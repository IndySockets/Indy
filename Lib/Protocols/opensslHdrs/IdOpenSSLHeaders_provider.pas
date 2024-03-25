  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_provider.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_provider.h2pas
     and this file regenerated. IdOpenSSLHeaders_provider.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_provider;

interface

{
  Automatically converted by H2Pas 1.0.0 from provider.h
  The following command line parameters were used:
    provider.h
}

uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_core;

type
    POSSL_ALGORITHM  = ^OSSL_ALGORITHM;
    POSSL_CALLBACK  = ^OSSL_CALLBACK;
    POSSL_DISPATCH  = ^OSSL_DISPATCH;
    POSSL_PARAM  = ^OSSL_PARAM;
    POSSL_PROVIDER  = pointer;
    POSSL_provider_init_fn  = ^OSSL_provider_init_fn;

    TDo_AllCallback = function (provider:POSSL_PROVIDER; cbdata:pointer):TIdC_LONG; cdecl;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}
  {
   * Copyright 2019-2023 The OpenSSL Project Authors. All Rights Reserved.
   *
   * Licensed under the Apache License 2.0 (the "License").  You may not use
   * this file except in compliance with the License.  You can obtain a copy
   * in the file LICENSE in the source distribution or at
   * https://www.openssl.org/source/license.html
    }
  { Set and Get a library context search path  }
    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM OSSL_PROVIDER_set_default_search_path} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get0_default_search_path} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_load} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_load_ex} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_try_load} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_try_load_ex} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_unload} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_available} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_do_all} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_gettable_params} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get_params} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_self_test}{introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get_capabilities}{introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_query_operation} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_unquery_operation} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get0_provider_ctx} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get0_dispatch} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_add_builtin} {introduced 3.0.0}
  {$EXTERNALSYM OSSL_PROVIDER_get0_name} {introduced 3.0.0}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  OSSL_PROVIDER_set_default_search_path: function (ctx: POSSL_LIB_CTX; path: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_default_search_path: function (libctx: POSSL_LIB_CTX): PIdAnsiChar; cdecl = nil; {introduced 3.0.0}
    { Load and unload a provider  }
  OSSL_PROVIDER_load: function (_para1:POSSL_LIB_CTX; name: PIdAnsiChar):POSSL_PROVIDER; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_load_ex: function (_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params: POSSL_PARAM):POSSL_PROVIDER; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_try_load: function (_para1:POSSL_LIB_CTX; name: PIdAnsiChar; retain_fallbacks: TIdC_LONG):POSSL_PROVIDER; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_try_load_ex: function (_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params:POSSL_PARAM; retain_fallbacks:TIdC_LONG):POSSL_PROVIDER; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_unload: function (prov:POSSL_PROVIDER):TIdC_LONG; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_available: function (_para1:POSSL_LIB_CTX; name:PIdAnsiChar):TIdC_LONG; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_do_all: function (ctx:POSSL_LIB_CTX; cb:TDo_AllCallback; cbdata:pointer):TIdC_LONG; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_gettable_params: function (prov:POSSL_PROVIDER):POSSL_PARAM; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_get_params: function (prov:POSSL_PROVIDER; params:POSSL_PARAM):TIdC_LONG; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_self_test: function (prov:POSSL_PROVIDER):TIdC_LONG; cdecl = nil;{introduced 3.0.0}
  OSSL_PROVIDER_get_capabilities: function (prov:POSSL_PROVIDER; capability:PIdAnsiChar; cb:POSSL_CALLBACK; arg:pointer):TIdC_LONG; cdecl = nil;{introduced 3.0.0}
  OSSL_PROVIDER_query_operation: function (prov:POSSL_PROVIDER; operation_id:TIdC_LONG; no_cache:PIdC_LONG):POSSL_ALGORITHM; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_unquery_operation: procedure (prov:POSSL_PROVIDER; operation_id:TIdC_LONG; algs:POSSL_ALGORITHM); cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_provider_ctx: function (prov:POSSL_PROVIDER):pointer; cdecl = nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_dispatch: function (prov:POSSL_PROVIDER):POSSL_DISPATCH; cdecl = nil; {introduced 3.0.0}
    { Add a built in providers  }
  OSSL_PROVIDER_add_builtin: function (_para1:POSSL_LIB_CTX; name:PIdAnsiChar; init_fn:POSSL_provider_init_fn):TIdC_LONG; cdecl = nil; {introduced 3.0.0}

    { Information  }
  OSSL_PROVIDER_get0_name: function (prov:POSSL_PROVIDER):PIdAnsiChar; cdecl = nil; {introduced 3.0.0}


{$ELSE}
  function OSSL_PROVIDER_set_default_search_path(ctx: POSSL_LIB_CTX; path: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_get0_default_search_path(libctx: POSSL_LIB_CTX): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
    { Load and unload a provider  }
  function OSSL_PROVIDER_load(_para1:POSSL_LIB_CTX; name: PIdAnsiChar):POSSL_PROVIDER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_load_ex(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params: POSSL_PARAM):POSSL_PROVIDER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_try_load(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; retain_fallbacks: TIdC_LONG):POSSL_PROVIDER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_try_load_ex(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params:POSSL_PARAM; retain_fallbacks:TIdC_LONG):POSSL_PROVIDER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_unload(prov:POSSL_PROVIDER):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_available(_para1:POSSL_LIB_CTX; name:PIdAnsiChar):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_do_all(ctx:POSSL_LIB_CTX; cb:TDo_AllCallback; cbdata:pointer):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_gettable_params(prov:POSSL_PROVIDER):POSSL_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_get_params(prov:POSSL_PROVIDER; params:POSSL_PARAM):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_self_test(prov:POSSL_PROVIDER):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};{introduced 3.0.0}
  function OSSL_PROVIDER_get_capabilities(prov:POSSL_PROVIDER; capability:PIdAnsiChar; cb:POSSL_CALLBACK; arg:pointer):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};{introduced 3.0.0}
  function OSSL_PROVIDER_query_operation(prov:POSSL_PROVIDER; operation_id:TIdC_LONG; no_cache:PIdC_LONG):POSSL_ALGORITHM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  procedure OSSL_PROVIDER_unquery_operation(prov:POSSL_PROVIDER; operation_id:TIdC_LONG; algs:POSSL_ALGORITHM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_get0_provider_ctx(prov:POSSL_PROVIDER):pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  function OSSL_PROVIDER_get0_dispatch(prov:POSSL_PROVIDER):POSSL_DISPATCH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
    { Add a built in providers  }
  function OSSL_PROVIDER_add_builtin(_para1:POSSL_LIB_CTX; name:PIdAnsiChar; init_fn:POSSL_provider_init_fn):TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}

    { Information  }
  function OSSL_PROVIDER_get0_name(prov:POSSL_PROVIDER):PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}


