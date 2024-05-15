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

unit IdOpenSSLHeaders_asn1t;

interface

// Headers for OpenSSL 1.1.1
// asn1t.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;
  
type
  // moved from asn1
  ASN1_ITEM_EXP = ASN1_ITEM;
  PASN1_ITEM_EXP = ^ASN1_ITEM_EXP;

//# ifndef OPENSSL_EXPORT_VAR_AS_FUNCTION
//
///// Macro to obtain ASN1_ADB pointer from a type (only used internally) ///
//#  define ASN1_ADB_ptr(iptr) ((const ASN1_ADB //)(iptr))
//
///// Macros for start and end of ASN1_ITEM definition ///
//
//#  define ASN1_ITEM_start(itname) \
//        const ASN1_ITEM itname##_it = {
//
//#  define static_ASN1_ITEM_start(itname) \
//        static const ASN1_ITEM itname##_it = {
//
//#  define ASN1_ITEM_end(itname)                 \
//                };
//
//# else
//
///// Macro to obtain ASN1_ADB pointer from a type (only used internally) ///
//#  define ASN1_ADB_ptr(iptr) ((const ASN1_ADB //)((iptr)()))
//
///// Macros for start and end of ASN1_ITEM definition ///
//
//#  define ASN1_ITEM_start(itname) \
//        const ASN1_ITEM // itname##_it(void) \
//        { \
//                static const ASN1_ITEM local_it = {
//
//#  define static_ASN1_ITEM_start(itname) \
//        static ASN1_ITEM_start(itname)
//
//#  define ASN1_ITEM_end(itname) \
//                }; \
//        return &local_it; \
//        }
//
//# endif
//
///// Macros to aid ASN1 template writing ///
//
//  ASN1_ITEM_TEMPLATE(tname) \
//        static const PASN1_TEMPLATE tname##_item_tt
//
//  ASN1_ITEM_TEMPLATE_END(tname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_PRIMITIVE,\
//                -1,\
//                &tname##_item_tt,\
//                0,\
//                NULL,\
//                0,\
//                #tname \
//        ASN1_ITEM_end(tname)
//  static_ASN1_ITEM_TEMPLATE_END(tname) \
//        ;\
//        static_ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_PRIMITIVE,\
//                -1,\
//                &tname##_item_tt,\
//                0,\
//                NULL,\
//                0,\
//                #tname \
//        ASN1_ITEM_end(tname)
//
///// This is a ASN1 type which just embeds a template ///
//
/////-
// // This pair helps declare a SEQUENCE. We can do:
// //
// //      ASN1_SEQUENCE(stname) = {
// //              ... SEQUENCE components ...
// //      } ASN1_SEQUENCE_END(stname)
// //
// //      This will produce an ASN1_ITEM called stname_it
// //      for a structure called stname.
// //
// //      If you want the same structure but a different
// //      name then use:
// //
// //      ASN1_SEQUENCE(itname) = {
// //              ... SEQUENCE components ...
// //      } ASN1_SEQUENCE_END_name(stname, itname)
// //
// //      This will create an item called itname_it using
// //      a structure called stname.
// ///
//
//  ASN1_SEQUENCE(tname) \
//        static const PASN1_TEMPLATE tname##_seq_tt[]
//
//  ASN1_SEQUENCE_END(stname) ASN1_SEQUENCE_END_name(stname, stname)
//
//  static_ASN1_SEQUENCE_END(stname) static_ASN1_SEQUENCE_END_name(stname, stname)
//
//  ASN1_SEQUENCE_END_name(stname, tname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(stname),\
//                #tname \
//        ASN1_ITEM_end(tname)
//
//  static_ASN1_SEQUENCE_END_name(stname, tname) \
//        ;\
//        static_ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
//  ASN1_NDEF_SEQUENCE(tname) \
//        ASN1_SEQUENCE(tname)
//
//  ASN1_NDEF_SEQUENCE_cb(tname, cb) \
//        ASN1_SEQUENCE_cb(tname, cb)
//
//  ASN1_SEQUENCE_cb(tname, cb) \
//        static const ASN1_AUX tname##_aux = {NULL, 0, 0, 0, cb, 0}; \
//        ASN1_SEQUENCE(tname)
//
//  ASN1_BROKEN_SEQUENCE(tname) \
//        static const ASN1_AUX tname##_aux = {NULL, ASN1_AFLG_BROKEN, 0, 0, 0, 0}; \
//        ASN1_SEQUENCE(tname)
//
//  ASN1_SEQUENCE_ref(tname, cb) \
//        static const ASN1_AUX tname##_aux = {NULL, ASN1_AFLG_REFCOUNT, offsetof(tname, references), offsetof(tname, lock), cb, 0}; \
//        ASN1_SEQUENCE(tname)
//
//  ASN1_SEQUENCE_enc(tname, enc, cb) \
//        static const ASN1_AUX tname##_aux = {NULL, ASN1_AFLG_ENCODING, 0, 0, cb, offsetof(tname, enc)}; \
//        ASN1_SEQUENCE(tname)
//
//  ASN1_NDEF_SEQUENCE_END(tname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_NDEF_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(tname),\
//                #tname \
//        ASN1_ITEM_end(tname)
//  static_ASN1_NDEF_SEQUENCE_END(tname) \
//        ;\
//        static_ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_NDEF_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(tname),\
//                #tname \
//        ASN1_ITEM_end(tname)
//
//  ASN1_BROKEN_SEQUENCE_END(stname) ASN1_SEQUENCE_END_ref(stname, stname)
//  static_ASN1_BROKEN_SEQUENCE_END(stname) \
//        static_ASN1_SEQUENCE_END_ref(stname, stname)
//
//  ASN1_SEQUENCE_END_enc(stname, tname) ASN1_SEQUENCE_END_ref(stname, tname)
//
//  ASN1_SEQUENCE_END_cb(stname, tname) ASN1_SEQUENCE_END_ref(stname, tname)
//  static_ASN1_SEQUENCE_END_cb(stname, tname) static_ASN1_SEQUENCE_END_ref(stname, tname)
//
//  ASN1_SEQUENCE_END_ref(stname, tname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                &tname##_aux,\
//                sizeof(stname),\
//                #tname \
//        ASN1_ITEM_end(tname)
//  static_ASN1_SEQUENCE_END_ref(stname, tname) \
//        ;\
//        static_ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                &tname##_aux,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
//  ASN1_NDEF_SEQUENCE_END_cb(stname, tname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_NDEF_SEQUENCE,\
//                V_ASN1_SEQUENCE,\
//                tname##_seq_tt,\
//                sizeof(tname##_seq_tt) / sizeof(PASN1_TEMPLATE),\
//                &tname##_aux,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
/////-
// // This pair helps declare a CHOICE type. We can do:
// //
// //      ASN1_CHOICE(chname) = {
// //              ... CHOICE options ...
// //      ASN1_CHOICE_END(chname)
// //
// //      This will produce an ASN1_ITEM called chname_it
// //      for a structure called chname. The structure
// //      definition must look like this:
// //      typedef struct {
// //              int type;
// //              union {
// //                      ASN1_SOMETHING //opt1;
// //                      ASN1_SOMEOTHER //opt2;
// //              } value;
// //      } chname;
// //
// //      the name of the selector must be 'type'.
// //      to use an alternative selector name use the
// //      ASN1_CHOICE_END_selector() version.
// ///
//
//  ASN1_CHOICE(tname) \
//        static const PASN1_TEMPLATE tname##_ch_tt[]
//
//  ASN1_CHOICE_cb(tname, cb) \
//        static const ASN1_AUX tname##_aux = {NULL, 0, 0, 0, cb, 0}; \
//        ASN1_CHOICE(tname)
//
//  ASN1_CHOICE_END(stname) ASN1_CHOICE_END_name(stname, stname)
//
//  static_ASN1_CHOICE_END(stname) static_ASN1_CHOICE_END_name(stname, stname)
//
//  ASN1_CHOICE_END_name(stname, tname) ASN1_CHOICE_END_selector(stname, tname, type)
//
//  static_ASN1_CHOICE_END_name(stname, tname) static_ASN1_CHOICE_END_selector(stname, tname, type)
//
//  ASN1_CHOICE_END_selector(stname, tname, selname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_CHOICE,\
//                offsetof(stname,selname) ,\
//                tname##_ch_tt,\
//                sizeof(tname##_ch_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
//  static_ASN1_CHOICE_END_selector(stname, tname, selname) \
//        ;\
//        static_ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_CHOICE,\
//                offsetof(stname,selname) ,\
//                tname##_ch_tt,\
//                sizeof(tname##_ch_tt) / sizeof(PASN1_TEMPLATE),\
//                NULL,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
//  ASN1_CHOICE_END_cb(stname, tname, selname) \
//        ;\
//        ASN1_ITEM_start(tname) \
//                ASN1_ITYPE_CHOICE,\
//                offsetof(stname,selname) ,\
//                tname##_ch_tt,\
//                sizeof(tname##_ch_tt) / sizeof(PASN1_TEMPLATE),\
//                &tname##_aux,\
//                sizeof(stname),\
//                #stname \
//        ASN1_ITEM_end(tname)
//
///// This helps with the template wrapper form of ASN1_ITEM ///
//
//  ASN1_EX_TEMPLATE_TYPE(flags, tag, name, type) { \
//        (flags), (tag), 0,\
//        #name, ASN1_ITEM_ref(type) }
//
///// These help with SEQUENCE or CHOICE components ///
//
///// used to declare other types ///
//
//  ASN1_EX_TYPE(flags, tag, stname, field, type) { \
//        (flags), (tag), offsetof(stname, field),\
//        #field, ASN1_ITEM_ref(type) }
//
///// implicit and explicit helper macros ///
//
//  ASN1_IMP_EX(stname, field, type, tag, ex) \
//         ASN1_EX_TYPE(ASN1_TFLG_IMPLICIT | (ex), tag, stname, field, type)
//
//  ASN1_EXP_EX(stname, field, type, tag, ex) \
//         ASN1_EX_TYPE(ASN1_TFLG_EXPLICIT | (ex), tag, stname, field, type)
//
///// Any defined by macros: the field used is in the table itself ///
//
//# ifndef OPENSSL_EXPORT_VAR_AS_FUNCTION
//#  define ASN1_ADB_OBJECT(tblname) { ASN1_TFLG_ADB_OID, -1, 0, #tblname, (const ASN1_ITEM //)&(tblname##_adb) }
//#  define ASN1_ADB_INTEGER(tblname) { ASN1_TFLG_ADB_INT, -1, 0, #tblname, (const ASN1_ITEM //)&(tblname##_adb) }
//# else
//#  define ASN1_ADB_OBJECT(tblname) { ASN1_TFLG_ADB_OID, -1, 0, #tblname, tblname##_adb }
//#  define ASN1_ADB_INTEGER(tblname) { ASN1_TFLG_ADB_INT, -1, 0, #tblname, tblname##_adb }
//# endif
///// Plain simple type ///
//  ASN1_SIMPLE(stname, field, type) ASN1_EX_TYPE(0,0, stname, field, type)
///// Embedded simple type ///
//  ASN1_EMBED(stname, field, type) ASN1_EX_TYPE(ASN1_TFLG_EMBED,0, stname, field, type)
//
///// OPTIONAL simple type ///
//  ASN1_OPT(stname, field, type) ASN1_EX_TYPE(ASN1_TFLG_OPTIONAL, 0, stname, field, type)
//  ASN1_OPT_EMBED(stname, field, type) ASN1_EX_TYPE(ASN1_TFLG_OPTIONAL|ASN1_TFLG_EMBED, 0, stname, field, type)
//
///// IMPLICIT tagged simple type ///
//  ASN1_IMP(stname, field, type, tag) ASN1_IMP_EX(stname, field, type, tag, 0)
//  ASN1_IMP_EMBED(stname, field, type, tag) ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_EMBED)
//
///// IMPLICIT tagged OPTIONAL simple type ///
//  ASN1_IMP_OPT(stname, field, type, tag) ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_OPTIONAL)
//  ASN1_IMP_OPT_EMBED(stname, field, type, tag) ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_OPTIONAL|ASN1_TFLG_EMBED)
//
///// Same as above but EXPLICIT ///
//
//  ASN1_EXP(stname, field, type, tag) ASN1_EXP_EX(stname, field, type, tag, 0)
//  ASN1_EXP_EMBED(stname, field, type, tag) ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_EMBED)
//  ASN1_EXP_OPT(stname, field, type, tag) ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_OPTIONAL)
//  ASN1_EXP_OPT_EMBED(stname, field, type, tag) ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_OPTIONAL|ASN1_TFLG_EMBED)
//
///// SEQUENCE OF type ///
//  ASN1_SEQUENCE_OF(stname, field, type) \
//                ASN1_EX_TYPE(ASN1_TFLG_SEQUENCE_OF, 0, stname, field, type)
//
///// OPTIONAL SEQUENCE OF ///
//  ASN1_SEQUENCE_OF_OPT(stname, field, type) \
//                ASN1_EX_TYPE(ASN1_TFLG_SEQUENCE_OF|ASN1_TFLG_OPTIONAL, 0, stname, field, type)
//
///// Same as above but for SET OF ///
//
//  ASN1_SET_OF(stname, field, type) \
//                ASN1_EX_TYPE(ASN1_TFLG_SET_OF, 0, stname, field, type)
//
//  ASN1_SET_OF_OPT(stname, field, type) \
//                ASN1_EX_TYPE(ASN1_TFLG_SET_OF|ASN1_TFLG_OPTIONAL, 0, stname, field, type)
//
///// Finally compound types of SEQUENCE, SET, IMPLICIT, EXPLICIT and OPTIONAL ///
//
//  ASN1_IMP_SET_OF(stname, field, type, tag) \
//                        ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_SET_OF)
//
//  ASN1_EXP_SET_OF(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_SET_OF)
//
//  ASN1_IMP_SET_OF_OPT(stname, field, type, tag) \
//                        ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_SET_OF|ASN1_TFLG_OPTIONAL)
//
//  ASN1_EXP_SET_OF_OPT(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_SET_OF|ASN1_TFLG_OPTIONAL)
//
//  ASN1_IMP_SEQUENCE_OF(stname, field, type, tag) \
//                        ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_SEQUENCE_OF)
//
//  ASN1_IMP_SEQUENCE_OF_OPT(stname, field, type, tag) \
//                        ASN1_IMP_EX(stname, field, type, tag, ASN1_TFLG_SEQUENCE_OF|ASN1_TFLG_OPTIONAL)
//
//  ASN1_EXP_SEQUENCE_OF(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_SEQUENCE_OF)
//
//  ASN1_EXP_SEQUENCE_OF_OPT(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_SEQUENCE_OF|ASN1_TFLG_OPTIONAL)
//
///// EXPLICIT using indefinite length constructed form ///
//  ASN1_NDEF_EXP(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_NDEF)
//
///// EXPLICIT OPTIONAL using indefinite length constructed form ///
//  ASN1_NDEF_EXP_OPT(stname, field, type, tag) \
//                        ASN1_EXP_EX(stname, field, type, tag, ASN1_TFLG_OPTIONAL|ASN1_TFLG_NDEF)
//
///// Macros for the ASN1_ADB structure ///
//
//  ASN1_ADB(name) \
//        static const ASN1_ADB_TABLE name##_adbtbl[]
//
//# ifndef OPENSSL_EXPORT_VAR_AS_FUNCTION
//
//#  define ASN1_ADB_END(name, flags, field, adb_cb, def, none) \
//        ;\
//        static const ASN1_ADB name##_adb = {\
//                flags,\
//                offsetof(name, field),\
//                adb_cb,\
//                name##_adbtbl,\
//                sizeof(name##_adbtbl) / sizeof(ASN1_ADB_TABLE),\
//                def,\
//                none\
//        }
//
//# else
//
//#  define ASN1_ADB_END(name, flags, field, adb_cb, def, none) \
//        ;\
//        static const ASN1_ITEM //name##_adb(void) \
//        { \
//        static const ASN1_ADB internal_adb = \
//                {\
//                flags,\
//                offsetof(name, field),\
//                adb_cb,\
//                name##_adbtbl,\
//                sizeof(name##_adbtbl) / sizeof(ASN1_ADB_TABLE),\
//                def,\
//                none\
//                }; \
//                return (const ASN1_ITEM //) &internal_adb; \
//        } \
//        void dummy_function(void)
//
//# endif
//
//  ADB_ENTRY(val, template) {val, template}
//
//  ASN1_ADB_TEMPLATE(name) \
//        static const PASN1_TEMPLATE name##_tt
//
/////
// // This is the ASN1 template structure that defines a wrapper round the
// // actual type. It determines the actual position of the field in the value
// // structure, various flags such as OPTIONAL and the field name.
// ///

