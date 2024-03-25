  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_pkcs12.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_pkcs12.h2pas
     and this file regenerated. IdOpenSSLHeaders_pkcs12.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_pkcs12;

interface

// Headers for OpenSSL 1.1.1
// pkcs12.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_pkcs7,
  IdOpenSSLHeaders_x509;

const
  PKCS12_KEY_ID = 1;
  PKCS12_IV_ID = 2;
  PKCS12_MAC_ID = 3;

  ///* Default iteration count */
  //# ifndef PKCS12_DEFAULT_ITER
  //#  define PKCS12_DEFAULT_ITER     PKCS5_DEFAULT_ITER
  //# endif

  PKCS12_MAC_KEY_LENGTH = 20;

  PKCS12_SALT_LEN = 8;

  ///* It's not clear if these are actually needed... */
  //# define PKCS12_key_gen PKCS12_key_gen_utf8
  //# define PKCS12_add_friendlyname PKCS12_add_friendlyname_utf8

  (* MS key usage constants *)
  KEY_EX  = $10;
  KEY_SIG = $80;

  PKCS12_ERROR    = 0;
  PKCS12_OK       = 1;

type
  PKCS12_MAC_DATA_st = type Pointer;
  PKCS12_MAC_DATA = PKCS12_MAC_DATA_st;
  PPKCS12_MAC_DATA = ^PKCS12_MAC_DATA;
  PPPKCS12_MAC_DATA = ^PPKCS12_MAC_DATA;

  PKCS12_st = type Pointer;
  PKCS12 = PKCS12_st;
  PPKCS12 = ^PKCS12;
  PPPKCS12 = ^PPKCS12;

  PKCS12_SAFEBAG_st = type Pointer;
  PKCS12_SAFEBAG = PKCS12_SAFEBAG_st;
  PPKCS12_SAFEBAG = ^PKCS12_SAFEBAG;
  PPPKCS12_SAFEBAG = ^PPKCS12_SAFEBAG;

//  DEFINE_STACK_OF(PKCS12_SAFEBAG)

  pkcs12_bag_st = type Pointer;
  PKCS12_BAGS = pkcs12_bag_st;
  PPKCS12_BAGS = ^PKCS12_BAGS;
  PPPKCS12_BAGS = ^PPKCS12_BAGS;

  //ASN1_TYPE *PKCS8_get_attr(PKCS8_PRIV_KEY_INFO *p8, TIdC_INT attr_nid);
    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM PKCS12_mac_present} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_get0_mac} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get0_attr} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get0_type} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get_nid} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get_bag_nid} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get1_cert} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get1_crl} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get0_p8inf} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_get0_pkcs8} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_create_cert} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_create_crl} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_create0_p8inf} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_create0_pkcs8} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_SAFEBAG_create_pkcs8_encrypt} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_item_pack_safebag}
  {$EXTERNALSYM PKCS8_decrypt}
  {$EXTERNALSYM PKCS12_decrypt_skey}
  {$EXTERNALSYM PKCS8_encrypt}
  {$EXTERNALSYM PKCS8_set0_pbe} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_add_localkeyid}
  {$EXTERNALSYM PKCS12_add_friendlyname_asc}
  {$EXTERNALSYM PKCS12_add_friendlyname_utf8} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_add_CSPName_asc}
  {$EXTERNALSYM PKCS12_add_friendlyname_uni}
  {$EXTERNALSYM PKCS8_add_keyusage}
  {$EXTERNALSYM PKCS12_get_friendlyname}
  {$EXTERNALSYM PKCS12_pbe_crypt}
  {$EXTERNALSYM PKCS12_item_decrypt_d2i}
  {$EXTERNALSYM PKCS12_item_i2d_encrypt}
  {$EXTERNALSYM PKCS12_init}
  {$EXTERNALSYM PKCS12_key_gen_asc}
  {$EXTERNALSYM PKCS12_key_gen_uni}
  {$EXTERNALSYM PKCS12_key_gen_utf8} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_PBE_keyivgen}
  {$EXTERNALSYM PKCS12_gen_mac}
  {$EXTERNALSYM PKCS12_verify_mac}
  {$EXTERNALSYM PKCS12_set_mac}
  {$EXTERNALSYM PKCS12_setup_mac}
  {$EXTERNALSYM OPENSSL_asc2uni}
  {$EXTERNALSYM OPENSSL_uni2asc}
  {$EXTERNALSYM OPENSSL_utf82uni} {introduced 1.1.0}
  {$EXTERNALSYM OPENSSL_uni2utf8} {introduced 1.1.0}
  {$EXTERNALSYM PKCS12_new}
  {$EXTERNALSYM PKCS12_free}
  {$EXTERNALSYM d2i_PKCS12}
  {$EXTERNALSYM i2d_PKCS12}
  {$EXTERNALSYM PKCS12_it}
  {$EXTERNALSYM PKCS12_MAC_DATA_new}
  {$EXTERNALSYM PKCS12_MAC_DATA_free}
  {$EXTERNALSYM d2i_PKCS12_MAC_DATA}
  {$EXTERNALSYM i2d_PKCS12_MAC_DATA}
  {$EXTERNALSYM PKCS12_MAC_DATA_it}
  {$EXTERNALSYM PKCS12_SAFEBAG_new}
  {$EXTERNALSYM PKCS12_SAFEBAG_free}
  {$EXTERNALSYM d2i_PKCS12_SAFEBAG}
  {$EXTERNALSYM i2d_PKCS12_SAFEBAG}
  {$EXTERNALSYM PKCS12_SAFEBAG_it}
  {$EXTERNALSYM PKCS12_BAGS_new}
  {$EXTERNALSYM PKCS12_BAGS_free}
  {$EXTERNALSYM d2i_PKCS12_BAGS}
  {$EXTERNALSYM i2d_PKCS12_BAGS}
  {$EXTERNALSYM PKCS12_BAGS_it}
  {$EXTERNALSYM PKCS12_PBE_add}
  {$EXTERNALSYM PKCS12_parse}
  {$EXTERNALSYM PKCS12_create}
  {$EXTERNALSYM i2d_PKCS12_bio}
  {$EXTERNALSYM d2i_PKCS12_bio}
  {$EXTERNALSYM PKCS12_newpass}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  PKCS12_mac_present: function (const p12: PPKCS12): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  PKCS12_get0_mac: procedure (const pmac: PPASN1_OCTET_STRING; const pmacalg: PPX509_ALGOR; const psalt: PPASN1_OCTET_STRING; const piter: PPASN1_INTEGER; const p12: PPKCS12); cdecl = nil; {introduced 1.1.0}

  PKCS12_SAFEBAG_get0_attr: function (const bag: PPKCS12_SAFEBAG; attr_nid: TIdC_INT): PASN1_TYPE; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_type: function (const bag: PPKCS12_SAFEBAG): PASN1_OBJECT; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get_nid: function (const bag: PPKCS12_SAFEBAG): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get_bag_nid: function (const bag: PPKCS12_SAFEBAG): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  PKCS12_SAFEBAG_get1_cert: function (const bag: PPKCS12_SAFEBAG): PX509; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get1_crl: function (const bag: PPKCS12_SAFEBAG): PX509_CRL; cdecl = nil; {introduced 1.1.0}
