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
unit IdSSLOpenSSLExceptionHandlers;

{$I IdCompilerDefines.inc}
{$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}


interface

uses
  Classes, SysUtils, IdException, IdCTypes;

type
//moved from IdSSLOpenSSL so we can use these classes in other places
  EIdOpenSSLError               = class(EIdException);
  TIdOpenSSLAPISSLError = class of EIdOpenSSLAPISSLError;

  EIdOpenSSLAPISSLError = class(EIdOpenSSLError)
  protected
    FErrorCode : TIdC_INT;
    FRetCode : TIdC_INT;
  public
    class procedure RaiseException(ASSL: Pointer; const ARetCode : TIdC_INT; const AMsg : String = '');
    class procedure RaiseExceptionCode(const AErrCode, ARetCode : TIdC_INT; const AMsg : String = '');
    property ErrorCode : TIdC_INT read FErrorCode;
    property RetCode : TIdC_INT read FRetCode;
  end;

  TIdSSLOpenSSLAPICryptoError = class of EIdOpenSSLAPICryptoError;
  EIdOpenSSLAPICryptoError = class(EIdOpenSSLError)
  protected
    FErrorCode : TIdC_ULONG;
  public
    class procedure RaiseExceptionCode(const AErrCode : TIdC_ULONG; const AMsg : String = '');
    class procedure RaiseException(const AMsg : String = '');
    property ErrorCode : TIdC_ULONG read FErrorCode;
  end;
  EIdOSSLUnderlyingCryptoError = class(EIdOpenSSLAPICryptoError);

  EIdDigestError = class(EIdOpenSSLAPICryptoError);
  EIdDigestFinalEx = class(EIdDigestError);
  EIdDigestInitEx = class(EIdDigestError);
  EIdDigestUpdate = class(EIdDigestError);

  { EIdAPIFunctionNotPresent }

  EIdAPIFunctionNotPresent = class(EIdOpenSSLError)
  public
    class procedure RaiseException(functionName: string);
  end;

implementation

uses IdOpenSSLHeaders_err, IdGlobal, IdOpenSSLHeaders_ssl,
  IdOpenSSLHeaders_ossl_typ, IdResourceStringsProtocols,
  IdStack, IdResourceStringsOpenSSL;

function GetErrorMessage(const AErr : TIdC_ULONG) : String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
const
  sMaxErrMsg = 160;
var
  LErrMsg: array [0..sMaxErrMsg] of TIdAnsiChar;
  {$IFDEF USE_MARSHALLED_PTRS}
  LErrMsgPtr: TPtrWrapper;
  {$ENDIF}
begin
  {$IFDEF USE_MARSHALLED_PTRS}
  LErrMsgPtr := TPtrWrapper.Create(@LErrMsg[0]);
  {$ENDIF}
  ERR_error_string_n(AErr,
    {$IFDEF USE_MARSHALLED_PTRS}
    LErrMsgPtr.ToPointer
    {$ELSE}
    LErrMsg
    {$ENDIF}, sMaxErrMsg);
  LErrMsg[sMaxErrMsg] := TIdAnsiChar(0);
  {$IFDEF USE_MARSHALLED_PTRS}
  Result := TMarshal.ReadStringAsAnsi(LErrMsgPtr);
  {$ELSE}
  Result := String(LErrMsg);
  {$ENDIF}
end;

{ EIdAPIFunctionNotPresent }

class procedure EIdAPIFunctionNotPresent.RaiseException(functionName: string);
begin
  raise EIdAPIFunctionNotPresent.CreateFmt(ROSSLAPIFunctionNotPresent,[functionName]);
end;

{ EIdOpenSSLAPICryptoError }
class procedure EIdOpenSSLAPICryptoError.RaiseException(const AMsg : String = '');
begin
  RaiseExceptionCode(ERR_get_error(), AMsg);
end;

class procedure EIdOpenSSLAPICryptoError.RaiseExceptionCode(
  const AErrCode: TIdC_ULONG; const AMsg: String);
var
  LMsg: String;
  LException : EIdOpenSSLAPICryptoError;
begin
  if AMsg <> '' then begin
    LMsg := AMsg + sLineBreak + String(GetErrorMessage(AErrCode));
  end else begin
    LMsg := String(GetErrorMessage(AErrCode));
  end;
  LException := Create(LMsg);
  LException.FErrorCode := AErrCode;
  raise LException;
end;

{ EIdOpenSSLAPISSLError }

class procedure EIdOpenSSLAPISSLError.RaiseException(ASSL: Pointer; const ARetCode: TIdC_INT;
  const AMsg: String);
begin
  RaiseExceptionCode(SSL_get_error(PSSL(ASSL), ARetCode), ARetCode, AMsg);
end;

class procedure EIdOpenSSLAPISSLError.RaiseExceptionCode(const AErrCode, ARetCode: TIdC_INT;
  const AMsg: String);
var
  LErrQueue : TIdC_ULONG;
  LException : EIdOpenSSLAPISSLError;
  LErrStr : String;
begin
  if AMsg <> '' then begin
    LErrStr := AMsg + sLineBreak;
  end else begin
    LErrStr := '';
  end;
  case AErrCode of
    SSL_ERROR_SYSCALL :
    begin
      LErrQueue := ERR_get_error;
      if LErrQueue <> 0 then begin
        EIdOSSLUnderlyingCryptoError.RaiseExceptionCode(LErrQueue, AMsg);
      end;
      if ARetCode = 0 then begin
        LException := Create(LErrStr + RSSSLEOFViolation);
        LException.FErrorCode := AErrCode;
        LException.FRetCode := ARetCode;
        raise LException;
      end;
      {Note that if LErrQueue returns 0 and ARetCode = -1, there probably
      is an error in the underlying socket so you should raise a socket error}
      if ARetCode = -1 then begin
        // TODO: catch the socket exception and re-raise it as the InnerException
        // for an EIdOpenSSLAPISSLError exception...
        GStack.RaiseLastSocketError;
      end;
    end;
    SSL_ERROR_SSL : begin
      EIdOSSLUnderlyingCryptoError.RaiseException(AMsg);
    end
  end;
  // everything else...
  LException := Create(LErrStr + String(GetErrorMessage(AErrCode)));
  LException.FErrorCode := AErrCode;
  LException.FRetCode := ARetCode;
  raise LException;
end;

end.

