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

unit IdOpenSSLHeaders_x509;

interface

// Headers for OpenSSL 1.1.1
// x509.h

{$i IdCompilerDefines.inc}

uses
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

  procedure X509_CRL_set_default_method(const meth: PX509_CRL_METHOD) cdecl; external CLibCrypto;
//  function X509_CRL_METHOD_new(crl_init: function(crl: X509_CRL): TIdC_INT;
//    crl_free: function(crl: PX509_CRL): TIdC_INT;
//    crl_lookup: function(crl: PX509_CRL; ret: PPX509_REVOKED; ser: PASN1_INTEGER; issuer: PX509_NAME): TIdC_INT;
//    crl_verify: function(crl: PX509_CRL, pk: PEVP_PKEY): TIdC_INT): PX509_CRL_METHOD;
  procedure X509_CRL_METHOD_free(m: PX509_CRL_METHOD) cdecl; external CLibCrypto;

  procedure X509_CRL_set_meth_data(crl: PX509_CRL; dat: Pointer) cdecl; external CLibCrypto;
  function X509_CRL_get_meth_data(crl: PX509_CRL): Pointer cdecl; external CLibCrypto;

  function X509_verify_cert_error_string(n: TIdC_LONG): PIdAnsiChar cdecl; external CLibCrypto;

  function X509_verify(a: PX509; r: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function X509_REQ_verify(a: PX509_REQ; r: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_verify(a: PX509_CRL; r: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function NETSCAPE_SPKI_verify(a: PNETSCAPE_SPKI; r: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function NETSCAPE_SPKI_b64_decode(const str: PIdAnsiChar; len: TIdC_INT): PNETSCAPE_SPKI cdecl; external CLibCrypto;
  function NETSCAPE_SPKI_b64_encode(x: PNETSCAPE_SPKI): PIdAnsiChar cdecl; external CLibCrypto;
  function NETSCAPE_SPKI_get_pubkey(x: PNETSCAPE_SPKI): PEVP_PKEY cdecl; external CLibCrypto;
  function NETSCAPE_SPKI_set_pubkey(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function NETSCAPE_SPKI_print(&out: PBIO; spki: PNETSCAPE_SPKI): TIdC_INT cdecl; external CLibCrypto;

  function X509_signature_dump(bp: PBIO; const sig: PASN1_STRING; indent: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_signature_print(bp: PBIO; const alg: PX509_ALGOR; const sig: PASN1_STRING): TIdC_INT cdecl; external CLibCrypto;

  function X509_sign(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function X509_sign_ctx(x: PX509; ctx: PEVP_MD_CTX): TIdC_INT cdecl; external CLibCrypto;

  function X509_http_nbio(rctx: POCSP_REQ_CTX; pcert: PPX509): TIdC_INT cdecl; external CLibCrypto;

  function X509_REQ_sign(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_sign_ctx(x: PX509_REQ; ctx: PEVP_MD_CTX): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_sign(x: PX509_CRL; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_sign_ctx(x: PX509_CRL; ctx: PEVP_MD_CTX): TIdC_INT cdecl; external CLibCrypto;

  function X509_CRL_http_nbio(rctx: POCSP_REQ_CTX; pcrl: PPX509_CRL): TIdC_INT cdecl; external CLibCrypto;

  function NETSCAPE_SPKI_sign(x: PNETSCAPE_SPKI; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;

  function X509_pubkey_digest(const data: PX509; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function X509_digest(const data: PX509; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_digest(const data: PX509_CRL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_digest(const data: PX509_REQ; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_digest(const data: PX509_NAME; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;

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

  function d2i_X509_bio(bp: PBIO; x509: PPX509): PX509 cdecl; external CLibCrypto;
  function i2d_X509_bio(bp: PBIO; x509: PX509): TIdC_INT cdecl; external CLibCrypto;
  function d2i_X509_CRL_bio(bp: PBIO; crl: PPX509_CRL): PX509_CRL cdecl; external CLibCrypto;
  function i2d_X509_CRL_bio(bp: PBIO; crl: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function d2i_X509_REQ_bio(bp: PBIO; req: PPX509_REQ): PX509_REQ cdecl; external CLibCrypto;
  function i2d_X509_REQ_bio(bp: PBIO; req: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;

  function d2i_RSAPrivateKey_bio(bp: PBIO; rsa: PPRSA): PRSA cdecl; external CLibCrypto;
  function i2d_RSAPrivateKey_bio(bp: PBIO; rsa: PRSA): TIdC_INT cdecl; external CLibCrypto;
  function d2i_RSAPublicKey_bio(bp: PBIO; rsa: PPRSA): PRSA cdecl; external CLibCrypto;
  function i2d_RSAPublicKey_bio(bp: PBIO; rsa: PRSA): TIdC_INT cdecl; external CLibCrypto;
  function d2i_RSA_PUBKEY_bio(bp: PBIO; rsa: PPRSA): PRSA cdecl; external CLibCrypto;
  function i2d_RSA_PUBKEY_bio(bp: PBIO; rsa: PRSA): TIdC_INT cdecl; external CLibCrypto;

  function d2i_DSA_PUBKEY_bio(bp: PBIO; dsa: PPDSA): DSA cdecl; external CLibCrypto;
  function i2d_DSA_PUBKEY_bio(bp: PBIO; dsa: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function d2i_DSAPrivateKey_bio(bp: PBIO; dsa: PPDSA): PDSA cdecl; external CLibCrypto;
  function i2d_DSAPrivateKey_bio(bp: PBIO; dsa: PDSA): TIdC_INT cdecl; external CLibCrypto;

  function d2i_EC_PUBKEY_bio(bp: PBIO; eckey: PPEC_KEY): PEC_KEY cdecl; external CLibCrypto;
  function i2d_EC_PUBKEY_bio(bp: PBIO; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function d2i_ECPrivateKey_bio(bp: PBIO; eckey: PPEC_KEY): EC_KEY cdecl; external CLibCrypto;
  function i2d_ECPrivateKey_bio(bp: PBIO; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;

  function d2i_PKCS8_bio(bp: PBIO; p8: PPX509_SIG): PX509_SIG cdecl; external CLibCrypto;
  function i2d_PKCS8_bio(bp: PBIO; p8: PX509_SIG): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPPKCS8_PRIV_KEY_INFO): PPKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;
  function i2d_PKCS8_PRIV_KEY_INFO_bio(bp: PBIO; p8inf: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl; external CLibCrypto;
  function i2d_PKCS8PrivateKeyInfo_bio(bp: PBIO; key: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function i2d_PrivateKey_bio(bp: PBIO; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PrivateKey_bio(bp: PBIO; a: PPEVP_PKEY): PEVP_PKEY cdecl; external CLibCrypto;
  function i2d_PUBKEY_bio(bp: PBIO; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PUBKEY_bio(bp: PBIO; a: PPEVP_PKEY): PEVP_PKEY cdecl; external CLibCrypto;

  function X509_dup(x509: PX509): PX509 cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_dup(xa: PX509_ATTRIBUTE): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_EXTENSION_dup(ex: PX509_EXTENSION): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_CRL_dup(crl: PX509_CRL): PX509_CRL cdecl; external CLibCrypto;
  function X509_REVOKED_dup(rev: PX509_REVOKED): PX509_REVOKED cdecl; external CLibCrypto;
  function X509_REQ_dup(req: PX509_REQ): PX509_REQ cdecl; external CLibCrypto;
  function X509_ALGOR_dup(xn: PX509_ALGOR): PX509_ALGOR cdecl; external CLibCrypto;
  function X509_ALGOR_set0(alg: PX509_ALGOR; aobj: PASN1_OBJECT; ptype: TIdC_INT; pval: Pointer): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_ALGOR_get0(const paobj: PPASN1_OBJECT; pptype: PIdC_INT; const ppval: PPointer; const algor: PX509_ALGOR) cdecl; external CLibCrypto;
  procedure X509_ALGOR_set_md(alg: PX509_ALGOR; const md: PEVP_MD) cdecl; external CLibCrypto;
  function X509_ALGOR_cmp(const a: PX509_ALGOR; const b: PX509_ALGOR): TIdC_INT cdecl; external CLibCrypto;

  function X509_NAME_dup(xn: PX509_NAME): PX509_NAME cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_dup(ne: PX509_NAME_ENTRY): PX509_NAME_ENTRY cdecl; external CLibCrypto;

  function X509_cmp_time(const s: PASN1_TIME; t: PIdC_TIMET): TIdC_INT cdecl; external CLibCrypto;
  function X509_cmp_current_time(const s: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function X509_time_adj(s: PASN1_TIME; adj: TIdC_LONG; t: PIdC_TIMET): PASN1_TIME cdecl; external CLibCrypto;
  function X509_time_adj_ex(s: PASN1_TIME; offset_day: TIdC_INT; offset_sec: TIdC_LONG; t: PIdC_TIMET): PASN1_TIME cdecl; external CLibCrypto;
  function X509_gmtime_adj(s: PASN1_TIME; adj: TIdC_LONG): PASN1_TIME cdecl; external CLibCrypto;

  function X509_get_default_cert_area: PIdAnsiChar cdecl; external CLibCrypto;
  function X509_get_default_cert_dir: PIdAnsiChar cdecl; external CLibCrypto;
  function X509_get_default_cert_file: PIdAnsiChar cdecl; external CLibCrypto;
  function X509_get_default_cert_dir_env: PIdAnsiChar cdecl; external CLibCrypto;
  function X509_get_default_cert_file_env: PIdAnsiChar cdecl; external CLibCrypto;
  function X509_get_default_private_dir: PIdAnsiChar cdecl; external CLibCrypto;

  function X509_to_X509_REQ(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): PX509_REQ cdecl; external CLibCrypto;
  function X509_REQ_to_X509(r: PX509_REQ; days: TIdC_INT; pkey: PEVP_PKEY): PX509 cdecl; external CLibCrypto;

  function X509_ALGOR_new: PX509_ALGOR cdecl; external CLibCrypto;
  procedure X509_ALGOR_free(v1: PX509_ALGOR) cdecl; external CLibCrypto;
  function d2i_X509_ALGOR(a: PPX509_ALGOR; const in_: PPByte; len: TIdC_LONG): PX509_ALGOR cdecl; external CLibCrypto;
  function i2d_X509_ALGOR(a: PX509_ALGOR; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  //DECLARE_ASN1_ENCODE_FUNCTIONS(X509_ALGORS, X509_ALGORS, X509_ALGORS)
  function X509_VAL_new: PX509_VAL cdecl; external CLibCrypto;
  procedure X509_VAL_free(v1: PX509_VAL) cdecl; external CLibCrypto;
  function d2i_X509_VAL(a: PPX509_VAL; const in_: PPByte; len: TIdC_LONG): PX509_VAL cdecl; external CLibCrypto;
  function i2d_X509_VAL(a: PX509_VAL; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_PUBKEY_new: PX509_PUBKEY cdecl; external CLibCrypto;
  procedure X509_PUBKEY_free(v1: PX509_PUBKEY) cdecl; external CLibCrypto;
  function d2i_X509_PUBKEY(a: PPX509_PUBKEY; const in_: PPByte; len: TIdC_LONG): PX509_PUBKEY cdecl; external CLibCrypto;
  function i2d_X509_PUBKEY(a: PX509_PUBKEY; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_PUBKEY_set(x: PPX509_PUBKEY; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function X509_PUBKEY_get0(key: PX509_PUBKEY): PEVP_PKEY cdecl; external CLibCrypto;
  function X509_PUBKEY_get(key: PX509_PUBKEY): PEVP_PKEY cdecl; external CLibCrypto;
//  function X509_get_pubkey_parameters(pkey: PEVP_PKEY; chain: P STACK_OF(X509)): TIdC_INT;
  function X509_get_pathlen(x: PX509): TIdC_LONG cdecl; external CLibCrypto;
  function i2d_PUBKEY(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_PUBKEY(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external CLibCrypto;

  function i2d_RSA_PUBKEY(a: PRSA; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_RSA_PUBKEY(a: PPRSA; const pp: PPByte; length: TIdC_LONG): PRSA cdecl; external CLibCrypto;

  function i2d_DSA_PUBKEY(a: PDSA; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_DSA_PUBKEY(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl; external CLibCrypto;

  function i2d_EC_PUBKEY(a: EC_KEY; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_EC_PUBKEY(a: PPEC_KEY; const pp: PPByte; length: TIdC_LONG): PEC_KEY cdecl; external CLibCrypto;

  function X509_SIG_new: PX509_SIG cdecl; external CLibCrypto;
  procedure X509_SIG_free(v1: PX509_SIG) cdecl; external CLibCrypto;
  function d2i_X509_SIG(a: PPX509_SIG; const in_: PPByte; len: TIdC_LONG): PX509_SIG cdecl; external CLibCrypto;
  function i2d_X509_SIG(a: PX509_SIG; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_SIG_get0(const sig: PX509_SIG; const palg: PPX509_ALGOR; const pdigest: PPASN1_OCTET_STRING) cdecl; external CLibCrypto;
  procedure X509_SIG_getm(sig: X509_SIG; palg: PPX509_ALGOR; pdigest: PPASN1_OCTET_STRING) cdecl; external CLibCrypto;

  function X509_REQ_INFO_new: PX509_REQ_INFO cdecl; external CLibCrypto;
  procedure X509_REQ_INFO_free(v1: PX509_REQ_INFO) cdecl; external CLibCrypto;
  function d2i_X509_REQ_INFO(a: PPX509_REQ_INFO; const in_: PPByte; len: TIdC_LONG): PX509_REQ_INFO cdecl; external CLibCrypto;
  function i2d_X509_REQ_INFO(a: PX509_REQ_INFO; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_REQ_new: PX509_REQ cdecl; external CLibCrypto;
  procedure X509_REQ_free(v1: PX509_REQ) cdecl; external CLibCrypto;
  function d2i_X509_REQ(a: PPX509_REQ; const in_: PPByte; len: TIdC_LONG): PX509_REQ cdecl; external CLibCrypto;
  function i2d_X509_REQ(a: PX509_REQ; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_ATTRIBUTE_new: PX509_ATTRIBUTE cdecl; external CLibCrypto;
  procedure X509_ATTRIBUTE_free(v1: PX509_ATTRIBUTE) cdecl; external CLibCrypto;
  function d2i_X509_ATTRIBUTE(a: PPX509_ATTRIBUTE; const in_: PPByte; len: TIdC_LONG): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function i2d_X509_ATTRIBUTE(a: PX509_ATTRIBUTE; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_create(nid: TIdC_INT; trtype: TIdC_INT; value: Pointer): PX509_ATTRIBUTE cdecl; external CLibCrypto;

  function X509_EXTENSION_new: PX509_EXTENSION cdecl; external CLibCrypto;
  procedure X509_EXTENSION_free(v1: PX509_EXTENSION) cdecl; external CLibCrypto;
  function d2i_X509_EXTENSION(a: PPX509_EXTENSION; const in_: PPByte; len: TIdC_LONG): PX509_EXTENSION cdecl; external CLibCrypto;
  function i2d_X509_EXTENSION(a: PX509_EXTENSION; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  //DECLARE_ASN1_ENCODE_FUNCTIONS(X509_EXTENSIONS, X509_EXTENSIONS, X509_EXTENSIONS)

  function X509_NAME_ENTRY_new: PX509_NAME_ENTRY cdecl; external CLibCrypto;
  procedure X509_NAME_ENTRY_free(v1: PX509_NAME_ENTRY) cdecl; external CLibCrypto;
  function d2i_X509_NAME_ENTRY(a: PPX509_NAME_ENTRY; const in_: PPByte; len: TIdC_LONG): PX509_NAME_ENTRY cdecl; external CLibCrypto;
  function i2d_X509_NAME_ENTRY(a: PX509_NAME_ENTRY; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_NAME_new: PX509_NAME cdecl; external CLibCrypto;
  procedure X509_NAME_free(v1: PX509_NAME) cdecl; external CLibCrypto;
  function d2i_X509_NAME(a: PPX509_NAME; const in_: PPByte; len: TIdC_LONG): PX509_NAME cdecl; external CLibCrypto;
  function i2d_X509_NAME(a: PX509_NAME; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_NAME_set(xn: PPX509_NAME; name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;

  //DECLARE_ASN1_FUNCTIONS(X509_CINF)

  function X509_new: PX509 cdecl; external CLibCrypto;
  procedure X509_free(v1: PX509) cdecl; external CLibCrypto;
  function d2i_X509(a: PPX509; const in_: PPByte; len: TIdC_LONG): PX509 cdecl; external CLibCrypto;
  function i2d_X509(a: PX509; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  //DECLARE_ASN1_FUNCTIONS(X509_CERT_AUX)
  //
  //#define X509_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509, l, p, newf, dupf, freef)
  function X509_set_ex_data(r: PX509; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ex_data(r: PX509; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function i2d_X509_AUX(a: PX509; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_X509_AUX(a: PPX509; const pp: PPByte; length: TIdC_LONG): PX509 cdecl; external CLibCrypto;

  function i2d_re_X509_tbs(x: PX509; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_SIG_INFO_get(const siginf: PX509_SIG_INFO; mdnid: PIdC_INT; pknid: PIdC_INT; secbits: PIdC_INT; flags: PIdC_UINT32): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_SIG_INFO_set(siginf: PX509_SIG_INFO; mdnid: TIdC_INT; pknid: TIdC_INT; secbits: TIdC_INT; flags: TIdC_UINT32) cdecl; external CLibCrypto;

  function X509_get_signature_info(x: PX509; mdnid: PIdC_INT; pknid: PIdC_INT; secbits: PIdC_INT; flags: PIdC_UINT32): TIdC_INT cdecl; external CLibCrypto;

  procedure X509_get0_signature(const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR; const x: PX509) cdecl; external CLibCrypto;
  function X509_get_signature_nid(const x: PX509): TIdC_INT cdecl; external CLibCrypto;

  function X509_trusted(const x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_alias_set1(x: PX509; const name: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_keyid_set1(x: PX509; const id: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_alias_get0(x: PX509; len: PIdC_INT): PByte cdecl; external CLibCrypto;
  function X509_keyid_get0(x: PX509; len: PIdC_INT): PByte cdecl; external CLibCrypto;
//  TIdC_INT (*X509_TRUST_set_default(TIdC_INT (*trust) (TIdC_INT, X509 *, TIdC_INT))) (TIdC_INT, X509 *,
//                                                                  TIdC_INT);
  function X509_TRUST_set(t: PIdC_INT; trust: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_add1_trust_object(x: PX509; const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_add1_reject_object(x: PX509; const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_trust_clear(x: PX509) cdecl; external CLibCrypto;
  procedure X509_reject_clear(x: PX509) cdecl; external CLibCrypto;

  //STACK_OF(ASN1_OBJECT) *X509_get0_trust_objects(X509 *x);
  //STACK_OF(ASN1_OBJECT) *X509_get0_reject_objects(X509 *x);
  //
  function X509_REVOKED_new: PX509_REVOKED cdecl; external CLibCrypto;
  procedure X509_REVOKED_free(v1: PX509_REVOKED) cdecl; external CLibCrypto;
  function d2i_X509_REVOKED(a: PPX509_REVOKED; const in_: PPByte; len: TIdC_LONG): PX509_REVOKED cdecl; external CLibCrypto;
  function i2d_X509_REVOKED(a: PX509_REVOKED; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_INFO_new: PX509_CRL_INFO cdecl; external CLibCrypto;
  procedure X509_CRL_INFO_free(v1: PX509_CRL_INFO) cdecl; external CLibCrypto;
  function d2i_X509_CRL_INFO(a: PPX509_CRL_INFO; const in_: PPByte; len: TIdC_LONG): PX509_CRL_INFO cdecl; external CLibCrypto;
  function i2d_X509_CRL_INFO(a: PX509_CRL_INFO; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_new: PX509_CRL cdecl; external CLibCrypto;
  procedure X509_CRL_free(v1: PX509_CRL) cdecl; external CLibCrypto;
  function d2i_X509_CRL(a: PPX509_CRL; const in_: PPByte; len: TIdC_LONG): PX509_CRL cdecl; external CLibCrypto;
  function i2d_X509_CRL(a: PX509_CRL; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_CRL_add0_revoked(crl: PX509_CRL; rev: PX509_REVOKED): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get0_by_serial(crl: PX509_CRL; ret: PPX509_REVOKED; serial: PASN1_INTEGER): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get0_by_cert(crl: PX509_CRL; ret: PPX509_REVOKED; x: PX509): TIdC_INT cdecl; external CLibCrypto;

  function X509_PKEY_new: PX509_PKEY cdecl; external CLibCrypto;
  procedure X509_PKEY_free(a: PX509_PKEY) cdecl; external CLibCrypto;

  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_SPKI)
  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_SPKAC)
  //DECLARE_ASN1_FUNCTIONS(NETSCAPE_CERT_SEQUENCE)

  function X509_INFO_new: PX509_INFO cdecl; external CLibCrypto;
  procedure X509_INFO_free(a: PX509_INFO) cdecl; external CLibCrypto;
  function X509_NAME_oneline(const a: PX509_NAME; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;

//  function ASN1_verify(i2d: Pi2d_of_void; algor1: PX509_ALGOR;
//    signature: PASN1_BIT_STRING; data: PIdAnsiChar; pkey: PEVP_PKEY): TIdC_INT;

//  TIdC_INT ASN1_digest(i2d_of_void *i2d, const EVP_MD *type, char *data,
//                  unsigned char *md, unsigned TIdC_INT *len);

//  TIdC_INT ASN1_sign(i2d_of_void *i2d, X509_ALGOR *algor1,
//                X509_ALGOR *algor2, ASN1_BIT_STRING *signature,
//                char *data, EVP_PKEY *pkey, const EVP_MD *type);

  function ASN1_item_digest(const it: PASN1_ITEM; const type_: PEVP_MD; data: Pointer; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;

  function ASN1_item_verify(const it: PASN1_ITEM; algor1: PX509_ALGOR; signature: PASN1_BIT_STRING; data: Pointer; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function ASN1_item_sign(const it: PASN1_ITEM; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_BIT_STRING; data: Pointer; pkey: PEVP_PKEY; const type_: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function ASN1_item_sign_ctx(const it: PASN1_ITEM; algor1: PX509_ALGOR; algor2: PX509_ALGOR; signature: PASN1_BIT_STRING; asn: Pointer; ctx: PEVP_MD_CTX): TIdC_INT cdecl; external CLibCrypto;

  function X509_get_version(const x: PX509): TIdC_LONG cdecl; external CLibCrypto;
  function X509_set_version(x: PX509; version: TIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_set_serialNumber(x: PX509; serial: PASN1_INTEGER): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_serialNumber(x: PX509): PASN1_INTEGER cdecl; external CLibCrypto;
  function X509_get0_serialNumber(const x: PX509): PASN1_INTEGER cdecl; external CLibCrypto;
  function X509_set_issuer_name(x: PX509; name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_issuer_name(const a: PX509): PX509_NAME cdecl; external CLibCrypto;
  function X509_set_subject_name(x: PX509; name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_subject_name(const a: PX509): PX509_NAME cdecl; external CLibCrypto;
  function X509_get0_notBefore(const x: PX509): PASN1_TIME cdecl; external CLibCrypto;
  function X509_getm_notBefore(const x: PX509): PASN1_TIME cdecl; external CLibCrypto;
  function X509_set1_notBefore(x: PX509; const tm: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function X509_get0_notAfter(const x: PX509): PASN1_TIME cdecl; external CLibCrypto;
  function X509_getm_notAfter(const x: PX509): PASN1_TIME cdecl; external CLibCrypto;
  function X509_set1_notAfter(x: PX509; const tm: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function X509_set_pubkey(x: PX509; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function X509_up_ref(x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_signature_type(const x: PX509): TIdC_INT cdecl; external CLibCrypto;

  (*
   * This one is only used so that a binary form can output, as in
   * i2d_X509_PUBKEY(X509_get_X509_PUBKEY(x), &buf)
   *)
  function X509_get_X509_PUBKEY(const x: PX509): PX509_PUBKEY cdecl; external CLibCrypto;
//  const STACK_OF(X509_EXTENSION) *X509_get0_extensions(const X509 *x);
  procedure X509_get0_uids(const x: PX509; const piuid: PPASN1_BIT_STRING; const psuid: PPASN1_BIT_STRING) cdecl; external CLibCrypto;
  function X509_get0_tbs_sigalg(const x: PX509): PX509_ALGOR cdecl; external CLibCrypto;

  function X509_get0_pubkey(const x: PX509): PEVP_PKEY cdecl; external CLibCrypto;
  function X509_get_pubkey(x: PX509): PEVP_PKEY cdecl; external CLibCrypto;
  function X509_get0_pubkey_bitstr(const x: PX509): PASN1_BIT_STRING cdecl; external CLibCrypto;
  function X509_certificate_type(const x: PX509; const pubkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function X509_REQ_get_version(const req: PX509_REQ): TIdC_LONG cdecl; external CLibCrypto;
  function X509_REQ_set_version(x: PX509_REQ; version: TIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_subject_name(const req: PX509_REQ): PX509_NAME cdecl; external CLibCrypto;
  function X509_REQ_set_subject_name(req: PX509_REQ; name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_REQ_get0_signature(const req: PX509_REQ; const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR) cdecl; external CLibCrypto;
  function X509_REQ_get_signature_nid(const req: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;
  function i2d_re_X509_REQ_tbs(req: PX509_REQ; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_set_pubkey(x: PX509_REQ; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_pubkey(req: PX509_REQ): PEVP_PKEY cdecl; external CLibCrypto;
  function X509_REQ_get0_pubkey(req: PX509_REQ): PEVP_PKEY cdecl; external CLibCrypto;
  function X509_REQ_get_X509_PUBKEY(req: PX509_REQ): PX509_PUBKEY cdecl; external CLibCrypto;
  function X509_REQ_extension_nid(nid: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_extension_nids: PIdC_INT cdecl; external CLibCrypto;
  procedure X509_REQ_set_extension_nids(nids: PIdC_INT) cdecl; external CLibCrypto;
//  STACK_OF(X509_EXTENSION) *X509_REQ_get_extensions(X509_REQ *req);
  //TIdC_INT X509_REQ_add_extensions_nid(X509_REQ *req, STACK_OF(X509_EXTENSION) *exts,
  //                                TIdC_INT nid);
  //TIdC_INT X509_REQ_add_extensions(X509_REQ *req, STACK_OF(X509_EXTENSION) *exts);
  function X509_REQ_get_attr_count(const req: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_attr_by_NID(const req: PX509_REQ; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_attr_by_OBJ(const req: PX509_REQ; const obj: ASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_get_attr(const req: PX509_REQ; loc: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_REQ_delete_attr(req: PX509_REQ; loc: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_REQ_add1_attr(req: PX509_REQ; attr: PX509_ATTRIBUTE): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_add1_attr_by_OBJ(req: PX509_REQ; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_add1_attr_by_NID(req: PX509_REQ; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_add1_attr_by_txt(req: PX509_REQ; const attrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function X509_CRL_set_version(x: PX509_CRL; version: TIdC_LONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_set_issuer_name(x: PX509_CRL; name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_set1_lastUpdate(x: PX509_CRL; const tm: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_set1_nextUpdate(x: PX509_CRL; const tm: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_sort(crl: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_up_ref(crl: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;

  function X509_CRL_get_version(const crl: PX509_CRL): TIdC_LONG cdecl; external CLibCrypto;
  function X509_CRL_get0_lastUpdate(const crl: PX509_CRL): PASN1_TIME cdecl; external CLibCrypto;
  function X509_CRL_get0_nextUpdate(const crl: PX509_CRL): PASN1_TIME cdecl; external CLibCrypto;
  function X509_CRL_get_issuer(const crl: PX509_CRL): PX509_NAME cdecl; external CLibCrypto;
  //const STACK_OF(X509_EXTENSION) *X509_CRL_get0_extensions(const X509_CRL *crl);
  //STACK_OF(X509_REVOKED) *X509_CRL_get_REVOKED(X509_CRL *crl);
  procedure X509_CRL_get0_signature(const crl: PX509_CRL; const psig: PPASN1_BIT_STRING; const palg: PPX509_ALGOR) cdecl; external CLibCrypto;
  function  X509_CRL_get_signature_nid(const crl: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function i2d_re_X509_CRL_tbs(req: PX509_CRL; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function X509_REVOKED_get0_serialNumber(const x: PX509_REVOKED): PASN1_INTEGER cdecl; external CLibCrypto;
  function X509_REVOKED_set_serialNumber(x: PX509_REVOKED; serial: PASN1_INTEGER): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get0_revocationDate(const x: PX509_REVOKED): PASN1_TIME cdecl; external CLibCrypto;
  function X509_REVOKED_set_revocationDate(r: PX509_REVOKED; tm: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  //const STACK_OF(X509_EXTENSION) *
  //X509_REVOKED_get0_extensions(const X509_REVOKED *r);

  function X509_CRL_diff(base: PX509_CRL; newer: PX509_CRL; skey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_UINT): PX509_CRL cdecl; external CLibCrypto;

  function X509_REQ_check_private_key(x509: PX509_REQ; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;

  function X509_check_private_key(const x509: PX509; const pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  //TIdC_INT X509_chain_check_suiteb(TIdC_INT *perror_depth,
  //                            X509 *x, STACK_OF(X509) *chain,
  //                            unsigned TIdC_LONG flags);
  function X509_CRL_check_suiteb(crl: PX509_CRL; pk: PEVP_PKEY; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  //STACK_OF(X509) *X509_chain_up_ref(STACK_OF(X509) *chain);

  function X509_issuer_and_serial_cmp(const a: PX509; const b: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_issuer_and_serial_hash(a: PX509): TIdC_ULONG cdecl; external CLibCrypto;

  function X509_issuer_name_cmp(const a: PX509; const b: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_issuer_name_hash(a: PX509): TIdC_uLONG cdecl; external CLibCrypto;

  function X509_subject_name_cmp(const a: PX509; const b: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_subject_name_hash(x: PX509): TIdC_ULONG cdecl; external CLibCrypto;

  function X509_cmp(const a: PX509; const b: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_cmp(const a: PX509_NAME; const b: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_hash(x: PX509_NAME): TIdC_ULONG cdecl; external CLibCrypto;
  function X509_NAME_hash_old(x: PX509_NAME): TIdC_ULONG cdecl; external CLibCrypto;

  function X509_CRL_cmp(const a: PX509_CRL; const b: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_match(const a: PX509_CRL; const b: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_aux_print(&out: PBIO; x: PX509; indent: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  //# ifndef OPENSSL_NO_STDIO
  //TIdC_INT X509_print_ex_fp(FILE *bp, X509 *x, unsigned TIdC_LONG nmflag,
  //                     unsigned TIdC_LONG cflag);
  //TIdC_INT X509_print_fp(FILE *bp, X509 *x);
  //TIdC_INT X509_CRL_print_fp(FILE *bp, X509_CRL *x);
  //TIdC_INT X509_REQ_print_fp(FILE *bp, X509_REQ *req);
  //TIdC_INT X509_NAME_print_ex_fp(FILE *fp, const X509_NAME *nm, TIdC_INT indent,
  //                          unsigned TIdC_LONG flags);
  //# endif

  function X509_NAME_print(bp: PBIO; const name: PX509_NAME; obase: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_print_ex(&out: PBIO; const nm: PX509_NAME; indent: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_print_ex(bp: PBIO; x: PX509; nmflag: TIdC_ULONG; cflag: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_print(bp: PBIO; x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_ocspid_print(bp: PBIO; x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_print_ex(&out: PBIO; x: PX509_CRL; nmflag: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_print(bp: PBIO; x: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_print_ex(bp: PBIO; x: PX509_REQ; nmflag: TIdC_ULONG; cflag: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_REQ_print(bp: PBIO; req: PX509_REQ): TIdC_INT cdecl; external CLibCrypto;

  function X509_NAME_entry_count(const name: PX509_NAME): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_get_text_by_NID(name: PX509_NAME; nid: TIdC_INT; buf: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_get_text_by_OBJ(name: PX509_NAME; const obj: PASN1_OBJECT; buf: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  (*
   * NOTE: you should be passing -1, not 0 as lastpos. The functions that use
   * lastpos, search after that position on.
   *)
  function X509_NAME_get_index_by_NID(name: PX509_NAME; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_get_index_by_OBJ(name: PX509_NAME; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_get_entry(const name: PX509_NAME; loc: TIdC_INT): PX509_NAME_ENTRY cdecl; external CLibCrypto;
  function X509_NAME_delete_entry(name: PX509_NAME; loc: TIdC_INT): pX509_NAME_ENTRY cdecl; external CLibCrypto;
  function X509_NAME_add_entry(name: PX509_NAME; const ne: PX509_NAME_ENTRY; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_add_entry_by_OBJ(name: PX509_NAME; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_add_entry_by_NID(name: PX509_NAME; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_create_by_txt(ne: PPX509_NAME_ENTRY; const field: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_create_by_NID(ne: PPX509_NAME_ENTRY; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl; external CLibCrypto;
  function X509_NAME_add_entry_by_txt(name: PX509_NAME; const field: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT; loc: TIdC_INT; set_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_create_by_OBJ(ne: PPX509_NAME_ENTRY; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_NAME_ENTRY cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_set_object(ne: PX509_NAME_ENTRY; const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_set_data(ne: PX509_NAME_ENTRY; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_get_object(const ne: PX509_NAME_ENTRY): PASN1_OBJECT cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_get_data(const ne: PX509_NAME_ENTRY): PASN1_STRING cdecl; external CLibCrypto;
  function X509_NAME_ENTRY_set(const ne: PX509_NAME_ENTRY): TIdC_INT cdecl; external CLibCrypto;

  function X509_NAME_get0_der(nm: PX509_NAME; const pder: PPByte; pderlen: PIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;

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

  function X509_get_ext_count(const x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ext_by_NID(const x: PX509; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ext_by_OBJ(const x: PX509; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ext_by_critical(const x: PX509; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ext(const x: PX509; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_delete_ext(x: PX509; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_add_ext(x: PX509; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_get_ext_d2i(const x: PX509; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl; external CLibCrypto;
  function X509_add1_ext_i2d(x: PX509; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;

  function X509_CRL_get_ext_count(const x: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get_ext_by_NID(const x: PX509_CRL; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get_ext_by_OBJ(const x: X509_CRL; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get_ext_by_critical(const x: PX509_CRL; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get_ext(const x: PX509_CRL; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_CRL_delete_ext(x: PX509_CRL; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_CRL_add_ext(x: PX509_CRL; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_CRL_get_ext_d2i(const x: PX509_CRL; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl; external CLibCrypto;
  function X509_CRL_add1_ext_i2d(x: PX509_CRL; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;

  function X509_REVOKED_get_ext_count(const x: PX509_REVOKED): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get_ext_by_NID(const x: PX509_REVOKED; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get_ext_by_OBJ(const x: PX509_REVOKED; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get_ext_by_critical(const x: PX509_REVOKED; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get_ext(const x: PX509_REVOKED; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_REVOKED_delete_ext(x: PX509_REVOKED; loc: TIdC_INT): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_REVOKED_add_ext(x: PX509_REVOKED; ex: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_REVOKED_get_ext_d2i(const x: PX509_REVOKED; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl; external CLibCrypto;
  function X509_REVOKED_add1_ext_i2d(x: PX509_REVOKED; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;

  function X509_EXTENSION_create_by_NID(ex: PPX509_EXTENSION; nid: TIdC_INT; crit: TIdC_INT; data: PASN1_OCTET_STRING): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_EXTENSION_create_by_OBJ(ex: PPX509_EXTENSION; const obj: PASN1_OBJECT; crit: TIdC_INT; data: PASN1_OCTET_STRING): PX509_EXTENSION cdecl; external CLibCrypto;
  function X509_EXTENSION_set_object(ex: PX509_EXTENSION; const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_EXTENSION_set_critical(ex: PX509_EXTENSION; crit: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_EXTENSION_set_data(ex: PX509_EXTENSION; data: PASN1_OCTET_STRING): TIdC_INT cdecl; external CLibCrypto;
  function X509_EXTENSION_get_object(ex: PX509_EXTENSION): PASN1_OBJECT cdecl; external CLibCrypto;
  function X509_EXTENSION_get_data(ne: PX509_EXTENSION): PASN1_OCTET_STRING cdecl; external CLibCrypto;
  function X509_EXTENSION_get_critical(const ex: PX509_EXTENSION): TIdC_INT cdecl; external CLibCrypto;

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
  function X509_ATTRIBUTE_create_by_NID(attr: PPX509_ATTRIBUTE; nid: TIdC_INT; atrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_create_by_OBJ(attr: PPX509_ATTRIBUTE; const obj: PASN1_OBJECT; atrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_create_by_txt(attr: PPX509_ATTRIBUTE; const atrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_set1_object(attr: PX509_ATTRIBUTE; const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_set1_data(attr: PX509_ATTRIBUTE; attrtype: TIdC_INT; const data: Pointer; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_get0_data(attr: PX509_ATTRIBUTE; idx: TIdC_INT; atrtype: TIdC_INT; data: Pointer): Pointer cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_count(const attr: PX509_ATTRIBUTE): TIdC_INT cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_get0_object(attr: PX509_ATTRIBUTE): PASN1_OBJECT cdecl; external CLibCrypto;
  function X509_ATTRIBUTE_get0_type(attr: PX509_ATTRIBUTE; idx: TIdC_INT): PASN1_TYPE cdecl; external CLibCrypto;

  function EVP_PKEY_get_attr_count(const key: PEVP_PKEY): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_get_attr_by_NID(const key: PEVP_PKEY; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_get_attr_by_OBJ(const key: PEVP_PKEY; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_get_attr(const key: PEVP_PKEY; loc: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function EVP_PKEY_delete_attr(key: PEVP_PKEY; loc: TIdC_INT): PX509_ATTRIBUTE cdecl; external CLibCrypto;
  function EVP_PKEY_add1_attr(key: PEVP_PKEY; attr: PX509_ATTRIBUTE): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_add1_attr_by_OBJ(key: PEVP_PKEY; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_add1_attr_by_NID(key: PEVP_PKEY; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function EVP_PKEY_add1_attr_by_txt(key: PEVP_PKEY; const attrname: PIdAnsiChar; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function X509_verify_cert(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external CLibCrypto;

  (* lookup a cert from a X509 STACK *)
//  function X509_find_by_issuer_and_serial(sk: P STACK_OF(X509); name: PX509_NAME; serial: PASN1_INTEGER): PX509;
//  X509 *X509_find_by_subject(STACK_OF(X509) *sk, X509_NAME *name);

  //DECLARE_ASN1_FUNCTIONS(PBEPARAM)
  //DECLARE_ASN1_FUNCTIONS(PBE2PARAM)
  //DECLARE_ASN1_FUNCTIONS(PBKDF2PARAM)
  //#ifndef OPENSSL_NO_SCRYPT
  //DECLARE_ASN1_FUNCTIONS(SCRYPT_PARAMS)
  //#endif

  function PKCS5_pbe_set0_algor(algor: PX509_ALGOR; alg: TIdC_INT; iter: TIdC_INT; const salt: PByte; saltlen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function PKCS5_pbe_set(alg: TIdC_INT; iter: TIdC_INT; const salt: PByte; saltlen: TIdC_INT): PX509_ALGOR cdecl; external CLibCrypto;
  function PKCS5_pbe2_set(const cipher: PEVP_CIPHER; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT): PX509_ALGOR cdecl; external CLibCrypto;
  function PKCS5_pbe2_set_iv(const cipher: PEVP_CIPHER; iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; aiv: PByte; prf_nid: TIdC_INT): PX509_ALGOR cdecl; external CLibCrypto;

  function PKCS5_pbe2_set_scrypt(const cipher: PEVP_CIPHER; const salt: PByte; saltlen: TIdC_INT; aiv: PByte; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64): PX509_ALGOR cdecl; external CLibCrypto;

  function PKCS5_pbkdf2_set(iter: TIdC_INT; salt: PByte; saltlen: TIdC_INT; prf_nid: TIdC_INT; keylen: TIdC_INT): PX509_ALGOR cdecl; external CLibCrypto;

  (* PKCS#8 utilities *)

  //DECLARE_ASN1_FUNCTIONS(PKCS8_PRIV_KEY_INFO)

  function EVP_PKCS82PKEY(const p8: PPKCS8_PRIV_KEY_INFO): PEVP_PKEY cdecl; external CLibCrypto;
  function EVP_PKEY2PKCS8(pkey: PEVP_PKEY): PKCS8_PRIV_KEY_INFO cdecl; external CLibCrypto;

  function PKCS8_pkey_set0(priv: PPKCS8_PRIV_KEY_INFO; aobj: PASN1_OBJECT; version: TIdC_INT; ptype: TIdC_INT; pval: Pointer; penc: PByte; penclen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS8_pkey_get0(const ppkalg: PPASN1_OBJECT; const pk: PPByte; ppklen: PIdC_INT; const pa: PPX509_ALGOR; const p8: PPKCS8_PRIV_KEY_INFO): TIdC_INT cdecl; external CLibCrypto;

  //const STACK_OF(X509_ATTRIBUTE) *
  //PKCS8_pkey_get0_attrs(const PKCS8_PRIV_KEY_INFO *p8);
  function PKCS8_pkey_add1_attr_by_NID(p8: PPKCS8_PRIV_KEY_INFO; nid: TIdC_INT; type_: TIdC_INT; const bytes: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function X509_PUBKEY_set0_param(pub: PX509_PUBKEY; aobj: PASN1_OBJECT; ptype: TIdC_INT; pval: Pointer; penc: PByte; penclen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_PUBKEY_get0_param(ppkalg: PPASN1_OBJECT; const pk: PPByte; ppklen: PIdC_INT; pa: PPX509_ALGOR; pub: PX509_PUBKEY): TIdC_INT cdecl; external CLibCrypto;

  function X509_check_trust(x: PX509; id: TIdC_INT; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_TRUST_get_count: TIdC_INT cdecl; external CLibCrypto;
  function X509_TRUST_get0(idx: TIdC_INT): PX509_TRUST cdecl; external CLibCrypto;
  function X509_TRUST_get_by_id(id: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
//  TIdC_INT X509_TRUST_add(TIdC_INT id, TIdC_INT flags, TIdC_INT (*ck) (X509_TRUST *, X509 *, TIdC_INT),
//                     const PIdAnsiChar *name, TIdC_INT arg1, void *arg2);
  procedure X509_TRUST_cleanup cdecl; external CLibCrypto;
  function X509_TRUST_get_flags(const xp: PX509_TRUST): TIdC_INT cdecl; external CLibCrypto;
  function X509_TRUST_get0_name(const xp: PX509_TRUST): PIdAnsiChar cdecl; external CLibCrypto;
  function X509_TRUST_get_trust(const xp: PX509_TRUST): TIdC_INT cdecl; external CLibCrypto;

implementation

end.
