  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_ec.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_ec.h2pas
     and this file regenerated. IdOpenSSLHeaders_ec.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_ec;

interface

// Headers for OpenSSL 1.1.1
// ec.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_evp;

const
  OPENSSL_EC_EXPLICIT_CURVE = $000;
  OPENSSL_EC_NAMED_CURVE    = $001;
  EC_PKEY_NO_PARAMETERS = $001;
  EC_PKEY_NO_PUBKEY     = $002;
  EC_FLAG_NON_FIPS_ALLOW = $1;
  EC_FLAG_FIPS_CHECKED   = $2;
  EC_FLAG_COFACTOR_ECDH  = $1000;
  EVP_PKEY_CTRL_EC_PARAMGEN_CURVE_NID = (EVP_PKEY_ALG_CTRL + 1);
  EVP_PKEY_CTRL_EC_PARAM_ENC          = (EVP_PKEY_ALG_CTRL + 2);
  EVP_PKEY_CTRL_EC_ECDH_COFACTOR      = (EVP_PKEY_ALG_CTRL + 3);
  EVP_PKEY_CTRL_EC_KDF_TYPE           = (EVP_PKEY_ALG_CTRL + 4);
  EVP_PKEY_CTRL_EC_KDF_MD             = (EVP_PKEY_ALG_CTRL + 5);
  EVP_PKEY_CTRL_GET_EC_KDF_MD         = (EVP_PKEY_ALG_CTRL + 6);
  EVP_PKEY_CTRL_EC_KDF_OUTLEN         = (EVP_PKEY_ALG_CTRL + 7);
  EVP_PKEY_CTRL_GET_EC_KDF_OUTLEN     = (EVP_PKEY_ALG_CTRL + 8);
  EVP_PKEY_CTRL_EC_KDF_UKM            = (EVP_PKEY_ALG_CTRL + 9);
  EVP_PKEY_CTRL_GET_EC_KDF_UKM        = (EVP_PKEY_ALG_CTRL + 10);
  EVP_PKEY_CTRL_SET1_ID               = (EVP_PKEY_ALG_CTRL + 11);
  EVP_PKEY_CTRL_GET1_ID               = (EVP_PKEY_ALG_CTRL + 12);
  EVP_PKEY_CTRL_GET1_ID_LEN           = (EVP_PKEY_ALG_CTRL + 13);
  EVP_PKEY_ECDH_KDF_NONE              = 1;
  EVP_PKEY_ECDH_KDF_X9_63             = 2;
  EVP_PKEY_ECDH_KDF_X9_62             = EVP_PKEY_ECDH_KDF_X9_63;

