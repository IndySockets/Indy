  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_objects.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_objects.h2pas
     and this file regenerated. IdOpenSSLHeaders_objects.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_objects;

interface

// Headers for OpenSSL 1.1.1
// objects.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
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

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM OBJ_NAME_init}
  {$EXTERNALSYM OBJ_NAME_get}
  {$EXTERNALSYM OBJ_NAME_add}
  {$EXTERNALSYM OBJ_NAME_remove}
  {$EXTERNALSYM OBJ_NAME_cleanup}
  {$EXTERNALSYM OBJ_dup}
  {$EXTERNALSYM OBJ_nid2obj}
  {$EXTERNALSYM OBJ_nid2ln}
  {$EXTERNALSYM OBJ_nid2sn}
  {$EXTERNALSYM OBJ_obj2nid}
  {$EXTERNALSYM OBJ_txt2obj}
  {$EXTERNALSYM OBJ_obj2txt}
  {$EXTERNALSYM OBJ_txt2nid}
  {$EXTERNALSYM OBJ_ln2nid}
  {$EXTERNALSYM OBJ_sn2nid}
  {$EXTERNALSYM OBJ_cmp}
  {$EXTERNALSYM OBJ_new_nid}
  {$EXTERNALSYM OBJ_add_object}
  {$EXTERNALSYM OBJ_create}
  {$EXTERNALSYM OBJ_create_objects}
  {$EXTERNALSYM OBJ_length} {introduced 1.1.0}
  {$EXTERNALSYM OBJ_get0_data} {introduced 1.1.0}
  {$EXTERNALSYM OBJ_find_sigid_algs}
  {$EXTERNALSYM OBJ_find_sigid_by_algs}
  {$EXTERNALSYM OBJ_add_sigid}
  {$EXTERNALSYM OBJ_sigid_free}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  OBJ_NAME_init: function : TIdC_INT; cdecl = nil;
  //TIdC_INT OBJ_NAME_new_index(TIdC_ULONG (*hash_func) (const PIdAnsiChar *);
  //                       TIdC_INT (*cmp_func) (const PIdAnsiChar *; const PIdAnsiChar *);
  //                       void (*free_func) (const PIdAnsiChar *; TIdC_INT; const PIdAnsiChar *));
  OBJ_NAME_get: function (const name: PIdAnsiChar; type_: TIdC_INT): PIdAnsiChar; cdecl = nil;
  OBJ_NAME_add: function (const name: PIdAnsiChar; type_: TIdC_INT; const data: PIdAnsiChar): TIdC_INT; cdecl = nil;
  OBJ_NAME_remove: function (const name: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_NAME_cleanup: procedure (type_: TIdC_INT); cdecl = nil;
//  void OBJ_NAME_do_all(TIdC_INT type_; void (*fn) (const OBJ_NAME *; void *arg);
//                       void *arg);
//  void OBJ_NAME_do_all_sorted(TIdC_INT type_;
//                              void (*fn) (const OBJ_NAME *; void *arg);
//                              void *arg);

  OBJ_dup: function (const o: PASN1_OBJECT): PASN1_OBJECT; cdecl = nil;
  OBJ_nid2obj: function (n: TIdC_INT): PASN1_OBJECT; cdecl = nil;
  OBJ_nid2ln: function (n: TIdC_INT): PIdAnsiChar; cdecl = nil;
  OBJ_nid2sn: function (n: TIdC_INT): PIdAnsiChar; cdecl = nil;
  OBJ_obj2nid: function (const o: PASN1_OBJECT): TIdC_INT; cdecl = nil;
  OBJ_txt2obj: function (const s: PIdAnsiChar; no_name: TIdC_INT): PASN1_OBJECT; cdecl = nil;
  OBJ_obj2txt: function (buf: PIdAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT; no_name: TIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_txt2nid: function (const s: PIdAnsiChar): TIdC_INT; cdecl = nil;
  OBJ_ln2nid: function (const s: PIdAnsiChar): TIdC_INT; cdecl = nil;
  OBJ_sn2nid: function (const s: PIdAnsiChar): TIdC_INT; cdecl = nil;
  OBJ_cmp: function (const a: PASN1_OBJECT; const b: PASN1_OBJECT): TIdC_INT; cdecl = nil;
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

  OBJ_new_nid: function (num: TIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_add_object: function (const obj: PASN1_OBJECT): TIdC_INT; cdecl = nil;
  OBJ_create: function (const oid: PIdAnsiChar; const sn: PIdAnsiChar; const ln: PIdAnsiChar): TIdC_INT; cdecl = nil;
  OBJ_create_objects: function (in_: PBIO): TIdC_INT; cdecl = nil;

  OBJ_length: function (const obj: PASN1_OBJECT): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  OBJ_get0_data: function (const obj: PASN1_OBJECT): PByte; cdecl = nil; {introduced 1.1.0}

  OBJ_find_sigid_algs: function (signid: TIdC_INT; pdig_nid: PIdC_INT; ppkey_nid: PIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_find_sigid_by_algs: function (psignid: PIdC_INT; dig_nid: TIdC_INT; pkey_nid: TIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_add_sigid: function (signid: TIdC_INT; dig_id: TIdC_INT; pkey_id: TIdC_INT): TIdC_INT; cdecl = nil;
  OBJ_sigid_free: procedure ; cdecl = nil;

{$ELSE}
  function OBJ_NAME_init: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //TIdC_INT OBJ_NAME_new_index(TIdC_ULONG (*hash_func) (const PIdAnsiChar *);
  //                       TIdC_INT (*cmp_func) (const PIdAnsiChar *; const PIdAnsiChar *);
  //                       void (*free_func) (const PIdAnsiChar *; TIdC_INT; const PIdAnsiChar *));
  function OBJ_NAME_get(const name: PIdAnsiChar; type_: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_NAME_add(const name: PIdAnsiChar; type_: TIdC_INT; const data: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_NAME_remove(const name: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure OBJ_NAME_cleanup(type_: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  void OBJ_NAME_do_all(TIdC_INT type_; void (*fn) (const OBJ_NAME *; void *arg);
//                       void *arg);
//  void OBJ_NAME_do_all_sorted(TIdC_INT type_;
//                              void (*fn) (const OBJ_NAME *; void *arg);
//                              void *arg);

  function OBJ_dup(const o: PASN1_OBJECT): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_nid2obj(n: TIdC_INT): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_nid2ln(n: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_nid2sn(n: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_obj2nid(const o: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_txt2obj(const s: PIdAnsiChar; no_name: TIdC_INT): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_obj2txt(buf: PIdAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT; no_name: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_txt2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_ln2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_sn2nid(const s: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_cmp(const a: PASN1_OBJECT; const b: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
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

  function OBJ_new_nid(num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_add_object(const obj: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_create(const oid: PIdAnsiChar; const sn: PIdAnsiChar; const ln: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_create_objects(in_: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function OBJ_length(const obj: PASN1_OBJECT): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function OBJ_get0_data(const obj: PASN1_OBJECT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function OBJ_find_sigid_algs(signid: TIdC_INT; pdig_nid: PIdC_INT; ppkey_nid: PIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_find_sigid_by_algs(psignid: PIdC_INT; dig_nid: TIdC_INT; pkey_nid: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function OBJ_add_sigid(signid: TIdC_INT; dig_id: TIdC_INT; pkey_id: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure OBJ_sigid_free cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  OBJ_length_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OBJ_get0_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
function  ERR_OBJ_length(const obj: PASN1_OBJECT): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OBJ_length');
end;


function  ERR_OBJ_get0_data(const obj: PASN1_OBJECT): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OBJ_get0_data');
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
  OBJ_NAME_init := LoadFunction('OBJ_NAME_init',AFailed);
  OBJ_NAME_get := LoadFunction('OBJ_NAME_get',AFailed);
  OBJ_NAME_add := LoadFunction('OBJ_NAME_add',AFailed);
  OBJ_NAME_remove := LoadFunction('OBJ_NAME_remove',AFailed);
  OBJ_NAME_cleanup := LoadFunction('OBJ_NAME_cleanup',AFailed);
  OBJ_dup := LoadFunction('OBJ_dup',AFailed);
  OBJ_nid2obj := LoadFunction('OBJ_nid2obj',AFailed);
  OBJ_nid2ln := LoadFunction('OBJ_nid2ln',AFailed);
  OBJ_nid2sn := LoadFunction('OBJ_nid2sn',AFailed);
  OBJ_obj2nid := LoadFunction('OBJ_obj2nid',AFailed);
  OBJ_txt2obj := LoadFunction('OBJ_txt2obj',AFailed);
  OBJ_obj2txt := LoadFunction('OBJ_obj2txt',AFailed);
  OBJ_txt2nid := LoadFunction('OBJ_txt2nid',AFailed);
  OBJ_ln2nid := LoadFunction('OBJ_ln2nid',AFailed);
  OBJ_sn2nid := LoadFunction('OBJ_sn2nid',AFailed);
  OBJ_cmp := LoadFunction('OBJ_cmp',AFailed);
  OBJ_new_nid := LoadFunction('OBJ_new_nid',AFailed);
  OBJ_add_object := LoadFunction('OBJ_add_object',AFailed);
  OBJ_create := LoadFunction('OBJ_create',AFailed);
  OBJ_create_objects := LoadFunction('OBJ_create_objects',AFailed);
  OBJ_find_sigid_algs := LoadFunction('OBJ_find_sigid_algs',AFailed);
  OBJ_find_sigid_by_algs := LoadFunction('OBJ_find_sigid_by_algs',AFailed);
  OBJ_add_sigid := LoadFunction('OBJ_add_sigid',AFailed);
  OBJ_sigid_free := LoadFunction('OBJ_sigid_free',AFailed);
  OBJ_length := LoadFunction('OBJ_length',nil); {introduced 1.1.0}
  OBJ_get0_data := LoadFunction('OBJ_get0_data',nil); {introduced 1.1.0}
  if not assigned(OBJ_length) then 
  begin
    {$if declared(OBJ_length_introduced)}
    if LibVersion < OBJ_length_introduced then
      {$if declared(FC_OBJ_length)}
      OBJ_length := @FC_OBJ_length
      {$else}
      OBJ_length := @ERR_OBJ_length
      {$ifend}
    else
    {$ifend}
   {$if declared(OBJ_length_removed)}
   if OBJ_length_removed <= LibVersion then
     {$if declared(_OBJ_length)}
     OBJ_length := @_OBJ_length
     {$else}
       {$IF declared(ERR_OBJ_length)}
       OBJ_length := @ERR_OBJ_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OBJ_length) and Assigned(AFailed) then 
     AFailed.Add('OBJ_length');
  end;


  if not assigned(OBJ_get0_data) then 
  begin
    {$if declared(OBJ_get0_data_introduced)}
    if LibVersion < OBJ_get0_data_introduced then
      {$if declared(FC_OBJ_get0_data)}
      OBJ_get0_data := @FC_OBJ_get0_data
      {$else}
      OBJ_get0_data := @ERR_OBJ_get0_data
      {$ifend}
    else
    {$ifend}
   {$if declared(OBJ_get0_data_removed)}
   if OBJ_get0_data_removed <= LibVersion then
     {$if declared(_OBJ_get0_data)}
     OBJ_get0_data := @_OBJ_get0_data
     {$else}
       {$IF declared(ERR_OBJ_get0_data)}
       OBJ_get0_data := @ERR_OBJ_get0_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OBJ_get0_data) and Assigned(AFailed) then 
     AFailed.Add('OBJ_get0_data');
  end;


end;

procedure Unload;
begin
  OBJ_NAME_init := nil;
  OBJ_NAME_get := nil;
  OBJ_NAME_add := nil;
  OBJ_NAME_remove := nil;
  OBJ_NAME_cleanup := nil;
  OBJ_dup := nil;
  OBJ_nid2obj := nil;
  OBJ_nid2ln := nil;
  OBJ_nid2sn := nil;
  OBJ_obj2nid := nil;
  OBJ_txt2obj := nil;
  OBJ_obj2txt := nil;
  OBJ_txt2nid := nil;
  OBJ_ln2nid := nil;
  OBJ_sn2nid := nil;
  OBJ_cmp := nil;
  OBJ_new_nid := nil;
  OBJ_add_object := nil;
  OBJ_create := nil;
  OBJ_create_objects := nil;
  OBJ_length := nil; {introduced 1.1.0}
  OBJ_get0_data := nil; {introduced 1.1.0}
  OBJ_find_sigid_algs := nil;
  OBJ_find_sigid_by_algs := nil;
  OBJ_add_sigid := nil;
  OBJ_sigid_free := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