type
  ASN1_TEMPLATE_st = record
    flags: TIdC_ULONG;
    tag: TIdC_LONG;
    offset: TIdC_ULONG;
    fieldname: PIdAnsiChar;
    item: PASN1_ITEM_EXP;
  end;  
  ASN1_TEMPLATE = ASN1_TEMPLATE_st;
  PASN1_TEMPLATE = ^ASN1_TEMPLATE;

///// Macro to extract ASN1_ITEM and ASN1_ADB pointer from PASN1_TEMPLATE ///
//
//  ASN1_TEMPLATE_item(t) (t->item_ptr)
//  ASN1_TEMPLATE_adb(t) (t->item_ptr)

  adb_cb_callback = function(psel: PIdC_LONG): TIdC_INT;

  ASN1_ADB_TABLE_st = record
    value: TIdC_LONG;
    tt: PASN1_TEMPLATE;
  end;

  ASN1_ADB_TABLE = ASN1_ADB_TABLE_st;
  PASN1_ADB_TABLE = ^ASN1_ADB_TABLE;
  
  ASN1_ADB_st = record
    flags: TIdC_ULONG;
    offset: TIdC_ULONG;
    adb_cb: adb_cb_callback;
    tbl: PASN1_ADB_TABLE;
    tblcount: TIdC_LONG;
    default_tt: PASN1_TEMPLATE;
    null_tt: PASN1_TEMPLATE;
  end;
  ASN1_ADB = ASN1_ADB_st;

