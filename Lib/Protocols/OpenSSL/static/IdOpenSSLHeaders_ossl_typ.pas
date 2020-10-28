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

unit IdOpenSSLHeaders_ossl_typ;

interface

// Headers for OpenSSL 1.1.1
// ossl_typ.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

type
// moved from unit "asn1" to prevent circular references
  asn1_string_st = record
    length: TIdC_INT;
    type_: TIdC_INT;
    data: PByte;
    (*
     * The value of the following field depends on the type being held.  It
     * is mostly being used for BIT_STRING so if the input data has a
     * non-zero 'unused bits' value, it will be handled correctly
     *)
    flags: TIdC_LONG;
  end;

  // moved from asn1  
  ASN1_VALUE_st = type Pointer;
  ASN1_VALUE = ASN1_VALUE_st;
  PASN1_VALUE = ^ASN1_VALUE;
  PPASN1_VALUE = ^PASN1_VALUE;

  // moved from e_os2
  ossl_ssize_t = type {$IFDEF WIN64}TIdC_INT64{$ELSE}TIdC_INT{$ENDIF};

  asn1_object_st = type Pointer;
  ASN1_OBJECT = asn1_object_st;
  PASN1_OBJECT = ^ASN1_OBJECT;
  PPASN1_OBJECT = ^PASN1_OBJECT;

  ASN1_INTEGER = type asn1_string_st;
  PASN1_INTEGER = ^ASN1_INTEGER;
  PPASN1_INTEGER = ^PASN1_INTEGER;

  ASN1_ENUMERATED = type asn1_string_st;
  PASN1_ENUMERATED = ^ASN1_ENUMERATED;

  ASN1_BIT_STRING = type asn1_string_st;
  PASN1_BIT_STRING = ^ASN1_BIT_STRING;
  PPASN1_BIT_STRING = ^PASN1_BIT_STRING;

  ASN1_OCTET_STRING = type asn1_string_st;
  PASN1_OCTET_STRING = ^ASN1_OCTET_STRING;
  PPASN1_OCTET_STRING = ^PASN1_OCTET_STRING;

  ASN1_PRINTABLESTRING = type asn1_string_st;
  PASN1_PRINTABLESTRING = ^ASN1_PRINTABLESTRING;

  ASN1_T61STRING = type asn1_string_st;
  PASN1_T61STRING = ^ASN1_T61STRING;

  ASN1_IA5STRING = type asn1_string_st;
  PASN1_IA5STRING = ^ASN1_IA5STRING;

  ASN1_GENERALSTRING = type asn1_string_st;
  PASN1_GENERALSTRING = ^ASN1_GENERALSTRING;

  ASN1_UNIVERSALSTRING = type asn1_string_st;
  PASN1_UNIVERSALSTRING = ^ASN1_UNIVERSALSTRING;

  ASN1_BMPSTRING = type asn1_string_st;
  PASN1_BMPSTRING = ^ASN1_BMPSTRING;

  ASN1_UTCTIME = type asn1_string_st;
  PASN1_UTCTIME = ^ASN1_UTCTIME;

  ASN1_TIME = type asn1_string_st;
  PASN1_TIME = ^ASN1_TIME;

  ASN1_GENERALIZEDTIME = type asn1_string_st;
  PASN1_GENERALIZEDTIME = ^ASN1_GENERALIZEDTIME;
  PPASN1_GENERALIZEDTIME = ^PASN1_GENERALIZEDTIME;

  ASN1_VISIBLESTRING = type asn1_string_st;
  PASN1_VISIBLESTRING = ^ASN1_VISIBLESTRING;

  ASN1_UTF8STRING = type asn1_string_st;
  PASN1_UTF8STRING = ^ASN1_UTF8STRING;

  ASN1_STRING = type asn1_string_st;
  PASN1_STRING = ^ASN1_STRING;
  PPASN1_STRING = ^PASN1_STRING;

  ASN1_BOOLEAN = type TIdC_INT;
  PASN1_BOOLEAN = ^ASN1_BOOLEAN;

  ASN1_NULL = type TIdC_INT;
  PASN1_NULL = ^ASN1_NULL;

  
  ASN1_ITEM_st = type Pointer;
  ASN1_ITEM = ASN1_ITEM_st;
  PASN1_ITEM = ^ASN1_ITEM;
  
  asn1_pctx_st = type Pointer;
  ASN1_PCTX = asn1_pctx_st;
  PASN1_PCTX = ^ASN1_PCTX;
  
  asn1_sctx_st = type Pointer;
  ASN1_SCTX = asn1_sctx_st;
  PASN1_SCTX = ^ASN1_SCTX;

  dane_st = type Pointer;
  bio_st = type Pointer;
  BIO = bio_st;
  PBIO = ^BIO;
  PPBIO  = ^PBIO;
  bignum_st = type Pointer;
  BIGNUM = bignum_st;
  PBIGNUM = ^BIGNUM;
  PPBIGNUM  = ^PBIGNUM;
  bignum_ctx = type Pointer;
  BN_CTX = bignum_ctx;
  PBN_CTX = ^BN_CTX;
  bn_blinding_st = type Pointer;
  BN_BLINDING = bn_blinding_st;
  PBN_BLINDING = ^BN_BLINDING;
  bn_mont_ctx_st = type Pointer;
  BN_MONT_CTX = bn_mont_ctx_st;
  PBN_MONT_CTX = ^BN_MONT_CTX;
  bn_recp_ctx_st = type Pointer;
  BN_RECP_CTX = bn_recp_ctx_st;
  PBN_RECP_CTX = ^BN_RECP_CTX;
  bn_gencb_st = type Pointer;
  BN_GENCB = bn_gencb_st;
  PBN_GENCB = ^BN_GENCB;
  
  buf_mem_st = type Pointer;
  BUF_MEM = buf_mem_st;
  PBUF_MEM = ^BUF_MEM;

  evp_cipher_st = type Pointer;
  EVP_CIPHER = evp_cipher_st;
  PEVP_CIPHER = ^EVP_CIPHER;
  PPEVP_CIPHER = ^PEVP_CIPHER;
  evp_cipher_ctx_st = type Pointer;
  EVP_CIPHER_CTX = evp_cipher_ctx_st;
  PEVP_CIPHER_CTX = ^EVP_CIPHER_CTX;
  evp_md_st = type Pointer;
  EVP_MD = evp_md_st;
  PEVP_MD = ^EVP_MD;
  PPEVP_MD = ^PEVP_MD;
  evp_md_ctx_st = type Pointer;
  EVP_MD_CTX = evp_md_ctx_st;
  PEVP_MD_CTX = ^EVP_MD_CTX;
  evp_pkey_st = type Pointer;
  EVP_PKEY = evp_pkey_st;
  PEVP_PKEY = ^EVP_PKEY;
  PPEVP_PKEY = ^PEVP_PKEY;
  
  evp_pkey_asn1_method_st = type Pointer;
  EVP_PKEY_ASN1_METHOD = evp_pkey_asn1_method_st;
  PEVP_PKEY_ASN1_METHOD = ^EVP_PKEY_ASN1_METHOD;
  PPEVP_PKEY_ASN1_METHOD = ^PEVP_PKEY_ASN1_METHOD;
  
  evp_pkey_method_st = type Pointer;
  EVP_PKEY_METHOD = evp_pkey_method_st;
  PEVP_PKEY_METHOD = ^EVP_PKEY_METHOD;
  PPEVP_PKEY_METHOD = ^PEVP_PKEY_METHOD;
  evp_pkey_ctx_st = type Pointer;
  EVP_PKEY_CTX = evp_pkey_ctx_st;
  PEVP_PKEY_CTX = ^EVP_PKEY_CTX;
  PPEVP_PKEY_CTX = ^PEVP_PKEY_CTX;
  
  evp_Encode_Ctx_st = type Pointer;
  EVP_ENCODE_CTX = evp_Encode_Ctx_st;
  PEVP_ENCODE_CTX = ^EVP_ENCODE_CTX;

  hmac_ctx_st = type Pointer;
  HMAC_CTX = hmac_ctx_st;
  PHMAC_CTX = ^HMAC_CTX;
  
  dh_st = type Pointer;
  DH = dh_st;
  PDH = ^DH;
  PPDH = ^PDH;
  dh_method_st = type Pointer;
  DH_METHOD = dh_method_st;
  PDH_METHOD = ^DH_METHOD;
  
  dsa_st = type Pointer;
  DSA = dsa_st;
  PDSA = ^DSA;
  PPDSA = ^PDSA;
  dsa_method_st = type Pointer;
  DSA_METHOD = dsa_method_st;
  PDSA_METHOD = ^DSA_METHOD;
  
  rsa_st = type Pointer;
  RSA = rsa_st;
  PRSA = ^RSA;
  PPRSA = ^PRSA;
  rsa_meth_st = type Pointer;
  RSA_METHOD = rsa_meth_st;
  PRSA_METHOD = ^RSA_METHOD;

  ec_key_st = type Pointer;
  EC_KEY = ec_key_st;
  PEC_KEY = ^EC_KEY;
  PPEC_KEY = ^PEC_KEY;
  ec_key_method_st = type Pointer;
  EC_KEY_METHOD = ec_key_method_st;
  PEC_KEY_METHOD = ^EC_KEY_METHOD;
  
  rand_meth_st = type Pointer;
  RAND_METHOD = rand_meth_st;
  PRAND_METHOD = ^RAND_METHOD;
  rand_drbg_st = type Pointer;
  RAND_DRBG = rand_drbg_st;
  PRAND_DRBG = ^RAND_DRBG;
  
  ssl_dane_st = type Pointer;
  SSL_DANE = ssl_dane_st;
  PSSL_DANE = ^SSL_DANE;
  x509_st = type Pointer;
  X509 = x509_st;
  PX509 = ^X509;
  PPX509 = ^PX509;
  X509_crl_st = type Pointer;
  X509_CRL = X509_crl_st;
  PX509_CRL = ^X509_CRL;
  PPX509_CRL = ^PX509_CRL;
  x509_crl_method_st = type Pointer;
  X509_CRL_METHOD = x509_crl_method_st;
  PX509_CRL_METHOD = ^X509_CRL_METHOD;
  x509_revoked_st = type Pointer;
  X509_REVOKED = x509_revoked_st;
  PX509_REVOKED = ^X509_REVOKED;
  X509_name_st = type Pointer;
  X509_NAME = X509_name_st;
  PX509_NAME = ^X509_NAME;
  PPX509_NAME = ^PX509_NAME;
  X509_pubkey_st = type Pointer;
  X509_PUBKEY = X509_pubkey_st;
  PX509_PUBKEY = ^X509_PUBKEY;
  PPX509_PUBKEY = ^PX509_PUBKEY;
  x509_store_st = type Pointer;
  X509_STORE = x509_store_st;
  PX509_STORE = ^X509_STORE;
  x509_store_ctx_st = type Pointer;
  X509_STORE_CTX = x509_store_ctx_st;
  PX509_STORE_CTX = ^X509_STORE_CTX;
  
  x509_object_st = type Pointer;
  X509_OBJECT = x509_object_st;
  PX509_OBJECT = ^X509_OBJECT;
  x509_lookup_st = type Pointer;
  X509_LOOKUP = x509_lookup_st;
  PX509_LOOKUP = ^X509_LOOKUP;
  x509_lookup_method_st = type Pointer;
  X509_LOOKUP_METHOD = x509_lookup_method_st;
  PX509_LOOKUP_METHOD = ^X509_LOOKUP_METHOD;
  X509_VERIFY_PARAM_st = type Pointer;
  X509_VERIFY_PARAM = X509_VERIFY_PARAM_st;
  PX509_VERIFY_PARAM = ^X509_VERIFY_PARAM;
  
  x509_sig_info_st = type Pointer;
  X509_SIG_INFO = x509_sig_info_st;
  PX509_SIG_INFO = ^X509_SIG_INFO;

  pkcs8_priv_key_info_st = type Pointer;
  PKCS8_PRIV_KEY_INFO = pkcs8_priv_key_info_st;
  PPKCS8_PRIV_KEY_INFO = ^PKCS8_PRIV_KEY_INFO;
  PPPKCS8_PRIV_KEY_INFO = ^PPKCS8_PRIV_KEY_INFO;

