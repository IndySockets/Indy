  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_hmac.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_hmac.h2pas
     and this file regenerated. IdOpenSSLHeaders_hmac.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM HMAC_size}
  {$EXTERNALSYM HMAC_CTX_new}
  {$EXTERNALSYM HMAC_CTX_reset}
  {$EXTERNALSYM HMAC_CTX_free}
  {$EXTERNALSYM HMAC_Init_ex}
  {$EXTERNALSYM HMAC_Update}
  {$EXTERNALSYM HMAC_Final}
  {$EXTERNALSYM HMAC}
  {$EXTERNALSYM HMAC_CTX_copy}
  {$EXTERNALSYM HMAC_CTX_set_flags}
  {$EXTERNALSYM HMAC_CTX_get_md}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  HMAC_size: function(const e: PHMAC_CTX): TIdC_SIZET; cdecl = nil;
  HMAC_CTX_new: function: PHMAC_CTX; cdecl = nil;
  HMAC_CTX_reset: function(ctx: PHMAC_CTX): TIdC_INT; cdecl = nil;
  HMAC_CTX_free: procedure(ctx: PHMAC_CTX); cdecl = nil;

  HMAC_Init_ex: function(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT; cdecl = nil;
  HMAC_Update: function(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  HMAC_Final: function(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT; cdecl = nil;
  HMAC: function(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte; cdecl = nil;
  HMAC_CTX_copy: function(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT; cdecl = nil;

  HMAC_CTX_set_flags: procedure(ctx: PHMAC_CTX; flags: TIdC_ULONG); cdecl = nil;
  HMAC_CTX_get_md: function(const ctx: PHMAC_CTX): PEVP_MD; cdecl = nil;

{$ELSE}
  function HMAC_size(const e: PHMAC_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_new: PHMAC_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure HMAC_CTX_free(ctx: PHMAC_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function HMAC_Init_ex(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_Update(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_Final(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_copy(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure HMAC_CTX_set_flags(ctx: PHMAC_CTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  HMAC_size := LoadFunction('HMAC_size',AFailed);
  HMAC_CTX_new := LoadFunction('HMAC_CTX_new',AFailed);
  HMAC_CTX_reset := LoadFunction('HMAC_CTX_reset',AFailed);
  HMAC_CTX_free := LoadFunction('HMAC_CTX_free',AFailed);
  HMAC_Init_ex := LoadFunction('HMAC_Init_ex',AFailed);
  HMAC_Update := LoadFunction('HMAC_Update',AFailed);
  HMAC_Final := LoadFunction('HMAC_Final',AFailed);
  HMAC := LoadFunction('HMAC',AFailed);
  HMAC_CTX_copy := LoadFunction('HMAC_CTX_copy',AFailed);
  HMAC_CTX_set_flags := LoadFunction('HMAC_CTX_set_flags',AFailed);
  HMAC_CTX_get_md := LoadFunction('HMAC_CTX_get_md',AFailed);
end;

procedure Unload;
begin
  HMAC_size := nil;
  HMAC_CTX_new := nil;
  HMAC_CTX_reset := nil;
  HMAC_CTX_free := nil;
  HMAC_Init_ex := nil;
  HMAC_Update := nil;
  HMAC_Final := nil;
  HMAC := nil;
  HMAC_CTX_copy := nil;
  HMAC_CTX_set_flags := nil;
  HMAC_CTX_get_md := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