const
// template flags //

// Field is optional //
  ASN1_TFLG_OPTIONAL     = $1;

// Field is a SET OF //
  ASN1_TFLG_SET_OF       = ($1 shl 1);

// Field is a SEQUENCE OF //
  ASN1_TFLG_SEQUENCE_OF  = ($2 shl 1);

//
// Special case: this refers to a SET OF that will be sorted into DER order
// when encoded /and/ the corresponding STACK will be modified to match the
// new order.
 //
  ASN1_TFLG_SET_ORDER     = ($3 shl 1);

// Mask for SET OF or SEQUENCE OF //
  ASN1_TFLG_SK_MASK       = ($3 shl 1);

//
//  These flags mean the tag should be taken from the tag field. If EXPLICIT
//  then the underlying type is used for the inner tag.
 //

// IMPLICIT tagging //
  ASN1_TFLG_IMPTAG        = ($1 shl 3);

// EXPLICIT tagging, inner tag from underlying type //
  ASN1_TFLG_EXPTAG        = ($2 shl 3);

  ASN1_TFLG_TAG_MASK      = ($3 shl 3);

// context specific IMPLICIT //
//   ASN1_TFLG_IMPLICIT      (ASN1_TFLG_IMPTAG|ASN1_TFLG_CONTEXT)

