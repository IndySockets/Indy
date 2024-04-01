  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_camellia.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_camellia.h2pas
     and this file regenerated. IdOpenSSLHeaders_camellia.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_camellia;

interface

// Headers for OpenSSL 1.1.1
// camellia.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  CAMELLIA_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  CAMELLIA_DECRYPT_CONST = 0;

  CAMELLIA_BLOCK_SIZE = 16;
  CAMELLIA_TABLE_BYTE_LEN = 272;
  CAMELLIA_TABLE_WORD_LEN = CAMELLIA_TABLE_BYTE_LEN div 4;

type
  KEY_TABLE_TYPE = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of TIdC_UINT;

  camellia_key_st_u = record
    case Integer of
    0: (d: TIdC_DOUBLE);
    1: (rd_key: KEY_TABLE_TYPE);
  end;

  camellia_key_st = record
    u: camellia_key_st_u;
    grand_rounds: TIdC_INT;
  end;

  CAMELLIA_KEY = camellia_key_st;
  PCAMELLIA_KEY = ^CAMELLIA_KEY;

  TCamellia_ctr128_encrypt_ivec = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of Byte;
  TCamellia_ctr128_encrypt_ecount_buf = array[0 .. CAMELLIA_TABLE_WORD_LEN - 1] of Byte;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM Camellia_set_key}
  {$EXTERNALSYM Camellia_encrypt}
  {$EXTERNALSYM Camellia_decrypt}
  {$EXTERNALSYM Camellia_ecb_encrypt}
  {$EXTERNALSYM Camellia_cbc_encrypt}
  {$EXTERNALSYM Camellia_cfb128_encrypt}
  {$EXTERNALSYM Camellia_cfb1_encrypt}
  {$EXTERNALSYM Camellia_cfb8_encrypt}
  {$EXTERNALSYM Camellia_ofb128_encrypt}
  {$EXTERNALSYM Camellia_ctr128_encrypt}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  Camellia_set_key: function (const userKey: PByte; const bits: TIdC_INT; key: PCAMELLIA_KEY): TIdC_INT; cdecl = nil;

  Camellia_encrypt: procedure (const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY); cdecl = nil;
  Camellia_decrypt: procedure (const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY); cdecl = nil;

  Camellia_ecb_encrypt: procedure ( const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY; const enc: TIdC_INT); cdecl = nil;
  Camellia_cbc_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; const enc: TIdC_INT); cdecl = nil;
  Camellia_cfb128_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  Camellia_cfb1_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  Camellia_cfb8_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT); cdecl = nil;
  Camellia_ofb128_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT); cdecl = nil;
  Camellia_ctr128_encrypt: procedure ( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: TCamellia_ctr128_encrypt_ivec; ecount_buf: TCamellia_ctr128_encrypt_ecount_buf; num: PIdC_INT); cdecl = nil;

{$ELSE}
  function Camellia_set_key(const userKey: PByte; const bits: TIdC_INT; key: PCAMELLIA_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure Camellia_encrypt(const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_decrypt(const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure Camellia_ecb_encrypt( const in_: PByte; const out_: PByte; const key: PCAMELLIA_KEY; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_cbc_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_cfb128_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_cfb1_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_cfb8_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_ofb128_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: PByte; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure Camellia_ctr128_encrypt( const in_: PByte; const out_: PByte; length: TIdC_SIZET; const key: PCAMELLIA_KEY; ivec: TCamellia_ctr128_encrypt_ivec; ecount_buf: TCamellia_ctr128_encrypt_ecount_buf; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  Camellia_set_key := LoadFunction('Camellia_set_key',AFailed);
  Camellia_encrypt := LoadFunction('Camellia_encrypt',AFailed);
  Camellia_decrypt := LoadFunction('Camellia_decrypt',AFailed);
  Camellia_ecb_encrypt := LoadFunction('Camellia_ecb_encrypt',AFailed);
  Camellia_cbc_encrypt := LoadFunction('Camellia_cbc_encrypt',AFailed);
  Camellia_cfb128_encrypt := LoadFunction('Camellia_cfb128_encrypt',AFailed);
  Camellia_cfb1_encrypt := LoadFunction('Camellia_cfb1_encrypt',AFailed);
  Camellia_cfb8_encrypt := LoadFunction('Camellia_cfb8_encrypt',AFailed);
  Camellia_ofb128_encrypt := LoadFunction('Camellia_ofb128_encrypt',AFailed);
  Camellia_ctr128_encrypt := LoadFunction('Camellia_ctr128_encrypt',AFailed);
end;

procedure Unload;
begin
  Camellia_set_key := nil;
  Camellia_encrypt := nil;
  Camellia_decrypt := nil;
  Camellia_ecb_encrypt := nil;
  Camellia_cbc_encrypt := nil;
  Camellia_cfb128_encrypt := nil;
  Camellia_cfb1_encrypt := nil;
  Camellia_cfb8_encrypt := nil;
  Camellia_ofb128_encrypt := nil;
  Camellia_ctr128_encrypt := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
