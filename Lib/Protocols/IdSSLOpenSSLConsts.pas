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
{   (c) 1993-2024, the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}
unit IdSSLOpenSSLConsts;

interface

{$i IdCompilerDefines.inc}
{$i IdSSLOpenSSLDefines.inc}
{$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}


const
  {The default SSLLibraryPath is empty. You can override this by setting the
   OPENSSL_LIBRARY_PATH environment variable to the absolute path of the location
   of your openssl library.}

  OpenSSLLibraryPath = 'OPENSSL_LIBRARY_PATH'; {environment variable name}
  {$IFNDEF OPENSSL_NO_MIN_VERSION}
  min_supported_ssl_version =  (((byte(1) shl 8) + byte(0)) shl 8) shl 8 + byte(0); {1.0.0}
  {$ELSE}
  min_supported_ssl_version = 0;
  {$ENDIF}
  CLibCryptoBase = 'libcrypto';
  CLibSSLBase = 'libssl';

  {The following lists are used when trying to locate the libcrypto and libssl libraries.
   Default sufficies can be replaced by setting the IOpenSSLLoader.GetSSLLibVersions property}
  {$IFDEF UNIX}
  CLibCrypto = 'crypto';
  CLibSSL = 'ssl';
  DirListDelimiter = ':';
  LibSuffix = '.so';
  DefaultLibVersions = ':.3:.1.1:.1.0.2:.1.0.0:.0.9.9:.0.9.8:.0.9.7:.0.9.6';
  {$ENDIF}
  {$IFDEF WINDOWS}
  DirListDelimiter = ';';
  LibSuffix = '';
  LegacyLibCrypto = 'libeay32';
  LegacyLibssl = 'ssleay32';

  {This list is a pragmatic solution to the following functions not being present
   in the ssleay and libeay libraries for 1.0.2 distributed on the Indy github
   website}
  LegacyAllowFailed = 'BIO_s_log,ECPKPARAMETERS_it,ECPKPARAMETERS_new,ECPKPARAMETERS_free,'+
                'ECPARAMETERS_it,ECPARAMETERS_new,ECPARAMETERS_free,HMAC_size,HMAC_CTX_reset,HMAC_CTX_get_md';
  {$IFDEF CPU64}
  CLibCrypto = 'libcrypto-3-x64.dll';
  CLibSSL = 'libssl-3-x64.dll';
  DefaultLibVersions = ';-3-x64;-1-x64';
  {$ENDIF}
  {$IFDEF CPU32}
  CLibCrypto = 'libcrypto-3.dll';
  CLibSSL = 'libssl-3.dll';
  DefaultLibVersions = ';-3;-1';
  {$ENDIF}
  {$ENDIF}

implementation

end.
