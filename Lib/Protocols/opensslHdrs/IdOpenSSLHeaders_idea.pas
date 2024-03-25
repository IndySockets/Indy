  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_idea.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_idea.h2pas
     and this file regenerated. IdOpenSSLHeaders_idea.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_idea;

interface

// Headers for OpenSSL 1.1.1
// idea.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  IDEA_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  IDEA_DECRYPT_CONST = 0;

  IDEA_BLOCK      = 8;
  IDEA_KEY_LENGTH = 16;

type
  IDEA_INT = type TIdC_INT;

  idea_key_st = record
    data: array[0..8, 0..5] of IDEA_INT;
  end;
  IDEA_KEY_SCHEDULE = idea_key_st;
  PIDEA_KEY_SCHEDULE = ^IDEA_KEY_SCHEDULE;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM IDEA_options}
  {$EXTERNALSYM IDEA_ecb_encrypt}
  {$EXTERNALSYM IDEA_set_encrypt_key}
  {$EXTERNALSYM IDEA_set_decrypt_key}
  {$EXTERNALSYM IDEA_cbc_encrypt}
  {$EXTERNALSYM IDEA_cfb64_encrypt}
  {$EXTERNALSYM IDEA_ofb64_encrypt}
  {$EXTERNALSYM IDEA_encrypt}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  IDEA_options: function : PIdAnsiChar; cdecl = nil;
  IDEA_ecb_encrypt: procedure (const in_: PByte; out_: PByte; ks: PIDEA_KEY_SCHEDULE); cdecl = nil;
  IDEA_set_encrypt_key: procedure (const key: PByte; ks: PIDEA_KEY_SCHEDULE); cdecl = nil;
  IDEA_set_decrypt_key: procedure (ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE); cdecl = nil;
  IDEA_cbc_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; enc: TIdC_INT); cdecl = nil;
  IDEA_cfb64_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT; enc: TIdC_INT); cdecl = nil;
  IDEA_ofb64_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT); cdecl = nil;
  IDEA_encrypt: procedure (in_: PIdC_LONG; ks: PIDEA_KEY_SCHEDULE); cdecl = nil;

{$ELSE}
  function IDEA_options: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_ecb_encrypt(const in_: PByte; out_: PByte; ks: PIDEA_KEY_SCHEDULE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_set_encrypt_key(const key: PByte; ks: PIDEA_KEY_SCHEDULE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_set_decrypt_key(ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_cfb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_ofb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure IDEA_encrypt(in_: PIdC_LONG; ks: PIDEA_KEY_SCHEDULE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  IDEA_options := LoadFunction('IDEA_options',AFailed);
  IDEA_ecb_encrypt := LoadFunction('IDEA_ecb_encrypt',AFailed);
  IDEA_set_encrypt_key := LoadFunction('IDEA_set_encrypt_key',AFailed);
  IDEA_set_decrypt_key := LoadFunction('IDEA_set_decrypt_key',AFailed);
  IDEA_cbc_encrypt := LoadFunction('IDEA_cbc_encrypt',AFailed);
  IDEA_cfb64_encrypt := LoadFunction('IDEA_cfb64_encrypt',AFailed);
  IDEA_ofb64_encrypt := LoadFunction('IDEA_ofb64_encrypt',AFailed);
  IDEA_encrypt := LoadFunction('IDEA_encrypt',AFailed);
end;

procedure Unload;
begin
  IDEA_options := nil;
  IDEA_ecb_encrypt := nil;
  IDEA_set_encrypt_key := nil;
  IDEA_set_decrypt_key := nil;
  IDEA_cbc_encrypt := nil;
  IDEA_cfb64_encrypt := nil;
  IDEA_ofb64_encrypt := nil;
  IDEA_encrypt := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
