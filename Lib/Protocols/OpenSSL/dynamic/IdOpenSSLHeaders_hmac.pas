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

unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  HMAC_size: function(const e: PHMAC_CTX): TIdC_SIZET cdecl = nil;
  HMAC_CTX_new: function: PHMAC_CTX cdecl = nil;
  HMAC_CTX_reset: function(ctx: PHMAC_CTX): TIdC_INT cdecl = nil;
  HMAC_CTX_free: procedure(ctx: PHMAC_CTX) cdecl = nil;

  HMAC_Init_ex: function(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT cdecl = nil;
  HMAC_Update: function(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT cdecl = nil;
  HMAC_Final: function(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT cdecl = nil;
  HMAC: function(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte cdecl = nil;
  HMAC_CTX_copy: function(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT cdecl = nil;

  HMAC_CTX_set_flags: procedure(ctx: PHMAC_CTX; flags: TIdC_ULONG) cdecl = nil;
  HMAC_CTX_get_md: function(const ctx: PHMAC_CTX): PEVP_MD cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  HMAC_size := LoadFunction('HMAC_size', AFailed);
  HMAC_CTX_new := LoadFunction('HMAC_CTX_new', AFailed);
  HMAC_CTX_reset := LoadFunction('HMAC_CTX_reset', AFailed);
  HMAC_CTX_free := LoadFunction('HMAC_CTX_free', AFailed);
  HMAC_Init_ex := LoadFunction('HMAC_Init_ex', AFailed);
  HMAC_Update := LoadFunction('HMAC_Update', AFailed);
  HMAC_Final := LoadFunction('HMAC_Final', AFailed);
  HMAC := LoadFunction('HMAC', AFailed);
  HMAC_CTX_copy := LoadFunction('HMAC_CTX_copy', AFailed);
  HMAC_CTX_set_flags := LoadFunction('HMAC_CTX_set_flags', AFailed);
  HMAC_CTX_get_md := LoadFunction('HMAC_CTX_get_md', AFailed);
end;

procedure UnLoad;
begin
  HMAC_size := nil;
  HMAC_CTX_new := nil;
  HMAC_CTX_reset := nil;
  HMAC_CTX_free := nil;
  HMAC_Init_ex := nil;
  HMAC_Update := nil;
  HMAC_Final := nil;
  HMAC := nil;
  HMAC_CTX_copy := nil;
  HMAC_CTX_set_flags := nil;
  HMAC_CTX_get_md := nil;
end;

end.
