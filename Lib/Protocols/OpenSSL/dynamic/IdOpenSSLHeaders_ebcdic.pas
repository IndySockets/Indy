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

unit IdOpenSSLHeaders_ebcdic;

interface

// Headers for OpenSSL 1.1.1
// ebcdic.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var

  //extern const unsigned char os_toascii[256];
  //extern const unsigned char os_toebcdic[256];

  ebcdic2ascii: function(dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer cdecl = nil;
  ascii2ebcdic: function(dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ebcdic2ascii := LoadFunction('ebcdic2ascii', AFailed);
  ascii2ebcdic := LoadFunction('ascii2ebcdic', AFailed);
end;

procedure UnLoad;
begin
  ebcdic2ascii := nil;
  ascii2ebcdic := nil;
end;

end.
