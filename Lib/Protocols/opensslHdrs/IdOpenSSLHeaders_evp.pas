  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_evp.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_evp.h2pas
     and this file regenerated. IdOpenSSLHeaders_evp.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 

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

unit IdOpenSSLHeaders_evp;

interface

// Headers for OpenSSL 1.1.1
// evp.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_obj_mac,
  IdOpenSSLHeaders_ossl_typ;

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
  EVP_MD_meth_copy = function(to_: PEVP_MD_CTX; const from: PEVP_MD_CTX): TIdC_INT; cdecl;
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
  pub_print = function(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;
  pkey_size = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  pkey_bits = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;

  priv_decode = function(pk: PEVP_PKEY; const p8inf: PKCS8_PRIV_KEY_INFO): TIdC_INT; cdecl;
  priv_encode = function(p8: PPKCS8_PRIV_KEY_INFO; const pk: PEVP_PKEY): TIdC_INT; cdecl;
  priv_print = function(out_: PBIO; const pkea: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;

  param_decode = function(pkey: PEVP_PKEY; const pder: PPByte; derlen: TIdC_INT): TIdC_INT; cdecl;
  param_encode = function(const pkey: PEVP_PKEY; pder: PPByte): TIdC_INT; cdecl;
  param_missing = function(const pk: PEVP_PKEY): TIdC_INT; cdecl;
  param_copy = function(to_: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT; cdecl;
  param_cmp = function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT; cdecl;
  param_print = function(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl;

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

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM EVP_MD_meth_new} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_dup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_free} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_input_blocksize} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_result_size} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_app_datasize} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_init} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_update} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_final} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_copy} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_set_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_input_blocksize} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_result_size} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_app_datasize} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_flags} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_init} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_update} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_final} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_copy} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_meth_get_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_new} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_dup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_free} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_iv_length} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_impl_ctx_size} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_init} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_do_cipher} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_set_asn1_params} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_get_asn1_params} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_set_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_init} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_do_cipher} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_set_asn1_params} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_get_asn1_params} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_meth_get_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_md}
  {$EXTERNALSYM EVP_MD_CTX_update_fn} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_set_update_fn} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_set_pkey_ctx} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_impl_ctx_size} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_cipher}
  {$EXTERNALSYM EVP_CIPHER_CTX_iv} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_original_iv} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_iv_noconst} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_buf_noconst} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_num} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_copy}
  {$EXTERNALSYM EVP_CIPHER_CTX_get_app_data}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_app_data}
  {$EXTERNALSYM EVP_CIPHER_CTX_get_cipher_data} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_cipher_data} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_new} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_reset} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_free} {introduced 1.1.0}
  {$EXTERNALSYM EVP_MD_CTX_copy_ex}
  {$EXTERNALSYM EVP_MD_CTX_set_flags}
  {$EXTERNALSYM EVP_MD_CTX_clear_flags}
  {$EXTERNALSYM EVP_MD_CTX_test_flags}
  {$EXTERNALSYM EVP_DigestInit_ex}
  {$EXTERNALSYM EVP_DigestUpdate}
  {$EXTERNALSYM EVP_DigestFinal_ex}
  {$EXTERNALSYM EVP_Digest}
  {$EXTERNALSYM EVP_MD_CTX_copy}
  {$EXTERNALSYM EVP_DigestInit}
  {$EXTERNALSYM EVP_DigestFinal}
  {$EXTERNALSYM EVP_DigestFinalXOF} {introduced 1.1.0}
  {$EXTERNALSYM EVP_read_pw_string}
  {$EXTERNALSYM EVP_read_pw_string_min}
  {$EXTERNALSYM EVP_set_pw_prompt}
  {$EXTERNALSYM EVP_get_pw_prompt}
  {$EXTERNALSYM EVP_BytesToKey}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_flags}
  {$EXTERNALSYM EVP_CIPHER_CTX_clear_flags}
  {$EXTERNALSYM EVP_CIPHER_CTX_test_flags}
  {$EXTERNALSYM EVP_EncryptInit}
  {$EXTERNALSYM EVP_EncryptInit_ex}
  {$EXTERNALSYM EVP_EncryptUpdate}
  {$EXTERNALSYM EVP_EncryptFinal_ex}
  {$EXTERNALSYM EVP_EncryptFinal}
  {$EXTERNALSYM EVP_DecryptInit}
  {$EXTERNALSYM EVP_DecryptInit_ex}
  {$EXTERNALSYM EVP_DecryptUpdate}
  {$EXTERNALSYM EVP_DecryptFinal}
  {$EXTERNALSYM EVP_DecryptFinal_ex}
  {$EXTERNALSYM EVP_CipherInit}
  {$EXTERNALSYM EVP_CipherInit_ex}
  {$EXTERNALSYM EVP_CipherUpdate}
  {$EXTERNALSYM EVP_CipherFinal}
  {$EXTERNALSYM EVP_CipherFinal_ex}
  {$EXTERNALSYM EVP_SignFinal}
  {$EXTERNALSYM EVP_DigestSign} {introduced 1.1.0}
  {$EXTERNALSYM EVP_VerifyFinal}
  {$EXTERNALSYM EVP_DigestVerify} {introduced 1.1.0}
  {$EXTERNALSYM EVP_DigestSignInit}
  {$EXTERNALSYM EVP_DigestSignFinal}
  {$EXTERNALSYM EVP_DigestVerifyInit}
  {$EXTERNALSYM EVP_DigestVerifyFinal}
  {$EXTERNALSYM EVP_OpenInit}
  {$EXTERNALSYM EVP_OpenFinal}
  {$EXTERNALSYM EVP_SealInit}
  {$EXTERNALSYM EVP_SealFinal}
  {$EXTERNALSYM EVP_ENCODE_CTX_new} {introduced 1.1.0}
  {$EXTERNALSYM EVP_ENCODE_CTX_free} {introduced 1.1.0}
  {$EXTERNALSYM EVP_ENCODE_CTX_copy} {introduced 1.1.0}
  {$EXTERNALSYM EVP_ENCODE_CTX_num} {introduced 1.1.0}
  {$EXTERNALSYM EVP_EncodeInit}
  {$EXTERNALSYM EVP_EncodeUpdate}
  {$EXTERNALSYM EVP_EncodeFinal}
  {$EXTERNALSYM EVP_EncodeBlock}
  {$EXTERNALSYM EVP_DecodeInit}
  {$EXTERNALSYM EVP_DecodeUpdate}
  {$EXTERNALSYM EVP_DecodeFinal}
  {$EXTERNALSYM EVP_DecodeBlock}
  {$EXTERNALSYM EVP_CIPHER_CTX_new}
  {$EXTERNALSYM EVP_CIPHER_CTX_reset} {introduced 1.1.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_free}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_key_length}
  {$EXTERNALSYM EVP_CIPHER_CTX_set_padding}
  {$EXTERNALSYM EVP_CIPHER_CTX_ctrl}
  {$EXTERNALSYM EVP_CIPHER_CTX_rand_key}
  {$EXTERNALSYM BIO_f_md}
  {$EXTERNALSYM BIO_f_base64}
  {$EXTERNALSYM BIO_f_cipher}
  {$EXTERNALSYM BIO_f_reliable}
  {$EXTERNALSYM BIO_set_cipher}
  {$EXTERNALSYM EVP_md_null}
  {$EXTERNALSYM EVP_md5}
  {$EXTERNALSYM EVP_md5_sha1} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha1}
  {$EXTERNALSYM EVP_sha224}
  {$EXTERNALSYM EVP_sha256}
  {$EXTERNALSYM EVP_sha384}
  {$EXTERNALSYM EVP_sha512}
  {$EXTERNALSYM EVP_sha512_224} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha512_256} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha3_224} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha3_256} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha3_384} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sha3_512} {introduced 1.1.0}
  {$EXTERNALSYM EVP_shake128} {introduced 1.1.0}
  {$EXTERNALSYM EVP_shake256} {introduced 1.1.0}
  {$EXTERNALSYM EVP_enc_null}
  {$EXTERNALSYM EVP_des_ecb}
  {$EXTERNALSYM EVP_des_ede}
  {$EXTERNALSYM EVP_des_ede3}
  {$EXTERNALSYM EVP_des_ede_ecb}
  {$EXTERNALSYM EVP_des_ede3_ecb}
  {$EXTERNALSYM EVP_des_cfb64}
  {$EXTERNALSYM EVP_des_cfb1}
  {$EXTERNALSYM EVP_des_cfb8}
  {$EXTERNALSYM EVP_des_ede_cfb64}
  {$EXTERNALSYM EVP_des_ede3_cfb64}
  {$EXTERNALSYM EVP_des_ede3_cfb1}
  {$EXTERNALSYM EVP_des_ede3_cfb8}
  {$EXTERNALSYM EVP_des_ofb}
  {$EXTERNALSYM EVP_des_ede_ofb}
  {$EXTERNALSYM EVP_des_ede3_ofb}
  {$EXTERNALSYM EVP_des_cbc}
  {$EXTERNALSYM EVP_des_ede_cbc}
  {$EXTERNALSYM EVP_des_ede3_cbc}
  {$EXTERNALSYM EVP_desx_cbc}
  {$EXTERNALSYM EVP_des_ede3_wrap}
  {$EXTERNALSYM EVP_rc4}
  {$EXTERNALSYM EVP_rc4_40}
  {$EXTERNALSYM EVP_rc2_ecb}
  {$EXTERNALSYM EVP_rc2_cbc}
  {$EXTERNALSYM EVP_rc2_40_cbc}
  {$EXTERNALSYM EVP_rc2_64_cbc}
  {$EXTERNALSYM EVP_rc2_cfb64}
  {$EXTERNALSYM EVP_rc2_ofb}
  {$EXTERNALSYM EVP_bf_ecb}
  {$EXTERNALSYM EVP_bf_cbc}
  {$EXTERNALSYM EVP_bf_cfb64}
  {$EXTERNALSYM EVP_bf_ofb}
  {$EXTERNALSYM EVP_cast5_ecb}
  {$EXTERNALSYM EVP_cast5_cbc}
  {$EXTERNALSYM EVP_cast5_cfb64}
  {$EXTERNALSYM EVP_cast5_ofb}
  {$EXTERNALSYM EVP_aes_128_ecb}
  {$EXTERNALSYM EVP_aes_128_cbc}
  {$EXTERNALSYM EVP_aes_128_cfb1}
  {$EXTERNALSYM EVP_aes_128_cfb8}
  {$EXTERNALSYM EVP_aes_128_cfb128}
  {$EXTERNALSYM EVP_aes_128_ofb}
  {$EXTERNALSYM EVP_aes_128_ctr}
  {$EXTERNALSYM EVP_aes_128_ccm}
  {$EXTERNALSYM EVP_aes_128_gcm}
  {$EXTERNALSYM EVP_aes_128_xts}
  {$EXTERNALSYM EVP_aes_128_wrap}
  {$EXTERNALSYM EVP_aes_128_wrap_pad} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_128_ocb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_192_ecb}
  {$EXTERNALSYM EVP_aes_192_cbc}
  {$EXTERNALSYM EVP_aes_192_cfb1}
  {$EXTERNALSYM EVP_aes_192_cfb8}
  {$EXTERNALSYM EVP_aes_192_cfb128}
  {$EXTERNALSYM EVP_aes_192_ofb}
  {$EXTERNALSYM EVP_aes_192_ctr}
  {$EXTERNALSYM EVP_aes_192_ccm}
  {$EXTERNALSYM EVP_aes_192_gcm}
  {$EXTERNALSYM EVP_aes_192_wrap}
  {$EXTERNALSYM EVP_aes_192_wrap_pad} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_192_ocb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_256_ecb}
  {$EXTERNALSYM EVP_aes_256_cbc}
  {$EXTERNALSYM EVP_aes_256_cfb1}
  {$EXTERNALSYM EVP_aes_256_cfb8}
  {$EXTERNALSYM EVP_aes_256_cfb128}
  {$EXTERNALSYM EVP_aes_256_ofb}
  {$EXTERNALSYM EVP_aes_256_ctr}
  {$EXTERNALSYM EVP_aes_256_ccm}
  {$EXTERNALSYM EVP_aes_256_gcm}
  {$EXTERNALSYM EVP_aes_256_xts}
  {$EXTERNALSYM EVP_aes_256_wrap}
  {$EXTERNALSYM EVP_aes_256_wrap_pad} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_256_ocb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aes_128_cbc_hmac_sha1}
  {$EXTERNALSYM EVP_aes_256_cbc_hmac_sha1}
  {$EXTERNALSYM EVP_aes_128_cbc_hmac_sha256}
  {$EXTERNALSYM EVP_aes_256_cbc_hmac_sha256}
  {$EXTERNALSYM EVP_aria_128_ecb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_cbc} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_cfb1} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_cfb8} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_cfb128} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_ofb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_gcm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_128_ccm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_ecb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_cbc} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_cfb1} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_cfb8} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_cfb128} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_ofb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_gcm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_192_ccm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_ecb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_cbc} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_cfb1} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_cfb8} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_cfb128} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_ofb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_gcm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_aria_256_ccm} {introduced 1.1.0}
  {$EXTERNALSYM EVP_camellia_128_ecb}
  {$EXTERNALSYM EVP_camellia_128_cbc}
  {$EXTERNALSYM EVP_camellia_128_cfb1}
  {$EXTERNALSYM EVP_camellia_128_cfb8}
  {$EXTERNALSYM EVP_camellia_128_cfb128}
  {$EXTERNALSYM EVP_camellia_128_ofb}
  {$EXTERNALSYM EVP_camellia_128_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_camellia_192_ecb}
  {$EXTERNALSYM EVP_camellia_192_cbc}
  {$EXTERNALSYM EVP_camellia_192_cfb1}
  {$EXTERNALSYM EVP_camellia_192_cfb8}
  {$EXTERNALSYM EVP_camellia_192_cfb128}
  {$EXTERNALSYM EVP_camellia_192_ofb}
  {$EXTERNALSYM EVP_camellia_192_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_camellia_256_ecb}
  {$EXTERNALSYM EVP_camellia_256_cbc}
  {$EXTERNALSYM EVP_camellia_256_cfb1}
  {$EXTERNALSYM EVP_camellia_256_cfb8}
  {$EXTERNALSYM EVP_camellia_256_cfb128}
  {$EXTERNALSYM EVP_camellia_256_ofb}
  {$EXTERNALSYM EVP_camellia_256_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_chacha20} {introduced 1.1.0}
  {$EXTERNALSYM EVP_chacha20_poly1305} {introduced 1.1.0}
  {$EXTERNALSYM EVP_seed_ecb}
  {$EXTERNALSYM EVP_seed_cbc}
  {$EXTERNALSYM EVP_seed_cfb128}
  {$EXTERNALSYM EVP_seed_ofb}
  {$EXTERNALSYM EVP_sm4_ecb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sm4_cbc} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sm4_cfb128} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sm4_ofb} {introduced 1.1.0}
  {$EXTERNALSYM EVP_sm4_ctr} {introduced 1.1.0}
  {$EXTERNALSYM EVP_add_cipher}
  {$EXTERNALSYM EVP_add_digest}
  {$EXTERNALSYM EVP_get_cipherbyname}
  {$EXTERNALSYM EVP_get_digestbyname}
  {$EXTERNALSYM EVP_CIPHER_do_all}
  {$EXTERNALSYM EVP_CIPHER_do_all_sorted}
  {$EXTERNALSYM EVP_MD_do_all}
  {$EXTERNALSYM EVP_MD_do_all_sorted}
  {$EXTERNALSYM EVP_PKEY_decrypt_old}
  {$EXTERNALSYM EVP_PKEY_encrypt_old}
  {$EXTERNALSYM EVP_PKEY_type}
  {$EXTERNALSYM EVP_PKEY_set_type}
  {$EXTERNALSYM EVP_PKEY_set_type_str}
  {$EXTERNALSYM EVP_PKEY_set1_engine} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get0_engine} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_assign}
  {$EXTERNALSYM EVP_PKEY_get0}
  {$EXTERNALSYM EVP_PKEY_get0_hmac} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get0_poly1305} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get0_siphash} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_set1_RSA}
  {$EXTERNALSYM EVP_PKEY_get0_RSA} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get1_RSA}
  {$EXTERNALSYM EVP_PKEY_set1_DSA}
  {$EXTERNALSYM EVP_PKEY_get0_DSA} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get1_DSA}
  {$EXTERNALSYM EVP_PKEY_set1_DH}
  {$EXTERNALSYM EVP_PKEY_get0_DH} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get1_DH}
  {$EXTERNALSYM EVP_PKEY_set1_EC_KEY}
  {$EXTERNALSYM EVP_PKEY_get0_EC_KEY} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get1_EC_KEY}
  {$EXTERNALSYM EVP_PKEY_new}
  {$EXTERNALSYM EVP_PKEY_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_free}
  {$EXTERNALSYM d2i_PublicKey}
  {$EXTERNALSYM i2d_PublicKey}
  {$EXTERNALSYM d2i_PrivateKey}
  {$EXTERNALSYM d2i_AutoPrivateKey}
  {$EXTERNALSYM i2d_PrivateKey}
  {$EXTERNALSYM EVP_PKEY_copy_parameters}
  {$EXTERNALSYM EVP_PKEY_missing_parameters}
  {$EXTERNALSYM EVP_PKEY_save_parameters}
  {$EXTERNALSYM EVP_PKEY_cmp_parameters}
  {$EXTERNALSYM EVP_PKEY_cmp}
  {$EXTERNALSYM EVP_PKEY_print_public}
  {$EXTERNALSYM EVP_PKEY_print_private}
  {$EXTERNALSYM EVP_PKEY_print_params}
  {$EXTERNALSYM EVP_PKEY_get_default_digest_nid}
  {$EXTERNALSYM EVP_CIPHER_param_to_asn1}
  {$EXTERNALSYM EVP_CIPHER_asn1_to_param}
  {$EXTERNALSYM EVP_CIPHER_set_asn1_iv}
  {$EXTERNALSYM EVP_CIPHER_get_asn1_iv}
  {$EXTERNALSYM PKCS5_PBE_keyivgen}
  {$EXTERNALSYM PKCS5_PBKDF2_HMAC_SHA1}
  {$EXTERNALSYM PKCS5_PBKDF2_HMAC}
  {$EXTERNALSYM PKCS5_v2_PBE_keyivgen}
  {$EXTERNALSYM EVP_PBE_scrypt} {introduced 1.1.0}
  {$EXTERNALSYM PKCS5_v2_scrypt_keyivgen} {introduced 1.1.0}
  {$EXTERNALSYM PKCS5_PBE_add}
  {$EXTERNALSYM EVP_PBE_CipherInit}
  {$EXTERNALSYM EVP_PBE_alg_add_type}
  {$EXTERNALSYM EVP_PBE_alg_add}
  {$EXTERNALSYM EVP_PBE_find}
  {$EXTERNALSYM EVP_PBE_cleanup}
  {$EXTERNALSYM EVP_PBE_get} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_get_count}
  {$EXTERNALSYM EVP_PKEY_asn1_get0}
  {$EXTERNALSYM EVP_PKEY_asn1_find}
  {$EXTERNALSYM EVP_PKEY_asn1_find_str}
  {$EXTERNALSYM EVP_PKEY_asn1_add0}
  {$EXTERNALSYM EVP_PKEY_asn1_add_alias}
  {$EXTERNALSYM EVP_PKEY_asn1_get0_info}
  {$EXTERNALSYM EVP_PKEY_get0_asn1}
  {$EXTERNALSYM EVP_PKEY_asn1_new}
  {$EXTERNALSYM EVP_PKEY_asn1_copy}
  {$EXTERNALSYM EVP_PKEY_asn1_free}
  {$EXTERNALSYM EVP_PKEY_asn1_set_public}
  {$EXTERNALSYM EVP_PKEY_asn1_set_private}
  {$EXTERNALSYM EVP_PKEY_asn1_set_param}
  {$EXTERNALSYM EVP_PKEY_asn1_set_free}
  {$EXTERNALSYM EVP_PKEY_asn1_set_ctrl}
  {$EXTERNALSYM EVP_PKEY_asn1_set_item}
  {$EXTERNALSYM EVP_PKEY_asn1_set_siginf} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_public_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_param_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_set_priv_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_set_pub_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_get_priv_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_get_pub_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_asn1_set_security_bits} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_find}
  {$EXTERNALSYM EVP_PKEY_meth_new}
  {$EXTERNALSYM EVP_PKEY_meth_get0_info}
  {$EXTERNALSYM EVP_PKEY_meth_copy}
  {$EXTERNALSYM EVP_PKEY_meth_free}
  {$EXTERNALSYM EVP_PKEY_meth_add0}
  {$EXTERNALSYM EVP_PKEY_meth_remove} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_count} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get0} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_new}
  {$EXTERNALSYM EVP_PKEY_CTX_new_id}
  {$EXTERNALSYM EVP_PKEY_CTX_dup}
  {$EXTERNALSYM EVP_PKEY_CTX_free}
  {$EXTERNALSYM EVP_PKEY_CTX_ctrl}
  {$EXTERNALSYM EVP_PKEY_CTX_ctrl_str}
  {$EXTERNALSYM EVP_PKEY_CTX_ctrl_uint64} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_str2ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_hex2ctrl} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_md} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_get_operation}
  {$EXTERNALSYM EVP_PKEY_CTX_set0_keygen_info}
  {$EXTERNALSYM EVP_PKEY_new_mac_key}
  {$EXTERNALSYM EVP_PKEY_new_raw_private_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_new_raw_public_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get_raw_private_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_get_raw_public_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_new_CMAC_key} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_set_data}
  {$EXTERNALSYM EVP_PKEY_CTX_get_data}
  {$EXTERNALSYM EVP_PKEY_CTX_get0_pkey}
  {$EXTERNALSYM EVP_PKEY_CTX_get0_peerkey}
  {$EXTERNALSYM EVP_PKEY_CTX_set_app_data}
  {$EXTERNALSYM EVP_PKEY_CTX_get_app_data}
  {$EXTERNALSYM EVP_PKEY_sign_init}
  {$EXTERNALSYM EVP_PKEY_sign}
  {$EXTERNALSYM EVP_PKEY_verify_init}
  {$EXTERNALSYM EVP_PKEY_verify}
  {$EXTERNALSYM EVP_PKEY_verify_recover_init}
  {$EXTERNALSYM EVP_PKEY_verify_recover}
  {$EXTERNALSYM EVP_PKEY_encrypt_init}
  {$EXTERNALSYM EVP_PKEY_encrypt}
  {$EXTERNALSYM EVP_PKEY_decrypt_init}
  {$EXTERNALSYM EVP_PKEY_decrypt}
  {$EXTERNALSYM EVP_PKEY_derive_init}
  {$EXTERNALSYM EVP_PKEY_derive_set_peer}
  {$EXTERNALSYM EVP_PKEY_derive}
  {$EXTERNALSYM EVP_PKEY_paramgen_init}
  {$EXTERNALSYM EVP_PKEY_paramgen}
  {$EXTERNALSYM EVP_PKEY_keygen_init}
  {$EXTERNALSYM EVP_PKEY_keygen}
  {$EXTERNALSYM EVP_PKEY_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_public_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_param_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_CTX_set_cb}
  {$EXTERNALSYM EVP_PKEY_CTX_get_cb}
  {$EXTERNALSYM EVP_PKEY_CTX_get_keygen_info}
  {$EXTERNALSYM EVP_PKEY_meth_set_init}
  {$EXTERNALSYM EVP_PKEY_meth_set_copy}
  {$EXTERNALSYM EVP_PKEY_meth_set_cleanup}
  {$EXTERNALSYM EVP_PKEY_meth_set_paramgen}
  {$EXTERNALSYM EVP_PKEY_meth_set_keygen}
  {$EXTERNALSYM EVP_PKEY_meth_set_sign}
  {$EXTERNALSYM EVP_PKEY_meth_set_verify}
  {$EXTERNALSYM EVP_PKEY_meth_set_verify_recover}
  {$EXTERNALSYM EVP_PKEY_meth_set_signctx}
  {$EXTERNALSYM EVP_PKEY_meth_set_verifyctx}
  {$EXTERNALSYM EVP_PKEY_meth_set_encrypt}
  {$EXTERNALSYM EVP_PKEY_meth_set_decrypt}
  {$EXTERNALSYM EVP_PKEY_meth_set_derive}
  {$EXTERNALSYM EVP_PKEY_meth_set_ctrl}
  {$EXTERNALSYM EVP_PKEY_meth_set_digestsign} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_set_digestverify} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_set_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_set_public_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_set_param_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_set_digest_custom} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_init}
  {$EXTERNALSYM EVP_PKEY_meth_get_copy}
  {$EXTERNALSYM EVP_PKEY_meth_get_cleanup}
  {$EXTERNALSYM EVP_PKEY_meth_get_paramgen}
  {$EXTERNALSYM EVP_PKEY_meth_get_keygen}
  {$EXTERNALSYM EVP_PKEY_meth_get_sign}
  {$EXTERNALSYM EVP_PKEY_meth_get_verify}
  {$EXTERNALSYM EVP_PKEY_meth_get_verify_recover}
  {$EXTERNALSYM EVP_PKEY_meth_get_signctx}
  {$EXTERNALSYM EVP_PKEY_meth_get_verifyctx}
  {$EXTERNALSYM EVP_PKEY_meth_get_encrypt}
  {$EXTERNALSYM EVP_PKEY_meth_get_decrypt}
  {$EXTERNALSYM EVP_PKEY_meth_get_derive}
  {$EXTERNALSYM EVP_PKEY_meth_get_ctrl}
  {$EXTERNALSYM EVP_PKEY_meth_get_digestsign} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_digestverify} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_public_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_param_check} {introduced 1.1.0}
  {$EXTERNALSYM EVP_PKEY_meth_get_digest_custom} {introduced 1.1.0}
  {$EXTERNALSYM EVP_add_alg_module}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM EVP_PKEY_assign_RSA} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_assign_DSA} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_assign_DH} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_assign_EC_KEY} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_assign_SIPHASH} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_assign_POLY1305} {removed 1.0.0}
  {$EXTERNALSYM EVP_MD_type} {removed 3.0.0}
  {$EXTERNALSYM EVP_MD_pkey_type} {removed 3.0.0}
  {$EXTERNALSYM EVP_MD_size} {removed 3.0.0}
  {$EXTERNALSYM EVP_MD_block_size} {removed 3.0.0}
  {$EXTERNALSYM EVP_MD_flags} {removed 3.0.0}
  {$EXTERNALSYM EVP_MD_CTX_pkey_ctx} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_MD_CTX_md_data} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_nid} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_block_size} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_key_length} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_iv_length} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_flags} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_encrypting} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_nid} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_block_size} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_key_length} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_iv_length} {removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_CTX_num} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM BIO_set_md} {removed 1.0.0}
  {$EXTERNALSYM EVP_PKEY_id} {removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_base_id} {removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_bits} {removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_security_bits} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_size} {removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_set_alias_type} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_set1_tls_encodedpoint} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_PKEY_get1_tls_encodedpoint} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EVP_CIPHER_type} {removed 3.0.0}
  {$EXTERNALSYM OpenSSL_add_all_ciphers} {removed 1.1.0}
  {$EXTERNALSYM OpenSSL_add_all_digests} {removed 1.1.0}
  {$EXTERNALSYM EVP_cleanup} {removed 1.1.0}
  EVP_PKEY_assign_RSA: function(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}
  EVP_PKEY_assign_DSA: function(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}
  EVP_PKEY_assign_DH: function(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}
  EVP_PKEY_assign_EC_KEY: function(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}
  EVP_PKEY_assign_SIPHASH: function(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}
  EVP_PKEY_assign_POLY1305: function(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}

  EVP_MD_meth_new: function(md_type: TIdC_INT; pkey_type: TIdC_INT): PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_dup: function(const md: PEVP_MD): PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_free: procedure(md: PEVP_MD); cdecl = nil; {introduced 1.1.0}

  EVP_MD_meth_set_input_blocksize: function(md: PEVP_MD; blocksize: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_result_size: function(md: PEVP_MD; resultsize: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_app_datasize: function(md: PEVP_MD; datasize: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_flags: function(md: PEVP_MD; flags: TIdC_ULONG): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_init: function(md: PEVP_MD; init: EVP_MD_meth_init): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_update: function(md: PEVP_MD; update: EVP_MD_meth_update): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_final: function(md: PEVP_MD; final_: EVP_MD_meth_final): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_copy: function(md: PEVP_MD; copy: EVP_MD_meth_copy): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_cleanup: function(md: PEVP_MD; cleanup: EVP_MD_meth_cleanup): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_set_ctrl: function(md: PEVP_MD; ctrl: EVP_MD_meth_ctrl): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_MD_meth_get_input_blocksize: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_result_size: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_app_datasize: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_flags: function(const md: PEVP_MD): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_init: function(const md: PEVP_MD): EVP_MD_meth_init; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_update: function(const md: PEVP_MD): EVP_MD_meth_update; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_final: function(const md: PEVP_MD): EVP_MD_meth_final; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_copy: function(const md: PEVP_MD): EVP_MD_meth_copy; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_cleanup: function(const md: PEVP_MD): EVP_MD_meth_cleanup; cdecl = nil; {introduced 1.1.0}
  EVP_MD_meth_get_ctrl: function(const md: PEVP_MD): EVP_MD_meth_ctrl; cdecl = nil; {introduced 1.1.0}

  EVP_CIPHER_meth_new: function(cipher_type: TIdC_INT; block_size: TIdC_INT; key_len: TIdC_INT): PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_dup: function(const cipher: PEVP_CIPHER): PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_free: procedure(cipher: PEVP_CIPHER); cdecl = nil; {introduced 1.1.0}

  EVP_CIPHER_meth_set_iv_length: function(cipher: PEVP_CIPHER; iv_len: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_flags: function(cipher: PEVP_CIPHER; flags: TIdC_ULONG): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_impl_ctx_size: function(cipher: PEVP_CIPHER; ctx_size: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_init: function(cipher: PEVP_CIPHER; init: EVP_CIPHER_meth_init): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_do_cipher: function(cipher: PEVP_CIPHER; do_cipher: EVP_CIPHER_meth_do_cipher): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_cleanup: function(cipher: PEVP_CIPHER; cleanup: EVP_CIPHER_meth_cleanup): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_set_asn1_params: function(cipher: PEVP_CIPHER; set_asn1_parameters: EVP_CIPHER_meth_set_asn1_params): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_get_asn1_params: function(cipher: PEVP_CIPHER; get_asn1_parameters: EVP_CIPHER_meth_get_asn1_params): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_ctrl: function(cipher: PEVP_CIPHER; ctrl: EVP_CIPHER_meth_ctrl): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_init: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_init; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_do_cipher: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_do_cipher; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_cleanup: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_cleanup; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_set_asn1_params: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_set_asn1_params; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_get_asn1_params: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_get_asn1_params; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_ctrl: function(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_ctrl; cdecl = nil; {introduced 1.1.0}

  /// Add some extra combinations ///
  //# define EVP_get_digestbynid(a) EVP_get_digestbyname(OBJ_nid2sn(a));
  //# define EVP_get_digestbyobj(a) EVP_get_digestbynid(OBJ_obj2nid(a));
  //# define EVP_get_cipherbynid(a) EVP_get_cipherbyname(OBJ_nid2sn(a));
  //# define EVP_get_cipherbyobj(a) EVP_get_cipherbynid(OBJ_obj2nid(a));

  EVP_MD_type: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {removed 3.0.0}
  //# define EVP_MD_nid(e)                   EVP_MD_type(e)
  //# define EVP_MD_name(e)                  OBJ_nid2sn(EVP_MD_nid(e))
  EVP_MD_pkey_type: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_MD_size: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_MD_block_size: function(const md: PEVP_MD): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_MD_flags: function(const md: PEVP_MD): PIdC_ULONG; cdecl = nil; {removed 3.0.0}

  EVP_MD_CTX_md: function(ctx: PEVP_MD_CTX): PEVP_MD; cdecl = nil;
  EVP_MD_CTX_update_fn: function(ctx: PEVP_MD_CTX): EVP_MD_CTX_update; cdecl = nil; {introduced 1.1.0}
  EVP_MD_CTX_set_update_fn: procedure(ctx: PEVP_MD_CTX; update: EVP_MD_CTX_update); cdecl = nil; {introduced 1.1.0}
  //  EVP_MD_CTX_size(e)              EVP_MD_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_block_size(e)        EVP_MD_block_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_type(e)              EVP_MD_type(EVP_MD_CTX_md(e))
  EVP_MD_CTX_pkey_ctx: function(const ctx: PEVP_MD_CTX): PEVP_PKEY_CTX; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EVP_MD_CTX_set_pkey_ctx: procedure(ctx: PEVP_MD_CTX; pctx: PEVP_PKEY_CTX); cdecl = nil; {introduced 1.1.0}
  EVP_MD_CTX_md_data: function(const ctx: PEVP_MD_CTX): Pointer; cdecl = nil; {introduced 1.1.0 removed 3.0.0}

  EVP_CIPHER_nid: function(const ctx: PEVP_MD_CTX): TIdC_INT; cdecl = nil; {removed 3.0.0}
  //# define EVP_CIPHER_name(e)              OBJ_nid2sn(EVP_CIPHER_nid(e))
  EVP_CIPHER_block_size: function(const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_impl_ctx_size: function(const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_key_length: function(const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_iv_length: function(const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_flags: function(const cipher: PEVP_CIPHER): TIdC_ULONG; cdecl = nil; {removed 3.0.0}
  //# define EVP_CIPHER_mode(e)              (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)

  EVP_CIPHER_CTX_cipher: function(const ctx: PEVP_CIPHER_CTX): PEVP_CIPHER; cdecl = nil;
  EVP_CIPHER_CTX_encrypting: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_nid: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_CTX_block_size: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_CTX_key_length: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_CTX_iv_length: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_CIPHER_CTX_iv: function(const ctx: PEVP_CIPHER_CTX): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_original_iv: function(const ctx: PEVP_CIPHER_CTX): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_iv_noconst: function(ctx: PEVP_CIPHER_CTX): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_buf_noconst: function(ctx: PEVP_CIPHER_CTX): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_num: function(const ctx: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_set_num: procedure(ctx: PEVP_CIPHER_CTX; num: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_copy: function(out_: PEVP_CIPHER_CTX; const in_: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil;
  EVP_CIPHER_CTX_get_app_data: function(const ctx: PEVP_CIPHER_CTX): Pointer; cdecl = nil;
  EVP_CIPHER_CTX_set_app_data: procedure(ctx: PEVP_CIPHER_CTX; data: Pointer); cdecl = nil;
  EVP_CIPHER_CTX_get_cipher_data: function(const ctx: PEVP_CIPHER_CTX): Pointer; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_set_cipher_data: function(ctx: PEVP_CIPHER_CTX; cipher_data: Pointer): Pointer; cdecl = nil; {introduced 1.1.0}

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

  BIO_set_md: procedure(v1: PBIO; const md: PEVP_MD); cdecl = nil; {removed 1.0.0}
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

  EVP_MD_CTX_ctrl: function(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_CTX_new: function: PEVP_MD_CTX; cdecl = nil; {introduced 1.1.0}
  EVP_MD_CTX_reset: function(ctx: PEVP_MD_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_MD_CTX_free: procedure(ctx: PEVP_MD_CTX); cdecl = nil; {introduced 1.1.0}
  //# define EVP_MD_CTX_create()     EVP_MD_CTX_new()
  //# define EVP_MD_CTX_init(ctx)    EVP_MD_CTX_reset((ctx))
  //# define EVP_MD_CTX_destroy(ctx) EVP_MD_CTX_free((ctx))
  EVP_MD_CTX_copy_ex: function(out_: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT; cdecl = nil;
  EVP_MD_CTX_set_flags: procedure(ctx: PEVP_MD_CTX; flags: TIdC_INT); cdecl = nil;
  EVP_MD_CTX_clear_flags: procedure(ctx: PEVP_MD_CTX; flags: TIdC_INT); cdecl = nil;
  EVP_MD_CTX_test_flags: function(const ctx: PEVP_MD_CTX; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_DigestInit_ex: function(ctx: PEVP_MD_CTX; const type_: PEVP_MD; impl: PENGINE): TIdC_INT; cdecl = nil;
  EVP_DigestUpdate: function(ctx: PEVP_MD_CTX; const d: Pointer; cnt: TIdC_SIZET): TIdC_INT; cdecl = nil;
  EVP_DigestFinal_ex: function(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT; cdecl = nil;
  EVP_Digest: function(const data: Pointer; count: TIdC_SIZET; md: PByte; size: PIdC_UINT; const type_: PEVP_MD; impl: PENGINE): TIdC_INT; cdecl = nil;

  EVP_MD_CTX_copy: function(out_: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT; cdecl = nil;
  EVP_DigestInit: function(ctx: PEVP_MD_CTX; const type_: PEVP_MD): TIdC_INT; cdecl = nil;
  EVP_DigestFinal: function(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT; cdecl = nil;
  EVP_DigestFinalXOF: function(ctx: PEVP_MD_CTX; md: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_read_pw_string: function(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_read_pw_string_min: function(buf: PIdAnsiChar; minlen: TIdC_INT; maxlen: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_set_pw_prompt: procedure(const prompt: PIdAnsiChar); cdecl = nil;
  EVP_get_pw_prompt: function: PIdAnsiChar; cdecl = nil;
  EVP_BytesToKey: function(const type_: PEVP_CIPHER; const md: PEVP_MD; const salt: PByte; const data: PByte; data1: TIdC_INT; count: TIdC_INT; key: PByte; iv: PByte): TIdC_INT; cdecl = nil;

  EVP_CIPHER_CTX_set_flags: procedure(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT); cdecl = nil;
  EVP_CIPHER_CTX_clear_flags: procedure(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT); cdecl = nil;
  EVP_CIPHER_CTX_test_flags: function(const ctx: PEVP_CIPHER_CTX; flags: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_EncryptInit: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte): TIdC_INT; cdecl = nil;
  EVP_EncryptInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT; cdecl = nil;
  EVP_EncryptUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in_1: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_EncryptFinal_ex: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;
  EVP_EncryptFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_DecryptInit: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PidC_INT): TIdC_INT; cdecl = nil;
  EVP_DecryptInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT; cdecl = nil;
  EVP_DecryptUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in_1: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_DecryptFinal: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;
  EVP_DecryptFinal_ex: function(ctx: PEVP_MD_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_CipherInit: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte; enc: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_CipherInit_ex: function(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte; enc: TidC_INT): TIdC_INT; cdecl = nil;
  EVP_CipherUpdate: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_CipherFinal: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;
  EVP_CipherFinal_ex: function(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_SignFinal: function(ctx: PEVP_CIPHER_CTX; md: PByte; s: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;

  EVP_DigestSign: function(ctx: PEVP_CIPHER_CTX; sigret: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_VerifyFinal: function(ctx: PEVP_MD_CTX; const sigbuf: PByte; siglen: TIdC_UINT; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;

  EVP_DigestVerify: function(ctx: PEVP_CIPHER_CTX; const sigret: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_DigestSignInit: function(ctx: PEVP_MD_CTX; pctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_DigestSignFinal: function(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_SIZET): TIdC_INT; cdecl = nil;

  EVP_DigestVerifyInit: function(ctx: PEVP_MD_CTX; ppctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_DigestVerifyFinal: function(ctx: PEVP_MD_CTX; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT; cdecl = nil;

  EVP_OpenInit: function(ctx: PEVP_CIPHER_CTX; const type_: PEVP_CIPHER; const ek: PByte; ek1: TIdC_INT; const iv: PByte; priv: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_OpenFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_SealInit: function(ctx: PEVP_CIPHER_CTX; const type_: EVP_CIPHER; ek: PPByte; ek1: PIdC_INT; iv: PByte; pubk: PPEVP_PKEY; npubk: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_SealFinal: function(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_ENCODE_CTX_new: function: PEVP_ENCODE_CTX; cdecl = nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_free: procedure(ctx: PEVP_ENCODE_CTX); cdecl = nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_copy: function(dctx: PEVP_ENCODE_CTX; sctx: PEVP_ENCODE_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_num: function(ctx: PEVP_ENCODE_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_EncodeInit: procedure(ctx: PEVP_ENCODE_CTX); cdecl = nil;
  EVP_EncodeUpdate: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_EncodeFinal: procedure(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT); cdecl = nil;
  EVP_EncodeBlock: function(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_DecodeInit: procedure(ctx: PEVP_ENCODE_CTX); cdecl = nil;
  EVP_DecodeUpdate: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_DecodeFinal: function(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT; cdecl = nil;
  EVP_DecodeBlock: function(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_CIPHER_CTX_new: function: PEVP_CIPHER_CTX; cdecl = nil;
  EVP_CIPHER_CTX_reset: function(c: PEVP_CIPHER_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_free: procedure(c: PEVP_CIPHER_CTX); cdecl = nil;
  EVP_CIPHER_CTX_set_key_length: function(x: PEVP_CIPHER_CTX; keylen: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_CIPHER_CTX_set_padding: function(c: PEVP_CIPHER_CTX; pad: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_CIPHER_CTX_ctrl: function(ctx: PEVP_CIPHER_CTX; type_: TIdC_INT; arg: TIdC_INT; ptr: Pointer): TIdC_INT; cdecl = nil;
  EVP_CIPHER_CTX_rand_key: function(ctx: PEVP_CIPHER_CTX; key: PByte): TIdC_INT; cdecl = nil;

  BIO_f_md: function: PBIO_METHOD; cdecl = nil;
  BIO_f_base64: function: PBIO_METHOD; cdecl = nil;
  BIO_f_cipher: function: PBIO_METHOD; cdecl = nil;
  BIO_f_reliable: function: PBIO_METHOD; cdecl = nil;
  BIO_set_cipher: function(b: PBIO; c: PEVP_CIPHER; const k: PByte; const i: PByte; enc: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_md_null: function: PEVP_MD; cdecl = nil;

  EVP_md5: function: PEVP_MD; cdecl = nil;
  EVP_md5_sha1: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}

  EVP_sha1: function: PEVP_MD; cdecl = nil;
  EVP_sha224: function: PEVP_MD; cdecl = nil;
  EVP_sha256: function: PEVP_MD; cdecl = nil;
  EVP_sha384: function: PEVP_MD; cdecl = nil;
  EVP_sha512: function: PEVP_MD; cdecl = nil;
  EVP_sha512_224: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_sha512_256: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_sha3_224: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_sha3_256: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_sha3_384: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_sha3_512: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_shake128: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}
  EVP_shake256: function: PEVP_MD; cdecl = nil; {introduced 1.1.0}

  (* does nothing :-) *)
  EVP_enc_null: function: PEVP_CIPHER; cdecl = nil;

  EVP_des_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_cfb64: function: PEVP_CIPHER; cdecl = nil;
  //EVP_des_cfb EVP_des_cfb64
  EVP_des_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede_cfb64: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_cfb64: function: PEVP_CIPHER; cdecl = nil;
  //EVP_des_ede3_cfb EVP_des_ede3_cfb64
  EVP_des_ede3_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_desx_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_des_ede3_wrap: function: PEVP_CIPHER; cdecl = nil;
  //
  // This should now be supported through the dev_crypto ENGINE. But also, why
  // are rc4 and md5 declarations made here inside a "NO_DES" precompiler
  // branch?
  //
  EVP_rc4: function: PEVP_CIPHER; cdecl = nil;
  EVP_rc4_40: function: PEVP_CIPHER; cdecl = nil;
//  function EVP_idea_ecb: PEVP_CIPHER;
// function EVP_idea_cfb64: PEVP_CIPHER;
  //EVP_idea_cfb EVP_idea_cfb64
//  function EVP_idea_ofb: PEVP_CIPHER;
 // function EVP_idea_cbc: PEVP_CIPHER;
  EVP_rc2_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_rc2_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_rc2_40_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_rc2_64_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_rc2_cfb64: function: PEVP_CIPHER; cdecl = nil;
  //EVP_rc2_cfb EVP_rc2_cfb64
  EVP_rc2_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_bf_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_bf_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_bf_cfb64: function: PEVP_CIPHER; cdecl = nil;
  //EVP_bf_cfb EVP_bf_cfb64
  EVP_bf_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_cast5_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_cast5_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_cast5_cfb64: function: PEVP_CIPHER; cdecl = nil;
  //EVP_cast5_cfb EVP_cast5_cfb64
  EVP_cast5_ofb: function: PEVP_CIPHER; cdecl = nil;
//  function EVP_rc5_32_12_16_cbc: PEVP_CIPHER;
//  function EVP_rc5_32_12_16_ecb: PEVP_CIPHER;
//  function EVP_rc5_32_12_16_cfb64: PEVP_CIPHER;
  //EVP_rc5_32_12_16_cfb EVP_rc5_32_12_16_cfb64
//  function EVP_rc5_32_12_16_ofb: PEVP_CIPHER;

  EVP_aes_128_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_aes_128_cfb EVP_aes_128_cfb128
  EVP_aes_128_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_ctr: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_ccm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_gcm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_xts: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_wrap: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_wrap_pad: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_128_ocb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_192_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_aes_192_cfb EVP_aes_192_cfb128
  EVP_aes_192_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_ctr: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_ccm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_gcm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_wrap: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_192_wrap_pad: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_192_ocb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_256_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_aes_256_cfb EVP_aes_256_cfb128
  EVP_aes_256_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_ctr: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_ccm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_gcm: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_xts: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_wrap: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_wrap_pad: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_256_ocb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aes_128_cbc_hmac_sha1: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cbc_hmac_sha1: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_128_cbc_hmac_sha256: function: PEVP_CIPHER; cdecl = nil;
  EVP_aes_256_cbc_hmac_sha256: function: PEVP_CIPHER; cdecl = nil;

  EVP_aria_128_ecb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_cbc: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_cfb1: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_cfb8: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_cfb128: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_ofb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_gcm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_128_ccm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_ecb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_cbc: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_cfb1: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_cfb8: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_cfb128: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  //EVP_aria_192_cfb EVP_aria_192_cfb128
  EVP_aria_192_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_ofb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_gcm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_192_ccm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_ecb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_cbc: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_cfb1: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_cfb8: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_cfb128: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  //EVP_aria_256_cfb EVP_aria_256_cfb128
  EVP_aria_256_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_ofb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_gcm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_aria_256_ccm: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}

  EVP_camellia_128_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_128_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_128_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_128_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_128_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_camellia_128_cfb EVP_camellia_128_cfb128
  EVP_camellia_128_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_128_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_camellia_192_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_192_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_192_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_192_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_192_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_camellia_192_cfb EVP_camellia_192_cfb128
  EVP_camellia_192_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_192_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_camellia_256_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_256_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_256_cfb1: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_256_cfb8: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_256_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_camellia_256_cfb EVP_camellia_256_cfb128
  EVP_camellia_256_ofb: function: PEVP_CIPHER; cdecl = nil;
  EVP_camellia_256_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}

  EVP_chacha20: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_chacha20_poly1305: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}

  EVP_seed_ecb: function: PEVP_CIPHER; cdecl = nil;
  EVP_seed_cbc: function: PEVP_CIPHER; cdecl = nil;
  EVP_seed_cfb128: function: PEVP_CIPHER; cdecl = nil;
  //EVP_seed_cfb EVP_seed_cfb128
  EVP_seed_ofb: function: PEVP_CIPHER; cdecl = nil;

  EVP_sm4_ecb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_sm4_cbc: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_sm4_cfb128: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  //EVP_sm4_cfb EVP_sm4_cfb128
  EVP_sm4_ofb: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}
  EVP_sm4_ctr: function: PEVP_CIPHER; cdecl = nil; {introduced 1.1.0}

  EVP_add_cipher: function(const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil;
  EVP_add_digest: function(const digest: PEVP_MD): TIdC_INT; cdecl = nil;

  EVP_get_cipherbyname: function(const name: PIdAnsiChar): PEVP_CIPHER; cdecl = nil;
  EVP_get_digestbyname: function(const name: PIdAnsiChar): PEVP_MD; cdecl = nil;

  EVP_CIPHER_do_all: procedure(AFn: fn; arg: Pointer); cdecl = nil;
  EVP_CIPHER_do_all_sorted: procedure(AFn: fn; arg: Pointer); cdecl = nil;

  EVP_MD_do_all: procedure(AFn: fn; arg: Pointer); cdecl = nil;
  EVP_MD_do_all_sorted: procedure(AFn: fn; arg: Pointer); cdecl = nil;

  EVP_PKEY_decrypt_old: function(dec_key: PByte; const enc_key: PByte; enc_key_len: TIdC_INT; private_key: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_encrypt_old: function(dec_key: PByte; const enc_key: PByte; key_len: TIdC_INT; pub_key: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_type: function(type_: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_PKEY_id: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_PKEY_base_id: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_PKEY_bits: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_PKEY_security_bits: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_size: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {removed 3.0.0}
  EVP_PKEY_set_type: function(pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_set_type_str: function(pkey: PEVP_PKEY; const str: PIdAnsiChar; len: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_PKEY_set_alias_type: function(pkey: PEVP_PKEY; type_: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0 removed 3.0.0}

  EVP_PKEY_set1_engine: function(pkey: PEVP_PKEY; e: PENGINE): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get0_engine: function(const pkey: PEVP_PKEY): PENGINE; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_assign: function(pkey: PEVP_PKEY; type_: TIdC_INT; key: Pointer): TIdC_INT; cdecl = nil;
  EVP_PKEY_get0: function(const pkey: PEVP_PKEY): Pointer; cdecl = nil;
  EVP_PKEY_get0_hmac: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get0_poly1305: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get0_siphash: function(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_set1_RSA: function(pkey: PEVP_PKEY; key: PRSA): TIdC_INT; cdecl = nil;
  EVP_PKEY_get0_RSA: function(pkey: PEVP_PKEY): PRSA; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get1_RSA: function(pkey: PEVP_PKEY): PRSA; cdecl = nil;

  EVP_PKEY_set1_DSA: function(pkey: PEVP_PKEY; key: PDSA): TIdC_INT; cdecl = nil;
  EVP_PKEY_get0_DSA: function(pkey: PEVP_PKEY): PDSA; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get1_DSA: function(pkey: PEVP_PKEY): PDSA; cdecl = nil;

  EVP_PKEY_set1_DH: function(pkey: PEVP_PKEY; key: PDH): TIdC_INT; cdecl = nil;
  EVP_PKEY_get0_DH: function(pkey: PEVP_PKEY): PDH; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get1_DH: function(pkey: PEVP_PKEY): PDH; cdecl = nil;

  EVP_PKEY_set1_EC_KEY: function(pkey: PEVP_PKEY; key: PEC_KEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_get0_EC_KEY: function(pkey: PEVP_PKEY): PEC_KEY; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get1_EC_KEY: function(pkey: PEVP_PKEY): PEC_KEY; cdecl = nil;

  EVP_PKEY_new: function: PEVP_PKEY; cdecl = nil;
  EVP_PKEY_up_ref: function(pkey: PEVP_PKEY): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_free: procedure(pkey: PEVP_PKEY); cdecl = nil;

  d2i_PublicKey: function(type_: TIdC_INT; a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY; cdecl = nil;
  i2d_PublicKey: function(a: PEVP_PKEY; pp: PPByte): TIdC_INT; cdecl = nil;

  d2i_PrivateKey: function(type_: TIdC_INT; a: PEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY; cdecl = nil;
  d2i_AutoPrivateKey: function(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY; cdecl = nil;
  i2d_PrivateKey: function(a: PEVP_PKEY; pp: PPByte): TIdC_INT; cdecl = nil;

  EVP_PKEY_copy_parameters: function(to_: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_missing_parameters: function(const pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_save_parameters: function(pkey: PEVP_PKEY; mode: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_PKEY_cmp_parameters: function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT; cdecl = nil;

  EVP_PKEY_cmp: function(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT; cdecl = nil;

  EVP_PKEY_print_public: function(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_print_private: function(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_print_params: function(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT; cdecl = nil;

  EVP_PKEY_get_default_digest_nid: function(pkey: PEVP_PKEY; pnid: PIdC_INT): TIdC_INT; cdecl = nil;

  EVP_PKEY_set1_tls_encodedpoint: function(pkey: PEVP_PKEY; const pt: PByte; ptlen: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_get1_tls_encodedpoint: function(pkey: PEVP_PKEY; ppt: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0 removed 3.0.0}

  EVP_CIPHER_type: function(const ctx: PEVP_CIPHER): TIdC_INT; cdecl = nil; {removed 3.0.0}

  (* calls methods *)
  EVP_CIPHER_param_to_asn1: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT; cdecl = nil;
  EVP_CIPHER_asn1_to_param: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT; cdecl = nil;

  (* These are used by EVP_CIPHER methods *)
  EVP_CIPHER_set_asn1_iv: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT; cdecl = nil;
  EVP_CIPHER_get_asn1_iv: function(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT; cdecl = nil;

  (* PKCS5 password based encryption *)
  PKCS5_PBE_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS5_PBKDF2_HMAC_SHA1: function(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; keylen: TIdC_INT; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS5_PBKDF2_HMAC: function(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const digest: PEVP_MD; keylen: TIdC_INT; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS5_v2_PBE_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_PBE_scrypt: function(const pass: PIdAnsiChar; passlen: TIdC_SIZET; const salt: PByte; saltlen: TIdC_SIZET; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64; maxmem: TIdC_UINT64; key: PByte; keylen: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  PKCS5_v2_scrypt_keyivgen: function(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const c: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  PKCS5_PBE_add: procedure; cdecl = nil;

  EVP_PBE_CipherInit: function(pbe_obj: PASN1_OBJECT; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: TIdC_INT): TIdC_INT; cdecl = nil;

  (* PBE type *)
  EVP_PBE_alg_add_type: function(pbe_type: TIdC_INT; pbe_nid: TIdC_INT; cipher_nid: TIdC_INT; md_nid: TIdC_INT; keygen: PEVP_PBE_KEYGEN): TIdC_INT; cdecl = nil;
  EVP_PBE_alg_add: function(nid: TIdC_INT; const cipher: PEVP_CIPHER; const md: PEVP_MD; keygen: PEVP_PBE_KEYGEN): TIdC_INT; cdecl = nil;
  EVP_PBE_find: function(type_: TIdC_INT; pbe_nid: TIdC_INT; pcnid: PIdC_INT; pmnid: PIdC_INT; pkeygen: PPEVP_PBE_KEYGEN): TIdC_INT; cdecl = nil;
  EVP_PBE_cleanup: procedure; cdecl = nil;
  EVP_PBE_get: function(ptype: PIdC_INT; ppbe_nid: PIdC_INT; num: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_get_count: function: TIdC_INT; cdecl = nil;
  EVP_PKEY_asn1_get0: function(idx: TIdC_INT): PEVP_PKEY_ASN1_METHOD; cdecl = nil;
  EVP_PKEY_asn1_find: function(pe: PPENGINE; type_: TIdC_INT): PEVP_PKEY_ASN1_METHOD; cdecl = nil;
  EVP_PKEY_asn1_find_str: function(pe: PPENGINE; const str: PIdAnsiChar; len: TIdC_INT): PEVP_PKEY_ASN1_METHOD; cdecl = nil;
  EVP_PKEY_asn1_add0: function(const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT; cdecl = nil;
  EVP_PKEY_asn1_add_alias: function(to_: TIdC_INT; from: TIdC_INT): TIdC_INT; cdecl = nil;
  EVP_PKEY_asn1_get0_info: function(ppkey_id: PIdC_INT; pkey_base_id: PIdC_INT; ppkey_flags: PIdC_INT; const pinfo: PPIdAnsiChar; const ppem_str: PPIdAnsiChar; const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT; cdecl = nil;

  EVP_PKEY_get0_asn1: function(const pkey: PEVP_PKEY): PEVP_PKEY_ASN1_METHOD; cdecl = nil;
  EVP_PKEY_asn1_new: function(id: TIdC_INT; flags: TIdC_INT; const pem_str: PIdAnsiChar; const info: PIdAnsiChar): PEVP_PKEY_ASN1_METHOD; cdecl = nil;
  EVP_PKEY_asn1_copy: procedure(dst: PEVP_PKEY_ASN1_METHOD; const src: PEVP_PKEY_ASN1_METHOD); cdecl = nil;
  EVP_PKEY_asn1_free: procedure(ameth: PEVP_PKEY_ASN1_METHOD); cdecl = nil;

  EVP_PKEY_asn1_set_public: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APub_decode: pub_decode; APub_encode: pub_encode; APub_cmd: pub_cmd; APub_print: pub_print; APkey_size: pkey_size; APkey_bits: pkey_bits); cdecl = nil;
  EVP_PKEY_asn1_set_private: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APriv_decode: priv_decode; APriv_encode: priv_encode; APriv_print: priv_print); cdecl = nil;
  EVP_PKEY_asn1_set_param: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AParam_decode: param_decode; AParam_encode: param_encode; AParam_missing: param_missing; AParam_copy: param_copy; AParam_cmp: param_cmp; AParam_print: param_print); cdecl = nil;

  EVP_PKEY_asn1_set_free: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_free: pkey_free); cdecl = nil;
  EVP_PKEY_asn1_set_ctrl: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_ctrl: pkey_ctrl); cdecl = nil;
  EVP_PKEY_asn1_set_item: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AItem_verify: item_verify; AItem_sign: item_sign); cdecl = nil;

  EVP_PKEY_asn1_set_siginf: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASiginf_set: siginf_set); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_set_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_check: pkey_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_set_public_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_pub_check: pkey_pub_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_set_param_check: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_param_check: pkey_param_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_set_set_priv_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASet_priv_key: set_priv_key); cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_set_pub_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; ASet_pub_key: set_pub_key); cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_priv_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AGet_priv_key: get_priv_key); cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_pub_key: procedure(ameth: PEVP_PKEY_ASN1_METHOD; AGet_pub_key: get_pub_key); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_asn1_set_security_bits: procedure(ameth: PEVP_PKEY_ASN1_METHOD; APkey_security_bits: pkey_security_bits); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_find: function(type_: TIdC_INT): PEVP_PKEY_METHOD; cdecl = nil;
  EVP_PKEY_meth_new: function(id: TIdC_INT; flags: TIdC_INT): PEVP_PKEY_METHOD; cdecl = nil;
  EVP_PKEY_meth_get0_info: procedure(ppkey_id: PIdC_INT; pflags: PIdC_INT; const meth: PEVP_PKEY_METHOD); cdecl = nil;
  EVP_PKEY_meth_copy: procedure(dst: PEVP_PKEY_METHOD; const src: PEVP_PKEY_METHOD); cdecl = nil;
  EVP_PKEY_meth_free: procedure(pmeth: PEVP_PKEY_METHOD); cdecl = nil;
  EVP_PKEY_meth_add0: function(const pmeth: PEVP_PKEY_METHOD): TIdC_INT; cdecl = nil;
  EVP_PKEY_meth_remove: function(const pmeth: PEVP_PKEY_METHOD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_count: function: TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_meth_get0: function(idx: TIdC_SIZET): PEVP_PKEY_METHOD; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_new: function(pkey: PEVP_PKEY; e: PENGINE): PEVP_PKEY_CTX; cdecl = nil;
  EVP_PKEY_CTX_new_id: function(id: TIdC_INT; e: PENGINE): PEVP_PKEY_CTX; cdecl = nil;
  EVP_PKEY_CTX_dup: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY_CTX; cdecl = nil;
  EVP_PKEY_CTX_free: procedure(ctx: PEVP_PKEY_CTX); cdecl = nil;

  EVP_PKEY_CTX_ctrl: function(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT; cdecl = nil;
  EVP_PKEY_CTX_ctrl_str: function(ctx: PEVP_PKEY_CTX; const type_: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT; cdecl = nil;
  EVP_PKEY_CTX_ctrl_uint64: function(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; value: TIdC_UINT64): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_str2ctrl: function(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const str: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_CTX_hex2ctrl: function(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const hex: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_md: function(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; const md: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_get_operation: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_CTX_set0_keygen_info: procedure(ctx: PEVP_PKEY_CTX; dat: PIdC_INT; datlen: TIdC_INT); cdecl = nil;

  EVP_PKEY_new_mac_key: function(type_: TIdC_INT; e: PENGINE; const key: PByte; keylen: TIdC_INT): PEVP_PKEY; cdecl = nil;
  EVP_PKEY_new_raw_private_key: function(type_: TIdC_INT; e: PENGINE; const priv: PByte; len: TIdC_SIZET): PEVP_PKEY; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_new_raw_public_key: function(type_: TIdC_INT; e: PENGINE; const pub: PByte; len: TIdC_SIZET): PEVP_PKEY; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get_raw_private_key: function(const pkey: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_get_raw_public_key: function(const pkey: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_new_CMAC_key: function(e: PENGINE; const priv: PByte; len: TIdC_SIZET; const cipher: PEVP_CIPHER): PEVP_PKEY; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_set_data: procedure(ctx: PEVP_PKEY_CTX; data: Pointer); cdecl = nil;
  EVP_PKEY_CTX_get_data: function(ctx: PEVP_PKEY_CTX): Pointer; cdecl = nil;
  EVP_PKEY_CTX_get0_pkey: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY; cdecl = nil;

  EVP_PKEY_CTX_get0_peerkey: function(ctx: PEVP_PKEY_CTX): PEVP_PKEY; cdecl = nil;

  EVP_PKEY_CTX_set_app_data: procedure(ctx: PEVP_PKEY_CTX; data: Pointer); cdecl = nil;
  EVP_PKEY_CTX_get_app_data: function(ctx: PEVP_PKEY_CTX): Pointer; cdecl = nil;

  EVP_PKEY_sign_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_sign: function(ctx: PEVP_PKEY_CTX; sig: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  EVP_PKEY_verify_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_verify: function(ctx: PEVP_PKEY_CTX; const sig: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  EVP_PKEY_verify_recover_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_verify_recover: function(ctx: PEVP_PKEY_CTX; rout: PByte; routlen: PIdC_SIZET; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  EVP_PKEY_encrypt_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_encrypt: function(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  EVP_PKEY_decrypt_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_decrypt: function(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT; cdecl = nil;

  EVP_PKEY_derive_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_derive_set_peer: function(ctx: PEVP_PKEY_CTX; peer: PEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_derive: function(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT; cdecl = nil;

  EVP_PKEY_paramgen_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_paramgen: function(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_keygen_init: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil;
  EVP_PKEY_keygen: function(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT; cdecl = nil;
  EVP_PKEY_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_public_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EVP_PKEY_param_check: function(ctx: PEVP_PKEY_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_CTX_set_cb: procedure(ctx: PEVP_PKEY_CTX; cb: EVP_PKEY_gen_cb); cdecl = nil;
  EVP_PKEY_CTX_get_cb: function(ctx: PEVP_PKEY_CTX): EVP_PKEY_gen_cb; cdecl = nil;

  EVP_PKEY_CTX_get_keygen_info: function(ctx: PEVP_PKEY_CTX; idx: TIdC_INT): TIdC_INT; cdecl = nil;

  EVP_PKEY_meth_set_init: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: EVP_PKEY_meth_init); cdecl = nil;

  EVP_PKEY_meth_set_copy: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy_cb: EVP_PKEY_meth_copy_cb); cdecl = nil;

  EVP_PKEY_meth_set_cleanup: procedure(pmeth: PEVP_PKEY_METHOD; PEVP_PKEY_meth_cleanup: EVP_PKEY_meth_cleanup); cdecl = nil;

  EVP_PKEY_meth_set_paramgen: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: EVP_PKEY_meth_paramgen_init); cdecl = nil;

  EVP_PKEY_meth_set_keygen: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: EVP_PKEY_meth_keygen); cdecl = nil;

  EVP_PKEY_meth_set_sign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: EVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: EVP_PKEY_meth_sign); cdecl = nil;

  EVP_PKEY_meth_set_verify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: EVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: EVP_PKEY_meth_verify_init); cdecl = nil;

  EVP_PKEY_meth_set_verify_recover: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: EVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: EVP_PKEY_meth_verify_recover_init); cdecl = nil;

  EVP_PKEY_meth_set_signctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: EVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: EVP_PKEY_meth_signctx); cdecl = nil;

  EVP_PKEY_meth_set_verifyctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: EVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: EVP_PKEY_meth_verifyctx); cdecl = nil;

  EVP_PKEY_meth_set_encrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: EVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: EVP_PKEY_meth_encrypt); cdecl = nil;

  EVP_PKEY_meth_set_decrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: EVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: EVP_PKEY_meth_decrypt); cdecl = nil;

  EVP_PKEY_meth_set_derive: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: EVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: EVP_PKEY_meth_derive); cdecl = nil;

  EVP_PKEY_meth_set_ctrl: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: EVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: EVP_PKEY_meth_ctrl_str); cdecl = nil;

  EVP_PKEY_meth_set_digestsign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: EVP_PKEY_meth_digestsign); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_set_digestverify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: EVP_PKEY_meth_digestverify); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_set_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: EVP_PKEY_meth_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_set_public_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: EVP_PKEY_meth_public_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_set_param_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: EVP_PKEY_meth_param_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_set_digest_custom: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: EVP_PKEY_meth_digest_custom); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_init: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: PEVP_PKEY_meth_init); cdecl = nil;

  EVP_PKEY_meth_get_copy: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy: PEVP_PKEY_meth_copy); cdecl = nil;

  EVP_PKEY_meth_get_cleanup: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_cleanup: PEVP_PKEY_meth_cleanup); cdecl = nil;

  EVP_PKEY_meth_get_paramgen: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: PEVP_PKEY_meth_paramgen); cdecl = nil;

  EVP_PKEY_meth_get_keygen: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: PEVP_PKEY_meth_keygen); cdecl = nil;

  EVP_PKEY_meth_get_sign: procedure(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: PEVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: PEVP_PKEY_meth_sign); cdecl = nil;

  EVP_PKEY_meth_get_verify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: PEVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: PEVP_PKEY_meth_verify_init); cdecl = nil;

  EVP_PKEY_meth_get_verify_recover: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: PEVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: PEVP_PKEY_meth_verify_recover_init); cdecl = nil;

  EVP_PKEY_meth_get_signctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: PEVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: PEVP_PKEY_meth_signctx); cdecl = nil;

  EVP_PKEY_meth_get_verifyctx: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: PEVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: PEVP_PKEY_meth_verifyctx); cdecl = nil;

  EVP_PKEY_meth_get_encrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: PEVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: PEVP_PKEY_meth_encrypt); cdecl = nil;

  EVP_PKEY_meth_get_decrypt: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: PEVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: PEVP_PKEY_meth_decrypt); cdecl = nil;

  EVP_PKEY_meth_get_derive: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: PEVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: PEVP_PKEY_meth_derive); cdecl = nil;

  EVP_PKEY_meth_get_ctrl: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: PEVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: PEVP_PKEY_meth_ctrl_str); cdecl = nil;

  EVP_PKEY_meth_get_digestsign: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: PEVP_PKEY_meth_digestsign); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_digestverify: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: PEVP_PKEY_meth_digestverify); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: PEVP_PKEY_meth_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_public_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: PEVP_PKEY_meth_public_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_param_check: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: PEVP_PKEY_meth_param_check); cdecl = nil; {introduced 1.1.0}

  EVP_PKEY_meth_get_digest_custom: procedure(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: PEVP_PKEY_meth_digest_custom); cdecl = nil; {introduced 1.1.0}

  EVP_add_alg_module: procedure; cdecl = nil;

  OpenSSL_add_all_ciphers: procedure; cdecl = nil; {removed 1.1.0}

  OpenSSL_add_all_digests: procedure; cdecl = nil; {removed 1.1.0}

  EVP_cleanup: procedure; cdecl = nil; {removed 1.1.0}

{$ELSE}

  function EVP_MD_meth_new(md_type: TIdC_INT; pkey_type: TIdC_INT): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_dup(const md: PEVP_MD): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_MD_meth_free(md: PEVP_MD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_MD_meth_set_input_blocksize(md: PEVP_MD; blocksize: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_result_size(md: PEVP_MD; resultsize: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_app_datasize(md: PEVP_MD; datasize: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_flags(md: PEVP_MD; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_init(md: PEVP_MD; init: EVP_MD_meth_init): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_update(md: PEVP_MD; update: EVP_MD_meth_update): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_final(md: PEVP_MD; final_: EVP_MD_meth_final): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_copy(md: PEVP_MD; copy: EVP_MD_meth_copy): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_cleanup(md: PEVP_MD; cleanup: EVP_MD_meth_cleanup): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_set_ctrl(md: PEVP_MD; ctrl: EVP_MD_meth_ctrl): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_MD_meth_get_input_blocksize(const md: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_result_size(const md: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_app_datasize(const md: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_flags(const md: PEVP_MD): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_init(const md: PEVP_MD): EVP_MD_meth_init cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_update(const md: PEVP_MD): EVP_MD_meth_update cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_final(const md: PEVP_MD): EVP_MD_meth_final cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_copy(const md: PEVP_MD): EVP_MD_meth_copy cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_cleanup(const md: PEVP_MD): EVP_MD_meth_cleanup cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_meth_get_ctrl(const md: PEVP_MD): EVP_MD_meth_ctrl cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_CIPHER_meth_new(cipher_type: TIdC_INT; block_size: TIdC_INT; key_len: TIdC_INT): PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_dup(const cipher: PEVP_CIPHER): PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_CIPHER_meth_free(cipher: PEVP_CIPHER) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_CIPHER_meth_set_iv_length(cipher: PEVP_CIPHER; iv_len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_flags(cipher: PEVP_CIPHER; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_impl_ctx_size(cipher: PEVP_CIPHER; ctx_size: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_init(cipher: PEVP_CIPHER; init: EVP_CIPHER_meth_init): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_do_cipher(cipher: PEVP_CIPHER; do_cipher: EVP_CIPHER_meth_do_cipher): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_cleanup(cipher: PEVP_CIPHER; cleanup: EVP_CIPHER_meth_cleanup): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_set_asn1_params(cipher: PEVP_CIPHER; set_asn1_parameters: EVP_CIPHER_meth_set_asn1_params): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_get_asn1_params(cipher: PEVP_CIPHER; get_asn1_parameters: EVP_CIPHER_meth_get_asn1_params): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_set_ctrl(cipher: PEVP_CIPHER; ctrl: EVP_CIPHER_meth_ctrl): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_init(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_init cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_do_cipher(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_do_cipher cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_cleanup(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_cleanup cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_set_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_set_asn1_params cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_get_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_get_asn1_params cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_meth_get_ctrl(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_ctrl cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  /// Add some extra combinations ///
  //# define EVP_get_digestbynid(a) EVP_get_digestbyname(OBJ_nid2sn(a));
  //# define EVP_get_digestbyobj(a) EVP_get_digestbynid(OBJ_obj2nid(a));
  //# define EVP_get_cipherbynid(a) EVP_get_cipherbyname(OBJ_nid2sn(a));
  //# define EVP_get_cipherbyobj(a) EVP_get_cipherbynid(OBJ_obj2nid(a));

  //# define EVP_MD_nid(e)                   EVP_MD_type(e)
  //# define EVP_MD_name(e)                  OBJ_nid2sn(EVP_MD_nid(e))

  function EVP_MD_CTX_md(ctx: PEVP_MD_CTX): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_MD_CTX_update_fn(ctx: PEVP_MD_CTX): EVP_MD_CTX_update cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_MD_CTX_set_update_fn(ctx: PEVP_MD_CTX; update: EVP_MD_CTX_update) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //  EVP_MD_CTX_size(e)              EVP_MD_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_block_size(e)        EVP_MD_block_size(EVP_MD_CTX_md(e))
  //  EVP_MD_CTX_type(e)              EVP_MD_type(EVP_MD_CTX_md(e))
  procedure EVP_MD_CTX_set_pkey_ctx(ctx: PEVP_MD_CTX; pctx: PEVP_PKEY_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  //# define EVP_CIPHER_name(e)              OBJ_nid2sn(EVP_CIPHER_nid(e))
  function EVP_CIPHER_impl_ctx_size(const cipher: PEVP_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //# define EVP_CIPHER_mode(e)              (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)

  function EVP_CIPHER_CTX_cipher(const ctx: PEVP_CIPHER_CTX): PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_iv(const ctx: PEVP_CIPHER_CTX): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_CTX_original_iv(const ctx: PEVP_CIPHER_CTX): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_CTX_iv_noconst(ctx: PEVP_CIPHER_CTX): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_CTX_buf_noconst(ctx: PEVP_CIPHER_CTX): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_CIPHER_CTX_set_num(ctx: PEVP_CIPHER_CTX; num: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_CTX_copy(out_: PEVP_CIPHER_CTX; const in_: PEVP_CIPHER_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_get_app_data(const ctx: PEVP_CIPHER_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_CIPHER_CTX_set_app_data(ctx: PEVP_CIPHER_CTX; data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_get_cipher_data(const ctx: PEVP_CIPHER_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_CIPHER_CTX_set_cipher_data(ctx: PEVP_CIPHER_CTX; cipher_data: Pointer): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

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

  function EVP_MD_CTX_ctrl(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_CTX_new: PEVP_MD_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_MD_CTX_reset(ctx: PEVP_MD_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_MD_CTX_free(ctx: PEVP_MD_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //# define EVP_MD_CTX_create()     EVP_MD_CTX_new()
  //# define EVP_MD_CTX_init(ctx)    EVP_MD_CTX_reset((ctx))
  //# define EVP_MD_CTX_destroy(ctx) EVP_MD_CTX_free((ctx))
  function EVP_MD_CTX_copy_ex(out_: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_MD_CTX_set_flags(ctx: PEVP_MD_CTX; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_MD_CTX_clear_flags(ctx: PEVP_MD_CTX; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_MD_CTX_test_flags(const ctx: PEVP_MD_CTX; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestInit_ex(ctx: PEVP_MD_CTX; const type_: PEVP_MD; impl: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestUpdate(ctx: PEVP_MD_CTX; const d: Pointer; cnt: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestFinal_ex(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_Digest(const data: Pointer; count: TIdC_SIZET; md: PByte; size: PIdC_UINT; const type_: PEVP_MD; impl: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_MD_CTX_copy(out_: PEVP_MD_CTX; const in_: PEVP_MD_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestInit(ctx: PEVP_MD_CTX; const type_: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestFinal(ctx: PEVP_MD_CTX; md: PByte; s: PIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestFinalXOF(ctx: PEVP_MD_CTX; md: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_read_pw_string(buf: PIdAnsiChar; length: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_read_pw_string_min(buf: PIdAnsiChar; minlen: TIdC_INT; maxlen: TIdC_INT; const prompt: PIdAnsiChar; verify: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_set_pw_prompt(const prompt: PIdAnsiChar) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_get_pw_prompt: PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_BytesToKey(const type_: PEVP_CIPHER; const md: PEVP_MD; const salt: PByte; const data: PByte; data1: TIdC_INT; count: TIdC_INT; key: PByte; iv: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_CIPHER_CTX_set_flags(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_CIPHER_CTX_clear_flags(ctx: PEVP_CIPHER_CTX; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_test_flags(const ctx: PEVP_CIPHER_CTX; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_EncryptInit(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncryptInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncryptUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in_1: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncryptFinal_ex(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncryptFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_DecryptInit(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PidC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecryptInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecryptUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in_1: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecryptFinal(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecryptFinal_ex(ctx: PEVP_MD_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_CipherInit(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; const key: PByte; const iv: PByte; enc: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CipherInit_ex(ctx: PEVP_CIPHER_CTX; const cipher: PEVP_CIPHER; impl: PENGINE; const key: PByte; const iv: PByte; enc: TidC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CipherUpdate(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CipherFinal(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CipherFinal_ex(ctx: PEVP_CIPHER_CTX; outm: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_SignFinal(ctx: PEVP_CIPHER_CTX; md: PByte; s: PIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_DigestSign(ctx: PEVP_CIPHER_CTX; sigret: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_VerifyFinal(ctx: PEVP_MD_CTX; const sigbuf: PByte; siglen: TIdC_UINT; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_DigestVerify(ctx: PEVP_CIPHER_CTX; const sigret: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_DigestSignInit(ctx: PEVP_MD_CTX; pctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestSignFinal(ctx: PEVP_MD_CTX; sigret: PByte; siglen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_DigestVerifyInit(ctx: PEVP_MD_CTX; ppctx: PPEVP_PKEY_CTX; const type_: PEVP_MD; e: PENGINE; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DigestVerifyFinal(ctx: PEVP_MD_CTX; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_OpenInit(ctx: PEVP_CIPHER_CTX; const type_: PEVP_CIPHER; const ek: PByte; ek1: TIdC_INT; const iv: PByte; priv: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_OpenFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_SealInit(ctx: PEVP_CIPHER_CTX; const type_: EVP_CIPHER; ek: PPByte; ek1: PIdC_INT; iv: PByte; pubk: PPEVP_PKEY; npubk: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_SealFinal(ctx: PEVP_CIPHER_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_ENCODE_CTX_new: PEVP_ENCODE_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_ENCODE_CTX_free(ctx: PEVP_ENCODE_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_ENCODE_CTX_copy(dctx: PEVP_ENCODE_CTX; sctx: PEVP_ENCODE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_ENCODE_CTX_num(ctx: PEVP_ENCODE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_EncodeInit(ctx: PEVP_ENCODE_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncodeUpdate(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_EncodeFinal(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_EncodeBlock(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_DecodeInit(ctx: PEVP_ENCODE_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecodeUpdate(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT; const in_: PByte; in1: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecodeFinal(ctx: PEVP_ENCODE_CTX; out_: PByte; out1: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_DecodeBlock(t: PByte; const f: PByte; n: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_CIPHER_CTX_new: PEVP_CIPHER_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_reset(c: PEVP_CIPHER_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_CIPHER_CTX_free(c: PEVP_CIPHER_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_set_key_length(x: PEVP_CIPHER_CTX; keylen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_set_padding(c: PEVP_CIPHER_CTX; pad: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_ctrl(ctx: PEVP_CIPHER_CTX; type_: TIdC_INT; arg: TIdC_INT; ptr: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_CTX_rand_key(ctx: PEVP_CIPHER_CTX; key: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_f_md: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_base64: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_cipher: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_reliable: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_set_cipher(b: PBIO; c: PEVP_CIPHER; const k: PByte; const i: PByte; enc: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_md_null: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_md5: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_md5_sha1: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_sha1: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_sha224: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_sha256: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_sha384: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_sha512: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_sha512_224: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sha512_256: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sha3_224: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sha3_256: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sha3_384: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sha3_512: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_shake128: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_shake256: PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  (* does nothing :-) *)
  function EVP_enc_null: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_des_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_des_cfb EVP_des_cfb64
  function EVP_des_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_des_ede3_cfb EVP_des_ede3_cfb64
  function EVP_des_ede3_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_desx_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_des_ede3_wrap: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //
  // This should now be supported through the dev_crypto ENGINE. But also, why
  // are rc4 and md5 declarations made here inside a "NO_DES" precompiler
  // branch?
  //
  function EVP_rc4: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_rc4_40: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  function EVP_idea_ecb: PEVP_CIPHER;
// function EVP_idea_cfb64: PEVP_CIPHER;
  //EVP_idea_cfb EVP_idea_cfb64
//  function EVP_idea_ofb: PEVP_CIPHER;
 // function EVP_idea_cbc: PEVP_CIPHER;
  function EVP_rc2_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_rc2_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_rc2_40_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_rc2_64_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_rc2_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_rc2_cfb EVP_rc2_cfb64
  function EVP_rc2_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_bf_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_bf_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_bf_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_bf_cfb EVP_bf_cfb64
  function EVP_bf_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_cast5_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_cast5_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_cast5_cfb64: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_cast5_cfb EVP_cast5_cfb64
  function EVP_cast5_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  function EVP_rc5_32_12_16_cbc: PEVP_CIPHER;
//  function EVP_rc5_32_12_16_ecb: PEVP_CIPHER;
//  function EVP_rc5_32_12_16_cfb64: PEVP_CIPHER;
  //EVP_rc5_32_12_16_cfb EVP_rc5_32_12_16_cfb64
//  function EVP_rc5_32_12_16_ofb: PEVP_CIPHER;

  function EVP_aes_128_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_aes_128_cfb EVP_aes_128_cfb128
  function EVP_aes_128_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_xts: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_wrap: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_wrap_pad: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_128_ocb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_192_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_aes_192_cfb EVP_aes_192_cfb128
  function EVP_aes_192_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_wrap: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_192_wrap_pad: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_192_ocb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_256_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_aes_256_cfb EVP_aes_256_cfb128
  function EVP_aes_256_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_xts: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_wrap: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_wrap_pad: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_256_ocb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aes_128_cbc_hmac_sha1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cbc_hmac_sha1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_128_cbc_hmac_sha256: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_aes_256_cbc_hmac_sha256: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_aria_128_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_128_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //EVP_aria_192_cfb EVP_aria_192_cfb128
  function EVP_aria_192_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_192_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //EVP_aria_256_cfb EVP_aria_256_cfb128
  function EVP_aria_256_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_gcm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_aria_256_ccm: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_camellia_128_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_128_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_128_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_128_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_128_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_camellia_128_cfb EVP_camellia_128_cfb128
  function EVP_camellia_128_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_128_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_camellia_192_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_192_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_192_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_192_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_192_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_camellia_192_cfb EVP_camellia_192_cfb128
  function EVP_camellia_192_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_192_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_camellia_256_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_256_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_256_cfb1: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_256_cfb8: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_256_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_camellia_256_cfb EVP_camellia_256_cfb128
  function EVP_camellia_256_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_camellia_256_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_chacha20: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_chacha20_poly1305: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_seed_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_seed_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_seed_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //EVP_seed_cfb EVP_seed_cfb128
  function EVP_seed_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_sm4_ecb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sm4_cbc: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sm4_cfb128: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //EVP_sm4_cfb EVP_sm4_cfb128
  function EVP_sm4_ofb: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_sm4_ctr: PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_add_cipher(const cipher: PEVP_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_add_digest(const digest: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_get_cipherbyname(const name: PIdAnsiChar): PEVP_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_get_digestbyname(const name: PIdAnsiChar): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_CIPHER_do_all(AFn: fn; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_CIPHER_do_all_sorted(AFn: fn; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_MD_do_all(AFn: fn; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_MD_do_all_sorted(AFn: fn; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_decrypt_old(dec_key: PByte; const enc_key: PByte; enc_key_len: TIdC_INT; private_key: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_encrypt_old(dec_key: PByte; const enc_key: PByte; key_len: TIdC_INT; pub_key: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_type(type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_set_type(pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_set_type_str(pkey: PEVP_PKEY; const str: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_set1_engine(pkey: PEVP_PKEY; e: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get0_engine(const pkey: PEVP_PKEY): PENGINE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_assign(pkey: PEVP_PKEY; type_: TIdC_INT; key: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0(const pkey: PEVP_PKEY): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0_hmac(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get0_poly1305(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get0_siphash(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_set1_RSA(pkey: PEVP_PKEY; key: PRSA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0_RSA(pkey: PEVP_PKEY): PRSA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get1_RSA(pkey: PEVP_PKEY): PRSA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_set1_DSA(pkey: PEVP_PKEY; key: PDSA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0_DSA(pkey: PEVP_PKEY): PDSA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get1_DSA(pkey: PEVP_PKEY): PDSA cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_set1_DH(pkey: PEVP_PKEY; key: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0_DH(pkey: PEVP_PKEY): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get1_DH(pkey: PEVP_PKEY): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_set1_EC_KEY(pkey: PEVP_PKEY; key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_get0_EC_KEY(pkey: PEVP_PKEY): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get1_EC_KEY(pkey: PEVP_PKEY): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_new: PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_up_ref(pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_PKEY_free(pkey: PEVP_PKEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function d2i_PublicKey(type_: TIdC_INT; a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_PublicKey(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function d2i_PrivateKey(type_: TIdC_INT; a: PEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_AutoPrivateKey(a: PPEVP_PKEY; const pp: PPByte; length: TIdC_LONG): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_PrivateKey(a: PEVP_PKEY; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_copy_parameters(to_: PEVP_PKEY; const from: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_missing_parameters(const pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_save_parameters(pkey: PEVP_PKEY; mode: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_cmp_parameters(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_cmp(const a: PEVP_PKEY; const b: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_print_public(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_print_private(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_print_params(out_: PBIO; const pkey: PEVP_PKEY; indent: TIdC_INT; pctx: PASN1_PCTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_get_default_digest_nid(pkey: PEVP_PKEY; pnid: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};



  (* calls methods *)
  function EVP_CIPHER_param_to_asn1(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_asn1_to_param(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* These are used by EVP_CIPHER methods *)
  function EVP_CIPHER_set_asn1_iv(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_CIPHER_get_asn1_iv(c: PEVP_CIPHER_CTX; type_: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* PKCS5 password based encryption *)
  function PKCS5_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function PKCS5_PBKDF2_HMAC_SHA1(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; keylen: TIdC_INT; out_: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function PKCS5_PBKDF2_HMAC(const pass: PIdAnsiChar; passlen: TIdC_INT; const salt: PByte; saltlen: TIdC_INT; iter: TIdC_INT; const digest: PEVP_MD; keylen: TIdC_INT; out_: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function PKCS5_v2_PBE_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const cipher: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PBE_scrypt(const pass: PIdAnsiChar; passlen: TIdC_SIZET; const salt: PByte; saltlen: TIdC_SIZET; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64; maxmem: TIdC_UINT64; key: PByte; keylen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function PKCS5_v2_scrypt_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const c: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure PKCS5_PBE_add cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PBE_CipherInit(pbe_obj: PASN1_OBJECT; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; ctx: PEVP_CIPHER_CTX; en_de: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* PBE type *)
  function EVP_PBE_alg_add_type(pbe_type: TIdC_INT; pbe_nid: TIdC_INT; cipher_nid: TIdC_INT; md_nid: TIdC_INT; keygen: PEVP_PBE_KEYGEN): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PBE_alg_add(nid: TIdC_INT; const cipher: PEVP_CIPHER; const md: PEVP_MD; keygen: PEVP_PBE_KEYGEN): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PBE_find(type_: TIdC_INT; pbe_nid: TIdC_INT; pcnid: PIdC_INT; pmnid: PIdC_INT; pkeygen: PPEVP_PBE_KEYGEN): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PBE_cleanup cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PBE_get(ptype: PIdC_INT; ppbe_nid: PIdC_INT; num: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_asn1_get_count: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_get0(idx: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_find(pe: PPENGINE; type_: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_find_str(pe: PPENGINE; const str: PIdAnsiChar; len: TIdC_INT): PEVP_PKEY_ASN1_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_add0(const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_add_alias(to_: TIdC_INT; from: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_get0_info(ppkey_id: PIdC_INT; pkey_base_id: PIdC_INT; ppkey_flags: PIdC_INT; const pinfo: PPIdAnsiChar; const ppem_str: PPIdAnsiChar; const ameth: PEVP_PKEY_ASN1_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_get0_asn1(const pkey: PEVP_PKEY): PEVP_PKEY_ASN1_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_asn1_new(id: TIdC_INT; flags: TIdC_INT; const pem_str: PIdAnsiChar; const info: PIdAnsiChar): PEVP_PKEY_ASN1_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_copy(dst: PEVP_PKEY_ASN1_METHOD; const src: PEVP_PKEY_ASN1_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_free(ameth: PEVP_PKEY_ASN1_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_asn1_set_public(ameth: PEVP_PKEY_ASN1_METHOD; APub_decode: pub_decode; APub_encode: pub_encode; APub_cmd: pub_cmd; APub_print: pub_print; APkey_size: pkey_size; APkey_bits: pkey_bits) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_set_private(ameth: PEVP_PKEY_ASN1_METHOD; APriv_decode: priv_decode; APriv_encode: priv_encode; APriv_print: priv_print) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_set_param(ameth: PEVP_PKEY_ASN1_METHOD; AParam_decode: param_decode; AParam_encode: param_encode; AParam_missing: param_missing; AParam_copy: param_copy; AParam_cmp: param_cmp; AParam_print: param_print) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_asn1_set_free(ameth: PEVP_PKEY_ASN1_METHOD; APkey_free: pkey_free) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_set_ctrl(ameth: PEVP_PKEY_ASN1_METHOD; APkey_ctrl: pkey_ctrl) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_asn1_set_item(ameth: PEVP_PKEY_ASN1_METHOD; AItem_verify: item_verify; AItem_sign: item_sign) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_asn1_set_siginf(ameth: PEVP_PKEY_ASN1_METHOD; ASiginf_set: siginf_set) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_asn1_set_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_check: pkey_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_asn1_set_public_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_pub_check: pkey_pub_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_asn1_set_param_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_param_check: pkey_param_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_asn1_set_set_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_priv_key: set_priv_key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_PKEY_asn1_set_set_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_pub_key: set_pub_key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_PKEY_asn1_set_get_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_priv_key: get_priv_key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EVP_PKEY_asn1_set_get_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_pub_key: get_pub_key) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_asn1_set_security_bits(ameth: PEVP_PKEY_ASN1_METHOD; APkey_security_bits: pkey_security_bits) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_meth_find(type_: TIdC_INT): PEVP_PKEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_meth_new(id: TIdC_INT; flags: TIdC_INT): PEVP_PKEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_meth_get0_info(ppkey_id: PIdC_INT; pflags: PIdC_INT; const meth: PEVP_PKEY_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_meth_copy(dst: PEVP_PKEY_METHOD; const src: PEVP_PKEY_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_meth_free(pmeth: PEVP_PKEY_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_meth_add0(const pmeth: PEVP_PKEY_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_meth_remove(const pmeth: PEVP_PKEY_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_meth_get_count: TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_meth_get0(idx: TIdC_SIZET): PEVP_PKEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_CTX_new(pkey: PEVP_PKEY; e: PENGINE): PEVP_PKEY_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_new_id(id: TIdC_INT; e: PENGINE): PEVP_PKEY_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_dup(ctx: PEVP_PKEY_CTX): PEVP_PKEY_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_CTX_free(ctx: PEVP_PKEY_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_CTX_ctrl(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_ctrl_str(ctx: PEVP_PKEY_CTX; const type_: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_ctrl_uint64(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; value: TIdC_UINT64): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_CTX_str2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_CTX_hex2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const hex: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_CTX_md(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; const md: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_CTX_get_operation(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EVP_PKEY_CTX_set0_keygen_info(ctx: PEVP_PKEY_CTX; dat: PIdC_INT; datlen: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_new_mac_key(type_: TIdC_INT; e: PENGINE; const key: PByte; keylen: TIdC_INT): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_new_raw_private_key(type_: TIdC_INT; e: PENGINE; const priv: PByte; len: TIdC_SIZET): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_new_raw_public_key(type_: TIdC_INT; e: PENGINE; const pub: PByte; len: TIdC_SIZET): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get_raw_private_key(const pkey: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_get_raw_public_key(const pkey: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EVP_PKEY_new_CMAC_key(e: PENGINE; const priv: PByte; len: TIdC_SIZET; const cipher: PEVP_CIPHER): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_CTX_set_data(ctx: PEVP_PKEY_CTX; data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_get_data(ctx: PEVP_PKEY_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_get0_pkey(ctx: PEVP_PKEY_CTX): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_CTX_get0_peerkey(ctx: PEVP_PKEY_CTX): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_CTX_set_app_data(ctx: PEVP_PKEY_CTX; data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_get_app_data(ctx: PEVP_PKEY_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_sign_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_sign(ctx: PEVP_PKEY_CTX; sig: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_verify_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_verify(ctx: PEVP_PKEY_CTX; const sig: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_verify_recover_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_verify_recover(ctx: PEVP_PKEY_CTX; rout: PByte; routlen: PIdC_SIZET; const sig: PByte; siglen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_encrypt_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_encrypt(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_decrypt_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_decrypt(ctx: PEVP_PKEY_CTX; out_: PByte; outlen: PIdC_SIZET; const in_: PByte; inlen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_derive_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_derive_set_peer(ctx: PEVP_PKEY_CTX; peer: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_derive(ctx: PEVP_PKEY_CTX; key: PByte; keylen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_paramgen_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_paramgen(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_keygen_init(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_keygen(ctx: PEVP_PKEY_CTX; ppkey: PPEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_check(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_public_check(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EVP_PKEY_param_check(ctx: PEVP_PKEY_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_CTX_set_cb(ctx: PEVP_PKEY_CTX; cb: EVP_PKEY_gen_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EVP_PKEY_CTX_get_cb(ctx: PEVP_PKEY_CTX): EVP_PKEY_gen_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EVP_PKEY_CTX_get_keygen_info(ctx: PEVP_PKEY_CTX; idx: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_init(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: EVP_PKEY_meth_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_copy(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy_cb: EVP_PKEY_meth_copy_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_cleanup(pmeth: PEVP_PKEY_METHOD; PEVP_PKEY_meth_cleanup: EVP_PKEY_meth_cleanup) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_paramgen(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: EVP_PKEY_meth_paramgen_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_keygen(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: EVP_PKEY_meth_keygen) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_sign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: EVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: EVP_PKEY_meth_sign) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_verify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: EVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: EVP_PKEY_meth_verify_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_verify_recover(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: EVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: EVP_PKEY_meth_verify_recover_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_signctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: EVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: EVP_PKEY_meth_signctx) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_verifyctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: EVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: EVP_PKEY_meth_verifyctx) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_encrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: EVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: EVP_PKEY_meth_encrypt) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_decrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: EVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: EVP_PKEY_meth_decrypt) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_derive(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: EVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: EVP_PKEY_meth_derive) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_ctrl(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: EVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: EVP_PKEY_meth_ctrl_str) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_set_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: EVP_PKEY_meth_digestsign) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_set_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: EVP_PKEY_meth_digestverify) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_set_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: EVP_PKEY_meth_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_set_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: EVP_PKEY_meth_public_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_set_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: EVP_PKEY_meth_param_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_set_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: EVP_PKEY_meth_digest_custom) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_init(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_init: PEVP_PKEY_meth_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_copy(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_copy: PEVP_PKEY_meth_copy) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_cleanup(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_cleanup: PEVP_PKEY_meth_cleanup) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_paramgen(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_paramgen_init: EVP_PKEY_meth_paramgen_init; AEVP_PKEY_meth_paramgen: PEVP_PKEY_meth_paramgen) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_keygen(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_keygen_init: EVP_PKEY_meth_keygen_init; AEVP_PKEY_meth_keygen: PEVP_PKEY_meth_keygen) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_sign(const pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_sign_init: PEVP_PKEY_meth_sign_init; AEVP_PKEY_meth_sign: PEVP_PKEY_meth_sign) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_verify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_init: PEVP_PKEY_meth_verify_init; AEVP_PKEY_meth_verify: PEVP_PKEY_meth_verify_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_verify_recover(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verify_recover_init: PEVP_PKEY_meth_verify_recover_init; AEVP_PKEY_meth_verify_recover: PEVP_PKEY_meth_verify_recover_init) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_signctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_signctx_init: PEVP_PKEY_meth_signctx_init; AEVP_PKEY_meth_signctx: PEVP_PKEY_meth_signctx) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_verifyctx(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_verifyctx_init: PEVP_PKEY_meth_verifyctx_init; AEVP_PKEY_meth_verifyctx: PEVP_PKEY_meth_verifyctx) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_encrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_encrypt_init: PEVP_PKEY_meth_encrypt_init; AEVP_PKEY_meth_encrypt: PEVP_PKEY_meth_encrypt) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_decrypt(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_decrypt_init: PEVP_PKEY_meth_decrypt_init; AEVP_PKEY_meth_decrypt: PEVP_PKEY_meth_decrypt) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_derive(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_derive_init: PEVP_PKEY_meth_derive_init; AEVP_PKEY_meth_derive: PEVP_PKEY_meth_derive) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_ctrl(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_ctrl: PEVP_PKEY_meth_ctrl; AEVP_PKEY_meth_ctrl_str: PEVP_PKEY_meth_ctrl_str) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EVP_PKEY_meth_get_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: PEVP_PKEY_meth_digestsign) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: PEVP_PKEY_meth_digestverify) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: PEVP_PKEY_meth_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: PEVP_PKEY_meth_public_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: PEVP_PKEY_meth_param_check) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_PKEY_meth_get_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: PEVP_PKEY_meth_digest_custom) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EVP_add_alg_module cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};




function EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT; {removed 1.0.0}
function EVP_PKEY_assign_DSA(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT; {removed 1.0.0}
function EVP_PKEY_assign_DH(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT; {removed 1.0.0}
function EVP_PKEY_assign_EC_KEY(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT; {removed 1.0.0}
function EVP_PKEY_assign_SIPHASH(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT; {removed 1.0.0}
function EVP_PKEY_assign_POLY1305(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT; {removed 1.0.0}
  procedure BIO_set_md(v1: PBIO; const md: PEVP_MD); {removed 1.0.0}
  procedure OpenSSL_add_all_ciphers; {removed 1.1.0}
  procedure OpenSSL_add_all_digests; {removed 1.1.0}
  procedure EVP_cleanup; {removed 1.1.0}
{$ENDIF}

implementation

uses 
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  classes,
  IdSSLOpenSSLExceptionHandlers,
  IdSSLOpenSSLLoader,
  {$ENDIF} IdOpenSSLHeaders_crypto;
  
const
  EVP_MD_meth_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_dup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_input_blocksize_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_result_size_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_app_datasize_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_update_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_final_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_copy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_set_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_input_blocksize_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_result_size_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_app_datasize_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_update_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_final_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_copy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_meth_get_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_dup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_iv_length_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_impl_ctx_size_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_do_cipher_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_set_asn1_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_get_asn1_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_set_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_do_cipher_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_set_asn1_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_get_asn1_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_meth_get_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_update_fn_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_set_update_fn_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_pkey_ctx_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_set_pkey_ctx_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_md_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_impl_ctx_size_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_encrypting_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_iv_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_original_iv_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_iv_noconst_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_buf_noconst_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_num_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_set_num_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_get_cipher_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_set_cipher_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_reset_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_MD_CTX_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_DigestFinalXOF_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_DigestSign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_DigestVerify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_ENCODE_CTX_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_ENCODE_CTX_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_ENCODE_CTX_copy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_ENCODE_CTX_num_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_CIPHER_CTX_reset_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_md5_sha1_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha512_224_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha512_256_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha3_224_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha3_256_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha3_384_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sha3_512_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_shake128_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_shake256_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_128_wrap_pad_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_128_ocb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_192_wrap_pad_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_192_ocb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_256_wrap_pad_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aes_256_ocb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_ecb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_cbc_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_cfb1_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_cfb8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_cfb128_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_ofb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_gcm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_128_ccm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_ecb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_cbc_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_cfb1_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_cfb8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_cfb128_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_ofb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_gcm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_192_ccm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_ecb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_cbc_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_cfb1_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_cfb8_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_cfb128_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_ofb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_gcm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_aria_256_ccm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_camellia_128_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_camellia_192_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_camellia_256_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_chacha20_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_chacha20_poly1305_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sm4_ecb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sm4_cbc_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sm4_cfb128_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sm4_ofb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_sm4_ctr_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_security_bits_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_set_alias_type_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_set1_engine_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_engine_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_hmac_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_poly1305_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_siphash_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_RSA_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_DSA_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_DH_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get0_EC_KEY_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_set1_tls_encodedpoint_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get1_tls_encodedpoint_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PBE_scrypt_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  PKCS5_v2_scrypt_keyivgen_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PBE_get_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_siginf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_public_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_param_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_set_priv_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_set_pub_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_get_priv_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_get_pub_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_asn1_set_security_bits_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_remove_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_count_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get0_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_CTX_ctrl_uint64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_CTX_str2ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_CTX_hex2ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_CTX_md_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_new_raw_private_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_new_raw_public_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get_raw_private_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_get_raw_public_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_new_CMAC_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_public_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_param_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_digestsign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_digestverify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_public_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_param_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_set_digest_custom_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_digestsign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_digestverify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_public_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_param_check_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_meth_get_digest_custom_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_PKEY_assign_RSA_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_assign_DSA_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_assign_DH_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_assign_EC_KEY_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_assign_SIPHASH_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_assign_POLY1305_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_type_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_pkey_type_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_size_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_block_size_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_flags_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_CTX_pkey_ctx_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_MD_CTX_md_data_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_nid_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_block_size_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_key_length_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_iv_length_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_flags_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_encrypting_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_nid_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_block_size_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_key_length_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_iv_length_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_CTX_num_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_md_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_id_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_base_id_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_bits_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_security_bits_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_size_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_set_alias_type_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_set1_tls_encodedpoint_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_PKEY_get1_tls_encodedpoint_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EVP_CIPHER_type_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OpenSSL_add_all_ciphers_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OpenSSL_add_all_digests_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EVP_cleanup_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);


//#  define EVP_PKEY_assign_RSA(pkey,rsa) EVP_PKEY_assign((pkey),EVP_PKEY_RSA, (char *)(rsa))
{$IFNDEF USE_EXTERNAL_LIBRARY}


//#  define EVP_PKEY_assign_RSA(pkey,rsa) EVP_PKEY_assign((pkey),EVP_PKEY_RSA, (char *)(rsa))
function _EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_RSA, rsa);
end;

//#  define EVP_PKEY_assign_DSA(pkey,dsa) EVP_PKEY_assign((pkey),EVP_PKEY_DSA, (char *)(dsa))
function _EVP_PKEY_assign_DSA(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_DSA, dsa);
end;

//#  define EVP_PKEY_assign_DH(pkey,dh) EVP_PKEY_assign((pkey),EVP_PKEY_DH, (char *)(dh))
function _EVP_PKEY_assign_DH(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_DH, dh);
end;

//#  define EVP_PKEY_assign_EC_KEY(pkey,eckey) EVP_PKEY_assign((pkey),EVP_PKEY_EC, (char *)(eckey))
function _EVP_PKEY_assign_EC_KEY(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_EC, eckey);
end;

//#  define EVP_PKEY_assign_SIPHASH(pkey,shkey) EVP_PKEY_assign((pkey),EVP_PKEY_SIPHASH, (char *)(shkey))
function _EVP_PKEY_assign_SIPHASH(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_SIPHASH, shkey);
end;

//#  define EVP_PKEY_assign_POLY1305(pkey,polykey) EVP_PKEY_assign((pkey),EVP_PKEY_POLY1305, (char *)(polykey))
function _EVP_PKEY_assign_POLY1305(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT; cdecl;
begin
  Result := EVP_PKEY_assign(pkey, EVP_PKEY_POLY1305, polykey);
end;

procedure _OpenSSL_add_all_ciphers; cdecl;
begin
  OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS, nil);
end;

procedure _OpenSSL_add_all_digests; cdecl;
begin
  OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_DIGESTS, Nil);
end;

procedure _EVP_cleanup; cdecl;
begin
end;

procedure _BIO_set_md(v1: PBIO; const md: PEVP_MD); cdecl;
begin
  {define BIO_set_md(b,md)  BIO_ctrl(b,BIO_C_SET_MD,0,(char *)(md))}
  BIO_ctrl(v1,BIO_C_SET_MD,0,PIdAnsiChar(md));
end;

{$WARN  NO_RETVAL OFF}
function ERR_EVP_PKEY_assign_RSA(pkey: PEVP_PKEY; rsa: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_RSA');
end;


function ERR_EVP_PKEY_assign_DSA(pkey: PEVP_PKEY; dsa: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_DSA');
end;


function ERR_EVP_PKEY_assign_DH(pkey: PEVP_PKEY; dh: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_DH');
end;


function ERR_EVP_PKEY_assign_EC_KEY(pkey: PEVP_PKEY; eckey: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_EC_KEY');
end;


function ERR_EVP_PKEY_assign_SIPHASH(pkey: PEVP_PKEY; shkey: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_SIPHASH');
end;


function ERR_EVP_PKEY_assign_POLY1305(pkey: PEVP_PKEY; polykey: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_assign_POLY1305');
end;


function ERR_EVP_MD_meth_new(md_type: TIdC_INT; pkey_type: TIdC_INT): PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_new');
end;


function ERR_EVP_MD_meth_dup(const md: PEVP_MD): PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_dup');
end;


procedure ERR_EVP_MD_meth_free(md: PEVP_MD); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_free');
end;


function ERR_EVP_MD_meth_set_input_blocksize(md: PEVP_MD; blocksize: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_input_blocksize');
end;


function ERR_EVP_MD_meth_set_result_size(md: PEVP_MD; resultsize: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_result_size');
end;


function ERR_EVP_MD_meth_set_app_datasize(md: PEVP_MD; datasize: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_app_datasize');
end;


function ERR_EVP_MD_meth_set_flags(md: PEVP_MD; flags: TIdC_ULONG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_flags');
end;


function ERR_EVP_MD_meth_set_init(md: PEVP_MD; init: EVP_MD_meth_init): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_init');
end;


function ERR_EVP_MD_meth_set_update(md: PEVP_MD; update: EVP_MD_meth_update): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_update');
end;


function ERR_EVP_MD_meth_set_final(md: PEVP_MD; final_: EVP_MD_meth_final): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_final');
end;


function ERR_EVP_MD_meth_set_copy(md: PEVP_MD; copy: EVP_MD_meth_copy): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_copy');
end;


function ERR_EVP_MD_meth_set_cleanup(md: PEVP_MD; cleanup: EVP_MD_meth_cleanup): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_cleanup');
end;


function ERR_EVP_MD_meth_set_ctrl(md: PEVP_MD; ctrl: EVP_MD_meth_ctrl): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_set_ctrl');
end;


function ERR_EVP_MD_meth_get_input_blocksize(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_input_blocksize');
end;


function ERR_EVP_MD_meth_get_result_size(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_result_size');
end;


function ERR_EVP_MD_meth_get_app_datasize(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_app_datasize');
end;


function ERR_EVP_MD_meth_get_flags(const md: PEVP_MD): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_flags');
end;


function ERR_EVP_MD_meth_get_init(const md: PEVP_MD): EVP_MD_meth_init; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_init');
end;


function ERR_EVP_MD_meth_get_update(const md: PEVP_MD): EVP_MD_meth_update; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_update');
end;


function ERR_EVP_MD_meth_get_final(const md: PEVP_MD): EVP_MD_meth_final; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_final');
end;


function ERR_EVP_MD_meth_get_copy(const md: PEVP_MD): EVP_MD_meth_copy; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_copy');
end;


function ERR_EVP_MD_meth_get_cleanup(const md: PEVP_MD): EVP_MD_meth_cleanup; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_cleanup');
end;


function ERR_EVP_MD_meth_get_ctrl(const md: PEVP_MD): EVP_MD_meth_ctrl; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_meth_get_ctrl');
end;


function ERR_EVP_CIPHER_meth_new(cipher_type: TIdC_INT; block_size: TIdC_INT; key_len: TIdC_INT): PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_new');
end;


function ERR_EVP_CIPHER_meth_dup(const cipher: PEVP_CIPHER): PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_dup');
end;


procedure ERR_EVP_CIPHER_meth_free(cipher: PEVP_CIPHER); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_free');
end;


function ERR_EVP_CIPHER_meth_set_iv_length(cipher: PEVP_CIPHER; iv_len: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_iv_length');
end;


function ERR_EVP_CIPHER_meth_set_flags(cipher: PEVP_CIPHER; flags: TIdC_ULONG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_flags');
end;


function ERR_EVP_CIPHER_meth_set_impl_ctx_size(cipher: PEVP_CIPHER; ctx_size: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_impl_ctx_size');
end;


function ERR_EVP_CIPHER_meth_set_init(cipher: PEVP_CIPHER; init: EVP_CIPHER_meth_init): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_init');
end;


function ERR_EVP_CIPHER_meth_set_do_cipher(cipher: PEVP_CIPHER; do_cipher: EVP_CIPHER_meth_do_cipher): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_do_cipher');
end;


function ERR_EVP_CIPHER_meth_set_cleanup(cipher: PEVP_CIPHER; cleanup: EVP_CIPHER_meth_cleanup): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_cleanup');
end;


function ERR_EVP_CIPHER_meth_set_set_asn1_params(cipher: PEVP_CIPHER; set_asn1_parameters: EVP_CIPHER_meth_set_asn1_params): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_set_asn1_params');
end;


function ERR_EVP_CIPHER_meth_set_get_asn1_params(cipher: PEVP_CIPHER; get_asn1_parameters: EVP_CIPHER_meth_get_asn1_params): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_get_asn1_params');
end;


function ERR_EVP_CIPHER_meth_set_ctrl(cipher: PEVP_CIPHER; ctrl: EVP_CIPHER_meth_ctrl): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_set_ctrl');
end;


function ERR_EVP_CIPHER_meth_get_init(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_init; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_init');
end;


function ERR_EVP_CIPHER_meth_get_do_cipher(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_do_cipher; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_do_cipher');
end;


function ERR_EVP_CIPHER_meth_get_cleanup(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_cleanup; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_cleanup');
end;


function ERR_EVP_CIPHER_meth_get_set_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_set_asn1_params; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_set_asn1_params');
end;


function ERR_EVP_CIPHER_meth_get_get_asn1_params(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_get_asn1_params; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_get_asn1_params');
end;


function ERR_EVP_CIPHER_meth_get_ctrl(const cipher: PEVP_CIPHER): EVP_CIPHER_meth_ctrl; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_meth_get_ctrl');
end;


function ERR_EVP_MD_type(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_type');
end;


function ERR_EVP_MD_pkey_type(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_pkey_type');
end;


function ERR_EVP_MD_size(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_size');
end;


function ERR_EVP_MD_block_size(const md: PEVP_MD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_block_size');
end;


function ERR_EVP_MD_flags(const md: PEVP_MD): PIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_flags');
end;


function ERR_EVP_MD_CTX_update_fn(ctx: PEVP_MD_CTX): EVP_MD_CTX_update; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_update_fn');
end;


procedure ERR_EVP_MD_CTX_set_update_fn(ctx: PEVP_MD_CTX; update: EVP_MD_CTX_update); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_set_update_fn');
end;


function ERR_EVP_MD_CTX_pkey_ctx(const ctx: PEVP_MD_CTX): PEVP_PKEY_CTX; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_pkey_ctx');
end;


procedure ERR_EVP_MD_CTX_set_pkey_ctx(ctx: PEVP_MD_CTX; pctx: PEVP_PKEY_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_set_pkey_ctx');
end;


function ERR_EVP_MD_CTX_md_data(const ctx: PEVP_MD_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_md_data');
end;


function ERR_EVP_CIPHER_nid(const ctx: PEVP_MD_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_nid');
end;


function ERR_EVP_CIPHER_block_size(const cipher: PEVP_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_block_size');
end;


function ERR_EVP_CIPHER_impl_ctx_size(const cipher: PEVP_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_impl_ctx_size');
end;


function ERR_EVP_CIPHER_key_length(const cipher: PEVP_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_key_length');
end;


function ERR_EVP_CIPHER_iv_length(const cipher: PEVP_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_iv_length');
end;


function ERR_EVP_CIPHER_flags(const cipher: PEVP_CIPHER): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_flags');
end;


function ERR_EVP_CIPHER_CTX_encrypting(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_encrypting');
end;


function ERR_EVP_CIPHER_CTX_nid(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_nid');
end;


function ERR_EVP_CIPHER_CTX_block_size(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_block_size');
end;


function ERR_EVP_CIPHER_CTX_key_length(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_key_length');
end;


function ERR_EVP_CIPHER_CTX_iv_length(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_iv_length');
end;


function ERR_EVP_CIPHER_CTX_iv(const ctx: PEVP_CIPHER_CTX): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_iv');
end;


function ERR_EVP_CIPHER_CTX_original_iv(const ctx: PEVP_CIPHER_CTX): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_original_iv');
end;


function ERR_EVP_CIPHER_CTX_iv_noconst(ctx: PEVP_CIPHER_CTX): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_iv_noconst');
end;


function ERR_EVP_CIPHER_CTX_buf_noconst(ctx: PEVP_CIPHER_CTX): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_buf_noconst');
end;


function ERR_EVP_CIPHER_CTX_num(const ctx: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_num');
end;


procedure ERR_EVP_CIPHER_CTX_set_num(ctx: PEVP_CIPHER_CTX; num: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_set_num');
end;


function ERR_EVP_CIPHER_CTX_get_cipher_data(const ctx: PEVP_CIPHER_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_get_cipher_data');
end;


function ERR_EVP_CIPHER_CTX_set_cipher_data(ctx: PEVP_CIPHER_CTX; cipher_data: Pointer): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_set_cipher_data');
end;


procedure ERR_BIO_set_md(v1: PBIO; const md: PEVP_MD); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_md');
end;


function ERR_EVP_MD_CTX_ctrl(ctx: PEVP_MD_CTX; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_ctrl');
end;


function ERR_EVP_MD_CTX_new: PEVP_MD_CTX; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_new');
end;


function ERR_EVP_MD_CTX_reset(ctx: PEVP_MD_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_reset');
end;


procedure ERR_EVP_MD_CTX_free(ctx: PEVP_MD_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_MD_CTX_free');
end;


function ERR_EVP_DigestFinalXOF(ctx: PEVP_MD_CTX; md: PByte; len: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_DigestFinalXOF');
end;


function ERR_EVP_DigestSign(ctx: PEVP_CIPHER_CTX; sigret: PByte; siglen: PIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_DigestSign');
end;


function ERR_EVP_DigestVerify(ctx: PEVP_CIPHER_CTX; const sigret: PByte; siglen: TIdC_SIZET; const tbs: PByte; tbslen: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_DigestVerify');
end;


function ERR_EVP_ENCODE_CTX_new: PEVP_ENCODE_CTX; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_ENCODE_CTX_new');
end;


procedure ERR_EVP_ENCODE_CTX_free(ctx: PEVP_ENCODE_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_ENCODE_CTX_free');
end;


function ERR_EVP_ENCODE_CTX_copy(dctx: PEVP_ENCODE_CTX; sctx: PEVP_ENCODE_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_ENCODE_CTX_copy');
end;


function ERR_EVP_ENCODE_CTX_num(ctx: PEVP_ENCODE_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_ENCODE_CTX_num');
end;


function ERR_EVP_CIPHER_CTX_reset(c: PEVP_CIPHER_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_CTX_reset');
end;


function ERR_EVP_md5_sha1: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_md5_sha1');
end;


function ERR_EVP_sha512_224: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha512_224');
end;


function ERR_EVP_sha512_256: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha512_256');
end;


function ERR_EVP_sha3_224: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha3_224');
end;


function ERR_EVP_sha3_256: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha3_256');
end;


function ERR_EVP_sha3_384: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha3_384');
end;


function ERR_EVP_sha3_512: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sha3_512');
end;


function ERR_EVP_shake128: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_shake128');
end;


function ERR_EVP_shake256: PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_shake256');
end;


function ERR_EVP_aes_128_wrap_pad: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_128_wrap_pad');
end;


function ERR_EVP_aes_128_ocb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_128_ocb');
end;


function ERR_EVP_aes_192_wrap_pad: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_192_wrap_pad');
end;


function ERR_EVP_aes_192_ocb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_192_ocb');
end;


function ERR_EVP_aes_256_wrap_pad: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_256_wrap_pad');
end;


function ERR_EVP_aes_256_ocb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aes_256_ocb');
end;


function ERR_EVP_aria_128_ecb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_ecb');
end;


function ERR_EVP_aria_128_cbc: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_cbc');
end;


function ERR_EVP_aria_128_cfb1: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_cfb1');
end;


function ERR_EVP_aria_128_cfb8: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_cfb8');
end;


function ERR_EVP_aria_128_cfb128: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_cfb128');
end;


function ERR_EVP_aria_128_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_ctr');
end;


function ERR_EVP_aria_128_ofb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_ofb');
end;


function ERR_EVP_aria_128_gcm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_gcm');
end;


function ERR_EVP_aria_128_ccm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_128_ccm');
end;


function ERR_EVP_aria_192_ecb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_ecb');
end;


function ERR_EVP_aria_192_cbc: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_cbc');
end;


function ERR_EVP_aria_192_cfb1: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_cfb1');
end;


function ERR_EVP_aria_192_cfb8: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_cfb8');
end;


function ERR_EVP_aria_192_cfb128: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_cfb128');
end;


function ERR_EVP_aria_192_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_ctr');
end;


function ERR_EVP_aria_192_ofb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_ofb');
end;


function ERR_EVP_aria_192_gcm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_gcm');
end;


function ERR_EVP_aria_192_ccm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_192_ccm');
end;


function ERR_EVP_aria_256_ecb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_ecb');
end;


function ERR_EVP_aria_256_cbc: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_cbc');
end;


function ERR_EVP_aria_256_cfb1: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_cfb1');
end;


function ERR_EVP_aria_256_cfb8: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_cfb8');
end;


function ERR_EVP_aria_256_cfb128: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_cfb128');
end;


function ERR_EVP_aria_256_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_ctr');
end;


function ERR_EVP_aria_256_ofb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_ofb');
end;


function ERR_EVP_aria_256_gcm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_gcm');
end;


function ERR_EVP_aria_256_ccm: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_aria_256_ccm');
end;


function ERR_EVP_camellia_128_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_camellia_128_ctr');
end;


function ERR_EVP_camellia_192_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_camellia_192_ctr');
end;


function ERR_EVP_camellia_256_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_camellia_256_ctr');
end;


function ERR_EVP_chacha20: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_chacha20');
end;


function ERR_EVP_chacha20_poly1305: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_chacha20_poly1305');
end;


function ERR_EVP_sm4_ecb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sm4_ecb');
end;


function ERR_EVP_sm4_cbc: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sm4_cbc');
end;


function ERR_EVP_sm4_cfb128: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sm4_cfb128');
end;


function ERR_EVP_sm4_ofb: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sm4_ofb');
end;


function ERR_EVP_sm4_ctr: PEVP_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_sm4_ctr');
end;


function ERR_EVP_PKEY_id(const pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_id');
end;


function ERR_EVP_PKEY_base_id(const pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_base_id');
end;


function ERR_EVP_PKEY_bits(const pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_bits');
end;


function ERR_EVP_PKEY_security_bits(const pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_security_bits');
end;


function ERR_EVP_PKEY_size(const pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_size');
end;


function ERR_EVP_PKEY_set_alias_type(pkey: PEVP_PKEY; type_: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_set_alias_type');
end;


function ERR_EVP_PKEY_set1_engine(pkey: PEVP_PKEY; e: PENGINE): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_set1_engine');
end;


function ERR_EVP_PKEY_get0_engine(const pkey: PEVP_PKEY): PENGINE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_engine');
end;


function ERR_EVP_PKEY_get0_hmac(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_hmac');
end;


function ERR_EVP_PKEY_get0_poly1305(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_poly1305');
end;


function ERR_EVP_PKEY_get0_siphash(const pkey: PEVP_PKEY; len: PIdC_SIZET): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_siphash');
end;


function ERR_EVP_PKEY_get0_RSA(pkey: PEVP_PKEY): PRSA; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_RSA');
end;


function ERR_EVP_PKEY_get0_DSA(pkey: PEVP_PKEY): PDSA; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_DSA');
end;


function ERR_EVP_PKEY_get0_DH(pkey: PEVP_PKEY): PDH; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_DH');
end;


function ERR_EVP_PKEY_get0_EC_KEY(pkey: PEVP_PKEY): PEC_KEY; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get0_EC_KEY');
end;


function ERR_EVP_PKEY_up_ref(pkey: PEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_up_ref');
end;


function ERR_EVP_PKEY_set1_tls_encodedpoint(pkey: PEVP_PKEY; const pt: PByte; ptlen: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_set1_tls_encodedpoint');
end;


function ERR_EVP_PKEY_get1_tls_encodedpoint(pkey: PEVP_PKEY; ppt: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get1_tls_encodedpoint');
end;


function ERR_EVP_CIPHER_type(const ctx: PEVP_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_CIPHER_type');
end;


function ERR_EVP_PBE_scrypt(const pass: PIdAnsiChar; passlen: TIdC_SIZET; const salt: PByte; saltlen: TIdC_SIZET; N: TIdC_UINT64; r: TIdC_UINT64; p: TIdC_UINT64; maxmem: TIdC_UINT64; key: PByte; keylen: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PBE_scrypt');
end;


function ERR_PKCS5_v2_scrypt_keyivgen(ctx: PEVP_CIPHER_CTX; const pass: PIdAnsiChar; passlen: TIdC_INT; param: PASN1_TYPE; const c: PEVP_CIPHER; const md: PEVP_MD; en_de: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('PKCS5_v2_scrypt_keyivgen');
end;


function ERR_EVP_PBE_get(ptype: PIdC_INT; ppbe_nid: PIdC_INT; num: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PBE_get');
end;


procedure ERR_EVP_PKEY_asn1_set_siginf(ameth: PEVP_PKEY_ASN1_METHOD; ASiginf_set: siginf_set); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_siginf');
end;


procedure ERR_EVP_PKEY_asn1_set_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_check: pkey_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_check');
end;


procedure ERR_EVP_PKEY_asn1_set_public_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_pub_check: pkey_pub_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_public_check');
end;


procedure ERR_EVP_PKEY_asn1_set_param_check(ameth: PEVP_PKEY_ASN1_METHOD; APkey_param_check: pkey_param_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_param_check');
end;


procedure ERR_EVP_PKEY_asn1_set_set_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_priv_key: set_priv_key); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_set_priv_key');
end;


procedure ERR_EVP_PKEY_asn1_set_set_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; ASet_pub_key: set_pub_key); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_set_pub_key');
end;


procedure ERR_EVP_PKEY_asn1_set_get_priv_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_priv_key: get_priv_key); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_get_priv_key');
end;


procedure ERR_EVP_PKEY_asn1_set_get_pub_key(ameth: PEVP_PKEY_ASN1_METHOD; AGet_pub_key: get_pub_key); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_get_pub_key');
end;


procedure ERR_EVP_PKEY_asn1_set_security_bits(ameth: PEVP_PKEY_ASN1_METHOD; APkey_security_bits: pkey_security_bits); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_asn1_set_security_bits');
end;


function ERR_EVP_PKEY_meth_remove(const pmeth: PEVP_PKEY_METHOD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_remove');
end;


function ERR_EVP_PKEY_meth_get_count: TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_count');
end;


function ERR_EVP_PKEY_meth_get0(idx: TIdC_SIZET): PEVP_PKEY_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get0');
end;


function ERR_EVP_PKEY_CTX_ctrl_uint64(ctx: PEVP_PKEY_CTX; keytype: TIdC_INT; optype: TIdC_INT; cmd: TIdC_INT; value: TIdC_UINT64): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_CTX_ctrl_uint64');
end;


function ERR_EVP_PKEY_CTX_str2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const str: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_CTX_str2ctrl');
end;


function ERR_EVP_PKEY_CTX_hex2ctrl(ctx: PEVP_PKEY_CTX; cmd: TIdC_INT; const hex: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_CTX_hex2ctrl');
end;


function ERR_EVP_PKEY_CTX_md(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; const md: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_CTX_md');
end;


function ERR_EVP_PKEY_new_raw_private_key(type_: TIdC_INT; e: PENGINE; const priv: PByte; len: TIdC_SIZET): PEVP_PKEY; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_new_raw_private_key');
end;


function ERR_EVP_PKEY_new_raw_public_key(type_: TIdC_INT; e: PENGINE; const pub: PByte; len: TIdC_SIZET): PEVP_PKEY; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_new_raw_public_key');
end;


function ERR_EVP_PKEY_get_raw_private_key(const pkey: PEVP_PKEY; priv: PByte; len: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get_raw_private_key');
end;


function ERR_EVP_PKEY_get_raw_public_key(const pkey: PEVP_PKEY; pub: PByte; len: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_get_raw_public_key');
end;


function ERR_EVP_PKEY_new_CMAC_key(e: PENGINE; const priv: PByte; len: TIdC_SIZET; const cipher: PEVP_CIPHER): PEVP_PKEY; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_new_CMAC_key');
end;


function ERR_EVP_PKEY_check(ctx: PEVP_PKEY_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_check');
end;


function ERR_EVP_PKEY_public_check(ctx: PEVP_PKEY_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_public_check');
end;


function ERR_EVP_PKEY_param_check(ctx: PEVP_PKEY_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_param_check');
end;


procedure ERR_EVP_PKEY_meth_set_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: EVP_PKEY_meth_digestsign); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_digestsign');
end;


procedure ERR_EVP_PKEY_meth_set_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: EVP_PKEY_meth_digestverify); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_digestverify');
end;


procedure ERR_EVP_PKEY_meth_set_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: EVP_PKEY_meth_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_check');
end;


procedure ERR_EVP_PKEY_meth_set_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: EVP_PKEY_meth_public_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_public_check');
end;


procedure ERR_EVP_PKEY_meth_set_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: EVP_PKEY_meth_param_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_param_check');
end;


procedure ERR_EVP_PKEY_meth_set_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: EVP_PKEY_meth_digest_custom); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_set_digest_custom');
end;


procedure ERR_EVP_PKEY_meth_get_digestsign(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestsign: PEVP_PKEY_meth_digestsign); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_digestsign');
end;


procedure ERR_EVP_PKEY_meth_get_digestverify(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digestverify: PEVP_PKEY_meth_digestverify); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_digestverify');
end;


procedure ERR_EVP_PKEY_meth_get_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_check: PEVP_PKEY_meth_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_check');
end;


procedure ERR_EVP_PKEY_meth_get_public_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_public_check: PEVP_PKEY_meth_public_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_public_check');
end;


procedure ERR_EVP_PKEY_meth_get_param_check(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_param_check: PEVP_PKEY_meth_param_check); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_param_check');
end;


procedure ERR_EVP_PKEY_meth_get_digest_custom(pmeth: PEVP_PKEY_METHOD; AEVP_PKEY_meth_digest_custom: PEVP_PKEY_meth_digest_custom); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_PKEY_meth_get_digest_custom');
end;


procedure ERR_OpenSSL_add_all_ciphers; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OpenSSL_add_all_ciphers');
end;


procedure ERR_OpenSSL_add_all_digests; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OpenSSL_add_all_digests');
end;


procedure ERR_EVP_cleanup; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EVP_cleanup');
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
  EVP_MD_CTX_md := LoadFunction('EVP_MD_CTX_md',AFailed);
  EVP_CIPHER_CTX_cipher := LoadFunction('EVP_CIPHER_CTX_cipher',AFailed);
  EVP_CIPHER_CTX_copy := LoadFunction('EVP_CIPHER_CTX_copy',AFailed);
  EVP_CIPHER_CTX_get_app_data := LoadFunction('EVP_CIPHER_CTX_get_app_data',AFailed);
  EVP_CIPHER_CTX_set_app_data := LoadFunction('EVP_CIPHER_CTX_set_app_data',AFailed);
  EVP_MD_CTX_copy_ex := LoadFunction('EVP_MD_CTX_copy_ex',AFailed);
  EVP_MD_CTX_set_flags := LoadFunction('EVP_MD_CTX_set_flags',AFailed);
  EVP_MD_CTX_clear_flags := LoadFunction('EVP_MD_CTX_clear_flags',AFailed);
  EVP_MD_CTX_test_flags := LoadFunction('EVP_MD_CTX_test_flags',AFailed);
  EVP_DigestInit_ex := LoadFunction('EVP_DigestInit_ex',AFailed);
  EVP_DigestUpdate := LoadFunction('EVP_DigestUpdate',AFailed);
  EVP_DigestFinal_ex := LoadFunction('EVP_DigestFinal_ex',AFailed);
  EVP_Digest := LoadFunction('EVP_Digest',AFailed);
  EVP_MD_CTX_copy := LoadFunction('EVP_MD_CTX_copy',AFailed);
  EVP_DigestInit := LoadFunction('EVP_DigestInit',AFailed);
  EVP_DigestFinal := LoadFunction('EVP_DigestFinal',AFailed);
  EVP_read_pw_string := LoadFunction('EVP_read_pw_string',AFailed);
  EVP_read_pw_string_min := LoadFunction('EVP_read_pw_string_min',AFailed);
  EVP_set_pw_prompt := LoadFunction('EVP_set_pw_prompt',AFailed);
  EVP_get_pw_prompt := LoadFunction('EVP_get_pw_prompt',AFailed);
  EVP_BytesToKey := LoadFunction('EVP_BytesToKey',AFailed);
  EVP_CIPHER_CTX_set_flags := LoadFunction('EVP_CIPHER_CTX_set_flags',AFailed);
  EVP_CIPHER_CTX_clear_flags := LoadFunction('EVP_CIPHER_CTX_clear_flags',AFailed);
  EVP_CIPHER_CTX_test_flags := LoadFunction('EVP_CIPHER_CTX_test_flags',AFailed);
  EVP_EncryptInit := LoadFunction('EVP_EncryptInit',AFailed);
  EVP_EncryptInit_ex := LoadFunction('EVP_EncryptInit_ex',AFailed);
  EVP_EncryptUpdate := LoadFunction('EVP_EncryptUpdate',AFailed);
  EVP_EncryptFinal_ex := LoadFunction('EVP_EncryptFinal_ex',AFailed);
  EVP_EncryptFinal := LoadFunction('EVP_EncryptFinal',AFailed);
  EVP_DecryptInit := LoadFunction('EVP_DecryptInit',AFailed);
  EVP_DecryptInit_ex := LoadFunction('EVP_DecryptInit_ex',AFailed);
  EVP_DecryptUpdate := LoadFunction('EVP_DecryptUpdate',AFailed);
  EVP_DecryptFinal := LoadFunction('EVP_DecryptFinal',AFailed);
  EVP_DecryptFinal_ex := LoadFunction('EVP_DecryptFinal_ex',AFailed);
  EVP_CipherInit := LoadFunction('EVP_CipherInit',AFailed);
  EVP_CipherInit_ex := LoadFunction('EVP_CipherInit_ex',AFailed);
  EVP_CipherUpdate := LoadFunction('EVP_CipherUpdate',AFailed);
  EVP_CipherFinal := LoadFunction('EVP_CipherFinal',AFailed);
  EVP_CipherFinal_ex := LoadFunction('EVP_CipherFinal_ex',AFailed);
  EVP_SignFinal := LoadFunction('EVP_SignFinal',AFailed);
  EVP_VerifyFinal := LoadFunction('EVP_VerifyFinal',AFailed);
  EVP_DigestSignInit := LoadFunction('EVP_DigestSignInit',AFailed);
  EVP_DigestSignFinal := LoadFunction('EVP_DigestSignFinal',AFailed);
  EVP_DigestVerifyInit := LoadFunction('EVP_DigestVerifyInit',AFailed);
  EVP_DigestVerifyFinal := LoadFunction('EVP_DigestVerifyFinal',AFailed);
  EVP_OpenInit := LoadFunction('EVP_OpenInit',AFailed);
  EVP_OpenFinal := LoadFunction('EVP_OpenFinal',AFailed);
  EVP_SealInit := LoadFunction('EVP_SealInit',AFailed);
  EVP_SealFinal := LoadFunction('EVP_SealFinal',AFailed);
  EVP_EncodeInit := LoadFunction('EVP_EncodeInit',AFailed);
  EVP_EncodeUpdate := LoadFunction('EVP_EncodeUpdate',AFailed);
  EVP_EncodeFinal := LoadFunction('EVP_EncodeFinal',AFailed);
  EVP_EncodeBlock := LoadFunction('EVP_EncodeBlock',AFailed);
  EVP_DecodeInit := LoadFunction('EVP_DecodeInit',AFailed);
  EVP_DecodeUpdate := LoadFunction('EVP_DecodeUpdate',AFailed);
  EVP_DecodeFinal := LoadFunction('EVP_DecodeFinal',AFailed);
  EVP_DecodeBlock := LoadFunction('EVP_DecodeBlock',AFailed);
  EVP_CIPHER_CTX_new := LoadFunction('EVP_CIPHER_CTX_new',AFailed);
  EVP_CIPHER_CTX_free := LoadFunction('EVP_CIPHER_CTX_free',AFailed);
  EVP_CIPHER_CTX_set_key_length := LoadFunction('EVP_CIPHER_CTX_set_key_length',AFailed);
  EVP_CIPHER_CTX_set_padding := LoadFunction('EVP_CIPHER_CTX_set_padding',AFailed);
  EVP_CIPHER_CTX_ctrl := LoadFunction('EVP_CIPHER_CTX_ctrl',AFailed);
  EVP_CIPHER_CTX_rand_key := LoadFunction('EVP_CIPHER_CTX_rand_key',AFailed);
  BIO_f_md := LoadFunction('BIO_f_md',AFailed);
  BIO_f_base64 := LoadFunction('BIO_f_base64',AFailed);
  BIO_f_cipher := LoadFunction('BIO_f_cipher',AFailed);
  BIO_f_reliable := LoadFunction('BIO_f_reliable',AFailed);
  BIO_set_cipher := LoadFunction('BIO_set_cipher',AFailed);
  EVP_md_null := LoadFunction('EVP_md_null',AFailed);
  EVP_md5 := LoadFunction('EVP_md5',AFailed);
  EVP_sha1 := LoadFunction('EVP_sha1',AFailed);
  EVP_sha224 := LoadFunction('EVP_sha224',AFailed);
  EVP_sha256 := LoadFunction('EVP_sha256',AFailed);
  EVP_sha384 := LoadFunction('EVP_sha384',AFailed);
  EVP_sha512 := LoadFunction('EVP_sha512',AFailed);
  EVP_enc_null := LoadFunction('EVP_enc_null',AFailed);
  EVP_des_ecb := LoadFunction('EVP_des_ecb',AFailed);
  EVP_des_ede := LoadFunction('EVP_des_ede',AFailed);
  EVP_des_ede3 := LoadFunction('EVP_des_ede3',AFailed);
  EVP_des_ede_ecb := LoadFunction('EVP_des_ede_ecb',AFailed);
  EVP_des_ede3_ecb := LoadFunction('EVP_des_ede3_ecb',AFailed);
  EVP_des_cfb64 := LoadFunction('EVP_des_cfb64',AFailed);
  EVP_des_cfb1 := LoadFunction('EVP_des_cfb1',AFailed);
  EVP_des_cfb8 := LoadFunction('EVP_des_cfb8',AFailed);
  EVP_des_ede_cfb64 := LoadFunction('EVP_des_ede_cfb64',AFailed);
  EVP_des_ede3_cfb64 := LoadFunction('EVP_des_ede3_cfb64',AFailed);
  EVP_des_ede3_cfb1 := LoadFunction('EVP_des_ede3_cfb1',AFailed);
  EVP_des_ede3_cfb8 := LoadFunction('EVP_des_ede3_cfb8',AFailed);
  EVP_des_ofb := LoadFunction('EVP_des_ofb',AFailed);
  EVP_des_ede_ofb := LoadFunction('EVP_des_ede_ofb',AFailed);
  EVP_des_ede3_ofb := LoadFunction('EVP_des_ede3_ofb',AFailed);
  EVP_des_cbc := LoadFunction('EVP_des_cbc',AFailed);
  EVP_des_ede_cbc := LoadFunction('EVP_des_ede_cbc',AFailed);
  EVP_des_ede3_cbc := LoadFunction('EVP_des_ede3_cbc',AFailed);
  EVP_desx_cbc := LoadFunction('EVP_desx_cbc',AFailed);
  EVP_des_ede3_wrap := LoadFunction('EVP_des_ede3_wrap',AFailed);
  EVP_rc4 := LoadFunction('EVP_rc4',AFailed);
  EVP_rc4_40 := LoadFunction('EVP_rc4_40',AFailed);
  EVP_rc2_ecb := LoadFunction('EVP_rc2_ecb',AFailed);
  EVP_rc2_cbc := LoadFunction('EVP_rc2_cbc',AFailed);
  EVP_rc2_40_cbc := LoadFunction('EVP_rc2_40_cbc',AFailed);
  EVP_rc2_64_cbc := LoadFunction('EVP_rc2_64_cbc',AFailed);
  EVP_rc2_cfb64 := LoadFunction('EVP_rc2_cfb64',AFailed);
  EVP_rc2_ofb := LoadFunction('EVP_rc2_ofb',AFailed);
  EVP_bf_ecb := LoadFunction('EVP_bf_ecb',AFailed);
  EVP_bf_cbc := LoadFunction('EVP_bf_cbc',AFailed);
  EVP_bf_cfb64 := LoadFunction('EVP_bf_cfb64',AFailed);
  EVP_bf_ofb := LoadFunction('EVP_bf_ofb',AFailed);
  EVP_cast5_ecb := LoadFunction('EVP_cast5_ecb',AFailed);
  EVP_cast5_cbc := LoadFunction('EVP_cast5_cbc',AFailed);
  EVP_cast5_cfb64 := LoadFunction('EVP_cast5_cfb64',AFailed);
  EVP_cast5_ofb := LoadFunction('EVP_cast5_ofb',AFailed);
  EVP_aes_128_ecb := LoadFunction('EVP_aes_128_ecb',AFailed);
  EVP_aes_128_cbc := LoadFunction('EVP_aes_128_cbc',AFailed);
  EVP_aes_128_cfb1 := LoadFunction('EVP_aes_128_cfb1',AFailed);
  EVP_aes_128_cfb8 := LoadFunction('EVP_aes_128_cfb8',AFailed);
  EVP_aes_128_cfb128 := LoadFunction('EVP_aes_128_cfb128',AFailed);
  EVP_aes_128_ofb := LoadFunction('EVP_aes_128_ofb',AFailed);
  EVP_aes_128_ctr := LoadFunction('EVP_aes_128_ctr',AFailed);
  EVP_aes_128_ccm := LoadFunction('EVP_aes_128_ccm',AFailed);
  EVP_aes_128_gcm := LoadFunction('EVP_aes_128_gcm',AFailed);
  EVP_aes_128_xts := LoadFunction('EVP_aes_128_xts',AFailed);
  EVP_aes_128_wrap := LoadFunction('EVP_aes_128_wrap',AFailed);
  EVP_aes_192_ecb := LoadFunction('EVP_aes_192_ecb',AFailed);
  EVP_aes_192_cbc := LoadFunction('EVP_aes_192_cbc',AFailed);
  EVP_aes_192_cfb1 := LoadFunction('EVP_aes_192_cfb1',AFailed);
  EVP_aes_192_cfb8 := LoadFunction('EVP_aes_192_cfb8',AFailed);
  EVP_aes_192_cfb128 := LoadFunction('EVP_aes_192_cfb128',AFailed);
  EVP_aes_192_ofb := LoadFunction('EVP_aes_192_ofb',AFailed);
  EVP_aes_192_ctr := LoadFunction('EVP_aes_192_ctr',AFailed);
  EVP_aes_192_ccm := LoadFunction('EVP_aes_192_ccm',AFailed);
  EVP_aes_192_gcm := LoadFunction('EVP_aes_192_gcm',AFailed);
  EVP_aes_192_wrap := LoadFunction('EVP_aes_192_wrap',AFailed);
  EVP_aes_256_ecb := LoadFunction('EVP_aes_256_ecb',AFailed);
  EVP_aes_256_cbc := LoadFunction('EVP_aes_256_cbc',AFailed);
  EVP_aes_256_cfb1 := LoadFunction('EVP_aes_256_cfb1',AFailed);
  EVP_aes_256_cfb8 := LoadFunction('EVP_aes_256_cfb8',AFailed);
  EVP_aes_256_cfb128 := LoadFunction('EVP_aes_256_cfb128',AFailed);
  EVP_aes_256_ofb := LoadFunction('EVP_aes_256_ofb',AFailed);
  EVP_aes_256_ctr := LoadFunction('EVP_aes_256_ctr',AFailed);
  EVP_aes_256_ccm := LoadFunction('EVP_aes_256_ccm',AFailed);
  EVP_aes_256_gcm := LoadFunction('EVP_aes_256_gcm',AFailed);
  EVP_aes_256_xts := LoadFunction('EVP_aes_256_xts',AFailed);
  EVP_aes_256_wrap := LoadFunction('EVP_aes_256_wrap',AFailed);
  EVP_aes_128_cbc_hmac_sha1 := LoadFunction('EVP_aes_128_cbc_hmac_sha1',AFailed);
  EVP_aes_256_cbc_hmac_sha1 := LoadFunction('EVP_aes_256_cbc_hmac_sha1',AFailed);
  EVP_aes_128_cbc_hmac_sha256 := LoadFunction('EVP_aes_128_cbc_hmac_sha256',AFailed);
  EVP_aes_256_cbc_hmac_sha256 := LoadFunction('EVP_aes_256_cbc_hmac_sha256',AFailed);
  EVP_camellia_128_ecb := LoadFunction('EVP_camellia_128_ecb',AFailed);
  EVP_camellia_128_cbc := LoadFunction('EVP_camellia_128_cbc',AFailed);
  EVP_camellia_128_cfb1 := LoadFunction('EVP_camellia_128_cfb1',AFailed);
  EVP_camellia_128_cfb8 := LoadFunction('EVP_camellia_128_cfb8',AFailed);
  EVP_camellia_128_cfb128 := LoadFunction('EVP_camellia_128_cfb128',AFailed);
  EVP_camellia_128_ofb := LoadFunction('EVP_camellia_128_ofb',AFailed);
  EVP_camellia_192_ecb := LoadFunction('EVP_camellia_192_ecb',AFailed);
  EVP_camellia_192_cbc := LoadFunction('EVP_camellia_192_cbc',AFailed);
  EVP_camellia_192_cfb1 := LoadFunction('EVP_camellia_192_cfb1',AFailed);
  EVP_camellia_192_cfb8 := LoadFunction('EVP_camellia_192_cfb8',AFailed);
  EVP_camellia_192_cfb128 := LoadFunction('EVP_camellia_192_cfb128',AFailed);
  EVP_camellia_192_ofb := LoadFunction('EVP_camellia_192_ofb',AFailed);
  EVP_camellia_256_ecb := LoadFunction('EVP_camellia_256_ecb',AFailed);
  EVP_camellia_256_cbc := LoadFunction('EVP_camellia_256_cbc',AFailed);
  EVP_camellia_256_cfb1 := LoadFunction('EVP_camellia_256_cfb1',AFailed);
  EVP_camellia_256_cfb8 := LoadFunction('EVP_camellia_256_cfb8',AFailed);
  EVP_camellia_256_cfb128 := LoadFunction('EVP_camellia_256_cfb128',AFailed);
  EVP_camellia_256_ofb := LoadFunction('EVP_camellia_256_ofb',AFailed);
  EVP_seed_ecb := LoadFunction('EVP_seed_ecb',AFailed);
  EVP_seed_cbc := LoadFunction('EVP_seed_cbc',AFailed);
  EVP_seed_cfb128 := LoadFunction('EVP_seed_cfb128',AFailed);
  EVP_seed_ofb := LoadFunction('EVP_seed_ofb',AFailed);
  EVP_add_cipher := LoadFunction('EVP_add_cipher',AFailed);
  EVP_add_digest := LoadFunction('EVP_add_digest',AFailed);
  EVP_get_cipherbyname := LoadFunction('EVP_get_cipherbyname',AFailed);
  EVP_get_digestbyname := LoadFunction('EVP_get_digestbyname',AFailed);
  EVP_CIPHER_do_all := LoadFunction('EVP_CIPHER_do_all',AFailed);
  EVP_CIPHER_do_all_sorted := LoadFunction('EVP_CIPHER_do_all_sorted',AFailed);
  EVP_MD_do_all := LoadFunction('EVP_MD_do_all',AFailed);
  EVP_MD_do_all_sorted := LoadFunction('EVP_MD_do_all_sorted',AFailed);
  EVP_PKEY_decrypt_old := LoadFunction('EVP_PKEY_decrypt_old',AFailed);
  EVP_PKEY_encrypt_old := LoadFunction('EVP_PKEY_encrypt_old',AFailed);
  EVP_PKEY_type := LoadFunction('EVP_PKEY_type',AFailed);
  EVP_PKEY_set_type := LoadFunction('EVP_PKEY_set_type',AFailed);
  EVP_PKEY_set_type_str := LoadFunction('EVP_PKEY_set_type_str',AFailed);
  EVP_PKEY_assign := LoadFunction('EVP_PKEY_assign',AFailed);
  EVP_PKEY_get0 := LoadFunction('EVP_PKEY_get0',AFailed);
  EVP_PKEY_set1_RSA := LoadFunction('EVP_PKEY_set1_RSA',AFailed);
  EVP_PKEY_get1_RSA := LoadFunction('EVP_PKEY_get1_RSA',AFailed);
  EVP_PKEY_set1_DSA := LoadFunction('EVP_PKEY_set1_DSA',AFailed);
  EVP_PKEY_get1_DSA := LoadFunction('EVP_PKEY_get1_DSA',AFailed);
  EVP_PKEY_set1_DH := LoadFunction('EVP_PKEY_set1_DH',AFailed);
  EVP_PKEY_get1_DH := LoadFunction('EVP_PKEY_get1_DH',AFailed);
  EVP_PKEY_set1_EC_KEY := LoadFunction('EVP_PKEY_set1_EC_KEY',AFailed);
  EVP_PKEY_get1_EC_KEY := LoadFunction('EVP_PKEY_get1_EC_KEY',AFailed);
  EVP_PKEY_new := LoadFunction('EVP_PKEY_new',AFailed);
  EVP_PKEY_free := LoadFunction('EVP_PKEY_free',AFailed);
  d2i_PublicKey := LoadFunction('d2i_PublicKey',AFailed);
  i2d_PublicKey := LoadFunction('i2d_PublicKey',AFailed);
  d2i_PrivateKey := LoadFunction('d2i_PrivateKey',AFailed);
  d2i_AutoPrivateKey := LoadFunction('d2i_AutoPrivateKey',AFailed);
  i2d_PrivateKey := LoadFunction('i2d_PrivateKey',AFailed);
  EVP_PKEY_copy_parameters := LoadFunction('EVP_PKEY_copy_parameters',AFailed);
  EVP_PKEY_missing_parameters := LoadFunction('EVP_PKEY_missing_parameters',AFailed);
  EVP_PKEY_save_parameters := LoadFunction('EVP_PKEY_save_parameters',AFailed);
  EVP_PKEY_cmp_parameters := LoadFunction('EVP_PKEY_cmp_parameters',AFailed);
  EVP_PKEY_cmp := LoadFunction('EVP_PKEY_cmp',AFailed);
  EVP_PKEY_print_public := LoadFunction('EVP_PKEY_print_public',AFailed);
  EVP_PKEY_print_private := LoadFunction('EVP_PKEY_print_private',AFailed);
  EVP_PKEY_print_params := LoadFunction('EVP_PKEY_print_params',AFailed);
  EVP_PKEY_get_default_digest_nid := LoadFunction('EVP_PKEY_get_default_digest_nid',AFailed);
  EVP_CIPHER_param_to_asn1 := LoadFunction('EVP_CIPHER_param_to_asn1',AFailed);
  EVP_CIPHER_asn1_to_param := LoadFunction('EVP_CIPHER_asn1_to_param',AFailed);
  EVP_CIPHER_set_asn1_iv := LoadFunction('EVP_CIPHER_set_asn1_iv',AFailed);
  EVP_CIPHER_get_asn1_iv := LoadFunction('EVP_CIPHER_get_asn1_iv',AFailed);
  PKCS5_PBE_keyivgen := LoadFunction('PKCS5_PBE_keyivgen',AFailed);
  PKCS5_PBKDF2_HMAC_SHA1 := LoadFunction('PKCS5_PBKDF2_HMAC_SHA1',AFailed);
  PKCS5_PBKDF2_HMAC := LoadFunction('PKCS5_PBKDF2_HMAC',AFailed);
  PKCS5_v2_PBE_keyivgen := LoadFunction('PKCS5_v2_PBE_keyivgen',AFailed);
  PKCS5_PBE_add := LoadFunction('PKCS5_PBE_add',AFailed);
  EVP_PBE_CipherInit := LoadFunction('EVP_PBE_CipherInit',AFailed);
  EVP_PBE_alg_add_type := LoadFunction('EVP_PBE_alg_add_type',AFailed);
  EVP_PBE_alg_add := LoadFunction('EVP_PBE_alg_add',AFailed);
  EVP_PBE_find := LoadFunction('EVP_PBE_find',AFailed);
  EVP_PBE_cleanup := LoadFunction('EVP_PBE_cleanup',AFailed);
  EVP_PKEY_asn1_get_count := LoadFunction('EVP_PKEY_asn1_get_count',AFailed);
  EVP_PKEY_asn1_get0 := LoadFunction('EVP_PKEY_asn1_get0',AFailed);
  EVP_PKEY_asn1_find := LoadFunction('EVP_PKEY_asn1_find',AFailed);
  EVP_PKEY_asn1_find_str := LoadFunction('EVP_PKEY_asn1_find_str',AFailed);
  EVP_PKEY_asn1_add0 := LoadFunction('EVP_PKEY_asn1_add0',AFailed);
  EVP_PKEY_asn1_add_alias := LoadFunction('EVP_PKEY_asn1_add_alias',AFailed);
  EVP_PKEY_asn1_get0_info := LoadFunction('EVP_PKEY_asn1_get0_info',AFailed);
  EVP_PKEY_get0_asn1 := LoadFunction('EVP_PKEY_get0_asn1',AFailed);
  EVP_PKEY_asn1_new := LoadFunction('EVP_PKEY_asn1_new',AFailed);
  EVP_PKEY_asn1_copy := LoadFunction('EVP_PKEY_asn1_copy',AFailed);
  EVP_PKEY_asn1_free := LoadFunction('EVP_PKEY_asn1_free',AFailed);
  EVP_PKEY_asn1_set_public := LoadFunction('EVP_PKEY_asn1_set_public',AFailed);
  EVP_PKEY_asn1_set_private := LoadFunction('EVP_PKEY_asn1_set_private',AFailed);
  EVP_PKEY_asn1_set_param := LoadFunction('EVP_PKEY_asn1_set_param',AFailed);
  EVP_PKEY_asn1_set_free := LoadFunction('EVP_PKEY_asn1_set_free',AFailed);
  EVP_PKEY_asn1_set_ctrl := LoadFunction('EVP_PKEY_asn1_set_ctrl',AFailed);
  EVP_PKEY_asn1_set_item := LoadFunction('EVP_PKEY_asn1_set_item',AFailed);
  EVP_PKEY_meth_find := LoadFunction('EVP_PKEY_meth_find',AFailed);
  EVP_PKEY_meth_new := LoadFunction('EVP_PKEY_meth_new',AFailed);
  EVP_PKEY_meth_get0_info := LoadFunction('EVP_PKEY_meth_get0_info',AFailed);
  EVP_PKEY_meth_copy := LoadFunction('EVP_PKEY_meth_copy',AFailed);
  EVP_PKEY_meth_free := LoadFunction('EVP_PKEY_meth_free',AFailed);
  EVP_PKEY_meth_add0 := LoadFunction('EVP_PKEY_meth_add0',AFailed);
  EVP_PKEY_CTX_new := LoadFunction('EVP_PKEY_CTX_new',AFailed);
  EVP_PKEY_CTX_new_id := LoadFunction('EVP_PKEY_CTX_new_id',AFailed);
  EVP_PKEY_CTX_dup := LoadFunction('EVP_PKEY_CTX_dup',AFailed);
  EVP_PKEY_CTX_free := LoadFunction('EVP_PKEY_CTX_free',AFailed);
  EVP_PKEY_CTX_ctrl := LoadFunction('EVP_PKEY_CTX_ctrl',AFailed);
  EVP_PKEY_CTX_ctrl_str := LoadFunction('EVP_PKEY_CTX_ctrl_str',AFailed);
  EVP_PKEY_CTX_get_operation := LoadFunction('EVP_PKEY_CTX_get_operation',AFailed);
  EVP_PKEY_CTX_set0_keygen_info := LoadFunction('EVP_PKEY_CTX_set0_keygen_info',AFailed);
  EVP_PKEY_new_mac_key := LoadFunction('EVP_PKEY_new_mac_key',AFailed);
  EVP_PKEY_CTX_set_data := LoadFunction('EVP_PKEY_CTX_set_data',AFailed);
  EVP_PKEY_CTX_get_data := LoadFunction('EVP_PKEY_CTX_get_data',AFailed);
  EVP_PKEY_CTX_get0_pkey := LoadFunction('EVP_PKEY_CTX_get0_pkey',AFailed);
  EVP_PKEY_CTX_get0_peerkey := LoadFunction('EVP_PKEY_CTX_get0_peerkey',AFailed);
  EVP_PKEY_CTX_set_app_data := LoadFunction('EVP_PKEY_CTX_set_app_data',AFailed);
  EVP_PKEY_CTX_get_app_data := LoadFunction('EVP_PKEY_CTX_get_app_data',AFailed);
  EVP_PKEY_sign_init := LoadFunction('EVP_PKEY_sign_init',AFailed);
  EVP_PKEY_sign := LoadFunction('EVP_PKEY_sign',AFailed);
  EVP_PKEY_verify_init := LoadFunction('EVP_PKEY_verify_init',AFailed);
  EVP_PKEY_verify := LoadFunction('EVP_PKEY_verify',AFailed);
  EVP_PKEY_verify_recover_init := LoadFunction('EVP_PKEY_verify_recover_init',AFailed);
  EVP_PKEY_verify_recover := LoadFunction('EVP_PKEY_verify_recover',AFailed);
  EVP_PKEY_encrypt_init := LoadFunction('EVP_PKEY_encrypt_init',AFailed);
  EVP_PKEY_encrypt := LoadFunction('EVP_PKEY_encrypt',AFailed);
  EVP_PKEY_decrypt_init := LoadFunction('EVP_PKEY_decrypt_init',AFailed);
  EVP_PKEY_decrypt := LoadFunction('EVP_PKEY_decrypt',AFailed);
  EVP_PKEY_derive_init := LoadFunction('EVP_PKEY_derive_init',AFailed);
  EVP_PKEY_derive_set_peer := LoadFunction('EVP_PKEY_derive_set_peer',AFailed);
  EVP_PKEY_derive := LoadFunction('EVP_PKEY_derive',AFailed);
  EVP_PKEY_paramgen_init := LoadFunction('EVP_PKEY_paramgen_init',AFailed);
  EVP_PKEY_paramgen := LoadFunction('EVP_PKEY_paramgen',AFailed);
  EVP_PKEY_keygen_init := LoadFunction('EVP_PKEY_keygen_init',AFailed);
  EVP_PKEY_keygen := LoadFunction('EVP_PKEY_keygen',AFailed);
  EVP_PKEY_CTX_set_cb := LoadFunction('EVP_PKEY_CTX_set_cb',AFailed);
  EVP_PKEY_CTX_get_cb := LoadFunction('EVP_PKEY_CTX_get_cb',AFailed);
  EVP_PKEY_CTX_get_keygen_info := LoadFunction('EVP_PKEY_CTX_get_keygen_info',AFailed);
  EVP_PKEY_meth_set_init := LoadFunction('EVP_PKEY_meth_set_init',AFailed);
  EVP_PKEY_meth_set_copy := LoadFunction('EVP_PKEY_meth_set_copy',AFailed);
  EVP_PKEY_meth_set_cleanup := LoadFunction('EVP_PKEY_meth_set_cleanup',AFailed);
  EVP_PKEY_meth_set_paramgen := LoadFunction('EVP_PKEY_meth_set_paramgen',AFailed);
  EVP_PKEY_meth_set_keygen := LoadFunction('EVP_PKEY_meth_set_keygen',AFailed);
  EVP_PKEY_meth_set_sign := LoadFunction('EVP_PKEY_meth_set_sign',AFailed);
  EVP_PKEY_meth_set_verify := LoadFunction('EVP_PKEY_meth_set_verify',AFailed);
  EVP_PKEY_meth_set_verify_recover := LoadFunction('EVP_PKEY_meth_set_verify_recover',AFailed);
  EVP_PKEY_meth_set_signctx := LoadFunction('EVP_PKEY_meth_set_signctx',AFailed);
  EVP_PKEY_meth_set_verifyctx := LoadFunction('EVP_PKEY_meth_set_verifyctx',AFailed);
  EVP_PKEY_meth_set_encrypt := LoadFunction('EVP_PKEY_meth_set_encrypt',AFailed);
  EVP_PKEY_meth_set_decrypt := LoadFunction('EVP_PKEY_meth_set_decrypt',AFailed);
  EVP_PKEY_meth_set_derive := LoadFunction('EVP_PKEY_meth_set_derive',AFailed);
  EVP_PKEY_meth_set_ctrl := LoadFunction('EVP_PKEY_meth_set_ctrl',AFailed);
  EVP_PKEY_meth_get_init := LoadFunction('EVP_PKEY_meth_get_init',AFailed);
  EVP_PKEY_meth_get_copy := LoadFunction('EVP_PKEY_meth_get_copy',AFailed);
  EVP_PKEY_meth_get_cleanup := LoadFunction('EVP_PKEY_meth_get_cleanup',AFailed);
  EVP_PKEY_meth_get_paramgen := LoadFunction('EVP_PKEY_meth_get_paramgen',AFailed);
  EVP_PKEY_meth_get_keygen := LoadFunction('EVP_PKEY_meth_get_keygen',AFailed);
  EVP_PKEY_meth_get_sign := LoadFunction('EVP_PKEY_meth_get_sign',AFailed);
  EVP_PKEY_meth_get_verify := LoadFunction('EVP_PKEY_meth_get_verify',AFailed);
  EVP_PKEY_meth_get_verify_recover := LoadFunction('EVP_PKEY_meth_get_verify_recover',AFailed);
  EVP_PKEY_meth_get_signctx := LoadFunction('EVP_PKEY_meth_get_signctx',AFailed);
  EVP_PKEY_meth_get_verifyctx := LoadFunction('EVP_PKEY_meth_get_verifyctx',AFailed);
  EVP_PKEY_meth_get_encrypt := LoadFunction('EVP_PKEY_meth_get_encrypt',AFailed);
  EVP_PKEY_meth_get_decrypt := LoadFunction('EVP_PKEY_meth_get_decrypt',AFailed);
  EVP_PKEY_meth_get_derive := LoadFunction('EVP_PKEY_meth_get_derive',AFailed);
  EVP_PKEY_meth_get_ctrl := LoadFunction('EVP_PKEY_meth_get_ctrl',AFailed);
  EVP_add_alg_module := LoadFunction('EVP_add_alg_module',AFailed);
  EVP_PKEY_assign_RSA := LoadFunction('EVP_PKEY_assign_RSA',nil); {removed 1.0.0}
  EVP_PKEY_assign_DSA := LoadFunction('EVP_PKEY_assign_DSA',nil); {removed 1.0.0}
  EVP_PKEY_assign_DH := LoadFunction('EVP_PKEY_assign_DH',nil); {removed 1.0.0}
  EVP_PKEY_assign_EC_KEY := LoadFunction('EVP_PKEY_assign_EC_KEY',nil); {removed 1.0.0}
  EVP_PKEY_assign_SIPHASH := LoadFunction('EVP_PKEY_assign_SIPHASH',nil); {removed 1.0.0}
  EVP_PKEY_assign_POLY1305 := LoadFunction('EVP_PKEY_assign_POLY1305',nil); {removed 1.0.0}
  EVP_MD_meth_new := LoadFunction('EVP_MD_meth_new',nil); {introduced 1.1.0}
  EVP_MD_meth_dup := LoadFunction('EVP_MD_meth_dup',nil); {introduced 1.1.0}
  EVP_MD_meth_free := LoadFunction('EVP_MD_meth_free',nil); {introduced 1.1.0}
  EVP_MD_meth_set_input_blocksize := LoadFunction('EVP_MD_meth_set_input_blocksize',nil); {introduced 1.1.0}
  EVP_MD_meth_set_result_size := LoadFunction('EVP_MD_meth_set_result_size',nil); {introduced 1.1.0}
  EVP_MD_meth_set_app_datasize := LoadFunction('EVP_MD_meth_set_app_datasize',nil); {introduced 1.1.0}
  EVP_MD_meth_set_flags := LoadFunction('EVP_MD_meth_set_flags',nil); {introduced 1.1.0}
  EVP_MD_meth_set_init := LoadFunction('EVP_MD_meth_set_init',nil); {introduced 1.1.0}
  EVP_MD_meth_set_update := LoadFunction('EVP_MD_meth_set_update',nil); {introduced 1.1.0}
  EVP_MD_meth_set_final := LoadFunction('EVP_MD_meth_set_final',nil); {introduced 1.1.0}
  EVP_MD_meth_set_copy := LoadFunction('EVP_MD_meth_set_copy',nil); {introduced 1.1.0}
  EVP_MD_meth_set_cleanup := LoadFunction('EVP_MD_meth_set_cleanup',nil); {introduced 1.1.0}
  EVP_MD_meth_set_ctrl := LoadFunction('EVP_MD_meth_set_ctrl',nil); {introduced 1.1.0}
  EVP_MD_meth_get_input_blocksize := LoadFunction('EVP_MD_meth_get_input_blocksize',nil); {introduced 1.1.0}
  EVP_MD_meth_get_result_size := LoadFunction('EVP_MD_meth_get_result_size',nil); {introduced 1.1.0}
  EVP_MD_meth_get_app_datasize := LoadFunction('EVP_MD_meth_get_app_datasize',nil); {introduced 1.1.0}
  EVP_MD_meth_get_flags := LoadFunction('EVP_MD_meth_get_flags',nil); {introduced 1.1.0}
  EVP_MD_meth_get_init := LoadFunction('EVP_MD_meth_get_init',nil); {introduced 1.1.0}
  EVP_MD_meth_get_update := LoadFunction('EVP_MD_meth_get_update',nil); {introduced 1.1.0}
  EVP_MD_meth_get_final := LoadFunction('EVP_MD_meth_get_final',nil); {introduced 1.1.0}
  EVP_MD_meth_get_copy := LoadFunction('EVP_MD_meth_get_copy',nil); {introduced 1.1.0}
  EVP_MD_meth_get_cleanup := LoadFunction('EVP_MD_meth_get_cleanup',nil); {introduced 1.1.0}
  EVP_MD_meth_get_ctrl := LoadFunction('EVP_MD_meth_get_ctrl',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_new := LoadFunction('EVP_CIPHER_meth_new',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_dup := LoadFunction('EVP_CIPHER_meth_dup',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_free := LoadFunction('EVP_CIPHER_meth_free',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_iv_length := LoadFunction('EVP_CIPHER_meth_set_iv_length',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_flags := LoadFunction('EVP_CIPHER_meth_set_flags',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_impl_ctx_size := LoadFunction('EVP_CIPHER_meth_set_impl_ctx_size',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_init := LoadFunction('EVP_CIPHER_meth_set_init',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_do_cipher := LoadFunction('EVP_CIPHER_meth_set_do_cipher',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_cleanup := LoadFunction('EVP_CIPHER_meth_set_cleanup',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_set_asn1_params := LoadFunction('EVP_CIPHER_meth_set_set_asn1_params',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_get_asn1_params := LoadFunction('EVP_CIPHER_meth_set_get_asn1_params',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_set_ctrl := LoadFunction('EVP_CIPHER_meth_set_ctrl',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_init := LoadFunction('EVP_CIPHER_meth_get_init',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_do_cipher := LoadFunction('EVP_CIPHER_meth_get_do_cipher',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_cleanup := LoadFunction('EVP_CIPHER_meth_get_cleanup',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_set_asn1_params := LoadFunction('EVP_CIPHER_meth_get_set_asn1_params',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_get_asn1_params := LoadFunction('EVP_CIPHER_meth_get_get_asn1_params',nil); {introduced 1.1.0}
  EVP_CIPHER_meth_get_ctrl := LoadFunction('EVP_CIPHER_meth_get_ctrl',nil); {introduced 1.1.0}
  EVP_MD_type := LoadFunction('EVP_MD_type',nil); {removed 3.0.0}
  EVP_MD_pkey_type := LoadFunction('EVP_MD_pkey_type',nil); {removed 3.0.0}
  EVP_MD_size := LoadFunction('EVP_MD_size',nil); {removed 3.0.0}
  EVP_MD_block_size := LoadFunction('EVP_MD_block_size',nil); {removed 3.0.0}
  EVP_MD_flags := LoadFunction('EVP_MD_flags',nil); {removed 3.0.0}
  EVP_MD_CTX_update_fn := LoadFunction('EVP_MD_CTX_update_fn',nil); {introduced 1.1.0}
  EVP_MD_CTX_set_update_fn := LoadFunction('EVP_MD_CTX_set_update_fn',nil); {introduced 1.1.0}
  EVP_MD_CTX_pkey_ctx := LoadFunction('EVP_MD_CTX_pkey_ctx',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_MD_CTX_set_pkey_ctx := LoadFunction('EVP_MD_CTX_set_pkey_ctx',nil); {introduced 1.1.0}
  EVP_MD_CTX_md_data := LoadFunction('EVP_MD_CTX_md_data',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_nid := LoadFunction('EVP_CIPHER_nid',nil); {removed 3.0.0}
  EVP_CIPHER_block_size := LoadFunction('EVP_CIPHER_block_size',nil); {removed 3.0.0}
  EVP_CIPHER_impl_ctx_size := LoadFunction('EVP_CIPHER_impl_ctx_size',nil); {introduced 1.1.0}
  EVP_CIPHER_key_length := LoadFunction('EVP_CIPHER_key_length',nil); {removed 3.0.0}
  EVP_CIPHER_iv_length := LoadFunction('EVP_CIPHER_iv_length',nil); {removed 3.0.0}
  EVP_CIPHER_flags := LoadFunction('EVP_CIPHER_flags',nil); {removed 3.0.0}
  EVP_CIPHER_CTX_encrypting := LoadFunction('EVP_CIPHER_CTX_encrypting',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_nid := LoadFunction('EVP_CIPHER_CTX_nid',nil); {removed 3.0.0}
  EVP_CIPHER_CTX_block_size := LoadFunction('EVP_CIPHER_CTX_block_size',nil); {removed 3.0.0}
  EVP_CIPHER_CTX_key_length := LoadFunction('EVP_CIPHER_CTX_key_length',nil); {removed 3.0.0}
  EVP_CIPHER_CTX_iv_length := LoadFunction('EVP_CIPHER_CTX_iv_length',nil); {removed 3.0.0}
  EVP_CIPHER_CTX_iv := LoadFunction('EVP_CIPHER_CTX_iv',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_original_iv := LoadFunction('EVP_CIPHER_CTX_original_iv',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_iv_noconst := LoadFunction('EVP_CIPHER_CTX_iv_noconst',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_buf_noconst := LoadFunction('EVP_CIPHER_CTX_buf_noconst',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_num := LoadFunction('EVP_CIPHER_CTX_num',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_set_num := LoadFunction('EVP_CIPHER_CTX_set_num',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_get_cipher_data := LoadFunction('EVP_CIPHER_CTX_get_cipher_data',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_set_cipher_data := LoadFunction('EVP_CIPHER_CTX_set_cipher_data',nil); {introduced 1.1.0}
  BIO_set_md := LoadFunction('BIO_set_md',nil); {removed 1.0.0}
  EVP_MD_CTX_ctrl := LoadFunction('EVP_MD_CTX_ctrl',nil); {introduced 1.1.0}
  EVP_MD_CTX_new := LoadFunction('EVP_MD_CTX_new',nil); {introduced 1.1.0}
  EVP_MD_CTX_reset := LoadFunction('EVP_MD_CTX_reset',nil); {introduced 1.1.0}
  EVP_MD_CTX_free := LoadFunction('EVP_MD_CTX_free',nil); {introduced 1.1.0}
  EVP_DigestFinalXOF := LoadFunction('EVP_DigestFinalXOF',nil); {introduced 1.1.0}
  EVP_DigestSign := LoadFunction('EVP_DigestSign',nil); {introduced 1.1.0}
  EVP_DigestVerify := LoadFunction('EVP_DigestVerify',nil); {introduced 1.1.0}
  EVP_ENCODE_CTX_new := LoadFunction('EVP_ENCODE_CTX_new',nil); {introduced 1.1.0}
  EVP_ENCODE_CTX_free := LoadFunction('EVP_ENCODE_CTX_free',nil); {introduced 1.1.0}
  EVP_ENCODE_CTX_copy := LoadFunction('EVP_ENCODE_CTX_copy',nil); {introduced 1.1.0}
  EVP_ENCODE_CTX_num := LoadFunction('EVP_ENCODE_CTX_num',nil); {introduced 1.1.0}
  EVP_CIPHER_CTX_reset := LoadFunction('EVP_CIPHER_CTX_reset',nil); {introduced 1.1.0}
  EVP_md5_sha1 := LoadFunction('EVP_md5_sha1',nil); {introduced 1.1.0}
  EVP_sha512_224 := LoadFunction('EVP_sha512_224',nil); {introduced 1.1.0}
  EVP_sha512_256 := LoadFunction('EVP_sha512_256',nil); {introduced 1.1.0}
  EVP_sha3_224 := LoadFunction('EVP_sha3_224',nil); {introduced 1.1.0}
  EVP_sha3_256 := LoadFunction('EVP_sha3_256',nil); {introduced 1.1.0}
  EVP_sha3_384 := LoadFunction('EVP_sha3_384',nil); {introduced 1.1.0}
  EVP_sha3_512 := LoadFunction('EVP_sha3_512',nil); {introduced 1.1.0}
  EVP_shake128 := LoadFunction('EVP_shake128',nil); {introduced 1.1.0}
  EVP_shake256 := LoadFunction('EVP_shake256',nil); {introduced 1.1.0}
  EVP_aes_128_wrap_pad := LoadFunction('EVP_aes_128_wrap_pad',nil); {introduced 1.1.0}
  EVP_aes_128_ocb := LoadFunction('EVP_aes_128_ocb',nil); {introduced 1.1.0}
  EVP_aes_192_wrap_pad := LoadFunction('EVP_aes_192_wrap_pad',nil); {introduced 1.1.0}
  EVP_aes_192_ocb := LoadFunction('EVP_aes_192_ocb',nil); {introduced 1.1.0}
  EVP_aes_256_wrap_pad := LoadFunction('EVP_aes_256_wrap_pad',nil); {introduced 1.1.0}
  EVP_aes_256_ocb := LoadFunction('EVP_aes_256_ocb',nil); {introduced 1.1.0}
  EVP_aria_128_ecb := LoadFunction('EVP_aria_128_ecb',nil); {introduced 1.1.0}
  EVP_aria_128_cbc := LoadFunction('EVP_aria_128_cbc',nil); {introduced 1.1.0}
  EVP_aria_128_cfb1 := LoadFunction('EVP_aria_128_cfb1',nil); {introduced 1.1.0}
  EVP_aria_128_cfb8 := LoadFunction('EVP_aria_128_cfb8',nil); {introduced 1.1.0}
  EVP_aria_128_cfb128 := LoadFunction('EVP_aria_128_cfb128',nil); {introduced 1.1.0}
  EVP_aria_128_ctr := LoadFunction('EVP_aria_128_ctr',nil); {introduced 1.1.0}
  EVP_aria_128_ofb := LoadFunction('EVP_aria_128_ofb',nil); {introduced 1.1.0}
  EVP_aria_128_gcm := LoadFunction('EVP_aria_128_gcm',nil); {introduced 1.1.0}
  EVP_aria_128_ccm := LoadFunction('EVP_aria_128_ccm',nil); {introduced 1.1.0}
  EVP_aria_192_ecb := LoadFunction('EVP_aria_192_ecb',nil); {introduced 1.1.0}
  EVP_aria_192_cbc := LoadFunction('EVP_aria_192_cbc',nil); {introduced 1.1.0}
  EVP_aria_192_cfb1 := LoadFunction('EVP_aria_192_cfb1',nil); {introduced 1.1.0}
  EVP_aria_192_cfb8 := LoadFunction('EVP_aria_192_cfb8',nil); {introduced 1.1.0}
  EVP_aria_192_cfb128 := LoadFunction('EVP_aria_192_cfb128',nil); {introduced 1.1.0}
  EVP_aria_192_ctr := LoadFunction('EVP_aria_192_ctr',nil); {introduced 1.1.0}
  EVP_aria_192_ofb := LoadFunction('EVP_aria_192_ofb',nil); {introduced 1.1.0}
  EVP_aria_192_gcm := LoadFunction('EVP_aria_192_gcm',nil); {introduced 1.1.0}
  EVP_aria_192_ccm := LoadFunction('EVP_aria_192_ccm',nil); {introduced 1.1.0}
  EVP_aria_256_ecb := LoadFunction('EVP_aria_256_ecb',nil); {introduced 1.1.0}
  EVP_aria_256_cbc := LoadFunction('EVP_aria_256_cbc',nil); {introduced 1.1.0}
  EVP_aria_256_cfb1 := LoadFunction('EVP_aria_256_cfb1',nil); {introduced 1.1.0}
  EVP_aria_256_cfb8 := LoadFunction('EVP_aria_256_cfb8',nil); {introduced 1.1.0}
  EVP_aria_256_cfb128 := LoadFunction('EVP_aria_256_cfb128',nil); {introduced 1.1.0}
  EVP_aria_256_ctr := LoadFunction('EVP_aria_256_ctr',nil); {introduced 1.1.0}
  EVP_aria_256_ofb := LoadFunction('EVP_aria_256_ofb',nil); {introduced 1.1.0}
  EVP_aria_256_gcm := LoadFunction('EVP_aria_256_gcm',nil); {introduced 1.1.0}
  EVP_aria_256_ccm := LoadFunction('EVP_aria_256_ccm',nil); {introduced 1.1.0}
  EVP_camellia_128_ctr := LoadFunction('EVP_camellia_128_ctr',nil); {introduced 1.1.0}
  EVP_camellia_192_ctr := LoadFunction('EVP_camellia_192_ctr',nil); {introduced 1.1.0}
  EVP_camellia_256_ctr := LoadFunction('EVP_camellia_256_ctr',nil); {introduced 1.1.0}
  EVP_chacha20 := LoadFunction('EVP_chacha20',nil); {introduced 1.1.0}
  EVP_chacha20_poly1305 := LoadFunction('EVP_chacha20_poly1305',nil); {introduced 1.1.0}
  EVP_sm4_ecb := LoadFunction('EVP_sm4_ecb',nil); {introduced 1.1.0}
  EVP_sm4_cbc := LoadFunction('EVP_sm4_cbc',nil); {introduced 1.1.0}
  EVP_sm4_cfb128 := LoadFunction('EVP_sm4_cfb128',nil); {introduced 1.1.0}
  EVP_sm4_ofb := LoadFunction('EVP_sm4_ofb',nil); {introduced 1.1.0}
  EVP_sm4_ctr := LoadFunction('EVP_sm4_ctr',nil); {introduced 1.1.0}
  EVP_PKEY_id := LoadFunction('EVP_PKEY_id',nil); {removed 3.0.0}
  EVP_PKEY_base_id := LoadFunction('EVP_PKEY_base_id',nil); {removed 3.0.0}
  EVP_PKEY_bits := LoadFunction('EVP_PKEY_bits',nil); {removed 3.0.0}
  EVP_PKEY_security_bits := LoadFunction('EVP_PKEY_security_bits',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_size := LoadFunction('EVP_PKEY_size',nil); {removed 3.0.0}
  EVP_PKEY_set_alias_type := LoadFunction('EVP_PKEY_set_alias_type',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_set1_engine := LoadFunction('EVP_PKEY_set1_engine',nil); {introduced 1.1.0}
  EVP_PKEY_get0_engine := LoadFunction('EVP_PKEY_get0_engine',nil); {introduced 1.1.0}
  EVP_PKEY_get0_hmac := LoadFunction('EVP_PKEY_get0_hmac',nil); {introduced 1.1.0}
  EVP_PKEY_get0_poly1305 := LoadFunction('EVP_PKEY_get0_poly1305',nil); {introduced 1.1.0}
  EVP_PKEY_get0_siphash := LoadFunction('EVP_PKEY_get0_siphash',nil); {introduced 1.1.0}
  EVP_PKEY_get0_RSA := LoadFunction('EVP_PKEY_get0_RSA',nil); {introduced 1.1.0}
  EVP_PKEY_get0_DSA := LoadFunction('EVP_PKEY_get0_DSA',nil); {introduced 1.1.0}
  EVP_PKEY_get0_DH := LoadFunction('EVP_PKEY_get0_DH',nil); {introduced 1.1.0}
  EVP_PKEY_get0_EC_KEY := LoadFunction('EVP_PKEY_get0_EC_KEY',nil); {introduced 1.1.0}
  EVP_PKEY_up_ref := LoadFunction('EVP_PKEY_up_ref',nil); {introduced 1.1.0}
  EVP_PKEY_set1_tls_encodedpoint := LoadFunction('EVP_PKEY_set1_tls_encodedpoint',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_get1_tls_encodedpoint := LoadFunction('EVP_PKEY_get1_tls_encodedpoint',nil); {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_type := LoadFunction('EVP_CIPHER_type',nil); {removed 3.0.0}
  EVP_PBE_scrypt := LoadFunction('EVP_PBE_scrypt',nil); {introduced 1.1.0}
  PKCS5_v2_scrypt_keyivgen := LoadFunction('PKCS5_v2_scrypt_keyivgen',nil); {introduced 1.1.0}
  EVP_PBE_get := LoadFunction('EVP_PBE_get',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_siginf := LoadFunction('EVP_PKEY_asn1_set_siginf',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_check := LoadFunction('EVP_PKEY_asn1_set_check',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_public_check := LoadFunction('EVP_PKEY_asn1_set_public_check',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_param_check := LoadFunction('EVP_PKEY_asn1_set_param_check',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_set_priv_key := LoadFunction('EVP_PKEY_asn1_set_set_priv_key',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_set_pub_key := LoadFunction('EVP_PKEY_asn1_set_set_pub_key',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_priv_key := LoadFunction('EVP_PKEY_asn1_set_get_priv_key',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_pub_key := LoadFunction('EVP_PKEY_asn1_set_get_pub_key',nil); {introduced 1.1.0}
  EVP_PKEY_asn1_set_security_bits := LoadFunction('EVP_PKEY_asn1_set_security_bits',nil); {introduced 1.1.0}
  EVP_PKEY_meth_remove := LoadFunction('EVP_PKEY_meth_remove',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_count := LoadFunction('EVP_PKEY_meth_get_count',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get0 := LoadFunction('EVP_PKEY_meth_get0',nil); {introduced 1.1.0}
  EVP_PKEY_CTX_ctrl_uint64 := LoadFunction('EVP_PKEY_CTX_ctrl_uint64',nil); {introduced 1.1.0}
  EVP_PKEY_CTX_str2ctrl := LoadFunction('EVP_PKEY_CTX_str2ctrl',nil); {introduced 1.1.0}
  EVP_PKEY_CTX_hex2ctrl := LoadFunction('EVP_PKEY_CTX_hex2ctrl',nil); {introduced 1.1.0}
  EVP_PKEY_CTX_md := LoadFunction('EVP_PKEY_CTX_md',nil); {introduced 1.1.0}
  EVP_PKEY_new_raw_private_key := LoadFunction('EVP_PKEY_new_raw_private_key',nil); {introduced 1.1.0}
  EVP_PKEY_new_raw_public_key := LoadFunction('EVP_PKEY_new_raw_public_key',nil); {introduced 1.1.0}
  EVP_PKEY_get_raw_private_key := LoadFunction('EVP_PKEY_get_raw_private_key',nil); {introduced 1.1.0}
  EVP_PKEY_get_raw_public_key := LoadFunction('EVP_PKEY_get_raw_public_key',nil); {introduced 1.1.0}
  EVP_PKEY_new_CMAC_key := LoadFunction('EVP_PKEY_new_CMAC_key',nil); {introduced 1.1.0}
  EVP_PKEY_check := LoadFunction('EVP_PKEY_check',nil); {introduced 1.1.0}
  EVP_PKEY_public_check := LoadFunction('EVP_PKEY_public_check',nil); {introduced 1.1.0}
  EVP_PKEY_param_check := LoadFunction('EVP_PKEY_param_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_digestsign := LoadFunction('EVP_PKEY_meth_set_digestsign',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_digestverify := LoadFunction('EVP_PKEY_meth_set_digestverify',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_check := LoadFunction('EVP_PKEY_meth_set_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_public_check := LoadFunction('EVP_PKEY_meth_set_public_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_param_check := LoadFunction('EVP_PKEY_meth_set_param_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_set_digest_custom := LoadFunction('EVP_PKEY_meth_set_digest_custom',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_digestsign := LoadFunction('EVP_PKEY_meth_get_digestsign',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_digestverify := LoadFunction('EVP_PKEY_meth_get_digestverify',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_check := LoadFunction('EVP_PKEY_meth_get_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_public_check := LoadFunction('EVP_PKEY_meth_get_public_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_param_check := LoadFunction('EVP_PKEY_meth_get_param_check',nil); {introduced 1.1.0}
  EVP_PKEY_meth_get_digest_custom := LoadFunction('EVP_PKEY_meth_get_digest_custom',nil); {introduced 1.1.0}
  OpenSSL_add_all_ciphers := LoadFunction('OpenSSL_add_all_ciphers',nil); {removed 1.1.0}
  OpenSSL_add_all_digests := LoadFunction('OpenSSL_add_all_digests',nil); {removed 1.1.0}
  EVP_cleanup := LoadFunction('EVP_cleanup',nil); {removed 1.1.0}
  if not assigned(EVP_PKEY_assign_RSA) then 
  begin
    {$if declared(EVP_PKEY_assign_RSA_introduced)}
    if LibVersion < EVP_PKEY_assign_RSA_introduced then
      {$if declared(FC_EVP_PKEY_assign_RSA)}
      EVP_PKEY_assign_RSA := @FC_EVP_PKEY_assign_RSA
      {$else}
      EVP_PKEY_assign_RSA := @ERR_EVP_PKEY_assign_RSA
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_RSA_removed)}
   if EVP_PKEY_assign_RSA_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_RSA)}
     EVP_PKEY_assign_RSA := @_EVP_PKEY_assign_RSA
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_RSA)}
       EVP_PKEY_assign_RSA := @ERR_EVP_PKEY_assign_RSA
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_RSA) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_RSA');
  end;


  if not assigned(EVP_PKEY_assign_DSA) then 
  begin
    {$if declared(EVP_PKEY_assign_DSA_introduced)}
    if LibVersion < EVP_PKEY_assign_DSA_introduced then
      {$if declared(FC_EVP_PKEY_assign_DSA)}
      EVP_PKEY_assign_DSA := @FC_EVP_PKEY_assign_DSA
      {$else}
      EVP_PKEY_assign_DSA := @ERR_EVP_PKEY_assign_DSA
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_DSA_removed)}
   if EVP_PKEY_assign_DSA_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_DSA)}
     EVP_PKEY_assign_DSA := @_EVP_PKEY_assign_DSA
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_DSA)}
       EVP_PKEY_assign_DSA := @ERR_EVP_PKEY_assign_DSA
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_DSA) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_DSA');
  end;


  if not assigned(EVP_PKEY_assign_DH) then 
  begin
    {$if declared(EVP_PKEY_assign_DH_introduced)}
    if LibVersion < EVP_PKEY_assign_DH_introduced then
      {$if declared(FC_EVP_PKEY_assign_DH)}
      EVP_PKEY_assign_DH := @FC_EVP_PKEY_assign_DH
      {$else}
      EVP_PKEY_assign_DH := @ERR_EVP_PKEY_assign_DH
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_DH_removed)}
   if EVP_PKEY_assign_DH_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_DH)}
     EVP_PKEY_assign_DH := @_EVP_PKEY_assign_DH
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_DH)}
       EVP_PKEY_assign_DH := @ERR_EVP_PKEY_assign_DH
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_DH) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_DH');
  end;


  if not assigned(EVP_PKEY_assign_EC_KEY) then 
  begin
    {$if declared(EVP_PKEY_assign_EC_KEY_introduced)}
    if LibVersion < EVP_PKEY_assign_EC_KEY_introduced then
      {$if declared(FC_EVP_PKEY_assign_EC_KEY)}
      EVP_PKEY_assign_EC_KEY := @FC_EVP_PKEY_assign_EC_KEY
      {$else}
      EVP_PKEY_assign_EC_KEY := @ERR_EVP_PKEY_assign_EC_KEY
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_EC_KEY_removed)}
   if EVP_PKEY_assign_EC_KEY_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_EC_KEY)}
     EVP_PKEY_assign_EC_KEY := @_EVP_PKEY_assign_EC_KEY
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_EC_KEY)}
       EVP_PKEY_assign_EC_KEY := @ERR_EVP_PKEY_assign_EC_KEY
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_EC_KEY) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_EC_KEY');
  end;


  if not assigned(EVP_PKEY_assign_SIPHASH) then 
  begin
    {$if declared(EVP_PKEY_assign_SIPHASH_introduced)}
    if LibVersion < EVP_PKEY_assign_SIPHASH_introduced then
      {$if declared(FC_EVP_PKEY_assign_SIPHASH)}
      EVP_PKEY_assign_SIPHASH := @FC_EVP_PKEY_assign_SIPHASH
      {$else}
      EVP_PKEY_assign_SIPHASH := @ERR_EVP_PKEY_assign_SIPHASH
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_SIPHASH_removed)}
   if EVP_PKEY_assign_SIPHASH_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_SIPHASH)}
     EVP_PKEY_assign_SIPHASH := @_EVP_PKEY_assign_SIPHASH
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_SIPHASH)}
       EVP_PKEY_assign_SIPHASH := @ERR_EVP_PKEY_assign_SIPHASH
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_SIPHASH) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_SIPHASH');
  end;


  if not assigned(EVP_PKEY_assign_POLY1305) then 
  begin
    {$if declared(EVP_PKEY_assign_POLY1305_introduced)}
    if LibVersion < EVP_PKEY_assign_POLY1305_introduced then
      {$if declared(FC_EVP_PKEY_assign_POLY1305)}
      EVP_PKEY_assign_POLY1305 := @FC_EVP_PKEY_assign_POLY1305
      {$else}
      EVP_PKEY_assign_POLY1305 := @ERR_EVP_PKEY_assign_POLY1305
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_assign_POLY1305_removed)}
   if EVP_PKEY_assign_POLY1305_removed <= LibVersion then
     {$if declared(_EVP_PKEY_assign_POLY1305)}
     EVP_PKEY_assign_POLY1305 := @_EVP_PKEY_assign_POLY1305
     {$else}
       {$IF declared(ERR_EVP_PKEY_assign_POLY1305)}
       EVP_PKEY_assign_POLY1305 := @ERR_EVP_PKEY_assign_POLY1305
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_assign_POLY1305) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_assign_POLY1305');
  end;


  if not assigned(EVP_MD_meth_new) then 
  begin
    {$if declared(EVP_MD_meth_new_introduced)}
    if LibVersion < EVP_MD_meth_new_introduced then
      {$if declared(FC_EVP_MD_meth_new)}
      EVP_MD_meth_new := @FC_EVP_MD_meth_new
      {$else}
      EVP_MD_meth_new := @ERR_EVP_MD_meth_new
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_new_removed)}
   if EVP_MD_meth_new_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_new)}
     EVP_MD_meth_new := @_EVP_MD_meth_new
     {$else}
       {$IF declared(ERR_EVP_MD_meth_new)}
       EVP_MD_meth_new := @ERR_EVP_MD_meth_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_new) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_new');
  end;


  if not assigned(EVP_MD_meth_dup) then 
  begin
    {$if declared(EVP_MD_meth_dup_introduced)}
    if LibVersion < EVP_MD_meth_dup_introduced then
      {$if declared(FC_EVP_MD_meth_dup)}
      EVP_MD_meth_dup := @FC_EVP_MD_meth_dup
      {$else}
      EVP_MD_meth_dup := @ERR_EVP_MD_meth_dup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_dup_removed)}
   if EVP_MD_meth_dup_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_dup)}
     EVP_MD_meth_dup := @_EVP_MD_meth_dup
     {$else}
       {$IF declared(ERR_EVP_MD_meth_dup)}
       EVP_MD_meth_dup := @ERR_EVP_MD_meth_dup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_dup) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_dup');
  end;


  if not assigned(EVP_MD_meth_free) then 
  begin
    {$if declared(EVP_MD_meth_free_introduced)}
    if LibVersion < EVP_MD_meth_free_introduced then
      {$if declared(FC_EVP_MD_meth_free)}
      EVP_MD_meth_free := @FC_EVP_MD_meth_free
      {$else}
      EVP_MD_meth_free := @ERR_EVP_MD_meth_free
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_free_removed)}
   if EVP_MD_meth_free_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_free)}
     EVP_MD_meth_free := @_EVP_MD_meth_free
     {$else}
       {$IF declared(ERR_EVP_MD_meth_free)}
       EVP_MD_meth_free := @ERR_EVP_MD_meth_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_free) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_free');
  end;


  if not assigned(EVP_MD_meth_set_input_blocksize) then 
  begin
    {$if declared(EVP_MD_meth_set_input_blocksize_introduced)}
    if LibVersion < EVP_MD_meth_set_input_blocksize_introduced then
      {$if declared(FC_EVP_MD_meth_set_input_blocksize)}
      EVP_MD_meth_set_input_blocksize := @FC_EVP_MD_meth_set_input_blocksize
      {$else}
      EVP_MD_meth_set_input_blocksize := @ERR_EVP_MD_meth_set_input_blocksize
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_input_blocksize_removed)}
   if EVP_MD_meth_set_input_blocksize_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_input_blocksize)}
     EVP_MD_meth_set_input_blocksize := @_EVP_MD_meth_set_input_blocksize
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_input_blocksize)}
       EVP_MD_meth_set_input_blocksize := @ERR_EVP_MD_meth_set_input_blocksize
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_input_blocksize) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_input_blocksize');
  end;


  if not assigned(EVP_MD_meth_set_result_size) then 
  begin
    {$if declared(EVP_MD_meth_set_result_size_introduced)}
    if LibVersion < EVP_MD_meth_set_result_size_introduced then
      {$if declared(FC_EVP_MD_meth_set_result_size)}
      EVP_MD_meth_set_result_size := @FC_EVP_MD_meth_set_result_size
      {$else}
      EVP_MD_meth_set_result_size := @ERR_EVP_MD_meth_set_result_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_result_size_removed)}
   if EVP_MD_meth_set_result_size_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_result_size)}
     EVP_MD_meth_set_result_size := @_EVP_MD_meth_set_result_size
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_result_size)}
       EVP_MD_meth_set_result_size := @ERR_EVP_MD_meth_set_result_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_result_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_result_size');
  end;


  if not assigned(EVP_MD_meth_set_app_datasize) then 
  begin
    {$if declared(EVP_MD_meth_set_app_datasize_introduced)}
    if LibVersion < EVP_MD_meth_set_app_datasize_introduced then
      {$if declared(FC_EVP_MD_meth_set_app_datasize)}
      EVP_MD_meth_set_app_datasize := @FC_EVP_MD_meth_set_app_datasize
      {$else}
      EVP_MD_meth_set_app_datasize := @ERR_EVP_MD_meth_set_app_datasize
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_app_datasize_removed)}
   if EVP_MD_meth_set_app_datasize_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_app_datasize)}
     EVP_MD_meth_set_app_datasize := @_EVP_MD_meth_set_app_datasize
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_app_datasize)}
       EVP_MD_meth_set_app_datasize := @ERR_EVP_MD_meth_set_app_datasize
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_app_datasize) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_app_datasize');
  end;


  if not assigned(EVP_MD_meth_set_flags) then 
  begin
    {$if declared(EVP_MD_meth_set_flags_introduced)}
    if LibVersion < EVP_MD_meth_set_flags_introduced then
      {$if declared(FC_EVP_MD_meth_set_flags)}
      EVP_MD_meth_set_flags := @FC_EVP_MD_meth_set_flags
      {$else}
      EVP_MD_meth_set_flags := @ERR_EVP_MD_meth_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_flags_removed)}
   if EVP_MD_meth_set_flags_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_flags)}
     EVP_MD_meth_set_flags := @_EVP_MD_meth_set_flags
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_flags)}
       EVP_MD_meth_set_flags := @ERR_EVP_MD_meth_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_flags) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_flags');
  end;


  if not assigned(EVP_MD_meth_set_init) then 
  begin
    {$if declared(EVP_MD_meth_set_init_introduced)}
    if LibVersion < EVP_MD_meth_set_init_introduced then
      {$if declared(FC_EVP_MD_meth_set_init)}
      EVP_MD_meth_set_init := @FC_EVP_MD_meth_set_init
      {$else}
      EVP_MD_meth_set_init := @ERR_EVP_MD_meth_set_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_init_removed)}
   if EVP_MD_meth_set_init_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_init)}
     EVP_MD_meth_set_init := @_EVP_MD_meth_set_init
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_init)}
       EVP_MD_meth_set_init := @ERR_EVP_MD_meth_set_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_init) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_init');
  end;


  if not assigned(EVP_MD_meth_set_update) then 
  begin
    {$if declared(EVP_MD_meth_set_update_introduced)}
    if LibVersion < EVP_MD_meth_set_update_introduced then
      {$if declared(FC_EVP_MD_meth_set_update)}
      EVP_MD_meth_set_update := @FC_EVP_MD_meth_set_update
      {$else}
      EVP_MD_meth_set_update := @ERR_EVP_MD_meth_set_update
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_update_removed)}
   if EVP_MD_meth_set_update_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_update)}
     EVP_MD_meth_set_update := @_EVP_MD_meth_set_update
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_update)}
       EVP_MD_meth_set_update := @ERR_EVP_MD_meth_set_update
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_update) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_update');
  end;


  if not assigned(EVP_MD_meth_set_final) then 
  begin
    {$if declared(EVP_MD_meth_set_final_introduced)}
    if LibVersion < EVP_MD_meth_set_final_introduced then
      {$if declared(FC_EVP_MD_meth_set_final)}
      EVP_MD_meth_set_final := @FC_EVP_MD_meth_set_final
      {$else}
      EVP_MD_meth_set_final := @ERR_EVP_MD_meth_set_final
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_final_removed)}
   if EVP_MD_meth_set_final_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_final)}
     EVP_MD_meth_set_final := @_EVP_MD_meth_set_final
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_final)}
       EVP_MD_meth_set_final := @ERR_EVP_MD_meth_set_final
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_final) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_final');
  end;


  if not assigned(EVP_MD_meth_set_copy) then 
  begin
    {$if declared(EVP_MD_meth_set_copy_introduced)}
    if LibVersion < EVP_MD_meth_set_copy_introduced then
      {$if declared(FC_EVP_MD_meth_set_copy)}
      EVP_MD_meth_set_copy := @FC_EVP_MD_meth_set_copy
      {$else}
      EVP_MD_meth_set_copy := @ERR_EVP_MD_meth_set_copy
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_copy_removed)}
   if EVP_MD_meth_set_copy_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_copy)}
     EVP_MD_meth_set_copy := @_EVP_MD_meth_set_copy
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_copy)}
       EVP_MD_meth_set_copy := @ERR_EVP_MD_meth_set_copy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_copy) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_copy');
  end;


  if not assigned(EVP_MD_meth_set_cleanup) then 
  begin
    {$if declared(EVP_MD_meth_set_cleanup_introduced)}
    if LibVersion < EVP_MD_meth_set_cleanup_introduced then
      {$if declared(FC_EVP_MD_meth_set_cleanup)}
      EVP_MD_meth_set_cleanup := @FC_EVP_MD_meth_set_cleanup
      {$else}
      EVP_MD_meth_set_cleanup := @ERR_EVP_MD_meth_set_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_cleanup_removed)}
   if EVP_MD_meth_set_cleanup_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_cleanup)}
     EVP_MD_meth_set_cleanup := @_EVP_MD_meth_set_cleanup
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_cleanup)}
       EVP_MD_meth_set_cleanup := @ERR_EVP_MD_meth_set_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_cleanup) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_cleanup');
  end;


  if not assigned(EVP_MD_meth_set_ctrl) then 
  begin
    {$if declared(EVP_MD_meth_set_ctrl_introduced)}
    if LibVersion < EVP_MD_meth_set_ctrl_introduced then
      {$if declared(FC_EVP_MD_meth_set_ctrl)}
      EVP_MD_meth_set_ctrl := @FC_EVP_MD_meth_set_ctrl
      {$else}
      EVP_MD_meth_set_ctrl := @ERR_EVP_MD_meth_set_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_set_ctrl_removed)}
   if EVP_MD_meth_set_ctrl_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_set_ctrl)}
     EVP_MD_meth_set_ctrl := @_EVP_MD_meth_set_ctrl
     {$else}
       {$IF declared(ERR_EVP_MD_meth_set_ctrl)}
       EVP_MD_meth_set_ctrl := @ERR_EVP_MD_meth_set_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_set_ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_set_ctrl');
  end;


  if not assigned(EVP_MD_meth_get_input_blocksize) then 
  begin
    {$if declared(EVP_MD_meth_get_input_blocksize_introduced)}
    if LibVersion < EVP_MD_meth_get_input_blocksize_introduced then
      {$if declared(FC_EVP_MD_meth_get_input_blocksize)}
      EVP_MD_meth_get_input_blocksize := @FC_EVP_MD_meth_get_input_blocksize
      {$else}
      EVP_MD_meth_get_input_blocksize := @ERR_EVP_MD_meth_get_input_blocksize
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_input_blocksize_removed)}
   if EVP_MD_meth_get_input_blocksize_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_input_blocksize)}
     EVP_MD_meth_get_input_blocksize := @_EVP_MD_meth_get_input_blocksize
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_input_blocksize)}
       EVP_MD_meth_get_input_blocksize := @ERR_EVP_MD_meth_get_input_blocksize
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_input_blocksize) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_input_blocksize');
  end;


  if not assigned(EVP_MD_meth_get_result_size) then 
  begin
    {$if declared(EVP_MD_meth_get_result_size_introduced)}
    if LibVersion < EVP_MD_meth_get_result_size_introduced then
      {$if declared(FC_EVP_MD_meth_get_result_size)}
      EVP_MD_meth_get_result_size := @FC_EVP_MD_meth_get_result_size
      {$else}
      EVP_MD_meth_get_result_size := @ERR_EVP_MD_meth_get_result_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_result_size_removed)}
   if EVP_MD_meth_get_result_size_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_result_size)}
     EVP_MD_meth_get_result_size := @_EVP_MD_meth_get_result_size
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_result_size)}
       EVP_MD_meth_get_result_size := @ERR_EVP_MD_meth_get_result_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_result_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_result_size');
  end;


  if not assigned(EVP_MD_meth_get_app_datasize) then 
  begin
    {$if declared(EVP_MD_meth_get_app_datasize_introduced)}
    if LibVersion < EVP_MD_meth_get_app_datasize_introduced then
      {$if declared(FC_EVP_MD_meth_get_app_datasize)}
      EVP_MD_meth_get_app_datasize := @FC_EVP_MD_meth_get_app_datasize
      {$else}
      EVP_MD_meth_get_app_datasize := @ERR_EVP_MD_meth_get_app_datasize
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_app_datasize_removed)}
   if EVP_MD_meth_get_app_datasize_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_app_datasize)}
     EVP_MD_meth_get_app_datasize := @_EVP_MD_meth_get_app_datasize
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_app_datasize)}
       EVP_MD_meth_get_app_datasize := @ERR_EVP_MD_meth_get_app_datasize
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_app_datasize) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_app_datasize');
  end;


  if not assigned(EVP_MD_meth_get_flags) then 
  begin
    {$if declared(EVP_MD_meth_get_flags_introduced)}
    if LibVersion < EVP_MD_meth_get_flags_introduced then
      {$if declared(FC_EVP_MD_meth_get_flags)}
      EVP_MD_meth_get_flags := @FC_EVP_MD_meth_get_flags
      {$else}
      EVP_MD_meth_get_flags := @ERR_EVP_MD_meth_get_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_flags_removed)}
   if EVP_MD_meth_get_flags_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_flags)}
     EVP_MD_meth_get_flags := @_EVP_MD_meth_get_flags
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_flags)}
       EVP_MD_meth_get_flags := @ERR_EVP_MD_meth_get_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_flags) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_flags');
  end;


  if not assigned(EVP_MD_meth_get_init) then 
  begin
    {$if declared(EVP_MD_meth_get_init_introduced)}
    if LibVersion < EVP_MD_meth_get_init_introduced then
      {$if declared(FC_EVP_MD_meth_get_init)}
      EVP_MD_meth_get_init := @FC_EVP_MD_meth_get_init
      {$else}
      EVP_MD_meth_get_init := @ERR_EVP_MD_meth_get_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_init_removed)}
   if EVP_MD_meth_get_init_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_init)}
     EVP_MD_meth_get_init := @_EVP_MD_meth_get_init
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_init)}
       EVP_MD_meth_get_init := @ERR_EVP_MD_meth_get_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_init) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_init');
  end;


  if not assigned(EVP_MD_meth_get_update) then 
  begin
    {$if declared(EVP_MD_meth_get_update_introduced)}
    if LibVersion < EVP_MD_meth_get_update_introduced then
      {$if declared(FC_EVP_MD_meth_get_update)}
      EVP_MD_meth_get_update := @FC_EVP_MD_meth_get_update
      {$else}
      EVP_MD_meth_get_update := @ERR_EVP_MD_meth_get_update
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_update_removed)}
   if EVP_MD_meth_get_update_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_update)}
     EVP_MD_meth_get_update := @_EVP_MD_meth_get_update
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_update)}
       EVP_MD_meth_get_update := @ERR_EVP_MD_meth_get_update
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_update) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_update');
  end;


  if not assigned(EVP_MD_meth_get_final) then 
  begin
    {$if declared(EVP_MD_meth_get_final_introduced)}
    if LibVersion < EVP_MD_meth_get_final_introduced then
      {$if declared(FC_EVP_MD_meth_get_final)}
      EVP_MD_meth_get_final := @FC_EVP_MD_meth_get_final
      {$else}
      EVP_MD_meth_get_final := @ERR_EVP_MD_meth_get_final
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_final_removed)}
   if EVP_MD_meth_get_final_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_final)}
     EVP_MD_meth_get_final := @_EVP_MD_meth_get_final
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_final)}
       EVP_MD_meth_get_final := @ERR_EVP_MD_meth_get_final
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_final) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_final');
  end;


  if not assigned(EVP_MD_meth_get_copy) then 
  begin
    {$if declared(EVP_MD_meth_get_copy_introduced)}
    if LibVersion < EVP_MD_meth_get_copy_introduced then
      {$if declared(FC_EVP_MD_meth_get_copy)}
      EVP_MD_meth_get_copy := @FC_EVP_MD_meth_get_copy
      {$else}
      EVP_MD_meth_get_copy := @ERR_EVP_MD_meth_get_copy
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_copy_removed)}
   if EVP_MD_meth_get_copy_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_copy)}
     EVP_MD_meth_get_copy := @_EVP_MD_meth_get_copy
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_copy)}
       EVP_MD_meth_get_copy := @ERR_EVP_MD_meth_get_copy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_copy) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_copy');
  end;


  if not assigned(EVP_MD_meth_get_cleanup) then 
  begin
    {$if declared(EVP_MD_meth_get_cleanup_introduced)}
    if LibVersion < EVP_MD_meth_get_cleanup_introduced then
      {$if declared(FC_EVP_MD_meth_get_cleanup)}
      EVP_MD_meth_get_cleanup := @FC_EVP_MD_meth_get_cleanup
      {$else}
      EVP_MD_meth_get_cleanup := @ERR_EVP_MD_meth_get_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_cleanup_removed)}
   if EVP_MD_meth_get_cleanup_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_cleanup)}
     EVP_MD_meth_get_cleanup := @_EVP_MD_meth_get_cleanup
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_cleanup)}
       EVP_MD_meth_get_cleanup := @ERR_EVP_MD_meth_get_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_cleanup) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_cleanup');
  end;


  if not assigned(EVP_MD_meth_get_ctrl) then 
  begin
    {$if declared(EVP_MD_meth_get_ctrl_introduced)}
    if LibVersion < EVP_MD_meth_get_ctrl_introduced then
      {$if declared(FC_EVP_MD_meth_get_ctrl)}
      EVP_MD_meth_get_ctrl := @FC_EVP_MD_meth_get_ctrl
      {$else}
      EVP_MD_meth_get_ctrl := @ERR_EVP_MD_meth_get_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_meth_get_ctrl_removed)}
   if EVP_MD_meth_get_ctrl_removed <= LibVersion then
     {$if declared(_EVP_MD_meth_get_ctrl)}
     EVP_MD_meth_get_ctrl := @_EVP_MD_meth_get_ctrl
     {$else}
       {$IF declared(ERR_EVP_MD_meth_get_ctrl)}
       EVP_MD_meth_get_ctrl := @ERR_EVP_MD_meth_get_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_meth_get_ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_meth_get_ctrl');
  end;


  if not assigned(EVP_CIPHER_meth_new) then 
  begin
    {$if declared(EVP_CIPHER_meth_new_introduced)}
    if LibVersion < EVP_CIPHER_meth_new_introduced then
      {$if declared(FC_EVP_CIPHER_meth_new)}
      EVP_CIPHER_meth_new := @FC_EVP_CIPHER_meth_new
      {$else}
      EVP_CIPHER_meth_new := @ERR_EVP_CIPHER_meth_new
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_new_removed)}
   if EVP_CIPHER_meth_new_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_new)}
     EVP_CIPHER_meth_new := @_EVP_CIPHER_meth_new
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_new)}
       EVP_CIPHER_meth_new := @ERR_EVP_CIPHER_meth_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_new) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_new');
  end;


  if not assigned(EVP_CIPHER_meth_dup) then 
  begin
    {$if declared(EVP_CIPHER_meth_dup_introduced)}
    if LibVersion < EVP_CIPHER_meth_dup_introduced then
      {$if declared(FC_EVP_CIPHER_meth_dup)}
      EVP_CIPHER_meth_dup := @FC_EVP_CIPHER_meth_dup
      {$else}
      EVP_CIPHER_meth_dup := @ERR_EVP_CIPHER_meth_dup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_dup_removed)}
   if EVP_CIPHER_meth_dup_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_dup)}
     EVP_CIPHER_meth_dup := @_EVP_CIPHER_meth_dup
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_dup)}
       EVP_CIPHER_meth_dup := @ERR_EVP_CIPHER_meth_dup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_dup) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_dup');
  end;


  if not assigned(EVP_CIPHER_meth_free) then 
  begin
    {$if declared(EVP_CIPHER_meth_free_introduced)}
    if LibVersion < EVP_CIPHER_meth_free_introduced then
      {$if declared(FC_EVP_CIPHER_meth_free)}
      EVP_CIPHER_meth_free := @FC_EVP_CIPHER_meth_free
      {$else}
      EVP_CIPHER_meth_free := @ERR_EVP_CIPHER_meth_free
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_free_removed)}
   if EVP_CIPHER_meth_free_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_free)}
     EVP_CIPHER_meth_free := @_EVP_CIPHER_meth_free
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_free)}
       EVP_CIPHER_meth_free := @ERR_EVP_CIPHER_meth_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_free) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_free');
  end;


  if not assigned(EVP_CIPHER_meth_set_iv_length) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_iv_length_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_iv_length_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_iv_length)}
      EVP_CIPHER_meth_set_iv_length := @FC_EVP_CIPHER_meth_set_iv_length
      {$else}
      EVP_CIPHER_meth_set_iv_length := @ERR_EVP_CIPHER_meth_set_iv_length
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_iv_length_removed)}
   if EVP_CIPHER_meth_set_iv_length_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_iv_length)}
     EVP_CIPHER_meth_set_iv_length := @_EVP_CIPHER_meth_set_iv_length
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_iv_length)}
       EVP_CIPHER_meth_set_iv_length := @ERR_EVP_CIPHER_meth_set_iv_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_iv_length) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_iv_length');
  end;


  if not assigned(EVP_CIPHER_meth_set_flags) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_flags_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_flags_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_flags)}
      EVP_CIPHER_meth_set_flags := @FC_EVP_CIPHER_meth_set_flags
      {$else}
      EVP_CIPHER_meth_set_flags := @ERR_EVP_CIPHER_meth_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_flags_removed)}
   if EVP_CIPHER_meth_set_flags_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_flags)}
     EVP_CIPHER_meth_set_flags := @_EVP_CIPHER_meth_set_flags
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_flags)}
       EVP_CIPHER_meth_set_flags := @ERR_EVP_CIPHER_meth_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_flags) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_flags');
  end;


  if not assigned(EVP_CIPHER_meth_set_impl_ctx_size) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_impl_ctx_size_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_impl_ctx_size_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_impl_ctx_size)}
      EVP_CIPHER_meth_set_impl_ctx_size := @FC_EVP_CIPHER_meth_set_impl_ctx_size
      {$else}
      EVP_CIPHER_meth_set_impl_ctx_size := @ERR_EVP_CIPHER_meth_set_impl_ctx_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_impl_ctx_size_removed)}
   if EVP_CIPHER_meth_set_impl_ctx_size_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_impl_ctx_size)}
     EVP_CIPHER_meth_set_impl_ctx_size := @_EVP_CIPHER_meth_set_impl_ctx_size
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_impl_ctx_size)}
       EVP_CIPHER_meth_set_impl_ctx_size := @ERR_EVP_CIPHER_meth_set_impl_ctx_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_impl_ctx_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_impl_ctx_size');
  end;


  if not assigned(EVP_CIPHER_meth_set_init) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_init_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_init_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_init)}
      EVP_CIPHER_meth_set_init := @FC_EVP_CIPHER_meth_set_init
      {$else}
      EVP_CIPHER_meth_set_init := @ERR_EVP_CIPHER_meth_set_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_init_removed)}
   if EVP_CIPHER_meth_set_init_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_init)}
     EVP_CIPHER_meth_set_init := @_EVP_CIPHER_meth_set_init
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_init)}
       EVP_CIPHER_meth_set_init := @ERR_EVP_CIPHER_meth_set_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_init) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_init');
  end;


  if not assigned(EVP_CIPHER_meth_set_do_cipher) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_do_cipher_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_do_cipher_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_do_cipher)}
      EVP_CIPHER_meth_set_do_cipher := @FC_EVP_CIPHER_meth_set_do_cipher
      {$else}
      EVP_CIPHER_meth_set_do_cipher := @ERR_EVP_CIPHER_meth_set_do_cipher
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_do_cipher_removed)}
   if EVP_CIPHER_meth_set_do_cipher_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_do_cipher)}
     EVP_CIPHER_meth_set_do_cipher := @_EVP_CIPHER_meth_set_do_cipher
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_do_cipher)}
       EVP_CIPHER_meth_set_do_cipher := @ERR_EVP_CIPHER_meth_set_do_cipher
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_do_cipher) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_do_cipher');
  end;


  if not assigned(EVP_CIPHER_meth_set_cleanup) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_cleanup_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_cleanup_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_cleanup)}
      EVP_CIPHER_meth_set_cleanup := @FC_EVP_CIPHER_meth_set_cleanup
      {$else}
      EVP_CIPHER_meth_set_cleanup := @ERR_EVP_CIPHER_meth_set_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_cleanup_removed)}
   if EVP_CIPHER_meth_set_cleanup_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_cleanup)}
     EVP_CIPHER_meth_set_cleanup := @_EVP_CIPHER_meth_set_cleanup
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_cleanup)}
       EVP_CIPHER_meth_set_cleanup := @ERR_EVP_CIPHER_meth_set_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_cleanup) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_cleanup');
  end;


  if not assigned(EVP_CIPHER_meth_set_set_asn1_params) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_set_asn1_params_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_set_asn1_params_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_set_asn1_params)}
      EVP_CIPHER_meth_set_set_asn1_params := @FC_EVP_CIPHER_meth_set_set_asn1_params
      {$else}
      EVP_CIPHER_meth_set_set_asn1_params := @ERR_EVP_CIPHER_meth_set_set_asn1_params
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_set_asn1_params_removed)}
   if EVP_CIPHER_meth_set_set_asn1_params_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_set_asn1_params)}
     EVP_CIPHER_meth_set_set_asn1_params := @_EVP_CIPHER_meth_set_set_asn1_params
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_set_asn1_params)}
       EVP_CIPHER_meth_set_set_asn1_params := @ERR_EVP_CIPHER_meth_set_set_asn1_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_set_asn1_params) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_set_asn1_params');
  end;


  if not assigned(EVP_CIPHER_meth_set_get_asn1_params) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_get_asn1_params_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_get_asn1_params_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_get_asn1_params)}
      EVP_CIPHER_meth_set_get_asn1_params := @FC_EVP_CIPHER_meth_set_get_asn1_params
      {$else}
      EVP_CIPHER_meth_set_get_asn1_params := @ERR_EVP_CIPHER_meth_set_get_asn1_params
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_get_asn1_params_removed)}
   if EVP_CIPHER_meth_set_get_asn1_params_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_get_asn1_params)}
     EVP_CIPHER_meth_set_get_asn1_params := @_EVP_CIPHER_meth_set_get_asn1_params
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_get_asn1_params)}
       EVP_CIPHER_meth_set_get_asn1_params := @ERR_EVP_CIPHER_meth_set_get_asn1_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_get_asn1_params) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_get_asn1_params');
  end;


  if not assigned(EVP_CIPHER_meth_set_ctrl) then 
  begin
    {$if declared(EVP_CIPHER_meth_set_ctrl_introduced)}
    if LibVersion < EVP_CIPHER_meth_set_ctrl_introduced then
      {$if declared(FC_EVP_CIPHER_meth_set_ctrl)}
      EVP_CIPHER_meth_set_ctrl := @FC_EVP_CIPHER_meth_set_ctrl
      {$else}
      EVP_CIPHER_meth_set_ctrl := @ERR_EVP_CIPHER_meth_set_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_set_ctrl_removed)}
   if EVP_CIPHER_meth_set_ctrl_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_set_ctrl)}
     EVP_CIPHER_meth_set_ctrl := @_EVP_CIPHER_meth_set_ctrl
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_set_ctrl)}
       EVP_CIPHER_meth_set_ctrl := @ERR_EVP_CIPHER_meth_set_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_set_ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_set_ctrl');
  end;


  if not assigned(EVP_CIPHER_meth_get_init) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_init_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_init_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_init)}
      EVP_CIPHER_meth_get_init := @FC_EVP_CIPHER_meth_get_init
      {$else}
      EVP_CIPHER_meth_get_init := @ERR_EVP_CIPHER_meth_get_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_init_removed)}
   if EVP_CIPHER_meth_get_init_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_init)}
     EVP_CIPHER_meth_get_init := @_EVP_CIPHER_meth_get_init
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_init)}
       EVP_CIPHER_meth_get_init := @ERR_EVP_CIPHER_meth_get_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_init) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_init');
  end;


  if not assigned(EVP_CIPHER_meth_get_do_cipher) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_do_cipher_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_do_cipher_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_do_cipher)}
      EVP_CIPHER_meth_get_do_cipher := @FC_EVP_CIPHER_meth_get_do_cipher
      {$else}
      EVP_CIPHER_meth_get_do_cipher := @ERR_EVP_CIPHER_meth_get_do_cipher
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_do_cipher_removed)}
   if EVP_CIPHER_meth_get_do_cipher_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_do_cipher)}
     EVP_CIPHER_meth_get_do_cipher := @_EVP_CIPHER_meth_get_do_cipher
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_do_cipher)}
       EVP_CIPHER_meth_get_do_cipher := @ERR_EVP_CIPHER_meth_get_do_cipher
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_do_cipher) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_do_cipher');
  end;


  if not assigned(EVP_CIPHER_meth_get_cleanup) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_cleanup_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_cleanup_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_cleanup)}
      EVP_CIPHER_meth_get_cleanup := @FC_EVP_CIPHER_meth_get_cleanup
      {$else}
      EVP_CIPHER_meth_get_cleanup := @ERR_EVP_CIPHER_meth_get_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_cleanup_removed)}
   if EVP_CIPHER_meth_get_cleanup_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_cleanup)}
     EVP_CIPHER_meth_get_cleanup := @_EVP_CIPHER_meth_get_cleanup
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_cleanup)}
       EVP_CIPHER_meth_get_cleanup := @ERR_EVP_CIPHER_meth_get_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_cleanup) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_cleanup');
  end;


  if not assigned(EVP_CIPHER_meth_get_set_asn1_params) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_set_asn1_params_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_set_asn1_params_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_set_asn1_params)}
      EVP_CIPHER_meth_get_set_asn1_params := @FC_EVP_CIPHER_meth_get_set_asn1_params
      {$else}
      EVP_CIPHER_meth_get_set_asn1_params := @ERR_EVP_CIPHER_meth_get_set_asn1_params
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_set_asn1_params_removed)}
   if EVP_CIPHER_meth_get_set_asn1_params_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_set_asn1_params)}
     EVP_CIPHER_meth_get_set_asn1_params := @_EVP_CIPHER_meth_get_set_asn1_params
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_set_asn1_params)}
       EVP_CIPHER_meth_get_set_asn1_params := @ERR_EVP_CIPHER_meth_get_set_asn1_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_set_asn1_params) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_set_asn1_params');
  end;


  if not assigned(EVP_CIPHER_meth_get_get_asn1_params) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_get_asn1_params_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_get_asn1_params_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_get_asn1_params)}
      EVP_CIPHER_meth_get_get_asn1_params := @FC_EVP_CIPHER_meth_get_get_asn1_params
      {$else}
      EVP_CIPHER_meth_get_get_asn1_params := @ERR_EVP_CIPHER_meth_get_get_asn1_params
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_get_asn1_params_removed)}
   if EVP_CIPHER_meth_get_get_asn1_params_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_get_asn1_params)}
     EVP_CIPHER_meth_get_get_asn1_params := @_EVP_CIPHER_meth_get_get_asn1_params
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_get_asn1_params)}
       EVP_CIPHER_meth_get_get_asn1_params := @ERR_EVP_CIPHER_meth_get_get_asn1_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_get_asn1_params) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_get_asn1_params');
  end;


  if not assigned(EVP_CIPHER_meth_get_ctrl) then 
  begin
    {$if declared(EVP_CIPHER_meth_get_ctrl_introduced)}
    if LibVersion < EVP_CIPHER_meth_get_ctrl_introduced then
      {$if declared(FC_EVP_CIPHER_meth_get_ctrl)}
      EVP_CIPHER_meth_get_ctrl := @FC_EVP_CIPHER_meth_get_ctrl
      {$else}
      EVP_CIPHER_meth_get_ctrl := @ERR_EVP_CIPHER_meth_get_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_meth_get_ctrl_removed)}
   if EVP_CIPHER_meth_get_ctrl_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_meth_get_ctrl)}
     EVP_CIPHER_meth_get_ctrl := @_EVP_CIPHER_meth_get_ctrl
     {$else}
       {$IF declared(ERR_EVP_CIPHER_meth_get_ctrl)}
       EVP_CIPHER_meth_get_ctrl := @ERR_EVP_CIPHER_meth_get_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_meth_get_ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_meth_get_ctrl');
  end;


  if not assigned(EVP_MD_type) then 
  begin
    {$if declared(EVP_MD_type_introduced)}
    if LibVersion < EVP_MD_type_introduced then
      {$if declared(FC_EVP_MD_type)}
      EVP_MD_type := @FC_EVP_MD_type
      {$else}
      EVP_MD_type := @ERR_EVP_MD_type
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_type_removed)}
   if EVP_MD_type_removed <= LibVersion then
     {$if declared(_EVP_MD_type)}
     EVP_MD_type := @_EVP_MD_type
     {$else}
       {$IF declared(ERR_EVP_MD_type)}
       EVP_MD_type := @ERR_EVP_MD_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_type) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_type');
  end;


  if not assigned(EVP_MD_pkey_type) then 
  begin
    {$if declared(EVP_MD_pkey_type_introduced)}
    if LibVersion < EVP_MD_pkey_type_introduced then
      {$if declared(FC_EVP_MD_pkey_type)}
      EVP_MD_pkey_type := @FC_EVP_MD_pkey_type
      {$else}
      EVP_MD_pkey_type := @ERR_EVP_MD_pkey_type
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_pkey_type_removed)}
   if EVP_MD_pkey_type_removed <= LibVersion then
     {$if declared(_EVP_MD_pkey_type)}
     EVP_MD_pkey_type := @_EVP_MD_pkey_type
     {$else}
       {$IF declared(ERR_EVP_MD_pkey_type)}
       EVP_MD_pkey_type := @ERR_EVP_MD_pkey_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_pkey_type) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_pkey_type');
  end;


  if not assigned(EVP_MD_size) then 
  begin
    {$if declared(EVP_MD_size_introduced)}
    if LibVersion < EVP_MD_size_introduced then
      {$if declared(FC_EVP_MD_size)}
      EVP_MD_size := @FC_EVP_MD_size
      {$else}
      EVP_MD_size := @ERR_EVP_MD_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_size_removed)}
   if EVP_MD_size_removed <= LibVersion then
     {$if declared(_EVP_MD_size)}
     EVP_MD_size := @_EVP_MD_size
     {$else}
       {$IF declared(ERR_EVP_MD_size)}
       EVP_MD_size := @ERR_EVP_MD_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_size');
  end;


  if not assigned(EVP_MD_block_size) then 
  begin
    {$if declared(EVP_MD_block_size_introduced)}
    if LibVersion < EVP_MD_block_size_introduced then
      {$if declared(FC_EVP_MD_block_size)}
      EVP_MD_block_size := @FC_EVP_MD_block_size
      {$else}
      EVP_MD_block_size := @ERR_EVP_MD_block_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_block_size_removed)}
   if EVP_MD_block_size_removed <= LibVersion then
     {$if declared(_EVP_MD_block_size)}
     EVP_MD_block_size := @_EVP_MD_block_size
     {$else}
       {$IF declared(ERR_EVP_MD_block_size)}
       EVP_MD_block_size := @ERR_EVP_MD_block_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_block_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_block_size');
  end;


  if not assigned(EVP_MD_flags) then 
  begin
    {$if declared(EVP_MD_flags_introduced)}
    if LibVersion < EVP_MD_flags_introduced then
      {$if declared(FC_EVP_MD_flags)}
      EVP_MD_flags := @FC_EVP_MD_flags
      {$else}
      EVP_MD_flags := @ERR_EVP_MD_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_flags_removed)}
   if EVP_MD_flags_removed <= LibVersion then
     {$if declared(_EVP_MD_flags)}
     EVP_MD_flags := @_EVP_MD_flags
     {$else}
       {$IF declared(ERR_EVP_MD_flags)}
       EVP_MD_flags := @ERR_EVP_MD_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_flags) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_flags');
  end;


  if not assigned(EVP_MD_CTX_update_fn) then 
  begin
    {$if declared(EVP_MD_CTX_update_fn_introduced)}
    if LibVersion < EVP_MD_CTX_update_fn_introduced then
      {$if declared(FC_EVP_MD_CTX_update_fn)}
      EVP_MD_CTX_update_fn := @FC_EVP_MD_CTX_update_fn
      {$else}
      EVP_MD_CTX_update_fn := @ERR_EVP_MD_CTX_update_fn
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_update_fn_removed)}
   if EVP_MD_CTX_update_fn_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_update_fn)}
     EVP_MD_CTX_update_fn := @_EVP_MD_CTX_update_fn
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_update_fn)}
       EVP_MD_CTX_update_fn := @ERR_EVP_MD_CTX_update_fn
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_update_fn) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_update_fn');
  end;


  if not assigned(EVP_MD_CTX_set_update_fn) then 
  begin
    {$if declared(EVP_MD_CTX_set_update_fn_introduced)}
    if LibVersion < EVP_MD_CTX_set_update_fn_introduced then
      {$if declared(FC_EVP_MD_CTX_set_update_fn)}
      EVP_MD_CTX_set_update_fn := @FC_EVP_MD_CTX_set_update_fn
      {$else}
      EVP_MD_CTX_set_update_fn := @ERR_EVP_MD_CTX_set_update_fn
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_set_update_fn_removed)}
   if EVP_MD_CTX_set_update_fn_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_set_update_fn)}
     EVP_MD_CTX_set_update_fn := @_EVP_MD_CTX_set_update_fn
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_set_update_fn)}
       EVP_MD_CTX_set_update_fn := @ERR_EVP_MD_CTX_set_update_fn
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_set_update_fn) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_set_update_fn');
  end;


  if not assigned(EVP_MD_CTX_pkey_ctx) then 
  begin
    {$if declared(EVP_MD_CTX_pkey_ctx_introduced)}
    if LibVersion < EVP_MD_CTX_pkey_ctx_introduced then
      {$if declared(FC_EVP_MD_CTX_pkey_ctx)}
      EVP_MD_CTX_pkey_ctx := @FC_EVP_MD_CTX_pkey_ctx
      {$else}
      EVP_MD_CTX_pkey_ctx := @ERR_EVP_MD_CTX_pkey_ctx
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_pkey_ctx_removed)}
   if EVP_MD_CTX_pkey_ctx_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_pkey_ctx)}
     EVP_MD_CTX_pkey_ctx := @_EVP_MD_CTX_pkey_ctx
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_pkey_ctx)}
       EVP_MD_CTX_pkey_ctx := @ERR_EVP_MD_CTX_pkey_ctx
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_pkey_ctx) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_pkey_ctx');
  end;


  if not assigned(EVP_MD_CTX_set_pkey_ctx) then 
  begin
    {$if declared(EVP_MD_CTX_set_pkey_ctx_introduced)}
    if LibVersion < EVP_MD_CTX_set_pkey_ctx_introduced then
      {$if declared(FC_EVP_MD_CTX_set_pkey_ctx)}
      EVP_MD_CTX_set_pkey_ctx := @FC_EVP_MD_CTX_set_pkey_ctx
      {$else}
      EVP_MD_CTX_set_pkey_ctx := @ERR_EVP_MD_CTX_set_pkey_ctx
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_set_pkey_ctx_removed)}
   if EVP_MD_CTX_set_pkey_ctx_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_set_pkey_ctx)}
     EVP_MD_CTX_set_pkey_ctx := @_EVP_MD_CTX_set_pkey_ctx
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_set_pkey_ctx)}
       EVP_MD_CTX_set_pkey_ctx := @ERR_EVP_MD_CTX_set_pkey_ctx
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_set_pkey_ctx) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_set_pkey_ctx');
  end;


  if not assigned(EVP_MD_CTX_md_data) then 
  begin
    {$if declared(EVP_MD_CTX_md_data_introduced)}
    if LibVersion < EVP_MD_CTX_md_data_introduced then
      {$if declared(FC_EVP_MD_CTX_md_data)}
      EVP_MD_CTX_md_data := @FC_EVP_MD_CTX_md_data
      {$else}
      EVP_MD_CTX_md_data := @ERR_EVP_MD_CTX_md_data
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_md_data_removed)}
   if EVP_MD_CTX_md_data_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_md_data)}
     EVP_MD_CTX_md_data := @_EVP_MD_CTX_md_data
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_md_data)}
       EVP_MD_CTX_md_data := @ERR_EVP_MD_CTX_md_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_md_data) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_md_data');
  end;


  if not assigned(EVP_CIPHER_nid) then 
  begin
    {$if declared(EVP_CIPHER_nid_introduced)}
    if LibVersion < EVP_CIPHER_nid_introduced then
      {$if declared(FC_EVP_CIPHER_nid)}
      EVP_CIPHER_nid := @FC_EVP_CIPHER_nid
      {$else}
      EVP_CIPHER_nid := @ERR_EVP_CIPHER_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_nid_removed)}
   if EVP_CIPHER_nid_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_nid)}
     EVP_CIPHER_nid := @_EVP_CIPHER_nid
     {$else}
       {$IF declared(ERR_EVP_CIPHER_nid)}
       EVP_CIPHER_nid := @ERR_EVP_CIPHER_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_nid) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_nid');
  end;


  if not assigned(EVP_CIPHER_block_size) then 
  begin
    {$if declared(EVP_CIPHER_block_size_introduced)}
    if LibVersion < EVP_CIPHER_block_size_introduced then
      {$if declared(FC_EVP_CIPHER_block_size)}
      EVP_CIPHER_block_size := @FC_EVP_CIPHER_block_size
      {$else}
      EVP_CIPHER_block_size := @ERR_EVP_CIPHER_block_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_block_size_removed)}
   if EVP_CIPHER_block_size_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_block_size)}
     EVP_CIPHER_block_size := @_EVP_CIPHER_block_size
     {$else}
       {$IF declared(ERR_EVP_CIPHER_block_size)}
       EVP_CIPHER_block_size := @ERR_EVP_CIPHER_block_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_block_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_block_size');
  end;


  if not assigned(EVP_CIPHER_impl_ctx_size) then 
  begin
    {$if declared(EVP_CIPHER_impl_ctx_size_introduced)}
    if LibVersion < EVP_CIPHER_impl_ctx_size_introduced then
      {$if declared(FC_EVP_CIPHER_impl_ctx_size)}
      EVP_CIPHER_impl_ctx_size := @FC_EVP_CIPHER_impl_ctx_size
      {$else}
      EVP_CIPHER_impl_ctx_size := @ERR_EVP_CIPHER_impl_ctx_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_impl_ctx_size_removed)}
   if EVP_CIPHER_impl_ctx_size_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_impl_ctx_size)}
     EVP_CIPHER_impl_ctx_size := @_EVP_CIPHER_impl_ctx_size
     {$else}
       {$IF declared(ERR_EVP_CIPHER_impl_ctx_size)}
       EVP_CIPHER_impl_ctx_size := @ERR_EVP_CIPHER_impl_ctx_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_impl_ctx_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_impl_ctx_size');
  end;


  if not assigned(EVP_CIPHER_key_length) then 
  begin
    {$if declared(EVP_CIPHER_key_length_introduced)}
    if LibVersion < EVP_CIPHER_key_length_introduced then
      {$if declared(FC_EVP_CIPHER_key_length)}
      EVP_CIPHER_key_length := @FC_EVP_CIPHER_key_length
      {$else}
      EVP_CIPHER_key_length := @ERR_EVP_CIPHER_key_length
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_key_length_removed)}
   if EVP_CIPHER_key_length_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_key_length)}
     EVP_CIPHER_key_length := @_EVP_CIPHER_key_length
     {$else}
       {$IF declared(ERR_EVP_CIPHER_key_length)}
       EVP_CIPHER_key_length := @ERR_EVP_CIPHER_key_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_key_length) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_key_length');
  end;


  if not assigned(EVP_CIPHER_iv_length) then 
  begin
    {$if declared(EVP_CIPHER_iv_length_introduced)}
    if LibVersion < EVP_CIPHER_iv_length_introduced then
      {$if declared(FC_EVP_CIPHER_iv_length)}
      EVP_CIPHER_iv_length := @FC_EVP_CIPHER_iv_length
      {$else}
      EVP_CIPHER_iv_length := @ERR_EVP_CIPHER_iv_length
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_iv_length_removed)}
   if EVP_CIPHER_iv_length_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_iv_length)}
     EVP_CIPHER_iv_length := @_EVP_CIPHER_iv_length
     {$else}
       {$IF declared(ERR_EVP_CIPHER_iv_length)}
       EVP_CIPHER_iv_length := @ERR_EVP_CIPHER_iv_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_iv_length) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_iv_length');
  end;


  if not assigned(EVP_CIPHER_flags) then 
  begin
    {$if declared(EVP_CIPHER_flags_introduced)}
    if LibVersion < EVP_CIPHER_flags_introduced then
      {$if declared(FC_EVP_CIPHER_flags)}
      EVP_CIPHER_flags := @FC_EVP_CIPHER_flags
      {$else}
      EVP_CIPHER_flags := @ERR_EVP_CIPHER_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_flags_removed)}
   if EVP_CIPHER_flags_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_flags)}
     EVP_CIPHER_flags := @_EVP_CIPHER_flags
     {$else}
       {$IF declared(ERR_EVP_CIPHER_flags)}
       EVP_CIPHER_flags := @ERR_EVP_CIPHER_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_flags) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_flags');
  end;


  if not assigned(EVP_CIPHER_CTX_encrypting) then 
  begin
    {$if declared(EVP_CIPHER_CTX_encrypting_introduced)}
    if LibVersion < EVP_CIPHER_CTX_encrypting_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_encrypting)}
      EVP_CIPHER_CTX_encrypting := @FC_EVP_CIPHER_CTX_encrypting
      {$else}
      EVP_CIPHER_CTX_encrypting := @ERR_EVP_CIPHER_CTX_encrypting
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_encrypting_removed)}
   if EVP_CIPHER_CTX_encrypting_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_encrypting)}
     EVP_CIPHER_CTX_encrypting := @_EVP_CIPHER_CTX_encrypting
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_encrypting)}
       EVP_CIPHER_CTX_encrypting := @ERR_EVP_CIPHER_CTX_encrypting
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_encrypting) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_encrypting');
  end;


  if not assigned(EVP_CIPHER_CTX_nid) then 
  begin
    {$if declared(EVP_CIPHER_CTX_nid_introduced)}
    if LibVersion < EVP_CIPHER_CTX_nid_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_nid)}
      EVP_CIPHER_CTX_nid := @FC_EVP_CIPHER_CTX_nid
      {$else}
      EVP_CIPHER_CTX_nid := @ERR_EVP_CIPHER_CTX_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_nid_removed)}
   if EVP_CIPHER_CTX_nid_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_nid)}
     EVP_CIPHER_CTX_nid := @_EVP_CIPHER_CTX_nid
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_nid)}
       EVP_CIPHER_CTX_nid := @ERR_EVP_CIPHER_CTX_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_nid) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_nid');
  end;


  if not assigned(EVP_CIPHER_CTX_block_size) then 
  begin
    {$if declared(EVP_CIPHER_CTX_block_size_introduced)}
    if LibVersion < EVP_CIPHER_CTX_block_size_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_block_size)}
      EVP_CIPHER_CTX_block_size := @FC_EVP_CIPHER_CTX_block_size
      {$else}
      EVP_CIPHER_CTX_block_size := @ERR_EVP_CIPHER_CTX_block_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_block_size_removed)}
   if EVP_CIPHER_CTX_block_size_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_block_size)}
     EVP_CIPHER_CTX_block_size := @_EVP_CIPHER_CTX_block_size
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_block_size)}
       EVP_CIPHER_CTX_block_size := @ERR_EVP_CIPHER_CTX_block_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_block_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_block_size');
  end;


  if not assigned(EVP_CIPHER_CTX_key_length) then 
  begin
    {$if declared(EVP_CIPHER_CTX_key_length_introduced)}
    if LibVersion < EVP_CIPHER_CTX_key_length_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_key_length)}
      EVP_CIPHER_CTX_key_length := @FC_EVP_CIPHER_CTX_key_length
      {$else}
      EVP_CIPHER_CTX_key_length := @ERR_EVP_CIPHER_CTX_key_length
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_key_length_removed)}
   if EVP_CIPHER_CTX_key_length_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_key_length)}
     EVP_CIPHER_CTX_key_length := @_EVP_CIPHER_CTX_key_length
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_key_length)}
       EVP_CIPHER_CTX_key_length := @ERR_EVP_CIPHER_CTX_key_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_key_length) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_key_length');
  end;


  if not assigned(EVP_CIPHER_CTX_iv_length) then 
  begin
    {$if declared(EVP_CIPHER_CTX_iv_length_introduced)}
    if LibVersion < EVP_CIPHER_CTX_iv_length_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_iv_length)}
      EVP_CIPHER_CTX_iv_length := @FC_EVP_CIPHER_CTX_iv_length
      {$else}
      EVP_CIPHER_CTX_iv_length := @ERR_EVP_CIPHER_CTX_iv_length
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_iv_length_removed)}
   if EVP_CIPHER_CTX_iv_length_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_iv_length)}
     EVP_CIPHER_CTX_iv_length := @_EVP_CIPHER_CTX_iv_length
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_iv_length)}
       EVP_CIPHER_CTX_iv_length := @ERR_EVP_CIPHER_CTX_iv_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_iv_length) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_iv_length');
  end;


  if not assigned(EVP_CIPHER_CTX_iv) then 
  begin
    {$if declared(EVP_CIPHER_CTX_iv_introduced)}
    if LibVersion < EVP_CIPHER_CTX_iv_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_iv)}
      EVP_CIPHER_CTX_iv := @FC_EVP_CIPHER_CTX_iv
      {$else}
      EVP_CIPHER_CTX_iv := @ERR_EVP_CIPHER_CTX_iv
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_iv_removed)}
   if EVP_CIPHER_CTX_iv_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_iv)}
     EVP_CIPHER_CTX_iv := @_EVP_CIPHER_CTX_iv
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_iv)}
       EVP_CIPHER_CTX_iv := @ERR_EVP_CIPHER_CTX_iv
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_iv) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_iv');
  end;


  if not assigned(EVP_CIPHER_CTX_original_iv) then 
  begin
    {$if declared(EVP_CIPHER_CTX_original_iv_introduced)}
    if LibVersion < EVP_CIPHER_CTX_original_iv_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_original_iv)}
      EVP_CIPHER_CTX_original_iv := @FC_EVP_CIPHER_CTX_original_iv
      {$else}
      EVP_CIPHER_CTX_original_iv := @ERR_EVP_CIPHER_CTX_original_iv
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_original_iv_removed)}
   if EVP_CIPHER_CTX_original_iv_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_original_iv)}
     EVP_CIPHER_CTX_original_iv := @_EVP_CIPHER_CTX_original_iv
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_original_iv)}
       EVP_CIPHER_CTX_original_iv := @ERR_EVP_CIPHER_CTX_original_iv
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_original_iv) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_original_iv');
  end;


  if not assigned(EVP_CIPHER_CTX_iv_noconst) then 
  begin
    {$if declared(EVP_CIPHER_CTX_iv_noconst_introduced)}
    if LibVersion < EVP_CIPHER_CTX_iv_noconst_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_iv_noconst)}
      EVP_CIPHER_CTX_iv_noconst := @FC_EVP_CIPHER_CTX_iv_noconst
      {$else}
      EVP_CIPHER_CTX_iv_noconst := @ERR_EVP_CIPHER_CTX_iv_noconst
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_iv_noconst_removed)}
   if EVP_CIPHER_CTX_iv_noconst_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_iv_noconst)}
     EVP_CIPHER_CTX_iv_noconst := @_EVP_CIPHER_CTX_iv_noconst
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_iv_noconst)}
       EVP_CIPHER_CTX_iv_noconst := @ERR_EVP_CIPHER_CTX_iv_noconst
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_iv_noconst) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_iv_noconst');
  end;


  if not assigned(EVP_CIPHER_CTX_buf_noconst) then 
  begin
    {$if declared(EVP_CIPHER_CTX_buf_noconst_introduced)}
    if LibVersion < EVP_CIPHER_CTX_buf_noconst_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_buf_noconst)}
      EVP_CIPHER_CTX_buf_noconst := @FC_EVP_CIPHER_CTX_buf_noconst
      {$else}
      EVP_CIPHER_CTX_buf_noconst := @ERR_EVP_CIPHER_CTX_buf_noconst
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_buf_noconst_removed)}
   if EVP_CIPHER_CTX_buf_noconst_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_buf_noconst)}
     EVP_CIPHER_CTX_buf_noconst := @_EVP_CIPHER_CTX_buf_noconst
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_buf_noconst)}
       EVP_CIPHER_CTX_buf_noconst := @ERR_EVP_CIPHER_CTX_buf_noconst
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_buf_noconst) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_buf_noconst');
  end;


  if not assigned(EVP_CIPHER_CTX_num) then 
  begin
    {$if declared(EVP_CIPHER_CTX_num_introduced)}
    if LibVersion < EVP_CIPHER_CTX_num_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_num)}
      EVP_CIPHER_CTX_num := @FC_EVP_CIPHER_CTX_num
      {$else}
      EVP_CIPHER_CTX_num := @ERR_EVP_CIPHER_CTX_num
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_num_removed)}
   if EVP_CIPHER_CTX_num_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_num)}
     EVP_CIPHER_CTX_num := @_EVP_CIPHER_CTX_num
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_num)}
       EVP_CIPHER_CTX_num := @ERR_EVP_CIPHER_CTX_num
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_num) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_num');
  end;


  if not assigned(EVP_CIPHER_CTX_set_num) then 
  begin
    {$if declared(EVP_CIPHER_CTX_set_num_introduced)}
    if LibVersion < EVP_CIPHER_CTX_set_num_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_set_num)}
      EVP_CIPHER_CTX_set_num := @FC_EVP_CIPHER_CTX_set_num
      {$else}
      EVP_CIPHER_CTX_set_num := @ERR_EVP_CIPHER_CTX_set_num
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_set_num_removed)}
   if EVP_CIPHER_CTX_set_num_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_set_num)}
     EVP_CIPHER_CTX_set_num := @_EVP_CIPHER_CTX_set_num
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_set_num)}
       EVP_CIPHER_CTX_set_num := @ERR_EVP_CIPHER_CTX_set_num
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_set_num) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_set_num');
  end;


  if not assigned(EVP_CIPHER_CTX_get_cipher_data) then 
  begin
    {$if declared(EVP_CIPHER_CTX_get_cipher_data_introduced)}
    if LibVersion < EVP_CIPHER_CTX_get_cipher_data_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_get_cipher_data)}
      EVP_CIPHER_CTX_get_cipher_data := @FC_EVP_CIPHER_CTX_get_cipher_data
      {$else}
      EVP_CIPHER_CTX_get_cipher_data := @ERR_EVP_CIPHER_CTX_get_cipher_data
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_get_cipher_data_removed)}
   if EVP_CIPHER_CTX_get_cipher_data_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_get_cipher_data)}
     EVP_CIPHER_CTX_get_cipher_data := @_EVP_CIPHER_CTX_get_cipher_data
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_get_cipher_data)}
       EVP_CIPHER_CTX_get_cipher_data := @ERR_EVP_CIPHER_CTX_get_cipher_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_get_cipher_data) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_get_cipher_data');
  end;


  if not assigned(EVP_CIPHER_CTX_set_cipher_data) then 
  begin
    {$if declared(EVP_CIPHER_CTX_set_cipher_data_introduced)}
    if LibVersion < EVP_CIPHER_CTX_set_cipher_data_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_set_cipher_data)}
      EVP_CIPHER_CTX_set_cipher_data := @FC_EVP_CIPHER_CTX_set_cipher_data
      {$else}
      EVP_CIPHER_CTX_set_cipher_data := @ERR_EVP_CIPHER_CTX_set_cipher_data
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_set_cipher_data_removed)}
   if EVP_CIPHER_CTX_set_cipher_data_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_set_cipher_data)}
     EVP_CIPHER_CTX_set_cipher_data := @_EVP_CIPHER_CTX_set_cipher_data
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_set_cipher_data)}
       EVP_CIPHER_CTX_set_cipher_data := @ERR_EVP_CIPHER_CTX_set_cipher_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_set_cipher_data) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_set_cipher_data');
  end;


  if not assigned(BIO_set_md) then 
  begin
    {$if declared(BIO_set_md_introduced)}
    if LibVersion < BIO_set_md_introduced then
      {$if declared(FC_BIO_set_md)}
      BIO_set_md := @FC_BIO_set_md
      {$else}
      BIO_set_md := @ERR_BIO_set_md
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_md_removed)}
   if BIO_set_md_removed <= LibVersion then
     {$if declared(_BIO_set_md)}
     BIO_set_md := @_BIO_set_md
     {$else}
       {$IF declared(ERR_BIO_set_md)}
       BIO_set_md := @ERR_BIO_set_md
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_md) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_md');
  end;


  if not assigned(EVP_MD_CTX_ctrl) then 
  begin
    {$if declared(EVP_MD_CTX_ctrl_introduced)}
    if LibVersion < EVP_MD_CTX_ctrl_introduced then
      {$if declared(FC_EVP_MD_CTX_ctrl)}
      EVP_MD_CTX_ctrl := @FC_EVP_MD_CTX_ctrl
      {$else}
      EVP_MD_CTX_ctrl := @ERR_EVP_MD_CTX_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_ctrl_removed)}
   if EVP_MD_CTX_ctrl_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_ctrl)}
     EVP_MD_CTX_ctrl := @_EVP_MD_CTX_ctrl
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_ctrl)}
       EVP_MD_CTX_ctrl := @ERR_EVP_MD_CTX_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_ctrl');
  end;


  if not assigned(EVP_MD_CTX_new) then 
  begin
    {$if declared(EVP_MD_CTX_new_introduced)}
    if LibVersion < EVP_MD_CTX_new_introduced then
      {$if declared(FC_EVP_MD_CTX_new)}
      EVP_MD_CTX_new := @FC_EVP_MD_CTX_new
      {$else}
      EVP_MD_CTX_new := @ERR_EVP_MD_CTX_new
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_new_removed)}
   if EVP_MD_CTX_new_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_new)}
     EVP_MD_CTX_new := @_EVP_MD_CTX_new
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_new)}
       EVP_MD_CTX_new := @ERR_EVP_MD_CTX_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_new) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_new');
  end;


  if not assigned(EVP_MD_CTX_reset) then 
  begin
    {$if declared(EVP_MD_CTX_reset_introduced)}
    if LibVersion < EVP_MD_CTX_reset_introduced then
      {$if declared(FC_EVP_MD_CTX_reset)}
      EVP_MD_CTX_reset := @FC_EVP_MD_CTX_reset
      {$else}
      EVP_MD_CTX_reset := @ERR_EVP_MD_CTX_reset
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_reset_removed)}
   if EVP_MD_CTX_reset_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_reset)}
     EVP_MD_CTX_reset := @_EVP_MD_CTX_reset
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_reset)}
       EVP_MD_CTX_reset := @ERR_EVP_MD_CTX_reset
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_reset) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_reset');
  end;


  if not assigned(EVP_MD_CTX_free) then 
  begin
    {$if declared(EVP_MD_CTX_free_introduced)}
    if LibVersion < EVP_MD_CTX_free_introduced then
      {$if declared(FC_EVP_MD_CTX_free)}
      EVP_MD_CTX_free := @FC_EVP_MD_CTX_free
      {$else}
      EVP_MD_CTX_free := @ERR_EVP_MD_CTX_free
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_MD_CTX_free_removed)}
   if EVP_MD_CTX_free_removed <= LibVersion then
     {$if declared(_EVP_MD_CTX_free)}
     EVP_MD_CTX_free := @_EVP_MD_CTX_free
     {$else}
       {$IF declared(ERR_EVP_MD_CTX_free)}
       EVP_MD_CTX_free := @ERR_EVP_MD_CTX_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_MD_CTX_free) and Assigned(AFailed) then 
     AFailed.Add('EVP_MD_CTX_free');
  end;


  if not assigned(EVP_DigestFinalXOF) then 
  begin
    {$if declared(EVP_DigestFinalXOF_introduced)}
    if LibVersion < EVP_DigestFinalXOF_introduced then
      {$if declared(FC_EVP_DigestFinalXOF)}
      EVP_DigestFinalXOF := @FC_EVP_DigestFinalXOF
      {$else}
      EVP_DigestFinalXOF := @ERR_EVP_DigestFinalXOF
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_DigestFinalXOF_removed)}
   if EVP_DigestFinalXOF_removed <= LibVersion then
     {$if declared(_EVP_DigestFinalXOF)}
     EVP_DigestFinalXOF := @_EVP_DigestFinalXOF
     {$else}
       {$IF declared(ERR_EVP_DigestFinalXOF)}
       EVP_DigestFinalXOF := @ERR_EVP_DigestFinalXOF
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_DigestFinalXOF) and Assigned(AFailed) then 
     AFailed.Add('EVP_DigestFinalXOF');
  end;


  if not assigned(EVP_DigestSign) then 
  begin
    {$if declared(EVP_DigestSign_introduced)}
    if LibVersion < EVP_DigestSign_introduced then
      {$if declared(FC_EVP_DigestSign)}
      EVP_DigestSign := @FC_EVP_DigestSign
      {$else}
      EVP_DigestSign := @ERR_EVP_DigestSign
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_DigestSign_removed)}
   if EVP_DigestSign_removed <= LibVersion then
     {$if declared(_EVP_DigestSign)}
     EVP_DigestSign := @_EVP_DigestSign
     {$else}
       {$IF declared(ERR_EVP_DigestSign)}
       EVP_DigestSign := @ERR_EVP_DigestSign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_DigestSign) and Assigned(AFailed) then 
     AFailed.Add('EVP_DigestSign');
  end;


  if not assigned(EVP_DigestVerify) then 
  begin
    {$if declared(EVP_DigestVerify_introduced)}
    if LibVersion < EVP_DigestVerify_introduced then
      {$if declared(FC_EVP_DigestVerify)}
      EVP_DigestVerify := @FC_EVP_DigestVerify
      {$else}
      EVP_DigestVerify := @ERR_EVP_DigestVerify
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_DigestVerify_removed)}
   if EVP_DigestVerify_removed <= LibVersion then
     {$if declared(_EVP_DigestVerify)}
     EVP_DigestVerify := @_EVP_DigestVerify
     {$else}
       {$IF declared(ERR_EVP_DigestVerify)}
       EVP_DigestVerify := @ERR_EVP_DigestVerify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_DigestVerify) and Assigned(AFailed) then 
     AFailed.Add('EVP_DigestVerify');
  end;


  if not assigned(EVP_ENCODE_CTX_new) then 
  begin
    {$if declared(EVP_ENCODE_CTX_new_introduced)}
    if LibVersion < EVP_ENCODE_CTX_new_introduced then
      {$if declared(FC_EVP_ENCODE_CTX_new)}
      EVP_ENCODE_CTX_new := @FC_EVP_ENCODE_CTX_new
      {$else}
      EVP_ENCODE_CTX_new := @ERR_EVP_ENCODE_CTX_new
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_ENCODE_CTX_new_removed)}
   if EVP_ENCODE_CTX_new_removed <= LibVersion then
     {$if declared(_EVP_ENCODE_CTX_new)}
     EVP_ENCODE_CTX_new := @_EVP_ENCODE_CTX_new
     {$else}
       {$IF declared(ERR_EVP_ENCODE_CTX_new)}
       EVP_ENCODE_CTX_new := @ERR_EVP_ENCODE_CTX_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_ENCODE_CTX_new) and Assigned(AFailed) then 
     AFailed.Add('EVP_ENCODE_CTX_new');
  end;


  if not assigned(EVP_ENCODE_CTX_free) then 
  begin
    {$if declared(EVP_ENCODE_CTX_free_introduced)}
    if LibVersion < EVP_ENCODE_CTX_free_introduced then
      {$if declared(FC_EVP_ENCODE_CTX_free)}
      EVP_ENCODE_CTX_free := @FC_EVP_ENCODE_CTX_free
      {$else}
      EVP_ENCODE_CTX_free := @ERR_EVP_ENCODE_CTX_free
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_ENCODE_CTX_free_removed)}
   if EVP_ENCODE_CTX_free_removed <= LibVersion then
     {$if declared(_EVP_ENCODE_CTX_free)}
     EVP_ENCODE_CTX_free := @_EVP_ENCODE_CTX_free
     {$else}
       {$IF declared(ERR_EVP_ENCODE_CTX_free)}
       EVP_ENCODE_CTX_free := @ERR_EVP_ENCODE_CTX_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_ENCODE_CTX_free) and Assigned(AFailed) then 
     AFailed.Add('EVP_ENCODE_CTX_free');
  end;


  if not assigned(EVP_ENCODE_CTX_copy) then 
  begin
    {$if declared(EVP_ENCODE_CTX_copy_introduced)}
    if LibVersion < EVP_ENCODE_CTX_copy_introduced then
      {$if declared(FC_EVP_ENCODE_CTX_copy)}
      EVP_ENCODE_CTX_copy := @FC_EVP_ENCODE_CTX_copy
      {$else}
      EVP_ENCODE_CTX_copy := @ERR_EVP_ENCODE_CTX_copy
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_ENCODE_CTX_copy_removed)}
   if EVP_ENCODE_CTX_copy_removed <= LibVersion then
     {$if declared(_EVP_ENCODE_CTX_copy)}
     EVP_ENCODE_CTX_copy := @_EVP_ENCODE_CTX_copy
     {$else}
       {$IF declared(ERR_EVP_ENCODE_CTX_copy)}
       EVP_ENCODE_CTX_copy := @ERR_EVP_ENCODE_CTX_copy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_ENCODE_CTX_copy) and Assigned(AFailed) then 
     AFailed.Add('EVP_ENCODE_CTX_copy');
  end;


  if not assigned(EVP_ENCODE_CTX_num) then 
  begin
    {$if declared(EVP_ENCODE_CTX_num_introduced)}
    if LibVersion < EVP_ENCODE_CTX_num_introduced then
      {$if declared(FC_EVP_ENCODE_CTX_num)}
      EVP_ENCODE_CTX_num := @FC_EVP_ENCODE_CTX_num
      {$else}
      EVP_ENCODE_CTX_num := @ERR_EVP_ENCODE_CTX_num
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_ENCODE_CTX_num_removed)}
   if EVP_ENCODE_CTX_num_removed <= LibVersion then
     {$if declared(_EVP_ENCODE_CTX_num)}
     EVP_ENCODE_CTX_num := @_EVP_ENCODE_CTX_num
     {$else}
       {$IF declared(ERR_EVP_ENCODE_CTX_num)}
       EVP_ENCODE_CTX_num := @ERR_EVP_ENCODE_CTX_num
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_ENCODE_CTX_num) and Assigned(AFailed) then 
     AFailed.Add('EVP_ENCODE_CTX_num');
  end;


  if not assigned(EVP_CIPHER_CTX_reset) then 
  begin
    {$if declared(EVP_CIPHER_CTX_reset_introduced)}
    if LibVersion < EVP_CIPHER_CTX_reset_introduced then
      {$if declared(FC_EVP_CIPHER_CTX_reset)}
      EVP_CIPHER_CTX_reset := @FC_EVP_CIPHER_CTX_reset
      {$else}
      EVP_CIPHER_CTX_reset := @ERR_EVP_CIPHER_CTX_reset
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_CTX_reset_removed)}
   if EVP_CIPHER_CTX_reset_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_CTX_reset)}
     EVP_CIPHER_CTX_reset := @_EVP_CIPHER_CTX_reset
     {$else}
       {$IF declared(ERR_EVP_CIPHER_CTX_reset)}
       EVP_CIPHER_CTX_reset := @ERR_EVP_CIPHER_CTX_reset
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_CTX_reset) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_CTX_reset');
  end;


  if not assigned(EVP_md5_sha1) then 
  begin
    {$if declared(EVP_md5_sha1_introduced)}
    if LibVersion < EVP_md5_sha1_introduced then
      {$if declared(FC_EVP_md5_sha1)}
      EVP_md5_sha1 := @FC_EVP_md5_sha1
      {$else}
      EVP_md5_sha1 := @ERR_EVP_md5_sha1
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_md5_sha1_removed)}
   if EVP_md5_sha1_removed <= LibVersion then
     {$if declared(_EVP_md5_sha1)}
     EVP_md5_sha1 := @_EVP_md5_sha1
     {$else}
       {$IF declared(ERR_EVP_md5_sha1)}
       EVP_md5_sha1 := @ERR_EVP_md5_sha1
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_md5_sha1) and Assigned(AFailed) then 
     AFailed.Add('EVP_md5_sha1');
  end;


  if not assigned(EVP_sha512_224) then 
  begin
    {$if declared(EVP_sha512_224_introduced)}
    if LibVersion < EVP_sha512_224_introduced then
      {$if declared(FC_EVP_sha512_224)}
      EVP_sha512_224 := @FC_EVP_sha512_224
      {$else}
      EVP_sha512_224 := @ERR_EVP_sha512_224
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha512_224_removed)}
   if EVP_sha512_224_removed <= LibVersion then
     {$if declared(_EVP_sha512_224)}
     EVP_sha512_224 := @_EVP_sha512_224
     {$else}
       {$IF declared(ERR_EVP_sha512_224)}
       EVP_sha512_224 := @ERR_EVP_sha512_224
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha512_224) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha512_224');
  end;


  if not assigned(EVP_sha512_256) then 
  begin
    {$if declared(EVP_sha512_256_introduced)}
    if LibVersion < EVP_sha512_256_introduced then
      {$if declared(FC_EVP_sha512_256)}
      EVP_sha512_256 := @FC_EVP_sha512_256
      {$else}
      EVP_sha512_256 := @ERR_EVP_sha512_256
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha512_256_removed)}
   if EVP_sha512_256_removed <= LibVersion then
     {$if declared(_EVP_sha512_256)}
     EVP_sha512_256 := @_EVP_sha512_256
     {$else}
       {$IF declared(ERR_EVP_sha512_256)}
       EVP_sha512_256 := @ERR_EVP_sha512_256
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha512_256) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha512_256');
  end;


  if not assigned(EVP_sha3_224) then 
  begin
    {$if declared(EVP_sha3_224_introduced)}
    if LibVersion < EVP_sha3_224_introduced then
      {$if declared(FC_EVP_sha3_224)}
      EVP_sha3_224 := @FC_EVP_sha3_224
      {$else}
      EVP_sha3_224 := @ERR_EVP_sha3_224
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha3_224_removed)}
   if EVP_sha3_224_removed <= LibVersion then
     {$if declared(_EVP_sha3_224)}
     EVP_sha3_224 := @_EVP_sha3_224
     {$else}
       {$IF declared(ERR_EVP_sha3_224)}
       EVP_sha3_224 := @ERR_EVP_sha3_224
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha3_224) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha3_224');
  end;


  if not assigned(EVP_sha3_256) then 
  begin
    {$if declared(EVP_sha3_256_introduced)}
    if LibVersion < EVP_sha3_256_introduced then
      {$if declared(FC_EVP_sha3_256)}
      EVP_sha3_256 := @FC_EVP_sha3_256
      {$else}
      EVP_sha3_256 := @ERR_EVP_sha3_256
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha3_256_removed)}
   if EVP_sha3_256_removed <= LibVersion then
     {$if declared(_EVP_sha3_256)}
     EVP_sha3_256 := @_EVP_sha3_256
     {$else}
       {$IF declared(ERR_EVP_sha3_256)}
       EVP_sha3_256 := @ERR_EVP_sha3_256
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha3_256) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha3_256');
  end;


  if not assigned(EVP_sha3_384) then 
  begin
    {$if declared(EVP_sha3_384_introduced)}
    if LibVersion < EVP_sha3_384_introduced then
      {$if declared(FC_EVP_sha3_384)}
      EVP_sha3_384 := @FC_EVP_sha3_384
      {$else}
      EVP_sha3_384 := @ERR_EVP_sha3_384
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha3_384_removed)}
   if EVP_sha3_384_removed <= LibVersion then
     {$if declared(_EVP_sha3_384)}
     EVP_sha3_384 := @_EVP_sha3_384
     {$else}
       {$IF declared(ERR_EVP_sha3_384)}
       EVP_sha3_384 := @ERR_EVP_sha3_384
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha3_384) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha3_384');
  end;


  if not assigned(EVP_sha3_512) then 
  begin
    {$if declared(EVP_sha3_512_introduced)}
    if LibVersion < EVP_sha3_512_introduced then
      {$if declared(FC_EVP_sha3_512)}
      EVP_sha3_512 := @FC_EVP_sha3_512
      {$else}
      EVP_sha3_512 := @ERR_EVP_sha3_512
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sha3_512_removed)}
   if EVP_sha3_512_removed <= LibVersion then
     {$if declared(_EVP_sha3_512)}
     EVP_sha3_512 := @_EVP_sha3_512
     {$else}
       {$IF declared(ERR_EVP_sha3_512)}
       EVP_sha3_512 := @ERR_EVP_sha3_512
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sha3_512) and Assigned(AFailed) then 
     AFailed.Add('EVP_sha3_512');
  end;


  if not assigned(EVP_shake128) then 
  begin
    {$if declared(EVP_shake128_introduced)}
    if LibVersion < EVP_shake128_introduced then
      {$if declared(FC_EVP_shake128)}
      EVP_shake128 := @FC_EVP_shake128
      {$else}
      EVP_shake128 := @ERR_EVP_shake128
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_shake128_removed)}
   if EVP_shake128_removed <= LibVersion then
     {$if declared(_EVP_shake128)}
     EVP_shake128 := @_EVP_shake128
     {$else}
       {$IF declared(ERR_EVP_shake128)}
       EVP_shake128 := @ERR_EVP_shake128
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_shake128) and Assigned(AFailed) then 
     AFailed.Add('EVP_shake128');
  end;


  if not assigned(EVP_shake256) then 
  begin
    {$if declared(EVP_shake256_introduced)}
    if LibVersion < EVP_shake256_introduced then
      {$if declared(FC_EVP_shake256)}
      EVP_shake256 := @FC_EVP_shake256
      {$else}
      EVP_shake256 := @ERR_EVP_shake256
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_shake256_removed)}
   if EVP_shake256_removed <= LibVersion then
     {$if declared(_EVP_shake256)}
     EVP_shake256 := @_EVP_shake256
     {$else}
       {$IF declared(ERR_EVP_shake256)}
       EVP_shake256 := @ERR_EVP_shake256
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_shake256) and Assigned(AFailed) then 
     AFailed.Add('EVP_shake256');
  end;


  if not assigned(EVP_aes_128_wrap_pad) then 
  begin
    {$if declared(EVP_aes_128_wrap_pad_introduced)}
    if LibVersion < EVP_aes_128_wrap_pad_introduced then
      {$if declared(FC_EVP_aes_128_wrap_pad)}
      EVP_aes_128_wrap_pad := @FC_EVP_aes_128_wrap_pad
      {$else}
      EVP_aes_128_wrap_pad := @ERR_EVP_aes_128_wrap_pad
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_128_wrap_pad_removed)}
   if EVP_aes_128_wrap_pad_removed <= LibVersion then
     {$if declared(_EVP_aes_128_wrap_pad)}
     EVP_aes_128_wrap_pad := @_EVP_aes_128_wrap_pad
     {$else}
       {$IF declared(ERR_EVP_aes_128_wrap_pad)}
       EVP_aes_128_wrap_pad := @ERR_EVP_aes_128_wrap_pad
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_128_wrap_pad) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_128_wrap_pad');
  end;


  if not assigned(EVP_aes_128_ocb) then 
  begin
    {$if declared(EVP_aes_128_ocb_introduced)}
    if LibVersion < EVP_aes_128_ocb_introduced then
      {$if declared(FC_EVP_aes_128_ocb)}
      EVP_aes_128_ocb := @FC_EVP_aes_128_ocb
      {$else}
      EVP_aes_128_ocb := @ERR_EVP_aes_128_ocb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_128_ocb_removed)}
   if EVP_aes_128_ocb_removed <= LibVersion then
     {$if declared(_EVP_aes_128_ocb)}
     EVP_aes_128_ocb := @_EVP_aes_128_ocb
     {$else}
       {$IF declared(ERR_EVP_aes_128_ocb)}
       EVP_aes_128_ocb := @ERR_EVP_aes_128_ocb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_128_ocb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_128_ocb');
  end;


  if not assigned(EVP_aes_192_wrap_pad) then 
  begin
    {$if declared(EVP_aes_192_wrap_pad_introduced)}
    if LibVersion < EVP_aes_192_wrap_pad_introduced then
      {$if declared(FC_EVP_aes_192_wrap_pad)}
      EVP_aes_192_wrap_pad := @FC_EVP_aes_192_wrap_pad
      {$else}
      EVP_aes_192_wrap_pad := @ERR_EVP_aes_192_wrap_pad
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_192_wrap_pad_removed)}
   if EVP_aes_192_wrap_pad_removed <= LibVersion then
     {$if declared(_EVP_aes_192_wrap_pad)}
     EVP_aes_192_wrap_pad := @_EVP_aes_192_wrap_pad
     {$else}
       {$IF declared(ERR_EVP_aes_192_wrap_pad)}
       EVP_aes_192_wrap_pad := @ERR_EVP_aes_192_wrap_pad
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_192_wrap_pad) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_192_wrap_pad');
  end;


  if not assigned(EVP_aes_192_ocb) then 
  begin
    {$if declared(EVP_aes_192_ocb_introduced)}
    if LibVersion < EVP_aes_192_ocb_introduced then
      {$if declared(FC_EVP_aes_192_ocb)}
      EVP_aes_192_ocb := @FC_EVP_aes_192_ocb
      {$else}
      EVP_aes_192_ocb := @ERR_EVP_aes_192_ocb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_192_ocb_removed)}
   if EVP_aes_192_ocb_removed <= LibVersion then
     {$if declared(_EVP_aes_192_ocb)}
     EVP_aes_192_ocb := @_EVP_aes_192_ocb
     {$else}
       {$IF declared(ERR_EVP_aes_192_ocb)}
       EVP_aes_192_ocb := @ERR_EVP_aes_192_ocb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_192_ocb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_192_ocb');
  end;


  if not assigned(EVP_aes_256_wrap_pad) then 
  begin
    {$if declared(EVP_aes_256_wrap_pad_introduced)}
    if LibVersion < EVP_aes_256_wrap_pad_introduced then
      {$if declared(FC_EVP_aes_256_wrap_pad)}
      EVP_aes_256_wrap_pad := @FC_EVP_aes_256_wrap_pad
      {$else}
      EVP_aes_256_wrap_pad := @ERR_EVP_aes_256_wrap_pad
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_256_wrap_pad_removed)}
   if EVP_aes_256_wrap_pad_removed <= LibVersion then
     {$if declared(_EVP_aes_256_wrap_pad)}
     EVP_aes_256_wrap_pad := @_EVP_aes_256_wrap_pad
     {$else}
       {$IF declared(ERR_EVP_aes_256_wrap_pad)}
       EVP_aes_256_wrap_pad := @ERR_EVP_aes_256_wrap_pad
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_256_wrap_pad) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_256_wrap_pad');
  end;


  if not assigned(EVP_aes_256_ocb) then 
  begin
    {$if declared(EVP_aes_256_ocb_introduced)}
    if LibVersion < EVP_aes_256_ocb_introduced then
      {$if declared(FC_EVP_aes_256_ocb)}
      EVP_aes_256_ocb := @FC_EVP_aes_256_ocb
      {$else}
      EVP_aes_256_ocb := @ERR_EVP_aes_256_ocb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aes_256_ocb_removed)}
   if EVP_aes_256_ocb_removed <= LibVersion then
     {$if declared(_EVP_aes_256_ocb)}
     EVP_aes_256_ocb := @_EVP_aes_256_ocb
     {$else}
       {$IF declared(ERR_EVP_aes_256_ocb)}
       EVP_aes_256_ocb := @ERR_EVP_aes_256_ocb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aes_256_ocb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aes_256_ocb');
  end;


  if not assigned(EVP_aria_128_ecb) then 
  begin
    {$if declared(EVP_aria_128_ecb_introduced)}
    if LibVersion < EVP_aria_128_ecb_introduced then
      {$if declared(FC_EVP_aria_128_ecb)}
      EVP_aria_128_ecb := @FC_EVP_aria_128_ecb
      {$else}
      EVP_aria_128_ecb := @ERR_EVP_aria_128_ecb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_ecb_removed)}
   if EVP_aria_128_ecb_removed <= LibVersion then
     {$if declared(_EVP_aria_128_ecb)}
     EVP_aria_128_ecb := @_EVP_aria_128_ecb
     {$else}
       {$IF declared(ERR_EVP_aria_128_ecb)}
       EVP_aria_128_ecb := @ERR_EVP_aria_128_ecb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_ecb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_ecb');
  end;


  if not assigned(EVP_aria_128_cbc) then 
  begin
    {$if declared(EVP_aria_128_cbc_introduced)}
    if LibVersion < EVP_aria_128_cbc_introduced then
      {$if declared(FC_EVP_aria_128_cbc)}
      EVP_aria_128_cbc := @FC_EVP_aria_128_cbc
      {$else}
      EVP_aria_128_cbc := @ERR_EVP_aria_128_cbc
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_cbc_removed)}
   if EVP_aria_128_cbc_removed <= LibVersion then
     {$if declared(_EVP_aria_128_cbc)}
     EVP_aria_128_cbc := @_EVP_aria_128_cbc
     {$else}
       {$IF declared(ERR_EVP_aria_128_cbc)}
       EVP_aria_128_cbc := @ERR_EVP_aria_128_cbc
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_cbc) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_cbc');
  end;


  if not assigned(EVP_aria_128_cfb1) then 
  begin
    {$if declared(EVP_aria_128_cfb1_introduced)}
    if LibVersion < EVP_aria_128_cfb1_introduced then
      {$if declared(FC_EVP_aria_128_cfb1)}
      EVP_aria_128_cfb1 := @FC_EVP_aria_128_cfb1
      {$else}
      EVP_aria_128_cfb1 := @ERR_EVP_aria_128_cfb1
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_cfb1_removed)}
   if EVP_aria_128_cfb1_removed <= LibVersion then
     {$if declared(_EVP_aria_128_cfb1)}
     EVP_aria_128_cfb1 := @_EVP_aria_128_cfb1
     {$else}
       {$IF declared(ERR_EVP_aria_128_cfb1)}
       EVP_aria_128_cfb1 := @ERR_EVP_aria_128_cfb1
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_cfb1) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_cfb1');
  end;


  if not assigned(EVP_aria_128_cfb8) then 
  begin
    {$if declared(EVP_aria_128_cfb8_introduced)}
    if LibVersion < EVP_aria_128_cfb8_introduced then
      {$if declared(FC_EVP_aria_128_cfb8)}
      EVP_aria_128_cfb8 := @FC_EVP_aria_128_cfb8
      {$else}
      EVP_aria_128_cfb8 := @ERR_EVP_aria_128_cfb8
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_cfb8_removed)}
   if EVP_aria_128_cfb8_removed <= LibVersion then
     {$if declared(_EVP_aria_128_cfb8)}
     EVP_aria_128_cfb8 := @_EVP_aria_128_cfb8
     {$else}
       {$IF declared(ERR_EVP_aria_128_cfb8)}
       EVP_aria_128_cfb8 := @ERR_EVP_aria_128_cfb8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_cfb8) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_cfb8');
  end;


  if not assigned(EVP_aria_128_cfb128) then 
  begin
    {$if declared(EVP_aria_128_cfb128_introduced)}
    if LibVersion < EVP_aria_128_cfb128_introduced then
      {$if declared(FC_EVP_aria_128_cfb128)}
      EVP_aria_128_cfb128 := @FC_EVP_aria_128_cfb128
      {$else}
      EVP_aria_128_cfb128 := @ERR_EVP_aria_128_cfb128
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_cfb128_removed)}
   if EVP_aria_128_cfb128_removed <= LibVersion then
     {$if declared(_EVP_aria_128_cfb128)}
     EVP_aria_128_cfb128 := @_EVP_aria_128_cfb128
     {$else}
       {$IF declared(ERR_EVP_aria_128_cfb128)}
       EVP_aria_128_cfb128 := @ERR_EVP_aria_128_cfb128
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_cfb128) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_cfb128');
  end;


  if not assigned(EVP_aria_128_ctr) then 
  begin
    {$if declared(EVP_aria_128_ctr_introduced)}
    if LibVersion < EVP_aria_128_ctr_introduced then
      {$if declared(FC_EVP_aria_128_ctr)}
      EVP_aria_128_ctr := @FC_EVP_aria_128_ctr
      {$else}
      EVP_aria_128_ctr := @ERR_EVP_aria_128_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_ctr_removed)}
   if EVP_aria_128_ctr_removed <= LibVersion then
     {$if declared(_EVP_aria_128_ctr)}
     EVP_aria_128_ctr := @_EVP_aria_128_ctr
     {$else}
       {$IF declared(ERR_EVP_aria_128_ctr)}
       EVP_aria_128_ctr := @ERR_EVP_aria_128_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_ctr');
  end;


  if not assigned(EVP_aria_128_ofb) then 
  begin
    {$if declared(EVP_aria_128_ofb_introduced)}
    if LibVersion < EVP_aria_128_ofb_introduced then
      {$if declared(FC_EVP_aria_128_ofb)}
      EVP_aria_128_ofb := @FC_EVP_aria_128_ofb
      {$else}
      EVP_aria_128_ofb := @ERR_EVP_aria_128_ofb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_ofb_removed)}
   if EVP_aria_128_ofb_removed <= LibVersion then
     {$if declared(_EVP_aria_128_ofb)}
     EVP_aria_128_ofb := @_EVP_aria_128_ofb
     {$else}
       {$IF declared(ERR_EVP_aria_128_ofb)}
       EVP_aria_128_ofb := @ERR_EVP_aria_128_ofb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_ofb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_ofb');
  end;


  if not assigned(EVP_aria_128_gcm) then 
  begin
    {$if declared(EVP_aria_128_gcm_introduced)}
    if LibVersion < EVP_aria_128_gcm_introduced then
      {$if declared(FC_EVP_aria_128_gcm)}
      EVP_aria_128_gcm := @FC_EVP_aria_128_gcm
      {$else}
      EVP_aria_128_gcm := @ERR_EVP_aria_128_gcm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_gcm_removed)}
   if EVP_aria_128_gcm_removed <= LibVersion then
     {$if declared(_EVP_aria_128_gcm)}
     EVP_aria_128_gcm := @_EVP_aria_128_gcm
     {$else}
       {$IF declared(ERR_EVP_aria_128_gcm)}
       EVP_aria_128_gcm := @ERR_EVP_aria_128_gcm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_gcm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_gcm');
  end;


  if not assigned(EVP_aria_128_ccm) then 
  begin
    {$if declared(EVP_aria_128_ccm_introduced)}
    if LibVersion < EVP_aria_128_ccm_introduced then
      {$if declared(FC_EVP_aria_128_ccm)}
      EVP_aria_128_ccm := @FC_EVP_aria_128_ccm
      {$else}
      EVP_aria_128_ccm := @ERR_EVP_aria_128_ccm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_128_ccm_removed)}
   if EVP_aria_128_ccm_removed <= LibVersion then
     {$if declared(_EVP_aria_128_ccm)}
     EVP_aria_128_ccm := @_EVP_aria_128_ccm
     {$else}
       {$IF declared(ERR_EVP_aria_128_ccm)}
       EVP_aria_128_ccm := @ERR_EVP_aria_128_ccm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_128_ccm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_128_ccm');
  end;


  if not assigned(EVP_aria_192_ecb) then 
  begin
    {$if declared(EVP_aria_192_ecb_introduced)}
    if LibVersion < EVP_aria_192_ecb_introduced then
      {$if declared(FC_EVP_aria_192_ecb)}
      EVP_aria_192_ecb := @FC_EVP_aria_192_ecb
      {$else}
      EVP_aria_192_ecb := @ERR_EVP_aria_192_ecb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_ecb_removed)}
   if EVP_aria_192_ecb_removed <= LibVersion then
     {$if declared(_EVP_aria_192_ecb)}
     EVP_aria_192_ecb := @_EVP_aria_192_ecb
     {$else}
       {$IF declared(ERR_EVP_aria_192_ecb)}
       EVP_aria_192_ecb := @ERR_EVP_aria_192_ecb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_ecb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_ecb');
  end;


  if not assigned(EVP_aria_192_cbc) then 
  begin
    {$if declared(EVP_aria_192_cbc_introduced)}
    if LibVersion < EVP_aria_192_cbc_introduced then
      {$if declared(FC_EVP_aria_192_cbc)}
      EVP_aria_192_cbc := @FC_EVP_aria_192_cbc
      {$else}
      EVP_aria_192_cbc := @ERR_EVP_aria_192_cbc
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_cbc_removed)}
   if EVP_aria_192_cbc_removed <= LibVersion then
     {$if declared(_EVP_aria_192_cbc)}
     EVP_aria_192_cbc := @_EVP_aria_192_cbc
     {$else}
       {$IF declared(ERR_EVP_aria_192_cbc)}
       EVP_aria_192_cbc := @ERR_EVP_aria_192_cbc
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_cbc) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_cbc');
  end;


  if not assigned(EVP_aria_192_cfb1) then 
  begin
    {$if declared(EVP_aria_192_cfb1_introduced)}
    if LibVersion < EVP_aria_192_cfb1_introduced then
      {$if declared(FC_EVP_aria_192_cfb1)}
      EVP_aria_192_cfb1 := @FC_EVP_aria_192_cfb1
      {$else}
      EVP_aria_192_cfb1 := @ERR_EVP_aria_192_cfb1
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_cfb1_removed)}
   if EVP_aria_192_cfb1_removed <= LibVersion then
     {$if declared(_EVP_aria_192_cfb1)}
     EVP_aria_192_cfb1 := @_EVP_aria_192_cfb1
     {$else}
       {$IF declared(ERR_EVP_aria_192_cfb1)}
       EVP_aria_192_cfb1 := @ERR_EVP_aria_192_cfb1
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_cfb1) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_cfb1');
  end;


  if not assigned(EVP_aria_192_cfb8) then 
  begin
    {$if declared(EVP_aria_192_cfb8_introduced)}
    if LibVersion < EVP_aria_192_cfb8_introduced then
      {$if declared(FC_EVP_aria_192_cfb8)}
      EVP_aria_192_cfb8 := @FC_EVP_aria_192_cfb8
      {$else}
      EVP_aria_192_cfb8 := @ERR_EVP_aria_192_cfb8
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_cfb8_removed)}
   if EVP_aria_192_cfb8_removed <= LibVersion then
     {$if declared(_EVP_aria_192_cfb8)}
     EVP_aria_192_cfb8 := @_EVP_aria_192_cfb8
     {$else}
       {$IF declared(ERR_EVP_aria_192_cfb8)}
       EVP_aria_192_cfb8 := @ERR_EVP_aria_192_cfb8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_cfb8) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_cfb8');
  end;


  if not assigned(EVP_aria_192_cfb128) then 
  begin
    {$if declared(EVP_aria_192_cfb128_introduced)}
    if LibVersion < EVP_aria_192_cfb128_introduced then
      {$if declared(FC_EVP_aria_192_cfb128)}
      EVP_aria_192_cfb128 := @FC_EVP_aria_192_cfb128
      {$else}
      EVP_aria_192_cfb128 := @ERR_EVP_aria_192_cfb128
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_cfb128_removed)}
   if EVP_aria_192_cfb128_removed <= LibVersion then
     {$if declared(_EVP_aria_192_cfb128)}
     EVP_aria_192_cfb128 := @_EVP_aria_192_cfb128
     {$else}
       {$IF declared(ERR_EVP_aria_192_cfb128)}
       EVP_aria_192_cfb128 := @ERR_EVP_aria_192_cfb128
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_cfb128) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_cfb128');
  end;


  if not assigned(EVP_aria_192_ctr) then 
  begin
    {$if declared(EVP_aria_192_ctr_introduced)}
    if LibVersion < EVP_aria_192_ctr_introduced then
      {$if declared(FC_EVP_aria_192_ctr)}
      EVP_aria_192_ctr := @FC_EVP_aria_192_ctr
      {$else}
      EVP_aria_192_ctr := @ERR_EVP_aria_192_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_ctr_removed)}
   if EVP_aria_192_ctr_removed <= LibVersion then
     {$if declared(_EVP_aria_192_ctr)}
     EVP_aria_192_ctr := @_EVP_aria_192_ctr
     {$else}
       {$IF declared(ERR_EVP_aria_192_ctr)}
       EVP_aria_192_ctr := @ERR_EVP_aria_192_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_ctr');
  end;


  if not assigned(EVP_aria_192_ofb) then 
  begin
    {$if declared(EVP_aria_192_ofb_introduced)}
    if LibVersion < EVP_aria_192_ofb_introduced then
      {$if declared(FC_EVP_aria_192_ofb)}
      EVP_aria_192_ofb := @FC_EVP_aria_192_ofb
      {$else}
      EVP_aria_192_ofb := @ERR_EVP_aria_192_ofb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_ofb_removed)}
   if EVP_aria_192_ofb_removed <= LibVersion then
     {$if declared(_EVP_aria_192_ofb)}
     EVP_aria_192_ofb := @_EVP_aria_192_ofb
     {$else}
       {$IF declared(ERR_EVP_aria_192_ofb)}
       EVP_aria_192_ofb := @ERR_EVP_aria_192_ofb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_ofb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_ofb');
  end;


  if not assigned(EVP_aria_192_gcm) then 
  begin
    {$if declared(EVP_aria_192_gcm_introduced)}
    if LibVersion < EVP_aria_192_gcm_introduced then
      {$if declared(FC_EVP_aria_192_gcm)}
      EVP_aria_192_gcm := @FC_EVP_aria_192_gcm
      {$else}
      EVP_aria_192_gcm := @ERR_EVP_aria_192_gcm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_gcm_removed)}
   if EVP_aria_192_gcm_removed <= LibVersion then
     {$if declared(_EVP_aria_192_gcm)}
     EVP_aria_192_gcm := @_EVP_aria_192_gcm
     {$else}
       {$IF declared(ERR_EVP_aria_192_gcm)}
       EVP_aria_192_gcm := @ERR_EVP_aria_192_gcm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_gcm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_gcm');
  end;


  if not assigned(EVP_aria_192_ccm) then 
  begin
    {$if declared(EVP_aria_192_ccm_introduced)}
    if LibVersion < EVP_aria_192_ccm_introduced then
      {$if declared(FC_EVP_aria_192_ccm)}
      EVP_aria_192_ccm := @FC_EVP_aria_192_ccm
      {$else}
      EVP_aria_192_ccm := @ERR_EVP_aria_192_ccm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_192_ccm_removed)}
   if EVP_aria_192_ccm_removed <= LibVersion then
     {$if declared(_EVP_aria_192_ccm)}
     EVP_aria_192_ccm := @_EVP_aria_192_ccm
     {$else}
       {$IF declared(ERR_EVP_aria_192_ccm)}
       EVP_aria_192_ccm := @ERR_EVP_aria_192_ccm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_192_ccm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_192_ccm');
  end;


  if not assigned(EVP_aria_256_ecb) then 
  begin
    {$if declared(EVP_aria_256_ecb_introduced)}
    if LibVersion < EVP_aria_256_ecb_introduced then
      {$if declared(FC_EVP_aria_256_ecb)}
      EVP_aria_256_ecb := @FC_EVP_aria_256_ecb
      {$else}
      EVP_aria_256_ecb := @ERR_EVP_aria_256_ecb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_ecb_removed)}
   if EVP_aria_256_ecb_removed <= LibVersion then
     {$if declared(_EVP_aria_256_ecb)}
     EVP_aria_256_ecb := @_EVP_aria_256_ecb
     {$else}
       {$IF declared(ERR_EVP_aria_256_ecb)}
       EVP_aria_256_ecb := @ERR_EVP_aria_256_ecb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_ecb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_ecb');
  end;


  if not assigned(EVP_aria_256_cbc) then 
  begin
    {$if declared(EVP_aria_256_cbc_introduced)}
    if LibVersion < EVP_aria_256_cbc_introduced then
      {$if declared(FC_EVP_aria_256_cbc)}
      EVP_aria_256_cbc := @FC_EVP_aria_256_cbc
      {$else}
      EVP_aria_256_cbc := @ERR_EVP_aria_256_cbc
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_cbc_removed)}
   if EVP_aria_256_cbc_removed <= LibVersion then
     {$if declared(_EVP_aria_256_cbc)}
     EVP_aria_256_cbc := @_EVP_aria_256_cbc
     {$else}
       {$IF declared(ERR_EVP_aria_256_cbc)}
       EVP_aria_256_cbc := @ERR_EVP_aria_256_cbc
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_cbc) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_cbc');
  end;


  if not assigned(EVP_aria_256_cfb1) then 
  begin
    {$if declared(EVP_aria_256_cfb1_introduced)}
    if LibVersion < EVP_aria_256_cfb1_introduced then
      {$if declared(FC_EVP_aria_256_cfb1)}
      EVP_aria_256_cfb1 := @FC_EVP_aria_256_cfb1
      {$else}
      EVP_aria_256_cfb1 := @ERR_EVP_aria_256_cfb1
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_cfb1_removed)}
   if EVP_aria_256_cfb1_removed <= LibVersion then
     {$if declared(_EVP_aria_256_cfb1)}
     EVP_aria_256_cfb1 := @_EVP_aria_256_cfb1
     {$else}
       {$IF declared(ERR_EVP_aria_256_cfb1)}
       EVP_aria_256_cfb1 := @ERR_EVP_aria_256_cfb1
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_cfb1) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_cfb1');
  end;


  if not assigned(EVP_aria_256_cfb8) then 
  begin
    {$if declared(EVP_aria_256_cfb8_introduced)}
    if LibVersion < EVP_aria_256_cfb8_introduced then
      {$if declared(FC_EVP_aria_256_cfb8)}
      EVP_aria_256_cfb8 := @FC_EVP_aria_256_cfb8
      {$else}
      EVP_aria_256_cfb8 := @ERR_EVP_aria_256_cfb8
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_cfb8_removed)}
   if EVP_aria_256_cfb8_removed <= LibVersion then
     {$if declared(_EVP_aria_256_cfb8)}
     EVP_aria_256_cfb8 := @_EVP_aria_256_cfb8
     {$else}
       {$IF declared(ERR_EVP_aria_256_cfb8)}
       EVP_aria_256_cfb8 := @ERR_EVP_aria_256_cfb8
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_cfb8) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_cfb8');
  end;


  if not assigned(EVP_aria_256_cfb128) then 
  begin
    {$if declared(EVP_aria_256_cfb128_introduced)}
    if LibVersion < EVP_aria_256_cfb128_introduced then
      {$if declared(FC_EVP_aria_256_cfb128)}
      EVP_aria_256_cfb128 := @FC_EVP_aria_256_cfb128
      {$else}
      EVP_aria_256_cfb128 := @ERR_EVP_aria_256_cfb128
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_cfb128_removed)}
   if EVP_aria_256_cfb128_removed <= LibVersion then
     {$if declared(_EVP_aria_256_cfb128)}
     EVP_aria_256_cfb128 := @_EVP_aria_256_cfb128
     {$else}
       {$IF declared(ERR_EVP_aria_256_cfb128)}
       EVP_aria_256_cfb128 := @ERR_EVP_aria_256_cfb128
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_cfb128) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_cfb128');
  end;


  if not assigned(EVP_aria_256_ctr) then 
  begin
    {$if declared(EVP_aria_256_ctr_introduced)}
    if LibVersion < EVP_aria_256_ctr_introduced then
      {$if declared(FC_EVP_aria_256_ctr)}
      EVP_aria_256_ctr := @FC_EVP_aria_256_ctr
      {$else}
      EVP_aria_256_ctr := @ERR_EVP_aria_256_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_ctr_removed)}
   if EVP_aria_256_ctr_removed <= LibVersion then
     {$if declared(_EVP_aria_256_ctr)}
     EVP_aria_256_ctr := @_EVP_aria_256_ctr
     {$else}
       {$IF declared(ERR_EVP_aria_256_ctr)}
       EVP_aria_256_ctr := @ERR_EVP_aria_256_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_ctr');
  end;


  if not assigned(EVP_aria_256_ofb) then 
  begin
    {$if declared(EVP_aria_256_ofb_introduced)}
    if LibVersion < EVP_aria_256_ofb_introduced then
      {$if declared(FC_EVP_aria_256_ofb)}
      EVP_aria_256_ofb := @FC_EVP_aria_256_ofb
      {$else}
      EVP_aria_256_ofb := @ERR_EVP_aria_256_ofb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_ofb_removed)}
   if EVP_aria_256_ofb_removed <= LibVersion then
     {$if declared(_EVP_aria_256_ofb)}
     EVP_aria_256_ofb := @_EVP_aria_256_ofb
     {$else}
       {$IF declared(ERR_EVP_aria_256_ofb)}
       EVP_aria_256_ofb := @ERR_EVP_aria_256_ofb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_ofb) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_ofb');
  end;


  if not assigned(EVP_aria_256_gcm) then 
  begin
    {$if declared(EVP_aria_256_gcm_introduced)}
    if LibVersion < EVP_aria_256_gcm_introduced then
      {$if declared(FC_EVP_aria_256_gcm)}
      EVP_aria_256_gcm := @FC_EVP_aria_256_gcm
      {$else}
      EVP_aria_256_gcm := @ERR_EVP_aria_256_gcm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_gcm_removed)}
   if EVP_aria_256_gcm_removed <= LibVersion then
     {$if declared(_EVP_aria_256_gcm)}
     EVP_aria_256_gcm := @_EVP_aria_256_gcm
     {$else}
       {$IF declared(ERR_EVP_aria_256_gcm)}
       EVP_aria_256_gcm := @ERR_EVP_aria_256_gcm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_gcm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_gcm');
  end;


  if not assigned(EVP_aria_256_ccm) then 
  begin
    {$if declared(EVP_aria_256_ccm_introduced)}
    if LibVersion < EVP_aria_256_ccm_introduced then
      {$if declared(FC_EVP_aria_256_ccm)}
      EVP_aria_256_ccm := @FC_EVP_aria_256_ccm
      {$else}
      EVP_aria_256_ccm := @ERR_EVP_aria_256_ccm
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_aria_256_ccm_removed)}
   if EVP_aria_256_ccm_removed <= LibVersion then
     {$if declared(_EVP_aria_256_ccm)}
     EVP_aria_256_ccm := @_EVP_aria_256_ccm
     {$else}
       {$IF declared(ERR_EVP_aria_256_ccm)}
       EVP_aria_256_ccm := @ERR_EVP_aria_256_ccm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_aria_256_ccm) and Assigned(AFailed) then 
     AFailed.Add('EVP_aria_256_ccm');
  end;


  if not assigned(EVP_camellia_128_ctr) then 
  begin
    {$if declared(EVP_camellia_128_ctr_introduced)}
    if LibVersion < EVP_camellia_128_ctr_introduced then
      {$if declared(FC_EVP_camellia_128_ctr)}
      EVP_camellia_128_ctr := @FC_EVP_camellia_128_ctr
      {$else}
      EVP_camellia_128_ctr := @ERR_EVP_camellia_128_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_camellia_128_ctr_removed)}
   if EVP_camellia_128_ctr_removed <= LibVersion then
     {$if declared(_EVP_camellia_128_ctr)}
     EVP_camellia_128_ctr := @_EVP_camellia_128_ctr
     {$else}
       {$IF declared(ERR_EVP_camellia_128_ctr)}
       EVP_camellia_128_ctr := @ERR_EVP_camellia_128_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_camellia_128_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_camellia_128_ctr');
  end;


  if not assigned(EVP_camellia_192_ctr) then 
  begin
    {$if declared(EVP_camellia_192_ctr_introduced)}
    if LibVersion < EVP_camellia_192_ctr_introduced then
      {$if declared(FC_EVP_camellia_192_ctr)}
      EVP_camellia_192_ctr := @FC_EVP_camellia_192_ctr
      {$else}
      EVP_camellia_192_ctr := @ERR_EVP_camellia_192_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_camellia_192_ctr_removed)}
   if EVP_camellia_192_ctr_removed <= LibVersion then
     {$if declared(_EVP_camellia_192_ctr)}
     EVP_camellia_192_ctr := @_EVP_camellia_192_ctr
     {$else}
       {$IF declared(ERR_EVP_camellia_192_ctr)}
       EVP_camellia_192_ctr := @ERR_EVP_camellia_192_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_camellia_192_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_camellia_192_ctr');
  end;


  if not assigned(EVP_camellia_256_ctr) then 
  begin
    {$if declared(EVP_camellia_256_ctr_introduced)}
    if LibVersion < EVP_camellia_256_ctr_introduced then
      {$if declared(FC_EVP_camellia_256_ctr)}
      EVP_camellia_256_ctr := @FC_EVP_camellia_256_ctr
      {$else}
      EVP_camellia_256_ctr := @ERR_EVP_camellia_256_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_camellia_256_ctr_removed)}
   if EVP_camellia_256_ctr_removed <= LibVersion then
     {$if declared(_EVP_camellia_256_ctr)}
     EVP_camellia_256_ctr := @_EVP_camellia_256_ctr
     {$else}
       {$IF declared(ERR_EVP_camellia_256_ctr)}
       EVP_camellia_256_ctr := @ERR_EVP_camellia_256_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_camellia_256_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_camellia_256_ctr');
  end;


  if not assigned(EVP_chacha20) then 
  begin
    {$if declared(EVP_chacha20_introduced)}
    if LibVersion < EVP_chacha20_introduced then
      {$if declared(FC_EVP_chacha20)}
      EVP_chacha20 := @FC_EVP_chacha20
      {$else}
      EVP_chacha20 := @ERR_EVP_chacha20
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_chacha20_removed)}
   if EVP_chacha20_removed <= LibVersion then
     {$if declared(_EVP_chacha20)}
     EVP_chacha20 := @_EVP_chacha20
     {$else}
       {$IF declared(ERR_EVP_chacha20)}
       EVP_chacha20 := @ERR_EVP_chacha20
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_chacha20) and Assigned(AFailed) then 
     AFailed.Add('EVP_chacha20');
  end;


  if not assigned(EVP_chacha20_poly1305) then 
  begin
    {$if declared(EVP_chacha20_poly1305_introduced)}
    if LibVersion < EVP_chacha20_poly1305_introduced then
      {$if declared(FC_EVP_chacha20_poly1305)}
      EVP_chacha20_poly1305 := @FC_EVP_chacha20_poly1305
      {$else}
      EVP_chacha20_poly1305 := @ERR_EVP_chacha20_poly1305
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_chacha20_poly1305_removed)}
   if EVP_chacha20_poly1305_removed <= LibVersion then
     {$if declared(_EVP_chacha20_poly1305)}
     EVP_chacha20_poly1305 := @_EVP_chacha20_poly1305
     {$else}
       {$IF declared(ERR_EVP_chacha20_poly1305)}
       EVP_chacha20_poly1305 := @ERR_EVP_chacha20_poly1305
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_chacha20_poly1305) and Assigned(AFailed) then 
     AFailed.Add('EVP_chacha20_poly1305');
  end;


  if not assigned(EVP_sm4_ecb) then 
  begin
    {$if declared(EVP_sm4_ecb_introduced)}
    if LibVersion < EVP_sm4_ecb_introduced then
      {$if declared(FC_EVP_sm4_ecb)}
      EVP_sm4_ecb := @FC_EVP_sm4_ecb
      {$else}
      EVP_sm4_ecb := @ERR_EVP_sm4_ecb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sm4_ecb_removed)}
   if EVP_sm4_ecb_removed <= LibVersion then
     {$if declared(_EVP_sm4_ecb)}
     EVP_sm4_ecb := @_EVP_sm4_ecb
     {$else}
       {$IF declared(ERR_EVP_sm4_ecb)}
       EVP_sm4_ecb := @ERR_EVP_sm4_ecb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sm4_ecb) and Assigned(AFailed) then 
     AFailed.Add('EVP_sm4_ecb');
  end;


  if not assigned(EVP_sm4_cbc) then 
  begin
    {$if declared(EVP_sm4_cbc_introduced)}
    if LibVersion < EVP_sm4_cbc_introduced then
      {$if declared(FC_EVP_sm4_cbc)}
      EVP_sm4_cbc := @FC_EVP_sm4_cbc
      {$else}
      EVP_sm4_cbc := @ERR_EVP_sm4_cbc
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sm4_cbc_removed)}
   if EVP_sm4_cbc_removed <= LibVersion then
     {$if declared(_EVP_sm4_cbc)}
     EVP_sm4_cbc := @_EVP_sm4_cbc
     {$else}
       {$IF declared(ERR_EVP_sm4_cbc)}
       EVP_sm4_cbc := @ERR_EVP_sm4_cbc
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sm4_cbc) and Assigned(AFailed) then 
     AFailed.Add('EVP_sm4_cbc');
  end;


  if not assigned(EVP_sm4_cfb128) then 
  begin
    {$if declared(EVP_sm4_cfb128_introduced)}
    if LibVersion < EVP_sm4_cfb128_introduced then
      {$if declared(FC_EVP_sm4_cfb128)}
      EVP_sm4_cfb128 := @FC_EVP_sm4_cfb128
      {$else}
      EVP_sm4_cfb128 := @ERR_EVP_sm4_cfb128
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sm4_cfb128_removed)}
   if EVP_sm4_cfb128_removed <= LibVersion then
     {$if declared(_EVP_sm4_cfb128)}
     EVP_sm4_cfb128 := @_EVP_sm4_cfb128
     {$else}
       {$IF declared(ERR_EVP_sm4_cfb128)}
       EVP_sm4_cfb128 := @ERR_EVP_sm4_cfb128
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sm4_cfb128) and Assigned(AFailed) then 
     AFailed.Add('EVP_sm4_cfb128');
  end;


  if not assigned(EVP_sm4_ofb) then 
  begin
    {$if declared(EVP_sm4_ofb_introduced)}
    if LibVersion < EVP_sm4_ofb_introduced then
      {$if declared(FC_EVP_sm4_ofb)}
      EVP_sm4_ofb := @FC_EVP_sm4_ofb
      {$else}
      EVP_sm4_ofb := @ERR_EVP_sm4_ofb
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sm4_ofb_removed)}
   if EVP_sm4_ofb_removed <= LibVersion then
     {$if declared(_EVP_sm4_ofb)}
     EVP_sm4_ofb := @_EVP_sm4_ofb
     {$else}
       {$IF declared(ERR_EVP_sm4_ofb)}
       EVP_sm4_ofb := @ERR_EVP_sm4_ofb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sm4_ofb) and Assigned(AFailed) then 
     AFailed.Add('EVP_sm4_ofb');
  end;


  if not assigned(EVP_sm4_ctr) then 
  begin
    {$if declared(EVP_sm4_ctr_introduced)}
    if LibVersion < EVP_sm4_ctr_introduced then
      {$if declared(FC_EVP_sm4_ctr)}
      EVP_sm4_ctr := @FC_EVP_sm4_ctr
      {$else}
      EVP_sm4_ctr := @ERR_EVP_sm4_ctr
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_sm4_ctr_removed)}
   if EVP_sm4_ctr_removed <= LibVersion then
     {$if declared(_EVP_sm4_ctr)}
     EVP_sm4_ctr := @_EVP_sm4_ctr
     {$else}
       {$IF declared(ERR_EVP_sm4_ctr)}
       EVP_sm4_ctr := @ERR_EVP_sm4_ctr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_sm4_ctr) and Assigned(AFailed) then 
     AFailed.Add('EVP_sm4_ctr');
  end;


  if not assigned(EVP_PKEY_id) then 
  begin
    {$if declared(EVP_PKEY_id_introduced)}
    if LibVersion < EVP_PKEY_id_introduced then
      {$if declared(FC_EVP_PKEY_id)}
      EVP_PKEY_id := @FC_EVP_PKEY_id
      {$else}
      EVP_PKEY_id := @ERR_EVP_PKEY_id
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_id_removed)}
   if EVP_PKEY_id_removed <= LibVersion then
     {$if declared(_EVP_PKEY_id)}
     EVP_PKEY_id := @_EVP_PKEY_id
     {$else}
       {$IF declared(ERR_EVP_PKEY_id)}
       EVP_PKEY_id := @ERR_EVP_PKEY_id
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_id) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_id');
  end;


  if not assigned(EVP_PKEY_base_id) then 
  begin
    {$if declared(EVP_PKEY_base_id_introduced)}
    if LibVersion < EVP_PKEY_base_id_introduced then
      {$if declared(FC_EVP_PKEY_base_id)}
      EVP_PKEY_base_id := @FC_EVP_PKEY_base_id
      {$else}
      EVP_PKEY_base_id := @ERR_EVP_PKEY_base_id
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_base_id_removed)}
   if EVP_PKEY_base_id_removed <= LibVersion then
     {$if declared(_EVP_PKEY_base_id)}
     EVP_PKEY_base_id := @_EVP_PKEY_base_id
     {$else}
       {$IF declared(ERR_EVP_PKEY_base_id)}
       EVP_PKEY_base_id := @ERR_EVP_PKEY_base_id
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_base_id) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_base_id');
  end;


  if not assigned(EVP_PKEY_bits) then 
  begin
    {$if declared(EVP_PKEY_bits_introduced)}
    if LibVersion < EVP_PKEY_bits_introduced then
      {$if declared(FC_EVP_PKEY_bits)}
      EVP_PKEY_bits := @FC_EVP_PKEY_bits
      {$else}
      EVP_PKEY_bits := @ERR_EVP_PKEY_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_bits_removed)}
   if EVP_PKEY_bits_removed <= LibVersion then
     {$if declared(_EVP_PKEY_bits)}
     EVP_PKEY_bits := @_EVP_PKEY_bits
     {$else}
       {$IF declared(ERR_EVP_PKEY_bits)}
       EVP_PKEY_bits := @ERR_EVP_PKEY_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_bits) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_bits');
  end;


  if not assigned(EVP_PKEY_security_bits) then 
  begin
    {$if declared(EVP_PKEY_security_bits_introduced)}
    if LibVersion < EVP_PKEY_security_bits_introduced then
      {$if declared(FC_EVP_PKEY_security_bits)}
      EVP_PKEY_security_bits := @FC_EVP_PKEY_security_bits
      {$else}
      EVP_PKEY_security_bits := @ERR_EVP_PKEY_security_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_security_bits_removed)}
   if EVP_PKEY_security_bits_removed <= LibVersion then
     {$if declared(_EVP_PKEY_security_bits)}
     EVP_PKEY_security_bits := @_EVP_PKEY_security_bits
     {$else}
       {$IF declared(ERR_EVP_PKEY_security_bits)}
       EVP_PKEY_security_bits := @ERR_EVP_PKEY_security_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_security_bits) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_security_bits');
  end;


  if not assigned(EVP_PKEY_size) then 
  begin
    {$if declared(EVP_PKEY_size_introduced)}
    if LibVersion < EVP_PKEY_size_introduced then
      {$if declared(FC_EVP_PKEY_size)}
      EVP_PKEY_size := @FC_EVP_PKEY_size
      {$else}
      EVP_PKEY_size := @ERR_EVP_PKEY_size
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_size_removed)}
   if EVP_PKEY_size_removed <= LibVersion then
     {$if declared(_EVP_PKEY_size)}
     EVP_PKEY_size := @_EVP_PKEY_size
     {$else}
       {$IF declared(ERR_EVP_PKEY_size)}
       EVP_PKEY_size := @ERR_EVP_PKEY_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_size) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_size');
  end;


  if not assigned(EVP_PKEY_set_alias_type) then 
  begin
    {$if declared(EVP_PKEY_set_alias_type_introduced)}
    if LibVersion < EVP_PKEY_set_alias_type_introduced then
      {$if declared(FC_EVP_PKEY_set_alias_type)}
      EVP_PKEY_set_alias_type := @FC_EVP_PKEY_set_alias_type
      {$else}
      EVP_PKEY_set_alias_type := @ERR_EVP_PKEY_set_alias_type
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_set_alias_type_removed)}
   if EVP_PKEY_set_alias_type_removed <= LibVersion then
     {$if declared(_EVP_PKEY_set_alias_type)}
     EVP_PKEY_set_alias_type := @_EVP_PKEY_set_alias_type
     {$else}
       {$IF declared(ERR_EVP_PKEY_set_alias_type)}
       EVP_PKEY_set_alias_type := @ERR_EVP_PKEY_set_alias_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_set_alias_type) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_set_alias_type');
  end;


  if not assigned(EVP_PKEY_set1_engine) then 
  begin
    {$if declared(EVP_PKEY_set1_engine_introduced)}
    if LibVersion < EVP_PKEY_set1_engine_introduced then
      {$if declared(FC_EVP_PKEY_set1_engine)}
      EVP_PKEY_set1_engine := @FC_EVP_PKEY_set1_engine
      {$else}
      EVP_PKEY_set1_engine := @ERR_EVP_PKEY_set1_engine
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_set1_engine_removed)}
   if EVP_PKEY_set1_engine_removed <= LibVersion then
     {$if declared(_EVP_PKEY_set1_engine)}
     EVP_PKEY_set1_engine := @_EVP_PKEY_set1_engine
     {$else}
       {$IF declared(ERR_EVP_PKEY_set1_engine)}
       EVP_PKEY_set1_engine := @ERR_EVP_PKEY_set1_engine
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_set1_engine) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_set1_engine');
  end;


  if not assigned(EVP_PKEY_get0_engine) then 
  begin
    {$if declared(EVP_PKEY_get0_engine_introduced)}
    if LibVersion < EVP_PKEY_get0_engine_introduced then
      {$if declared(FC_EVP_PKEY_get0_engine)}
      EVP_PKEY_get0_engine := @FC_EVP_PKEY_get0_engine
      {$else}
      EVP_PKEY_get0_engine := @ERR_EVP_PKEY_get0_engine
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_engine_removed)}
   if EVP_PKEY_get0_engine_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_engine)}
     EVP_PKEY_get0_engine := @_EVP_PKEY_get0_engine
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_engine)}
       EVP_PKEY_get0_engine := @ERR_EVP_PKEY_get0_engine
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_engine) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_engine');
  end;


  if not assigned(EVP_PKEY_get0_hmac) then 
  begin
    {$if declared(EVP_PKEY_get0_hmac_introduced)}
    if LibVersion < EVP_PKEY_get0_hmac_introduced then
      {$if declared(FC_EVP_PKEY_get0_hmac)}
      EVP_PKEY_get0_hmac := @FC_EVP_PKEY_get0_hmac
      {$else}
      EVP_PKEY_get0_hmac := @ERR_EVP_PKEY_get0_hmac
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_hmac_removed)}
   if EVP_PKEY_get0_hmac_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_hmac)}
     EVP_PKEY_get0_hmac := @_EVP_PKEY_get0_hmac
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_hmac)}
       EVP_PKEY_get0_hmac := @ERR_EVP_PKEY_get0_hmac
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_hmac) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_hmac');
  end;


  if not assigned(EVP_PKEY_get0_poly1305) then 
  begin
    {$if declared(EVP_PKEY_get0_poly1305_introduced)}
    if LibVersion < EVP_PKEY_get0_poly1305_introduced then
      {$if declared(FC_EVP_PKEY_get0_poly1305)}
      EVP_PKEY_get0_poly1305 := @FC_EVP_PKEY_get0_poly1305
      {$else}
      EVP_PKEY_get0_poly1305 := @ERR_EVP_PKEY_get0_poly1305
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_poly1305_removed)}
   if EVP_PKEY_get0_poly1305_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_poly1305)}
     EVP_PKEY_get0_poly1305 := @_EVP_PKEY_get0_poly1305
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_poly1305)}
       EVP_PKEY_get0_poly1305 := @ERR_EVP_PKEY_get0_poly1305
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_poly1305) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_poly1305');
  end;


  if not assigned(EVP_PKEY_get0_siphash) then 
  begin
    {$if declared(EVP_PKEY_get0_siphash_introduced)}
    if LibVersion < EVP_PKEY_get0_siphash_introduced then
      {$if declared(FC_EVP_PKEY_get0_siphash)}
      EVP_PKEY_get0_siphash := @FC_EVP_PKEY_get0_siphash
      {$else}
      EVP_PKEY_get0_siphash := @ERR_EVP_PKEY_get0_siphash
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_siphash_removed)}
   if EVP_PKEY_get0_siphash_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_siphash)}
     EVP_PKEY_get0_siphash := @_EVP_PKEY_get0_siphash
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_siphash)}
       EVP_PKEY_get0_siphash := @ERR_EVP_PKEY_get0_siphash
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_siphash) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_siphash');
  end;


  if not assigned(EVP_PKEY_get0_RSA) then 
  begin
    {$if declared(EVP_PKEY_get0_RSA_introduced)}
    if LibVersion < EVP_PKEY_get0_RSA_introduced then
      {$if declared(FC_EVP_PKEY_get0_RSA)}
      EVP_PKEY_get0_RSA := @FC_EVP_PKEY_get0_RSA
      {$else}
      EVP_PKEY_get0_RSA := @ERR_EVP_PKEY_get0_RSA
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_RSA_removed)}
   if EVP_PKEY_get0_RSA_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_RSA)}
     EVP_PKEY_get0_RSA := @_EVP_PKEY_get0_RSA
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_RSA)}
       EVP_PKEY_get0_RSA := @ERR_EVP_PKEY_get0_RSA
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_RSA) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_RSA');
  end;


  if not assigned(EVP_PKEY_get0_DSA) then 
  begin
    {$if declared(EVP_PKEY_get0_DSA_introduced)}
    if LibVersion < EVP_PKEY_get0_DSA_introduced then
      {$if declared(FC_EVP_PKEY_get0_DSA)}
      EVP_PKEY_get0_DSA := @FC_EVP_PKEY_get0_DSA
      {$else}
      EVP_PKEY_get0_DSA := @ERR_EVP_PKEY_get0_DSA
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_DSA_removed)}
   if EVP_PKEY_get0_DSA_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_DSA)}
     EVP_PKEY_get0_DSA := @_EVP_PKEY_get0_DSA
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_DSA)}
       EVP_PKEY_get0_DSA := @ERR_EVP_PKEY_get0_DSA
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_DSA) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_DSA');
  end;


  if not assigned(EVP_PKEY_get0_DH) then 
  begin
    {$if declared(EVP_PKEY_get0_DH_introduced)}
    if LibVersion < EVP_PKEY_get0_DH_introduced then
      {$if declared(FC_EVP_PKEY_get0_DH)}
      EVP_PKEY_get0_DH := @FC_EVP_PKEY_get0_DH
      {$else}
      EVP_PKEY_get0_DH := @ERR_EVP_PKEY_get0_DH
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_DH_removed)}
   if EVP_PKEY_get0_DH_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_DH)}
     EVP_PKEY_get0_DH := @_EVP_PKEY_get0_DH
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_DH)}
       EVP_PKEY_get0_DH := @ERR_EVP_PKEY_get0_DH
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_DH) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_DH');
  end;


  if not assigned(EVP_PKEY_get0_EC_KEY) then 
  begin
    {$if declared(EVP_PKEY_get0_EC_KEY_introduced)}
    if LibVersion < EVP_PKEY_get0_EC_KEY_introduced then
      {$if declared(FC_EVP_PKEY_get0_EC_KEY)}
      EVP_PKEY_get0_EC_KEY := @FC_EVP_PKEY_get0_EC_KEY
      {$else}
      EVP_PKEY_get0_EC_KEY := @ERR_EVP_PKEY_get0_EC_KEY
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get0_EC_KEY_removed)}
   if EVP_PKEY_get0_EC_KEY_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get0_EC_KEY)}
     EVP_PKEY_get0_EC_KEY := @_EVP_PKEY_get0_EC_KEY
     {$else}
       {$IF declared(ERR_EVP_PKEY_get0_EC_KEY)}
       EVP_PKEY_get0_EC_KEY := @ERR_EVP_PKEY_get0_EC_KEY
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get0_EC_KEY) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get0_EC_KEY');
  end;


  if not assigned(EVP_PKEY_up_ref) then 
  begin
    {$if declared(EVP_PKEY_up_ref_introduced)}
    if LibVersion < EVP_PKEY_up_ref_introduced then
      {$if declared(FC_EVP_PKEY_up_ref)}
      EVP_PKEY_up_ref := @FC_EVP_PKEY_up_ref
      {$else}
      EVP_PKEY_up_ref := @ERR_EVP_PKEY_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_up_ref_removed)}
   if EVP_PKEY_up_ref_removed <= LibVersion then
     {$if declared(_EVP_PKEY_up_ref)}
     EVP_PKEY_up_ref := @_EVP_PKEY_up_ref
     {$else}
       {$IF declared(ERR_EVP_PKEY_up_ref)}
       EVP_PKEY_up_ref := @ERR_EVP_PKEY_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_up_ref) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_up_ref');
  end;


  if not assigned(EVP_PKEY_set1_tls_encodedpoint) then 
  begin
    {$if declared(EVP_PKEY_set1_tls_encodedpoint_introduced)}
    if LibVersion < EVP_PKEY_set1_tls_encodedpoint_introduced then
      {$if declared(FC_EVP_PKEY_set1_tls_encodedpoint)}
      EVP_PKEY_set1_tls_encodedpoint := @FC_EVP_PKEY_set1_tls_encodedpoint
      {$else}
      EVP_PKEY_set1_tls_encodedpoint := @ERR_EVP_PKEY_set1_tls_encodedpoint
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_set1_tls_encodedpoint_removed)}
   if EVP_PKEY_set1_tls_encodedpoint_removed <= LibVersion then
     {$if declared(_EVP_PKEY_set1_tls_encodedpoint)}
     EVP_PKEY_set1_tls_encodedpoint := @_EVP_PKEY_set1_tls_encodedpoint
     {$else}
       {$IF declared(ERR_EVP_PKEY_set1_tls_encodedpoint)}
       EVP_PKEY_set1_tls_encodedpoint := @ERR_EVP_PKEY_set1_tls_encodedpoint
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_set1_tls_encodedpoint) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_set1_tls_encodedpoint');
  end;


  if not assigned(EVP_PKEY_get1_tls_encodedpoint) then 
  begin
    {$if declared(EVP_PKEY_get1_tls_encodedpoint_introduced)}
    if LibVersion < EVP_PKEY_get1_tls_encodedpoint_introduced then
      {$if declared(FC_EVP_PKEY_get1_tls_encodedpoint)}
      EVP_PKEY_get1_tls_encodedpoint := @FC_EVP_PKEY_get1_tls_encodedpoint
      {$else}
      EVP_PKEY_get1_tls_encodedpoint := @ERR_EVP_PKEY_get1_tls_encodedpoint
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get1_tls_encodedpoint_removed)}
   if EVP_PKEY_get1_tls_encodedpoint_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get1_tls_encodedpoint)}
     EVP_PKEY_get1_tls_encodedpoint := @_EVP_PKEY_get1_tls_encodedpoint
     {$else}
       {$IF declared(ERR_EVP_PKEY_get1_tls_encodedpoint)}
       EVP_PKEY_get1_tls_encodedpoint := @ERR_EVP_PKEY_get1_tls_encodedpoint
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get1_tls_encodedpoint) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get1_tls_encodedpoint');
  end;


  if not assigned(EVP_CIPHER_type) then 
  begin
    {$if declared(EVP_CIPHER_type_introduced)}
    if LibVersion < EVP_CIPHER_type_introduced then
      {$if declared(FC_EVP_CIPHER_type)}
      EVP_CIPHER_type := @FC_EVP_CIPHER_type
      {$else}
      EVP_CIPHER_type := @ERR_EVP_CIPHER_type
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_CIPHER_type_removed)}
   if EVP_CIPHER_type_removed <= LibVersion then
     {$if declared(_EVP_CIPHER_type)}
     EVP_CIPHER_type := @_EVP_CIPHER_type
     {$else}
       {$IF declared(ERR_EVP_CIPHER_type)}
       EVP_CIPHER_type := @ERR_EVP_CIPHER_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_CIPHER_type) and Assigned(AFailed) then 
     AFailed.Add('EVP_CIPHER_type');
  end;


  if not assigned(EVP_PBE_scrypt) then 
  begin
    {$if declared(EVP_PBE_scrypt_introduced)}
    if LibVersion < EVP_PBE_scrypt_introduced then
      {$if declared(FC_EVP_PBE_scrypt)}
      EVP_PBE_scrypt := @FC_EVP_PBE_scrypt
      {$else}
      EVP_PBE_scrypt := @ERR_EVP_PBE_scrypt
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PBE_scrypt_removed)}
   if EVP_PBE_scrypt_removed <= LibVersion then
     {$if declared(_EVP_PBE_scrypt)}
     EVP_PBE_scrypt := @_EVP_PBE_scrypt
     {$else}
       {$IF declared(ERR_EVP_PBE_scrypt)}
       EVP_PBE_scrypt := @ERR_EVP_PBE_scrypt
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PBE_scrypt) and Assigned(AFailed) then 
     AFailed.Add('EVP_PBE_scrypt');
  end;


  if not assigned(PKCS5_v2_scrypt_keyivgen) then 
  begin
    {$if declared(PKCS5_v2_scrypt_keyivgen_introduced)}
    if LibVersion < PKCS5_v2_scrypt_keyivgen_introduced then
      {$if declared(FC_PKCS5_v2_scrypt_keyivgen)}
      PKCS5_v2_scrypt_keyivgen := @FC_PKCS5_v2_scrypt_keyivgen
      {$else}
      PKCS5_v2_scrypt_keyivgen := @ERR_PKCS5_v2_scrypt_keyivgen
      {$ifend}
    else
    {$ifend}
   {$if declared(PKCS5_v2_scrypt_keyivgen_removed)}
   if PKCS5_v2_scrypt_keyivgen_removed <= LibVersion then
     {$if declared(_PKCS5_v2_scrypt_keyivgen)}
     PKCS5_v2_scrypt_keyivgen := @_PKCS5_v2_scrypt_keyivgen
     {$else}
       {$IF declared(ERR_PKCS5_v2_scrypt_keyivgen)}
       PKCS5_v2_scrypt_keyivgen := @ERR_PKCS5_v2_scrypt_keyivgen
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(PKCS5_v2_scrypt_keyivgen) and Assigned(AFailed) then 
     AFailed.Add('PKCS5_v2_scrypt_keyivgen');
  end;


  if not assigned(EVP_PBE_get) then 
  begin
    {$if declared(EVP_PBE_get_introduced)}
    if LibVersion < EVP_PBE_get_introduced then
      {$if declared(FC_EVP_PBE_get)}
      EVP_PBE_get := @FC_EVP_PBE_get
      {$else}
      EVP_PBE_get := @ERR_EVP_PBE_get
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PBE_get_removed)}
   if EVP_PBE_get_removed <= LibVersion then
     {$if declared(_EVP_PBE_get)}
     EVP_PBE_get := @_EVP_PBE_get
     {$else}
       {$IF declared(ERR_EVP_PBE_get)}
       EVP_PBE_get := @ERR_EVP_PBE_get
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PBE_get) and Assigned(AFailed) then 
     AFailed.Add('EVP_PBE_get');
  end;


  if not assigned(EVP_PKEY_asn1_set_siginf) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_siginf_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_siginf_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_siginf)}
      EVP_PKEY_asn1_set_siginf := @FC_EVP_PKEY_asn1_set_siginf
      {$else}
      EVP_PKEY_asn1_set_siginf := @ERR_EVP_PKEY_asn1_set_siginf
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_siginf_removed)}
   if EVP_PKEY_asn1_set_siginf_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_siginf)}
     EVP_PKEY_asn1_set_siginf := @_EVP_PKEY_asn1_set_siginf
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_siginf)}
       EVP_PKEY_asn1_set_siginf := @ERR_EVP_PKEY_asn1_set_siginf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_siginf) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_siginf');
  end;


  if not assigned(EVP_PKEY_asn1_set_check) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_check_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_check_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_check)}
      EVP_PKEY_asn1_set_check := @FC_EVP_PKEY_asn1_set_check
      {$else}
      EVP_PKEY_asn1_set_check := @ERR_EVP_PKEY_asn1_set_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_check_removed)}
   if EVP_PKEY_asn1_set_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_check)}
     EVP_PKEY_asn1_set_check := @_EVP_PKEY_asn1_set_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_check)}
       EVP_PKEY_asn1_set_check := @ERR_EVP_PKEY_asn1_set_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_check');
  end;


  if not assigned(EVP_PKEY_asn1_set_public_check) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_public_check_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_public_check_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_public_check)}
      EVP_PKEY_asn1_set_public_check := @FC_EVP_PKEY_asn1_set_public_check
      {$else}
      EVP_PKEY_asn1_set_public_check := @ERR_EVP_PKEY_asn1_set_public_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_public_check_removed)}
   if EVP_PKEY_asn1_set_public_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_public_check)}
     EVP_PKEY_asn1_set_public_check := @_EVP_PKEY_asn1_set_public_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_public_check)}
       EVP_PKEY_asn1_set_public_check := @ERR_EVP_PKEY_asn1_set_public_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_public_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_public_check');
  end;


  if not assigned(EVP_PKEY_asn1_set_param_check) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_param_check_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_param_check_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_param_check)}
      EVP_PKEY_asn1_set_param_check := @FC_EVP_PKEY_asn1_set_param_check
      {$else}
      EVP_PKEY_asn1_set_param_check := @ERR_EVP_PKEY_asn1_set_param_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_param_check_removed)}
   if EVP_PKEY_asn1_set_param_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_param_check)}
     EVP_PKEY_asn1_set_param_check := @_EVP_PKEY_asn1_set_param_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_param_check)}
       EVP_PKEY_asn1_set_param_check := @ERR_EVP_PKEY_asn1_set_param_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_param_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_param_check');
  end;


  if not assigned(EVP_PKEY_asn1_set_set_priv_key) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_set_priv_key_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_set_priv_key_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_set_priv_key)}
      EVP_PKEY_asn1_set_set_priv_key := @FC_EVP_PKEY_asn1_set_set_priv_key
      {$else}
      EVP_PKEY_asn1_set_set_priv_key := @ERR_EVP_PKEY_asn1_set_set_priv_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_set_priv_key_removed)}
   if EVP_PKEY_asn1_set_set_priv_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_set_priv_key)}
     EVP_PKEY_asn1_set_set_priv_key := @_EVP_PKEY_asn1_set_set_priv_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_set_priv_key)}
       EVP_PKEY_asn1_set_set_priv_key := @ERR_EVP_PKEY_asn1_set_set_priv_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_set_priv_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_set_priv_key');
  end;


  if not assigned(EVP_PKEY_asn1_set_set_pub_key) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_set_pub_key_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_set_pub_key_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_set_pub_key)}
      EVP_PKEY_asn1_set_set_pub_key := @FC_EVP_PKEY_asn1_set_set_pub_key
      {$else}
      EVP_PKEY_asn1_set_set_pub_key := @ERR_EVP_PKEY_asn1_set_set_pub_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_set_pub_key_removed)}
   if EVP_PKEY_asn1_set_set_pub_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_set_pub_key)}
     EVP_PKEY_asn1_set_set_pub_key := @_EVP_PKEY_asn1_set_set_pub_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_set_pub_key)}
       EVP_PKEY_asn1_set_set_pub_key := @ERR_EVP_PKEY_asn1_set_set_pub_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_set_pub_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_set_pub_key');
  end;


  if not assigned(EVP_PKEY_asn1_set_get_priv_key) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_get_priv_key_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_get_priv_key_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_get_priv_key)}
      EVP_PKEY_asn1_set_get_priv_key := @FC_EVP_PKEY_asn1_set_get_priv_key
      {$else}
      EVP_PKEY_asn1_set_get_priv_key := @ERR_EVP_PKEY_asn1_set_get_priv_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_get_priv_key_removed)}
   if EVP_PKEY_asn1_set_get_priv_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_get_priv_key)}
     EVP_PKEY_asn1_set_get_priv_key := @_EVP_PKEY_asn1_set_get_priv_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_get_priv_key)}
       EVP_PKEY_asn1_set_get_priv_key := @ERR_EVP_PKEY_asn1_set_get_priv_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_get_priv_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_get_priv_key');
  end;


  if not assigned(EVP_PKEY_asn1_set_get_pub_key) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_get_pub_key_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_get_pub_key_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_get_pub_key)}
      EVP_PKEY_asn1_set_get_pub_key := @FC_EVP_PKEY_asn1_set_get_pub_key
      {$else}
      EVP_PKEY_asn1_set_get_pub_key := @ERR_EVP_PKEY_asn1_set_get_pub_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_get_pub_key_removed)}
   if EVP_PKEY_asn1_set_get_pub_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_get_pub_key)}
     EVP_PKEY_asn1_set_get_pub_key := @_EVP_PKEY_asn1_set_get_pub_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_get_pub_key)}
       EVP_PKEY_asn1_set_get_pub_key := @ERR_EVP_PKEY_asn1_set_get_pub_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_get_pub_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_get_pub_key');
  end;


  if not assigned(EVP_PKEY_asn1_set_security_bits) then 
  begin
    {$if declared(EVP_PKEY_asn1_set_security_bits_introduced)}
    if LibVersion < EVP_PKEY_asn1_set_security_bits_introduced then
      {$if declared(FC_EVP_PKEY_asn1_set_security_bits)}
      EVP_PKEY_asn1_set_security_bits := @FC_EVP_PKEY_asn1_set_security_bits
      {$else}
      EVP_PKEY_asn1_set_security_bits := @ERR_EVP_PKEY_asn1_set_security_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_asn1_set_security_bits_removed)}
   if EVP_PKEY_asn1_set_security_bits_removed <= LibVersion then
     {$if declared(_EVP_PKEY_asn1_set_security_bits)}
     EVP_PKEY_asn1_set_security_bits := @_EVP_PKEY_asn1_set_security_bits
     {$else}
       {$IF declared(ERR_EVP_PKEY_asn1_set_security_bits)}
       EVP_PKEY_asn1_set_security_bits := @ERR_EVP_PKEY_asn1_set_security_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_asn1_set_security_bits) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_asn1_set_security_bits');
  end;


  if not assigned(EVP_PKEY_meth_remove) then 
  begin
    {$if declared(EVP_PKEY_meth_remove_introduced)}
    if LibVersion < EVP_PKEY_meth_remove_introduced then
      {$if declared(FC_EVP_PKEY_meth_remove)}
      EVP_PKEY_meth_remove := @FC_EVP_PKEY_meth_remove
      {$else}
      EVP_PKEY_meth_remove := @ERR_EVP_PKEY_meth_remove
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_remove_removed)}
   if EVP_PKEY_meth_remove_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_remove)}
     EVP_PKEY_meth_remove := @_EVP_PKEY_meth_remove
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_remove)}
       EVP_PKEY_meth_remove := @ERR_EVP_PKEY_meth_remove
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_remove) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_remove');
  end;


  if not assigned(EVP_PKEY_meth_get_count) then 
  begin
    {$if declared(EVP_PKEY_meth_get_count_introduced)}
    if LibVersion < EVP_PKEY_meth_get_count_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_count)}
      EVP_PKEY_meth_get_count := @FC_EVP_PKEY_meth_get_count
      {$else}
      EVP_PKEY_meth_get_count := @ERR_EVP_PKEY_meth_get_count
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_count_removed)}
   if EVP_PKEY_meth_get_count_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_count)}
     EVP_PKEY_meth_get_count := @_EVP_PKEY_meth_get_count
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_count)}
       EVP_PKEY_meth_get_count := @ERR_EVP_PKEY_meth_get_count
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_count) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_count');
  end;


  if not assigned(EVP_PKEY_meth_get0) then 
  begin
    {$if declared(EVP_PKEY_meth_get0_introduced)}
    if LibVersion < EVP_PKEY_meth_get0_introduced then
      {$if declared(FC_EVP_PKEY_meth_get0)}
      EVP_PKEY_meth_get0 := @FC_EVP_PKEY_meth_get0
      {$else}
      EVP_PKEY_meth_get0 := @ERR_EVP_PKEY_meth_get0
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get0_removed)}
   if EVP_PKEY_meth_get0_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get0)}
     EVP_PKEY_meth_get0 := @_EVP_PKEY_meth_get0
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get0)}
       EVP_PKEY_meth_get0 := @ERR_EVP_PKEY_meth_get0
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get0) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get0');
  end;


  if not assigned(EVP_PKEY_CTX_ctrl_uint64) then 
  begin
    {$if declared(EVP_PKEY_CTX_ctrl_uint64_introduced)}
    if LibVersion < EVP_PKEY_CTX_ctrl_uint64_introduced then
      {$if declared(FC_EVP_PKEY_CTX_ctrl_uint64)}
      EVP_PKEY_CTX_ctrl_uint64 := @FC_EVP_PKEY_CTX_ctrl_uint64
      {$else}
      EVP_PKEY_CTX_ctrl_uint64 := @ERR_EVP_PKEY_CTX_ctrl_uint64
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_CTX_ctrl_uint64_removed)}
   if EVP_PKEY_CTX_ctrl_uint64_removed <= LibVersion then
     {$if declared(_EVP_PKEY_CTX_ctrl_uint64)}
     EVP_PKEY_CTX_ctrl_uint64 := @_EVP_PKEY_CTX_ctrl_uint64
     {$else}
       {$IF declared(ERR_EVP_PKEY_CTX_ctrl_uint64)}
       EVP_PKEY_CTX_ctrl_uint64 := @ERR_EVP_PKEY_CTX_ctrl_uint64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_CTX_ctrl_uint64) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_CTX_ctrl_uint64');
  end;


  if not assigned(EVP_PKEY_CTX_str2ctrl) then 
  begin
    {$if declared(EVP_PKEY_CTX_str2ctrl_introduced)}
    if LibVersion < EVP_PKEY_CTX_str2ctrl_introduced then
      {$if declared(FC_EVP_PKEY_CTX_str2ctrl)}
      EVP_PKEY_CTX_str2ctrl := @FC_EVP_PKEY_CTX_str2ctrl
      {$else}
      EVP_PKEY_CTX_str2ctrl := @ERR_EVP_PKEY_CTX_str2ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_CTX_str2ctrl_removed)}
   if EVP_PKEY_CTX_str2ctrl_removed <= LibVersion then
     {$if declared(_EVP_PKEY_CTX_str2ctrl)}
     EVP_PKEY_CTX_str2ctrl := @_EVP_PKEY_CTX_str2ctrl
     {$else}
       {$IF declared(ERR_EVP_PKEY_CTX_str2ctrl)}
       EVP_PKEY_CTX_str2ctrl := @ERR_EVP_PKEY_CTX_str2ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_CTX_str2ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_CTX_str2ctrl');
  end;


  if not assigned(EVP_PKEY_CTX_hex2ctrl) then 
  begin
    {$if declared(EVP_PKEY_CTX_hex2ctrl_introduced)}
    if LibVersion < EVP_PKEY_CTX_hex2ctrl_introduced then
      {$if declared(FC_EVP_PKEY_CTX_hex2ctrl)}
      EVP_PKEY_CTX_hex2ctrl := @FC_EVP_PKEY_CTX_hex2ctrl
      {$else}
      EVP_PKEY_CTX_hex2ctrl := @ERR_EVP_PKEY_CTX_hex2ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_CTX_hex2ctrl_removed)}
   if EVP_PKEY_CTX_hex2ctrl_removed <= LibVersion then
     {$if declared(_EVP_PKEY_CTX_hex2ctrl)}
     EVP_PKEY_CTX_hex2ctrl := @_EVP_PKEY_CTX_hex2ctrl
     {$else}
       {$IF declared(ERR_EVP_PKEY_CTX_hex2ctrl)}
       EVP_PKEY_CTX_hex2ctrl := @ERR_EVP_PKEY_CTX_hex2ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_CTX_hex2ctrl) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_CTX_hex2ctrl');
  end;


  if not assigned(EVP_PKEY_CTX_md) then 
  begin
    {$if declared(EVP_PKEY_CTX_md_introduced)}
    if LibVersion < EVP_PKEY_CTX_md_introduced then
      {$if declared(FC_EVP_PKEY_CTX_md)}
      EVP_PKEY_CTX_md := @FC_EVP_PKEY_CTX_md
      {$else}
      EVP_PKEY_CTX_md := @ERR_EVP_PKEY_CTX_md
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_CTX_md_removed)}
   if EVP_PKEY_CTX_md_removed <= LibVersion then
     {$if declared(_EVP_PKEY_CTX_md)}
     EVP_PKEY_CTX_md := @_EVP_PKEY_CTX_md
     {$else}
       {$IF declared(ERR_EVP_PKEY_CTX_md)}
       EVP_PKEY_CTX_md := @ERR_EVP_PKEY_CTX_md
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_CTX_md) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_CTX_md');
  end;


  if not assigned(EVP_PKEY_new_raw_private_key) then 
  begin
    {$if declared(EVP_PKEY_new_raw_private_key_introduced)}
    if LibVersion < EVP_PKEY_new_raw_private_key_introduced then
      {$if declared(FC_EVP_PKEY_new_raw_private_key)}
      EVP_PKEY_new_raw_private_key := @FC_EVP_PKEY_new_raw_private_key
      {$else}
      EVP_PKEY_new_raw_private_key := @ERR_EVP_PKEY_new_raw_private_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_new_raw_private_key_removed)}
   if EVP_PKEY_new_raw_private_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_new_raw_private_key)}
     EVP_PKEY_new_raw_private_key := @_EVP_PKEY_new_raw_private_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_new_raw_private_key)}
       EVP_PKEY_new_raw_private_key := @ERR_EVP_PKEY_new_raw_private_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_new_raw_private_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_new_raw_private_key');
  end;


  if not assigned(EVP_PKEY_new_raw_public_key) then 
  begin
    {$if declared(EVP_PKEY_new_raw_public_key_introduced)}
    if LibVersion < EVP_PKEY_new_raw_public_key_introduced then
      {$if declared(FC_EVP_PKEY_new_raw_public_key)}
      EVP_PKEY_new_raw_public_key := @FC_EVP_PKEY_new_raw_public_key
      {$else}
      EVP_PKEY_new_raw_public_key := @ERR_EVP_PKEY_new_raw_public_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_new_raw_public_key_removed)}
   if EVP_PKEY_new_raw_public_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_new_raw_public_key)}
     EVP_PKEY_new_raw_public_key := @_EVP_PKEY_new_raw_public_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_new_raw_public_key)}
       EVP_PKEY_new_raw_public_key := @ERR_EVP_PKEY_new_raw_public_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_new_raw_public_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_new_raw_public_key');
  end;


  if not assigned(EVP_PKEY_get_raw_private_key) then 
  begin
    {$if declared(EVP_PKEY_get_raw_private_key_introduced)}
    if LibVersion < EVP_PKEY_get_raw_private_key_introduced then
      {$if declared(FC_EVP_PKEY_get_raw_private_key)}
      EVP_PKEY_get_raw_private_key := @FC_EVP_PKEY_get_raw_private_key
      {$else}
      EVP_PKEY_get_raw_private_key := @ERR_EVP_PKEY_get_raw_private_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get_raw_private_key_removed)}
   if EVP_PKEY_get_raw_private_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get_raw_private_key)}
     EVP_PKEY_get_raw_private_key := @_EVP_PKEY_get_raw_private_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_get_raw_private_key)}
       EVP_PKEY_get_raw_private_key := @ERR_EVP_PKEY_get_raw_private_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get_raw_private_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get_raw_private_key');
  end;


  if not assigned(EVP_PKEY_get_raw_public_key) then 
  begin
    {$if declared(EVP_PKEY_get_raw_public_key_introduced)}
    if LibVersion < EVP_PKEY_get_raw_public_key_introduced then
      {$if declared(FC_EVP_PKEY_get_raw_public_key)}
      EVP_PKEY_get_raw_public_key := @FC_EVP_PKEY_get_raw_public_key
      {$else}
      EVP_PKEY_get_raw_public_key := @ERR_EVP_PKEY_get_raw_public_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_get_raw_public_key_removed)}
   if EVP_PKEY_get_raw_public_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_get_raw_public_key)}
     EVP_PKEY_get_raw_public_key := @_EVP_PKEY_get_raw_public_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_get_raw_public_key)}
       EVP_PKEY_get_raw_public_key := @ERR_EVP_PKEY_get_raw_public_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_get_raw_public_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_get_raw_public_key');
  end;


  if not assigned(EVP_PKEY_new_CMAC_key) then 
  begin
    {$if declared(EVP_PKEY_new_CMAC_key_introduced)}
    if LibVersion < EVP_PKEY_new_CMAC_key_introduced then
      {$if declared(FC_EVP_PKEY_new_CMAC_key)}
      EVP_PKEY_new_CMAC_key := @FC_EVP_PKEY_new_CMAC_key
      {$else}
      EVP_PKEY_new_CMAC_key := @ERR_EVP_PKEY_new_CMAC_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_new_CMAC_key_removed)}
   if EVP_PKEY_new_CMAC_key_removed <= LibVersion then
     {$if declared(_EVP_PKEY_new_CMAC_key)}
     EVP_PKEY_new_CMAC_key := @_EVP_PKEY_new_CMAC_key
     {$else}
       {$IF declared(ERR_EVP_PKEY_new_CMAC_key)}
       EVP_PKEY_new_CMAC_key := @ERR_EVP_PKEY_new_CMAC_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_new_CMAC_key) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_new_CMAC_key');
  end;


  if not assigned(EVP_PKEY_check) then 
  begin
    {$if declared(EVP_PKEY_check_introduced)}
    if LibVersion < EVP_PKEY_check_introduced then
      {$if declared(FC_EVP_PKEY_check)}
      EVP_PKEY_check := @FC_EVP_PKEY_check
      {$else}
      EVP_PKEY_check := @ERR_EVP_PKEY_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_check_removed)}
   if EVP_PKEY_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_check)}
     EVP_PKEY_check := @_EVP_PKEY_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_check)}
       EVP_PKEY_check := @ERR_EVP_PKEY_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_check');
  end;


  if not assigned(EVP_PKEY_public_check) then 
  begin
    {$if declared(EVP_PKEY_public_check_introduced)}
    if LibVersion < EVP_PKEY_public_check_introduced then
      {$if declared(FC_EVP_PKEY_public_check)}
      EVP_PKEY_public_check := @FC_EVP_PKEY_public_check
      {$else}
      EVP_PKEY_public_check := @ERR_EVP_PKEY_public_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_public_check_removed)}
   if EVP_PKEY_public_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_public_check)}
     EVP_PKEY_public_check := @_EVP_PKEY_public_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_public_check)}
       EVP_PKEY_public_check := @ERR_EVP_PKEY_public_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_public_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_public_check');
  end;


  if not assigned(EVP_PKEY_param_check) then 
  begin
    {$if declared(EVP_PKEY_param_check_introduced)}
    if LibVersion < EVP_PKEY_param_check_introduced then
      {$if declared(FC_EVP_PKEY_param_check)}
      EVP_PKEY_param_check := @FC_EVP_PKEY_param_check
      {$else}
      EVP_PKEY_param_check := @ERR_EVP_PKEY_param_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_param_check_removed)}
   if EVP_PKEY_param_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_param_check)}
     EVP_PKEY_param_check := @_EVP_PKEY_param_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_param_check)}
       EVP_PKEY_param_check := @ERR_EVP_PKEY_param_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_param_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_param_check');
  end;


  if not assigned(EVP_PKEY_meth_set_digestsign) then 
  begin
    {$if declared(EVP_PKEY_meth_set_digestsign_introduced)}
    if LibVersion < EVP_PKEY_meth_set_digestsign_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_digestsign)}
      EVP_PKEY_meth_set_digestsign := @FC_EVP_PKEY_meth_set_digestsign
      {$else}
      EVP_PKEY_meth_set_digestsign := @ERR_EVP_PKEY_meth_set_digestsign
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_digestsign_removed)}
   if EVP_PKEY_meth_set_digestsign_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_digestsign)}
     EVP_PKEY_meth_set_digestsign := @_EVP_PKEY_meth_set_digestsign
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_digestsign)}
       EVP_PKEY_meth_set_digestsign := @ERR_EVP_PKEY_meth_set_digestsign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_digestsign) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_digestsign');
  end;


  if not assigned(EVP_PKEY_meth_set_digestverify) then 
  begin
    {$if declared(EVP_PKEY_meth_set_digestverify_introduced)}
    if LibVersion < EVP_PKEY_meth_set_digestverify_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_digestverify)}
      EVP_PKEY_meth_set_digestverify := @FC_EVP_PKEY_meth_set_digestverify
      {$else}
      EVP_PKEY_meth_set_digestverify := @ERR_EVP_PKEY_meth_set_digestverify
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_digestverify_removed)}
   if EVP_PKEY_meth_set_digestverify_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_digestverify)}
     EVP_PKEY_meth_set_digestverify := @_EVP_PKEY_meth_set_digestverify
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_digestverify)}
       EVP_PKEY_meth_set_digestverify := @ERR_EVP_PKEY_meth_set_digestverify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_digestverify) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_digestverify');
  end;


  if not assigned(EVP_PKEY_meth_set_check) then 
  begin
    {$if declared(EVP_PKEY_meth_set_check_introduced)}
    if LibVersion < EVP_PKEY_meth_set_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_check)}
      EVP_PKEY_meth_set_check := @FC_EVP_PKEY_meth_set_check
      {$else}
      EVP_PKEY_meth_set_check := @ERR_EVP_PKEY_meth_set_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_check_removed)}
   if EVP_PKEY_meth_set_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_check)}
     EVP_PKEY_meth_set_check := @_EVP_PKEY_meth_set_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_check)}
       EVP_PKEY_meth_set_check := @ERR_EVP_PKEY_meth_set_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_check');
  end;


  if not assigned(EVP_PKEY_meth_set_public_check) then 
  begin
    {$if declared(EVP_PKEY_meth_set_public_check_introduced)}
    if LibVersion < EVP_PKEY_meth_set_public_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_public_check)}
      EVP_PKEY_meth_set_public_check := @FC_EVP_PKEY_meth_set_public_check
      {$else}
      EVP_PKEY_meth_set_public_check := @ERR_EVP_PKEY_meth_set_public_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_public_check_removed)}
   if EVP_PKEY_meth_set_public_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_public_check)}
     EVP_PKEY_meth_set_public_check := @_EVP_PKEY_meth_set_public_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_public_check)}
       EVP_PKEY_meth_set_public_check := @ERR_EVP_PKEY_meth_set_public_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_public_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_public_check');
  end;


  if not assigned(EVP_PKEY_meth_set_param_check) then 
  begin
    {$if declared(EVP_PKEY_meth_set_param_check_introduced)}
    if LibVersion < EVP_PKEY_meth_set_param_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_param_check)}
      EVP_PKEY_meth_set_param_check := @FC_EVP_PKEY_meth_set_param_check
      {$else}
      EVP_PKEY_meth_set_param_check := @ERR_EVP_PKEY_meth_set_param_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_param_check_removed)}
   if EVP_PKEY_meth_set_param_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_param_check)}
     EVP_PKEY_meth_set_param_check := @_EVP_PKEY_meth_set_param_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_param_check)}
       EVP_PKEY_meth_set_param_check := @ERR_EVP_PKEY_meth_set_param_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_param_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_param_check');
  end;


  if not assigned(EVP_PKEY_meth_set_digest_custom) then 
  begin
    {$if declared(EVP_PKEY_meth_set_digest_custom_introduced)}
    if LibVersion < EVP_PKEY_meth_set_digest_custom_introduced then
      {$if declared(FC_EVP_PKEY_meth_set_digest_custom)}
      EVP_PKEY_meth_set_digest_custom := @FC_EVP_PKEY_meth_set_digest_custom
      {$else}
      EVP_PKEY_meth_set_digest_custom := @ERR_EVP_PKEY_meth_set_digest_custom
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_set_digest_custom_removed)}
   if EVP_PKEY_meth_set_digest_custom_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_set_digest_custom)}
     EVP_PKEY_meth_set_digest_custom := @_EVP_PKEY_meth_set_digest_custom
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_set_digest_custom)}
       EVP_PKEY_meth_set_digest_custom := @ERR_EVP_PKEY_meth_set_digest_custom
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_set_digest_custom) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_set_digest_custom');
  end;


  if not assigned(EVP_PKEY_meth_get_digestsign) then 
  begin
    {$if declared(EVP_PKEY_meth_get_digestsign_introduced)}
    if LibVersion < EVP_PKEY_meth_get_digestsign_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_digestsign)}
      EVP_PKEY_meth_get_digestsign := @FC_EVP_PKEY_meth_get_digestsign
      {$else}
      EVP_PKEY_meth_get_digestsign := @ERR_EVP_PKEY_meth_get_digestsign
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_digestsign_removed)}
   if EVP_PKEY_meth_get_digestsign_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_digestsign)}
     EVP_PKEY_meth_get_digestsign := @_EVP_PKEY_meth_get_digestsign
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_digestsign)}
       EVP_PKEY_meth_get_digestsign := @ERR_EVP_PKEY_meth_get_digestsign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_digestsign) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_digestsign');
  end;


  if not assigned(EVP_PKEY_meth_get_digestverify) then 
  begin
    {$if declared(EVP_PKEY_meth_get_digestverify_introduced)}
    if LibVersion < EVP_PKEY_meth_get_digestverify_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_digestverify)}
      EVP_PKEY_meth_get_digestverify := @FC_EVP_PKEY_meth_get_digestverify
      {$else}
      EVP_PKEY_meth_get_digestverify := @ERR_EVP_PKEY_meth_get_digestverify
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_digestverify_removed)}
   if EVP_PKEY_meth_get_digestverify_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_digestverify)}
     EVP_PKEY_meth_get_digestverify := @_EVP_PKEY_meth_get_digestverify
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_digestverify)}
       EVP_PKEY_meth_get_digestverify := @ERR_EVP_PKEY_meth_get_digestverify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_digestverify) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_digestverify');
  end;


  if not assigned(EVP_PKEY_meth_get_check) then 
  begin
    {$if declared(EVP_PKEY_meth_get_check_introduced)}
    if LibVersion < EVP_PKEY_meth_get_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_check)}
      EVP_PKEY_meth_get_check := @FC_EVP_PKEY_meth_get_check
      {$else}
      EVP_PKEY_meth_get_check := @ERR_EVP_PKEY_meth_get_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_check_removed)}
   if EVP_PKEY_meth_get_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_check)}
     EVP_PKEY_meth_get_check := @_EVP_PKEY_meth_get_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_check)}
       EVP_PKEY_meth_get_check := @ERR_EVP_PKEY_meth_get_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_check');
  end;


  if not assigned(EVP_PKEY_meth_get_public_check) then 
  begin
    {$if declared(EVP_PKEY_meth_get_public_check_introduced)}
    if LibVersion < EVP_PKEY_meth_get_public_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_public_check)}
      EVP_PKEY_meth_get_public_check := @FC_EVP_PKEY_meth_get_public_check
      {$else}
      EVP_PKEY_meth_get_public_check := @ERR_EVP_PKEY_meth_get_public_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_public_check_removed)}
   if EVP_PKEY_meth_get_public_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_public_check)}
     EVP_PKEY_meth_get_public_check := @_EVP_PKEY_meth_get_public_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_public_check)}
       EVP_PKEY_meth_get_public_check := @ERR_EVP_PKEY_meth_get_public_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_public_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_public_check');
  end;


  if not assigned(EVP_PKEY_meth_get_param_check) then 
  begin
    {$if declared(EVP_PKEY_meth_get_param_check_introduced)}
    if LibVersion < EVP_PKEY_meth_get_param_check_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_param_check)}
      EVP_PKEY_meth_get_param_check := @FC_EVP_PKEY_meth_get_param_check
      {$else}
      EVP_PKEY_meth_get_param_check := @ERR_EVP_PKEY_meth_get_param_check
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_param_check_removed)}
   if EVP_PKEY_meth_get_param_check_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_param_check)}
     EVP_PKEY_meth_get_param_check := @_EVP_PKEY_meth_get_param_check
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_param_check)}
       EVP_PKEY_meth_get_param_check := @ERR_EVP_PKEY_meth_get_param_check
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_param_check) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_param_check');
  end;


  if not assigned(EVP_PKEY_meth_get_digest_custom) then 
  begin
    {$if declared(EVP_PKEY_meth_get_digest_custom_introduced)}
    if LibVersion < EVP_PKEY_meth_get_digest_custom_introduced then
      {$if declared(FC_EVP_PKEY_meth_get_digest_custom)}
      EVP_PKEY_meth_get_digest_custom := @FC_EVP_PKEY_meth_get_digest_custom
      {$else}
      EVP_PKEY_meth_get_digest_custom := @ERR_EVP_PKEY_meth_get_digest_custom
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_PKEY_meth_get_digest_custom_removed)}
   if EVP_PKEY_meth_get_digest_custom_removed <= LibVersion then
     {$if declared(_EVP_PKEY_meth_get_digest_custom)}
     EVP_PKEY_meth_get_digest_custom := @_EVP_PKEY_meth_get_digest_custom
     {$else}
       {$IF declared(ERR_EVP_PKEY_meth_get_digest_custom)}
       EVP_PKEY_meth_get_digest_custom := @ERR_EVP_PKEY_meth_get_digest_custom
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_PKEY_meth_get_digest_custom) and Assigned(AFailed) then 
     AFailed.Add('EVP_PKEY_meth_get_digest_custom');
  end;


  if not assigned(OpenSSL_add_all_ciphers) then 
  begin
    {$if declared(OpenSSL_add_all_ciphers_introduced)}
    if LibVersion < OpenSSL_add_all_ciphers_introduced then
      {$if declared(FC_OpenSSL_add_all_ciphers)}
      OpenSSL_add_all_ciphers := @FC_OpenSSL_add_all_ciphers
      {$else}
      OpenSSL_add_all_ciphers := @ERR_OpenSSL_add_all_ciphers
      {$ifend}
    else
    {$ifend}
   {$if declared(OpenSSL_add_all_ciphers_removed)}
   if OpenSSL_add_all_ciphers_removed <= LibVersion then
     {$if declared(_OpenSSL_add_all_ciphers)}
     OpenSSL_add_all_ciphers := @_OpenSSL_add_all_ciphers
     {$else}
       {$IF declared(ERR_OpenSSL_add_all_ciphers)}
       OpenSSL_add_all_ciphers := @ERR_OpenSSL_add_all_ciphers
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OpenSSL_add_all_ciphers) and Assigned(AFailed) then 
     AFailed.Add('OpenSSL_add_all_ciphers');
  end;


  if not assigned(OpenSSL_add_all_digests) then 
  begin
    {$if declared(OpenSSL_add_all_digests_introduced)}
    if LibVersion < OpenSSL_add_all_digests_introduced then
      {$if declared(FC_OpenSSL_add_all_digests)}
      OpenSSL_add_all_digests := @FC_OpenSSL_add_all_digests
      {$else}
      OpenSSL_add_all_digests := @ERR_OpenSSL_add_all_digests
      {$ifend}
    else
    {$ifend}
   {$if declared(OpenSSL_add_all_digests_removed)}
   if OpenSSL_add_all_digests_removed <= LibVersion then
     {$if declared(_OpenSSL_add_all_digests)}
     OpenSSL_add_all_digests := @_OpenSSL_add_all_digests
     {$else}
       {$IF declared(ERR_OpenSSL_add_all_digests)}
       OpenSSL_add_all_digests := @ERR_OpenSSL_add_all_digests
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OpenSSL_add_all_digests) and Assigned(AFailed) then 
     AFailed.Add('OpenSSL_add_all_digests');
  end;


  if not assigned(EVP_cleanup) then 
  begin
    {$if declared(EVP_cleanup_introduced)}
    if LibVersion < EVP_cleanup_introduced then
      {$if declared(FC_EVP_cleanup)}
      EVP_cleanup := @FC_EVP_cleanup
      {$else}
      EVP_cleanup := @ERR_EVP_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(EVP_cleanup_removed)}
   if EVP_cleanup_removed <= LibVersion then
     {$if declared(_EVP_cleanup)}
     EVP_cleanup := @_EVP_cleanup
     {$else}
       {$IF declared(ERR_EVP_cleanup)}
       EVP_cleanup := @ERR_EVP_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EVP_cleanup) and Assigned(AFailed) then 
     AFailed.Add('EVP_cleanup');
  end;


end;

procedure Unload;
begin
  EVP_PKEY_assign_RSA := nil; {removed 1.0.0}
  EVP_PKEY_assign_DSA := nil; {removed 1.0.0}
  EVP_PKEY_assign_DH := nil; {removed 1.0.0}
  EVP_PKEY_assign_EC_KEY := nil; {removed 1.0.0}
  EVP_PKEY_assign_SIPHASH := nil; {removed 1.0.0}
  EVP_PKEY_assign_POLY1305 := nil; {removed 1.0.0}
  EVP_MD_meth_new := nil; {introduced 1.1.0}
  EVP_MD_meth_dup := nil; {introduced 1.1.0}
  EVP_MD_meth_free := nil; {introduced 1.1.0}
  EVP_MD_meth_set_input_blocksize := nil; {introduced 1.1.0}
  EVP_MD_meth_set_result_size := nil; {introduced 1.1.0}
  EVP_MD_meth_set_app_datasize := nil; {introduced 1.1.0}
  EVP_MD_meth_set_flags := nil; {introduced 1.1.0}
  EVP_MD_meth_set_init := nil; {introduced 1.1.0}
  EVP_MD_meth_set_update := nil; {introduced 1.1.0}
  EVP_MD_meth_set_final := nil; {introduced 1.1.0}
  EVP_MD_meth_set_copy := nil; {introduced 1.1.0}
  EVP_MD_meth_set_cleanup := nil; {introduced 1.1.0}
  EVP_MD_meth_set_ctrl := nil; {introduced 1.1.0}
  EVP_MD_meth_get_input_blocksize := nil; {introduced 1.1.0}
  EVP_MD_meth_get_result_size := nil; {introduced 1.1.0}
  EVP_MD_meth_get_app_datasize := nil; {introduced 1.1.0}
  EVP_MD_meth_get_flags := nil; {introduced 1.1.0}
  EVP_MD_meth_get_init := nil; {introduced 1.1.0}
  EVP_MD_meth_get_update := nil; {introduced 1.1.0}
  EVP_MD_meth_get_final := nil; {introduced 1.1.0}
  EVP_MD_meth_get_copy := nil; {introduced 1.1.0}
  EVP_MD_meth_get_cleanup := nil; {introduced 1.1.0}
  EVP_MD_meth_get_ctrl := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_new := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_dup := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_free := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_iv_length := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_flags := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_impl_ctx_size := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_init := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_do_cipher := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_cleanup := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_set_asn1_params := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_get_asn1_params := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_set_ctrl := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_init := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_do_cipher := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_cleanup := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_set_asn1_params := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_get_asn1_params := nil; {introduced 1.1.0}
  EVP_CIPHER_meth_get_ctrl := nil; {introduced 1.1.0}
  EVP_MD_type := nil; {removed 3.0.0}
  EVP_MD_pkey_type := nil; {removed 3.0.0}
  EVP_MD_size := nil; {removed 3.0.0}
  EVP_MD_block_size := nil; {removed 3.0.0}
  EVP_MD_flags := nil; {removed 3.0.0}
  EVP_MD_CTX_md := nil;
  EVP_MD_CTX_update_fn := nil; {introduced 1.1.0}
  EVP_MD_CTX_set_update_fn := nil; {introduced 1.1.0}
  EVP_MD_CTX_pkey_ctx := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_MD_CTX_set_pkey_ctx := nil; {introduced 1.1.0}
  EVP_MD_CTX_md_data := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_nid := nil; {removed 3.0.0}
  EVP_CIPHER_block_size := nil; {removed 3.0.0}
  EVP_CIPHER_impl_ctx_size := nil; {introduced 1.1.0}
  EVP_CIPHER_key_length := nil; {removed 3.0.0}
  EVP_CIPHER_iv_length := nil; {removed 3.0.0}
  EVP_CIPHER_flags := nil; {removed 3.0.0}
  EVP_CIPHER_CTX_cipher := nil;
  EVP_CIPHER_CTX_encrypting := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_nid := nil; {removed 3.0.0}
  EVP_CIPHER_CTX_block_size := nil; {removed 3.0.0}
  EVP_CIPHER_CTX_key_length := nil; {removed 3.0.0}
  EVP_CIPHER_CTX_iv_length := nil; {removed 3.0.0}
  EVP_CIPHER_CTX_iv := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_original_iv := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_iv_noconst := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_buf_noconst := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_num := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_CTX_set_num := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_copy := nil;
  EVP_CIPHER_CTX_get_app_data := nil;
  EVP_CIPHER_CTX_set_app_data := nil;
  EVP_CIPHER_CTX_get_cipher_data := nil; {introduced 1.1.0}
  EVP_CIPHER_CTX_set_cipher_data := nil; {introduced 1.1.0}
  BIO_set_md := nil; {removed 1.0.0}
  EVP_MD_CTX_ctrl := nil; {introduced 1.1.0}
  EVP_MD_CTX_new := nil; {introduced 1.1.0}
  EVP_MD_CTX_reset := nil; {introduced 1.1.0}
  EVP_MD_CTX_free := nil; {introduced 1.1.0}
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
  EVP_DigestFinalXOF := nil; {introduced 1.1.0}
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
  EVP_DigestSign := nil; {introduced 1.1.0}
  EVP_VerifyFinal := nil;
  EVP_DigestVerify := nil; {introduced 1.1.0}
  EVP_DigestSignInit := nil;
  EVP_DigestSignFinal := nil;
  EVP_DigestVerifyInit := nil;
  EVP_DigestVerifyFinal := nil;
  EVP_OpenInit := nil;
  EVP_OpenFinal := nil;
  EVP_SealInit := nil;
  EVP_SealFinal := nil;
  EVP_ENCODE_CTX_new := nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_free := nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_copy := nil; {introduced 1.1.0}
  EVP_ENCODE_CTX_num := nil; {introduced 1.1.0}
  EVP_EncodeInit := nil;
  EVP_EncodeUpdate := nil;
  EVP_EncodeFinal := nil;
  EVP_EncodeBlock := nil;
  EVP_DecodeInit := nil;
  EVP_DecodeUpdate := nil;
  EVP_DecodeFinal := nil;
  EVP_DecodeBlock := nil;
  EVP_CIPHER_CTX_new := nil;
  EVP_CIPHER_CTX_reset := nil; {introduced 1.1.0}
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
  EVP_md5_sha1 := nil; {introduced 1.1.0}
  EVP_sha1 := nil;
  EVP_sha224 := nil;
  EVP_sha256 := nil;
  EVP_sha384 := nil;
  EVP_sha512 := nil;
  EVP_sha512_224 := nil; {introduced 1.1.0}
  EVP_sha512_256 := nil; {introduced 1.1.0}
  EVP_sha3_224 := nil; {introduced 1.1.0}
  EVP_sha3_256 := nil; {introduced 1.1.0}
  EVP_sha3_384 := nil; {introduced 1.1.0}
  EVP_sha3_512 := nil; {introduced 1.1.0}
  EVP_shake128 := nil; {introduced 1.1.0}
  EVP_shake256 := nil; {introduced 1.1.0}
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
  EVP_aes_128_wrap_pad := nil; {introduced 1.1.0}
  EVP_aes_128_ocb := nil; {introduced 1.1.0}
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
  EVP_aes_192_wrap_pad := nil; {introduced 1.1.0}
  EVP_aes_192_ocb := nil; {introduced 1.1.0}
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
  EVP_aes_256_wrap_pad := nil; {introduced 1.1.0}
  EVP_aes_256_ocb := nil; {introduced 1.1.0}
  EVP_aes_128_cbc_hmac_sha1 := nil;
  EVP_aes_256_cbc_hmac_sha1 := nil;
  EVP_aes_128_cbc_hmac_sha256 := nil;
  EVP_aes_256_cbc_hmac_sha256 := nil;
  EVP_aria_128_ecb := nil; {introduced 1.1.0}
  EVP_aria_128_cbc := nil; {introduced 1.1.0}
  EVP_aria_128_cfb1 := nil; {introduced 1.1.0}
  EVP_aria_128_cfb8 := nil; {introduced 1.1.0}
  EVP_aria_128_cfb128 := nil; {introduced 1.1.0}
  EVP_aria_128_ctr := nil; {introduced 1.1.0}
  EVP_aria_128_ofb := nil; {introduced 1.1.0}
  EVP_aria_128_gcm := nil; {introduced 1.1.0}
  EVP_aria_128_ccm := nil; {introduced 1.1.0}
  EVP_aria_192_ecb := nil; {introduced 1.1.0}
  EVP_aria_192_cbc := nil; {introduced 1.1.0}
  EVP_aria_192_cfb1 := nil; {introduced 1.1.0}
  EVP_aria_192_cfb8 := nil; {introduced 1.1.0}
  EVP_aria_192_cfb128 := nil; {introduced 1.1.0}
  EVP_aria_192_ctr := nil; {introduced 1.1.0}
  EVP_aria_192_ofb := nil; {introduced 1.1.0}
  EVP_aria_192_gcm := nil; {introduced 1.1.0}
  EVP_aria_192_ccm := nil; {introduced 1.1.0}
  EVP_aria_256_ecb := nil; {introduced 1.1.0}
  EVP_aria_256_cbc := nil; {introduced 1.1.0}
  EVP_aria_256_cfb1 := nil; {introduced 1.1.0}
  EVP_aria_256_cfb8 := nil; {introduced 1.1.0}
  EVP_aria_256_cfb128 := nil; {introduced 1.1.0}
  EVP_aria_256_ctr := nil; {introduced 1.1.0}
  EVP_aria_256_ofb := nil; {introduced 1.1.0}
  EVP_aria_256_gcm := nil; {introduced 1.1.0}
  EVP_aria_256_ccm := nil; {introduced 1.1.0}
  EVP_camellia_128_ecb := nil;
  EVP_camellia_128_cbc := nil;
  EVP_camellia_128_cfb1 := nil;
  EVP_camellia_128_cfb8 := nil;
  EVP_camellia_128_cfb128 := nil;
  EVP_camellia_128_ofb := nil;
  EVP_camellia_128_ctr := nil; {introduced 1.1.0}
  EVP_camellia_192_ecb := nil;
  EVP_camellia_192_cbc := nil;
  EVP_camellia_192_cfb1 := nil;
  EVP_camellia_192_cfb8 := nil;
  EVP_camellia_192_cfb128 := nil;
  EVP_camellia_192_ofb := nil;
  EVP_camellia_192_ctr := nil; {introduced 1.1.0}
  EVP_camellia_256_ecb := nil;
  EVP_camellia_256_cbc := nil;
  EVP_camellia_256_cfb1 := nil;
  EVP_camellia_256_cfb8 := nil;
  EVP_camellia_256_cfb128 := nil;
  EVP_camellia_256_ofb := nil;
  EVP_camellia_256_ctr := nil; {introduced 1.1.0}
  EVP_chacha20 := nil; {introduced 1.1.0}
  EVP_chacha20_poly1305 := nil; {introduced 1.1.0}
  EVP_seed_ecb := nil;
  EVP_seed_cbc := nil;
  EVP_seed_cfb128 := nil;
  EVP_seed_ofb := nil;
  EVP_sm4_ecb := nil; {introduced 1.1.0}
  EVP_sm4_cbc := nil; {introduced 1.1.0}
  EVP_sm4_cfb128 := nil; {introduced 1.1.0}
  EVP_sm4_ofb := nil; {introduced 1.1.0}
  EVP_sm4_ctr := nil; {introduced 1.1.0}
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
  EVP_PKEY_id := nil; {removed 3.0.0}
  EVP_PKEY_base_id := nil; {removed 3.0.0}
  EVP_PKEY_bits := nil; {removed 3.0.0}
  EVP_PKEY_security_bits := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_size := nil; {removed 3.0.0}
  EVP_PKEY_set_type := nil;
  EVP_PKEY_set_type_str := nil;
  EVP_PKEY_set_alias_type := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_set1_engine := nil; {introduced 1.1.0}
  EVP_PKEY_get0_engine := nil; {introduced 1.1.0}
  EVP_PKEY_assign := nil;
  EVP_PKEY_get0 := nil;
  EVP_PKEY_get0_hmac := nil; {introduced 1.1.0}
  EVP_PKEY_get0_poly1305 := nil; {introduced 1.1.0}
  EVP_PKEY_get0_siphash := nil; {introduced 1.1.0}
  EVP_PKEY_set1_RSA := nil;
  EVP_PKEY_get0_RSA := nil; {introduced 1.1.0}
  EVP_PKEY_get1_RSA := nil;
  EVP_PKEY_set1_DSA := nil;
  EVP_PKEY_get0_DSA := nil; {introduced 1.1.0}
  EVP_PKEY_get1_DSA := nil;
  EVP_PKEY_set1_DH := nil;
  EVP_PKEY_get0_DH := nil; {introduced 1.1.0}
  EVP_PKEY_get1_DH := nil;
  EVP_PKEY_set1_EC_KEY := nil;
  EVP_PKEY_get0_EC_KEY := nil; {introduced 1.1.0}
  EVP_PKEY_get1_EC_KEY := nil;
  EVP_PKEY_new := nil;
  EVP_PKEY_up_ref := nil; {introduced 1.1.0}
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
  EVP_PKEY_set1_tls_encodedpoint := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_PKEY_get1_tls_encodedpoint := nil; {introduced 1.1.0 removed 3.0.0}
  EVP_CIPHER_type := nil; {removed 3.0.0}
  EVP_CIPHER_param_to_asn1 := nil;
  EVP_CIPHER_asn1_to_param := nil;
  EVP_CIPHER_set_asn1_iv := nil;
  EVP_CIPHER_get_asn1_iv := nil;
  PKCS5_PBE_keyivgen := nil;
  PKCS5_PBKDF2_HMAC_SHA1 := nil;
  PKCS5_PBKDF2_HMAC := nil;
  PKCS5_v2_PBE_keyivgen := nil;
  EVP_PBE_scrypt := nil; {introduced 1.1.0}
  PKCS5_v2_scrypt_keyivgen := nil; {introduced 1.1.0}
  PKCS5_PBE_add := nil;
  EVP_PBE_CipherInit := nil;
  EVP_PBE_alg_add_type := nil;
  EVP_PBE_alg_add := nil;
  EVP_PBE_find := nil;
  EVP_PBE_cleanup := nil;
  EVP_PBE_get := nil; {introduced 1.1.0}
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
  EVP_PKEY_asn1_set_siginf := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_check := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_public_check := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_param_check := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_set_priv_key := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_set_pub_key := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_priv_key := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_get_pub_key := nil; {introduced 1.1.0}
  EVP_PKEY_asn1_set_security_bits := nil; {introduced 1.1.0}
  EVP_PKEY_meth_find := nil;
  EVP_PKEY_meth_new := nil;
  EVP_PKEY_meth_get0_info := nil;
  EVP_PKEY_meth_copy := nil;
  EVP_PKEY_meth_free := nil;
  EVP_PKEY_meth_add0 := nil;
  EVP_PKEY_meth_remove := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_count := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get0 := nil; {introduced 1.1.0}
  EVP_PKEY_CTX_new := nil;
  EVP_PKEY_CTX_new_id := nil;
  EVP_PKEY_CTX_dup := nil;
  EVP_PKEY_CTX_free := nil;
  EVP_PKEY_CTX_ctrl := nil;
  EVP_PKEY_CTX_ctrl_str := nil;
  EVP_PKEY_CTX_ctrl_uint64 := nil; {introduced 1.1.0}
  EVP_PKEY_CTX_str2ctrl := nil; {introduced 1.1.0}
  EVP_PKEY_CTX_hex2ctrl := nil; {introduced 1.1.0}
  EVP_PKEY_CTX_md := nil; {introduced 1.1.0}
  EVP_PKEY_CTX_get_operation := nil;
  EVP_PKEY_CTX_set0_keygen_info := nil;
  EVP_PKEY_new_mac_key := nil;
  EVP_PKEY_new_raw_private_key := nil; {introduced 1.1.0}
  EVP_PKEY_new_raw_public_key := nil; {introduced 1.1.0}
  EVP_PKEY_get_raw_private_key := nil; {introduced 1.1.0}
  EVP_PKEY_get_raw_public_key := nil; {introduced 1.1.0}
  EVP_PKEY_new_CMAC_key := nil; {introduced 1.1.0}
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
  EVP_PKEY_check := nil; {introduced 1.1.0}
  EVP_PKEY_public_check := nil; {introduced 1.1.0}
  EVP_PKEY_param_check := nil; {introduced 1.1.0}
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
  EVP_PKEY_meth_set_digestsign := nil; {introduced 1.1.0}
  EVP_PKEY_meth_set_digestverify := nil; {introduced 1.1.0}
  EVP_PKEY_meth_set_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_set_public_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_set_param_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_set_digest_custom := nil; {introduced 1.1.0}
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
  EVP_PKEY_meth_get_digestsign := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_digestverify := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_public_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_param_check := nil; {introduced 1.1.0}
  EVP_PKEY_meth_get_digest_custom := nil; {introduced 1.1.0}
  EVP_add_alg_module := nil;
  OpenSSL_add_all_ciphers := nil; {removed 1.1.0}
  OpenSSL_add_all_digests := nil; {removed 1.1.0}
  EVP_cleanup := nil; {removed 1.1.0}
end;
{$ELSE}
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

procedure OpenSSL_add_all_ciphers;
begin
  OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS, nil);
end;

procedure OpenSSL_add_all_digests;
begin
  OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_DIGESTS, Nil);
end;

procedure EVP_cleanup;
begin
end;

procedure BIO_set_md(v1: PBIO; const md: PEVP_MD);
begin
  {define BIO_set_md(b,md)  BIO_ctrl(b,BIO_C_SET_MD,0,(char *)(md))}
  BIO_ctrl(v1,BIO_C_SET_MD,0,PIdAnsiChar(md));
end;

{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