type
  {$MINENUMSIZE 4}
  point_conversion_form_t = (
    POINT_CONVERSION_COMPRESSED = 2,
    POINT_CONVERSION_UNCOMPRESSED = 4,
    POINT_CONVERSION_HYBRID = 6
  );

  EC_METHOD = type Pointer; // ec_method_st
  PEC_METHOD = ^EC_METHOD;

  EC_GROUP = type Pointer; // ec_group_st
  PEC_GROUP = ^EC_GROUP;
  PPEC_GROUP = ^PEC_GROUP;

  EC_POINT = type Pointer; // ec_point_st
  PEC_POINT = ^EC_POINT;
  PPEC_POINT = ^PEC_POINT;

  ECPKPARAMETERS = type Pointer; // ecpk_parameters_st
  PECPKPARAMETERS = ^ECPKPARAMETERS;

  ECPARAMETERS = type Pointer; // ec_parameters_st
  PECPARAMETERS = ^ECPARAMETERS;

  EC_builtin_curve = record
    nid: TIdC_INT;
    comment: PIdAnsiChar;
  end;
  PEC_builtin_curve = ^EC_builtin_curve;

  ECDSA_SIG = type Pointer; // ECDSA_SIG_st
  PECDSA_SIG = ^ECDSA_SIG;
  PPECDSA_SIG = ^PECDSA_SIG;

  ECDH_compute_key_KDF = function(const in_: Pointer; inlen: TIdC_SIZET; out_: Pointer; outlen: PIdC_SIZET): Pointer; cdecl;

  EC_KEY_METHOD_init_init = function(key: PEC_KEY): TIdC_INT; cdecl;
  EC_KEY_METHOD_init_finish = procedure(key: PEC_KEY); cdecl;
  EC_KEY_METHOD_init_copy = function(dest: PEC_KEY; const src: PEC_KEY): TIdC_INT; cdecl;
  EC_KEY_METHOD_init_set_group = function(key: PEC_KEY; const grp: PEC_GROUP): TIdC_INT; cdecl;
  EC_KEY_METHOD_init_set_private = function(key: PEC_KEY; const priv_key: PBIGNUM): TIdC_INT; cdecl;
  EC_KEY_METHOD_init_set_public = function(key: PEC_KEY; const pub_key: PEC_POINT): TIdC_INT; cdecl;

  EC_KEY_METHOD_keygen_keygen = function(key: PEC_KEY): TIdC_INT; cdecl;

  EC_KEY_METHOD_compute_key_ckey = function(psec: PPByte; pseclen: PIdC_SIZET; const pub_key: PEC_POINT; const ecdh: PEC_KEY): TIdC_INT; cdecl;

  EC_KEY_METHOD_sign_sign = function(type_: TIdC_INT; const dgst: PByte; dlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const r: PBIGNUM; eckey: PEC_KEY): TIdC_INT; cdecl;
  EC_KEY_METHOD_sign_sign_setup = function(eckey: PEC_KEY; ctx_in: PBN_CTX; kinvp: PPBIGNUM; rp: PPBIGNUM): TIdC_INT; cdecl;
  EC_KEY_METHOD_sign_sign_sig = function(const dgst: PByte; dgst_len: TIdC_INT; const in_kinv: PBIGNUM; const in_r: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG; cdecl;

  EC_KEY_METHOD_verify_verify = function(type_: TIdC_INT; const dgst: PByte; dgst_len: TIdC_INT; const sigbuf: PByte; sig_len: TIdC_INT; eckey: PEC_KEY): TIdC_INT; cdecl;
  EC_KEY_METHOD_verify_verify_sig = function(const dgst: PByte; dgst_len: TIdC_INT; const sig: PECDSA_SIG; eckey: PEC_KEY): TIdC_INT; cdecl;

  PEC_KEY_METHOD_init_init = ^EC_KEY_METHOD_init_init;
  PEC_KEY_METHOD_init_finish = ^EC_KEY_METHOD_init_finish;
  PEC_KEY_METHOD_init_copy = ^EC_KEY_METHOD_init_copy;
  PEC_KEY_METHOD_init_set_group = ^EC_KEY_METHOD_init_set_group;
  PEC_KEY_METHOD_init_set_private = ^EC_KEY_METHOD_init_set_private;
  PEC_KEY_METHOD_init_set_public = ^EC_KEY_METHOD_init_set_public;

  PEC_KEY_METHOD_keygen_keygen = ^EC_KEY_METHOD_keygen_keygen;

  PEC_KEY_METHOD_compute_key_ckey = ^EC_KEY_METHOD_compute_key_ckey;

  PEC_KEY_METHOD_sign_sign = ^EC_KEY_METHOD_sign_sign;
  PEC_KEY_METHOD_sign_sign_setup = ^EC_KEY_METHOD_sign_sign_setup;
  PEC_KEY_METHOD_sign_sign_sig = ^EC_KEY_METHOD_sign_sign_sig;

  PEC_KEY_METHOD_verify_verify = ^EC_KEY_METHOD_verify_verify;
  PEC_KEY_METHOD_verify_verify_sig = ^EC_KEY_METHOD_verify_verify_sig;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM EC_GFp_simple_method}
  {$EXTERNALSYM EC_GFp_mont_method}
  {$EXTERNALSYM EC_GFp_nist_method}
  {$EXTERNALSYM EC_GF2m_simple_method}
  {$EXTERNALSYM EC_GROUP_new}
  {$EXTERNALSYM EC_GROUP_free}
  {$EXTERNALSYM EC_GROUP_clear_free}
  {$EXTERNALSYM EC_GROUP_copy}
  {$EXTERNALSYM EC_GROUP_dup}
  {$EXTERNALSYM EC_GROUP_method_of}
  {$EXTERNALSYM EC_METHOD_get_field_type}
  {$EXTERNALSYM EC_GROUP_set_generator}
  {$EXTERNALSYM EC_GROUP_get0_generator}
  {$EXTERNALSYM EC_GROUP_get_mont_data}
  {$EXTERNALSYM EC_GROUP_get_order}
  {$EXTERNALSYM EC_GROUP_get0_order} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_order_bits} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_get_cofactor}
  {$EXTERNALSYM EC_GROUP_get0_cofactor} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_set_curve_name}
  {$EXTERNALSYM EC_GROUP_get_curve_name}
  {$EXTERNALSYM EC_GROUP_set_asn1_flag}
  {$EXTERNALSYM EC_GROUP_get_asn1_flag}
  {$EXTERNALSYM EC_GROUP_set_point_conversion_form}
  {$EXTERNALSYM EC_GROUP_get_point_conversion_form}
  {$EXTERNALSYM EC_GROUP_get0_seed}
  {$EXTERNALSYM EC_GROUP_get_seed_len}
  {$EXTERNALSYM EC_GROUP_set_seed}
  {$EXTERNALSYM EC_GROUP_set_curve} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_get_curve} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_set_curve_GFp}
  {$EXTERNALSYM EC_GROUP_get_curve_GFp}
  {$EXTERNALSYM EC_GROUP_set_curve_GF2m}
  {$EXTERNALSYM EC_GROUP_get_curve_GF2m}
  {$EXTERNALSYM EC_GROUP_get_degree}
  {$EXTERNALSYM EC_GROUP_check}
  {$EXTERNALSYM EC_GROUP_check_discriminant}
  {$EXTERNALSYM EC_GROUP_cmp}
  {$EXTERNALSYM EC_GROUP_new_curve_GFp}
  {$EXTERNALSYM EC_GROUP_new_curve_GF2m}
  {$EXTERNALSYM EC_GROUP_new_by_curve_name}
  {$EXTERNALSYM EC_GROUP_new_from_ecparameters} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_get_ecparameters} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_new_from_ecpkparameters} {introduced 1.1.0}
  {$EXTERNALSYM EC_GROUP_get_ecpkparameters} {introduced 1.1.0}
  {$EXTERNALSYM EC_get_builtin_curves}
  {$EXTERNALSYM EC_curve_nid2nist}
  {$EXTERNALSYM EC_curve_nist2nid}
  {$EXTERNALSYM EC_POINT_new}
  {$EXTERNALSYM EC_POINT_free}
  {$EXTERNALSYM EC_POINT_clear_free}
  {$EXTERNALSYM EC_POINT_copy}
  {$EXTERNALSYM EC_POINT_dup}
  {$EXTERNALSYM EC_POINT_method_of}
  {$EXTERNALSYM EC_POINT_set_to_infinity}
  {$EXTERNALSYM EC_POINT_set_Jprojective_coordinates_GFp}
  {$EXTERNALSYM EC_POINT_get_Jprojective_coordinates_GFp}
  {$EXTERNALSYM EC_POINT_set_affine_coordinates} {introduced 1.1.0}
  {$EXTERNALSYM EC_POINT_get_affine_coordinates} {introduced 1.1.0}
  {$EXTERNALSYM EC_POINT_set_affine_coordinates_GFp}
  {$EXTERNALSYM EC_POINT_get_affine_coordinates_GFp}
  {$EXTERNALSYM EC_POINT_set_compressed_coordinates} {introduced 1.1.0}
  {$EXTERNALSYM EC_POINT_set_compressed_coordinates_GFp}
  {$EXTERNALSYM EC_POINT_set_affine_coordinates_GF2m}
  {$EXTERNALSYM EC_POINT_get_affine_coordinates_GF2m}
  {$EXTERNALSYM EC_POINT_set_compressed_coordinates_GF2m}
  {$EXTERNALSYM EC_POINT_point2oct}
  {$EXTERNALSYM EC_POINT_oct2point}
  {$EXTERNALSYM EC_POINT_point2buf} {introduced 1.1.0}
  {$EXTERNALSYM EC_POINT_point2bn}
  {$EXTERNALSYM EC_POINT_bn2point}
  {$EXTERNALSYM EC_POINT_point2hex}
  {$EXTERNALSYM EC_POINT_hex2point}
  {$EXTERNALSYM EC_POINT_add}
  {$EXTERNALSYM EC_POINT_dbl}
  {$EXTERNALSYM EC_POINT_invert}
  {$EXTERNALSYM EC_POINT_is_at_infinity}
  {$EXTERNALSYM EC_POINT_is_on_curve}
  {$EXTERNALSYM EC_POINT_cmp}
  {$EXTERNALSYM EC_POINT_make_affine}
  {$EXTERNALSYM EC_POINTs_make_affine}
  {$EXTERNALSYM EC_POINTs_mul}
  {$EXTERNALSYM EC_POINT_mul}
  {$EXTERNALSYM EC_GROUP_precompute_mult}
  {$EXTERNALSYM EC_GROUP_have_precompute_mult}
  {$EXTERNALSYM ECPKPARAMETERS_it}
  {$EXTERNALSYM ECPKPARAMETERS_new}
  {$EXTERNALSYM ECPKPARAMETERS_free}
  {$EXTERNALSYM ECPARAMETERS_it}
  {$EXTERNALSYM ECPARAMETERS_new}
  {$EXTERNALSYM ECPARAMETERS_free}
  {$EXTERNALSYM EC_GROUP_get_basis_type}
  {$EXTERNALSYM EC_GROUP_get_trinomial_basis}
  {$EXTERNALSYM EC_GROUP_get_pentanomial_basis}
  {$EXTERNALSYM d2i_ECPKParameters}
  {$EXTERNALSYM i2d_ECPKParameters}
  {$EXTERNALSYM ECPKParameters_print}
  {$EXTERNALSYM EC_KEY_new}
  {$EXTERNALSYM EC_KEY_get_flags}
  {$EXTERNALSYM EC_KEY_set_flags}
  {$EXTERNALSYM EC_KEY_clear_flags}
  {$EXTERNALSYM EC_KEY_new_by_curve_name}
  {$EXTERNALSYM EC_KEY_free}
  {$EXTERNALSYM EC_KEY_copy}
  {$EXTERNALSYM EC_KEY_dup}
  {$EXTERNALSYM EC_KEY_up_ref}
  {$EXTERNALSYM EC_KEY_get0_engine} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_get0_group}
  {$EXTERNALSYM EC_KEY_set_group}
  {$EXTERNALSYM EC_KEY_get0_private_key}
  {$EXTERNALSYM EC_KEY_set_private_key}
  {$EXTERNALSYM EC_KEY_get0_public_key}
  {$EXTERNALSYM EC_KEY_set_public_key}
  {$EXTERNALSYM EC_KEY_get_enc_flags}
  {$EXTERNALSYM EC_KEY_set_enc_flags}
  {$EXTERNALSYM EC_KEY_get_conv_form}
  {$EXTERNALSYM EC_KEY_set_conv_form}
  {$EXTERNALSYM EC_KEY_set_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_get_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_set_asn1_flag}
  {$EXTERNALSYM EC_KEY_precompute_mult}
  {$EXTERNALSYM EC_KEY_generate_key}
  {$EXTERNALSYM EC_KEY_check_key}
  {$EXTERNALSYM EC_KEY_can_sign} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_set_public_key_affine_coordinates}
  {$EXTERNALSYM EC_KEY_key2buf} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_oct2key} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_oct2priv} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_priv2oct} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_priv2buf} {introduced 1.1.0}
  {$EXTERNALSYM d2i_ECPrivateKey}
  {$EXTERNALSYM i2d_ECPrivateKey}
  {$EXTERNALSYM o2i_ECPublicKey}
  {$EXTERNALSYM i2o_ECPublicKey}
  {$EXTERNALSYM ECParameters_print}
  {$EXTERNALSYM EC_KEY_print}
  {$EXTERNALSYM EC_KEY_OpenSSL} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_get_default_method} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_set_default_method} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_get_method} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_set_method} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_new_method} {introduced 1.1.0}
  {$EXTERNALSYM ECDH_KDF_X9_62}
  {$EXTERNALSYM ECDH_compute_key}
  {$EXTERNALSYM ECDSA_SIG_new}
  {$EXTERNALSYM ECDSA_SIG_free}
  {$EXTERNALSYM i2d_ECDSA_SIG}
  {$EXTERNALSYM d2i_ECDSA_SIG}
  {$EXTERNALSYM ECDSA_SIG_get0} {introduced 1.1.0}
  {$EXTERNALSYM ECDSA_SIG_get0_r} {introduced 1.1.0}
  {$EXTERNALSYM ECDSA_SIG_get0_s} {introduced 1.1.0}
  {$EXTERNALSYM ECDSA_SIG_set0} {introduced 1.1.0}
  {$EXTERNALSYM ECDSA_do_sign}
  {$EXTERNALSYM ECDSA_do_sign_ex}
  {$EXTERNALSYM ECDSA_do_verify}
  {$EXTERNALSYM ECDSA_sign_setup}
  {$EXTERNALSYM ECDSA_sign}
  {$EXTERNALSYM ECDSA_sign_ex}
  {$EXTERNALSYM ECDSA_verify}
  {$EXTERNALSYM ECDSA_size}
  {$EXTERNALSYM EC_KEY_METHOD_new} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_free} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_set_init} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_set_keygen} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_set_compute_key} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_set_sign} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_set_verify} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_get_init} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_get_keygen} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_get_compute_key} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_get_sign} {introduced 1.1.0}
  {$EXTERNALSYM EC_KEY_METHOD_get_verify} {introduced 1.1.0}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM EC_GFp_nistp224_method} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EC_GFp_nistp256_method} {introduced 1.1.0 removed 3.0.0}
  {$EXTERNALSYM EC_GFp_nistp521_method} {introduced 1.1.0 removed 3.0.0}
  EC_GFp_simple_method: function: PEC_METHOD; cdecl = nil;
  EC_GFp_mont_method: function: PEC_METHOD; cdecl = nil;
  EC_GFp_nist_method: function: PEC_METHOD; cdecl = nil;
  EC_GFp_nistp224_method: function: PEC_METHOD; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp256_method: function: PEC_METHOD; cdecl = nil; {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp521_method: function: PEC_METHOD; cdecl = nil; {introduced 1.1.0 removed 3.0.0}

  EC_GF2m_simple_method: function: PEC_METHOD; cdecl = nil;

  EC_GROUP_new: function(const meth: PEC_METHOD): PEC_GROUP; cdecl = nil;
  EC_GROUP_free: procedure(group: PEC_GROUP); cdecl = nil;
  EC_GROUP_clear_free: procedure(group: PEC_GROUP); cdecl = nil;
  EC_GROUP_copy: function(dst: PEC_GROUP; const src: PEC_GROUP): TIdC_INT; cdecl = nil;
  EC_GROUP_dup: function(const src: PEC_GROUP): PEC_GROUP; cdecl = nil;
  EC_GROUP_method_of: function(const group: PEC_GROUP): PEC_GROUP; cdecl = nil;
  EC_METHOD_get_field_type: function(const meth: PEC_METHOD): TIdC_INT; cdecl = nil;
  EC_GROUP_set_generator: function(group: PEC_GROUP; const generator: PEC_POINT; const order: PBIGNUM; const cofactor: PBIGNUM): TIdC_INT; cdecl = nil;
  EC_GROUP_get0_generator: function(const group: PEC_GROUP): PEC_POINT; cdecl = nil;
  EC_GROUP_get_mont_data: function(const group: PEC_GROUP): PBN_MONT_CTX; cdecl = nil;
  EC_GROUP_get_order: function(const group: PEC_GROUP; order: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_get0_order: function(const group: PEC_GROUP): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_order_bits: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_get_cofactor: function(const group: PEC_GROUP; cofactor: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_get0_cofactor: function(const group: PEC_GROUP): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_set_curve_name: procedure(group: PEC_GROUP; nid: TIdC_INT); cdecl = nil;
  EC_GROUP_get_curve_name: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil;

  EC_GROUP_set_asn1_flag: procedure(group: PEC_GROUP; flag: TIdC_INT); cdecl = nil;
  EC_GROUP_get_asn1_flag: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil;

  EC_GROUP_set_point_conversion_form: procedure(group: PEC_GROUP; form: point_conversion_form_t); cdecl = nil;
  EC_GROUP_get_point_conversion_form: function(const group: PEC_GROUP): point_conversion_form_t; cdecl = nil;

  EC_GROUP_get0_seed: function(const x: PEC_GROUP): PByte; cdecl = nil;
  EC_GROUP_get_seed_len: function(const x: PEC_GROUP): TIdC_SIZET; cdecl = nil;
  EC_GROUP_set_seed: function(x: PEC_GROUP; const p: PByte; len: TIdC_SIZET): TIdC_SIZET; cdecl = nil;

  EC_GROUP_set_curve: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_get_curve: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_set_curve_GFp: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_get_curve_GFp: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_set_curve_GF2m: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b:PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_get_curve_GF2m: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;

  EC_GROUP_get_degree: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil;
  EC_GROUP_check: function(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_check_discriminant: function(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_cmp: function(const a: PEC_GROUP; const b: PEC_GROUP; ctx: PBN_CTX): TIdC_INT; cdecl = nil;

  EC_GROUP_new_curve_GFp: function(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP; cdecl = nil;
  EC_GROUP_new_curve_GF2m: function(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP; cdecl = nil;
  EC_GROUP_new_by_curve_name: function(nid: TIdC_INT): PEC_GROUP; cdecl = nil;
  EC_GROUP_new_from_ecparameters: function(const params: PECPARAMETERS): PEC_GROUP; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_get_ecparameters: function(const group: PEC_GROUP; params: PECPARAMETERS): PECPARAMETERS; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_new_from_ecpkparameters: function(const params: PECPKPARAMETERS): PEC_GROUP; cdecl = nil; {introduced 1.1.0}
  EC_GROUP_get_ecpkparameters: function(const group: PEC_GROUP; params: PECPKPARAMETERS): PECPKPARAMETERS; cdecl = nil; {introduced 1.1.0}

  EC_get_builtin_curves: function(r: PEC_builtin_curve; nitems: TIdC_SIZET): TIdC_SIZET; cdecl = nil;

  EC_curve_nid2nist: function(nid: TIdC_INT): PIdAnsiChar; cdecl = nil;
  EC_curve_nist2nid: function(const name: PIdAnsiChar): TIdC_INT; cdecl = nil;

  EC_POINT_new: function(const group: PEC_GROUP): PEC_POINT; cdecl = nil;
  EC_POINT_free: procedure(point: PEC_POINT); cdecl = nil;
  EC_POINT_clear_free: procedure(point: PEC_POINT); cdecl = nil;
  EC_POINT_copy: function(dst: PEC_POINT; const src: PEC_POINT): TIdC_INT; cdecl = nil;
  EC_POINT_dup: function(const src: PEC_POINT; const group: PEC_GROUP): PEC_POINT; cdecl = nil;
  EC_POINT_method_of: function(const point: PEC_POINT): PEC_METHOD; cdecl = nil;
  EC_POINT_set_to_infinity: function(const group: PEC_GROUP; point: PEC_POINT): TIdC_INT; cdecl = nil;
  EC_POINT_set_Jprojective_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; const z: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_get_Jprojective_coordinates_GFp: function(const group: PEC_METHOD; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; z: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_set_affine_coordinates: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_POINT_get_affine_coordinates: function(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_POINT_set_affine_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_get_affine_coordinates_GFp: function(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_set_compressed_coordinates: function(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_POINT_set_compressed_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_set_affine_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_get_affine_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_set_compressed_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;

  EC_POINT_point2oct: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_SIZET; cdecl = nil;
  EC_POINT_oct2point: function(const group: PEC_GROUP; p: PEC_POINT; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_point2buf: function(const group: PEC_GROUP; const point: PEC_POINT; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  EC_POINT_point2bn: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; bn: PBIGNUM; ctx: PBN_CTX): PBIGNUM; cdecl = nil;
  EC_POINT_bn2point: function(const group: PEC_GROUP; const bn: PBIGNUM; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT; cdecl = nil;
  EC_POINT_point2hex: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; ctx: PBN_CTX): PIdAnsiChar; cdecl = nil;
  EC_POINT_hex2point: function(const group: PEC_GROUP; const buf: PIdAnsiChar; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT; cdecl = nil;

  EC_POINT_add: function(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_dbl: function(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_invert: function(const group: PEC_GROUP; a: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_is_at_infinity: function(const group: PEC_GROUP; const p: PEC_POINT): TIdC_INT; cdecl = nil;
  EC_POINT_is_on_curve: function(const group: PEC_GROUP; const point: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_cmp: function(const group: PEC_GROUP; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_make_affine: function(const group: PEC_GROUP; point: PEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINTs_make_affine: function(const group: PEC_METHOD; num: TIdC_SIZET; points: PPEC_POINT; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINTs_mul: function(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; num: TIdC_SIZET; const p: PPEC_POINT; const m: PPBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_POINT_mul: function(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; const q: PEC_POINT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT; cdecl = nil;

  EC_GROUP_precompute_mult: function(group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_GROUP_have_precompute_mult: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil;

  ECPKPARAMETERS_it: function: PASN1_ITEM; cdecl = nil;
  ECPKPARAMETERS_new: function: PECPKPARAMETERS; cdecl = nil;
  ECPKPARAMETERS_free: procedure(a: PECPKPARAMETERS); cdecl = nil;

  ECPARAMETERS_it: function: PASN1_ITEM; cdecl = nil;
  ECPARAMETERS_new: function: PECPARAMETERS; cdecl = nil;
  ECPARAMETERS_free: procedure(a: PECPARAMETERS); cdecl = nil;

  EC_GROUP_get_basis_type: function(const group: PEC_GROUP): TIdC_INT; cdecl = nil;
  EC_GROUP_get_trinomial_basis: function(const group: PEC_GROUP; k: PIdC_UINT): TIdC_INT; cdecl = nil;
  EC_GROUP_get_pentanomial_basis: function(const group: PEC_GROUP; k1: PIdC_UINT; k2: PIdC_UINT; k3: PIdC_UINT): TIdC_INT; cdecl = nil;

  d2i_ECPKParameters: function(group: PPEC_GROUP; const in_: PPByte; len: TIdC_LONG): PEC_GROUP; cdecl = nil;
  i2d_ECPKParameters: function(const group: PEC_GROUP; out_: PPByte): TIdC_INT; cdecl = nil;

  ECPKParameters_print: function(bp: PBIO; const x: PEC_GROUP; off: TIdC_INT): TIdC_INT; cdecl = nil;

  EC_KEY_new: function: PEC_KEY; cdecl = nil;
  EC_KEY_get_flags: function(const key: PEC_KEY): TIdC_INT; cdecl = nil;
  EC_KEY_set_flags: procedure(key: PEC_KEY; flags: TIdC_INT); cdecl = nil;
  EC_KEY_clear_flags: procedure(key: PEC_KEY; flags: TIdC_INT); cdecl = nil;
  EC_KEY_new_by_curve_name: function(nid: TIdC_INT): PEC_KEY; cdecl = nil;
  EC_KEY_free: procedure(key: PEC_KEY); cdecl = nil;
  EC_KEY_copy: function(dst: PEC_KEY; const src: PEC_KEY): PEC_KEY; cdecl = nil;
  EC_KEY_dup: function(const src: PEC_KEY): PEC_KEY; cdecl = nil;
  EC_KEY_up_ref: function(key: PEC_KEY): TIdC_INT; cdecl = nil;
  EC_KEY_get0_engine: function(const eckey: PEC_KEY): PENGINE; cdecl = nil; {introduced 1.1.0}
  EC_KEY_get0_group: function(const key: PEC_KEY): PEC_GROUP; cdecl = nil;
  EC_KEY_set_group: function(key: PEC_KEY; const group: PEC_GROUP): TIdC_INT; cdecl = nil;
  EC_KEY_get0_private_key: function(const key: PEC_KEY): PBIGNUM; cdecl = nil;
  EC_KEY_set_private_key: function(const key: PEC_KEY; const prv: PBIGNUM): TIdC_INT; cdecl = nil;
  EC_KEY_get0_public_key: function(const key: PEC_KEY): PEC_POINT; cdecl = nil;
  EC_KEY_set_public_key: function(key: PEC_KEY; const pub: PEC_POINT): TIdC_INT; cdecl = nil;
  EC_KEY_get_enc_flags: function(const key: PEC_KEY): TIdC_UINT; cdecl = nil;
  EC_KEY_set_enc_flags: procedure(eckey: PEC_KEY; flags: TIdC_UINT); cdecl = nil;
  EC_KEY_get_conv_form: function(const key: PEC_KEY): point_conversion_form_t; cdecl = nil;
  EC_KEY_set_conv_form: procedure(eckey: PEC_KEY; cform: point_conversion_form_t); cdecl = nil;
  EC_KEY_set_ex_data: function(key: PEC_KEY; idx: TIdC_INT; arg: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_KEY_get_ex_data: function(const key: PEC_KEY; idx: TIdC_INT): Pointer; cdecl = nil; {introduced 1.1.0}
  EC_KEY_set_asn1_flag: procedure(eckey: PEC_KEY; asn1_flag: TIdC_INT); cdecl = nil;
  EC_KEY_precompute_mult: function(key: PEC_KEY; ctx: PBN_CTX): TIdC_INT; cdecl = nil;
  EC_KEY_generate_key: function(key: PEC_KEY): TIdC_INT; cdecl = nil;
  EC_KEY_check_key: function(const key: PEC_KEY): TIdC_INT; cdecl = nil;
  EC_KEY_can_sign: function(const eckey: PEC_KEY): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_KEY_set_public_key_affine_coordinates: function(key: PEC_KEY; x: PBIGNUM; y: PBIGNUM): TIdC_INT; cdecl = nil;
  EC_KEY_key2buf: function(const key: PEC_KEY; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  EC_KEY_oct2key: function(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_KEY_oct2priv: function(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_KEY_priv2oct: function(const key: PEC_KEY; buf: PByte; len: TIdC_SIZET): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  EC_KEY_priv2buf: function(const eckey: PEC_KEY; buf: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}

  d2i_ECPrivateKey: function(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY; cdecl = nil;
  i2d_ECPrivateKey: function(key: PEC_KEY; out_: PPByte): TIdC_INT; cdecl = nil;
  o2i_ECPublicKey: function(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY; cdecl = nil;
  i2o_ECPublicKey: function(const key: PEC_KEY; out_: PPByte): TIdC_INT; cdecl = nil;

  ECParameters_print: function(bp: PBIO; const key: PEC_KEY): TIdC_INT; cdecl = nil;
  EC_KEY_print: function(bp: PBIO; const key: PEC_KEY; off: TIdC_INT): TIdC_INT; cdecl = nil;

  EC_KEY_OpenSSL: function: PEC_KEY_METHOD; cdecl = nil; {introduced 1.1.0}
  EC_KEY_get_default_method: function: PEC_KEY_METHOD; cdecl = nil; {introduced 1.1.0}
  EC_KEY_set_default_method: procedure(const meth: PEC_KEY_METHOD); cdecl = nil; {introduced 1.1.0}
  EC_KEY_get_method: function(const key: PEC_KEY): PEC_KEY_METHOD; cdecl = nil; {introduced 1.1.0}
  EC_KEY_set_method: function(key: PEC_KEY; const meth: PEC_KEY_METHOD): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  EC_KEY_new_method: function(engine: PENGINE): PEC_KEY; cdecl = nil; {introduced 1.1.0}

  ECDH_KDF_X9_62: function(out_: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; const sinfo: PByte; sinfolen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT; cdecl = nil;
  ECDH_compute_key: function(out_: Pointer; oulen: TIdC_SIZET; const pub_key: PEC_POINT; const ecdh: PEC_KEY; kdf: ECDH_compute_key_KDF): TIdC_INT; cdecl = nil;

  ECDSA_SIG_new: function: PECDSA_SIG; cdecl = nil;
  ECDSA_SIG_free: procedure(sig: PECDSA_SIG); cdecl = nil;
  i2d_ECDSA_SIG: function(const sig: PECDSA_SIG; pp: PPByte): TIdC_INT; cdecl = nil;
  d2i_ECDSA_SIG: function(sig: PPECDSA_SIG; const pp: PPByte; len: TIdC_LONG): PECDSA_SIG; cdecl = nil;
  ECDSA_SIG_get0: procedure(const sig: PECDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM); cdecl = nil; {introduced 1.1.0}
  ECDSA_SIG_get0_r: function(const sig: PECDSA_SIG): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  ECDSA_SIG_get0_s: function(const sig: PECDSA_SIG): PBIGNUM; cdecl = nil; {introduced 1.1.0}
  ECDSA_SIG_set0: function(sig: PECDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ECDSA_do_sign: function(const dgst: PByte; dgst_len: TIdC_INT; eckey: PEC_KEY): PECDSA_SIG; cdecl = nil;
  ECDSA_do_sign_ex: function(const dgst: PByte; dgst_len: TIdC_INT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG; cdecl = nil;
  ECDSA_do_verify: function(const dgst: PByte; dgst_len: TIdC_INT; const sig: PECDSA_SIG; eckey: PEC_KEY): TIdC_INT; cdecl = nil;
  ECDSA_sign_setup: function(eckey: PEC_KEY; ctx: PBN_CTX; kiv: PPBIGNUM; rp: PPBIGNUM): TIdC_INT; cdecl = nil;
  ECDSA_sign: function(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; eckey: PEC_KEY): TIdC_INT; cdecl = nil;
  ECDSA_sign_ex: function(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): TIdC_INT; cdecl = nil;
  ECDSA_verify: function(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; const sig: PByte; siglen: TIdC_INT; eckey: PEC_KEY): TIdC_INT; cdecl = nil;
  ECDSA_size: function(const eckey: PEC_KEY): TIdC_INT; cdecl = nil;

  EC_KEY_METHOD_new: function(const meth: PEC_KEY_METHOD): PEC_KEY_METHOD; cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_free: procedure(meth: PEC_KEY_METHOD); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_init: procedure(meth: PEC_KEY_METHOD; init: EC_KEY_METHOD_init_init; finish: EC_KEY_METHOD_init_finish; copy: EC_KEY_METHOD_init_copy; set_group: EC_KEY_METHOD_init_set_group; set_private: EC_KEY_METHOD_init_set_private; set_public: EC_KEY_METHOD_init_set_public); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_keygen: procedure(meth: PEC_KEY_METHOD; keygen: EC_KEY_METHOD_keygen_keygen); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_compute_key: procedure(meth: PEC_KEY_METHOD; ckey: EC_KEY_METHOD_compute_key_ckey); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_sign: procedure(meth: PEC_KEY_METHOD; sign: EC_KEY_METHOD_sign_sign; sign_setup: EC_KEY_METHOD_sign_sign_setup; sign_sig: EC_KEY_METHOD_sign_sign_sig); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_verify: procedure(meth: PEC_KEY_METHOD; verify: EC_KEY_METHOD_verify_verify; verify_sig: EC_KEY_METHOD_verify_verify_sig); cdecl = nil; {introduced 1.1.0}

  EC_KEY_METHOD_get_init: procedure(const meth: PEC_KEY_METHOD; pinit: PEC_KEY_METHOD_init_init; pfinish: PEC_KEY_METHOD_init_finish; pcopy: PEC_KEY_METHOD_init_copy; pset_group: PEC_KEY_METHOD_init_set_group; pset_private: PEC_KEY_METHOD_init_set_private; pset_public: PEC_KEY_METHOD_init_set_public); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_keygen: procedure(const meth: PEC_KEY_METHOD; pkeygen: PEC_KEY_METHOD_keygen_keygen); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_compute_key: procedure(const meth: PEC_KEY_METHOD; pck: PEC_KEY_METHOD_compute_key_ckey); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_sign: procedure(const meth: PEC_KEY_METHOD; psign: PEC_KEY_METHOD_sign_sign; psign_setup: PEC_KEY_METHOD_sign_sign_setup; psign_sig: PEC_KEY_METHOD_sign_sign_sig); cdecl = nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_verify: procedure(const meth: PEC_KEY_METHOD; pverify: PEC_KEY_METHOD_verify_verify; pverify_sig: PEC_KEY_METHOD_verify_verify_sig); cdecl = nil; {introduced 1.1.0}

{$ELSE}
  function EC_GFp_simple_method: PEC_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GFp_mont_method: PEC_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GFp_nist_method: PEC_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GF2m_simple_method: PEC_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_new(const meth: PEC_METHOD): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_GROUP_free(group: PEC_GROUP) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_GROUP_clear_free(group: PEC_GROUP) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_copy(dst: PEC_GROUP; const src: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_dup(const src: PEC_GROUP): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_method_of(const group: PEC_GROUP): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_METHOD_get_field_type(const meth: PEC_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_set_generator(group: PEC_GROUP; const generator: PEC_POINT; const order: PBIGNUM; const cofactor: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get0_generator(const group: PEC_GROUP): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_mont_data(const group: PEC_GROUP): PBN_MONT_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_order(const group: PEC_GROUP; order: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get0_order(const group: PEC_GROUP): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_order_bits(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_get_cofactor(const group: PEC_GROUP; cofactor: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get0_cofactor(const group: PEC_GROUP): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_GROUP_set_curve_name(group: PEC_GROUP; nid: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_curve_name(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EC_GROUP_set_asn1_flag(group: PEC_GROUP; flag: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_asn1_flag(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure EC_GROUP_set_point_conversion_form(group: PEC_GROUP; form: point_conversion_form_t) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_point_conversion_form(const group: PEC_GROUP): point_conversion_form_t cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_get0_seed(const x: PEC_GROUP): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_seed_len(const x: PEC_GROUP): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_set_seed(x: PEC_GROUP; const p: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_set_curve(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_get_curve(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_set_curve_GFp(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_curve_GFp(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_set_curve_GF2m(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b:PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_curve_GF2m(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_get_degree(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_check(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_check_discriminant(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_cmp(const a: PEC_GROUP; const b: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_new_curve_GFp(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_new_curve_GF2m(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_new_by_curve_name(nid: TIdC_INT): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_new_from_ecparameters(const params: PECPARAMETERS): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_get_ecparameters(const group: PEC_GROUP; params: PECPARAMETERS): PECPARAMETERS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_new_from_ecpkparameters(const params: PECPKPARAMETERS): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_GROUP_get_ecpkparameters(const group: PEC_GROUP; params: PECPKPARAMETERS): PECPKPARAMETERS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function EC_get_builtin_curves(r: PEC_builtin_curve; nitems: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_curve_nid2nist(nid: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_curve_nist2nid(const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_POINT_new(const group: PEC_GROUP): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_POINT_free(point: PEC_POINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_POINT_clear_free(point: PEC_POINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_copy(dst: PEC_POINT; const src: PEC_POINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_dup(const src: PEC_POINT; const group: PEC_GROUP): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_method_of(const point: PEC_POINT): PEC_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_to_infinity(const group: PEC_GROUP; point: PEC_POINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_Jprojective_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; const z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_get_Jprojective_coordinates_GFp(const group: PEC_METHOD; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_affine_coordinates(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_POINT_get_affine_coordinates(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_POINT_set_affine_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_get_affine_coordinates_GFp(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_compressed_coordinates(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_POINT_set_compressed_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_affine_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_get_affine_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_set_compressed_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_POINT_point2oct(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_oct2point(const group: PEC_GROUP; p: PEC_POINT; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_point2buf(const group: PEC_GROUP; const point: PEC_POINT; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_POINT_point2bn(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; bn: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_bn2point(const group: PEC_GROUP; const bn: PBIGNUM; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_point2hex(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; ctx: PBN_CTX): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_hex2point(const group: PEC_GROUP; const buf: PIdAnsiChar; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_POINT_add(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_dbl(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_invert(const group: PEC_GROUP; a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_is_at_infinity(const group: PEC_GROUP; const p: PEC_POINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_is_on_curve(const group: PEC_GROUP; const point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_cmp(const group: PEC_GROUP; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_make_affine(const group: PEC_GROUP; point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINTs_make_affine(const group: PEC_METHOD; num: TIdC_SIZET; points: PPEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINTs_mul(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; num: TIdC_SIZET; const p: PPEC_POINT; const m: PPBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_POINT_mul(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; const q: PEC_POINT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_precompute_mult(group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_have_precompute_mult(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ECPKPARAMETERS_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECPKPARAMETERS_new: PECPKPARAMETERS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ECPKPARAMETERS_free(a: PECPKPARAMETERS) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ECPARAMETERS_it: PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECPARAMETERS_new: PECPARAMETERS cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ECPARAMETERS_free(a: PECPARAMETERS) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_GROUP_get_basis_type(const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_trinomial_basis(const group: PEC_GROUP; k: PIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_GROUP_get_pentanomial_basis(const group: PEC_GROUP; k1: PIdC_UINT; k2: PIdC_UINT; k3: PIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function d2i_ECPKParameters(group: PPEC_GROUP; const in_: PPByte; len: TIdC_LONG): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ECPKParameters(const group: PEC_GROUP; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ECPKParameters_print(bp: PBIO; const x: PEC_GROUP; off: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_KEY_new: PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get_flags(const key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_KEY_set_flags(key: PEC_KEY; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_KEY_clear_flags(key: PEC_KEY; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_new_by_curve_name(nid: TIdC_INT): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_KEY_free(key: PEC_KEY) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_copy(dst: PEC_KEY; const src: PEC_KEY): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_dup(const src: PEC_KEY): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_up_ref(key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get0_engine(const eckey: PEC_KEY): PENGINE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_get0_group(const key: PEC_KEY): PEC_GROUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_set_group(key: PEC_KEY; const group: PEC_GROUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get0_private_key(const key: PEC_KEY): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_set_private_key(const key: PEC_KEY; const prv: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get0_public_key(const key: PEC_KEY): PEC_POINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_set_public_key(key: PEC_KEY; const pub: PEC_POINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get_enc_flags(const key: PEC_KEY): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_KEY_set_enc_flags(eckey: PEC_KEY; flags: TIdC_UINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_get_conv_form(const key: PEC_KEY): point_conversion_form_t cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure EC_KEY_set_conv_form(eckey: PEC_KEY; cform: point_conversion_form_t) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_set_ex_data(key: PEC_KEY; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_get_ex_data(const key: PEC_KEY; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_set_asn1_flag(eckey: PEC_KEY; asn1_flag: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_precompute_mult(key: PEC_KEY; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_generate_key(key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_check_key(const key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_can_sign(const eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_set_public_key_affine_coordinates(key: PEC_KEY; x: PBIGNUM; y: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_key2buf(const key: PEC_KEY; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_oct2key(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_oct2priv(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_priv2oct(const key: PEC_KEY; buf: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_priv2buf(const eckey: PEC_KEY; buf: PPByte): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function d2i_ECPrivateKey(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ECPrivateKey(key: PEC_KEY; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function o2i_ECPublicKey(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2o_ECPublicKey(const key: PEC_KEY; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ECParameters_print(bp: PBIO; const key: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function EC_KEY_print(bp: PBIO; const key: PEC_KEY; off: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_KEY_OpenSSL: PEC_KEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_get_default_method: PEC_KEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_set_default_method(const meth: PEC_KEY_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_get_method(const key: PEC_KEY): PEC_KEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_set_method(key: PEC_KEY; const meth: PEC_KEY_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function EC_KEY_new_method(engine: PENGINE): PEC_KEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function ECDH_KDF_X9_62(out_: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; const sinfo: PByte; sinfolen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDH_compute_key(out_: Pointer; oulen: TIdC_SIZET; const pub_key: PEC_POINT; const ecdh: PEC_KEY; kdf: ECDH_compute_key_KDF): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ECDSA_SIG_new: PECDSA_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ECDSA_SIG_free(sig: PECDSA_SIG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ECDSA_SIG(const sig: PECDSA_SIG; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ECDSA_SIG(sig: PPECDSA_SIG; const pp: PPByte; len: TIdC_LONG): PECDSA_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ECDSA_SIG_get0(const sig: PECDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ECDSA_SIG_get0_r(const sig: PECDSA_SIG): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ECDSA_SIG_get0_s(const sig: PECDSA_SIG): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ECDSA_SIG_set0(sig: PECDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ECDSA_do_sign(const dgst: PByte; dgst_len: TIdC_INT; eckey: PEC_KEY): PECDSA_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_do_sign_ex(const dgst: PByte; dgst_len: TIdC_INT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_do_verify(const dgst: PByte; dgst_len: TIdC_INT; const sig: PECDSA_SIG; eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_sign_setup(eckey: PEC_KEY; ctx: PBN_CTX; kiv: PPBIGNUM; rp: PPBIGNUM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_sign(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_sign_ex(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_verify(type_: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; const sig: PByte; siglen: TIdC_INT; eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ECDSA_size(const eckey: PEC_KEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function EC_KEY_METHOD_new(const meth: PEC_KEY_METHOD): PEC_KEY_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_free(meth: PEC_KEY_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_set_init(meth: PEC_KEY_METHOD; init: EC_KEY_METHOD_init_init; finish: EC_KEY_METHOD_init_finish; copy: EC_KEY_METHOD_init_copy; set_group: EC_KEY_METHOD_init_set_group; set_private: EC_KEY_METHOD_init_set_private; set_public: EC_KEY_METHOD_init_set_public) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_set_keygen(meth: PEC_KEY_METHOD; keygen: EC_KEY_METHOD_keygen_keygen) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_set_compute_key(meth: PEC_KEY_METHOD; ckey: EC_KEY_METHOD_compute_key_ckey) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_set_sign(meth: PEC_KEY_METHOD; sign: EC_KEY_METHOD_sign_sign; sign_setup: EC_KEY_METHOD_sign_sign_setup; sign_sig: EC_KEY_METHOD_sign_sign_sig) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_set_verify(meth: PEC_KEY_METHOD; verify: EC_KEY_METHOD_verify_verify; verify_sig: EC_KEY_METHOD_verify_verify_sig) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure EC_KEY_METHOD_get_init(const meth: PEC_KEY_METHOD; pinit: PEC_KEY_METHOD_init_init; pfinish: PEC_KEY_METHOD_init_finish; pcopy: PEC_KEY_METHOD_init_copy; pset_group: PEC_KEY_METHOD_init_set_group; pset_private: PEC_KEY_METHOD_init_set_private; pset_public: PEC_KEY_METHOD_init_set_public) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_get_keygen(const meth: PEC_KEY_METHOD; pkeygen: PEC_KEY_METHOD_keygen_keygen) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_get_compute_key(const meth: PEC_KEY_METHOD; pck: PEC_KEY_METHOD_compute_key_ckey) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_get_sign(const meth: PEC_KEY_METHOD; psign: PEC_KEY_METHOD_sign_sign; psign_setup: PEC_KEY_METHOD_sign_sign_setup; psign_sig: PEC_KEY_METHOD_sign_sign_sig) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure EC_KEY_METHOD_get_verify(const meth: PEC_KEY_METHOD; pverify: PEC_KEY_METHOD_verify_verify; pverify_sig: PEC_KEY_METHOD_verify_verify_sig) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  
const
  EC_GFp_nistp224_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GFp_nistp256_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GFp_nistp521_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_get0_order_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_order_bits_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_get0_cofactor_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_set_curve_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_get_curve_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_new_from_ecparameters_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_get_ecparameters_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_new_from_ecpkparameters_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GROUP_get_ecpkparameters_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_POINT_set_affine_coordinates_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_POINT_get_affine_coordinates_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_POINT_set_compressed_coordinates_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_POINT_point2buf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_get0_engine_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_set_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_get_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_can_sign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_key2buf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_oct2key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_oct2priv_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_priv2oct_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_priv2buf_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_OpenSSL_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_get_default_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_set_default_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_get_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_set_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_new_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ECDSA_SIG_get0_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ECDSA_SIG_get0_r_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ECDSA_SIG_get0_s_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ECDSA_SIG_set0_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_set_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_set_keygen_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_set_compute_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_set_sign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_set_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_get_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_get_keygen_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_get_compute_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_get_sign_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_KEY_METHOD_get_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  EC_GFp_nistp224_method_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EC_GFp_nistp256_method_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  EC_GFp_nistp521_method_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
function ERR_EC_GFp_nistp224_method: PEC_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GFp_nistp224_method');
end;


function ERR_EC_GFp_nistp256_method: PEC_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GFp_nistp256_method');
end;


function ERR_EC_GFp_nistp521_method: PEC_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GFp_nistp521_method');
end;


function ERR_EC_GROUP_get0_order(const group: PEC_GROUP): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_get0_order');
end;


function ERR_EC_GROUP_order_bits(const group: PEC_GROUP): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_order_bits');
end;


function ERR_EC_GROUP_get0_cofactor(const group: PEC_GROUP): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_get0_cofactor');
end;


function ERR_EC_GROUP_set_curve(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_set_curve');
end;


function ERR_EC_GROUP_get_curve(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_get_curve');
end;


function ERR_EC_GROUP_new_from_ecparameters(const params: PECPARAMETERS): PEC_GROUP; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_new_from_ecparameters');
end;


function ERR_EC_GROUP_get_ecparameters(const group: PEC_GROUP; params: PECPARAMETERS): PECPARAMETERS; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_get_ecparameters');
end;


function ERR_EC_GROUP_new_from_ecpkparameters(const params: PECPKPARAMETERS): PEC_GROUP; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_new_from_ecpkparameters');
end;


function ERR_EC_GROUP_get_ecpkparameters(const group: PEC_GROUP; params: PECPKPARAMETERS): PECPKPARAMETERS; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_GROUP_get_ecpkparameters');
end;


function ERR_EC_POINT_set_affine_coordinates(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_POINT_set_affine_coordinates');
end;


function ERR_EC_POINT_get_affine_coordinates(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_POINT_get_affine_coordinates');
end;


function ERR_EC_POINT_set_compressed_coordinates(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_POINT_set_compressed_coordinates');
end;


function ERR_EC_POINT_point2buf(const group: PEC_GROUP; const point: PEC_POINT; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_POINT_point2buf');
end;


function ERR_EC_KEY_get0_engine(const eckey: PEC_KEY): PENGINE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_get0_engine');
end;


function ERR_EC_KEY_set_ex_data(key: PEC_KEY; idx: TIdC_INT; arg: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_set_ex_data');
end;


function ERR_EC_KEY_get_ex_data(const key: PEC_KEY; idx: TIdC_INT): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_get_ex_data');
end;


function ERR_EC_KEY_can_sign(const eckey: PEC_KEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_can_sign');
end;


function ERR_EC_KEY_key2buf(const key: PEC_KEY; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_key2buf');
end;


function ERR_EC_KEY_oct2key(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_oct2key');
end;


function ERR_EC_KEY_oct2priv(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_oct2priv');
end;


function ERR_EC_KEY_priv2oct(const key: PEC_KEY; buf: PByte; len: TIdC_SIZET): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_priv2oct');
end;


function ERR_EC_KEY_priv2buf(const eckey: PEC_KEY; buf: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_priv2buf');
end;


function ERR_EC_KEY_OpenSSL: PEC_KEY_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_OpenSSL');
end;


function ERR_EC_KEY_get_default_method: PEC_KEY_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_get_default_method');
end;


procedure ERR_EC_KEY_set_default_method(const meth: PEC_KEY_METHOD); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_set_default_method');
end;


function ERR_EC_KEY_get_method(const key: PEC_KEY): PEC_KEY_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_get_method');
end;


function ERR_EC_KEY_set_method(key: PEC_KEY; const meth: PEC_KEY_METHOD): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_set_method');
end;


function ERR_EC_KEY_new_method(engine: PENGINE): PEC_KEY; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_new_method');
end;


procedure ERR_ECDSA_SIG_get0(const sig: PECDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ECDSA_SIG_get0');
end;


function ERR_ECDSA_SIG_get0_r(const sig: PECDSA_SIG): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ECDSA_SIG_get0_r');
end;


function ERR_ECDSA_SIG_get0_s(const sig: PECDSA_SIG): PBIGNUM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ECDSA_SIG_get0_s');
end;


function ERR_ECDSA_SIG_set0(sig: PECDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ECDSA_SIG_set0');
end;


function ERR_EC_KEY_METHOD_new(const meth: PEC_KEY_METHOD): PEC_KEY_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_new');
end;


procedure ERR_EC_KEY_METHOD_free(meth: PEC_KEY_METHOD); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_free');
end;


procedure ERR_EC_KEY_METHOD_set_init(meth: PEC_KEY_METHOD; init: EC_KEY_METHOD_init_init; finish: EC_KEY_METHOD_init_finish; copy: EC_KEY_METHOD_init_copy; set_group: EC_KEY_METHOD_init_set_group; set_private: EC_KEY_METHOD_init_set_private; set_public: EC_KEY_METHOD_init_set_public); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_set_init');
end;


procedure ERR_EC_KEY_METHOD_set_keygen(meth: PEC_KEY_METHOD; keygen: EC_KEY_METHOD_keygen_keygen); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_set_keygen');
end;


procedure ERR_EC_KEY_METHOD_set_compute_key(meth: PEC_KEY_METHOD; ckey: EC_KEY_METHOD_compute_key_ckey); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_set_compute_key');
end;


procedure ERR_EC_KEY_METHOD_set_sign(meth: PEC_KEY_METHOD; sign: EC_KEY_METHOD_sign_sign; sign_setup: EC_KEY_METHOD_sign_sign_setup; sign_sig: EC_KEY_METHOD_sign_sign_sig); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_set_sign');
end;


procedure ERR_EC_KEY_METHOD_set_verify(meth: PEC_KEY_METHOD; verify: EC_KEY_METHOD_verify_verify; verify_sig: EC_KEY_METHOD_verify_verify_sig); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_set_verify');
end;


procedure ERR_EC_KEY_METHOD_get_init(const meth: PEC_KEY_METHOD; pinit: PEC_KEY_METHOD_init_init; pfinish: PEC_KEY_METHOD_init_finish; pcopy: PEC_KEY_METHOD_init_copy; pset_group: PEC_KEY_METHOD_init_set_group; pset_private: PEC_KEY_METHOD_init_set_private; pset_public: PEC_KEY_METHOD_init_set_public); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_get_init');
end;


procedure ERR_EC_KEY_METHOD_get_keygen(const meth: PEC_KEY_METHOD; pkeygen: PEC_KEY_METHOD_keygen_keygen); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_get_keygen');
end;


procedure ERR_EC_KEY_METHOD_get_compute_key(const meth: PEC_KEY_METHOD; pck: PEC_KEY_METHOD_compute_key_ckey); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_get_compute_key');
end;


procedure ERR_EC_KEY_METHOD_get_sign(const meth: PEC_KEY_METHOD; psign: PEC_KEY_METHOD_sign_sign; psign_setup: PEC_KEY_METHOD_sign_sign_setup; psign_sig: PEC_KEY_METHOD_sign_sign_sig); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_get_sign');
end;


procedure ERR_EC_KEY_METHOD_get_verify(const meth: PEC_KEY_METHOD; pverify: PEC_KEY_METHOD_verify_verify; pverify_sig: PEC_KEY_METHOD_verify_verify_sig); 
begin
  EIdAPIFunctionNotPresent.RaiseException('EC_KEY_METHOD_get_verify');
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
  EC_GFp_simple_method := LoadFunction('EC_GFp_simple_method',AFailed);
  EC_GFp_mont_method := LoadFunction('EC_GFp_mont_method',AFailed);
  EC_GFp_nist_method := LoadFunction('EC_GFp_nist_method',AFailed);
  EC_GF2m_simple_method := LoadFunction('EC_GF2m_simple_method',AFailed);
  EC_GROUP_new := LoadFunction('EC_GROUP_new',AFailed);
  EC_GROUP_free := LoadFunction('EC_GROUP_free',AFailed);
  EC_GROUP_clear_free := LoadFunction('EC_GROUP_clear_free',AFailed);
  EC_GROUP_copy := LoadFunction('EC_GROUP_copy',AFailed);
  EC_GROUP_dup := LoadFunction('EC_GROUP_dup',AFailed);
  EC_GROUP_method_of := LoadFunction('EC_GROUP_method_of',AFailed);
  EC_METHOD_get_field_type := LoadFunction('EC_METHOD_get_field_type',AFailed);
  EC_GROUP_set_generator := LoadFunction('EC_GROUP_set_generator',AFailed);
  EC_GROUP_get0_generator := LoadFunction('EC_GROUP_get0_generator',AFailed);
  EC_GROUP_get_mont_data := LoadFunction('EC_GROUP_get_mont_data',AFailed);
  EC_GROUP_get_order := LoadFunction('EC_GROUP_get_order',AFailed);
  EC_GROUP_get_cofactor := LoadFunction('EC_GROUP_get_cofactor',AFailed);
  EC_GROUP_set_curve_name := LoadFunction('EC_GROUP_set_curve_name',AFailed);
  EC_GROUP_get_curve_name := LoadFunction('EC_GROUP_get_curve_name',AFailed);
  EC_GROUP_set_asn1_flag := LoadFunction('EC_GROUP_set_asn1_flag',AFailed);
  EC_GROUP_get_asn1_flag := LoadFunction('EC_GROUP_get_asn1_flag',AFailed);
  EC_GROUP_set_point_conversion_form := LoadFunction('EC_GROUP_set_point_conversion_form',AFailed);
  EC_GROUP_get_point_conversion_form := LoadFunction('EC_GROUP_get_point_conversion_form',AFailed);
  EC_GROUP_get0_seed := LoadFunction('EC_GROUP_get0_seed',AFailed);
  EC_GROUP_get_seed_len := LoadFunction('EC_GROUP_get_seed_len',AFailed);
  EC_GROUP_set_seed := LoadFunction('EC_GROUP_set_seed',AFailed);
  EC_GROUP_set_curve_GFp := LoadFunction('EC_GROUP_set_curve_GFp',AFailed);
  EC_GROUP_get_curve_GFp := LoadFunction('EC_GROUP_get_curve_GFp',AFailed);
  EC_GROUP_set_curve_GF2m := LoadFunction('EC_GROUP_set_curve_GF2m',AFailed);
  EC_GROUP_get_curve_GF2m := LoadFunction('EC_GROUP_get_curve_GF2m',AFailed);
  EC_GROUP_get_degree := LoadFunction('EC_GROUP_get_degree',AFailed);
  EC_GROUP_check := LoadFunction('EC_GROUP_check',AFailed);
  EC_GROUP_check_discriminant := LoadFunction('EC_GROUP_check_discriminant',AFailed);
  EC_GROUP_cmp := LoadFunction('EC_GROUP_cmp',AFailed);
  EC_GROUP_new_curve_GFp := LoadFunction('EC_GROUP_new_curve_GFp',AFailed);
  EC_GROUP_new_curve_GF2m := LoadFunction('EC_GROUP_new_curve_GF2m',AFailed);
  EC_GROUP_new_by_curve_name := LoadFunction('EC_GROUP_new_by_curve_name',AFailed);
  EC_get_builtin_curves := LoadFunction('EC_get_builtin_curves',AFailed);
  EC_curve_nid2nist := LoadFunction('EC_curve_nid2nist',AFailed);
  EC_curve_nist2nid := LoadFunction('EC_curve_nist2nid',AFailed);
  EC_POINT_new := LoadFunction('EC_POINT_new',AFailed);
  EC_POINT_free := LoadFunction('EC_POINT_free',AFailed);
  EC_POINT_clear_free := LoadFunction('EC_POINT_clear_free',AFailed);
  EC_POINT_copy := LoadFunction('EC_POINT_copy',AFailed);
  EC_POINT_dup := LoadFunction('EC_POINT_dup',AFailed);
  EC_POINT_method_of := LoadFunction('EC_POINT_method_of',AFailed);
  EC_POINT_set_to_infinity := LoadFunction('EC_POINT_set_to_infinity',AFailed);
  EC_POINT_set_Jprojective_coordinates_GFp := LoadFunction('EC_POINT_set_Jprojective_coordinates_GFp',AFailed);
  EC_POINT_get_Jprojective_coordinates_GFp := LoadFunction('EC_POINT_get_Jprojective_coordinates_GFp',AFailed);
  EC_POINT_set_affine_coordinates_GFp := LoadFunction('EC_POINT_set_affine_coordinates_GFp',AFailed);
  EC_POINT_get_affine_coordinates_GFp := LoadFunction('EC_POINT_get_affine_coordinates_GFp',AFailed);
  EC_POINT_set_compressed_coordinates_GFp := LoadFunction('EC_POINT_set_compressed_coordinates_GFp',AFailed);
  EC_POINT_set_affine_coordinates_GF2m := LoadFunction('EC_POINT_set_affine_coordinates_GF2m',AFailed);
  EC_POINT_get_affine_coordinates_GF2m := LoadFunction('EC_POINT_get_affine_coordinates_GF2m',AFailed);
  EC_POINT_set_compressed_coordinates_GF2m := LoadFunction('EC_POINT_set_compressed_coordinates_GF2m',AFailed);
  EC_POINT_point2oct := LoadFunction('EC_POINT_point2oct',AFailed);
  EC_POINT_oct2point := LoadFunction('EC_POINT_oct2point',AFailed);
  EC_POINT_point2bn := LoadFunction('EC_POINT_point2bn',AFailed);
  EC_POINT_bn2point := LoadFunction('EC_POINT_bn2point',AFailed);
  EC_POINT_point2hex := LoadFunction('EC_POINT_point2hex',AFailed);
  EC_POINT_hex2point := LoadFunction('EC_POINT_hex2point',AFailed);
  EC_POINT_add := LoadFunction('EC_POINT_add',AFailed);
  EC_POINT_dbl := LoadFunction('EC_POINT_dbl',AFailed);
  EC_POINT_invert := LoadFunction('EC_POINT_invert',AFailed);
  EC_POINT_is_at_infinity := LoadFunction('EC_POINT_is_at_infinity',AFailed);
  EC_POINT_is_on_curve := LoadFunction('EC_POINT_is_on_curve',AFailed);
  EC_POINT_cmp := LoadFunction('EC_POINT_cmp',AFailed);
  EC_POINT_make_affine := LoadFunction('EC_POINT_make_affine',AFailed);
  EC_POINTs_make_affine := LoadFunction('EC_POINTs_make_affine',AFailed);
  EC_POINTs_mul := LoadFunction('EC_POINTs_mul',AFailed);
  EC_POINT_mul := LoadFunction('EC_POINT_mul',AFailed);
  EC_GROUP_precompute_mult := LoadFunction('EC_GROUP_precompute_mult',AFailed);
  EC_GROUP_have_precompute_mult := LoadFunction('EC_GROUP_have_precompute_mult',AFailed);
  ECPKPARAMETERS_it := LoadFunction('ECPKPARAMETERS_it',AFailed);
  ECPKPARAMETERS_new := LoadFunction('ECPKPARAMETERS_new',AFailed);
  ECPKPARAMETERS_free := LoadFunction('ECPKPARAMETERS_free',AFailed);
  ECPARAMETERS_it := LoadFunction('ECPARAMETERS_it',AFailed);
  ECPARAMETERS_new := LoadFunction('ECPARAMETERS_new',AFailed);
  ECPARAMETERS_free := LoadFunction('ECPARAMETERS_free',AFailed);
  EC_GROUP_get_basis_type := LoadFunction('EC_GROUP_get_basis_type',AFailed);
  EC_GROUP_get_trinomial_basis := LoadFunction('EC_GROUP_get_trinomial_basis',AFailed);
  EC_GROUP_get_pentanomial_basis := LoadFunction('EC_GROUP_get_pentanomial_basis',AFailed);
  d2i_ECPKParameters := LoadFunction('d2i_ECPKParameters',AFailed);
  i2d_ECPKParameters := LoadFunction('i2d_ECPKParameters',AFailed);
  ECPKParameters_print := LoadFunction('ECPKParameters_print',AFailed);
  EC_KEY_new := LoadFunction('EC_KEY_new',AFailed);
  EC_KEY_get_flags := LoadFunction('EC_KEY_get_flags',AFailed);
  EC_KEY_set_flags := LoadFunction('EC_KEY_set_flags',AFailed);
  EC_KEY_clear_flags := LoadFunction('EC_KEY_clear_flags',AFailed);
  EC_KEY_new_by_curve_name := LoadFunction('EC_KEY_new_by_curve_name',AFailed);
  EC_KEY_free := LoadFunction('EC_KEY_free',AFailed);
  EC_KEY_copy := LoadFunction('EC_KEY_copy',AFailed);
  EC_KEY_dup := LoadFunction('EC_KEY_dup',AFailed);
  EC_KEY_up_ref := LoadFunction('EC_KEY_up_ref',AFailed);
  EC_KEY_get0_group := LoadFunction('EC_KEY_get0_group',AFailed);
  EC_KEY_set_group := LoadFunction('EC_KEY_set_group',AFailed);
  EC_KEY_get0_private_key := LoadFunction('EC_KEY_get0_private_key',AFailed);
  EC_KEY_set_private_key := LoadFunction('EC_KEY_set_private_key',AFailed);
  EC_KEY_get0_public_key := LoadFunction('EC_KEY_get0_public_key',AFailed);
  EC_KEY_set_public_key := LoadFunction('EC_KEY_set_public_key',AFailed);
  EC_KEY_get_enc_flags := LoadFunction('EC_KEY_get_enc_flags',AFailed);
  EC_KEY_set_enc_flags := LoadFunction('EC_KEY_set_enc_flags',AFailed);
  EC_KEY_get_conv_form := LoadFunction('EC_KEY_get_conv_form',AFailed);
  EC_KEY_set_conv_form := LoadFunction('EC_KEY_set_conv_form',AFailed);
  EC_KEY_set_asn1_flag := LoadFunction('EC_KEY_set_asn1_flag',AFailed);
  EC_KEY_precompute_mult := LoadFunction('EC_KEY_precompute_mult',AFailed);
  EC_KEY_generate_key := LoadFunction('EC_KEY_generate_key',AFailed);
  EC_KEY_check_key := LoadFunction('EC_KEY_check_key',AFailed);
  EC_KEY_set_public_key_affine_coordinates := LoadFunction('EC_KEY_set_public_key_affine_coordinates',AFailed);
  d2i_ECPrivateKey := LoadFunction('d2i_ECPrivateKey',AFailed);
  i2d_ECPrivateKey := LoadFunction('i2d_ECPrivateKey',AFailed);
  o2i_ECPublicKey := LoadFunction('o2i_ECPublicKey',AFailed);
  i2o_ECPublicKey := LoadFunction('i2o_ECPublicKey',AFailed);
  ECParameters_print := LoadFunction('ECParameters_print',AFailed);
  EC_KEY_print := LoadFunction('EC_KEY_print',AFailed);
  ECDH_KDF_X9_62 := LoadFunction('ECDH_KDF_X9_62',AFailed);
  ECDH_compute_key := LoadFunction('ECDH_compute_key',AFailed);
  ECDSA_SIG_new := LoadFunction('ECDSA_SIG_new',AFailed);
  ECDSA_SIG_free := LoadFunction('ECDSA_SIG_free',AFailed);
  i2d_ECDSA_SIG := LoadFunction('i2d_ECDSA_SIG',AFailed);
  d2i_ECDSA_SIG := LoadFunction('d2i_ECDSA_SIG',AFailed);
  ECDSA_do_sign := LoadFunction('ECDSA_do_sign',AFailed);
  ECDSA_do_sign_ex := LoadFunction('ECDSA_do_sign_ex',AFailed);
  ECDSA_do_verify := LoadFunction('ECDSA_do_verify',AFailed);
  ECDSA_sign_setup := LoadFunction('ECDSA_sign_setup',AFailed);
  ECDSA_sign := LoadFunction('ECDSA_sign',AFailed);
  ECDSA_sign_ex := LoadFunction('ECDSA_sign_ex',AFailed);
  ECDSA_verify := LoadFunction('ECDSA_verify',AFailed);
  ECDSA_size := LoadFunction('ECDSA_size',AFailed);
  EC_GFp_nistp224_method := LoadFunction('EC_GFp_nistp224_method',nil); {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp256_method := LoadFunction('EC_GFp_nistp256_method',nil); {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp521_method := LoadFunction('EC_GFp_nistp521_method',nil); {introduced 1.1.0 removed 3.0.0}
  EC_GROUP_get0_order := LoadFunction('EC_GROUP_get0_order',nil); {introduced 1.1.0}
  EC_GROUP_order_bits := LoadFunction('EC_GROUP_order_bits',nil); {introduced 1.1.0}
  EC_GROUP_get0_cofactor := LoadFunction('EC_GROUP_get0_cofactor',nil); {introduced 1.1.0}
  EC_GROUP_set_curve := LoadFunction('EC_GROUP_set_curve',nil); {introduced 1.1.0}
  EC_GROUP_get_curve := LoadFunction('EC_GROUP_get_curve',nil); {introduced 1.1.0}
  EC_GROUP_new_from_ecparameters := LoadFunction('EC_GROUP_new_from_ecparameters',nil); {introduced 1.1.0}
  EC_GROUP_get_ecparameters := LoadFunction('EC_GROUP_get_ecparameters',nil); {introduced 1.1.0}
  EC_GROUP_new_from_ecpkparameters := LoadFunction('EC_GROUP_new_from_ecpkparameters',nil); {introduced 1.1.0}
  EC_GROUP_get_ecpkparameters := LoadFunction('EC_GROUP_get_ecpkparameters',nil); {introduced 1.1.0}
  EC_POINT_set_affine_coordinates := LoadFunction('EC_POINT_set_affine_coordinates',nil); {introduced 1.1.0}
  EC_POINT_get_affine_coordinates := LoadFunction('EC_POINT_get_affine_coordinates',nil); {introduced 1.1.0}
  EC_POINT_set_compressed_coordinates := LoadFunction('EC_POINT_set_compressed_coordinates',nil); {introduced 1.1.0}
  EC_POINT_point2buf := LoadFunction('EC_POINT_point2buf',nil); {introduced 1.1.0}
  EC_KEY_get0_engine := LoadFunction('EC_KEY_get0_engine',nil); {introduced 1.1.0}
  EC_KEY_set_ex_data := LoadFunction('EC_KEY_set_ex_data',nil); {introduced 1.1.0}
  EC_KEY_get_ex_data := LoadFunction('EC_KEY_get_ex_data',nil); {introduced 1.1.0}
  EC_KEY_can_sign := LoadFunction('EC_KEY_can_sign',nil); {introduced 1.1.0}
  EC_KEY_key2buf := LoadFunction('EC_KEY_key2buf',nil); {introduced 1.1.0}
  EC_KEY_oct2key := LoadFunction('EC_KEY_oct2key',nil); {introduced 1.1.0}
  EC_KEY_oct2priv := LoadFunction('EC_KEY_oct2priv',nil); {introduced 1.1.0}
  EC_KEY_priv2oct := LoadFunction('EC_KEY_priv2oct',nil); {introduced 1.1.0}
  EC_KEY_priv2buf := LoadFunction('EC_KEY_priv2buf',nil); {introduced 1.1.0}
  EC_KEY_OpenSSL := LoadFunction('EC_KEY_OpenSSL',nil); {introduced 1.1.0}
  EC_KEY_get_default_method := LoadFunction('EC_KEY_get_default_method',nil); {introduced 1.1.0}
  EC_KEY_set_default_method := LoadFunction('EC_KEY_set_default_method',nil); {introduced 1.1.0}
  EC_KEY_get_method := LoadFunction('EC_KEY_get_method',nil); {introduced 1.1.0}
  EC_KEY_set_method := LoadFunction('EC_KEY_set_method',nil); {introduced 1.1.0}
  EC_KEY_new_method := LoadFunction('EC_KEY_new_method',nil); {introduced 1.1.0}
  ECDSA_SIG_get0 := LoadFunction('ECDSA_SIG_get0',nil); {introduced 1.1.0}
  ECDSA_SIG_get0_r := LoadFunction('ECDSA_SIG_get0_r',nil); {introduced 1.1.0}
  ECDSA_SIG_get0_s := LoadFunction('ECDSA_SIG_get0_s',nil); {introduced 1.1.0}
  ECDSA_SIG_set0 := LoadFunction('ECDSA_SIG_set0',nil); {introduced 1.1.0}
  EC_KEY_METHOD_new := LoadFunction('EC_KEY_METHOD_new',nil); {introduced 1.1.0}
  EC_KEY_METHOD_free := LoadFunction('EC_KEY_METHOD_free',nil); {introduced 1.1.0}
  EC_KEY_METHOD_set_init := LoadFunction('EC_KEY_METHOD_set_init',nil); {introduced 1.1.0}
  EC_KEY_METHOD_set_keygen := LoadFunction('EC_KEY_METHOD_set_keygen',nil); {introduced 1.1.0}
  EC_KEY_METHOD_set_compute_key := LoadFunction('EC_KEY_METHOD_set_compute_key',nil); {introduced 1.1.0}
  EC_KEY_METHOD_set_sign := LoadFunction('EC_KEY_METHOD_set_sign',nil); {introduced 1.1.0}
  EC_KEY_METHOD_set_verify := LoadFunction('EC_KEY_METHOD_set_verify',nil); {introduced 1.1.0}
  EC_KEY_METHOD_get_init := LoadFunction('EC_KEY_METHOD_get_init',nil); {introduced 1.1.0}
  EC_KEY_METHOD_get_keygen := LoadFunction('EC_KEY_METHOD_get_keygen',nil); {introduced 1.1.0}
  EC_KEY_METHOD_get_compute_key := LoadFunction('EC_KEY_METHOD_get_compute_key',nil); {introduced 1.1.0}
  EC_KEY_METHOD_get_sign := LoadFunction('EC_KEY_METHOD_get_sign',nil); {introduced 1.1.0}
  EC_KEY_METHOD_get_verify := LoadFunction('EC_KEY_METHOD_get_verify',nil); {introduced 1.1.0}
  if not assigned(EC_GFp_nistp224_method) then 
  begin
    {$if declared(EC_GFp_nistp224_method_introduced)}
    if LibVersion < EC_GFp_nistp224_method_introduced then
      {$if declared(FC_EC_GFp_nistp224_method)}
      EC_GFp_nistp224_method := @FC_EC_GFp_nistp224_method
      {$else}
      EC_GFp_nistp224_method := @ERR_EC_GFp_nistp224_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GFp_nistp224_method_removed)}
   if EC_GFp_nistp224_method_removed <= LibVersion then
     {$if declared(_EC_GFp_nistp224_method)}
     EC_GFp_nistp224_method := @_EC_GFp_nistp224_method
     {$else}
       {$IF declared(ERR_EC_GFp_nistp224_method)}
       EC_GFp_nistp224_method := @ERR_EC_GFp_nistp224_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GFp_nistp224_method) and Assigned(AFailed) then 
     AFailed.Add('EC_GFp_nistp224_method');
  end;


  if not assigned(EC_GFp_nistp256_method) then 
  begin
    {$if declared(EC_GFp_nistp256_method_introduced)}
    if LibVersion < EC_GFp_nistp256_method_introduced then
      {$if declared(FC_EC_GFp_nistp256_method)}
      EC_GFp_nistp256_method := @FC_EC_GFp_nistp256_method
      {$else}
      EC_GFp_nistp256_method := @ERR_EC_GFp_nistp256_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GFp_nistp256_method_removed)}
   if EC_GFp_nistp256_method_removed <= LibVersion then
     {$if declared(_EC_GFp_nistp256_method)}
     EC_GFp_nistp256_method := @_EC_GFp_nistp256_method
     {$else}
       {$IF declared(ERR_EC_GFp_nistp256_method)}
       EC_GFp_nistp256_method := @ERR_EC_GFp_nistp256_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GFp_nistp256_method) and Assigned(AFailed) then 
     AFailed.Add('EC_GFp_nistp256_method');
  end;


  if not assigned(EC_GFp_nistp521_method) then 
  begin
    {$if declared(EC_GFp_nistp521_method_introduced)}
    if LibVersion < EC_GFp_nistp521_method_introduced then
      {$if declared(FC_EC_GFp_nistp521_method)}
      EC_GFp_nistp521_method := @FC_EC_GFp_nistp521_method
      {$else}
      EC_GFp_nistp521_method := @ERR_EC_GFp_nistp521_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GFp_nistp521_method_removed)}
   if EC_GFp_nistp521_method_removed <= LibVersion then
     {$if declared(_EC_GFp_nistp521_method)}
     EC_GFp_nistp521_method := @_EC_GFp_nistp521_method
     {$else}
       {$IF declared(ERR_EC_GFp_nistp521_method)}
       EC_GFp_nistp521_method := @ERR_EC_GFp_nistp521_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GFp_nistp521_method) and Assigned(AFailed) then 
     AFailed.Add('EC_GFp_nistp521_method');
  end;


  if not assigned(EC_GROUP_get0_order) then 
  begin
    {$if declared(EC_GROUP_get0_order_introduced)}
    if LibVersion < EC_GROUP_get0_order_introduced then
      {$if declared(FC_EC_GROUP_get0_order)}
      EC_GROUP_get0_order := @FC_EC_GROUP_get0_order
      {$else}
      EC_GROUP_get0_order := @ERR_EC_GROUP_get0_order
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_get0_order_removed)}
   if EC_GROUP_get0_order_removed <= LibVersion then
     {$if declared(_EC_GROUP_get0_order)}
     EC_GROUP_get0_order := @_EC_GROUP_get0_order
     {$else}
       {$IF declared(ERR_EC_GROUP_get0_order)}
       EC_GROUP_get0_order := @ERR_EC_GROUP_get0_order
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_get0_order) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_get0_order');
  end;


  if not assigned(EC_GROUP_order_bits) then 
  begin
    {$if declared(EC_GROUP_order_bits_introduced)}
    if LibVersion < EC_GROUP_order_bits_introduced then
      {$if declared(FC_EC_GROUP_order_bits)}
      EC_GROUP_order_bits := @FC_EC_GROUP_order_bits
      {$else}
      EC_GROUP_order_bits := @ERR_EC_GROUP_order_bits
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_order_bits_removed)}
   if EC_GROUP_order_bits_removed <= LibVersion then
     {$if declared(_EC_GROUP_order_bits)}
     EC_GROUP_order_bits := @_EC_GROUP_order_bits
     {$else}
       {$IF declared(ERR_EC_GROUP_order_bits)}
       EC_GROUP_order_bits := @ERR_EC_GROUP_order_bits
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_order_bits) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_order_bits');
  end;


  if not assigned(EC_GROUP_get0_cofactor) then 
  begin
    {$if declared(EC_GROUP_get0_cofactor_introduced)}
    if LibVersion < EC_GROUP_get0_cofactor_introduced then
      {$if declared(FC_EC_GROUP_get0_cofactor)}
      EC_GROUP_get0_cofactor := @FC_EC_GROUP_get0_cofactor
      {$else}
      EC_GROUP_get0_cofactor := @ERR_EC_GROUP_get0_cofactor
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_get0_cofactor_removed)}
   if EC_GROUP_get0_cofactor_removed <= LibVersion then
     {$if declared(_EC_GROUP_get0_cofactor)}
     EC_GROUP_get0_cofactor := @_EC_GROUP_get0_cofactor
     {$else}
       {$IF declared(ERR_EC_GROUP_get0_cofactor)}
       EC_GROUP_get0_cofactor := @ERR_EC_GROUP_get0_cofactor
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_get0_cofactor) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_get0_cofactor');
  end;


  if not assigned(EC_GROUP_set_curve) then 
  begin
    {$if declared(EC_GROUP_set_curve_introduced)}
    if LibVersion < EC_GROUP_set_curve_introduced then
      {$if declared(FC_EC_GROUP_set_curve)}
      EC_GROUP_set_curve := @FC_EC_GROUP_set_curve
      {$else}
      EC_GROUP_set_curve := @ERR_EC_GROUP_set_curve
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_set_curve_removed)}
   if EC_GROUP_set_curve_removed <= LibVersion then
     {$if declared(_EC_GROUP_set_curve)}
     EC_GROUP_set_curve := @_EC_GROUP_set_curve
     {$else}
       {$IF declared(ERR_EC_GROUP_set_curve)}
       EC_GROUP_set_curve := @ERR_EC_GROUP_set_curve
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_set_curve) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_set_curve');
  end;


  if not assigned(EC_GROUP_get_curve) then 
  begin
    {$if declared(EC_GROUP_get_curve_introduced)}
    if LibVersion < EC_GROUP_get_curve_introduced then
      {$if declared(FC_EC_GROUP_get_curve)}
      EC_GROUP_get_curve := @FC_EC_GROUP_get_curve
      {$else}
      EC_GROUP_get_curve := @ERR_EC_GROUP_get_curve
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_get_curve_removed)}
   if EC_GROUP_get_curve_removed <= LibVersion then
     {$if declared(_EC_GROUP_get_curve)}
     EC_GROUP_get_curve := @_EC_GROUP_get_curve
     {$else}
       {$IF declared(ERR_EC_GROUP_get_curve)}
       EC_GROUP_get_curve := @ERR_EC_GROUP_get_curve
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_get_curve) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_get_curve');
  end;


  if not assigned(EC_GROUP_new_from_ecparameters) then 
  begin
    {$if declared(EC_GROUP_new_from_ecparameters_introduced)}
    if LibVersion < EC_GROUP_new_from_ecparameters_introduced then
      {$if declared(FC_EC_GROUP_new_from_ecparameters)}
      EC_GROUP_new_from_ecparameters := @FC_EC_GROUP_new_from_ecparameters
      {$else}
      EC_GROUP_new_from_ecparameters := @ERR_EC_GROUP_new_from_ecparameters
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_new_from_ecparameters_removed)}
   if EC_GROUP_new_from_ecparameters_removed <= LibVersion then
     {$if declared(_EC_GROUP_new_from_ecparameters)}
     EC_GROUP_new_from_ecparameters := @_EC_GROUP_new_from_ecparameters
     {$else}
       {$IF declared(ERR_EC_GROUP_new_from_ecparameters)}
       EC_GROUP_new_from_ecparameters := @ERR_EC_GROUP_new_from_ecparameters
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_new_from_ecparameters) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_new_from_ecparameters');
  end;


  if not assigned(EC_GROUP_get_ecparameters) then 
  begin
    {$if declared(EC_GROUP_get_ecparameters_introduced)}
    if LibVersion < EC_GROUP_get_ecparameters_introduced then
      {$if declared(FC_EC_GROUP_get_ecparameters)}
      EC_GROUP_get_ecparameters := @FC_EC_GROUP_get_ecparameters
      {$else}
      EC_GROUP_get_ecparameters := @ERR_EC_GROUP_get_ecparameters
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_get_ecparameters_removed)}
   if EC_GROUP_get_ecparameters_removed <= LibVersion then
     {$if declared(_EC_GROUP_get_ecparameters)}
     EC_GROUP_get_ecparameters := @_EC_GROUP_get_ecparameters
     {$else}
       {$IF declared(ERR_EC_GROUP_get_ecparameters)}
       EC_GROUP_get_ecparameters := @ERR_EC_GROUP_get_ecparameters
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_get_ecparameters) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_get_ecparameters');
  end;


  if not assigned(EC_GROUP_new_from_ecpkparameters) then 
  begin
    {$if declared(EC_GROUP_new_from_ecpkparameters_introduced)}
    if LibVersion < EC_GROUP_new_from_ecpkparameters_introduced then
      {$if declared(FC_EC_GROUP_new_from_ecpkparameters)}
      EC_GROUP_new_from_ecpkparameters := @FC_EC_GROUP_new_from_ecpkparameters
      {$else}
      EC_GROUP_new_from_ecpkparameters := @ERR_EC_GROUP_new_from_ecpkparameters
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_new_from_ecpkparameters_removed)}
   if EC_GROUP_new_from_ecpkparameters_removed <= LibVersion then
     {$if declared(_EC_GROUP_new_from_ecpkparameters)}
     EC_GROUP_new_from_ecpkparameters := @_EC_GROUP_new_from_ecpkparameters
     {$else}
       {$IF declared(ERR_EC_GROUP_new_from_ecpkparameters)}
       EC_GROUP_new_from_ecpkparameters := @ERR_EC_GROUP_new_from_ecpkparameters
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_new_from_ecpkparameters) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_new_from_ecpkparameters');
  end;


  if not assigned(EC_GROUP_get_ecpkparameters) then 
  begin
    {$if declared(EC_GROUP_get_ecpkparameters_introduced)}
    if LibVersion < EC_GROUP_get_ecpkparameters_introduced then
      {$if declared(FC_EC_GROUP_get_ecpkparameters)}
      EC_GROUP_get_ecpkparameters := @FC_EC_GROUP_get_ecpkparameters
      {$else}
      EC_GROUP_get_ecpkparameters := @ERR_EC_GROUP_get_ecpkparameters
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_GROUP_get_ecpkparameters_removed)}
   if EC_GROUP_get_ecpkparameters_removed <= LibVersion then
     {$if declared(_EC_GROUP_get_ecpkparameters)}
     EC_GROUP_get_ecpkparameters := @_EC_GROUP_get_ecpkparameters
     {$else}
       {$IF declared(ERR_EC_GROUP_get_ecpkparameters)}
       EC_GROUP_get_ecpkparameters := @ERR_EC_GROUP_get_ecpkparameters
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_GROUP_get_ecpkparameters) and Assigned(AFailed) then 
     AFailed.Add('EC_GROUP_get_ecpkparameters');
  end;


  if not assigned(EC_POINT_set_affine_coordinates) then 
  begin
    {$if declared(EC_POINT_set_affine_coordinates_introduced)}
    if LibVersion < EC_POINT_set_affine_coordinates_introduced then
      {$if declared(FC_EC_POINT_set_affine_coordinates)}
      EC_POINT_set_affine_coordinates := @FC_EC_POINT_set_affine_coordinates
      {$else}
      EC_POINT_set_affine_coordinates := @ERR_EC_POINT_set_affine_coordinates
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_POINT_set_affine_coordinates_removed)}
   if EC_POINT_set_affine_coordinates_removed <= LibVersion then
     {$if declared(_EC_POINT_set_affine_coordinates)}
     EC_POINT_set_affine_coordinates := @_EC_POINT_set_affine_coordinates
     {$else}
       {$IF declared(ERR_EC_POINT_set_affine_coordinates)}
       EC_POINT_set_affine_coordinates := @ERR_EC_POINT_set_affine_coordinates
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_POINT_set_affine_coordinates) and Assigned(AFailed) then 
     AFailed.Add('EC_POINT_set_affine_coordinates');
  end;


  if not assigned(EC_POINT_get_affine_coordinates) then 
  begin
    {$if declared(EC_POINT_get_affine_coordinates_introduced)}
    if LibVersion < EC_POINT_get_affine_coordinates_introduced then
      {$if declared(FC_EC_POINT_get_affine_coordinates)}
      EC_POINT_get_affine_coordinates := @FC_EC_POINT_get_affine_coordinates
      {$else}
      EC_POINT_get_affine_coordinates := @ERR_EC_POINT_get_affine_coordinates
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_POINT_get_affine_coordinates_removed)}
   if EC_POINT_get_affine_coordinates_removed <= LibVersion then
     {$if declared(_EC_POINT_get_affine_coordinates)}
     EC_POINT_get_affine_coordinates := @_EC_POINT_get_affine_coordinates
     {$else}
       {$IF declared(ERR_EC_POINT_get_affine_coordinates)}
       EC_POINT_get_affine_coordinates := @ERR_EC_POINT_get_affine_coordinates
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_POINT_get_affine_coordinates) and Assigned(AFailed) then 
     AFailed.Add('EC_POINT_get_affine_coordinates');
  end;


  if not assigned(EC_POINT_set_compressed_coordinates) then 
  begin
    {$if declared(EC_POINT_set_compressed_coordinates_introduced)}
    if LibVersion < EC_POINT_set_compressed_coordinates_introduced then
      {$if declared(FC_EC_POINT_set_compressed_coordinates)}
      EC_POINT_set_compressed_coordinates := @FC_EC_POINT_set_compressed_coordinates
      {$else}
      EC_POINT_set_compressed_coordinates := @ERR_EC_POINT_set_compressed_coordinates
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_POINT_set_compressed_coordinates_removed)}
   if EC_POINT_set_compressed_coordinates_removed <= LibVersion then
     {$if declared(_EC_POINT_set_compressed_coordinates)}
     EC_POINT_set_compressed_coordinates := @_EC_POINT_set_compressed_coordinates
     {$else}
       {$IF declared(ERR_EC_POINT_set_compressed_coordinates)}
       EC_POINT_set_compressed_coordinates := @ERR_EC_POINT_set_compressed_coordinates
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_POINT_set_compressed_coordinates) and Assigned(AFailed) then 
     AFailed.Add('EC_POINT_set_compressed_coordinates');
  end;


  if not assigned(EC_POINT_point2buf) then 
  begin
    {$if declared(EC_POINT_point2buf_introduced)}
    if LibVersion < EC_POINT_point2buf_introduced then
      {$if declared(FC_EC_POINT_point2buf)}
      EC_POINT_point2buf := @FC_EC_POINT_point2buf
      {$else}
      EC_POINT_point2buf := @ERR_EC_POINT_point2buf
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_POINT_point2buf_removed)}
   if EC_POINT_point2buf_removed <= LibVersion then
     {$if declared(_EC_POINT_point2buf)}
     EC_POINT_point2buf := @_EC_POINT_point2buf
     {$else}
       {$IF declared(ERR_EC_POINT_point2buf)}
       EC_POINT_point2buf := @ERR_EC_POINT_point2buf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_POINT_point2buf) and Assigned(AFailed) then 
     AFailed.Add('EC_POINT_point2buf');
  end;


  if not assigned(EC_KEY_get0_engine) then 
  begin
    {$if declared(EC_KEY_get0_engine_introduced)}
    if LibVersion < EC_KEY_get0_engine_introduced then
      {$if declared(FC_EC_KEY_get0_engine)}
      EC_KEY_get0_engine := @FC_EC_KEY_get0_engine
      {$else}
      EC_KEY_get0_engine := @ERR_EC_KEY_get0_engine
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_get0_engine_removed)}
   if EC_KEY_get0_engine_removed <= LibVersion then
     {$if declared(_EC_KEY_get0_engine)}
     EC_KEY_get0_engine := @_EC_KEY_get0_engine
     {$else}
       {$IF declared(ERR_EC_KEY_get0_engine)}
       EC_KEY_get0_engine := @ERR_EC_KEY_get0_engine
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_get0_engine) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_get0_engine');
  end;


  if not assigned(EC_KEY_set_ex_data) then 
  begin
    {$if declared(EC_KEY_set_ex_data_introduced)}
    if LibVersion < EC_KEY_set_ex_data_introduced then
      {$if declared(FC_EC_KEY_set_ex_data)}
      EC_KEY_set_ex_data := @FC_EC_KEY_set_ex_data
      {$else}
      EC_KEY_set_ex_data := @ERR_EC_KEY_set_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_set_ex_data_removed)}
   if EC_KEY_set_ex_data_removed <= LibVersion then
     {$if declared(_EC_KEY_set_ex_data)}
     EC_KEY_set_ex_data := @_EC_KEY_set_ex_data
     {$else}
       {$IF declared(ERR_EC_KEY_set_ex_data)}
       EC_KEY_set_ex_data := @ERR_EC_KEY_set_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_set_ex_data) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_set_ex_data');
  end;


  if not assigned(EC_KEY_get_ex_data) then 
  begin
    {$if declared(EC_KEY_get_ex_data_introduced)}
    if LibVersion < EC_KEY_get_ex_data_introduced then
      {$if declared(FC_EC_KEY_get_ex_data)}
      EC_KEY_get_ex_data := @FC_EC_KEY_get_ex_data
      {$else}
      EC_KEY_get_ex_data := @ERR_EC_KEY_get_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_get_ex_data_removed)}
   if EC_KEY_get_ex_data_removed <= LibVersion then
     {$if declared(_EC_KEY_get_ex_data)}
     EC_KEY_get_ex_data := @_EC_KEY_get_ex_data
     {$else}
       {$IF declared(ERR_EC_KEY_get_ex_data)}
       EC_KEY_get_ex_data := @ERR_EC_KEY_get_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_get_ex_data) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_get_ex_data');
  end;


  if not assigned(EC_KEY_can_sign) then 
  begin
    {$if declared(EC_KEY_can_sign_introduced)}
    if LibVersion < EC_KEY_can_sign_introduced then
      {$if declared(FC_EC_KEY_can_sign)}
      EC_KEY_can_sign := @FC_EC_KEY_can_sign
      {$else}
      EC_KEY_can_sign := @ERR_EC_KEY_can_sign
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_can_sign_removed)}
   if EC_KEY_can_sign_removed <= LibVersion then
     {$if declared(_EC_KEY_can_sign)}
     EC_KEY_can_sign := @_EC_KEY_can_sign
     {$else}
       {$IF declared(ERR_EC_KEY_can_sign)}
       EC_KEY_can_sign := @ERR_EC_KEY_can_sign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_can_sign) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_can_sign');
  end;


  if not assigned(EC_KEY_key2buf) then 
  begin
    {$if declared(EC_KEY_key2buf_introduced)}
    if LibVersion < EC_KEY_key2buf_introduced then
      {$if declared(FC_EC_KEY_key2buf)}
      EC_KEY_key2buf := @FC_EC_KEY_key2buf
      {$else}
      EC_KEY_key2buf := @ERR_EC_KEY_key2buf
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_key2buf_removed)}
   if EC_KEY_key2buf_removed <= LibVersion then
     {$if declared(_EC_KEY_key2buf)}
     EC_KEY_key2buf := @_EC_KEY_key2buf
     {$else}
       {$IF declared(ERR_EC_KEY_key2buf)}
       EC_KEY_key2buf := @ERR_EC_KEY_key2buf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_key2buf) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_key2buf');
  end;


  if not assigned(EC_KEY_oct2key) then 
  begin
    {$if declared(EC_KEY_oct2key_introduced)}
    if LibVersion < EC_KEY_oct2key_introduced then
      {$if declared(FC_EC_KEY_oct2key)}
      EC_KEY_oct2key := @FC_EC_KEY_oct2key
      {$else}
      EC_KEY_oct2key := @ERR_EC_KEY_oct2key
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_oct2key_removed)}
   if EC_KEY_oct2key_removed <= LibVersion then
     {$if declared(_EC_KEY_oct2key)}
     EC_KEY_oct2key := @_EC_KEY_oct2key
     {$else}
       {$IF declared(ERR_EC_KEY_oct2key)}
       EC_KEY_oct2key := @ERR_EC_KEY_oct2key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_oct2key) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_oct2key');
  end;


  if not assigned(EC_KEY_oct2priv) then 
  begin
    {$if declared(EC_KEY_oct2priv_introduced)}
    if LibVersion < EC_KEY_oct2priv_introduced then
      {$if declared(FC_EC_KEY_oct2priv)}
      EC_KEY_oct2priv := @FC_EC_KEY_oct2priv
      {$else}
      EC_KEY_oct2priv := @ERR_EC_KEY_oct2priv
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_oct2priv_removed)}
   if EC_KEY_oct2priv_removed <= LibVersion then
     {$if declared(_EC_KEY_oct2priv)}
     EC_KEY_oct2priv := @_EC_KEY_oct2priv
     {$else}
       {$IF declared(ERR_EC_KEY_oct2priv)}
       EC_KEY_oct2priv := @ERR_EC_KEY_oct2priv
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_oct2priv) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_oct2priv');
  end;


  if not assigned(EC_KEY_priv2oct) then 
  begin
    {$if declared(EC_KEY_priv2oct_introduced)}
    if LibVersion < EC_KEY_priv2oct_introduced then
      {$if declared(FC_EC_KEY_priv2oct)}
      EC_KEY_priv2oct := @FC_EC_KEY_priv2oct
      {$else}
      EC_KEY_priv2oct := @ERR_EC_KEY_priv2oct
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_priv2oct_removed)}
   if EC_KEY_priv2oct_removed <= LibVersion then
     {$if declared(_EC_KEY_priv2oct)}
     EC_KEY_priv2oct := @_EC_KEY_priv2oct
     {$else}
       {$IF declared(ERR_EC_KEY_priv2oct)}
       EC_KEY_priv2oct := @ERR_EC_KEY_priv2oct
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_priv2oct) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_priv2oct');
  end;


  if not assigned(EC_KEY_priv2buf) then 
  begin
    {$if declared(EC_KEY_priv2buf_introduced)}
    if LibVersion < EC_KEY_priv2buf_introduced then
      {$if declared(FC_EC_KEY_priv2buf)}
      EC_KEY_priv2buf := @FC_EC_KEY_priv2buf
      {$else}
      EC_KEY_priv2buf := @ERR_EC_KEY_priv2buf
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_priv2buf_removed)}
   if EC_KEY_priv2buf_removed <= LibVersion then
     {$if declared(_EC_KEY_priv2buf)}
     EC_KEY_priv2buf := @_EC_KEY_priv2buf
     {$else}
       {$IF declared(ERR_EC_KEY_priv2buf)}
       EC_KEY_priv2buf := @ERR_EC_KEY_priv2buf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_priv2buf) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_priv2buf');
  end;


  if not assigned(EC_KEY_OpenSSL) then 
  begin
    {$if declared(EC_KEY_OpenSSL_introduced)}
    if LibVersion < EC_KEY_OpenSSL_introduced then
      {$if declared(FC_EC_KEY_OpenSSL)}
      EC_KEY_OpenSSL := @FC_EC_KEY_OpenSSL
      {$else}
      EC_KEY_OpenSSL := @ERR_EC_KEY_OpenSSL
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_OpenSSL_removed)}
   if EC_KEY_OpenSSL_removed <= LibVersion then
     {$if declared(_EC_KEY_OpenSSL)}
     EC_KEY_OpenSSL := @_EC_KEY_OpenSSL
     {$else}
       {$IF declared(ERR_EC_KEY_OpenSSL)}
       EC_KEY_OpenSSL := @ERR_EC_KEY_OpenSSL
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_OpenSSL) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_OpenSSL');
  end;


  if not assigned(EC_KEY_get_default_method) then 
  begin
    {$if declared(EC_KEY_get_default_method_introduced)}
    if LibVersion < EC_KEY_get_default_method_introduced then
      {$if declared(FC_EC_KEY_get_default_method)}
      EC_KEY_get_default_method := @FC_EC_KEY_get_default_method
      {$else}
      EC_KEY_get_default_method := @ERR_EC_KEY_get_default_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_get_default_method_removed)}
   if EC_KEY_get_default_method_removed <= LibVersion then
     {$if declared(_EC_KEY_get_default_method)}
     EC_KEY_get_default_method := @_EC_KEY_get_default_method
     {$else}
       {$IF declared(ERR_EC_KEY_get_default_method)}
       EC_KEY_get_default_method := @ERR_EC_KEY_get_default_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_get_default_method) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_get_default_method');
  end;


  if not assigned(EC_KEY_set_default_method) then 
  begin
    {$if declared(EC_KEY_set_default_method_introduced)}
    if LibVersion < EC_KEY_set_default_method_introduced then
      {$if declared(FC_EC_KEY_set_default_method)}
      EC_KEY_set_default_method := @FC_EC_KEY_set_default_method
      {$else}
      EC_KEY_set_default_method := @ERR_EC_KEY_set_default_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_set_default_method_removed)}
   if EC_KEY_set_default_method_removed <= LibVersion then
     {$if declared(_EC_KEY_set_default_method)}
     EC_KEY_set_default_method := @_EC_KEY_set_default_method
     {$else}
       {$IF declared(ERR_EC_KEY_set_default_method)}
       EC_KEY_set_default_method := @ERR_EC_KEY_set_default_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_set_default_method) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_set_default_method');
  end;


  if not assigned(EC_KEY_get_method) then 
  begin
    {$if declared(EC_KEY_get_method_introduced)}
    if LibVersion < EC_KEY_get_method_introduced then
      {$if declared(FC_EC_KEY_get_method)}
      EC_KEY_get_method := @FC_EC_KEY_get_method
      {$else}
      EC_KEY_get_method := @ERR_EC_KEY_get_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_get_method_removed)}
   if EC_KEY_get_method_removed <= LibVersion then
     {$if declared(_EC_KEY_get_method)}
     EC_KEY_get_method := @_EC_KEY_get_method
     {$else}
       {$IF declared(ERR_EC_KEY_get_method)}
       EC_KEY_get_method := @ERR_EC_KEY_get_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_get_method) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_get_method');
  end;


  if not assigned(EC_KEY_set_method) then 
  begin
    {$if declared(EC_KEY_set_method_introduced)}
    if LibVersion < EC_KEY_set_method_introduced then
      {$if declared(FC_EC_KEY_set_method)}
      EC_KEY_set_method := @FC_EC_KEY_set_method
      {$else}
      EC_KEY_set_method := @ERR_EC_KEY_set_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_set_method_removed)}
   if EC_KEY_set_method_removed <= LibVersion then
     {$if declared(_EC_KEY_set_method)}
     EC_KEY_set_method := @_EC_KEY_set_method
     {$else}
       {$IF declared(ERR_EC_KEY_set_method)}
       EC_KEY_set_method := @ERR_EC_KEY_set_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_set_method) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_set_method');
  end;


  if not assigned(EC_KEY_new_method) then 
  begin
    {$if declared(EC_KEY_new_method_introduced)}
    if LibVersion < EC_KEY_new_method_introduced then
      {$if declared(FC_EC_KEY_new_method)}
      EC_KEY_new_method := @FC_EC_KEY_new_method
      {$else}
      EC_KEY_new_method := @ERR_EC_KEY_new_method
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_new_method_removed)}
   if EC_KEY_new_method_removed <= LibVersion then
     {$if declared(_EC_KEY_new_method)}
     EC_KEY_new_method := @_EC_KEY_new_method
     {$else}
       {$IF declared(ERR_EC_KEY_new_method)}
       EC_KEY_new_method := @ERR_EC_KEY_new_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_new_method) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_new_method');
  end;


  if not assigned(ECDSA_SIG_get0) then 
  begin
    {$if declared(ECDSA_SIG_get0_introduced)}
    if LibVersion < ECDSA_SIG_get0_introduced then
      {$if declared(FC_ECDSA_SIG_get0)}
      ECDSA_SIG_get0 := @FC_ECDSA_SIG_get0
      {$else}
      ECDSA_SIG_get0 := @ERR_ECDSA_SIG_get0
      {$ifend}
    else
    {$ifend}
   {$if declared(ECDSA_SIG_get0_removed)}
   if ECDSA_SIG_get0_removed <= LibVersion then
     {$if declared(_ECDSA_SIG_get0)}
     ECDSA_SIG_get0 := @_ECDSA_SIG_get0
     {$else}
       {$IF declared(ERR_ECDSA_SIG_get0)}
       ECDSA_SIG_get0 := @ERR_ECDSA_SIG_get0
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ECDSA_SIG_get0) and Assigned(AFailed) then 
     AFailed.Add('ECDSA_SIG_get0');
  end;


  if not assigned(ECDSA_SIG_get0_r) then 
  begin
    {$if declared(ECDSA_SIG_get0_r_introduced)}
    if LibVersion < ECDSA_SIG_get0_r_introduced then
      {$if declared(FC_ECDSA_SIG_get0_r)}
      ECDSA_SIG_get0_r := @FC_ECDSA_SIG_get0_r
      {$else}
      ECDSA_SIG_get0_r := @ERR_ECDSA_SIG_get0_r
      {$ifend}
    else
    {$ifend}
   {$if declared(ECDSA_SIG_get0_r_removed)}
   if ECDSA_SIG_get0_r_removed <= LibVersion then
     {$if declared(_ECDSA_SIG_get0_r)}
     ECDSA_SIG_get0_r := @_ECDSA_SIG_get0_r
     {$else}
       {$IF declared(ERR_ECDSA_SIG_get0_r)}
       ECDSA_SIG_get0_r := @ERR_ECDSA_SIG_get0_r
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ECDSA_SIG_get0_r) and Assigned(AFailed) then 
     AFailed.Add('ECDSA_SIG_get0_r');
  end;


  if not assigned(ECDSA_SIG_get0_s) then 
  begin
    {$if declared(ECDSA_SIG_get0_s_introduced)}
    if LibVersion < ECDSA_SIG_get0_s_introduced then
      {$if declared(FC_ECDSA_SIG_get0_s)}
      ECDSA_SIG_get0_s := @FC_ECDSA_SIG_get0_s
      {$else}
      ECDSA_SIG_get0_s := @ERR_ECDSA_SIG_get0_s
      {$ifend}
    else
    {$ifend}
   {$if declared(ECDSA_SIG_get0_s_removed)}
   if ECDSA_SIG_get0_s_removed <= LibVersion then
     {$if declared(_ECDSA_SIG_get0_s)}
     ECDSA_SIG_get0_s := @_ECDSA_SIG_get0_s
     {$else}
       {$IF declared(ERR_ECDSA_SIG_get0_s)}
       ECDSA_SIG_get0_s := @ERR_ECDSA_SIG_get0_s
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ECDSA_SIG_get0_s) and Assigned(AFailed) then 
     AFailed.Add('ECDSA_SIG_get0_s');
  end;


  if not assigned(ECDSA_SIG_set0) then 
  begin
    {$if declared(ECDSA_SIG_set0_introduced)}
    if LibVersion < ECDSA_SIG_set0_introduced then
      {$if declared(FC_ECDSA_SIG_set0)}
      ECDSA_SIG_set0 := @FC_ECDSA_SIG_set0
      {$else}
      ECDSA_SIG_set0 := @ERR_ECDSA_SIG_set0
      {$ifend}
    else
    {$ifend}
   {$if declared(ECDSA_SIG_set0_removed)}
   if ECDSA_SIG_set0_removed <= LibVersion then
     {$if declared(_ECDSA_SIG_set0)}
     ECDSA_SIG_set0 := @_ECDSA_SIG_set0
     {$else}
       {$IF declared(ERR_ECDSA_SIG_set0)}
       ECDSA_SIG_set0 := @ERR_ECDSA_SIG_set0
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ECDSA_SIG_set0) and Assigned(AFailed) then 
     AFailed.Add('ECDSA_SIG_set0');
  end;


  if not assigned(EC_KEY_METHOD_new) then 
  begin
    {$if declared(EC_KEY_METHOD_new_introduced)}
    if LibVersion < EC_KEY_METHOD_new_introduced then
      {$if declared(FC_EC_KEY_METHOD_new)}
      EC_KEY_METHOD_new := @FC_EC_KEY_METHOD_new
      {$else}
      EC_KEY_METHOD_new := @ERR_EC_KEY_METHOD_new
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_new_removed)}
   if EC_KEY_METHOD_new_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_new)}
     EC_KEY_METHOD_new := @_EC_KEY_METHOD_new
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_new)}
       EC_KEY_METHOD_new := @ERR_EC_KEY_METHOD_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_new) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_new');
  end;


  if not assigned(EC_KEY_METHOD_free) then 
  begin
    {$if declared(EC_KEY_METHOD_free_introduced)}
    if LibVersion < EC_KEY_METHOD_free_introduced then
      {$if declared(FC_EC_KEY_METHOD_free)}
      EC_KEY_METHOD_free := @FC_EC_KEY_METHOD_free
      {$else}
      EC_KEY_METHOD_free := @ERR_EC_KEY_METHOD_free
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_free_removed)}
   if EC_KEY_METHOD_free_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_free)}
     EC_KEY_METHOD_free := @_EC_KEY_METHOD_free
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_free)}
       EC_KEY_METHOD_free := @ERR_EC_KEY_METHOD_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_free) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_free');
  end;


  if not assigned(EC_KEY_METHOD_set_init) then 
  begin
    {$if declared(EC_KEY_METHOD_set_init_introduced)}
    if LibVersion < EC_KEY_METHOD_set_init_introduced then
      {$if declared(FC_EC_KEY_METHOD_set_init)}
      EC_KEY_METHOD_set_init := @FC_EC_KEY_METHOD_set_init
      {$else}
      EC_KEY_METHOD_set_init := @ERR_EC_KEY_METHOD_set_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_set_init_removed)}
   if EC_KEY_METHOD_set_init_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_set_init)}
     EC_KEY_METHOD_set_init := @_EC_KEY_METHOD_set_init
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_set_init)}
       EC_KEY_METHOD_set_init := @ERR_EC_KEY_METHOD_set_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_set_init) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_set_init');
  end;


  if not assigned(EC_KEY_METHOD_set_keygen) then 
  begin
    {$if declared(EC_KEY_METHOD_set_keygen_introduced)}
    if LibVersion < EC_KEY_METHOD_set_keygen_introduced then
      {$if declared(FC_EC_KEY_METHOD_set_keygen)}
      EC_KEY_METHOD_set_keygen := @FC_EC_KEY_METHOD_set_keygen
      {$else}
      EC_KEY_METHOD_set_keygen := @ERR_EC_KEY_METHOD_set_keygen
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_set_keygen_removed)}
   if EC_KEY_METHOD_set_keygen_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_set_keygen)}
     EC_KEY_METHOD_set_keygen := @_EC_KEY_METHOD_set_keygen
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_set_keygen)}
       EC_KEY_METHOD_set_keygen := @ERR_EC_KEY_METHOD_set_keygen
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_set_keygen) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_set_keygen');
  end;


  if not assigned(EC_KEY_METHOD_set_compute_key) then 
  begin
    {$if declared(EC_KEY_METHOD_set_compute_key_introduced)}
    if LibVersion < EC_KEY_METHOD_set_compute_key_introduced then
      {$if declared(FC_EC_KEY_METHOD_set_compute_key)}
      EC_KEY_METHOD_set_compute_key := @FC_EC_KEY_METHOD_set_compute_key
      {$else}
      EC_KEY_METHOD_set_compute_key := @ERR_EC_KEY_METHOD_set_compute_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_set_compute_key_removed)}
   if EC_KEY_METHOD_set_compute_key_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_set_compute_key)}
     EC_KEY_METHOD_set_compute_key := @_EC_KEY_METHOD_set_compute_key
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_set_compute_key)}
       EC_KEY_METHOD_set_compute_key := @ERR_EC_KEY_METHOD_set_compute_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_set_compute_key) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_set_compute_key');
  end;


  if not assigned(EC_KEY_METHOD_set_sign) then 
  begin
    {$if declared(EC_KEY_METHOD_set_sign_introduced)}
    if LibVersion < EC_KEY_METHOD_set_sign_introduced then
      {$if declared(FC_EC_KEY_METHOD_set_sign)}
      EC_KEY_METHOD_set_sign := @FC_EC_KEY_METHOD_set_sign
      {$else}
      EC_KEY_METHOD_set_sign := @ERR_EC_KEY_METHOD_set_sign
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_set_sign_removed)}
   if EC_KEY_METHOD_set_sign_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_set_sign)}
     EC_KEY_METHOD_set_sign := @_EC_KEY_METHOD_set_sign
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_set_sign)}
       EC_KEY_METHOD_set_sign := @ERR_EC_KEY_METHOD_set_sign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_set_sign) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_set_sign');
  end;


  if not assigned(EC_KEY_METHOD_set_verify) then 
  begin
    {$if declared(EC_KEY_METHOD_set_verify_introduced)}
    if LibVersion < EC_KEY_METHOD_set_verify_introduced then
      {$if declared(FC_EC_KEY_METHOD_set_verify)}
      EC_KEY_METHOD_set_verify := @FC_EC_KEY_METHOD_set_verify
      {$else}
      EC_KEY_METHOD_set_verify := @ERR_EC_KEY_METHOD_set_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_set_verify_removed)}
   if EC_KEY_METHOD_set_verify_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_set_verify)}
     EC_KEY_METHOD_set_verify := @_EC_KEY_METHOD_set_verify
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_set_verify)}
       EC_KEY_METHOD_set_verify := @ERR_EC_KEY_METHOD_set_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_set_verify) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_set_verify');
  end;


  if not assigned(EC_KEY_METHOD_get_init) then 
  begin
    {$if declared(EC_KEY_METHOD_get_init_introduced)}
    if LibVersion < EC_KEY_METHOD_get_init_introduced then
      {$if declared(FC_EC_KEY_METHOD_get_init)}
      EC_KEY_METHOD_get_init := @FC_EC_KEY_METHOD_get_init
      {$else}
      EC_KEY_METHOD_get_init := @ERR_EC_KEY_METHOD_get_init
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_get_init_removed)}
   if EC_KEY_METHOD_get_init_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_get_init)}
     EC_KEY_METHOD_get_init := @_EC_KEY_METHOD_get_init
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_get_init)}
       EC_KEY_METHOD_get_init := @ERR_EC_KEY_METHOD_get_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_get_init) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_get_init');
  end;


  if not assigned(EC_KEY_METHOD_get_keygen) then 
  begin
    {$if declared(EC_KEY_METHOD_get_keygen_introduced)}
    if LibVersion < EC_KEY_METHOD_get_keygen_introduced then
      {$if declared(FC_EC_KEY_METHOD_get_keygen)}
      EC_KEY_METHOD_get_keygen := @FC_EC_KEY_METHOD_get_keygen
      {$else}
      EC_KEY_METHOD_get_keygen := @ERR_EC_KEY_METHOD_get_keygen
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_get_keygen_removed)}
   if EC_KEY_METHOD_get_keygen_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_get_keygen)}
     EC_KEY_METHOD_get_keygen := @_EC_KEY_METHOD_get_keygen
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_get_keygen)}
       EC_KEY_METHOD_get_keygen := @ERR_EC_KEY_METHOD_get_keygen
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_get_keygen) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_get_keygen');
  end;


  if not assigned(EC_KEY_METHOD_get_compute_key) then 
  begin
    {$if declared(EC_KEY_METHOD_get_compute_key_introduced)}
    if LibVersion < EC_KEY_METHOD_get_compute_key_introduced then
      {$if declared(FC_EC_KEY_METHOD_get_compute_key)}
      EC_KEY_METHOD_get_compute_key := @FC_EC_KEY_METHOD_get_compute_key
      {$else}
      EC_KEY_METHOD_get_compute_key := @ERR_EC_KEY_METHOD_get_compute_key
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_get_compute_key_removed)}
   if EC_KEY_METHOD_get_compute_key_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_get_compute_key)}
     EC_KEY_METHOD_get_compute_key := @_EC_KEY_METHOD_get_compute_key
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_get_compute_key)}
       EC_KEY_METHOD_get_compute_key := @ERR_EC_KEY_METHOD_get_compute_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_get_compute_key) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_get_compute_key');
  end;


  if not assigned(EC_KEY_METHOD_get_sign) then 
  begin
    {$if declared(EC_KEY_METHOD_get_sign_introduced)}
    if LibVersion < EC_KEY_METHOD_get_sign_introduced then
      {$if declared(FC_EC_KEY_METHOD_get_sign)}
      EC_KEY_METHOD_get_sign := @FC_EC_KEY_METHOD_get_sign
      {$else}
      EC_KEY_METHOD_get_sign := @ERR_EC_KEY_METHOD_get_sign
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_get_sign_removed)}
   if EC_KEY_METHOD_get_sign_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_get_sign)}
     EC_KEY_METHOD_get_sign := @_EC_KEY_METHOD_get_sign
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_get_sign)}
       EC_KEY_METHOD_get_sign := @ERR_EC_KEY_METHOD_get_sign
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_get_sign) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_get_sign');
  end;


  if not assigned(EC_KEY_METHOD_get_verify) then 
  begin
    {$if declared(EC_KEY_METHOD_get_verify_introduced)}
    if LibVersion < EC_KEY_METHOD_get_verify_introduced then
      {$if declared(FC_EC_KEY_METHOD_get_verify)}
      EC_KEY_METHOD_get_verify := @FC_EC_KEY_METHOD_get_verify
      {$else}
      EC_KEY_METHOD_get_verify := @ERR_EC_KEY_METHOD_get_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(EC_KEY_METHOD_get_verify_removed)}
   if EC_KEY_METHOD_get_verify_removed <= LibVersion then
     {$if declared(_EC_KEY_METHOD_get_verify)}
     EC_KEY_METHOD_get_verify := @_EC_KEY_METHOD_get_verify
     {$else}
       {$IF declared(ERR_EC_KEY_METHOD_get_verify)}
       EC_KEY_METHOD_get_verify := @ERR_EC_KEY_METHOD_get_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(EC_KEY_METHOD_get_verify) and Assigned(AFailed) then 
     AFailed.Add('EC_KEY_METHOD_get_verify');
  end;


