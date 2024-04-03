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
{   (c) 1993-2024, the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}
unit IdSSLOpenSSLFIPS;

{$i IdCompilerDefines.inc}
{$i IdSSLOpenSSLDefines.inc}
{$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}

interface

uses
  Classes;

implementation

uses
  IdException,
  IdGlobal,
  IdCTypes,
  IdFIPS,
  IdSSLOpenSSLExceptionHandlers,
  IdResourceStringsOpenSSL,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_crypto,
  IdOpenSSLHeaders_hmac,
  IdOpenSSLHeaders_ossl_typ;

function FIPS_mode_set(onoff : TIdC_INT) : TIdC_INT;  {$IFDEF INLINE}inline;{$ENDIF}
begin
  Result := 0;
  {$IFDEF OPENSSL_FIPS}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  if Assigned(IdOpenSSLHeaders_crypto.FIPS_mode_set) then
  {$ENDIF}
  begin
    Result := IdOpenSSLHeaders_crypto.FIPS_mode_set(onoff);
  end;
  {$ENDIF}
end;

function FIPS_mode() : TIdC_INT;  {$IFDEF INLINE}inline;{$ENDIF}
begin
  Result := 0;
  {$IFDEF OPENSSL_FIPS}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  if Assigned(IdOpenSSLHeaders_crypto.FIPS_mode) then
  {$ENDIF}
  begin
    Result := IdOpenSSLHeaders_crypto.FIPS_mode;
  end;
  {$ENDIF}
end;

//**************** FIPS Support backend *******************

function OpenSSLIsHashingIntfAvail : Boolean;
begin
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_DigestInit_ex) and
            Assigned(EVP_DigestUpdate) and
            Assigned(EVP_DigestFinal_ex) ;
  {$ELSE}
  Result := true;
  {$ENDIF}
end;

function OpenSSLGetFIPSMode : Boolean;
begin
  Result := FIPS_mode <> 0;
end;

function OpenSSLSetFIPSMode(const AMode : Boolean) : Boolean;
begin
  //leave this empty as we may not be using something that supports FIPS
  if AMode then begin
    Result := FIPS_mode_set(1) = 1;
  end else begin
    Result := FIPS_mode_set(0) = 1;
  end;
end;

function OpenSSLGetDigestCtx( AInst : PEVP_MD) : TIdHashIntCtx;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
var LRet : Integer;
begin
  Result := EVP_MD_CTX_new;

  LRet := EVP_DigestInit_ex(Result, AInst, nil);
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException(RSOSSLEVPDigestExError);
  end;
end;

function OpenSSLIsMD2HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_MD2}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_md2);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetMD2HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_MD2}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_MD2}
  Result := nil;
  {$ELSE}
  LRet := EVP_md2;
  Result := OpenSSLGetDigestCtx(LRet);
  {$ENDIF}
end;

function OpenSSLIsMD4HashIntfAvail: Boolean;
begin
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_md4);
  {$ELSE}
  Result := true;
  {$ENDIF}
end;

function OpenSSLGetMD4HashInst : TIdHashIntCtx;
var
  LRet : PEVP_MD;
begin
  LRet := EVP_md4;
  Result := OpenSSLGetDigestCtx(LRet);
end;

function OpenSSLIsMD5HashIntfAvail: Boolean;
begin
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_md5);
  {$ELSE}
  Result := true;
  {$ENDIF}
end;

function OpenSSLGetMD5HashInst : TIdHashIntCtx;
var
  LRet : PEVP_MD;
begin
  LRet := EVP_md5;
  Result := OpenSSLGetDigestCtx(LRet);
end;

function OpenSSLIsSHA1HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha1);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetSHA1HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_SHA}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_SHA}
  Result := nil;
  {$ELSE}
  LRet := EVP_sha1;
  Result := OpenSSLGetDigestCtx(LRet);
  {$ENDIF}
end;

