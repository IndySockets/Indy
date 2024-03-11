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

// Generation date: 28.10.2020 15:24:33

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

  function RAND_set_rand_method(const meth: PRAND_METHOD): TIdC_INT cdecl; external CLibCrypto;
  function RAND_get_rand_method: PRAND_METHOD cdecl; external CLibCrypto;
  function RAND_set_rand_engine(engine: PENGINE): TIdC_INT cdecl; external CLibCrypto;

  function RAND_OpenSSL: PRAND_METHOD cdecl; external CLibCrypto;

  function RAND_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function RAND_priv_bytes(buf: PByte; num: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  procedure RAND_seed(const buf: Pointer; num: TIdC_INT) cdecl; external CLibCrypto;
  procedure RAND_keep_random_devices_open(keep: TIdC_INT) cdecl; external CLibCrypto;

  procedure RAND_add(const buf: Pointer; num: TIdC_INT; randomness: TIdC_DOUBLE) cdecl; external CLibCrypto;
  function RAND_load_file(const file_: PIdAnsiChar; max_bytes: TIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function RAND_write_file(const file_: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function RAND_status: TIdC_INT cdecl; external CLibCrypto;

  function RAND_query_egd_bytes(const path: PIdAnsiChar; buf: PByte; bytes: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function RAND_egd(const path: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function RAND_egd_bytes(const path: PIdAnsiChar; bytes: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function RAND_poll: TIdC_INT cdecl; external CLibCrypto;

implementation

end.