{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  
const
  OSSL_PROVIDER_set_default_search_path_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get0_default_search_path_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_load_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_load_ex_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_try_load_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_try_load_ex_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_unload_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_available_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_do_all_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_gettable_params_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get_params_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_self_test_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get_capabilities_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_query_operation_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_unquery_operation_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get0_provider_ctx_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get0_dispatch_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_add_builtin_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_PROVIDER_get0_name_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
{$IFNDEF USE_EXTERNAL_LIBRARY}
{$WARN  NO_RETVAL OFF}
function  ERR_OSSL_PROVIDER_set_default_search_path(ctx: POSSL_LIB_CTX; path: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_set_default_search_path');
end;


function  ERR_OSSL_PROVIDER_get0_default_search_path(libctx: POSSL_LIB_CTX): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get0_default_search_path');
end;


function  ERR_OSSL_PROVIDER_load(_para1:POSSL_LIB_CTX; name: PIdAnsiChar):POSSL_PROVIDER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_load');
end;


function  ERR_OSSL_PROVIDER_load_ex(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params: POSSL_PARAM):POSSL_PROVIDER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_load_ex');
end;


function  ERR_OSSL_PROVIDER_try_load(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; retain_fallbacks: TIdC_LONG):POSSL_PROVIDER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_try_load');
end;


function  ERR_OSSL_PROVIDER_try_load_ex(_para1:POSSL_LIB_CTX; name: PIdAnsiChar; params:POSSL_PARAM; retain_fallbacks:TIdC_LONG):POSSL_PROVIDER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_try_load_ex');
end;


function  ERR_OSSL_PROVIDER_unload(prov:POSSL_PROVIDER):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_unload');
end;


function  ERR_OSSL_PROVIDER_available(_para1:POSSL_LIB_CTX; name:PIdAnsiChar):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_available');
end;


function  ERR_OSSL_PROVIDER_do_all(ctx:POSSL_LIB_CTX; cb:TDo_AllCallback; cbdata:pointer):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_do_all');
end;


function  ERR_OSSL_PROVIDER_gettable_params(prov:POSSL_PROVIDER):POSSL_PARAM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_gettable_params');
end;


function  ERR_OSSL_PROVIDER_get_params(prov:POSSL_PROVIDER; params:POSSL_PARAM):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get_params');
end;


function  ERR_OSSL_PROVIDER_self_test(prov:POSSL_PROVIDER):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_self_test');
end;


function  ERR_OSSL_PROVIDER_get_capabilities(prov:POSSL_PROVIDER; capability:PIdAnsiChar; cb:POSSL_CALLBACK; arg:pointer):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get_capabilities');
end;


function  ERR_OSSL_PROVIDER_query_operation(prov:POSSL_PROVIDER; operation_id:TIdC_LONG; no_cache:PIdC_LONG):POSSL_ALGORITHM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_query_operation');
end;


procedure  ERR_OSSL_PROVIDER_unquery_operation(prov:POSSL_PROVIDER; operation_id:TIdC_LONG; algs:POSSL_ALGORITHM); 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_unquery_operation');
end;


function  ERR_OSSL_PROVIDER_get0_provider_ctx(prov:POSSL_PROVIDER):pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get0_provider_ctx');
end;


function  ERR_OSSL_PROVIDER_get0_dispatch(prov:POSSL_PROVIDER):POSSL_DISPATCH; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get0_dispatch');
end;


function  ERR_OSSL_PROVIDER_add_builtin(_para1:POSSL_LIB_CTX; name:PIdAnsiChar; init_fn:POSSL_provider_init_fn):TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_add_builtin');
end;


function  ERR_OSSL_PROVIDER_get0_name(prov:POSSL_PROVIDER):PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OSSL_PROVIDER_get0_name');
end;


{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  OSSL_PROVIDER_set_default_search_path := LoadFunction('OSSL_PROVIDER_set_default_search_path',nil); {introduced 3.0.0}
  OSSL_PROVIDER_get0_default_search_path := LoadFunction('OSSL_PROVIDER_get0_default_search_path',nil); {introduced 3.0.0}
  OSSL_PROVIDER_load := LoadFunction('OSSL_PROVIDER_load',nil); {introduced 3.0.0}
  OSSL_PROVIDER_load_ex := LoadFunction('OSSL_PROVIDER_load_ex',nil); {introduced 3.0.0}
  OSSL_PROVIDER_try_load := LoadFunction('OSSL_PROVIDER_try_load',nil); {introduced 3.0.0}
  OSSL_PROVIDER_try_load_ex := LoadFunction('OSSL_PROVIDER_try_load_ex',nil); {introduced 3.0.0}
  OSSL_PROVIDER_unload := LoadFunction('OSSL_PROVIDER_unload',nil); {introduced 3.0.0}
  OSSL_PROVIDER_available := LoadFunction('OSSL_PROVIDER_available',nil); {introduced 3.0.0}
  OSSL_PROVIDER_do_all := LoadFunction('OSSL_PROVIDER_do_all',nil); {introduced 3.0.0}
  OSSL_PROVIDER_gettable_params := LoadFunction('OSSL_PROVIDER_gettable_params',nil); {introduced 3.0.0}
  OSSL_PROVIDER_get_params := LoadFunction('OSSL_PROVIDER_get_params',nil); {introduced 3.0.0}
  OSSL_PROVIDER_self_test := LoadFunction('OSSL_PROVIDER_self_test',nil);{introduced 3.0.0}
  OSSL_PROVIDER_get_capabilities := LoadFunction('OSSL_PROVIDER_get_capabilities',nil);{introduced 3.0.0}
  OSSL_PROVIDER_query_operation := LoadFunction('OSSL_PROVIDER_query_operation',nil); {introduced 3.0.0}
  OSSL_PROVIDER_unquery_operation := LoadFunction('OSSL_PROVIDER_unquery_operation',nil); {introduced 3.0.0}
  OSSL_PROVIDER_get0_provider_ctx := LoadFunction('OSSL_PROVIDER_get0_provider_ctx',nil); {introduced 3.0.0}
  OSSL_PROVIDER_get0_dispatch := LoadFunction('OSSL_PROVIDER_get0_dispatch',nil); {introduced 3.0.0}
  OSSL_PROVIDER_add_builtin := LoadFunction('OSSL_PROVIDER_add_builtin',nil); {introduced 3.0.0}
  OSSL_PROVIDER_get0_name := LoadFunction('OSSL_PROVIDER_get0_name',nil); {introduced 3.0.0}
  if not assigned(OSSL_PROVIDER_set_default_search_path) then 
  begin
    {$if declared(OSSL_PROVIDER_set_default_search_path_introduced)}
    if LibVersion < OSSL_PROVIDER_set_default_search_path_introduced then
      {$if declared(FC_OSSL_PROVIDER_set_default_search_path)}
      OSSL_PROVIDER_set_default_search_path := @FC_OSSL_PROVIDER_set_default_search_path
      {$else}
      OSSL_PROVIDER_set_default_search_path := @ERR_OSSL_PROVIDER_set_default_search_path
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_set_default_search_path_removed)}
   if OSSL_PROVIDER_set_default_search_path_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_set_default_search_path)}
     OSSL_PROVIDER_set_default_search_path := @_OSSL_PROVIDER_set_default_search_path
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_set_default_search_path)}
       OSSL_PROVIDER_set_default_search_path := @ERR_OSSL_PROVIDER_set_default_search_path
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_set_default_search_path) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_set_default_search_path');
  end;


  if not assigned(OSSL_PROVIDER_get0_default_search_path) then 
  begin
    {$if declared(OSSL_PROVIDER_get0_default_search_path_introduced)}
    if LibVersion < OSSL_PROVIDER_get0_default_search_path_introduced then
      {$if declared(FC_OSSL_PROVIDER_get0_default_search_path)}
      OSSL_PROVIDER_get0_default_search_path := @FC_OSSL_PROVIDER_get0_default_search_path
      {$else}
      OSSL_PROVIDER_get0_default_search_path := @ERR_OSSL_PROVIDER_get0_default_search_path
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get0_default_search_path_removed)}
   if OSSL_PROVIDER_get0_default_search_path_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get0_default_search_path)}
     OSSL_PROVIDER_get0_default_search_path := @_OSSL_PROVIDER_get0_default_search_path
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get0_default_search_path)}
       OSSL_PROVIDER_get0_default_search_path := @ERR_OSSL_PROVIDER_get0_default_search_path
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get0_default_search_path) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get0_default_search_path');
  end;


  if not assigned(OSSL_PROVIDER_load) then 
  begin
    {$if declared(OSSL_PROVIDER_load_introduced)}
    if LibVersion < OSSL_PROVIDER_load_introduced then
      {$if declared(FC_OSSL_PROVIDER_load)}
      OSSL_PROVIDER_load := @FC_OSSL_PROVIDER_load
      {$else}
      OSSL_PROVIDER_load := @ERR_OSSL_PROVIDER_load
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_load_removed)}
   if OSSL_PROVIDER_load_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_load)}
     OSSL_PROVIDER_load := @_OSSL_PROVIDER_load
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_load)}
       OSSL_PROVIDER_load := @ERR_OSSL_PROVIDER_load
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_load) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_load');
  end;


  if not assigned(OSSL_PROVIDER_load_ex) then 
  begin
    {$if declared(OSSL_PROVIDER_load_ex_introduced)}
    if LibVersion < OSSL_PROVIDER_load_ex_introduced then
      {$if declared(FC_OSSL_PROVIDER_load_ex)}
      OSSL_PROVIDER_load_ex := @FC_OSSL_PROVIDER_load_ex
      {$else}
      OSSL_PROVIDER_load_ex := @ERR_OSSL_PROVIDER_load_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_load_ex_removed)}
   if OSSL_PROVIDER_load_ex_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_load_ex)}
     OSSL_PROVIDER_load_ex := @_OSSL_PROVIDER_load_ex
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_load_ex)}
       OSSL_PROVIDER_load_ex := @ERR_OSSL_PROVIDER_load_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_load_ex) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_load_ex');
  end;


  if not assigned(OSSL_PROVIDER_try_load) then 
  begin
    {$if declared(OSSL_PROVIDER_try_load_introduced)}
    if LibVersion < OSSL_PROVIDER_try_load_introduced then
      {$if declared(FC_OSSL_PROVIDER_try_load)}
      OSSL_PROVIDER_try_load := @FC_OSSL_PROVIDER_try_load
      {$else}
      OSSL_PROVIDER_try_load := @ERR_OSSL_PROVIDER_try_load
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_try_load_removed)}
   if OSSL_PROVIDER_try_load_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_try_load)}
     OSSL_PROVIDER_try_load := @_OSSL_PROVIDER_try_load
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_try_load)}
       OSSL_PROVIDER_try_load := @ERR_OSSL_PROVIDER_try_load
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_try_load) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_try_load');
  end;


  if not assigned(OSSL_PROVIDER_try_load_ex) then 
  begin
    {$if declared(OSSL_PROVIDER_try_load_ex_introduced)}
    if LibVersion < OSSL_PROVIDER_try_load_ex_introduced then
      {$if declared(FC_OSSL_PROVIDER_try_load_ex)}
      OSSL_PROVIDER_try_load_ex := @FC_OSSL_PROVIDER_try_load_ex
      {$else}
      OSSL_PROVIDER_try_load_ex := @ERR_OSSL_PROVIDER_try_load_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_try_load_ex_removed)}
   if OSSL_PROVIDER_try_load_ex_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_try_load_ex)}
     OSSL_PROVIDER_try_load_ex := @_OSSL_PROVIDER_try_load_ex
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_try_load_ex)}
       OSSL_PROVIDER_try_load_ex := @ERR_OSSL_PROVIDER_try_load_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_try_load_ex) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_try_load_ex');
  end;


  if not assigned(OSSL_PROVIDER_unload) then 
  begin
    {$if declared(OSSL_PROVIDER_unload_introduced)}
    if LibVersion < OSSL_PROVIDER_unload_introduced then
      {$if declared(FC_OSSL_PROVIDER_unload)}
      OSSL_PROVIDER_unload := @FC_OSSL_PROVIDER_unload
      {$else}
      OSSL_PROVIDER_unload := @ERR_OSSL_PROVIDER_unload
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_unload_removed)}
   if OSSL_PROVIDER_unload_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_unload)}
     OSSL_PROVIDER_unload := @_OSSL_PROVIDER_unload
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_unload)}
       OSSL_PROVIDER_unload := @ERR_OSSL_PROVIDER_unload
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_unload) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_unload');
  end;


  if not assigned(OSSL_PROVIDER_available) then 
  begin
    {$if declared(OSSL_PROVIDER_available_introduced)}
    if LibVersion < OSSL_PROVIDER_available_introduced then
      {$if declared(FC_OSSL_PROVIDER_available)}
      OSSL_PROVIDER_available := @FC_OSSL_PROVIDER_available
      {$else}
      OSSL_PROVIDER_available := @ERR_OSSL_PROVIDER_available
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_available_removed)}
   if OSSL_PROVIDER_available_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_available)}
     OSSL_PROVIDER_available := @_OSSL_PROVIDER_available
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_available)}
       OSSL_PROVIDER_available := @ERR_OSSL_PROVIDER_available
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_available) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_available');
  end;


  if not assigned(OSSL_PROVIDER_do_all) then 
  begin
    {$if declared(OSSL_PROVIDER_do_all_introduced)}
    if LibVersion < OSSL_PROVIDER_do_all_introduced then
      {$if declared(FC_OSSL_PROVIDER_do_all)}
      OSSL_PROVIDER_do_all := @FC_OSSL_PROVIDER_do_all
      {$else}
      OSSL_PROVIDER_do_all := @ERR_OSSL_PROVIDER_do_all
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_do_all_removed)}
   if OSSL_PROVIDER_do_all_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_do_all)}
     OSSL_PROVIDER_do_all := @_OSSL_PROVIDER_do_all
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_do_all)}
       OSSL_PROVIDER_do_all := @ERR_OSSL_PROVIDER_do_all
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_do_all) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_do_all');
  end;


  if not assigned(OSSL_PROVIDER_gettable_params) then 
  begin
    {$if declared(OSSL_PROVIDER_gettable_params_introduced)}
    if LibVersion < OSSL_PROVIDER_gettable_params_introduced then
      {$if declared(FC_OSSL_PROVIDER_gettable_params)}
      OSSL_PROVIDER_gettable_params := @FC_OSSL_PROVIDER_gettable_params
      {$else}
      OSSL_PROVIDER_gettable_params := @ERR_OSSL_PROVIDER_gettable_params
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_gettable_params_removed)}
   if OSSL_PROVIDER_gettable_params_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_gettable_params)}
     OSSL_PROVIDER_gettable_params := @_OSSL_PROVIDER_gettable_params
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_gettable_params)}
       OSSL_PROVIDER_gettable_params := @ERR_OSSL_PROVIDER_gettable_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_gettable_params) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_gettable_params');
  end;


  if not assigned(OSSL_PROVIDER_get_params) then 
  begin
    {$if declared(OSSL_PROVIDER_get_params_introduced)}
    if LibVersion < OSSL_PROVIDER_get_params_introduced then
      {$if declared(FC_OSSL_PROVIDER_get_params)}
      OSSL_PROVIDER_get_params := @FC_OSSL_PROVIDER_get_params
      {$else}
      OSSL_PROVIDER_get_params := @ERR_OSSL_PROVIDER_get_params
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get_params_removed)}
   if OSSL_PROVIDER_get_params_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get_params)}
     OSSL_PROVIDER_get_params := @_OSSL_PROVIDER_get_params
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get_params)}
       OSSL_PROVIDER_get_params := @ERR_OSSL_PROVIDER_get_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get_params) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get_params');
  end;


  if not assigned(OSSL_PROVIDER_self_test) then 
  begin
    {$if declared(OSSL_PROVIDER_self_test_introduced)}
    if LibVersion < OSSL_PROVIDER_self_test_introduced then
      {$if declared(FC_OSSL_PROVIDER_self_test)}
      OSSL_PROVIDER_self_test := @FC_OSSL_PROVIDER_self_test
      {$else}
      OSSL_PROVIDER_self_test := @ERR_OSSL_PROVIDER_self_test
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_self_test_removed)}
   if OSSL_PROVIDER_self_test_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_self_test)}
     OSSL_PROVIDER_self_test := @_OSSL_PROVIDER_self_test
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_self_test)}
       OSSL_PROVIDER_self_test := @ERR_OSSL_PROVIDER_self_test
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_self_test) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_self_test');
  end;


  if not assigned(OSSL_PROVIDER_get_capabilities) then 
  begin
    {$if declared(OSSL_PROVIDER_get_capabilities_introduced)}
    if LibVersion < OSSL_PROVIDER_get_capabilities_introduced then
      {$if declared(FC_OSSL_PROVIDER_get_capabilities)}
      OSSL_PROVIDER_get_capabilities := @FC_OSSL_PROVIDER_get_capabilities
      {$else}
      OSSL_PROVIDER_get_capabilities := @ERR_OSSL_PROVIDER_get_capabilities
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get_capabilities_removed)}
   if OSSL_PROVIDER_get_capabilities_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get_capabilities)}
     OSSL_PROVIDER_get_capabilities := @_OSSL_PROVIDER_get_capabilities
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get_capabilities)}
       OSSL_PROVIDER_get_capabilities := @ERR_OSSL_PROVIDER_get_capabilities
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get_capabilities) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get_capabilities');
  end;


  if not assigned(OSSL_PROVIDER_query_operation) then 
  begin
    {$if declared(OSSL_PROVIDER_query_operation_introduced)}
    if LibVersion < OSSL_PROVIDER_query_operation_introduced then
      {$if declared(FC_OSSL_PROVIDER_query_operation)}
      OSSL_PROVIDER_query_operation := @FC_OSSL_PROVIDER_query_operation
      {$else}
      OSSL_PROVIDER_query_operation := @ERR_OSSL_PROVIDER_query_operation
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_query_operation_removed)}
   if OSSL_PROVIDER_query_operation_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_query_operation)}
     OSSL_PROVIDER_query_operation := @_OSSL_PROVIDER_query_operation
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_query_operation)}
       OSSL_PROVIDER_query_operation := @ERR_OSSL_PROVIDER_query_operation
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_query_operation) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_query_operation');
  end;


  if not assigned(OSSL_PROVIDER_unquery_operation) then 
  begin
    {$if declared(OSSL_PROVIDER_unquery_operation_introduced)}
    if LibVersion < OSSL_PROVIDER_unquery_operation_introduced then
      {$if declared(FC_OSSL_PROVIDER_unquery_operation)}
      OSSL_PROVIDER_unquery_operation := @FC_OSSL_PROVIDER_unquery_operation
      {$else}
      OSSL_PROVIDER_unquery_operation := @ERR_OSSL_PROVIDER_unquery_operation
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_unquery_operation_removed)}
   if OSSL_PROVIDER_unquery_operation_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_unquery_operation)}
     OSSL_PROVIDER_unquery_operation := @_OSSL_PROVIDER_unquery_operation
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_unquery_operation)}
       OSSL_PROVIDER_unquery_operation := @ERR_OSSL_PROVIDER_unquery_operation
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_unquery_operation) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_unquery_operation');
  end;


  if not assigned(OSSL_PROVIDER_get0_provider_ctx) then 
  begin
    {$if declared(OSSL_PROVIDER_get0_provider_ctx_introduced)}
    if LibVersion < OSSL_PROVIDER_get0_provider_ctx_introduced then
      {$if declared(FC_OSSL_PROVIDER_get0_provider_ctx)}
      OSSL_PROVIDER_get0_provider_ctx := @FC_OSSL_PROVIDER_get0_provider_ctx
      {$else}
      OSSL_PROVIDER_get0_provider_ctx := @ERR_OSSL_PROVIDER_get0_provider_ctx
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get0_provider_ctx_removed)}
   if OSSL_PROVIDER_get0_provider_ctx_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get0_provider_ctx)}
     OSSL_PROVIDER_get0_provider_ctx := @_OSSL_PROVIDER_get0_provider_ctx
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get0_provider_ctx)}
       OSSL_PROVIDER_get0_provider_ctx := @ERR_OSSL_PROVIDER_get0_provider_ctx
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get0_provider_ctx) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get0_provider_ctx');
  end;


  if not assigned(OSSL_PROVIDER_get0_dispatch) then 
  begin
    {$if declared(OSSL_PROVIDER_get0_dispatch_introduced)}
    if LibVersion < OSSL_PROVIDER_get0_dispatch_introduced then
      {$if declared(FC_OSSL_PROVIDER_get0_dispatch)}
      OSSL_PROVIDER_get0_dispatch := @FC_OSSL_PROVIDER_get0_dispatch
      {$else}
      OSSL_PROVIDER_get0_dispatch := @ERR_OSSL_PROVIDER_get0_dispatch
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get0_dispatch_removed)}
   if OSSL_PROVIDER_get0_dispatch_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get0_dispatch)}
     OSSL_PROVIDER_get0_dispatch := @_OSSL_PROVIDER_get0_dispatch
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get0_dispatch)}
       OSSL_PROVIDER_get0_dispatch := @ERR_OSSL_PROVIDER_get0_dispatch
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get0_dispatch) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get0_dispatch');
  end;


  if not assigned(OSSL_PROVIDER_add_builtin) then 
  begin
    {$if declared(OSSL_PROVIDER_add_builtin_introduced)}
    if LibVersion < OSSL_PROVIDER_add_builtin_introduced then
      {$if declared(FC_OSSL_PROVIDER_add_builtin)}
      OSSL_PROVIDER_add_builtin := @FC_OSSL_PROVIDER_add_builtin
      {$else}
      OSSL_PROVIDER_add_builtin := @ERR_OSSL_PROVIDER_add_builtin
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_add_builtin_removed)}
   if OSSL_PROVIDER_add_builtin_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_add_builtin)}
     OSSL_PROVIDER_add_builtin := @_OSSL_PROVIDER_add_builtin
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_add_builtin)}
       OSSL_PROVIDER_add_builtin := @ERR_OSSL_PROVIDER_add_builtin
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_add_builtin) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_add_builtin');
  end;


  if not assigned(OSSL_PROVIDER_get0_name) then 
  begin
    {$if declared(OSSL_PROVIDER_get0_name_introduced)}
    if LibVersion < OSSL_PROVIDER_get0_name_introduced then
      {$if declared(FC_OSSL_PROVIDER_get0_name)}
      OSSL_PROVIDER_get0_name := @FC_OSSL_PROVIDER_get0_name
      {$else}
      OSSL_PROVIDER_get0_name := @ERR_OSSL_PROVIDER_get0_name
      {$ifend}
    else
    {$ifend}
   {$if declared(OSSL_PROVIDER_get0_name_removed)}
   if OSSL_PROVIDER_get0_name_removed <= LibVersion then
     {$if declared(_OSSL_PROVIDER_get0_name)}
     OSSL_PROVIDER_get0_name := @_OSSL_PROVIDER_get0_name
     {$else}
       {$IF declared(ERR_OSSL_PROVIDER_get0_name)}
       OSSL_PROVIDER_get0_name := @ERR_OSSL_PROVIDER_get0_name
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OSSL_PROVIDER_get0_name) and Assigned(AFailed) then 
     AFailed.Add('OSSL_PROVIDER_get0_name');
  end;


