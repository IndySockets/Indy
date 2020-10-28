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

// Generation date: 28.10.2020 15:24:33

unit IdOpenSSLHeaders_pem;

interface

// Headers for OpenSSL 1.1.1
// pem.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ec,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_pkcs7,
  IdOpenSSLHeaders_x509;
  
type
  EVP_CIPHER_INFO = type Pointer;
  PEVP_CIPHER_INFO = ^EVP_CIPHER_INFO;

const
  PEM_BUFSIZE             = 1024;

  PEM_STRING_X509_OLD     = AnsiString('X509 CERTIFICATE');
  PEM_STRING_X509         = AnsiString('CERTIFICATE');
  PEM_STRING_X509_TRUSTED = AnsiString('TRUSTED CERTIFICATE');
  PEM_STRING_X509_REQ_OLD = AnsiString('NEW CERTIFICATE REQUEST');
  PEM_STRING_X509_REQ     = AnsiString('CERTIFICATE REQUEST');
  PEM_STRING_X509_CRL     = AnsiString('X509 CRL');
  PEM_STRING_EVP_PKEY     = AnsiString('ANY PRIVATE KEY');
  PEM_STRING_PUBLIC       = AnsiString('PUBLIC KEY');
  PEM_STRING_RSA          = AnsiString('RSA PRIVATE KEY');
  PEM_STRING_RSA_PUBLIC   = AnsiString('RSA PUBLIC KEY');
  PEM_STRING_DSA          = AnsiString('DSA PRIVATE KEY');
  PEM_STRING_DSA_PUBLIC   = AnsiString('DSA PUBLIC KEY');
  PEM_STRING_PKCS7        = AnsiString('PKCS7');
  PEM_STRING_PKCS7_SIGNED = AnsiString('PKCS #7 SIGNED DATA');
  PEM_STRING_PKCS8        = AnsiString('ENCRYPTED PRIVATE KEY');
  PEM_STRING_PKCS8INF     = AnsiString('PRIVATE KEY');
  PEM_STRING_DHPARAMS     = AnsiString('DH PARAMETERS');
  PEM_STRING_DHXPARAMS    = AnsiString('X9.42 DH PARAMETERS');
  PEM_STRING_SSL_SESSION  = AnsiString('SSL SESSION PARAMETERS');
  PEM_STRING_DSAPARAMS    = AnsiString('DSA PARAMETERS');
  PEM_STRING_ECDSA_PUBLIC = AnsiString('ECDSA PUBLIC KEY');
  PEM_STRING_ECPARAMETERS = AnsiString('EC PARAMETERS');
  PEM_STRING_ECPRIVATEKEY = AnsiString('EC PRIVATE KEY');
  PEM_STRING_PARAMETERS   = AnsiString('PARAMETERS');
  PEM_STRING_CMS          = AnsiString('CMS');

  PEM_TYPE_ENCRYPTED      = 10;
  PEM_TYPE_MIC_ONLY       = 20;
  PEM_TYPE_MIC_CLEAR      = 30;
  PEM_TYPE_CLEAR          = 40;

  PEM_FLAG_SECURE         = $1;
  PEM_FLAG_EAY_COMPATIBLE = $2;
  PEM_FLAG_ONLY_B64       = $4;

