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

unit IdOpenSSLHeaders_camellia;

interface

// Headers for OpenSSL 1.1.1
// camellia.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  CAMELLIA_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  CAMELLIA_DECRYPT_CONST = 0;

  CAMELLIA_BLOCK_SIZE = 16;
  CAMELLIA_TABLE_BYTE_LEN = 272;
  CAMELLIA_TABLE_WORD_LEN = CAMELLIA_TABLE_BYTE_LEN div 4;

type
  KEY_TABLE_TYPE = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of TIdC_UINT;

  camellia_key_st_u = record
    case Integer of
    0: (d: TIdC_DOUBLE);
    1: (rd_key: KEY_TABLE_TYPE);
  end;

  camellia_key_st = record
    u: camellia_key_st_u;
    grand_rounds: TIdC_INT;
  end;

  CAMELLIA_KEY = camellia_key_st;
  PCAMELLIA_KEY = ^CAMELLIA_KEY;

  TCamellia_ctr128_encrypt_ivec = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of Byte;
  TCamellia_ctr128_encrypt_ecount_buf = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of Byte;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  Camellia_set_key: function(const userKey: PByte; const bits: TIdC_INT; key: PCAMELLIA_KEY): TIdC_INT cdecl = nil;

  Camellia_encrypt: procedure(const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY) cdecl = nil;
  Camellia_decrypt: procedure(const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY) cdecl = nil;

  Camellia_ecb_encrypt: procedure( const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY; const enc: TIdC_INT) cdecl = nil;
  Camellia_cbc_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;
  Camellia_cfb128_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  Camellia_cfb1_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  Camellia_cfb8_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  Camellia_ofb128_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT) cdecl = nil;
  Camellia_ctr128_encrypt: procedure( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: TCamellia_ctr128_encrypt_ivec; ecount_buf: TCamellia_ctr128_encrypt_ecount_buf; num: PIdC_INT) cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  Camellia_set_key := LoadFunction('Camellia_set_key', AFailed);
  Camellia_encrypt := LoadFunction('Camellia_encrypt', AFailed);
  Camellia_decrypt := LoadFunction('Camellia_decrypt', AFailed);
  Camellia_ecb_encrypt := LoadFunction('Camellia_ecb_encrypt', AFailed);
  Camellia_cbc_encrypt := LoadFunction('Camellia_cbc_encrypt', AFailed);
  Camellia_cfb128_encrypt := LoadFunction('Camellia_cfb128_encrypt', AFailed);
  Camellia_cfb1_encrypt := LoadFunction('Camellia_cfb1_encrypt', AFailed);
  Camellia_cfb8_encrypt := LoadFunction('Camellia_cfb8_encrypt', AFailed);
  Camellia_ofb128_encrypt := LoadFunction('Camellia_ofb128_encrypt', AFailed);
  Camellia_ctr128_encrypt := LoadFunction('Camellia_ctr128_encrypt', AFailed);
end;

procedure UnLoad;
begin
  Camellia_set_key := nil;
  Camellia_encrypt := nil;
  Camellia_decrypt := nil;
  Camellia_ecb_encrypt := nil;
  Camellia_cbc_encrypt := nil;
  Camellia_cfb128_encrypt := nil;
  Camellia_cfb1_encrypt := nil;
  Camellia_cfb8_encrypt := nil;
  Camellia_ofb128_encrypt := nil;
  Camellia_ctr128_encrypt := nil;
end;

end.
