  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_ebcdic.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_ebcdic.h2pas
     and this file regenerated. IdOpenSSLHeaders_ebcdic.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_ebcdic;

interface

// Headers for OpenSSL 1.1.1
// ebcdic.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;


  //extern const unsigned char os_toascii[256];
  //extern const unsigned char os_toebcdic[256];

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ebcdic2ascii}
  {$EXTERNALSYM ascii2ebcdic}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  ebcdic2ascii: function (dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer; cdecl = nil;
  ascii2ebcdic: function (dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer; cdecl = nil;

{$ELSE}
  function ebcdic2ascii(dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ascii2ebcdic(dest: Pointer; const srce: Pointer; count: TIdC_SIZET): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  ebcdic2ascii := LoadFunction('ebcdic2ascii',AFailed);
  ascii2ebcdic := LoadFunction('ascii2ebcdic',AFailed);
end;

procedure Unload;
begin
  ebcdic2ascii := nil;
  ascii2ebcdic := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
