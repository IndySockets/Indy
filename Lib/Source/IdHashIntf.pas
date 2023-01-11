unit IdHashIntf;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFIPS,
  IdGlobal, IdHash;

type
  TIdHashInt = class(TIdHash)
  protected
    function HashToHex(const AHash: TIdBytes): String; override;
    function GetHashInst : TIdHashInst; virtual; abstract;
    function InitHash : TIdHashIntCtx; virtual;
    procedure UpdateHash(ACtx : TIdHashIntCtx; const AIn : TIdBytes);
    function FinalHash(ACtx : TIdHashIntCtx) : TIdBytes;
    function GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes; override;
  public
    class function IsAvailable : Boolean; override;
  end;

  TIdHashSHA224 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  public
    class function IsAvailable : Boolean; override;
  end;

  TIdHashSHA256 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  public
    class function IsAvailable : Boolean; override;
  end;

  TIdHashSHA386 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  public
    class function IsAvailable : Boolean; override;
  end;

  TIdHashSHA512 = class(TIdHashInt)
  protected
    function GetHashInst : TIdHashInst; override;
  public
    class function IsAvailable : Boolean; override;
  end;

  EIdDigestError = class(EIdOpenSSLAPICryptoError);
  EIdDigestFinalEx = class(EIdDigestError);
  EIdDigestInitEx = class(EIdDigestError);
  EIdDigestUpdate = class(EIdDigestError);

implementation

uses
  IdCTypes;

{ TIdHashInt }

function TIdHashInt.FinalHash(ACtx: TIdHashIntCtx): TIdBytes;
var
  LLen, LRet : TIdC_UInt;
begin
  SetLength(Result,OPENSSL_EVP_MAX_MD_SIZE);
  LRet := IdSslEvpDigestFinalEx(@ACtx,@Result[0],LLen);
  if LRet <> 1 then begin
    EIdDigestFinalEx.RaiseException('EVP_DigestFinal_ex error');
  end;
  SetLength(Result,LLen);
  IdSslEvpMDCtxCleanup(@ACtx);
end;

function TIdHashInt.GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes;
var
  LBuf : TIdBytes;
  LSize : Int64;
  LCtx : TIdHashIntCtx;
begin
  LCtx := InitHash;
  try
    SetLength(LBuf,2048);
    repeat
      LSize := ReadTIdBytesFromStream(AStream,LBuf,2048);
      if LSize = 0 then begin
        Break;
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
var
  LHash : TIdHashInst;
  LRet : TIdC_Int;
begin
  LHash := GetHashInst;
  IdSslEvpMDCtxInit(@Result);
  LRet := IdSslEvpDigestInitEx(@Result, LHash, nil);
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException('EVP_DigestInit_ex error');
  end;
end;

class function TIdHashInt.IsAvailable: Boolean;
begin
   Result := Assigned(IdSslEvpDigestInitEx) and
             Assigned(IdSslEvpDigestUpdate) and
             Assigned(IdSslEvpDigestFinalEx);
end;

procedure TIdHashInt.UpdateHash(ACtx: TIdHashIntCtx; const AIn: TIdBytes);
var
  LRet : TIdC_Int;
begin
  LRet := IdSslEvpDigestUpdate(@ACtx,PByte(Ain),Length(AIn));
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException('EVP_DigestUpdate error');
  end;
end;

{ TIdHashSHA224 }

function TIdHashSHA224.GetHashInst: TIdHashInst;
begin
  Result := IdSslEvpSHA224;
end;

class function TIdHashSHA224.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA224) and inherited IsAvailable;
end;

{ TIdHashSHA256 }

function TIdHashSHA256.GetHashInst: TIdHashInst;
begin
  Result := IdSslEvpSHA256;
end;

class function TIdHashSHA256.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA256) and inherited IsAvailable;
end;

{ TIdHashSHA386 }

function TIdHashSHA386.GetHashInst: TIdHashInst;
begin
  Result := IdSslEvpSHA384;
end;

class function TIdHashSHA386.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA384) and inherited IsAvailable;
end;

{ TIdHashSHA512 }

function TIdHashSHA512.GetHashInst: TIdHashInst;
begin
  Result := IdSslEvpSHA512;
end;

class function TIdHashSHA512.IsAvailable: Boolean;
begin
  Result := Assigned(IdSslEvpSHA512) and inherited IsAvailable;
end;

end.
