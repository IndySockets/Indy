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

unit IdOpenSSLHeaders_rsa;

interface

// Headers for OpenSSL 1.1.1
// rsa.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_evp;

(* The types RSA and RSA_METHOD are defined in ossl_typ.h *)

const
  OPENSSL_RSA_MAX_MODULUS_BITS =  16384;
  OPENSSL_RSA_FIPS_MIN_MODULUS_BITS = 1024;
  OPENSSL_RSA_SMALL_MODULUS_BITS = 3072;
  (* exponent limit enforced for "large" modulus only *)
  OPENSSL_RSA_MAX_PUBEXP_BITS =  64;

  RSA_3 =  TIdC_Long($3);
  RSA_F4 = TIdC_Long($10001);

  (* based on RFC 8017 appendix A.1.2 *)
  RSA_ASN1_VERSION_DEFAULT = 0;
  RSA_ASN1_VERSION_MULTI =   1;
  RSA_DEFAULT_PRIME_NUM =    2;

  RSA_METHOD_FLAG_NO_CHECK = $0001; (* don't check pub/private match *)
  RSA_FLAG_CACHE_PUBLIC =    $0002;
  RSA_FLAG_CACHE_PRIVATE =   $0004;
  RSA_FLAG_BLINDING =        $0008;
  RSA_FLAG_THREAD_SAFE =     $0010;
  (*
   * This flag means the private key operations will be handled by rsa_mod_exp
   * and that they do not depend on the private key components being present:
   * for example a key stored in external hardware. Without this flag
   * bn_mod_exp gets called when private key components are absent.
   *)
  RSA_FLAG_EXT_PKEY =        $0020;
  (*
   * new with 0.9.6j and 0.9.7b; the built-in
   * RSA implementation now uses blinding by
   * default (ignoring RSA_FLAG_BLINDING),
   * but other engines might not need it
   *)
  RSA_FLAG_NO_BLINDING =     $0080;
  (*
   * Does nothing. Previously this switched off constant time behaviour.
   *)
  RSA_FLAG_NO_CONSTTIME =    $0000;

  (* Salt length matches digest *)
  RSA_PSS_SALTLEN_DIGEST = -1;
  (* Verify only: auto detect salt length *)
  RSA_PSS_SALTLEN_AUTO = -2;
  (* Set salt length to maximum possible *)
  RSA_PSS_SALTLEN_MAX = -3;
  (* Old compatible max salt length for sign only *)
  RSA_PSS_SALTLEN_MAX_SIGN = -2;

  EVP_PKEY_CTRL_RSA_PADDING = EVP_PKEY_ALG_CTRL + 1;
  EVP_PKEY_CTRL_RSA_PSS_SALTLEN = EVP_PKEY_ALG_CTRL + 2;

  EVP_PKEY_CTRL_RSA_KEYGEN_BITS = EVP_PKEY_ALG_CTRL + 3;
  EVP_PKEY_CTRL_RSA_KEYGEN_PUBEXP = EVP_PKEY_ALG_CTRL + 4;
  EVP_PKEY_CTRL_RSA_MGF1_MD = EVP_PKEY_ALG_CTRL + 5;

  EVP_PKEY_CTRL_GET_RSA_PADDING =  EVP_PKEY_ALG_CTRL + 6;
  EVP_PKEY_CTRL_GET_RSA_PSS_SALTLEN = EVP_PKEY_ALG_CTRL + 7;
  EVP_PKEY_CTRL_GET_RSA_MGF1_MD =  EVP_PKEY_ALG_CTRL + 8;

  EVP_PKEY_CTRL_RSA_OAEP_MD = EVP_PKEY_ALG_CTRL + 9;
  EVP_PKEY_CTRL_RSA_OAEP_LABEL = EVP_PKEY_ALG_CTRL + 10;

  EVP_PKEY_CTRL_GET_RSA_OAEP_MD = EVP_PKEY_ALG_CTRL + 11;
  EVP_PKEY_CTRL_GET_RSA_OAEP_LABEL = EVP_PKEY_ALG_CTRL + 12;

  EVP_PKEY_CTRL_RSA_KEYGEN_PRIMES = EVP_PKEY_ALG_CTRL + 13;

  RSA_PKCS1_PADDING =   1;
  RSA_SSLV23_PADDING =  2;
  RSA_NO_PADDING =   3;
  RSA_PKCS1_OAEP_PADDING = 4;
  RSA_X931_PADDING =   5;
  RSA_PKCS1_PSS_PADDING =  6; (* EVP_PKEY_ only *)
  RSA_PKCS1_PADDING_SIZE = 11;

  (*
   * If this flag is set the RSA method is FIPS compliant and can be used in
   * FIPS mode. This is set in the validated module method. If an application
   * sets this flag in its own methods it is its responsibility to ensure the
   * result is compliant.
   *)
  RSA_FLAG_FIPS_METHOD = $0400;
  (*
   * If this flag is set the operations normally disabled in FIPS mode are
   * permitted it is then the applications responsibility to ensure that the
   * usage is compliant.
   *)
  RSA_FLAG_NON_FIPS_ALLOW = $0400;
  (*
   * Application has decided PRNG is good enough to generate a key: don't
   * check.
   *)
  RSA_FLAG_CHECKED = $0800;

type
  rsa_pss_params_st = record
    hashAlgorithm: PX509_ALGOR;
    maskGenAlgorithm: PX509_ALGOR;
    saltLength: PASN1_INTEGER;
    trailerField: PASN1_INTEGER;
    (* Decoded hash algorithm from maskGenAlgorithm *)
    maskHash: PX509_ALGOR;
  end;
  RSA_PSS_PARAMS = rsa_pss_params_st;
  // DECLARE_ASN1_FUNCTIONS(RSA_PSS_PARAMS)

  rsa_oaep_params_st = record
    hashFunc: PX509_ALGOR;
    maskGenFunc: PX509_ALGOR;
    pSourceFunc: PX509_ALGOR;
    (* Decoded hash algorithm from maskGenFunc *)
    maskHash: PX509_ALGOR;
  end;
  RSA_OAEP_PARAMS = rsa_oaep_params_st;
  //DECLARE_ASN1_FUNCTIONS(RSA_OAEP_PARAMS)

  //DECLARE_ASN1_ENCODE_FUNCTIONS_const(RSA, RSAPublicKey)
  //DECLARE_ASN1_ENCODE_FUNCTIONS_const(RSA, RSAPrivateKey)

  RSA_meth_set_priv_dec_priv_dec = function(flen: TIdC_INT; const from: PByte;
    to_: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT; cdecl;

  RSA_meth_set_mod_exp_mod_exp = function(r0: PBIGNUM; const i: PBIGNUM;
    rsa: PRSA; ctx: PBN_CTX): TIdC_INT; cdecl;

  RSA_meth_set_bn_mod_exp_bn_mod_exp = function(r: PBIGNUM; const a: PBIGNUM;
    const p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTx; m_ctx: PBN_MONT_CTx): TIdC_INT; cdecl;

  RSA_meth_set_init_init = function(rsa: PRSA): TIdC_INT; cdecl;

  RSA_meth_set_finish_finish = function(rsa: PRSA): TIdC_INT; cdecl;

  RSA_meth_set_sign_sign = function(&type: TIdC_INT; const m: PByte;
    m_length: TIdC_UINT; sigret: PByte; siglen: PIdC_UINT; const rsa: PRSA): TIdC_INT; cdecl;

  RSA_meth_set_verify_verify = function(dtype: TIdC_INT; const m: PByte;
    m_length: TIdC_UINT; const sigbuf: PByte; siglen: TIdC_UINT; const rsa: PRSA): TIdC_INT; cdecl;

  RSA_meth_set_keygen_keygen = function(rsa: PRSA; bits: TIdC_INT; e: PBIGNUM; cb: PBN_GENCb): TIdC_INT; cdecl;

  RSA_meth_set_multi_prime_keygen_keygen = function(rsa: PRSA; bits: TIdC_INT;
    primes: TIdC_INT; e: PBIGNUM; cb: PBN_GENCb): TIdC_INT; cdecl;

//# define EVP_PKEY_CTX_set_rsa_padding(ctx, pad) \
//        RSA_pkey_ctx_ctrl(ctx, -1, EVP_PKEY_CTRL_RSA_PADDING, pad, NULL)
//
//# define EVP_PKEY_CTX_get_rsa_padding(ctx, ppad) \
//        RSA_pkey_ctx_ctrl(ctx, -1, EVP_PKEY_CTRL_GET_RSA_PADDING, 0, ppad)
//
//# define EVP_PKEY_CTX_set_rsa_pss_saltlen(ctx, len) \
//        RSA_pkey_ctx_ctrl(ctx, (EVP_PKEY_OP_SIGN|EVP_PKEY_OP_VERIFY), \
//                          EVP_PKEY_CTRL_RSA_PSS_SALTLEN, len, NULL)

//# define EVP_PKEY_CTX_set_rsa_pss_keygen_saltlen(ctx, len) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA_PSS, EVP_PKEY_OP_KEYGEN, \
//                          EVP_PKEY_CTRL_RSA_PSS_SALTLEN, len, NULL)
//
//# define EVP_PKEY_CTX_get_rsa_pss_saltlen(ctx, plen) \
//        RSA_pkey_ctx_ctrl(ctx, (EVP_PKEY_OP_SIGN|EVP_PKEY_OP_VERIFY), \
//                          EVP_PKEY_CTRL_GET_RSA_PSS_SALTLEN, 0, plen)
//
//# define EVP_PKEY_CTX_set_rsa_keygen_bits(ctx, bits) \
//        RSA_pkey_ctx_ctrl(ctx, EVP_PKEY_OP_KEYGEN, \
//                          EVP_PKEY_CTRL_RSA_KEYGEN_BITS, bits, NULL)
//
//# define EVP_PKEY_CTX_set_rsa_keygen_pubexp(ctx, pubexp) \
//        RSA_pkey_ctx_ctrl(ctx, EVP_PKEY_OP_KEYGEN, \
//                          EVP_PKEY_CTRL_RSA_KEYGEN_PUBEXP, 0, pubexp)
//
//# define EVP_PKEY_CTX_set_rsa_keygen_primes(ctx, primes) \
//        RSA_pkey_ctx_ctrl(ctx, EVP_PKEY_OP_KEYGEN, \
//                          EVP_PKEY_CTRL_RSA_KEYGEN_PRIMES, primes, NULL)
//
//# define  EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, md) \
//        RSA_pkey_ctx_ctrl(ctx, EVP_PKEY_OP_TYPE_SIG | EVP_PKEY_OP_TYPE_CRYPT, \
//                          EVP_PKEY_CTRL_RSA_MGF1_MD, 0, (void *)(md))
//
//# define  EVP_PKEY_CTX_set_rsa_pss_keygen_mgf1_md(ctx, md) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA_PSS, EVP_PKEY_OP_KEYGEN, \
//                          EVP_PKEY_CTRL_RSA_MGF1_MD, 0, (void *)(md))
//
//# define  EVP_PKEY_CTX_set_rsa_oaep_md(ctx, md) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA, EVP_PKEY_OP_TYPE_CRYPT,  \
//                          EVP_PKEY_CTRL_RSA_OAEP_MD, 0, (void *)(md))
//
//# define  EVP_PKEY_CTX_get_rsa_mgf1_md(ctx, pmd) \
//        RSA_pkey_ctx_ctrl(ctx, EVP_PKEY_OP_TYPE_SIG | EVP_PKEY_OP_TYPE_CRYPT, \
//                          EVP_PKEY_CTRL_GET_RSA_MGF1_MD, 0, (void *)(pmd))
//
//# define  EVP_PKEY_CTX_get_rsa_oaep_md(ctx, pmd) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA, EVP_PKEY_OP_TYPE_CRYPT,  \
//                          EVP_PKEY_CTRL_GET_RSA_OAEP_MD, 0, (void *)(pmd))
//
//# define  EVP_PKEY_CTX_set0_rsa_oaep_label(ctx, l, llen) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA, EVP_PKEY_OP_TYPE_CRYPT,  \
//                          EVP_PKEY_CTRL_RSA_OAEP_LABEL, llen, (void *)(l))
//
//# define  EVP_PKEY_CTX_get0_rsa_oaep_label(ctx, l) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA, EVP_PKEY_OP_TYPE_CRYPT,  \
//                          EVP_PKEY_CTRL_GET_RSA_OAEP_LABEL, 0, (void *)(l))
//
//# define  EVP_PKEY_CTX_set_rsa_pss_keygen_md(ctx, md) \
//        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_RSA_PSS,  \
//                          EVP_PKEY_OP_KEYGEN, EVP_PKEY_CTRL_MD,  \
//                          0, (void *)(md))

//# define RSA_set_app_data(s,arg)         RSA_set_ex_data(s,0,arg)
//# define RSA_get_app_data(s)             RSA_get_ex_data(s,0)

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  RSA_new: function: PRSA cdecl = nil;
  RSA_new_method: function(engine: PENGINE): PRSA cdecl = nil;
  RSA_bits: function(const rsa: PRSA): TIdC_INT cdecl = nil;
  RSA_size: function(const rsa: PRSA): TIdC_INT cdecl = nil;
  RSA_security_bits: function(const rsa: PRSA): TIdC_INT cdecl = nil;

  RSA_set0_key: function(r: PRSA; n: PBIGNUM; e: PBIGNUM; d: PBIGNUM): TIdC_INT cdecl = nil;
  RSA_set0_factors: function(r: PRSA; p: PBIGNUM; q: PBIGNUM): TIdC_INT cdecl = nil;
  RSA_set0_crt_params: function(r: PRSA; dmp1: PBIGNUM; dmq1: PBIGNUM; iqmp: PBIGNUM): TIdC_INT cdecl = nil;
  //function RSA_set0_multi_prime_params(r: PRSA; primes: array of PBIGNUM; exps: array of PBIGNUM; coeffs: array of PBIGNUM; pnum: TIdC_INT): TIdC_INT;

  RSA_get0_key: procedure(const r: PRSA; const n: PPBIGNUM; const e: PPBIGNUM; const d: PPBIGNUM) cdecl = nil;
  RSA_get0_factors: procedure(const r: PRSA; const p: PPBIGNUM; const q: PPBIGNUM) cdecl = nil;
  RSA_get_multi_prime_extra_count: function(const r: PRSA): TIdC_INT cdecl = nil;
  //function RSA_get0_multi_prime_factors(const r: PRSA; const primes: array of PBIGNUM): TIdC_INT;
  RSA_get0_crt_params: procedure(const r: PRSA; const dmp1: PPBIGNUM; const dmq1: PPBIGNUM; const iqmp: PPBIGNUM) cdecl = nil;

  //function RSA_get0_multi_prime_crt_params(const r: PRSA; const exps: array of PBIGNUM; const coeffs: array of PBIGNUM): TIdC_INT;

  RSA_get0_n: function(const d: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_e: function(const d: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_d: function(const d: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_p: function(const d: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_q: function(const d: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_dmp1: function(const r: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_dmq1: function(const r: PRSA): PBIGNUM cdecl = nil;
  RSA_get0_iqmp: function(const r: PRSA): PBIGNUM cdecl = nil;

  RSA_clear_flags: procedure(r: PRSA; flags: TIdC_INT) cdecl = nil;
  RSA_test_flags: function(const r: PRSA; flags: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_set_flags: procedure(r: PRSA; flags: TIdC_INT) cdecl = nil;
  RSA_get_version: function(r: PRSA): TIdC_INT cdecl = nil;
  RSA_get0_engine: function(const r: PRSA): PENGINE cdecl = nil;

  (* New version *)
  RSA_generate_key_ex: function(rsa: PRSA; bits: TIdC_INT; e: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  (* Multi-prime version *)
  RSA_generate_multi_prime_key: function(rsa: PRSA; bits: TIdC_INT; primes: TIdC_INT; e: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  RSA_X931_derive_ex: function(rsa: PRSA; p1: PBIGNUM; p2: PBIGNUM; q1: PBIGNUM; q2: PBIGNUM; const Xp1: PBIGNUM; const Xp2: PBIGNUM; const Xp: PBIGNUM; const Xq1: PBIGNUM; const Xq2: PBIGNUM; const Xq: PBIGNUM; const e: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  RSA_X931_generate_key_ex: function(rsa: PRSA; bits: TIdC_INT; const e: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl = nil;

  RSA_check_key: function(const v1: PRSA): TIdC_INT cdecl = nil;
  RSA_check_key_ex: function(const v1: PRSA; cb: BN_GENCB): TIdC_INT cdecl = nil;
  (* next 4 return -1 on error *)
  RSA_public_encrypt: function(flen: TIdC_INT; const from: PByte; to_: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_private_encrypt: function(flen: TIdC_INT; const from: PByte; to_: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_public_decrypt: function(flen: TIdC_INT; const from: PByte; to_: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_private_decrypt: function(flen: TIdC_INT; const from: PByte; to_: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl = nil;

  RSA_free: procedure(r: PRSA) cdecl = nil;
  (* "up" the RSA object's reference count *)
  RSA_up_ref: function(r: PRSA): TIdC_INT cdecl = nil;

  RSA_flags: function(const r: PRSA): TIdC_INT cdecl = nil;

  RSA_set_default_method: procedure(const meth: PRSA_METHOD) cdecl = nil;
  RSA_get_default_method: function: PRSA_METHOD cdecl = nil;
  RSA_null_method: function: PRSA_METHOD cdecl = nil;
  RSA_get_method: function(const rsa: PRSA): PRSA_METHOD cdecl = nil;
  RSA_set_method: function(rsa: PRSA; const meth: PRSA_METHOD): TIdC_INT cdecl = nil;

  (* these are the actual RSA functions *)
  RSA_PKCS1_OpenSSL: function: PRSA_METHOD cdecl = nil;

  RSA_pkey_ctx_ctrl: function(ctx: PEVP_PKEY_CTX; optype: TIdC_INT; cmd: TIdC_INT; p1: TIdC_INT; p2: Pointer): TIdC_INT cdecl = nil;

  RSA_print: function(bp: PBIO; const r: PRSA; offset: TIdC_INT): TIdC_INT cdecl = nil;

  (*
   * The following 2 functions sign and verify a X509_SIG ASN1 object inside
   * PKCS#1 padded RSA encryption
   *)
  RSA_sign: function(&type: TIdC_INT; const m: PByte; m_length: TIdC_UINT; sigret: PByte; siglen: PIdC_UINT; rsa: PRSA): TIdC_INT cdecl = nil;
  RSA_verify: function(&type: TIdC_INT; const m: PByte; m_length: TIdC_UINT; const sigbuf: PByte; siglen: TIdC_UINT; rsa: PRSA): TIdC_INT cdecl = nil;

  (*
   * The following 2 function sign and verify a ASN1_OCTET_STRING object inside
   * PKCS#1 padded RSA encryption
   *)
  RSA_sign_ASN1_OCTET_STRING: function(&type: TIdC_INT; const m: PByte; m_length: TIdC_UINT; sigret: PByte; siglen: PIdC_UINT; rsa: PRSA): TIdC_INT cdecl = nil;
  RSA_verify_ASN1_OCTET_STRING: function(&type: TIdC_INT; const m: PByte; m_length: TIdC_UINT; sigbuf: PByte; siglen: TIdC_UINT; rsa: PRSA): TIdC_INT cdecl = nil;

  RSA_blinding_on: function(rsa: PRSA; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  RSA_blinding_off: procedure(rsa: PRSA) cdecl = nil;
  RSA_setup_blinding: function(rsa: PRSA; ctx: PBN_CTX): PBN_BLINDING cdecl = nil;
  RSA_padding_add_PKCS1_type_1: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_PKCS1_type_1: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_PKCS1_type_2: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_PKCS1_type_2: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT): TIdC_INT cdecl = nil;
  PKCS1_MGF1: function(mask: PByte; len: TIdC_LONG; const seed: PByte; seedlen: TIdC_LONG; const dgst: PEVP_MD): TIdC_INT cdecl = nil;
  RSA_padding_add_PKCS1_OAEP: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; const p: PByte; pl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_PKCS1_OAEP: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT; const p: PByte; pl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_PKCS1_OAEP_mgf1: function(&to: PByte; tlen: TIdC_INT; const from: PByte; flen: TIdC_INT; const param: PByte; plen: TIdC_INT; const md: PEVP_MD; const mgf1md: PEVP_MD): TIdC_INT cdecl = nil;
  RSA_padding_check_PKCS1_OAEP_mgf1: function(&to: PByte; tlen: TIdC_INT; const from: PByte; flen: TIdC_INT; num: TIdC_INT; const param: PByte; plen: TIdC_INT; const md: PEVP_MD; const mgf1md: PEVP_MD): TIdC_INT cdecl = nil;
  RSA_padding_add_SSLv23: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_SSLv23: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_none: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_none: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_X931: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_check_X931: function(&to: PByte; tlen: TIdC_INT; const f: PByte; fl: TIdC_INT; rsa_len: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_X931_hash_id: function(nid: TIdC_INT): TIdC_INT cdecl = nil;

  RSA_verify_PKCS1_PSS: function(rsa: PRSA; const mHash: PByte; const Hash: PEVP_MD; const EM: PByte; sLen: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_PKCS1_PSS: function(rsa: PRSA; EM: PByte; const mHash: PByte; const Hash: PEVP_MD; sLen: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_verify_PKCS1_PSS_mgf1: function(rsa: PRSA; const mHash: PByte; const Hash: PEVP_MD; const mgf1Hash: PEVP_MD; const EM: PByte; sLen: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_padding_add_PKCS1_PSS_mgf1: function(rsa: PRSA; EM: PByte; const mHash: PByte; const Hash: PEVP_MD; const mgf1Hash: PEVP_MD; sLen: TIdC_INT): TIdC_INT cdecl = nil;

  //#define RSA_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_RSA, l, p, newf, dupf, freef)

  RSA_set_ex_data: function(r: PRSA; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  RSA_get_ex_data: function(const r: PRSA; idx: TIdC_INT): Pointer cdecl = nil;
  RSAPublicKey_dup: function(rsa: PRSA): PRSA cdecl = nil;
  RSAPrivateKey_dup: function(rsa: PRSA): PRSA cdecl = nil;

  RSA_meth_new: function(const name: PIdAnsiChar; flags: TIdC_INT): PRSA_METHOD cdecl = nil;
  RSA_meth_free: procedure(meth: PRSA_METHOD) cdecl = nil;
  RSA_meth_dup: function(const meth: PRSA_METHOD): PRSA_METHOD cdecl = nil;
  RSA_meth_get0_name: function(const meth: PRSA_METHOD): PIdAnsiChar cdecl = nil;
  RSA_meth_set1_name: function(meth: PRSA_METHOD; const name: PIdAnsiChar): TIdC_INT cdecl = nil;
  RSA_meth_get_flags: function(const meth: PRSA_METHOD): TIdC_INT cdecl = nil;
  RSA_meth_set_flags: function(meth: PRSA_METHOD; flags: TIdC_INT): TIdC_INT cdecl = nil;
  RSA_meth_get0_app_data: function(const meth: PRSA_METHOD): Pointer cdecl = nil;
  RSA_meth_set0_app_data: function(meth: PRSA_METHOD; app_data: Pointer): TIdC_INT cdecl = nil;

  //int (*RSA_meth_get_pub_enc(const RSA_METHOD *meth))
  //    (int flen, const unsigned char *from,
  //     unsigned char *&to, RSA *rsa, int padding);
  //int RSA_meth_set_pub_enc(RSA_METHOD *rsa,
  //                         int (*pub_enc) (int flen, const unsigned char *from,
  //                                         unsigned char *&to, RSA *rsa,
  //                                         int padding));
  //int (*RSA_meth_get_pub_dec(const RSA_METHOD *meth))
  //    (int flen, const unsigned char *from,
  //     unsigned char *&to, RSA *rsa, int padding);
  //int RSA_meth_set_pub_dec(RSA_METHOD *rsa,
  //                         int (*pub_dec) (int flen, const unsigned char *from,
  //                                         unsigned char *&to, RSA *rsa,
  //                                         int padding));
  //int (*RSA_meth_get_priv_enc(const RSA_METHOD *meth))
  //    (int flen, const unsigned char *from,
  //     unsigned char *&to, RSA *rsa, int padding);
  //int RSA_meth_set_priv_enc(RSA_METHOD *rsa,
  //                          int (*priv_enc) (int flen, const unsigned char *from,
  //                                           unsigned char *&to, RSA *rsa,
  //                                           int padding));
  //int (*RSA_meth_get_priv_dec(const RSA_METHOD *meth))
  //    (int flen, const unsigned char *from,
  //     unsigned char *&to, RSA *rsa, int padding);
  RSA_meth_set_priv_dec: function(rsa: PRSA_METHOD; priv_dec: RSA_meth_set_priv_dec_priv_dec): TIdC_INT cdecl = nil;

  //int (*RSA_meth_get_mod_exp(const RSA_METHOD *meth))
  //    (BIGNUM *r0, const BIGNUM *i, RSA *rsa, BN_CTX *ctx);
  RSA_meth_set_mod_exp: function(rsa: PRSA_METHOD; mod_exp: RSA_meth_set_mod_exp_mod_exp): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_bn_mod_exp(const RSA_METHOD *meth))
  //    (BIGNUM *r, const BIGNUM *a, const BIGNUM *p,
  //     const BIGNUM *m, BN_CTX *ctx, BN_MONT_CTX *m_ctx);
  RSA_meth_set_bn_mod_exp: function(rsa: PRSA_METHOD; bn_mod_exp: RSA_meth_set_bn_mod_exp_bn_mod_exp): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_init(const RSA_METHOD *meth)) (RSA *rsa);
  RSA_meth_set_init: function(rsa: PRSA_METHOD; init: RSA_meth_set_init_init): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_finish(const RSA_METHOD *meth)) (RSA *rsa);
  RSA_meth_set_finish: function(rsa: PRSA_METHOD; finish: RSA_meth_set_finish_finish): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_sign(const RSA_METHOD *meth))
  //    (int type_,
  //     const unsigned char *m, unsigned int m_length,
  //     unsigned char *sigret, unsigned int *siglen,
  //     const RSA *rsa);
  RSA_meth_set_sign: function(rsa: PRSA_METHOD; sign: RSA_meth_set_sign_sign): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_verify(const RSA_METHOD *meth))
  //    (int dtype, const unsigned char *m,
  //     unsigned int m_length, const unsigned char *sigbuf,
  //     unsigned int siglen, const RSA *rsa);
  RSA_meth_set_verify: function(rsa: PRSA_METHOD; verify: RSA_meth_set_verify_verify): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_keygen(const RSA_METHOD *meth))
  //    (RSA *rsa, int bits, BIGNUM *e, BN_GENCB *cb);
  RSA_meth_set_keygen: function(rsa: PRSA_METHOD; keygen: RSA_meth_set_keygen_keygen): TIdC_INT cdecl = nil;
  //int (*RSA_meth_get_multi_prime_keygen(const RSA_METHOD *meth))
  //    (RSA *rsa, int bits, int primes, BIGNUM *e, BN_GENCB *cb);
  RSA_meth_set_multi_prime_keygen: function(meth: PRSA_METHOD; keygen: RSA_meth_set_multi_prime_keygen_keygen): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  RSA_new := LoadFunction('RSA_new', AFailed);
  RSA_new_method := LoadFunction('RSA_new_method', AFailed);
  RSA_bits := LoadFunction('RSA_bits', AFailed);
  RSA_size := LoadFunction('RSA_size', AFailed);
  RSA_security_bits := LoadFunction('RSA_security_bits', AFailed);
  RSA_set0_key := LoadFunction('RSA_set0_key', AFailed);
  RSA_set0_factors := LoadFunction('RSA_set0_factors', AFailed);
  RSA_set0_crt_params := LoadFunction('RSA_set0_crt_params', AFailed);
  RSA_get0_key := LoadFunction('RSA_get0_key', AFailed);
  RSA_get0_factors := LoadFunction('RSA_get0_factors', AFailed);
  RSA_get_multi_prime_extra_count := LoadFunction('RSA_get_multi_prime_extra_count', AFailed);
  RSA_get0_crt_params := LoadFunction('RSA_get0_crt_params', AFailed);
  RSA_get0_n := LoadFunction('RSA_get0_n', AFailed);
  RSA_get0_e := LoadFunction('RSA_get0_e', AFailed);
  RSA_get0_d := LoadFunction('RSA_get0_d', AFailed);
  RSA_get0_p := LoadFunction('RSA_get0_p', AFailed);
  RSA_get0_q := LoadFunction('RSA_get0_q', AFailed);
  RSA_get0_dmp1 := LoadFunction('RSA_get0_dmp1', AFailed);
  RSA_get0_dmq1 := LoadFunction('RSA_get0_dmq1', AFailed);
  RSA_get0_iqmp := LoadFunction('RSA_get0_iqmp', AFailed);
  RSA_clear_flags := LoadFunction('RSA_clear_flags', AFailed);
  RSA_test_flags := LoadFunction('RSA_test_flags', AFailed);
  RSA_set_flags := LoadFunction('RSA_set_flags', AFailed);
  RSA_get_version := LoadFunction('RSA_get_version', AFailed);
  RSA_get0_engine := LoadFunction('RSA_get0_engine', AFailed);
  RSA_generate_key_ex := LoadFunction('RSA_generate_key_ex', AFailed);
  RSA_generate_multi_prime_key := LoadFunction('RSA_generate_multi_prime_key', AFailed);
  RSA_X931_derive_ex := LoadFunction('RSA_X931_derive_ex', AFailed);
  RSA_X931_generate_key_ex := LoadFunction('RSA_X931_generate_key_ex', AFailed);
  RSA_check_key := LoadFunction('RSA_check_key', AFailed);
  RSA_check_key_ex := LoadFunction('RSA_check_key_ex', AFailed);
  RSA_public_encrypt := LoadFunction('RSA_public_encrypt', AFailed);
  RSA_private_encrypt := LoadFunction('RSA_private_encrypt', AFailed);
  RSA_public_decrypt := LoadFunction('RSA_public_decrypt', AFailed);
  RSA_private_decrypt := LoadFunction('RSA_private_decrypt', AFailed);
  RSA_free := LoadFunction('RSA_free', AFailed);
  RSA_up_ref := LoadFunction('RSA_up_ref', AFailed);
  RSA_flags := LoadFunction('RSA_flags', AFailed);
  RSA_set_default_method := LoadFunction('RSA_set_default_method', AFailed);
  RSA_get_default_method := LoadFunction('RSA_get_default_method', AFailed);
  RSA_null_method := LoadFunction('RSA_null_method', AFailed);
  RSA_get_method := LoadFunction('RSA_get_method', AFailed);
  RSA_set_method := LoadFunction('RSA_set_method', AFailed);
  RSA_PKCS1_OpenSSL := LoadFunction('RSA_PKCS1_OpenSSL', AFailed);
  RSA_pkey_ctx_ctrl := LoadFunction('RSA_pkey_ctx_ctrl', AFailed);
  RSA_print := LoadFunction('RSA_print', AFailed);
  RSA_sign := LoadFunction('RSA_sign', AFailed);
  RSA_verify := LoadFunction('RSA_verify', AFailed);
  RSA_sign_ASN1_OCTET_STRING := LoadFunction('RSA_sign_ASN1_OCTET_STRING', AFailed);
  RSA_verify_ASN1_OCTET_STRING := LoadFunction('RSA_verify_ASN1_OCTET_STRING', AFailed);
  RSA_blinding_on := LoadFunction('RSA_blinding_on', AFailed);
  RSA_blinding_off := LoadFunction('RSA_blinding_off', AFailed);
  RSA_setup_blinding := LoadFunction('RSA_setup_blinding', AFailed);
  RSA_padding_add_PKCS1_type_1 := LoadFunction('RSA_padding_add_PKCS1_type_1', AFailed);
  RSA_padding_check_PKCS1_type_1 := LoadFunction('RSA_padding_check_PKCS1_type_1', AFailed);
  RSA_padding_add_PKCS1_type_2 := LoadFunction('RSA_padding_add_PKCS1_type_2', AFailed);
  RSA_padding_check_PKCS1_type_2 := LoadFunction('RSA_padding_check_PKCS1_type_2', AFailed);
  PKCS1_MGF1 := LoadFunction('PKCS1_MGF1', AFailed);
  RSA_padding_add_PKCS1_OAEP := LoadFunction('RSA_padding_add_PKCS1_OAEP', AFailed);
  RSA_padding_check_PKCS1_OAEP := LoadFunction('RSA_padding_check_PKCS1_OAEP', AFailed);
  RSA_padding_add_PKCS1_OAEP_mgf1 := LoadFunction('RSA_padding_add_PKCS1_OAEP_mgf1', AFailed);
  RSA_padding_check_PKCS1_OAEP_mgf1 := LoadFunction('RSA_padding_check_PKCS1_OAEP_mgf1', AFailed);
  RSA_padding_add_SSLv23 := LoadFunction('RSA_padding_add_SSLv23', AFailed);
  RSA_padding_check_SSLv23 := LoadFunction('RSA_padding_check_SSLv23', AFailed);
  RSA_padding_add_none := LoadFunction('RSA_padding_add_none', AFailed);
  RSA_padding_check_none := LoadFunction('RSA_padding_check_none', AFailed);
  RSA_padding_add_X931 := LoadFunction('RSA_padding_add_X931', AFailed);
  RSA_padding_check_X931 := LoadFunction('RSA_padding_check_X931', AFailed);
  RSA_X931_hash_id := LoadFunction('RSA_X931_hash_id', AFailed);
  RSA_verify_PKCS1_PSS := LoadFunction('RSA_verify_PKCS1_PSS', AFailed);
  RSA_padding_add_PKCS1_PSS := LoadFunction('RSA_padding_add_PKCS1_PSS', AFailed);
  RSA_verify_PKCS1_PSS_mgf1 := LoadFunction('RSA_verify_PKCS1_PSS_mgf1', AFailed);
  RSA_padding_add_PKCS1_PSS_mgf1 := LoadFunction('RSA_padding_add_PKCS1_PSS_mgf1', AFailed);
  RSA_set_ex_data := LoadFunction('RSA_set_ex_data', AFailed);
  RSA_get_ex_data := LoadFunction('RSA_get_ex_data', AFailed);
  RSAPublicKey_dup := LoadFunction('RSAPublicKey_dup', AFailed);
  RSAPrivateKey_dup := LoadFunction('RSAPrivateKey_dup', AFailed);
  RSA_meth_new := LoadFunction('RSA_meth_new', AFailed);
  RSA_meth_free := LoadFunction('RSA_meth_free', AFailed);
  RSA_meth_dup := LoadFunction('RSA_meth_dup', AFailed);
  RSA_meth_get0_name := LoadFunction('RSA_meth_get0_name', AFailed);
  RSA_meth_set1_name := LoadFunction('RSA_meth_set1_name', AFailed);
  RSA_meth_get_flags := LoadFunction('RSA_meth_get_flags', AFailed);
  RSA_meth_set_flags := LoadFunction('RSA_meth_set_flags', AFailed);
  RSA_meth_get0_app_data := LoadFunction('RSA_meth_get0_app_data', AFailed);
  RSA_meth_set0_app_data := LoadFunction('RSA_meth_set0_app_data', AFailed);
  RSA_meth_set_priv_dec := LoadFunction('RSA_meth_set_priv_dec', AFailed);
  RSA_meth_set_mod_exp := LoadFunction('RSA_meth_set_mod_exp', AFailed);
  RSA_meth_set_bn_mod_exp := LoadFunction('RSA_meth_set_bn_mod_exp', AFailed);
  RSA_meth_set_init := LoadFunction('RSA_meth_set_init', AFailed);
  RSA_meth_set_finish := LoadFunction('RSA_meth_set_finish', AFailed);
  RSA_meth_set_sign := LoadFunction('RSA_meth_set_sign', AFailed);
  RSA_meth_set_verify := LoadFunction('RSA_meth_set_verify', AFailed);
  RSA_meth_set_keygen := LoadFunction('RSA_meth_set_keygen', AFailed);
  RSA_meth_set_multi_prime_keygen := LoadFunction('RSA_meth_set_multi_prime_keygen', AFailed);
end;

procedure UnLoad;
begin
  RSA_new := nil;
  RSA_new_method := nil;
  RSA_bits := nil;
  RSA_size := nil;
  RSA_security_bits := nil;
  RSA_set0_key := nil;
  RSA_set0_factors := nil;
  RSA_set0_crt_params := nil;
  RSA_get0_key := nil;
  RSA_get0_factors := nil;
  RSA_get_multi_prime_extra_count := nil;
  RSA_get0_crt_params := nil;
  RSA_get0_n := nil;
  RSA_get0_e := nil;
  RSA_get0_d := nil;
  RSA_get0_p := nil;
  RSA_get0_q := nil;
  RSA_get0_dmp1 := nil;
  RSA_get0_dmq1 := nil;
  RSA_get0_iqmp := nil;
  RSA_clear_flags := nil;
  RSA_test_flags := nil;
  RSA_set_flags := nil;
  RSA_get_version := nil;
  RSA_get0_engine := nil;
  RSA_generate_key_ex := nil;
  RSA_generate_multi_prime_key := nil;
  RSA_X931_derive_ex := nil;
  RSA_X931_generate_key_ex := nil;
  RSA_check_key := nil;
  RSA_check_key_ex := nil;
  RSA_public_encrypt := nil;
  RSA_private_encrypt := nil;
  RSA_public_decrypt := nil;
  RSA_private_decrypt := nil;
  RSA_free := nil;
  RSA_up_ref := nil;
  RSA_flags := nil;
  RSA_set_default_method := nil;
  RSA_get_default_method := nil;
  RSA_null_method := nil;
  RSA_get_method := nil;
  RSA_set_method := nil;
  RSA_PKCS1_OpenSSL := nil;
  RSA_pkey_ctx_ctrl := nil;
  RSA_print := nil;
  RSA_sign := nil;
  RSA_verify := nil;
  RSA_sign_ASN1_OCTET_STRING := nil;
  RSA_verify_ASN1_OCTET_STRING := nil;
  RSA_blinding_on := nil;
  RSA_blinding_off := nil;
  RSA_setup_blinding := nil;
  RSA_padding_add_PKCS1_type_1 := nil;
  RSA_padding_check_PKCS1_type_1 := nil;
  RSA_padding_add_PKCS1_type_2 := nil;
  RSA_padding_check_PKCS1_type_2 := nil;
  PKCS1_MGF1 := nil;
  RSA_padding_add_PKCS1_OAEP := nil;
  RSA_padding_check_PKCS1_OAEP := nil;
  RSA_padding_add_PKCS1_OAEP_mgf1 := nil;
  RSA_padding_check_PKCS1_OAEP_mgf1 := nil;
  RSA_padding_add_SSLv23 := nil;
  RSA_padding_check_SSLv23 := nil;
  RSA_padding_add_none := nil;
  RSA_padding_check_none := nil;
  RSA_padding_add_X931 := nil;
  RSA_padding_check_X931 := nil;
  RSA_X931_hash_id := nil;
  RSA_verify_PKCS1_PSS := nil;
  RSA_padding_add_PKCS1_PSS := nil;
  RSA_verify_PKCS1_PSS_mgf1 := nil;
  RSA_padding_add_PKCS1_PSS_mgf1 := nil;
  RSA_set_ex_data := nil;
  RSA_get_ex_data := nil;
  RSAPublicKey_dup := nil;
  RSAPrivateKey_dup := nil;
  RSA_meth_new := nil;
  RSA_meth_free := nil;
  RSA_meth_dup := nil;
  RSA_meth_get0_name := nil;
  RSA_meth_set1_name := nil;
  RSA_meth_get_flags := nil;
  RSA_meth_set_flags := nil;
  RSA_meth_get0_app_data := nil;
  RSA_meth_set0_app_data := nil;
  RSA_meth_set_priv_dec := nil;
  RSA_meth_set_mod_exp := nil;
  RSA_meth_set_bn_mod_exp := nil;
  RSA_meth_set_init := nil;
  RSA_meth_set_finish := nil;
  RSA_meth_set_sign := nil;
  RSA_meth_set_verify := nil;
  RSA_meth_set_keygen := nil;
  RSA_meth_set_multi_prime_keygen := nil;
end;

end.
