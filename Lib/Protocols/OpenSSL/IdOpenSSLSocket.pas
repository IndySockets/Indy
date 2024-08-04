{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLSocket;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdOpenSSLHeaders_ossl_typ;

type
  TIdOpenSSLSocket = class(TObject)
  private
    FCallShutdown: Boolean;
    function HasShutdownBeenReceived(const ASSL: PSSL): Boolean;
    function HasShutdownBeenSent(const ASSL: PSSL): Boolean;
  protected
    FSSL: PSSL;
    FContext: PSSL_CTX;
    function StartSSL(const AContext: PSSL_CTX): PSSL;
    /// <summary>
    ///   Checks if the return code is a recoverable error which means we should
    ///   do the same action again, for example because of a renegotiation
    /// </summary>
    /// <param name="ASSL">
    ///   Pointer to the PSSL
    /// </param>
    /// <param name="AReturnCode">
    ///   The result of the before called api, will be zero'ed only if the
    ///   connection is closed from the peer
    /// </param>
    function ShouldRetry(const ASSL: PSSL; var AReturnCode: Integer): Boolean;
    function GetErrorCode(const ASSL: PSSL; const AReturnCode: Integer): Integer; overload;
  public
    constructor Create(const AContext: PSSL_CTX);
    destructor Destroy; override;

    /// <summary>
    ///   Closes the TLS (but not the TCP) connection with a shutdown (close_notify alert)
    /// </summary>
    /// <param name="AUseBidirectionalShutdown">
    ///   Determines whether to wait for the close_notify of the peer.
    ///   The wait could trigger ReadTimeouts.
    /// </param>
    /// <remarks>
    ///   See RFC 5246 Section 7.2.1 for more information
    ///   (for example https://www.rfc-editor.org/rfc/rfc5246#section-7.2.1). If the application
    ///   protocol will not transfer any additional data, but will only close the underlying
    ///   transport connection, then the implementation MAY choose to close the transport without
    ///   waiting for the responding close_notify.
    /// </remarks>
    procedure Shutdown(const AUseBidirectionalShutdown: Boolean);

    function Send(const ABuffer: TIdBytes; AOffset, ALength: Integer): Integer;
    function Receive(var ABuffer: TIdBytes): Integer;

    function HasReadableData: Boolean;

    function GetErrorCode(const AReturnCode: Integer): Integer; overload;
  end;

implementation

uses
  IdCTypes,
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_err,
  IdOpenSSLHeaders_ssl,
  SysUtils;

{ TIdOpenSSLSocket }

constructor TIdOpenSSLSocket.Create(const AContext: PSSL_CTX);
begin
  inherited Create;
  FContext := AContext;
end;

destructor TIdOpenSSLSocket.Destroy;
begin
  SSL_free(FSSL); // nil-safe
  FSSL := nil;
  inherited;
end;

function TIdOpenSSLSocket.GetErrorCode(const AReturnCode: Integer): Integer;
begin
  Result := GetErrorCode(FSSL, AReturnCode);
end;

function TIdOpenSSLSocket.GetErrorCode(const ASSL: PSSL; const AReturnCode: Integer): Integer;
begin
  Result := SSL_get_error(ASSL, AReturnCode);
end;

function TIdOpenSSLSocket.HasReadableData: Boolean;
begin
  Result := SSL_pending(FSSL) > 0;
end;

function TIdOpenSSLSocket.HasShutdownBeenReceived(const ASSL: PSSL): Boolean;
var
  LShutdownMask: TIdC_INT;
begin
  LShutdownMask := SSL_get_shutdown(ASSL);
  Result := (LShutdownMask and SSL_RECEIVED_SHUTDOWN) <> 0;
end;

function TIdOpenSSLSocket.HasShutdownBeenSent(const ASSL: PSSL): Boolean;
var
  LShutdownMask: TIdC_INT;
begin
  LShutdownMask := SSL_get_shutdown(ASSL);
  Result := (LShutdownMask and SSL_SENT_SHUTDOWN) <> 0;
end;

function TIdOpenSSLSocket.ShouldRetry(const ASSL: PSSL; var AReturnCode: Integer): Boolean;
begin
  Result := False;
  // Only negative values are errors, positiv values represent the amount of
  // bytes which are read/written
  if AReturnCode > 0 then
    Exit;

  case GetErrorCode(ASSL, AReturnCode) of
    SSL_ERROR_NONE:
    // The TLS/SSL I/O operation completed. This result code is returned if and
    // only if AReturnCode > 0
    // No reason for a retry
      Result := False;

    // Even write operation could trigger read operations, for example
    // because of an automatic executed renegotiation
    SSL_ERROR_WANT_READ, SSL_ERROR_WANT_WRITE:
    // The operation did not complete and can be retried later.
      Result := True;

    SSL_ERROR_WANT_CONNECT, SSL_ERROR_WANT_ACCEPT:
    // The operation did not complete; the same TLS/SSL I/O function should
    // be called again later.
      Result := True;

    SSL_ERROR_ZERO_RETURN:
    // The TLS/SSL peer has closed the connection for writing by sending the
    // close_notify alert. No more data can be read.
    begin
      Result := False;
      AReturnCode := 0;
    end;

    SSL_ERROR_SYSCALL:
    // Some non-recoverable, fatal I/O error occurred.
    begin
      FCallShutdown := False;
      Result := False;
    end;

    SSL_ERROR_SSL:
    // A non-recoverable, fatal error in the SSL library occurred, usually a
    // protocol error.
    begin
      FCallShutdown := False;
      Result := False;
    end
  else
    Result := False;
  end;
end;

procedure TIdOpenSSLSocket.Shutdown(const AUseBidirectionalShutdown: Boolean);
var
  LReturnCode: TIdC_INT;
  LSSLErrorCode: TIdC_INT;
  LBuffer: array[0 .. 1023] of Byte;
  LReadBytes: TIdC_SizeT;
begin
  if FCallShutdown and not HasShutdownBeenSent(FSSL) then
  begin
    // Maybe the server has already sent a close notify alert. Or maybe we haven't received a
    // New Session Ticket event yet.
    // Read it to avoid a RST on the TCP connection
    // See https://github.com/openssl/openssl/issues/7948 for more information, really you should
    // read that discussion
    // Same solution as used in https://github.com/curl/curl/issues/6149
//    SSL_read(FSSL, @LBuffer[0], Length(LBuffer));

    LReturnCode := SSL_shutdown(FSSL);
    case LReturnCode of
      // The shutdown was successfully completed. The close_notify alert was sent and the peer's
      // close_notify alert was received.
      1: ;

      // The shutdown is not yet finished: the close_notify was sent but the peer did not send it
      // back yet. Call SSL_read() to do a bidirectional shutdown.
      // Unlike most other functions, returning 0 does not indicate an error. SSL_get_error should
      // not get called, it may misleadingly indicate an error even though no error occurred.
      0:
      begin
        if AUseBidirectionalShutdown then
        begin
          LReadBytes := 0;
          // Continue reading until the close_notify is received
          while not HasShutdownBeenReceived(FSSL) do
            if SSL_read_ex(FSSL, @LBuffer[0], Length(LBuffer), @LReadBytes) = 0 then
              Break;
        end;
      end;
    else
      LSSLErrorCode := SSL_get_error(FSSL, LReturnCode);
      if LSSLErrorCode <> SSL_ERROR_ZERO_RETURN then
        raise EIdOpenSSLShutdownError.Create(FSSL, LReturnCode, RIdOpenSSLShutdownError);
    end;
  end
  else
    SSL_set_shutdown(FSSL, SSL_SENT_SHUTDOWN or SSL_RECEIVED_SHUTDOWN);
end;

function TIdOpenSSLSocket.Receive(var ABuffer: TIdBytes): Integer;
begin
  repeat
    Result := SSL_read(FSSL, PByte(ABuffer), Length(ABuffer));
    // Got a result, no need for reading more or retrying
    if Result > 0 then
    begin
      SetLength(ABuffer, Result);
      Exit;
    end;
  until not ShouldRetry(FSSL, Result);
end;

function TIdOpenSSLSocket.Send(const ABuffer: TIdBytes; AOffset, ALength: Integer): Integer;
var
  LBytesWritten: Integer;
begin
  Result := 0;
  while Result < ALength do
  begin
    LBytesWritten := SSL_write(FSSL, @ABuffer[AOffset], ALength);
    if LBytesWritten > 0 then
    begin
      Inc(AOffset, LBytesWritten);
      Dec(ALength, LBytesWritten);
      Inc(Result, LBytesWritten);
    end
    else
    begin
      if not ShouldRetry(FSSL, LBytesWritten) then
      begin
        Result := LBytesWritten;
        Exit;
      end;
    end;
  end;
end;

function TIdOpenSSLSocket.StartSSL(const AContext: PSSL_CTX): PSSL;
begin
  Result := SSL_new(AContext);
  if not Assigned(Result) then
    EIdOpenSSLNewSSLError.Raise_(RIdOpenSSLNewSSLError);
  FCallShutdown := True;
end;

end.
