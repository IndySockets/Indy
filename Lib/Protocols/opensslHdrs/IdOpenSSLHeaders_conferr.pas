  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_conferr.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_conferr.h2pas
     and this file regenerated. IdOpenSSLHeaders_conferr.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_conferr;

interface

// Headers for OpenSSL 1.1.1
// conferr.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  ///*
  // * CONF function codes.
  // */
  CONF_F_CONF_DUMP_FP = 104;
  CONF_F_CONF_LOAD = 100;
  CONF_F_CONF_LOAD_FP = 103;
  CONF_F_CONF_PARSE_LIST = 119;
  CONF_F_DEF_LOAD = 120;
  CONF_F_DEF_LOAD_BIO = 121;
  CONF_F_GET_NEXT_FILE = 107;
  CONF_F_MODULE_ADD = 122;
  CONF_F_MODULE_INIT = 115;
  CONF_F_MODULE_LOAD_DSO = 117;
  CONF_F_MODULE_RUN = 118;
  CONF_F_NCONF_DUMP_BIO = 105;
  CONF_F_NCONF_DUMP_FP = 106;
  CONF_F_NCONF_GET_NUMBER_E = 112;
  CONF_F_NCONF_GET_SECTION = 108;
  CONF_F_NCONF_GET_STRING = 109;
  CONF_F_NCONF_LOAD = 113;
  CONF_F_NCONF_LOAD_BIO = 110;
  CONF_F_NCONF_LOAD_FP = 114;
  CONF_F_NCONF_NEW = 111;
  CONF_F_PROCESS_INCLUDE = 116;
  CONF_F_SSL_MODULE_INIT = 123;
  CONF_F_STR_COPY = 101;

  ///*
  // * CONF reason codes.
  // */
  CONF_R_ERROR_LOADING_DSO = 110;
  CONF_R_LIST_CANNOT_BE_NULL = 115;
  CONF_R_MISSING_CLOSE_SQUARE_BRACKET = 100;
  CONF_R_MISSING_EQUAL_SIGN = 101;
  CONF_R_MISSING_INIT_FUNCTION = 112;
  CONF_R_MODULE_INITIALIZATION_ERROR = 109;
  CONF_R_NO_CLOSE_BRACE = 102;
  CONF_R_NO_CONF = 105;
  CONF_R_NO_CONF_OR_ENVIRONMENT_VARIABLE = 106;
  CONF_R_NO_SECTION = 107;
  CONF_R_NO_SUCH_FILE = 114;
  CONF_R_NO_VALUE = 108;
  CONF_R_NUMBER_TOO_LARGE = 121;
  CONF_R_RECURSIVE_DIRECTORY_INCLUDE = 111;
  CONF_R_SSL_COMMAND_SECTION_EMPTY = 117;
  CONF_R_SSL_COMMAND_SECTION_NOT_FOUND = 118;
  CONF_R_SSL_SECTION_EMPTY = 119;
  CONF_R_SSL_SECTION_NOT_FOUND = 120;
  CONF_R_UNABLE_TO_CREATE_NEW_SECTION = 103;
  CONF_R_UNKNOWN_MODULE_NAME = 113;
  CONF_R_VARIABLE_EXPANSION_TOO_LONG = 116;
  CONF_R_VARIABLE_HAS_NO_VALUE = 104;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_CONF_strings}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  ERR_load_CONF_strings: function: TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_CONF_strings: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  ERR_load_CONF_strings := LoadFunction('ERR_load_CONF_strings',AFailed);
end;

procedure Unload;
begin
  ERR_load_CONF_strings := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
