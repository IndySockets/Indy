  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_cmac.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_cmac.h2pas
     and this file regenerated. IdOpenSSLHeaders_cmac.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_cmac;

interface

// Headers for OpenSSL 1.1.1
// cmac.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_ossl_typ;

//* Opaque */
type
  CMAC_CTX_st = type Pointer;
  CMAC_CTX = CMAC_CTX_st;
  PCMAC_CTX = ^CMAC_CTX;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM CMAC_CTX_new}
  {$EXTERNALSYM CMAC_CTX_cleanup}
  {$EXTERNALSYM CMAC_CTX_free}
  {$EXTERNALSYM CMAC_CTX_get0_cipher_ctx}
  {$EXTERNALSYM CMAC_CTX_copy}
  {$EXTERNALSYM CMAC_Init}
  {$EXTERNALSYM CMAC_Update}
  {$EXTERNALSYM CMAC_Final}
  {$EXTERNALSYM CMAC_resume}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  CMAC_CTX_new: function: PCMAC_CTX; cdecl = nil;
  CMAC_CTX_cleanup: procedure(ctx: PCMAC_CTX); cdecl = nil;
  CMAC_CTX_free: procedure(ctx: PCMAC_CTX); cdecl = nil;
  CMAC_CTX_get0_cipher_ctx: function(ctx: PCMAC_CTX): PEVP_CIPHER_CTX; cdecl = nil;
  CMAC_CTX_copy: function(out_: PCMAC_CTX; const in_: PCMAC_CTX): TIdC_INT; cdecl = nil;
  CMAC_Init: function(ctx: PCMAC_CTX; const key: Pointer; keylen: TIdC_SIZET; const cipher: PEVP_Cipher; impl: PENGINe): TIdC_INT; cdecl = nil;
  CMAC_Update: function(ctx: PCMAC_CTX; const data: Pointer; dlen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  CMAC_Final: function(ctx: PCMAC_CTX; out_: PByte; poutlen: PIdC_SIZET): TIdC_INT; cdecl = nil;
  CMAC_resume: function(ctx: PCMAC_CTX): TIdC_INT; cdecl = nil;

{$ELSE}
  function CMAC_CTX_new: PCMAC_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CMAC_CTX_cleanup(ctx: PCMAC_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CMAC_CTX_free(ctx: PCMAC_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_CTX_get0_cipher_ctx(ctx: PCMAC_CTX): PEVP_CIPHER_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_CTX_copy(out_: PCMAC_CTX; const in_: PCMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_Init(ctx: PCMAC_CTX; const key: Pointer; keylen: TIdC_SIZET; const cipher: PEVP_Cipher; impl: PENGINe): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_Update(ctx: PCMAC_CTX; const data: Pointer; dlen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_Final(ctx: PCMAC_CTX; out_: PByte; poutlen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CMAC_resume(ctx: PCMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  CMAC_CTX_new := LoadFunction('CMAC_CTX_new',AFailed);
  CMAC_CTX_cleanup := LoadFunction('CMAC_CTX_cleanup',AFailed);
  CMAC_CTX_free := LoadFunction('CMAC_CTX_free',AFailed);
  CMAC_CTX_get0_cipher_ctx := LoadFunction('CMAC_CTX_get0_cipher_ctx',AFailed);
  CMAC_CTX_copy := LoadFunction('CMAC_CTX_copy',AFailed);
  CMAC_Init := LoadFunction('CMAC_Init',AFailed);
  CMAC_Update := LoadFunction('CMAC_Update',AFailed);
  CMAC_Final := LoadFunction('CMAC_Final',AFailed);
  CMAC_resume := LoadFunction('CMAC_resume',AFailed);
end;

procedure Unload;
begin
  CMAC_CTX_new := nil;
  CMAC_CTX_cleanup := nil;
  CMAC_CTX_free := nil;
  CMAC_CTX_get0_cipher_ctx := nil;
  CMAC_CTX_copy := nil;
  CMAC_Init := nil;
  CMAC_Update := nil;
  CMAC_Final := nil;
  CMAC_resume := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
