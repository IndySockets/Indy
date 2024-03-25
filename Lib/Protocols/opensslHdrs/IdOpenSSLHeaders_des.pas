  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_des.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_des.h2pas
     and this file regenerated. IdOpenSSLHeaders_des.h2pas is distributed with the full Indy
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


unit IdOpenSSLHeaders_des;

interface


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts;

{
  Automatically converted by H2Pas 1.0.0 from des.h
  The following command line parameters were used:
    des.h
}

    Type
    DES_LONG = type cardinal;
    Pconst_DES_cblock  = ^const_DES_cblock;
    PDES_cblock  = ^DES_cblock;
    PDES_key_schedule  = ^DES_key_schedule;
    PDES_LONG  = ^DES_LONG;


     DES_cblock = array[0..7] of byte;
    { const  }
      const_DES_cblock = array[0..7] of byte;
    {
     * With "const", gcc 2.8.1 on Solaris thinks that DES_cblock * and
     * const_DES_cblock * are incompatible pointer types.
      }
    {
             * make sure things are correct size on machines with 8 byte longs
              }

      DES_ks = record
          ks : array[0..15] of record
              case longint of
                0 : ( cblock : DES_cblock );
                1 : ( deslong : array[0..1] of DES_LONG );
              end;
        end;
      DES_key_schedule = DES_ks;

var
  DES_check_key : longint;


    const
      DES_ENCRYPT = 1;
      DES_DECRYPT = 0;
      DES_CBC_MODE = 0;
      DES_PCBC_MODE = 1;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM DES_options}
  {$EXTERNALSYM DES_ecb3_encrypt}
  {$EXTERNALSYM DES_cbc_cksum}
  {$EXTERNALSYM DES_cbc_encrypt}
  {$EXTERNALSYM DES_ncbc_encrypt}
  {$EXTERNALSYM DES_xcbc_encrypt}
  {$EXTERNALSYM DES_cfb_encrypt}
  {$EXTERNALSYM DES_ecb_encrypt} 
  {$EXTERNALSYM DES_encrypt1}
  {$EXTERNALSYM DES_encrypt2}
  {$EXTERNALSYM DES_encrypt3}
  {$EXTERNALSYM DES_decrypt3}
  {$EXTERNALSYM DES_ede3_cbc_encrypt}
  {$EXTERNALSYM DES_ede3_cfb64_encrypt}
  {$EXTERNALSYM DES_ede3_cfb_encrypt}
  {$EXTERNALSYM DES_ede3_ofb64_encrypt}
  {$EXTERNALSYM DES_fcrypt}
  {$EXTERNALSYM DES_crypt}
  {$EXTERNALSYM DES_ofb_encrypt}
  {$EXTERNALSYM DES_pcbc_encrypt}
  {$EXTERNALSYM DES_quad_cksum}
  {$EXTERNALSYM DES_random_key}
  {$EXTERNALSYM DES_set_odd_parity}
  {$EXTERNALSYM DES_check_key_parity}
  {$EXTERNALSYM DES_is_weak_key}
  {$EXTERNALSYM DES_set_key}
  {$EXTERNALSYM DES_key_sched}
  {$EXTERNALSYM DES_set_key_checked}
  {$EXTERNALSYM DES_set_key_unchecked}
  {$EXTERNALSYM DES_string_to_key}
  {$EXTERNALSYM DES_string_to_2keys}
  {$EXTERNALSYM DES_cfb64_encrypt}
  {$EXTERNALSYM DES_ofb64_encrypt}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM DES_ecb2_encrypt}  {removed 1.0.0}
  {$EXTERNALSYM DES_ede2_cbc_encrypt}  {removed 1.0.0}
  {$EXTERNALSYM DES_ede2_cfb64_encrypt}  {removed 1.0.0}
  {$EXTERNALSYM DES_ede2_ofb64_encrypt}  {removed 1.0.0}
  {$EXTERNALSYM DES_fixup_key_parity} {removed 1.0.0}
  DES_ecb2_encrypt: procedure (input:Pconst_DES_cblock; output:PDES_cblock; ks1:PDES_key_schedule; ks2:PDES_key_schedule; enc:longint); cdecl = nil;  {removed 1.0.0}
  DES_ede2_cbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;  {removed 1.0.0}
  DES_ede2_cfb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint); cdecl = nil;  {removed 1.0.0}
  DES_ede2_ofb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint); cdecl = nil;  {removed 1.0.0}


