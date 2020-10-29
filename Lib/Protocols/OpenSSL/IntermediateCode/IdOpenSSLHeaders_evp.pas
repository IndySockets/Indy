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

unit IdOpenSSLHeaders_evp;

interface

// Headers for OpenSSL 1.1.1
// evp.h

{$i IdCompilerDefines.inc}

uses
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

var
  function EVP_MD_meth_new(md_type: TIdC_INT; pkey_type: TIdC_INT): PEVP_MD;
  function EVP_MD_meth_dup(const md: PEVP_MD): PEVP_MD;
  procedure EVP_MD_meth_free(md: PEVP_MD);

  function EVP_MD_meth_set_input_blocksize(md: PEVP_MD; blocksize: TIdC_INT): TIdC_INT;
  function EVP_MD_meth_set_result_size(md: PEVP_MD; resultsize: TIdC_INT): TIdC_INT;
  function EVP_MD_meth_set_app_datasize(md: PEVP_MD; datasize: TIdC_INT): TIdC_INT;
  function EVP_MD_meth_set_flags(md: PEVP_MD; flags: TIdC_ULONG): TIdC_INT;
  function EVP_MD_meth_set_init(md: PEVP_MD; init: EVP_MD_meth_init): TIdC_INT;
  function EVP_MD_meth_set_update(md: PEVP_MD; update: EVP_MD_meth_update): TIdC_INT;
  function EVP_MD_meth_set_final(md: PEVP_MD; final_: EVP_MD_meth_final): TIdC_INT;
  function EVP_MD_meth_set_copy(md: PEVP_MD; copy: EVP_MD_meth_copy): TIdC_INT;
  function EVP_MD_meth_set_cleanup(md: PEVP_MD; cleanup: EVP_MD_meth_cleanup): TIdC_INT;
  function EVP_MD_meth_set_ctrl(md: PEVP_MD; ctrl: EVP_MD_meth_ctrl): TIdC_INT;

  function EVP_MD_meth_get_input_blocksize(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_meth_get_result_size(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_meth_get_app_datasize(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_meth_get_flags(const md: PEVP_MD): TIdC_ULONG;
  function EVP_MD_meth_get_init(const md: PEVP_MD): EVP_MD_meth_init;
  function EVP_MD_meth_get_update(const md: PEVP_MD): EVP_MD_meth_update;
  function EVP_MD_meth_get_final(const md: PEVP_MD): EVP_MD_meth_final;
  function EVP_MD_meth_get_copy(const md: PEVP_MD): EVP_MD_meth_copy;
  function EVP_MD_meth_get_cleanup(const md: PEVP_MD): EVP_MD_meth_cleanup;
  function EVP_MD_meth_get_ctrl(const md: PEVP_MD): EVP_MD_meth_ctrl;

  function EVP_CIPHER_meth_new(cipher_type: TIdC_INT; block_size: TIdC_INT; key_len: TIdC_INT): PEVP_CIPHER;
  function EVP_CIPHER_meth_dup(const cipher: PEVP_CIPHER): PEVP_CIPHER;
  procedure EVP_CIPHER_meth_free(cipher: PEVP_CIPHER);

  function EVP_CIPHER_meth_set_iv_length(cipher: PEVP_CIPHER; iv_len: TIdC_INT): TIdC_INT;
  function EVP_CIPHER_meth_set_flags(cipher: PEVP_CIPHER; flags: TIdC_ULONG): TIdC_INT;
  function EVP_CIPHER_meth_set_impl_ctx_size(cipher: PEVP_CIPHER; ctx_size: TIdC_INT): TIdC_INT;
  function EVP_CIPHER_meth_set_init(cipher: PEVP_CIPHER; init: EVP_CIPHER_meth_init): TIdC_INT;
  function EVP_CIPHER_meth_set_do_cipher(cipher: PEVP_CIPHER; do_cipher: EVP_CIPHER_meth_do_cipher): TIdC_INT;
  function EVP_CIPHER_meth_set_cleanup(cipher: PEVP_CIPHER; cleanup: EVP_CIPHER_meth_cleanup): TIdC_INT;
  function EVP_CIPHER_meth_set_set_asn1_params(cipher: PEVP_CIPHER; set_asn1_parameters: EVP_CIPHER_meth_set_asn1_params): TIdC_INT;
  function EVP_CIPHER_meth_set_get_asn1_params(cipher: PEVP_CIPHER; get_asn1_parameters: EVP_CIPHER_meth_get_asn1_params): TIdC_INT;
  function EVP_CIPHER_meth_set_ctrl(cipher: PEVP_CIPHER; ctrl: EVP_CIPHER_meth_ctrl): TIdC_INT;
  function EVP_CIPHER_meth_get_init(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_init;
  function EVP_CIPHER_meth_get_do_cipher(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_do_cipher;
  function EVP_CIPHER_meth_get_cleanup(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_cleanup;
  function EVP_CIPHER_meth_get_set_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_set_asn1_params;
  function EVP_CIPHER_meth_get_get_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_get_asn1_params;
  function EVP_CIPHER_meth_get_ctrl(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_ctrl;

  /// Add some extra combinations ///
  //# define EVP_get_digestbynid(a) EVP_get_digestbyname(OBJ_nid2sn(a));
  //# define EVP_get_digestbyobj(a) EVP_get_digestbynid(OBJ_obj2nid(a));
  //# define EVP_get_cipherbynid(a) EVP_get_cipherbyname(OBJ_nid2sn(a));
  //# define EVP_get_cipherbyobj(a) EVP_get_cipherbynid(OBJ_obj2nid(a));

  function EVP_MD_type(const md: PEVP_MD): TIdC_INT;
  //# define EVP_MD_nid(e)                   EVP_MD_type(e)
  //# define EVP_MD_name(e)                  OBJ_nid2sn(EVP_MD_nid(e))
  function EVP_MD_pkey_type(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_size(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_block_size(const md: PEVP_MD): TIdC_INT;
  function EVP_MD_flags(const md: PEVP_MD): PIdC_ULONG;

  function EVP_MD_CTX_md(ctx: PEVP_MD_CTX): PEVP_MD;
  function EVP_MD_CTX_update_fn(ctx: PEVP_MD_CTX): EVP_MD_CTX_update;
  procedure EVP_MD_CTX_set_update_fn(ctx: PEVP_MD_CTX; update: EVP_MD_CTX_update);
  //  EVP_MD_CTX_size(e)              EVP_MD_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_block_size(e)        EVP_MD_block_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_type(e)              EVP_MD_type(EVP_MD_CTX_md(e))
  function EVP_MD_CTX_pkey_ctx(const ctx: PEVP_MD_CTX): PEVP_PKEY_CTX;
  procedure EVP_MD_CTX_set_pkey_ctx(ctx: PEVP_MD_CTX; pctx: PEVP_PKEY_CTX);
  function EVP_MD_CTX_md_data(const ctx: PEVP_MD_CTX): Pointer;

  function EVP_CIPHER_nid(const ctx: PEVP_MD_CTX): TIdC_INT;
  //# define EVP_CIPHER_name(e)              OBJ_nid2sn(EVP_CIPHER_nid(e))
  function EVP_CIPHER_block_size(const cipher: PEVP_CIPHER): TIdC_INT;
  function EVP_CIPHER_impl_ctx_size(const cipher: PEVP_CIPHER): TIdC_INT;
  function EVP_CIPHER_key_length(const cipher: PEVP_CIPHER): TIdC_INT;
  function EVP_CIPHER_iv_length(const cipher: PEVP_CIPHER): TIdC_INT;
  function EVP_CIPHER_flags(const cipher: PEVP_CIPHER): TIdC_ULONG;
  //# define EVP_CIPHER_mode(e)              (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)

  function EVP_CIPHER_CTX_cipher(const ctx: PEVP_CIPHER_CTX): PEVP_CIPHER;
  function EVP_CIPHER_CTX_encrypting(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_nid(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_block_size(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_key_length(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_iv_length(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_iv(const ctx: PEVP_CIPHER_CTX): PByte;
  function EVP_CIPHER_CTX_original_iv(const ctx: PEVP_CIPHER_CTX): PByte;
  function EVP_CIPHER_CTX_iv_noconst(ctx: PEVP_CIPHER_CTX): PByte;
  function EVP_CIPHER_CTX_buf_noconst(ctx: PEVP_CIPHER_CTX): PByte;
  function EVP_CIPHER_CTX_num(const ctx: PEVP_CIPHER_CTX): TIdC_INT;
  procedure EVP_CIPHER_CTX_set_num(ctx: PEVP_CIPHER_CTX; num: TIdC_INT);
  function EVP_CIPHER_CTX_copy(&out: PEVP_CIPHER_CTX; const in_: PEVP_CIPHER_CTX): TIdC_INT;
  function EVP_CIPHER_CTX_get_app_data(const ctx: PEVP_CIPHER_CTX): Pointer;
  procedure EVP_CIPHER_CTX_set_app_data(ctx: PEVP_CIPHER_CTX; data: Pointer);
  function EVP_CIPHER_CTX_get_cipher_data(const ctx: PEVP_CIPHER_CTX): Pointer;
  function EVP_CIPHER_CTX_set_cipher_data(ctx: PEVP_CIPHER_CTX; cipher_data: Pointer): Pointer;

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

  procedure BIO_set_md(v1: PBIO; const md: PEVP_MD);
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

  function EVP_MD_CTX_ctrl(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT;
  function EVP_MD_CTX_new: PEVP_MD_CTX;
  function EVP_MD_CTX_reset(ctx: PEVP_MD_CTX): TIdC_INT;
  procedure EVP_MD_CTX_free(ctx: PEVP_MD_CTX);
  //# define EVP_MD_CTX_create()     EVP_MD_CTX_new()
  //# define EVP_MD_CTX_init(ctx)    EVP_MD_CTX_reset((ctx))
  //# define EVP_MD_CTX_destroy(ctx) EVP_MD_CTX_free((ctx))
  function EVP_MD_CTX_copy_ex(&out: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT;
  procedure EVP_MD_CTX_set_flags(ctx: PEVP_MD_CTX; flags: TIdC_INT);
  procedure EVP_MD_CTX_clear_flags(ctx: PEVP_MD_CTX; flags: TIdC_INT);
  function EVP_MD_CTX_test_flags(const ctx: PEVP_MD_CTX; flags: TIdC_INT): TIdC_INT;
  function EVP_DigestInit_ex(ctx: PEVP_MD_CTX; const type_: PEVP_MD; impl: PENGINE): TIdC_INT;
  function EVP_DigestUpdate(ctx: PEVP_MD_CTX; const d: Pointer; cnt: TIdC_SIZET): TIdC_INT;
  function EVP_DigestFinal_ex(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT;
  function EVP_Digest(const data: Pointer; count: TIdC_SIZET; md: PByte; size: PIdC_UINT; const type_: PEVP_MD; impl: PENGINE): TIdC_INT;

  function EVP_MD_CTX_copy(&out: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT;
  function EVP_DigestInit(ctx: PEVP_MD_CTX; const type_: PEVP_MD): TIdC_INT;
  function EVP_DigestFinal(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT;
  function EVP_DigestFinalXOF(ctx: PEVP_MD_CTX; md: PByte; len: TIdC_SIZET): TIdC_INT;

  function EVP_read_pw_string(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT;
  function EVP_read_pw_string_min(buf: PIdAnsiChar; minlen: TIdC_INT; maxlen: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT;
  procedure EVP_set_pw_prompt(const prompt: PIdAnsiChar);
  function EVP_get_pw_prompt: PIdAnsiChar;
  function EVP_BytesToKey(const type_: PEVP_CIPHER; const md: PEVP_MD; const salt: PByte; const data: PByte; data1: TIdC_INT; count: TIdC_INT; key: PByte; iv: PByte): TIdC_INT;

  procedure EVP_CIPHER_CTX_set_flags(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT);
  procedure EVP_CIPHER_CTX_clear_flags(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT);
  function EVP_CIPHER_CTX_test_flags(const ctx: PEVP_CIPHER_CTX; flags: TIdC_INT): TIdC_INT;

  function EVP_EncryptInit(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte): TIdC_INT;
  function EVP_EncryptInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT;
  function EVP_EncryptUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; &in1: TIdC_INT): TIdC_INT;
  function EVP_EncryptFinal_ex(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT;
  function EVP_EncryptFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT;

  function EVP_DecryptInit(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PidC_INT): TIdC_INT;
  function EVP_DecryptInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT;
  function EVP_DecryptUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; &in1: TIdC_INT): TIdC_INT;
  function EVP_DecryptFinal(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT;
  function EVP_DecryptFinal_ex(ctx: PEVP_MD_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT;

  function EVP_CipherInit(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte; enc: TIdC_INT): TIdC_INT;
  function EVP_CipherInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte; enc: TidC_INT): TIdC_INT;
  function EVP_CipherUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT;
  function EVP_CipherFinal(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT;
  function EVP_CipherFinal_ex(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT;

  function EVP_SignFinal(ctx: PEVP_CIPHER_CTX; md: PByte; s: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT;

  function EVP_DigestSign(ctx: PEVP_CIPHER_CTX; sigret: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT;

  function EVP_VerifyFinal(ctx: PEVP_MD_CTX; const sigbuf: PByte; siglen: TIdC_UINT; pkey: PEVP_PKEY): TIdC_INT;

  function EVP_DigestVerify(ctx: PEVP_CIPHER_CTX; const sigret: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT;

  function EVP_DigestSignInit(ctx: PEVP_MD_CTX; pctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT;
  function EVP_DigestSignFinal(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_SIZET): TIdC_INT;

  function EVP_DigestVerifyInit(ctx: PEVP_MD_CTX; ppctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT;
  function EVP_DigestVerifyFinal(ctx: PEVP_MD_CTX; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT;

  function EVP_OpenInit(ctx: PEVP_CIPHER_CTX; const type_: PEVP_CIPHER; const ek: PByte; ek1: TIdC_INT; const iv: PByte; priv: PEVP_PKEY): TIdC_INT;
  function EVP_OpenFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT;

  function EVP_SealInit(ctx: PEVP_CIPHER_CTX; const type_: EVP_CIPHER; ek: PPByte; ek1: PIdC_INT; iv: PByte; pubk: PPEVP_PKEY; npubk: TIdC_INT): TIdC_INT;
  function EVP_SealFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT;

  function EVP_ENCODE_CTX_new: PEVP_ENCODE_CTX;
  procedure EVP_ENCODE_CTX_free(ctx: PEVP_ENCODE_CTX);
  function EVP_ENCODE_CTX_copy(dctx: PEVP_ENCODE_CTX; sctx: PEVP_ENCODE_CTX): TIdC_INT;
  function EVP_ENCODE_CTX_num(ctx: PEVP_ENCODE_CTX): TIdC_INT;
  procedure EVP_EncodeInit(ctx: PEVP_ENCODE_CTX);
  function EVP_EncodeUpdate(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT;
  procedure EVP_EncodeFinal(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT);
  function EVP_EncodeBlock(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT;

  procedure EVP_DecodeInit(ctx: PEVP_ENCODE_CTX);
  function EVP_DecodeUpdate(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT;
  function EVP_DecodeFinal(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT;
  function EVP_DecodeBlock(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT;

  function EVP_CIPHER_CTX_new: PEVP_CIPHER_CTX;
  function EVP_CIPHER_CTX_reset(c: PEVP_CIPHER_CTX): TIdC_INT;
  procedure EVP_CIPHER_CTX_free(c: PEVP_CIPHER_CTX);
  function EVP_CIPHER_CTX_set_key_length(x: PEVP_CIPHER_CTX; keylen: TIdC_INT): TIdC_INT;
  function EVP_CIPHER_CTX_set_padding(c: PEVP_CIPHER_CTX; pad: TIdC_INT): TIdC_INT;
  function EVP_CIPHER_CTX_ctrl(ctx: PEVP_CIPHER_CTX; type_: TIdC_INT; arg: TIdC_INT; ptr: Pointer): TIdC_INT;
  function EVP_CIPHER_CTX_rand_key(ctx: PEVP_CIPHER_CTX; key: PByte): TIdC_INT;

  function BIO_f_md: PBIO_METHOD;
  function BIO_f_base64: PBIO_METHOD;
  function BIO_f_cipher: PBIO_METHOD;
  function BIO_f_reliable: PBIO_METHOD;
  function BIO_set_cipher(b: PBIO; c: PEVP_CIPHER; const k: PByte; const i: PByte; enc: TIdC_INT): TIdC_INT;

  function EVP_md_null: PEVP_MD;

  function EVP_md5: PEVP_MD;
  function EVP_md5_sha1: PEVP_MD;

  function EVP_sha1: PEVP_MD;
  function EVP_sha224: PEVP_MD;
  function EVP_sha256: PEVP_MD;
  function EVP_sha384: PEVP_MD;
  function EVP_sha512: PEVP_MD;
  function EVP_sha512_224: PEVP_MD;
  function EVP_sha512_256: PEVP_MD;
  function EVP_sha3_224: PEVP_MD;
  function EVP_sha3_256: PEVP_MD;
  function EVP_sha3_384: PEVP_MD;
  function EVP_sha3_512: PEVP_MD;
  function EVP_shake128: PEVP_MD;
  function EVP_shake256: PEVP_MD;

  (* does nothing :-) *)
  function EVP_enc_null: PEVP_CIPHER;

  function EVP_des_ecb: PEVP_CIPHER;
  function EVP_des_ede: PEVP_CIPHER;
  function EVP_des_ede3: PEVP_CIPHER;
  function EVP_des_ede_ecb: PEVP_CIPHER;
  function EVP_des_ede3_ecb: PEVP_CIPHER;
  function EVP_des_cfb64: PEVP_CIPHER;
  //EVP_des_cfb EVP_des_cfb64
  function EVP_des_cfb1: PEVP_CIPHER;
  function EVP_des_cfb8: PEVP_CIPHER;
  function EVP_des_ede_cfb64: PEVP_CIPHER;
  function EVP_des_ede3_cfb64: PEVP_CIPHER;
  //EVP_des_ede3_cfb EVP_des_ede3_cfb64
  function EVP_des_ede3_cfb1: PEVP_CIPHER;
  function EVP_des_ede3_cfb8: PEVP_CIPHER;
  function EVP_des_ofb: PEVP_CIPHER;
  function EVP_des_ede_ofb: PEVP_CIPHER;
  function EVP_des_ede3_ofb: PEVP_CIPHER;
  function EVP_des_cbc: PEVP_CIPHER;
  function EVP_des_ede_cbc: PEVP_CIPHER;
  function EVP_des_ede3_cbc: PEVP_CIPHER;
  function EVP_desx_cbc: PEVP_CIPHER;
  function EVP_des_ede3_wrap: PEVP_CIPHER;
  //
  // This should now be supported through the dev_crypto ENGINE. But also, why
  // are rc4 and md5 declarations made here inside a "NO_DES" precompiler
  // branch?
  //
  function EVP_rc4: PEVP_CIPHER;
  function EVP_rc4_40: PEVP_CIPHER;
  function EVP_idea_ecb: PEVP_CIPHER;
  function EVP_idea_cfb64: PEVP_CIPHER;
  //EVP_idea_cfb EVP_idea_cfb64
  function EVP_idea_ofb: PEVP_CIPHER;
  function EVP_idea_cbc: PEVP_CIPHER;
  function EVP_rc2_ecb: PEVP_CIPHER;
  function EVP_rc2_cbc: PEVP_CIPHER;
  function EVP_rc2_40_cbc: PEVP_CIPHER;
  function EVP_rc2_64_cbc: PEVP_CIPHER;
  function EVP_rc2_cfb64: PEVP_CIPHER;
  //EVP_rc2_cfb EVP_rc2_cfb64
  function EVP_rc2_ofb: PEVP_CIPHER;
  function EVP_bf_ecb: PEVP_CIPHER;
  function EVP_bf_cbc: PEVP_CIPHER;
  function EVP_bf_cfb64: PEVP_CIPHER;
  //EVP_bf_cfb EVP_bf_cfb64
  function EVP_bf_ofb: PEVP_CIPHER;
  function EVP_cast5_ecb: PEVP_CIPHER;
  function EVP_cast5_cbc: PEVP_CIPHER;
  function EVP_cast5_cfb64: PEVP_CIPHER;
  //EVP_cast5_cfb EVP_cast5_cfb64
  function EVP_cast5_ofb: PEVP_CIPHER;
  function EVP_rc5_32_12_16_cbc: PEVP_CIPHER;
  function EVP_rc5_32_12_16_ecb: PEVP_CIPHER;
  function EVP_rc5_32_12_16_cfb64: PEVP_CIPHER;
  //EVP_rc5_32_12_16_cfb EVP_rc5_32_12_16_cfb64
  function EVP_rc5_32_12_16_ofb: PEVP_CIPHER;

  function EVP_aes_128_ecb: PEVP_CIPHER;
  function EVP_aes_128_cbc: PEVP_CIPHER;
  function EVP_aes_128_cfb1: PEVP_CIPHER;
  function EVP_aes_128_cfb8: PEVP_CIPHER;
  function EVP_aes_128_cfb128: PEVP_CIPHER;
  //EVP_aes_128_cfb EVP_aes_128_cfb128
  function EVP_aes_128_ofb: PEVP_CIPHER;
  function EVP_aes_128_ctr: PEVP_CIPHER;
  function EVP_aes_128_ccm: PEVP_CIPHER;
  function EVP_aes_128_gcm: PEVP_CIPHER;
  function EVP_aes_128_xts: PEVP_CIPHER;
  function EVP_aes_128_wrap: PEVP_CIPHER;
  function EVP_aes_128_wrap_pad: PEVP_CIPHER;
  function EVP_aes_128_ocb: PEVP_CIPHER;
  function EVP_aes_192_ecb: PEVP_CIPHER;
  function EVP_aes_192_cbc: PEVP_CIPHER;
  function EVP_aes_192_cfb1: PEVP_CIPHER;
  function EVP_aes_192_cfb8: PEVP_CIPHER;
  function EVP_aes_192_cfb128: PEVP_CIPHER;
  //EVP_aes_192_cfb EVP_aes_192_cfb128
  function EVP_aes_192_ofb: PEVP_CIPHER;
  function EVP_aes_192_ctr: PEVP_CIPHER;
  function EVP_aes_192_ccm: PEVP_CIPHER;
  function EVP_aes_192_gcm: PEVP_CIPHER;
  function EVP_aes_192_wrap: PEVP_CIPHER;
  function EVP_aes_192_wrap_pad: PEVP_CIPHER;
  function EVP_aes_192_ocb: PEVP_CIPHER;
  function EVP_aes_256_ecb: PEVP_CIPHER;
  function EVP_aes_256_cbc: PEVP_CIPHER;
  function EVP_aes_256_cfb1: PEVP_CIPHER;
  function EVP_aes_256_cfb8: PEVP_CIPHER;
  function EVP_aes_256_cfb128: PEVP_CIPHER;
  //EVP_aes_256_cfb EVP_aes_256_cfb128
  function EVP_aes_256_ofb: PEVP_CIPHER;
  function EVP_aes_256_ctr: PEVP_CIPHER;
  function EVP_aes_256_ccm: PEVP_CIPHER;
  function EVP_aes_256_gcm: PEVP_CIPHER;
  function EVP_aes_256_xts: PEVP_CIPHER;
  function EVP_aes_256_wrap: PEVP_CIPHER;
  function EVP_aes_256_wrap_pad: PEVP_CIPHER;
  function EVP_aes_256_ocb: PEVP_CIPHER;
  function EVP_aes_128_cbc_hmac_sha1: PEVP_CIPHER;
  function EVP_aes_256_cbc_hmac_sha1: PEVP_CIPHER;
  function EVP_aes_128_cbc_hmac_sha256: PEVP_CIPHER;
  function EVP_aes_256_cbc_hmac_sha256: PEVP_CIPHER;

  function EVP_aria_128_ecb: PEVP_CIPHER;
  function EVP_aria_128_cbc: PEVP_CIPHER;
  function EVP_aria_128_cfb1: PEVP_CIPHER;
  function EVP_aria_128_cfb8: PEVP_CIPHER;
  function EVP_aria_128_cfb128: PEVP_CIPHER;
  function EVP_aria_128_ctr: PEVP_CIPHER;
  function EVP_aria_128_ofb: PEVP_CIPHER;
  function EVP_aria_128_gcm: PEVP_CIPHER;
  function EVP_aria_128_ccm: PEVP_CIPHER;
  function EVP_aria_192_ecb: PEVP_CIPHER;
  function EVP_aria_192_cbc: PEVP_CIPHER;
  function EVP_aria_192_cfb1: PEVP_CIPHER;
  function EVP_aria_192_cfb8: PEVP_CIPHER;
  function EVP_aria_192_cfb128: PEVP_CIPHER;
  //EVP_aria_192_cfb EVP_aria_192_cfb128
  function EVP_aria_192_ctr: PEVP_CIPHER;
  function EVP_aria_192_ofb: PEVP_CIPHER;
  function EVP_aria_192_gcm: PEVP_CIPHER;
  function EVP_aria_192_ccm: PEVP_CIPHER;
  function EVP_aria_256_ecb: PEVP_CIPHER;
  function EVP_aria_256_cbc: PEVP_CIPHER;
  function EVP_aria_256_cfb1: PEVP_CIPHER;
  function EVP_aria_256_cfb8: PEVP_CIPHER;
  function EVP_aria_256_cfb128: PEVP_CIPHER;
  //EVP_aria_256_cfb EVP_aria_256_cfb128
  function EVP_aria_256_ctr: PEVP_CIPHER;
  function EVP_aria_256_ofb: PEVP_CIPHER;
  function EVP_aria_256_gcm: PEVP_CIPHER;
  function EVP_aria_256_ccm: PEVP_CIPHER;

  function EVP_camellia_128_ecb: PEVP_CIPHER;
  function EVP_camellia_128_cbc: PEVP_CIPHER;
  function EVP_camellia_128_cfb1: PEVP_CIPHER;
  function EVP_camellia_128_cfb8: PEVP_CIPHER;
  function EVP_camellia_128_cfb128: PEVP_CIPHER;
  //EVP_camellia_128_cfb EVP_camellia_128_cfb128
  function EVP_camellia_128_ofb: PEVP_CIPHER;
  function EVP_camellia_128_ctr: PEVP_CIPHER;
  function EVP_camellia_192_ecb: PEVP_CIPHER;
  function EVP_camellia_192_cbc: PEVP_CIPHER;
  function EVP_camellia_192_cfb1: PEVP_CIPHER;
  function EVP_camellia_192_cfb8: PEVP_CIPHER;
  function EVP_camellia_192_cfb128: PEVP_CIPHER;
  //EVP_camellia_192_cfb EVP_camellia_192_cfb128
  function EVP_camellia_192_ofb: PEVP_CIPHER;
  function EVP_camellia_192_ctr: PEVP_CIPHER;
  function EVP_camellia_256_ecb: PEVP_CIPHER;
  function EVP_camellia_256_cbc: PEVP_CIPHER;
  function EVP_camellia_256_cfb1: PEVP_CIPHER;
  function EVP_camellia_256_cfb8: PEVP_CIPHER;
  function EVP_camellia_256_cfb128: PEVP_CIPHER;
  //EVP_camellia_256_cfb EVP_camellia_256_cfb128
  function EVP_camellia_256_ofb: PEVP_CIPHER;
  function EVP_camellia_256_ctr: PEVP_CIPHER;

  function EVP_chacha20: PEVP_CIPHER;
  function EVP_chacha20_poly1305: PEVP_CIPHER;

  function EVP_seed_ecb: PEVP_CIPHER;
  function EVP_seed_cbc: PEVP_CIPHER;
  function EVP_seed_cfb128: PEVP_CIPHER;
  //EVP_seed_cfb EVP_seed_cfb128
  function EVP_seed_ofb: PEVP_CIPHER;

  function EVP_sm4_ecb: PEVP_CIPHER;
  function EVP_sm4_cbc: PEVP_CIPHER;
  function EVP_sm4_cfb128: PEVP_CIPHER;
  //EVP_sm4_cfb EVP_sm4_cfb128
  function EVP_sm4_ofb: PEVP_CIPHER;
  function EVP_sm4_ctr: PEVP_CIPHER;

  function EVP_add_cipher(const cipher: PEVP_CIPHER): TIdC_INT;
  function EVP_add_digest(const digest: PEVP_MD): TIdC_INT;

  function EVP_get_cipherbyname(const name: PIdAnsiChar): PEVP_CIPHER;
  function EVP_get_digestbyname(const name: PIdAnsiChar): PEVP_MD;

  procedure EVP_CIPHER_do_all(AFn: fn; arg: Pointer);
  procedure EVP_CIPHER_do_all_sorted(AFn: fn; arg: Pointer);

  procedure EVP_MD_do_all(AFn: fn; arg: Pointer);
  procedure EVP_MD_do_all_sorted(AFn: fn; arg: Pointer);

  function EVP_PKEY_decrypt_old(dec_key: PByte; const enc_key: PByte; enc_key_len: TIdC_INT; private_key: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_encrypt_old(dec_key: PByte; const enc_key: PByte; key_len: TIdC_INT; pub_key: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_type(&type: TIdC_INT): TIdC_INT;
  function EVP_PKEY_id(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_base_id(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_bits(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_security_bits(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_size(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_set_type(pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_set_type_str(pkey: PEVP_PKEY; const str: PIdAnsiChar; len: TIdC_INT): TIdC_INT;
  function EVP_PKEY_set_alias_type(pkey: PEVP_PKEY; type_: TIdC_INT): TIdC_INT;

  function EVP_PKEY_set1_engine(pkey: PEVP_PKEY; e: PENGINE): TIdC_INT;
  function EVP_PKEY_get0_engine(const pkey: PEVP_PKEY): PENGINE;

  function EVP_PKEY_assign(pkey: PEVP_PKEY; type_: TIdC_INT; key: Pointer): TIdC_INT;
  function EVP_PKEY_get0(const pkey: PEVP_PKEY): Pointer;
  function EVP_PKEY_get0_hmac(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte;
  function EVP_PKEY_get0_poly1305(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte;
  function EVP_PKEY_get0_siphash(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte;

  function EVP_PKEY_set1_RSA(pkey: PEVP_PKEY; key: PRSA): TIdC_INT;
  function EVP_PKEY_get0_RSA(pkey: PEVP_PKEY): PRSA;
  function EVP_PKEY_get1_RSA(pkey: PEVP_PKEY): PRSA;

  function EVP_PKEY_set1_DSA(pkey: PEVP_PKEY; key: PDSA): TIdC_INT;
  function EVP_PKEY_get0_DSA(pkey: PEVP_PKEY): PDSA;
  function EVP_PKEY_get1_DSA(pkey: PEVP_PKEY): PDSA;

  function EVP_PKEY_set1_DH(pkey: PEVP_PKEY; key: PDH): TIdC_INT;
  function EVP_PKEY_get0_DH(pkey: PEVP_PKEY): PDH;
  function EVP_PKEY_get1_DH(pkey: PEVP_PKEY): PDH;

  function EVP_PKEY_set1_EC_KEY(pkey: PEVP_PKEY; key: PEC_KEY): TIdC_INT;
  function EVP_PKEY_get0_EC_KEY(pkey: PEVP_PKEY): PEC_KEY;
  function EVP_PKEY_get1_EC_KEY(pkey: PEVP_PKEY): PEC_KEY;

  function EVP_PKEY_new: PEVP_PKEY;
  function EVP_PKEY_up_ref(pkey: PEVP_PKEY): TIdC_INT;
  procedure EVP_PKEY_free(pkey: PEVP_PKEY);

  function d2i_PublicKey(&type: TIdC_INT; a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY;
  function i2d_PublicKey(a: PEVP_PKEY; pp: PPByte): TIdC_INT;

  function d2i_PrivateKey(&type: TIdC_INT; a: PEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY;
  function d2i_AutoPrivateKey(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY;
  function i2d_PrivateKey(a: PEVP_PKEY; pp: PPByte): TIdC_INT;

  function EVP_PKEY_copy_parameters(&to: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_missing_parameters(const pkey: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_save_parameters(pkey: PEVP_PKEY; mode: TIdC_INT): TIdC_INT;
  function EVP_PKEY_cmp_parameters(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT;

  function EVP_PKEY_cmp(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT;

  function EVP_PKEY_print_public(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT;
  function EVP_PKEY_print_private(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT;
  function EVP_PKEY_print_params(&out: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT;

  function EVP_PKEY_get_default_digest_nid(pkey: PEVP_PKEY; pnid: PIdC_INT): TIdC_INT;

  function EVP_PKEY_set1_tls_encodedpoint(pkey: PEVP_PKEY; const pt: PByte; ptlen: TIdC_SIZET): TIdC_INT;
  function EVP_PKEY_get1_tls_encodedpoint(pkey: PEVP_PKEY; ppt: PPByte): TIdC_SIZET;

  function EVP_CIPHER_type(const ctx: PEVP_CIPHER): TIdC_INT;

  (* calls methods *)
  function EVP_CIPHER_param_to_asn1(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT;
  function EVP_CIPHER_asn1_to_param(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT;

  (* These are used by EVP_CIPHER methods *)
  function EVP_CIPHER_set_asn1_iv(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT;
  function EVP_CIPHER_get_asn1_iv(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT;

  (* PKCS5 password based encryption *)
  function PKCS5_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT;
  function PKCS5_PBKDF2_HMAC_SHA1(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; keylen: TIdC_INT; out_: PByte): TIdC_INT;
  function PKCS5_PBKDF2_HMAC(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const digest: PEVP_MD; keylen: TIdC_INT; out_: PByte): TIdC_INT;
  function PKCS5_v2_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT;

  function EVP_PBE_scrypt(const pass: PIdAnsiChar; passlen: TIdC_SIZET; const salt: PByte; saltlen: TIdC_SIZET; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64; maxmem: TIdC_UINT64; key: PByte; keylen: TIdC_SIZET): TIdC_INT;

  function PKCS5_v2_scrypt_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const c: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT;

  procedure PKCS5_PBE_add;

  function EVP_PBE_CipherInit(pbe_obj: PASN1_OBJECT; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: TIdC_INT): TIdC_INT;

  (* PBE type *)
  function EVP_PBE_alg_add_type(pbe_type: TIdC_INT; pbe_nid: TIdC_INT; cipher_nid: TIdC_INT; md_nid: TIdC_INT; keygen: PEVP_PBE_KEYGEN): TIdC_INT;
  function EVP_PBE_alg_add(nid: TIdC_INT; const cipher: PEVP_CIPHER; const md: PEVP_MD; keygen: PEVP_PBE_KEYGEN): TIdC_INT;
  function EVP_PBE_find(&type: TIdC_INT; pbe_nid: TIdC_INT; pcnid: PIdC_INT; pmnid: PIdC_INT; pkeygen: PPEVP_PBE_KEYGEN): TIdC_INT;
  procedure EVP_PBE_cleanup;
  function EVP_PBE_get(ptype: PIdC_INT; ppbe_nid: PIdC_INT; num: TIdC_SIZET): TIdC_INT;

  function EVP_PKEY_asn1_get_count: TIdC_INT;
  function EVP_PKEY_asn1_get0(idx: TIdC_INT): PEVP_PKEY_ASN1_METHOD;
  function EVP_PKEY_asn1_find(pe: PPENGINE; type_: TIdC_INT): PEVP_PKEY_ASN1_METHOD;
  function EVP_PKEY_asn1_find_str(pe: PPENGINE; const str: PIdAnsiChar; len: TIdC_INT): PEVP_PKEY_ASN1_METHOD;
  function EVP_PKEY_asn1_add0(const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT;
  function EVP_PKEY_asn1_add_alias(&to: TIdC_INT; from: TIdC_INT): TIdC_INT;
  function EVP_PKEY_asn1_get0_info(ppkey_id: PIdC_INT; pkey_base_id: PIdC_INT; ppkey_flags: PIdC_INT; const pinfo: PPIdAnsiChar; const ppem_str: PPIdAnsiChar; const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT;

  function EVP_PKEY_get0_asn1(const pkey: PEVP_PKEY): PEVP_PKEY_ASN1_METHOD;
  function EVP_PKEY_asn1_new(id: TIdC_INT; flags: TIdC_INT; const pem_str: PIdAnsiChar; const info: PIdAnsiChar): PEVP_PKEY_ASN1_METHOD;
  procedure EVP_PKEY_asn1_copy(dst: PEVP_PKEY_ASN1_METHOD; const src: PEVP_PKEY_ASN1_METHOD);
  procedure EVP_PKEY_asn1_free(ameth: PEVP_PKEY_ASN1_METHOD);

  procedure EVP_PKEY_asn1_set_public(ameth: PEVP_PKEY_ASN1_METHOD; APub_decode: pub_decode; APub_encode: pub_encode; APub_cmd: pub_cmd; APub_print: pub_print; APkey_size: pkey_size; APkey_bits: pkey_bits);
  procedure EVP_PKEY_asn1_set_private(ameth: PEVP_PKEY_ASN1_METHOD; APriv_decode: priv_decode; APriv_encode: priv_encode; APriv_print: priv_print);
  procedure EVP_PKEY_asn1_set_param(ameth: PEVP_PKEY_ASN1_METHOD; AParam_decode: param_decode; AParam_encode: param_encode; AParam_missing: param_missing; AParam_copy: param_copy; AParam_cmp: param_cmp; AParam_print: param_print);

  procedure EVP_PKEY_asn1_set_free(ameth: PEVP_PKEY_ASN1_METHOD; APkey_free: pkey_free);
  procedure EVP_PKEY_asn1_set_ctrl(ameth: PEVP_PKEY_ASN1_METHOD; APkey_ctrl: pkey_ctrl);
  procedure EVP_PKEY_asn1_set_item(ameth: PEVP_PKEY_ASN1_METHOD; AItem_verify: item_verify; AItem_sign: item_sign);

  procedure EVP_PKEY_asn1_set_siginf(ameth: PEVP_PKEY_ASN1_METHOD; ASiginf_set: siginf_set);

  procedure EVP_PKEY_asn1_set_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_check: pkey_check);

  procedure EVP_PKEY_asn1_set_public_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_pub_check: pkey_pub_check);

  procedure EVP_PKEY_asn1_set_param_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_param_check: pkey_param_check);

  procedure EVP_PKEY_asn1_set_set_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_priv_key: set_priv_key);
  procedure EVP_PKEY_asn1_set_set_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_pub_key: set_pub_key);
  procedure EVP_PKEY_asn1_set_get_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_priv_key: get_priv_key);
  procedure EVP_PKEY_asn1_set_get_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_pub_key: get_pub_key);

  procedure EVP_PKEY_asn1_set_security_bits(ameth: PEVP_PKEY_ASN1_METHOD; APkey_security_bits: pkey_security_bits);

  function EVP_PKEY_meth_find(&type: TIdC_INT): PEVP_PKEY_METHOD;
  function EVP_PKEY_meth_new(id: TIdC_INT; flags: TIdC_INT): PEVP_PKEY_METHOD;
  procedure EVP_PKEY_meth_get0_info(ppkey_id: PIdC_INT; pflags: PIdC_INT; const meth: PEVP_PKEY_METHOD);
  procedure EVP_PKEY_meth_copy(dst: PEVP_PKEY_METHOD; const src: PEVP_PKEY_METHOD);
  procedure EVP_PKEY_meth_free(pmeth: PEVP_PKEY_METHOD);
  function EVP_PKEY_meth_add0(const pmeth: PEVP_PKEY_METHOD): TIdC_INT;
  function EVP_PKEY_meth_remove(const pmeth: PEVP_PKEY_METHOD): TIdC_INT;
  function EVP_PKEY_meth_get_count: TIdC_SIZET;
  function EVP_PKEY_meth_get0(idx: TIdC_SIZET): PEVP_PKEY_METHOD;

  function EVP_PKEY_CTX_new(pkey: PEVP_PKEY; e: PENGINE): PEVP_PKEY_CTX;
  function EVP_PKEY_CTX_new_id(id: TIdC_INT; e: PENGINE): PEVP_PKEY_CTX;
  function EVP_PKEY_CTX_dup(ctx: PEVP_PKEY_CTX): PEVP_PKEY_CTX;
  procedure EVP_PKEY_CTX_free(ctx: PEVP_PKEY_CTX);

  function EVP_PKEY_CTX_ctrl(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT;
  function EVP_PKEY_CTX_ctrl_str(ctx: PEVP_PKEY_CTX; const type_: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT;
  function EVP_PKEY_CTX_ctrl_uint64(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; value: TIdC_UINT64): TIdC_INT;

  function EVP_PKEY_CTX_str2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const str: PIdAnsiChar): TIdC_INT;
  function EVP_PKEY_CTX_hex2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const hex: PIdAnsiChar): TIdC_INT;

  function EVP_PKEY_CTX_md(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; const md: PIdAnsiChar): TIdC_INT;

  function EVP_PKEY_CTX_get_operation(ctx: PEVP_PKEY_CTX): TIdC_INT;
  procedure EVP_PKEY_CTX_set0_keygen_info(ctx: PEVP_PKEY_CTX; dat: PIdC_INT; datlen: TIdC_INT);

  function EVP_PKEY_new_mac_key(&type: TIdC_INT; e: PENGINE; const key: PByte; keylen: TIdC_INT): PEVP_PKEY;
  function EVP_PKEY_new_raw_private_key(&type: TIdC_INT; e: PENGINE; const priv: PByte; len: TIdC_SIZET): PEVP_PKEY;
  function EVP_PKEY_new_raw_public_key(&type: TIdC_INT; e: PENGINE; const pub: PByte; len: TIdC_SIZET): PEVP_PKEY;
  function EVP_PKEY_get_raw_private_key(const pkey: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT;
  function EVP_PKEY_get_raw_public_key(const pkey: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT;

  function EVP_PKEY_new_CMAC_key(e: PENGINE; const priv: PByte; len: TIdC_SIZET; const cipher: PEVP_CIPHER): PEVP_PKEY;

  procedure EVP_PKEY_CTX_set_data(ctx: PEVP_PKEY_CTX; data: Pointer);
  function EVP_PKEY_CTX_get_data(ctx: PEVP_PKEY_CTX): Pointer;
  function EVP_PKEY_CTX_get0_pkey(ctx: PEVP_PKEY_CTX): PEVP_PKEY;

  function EVP_PKEY_CTX_get0_peerkey(ctx: PEVP_PKEY_CTX): PEVP_PKEY;

  procedure EVP_PKEY_CTX_set_app_data(ctx: PEVP_PKEY_CTX; data: Pointer);
  function EVP_PKEY_CTX_get_app_data(ctx: PEVP_PKEY_CTX): Pointer;

  function EVP_PKEY_sign_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_sign(ctx: PEVP_PKEY_CTX; sig: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT;
  function EVP_PKEY_verify_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_verify(ctx: PEVP_PKEY_CTX; const sig: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT;
  function EVP_PKEY_verify_recover_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_verify_recover(ctx: PEVP_PKEY_CTX; rout: PByte; routlen: PIdC_SIZET; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT;
  function EVP_PKEY_encrypt_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_encrypt(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT;
  function EVP_PKEY_decrypt_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_decrypt(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT;

  function EVP_PKEY_derive_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_derive_set_peer(ctx: PEVP_PKEY_CTX; peer: PEVP_PKEY): TIdC_INT;
  function EVP_PKEY_derive(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT;

  function EVP_PKEY_paramgen_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_paramgen(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT;
  function EVP_PKEY_keygen_init(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_keygen(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT;
  function EVP_PKEY_check(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_public_check(ctx: PEVP_PKEY_CTX): TIdC_INT;
  function EVP_PKEY_param_check(ctx: PEVP_PKEY_CTX): TIdC_INT;

  procedure EVP_PKEY_CTX_set_cb(ctx: PEVP_PKEY_CTX; cb: EVP_PKEY_gen_cb);
  function EVP_PKEY_CTX_get_cb(ctx: PEVP_PKEY_CTX): EVP_PKEY_gen_cb;

  function EVP_PKEY_CTX_get_keygen_info(ctx: PEVP_PKEY_CTX; idx: TIdC_INT): TIdC_INT;

  procedure EVP_PKEY_meth_set_init(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: EVP_PKEY_meth_init);

  procedure EVP_PKEY_meth_set_copy(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy_cb: EVP_PKEY_meth_copy_cb);

  procedure EVP_PKEY_meth_set_cleanup(pmeth: PEVP_PKEY_METHOD; PEVP_PKEY_meth_cleanup: EVP_PKEY_meth_cleanup);

  procedure EVP_PKEY_meth_set_paramgen(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: EVP_PKEY_meth_paramgen_init);

  procedure EVP_PKEY_meth_set_keygen(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: EVP_PKEY_meth_keygen);

  procedure EVP_PKEY_meth_set_sign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: EVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: EVP_PKEY_meth_sign);

  procedure EVP_PKEY_meth_set_verify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: EVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: EVP_PKEY_meth_verify_init);

  procedure EVP_PKEY_meth_set_verify_recover(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: EVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: EVP_PKEY_meth_verify_recover_init);

  procedure EVP_PKEY_meth_set_signctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: EVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: EVP_PKEY_meth_signctx);

  procedure EVP_PKEY_meth_set_verifyctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: EVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: EVP_PKEY_meth_verifyctx);

  procedure EVP_PKEY_meth_set_encrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: EVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: EVP_PKEY_meth_encrypt);

  procedure EVP_PKEY_meth_set_decrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: EVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: EVP_PKEY_meth_decrypt);

  procedure EVP_PKEY_meth_set_derive(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: EVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: EVP_PKEY_meth_derive);

  procedure EVP_PKEY_meth_set_ctrl(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: EVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: EVP_PKEY_meth_ctrl_str);

  procedure EVP_PKEY_meth_set_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: EVP_PKEY_meth_digestsign);

  procedure EVP_PKEY_meth_set_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: EVP_PKEY_meth_digestverify);

  procedure EVP_PKEY_meth_set_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: EVP_PKEY_meth_check);

  procedure EVP_PKEY_meth_set_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: EVP_PKEY_meth_public_check);

  procedure EVP_PKEY_meth_set_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: EVP_PKEY_meth_param_check);

  procedure EVP_PKEY_meth_set_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: EVP_PKEY_meth_digest_custom);

  procedure EVP_PKEY_meth_get_init(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: PEVP_PKEY_meth_init);

  procedure EVP_PKEY_meth_get_copy(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy: PEVP_PKEY_meth_copy);

  procedure EVP_PKEY_meth_get_cleanup(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_cleanup: PEVP_PKEY_meth_cleanup);

  procedure EVP_PKEY_meth_get_paramgen(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: PEVP_PKEY_meth_paramgen);

  procedure EVP_PKEY_meth_get_keygen(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: PEVP_PKEY_meth_keygen);

  procedure EVP_PKEY_meth_get_sign(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: PEVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: PEVP_PKEY_meth_sign);

  procedure EVP_PKEY_meth_get_verify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: PEVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: PEVP_PKEY_meth_verify_init);

  procedure EVP_PKEY_meth_get_verify_recover(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: PEVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: PEVP_PKEY_meth_verify_recover_init);

  procedure EVP_PKEY_meth_get_signctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: PEVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: PEVP_PKEY_meth_signctx);

  procedure EVP_PKEY_meth_get_verifyctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: PEVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: PEVP_PKEY_meth_verifyctx);

  procedure EVP_PKEY_meth_get_encrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: PEVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: PEVP_PKEY_meth_encrypt);

  procedure EVP_PKEY_meth_get_decrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: PEVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: PEVP_PKEY_meth_decrypt);

  procedure EVP_PKEY_meth_get_derive(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: PEVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: PEVP_PKEY_meth_derive);

  procedure EVP_PKEY_meth_get_ctrl(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: PEVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: PEVP_PKEY_meth_ctrl_str);

  procedure EVP_PKEY_meth_get_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: PEVP_PKEY_meth_digestsign);

  procedure EVP_PKEY_meth_get_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: PEVP_PKEY_meth_digestverify);

  procedure EVP_PKEY_meth_get_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: PEVP_PKEY_meth_check);

  procedure EVP_PKEY_meth_get_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: PEVP_PKEY_meth_public_check);

  procedure EVP_PKEY_meth_get_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: PEVP_PKEY_meth_param_check);

  procedure EVP_PKEY_meth_get_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: PEVP_PKEY_meth_digest_custom);

  procedure EVP_add_alg_module;

implementation

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
