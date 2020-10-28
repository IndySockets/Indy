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
    FDoNotCallShutdown: Boolean;
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
  public
    constructor Create(const AContext: PSSL_CTX);
    destructor Destroy; override;

    procedure Close;

    function Send(const ABuffer: TIdBytes; AOffset, ALength: Integer): Integer;
    function Receive(var ABuffer: TIdBytes): Integer;

    function HasReadableData: Boolean;
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

procedure TIdOpenSSLSocket.Close;
var
  LReturnCode: TIdC_INT;
  LSSLErrorCode: TIdC_INT;
begin
  if not FDoNotCallShutdown then
  begin
    LReturnCode := SSL_shutdown(FSSL);
    if LReturnCode < 0 then
    begin
      LSSLErrorCode := SSL_get_error(FSSL, LReturnCode);
      if LSSLErrorCode <> SSL_ERROR_ZERO_RETURN then
        EIdOpenSSLShutdownError.RaiseFmt(RIdOpenSSLShutdownError, [LSSLErrorCode]);
    end;
  end
  else
    SSL_set_shutdown(FSSL, SSL_SENT_SHUTDOWN or SSL_RECEIVED_SHUTDOWN);
end;

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

function TIdOpenSSLSocket.HasReadableData: Boolean;
begin
  Result := SSL_pending(FSSL) > 0;
end;

function TIdOpenSSLSocket.ShouldRetry(const ASSL: PSSL; var AReturnCode: Integer): Boolean;
begin
  Result := False;
  // Only negative values are errors, positiv values represent the amount of
  // bytes which are read/written
  if AReturnCode > 0 then
    Exit;

  case SSL_get_error(ASSL, AReturnCode) of
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
      FDoNotCallShutdown := True;
      Result := False;
    end;

    SSL_ERROR_SSL:
    // A non-recoverable, fatal error in the SSL library occurred, usually a
    // protocol error.
    begin
      FDoNotCallShutdown := True;
      Result := False;
    end
  else
    Result := False;
  end;
end;

function TIdOpenSSLSocket.Receive(var ABuffer: TIdBytes): Integer;
begin
  repeat
    Result := SSL_read(FSSL, PByte(ABuffer), Length(ABuffer));
    // Got a result, no need for reading more or retrying
    if Result > 0 then
      Exit;
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
  FDoNotCallShutdown := False;
end;

end.
