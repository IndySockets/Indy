  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_objectserr.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_objectserr.h2pas
     and this file regenerated. IdOpenSSLHeaders_objectserr.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
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

unit IdOpenSSLHeaders_objectserr;

interface

// Headers for OpenSSL 1.1.1
// objectserr.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  (*
   * OBJ function codes.
   *)
  OBJ_F_OBJ_ADD_OBJECT =  105;
  OBJ_F_OBJ_ADD_SIGID =  107;
  OBJ_F_OBJ_CREATE =   100;
  OBJ_F_OBJ_DUP =   101;
  OBJ_F_OBJ_NAME_NEW_INDEX =  106;
  OBJ_F_OBJ_NID2LN =   102;
  OBJ_F_OBJ_NID2OBJ =   103;
  OBJ_F_OBJ_NID2SN =   104;
  OBJ_F_OBJ_TXT2OBJ =   108;

  (*
   * OBJ reason codes.
   *)
  OBJ_R_OID_EXISTS = 102;
  OBJ_R_UNKNOWN_NID = 101;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_OBJ_strings}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  ERR_load_OBJ_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_OBJ_strings: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  

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
  ERR_load_OBJ_strings := LoadFunction('ERR_load_OBJ_strings',AFailed);
end;

procedure Unload;
begin
  ERR_load_OBJ_strings := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
