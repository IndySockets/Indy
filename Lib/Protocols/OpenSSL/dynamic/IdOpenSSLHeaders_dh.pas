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

unit IdOpenSSLHeaders_dh;

interface

// Headers for OpenSSL 1.1.1
// dh.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_evp;

const
  OPENSSL_DH_MAX_MODULUS_BITS      = 10000;
  OPENSSL_DH_FIPS_MIN_MODULUS_BITS =  1024;

  DH_FLAG_CACHE_MONT_P   =   $01;
  DH_FLAG_FIPS_METHOD    = $0400;
  DH_FLAG_NON_FIPS_ALLOW = $0400;

  DH_GENERATOR_2 = 2;
  DH_GENERATOR_5 = 5;

  DH_CHECK_P_NOT_PRIME         = $01;
  DH_CHECK_P_NOT_SAFE_PRIME    = $02;
  DH_UNABLE_TO_CHECK_GENERATOR = $04;
  DH_NOT_SUITABLE_GENERATOR    = $08;
  DH_CHECK_Q_NOT_PRIME         = $10;
  DH_CHECK_INVALID_Q_VALUE     = $20;
  DH_CHECK_INVALID_J_VALUE     = $40;
  DH_CHECK_PUBKEY_TOO_SMALL    = $01;
  DH_CHECK_PUBKEY_TOO_LARGE    = $02;
  DH_CHECK_PUBKEY_INVALID      = $04;
  DH_CHECK_P_NOT_STRONG_PRIME  = DH_CHECK_P_NOT_SAFE_PRIME;

  EVP_PKEY_DH_KDF_NONE  = 1;
  EVP_PKEY_DH_KDF_X9_42 = 2;

  EVP_PKEY_CTRL_DH_PARAMGEN_PRIME_LEN    = (EVP_PKEY_ALG_CTRL + 1);
  EVP_PKEY_CTRL_DH_PARAMGEN_GENERATOR    = (EVP_PKEY_ALG_CTRL + 2);
  EVP_PKEY_CTRL_DH_RFC5114               = (EVP_PKEY_ALG_CTRL + 3);
  EVP_PKEY_CTRL_DH_PARAMGEN_SUBPRIME_LEN = (EVP_PKEY_ALG_CTRL + 4);
  EVP_PKEY_CTRL_DH_PARAMGEN_TYPE         = (EVP_PKEY_ALG_CTRL + 5);
  EVP_PKEY_CTRL_DH_KDF_TYPE              = (EVP_PKEY_ALG_CTRL + 6);
  EVP_PKEY_CTRL_DH_KDF_MD                = (EVP_PKEY_ALG_CTRL + 7);
  EVP_PKEY_CTRL_GET_DH_KDF_MD            = (EVP_PKEY_ALG_CTRL + 8);
  EVP_PKEY_CTRL_DH_KDF_OUTLEN            = (EVP_PKEY_ALG_CTRL + 9);
  EVP_PKEY_CTRL_GET_DH_KDF_OUTLEN        = (EVP_PKEY_ALG_CTRL + 10);
  EVP_PKEY_CTRL_DH_KDF_UKM               = (EVP_PKEY_ALG_CTRL + 11);
  EVP_PKEY_CTRL_GET_DH_KDF_UKM           = (EVP_PKEY_ALG_CTRL + 12);
  EVP_PKEY_CTRL_DH_KDF_OID               = (EVP_PKEY_ALG_CTRL + 13);
  EVP_PKEY_CTRL_GET_DH_KDF_OID           = (EVP_PKEY_ALG_CTRL + 14);
  EVP_PKEY_CTRL_DH_NID                   = (EVP_PKEY_ALG_CTRL + 15);
  EVP_PKEY_CTRL_DH_PAD                   = (EVP_PKEY_ALG_CTRL + 16);

