  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_dh.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_dh.h2pas
     and this file regenerated. IdOpenSSLHeaders_dh.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
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

unit IdOpenSSLHeaders_dh;

interface

// Headers for OpenSSL 1.1.1
// dh.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
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

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM DHparams_dup}
  {$EXTERNALSYM DH_OpenSSL}
  {$EXTERNALSYM DH_set_default_method}
  {$EXTERNALSYM DH_get_default_method}
  {$EXTERNALSYM DH_set_method}
  {$EXTERNALSYM DH_new_method}
  {$EXTERNALSYM DH_new}
  {$EXTERNALSYM DH_free}
  {$EXTERNALSYM DH_up_ref}
  {$EXTERNALSYM DH_bits} {introduced 1.1.0}
  {$EXTERNALSYM DH_size}
  {$EXTERNALSYM DH_security_bits} {introduced 1.1.0}
  {$EXTERNALSYM DH_set_ex_data}
  {$EXTERNALSYM DH_get_ex_data}
  {$EXTERNALSYM DH_generate_parameters_ex}
  {$EXTERNALSYM DH_check_params_ex} {introduced 1.1.0}
  {$EXTERNALSYM DH_check_ex} {introduced 1.1.0}
  {$EXTERNALSYM DH_check_pub_key_ex} {introduced 1.1.0}
  {$EXTERNALSYM DH_check_params} {introduced 1.1.0}
  {$EXTERNALSYM DH_check}
  {$EXTERNALSYM DH_check_pub_key}
  {$EXTERNALSYM DH_generate_key}
  {$EXTERNALSYM DH_compute_key}
  {$EXTERNALSYM DH_compute_key_padded}
  {$EXTERNALSYM d2i_DHparams}
  {$EXTERNALSYM i2d_DHparams}
  {$EXTERNALSYM d2i_DHxparams}
  {$EXTERNALSYM i2d_DHxparams}
  {$EXTERNALSYM DHparams_print}
  {$EXTERNALSYM DH_get_1024_160}
  {$EXTERNALSYM DH_get_2048_224}
  {$EXTERNALSYM DH_get_2048_256}
  {$EXTERNALSYM DH_new_by_nid} {introduced 1.1.0}
  {$EXTERNALSYM DH_get_nid} {introduced 1.1.0}
  {$EXTERNALSYM DH_KDF_X9_42}
  {$EXTERNALSYM DH_get0_pqg} {introduced 1.1.0}
  {$EXTERNALSYM DH_set0_pqg} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_set0_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_p} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_q} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_g} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_priv_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_pub_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_clear_flags} {introduced 1.1.0}
  {$EXTERNALSYM DH_test_flags} {introduced 1.1.0}
  {$EXTERNALSYM DH_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM DH_get0_engine} {introduced 1.1.0}
  {$EXTERNALSYM DH_get_length} {introduced 1.1.0}
  {$EXTERNALSYM DH_set_length} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_new} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_free} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_dup} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get0_name} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set1_name} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_flags} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get0_app_data} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set0_app_data} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_generate_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_generate_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_compute_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_compute_key} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_bn_mod_exp} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_bn_mod_exp} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_init} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_init} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_finish} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_finish} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_get_generate_params} {introduced 1.1.0}
  {$EXTERNALSYM DH_meth_set_generate_params} {introduced 1.1.0}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  DHparams_dup: function (dh: PDH): PDH; cdecl = nil;

  DH_OpenSSL: function : PDH_Method; cdecl = nil;

  DH_set_default_method: procedure (const meth: PDH_Method); cdecl = nil;
  DH_get_default_method: function : PDH_Method; cdecl = nil;
  DH_set_method: function (dh: PDH; const meth: PDH_Method): TIdC_INT; cdecl = nil;
  DH_new_method: function (engine: PENGINE): PDH; cdecl = nil;

  DH_new: function : PDH; cdecl = nil;
  DH_free: procedure (dh: PDH); cdecl = nil;
  DH_up_ref: function (dh: PDH): TIdC_INT; cdecl = nil;
  DH_bits: function (const dh: PDH): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_size: function (const dh: PDH): TIdC_INT; cdecl = nil;
  DH_security_bits: function (const dh: PDH): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_set_ex_data: function (d: PDH; idx: TIdC_INT; arg: Pointer): TIdC_INT; cdecl = nil;
  DH_get_ex_data: function (d: PDH; idx: TIdC_INT): Pointer; cdecl = nil;

  DH_generate_parameters_ex: function (dh: PDH; prime_len: TIdC_INT; generator: TIdC_INT; cb: PBN_GENCB): TIdC_INT; cdecl = nil;

  DH_check_params_ex: function (const dh: PDH): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_check_ex: function (const dh: PDH): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_check_pub_key_ex: function (const dh: PDH; const pub_key: PBIGNUM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_check_params: function (const dh: PDH; ret: PIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_check: function (const dh: PDH; codes: PIdC_INT): TIdC_INT; cdecl = nil;
  DH_check_pub_key: function (const dh: PDH; const pub_key: PBIGNUM; codes: PIdC_INT): TIdC_INT; cdecl = nil;
  DH_generate_key: function (dh: PDH): TIdC_INT; cdecl = nil;
  DH_compute_key: function (key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT; cdecl = nil;
  DH_compute_key_padded: function (key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT; cdecl = nil;
  d2i_DHparams: function (a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH; cdecl = nil;
  i2d_DHparams: function (const a: PDH; pp: PPByte): TIdC_INT; cdecl = nil;
  d2i_DHxparams: function (a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH; cdecl = nil;
  i2d_DHxparams: function (const a: PDH; pp: PPByte): TIdC_INT; cdecl = nil;
  DHparams_print: function (bp: PBIO; const x: PDH): TIdC_INT; cdecl = nil;

  DH_get_1024_160: function : PDH; cdecl = nil;
  DH_get_2048_224: function : PDH; cdecl = nil;
  DH_get_2048_256: function : PDH; cdecl = nil;

  DH_new_by_nid: function (nid: TIdC_INT): PDH; cdecl = nil; {introduced 1.1.0}
  DH_get_nid: function (const dh: PDH): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_KDF_X9_42: function ( out_: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; key_oid: PASN1_OBJECT; const ukm: PByte; ukmlen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT; cdecl = nil;

  DH_get0_pqg: procedure (const dh: PDH; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM); cdecl = nil; {introduced 1.1.0}
  DH_set0_pqg: function (dh: PDH; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_get0_key: procedure (const dh: PDH; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM); cdecl = nil; {introduced 1.1.0}
  DH_set0_key: function (dh: PDH; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_get0_p: function (const dh: PDH): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  DH_get0_q: function (const dh: PDH): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  DH_get0_g: function (const dh: PDH): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  DH_get0_priv_key: function (const dh: PDH): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  DH_get0_pub_key: function (const dh: PDH): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  DH_clear_flags: procedure (dh: PDH; flags: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  DH_test_flags: function (const dh: PDH; flags: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_set_flags: procedure (dh: PDH; flags: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  DH_get0_engine: function (d: PDH): PENGINE; cdecl = nil; {introduced 1.1.0}
  DH_get_length: function (const dh: PDH): TIdC_LONG; cdecl = nil; {introduced 1.1.0}
  DH_set_length: function (dh: PDH; length: TIdC_LONG): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_new: function (const name: PIdAnsiChar; flags: TIdC_INT): PDH_Method; cdecl = nil; {introduced 1.1.0}
  DH_meth_free: procedure (dhm: PDH_Method); cdecl = nil; {introduced 1.1.0}
  DH_meth_dup: function (const dhm: PDH_Method): PDH_Method; cdecl = nil; {introduced 1.1.0}
  DH_meth_get0_name: function (const dhm: PDH_Method): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  DH_meth_set1_name: function (dhm: PDH_Method; const name: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_meth_get_flags: function (const dhm: PDH_Method): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_flags: function (const dhm: PDH_Method; flags: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  DH_meth_get0_app_data: function (const dhm: PDH_Method): Pointer; cdecl = nil; {introduced 1.1.0}
  DH_meth_set0_app_data: function (const dhm: PDH_Method; app_data: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_generate_key: function (const dhm: PDH_Method): DH_meth_generate_key_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_generate_key: function (const dhm: PDH_Method; generate_key: DH_meth_generate_key_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_compute_key: function (const dhm: PDH_Method): DH_meth_compute_key_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_compute_key: function (const dhm: PDH_Method; compute_key: DH_meth_compute_key_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_bn_mod_exp: function (const dhm: PDH_Method): DH_meth_bn_mod_exp_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_bn_mod_exp: function (const dhm: PDH_Method; bn_mod_expr: DH_meth_bn_mod_exp_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_init: function (const dhm: PDH_Method): DH_meth_init_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_init: function (const dhm: PDH_Method; init: DH_meth_init_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_finish: function (const dhm: PDH_Method): DH_meth_finish_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_finish: function (const dhm: PDH_Method; finish: DH_meth_finish_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  DH_meth_get_generate_params: function (const dhm: PDH_Method): DH_meth_generate_params_cb; cdecl = nil; {introduced 1.1.0}
  DH_meth_set_generate_params: function (const dhm: PDH_Method; generate_params: DH_meth_generate_params_cb): TIdC_INT; cdecl = nil; {introduced 1.1.0}

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

{$ELSE}
  function DHparams_dup(dh: PDH): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_OpenSSL: PDH_Method cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure DH_set_default_method(const meth: PDH_Method) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_get_default_method: PDH_Method cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_set_method(dh: PDH; const meth: PDH_Method): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_new_method(engine: PENGINE): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_new: PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure DH_free(dh: PDH) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_up_ref(dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_bits(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_size(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_security_bits(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_set_ex_data(d: PDH; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_get_ex_data(d: PDH; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_generate_parameters_ex(dh: PDH; prime_len: TIdC_INT; generator: TIdC_INT; cb: PBN_GENCB): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_check_params_ex(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_check_ex(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_check_pub_key_ex(const dh: PDH; const pub_key: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_check_params(const dh: PDH; ret: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_check(const dh: PDH; codes: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_check_pub_key(const dh: PDH; const pub_key: PBIGNUM; codes: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_generate_key(dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_compute_key(key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_compute_key_padded(key: PByte; const pub_key: PBIGNUM; dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_DHparams(a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_DHparams(const a: PDH; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_DHxparams(a: PPDH; const pp: PPByte; length: TIdC_LONG): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_DHxparams(const a: PDH; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DHparams_print(bp: PBIO; const x: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_get_1024_160: PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_get_2048_224: PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function DH_get_2048_256: PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function DH_new_by_nid(nid: TIdC_INT): PDH cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get_nid(const dh: PDH): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_KDF_X9_42( out_: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; key_oid: PASN1_OBJECT; const ukm: PByte; ukmlen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure DH_get0_pqg(const dh: PDH; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_set0_pqg(dh: PDH; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure DH_get0_key(const dh: PDH; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_set0_key(dh: PDH; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_p(const dh: PDH): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_q(const dh: PDH): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_g(const dh: PDH): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_priv_key(const dh: PDH): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_pub_key(const dh: PDH): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure DH_clear_flags(dh: PDH; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_test_flags(const dh: PDH; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure DH_set_flags(dh: PDH; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get0_engine(d: PDH): PENGINE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_get_length(const dh: PDH): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_set_length(dh: PDH; length: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_new(const name: PIdAnsiChar; flags: TIdC_INT): PDH_Method cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure DH_meth_free(dhm: PDH_Method) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_dup(const dhm: PDH_Method): PDH_Method cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_get0_name(const dhm: PDH_Method): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set1_name(dhm: PDH_Method; const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_get_flags(const dhm: PDH_Method): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_flags(const dhm: PDH_Method; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_get0_app_data(const dhm: PDH_Method): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set0_app_data(const dhm: PDH_Method; app_data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_generate_key(const dhm: PDH_Method): DH_meth_generate_key_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_generate_key(const dhm: PDH_Method; generate_key: DH_meth_generate_key_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_compute_key(const dhm: PDH_Method): DH_meth_compute_key_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_compute_key(const dhm: PDH_Method; compute_key: DH_meth_compute_key_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_bn_mod_exp(const dhm: PDH_Method): DH_meth_bn_mod_exp_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_bn_mod_exp(const dhm: PDH_Method; bn_mod_expr: DH_meth_bn_mod_exp_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_init(const dhm: PDH_Method): DH_meth_init_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_init(const dhm: PDH_Method; init: DH_meth_init_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_finish(const dhm: PDH_Method): DH_meth_finish_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_finish(const dhm: PDH_Method; finish: DH_meth_finish_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function DH_meth_get_generate_params(const dhm: PDH_Method): DH_meth_generate_params_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function DH_meth_set_generate_params(const dhm: PDH_Method; generate_params: DH_meth_generate_params_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

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

{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  
const
  DH_bits_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_security_bits_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_check_params_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_check_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_check_pub_key_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_check_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_new_by_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_pqg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_set0_pqg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_set0_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_p_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_q_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_g_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_priv_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_pub_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_clear_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_test_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get0_engine_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_get_length_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_set_length_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_dup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get0_name_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set1_name_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get0_app_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set0_app_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_generate_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_generate_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_compute_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_compute_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_bn_mod_exp_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_bn_mod_exp_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_finish_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_finish_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_get_generate_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DH_meth_set_generate_params_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
function  ERR_DH_bits(const dh: PDH): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_bits');
end;


function  ERR_DH_security_bits(const dh: PDH): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_security_bits');
end;


function  ERR_DH_check_params_ex(const dh: PDH): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_check_params_ex');
end;


function  ERR_DH_check_ex(const dh: PDH): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_check_ex');
end;


function  ERR_DH_check_pub_key_ex(const dh: PDH; const pub_key: PBIGNUM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_check_pub_key_ex');
end;


function  ERR_DH_check_params(const dh: PDH; ret: PIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_check_params');
end;


function  ERR_DH_new_by_nid(nid: TIdC_INT): PDH; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_new_by_nid');
end;


function  ERR_DH_get_nid(const dh: PDH): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get_nid');
end;


procedure  ERR_DH_get0_pqg(const dh: PDH; const p: PPBIGNUM; const q: PPBIGNUM; const g: PPBIGNUM); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_pqg');
end;


function  ERR_DH_set0_pqg(dh: PDH; p: PBIGNUM; q: PBIGNUM; g: PBIGNUM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_set0_pqg');
end;


procedure  ERR_DH_get0_key(const dh: PDH; const pub_key: PPBIGNUM; const priv_key: PPBIGNUM); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_key');
end;


function  ERR_DH_set0_key(dh: PDH; pub_key: PBIGNUM; priv_key: PBIGNUM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_set0_key');
end;


function  ERR_DH_get0_p(const dh: PDH): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_p');
end;


function  ERR_DH_get0_q(const dh: PDH): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_q');
end;


function  ERR_DH_get0_g(const dh: PDH): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_g');
end;


function  ERR_DH_get0_priv_key(const dh: PDH): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_priv_key');
end;


function  ERR_DH_get0_pub_key(const dh: PDH): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_pub_key');
end;


procedure  ERR_DH_clear_flags(dh: PDH; flags: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_clear_flags');
end;


function  ERR_DH_test_flags(const dh: PDH; flags: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_test_flags');
end;


procedure  ERR_DH_set_flags(dh: PDH; flags: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_set_flags');
end;


function  ERR_DH_get0_engine(d: PDH): PENGINE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get0_engine');
end;


function  ERR_DH_get_length(const dh: PDH): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_get_length');
end;


function  ERR_DH_set_length(dh: PDH; length: TIdC_LONG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_set_length');
end;


function  ERR_DH_meth_new(const name: PIdAnsiChar; flags: TIdC_INT): PDH_Method; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_new');
end;


procedure  ERR_DH_meth_free(dhm: PDH_Method); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_free');
end;


function  ERR_DH_meth_dup(const dhm: PDH_Method): PDH_Method; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_dup');
end;


function  ERR_DH_meth_get0_name(const dhm: PDH_Method): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get0_name');
end;


function  ERR_DH_meth_set1_name(dhm: PDH_Method; const name: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set1_name');
end;


function  ERR_DH_meth_get_flags(const dhm: PDH_Method): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_flags');
end;


function  ERR_DH_meth_set_flags(const dhm: PDH_Method; flags: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_flags');
end;


function  ERR_DH_meth_get0_app_data(const dhm: PDH_Method): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get0_app_data');
end;


function  ERR_DH_meth_set0_app_data(const dhm: PDH_Method; app_data: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set0_app_data');
end;


function  ERR_DH_meth_get_generate_key(const dhm: PDH_Method): DH_meth_generate_key_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_generate_key');
end;


function  ERR_DH_meth_set_generate_key(const dhm: PDH_Method; generate_key: DH_meth_generate_key_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_generate_key');
end;


function  ERR_DH_meth_get_compute_key(const dhm: PDH_Method): DH_meth_compute_key_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_compute_key');
end;


function  ERR_DH_meth_set_compute_key(const dhm: PDH_Method; compute_key: DH_meth_compute_key_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_compute_key');
end;


function  ERR_DH_meth_get_bn_mod_exp(const dhm: PDH_Method): DH_meth_bn_mod_exp_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_bn_mod_exp');
end;


function  ERR_DH_meth_set_bn_mod_exp(const dhm: PDH_Method; bn_mod_expr: DH_meth_bn_mod_exp_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_bn_mod_exp');
end;


function  ERR_DH_meth_get_init(const dhm: PDH_Method): DH_meth_init_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_init');
end;


function  ERR_DH_meth_set_init(const dhm: PDH_Method; init: DH_meth_init_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_init');
end;


function  ERR_DH_meth_get_finish(const dhm: PDH_Method): DH_meth_finish_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_finish');
end;


function  ERR_DH_meth_set_finish(const dhm: PDH_Method; finish: DH_meth_finish_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_finish');
end;


function  ERR_DH_meth_get_generate_params(const dhm: PDH_Method): DH_meth_generate_params_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_get_generate_params');
end;


function  ERR_DH_meth_set_generate_params(const dhm: PDH_Method; generate_params: DH_meth_generate_params_cb): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DH_meth_set_generate_params');
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
  DHparams_dup := LoadFunction('DHparams_dup',AFailed);
  DH_OpenSSL := LoadFunction('DH_OpenSSL',AFailed);
  DH_set_default_method := LoadFunction('DH_set_default_method',AFailed);
  DH_get_default_method := LoadFunction('DH_get_default_method',AFailed);
  DH_set_method := LoadFunction('DH_set_method',AFailed);
  DH_new_method := LoadFunction('DH_new_method',AFailed);
  DH_new := LoadFunction('DH_new',AFailed);
  DH_free := LoadFunction('DH_free',AFailed);
  DH_up_ref := LoadFunction('DH_up_ref',AFailed);
  DH_size := LoadFunction('DH_size',AFailed);
  DH_set_ex_data := LoadFunction('DH_set_ex_data',AFailed);
  DH_get_ex_data := LoadFunction('DH_get_ex_data',AFailed);
  DH_generate_parameters_ex := LoadFunction('DH_generate_parameters_ex',AFailed);
  DH_check := LoadFunction('DH_check',AFailed);
  DH_check_pub_key := LoadFunction('DH_check_pub_key',AFailed);
  DH_generate_key := LoadFunction('DH_generate_key',AFailed);
  DH_compute_key := LoadFunction('DH_compute_key',AFailed);
  DH_compute_key_padded := LoadFunction('DH_compute_key_padded',AFailed);
  d2i_DHparams := LoadFunction('d2i_DHparams',AFailed);
  i2d_DHparams := LoadFunction('i2d_DHparams',AFailed);
  d2i_DHxparams := LoadFunction('d2i_DHxparams',AFailed);
  i2d_DHxparams := LoadFunction('i2d_DHxparams',AFailed);
  DHparams_print := LoadFunction('DHparams_print',AFailed);
  DH_get_1024_160 := LoadFunction('DH_get_1024_160',AFailed);
  DH_get_2048_224 := LoadFunction('DH_get_2048_224',AFailed);
  DH_get_2048_256 := LoadFunction('DH_get_2048_256',AFailed);
  DH_KDF_X9_42 := LoadFunction('DH_KDF_X9_42',AFailed);
  DH_bits := LoadFunction('DH_bits',nil); {introduced 1.1.0}
  DH_security_bits := LoadFunction('DH_security_bits',nil); {introduced 1.1.0}
  DH_check_params_ex := LoadFunction('DH_check_params_ex',nil); {introduced 1.1.0}
  DH_check_ex := LoadFunction('DH_check_ex',nil); {introduced 1.1.0}
  DH_check_pub_key_ex := LoadFunction('DH_check_pub_key_ex',nil); {introduced 1.1.0}
  DH_check_params := LoadFunction('DH_check_params',nil); {introduced 1.1.0}
  DH_new_by_nid := LoadFunction('DH_new_by_nid',nil); {introduced 1.1.0}
  DH_get_nid := LoadFunction('DH_get_nid',nil); {introduced 1.1.0}
  DH_get0_pqg := LoadFunction('DH_get0_pqg',nil); {introduced 1.1.0}
  DH_set0_pqg := LoadFunction('DH_set0_pqg',nil); {introduced 1.1.0}
  DH_get0_key := LoadFunction('DH_get0_key',nil); {introduced 1.1.0}
  DH_set0_key := LoadFunction('DH_set0_key',nil); {introduced 1.1.0}
  DH_get0_p := LoadFunction('DH_get0_p',nil); {introduced 1.1.0}
  DH_get0_q := LoadFunction('DH_get0_q',nil); {introduced 1.1.0}
  DH_get0_g := LoadFunction('DH_get0_g',nil); {introduced 1.1.0}
  DH_get0_priv_key := LoadFunction('DH_get0_priv_key',nil); {introduced 1.1.0}
  DH_get0_pub_key := LoadFunction('DH_get0_pub_key',nil); {introduced 1.1.0}
  DH_clear_flags := LoadFunction('DH_clear_flags',nil); {introduced 1.1.0}
  DH_test_flags := LoadFunction('DH_test_flags',nil); {introduced 1.1.0}
  DH_set_flags := LoadFunction('DH_set_flags',nil); {introduced 1.1.0}
  DH_get0_engine := LoadFunction('DH_get0_engine',nil); {introduced 1.1.0}
  DH_get_length := LoadFunction('DH_get_length',nil); {introduced 1.1.0}
  DH_set_length := LoadFunction('DH_set_length',nil); {introduced 1.1.0}
  DH_meth_new := LoadFunction('DH_meth_new',nil); {introduced 1.1.0}
  DH_meth_free := LoadFunction('DH_meth_free',nil); {introduced 1.1.0}
  DH_meth_dup := LoadFunction('DH_meth_dup',nil); {introduced 1.1.0}
  DH_meth_get0_name := LoadFunction('DH_meth_get0_name',nil); {introduced 1.1.0}
  DH_meth_set1_name := LoadFunction('DH_meth_set1_name',nil); {introduced 1.1.0}
  DH_meth_get_flags := LoadFunction('DH_meth_get_flags',nil); {introduced 1.1.0}
  DH_meth_set_flags := LoadFunction('DH_meth_set_flags',nil); {introduced 1.1.0}
  DH_meth_get0_app_data := LoadFunction('DH_meth_get0_app_data',nil); {introduced 1.1.0}
  DH_meth_set0_app_data := LoadFunction('DH_meth_set0_app_data',nil); {introduced 1.1.0}
  DH_meth_get_generate_key := LoadFunction('DH_meth_get_generate_key',nil); {introduced 1.1.0}
  DH_meth_set_generate_key := LoadFunction('DH_meth_set_generate_key',nil); {introduced 1.1.0}
  DH_meth_get_compute_key := LoadFunction('DH_meth_get_compute_key',nil); {introduced 1.1.0}
  DH_meth_set_compute_key := LoadFunction('DH_meth_set_compute_key',nil); {introduced 1.1.0}
  DH_meth_get_bn_mod_exp := LoadFunction('DH_meth_get_bn_mod_exp',nil); {introduced 1.1.0}
  DH_meth_set_bn_mod_exp := LoadFunction('DH_meth_set_bn_mod_exp',nil); {introduced 1.1.0}
  DH_meth_get_init := LoadFunction('DH_meth_get_init',nil); {introduced 1.1.0}
  DH_meth_set_init := LoadFunction('DH_meth_set_init',nil); {introduced 1.1.0}
  DH_meth_get_finish := LoadFunction('DH_meth_get_finish',nil); {introduced 1.1.0}
  DH_meth_set_finish := LoadFunction('DH_meth_set_finish',nil); {introduced 1.1.0}
  DH_meth_get_generate_params := LoadFunction('DH_meth_get_generate_params',nil); {introduced 1.1.0}
  DH_meth_set_generate_params := LoadFunction('DH_meth_set_generate_params',nil); {introduced 1.1.0}
  if not assigned(DH_bits) then 
  begin
    {$if declared(DH_bits_introduced)}
    if LibVersion < DH_bits_introduced then
      {$if declared(FC_DH_bits)}
      DH_bits := @FC_DH_bits
      {$else}
      DH_bits := @ERR_DH_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_bits_removed)}
   if DH_bits_removed <= LibVersion then
     {$if declared(_DH_bits)}
     DH_bits := @_DH_bits
     {$else}
       {$IF declared(ERR_DH_bits)}
       DH_bits := @ERR_DH_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_bits) and Assigned(AFailed) then 
     AFailed.Add('DH_bits');
  end;


  if not assigned(DH_security_bits) then 
  begin
    {$if declared(DH_security_bits_introduced)}
    if LibVersion < DH_security_bits_introduced then
      {$if declared(FC_DH_security_bits)}
      DH_security_bits := @FC_DH_security_bits
      {$else}
      DH_security_bits := @ERR_DH_security_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_security_bits_removed)}
   if DH_security_bits_removed <= LibVersion then
     {$if declared(_DH_security_bits)}
     DH_security_bits := @_DH_security_bits
     {$else}
       {$IF declared(ERR_DH_security_bits)}
       DH_security_bits := @ERR_DH_security_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_security_bits) and Assigned(AFailed) then 
     AFailed.Add('DH_security_bits');
  end;


  if not assigned(DH_check_params_ex) then 
  begin
    {$if declared(DH_check_params_ex_introduced)}
    if LibVersion < DH_check_params_ex_introduced then
      {$if declared(FC_DH_check_params_ex)}
      DH_check_params_ex := @FC_DH_check_params_ex
      {$else}
      DH_check_params_ex := @ERR_DH_check_params_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_check_params_ex_removed)}
   if DH_check_params_ex_removed <= LibVersion then
     {$if declared(_DH_check_params_ex)}
     DH_check_params_ex := @_DH_check_params_ex
     {$else}
       {$IF declared(ERR_DH_check_params_ex)}
       DH_check_params_ex := @ERR_DH_check_params_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_check_params_ex) and Assigned(AFailed) then 
     AFailed.Add('DH_check_params_ex');
  end;


  if not assigned(DH_check_ex) then 
  begin
    {$if declared(DH_check_ex_introduced)}
    if LibVersion < DH_check_ex_introduced then
      {$if declared(FC_DH_check_ex)}
      DH_check_ex := @FC_DH_check_ex
      {$else}
      DH_check_ex := @ERR_DH_check_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_check_ex_removed)}
   if DH_check_ex_removed <= LibVersion then
     {$if declared(_DH_check_ex)}
     DH_check_ex := @_DH_check_ex
     {$else}
       {$IF declared(ERR_DH_check_ex)}
       DH_check_ex := @ERR_DH_check_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_check_ex) and Assigned(AFailed) then 
     AFailed.Add('DH_check_ex');
  end;


  if not assigned(DH_check_pub_key_ex) then 
  begin
    {$if declared(DH_check_pub_key_ex_introduced)}
    if LibVersion < DH_check_pub_key_ex_introduced then
      {$if declared(FC_DH_check_pub_key_ex)}
      DH_check_pub_key_ex := @FC_DH_check_pub_key_ex
      {$else}
      DH_check_pub_key_ex := @ERR_DH_check_pub_key_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_check_pub_key_ex_removed)}
   if DH_check_pub_key_ex_removed <= LibVersion then
     {$if declared(_DH_check_pub_key_ex)}
     DH_check_pub_key_ex := @_DH_check_pub_key_ex
     {$else}
       {$IF declared(ERR_DH_check_pub_key_ex)}
       DH_check_pub_key_ex := @ERR_DH_check_pub_key_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_check_pub_key_ex) and Assigned(AFailed) then 
     AFailed.Add('DH_check_pub_key_ex');
  end;


  if not assigned(DH_check_params) then 
  begin
    {$if declared(DH_check_params_introduced)}
    if LibVersion < DH_check_params_introduced then
      {$if declared(FC_DH_check_params)}
      DH_check_params := @FC_DH_check_params
      {$else}
      DH_check_params := @ERR_DH_check_params
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_check_params_removed)}
   if DH_check_params_removed <= LibVersion then
     {$if declared(_DH_check_params)}
     DH_check_params := @_DH_check_params
     {$else}
       {$IF declared(ERR_DH_check_params)}
       DH_check_params := @ERR_DH_check_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_check_params) and Assigned(AFailed) then 
     AFailed.Add('DH_check_params');
  end;


  if not assigned(DH_new_by_nid) then 
  begin
    {$if declared(DH_new_by_nid_introduced)}
    if LibVersion < DH_new_by_nid_introduced then
      {$if declared(FC_DH_new_by_nid)}
      DH_new_by_nid := @FC_DH_new_by_nid
      {$else}
      DH_new_by_nid := @ERR_DH_new_by_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_new_by_nid_removed)}
   if DH_new_by_nid_removed <= LibVersion then
     {$if declared(_DH_new_by_nid)}
     DH_new_by_nid := @_DH_new_by_nid
     {$else}
       {$IF declared(ERR_DH_new_by_nid)}
       DH_new_by_nid := @ERR_DH_new_by_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_new_by_nid) and Assigned(AFailed) then 
     AFailed.Add('DH_new_by_nid');
  end;


  if not assigned(DH_get_nid) then 
  begin
    {$if declared(DH_get_nid_introduced)}
    if LibVersion < DH_get_nid_introduced then
      {$if declared(FC_DH_get_nid)}
      DH_get_nid := @FC_DH_get_nid
      {$else}
      DH_get_nid := @ERR_DH_get_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get_nid_removed)}
   if DH_get_nid_removed <= LibVersion then
     {$if declared(_DH_get_nid)}
     DH_get_nid := @_DH_get_nid
     {$else}
       {$IF declared(ERR_DH_get_nid)}
       DH_get_nid := @ERR_DH_get_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get_nid) and Assigned(AFailed) then 
     AFailed.Add('DH_get_nid');
  end;


  if not assigned(DH_get0_pqg) then 
  begin
    {$if declared(DH_get0_pqg_introduced)}
    if LibVersion < DH_get0_pqg_introduced then
      {$if declared(FC_DH_get0_pqg)}
      DH_get0_pqg := @FC_DH_get0_pqg
      {$else}
      DH_get0_pqg := @ERR_DH_get0_pqg
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_pqg_removed)}
   if DH_get0_pqg_removed <= LibVersion then
     {$if declared(_DH_get0_pqg)}
     DH_get0_pqg := @_DH_get0_pqg
     {$else}
       {$IF declared(ERR_DH_get0_pqg)}
       DH_get0_pqg := @ERR_DH_get0_pqg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_pqg) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_pqg');
  end;


  if not assigned(DH_set0_pqg) then 
  begin
    {$if declared(DH_set0_pqg_introduced)}
    if LibVersion < DH_set0_pqg_introduced then
      {$if declared(FC_DH_set0_pqg)}
      DH_set0_pqg := @FC_DH_set0_pqg
      {$else}
      DH_set0_pqg := @ERR_DH_set0_pqg
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_set0_pqg_removed)}
   if DH_set0_pqg_removed <= LibVersion then
     {$if declared(_DH_set0_pqg)}
     DH_set0_pqg := @_DH_set0_pqg
     {$else}
       {$IF declared(ERR_DH_set0_pqg)}
       DH_set0_pqg := @ERR_DH_set0_pqg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_set0_pqg) and Assigned(AFailed) then 
     AFailed.Add('DH_set0_pqg');
  end;


  if not assigned(DH_get0_key) then 
  begin
    {$if declared(DH_get0_key_introduced)}
    if LibVersion < DH_get0_key_introduced then
      {$if declared(FC_DH_get0_key)}
      DH_get0_key := @FC_DH_get0_key
      {$else}
      DH_get0_key := @ERR_DH_get0_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_key_removed)}
   if DH_get0_key_removed <= LibVersion then
     {$if declared(_DH_get0_key)}
     DH_get0_key := @_DH_get0_key
     {$else}
       {$IF declared(ERR_DH_get0_key)}
       DH_get0_key := @ERR_DH_get0_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_key) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_key');
  end;


  if not assigned(DH_set0_key) then 
  begin
    {$if declared(DH_set0_key_introduced)}
    if LibVersion < DH_set0_key_introduced then
      {$if declared(FC_DH_set0_key)}
      DH_set0_key := @FC_DH_set0_key
      {$else}
      DH_set0_key := @ERR_DH_set0_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_set0_key_removed)}
   if DH_set0_key_removed <= LibVersion then
     {$if declared(_DH_set0_key)}
     DH_set0_key := @_DH_set0_key
     {$else}
       {$IF declared(ERR_DH_set0_key)}
       DH_set0_key := @ERR_DH_set0_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_set0_key) and Assigned(AFailed) then 
     AFailed.Add('DH_set0_key');
  end;


  if not assigned(DH_get0_p) then 
  begin
    {$if declared(DH_get0_p_introduced)}
    if LibVersion < DH_get0_p_introduced then
      {$if declared(FC_DH_get0_p)}
      DH_get0_p := @FC_DH_get0_p
      {$else}
      DH_get0_p := @ERR_DH_get0_p
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_p_removed)}
   if DH_get0_p_removed <= LibVersion then
     {$if declared(_DH_get0_p)}
     DH_get0_p := @_DH_get0_p
     {$else}
       {$IF declared(ERR_DH_get0_p)}
       DH_get0_p := @ERR_DH_get0_p
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_p) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_p');
  end;


  if not assigned(DH_get0_q) then 
  begin
    {$if declared(DH_get0_q_introduced)}
    if LibVersion < DH_get0_q_introduced then
      {$if declared(FC_DH_get0_q)}
      DH_get0_q := @FC_DH_get0_q
      {$else}
      DH_get0_q := @ERR_DH_get0_q
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_q_removed)}
   if DH_get0_q_removed <= LibVersion then
     {$if declared(_DH_get0_q)}
     DH_get0_q := @_DH_get0_q
     {$else}
       {$IF declared(ERR_DH_get0_q)}
       DH_get0_q := @ERR_DH_get0_q
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_q) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_q');
  end;


  if not assigned(DH_get0_g) then 
  begin
    {$if declared(DH_get0_g_introduced)}
    if LibVersion < DH_get0_g_introduced then
      {$if declared(FC_DH_get0_g)}
      DH_get0_g := @FC_DH_get0_g
      {$else}
      DH_get0_g := @ERR_DH_get0_g
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_g_removed)}
   if DH_get0_g_removed <= LibVersion then
     {$if declared(_DH_get0_g)}
     DH_get0_g := @_DH_get0_g
     {$else}
       {$IF declared(ERR_DH_get0_g)}
       DH_get0_g := @ERR_DH_get0_g
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_g) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_g');
  end;


  if not assigned(DH_get0_priv_key) then 
  begin
    {$if declared(DH_get0_priv_key_introduced)}
    if LibVersion < DH_get0_priv_key_introduced then
      {$if declared(FC_DH_get0_priv_key)}
      DH_get0_priv_key := @FC_DH_get0_priv_key
      {$else}
      DH_get0_priv_key := @ERR_DH_get0_priv_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_priv_key_removed)}
   if DH_get0_priv_key_removed <= LibVersion then
     {$if declared(_DH_get0_priv_key)}
     DH_get0_priv_key := @_DH_get0_priv_key
     {$else}
       {$IF declared(ERR_DH_get0_priv_key)}
       DH_get0_priv_key := @ERR_DH_get0_priv_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_priv_key) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_priv_key');
  end;


  if not assigned(DH_get0_pub_key) then 
  begin
    {$if declared(DH_get0_pub_key_introduced)}
    if LibVersion < DH_get0_pub_key_introduced then
      {$if declared(FC_DH_get0_pub_key)}
      DH_get0_pub_key := @FC_DH_get0_pub_key
      {$else}
      DH_get0_pub_key := @ERR_DH_get0_pub_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_pub_key_removed)}
   if DH_get0_pub_key_removed <= LibVersion then
     {$if declared(_DH_get0_pub_key)}
     DH_get0_pub_key := @_DH_get0_pub_key
     {$else}
       {$IF declared(ERR_DH_get0_pub_key)}
       DH_get0_pub_key := @ERR_DH_get0_pub_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_pub_key) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_pub_key');
  end;


  if not assigned(DH_clear_flags) then 
  begin
    {$if declared(DH_clear_flags_introduced)}
    if LibVersion < DH_clear_flags_introduced then
      {$if declared(FC_DH_clear_flags)}
      DH_clear_flags := @FC_DH_clear_flags
      {$else}
      DH_clear_flags := @ERR_DH_clear_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_clear_flags_removed)}
   if DH_clear_flags_removed <= LibVersion then
     {$if declared(_DH_clear_flags)}
     DH_clear_flags := @_DH_clear_flags
     {$else}
       {$IF declared(ERR_DH_clear_flags)}
       DH_clear_flags := @ERR_DH_clear_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_clear_flags) and Assigned(AFailed) then 
     AFailed.Add('DH_clear_flags');
  end;


  if not assigned(DH_test_flags) then 
  begin
    {$if declared(DH_test_flags_introduced)}
    if LibVersion < DH_test_flags_introduced then
      {$if declared(FC_DH_test_flags)}
      DH_test_flags := @FC_DH_test_flags
      {$else}
      DH_test_flags := @ERR_DH_test_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_test_flags_removed)}
   if DH_test_flags_removed <= LibVersion then
     {$if declared(_DH_test_flags)}
     DH_test_flags := @_DH_test_flags
     {$else}
       {$IF declared(ERR_DH_test_flags)}
       DH_test_flags := @ERR_DH_test_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_test_flags) and Assigned(AFailed) then 
     AFailed.Add('DH_test_flags');
  end;


  if not assigned(DH_set_flags) then 
  begin
    {$if declared(DH_set_flags_introduced)}
    if LibVersion < DH_set_flags_introduced then
      {$if declared(FC_DH_set_flags)}
      DH_set_flags := @FC_DH_set_flags
      {$else}
      DH_set_flags := @ERR_DH_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_set_flags_removed)}
   if DH_set_flags_removed <= LibVersion then
     {$if declared(_DH_set_flags)}
     DH_set_flags := @_DH_set_flags
     {$else}
       {$IF declared(ERR_DH_set_flags)}
       DH_set_flags := @ERR_DH_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_set_flags) and Assigned(AFailed) then 
     AFailed.Add('DH_set_flags');
  end;


  if not assigned(DH_get0_engine) then 
  begin
    {$if declared(DH_get0_engine_introduced)}
    if LibVersion < DH_get0_engine_introduced then
      {$if declared(FC_DH_get0_engine)}
      DH_get0_engine := @FC_DH_get0_engine
      {$else}
      DH_get0_engine := @ERR_DH_get0_engine
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get0_engine_removed)}
   if DH_get0_engine_removed <= LibVersion then
     {$if declared(_DH_get0_engine)}
     DH_get0_engine := @_DH_get0_engine
     {$else}
       {$IF declared(ERR_DH_get0_engine)}
       DH_get0_engine := @ERR_DH_get0_engine
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get0_engine) and Assigned(AFailed) then 
     AFailed.Add('DH_get0_engine');
  end;


  if not assigned(DH_get_length) then 
  begin
    {$if declared(DH_get_length_introduced)}
    if LibVersion < DH_get_length_introduced then
      {$if declared(FC_DH_get_length)}
      DH_get_length := @FC_DH_get_length
      {$else}
      DH_get_length := @ERR_DH_get_length
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_get_length_removed)}
   if DH_get_length_removed <= LibVersion then
     {$if declared(_DH_get_length)}
     DH_get_length := @_DH_get_length
     {$else}
       {$IF declared(ERR_DH_get_length)}
       DH_get_length := @ERR_DH_get_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_get_length) and Assigned(AFailed) then 
     AFailed.Add('DH_get_length');
  end;


  if not assigned(DH_set_length) then 
  begin
    {$if declared(DH_set_length_introduced)}
    if LibVersion < DH_set_length_introduced then
      {$if declared(FC_DH_set_length)}
      DH_set_length := @FC_DH_set_length
      {$else}
      DH_set_length := @ERR_DH_set_length
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_set_length_removed)}
   if DH_set_length_removed <= LibVersion then
     {$if declared(_DH_set_length)}
     DH_set_length := @_DH_set_length
     {$else}
       {$IF declared(ERR_DH_set_length)}
       DH_set_length := @ERR_DH_set_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_set_length) and Assigned(AFailed) then 
     AFailed.Add('DH_set_length');
  end;


  if not assigned(DH_meth_new) then 
  begin
    {$if declared(DH_meth_new_introduced)}
    if LibVersion < DH_meth_new_introduced then
      {$if declared(FC_DH_meth_new)}
      DH_meth_new := @FC_DH_meth_new
      {$else}
      DH_meth_new := @ERR_DH_meth_new
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_new_removed)}
   if DH_meth_new_removed <= LibVersion then
     {$if declared(_DH_meth_new)}
     DH_meth_new := @_DH_meth_new
     {$else}
       {$IF declared(ERR_DH_meth_new)}
       DH_meth_new := @ERR_DH_meth_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_new) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_new');
  end;


  if not assigned(DH_meth_free) then 
  begin
    {$if declared(DH_meth_free_introduced)}
    if LibVersion < DH_meth_free_introduced then
      {$if declared(FC_DH_meth_free)}
      DH_meth_free := @FC_DH_meth_free
      {$else}
      DH_meth_free := @ERR_DH_meth_free
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_free_removed)}
   if DH_meth_free_removed <= LibVersion then
     {$if declared(_DH_meth_free)}
     DH_meth_free := @_DH_meth_free
     {$else}
       {$IF declared(ERR_DH_meth_free)}
       DH_meth_free := @ERR_DH_meth_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_free) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_free');
  end;


  if not assigned(DH_meth_dup) then 
  begin
    {$if declared(DH_meth_dup_introduced)}
    if LibVersion < DH_meth_dup_introduced then
      {$if declared(FC_DH_meth_dup)}
      DH_meth_dup := @FC_DH_meth_dup
      {$else}
      DH_meth_dup := @ERR_DH_meth_dup
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_dup_removed)}
   if DH_meth_dup_removed <= LibVersion then
     {$if declared(_DH_meth_dup)}
     DH_meth_dup := @_DH_meth_dup
     {$else}
       {$IF declared(ERR_DH_meth_dup)}
       DH_meth_dup := @ERR_DH_meth_dup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_dup) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_dup');
  end;


  if not assigned(DH_meth_get0_name) then 
  begin
    {$if declared(DH_meth_get0_name_introduced)}
    if LibVersion < DH_meth_get0_name_introduced then
      {$if declared(FC_DH_meth_get0_name)}
      DH_meth_get0_name := @FC_DH_meth_get0_name
      {$else}
      DH_meth_get0_name := @ERR_DH_meth_get0_name
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get0_name_removed)}
   if DH_meth_get0_name_removed <= LibVersion then
     {$if declared(_DH_meth_get0_name)}
     DH_meth_get0_name := @_DH_meth_get0_name
     {$else}
       {$IF declared(ERR_DH_meth_get0_name)}
       DH_meth_get0_name := @ERR_DH_meth_get0_name
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get0_name) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get0_name');
  end;


  if not assigned(DH_meth_set1_name) then 
  begin
    {$if declared(DH_meth_set1_name_introduced)}
    if LibVersion < DH_meth_set1_name_introduced then
      {$if declared(FC_DH_meth_set1_name)}
      DH_meth_set1_name := @FC_DH_meth_set1_name
      {$else}
      DH_meth_set1_name := @ERR_DH_meth_set1_name
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set1_name_removed)}
   if DH_meth_set1_name_removed <= LibVersion then
     {$if declared(_DH_meth_set1_name)}
     DH_meth_set1_name := @_DH_meth_set1_name
     {$else}
       {$IF declared(ERR_DH_meth_set1_name)}
       DH_meth_set1_name := @ERR_DH_meth_set1_name
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set1_name) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set1_name');
  end;


  if not assigned(DH_meth_get_flags) then 
  begin
    {$if declared(DH_meth_get_flags_introduced)}
    if LibVersion < DH_meth_get_flags_introduced then
      {$if declared(FC_DH_meth_get_flags)}
      DH_meth_get_flags := @FC_DH_meth_get_flags
      {$else}
      DH_meth_get_flags := @ERR_DH_meth_get_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_flags_removed)}
   if DH_meth_get_flags_removed <= LibVersion then
     {$if declared(_DH_meth_get_flags)}
     DH_meth_get_flags := @_DH_meth_get_flags
     {$else}
       {$IF declared(ERR_DH_meth_get_flags)}
       DH_meth_get_flags := @ERR_DH_meth_get_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_flags) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_flags');
  end;


  if not assigned(DH_meth_set_flags) then 
  begin
    {$if declared(DH_meth_set_flags_introduced)}
    if LibVersion < DH_meth_set_flags_introduced then
      {$if declared(FC_DH_meth_set_flags)}
      DH_meth_set_flags := @FC_DH_meth_set_flags
      {$else}
      DH_meth_set_flags := @ERR_DH_meth_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_flags_removed)}
   if DH_meth_set_flags_removed <= LibVersion then
     {$if declared(_DH_meth_set_flags)}
     DH_meth_set_flags := @_DH_meth_set_flags
     {$else}
       {$IF declared(ERR_DH_meth_set_flags)}
       DH_meth_set_flags := @ERR_DH_meth_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_flags) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_flags');
  end;


  if not assigned(DH_meth_get0_app_data) then 
  begin
    {$if declared(DH_meth_get0_app_data_introduced)}
    if LibVersion < DH_meth_get0_app_data_introduced then
      {$if declared(FC_DH_meth_get0_app_data)}
      DH_meth_get0_app_data := @FC_DH_meth_get0_app_data
      {$else}
      DH_meth_get0_app_data := @ERR_DH_meth_get0_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get0_app_data_removed)}
   if DH_meth_get0_app_data_removed <= LibVersion then
     {$if declared(_DH_meth_get0_app_data)}
     DH_meth_get0_app_data := @_DH_meth_get0_app_data
     {$else}
       {$IF declared(ERR_DH_meth_get0_app_data)}
       DH_meth_get0_app_data := @ERR_DH_meth_get0_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get0_app_data) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get0_app_data');
  end;


  if not assigned(DH_meth_set0_app_data) then 
  begin
    {$if declared(DH_meth_set0_app_data_introduced)}
    if LibVersion < DH_meth_set0_app_data_introduced then
      {$if declared(FC_DH_meth_set0_app_data)}
      DH_meth_set0_app_data := @FC_DH_meth_set0_app_data
      {$else}
      DH_meth_set0_app_data := @ERR_DH_meth_set0_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set0_app_data_removed)}
   if DH_meth_set0_app_data_removed <= LibVersion then
     {$if declared(_DH_meth_set0_app_data)}
     DH_meth_set0_app_data := @_DH_meth_set0_app_data
     {$else}
       {$IF declared(ERR_DH_meth_set0_app_data)}
       DH_meth_set0_app_data := @ERR_DH_meth_set0_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set0_app_data) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set0_app_data');
  end;


  if not assigned(DH_meth_get_generate_key) then 
  begin
    {$if declared(DH_meth_get_generate_key_introduced)}
    if LibVersion < DH_meth_get_generate_key_introduced then
      {$if declared(FC_DH_meth_get_generate_key)}
      DH_meth_get_generate_key := @FC_DH_meth_get_generate_key
      {$else}
      DH_meth_get_generate_key := @ERR_DH_meth_get_generate_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_generate_key_removed)}
   if DH_meth_get_generate_key_removed <= LibVersion then
     {$if declared(_DH_meth_get_generate_key)}
     DH_meth_get_generate_key := @_DH_meth_get_generate_key
     {$else}
       {$IF declared(ERR_DH_meth_get_generate_key)}
       DH_meth_get_generate_key := @ERR_DH_meth_get_generate_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_generate_key) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_generate_key');
  end;


  if not assigned(DH_meth_set_generate_key) then 
  begin
    {$if declared(DH_meth_set_generate_key_introduced)}
    if LibVersion < DH_meth_set_generate_key_introduced then
      {$if declared(FC_DH_meth_set_generate_key)}
      DH_meth_set_generate_key := @FC_DH_meth_set_generate_key
      {$else}
      DH_meth_set_generate_key := @ERR_DH_meth_set_generate_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_generate_key_removed)}
   if DH_meth_set_generate_key_removed <= LibVersion then
     {$if declared(_DH_meth_set_generate_key)}
     DH_meth_set_generate_key := @_DH_meth_set_generate_key
     {$else}
       {$IF declared(ERR_DH_meth_set_generate_key)}
       DH_meth_set_generate_key := @ERR_DH_meth_set_generate_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_generate_key) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_generate_key');
  end;


  if not assigned(DH_meth_get_compute_key) then 
  begin
    {$if declared(DH_meth_get_compute_key_introduced)}
    if LibVersion < DH_meth_get_compute_key_introduced then
      {$if declared(FC_DH_meth_get_compute_key)}
      DH_meth_get_compute_key := @FC_DH_meth_get_compute_key
      {$else}
      DH_meth_get_compute_key := @ERR_DH_meth_get_compute_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_compute_key_removed)}
   if DH_meth_get_compute_key_removed <= LibVersion then
     {$if declared(_DH_meth_get_compute_key)}
     DH_meth_get_compute_key := @_DH_meth_get_compute_key
     {$else}
       {$IF declared(ERR_DH_meth_get_compute_key)}
       DH_meth_get_compute_key := @ERR_DH_meth_get_compute_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_compute_key) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_compute_key');
  end;


  if not assigned(DH_meth_set_compute_key) then 
  begin
    {$if declared(DH_meth_set_compute_key_introduced)}
    if LibVersion < DH_meth_set_compute_key_introduced then
      {$if declared(FC_DH_meth_set_compute_key)}
      DH_meth_set_compute_key := @FC_DH_meth_set_compute_key
      {$else}
      DH_meth_set_compute_key := @ERR_DH_meth_set_compute_key
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_compute_key_removed)}
   if DH_meth_set_compute_key_removed <= LibVersion then
     {$if declared(_DH_meth_set_compute_key)}
     DH_meth_set_compute_key := @_DH_meth_set_compute_key
     {$else}
       {$IF declared(ERR_DH_meth_set_compute_key)}
       DH_meth_set_compute_key := @ERR_DH_meth_set_compute_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_compute_key) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_compute_key');
  end;


  if not assigned(DH_meth_get_bn_mod_exp) then 
  begin
    {$if declared(DH_meth_get_bn_mod_exp_introduced)}
    if LibVersion < DH_meth_get_bn_mod_exp_introduced then
      {$if declared(FC_DH_meth_get_bn_mod_exp)}
      DH_meth_get_bn_mod_exp := @FC_DH_meth_get_bn_mod_exp
      {$else}
      DH_meth_get_bn_mod_exp := @ERR_DH_meth_get_bn_mod_exp
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_bn_mod_exp_removed)}
   if DH_meth_get_bn_mod_exp_removed <= LibVersion then
     {$if declared(_DH_meth_get_bn_mod_exp)}
     DH_meth_get_bn_mod_exp := @_DH_meth_get_bn_mod_exp
     {$else}
       {$IF declared(ERR_DH_meth_get_bn_mod_exp)}
       DH_meth_get_bn_mod_exp := @ERR_DH_meth_get_bn_mod_exp
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_bn_mod_exp) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_bn_mod_exp');
  end;


  if not assigned(DH_meth_set_bn_mod_exp) then 
  begin
    {$if declared(DH_meth_set_bn_mod_exp_introduced)}
    if LibVersion < DH_meth_set_bn_mod_exp_introduced then
      {$if declared(FC_DH_meth_set_bn_mod_exp)}
      DH_meth_set_bn_mod_exp := @FC_DH_meth_set_bn_mod_exp
      {$else}
      DH_meth_set_bn_mod_exp := @ERR_DH_meth_set_bn_mod_exp
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_bn_mod_exp_removed)}
   if DH_meth_set_bn_mod_exp_removed <= LibVersion then
     {$if declared(_DH_meth_set_bn_mod_exp)}
     DH_meth_set_bn_mod_exp := @_DH_meth_set_bn_mod_exp
     {$else}
       {$IF declared(ERR_DH_meth_set_bn_mod_exp)}
       DH_meth_set_bn_mod_exp := @ERR_DH_meth_set_bn_mod_exp
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_bn_mod_exp) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_bn_mod_exp');
  end;


  if not assigned(DH_meth_get_init) then 
  begin
    {$if declared(DH_meth_get_init_introduced)}
    if LibVersion < DH_meth_get_init_introduced then
      {$if declared(FC_DH_meth_get_init)}
      DH_meth_get_init := @FC_DH_meth_get_init
      {$else}
      DH_meth_get_init := @ERR_DH_meth_get_init
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_init_removed)}
   if DH_meth_get_init_removed <= LibVersion then
     {$if declared(_DH_meth_get_init)}
     DH_meth_get_init := @_DH_meth_get_init
     {$else}
       {$IF declared(ERR_DH_meth_get_init)}
       DH_meth_get_init := @ERR_DH_meth_get_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_init) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_init');
  end;


  if not assigned(DH_meth_set_init) then 
  begin
    {$if declared(DH_meth_set_init_introduced)}
    if LibVersion < DH_meth_set_init_introduced then
      {$if declared(FC_DH_meth_set_init)}
      DH_meth_set_init := @FC_DH_meth_set_init
      {$else}
      DH_meth_set_init := @ERR_DH_meth_set_init
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_init_removed)}
   if DH_meth_set_init_removed <= LibVersion then
     {$if declared(_DH_meth_set_init)}
     DH_meth_set_init := @_DH_meth_set_init
     {$else}
       {$IF declared(ERR_DH_meth_set_init)}
       DH_meth_set_init := @ERR_DH_meth_set_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_init) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_init');
  end;


  if not assigned(DH_meth_get_finish) then 
  begin
    {$if declared(DH_meth_get_finish_introduced)}
    if LibVersion < DH_meth_get_finish_introduced then
      {$if declared(FC_DH_meth_get_finish)}
      DH_meth_get_finish := @FC_DH_meth_get_finish
      {$else}
      DH_meth_get_finish := @ERR_DH_meth_get_finish
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_finish_removed)}
   if DH_meth_get_finish_removed <= LibVersion then
     {$if declared(_DH_meth_get_finish)}
     DH_meth_get_finish := @_DH_meth_get_finish
     {$else}
       {$IF declared(ERR_DH_meth_get_finish)}
       DH_meth_get_finish := @ERR_DH_meth_get_finish
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_finish) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_finish');
  end;


  if not assigned(DH_meth_set_finish) then 
  begin
    {$if declared(DH_meth_set_finish_introduced)}
    if LibVersion < DH_meth_set_finish_introduced then
      {$if declared(FC_DH_meth_set_finish)}
      DH_meth_set_finish := @FC_DH_meth_set_finish
      {$else}
      DH_meth_set_finish := @ERR_DH_meth_set_finish
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_finish_removed)}
   if DH_meth_set_finish_removed <= LibVersion then
     {$if declared(_DH_meth_set_finish)}
     DH_meth_set_finish := @_DH_meth_set_finish
     {$else}
       {$IF declared(ERR_DH_meth_set_finish)}
       DH_meth_set_finish := @ERR_DH_meth_set_finish
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_finish) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_finish');
  end;


  if not assigned(DH_meth_get_generate_params) then 
  begin
    {$if declared(DH_meth_get_generate_params_introduced)}
    if LibVersion < DH_meth_get_generate_params_introduced then
      {$if declared(FC_DH_meth_get_generate_params)}
      DH_meth_get_generate_params := @FC_DH_meth_get_generate_params
      {$else}
      DH_meth_get_generate_params := @ERR_DH_meth_get_generate_params
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_get_generate_params_removed)}
   if DH_meth_get_generate_params_removed <= LibVersion then
     {$if declared(_DH_meth_get_generate_params)}
     DH_meth_get_generate_params := @_DH_meth_get_generate_params
     {$else}
       {$IF declared(ERR_DH_meth_get_generate_params)}
       DH_meth_get_generate_params := @ERR_DH_meth_get_generate_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_get_generate_params) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_get_generate_params');
  end;


  if not assigned(DH_meth_set_generate_params) then 
  begin
    {$if declared(DH_meth_set_generate_params_introduced)}
    if LibVersion < DH_meth_set_generate_params_introduced then
      {$if declared(FC_DH_meth_set_generate_params)}
      DH_meth_set_generate_params := @FC_DH_meth_set_generate_params
      {$else}
      DH_meth_set_generate_params := @ERR_DH_meth_set_generate_params
      {$ifend}
    else
    {$ifend}
   {$if declared(DH_meth_set_generate_params_removed)}
   if DH_meth_set_generate_params_removed <= LibVersion then
     {$if declared(_DH_meth_set_generate_params)}
     DH_meth_set_generate_params := @_DH_meth_set_generate_params
     {$else}
       {$IF declared(ERR_DH_meth_set_generate_params)}
       DH_meth_set_generate_params := @ERR_DH_meth_set_generate_params
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DH_meth_set_generate_params) and Assigned(AFailed) then 
     AFailed.Add('DH_meth_set_generate_params');
  end;


