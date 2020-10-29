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

unit IdOpenSSLExceptions;

interface

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdException,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_ssl;

type
  EIdOpenSSLBaseError = class(EIdException)
  public
    class procedure Raise_; overload;
    class procedure Raise_(const AMsg: string); overload;
    class procedure RaiseFmt(const AMsg: string; const Args: array of const);
  end;

  EIdOpenSSLLoadError = class(EIdOpenSSLBaseError);

  EIdOpenSSLSetExDataError = class(EIdOpenSSLBaseError);
  EIdOpenSSLGetExDataError = class(EIdOpenSSLBaseError);
  EIdOpenSSLSetCipherListError = class(EIdOpenSSLBaseError);
  EIdOpenSSLSetCipherSuiteError = class(EIdOpenSSLBaseError);
  EIdOpenSSLSetClientCAError = class(EIdOpenSSLBaseError);
  EIdOpenSSLSetSNIServerNameError = class(EIdOpenSSLBaseError);

  /// <summary>
  ///   Base class for errors that are based on the error stack in err.h
  /// </summary>
  EIdOpenSSLErrorStackBasedError = class(EIdOpenSSLBaseError)
  private
    FErrorCode: TIdC_INT;
    FErrorText: string;
    FExtractedReason: string;
    FInnerMessage: string;
    /// <summary>
    ///   Generates a human-readable string representing the error code
    /// </summary>
    /// <returns>
    ///   The Result string will have the following format:
    ///   <code>error:[error code]:[library name]:[function name]:[reason string]</code>
    /// </returns>
    class function GetErrorText(const AErrorCode: TIdC_INT): string;
    class function GetErrorReason(const AErrorText: string): string;
    function GetErrorCodeInHex: string;
  public
    constructor Create; overload;
    constructor Create(const AMsg: string); overload; override;
    constructor Create(const AMsg: string; const AErrorCode: TIdC_INT); overload;

    /// <returns>
    ///   Contains a human-readable string representing the error code
    /// </returns>
    /// <remarks>
    ///   The Result string will have the following format:
    ///   <code>error:[error code]:[library name]:[function name]:[reason string]</code>
    /// </remarks>
    property ErrorText: string read FErrorText;

    /// <returns>
    ///   Returns the error code in decimal numbers (useful for case statements)
    /// </returns>
    /// <remarks>
    ///   The hexadecimal representation will be contained as "error code" in <see cref="ErrorText"/>
    /// </remarks>
    property ErrorCodeInDec: TIdC_INT read FErrorCode;
    /// <returns>
    ///   Returns the error code in hexadecimal
    /// </returns>
    /// <remarks>
    ///   This will be contained as "error code" in <see cref="ErrorText"/>
    /// </remarks>
    property ErrorCodeInHex: string read GetErrorCodeInHex;

    /// <returns>
    ///   Returns a human-readable reason of the failure
    /// </returns>
    /// <remarks>
    ///   This will be contained as "reason string" in <see cref="ErrorText"/>
    /// </remarks>
    property ErrorReason: string read FExtractedReason;
  end;

  EIdOpenSSLNewSSLCtxError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLNewSSLError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLSetVerifyLocationError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLSetCertificateError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLSetPrivateKeyError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLCertAndPrivKeyMisMatchError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLSessionIdContextError = class(EIdOpenSSLErrorStackBasedError);
  EIdOpenSSLSetSessionError = class(EIdOpenSSLErrorStackBasedError);

  /// <summary>
  ///   Base class for errors that are based on the ssl error return codes
  /// </summary>
  EIdOpenSSLSSLBasedError = class(EIdOpenSSLErrorStackBasedError)
  private
    FErrorCode: TIdC_INT;
    FReturnCode: TIdC_INT;
  public
    constructor Create(const ASSL: PSSL; const AReturnCode: TIdC_INT; const AMsg: string);
  end;

  EIdOpenSSLConnectError = class(EIdOpenSSLSSLBasedError);
  EIdOpenSSLAcceptError = class(EIdOpenSSLSSLBasedError);
  EIdOpenSSLShutdownError = class(EIdOpenSSLSSLBasedError);

implementation

uses
  IdGlobal,
  IdOpenSSLHeaders_err,
  StrUtils,
  SysUtils,
  {$IFDEF VCL_XE3_OR_ABOVE}System.Types{$ELSE}Types{$ENDIF};

const
  CIndexOfReason = 4;

{ EIdOpenSSLBaseError }

class procedure EIdOpenSSLBaseError.Raise_;
begin
  {$IFDEF VCL_XE4_OR_ABOVE}
    raise Self.Create('') at
    {$IFNDEF FPC}
    ReturnAddress
    {$ELSE}
    get_caller_addr(get_frame), get_caller_frame(get_frame)
    {$ENDIF}
    ;
  {$ELSE}
    IndyRaiseOuterException(Self.Create(''));
  {$ENDIF}