// moved from x509 to prevent circular references
  X509_REQ = type Pointer; // X509_req_st
  PX509_REQ = ^X509_REQ;
  PPX509_REQ = ^PX509_REQ;

// moved from x509v3 to prevent circular references
  (* Context specific info *)
  v3_ext_ctx = record
    flags: TIdC_INT;
    issuer_cert: PX509;
    subject_cert: PX509;
    subject_req: PX509_REQ;
    crl: PX509_CRL;
    db_meth: Pointer; //PX509V3_CONF_METHOD;
    db: Pointer;
  (* Maybe more here *)
  end;
//  v3_ext_ctx = type Pointer;
  X509V3_CTX = v3_ext_ctx;
  PX509V3_CTX = ^X509V3_CTX;
  conf_st = type Pointer;
  CONF = conf_st;
  PCONF = ^CONF;
  ossl_init_settings_st = type Pointer;
  OPENSSL_INIT_SETTINGS = ossl_init_settings_st;
  POPENSSL_INIT_SETTINGS = ^OPENSSL_INIT_SETTINGS;

  ui_st = type Pointer;
  UI = ui_st;
  PUI = ^UI;
  ui_method_st = type Pointer;
  UI_METHOD = ui_method_st;
  PUI_METHOD = ^UI_METHOD;
  
  engine_st = type Pointer;
  ENGINE = engine_st;
  PENGINE = ^ENGINE;
  PPENGINE = ^PENGINE;
  ssl_st = type Pointer;
  SSL = ssl_st;
  PSSL = ^SSL;
  ssl_ctx_st = type Pointer;
  SSL_CTX = ssl_ctx_st;
  PSSL_CTX = ^SSL_CTX;
  PPSSL_CTX  = ^PSSL_CTX;
  
  comp_ctx_st = type Pointer;
  COMP_CTX = comp_ctx_st;
  PCOMP_CTX = ^COMP_CTX;
  comp_method_st = type Pointer;
  COMP_METHOD = comp_method_st;
  PCOMP_METHOD = ^COMP_METHOD;
  
  X509_POLICY_NODE_st = type Pointer;
  X509_POLICY_NODE = X509_POLICY_NODE_st;
  PX509_POLICY_NODE = ^X509_POLICY_NODE;
  X509_POLICY_LEVEL_st = type Pointer;
  X509_POLICY_LEVEL = X509_POLICY_LEVEL_st;
  PX509_POLICY_LEVEL = ^X509_POLICY_LEVEL;
  X509_POLICY_TREE_st = type Pointer;
  X509_POLICY_TREE = X509_POLICY_TREE_st;
  PX509_POLICY_TREE = ^X509_POLICY_TREE;
  X509_POLICY_CACHE_st = type Pointer;
  X509_POLICY_CACHE = X509_POLICY_CACHE_st;
  PX509_POLICY_CACHE = ^X509_POLICY_CACHE;
  
  AUTHORITY_KEYID_st = type Pointer;
  AUTHORITY_KEYID = AUTHORITY_KEYID_st;
  PAUTHORITY_KEYID = ^AUTHORITY_KEYID;
  DIST_POINT_st = type Pointer;
  DIST_POINT = DIST_POINT_st;
  PDIST_POINT = ^DIST_POINT;
  ISSUING_DIST_POINT_st = type Pointer;
  ISSUING_DIST_POINT = ISSUING_DIST_POINT_st;
  PISSUING_DIST_POINT = ^ISSUING_DIST_POINT;
  NAME_CONSTRAINTS_st = type Pointer;
  NAME_CONSTRAINTS = NAME_CONSTRAINTS_st;
  PNAME_CONSTRAINTS = ^NAME_CONSTRAINTS;
  
  crypto_ex_data_st = type Pointer;
  CRYPTO_EX_DATA = crypto_ex_data_st;
  PCRYPTO_EX_DATA = ^CRYPTO_EX_DATA;
  
  ocsp_req_ctx_st = type Pointer;
  OCSP_REQ_CTX = ocsp_req_ctx_st;
  POCSP_REQ_CTX = ^OCSP_REQ_CTX;
  ocsp_response_st = type Pointer;
  OCSP_RESPONSE = ocsp_response_st;
  POCSP_RESPONSE = ^OCSP_RESPONSE;
  ocsp_responder_id_st = type Pointer;
  OCSP_RESPID = ocsp_responder_id_st;
  POCSP_RESPID = ^OCSP_RESPID;
  
  sct_st = type Pointer;
  SCT = sct_st;
  PSCT = ^SCT;
  sct_ctx_st = type Pointer;
  SCT_CTX = sct_ctx_st;
  PSCT_CTX = ^SCT_CTX;
  ctlog_st = type Pointer;
  CTLOG = ctlog_st;
  PCTLOG = ^CTLOG;
  ctlog_store_st = type Pointer;
  CTLOG_STORE = ctlog_store_st;
  PCTLOG_STORE = ^CTLOG_STORE;
  ct_policy_eval_ctx_st = type Pointer;
  CT_POLICY_EVAL_CTX = ct_policy_eval_ctx_st;
  PCT_POLICY_EVAL_CTX = ^CT_POLICY_EVAL_CTX;
  
  ossl_store_info_st = type Pointer;
  OSSL_STORE_INFO = ossl_store_info_st;
  POSSL_STORE_INFO = ^OSSL_STORE_INFO;
  ossl_store_search_st = type Pointer;
  OSSL_STORE_SEARCH = ossl_store_search_st;
  POSSL_STORE_SEARCH = ^OSSL_STORE_SEARCH;