// context specific EXPLICIT //
//   ASN1_TFLG_EXPLICIT      (ASN1_TFLG_EXPTAG|ASN1_TFLG_CONTEXT)

//
// If tagging is in force these determine the type of tag to use. Otherwise
// the tag is determined by the underlying type. These values reflect the
// actual octet format.
 //

// Universal tag //
  ASN1_TFLG_UNIVERSAL     = ($0 shl 6);
// Application tag //
  ASN1_TFLG_APPLICATION   = ($1 shl 6);
// Context specific tag //
  ASN1_TFLG_CONTEXT       = ($2 shl 6);
// Private tag //
  ASN1_TFLG_PRIVATE       = ($3 shl 6);

  ASN1_TFLG_TAG_CLASS     = ($3 shl 6);

//
// These are for ANY DEFINED BY type. In this case the 'item' field points to
// an ASN1_ADB structure which contains a table of values to decode the
// relevant type
 //

  ASN1_TFLG_ADB_MASK      = ($3 shl 8);

  ASN1_TFLG_ADB_OID       = ($1 shl 8);

  ASN1_TFLG_ADB_INT       = ($1 shl 9);

//
// This flag when present in a SEQUENCE OF, SET OF or EXPLICIT causes
// indefinite length constructed encoding to be used if required.
 //

  ASN1_TFLG_NDEF          = ($1 shl 11);

