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

// Generation date: 29.10.2020 09:34:06

unit IdOpenSSLHeaders_ec;

interface

// Headers for OpenSSL 1.1.1
// ec.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  EC_GFp_simple_method: function: PEC_METHOD cdecl = nil;
  EC_GFp_mont_method: function: PEC_METHOD cdecl = nil;
  EC_GFp_nist_method: function: PEC_METHOD cdecl = nil;
  EC_GFp_nistp224_method: function: PEC_METHOD cdecl = nil;
  EC_GFp_nistp256_method: function: PEC_METHOD cdecl = nil;
  EC_GFp_nistp521_method: function: PEC_METHOD cdecl = nil;

  EC_GF2m_simple_method: function: PEC_METHOD cdecl = nil;

  EC_GROUP_new: function(const meth: PEC_METHOD): PEC_GROUP cdecl = nil;
  EC_GROUP_free: procedure(group: PEC_GROUP) cdecl = nil;
  EC_GROUP_clear_free: procedure(group: PEC_GROUP) cdecl = nil;
  EC_GROUP_copy: function(dst: PEC_GROUP; const src: PEC_GROUP): TIdC_INT cdecl = nil;
  EC_GROUP_dup: function(const src: PEC_GROUP): PEC_GROUP cdecl = nil;
  EC_GROUP_method_of: function(const group: PEC_GROUP): PEC_GROUP cdecl = nil;
  EC_METHOD_get_field_type: function(const meth: PEC_METHOD): TIdC_INT cdecl = nil;
  EC_GROUP_set_generator: function(group: PEC_GROUP; const generator: PEC_POINT; const order: PBIGNUM; const cofactor: PBIGNUM): TIdC_INT cdecl = nil;
  EC_GROUP_get0_generator: function(const group: PEC_GROUP): PEC_POINT cdecl = nil;
  EC_GROUP_get_mont_data: function(const group: PEC_GROUP): PBN_MONT_CTX cdecl = nil;
  EC_GROUP_get_order: function(const group: PEC_GROUP; order: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_get0_order: function(const group: PEC_GROUP): PBIGNUM cdecl = nil;
  EC_GROUP_order_bits: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;
  EC_GROUP_get_cofactor: function(const group: PEC_GROUP; cofactor: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_get0_cofactor: function(const group: PEC_GROUP): PBIGNUM cdecl = nil;
  EC_GROUP_set_curve_name: procedure(group: PEC_GROUP; nid: TIdC_INT) cdecl = nil;
  EC_GROUP_get_curve_name: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;

  EC_GROUP_set_asn1_flag: procedure(group: PEC_GROUP; flag: TIdC_INT) cdecl = nil;
  EC_GROUP_get_asn1_flag: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;

  EC_GROUP_set_point_conversion_form: procedure(group: PEC_GROUP; form: point_conversion_form_t) cdecl = nil;
  EC_GROUP_get_point_conversion_form: function(const group: PEC_GROUP): point_conversion_form_t cdecl = nil;

  EC_GROUP_get0_seed: function(const x: PEC_GROUP): PByte cdecl = nil;
  EC_GROUP_get_seed_len: function(const x: PEC_GROUP): TIdC_SIZET cdecl = nil;
  EC_GROUP_set_seed: function(x: PEC_GROUP; const p: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl = nil;

  EC_GROUP_set_curve: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_get_curve: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_set_curve_GFp: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_get_curve_GFp: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_set_curve_GF2m: function(group: PEC_GROUP; const p: PBIGNUM; const a: PBIGNUM; const b:PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_get_curve_GF2m: function(const group: PEC_GROUP; p: PBIGNUM; a: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  EC_GROUP_get_degree: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;
  EC_GROUP_check: function(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_check_discriminant: function(const group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_cmp: function(const a: PEC_GROUP; const b: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  EC_GROUP_new_curve_GFp: function(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl = nil;
  EC_GROUP_new_curve_GF2m: function(const p: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): PEC_GROUP cdecl = nil;
  EC_GROUP_new_by_curve_name: function(nid: TIdC_INT): PEC_GROUP cdecl = nil;
  EC_GROUP_new_from_ecparameters: function(const params: PECPARAMETERS): PEC_GROUP cdecl = nil;
  EC_GROUP_get_ecparameters: function(const group: PEC_GROUP; params: PECPARAMETERS): PECPARAMETERS cdecl = nil;
  EC_GROUP_new_from_ecpkparameters: function(const params: PECPKPARAMETERS): PEC_GROUP cdecl = nil;
  EC_GROUP_get_ecpkparameters: function(const group: PEC_GROUP; params: PECPKPARAMETERS): PECPKPARAMETERS cdecl = nil;

  EC_get_builtin_curves: function(r: PEC_builtin_curve; nitems: TIdC_SIZET): TIdC_SIZET cdecl = nil;

  EC_curve_nid2nist: function(nid: TIdC_INT): PIdAnsiChar cdecl = nil;
  EC_curve_nist2nid: function(const name: PIdAnsiChar): TIdC_INT cdecl = nil;

  EC_POINT_new: function(const group: PEC_GROUP): PEC_POINT cdecl = nil;
  EC_POINT_free: procedure(point: PEC_POINT) cdecl = nil;
  EC_POINT_clear_free: procedure(point: PEC_POINT) cdecl = nil;
  EC_POINT_copy: function(dst: PEC_POINT; const src: PEC_POINT): TIdC_INT cdecl = nil;
  EC_POINT_dup: function(const src: PEC_POINT; const group: PEC_GROUP): PEC_POINT cdecl = nil;
  EC_POINT_method_of: function(const point: PEC_POINT): PEC_METHOD cdecl = nil;
  EC_POINT_set_to_infinity: function(const group: PEC_GROUP; point: PEC_POINT): TIdC_INT cdecl = nil;
  EC_POINT_set_Jprojective_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; const z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_get_Jprojective_coordinates_GFp: function(const group: PEC_METHOD; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; z: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_affine_coordinates: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_get_affine_coordinates: function(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_affine_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_get_affine_coordinates_GFp: function(const group: PEC_GROUP; const p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_compressed_coordinates: function(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_compressed_coordinates_GFp: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_affine_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; const y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_get_affine_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; x: PBIGNUM; y: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_set_compressed_coordinates_GF2m: function(const group: PEC_GROUP; p: PEC_POINT; const x: PBIGNUM; y_bit: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  EC_POINT_point2oct: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_SIZET cdecl = nil;
  EC_POINT_oct2point: function(const group: PEC_GROUP; p: PEC_POINT; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_point2buf: function(const group: PEC_GROUP; const point: PEC_POINT; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl = nil;
  EC_POINT_point2bn: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; bn: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl = nil;
  EC_POINT_bn2point: function(const group: PEC_GROUP; const bn: PBIGNUM; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl = nil;
  EC_POINT_point2hex: function(const group: PEC_GROUP; const p: PEC_POINT; form: point_conversion_form_t; ctx: PBN_CTX): PIdAnsiChar cdecl = nil;
  EC_POINT_hex2point: function(const group: PEC_GROUP; const buf: PIdAnsiChar; p: PEC_POINT; ctx: PBN_CTX): PEC_POINT cdecl = nil;

  EC_POINT_add: function(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_dbl: function(const group: PEC_GROUP; r: PEC_POINT; const a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_invert: function(const group: PEC_GROUP; a: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_is_at_infinity: function(const group: PEC_GROUP; const p: PEC_POINT): TIdC_INT cdecl = nil;
  EC_POINT_is_on_curve: function(const group: PEC_GROUP; const point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_cmp: function(const group: PEC_GROUP; const a: PEC_POINT; const b: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_make_affine: function(const group: PEC_GROUP; point: PEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINTs_make_affine: function(const group: PEC_METHOD; num: TIdC_SIZET; points: PPEC_POINT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINTs_mul: function(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; num: TIdC_SIZET; const p: PPEC_POINT; const m: PPBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_POINT_mul: function(const group: PEC_GROUP; r: PEC_POINT; const n: PBIGNUM; const q: PEC_POINT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  EC_GROUP_precompute_mult: function(group: PEC_GROUP; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_GROUP_have_precompute_mult: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;

  ECPKPARAMETERS_it: function: PASN1_ITEM cdecl = nil;
  ECPKPARAMETERS_new: function: PECPKPARAMETERS cdecl = nil;
  ECPKPARAMETERS_free: procedure(a: PECPKPARAMETERS) cdecl = nil;

  ECPARAMETERS_it: function: PASN1_ITEM cdecl = nil;
  ECPARAMETERS_new: function: PECPARAMETERS cdecl = nil;
  ECPARAMETERS_free: procedure(a: PECPARAMETERS) cdecl = nil;

  EC_GROUP_get_basis_type: function(const group: PEC_GROUP): TIdC_INT cdecl = nil;
  EC_GROUP_get_trinomial_basis: function(const group: PEC_GROUP; k: PIdC_UINT): TIdC_INT cdecl = nil;
  EC_GROUP_get_pentanomial_basis: function(const group: PEC_GROUP; k1: PIdC_UINT; k2: PIdC_UINT; k3: PIdC_UINT): TIdC_INT cdecl = nil;

  d2i_ECPKParameters: function(group: PPEC_GROUP; const in_: PPByte; len: TIdC_LONG): PEC_GROUP cdecl = nil;
  i2d_ECPKParameters: function(const group: PEC_GROUP; out_: PPByte): TIdC_INT cdecl = nil;

  ECPKParameters_print: function(bp: PBIO; const x: PEC_GROUP; off: TIdC_INT): TIdC_INT cdecl = nil;

  EC_KEY_new: function: PEC_KEY cdecl = nil;
  EC_KEY_get_flags: function(const key: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_set_flags: procedure(key: PEC_KEY; flags: TIdC_INT) cdecl = nil;
  EC_KEY_clear_flags: procedure(key: PEC_KEY; flags: TIdC_INT) cdecl = nil;
  EC_KEY_new_by_curve_name: function(nid: TIdC_INT): PEC_KEY cdecl = nil;
  EC_KEY_free: procedure(key: PEC_KEY) cdecl = nil;
  EC_KEY_copy: function(dst: PEC_KEY; const src: PEC_KEY): PEC_KEY cdecl = nil;
  EC_KEY_dup: function(const src: PEC_KEY): PEC_KEY cdecl = nil;
  EC_KEY_up_ref: function(key: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_get0_engine: function(const eckey: PEC_KEY): PENGINE cdecl = nil;
  EC_KEY_get0_group: function(const key: PEC_KEY): PEC_GROUP cdecl = nil;
  EC_KEY_set_group: function(key: PEC_KEY; const group: PEC_GROUP): TIdC_INT cdecl = nil;
  EC_KEY_get0_private_key: function(const key: PEC_KEY): PBIGNUM cdecl = nil;
  EC_KEY_set_private_key: function(const key: PEC_KEY; const prv: PBIGNUM): TIdC_INT cdecl = nil;
  EC_KEY_get0_public_key: function(const key: PEC_KEY): PEC_POINT cdecl = nil;
  EC_KEY_set_public_key: function(key: PEC_KEY; const pub: PEC_POINT): TIdC_INT cdecl = nil;
  EC_KEY_get_enc_flags: function(const key: PEC_KEY): TIdC_UINT cdecl = nil;
  EC_KEY_set_enc_flags: procedure(eckey: PEC_KEY; flags: TIdC_UINT) cdecl = nil;
  EC_KEY_get_conv_form: function(const key: PEC_KEY): point_conversion_form_t cdecl = nil;
  EC_KEY_set_conv_form: procedure(eckey: PEC_KEY; cform: point_conversion_form_t) cdecl = nil;
  EC_KEY_set_ex_data: function(key: PEC_KEY; idx: TIdC_INT; arg: Pointer): TIdC_INT cdecl = nil;
  EC_KEY_get_ex_data: function(const key: PEC_KEY; idx: TIdC_INT): Pointer cdecl = nil;
  EC_KEY_set_asn1_flag: procedure(eckey: PEC_KEY; asn1_flag: TIdC_INT) cdecl = nil;
  EC_KEY_precompute_mult: function(key: PEC_KEY; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_KEY_generate_key: function(key: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_check_key: function(const key: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_can_sign: function(const eckey: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_set_public_key_affine_coordinates: function(key: PEC_KEY; x: PBIGNUM; y: PBIGNUM): TIdC_INT cdecl = nil;
  EC_KEY_key2buf: function(const key: PEC_KEY; form: point_conversion_form_t; pbuf: PPByte; ctx: PBN_CTX): TIdC_SIZET cdecl = nil;
  EC_KEY_oct2key: function(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  EC_KEY_oct2priv: function(key: PEC_KEY; const buf: PByte; len: TIdC_SIZET): TIdC_INT cdecl = nil;
  EC_KEY_priv2oct: function(const key: PEC_KEY; buf: PByte; len: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  EC_KEY_priv2buf: function(const eckey: PEC_KEY; buf: PPByte): TIdC_SIZET cdecl = nil;

  d2i_ECPrivateKey: function(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl = nil;
  i2d_ECPrivateKey: function(key: PEC_KEY; out_: PPByte): TIdC_INT cdecl = nil;
  o2i_ECPublicKey: function(key: PPEC_KEY; const in_: PPByte; len: TIdC_LONG): PEC_KEY cdecl = nil;
  i2o_ECPublicKey: function(const key: PEC_KEY; out_: PPByte): TIdC_INT cdecl = nil;

  ECParameters_print: function(bp: PBIO; const key: PEC_KEY): TIdC_INT cdecl = nil;
  EC_KEY_print: function(bp: PBIO; const key: PEC_KEY; off: TIdC_INT): TIdC_INT cdecl = nil;

  EC_KEY_OpenSSL: function: PEC_KEY_METHOD cdecl = nil;
  EC_KEY_get_default_method: function: PEC_KEY_METHOD cdecl = nil;
  EC_KEY_set_default_method: procedure(const meth: PEC_KEY_METHOD) cdecl = nil;
  EC_KEY_get_method: function(const key: PEC_KEY): PEC_KEY_METHOD cdecl = nil;
  EC_KEY_set_method: function(key: PEC_KEY; const meth: PEC_KEY_METHOD): TIdC_INT cdecl = nil;
  EC_KEY_new_method: function(engine: PENGINE): PEC_KEY cdecl = nil;

  ECDH_KDF_X9_62: function(&out: PByte; outlen: TIdC_SIZET; const Z: PByte; Zlen: TIdC_SIZET; const sinfo: PByte; sinfolen: TIdC_SIZET; const md: PEVP_MD): TIdC_INT cdecl = nil;
  ECDH_compute_key: function(&out: Pointer; oulen: TIdC_SIZET; const pub_key: PEC_POINT; const ecdh: PEC_KEY; kdf: ECDH_compute_key_KDF): TIdC_INT cdecl = nil;

  ECDSA_SIG_new: function: PECDSA_SIG cdecl = nil;
  ECDSA_SIG_free: procedure(sig: PECDSA_SIG) cdecl = nil;
  i2d_ECDSA_SIG: function(const sig: PECDSA_SIG; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ECDSA_SIG: function(sig: PPECDSA_SIG; const pp: PPByte; len: TIdC_LONG): PECDSA_SIG cdecl = nil;
  ECDSA_SIG_get0: procedure(const sig: PECDSA_SIG; const pr: PPBIGNUM; const ps: PPBIGNUM) cdecl = nil;
  ECDSA_SIG_get0_r: function(const sig: PECDSA_SIG): PBIGNUM cdecl = nil;
  ECDSA_SIG_get0_s: function(const sig: PECDSA_SIG): PBIGNUM cdecl = nil;
  ECDSA_SIG_set0: function(sig: PECDSA_SIG; r: PBIGNUM; s: PBIGNUM): TIdC_INT cdecl = nil;
  ECDSA_do_sign: function(const dgst: PByte; dgst_len: TIdC_INT; eckey: PEC_KEY): PECDSA_SIG cdecl = nil;
  ECDSA_do_sign_ex: function(const dgst: PByte; dgst_len: TIdC_INT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): PECDSA_SIG cdecl = nil;
  ECDSA_do_verify: function(const dgst: PByte; dgst_len: TIdC_INT; const sig: PECDSA_SIG; eckey: PEC_KEY): TIdC_INT cdecl = nil;
  ECDSA_sign_setup: function(eckey: PEC_KEY; ctx: PBN_CTX; kiv: PPBIGNUM; rp: PPBIGNUM): TIdC_INT cdecl = nil;
  ECDSA_sign: function(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; eckey: PEC_KEY): TIdC_INT cdecl = nil;
  ECDSA_sign_ex: function(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; sig: PByte; siglen: PIdC_UINT; const kinv: PBIGNUM; const rp: PBIGNUM; eckey: PEC_KEY): TIdC_INT cdecl = nil;
  ECDSA_verify: function(&type: TIdC_INT; const dgst: PByte; dgstlen: TIdC_INT; const sig: PByte; siglen: TIdC_INT; eckey: PEC_KEY): TIdC_INT cdecl = nil;
  ECDSA_size: function(const eckey: PEC_KEY): TIdC_INT cdecl = nil;

  EC_KEY_METHOD_new: function(const meth: PEC_KEY_METHOD): PEC_KEY_METHOD cdecl = nil;
  EC_KEY_METHOD_free: procedure(meth: PEC_KEY_METHOD) cdecl = nil;
  EC_KEY_METHOD_set_init: procedure(meth: PEC_KEY_METHOD; init: EC_KEY_METHOD_init_init; finish: EC_KEY_METHOD_init_finish; copy: EC_KEY_METHOD_init_copy; set_group: EC_KEY_METHOD_init_set_group; set_private: EC_KEY_METHOD_init_set_private; set_public: EC_KEY_METHOD_init_set_public) cdecl = nil;
  EC_KEY_METHOD_set_keygen: procedure(meth: PEC_KEY_METHOD; keygen: EC_KEY_METHOD_keygen_keygen) cdecl = nil;
  EC_KEY_METHOD_set_compute_key: procedure(meth: PEC_KEY_METHOD; ckey: EC_KEY_METHOD_compute_key_ckey) cdecl = nil;
  EC_KEY_METHOD_set_sign: procedure(meth: PEC_KEY_METHOD; sign: EC_KEY_METHOD_sign_sign; sign_setup: EC_KEY_METHOD_sign_sign_setup; sign_sig: EC_KEY_METHOD_sign_sign_sig) cdecl = nil;
  EC_KEY_METHOD_set_verify: procedure(meth: PEC_KEY_METHOD; verify: EC_KEY_METHOD_verify_verify; verify_sig: EC_KEY_METHOD_verify_verify_sig) cdecl = nil;

  EC_KEY_METHOD_get_init: procedure(const meth: PEC_KEY_METHOD; pinit: PEC_KEY_METHOD_init_init; pfinish: PEC_KEY_METHOD_init_finish; pcopy: PEC_KEY_METHOD_init_copy; pset_group: PEC_KEY_METHOD_init_set_group; pset_private: PEC_KEY_METHOD_init_set_private; pset_public: PEC_KEY_METHOD_init_set_public) cdecl = nil;
  EC_KEY_METHOD_get_keygen: procedure(const meth: PEC_KEY_METHOD; pkeygen: PEC_KEY_METHOD_keygen_keygen) cdecl = nil;
  EC_KEY_METHOD_get_compute_key: procedure(const meth: PEC_KEY_METHOD; pck: PEC_KEY_METHOD_compute_key_ckey) cdecl = nil;
  EC_KEY_METHOD_get_sign: procedure(const meth: PEC_KEY_METHOD; psign: PEC_KEY_METHOD_sign_sign; psign_setup: PEC_KEY_METHOD_sign_sign_setup; psign_sig: PEC_KEY_METHOD_sign_sign_sig) cdecl = nil;
  EC_KEY_METHOD_get_verify: procedure(const meth: PEC_KEY_METHOD; pverify: PEC_KEY_METHOD_verify_verify; pverify_sig: PEC_KEY_METHOD_verify_verify_sig) cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  EC_GFp_simple_method := LoadFunction('EC_GFp_simple_method', AFailed);
  EC_GFp_mont_method := LoadFunction('EC_GFp_mont_method', AFailed);
  EC_GFp_nist_method := LoadFunction('EC_GFp_nist_method', AFailed);
  EC_GFp_nistp224_method := LoadFunction('EC_GFp_nistp224_method', AFailed);
  EC_GFp_nistp256_method := LoadFunction('EC_GFp_nistp256_method', AFailed);
  EC_GFp_nistp521_method := LoadFunction('EC_GFp_nistp521_method', AFailed);
  EC_GF2m_simple_method := LoadFunction('EC_GF2m_simple_method', AFailed);
  EC_GROUP_new := LoadFunction('EC_GROUP_new', AFailed);
  EC_GROUP_free := LoadFunction('EC_GROUP_free', AFailed);
  EC_GROUP_clear_free := LoadFunction('EC_GROUP_clear_free', AFailed);
  EC_GROUP_copy := LoadFunction('EC_GROUP_copy', AFailed);
  EC_GROUP_dup := LoadFunction('EC_GROUP_dup', AFailed);
  EC_GROUP_method_of := LoadFunction('EC_GROUP_method_of', AFailed);
  EC_METHOD_get_field_type := LoadFunction('EC_METHOD_get_field_type', AFailed);
  EC_GROUP_set_generator := LoadFunction('EC_GROUP_set_generator', AFailed);
  EC_GROUP_get0_generator := LoadFunction('EC_GROUP_get0_generator', AFailed);
  EC_GROUP_get_mont_data := LoadFunction('EC_GROUP_get_mont_data', AFailed);
  EC_GROUP_get_order := LoadFunction('EC_GROUP_get_order', AFailed);
  EC_GROUP_get0_order := LoadFunction('EC_GROUP_get0_order', AFailed);
  EC_GROUP_order_bits := LoadFunction('EC_GROUP_order_bits', AFailed);
  EC_GROUP_get_cofactor := LoadFunction('EC_GROUP_get_cofactor', AFailed);
  EC_GROUP_get0_cofactor := LoadFunction('EC_GROUP_get0_cofactor', AFailed);
  EC_GROUP_set_curve_name := LoadFunction('EC_GROUP_set_curve_name', AFailed);
  EC_GROUP_get_curve_name := LoadFunction('EC_GROUP_get_curve_name', AFailed);
  EC_GROUP_set_asn1_flag := LoadFunction('EC_GROUP_set_asn1_flag', AFailed);
  EC_GROUP_get_asn1_flag := LoadFunction('EC_GROUP_get_asn1_flag', AFailed);
  EC_GROUP_set_point_conversion_form := LoadFunction('EC_GROUP_set_point_conversion_form', AFailed);
  EC_GROUP_get_point_conversion_form := LoadFunction('EC_GROUP_get_point_conversion_form', AFailed);
  EC_GROUP_get0_seed := LoadFunction('EC_GROUP_get0_seed', AFailed);
  EC_GROUP_get_seed_len := LoadFunction('EC_GROUP_get_seed_len', AFailed);
  EC_GROUP_set_seed := LoadFunction('EC_GROUP_set_seed', AFailed);
  EC_GROUP_set_curve := LoadFunction('EC_GROUP_set_curve', AFailed);
  EC_GROUP_get_curve := LoadFunction('EC_GROUP_get_curve', AFailed);
  EC_GROUP_set_curve_GFp := LoadFunction('EC_GROUP_set_curve_GFp', AFailed);
  EC_GROUP_get_curve_GFp := LoadFunction('EC_GROUP_get_curve_GFp', AFailed);
  EC_GROUP_set_curve_GF2m := LoadFunction('EC_GROUP_set_curve_GF2m', AFailed);
  EC_GROUP_get_curve_GF2m := LoadFunction('EC_GROUP_get_curve_GF2m', AFailed);
  EC_GROUP_get_degree := LoadFunction('EC_GROUP_get_degree', AFailed);
  EC_GROUP_check := LoadFunction('EC_GROUP_check', AFailed);
  EC_GROUP_check_discriminant := LoadFunction('EC_GROUP_check_discriminant', AFailed);
  EC_GROUP_cmp := LoadFunction('EC_GROUP_cmp', AFailed);
  EC_GROUP_new_curve_GFp := LoadFunction('EC_GROUP_new_curve_GFp', AFailed);
  EC_GROUP_new_curve_GF2m := LoadFunction('EC_GROUP_new_curve_GF2m', AFailed);
  EC_GROUP_new_by_curve_name := LoadFunction('EC_GROUP_new_by_curve_name', AFailed);
  EC_GROUP_new_from_ecparameters := LoadFunction('EC_GROUP_new_from_ecparameters', AFailed);
  EC_GROUP_get_ecparameters := LoadFunction('EC_GROUP_get_ecparameters', AFailed);
  EC_GROUP_new_from_ecpkparameters := LoadFunction('EC_GROUP_new_from_ecpkparameters', AFailed);
  EC_GROUP_get_ecpkparameters := LoadFunction('EC_GROUP_get_ecpkparameters', AFailed);
  EC_get_builtin_curves := LoadFunction('EC_get_builtin_curves', AFailed);
  EC_curve_nid2nist := LoadFunction('EC_curve_nid2nist', AFailed);
  EC_curve_nist2nid := LoadFunction('EC_curve_nist2nid', AFailed);
  EC_POINT_new := LoadFunction('EC_POINT_new', AFailed);
  EC_POINT_free := LoadFunction('EC_POINT_free', AFailed);
  EC_POINT_clear_free := LoadFunction('EC_POINT_clear_free', AFailed);
  EC_POINT_copy := LoadFunction('EC_POINT_copy', AFailed);
  EC_POINT_dup := LoadFunction('EC_POINT_dup', AFailed);
  EC_POINT_method_of := LoadFunction('EC_POINT_method_of', AFailed);
  EC_POINT_set_to_infinity := LoadFunction('EC_POINT_set_to_infinity', AFailed);
  EC_POINT_set_Jprojective_coordinates_GFp := LoadFunction('EC_POINT_set_Jprojective_coordinates_GFp', AFailed);
  EC_POINT_get_Jprojective_coordinates_GFp := LoadFunction('EC_POINT_get_Jprojective_coordinates_GFp', AFailed);
  EC_POINT_set_affine_coordinates := LoadFunction('EC_POINT_set_affine_coordinates', AFailed);
  EC_POINT_get_affine_coordinates := LoadFunction('EC_POINT_get_affine_coordinates', AFailed);
  EC_POINT_set_affine_coordinates_GFp := LoadFunction('EC_POINT_set_affine_coordinates_GFp', AFailed);
  EC_POINT_get_affine_coordinates_GFp := LoadFunction('EC_POINT_get_affine_coordinates_GFp', AFailed);
  EC_POINT_set_compressed_coordinates := LoadFunction('EC_POINT_set_compressed_coordinates', AFailed);
  EC_POINT_set_compressed_coordinates_GFp := LoadFunction('EC_POINT_set_compressed_coordinates_GFp', AFailed);
  EC_POINT_set_affine_coordinates_GF2m := LoadFunction('EC_POINT_set_affine_coordinates_GF2m', AFailed);
  EC_POINT_get_affine_coordinates_GF2m := LoadFunction('EC_POINT_get_affine_coordinates_GF2m', AFailed);
  EC_POINT_set_compressed_coordinates_GF2m := LoadFunction('EC_POINT_set_compressed_coordinates_GF2m', AFailed);
  EC_POINT_point2oct := LoadFunction('EC_POINT_point2oct', AFailed);
  EC_POINT_oct2point := LoadFunction('EC_POINT_oct2point', AFailed);
  EC_POINT_point2buf := LoadFunction('EC_POINT_point2buf', AFailed);
  EC_POINT_point2bn := LoadFunction('EC_POINT_point2bn', AFailed);
  EC_POINT_bn2point := LoadFunction('EC_POINT_bn2point', AFailed);
  EC_POINT_point2hex := LoadFunction('EC_POINT_point2hex', AFailed);
  EC_POINT_hex2point := LoadFunction('EC_POINT_hex2point', AFailed);
  EC_POINT_add := LoadFunction('EC_POINT_add', AFailed);
  EC_POINT_dbl := LoadFunction('EC_POINT_dbl', AFailed);
  EC_POINT_invert := LoadFunction('EC_POINT_invert', AFailed);
  EC_POINT_is_at_infinity := LoadFunction('EC_POINT_is_at_infinity', AFailed);
  EC_POINT_is_on_curve := LoadFunction('EC_POINT_is_on_curve', AFailed);
  EC_POINT_cmp := LoadFunction('EC_POINT_cmp', AFailed);
  EC_POINT_make_affine := LoadFunction('EC_POINT_make_affine', AFailed);
  EC_POINTs_make_affine := LoadFunction('EC_POINTs_make_affine', AFailed);
  EC_POINTs_mul := LoadFunction('EC_POINTs_mul', AFailed);
  EC_POINT_mul := LoadFunction('EC_POINT_mul', AFailed);
  EC_GROUP_precompute_mult := LoadFunction('EC_GROUP_precompute_mult', AFailed);
  EC_GROUP_have_precompute_mult := LoadFunction('EC_GROUP_have_precompute_mult', AFailed);
  ECPKPARAMETERS_it := LoadFunction('ECPKPARAMETERS_it', AFailed);
  ECPKPARAMETERS_new := LoadFunction('ECPKPARAMETERS_new', AFailed);
  ECPKPARAMETERS_free := LoadFunction('ECPKPARAMETERS_free', AFailed);
  ECPARAMETERS_it := LoadFunction('ECPARAMETERS_it', AFailed);
  ECPARAMETERS_new := LoadFunction('ECPARAMETERS_new', AFailed);
  ECPARAMETERS_free := LoadFunction('ECPARAMETERS_free', AFailed);
  EC_GROUP_get_basis_type := LoadFunction('EC_GROUP_get_basis_type', AFailed);
  EC_GROUP_get_trinomial_basis := LoadFunction('EC_GROUP_get_trinomial_basis', AFailed);
  EC_GROUP_get_pentanomial_basis := LoadFunction('EC_GROUP_get_pentanomial_basis', AFailed);
  d2i_ECPKParameters := LoadFunction('d2i_ECPKParameters', AFailed);
  i2d_ECPKParameters := LoadFunction('i2d_ECPKParameters', AFailed);
  ECPKParameters_print := LoadFunction('ECPKParameters_print', AFailed);
  EC_KEY_new := LoadFunction('EC_KEY_new', AFailed);
  EC_KEY_get_flags := LoadFunction('EC_KEY_get_flags', AFailed);
  EC_KEY_set_flags := LoadFunction('EC_KEY_set_flags', AFailed);
  EC_KEY_clear_flags := LoadFunction('EC_KEY_clear_flags', AFailed);
  EC_KEY_new_by_curve_name := LoadFunction('EC_KEY_new_by_curve_name', AFailed);
  EC_KEY_free := LoadFunction('EC_KEY_free', AFailed);
  EC_KEY_copy := LoadFunction('EC_KEY_copy', AFailed);
  EC_KEY_dup := LoadFunction('EC_KEY_dup', AFailed);
  EC_KEY_up_ref := LoadFunction('EC_KEY_up_ref', AFailed);
  EC_KEY_get0_engine := LoadFunction('EC_KEY_get0_engine', AFailed);
  EC_KEY_get0_group := LoadFunction('EC_KEY_get0_group', AFailed);
  EC_KEY_set_group := LoadFunction('EC_KEY_set_group', AFailed);
  EC_KEY_get0_private_key := LoadFunction('EC_KEY_get0_private_key', AFailed);
  EC_KEY_set_private_key := LoadFunction('EC_KEY_set_private_key', AFailed);
  EC_KEY_get0_public_key := LoadFunction('EC_KEY_get0_public_key', AFailed);
  EC_KEY_set_public_key := LoadFunction('EC_KEY_set_public_key', AFailed);
  EC_KEY_get_enc_flags := LoadFunction('EC_KEY_get_enc_flags', AFailed);
  EC_KEY_set_enc_flags := LoadFunction('EC_KEY_set_enc_flags', AFailed);
  EC_KEY_get_conv_form := LoadFunction('EC_KEY_get_conv_form', AFailed);
  EC_KEY_set_conv_form := LoadFunction('EC_KEY_set_conv_form', AFailed);
  EC_KEY_set_ex_data := LoadFunction('EC_KEY_set_ex_data', AFailed);
  EC_KEY_get_ex_data := LoadFunction('EC_KEY_get_ex_data', AFailed);
  EC_KEY_set_asn1_flag := LoadFunction('EC_KEY_set_asn1_flag', AFailed);
  EC_KEY_precompute_mult := LoadFunction('EC_KEY_precompute_mult', AFailed);
  EC_KEY_generate_key := LoadFunction('EC_KEY_generate_key', AFailed);
  EC_KEY_check_key := LoadFunction('EC_KEY_check_key', AFailed);
  EC_KEY_can_sign := LoadFunction('EC_KEY_can_sign', AFailed);
  EC_KEY_set_public_key_affine_coordinates := LoadFunction('EC_KEY_set_public_key_affine_coordinates', AFailed);
  EC_KEY_key2buf := LoadFunction('EC_KEY_key2buf', AFailed);
  EC_KEY_oct2key := LoadFunction('EC_KEY_oct2key', AFailed);
  EC_KEY_oct2priv := LoadFunction('EC_KEY_oct2priv', AFailed);
  EC_KEY_priv2oct := LoadFunction('EC_KEY_priv2oct', AFailed);
  EC_KEY_priv2buf := LoadFunction('EC_KEY_priv2buf', AFailed);
  d2i_ECPrivateKey := LoadFunction('d2i_ECPrivateKey', AFailed);
  i2d_ECPrivateKey := LoadFunction('i2d_ECPrivateKey', AFailed);
  o2i_ECPublicKey := LoadFunction('o2i_ECPublicKey', AFailed);
  i2o_ECPublicKey := LoadFunction('i2o_ECPublicKey', AFailed);
  ECParameters_print := LoadFunction('ECParameters_print', AFailed);
  EC_KEY_print := LoadFunction('EC_KEY_print', AFailed);
  EC_KEY_OpenSSL := LoadFunction('EC_KEY_OpenSSL', AFailed);
  EC_KEY_get_default_method := LoadFunction('EC_KEY_get_default_method', AFailed);
  EC_KEY_set_default_method := LoadFunction('EC_KEY_set_default_method', AFailed);
  EC_KEY_get_method := LoadFunction('EC_KEY_get_method', AFailed);
  EC_KEY_set_method := LoadFunction('EC_KEY_set_method', AFailed);
  EC_KEY_new_method := LoadFunction('EC_KEY_new_method', AFailed);
  ECDH_KDF_X9_62 := LoadFunction('ECDH_KDF_X9_62', AFailed);
  ECDH_compute_key := LoadFunction('ECDH_compute_key', AFailed);
  ECDSA_SIG_new := LoadFunction('ECDSA_SIG_new', AFailed);
  ECDSA_SIG_free := LoadFunction('ECDSA_SIG_free', AFailed);
  i2d_ECDSA_SIG := LoadFunction('i2d_ECDSA_SIG', AFailed);
  d2i_ECDSA_SIG := LoadFunction('d2i_ECDSA_SIG', AFailed);
  ECDSA_SIG_get0 := LoadFunction('ECDSA_SIG_get0', AFailed);
  ECDSA_SIG_get0_r := LoadFunction('ECDSA_SIG_get0_r', AFailed);
  ECDSA_SIG_get0_s := LoadFunction('ECDSA_SIG_get0_s', AFailed);
  ECDSA_SIG_set0 := LoadFunction('ECDSA_SIG_set0', AFailed);
  ECDSA_do_sign := LoadFunction('ECDSA_do_sign', AFailed);
  ECDSA_do_sign_ex := LoadFunction('ECDSA_do_sign_ex', AFailed);
  ECDSA_do_verify := LoadFunction('ECDSA_do_verify', AFailed);
  ECDSA_sign_setup := LoadFunction('ECDSA_sign_setup', AFailed);
  ECDSA_sign := LoadFunction('ECDSA_sign', AFailed);
  ECDSA_sign_ex := LoadFunction('ECDSA_sign_ex', AFailed);
  ECDSA_verify := LoadFunction('ECDSA_verify', AFailed);
  ECDSA_size := LoadFunction('ECDSA_size', AFailed);
  EC_KEY_METHOD_new := LoadFunction('EC_KEY_METHOD_new', AFailed);
  EC_KEY_METHOD_free := LoadFunction('EC_KEY_METHOD_free', AFailed);
  EC_KEY_METHOD_set_init := LoadFunction('EC_KEY_METHOD_set_init', AFailed);
  EC_KEY_METHOD_set_keygen := LoadFunction('EC_KEY_METHOD_set_keygen', AFailed);
  EC_KEY_METHOD_set_compute_key := LoadFunction('EC_KEY_METHOD_set_compute_key', AFailed);
  EC_KEY_METHOD_set_sign := LoadFunction('EC_KEY_METHOD_set_sign', AFailed);
  EC_KEY_METHOD_set_verify := LoadFunction('EC_KEY_METHOD_set_verify', AFailed);
  EC_KEY_METHOD_get_init := LoadFunction('EC_KEY_METHOD_get_init', AFailed);
  EC_KEY_METHOD_get_keygen := LoadFunction('EC_KEY_METHOD_get_keygen', AFailed);
  EC_KEY_METHOD_get_compute_key := LoadFunction('EC_KEY_METHOD_get_compute_key', AFailed);
  EC_KEY_METHOD_get_sign := LoadFunction('EC_KEY_METHOD_get_sign', AFailed);
  EC_KEY_METHOD_get_verify := LoadFunction('EC_KEY_METHOD_get_verify', AFailed);
end;

procedure UnLoad;
begin
  EC_GFp_simple_method := nil;
  EC_GFp_mont_method := nil;
  EC_GFp_nist_method := nil;
  EC_GFp_nistp224_method := nil;
  EC_GFp_nistp256_method := nil;
  EC_GFp_nistp521_method := nil;
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
  EC_GROUP_get0_order := nil;
  EC_GROUP_order_bits := nil;
  EC_GROUP_get_cofactor := nil;
  EC_GROUP_get0_cofactor := nil;
  EC_GROUP_set_curve_name := nil;
  EC_GROUP_get_curve_name := nil;
  EC_GROUP_set_asn1_flag := nil;
  EC_GROUP_get_asn1_flag := nil;
  EC_GROUP_set_point_conversion_form := nil;
  EC_GROUP_get_point_conversion_form := nil;
  EC_GROUP_get0_seed := nil;
  EC_GROUP_get_seed_len := nil;
  EC_GROUP_set_seed := nil;
  EC_GROUP_set_curve := nil;
  EC_GROUP_get_curve := nil;
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
  EC_GROUP_new_from_ecparameters := nil;
  EC_GROUP_get_ecparameters := nil;
  EC_GROUP_new_from_ecpkparameters := nil;
  EC_GROUP_get_ecpkparameters := nil;
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
  EC_POINT_set_affine_coordinates := nil;
  EC_POINT_get_affine_coordinates := nil;
  EC_POINT_set_affine_coordinates_GFp := nil;
  EC_POINT_get_affine_coordinates_GFp := nil;
  EC_POINT_set_compressed_coordinates := nil;
  EC_POINT_set_compressed_coordinates_GFp := nil;
  EC_POINT_set_affine_coordinates_GF2m := nil;
  EC_POINT_get_affine_coordinates_GF2m := nil;
  EC_POINT_set_compressed_coordinates_GF2m := nil;
  EC_POINT_point2oct := nil;
  EC_POINT_oct2point := nil;
  EC_POINT_point2buf := nil;
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
  EC_KEY_get0_engine := nil;
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
  EC_KEY_set_ex_data := nil;
  EC_KEY_get_ex_data := nil;
  EC_KEY_set_asn1_flag := nil;
  EC_KEY_precompute_mult := nil;
  EC_KEY_generate_key := nil;
  EC_KEY_check_key := nil;
  EC_KEY_can_sign := nil;
  EC_KEY_set_public_key_affine_coordinates := nil;
  EC_KEY_key2buf := nil;
  EC_KEY_oct2key := nil;
  EC_KEY_oct2priv := nil;
  EC_KEY_priv2oct := nil;
  EC_KEY_priv2buf := nil;
  d2i_ECPrivateKey := nil;
  i2d_ECPrivateKey := nil;
  o2i_ECPublicKey := nil;
  i2o_ECPublicKey := nil;
  ECParameters_print := nil;
  EC_KEY_print := nil;
  EC_KEY_OpenSSL := nil;
  EC_KEY_get_default_method := nil;
  EC_KEY_set_default_method := nil;
  EC_KEY_get_method := nil;
  EC_KEY_set_method := nil;
  EC_KEY_new_method := nil;
  ECDH_KDF_X9_62 := nil;
  ECDH_compute_key := nil;
  ECDSA_SIG_new := nil;
  ECDSA_SIG_free := nil;
  i2d_ECDSA_SIG := nil;
  d2i_ECDSA_SIG := nil;
  ECDSA_SIG_get0 := nil;
  ECDSA_SIG_get0_r := nil;
  ECDSA_SIG_get0_s := nil;
  ECDSA_SIG_set0 := nil;
  ECDSA_do_sign := nil;
  ECDSA_do_sign_ex := nil;
  ECDSA_do_verify := nil;
  ECDSA_sign_setup := nil;
  ECDSA_sign := nil;
  ECDSA_sign_ex := nil;
  ECDSA_verify := nil;
  ECDSA_size := nil;
  EC_KEY_METHOD_new := nil;
  EC_KEY_METHOD_free := nil;
  EC_KEY_METHOD_set_init := nil;
  EC_KEY_METHOD_set_keygen := nil;
  EC_KEY_METHOD_set_compute_key := nil;
  EC_KEY_METHOD_set_sign := nil;
  EC_KEY_METHOD_set_verify := nil;
  EC_KEY_METHOD_get_init := nil;
  EC_KEY_METHOD_get_keygen := nil;
  EC_KEY_METHOD_get_compute_key := nil;
  EC_KEY_METHOD_get_sign := nil;
  EC_KEY_METHOD_get_verify := nil;
end;

end.