// moved from unit "asn1" to prevent circular references'
const
  V_ASN1_UNIVERSAL = $00;
  V_ASN1_APPLICATION = $40;
  V_ASN1_CONTEXT_SPECIFIC = $80;
  V_ASN1_PRIVATE = $c0;

  V_ASN1_CONSTRUCTED = $20;
  V_ASN1_PRIMITIVE_TAG = $1f;
  V_ASN1_PRIMATIVE_TAG = V_ASN1_PRIMITIVE_TAG;

  V_ASN1_APP_CHOOSE = -2; (* let the recipient choose *)
  V_ASN1_OTHER = -3;      (* used in ASN1_TYPE *)
  V_ASN1_ANY = -4;        (* used in ASN1 template code *)

  V_ASN1_UNDEF = -1;
  V_ASN1_EOC =  0;
  V_ASN1_BOOLEAN = 1;
  V_ASN1_INTEGER = 2;
  V_ASN1_BIT_STRING = 3;
  V_ASN1_OCTET_STRING = 4;
  V_ASN1_NULL = 5;
  V_ASN1_OBJECT = 6;
  V_ASN1_OBJECT_DESCRIPTOR = 7;
  V_ASN1_EXTERNAL = 8;
  V_ASN1_REAL = 9;
  V_ASN1_ENUMERATED = 10;
  V_ASN1_UTF8STRING = 12;
  V_ASN1_SEQUENCE = 16;
  V_ASN1_SET = 17;
  V_ASN1_NUMERICSTRING = 18;
  V_ASN1_PRINTABLESTRING = 19;
  V_ASN1_T61STRING = 20;
  V_ASN1_TELETEXSTRING = 20;
  V_ASN1_VIDEOTEXSTRING = 21;
  V_ASN1_IA5STRING = 22;
  V_ASN1_UTCTIME = 23;
  V_ASN1_GENERALIZEDTIME = 24;
  V_ASN1_GRAPHICSTRING = 25;
  V_ASN1_ISO64STRING = 26;
  V_ASN1_VISIBLESTRING = 26;
  V_ASN1_GENERALSTRING = 27;
  V_ASN1_UNIVERSALSTRING = 28;
  V_ASN1_BMPSTRING = 30;