type
  DH_meth_generate_key_cb = function(dh: PDH): TIdC_INT cdecl;
  DH_meth_compute_key_cb = function(key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT cdecl;
  DH_meth_bn_mod_exp_cb = function(
    const dh: PDH; r: PBIGNUM; const a: PBIGNUM;
    const p: PBIGNUM; const m: PBIGNUM;
    ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl;
  DH_meth_init_cb = function(dh: PDH): TIdC_INT cdecl;
  DH_meth_finish_cb = function(dh: PDH): TIdC_INT cdecl;
  DH_meth_generate_params_cb = function(dh: PDH; prime_len: TIdC_INT; generator: TIdC_INT; cb: PBN_GENCB): TIdC_INT cdecl;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
{
  # define DH_CHECK_P_NOT_STRONG_PRIME     DH_CHECK_P_NOT_SAFE_PRIME

  # define d2i_DHparams_fp(fp,x) \
      (DH *)ASN1_d2i_fp((char *(*)())DH_new, \
                        (char *(*)())d2i_DHparams, \
                        (fp), \
                        (unsigned char **)(x))
  # define i2d_DHparams_fp(fp,x) \
      ASN1_i2d_fp(i2d_DHparams,(fp), (unsigned char *)(x))
  # define d2i_DHparams_bio(bp,x) \
      ASN1_d2i_bio_of(DH, DH_new, d2i_DHparams, bp, x)
  # define i2d_DHparams_bio(bp,x) \
      ASN1_i2d_bio_of_const(DH,i2d_DHparams,bp,x)

  # define d2i_DHxparams_fp(fp,x) \
      (DH *)ASN1_d2i_fp((char *(*)())DH_new, \
                        (char *(*)())d2i_DHxparams, \
                        (fp), \
                        (unsigned char **)(x))
  # define i2d_DHxparams_fp(fp,x) \
      ASN1_i2d_fp(i2d_DHxparams,(fp), (unsigned char *)(x))
  # define d2i_DHxparams_bio(bp,x) \
      ASN1_d2i_bio_of(DH, DH_new, d2i_DHxparams, bp, x)
  # define i2d_DHxparams_bio(bp,x) \
      ASN1_i2d_bio_of_const(DH, i2d_DHxparams, bp, x)
}

  DHparams_dup: function(dh: PDH): PDH cdecl = nil;

  DH_OpenSSL: function: PDH_Method cdecl = nil;

  DH_set_default_method: procedure(const meth: PDH_Method) cdecl = nil;
  DH_get_default_method: function: PDH_Method cdecl = nil;
  DH_set_method: function(dh: PDH; const meth: PDH_Method): TIdC_INT cdecl = nil;
  DH_new_method: function(engine: PENGINE): PDH cdecl = nil;

  DH_new: function: PDH cdecl = nil;
  DH_free: procedure(dh: PDH) cdecl = nil;
  DH_up_ref: function(dh: PDH): TIdC_INT cdecl = nil;
  DH_bits: function(const dh: PDH): TIdC_INT cdecl = nil;
  DH_size: function(const dh: PDH): TIdC_INT cdecl = nil;
  DH_security_bits: function(const dh: PDH): TIdC_INT cdecl = nil;
  DH_set_ex_data: function(d: PDH; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  DH_get_ex_data: function(d: PDH; idx: TIdC_INT): Pointer cdecl = nil;

  DH_generate_parameters_ex: function(dh: PDH; prime_len: TIdC_INT; generator: TIdC_INT; cb: PBN_GENCB): TIdC_INT cdecl = nil;

  DH_check_params_ex: function(const dh: PDH): TIdC_INT cdecl = nil;
  DH_check_ex: function(const dh: PDH): TIdC_INT cdecl = nil;
  DH_check_pub_key_ex: function(const dh: PDH; const pub_key: PBIGNUM): TIdC_INT cdecl = nil;
  DH_check_params: function(const dh: PDH; ret: PIdC_INT): TIdC_INT cdecl = nil;
  DH_check: function(const dh: PDH; codes: PIdC_INT): TIdC_INT cdecl = nil;
  DH_check_pub_key: function(const dh: PDH; const pub_key: PBIGNUM; codes: PIdC_INT): TIdC_INT cdecl = nil;
  DH_generate_key: function(dh: PDH): TIdC_INT cdecl = nil;
  DH_compute_key: function(key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT cdecl = nil;
  DH_compute_key_padded: function(key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT cdecl = nil;
  d2i_DHparams: function(a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH cdecl = nil;
  i2d_DHparams: function(const a: PDH; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_DHxparams: function(a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH cdecl = nil;
  i2d_DHxparams: function(const a: PDH; pp: PPByte): TIdC_INT cdecl = nil;
  DHparams_print: function(bp: PBIO; const x: PDH): TIdC_INT cdecl = nil;

  DH_get_1024_160: function: PDH cdecl = nil;
  DH_get_2048_224: function: PDH cdecl = nil;
  DH_get_2048_256: function: PDH cdecl = nil;

  DH_new_by_nid: function(nid: TIdC_INT): PDH cdecl = nil;
  DH_get_nid: function(const dh: PDH): TIdC_INT cdecl = nil;

  DH_KDF_X9_42: function( out_: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; key_oid: PASN1_OBJECT; const ukm: PByte; ukmlen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT cdecl = nil;

  DH_get0_pqg: procedure(const dh: PDH; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM) cdecl = nil;
  DH_set0_pqg: function(dh: PDH; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT cdecl = nil;
  DH_get0_key: procedure(const dh: PDH; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM) cdecl = nil;
  DH_set0_key: function(dh: PDH; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT cdecl = nil;
  DH_get0_p: function(const dh: PDH): PBIGNUM cdecl = nil;
  DH_get0_q: function(const dh: PDH): PBIGNUM cdecl = nil;
  DH_get0_g: function(const dh: PDH): PBIGNUM cdecl = nil;
  DH_get0_priv_key: function(const dh: PDH): PBIGNUM cdecl = nil;
  DH_get0_pub_key: function(const dh: PDH): PBIGNUM cdecl = nil;
  DH_clear_flags: procedure(dh: PDH; flags: TIdC_INT) cdecl = nil;
  DH_test_flags: function(const dh: PDH; flags: TIdC_INT): TIdC_INT cdecl = nil;
  DH_set_flags: procedure(dh: PDH; flags: TIdC_INT) cdecl = nil;
  DH_get0_engine: function(d: PDH): PENGINE cdecl = nil;
  DH_get_length: function(const dh: PDH): TIdC_LONG cdecl = nil;
  DH_set_length: function(dh: PDH; length: TIdC_LONG): TIdC_INT cdecl = nil;

  DH_meth_new: function(const name: PIdAnsiChar; flags: TIdC_INT): PDH_Method cdecl = nil;
  DH_meth_free: procedure(dhm: PDH_Method) cdecl = nil;
  DH_meth_dup: function(const dhm: PDH_Method): PDH_Method cdecl = nil;
  DH_meth_get0_name: function(const dhm: PDH_Method): PIdAnsiChar cdecl = nil;
  DH_meth_set1_name: function(dhm: PDH_Method; const name: PIdAnsiChar): TIdC_INT cdecl = nil;
  DH_meth_get_flags: function(const dhm: PDH_Method): TIdC_INT cdecl = nil;
  DH_meth_set_flags: function(const dhm: PDH_Method; flags: TIdC_INT): TIdC_INT cdecl = nil;
  DH_meth_get0_app_data: function(const dhm: PDH_Method): Pointer cdecl = nil;
  DH_meth_set0_app_data: function(const dhm: PDH_Method; app_data: Pointer): TIdC_INT cdecl = nil;

  DH_meth_get_generate_key: function(const dhm: PDH_Method): DH_meth_generate_key_cb cdecl = nil;
  DH_meth_set_generate_key: function(const dhm: PDH_Method; generate_key: DH_meth_generate_key_cb): TIdC_INT cdecl = nil;

  DH_meth_get_compute_key: function(const dhm: PDH_Method): DH_meth_compute_key_cb cdecl = nil;
  DH_meth_set_compute_key: function(const dhm: PDH_Method; compute_key: DH_meth_compute_key_cb): TIdC_INT cdecl = nil;

  DH_meth_get_bn_mod_exp: function(const dhm: PDH_Method): DH_meth_bn_mod_exp_cb cdecl = nil;
  DH_meth_set_bn_mod_exp: function(const dhm: PDH_Method; bn_mod_expr: DH_meth_bn_mod_exp_cb): TIdC_INT cdecl = nil;

  DH_meth_get_init: function(const dhm: PDH_Method): DH_meth_init_cb cdecl = nil;
  DH_meth_set_init: function(const dhm: PDH_Method; init: DH_meth_init_cb): TIdC_INT cdecl = nil;

  DH_meth_get_finish: function(const dhm: PDH_Method): DH_meth_finish_cb cdecl = nil;
  DH_meth_set_finish: function(const dhm: PDH_Method; finish: DH_meth_finish_cb): TIdC_INT cdecl = nil;

  DH_meth_get_generate_params: function(const dhm: PDH_Method): DH_meth_generate_params_cb cdecl = nil;
  DH_meth_set_generate_params: function(const dhm: PDH_Method; generate_params: DH_meth_generate_params_cb): TIdC_INT cdecl = nil;

{
# define EVP_PKEY_CTX_set_dh_paramgen_prime_len(ctx, len) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_PARAMGEN_PRIME_LEN, len, NULL)

# define EVP_PKEY_CTX_set_dh_paramgen_subprime_len(ctx, len) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_PARAMGEN_SUBPRIME_LEN, len, NULL)

# define EVP_PKEY_CTX_set_dh_paramgen_type(ctx, typ) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_PARAMGEN_TYPE, typ, NULL)

# define EVP_PKEY_CTX_set_dh_paramgen_generator(ctx, gen) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_PARAMGEN_GENERATOR, gen, NULL)

# define EVP_PKEY_CTX_set_dh_rfc5114(ctx, gen) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_RFC5114, gen, NULL)

# define EVP_PKEY_CTX_set_dhx_rfc5114(ctx, gen) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, EVP_PKEY_OP_PARAMGEN, \
                        EVP_PKEY_CTRL_DH_RFC5114, gen, NULL)

# define EVP_PKEY_CTX_set_dh_nid(ctx, nid) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, \
                        EVP_PKEY_OP_PARAMGEN | EVP_PKEY_OP_KEYGEN, \
                        EVP_PKEY_CTRL_DH_NID, nid, NULL)

# define EVP_PKEY_CTX_set_dh_pad(ctx, pad) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DH, EVP_PKEY_OP_DERIVE, \
                          EVP_PKEY_CTRL_DH_PAD, pad, NULL)

# define EVP_PKEY_CTX_set_dh_kdf_type(ctx, kdf) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_TYPE, kdf, NULL)

# define EVP_PKEY_CTX_get_dh_kdf_type(ctx) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_TYPE, -2, NULL)

# define EVP_PKEY_CTX_set0_dh_kdf_oid(ctx, oid) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_OID, 0, (void *)(oid))

# define EVP_PKEY_CTX_get0_dh_kdf_oid(ctx, poid) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_GET_DH_KDF_OID, 0, (void *)(poid))

# define EVP_PKEY_CTX_set_dh_kdf_md(ctx, md) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_MD, 0, (void *)(md))

# define EVP_PKEY_CTX_get_dh_kdf_md(ctx, pmd) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_GET_DH_KDF_MD, 0, (void *)(pmd))

# define EVP_PKEY_CTX_set_dh_kdf_outlen(ctx, len) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_OUTLEN, len, NULL)

# define EVP_PKEY_CTX_get_dh_kdf_outlen(ctx, plen) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                        EVP_PKEY_CTRL_GET_DH_KDF_OUTLEN, 0, (void *)(plen))

# define EVP_PKEY_CTX_set0_dh_kdf_ukm(ctx, p, plen) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_DH_KDF_UKM, plen, (void *)(p))

# define EVP_PKEY_CTX_get0_dh_kdf_ukm(ctx, p) \
        EVP_PKEY_CTX_ctrl(ctx, EVP_PKEY_DHX, \
                                EVP_PKEY_OP_DERIVE, \
                                EVP_PKEY_CTRL_GET_DH_KDF_UKM, 0, (void *)(p))
}

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  DHparams_dup := LoadFunction('DHparams_dup', AFailed);
  DH_OpenSSL := LoadFunction('DH_OpenSSL', AFailed);
  DH_set_default_method := LoadFunction('DH_set_default_method', AFailed);
  DH_get_default_method := LoadFunction('DH_get_default_method', AFailed);
  DH_set_method := LoadFunction('DH_set_method', AFailed);
  DH_new_method := LoadFunction('DH_new_method', AFailed);
  DH_new := LoadFunction('DH_new', AFailed);
  DH_free := LoadFunction('DH_free', AFailed);
  DH_up_ref := LoadFunction('DH_up_ref', AFailed);
  DH_bits := LoadFunction('DH_bits', AFailed);
  DH_size := LoadFunction('DH_size', AFailed);
  DH_security_bits := LoadFunction('DH_security_bits', AFailed);
  DH_set_ex_data := LoadFunction('DH_set_ex_data', AFailed);
  DH_get_ex_data := LoadFunction('DH_get_ex_data', AFailed);
  DH_generate_parameters_ex := LoadFunction('DH_generate_parameters_ex', AFailed);
  DH_check_params_ex := LoadFunction('DH_check_params_ex', AFailed);
  DH_check_ex := LoadFunction('DH_check_ex', AFailed);
  DH_check_pub_key_ex := LoadFunction('DH_check_pub_key_ex', AFailed);
  DH_check_params := LoadFunction('DH_check_params', AFailed);
  DH_check := LoadFunction('DH_check', AFailed);
  DH_check_pub_key := LoadFunction('DH_check_pub_key', AFailed);
  DH_generate_key := LoadFunction('DH_generate_key', AFailed);
  DH_compute_key := LoadFunction('DH_compute_key', AFailed);
  DH_compute_key_padded := LoadFunction('DH_compute_key_padded', AFailed);
  d2i_DHparams := LoadFunction('d2i_DHparams', AFailed);
  i2d_DHparams := LoadFunction('i2d_DHparams', AFailed);
  d2i_DHxparams := LoadFunction('d2i_DHxparams', AFailed);
  i2d_DHxparams := LoadFunction('i2d_DHxparams', AFailed);
  DHparams_print := LoadFunction('DHparams_print', AFailed);
  DH_get_1024_160 := LoadFunction('DH_get_1024_160', AFailed);
  DH_get_2048_224 := LoadFunction('DH_get_2048_224', AFailed);
  DH_get_2048_256 := LoadFunction('DH_get_2048_256', AFailed);
  DH_new_by_nid := LoadFunction('DH_new_by_nid', AFailed);
  DH_get_nid := LoadFunction('DH_get_nid', AFailed);
  DH_KDF_X9_42 := LoadFunction('DH_KDF_X9_42', AFailed);
  DH_get0_pqg := LoadFunction('DH_get0_pqg', AFailed);
  DH_set0_pqg := LoadFunction('DH_set0_pqg', AFailed);
  DH_get0_key := LoadFunction('DH_get0_key', AFailed);
  DH_set0_key := LoadFunction('DH_set0_key', AFailed);
  DH_get0_p := LoadFunction('DH_get0_p', AFailed);
  DH_get0_q := LoadFunction('DH_get0_q', AFailed);
  DH_get0_g := LoadFunction('DH_get0_g', AFailed);
  DH_get0_priv_key := LoadFunction('DH_get0_priv_key', AFailed);
  DH_get0_pub_key := LoadFunction('DH_get0_pub_key', AFailed);
  DH_clear_flags := LoadFunction('DH_clear_flags', AFailed);
  DH_test_flags := LoadFunction('DH_test_flags', AFailed);
  DH_set_flags := LoadFunction('DH_set_flags', AFailed);
  DH_get0_engine := LoadFunction('DH_get0_engine', AFailed);
  DH_get_length := LoadFunction('DH_get_length', AFailed);
  DH_set_length := LoadFunction('DH_set_length', AFailed);
  DH_meth_new := LoadFunction('DH_meth_new', AFailed);
  DH_meth_free := LoadFunction('DH_meth_free', AFailed);
  DH_meth_dup := LoadFunction('DH_meth_dup', AFailed);
  DH_meth_get0_name := LoadFunction('DH_meth_get0_name', AFailed);
  DH_meth_set1_name := LoadFunction('DH_meth_set1_name', AFailed);
  DH_meth_get_flags := LoadFunction('DH_meth_get_flags', AFailed);
  DH_meth_set_flags := LoadFunction('DH_meth_set_flags', AFailed);
  DH_meth_get0_app_data := LoadFunction('DH_meth_get0_app_data', AFailed);
  DH_meth_set0_app_data := LoadFunction('DH_meth_set0_app_data', AFailed);
  DH_meth_get_generate_key := LoadFunction('DH_meth_get_generate_key', AFailed);
  DH_meth_set_generate_key := LoadFunction('DH_meth_set_generate_key', AFailed);
  DH_meth_get_compute_key := LoadFunction('DH_meth_get_compute_key', AFailed);
  DH_meth_set_compute_key := LoadFunction('DH_meth_set_compute_key', AFailed);
  DH_meth_get_bn_mod_exp := LoadFunction('DH_meth_get_bn_mod_exp', AFailed);
  DH_meth_set_bn_mod_exp := LoadFunction('DH_meth_set_bn_mod_exp', AFailed);
  DH_meth_get_init := LoadFunction('DH_meth_get_init', AFailed);
  DH_meth_set_init := LoadFunction('DH_meth_set_init', AFailed);
  DH_meth_get_finish := LoadFunction('DH_meth_get_finish', AFailed);
  DH_meth_set_finish := LoadFunction('DH_meth_set_finish', AFailed);
  DH_meth_get_generate_params := LoadFunction('DH_meth_get_generate_params', AFailed);
  DH_meth_set_generate_params := LoadFunction('DH_meth_set_generate_params', AFailed);
end;

procedure UnLoad;
begin
  DHparams_dup := nil;
  DH_OpenSSL := nil;
  DH_set_default_method := nil;
  DH_get_default_method := nil;
  DH_set_method := nil;
  DH_new_method := nil;
  DH_new := nil;
  DH_free := nil;
  DH_up_ref := nil;
  DH_bits := nil;
  DH_size := nil;
  DH_security_bits := nil;
  DH_set_ex_data := nil;
  DH_get_ex_data := nil;
  DH_generate_parameters_ex := nil;
  DH_check_params_ex := nil;
  DH_check_ex := nil;
  DH_check_pub_key_ex := nil;
  DH_check_params := nil;
  DH_check := nil;
  DH_check_pub_key := nil;
  DH_generate_key := nil;
  DH_compute_key := nil;
  DH_compute_key_padded := nil;
  d2i_DHparams := nil;
  i2d_DHparams := nil;
  d2i_DHxparams := nil;
  i2d_DHxparams := nil;
  DHparams_print := nil;
  DH_get_1024_160 := nil;
  DH_get_2048_224 := nil;
  DH_get_2048_256 := nil;
  DH_new_by_nid := nil;
  DH_get_nid := nil;
  DH_KDF_X9_42 := nil;
  DH_get0_pqg := nil;
  DH_set0_pqg := nil;
  DH_get0_key := nil;
  DH_set0_key := nil;
  DH_get0_p := nil;
  DH_get0_q := nil;
  DH_get0_g := nil;
  DH_get0_priv_key := nil;
  DH_get0_pub_key := nil;
  DH_clear_flags := nil;
  DH_test_flags := nil;
  DH_set_flags := nil;
  DH_get0_engine := nil;
  DH_get_length := nil;
  DH_set_length := nil;
  DH_meth_new := nil;
  DH_meth_free := nil;
  DH_meth_dup := nil;
  DH_meth_get0_name := nil;
  DH_meth_set1_name := nil;
  DH_meth_get_flags := nil;
  DH_meth_set_flags := nil;
  DH_meth_get0_app_data := nil;
  DH_meth_set0_app_data := nil;
  DH_meth_get_generate_key := nil;
  DH_meth_set_generate_key := nil;
  DH_meth_get_compute_key := nil;
  DH_meth_set_compute_key := nil;
  DH_meth_get_bn_mod_exp := nil;
  DH_meth_set_bn_mod_exp := nil;
  DH_meth_get_init := nil;
  DH_meth_set_init := nil;
  DH_meth_get_finish := nil;
  DH_meth_set_finish := nil;
  DH_meth_get_generate_params := nil;
  DH_meth_set_generate_params := nil;
end;

end.
