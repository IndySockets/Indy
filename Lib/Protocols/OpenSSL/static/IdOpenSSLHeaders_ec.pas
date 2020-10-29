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

// Generation date: 29.10.2020 09:34:09

unit IdOpenSSLHeaders_ec;

interface

// Headers for OpenSSL 1.1.1
// ec.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
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

  EC_KEY_METHOD_sign_sign = function(&type: TIdC_INT; const dgst: PByte; dlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const r: PBIGNUM; eckey: PEC_KEY): TIdC_INT; cdecl;
  EC_KEY_METHOD_sign_sign_setup = function(eckey: PEC_KEY; ctx_in: PBN_CTX; kinvp: PPBIGNUM; rp: PPBIGNUM): TIdC_INT; cdecl;
  EC_KEY_METHOD_sign_sign_sig = function(const dgst: PByte; dgst_len: TIdC_INT; const in_kinv: PBIGNUM; const in_r: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG; cdecl;

  EC_KEY_METHOD_verify_verify = function(&type: TIdC_INT; const dgst: PByte; dgst_len: TIdC_INT; const sigbuf: PByte; sig_len: TIdC_INT; eckey: PEC_KEY): TIdC_INT; cdecl;
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

  function EC_GFp_simple_method: PEC_METHOD cdecl; external CLibCrypto;
  function EC_GFp_mont_method: PEC_METHOD cdecl; external CLibCrypto;
  function EC_GFp_nist_method: PEC_METHOD cdecl; external CLibCrypto;
  function EC_GFp_nistp224_method: PEC_METHOD cdecl; external CLibCrypto;
  function EC_GFp_nistp256_method: PEC_METHOD cdecl; external CLibCrypto;
  function EC_GFp_nistp521_method: PEC_METHOD cdecl; external CLibCrypto;

  function EC_GF2m_simple_method: PEC_METHOD cdecl; external CLibCrypto;

  function EC_GROUP_new(const meth: PEC_METHOD): PEC_GROUP cdecl; external CLibCrypto;
  procedure EC_GROUP_free(group: PEC_GROUP) cdecl; external CLibCrypto;
  procedure EC_GROUP_clear_free(group: PEC_GROUP) cdecl; external CLibCrypto;
  function EC_GROUP_copy(dst: PEC_GROUP; const src: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_dup(const src: PEC_GROUP): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_method_of(const group: PEC_GROUP): PEC_GROUP cdecl; external CLibCrypto;
  function EC_METHOD_get_field_type(const meth: PEC_METHOD): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_set_generator(group: PEC_GROUP; const generator: PEC_POINT; const order: PBIGNUM; const cofactor: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get0_generator(const group: PEC_GROUP): PEC_POINT cdecl; external CLibCrypto;
  function EC_GROUP_get_mont_data(const group: PEC_GROUP): PBN_MONT_CTX cdecl; external CLibCrypto;
  function EC_GROUP_get_order(const group: PEC_GROUP; order: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get0_order(const group: PEC_GROUP): PBIGNUM cdecl; external CLibCrypto;
  function EC_GROUP_order_bits(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_cofactor(const group: PEC_GROUP; cofactor: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get0_cofactor(const group: PEC_GROUP): PBIGNUM cdecl; external CLibCrypto;
  procedure EC_GROUP_set_curve_name(group: PEC_GROUP; nid: TIdC_INT) cdecl; external CLibCrypto;
  function EC_GROUP_get_curve_name(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;

  procedure EC_GROUP_set_asn1_flag(group: PEC_GROUP; flag: TIdC_INT) cdecl; external CLibCrypto;
  function EC_GROUP_get_asn1_flag(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;

  procedure EC_GROUP_set_point_conversion_form(group: PEC_GROUP; form: point_conversion_form_t) cdecl; external CLibCrypto;
  function EC_GROUP_get_point_conversion_form(const group: PEC_GROUP): point_conversion_form_t cdecl; external CLibCrypto;

  function EC_GROUP_get0_seed(const x: PEC_GROUP): PByte cdecl; external CLibCrypto;
  function EC_GROUP_get_seed_len(const x: PEC_GROUP): TIdC_SIZET cdecl; external CLibCrypto;
  function EC_GROUP_set_seed(x: PEC_GROUP; const p: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;

  function EC_GROUP_set_curve(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_curve(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_set_curve_GFp(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_curve_GFp(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_set_curve_GF2m(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b:PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_curve_GF2m(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function EC_GROUP_get_degree(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_check(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_check_discriminant(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_cmp(const a: PEC_GROUP; const b: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function EC_GROUP_new_curve_GFp(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_new_curve_GF2m(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_new_by_curve_name(nid: TIdC_INT): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_new_from_ecparameters(const params: PECPARAMETERS): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_get_ecparameters(const group: PEC_GROUP; params: PECPARAMETERS): PECPARAMETERS cdecl; external CLibCrypto;
  function EC_GROUP_new_from_ecpkparameters(const params: PECPKPARAMETERS): PEC_GROUP cdecl; external CLibCrypto;
  function EC_GROUP_get_ecpkparameters(const group: PEC_GROUP; params: PECPKPARAMETERS): PECPKPARAMETERS cdecl; external CLibCrypto;

  function EC_get_builtin_curves(r: PEC_builtin_curve; nitems: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;

  function EC_curve_nid2nist(nid: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function EC_curve_nist2nid(const name: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;

  function EC_POINT_new(const group: PEC_GROUP): PEC_POINT cdecl; external CLibCrypto;
  procedure EC_POINT_free(point: PEC_POINT) cdecl; external CLibCrypto;
  procedure EC_POINT_clear_free(point: PEC_POINT) cdecl; external CLibCrypto;
  function EC_POINT_copy(dst: PEC_POINT; const src: PEC_POINT): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_dup(const src: PEC_POINT; const group: PEC_GROUP): PEC_POINT cdecl; external CLibCrypto;
  function EC_POINT_method_of(const point: PEC_POINT): PEC_METHOD cdecl; external CLibCrypto;
  function EC_POINT_set_to_infinity(const group: PEC_GROUP; point: PEC_POINT): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_Jprojective_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; const z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_get_Jprojective_coordinates_GFp(const group: PEC_METHOD; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_affine_coordinates(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_get_affine_coordinates(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_affine_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_get_affine_coordinates_GFp(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_compressed_coordinates(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_compressed_coordinates_GFp(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_affine_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_get_affine_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_set_compressed_coordinates_GF2m(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function EC_POINT_point2oct(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_SIZET cdecl; external CLibCrypto;
  function EC_POINT_oct2point(const group: PEC_GROUP; p: PEC_POINT; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_point2buf(const group: PEC_GROUP; const point: PEC_POINT; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl; external CLibCrypto;
  function EC_POINT_point2bn(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; bn: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl; external CLibCrypto;
  function EC_POINT_bn2point(const group: PEC_GROUP; const bn: PBIGNUM; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl; external CLibCrypto;
  function EC_POINT_point2hex(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; ctx: PBN_CTX): PIdAnsiChar cdecl; external CLibCrypto;
  function EC_POINT_hex2point(const group: PEC_GROUP; const buf: PIdAnsiChar; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl; external CLibCrypto;

  function EC_POINT_add(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_dbl(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_invert(const group: PEC_GROUP; a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_is_at_infinity(const group: PEC_GROUP; const p: PEC_POINT): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_is_on_curve(const group: PEC_GROUP; const point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_cmp(const group: PEC_GROUP; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_make_affine(const group: PEC_GROUP; point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINTs_make_affine(const group: PEC_METHOD; num: TIdC_SIZET; points: PPEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINTs_mul(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; num: TIdC_SIZET; const p: PPEC_POINT; const m: PPBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_POINT_mul(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; const q: PEC_POINT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function EC_GROUP_precompute_mult(group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_have_precompute_mult(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;

  function ECPKPARAMETERS_it: PASN1_ITEM cdecl; external CLibCrypto;
  function ECPKPARAMETERS_new: PECPKPARAMETERS cdecl; external CLibCrypto;
  procedure ECPKPARAMETERS_free(a: PECPKPARAMETERS) cdecl; external CLibCrypto;

  function ECPARAMETERS_it: PASN1_ITEM cdecl; external CLibCrypto;
  function ECPARAMETERS_new: PECPARAMETERS cdecl; external CLibCrypto;
  procedure ECPARAMETERS_free(a: PECPARAMETERS) cdecl; external CLibCrypto;

  function EC_GROUP_get_basis_type(const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_trinomial_basis(const group: PEC_GROUP; k: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;
  function EC_GROUP_get_pentanomial_basis(const group: PEC_GROUP; k1: PIdC_UINT; k2: PIdC_UINT; k3: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;

  function d2i_ECPKParameters(group: PPEC_GROUP; const in_: PPByte; len: TIdC_LONG): PEC_GROUP cdecl; external CLibCrypto;
  function i2d_ECPKParameters(const group: PEC_GROUP; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function ECPKParameters_print(bp: PBIO; const x: PEC_GROUP; off: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function EC_KEY_new: PEC_KEY cdecl; external CLibCrypto;
  function EC_KEY_get_flags(const key: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  procedure EC_KEY_set_flags(key: PEC_KEY; flags: TIdC_INT) cdecl; external CLibCrypto;
  procedure EC_KEY_clear_flags(key: PEC_KEY; flags: TIdC_INT) cdecl; external CLibCrypto;
  function EC_KEY_new_by_curve_name(nid: TIdC_INT): PEC_KEY cdecl; external CLibCrypto;
  procedure EC_KEY_free(key: PEC_KEY) cdecl; external CLibCrypto;
  function EC_KEY_copy(dst: PEC_KEY; const src: PEC_KEY): PEC_KEY cdecl; external CLibCrypto;
  function EC_KEY_dup(const src: PEC_KEY): PEC_KEY cdecl; external CLibCrypto;
  function EC_KEY_up_ref(key: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_get0_engine(const eckey: PEC_KEY): PENGINE cdecl; external CLibCrypto;
  function EC_KEY_get0_group(const key: PEC_KEY): PEC_GROUP cdecl; external CLibCrypto;
  function EC_KEY_set_group(key: PEC_KEY; const group: PEC_GROUP): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_get0_private_key(const key: PEC_KEY): PBIGNUM cdecl; external CLibCrypto;
  function EC_KEY_set_private_key(const key: PEC_KEY; const prv: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_get0_public_key(const key: PEC_KEY): PEC_POINT cdecl; external CLibCrypto;
  function EC_KEY_set_public_key(key: PEC_KEY; const pub: PEC_POINT): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_get_enc_flags(const key: PEC_KEY): TIdC_UINT cdecl; external CLibCrypto;
  procedure EC_KEY_set_enc_flags(eckey: PEC_KEY; flags: TIdC_UINT) cdecl; external CLibCrypto;
  function EC_KEY_get_conv_form(const key: PEC_KEY): point_conversion_form_t cdecl; external CLibCrypto;
  procedure EC_KEY_set_conv_form(eckey: PEC_KEY; cform: point_conversion_form_t) cdecl; external CLibCrypto;
  function EC_KEY_set_ex_data(key: PEC_KEY; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_get_ex_data(const key: PEC_KEY; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;
  procedure EC_KEY_set_asn1_flag(eckey: PEC_KEY; asn1_flag: TIdC_INT) cdecl; external CLibCrypto;
  function EC_KEY_precompute_mult(key: PEC_KEY; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_generate_key(key: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_check_key(const key: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_can_sign(const eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_set_public_key_affine_coordinates(key: PEC_KEY; x: PBIGNUM; y: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_key2buf(const key: PEC_KEY; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl; external CLibCrypto;
  function EC_KEY_oct2key(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_oct2priv(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_priv2oct(const key: PEC_KEY; buf: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;
  function EC_KEY_priv2buf(const eckey: PEC_KEY; buf: PPByte): TIdC_SIZET cdecl; external CLibCrypto;

  function d2i_ECPrivateKey(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl; external CLibCrypto;
  function i2d_ECPrivateKey(key: PEC_KEY; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function o2i_ECPublicKey(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl; external CLibCrypto;
  function i2o_ECPublicKey(const key: PEC_KEY; out_: PPByte): TIdC_INT cdecl; external CLibCrypto;

  function ECParameters_print(bp: PBIO; const key: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_print(bp: PBIO; const key: PEC_KEY; off: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function EC_KEY_OpenSSL: PEC_KEY_METHOD cdecl; external CLibCrypto;
  function EC_KEY_get_default_method: PEC_KEY_METHOD cdecl; external CLibCrypto;
  procedure EC_KEY_set_default_method(const meth: PEC_KEY_METHOD) cdecl; external CLibCrypto;
  function EC_KEY_get_method(const key: PEC_KEY): PEC_KEY_METHOD cdecl; external CLibCrypto;
  function EC_KEY_set_method(key: PEC_KEY; const meth: PEC_KEY_METHOD): TIdC_INT cdecl; external CLibCrypto;
  function EC_KEY_new_method(engine: PENGINE): PEC_KEY cdecl; external CLibCrypto;

  function ECDH_KDF_X9_62(&out: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; const sinfo: PByte; sinfolen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function ECDH_compute_key(&out: Pointer; oulen: TIdC_SIZET; const pub_key: PEC_POINT; const ecdh: PEC_KEY; kdf: ECDH_compute_key_KDF): TIdC_INT cdecl; external CLibCrypto;

  function ECDSA_SIG_new: PECDSA_SIG cdecl; external CLibCrypto;
  procedure ECDSA_SIG_free(sig: PECDSA_SIG) cdecl; external CLibCrypto;
  function i2d_ECDSA_SIG(const sig: PECDSA_SIG; pp: PPByte): TIdC_INT cdecl; external CLibCrypto;
  function d2i_ECDSA_SIG(sig: PPECDSA_SIG; const pp: PPByte; len: TIdC_LONG): PECDSA_SIG cdecl; external CLibCrypto;
  procedure ECDSA_SIG_get0(const sig: PECDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM) cdecl; external CLibCrypto;
  function ECDSA_SIG_get0_r(const sig: PECDSA_SIG): PBIGNUM cdecl; external CLibCrypto;
  function ECDSA_SIG_get0_s(const sig: PECDSA_SIG): PBIGNUM cdecl; external CLibCrypto;
  function ECDSA_SIG_set0(sig: PECDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_do_sign(const dgst: PByte; dgst_len: TIdC_INT; eckey: PEC_KEY): PECDSA_SIG cdecl; external CLibCrypto;
  function ECDSA_do_sign_ex(const dgst: PByte; dgst_len: TIdC_INT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG cdecl; external CLibCrypto;
  function ECDSA_do_verify(const dgst: PByte; dgst_len: TIdC_INT; const sig: PECDSA_SIG; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_sign_setup(eckey: PEC_KEY; ctx: PBN_CTX; kiv: PPBIGNUM; rp: PPBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_sign(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_sign_ex(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_verify(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; const sig: PByte; siglen: TIdC_INT; eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;
  function ECDSA_size(const eckey: PEC_KEY): TIdC_INT cdecl; external CLibCrypto;

  function EC_KEY_METHOD_new(const meth: PEC_KEY_METHOD): PEC_KEY_METHOD cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_free(meth: PEC_KEY_METHOD) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_set_init(meth: PEC_KEY_METHOD; init: EC_KEY_METHOD_init_init; finish: EC_KEY_METHOD_init_finish; copy: EC_KEY_METHOD_init_copy; set_group: EC_KEY_METHOD_init_set_group; set_private: EC_KEY_METHOD_init_set_private; set_public: EC_KEY_METHOD_init_set_public) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_set_keygen(meth: PEC_KEY_METHOD; keygen: EC_KEY_METHOD_keygen_keygen) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_set_compute_key(meth: PEC_KEY_METHOD; ckey: EC_KEY_METHOD_compute_key_ckey) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_set_sign(meth: PEC_KEY_METHOD; sign: EC_KEY_METHOD_sign_sign; sign_setup: EC_KEY_METHOD_sign_sign_setup; sign_sig: EC_KEY_METHOD_sign_sign_sig) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_set_verify(meth: PEC_KEY_METHOD; verify: EC_KEY_METHOD_verify_verify; verify_sig: EC_KEY_METHOD_verify_verify_sig) cdecl; external CLibCrypto;

  procedure EC_KEY_METHOD_get_init(const meth: PEC_KEY_METHOD; pinit: PEC_KEY_METHOD_init_init; pfinish: PEC_KEY_METHOD_init_finish; pcopy: PEC_KEY_METHOD_init_copy; pset_group: PEC_KEY_METHOD_init_set_group; pset_private: PEC_KEY_METHOD_init_set_private; pset_public: PEC_KEY_METHOD_init_set_public) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_get_keygen(const meth: PEC_KEY_METHOD; pkeygen: PEC_KEY_METHOD_keygen_keygen) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_get_compute_key(const meth: PEC_KEY_METHOD; pck: PEC_KEY_METHOD_compute_key_ckey) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_get_sign(const meth: PEC_KEY_METHOD; psign: PEC_KEY_METHOD_sign_sign; psign_setup: PEC_KEY_METHOD_sign_sign_setup; psign_sig: PEC_KEY_METHOD_sign_sign_sig) cdecl; external CLibCrypto;
  procedure EC_KEY_METHOD_get_verify(const meth: PEC_KEY_METHOD; pverify: PEC_KEY_METHOD_verify_verify; pverify_sig: PEC_KEY_METHOD_verify_verify_sig) cdecl; external CLibCrypto;

implementation

end.
