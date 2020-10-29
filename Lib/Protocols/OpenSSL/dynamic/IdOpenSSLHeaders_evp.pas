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

// Generation date: 29.10.2020 07:07:29

unit IdOpenSSLHeaders_evp;

interface

// Headers for OpenSSL 1.1.1
// evp.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSlHeaders_bio,
  IdOpenSSLHeaders_obj_mac,
  IdOpenSSlHeaders_ossl_typ;

const
  EVP_MAX_MD_SIZE = 64; // longest known is SHA512
  EVP_MAX_KEY_LENGTH = 64;
  EVP_MAX_IV_LENGTH = 16;
  EVP_MAX_BLOCK_LENGTH = 32;
  PKCS5_SALT_LEN = 8;
  // Default PKCS#5 iteration count
  PKCS5_DEFAULT_ITER = 2048;
  EVP_PK_RSA = $0001;
  EVP_PK_DSA = $0002;
  EVP_PK_DH  = $0004;
  EVP_PK_EC = $0008;
  EVP_PKT_SIGN = $0010;
  EVP_PKT_ENC = $0020;
  EVP_PKT_EXCH = $0040;
  EVP_PKS_RSA = $0100;
  EVP_PKS_DSA = $0200;
  EVP_PKS_EC = $0400;

  EVP_PKEY_NONE = NID_undef;
  EVP_PKEY_RSA = NID_rsaEncryption;
  EVP_PKEY_RSA2 = NID_rsa;
  EVP_PKEY_RSA_PSS = NID_rsassaPss;
  EVP_PKEY_DSA = NID_dsa;
  EVP_PKEY_DSA1 = NID_dsa_2;
  EVP_PKEY_DSA2 = NID_dsaWithSHA;
  EVP_PKEY_DSA3 = NID_dsaWithSHA1;
  EVP_PKEY_DSA4 = NID_dsaWithSHA1_2;
  EVP_PKEY_DH = NID_dhKeyAgreement;
  EVP_PKEY_DHX = NID_dhpublicnumber;
  EVP_PKEY_EC = NID_X9_62_id_ecPublicKey;
  EVP_PKEY_SM2 = NID_sm2;
  EVP_PKEY_HMAC = NID_hmac;
  EVP_PKEY_CMAC = NID_cmac;
  EVP_PKEY_SCRYPT = NID_id_scrypt;
  EVP_PKEY_TLS1_PRF = NID_tls1_prf;
  EVP_PKEY_HKDF = NID_hkdf;
  EVP_PKEY_POLY1305 = NID_poly1305;
  EVP_PKEY_SIPHASH = NID_siphash;
  EVP_PKEY_X25519 = NID_X25519;
  EVP_PKEY_ED25519 = NID_ED25519;
  EVP_PKEY_X448 = NID_X448;
  EVP_PKEY_ED448 = NID_ED448;

  EVP_PKEY_MO_SIGN = $0001;
  EVP_PKEY_MO_VERIFY = $0002;
  EVP_PKEY_MO_ENCRYPT = $0004;
  EVP_PKEY_MO_DECRYPT = $0008;

// digest can only handle a single block ///
  EVP_MD_FLAG_ONESHOT = $0001;

// digest is extensible-output function; XOF ///

  EVP_MD_FLAG_XOF = $0002;

// DigestAlgorithmIdentifier flags... ///

  EVP_MD_FLAG_DIGALGID_MASK = $0018;

// NULL or absent parameter accepted. Use NULL ///

  EVP_MD_FLAG_DIGALGID_NULL = $0000;

// NULL or absent parameter accepted. Use NULL for PKCS#1 otherwise absent ///

  EVP_MD_FLAG_DIGALGID_ABSENT = $0008;

// Custom handling via ctrl ///

  EVP_MD_FLAG_DIGALGID_CUSTOM = $0018;

// Note if suitable for use in FIPS mode ///

  EVP_MD_FLAG_FIPS = $0400;

// Digest ctrls ///

  EVP_MD_CTRL_DIGALGID = $1;
  EVP_MD_CTRL_MICALG = $2;
  EVP_MD_CTRL_XOF_LEN = $3;

// Minimum Algorithm specific ctrl value ///

  EVP_MD_CTRL_ALG_CTRL = $1000;
 // not EVP_MD ///

// values for EVP_MD_CTX flags ///
  EVP_MD_CTX_FLAG_ONESHOT = $0001;
  EVP_MD_CTX_FLAG_CLEANED = $0002;
  EVP_MD_CTX_FLAG_REUSE = $0004;
//
 // FIPS and pad options are ignored in 1.0.0; definitions are here so we
 // don't accidentally reuse the values for other purposes.
 ///

  EVP_MD_CTX_FLAG_NON_FIPS_ALLOW = $0008;

//
 // The following PAD options are also currently ignored in 1.0.0; digest
 // parameters are handled through EVP_DigestSign//() and EVP_DigestVerify//()
 // instead.
 ///
  EVP_MD_CTX_FLAG_PAD_MASK = $F0;
  EVP_MD_CTX_FLAG_PAD_PKCS1 = $00;
  EVP_MD_CTX_FLAG_PAD_X931 = $10;
  EVP_MD_CTX_FLAG_PAD_PSS = $20;

  EVP_MD_CTX_FLAG_NO_INIT = $0100;
//
 // Some functions such as EVP_DigestSign only finalise copies of internal
 // contexts so additional data can be included after the finalisation call.
 // This is inefficient if this functionality is not required: it is disabled
 // if the following flag is set.
 ///
  EVP_MD_CTX_FLAG_FINALISE = $0200;


// NOTE: $0400 is reserved for internal usage ///
// Values for cipher flags ///

// Modes for ciphers ///

  EVP_CIPH_STREAM_CIPHER = $0;
  EVP_CIPH_ECB_MODE = $1;
  EVP_CIPHC_MODE = $2;
  EVP_CIPH_CFB_MODE = $3;
  EVP_CIPH_OFB_MODE = $4;
  EVP_CIPH_CTR_MODE = $5;
  EVP_CIPH_GCM_MODE = $6;
  EVP_CIPH_CCM_MODE = $7;
  EVP_CIPH_XTS_MODE = $10001;
  EVP_CIPH_WRAP_MODE = $10002;
  EVP_CIPH_OCB_MODE = $10003;
  EVP_CIPH_MODE = $F0007;
// Set if variable length cipher ///
  EVP_CIPH_VARIABLE_LENGTH = $8;
// Set if the iv handling should be done by the cipher itself ///
  EVP_CIPH_CUSTOM_IV = $10;
// Set if the cipher's init() function should be called if key is NULL ///
  EVP_CIPH_ALWAYS_CALL_INIT = $20;
// Call ctrl() to init cipher parameters ///
  EVP_CIPH_CTRL_INIT = $40;
// Don't use standard key length function ///
  EVP_CIPH_CUSTOM_KEY_LENGTH = $80;
// Don't use standard block padding ///
  EVP_CIPH_NO_PADDING = $100;
// cipher handles random key generation ///
  EVP_CIPH_RAND_KEY = $200;
// cipher has its own additional copying logic ///
  EVP_CIPH_CUSTOM_COPY = $400;
// Don't use standard iv length function ///
  EVP_CIPH_CUSTOM_IV_LENGTH = $800;
// Allow use default ASN1 get/set iv ///
  EVP_CIPH_FLAG_DEFAULT_ASN1 = $1000;
// Buffer length in bits not bytes: CFB1 mode only ///
  EVP_CIPH_FLAG_LENGTH_BITS = $2000;
// Note if suitable for use in FIPS mode ///
  EVP_CIPH_FLAG_FIPS = $4000;
// Allow non FIPS cipher in FIPS mode ///
  EVP_CIPH_FLAG_NON_FIPS_ALLOW = $8000;
//
 // Cipher handles any and all padding logic as well as finalisation.
 ///
  EVP_CIPH_FLAG_CUSTOM_CIPHER = $100000;
  EVP_CIPH_FLAG_AEAD_CIPHER = $200000;
  EVP_CIPH_FLAG_TLS1_1_MULTIBLOCK = $400000;
// Cipher can handle pipeline operations ///
  EVP_CIPH_FLAG_PIPELINE = $800000;

//
 // Cipher context flag to indicate we can handle wrap mode: if allowed in
 // older applications it could overflow buffers.
 ///

  EVP_CIPHER_CTX_FLAG_WRAP_ALLOW = $1;

// ctrl() values ///

  EVP_CTRL_INIT = $0;
  EVP_CTRL_SET_KEY_LENGTH = $1;
  EVP_CTRL_GET_RC2_KEY_BITS = $2;
  EVP_CTRL_SET_RC2_KEY_BITS = $3;
  EVP_CTRL_GET_RC5_ROUNDS = $4;
  EVP_CTRL_SET_RC5_ROUNDS = $5;
  EVP_CTRL_RAND_KEY = $6;
  EVP_CTRL_PBE_PRF_NID = $7;
  EVP_CTRL_COPY = $8;
  EVP_CTRL_AEAD_SET_IVLEN = $9;
  EVP_CTRL_AEAD_GET_TAG = $10;
  EVP_CTRL_AEAD_SET_TAG = $11;
  EVP_CTRL_AEAD_SET_IV_FIXED = $12;
  EVP_CTRL_GCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN;
  EVP_CTRL_GCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG;
  EVP_CTRL_GCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG;
  EVP_CTRL_GCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED;
  EVP_CTRL_GCM_IV_GEN = $13;
  EVP_CTRL_CCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN;
  EVP_CTRL_CCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG;
  EVP_CTRL_CCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG;
  EVP_CTRL_CCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED;
  EVP_CTRL_CCM_SET_L = $14;
  EVP_CTRL_CCM_SET_MSGLEN = $15;
//
 // AEAD cipher deduces payload length and returns number of bytes required to
 // store MAC and eventual padding. Subsequent call to EVP_Cipher even
 // appends/verifies MAC.
 ///
  EVP_CTRL_AEAD_TLS1_AAD = $16;
// Used by composite AEAD ciphers; no-op in GCM; CCM... ///
  EVP_CTRL_AEAD_SET_MAC_KEY = $17;
// Set the GCM invocation field; decrypt only ///
  EVP_CTRL_GCM_SET_IV_INV = $18;

  EVP_CTRL_TLS1_1_MULTIBLOCK_AAD = $19;
  EVP_CTRL_TLS1_1_MULTIBLOCK_ENCRYPT = $1a;
  EVP_CTRL_TLS1_1_MULTIBLOCK_DECRYPT = $1b;
  EVP_CTRL_TLS1_1_MULTIBLOCK_MAX_BUFSIZE = $1c;

  EVP_CTRL_SSL3_MASTER_SECRET = $1d;

// EVP_CTRL_SET_SBOX takes the PIdAnsiChar// specifying S-boxes///
  EVP_CTRL_SET_SBOX = $1e;
//
// EVP_CTRL_SBOX_USED takes a 'TIdC_SIZET' and 'PIdAnsiChar//'; pointing at a
// pre-allocated buffer with specified size
///
  EVP_CTRL_SBOX_USED = $1f;
// EVP_CTRL_KEY_MESH takes 'TIdC_SIZET' number of bytes to mesh the key after;
// 0 switches meshing off
///
  EVP_CTRL_KEY_MESH = $20;
// EVP_CTRL_BLOCK_PADDING_MODE takes the padding mode///
  EVP_CTRL_BLOCK_PADDING_MODE = $21;

// Set the output buffers to use for a pipelined operation///
  EVP_CTRL_SET_PIPELINE_OUTPUT_BUFS = $22;
// Set the input buffers to use for a pipelined operation///
  EVP_CTRL_SET_PIPELINE_INPUT_BUFS = $23;
// Set the input buffer lengths to use for a pipelined operation///
  EVP_CTRL_SET_PIPELINE_INPUT_LENS = $24;

  EVP_CTRL_GET_IVLEN = $25;

// Padding modes///
  EVP_PADDING_PKCS7 = 1;
  EVP_PADDING_ISO7816_4 = 2;
  EVP_PADDING_ANSI923 = 3;
  EVP_PADDING_ISO10126 = 4;
  EVP_PADDING_ZERO = 5;

// RFC 5246 defines additional data to be 13 bytes in length///
  EVP_AEAD_TLS1_AAD_LEN = 13;

// GCM TLS constants///
// Length of fixed part of IV derived from PRF///
  EVP_GCM_TLS_FIXED_IV_LEN = 4;
// Length of explicit part of IV part of TLS records///
  EVP_GCM_TLS_EXPLICIT_IV_LEN = 8;
// Length of tag for TLS
  EVP_GCM_TLS_TAG_LEN = 16;

/// CCM TLS constants ///
/// Length of fixed part of IV derived from PRF ///
  EVP_CCM_TLS_FIXED_IV_LEN = 4;
/// Length of explicit part of IV part of TLS records ///
  EVP_CCM_TLS_EXPLICIT_IV_LEN = 8;
/// Total length of CCM IV length for TLS ///
  EVP_CCM_TLS_IV_LEN = 12;
/// Length of tag for TLS ///
  EVP_CCM_TLS_TAG_LEN = 16;
/// Length of CCM8 tag for TLS ///
  EVP_CCM8_TLS_TAG_LEN = 8;

/// Length of tag for TLS ///
  EVP_CHACHAPOLY_TLS_TAG_LEN = 16;

(* Can appear as the outermost AlgorithmIdentifier *)
  EVP_PBE_TYPE_OUTER = $0;
(* Is an PRF type OID *)
  EVP_PBE_TYPE_PRF = $1;
