  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_rand.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_rand.h2pas
     and this file regenerated. IdOpenSSLHeaders_rand.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_rand;

interface

// Headers for OpenSSL 1.1.1
// rand.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

type
  rand_meth_st_seed = function (const buf: Pointer; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_bytes = function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_cleanup = procedure; cdecl;
  rand_meth_st_add = function (const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE): TIdC_INT; cdecl;
  rand_meth_st_pseudorand = function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl;
  rand_meth_st_status = function: TIdC_INT; cdecl;

  rand_meth_st = record
    seed: rand_meth_st_seed;
    bytes: rand_meth_st_bytes;
    cleanup: rand_meth_st_cleanup;
    add: rand_meth_st_add;
    pseudorand: rand_meth_st_pseudorand;
    status: rand_meth_st_status;
  end;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM RAND_set_rand_method}
  {$EXTERNALSYM RAND_get_rand_method}
  {$EXTERNALSYM RAND_set_rand_engine}
  {$EXTERNALSYM RAND_OpenSSL}
  {$EXTERNALSYM RAND_bytes}
  {$EXTERNALSYM RAND_priv_bytes}
  {$EXTERNALSYM RAND_seed}
  {$EXTERNALSYM RAND_keep_random_devices_open}
  {$EXTERNALSYM RAND_add}
  {$EXTERNALSYM RAND_load_file}
  {$EXTERNALSYM RAND_write_file}
  {$EXTERNALSYM RAND_status}
  {$EXTERNALSYM RAND_query_egd_bytes}
  {$EXTERNALSYM RAND_egd}
  {$EXTERNALSYM RAND_egd_bytes}
  {$EXTERNALSYM RAND_poll}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  RAND_set_rand_method: function (const meth: PRAND_METHOD): TIdC_INT; cdecl = nil;
  RAND_get_rand_method: function : PRAND_METHOD; cdecl = nil;
  RAND_set_rand_engine: function (engine: PENGINE): TIdC_INT; cdecl = nil;

  RAND_OpenSSL: function : PRAND_METHOD; cdecl = nil;

  RAND_bytes: function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl = nil;
  RAND_priv_bytes: function (buf: PByte; num: TIdC_INT): TIdC_INT; cdecl = nil;

  RAND_seed: procedure (const buf: Pointer; num: TIdC_INT); cdecl = nil;
  RAND_keep_random_devices_open: procedure (keep: TIdC_INT); cdecl = nil;

  RAND_add: procedure (const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE); cdecl = nil;
  RAND_load_file: function (const file_: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT; cdecl = nil;
  RAND_write_file: function (const file_: PIdAnsiChar): TIdC_INT; cdecl = nil;
  RAND_status: function : TIdC_INT; cdecl = nil;

  RAND_query_egd_bytes: function (const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT; cdecl = nil;
  RAND_egd: function (const path: PIdAnsiChar): TIdC_INT; cdecl = nil;
  RAND_egd_bytes: function (const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT; cdecl = nil;

  RAND_poll: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function RAND_set_rand_method(const meth: PRAND_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_get_rand_method: PRAND_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_set_rand_engine(engine: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function RAND_OpenSSL: PRAND_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function RAND_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_priv_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure RAND_seed(const buf: Pointer; num: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure RAND_keep_random_devices_open(keep: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure RAND_add(const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_load_file(const file_: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_write_file(const file_: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_status: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function RAND_query_egd_bytes(const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_egd(const path: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function RAND_egd_bytes(const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function RAND_poll: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  RAND_set_rand_method := LoadFunction('RAND_set_rand_method',AFailed);
  RAND_get_rand_method := LoadFunction('RAND_get_rand_method',AFailed);
  RAND_set_rand_engine := LoadFunction('RAND_set_rand_engine',AFailed);
  RAND_OpenSSL := LoadFunction('RAND_OpenSSL',AFailed);
  RAND_bytes := LoadFunction('RAND_bytes',AFailed);
  RAND_priv_bytes := LoadFunction('RAND_priv_bytes',AFailed);
  RAND_seed := LoadFunction('RAND_seed',AFailed);
  RAND_keep_random_devices_open := LoadFunction('RAND_keep_random_devices_open',AFailed);
  RAND_add := LoadFunction('RAND_add',AFailed);
  RAND_load_file := LoadFunction('RAND_load_file',AFailed);
  RAND_write_file := LoadFunction('RAND_write_file',AFailed);
  RAND_status := LoadFunction('RAND_status',AFailed);
  RAND_query_egd_bytes := LoadFunction('RAND_query_egd_bytes',AFailed);
  RAND_egd := LoadFunction('RAND_egd',AFailed);
  RAND_egd_bytes := LoadFunction('RAND_egd_bytes',AFailed);
  RAND_poll := LoadFunction('RAND_poll',AFailed);
end;

procedure Unload;
begin
  RAND_set_rand_method := nil;
  RAND_get_rand_method := nil;
  RAND_set_rand_engine := nil;
  RAND_OpenSSL := nil;
  RAND_bytes := nil;
  RAND_priv_bytes := nil;
  RAND_seed := nil;
  RAND_keep_random_devices_open := nil;
  RAND_add := nil;
  RAND_load_file := nil;
  RAND_write_file := nil;
  RAND_status := nil;
  RAND_query_egd_bytes := nil;
  RAND_egd := nil;
  RAND_egd_bytes := nil;
  RAND_poll := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