end;

procedure Unload;
begin
  OSSL_PROVIDER_set_default_search_path := nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_default_search_path := nil; {introduced 3.0.0}
  OSSL_PROVIDER_load := nil; {introduced 3.0.0}
  OSSL_PROVIDER_load_ex := nil; {introduced 3.0.0}
  OSSL_PROVIDER_try_load := nil; {introduced 3.0.0}
  OSSL_PROVIDER_try_load_ex := nil; {introduced 3.0.0}
  OSSL_PROVIDER_unload := nil; {introduced 3.0.0}
  OSSL_PROVIDER_available := nil; {introduced 3.0.0}
  OSSL_PROVIDER_do_all := nil; {introduced 3.0.0}
  OSSL_PROVIDER_gettable_params := nil; {introduced 3.0.0}
  OSSL_PROVIDER_get_params := nil; {introduced 3.0.0}
  OSSL_PROVIDER_self_test := nil;{introduced 3.0.0}
  OSSL_PROVIDER_get_capabilities := nil;{introduced 3.0.0}
  OSSL_PROVIDER_query_operation := nil; {introduced 3.0.0}
  OSSL_PROVIDER_unquery_operation := nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_provider_ctx := nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_dispatch := nil; {introduced 3.0.0}
  OSSL_PROVIDER_add_builtin := nil; {introduced 3.0.0}
  OSSL_PROVIDER_get0_name := nil; {introduced 3.0.0}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
