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

unit IdOpenSSLHeaders_aes;

interface

// Headers for OpenSSL 1.1.1
// aes.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
// Added '_CONST' to avoid name clashes
  AES_ENCRYPT_CONST = 1;
// Added '_CONST' to avoid name clashes
  AES_DECRYPT_CONST = 0;
  AES_MAXNR = 14;
  AES_BLOCK_SIZE = 16;

type
  aes_key_st = record
  // in old IdSSLOpenSSLHeaders.pas it was also TIdC_UINT ¯\_(ツ)_/¯
//    {$IFDEF AES_LONG}
//    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_ULONG;
//    {$ELSE}
    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_UINT;
//    {$ENDIF}
    rounds: TIdC_INT;
  end;
  AES_KEY = aes_key_st;
  PAES_KEY = ^AES_KEY;

  function AES_options: PIdAnsiChar cdecl; external CLibCrypto;

  function AES_set_encrypt_key(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl; external CLibCrypto;
  function AES_set_decrypt_key(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl; external CLibCrypto;

  procedure AES_encrypt(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl; external CLibCrypto;
  procedure AES_decrypt(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl; external CLibCrypto;

  procedure AES_ecb_encrypt(const in_: PByte; out_: PByte; const key: PAES_KEY; const enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure AES_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure AES_cfb128_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure AES_cfb1_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure AES_cfb8_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external CLibCrypto;
  procedure AES_ofb128_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT) cdecl; external CLibCrypto;
  (* NB: the IV is _two_ blocks long *)
  procedure AES_ige_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external CLibCrypto;
  (* NB: the IV is _four_ blocks long *)
  procedure AES_bi_ige_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; const key2: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external CLibCrypto;

  function AES_wrap_key(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function AES_unwrap_key(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl; external CLibCrypto;

implementation

end.