(* Const before type ignored *)
  DES_options: function : PIdAnsiChar; cdecl = nil;

  DES_ecb3_encrypt: procedure (input:Pconst_DES_cblock; output:PDES_cblock; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_cbc_cksum: function (input:Pbyte; output:PDES_cblock; length:longint; schedule:PDES_key_schedule; ivec:Pconst_DES_cblock):DES_LONG; cdecl = nil;

    { DES_cbc_encrypt does not update the IV!  Use DES_ncbc_encrypt instead.  }
(* Const before type ignored *)
  DES_cbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_ncbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_xcbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; inw:Pconst_DES_cblock; outw:Pconst_DES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_cfb_encrypt: procedure (in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

  DES_ecb_encrypt: procedure (input:Pconst_DES_cblock; output:PDES_cblock; ks:PDES_key_schedule; enc:longint); cdecl = nil; 
   {
     * This is the DES encryption function that gets called by just about every
     * other DES routine in the library.  You should not use this function except
     * to implement 'modes' of DES.  I say this because the functions that call
     * this routine do the conversion from 'char *' to long, and this needs to be
     * done to make sure 'non-aligned' memory access do not occur.  The
     * characters are loaded 'little endian'. Data is a pointer to 2 unsigned
     * long's and ks is the DES_key_schedule to use.  enc, is non zero specifies
     * encryption, zero if decryption.
      }
  DES_encrypt1: procedure (data:PDES_LONG; ks:PDES_key_schedule; enc:longint); cdecl = nil;

    {
     * This functions is the same as DES_encrypt1() except that the DES initial
     * permutation (IP) and final permutation (FP) have been left out.  As for
     * DES_encrypt1(), you should not use this function. It is used by the
     * routines in the library that implement triple DES. IP() DES_encrypt2()
     * DES_encrypt2() DES_encrypt2() FP() is the same as DES_encrypt1()
     * DES_encrypt1() DES_encrypt1() except faster :-).
      }
  DES_encrypt2: procedure (data:PDES_LONG; ks:PDES_key_schedule; enc:longint); cdecl = nil;

  DES_encrypt3: procedure (data:PDES_LONG; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule); cdecl = nil;

  DES_decrypt3: procedure (data:PDES_LONG; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule); cdecl = nil;

(* Const before type ignored *)
  DES_ede3_cbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_ede3_cfb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_ede3_cfb_encrypt: procedure (in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_ede3_ofb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; num:Plongint); cdecl = nil;

(* Const before type ignored *)
(* Const before type ignored *)
  DES_fcrypt: function (buf:PIdAnsiChar; salt:PIdAnsiChar; ret:PIdAnsiChar): PIdAnsiChar; cdecl = nil;

(* Const before type ignored *)
(* Const before type ignored *)
  DES_crypt: function (buf:PIdAnsiChar; salt:PIdAnsiChar): PIdAnsiChar; cdecl = nil;

(* Const before type ignored *)
  DES_ofb_encrypt: procedure (in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock); cdecl = nil;

(* Const before type ignored *)
  DES_pcbc_encrypt: procedure (input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_quad_cksum: function (input:Pbyte; output:PDES_cblock; length:longint; out_count:longint; seed:PDES_cblock):DES_LONG; cdecl = nil;

  DES_random_key: function (ret:PDES_cblock):longint; cdecl = nil;

  DES_set_odd_parity: procedure (key:PDES_cblock); cdecl = nil;

  DES_check_key_parity: function (key:Pconst_DES_cblock):longint; cdecl = nil;

  DES_is_weak_key: function (key:Pconst_DES_cblock):longint; cdecl = nil;

    {
     * DES_set_key (= set_key = DES_key_sched = key_sched) calls
     * DES_set_key_checked if global variable DES_check_key is set,
     * DES_set_key_unchecked otherwise.
      }
  DES_set_key: function (key:Pconst_DES_cblock; var schedule: DES_key_schedule):longint; cdecl = nil;

  DES_key_sched: function (key:Pconst_DES_cblock; schedule:PDES_key_schedule):longint; cdecl = nil;

  DES_set_key_checked: function (key:Pconst_DES_cblock; schedule:PDES_key_schedule):longint; cdecl = nil;

  DES_set_key_unchecked: procedure (key:Pconst_DES_cblock; schedule:PDES_key_schedule); cdecl = nil;

(* Const before type ignored *)
  DES_string_to_key: procedure (str:PIdAnsiChar; key:PDES_cblock); cdecl = nil;

(* Const before type ignored *)
  DES_string_to_2keys: procedure (str:PIdAnsiChar; key1:PDES_cblock; key2:PDES_cblock); cdecl = nil;

(* Const before type ignored *)
  DES_cfb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint); cdecl = nil;

(* Const before type ignored *)
  DES_ofb64_encrypt: procedure (in_:Pbyte; out_:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; num:Plongint); cdecl = nil;

  DES_fixup_key_parity: procedure (key: PDES_cblock); cdecl = nil; {removed 1.0.0}

{$ELSE}


(* Const before type ignored *)
  function DES_options: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_ecb3_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  function DES_cbc_cksum(input:Pbyte; output:PDES_cblock; length:longint; schedule:PDES_key_schedule; ivec:Pconst_DES_cblock):DES_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

    { DES_cbc_encrypt does not update the IV!  Use DES_ncbc_encrypt instead.  }
(* Const before type ignored *)
  procedure DES_cbc_encrypt(input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ncbc_encrypt(input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_xcbc_encrypt(input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; inw:Pconst_DES_cblock; outw:Pconst_DES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_cfb_encrypt(in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_ecb_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks:PDES_key_schedule; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; 
   {
     * This is the DES encryption function that gets called by just about every
     * other DES routine in the library.  You should not use this function except
     * to implement 'modes' of DES.  I say this because the functions that call
     * this routine do the conversion from 'char *' to long, and this needs to be
     * done to make sure 'non-aligned' memory access do not occur.  The
     * characters are loaded 'little endian'. Data is a pointer to 2 unsigned
     * long's and ks is the DES_key_schedule to use.  enc, is non zero specifies
     * encryption, zero if decryption.
      }
  procedure DES_encrypt1(data:PDES_LONG; ks:PDES_key_schedule; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

    {
     * This functions is the same as DES_encrypt1() except that the DES initial
     * permutation (IP) and final permutation (FP) have been left out.  As for
     * DES_encrypt1(), you should not use this function. It is used by the
     * routines in the library that implement triple DES. IP() DES_encrypt2()
     * DES_encrypt2() DES_encrypt2() FP() is the same as DES_encrypt1()
     * DES_encrypt1() DES_encrypt1() except faster :-).
      }
  procedure DES_encrypt2(data:PDES_LONG; ks:PDES_key_schedule; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_encrypt3(data:PDES_LONG; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_decrypt3(data:PDES_LONG; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ede3_cbc_encrypt(input:Pbyte; output:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ede3_cfb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ede3_cfb_encrypt(in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ede3_ofb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ks3:PDES_key_schedule; ivec:PDES_cblock; num:Plongint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
(* Const before type ignored *)
  function DES_fcrypt(buf:PIdAnsiChar; salt:PIdAnsiChar; ret:PIdAnsiChar): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
(* Const before type ignored *)
  function DES_crypt(buf:PIdAnsiChar; salt:PIdAnsiChar): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ofb_encrypt(in_:Pbyte; out_:Pbyte; numbits:longint; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_pcbc_encrypt(input:Pbyte; output:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  function DES_quad_cksum(input:Pbyte; output:PDES_cblock; length:longint; out_count:longint; seed:PDES_cblock):DES_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function DES_random_key(ret:PDES_cblock):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_set_odd_parity(key:PDES_cblock) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function DES_check_key_parity(key:Pconst_DES_cblock):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function DES_is_weak_key(key:Pconst_DES_cblock):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

    {
     * DES_set_key (= set_key = DES_key_sched = key_sched) calls
     * DES_set_key_checked if global variable DES_check_key is set,
     * DES_set_key_unchecked otherwise.
      }
  function DES_set_key(key:Pconst_DES_cblock; var schedule: DES_key_schedule):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function DES_key_sched(key:Pconst_DES_cblock; schedule:PDES_key_schedule):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function DES_set_key_checked(key:Pconst_DES_cblock; schedule:PDES_key_schedule):longint cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure DES_set_key_unchecked(key:Pconst_DES_cblock; schedule:PDES_key_schedule) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_string_to_key(str:PIdAnsiChar; key:PDES_cblock) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_string_to_2keys(str:PIdAnsiChar; key1:PDES_cblock; key2:PDES_cblock) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_cfb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

(* Const before type ignored *)
  procedure DES_ofb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; schedule:PDES_key_schedule; ivec:PDES_cblock; num:Plongint) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};


    procedure DES_ecb2_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks1:PDES_key_schedule; ks2:PDES_key_schedule; enc:longint);  {removed 1.0.0}
    procedure DES_ede2_cbc_encrypt(input:Pbyte; output:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; enc:longint);  {removed 1.0.0}
    procedure DES_ede2_cfb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint);  {removed 1.0.0}
    procedure DES_ede2_ofb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint);  {removed 1.0.0}
    procedure DES_fixup_key_parity(key: PDES_cblock); {removed 1.0.0}
{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  
const
  DES_ecb2_encrypt_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  DES_ede2_cbc_encrypt_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  DES_ede2_cfb64_encrypt_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  DES_ede2_ofb64_encrypt_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  DES_fixup_key_parity_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

procedure  _DES_ecb2_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks1: PDES_key_schedule; ks2: PDES_key_schedule; enc: longint); cdecl;
    begin
      DES_ecb3_encrypt(input,output,ks1,ks2,ks1,enc);
    end;

procedure  _DES_ede2_cbc_encrypt(input:Pbyte; output:Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; enc: longint); cdecl;
    begin
      DES_ede3_cbc_encrypt(input,output,length,ks1,ks2,ks1,ivec,enc);
    end;

procedure  _DES_ede2_cfb64_encrypt(in_: Pbyte; out_: Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; num: Plongint; enc: longint); cdecl;
    begin
      DES_ede3_cfb64_encrypt(in_,out_,length,ks1,ks2,ks1,ivec,num,enc);
    end;

procedure  _DES_ede2_ofb64_encrypt(in_: Pbyte; out_: Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; num: Plongint); cdecl;
    begin
      DES_ede3_ofb64_encrypt(in_,out_,length,ks1,ks2,ks1,ivec,num);
    end;

procedure  _DES_fixup_key_parity(key:PDES_cblock); cdecl;
    begin
      DES_set_odd_parity(key);
   end;


{$WARN  NO_RETVAL OFF}
procedure  ERR_DES_ecb2_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks1:PDES_key_schedule; ks2:PDES_key_schedule; enc:longint); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DES_ecb2_encrypt');
end;


procedure  ERR_DES_ede2_cbc_encrypt(input:Pbyte; output:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; enc:longint); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DES_ede2_cbc_encrypt');
end;


procedure  ERR_DES_ede2_cfb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint; enc:longint); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DES_ede2_cfb64_encrypt');
end;


procedure  ERR_DES_ede2_ofb64_encrypt(in_:Pbyte; out_:Pbyte; length:longint; ks1:PDES_key_schedule; ks2:PDES_key_schedule; ivec:PDES_cblock; num:Plongint); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DES_ede2_ofb64_encrypt');
end;


procedure  ERR_DES_fixup_key_parity(key: PDES_cblock); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DES_fixup_key_parity');
end;


{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  DES_options := LoadFunction('DES_options',AFailed);
  DES_ecb3_encrypt := LoadFunction('DES_ecb3_encrypt',AFailed);
  DES_cbc_cksum := LoadFunction('DES_cbc_cksum',AFailed);
  DES_cbc_encrypt := LoadFunction('DES_cbc_encrypt',AFailed);
  DES_ncbc_encrypt := LoadFunction('DES_ncbc_encrypt',AFailed);
  DES_xcbc_encrypt := LoadFunction('DES_xcbc_encrypt',AFailed);
  DES_cfb_encrypt := LoadFunction('DES_cfb_encrypt',AFailed);
  DES_ecb_encrypt := LoadFunction('DES_ecb_encrypt',AFailed); 
  DES_encrypt1 := LoadFunction('DES_encrypt1',AFailed);
  DES_encrypt2 := LoadFunction('DES_encrypt2',AFailed);
  DES_encrypt3 := LoadFunction('DES_encrypt3',AFailed);
  DES_decrypt3 := LoadFunction('DES_decrypt3',AFailed);
  DES_ede3_cbc_encrypt := LoadFunction('DES_ede3_cbc_encrypt',AFailed);
  DES_ede3_cfb64_encrypt := LoadFunction('DES_ede3_cfb64_encrypt',AFailed);
  DES_ede3_cfb_encrypt := LoadFunction('DES_ede3_cfb_encrypt',AFailed);
  DES_ede3_ofb64_encrypt := LoadFunction('DES_ede3_ofb64_encrypt',AFailed);
  DES_fcrypt := LoadFunction('DES_fcrypt',AFailed);
  DES_crypt := LoadFunction('DES_crypt',AFailed);
  DES_ofb_encrypt := LoadFunction('DES_ofb_encrypt',AFailed);
  DES_pcbc_encrypt := LoadFunction('DES_pcbc_encrypt',AFailed);
  DES_quad_cksum := LoadFunction('DES_quad_cksum',AFailed);
  DES_random_key := LoadFunction('DES_random_key',AFailed);
  DES_set_odd_parity := LoadFunction('DES_set_odd_parity',AFailed);
  DES_check_key_parity := LoadFunction('DES_check_key_parity',AFailed);
  DES_is_weak_key := LoadFunction('DES_is_weak_key',AFailed);
  DES_set_key := LoadFunction('DES_set_key',AFailed);
  DES_key_sched := LoadFunction('DES_key_sched',AFailed);
  DES_set_key_checked := LoadFunction('DES_set_key_checked',AFailed);
  DES_set_key_unchecked := LoadFunction('DES_set_key_unchecked',AFailed);
  DES_string_to_key := LoadFunction('DES_string_to_key',AFailed);
  DES_string_to_2keys := LoadFunction('DES_string_to_2keys',AFailed);
  DES_cfb64_encrypt := LoadFunction('DES_cfb64_encrypt',AFailed);
  DES_ofb64_encrypt := LoadFunction('DES_ofb64_encrypt',AFailed);
  DES_ecb2_encrypt := LoadFunction('DES_ecb2_encrypt',nil);  {removed 1.0.0}
  DES_ede2_cbc_encrypt := LoadFunction('DES_ede2_cbc_encrypt',nil);  {removed 1.0.0}
  DES_ede2_cfb64_encrypt := LoadFunction('DES_ede2_cfb64_encrypt',nil);  {removed 1.0.0}
  DES_ede2_ofb64_encrypt := LoadFunction('DES_ede2_ofb64_encrypt',nil);  {removed 1.0.0}
  DES_fixup_key_parity := LoadFunction('DES_fixup_key_parity',nil); {removed 1.0.0}
  if not assigned(DES_ecb2_encrypt) then 
  begin
    {$if declared(DES_ecb2_encrypt_introduced)}
    if LibVersion < DES_ecb2_encrypt_introduced then
      {$if declared(FC_DES_ecb2_encrypt)}
      DES_ecb2_encrypt := @FC_DES_ecb2_encrypt
      {$else}
      DES_ecb2_encrypt := @ERR_DES_ecb2_encrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(DES_ecb2_encrypt_removed)}
   if DES_ecb2_encrypt_removed <= LibVersion then
     {$if declared(_DES_ecb2_encrypt)}
     DES_ecb2_encrypt := @_DES_ecb2_encrypt
     {$else}
       {$IF declared(ERR_DES_ecb2_encrypt)}
       DES_ecb2_encrypt := @ERR_DES_ecb2_encrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DES_ecb2_encrypt) and Assigned(AFailed) then 
     AFailed.Add('DES_ecb2_encrypt');
  end;


  if not assigned(DES_ede2_cbc_encrypt) then 
  begin
    {$if declared(DES_ede2_cbc_encrypt_introduced)}
    if LibVersion < DES_ede2_cbc_encrypt_introduced then
      {$if declared(FC_DES_ede2_cbc_encrypt)}
      DES_ede2_cbc_encrypt := @FC_DES_ede2_cbc_encrypt
      {$else}
      DES_ede2_cbc_encrypt := @ERR_DES_ede2_cbc_encrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(DES_ede2_cbc_encrypt_removed)}
   if DES_ede2_cbc_encrypt_removed <= LibVersion then
     {$if declared(_DES_ede2_cbc_encrypt)}
     DES_ede2_cbc_encrypt := @_DES_ede2_cbc_encrypt
     {$else}
       {$IF declared(ERR_DES_ede2_cbc_encrypt)}
       DES_ede2_cbc_encrypt := @ERR_DES_ede2_cbc_encrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DES_ede2_cbc_encrypt) and Assigned(AFailed) then 
     AFailed.Add('DES_ede2_cbc_encrypt');
  end;


  if not assigned(DES_ede2_cfb64_encrypt) then 
  begin
    {$if declared(DES_ede2_cfb64_encrypt_introduced)}
    if LibVersion < DES_ede2_cfb64_encrypt_introduced then
      {$if declared(FC_DES_ede2_cfb64_encrypt)}
      DES_ede2_cfb64_encrypt := @FC_DES_ede2_cfb64_encrypt
      {$else}
      DES_ede2_cfb64_encrypt := @ERR_DES_ede2_cfb64_encrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(DES_ede2_cfb64_encrypt_removed)}
   if DES_ede2_cfb64_encrypt_removed <= LibVersion then
     {$if declared(_DES_ede2_cfb64_encrypt)}
     DES_ede2_cfb64_encrypt := @_DES_ede2_cfb64_encrypt
     {$else}
       {$IF declared(ERR_DES_ede2_cfb64_encrypt)}
       DES_ede2_cfb64_encrypt := @ERR_DES_ede2_cfb64_encrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DES_ede2_cfb64_encrypt) and Assigned(AFailed) then 
     AFailed.Add('DES_ede2_cfb64_encrypt');
  end;


  if not assigned(DES_ede2_ofb64_encrypt) then 
  begin
    {$if declared(DES_ede2_ofb64_encrypt_introduced)}
    if LibVersion < DES_ede2_ofb64_encrypt_introduced then
      {$if declared(FC_DES_ede2_ofb64_encrypt)}
      DES_ede2_ofb64_encrypt := @FC_DES_ede2_ofb64_encrypt
      {$else}
      DES_ede2_ofb64_encrypt := @ERR_DES_ede2_ofb64_encrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(DES_ede2_ofb64_encrypt_removed)}
   if DES_ede2_ofb64_encrypt_removed <= LibVersion then
     {$if declared(_DES_ede2_ofb64_encrypt)}
     DES_ede2_ofb64_encrypt := @_DES_ede2_ofb64_encrypt
     {$else}
       {$IF declared(ERR_DES_ede2_ofb64_encrypt)}
       DES_ede2_ofb64_encrypt := @ERR_DES_ede2_ofb64_encrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DES_ede2_ofb64_encrypt) and Assigned(AFailed) then 
     AFailed.Add('DES_ede2_ofb64_encrypt');
  end;


  if not assigned(DES_fixup_key_parity) then 
  begin
    {$if declared(DES_fixup_key_parity_introduced)}
    if LibVersion < DES_fixup_key_parity_introduced then
      {$if declared(FC_DES_fixup_key_parity)}
      DES_fixup_key_parity := @FC_DES_fixup_key_parity
      {$else}
      DES_fixup_key_parity := @ERR_DES_fixup_key_parity
      {$ifend}
    else
    {$ifend}
   {$if declared(DES_fixup_key_parity_removed)}
   if DES_fixup_key_parity_removed <= LibVersion then
     {$if declared(_DES_fixup_key_parity)}
     DES_fixup_key_parity := @_DES_fixup_key_parity
     {$else}
       {$IF declared(ERR_DES_fixup_key_parity)}
       DES_fixup_key_parity := @ERR_DES_fixup_key_parity
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DES_fixup_key_parity) and Assigned(AFailed) then 
     AFailed.Add('DES_fixup_key_parity');
  end;


