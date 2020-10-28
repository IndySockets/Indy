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

unit IdOpenSSLHeaders_rand;

interface

// Headers for OpenSSL 1.1.1
// rand.h

{$i IdCompilerDefines.inc}

uses
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

var
  function RAND_set_rand_method(const meth: PRAND_METHOD): TIdC_INT;
  function RAND_get_rand_method: PRAND_METHOD;
  function RAND_set_rand_engine(engine: PENGINE): TIdC_INT;

  function RAND_OpenSSL: PRAND_METHOD;

  function RAND_bytes(buf: PByte; num: TIdC_INT): TIdC_INT;
  function RAND_priv_bytes(buf: PByte; num: TIdC_INT): TIdC_INT;

  procedure RAND_seed(const buf: Pointer; num: TIdC_INT);
  procedure RAND_keep_random_devices_open(keep: TIdC_INT);

  procedure RAND_add(const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE);
  function RAND_load_file(const file_: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT;
  function RAND_write_file(const file_: PIdAnsiChar): TIdC_INT;
  function RAND_status: TIdC_INT;

  function RAND_query_egd_bytes(const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT;
  function RAND_egd(const path: PIdAnsiChar): TIdC_INT;
  function RAND_egd_bytes(const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT;

  function RAND_poll: TIdC_INT;

implementation

end.