//  const STACK_OF(PKCS12_SAFEBAG) *PKCS12_SAFEBAG_get0_safes(const PKCS12_SAFEBAG *bag);
  PKCS12_SAFEBAG_get0_p8inf: function (const bag: PPKCS12_SAFEBAG): PPKCS8_PRIV_KEY_INFO; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_pkcs8: function (const bag: PPKCS12_SAFEBAG): PX509_SIG; cdecl = nil; {introduced 1.1.0}

  PKCS12_SAFEBAG_create_cert: function (x509: PX509): PPKCS12_SAFEBAG; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create_crl: function (crl: PX509_CRL): PPKCS12_SAFEBAG; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_p8inf: function (p8: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_pkcs8: function (p8: PX509_SIG): PPKCS12_SAFEBAG; cdecl = nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create_pkcs8_encrypt: function (pbe_nid: TIdC_INT; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG; cdecl = nil; {introduced 1.1.0}

  PKCS12_item_pack_safebag: function (obj: Pointer; const it: PASN1_ITEM; nid1: TIdC_INT; nid2: TIdC_INT): PPKCS12_SAFEBAG; cdecl = nil;
  PKCS8_decrypt: function (const p8: PX509_SIG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO; cdecl = nil;
  PKCS12_decrypt_skey: function (const bag: PPKCS12_SAFEBAG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO; cdecl = nil;
  PKCS8_encrypt: function (pbe_nid: TIdC_INT; const cipher: PEVP_CIPHER; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8: PPKCS8_PRIV_KEY_INFO): PX509_SIG; cdecl = nil;
  PKCS8_set0_pbe: function (const pass: PIdAnsiChar; passlen: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO; pbe: PX509_ALGOR): PX509_SIG; cdecl = nil; {introduced 1.1.0}
//  PKCS7 *PKCS12_pack_p7data(STACK_OF(PKCS12_SAFEBAG) *sk);
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7);
//  function PKCS12_pack_p7encdata(TIdC_INT pbe_nid, const PIdAnsiChar pass, TIdC_INT passlen,
//                               Byte *salt, TIdC_INT saltlen, TIdC_INT iter,
//                               STACK_OF(PKCS12_SAFEBAG) *bags): PPKCS7;
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const PIdAnsiChar *pass,
//                                                    TIdC_INT passlen);

//  TIdC_INT PKCS12_pack_authsafes(PKCS12 *p12, STACK_OF(PKCS7) *safes);
//  STACK_OF(PKCS7) *PKCS12_unpack_authsafes(const PKCS12 *p12);

  PKCS12_add_localkeyid: function (bag: PPKCS12_SAFEBAG; name: PByte; namelen: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS12_add_friendlyname_asc: function (bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS12_add_friendlyname_utf8: function (bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  PKCS12_add_CSPName_asc: function (bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS12_add_friendlyname_uni: function (bag: PPKCS12_SAFEBAG; const name: PByte; namelen: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS8_add_keyusage: function (p8: PPKCS8_PRIV_KEY_INFO; usage: TIdC_INT): TIdC_INT; cdecl = nil;
//  function PKCS12_get_attr_gen(const STACK_OF(X509_ATTRIBUTE) *attrs; TIdC_INT attr_nid): PASN1_TYPE;
  PKCS12_get_friendlyname: function (bag: PPKCS12_SAFEBAG): PIdAnsiChar; cdecl = nil;
//  const STACK_OF(X509_ATTRIBUTE) *PKCS12_SAFEBAG_get0_attrs(const PKCS12_SAFEBAG *bag);
  PKCS12_pbe_crypt: function (const algor: PX509_ALGOR; const pass: PIdAnsiChar; passlen: TIdC_INT; const in_: PByte; inlen: TIdC_INT; data: PPByte; datalen: PIdC_INT; en_de: TIdC_INT): PByte; cdecl = nil;
  PKCS12_item_decrypt_d2i: function (const algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; const oct: PASN1_OCTET_STRING; zbuf: TIdC_INT): Pointer; cdecl = nil;
  PKCS12_item_i2d_encrypt: function (algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; obj: Pointer; zbuf: TIdC_INT): PASN1_OCTET_STRING; cdecl = nil;
  PKCS12_init: function (mode: TIdC_INT): PPKCS12; cdecl = nil;
  PKCS12_key_gen_asc: function (const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT; cdecl = nil;
  PKCS12_key_gen_uni: function (pass: PByte; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT; cdecl = nil;
  PKCS12_key_gen_utf8: function (const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  PKCS12_PBE_keyivgen: function (ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md_type: PEVP_MD; en_de: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS12_gen_mac: function (p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; mac: PByte; maclen: PIdC_UINT): TIdC_INT; cdecl = nil;
  PKCS12_verify_mac: function (p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS12_set_mac: function (p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const md_type: PEVP_MD): TIdC_INT; cdecl = nil;
  PKCS12_setup_mac: function (p12: PPKCS12; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; const md_type: PEVP_MD): TIdC_INT; cdecl = nil;
  OPENSSL_asc2uni: function (const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte; cdecl = nil;
  OPENSSL_uni2asc: function (const uni: PByte; unilen: TIdC_INT): PIdAnsiChar; cdecl = nil;
  OPENSSL_utf82uni: function (const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte; cdecl = nil; {introduced 1.1.0}
  OPENSSL_uni2utf8: function (const uni: PByte; unilen: TIdC_INT): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}

  PKCS12_new: function : PPKCS12; cdecl = nil;
  PKCS12_free: procedure (a: PPKCS12); cdecl = nil;
  d2i_PKCS12: function (a: PPPKCS12; const in_: PPByte; len: TIdC_LONG): PPKCS12; cdecl = nil;
  i2d_PKCS12: function (a: PPKCS12; out_: PPByte): TIdC_INT; cdecl = nil;
  PKCS12_it: function : PASN1_ITEM; cdecl = nil;

  PKCS12_MAC_DATA_new: function : PPKCS12_MAC_DATA; cdecl = nil;
  PKCS12_MAC_DATA_free: procedure (a: PPKCS12_MAC_DATA); cdecl = nil;
  d2i_PKCS12_MAC_DATA: function (a: PPPKCS12_MAC_DATA; const in_: PPByte; len: TIdC_LONG): PPKCS12_MAC_DATA; cdecl = nil;
  i2d_PKCS12_MAC_DATA: function (a: PPKCS12_MAC_DATA; out_: PPByte): TIdC_INT; cdecl = nil;
  PKCS12_MAC_DATA_it: function : PASN1_ITEM; cdecl = nil;

  PKCS12_SAFEBAG_new: function : PPKCS12_SAFEBAG; cdecl = nil;
  PKCS12_SAFEBAG_free: procedure (a: PPKCS12_SAFEBAG); cdecl = nil;
  d2i_PKCS12_SAFEBAG: function (a: PPPKCS12_SAFEBAG; const in_: PPByte; len: TIdC_LONG): PPKCS12_SAFEBAG; cdecl = nil;
  i2d_PKCS12_SAFEBAG: function (a: PPKCS12_SAFEBAG; out_: PPByte): TIdC_INT; cdecl = nil;
  PKCS12_SAFEBAG_it: function : PASN1_ITEM; cdecl = nil;

  PKCS12_BAGS_new: function : PPKCS12_BAGS; cdecl = nil;
  PKCS12_BAGS_free: procedure (a: PPKCS12_BAGS); cdecl = nil;
  d2i_PKCS12_BAGS: function (a: PPPKCS12_BAGS; const in_: PPByte; len: TIdC_LONG): PPKCS12_BAGS; cdecl = nil;
  i2d_PKCS12_BAGS: function (a: PPKCS12_BAGS; out_: PPByte): TIdC_INT; cdecl = nil;
  PKCS12_BAGS_it: function : PASN1_ITEM; cdecl = nil;

  PKCS12_PBE_add: procedure (v: Pointer); cdecl = nil;
  PKCS12_parse: function (p12: PPKCS12; const pass: PIdAnsiChar; out pkey: PEVP_PKEY; out cert: PX509; ca: PPStack_Of_X509): TIdC_INT; cdecl = nil;
  PKCS12_create: function (const pass: PIdAnsiChar; const name: PIdAnsiChar; pkey: PEVP_PKEY; cert: PX509; ca: PStack_Of_X509; nid_key: TIdC_INT; nid_cert: TIdC_INT; iter: TIdC_INT; mac_iter: TIdC_INT; keytype: TIdC_INT): PPKCS12; cdecl = nil;

//  function PKCS12_add_cert(STACK_OF(PKCS12_SAFEBAG) **pbags; X509 *cert): PKCS12_SAFEBAG;
//  PKCS12_SAFEBAG *PKCS12_add_key(STACK_OF(PKCS12_SAFEBAG) **pbags;
//                                 EVP_PKEY *key; TIdC_INT key_usage; iter: TIdC_INT;
//                                 TIdC_INT key_nid; const pass: PIdAnsiChar);
//  TIdC_INT PKCS12_add_safe(STACK_OF(PKCS7) **psafes; STACK_OF(PKCS12_SAFEBAG) *bags;
//                      TIdC_INT safe_nid; iter: TIdC_INT; const pass: PIdAnsiChar);
//  PKCS12 *PKCS12_add_safes(STACK_OF(PKCS7) *safes; TIdC_INT p7_nid);

  i2d_PKCS12_bio: function (bp: PBIO; p12: PPKCS12): TIdC_INT; cdecl = nil;
  d2i_PKCS12_bio: function (bp: PBIO; p12: PPPKCS12): PPKCS12; cdecl = nil;
  PKCS12_newpass: function (p12: PPKCS12; const oldpass: PIdAnsiChar; const newpass: PIdAnsiChar): TIdC_INT; cdecl = nil;

{$ELSE}
  function PKCS12_mac_present(const p12: PPKCS12): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  procedure PKCS12_get0_mac(const pmac: PPASN1_OCTET_STRING; const pmacalg: PPX509_ALGOR; const psalt: PPASN1_OCTET_STRING; const piter: PPASN1_INTEGER; const p12: PPKCS12) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}

  function PKCS12_SAFEBAG_get0_attr(const bag: PPKCS12_SAFEBAG; attr_nid: TIdC_INT): PASN1_TYPE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_get0_type(const bag: PPKCS12_SAFEBAG): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_get_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_get_bag_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}

  function PKCS12_SAFEBAG_get1_cert(const bag: PPKCS12_SAFEBAG): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_get1_crl(const bag: PPKCS12_SAFEBAG): PX509_CRL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
//  const STACK_OF(PKCS12_SAFEBAG) *PKCS12_SAFEBAG_get0_safes(const PKCS12_SAFEBAG *bag);
  function PKCS12_SAFEBAG_get0_p8inf(const bag: PPKCS12_SAFEBAG): PPKCS8_PRIV_KEY_INFO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_get0_pkcs8(const bag: PPKCS12_SAFEBAG): PX509_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}

  function PKCS12_SAFEBAG_create_cert(x509: PX509): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_create_crl(crl: PX509_CRL): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_create0_p8inf(p8: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_create0_pkcs8(p8: PX509_SIG): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_SAFEBAG_create_pkcs8_encrypt(pbe_nid: TIdC_INT; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}

  function PKCS12_item_pack_safebag(obj: Pointer; const it: PASN1_ITEM; nid1: TIdC_INT; nid2: TIdC_INT): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS8_decrypt(const p8: PX509_SIG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_decrypt_skey(const bag: PPKCS12_SAFEBAG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS8_encrypt(pbe_nid: TIdC_INT; const cipher: PEVP_CIPHER; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8: PPKCS8_PRIV_KEY_INFO): PX509_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS8_set0_pbe(const pass: PIdAnsiChar; passlen: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO; pbe: PX509_ALGOR): PX509_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
//  PKCS7 *PKCS12_pack_p7data(STACK_OF(PKCS12_SAFEBAG) *sk);
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7);
//  function PKCS12_pack_p7encdata(TIdC_INT pbe_nid, const PIdAnsiChar pass, TIdC_INT passlen,
//                               Byte *salt, TIdC_INT saltlen, TIdC_INT iter,
//                               STACK_OF(PKCS12_SAFEBAG) *bags): PPKCS7;
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const PIdAnsiChar *pass,
//                                                    TIdC_INT passlen);

//  TIdC_INT PKCS12_pack_authsafes(PKCS12 *p12, STACK_OF(PKCS7) *safes);
//  STACK_OF(PKCS7) *PKCS12_unpack_authsafes(const PKCS12 *p12);

  function PKCS12_add_localkeyid(bag: PPKCS12_SAFEBAG; name: PByte; namelen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_add_friendlyname_asc(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_add_friendlyname_utf8(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_add_CSPName_asc(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_add_friendlyname_uni(bag: PPKCS12_SAFEBAG; const name: PByte; namelen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS8_add_keyusage(p8: PPKCS8_PRIV_KEY_INFO; usage: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
//  function PKCS12_get_attr_gen(const STACK_OF(X509_ATTRIBUTE) *attrs; TIdC_INT attr_nid): PASN1_TYPE;
  function PKCS12_get_friendlyname(bag: PPKCS12_SAFEBAG): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
//  const STACK_OF(X509_ATTRIBUTE) *PKCS12_SAFEBAG_get0_attrs(const PKCS12_SAFEBAG *bag);
  function PKCS12_pbe_crypt(const algor: PX509_ALGOR; const pass: PIdAnsiChar; passlen: TIdC_INT; const in_: PByte; inlen: TIdC_INT; data: PPByte; datalen: PIdC_INT; en_de: TIdC_INT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_item_decrypt_d2i(const algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; const oct: PASN1_OCTET_STRING; zbuf: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_item_i2d_encrypt(algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; obj: Pointer; zbuf: TIdC_INT): PASN1_OCTET_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_init(mode: TIdC_INT): PPKCS12 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_key_gen_asc(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_key_gen_uni(pass: PByte; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_key_gen_utf8(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function PKCS12_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md_type: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_gen_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; mac: PByte; maclen: PIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_verify_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_set_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_setup_mac(p12: PPKCS12; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function OPENSSL_asc2uni(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function OPENSSL_uni2asc(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function OPENSSL_utf82uni(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function OPENSSL_uni2utf8(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}

  function PKCS12_new: PPKCS12 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure PKCS12_free(a: PPKCS12) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function d2i_PKCS12(a: PPPKCS12; const in_: PPByte; len: TIdC_LONG): PPKCS12 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function i2d_PKCS12(a: PPKCS12; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function PKCS12_MAC_DATA_new: PPKCS12_MAC_DATA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure PKCS12_MAC_DATA_free(a: PPKCS12_MAC_DATA) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function d2i_PKCS12_MAC_DATA(a: PPPKCS12_MAC_DATA; const in_: PPByte; len: TIdC_LONG): PPKCS12_MAC_DATA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function i2d_PKCS12_MAC_DATA(a: PPKCS12_MAC_DATA; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_MAC_DATA_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function PKCS12_SAFEBAG_new: PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure PKCS12_SAFEBAG_free(a: PPKCS12_SAFEBAG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function d2i_PKCS12_SAFEBAG(a: PPPKCS12_SAFEBAG; const in_: PPByte; len: TIdC_LONG): PPKCS12_SAFEBAG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function i2d_PKCS12_SAFEBAG(a: PPKCS12_SAFEBAG; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_SAFEBAG_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function PKCS12_BAGS_new: PPKCS12_BAGS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure PKCS12_BAGS_free(a: PPKCS12_BAGS) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function d2i_PKCS12_BAGS(a: PPPKCS12_BAGS; const in_: PPByte; len: TIdC_LONG): PPKCS12_BAGS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function i2d_PKCS12_BAGS(a: PPKCS12_BAGS; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_BAGS_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure PKCS12_PBE_add(v: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_parse(p12: PPKCS12; const pass: PIdAnsiChar; out pkey: PEVP_PKEY; out cert: PX509; ca: PPStack_Of_X509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_create(const pass: PIdAnsiChar; const name: PIdAnsiChar; pkey: PEVP_PKEY; cert: PX509; ca: PStack_Of_X509; nid_key: TIdC_INT; nid_cert: TIdC_INT; iter: TIdC_INT; mac_iter: TIdC_INT; keytype: TIdC_INT): PPKCS12 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

//  function PKCS12_add_cert(STACK_OF(PKCS12_SAFEBAG) **pbags; X509 *cert): PKCS12_SAFEBAG;
//  PKCS12_SAFEBAG *PKCS12_add_key(STACK_OF(PKCS12_SAFEBAG) **pbags;
//                                 EVP_PKEY *key; TIdC_INT key_usage; iter: TIdC_INT;
//                                 TIdC_INT key_nid; const pass: PIdAnsiChar);
//  TIdC_INT PKCS12_add_safe(STACK_OF(PKCS7) **psafes; STACK_OF(PKCS12_SAFEBAG) *bags;
//                      TIdC_INT safe_nid; iter: TIdC_INT; const pass: PIdAnsiChar);
//  PKCS12 *PKCS12_add_safes(STACK_OF(PKCS7) *safes; TIdC_INT p7_nid);

  function i2d_PKCS12_bio(bp: PBIO; p12: PPKCS12): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function d2i_PKCS12_bio(bp: PBIO; p12: PPPKCS12): PPKCS12 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function PKCS12_newpass(p12: PPKCS12; const oldpass: PIdAnsiChar; const newpass: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

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
  PKCS12_mac_present_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_get0_mac_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get0_attr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get0_type_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get_bag_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get1_cert_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get1_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get0_p8inf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_get0_pkcs8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_create_cert_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_create_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_create0_p8inf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_create0_pkcs8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_SAFEBAG_create_pkcs8_encrypt_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS8_set0_pbe_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_add_friendlyname_utf8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS12_key_gen_utf8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OPENSSL_utf82uni_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OPENSSL_uni2utf8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
function  ERR_PKCS12_mac_present(const p12: PPKCS12): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_mac_present');
end;


procedure  ERR_PKCS12_get0_mac(const pmac: PPASN1_OCTET_STRING; const pmacalg: PPX509_ALGOR; const psalt: PPASN1_OCTET_STRING; const piter: PPASN1_INTEGER; const p12: PPKCS12); 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_get0_mac');
end;


function  ERR_PKCS12_SAFEBAG_get0_attr(const bag: PPKCS12_SAFEBAG; attr_nid: TIdC_INT): PASN1_TYPE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get0_attr');
end;


function  ERR_PKCS12_SAFEBAG_get0_type(const bag: PPKCS12_SAFEBAG): PASN1_OBJECT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get0_type');
end;


function  ERR_PKCS12_SAFEBAG_get_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get_nid');
end;


function  ERR_PKCS12_SAFEBAG_get_bag_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get_bag_nid');
end;


function  ERR_PKCS12_SAFEBAG_get1_cert(const bag: PPKCS12_SAFEBAG): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get1_cert');
end;


function  ERR_PKCS12_SAFEBAG_get1_crl(const bag: PPKCS12_SAFEBAG): PX509_CRL; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get1_crl');
end;


function  ERR_PKCS12_SAFEBAG_get0_p8inf(const bag: PPKCS12_SAFEBAG): PPKCS8_PRIV_KEY_INFO; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get0_p8inf');
end;


function  ERR_PKCS12_SAFEBAG_get0_pkcs8(const bag: PPKCS12_SAFEBAG): PX509_SIG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_get0_pkcs8');
end;


function  ERR_PKCS12_SAFEBAG_create_cert(x509: PX509): PPKCS12_SAFEBAG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_create_cert');
end;


function  ERR_PKCS12_SAFEBAG_create_crl(crl: PX509_CRL): PPKCS12_SAFEBAG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_create_crl');
end;


function  ERR_PKCS12_SAFEBAG_create0_p8inf(p8: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_create0_p8inf');
end;


function  ERR_PKCS12_SAFEBAG_create0_pkcs8(p8: PX509_SIG): PPKCS12_SAFEBAG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_create0_pkcs8');
end;


function  ERR_PKCS12_SAFEBAG_create_pkcs8_encrypt(pbe_nid: TIdC_INT; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_SAFEBAG_create_pkcs8_encrypt');
end;


function  ERR_PKCS8_set0_pbe(const pass: PIdAnsiChar; passlen: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO; pbe: PX509_ALGOR): PX509_SIG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS8_set0_pbe');
end;


function  ERR_PKCS12_add_friendlyname_utf8(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_add_friendlyname_utf8');
end;


function  ERR_PKCS12_key_gen_utf8(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS12_key_gen_utf8');
end;


function  ERR_OPENSSL_utf82uni(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OPENSSL_utf82uni');
end;


function  ERR_OPENSSL_uni2utf8(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OPENSSL_uni2utf8');
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
  PKCS12_item_pack_safebag := LoadFunction('PKCS12_item_pack_safebag',AFailed);
  PKCS8_decrypt := LoadFunction('PKCS8_decrypt',AFailed);
  PKCS12_decrypt_skey := LoadFunction('PKCS12_decrypt_skey',AFailed);
  PKCS8_encrypt := LoadFunction('PKCS8_encrypt',AFailed);
  PKCS12_add_localkeyid := LoadFunction('PKCS12_add_localkeyid',AFailed);
  PKCS12_add_friendlyname_asc := LoadFunction('PKCS12_add_friendlyname_asc',AFailed);
  PKCS12_add_CSPName_asc := LoadFunction('PKCS12_add_CSPName_asc',AFailed);
  PKCS12_add_friendlyname_uni := LoadFunction('PKCS12_add_friendlyname_uni',AFailed);
  PKCS8_add_keyusage := LoadFunction('PKCS8_add_keyusage',AFailed);
  PKCS12_get_friendlyname := LoadFunction('PKCS12_get_friendlyname',AFailed);
  PKCS12_pbe_crypt := LoadFunction('PKCS12_pbe_crypt',AFailed);
  PKCS12_item_decrypt_d2i := LoadFunction('PKCS12_item_decrypt_d2i',AFailed);
  PKCS12_item_i2d_encrypt := LoadFunction('PKCS12_item_i2d_encrypt',AFailed);
  PKCS12_init := LoadFunction('PKCS12_init',AFailed);
  PKCS12_key_gen_asc := LoadFunction('PKCS12_key_gen_asc',AFailed);
  PKCS12_key_gen_uni := LoadFunction('PKCS12_key_gen_uni',AFailed);
  PKCS12_PBE_keyivgen := LoadFunction('PKCS12_PBE_keyivgen',AFailed);
  PKCS12_gen_mac := LoadFunction('PKCS12_gen_mac',AFailed);
  PKCS12_verify_mac := LoadFunction('PKCS12_verify_mac',AFailed);
  PKCS12_set_mac := LoadFunction('PKCS12_set_mac',AFailed);
  PKCS12_setup_mac := LoadFunction('PKCS12_setup_mac',AFailed);
  OPENSSL_asc2uni := LoadFunction('OPENSSL_asc2uni',AFailed);
  OPENSSL_uni2asc := LoadFunction('OPENSSL_uni2asc',AFailed);
  PKCS12_new := LoadFunction('PKCS12_new',AFailed);
  PKCS12_free := LoadFunction('PKCS12_free',AFailed);
  d2i_PKCS12 := LoadFunction('d2i_PKCS12',AFailed);
  i2d_PKCS12 := LoadFunction('i2d_PKCS12',AFailed);
  PKCS12_it := LoadFunction('PKCS12_it',AFailed);
  PKCS12_MAC_DATA_new := LoadFunction('PKCS12_MAC_DATA_new',AFailed);
  PKCS12_MAC_DATA_free := LoadFunction('PKCS12_MAC_DATA_free',AFailed);
  d2i_PKCS12_MAC_DATA := LoadFunction('d2i_PKCS12_MAC_DATA',AFailed);
  i2d_PKCS12_MAC_DATA := LoadFunction('i2d_PKCS12_MAC_DATA',AFailed);
  PKCS12_MAC_DATA_it := LoadFunction('PKCS12_MAC_DATA_it',AFailed);
  PKCS12_SAFEBAG_new := LoadFunction('PKCS12_SAFEBAG_new',AFailed);
  PKCS12_SAFEBAG_free := LoadFunction('PKCS12_SAFEBAG_free',AFailed);
  d2i_PKCS12_SAFEBAG := LoadFunction('d2i_PKCS12_SAFEBAG',AFailed);
  i2d_PKCS12_SAFEBAG := LoadFunction('i2d_PKCS12_SAFEBAG',AFailed);
  PKCS12_SAFEBAG_it := LoadFunction('PKCS12_SAFEBAG_it',AFailed);
  PKCS12_BAGS_new := LoadFunction('PKCS12_BAGS_new',AFailed);
  PKCS12_BAGS_free := LoadFunction('PKCS12_BAGS_free',AFailed);
  d2i_PKCS12_BAGS := LoadFunction('d2i_PKCS12_BAGS',AFailed);
  i2d_PKCS12_BAGS := LoadFunction('i2d_PKCS12_BAGS',AFailed);
  PKCS12_BAGS_it := LoadFunction('PKCS12_BAGS_it',AFailed);
  PKCS12_PBE_add := LoadFunction('PKCS12_PBE_add',AFailed);
  PKCS12_parse := LoadFunction('PKCS12_parse',AFailed);
  PKCS12_create := LoadFunction('PKCS12_create',AFailed);
  i2d_PKCS12_bio := LoadFunction('i2d_PKCS12_bio',AFailed);
  d2i_PKCS12_bio := LoadFunction('d2i_PKCS12_bio',AFailed);
  PKCS12_newpass := LoadFunction('PKCS12_newpass',AFailed);
  PKCS12_mac_present := LoadFunction('PKCS12_mac_present',nil); {introduced 1.1.0}
  PKCS12_get0_mac := LoadFunction('PKCS12_get0_mac',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_attr := LoadFunction('PKCS12_SAFEBAG_get0_attr',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_type := LoadFunction('PKCS12_SAFEBAG_get0_type',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get_nid := LoadFunction('PKCS12_SAFEBAG_get_nid',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get_bag_nid := LoadFunction('PKCS12_SAFEBAG_get_bag_nid',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get1_cert := LoadFunction('PKCS12_SAFEBAG_get1_cert',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get1_crl := LoadFunction('PKCS12_SAFEBAG_get1_crl',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_p8inf := LoadFunction('PKCS12_SAFEBAG_get0_p8inf',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_pkcs8 := LoadFunction('PKCS12_SAFEBAG_get0_pkcs8',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_create_cert := LoadFunction('PKCS12_SAFEBAG_create_cert',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_create_crl := LoadFunction('PKCS12_SAFEBAG_create_crl',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_p8inf := LoadFunction('PKCS12_SAFEBAG_create0_p8inf',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_pkcs8 := LoadFunction('PKCS12_SAFEBAG_create0_pkcs8',nil); {introduced 1.1.0}
  PKCS12_SAFEBAG_create_pkcs8_encrypt := LoadFunction('PKCS12_SAFEBAG_create_pkcs8_encrypt',nil); {introduced 1.1.0}
  PKCS8_set0_pbe := LoadFunction('PKCS8_set0_pbe',nil); {introduced 1.1.0}
  PKCS12_add_friendlyname_utf8 := LoadFunction('PKCS12_add_friendlyname_utf8',nil); {introduced 1.1.0}
  PKCS12_key_gen_utf8 := LoadFunction('PKCS12_key_gen_utf8',nil); {introduced 1.1.0}
  OPENSSL_utf82uni := LoadFunction('OPENSSL_utf82uni',nil); {introduced 1.1.0}
  OPENSSL_uni2utf8 := LoadFunction('OPENSSL_uni2utf8',nil); {introduced 1.1.0}
  if not assigned(PKCS12_mac_present) then 
  begin
    {$if declared(PKCS12_mac_present_introduced)}
    if LibVersion < PKCS12_mac_present_introduced then
      {$if declared(FC_PKCS12_mac_present)}
      PKCS12_mac_present := @FC_PKCS12_mac_present
      {$else}
      PKCS12_mac_present := @ERR_PKCS12_mac_present
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_mac_present_removed)}
   if PKCS12_mac_present_removed <= LibVersion then
     {$if declared(_PKCS12_mac_present)}
     PKCS12_mac_present := @_PKCS12_mac_present
     {$else}
       {$IF declared(ERR_PKCS12_mac_present)}
       PKCS12_mac_present := @ERR_PKCS12_mac_present
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_mac_present) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_mac_present');
  end;


  if not assigned(PKCS12_get0_mac) then 
  begin
    {$if declared(PKCS12_get0_mac_introduced)}
    if LibVersion < PKCS12_get0_mac_introduced then
      {$if declared(FC_PKCS12_get0_mac)}
      PKCS12_get0_mac := @FC_PKCS12_get0_mac
      {$else}
      PKCS12_get0_mac := @ERR_PKCS12_get0_mac
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_get0_mac_removed)}
   if PKCS12_get0_mac_removed <= LibVersion then
     {$if declared(_PKCS12_get0_mac)}
     PKCS12_get0_mac := @_PKCS12_get0_mac
     {$else}
       {$IF declared(ERR_PKCS12_get0_mac)}
       PKCS12_get0_mac := @ERR_PKCS12_get0_mac
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_get0_mac) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_get0_mac');
  end;


  if not assigned(PKCS12_SAFEBAG_get0_attr) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get0_attr_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get0_attr_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get0_attr)}
      PKCS12_SAFEBAG_get0_attr := @FC_PKCS12_SAFEBAG_get0_attr
      {$else}
      PKCS12_SAFEBAG_get0_attr := @ERR_PKCS12_SAFEBAG_get0_attr
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get0_attr_removed)}
   if PKCS12_SAFEBAG_get0_attr_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get0_attr)}
     PKCS12_SAFEBAG_get0_attr := @_PKCS12_SAFEBAG_get0_attr
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get0_attr)}
       PKCS12_SAFEBAG_get0_attr := @ERR_PKCS12_SAFEBAG_get0_attr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get0_attr) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get0_attr');
  end;


  if not assigned(PKCS12_SAFEBAG_get0_type) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get0_type_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get0_type_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get0_type)}
      PKCS12_SAFEBAG_get0_type := @FC_PKCS12_SAFEBAG_get0_type
      {$else}
      PKCS12_SAFEBAG_get0_type := @ERR_PKCS12_SAFEBAG_get0_type
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get0_type_removed)}
   if PKCS12_SAFEBAG_get0_type_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get0_type)}
     PKCS12_SAFEBAG_get0_type := @_PKCS12_SAFEBAG_get0_type
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get0_type)}
       PKCS12_SAFEBAG_get0_type := @ERR_PKCS12_SAFEBAG_get0_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get0_type) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get0_type');
  end;


  if not assigned(PKCS12_SAFEBAG_get_nid) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get_nid_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get_nid_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get_nid)}
      PKCS12_SAFEBAG_get_nid := @FC_PKCS12_SAFEBAG_get_nid
      {$else}
      PKCS12_SAFEBAG_get_nid := @ERR_PKCS12_SAFEBAG_get_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get_nid_removed)}
   if PKCS12_SAFEBAG_get_nid_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get_nid)}
     PKCS12_SAFEBAG_get_nid := @_PKCS12_SAFEBAG_get_nid
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get_nid)}
       PKCS12_SAFEBAG_get_nid := @ERR_PKCS12_SAFEBAG_get_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get_nid) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get_nid');
  end;


  if not assigned(PKCS12_SAFEBAG_get_bag_nid) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get_bag_nid_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get_bag_nid_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get_bag_nid)}
      PKCS12_SAFEBAG_get_bag_nid := @FC_PKCS12_SAFEBAG_get_bag_nid
      {$else}
      PKCS12_SAFEBAG_get_bag_nid := @ERR_PKCS12_SAFEBAG_get_bag_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get_bag_nid_removed)}
   if PKCS12_SAFEBAG_get_bag_nid_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get_bag_nid)}
     PKCS12_SAFEBAG_get_bag_nid := @_PKCS12_SAFEBAG_get_bag_nid
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get_bag_nid)}
       PKCS12_SAFEBAG_get_bag_nid := @ERR_PKCS12_SAFEBAG_get_bag_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get_bag_nid) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get_bag_nid');
  end;


  if not assigned(PKCS12_SAFEBAG_get1_cert) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get1_cert_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get1_cert_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get1_cert)}
      PKCS12_SAFEBAG_get1_cert := @FC_PKCS12_SAFEBAG_get1_cert
      {$else}
      PKCS12_SAFEBAG_get1_cert := @ERR_PKCS12_SAFEBAG_get1_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get1_cert_removed)}
   if PKCS12_SAFEBAG_get1_cert_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get1_cert)}
     PKCS12_SAFEBAG_get1_cert := @_PKCS12_SAFEBAG_get1_cert
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get1_cert)}
       PKCS12_SAFEBAG_get1_cert := @ERR_PKCS12_SAFEBAG_get1_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get1_cert) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get1_cert');
  end;


  if not assigned(PKCS12_SAFEBAG_get1_crl) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get1_crl_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get1_crl_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get1_crl)}
      PKCS12_SAFEBAG_get1_crl := @FC_PKCS12_SAFEBAG_get1_crl
      {$else}
      PKCS12_SAFEBAG_get1_crl := @ERR_PKCS12_SAFEBAG_get1_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get1_crl_removed)}
   if PKCS12_SAFEBAG_get1_crl_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get1_crl)}
     PKCS12_SAFEBAG_get1_crl := @_PKCS12_SAFEBAG_get1_crl
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get1_crl)}
       PKCS12_SAFEBAG_get1_crl := @ERR_PKCS12_SAFEBAG_get1_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get1_crl) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get1_crl');
  end;


  if not assigned(PKCS12_SAFEBAG_get0_p8inf) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get0_p8inf_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get0_p8inf_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get0_p8inf)}
      PKCS12_SAFEBAG_get0_p8inf := @FC_PKCS12_SAFEBAG_get0_p8inf
      {$else}
      PKCS12_SAFEBAG_get0_p8inf := @ERR_PKCS12_SAFEBAG_get0_p8inf
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get0_p8inf_removed)}
   if PKCS12_SAFEBAG_get0_p8inf_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get0_p8inf)}
     PKCS12_SAFEBAG_get0_p8inf := @_PKCS12_SAFEBAG_get0_p8inf
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get0_p8inf)}
       PKCS12_SAFEBAG_get0_p8inf := @ERR_PKCS12_SAFEBAG_get0_p8inf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get0_p8inf) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get0_p8inf');
  end;


  if not assigned(PKCS12_SAFEBAG_get0_pkcs8) then 
  begin
    {$if declared(PKCS12_SAFEBAG_get0_pkcs8_introduced)}
    if LibVersion < PKCS12_SAFEBAG_get0_pkcs8_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_get0_pkcs8)}
      PKCS12_SAFEBAG_get0_pkcs8 := @FC_PKCS12_SAFEBAG_get0_pkcs8
      {$else}
      PKCS12_SAFEBAG_get0_pkcs8 := @ERR_PKCS12_SAFEBAG_get0_pkcs8
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_get0_pkcs8_removed)}
   if PKCS12_SAFEBAG_get0_pkcs8_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_get0_pkcs8)}
     PKCS12_SAFEBAG_get0_pkcs8 := @_PKCS12_SAFEBAG_get0_pkcs8
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_get0_pkcs8)}
       PKCS12_SAFEBAG_get0_pkcs8 := @ERR_PKCS12_SAFEBAG_get0_pkcs8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_get0_pkcs8) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_get0_pkcs8');
  end;


  if not assigned(PKCS12_SAFEBAG_create_cert) then 
  begin
    {$if declared(PKCS12_SAFEBAG_create_cert_introduced)}
    if LibVersion < PKCS12_SAFEBAG_create_cert_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_create_cert)}
      PKCS12_SAFEBAG_create_cert := @FC_PKCS12_SAFEBAG_create_cert
      {$else}
      PKCS12_SAFEBAG_create_cert := @ERR_PKCS12_SAFEBAG_create_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_create_cert_removed)}
   if PKCS12_SAFEBAG_create_cert_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_create_cert)}
     PKCS12_SAFEBAG_create_cert := @_PKCS12_SAFEBAG_create_cert
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_create_cert)}
       PKCS12_SAFEBAG_create_cert := @ERR_PKCS12_SAFEBAG_create_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_create_cert) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_create_cert');
  end;


  if not assigned(PKCS12_SAFEBAG_create_crl) then 
  begin
    {$if declared(PKCS12_SAFEBAG_create_crl_introduced)}
    if LibVersion < PKCS12_SAFEBAG_create_crl_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_create_crl)}
      PKCS12_SAFEBAG_create_crl := @FC_PKCS12_SAFEBAG_create_crl
      {$else}
      PKCS12_SAFEBAG_create_crl := @ERR_PKCS12_SAFEBAG_create_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_create_crl_removed)}
   if PKCS12_SAFEBAG_create_crl_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_create_crl)}
     PKCS12_SAFEBAG_create_crl := @_PKCS12_SAFEBAG_create_crl
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_create_crl)}
       PKCS12_SAFEBAG_create_crl := @ERR_PKCS12_SAFEBAG_create_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_create_crl) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_create_crl');
  end;


  if not assigned(PKCS12_SAFEBAG_create0_p8inf) then 
  begin
    {$if declared(PKCS12_SAFEBAG_create0_p8inf_introduced)}
    if LibVersion < PKCS12_SAFEBAG_create0_p8inf_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_create0_p8inf)}
      PKCS12_SAFEBAG_create0_p8inf := @FC_PKCS12_SAFEBAG_create0_p8inf
      {$else}
      PKCS12_SAFEBAG_create0_p8inf := @ERR_PKCS12_SAFEBAG_create0_p8inf
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_create0_p8inf_removed)}
   if PKCS12_SAFEBAG_create0_p8inf_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_create0_p8inf)}
     PKCS12_SAFEBAG_create0_p8inf := @_PKCS12_SAFEBAG_create0_p8inf
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_create0_p8inf)}
       PKCS12_SAFEBAG_create0_p8inf := @ERR_PKCS12_SAFEBAG_create0_p8inf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_create0_p8inf) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_create0_p8inf');
  end;


  if not assigned(PKCS12_SAFEBAG_create0_pkcs8) then 
  begin
    {$if declared(PKCS12_SAFEBAG_create0_pkcs8_introduced)}
    if LibVersion < PKCS12_SAFEBAG_create0_pkcs8_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_create0_pkcs8)}
      PKCS12_SAFEBAG_create0_pkcs8 := @FC_PKCS12_SAFEBAG_create0_pkcs8
      {$else}
      PKCS12_SAFEBAG_create0_pkcs8 := @ERR_PKCS12_SAFEBAG_create0_pkcs8
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_create0_pkcs8_removed)}
   if PKCS12_SAFEBAG_create0_pkcs8_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_create0_pkcs8)}
     PKCS12_SAFEBAG_create0_pkcs8 := @_PKCS12_SAFEBAG_create0_pkcs8
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_create0_pkcs8)}
       PKCS12_SAFEBAG_create0_pkcs8 := @ERR_PKCS12_SAFEBAG_create0_pkcs8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_create0_pkcs8) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_create0_pkcs8');
  end;


  if not assigned(PKCS12_SAFEBAG_create_pkcs8_encrypt) then 
  begin
    {$if declared(PKCS12_SAFEBAG_create_pkcs8_encrypt_introduced)}
    if LibVersion < PKCS12_SAFEBAG_create_pkcs8_encrypt_introduced then
      {$if declared(FC_PKCS12_SAFEBAG_create_pkcs8_encrypt)}
      PKCS12_SAFEBAG_create_pkcs8_encrypt := @FC_PKCS12_SAFEBAG_create_pkcs8_encrypt
      {$else}
      PKCS12_SAFEBAG_create_pkcs8_encrypt := @ERR_PKCS12_SAFEBAG_create_pkcs8_encrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_SAFEBAG_create_pkcs8_encrypt_removed)}
   if PKCS12_SAFEBAG_create_pkcs8_encrypt_removed <= LibVersion then
     {$if declared(_PKCS12_SAFEBAG_create_pkcs8_encrypt)}
     PKCS12_SAFEBAG_create_pkcs8_encrypt := @_PKCS12_SAFEBAG_create_pkcs8_encrypt
     {$else}
       {$IF declared(ERR_PKCS12_SAFEBAG_create_pkcs8_encrypt)}
       PKCS12_SAFEBAG_create_pkcs8_encrypt := @ERR_PKCS12_SAFEBAG_create_pkcs8_encrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_SAFEBAG_create_pkcs8_encrypt) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_SAFEBAG_create_pkcs8_encrypt');
  end;


  if not assigned(PKCS8_set0_pbe) then 
  begin
    {$if declared(PKCS8_set0_pbe_introduced)}
    if LibVersion < PKCS8_set0_pbe_introduced then
      {$if declared(FC_PKCS8_set0_pbe)}
      PKCS8_set0_pbe := @FC_PKCS8_set0_pbe
      {$else}
      PKCS8_set0_pbe := @ERR_PKCS8_set0_pbe
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS8_set0_pbe_removed)}
   if PKCS8_set0_pbe_removed <= LibVersion then
     {$if declared(_PKCS8_set0_pbe)}
     PKCS8_set0_pbe := @_PKCS8_set0_pbe
     {$else}
       {$IF declared(ERR_PKCS8_set0_pbe)}
       PKCS8_set0_pbe := @ERR_PKCS8_set0_pbe
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS8_set0_pbe) and Assigned(AFailed) then 
     AFailed.Add('PKCS8_set0_pbe');
  end;


  if not assigned(PKCS12_add_friendlyname_utf8) then 
  begin
    {$if declared(PKCS12_add_friendlyname_utf8_introduced)}
    if LibVersion < PKCS12_add_friendlyname_utf8_introduced then
      {$if declared(FC_PKCS12_add_friendlyname_utf8)}
      PKCS12_add_friendlyname_utf8 := @FC_PKCS12_add_friendlyname_utf8
      {$else}
      PKCS12_add_friendlyname_utf8 := @ERR_PKCS12_add_friendlyname_utf8
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_add_friendlyname_utf8_removed)}
   if PKCS12_add_friendlyname_utf8_removed <= LibVersion then
     {$if declared(_PKCS12_add_friendlyname_utf8)}
     PKCS12_add_friendlyname_utf8 := @_PKCS12_add_friendlyname_utf8
     {$else}
       {$IF declared(ERR_PKCS12_add_friendlyname_utf8)}
       PKCS12_add_friendlyname_utf8 := @ERR_PKCS12_add_friendlyname_utf8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_add_friendlyname_utf8) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_add_friendlyname_utf8');
  end;


  if not assigned(PKCS12_key_gen_utf8) then 
  begin
    {$if declared(PKCS12_key_gen_utf8_introduced)}
    if LibVersion < PKCS12_key_gen_utf8_introduced then
      {$if declared(FC_PKCS12_key_gen_utf8)}
      PKCS12_key_gen_utf8 := @FC_PKCS12_key_gen_utf8
      {$else}
      PKCS12_key_gen_utf8 := @ERR_PKCS12_key_gen_utf8
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS12_key_gen_utf8_removed)}
   if PKCS12_key_gen_utf8_removed <= LibVersion then
     {$if declared(_PKCS12_key_gen_utf8)}
     PKCS12_key_gen_utf8 := @_PKCS12_key_gen_utf8
     {$else}
       {$IF declared(ERR_PKCS12_key_gen_utf8)}
       PKCS12_key_gen_utf8 := @ERR_PKCS12_key_gen_utf8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS12_key_gen_utf8) and Assigned(AFailed) then 
     AFailed.Add('PKCS12_key_gen_utf8');
  end;


  if not assigned(OPENSSL_utf82uni) then 
  begin
    {$if declared(OPENSSL_utf82uni_introduced)}
    if LibVersion < OPENSSL_utf82uni_introduced then
      {$if declared(FC_OPENSSL_utf82uni)}
      OPENSSL_utf82uni := @FC_OPENSSL_utf82uni
      {$else}
      OPENSSL_utf82uni := @ERR_OPENSSL_utf82uni
      {$ifend}
    else
    {$ifend}
   {$if declared(OPENSSL_utf82uni_removed)}
   if OPENSSL_utf82uni_removed <= LibVersion then
     {$if declared(_OPENSSL_utf82uni)}
     OPENSSL_utf82uni := @_OPENSSL_utf82uni
     {$else}
       {$IF declared(ERR_OPENSSL_utf82uni)}
       OPENSSL_utf82uni := @ERR_OPENSSL_utf82uni
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OPENSSL_utf82uni) and Assigned(AFailed) then 
     AFailed.Add('OPENSSL_utf82uni');
  end;


  if not assigned(OPENSSL_uni2utf8) then 
  begin
    {$if declared(OPENSSL_uni2utf8_introduced)}
    if LibVersion < OPENSSL_uni2utf8_introduced then
      {$if declared(FC_OPENSSL_uni2utf8)}
      OPENSSL_uni2utf8 := @FC_OPENSSL_uni2utf8
      {$else}
      OPENSSL_uni2utf8 := @ERR_OPENSSL_uni2utf8
      {$ifend}
    else
    {$ifend}
   {$if declared(OPENSSL_uni2utf8_removed)}
   if OPENSSL_uni2utf8_removed <= LibVersion then
     {$if declared(_OPENSSL_uni2utf8)}
     OPENSSL_uni2utf8 := @_OPENSSL_uni2utf8
     {$else}
       {$IF declared(ERR_OPENSSL_uni2utf8)}
       OPENSSL_uni2utf8 := @ERR_OPENSSL_uni2utf8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OPENSSL_uni2utf8) and Assigned(AFailed) then 
     AFailed.Add('OPENSSL_uni2utf8');
  end;


