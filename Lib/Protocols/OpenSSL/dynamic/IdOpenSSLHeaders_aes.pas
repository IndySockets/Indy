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

unit IdOpenSSLHeaders_aes;

interface

// Headers for OpenSSL 1.1.1
// aes.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  AES_options: function: PIdAnsiChar cdecl = nil;

  AES_set_encrypt_key: function(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl = nil;
  AES_set_decrypt_key: function(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl = nil;

  AES_encrypt: procedure(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl = nil;
  AES_decrypt: procedure(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl = nil;

  AES_ecb_encrypt: procedure(const in_: PByte; out_: PByte; const key: PAES_KEY; const enc: TIdC_INT) cdecl = nil;
  AES_cbc_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;
  AES_cfb128_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_cfb1_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_cfb8_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_ofb128_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT) cdecl = nil;
  (* NB: the IV is _two_ blocks long *)
  AES_ige_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;
  (* NB: the IV is _four_ blocks long *)
  AES_bi_ige_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; const key2: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;

  AES_wrap_key: function(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl = nil;
  AES_unwrap_key: function(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  AES_options := LoadFunction('AES_options', AFailed);
  AES_set_encrypt_key := LoadFunction('AES_set_encrypt_key', AFailed);
  AES_set_decrypt_key := LoadFunction('AES_set_decrypt_key', AFailed);
  AES_encrypt := LoadFunction('AES_encrypt', AFailed);
  AES_decrypt := LoadFunction('AES_decrypt', AFailed);
  AES_ecb_encrypt := LoadFunction('AES_ecb_encrypt', AFailed);
  AES_cbc_encrypt := LoadFunction('AES_cbc_encrypt', AFailed);
  AES_cfb128_encrypt := LoadFunction('AES_cfb128_encrypt', AFailed);
  AES_cfb1_encrypt := LoadFunction('AES_cfb1_encrypt', AFailed);
  AES_cfb8_encrypt := LoadFunction('AES_cfb8_encrypt', AFailed);
  AES_ofb128_encrypt := LoadFunction('AES_ofb128_encrypt', AFailed);
  AES_ige_encrypt := LoadFunction('AES_ige_encrypt', AFailed);
  AES_bi_ige_encrypt := LoadFunction('AES_bi_ige_encrypt', AFailed);
  AES_wrap_key := LoadFunction('AES_wrap_key', AFailed);
  AES_unwrap_key := LoadFunction('AES_unwrap_key', AFailed);
end;

procedure UnLoad;
begin
  AES_options := nil;
  AES_set_encrypt_key := nil;
  AES_set_decrypt_key := nil;
  AES_encrypt := nil;
  AES_decrypt := nil;
  AES_ecb_encrypt := nil;
  AES_cbc_encrypt := nil;
  AES_cfb128_encrypt := nil;
  AES_cfb1_encrypt := nil;
  AES_cfb8_encrypt := nil;
  AES_ofb128_encrypt := nil;
  AES_ige_encrypt := nil;
  AES_bi_ige_encrypt := nil;
  AES_wrap_key := nil;
  AES_unwrap_key := nil;
end;

end.