// Field is embedded and not a pointer //
  ASN1_TFLG_EMBED         = ($1 shl 12);

// This is the actual ASN1 item itself //

type
  ASN1_ITEM_st = record
    itype: AnsiChar;
    utype: TIdC_LONG;
    template: PASN1_TEMPLATE;
    tcount: TIdC_LONG;
    funcs: Pointer;
    size: TIdC_LONG;
    sname: PIdAnsiChar;
  end;

//-
 // These are values for the itype field and
 // determine how the type is interpreted.
 //
 // For PRIMITIVE types the underlying type
 // determines the behaviour if items is NULL.
 //
 // Otherwise templates must contain a single
 // template and the type is treated in the
 // same way as the type specified in the template.
 //
 // For SEQUENCE types the templates field points
 // to the members, the size field is the
 // structure size.
 //
 // For CHOICE types the templates field points
 // to each possible member (typically a union)
 // and the 'size' field is the offset of the
 // selector.
 //
 // The 'funcs' field is used for application
 // specific functions.
 //
 // The EXTERN type uses a new style d2i/i2d.
 // The new style should be used where possible
 // because it avoids things like the d2i IMPLICIT
 // hack.
 //
 // MSTRING is a multiple string type, it is used
 // for a CHOICE of character strings where the
 // actual strings all occupy an ASN1_STRING
 // structure. In this case the 'utype' field
 // has a special meaning, it is used as a mask
 // of acceptable types using the B_ASN1 constants.
 //
 // NDEF_SEQUENCE is the same as SEQUENCE except
 // that it will use indefinite length constructed
 // encoding if requested.
 //
 //
const
  ASN1_ITYPE_PRIMITIVE            = $0;

  ASN1_ITYPE_SEQUENCE             = $1;

  ASN1_ITYPE_CHOICE               = $2;

  ASN1_ITYPE_EXTERN               = $4;

  ASN1_ITYPE_MSTRING              = $5;

  ASN1_ITYPE_NDEF_SEQUENCE        = $6;

//
 // Cache for ASN1 tag and length, so we don't keep re-reading it for things
 // like CHOICE
 //

