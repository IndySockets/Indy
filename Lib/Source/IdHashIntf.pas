unit IdHashIntf;

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFIPS,
  IdGlobal, IdHash,
  {$IFDEF DOTNET}
  System.Security.Cryptography,
  IdException
  {$ELSE}
  IdStreamVCL
  {$ENDIF}
  ;

type
  TIdHashInt = class(TIdHash)
  protected
    function HashToHex(const AHash: TIdBytes): String; override;
    function GetHashInst : TIdHashInst; virtual; abstract;
    function InitHash : TIdHashIntCtx; virtual;
    procedure UpdateHash(ACtx : TIdHashIntCtx; const AIn : TIdBytes);
    function FinalHash(ACtx : TIdHashIntCtx) : TIdBytes;
    function GetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes; override;
  {$IFNDEF DOTNET}
  public
    class function IsAvailable : Boolean; override;
  {$ENDIF}
  end;
  TIdHashSHA224 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  {$IFNDEF DOTNET}
  public
    class function IsAvailable : Boolean; override;
  {$ENDIF}
  end;
  TIdHashSHA256 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  {$IFNDEF DOTNET}
  public
    class function IsAvailable : Boolean; override;
  {$ENDIF}
  end;
  TIdHashSHA386 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  {$IFNDEF DOTNET}
  public
    class function IsAvailable : Boolean; override;
  {$ENDIF}
  end;
  TIdHashSHA512 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  {$IFNDEF DOTNET}
  public
    class function IsAvailable : Boolean; override;
  {$ENDIF}
  end;
  {$IFDEF DOTNET}
  EIdSecurityAPIException = class(EIdException);
  EIdSHA224NotSupported = class(EIdSecurityAPIException);
  {$ELSE}
  EIdDigestError = class(EIdOpenSSLAPICryptoError);
  EIdDigestFinalEx = class(EIdDigestError);
  EIdDigestInitEx = class(EIdDigestError);
  EIdDigestUpdate = class(EIdDigestError);
  {$ENDIF}

implementation
{$IFNDEF DOTNET}
uses IdCTypes;
{$ENDIF}

{ TIdHashInt }

function TIdHashInt.FinalHash(ACtx: TIdHashIntCtx): TIdBytes;
var
{$IFDEF DOTNET}
  LDummy : TIdBytes;
{$ELSE}
  LLen, LRet : TIdC_UInt;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  //This is a funny way of coding.  I have to pass a dummy value to
  //TransformFinalBlock so that things can work similarly to the OpenSSL
  //Crypto API.  You can't pass nul to TransformFinalBlock without an exception.
  SetLength(LDummy,0);
   ACtx.TransformFinalBlock(LDummy,0,0);
  Result := ACtx.Hash;
  {$ELSE}
  SetLength(Result,OPENSSL_EVP_MAX_MD_SIZE);
  LRet := IdSslEvpDigestFinalEx(@ACtx,@Result[0],LLen);
  if LRet <> 1 then begin
    EIdDigestFinalEx.RaiseException('EVP_DigestFinal_ex error');
  end;
  SetLength(Result,LLen);
  IdSslEvpMDCtxCleanup(@ACtx);
  {$ENDIF}
end;

function TIdHashInt.GetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes;
var LBuf : TIdBytes;
  LSize : Int64;
  LCtx : TIdHashIntCtx;
begin
  LCtx := InitHash;
  try
    SetLength(LBuf,2048);
    repeat
      LSize := ReadTIdBytesFromStream(AStream,LBuf,2048);
      if LSize = 0 then begin
        break;
      end;
      if LSize < 2048 then begin
        SetLength(LBuf,LSize);
        UpdateHash(LCtx,LBuf);
        break;
      end else begin
        UpdateHash(LCtx,LBuf);
      end;
    until False;
  finally
    Result := FinalHash(LCtx);
  end;
end;

function TIdHashInt.HashToHex(const AHash: TIdBytes): String;
begin
  Result := ToHex(AHash);
end;

function TIdHashInt.InitHash: TIdHashIntCtx;
 {$IFNDEF DOTNET}
var
  LHash : TIdHashInst;
  LRet : TIdC_Int;
  {$ENDIF}
begin
  {$IFDEF DOTNET}
   Result := GetHashInst;
  {$ELSE}
  LHash := GetHashInst;
  IdSslEvpMDCtxInit(@Result);
  LRet := IdSslEvpDigestInitEx(@Result, LHash, nil);
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException('EVP_DigestInit_ex error');
  end;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
class function TIdHashInt.IsAvailable: Boolean;
begin
   Result := Assigned(IdSslEvpDigestInitEx) and
             Assigned(IdSslEvpDigestUpdate) and
             Assigned(IdSslEvpDigestFinalEx);
end;
{$ENDIF}

procedure TIdHashInt.UpdateHash(ACtx: TIdHashIntCtx; const AIn: TIdBytes);
{$IFNDEF DOTNET}
var LRet : TIdC_Int;
{$ENDIF}
begin
   {$IFDEF DOTNET}
   ACtx.TransformBlock(AIn,0,Length(AIn),AIn,0);
   {$ELSE}
  LRet := IdSslEvpDigestUpdate(@ACtx,@Ain[0],Length(AIn));
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException('EVP_DigestUpdate error');
  end;
  {$ENDIF}
end;

{ TIdHashSHA224 }

function TIdHashSHA224.GetHashInst: TIdHashInst;
begin
  {$IFDEF DOTNET}
  Result := nil;
  Raise EIdSHA224NotSupported.Create('SHA224 not supported.');
  {$ELSE}
  Result := IdSslEvpSHA224;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
class function TIdHashSHA224.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA224) and inherited IsAvailable;
end;
{$ENDIF}

{ TIdHashSHA256 }

function TIdHashSHA256.GetHashInst: TIdHashInst;
begin
   {$IFDEF DOTNET}
   Result := System.Security.Cryptography.SHA256Managed.Create;
   {$ELSE}
  Result := IdSslEvpSHA256;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
class function TIdHashSHA256.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA256) and inherited IsAvailable;
end;
{$ENDIF}

{ TIdHashSHA386 }

function TIdHashSHA386.GetHashInst: TIdHashInst;
begin
  {$IFDEF DOTNET}
   Result := System.Security.Cryptography.SHA384Managed.Create;
  {$ELSE}
  Result := IdSslEvpSHA384;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
class function TIdHashSHA386.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA384) and inherited IsAvailable;
end;
{$ENDIF}

{ TIdHashSHA512 }

function TIdHashSHA512.GetHashInst: TIdHashInst;
begin
  {$IFDEF DOTNET}
   Result := System.Security.Cryptography.SHA512Managed.Create;
  {$ELSE}
  Result := IdSslEvpSHA512;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
class function TIdHashSHA512.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA512) and inherited IsAvailable;
end;
{$ENDIF}

end.
