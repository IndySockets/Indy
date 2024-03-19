  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_sha.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_sha.h2pas
     and this file regenerated. IdOpenSSLHeaders_sha.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 

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
{                                                                              }
{******************************************************************************}

unit IdOpenSSLHeaders_sha;

interface

// Headers for OpenSSL 1.1.1
// sha.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  SHA_LBLOCK = 16;
  SHA_CBLOCK = SHA_LBLOCK * 4;

  SHA_LAST_BLOCK = SHA_CBLOCK - 8;
  SHA_DIGEST_LENGTH = 20;

  SHA256_CBLOCK = SHA_LBLOCK * 4;

  SHA224_DIGEST_LENGTH = 28;
  SHA256_DIGEST_LENGTH = 32;
  SHA384_DIGEST_LENGTH = 48;
  SHA512_DIGEST_LENGTH = 64;

  SHA512_CBLOCK = SHA_LBLOCK * 8;

type
  SHA_LONG = TIdC_UINT;

  SHAstate_sf = record
    h0, h1, h2, h3, h4: SHA_LONG;
    Nl, Nh: SHA_LONG;
    data: array[0 .. SHA_LAST_BLOCK - 1] of SHA_LONG;
    num: TIdC_UINT;
  end;
  SHA_CTX = SHAstate_sf;
  PSHA_CTX = ^SHA_CTX;

  SHAstate256_sf = record
    h: array[0..7] of SHA_LONG;
    Nl, Nh: SHA_LONG;
    data: array[0 .. SHA_LAST_BLOCK - 1] of SHA_LONG;
    num, md_len: TIdC_UINT;
  end;
  SHA256_CTX = SHAstate256_sf;
  PSHA256_CTX = ^SHA256_CTX;

  SHA_LONG64 = TIdC_UINT64;

  SHA512state_st_u = record
    case Integer of
    0: (d: array[0 .. SHA_LBLOCK - 1] of SHA_LONG64);
    1: (p: array[0 .. SHA512_CBLOCK - 1] of Byte);
  end;

  SHA512state_st = record
    h: array[0..7] of SHA_LONG64;
    Nl, Nh: SHA_LONG64;
    u: SHA512state_st_u;
    num, md_len: TIdC_UINT;
  end;
  SHA512_CTX = SHA512state_st;
  PSHA512_CTX = ^SHA512_CTX;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM SHA1_Init}
  {$EXTERNALSYM SHA1_Update}
  {$EXTERNALSYM SHA1_Final}
  {$EXTERNALSYM SHA1}
  {$EXTERNALSYM SHA1_Transform}
  {$EXTERNALSYM SHA224_Init}
  {$EXTERNALSYM SHA224_Update}
  {$EXTERNALSYM SHA224_Final}
  {$EXTERNALSYM SHA224}
  {$EXTERNALSYM SHA256_Init}
  {$EXTERNALSYM SHA256_Update}
  {$EXTERNALSYM SHA256_Final}
  {$EXTERNALSYM SHA256}
  {$EXTERNALSYM SHA256_Transform}
  {$EXTERNALSYM SHA384_Init}
  {$EXTERNALSYM SHA384_Update}
  {$EXTERNALSYM SHA384_Final}
  {$EXTERNALSYM SHA384}
  {$EXTERNALSYM SHA512_Init}
  {$EXTERNALSYM SHA512_Update}
  {$EXTERNALSYM SHA512_Final}
  {$EXTERNALSYM SHA512}
  {$EXTERNALSYM SHA512_Transform}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  SHA1_Init: function(c: PSHA_CTX): TIdC_INT; cdecl = nil;
  SHA1_Update: function(c: PSHA_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SHA1_Final: function(md: PByte; c: PSHA_CTX): TIdC_INT; cdecl = nil;
  SHA1: function(const d: PByte; n: TIdC_SIZET; md: PByte): PByte; cdecl = nil;
  SHA1_Transform: procedure(c: PSHA_CTX; const data: PByte); cdecl = nil;

  SHA224_Init: function(c: PSHA256_CTX): TIdC_INT; cdecl = nil;
  SHA224_Update: function(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SHA224_Final: function(md: PByte; c: PSHA256_CTX): TIdC_INT; cdecl = nil;
  SHA224: function(const d: PByte; n: TIdC_SIZET; md: PByte): PByte; cdecl = nil;

  SHA256_Init: function(c: PSHA256_CTX): TIdC_INT; cdecl = nil;
  SHA256_Update: function(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SHA256_Final: function(md: PByte; c: PSHA256_CTX): TIdC_INT; cdecl = nil;
  SHA256: function(const d: PByte; n: TIdC_SIZET; md: PByte): PByte; cdecl = nil;
  SHA256_Transform: procedure(c: PSHA256_CTX; const data: PByte); cdecl = nil;

  SHA384_Init: function(c: PSHA512_CTX): TIdC_INT; cdecl = nil;
  SHA384_Update: function(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SHA384_Final: function(md: PByte; c: PSHA512_CTX): TIdC_INT; cdecl = nil;
  SHA384: function(const d: PByte; n: TIdC_SIZET; md: PByte): PByte; cdecl = nil;

  SHA512_Init: function(c: PSHA512_CTX): TIdC_INT; cdecl = nil;
  SHA512_Update: function(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SHA512_Final: function(md: PByte; c: PSHA512_CTX): TIdC_INT; cdecl = nil;
  SHA512: function(const d: PByte; n: TIdC_SIZET; md: PByte): PByte; cdecl = nil;
  SHA512_Transform: procedure(c: PSHA512_CTX; const data: PByte); cdecl = nil;

{$ELSE}
  function SHA1_Init(c: PSHA_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA1_Update(c: PSHA_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA1_Final(md: PByte; c: PSHA_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA1(const d: PByte; n: TIdC_SIZET; md: PByte): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure SHA1_Transform(c: PSHA_CTX; const data: PByte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function SHA224_Init(c: PSHA256_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA224_Update(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA224_Final(md: PByte; c: PSHA256_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA224(const d: PByte; n: TIdC_SIZET; md: PByte): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function SHA256_Init(c: PSHA256_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA256_Update(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA256_Final(md: PByte; c: PSHA256_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA256(const d: PByte; n: TIdC_SIZET; md: PByte): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure SHA256_Transform(c: PSHA256_CTX; const data: PByte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function SHA384_Init(c: PSHA512_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA384_Update(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA384_Final(md: PByte; c: PSHA512_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA384(const d: PByte; n: TIdC_SIZET; md: PByte): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function SHA512_Init(c: PSHA512_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA512_Update(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA512_Final(md: PByte; c: PSHA512_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SHA512(const d: PByte; n: TIdC_SIZET; md: PByte): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure SHA512_Transform(c: PSHA512_CTX; const data: PByte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  SHA1_Init := LoadFunction('SHA1_Init',AFailed);
  SHA1_Update := LoadFunction('SHA1_Update',AFailed);
  SHA1_Final := LoadFunction('SHA1_Final',AFailed);
  SHA1 := LoadFunction('SHA1',AFailed);
  SHA1_Transform := LoadFunction('SHA1_Transform',AFailed);
  SHA224_Init := LoadFunction('SHA224_Init',AFailed);
  SHA224_Update := LoadFunction('SHA224_Update',AFailed);
  SHA224_Final := LoadFunction('SHA224_Final',AFailed);
  SHA224 := LoadFunction('SHA224',AFailed);
  SHA256_Init := LoadFunction('SHA256_Init',AFailed);
  SHA256_Update := LoadFunction('SHA256_Update',AFailed);
  SHA256_Final := LoadFunction('SHA256_Final',AFailed);
  SHA256 := LoadFunction('SHA256',AFailed);
  SHA256_Transform := LoadFunction('SHA256_Transform',AFailed);
  SHA384_Init := LoadFunction('SHA384_Init',AFailed);
  SHA384_Update := LoadFunction('SHA384_Update',AFailed);
  SHA384_Final := LoadFunction('SHA384_Final',AFailed);
  SHA384 := LoadFunction('SHA384',AFailed);
  SHA512_Init := LoadFunction('SHA512_Init',AFailed);
  SHA512_Update := LoadFunction('SHA512_Update',AFailed);
  SHA512_Final := LoadFunction('SHA512_Final',AFailed);
  SHA512 := LoadFunction('SHA512',AFailed);
  SHA512_Transform := LoadFunction('SHA512_Transform',AFailed);
end;

procedure Unload;
begin
  SHA1_Init := nil;
  SHA1_Update := nil;
  SHA1_Final := nil;
  SHA1 := nil;
  SHA1_Transform := nil;
  SHA224_Init := nil;
  SHA224_Update := nil;
  SHA224_Final := nil;
  SHA224 := nil;
  SHA256_Init := nil;
  SHA256_Update := nil;
  SHA256_Final := nil;
  SHA256 := nil;
  SHA256_Transform := nil;
  SHA384_Init := nil;
  SHA384_Update := nil;
  SHA384_Final := nil;
  SHA384 := nil;
  SHA512_Init := nil;
  SHA512_Update := nil;
  SHA512_Final := nil;
  SHA512 := nil;
  SHA512_Transform := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
