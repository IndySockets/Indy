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

unit IdOpenSSLHeaders_blowfish;

interface

// Headers for OpenSSL 1.1.1
// blowfish.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  BF_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  BF_DECRYPT_CONST = 0;

  BF_ROUNDS = 16;
  BF_BLOCK  = 8;

type
  BF_LONG = TIdC_UINT;
  PBF_LONG = ^BF_LONG;

  bf_key_st = record
    p: array[0 .. BF_ROUNDS + 2 - 1] of BF_LONG;
    s: array[0 .. 4 * 256 - 1] of BF_LONG;
  end;
  BF_KEY = bf_key_st;
  PBF_KEY = ^BF_KEY;

  procedure BF_set_key(key: PBF_KEY; len: TIdC_INT; const data: PByte) cdecl; external CLibCrypto;

  procedure BF_encrypt(data: PBF_LONG; const key: PBF_KEY) cdecl; external CLibCrypto;
  procedure BF_decrypt(data: PBF_LONG; const key: PBF_KEY) cdecl; external CLibCrypto;

  procedure BF_ecb_encrypt(const in_: PByte; out_: PByte; key: PBF_KEY; enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure BF_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure BF_cfb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure BF_ofb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT) cdecl; external CLibCrypto;

  function BF_options: PIdAnsiChar cdecl; external CLibCrypto;

implementation

end.
