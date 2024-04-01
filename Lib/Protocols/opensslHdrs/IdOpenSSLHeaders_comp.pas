  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_comp.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_comp.h2pas
     and this file regenerated. IdOpenSSLHeaders_comp.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
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

unit IdOpenSSLHeaders_comp;

interface

// Headers for OpenSSL 1.1.1
// comp.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM COMP_CTX_new}
  {$EXTERNALSYM COMP_CTX_get_method}
  {$EXTERNALSYM COMP_CTX_get_type}
  {$EXTERNALSYM COMP_get_type}
  {$EXTERNALSYM COMP_get_name}
  {$EXTERNALSYM COMP_CTX_free}
  {$EXTERNALSYM COMP_compress_block}
  {$EXTERNALSYM COMP_expand_block}
  {$EXTERNALSYM COMP_zlib}
  {$EXTERNALSYM BIO_f_zlib}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  COMP_CTX_new: function (meth: PCOMP_METHOD): PCOMP_CTX; cdecl = nil;
  COMP_CTX_get_method: function (const ctx: PCOMP_CTX): PCOMP_METHOD; cdecl = nil;
  COMP_CTX_get_type: function (const comp: PCOMP_CTX): TIdC_INT; cdecl = nil;
  COMP_get_type: function (const meth: PCOMP_METHOD): TIdC_INT; cdecl = nil;
  COMP_get_name: function (const meth: PCOMP_METHOD): PIdAnsiChar; cdecl = nil;
  COMP_CTX_free: procedure (ctx: PCOMP_CTX); cdecl = nil;

  COMP_compress_block: function (ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT; cdecl = nil;
  COMP_expand_block: function (ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT; cdecl = nil;

  COMP_zlib: function : PCOMP_METHOD; cdecl = nil;

  BIO_f_zlib: function : PBIO_METHOD; cdecl = nil;

{$ELSE}
  function COMP_CTX_new(meth: PCOMP_METHOD): PCOMP_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function COMP_CTX_get_method(const ctx: PCOMP_CTX): PCOMP_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function COMP_CTX_get_type(const comp: PCOMP_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function COMP_get_type(const meth: PCOMP_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function COMP_get_name(const meth: PCOMP_METHOD): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure COMP_CTX_free(ctx: PCOMP_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function COMP_compress_block(ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function COMP_expand_block(ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function COMP_zlib: PCOMP_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_f_zlib: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  

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
  COMP_CTX_new := LoadFunction('COMP_CTX_new',AFailed);
  COMP_CTX_get_method := LoadFunction('COMP_CTX_get_method',AFailed);
  COMP_CTX_get_type := LoadFunction('COMP_CTX_get_type',AFailed);
  COMP_get_type := LoadFunction('COMP_get_type',AFailed);
  COMP_get_name := LoadFunction('COMP_get_name',AFailed);
  COMP_CTX_free := LoadFunction('COMP_CTX_free',AFailed);
  COMP_compress_block := LoadFunction('COMP_compress_block',AFailed);
  COMP_expand_block := LoadFunction('COMP_expand_block',AFailed);
  COMP_zlib := LoadFunction('COMP_zlib',AFailed);
  BIO_f_zlib := LoadFunction('BIO_f_zlib',AFailed);
end;

procedure Unload;
begin
  COMP_CTX_new := nil;
  COMP_CTX_get_method := nil;
  COMP_CTX_get_type := nil;
  COMP_get_type := nil;
  COMP_get_name := nil;
  COMP_CTX_free := nil;
  COMP_compress_block := nil;
  COMP_expand_block := nil;
  COMP_zlib := nil;
  BIO_f_zlib := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
