  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_aes.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_aes.h2pas
     and this file regenerated. IdOpenSSLHeaders_aes.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_aes;

interface

// Headers for OpenSSL 1.1.1
// aes.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
// Added '_CONST' to avoid name clashes
  AES_ENCRYPT_CONST = 1;
// Added '_CONST' to avoid name clashes
  AES_DECRYPT_CONST = 0;
  AES_MAXNR = 14;
  AES_BLOCK_SIZE = 16;

type
  aes_key_st = record
  // in old IdSSLOpenSSLHeaders.pas it was also TIdC_UINT ¯\_(ツ)_/¯
//    {$IFDEF AES_LONG}
//    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_ULONG;
//    {$ELSE}
    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_UINT;
//    {$ENDIF}
    rounds: TIdC_INT;
  end;
  AES_KEY = aes_key_st;
  PAES_KEY = ^AES_KEY;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM AES_options}
  {$EXTERNALSYM AES_set_encrypt_key}
  {$EXTERNALSYM AES_set_decrypt_key}
  {$EXTERNALSYM AES_encrypt}
  {$EXTERNALSYM AES_decrypt}
  {$EXTERNALSYM AES_ecb_encrypt}
  {$EXTERNALSYM AES_cbc_encrypt}
  {$EXTERNALSYM AES_cfb128_encrypt}
  {$EXTERNALSYM AES_cfb1_encrypt}
  {$EXTERNALSYM AES_cfb8_encrypt}
  {$EXTERNALSYM AES_ofb128_encrypt}
  {$EXTERNALSYM AES_ige_encrypt}
  {$EXTERNALSYM AES_bi_ige_encrypt}
  {$EXTERNALSYM AES_wrap_key}
  {$EXTERNALSYM AES_unwrap_key}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  AES_options: function : PIdAnsiChar; cdecl = nil;

  AES_set_encrypt_key: function (const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT; cdecl = nil;
  AES_set_decrypt_key: function (const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT; cdecl = nil;

  AES_encrypt: procedure (const in_: PByte; out_: PByte; const key: PAES_KEY); cdecl = nil;
  AES_decrypt: procedure (const in_: PByte; out_: PByte; const key: PAES_KEY); cdecl = nil;

  AES_ecb_encrypt: procedure (const in_: PByte; out_: PByte; const key: PAES_KEY; const enc: TIdC_INT); cdecl = nil;
  AES_cbc_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT); cdecl = nil;
  AES_cfb128_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  AES_cfb1_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  AES_cfb8_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  AES_ofb128_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT); cdecl = nil;
  (* NB: the IV is _two_ blocks long *)
  AES_ige_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT); cdecl = nil;
  (* NB: the IV is _four_ blocks long *)
  AES_bi_ige_encrypt: procedure (const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; const key2: PAES_KEY; ivec: PByte; const enc: TIdC_INT); cdecl = nil;

  AES_wrap_key: function (key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT; cdecl = nil;
  AES_unwrap_key: function (key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT; cdecl = nil;

{$ELSE}
  function AES_options: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function AES_set_encrypt_key(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function AES_set_decrypt_key(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure AES_encrypt(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_decrypt(const in_: PByte; out_: PByte; const key: PAES_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure AES_ecb_encrypt(const in_: PByte; out_: PByte; const key: PAES_KEY; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_cfb128_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_cfb1_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_cfb8_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure AES_ofb128_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  (* NB: the IV is _two_ blocks long *)
  procedure AES_ige_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  (* NB: the IV is _four_ blocks long *)
  procedure AES_bi_ige_encrypt(const in_: PByte; out_: PByte; length: TIdC_SIZET; const key: PAES_KEY; const key2: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function AES_wrap_key(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function AES_unwrap_key(key: PAES_KEY; const iv: PByte; out_: PByte; const in_: PByte; inlen: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  AES_options := LoadFunction('AES_options',AFailed);
  AES_set_encrypt_key := LoadFunction('AES_set_encrypt_key',AFailed);
  AES_set_decrypt_key := LoadFunction('AES_set_decrypt_key',AFailed);
  AES_encrypt := LoadFunction('AES_encrypt',AFailed);
  AES_decrypt := LoadFunction('AES_decrypt',AFailed);
  AES_ecb_encrypt := LoadFunction('AES_ecb_encrypt',AFailed);
  AES_cbc_encrypt := LoadFunction('AES_cbc_encrypt',AFailed);
  AES_cfb128_encrypt := LoadFunction('AES_cfb128_encrypt',AFailed);
  AES_cfb1_encrypt := LoadFunction('AES_cfb1_encrypt',AFailed);
  AES_cfb8_encrypt := LoadFunction('AES_cfb8_encrypt',AFailed);
  AES_ofb128_encrypt := LoadFunction('AES_ofb128_encrypt',AFailed);
  AES_ige_encrypt := LoadFunction('AES_ige_encrypt',AFailed);
  AES_bi_ige_encrypt := LoadFunction('AES_bi_ige_encrypt',AFailed);
  AES_wrap_key := LoadFunction('AES_wrap_key',AFailed);
  AES_unwrap_key := LoadFunction('AES_unwrap_key',AFailed);
end;

procedure Unload;
begin
  AES_options := nil;
  AES_set_encrypt_key := nil;
  AES_set_decrypt_key := nil;
  AES_encrypt := nil;
  AES_decrypt := nil;
  AES_ecb_encrypt := nil;
  AES_cbc_encrypt := nil;
  AES_cfb128_encrypt := nil;
  AES_cfb1_encrypt := nil;
  AES_cfb8_encrypt := nil;
  AES_ofb128_encrypt := nil;
  AES_ige_encrypt := nil;
  AES_bi_ige_encrypt := nil;
  AES_wrap_key := nil;
  AES_unwrap_key := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
