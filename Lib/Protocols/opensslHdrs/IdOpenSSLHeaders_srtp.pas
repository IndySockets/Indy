  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_srtp.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_srtp.h2pas
     and this file regenerated. IdOpenSSLHeaders_srtp.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_srtp;

interface

// Headers for OpenSSL 1.1.1
// srtp.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_ssl;

const
  SRTP_AES128_CM_SHA1_80 = $0001;
  SRTP_AES128_CM_SHA1_32 = $0002;
  SRTP_AES128_F8_SHA1_80 = $0003;
  SRTP_AES128_F8_SHA1_32 = $0004;
  SRTP_NULL_SHA1_80      = $0005;
  SRTP_NULL_SHA1_32      = $0006;

  (* AEAD SRTP protection profiles from RFC 7714 *)
  SRTP_AEAD_AES_128_GCM = $0007;
  SRTP_AEAD_AES_256_GCM = $0008;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM SSL_CTX_set_tlsext_use_srtp}
  {$EXTERNALSYM SSL_set_tlsext_use_srtp}
  {$EXTERNALSYM SSL_get_selected_srtp_profile}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  SSL_CTX_set_tlsext_use_srtp: function (ctx: PSSL_CTX; const profiles: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_set_tlsext_use_srtp: function (ctx: PSSL_CTX; const profiles: PIdAnsiChar): TIdC_INT; cdecl = nil;

  //function SSL_get_srtp_profiles(s: PSSL): PSTACK_OF_SRTP_PROTECTION_PROFILE;
  SSL_get_selected_srtp_profile: function (s: PSSL): PSRTP_PROTECTION_PROFILE; cdecl = nil;

{$ELSE}
  function SSL_CTX_set_tlsext_use_srtp(ctx: PSSL_CTX; const profiles: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function SSL_set_tlsext_use_srtp(ctx: PSSL_CTX; const profiles: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  //function SSL_get_srtp_profiles(s: PSSL): PSTACK_OF_SRTP_PROTECTION_PROFILE;
  function SSL_get_selected_srtp_profile(s: PSSL): PSRTP_PROTECTION_PROFILE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  SSL_CTX_set_tlsext_use_srtp := LoadFunction('SSL_CTX_set_tlsext_use_srtp',AFailed);
  SSL_set_tlsext_use_srtp := LoadFunction('SSL_set_tlsext_use_srtp',AFailed);
  SSL_get_selected_srtp_profile := LoadFunction('SSL_get_selected_srtp_profile',AFailed);
end;

procedure Unload;
begin
  SSL_CTX_set_tlsext_use_srtp := nil;
  SSL_set_tlsext_use_srtp := nil;
  SSL_get_selected_srtp_profile := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
