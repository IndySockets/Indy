  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_rc4.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_rc4.h2pas
     and this file regenerated. IdOpenSSLHeaders_rc4.h2pas is distributed with the full Indy
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
unit IdOpenSSLHeaders_rc4;

interface

{
  Automatically converted by H2Pas 1.0.0 from rc4.h
  The following command line parameters were used:
    rc4.h
}

uses
  IdCTypes,
  IdGlobal;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  { crypto/rc4/rc4.h  }
  { Copyright (C) 1995-1997 Eric Young (eay@cryptsoft.com)
   * All rights reserved.
   *
   * This package is an SSL implementation written
   * by Eric Young (eay@cryptsoft.com).
   * The implementation was written so as to conform with Netscapes SSL.
   *
   * This library is free for commercial and non-commercial use as long as
   * the following conditions are aheared to.  The following conditions
   * apply to all code found in this distribution, be it the RC4, RSA,
   * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
   * included with this distribution is covered by the same copyright terms
   * except that the holder is Tim Hudson (tjh@cryptsoft.com).
   *
   * Copyright remains Eric Young's, and as such any Copyright notices in
   * the code are not to be removed.
   * If this package is used in a product, Eric Young should be given attribution
   * as the author of the parts of the library used.
   * This can be in the form of a textual message at program startup or
   * in documentation (online or textual) provided with the package.
   *
   * Redistribution and use in source and binary forms, with or without
   * modification, are permitted provided that the following conditions
   * are met:
   * 1. Redistributions of source code must retain the copyright
   *    notice, this list of conditions and the following disclaimer.
   * 2. Redistributions in binary form must reproduce the above copyright
   *    notice, this list of conditions and the following disclaimer in the
   *    documentation and/or other materials provided with the distribution.
   * 3. All advertising materials mentioning features or use of this software
   *    must display the following acknowledgement:
   *    "This product includes cryptographic software written by
   *     Eric Young (eay@cryptsoft.com)"
   *    The word 'cryptographic' can be left out if the rouines from the library
   *    being used are not cryptographic related :-).
   * 4. If you include any Windows specific code (or a derivative thereof) from
   *    the apps directory (application code) you must include an acknowledgement:
   *    "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
   *
   * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
   * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
   * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
   * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
   * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
   * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
   * SUCH DAMAGE.
   *
   * The licence and distribution terms for any publically available version or
   * derivative of this code cannot be changed.  i.e. this code cannot simply be
   * copied and put under another distribution licence
   * [including the GNU Public Licence.]
    }

  type
    PRC4_KEY  = ^RC4_KEY;
    RC4_INT = TIdC_UINT;
    rc4_key_st = record
        x : RC4_INT;
        y : RC4_INT;
        data : array[0..255] of RC4_INT;
      end;
    RC4_KEY = rc4_key_st;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM RC4_options} {allow_nil}
  {$EXTERNALSYM RC4_set_key} {allow_nil}
  {$EXTERNALSYM private_RC4_set_key} {allow_nil}
  {$EXTERNALSYM RC4} {allow_nil}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  RC4_options: function : PIdAnsiChar; cdecl = nil; {allow_nil}
  RC4_set_key: procedure (key:PRC4_KEY; len: TIdC_LONG; const data:Pbyte); cdecl = nil; {allow_nil}
  private_RC4_set_key: procedure (key:PRC4_KEY; len: TIdC_LONG; const data:Pbyte); cdecl = nil; {allow_nil}
  RC4: procedure (key:PRC4_KEY; len: TIdC_SIZET; const indata: Pbyte; outdata: Pbyte); cdecl = nil; {allow_nil}

{$ELSE}
{interface_body}
{$IFNDEF OPENSSL_NO_RC4}
  function RC4_options: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; 
  procedure RC4_set_key(key:PRC4_KEY; len: TIdC_LONG; const data:Pbyte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; 
  procedure private_RC4_set_key(key:PRC4_KEY; len: TIdC_LONG; const data:Pbyte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; 
  procedure RC4(key:PRC4_KEY; len: TIdC_SIZET; const indata: Pbyte; outdata: Pbyte) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; 
{$ENDIF}

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
  RC4_options := LoadFunction('RC4_options',nil); {allow_nil}
  RC4_set_key := LoadFunction('RC4_set_key',nil); {allow_nil}
  private_RC4_set_key := LoadFunction('private_RC4_set_key',nil); {allow_nil}
  RC4 := LoadFunction('RC4',nil); {allow_nil}
end;

procedure Unload;
begin
  RC4_options := nil; {allow_nil}
  RC4_set_key := nil; {allow_nil}
  private_RC4_set_key := nil; {allow_nil}
  RC4 := nil; {allow_nil}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