function OpenSSLIsSHA224HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha224);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetSHA224HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_SHA256}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := nil;
  {$ELSE}
  LRet := EVP_sha224;
  Result := OpenSSLGetDigestCtx(LRet);
  {$ENDIF}
end;

function OpenSSLIsSHA256HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha256);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetSHA256HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_SHA256}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := nil;
  {$ELSE}
  LRet := EVP_sha256;
  Result := OpenSSLGetDigestCtx(LRet);
  {$ENDIF}
end;

function OpenSSLIsSHA384HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha384);
  {$ELSE}
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetSHA384HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_SHA512}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := nil;
  {$ELSE}
  LRet := EVP_sha384;
  Result := OpenSSLGetDigestCtx(LRet);
  {$ENDIF}
end;

function OpenSSLIsSHA512HashIntfAvail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := nil;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha512);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetSHA512HashInst : TIdHashIntCtx;
{$IFNDEF OPENSSL_NO_SHA512}
var
  LRet : PEVP_MD;
{$ENDIF}
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := nil;
  {$ELSE}
  LRet := EVP_sha512;
  Result := OpenSSLGetDigestCtx(LRet);
{$ENDIF}
end;

procedure OpenSSLUpdateHashInst(ACtx: TIdHashIntCtx; const AIn: TIdBytes);
var
  LRet : TIdC_Int;
begin
  LRet := EVP_DigestUpdate(ACtx, PByte(Ain), Length(AIn));
  if LRet <> 1 then begin
    EIdDigestInitEx.RaiseException(RSOSSLEVPDigestUpdateError);
  end;
end;

function OpenSSLFinalHashInst(ACtx: TIdHashIntCtx): TIdBytes;
var
  LLen : TIdC_UInt;
  LRet : TIdC_Int;
begin
  SetLength(Result,EVP_MAX_MD_SIZE);
  LRet := EVP_DigestFinal_ex(ACtx, PByte(@Result[0]), LLen);
  if LRet <> 1 then begin
    EIdDigestFinalEx.RaiseException('EVP_DigestFinal_ex error');
  end;
  SetLength(Result,LLen);
  EVP_MD_CTX_free(PEVP_MD_CTX(ACtx));
end;

function OpenSSLIsHMACAvail : Boolean;
begin
  {$IFDEF OPENSSL_NO_HMAC}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(HMAC_CTX_new) and
            Assigned(HMAC_Init_ex) and
            Assigned(HMAC_Update)  and
            Assigned(HMAC_Final) and
            Assigned(HMAC_CTX_free);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLIsHMACMD5Avail: Boolean;
begin
 {$IFDEF OPENSSL_NO_MD5}
 Result := False;
 {$ELSE}
 {$IFNDEF USE_EXTERNAL_LIBRARY}
 Result := Assigned(EVP_md5);
 {$ELSE}
 Result := true;
 {$ENDIF}
 {$ENDIF}
end;

function OpenSSLGetHMACMD5Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_MD5}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_md5, nil);
  {$ENDIF}
end;

function OpenSSLIsHMACSHA1Avail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha1);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetHMACSHA1Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_SHA}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_sha1, nil);
  {$ENDIF}
end;

function OpenSSLIsHMACSHA224Avail: Boolean;

begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha224);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetHMACSHA224Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_sha224, nil);
  {$ENDIF}
end;

function OpenSSLIsHMACSHA256Avail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha256);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetHMACSHA256Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_SHA256}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_sha256, nil);
  {$ENDIF}
end;

function OpenSSLIsHMACSHA384Avail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha384);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetHMACSHA384Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_sha384, nil);
  {$ENDIF}
end;

function OpenSSLIsHMACSHA512Avail: Boolean;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := False;
  {$ELSE}
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  Result := Assigned(EVP_sha512);
  {$ELSE}
  Result := true;
  {$ENDIF}
  {$ENDIF}
end;

