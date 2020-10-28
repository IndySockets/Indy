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

unit IdOpenSSLHeaders_dsa;

interface

// Headers for OpenSSL 1.1.1
// dsa.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_evp;

const
  OPENSSL_DSA_MAX_MODULUS_BITS = 10000;
  OPENSSL_DSA_FIPS_MIN_MODULUS_BITS = 1024;
  DSA_FLAG_CACHE_MONT_P = $01;
  DSA_FLAG_NO_EXP_CONSTTIME = $00;
  DSA_FLAG_FIPS_METHOD = $0400;
  DSA_FLAG_NON_FIPS_ALLOW = $0400;
  DSA_FLAG_FIPS_CHECKED = $0800;

  DSS_prime_checks = 64;

  EVP_PKEY_CTRL_DSA_PARAMGEN_BITS = EVP_PKEY_ALG_CTRL + 1;
  EVP_PKEY_CTRL_DSA_PARAMGEN_Q_BITS = EVP_PKEY_ALG_CTRL + 2;
  EVP_PKEY_CTRL_DSA_PARAMGEN_MD = EVP_PKEY_ALG_CTRL + 3;

type
  DSA_SIG = type Pointer; // DSA_SIG_st
  PDSA_SIG = ^DSA_SIG;
  PPDSA_SIG = ^PDSA_SIG;

  DSA_meth_sign_cb = function (const v1: PByte; v2: TIdC_INT; v3: PDSA): PDSA_SIG cdecl;
  DSA_meth_sign_setup_cb = function (v1: PDSA; v2: PBN_CTX;
    v3: PPBIGNUM; v4: PPBIGNUM): TIdC_INT cdecl;
  DSA_meth_verify_cb = function (const v1: PByte; v2: TIdC_INT;
    v3: PDSA_SIG; v4: PDSA): TIdC_INT cdecl;
  DSA_meth_mod_exp_cb = function (v1: PDSA; v2: PBIGNUM;
    const v3: PBIGNUM; const v4: PBIGNUM; const v5: PBIGNUM; const v6: PBIGNUM;
    const v7: PBIGNUM; v8: PBN_CTX; v9: PBN_MONT_CTX): TIdC_INT cdecl;
  DSA_meth_bn_mod_exp_cb = function (v1: PDSA; v2: PBIGNUM;
    const v3: PBIGNUM; const v4: PBIGNUM; const v5: PBIGNUM; v6: PBN_CTX; v7: PBN_MONT_CTX): TIdC_INT cdecl;
  DSA_meth_init_cb = function(v1: PDSA): TIdC_INT cdecl;
  DSA_meth_finish_cb = function (v1: PDSA): TIdC_INT cdecl;
  DSA_meth_paramgen_cb = function (v1: PDSA; v2: TIdC_INT;
    const v3: PByte; v4: TIdC_INT; v5: PIdC_INT; v6: PIdC_ULONG; v7: PBN_GENCB): TIdC_INT cdecl;
  DSA_meth_keygen_cb = function (v1: PDSA): TIdC_INT cdecl;

