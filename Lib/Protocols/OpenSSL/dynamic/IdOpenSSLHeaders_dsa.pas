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

unit IdOpenSSLHeaders_dsa;

interface

// Headers for OpenSSL 1.1.1
// dsa.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  DSAparams_dup: function(x: PDSA): PDSA cdecl = nil;
  DSA_SIG_new: function: PDSA_SIG cdecl = nil;
  DSA_SIG_free: procedure(a: PDSA_SIG) cdecl = nil;
  i2d_DSA_SIG: function(const a: PDSA_SIG; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_DSA_SIG: function(v: PPDSA_SIG; const pp: PPByte; length: TIdC_LONG): PDSA_SIG cdecl = nil;
  DSA_SIG_get0: procedure(const sig: PDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM) cdecl = nil;
  DSA_SIG_set0: function(sig: PDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT cdecl = nil;
  
  DSA_do_sign: function(const dgst: PByte; dlen: TIdC_INT; dsa: PDSA): PDSA_SIG cdecl = nil;
  DSA_do_verify: function(const dgst: PByte; dgst_len: TIdC_INT; sig: PDSA_SIG; dsa: PDSA): TIdC_INT cdecl = nil;
  
  DSA_OpenSSL: function: PDSA_METHOD cdecl = nil;
  DSA_set_default_method: procedure(const v1: PDSA_METHOD) cdecl = nil;
  DSA_get_default_method: function: PDSA_METHOD cdecl = nil;
  DSA_set_method: function(dsa: PDSA; const v1: PDSA_METHOD): TIdC_INT cdecl = nil;
  DSA_get_method: function(d: PDSA): PDSA_METHOD cdecl = nil;

  DSA_new: function: PDSA cdecl = nil;
  DSA_new_method: function(engine: PENGINE): PDSA cdecl = nil;
  DSA_free: procedure(r: PDSA) cdecl = nil;
  (* "up" the DSA object's reference count *)
  DSA_up_ref: function(r: PDSA): TIdC_INT cdecl = nil;
  DSA_size: function(const v1: PDSA): TIdC_INT cdecl = nil;
  DSA_bits: function(const d: PDSA): TIdC_INT cdecl = nil;
  DSA_security_bits: function(const d: PDSA): TIdC_INT cdecl = nil;
  DSA_sign: function(&type: TIdC_INT; const dgst: PByte; dlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; dsa: PDSA): TIdC_INT cdecl = nil;
  DSA_verify: function(&type: TIdC_INT; const dgst: PByte; dgst_len: TIdC_INT; const sigbuf: PByte; siglen: TIdC_INT; dsa: PDSA): TIdC_INT cdecl = nil;
  //#define DSA_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_DSA, l, p, newf, dupf, freef)
  DSA_set_ex_data: function(d: PDSA; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  DSA_get_ex_data: function(d: PDSA; idx: TIdC_INT): Pointer cdecl = nil;
  
  d2i_DSAPublicKey: function(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl = nil;
  d2i_DSAPrivateKey: function(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl = nil;
  d2i_DSAparams: function(a: PPDSA; const pp: PPByte; length: TIdC_LONG): PDSA cdecl = nil;

  DSA_generate_parameters_ex: function(dsa: PDSA; bits: TIdC_INT; const seed: PByte; seed_len: TIdC_INT; counter_ret: PIdC_INT; h_ret: PIdC_ULONG; cb: PBN_GENCB): TIdC_INT cdecl = nil;

  DSA_generate_key: function(a: PDSA): TIdC_INT cdecl = nil;
  i2d_DSAPublicKey: function(const a: PDSA; pp: PPByte): TIdC_INT cdecl = nil;
  i2d_DSAPrivateKey: function(const a: PDSA; pp: PPByte): TIdC_INT cdecl = nil;
  i2d_DSAparams: function(const a: PDSA; pp: PPByte): TIdC_INT cdecl = nil;
  
  DSAparams_print: function(bp: PBIO; const x: PDSA): TIdC_INT cdecl = nil;
  DSA_print: function(bp: PBIO; const x: PDSA; off: TIdC_INT): TIdC_INT cdecl = nil;
//  function DSAparams_print_fp(fp: PFile; const x: PDSA): TIdC_INT;
//  function DSA_print_fp(bp: PFile; const x: PDSA; off: TIdC_INT): TIdC_INT;

  //# define DSA_is_prime(n, callback, cb_arg) \
  //        BN_is_prime(n, DSS_prime_checks, callback, NULL, cb_arg)

  (*
   * Convert DSA structure (key or just parameters) into DH structure (be
   * careful to avoid small subgroup attacks when using this!)
   *)
  DSA_dup_DH: function(const r: PDSA): PDH cdecl = nil;

  //# define EVP_PKEY_CTX_set_dsa_paramgen_bits(ctx, nbits) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_BITS, nbits, NULL)
  //# define EVP_PKEY_CTX_set_dsa_paramgen_q_bits(ctx, qbits) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_Q_BITS, qbits, NULL)
  //# define EVP_PKEY_CTX_set_dsa_paramgen_md(ctx, md) \
  //        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DSA, EVP_PKEY_OP_PARAMGEN, \
  //                                EVP_PKEY_CTRL_DSA_PARAMGEN_MD, 0, (void *)(md))

  DSA_get0_pqg: procedure(const d: PDSA; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM) cdecl = nil;
  DSA_set0_pqg: function(d: PDSA; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT cdecl = nil;
  DSA_get0_key: procedure(const d: PDSA; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM) cdecl = nil;
  DSA_set0_key: function(d: PDSA; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT cdecl = nil;
  DSA_get0_p: function(const d: PDSA): PBIGNUM cdecl = nil;
  DSA_get0_q: function(const d: PDSA): PBIGNUM cdecl = nil;
  DSA_get0_g: function(const d: PDSA): PBIGNUM cdecl = nil;
  DSA_get0_pub_key: function(const d: PDSA): PBIGNUM cdecl = nil;
  DSA_get0_priv_key: function(const d: PDSA): PBIGNUM cdecl = nil;
  DSA_clear_flags: procedure(d: PDSA; flags: TIdC_INT) cdecl = nil;
  DSA_test_flags: function(const d: PDSA; flags: TIdC_INT): TIdC_INT cdecl = nil;
  DSA_set_flags: procedure(d: PDSA; flags: TIdC_INT) cdecl = nil;
  DSA_get0_engine: function(d: PDSA): PENGINE cdecl = nil;
  
  DSA_meth_new: function(const name: PIdAnsiChar; flags: TIdC_INT): PDSA_METHOD cdecl = nil;
  DSA_meth_free: procedure(dsam: PDSA_METHOD) cdecl = nil;
  DSA_meth_dup: function(const dsam: PDSA_METHOD): PDSA_METHOD cdecl = nil;
  DSA_meth_get0_name: function(const dsam: PDSA_METHOD): PIdAnsiChar cdecl = nil;
  DSA_meth_set1_name: function(dsam: PDSA_METHOD; const name: PIdAnsiChar): TIdC_INT cdecl = nil;
  DSA_meth_get_flags: function(const dsam: PDSA_METHOD): TIdC_INT cdecl = nil;
  DSA_meth_set_flags: function(dsam: PDSA_METHOD; flags: TIdC_INT): TIdC_INT cdecl = nil;
  DSA_meth_get0_app_data: function(const dsam: PDSA_METHOD): Pointer cdecl = nil;
  DSA_meth_set0_app_data: function(dsam: PDSA_METHOD; app_data: Pointer): TIdC_INT cdecl = nil;
  DSA_meth_get_sign: function(const dsam: PDSA_METHOD): DSA_meth_sign_cb cdecl = nil;
  DSA_meth_set_sign: function(dsam: PDSA_METHOD; sign: DSA_meth_sign_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_sign_setup: function(const dsam: PDSA_METHOD): DSA_meth_sign_setup_cb cdecl = nil;
  DSA_meth_set_sign_setup: function(dsam: PDSA_METHOD; sign_setup: DSA_meth_sign_setup_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_verify: function(const dsam: PDSA_METHOD): DSA_meth_verify_cb cdecl = nil;
  DSA_meth_set_verify: function(dsam: PDSA_METHOD; verify: DSA_meth_verify_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_mod_exp: function(const dsam: PDSA_METHOD): DSA_meth_mod_exp_cb cdecl = nil;
  DSA_meth_set_mod_exp: function(dsam: PDSA_METHOD; mod_exp: DSA_meth_mod_exp_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_bn_mod_exp: function(const dsam: PDSA_METHOD): DSA_meth_bn_mod_exp_cb cdecl = nil;
  DSA_meth_set_bn_mod_exp: function(dsam: PDSA_METHOD; bn_mod_exp: DSA_meth_bn_mod_exp_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_init: function(const dsam: PDSA_METHOD): DSA_meth_init_cb cdecl = nil;
  DSA_meth_set_init: function(dsam: PDSA_METHOD; init: DSA_meth_init_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_finish: function(const dsam: PDSA_METHOD): DSA_meth_finish_cb cdecl = nil;
  DSA_meth_set_finish: function(dsam: PDSA_METHOD; finish: DSA_meth_finish_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_paramgen: function(const dsam: PDSA_METHOD): DSA_meth_paramgen_cb cdecl = nil;
  DSA_meth_set_paramgen: function(dsam: PDSA_METHOD; paramgen: DSA_meth_paramgen_cb): TIdC_INT cdecl = nil;
  DSA_meth_get_keygen: function(const dsam: PDSA_METHOD): DSA_meth_keygen_cb cdecl = nil;
  DSA_meth_set_keygen: function(dsam: PDSA_METHOD; keygen: DSA_meth_keygen_cb): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  DSAparams_dup := LoadFunction('DSAparams_dup', AFailed);
  DSA_SIG_new := LoadFunction('DSA_SIG_new', AFailed);
  DSA_SIG_free := LoadFunction('DSA_SIG_free', AFailed);
  i2d_DSA_SIG := LoadFunction('i2d_DSA_SIG', AFailed);
  d2i_DSA_SIG := LoadFunction('d2i_DSA_SIG', AFailed);
  DSA_SIG_get0 := LoadFunction('DSA_SIG_get0', AFailed);
  DSA_SIG_set0 := LoadFunction('DSA_SIG_set0', AFailed);
  DSA_do_sign := LoadFunction('DSA_do_sign', AFailed);
  DSA_do_verify := LoadFunction('DSA_do_verify', AFailed);
  DSA_OpenSSL := LoadFunction('DSA_OpenSSL', AFailed);
  DSA_set_default_method := LoadFunction('DSA_set_default_method', AFailed);
  DSA_get_default_method := LoadFunction('DSA_get_default_method', AFailed);
  DSA_set_method := LoadFunction('DSA_set_method', AFailed);
  DSA_get_method := LoadFunction('DSA_get_method', AFailed);
  DSA_new := LoadFunction('DSA_new', AFailed);
  DSA_new_method := LoadFunction('DSA_new_method', AFailed);
  DSA_free := LoadFunction('DSA_free', AFailed);
  DSA_up_ref := LoadFunction('DSA_up_ref', AFailed);
  DSA_size := LoadFunction('DSA_size', AFailed);
  DSA_bits := LoadFunction('DSA_bits', AFailed);
  DSA_security_bits := LoadFunction('DSA_security_bits', AFailed);
  DSA_sign := LoadFunction('DSA_sign', AFailed);
  DSA_verify := LoadFunction('DSA_verify', AFailed);
  DSA_set_ex_data := LoadFunction('DSA_set_ex_data', AFailed);
  DSA_get_ex_data := LoadFunction('DSA_get_ex_data', AFailed);
  d2i_DSAPublicKey := LoadFunction('d2i_DSAPublicKey', AFailed);
  d2i_DSAPrivateKey := LoadFunction('d2i_DSAPrivateKey', AFailed);
  d2i_DSAparams := LoadFunction('d2i_DSAparams', AFailed);
  DSA_generate_parameters_ex := LoadFunction('DSA_generate_parameters_ex', AFailed);
  DSA_generate_key := LoadFunction('DSA_generate_key', AFailed);
  i2d_DSAPublicKey := LoadFunction('i2d_DSAPublicKey', AFailed);
  i2d_DSAPrivateKey := LoadFunction('i2d_DSAPrivateKey', AFailed);
  i2d_DSAparams := LoadFunction('i2d_DSAparams', AFailed);
  DSAparams_print := LoadFunction('DSAparams_print', AFailed);
  DSA_print := LoadFunction('DSA_print', AFailed);
  DSA_dup_DH := LoadFunction('DSA_dup_DH', AFailed);
  DSA_get0_pqg := LoadFunction('DSA_get0_pqg', AFailed);
  DSA_set0_pqg := LoadFunction('DSA_set0_pqg', AFailed);
  DSA_get0_key := LoadFunction('DSA_get0_key', AFailed);
  DSA_set0_key := LoadFunction('DSA_set0_key', AFailed);
  DSA_get0_p := LoadFunction('DSA_get0_p', AFailed);
  DSA_get0_q := LoadFunction('DSA_get0_q', AFailed);
  DSA_get0_g := LoadFunction('DSA_get0_g', AFailed);
  DSA_get0_pub_key := LoadFunction('DSA_get0_pub_key', AFailed);
  DSA_get0_priv_key := LoadFunction('DSA_get0_priv_key', AFailed);
  DSA_clear_flags := LoadFunction('DSA_clear_flags', AFailed);
  DSA_test_flags := LoadFunction('DSA_test_flags', AFailed);
  DSA_set_flags := LoadFunction('DSA_set_flags', AFailed);
  DSA_get0_engine := LoadFunction('DSA_get0_engine', AFailed);
  DSA_meth_new := LoadFunction('DSA_meth_new', AFailed);
  DSA_meth_free := LoadFunction('DSA_meth_free', AFailed);
  DSA_meth_dup := LoadFunction('DSA_meth_dup', AFailed);
  DSA_meth_get0_name := LoadFunction('DSA_meth_get0_name', AFailed);
  DSA_meth_set1_name := LoadFunction('DSA_meth_set1_name', AFailed);
  DSA_meth_get_flags := LoadFunction('DSA_meth_get_flags', AFailed);
  DSA_meth_set_flags := LoadFunction('DSA_meth_set_flags', AFailed);
  DSA_meth_get0_app_data := LoadFunction('DSA_meth_get0_app_data', AFailed);
  DSA_meth_set0_app_data := LoadFunction('DSA_meth_set0_app_data', AFailed);
  DSA_meth_get_sign := LoadFunction('DSA_meth_get_sign', AFailed);
  DSA_meth_set_sign := LoadFunction('DSA_meth_set_sign', AFailed);
  DSA_meth_get_sign_setup := LoadFunction('DSA_meth_get_sign_setup', AFailed);
  DSA_meth_set_sign_setup := LoadFunction('DSA_meth_set_sign_setup', AFailed);
  DSA_meth_get_verify := LoadFunction('DSA_meth_get_verify', AFailed);
  DSA_meth_set_verify := LoadFunction('DSA_meth_set_verify', AFailed);
  DSA_meth_get_mod_exp := LoadFunction('DSA_meth_get_mod_exp', AFailed);
  DSA_meth_set_mod_exp := LoadFunction('DSA_meth_set_mod_exp', AFailed);
  DSA_meth_get_bn_mod_exp := LoadFunction('DSA_meth_get_bn_mod_exp', AFailed);
  DSA_meth_set_bn_mod_exp := LoadFunction('DSA_meth_set_bn_mod_exp', AFailed);
  DSA_meth_get_init := LoadFunction('DSA_meth_get_init', AFailed);
  DSA_meth_set_init := LoadFunction('DSA_meth_set_init', AFailed);
  DSA_meth_get_finish := LoadFunction('DSA_meth_get_finish', AFailed);
  DSA_meth_set_finish := LoadFunction('DSA_meth_set_finish', AFailed);
  DSA_meth_get_paramgen := LoadFunction('DSA_meth_get_paramgen', AFailed);
  DSA_meth_set_paramgen := LoadFunction('DSA_meth_set_paramgen', AFailed);
  DSA_meth_get_keygen := LoadFunction('DSA_meth_get_keygen', AFailed);
  DSA_meth_set_keygen := LoadFunction('DSA_meth_set_keygen', AFailed);
end;

procedure UnLoad;
begin
  DSAparams_dup := nil;
  DSA_SIG_new := nil;
  DSA_SIG_free := nil;
  i2d_DSA_SIG := nil;
  d2i_DSA_SIG := nil;
  DSA_SIG_get0 := nil;
  DSA_SIG_set0 := nil;
  DSA_do_sign := nil;
  DSA_do_verify := nil;
  DSA_OpenSSL := nil;
  DSA_set_default_method := nil;
  DSA_get_default_method := nil;
  DSA_set_method := nil;
  DSA_get_method := nil;
  DSA_new := nil;
  DSA_new_method := nil;
  DSA_free := nil;
  DSA_up_ref := nil;
  DSA_size := nil;
  DSA_bits := nil;
  DSA_security_bits := nil;
  DSA_sign := nil;
  DSA_verify := nil;
  DSA_set_ex_data := nil;
  DSA_get_ex_data := nil;
  d2i_DSAPublicKey := nil;
  d2i_DSAPrivateKey := nil;
  d2i_DSAparams := nil;
  DSA_generate_parameters_ex := nil;
  DSA_generate_key := nil;
  i2d_DSAPublicKey := nil;
  i2d_DSAPrivateKey := nil;
  i2d_DSAparams := nil;
  DSAparams_print := nil;
  DSA_print := nil;
  DSA_dup_DH := nil;
  DSA_get0_pqg := nil;
  DSA_set0_pqg := nil;
  DSA_get0_key := nil;
  DSA_set0_key := nil;
  DSA_get0_p := nil;
  DSA_get0_q := nil;
  DSA_get0_g := nil;
  DSA_get0_pub_key := nil;
  DSA_get0_priv_key := nil;
  DSA_clear_flags := nil;
  DSA_test_flags := nil;
  DSA_set_flags := nil;
  DSA_get0_engine := nil;
  DSA_meth_new := nil;
  DSA_meth_free := nil;
  DSA_meth_dup := nil;
  DSA_meth_get0_name := nil;
  DSA_meth_set1_name := nil;
  DSA_meth_get_flags := nil;
  DSA_meth_set_flags := nil;
  DSA_meth_get0_app_data := nil;
  DSA_meth_set0_app_data := nil;
  DSA_meth_get_sign := nil;
  DSA_meth_set_sign := nil;
  DSA_meth_get_sign_setup := nil;
  DSA_meth_set_sign_setup := nil;
  DSA_meth_get_verify := nil;
  DSA_meth_set_verify := nil;
  DSA_meth_get_mod_exp := nil;
  DSA_meth_set_mod_exp := nil;
  DSA_meth_get_bn_mod_exp := nil;
  DSA_meth_set_bn_mod_exp := nil;
  DSA_meth_get_init := nil;
  DSA_meth_set_init := nil;
  DSA_meth_get_finish := nil;
  DSA_meth_set_finish := nil;
  DSA_meth_get_paramgen := nil;
  DSA_meth_set_paramgen := nil;
  DSA_meth_get_keygen := nil;
  DSA_meth_set_keygen := nil;
end;

end.
