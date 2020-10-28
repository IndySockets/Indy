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

unit IdOpenSSLHeaders_objects;

interface

// Headers for OpenSSL 1.1.1
// objects.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

type
  obj_name_st = record
    type_: TIdC_INT;
    alias: TIdC_INT;
    name: PIdAnsiChar;
    data: PIdAnsiChar;
  end;
  OBJ_NAME = obj_name_st;
  POBJ_NAME = ^OBJ_NAME;

//# define         OBJ_create_and_add_object(a,b,c) OBJ_create(a,b,c)

  function OBJ_NAME_init: TIdC_INT cdecl; external CLibCrypto;
  //TIdC_INT OBJ_NAME_new_index(TIdC_ULONG (*hash_func) (const PIdAnsiChar *);
  //                       TIdC_INT (*cmp_func) (const PIdAnsiChar *; const PIdAnsiChar *);
  //                       void (*free_func) (const PIdAnsiChar *; TIdC_INT; const PIdAnsiChar *));
  function OBJ_NAME_get(const name: PIdAnsiChar; type_: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function OBJ_NAME_add(const name: PIdAnsiChar; type_: TIdC_INT; const data: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_NAME_remove(const name: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  procedure OBJ_NAME_cleanup(&type: TIdC_INT) cdecl; external CLibCrypto;
//  void OBJ_NAME_do_all(TIdC_INT type_; void (*fn) (const OBJ_NAME *; void *arg);
//                       void *arg);
//  void OBJ_NAME_do_all_sorted(TIdC_INT type_;
//                              void (*fn) (const OBJ_NAME *; void *arg);
//                              void *arg);

  function OBJ_dup(const o: PASN1_OBJECT): PASN1_OBJECT cdecl; external CLibCrypto;
  function OBJ_nid2obj(n: TIdC_INT): PASN1_OBJECT cdecl; external CLibCrypto;
  function OBJ_nid2ln(n: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function OBJ_nid2sn(n: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function OBJ_obj2nid(const o: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_txt2obj(const s: PIdAnsiChar; no_name: TIdC_INT): PASN1_OBJECT cdecl; external CLibCrypto;
  function OBJ_obj2txt(buf: PIdAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT; no_name: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_txt2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_ln2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_sn2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_cmp(const a: PASN1_OBJECT; const b: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
//  const void *OBJ_bsearch_(const void *key; const void *base; TIdC_INT num; TIdC_INT size;
//                           TIdC_INT (*cmp) (const void *; const void *));
//  const void *OBJ_bsearch_ex_(const void *key; const void *base; TIdC_INT num;
//                              TIdC_INT size;
//                              TIdC_INT (*cmp) (const void *; const void *);
//                              TIdC_INT flags);

  //# define _DECLARE_OBJ_BSEARCH_CMP_FN(scope; type1; type2; nm)    \
  //  static TIdC_INT nm##_cmp_BSEARCH_CMP_FN(const void *; const void *); \
  //  static TIdC_INT nm##_cmp(type1 const *; type2 const *); \
  //  scope type2 * OBJ_bsearch_##nm(type1 *key; type2 const *base; TIdC_INT num)
  //
  //# define DECLARE_OBJ_BSEARCH_CMP_FN(type1; type2; cmp)   \
  //  _DECLARE_OBJ_BSEARCH_CMP_FN(static; type1; type2; cmp)
  //# define DECLARE_OBJ_BSEARCH_GLOBAL_CMP_FN(type1; type2; nm)     \
  //  type2 * OBJ_bsearch_##nm(type1 *key; type2 const *base; TIdC_INT num)

  (*
   * Unsolved problem: if a type is actually a pointer type, like
   * nid_triple is, then its impossible to get a const where you need
   * it. Consider:
   *
   * typedef TIdC_INT nid_triple[3];
   * const void *a_;
   * const nid_triple const *a = a_;
   *
   * The assignment discards a const because what you really want is:
   *
   * const TIdC_INT const * const *a = a_;
   *
   * But if you do that, you lose the fact that a is an array of 3 ints,
   * which breaks comparison functions.
   *
   * Thus we end up having to cast, sadly, or unpack the
   * declarations. Or, as I finally did in this case, declare nid_triple
   * to be a struct, which it should have been in the first place.
   *
   * Ben, August 2008.
   *
   * Also, strictly speaking not all types need be const, but handling
   * the non-constness means a lot of complication, and in practice
   * comparison routines do always not touch their arguments.
   *)

  //# define IMPLEMENT_OBJ_BSEARCH_CMP_FN(type1, type2, nm)  \
  //  static TIdC_INT nm##_cmp_BSEARCH_CMP_FN(const void *a_; const void *b_)    \
  //      { \
  //      type1 const *a = a_; \
  //      type2 const *b = b_; \
  //      return nm##_cmp(a;b); \
  //      } \
  //  static type2 *OBJ_bsearch_##nm(type1 *key; type2 const *base; TIdC_INT num) \
  //      { \
  //      return (type2 *)OBJ_bsearch_(key; base; num; sizeof(type2); \
  //                                        nm##_cmp_BSEARCH_CMP_FN); \
  //      } \
  //      extern void dummy_prototype(void)
  //
  //# define IMPLEMENT_OBJ_BSEARCH_GLOBAL_CMP_FN(type1; type2; nm)   \
  //  static TIdC_INT nm##_cmp_BSEARCH_CMP_FN(const void *a_; const void *b_)    \
  //      { \
  //      type1 const *a = a_; \
  //      type2 const *b = b_; \
  //      return nm##_cmp(a;b); \
  //      } \
  //  type2 *OBJ_bsearch_##nm(type1 *key; type2 const *base; TIdC_INT num) \
  //      { \
  //      return (type2 *)OBJ_bsearch_(key; base; num; sizeof(type2); \
  //                                        nm##_cmp_BSEARCH_CMP_FN); \
  //      } \
  //      extern void dummy_prototype(void)
  //
  //# define OBJ_bsearch(type1;key;type2;base;num;cmp)                              \
  //  ((type2 *)OBJ_bsearch_(CHECKED_PTR_OF(type1;key);CHECKED_PTR_OF(type2;base); \
  //                         num;sizeof(type2);                             \
  //                         ((void)CHECKED_PTR_OF(type1;cmp##_type_1);     \
  //                          (void)CHECKED_PTR_OF(type2;cmp##_type_2);     \
  //                          cmp##_BSEARCH_CMP_FN)))
  //
  //# define OBJ_bsearch_ex(type1;key;type2;base;num;cmp;flags)                      \
  //  ((type2 *)OBJ_bsearch_ex_(CHECKED_PTR_OF(type1;key);CHECKED_PTR_OF(type2;base); \
  //                         num;sizeof(type2);                             \
  //                         ((void)CHECKED_PTR_OF(type1;cmp##_type_1);     \
  //                          (void)type_2=CHECKED_PTR_OF(type2;cmp##_type_2); \
  //                          cmp##_BSEARCH_CMP_FN));flags)

  function OBJ_new_nid(num: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_add_object(const obj: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_create(const oid: PIdAnsiChar; const sn: PIdAnsiChar; const ln: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_create_objects(&in: PBIO): TIdC_INT cdecl; external CLibCrypto;

  function OBJ_length(const obj: PASN1_OBJECT): TIdC_SIZET cdecl; external CLibCrypto;
  function OBJ_get0_data(const obj: PASN1_OBJECT): PByte cdecl; external CLibCrypto;

  function OBJ_find_sigid_algs(signid: TIdC_INT; pdig_nid: PIdC_INT; ppkey_nid: PIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_find_sigid_by_algs(psignid: PIdC_INT; dig_nid: TIdC_INT; pkey_nid: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function OBJ_add_sigid(signid: TIdC_INT; dig_id: TIdC_INT; pkey_id: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  procedure OBJ_sigid_free cdecl; external CLibCrypto;

implementation

end.
