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

unit IdOpenSSLHeaders_bn;

interface

// Headers for OpenSSL 1.1.1
// bn.h

{$i IdCompilerDefines.inc}

uses
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

  procedure BN_set_flags(b: PBIGNUM; n: TIdC_INT) cdecl; external CLibCrypto;
  function BN_get_flags(b: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  (*
   * get a clone of a BIGNUM with changed flags, for *temporary* use only (the
   * two BIGNUMs cannot be used in parallel!). Also only for *read only* use. The
   * value |dest| should be a newly allocated BIGNUM obtained via BN_new() that
   * has not been otherwise initialised or used.
   *)
  procedure BN_with_flags(dest: PBIGNUM; b: PBIGNUM; flags: TIdC_INT) cdecl; external CLibCrypto;
  (* Wrapper function to make using BN_GENCB easier *)
  function BN_GENCB_call(cb: PBN_GENCB; a: TIdC_INT; b: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function BN_GENCB_new: PBN_GENCB cdecl; external CLibCrypto;
  procedure BN_GENCB_free(cb: PBN_GENCB) cdecl; external CLibCrypto;

  (* Populate a PBN_GENCB structure with an "old"-style callback *)
  procedure BN_GENCB_set_old(gencb: PBN_GENCB; callback: BN_GENCB_set_old_cb; cb_arg: Pointer) cdecl; external CLibCrypto;

  (* Populate a PBN_GENCB structure with a "new"-style callback *)
  procedure BN_GENCB_set(gencb: PBN_GENCB; callback: BN_GENCB_set_cb; cb_arg: Pointer) cdecl; external CLibCrypto;

  function BN_GENCB_get_arg(cb: PBN_GENCB): Pointer cdecl; external CLibCrypto;
  
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

  function BN_abs_is_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_zero(a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_one(a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_odd(a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;

//  # define BN_one(a)       (BN_set_word((a),1))

  procedure BN_zero_ex(a: PBIGNUM) cdecl; external CLibCrypto;

  function BN_value_one: PBIGNUM cdecl; external CLibCrypto;
  function BN_options: PIdAnsiChar cdecl; external CLibCrypto;
  function BN_CTX_new: PBN_CTX cdecl; external CLibCrypto;
  function BN_CTX_secure_new: PBN_CTX cdecl; external CLibCrypto;
  procedure BN_CTX_free(c: PBN_CTX) cdecl; external CLibCrypto;
  procedure BN_CTX_start(ctx: PBN_CTX) cdecl; external CLibCrypto;
  function BN_CTX_get(ctx: PBN_CTX): PBIGNUM cdecl; external CLibCrypto;
  procedure BN_CTX_end(ctx: PBN_CTX) cdecl; external CLibCrypto;
  function BN_rand(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_priv_rand(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_rand_range(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_priv_rand_range(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_pseudo_rand(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_pseudo_rand_range(rnd: PBIGNUM; range: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_num_bits(a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_num_bits_word(l: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_security_bits(L: TIdC_INT; N: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_new: PBIGNUM cdecl; external CLibCrypto;
  function BN_secure_new: PBIGNUM cdecl; external CLibCrypto;
  procedure BN_clear_free(a: PBIGNUM) cdecl; external CLibCrypto;
  function BN_copy(a: PBIGNUM; b: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  procedure BN_swap(a: PBIGNUM; b: PBIGNUM) cdecl; external CLibCrypto;
  function BN_bin2bn(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_bn2bin(const a: PBIGNUM; to_: PByte): TIdC_INT cdecl; external CLibCrypto;
  function BN_bn2binpad(const a: PBIGNUM; to_: PByte; tolen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_lebin2bn(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_bn2lebinpad(a: PBIGNUM; to_: PByte; tolen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_mpi2bn(const s: PByte; len: TIdC_INT; ret: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_bn2mpi(a: PBIGNUM; to_: PByte): TIdC_INT cdecl; external CLibCrypto;
  function BN_sub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_usub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_uadd(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_add(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_mul(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_sqr(r: PBIGNUM; const a: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  (** BN_set_negative sets sign of a BIGNUM
   * \param  b  pointer to the BIGNUM object
   * \param  n  0 if the BIGNUM b should be positive and a value != 0 otherwise
   *)
  procedure BN_set_negative(b: PBIGNUM; n: TIdC_INT) cdecl; external CLibCrypto;
  (** BN_is_negative returns 1 if the BIGNUM is negative
   * \param  b  pointer to the BIGNUM object
   * \return 1 if a < 0 and 0 otherwise
   *)
  function BN_is_negative(b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;

  function BN_div(dv: PBIGNUM; rem: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
//  # define BN_mod(rem,m,d,ctx) BN_div(NULL,(rem),(m),(d),(ctx))
  function BN_nnmod(r: PBIGNUM; const m: PBIGNUM; const d: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_add(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_add_quick(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_sub(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_sub_quick(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_mul(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_sqr(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_lshift1(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_lshift1_quick(r: PBIGNUM; const a: PBIGNUM; const m: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_lshift(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_lshift_quick(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT; const m: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;

  function BN_mod_word(const a: PBIGNUM; w: BN_ULONG): BN_ULONG cdecl; external CLibCrypto;
  function BN_div_word(a: PBIGNUM; w: BN_ULONG): BN_ULONG cdecl; external CLibCrypto;
  function BN_mul_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_add_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_sub_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_set_word(a: PBIGNUM; w: BN_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function BN_get_word(const a: PBIGNUM): BN_ULONG cdecl; external CLibCrypto;

  function BN_cmp(const a: PBIGNUM; const b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  procedure BN_free(a: PBIGNUM) cdecl; external CLibCrypto;
  function BN_is_bit_set(const a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_lshift(r: PBIGNUM; const a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_lshift1(r: PBIGNUM; const a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_exp(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function BN_mod_exp(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp_mont(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp_mont_consttime(rr: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; in_mont: PBN_MONT_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp_mont_word(r: PBIGNUM; a: BN_ULONG; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp2_mont(r: PBIGNUM; const a1: PBIGNUM; const p1: PBIGNUM; const a2: PBIGNUM; const p2: PBIGNUM; const m: PBIGNUM; ctx: PBN_CTX; m_ctx: PBN_MONT_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp_simple(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function BN_mask_bits(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_print(bio: PBIO; a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_reciprocal(r: PBIGNUM; m: PBIGNUM; len: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_rshift(r: PBIGNUM; a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_rshift1(r: PBIGNUM; a: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  procedure BN_clear(a: PBIGNUM) cdecl; external CLibCrypto;
  function BN_dup(const a: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_ucmp(a: PBIGNUM; b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  function BN_set_bit(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_clear_bit(a: PBIGNUM; n: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function BN_bn2hex(a: PBIGNUM): PIdAnsiChar cdecl; external CLibCrypto;
  function BN_bn2dec(a: PBIGNUM): PIdAnsiChar cdecl; external CLibCrypto;
  function BN_hex2bn(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function BN_dec2bn(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function BN_asc2bn(a: PBIGNUM; str: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function BN_gcd(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_kronecker(a: PBIGNUM; b: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function BN_mod_inverse(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl; external CLibCrypto;
  function BN_mod_sqrt(ret: PBIGNUM; a: PBIGNUM; const n: PBIGNUM; ctx: PBN_CTX): PBIGNUM cdecl; external CLibCrypto;

  procedure BN_consttime_swap(swap: BN_ULONG; a: PBIGNUM; b: PBIGNUM; nwords: TIdC_INT) cdecl; external CLibCrypto;

  function BN_generate_prime_ex(ret: PBIGNUM; bits: TIdC_INT; safe: TIdC_INT; const add: PBIGNUM; const rem: PBIGNUM; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_prime_ex(const p: PBIGNUM; nchecks: TIdC_INT; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;
  function BN_is_prime_fasttest_ex(const p: PBIGNUM; nchecks: TIdC_INT; ctx: PBN_CTX; do_trial_division: TIdC_INT; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;
  function BN_X931_generate_Xpq(Xp: PBIGNUM; Xq: PBIGNUM; nbits: TIdC_INT; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_X931_derive_prime_ex(p: PBIGNUM; p1: PBIGNUM; p2: PBIGNUM; const Xp: PBIGNUM; const Xp1: PBIGNUM; const Xp2: PBIGNUM; const e: PBIGNUM; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;
  function BN_X931_generate_prime_ex(p: PBIGNUM; p1: PBIGNUM; p2: PBIGNUM; Xp1: PBIGNUM; Xp2: PBIGNUM; Xp: PBIGNUM; const e: PBIGNUM; ctx: PBN_CTX; cb: PBN_GENCB): TIdC_INT cdecl; external CLibCrypto;
  function BN_MONT_CTX_new: PBN_MONT_CTX cdecl; external CLibCrypto;
  function BN_mod_mul_montgomery(r: PBIGNUM; const a: PBIGNUM; const b: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_to_montgomery(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_from_montgomery(r: PBIGNUM; a: PBIGNUM; mont: PBN_MONT_CTX; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  procedure BN_MONT_CTX_free(mont: PBN_MONT_CTX) cdecl; external CLibCrypto;
  function BN_MONT_CTX_set(mont: PBN_MONT_CTX; mod_: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_MONT_CTX_copy(&to: PBN_MONT_CTX; from: PBN_MONT_CTX): PBN_MONT_CTX cdecl; external CLibCrypto;
//  function BN_MONT_CTX_set_locked(pmont: ^PBN_MONT_CTX; lock: CRYPTO_RWLOCK; mod_: PBIGNUM; ctx: PBN_CTX): PBN_MONT_CTX;

  function BN_BLINDING_new(const A: PBIGNUM; const Ai: PBIGNUM; mod_: PBIGNUM): PBN_BLINDING cdecl; external CLibCrypto;
  procedure BN_BLINDING_free(b: PBN_BLINDING) cdecl; external CLibCrypto;
  function BN_BLINDING_update(b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_BLINDING_convert(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_BLINDING_invert(n: PBIGNUM; b: PBN_BLINDING; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_BLINDING_convert_ex(n: PBIGNUM; r: PBIGNUM; b: PBN_BLINDING; v4: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_BLINDING_invert_ex(n: PBIGNUM; r: PBIGNUM; b: PBN_BLINDING; v2: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function BN_BLINDING_is_current_thread(b: PBN_BLINDING): TIdC_INT cdecl; external CLibCrypto;
  procedure BN_BLINDING_set_current_thread(b: PBN_BLINDING) cdecl; external CLibCrypto;
  function BN_BLINDING_lock(b: PBN_BLINDING): TIdC_INT cdecl; external CLibCrypto;
  function BN_BLINDING_unlock(b: PBN_BLINDING): TIdC_INT cdecl; external CLibCrypto;

  function BN_BLINDING_get_flags(v1: PBN_BLINDING): TIdC_ULONG cdecl; external CLibCrypto;
  procedure BN_BLINDING_set_flags(v1: PBN_BLINDING; v2: TIdC_ULONG) cdecl; external CLibCrypto;
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

  procedure BN_RECP_CTX_free(recp: PBN_RECP_CTX) cdecl; external CLibCrypto;
  function BN_RECP_CTX_set(recp: PBN_RECP_CTX; rdiv: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_mul_reciprocal(r: PBIGNUM; x: PBIGNUM; y: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_mod_exp_recp(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; m: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_div_recp(dv: PBIGNUM; rem: PBIGNUM; m: PBIGNUM; recp: PBN_RECP_CTX; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  (*
   * Functions for arithmetic over binary polynomials represented by BIGNUMs.
   * The BIGNUM::neg property of BIGNUMs representing binary polynomials is
   * ignored. Note that input arguments are not const so that their bit arrays
   * can be expanded to the appropriate size if needed.
   *)

  (*
   * r = a + b
   *)
  function BN_GF2m_add(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
//  #  define BN_GF2m_sub(r, a, b) BN_GF2m_add(r, a, b)
  (*
   * r=a mod p
   *)
  function BN_GF2m_mod(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM): TIdC_INT cdecl; external CLibCrypto;
  (* r = (a * b) mod p *)
  function BN_GF2m_mod_mul(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r = (a * a) mod p *)
  function BN_GF2m_mod_sqr(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r = (1 / b) mod p *)
  function BN_GF2m_mod_inv(r: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r = (a / b) mod p *)
  function BN_GF2m_mod_div(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r = (a ^ b) mod p *)
  function BN_GF2m_mod_exp(r: PBIGNUM; a: PBIGNUM; b: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r = sqrt(a) mod p *)
  function BN_GF2m_mod_sqrt(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  (* r^2 + r = a mod p *)
  function BN_GF2m_mod_solve_quad(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
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
  function BN_nist_mod_192(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_nist_mod_224(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_nist_mod_256(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_nist_mod_384(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;
  function BN_nist_mod_521(r: PBIGNUM; a: PBIGNUM; p: PBIGNUM; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  function BN_get0_nist_prime_192: PBIGNUM cdecl; external CLibCrypto;
  function BN_get0_nist_prime_224: PBIGNUM cdecl; external CLibCrypto;
  function BN_get0_nist_prime_256: PBIGNUM cdecl; external CLibCrypto;
  function BN_get0_nist_prime_384: PBIGNUM cdecl; external CLibCrypto;
  function BN_get0_nist_prime_521: PBIGNUM cdecl; external CLibCrypto;

//int (*BN_nist_mod_func(const BIGNUM *p)) (BIGNUM *r, const BIGNUM *a,
//                                          const BIGNUM *field, BN_CTX *ctx);

  function BN_generate_dsa_nonce(&out: PBIGNUM; range: PBIGNUM; priv: PBIGNUM; const message_: PByte; message_len: TIdC_SIZET; ctx: PBN_CTX): TIdC_INT cdecl; external CLibCrypto;

  (* Primes from RFC 2409 *)
  function BN_get_rfc2409_prime_768(bn: PBIGNUM ): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc2409_prime_1024(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;

  (* Primes from RFC 3526 *)
  function BN_get_rfc3526_prime_1536(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc3526_prime_2048(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc3526_prime_3072(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc3526_prime_4096(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc3526_prime_6144(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;
  function BN_get_rfc3526_prime_8192(bn: PBIGNUM): PBIGNUM cdecl; external CLibCrypto;

  function BN_bntest_rand(rnd: PBIGNUM; bits: TIdC_INT; top: TIdC_INT; bottom: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

implementation

end.

