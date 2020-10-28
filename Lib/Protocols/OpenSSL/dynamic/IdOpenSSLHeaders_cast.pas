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

unit IdOpenSSLHeaders_cast;

interface

// Headers for OpenSSL 1.1.1
// cast.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  CAST_ENCRYPT_CONST =  1;
  CAST_DECRYPT_CONST =  0;
  CAST_BLOCK =  8;
  CAST_KEY_LENGTH = 16;

type
  CAST_LONG = type TIdC_UINT;
  PCAST_LONG = ^CAST_LONG;

  cast_key_st = record
    data: array of CAST_LONG;
    short_key: TIdC_INT;              //* Use reduced rounds for short key */
  end;

  CAST_KEY = cast_key_st;
  PCAST_KEY = ^CAST_KEY;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  CAST_set_key: procedure(key: PCast_Key; len: TIdC_INT; const data: PByte) cdecl = nil;
  CAST_ecb_encrypt: procedure(const in_: PByte; out_: PByte; const key: PCast_Key; enc: TIdC_INT) cdecl = nil;
  CAST_encrypt: procedure(data: PCAST_LONG; const key: PCast_Key) cdecl = nil;
  CAST_decrypt: procedure(data: PCAST_LONG; const key: PCast_Key) cdecl = nil;
  CAST_cbc_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const ks: PCast_Key; iv: PByte; enc: TIdC_INT) cdecl = nil;
  CAST_cfb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl = nil;
  CAST_ofb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT) cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  CAST_set_key := LoadFunction('CAST_set_key', AFailed);
  CAST_ecb_encrypt := LoadFunction('CAST_ecb_encrypt', AFailed);
  CAST_encrypt := LoadFunction('CAST_encrypt', AFailed);
  CAST_decrypt := LoadFunction('CAST_decrypt', AFailed);
  CAST_cbc_encrypt := LoadFunction('CAST_cbc_encrypt', AFailed);
  CAST_cfb64_encrypt := LoadFunction('CAST_cfb64_encrypt', AFailed);
  CAST_ofb64_encrypt := LoadFunction('CAST_ofb64_encrypt', AFailed);
end;

procedure UnLoad;
begin
  CAST_set_key := nil;
  CAST_ecb_encrypt := nil;
  CAST_encrypt := nil;
  CAST_decrypt := nil;
  CAST_cbc_encrypt := nil;
  CAST_cfb64_encrypt := nil;
  CAST_ofb64_encrypt := nil;
end;

end.