type
  asn1_type_st = record
    case type_: TIdC_INT of
//      (ptr: PIdAnsichar);
      V_ASN1_BOOLEAN: (boolean: ASN1_BOOLEAN);
//      (asn1_string: PASN1_STRING);
      V_ASN1_OBJECT: (&object: PASN1_OBJECT);
      V_ASN1_INTEGER: (integer: PASN1_INTEGER);
      V_ASN1_ENUMERATED: (enumerated: PASN1_ENUMERATED);
      V_ASN1_BIT_STRING: (bit_string: PASN1_BIT_STRING);
      V_ASN1_OCTET_STRING: (octet_string: PASN1_OCTET_STRING);
      V_ASN1_PRINTABLESTRING: (printablestring: PASN1_PRINTABLESTRING);
      V_ASN1_T61STRING: (t61string: PASN1_T61STRING);
      V_ASN1_IA5STRING: (ia5string: PASN1_IA5STRING);
      V_ASN1_GENERALSTRING: (generalstring: PASN1_GENERALSTRING);
      V_ASN1_BMPSTRING: (bmpstring: PASN1_BMPSTRING);
      V_ASN1_UNIVERSALSTRING: (universalstring: PASN1_UNIVERSALSTRING);
      V_ASN1_UTCTIME: (utctime: PASN1_UTCTIME);
      V_ASN1_GENERALIZEDTIME: (generalizedtime: PASN1_GENERALIZEDTIME);
      V_ASN1_VISIBLESTRING: (visiblestring: PASN1_VISIBLESTRING);
      V_ASN1_UTF8STRING: (utf8string: PASN1_UTF8STRING);
      (*
       * set and sequence are left complete and still contain the set or
       * sequence bytes
       *)
      V_ASN1_SET: (&set: PASN1_STRING);
      V_ASN1_SEQUENCE: (sequence: PASN1_STRING);