type
  ASN1_TLC_st = record
    valid: AnsiChar;
    ret: TIdC_INT;
    plen: TIdC_LONG;
    ptag: TIdC_INT;
    pclass: TIdC_INT;
    hdrlen: TIdC_INT;
  end;
  ASN1_TLC = ASN1_TLC_st;
  PASN1_TLC = ^ASN1_TLC;

  ASN1_ex_d2i = function(pval: PPASN1_VALUE; const AIn: PPByte; len: TIdC_LONG;
    const it: PASN1_ITEM; tag: TIdC_INT; aclass: TIdC_INT;
    opt: AnsiChar; ctx: PASN1_TLC): TIdC_INT;
  PASN1_ex_d2i = ^ASN1_ex_d2i;

  ASN1_ex_i2d = function(pval: PPASN1_VALUE; AOut: PPByte; const it: PASN1_ITEM;
    tag: TIdC_INT; aclass: TIdC_INT): TIdC_INT;
  PASN1_ex_i2d = ^ASN1_ex_i2d;

  ASN1_ex_new_func = function(pval: PPASN1_VALUE; const it: PASN1_ITEM): TIdC_INT;
  PASN1_ex_new_func = ^ASN1_ex_new_func;

  ASN1_ex_free_func = procedure(pval: PPASN1_VALUE; const it: PASN1_ITEM);
  PASN1_ex_free_func = ^ASN1_ex_free_func;

  ASN1_ex_print_func = function(AOut: PBIO; pval: PPASN1_VALUE; indent: TIdC_INT;
    const fname: PIdAnsiChar; const pctx: PASN1_PCTX): TIdC_INT;
  PASN1_ex_print_func = ^ASN1_ex_print_func;

  ASN1_primitive_i2c = function(pval: PPASN1_VALUE; const cont: PIdAnsiChar;
    puttype: PIdC_INT; const it: PASN1_ITEM): TIdC_INT;
  PASN1_primitive_i2c = ^ASN1_primitive_i2c;

  ASN1_primitive_c2i = function(pval: PPASN1_VALUE; const cont: PByte;
    len: TIdC_INT; utype: TIdC_INT; free_cont: PIdAnsiChar;
    const it: PASN1_ITEM): TIdC_INT;
  PASN1_primitive_c2i = ^ASN1_primitive_c2i;

  ASN1_primitive_print = function(AOut: PBIO; pval: PPASN1_VALUE;
    const it: PASN1_ITEM; indent: TIdC_INT; const pctx: PASN1_PCTX): TIdC_INT;
  PASN1_primitive_print = ^ASN1_primitive_print;

  ASN1_EXTERN_FUNCS_st = record
    app_data: Pointer;
    asn1_ex_new: PASN1_ex_new_func;
    asn1_ex_free: PASN1_ex_free_func;
    asn1_ex_clear: PASN1_ex_free_func;
    asn1_ex_d2i: PASN1_ex_d2i;
    asn1_ex_i2d: PASN1_ex_i2d;
    asn1_ex_print: PASN1_ex_print_func;
  end;

  ASN1_EXTERN_FUNCS = ASN1_EXTERN_FUNCS_st;

  ASN1_PRIMITIVE_FUNCS_st = record
    app_data: Pointer;
    flags: TIdC_ULONG;
    prim_new: PASN1_ex_new_func;
    prim_free: PASN1_ex_free_func;
    prim_clear: PASN1_ex_free_func;
    prim_c2i: PASN1_primitive_c2i;
    prim_i2c: PASN1_primitive_i2c;
    prim_print: PASN1_primitive_print;
  end;

  ASN1_PRIMITIVE_FUNCS = ASN1_PRIMITIVE_FUNCS_st;

//
 // This is the ASN1_AUX structure: it handles various miscellaneous
 // requirements. For example the use of reference counts and an informational
 // callback. The "informational callback" is called at various points during
 // the ASN1 encoding and decoding. It can be used to provide minor
 // customisation of the structures used. This is most useful where the
 // supplied routines //almost// do the right thing but need some extra help at
 // a few points. If the callback returns zero then it is assumed a fatal
 // error has occurred and the main operation should be abandoned. If major
 // changes in the default behaviour are required then an external type is
 // more appropriate.
 //

  ASN1_aux_cb = function(operation: TIdC_INT; AIn: PASN1_VALUE; const it: PASN1_ITEM; exarg: Pointer): TIdC_INT;
  PASN1_aux_cb = ^ASN1_aux_cb;

  ASN1_AUX_st = record
    app_data: Pointer;
    flags: TIdC_INT;
    ref_offset: TIdC_INT;
    ref_lock: TIdC_INT;
    asn1_cb: PASN1_aux_cb;
    enc_offset: TidC_INT;
  end;

  ASN1_AUX = ASN1_AUX_st;

// For print related callbacks exarg points to this structure

  ASN1_PRINT_ARG_st = record
    AOut: PBIO;
    indent: TIdC_INT;
    pctx: PASN1_PCTX;
  end;

  ASN1_PRINT_ARG = ASN1_PRINT_ARG_st;

// For streaming related callbacks exarg points to this structure
  ASN1_STREAM_ARG_st = record
    // BIO to stream through
    FOut: PBIO;
    // BIO with filters appended
    ndef_bio: PBIO;
    // Streaming I/O boundary
    boundary: PPByte;
  end;

  ASN1_STREAM_ARG = ASN1_STREAM_ARG_st;

const
/// Flags in ASN1_AUX ///

/// Use a reference count ///
  ASN1_AFLG_REFCOUNT      = 1;
/// Save the encoding of structure (useful for signatures) ///
  ASN1_AFLG_ENCODING      = 2;
/// The Sequence length is invalid ///
  ASN1_AFLG_BROKEN        = 4;