//# define d2i_DSAparams_fp(fp,x) (DSA *)ASN1_d2i_fp((char *(*)())DSA_new, \
//                (char *(*)())d2i_DSAparams,(fp),(unsigned char **)(x))
//# define i2d_DSAparams_fp(fp,x) ASN1_i2d_fp(i2d_DSAparams,(fp), \
//                (unsigned char *)(x))
//# define d2i_DSAparams_bio(bp,x) ASN1_d2i_bio_of(DSA,DSA_new,d2i_DSAparams,bp,x)
//# define i2d_DSAparams_bio(bp,x) ASN1_i2d_bio_of_const(DSA,i2d_DSAparams,bp,x)

  function DSAparams_dup(x: PDSA): PDSA cdecl; external CLibCrypto;
  function DSA_SIG_new: PDSA_SIG cdecl; external CLibCrypto;
  procedure DSA_SIG_free(a: PDSA_SIG) cdecl; external CLibCrypto;
  function i2d_DSA_SIG(const a: PDSA_SIG; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_DSA_SIG(v: PPDSA_SIG; const pp: PPByte; length: TIdC_LONG): PDSA_SIG cdecl; external CLibCrypto;
  procedure DSA_SIG_get0(const sig: PDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM) cdecl; external CLibCrypto;
  function DSA_SIG_set0(sig: PDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  
  function DSA_do_sign(const dgst: PByte; dlen: TIdC_INT; dsa: PDSA): PDSA_SIG cdecl; external CLibCrypto;
  function DSA_do_verify(const dgst: PByte; dgst_len: TIdC_INT; sig: PDSA_SIG; dsa: PDSA): TIdC_INT cdecl; external CLibCrypto;
  
  function DSA_OpenSSL: PDSA_METHOD cdecl; external CLibCrypto;
  procedure DSA_set_default_method(const v1: PDSA_METHOD) cdecl; external CLibCrypto;
  function DSA_get_default_method: PDSA_METHOD cdecl; external CLibCrypto;
  function DSA_set_method(dsa: PDSA; const v1: PDSA_METHOD): TIdC_INT cdecl; external CLibCrypto;
  function DSA_get_method(d: PDSA): PDSA_METHOD cdecl; external CLibCrypto;

  function DSA_new: PDSA cdecl; external CLibCrypto;
  function DSA_new_method(engine: PENGINE): PDSA cdecl; external CLibCrypto;
  procedure DSA_free(r: PDSA) cdecl; external CLibCrypto;
  (* "up" the DSA object's reference count *)
  function DSA_up_ref(r: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_size(const v1: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_bits(const d: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_security_bits(const d: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_sign(&type: TIdC_INT; const dgst: PByte; dlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; dsa: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_verify(&type: TIdC_INT; const dgst: PByte; dgst_len: TIdC_INT; const sigbuf: PByte; siglen: TIdC_INT; dsa: PDSA): TIdC_INT cdecl; external CLibCrypto;
  //#define DSA_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_DSA, l, p, newf, dupf, freef)
  function DSA_set_ex_data(d: PDSA; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function DSA_get_ex_data(d: PDSA; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;
  
  function d2i_DSAPublicKey(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl; external CLibCrypto;
  function d2i_DSAPrivateKey(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl; external CLibCrypto;
  function d2i_DSAparams(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl; external CLibCrypto;

  function DSA_generate_parameters_ex(dsa: PDSA; bits: TIdC_INT; const seed: PByte; seed_len: TIdC_INT; counter_ret: PIdC_INT; h_ret: PIdC_ULONG; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;

  function DSA_generate_key(a: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function i2d_DSAPublicKey(const a: PDSA; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function i2d_DSAPrivateKey(const a: PDSA; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function i2d_DSAparams(const a: PDSA; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  
  function DSAparams_print(bp: PBIO; const x: PDSA): TIdC_INT cdecl; external CLibCrypto;
  function DSA_print(bp: PBIO; const x: PDSA; off: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
//  function DSAparams_print_fp(fp: PFile; const x: PDSA): TIdC_INT;
//  function DSA_print_fp(bp: PFile; const x: PDSA; off: TIdC_INT): TIdC_INT;

  //# define DSA_is_prime(n, callback, cb_arg) \
  //        BN_is_prime(n, DSS_prime_checks, callback, NULL, cb_arg)

  (*
   * Convert DSA structure (key or just parameters) into DH structure (be
   * careful to avoid small subgroup attacks when using this!)
   *)
  function DSA_dup_DH(const r: PDSA): PDH cdecl; external CLibCrypto;

  //# define EVP_PKEY_CTX_set_dsa_paramgen_bits(ctx, nbits) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_BITS, nbits, NULL)
  //# define EVP_PKEY_CTX_set_dsa_paramgen_q_bits(ctx, qbits) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_Q_BITS, qbits, NULL)
  //# define EVP_PKEY_CTX_set_dsa_paramgen_md(ctx, md) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_MD, 0, (void *)(md))

  procedure DSA_get0_pqg(const d: PDSA; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM) cdecl; external CLibCrypto;
  function DSA_set0_pqg(d: PDSA; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  procedure DSA_get0_key(const d: PDSA; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM) cdecl; external CLibCrypto;
  function DSA_set0_key(d: PDSA; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function DSA_get0_p(const d: PDSA): PBIGNUM cdecl; external CLibCrypto;
  function DSA_get0_q(const d: PDSA): PBIGNUM cdecl; external CLibCrypto;
  function DSA_get0_g(const d: PDSA): PBIGNUM cdecl; external CLibCrypto;
  function DSA_get0_pub_key(const d: PDSA): PBIGNUM cdecl; external CLibCrypto;
  function DSA_get0_priv_key(const d: PDSA): PBIGNUM cdecl; external CLibCrypto;
  procedure DSA_clear_flags(d: PDSA; flags: TIdC_INT) cdecl; external CLibCrypto;
  function DSA_test_flags(const d: PDSA; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  procedure DSA_set_flags(d: PDSA; flags: TIdC_INT) cdecl; external CLibCrypto;
  function DSA_get0_engine(d: PDSA): PENGINE cdecl; external CLibCrypto;
  
  function DSA_meth_new(const name: PIdAnsiChar; flags: TIdC_INT): PDSA_METHOD cdecl; external CLibCrypto;
  procedure DSA_meth_free(dsam: PDSA_METHOD) cdecl; external CLibCrypto;
  function DSA_meth_dup(const dsam: PDSA_METHOD): PDSA_METHOD cdecl; external CLibCrypto;
  function DSA_meth_get0_name(const dsam: PDSA_METHOD): PIdAnsiChar cdecl; external CLibCrypto;
  function DSA_meth_set1_name(dsam: PDSA_METHOD; const name: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_flags(const dsam: PDSA_METHOD): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_set_flags(dsam: PDSA_METHOD; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get0_app_data(const dsam: PDSA_METHOD): Pointer cdecl; external CLibCrypto;
  function DSA_meth_set0_app_data(dsam: PDSA_METHOD; app_data: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_sign(const dsam: PDSA_METHOD): DSA_meth_sign_cb cdecl; external CLibCrypto;
  function DSA_meth_set_sign(dsam: PDSA_METHOD; sign: DSA_meth_sign_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_sign_setup(const dsam: PDSA_METHOD): DSA_meth_sign_setup_cb cdecl; external CLibCrypto;
  function DSA_meth_set_sign_setup(dsam: PDSA_METHOD; sign_setup: DSA_meth_sign_setup_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_verify(const dsam: PDSA_METHOD): DSA_meth_verify_cb cdecl; external CLibCrypto;
  function DSA_meth_set_verify(dsam: PDSA_METHOD; verify: DSA_meth_verify_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_mod_exp(const dsam: PDSA_METHOD): DSA_meth_mod_exp_cb cdecl; external CLibCrypto;
  function DSA_meth_set_mod_exp(dsam: PDSA_METHOD; mod_exp: DSA_meth_mod_exp_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_bn_mod_exp(const dsam: PDSA_METHOD): DSA_meth_bn_mod_exp_cb cdecl; external CLibCrypto;
  function DSA_meth_set_bn_mod_exp(dsam: PDSA_METHOD; bn_mod_exp: DSA_meth_bn_mod_exp_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_init(const dsam: PDSA_METHOD): DSA_meth_init_cb cdecl; external CLibCrypto;
  function DSA_meth_set_init(dsam: PDSA_METHOD; init: DSA_meth_init_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_finish(const dsam: PDSA_METHOD): DSA_meth_finish_cb cdecl; external CLibCrypto;
  function DSA_meth_set_finish(dsam: PDSA_METHOD; finish: DSA_meth_finish_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_paramgen(const dsam: PDSA_METHOD): DSA_meth_paramgen_cb cdecl; external CLibCrypto;
  function DSA_meth_set_paramgen(dsam: PDSA_METHOD; paramgen: DSA_meth_paramgen_cb): TIdC_INT cdecl; external CLibCrypto;
  function DSA_meth_get_keygen(const dsam: PDSA_METHOD): DSA_meth_keygen_cb cdecl; external CLibCrypto;
  function DSA_meth_set_keygen(dsam: PDSA_METHOD; keygen: DSA_meth_keygen_cb): TIdC_INT cdecl; external CLibCrypto;

implementation

end.