end;

procedure Unload;
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
  DH_bits := nil; {introduced 1.1.0}
  DH_size := nil;
  DH_security_bits := nil; {introduced 1.1.0}
  DH_set_ex_data := nil;
  DH_get_ex_data := nil;
  DH_generate_parameters_ex := nil;
  DH_check_params_ex := nil; {introduced 1.1.0}
  DH_check_ex := nil; {introduced 1.1.0}
  DH_check_pub_key_ex := nil; {introduced 1.1.0}
  DH_check_params := nil; {introduced 1.1.0}
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
  DH_new_by_nid := nil; {introduced 1.1.0}
  DH_get_nid := nil; {introduced 1.1.0}
  DH_KDF_X9_42 := nil;
  DH_get0_pqg := nil; {introduced 1.1.0}
  DH_set0_pqg := nil; {introduced 1.1.0}
  DH_get0_key := nil; {introduced 1.1.0}
  DH_set0_key := nil; {introduced 1.1.0}
  DH_get0_p := nil; {introduced 1.1.0}
  DH_get0_q := nil; {introduced 1.1.0}
  DH_get0_g := nil; {introduced 1.1.0}
  DH_get0_priv_key := nil; {introduced 1.1.0}
  DH_get0_pub_key := nil; {introduced 1.1.0}
  DH_clear_flags := nil; {introduced 1.1.0}
  DH_test_flags := nil; {introduced 1.1.0}
  DH_set_flags := nil; {introduced 1.1.0}
  DH_get0_engine := nil; {introduced 1.1.0}
  DH_get_length := nil; {introduced 1.1.0}
  DH_set_length := nil; {introduced 1.1.0}
  DH_meth_new := nil; {introduced 1.1.0}
  DH_meth_free := nil; {introduced 1.1.0}
  DH_meth_dup := nil; {introduced 1.1.0}
  DH_meth_get0_name := nil; {introduced 1.1.0}
  DH_meth_set1_name := nil; {introduced 1.1.0}
  DH_meth_get_flags := nil; {introduced 1.1.0}
  DH_meth_set_flags := nil; {introduced 1.1.0}
  DH_meth_get0_app_data := nil; {introduced 1.1.0}
  DH_meth_set0_app_data := nil; {introduced 1.1.0}
  DH_meth_get_generate_key := nil; {introduced 1.1.0}
  DH_meth_set_generate_key := nil; {introduced 1.1.0}
  DH_meth_get_compute_key := nil; {introduced 1.1.0}
  DH_meth_set_compute_key := nil; {introduced 1.1.0}
  DH_meth_get_bn_mod_exp := nil; {introduced 1.1.0}
  DH_meth_set_bn_mod_exp := nil; {introduced 1.1.0}
  DH_meth_get_init := nil; {introduced 1.1.0}
  DH_meth_set_init := nil; {introduced 1.1.0}
  DH_meth_get_finish := nil; {introduced 1.1.0}
  DH_meth_set_finish := nil; {introduced 1.1.0}
  DH_meth_get_generate_params := nil; {introduced 1.1.0}
  DH_meth_set_generate_params := nil; {introduced 1.1.0}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