/// operation values for asn1_cb ///

  ASN1_OP_NEW_PRE         = 0;
  ASN1_OP_NEW_POST        = 1;
  ASN1_OP_FREE_PRE        = 2;
  ASN1_OP_FREE_POST       = 3;
  ASN1_OP_D2I_PRE         = 4;
  ASN1_OP_D2I_POST        = 5;
  ASN1_OP_I2D_PRE         = 6;
  ASN1_OP_I2D_POST        = 7;
  ASN1_OP_PRINT_PRE       = 8;
  ASN1_OP_PRINT_POST      = 9;
  ASN1_OP_STREAM_PRE      = 10;
  ASN1_OP_STREAM_POST     = 11;
  ASN1_OP_DETACHED_PRE    = 12;
  ASN1_OP_DETACHED_POST   = 13;

///* Macro to implement a primitive type */
//# define IMPLEMENT_ASN1_TYPE(stname) IMPLEMENT_ASN1_TYPE_ex(stname, stname, 0)
//# define IMPLEMENT_ASN1_TYPE_ex(itname, vname, ex) \
//                                ASN1_ITEM_start(itname) \
//                                        ASN1_ITYPE_PRIMITIVE, V_##vname, NULL, 0, NULL, ex, #itname \
//                                ASN1_ITEM_end(itname)
//
///* Macro to implement a multi string type */
//# define IMPLEMENT_ASN1_MSTRING(itname, mask) \
//                                ASN1_ITEM_start(itname) \
//                                        ASN1_ITYPE_MSTRING, mask, NULL, 0, NULL, sizeof(ASN1_STRING), #itname \
//                                ASN1_ITEM_end(itname)
//
//# define IMPLEMENT_EXTERN_ASN1(sname, tag, fptrs) \
//        ASN1_ITEM_start(sname) \
//                ASN1_ITYPE_EXTERN, \
//                tag, \
//                NULL, \
//                0, \
//                &fptrs, \
//                0, \
//                #sname \
//        ASN1_ITEM_end(sname)
//
///* Macro to implement standard functions in terms of ASN1_ITEM structures */
//
//# define IMPLEMENT_ASN1_FUNCTIONS(stname) IMPLEMENT_ASN1_FUNCTIONS_fname(stname, stname, stname)
//
//# define IMPLEMENT_ASN1_FUNCTIONS_name(stname, itname) IMPLEMENT_ASN1_FUNCTIONS_fname(stname, itname, itname)
//
//# define IMPLEMENT_ASN1_FUNCTIONS_ENCODE_name(stname, itname) \
//                        IMPLEMENT_ASN1_FUNCTIONS_ENCODE_fname(stname, itname, itname)
//
//# define IMPLEMENT_STATIC_ASN1_ALLOC_FUNCTIONS(stname) \
//                IMPLEMENT_ASN1_ALLOC_FUNCTIONS_pfname(static, stname, stname, stname)
//
//# define IMPLEMENT_ASN1_ALLOC_FUNCTIONS(stname) \
//                IMPLEMENT_ASN1_ALLOC_FUNCTIONS_fname(stname, stname, stname)
//
//# define IMPLEMENT_ASN1_ALLOC_FUNCTIONS_pfname(pre, stname, itname, fname) \
//        pre stname *fname##_new(void) \
//        { \
//                return (stname *)ASN1_item_new(ASN1_ITEM_rptr(itname)); \
//        } \
//        pre void fname##_free(stname *a) \
//        { \
//                ASN1_item_free((ASN1_VALUE *)a, ASN1_ITEM_rptr(itname)); \
//        }
//
//# define IMPLEMENT_ASN1_ALLOC_FUNCTIONS_fname(stname, itname, fname) \
//        stname *fname##_new(void) \
//        { \
//                return (stname *)ASN1_item_new(ASN1_ITEM_rptr(itname)); \
//        } \
//        void fname##_free(stname *a) \
//        { \
//                ASN1_item_free((ASN1_VALUE *)a, ASN1_ITEM_rptr(itname)); \
//        }
//
//# define IMPLEMENT_ASN1_FUNCTIONS_fname(stname, itname, fname) \
//        IMPLEMENT_ASN1_ENCODE_FUNCTIONS_fname(stname, itname, fname) \
//        IMPLEMENT_ASN1_ALLOC_FUNCTIONS_fname(stname, itname, fname)
//
//# define IMPLEMENT_ASN1_ENCODE_FUNCTIONS_fname(stname, itname, fname) \
//        stname *d2i_##fname(stname **a, const unsigned char **in, long len) \
//        { \
//                return (stname *)ASN1_item_d2i((ASN1_VALUE **)a, in, len, ASN1_ITEM_rptr(itname));\
//        } \
//        int i2d_##fname(stname *a, unsigned char **out) \
//        { \
//                return ASN1_item_i2d((ASN1_VALUE *)a, out, ASN1_ITEM_rptr(itname));\
//        }
//
//# define IMPLEMENT_ASN1_NDEF_FUNCTION(stname) \
//        int i2d_##stname##_NDEF(stname *a, unsigned char **out) \
//        { \
//                return ASN1_item_ndef_i2d((ASN1_VALUE *)a, out, ASN1_ITEM_rptr(stname));\
//        }
//
//# define IMPLEMENT_STATIC_ASN1_ENCODE_FUNCTIONS(stname) \
//        static stname *d2i_##stname(stname **a, \
//                                   const unsigned char **in, long len) \
//        { \
//                return (stname *)ASN1_item_d2i((ASN1_VALUE **)a, in, len, \
//                                               ASN1_ITEM_rptr(stname)); \
//        } \
//        static int i2d_##stname(stname *a, unsigned char **out) \
//        { \
//                return ASN1_item_i2d((ASN1_VALUE *)a, out, \
//                                     ASN1_ITEM_rptr(stname)); \
//        }
//
///*
// * This includes evil casts to remove const: they will go away when full ASN1
// * constification is done.
// */
//# define IMPLEMENT_ASN1_ENCODE_FUNCTIONS_const_fname(stname, itname, fname) \
//        stname *d2i_##fname(stname **a, const unsigned char **in, long len) \
//        { \
//                return (stname *)ASN1_item_d2i((ASN1_VALUE **)a, in, len, ASN1_ITEM_rptr(itname));\
//        } \
//        int i2d_##fname(const stname *a, unsigned char **out) \
//        { \
//                return ASN1_item_i2d((ASN1_VALUE *)a, out, ASN1_ITEM_rptr(itname));\
//        }
//
//# define IMPLEMENT_ASN1_DUP_FUNCTION(stname) \
//        stname * stname##_dup(stname *x) \
//        { \
//        return ASN1_item_dup(ASN1_ITEM_rptr(stname), x); \
//        }
//
//# define IMPLEMENT_ASN1_PRINT_FUNCTION(stname) \
//        IMPLEMENT_ASN1_PRINT_FUNCTION_fname(stname, stname, stname)
//
//# define IMPLEMENT_ASN1_PRINT_FUNCTION_fname(stname, itname, fname) \
//        int fname##_print_ctx(BIO *out, stname *x, int indent, \
//                                                const ASN1_PCTX *pctx) \
//        { \
//                return ASN1_item_print(out, (ASN1_VALUE *)x, indent, \
//                        ASN1_ITEM_rptr(itname), pctx); \
//        }
//
//# define IMPLEMENT_ASN1_FUNCTIONS_const(name) \
//                IMPLEMENT_ASN1_FUNCTIONS_const_fname(name, name, name)
//
//# define IMPLEMENT_ASN1_FUNCTIONS_const_fname(stname, itname, fname) \
//        IMPLEMENT_ASN1_ENCODE_FUNCTIONS_const_fname(stname, itname, fname) \
//        IMPLEMENT_ASN1_ALLOC_FUNCTIONS_fname(stname, itname, fname)
//
//* external definitions for primitive types */