function OpenSSLGetHMACSHA512Inst(const AKey : TIdBytes) : TIdHMACIntCtx;
begin
  {$IFDEF OPENSSL_NO_SHA512}
  Result := nil;
  {$ELSE}
  Result := HMAC_CTX_new;
  HMAC_Init_ex(Result, PByte(AKey), Length(AKey), EVP_sha512, nil);
  {$ENDIF}
end;

procedure OpenSSLUpdateHMACInst(ACtx : TIdHMACIntCtx; const AIn: TIdBytes);
begin
  HMAC_Update(ACtx, PByte(AIn), Length(AIn));
end;

function OpenSSLFinalHMACInst(ACtx: TIdHMACIntCtx): TIdBytes;
var
  LLen : TIdC_UInt;
begin
  LLen := EVP_MAX_MD_SIZE;
  SetLength(Result,LLen);
  HMAC_Final(ACtx, PByte(@Result[0]), @LLen);
  SetLength(Result,LLen);
  HMAC_CTX_free(ACtx);
end;

//****************************************************

initialization
  SetFIPSMode := OpenSSLSetFIPSMode;
  GetFIPSMode := OpenSSLGetFIPSMode;
  IsHashingIntfAvail := OpenSSLIsHashingIntfAvail;
  IsMD2HashIntfAvail := OpenSSLIsMD2HashIntfAvail;
  GetMD2HashInst := OpenSSLGetMD2HashInst;
  IsMD4HashIntfAvail := OpenSSLIsMD4HashIntfAvail;
  GetMD4HashInst := OpenSSLGetMD4HashInst;
  IsMD5HashIntfAvail := OpenSSLIsMD5HashIntfAvail;
  GetMD5HashInst := OpenSSLGetMD5HashInst;
  IsSHA1HashIntfAvail := OpenSSLIsSHA1HashIntfAvail;
  GetSHA1HashInst := OpenSSLGetSHA1HashInst;
  IsSHA224HashIntfAvail := OpenSSLIsSHA224HashIntfAvail;
  GetSHA224HashInst := OpenSSLGetSHA224HashInst;
  IsSHA256HashIntfAvail := OpenSSLIsSHA256HashIntfAvail;
  GetSHA256HashInst := OpenSSLGetSHA256HashInst;
  IsSHA384HashIntfAvail := OpenSSLIsSHA384HashIntfAvail;
  GetSHA384HashInst := OpenSSLGetSHA384HashInst;
  IsSHA512HashIntfAvail := OpenSSLIsSHA512HashIntfAvail;
  GetSHA512HashInst := OpenSSLGetSHA512HashInst;
  UpdateHashInst := OpenSSLUpdateHashInst;
  FinalHashInst := OpenSSLFinalHashInst;
  IsHMACAvail := OpenSSLIsHMACAvail;
  IsHMACMD5Avail := OpenSSLIsHMACMD5Avail;
  GetHMACMD5HashInst := OpenSSLGetHMACMD5Inst;
  IsHMACSHA1Avail  := OpenSSLIsHMACSHA1Avail;
  GetHMACSHA1HashInst:= OpenSSLGetHMACSHA1Inst;
  IsHMACSHA224Avail := OpenSSLIsHMACSHA224Avail;
  GetHMACSHA224HashInst:= OpenSSLGetHMACSHA224Inst;
  IsHMACSHA256Avail := OpenSSLIsHMACSHA256Avail;
  GetHMACSHA256HashInst:= OpenSSLGetHMACSHA256Inst;
  IsHMACSHA384Avail := OpenSSLIsHMACSHA384Avail;
  GetHMACSHA384HashInst:= OpenSSLGetHMACSHA384Inst;
  IsHMACSHA512Avail := OpenSSLIsHMACSHA512Avail;
  GetHMACSHA512HashInst:= OpenSSLGetHMACSHA512Inst;
  UpdateHMACInst := OpenSSLUpdateHMACInst;
  FinalHMACInst := OpenSSLFinalHMACInst;
end.

