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

unit IdOpenSSLHeaders_x509;

interface

// Headers for OpenSSL 1.1.1
// x509.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_asn1,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_ossl_typ;

type
  X509_ALGORS = type Pointer;

const
  (* Flags for X509_get_signature_info() *)
  (* Signature info is valid *)
  X509_SIG_INFO_VALID = $1;
  (* Signature is suitable for TLS use *)
  X509_SIG_INFO_TLS = $2;

  X509_FILETYPE_PEM     = 1;
  X509_FILETYPE_ASN1    = 2;
  X509_FILETYPE_DEFAULT = 3;

  X509v3_KU_DIGITAL_SIGNATURE = $0080;
  X509v3_KU_NON_REPUDIATION   = $0040;
  X509v3_KU_KEY_ENCIPHERMENT  = $0020;
  X509v3_KU_DATA_ENCIPHERMENT = $0010;
  X509v3_KU_KEY_AGREEMENT     = $0008;
  X509v3_KU_KEY_CERT_SIGN     = $0004;
  X509v3_KU_CRL_SIGN          = $0002;
  X509v3_KU_ENCIPHER_ONLY     = $0001;
  X509v3_KU_DECIPHER_ONLY     = $8000;
  X509v3_KU_UNDEF             = $ffff;

  X509_EX_V_NETSCAPE_HACK = $8000;
  X509_EX_V_INIT          = $0001;


  (* standard trust ids *)

  X509_TRUST_DEFAULT      = 0; (* Only valid in purpose settings *)

  X509_TRUST_COMPAT       = 1;
  X509_TRUST_SSL_CLIENT   = 2;
  X509_TRUST_SSL_SERVER   = 3;
  X509_TRUST_EMAIL        = 4;
  X509_TRUST_OBJECT_SIGN  = 5;
  X509_TRUST_OCSP_SIGN    = 6;
  X509_TRUST_OCSP_REQUEST = 7;
  X509_TRUST_TSA          = 8;

  (* Keep these up to date! *)
  X509_TRUST_MIN          = 1;
  X509_TRUST_MAX          = 8;

  (* trust_flags values *)
  X509_TRUST_DYNAMIC      = TIdC_UINT(1) shl 0;
  X509_TRUST_DYNAMIC_NAME = TIdC_UINT(1) shl 1;
  (* No compat trust if self-signed, preempts "DO_SS" *)
  X509_TRUST_NO_SS_COMPAT = TIdC_UINT(1) shl 2;
  (* Compat trust if no explicit accepted trust EKUs *)
  X509_TRUST_DO_SS_COMPAT = TIdC_UINT(1) shl 3;
  (* Accept "anyEKU" as a wildcard trust OID *)
  X509_TRUST_OK_ANY_EKU   = TIdC_UINT(1) shl 4;

  (* check_trust return codes *)

  X509_TRUST_TRUSTED   = 1;
  X509_TRUST_REJECTED  = 2;
  X509_TRUST_UNTRUSTED = 3;

  (* Flags for X509_print_ex() *)

  X509_FLAG_COMPAT        = 0;
  X509_FLAG_NO_HEADER     = TIdC_LONG(1);
  X509_FLAG_NO_VERSION    = TIdC_LONG(1) shl 1;
  X509_FLAG_NO_SERIAL     = TIdC_LONG(1) shl 2;
  X509_FLAG_NO_SIGNAME    = TIdC_LONG(1) shl 3;
  X509_FLAG_NO_ISSUER     = TIdC_LONG(1) shl 4;
  X509_FLAG_NO_VALIDITY   = TIdC_LONG(1) shl 5;
  X509_FLAG_NO_SUBJECT    = TIdC_LONG(1) shl 6;
  X509_FLAG_NO_PUBKEY     = TIdC_LONG(1) shl 7;
  X509_FLAG_NO_EXTENSIONS = TIdC_LONG(1) shl 8;
  X509_FLAG_NO_SIGDUMP    = TIdC_LONG(1) shl 9;
  X509_FLAG_NO_AUX        = TIdC_LONG(1) shl 10;
  X509_FLAG_NO_ATTRIBUTES = TIdC_LONG(1) shl 11;
  X509_FLAG_NO_IDS        = TIdC_LONG(1) shl 12;

  (* Flags specific to X509_NAME_print_ex() *)

  (* The field separator information *)

  XN_FLAG_SEP_MASK       = $f shl 16;

  XN_FLAG_COMPAT         = 0;(* Traditional; use old X509_NAME_print *)
  XN_FLAG_SEP_COMMA_PLUS = 1 shl 16;(* RFC2253 ,+ *)
  XN_FLAG_SEP_CPLUS_SPC  = 2 shl 16;(* ,+ spaced: more readable *)
  XN_FLAG_SEP_SPLUS_SPC  = 3 shl 16;(* ;+ spaced *)
  XN_FLAG_SEP_MULTILINE  = 4 shl 16;(* One line per field *)

  XN_FLAG_DN_REV         = 1 shl 20;(* Reverse DN order *)

  (* How the field name is shown *)

  XN_FLAG_FN_MASK        = $3 shl 21;

  XN_FLAG_FN_SN          = 0;(* Object short name *)
  XN_FLAG_FN_LN          = 1 shl 21;(* Object long name *)
  XN_FLAG_FN_OID         = 2 shl 21;(* Always use OIDs *)
  XN_FLAG_FN_NONE        = 3 shl 21;(* No field names *)

  XN_FLAG_SPC_EQ         = 1 shl 23;(* Put spaces round '=' *)

  (*
   * This determines if we dump fields we don't recognise: RFC2253 requires
   * this.
   *)

  XN_FLAG_DUMP_UNKNOWN_FIELDS = 1 shl 24;

  XN_FLAG_FN_ALIGN = 1 shl 25;(* Align field names to 20
                                             * characters *)

  (* Complete set of RFC2253 flags *)

  XN_FLAG_RFC2253 = ASN1_STRFLGS_RFC2253 or XN_FLAG_SEP_COMMA_PLUS
    or XN_FLAG_DN_REV or XN_FLAG_FN_SN or XN_FLAG_DUMP_UNKNOWN_FIELDS;

  (* readable oneline form *)

  XN_FLAG_ONELINE = ASN1_STRFLGS_RFC2253 or ASN1_STRFLGS_ESC_QUOTE
    or XN_FLAG_SEP_CPLUS_SPC or XN_FLAG_SPC_EQ or XN_FLAG_FN_SN;

  (* readable multiline form *)

  XN_FLAG_MULTILINE = ASN1_STRFLGS_ESC_CTRL or ASN1_STRFLGS_ESC_MSB
    or XN_FLAG_SEP_MULTILINE or XN_FLAG_SPC_EQ or XN_FLAG_FN_LN or XN_FLAG_FN_ALIGN;

  X509_EXT_PACK_UNKNOWN = 1;
  X509_EXT_PACK_STRING  = 2;

