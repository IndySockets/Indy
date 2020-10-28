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
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 28.10.2020 15:24:13

unit IdOpenSSLHeaders_rand;

interface

// Headers for OpenSSL 1.1.1
// rand.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  RAND_set_rand_method: function(const meth: PRAND_METHOD): TIdC_INT cdecl = nil;
  RAND_get_rand_method: function: PRAND_METHOD cdecl = nil;
  RAND_set_rand_engine: function(engine: PENGINE): TIdC_INT cdecl = nil;

  RAND_OpenSSL: function: PRAND_METHOD cdecl = nil;

  RAND_bytes: function(buf: PByte; num: TIdC_INT): TIdC_INT cdecl = nil;
  RAND_priv_bytes: function(buf: PByte; num: TIdC_INT): TIdC_INT cdecl = nil;

  RAND_seed: procedure(const buf: Pointer; num: TIdC_INT) cdecl = nil;
  RAND_keep_random_devices_open: procedure(keep: TIdC_INT) cdecl = nil;

  RAND_add: procedure(const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE) cdecl = nil;
  RAND_load_file: function(const file_: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT cdecl = nil;
  RAND_write_file: function(const file_: PIdAnsiChar): TIdC_INT cdecl = nil;
  RAND_status: function: TIdC_INT cdecl = nil;

  RAND_query_egd_bytes: function(const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT cdecl = nil;
  RAND_egd: function(const path: PIdAnsiChar): TIdC_INT cdecl = nil;
  RAND_egd_bytes: function(const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT cdecl = nil;

  RAND_poll: function: TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  RAND_set_rand_method := LoadFunction('RAND_set_rand_method', AFailed);
  RAND_get_rand_method := LoadFunction('RAND_get_rand_method', AFailed);
  RAND_set_rand_engine := LoadFunction('RAND_set_rand_engine', AFailed);
  RAND_OpenSSL := LoadFunction('RAND_OpenSSL', AFailed);
  RAND_bytes := LoadFunction('RAND_bytes', AFailed);
  RAND_priv_bytes := LoadFunction('RAND_priv_bytes', AFailed);
  RAND_seed := LoadFunction('RAND_seed', AFailed);
  RAND_keep_random_devices_open := LoadFunction('RAND_keep_random_devices_open', AFailed);
  RAND_add := LoadFunction('RAND_add', AFailed);
  RAND_load_file := LoadFunction('RAND_load_file', AFailed);
  RAND_write_file := LoadFunction('RAND_write_file', AFailed);
  RAND_status := LoadFunction('RAND_status', AFailed);
  RAND_query_egd_bytes := LoadFunction('RAND_query_egd_bytes', AFailed);
  RAND_egd := LoadFunction('RAND_egd', AFailed);
  RAND_egd_bytes := LoadFunction('RAND_egd_bytes', AFailed);
  RAND_poll := LoadFunction('RAND_poll', AFailed);
end;

procedure UnLoad;
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

end.
