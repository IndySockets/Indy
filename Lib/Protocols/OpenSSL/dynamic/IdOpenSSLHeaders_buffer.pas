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

unit IdOpenSSLHeaders_buffer;

interface

// Headers for OpenSSL 1.1.1
// buffer.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  BUF_MEM_FLAG_SECURE = $01;

type
  buf_mem_st = record
    length: TIdC_SIZET;
    data: PIdAnsiChar;
    max: TIdC_SIZET;
    flags: TIdC_ULONG;
  end;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  BUF_MEM_new: function: PBUF_MEM cdecl = nil;
  BUF_MEM_new_ex: function(flags: TIdC_ULONG): PBUF_MEM cdecl = nil;
  BUF_MEM_free: procedure(a: PBUF_MEM) cdecl = nil;
  BUF_MEM_grow: function(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  BUF_MEM_grow_clean: function(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  BUF_reverse: procedure(&out: PByte; const in_: PByte; siz: TIdC_SIZET) cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  BUF_MEM_new := LoadFunction('BUF_MEM_new', AFailed);
  BUF_MEM_new_ex := LoadFunction('BUF_MEM_new_ex', AFailed);
  BUF_MEM_free := LoadFunction('BUF_MEM_free', AFailed);
  BUF_MEM_grow := LoadFunction('BUF_MEM_grow', AFailed);
  BUF_MEM_grow_clean := LoadFunction('BUF_MEM_grow_clean', AFailed);
  BUF_reverse := LoadFunction('BUF_reverse', AFailed);
end;

procedure UnLoad;
begin
  BUF_MEM_new := nil;
  BUF_MEM_new_ex := nil;
  BUF_MEM_free := nil;
  BUF_MEM_grow := nil;
  BUF_MEM_grow_clean := nil;
  BUF_reverse := nil;
end;

end.
