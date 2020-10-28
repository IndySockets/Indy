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

unit IdOpenSSLHeaders_bn;

interface

// Headers for OpenSSL 1.1.1
// bn.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  BN_FLG_MALLOCED = $01;
  BN_FLG_STATIC_DATA = $02;

  (*
   * avoid leaking exponent information through timing,
   * BN_mod_exp_mont() will call BN_mod_exp_mont_consttime,
   * BN_div() will call BN_div_no_branch,
   * BN_mod_inverse() will call BN_mod_inverse_no_branch.
   *)
  BN_FLG_CONSTTIME = $04;
  BN_FLG_SECURE = $08;

  (* Values for |top| in BN_rand() *)
  BN_RAND_TOP_ANY = -1;
  BN_RAND_TOP_ONE = 0;
  BN_RAND_TOP_TWO = 1;

  (* Values for |bottom| in BN_rand() *)
  BN_RAND_BOTTOM_ANY = 0;
  BN_RAND_BOTTOM_ODD = 1;
  
  (* BN_BLINDING flags *)
  BN_BLINDING_NO_UPDATE = $00000001;
  BN_BLINDING_NO_RECREATE = $00000002;

type
  BN_ULONG = TIdC_ULONG;

  BN_GENCB_set_old_cb = procedure (a: TIdC_INT; b: TIdC_INT; c: Pointer); cdecl;
  BN_GENCB_set_cb = function (a: TIdC_INT; b: TIdC_INT; c: PBN_GENCB): TIdC_INT; cdecl;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  BN_set_flags: procedure(b: PBIGNUM; n: TIdC_INT) cdecl = nil;
  BN_get_flags: function(b: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;

  (*
   * get a clone of a BIGNUM with changed flags, for *temporary* use only (the
   * two BIGNUMs cannot be used in parallel!). Also only for *read only* use. The
   * value |dest| should be a newly allocated BIGNUM obtained via BN_new() that
   * has not been otherwise initialised or used.
   *)
  BN_with_flags: procedure(dest: PBIGNUM; b: PBIGNUM; flags: TIdC_INT) cdecl = nil;
  (* Wrapper function to make using BN_GENCB easier *)
  BN_GENCB_call: function(cb: PBN_GENCB; a: TIdC_INT; b: TIdC_INT): TIdC_INT cdecl = nil;

  BN_GENCB_new: function: PBN_GENCB cdecl = nil;
  BN_GENCB_free: procedure(cb: PBN_GENCB) cdecl = nil;

  (* Populate a PBN_GENCB structure with an "old"-style callback *)
  BN_GENCB_set_old: procedure(gencb: PBN_GENCB; callback: BN_GENCB_set_old_cb; cb_arg: Pointer) cdecl = nil;

  (* Populate a PBN_GENCB structure with a "new"-style callback *)
  BN_GENCB_set: procedure(gencb: PBN_GENCB; callback: BN_GENCB_set_cb; cb_arg: Pointer) cdecl = nil;

  BN_GENCB_get_arg: function(cb: PBN_GENCB): Pointer cdecl = nil;
  
  (*
   * BN_prime_checks_for_size() returns the number of Miller-Rabin iterations
   * that will be done for checking that a random number is probably prime. The
   * error rate for accepting a composite number as prime depends on the size of
   * the prime |b|. The error rates used are for calculating an RSA key with 2 primes,
   * and so the level is what you would expect for a key of double the size of the
   * prime.
   *
   * This table is generated using the algorithm of FIPS PUB 186-4
   * Digital Signature Standard (DSS), section F.1, page 117.
   * (https://dx.doi.org/10.6028/NIST.FIPS.186-4)
   *
   * The following magma script was used to generate the output:
   * securitybits:=125;
   * k:=1024;
   * for t:=1 to 65 do
   *   for M:=3 to Floor(2*Sqrt(k-1)-1) do
   *     S:=0;
   *     // Sum over m
   *     for m:=3 to M do
   *       s:=0;
   *       // Sum over j
   *       for j:=2 to m do
   *         s+:=(RealField(32)!2)^-(j+(k-1)/j);
   *       end for;
   *       S+:=2^(m-(m-1)*t)*s;
   *     end for;
   *     A:=2^(k-2-M*t);
   *     B:=8*(Pi(RealField(32))^2-6)/3*2^(k-2)*S;
   *     pkt:=2.00743*Log(2)*k*2^-k*(A+B);
   *     seclevel:=Floor(-Log(2,pkt));
   *     if seclevel ge securitybits then
   *       printf "k: %5o, security: %o bits  (t: %o, M: %o)\n",k,seclevel,t,M;
   *       break;
   *     end if;
   *   end for;
   *   if seclevel ge securitybits then break; end if;
   * end for;
   *
   * It can be run online at:
   * http://magma.maths.usyd.edu.au/calc
   *
   * And will output:
   * k:  1024, security: 129 bits  (t: 6, M: 23)
   *
   * k is the number of bits of the prime, securitybits is the level we want to
   * reach.
   *
   * prime length | RSA key size | # MR tests | security level
   * -------------+--------------|------------+---------------
   *  (b) >= 6394 |     >= 12788 |          3 |        256 bit
   *  (b) >= 3747 |     >=  7494 |          3 |        192 bit
   *  (b) >= 1345 |     >=  2690 |          4 |        128 bit
   *  (b) >= 1080 |     >=  2160 |          5 |        128 bit
   *  (b) >=  852 |     >=  1704 |          5 |        112 bit
   *  (b) >=  476 |     >=   952 |          5 |         80 bit
   *  (b) >=  400 |     >=   800 |          6 |         80 bit
   *  (b) >=  347 |     >=   694 |          7 |         80 bit
   *  (b) >=  308 |     >=   616 |          8 |         80 bit
   *  (b) >=   55 |     >=   110 |         27 |         64 bit
   *  (b) >=    6 |     >=    12 |         34 |         64 bit
   *)

//  # define BN_prime_checks_for_size(b) ((b) >= 3747 ?  3 : \
//                                  (b) >=  1345 ?  4 : \
//                                  (b) >=  476 ?  5 : \
//                                  (b) >=  400 ?  6 : \
//                                  (b) >=  347 ?  7 : \
//                                  (b) >=  308 ?  8 : \
//                                  (b) >=  55  ? 27 : \
//                                  (* b >= 6 *) 34)
//
//  # define BN_num_bytes(a) ((BN_num_bits(a)+7)/8)

  BN_abs_is_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_is_zero: function(a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_is_one: function(a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_is_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_is_odd: function(a: PBIGNUM): TIdC_INT cdecl = nil;

//  # define BN_one(a)       (BN_set_word((a),1))

  BN_zero_ex: procedure(a: PBIGNUM) cdecl = nil;

  BN_value_one: function: PBIGNUM cdecl = nil;
  BN_options: function: PIdAnsiChar cdecl = nil;
  BN_CTX_new: function: PBN_CTX cdecl = nil;
  BN_CTX_secure_new: function: PBN_CTX cdecl = nil;
  BN_CTX_free: procedure(c: PBN_CTX) cdecl = nil;
  BN_CTX_start: procedure(ctx: PBN_CTX) cdecl = nil;
  BN_CTX_get: function(ctx: PBN_CTX): PBIGNUM cdecl = nil;
  BN_CTX_end: procedure(ctx: PBN_CTX) cdecl = nil;
  BN_rand: function(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl = nil;
  BN_priv_rand: function(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl = nil;
  BN_rand_range: function(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl = nil;
  BN_priv_rand_range: function(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl = nil;
  BN_pseudo_rand: function(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl = nil;
  BN_pseudo_rand_range: function(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl = nil;
  BN_num_bits: function(a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_num_bits_word: function(l: BN_ULONG): TIdC_INT cdecl = nil;
  BN_security_bits: function(L: TIdC_INT; N: TIdC_INT): TIdC_INT cdecl = nil;
  BN_new: function: PBIGNUM cdecl = nil;
  BN_secure_new: function: PBIGNUM cdecl = nil;
  BN_clear_free: procedure(a: PBIGNUM) cdecl = nil;
  BN_copy: function(a: PBIGNUM; b: PBIGNUM): PBIGNUM cdecl = nil;
  BN_swap: procedure(a: PBIGNUM; b: PBIGNUM) cdecl = nil;
  BN_bin2bn: function(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl = nil;
  BN_bn2bin: function(const a: PBIGNUM; to_: PByte): TIdC_INT cdecl = nil;
  BN_bn2binpad: function(const a: PBIGNUM; to_: PByte; tolen: TIdC_INT): TIdC_INT cdecl = nil;
  BN_lebin2bn: function(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl = nil;
  BN_bn2lebinpad: function(a: PBIGNUM; to_: PByte; tolen: TIdC_INT): TIdC_INT cdecl = nil;
  BN_mpi2bn: function(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl = nil;
  BN_bn2mpi: function(a: PBIGNUM; to_: PByte): TIdC_INT cdecl = nil;
  BN_sub: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_usub: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_uadd: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_add: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_mul: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_sqr: function(r: PBIGNUM; const a: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  (** BN_set_negative sets sign of a BIGNUM
   * \param  b  pointer to the BIGNUM object
   * \param  n  0 if the BIGNUM b should be positive and a value != 0 otherwise
   *)
  BN_set_negative: procedure(b: PBIGNUM; n: TIdC_INT) cdecl = nil;
  (** BN_is_negative returns 1 if the BIGNUM is negative
   * \param  b  pointer to the BIGNUM object
   * \return 1 if a < 0 and 0 otherwise
   *)
  BN_is_negative: function(b: PBIGNUM): TIdC_INT cdecl = nil;

  BN_div: function(dv: PBIGNUM; rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
//  # define BN_mod(rem,m,d,ctx) BN_div(NULL,(rem),(m),(d),(ctx))
  BN_nnmod: function(r: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_add: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_add_quick: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl = nil;
  BN_mod_sub: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_sub_quick: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl = nil;
  BN_mod_mul: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_sqr: function(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_lshift1: function(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_lshift1_quick: function(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl = nil;
  BN_mod_lshift: function(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_lshift_quick: function(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT; const m: PBIGNUM): TIdC_INT cdecl = nil;

  BN_mod_word: function(const a: PBIGNUM; w: BN_ULONG): BN_ULONG cdecl = nil;
  BN_div_word: function(a: PBIGNUM; w: BN_ULONG): BN_ULONG cdecl = nil;
  BN_mul_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_add_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_sub_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_set_word: function(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl = nil;
  BN_get_word: function(const a: PBIGNUM): BN_ULONG cdecl = nil;

  BN_cmp: function(const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_free: procedure(a: PBIGNUM) cdecl = nil;
  BN_is_bit_set: function(const a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_lshift: function(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_lshift1: function(r: PBIGNUM; const a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_exp: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  BN_mod_exp: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp_mont: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp_mont_consttime: function(rr: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; in_mont: PBN_MONT_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp_mont_word: function(r: PBIGNUM; a: BN_ULONG; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp2_mont: function(r: PBIGNUM; const a1: PBIGNUM; const p1: PBIGNUM; const a2: PBIGNUM; const p2: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp_simple: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  BN_mask_bits: function(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_print: function(bio: PBIO; a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_reciprocal: function(r: PBIGNUM; m: PBIGNUM; len: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_rshift: function(r: PBIGNUM; a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_rshift1: function(r: PBIGNUM; a: PBIGNUM): TIdC_INT cdecl = nil;
  BN_clear: procedure(a: PBIGNUM) cdecl = nil;
  BN_dup: function(const a: PBIGNUM): PBIGNUM cdecl = nil;
  BN_ucmp: function(a: PBIGNUM; b: PBIGNUM): TIdC_INT cdecl = nil;
  BN_set_bit: function(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_clear_bit: function(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl = nil;
  BN_bn2hex: function(a: PBIGNUM): PIdAnsiChar cdecl = nil;
  BN_bn2dec: function(a: PBIGNUM): PIdAnsiChar cdecl = nil;
  BN_hex2bn: function(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl = nil;
  BN_dec2bn: function(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl = nil;
  BN_asc2bn: function(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl = nil;
  BN_gcd: function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_kronecker: function(a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  BN_mod_inverse: function(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl = nil;
  BN_mod_sqrt: function(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl = nil;

  BN_consttime_swap: procedure(swap: BN_ULONG; a: PBIGNUM; b: PBIGNUM; nwords: TIdC_INT) cdecl = nil;

  BN_generate_prime_ex: function(ret: PBIGNUM; bits: TIdC_INT; safe: TIdC_INT; const add: PBIGNUM; const rem: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  BN_is_prime_ex: function(const p: PBIGNUM; nchecks: TIdC_INT; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  BN_is_prime_fasttest_ex: function(const p: PBIGNUM; nchecks: TIdC_INT; ctx: PBN_CTX; do_trial_division: TIdC_INT; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  BN_X931_generate_Xpq: function(Xp: PBIGNUM; Xq: PBIGNUM; nbits: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_X931_derive_prime_ex: function(p: PBIGNUM; p1: PBIGNUM; p2: PBIGNUM; const Xp: PBIGNUM; const Xp1: PBIGNUM; const Xp2: PBIGNUM; const e: PBIGNUM; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  BN_X931_generate_prime_ex: function(p: PBIGNUM; p1: PBIGNUM; p2: PBIGNUM; Xp1: PBIGNUM; Xp2: PBIGNUM; Xp: PBIGNUM; const e: PBIGNUM; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl = nil;
  BN_MONT_CTX_new: function: PBN_MONT_CTX cdecl = nil;
  BN_mod_mul_montgomery: function(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_to_montgomery: function(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_from_montgomery: function(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_MONT_CTX_free: procedure(mont: PBN_MONT_CTX) cdecl = nil;
  BN_MONT_CTX_set: function(mont: PBN_MONT_CTX; mod_: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_MONT_CTX_copy: function(&to: PBN_MONT_CTX; from: PBN_MONT_CTX): PBN_MONT_CTX cdecl = nil;
//  function BN_MONT_CTX_set_locked(pmont: ^PBN_MONT_CTX; lock: CRYPTO_RWLOCK; mod_: PBIGNUM; ctx: PBN_CTX): PBN_MONT_CTX;

  BN_BLINDING_new: function(const A: PBIGNUM; const Ai: PBIGNUM; mod_: PBIGNUM): PBN_BLINDING cdecl = nil;
  BN_BLINDING_free: procedure(b: PBN_BLINDING) cdecl = nil;
  BN_BLINDING_update: function(b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_BLINDING_convert: function(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_BLINDING_invert: function(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_BLINDING_convert_ex: function(n: PBIGNUM; r: PBIGNUM; b: PBN_BLINDING; v4: PBN_CTX): TIdC_INT cdecl = nil;
  BN_BLINDING_invert_ex: function(n: PBIGNUM; r: PBIGNUM; b: PBN_BLINDING; v2: PBN_CTX): TIdC_INT cdecl = nil;

  BN_BLINDING_is_current_thread: function(b: PBN_BLINDING): TIdC_INT cdecl = nil;
  BN_BLINDING_set_current_thread: procedure(b: PBN_BLINDING) cdecl = nil;
  BN_BLINDING_lock: function(b: PBN_BLINDING): TIdC_INT cdecl = nil;
  BN_BLINDING_unlock: function(b: PBN_BLINDING): TIdC_INT cdecl = nil;

  BN_BLINDING_get_flags: function(v1: PBN_BLINDING): TIdC_ULONG cdecl = nil;
  BN_BLINDING_set_flags: procedure(v1: PBN_BLINDING; v2: TIdC_ULONG) cdecl = nil;
//  function BN_BLINDING_create_param(PBN_BLINDING *b,
//                                         PBIGNUM *e, PBIGNUM *m, PBN_CTX *ctx,
//                                        function (
//    r: PBIGNUM;
//    a: PBIGNUM;
//    p: PBIGNUM;
//    m: PBIGNUM;
//    ctx: PBN_CTX;
//    m_ctx: PBN_MONT_CTX): TIdC_INT,
//                                        PBN_MONT_CTX *m_ctx): PBN_BLINDING;

  BN_RECP_CTX_free: procedure(recp: PBN_RECP_CTX) cdecl = nil;
  BN_RECP_CTX_set: function(recp: PBN_RECP_CTX; rdiv: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_mul_reciprocal: function(r: PBIGNUM; x: PBIGNUM; y: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_mod_exp_recp: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_div_recp: function(dv: PBIGNUM; rem: PBIGNUM; m: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  (*
   * Functions for arithmetic over binary polynomials represented by BIGNUMs.
   * The BIGNUM::neg property of BIGNUMs representing binary polynomials is
   * ignored. Note that input arguments are not const so that their bit arrays
   * can be expanded to the appropriate size if needed.
   *)

  (*
   * r = a + b
   *)
  BN_GF2m_add: function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM): TIdC_INT cdecl = nil;
//  #  define BN_GF2m_sub(r, a, b) BN_GF2m_add(r, a, b)
  (*
   * r=a mod p
   *)
  BN_GF2m_mod: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM): TIdC_INT cdecl = nil;
  (* r = (a * b) mod p *)
  BN_GF2m_mod_mul: function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r = (a * a) mod p *)
  BN_GF2m_mod_sqr: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r = (1 / b) mod p *)
  BN_GF2m_mod_inv: function(r: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r = (a / b) mod p *)
  BN_GF2m_mod_div: function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r = (a ^ b) mod p *)
  BN_GF2m_mod_exp: function(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r = sqrt(a) mod p *)
  BN_GF2m_mod_sqrt: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  (* r^2 + r = a mod p *)
  BN_GF2m_mod_solve_quad: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
//  #  define BN_GF2m_cmp(a, b) BN_ucmp((a), (b))
  (*-
   * Some functions allow for representation of the irreducible polynomials
   * as an unsigned int[], say p.  The irreducible f(t) is then of the form:
   *     t^p[0] + t^p[1] + ... + t^p[k]
   * where m = p[0] > p[1] > ... > p[k] = 0.
   *)
  (* r = a mod p *)
//  function BN_GF2m_mod_arr(r: PBIGNUM; a: PBIGNUM; p: array of TIdC_INT): TIdC_INT;
  (* r = (a * b) mod p *)
//  function BN_GF2m_mod_mul_arr(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r = (a * a) mod p *)
//  function BN_GF2m_mod_sqr_arr(r: PBIGNUM; a: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r = (1 / b) mod p *)
//  function BN_GF2m_mod_inv_arr(r: PBIGNUM; b: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r = (a / b) mod p *)
//  function BN_GF2m_mod_div_arr(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r = (a ^ b) mod p *)
//  function BN_GF2m_mod_exp_arr(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r = sqrt(a) mod p *)
//  function BN_GF2m_mod_sqrt_arr(r: PBIGNUM; a: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
  (* r^2 + r = a mod p *)
//  function BN_GF2m_mod_solve_quad_arr(r: PBIGNUM; a: PBIGNUM; p: array of TIdC_INT; ctx: PBN_CTX): TIdC_INT;
//  function BN_GF2m_poly2arr(a: PBIGNUM; p: array of TIdC_INT; max: TIdC_INT): TIdC_INT;
//  function BN_GF2m_arr2poly(p: array of TIdC_INT; a: PBIGNUM): TIdC_INT;

  (*
   * faster mod functions for the 'NIST primes' 0 <= a < p^2
   *)
  BN_nist_mod_192: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_nist_mod_224: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_nist_mod_256: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_nist_mod_384: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;
  BN_nist_mod_521: function(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  BN_get0_nist_prime_192: function: PBIGNUM cdecl = nil;
  BN_get0_nist_prime_224: function: PBIGNUM cdecl = nil;
  BN_get0_nist_prime_256: function: PBIGNUM cdecl = nil;
  BN_get0_nist_prime_384: function: PBIGNUM cdecl = nil;
  BN_get0_nist_prime_521: function: PBIGNUM cdecl = nil;

//int (*BN_nist_mod_func(const BIGNUM *p)) (BIGNUM *r, const BIGNUM *a,
//                                          const BIGNUM *field, BN_CTX *ctx);

  BN_generate_dsa_nonce: function(&out: PBIGNUM; range: PBIGNUM; priv: PBIGNUM; const message_: PByte; message_len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl = nil;

  (* Primes from RFC 2409 *)
  BN_get_rfc2409_prime_768: function(bn: PBIGNUM ): PBIGNUM cdecl = nil;
  BN_get_rfc2409_prime_1024: function(bn: PBIGNUM): PBIGNUM cdecl = nil;

  (* Primes from RFC 3526 *)
  BN_get_rfc3526_prime_1536: function(bn: PBIGNUM): PBIGNUM cdecl = nil;
  BN_get_rfc3526_prime_2048: function(bn: PBIGNUM): PBIGNUM cdecl = nil;
  BN_get_rfc3526_prime_3072: function(bn: PBIGNUM): PBIGNUM cdecl = nil;
  BN_get_rfc3526_prime_4096: function(bn: PBIGNUM): PBIGNUM cdecl = nil;
  BN_get_rfc3526_prime_6144: function(bn: PBIGNUM): PBIGNUM cdecl = nil;
  BN_get_rfc3526_prime_8192: function(bn: PBIGNUM): PBIGNUM cdecl = nil;

  BN_bntest_rand: function(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  BN_set_flags := LoadFunction('BN_set_flags', AFailed);
  BN_get_flags := LoadFunction('BN_get_flags', AFailed);
  BN_with_flags := LoadFunction('BN_with_flags', AFailed);
  BN_GENCB_call := LoadFunction('BN_GENCB_call', AFailed);
  BN_GENCB_new := LoadFunction('BN_GENCB_new', AFailed);
  BN_GENCB_free := LoadFunction('BN_GENCB_free', AFailed);
  BN_GENCB_set_old := LoadFunction('BN_GENCB_set_old', AFailed);
  BN_GENCB_set := LoadFunction('BN_GENCB_set', AFailed);
  BN_GENCB_get_arg := LoadFunction('BN_GENCB_get_arg', AFailed);
  BN_abs_is_word := LoadFunction('BN_abs_is_word', AFailed);
  BN_is_zero := LoadFunction('BN_is_zero', AFailed);
  BN_is_one := LoadFunction('BN_is_one', AFailed);
  BN_is_word := LoadFunction('BN_is_word', AFailed);
  BN_is_odd := LoadFunction('BN_is_odd', AFailed);
  BN_zero_ex := LoadFunction('BN_zero_ex', AFailed);
  BN_value_one := LoadFunction('BN_value_one', AFailed);
  BN_options := LoadFunction('BN_options', AFailed);
  BN_CTX_new := LoadFunction('BN_CTX_new', AFailed);
  BN_CTX_secure_new := LoadFunction('BN_CTX_secure_new', AFailed);
  BN_CTX_free := LoadFunction('BN_CTX_free', AFailed);
  BN_CTX_start := LoadFunction('BN_CTX_start', AFailed);
  BN_CTX_get := LoadFunction('BN_CTX_get', AFailed);
  BN_CTX_end := LoadFunction('BN_CTX_end', AFailed);
  BN_rand := LoadFunction('BN_rand', AFailed);
  BN_priv_rand := LoadFunction('BN_priv_rand', AFailed);
  BN_rand_range := LoadFunction('BN_rand_range', AFailed);
  BN_priv_rand_range := LoadFunction('BN_priv_rand_range', AFailed);
  BN_pseudo_rand := LoadFunction('BN_pseudo_rand', AFailed);
  BN_pseudo_rand_range := LoadFunction('BN_pseudo_rand_range', AFailed);
  BN_num_bits := LoadFunction('BN_num_bits', AFailed);
  BN_num_bits_word := LoadFunction('BN_num_bits_word', AFailed);
  BN_security_bits := LoadFunction('BN_security_bits', AFailed);
  BN_new := LoadFunction('BN_new', AFailed);
  BN_secure_new := LoadFunction('BN_secure_new', AFailed);
  BN_clear_free := LoadFunction('BN_clear_free', AFailed);
  BN_copy := LoadFunction('BN_copy', AFailed);
  BN_swap := LoadFunction('BN_swap', AFailed);
  BN_bin2bn := LoadFunction('BN_bin2bn', AFailed);
  BN_bn2bin := LoadFunction('BN_bn2bin', AFailed);
  BN_bn2binpad := LoadFunction('BN_bn2binpad', AFailed);
  BN_lebin2bn := LoadFunction('BN_lebin2bn', AFailed);
  BN_bn2lebinpad := LoadFunction('BN_bn2lebinpad', AFailed);
  BN_mpi2bn := LoadFunction('BN_mpi2bn', AFailed);
  BN_bn2mpi := LoadFunction('BN_bn2mpi', AFailed);
  BN_sub := LoadFunction('BN_sub', AFailed);
  BN_usub := LoadFunction('BN_usub', AFailed);
  BN_uadd := LoadFunction('BN_uadd', AFailed);
  BN_add := LoadFunction('BN_add', AFailed);
  BN_mul := LoadFunction('BN_mul', AFailed);
  BN_sqr := LoadFunction('BN_sqr', AFailed);
  BN_set_negative := LoadFunction('BN_set_negative', AFailed);
  BN_is_negative := LoadFunction('BN_is_negative', AFailed);
  BN_div := LoadFunction('BN_div', AFailed);
  BN_nnmod := LoadFunction('BN_nnmod', AFailed);
  BN_mod_add := LoadFunction('BN_mod_add', AFailed);
  BN_mod_add_quick := LoadFunction('BN_mod_add_quick', AFailed);
  BN_mod_sub := LoadFunction('BN_mod_sub', AFailed);
  BN_mod_sub_quick := LoadFunction('BN_mod_sub_quick', AFailed);
  BN_mod_mul := LoadFunction('BN_mod_mul', AFailed);
  BN_mod_sqr := LoadFunction('BN_mod_sqr', AFailed);
  BN_mod_lshift1 := LoadFunction('BN_mod_lshift1', AFailed);
  BN_mod_lshift1_quick := LoadFunction('BN_mod_lshift1_quick', AFailed);
  BN_mod_lshift := LoadFunction('BN_mod_lshift', AFailed);
  BN_mod_lshift_quick := LoadFunction('BN_mod_lshift_quick', AFailed);
  BN_mod_word := LoadFunction('BN_mod_word', AFailed);
  BN_div_word := LoadFunction('BN_div_word', AFailed);
  BN_mul_word := LoadFunction('BN_mul_word', AFailed);
  BN_add_word := LoadFunction('BN_add_word', AFailed);
  BN_sub_word := LoadFunction('BN_sub_word', AFailed);
  BN_set_word := LoadFunction('BN_set_word', AFailed);
  BN_get_word := LoadFunction('BN_get_word', AFailed);
  BN_cmp := LoadFunction('BN_cmp', AFailed);
  BN_free := LoadFunction('BN_free', AFailed);
  BN_is_bit_set := LoadFunction('BN_is_bit_set', AFailed);
  BN_lshift := LoadFunction('BN_lshift', AFailed);
  BN_lshift1 := LoadFunction('BN_lshift1', AFailed);
  BN_exp := LoadFunction('BN_exp', AFailed);
  BN_mod_exp := LoadFunction('BN_mod_exp', AFailed);
  BN_mod_exp_mont := LoadFunction('BN_mod_exp_mont', AFailed);
  BN_mod_exp_mont_consttime := LoadFunction('BN_mod_exp_mont_consttime', AFailed);
  BN_mod_exp_mont_word := LoadFunction('BN_mod_exp_mont_word', AFailed);
  BN_mod_exp2_mont := LoadFunction('BN_mod_exp2_mont', AFailed);
  BN_mod_exp_simple := LoadFunction('BN_mod_exp_simple', AFailed);
  BN_mask_bits := LoadFunction('BN_mask_bits', AFailed);
  BN_print := LoadFunction('BN_print', AFailed);
  BN_reciprocal := LoadFunction('BN_reciprocal', AFailed);
  BN_rshift := LoadFunction('BN_rshift', AFailed);
  BN_rshift1 := LoadFunction('BN_rshift1', AFailed);
  BN_clear := LoadFunction('BN_clear', AFailed);
  BN_dup := LoadFunction('BN_dup', AFailed);
  BN_ucmp := LoadFunction('BN_ucmp', AFailed);
  BN_set_bit := LoadFunction('BN_set_bit', AFailed);
  BN_clear_bit := LoadFunction('BN_clear_bit', AFailed);
  BN_bn2hex := LoadFunction('BN_bn2hex', AFailed);
  BN_bn2dec := LoadFunction('BN_bn2dec', AFailed);
  BN_hex2bn := LoadFunction('BN_hex2bn', AFailed);
  BN_dec2bn := LoadFunction('BN_dec2bn', AFailed);
  BN_asc2bn := LoadFunction('BN_asc2bn', AFailed);
  BN_gcd := LoadFunction('BN_gcd', AFailed);
  BN_kronecker := LoadFunction('BN_kronecker', AFailed);
  BN_mod_inverse := LoadFunction('BN_mod_inverse', AFailed);
  BN_mod_sqrt := LoadFunction('BN_mod_sqrt', AFailed);
  BN_consttime_swap := LoadFunction('BN_consttime_swap', AFailed);
  BN_generate_prime_ex := LoadFunction('BN_generate_prime_ex', AFailed);
  BN_is_prime_ex := LoadFunction('BN_is_prime_ex', AFailed);
  BN_is_prime_fasttest_ex := LoadFunction('BN_is_prime_fasttest_ex', AFailed);
  BN_X931_generate_Xpq := LoadFunction('BN_X931_generate_Xpq', AFailed);
  BN_X931_derive_prime_ex := LoadFunction('BN_X931_derive_prime_ex', AFailed);
  BN_X931_generate_prime_ex := LoadFunction('BN_X931_generate_prime_ex', AFailed);
  BN_MONT_CTX_new := LoadFunction('BN_MONT_CTX_new', AFailed);
  BN_mod_mul_montgomery := LoadFunction('BN_mod_mul_montgomery', AFailed);
  BN_to_montgomery := LoadFunction('BN_to_montgomery', AFailed);
  BN_from_montgomery := LoadFunction('BN_from_montgomery', AFailed);
  BN_MONT_CTX_free := LoadFunction('BN_MONT_CTX_free', AFailed);
  BN_MONT_CTX_set := LoadFunction('BN_MONT_CTX_set', AFailed);
  BN_MONT_CTX_copy := LoadFunction('BN_MONT_CTX_copy', AFailed);
  BN_BLINDING_new := LoadFunction('BN_BLINDING_new', AFailed);
  BN_BLINDING_free := LoadFunction('BN_BLINDING_free', AFailed);
  BN_BLINDING_update := LoadFunction('BN_BLINDING_update', AFailed);
  BN_BLINDING_convert := LoadFunction('BN_BLINDING_convert', AFailed);
  BN_BLINDING_invert := LoadFunction('BN_BLINDING_invert', AFailed);
  BN_BLINDING_convert_ex := LoadFunction('BN_BLINDING_convert_ex', AFailed);
  BN_BLINDING_invert_ex := LoadFunction('BN_BLINDING_invert_ex', AFailed);
  BN_BLINDING_is_current_thread := LoadFunction('BN_BLINDING_is_current_thread', AFailed);
  BN_BLINDING_set_current_thread := LoadFunction('BN_BLINDING_set_current_thread', AFailed);
  BN_BLINDING_lock := LoadFunction('BN_BLINDING_lock', AFailed);
  BN_BLINDING_unlock := LoadFunction('BN_BLINDING_unlock', AFailed);
  BN_BLINDING_get_flags := LoadFunction('BN_BLINDING_get_flags', AFailed);
  BN_BLINDING_set_flags := LoadFunction('BN_BLINDING_set_flags', AFailed);
  BN_RECP_CTX_free := LoadFunction('BN_RECP_CTX_free', AFailed);
  BN_RECP_CTX_set := LoadFunction('BN_RECP_CTX_set', AFailed);
  BN_mod_mul_reciprocal := LoadFunction('BN_mod_mul_reciprocal', AFailed);
  BN_mod_exp_recp := LoadFunction('BN_mod_exp_recp', AFailed);
  BN_div_recp := LoadFunction('BN_div_recp', AFailed);
  BN_GF2m_add := LoadFunction('BN_GF2m_add', AFailed);
  BN_GF2m_mod := LoadFunction('BN_GF2m_mod', AFailed);
  BN_GF2m_mod_mul := LoadFunction('BN_GF2m_mod_mul', AFailed);
  BN_GF2m_mod_sqr := LoadFunction('BN_GF2m_mod_sqr', AFailed);
  BN_GF2m_mod_inv := LoadFunction('BN_GF2m_mod_inv', AFailed);
  BN_GF2m_mod_div := LoadFunction('BN_GF2m_mod_div', AFailed);
  BN_GF2m_mod_exp := LoadFunction('BN_GF2m_mod_exp', AFailed);
  BN_GF2m_mod_sqrt := LoadFunction('BN_GF2m_mod_sqrt', AFailed);
  BN_GF2m_mod_solve_quad := LoadFunction('BN_GF2m_mod_solve_quad', AFailed);
  BN_nist_mod_192 := LoadFunction('BN_nist_mod_192', AFailed);
  BN_nist_mod_224 := LoadFunction('BN_nist_mod_224', AFailed);
  BN_nist_mod_256 := LoadFunction('BN_nist_mod_256', AFailed);
  BN_nist_mod_384 := LoadFunction('BN_nist_mod_384', AFailed);
  BN_nist_mod_521 := LoadFunction('BN_nist_mod_521', AFailed);
  BN_get0_nist_prime_192 := LoadFunction('BN_get0_nist_prime_192', AFailed);
  BN_get0_nist_prime_224 := LoadFunction('BN_get0_nist_prime_224', AFailed);
  BN_get0_nist_prime_256 := LoadFunction('BN_get0_nist_prime_256', AFailed);
  BN_get0_nist_prime_384 := LoadFunction('BN_get0_nist_prime_384', AFailed);
  BN_get0_nist_prime_521 := LoadFunction('BN_get0_nist_prime_521', AFailed);
  BN_generate_dsa_nonce := LoadFunction('BN_generate_dsa_nonce', AFailed);
  BN_get_rfc2409_prime_768 := LoadFunction('BN_get_rfc2409_prime_768', AFailed);
  BN_get_rfc2409_prime_1024 := LoadFunction('BN_get_rfc2409_prime_1024', AFailed);
  BN_get_rfc3526_prime_1536 := LoadFunction('BN_get_rfc3526_prime_1536', AFailed);
  BN_get_rfc3526_prime_2048 := LoadFunction('BN_get_rfc3526_prime_2048', AFailed);
  BN_get_rfc3526_prime_3072 := LoadFunction('BN_get_rfc3526_prime_3072', AFailed);
  BN_get_rfc3526_prime_4096 := LoadFunction('BN_get_rfc3526_prime_4096', AFailed);
  BN_get_rfc3526_prime_6144 := LoadFunction('BN_get_rfc3526_prime_6144', AFailed);
  BN_get_rfc3526_prime_8192 := LoadFunction('BN_get_rfc3526_prime_8192', AFailed);
  BN_bntest_rand := LoadFunction('BN_bntest_rand', AFailed);
end;

procedure UnLoad;
begin
  BN_set_flags := nil;
  BN_get_flags := nil;
  BN_with_flags := nil;
  BN_GENCB_call := nil;
  BN_GENCB_new := nil;
  BN_GENCB_free := nil;
  BN_GENCB_set_old := nil;
  BN_GENCB_set := nil;
  BN_GENCB_get_arg := nil;
  BN_abs_is_word := nil;
  BN_is_zero := nil;
  BN_is_one := nil;
  BN_is_word := nil;
  BN_is_odd := nil;
  BN_zero_ex := nil;
  BN_value_one := nil;
  BN_options := nil;
  BN_CTX_new := nil;
  BN_CTX_secure_new := nil;
  BN_CTX_free := nil;
  BN_CTX_start := nil;
  BN_CTX_get := nil;
  BN_CTX_end := nil;
  BN_rand := nil;
  BN_priv_rand := nil;
  BN_rand_range := nil;
  BN_priv_rand_range := nil;
  BN_pseudo_rand := nil;
  BN_pseudo_rand_range := nil;
  BN_num_bits := nil;
  BN_num_bits_word := nil;
  BN_security_bits := nil;
  BN_new := nil;
  BN_secure_new := nil;
  BN_clear_free := nil;
  BN_copy := nil;
  BN_swap := nil;
  BN_bin2bn := nil;
  BN_bn2bin := nil;
  BN_bn2binpad := nil;
  BN_lebin2bn := nil;
  BN_bn2lebinpad := nil;
  BN_mpi2bn := nil;
  BN_bn2mpi := nil;
  BN_sub := nil;
  BN_usub := nil;
  BN_uadd := nil;
  BN_add := nil;
  BN_mul := nil;
  BN_sqr := nil;
  BN_set_negative := nil;
  BN_is_negative := nil;
  BN_div := nil;
  BN_nnmod := nil;
  BN_mod_add := nil;
  BN_mod_add_quick := nil;
  BN_mod_sub := nil;
  BN_mod_sub_quick := nil;
  BN_mod_mul := nil;
  BN_mod_sqr := nil;
  BN_mod_lshift1 := nil;
  BN_mod_lshift1_quick := nil;
  BN_mod_lshift := nil;
  BN_mod_lshift_quick := nil;
  BN_mod_word := nil;
  BN_div_word := nil;
  BN_mul_word := nil;
  BN_add_word := nil;
  BN_sub_word := nil;
  BN_set_word := nil;
  BN_get_word := nil;
  BN_cmp := nil;
  BN_free := nil;
  BN_is_bit_set := nil;
  BN_lshift := nil;
  BN_lshift1 := nil;
  BN_exp := nil;
  BN_mod_exp := nil;
  BN_mod_exp_mont := nil;
  BN_mod_exp_mont_consttime := nil;
  BN_mod_exp_mont_word := nil;
  BN_mod_exp2_mont := nil;
  BN_mod_exp_simple := nil;
  BN_mask_bits := nil;
  BN_print := nil;
  BN_reciprocal := nil;
  BN_rshift := nil;
  BN_rshift1 := nil;
  BN_clear := nil;
  BN_dup := nil;
  BN_ucmp := nil;
  BN_set_bit := nil;
  BN_clear_bit := nil;
  BN_bn2hex := nil;
  BN_bn2dec := nil;
  BN_hex2bn := nil;
  BN_dec2bn := nil;
  BN_asc2bn := nil;
  BN_gcd := nil;
  BN_kronecker := nil;
  BN_mod_inverse := nil;
  BN_mod_sqrt := nil;
  BN_consttime_swap := nil;
  BN_generate_prime_ex := nil;
  BN_is_prime_ex := nil;
  BN_is_prime_fasttest_ex := nil;
  BN_X931_generate_Xpq := nil;
  BN_X931_derive_prime_ex := nil;
  BN_X931_generate_prime_ex := nil;
  BN_MONT_CTX_new := nil;
  BN_mod_mul_montgomery := nil;
  BN_to_montgomery := nil;
  BN_from_montgomery := nil;
  BN_MONT_CTX_free := nil;
  BN_MONT_CTX_set := nil;
  BN_MONT_CTX_copy := nil;
  BN_BLINDING_new := nil;
  BN_BLINDING_free := nil;
  BN_BLINDING_update := nil;
  BN_BLINDING_convert := nil;
  BN_BLINDING_invert := nil;
  BN_BLINDING_convert_ex := nil;
  BN_BLINDING_invert_ex := nil;
  BN_BLINDING_is_current_thread := nil;
  BN_BLINDING_set_current_thread := nil;
  BN_BLINDING_lock := nil;
  BN_BLINDING_unlock := nil;
  BN_BLINDING_get_flags := nil;
  BN_BLINDING_set_flags := nil;
  BN_RECP_CTX_free := nil;
  BN_RECP_CTX_set := nil;
  BN_mod_mul_reciprocal := nil;
  BN_mod_exp_recp := nil;
  BN_div_recp := nil;
  BN_GF2m_add := nil;
  BN_GF2m_mod := nil;
  BN_GF2m_mod_mul := nil;
  BN_GF2m_mod_sqr := nil;
  BN_GF2m_mod_inv := nil;
  BN_GF2m_mod_div := nil;
  BN_GF2m_mod_exp := nil;
  BN_GF2m_mod_sqrt := nil;
  BN_GF2m_mod_solve_quad := nil;
  BN_nist_mod_192 := nil;
  BN_nist_mod_224 := nil;
  BN_nist_mod_256 := nil;
  BN_nist_mod_384 := nil;
  BN_nist_mod_521 := nil;
  BN_get0_nist_prime_192 := nil;
  BN_get0_nist_prime_224 := nil;
  BN_get0_nist_prime_256 := nil;
  BN_get0_nist_prime_384 := nil;
  BN_get0_nist_prime_521 := nil;
  BN_generate_dsa_nonce := nil;
  BN_get_rfc2409_prime_768 := nil;
  BN_get_rfc2409_prime_1024 := nil;
  BN_get_rfc3526_prime_1536 := nil;
  BN_get_rfc3526_prime_2048 := nil;
  BN_get_rfc3526_prime_3072 := nil;
  BN_get_rfc3526_prime_4096 := nil;
  BN_get_rfc3526_prime_6144 := nil;
  BN_get_rfc3526_prime_8192 := nil;
  BN_bntest_rand := nil;
end;

end.

