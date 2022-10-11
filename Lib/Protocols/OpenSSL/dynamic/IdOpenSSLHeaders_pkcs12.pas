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

// Generation date: 11.10.2022 07:55:23

unit IdOpenSSLHeaders_pkcs12;

interface

// Headers for OpenSSL 1.1.1
// pkcs12.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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
  PPPKCS12_MAC_DATA = ^PKCS12_MAC_DATA;

  PKCS12_st = type Pointer;
  PKCS12 = PKCS12_st;
  PPKCS12 = ^PKCS12;
  PPPKCS12 = ^PPKCS12;

  PKCS12_SAFEBAG_st = type Pointer;
  PKCS12_SAFEBAG = PKCS12_SAFEBAG_st;
  PPKCS12_SAFEBAG = ^PKCS12_SAFEBAG;

//  DEFINE_STACK_OF(PKCS12_SAFEBAG)

  pkcs12_bag_st = type Pointer;
  PKCS12_BAGS = pkcs12_bag_st;
  PPKCS12_BAGS = ^PKCS12_BAGS;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  //ASN1_TYPE *PKCS8_get_attr(PKCS8_PRIV_KEY_INFO *p8, TIdC_INT attr_nid);
  PKCS12_mac_present: function(const p12: PPKCS12): TIdC_INT cdecl = nil;
  PKCS12_get0_mac: procedure(const pmac: PPASN1_OCTET_STRING; const pmacalg: PPX509_ALGOR; const psalt: PPASN1_OCTET_STRING; const piter: PPASN1_INTEGER; const p12: PPKCS12) cdecl = nil;

  PKCS12_SAFEBAG_get0_attr: function(const bag: PPKCS12_SAFEBAG; attr_nid: TIdC_INT): PASN1_TYPE cdecl = nil;
  PKCS12_SAFEBAG_get0_type: function(const bag: PPKCS12_SAFEBAG): PASN1_OBJECT cdecl = nil;
  PKCS12_SAFEBAG_get_nid: function(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl = nil;
  PKCS12_SAFEBAG_get_bag_nid: function(const bag: PPKCS12_SAFEBAG): TIdC_INT cdecl = nil;

  PKCS12_SAFEBAG_get1_cert: function(const bag: PPKCS12_SAFEBAG): PX509 cdecl = nil;
  PKCS12_SAFEBAG_get1_crl: function(const bag: PPKCS12_SAFEBAG): PX509_CRL cdecl = nil;
//  const STACK_OF(PKCS12_SAFEBAG) *PKCS12_SAFEBAG_get0_safes(const PKCS12_SAFEBAG *bag);
  PKCS12_SAFEBAG_get0_p8inf: function(const bag: PPKCS12_SAFEBAG): PPKCS8_PRIV_KEY_INFO cdecl = nil;
  PKCS12_SAFEBAG_get0_pkcs8: function(const bag: PPKCS12_SAFEBAG): PX509_SIG cdecl = nil;

  PKCS12_SAFEBAG_create_cert: function(x509: PX509): PPKCS12_SAFEBAG cdecl = nil;
  PKCS12_SAFEBAG_create_crl: function(crl: PX509_CRL): PPKCS12_SAFEBAG cdecl = nil;
  PKCS12_SAFEBAG_create0_p8inf: function(p8: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl = nil;
  PKCS12_SAFEBAG_create0_pkcs8: function(p8: PX509_SIG): PPKCS12_SAFEBAG cdecl = nil;
  PKCS12_SAFEBAG_create_pkcs8_encrypt: function(pbe_nid: TIdC_INT; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO): PPKCS12_SAFEBAG cdecl = nil;

  PKCS12_item_pack_safebag: function(obj: Pointer; const it: PASN1_ITEM; nid1: TIdC_INT; nid2: TIdC_INT): PPKCS12_SAFEBAG cdecl = nil;
  PKCS8_decrypt: function(const p8: PX509_SIG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl = nil;
  PKCS12_decrypt_skey: function(const bag: PPKCS12_SAFEBAG; const pass: PIdAnsiChar; passlen: TIdC_INT): PPKCS8_PRIV_KEY_INFO cdecl = nil;
  PKCS8_encrypt: function(pbe_nid: TIdC_INT; const cipher: PEVP_CIPHER; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; p8: PPKCS8_PRIV_KEY_INFO): PX509_SIG cdecl = nil;
  PKCS8_set0_pbe: function(const pass: PIdAnsiChar; passlen: TIdC_INT; p8inf: PPKCS8_PRIV_KEY_INFO; pbe: PX509_ALGOR): PX509_SIG cdecl = nil;
//  PKCS7 *PKCS12_pack_p7data(STACK_OF(PKCS12_SAFEBAG) *sk);
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7);
//  function PKCS12_pack_p7encdata(TIdC_INT pbe_nid, const PIdAnsiChar pass, TIdC_INT passlen,
//                               Byte *salt, TIdC_INT saltlen, TIdC_INT iter,
//                               STACK_OF(PKCS12_SAFEBAG) *bags): PPKCS7;
//  STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const PIdAnsiChar *pass,
//                                                    TIdC_INT passlen);

//  TIdC_INT PKCS12_pack_authsafes(PKCS12 *p12, STACK_OF(PKCS7) *safes);
//  STACK_OF(PKCS7) *PKCS12_unpack_authsafes(const PKCS12 *p12);

  PKCS12_add_localkeyid: function(bag: PPKCS12_SAFEBAG; name: PByte; namelen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_add_friendlyname_asc: function(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_add_friendlyname_utf8: function(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_add_CSPName_asc: function(bag: PPKCS12_SAFEBAG; const name: PIdAnsiChar; namelen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_add_friendlyname_uni: function(bag: PPKCS12_SAFEBAG; const name: PByte; namelen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS8_add_keyusage: function(p8: PPKCS8_PRIV_KEY_INFO; usage: TIdC_INT): TIdC_INT cdecl = nil;
//  function PKCS12_get_attr_gen(const STACK_OF(X509_ATTRIBUTE) *attrs; TIdC_INT attr_nid): PASN1_TYPE;
  PKCS12_get_friendlyname: function(bag: PPKCS12_SAFEBAG): PIdAnsiChar cdecl = nil;
//  const STACK_OF(X509_ATTRIBUTE) *PKCS12_SAFEBAG_get0_attrs(const PKCS12_SAFEBAG *bag);
  PKCS12_pbe_crypt: function(const algor: PX509_ALGOR; const pass: PIdAnsiChar; passlen: TIdC_INT; const in_: PByte; inlen: TIdC_INT; data: PPByte; datalen: PIdC_INT; en_de: TIdC_INT): PByte cdecl = nil;
  PKCS12_item_decrypt_d2i: function(const algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; const oct: PASN1_OCTET_STRING; zbuf: TIdC_INT): Pointer cdecl = nil;
  PKCS12_item_i2d_encrypt: function(algor: PX509_ALGOR; const it: PASN1_ITEM; const pass: PIdAnsiChar; passlen: TIdC_INT; obj: Pointer; zbuf: TIdC_INT): PASN1_OCTET_STRING cdecl = nil;
  PKCS12_init: function(mode: TIdC_INT): PPKCS12 cdecl = nil;
  PKCS12_key_gen_asc: function(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl = nil;
  PKCS12_key_gen_uni: function(pass: PByte; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl = nil;
  PKCS12_key_gen_utf8: function(const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; id: TIdC_INT; iter: TIdC_INT; n: TIdC_INT; out_: PByte; const md_type: PEVP_MD): TIdC_INT cdecl = nil;
  PKCS12_PBE_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md_type: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_gen_mac: function(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; mac: PByte; maclen: PIdC_UINT): TIdC_INT cdecl = nil;
  PKCS12_verify_mac: function(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS12_set_mac: function(p12: PPKCS12; const pass: PIdAnsiChar; passlen: TIdC_INT; salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl = nil;
  PKCS12_setup_mac: function(p12: PPKCS12; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; const md_type: PEVP_MD): TIdC_INT cdecl = nil;
  OPENSSL_asc2uni: function(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl = nil;
  OPENSSL_uni2asc: function(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl = nil;
  OPENSSL_utf82uni: function(const asc: PIdAnsiChar; asclen: TIdC_INT; uni: PPByte; unilen: PIdC_INT): PByte cdecl = nil;
  OPENSSL_uni2utf8: function(const uni: PByte; unilen: TIdC_INT): PIdAnsiChar cdecl = nil;

//  DECLARE_ASN1_FUNCTIONS(PKCS12)
//  DECLARE_ASN1_FUNCTIONS(PKCS12_MAC_DATA)
//  DECLARE_ASN1_FUNCTIONS(PKCS12_SAFEBAG)
//  DECLARE_ASN1_FUNCTIONS(PKCS12_BAGS)

//  DECLARE_ASN1_ITEM(PKCS12_SAFEBAGS)
//  DECLARE_ASN1_ITEM(PKCS12_AUTHSAFES)

  PKCS12_PBE_add: procedure(v: Pointer) cdecl = nil;
  PKCS12_parse: function(p12: PPKCS12; const pass: PIdAnsiChar; pkey: PPEVP_PKEY; cert: PPX509; ca: PPStack_Of_X509): TIdC_INT cdecl = nil;
  PKCS12_create: function(const pass: PIdAnsiChar; const name: PIdAnsiChar; pkey: PEVP_PKEY; cert: PX509; ca: PStack_Of_X509; nid_key: TIdC_INT; nid_cert: TIdC_INT; iter: TIdC_INT; mac_iter: TIdC_INT; keytype: TIdC_INT): PPKCS12 cdecl = nil;

//  function PKCS12_add_cert(STACK_OF(PKCS12_SAFEBAG) **pbags; X509 *cert): PKCS12_SAFEBAG;
//  PKCS12_SAFEBAG *PKCS12_add_key(STACK_OF(PKCS12_SAFEBAG) **pbags;
//                                 EVP_PKEY *key; TIdC_INT key_usage; iter: TIdC_INT;
//                                 TIdC_INT key_nid; const pass: PIdAnsiChar);
//  TIdC_INT PKCS12_add_safe(STACK_OF(PKCS7) **psafes; STACK_OF(PKCS12_SAFEBAG) *bags;
//                      TIdC_INT safe_nid; iter: TIdC_INT; const pass: PIdAnsiChar);
//  PKCS12 *PKCS12_add_safes(STACK_OF(PKCS7) *safes; TIdC_INT p7_nid);

  i2d_PKCS12_bio: function(bp: PBIO; p12: PPKCS12): TIdC_INT cdecl = nil;
  d2i_PKCS12_bio: function(bp: PBIO; p12: PPPKCS12): PPKCS12 cdecl = nil;
  PKCS12_newpass: function(p12: PPKCS12; const oldpass: PIdAnsiChar; const newpass: PIdAnsiChar): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  PKCS12_mac_present := LoadFunction('PKCS12_mac_present', AFailed);
  PKCS12_get0_mac := LoadFunction('PKCS12_get0_mac', AFailed);
  PKCS12_SAFEBAG_get0_attr := LoadFunction('PKCS12_SAFEBAG_get0_attr', AFailed);
  PKCS12_SAFEBAG_get0_type := LoadFunction('PKCS12_SAFEBAG_get0_type', AFailed);
  PKCS12_SAFEBAG_get_nid := LoadFunction('PKCS12_SAFEBAG_get_nid', AFailed);
  PKCS12_SAFEBAG_get_bag_nid := LoadFunction('PKCS12_SAFEBAG_get_bag_nid', AFailed);
  PKCS12_SAFEBAG_get1_cert := LoadFunction('PKCS12_SAFEBAG_get1_cert', AFailed);
  PKCS12_SAFEBAG_get1_crl := LoadFunction('PKCS12_SAFEBAG_get1_crl', AFailed);
  PKCS12_SAFEBAG_get0_p8inf := LoadFunction('PKCS12_SAFEBAG_get0_p8inf', AFailed);
  PKCS12_SAFEBAG_get0_pkcs8 := LoadFunction('PKCS12_SAFEBAG_get0_pkcs8', AFailed);
  PKCS12_SAFEBAG_create_cert := LoadFunction('PKCS12_SAFEBAG_create_cert', AFailed);
  PKCS12_SAFEBAG_create_crl := LoadFunction('PKCS12_SAFEBAG_create_crl', AFailed);
  PKCS12_SAFEBAG_create0_p8inf := LoadFunction('PKCS12_SAFEBAG_create0_p8inf', AFailed);
  PKCS12_SAFEBAG_create0_pkcs8 := LoadFunction('PKCS12_SAFEBAG_create0_pkcs8', AFailed);
  PKCS12_SAFEBAG_create_pkcs8_encrypt := LoadFunction('PKCS12_SAFEBAG_create_pkcs8_encrypt', AFailed);
  PKCS12_item_pack_safebag := LoadFunction('PKCS12_item_pack_safebag', AFailed);
  PKCS8_decrypt := LoadFunction('PKCS8_decrypt', AFailed);
  PKCS12_decrypt_skey := LoadFunction('PKCS12_decrypt_skey', AFailed);
  PKCS8_encrypt := LoadFunction('PKCS8_encrypt', AFailed);
  PKCS8_set0_pbe := LoadFunction('PKCS8_set0_pbe', AFailed);
  PKCS12_add_localkeyid := LoadFunction('PKCS12_add_localkeyid', AFailed);
  PKCS12_add_friendlyname_asc := LoadFunction('PKCS12_add_friendlyname_asc', AFailed);
  PKCS12_add_friendlyname_utf8 := LoadFunction('PKCS12_add_friendlyname_utf8', AFailed);
  PKCS12_add_CSPName_asc := LoadFunction('PKCS12_add_CSPName_asc', AFailed);
  PKCS12_add_friendlyname_uni := LoadFunction('PKCS12_add_friendlyname_uni', AFailed);
  PKCS8_add_keyusage := LoadFunction('PKCS8_add_keyusage', AFailed);
  PKCS12_get_friendlyname := LoadFunction('PKCS12_get_friendlyname', AFailed);
  PKCS12_pbe_crypt := LoadFunction('PKCS12_pbe_crypt', AFailed);
  PKCS12_item_decrypt_d2i := LoadFunction('PKCS12_item_decrypt_d2i', AFailed);
  PKCS12_item_i2d_encrypt := LoadFunction('PKCS12_item_i2d_encrypt', AFailed);
  PKCS12_init := LoadFunction('PKCS12_init', AFailed);
  PKCS12_key_gen_asc := LoadFunction('PKCS12_key_gen_asc', AFailed);
  PKCS12_key_gen_uni := LoadFunction('PKCS12_key_gen_uni', AFailed);
  PKCS12_key_gen_utf8 := LoadFunction('PKCS12_key_gen_utf8', AFailed);
  PKCS12_PBE_keyivgen := LoadFunction('PKCS12_PBE_keyivgen', AFailed);
  PKCS12_gen_mac := LoadFunction('PKCS12_gen_mac', AFailed);
  PKCS12_verify_mac := LoadFunction('PKCS12_verify_mac', AFailed);
  PKCS12_set_mac := LoadFunction('PKCS12_set_mac', AFailed);
  PKCS12_setup_mac := LoadFunction('PKCS12_setup_mac', AFailed);
  OPENSSL_asc2uni := LoadFunction('OPENSSL_asc2uni', AFailed);
  OPENSSL_uni2asc := LoadFunction('OPENSSL_uni2asc', AFailed);
  OPENSSL_utf82uni := LoadFunction('OPENSSL_utf82uni', AFailed);
  OPENSSL_uni2utf8 := LoadFunction('OPENSSL_uni2utf8', AFailed);
  PKCS12_PBE_add := LoadFunction('PKCS12_PBE_add', AFailed);
  PKCS12_parse := LoadFunction('PKCS12_parse', AFailed);
  PKCS12_create := LoadFunction('PKCS12_create', AFailed);
  i2d_PKCS12_bio := LoadFunction('i2d_PKCS12_bio', AFailed);
  d2i_PKCS12_bio := LoadFunction('d2i_PKCS12_bio', AFailed);
  PKCS12_newpass := LoadFunction('PKCS12_newpass', AFailed);
end;

procedure UnLoad;
begin
  PKCS12_mac_present := nil;
  PKCS12_get0_mac := nil;
  PKCS12_SAFEBAG_get0_attr := nil;
  PKCS12_SAFEBAG_get0_type := nil;
  PKCS12_SAFEBAG_get_nid := nil;
  PKCS12_SAFEBAG_get_bag_nid := nil;
  PKCS12_SAFEBAG_get1_cert := nil;
  PKCS12_SAFEBAG_get1_crl := nil;
  PKCS12_SAFEBAG_get0_p8inf := nil;
  PKCS12_SAFEBAG_get0_pkcs8 := nil;
  PKCS12_SAFEBAG_create_cert := nil;
  PKCS12_SAFEBAG_create_crl := nil;
  PKCS12_SAFEBAG_create0_p8inf := nil;
  PKCS12_SAFEBAG_create0_pkcs8 := nil;
  PKCS12_SAFEBAG_create_pkcs8_encrypt := nil;
  PKCS12_item_pack_safebag := nil;
  PKCS8_decrypt := nil;
  PKCS12_decrypt_skey := nil;
  PKCS8_encrypt := nil;
  PKCS8_set0_pbe := nil;
  PKCS12_add_localkeyid := nil;
  PKCS12_add_friendlyname_asc := nil;
  PKCS12_add_friendlyname_utf8 := nil;
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
  PKCS12_key_gen_utf8 := nil;
  PKCS12_PBE_keyivgen := nil;
  PKCS12_gen_mac := nil;
  PKCS12_verify_mac := nil;
  PKCS12_set_mac := nil;
  PKCS12_setup_mac := nil;
  OPENSSL_asc2uni := nil;
  OPENSSL_uni2asc := nil;
  OPENSSL_utf82uni := nil;
  OPENSSL_uni2utf8 := nil;
  PKCS12_PBE_add := nil;
  PKCS12_parse := nil;
  PKCS12_create := nil;
  i2d_PKCS12_bio := nil;
  d2i_PKCS12_bio := nil;
  PKCS12_newpass := nil;
end;

end.