end;

class procedure EIdOpenSSLBaseError.Raise_(const AMsg: string);
begin
  {$IFDEF VCL_XE4_OR_ABOVE}
    raise Self.Create(AMsg) at
    {$IFNDEF FPC}
    ReturnAddress
    {$ELSE}
    get_caller_addr(get_frame), get_caller_frame(get_frame)
    {$ENDIF}
    ;
  {$ELSE}
    IndyRaiseOuterException(Self.Create(AMsg));
  {$ENDIF}
end;

class procedure EIdOpenSSLBaseError.RaiseFmt(const AMsg: string; const Args: array of const);
begin
  {$IFDEF VCL_XE4_OR_ABOVE}
    raise Self.CreateFmt(AMsg, Args) at
    {$IFNDEF FPC}
    ReturnAddress
    {$ELSE}
    get_caller_addr(get_frame), get_caller_frame(get_frame)
    {$ENDIF}
    ;
  {$ELSE}
    IndyRaiseOuterException(Self.Create(Format(AMsg, Args)));
  {$ENDIF}
end;

{ EIdOpenSSLBaseErrorStackError }

constructor EIdOpenSSLErrorStackBasedError.Create;
begin
  Create('');
end;

constructor EIdOpenSSLErrorStackBasedError.Create(const AMsg: string);
begin
  Create(AMsg, ERR_get_error());
end;

constructor EIdOpenSSLErrorStackBasedError.Create(const AMsg: string;
  const AErrorCode: TIdC_INT);

  function InternalGetMessage(const AMsg: string): string;
  begin
    Result := AMsg;
    if (Result <> '') and (FErrorText <> '') then
      Result := Result + sLineBreak;
    if FErrorText <> '' then
      Result := AMsg + FErrorText;
  end;

begin
  FInnerMessage := AMsg;
  FErrorCode := AErrorCode;
  FErrorText := GetErrorText(FErrorCode);
  FExtractedReason := GetErrorReason(FErrorText);

  inherited Create(InternalGetMessage(FInnerMessage));
end;

function EIdOpenSSLErrorStackBasedError.GetErrorCodeInHex: string;
begin
  Result := IntToHex(FErrorCode, 0);
end;

class function EIdOpenSSLErrorStackBasedError.GetErrorReason(
  const AErrorText: string): string;

{$IFNDEF VCL_XE4_OR_ABOVE}
// D2007 does not have SplitString
  function SplitString(const s, Delimiters: string): TStringDynArray;
  var
    i: integer;
    Len: integer;
    PosStart: integer;
    PosDel: integer;
    TempText:string;
  begin
    i := 0;
    SetLength(Result, 1);
    Len := Length(Delimiters);
    PosStart := 1;
    PosDel := Pos(Delimiters, s);
    TempText := s;
    while PosDel > 0 do
      begin
        Result[i] := Copy(TempText, PosStart, PosDel - PosStart);
        PosStart := PosDel + Len;
        TempText := Copy(TempText, PosStart, Length(TempText));
        PosDel := Pos(Delimiters, TempText);
        PosStart := 1;
        Inc(i);
        SetLength(Result, i + 1);
      end;
    Result[i] := Copy(TempText, PosStart, Length(TempText));
  end;
{$ENDIF}

var
  LError: TStringDynArray;
begin
  Result := '';
  if AErrorText = '' then
    Exit;

  LError := SplitString(AErrorText, ':');
  if Length(LError) < CIndexOfReason then
    Exit;
  Result := LError[CIndexOfReason];
end;

class function EIdOpenSSLErrorStackBasedError.GetErrorText(
  const AErrorCode: TIdC_INT): string;
begin
  Result := '';
  if AErrorCode <> 0 then
    Result := string(AnsiString(ERR_error_string(AErrorCode, nil)));
end;

{ EIdOpenSSLSSLBasedError }

constructor EIdOpenSSLSSLBasedError.Create(
  const ASSL: PSSL;
  const AReturnCode: TIdC_INT;
  const AMsg: string);
begin
  FReturnCode := AReturnCode;
  FErrorCode := SSL_get_error(ASSL, AReturnCode);
  case FErrorCode of
    SSL_ERROR_SYSCALL:
      // ERR_get_error() *may* contains more information
      inherited Create(AMsg, ERR_get_error());
    SSL_ERROR_SSL:
      // ERR_get_error() contains for sure more information
      inherited Create(AMsg, ERR_get_error());
  else
    inherited Create(AMsg, 0);
  end;
end;

end.