(* Is a PKCS#5 v2.0 KDF *)
  EVP_PBE_TYPE_KDF = $2;

  ASN1_PKEY_ALIAS = $1;
  ASN1_PKEY_DYNAMIC = $2;
  ASN1_PKEY_SIGPARAM_NULL = $4;

  ASN1_PKEY_CTRL_PKCS7_SIGN = $1;
  ASN1_PKEY_CTRL_PKCS7_ENCRYPT = $2;
  ASN1_PKEY_CTRL_DEFAULT_MD_NID = $3;
  ASN1_PKEY_CTRL_CMS_SIGN = $5;
  ASN1_PKEY_CTRL_CMS_ENVELOPE = $7;
  ASN1_PKEY_CTRL_CMS_RI_TYPE = $8;

  ASN1_PKEY_CTRL_SET1_TLS_ENCPT = $9;
  ASN1_PKEY_CTRL_GET1_TLS_ENCPT = $a;

  EVP_PKEY_OP_UNDEFINED = 0;
  EVP_PKEY_OP_PARAMGEN = (1 shl 1);
  EVP_PKEY_OP_KEYGEN = (1 shl 2);
  EVP_PKEY_OP_SIGN = (1 shl 3);
  EVP_PKEY_OP_VERIFY = (1 shl 4);
  EVP_PKEY_OP_VERIFYRECOVER = (1 shl 5);
  EVP_PKEY_OP_SIGNCTX = (1 shl 6);
  EVP_PKEY_OP_VERIFYCTX = (1 shl 7);
  EVP_PKEY_OP_ENCRYPT = (1 shl 8);
  EVP_PKEY_OP_DECRYPT = (1 shl 9);
  EVP_PKEY_OP_DERIVE = (1 shl 10);

  EVP_PKEY_OP_TYPE_SIG = EVP_PKEY_OP_SIGN or EVP_PKEY_OP_VERIFY
    or EVP_PKEY_OP_VERIFYRECOVER or EVP_PKEY_OP_SIGNCTX or EVP_PKEY_OP_VERIFYCTX;

  EVP_PKEY_OP_TYPE_CRYPT = EVP_PKEY_OP_ENCRYPT or EVP_PKEY_OP_DECRYPT;

  EVP_PKEY_OP_TYPE_NOGEN = EVP_PKEY_OP_TYPE_SIG or EVP_PKEY_OP_TYPE_CRYPT or EVP_PKEY_OP_DERIVE;

  EVP_PKEY_OP_TYPE_GEN = EVP_PKEY_OP_PARAMGEN or EVP_PKEY_OP_KEYGEN;

  EVP_PKEY_CTRL_MD = 1;
  EVP_PKEY_CTRL_PEER_KEY = 2;

  EVP_PKEY_CTRL_PKCS7_ENCRYPT = 3;
  EVP_PKEY_CTRL_PKCS7_DECRYPT = 4;

  EVP_PKEY_CTRL_PKCS7_SIGN = 5;

  EVP_PKEY_CTRL_SET_MAC_KEY = 6;

  EVP_PKEY_CTRL_DIGESTINIT = 7;

(* Used by GOST key encryption in TLS *)
  EVP_PKEY_CTRL_SET_IV = 8;

  EVP_PKEY_CTRL_CMS_ENCRYPT = 9;
  EVP_PKEY_CTRL_CMS_DECRYPT = 10;
  EVP_PKEY_CTRL_CMS_SIGN = 11;

  EVP_PKEY_CTRL_CIPHER = 12;

  EVP_PKEY_CTRL_GET_MD = 13;

  EVP_PKEY_CTRL_SET_DIGEST_SIZE = 14;

  EVP_PKEY_ALG_CTRL = $1000;

  EVP_PKEY_FLAG_AUTOARGLEN = 2;
  //
 // Method handles all operations: don't assume any digest related defaults.
 //
  EVP_PKEY_FLAG_SIGCTX_CUSTOM = 4;

type
  EVP_MD_meth_init = function(ctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  EVP_MD_meth_update = function(ctx: PEVP_MD_CTX; const data: Pointer;
    count: TIdC_SIZET): TIdC_INT; cdecl;
  EVP_MD_meth_final = function(ctx: PEVP_MD_CTX; const md: PByte): TIdC_INT; cdecl;
  EVP_MD_meth_copy = function(&to: PEVP_MD_CTX; const from: PEVP_MD_CTX): TIdC_INT; cdecl;
  EVP_MD_meth_cleanup = function(ctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  EVP_MD_meth_ctrl = function(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT;
    p2: Pointer): TIdC_INT; cdecl;

  EVP_CIPHER_meth_init = function(ctx: PEVP_CIPHER_CTX; const key: PByte;
    const iv: PByte; enc: TIdC_SIZET): TIdC_INT; cdecl;
  EVP_CIPHER_meth_do_cipher = function(ctx: PEVP_CIPHER_CTX; out_: PByte;
    const in_: PByte; inl: TIdC_SIZET): TIdC_INT; cdecl;
  EVP_CIPHER_meth_cleanup = function(v1: PEVP_CIPHER_CTX): TIdC_INT; cdecl;
  EVP_CIPHER_meth_set_asn1_params = function(v1: PEVP_CIPHER_CTX;
    v2: PASN1_TYPE): TIdC_INT; cdecl;
  EVP_CIPHER_meth_get_asn1_params = function(v1: PEVP_CIPHER_CTX;
    v2: PASN1_TYPE): TIdC_INT; cdecl;
  EVP_CIPHER_meth_ctrl = function(v1: PEVP_CIPHER_CTX; type_: TIdC_INT;
    arg: TIdC_INT; ptr: Pointer): TIdC_INT; cdecl;

  EVP_CTRL_TLS1_1_MULTIBLOCK_PARAM = record
    out_: PByte;
    inp: PByte;
    len: TIdC_SIZET;
    interleave: TidC_UINT;
  end;

  evp_cipher_info_st = record
    cipher: PEVP_CIPHER;
    iv: array[0 .. EVP_MAX_IV_LENGTH - 1] of PByte;
  end;
  EVP_CIPHER_INFO = evp_cipher_info_st;

  EVP_MD_CTX_update = function(ctx: PEVP_MD_CTX; const data: Pointer; count: TIdC_SIZET): TIdC_INT; cdecl;

  fn = procedure(const ciph: PEVP_CIPHER; const from: PIdAnsiChar; const to_: PIdAnsiChar; x: Pointer); cdecl;

  pub_decode = function(pk: PEVP_PKEY; pub: PX509_PUBKEY): TIdC_INT; cdecl;
  pub_encode = function(pub: PX509_PUBKEY; const pk: PEVP_PKEY): TIdC_INT; cdecl;
  pub_cmd = function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT; cdecl;
  pub_print = function(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;
  pkey_size = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  pkey_bits = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;

  priv_decode = function(pk: PEVP_PKEY; const p8inf: PKCS8_PRIV_KEY_INFO): TIdC_INT; cdecl;
  priv_encode = function(p8: PPKCS8_PRIV_KEY_INFO; const pk: PEVP_PKEY): TIdC_INT; cdecl;
  priv_print = function(&out: PBIO; const pkea: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;

  param_decode = function(pkey: PEVP_PKEY; const pder: PPByte; derlen: TIdC_INT): TIdC_INT; cdecl;
  param_encode = function(const pkey: PEVP_PKEY; pder: PPByte): TIdC_INT; cdecl;
  param_missing = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  param_copy = function(&to: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT; cdecl;
  param_cmp = function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT; cdecl;
  param_print = function(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;

  pkey_free = procedure(pkey: PEVP_PKEY); cdecl;
  pkey_ctrl = function(pkey: PEVP_PKEY; op: TIdC_INT; arg1: TIdC_LONG; arg2: Pointer): TIdC_INT; cdecl;
  item_verify = function(ctx: PEVP_MD_CTX; const it: PASN1_ITEM; asn: Pointer;
    a: PX509_ALGOR; sig: PASN1_BIT_STRING; pkey: PEVP_PKEY): TIdC_INT; cdecl;
  item_sign = function(ctx: PEVP_MD_CTX; const it: PASN1_ITEM; asn: Pointer;
    alg1: PX509_ALGOR; alg2: PX509_ALGOR; sig: PASN1_BIT_STRING): TIdC_INT; cdecl;
  siginf_set = function(siginf: PX509_SIG_INFO; const alg: PX509_ALGOR; const sig: PASN1_STRING): TIdC_INT; cdecl;
  pkey_check = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  pkey_pub_check = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  pkey_param_check = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  set_priv_key = function(pk: PEVP_PKEY; const priv: PByte; len: TIdC_SIZET): TIdC_INT; cdecl;
  set_pub_key = function(pk: PEVP_PKEY; const pub: PByte; len: TIdC_SIZET): TIdC_INT; cdecl;
  get_priv_key = function(const pk: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT; cdecl;
  get_pub_key = function(const pk: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT; cdecl;
  pkey_security_bits = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;

  EVP_PKEY_gen_cb = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
//  PEVP_PKEY_gen_cb = ^EVP_PKEY_gen_cb;

  EVP_PKEY_meth_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_init = ^EVP_PKEY_meth_init;
  EVP_PKEY_meth_copy_cb = function(dst: PEVP_PKEY_CTX; src: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_copy = ^EVP_PKEY_meth_copy_cb;
  EVP_PKEY_meth_cleanup = procedure(ctx: PEVP_PKEY_CTX); cdecl;
  PEVP_PKEY_meth_cleanup = ^EVP_PKEY_meth_cleanup;
  EVP_PKEY_meth_paramgen_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_paramgen_init = ^EVP_PKEY_meth_paramgen_init;
  EVP_PKEY_meth_paramgen = function(ctx: PEVP_PKEY_CTX; pkey: PEVP_PKEY): TIdC_INT; cdecl;
  PEVP_PKEY_meth_paramgen = ^EVP_PKEY_meth_paramgen;
  EVP_PKEY_meth_keygen_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_keygen_init = ^EVP_PKEY_meth_keygen_init;
  EVP_PKEY_meth_keygen = function(ctx: PEVP_PKEY_CTX; pkey: PEVP_PKEY): TIdC_INT; cdecl;
  PEVP_PKEY_meth_keygen = ^EVP_PKEY_meth_keygen;
  EVP_PKEY_meth_sign_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_sign_init = ^EVP_PKEY_meth_sign_init;
  EVP_PKEY_meth_sign = function(ctx: PEVP_PKEY_CTX; sig: PByte; siglen: TIdC_SIZET;
    const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_sign = ^EVP_PKEY_meth_sign;
  EVP_PKEY_meth_verify_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verify_init = ^EVP_PKEY_meth_verify_init;
  EVP_PKEY_meth_verify = function(ctx: PEVP_PKEY_CTX; const sig: PByte;
    siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verify = ^EVP_PKEY_meth_verify;
  EVP_PKEY_meth_verify_recover_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verify_recover_init = ^EVP_PKEY_meth_verify_recover_init;
  EVP_PKEY_meth_verify_recover = function(ctx: PEVP_PKEY_CTX; sig: PByte;
    siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verify_recover = ^EVP_PKEY_meth_verify_recover;
  EVP_PKEY_meth_signctx_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_signctx_init = ^EVP_PKEY_meth_signctx_init;
  EVP_PKEY_meth_signctx = function(ctx: PEVP_PKEY_CTX; sig: Pbyte;
    siglen: TIdC_SIZET; mctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_signctx = ^EVP_PKEY_meth_signctx;
  EVP_PKEY_meth_verifyctx_init = function(ctx: PEVP_PKEY_CTX; mctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verifyctx_init = ^EVP_PKEY_meth_verifyctx_init;
  EVP_PKEY_meth_verifyctx = function(ctx: PEVP_PKEY_CTX; const sig: PByte;
    siglen: TIdC_INT; mctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_verifyctx = ^EVP_PKEY_meth_verifyctx;
  EVP_PKEY_meth_encrypt_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_encrypt_init = ^EVP_PKEY_meth_encrypt_init;
  EVP_PKEY_meth_encrypt = function(ctx: PEVP_PKEY_CTX; out_: PByte;
    outlen: TIdC_SIZET; const in_: PByte): TIdC_INT; cdecl;
  PEVP_PKEY_meth_encrypt = ^ EVP_PKEY_meth_encrypt;
  EVP_PKEY_meth_decrypt_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_decrypt_init = ^EVP_PKEY_meth_decrypt_init;
  EVP_PKEY_meth_decrypt = function(ctx: PEVP_PKEY_CTX; out_: PByte;
    outlen: TIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_decrypt = ^EVP_PKEY_meth_decrypt;
  EVP_PKEY_meth_derive_init = function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_derive_init = ^EVP_PKEY_meth_derive_init;
  EVP_PKEY_meth_derive = function(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_derive = ^EVP_PKEY_meth_derive;
  EVP_PKEY_meth_ctrl = function(ctx: PEVP_PKEY_CTX; type_: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT; cdecl;
  PEVP_PKEY_meth_ctrl = ^EVP_PKEY_meth_ctrl;
  EVP_PKEY_meth_ctrl_str = function(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_ctrl_str = ^EVP_PKEY_meth_ctrl_str;
  EVP_PKEY_meth_digestsign = function(ctx: PEVP_PKEY_CTX; sig: PByte;
    siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_digestsign = ^EVP_PKEY_meth_digestsign;
  EVP_PKEY_meth_digestverify = function(ctx: PEVP_MD_CTX; const sig: PByte;
    siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl;
  PEVP_PKEY_meth_digestverify = ^EVP_PKEY_meth_digestverify;
  EVP_PKEY_meth_check = function(pkey: PEVP_PKEY): TIdC_INT; cdecl;
  PEVP_PKEY_meth_check = ^EVP_PKEY_meth_check;
  EVP_PKEY_meth_public_check = function(pkey: PEVP_PKEY): TIdC_INT; cdecl;
  PEVP_PKEY_meth_public_check = ^EVP_PKEY_meth_public_check;
  EVP_PKEY_meth_param_check = function(pkey: PEVP_PKEY): TIdC_INT; cdecl;
  PEVP_PKEY_meth_param_check = ^EVP_PKEY_meth_param_check;
  EVP_PKEY_meth_digest_custom = function(pkey: PEVP_PKEY; mctx: PEVP_MD_CTX): TIdC_INT; cdecl;
  PEVP_PKEY_meth_digest_custom = ^EVP_PKEY_meth_digest_custom;

  // Password based encryption function
  EVP_PBE_KEYGEN = function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar;
    passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER;
    const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT; cdecl;
  PEVP_PBE_KEYGEN = ^EVP_PBE_KEYGEN;
  PPEVP_PBE_KEYGEN = ^PEVP_PBE_KEYGEN;

function EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT;
function EVP_PKEY_assign_DSA(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT;
function EVP_PKEY_assign_DH(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT;
function EVP_PKEY_assign_EC_KEY(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT;
function EVP_PKEY_assign_SIPHASH(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT;
function EVP_PKEY_assign_POLY1305(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  EVP_MD_meth_new: function(md_type: TIdC_INT; pkey_type: TIdC_INT): PEVP_MD cdecl = nil;
  EVP_MD_meth_dup: function(const md: PEVP_MD): PEVP_MD cdecl = nil;
  EVP_MD_meth_free: procedure(md: PEVP_MD) cdecl = nil;

  EVP_MD_meth_set_input_blocksize: function(md: PEVP_MD; blocksize: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_result_size: function(md: PEVP_MD; resultsize: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_app_datasize: function(md: PEVP_MD; datasize: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_flags: function(md: PEVP_MD; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_init: function(md: PEVP_MD; init: EVP_MD_meth_init): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_update: function(md: PEVP_MD; update: EVP_MD_meth_update): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_final: function(md: PEVP_MD; final_: EVP_MD_meth_final): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_copy: function(md: PEVP_MD; copy: EVP_MD_meth_copy): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_cleanup: function(md: PEVP_MD; cleanup: EVP_MD_meth_cleanup): TIdC_INT cdecl = nil;
  EVP_MD_meth_set_ctrl: function(md: PEVP_MD; ctrl: EVP_MD_meth_ctrl): TIdC_INT cdecl = nil;

  EVP_MD_meth_get_input_blocksize: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_meth_get_result_size: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_meth_get_app_datasize: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_meth_get_flags: function(const md: PEVP_MD): TIdC_ULONG cdecl = nil;
  EVP_MD_meth_get_init: function(const md: PEVP_MD): EVP_MD_meth_init cdecl = nil;
  EVP_MD_meth_get_update: function(const md: PEVP_MD): EVP_MD_meth_update cdecl = nil;
  EVP_MD_meth_get_final: function(const md: PEVP_MD): EVP_MD_meth_final cdecl = nil;
  EVP_MD_meth_get_copy: function(const md: PEVP_MD): EVP_MD_meth_copy cdecl = nil;
  EVP_MD_meth_get_cleanup: function(const md: PEVP_MD): EVP_MD_meth_cleanup cdecl = nil;
  EVP_MD_meth_get_ctrl: function(const md: PEVP_MD): EVP_MD_meth_ctrl cdecl = nil;

  EVP_CIPHER_meth_new: function(cipher_type: TIdC_INT; block_size: TIdC_INT; key_len: TIdC_INT): PEVP_CIPHER cdecl = nil;
  EVP_CIPHER_meth_dup: function(const cipher: PEVP_CIPHER): PEVP_CIPHER cdecl = nil;
  EVP_CIPHER_meth_free: procedure(cipher: PEVP_CIPHER) cdecl = nil;

  EVP_CIPHER_meth_set_iv_length: function(cipher: PEVP_CIPHER; iv_len: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_flags: function(cipher: PEVP_CIPHER; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_impl_ctx_size: function(cipher: PEVP_CIPHER; ctx_size: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_init: function(cipher: PEVP_CIPHER; init: EVP_CIPHER_meth_init): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_do_cipher: function(cipher: PEVP_CIPHER; do_cipher: EVP_CIPHER_meth_do_cipher): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_cleanup: function(cipher: PEVP_CIPHER; cleanup: EVP_CIPHER_meth_cleanup): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_set_asn1_params: function(cipher: PEVP_CIPHER; set_asn1_parameters: EVP_CIPHER_meth_set_asn1_params): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_get_asn1_params: function(cipher: PEVP_CIPHER; get_asn1_parameters: EVP_CIPHER_meth_get_asn1_params): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_set_ctrl: function(cipher: PEVP_CIPHER; ctrl: EVP_CIPHER_meth_ctrl): TIdC_INT cdecl = nil;
  EVP_CIPHER_meth_get_init: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_init cdecl = nil;
  EVP_CIPHER_meth_get_do_cipher: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_do_cipher cdecl = nil;
  EVP_CIPHER_meth_get_cleanup: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_cleanup cdecl = nil;
  EVP_CIPHER_meth_get_set_asn1_params: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_set_asn1_params cdecl = nil;
  EVP_CIPHER_meth_get_get_asn1_params: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_get_asn1_params cdecl = nil;
  EVP_CIPHER_meth_get_ctrl: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_ctrl cdecl = nil;

  /// Add some extra combinations ///
  //# define EVP_get_digestbynid(a) EVP_get_digestbyname(OBJ_nid2sn(a));
  //# define EVP_get_digestbyobj(a) EVP_get_digestbynid(OBJ_obj2nid(a));
  //# define EVP_get_cipherbynid(a) EVP_get_cipherbyname(OBJ_nid2sn(a));
  //# define EVP_get_cipherbyobj(a) EVP_get_cipherbynid(OBJ_obj2nid(a));

  EVP_MD_type: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  //# define EVP_MD_nid(e)                   EVP_MD_type(e)
  //# define EVP_MD_name(e)                  OBJ_nid2sn(EVP_MD_nid(e))
  EVP_MD_pkey_type: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_size: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_block_size: function(const md: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_MD_flags: function(const md: PEVP_MD): PIdC_ULONG cdecl = nil;

  EVP_MD_CTX_md: function(ctx: PEVP_MD_CTX): PEVP_MD cdecl = nil;
  EVP_MD_CTX_update_fn: function(ctx: PEVP_MD_CTX): EVP_MD_CTX_update cdecl = nil;
  EVP_MD_CTX_set_update_fn: procedure(ctx: PEVP_MD_CTX; update: EVP_MD_CTX_update) cdecl = nil;
  //  EVP_MD_CTX_size(e)              EVP_MD_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_block_size(e)        EVP_MD_block_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_type(e)              EVP_MD_type(EVP_MD_CTX_md(e))
  EVP_MD_CTX_pkey_ctx: function(const ctx: PEVP_MD_CTX): PEVP_PKEY_CTX cdecl = nil;
  EVP_MD_CTX_set_pkey_ctx: procedure(ctx: PEVP_MD_CTX; pctx: PEVP_PKEY_CTX) cdecl = nil;
  EVP_MD_CTX_md_data: function(const ctx: PEVP_MD_CTX): Pointer cdecl = nil;

  EVP_CIPHER_nid: function(const ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;
  //# define EVP_CIPHER_name(e)              OBJ_nid2sn(EVP_CIPHER_nid(e))
  EVP_CIPHER_block_size: function(const cipher: PEVP_CIPHER): TIdC_INT cdecl = nil;
  EVP_CIPHER_impl_ctx_size: function(const cipher: PEVP_CIPHER): TIdC_INT cdecl = nil;
  EVP_CIPHER_key_length: function(const cipher: PEVP_CIPHER): TIdC_INT cdecl = nil;
  EVP_CIPHER_iv_length: function(const cipher: PEVP_CIPHER): TIdC_INT cdecl = nil;
  EVP_CIPHER_flags: function(const cipher: PEVP_CIPHER): TIdC_ULONG cdecl = nil;
  //# define EVP_CIPHER_mode(e)              (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)

  EVP_CIPHER_CTX_cipher: function(const ctx: PEVP_CIPHER_CTX): PEVP_CIPHER cdecl = nil;
  EVP_CIPHER_CTX_encrypting: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_nid: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_block_size: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_key_length: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_iv_length: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_iv: function(const ctx: PEVP_CIPHER_CTX): PByte cdecl = nil;
  EVP_CIPHER_CTX_original_iv: function(const ctx: PEVP_CIPHER_CTX): PByte cdecl = nil;
  EVP_CIPHER_CTX_iv_noconst: function(ctx: PEVP_CIPHER_CTX): PByte cdecl = nil;
  EVP_CIPHER_CTX_buf_noconst: function(ctx: PEVP_CIPHER_CTX): PByte cdecl = nil;
  EVP_CIPHER_CTX_num: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_set_num: procedure(ctx: PEVP_CIPHER_CTX; num: TIdC_INT) cdecl = nil;
  EVP_CIPHER_CTX_copy: function(&out: PEVP_CIPHER_CTX; const in_: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_get_app_data: function(const ctx: PEVP_CIPHER_CTX): Pointer cdecl = nil;
  EVP_CIPHER_CTX_set_app_data: procedure(ctx: PEVP_CIPHER_CTX; data: Pointer) cdecl = nil;
  EVP_CIPHER_CTX_get_cipher_data: function(const ctx: PEVP_CIPHER_CTX): Pointer cdecl = nil;
  EVP_CIPHER_CTX_set_cipher_data: function(ctx: PEVP_CIPHER_CTX; cipher_data: Pointer): Pointer cdecl = nil;

  //# define EVP_CIPHER_CTX_type(c)         EVP_CIPHER_type(EVP_CIPHER_CTX_cipher(c))
  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define EVP_CIPHER_CTX_flags(c)       EVP_CIPHER_flags(EVP_CIPHER_CTX_cipher(c))
  //# endif
  //# define EVP_CIPHER_CTX_mode(c)         EVP_CIPHER_mode(EVP_CIPHER_CTX_cipher(c))
  //
  //# define EVP_ENCODE_LENGTH(l)    ((((l)+2)/3*4)+((l)/48+1)*2+80)
  //# define EVP_DECODE_LENGTH(l)    (((l)+3)/4*3+80)
  //
  //# define EVP_SignInit_ex(a;b;c)          EVP_DigestInit_ex(a;b;c)
  //# define EVP_SignInit(a;b)               EVP_DigestInit(a;b)
  //# define EVP_SignUpdate(a;b;c)           EVP_DigestUpdate(a;b;c)
  //# define EVP_VerifyInit_ex(a;b;c)        EVP_DigestInit_ex(a;b;c)
  //# define EVP_VerifyInit(a;b)             EVP_DigestInit(a;b)
  //# define EVP_VerifyUpdate(a;b;c)         EVP_DigestUpdate(a;b;c)
  //# define EVP_OpenUpdate(a;b;c;d;e)       EVP_DecryptUpdate(a;b;c;d;e)
  //# define EVP_SealUpdate(a;b;c;d;e)       EVP_EncryptUpdate(a;b;c;d;e)
  //# define EVP_DigestSignUpdate(a;b;c)     EVP_DigestUpdate(a;b;c)
  //# define EVP_DigestVerifyUpdate(a;b;c)   EVP_DigestUpdate(a;b;c)

  BIO_set_md: procedure(v1: PBIO; const md: PEVP_MD) cdecl = nil;
  //# define BIO_get_md(b;mdp)          BIO_ctrl(b;BIO_C_GET_MD;0;(PIdAnsiChar)(mdp))
  //# define BIO_get_md_ctx(b;mdcp)     BIO_ctrl(b;BIO_C_GET_MD_CTX;0; (PIdAnsiChar)(mdcp))
  //# define BIO_set_md_ctx(b;mdcp)     BIO_ctrl(b;BIO_C_SET_MD_CTX;0; (PIdAnsiChar)(mdcp))
  //# define BIO_get_cipher_status(b)   BIO_ctrl(b;BIO_C_GET_CIPHER_STATUS;0;NULL)
  //# define BIO_get_cipher_ctx(b;c_pp) BIO_ctrl(b;BIO_C_GET_CIPHER_CTX;0; (PIdAnsiChar)(c_pp))

  //function EVP_Cipher(c: PEVP_CIPHER_CTX; out_: PByte; const in_: PByte; in1: TIdC_UINT): TIdC_INT;

  //# define EVP_add_cipher_alias(n;alias) OBJ_NAME_add((alias);OBJ_NAME_TYPE_CIPHER_METH|OBJ_NAME_ALIAS;(n))
  //# define EVP_add_digest_alias(n;alias) OBJ_NAME_add((alias);OBJ_NAME_TYPE_MD_METH|OBJ_NAME_ALIAS;(n))
  //# define EVP_delete_cipher_alias(alias) OBJ_NAME_remove(alias;OBJ_NAME_TYPE_CIPHER_METH|OBJ_NAME_ALIAS);
  //# define EVP_delete_digest_alias(alias) OBJ_NAME_remove(alias;OBJ_NAME_TYPE_MD_METH|OBJ_NAME_ALIAS);

  EVP_MD_CTX_ctrl: function(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT cdecl = nil;
  EVP_MD_CTX_new: function: PEVP_MD_CTX cdecl = nil;
  EVP_MD_CTX_reset: function(ctx: PEVP_MD_CTX): TIdC_INT cdecl = nil;
  EVP_MD_CTX_free: procedure(ctx: PEVP_MD_CTX) cdecl = nil;
  //# define EVP_MD_CTX_create()     EVP_MD_CTX_new()
  //# define EVP_MD_CTX_init(ctx)    EVP_MD_CTX_reset((ctx))
  //# define EVP_MD_CTX_destroy(ctx) EVP_MD_CTX_free((ctx))
  EVP_MD_CTX_copy_ex: function(&out: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT cdecl = nil;
  EVP_MD_CTX_set_flags: procedure(ctx: PEVP_MD_CTX; flags: TIdC_INT) cdecl = nil;
  EVP_MD_CTX_clear_flags: procedure(ctx: PEVP_MD_CTX; flags: TIdC_INT) cdecl = nil;
  EVP_MD_CTX_test_flags: function(const ctx: PEVP_MD_CTX; flags: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_DigestInit_ex: function(ctx: PEVP_MD_CTX; const type_: PEVP_MD; impl: PENGINE): TIdC_INT cdecl = nil;
  EVP_DigestUpdate: function(ctx: PEVP_MD_CTX; const d: Pointer; cnt: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_DigestFinal_ex: function(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT cdecl = nil;
  EVP_Digest: function(const data: Pointer; count: TIdC_SIZET; md: PByte; size: PIdC_UINT; const type_: PEVP_MD; impl: PENGINE): TIdC_INT cdecl = nil;

  EVP_MD_CTX_copy: function(&out: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT cdecl = nil;
  EVP_DigestInit: function(ctx: PEVP_MD_CTX; const type_: PEVP_MD): TIdC_INT cdecl = nil;
  EVP_DigestFinal: function(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT cdecl = nil;
  EVP_DigestFinalXOF: function(ctx: PEVP_MD_CTX; md: PByte; len: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_read_pw_string: function(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_read_pw_string_min: function(buf: PIdAnsiChar; minlen: TIdC_INT; maxlen: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_set_pw_prompt: procedure(const prompt: PIdAnsiChar) cdecl = nil;
  EVP_get_pw_prompt: function: PIdAnsiChar cdecl = nil;
  EVP_BytesToKey: function(const type_: PEVP_CIPHER; const md: PEVP_MD; const salt: PByte; const data: PByte; data1: TIdC_INT; count: TIdC_INT; key: PByte; iv: PByte): TIdC_INT cdecl = nil;

  EVP_CIPHER_CTX_set_flags: procedure(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT) cdecl = nil;
  EVP_CIPHER_CTX_clear_flags: procedure(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT) cdecl = nil;
  EVP_CIPHER_CTX_test_flags: function(const ctx: PEVP_CIPHER_CTX; flags: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_EncryptInit: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte): TIdC_INT cdecl = nil;
  EVP_EncryptInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT cdecl = nil;
  EVP_EncryptUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; &in1: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_EncryptFinal_ex: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;
  EVP_EncryptFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_DecryptInit: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PidC_INT): TIdC_INT cdecl = nil;
  EVP_DecryptInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT cdecl = nil;
  EVP_DecryptUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; &in1: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_DecryptFinal: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;
  EVP_DecryptFinal_ex: function(ctx: PEVP_MD_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_CipherInit: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte; enc: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CipherInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte; enc: TidC_INT): TIdC_INT cdecl = nil;
  EVP_CipherUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CipherFinal: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;
  EVP_CipherFinal_ex: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_SignFinal: function(ctx: PEVP_CIPHER_CTX; md: PByte; s: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  EVP_DigestSign: function(ctx: PEVP_CIPHER_CTX; sigret: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_VerifyFinal: function(ctx: PEVP_MD_CTX; const sigbuf: PByte; siglen: TIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;

  EVP_DigestVerify: function(ctx: PEVP_CIPHER_CTX; const sigret: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_DigestSignInit: function(ctx: PEVP_MD_CTX; pctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_DigestSignFinal: function(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_DigestVerifyInit: function(ctx: PEVP_MD_CTX; ppctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_DigestVerifyFinal: function(ctx: PEVP_MD_CTX; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_OpenInit: function(ctx: PEVP_CIPHER_CTX; const type_: PEVP_CIPHER; const ek: PByte; ek1: TIdC_INT; const iv: PByte; priv: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_OpenFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_SealInit: function(ctx: PEVP_CIPHER_CTX; const type_: EVP_CIPHER; ek: PPByte; ek1: PIdC_INT; iv: PByte; pubk: PPEVP_PKEY; npubk: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_SealFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_ENCODE_CTX_new: function: PEVP_ENCODE_CTX cdecl = nil;
  EVP_ENCODE_CTX_free: procedure(ctx: PEVP_ENCODE_CTX) cdecl = nil;
  EVP_ENCODE_CTX_copy: function(dctx: PEVP_ENCODE_CTX; sctx: PEVP_ENCODE_CTX): TIdC_INT cdecl = nil;
  EVP_ENCODE_CTX_num: function(ctx: PEVP_ENCODE_CTX): TIdC_INT cdecl = nil;
  EVP_EncodeInit: procedure(ctx: PEVP_ENCODE_CTX) cdecl = nil;
  EVP_EncodeUpdate: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_EncodeFinal: procedure(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT) cdecl = nil;
  EVP_EncodeBlock: function(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_DecodeInit: procedure(ctx: PEVP_ENCODE_CTX) cdecl = nil;
  EVP_DecodeUpdate: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_DecodeFinal: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl = nil;
  EVP_DecodeBlock: function(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_CIPHER_CTX_new: function: PEVP_CIPHER_CTX cdecl = nil;
  EVP_CIPHER_CTX_reset: function(c: PEVP_CIPHER_CTX): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_free: procedure(c: PEVP_CIPHER_CTX) cdecl = nil;
  EVP_CIPHER_CTX_set_key_length: function(x: PEVP_CIPHER_CTX; keylen: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_set_padding: function(c: PEVP_CIPHER_CTX; pad: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_ctrl: function(ctx: PEVP_CIPHER_CTX; type_: TIdC_INT; arg: TIdC_INT; ptr: Pointer): TIdC_INT cdecl = nil;
  EVP_CIPHER_CTX_rand_key: function(ctx: PEVP_CIPHER_CTX; key: PByte): TIdC_INT cdecl = nil;

  BIO_f_md: function: PBIO_METHOD cdecl = nil;
  BIO_f_base64: function: PBIO_METHOD cdecl = nil;
  BIO_f_cipher: function: PBIO_METHOD cdecl = nil;
  BIO_f_reliable: function: PBIO_METHOD cdecl = nil;
  BIO_set_cipher: function(b: PBIO; c: PEVP_CIPHER; const k: PByte; const i: PByte; enc: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_md_null: function: PEVP_MD cdecl = nil;

  EVP_md5: function: PEVP_MD cdecl = nil;
  EVP_md5_sha1: function: PEVP_MD cdecl = nil;

  EVP_sha1: function: PEVP_MD cdecl = nil;
  EVP_sha224: function: PEVP_MD cdecl = nil;
  EVP_sha256: function: PEVP_MD cdecl = nil;
  EVP_sha384: function: PEVP_MD cdecl = nil;
  EVP_sha512: function: PEVP_MD cdecl = nil;
  EVP_sha512_224: function: PEVP_MD cdecl = nil;
  EVP_sha512_256: function: PEVP_MD cdecl = nil;
  EVP_sha3_224: function: PEVP_MD cdecl = nil;
  EVP_sha3_256: function: PEVP_MD cdecl = nil;
  EVP_sha3_384: function: PEVP_MD cdecl = nil;
  EVP_sha3_512: function: PEVP_MD cdecl = nil;
  EVP_shake128: function: PEVP_MD cdecl = nil;
  EVP_shake256: function: PEVP_MD cdecl = nil;

  (* does nothing :-) *)
  EVP_enc_null: function: PEVP_CIPHER cdecl = nil;

  EVP_des_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_des_cfb EVP_des_cfb64
  EVP_des_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_des_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede_cfb64: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_des_ede3_cfb EVP_des_ede3_cfb64
  EVP_des_ede3_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_des_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_desx_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_des_ede3_wrap: function: PEVP_CIPHER cdecl = nil;
  //
  // This should now be supported through the dev_crypto ENGINE. But also, why
  // are rc4 and md5 declarations made here inside a "NO_DES" precompiler
  // branch?
  //
  EVP_rc4: function: PEVP_CIPHER cdecl = nil;
  EVP_rc4_40: function: PEVP_CIPHER cdecl = nil;
  EVP_idea_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_idea_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_idea_cfb EVP_idea_cfb64
  EVP_idea_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_idea_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_rc2_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_rc2_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_rc2_40_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_rc2_64_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_rc2_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_rc2_cfb EVP_rc2_cfb64
  EVP_rc2_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_bf_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_bf_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_bf_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_bf_cfb EVP_bf_cfb64
  EVP_bf_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_cast5_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_cast5_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_cast5_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_cast5_cfb EVP_cast5_cfb64
  EVP_cast5_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_rc5_32_12_16_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_rc5_32_12_16_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_rc5_32_12_16_cfb64: function: PEVP_CIPHER cdecl = nil;
  //EVP_rc5_32_12_16_cfb EVP_rc5_32_12_16_cfb64
  EVP_rc5_32_12_16_ofb: function: PEVP_CIPHER cdecl = nil;

  EVP_aes_128_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_aes_128_cfb EVP_aes_128_cfb128
  EVP_aes_128_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_ccm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_xts: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_wrap: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_wrap_pad: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_ocb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_aes_192_cfb EVP_aes_192_cfb128
  EVP_aes_192_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_ccm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_wrap: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_wrap_pad: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_192_ocb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_aes_256_cfb EVP_aes_256_cfb128
  EVP_aes_256_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_ccm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_xts: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_wrap: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_wrap_pad: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_ocb: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cbc_hmac_sha1: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cbc_hmac_sha1: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_128_cbc_hmac_sha256: function: PEVP_CIPHER cdecl = nil;
  EVP_aes_256_cbc_hmac_sha256: function: PEVP_CIPHER cdecl = nil;

  EVP_aria_128_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_cfb128: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_128_ccm: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_aria_192_cfb EVP_aria_192_cfb128
  EVP_aria_192_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_192_ccm: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_aria_256_cfb EVP_aria_256_cfb128
  EVP_aria_256_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_gcm: function: PEVP_CIPHER cdecl = nil;
  EVP_aria_256_ccm: function: PEVP_CIPHER cdecl = nil;

  EVP_camellia_128_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_128_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_128_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_128_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_128_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_camellia_128_cfb EVP_camellia_128_cfb128
  EVP_camellia_128_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_128_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_camellia_192_cfb EVP_camellia_192_cfb128
  EVP_camellia_192_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_192_ctr: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_cfb1: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_cfb8: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_camellia_256_cfb EVP_camellia_256_cfb128
  EVP_camellia_256_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_camellia_256_ctr: function: PEVP_CIPHER cdecl = nil;

  EVP_chacha20: function: PEVP_CIPHER cdecl = nil;
  EVP_chacha20_poly1305: function: PEVP_CIPHER cdecl = nil;

  EVP_seed_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_seed_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_seed_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_seed_cfb EVP_seed_cfb128
  EVP_seed_ofb: function: PEVP_CIPHER cdecl = nil;

  EVP_sm4_ecb: function: PEVP_CIPHER cdecl = nil;
  EVP_sm4_cbc: function: PEVP_CIPHER cdecl = nil;
  EVP_sm4_cfb128: function: PEVP_CIPHER cdecl = nil;
  //EVP_sm4_cfb EVP_sm4_cfb128
  EVP_sm4_ofb: function: PEVP_CIPHER cdecl = nil;
  EVP_sm4_ctr: function: PEVP_CIPHER cdecl = nil;

  EVP_add_cipher: function(const cipher: PEVP_CIPHER): TIdC_INT cdecl = nil;
  EVP_add_digest: function(const digest: PEVP_MD): TIdC_INT cdecl = nil;

  EVP_get_cipherbyname: function(const name: PIdAnsiChar): PEVP_CIPHER cdecl = nil;
  EVP_get_digestbyname: function(const name: PIdAnsiChar): PEVP_MD cdecl = nil;

  EVP_CIPHER_do_all: procedure(AFn: fn; arg: Pointer) cdecl = nil;
  EVP_CIPHER_do_all_sorted: procedure(AFn: fn; arg: Pointer) cdecl = nil;

  EVP_MD_do_all: procedure(AFn: fn; arg: Pointer) cdecl = nil;
  EVP_MD_do_all_sorted: procedure(AFn: fn; arg: Pointer) cdecl = nil;

  EVP_PKEY_decrypt_old: function(dec_key: PByte; const enc_key: PByte; enc_key_len: TIdC_INT; private_key: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_encrypt_old: function(dec_key: PByte; const enc_key: PByte; key_len: TIdC_INT; pub_key: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_type: function(&type: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_id: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_base_id: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_bits: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_security_bits: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_size: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_set_type: function(pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_set_type_str: function(pkey: PEVP_PKEY; const str: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_set_alias_type: function(pkey: PEVP_PKEY; type_: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_PKEY_set1_engine: function(pkey: PEVP_PKEY; e: PENGINE): TIdC_INT cdecl = nil;
  EVP_PKEY_get0_engine: function(const pkey: PEVP_PKEY): PENGINE cdecl = nil;

  EVP_PKEY_assign: function(pkey: PEVP_PKEY; type_: TIdC_INT; key: Pointer): TIdC_INT cdecl = nil;
  EVP_PKEY_get0: function(const pkey: PEVP_PKEY): Pointer cdecl = nil;
  EVP_PKEY_get0_hmac: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl = nil;
  EVP_PKEY_get0_poly1305: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl = nil;
  EVP_PKEY_get0_siphash: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl = nil;

  EVP_PKEY_set1_RSA: function(pkey: PEVP_PKEY; key: PRSA): TIdC_INT cdecl = nil;
  EVP_PKEY_get0_RSA: function(pkey: PEVP_PKEY): PRSA cdecl = nil;
  EVP_PKEY_get1_RSA: function(pkey: PEVP_PKEY): PRSA cdecl = nil;

  EVP_PKEY_set1_DSA: function(pkey: PEVP_PKEY; key: PDSA): TIdC_INT cdecl = nil;
  EVP_PKEY_get0_DSA: function(pkey: PEVP_PKEY): PDSA cdecl = nil;
  EVP_PKEY_get1_DSA: function(pkey: PEVP_PKEY): PDSA cdecl = nil;

  EVP_PKEY_set1_DH: function(pkey: PEVP_PKEY; key: PDH): TIdC_INT cdecl = nil;
  EVP_PKEY_get0_DH: function(pkey: PEVP_PKEY): PDH cdecl = nil;
  EVP_PKEY_get1_DH: function(pkey: PEVP_PKEY): PDH cdecl = nil;

  EVP_PKEY_set1_EC_KEY: function(pkey: PEVP_PKEY; key: PEC_KEY): TIdC_INT cdecl = nil;
  EVP_PKEY_get0_EC_KEY: function(pkey: PEVP_PKEY): PEC_KEY cdecl = nil;
  EVP_PKEY_get1_EC_KEY: function(pkey: PEVP_PKEY): PEC_KEY cdecl = nil;

  EVP_PKEY_new: function: PEVP_PKEY cdecl = nil;
  EVP_PKEY_up_ref: function(pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_free: procedure(pkey: PEVP_PKEY) cdecl = nil;

  d2i_PublicKey: function(&type: TIdC_INT; a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;
  i2d_PublicKey: function(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl = nil;

  d2i_PrivateKey: function(&type: TIdC_INT; a: PEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;
  d2i_AutoPrivateKey: function(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl = nil;
  i2d_PrivateKey: function(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl = nil;

  EVP_PKEY_copy_parameters: function(&to: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_missing_parameters: function(const pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_save_parameters: function(pkey: PEVP_PKEY; mode: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_cmp_parameters: function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT cdecl = nil;

  EVP_PKEY_cmp: function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT cdecl = nil;

  EVP_PKEY_print_public: function(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl = nil;
  EVP_PKEY_print_private: function(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl = nil;
  EVP_PKEY_print_params: function(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl = nil;

  EVP_PKEY_get_default_digest_nid: function(pkey: PEVP_PKEY; pnid: PIdC_INT): TIdC_INT cdecl = nil;

  EVP_PKEY_set1_tls_encodedpoint: function(pkey: PEVP_PKEY; const pt: PByte; ptlen: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_get1_tls_encodedpoint: function(pkey: PEVP_PKEY; ppt: PPByte): TIdC_SIZET cdecl = nil;

  EVP_CIPHER_type: function(const ctx: PEVP_CIPHER): TIdC_INT cdecl = nil;

  (* calls methods *)
  EVP_CIPHER_param_to_asn1: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl = nil;
  EVP_CIPHER_asn1_to_param: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl = nil;

  (* These are used by EVP_CIPHER methods *)
  EVP_CIPHER_set_asn1_iv: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl = nil;
  EVP_CIPHER_get_asn1_iv: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl = nil;

  (* PKCS5 password based encryption *)
  PKCS5_PBE_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS5_PBKDF2_HMAC_SHA1: function(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; keylen: TIdC_INT; out_: PByte): TIdC_INT cdecl = nil;
  PKCS5_PBKDF2_HMAC: function(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const digest: PEVP_MD; keylen: TIdC_INT; out_: PByte): TIdC_INT cdecl = nil;
  PKCS5_v2_PBE_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_PBE_scrypt: function(const pass: PIdAnsiChar; passlen: TIdC_SIZET; const salt: PByte; saltlen: TIdC_SIZET; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64; maxmem: TIdC_UINT64; key: PByte; keylen: TIdC_SIZET): TIdC_INT cdecl = nil;

  PKCS5_v2_scrypt_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const c: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl = nil;

  PKCS5_PBE_add: procedure cdecl = nil;

  EVP_PBE_CipherInit: function(pbe_obj: PASN1_OBJECT; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: TIdC_INT): TIdC_INT cdecl = nil;

  (* PBE type *)
  EVP_PBE_alg_add_type: function(pbe_type: TIdC_INT; pbe_nid: TIdC_INT; cipher_nid: TIdC_INT; md_nid: TIdC_INT; keygen: PEVP_PBE_KEYGEN): TIdC_INT cdecl = nil;
  EVP_PBE_alg_add: function(nid: TIdC_INT; const cipher: PEVP_CIPHER; const md: PEVP_MD; keygen: PEVP_PBE_KEYGEN): TIdC_INT cdecl = nil;
  EVP_PBE_find: function(&type: TIdC_INT; pbe_nid: TIdC_INT; pcnid: PIdC_INT; pmnid: PIdC_INT; pkeygen: PPEVP_PBE_KEYGEN): TIdC_INT cdecl = nil;
  EVP_PBE_cleanup: procedure cdecl = nil;
  EVP_PBE_get: function(ptype: PIdC_INT; ppbe_nid: PIdC_INT; num: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_PKEY_asn1_get_count: function: TIdC_INT cdecl = nil;
  EVP_PKEY_asn1_get0: function(idx: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl = nil;
  EVP_PKEY_asn1_find: function(pe: PPENGINE; type_: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl = nil;
  EVP_PKEY_asn1_find_str: function(pe: PPENGINE; const str: PIdAnsiChar; len: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl = nil;
  EVP_PKEY_asn1_add0: function(const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT cdecl = nil;
  EVP_PKEY_asn1_add_alias: function(&to: TIdC_INT; from: TIdC_INT): TIdC_INT cdecl = nil;
  EVP_PKEY_asn1_get0_info: function(ppkey_id: PIdC_INT; pkey_base_id: PIdC_INT; ppkey_flags: PIdC_INT; const pinfo: PPIdAnsiChar; const ppem_str: PPIdAnsiChar; const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT cdecl = nil;

  EVP_PKEY_get0_asn1: function(const pkey: PEVP_PKEY): PEVP_PKEY_ASN1_METHOD cdecl = nil;
  EVP_PKEY_asn1_new: function(id: TIdC_INT; flags: TIdC_INT; const pem_str: PIdAnsiChar; const info: PIdAnsiChar): PEVP_PKEY_ASN1_METHOD cdecl = nil;
  EVP_PKEY_asn1_copy: procedure(dst: PEVP_PKEY_ASN1_METHOD; const src: PEVP_PKEY_ASN1_METHOD) cdecl = nil;
  EVP_PKEY_asn1_free: procedure(ameth: PEVP_PKEY_ASN1_METHOD) cdecl = nil;

  EVP_PKEY_asn1_set_public: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APub_decode: pub_decode; APub_encode: pub_encode; APub_cmd: pub_cmd; APub_print: pub_print; APkey_size: pkey_size; APkey_bits: pkey_bits) cdecl = nil;
  EVP_PKEY_asn1_set_private: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APriv_decode: priv_decode; APriv_encode: priv_encode; APriv_print: priv_print) cdecl = nil;
  EVP_PKEY_asn1_set_param: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AParam_decode: param_decode; AParam_encode: param_encode; AParam_missing: param_missing; AParam_copy: param_copy; AParam_cmp: param_cmp; AParam_print: param_print) cdecl = nil;

  EVP_PKEY_asn1_set_free: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_free: pkey_free) cdecl = nil;
  EVP_PKEY_asn1_set_ctrl: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_ctrl: pkey_ctrl) cdecl = nil;
  EVP_PKEY_asn1_set_item: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AItem_verify: item_verify; AItem_sign: item_sign) cdecl = nil;

  EVP_PKEY_asn1_set_siginf: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASiginf_set: siginf_set) cdecl = nil;

  EVP_PKEY_asn1_set_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_check: pkey_check) cdecl = nil;

  EVP_PKEY_asn1_set_public_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_pub_check: pkey_pub_check) cdecl = nil;

  EVP_PKEY_asn1_set_param_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_param_check: pkey_param_check) cdecl = nil;

  EVP_PKEY_asn1_set_set_priv_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASet_priv_key: set_priv_key) cdecl = nil;
  EVP_PKEY_asn1_set_set_pub_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASet_pub_key: set_pub_key) cdecl = nil;
  EVP_PKEY_asn1_set_get_priv_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AGet_priv_key: get_priv_key) cdecl = nil;
  EVP_PKEY_asn1_set_get_pub_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AGet_pub_key: get_pub_key) cdecl = nil;

  EVP_PKEY_asn1_set_security_bits: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_security_bits: pkey_security_bits) cdecl = nil;

  EVP_PKEY_meth_find: function(&type: TIdC_INT): PEVP_PKEY_METHOD cdecl = nil;
  EVP_PKEY_meth_new: function(id: TIdC_INT; flags: TIdC_INT): PEVP_PKEY_METHOD cdecl = nil;
  EVP_PKEY_meth_get0_info: procedure(ppkey_id: PIdC_INT; pflags: PIdC_INT; const meth: PEVP_PKEY_METHOD) cdecl = nil;
  EVP_PKEY_meth_copy: procedure(dst: PEVP_PKEY_METHOD; const src: PEVP_PKEY_METHOD) cdecl = nil;
  EVP_PKEY_meth_free: procedure(pmeth: PEVP_PKEY_METHOD) cdecl = nil;
  EVP_PKEY_meth_add0: function(const pmeth: PEVP_PKEY_METHOD): TIdC_INT cdecl = nil;
  EVP_PKEY_meth_remove: function(const pmeth: PEVP_PKEY_METHOD): TIdC_INT cdecl = nil;
  EVP_PKEY_meth_get_count: function: TIdC_SIZET cdecl = nil;
  EVP_PKEY_meth_get0: function(idx: TIdC_SIZET): PEVP_PKEY_METHOD cdecl = nil;

  EVP_PKEY_CTX_new: function(pkey: PEVP_PKEY; e: PENGINE): PEVP_PKEY_CTX cdecl = nil;
  EVP_PKEY_CTX_new_id: function(id: TIdC_INT; e: PENGINE): PEVP_PKEY_CTX cdecl = nil;
  EVP_PKEY_CTX_dup: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY_CTX cdecl = nil;
  EVP_PKEY_CTX_free: procedure(ctx: PEVP_PKEY_CTX) cdecl = nil;

  EVP_PKEY_CTX_ctrl: function(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT cdecl = nil;
  EVP_PKEY_CTX_ctrl_str: function(ctx: PEVP_PKEY_CTX; const type_: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT cdecl = nil;
  EVP_PKEY_CTX_ctrl_uint64: function(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; value: TIdC_UINT64): TIdC_INT cdecl = nil;

  EVP_PKEY_CTX_str2ctrl: function(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const str: PIdAnsiChar): TIdC_INT cdecl = nil;
  EVP_PKEY_CTX_hex2ctrl: function(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const hex: PIdAnsiChar): TIdC_INT cdecl = nil;

  EVP_PKEY_CTX_md: function(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; const md: PIdAnsiChar): TIdC_INT cdecl = nil;

  EVP_PKEY_CTX_get_operation: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_CTX_set0_keygen_info: procedure(ctx: PEVP_PKEY_CTX; dat: PIdC_INT; datlen: TIdC_INT) cdecl = nil;

  EVP_PKEY_new_mac_key: function(&type: TIdC_INT; e: PENGINE; const key: PByte; keylen: TIdC_INT): PEVP_PKEY cdecl = nil;
  EVP_PKEY_new_raw_private_key: function(&type: TIdC_INT; e: PENGINE; const priv: PByte; len: TIdC_SIZET): PEVP_PKEY cdecl = nil;
  EVP_PKEY_new_raw_public_key: function(&type: TIdC_INT; e: PENGINE; const pub: PByte; len: TIdC_SIZET): PEVP_PKEY cdecl = nil;
  EVP_PKEY_get_raw_private_key: function(const pkey: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_get_raw_public_key: function(const pkey: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_PKEY_new_CMAC_key: function(e: PENGINE; const priv: PByte; len: TIdC_SIZET; const cipher: PEVP_CIPHER): PEVP_PKEY cdecl = nil;

  EVP_PKEY_CTX_set_data: procedure(ctx: PEVP_PKEY_CTX; data: Pointer) cdecl = nil;
  EVP_PKEY_CTX_get_data: function(ctx: PEVP_PKEY_CTX): Pointer cdecl = nil;
  EVP_PKEY_CTX_get0_pkey: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY cdecl = nil;

  EVP_PKEY_CTX_get0_peerkey: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY cdecl = nil;

  EVP_PKEY_CTX_set_app_data: procedure(ctx: PEVP_PKEY_CTX; data: Pointer) cdecl = nil;
  EVP_PKEY_CTX_get_app_data: function(ctx: PEVP_PKEY_CTX): Pointer cdecl = nil;

  EVP_PKEY_sign_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_sign: function(ctx: PEVP_PKEY_CTX; sig: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_verify_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_verify: function(ctx: PEVP_PKEY_CTX; const sig: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_verify_recover_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_verify_recover: function(ctx: PEVP_PKEY_CTX; rout: PByte; routlen: PIdC_SIZET; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_encrypt_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_encrypt: function(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT cdecl = nil;
  EVP_PKEY_decrypt_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_decrypt: function(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_PKEY_derive_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_derive_set_peer: function(ctx: PEVP_PKEY_CTX; peer: PEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_derive: function(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT cdecl = nil;

  EVP_PKEY_paramgen_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_paramgen: function(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_keygen_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_keygen: function(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT cdecl = nil;
  EVP_PKEY_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_public_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;
  EVP_PKEY_param_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl = nil;

  EVP_PKEY_CTX_set_cb: procedure(ctx: PEVP_PKEY_CTX; cb: EVP_PKEY_gen_cb) cdecl = nil;
  EVP_PKEY_CTX_get_cb: function(ctx: PEVP_PKEY_CTX): EVP_PKEY_gen_cb cdecl = nil;

  EVP_PKEY_CTX_get_keygen_info: function(ctx: PEVP_PKEY_CTX; idx: TIdC_INT): TIdC_INT cdecl = nil;

  EVP_PKEY_meth_set_init: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: EVP_PKEY_meth_init) cdecl = nil;

  EVP_PKEY_meth_set_copy: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy_cb: EVP_PKEY_meth_copy_cb) cdecl = nil;

  EVP_PKEY_meth_set_cleanup: procedure(pmeth: PEVP_PKEY_METHOD; PEVP_PKEY_meth_cleanup: EVP_PKEY_meth_cleanup) cdecl = nil;

  EVP_PKEY_meth_set_paramgen: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: EVP_PKEY_meth_paramgen_init) cdecl = nil;

  EVP_PKEY_meth_set_keygen: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: EVP_PKEY_meth_keygen) cdecl = nil;

  EVP_PKEY_meth_set_sign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: EVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: EVP_PKEY_meth_sign) cdecl = nil;

  EVP_PKEY_meth_set_verify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: EVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: EVP_PKEY_meth_verify_init) cdecl = nil;

  EVP_PKEY_meth_set_verify_recover: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: EVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: EVP_PKEY_meth_verify_recover_init) cdecl = nil;

  EVP_PKEY_meth_set_signctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: EVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: EVP_PKEY_meth_signctx) cdecl = nil;

  EVP_PKEY_meth_set_verifyctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: EVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: EVP_PKEY_meth_verifyctx) cdecl = nil;

  EVP_PKEY_meth_set_encrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: EVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: EVP_PKEY_meth_encrypt) cdecl = nil;

  EVP_PKEY_meth_set_decrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: EVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: EVP_PKEY_meth_decrypt) cdecl = nil;

  EVP_PKEY_meth_set_derive: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: EVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: EVP_PKEY_meth_derive) cdecl = nil;

  EVP_PKEY_meth_set_ctrl: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: EVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: EVP_PKEY_meth_ctrl_str) cdecl = nil;

  EVP_PKEY_meth_set_digestsign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: EVP_PKEY_meth_digestsign) cdecl = nil;

  EVP_PKEY_meth_set_digestverify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: EVP_PKEY_meth_digestverify) cdecl = nil;

  EVP_PKEY_meth_set_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: EVP_PKEY_meth_check) cdecl = nil;

  EVP_PKEY_meth_set_public_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: EVP_PKEY_meth_public_check) cdecl = nil;

  EVP_PKEY_meth_set_param_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: EVP_PKEY_meth_param_check) cdecl = nil;

  EVP_PKEY_meth_set_digest_custom: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: EVP_PKEY_meth_digest_custom) cdecl = nil;

  EVP_PKEY_meth_get_init: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: PEVP_PKEY_meth_init) cdecl = nil;

  EVP_PKEY_meth_get_copy: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy: PEVP_PKEY_meth_copy) cdecl = nil;

  EVP_PKEY_meth_get_cleanup: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_cleanup: PEVP_PKEY_meth_cleanup) cdecl = nil;

  EVP_PKEY_meth_get_paramgen: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: PEVP_PKEY_meth_paramgen) cdecl = nil;

  EVP_PKEY_meth_get_keygen: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: PEVP_PKEY_meth_keygen) cdecl = nil;

  EVP_PKEY_meth_get_sign: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: PEVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: PEVP_PKEY_meth_sign) cdecl = nil;

  EVP_PKEY_meth_get_verify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: PEVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: PEVP_PKEY_meth_verify_init) cdecl = nil;

  EVP_PKEY_meth_get_verify_recover: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: PEVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: PEVP_PKEY_meth_verify_recover_init) cdecl = nil;

  EVP_PKEY_meth_get_signctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: PEVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: PEVP_PKEY_meth_signctx) cdecl = nil;

  EVP_PKEY_meth_get_verifyctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: PEVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: PEVP_PKEY_meth_verifyctx) cdecl = nil;

  EVP_PKEY_meth_get_encrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: PEVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: PEVP_PKEY_meth_encrypt) cdecl = nil;

  EVP_PKEY_meth_get_decrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: PEVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: PEVP_PKEY_meth_decrypt) cdecl = nil;

  EVP_PKEY_meth_get_derive: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: PEVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: PEVP_PKEY_meth_derive) cdecl = nil;

  EVP_PKEY_meth_get_ctrl: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: PEVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: PEVP_PKEY_meth_ctrl_str) cdecl = nil;

  EVP_PKEY_meth_get_digestsign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: PEVP_PKEY_meth_digestsign) cdecl = nil;

  EVP_PKEY_meth_get_digestverify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: PEVP_PKEY_meth_digestverify) cdecl = nil;

  EVP_PKEY_meth_get_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: PEVP_PKEY_meth_check) cdecl = nil;

  EVP_PKEY_meth_get_public_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: PEVP_PKEY_meth_public_check) cdecl = nil;

  EVP_PKEY_meth_get_param_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: PEVP_PKEY_meth_param_check) cdecl = nil;

  EVP_PKEY_meth_get_digest_custom: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: PEVP_PKEY_meth_digest_custom) cdecl = nil;

  EVP_add_alg_module: procedure cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  EVP_MD_meth_new := LoadFunction('EVP_MD_meth_new', AFailed);
  EVP_MD_meth_dup := LoadFunction('EVP_MD_meth_dup', AFailed);
  EVP_MD_meth_free := LoadFunction('EVP_MD_meth_free', AFailed);
  EVP_MD_meth_set_input_blocksize := LoadFunction('EVP_MD_meth_set_input_blocksize', AFailed);
  EVP_MD_meth_set_result_size := LoadFunction('EVP_MD_meth_set_result_size', AFailed);
  EVP_MD_meth_set_app_datasize := LoadFunction('EVP_MD_meth_set_app_datasize', AFailed);
  EVP_MD_meth_set_flags := LoadFunction('EVP_MD_meth_set_flags', AFailed);
  EVP_MD_meth_set_init := LoadFunction('EVP_MD_meth_set_init', AFailed);
  EVP_MD_meth_set_update := LoadFunction('EVP_MD_meth_set_update', AFailed);
  EVP_MD_meth_set_final := LoadFunction('EVP_MD_meth_set_final', AFailed);
  EVP_MD_meth_set_copy := LoadFunction('EVP_MD_meth_set_copy', AFailed);
  EVP_MD_meth_set_cleanup := LoadFunction('EVP_MD_meth_set_cleanup', AFailed);
  EVP_MD_meth_set_ctrl := LoadFunction('EVP_MD_meth_set_ctrl', AFailed);
  EVP_MD_meth_get_input_blocksize := LoadFunction('EVP_MD_meth_get_input_blocksize', AFailed);
  EVP_MD_meth_get_result_size := LoadFunction('EVP_MD_meth_get_result_size', AFailed);
  EVP_MD_meth_get_app_datasize := LoadFunction('EVP_MD_meth_get_app_datasize', AFailed);
  EVP_MD_meth_get_flags := LoadFunction('EVP_MD_meth_get_flags', AFailed);
  EVP_MD_meth_get_init := LoadFunction('EVP_MD_meth_get_init', AFailed);
  EVP_MD_meth_get_update := LoadFunction('EVP_MD_meth_get_update', AFailed);
  EVP_MD_meth_get_final := LoadFunction('EVP_MD_meth_get_final', AFailed);
  EVP_MD_meth_get_copy := LoadFunction('EVP_MD_meth_get_copy', AFailed);
  EVP_MD_meth_get_cleanup := LoadFunction('EVP_MD_meth_get_cleanup', AFailed);
  EVP_MD_meth_get_ctrl := LoadFunction('EVP_MD_meth_get_ctrl', AFailed);
  EVP_CIPHER_meth_new := LoadFunction('EVP_CIPHER_meth_new', AFailed);
  EVP_CIPHER_meth_dup := LoadFunction('EVP_CIPHER_meth_dup', AFailed);
  EVP_CIPHER_meth_free := LoadFunction('EVP_CIPHER_meth_free', AFailed);
  EVP_CIPHER_meth_set_iv_length := LoadFunction('EVP_CIPHER_meth_set_iv_length', AFailed);
  EVP_CIPHER_meth_set_flags := LoadFunction('EVP_CIPHER_meth_set_flags', AFailed);
  EVP_CIPHER_meth_set_impl_ctx_size := LoadFunction('EVP_CIPHER_meth_set_impl_ctx_size', AFailed);
  EVP_CIPHER_meth_set_init := LoadFunction('EVP_CIPHER_meth_set_init', AFailed);
  EVP_CIPHER_meth_set_do_cipher := LoadFunction('EVP_CIPHER_meth_set_do_cipher', AFailed);
  EVP_CIPHER_meth_set_cleanup := LoadFunction('EVP_CIPHER_meth_set_cleanup', AFailed);
  EVP_CIPHER_meth_set_set_asn1_params := LoadFunction('EVP_CIPHER_meth_set_set_asn1_params', AFailed);
  EVP_CIPHER_meth_set_get_asn1_params := LoadFunction('EVP_CIPHER_meth_set_get_asn1_params', AFailed);
  EVP_CIPHER_meth_set_ctrl := LoadFunction('EVP_CIPHER_meth_set_ctrl', AFailed);
  EVP_CIPHER_meth_get_init := LoadFunction('EVP_CIPHER_meth_get_init', AFailed);
  EVP_CIPHER_meth_get_do_cipher := LoadFunction('EVP_CIPHER_meth_get_do_cipher', AFailed);
  EVP_CIPHER_meth_get_cleanup := LoadFunction('EVP_CIPHER_meth_get_cleanup', AFailed);
  EVP_CIPHER_meth_get_set_asn1_params := LoadFunction('EVP_CIPHER_meth_get_set_asn1_params', AFailed);
  EVP_CIPHER_meth_get_get_asn1_params := LoadFunction('EVP_CIPHER_meth_get_get_asn1_params', AFailed);
  EVP_CIPHER_meth_get_ctrl := LoadFunction('EVP_CIPHER_meth_get_ctrl', AFailed);
  EVP_MD_type := LoadFunction('EVP_MD_type', AFailed);
  EVP_MD_pkey_type := LoadFunction('EVP_MD_pkey_type', AFailed);
  EVP_MD_size := LoadFunction('EVP_MD_size', AFailed);
  EVP_MD_block_size := LoadFunction('EVP_MD_block_size', AFailed);
  EVP_MD_flags := LoadFunction('EVP_MD_flags', AFailed);
  EVP_MD_CTX_md := LoadFunction('EVP_MD_CTX_md', AFailed);
  EVP_MD_CTX_update_fn := LoadFunction('EVP_MD_CTX_update_fn', AFailed);
  EVP_MD_CTX_set_update_fn := LoadFunction('EVP_MD_CTX_set_update_fn', AFailed);
  EVP_MD_CTX_pkey_ctx := LoadFunction('EVP_MD_CTX_pkey_ctx', AFailed);
  EVP_MD_CTX_set_pkey_ctx := LoadFunction('EVP_MD_CTX_set_pkey_ctx', AFailed);
  EVP_MD_CTX_md_data := LoadFunction('EVP_MD_CTX_md_data', AFailed);
  EVP_CIPHER_nid := LoadFunction('EVP_CIPHER_nid', AFailed);
  EVP_CIPHER_block_size := LoadFunction('EVP_CIPHER_block_size', AFailed);
  EVP_CIPHER_impl_ctx_size := LoadFunction('EVP_CIPHER_impl_ctx_size', AFailed);
  EVP_CIPHER_key_length := LoadFunction('EVP_CIPHER_key_length', AFailed);
  EVP_CIPHER_iv_length := LoadFunction('EVP_CIPHER_iv_length', AFailed);
  EVP_CIPHER_flags := LoadFunction('EVP_CIPHER_flags', AFailed);
  EVP_CIPHER_CTX_cipher := LoadFunction('EVP_CIPHER_CTX_cipher', AFailed);
  EVP_CIPHER_CTX_encrypting := LoadFunction('EVP_CIPHER_CTX_encrypting', AFailed);
  EVP_CIPHER_CTX_nid := LoadFunction('EVP_CIPHER_CTX_nid', AFailed);
  EVP_CIPHER_CTX_block_size := LoadFunction('EVP_CIPHER_CTX_block_size', AFailed);
  EVP_CIPHER_CTX_key_length := LoadFunction('EVP_CIPHER_CTX_key_length', AFailed);
  EVP_CIPHER_CTX_iv_length := LoadFunction('EVP_CIPHER_CTX_iv_length', AFailed);
  EVP_CIPHER_CTX_iv := LoadFunction('EVP_CIPHER_CTX_iv', AFailed);
  EVP_CIPHER_CTX_original_iv := LoadFunction('EVP_CIPHER_CTX_original_iv', AFailed);
  EVP_CIPHER_CTX_iv_noconst := LoadFunction('EVP_CIPHER_CTX_iv_noconst', AFailed);
  EVP_CIPHER_CTX_buf_noconst := LoadFunction('EVP_CIPHER_CTX_buf_noconst', AFailed);
  EVP_CIPHER_CTX_num := LoadFunction('EVP_CIPHER_CTX_num', AFailed);
  EVP_CIPHER_CTX_set_num := LoadFunction('EVP_CIPHER_CTX_set_num', AFailed);
  EVP_CIPHER_CTX_copy := LoadFunction('EVP_CIPHER_CTX_copy', AFailed);
  EVP_CIPHER_CTX_get_app_data := LoadFunction('EVP_CIPHER_CTX_get_app_data', AFailed);
  EVP_CIPHER_CTX_set_app_data := LoadFunction('EVP_CIPHER_CTX_set_app_data', AFailed);
  EVP_CIPHER_CTX_get_cipher_data := LoadFunction('EVP_CIPHER_CTX_get_cipher_data', AFailed);
  EVP_CIPHER_CTX_set_cipher_data := LoadFunction('EVP_CIPHER_CTX_set_cipher_data', AFailed);
  BIO_set_md := LoadFunction('BIO_set_md', AFailed);
  EVP_MD_CTX_ctrl := LoadFunction('EVP_MD_CTX_ctrl', AFailed);
  EVP_MD_CTX_new := LoadFunction('EVP_MD_CTX_new', AFailed);
  EVP_MD_CTX_reset := LoadFunction('EVP_MD_CTX_reset', AFailed);
  EVP_MD_CTX_free := LoadFunction('EVP_MD_CTX_free', AFailed);
  EVP_MD_CTX_copy_ex := LoadFunction('EVP_MD_CTX_copy_ex', AFailed);
  EVP_MD_CTX_set_flags := LoadFunction('EVP_MD_CTX_set_flags', AFailed);
  EVP_MD_CTX_clear_flags := LoadFunction('EVP_MD_CTX_clear_flags', AFailed);
  EVP_MD_CTX_test_flags := LoadFunction('EVP_MD_CTX_test_flags', AFailed);
  EVP_DigestInit_ex := LoadFunction('EVP_DigestInit_ex', AFailed);
  EVP_DigestUpdate := LoadFunction('EVP_DigestUpdate', AFailed);
  EVP_DigestFinal_ex := LoadFunction('EVP_DigestFinal_ex', AFailed);
  EVP_Digest := LoadFunction('EVP_Digest', AFailed);
  EVP_MD_CTX_copy := LoadFunction('EVP_MD_CTX_copy', AFailed);
  EVP_DigestInit := LoadFunction('EVP_DigestInit', AFailed);
  EVP_DigestFinal := LoadFunction('EVP_DigestFinal', AFailed);
  EVP_DigestFinalXOF := LoadFunction('EVP_DigestFinalXOF', AFailed);
  EVP_read_pw_string := LoadFunction('EVP_read_pw_string', AFailed);
  EVP_read_pw_string_min := LoadFunction('EVP_read_pw_string_min', AFailed);
  EVP_set_pw_prompt := LoadFunction('EVP_set_pw_prompt', AFailed);
  EVP_get_pw_prompt := LoadFunction('EVP_get_pw_prompt', AFailed);
  EVP_BytesToKey := LoadFunction('EVP_BytesToKey', AFailed);
  EVP_CIPHER_CTX_set_flags := LoadFunction('EVP_CIPHER_CTX_set_flags', AFailed);
  EVP_CIPHER_CTX_clear_flags := LoadFunction('EVP_CIPHER_CTX_clear_flags', AFailed);
  EVP_CIPHER_CTX_test_flags := LoadFunction('EVP_CIPHER_CTX_test_flags', AFailed);
  EVP_EncryptInit := LoadFunction('EVP_EncryptInit', AFailed);
  EVP_EncryptInit_ex := LoadFunction('EVP_EncryptInit_ex', AFailed);
  EVP_EncryptUpdate := LoadFunction('EVP_EncryptUpdate', AFailed);
  EVP_EncryptFinal_ex := LoadFunction('EVP_EncryptFinal_ex', AFailed);
  EVP_EncryptFinal := LoadFunction('EVP_EncryptFinal', AFailed);
  EVP_DecryptInit := LoadFunction('EVP_DecryptInit', AFailed);
  EVP_DecryptInit_ex := LoadFunction('EVP_DecryptInit_ex', AFailed);
  EVP_DecryptUpdate := LoadFunction('EVP_DecryptUpdate', AFailed);
  EVP_DecryptFinal := LoadFunction('EVP_DecryptFinal', AFailed);
  EVP_DecryptFinal_ex := LoadFunction('EVP_DecryptFinal_ex', AFailed);
  EVP_CipherInit := LoadFunction('EVP_CipherInit', AFailed);
  EVP_CipherInit_ex := LoadFunction('EVP_CipherInit_ex', AFailed);
  EVP_CipherUpdate := LoadFunction('EVP_CipherUpdate', AFailed);
  EVP_CipherFinal := LoadFunction('EVP_CipherFinal', AFailed);
  EVP_CipherFinal_ex := LoadFunction('EVP_CipherFinal_ex', AFailed);
  EVP_SignFinal := LoadFunction('EVP_SignFinal', AFailed);
  EVP_DigestSign := LoadFunction('EVP_DigestSign', AFailed);
  EVP_VerifyFinal := LoadFunction('EVP_VerifyFinal', AFailed);
  EVP_DigestVerify := LoadFunction('EVP_DigestVerify', AFailed);
  EVP_DigestSignInit := LoadFunction('EVP_DigestSignInit', AFailed);
  EVP_DigestSignFinal := LoadFunction('EVP_DigestSignFinal', AFailed);
  EVP_DigestVerifyInit := LoadFunction('EVP_DigestVerifyInit', AFailed);
  EVP_DigestVerifyFinal := LoadFunction('EVP_DigestVerifyFinal', AFailed);
  EVP_OpenInit := LoadFunction('EVP_OpenInit', AFailed);
  EVP_OpenFinal := LoadFunction('EVP_OpenFinal', AFailed);
  EVP_SealInit := LoadFunction('EVP_SealInit', AFailed);
  EVP_SealFinal := LoadFunction('EVP_SealFinal', AFailed);
  EVP_ENCODE_CTX_new := LoadFunction('EVP_ENCODE_CTX_new', AFailed);
  EVP_ENCODE_CTX_free := LoadFunction('EVP_ENCODE_CTX_free', AFailed);
  EVP_ENCODE_CTX_copy := LoadFunction('EVP_ENCODE_CTX_copy', AFailed);
  EVP_ENCODE_CTX_num := LoadFunction('EVP_ENCODE_CTX_num', AFailed);
  EVP_EncodeInit := LoadFunction('EVP_EncodeInit', AFailed);
  EVP_EncodeUpdate := LoadFunction('EVP_EncodeUpdate', AFailed);
  EVP_EncodeFinal := LoadFunction('EVP_EncodeFinal', AFailed);
  EVP_EncodeBlock := LoadFunction('EVP_EncodeBlock', AFailed);
  EVP_DecodeInit := LoadFunction('EVP_DecodeInit', AFailed);
  EVP_DecodeUpdate := LoadFunction('EVP_DecodeUpdate', AFailed);
  EVP_DecodeFinal := LoadFunction('EVP_DecodeFinal', AFailed);
  EVP_DecodeBlock := LoadFunction('EVP_DecodeBlock', AFailed);
  EVP_CIPHER_CTX_new := LoadFunction('EVP_CIPHER_CTX_new', AFailed);
  EVP_CIPHER_CTX_reset := LoadFunction('EVP_CIPHER_CTX_reset', AFailed);
  EVP_CIPHER_CTX_free := LoadFunction('EVP_CIPHER_CTX_free', AFailed);
  EVP_CIPHER_CTX_set_key_length := LoadFunction('EVP_CIPHER_CTX_set_key_length', AFailed);
  EVP_CIPHER_CTX_set_padding := LoadFunction('EVP_CIPHER_CTX_set_padding', AFailed);
  EVP_CIPHER_CTX_ctrl := LoadFunction('EVP_CIPHER_CTX_ctrl', AFailed);
  EVP_CIPHER_CTX_rand_key := LoadFunction('EVP_CIPHER_CTX_rand_key', AFailed);
  BIO_f_md := LoadFunction('BIO_f_md', AFailed);
  BIO_f_base64 := LoadFunction('BIO_f_base64', AFailed);
  BIO_f_cipher := LoadFunction('BIO_f_cipher', AFailed);
  BIO_f_reliable := LoadFunction('BIO_f_reliable', AFailed);
  BIO_set_cipher := LoadFunction('BIO_set_cipher', AFailed);
  EVP_md_null := LoadFunction('EVP_md_null', AFailed);
  EVP_md5 := LoadFunction('EVP_md5', AFailed);
  EVP_md5_sha1 := LoadFunction('EVP_md5_sha1', AFailed);
  EVP_sha1 := LoadFunction('EVP_sha1', AFailed);
  EVP_sha224 := LoadFunction('EVP_sha224', AFailed);
  EVP_sha256 := LoadFunction('EVP_sha256', AFailed);
  EVP_sha384 := LoadFunction('EVP_sha384', AFailed);
  EVP_sha512 := LoadFunction('EVP_sha512', AFailed);
  EVP_sha512_224 := LoadFunction('EVP_sha512_224', AFailed);
  EVP_sha512_256 := LoadFunction('EVP_sha512_256', AFailed);
  EVP_sha3_224 := LoadFunction('EVP_sha3_224', AFailed);
  EVP_sha3_256 := LoadFunction('EVP_sha3_256', AFailed);
  EVP_sha3_384 := LoadFunction('EVP_sha3_384', AFailed);
  EVP_sha3_512 := LoadFunction('EVP_sha3_512', AFailed);
  EVP_shake128 := LoadFunction('EVP_shake128', AFailed);
  EVP_shake256 := LoadFunction('EVP_shake256', AFailed);
  EVP_enc_null := LoadFunction('EVP_enc_null', AFailed);
  EVP_des_ecb := LoadFunction('EVP_des_ecb', AFailed);
  EVP_des_ede := LoadFunction('EVP_des_ede', AFailed);
  EVP_des_ede3 := LoadFunction('EVP_des_ede3', AFailed);
  EVP_des_ede_ecb := LoadFunction('EVP_des_ede_ecb', AFailed);
  EVP_des_ede3_ecb := LoadFunction('EVP_des_ede3_ecb', AFailed);
  EVP_des_cfb64 := LoadFunction('EVP_des_cfb64', AFailed);
  EVP_des_cfb1 := LoadFunction('EVP_des_cfb1', AFailed);
  EVP_des_cfb8 := LoadFunction('EVP_des_cfb8', AFailed);
  EVP_des_ede_cfb64 := LoadFunction('EVP_des_ede_cfb64', AFailed);
  EVP_des_ede3_cfb64 := LoadFunction('EVP_des_ede3_cfb64', AFailed);
  EVP_des_ede3_cfb1 := LoadFunction('EVP_des_ede3_cfb1', AFailed);
  EVP_des_ede3_cfb8 := LoadFunction('EVP_des_ede3_cfb8', AFailed);
  EVP_des_ofb := LoadFunction('EVP_des_ofb', AFailed);
  EVP_des_ede_ofb := LoadFunction('EVP_des_ede_ofb', AFailed);
  EVP_des_ede3_ofb := LoadFunction('EVP_des_ede3_ofb', AFailed);
  EVP_des_cbc := LoadFunction('EVP_des_cbc', AFailed);
  EVP_des_ede_cbc := LoadFunction('EVP_des_ede_cbc', AFailed);
  EVP_des_ede3_cbc := LoadFunction('EVP_des_ede3_cbc', AFailed);
  EVP_desx_cbc := LoadFunction('EVP_desx_cbc', AFailed);
  EVP_des_ede3_wrap := LoadFunction('EVP_des_ede3_wrap', AFailed);
  EVP_rc4 := LoadFunction('EVP_rc4', AFailed);
  EVP_rc4_40 := LoadFunction('EVP_rc4_40', AFailed);
  EVP_idea_ecb := LoadFunction('EVP_idea_ecb', AFailed);
  EVP_idea_cfb64 := LoadFunction('EVP_idea_cfb64', AFailed);
  EVP_idea_ofb := LoadFunction('EVP_idea_ofb', AFailed);
  EVP_idea_cbc := LoadFunction('EVP_idea_cbc', AFailed);
  EVP_rc2_ecb := LoadFunction('EVP_rc2_ecb', AFailed);
  EVP_rc2_cbc := LoadFunction('EVP_rc2_cbc', AFailed);
  EVP_rc2_40_cbc := LoadFunction('EVP_rc2_40_cbc', AFailed);
  EVP_rc2_64_cbc := LoadFunction('EVP_rc2_64_cbc', AFailed);
  EVP_rc2_cfb64 := LoadFunction('EVP_rc2_cfb64', AFailed);
  EVP_rc2_ofb := LoadFunction('EVP_rc2_ofb', AFailed);
  EVP_bf_ecb := LoadFunction('EVP_bf_ecb', AFailed);
  EVP_bf_cbc := LoadFunction('EVP_bf_cbc', AFailed);
  EVP_bf_cfb64 := LoadFunction('EVP_bf_cfb64', AFailed);
  EVP_bf_ofb := LoadFunction('EVP_bf_ofb', AFailed);
  EVP_cast5_ecb := LoadFunction('EVP_cast5_ecb', AFailed);
  EVP_cast5_cbc := LoadFunction('EVP_cast5_cbc', AFailed);
  EVP_cast5_cfb64 := LoadFunction('EVP_cast5_cfb64', AFailed);
  EVP_cast5_ofb := LoadFunction('EVP_cast5_ofb', AFailed);
  EVP_rc5_32_12_16_cbc := LoadFunction('EVP_rc5_32_12_16_cbc', AFailed);
  EVP_rc5_32_12_16_ecb := LoadFunction('EVP_rc5_32_12_16_ecb', AFailed);
  EVP_rc5_32_12_16_cfb64 := LoadFunction('EVP_rc5_32_12_16_cfb64', AFailed);
  EVP_rc5_32_12_16_ofb := LoadFunction('EVP_rc5_32_12_16_ofb', AFailed);
  EVP_aes_128_ecb := LoadFunction('EVP_aes_128_ecb', AFailed);
  EVP_aes_128_cbc := LoadFunction('EVP_aes_128_cbc', AFailed);
  EVP_aes_128_cfb1 := LoadFunction('EVP_aes_128_cfb1', AFailed);
  EVP_aes_128_cfb8 := LoadFunction('EVP_aes_128_cfb8', AFailed);
  EVP_aes_128_cfb128 := LoadFunction('EVP_aes_128_cfb128', AFailed);
  EVP_aes_128_ofb := LoadFunction('EVP_aes_128_ofb', AFailed);
  EVP_aes_128_ctr := LoadFunction('EVP_aes_128_ctr', AFailed);
  EVP_aes_128_ccm := LoadFunction('EVP_aes_128_ccm', AFailed);
  EVP_aes_128_gcm := LoadFunction('EVP_aes_128_gcm', AFailed);
  EVP_aes_128_xts := LoadFunction('EVP_aes_128_xts', AFailed);
  EVP_aes_128_wrap := LoadFunction('EVP_aes_128_wrap', AFailed);
  EVP_aes_128_wrap_pad := LoadFunction('EVP_aes_128_wrap_pad', AFailed);
  EVP_aes_128_ocb := LoadFunction('EVP_aes_128_ocb', AFailed);
  EVP_aes_192_ecb := LoadFunction('EVP_aes_192_ecb', AFailed);
  EVP_aes_192_cbc := LoadFunction('EVP_aes_192_cbc', AFailed);
  EVP_aes_192_cfb1 := LoadFunction('EVP_aes_192_cfb1', AFailed);
  EVP_aes_192_cfb8 := LoadFunction('EVP_aes_192_cfb8', AFailed);
  EVP_aes_192_cfb128 := LoadFunction('EVP_aes_192_cfb128', AFailed);
  EVP_aes_192_ofb := LoadFunction('EVP_aes_192_ofb', AFailed);
  EVP_aes_192_ctr := LoadFunction('EVP_aes_192_ctr', AFailed);
  EVP_aes_192_ccm := LoadFunction('EVP_aes_192_ccm', AFailed);
  EVP_aes_192_gcm := LoadFunction('EVP_aes_192_gcm', AFailed);
  EVP_aes_192_wrap := LoadFunction('EVP_aes_192_wrap', AFailed);
  EVP_aes_192_wrap_pad := LoadFunction('EVP_aes_192_wrap_pad', AFailed);
  EVP_aes_192_ocb := LoadFunction('EVP_aes_192_ocb', AFailed);
  EVP_aes_256_ecb := LoadFunction('EVP_aes_256_ecb', AFailed);
  EVP_aes_256_cbc := LoadFunction('EVP_aes_256_cbc', AFailed);
  EVP_aes_256_cfb1 := LoadFunction('EVP_aes_256_cfb1', AFailed);
  EVP_aes_256_cfb8 := LoadFunction('EVP_aes_256_cfb8', AFailed);
  EVP_aes_256_cfb128 := LoadFunction('EVP_aes_256_cfb128', AFailed);
  EVP_aes_256_ofb := LoadFunction('EVP_aes_256_ofb', AFailed);
  EVP_aes_256_ctr := LoadFunction('EVP_aes_256_ctr', AFailed);
  EVP_aes_256_ccm := LoadFunction('EVP_aes_256_ccm', AFailed);
  EVP_aes_256_gcm := LoadFunction('EVP_aes_256_gcm', AFailed);
  EVP_aes_256_xts := LoadFunction('EVP_aes_256_xts', AFailed);
  EVP_aes_256_wrap := LoadFunction('EVP_aes_256_wrap', AFailed);
  EVP_aes_256_wrap_pad := LoadFunction('EVP_aes_256_wrap_pad', AFailed);
  EVP_aes_256_ocb := LoadFunction('EVP_aes_256_ocb', AFailed);
  EVP_aes_128_cbc_hmac_sha1 := LoadFunction('EVP_aes_128_cbc_hmac_sha1', AFailed);
  EVP_aes_256_cbc_hmac_sha1 := LoadFunction('EVP_aes_256_cbc_hmac_sha1', AFailed);
  EVP_aes_128_cbc_hmac_sha256 := LoadFunction('EVP_aes_128_cbc_hmac_sha256', AFailed);
  EVP_aes_256_cbc_hmac_sha256 := LoadFunction('EVP_aes_256_cbc_hmac_sha256', AFailed);
  EVP_aria_128_ecb := LoadFunction('EVP_aria_128_ecb', AFailed);
  EVP_aria_128_cbc := LoadFunction('EVP_aria_128_cbc', AFailed);
  EVP_aria_128_cfb1 := LoadFunction('EVP_aria_128_cfb1', AFailed);
  EVP_aria_128_cfb8 := LoadFunction('EVP_aria_128_cfb8', AFailed);
  EVP_aria_128_cfb128 := LoadFunction('EVP_aria_128_cfb128', AFailed);
  EVP_aria_128_ctr := LoadFunction('EVP_aria_128_ctr', AFailed);
  EVP_aria_128_ofb := LoadFunction('EVP_aria_128_ofb', AFailed);
  EVP_aria_128_gcm := LoadFunction('EVP_aria_128_gcm', AFailed);
  EVP_aria_128_ccm := LoadFunction('EVP_aria_128_ccm', AFailed);
  EVP_aria_192_ecb := LoadFunction('EVP_aria_192_ecb', AFailed);
  EVP_aria_192_cbc := LoadFunction('EVP_aria_192_cbc', AFailed);
  EVP_aria_192_cfb1 := LoadFunction('EVP_aria_192_cfb1', AFailed);
  EVP_aria_192_cfb8 := LoadFunction('EVP_aria_192_cfb8', AFailed);
  EVP_aria_192_cfb128 := LoadFunction('EVP_aria_192_cfb128', AFailed);
  EVP_aria_192_ctr := LoadFunction('EVP_aria_192_ctr', AFailed);
  EVP_aria_192_ofb := LoadFunction('EVP_aria_192_ofb', AFailed);
  EVP_aria_192_gcm := LoadFunction('EVP_aria_192_gcm', AFailed);
  EVP_aria_192_ccm := LoadFunction('EVP_aria_192_ccm', AFailed);
  EVP_aria_256_ecb := LoadFunction('EVP_aria_256_ecb', AFailed);
  EVP_aria_256_cbc := LoadFunction('EVP_aria_256_cbc', AFailed);
  EVP_aria_256_cfb1 := LoadFunction('EVP_aria_256_cfb1', AFailed);
  EVP_aria_256_cfb8 := LoadFunction('EVP_aria_256_cfb8', AFailed);
  EVP_aria_256_cfb128 := LoadFunction('EVP_aria_256_cfb128', AFailed);
  EVP_aria_256_ctr := LoadFunction('EVP_aria_256_ctr', AFailed);
  EVP_aria_256_ofb := LoadFunction('EVP_aria_256_ofb', AFailed);
  EVP_aria_256_gcm := LoadFunction('EVP_aria_256_gcm', AFailed);
  EVP_aria_256_ccm := LoadFunction('EVP_aria_256_ccm', AFailed);
  EVP_camellia_128_ecb := LoadFunction('EVP_camellia_128_ecb', AFailed);
  EVP_camellia_128_cbc := LoadFunction('EVP_camellia_128_cbc', AFailed);
  EVP_camellia_128_cfb1 := LoadFunction('EVP_camellia_128_cfb1', AFailed);
  EVP_camellia_128_cfb8 := LoadFunction('EVP_camellia_128_cfb8', AFailed);
  EVP_camellia_128_cfb128 := LoadFunction('EVP_camellia_128_cfb128', AFailed);
  EVP_camellia_128_ofb := LoadFunction('EVP_camellia_128_ofb', AFailed);
  EVP_camellia_128_ctr := LoadFunction('EVP_camellia_128_ctr', AFailed);
  EVP_camellia_192_ecb := LoadFunction('EVP_camellia_192_ecb', AFailed);
  EVP_camellia_192_cbc := LoadFunction('EVP_camellia_192_cbc', AFailed);
  EVP_camellia_192_cfb1 := LoadFunction('EVP_camellia_192_cfb1', AFailed);
  EVP_camellia_192_cfb8 := LoadFunction('EVP_camellia_192_cfb8', AFailed);
  EVP_camellia_192_cfb128 := LoadFunction('EVP_camellia_192_cfb128', AFailed);
  EVP_camellia_192_ofb := LoadFunction('EVP_camellia_192_ofb', AFailed);
  EVP_camellia_192_ctr := LoadFunction('EVP_camellia_192_ctr', AFailed);
  EVP_camellia_256_ecb := LoadFunction('EVP_camellia_256_ecb', AFailed);
  EVP_camellia_256_cbc := LoadFunction('EVP_camellia_256_cbc', AFailed);
  EVP_camellia_256_cfb1 := LoadFunction('EVP_camellia_256_cfb1', AFailed);
  EVP_camellia_256_cfb8 := LoadFunction('EVP_camellia_256_cfb8', AFailed);
  EVP_camellia_256_cfb128 := LoadFunction('EVP_camellia_256_cfb128', AFailed);
  EVP_camellia_256_ofb := LoadFunction('EVP_camellia_256_ofb', AFailed);
  EVP_camellia_256_ctr := LoadFunction('EVP_camellia_256_ctr', AFailed);
  EVP_chacha20 := LoadFunction('EVP_chacha20', AFailed);
  EVP_chacha20_poly1305 := LoadFunction('EVP_chacha20_poly1305', AFailed);
  EVP_seed_ecb := LoadFunction('EVP_seed_ecb', AFailed);
  EVP_seed_cbc := LoadFunction('EVP_seed_cbc', AFailed);
  EVP_seed_cfb128 := LoadFunction('EVP_seed_cfb128', AFailed);
  EVP_seed_ofb := LoadFunction('EVP_seed_ofb', AFailed);
  EVP_sm4_ecb := LoadFunction('EVP_sm4_ecb', AFailed);
  EVP_sm4_cbc := LoadFunction('EVP_sm4_cbc', AFailed);
  EVP_sm4_cfb128 := LoadFunction('EVP_sm4_cfb128', AFailed);
  EVP_sm4_ofb := LoadFunction('EVP_sm4_ofb', AFailed);
  EVP_sm4_ctr := LoadFunction('EVP_sm4_ctr', AFailed);
  EVP_add_cipher := LoadFunction('EVP_add_cipher', AFailed);
  EVP_add_digest := LoadFunction('EVP_add_digest', AFailed);
  EVP_get_cipherbyname := LoadFunction('EVP_get_cipherbyname', AFailed);
  EVP_get_digestbyname := LoadFunction('EVP_get_digestbyname', AFailed);
  EVP_CIPHER_do_all := LoadFunction('EVP_CIPHER_do_all', AFailed);
  EVP_CIPHER_do_all_sorted := LoadFunction('EVP_CIPHER_do_all_sorted', AFailed);
  EVP_MD_do_all := LoadFunction('EVP_MD_do_all', AFailed);
  EVP_MD_do_all_sorted := LoadFunction('EVP_MD_do_all_sorted', AFailed);
  EVP_PKEY_decrypt_old := LoadFunction('EVP_PKEY_decrypt_old', AFailed);
  EVP_PKEY_encrypt_old := LoadFunction('EVP_PKEY_encrypt_old', AFailed);
  EVP_PKEY_type := LoadFunction('EVP_PKEY_type', AFailed);
  EVP_PKEY_id := LoadFunction('EVP_PKEY_id', AFailed);
  EVP_PKEY_base_id := LoadFunction('EVP_PKEY_base_id', AFailed);
  EVP_PKEY_bits := LoadFunction('EVP_PKEY_bits', AFailed);
  EVP_PKEY_security_bits := LoadFunction('EVP_PKEY_security_bits', AFailed);
  EVP_PKEY_size := LoadFunction('EVP_PKEY_size', AFailed);
  EVP_PKEY_set_type := LoadFunction('EVP_PKEY_set_type', AFailed);
  EVP_PKEY_set_type_str := LoadFunction('EVP_PKEY_set_type_str', AFailed);
  EVP_PKEY_set_alias_type := LoadFunction('EVP_PKEY_set_alias_type', AFailed);
  EVP_PKEY_set1_engine := LoadFunction('EVP_PKEY_set1_engine', AFailed);
  EVP_PKEY_get0_engine := LoadFunction('EVP_PKEY_get0_engine', AFailed);
  EVP_PKEY_assign := LoadFunction('EVP_PKEY_assign', AFailed);
  EVP_PKEY_get0 := LoadFunction('EVP_PKEY_get0', AFailed);
  EVP_PKEY_get0_hmac := LoadFunction('EVP_PKEY_get0_hmac', AFailed);
  EVP_PKEY_get0_poly1305 := LoadFunction('EVP_PKEY_get0_poly1305', AFailed);
  EVP_PKEY_get0_siphash := LoadFunction('EVP_PKEY_get0_siphash', AFailed);
  EVP_PKEY_set1_RSA := LoadFunction('EVP_PKEY_set1_RSA', AFailed);
  EVP_PKEY_get0_RSA := LoadFunction('EVP_PKEY_get0_RSA', AFailed);
  EVP_PKEY_get1_RSA := LoadFunction('EVP_PKEY_get1_RSA', AFailed);
  EVP_PKEY_set1_DSA := LoadFunction('EVP_PKEY_set1_DSA', AFailed);
  EVP_PKEY_get0_DSA := LoadFunction('EVP_PKEY_get0_DSA', AFailed);
  EVP_PKEY_get1_DSA := LoadFunction('EVP_PKEY_get1_DSA', AFailed);
  EVP_PKEY_set1_DH := LoadFunction('EVP_PKEY_set1_DH', AFailed);
  EVP_PKEY_get0_DH := LoadFunction('EVP_PKEY_get0_DH', AFailed);
  EVP_PKEY_get1_DH := LoadFunction('EVP_PKEY_get1_DH', AFailed);
  EVP_PKEY_set1_EC_KEY := LoadFunction('EVP_PKEY_set1_EC_KEY', AFailed);
  EVP_PKEY_get0_EC_KEY := LoadFunction('EVP_PKEY_get0_EC_KEY', AFailed);
  EVP_PKEY_get1_EC_KEY := LoadFunction('EVP_PKEY_get1_EC_KEY', AFailed);
  EVP_PKEY_new := LoadFunction('EVP_PKEY_new', AFailed);
  EVP_PKEY_up_ref := LoadFunction('EVP_PKEY_up_ref', AFailed);
  EVP_PKEY_free := LoadFunction('EVP_PKEY_free', AFailed);
  d2i_PublicKey := LoadFunction('d2i_PublicKey', AFailed);
  i2d_PublicKey := LoadFunction('i2d_PublicKey', AFailed);
  d2i_PrivateKey := LoadFunction('d2i_PrivateKey', AFailed);
  d2i_AutoPrivateKey := LoadFunction('d2i_AutoPrivateKey', AFailed);
  i2d_PrivateKey := LoadFunction('i2d_PrivateKey', AFailed);
  EVP_PKEY_copy_parameters := LoadFunction('EVP_PKEY_copy_parameters', AFailed);
  EVP_PKEY_missing_parameters := LoadFunction('EVP_PKEY_missing_parameters', AFailed);
  EVP_PKEY_save_parameters := LoadFunction('EVP_PKEY_save_parameters', AFailed);
  EVP_PKEY_cmp_parameters := LoadFunction('EVP_PKEY_cmp_parameters', AFailed);
  EVP_PKEY_cmp := LoadFunction('EVP_PKEY_cmp', AFailed);
  EVP_PKEY_print_public := LoadFunction('EVP_PKEY_print_public', AFailed);
  EVP_PKEY_print_private := LoadFunction('EVP_PKEY_print_private', AFailed);
  EVP_PKEY_print_params := LoadFunction('EVP_PKEY_print_params', AFailed);
  EVP_PKEY_get_default_digest_nid := LoadFunction('EVP_PKEY_get_default_digest_nid', AFailed);
  EVP_PKEY_set1_tls_encodedpoint := LoadFunction('EVP_PKEY_set1_tls_encodedpoint', AFailed);
  EVP_PKEY_get1_tls_encodedpoint := LoadFunction('EVP_PKEY_get1_tls_encodedpoint', AFailed);
  EVP_CIPHER_type := LoadFunction('EVP_CIPHER_type', AFailed);
  EVP_CIPHER_param_to_asn1 := LoadFunction('EVP_CIPHER_param_to_asn1', AFailed);
  EVP_CIPHER_asn1_to_param := LoadFunction('EVP_CIPHER_asn1_to_param', AFailed);
  EVP_CIPHER_set_asn1_iv := LoadFunction('EVP_CIPHER_set_asn1_iv', AFailed);
  EVP_CIPHER_get_asn1_iv := LoadFunction('EVP_CIPHER_get_asn1_iv', AFailed);
  PKCS5_PBE_keyivgen := LoadFunction('PKCS5_PBE_keyivgen', AFailed);
  PKCS5_PBKDF2_HMAC_SHA1 := LoadFunction('PKCS5_PBKDF2_HMAC_SHA1', AFailed);
  PKCS5_PBKDF2_HMAC := LoadFunction('PKCS5_PBKDF2_HMAC', AFailed);
  PKCS5_v2_PBE_keyivgen := LoadFunction('PKCS5_v2_PBE_keyivgen', AFailed);
  EVP_PBE_scrypt := LoadFunction('EVP_PBE_scrypt', AFailed);
  PKCS5_v2_scrypt_keyivgen := LoadFunction('PKCS5_v2_scrypt_keyivgen', AFailed);
  PKCS5_PBE_add := LoadFunction('PKCS5_PBE_add', AFailed);
  EVP_PBE_CipherInit := LoadFunction('EVP_PBE_CipherInit', AFailed);
  EVP_PBE_alg_add_type := LoadFunction('EVP_PBE_alg_add_type', AFailed);
  EVP_PBE_alg_add := LoadFunction('EVP_PBE_alg_add', AFailed);
  EVP_PBE_find := LoadFunction('EVP_PBE_find', AFailed);
  EVP_PBE_cleanup := LoadFunction('EVP_PBE_cleanup', AFailed);
  EVP_PBE_get := LoadFunction('EVP_PBE_get', AFailed);
  EVP_PKEY_asn1_get_count := LoadFunction('EVP_PKEY_asn1_get_count', AFailed);
  EVP_PKEY_asn1_get0 := LoadFunction('EVP_PKEY_asn1_get0', AFailed);
  EVP_PKEY_asn1_find := LoadFunction('EVP_PKEY_asn1_find', AFailed);
  EVP_PKEY_asn1_find_str := LoadFunction('EVP_PKEY_asn1_find_str', AFailed);
  EVP_PKEY_asn1_add0 := LoadFunction('EVP_PKEY_asn1_add0', AFailed);
  EVP_PKEY_asn1_add_alias := LoadFunction('EVP_PKEY_asn1_add_alias', AFailed);
  EVP_PKEY_asn1_get0_info := LoadFunction('EVP_PKEY_asn1_get0_info', AFailed);
  EVP_PKEY_get0_asn1 := LoadFunction('EVP_PKEY_get0_asn1', AFailed);
  EVP_PKEY_asn1_new := LoadFunction('EVP_PKEY_asn1_new', AFailed);
  EVP_PKEY_asn1_copy := LoadFunction('EVP_PKEY_asn1_copy', AFailed);
  EVP_PKEY_asn1_free := LoadFunction('EVP_PKEY_asn1_free', AFailed);
  EVP_PKEY_asn1_set_public := LoadFunction('EVP_PKEY_asn1_set_public', AFailed);
  EVP_PKEY_asn1_set_private := LoadFunction('EVP_PKEY_asn1_set_private', AFailed);
  EVP_PKEY_asn1_set_param := LoadFunction('EVP_PKEY_asn1_set_param', AFailed);
  EVP_PKEY_asn1_set_free := LoadFunction('EVP_PKEY_asn1_set_free', AFailed);
  EVP_PKEY_asn1_set_ctrl := LoadFunction('EVP_PKEY_asn1_set_ctrl', AFailed);
  EVP_PKEY_asn1_set_item := LoadFunction('EVP_PKEY_asn1_set_item', AFailed);
  EVP_PKEY_asn1_set_siginf := LoadFunction('EVP_PKEY_asn1_set_siginf', AFailed);
  EVP_PKEY_asn1_set_check := LoadFunction('EVP_PKEY_asn1_set_check', AFailed);
  EVP_PKEY_asn1_set_public_check := LoadFunction('EVP_PKEY_asn1_set_public_check', AFailed);
  EVP_PKEY_asn1_set_param_check := LoadFunction('EVP_PKEY_asn1_set_param_check', AFailed);
  EVP_PKEY_asn1_set_set_priv_key := LoadFunction('EVP_PKEY_asn1_set_set_priv_key', AFailed);
  EVP_PKEY_asn1_set_set_pub_key := LoadFunction('EVP_PKEY_asn1_set_set_pub_key', AFailed);
  EVP_PKEY_asn1_set_get_priv_key := LoadFunction('EVP_PKEY_asn1_set_get_priv_key', AFailed);
  EVP_PKEY_asn1_set_get_pub_key := LoadFunction('EVP_PKEY_asn1_set_get_pub_key', AFailed);
  EVP_PKEY_asn1_set_security_bits := LoadFunction('EVP_PKEY_asn1_set_security_bits', AFailed);
  EVP_PKEY_meth_find := LoadFunction('EVP_PKEY_meth_find', AFailed);
  EVP_PKEY_meth_new := LoadFunction('EVP_PKEY_meth_new', AFailed);
  EVP_PKEY_meth_get0_info := LoadFunction('EVP_PKEY_meth_get0_info', AFailed);
  EVP_PKEY_meth_copy := LoadFunction('EVP_PKEY_meth_copy', AFailed);
  EVP_PKEY_meth_free := LoadFunction('EVP_PKEY_meth_free', AFailed);
  EVP_PKEY_meth_add0 := LoadFunction('EVP_PKEY_meth_add0', AFailed);
  EVP_PKEY_meth_remove := LoadFunction('EVP_PKEY_meth_remove', AFailed);
  EVP_PKEY_meth_get_count := LoadFunction('EVP_PKEY_meth_get_count', AFailed);
  EVP_PKEY_meth_get0 := LoadFunction('EVP_PKEY_meth_get0', AFailed);
  EVP_PKEY_CTX_new := LoadFunction('EVP_PKEY_CTX_new', AFailed);
  EVP_PKEY_CTX_new_id := LoadFunction('EVP_PKEY_CTX_new_id', AFailed);
  EVP_PKEY_CTX_dup := LoadFunction('EVP_PKEY_CTX_dup', AFailed);
  EVP_PKEY_CTX_free := LoadFunction('EVP_PKEY_CTX_free', AFailed);
  EVP_PKEY_CTX_ctrl := LoadFunction('EVP_PKEY_CTX_ctrl', AFailed);
  EVP_PKEY_CTX_ctrl_str := LoadFunction('EVP_PKEY_CTX_ctrl_str', AFailed);
  EVP_PKEY_CTX_ctrl_uint64 := LoadFunction('EVP_PKEY_CTX_ctrl_uint64', AFailed);
  EVP_PKEY_CTX_str2ctrl := LoadFunction('EVP_PKEY_CTX_str2ctrl', AFailed);
  EVP_PKEY_CTX_hex2ctrl := LoadFunction('EVP_PKEY_CTX_hex2ctrl', AFailed);
  EVP_PKEY_CTX_md := LoadFunction('EVP_PKEY_CTX_md', AFailed);
  EVP_PKEY_CTX_get_operation := LoadFunction('EVP_PKEY_CTX_get_operation', AFailed);
  EVP_PKEY_CTX_set0_keygen_info := LoadFunction('EVP_PKEY_CTX_set0_keygen_info', AFailed);
  EVP_PKEY_new_mac_key := LoadFunction('EVP_PKEY_new_mac_key', AFailed);
  EVP_PKEY_new_raw_private_key := LoadFunction('EVP_PKEY_new_raw_private_key', AFailed);
  EVP_PKEY_new_raw_public_key := LoadFunction('EVP_PKEY_new_raw_public_key', AFailed);
  EVP_PKEY_get_raw_private_key := LoadFunction('EVP_PKEY_get_raw_private_key', AFailed);
  EVP_PKEY_get_raw_public_key := LoadFunction('EVP_PKEY_get_raw_public_key', AFailed);
  EVP_PKEY_new_CMAC_key := LoadFunction('EVP_PKEY_new_CMAC_key', AFailed);
  EVP_PKEY_CTX_set_data := LoadFunction('EVP_PKEY_CTX_set_data', AFailed);
  EVP_PKEY_CTX_get_data := LoadFunction('EVP_PKEY_CTX_get_data', AFailed);
  EVP_PKEY_CTX_get0_pkey := LoadFunction('EVP_PKEY_CTX_get0_pkey', AFailed);
  EVP_PKEY_CTX_get0_peerkey := LoadFunction('EVP_PKEY_CTX_get0_peerkey', AFailed);
  EVP_PKEY_CTX_set_app_data := LoadFunction('EVP_PKEY_CTX_set_app_data', AFailed);
  EVP_PKEY_CTX_get_app_data := LoadFunction('EVP_PKEY_CTX_get_app_data', AFailed);
  EVP_PKEY_sign_init := LoadFunction('EVP_PKEY_sign_init', AFailed);
  EVP_PKEY_sign := LoadFunction('EVP_PKEY_sign', AFailed);
  EVP_PKEY_verify_init := LoadFunction('EVP_PKEY_verify_init', AFailed);
  EVP_PKEY_verify := LoadFunction('EVP_PKEY_verify', AFailed);
  EVP_PKEY_verify_recover_init := LoadFunction('EVP_PKEY_verify_recover_init', AFailed);
  EVP_PKEY_verify_recover := LoadFunction('EVP_PKEY_verify_recover', AFailed);
  EVP_PKEY_encrypt_init := LoadFunction('EVP_PKEY_encrypt_init', AFailed);
  EVP_PKEY_encrypt := LoadFunction('EVP_PKEY_encrypt', AFailed);
  EVP_PKEY_decrypt_init := LoadFunction('EVP_PKEY_decrypt_init', AFailed);
  EVP_PKEY_decrypt := LoadFunction('EVP_PKEY_decrypt', AFailed);
  EVP_PKEY_derive_init := LoadFunction('EVP_PKEY_derive_init', AFailed);
  EVP_PKEY_derive_set_peer := LoadFunction('EVP_PKEY_derive_set_peer', AFailed);
  EVP_PKEY_derive := LoadFunction('EVP_PKEY_derive', AFailed);
  EVP_PKEY_paramgen_init := LoadFunction('EVP_PKEY_paramgen_init', AFailed);
  EVP_PKEY_paramgen := LoadFunction('EVP_PKEY_paramgen', AFailed);
  EVP_PKEY_keygen_init := LoadFunction('EVP_PKEY_keygen_init', AFailed);
  EVP_PKEY_keygen := LoadFunction('EVP_PKEY_keygen', AFailed);
  EVP_PKEY_check := LoadFunction('EVP_PKEY_check', AFailed);
  EVP_PKEY_public_check := LoadFunction('EVP_PKEY_public_check', AFailed);
  EVP_PKEY_param_check := LoadFunction('EVP_PKEY_param_check', AFailed);
  EVP_PKEY_CTX_set_cb := LoadFunction('EVP_PKEY_CTX_set_cb', AFailed);
  EVP_PKEY_CTX_get_cb := LoadFunction('EVP_PKEY_CTX_get_cb', AFailed);
  EVP_PKEY_CTX_get_keygen_info := LoadFunction('EVP_PKEY_CTX_get_keygen_info', AFailed);
  EVP_PKEY_meth_set_init := LoadFunction('EVP_PKEY_meth_set_init', AFailed);
  EVP_PKEY_meth_set_copy := LoadFunction('EVP_PKEY_meth_set_copy', AFailed);
  EVP_PKEY_meth_set_cleanup := LoadFunction('EVP_PKEY_meth_set_cleanup', AFailed);
  EVP_PKEY_meth_set_paramgen := LoadFunction('EVP_PKEY_meth_set_paramgen', AFailed);
  EVP_PKEY_meth_set_keygen := LoadFunction('EVP_PKEY_meth_set_keygen', AFailed);
  EVP_PKEY_meth_set_sign := LoadFunction('EVP_PKEY_meth_set_sign', AFailed);
  EVP_PKEY_meth_set_verify := LoadFunction('EVP_PKEY_meth_set_verify', AFailed);
  EVP_PKEY_meth_set_verify_recover := LoadFunction('EVP_PKEY_meth_set_verify_recover', AFailed);
  EVP_PKEY_meth_set_signctx := LoadFunction('EVP_PKEY_meth_set_signctx', AFailed);
  EVP_PKEY_meth_set_verifyctx := LoadFunction('EVP_PKEY_meth_set_verifyctx', AFailed);
  EVP_PKEY_meth_set_encrypt := LoadFunction('EVP_PKEY_meth_set_encrypt', AFailed);
  EVP_PKEY_meth_set_decrypt := LoadFunction('EVP_PKEY_meth_set_decrypt', AFailed);
  EVP_PKEY_meth_set_derive := LoadFunction('EVP_PKEY_meth_set_derive', AFailed);
  EVP_PKEY_meth_set_ctrl := LoadFunction('EVP_PKEY_meth_set_ctrl', AFailed);
  EVP_PKEY_meth_set_digestsign := LoadFunction('EVP_PKEY_meth_set_digestsign', AFailed);
  EVP_PKEY_meth_set_digestverify := LoadFunction('EVP_PKEY_meth_set_digestverify', AFailed);
  EVP_PKEY_meth_set_check := LoadFunction('EVP_PKEY_meth_set_check', AFailed);
  EVP_PKEY_meth_set_public_check := LoadFunction('EVP_PKEY_meth_set_public_check', AFailed);
  EVP_PKEY_meth_set_param_check := LoadFunction('EVP_PKEY_meth_set_param_check', AFailed);
  EVP_PKEY_meth_set_digest_custom := LoadFunction('EVP_PKEY_meth_set_digest_custom', AFailed);
  EVP_PKEY_meth_get_init := LoadFunction('EVP_PKEY_meth_get_init', AFailed);
  EVP_PKEY_meth_get_copy := LoadFunction('EVP_PKEY_meth_get_copy', AFailed);
  EVP_PKEY_meth_get_cleanup := LoadFunction('EVP_PKEY_meth_get_cleanup', AFailed);
  EVP_PKEY_meth_get_paramgen := LoadFunction('EVP_PKEY_meth_get_paramgen', AFailed);
  EVP_PKEY_meth_get_keygen := LoadFunction('EVP_PKEY_meth_get_keygen', AFailed);
  EVP_PKEY_meth_get_sign := LoadFunction('EVP_PKEY_meth_get_sign', AFailed);
  EVP_PKEY_meth_get_verify := LoadFunction('EVP_PKEY_meth_get_verify', AFailed);
  EVP_PKEY_meth_get_verify_recover := LoadFunction('EVP_PKEY_meth_get_verify_recover', AFailed);
  EVP_PKEY_meth_get_signctx := LoadFunction('EVP_PKEY_meth_get_signctx', AFailed);
  EVP_PKEY_meth_get_verifyctx := LoadFunction('EVP_PKEY_meth_get_verifyctx', AFailed);
  EVP_PKEY_meth_get_encrypt := LoadFunction('EVP_PKEY_meth_get_encrypt', AFailed);
  EVP_PKEY_meth_get_decrypt := LoadFunction('EVP_PKEY_meth_get_decrypt', AFailed);
  EVP_PKEY_meth_get_derive := LoadFunction('EVP_PKEY_meth_get_derive', AFailed);
  EVP_PKEY_meth_get_ctrl := LoadFunction('EVP_PKEY_meth_get_ctrl', AFailed);
  EVP_PKEY_meth_get_digestsign := LoadFunction('EVP_PKEY_meth_get_digestsign', AFailed);
  EVP_PKEY_meth_get_digestverify := LoadFunction('EVP_PKEY_meth_get_digestverify', AFailed);
  EVP_PKEY_meth_get_check := LoadFunction('EVP_PKEY_meth_get_check', AFailed);
  EVP_PKEY_meth_get_public_check := LoadFunction('EVP_PKEY_meth_get_public_check', AFailed);
  EVP_PKEY_meth_get_param_check := LoadFunction('EVP_PKEY_meth_get_param_check', AFailed);
  EVP_PKEY_meth_get_digest_custom := LoadFunction('EVP_PKEY_meth_get_digest_custom', AFailed);
  EVP_add_alg_module := LoadFunction('EVP_add_alg_module', AFailed);
end;

procedure UnLoad;
begin
  EVP_MD_meth_new := nil;
  EVP_MD_meth_dup := nil;
  EVP_MD_meth_free := nil;
  EVP_MD_meth_set_input_blocksize := nil;
  EVP_MD_meth_set_result_size := nil;
  EVP_MD_meth_set_app_datasize := nil;
  EVP_MD_meth_set_flags := nil;
  EVP_MD_meth_set_init := nil;
  EVP_MD_meth_set_update := nil;
  EVP_MD_meth_set_final := nil;
  EVP_MD_meth_set_copy := nil;
  EVP_MD_meth_set_cleanup := nil;
  EVP_MD_meth_set_ctrl := nil;
  EVP_MD_meth_get_input_blocksize := nil;
  EVP_MD_meth_get_result_size := nil;
  EVP_MD_meth_get_app_datasize := nil;
  EVP_MD_meth_get_flags := nil;
  EVP_MD_meth_get_init := nil;
  EVP_MD_meth_get_update := nil;
  EVP_MD_meth_get_final := nil;
  EVP_MD_meth_get_copy := nil;
  EVP_MD_meth_get_cleanup := nil;
  EVP_MD_meth_get_ctrl := nil;
  EVP_CIPHER_meth_new := nil;
  EVP_CIPHER_meth_dup := nil;
  EVP_CIPHER_meth_free := nil;
  EVP_CIPHER_meth_set_iv_length := nil;
  EVP_CIPHER_meth_set_flags := nil;
  EVP_CIPHER_meth_set_impl_ctx_size := nil;
  EVP_CIPHER_meth_set_init := nil;
  EVP_CIPHER_meth_set_do_cipher := nil;
  EVP_CIPHER_meth_set_cleanup := nil;
  EVP_CIPHER_meth_set_set_asn1_params := nil;
  EVP_CIPHER_meth_set_get_asn1_params := nil;
  EVP_CIPHER_meth_set_ctrl := nil;
  EVP_CIPHER_meth_get_init := nil;
  EVP_CIPHER_meth_get_do_cipher := nil;
  EVP_CIPHER_meth_get_cleanup := nil;
  EVP_CIPHER_meth_get_set_asn1_params := nil;
  EVP_CIPHER_meth_get_get_asn1_params := nil;
  EVP_CIPHER_meth_get_ctrl := nil;
  EVP_MD_type := nil;
  EVP_MD_pkey_type := nil;
  EVP_MD_size := nil;
  EVP_MD_block_size := nil;
  EVP_MD_flags := nil;
  EVP_MD_CTX_md := nil;
  EVP_MD_CTX_update_fn := nil;
  EVP_MD_CTX_set_update_fn := nil;
  EVP_MD_CTX_pkey_ctx := nil;
  EVP_MD_CTX_set_pkey_ctx := nil;
  EVP_MD_CTX_md_data := nil;
  EVP_CIPHER_nid := nil;
  EVP_CIPHER_block_size := nil;
  EVP_CIPHER_impl_ctx_size := nil;
  EVP_CIPHER_key_length := nil;
  EVP_CIPHER_iv_length := nil;
  EVP_CIPHER_flags := nil;
  EVP_CIPHER_CTX_cipher := nil;
  EVP_CIPHER_CTX_encrypting := nil;
  EVP_CIPHER_CTX_nid := nil;
  EVP_CIPHER_CTX_block_size := nil;
  EVP_CIPHER_CTX_key_length := nil;
  EVP_CIPHER_CTX_iv_length := nil;
  EVP_CIPHER_CTX_iv := nil;
  EVP_CIPHER_CTX_original_iv := nil;
  EVP_CIPHER_CTX_iv_noconst := nil;
  EVP_CIPHER_CTX_buf_noconst := nil;
  EVP_CIPHER_CTX_num := nil;
  EVP_CIPHER_CTX_set_num := nil;
  EVP_CIPHER_CTX_copy := nil;
  EVP_CIPHER_CTX_get_app_data := nil;
  EVP_CIPHER_CTX_set_app_data := nil;
  EVP_CIPHER_CTX_get_cipher_data := nil;
  EVP_CIPHER_CTX_set_cipher_data := nil;
  BIO_set_md := nil;
  EVP_MD_CTX_ctrl := nil;
  EVP_MD_CTX_new := nil;
  EVP_MD_CTX_reset := nil;
  EVP_MD_CTX_free := nil;
  EVP_MD_CTX_copy_ex := nil;
  EVP_MD_CTX_set_flags := nil;
  EVP_MD_CTX_clear_flags := nil;
  EVP_MD_CTX_test_flags := nil;
  EVP_DigestInit_ex := nil;
  EVP_DigestUpdate := nil;
  EVP_DigestFinal_ex := nil;
  EVP_Digest := nil;
  EVP_MD_CTX_copy := nil;
  EVP_DigestInit := nil;
  EVP_DigestFinal := nil;
  EVP_DigestFinalXOF := nil;
  EVP_read_pw_string := nil;
  EVP_read_pw_string_min := nil;
  EVP_set_pw_prompt := nil;
  EVP_get_pw_prompt := nil;
  EVP_BytesToKey := nil;
  EVP_CIPHER_CTX_set_flags := nil;
  EVP_CIPHER_CTX_clear_flags := nil;
  EVP_CIPHER_CTX_test_flags := nil;
  EVP_EncryptInit := nil;
  EVP_EncryptInit_ex := nil;
  EVP_EncryptUpdate := nil;
  EVP_EncryptFinal_ex := nil;
  EVP_EncryptFinal := nil;
  EVP_DecryptInit := nil;
  EVP_DecryptInit_ex := nil;
  EVP_DecryptUpdate := nil;
  EVP_DecryptFinal := nil;
  EVP_DecryptFinal_ex := nil;
  EVP_CipherInit := nil;
  EVP_CipherInit_ex := nil;
  EVP_CipherUpdate := nil;
  EVP_CipherFinal := nil;
  EVP_CipherFinal_ex := nil;
  EVP_SignFinal := nil;
  EVP_DigestSign := nil;
  EVP_VerifyFinal := nil;
  EVP_DigestVerify := nil;
  EVP_DigestSignInit := nil;
  EVP_DigestSignFinal := nil;
  EVP_DigestVerifyInit := nil;
  EVP_DigestVerifyFinal := nil;
  EVP_OpenInit := nil;
  EVP_OpenFinal := nil;
  EVP_SealInit := nil;
  EVP_SealFinal := nil;
  EVP_ENCODE_CTX_new := nil;
  EVP_ENCODE_CTX_free := nil;
  EVP_ENCODE_CTX_copy := nil;
  EVP_ENCODE_CTX_num := nil;
  EVP_EncodeInit := nil;
  EVP_EncodeUpdate := nil;
  EVP_EncodeFinal := nil;
  EVP_EncodeBlock := nil;
  EVP_DecodeInit := nil;
  EVP_DecodeUpdate := nil;
  EVP_DecodeFinal := nil;
  EVP_DecodeBlock := nil;
  EVP_CIPHER_CTX_new := nil;
  EVP_CIPHER_CTX_reset := nil;
  EVP_CIPHER_CTX_free := nil;
  EVP_CIPHER_CTX_set_key_length := nil;
  EVP_CIPHER_CTX_set_padding := nil;
  EVP_CIPHER_CTX_ctrl := nil;
  EVP_CIPHER_CTX_rand_key := nil;
  BIO_f_md := nil;
  BIO_f_base64 := nil;
  BIO_f_cipher := nil;
  BIO_f_reliable := nil;
  BIO_set_cipher := nil;
  EVP_md_null := nil;
  EVP_md5 := nil;
  EVP_md5_sha1 := nil;
  EVP_sha1 := nil;
  EVP_sha224 := nil;
  EVP_sha256 := nil;
  EVP_sha384 := nil;
  EVP_sha512 := nil;
  EVP_sha512_224 := nil;
  EVP_sha512_256 := nil;
  EVP_sha3_224 := nil;
  EVP_sha3_256 := nil;
  EVP_sha3_384 := nil;
  EVP_sha3_512 := nil;
  EVP_shake128 := nil;
  EVP_shake256 := nil;
  EVP_enc_null := nil;
  EVP_des_ecb := nil;
  EVP_des_ede := nil;
  EVP_des_ede3 := nil;
  EVP_des_ede_ecb := nil;
  EVP_des_ede3_ecb := nil;
  EVP_des_cfb64 := nil;
  EVP_des_cfb1 := nil;
  EVP_des_cfb8 := nil;
  EVP_des_ede_cfb64 := nil;
  EVP_des_ede3_cfb64 := nil;
  EVP_des_ede3_cfb1 := nil;
  EVP_des_ede3_cfb8 := nil;
  EVP_des_ofb := nil;
  EVP_des_ede_ofb := nil;
  EVP_des_ede3_ofb := nil;
  EVP_des_cbc := nil;
  EVP_des_ede_cbc := nil;
  EVP_des_ede3_cbc := nil;
  EVP_desx_cbc := nil;
  EVP_des_ede3_wrap := nil;
  EVP_rc4 := nil;
  EVP_rc4_40 := nil;
  EVP_idea_ecb := nil;
  EVP_idea_cfb64 := nil;
  EVP_idea_ofb := nil;
  EVP_idea_cbc := nil;
  EVP_rc2_ecb := nil;
  EVP_rc2_cbc := nil;
  EVP_rc2_40_cbc := nil;
  EVP_rc2_64_cbc := nil;
  EVP_rc2_cfb64 := nil;
  EVP_rc2_ofb := nil;
  EVP_bf_ecb := nil;
  EVP_bf_cbc := nil;
  EVP_bf_cfb64 := nil;
  EVP_bf_ofb := nil;
  EVP_cast5_ecb := nil;
  EVP_cast5_cbc := nil;
  EVP_cast5_cfb64 := nil;
  EVP_cast5_ofb := nil;
  EVP_rc5_32_12_16_cbc := nil;
  EVP_rc5_32_12_16_ecb := nil;
  EVP_rc5_32_12_16_cfb64 := nil;
  EVP_rc5_32_12_16_ofb := nil;
  EVP_aes_128_ecb := nil;
  EVP_aes_128_cbc := nil;
  EVP_aes_128_cfb1 := nil;
  EVP_aes_128_cfb8 := nil;
  EVP_aes_128_cfb128 := nil;
  EVP_aes_128_ofb := nil;
  EVP_aes_128_ctr := nil;
  EVP_aes_128_ccm := nil;
  EVP_aes_128_gcm := nil;
  EVP_aes_128_xts := nil;
  EVP_aes_128_wrap := nil;
  EVP_aes_128_wrap_pad := nil;
  EVP_aes_128_ocb := nil;
  EVP_aes_192_ecb := nil;
  EVP_aes_192_cbc := nil;
  EVP_aes_192_cfb1 := nil;
  EVP_aes_192_cfb8 := nil;
  EVP_aes_192_cfb128 := nil;
  EVP_aes_192_ofb := nil;
  EVP_aes_192_ctr := nil;
  EVP_aes_192_ccm := nil;
  EVP_aes_192_gcm := nil;
  EVP_aes_192_wrap := nil;
  EVP_aes_192_wrap_pad := nil;
  EVP_aes_192_ocb := nil;
  EVP_aes_256_ecb := nil;
  EVP_aes_256_cbc := nil;
  EVP_aes_256_cfb1 := nil;
  EVP_aes_256_cfb8 := nil;
  EVP_aes_256_cfb128 := nil;
  EVP_aes_256_ofb := nil;
  EVP_aes_256_ctr := nil;
  EVP_aes_256_ccm := nil;
  EVP_aes_256_gcm := nil;
  EVP_aes_256_xts := nil;
  EVP_aes_256_wrap := nil;
  EVP_aes_256_wrap_pad := nil;
  EVP_aes_256_ocb := nil;
  EVP_aes_128_cbc_hmac_sha1 := nil;
  EVP_aes_256_cbc_hmac_sha1 := nil;
  EVP_aes_128_cbc_hmac_sha256 := nil;
  EVP_aes_256_cbc_hmac_sha256 := nil;
  EVP_aria_128_ecb := nil;
  EVP_aria_128_cbc := nil;
  EVP_aria_128_cfb1 := nil;
  EVP_aria_128_cfb8 := nil;
  EVP_aria_128_cfb128 := nil;
  EVP_aria_128_ctr := nil;
  EVP_aria_128_ofb := nil;
  EVP_aria_128_gcm := nil;
  EVP_aria_128_ccm := nil;
  EVP_aria_192_ecb := nil;
  EVP_aria_192_cbc := nil;
  EVP_aria_192_cfb1 := nil;
  EVP_aria_192_cfb8 := nil;
  EVP_aria_192_cfb128 := nil;
  EVP_aria_192_ctr := nil;
  EVP_aria_192_ofb := nil;
  EVP_aria_192_gcm := nil;
  EVP_aria_192_ccm := nil;
  EVP_aria_256_ecb := nil;
  EVP_aria_256_cbc := nil;
  EVP_aria_256_cfb1 := nil;
  EVP_aria_256_cfb8 := nil;
  EVP_aria_256_cfb128 := nil;
  EVP_aria_256_ctr := nil;
  EVP_aria_256_ofb := nil;
  EVP_aria_256_gcm := nil;
  EVP_aria_256_ccm := nil;
  EVP_camellia_128_ecb := nil;
  EVP_camellia_128_cbc := nil;
  EVP_camellia_128_cfb1 := nil;
  EVP_camellia_128_cfb8 := nil;
  EVP_camellia_128_cfb128 := nil;
  EVP_camellia_128_ofb := nil;
  EVP_camellia_128_ctr := nil;
  EVP_camellia_192_ecb := nil;
  EVP_camellia_192_cbc := nil;
  EVP_camellia_192_cfb1 := nil;
  EVP_camellia_192_cfb8 := nil;
  EVP_camellia_192_cfb128 := nil;
  EVP_camellia_192_ofb := nil;
  EVP_camellia_192_ctr := nil;
  EVP_camellia_256_ecb := nil;
  EVP_camellia_256_cbc := nil;
  EVP_camellia_256_cfb1 := nil;
  EVP_camellia_256_cfb8 := nil;
  EVP_camellia_256_cfb128 := nil;
  EVP_camellia_256_ofb := nil;
  EVP_camellia_256_ctr := nil;
  EVP_chacha20 := nil;
  EVP_chacha20_poly1305 := nil;
  EVP_seed_ecb := nil;
  EVP_seed_cbc := nil;
  EVP_seed_cfb128 := nil;
  EVP_seed_ofb := nil;
  EVP_sm4_ecb := nil;
  EVP_sm4_cbc := nil;
  EVP_sm4_cfb128 := nil;
  EVP_sm4_ofb := nil;
  EVP_sm4_ctr := nil;
  EVP_add_cipher := nil;
  EVP_add_digest := nil;
  EVP_get_cipherbyname := nil;
  EVP_get_digestbyname := nil;
  EVP_CIPHER_do_all := nil;
  EVP_CIPHER_do_all_sorted := nil;
  EVP_MD_do_all := nil;
  EVP_MD_do_all_sorted := nil;
  EVP_PKEY_decrypt_old := nil;
  EVP_PKEY_encrypt_old := nil;
  EVP_PKEY_type := nil;
  EVP_PKEY_id := nil;
  EVP_PKEY_base_id := nil;
  EVP_PKEY_bits := nil;
  EVP_PKEY_security_bits := nil;
  EVP_PKEY_size := nil;
  EVP_PKEY_set_type := nil;
  EVP_PKEY_set_type_str := nil;
  EVP_PKEY_set_alias_type := nil;
  EVP_PKEY_set1_engine := nil;
  EVP_PKEY_get0_engine := nil;
  EVP_PKEY_assign := nil;
  EVP_PKEY_get0 := nil;
  EVP_PKEY_get0_hmac := nil;
  EVP_PKEY_get0_poly1305 := nil;
  EVP_PKEY_get0_siphash := nil;
  EVP_PKEY_set1_RSA := nil;
  EVP_PKEY_get0_RSA := nil;
  EVP_PKEY_get1_RSA := nil;
  EVP_PKEY_set1_DSA := nil;
  EVP_PKEY_get0_DSA := nil;
  EVP_PKEY_get1_DSA := nil;
  EVP_PKEY_set1_DH := nil;
  EVP_PKEY_get0_DH := nil;
  EVP_PKEY_get1_DH := nil;
  EVP_PKEY_set1_EC_KEY := nil;
  EVP_PKEY_get0_EC_KEY := nil;
  EVP_PKEY_get1_EC_KEY := nil;
  EVP_PKEY_new := nil;
  EVP_PKEY_up_ref := nil;
  EVP_PKEY_free := nil;
  d2i_PublicKey := nil;
  i2d_PublicKey := nil;
  d2i_PrivateKey := nil;
  d2i_AutoPrivateKey := nil;
  i2d_PrivateKey := nil;
  EVP_PKEY_copy_parameters := nil;
  EVP_PKEY_missing_parameters := nil;
  EVP_PKEY_save_parameters := nil;
  EVP_PKEY_cmp_parameters := nil;
  EVP_PKEY_cmp := nil;
  EVP_PKEY_print_public := nil;
  EVP_PKEY_print_private := nil;
  EVP_PKEY_print_params := nil;
  EVP_PKEY_get_default_digest_nid := nil;
  EVP_PKEY_set1_tls_encodedpoint := nil;
  EVP_PKEY_get1_tls_encodedpoint := nil;
  EVP_CIPHER_type := nil;
  EVP_CIPHER_param_to_asn1 := nil;
  EVP_CIPHER_asn1_to_param := nil;
  EVP_CIPHER_set_asn1_iv := nil;
  EVP_CIPHER_get_asn1_iv := nil;
  PKCS5_PBE_keyivgen := nil;
  PKCS5_PBKDF2_HMAC_SHA1 := nil;
  PKCS5_PBKDF2_HMAC := nil;
  PKCS5_v2_PBE_keyivgen := nil;
  EVP_PBE_scrypt := nil;
  PKCS5_v2_scrypt_keyivgen := nil;
  PKCS5_PBE_add := nil;
  EVP_PBE_CipherInit := nil;
  EVP_PBE_alg_add_type := nil;
  EVP_PBE_alg_add := nil;
  EVP_PBE_find := nil;
  EVP_PBE_cleanup := nil;
  EVP_PBE_get := nil;
  EVP_PKEY_asn1_get_count := nil;
  EVP_PKEY_asn1_get0 := nil;
  EVP_PKEY_asn1_find := nil;
  EVP_PKEY_asn1_find_str := nil;
  EVP_PKEY_asn1_add0 := nil;
  EVP_PKEY_asn1_add_alias := nil;
  EVP_PKEY_asn1_get0_info := nil;
  EVP_PKEY_get0_asn1 := nil;
  EVP_PKEY_asn1_new := nil;
  EVP_PKEY_asn1_copy := nil;
  EVP_PKEY_asn1_free := nil;
  EVP_PKEY_asn1_set_public := nil;
  EVP_PKEY_asn1_set_private := nil;
  EVP_PKEY_asn1_set_param := nil;
  EVP_PKEY_asn1_set_free := nil;
  EVP_PKEY_asn1_set_ctrl := nil;
  EVP_PKEY_asn1_set_item := nil;
  EVP_PKEY_asn1_set_siginf := nil;
  EVP_PKEY_asn1_set_check := nil;
  EVP_PKEY_asn1_set_public_check := nil;
  EVP_PKEY_asn1_set_param_check := nil;
  EVP_PKEY_asn1_set_set_priv_key := nil;
  EVP_PKEY_asn1_set_set_pub_key := nil;
  EVP_PKEY_asn1_set_get_priv_key := nil;
  EVP_PKEY_asn1_set_get_pub_key := nil;
  EVP_PKEY_asn1_set_security_bits := nil;
  EVP_PKEY_meth_find := nil;
  EVP_PKEY_meth_new := nil;
  EVP_PKEY_meth_get0_info := nil;
  EVP_PKEY_meth_copy := nil;
  EVP_PKEY_meth_free := nil;
  EVP_PKEY_meth_add0 := nil;
  EVP_PKEY_meth_remove := nil;
  EVP_PKEY_meth_get_count := nil;
  EVP_PKEY_meth_get0 := nil;
  EVP_PKEY_CTX_new := nil;
  EVP_PKEY_CTX_new_id := nil;
  EVP_PKEY_CTX_dup := nil;
  EVP_PKEY_CTX_free := nil;
  EVP_PKEY_CTX_ctrl := nil;
  EVP_PKEY_CTX_ctrl_str := nil;
  EVP_PKEY_CTX_ctrl_uint64 := nil;
  EVP_PKEY_CTX_str2ctrl := nil;
  EVP_PKEY_CTX_hex2ctrl := nil;
  EVP_PKEY_CTX_md := nil;
  EVP_PKEY_CTX_get_operation := nil;
  EVP_PKEY_CTX_set0_keygen_info := nil;
  EVP_PKEY_new_mac_key := nil;
  EVP_PKEY_new_raw_private_key := nil;
  EVP_PKEY_new_raw_public_key := nil;
  EVP_PKEY_get_raw_private_key := nil;
  EVP_PKEY_get_raw_public_key := nil;
  EVP_PKEY_new_CMAC_key := nil;
  EVP_PKEY_CTX_set_data := nil;
  EVP_PKEY_CTX_get_data := nil;
  EVP_PKEY_CTX_get0_pkey := nil;
  EVP_PKEY_CTX_get0_peerkey := nil;
  EVP_PKEY_CTX_set_app_data := nil;
  EVP_PKEY_CTX_get_app_data := nil;
  EVP_PKEY_sign_init := nil;
  EVP_PKEY_sign := nil;
  EVP_PKEY_verify_init := nil;
  EVP_PKEY_verify := nil;
  EVP_PKEY_verify_recover_init := nil;
  EVP_PKEY_verify_recover := nil;
  EVP_PKEY_encrypt_init := nil;
  EVP_PKEY_encrypt := nil;
  EVP_PKEY_decrypt_init := nil;
  EVP_PKEY_decrypt := nil;
  EVP_PKEY_derive_init := nil;
  EVP_PKEY_derive_set_peer := nil;
  EVP_PKEY_derive := nil;
  EVP_PKEY_paramgen_init := nil;
  EVP_PKEY_paramgen := nil;
  EVP_PKEY_keygen_init := nil;
  EVP_PKEY_keygen := nil;
  EVP_PKEY_check := nil;
  EVP_PKEY_public_check := nil;
  EVP_PKEY_param_check := nil;
  EVP_PKEY_CTX_set_cb := nil;
  EVP_PKEY_CTX_get_cb := nil;
  EVP_PKEY_CTX_get_keygen_info := nil;
  EVP_PKEY_meth_set_init := nil;
  EVP_PKEY_meth_set_copy := nil;
  EVP_PKEY_meth_set_cleanup := nil;
  EVP_PKEY_meth_set_paramgen := nil;
  EVP_PKEY_meth_set_keygen := nil;
  EVP_PKEY_meth_set_sign := nil;
  EVP_PKEY_meth_set_verify := nil;
  EVP_PKEY_meth_set_verify_recover := nil;
  EVP_PKEY_meth_set_signctx := nil;
  EVP_PKEY_meth_set_verifyctx := nil;
  EVP_PKEY_meth_set_encrypt := nil;
  EVP_PKEY_meth_set_decrypt := nil;
  EVP_PKEY_meth_set_derive := nil;
  EVP_PKEY_meth_set_ctrl := nil;
  EVP_PKEY_meth_set_digestsign := nil;
  EVP_PKEY_meth_set_digestverify := nil;
  EVP_PKEY_meth_set_check := nil;
  EVP_PKEY_meth_set_public_check := nil;
  EVP_PKEY_meth_set_param_check := nil;
  EVP_PKEY_meth_set_digest_custom := nil;
  EVP_PKEY_meth_get_init := nil;
  EVP_PKEY_meth_get_copy := nil;
  EVP_PKEY_meth_get_cleanup := nil;
  EVP_PKEY_meth_get_paramgen := nil;
  EVP_PKEY_meth_get_keygen := nil;
  EVP_PKEY_meth_get_sign := nil;
  EVP_PKEY_meth_get_verify := nil;
  EVP_PKEY_meth_get_verify_recover := nil;
  EVP_PKEY_meth_get_signctx := nil;
  EVP_PKEY_meth_get_verifyctx := nil;
  EVP_PKEY_meth_get_encrypt := nil;
  EVP_PKEY_meth_get_decrypt := nil;
  EVP_PKEY_meth_get_derive := nil;
  EVP_PKEY_meth_get_ctrl := nil;
  EVP_PKEY_meth_get_digestsign := nil;
  EVP_PKEY_meth_get_digestverify := nil;
  EVP_PKEY_meth_get_check := nil;
  EVP_PKEY_meth_get_public_check := nil;
  EVP_PKEY_meth_get_param_check := nil;
  EVP_PKEY_meth_get_digest_custom := nil;
  EVP_add_alg_module := nil;
end;

//#  define EVP_PKEY_assign_RSA(pkey,rsa) EVP_PKEY_assign((pkey),EVP_PKEY_RSA, (char *)(rsa))
function EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_RSA, rsa);
end;

//#  define EVP_PKEY_assign_DSA(pkey,dsa) EVP_PKEY_assign((pkey),EVP_PKEY_DSA, (char *)(dsa))
function EVP_PKEY_assign_DSA(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_DSA, dsa);
end;

//#  define EVP_PKEY_assign_DH(pkey,dh) EVP_PKEY_assign((pkey),EVP_PKEY_DH, (char *)(dh))
function EVP_PKEY_assign_DH(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_DH, dh);
end;

//#  define EVP_PKEY_assign_EC_KEY(pkey,eckey) EVP_PKEY_assign((pkey),EVP_PKEY_EC, (char *)(eckey))
function EVP_PKEY_assign_EC_KEY(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_EC, eckey);
end;

//#  define EVP_PKEY_assign_SIPHASH(pkey,shkey) EVP_PKEY_assign((pkey),EVP_PKEY_SIPHASH, (char *)(shkey))
function EVP_PKEY_assign_SIPHASH(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_SIPHASH, shkey);
end;

//#  define EVP_PKEY_assign_POLY1305(pkey,polykey) EVP_PKEY_assign((pkey),EVP_PKEY_POLY1305, (char *)(polykey))
function EVP_PKEY_assign_POLY1305(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_POLY1305, polykey);
end;

end.