end;

procedure Unload;
begin
  PKCS12_mac_present := nil; {introduced 1.1.0}
  PKCS12_get0_mac := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_attr := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_type := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get_nid := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get_bag_nid := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get1_cert := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get1_crl := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_p8inf := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_get0_pkcs8 := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create_cert := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create_crl := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_p8inf := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create0_pkcs8 := nil; {introduced 1.1.0}
  PKCS12_SAFEBAG_create_pkcs8_encrypt := nil; {introduced 1.1.0}
  PKCS12_item_pack_safebag := nil;
  PKCS8_decrypt := nil;
  PKCS12_decrypt_skey := nil;
  PKCS8_encrypt := nil;
  PKCS8_set0_pbe := nil; {introduced 1.1.0}
  PKCS12_add_localkeyid := nil;
  PKCS12_add_friendlyname_asc := nil;
  PKCS12_add_friendlyname_utf8 := nil; {introduced 1.1.0}
  PKCS12_add_CSPName_asc := nil;
  PKCS12_add_friendlyname_uni := nil;
  PKCS8_add_keyusage := nil;
  PKCS12_get_friendlyname := nil;
  PKCS12_pbe_crypt := nil;
  PKCS12_item_decrypt_d2i := nil;
  PKCS12_item_i2d_encrypt := nil;
  PKCS12_init := nil;
  PKCS12_key_gen_asc := nil;
  PKCS12_key_gen_uni := nil;
  PKCS12_key_gen_utf8 := nil; {introduced 1.1.0}
  PKCS12_PBE_keyivgen := nil;
  PKCS12_gen_mac := nil;
  PKCS12_verify_mac := nil;
  PKCS12_set_mac := nil;
  PKCS12_setup_mac := nil;
  OPENSSL_asc2uni := nil;
  OPENSSL_uni2asc := nil;
  OPENSSL_utf82uni := nil; {introduced 1.1.0}
  OPENSSL_uni2utf8 := nil; {introduced 1.1.0}
  PKCS12_new := nil;
  PKCS12_free := nil;
  d2i_PKCS12 := nil;
  i2d_PKCS12 := nil;
  PKCS12_it := nil;
  PKCS12_MAC_DATA_new := nil;
  PKCS12_MAC_DATA_free := nil;
  d2i_PKCS12_MAC_DATA := nil;
  i2d_PKCS12_MAC_DATA := nil;
  PKCS12_MAC_DATA_it := nil;
  PKCS12_SAFEBAG_new := nil;
  PKCS12_SAFEBAG_free := nil;
  d2i_PKCS12_SAFEBAG := nil;
  i2d_PKCS12_SAFEBAG := nil;
  PKCS12_SAFEBAG_it := nil;
  PKCS12_BAGS_new := nil;
  PKCS12_BAGS_free := nil;
  d2i_PKCS12_BAGS := nil;
  i2d_PKCS12_BAGS := nil;
  PKCS12_BAGS_it := nil;
  PKCS12_PBE_add := nil;
  PKCS12_parse := nil;
  PKCS12_create := nil;
  i2d_PKCS12_bio := nil;
  d2i_PKCS12_bio := nil;
  PKCS12_newpass := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