type
  pem_password_cb = function(buf: PIdAnsiChar; size: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT; cdecl;

  function PEM_get_EVP_CIPHER_INFO(header: PIdAnsiChar; cipher: PEVP_CIPHER_INFO): TIdC_INT cdecl; external CLibCrypto;
  function PEM_do_header(cipher: PEVP_CIPHER_INFO; data: PByte; len: PIdC_LONG; callback: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio(bp: PBIO; name: PPIdAnsiChar; header: PPIdAnsiChar; data: PPByte; len: PIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function PEM_read_bio_ex(bp: PBIO; name: PPIdAnsiChar; header: PPIdAnsiChar; data: PPByte; len: PIdC_LONG; flags: TIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function PEM_bytes_read_bio_secmem(pdata: PPByte; plen: PIdC_LONG; pnm: PPIdAnsiChar; const name: PIdAnsiChar; bp: PBIO; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PEM_write_bio(bp: PBIO; const name: PIdAnsiChar; const hdr: PIdAnsiChar; const data: PByte; len: TIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function PEM_bytes_read_bio(pdata: PPByte; plen: PIdC_LONG; pnm: PPIdAnsiChar; const name: PIdAnsiChar; bp: PBIO; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PEM_ASN1_read_bio(d2i: d2i_of_void; const name: PIdAnsiChar; bp: PBIO; x: PPointer; cb: pem_password_cb; u: Pointer): Pointer cdecl; external CLibCrypto;
  function PEM_ASN1_write_bio(i2d: i2d_of_void; const name: PIdAnsiChar; bp: PBIO; x: Pointer; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  //function PEM_X509_INFO_read_bio(bp: PBIO; sk: PSTACK_OF_X509_INFO; cb: pem_password_cb; u: Pointer): PSTACK_OF_X509_INFO;
  function PEM_X509_INFO_write_bio(bp: PBIO; xi: PX509_INFO; enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cd: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_SignInit(ctx: PEVP_MD_CTX; type_: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PEM_SignUpdate(ctx: PEVP_MD_CTX; d: PByte; cnt: Byte): TIdC_INT cdecl; external CLibCrypto;
  function PEM_SignFinal(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  (* The default pem_password_cb that's used internally *)
  function PEM_def_callback(buf: PIdAnsiChar; num: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT cdecl; external CLibCrypto;
  procedure PEM_proc_type(buf: PIdAnsiChar; type_: TIdC_INT) cdecl; external CLibCrypto;
  procedure PEM_dek_info(buf: PIdAnsiChar; const type_: PIdAnsiChar; len: TIdC_INT; str: PIdAnsiChar) cdecl; external CLibCrypto;

  function PEM_read_bio_X509(bp: PBIO; x: PPX509; cb: pem_password_cb; u: Pointer): PX509 cdecl; external CLibCrypto;
  function PEM_write_bio_X509(bp: PBIO; x: PX509): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_X509_AUX(bp: PBIO; x: PPX509; cb: pem_password_cb; u: Pointer): PX509 cdecl; external CLibCrypto;
  function PEM_write_bio_X509_AUX(bp: PBIO; x: PX509): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_X509_REQ(bp: PBIO; x: PPX509_REQ; cb: pem_password_cb; u: Pointer): PX509_REQ cdecl; external CLibCrypto;
  function PEM_write_bio_X509_REQ(bp: PBIO; x: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;

  function PEM_write_bio_X509_REQ_NEW(bp: PBIO; x: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_X509_CRL(bp: PBIO; x: PPX509_CRL; cb: pem_password_cb; u: Pointer): PX509_CRL cdecl; external CLibCrypto;
  function PEM_write_bio_X509_CRL(bp: PBIO; x: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_PKCS7(bp: PBIO; x: PPPKCS7; cb: pem_password_cb; u: Pointer): PPKCS7 cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS7(bp: PBIO; x: PPKCS7): TIdC_INT cdecl; external CLibCrypto;

//  function PEM_read_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PPNETSCAPE_CERT_SEQUENCE; cb: pem_password_cb; u: Pointer): PNETSCAPE_CERT_SEQUENCE;
//  function PEM_write_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PNETSCAPE_CERT_SEQUENCE): TIdC_INT;

  function PEM_read_bio_PKCS8(bp: PBIO; x: PPX509_SIG; cb: pem_password_cb; u: Pointer): PX509_SIG cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS8(bp: PBIO; x: PX509_SIG): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPPKCS8_PRIV_KEY_INFO; cb: pem_password_cb; u: Pointer): PPKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS8_PRIV_KEY_INFO(bp: PBIO; x: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl; external CLibCrypto;

  // RSA
  function PEM_read_bio_RSAPrivateKey(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl; external CLibCrypto;
  function PEM_write_bio_RSAPrivateKey(bp: PBIO; x: PRSA; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_RSAPublicKey(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl; external CLibCrypto;
  function PEM_write_bio_RSAPublicKey(bp: PBIO; const x: PRSA): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_RSA_PUBKEY(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl; external CLibCrypto;
  function PEM_write_bio_RSA_PUBKEY(bp: PBIO; x: PRSA): TIdC_INT cdecl; external CLibCrypto;
  // ~RSA

  // DSA
  function PEM_read_bio_DSAPrivateKey(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl; external CLibCrypto;
  function PEM_write_bio_DSAPrivateKey(bp: PBIO; x: PDSA; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_DSA_PUBKEY(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl; external CLibCrypto;
  function PEM_write_bio_DSA_PUBKEY(bp: PBIO; x: PDSA): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_DSAparams(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl; external CLibCrypto;
  function PEM_write_bio_DSAparams(bp: PBIO; const x: PDSA): TIdC_INT cdecl; external CLibCrypto;
  // ~DSA

  // EC
  function PEM_read_bio_ECPKParameters(bp: PBIO; x: PPEC_GROUP; cb: pem_password_cb; u: Pointer): PEC_GROUP cdecl; external CLibCrypto;
  function PEM_write_bio_ECPKParameters(bp: PBIO; const x: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_ECPrivateKey(bp: PBIO; x: PPEC_KEY; cb: pem_password_cb; u: Pointer): PEC_KEY cdecl; external CLibCrypto;
  function PEM_write_bio_ECPrivateKey(bp: PBIO; x: PEC_KEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_EC_PUBKEY(bp: PBIO; x: PPEC_KEY; cb: pem_password_cb; u: Pointer): PEC_KEY cdecl; external CLibCrypto;
  function PEM_write_bio_EC_PUBKEY(bp: PBIO; x: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  // ~EC

  // DH
  function PEM_read_bio_DHparams(bp: PBIO; x: PPDH; cb: pem_password_cb; u: Pointer): PDH cdecl; external CLibCrypto;
  function PEM_write_bio_DHparams(bp: PBIO; const x: PDH): TIdC_INT cdecl; external CLibCrypto;

  function PEM_write_bio_DHxparams(bp: PBIO; const x: PDH): TIdC_INT cdecl; external CLibCrypto;
  // ~DH

  function PEM_read_bio_PrivateKey(bp: PBIO; x: PPEVP_PKEY; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl; external CLibCrypto;
  function PEM_write_bio_PrivateKey(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function PEM_read_bio_PUBKEY(bp: PBIO; x: PPEVP_PKEY; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl; external CLibCrypto;
  function PEM_write_bio_PUBKEY(bp: PBIO; x: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function PEM_write_bio_PrivateKey_traditional(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS8PrivateKey_nid(bp: PBIO; x: PEVP_PKEY; nid: TIdC_INT; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS8PrivateKey(bp: PBIO; x: PEVP_PKEY_METHOD; const enc: PEVP_CIPHER; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function i2d_PKCS8PrivateKey_bio(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER_CTX; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function i2d_PKCS8PrivateKey_nid_bio(bp: PBIO; x: PEVP_PKEY; nid: TIdC_INT; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PKCS8PrivateKey_bio(bp: PBIO; x: PPEVP_PKEY_CTX; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl; external CLibCrypto;

  function PEM_read_bio_Parameters(bp: PBIO; x: PPEVP_PKEY): PEVP_PKEY cdecl; external CLibCrypto;
  function PEM_write_bio_Parameters(bp: PBIO; x: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function b2i_PrivateKey(const in_: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external CLibCrypto;
  function b2i_PublicKey(const in_: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external CLibCrypto;
  function b2i_PrivateKey_bio(&in: PBIO): PEVP_PKEY cdecl; external CLibCrypto;
  function b2i_PublicKey_bio(&in: PBIO): PEVP_PKEY cdecl; external CLibCrypto;
  function i2b_PrivateKey_bio(&out: PBIO; pk: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function i2b_PublicKey_bio(&out: PBIO; pk: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function b2i_PVK_bio(&in: PBIO; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl; external CLibCrypto;
  function i2b_PVK_bio(&out: PBIO; pk: PEVP_PKEY; enclevel: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

implementation

end.
