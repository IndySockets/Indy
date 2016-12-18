unit IdFIPS;

interface

{$I IdCompilerDefines.inc}

{
  IMPORTANT!!!

  This unit does not directly provide FIPS support.  It centalizes some Indy
  encryption functions and exposes a function to get and set a FIPS mode that is
  implemented by the library that hooks this unit.

  The idea is that Indy will not have a FIPS certification per se but will be
  able to utilize cryptographic modules that are FIPS complient.

  In addition, this unit provides a way of centralizing all hashing and HMAC
  functions and to control dependancies in Indy.
}
uses
  IdException, IdGlobal
  {$IFDEF DOTNET}
  , System.Security.Cryptography
  {$ENDIF}
  ;

type
{$IFDEF DOTNET}
  TIdHashIntCtx = System.Security.Cryptography.HashAlgorithm;
  TIdHMACIntCtx = System.Security.Cryptography.HMAC;
{$ELSE}
  TIdHashIntCtx = Pointer;
  TIdHMACIntCtx = Pointer;
{$ENDIF}

  EIdFIPSAlgorithmNotAllowed = class(EIdException);
  TGetFIPSMode = function: Boolean;
  TSetFIPSMode = function(const AMode: Boolean): Boolean;
  TIsHashingIntfAvail = function: Boolean;
  TGetHashInst = function: TIdHashIntCtx;
  TUpdateHashInst = procedure(ACtx: TIdHashIntCtx; const AIn: TIdBytes);
  TFinalHashInst = function(ACtx: TIdHashIntCtx): TIdBytes;
  TIsHMACAvail = function : Boolean;
  TIsHMACIntfAvail = function : Boolean;
  TGetHMACInst = function (const AKey : TIdBytes) : TIdHMACIntCtx;
  TUpdateHMACInst = procedure(ACtx : TIdHMACIntCtx; const AIn: TIdBytes);
  TFinalHMACInst = function(ACtx: TIdHMACIntCtx): TIdBytes;

var
  GetFIPSMode: TGetFIPSMode;
  SetFIPSMode: TSetFIPSMode;
  IsHashingIntfAvail: TIsHashingIntfAvail;
  GetMD2HashInst: TGetHashInst;
  IsMD2HashIntfAvail: TIsHashingIntfAvail;
  GetMD4HashInst: TGetHashInst;
  IsMD4HashIntfAvail: TIsHashingIntfAvail;
  GetMD5HashInst: TGetHashInst;
  IsMD5HashIntfAvail: TIsHashingIntfAvail;
  GetSHA1HashInst: TGetHashInst;
  IsSHA1HashIntfAvail: TIsHashingIntfAvail;
  GetSHA224HashInst: TGetHashInst;
  IsSHA224HashIntfAvail: TIsHashingIntfAvail;
  GetSHA256HashInst: TGetHashInst;
  IsSHA256HashIntfAvail: TIsHashingIntfAvail;
  GetSHA384HashInst: TGetHashInst;
  IsSHA384HashIntfAvail: TIsHashingIntfAvail;
  GetSHA512HashInst: TGetHashInst;
  IsSHA512HashIntfAvail: TIsHashingIntfAvail;
  UpdateHashInst: TUpdateHashInst;
  FinalHashInst: TFinalHashInst;
  IsHMACAvail : TIsHMACAvail;
  IsHMACMD5Avail : TIsHMACIntfAvail;
  GetHMACMD5HashInst: TGetHMACInst;
  IsHMACSHA1Avail  : TIsHMACIntfAvail;
  GetHMACSHA1HashInst: TGetHMACInst;
  IsHMACSHA224Avail : TIsHMACIntfAvail;
  GetHMACSHA224HashInst: TGetHMACInst;
  IsHMACSHA256Avail : TIsHMACIntfAvail;
  GetHMACSHA256HashInst: TGetHMACInst;
  IsHMACSHA384Avail : TIsHMACIntfAvail;
  GetHMACSHA384HashInst: TGetHMACInst;
  IsHMACSHA512Avail : TIsHMACIntfAvail;
  GetHMACSHA512HashInst: TGetHMACInst;
  UpdateHMACInst : TUpdateHMACInst;
  FinalHMACInst : TFinalHMACInst;

  procedure CheckMD2Permitted;
  procedure CheckMD4Permitted;
  procedure CheckMD5Permitted;
  procedure FIPSAlgorithmNotAllowed(const AAlgorithm: String);

implementation

