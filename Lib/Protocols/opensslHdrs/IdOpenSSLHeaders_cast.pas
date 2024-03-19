  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_cast.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_cast.h2pas
     and this file regenerated. IdOpenSSLHeaders_cast.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_cast;

interface

// Headers for OpenSSL 1.1.1
// cast.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

const
  CAST_ENCRYPT_CONST =  1;
  CAST_DECRYPT_CONST =  0;
  CAST_BLOCK =  8;
  CAST_KEY_LENGTH = 16;

type
  CAST_LONG = type TIdC_UINT;
  PCAST_LONG = ^CAST_LONG;

  cast_key_st = record
    data: array of CAST_LONG;
    short_key: TIdC_INT;              //* Use reduced rounds for short key */
  end;

  CAST_KEY = cast_key_st;
  PCAST_KEY = ^CAST_KEY;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM CAST_set_key}
  {$EXTERNALSYM CAST_ecb_encrypt}
  {$EXTERNALSYM CAST_encrypt}
  {$EXTERNALSYM CAST_decrypt}
  {$EXTERNALSYM CAST_cbc_encrypt}
  {$EXTERNALSYM CAST_cfb64_encrypt}
  {$EXTERNALSYM CAST_ofb64_encrypt}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  CAST_set_key: procedure(key: PCast_Key; len: TIdC_INT; const data: PByte); cdecl = nil;
  CAST_ecb_encrypt: procedure(const in_: PByte; out_: PByte; const key: PCast_Key; enc: TIdC_INT); cdecl = nil;
  CAST_encrypt: procedure(data: PCAST_LONG; const key: PCast_Key); cdecl = nil;
  CAST_decrypt: procedure(data: PCAST_LONG; const key: PCast_Key); cdecl = nil;
  CAST_cbc_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const ks: PCast_Key; iv: PByte; enc: TIdC_INT); cdecl = nil;
  CAST_cfb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT; enc: TIdC_INT); cdecl = nil;
  CAST_ofb64_encrypt: procedure(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT); cdecl = nil;

{$ELSE}
  procedure CAST_set_key(key: PCast_Key; len: TIdC_INT; const data: PByte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_ecb_encrypt(const in_: PByte; out_: PByte; const key: PCast_Key; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_encrypt(data: PCAST_LONG; const key: PCast_Key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_decrypt(data: PCAST_LONG; const key: PCast_Key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_cbc_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; const ks: PCast_Key; iv: PByte; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_cfb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CAST_ofb64_encrypt(const in_: PByte; out_: PByte; length: TIdC_LONG; const schedule: PCast_Key; ivec: PByte; num: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  CAST_set_key := LoadFunction('CAST_set_key',AFailed);
  CAST_ecb_encrypt := LoadFunction('CAST_ecb_encrypt',AFailed);
  CAST_encrypt := LoadFunction('CAST_encrypt',AFailed);
  CAST_decrypt := LoadFunction('CAST_decrypt',AFailed);
  CAST_cbc_encrypt := LoadFunction('CAST_cbc_encrypt',AFailed);
  CAST_cfb64_encrypt := LoadFunction('CAST_cfb64_encrypt',AFailed);
  CAST_ofb64_encrypt := LoadFunction('CAST_ofb64_encrypt',AFailed);
end;

procedure Unload;
begin
  CAST_set_key := nil;
  CAST_ecb_encrypt := nil;
  CAST_encrypt := nil;
  CAST_decrypt := nil;
  CAST_cbc_encrypt := nil;
  CAST_cfb64_encrypt := nil;
  CAST_ofb64_encrypt := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