end;

procedure Unload;
begin
  DES_ecb2_encrypt := nil;  {removed 1.0.0}
  DES_ede2_cbc_encrypt := nil;  {removed 1.0.0}
  DES_ede2_cfb64_encrypt := nil;  {removed 1.0.0}
  DES_ede2_ofb64_encrypt := nil;  {removed 1.0.0}
  DES_options := nil;
  DES_ecb3_encrypt := nil;
  DES_cbc_cksum := nil;
  DES_cbc_encrypt := nil;
  DES_ncbc_encrypt := nil;
  DES_xcbc_encrypt := nil;
  DES_cfb_encrypt := nil;
  DES_ecb_encrypt := nil; 
  DES_encrypt1 := nil;
  DES_encrypt2 := nil;
  DES_encrypt3 := nil;
  DES_decrypt3 := nil;
  DES_ede3_cbc_encrypt := nil;
  DES_ede3_cfb64_encrypt := nil;
  DES_ede3_cfb_encrypt := nil;
  DES_ede3_ofb64_encrypt := nil;
  DES_fcrypt := nil;
  DES_crypt := nil;
  DES_ofb_encrypt := nil;
  DES_pcbc_encrypt := nil;
  DES_quad_cksum := nil;
  DES_random_key := nil;
  DES_set_odd_parity := nil;
  DES_check_key_parity := nil;
  DES_is_weak_key := nil;
  DES_set_key := nil;
  DES_key_sched := nil;
  DES_set_key_checked := nil;
  DES_set_key_unchecked := nil;
  DES_string_to_key := nil;
  DES_string_to_2keys := nil;
  DES_cfb64_encrypt := nil;
  DES_ofb64_encrypt := nil;
  DES_fixup_key_parity := nil; {removed 1.0.0}
