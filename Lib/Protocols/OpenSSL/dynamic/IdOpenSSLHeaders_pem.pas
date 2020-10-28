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

// Generation date: 28.10.2020 15:24:13

unit IdOpenSSLHeaders_pem;

interface

// Headers for OpenSSL 1.1.1
// pem.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  PEM_get_EVP_CIPHER_INFO: function(header: PIdAnsiChar; cipher: PEVP_CIPHER_INFO): TIdC_INT cdecl = nil;
  PEM_do_header: function(cipher: PEVP_CIPHER_INFO; data: PByte; len: PIdC_LONG; callback: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_read_bio: function(bp: PBIO; name: PPIdAnsiChar; header: PPIdAnsiChar; data: PPByte; len: PIdC_LONG): TIdC_INT cdecl = nil;
  PEM_read_bio_ex: function(bp: PBIO; name: PPIdAnsiChar; header: PPIdAnsiChar; data: PPByte; len: PIdC_LONG; flags: TIdC_UINT): TIdC_INT cdecl = nil;
  PEM_bytes_read_bio_secmem: function(pdata: PPByte; plen: PIdC_LONG; pnm: PPIdAnsiChar; const name: PIdAnsiChar; bp: PBIO; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  PEM_write_bio: function(bp: PBIO; const name: PIdAnsiChar; const hdr: PIdAnsiChar; const data: PByte; len: TIdC_LONG): TIdC_INT cdecl = nil;
  PEM_bytes_read_bio: function(pdata: PPByte; plen: PIdC_LONG; pnm: PPIdAnsiChar; const name: PIdAnsiChar; bp: PBIO; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  PEM_ASN1_read_bio: function(d2i: d2i_of_void; const name: PIdAnsiChar; bp: PBIO; x: PPointer; cb: pem_password_cb; u: Pointer): Pointer cdecl = nil;
  PEM_ASN1_write_bio: function(i2d: i2d_of_void; const name: PIdAnsiChar; bp: PBIO; x: Pointer; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  //function PEM_X509_INFO_read_bio(bp: PBIO; sk: PSTACK_OF_X509_INFO; cb: pem_password_cb; u: Pointer): PSTACK_OF_X509_INFO;
  PEM_X509_INFO_write_bio: function(bp: PBIO; xi: PX509_INFO; enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cd: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_SignInit: function(ctx: PEVP_MD_CTX; type_: PEVP_MD): TIdC_INT cdecl = nil;
  PEM_SignUpdate: function(ctx: PEVP_MD_CTX; d: PByte; cnt: Byte): TIdC_INT cdecl = nil;
  PEM_SignFinal: function(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  (* The default pem_password_cb that's used internally *)
  PEM_def_callback: function(buf: PIdAnsiChar; num: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT cdecl = nil;
  PEM_proc_type: procedure(buf: PIdAnsiChar; type_: TIdC_INT) cdecl = nil;
  PEM_dek_info: procedure(buf: PIdAnsiChar; const type_: PIdAnsiChar; len: TIdC_INT; str: PIdAnsiChar) cdecl = nil;

  PEM_read_bio_X509: function(bp: PBIO; x: PPX509; cb: pem_password_cb; u: Pointer): PX509 cdecl = nil;
  PEM_write_bio_X509: function(bp: PBIO; x: PX509): TIdC_INT cdecl = nil;

  PEM_read_bio_X509_AUX: function(bp: PBIO; x: PPX509; cb: pem_password_cb; u: Pointer): PX509 cdecl = nil;
  PEM_write_bio_X509_AUX: function(bp: PBIO; x: PX509): TIdC_INT cdecl = nil;

  PEM_read_bio_X509_REQ: function(bp: PBIO; x: PPX509_REQ; cb: pem_password_cb; u: Pointer): PX509_REQ cdecl = nil;
  PEM_write_bio_X509_REQ: function(bp: PBIO; x: PX509_REQ): TIdC_INT cdecl = nil;

  PEM_write_bio_X509_REQ_NEW: function(bp: PBIO; x: PX509_REQ): TIdC_INT cdecl = nil;

  PEM_read_bio_X509_CRL: function(bp: PBIO; x: PPX509_CRL; cb: pem_password_cb; u: Pointer): PX509_CRL cdecl = nil;
  PEM_write_bio_X509_CRL: function(bp: PBIO; x: PX509_CRL): TIdC_INT cdecl = nil;

  PEM_read_bio_PKCS7: function(bp: PBIO; x: PPPKCS7; cb: pem_password_cb; u: Pointer): PPKCS7 cdecl = nil;
  PEM_write_bio_PKCS7: function(bp: PBIO; x: PPKCS7): TIdC_INT cdecl = nil;

//  function PEM_read_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PPNETSCAPE_CERT_SEQUENCE; cb: pem_password_cb; u: Pointer): PNETSCAPE_CERT_SEQUENCE;
//  function PEM_write_bio_NETSCAPE_CERT_SEQUENCE(bp: PBIO; x: PNETSCAPE_CERT_SEQUENCE): TIdC_INT;

  PEM_read_bio_PKCS8: function(bp: PBIO; x: PPX509_SIG; cb: pem_password_cb; u: Pointer): PX509_SIG cdecl = nil;
  PEM_write_bio_PKCS8: function(bp: PBIO; x: PX509_SIG): TIdC_INT cdecl = nil;

  PEM_read_bio_PKCS8_PRIV_KEY_INFO: function(bp: PBIO; x: PPPKCS8_PRIV_KEY_INFO; cb: pem_password_cb; u: Pointer): PPKCS8_PRIV_KEY_INFO cdecl = nil;
  PEM_write_bio_PKCS8_PRIV_KEY_INFO: function(bp: PBIO; x: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl = nil;

  // RSA
  PEM_read_bio_RSAPrivateKey: function(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl = nil;
  PEM_write_bio_RSAPrivateKey: function(bp: PBIO; x: PRSA; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_read_bio_RSAPublicKey: function(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl = nil;
  PEM_write_bio_RSAPublicKey: function(bp: PBIO; const x: PRSA): TIdC_INT cdecl = nil;

  PEM_read_bio_RSA_PUBKEY: function(bp: PBIO; x: PPRSA; cb: pem_password_cb; u: Pointer): PRSA cdecl = nil;
  PEM_write_bio_RSA_PUBKEY: function(bp: PBIO; x: PRSA): TIdC_INT cdecl = nil;
  // ~RSA

  // DSA
  PEM_read_bio_DSAPrivateKey: function(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl = nil;
  PEM_write_bio_DSAPrivateKey: function(bp: PBIO; x: PDSA; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_read_bio_DSA_PUBKEY: function(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl = nil;
  PEM_write_bio_DSA_PUBKEY: function(bp: PBIO; x: PDSA): TIdC_INT cdecl = nil;

  PEM_read_bio_DSAparams: function(bp: PBIO; x: PPDSA; cb: pem_password_cb; u: Pointer): PDSA cdecl = nil;
  PEM_write_bio_DSAparams: function(bp: PBIO; const x: PDSA): TIdC_INT cdecl = nil;
  // ~DSA

  // EC
  PEM_read_bio_ECPKParameters: function(bp: PBIO; x: PPEC_GROUP; cb: pem_password_cb; u: Pointer): PEC_GROUP cdecl = nil;
  PEM_write_bio_ECPKParameters: function(bp: PBIO; const x: PEC_GROUP): TIdC_INT cdecl = nil;

  PEM_read_bio_ECPrivateKey: function(bp: PBIO; x: PPEC_KEY; cb: pem_password_cb; u: Pointer): PEC_KEY cdecl = nil;
  PEM_write_bio_ECPrivateKey: function(bp: PBIO; x: PEC_KEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_read_bio_EC_PUBKEY: function(bp: PBIO; x: PPEC_KEY; cb: pem_password_cb; u: Pointer): PEC_KEY cdecl = nil;
  PEM_write_bio_EC_PUBKEY: function(bp: PBIO; x: PEC_KEY): TIdC_INT cdecl = nil;
  // ~EC

  // DH
  PEM_read_bio_DHparams: function(bp: PBIO; x: PPDH; cb: pem_password_cb; u: Pointer): PDH cdecl = nil;
  PEM_write_bio_DHparams: function(bp: PBIO; const x: PDH): TIdC_INT cdecl = nil;

  PEM_write_bio_DHxparams: function(bp: PBIO; const x: PDH): TIdC_INT cdecl = nil;
  // ~DH

  PEM_read_bio_PrivateKey: function(bp: PBIO; x: PPEVP_PKEY; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl = nil;
  PEM_write_bio_PrivateKey: function(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

  PEM_read_bio_PUBKEY: function(bp: PBIO; x: PPEVP_PKEY; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl = nil;
  PEM_write_bio_PUBKEY: function(bp: PBIO; x: PEVP_PKEY): TIdC_INT cdecl = nil;

  PEM_write_bio_PrivateKey_traditional: function(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER; kstr: PByte; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  PEM_write_bio_PKCS8PrivateKey_nid: function(bp: PBIO; x: PEVP_PKEY; nid: TIdC_INT; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  PEM_write_bio_PKCS8PrivateKey: function(bp: PBIO; x: PEVP_PKEY_METHOD; const enc: PEVP_CIPHER; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  i2d_PKCS8PrivateKey_bio: function(bp: PBIO; x: PEVP_PKEY; const enc: PEVP_CIPHER_CTX; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  i2d_PKCS8PrivateKey_nid_bio: function(bp: PBIO; x: PEVP_PKEY; nid: TIdC_INT; kstr: PIdAnsiChar; klen: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;
  d2i_PKCS8PrivateKey_bio: function(bp: PBIO; x: PPEVP_PKEY_CTX; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl = nil;

  PEM_read_bio_Parameters: function(bp: PBIO; x: PPEVP_PKEY): PEVP_PKEY cdecl = nil;
  PEM_write_bio_Parameters: function(bp: PBIO; x: PEVP_PKEY): TIdC_INT cdecl = nil;

  b2i_PrivateKey: function(const in_: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;
  b2i_PublicKey: function(const in_: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;
  b2i_PrivateKey_bio: function(&in: PBIO): PEVP_PKEY cdecl = nil;
  b2i_PublicKey_bio: function(&in: PBIO): PEVP_PKEY cdecl = nil;
  i2b_PrivateKey_bio: function(&out: PBIO; pk: PEVP_PKEY): TIdC_INT cdecl = nil;
  i2b_PublicKey_bio: function(&out: PBIO; pk: PEVP_PKEY): TIdC_INT cdecl = nil;
  b2i_PVK_bio: function(&in: PBIO; cb: pem_password_cb; u: Pointer): PEVP_PKEY cdecl = nil;
  i2b_PVK_bio: function(&out: PBIO; pk: PEVP_PKEY; enclevel: TIdC_INT; cb: pem_password_cb; u: Pointer): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  PEM_get_EVP_CIPHER_INFO := LoadFunction('PEM_get_EVP_CIPHER_INFO', AFailed);
  PEM_do_header := LoadFunction('PEM_do_header', AFailed);
  PEM_read_bio := LoadFunction('PEM_read_bio', AFailed);
  PEM_read_bio_ex := LoadFunction('PEM_read_bio_ex', AFailed);
  PEM_bytes_read_bio_secmem := LoadFunction('PEM_bytes_read_bio_secmem', AFailed);
  PEM_write_bio := LoadFunction('PEM_write_bio', AFailed);
  PEM_bytes_read_bio := LoadFunction('PEM_bytes_read_bio', AFailed);
  PEM_ASN1_read_bio := LoadFunction('PEM_ASN1_read_bio', AFailed);
  PEM_ASN1_write_bio := LoadFunction('PEM_ASN1_write_bio', AFailed);
  PEM_X509_INFO_write_bio := LoadFunction('PEM_X509_INFO_write_bio', AFailed);
  PEM_SignInit := LoadFunction('PEM_SignInit', AFailed);
  PEM_SignUpdate := LoadFunction('PEM_SignUpdate', AFailed);
  PEM_SignFinal := LoadFunction('PEM_SignFinal', AFailed);
  PEM_def_callback := LoadFunction('PEM_def_callback', AFailed);
  PEM_proc_type := LoadFunction('PEM_proc_type', AFailed);
  PEM_dek_info := LoadFunction('PEM_dek_info', AFailed);
  PEM_read_bio_X509 := LoadFunction('PEM_read_bio_X509', AFailed);
  PEM_write_bio_X509 := LoadFunction('PEM_write_bio_X509', AFailed);
  PEM_read_bio_X509_AUX := LoadFunction('PEM_read_bio_X509_AUX', AFailed);
  PEM_write_bio_X509_AUX := LoadFunction('PEM_write_bio_X509_AUX', AFailed);
  PEM_read_bio_X509_REQ := LoadFunction('PEM_read_bio_X509_REQ', AFailed);
  PEM_write_bio_X509_REQ := LoadFunction('PEM_write_bio_X509_REQ', AFailed);
  PEM_write_bio_X509_REQ_NEW := LoadFunction('PEM_write_bio_X509_REQ_NEW', AFailed);
  PEM_read_bio_X509_CRL := LoadFunction('PEM_read_bio_X509_CRL', AFailed);
  PEM_write_bio_X509_CRL := LoadFunction('PEM_write_bio_X509_CRL', AFailed);
  PEM_read_bio_PKCS7 := LoadFunction('PEM_read_bio_PKCS7', AFailed);
  PEM_write_bio_PKCS7 := LoadFunction('PEM_write_bio_PKCS7', AFailed);
  PEM_read_bio_PKCS8 := LoadFunction('PEM_read_bio_PKCS8', AFailed);
  PEM_write_bio_PKCS8 := LoadFunction('PEM_write_bio_PKCS8', AFailed);
  PEM_read_bio_PKCS8_PRIV_KEY_INFO := LoadFunction('PEM_read_bio_PKCS8_PRIV_KEY_INFO', AFailed);
  PEM_write_bio_PKCS8_PRIV_KEY_INFO := LoadFunction('PEM_write_bio_PKCS8_PRIV_KEY_INFO', AFailed);
  PEM_read_bio_RSAPrivateKey := LoadFunction('PEM_read_bio_RSAPrivateKey', AFailed);
  PEM_write_bio_RSAPrivateKey := LoadFunction('PEM_write_bio_RSAPrivateKey', AFailed);
  PEM_read_bio_RSAPublicKey := LoadFunction('PEM_read_bio_RSAPublicKey', AFailed);
  PEM_write_bio_RSAPublicKey := LoadFunction('PEM_write_bio_RSAPublicKey', AFailed);
  PEM_read_bio_RSA_PUBKEY := LoadFunction('PEM_read_bio_RSA_PUBKEY', AFailed);
  PEM_write_bio_RSA_PUBKEY := LoadFunction('PEM_write_bio_RSA_PUBKEY', AFailed);
  PEM_read_bio_DSAPrivateKey := LoadFunction('PEM_read_bio_DSAPrivateKey', AFailed);
  PEM_write_bio_DSAPrivateKey := LoadFunction('PEM_write_bio_DSAPrivateKey', AFailed);
  PEM_read_bio_DSA_PUBKEY := LoadFunction('PEM_read_bio_DSA_PUBKEY', AFailed);
  PEM_write_bio_DSA_PUBKEY := LoadFunction('PEM_write_bio_DSA_PUBKEY', AFailed);
  PEM_read_bio_DSAparams := LoadFunction('PEM_read_bio_DSAparams', AFailed);
  PEM_write_bio_DSAparams := LoadFunction('PEM_write_bio_DSAparams', AFailed);
  PEM_read_bio_ECPKParameters := LoadFunction('PEM_read_bio_ECPKParameters', AFailed);
  PEM_write_bio_ECPKParameters := LoadFunction('PEM_write_bio_ECPKParameters', AFailed);
  PEM_read_bio_ECPrivateKey := LoadFunction('PEM_read_bio_ECPrivateKey', AFailed);
  PEM_write_bio_ECPrivateKey := LoadFunction('PEM_write_bio_ECPrivateKey', AFailed);
  PEM_read_bio_EC_PUBKEY := LoadFunction('PEM_read_bio_EC_PUBKEY', AFailed);
  PEM_write_bio_EC_PUBKEY := LoadFunction('PEM_write_bio_EC_PUBKEY', AFailed);
  PEM_read_bio_DHparams := LoadFunction('PEM_read_bio_DHparams', AFailed);
  PEM_write_bio_DHparams := LoadFunction('PEM_write_bio_DHparams', AFailed);
  PEM_write_bio_DHxparams := LoadFunction('PEM_write_bio_DHxparams', AFailed);
  PEM_read_bio_PrivateKey := LoadFunction('PEM_read_bio_PrivateKey', AFailed);
  PEM_write_bio_PrivateKey := LoadFunction('PEM_write_bio_PrivateKey', AFailed);
  PEM_read_bio_PUBKEY := LoadFunction('PEM_read_bio_PUBKEY', AFailed);
  PEM_write_bio_PUBKEY := LoadFunction('PEM_write_bio_PUBKEY', AFailed);
  PEM_write_bio_PrivateKey_traditional := LoadFunction('PEM_write_bio_PrivateKey_traditional', AFailed);
  PEM_write_bio_PKCS8PrivateKey_nid := LoadFunction('PEM_write_bio_PKCS8PrivateKey_nid', AFailed);
  PEM_write_bio_PKCS8PrivateKey := LoadFunction('PEM_write_bio_PKCS8PrivateKey', AFailed);
  i2d_PKCS8PrivateKey_bio := LoadFunction('i2d_PKCS8PrivateKey_bio', AFailed);
  i2d_PKCS8PrivateKey_nid_bio := LoadFunction('i2d_PKCS8PrivateKey_nid_bio', AFailed);
  d2i_PKCS8PrivateKey_bio := LoadFunction('d2i_PKCS8PrivateKey_bio', AFailed);
  PEM_read_bio_Parameters := LoadFunction('PEM_read_bio_Parameters', AFailed);
  PEM_write_bio_Parameters := LoadFunction('PEM_write_bio_Parameters', AFailed);
  b2i_PrivateKey := LoadFunction('b2i_PrivateKey', AFailed);
  b2i_PublicKey := LoadFunction('b2i_PublicKey', AFailed);
  b2i_PrivateKey_bio := LoadFunction('b2i_PrivateKey_bio', AFailed);
  b2i_PublicKey_bio := LoadFunction('b2i_PublicKey_bio', AFailed);
  i2b_PrivateKey_bio := LoadFunction('i2b_PrivateKey_bio', AFailed);
  i2b_PublicKey_bio := LoadFunction('i2b_PublicKey_bio', AFailed);
  b2i_PVK_bio := LoadFunction('b2i_PVK_bio', AFailed);
  i2b_PVK_bio := LoadFunction('i2b_PVK_bio', AFailed);
end;

procedure UnLoad;
begin
  PEM_get_EVP_CIPHER_INFO := nil;
  PEM_do_header := nil;
  PEM_read_bio := nil;
  PEM_read_bio_ex := nil;
  PEM_bytes_read_bio_secmem := nil;
  PEM_write_bio := nil;
  PEM_bytes_read_bio := nil;
  PEM_ASN1_read_bio := nil;
  PEM_ASN1_write_bio := nil;
  PEM_X509_INFO_write_bio := nil;
  PEM_SignInit := nil;
  PEM_SignUpdate := nil;
  PEM_SignFinal := nil;
  PEM_def_callback := nil;
  PEM_proc_type := nil;
  PEM_dek_info := nil;
  PEM_read_bio_X509 := nil;
  PEM_write_bio_X509 := nil;
  PEM_read_bio_X509_AUX := nil;
  PEM_write_bio_X509_AUX := nil;
  PEM_read_bio_X509_REQ := nil;
  PEM_write_bio_X509_REQ := nil;
  PEM_write_bio_X509_REQ_NEW := nil;
  PEM_read_bio_X509_CRL := nil;
  PEM_write_bio_X509_CRL := nil;
  PEM_read_bio_PKCS7 := nil;
  PEM_write_bio_PKCS7 := nil;
  PEM_read_bio_PKCS8 := nil;
  PEM_write_bio_PKCS8 := nil;
  PEM_read_bio_PKCS8_PRIV_KEY_INFO := nil;
  PEM_write_bio_PKCS8_PRIV_KEY_INFO := nil;
  PEM_read_bio_RSAPrivateKey := nil;
  PEM_write_bio_RSAPrivateKey := nil;
  PEM_read_bio_RSAPublicKey := nil;
  PEM_write_bio_RSAPublicKey := nil;
  PEM_read_bio_RSA_PUBKEY := nil;
  PEM_write_bio_RSA_PUBKEY := nil;
  PEM_read_bio_DSAPrivateKey := nil;
  PEM_write_bio_DSAPrivateKey := nil;
  PEM_read_bio_DSA_PUBKEY := nil;
  PEM_write_bio_DSA_PUBKEY := nil;
  PEM_read_bio_DSAparams := nil;
  PEM_write_bio_DSAparams := nil;
  PEM_read_bio_ECPKParameters := nil;
  PEM_write_bio_ECPKParameters := nil;
  PEM_read_bio_ECPrivateKey := nil;
  PEM_write_bio_ECPrivateKey := nil;
  PEM_read_bio_EC_PUBKEY := nil;
  PEM_write_bio_EC_PUBKEY := nil;
  PEM_read_bio_DHparams := nil;
  PEM_write_bio_DHparams := nil;
  PEM_write_bio_DHxparams := nil;
  PEM_read_bio_PrivateKey := nil;
  PEM_write_bio_PrivateKey := nil;
  PEM_read_bio_PUBKEY := nil;
  PEM_write_bio_PUBKEY := nil;
  PEM_write_bio_PrivateKey_traditional := nil;
  PEM_write_bio_PKCS8PrivateKey_nid := nil;
  PEM_write_bio_PKCS8PrivateKey := nil;
  i2d_PKCS8PrivateKey_bio := nil;
  i2d_PKCS8PrivateKey_nid_bio := nil;
  d2i_PKCS8PrivateKey_bio := nil;
  PEM_read_bio_Parameters := nil;
  PEM_write_bio_Parameters := nil;
  b2i_PrivateKey := nil;
  b2i_PublicKey := nil;
  b2i_PrivateKey_bio := nil;
  b2i_PublicKey_bio := nil;
  i2b_PrivateKey_bio := nil;
  i2b_PublicKey_bio := nil;
  b2i_PVK_bio := nil;
  i2b_PVK_bio := nil;
end;

end.
