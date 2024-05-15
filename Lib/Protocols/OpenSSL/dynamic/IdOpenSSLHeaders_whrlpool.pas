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

unit IdOpenSSLHeaders_whrlpool;

interface

// Headers for OpenSSL 1.1.1
// whrlpool.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  WHIRLPOOL_DIGEST_LENGTH = 512 div 8;
  WHIRLPOOL_BBLOCK = 512;
  WHIRLPOOL_COUNTER = 256 div 8;

type
  WHIRLPOOL_CTX_union = record
    case Byte of
      0: (c: array[0 .. WHIRLPOOL_DIGEST_LENGTH -1] of Byte);
      (* double q is here to ensure 64-bit alignment *)
      1: (q: array[0 .. (WHIRLPOOL_DIGEST_LENGTH div SizeOf(TIdC_DOUBLE)) -1] of TIdC_DOUBLE);
  end;
  WHIRLPOOL_CTX = record
    H: WHIRLPOOL_CTX_union;
    data: array[0 .. (WHIRLPOOL_BBLOCK div 8) -1] of Byte;
    bitoff: TIdC_UINT;
    bitlen: array[0 .. (WHIRLPOOL_COUNTER div SizeOf(TIdC_SIZET)) -1] of TIdC_SIZET;
  end;
  PWHIRLPOOL_CTX = ^WHIRLPOOL_CTX;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  WHIRLPOOL_Init: function(c: PWHIRLPOOL_CTX): TIdC_INT cdecl = nil;
  WHIRLPOOL_Update: function(c: PWHIRLPOOL_CTX; inp: Pointer; bytes: TIdC_SIZET): TIdC_INT cdecl = nil;
  WHIRLPOOL_BitUpdate: procedure(c: PWHIRLPOOL_CTX; inp: Pointer; bits: TIdC_SIZET) cdecl = nil;
  WHIRLPOOL_Final: function(md: PByte; c: PWHIRLPOOL_CTX): TIdC_INT cdecl = nil;
  WHIRLPOOL: function(inp: Pointer; bytes: TIdC_SIZET; md: PByte): PByte cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  WHIRLPOOL_Init := LoadFunction('WHIRLPOOL_Init', AFailed);
  WHIRLPOOL_Update := LoadFunction('WHIRLPOOL_Update', AFailed);
  WHIRLPOOL_BitUpdate := LoadFunction('WHIRLPOOL_BitUpdate', AFailed);
  WHIRLPOOL_Final := LoadFunction('WHIRLPOOL_Final', AFailed);
  WHIRLPOOL := LoadFunction('WHIRLPOOL', AFailed);
end;

procedure UnLoad;
begin
  WHIRLPOOL_Init := nil;
  WHIRLPOOL_Update := nil;
  WHIRLPOOL_BitUpdate := nil;
  WHIRLPOOL_Final := nil;
  WHIRLPOOL := nil;
end;

end.