end;
{$ELSE}
    procedure DES_ecb2_encrypt(input:Pconst_DES_cblock; output:PDES_cblock; ks1: PDES_key_schedule; ks2: PDES_key_schedule; enc: longint);
    begin
      DES_ecb3_encrypt(input,output,ks1,ks2,ks1,enc);
    end;

    procedure DES_ede2_cbc_encrypt(input:Pbyte; output:Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; enc: longint);
    begin
      DES_ede3_cbc_encrypt(input,output,length,ks1,ks2,ks1,ivec,enc);
    end;

    procedure DES_ede2_cfb64_encrypt(in_: Pbyte; out_: Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; num: Plongint; enc: longint);
    begin
      DES_ede3_cfb64_encrypt(in_,out_,length,ks1,ks2,ks1,ivec,num,enc);
    end;

    procedure DES_ede2_ofb64_encrypt(in_: Pbyte; out_: Pbyte; length: longint; ks1: PDES_key_schedule; ks2: PDES_key_schedule; ivec: PDES_cblock; num: Plongint);
    begin
      DES_ede3_ofb64_encrypt(in_,out_,length,ks1,ks2,ks1,ivec,num);
    end;

    procedure DES_fixup_key_parity(key:PDES_cblock);
    begin
      DES_set_odd_parity(key);
   end;


{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
