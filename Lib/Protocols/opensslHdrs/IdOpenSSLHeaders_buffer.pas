  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_buffer.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_buffer.h2pas
     and this file regenerated. IdOpenSSLHeaders_buffer.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_buffer;

interface

// Headers for OpenSSL 1.1.1
// buffer.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  BUF_MEM_FLAG_SECURE = $01;

type
  buf_mem_st = record
    length: TIdC_SIZET;
    data: PIdAnsiChar;
    max: TIdC_SIZET;
    flags: TIdC_ULONG;
  end;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM BUF_MEM_new}
  {$EXTERNALSYM BUF_MEM_new_ex}
  {$EXTERNALSYM BUF_MEM_free}
  {$EXTERNALSYM BUF_MEM_grow}
  {$EXTERNALSYM BUF_MEM_grow_clean}
  {$EXTERNALSYM BUF_reverse}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  BUF_MEM_new: function : PBUF_MEM; cdecl = nil;
  BUF_MEM_new_ex: function (flags: TIdC_ULONG): PBUF_MEM; cdecl = nil;
  BUF_MEM_free: procedure (a: PBUF_MEM); cdecl = nil;
  BUF_MEM_grow: function (str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET; cdecl = nil;
  BUF_MEM_grow_clean: function (str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET; cdecl = nil;
  BUF_reverse: procedure (out_: PByte; const in_: PByte; siz: TIdC_SIZET); cdecl = nil;

{$ELSE}
  function BUF_MEM_new: PBUF_MEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function BUF_MEM_new_ex(flags: TIdC_ULONG): PBUF_MEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure BUF_MEM_free(a: PBUF_MEM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function BUF_MEM_grow(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function BUF_MEM_grow_clean(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure BUF_reverse(out_: PByte; const in_: PByte; siz: TIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  BUF_MEM_new := LoadFunction('BUF_MEM_new',AFailed);
  BUF_MEM_new_ex := LoadFunction('BUF_MEM_new_ex',AFailed);
  BUF_MEM_free := LoadFunction('BUF_MEM_free',AFailed);
  BUF_MEM_grow := LoadFunction('BUF_MEM_grow',AFailed);
  BUF_MEM_grow_clean := LoadFunction('BUF_MEM_grow_clean',AFailed);
  BUF_reverse := LoadFunction('BUF_reverse',AFailed);
end;

procedure Unload;
begin
  BUF_MEM_new := nil;
  BUF_MEM_new_ex := nil;
  BUF_MEM_free := nil;
  BUF_MEM_grow := nil;
  BUF_MEM_grow_clean := nil;
  BUF_reverse := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
