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

unit IdOpenSSLHeaders_conf_api;

interface

// Headers for OpenSSL 1.1.1
// conf_api.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_conf;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  //* Up until OpenSSL 0.9.5a, this was new_section */
  _CONF_new_section: function(conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was get_section */
  _CONF_get_section: function(const conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was CONF_get_section */
  //STACK_OF(CONF_VALUE) *_CONF_get_section_values(const CONF *conf,
  //                                               const char *section);

  _CONF_add_string: function(conf: PCONF; section: PCONF_VALUE; value: PCONF_VALUE): TIdC_INT cdecl = nil;
  _CONF_get_string: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl = nil;
  _CONF_get_number: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): TIdC_LONG cdecl = nil;

  _CONF_new_data: function(conf: PCONF): TIdC_INT cdecl = nil;
  _CONF_free_data: procedure(conf: PCONF) cdecl = nil;


implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  _CONF_new_section := LoadFunction('_CONF_new_section', AFailed);
  _CONF_get_section := LoadFunction('_CONF_get_section', AFailed);
  _CONF_add_string := LoadFunction('_CONF_add_string', AFailed);
  _CONF_get_string := LoadFunction('_CONF_get_string', AFailed);
  _CONF_get_number := LoadFunction('_CONF_get_number', AFailed);
  _CONF_new_data := LoadFunction('_CONF_new_data', AFailed);
  _CONF_free_data := LoadFunction('_CONF_free_data', AFailed);
end;

procedure UnLoad;
begin
  _CONF_new_section := nil;
  _CONF_get_section := nil;
  _CONF_add_string := nil;
  _CONF_get_string := nil;
  _CONF_get_number := nil;
  _CONF_new_data := nil;
  _CONF_free_data := nil;
end;

end.