//DECLARE_ASN1_ITEM(ASN1_BOOLEAN)
//DECLARE_ASN1_ITEM(ASN1_TBOOLEAN)
//DECLARE_ASN1_ITEM(ASN1_FBOOLEAN)
//DECLARE_ASN1_ITEM(ASN1_SEQUENCE)
//DECLARE_ASN1_ITEM(CBIGNUM)
//DECLARE_ASN1_ITEM(BIGNUM)
//DECLARE_ASN1_ITEM(INT32)
//DECLARE_ASN1_ITEM(ZINT32)
//DECLARE_ASN1_ITEM(UINT32)
//DECLARE_ASN1_ITEM(ZUINT32)
//DECLARE_ASN1_ITEM(INT64)
//DECLARE_ASN1_ITEM(ZINT64)
//DECLARE_ASN1_ITEM(UINT64)
//DECLARE_ASN1_ITEM(ZUINT64)

//# if OPENSSL_API_COMPAT < 0x10200000L
///*
// * LONG and ZLONG are strongly discouraged for use as stored data, as the
// * underlying C type (long) differs in size depending on the architecture.
// * They are designed with 32-bit longs in mind.
// */
//DECLARE_ASN1_ITEM(LONG)
//DECLARE_ASN1_ITEM(ZLONG)
//# endif

//DEFINE_STACK_OF(ASN1_VALUE)

//* Functions used internally by the ASN1 code */

var
  function ASN1_item_ex_new(pval: PPASN1_VALUE; const it: PASN1_ITEM): TIdC_INT;
  procedure ASN1_item_ex_free(pval: PPASN1_VALUE; const it: PASN1_ITEM);

  function ASN1_item_ex_d2i(pval: PPASN1_VALUE; const AIn: PPByte; len: TIdC_LONG; const it: PASN1_ITEM; tag: TIdC_INT; aclass: TIdC_INT; opt: AnsiChar; ctx: PASN1_TLC): TIdC_INT;

  function ASN1_item_ex_i2d(pval: PPASN1_VALUE; AOut: PPByte; const it: PASN1_ITEM; tag: TIdC_INT; aclass: TIdC_INT): TIdC_INT;

implementation

end.
