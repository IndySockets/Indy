  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_conf_api.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_conf_api.h2pas
     and this file regenerated. IdOpenSSLHeaders_conf_api.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 

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
{                                                                              }
{******************************************************************************}

unit IdOpenSSLHeaders_conf_api;

interface

// Headers for OpenSSL 1.1.1
// conf_api.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_conf;

  //* Up until OpenSSL 0.9.5a, this was new_section */
    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM _CONF_new_section}
  {$EXTERNALSYM _CONF_get_section}
  {$EXTERNALSYM _CONF_add_string}
  {$EXTERNALSYM _CONF_get_string}
  {$EXTERNALSYM _CONF_get_number}
  {$EXTERNALSYM _CONF_new_data}
  {$EXTERNALSYM _CONF_free_data}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  _CONF_new_section: function(conf: PCONF; const section: PAnsiChar): PCONF_VALUE; cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was get_section */
  _CONF_get_section: function(const conf: PCONF; const section: PAnsiChar): PCONF_VALUE; cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was CONF_get_section */
  //STACK_OF(CONF_VALUE) *_CONF_get_section_values(const CONF *conf,
  //                                               const char *section);

  _CONF_add_string: function(conf: PCONF; section: PCONF_VALUE; value: PCONF_VALUE): TIdC_INT; cdecl = nil;
  _CONF_get_string: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): PAnsiChar; cdecl = nil;
  _CONF_get_number: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): TIdC_LONG; cdecl = nil;

  _CONF_new_data: function(conf: PCONF): TIdC_INT; cdecl = nil;
  _CONF_free_data: procedure(conf: PCONF); cdecl = nil;


{$ELSE}
  function _CONF_new_section(conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //* Up until OpenSSL 0.9.5a, this was get_section */
  function _CONF_get_section(const conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //* Up until OpenSSL 0.9.5a, this was CONF_get_section */
  //STACK_OF(CONF_VALUE) *_CONF_get_section_values(const CONF *conf,
  //                                               const char *section);

  function _CONF_add_string(conf: PCONF; section: PCONF_VALUE; value: PCONF_VALUE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function _CONF_get_string(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function _CONF_get_number(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function _CONF_new_data(conf: PCONF): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure _CONF_free_data(conf: PCONF) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};


{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  _CONF_new_section := LoadFunction('_CONF_new_section',AFailed);
  _CONF_get_section := LoadFunction('_CONF_get_section',AFailed);
  _CONF_add_string := LoadFunction('_CONF_add_string',AFailed);
  _CONF_get_string := LoadFunction('_CONF_get_string',AFailed);
  _CONF_get_number := LoadFunction('_CONF_get_number',AFailed);
  _CONF_new_data := LoadFunction('_CONF_new_data',AFailed);
  _CONF_free_data := LoadFunction('_CONF_free_data',AFailed);
end;

procedure Unload;
begin
  _CONF_new_section := nil;
  _CONF_get_section := nil;
  _CONF_add_string := nil;
  _CONF_get_string := nil;
  _CONF_get_number := nil;
  _CONF_new_data := nil;
  _CONF_free_data := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