//      (asn1_value: PASN1_VALUE);

//      V_ASN1_UNDEF: ;
//      V_ASN1_EOC: ;
//      V_ASN1_NULL: ;
//      V_ASN1_OBJECT_DESCRIPTOR: ;
//      V_ASN1_EXTERNAL: ;
//      V_ASN1_REAL: ;
//      V_ASN1_NUMERICSTRING: ;
//      V_ASN1_TELETEXSTRING: ;
//      V_ASN1_VIDEOTEXSTRING: ;
//      V_ASN1_GRAPHICSTRING: ;
//      V_ASN1_ISO64STRING: ;
  end;
  ASN1_TYPE = asn1_type_st;
  PASN1_TYPE = ^ASN1_TYPE;
  PPASN1_TYPE = ^PASN1_TYPE;

// moved from unit "x509" to prevent circular references
  X509_algor_st = record
    algorithm: PASN1_OBJECT;
    parameter: PASN1_TYPE;
  end; (* X509_ALGOR *)

  X509_ALGOR = X509_algor_st;
  PX509_ALGOR = ^X509_ALGOR;
  PPX509_ALGOR = ^PX509_ALGOR;
  
  i2d_of_void = type Pointer;
  Pi2d_of_void = ^i2d_of_void;

  d2i_of_void = type Pointer;
  Pd2i_of_void = ^d2i_of_void;

implementation

end.