uses
  IdResourceStringsProtocols, SysUtils;

// TODO: for .NET, implement functions that use .NET Hash/HMAC classes

procedure CheckMD2Permitted; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if GetFIPSMode then begin
    FIPSAlgorithmNotAllowed('MD2');
  end;
end;

procedure CheckMD4Permitted; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if GetFIPSMode then begin
    FIPSAlgorithmNotAllowed('MD4');
  end;
end;

procedure CheckMD5Permitted; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if GetFIPSMode then begin
    FIPSAlgorithmNotAllowed('MD5');
  end;
end;

procedure FIPSAlgorithmNotAllowed(const AAlgorithm: String);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  raise EIdFIPSAlgorithmNotAllowed.CreateFmt(RSFIPSAlgorithmNotAllowed, [AAlgorithm]);
end;

// fips mode default procs
function DefGetFIPSMode: Boolean;
begin
  Result := False;
end;

function DefSetFIPSMode(const AMode: Boolean): Boolean;
begin
  // leave this empty as we may not be using something that supports FIPS
  Result := False;
end;

function DefIsHashingIntfAvail: Boolean;
begin
  Result := False;
end;

function DefIsHashIntfAvail: Boolean;
begin
  Result := False;
end;

function DefGetHashInst : TIdHashIntCtx;
begin
  Result := nil;
end;

procedure DefUpdateHashInst(ACtx: TIdHashIntCtx; const AIn: TIdBytes);
begin
end;

function DefFinalHashInst(ACtx: TIdHashIntCtx): TIdBytes;
begin
  SetLength(Result, 0);
end;

function DefIsHMACAvail : Boolean;
begin
  Result := False;
end;

function DefIsHMACIntfAvail: Boolean;
begin
  Result := False;
end;

function DefGetHMACInst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  Result := nil;
end;

procedure DefUpdateHMACInst(ACtx : TIdHMACIntCtx; const AIn: TIdBytes);
begin
end;

function DefFinalHMACInst(ACtx: TIdHMACIntCtx): TIdBytes;
begin
  SetLength(Result, 0);
end;

initialization

  GetFIPSMode := DefGetFIPSMode;
  SetFIPSMode := DefSetFIPSMode;

  IsHashingIntfAvail := DefIsHashingIntfAvail;

  IsMD2HashIntfAvail := DefIsHashIntfAvail;
  GetMD2HashInst := DefGetHashInst;
  IsMD4HashIntfAvail := DefIsHashIntfAvail;
  GetMD4HashInst := DefGetHashInst;
  IsMD5HashIntfAvail := DefIsHashIntfAvail;
  GetMD5HashInst := DefGetHashInst;
  IsSHA1HashIntfAvail := DefIsHashIntfAvail;
  GetSHA1HashInst := DefGetHashInst;
  IsSHA224HashIntfAvail := DefIsHashIntfAvail;
  GetSHA224HashInst := DefGetHashInst;

  IsSHA256HashIntfAvail := DefIsHashIntfAvail;
  GetSHA256HashInst := DefGetHashInst;
  IsSHA384HashIntfAvail := DefIsHashIntfAvail;
  GetSHA384HashInst := DefGetHashInst;
  IsSHA512HashIntfAvail := DefIsHashIntfAvail;
  GetSHA512HashInst := DefGetHashInst;
  UpdateHashInst := DefUpdateHashInst;
  FinalHashInst := DefFinalHashInst;
  IsHMACAvail := DefIsHMACAvail;
  IsHMACMD5Avail := DefIsHMACIntfAvail;
  GetHMACMD5HashInst := DefGetHMACInst;
  IsHMACSHA1Avail  := DefIsHMACIntfAvail;
  GetHMACSHA1HashInst := DefGetHMACInst;
  IsHMACSHA224Avail  := DefIsHMACIntfAvail;
  GetHMACSHA224HashInst := DefGetHMACInst;
  IsHMACSHA256Avail  :=  DefIsHMACIntfAvail;
  GetHMACSHA256HashInst := DefGetHMACInst;
  IsHMACSHA384Avail  := DefIsHMACIntfAvail;
  GetHMACSHA384HashInst := DefGetHMACInst;
  IsHMACSHA512Avail  := DefIsHMACIntfAvail;
  GetHMACSHA512HashInst := DefGetHMACInst;

  UpdateHMACInst := DefUpdateHMACInst;
  FinalHMACInst := DefFinalHMACInst;

end.