end;

procedure Unload;
begin
  EC_GFp_simple_method := nil;
  EC_GFp_mont_method := nil;
  EC_GFp_nist_method := nil;
  EC_GFp_nistp224_method := nil; {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp256_method := nil; {introduced 1.1.0 removed 3.0.0}
  EC_GFp_nistp521_method := nil; {introduced 1.1.0 removed 3.0.0}
  EC_GF2m_simple_method := nil;
  EC_GROUP_new := nil;
  EC_GROUP_free := nil;
  EC_GROUP_clear_free := nil;
  EC_GROUP_copy := nil;
  EC_GROUP_dup := nil;
  EC_GROUP_method_of := nil;
  EC_METHOD_get_field_type := nil;
  EC_GROUP_set_generator := nil;
  EC_GROUP_get0_generator := nil;
  EC_GROUP_get_mont_data := nil;
  EC_GROUP_get_order := nil;
  EC_GROUP_get0_order := nil; {introduced 1.1.0}
  EC_GROUP_order_bits := nil; {introduced 1.1.0}
  EC_GROUP_get_cofactor := nil;
  EC_GROUP_get0_cofactor := nil; {introduced 1.1.0}
  EC_GROUP_set_curve_name := nil;
  EC_GROUP_get_curve_name := nil;
  EC_GROUP_set_asn1_flag := nil;
  EC_GROUP_get_asn1_flag := nil;
  EC_GROUP_set_point_conversion_form := nil;
  EC_GROUP_get_point_conversion_form := nil;
  EC_GROUP_get0_seed := nil;
  EC_GROUP_get_seed_len := nil;
  EC_GROUP_set_seed := nil;
  EC_GROUP_set_curve := nil; {introduced 1.1.0}
  EC_GROUP_get_curve := nil; {introduced 1.1.0}
  EC_GROUP_set_curve_GFp := nil;
  EC_GROUP_get_curve_GFp := nil;
  EC_GROUP_set_curve_GF2m := nil;
  EC_GROUP_get_curve_GF2m := nil;
  EC_GROUP_get_degree := nil;
  EC_GROUP_check := nil;
  EC_GROUP_check_discriminant := nil;
  EC_GROUP_cmp := nil;
  EC_GROUP_new_curve_GFp := nil;
  EC_GROUP_new_curve_GF2m := nil;
  EC_GROUP_new_by_curve_name := nil;
  EC_GROUP_new_from_ecparameters := nil; {introduced 1.1.0}
  EC_GROUP_get_ecparameters := nil; {introduced 1.1.0}
  EC_GROUP_new_from_ecpkparameters := nil; {introduced 1.1.0}
  EC_GROUP_get_ecpkparameters := nil; {introduced 1.1.0}
  EC_get_builtin_curves := nil;
  EC_curve_nid2nist := nil;
  EC_curve_nist2nid := nil;
  EC_POINT_new := nil;
  EC_POINT_free := nil;
  EC_POINT_clear_free := nil;
  EC_POINT_copy := nil;
  EC_POINT_dup := nil;
  EC_POINT_method_of := nil;
  EC_POINT_set_to_infinity := nil;
  EC_POINT_set_Jprojective_coordinates_GFp := nil;
  EC_POINT_get_Jprojective_coordinates_GFp := nil;
  EC_POINT_set_affine_coordinates := nil; {introduced 1.1.0}
  EC_POINT_get_affine_coordinates := nil; {introduced 1.1.0}
  EC_POINT_set_affine_coordinates_GFp := nil;
  EC_POINT_get_affine_coordinates_GFp := nil;
  EC_POINT_set_compressed_coordinates := nil; {introduced 1.1.0}
  EC_POINT_set_compressed_coordinates_GFp := nil;
  EC_POINT_set_affine_coordinates_GF2m := nil;
  EC_POINT_get_affine_coordinates_GF2m := nil;
  EC_POINT_set_compressed_coordinates_GF2m := nil;
  EC_POINT_point2oct := nil;
  EC_POINT_oct2point := nil;
  EC_POINT_point2buf := nil; {introduced 1.1.0}
  EC_POINT_point2bn := nil;
  EC_POINT_bn2point := nil;
  EC_POINT_point2hex := nil;
  EC_POINT_hex2point := nil;
  EC_POINT_add := nil;
  EC_POINT_dbl := nil;
  EC_POINT_invert := nil;
  EC_POINT_is_at_infinity := nil;
  EC_POINT_is_on_curve := nil;
  EC_POINT_cmp := nil;
  EC_POINT_make_affine := nil;
  EC_POINTs_make_affine := nil;
  EC_POINTs_mul := nil;
  EC_POINT_mul := nil;
  EC_GROUP_precompute_mult := nil;
  EC_GROUP_have_precompute_mult := nil;
  ECPKPARAMETERS_it := nil;
  ECPKPARAMETERS_new := nil;
  ECPKPARAMETERS_free := nil;
  ECPARAMETERS_it := nil;
  ECPARAMETERS_new := nil;
  ECPARAMETERS_free := nil;
  EC_GROUP_get_basis_type := nil;
  EC_GROUP_get_trinomial_basis := nil;
  EC_GROUP_get_pentanomial_basis := nil;
  d2i_ECPKParameters := nil;
  i2d_ECPKParameters := nil;
  ECPKParameters_print := nil;
  EC_KEY_new := nil;
  EC_KEY_get_flags := nil;
  EC_KEY_set_flags := nil;
  EC_KEY_clear_flags := nil;
  EC_KEY_new_by_curve_name := nil;
  EC_KEY_free := nil;
  EC_KEY_copy := nil;
  EC_KEY_dup := nil;
  EC_KEY_up_ref := nil;
  EC_KEY_get0_engine := nil; {introduced 1.1.0}
  EC_KEY_get0_group := nil;
  EC_KEY_set_group := nil;
  EC_KEY_get0_private_key := nil;
  EC_KEY_set_private_key := nil;
  EC_KEY_get0_public_key := nil;
  EC_KEY_set_public_key := nil;
  EC_KEY_get_enc_flags := nil;
  EC_KEY_set_enc_flags := nil;
  EC_KEY_get_conv_form := nil;
  EC_KEY_set_conv_form := nil;
  EC_KEY_set_ex_data := nil; {introduced 1.1.0}
  EC_KEY_get_ex_data := nil; {introduced 1.1.0}
  EC_KEY_set_asn1_flag := nil;
  EC_KEY_precompute_mult := nil;
  EC_KEY_generate_key := nil;
  EC_KEY_check_key := nil;
  EC_KEY_can_sign := nil; {introduced 1.1.0}
  EC_KEY_set_public_key_affine_coordinates := nil;
  EC_KEY_key2buf := nil; {introduced 1.1.0}
  EC_KEY_oct2key := nil; {introduced 1.1.0}
  EC_KEY_oct2priv := nil; {introduced 1.1.0}
  EC_KEY_priv2oct := nil; {introduced 1.1.0}
  EC_KEY_priv2buf := nil; {introduced 1.1.0}
  d2i_ECPrivateKey := nil;
  i2d_ECPrivateKey := nil;
  o2i_ECPublicKey := nil;
  i2o_ECPublicKey := nil;
  ECParameters_print := nil;
  EC_KEY_print := nil;
  EC_KEY_OpenSSL := nil; {introduced 1.1.0}
  EC_KEY_get_default_method := nil; {introduced 1.1.0}
  EC_KEY_set_default_method := nil; {introduced 1.1.0}
  EC_KEY_get_method := nil; {introduced 1.1.0}
  EC_KEY_set_method := nil; {introduced 1.1.0}
  EC_KEY_new_method := nil; {introduced 1.1.0}
  ECDH_KDF_X9_62 := nil;
  ECDH_compute_key := nil;
  ECDSA_SIG_new := nil;
  ECDSA_SIG_free := nil;
  i2d_ECDSA_SIG := nil;
  d2i_ECDSA_SIG := nil;
  ECDSA_SIG_get0 := nil; {introduced 1.1.0}
  ECDSA_SIG_get0_r := nil; {introduced 1.1.0}
  ECDSA_SIG_get0_s := nil; {introduced 1.1.0}
  ECDSA_SIG_set0 := nil; {introduced 1.1.0}
  ECDSA_do_sign := nil;
  ECDSA_do_sign_ex := nil;
  ECDSA_do_verify := nil;
  ECDSA_sign_setup := nil;
  ECDSA_sign := nil;
  ECDSA_sign_ex := nil;
  ECDSA_verify := nil;
  ECDSA_size := nil;
  EC_KEY_METHOD_new := nil; {introduced 1.1.0}
  EC_KEY_METHOD_free := nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_init := nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_keygen := nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_compute_key := nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_sign := nil; {introduced 1.1.0}
  EC_KEY_METHOD_set_verify := nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_init := nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_keygen := nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_compute_key := nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_sign := nil; {introduced 1.1.0}
  EC_KEY_METHOD_get_verify := nil; {introduced 1.1.0}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
