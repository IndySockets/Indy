  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_blowfish.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_blowfish.h2pas
     and this file regenerated. IdOpenSSLHeaders_blowfish.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_blowfish;

interface

// Headers for OpenSSL 1.1.1
// blowfish.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  BF_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  BF_DECRYPT_CONST = 0;

  BF_ROUNDS = 16;
  BF_BLOCK  = 8;

type
  BF_LONG = TIdC_UINT;
  PBF_LONG = ^BF_LONG;

  bf_key_st = record
    p: array[0 .. BF_ROUNDS + 2 - 1] of BF_LONG;
    s: array[0 .. 4 * 256 - 1] of BF_LONG;
  end;
  BF_KEY = bf_key_st;
  PBF_KEY = ^BF_KEY;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM BF_set_key}
  {$EXTERNALSYM BF_encrypt}
  {$EXTERNALSYM BF_decrypt}
  {$EXTERNALSYM BF_ecb_encrypt}
  {$EXTERNALSYM BF_cbc_encrypt}
  {$EXTERNALSYM BF_cfb64_encrypt}
  {$EXTERNALSYM BF_ofb64_encrypt}
  {$EXTERNALSYM BF_options}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  BF_set_key: procedure(key: PBF_KEY; len: TIdC_INT; const data: PByte); cdecl = nil;

  BF_encrypt: procedure(data: PBF_LONG; const key: PBF_KEY); cdecl = nil;
  BF_decrypt: procedure(data: PBF_LONG; const key: PBF_KEY); cdecl = nil;

  BF_ecb_encrypt: procedure(const in_: PByte; out_: PByte; key: PBF_KEY; enc: TIdC_INT); cdecl = nil;
  BF_cbc_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; enc: TIdC_INT); cdecl = nil;
  BF_cfb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT; enc: TIdC_INT); cdecl = nil;
  BF_ofb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT); cdecl = nil;

  BF_options: function: PIdAnsiChar; cdecl = nil;

{$ELSE}
  procedure BF_set_key(key: PBF_KEY; len: TIdC_INT; const data: PByte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure BF_encrypt(data: PBF_LONG; const key: PBF_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BF_decrypt(data: PBF_LONG; const key: PBF_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure BF_ecb_encrypt(const in_: PByte; out_: PByte; key: PBF_KEY; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BF_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BF_cfb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BF_ofb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BF_options: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  BF_set_key := LoadFunction('BF_set_key',AFailed);
  BF_encrypt := LoadFunction('BF_encrypt',AFailed);
  BF_decrypt := LoadFunction('BF_decrypt',AFailed);
  BF_ecb_encrypt := LoadFunction('BF_ecb_encrypt',AFailed);
  BF_cbc_encrypt := LoadFunction('BF_cbc_encrypt',AFailed);
  BF_cfb64_encrypt := LoadFunction('BF_cfb64_encrypt',AFailed);
  BF_ofb64_encrypt := LoadFunction('BF_ofb64_encrypt',AFailed);
  BF_options := LoadFunction('BF_options',AFailed);
end;

procedure Unload;
begin
  BF_set_key := nil;
  BF_encrypt := nil;
  BF_decrypt := nil;
  BF_ecb_encrypt := nil;
  BF_cbc_encrypt := nil;
  BF_cfb64_encrypt := nil;
  BF_ofb64_encrypt := nil;
  BF_options := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
