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
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 11.10.2022 09:03:30

unit IdOpenSSLHeaders_pkcs12;

interface

// Headers for OpenSSL 1.1.1
// pkcs12.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
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
  function PKCS12_mac_present(const p12: PPKCS12): TIdC_INT cdecl; external CLibCrypto;
  procedure PKCS12_get0_mac(const pmac: PPASN1_OCTET_STRING; const pmacalg: PPX509_ALGOR; const psalt: PPASN1_OCTET_STRING; const piter: PPASN1_INTEGER; const p12: PPKCS12) cdecl; external CLibCrypto;

  function PKCS12_SAFEBAG_get0_attr(const bag: PPKCS12_SAFEBAG; attr_nid: TIdC_INT): PASN1_TYPE cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_get0_type(const bag: PPKCS12_SAFEBAG): PASN1_OBJECT cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_get_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_get_bag_nid(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl; external CLibCrypto;

  function PKCS12_SAFEBAG_get1_cert(const bag: PPKCS12_SAFEBAG): PX509 cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_get1_crl(const bag: PPKCS12_SAFEBAG): PX509_CRL cdecl; external CLibCrypto;
//  const STACK_OF(PKCS12_SAFEBAG) *PKCS12_SAFEBAG_get0_safes(const PKCS12_SAFEBAG *bag);
  function PKCS12_SAFEBAG_get0_p8inf(const bag: PPKCS12_SAFEBAG): PPKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_get0_pkcs8(const bag: PPKCS12_SAFEBAG): PX509_SIG cdecl; external CLibCrypto;

  function PKCS12_SAFEBAG_create_cert(x509: PX509): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_create_crl(crl: PX509_CRL): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_create0_p8inf(p8: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_create0_pkcs8(p8: PX509_SIG): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_create_pkcs8_encrypt(pbe_nid: TIdC_INT; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl; external CLibCrypto;

  function PKCS12_item_pack_safebag(obj: Pointer; const it: PASN1_ITEM; nid1: TIdC_INT; nid2: TIdC_INT): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function PKCS8_decrypt(const p8: PX509_SIG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;
  function PKCS12_decrypt_skey(const bag: PPKCS12_SAFEBAG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;
  function PKCS8_encrypt(pbe_nid: TIdC_INT; const cipher: PEVP_CIPHER; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8: PPKCS8_PRIV_KEY_INFO): PX509_SIG cdecl; external CLibCrypto;
  function PKCS8_set0_pbe(const pass: PIdAnsiChar; passlen: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO; pbe: PX509_ALGOR): PX509_SIG cdecl; external CLibCrypto;
//  PKCS7 *PKCS12_pack_p7data(STACK_OF(PKCS12_SAFEBAG) *sk);
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7);
//  function PKCS12_pack_p7encdata(TIdC_INT pbe_nid, const PIdAnsiChar pass, TIdC_INT passlen,
//                               Byte *salt, TIdC_INT saltlen, TIdC_INT iter,
//                               STACK_OF(PKCS12_SAFEBAG) *bags): PPKCS7;
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const PIdAnsiChar *pass,
//                                                    TIdC_INT passlen);

//  TIdC_INT PKCS12_pack_authsafes(PKCS12 *p12, STACK_OF(PKCS7) *safes);
//  STACK_OF(PKCS7) *PKCS12_unpack_authsafes(const PKCS12 *p12);

  function PKCS12_add_localkeyid(bag: PPKCS12_SAFEBAG; name: PByte; namelen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_add_friendlyname_asc(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_add_friendlyname_utf8(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_add_CSPName_asc(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_add_friendlyname_uni(bag: PPKCS12_SAFEBAG; const name: PByte; namelen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS8_add_keyusage(p8: PPKCS8_PRIV_KEY_INFO; usage: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
//  function PKCS12_get_attr_gen(const STACK_OF(X509_ATTRIBUTE) *attrs; TIdC_INT attr_nid): PASN1_TYPE;
  function PKCS12_get_friendlyname(bag: PPKCS12_SAFEBAG): PIdAnsiChar cdecl; external CLibCrypto;
//  const STACK_OF(X509_ATTRIBUTE) *PKCS12_SAFEBAG_get0_attrs(const PKCS12_SAFEBAG *bag);
  function PKCS12_pbe_crypt(const algor: PX509_ALGOR; const pass: PIdAnsiChar; passlen: TIdC_INT; const in_: PByte; inlen: TIdC_INT; data: PPByte; datalen: PIdC_INT; en_de: TIdC_INT): PByte cdecl; external CLibCrypto;
  function PKCS12_item_decrypt_d2i(const algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; const oct: PASN1_OCTET_STRING; zbuf: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function PKCS12_item_i2d_encrypt(algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; obj: Pointer; zbuf: TIdC_INT): PASN1_OCTET_STRING cdecl; external CLibCrypto;
  function PKCS12_init(mode: TIdC_INT): PPKCS12 cdecl; external CLibCrypto;
  function PKCS12_key_gen_asc(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_key_gen_uni(pass: PByte; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_key_gen_utf8(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md_type: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_gen_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; mac: PByte; maclen: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_verify_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_set_mac(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_setup_mac(p12: PPKCS12; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function OPENSSL_asc2uni(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl; external CLibCrypto;
  function OPENSSL_uni2asc(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function OPENSSL_utf82uni(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl; external CLibCrypto;
  function OPENSSL_uni2utf8(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;

  function PKCS12_new: PPKCS12 cdecl; external CLibCrypto;
  procedure PKCS12_free(a: PPKCS12) cdecl; external CLibCrypto;
  function d2i_PKCS12(a: PPPKCS12; const in_: PPByte; len: TIdC_LONG): PPKCS12 cdecl; external CLibCrypto;
  function i2d_PKCS12(a: PPKCS12; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_it: PASN1_ITEM cdecl; external CLibCrypto;

  function PKCS12_MAC_DATA_new: PPKCS12_MAC_DATA cdecl; external CLibCrypto;
  procedure PKCS12_MAC_DATA_free(a: PPKCS12_MAC_DATA) cdecl; external CLibCrypto;
  function d2i_PKCS12_MAC_DATA(a: PPPKCS12_MAC_DATA; const in_: PPByte; len: TIdC_LONG): PPKCS12_MAC_DATA cdecl; external CLibCrypto;
  function i2d_PKCS12_MAC_DATA(a: PPKCS12_MAC_DATA; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_MAC_DATA_it: PASN1_ITEM cdecl; external CLibCrypto;

  function PKCS12_SAFEBAG_new: PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  procedure PKCS12_SAFEBAG_free(a: PPKCS12_SAFEBAG) cdecl; external CLibCrypto;
  function d2i_PKCS12_SAFEBAG(a: PPPKCS12_SAFEBAG; const in_: PPByte; len: TIdC_LONG): PPKCS12_SAFEBAG cdecl; external CLibCrypto;
  function i2d_PKCS12_SAFEBAG(a: PPKCS12_SAFEBAG; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_SAFEBAG_it: PASN1_ITEM cdecl; external CLibCrypto;

  function PKCS12_BAGS_new: PPKCS12_BAGS cdecl; external CLibCrypto;
  procedure PKCS12_BAGS_free(a: PPKCS12_BAGS) cdecl; external CLibCrypto;
  function d2i_PKCS12_BAGS(a: PPPKCS12_BAGS; const in_: PPByte; len: TIdC_LONG): PPKCS12_BAGS cdecl; external CLibCrypto;
  function i2d_PKCS12_BAGS(a: PPKCS12_BAGS; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_BAGS_it: PASN1_ITEM cdecl; external CLibCrypto;

  procedure PKCS12_PBE_add(v: Pointer) cdecl; external CLibCrypto;
  function PKCS12_parse(p12: PPKCS12; const pass: PIdAnsiChar; pkey: PPEVP_PKEY; cert: PPX509; ca: PPStack_Of_X509): TIdC_INT cdecl; external CLibCrypto;
  function PKCS12_create(const pass: PIdAnsiChar; const name: PIdAnsiChar; pkey: PEVP_PKEY; cert: PX509; ca: PStack_Of_X509; nid_key: TIdC_INT; nid_cert: TIdC_INT; iter: TIdC_INT; mac_iter: TIdC_INT; keytype: TIdC_INT): PPKCS12 cdecl; external CLibCrypto;

//  function PKCS12_add_cert(STACK_OF(PKCS12_SAFEBAG) **pbags; X509 *cert): PKCS12_SAFEBAG;
//  PKCS12_SAFEBAG *PKCS12_add_key(STACK_OF(PKCS12_SAFEBAG) **pbags;
//                                 EVP_PKEY *key; TIdC_INT key_usage; iter: TIdC_INT;
//                                 TIdC_INT key_nid; const pass: PIdAnsiChar);
//  TIdC_INT PKCS12_add_safe(STACK_OF(PKCS7) **psafes; STACK_OF(PKCS12_SAFEBAG) *bags;
//                      TIdC_INT safe_nid; iter: TIdC_INT; const pass: PIdAnsiChar);
//  PKCS12 *PKCS12_add_safes(STACK_OF(PKCS7) *safes; TIdC_INT p7_nid);

  function i2d_PKCS12_bio(bp: PBIO; p12: PPKCS12): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PKCS12_bio(bp: PBIO; p12: PPPKCS12): PPKCS12 cdecl; external CLibCrypto;
  function PKCS12_newpass(p12: PPKCS12; const oldpass: PIdAnsiChar; const newpass: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;

implementation

end.