type
  X509_val_st = record
    notBefore: PASN1_TIME;
    notAfter: PASN1_TIME;
  end;
  X509_VAL = X509_val_st;
  PX509_VAL = ^X509_VAL;
  PPX509_VAL = ^PX509_VAL;

  X509_SIG = type Pointer; // X509_sig_st
  PX509_SIG = ^X509_SIG;
  PPX509_SIG = ^PX509_SIG;

  X509_NAME_ENTRY = type Pointer; // X509_name_entry_st
  PX509_NAME_ENTRY = ^X509_NAME_ENTRY;
  PPX509_NAME_ENTRY = ^PX509_NAME_ENTRY;

  //DEFINE_STACK_OF(X509_NAME_ENTRY)
  //
  //DEFINE_STACK_OF(X509_NAME)

  X509_EXTENSION = type Pointer; // X509_extension_st
  PX509_EXTENSION = ^X509_EXTENSION;
  PPX509_EXTENSION = ^PX509_EXTENSION;

  //typedef STACK_OF(X509_EXTENSION) X509_EXTENSIONS;
  //
  //DEFINE_STACK_OF(X509_EXTENSION)

  X509_ATTRIBUTE = type Pointer; // x509_attributes_st
  PX509_ATTRIBUTE = ^X509_ATTRIBUTE;
  PPX509_ATTRIBUTE = ^PX509_ATTRIBUTE;

  //DEFINE_STACK_OF(X509_ATTRIBUTE)

  X509_REQ_INFO = type Pointer; // X509_req_info_st
  PX509_REQ_INFO = ^X509_REQ_INFO;
  PPX509_REQ_INFO = ^PX509_REQ_INFO;

  X509_CERT_AUX = type Pointer; // x509_cert_aux_st

  X509_CINF = type Pointer; // x509_cinf_st

  //DEFINE_STACK_OF(X509)

  (* This is used for a table of trust checking functions *)

  Px509_trust_st = ^x509_trust_st;
  x509_trust_st = record
    trust: TIdC_INT;
    flags: TIdC_INT;
    check_trust: function(v1: Px509_trust_st; v2: PX509; v3: TIdC_INT): TIdC_INT; cdecl;
    name: PIdAnsiChar;
    arg1: TIdC_INT;
    arg2: Pointer;
  end;
  X509_TRUST = x509_trust_st;
  PX509_TRUST = ^X509_TRUST;

  //DEFINE_STACK_OF(X509_TRUST)

  //DEFINE_STACK_OF(X509_REVOKED)
  X509_REVOKED = type Pointer;   //////////////////////////////////////////////
  PX509_REVOKED = ^X509_REVOKED; //////////////////////////////////////////////
  PPX509_REVOKED = ^PX509_REVOKED;/////////////////////////////////////////////

  X509_CRL_INFO = type Pointer; // X509_crl_info_st
  PX509_CRL_INFO = ^X509_CRL_INFO;
  PPX509_CRL_INFO = ^PX509_CRL_INFO;

  //DEFINE_STACK_OF(X509_CRL)

  private_key_st = record
    version: TIdC_INT;
    (* The PKCS#8 data types *)
    enc_algor: PX509_ALGOR;
    enc_pkey: PASN1_OCTET_STRING; (* encrypted pub key *)
    (* When decrypted, the following will not be NULL *)
    dec_pkey: PEVP_PKEY;
    (* used to encrypt and decrypt *)
    key_length: TIdC_INT;
    key_data: PIdAnsiChar;
    key_free: TIdC_INT;               (* true if we should auto free key_data *)
    (* expanded version of 'enc_algor' *)
    cipher: EVP_CIPHER_INFO;
  end;
  X509_PKEY = private_key_st;
  PX509_PKEY = ^X509_PKEY;

  X509_info_st = record
    x509: PX509;
    crl: PX509_CRL;
    x_pkey: PX509_PKEY;
    enc_cipher: EVP_CIPHER_INFO;
    enc_len: TIdC_INT;
    enc_data: PIdAnsiChar;
  end;
  X509_INFO = X509_info_st;
  PX509_INFO = ^X509_INFO;

  //DEFINE_STACK_OF(X509_INFO)

  (*
   * The next 2 structures and their 8 routines are used to manipulate Netscape's
   * spki structures - useful if you are writing a CA web page
   *)
  Netscape_spkac_st = record
    pubkey: PX509_PUBKEY;
    challenge: PASN1_IA5STRING;  (* challenge sent in atlas >= PR2 *)
  end;
  NETSCAPE_SPKAC = Netscape_spkac_st;
  PNETSCAPE_SPKAC = ^NETSCAPE_SPKAC;

  Netscape_spki_st = record
    spkac: PNETSCAPE_SPKAC;      (* signed public key and challenge *)
    sig_algor: X509_ALGOR;
    signature: PASN1_BIT_STRING;
  end;
  NETSCAPE_SPKI = Netscape_spki_st;
  PNETSCAPE_SPKI = ^NETSCAPE_SPKI;

  (* Netscape certificate sequence structure *)
//  Netscape_certificate_sequence: record
//    type_: PASN1_OBJECT;
//    certs: P --> STACK_OF(X509) <--;
//  end;
//  NETSCAPE_CERT_SEQUENCE = Netscape_certificate_sequence;

  (*- Unused (and iv length is wrong)
  typedef struct CBCParameter_st
          {
          unsigned char iv[8];
          } CBC_PARAM;
  *)

  (* Password based encryption structure *)
  PBEPARAM_st = record
    salt: PASN1_OCTET_STRING;
    iter: PASN1_INTEGER;
  end;
  PBEPARAM = PBEPARAM_st;

  (* Password based encryption V2 structures *)
  PBE2PARAM_st = record
    keyfunc: PX509_ALGOR;
    encryption: X509_ALGOR;
  end;
  PBE2PARAM = PBE2PARAM_st;

  PBKDF2PARAM_st = record
  (* Usually OCTET STRING but could be anything *)
    salt: PASN1_TYPE;
    iter: PASN1_INTEGER;
    keylength: PASN1_INTEGER;
    prf: X509_ALGOR;
  end;
  PBKDF2PARAM = PBKDF2PARAM_st;

  SCRYPT_PARAMS_st = record
    salt: PASN1_OCTET_STRING;
    costParameter: PASN1_INTEGER;
    blockSize: PASN1_INTEGER;
    parallelizationParameter: PASN1_INTEGER;
    keyLength: ASN1_INTEGER;
  end;
  SCRYPT_PARAMS = SCRYPT_PARAMS_st;

  //# define         X509_extract_key(x)     X509_get_pubkey(x)(*****)
  //# define         X509_REQ_extract_key(a) X509_REQ_get_pubkey(a)
  //# define         X509_name_cmp(a,b)      X509_NAME_cmp((a),(b))
  //

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  X509_CRL_set_default_method: procedure(const meth: PX509_CRL_METHOD) cdecl = nil;
//  function X509_CRL_METHOD_new(crl_init: function(crl: X509_CRL): TIdC_INT;
//    crl_free: function(crl: PX509_CRL): TIdC_INT;
//    crl_lookup: function(crl: PX509_CRL; ret: PPX509_REVOKED; ser: PASN1_INTEGER; issuer: PX509_NAME): TIdC_INT;
//    crl_verify: function(crl: PX509_CRL, pk: PEVP_PKEY): TIdC_INT): PX509_CRL_METHOD;
  X509_CRL_METHOD_free: procedure(m: PX509_CRL_METHOD) cdecl = nil;

  X509_CRL_set_meth_data: procedure(crl: PX509_CRL; dat: Pointer) cdecl = nil;
  X509_CRL_get_meth_data: function(crl: PX509_CRL): Pointer cdecl = nil;

  X509_verify_cert_error_string: function(n: TIdC_LONG): PIdAnsiChar cdecl = nil;

  X509_verify: function(a: PX509; r: PEVP_PKEY): TIdC_INT cdecl = nil;

  X509_REQ_verify: function(a: PX509_REQ; r: PEVP_PKEY): TIdC_INT cdecl = nil;
  X509_CRL_verify: function(a: PX509_CRL; r: PEVP_PKEY): TIdC_INT cdecl = nil;
  NETSCAPE_SPKI_verify: function(a: PNETSCAPE_SPKI; r: PEVP_PKEY): TIdC_INT cdecl = nil;

  NETSCAPE_SPKI_b64_decode: function(const str: PIdAnsiChar; len: TIdC_INT): PNETSCAPE_SPKI cdecl = nil;
  NETSCAPE_SPKI_b64_encode: function(x: PNETSCAPE_SPKI): PIdAnsiChar cdecl = nil;
  NETSCAPE_SPKI_get_pubkey: function(x: PNETSCAPE_SPKI): PEVP_PKEY cdecl = nil;
  NETSCAPE_SPKI_set_pubkey: function(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  NETSCAPE_SPKI_print: function(&out: PBIO; spki: PNETSCAPE_SPKI): TIdC_INT cdecl = nil;

  X509_signature_dump: function(bp: PBIO; const sig: PASN1_STRING; indent: TIdC_INT): TIdC_INT cdecl = nil;
  X509_signature_print: function(bp: PBIO; const alg: PX509_ALGOR; const sig: PASN1_STRING): TIdC_INT cdecl = nil;

  X509_sign: function(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl = nil;
  X509_sign_ctx: function(x: PX509; ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;

  X509_http_nbio: function(rctx: POCSP_REQ_CTX; pcert: PPX509): TIdC_INT cdecl = nil;

  X509_REQ_sign: function(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl = nil;
  X509_REQ_sign_ctx: function(x: PX509_REQ; ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;
  X509_CRL_sign: function(x: PX509_CRL; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl = nil;
  X509_CRL_sign_ctx: function(x: PX509_CRL; ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;

  X509_CRL_http_nbio: function(rctx: POCSP_REQ_CTX; pcrl: PPX509_CRL): TIdC_INT cdecl = nil;

  NETSCAPE_SPKI_sign: function(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl = nil;

  X509_pubkey_digest: function(const data: PX509; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;
  X509_digest: function(const data: PX509; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;
  X509_CRL_digest: function(const data: PX509_CRL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;
  X509_REQ_digest: function(const data: PX509_REQ; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;
  X509_NAME_digest: function(const data: PX509_NAME; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;

  //# ifndef OPENSSL_NO_STDIO
  //X509 *d2i_X509_fp(FILE *fp, X509 **x509);
  //TIdC_INT i2d_X509_fp(FILE *fp, X509 *x509);
  //X509_CRL *d2i_X509_CRL_fp(FILE *fp, X509_CRL **crl);
  //TIdC_INT i2d_X509_CRL_fp(FILE *fp, X509_CRL *crl);
  //X509_REQ *d2i_X509_REQ_fp(FILE *fp, X509_REQ **req);
  //TIdC_INT i2d_X509_REQ_fp(FILE *fp, X509_REQ *req);
  //#  ifndef OPENSSL_NO_RSA
  //RSA *d2i_RSAPrivateKey_fp(FILE *fp, RSA **rsa);
  //TIdC_INT i2d_RSAPrivateKey_fp(FILE *fp, RSA *rsa);
  //RSA *d2i_RSAPublicKey_fp(FILE *fp, RSA **rsa);
  //TIdC_INT i2d_RSAPublicKey_fp(FILE *fp, RSA *rsa);
  //RSA *d2i_RSA_PUBKEY_fp(FILE *fp, RSA **rsa);
  //TIdC_INT i2d_RSA_PUBKEY_fp(FILE *fp, RSA *rsa);
  //#  endif
  //#  ifndef OPENSSL_NO_DSA
  //DSA *d2i_DSA_PUBKEY_fp(FILE *fp, DSA **dsa);
  //TIdC_INT i2d_DSA_PUBKEY_fp(FILE *fp, DSA *dsa);
  //DSA *d2i_DSAPrivateKey_fp(FILE *fp, DSA **dsa);
  //TIdC_INT i2d_DSAPrivateKey_fp(FILE *fp, DSA *dsa);
  //#  endif
  //#  ifndef OPENSSL_NO_EC
  //EC_KEY *d2i_EC_PUBKEY_fp(FILE *fp, EC_KEY **eckey);
  //TIdC_INT i2d_EC_PUBKEY_fp(FILE *fp, EC_KEY *eckey);
  //EC_KEY *d2i_ECPrivateKey_fp(FILE *fp, EC_KEY **eckey);
  //TIdC_INT i2d_ECPrivateKey_fp(FILE *fp, EC_KEY *eckey);
  //#  endif
  //X509_SIG *d2i_PKCS8_fp(FILE *fp, X509_SIG **p8);
  //TIdC_INT i2d_PKCS8_fp(FILE *fp, X509_SIG *p8);
  //PKCS8_PRIV_KEY_INFO *d2i_PKCS8_PRIV_KEY_INFO_fp(FILE *fp,
  //                                                PKCS8_PRIV_KEY_INFO **p8inf);
  //TIdC_INT i2d_PKCS8_PRIV_KEY_INFO_fp(FILE *fp, PKCS8_PRIV_KEY_INFO *p8inf);
  //TIdC_INT i2d_PKCS8PrivateKeyInfo_fp(FILE *fp, EVP_PKEY *key);
  //TIdC_INT i2d_PrivateKey_fp(FILE *fp, EVP_PKEY *pkey);
  //EVP_PKEY *d2i_PrivateKey_fp(FILE *fp, EVP_PKEY **a);
  //TIdC_INT i2d_PUBKEY_fp(FILE *fp, EVP_PKEY *pkey);
  //EVP_PKEY *d2i_PUBKEY_fp(FILE *fp, EVP_PKEY **a);
  //# endif

  d2i_X509_bio: function(bp: PBIO; x509: PPX509): PX509 cdecl = nil;
  i2d_X509_bio: function(bp: PBIO; x509: PX509): TIdC_INT cdecl = nil;
  d2i_X509_CRL_bio: function(bp: PBIO; crl: PPX509_CRL): PX509_CRL cdecl = nil;
  i2d_X509_CRL_bio: function(bp: PBIO; crl: PX509_CRL): TIdC_INT cdecl = nil;
  d2i_X509_REQ_bio: function(bp: PBIO; req: PPX509_REQ): PX509_REQ cdecl = nil;
  i2d_X509_REQ_bio: function(bp: PBIO; req: PX509_REQ): TIdC_INT cdecl = nil;

  d2i_RSAPrivateKey_bio: function(bp: PBIO; rsa: PPRSA): PRSA cdecl = nil;
  i2d_RSAPrivateKey_bio: function(bp: PBIO; rsa: PRSA): TIdC_INT cdecl = nil;
  d2i_RSAPublicKey_bio: function(bp: PBIO; rsa: PPRSA): PRSA cdecl = nil;
  i2d_RSAPublicKey_bio: function(bp: PBIO; rsa: PRSA): TIdC_INT cdecl = nil;
  d2i_RSA_PUBKEY_bio: function(bp: PBIO; rsa: PPRSA): PRSA cdecl = nil;
  i2d_RSA_PUBKEY_bio: function(bp: PBIO; rsa: PRSA): TIdC_INT cdecl = nil;

  d2i_DSA_PUBKEY_bio: function(bp: PBIO; dsa: PPDSA): DSA cdecl = nil;
  i2d_DSA_PUBKEY_bio: function(bp: PBIO; dsa: PDSA): TIdC_INT cdecl = nil;
  d2i_DSAPrivateKey_bio: function(bp: PBIO; dsa: PPDSA): PDSA cdecl = nil;
  i2d_DSAPrivateKey_bio: function(bp: PBIO; dsa: PDSA): TIdC_INT cdecl = nil;

  d2i_EC_PUBKEY_bio: function(bp: PBIO; eckey: PPEC_KEY): PEC_KEY cdecl = nil;
  i2d_EC_PUBKEY_bio: function(bp: PBIO; eckey: PEC_KEY): TIdC_INT cdecl = nil;
  d2i_ECPrivateKey_bio: function(bp: PBIO; eckey: PPEC_KEY): EC_KEY cdecl = nil;
  i2d_ECPrivateKey_bio: function(bp: PBIO; eckey: PEC_KEY): TIdC_INT cdecl = nil;

  d2i_PKCS8_bio: function(bp: PBIO; p8: PPX509_SIG): PX509_SIG cdecl = nil;
  i2d_PKCS8_bio: function(bp: PBIO; p8: PX509_SIG): TIdC_INT cdecl = nil;
  d2i_PKCS8_PRIV_KEY_INFO_bio: function(bp: PBIO; p8inf: PPPKCS8_PRIV_KEY_INFO): PPKCS8_PRIV_KEY_INFO cdecl = nil;
  i2d_PKCS8_PRIV_KEY_INFO_bio: function(bp: PBIO; p8inf: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl = nil;
  i2d_PKCS8PrivateKeyInfo_bio: function(bp: PBIO; key: PEVP_PKEY): TIdC_INT cdecl = nil;
  i2d_PrivateKey_bio: function(bp: PBIO; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  d2i_PrivateKey_bio: function(bp: PBIO; a: PPEVP_PKEY): PEVP_PKEY cdecl = nil;
  i2d_PUBKEY_bio: function(bp: PBIO; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  d2i_PUBKEY_bio: function(bp: PBIO; a: PPEVP_PKEY): PEVP_PKEY cdecl = nil;

  X509_dup: function(x509: PX509): PX509 cdecl = nil;
  X509_ATTRIBUTE_dup: function(xa: PX509_ATTRIBUTE): PX509_ATTRIBUTE cdecl = nil;
  X509_EXTENSION_dup: function(ex: PX509_EXTENSION): PX509_EXTENSION cdecl = nil;
  X509_CRL_dup: function(crl: PX509_CRL): PX509_CRL cdecl = nil;
  X509_REVOKED_dup: function(rev: PX509_REVOKED): PX509_REVOKED cdecl = nil;
  X509_REQ_dup: function(req: PX509_REQ): PX509_REQ cdecl = nil;
  X509_ALGOR_dup: function(xn: PX509_ALGOR): PX509_ALGOR cdecl = nil;
  X509_ALGOR_set0: function(alg: PX509_ALGOR; aobj: PASN1_OBJECT; ptype: TIdC_INT; pval: Pointer): TIdC_INT cdecl = nil;
  X509_ALGOR_get0: procedure(const paobj: PPASN1_OBJECT; pptype: PIdC_INT; const ppval: PPointer; const algor: PX509_ALGOR) cdecl = nil;
  X509_ALGOR_set_md: procedure(alg: PX509_ALGOR; const md: PEVP_MD) cdecl = nil;
  X509_ALGOR_cmp: function(const a: PX509_ALGOR; const b: PX509_ALGOR): TIdC_INT cdecl = nil;

  X509_NAME_dup: function(xn: PX509_NAME): PX509_NAME cdecl = nil;
  X509_NAME_ENTRY_dup: function(ne: PX509_NAME_ENTRY): PX509_NAME_ENTRY cdecl = nil;

  X509_cmp_time: function(const s: PASN1_TIME; t: PIdC_TIMET): TIdC_INT cdecl = nil;
  X509_cmp_current_time: function(const s: PASN1_TIME): TIdC_INT cdecl = nil;
  X509_time_adj: function(s: PASN1_TIME; adj: TIdC_LONG; t: PIdC_TIMET): PASN1_TIME cdecl = nil;
  X509_time_adj_ex: function(s: PASN1_TIME; offset_day: TIdC_INT; offset_sec: TIdC_LONG; t: PIdC_TIMET): PASN1_TIME cdecl = nil;
  X509_gmtime_adj: function(s: PASN1_TIME; adj: TIdC_LONG): PASN1_TIME cdecl = nil;

  X509_get_default_cert_area: function: PIdAnsiChar cdecl = nil;
  X509_get_default_cert_dir: function: PIdAnsiChar cdecl = nil;
  X509_get_default_cert_file: function: PIdAnsiChar cdecl = nil;
  X509_get_default_cert_dir_env: function: PIdAnsiChar cdecl = nil;
  X509_get_default_cert_file_env: function: PIdAnsiChar cdecl = nil;
  X509_get_default_private_dir: function: PIdAnsiChar cdecl = nil;

  X509_to_X509_REQ: function(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): PX509_REQ cdecl = nil;
  X509_REQ_to_X509: function(r: PX509_REQ; days: TIdC_INT; pkey: PEVP_PKEY): PX509 cdecl = nil;

  X509_ALGOR_new: function: PX509_ALGOR cdecl = nil;
  X509_ALGOR_free: procedure(v1: PX509_ALGOR) cdecl = nil;
  d2i_X509_ALGOR: function(a: PPX509_ALGOR; const in_: PPByte; len: TIdC_LONG): PX509_ALGOR cdecl = nil;
  i2d_X509_ALGOR: function(a: PX509_ALGOR; out_: PPByte): TIdC_INT cdecl = nil;
  //DECLARE_ASN1_ENCODE_FUNCTIONS(X509_ALGORS, X509_ALGORS, X509_ALGORS)
  X509_VAL_new: function: PX509_VAL cdecl = nil;
  X509_VAL_free: procedure(v1: PX509_VAL) cdecl = nil;
  d2i_X509_VAL: function(a: PPX509_VAL; const in_: PPByte; len: TIdC_LONG): PX509_VAL cdecl = nil;
  i2d_X509_VAL: function(a: PX509_VAL; out_: PPByte): TIdC_INT cdecl = nil;

  X509_PUBKEY_new: function: PX509_PUBKEY cdecl = nil;
  X509_PUBKEY_free: procedure(v1: PX509_PUBKEY) cdecl = nil;
  d2i_X509_PUBKEY: function(a: PPX509_PUBKEY; const in_: PPByte; len: TIdC_LONG): PX509_PUBKEY cdecl = nil;
  i2d_X509_PUBKEY: function(a: PX509_PUBKEY; out_: PPByte): TIdC_INT cdecl = nil;

  X509_PUBKEY_set: function(x: PPX509_PUBKEY; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  X509_PUBKEY_get0: function(key: PX509_PUBKEY): PEVP_PKEY cdecl = nil;
  X509_PUBKEY_get: function(key: PX509_PUBKEY): PEVP_PKEY cdecl = nil;
//  function X509_get_pubkey_parameters(pkey: PEVP_PKEY; chain: P STACK_OF(X509)): TIdC_INT;
  X509_get_pathlen: function(x: PX509): TIdC_LONG cdecl = nil;
  i2d_PUBKEY: function(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_PUBKEY: function(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;

  i2d_RSA_PUBKEY: function(a: PRSA; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_RSA_PUBKEY: function(a: PPRSA; const pp: PPByte; length: TIdC_LONG): PRSA cdecl = nil;

  i2d_DSA_PUBKEY: function(a: PDSA; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_DSA_PUBKEY: function(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl = nil;

  i2d_EC_PUBKEY: function(a: EC_KEY; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_EC_PUBKEY: function(a: PPEC_KEY; const pp: PPByte; length: TIdC_LONG): PEC_KEY cdecl = nil;

  X509_SIG_new: function: PX509_SIG cdecl = nil;
  X509_SIG_free: procedure(v1: PX509_SIG) cdecl = nil;
  d2i_X509_SIG: function(a: PPX509_SIG; const in_: PPByte; len: TIdC_LONG): PX509_SIG cdecl = nil;
  i2d_X509_SIG: function(a: PX509_SIG; out_: PPByte): TIdC_INT cdecl = nil;
  X509_SIG_get0: procedure(const sig: PX509_SIG; const palg: PPX509_ALGOR; const pdigest: PPASN1_OCTET_STRING) cdecl = nil;
  X509_SIG_getm: procedure(sig: X509_SIG; palg: PPX509_ALGOR; pdigest: PPASN1_OCTET_STRING) cdecl = nil;

  X509_REQ_INFO_new: function: PX509_REQ_INFO cdecl = nil;
  X509_REQ_INFO_free: procedure(v1: PX509_REQ_INFO) cdecl = nil;
  d2i_X509_REQ_INFO: function(a: PPX509_REQ_INFO; const in_: PPByte; len: TIdC_LONG): PX509_REQ_INFO cdecl = nil;
  i2d_X509_REQ_INFO: function(a: PX509_REQ_INFO; out_: PPByte): TIdC_INT cdecl = nil;

  X509_REQ_new: function: PX509_REQ cdecl = nil;
  X509_REQ_free: procedure(v1: PX509_REQ) cdecl = nil;
  d2i_X509_REQ: function(a: PPX509_REQ; const in_: PPByte; len: TIdC_LONG): PX509_REQ cdecl = nil;
  i2d_X509_REQ: function(a: PX509_REQ; out_: PPByte): TIdC_INT cdecl = nil;

  X509_ATTRIBUTE_new: function: PX509_ATTRIBUTE cdecl = nil;
  X509_ATTRIBUTE_free: procedure(v1: PX509_ATTRIBUTE) cdecl = nil;
  d2i_X509_ATTRIBUTE: function(a: PPX509_ATTRIBUTE; const in_: PPByte; len: TIdC_LONG): PX509_ATTRIBUTE cdecl = nil;
  i2d_X509_ATTRIBUTE: function(a: PX509_ATTRIBUTE; out_: PPByte): TIdC_INT cdecl = nil;
  X509_ATTRIBUTE_create: function(nid: TIdC_INT; trtype: TIdC_INT; value: Pointer): PX509_ATTRIBUTE cdecl = nil;

  X509_EXTENSION_new: function: PX509_EXTENSION cdecl = nil;
  X509_EXTENSION_free: procedure(v1: PX509_EXTENSION) cdecl = nil;
  d2i_X509_EXTENSION: function(a: PPX509_EXTENSION; const in_: PPByte; len: TIdC_LONG): PX509_EXTENSION cdecl = nil;
  i2d_X509_EXTENSION: function(a: PX509_EXTENSION; out_: PPByte): TIdC_INT cdecl = nil;
  //DECLARE_ASN1_ENCODE_FUNCTIONS(X509_EXTENSIONS, X509_EXTENSIONS, X509_EXTENSIONS)

  X509_NAME_ENTRY_new: function: PX509_NAME_ENTRY cdecl = nil;
  X509_NAME_ENTRY_free: procedure(v1: PX509_NAME_ENTRY) cdecl = nil;
  d2i_X509_NAME_ENTRY: function(a: PPX509_NAME_ENTRY; const in_: PPByte; len: TIdC_LONG): PX509_NAME_ENTRY cdecl = nil;
  i2d_X509_NAME_ENTRY: function(a: PX509_NAME_ENTRY; out_: PPByte): TIdC_INT cdecl = nil;

  X509_NAME_new: function: PX509_NAME cdecl = nil;
  X509_NAME_free: procedure(v1: PX509_NAME) cdecl = nil;
  d2i_X509_NAME: function(a: PPX509_NAME; const in_: PPByte; len: TIdC_LONG): PX509_NAME cdecl = nil;
  i2d_X509_NAME: function(a: PX509_NAME; out_: PPByte): TIdC_INT cdecl = nil;

  X509_NAME_set: function(xn: PPX509_NAME; name: PX509_NAME): TIdC_INT cdecl = nil;

  //DECLARE_ASN1_FUNCTIONS(X509_CINF)

  X509_new: function: PX509 cdecl = nil;
  X509_free: procedure(v1: PX509) cdecl = nil;
  d2i_X509: function(a: PPX509; const in_: PPByte; len: TIdC_LONG): PX509 cdecl = nil;
  i2d_X509: function(a: PX509; out_: PPByte): TIdC_INT cdecl = nil;

  //DECLARE_ASN1_FUNCTIONS(X509_CERT_AUX)
  //
  //#define X509_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509, l, p, newf, dupf, freef)
  X509_set_ex_data: function(r: PX509; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  X509_get_ex_data: function(r: PX509; idx: TIdC_INT): Pointer cdecl = nil;
  i2d_X509_AUX: function(a: PX509; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_X509_AUX: function(a: PPX509; const pp: PPByte; length: TIdC_LONG): PX509 cdecl = nil;

  i2d_re_X509_tbs: function(x: PX509; pp: PPByte): TIdC_INT cdecl = nil;

  X509_SIG_INFO_get: function(const siginf: PX509_SIG_INFO; mdnid: PIdC_INT; pknid: PIdC_INT; secbits: PIdC_INT; flags: PIdC_UINT32): TIdC_INT cdecl = nil;
  X509_SIG_INFO_set: procedure(siginf: PX509_SIG_INFO; mdnid: TIdC_INT; pknid: TIdC_INT; secbits: TIdC_INT; flags: TIdC_UINT32) cdecl = nil;

  X509_get_signature_info: function(x: PX509; mdnid: PIdC_INT; pknid: PIdC_INT; secbits: PIdC_INT; flags: PIdC_UINT32): TIdC_INT cdecl = nil;

  X509_get0_signature: procedure(const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR; const x: PX509) cdecl = nil;
  X509_get_signature_nid: function(const x: PX509): TIdC_INT cdecl = nil;

  X509_trusted: function(const x: PX509): TIdC_INT cdecl = nil;
  X509_alias_set1: function(x: PX509; const name: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_keyid_set1: function(x: PX509; const id: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_alias_get0: function(x: PX509; len: PIdC_INT): PByte cdecl = nil;
  X509_keyid_get0: function(x: PX509; len: PIdC_INT): PByte cdecl = nil;
//  TIdC_INT (*X509_TRUST_set_default(TIdC_INT (*trust) (TIdC_INT, X509 *, TIdC_INT))) (TIdC_INT, X509 *,
//                                                                  TIdC_INT);
  X509_TRUST_set: function(t: PIdC_INT; trust: TIdC_INT): TIdC_INT cdecl = nil;
  X509_add1_trust_object: function(x: PX509; const obj: PASN1_OBJECT): TIdC_INT cdecl = nil;
  X509_add1_reject_object: function(x: PX509; const obj: PASN1_OBJECT): TIdC_INT cdecl = nil;
  X509_trust_clear: procedure(x: PX509) cdecl = nil;
  X509_reject_clear: procedure(x: PX509) cdecl = nil;

  //STACK_OF(ASN1_OBJECT) *X509_get0_trust_objects(X509 *x);
  //STACK_OF(ASN1_OBJECT) *X509_get0_reject_objects(X509 *x);
  //
  X509_REVOKED_new: function: PX509_REVOKED cdecl = nil;
  X509_REVOKED_free: procedure(v1: PX509_REVOKED) cdecl = nil;
  d2i_X509_REVOKED: function(a: PPX509_REVOKED; const in_: PPByte; len: TIdC_LONG): PX509_REVOKED cdecl = nil;
  i2d_X509_REVOKED: function(a: PX509_REVOKED; out_: PPByte): TIdC_INT cdecl = nil;
  X509_CRL_INFO_new: function: PX509_CRL_INFO cdecl = nil;
  X509_CRL_INFO_free: procedure(v1: PX509_CRL_INFO) cdecl = nil;
  d2i_X509_CRL_INFO: function(a: PPX509_CRL_INFO; const in_: PPByte; len: TIdC_LONG): PX509_CRL_INFO cdecl = nil;
  i2d_X509_CRL_INFO: function(a: PX509_CRL_INFO; out_: PPByte): TIdC_INT cdecl = nil;
  X509_CRL_new: function: PX509_CRL cdecl = nil;
  X509_CRL_free: procedure(v1: PX509_CRL) cdecl = nil;
  d2i_X509_CRL: function(a: PPX509_CRL; const in_: PPByte; len: TIdC_LONG): PX509_CRL cdecl = nil;
  i2d_X509_CRL: function(a: PX509_CRL; out_: PPByte): TIdC_INT cdecl = nil;

  X509_CRL_add0_revoked: function(crl: PX509_CRL; rev: PX509_REVOKED): TIdC_INT cdecl = nil;
  X509_CRL_get0_by_serial: function(crl: PX509_CRL; ret: PPX509_REVOKED; serial: PASN1_INTEGER): TIdC_INT cdecl = nil;
  X509_CRL_get0_by_cert: function(crl: PX509_CRL; ret: PPX509_REVOKED; x: PX509): TIdC_INT cdecl = nil;

  X509_PKEY_new: function: PX509_PKEY cdecl = nil;
  X509_PKEY_free: procedure(a: PX509_PKEY) cdecl = nil;

  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_SPKI)
  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_SPKAC)
  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_CERT_SEQUENCE)

  X509_INFO_new: function: PX509_INFO cdecl = nil;
  X509_INFO_free: procedure(a: PX509_INFO) cdecl = nil;
  X509_NAME_oneline: function(const a: PX509_NAME; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl = nil;

//  function ASN1_verify(i2d: Pi2d_of_void; algor1: PX509_ALGOR;
//    signature: PASN1_BIT_STRING; data: PIdAnsiChar; pkey: PEVP_PKEY): TIdC_INT;

//  TIdC_INT ASN1_digest(i2d_of_void *i2d, const EVP_MD *type, char *data,
//                  unsigned char *md, unsigned TIdC_INT *len);

//  TIdC_INT ASN1_sign(i2d_of_void *i2d, X509_ALGOR *algor1,
//                X509_ALGOR *algor2, ASN1_BIT_STRING *signature,
//                char *data, EVP_PKEY *pkey, const EVP_MD *type);

  ASN1_item_digest: function(const it: PASN1_ITEM; const type_: PEVP_MD; data: Pointer; md: PByte; len: PIdC_UINT): TIdC_INT cdecl = nil;

  ASN1_item_verify: function(const it: PASN1_ITEM; algor1: PX509_ALGOR; signature: PASN1_BIT_STRING; data: Pointer; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  ASN1_item_sign: function(const it: PASN1_ITEM; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_BIT_STRING; data: Pointer; pkey: PEVP_PKEY; const type_: PEVP_MD): TIdC_INT cdecl = nil;
  ASN1_item_sign_ctx: function(const it: PASN1_ITEM; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_BIT_STRING; asn: Pointer; ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;

  X509_get_version: function(const x: PX509): TIdC_LONG cdecl = nil;
  X509_set_version: function(x: PX509; version: TIdC_LONG): TIdC_INT cdecl = nil;
  X509_set_serialNumber: function(x: PX509; serial: PASN1_INTEGER): TIdC_INT cdecl = nil;
  X509_get_serialNumber: function(x: PX509): PASN1_INTEGER cdecl = nil;
  X509_get0_serialNumber: function(const x: PX509): PASN1_INTEGER cdecl = nil;
  X509_set_issuer_name: function(x: PX509; name: PX509_NAME): TIdC_INT cdecl = nil;
  X509_get_issuer_name: function(const a: PX509): PX509_NAME cdecl = nil;
  X509_set_subject_name: function(x: PX509; name: PX509_NAME): TIdC_INT cdecl = nil;
  X509_get_subject_name: function(const a: PX509): PX509_NAME cdecl = nil;
  X509_get0_notBefore: function(const x: PX509): PASN1_TIME cdecl = nil;
  X509_getm_notBefore: function(const x: PX509): PASN1_TIME cdecl = nil;
  X509_set1_notBefore: function(x: PX509; const tm: PASN1_TIME): TIdC_INT cdecl = nil;
  X509_get0_notAfter: function(const x: PX509): PASN1_TIME cdecl = nil;
  X509_getm_notAfter: function(const x: PX509): PASN1_TIME cdecl = nil;
  X509_set1_notAfter: function(x: PX509; const tm: PASN1_TIME): TIdC_INT cdecl = nil;
  X509_set_pubkey: function(x: PX509; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  X509_up_ref: function(x: PX509): TIdC_INT cdecl = nil;
  X509_get_signature_type: function(const x: PX509): TIdC_INT cdecl = nil;

  (*
   * This one is only used so that a binary form can output, as in
   * i2d_X509_PUBKEY(X509_get_X509_PUBKEY(x), &buf)
   *)
  X509_get_X509_PUBKEY: function(const x: PX509): PX509_PUBKEY cdecl = nil;
//  const STACK_OF(X509_EXTENSION) *X509_get0_extensions(const X509 *x);
  X509_get0_uids: procedure(const x: PX509; const piuid: PPASN1_BIT_STRING; const psuid: PPASN1_BIT_STRING) cdecl = nil;
  X509_get0_tbs_sigalg: function(const x: PX509): PX509_ALGOR cdecl = nil;

  X509_get0_pubkey: function(const x: PX509): PEVP_PKEY cdecl = nil;
  X509_get_pubkey: function(x: PX509): PEVP_PKEY cdecl = nil;
  X509_get0_pubkey_bitstr: function(const x: PX509): PASN1_BIT_STRING cdecl = nil;
  X509_certificate_type: function(const x: PX509; const pubkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  X509_REQ_get_version: function(const req: PX509_REQ): TIdC_LONG cdecl = nil;
  X509_REQ_set_version: function(x: PX509_REQ; version: TIdC_LONG): TIdC_INT cdecl = nil;
  X509_REQ_get_subject_name: function(const req: PX509_REQ): PX509_NAME cdecl = nil;
  X509_REQ_set_subject_name: function(req: PX509_REQ; name: PX509_NAME): TIdC_INT cdecl = nil;
  X509_REQ_get0_signature: procedure(const req: PX509_REQ; const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR) cdecl = nil;
  X509_REQ_get_signature_nid: function(const req: PX509_REQ): TIdC_INT cdecl = nil;
  i2d_re_X509_REQ_tbs: function(req: PX509_REQ; pp: PPByte): TIdC_INT cdecl = nil;
  X509_REQ_set_pubkey: function(x: PX509_REQ; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  X509_REQ_get_pubkey: function(req: PX509_REQ): PEVP_PKEY cdecl = nil;
  X509_REQ_get0_pubkey: function(req: PX509_REQ): PEVP_PKEY cdecl = nil;
  X509_REQ_get_X509_PUBKEY: function(req: PX509_REQ): PX509_PUBKEY cdecl = nil;
  X509_REQ_extension_nid: function(nid: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REQ_get_extension_nids: function: PIdC_INT cdecl = nil;
  X509_REQ_set_extension_nids: procedure(nids: PIdC_INT) cdecl = nil;
//  STACK_OF(X509_EXTENSION) *X509_REQ_get_extensions(X509_REQ *req);
  //TIdC_INT X509_REQ_add_extensions_nid(X509_REQ *req, STACK_OF(X509_EXTENSION) *exts,
  //                                TIdC_INT nid);
  //TIdC_INT X509_REQ_add_extensions(X509_REQ *req, STACK_OF(X509_EXTENSION) *exts);
  X509_REQ_get_attr_count: function(const req: PX509_REQ): TIdC_INT cdecl = nil;
  X509_REQ_get_attr_by_NID: function(const req: PX509_REQ; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REQ_get_attr_by_OBJ: function(const req: PX509_REQ; const obj: ASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REQ_get_attr: function(const req: PX509_REQ; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  X509_REQ_delete_attr: function(req: PX509_REQ; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  X509_REQ_add1_attr: function(req: PX509_REQ; attr: PX509_ATTRIBUTE): TIdC_INT cdecl = nil;
  X509_REQ_add1_attr_by_OBJ: function(req: PX509_REQ; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REQ_add1_attr_by_NID: function(req: PX509_REQ; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REQ_add1_attr_by_txt: function(req: PX509_REQ; const attrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;

  X509_CRL_set_version: function(x: PX509_CRL; version: TIdC_LONG): TIdC_INT cdecl = nil;
  X509_CRL_set_issuer_name: function(x: PX509_CRL; name: PX509_NAME): TIdC_INT cdecl = nil;
  X509_CRL_set1_lastUpdate: function(x: PX509_CRL; const tm: PASN1_TIME): TIdC_INT cdecl = nil;
  X509_CRL_set1_nextUpdate: function(x: PX509_CRL; const tm: PASN1_TIME): TIdC_INT cdecl = nil;
  X509_CRL_sort: function(crl: PX509_CRL): TIdC_INT cdecl = nil;
  X509_CRL_up_ref: function(crl: PX509_CRL): TIdC_INT cdecl = nil;

  X509_CRL_get_version: function(const crl: PX509_CRL): TIdC_LONG cdecl = nil;
  X509_CRL_get0_lastUpdate: function(const crl: PX509_CRL): PASN1_TIME cdecl = nil;
  X509_CRL_get0_nextUpdate: function(const crl: PX509_CRL): PASN1_TIME cdecl = nil;
  X509_CRL_get_issuer: function(const crl: PX509_CRL): PX509_NAME cdecl = nil;
  //const STACK_OF(X509_EXTENSION) *X509_CRL_get0_extensions(const X509_CRL *crl);
  //STACK_OF(X509_REVOKED) *X509_CRL_get_REVOKED(X509_CRL *crl);
  X509_CRL_get0_signature: procedure(const crl: PX509_CRL; const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR) cdecl = nil;
   X509_CRL_get_signature_nid: function(const crl: PX509_CRL): TIdC_INT cdecl = nil;
  i2d_re_X509_CRL_tbs: function(req: PX509_CRL; pp: PPByte): TIdC_INT cdecl = nil;

  X509_REVOKED_get0_serialNumber: function(const x: PX509_REVOKED): PASN1_INTEGER cdecl = nil;
  X509_REVOKED_set_serialNumber: function(x: PX509_REVOKED; serial: PASN1_INTEGER): TIdC_INT cdecl = nil;
  X509_REVOKED_get0_revocationDate: function(const x: PX509_REVOKED): PASN1_TIME cdecl = nil;
  X509_REVOKED_set_revocationDate: function(r: PX509_REVOKED; tm: PASN1_TIME): TIdC_INT cdecl = nil;
  //const STACK_OF(X509_EXTENSION) *
  //X509_REVOKED_get0_extensions(const X509_REVOKED *r);

  X509_CRL_diff: function(base: PX509_CRL; newer: PX509_CRL; skey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_UINT): PX509_CRL cdecl = nil;

  X509_REQ_check_private_key: function(x509: PX509_REQ; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  X509_check_private_key: function(const x509: PX509; const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  //TIdC_INT X509_chain_check_suiteb(TIdC_INT *perror_depth,
  //                            X509 *x, STACK_OF(X509) *chain,
  //                            unsigned TIdC_LONG flags);
  X509_CRL_check_suiteb: function(crl: PX509_CRL; pk: PEVP_PKEY; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  //STACK_OF(X509) *X509_chain_up_ref(STACK_OF(X509) *chain);

  X509_issuer_and_serial_cmp: function(const a: PX509; const b: PX509): TIdC_INT cdecl = nil;
  X509_issuer_and_serial_hash: function(a: PX509): TIdC_ULONG cdecl = nil;

  X509_issuer_name_cmp: function(const a: PX509; const b: PX509): TIdC_INT cdecl = nil;
  X509_issuer_name_hash: function(a: PX509): TIdC_uLONG cdecl = nil;

  X509_subject_name_cmp: function(const a: PX509; const b: PX509): TIdC_INT cdecl = nil;
  X509_subject_name_hash: function(x: PX509): TIdC_ULONG cdecl = nil;

  X509_cmp: function(const a: PX509; const b: PX509): TIdC_INT cdecl = nil;
  X509_NAME_cmp: function(const a: PX509_NAME; const b: PX509_NAME): TIdC_INT cdecl = nil;
  X509_NAME_hash: function(x: PX509_NAME): TIdC_ULONG cdecl = nil;
  X509_NAME_hash_old: function(x: PX509_NAME): TIdC_ULONG cdecl = nil;

  X509_CRL_cmp: function(const a: PX509_CRL; const b: PX509_CRL): TIdC_INT cdecl = nil;
  X509_CRL_match: function(const a: PX509_CRL; const b: PX509_CRL): TIdC_INT cdecl = nil;
  X509_aux_print: function(&out: PBIO; x: PX509; indent: TIdC_INT): TIdC_INT cdecl = nil;
  //# ifndef OPENSSL_NO_STDIO
  //TIdC_INT X509_print_ex_fp(FILE *bp, X509 *x, unsigned TIdC_LONG nmflag,
  //                     unsigned TIdC_LONG cflag);
  //TIdC_INT X509_print_fp(FILE *bp, X509 *x);
  //TIdC_INT X509_CRL_print_fp(FILE *bp, X509_CRL *x);
  //TIdC_INT X509_REQ_print_fp(FILE *bp, X509_REQ *req);
  //TIdC_INT X509_NAME_print_ex_fp(FILE *fp, const X509_NAME *nm, TIdC_INT indent,
  //                          unsigned TIdC_LONG flags);
  //# endif

  X509_NAME_print: function(bp: PBIO; const name: PX509_NAME; obase: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_print_ex: function(&out: PBIO; const nm: PX509_NAME; indent: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_print_ex: function(bp: PBIO; x: PX509; nmflag: TIdC_ULONG; cflag: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_print: function(bp: PBIO; x: PX509): TIdC_INT cdecl = nil;
  X509_ocspid_print: function(bp: PBIO; x: PX509): TIdC_INT cdecl = nil;
  X509_CRL_print_ex: function(&out: PBIO; x: PX509_CRL; nmflag: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_CRL_print: function(bp: PBIO; x: PX509_CRL): TIdC_INT cdecl = nil;
  X509_REQ_print_ex: function(bp: PBIO; x: PX509_REQ; nmflag: TIdC_ULONG; cflag: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_REQ_print: function(bp: PBIO; req: PX509_REQ): TIdC_INT cdecl = nil;

  X509_NAME_entry_count: function(const name: PX509_NAME): TIdC_INT cdecl = nil;
  X509_NAME_get_text_by_NID: function(name: PX509_NAME; nid: TIdC_INT; buf: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_get_text_by_OBJ: function(name: PX509_NAME; const obj: PASN1_OBJECT; buf: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl = nil;

  (*
   * NOTE: you should be passing -1, not 0 as lastpos. The functions that use
   * lastpos, search after that position on.
   *)
  X509_NAME_get_index_by_NID: function(name: PX509_NAME; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_get_index_by_OBJ: function(name: PX509_NAME; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_get_entry: function(const name: PX509_NAME; loc: TIdC_INT): PX509_NAME_ENTRY cdecl = nil;
  X509_NAME_delete_entry: function(name: PX509_NAME; loc: TIdC_INT): pX509_NAME_ENTRY cdecl = nil;
  X509_NAME_add_entry: function(name: PX509_NAME; const ne: PX509_NAME_ENTRY; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_add_entry_by_OBJ: function(name: PX509_NAME; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_add_entry_by_NID: function(name: PX509_NAME; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_ENTRY_create_by_txt: function(ne: PPX509_NAME_ENTRY; const field: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl = nil;
  X509_NAME_ENTRY_create_by_NID: function(ne: PPX509_NAME_ENTRY; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl = nil;
  X509_NAME_add_entry_by_txt: function(name: PX509_NAME; const field: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_ENTRY_create_by_OBJ: function(ne: PPX509_NAME_ENTRY; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl = nil;
  X509_NAME_ENTRY_set_object: function(ne: PX509_NAME_ENTRY; const obj: PASN1_OBJECT): TIdC_INT cdecl = nil;
  X509_NAME_ENTRY_set_data: function(ne: PX509_NAME_ENTRY; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_NAME_ENTRY_get_object: function(const ne: PX509_NAME_ENTRY): PASN1_OBJECT cdecl = nil;
  X509_NAME_ENTRY_get_data: function(const ne: PX509_NAME_ENTRY): PASN1_STRING cdecl = nil;
  X509_NAME_ENTRY_set: function(const ne: PX509_NAME_ENTRY): TIdC_INT cdecl = nil;

  X509_NAME_get0_der: function(nm: PX509_NAME; const pder: PPByte; pderlen: PIdC_SIZET): TIdC_INT cdecl = nil;

  //TIdC_INT X509v3_get_ext_count(const STACK_OF(X509_EXTENSION) *x);
  //TIdC_INT X509v3_get_ext_by_NID(const STACK_OF(X509_EXTENSION) *x,
  //                          TIdC_INT nid, TIdC_INT lastpos);
  //TIdC_INT X509v3_get_ext_by_OBJ(const STACK_OF(X509_EXTENSION) *x,
  //                          const ASN1_OBJECT *obj, TIdC_INT lastpos);
  //TIdC_INT X509v3_get_ext_by_critical(const STACK_OF(X509_EXTENSION) *x,
  //                               TIdC_INT crit, TIdC_INT lastpos);
  //X509_EXTENSION *X509v3_get_ext(const STACK_OF(X509_EXTENSION) *x, TIdC_INT loc);
  //X509_EXTENSION *X509v3_delete_ext(STACK_OF(X509_EXTENSION) *x, TIdC_INT loc);
  //STACK_OF(X509_EXTENSION) *X509v3_add_ext(STACK_OF(X509_EXTENSION) **x,
  //                                         X509_EXTENSION *ex, TIdC_INT loc);

  X509_get_ext_count: function(const x: PX509): TIdC_INT cdecl = nil;
  X509_get_ext_by_NID: function(const x: PX509; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_get_ext_by_OBJ: function(const x: PX509; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_get_ext_by_critical: function(const x: PX509; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_get_ext: function(const x: PX509; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_delete_ext: function(x: PX509; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_add_ext: function(x: PX509; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl = nil;
  X509_get_ext_d2i: function(const x: PX509; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl = nil;
  X509_add1_ext_i2d: function(x: PX509; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl = nil;

  X509_CRL_get_ext_count: function(const x: PX509_CRL): TIdC_INT cdecl = nil;
  X509_CRL_get_ext_by_NID: function(const x: PX509_CRL; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_CRL_get_ext_by_OBJ: function(const x: X509_CRL; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_CRL_get_ext_by_critical: function(const x: PX509_CRL; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_CRL_get_ext: function(const x: PX509_CRL; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_CRL_delete_ext: function(x: PX509_CRL; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_CRL_add_ext: function(x: PX509_CRL; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl = nil;
  X509_CRL_get_ext_d2i: function(const x: PX509_CRL; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl = nil;
  X509_CRL_add1_ext_i2d: function(x: PX509_CRL; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl = nil;

  X509_REVOKED_get_ext_count: function(const x: PX509_REVOKED): TIdC_INT cdecl = nil;
  X509_REVOKED_get_ext_by_NID: function(const x: PX509_REVOKED; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REVOKED_get_ext_by_OBJ: function(const x: PX509_REVOKED; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REVOKED_get_ext_by_critical: function(const x: PX509_REVOKED; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REVOKED_get_ext: function(const x: PX509_REVOKED; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_REVOKED_delete_ext: function(x: PX509_REVOKED; loc: TIdC_INT): PX509_EXTENSION cdecl = nil;
  X509_REVOKED_add_ext: function(x: PX509_REVOKED; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl = nil;
  X509_REVOKED_get_ext_d2i: function(const x: PX509_REVOKED; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl = nil;
  X509_REVOKED_add1_ext_i2d: function(x: PX509_REVOKED; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl = nil;

  X509_EXTENSION_create_by_NID: function(ex: PPX509_EXTENSION; nid: TIdC_INT; crit: TIdC_INT; data: PASN1_OCTET_STRING): PX509_EXTENSION cdecl = nil;
  X509_EXTENSION_create_by_OBJ: function(ex: PPX509_EXTENSION; const obj: PASN1_OBJECT; crit: TIdC_INT; data: PASN1_OCTET_STRING): PX509_EXTENSION cdecl = nil;
  X509_EXTENSION_set_object: function(ex: PX509_EXTENSION; const obj: PASN1_OBJECT): TIdC_INT cdecl = nil;
  X509_EXTENSION_set_critical: function(ex: PX509_EXTENSION; crit: TIdC_INT): TIdC_INT cdecl = nil;
  X509_EXTENSION_set_data: function(ex: PX509_EXTENSION; data: PASN1_OCTET_STRING): TIdC_INT cdecl = nil;
  X509_EXTENSION_get_object: function(ex: PX509_EXTENSION): PASN1_OBJECT cdecl = nil;
  X509_EXTENSION_get_data: function(ne: PX509_EXTENSION): PASN1_OCTET_STRING cdecl = nil;
  X509_EXTENSION_get_critical: function(const ex: PX509_EXTENSION): TIdC_INT cdecl = nil;

  //TIdC_INT X509at_get_attr_count(const STACK_OF(X509_ATTRIBUTE) *x);
  //TIdC_INT X509at_get_attr_by_NID(const STACK_OF(X509_ATTRIBUTE) *x, TIdC_INT nid,
  //                           TIdC_INT lastpos);
  //TIdC_INT X509at_get_attr_by_OBJ(const STACK_OF(X509_ATTRIBUTE) *sk,
  //                           const ASN1_OBJECT *obj, TIdC_INT lastpos);
  //X509_ATTRIBUTE *X509at_get_attr(const STACK_OF(X509_ATTRIBUTE) *x, TIdC_INT loc);
  //X509_ATTRIBUTE *X509at_delete_attr(STACK_OF(X509_ATTRIBUTE) *x, TIdC_INT loc);
  //STACK_OF(X509_ATTRIBUTE) *X509at_add1_attr(STACK_OF(X509_ATTRIBUTE) **x,
  //                                           X509_ATTRIBUTE *attr);
  //STACK_OF(X509_ATTRIBUTE) *X509at_add1_attr_by_OBJ(STACK_OF(X509_ATTRIBUTE)
  //                                                  **x, const ASN1_OBJECT *obj,
  //                                                  TIdC_INT type,
  //                                                  const unsigned char *bytes,
  //                                                  TIdC_INT len);
  //STACK_OF(X509_ATTRIBUTE) *X509at_add1_attr_by_NID(STACK_OF(X509_ATTRIBUTE)
  //                                                  **x, TIdC_INT nid, TIdC_INT type,
  //                                                  const unsigned char *bytes,
  //                                                  TIdC_INT len);
  //STACK_OF(X509_ATTRIBUTE) *X509at_add1_attr_by_txt(STACK_OF(X509_ATTRIBUTE)
  //                                                  **x, const PIdAnsiChar *attrname,
  //                                                  TIdC_INT type,
  //                                                  const unsigned char *bytes,
  //                                                  TIdC_INT len);
  //void *X509at_get0_data_by_OBJ(STACK_OF(X509_ATTRIBUTE) *x,
  //                              const ASN1_OBJECT *obj, TIdC_INT lastpos, TIdC_INT type);
  X509_ATTRIBUTE_create_by_NID: function(attr: PPX509_ATTRIBUTE; nid: TIdC_INT; atrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  X509_ATTRIBUTE_create_by_OBJ: function(attr: PPX509_ATTRIBUTE; const obj: PASN1_OBJECT; atrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  X509_ATTRIBUTE_create_by_txt: function(attr: PPX509_ATTRIBUTE; const atrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  X509_ATTRIBUTE_set1_object: function(attr: PX509_ATTRIBUTE; const obj: PASN1_OBJECT): TIdC_INT cdecl = nil;
  X509_ATTRIBUTE_set1_data: function(attr: PX509_ATTRIBUTE; attrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  X509_ATTRIBUTE_get0_data: function(attr: PX509_ATTRIBUTE; idx: TIdC_INT; atrtype: TIdC_INT; data: Pointer): Pointer cdecl = nil;
  X509_ATTRIBUTE_count: function(const attr: PX509_ATTRIBUTE): TIdC_INT cdecl = nil;
  X509_ATTRIBUTE_get0_object: function(attr: PX509_ATTRIBUTE): PASN1_OBJECT cdecl = nil;
  X509_ATTRIBUTE_get0_type: function(attr: PX509_ATTRIBUTE; idx: TIdC_INT): PASN1_TYPE cdecl = nil;

  EVP_PKEY_get_attr_count: function(const key: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_get_attr_by_NID: function(const key: PEVP_PKEY; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_get_attr_by_OBJ: function(const key: PEVP_PKEY; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_get_attr: function(const key: PEVP_PKEY; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  EVP_PKEY_delete_attr: function(key: PEVP_PKEY; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  EVP_PKEY_add1_attr: function(key: PEVP_PKEY; attr: PX509_ATTRIBUTE): TIdC_INT cdecl = nil;
  EVP_PKEY_add1_attr_by_OBJ: function(key: PEVP_PKEY; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_add1_attr_by_NID: function(key: PEVP_PKEY; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_add1_attr_by_txt: function(key: PEVP_PKEY; const attrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;

  X509_verify_cert: function(ctx: PX509_STORE_CTX): TIdC_INT cdecl = nil;

  (* lookup a cert from a X509 STACK *)
//  function X509_find_by_issuer_and_serial(sk: P STACK_OF(X509); name: PX509_NAME; serial: PASN1_INTEGER): PX509;
//  X509 *X509_find_by_subject(STACK_OF(X509) *sk, X509_NAME *name);

  //DECLARE_ASN1_FUNCTIONS(PBEPARAM)
  //DECLARE_ASN1_FUNCTIONS(PBE2PARAM)
  //DECLARE_ASN1_FUNCTIONS(PBKDF2PARAM)
  //#ifndef OPENSSL_NO_SCRYPT
  //DECLARE_ASN1_FUNCTIONS(SCRYPT_PARAMS)
  //#endif

  PKCS5_pbe_set0_algor: function(algor: PX509_ALGOR; alg: TIdC_INT; iter: TIdC_INT; const salt: PByte; saltlen: TIdC_INT): TIdC_INT cdecl = nil;

  PKCS5_pbe_set: function(alg: TIdC_INT; iter: TIdC_INT; const salt: PByte; saltlen: TIdC_INT): PX509_ALGOR cdecl = nil;
  PKCS5_pbe2_set: function(const cipher: PEVP_CIPHER; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT): PX509_ALGOR cdecl = nil;
  PKCS5_pbe2_set_iv: function(const cipher: PEVP_CIPHER; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; aiv: PByte; prf_nid: TIdC_INT): PX509_ALGOR cdecl = nil;

  PKCS5_pbe2_set_scrypt: function(const cipher: PEVP_CIPHER; const salt: PByte; saltlen: TIdC_INT; aiv: PByte; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64): PX509_ALGOR cdecl = nil;

  PKCS5_pbkdf2_set: function(iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; prf_nid: TIdC_INT; keylen: TIdC_INT): PX509_ALGOR cdecl = nil;

  (* PKCS#8 utilities *)

  //DECLARE_ASN1_FUNCTIONS(PKCS8_PRIV_KEY_INFO)

  EVP_PKCS82PKEY: function(const p8: PPKCS8_PRIV_KEY_INFO): PEVP_PKEY cdecl = nil;
  EVP_PKEY2PKCS8: function(pkey: PEVP_PKEY): PKCS8_PRIV_KEY_INFO cdecl = nil;

  PKCS8_pkey_set0: function(priv: PPKCS8_PRIV_KEY_INFO; aobj: PASN1_OBJECT; version: TIdC_INT; ptype: TIdC_INT; pval: Pointer; penc: PByte; penclen: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS8_pkey_get0: function(const ppkalg: PPASN1_OBJECT; const pk: PPByte; ppklen: PIdC_INT; const pa: PPX509_ALGOR; const p8: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl = nil;

  //const STACK_OF(X509_ATTRIBUTE) *
  //PKCS8_pkey_get0_attrs(const PKCS8_PRIV_KEY_INFO *p8);
  PKCS8_pkey_add1_attr_by_NID: function(p8: PPKCS8_PRIV_KEY_INFO; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;

  X509_PUBKEY_set0_param: function(pub: PX509_PUBKEY; aobj: PASN1_OBJECT; ptype: TIdC_INT; pval: Pointer; penc: PByte; penclen: TIdC_INT): TIdC_INT cdecl = nil;
  X509_PUBKEY_get0_param: function(ppkalg: PPASN1_OBJECT; const pk: PPByte; ppklen: PIdC_INT; pa: PPX509_ALGOR; pub: PX509_PUBKEY): TIdC_INT cdecl = nil;

  X509_check_trust: function(x: PX509; id: TIdC_INT; flags: TIdC_INT): TIdC_INT cdecl = nil;
  X509_TRUST_get_count: function: TIdC_INT cdecl = nil;
  X509_TRUST_get0: function(idx: TIdC_INT): PX509_TRUST cdecl = nil;
  X509_TRUST_get_by_id: function(id: TIdC_INT): TIdC_INT cdecl = nil;
//  TIdC_INT X509_TRUST_add(TIdC_INT id, TIdC_INT flags, TIdC_INT (*ck) (X509_TRUST *, X509 *, TIdC_INT),
//                     const PIdAnsiChar *name, TIdC_INT arg1, void *arg2);
  X509_TRUST_cleanup: procedure cdecl = nil;
  X509_TRUST_get_flags: function(const xp: PX509_TRUST): TIdC_INT cdecl = nil;
  X509_TRUST_get0_name: function(const xp: PX509_TRUST): PIdAnsiChar cdecl = nil;
  X509_TRUST_get_trust: function(const xp: PX509_TRUST): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  X509_CRL_set_default_method := LoadFunction('X509_CRL_set_default_method', AFailed);
  X509_CRL_METHOD_free := LoadFunction('X509_CRL_METHOD_free', AFailed);
  X509_CRL_set_meth_data := LoadFunction('X509_CRL_set_meth_data', AFailed);
  X509_CRL_get_meth_data := LoadFunction('X509_CRL_get_meth_data', AFailed);
  X509_verify_cert_error_string := LoadFunction('X509_verify_cert_error_string', AFailed);
  X509_verify := LoadFunction('X509_verify', AFailed);
  X509_REQ_verify := LoadFunction('X509_REQ_verify', AFailed);
  X509_CRL_verify := LoadFunction('X509_CRL_verify', AFailed);
  NETSCAPE_SPKI_verify := LoadFunction('NETSCAPE_SPKI_verify', AFailed);
  NETSCAPE_SPKI_b64_decode := LoadFunction('NETSCAPE_SPKI_b64_decode', AFailed);
  NETSCAPE_SPKI_b64_encode := LoadFunction('NETSCAPE_SPKI_b64_encode', AFailed);
  NETSCAPE_SPKI_get_pubkey := LoadFunction('NETSCAPE_SPKI_get_pubkey', AFailed);
  NETSCAPE_SPKI_set_pubkey := LoadFunction('NETSCAPE_SPKI_set_pubkey', AFailed);
  NETSCAPE_SPKI_print := LoadFunction('NETSCAPE_SPKI_print', AFailed);
  X509_signature_dump := LoadFunction('X509_signature_dump', AFailed);
  X509_signature_print := LoadFunction('X509_signature_print', AFailed);
  X509_sign := LoadFunction('X509_sign', AFailed);
  X509_sign_ctx := LoadFunction('X509_sign_ctx', AFailed);
  X509_http_nbio := LoadFunction('X509_http_nbio', AFailed);
  X509_REQ_sign := LoadFunction('X509_REQ_sign', AFailed);
  X509_REQ_sign_ctx := LoadFunction('X509_REQ_sign_ctx', AFailed);
  X509_CRL_sign := LoadFunction('X509_CRL_sign', AFailed);
  X509_CRL_sign_ctx := LoadFunction('X509_CRL_sign_ctx', AFailed);
  X509_CRL_http_nbio := LoadFunction('X509_CRL_http_nbio', AFailed);
  NETSCAPE_SPKI_sign := LoadFunction('NETSCAPE_SPKI_sign', AFailed);
  X509_pubkey_digest := LoadFunction('X509_pubkey_digest', AFailed);
  X509_digest := LoadFunction('X509_digest', AFailed);
  X509_CRL_digest := LoadFunction('X509_CRL_digest', AFailed);
  X509_REQ_digest := LoadFunction('X509_REQ_digest', AFailed);
  X509_NAME_digest := LoadFunction('X509_NAME_digest', AFailed);
  d2i_X509_bio := LoadFunction('d2i_X509_bio', AFailed);
  i2d_X509_bio := LoadFunction('i2d_X509_bio', AFailed);
  d2i_X509_CRL_bio := LoadFunction('d2i_X509_CRL_bio', AFailed);
  i2d_X509_CRL_bio := LoadFunction('i2d_X509_CRL_bio', AFailed);
  d2i_X509_REQ_bio := LoadFunction('d2i_X509_REQ_bio', AFailed);
  i2d_X509_REQ_bio := LoadFunction('i2d_X509_REQ_bio', AFailed);
  d2i_RSAPrivateKey_bio := LoadFunction('d2i_RSAPrivateKey_bio', AFailed);
  i2d_RSAPrivateKey_bio := LoadFunction('i2d_RSAPrivateKey_bio', AFailed);
  d2i_RSAPublicKey_bio := LoadFunction('d2i_RSAPublicKey_bio', AFailed);
  i2d_RSAPublicKey_bio := LoadFunction('i2d_RSAPublicKey_bio', AFailed);
  d2i_RSA_PUBKEY_bio := LoadFunction('d2i_RSA_PUBKEY_bio', AFailed);
  i2d_RSA_PUBKEY_bio := LoadFunction('i2d_RSA_PUBKEY_bio', AFailed);
  d2i_DSA_PUBKEY_bio := LoadFunction('d2i_DSA_PUBKEY_bio', AFailed);
  i2d_DSA_PUBKEY_bio := LoadFunction('i2d_DSA_PUBKEY_bio', AFailed);
  d2i_DSAPrivateKey_bio := LoadFunction('d2i_DSAPrivateKey_bio', AFailed);
  i2d_DSAPrivateKey_bio := LoadFunction('i2d_DSAPrivateKey_bio', AFailed);
  d2i_EC_PUBKEY_bio := LoadFunction('d2i_EC_PUBKEY_bio', AFailed);
  i2d_EC_PUBKEY_bio := LoadFunction('i2d_EC_PUBKEY_bio', AFailed);
  d2i_ECPrivateKey_bio := LoadFunction('d2i_ECPrivateKey_bio', AFailed);
  i2d_ECPrivateKey_bio := LoadFunction('i2d_ECPrivateKey_bio', AFailed);
  d2i_PKCS8_bio := LoadFunction('d2i_PKCS8_bio', AFailed);
  i2d_PKCS8_bio := LoadFunction('i2d_PKCS8_bio', AFailed);
  d2i_PKCS8_PRIV_KEY_INFO_bio := LoadFunction('d2i_PKCS8_PRIV_KEY_INFO_bio', AFailed);
  i2d_PKCS8_PRIV_KEY_INFO_bio := LoadFunction('i2d_PKCS8_PRIV_KEY_INFO_bio', AFailed);
  i2d_PKCS8PrivateKeyInfo_bio := LoadFunction('i2d_PKCS8PrivateKeyInfo_bio', AFailed);
  i2d_PrivateKey_bio := LoadFunction('i2d_PrivateKey_bio', AFailed);
  d2i_PrivateKey_bio := LoadFunction('d2i_PrivateKey_bio', AFailed);
  i2d_PUBKEY_bio := LoadFunction('i2d_PUBKEY_bio', AFailed);
  d2i_PUBKEY_bio := LoadFunction('d2i_PUBKEY_bio', AFailed);
  X509_dup := LoadFunction('X509_dup', AFailed);
  X509_ATTRIBUTE_dup := LoadFunction('X509_ATTRIBUTE_dup', AFailed);
  X509_EXTENSION_dup := LoadFunction('X509_EXTENSION_dup', AFailed);
  X509_CRL_dup := LoadFunction('X509_CRL_dup', AFailed);
  X509_REVOKED_dup := LoadFunction('X509_REVOKED_dup', AFailed);
  X509_REQ_dup := LoadFunction('X509_REQ_dup', AFailed);
  X509_ALGOR_dup := LoadFunction('X509_ALGOR_dup', AFailed);
  X509_ALGOR_set0 := LoadFunction('X509_ALGOR_set0', AFailed);
  X509_ALGOR_get0 := LoadFunction('X509_ALGOR_get0', AFailed);
  X509_ALGOR_set_md := LoadFunction('X509_ALGOR_set_md', AFailed);
  X509_ALGOR_cmp := LoadFunction('X509_ALGOR_cmp', AFailed);
  X509_NAME_dup := LoadFunction('X509_NAME_dup', AFailed);
  X509_NAME_ENTRY_dup := LoadFunction('X509_NAME_ENTRY_dup', AFailed);
  X509_cmp_time := LoadFunction('X509_cmp_time', AFailed);
  X509_cmp_current_time := LoadFunction('X509_cmp_current_time', AFailed);
  X509_time_adj := LoadFunction('X509_time_adj', AFailed);
  X509_time_adj_ex := LoadFunction('X509_time_adj_ex', AFailed);
  X509_gmtime_adj := LoadFunction('X509_gmtime_adj', AFailed);
  X509_get_default_cert_area := LoadFunction('X509_get_default_cert_area', AFailed);
  X509_get_default_cert_dir := LoadFunction('X509_get_default_cert_dir', AFailed);
  X509_get_default_cert_file := LoadFunction('X509_get_default_cert_file', AFailed);
  X509_get_default_cert_dir_env := LoadFunction('X509_get_default_cert_dir_env', AFailed);
  X509_get_default_cert_file_env := LoadFunction('X509_get_default_cert_file_env', AFailed);
  X509_get_default_private_dir := LoadFunction('X509_get_default_private_dir', AFailed);
  X509_to_X509_REQ := LoadFunction('X509_to_X509_REQ', AFailed);
  X509_REQ_to_X509 := LoadFunction('X509_REQ_to_X509', AFailed);
  X509_ALGOR_new := LoadFunction('X509_ALGOR_new', AFailed);
  X509_ALGOR_free := LoadFunction('X509_ALGOR_free', AFailed);
  d2i_X509_ALGOR := LoadFunction('d2i_X509_ALGOR', AFailed);
  i2d_X509_ALGOR := LoadFunction('i2d_X509_ALGOR', AFailed);
  X509_VAL_new := LoadFunction('X509_VAL_new', AFailed);
  X509_VAL_free := LoadFunction('X509_VAL_free', AFailed);
  d2i_X509_VAL := LoadFunction('d2i_X509_VAL', AFailed);
  i2d_X509_VAL := LoadFunction('i2d_X509_VAL', AFailed);
  X509_PUBKEY_new := LoadFunction('X509_PUBKEY_new', AFailed);
  X509_PUBKEY_free := LoadFunction('X509_PUBKEY_free', AFailed);
  d2i_X509_PUBKEY := LoadFunction('d2i_X509_PUBKEY', AFailed);
  i2d_X509_PUBKEY := LoadFunction('i2d_X509_PUBKEY', AFailed);
  X509_PUBKEY_set := LoadFunction('X509_PUBKEY_set', AFailed);
  X509_PUBKEY_get0 := LoadFunction('X509_PUBKEY_get0', AFailed);
  X509_PUBKEY_get := LoadFunction('X509_PUBKEY_get', AFailed);
  X509_get_pathlen := LoadFunction('X509_get_pathlen', AFailed);
  i2d_PUBKEY := LoadFunction('i2d_PUBKEY', AFailed);
  d2i_PUBKEY := LoadFunction('d2i_PUBKEY', AFailed);
  i2d_RSA_PUBKEY := LoadFunction('i2d_RSA_PUBKEY', AFailed);
  d2i_RSA_PUBKEY := LoadFunction('d2i_RSA_PUBKEY', AFailed);
  i2d_DSA_PUBKEY := LoadFunction('i2d_DSA_PUBKEY', AFailed);
  d2i_DSA_PUBKEY := LoadFunction('d2i_DSA_PUBKEY', AFailed);
  i2d_EC_PUBKEY := LoadFunction('i2d_EC_PUBKEY', AFailed);
  d2i_EC_PUBKEY := LoadFunction('d2i_EC_PUBKEY', AFailed);
  X509_SIG_new := LoadFunction('X509_SIG_new', AFailed);
  X509_SIG_free := LoadFunction('X509_SIG_free', AFailed);
  d2i_X509_SIG := LoadFunction('d2i_X509_SIG', AFailed);
  i2d_X509_SIG := LoadFunction('i2d_X509_SIG', AFailed);
  X509_SIG_get0 := LoadFunction('X509_SIG_get0', AFailed);
  X509_SIG_getm := LoadFunction('X509_SIG_getm', AFailed);
  X509_REQ_INFO_new := LoadFunction('X509_REQ_INFO_new', AFailed);
  X509_REQ_INFO_free := LoadFunction('X509_REQ_INFO_free', AFailed);
  d2i_X509_REQ_INFO := LoadFunction('d2i_X509_REQ_INFO', AFailed);
  i2d_X509_REQ_INFO := LoadFunction('i2d_X509_REQ_INFO', AFailed);
  X509_REQ_new := LoadFunction('X509_REQ_new', AFailed);
  X509_REQ_free := LoadFunction('X509_REQ_free', AFailed);
  d2i_X509_REQ := LoadFunction('d2i_X509_REQ', AFailed);
  i2d_X509_REQ := LoadFunction('i2d_X509_REQ', AFailed);
  X509_ATTRIBUTE_new := LoadFunction('X509_ATTRIBUTE_new', AFailed);
  X509_ATTRIBUTE_free := LoadFunction('X509_ATTRIBUTE_free', AFailed);
  d2i_X509_ATTRIBUTE := LoadFunction('d2i_X509_ATTRIBUTE', AFailed);
  i2d_X509_ATTRIBUTE := LoadFunction('i2d_X509_ATTRIBUTE', AFailed);
  X509_ATTRIBUTE_create := LoadFunction('X509_ATTRIBUTE_create', AFailed);
  X509_EXTENSION_new := LoadFunction('X509_EXTENSION_new', AFailed);
  X509_EXTENSION_free := LoadFunction('X509_EXTENSION_free', AFailed);
  d2i_X509_EXTENSION := LoadFunction('d2i_X509_EXTENSION', AFailed);
  i2d_X509_EXTENSION := LoadFunction('i2d_X509_EXTENSION', AFailed);
  X509_NAME_ENTRY_new := LoadFunction('X509_NAME_ENTRY_new', AFailed);
  X509_NAME_ENTRY_free := LoadFunction('X509_NAME_ENTRY_free', AFailed);
  d2i_X509_NAME_ENTRY := LoadFunction('d2i_X509_NAME_ENTRY', AFailed);
  i2d_X509_NAME_ENTRY := LoadFunction('i2d_X509_NAME_ENTRY', AFailed);
  X509_NAME_new := LoadFunction('X509_NAME_new', AFailed);
  X509_NAME_free := LoadFunction('X509_NAME_free', AFailed);
  d2i_X509_NAME := LoadFunction('d2i_X509_NAME', AFailed);
  i2d_X509_NAME := LoadFunction('i2d_X509_NAME', AFailed);
  X509_NAME_set := LoadFunction('X509_NAME_set', AFailed);
  X509_new := LoadFunction('X509_new', AFailed);
  X509_free := LoadFunction('X509_free', AFailed);
  d2i_X509 := LoadFunction('d2i_X509', AFailed);
  i2d_X509 := LoadFunction('i2d_X509', AFailed);
  X509_set_ex_data := LoadFunction('X509_set_ex_data', AFailed);
  X509_get_ex_data := LoadFunction('X509_get_ex_data', AFailed);
  i2d_X509_AUX := LoadFunction('i2d_X509_AUX', AFailed);
  d2i_X509_AUX := LoadFunction('d2i_X509_AUX', AFailed);
  i2d_re_X509_tbs := LoadFunction('i2d_re_X509_tbs', AFailed);
  X509_SIG_INFO_get := LoadFunction('X509_SIG_INFO_get', AFailed);
  X509_SIG_INFO_set := LoadFunction('X509_SIG_INFO_set', AFailed);
  X509_get_signature_info := LoadFunction('X509_get_signature_info', AFailed);
  X509_get0_signature := LoadFunction('X509_get0_signature', AFailed);
  X509_get_signature_nid := LoadFunction('X509_get_signature_nid', AFailed);
  X509_trusted := LoadFunction('X509_trusted', AFailed);
  X509_alias_set1 := LoadFunction('X509_alias_set1', AFailed);
  X509_keyid_set1 := LoadFunction('X509_keyid_set1', AFailed);
  X509_alias_get0 := LoadFunction('X509_alias_get0', AFailed);
  X509_keyid_get0 := LoadFunction('X509_keyid_get0', AFailed);
  X509_TRUST_set := LoadFunction('X509_TRUST_set', AFailed);
  X509_add1_trust_object := LoadFunction('X509_add1_trust_object', AFailed);
  X509_add1_reject_object := LoadFunction('X509_add1_reject_object', AFailed);
  X509_trust_clear := LoadFunction('X509_trust_clear', AFailed);
  X509_reject_clear := LoadFunction('X509_reject_clear', AFailed);
  X509_REVOKED_new := LoadFunction('X509_REVOKED_new', AFailed);
  X509_REVOKED_free := LoadFunction('X509_REVOKED_free', AFailed);
  d2i_X509_REVOKED := LoadFunction('d2i_X509_REVOKED', AFailed);
  i2d_X509_REVOKED := LoadFunction('i2d_X509_REVOKED', AFailed);
  X509_CRL_INFO_new := LoadFunction('X509_CRL_INFO_new', AFailed);
  X509_CRL_INFO_free := LoadFunction('X509_CRL_INFO_free', AFailed);
  d2i_X509_CRL_INFO := LoadFunction('d2i_X509_CRL_INFO', AFailed);
  i2d_X509_CRL_INFO := LoadFunction('i2d_X509_CRL_INFO', AFailed);
  X509_CRL_new := LoadFunction('X509_CRL_new', AFailed);
  X509_CRL_free := LoadFunction('X509_CRL_free', AFailed);
  d2i_X509_CRL := LoadFunction('d2i_X509_CRL', AFailed);
  i2d_X509_CRL := LoadFunction('i2d_X509_CRL', AFailed);
  X509_CRL_add0_revoked := LoadFunction('X509_CRL_add0_revoked', AFailed);
  X509_CRL_get0_by_serial := LoadFunction('X509_CRL_get0_by_serial', AFailed);
  X509_CRL_get0_by_cert := LoadFunction('X509_CRL_get0_by_cert', AFailed);
  X509_PKEY_new := LoadFunction('X509_PKEY_new', AFailed);
  X509_PKEY_free := LoadFunction('X509_PKEY_free', AFailed);
  X509_INFO_new := LoadFunction('X509_INFO_new', AFailed);
  X509_INFO_free := LoadFunction('X509_INFO_free', AFailed);
  X509_NAME_oneline := LoadFunction('X509_NAME_oneline', AFailed);
  ASN1_item_digest := LoadFunction('ASN1_item_digest', AFailed);
  ASN1_item_verify := LoadFunction('ASN1_item_verify', AFailed);
  ASN1_item_sign := LoadFunction('ASN1_item_sign', AFailed);
  ASN1_item_sign_ctx := LoadFunction('ASN1_item_sign_ctx', AFailed);
  X509_get_version := LoadFunction('X509_get_version', AFailed);
  X509_set_version := LoadFunction('X509_set_version', AFailed);
  X509_set_serialNumber := LoadFunction('X509_set_serialNumber', AFailed);
  X509_get_serialNumber := LoadFunction('X509_get_serialNumber', AFailed);
  X509_get0_serialNumber := LoadFunction('X509_get0_serialNumber', AFailed);
  X509_set_issuer_name := LoadFunction('X509_set_issuer_name', AFailed);
  X509_get_issuer_name := LoadFunction('X509_get_issuer_name', AFailed);
  X509_set_subject_name := LoadFunction('X509_set_subject_name', AFailed);
  X509_get_subject_name := LoadFunction('X509_get_subject_name', AFailed);
  X509_get0_notBefore := LoadFunction('X509_get0_notBefore', AFailed);
  X509_getm_notBefore := LoadFunction('X509_getm_notBefore', AFailed);
  X509_set1_notBefore := LoadFunction('X509_set1_notBefore', AFailed);
  X509_get0_notAfter := LoadFunction('X509_get0_notAfter', AFailed);
  X509_getm_notAfter := LoadFunction('X509_getm_notAfter', AFailed);
  X509_set1_notAfter := LoadFunction('X509_set1_notAfter', AFailed);
  X509_set_pubkey := LoadFunction('X509_set_pubkey', AFailed);
  X509_up_ref := LoadFunction('X509_up_ref', AFailed);
  X509_get_signature_type := LoadFunction('X509_get_signature_type', AFailed);
  X509_get_X509_PUBKEY := LoadFunction('X509_get_X509_PUBKEY', AFailed);
  X509_get0_uids := LoadFunction('X509_get0_uids', AFailed);
  X509_get0_tbs_sigalg := LoadFunction('X509_get0_tbs_sigalg', AFailed);
  X509_get0_pubkey := LoadFunction('X509_get0_pubkey', AFailed);
  X509_get_pubkey := LoadFunction('X509_get_pubkey', AFailed);
  X509_get0_pubkey_bitstr := LoadFunction('X509_get0_pubkey_bitstr', AFailed);
  X509_certificate_type := LoadFunction('X509_certificate_type', AFailed);
  X509_REQ_get_version := LoadFunction('X509_REQ_get_version', AFailed);
  X509_REQ_set_version := LoadFunction('X509_REQ_set_version', AFailed);
  X509_REQ_get_subject_name := LoadFunction('X509_REQ_get_subject_name', AFailed);
  X509_REQ_set_subject_name := LoadFunction('X509_REQ_set_subject_name', AFailed);
  X509_REQ_get0_signature := LoadFunction('X509_REQ_get0_signature', AFailed);
  X509_REQ_get_signature_nid := LoadFunction('X509_REQ_get_signature_nid', AFailed);
  i2d_re_X509_REQ_tbs := LoadFunction('i2d_re_X509_REQ_tbs', AFailed);
  X509_REQ_set_pubkey := LoadFunction('X509_REQ_set_pubkey', AFailed);
  X509_REQ_get_pubkey := LoadFunction('X509_REQ_get_pubkey', AFailed);
  X509_REQ_get0_pubkey := LoadFunction('X509_REQ_get0_pubkey', AFailed);
  X509_REQ_get_X509_PUBKEY := LoadFunction('X509_REQ_get_X509_PUBKEY', AFailed);
  X509_REQ_extension_nid := LoadFunction('X509_REQ_extension_nid', AFailed);
  X509_REQ_get_extension_nids := LoadFunction('X509_REQ_get_extension_nids', AFailed);
  X509_REQ_set_extension_nids := LoadFunction('X509_REQ_set_extension_nids', AFailed);
  X509_REQ_get_attr_count := LoadFunction('X509_REQ_get_attr_count', AFailed);
  X509_REQ_get_attr_by_NID := LoadFunction('X509_REQ_get_attr_by_NID', AFailed);
  X509_REQ_get_attr_by_OBJ := LoadFunction('X509_REQ_get_attr_by_OBJ', AFailed);
  X509_REQ_get_attr := LoadFunction('X509_REQ_get_attr', AFailed);
  X509_REQ_delete_attr := LoadFunction('X509_REQ_delete_attr', AFailed);
  X509_REQ_add1_attr := LoadFunction('X509_REQ_add1_attr', AFailed);
  X509_REQ_add1_attr_by_OBJ := LoadFunction('X509_REQ_add1_attr_by_OBJ', AFailed);
  X509_REQ_add1_attr_by_NID := LoadFunction('X509_REQ_add1_attr_by_NID', AFailed);
  X509_REQ_add1_attr_by_txt := LoadFunction('X509_REQ_add1_attr_by_txt', AFailed);
  X509_CRL_set_version := LoadFunction('X509_CRL_set_version', AFailed);
  X509_CRL_set_issuer_name := LoadFunction('X509_CRL_set_issuer_name', AFailed);
  X509_CRL_set1_lastUpdate := LoadFunction('X509_CRL_set1_lastUpdate', AFailed);
  X509_CRL_set1_nextUpdate := LoadFunction('X509_CRL_set1_nextUpdate', AFailed);
  X509_CRL_sort := LoadFunction('X509_CRL_sort', AFailed);
  X509_CRL_up_ref := LoadFunction('X509_CRL_up_ref', AFailed);
  X509_CRL_get_version := LoadFunction('X509_CRL_get_version', AFailed);
  X509_CRL_get0_lastUpdate := LoadFunction('X509_CRL_get0_lastUpdate', AFailed);
  X509_CRL_get0_nextUpdate := LoadFunction('X509_CRL_get0_nextUpdate', AFailed);
  X509_CRL_get_issuer := LoadFunction('X509_CRL_get_issuer', AFailed);
  X509_CRL_get0_signature := LoadFunction('X509_CRL_get0_signature', AFailed);
  X509_CRL_get_signature_nid := LoadFunction('X509_CRL_get_signature_nid', AFailed);
  i2d_re_X509_CRL_tbs := LoadFunction('i2d_re_X509_CRL_tbs', AFailed);
  X509_REVOKED_get0_serialNumber := LoadFunction('X509_REVOKED_get0_serialNumber', AFailed);
  X509_REVOKED_set_serialNumber := LoadFunction('X509_REVOKED_set_serialNumber', AFailed);
  X509_REVOKED_get0_revocationDate := LoadFunction('X509_REVOKED_get0_revocationDate', AFailed);
  X509_REVOKED_set_revocationDate := LoadFunction('X509_REVOKED_set_revocationDate', AFailed);
  X509_CRL_diff := LoadFunction('X509_CRL_diff', AFailed);
  X509_REQ_check_private_key := LoadFunction('X509_REQ_check_private_key', AFailed);
  X509_check_private_key := LoadFunction('X509_check_private_key', AFailed);
  X509_CRL_check_suiteb := LoadFunction('X509_CRL_check_suiteb', AFailed);
  X509_issuer_and_serial_cmp := LoadFunction('X509_issuer_and_serial_cmp', AFailed);
  X509_issuer_and_serial_hash := LoadFunction('X509_issuer_and_serial_hash', AFailed);
  X509_issuer_name_cmp := LoadFunction('X509_issuer_name_cmp', AFailed);
  X509_issuer_name_hash := LoadFunction('X509_issuer_name_hash', AFailed);
  X509_subject_name_cmp := LoadFunction('X509_subject_name_cmp', AFailed);
  X509_subject_name_hash := LoadFunction('X509_subject_name_hash', AFailed);
  X509_cmp := LoadFunction('X509_cmp', AFailed);
  X509_NAME_cmp := LoadFunction('X509_NAME_cmp', AFailed);
  X509_NAME_hash := LoadFunction('X509_NAME_hash', AFailed);
  X509_NAME_hash_old := LoadFunction('X509_NAME_hash_old', AFailed);
  X509_CRL_cmp := LoadFunction('X509_CRL_cmp', AFailed);
  X509_CRL_match := LoadFunction('X509_CRL_match', AFailed);
  X509_aux_print := LoadFunction('X509_aux_print', AFailed);
  X509_NAME_print := LoadFunction('X509_NAME_print', AFailed);
  X509_NAME_print_ex := LoadFunction('X509_NAME_print_ex', AFailed);
  X509_print_ex := LoadFunction('X509_print_ex', AFailed);
  X509_print := LoadFunction('X509_print', AFailed);
  X509_ocspid_print := LoadFunction('X509_ocspid_print', AFailed);
  X509_CRL_print_ex := LoadFunction('X509_CRL_print_ex', AFailed);
  X509_CRL_print := LoadFunction('X509_CRL_print', AFailed);
  X509_REQ_print_ex := LoadFunction('X509_REQ_print_ex', AFailed);
  X509_REQ_print := LoadFunction('X509_REQ_print', AFailed);
  X509_NAME_entry_count := LoadFunction('X509_NAME_entry_count', AFailed);
  X509_NAME_get_text_by_NID := LoadFunction('X509_NAME_get_text_by_NID', AFailed);
  X509_NAME_get_text_by_OBJ := LoadFunction('X509_NAME_get_text_by_OBJ', AFailed);
  X509_NAME_get_index_by_NID := LoadFunction('X509_NAME_get_index_by_NID', AFailed);
  X509_NAME_get_index_by_OBJ := LoadFunction('X509_NAME_get_index_by_OBJ', AFailed);
  X509_NAME_get_entry := LoadFunction('X509_NAME_get_entry', AFailed);
  X509_NAME_delete_entry := LoadFunction('X509_NAME_delete_entry', AFailed);
  X509_NAME_add_entry := LoadFunction('X509_NAME_add_entry', AFailed);
  X509_NAME_add_entry_by_OBJ := LoadFunction('X509_NAME_add_entry_by_OBJ', AFailed);
  X509_NAME_add_entry_by_NID := LoadFunction('X509_NAME_add_entry_by_NID', AFailed);
  X509_NAME_ENTRY_create_by_txt := LoadFunction('X509_NAME_ENTRY_create_by_txt', AFailed);
  X509_NAME_ENTRY_create_by_NID := LoadFunction('X509_NAME_ENTRY_create_by_NID', AFailed);
  X509_NAME_add_entry_by_txt := LoadFunction('X509_NAME_add_entry_by_txt', AFailed);
  X509_NAME_ENTRY_create_by_OBJ := LoadFunction('X509_NAME_ENTRY_create_by_OBJ', AFailed);
  X509_NAME_ENTRY_set_object := LoadFunction('X509_NAME_ENTRY_set_object', AFailed);
  X509_NAME_ENTRY_set_data := LoadFunction('X509_NAME_ENTRY_set_data', AFailed);
  X509_NAME_ENTRY_get_object := LoadFunction('X509_NAME_ENTRY_get_object', AFailed);
  X509_NAME_ENTRY_get_data := LoadFunction('X509_NAME_ENTRY_get_data', AFailed);
  X509_NAME_ENTRY_set := LoadFunction('X509_NAME_ENTRY_set', AFailed);
  X509_NAME_get0_der := LoadFunction('X509_NAME_get0_der', AFailed);
  X509_get_ext_count := LoadFunction('X509_get_ext_count', AFailed);
  X509_get_ext_by_NID := LoadFunction('X509_get_ext_by_NID', AFailed);
  X509_get_ext_by_OBJ := LoadFunction('X509_get_ext_by_OBJ', AFailed);
  X509_get_ext_by_critical := LoadFunction('X509_get_ext_by_critical', AFailed);
  X509_get_ext := LoadFunction('X509_get_ext', AFailed);
  X509_delete_ext := LoadFunction('X509_delete_ext', AFailed);
  X509_add_ext := LoadFunction('X509_add_ext', AFailed);
  X509_get_ext_d2i := LoadFunction('X509_get_ext_d2i', AFailed);
  X509_add1_ext_i2d := LoadFunction('X509_add1_ext_i2d', AFailed);
  X509_CRL_get_ext_count := LoadFunction('X509_CRL_get_ext_count', AFailed);
  X509_CRL_get_ext_by_NID := LoadFunction('X509_CRL_get_ext_by_NID', AFailed);
  X509_CRL_get_ext_by_OBJ := LoadFunction('X509_CRL_get_ext_by_OBJ', AFailed);
  X509_CRL_get_ext_by_critical := LoadFunction('X509_CRL_get_ext_by_critical', AFailed);
  X509_CRL_get_ext := LoadFunction('X509_CRL_get_ext', AFailed);
  X509_CRL_delete_ext := LoadFunction('X509_CRL_delete_ext', AFailed);
  X509_CRL_add_ext := LoadFunction('X509_CRL_add_ext', AFailed);
  X509_CRL_get_ext_d2i := LoadFunction('X509_CRL_get_ext_d2i', AFailed);
  X509_CRL_add1_ext_i2d := LoadFunction('X509_CRL_add1_ext_i2d', AFailed);
  X509_REVOKED_get_ext_count := LoadFunction('X509_REVOKED_get_ext_count', AFailed);
  X509_REVOKED_get_ext_by_NID := LoadFunction('X509_REVOKED_get_ext_by_NID', AFailed);
  X509_REVOKED_get_ext_by_OBJ := LoadFunction('X509_REVOKED_get_ext_by_OBJ', AFailed);
  X509_REVOKED_get_ext_by_critical := LoadFunction('X509_REVOKED_get_ext_by_critical', AFailed);
  X509_REVOKED_get_ext := LoadFunction('X509_REVOKED_get_ext', AFailed);
  X509_REVOKED_delete_ext := LoadFunction('X509_REVOKED_delete_ext', AFailed);
  X509_REVOKED_add_ext := LoadFunction('X509_REVOKED_add_ext', AFailed);
  X509_REVOKED_get_ext_d2i := LoadFunction('X509_REVOKED_get_ext_d2i', AFailed);
  X509_REVOKED_add1_ext_i2d := LoadFunction('X509_REVOKED_add1_ext_i2d', AFailed);
  X509_EXTENSION_create_by_NID := LoadFunction('X509_EXTENSION_create_by_NID', AFailed);
  X509_EXTENSION_create_by_OBJ := LoadFunction('X509_EXTENSION_create_by_OBJ', AFailed);
  X509_EXTENSION_set_object := LoadFunction('X509_EXTENSION_set_object', AFailed);
  X509_EXTENSION_set_critical := LoadFunction('X509_EXTENSION_set_critical', AFailed);
  X509_EXTENSION_set_data := LoadFunction('X509_EXTENSION_set_data', AFailed);
  X509_EXTENSION_get_object := LoadFunction('X509_EXTENSION_get_object', AFailed);
  X509_EXTENSION_get_data := LoadFunction('X509_EXTENSION_get_data', AFailed);
  X509_EXTENSION_get_critical := LoadFunction('X509_EXTENSION_get_critical', AFailed);
  X509_ATTRIBUTE_create_by_NID := LoadFunction('X509_ATTRIBUTE_create_by_NID', AFailed);
  X509_ATTRIBUTE_create_by_OBJ := LoadFunction('X509_ATTRIBUTE_create_by_OBJ', AFailed);
  X509_ATTRIBUTE_create_by_txt := LoadFunction('X509_ATTRIBUTE_create_by_txt', AFailed);
  X509_ATTRIBUTE_set1_object := LoadFunction('X509_ATTRIBUTE_set1_object', AFailed);
  X509_ATTRIBUTE_set1_data := LoadFunction('X509_ATTRIBUTE_set1_data', AFailed);
  X509_ATTRIBUTE_get0_data := LoadFunction('X509_ATTRIBUTE_get0_data', AFailed);
  X509_ATTRIBUTE_count := LoadFunction('X509_ATTRIBUTE_count', AFailed);
  X509_ATTRIBUTE_get0_object := LoadFunction('X509_ATTRIBUTE_get0_object', AFailed);
  X509_ATTRIBUTE_get0_type := LoadFunction('X509_ATTRIBUTE_get0_type', AFailed);
  EVP_PKEY_get_attr_count := LoadFunction('EVP_PKEY_get_attr_count', AFailed);
  EVP_PKEY_get_attr_by_NID := LoadFunction('EVP_PKEY_get_attr_by_NID', AFailed);
  EVP_PKEY_get_attr_by_OBJ := LoadFunction('EVP_PKEY_get_attr_by_OBJ', AFailed);
  EVP_PKEY_get_attr := LoadFunction('EVP_PKEY_get_attr', AFailed);
  EVP_PKEY_delete_attr := LoadFunction('EVP_PKEY_delete_attr', AFailed);
  EVP_PKEY_add1_attr := LoadFunction('EVP_PKEY_add1_attr', AFailed);
  EVP_PKEY_add1_attr_by_OBJ := LoadFunction('EVP_PKEY_add1_attr_by_OBJ', AFailed);
  EVP_PKEY_add1_attr_by_NID := LoadFunction('EVP_PKEY_add1_attr_by_NID', AFailed);
  EVP_PKEY_add1_attr_by_txt := LoadFunction('EVP_PKEY_add1_attr_by_txt', AFailed);
  X509_verify_cert := LoadFunction('X509_verify_cert', AFailed);
  PKCS5_pbe_set0_algor := LoadFunction('PKCS5_pbe_set0_algor', AFailed);
  PKCS5_pbe_set := LoadFunction('PKCS5_pbe_set', AFailed);
  PKCS5_pbe2_set := LoadFunction('PKCS5_pbe2_set', AFailed);
  PKCS5_pbe2_set_iv := LoadFunction('PKCS5_pbe2_set_iv', AFailed);
  PKCS5_pbe2_set_scrypt := LoadFunction('PKCS5_pbe2_set_scrypt', AFailed);
  PKCS5_pbkdf2_set := LoadFunction('PKCS5_pbkdf2_set', AFailed);
  EVP_PKCS82PKEY := LoadFunction('EVP_PKCS82PKEY', AFailed);
  EVP_PKEY2PKCS8 := LoadFunction('EVP_PKEY2PKCS8', AFailed);
  PKCS8_pkey_set0 := LoadFunction('PKCS8_pkey_set0', AFailed);
  PKCS8_pkey_get0 := LoadFunction('PKCS8_pkey_get0', AFailed);
  PKCS8_pkey_add1_attr_by_NID := LoadFunction('PKCS8_pkey_add1_attr_by_NID', AFailed);
  X509_PUBKEY_set0_param := LoadFunction('X509_PUBKEY_set0_param', AFailed);
  X509_PUBKEY_get0_param := LoadFunction('X509_PUBKEY_get0_param', AFailed);
  X509_check_trust := LoadFunction('X509_check_trust', AFailed);
  X509_TRUST_get_count := LoadFunction('X509_TRUST_get_count', AFailed);
  X509_TRUST_get0 := LoadFunction('X509_TRUST_get0', AFailed);
  X509_TRUST_get_by_id := LoadFunction('X509_TRUST_get_by_id', AFailed);
  X509_TRUST_cleanup := LoadFunction('X509_TRUST_cleanup', AFailed);
  X509_TRUST_get_flags := LoadFunction('X509_TRUST_get_flags', AFailed);
  X509_TRUST_get0_name := LoadFunction('X509_TRUST_get0_name', AFailed);
  X509_TRUST_get_trust := LoadFunction('X509_TRUST_get_trust', AFailed);
end;

procedure UnLoad;
begin
  X509_CRL_set_default_method := nil;
  X509_CRL_METHOD_free := nil;
  X509_CRL_set_meth_data := nil;
  X509_CRL_get_meth_data := nil;
  X509_verify_cert_error_string := nil;
  X509_verify := nil;
  X509_REQ_verify := nil;
  X509_CRL_verify := nil;
  NETSCAPE_SPKI_verify := nil;
  NETSCAPE_SPKI_b64_decode := nil;
  NETSCAPE_SPKI_b64_encode := nil;
  NETSCAPE_SPKI_get_pubkey := nil;
  NETSCAPE_SPKI_set_pubkey := nil;
  NETSCAPE_SPKI_print := nil;
  X509_signature_dump := nil;
  X509_signature_print := nil;
  X509_sign := nil;
  X509_sign_ctx := nil;
  X509_http_nbio := nil;
  X509_REQ_sign := nil;
  X509_REQ_sign_ctx := nil;
  X509_CRL_sign := nil;
  X509_CRL_sign_ctx := nil;
  X509_CRL_http_nbio := nil;
  NETSCAPE_SPKI_sign := nil;
  X509_pubkey_digest := nil;
  X509_digest := nil;
  X509_CRL_digest := nil;
  X509_REQ_digest := nil;
  X509_NAME_digest := nil;
  d2i_X509_bio := nil;
  i2d_X509_bio := nil;
  d2i_X509_CRL_bio := nil;
  i2d_X509_CRL_bio := nil;
  d2i_X509_REQ_bio := nil;
  i2d_X509_REQ_bio := nil;
  d2i_RSAPrivateKey_bio := nil;
  i2d_RSAPrivateKey_bio := nil;
  d2i_RSAPublicKey_bio := nil;
  i2d_RSAPublicKey_bio := nil;
  d2i_RSA_PUBKEY_bio := nil;
  i2d_RSA_PUBKEY_bio := nil;
  d2i_DSA_PUBKEY_bio := nil;
  i2d_DSA_PUBKEY_bio := nil;
  d2i_DSAPrivateKey_bio := nil;
  i2d_DSAPrivateKey_bio := nil;
  d2i_EC_PUBKEY_bio := nil;
  i2d_EC_PUBKEY_bio := nil;
  d2i_ECPrivateKey_bio := nil;
  i2d_ECPrivateKey_bio := nil;
  d2i_PKCS8_bio := nil;
  i2d_PKCS8_bio := nil;
  d2i_PKCS8_PRIV_KEY_INFO_bio := nil;
  i2d_PKCS8_PRIV_KEY_INFO_bio := nil;
  i2d_PKCS8PrivateKeyInfo_bio := nil;
  i2d_PrivateKey_bio := nil;
  d2i_PrivateKey_bio := nil;
  i2d_PUBKEY_bio := nil;
  d2i_PUBKEY_bio := nil;
  X509_dup := nil;
  X509_ATTRIBUTE_dup := nil;
  X509_EXTENSION_dup := nil;
  X509_CRL_dup := nil;
  X509_REVOKED_dup := nil;
  X509_REQ_dup := nil;
  X509_ALGOR_dup := nil;
  X509_ALGOR_set0 := nil;
  X509_ALGOR_get0 := nil;
  X509_ALGOR_set_md := nil;
  X509_ALGOR_cmp := nil;
  X509_NAME_dup := nil;
  X509_NAME_ENTRY_dup := nil;
  X509_cmp_time := nil;
  X509_cmp_current_time := nil;
  X509_time_adj := nil;
  X509_time_adj_ex := nil;
  X509_gmtime_adj := nil;
  X509_get_default_cert_area := nil;
  X509_get_default_cert_dir := nil;
  X509_get_default_cert_file := nil;
  X509_get_default_cert_dir_env := nil;
  X509_get_default_cert_file_env := nil;
  X509_get_default_private_dir := nil;
  X509_to_X509_REQ := nil;
  X509_REQ_to_X509 := nil;
  X509_ALGOR_new := nil;
  X509_ALGOR_free := nil;
  d2i_X509_ALGOR := nil;
  i2d_X509_ALGOR := nil;
  X509_VAL_new := nil;
  X509_VAL_free := nil;
  d2i_X509_VAL := nil;
  i2d_X509_VAL := nil;
  X509_PUBKEY_new := nil;
  X509_PUBKEY_free := nil;
  d2i_X509_PUBKEY := nil;
  i2d_X509_PUBKEY := nil;
  X509_PUBKEY_set := nil;
  X509_PUBKEY_get0 := nil;
  X509_PUBKEY_get := nil;
  X509_get_pathlen := nil;
  i2d_PUBKEY := nil;
  d2i_PUBKEY := nil;
  i2d_RSA_PUBKEY := nil;
  d2i_RSA_PUBKEY := nil;
  i2d_DSA_PUBKEY := nil;
  d2i_DSA_PUBKEY := nil;
  i2d_EC_PUBKEY := nil;
  d2i_EC_PUBKEY := nil;
  X509_SIG_new := nil;
  X509_SIG_free := nil;
  d2i_X509_SIG := nil;
  i2d_X509_SIG := nil;
  X509_SIG_get0 := nil;
  X509_SIG_getm := nil;
  X509_REQ_INFO_new := nil;
  X509_REQ_INFO_free := nil;
  d2i_X509_REQ_INFO := nil;
  i2d_X509_REQ_INFO := nil;
  X509_REQ_new := nil;
  X509_REQ_free := nil;
  d2i_X509_REQ := nil;
  i2d_X509_REQ := nil;
  X509_ATTRIBUTE_new := nil;
  X509_ATTRIBUTE_free := nil;
  d2i_X509_ATTRIBUTE := nil;
  i2d_X509_ATTRIBUTE := nil;
  X509_ATTRIBUTE_create := nil;
  X509_EXTENSION_new := nil;
  X509_EXTENSION_free := nil;
  d2i_X509_EXTENSION := nil;
  i2d_X509_EXTENSION := nil;
  X509_NAME_ENTRY_new := nil;
  X509_NAME_ENTRY_free := nil;
  d2i_X509_NAME_ENTRY := nil;
  i2d_X509_NAME_ENTRY := nil;
  X509_NAME_new := nil;
  X509_NAME_free := nil;
  d2i_X509_NAME := nil;
  i2d_X509_NAME := nil;
  X509_NAME_set := nil;
  X509_new := nil;
  X509_free := nil;
  d2i_X509 := nil;
  i2d_X509 := nil;
  X509_set_ex_data := nil;
  X509_get_ex_data := nil;
  i2d_X509_AUX := nil;
  d2i_X509_AUX := nil;
  i2d_re_X509_tbs := nil;
  X509_SIG_INFO_get := nil;
  X509_SIG_INFO_set := nil;
  X509_get_signature_info := nil;
  X509_get0_signature := nil;
  X509_get_signature_nid := nil;
  X509_trusted := nil;
  X509_alias_set1 := nil;
  X509_keyid_set1 := nil;
  X509_alias_get0 := nil;
  X509_keyid_get0 := nil;
  X509_TRUST_set := nil;
  X509_add1_trust_object := nil;
  X509_add1_reject_object := nil;
  X509_trust_clear := nil;
  X509_reject_clear := nil;
  X509_REVOKED_new := nil;
  X509_REVOKED_free := nil;
  d2i_X509_REVOKED := nil;
  i2d_X509_REVOKED := nil;
  X509_CRL_INFO_new := nil;
  X509_CRL_INFO_free := nil;
  d2i_X509_CRL_INFO := nil;
  i2d_X509_CRL_INFO := nil;
  X509_CRL_new := nil;
  X509_CRL_free := nil;
  d2i_X509_CRL := nil;
  i2d_X509_CRL := nil;
  X509_CRL_add0_revoked := nil;
  X509_CRL_get0_by_serial := nil;
  X509_CRL_get0_by_cert := nil;
  X509_PKEY_new := nil;
  X509_PKEY_free := nil;
  X509_INFO_new := nil;
  X509_INFO_free := nil;
  X509_NAME_oneline := nil;
  ASN1_item_digest := nil;
  ASN1_item_verify := nil;
  ASN1_item_sign := nil;
  ASN1_item_sign_ctx := nil;
  X509_get_version := nil;
  X509_set_version := nil;
  X509_set_serialNumber := nil;
  X509_get_serialNumber := nil;
  X509_get0_serialNumber := nil;
  X509_set_issuer_name := nil;
  X509_get_issuer_name := nil;
  X509_set_subject_name := nil;
  X509_get_subject_name := nil;
  X509_get0_notBefore := nil;
  X509_getm_notBefore := nil;
  X509_set1_notBefore := nil;
  X509_get0_notAfter := nil;
  X509_getm_notAfter := nil;
  X509_set1_notAfter := nil;
  X509_set_pubkey := nil;
  X509_up_ref := nil;
  X509_get_signature_type := nil;
  X509_get_X509_PUBKEY := nil;
  X509_get0_uids := nil;
  X509_get0_tbs_sigalg := nil;
  X509_get0_pubkey := nil;
  X509_get_pubkey := nil;
  X509_get0_pubkey_bitstr := nil;
  X509_certificate_type := nil;
  X509_REQ_get_version := nil;
  X509_REQ_set_version := nil;
  X509_REQ_get_subject_name := nil;
  X509_REQ_set_subject_name := nil;
  X509_REQ_get0_signature := nil;
  X509_REQ_get_signature_nid := nil;
  i2d_re_X509_REQ_tbs := nil;
  X509_REQ_set_pubkey := nil;
  X509_REQ_get_pubkey := nil;
  X509_REQ_get0_pubkey := nil;
  X509_REQ_get_X509_PUBKEY := nil;
  X509_REQ_extension_nid := nil;
  X509_REQ_get_extension_nids := nil;
  X509_REQ_set_extension_nids := nil;
  X509_REQ_get_attr_count := nil;
  X509_REQ_get_attr_by_NID := nil;
  X509_REQ_get_attr_by_OBJ := nil;
  X509_REQ_get_attr := nil;
  X509_REQ_delete_attr := nil;
  X509_REQ_add1_attr := nil;
  X509_REQ_add1_attr_by_OBJ := nil;
  X509_REQ_add1_attr_by_NID := nil;
  X509_REQ_add1_attr_by_txt := nil;
  X509_CRL_set_version := nil;
  X509_CRL_set_issuer_name := nil;
  X509_CRL_set1_lastUpdate := nil;
  X509_CRL_set1_nextUpdate := nil;
  X509_CRL_sort := nil;
  X509_CRL_up_ref := nil;
  X509_CRL_get_version := nil;
  X509_CRL_get0_lastUpdate := nil;
  X509_CRL_get0_nextUpdate := nil;
  X509_CRL_get_issuer := nil;
  X509_CRL_get0_signature := nil;
  X509_CRL_get_signature_nid := nil;
  i2d_re_X509_CRL_tbs := nil;
  X509_REVOKED_get0_serialNumber := nil;
  X509_REVOKED_set_serialNumber := nil;
  X509_REVOKED_get0_revocationDate := nil;
  X509_REVOKED_set_revocationDate := nil;
  X509_CRL_diff := nil;
  X509_REQ_check_private_key := nil;
  X509_check_private_key := nil;
  X509_CRL_check_suiteb := nil;
  X509_issuer_and_serial_cmp := nil;
  X509_issuer_and_serial_hash := nil;
  X509_issuer_name_cmp := nil;
  X509_issuer_name_hash := nil;
  X509_subject_name_cmp := nil;
  X509_subject_name_hash := nil;
  X509_cmp := nil;
  X509_NAME_cmp := nil;
  X509_NAME_hash := nil;
  X509_NAME_hash_old := nil;
  X509_CRL_cmp := nil;
  X509_CRL_match := nil;
  X509_aux_print := nil;
  X509_NAME_print := nil;
  X509_NAME_print_ex := nil;
  X509_print_ex := nil;
  X509_print := nil;
  X509_ocspid_print := nil;
  X509_CRL_print_ex := nil;
  X509_CRL_print := nil;
  X509_REQ_print_ex := nil;
  X509_REQ_print := nil;
  X509_NAME_entry_count := nil;
  X509_NAME_get_text_by_NID := nil;
  X509_NAME_get_text_by_OBJ := nil;
  X509_NAME_get_index_by_NID := nil;
  X509_NAME_get_index_by_OBJ := nil;
  X509_NAME_get_entry := nil;
  X509_NAME_delete_entry := nil;
  X509_NAME_add_entry := nil;
  X509_NAME_add_entry_by_OBJ := nil;
  X509_NAME_add_entry_by_NID := nil;
  X509_NAME_ENTRY_create_by_txt := nil;
  X509_NAME_ENTRY_create_by_NID := nil;
  X509_NAME_add_entry_by_txt := nil;
  X509_NAME_ENTRY_create_by_OBJ := nil;
  X509_NAME_ENTRY_set_object := nil;
  X509_NAME_ENTRY_set_data := nil;
  X509_NAME_ENTRY_get_object := nil;
  X509_NAME_ENTRY_get_data := nil;
  X509_NAME_ENTRY_set := nil;
  X509_NAME_get0_der := nil;
  X509_get_ext_count := nil;
  X509_get_ext_by_NID := nil;
  X509_get_ext_by_OBJ := nil;
  X509_get_ext_by_critical := nil;
  X509_get_ext := nil;
  X509_delete_ext := nil;
  X509_add_ext := nil;
  X509_get_ext_d2i := nil;
  X509_add1_ext_i2d := nil;
  X509_CRL_get_ext_count := nil;
  X509_CRL_get_ext_by_NID := nil;
  X509_CRL_get_ext_by_OBJ := nil;
  X509_CRL_get_ext_by_critical := nil;
  X509_CRL_get_ext := nil;
  X509_CRL_delete_ext := nil;
  X509_CRL_add_ext := nil;
  X509_CRL_get_ext_d2i := nil;
  X509_CRL_add1_ext_i2d := nil;
  X509_REVOKED_get_ext_count := nil;
  X509_REVOKED_get_ext_by_NID := nil;
  X509_REVOKED_get_ext_by_OBJ := nil;
  X509_REVOKED_get_ext_by_critical := nil;
  X509_REVOKED_get_ext := nil;
  X509_REVOKED_delete_ext := nil;
  X509_REVOKED_add_ext := nil;
  X509_REVOKED_get_ext_d2i := nil;
  X509_REVOKED_add1_ext_i2d := nil;
  X509_EXTENSION_create_by_NID := nil;
  X509_EXTENSION_create_by_OBJ := nil;
  X509_EXTENSION_set_object := nil;
  X509_EXTENSION_set_critical := nil;
  X509_EXTENSION_set_data := nil;
  X509_EXTENSION_get_object := nil;
  X509_EXTENSION_get_data := nil;
  X509_EXTENSION_get_critical := nil;
  X509_ATTRIBUTE_create_by_NID := nil;
  X509_ATTRIBUTE_create_by_OBJ := nil;
  X509_ATTRIBUTE_create_by_txt := nil;
  X509_ATTRIBUTE_set1_object := nil;
  X509_ATTRIBUTE_set1_data := nil;
  X509_ATTRIBUTE_get0_data := nil;
  X509_ATTRIBUTE_count := nil;
  X509_ATTRIBUTE_get0_object := nil;
  X509_ATTRIBUTE_get0_type := nil;
  EVP_PKEY_get_attr_count := nil;
  EVP_PKEY_get_attr_by_NID := nil;
  EVP_PKEY_get_attr_by_OBJ := nil;
  EVP_PKEY_get_attr := nil;
  EVP_PKEY_delete_attr := nil;
  EVP_PKEY_add1_attr := nil;
  EVP_PKEY_add1_attr_by_OBJ := nil;
  EVP_PKEY_add1_attr_by_NID := nil;
  EVP_PKEY_add1_attr_by_txt := nil;
  X509_verify_cert := nil;
  PKCS5_pbe_set0_algor := nil;
  PKCS5_pbe_set := nil;
  PKCS5_pbe2_set := nil;
  PKCS5_pbe2_set_iv := nil;
  PKCS5_pbe2_set_scrypt := nil;
  PKCS5_pbkdf2_set := nil;
  EVP_PKCS82PKEY := nil;
  EVP_PKEY2PKCS8 := nil;
  PKCS8_pkey_set0 := nil;
  PKCS8_pkey_get0 := nil;
  PKCS8_pkey_add1_attr_by_NID := nil;
  X509_PUBKEY_set0_param := nil;
  X509_PUBKEY_get0_param := nil;
  X509_check_trust := nil;
  X509_TRUST_get_count := nil;
  X509_TRUST_get0 := nil;
  X509_TRUST_get_by_id := nil;
  X509_TRUST_cleanup := nil;
  X509_TRUST_get_flags := nil;
  X509_TRUST_get0_name := nil;
  X509_TRUST_get_trust := nil;
end;

end.
