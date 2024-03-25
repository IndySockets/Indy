  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_asn1.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_asn1.h2pas
     and this file regenerated. IdOpenSSLHeaders_asn1.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_asn1;

interface

// Headers for OpenSSL 1.1.1
// asn1.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_asn1t,
  IdOpenSSLHeaders_bio,
  IdOpenSSlHeaders_ossl_typ;

{$MINENUMSIZE 4}

const
  (*
   * NB the constants below are used internally by ASN1_INTEGER
   * and ASN1_ENUMERATED to indicate the sign. They are *not* on
   * the wire tag values.
   *)

  V_ASN1_NEG = $100;
  V_ASN1_NEG_INTEGER = 2 or V_ASN1_NEG;
  V_ASN1_NEG_ENUMERATED = 10 or V_ASN1_NEG;

  (* For use with d2i_ASN1_type_bytes() *)
  B_ASN1_NUMERICSTRING = $0001;
  B_ASN1_PRINTABLESTRING = $0002;
  B_ASN1_T61STRING = $0004;
  B_ASN1_TELETEXSTRING = $0004;
  B_ASN1_VIDEOTEXSTRING = $0008;
  B_ASN1_IA5STRING = $0010;
  B_ASN1_GRAPHICSTRING = $0020;
  B_ASN1_ISO64STRING = $0040;
  B_ASN1_VISIBLESTRING = $0040;
  B_ASN1_GENERALSTRING = $0080;
  B_ASN1_UNIVERSALSTRING = $0100;
  B_ASN1_OCTET_STRING = $0200;
  B_ASN1_BIT_STRING = $0400;
  B_ASN1_BMPSTRING = $0800;
  B_ASN1_UNKNOWN = $1000;
  B_ASN1_UTF8STRING = $2000;
  B_ASN1_UTCTIME = $4000;
  B_ASN1_GENERALIZEDTIME = $8000;
  B_ASN1_SEQUENCE = $10000;
 (* For use with ASN1_mbstring_copy() *)
  MBSTRING_FLAG = $1000;
  MBSTRING_UTF8 = MBSTRING_FLAG;
  MBSTRING_ASC = MBSTRING_FLAG or 1;
  MBSTRING_BMP = MBSTRING_FLAG or 2;
  MBSTRING_UNIV = MBSTRING_FLAG or 4;
  SMIME_OLDMIME = $400;
  SMIME_CRLFEOL = $800;
  SMIME_STREAM = $1000;

//    struct X509_algor_st;
//DEFINE_STACK_OF(X509_ALGOR)

  ASN1_STRING_FLAG_BITS_LEFT = $08;   (* Set if $07 has bits left value *)
  (*
   * This indicates that the ASN1_STRING is not a real value but just a place
   * holder for the location where indefinite length constructed data should be
   * inserted in the memory buffer
   *)
  ASN1_STRING_FLAG_NDEF = $010;

  (*
   * This flag is used by the CMS code to indicate that a string is not
   * complete and is a place holder for content when it had all been accessed.
   * The flag will be reset when content has been written to it.
   *)

  ASN1_STRING_FLAG_CONT = $020;
  (*
   * This flag is used by ASN1 code to indicate an ASN1_STRING is an MSTRING
   * type.
   *)
  ASN1_STRING_FLAG_MSTRING = $040;
  (* String is embedded and only content should be freed *)
  ASN1_STRING_FLAG_EMBED = $080;
  (* String should be parsed in RFC 5280's time format *)
  ASN1_STRING_FLAG_X509_TIME = $100;

  (* Used with ASN1 LONG type: if a long is set to this it is omitted *)
  ASN1_LONG_UNDEF = TIdC_LONG($7fffffff);

  STABLE_FLAGS_MALLOC = $01;
  (*
   * A zero passed to ASN1_STRING_TABLE_new_add for the flags is interpreted
   * as "don't change" and STABLE_FLAGS_MALLOC is always set. By setting
   * STABLE_FLAGS_MALLOC only we can clear the existing value. Use the alias
   * STABLE_FLAGS_CLEAR to reflect this.
   *)
  STABLE_FLAGS_CLEAR = STABLE_FLAGS_MALLOC;
  STABLE_NO_MASK = $02;
  DIRSTRING_TYPE = B_ASN1_PRINTABLESTRING or B_ASN1_T61STRING or B_ASN1_BMPSTRING or B_ASN1_UTF8STRING;
  PKCS9STRING_TYPE = DIRSTRING_TYPE or B_ASN1_IA5STRING;

  (* size limits: this stuff is taken straight from RFC2459 *)
  ub_name = 32768;
  ub_common_name = 64;
  ub_locality_name = 128;
  ub_state_name = 128;
  ub_organization_name = 64;
  ub_organization_unit_name = 64;
  ub_title = 64;
  ub_email_address = 128;

  (* Parameters used by ASN1_STRING_print_ex() *)

  (*
   * These determine which characters to escape: RFC2253 special characters,
   * control characters and MSB set characters
   *)
  ASN1_STRFLGS_ESC_2253 = 1;
  ASN1_STRFLGS_ESC_CTRL = 2;
  ASN1_STRFLGS_ESC_MSB = 4;

  (*
   * This flag determines how we do escaping: normally RC2253 backslash only,
   * set this to use backslash and quote.
   *)

  ASN1_STRFLGS_ESC_QUOTE = 8;

  (* These three flags are internal use only. *)

  (* Character is a valid PrintableString character *)
  CHARTYPE_PRINTABLESTRING = $10;
  (* Character needs escaping if it is the first character *)
  CHARTYPE_FIRST_ESC_2253 = $20;
  (* Character needs escaping if it is the last character *)
  CHARTYPE_LAST_ESC_2253 = $40;

  (*
   * NB the internal flags are safely reused below by flags handled at the top
   * level.
   *)

  (*
   * If this is set we convert all character strings to UTF8 first
   *)

  ASN1_STRFLGS_UTF8_CONVERT = $10;

  (*
   * If this is set we don't attempt to interpret content: just assume all
   * strings are 1 byte per character. This will produce some pretty odd
   * looking output!
   *)

  ASN1_STRFLGS_IGNORE_TYPE = $20;

  (* If this is set we include the string type in the output *)
  ASN1_STRFLGS_SHOW_TYPE = $40;

  (*
   * This determines which strings to display and which to 'dump' (hex dump of
   * content octets or DER encoding). We can only dump non character strings or
   * everything. If we don't dump 'unknown' they are interpreted as character
   * strings with 1 octet per character and are subject to the usual escaping
   * options.
   *)

  ASN1_STRFLGS_DUMP_ALL = $80;
  ASN1_STRFLGS_DUMP_UNKNOWN = $100;

  (*
   * These determine what 'dumping' does, we can dump the content octets or the
   * DER encoding: both use the RFC2253 #XXXXX notation.
   *)

  ASN1_STRFLGS_DUMP_DER = $200;

  (*
   * This flag specifies that RC2254 escaping shall be performed.
   *)

  ASN1_STRFLGS_ESC_2254 = $400;

  (*
   * All the string flags consistent with RFC2253, escaping control characters
   * isn't essential in RFC2253 but it is advisable anyway.
   *)

  ASN1_STRFLGS_RFC2253 = ASN1_STRFLGS_ESC_2253 or ASN1_STRFLGS_ESC_CTRL or
    ASN1_STRFLGS_ESC_MSB or ASN1_STRFLGS_UTF8_CONVERT or
    ASN1_STRFLGS_DUMP_UNKNOWN or ASN1_STRFLGS_DUMP_DER;

  B_ASN1_TIME = B_ASN1_UTCTIME or B_ASN1_GENERALIZEDTIME;

  B_ASN1_PRINTABLE = B_ASN1_NUMERICSTRING or B_ASN1_PRINTABLESTRING or
    B_ASN1_T61STRING or B_ASN1_IA5STRING or B_ASN1_BIT_STRING or
    B_ASN1_UNIVERSALSTRING or B_ASN1_BMPSTRING or B_ASN1_UTF8STRING or
    B_ASN1_SEQUENCE or B_ASN1_UNKNOWN;

  B_ASN1_DIRECTORYSTRING = B_ASN1_PRINTABLESTRING or B_ASN1_TELETEXSTRING or
    B_ASN1_BMPSTRING or B_ASN1_UNIVERSALSTRING or B_ASN1_UTF8STRING;

  B_ASN1_DISPLAYTEXT = B_ASN1_IA5STRING or B_ASN1_VISIBLESTRING or
    B_ASN1_BMPSTRING or B_ASN1_UTF8STRING;

  (* ASN1 Print flags *)
  (* Indicate missing OPTIONAL fields *)
  ASN1_PCTX_FLAGS_SHOW_ABSENT = $001;
  (* Mark start and end of SEQUENCE *)
  ASN1_PCTX_FLAGS_SHOW_SEQUENCE = $002;
  (* Mark start and end of SEQUENCE/SET OF *)
  ASN1_PCTX_FLAGS_SHOW_SSOF = $004;
  (* Show the ASN1 type of primitives *)
  ASN1_PCTX_FLAGS_SHOW_TYPE = $008;
  (* Don't show ASN1 type of ANY *)
  ASN1_PCTX_FLAGS_NO_ANY_TYPE = $010;
  (* Don't show ASN1 type of MSTRINGs *)
  ASN1_PCTX_FLAGS_NO_MSTRING_TYPE = $020;
  (* Don't show field names in SEQUENCE *)
  ASN1_PCTX_FLAGS_NO_FIELD_NAME = $040;
  (* Show structure names of each SEQUENCE field *)
  ASN1_PCTX_FLAGS_SHOW_FIELD_STRUCT_NAME = $080;
  (* Don't show structure name even at top level *)
  ASN1_PCTX_FLAGS_NO_STRUCT_NAME = $100;

type
// Moved to ossl_type to prevent circular references
///(* This is the base type that holds just about everything :-) *)
//  asn1_string_st = record
//    length: TIdC_int;
//    type_: TIdC_int;
//    data: PByte;
//    (*
//     * The value of the following field depends on the type being held.  It
//     * is mostly being used for BIT_STRING so if the input data has a
//     * non-zero 'unused bits' value, it will be handled correctly
//     *)
//    flags: TIdC_long;
//  end;

  (*
   * ASN1_ENCODING structure: this is used to save the received encoding of an
   * ASN1 type. This is useful to get round problems with invalid encodings
   * which can break signatures.
   *)

  ASN1_ENCODING_st = record
    enc: PIdAnsiChar;           (* DER encoding *)
    len: TIdC_LONG;                     (* Length of encoding *)
    modified: TIdC_INT;                 (* set to 1 if 'enc' is invalid *)
  end;
  ASN1_ENCODING = ASN1_ENCODING_st;

  asn1_string_table_st = record
    nid: TIdC_INT;
    minsize: TIdC_LONG;
    maxsize: TIdC_LONG;
    mask: TIdC_ULONG;
    flags: TIdC_ULONG;
  end;
  ASN1_STRING_TABLE = asn1_string_table_st;
  PASN1_STRING_TABLE = ^ASN1_STRING_TABLE;

// DEFINE_STACK_OF(ASN1_STRING_TABLE)

  (*                  !!!
   * Declarations for template structures: for full definitions see asn1t.h
   *)
  (* This is just an opaque pointer *)
// typedef struct ASN1_VALUE_st ASN1_VALUE;

  (* Declare ASN1 functions: the implement macro in in asn1t.h *)

//# define DECLARE_ASN1_FUNCTIONS(type) DECLARE_ASN1_FUNCTIONS_name(type, type)
//
//# define DECLARE_ASN1_ALLOC_FUNCTIONS(type) \
//        DECLARE_ASN1_ALLOC_FUNCTIONS_name(type, type)
//
//# define DECLARE_ASN1_FUNCTIONS_name(type, name) \
//        DECLARE_ASN1_ALLOC_FUNCTIONS_name(type, name) \
//        DECLARE_ASN1_ENCODE_FUNCTIONS(type, name, name)
//
//# define DECLARE_ASN1_FUNCTIONS_fname(type, itname, name) \
//        DECLARE_ASN1_ALLOC_FUNCTIONS_name(type, name) \
//        DECLARE_ASN1_ENCODE_FUNCTIONS(type, itname, name)
//
//# define DECLARE_ASN1_ENCODE_FUNCTIONS(type, itname, name) \
//        type *d2i_##name(type **a, const unsigned char **in, long len); \
//        int i2d_##name(type *a, unsigned char **out); \
//        DECLARE_ASN1_ITEM(itname)
//
//# define DECLARE_ASN1_ENCODE_FUNCTIONS_const(type, name) \
//        type *d2i_##name(type **a, const unsigned char **in, long len); \
//        int i2d_##name(const type *a, unsigned char **out); \
//        DECLARE_ASN1_ITEM(name)
//
//# define DECLARE_ASN1_NDEF_FUNCTION(name) \
//        int i2d_##name##_NDEF(name *a, unsigned char **out);
//
//# define DECLARE_ASN1_FUNCTIONS_const(name) \
//        DECLARE_ASN1_ALLOC_FUNCTIONS(name) \
//        DECLARE_ASN1_ENCODE_FUNCTIONS_const(name, name)
//
//# define DECLARE_ASN1_ALLOC_FUNCTIONS_name(type, name) \
//        type *name##_new(void); \
//        void name##_free(type *a);
//
//# define DECLARE_ASN1_PRINT_FUNCTION(stname) \
//        DECLARE_ASN1_PRINT_FUNCTION_fname(stname, stname)
//
//# define DECLARE_ASN1_PRINT_FUNCTION_fname(stname, fname) \
//        int fname##_print_ctx(BIO *out, stname *x, int indent, \
//                                         const ASN1_PCTX *pctx);
//
//# define D2I_OF(type) type *(*)(type **,const unsigned char **,long)
//# define I2D_OF(type) int (*)(type *,unsigned char **)
//# define I2D_OF_const(type) int (*)(const type *,unsigned char **)
//
//# define CHECKED_D2I_OF(type, d2i) \
//    ((d2i_of_void*) (1 ? d2i : ((D2I_OF(type))0)))
//# define CHECKED_I2D_OF(type, i2d) \
//    ((i2d_of_void*) (1 ? i2d : ((I2D_OF(type))0)))
//# define CHECKED_NEW_OF(type, xnew) \
//    ((void *(*)(void)) (1 ? xnew : ((type *(*)(void))0)))
//# define CHECKED_PTR_OF(type, p) \
//    ((void*) (1 ? p : (type*)0))
//# define CHECKED_PPTR_OF(type, p) \
//    ((void**) (1 ? p : (type**)0))
//
//# define TYPEDEF_D2I_OF(type) typedef type *d2i_of_##type(type **,const unsigned char **,long)
//# define TYPEDEF_I2D_OF(type) typedef int i2d_of_##type(type *,unsigned char **)
//# define TYPEDEF_D2I2D_OF(type) TYPEDEF_D2I_OF(type); TYPEDEF_I2D_OF(type)
//
//TYPEDEF_D2I2D_OF(void);

  (*-
   * The following macros and typedefs allow an ASN1_ITEM
   * to be embedded in a structure and referenced. Since
   * the ASN1_ITEM pointers need to be globally accessible
   * (possibly from shared libraries) they may exist in
   * different forms. On platforms that support it the
   * ASN1_ITEM structure itself will be globally exported.
   * Other platforms will export a function that returns
   * an ASN1_ITEM pointer.
   *
   * To handle both cases transparently the macros below
   * should be used instead of hard coding an ASN1_ITEM
   * pointer in a structure.
   *
   * The structure will look like this:
   *
   * typedef struct SOMETHING_st {
   *      ...
   *      ASN1_ITEM_EXP *iptr;
   *      ...
   * } SOMETHING;
   *
   * It would be initialised as e.g.:
   *
   * SOMETHING somevar = {...,ASN1_ITEM_ref(X509),...};
   *
   * and the actual pointer extracted with:
   *
   * const ASN1_ITEM *it = ASN1_ITEM_ptr(somevar.iptr);
   *
   * Finally an ASN1_ITEM pointer can be extracted from an
   * appropriate reference with: ASN1_ITEM_rptr(X509). This
   * would be used when a function takes an ASN1_ITEM * argument.
   *
   *)

// # ifndef OPENSSL_EXPORT_VAR_AS_FUNCTION

///(* ASN1_ITEM pointer exported type *)
//typedef const ASN1_ITEM ASN1_ITEM_EXP;
//
///(* Macro to obtain ASN1_ITEM pointer from exported type *)
//#  define ASN1_ITEM_ptr(iptr) (iptr)
//
// (* Macro to include ASN1_ITEM pointer from base type *)
//#  define ASN1_ITEM_ref(iptr) (&(iptr##_it))
//
//#  define ASN1_ITEM_rptr(ref) (&(ref##_it))
//
//#  define DECLARE_ASN1_ITEM(name) \
//        OPENSSL_EXTERN const ASN1_ITEM name##_it;
//
//# else

// (*
// * Platforms that can't easily handle shared global variables are declared as
// * functions returning ASN1_ITEM pointers.
// *)

///(* ASN1_ITEM pointer exported type *)
//typedef const ASN1_ITEM *ASN1_ITEM_EXP (void);
//
///(* Macro to obtain ASN1_ITEM pointer from exported type *)
//#  define ASN1_ITEM_ptr(iptr) (iptr())
//
///(* Macro to include ASN1_ITEM pointer from base type *)
//#  define ASN1_ITEM_ref(iptr) (iptr##_it)
//
//#  define ASN1_ITEM_rptr(ref) (ref##_it())
//
//#  define DECLARE_ASN1_ITEM(name) \
//        const ASN1_ITEM * name##_it(void);
//
//# endif

//DEFINE_STACK_OF(ASN1_INTEGER)
//
//DEFINE_STACK_OF(ASN1_GENERALSTRING)
//
//DEFINE_STACK_OF(ASN1_UTF8STRING)

//DEFINE_STACK_OF(ASN1_TYPE)
//
//typedef STACK_OF(ASN1_TYPE) ASN1_SEQUENCE_ANY;
//
//DECLARE_ASN1_ENCODE_FUNCTIONS_const(ASN1_SEQUENCE_ANY, ASN1_SEQUENCE_ANY)
//DECLARE_ASN1_ENCODE_FUNCTIONS_const(ASN1_SEQUENCE_ANY, ASN1_SET_ANY)

  (* This is used to contain a list of bit names *)

  BIT_STRING_BITNAME_st = record
    bitnum: TIdC_INT;
    lname: PIdAnsiChar;
    sname: PIdAnsiChar;
  end;
  BIT_STRING_BITNAME = BIT_STRING_BITNAME_st;
  PBIT_STRING_BITNAME = ^BIT_STRING_BITNAME;

//DECLARE_ASN1_FUNCTIONS(type) -->
//        type *name##_new(void); \
//        void name##_free(type *a);
//        type *d2i_##name(type **a, const unsigned char **in, long len); \
//        int i2d_##name(type *a, unsigned char **out); \
//#  define DECLARE_ASN1_ITEM(name) \
//        OPENSSL_EXTERN const ASN1_ITEM name##_it;

// DECLARE_ASN1_FUNCTIONS_fname(ASN1_TYPE, ASN1_ANY, ASN1_TYPE)
    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ASN1_TYPE_get}
  {$EXTERNALSYM ASN1_TYPE_set}
  {$EXTERNALSYM ASN1_TYPE_set1}
  {$EXTERNALSYM ASN1_TYPE_cmp}
  {$EXTERNALSYM ASN1_TYPE_pack_sequence} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_TYPE_unpack_sequence} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_OBJECT_new}
  {$EXTERNALSYM ASN1_OBJECT_free}
  {$EXTERNALSYM i2d_ASN1_OBJECT}
  {$EXTERNALSYM d2i_ASN1_OBJECT}
  {$EXTERNALSYM ASN1_STRING_new}
  {$EXTERNALSYM ASN1_STRING_free}
  {$EXTERNALSYM ASN1_STRING_clear_free}
  {$EXTERNALSYM ASN1_STRING_copy}
  {$EXTERNALSYM ASN1_STRING_dup}
  {$EXTERNALSYM ASN1_STRING_type_new}
  {$EXTERNALSYM ASN1_STRING_cmp}
  {$EXTERNALSYM ASN1_STRING_set}
  {$EXTERNALSYM ASN1_STRING_set0}
  {$EXTERNALSYM ASN1_STRING_length}
  {$EXTERNALSYM ASN1_STRING_length_set}
  {$EXTERNALSYM ASN1_STRING_type}
  {$EXTERNALSYM ASN1_STRING_get0_data} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_BIT_STRING_set}
  {$EXTERNALSYM ASN1_BIT_STRING_set_bit}
  {$EXTERNALSYM ASN1_BIT_STRING_get_bit}
  {$EXTERNALSYM ASN1_BIT_STRING_check}
  {$EXTERNALSYM ASN1_BIT_STRING_name_print}
  {$EXTERNALSYM ASN1_BIT_STRING_num_asc}
  {$EXTERNALSYM ASN1_BIT_STRING_set_asc}
  {$EXTERNALSYM ASN1_INTEGER_new}
  {$EXTERNALSYM ASN1_INTEGER_free}
  {$EXTERNALSYM d2i_ASN1_INTEGER}
  {$EXTERNALSYM i2d_ASN1_INTEGER}
  {$EXTERNALSYM d2i_ASN1_UINTEGER}
  {$EXTERNALSYM ASN1_INTEGER_dup}
  {$EXTERNALSYM ASN1_INTEGER_cmp}
  {$EXTERNALSYM ASN1_UTCTIME_check}
  {$EXTERNALSYM ASN1_UTCTIME_set}
  {$EXTERNALSYM ASN1_UTCTIME_adj}
  {$EXTERNALSYM ASN1_UTCTIME_set_string}
  {$EXTERNALSYM ASN1_UTCTIME_cmp_time_t}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_check}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_set}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_adj}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_set_string}
  {$EXTERNALSYM ASN1_TIME_diff}
  {$EXTERNALSYM ASN1_OCTET_STRING_dup}
  {$EXTERNALSYM ASN1_OCTET_STRING_cmp}
  {$EXTERNALSYM ASN1_OCTET_STRING_set}
  {$EXTERNALSYM UTF8_getc}
  {$EXTERNALSYM UTF8_putc}
  {$EXTERNALSYM ASN1_UTCTIME_new}
  {$EXTERNALSYM ASN1_UTCTIME_free}
  {$EXTERNALSYM d2i_ASN1_UTCTIME}
  {$EXTERNALSYM i2d_ASN1_UTCTIME}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_new}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_free}
  {$EXTERNALSYM d2i_ASN1_GENERALIZEDTIME}
  {$EXTERNALSYM i2d_ASN1_GENERALIZEDTIME}
  {$EXTERNALSYM ASN1_TIME_new}
  {$EXTERNALSYM ASN1_TIME_free}
  {$EXTERNALSYM d2i_ASN1_TIME}
  {$EXTERNALSYM i2d_ASN1_TIME}
  {$EXTERNALSYM ASN1_TIME_set}
  {$EXTERNALSYM ASN1_TIME_adj}
  {$EXTERNALSYM ASN1_TIME_check}
  {$EXTERNALSYM ASN1_TIME_to_generalizedtime}
  {$EXTERNALSYM ASN1_TIME_set_string}
  {$EXTERNALSYM ASN1_TIME_set_string_X509} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_TIME_to_tm} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_TIME_normalize} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_TIME_cmp_time_t} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_TIME_compare} {introduced 1.1.0}
  {$EXTERNALSYM i2a_ASN1_INTEGER}
  {$EXTERNALSYM a2i_ASN1_INTEGER}
  {$EXTERNALSYM i2a_ASN1_ENUMERATED}
  {$EXTERNALSYM a2i_ASN1_ENUMERATED}
  {$EXTERNALSYM i2a_ASN1_OBJECT}
  {$EXTERNALSYM a2i_ASN1_STRING}
  {$EXTERNALSYM i2a_ASN1_STRING}
  {$EXTERNALSYM i2t_ASN1_OBJECT}
  {$EXTERNALSYM a2d_ASN1_OBJECT}
  {$EXTERNALSYM ASN1_OBJECT_create}
  {$EXTERNALSYM ASN1_INTEGER_get_int64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_INTEGER_set_int64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_INTEGER_get_uint64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_INTEGER_set_uint64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_INTEGER_set}
  {$EXTERNALSYM ASN1_INTEGER_get}
  {$EXTERNALSYM BN_to_ASN1_INTEGER}
  {$EXTERNALSYM ASN1_INTEGER_to_BN}
  {$EXTERNALSYM ASN1_ENUMERATED_get_int64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_ENUMERATED_set_int64} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_ENUMERATED_set}
  {$EXTERNALSYM ASN1_ENUMERATED_get}
  {$EXTERNALSYM BN_to_ASN1_ENUMERATED}
  {$EXTERNALSYM ASN1_ENUMERATED_to_BN}
  {$EXTERNALSYM ASN1_PRINTABLE_type}
  {$EXTERNALSYM ASN1_tag2bit}
  {$EXTERNALSYM ASN1_get_object}
  {$EXTERNALSYM ASN1_check_infinite_end}
  {$EXTERNALSYM ASN1_const_check_infinite_end}
  {$EXTERNALSYM ASN1_put_object}
  {$EXTERNALSYM ASN1_put_eoc}
  {$EXTERNALSYM ASN1_object_size}
  {$EXTERNALSYM ASN1_item_dup}
  {$EXTERNALSYM ASN1_STRING_to_UTF8}
  {$EXTERNALSYM ASN1_item_d2i_bio}
  {$EXTERNALSYM ASN1_i2d_bio}
  {$EXTERNALSYM ASN1_item_i2d_bio}
  {$EXTERNALSYM ASN1_UTCTIME_print}
  {$EXTERNALSYM ASN1_GENERALIZEDTIME_print}
  {$EXTERNALSYM ASN1_TIME_print}
  {$EXTERNALSYM ASN1_STRING_print}
  {$EXTERNALSYM ASN1_STRING_print_ex}
  {$EXTERNALSYM ASN1_buf_print} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_bn_print}
  {$EXTERNALSYM ASN1_parse}
  {$EXTERNALSYM ASN1_parse_dump}
  {$EXTERNALSYM ASN1_tag2str}
  {$EXTERNALSYM ASN1_UNIVERSALSTRING_to_string}
  {$EXTERNALSYM ASN1_TYPE_set_octetstring}
  {$EXTERNALSYM ASN1_TYPE_get_octetstring}
  {$EXTERNALSYM ASN1_TYPE_set_int_octetstring}
  {$EXTERNALSYM ASN1_TYPE_get_int_octetstring}
  {$EXTERNALSYM ASN1_item_unpack}
  {$EXTERNALSYM ASN1_item_pack}
  {$EXTERNALSYM ASN1_STRING_set_default_mask}
  {$EXTERNALSYM ASN1_STRING_set_default_mask_asc}
  {$EXTERNALSYM ASN1_STRING_get_default_mask}
  {$EXTERNALSYM ASN1_mbstring_copy}
  {$EXTERNALSYM ASN1_mbstring_ncopy}
  {$EXTERNALSYM ASN1_STRING_set_by_NID}
  {$EXTERNALSYM ASN1_STRING_TABLE_get}
  {$EXTERNALSYM ASN1_STRING_TABLE_add}
  {$EXTERNALSYM ASN1_STRING_TABLE_cleanup}
  {$EXTERNALSYM ASN1_item_new}
  {$EXTERNALSYM ASN1_item_free}
  {$EXTERNALSYM ASN1_item_d2i}
  {$EXTERNALSYM ASN1_item_i2d}
  {$EXTERNALSYM ASN1_item_ndef_i2d}
  {$EXTERNALSYM ASN1_add_oid_module}
  {$EXTERNALSYM ASN1_add_stable_module} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_generate_nconf}
  {$EXTERNALSYM ASN1_generate_v3}
  {$EXTERNALSYM ASN1_str2mask} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_item_print}
  {$EXTERNALSYM ASN1_PCTX_new}
  {$EXTERNALSYM ASN1_PCTX_free}
  {$EXTERNALSYM ASN1_PCTX_get_flags}
  {$EXTERNALSYM ASN1_PCTX_set_flags}
  {$EXTERNALSYM ASN1_PCTX_get_nm_flags}
  {$EXTERNALSYM ASN1_PCTX_set_nm_flags}
  {$EXTERNALSYM ASN1_PCTX_get_cert_flags}
  {$EXTERNALSYM ASN1_PCTX_set_cert_flags}
  {$EXTERNALSYM ASN1_PCTX_get_oid_flags}
  {$EXTERNALSYM ASN1_PCTX_set_oid_flags}
  {$EXTERNALSYM ASN1_PCTX_get_str_flags}
  {$EXTERNALSYM ASN1_PCTX_set_str_flags}
  {$EXTERNALSYM ASN1_SCTX_free} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_SCTX_get_item} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_SCTX_get_template} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_SCTX_get_flags} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_SCTX_set_app_data} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_SCTX_get_app_data} {introduced 1.1.0}
  {$EXTERNALSYM BIO_f_asn1}
  {$EXTERNALSYM BIO_new_NDEF}
  {$EXTERNALSYM i2d_ASN1_bio_stream}
  {$EXTERNALSYM PEM_write_bio_ASN1_stream}
  {$EXTERNALSYM SMIME_read_ASN1}
  {$EXTERNALSYM SMIME_crlf_copy}
  {$EXTERNALSYM SMIME_text}
  {$EXTERNALSYM ASN1_ITEM_lookup} {introduced 1.1.0}
  {$EXTERNALSYM ASN1_ITEM_get} {introduced 1.1.0}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  ASN1_TYPE_get: function (const a: PASN1_TYPE): TIdC_INT; cdecl = nil;
  ASN1_TYPE_set: procedure (a: PASN1_TYPE; type_: TIdC_INT; value: Pointer); cdecl = nil;
  ASN1_TYPE_set1: function (a: PASN1_TYPE; type_: TIdC_INT; const value: Pointer): TIdC_INT; cdecl = nil;
  ASN1_TYPE_cmp: function (const a: PASN1_TYPE; const b: PASN1_TYPE): TIdC_INT; cdecl = nil;

  ASN1_TYPE_pack_sequence: function (const it: PASN1_ITEM; s: Pointer; t: PPASN1_TYPE): PASN1_TYPE; cdecl = nil; {introduced 1.1.0}
  ASN1_TYPE_unpack_sequence: function (const it: PASN1_ITEM; const t: PASN1_TYPE): Pointer; cdecl = nil; {introduced 1.1.0}

  ASN1_OBJECT_new: function : PASN1_OBJECT; cdecl = nil;
  ASN1_OBJECT_free: procedure (a: PASN1_OBJECT); cdecl = nil;
  i2d_ASN1_OBJECT: function (const a: PASN1_OBJECT; pp: PPByte): TIdC_INT; cdecl = nil;
  d2i_ASN1_OBJECT: function (a: PPASN1_OBJECT; const pp: PPByte; length: TIdC_LONG): PASN1_OBJECT; cdecl = nil;

  //DECLARE_ASN1_ITEM(ASN1_OBJECT)
  //
  //DEFINE_STACK_OF(ASN1_OBJECT)

  ASN1_STRING_new: function : PASN1_STRING; cdecl = nil;
  ASN1_STRING_free: procedure (a: PASN1_STRING); cdecl = nil;
  ASN1_STRING_clear_free: procedure (a: PASN1_STRING); cdecl = nil;
  ASN1_STRING_copy: function (dst: PASN1_STRING; const str: PASN1_STRING): TIdC_INT; cdecl = nil;
  ASN1_STRING_dup: function (const a: PASN1_STRING): PASN1_STRING; cdecl = nil;
  ASN1_STRING_type_new: function (type_: TIdC_INT): PASN1_STRING; cdecl = nil;
  ASN1_STRING_cmp: function (const a: PASN1_STRING; const b: PASN1_STRING): TIdC_INT; cdecl = nil;

  (*
   * Since this is used to store all sorts of things, via macros, for now,
   * make its data void *
   *)
  ASN1_STRING_set: function (str: PASN1_STRING; const data: Pointer; len: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_STRING_set0: procedure (str: PASN1_STRING; data: Pointer; len: TIdC_INT); cdecl = nil;
  ASN1_STRING_length: function (const x: PASN1_STRING): TIdC_INT; cdecl = nil;
  ASN1_STRING_length_set: procedure (x: PASN1_STRING; n: TIdC_INT); cdecl = nil;
  ASN1_STRING_type: function (const x: PASN1_STRING): TIdC_INT; cdecl = nil;
  ASN1_STRING_get0_data: function (const x: PASN1_STRING): PByte; cdecl = nil; {introduced 1.1.0}

  //DECLARE_ASN1_FUNCTIONS(ASN1_BIT_STRING)
  ASN1_BIT_STRING_set: function (a: PASN1_BIT_STRING; d: PByte; length: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_BIT_STRING_set_bit: function (a: PASN1_BIT_STRING; n: TIdC_INT; value: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_BIT_STRING_get_bit: function (const a: PASN1_BIT_STRING; n: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_BIT_STRING_check: function (const a: PASN1_BIT_STRING; const flags: PByte; flags_len: TIdC_INT): TIdC_INT; cdecl = nil;

  ASN1_BIT_STRING_name_print: function (out_: PBIO; bs: PASN1_BIT_STRING; tbl: PBIT_STRING_BITNAME; indent: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_BIT_STRING_num_asc: function (const name: PIdAnsiChar; tbl: PBIT_STRING_BITNAME): TIdC_INT; cdecl = nil;
  ASN1_BIT_STRING_set_asc: function (bs: PASN1_BIT_STRING; const name: PIdAnsiChar; value: TIdC_INT; tbl: PBIT_STRING_BITNAME): TIdC_INT; cdecl = nil;

  ASN1_INTEGER_new: function : PASN1_INTEGER; cdecl = nil;
  ASN1_INTEGER_free: procedure (a: PASN1_INTEGER); cdecl = nil;
  d2i_ASN1_INTEGER: function (a: PPASN1_INTEGER; const in_: PPByte; len: TIdC_Long): PASN1_INTEGER; cdecl = nil;
  i2d_ASN1_INTEGER: function (a: PASN1_INTEGER; out_: PPByte): TIdC_Int; cdecl = nil;

  d2i_ASN1_UINTEGER: function (a: PPASN1_INTEGER; const pp: PPByte; length: TIdC_LONG): PASN1_INTEGER; cdecl = nil;
  ASN1_INTEGER_dup: function (const x: PASN1_INTEGER): PASN1_INTEGER; cdecl = nil;
  ASN1_INTEGER_cmp: function (const x: PASN1_INTEGER; const y: PASN1_INTEGER): TIdC_INT; cdecl = nil;

  // DECLARE_ASN1_FUNCTIONS(ASN1_ENUMERATED)

  ASN1_UTCTIME_check: function (const a: PASN1_UTCTIME): TIdC_INT; cdecl = nil;
  ASN1_UTCTIME_set: function (s: PASN1_UTCTIME; t: TIdC_TIMET): PASN1_UTCTIME; cdecl = nil;
  ASN1_UTCTIME_adj: function (s: PASN1_UTCTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_UTCTIME; cdecl = nil;
  ASN1_UTCTIME_set_string: function (s: PASN1_UTCTIME; const str: PAnsiChar): TIdC_INT; cdecl = nil;
  ASN1_UTCTIME_cmp_time_t: function (const s: PASN1_UTCTIME; t: TIdC_TIMET): TIdC_INT; cdecl = nil;

  ASN1_GENERALIZEDTIME_check: function (const a: PASN1_GENERALIZEDTIME): TIdC_INT; cdecl = nil;
  ASN1_GENERALIZEDTIME_set: function (s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET): PASN1_GENERALIZEDTIME; cdecl = nil;
  ASN1_GENERALIZEDTIME_adj: function (s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_GENERALIZEDTIME; cdecl = nil;
  ASN1_GENERALIZEDTIME_set_string: function (s: pASN1_GENERALIZEDTIME; const str: PAnsiChar): TIdC_INT; cdecl = nil;

  ASN1_TIME_diff: function (pday: PIdC_INT; psec: PIdC_INT; const from: PASN1_TIME; const to_: PASN1_TIME): TIdC_INT; cdecl = nil;

  // DECLARE_ASN1_FUNCTIONS(ASN1_OCTET_STRING)
  ASN1_OCTET_STRING_dup: function (const a: PASN1_OCTET_STRING): PASN1_OCTET_STRING; cdecl = nil;
  ASN1_OCTET_STRING_cmp: function (const a: PASN1_OCTET_STRING; const b: PASN1_OCTET_STRING): TIdC_INT; cdecl = nil;
  ASN1_OCTET_STRING_set: function (str: PASN1_OCTET_STRING; const data: PByte; len: TIdC_INT): TIdC_INT; cdecl = nil;

  //DECLARE_ASN1_FUNCTIONS(ASN1_VISIBLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UNIVERSALSTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UTF8STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_NULL)
  //DECLARE_ASN1_FUNCTIONS(ASN1_BMPSTRING)

  UTF8_getc: function (const str: PByte; len: TIdC_INT; val: PIdC_ULONG): TIdC_INT; cdecl = nil;
  UTF8_putc: function (str: PIdAnsiChar; len: TIdC_INT; value: TIdC_ULONG): TIdC_INT; cdecl = nil;

  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, ASN1_PRINTABLE)
  //
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DIRECTORYSTRING)
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DISPLAYTEXT)
  //DECLARE_ASN1_FUNCTIONS(ASN1_PRINTABLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_T61STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_IA5STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_GENERALSTRING)

  ASN1_UTCTIME_new: function : PASN1_UTCTIME; cdecl = nil;
  ASN1_UTCTIME_free: procedure (a: PASN1_UTCTIME); cdecl = nil;
  d2i_ASN1_UTCTIME: function (a: PPASN1_UTCTIME; const in_: PPByte; len: TIdC_LONG): PASN1_UTCTIME; cdecl = nil;
  i2d_ASN1_UTCTIME: function (a: PASN1_UTCTIME; out_: PPByte): TIdC_INT; cdecl = nil;

  ASN1_GENERALIZEDTIME_new: function : PASN1_GENERALIZEDTIME; cdecl = nil;
  ASN1_GENERALIZEDTIME_free: procedure (a: PASN1_GENERALIZEDTIME); cdecl = nil;
  d2i_ASN1_GENERALIZEDTIME: function (a: PPASN1_GENERALIZEDTIME; const in_: PPByte; len: TIdC_LONG): PASN1_GENERALIZEDTIME; cdecl = nil;
  i2d_ASN1_GENERALIZEDTIME: function (a: PASN1_GENERALIZEDTIME; out_: PPByte): TIdC_INT; cdecl = nil;

  ASN1_TIME_new: function : PASN1_TIME; cdecl = nil;
  ASN1_TIME_free: procedure (a: PASN1_TIME); cdecl = nil;
  d2i_ASN1_TIME: function (a: PPASN1_TIME; const in_: PPByte; len: TIdC_LONG): PASN1_TIME; cdecl = nil;
  i2d_ASN1_TIME: function (a: PASN1_TIME; out_: PPByte): TIdC_INT; cdecl = nil;

  // DECLARE_ASN1_ITEM(ASN1_OCTET_STRING_NDEF)

  ASN1_TIME_set: function (s: PASN1_TIME; t: TIdC_TIMET): PASN1_TIME; cdecl = nil;
  ASN1_TIME_adj: function (s: PASN1_TIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_TIME; cdecl = nil;
  ASN1_TIME_check: function (const t: PASN1_TIME): TIdC_INT; cdecl = nil;
  ASN1_TIME_to_generalizedtime: function (const t: PASN1_TIME; out_: PPASN1_GENERALIZEDTIME): PASN1_GENERALIZEDTIME; cdecl = nil;
  ASN1_TIME_set_string: function (s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT; cdecl = nil;
  ASN1_TIME_set_string_X509: function (s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_TIME_to_tm: function (const s: PASN1_TIME; tm: PIdC_TM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_TIME_normalize: function (s: PASN1_TIME): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_TIME_cmp_time_t: function (const s: PASN1_TIME; t: TIdC_TIMET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_TIME_compare: function (const a: PASN1_TIME; const b: PASN1_TIME): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  i2a_ASN1_INTEGER: function (bp: PBIO; const a: PASN1_INTEGER): TIdC_INT; cdecl = nil;
  a2i_ASN1_INTEGER: function (bp: PBIO; bs: PASN1_INTEGER; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT; cdecl = nil;
  i2a_ASN1_ENUMERATED: function (bp: PBIO; const a: PASN1_ENUMERATED): TIdC_INT; cdecl = nil;
  a2i_ASN1_ENUMERATED: function (bp: PBIO; bs: PASN1_ENUMERATED; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT; cdecl = nil;
  i2a_ASN1_OBJECT: function (bp: PBIO; const a: PASN1_OBJECT): TIdC_INT; cdecl = nil;
  a2i_ASN1_STRING: function (bp: PBIO; bs: PASN1_STRING; buf: PAnsiChar; size: TIdC_INT): TIdC_INT; cdecl = nil;
  i2a_ASN1_STRING: function (bp: PBIO; const a: PASN1_STRING; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  i2t_ASN1_OBJECT: function (buf: PAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT): TIdC_INT; cdecl = nil;

  a2d_ASN1_OBJECT: function (out_: PByte; olen: TIdC_INT; const buf: PIdAnsiChar; num: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_OBJECT_create: function (nid: TIdC_INT; data: PByte; len: TIdC_INT; const sn: PAnsiChar; const ln: PAnsiChar): PASN1_OBJECT; cdecl = nil;

  ASN1_INTEGER_get_int64: function (pr: PIdC_Int64; const a: PASN1_INTEGER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_INTEGER_set_int64: function (a: PASN1_INTEGER; r: TIdC_Int64): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_INTEGER_get_uint64: function (pr: PIdC_UInt64; const a: PASN1_INTEGER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_INTEGER_set_uint64: function (a: PASN1_INTEGER; r: TIdC_UInt64): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  ASN1_INTEGER_set: function (a: PASN1_INTEGER; v: TIdC_LONG): TIdC_INT; cdecl = nil;
  ASN1_INTEGER_get: function (const a: PASN1_INTEGER): TIdC_LONG; cdecl = nil;
  BN_to_ASN1_INTEGER: function (const bn: PBIGNUM; ai: PASN1_INTEGER): PASN1_INTEGER; cdecl = nil;
  ASN1_INTEGER_to_BN: function (const ai: PASN1_INTEGER; bn: PBIGNUM): PBIGNUM; cdecl = nil;

  ASN1_ENUMERATED_get_int64: function (pr: PIdC_Int64; const a: PASN1_ENUMERATED): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_ENUMERATED_set_int64: function (a: PASN1_ENUMERATED; r: TIdC_Int64): TIdC_INT; cdecl = nil; {introduced 1.1.0}


  ASN1_ENUMERATED_set: function (a: PASN1_ENUMERATED; v: TIdC_LONG): TIdC_INT; cdecl = nil;
  ASN1_ENUMERATED_get: function (const a: PASN1_ENUMERATED): TIdC_LONG; cdecl = nil;
  BN_to_ASN1_ENUMERATED: function (const bn: PBIGNUM; ai: PASN1_ENUMERATED): PASN1_ENUMERATED; cdecl = nil;
  ASN1_ENUMERATED_to_BN: function (const ai: PASN1_ENUMERATED; bn: PBIGNUM): PBIGNUM; cdecl = nil;

  (* General *)
  (* given a string, return the correct type, max is the maximum length *)
  ASN1_PRINTABLE_type: function (const s: PByte; max: TIdC_INT): TIdC_INT; cdecl = nil;

  ASN1_tag2bit: function (tag: TIdC_INT): TIdC_ULONG; cdecl = nil;

  (* SPECIALS *)
  ASN1_get_object: function (const pp: PPByte; plength: PIdC_LONG; ptag: PIdC_INT; pclass: PIdC_INT; omax: TIdC_LONG): TIdC_INT; cdecl = nil;
  ASN1_check_infinite_end: function (p: PPByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  ASN1_const_check_infinite_end: function (const p: PPByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  ASN1_put_object: procedure (pp: PPByte; constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT; xclass: TIdC_INT); cdecl = nil;
  ASN1_put_eoc: function (pp: PPByte): TIdC_INT; cdecl = nil;
  ASN1_object_size: function (constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT): TIdC_INT; cdecl = nil;

  (* Used to implement other functions *)
  //void *ASN1_dup(i2d_of_void *i2d, d2i_of_void *d2i, void *x);
  //
  //# define ASN1_dup_of(type,i2d,d2i,x) \
  //    ((type*)ASN1_dup(CHECKED_I2D_OF(type, i2d), \
  //                     CHECKED_D2I_OF(type, d2i), \
  //                     CHECKED_PTR_OF(type, x)))
  //
  //# define ASN1_dup_of_const(type,i2d,d2i,x) \
  //    ((type*)ASN1_dup(CHECKED_I2D_OF(const type, i2d), \
  //                     CHECKED_D2I_OF(type, d2i), \
  //                     CHECKED_PTR_OF(const type, x)))
  //
  ASN1_item_dup: function (const it: PASN1_ITEM; x: Pointer): Pointer; cdecl = nil;

    (* ASN1 alloc/free macros for when a type is only used internally *)

  //# define M_ASN1_new_of(type) (type *)ASN1_item_new(ASN1_ITEM_rptr(type))
  //# define M_ASN1_free_of(x, type) \
  //                ASN1_item_free(CHECKED_PTR_OF(type, x), ASN1_ITEM_rptr(type))
  //
  //# ifndef OPENSSL_NO_STDIO
  //void *ASN1_d2i_fp(void *(*xnew) (void), d2i_of_void *d2i, FILE *in, void **x);

  //#  define ASN1_d2i_fp_of(type,xnew,d2i,in,x) \
  //    ((type*)ASN1_d2i_fp(CHECKED_NEW_OF(type, xnew), \
  //                        CHECKED_D2I_OF(type, d2i), \
  //                        in, \
  //                        CHECKED_PPTR_OF(type, x)))
  //
  //function ASN1_item_d2i_fp(const it: PASN1_ITEM; in_: PFILE; x: Pointer): Pointer;
  //function ASN1_i2d_fp(i2d: Pi2d_of_void; out_: PFILE; x: Pointer): TIdC_INT;
  //
  //#  define ASN1_i2d_fp_of(type,i2d,out,x) \
  //    (ASN1_i2d_fp(CHECKED_I2D_OF(type, i2d), \
  //                 out, \
  //                 CHECKED_PTR_OF(type, x)))
  //
  //#  define ASN1_i2d_fp_of_const(type,i2d,out,x) \
  //    (ASN1_i2d_fp(CHECKED_I2D_OF(const type, i2d), \
  //                 out, \
  //                 CHECKED_PTR_OF(const type, x)))
  //
  //function ASN1_item_i2d_fp(const it: PASN1_ITEM; out_: PFILE; x: Pointer): TIdC_INT;
  //function ASN1_STRING_print_ex_fp(&fp: PFILE; const str: PASN1_STRING; flags: TIdC_ULONG): TIdC_INT;
  //# endif

  ASN1_STRING_to_UTF8: function (out_: PPByte; const in_: PASN1_STRING): TIdC_INT; cdecl = nil;

  //void *ASN1_d2i_bio(void *(*xnew) (void), d2i_of_void *d2i, BIO *in, void **x);

  //#  define ASN1_d2i_bio_of(type,xnew,d2i,in,x) \
  //    ((type*)ASN1_d2i_bio( CHECKED_NEW_OF(type, xnew), \
  //                          CHECKED_D2I_OF(type, d2i), \
  //                          in, \
  //                          CHECKED_PPTR_OF(type, x)))

  ASN1_item_d2i_bio: function (const it: PASN1_ITEM; in_: PBIO; x: Pointer): Pointer; cdecl = nil;
  ASN1_i2d_bio: function (i2d: Pi2d_of_void; out_: PBIO; x: PByte): TIdC_INT; cdecl = nil;

  //#  define ASN1_i2d_bio_of(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(type, x)))
  //
  //#  define ASN1_i2d_bio_of_const(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(const type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(const type, x)))

  ASN1_item_i2d_bio: function (const it: PASN1_ITEM; out_: PBIO; x: Pointer): TIdC_INT; cdecl = nil;
  ASN1_UTCTIME_print: function (fp: PBIO; const a: PASN1_UTCTIME): TIdC_INT; cdecl = nil;
  ASN1_GENERALIZEDTIME_print: function (fp: PBIO; const a: PASN1_GENERALIZEDTIME): TIdC_INT; cdecl = nil;
  ASN1_TIME_print: function (fp: PBIO; const a: PASN1_TIME): TIdC_INT; cdecl = nil;
  ASN1_STRING_print: function (bp: PBIO; const v: PASN1_STRING): TIdC_INT; cdecl = nil;
  ASN1_STRING_print_ex: function (out_: PBIO; const str: PASN1_STRING; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;
  ASN1_buf_print: function (bp: PBIO; const buf: PByte; buflen: TIdC_SIZET; off: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ASN1_bn_print: function (bp: PBIO; const number: PIdAnsiChar; const num: PBIGNUM; buf: PByte; off: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_parse: function (bp: PBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_parse_dump: function (bp: PPBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT; dump: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_tag2str: function (tag: TIdC_INT): PIdAnsiChar; cdecl = nil;

  (* Used to load and write Netscape format cert *)

  ASN1_UNIVERSALSTRING_to_string: function (s: PASN1_UNIVERSALSTRING): TIdC_INT; cdecl = nil;

  ASN1_TYPE_set_octetstring: function (a: PASN1_TYPE; data: PByte; len: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_TYPE_get_octetstring: function (const a: PASN1_TYPE; data: PByte; max_len: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_TYPE_set_int_octetstring: function (a: PASN1_TYPE; num: TIdC_LONG; data: PByte; len: TIdC_INT): TIdC_INT; cdecl = nil;
  ASN1_TYPE_get_int_octetstring: function (const a: PASN1_TYPE; num: PIdC_LONG; data: PByte; max_len: TIdC_INT): TIdC_INT; cdecl = nil;

  ASN1_item_unpack: function (const oct: PASN1_STRING; const it: PASN1_ITEM): Pointer; cdecl = nil;

  ASN1_item_pack: function (obj: Pointer; const it: PASN1_ITEM; oct: PPASN1_OCTET_STRING): PASN1_STRING; cdecl = nil;

  ASN1_STRING_set_default_mask: procedure (mask: TIdC_ULONG); cdecl = nil;
  ASN1_STRING_set_default_mask_asc: function (const p: PAnsiChar): TIdC_INT; cdecl = nil;
  ASN1_STRING_get_default_mask: function : TIdC_ULONG; cdecl = nil;
  ASN1_mbstring_copy: function (out_: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG): TIdC_INT; cdecl = nil;
  ASN1_mbstring_ncopy: function (out_: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG; minsize: TIdC_LONG; maxsize: TIdC_LONG): TIdC_INT; cdecl = nil;

  ASN1_STRING_set_by_NID: function (out_: PPASN1_STRING; const in_: PByte; inlen: TIdC_INT; inform: TIdC_INT; nid: TIdC_INT): PASN1_STRING; cdecl = nil;
  ASN1_STRING_TABLE_get: function (nid: TIdC_INT): PASN1_STRING_TABLE; cdecl = nil;
  ASN1_STRING_TABLE_add: function (v1: TIdC_INT; v2: TIdC_LONG; v3: TIdC_LONG; v4: TIdC_ULONG; v5: TIdC_ULONG): TIdC_INT; cdecl = nil;
  ASN1_STRING_TABLE_cleanup: procedure ; cdecl = nil;

  (* ASN1 template functions *)

  (* Old API compatible functions *)
  ASN1_item_new: function (const it: PASN1_ITEM): PASN1_VALUE; cdecl = nil;
  ASN1_item_free: procedure (val: PASN1_VALUE; const it: PASN1_ITEM); cdecl = nil;
  ASN1_item_d2i: function (val: PPASN1_VALUE; const in_: PPByte; len: TIdC_LONG; const it: PASN1_ITEM): PASN1_VALUE; cdecl = nil;
  ASN1_item_i2d: function (val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT; cdecl = nil;
  ASN1_item_ndef_i2d: function (val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT; cdecl = nil;

  ASN1_add_oid_module: procedure ; cdecl = nil;
  ASN1_add_stable_module: procedure ; cdecl = nil; {introduced 1.1.0}

  ASN1_generate_nconf: function (const str: PAnsiChar; nconf: PCONF): PASN1_TYPE; cdecl = nil;
  ASN1_generate_v3: function (const str: PAnsiChar; cnf: PX509V3_CTX): PASN1_TYPE; cdecl = nil;
  ASN1_str2mask: function (const str: PByte; pmask: PIdC_ULONG): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  ASN1_item_print: function (out_: PBIO; ifld: PASN1_VALUE; indent: TIdC_INT; const it: PASN1_ITEM; const pctx: PASN1_PCTX): TIdC_INT; cdecl = nil;
  ASN1_PCTX_new: function : PASN1_PCTX; cdecl = nil;
  ASN1_PCTX_free: procedure (p: PASN1_PCTX); cdecl = nil;
  ASN1_PCTX_get_flags: function (const p: PASN1_PCTX): TIdC_ULONG; cdecl = nil;
  ASN1_PCTX_set_flags: procedure (p: PASN1_PCTX; flags: TIdC_ULONG); cdecl = nil;
  ASN1_PCTX_get_nm_flags: function (const p: PASN1_PCTX): TIdC_ULONG; cdecl = nil;
  ASN1_PCTX_set_nm_flags: procedure (p: PASN1_PCTX; flags: TIdC_ULONG); cdecl = nil;
  ASN1_PCTX_get_cert_flags: function (const p: PASN1_PCTX): TIdC_ULONG; cdecl = nil;
  ASN1_PCTX_set_cert_flags: procedure (p: PASN1_PCTX; flags: TIdC_ULONG); cdecl = nil;
  ASN1_PCTX_get_oid_flags: function (const p: PASN1_PCTX): TIdC_ULONG; cdecl = nil;
  ASN1_PCTX_set_oid_flags: procedure (p: PASN1_PCTX; flags: TIdC_ULONG); cdecl = nil;
  ASN1_PCTX_get_str_flags: function (const p: PASN1_PCTX): TIdC_ULONG; cdecl = nil;
  ASN1_PCTX_set_str_flags: procedure (p: PASN1_PCTX; flags: TIdC_ULONG); cdecl = nil;

  //ASN1_SCTX *ASN1_SCTX_new(int (*scan_cb) (ASN1_SCTX *ctx));
  ASN1_SCTX_free: procedure (p: PASN1_SCTX); cdecl = nil; {introduced 1.1.0}
  ASN1_SCTX_get_item: function (p: PASN1_SCTX): PASN1_ITEM; cdecl = nil; {introduced 1.1.0}
  ASN1_SCTX_get_template: function (p: PASN1_SCTX): PASN1_TEMPLATE; cdecl = nil; {introduced 1.1.0}
  ASN1_SCTX_get_flags: function (p: PASN1_SCTX): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  ASN1_SCTX_set_app_data: procedure (p: PASN1_SCTX; data: Pointer); cdecl = nil; {introduced 1.1.0}
  ASN1_SCTX_get_app_data: function (p: PASN1_SCTX): Pointer; cdecl = nil; {introduced 1.1.0}

  BIO_f_asn1: function : PBIO_METHOD; cdecl = nil;

  BIO_new_NDEF: function (out_: PBIO; val: PASN1_VALUE; const it: PASN1_ITEM): PBIO; cdecl = nil;

  i2d_ASN1_bio_stream: function (out_: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const it: PASN1_ITEM): TIdC_INT; cdecl = nil;
  PEM_write_bio_ASN1_stream: function (out_: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const hdr: PAnsiChar; const it: PASN1_ITEM): TIdC_INT; cdecl = nil;
  //function SMIME_write_ASN1(bio: PBIO; val: PASN1_VALUE; data: PBIO; flags: TIdC_INT;
  //                     ctype_nid: TIdC_INT; econt_nid: TIdC_INT;
  //                     STACK_OF(X509_ALGOR) *mdalgs, const ASN1_ITEM *it): TIdC_INT;
  SMIME_read_ASN1: function (bio: PBIO; bcont: PPBIO; const it: PASN1_ITEM): PASN1_VALUE; cdecl = nil;
  SMIME_crlf_copy: function (in_: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  SMIME_text: function (in_: PBIO; out_: PBIO): TIdC_INT; cdecl = nil;

  ASN1_ITEM_lookup: function (const name: PIdAnsiChar): PASN1_ITEM; cdecl = nil; {introduced 1.1.0}
  ASN1_ITEM_get: function (i: TIdC_SIZET): PASN1_ITEM; cdecl = nil; {introduced 1.1.0}

{$ELSE}
  function ASN1_TYPE_get(const a: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_TYPE_set(a: PASN1_TYPE; type_: TIdC_INT; value: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TYPE_set1(a: PASN1_TYPE; type_: TIdC_INT; const value: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TYPE_cmp(const a: PASN1_TYPE; const b: PASN1_TYPE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_TYPE_pack_sequence(const it: PASN1_ITEM; s: Pointer; t: PPASN1_TYPE): PASN1_TYPE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_TYPE_unpack_sequence(const it: PASN1_ITEM; const t: PASN1_TYPE): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function ASN1_OBJECT_new: PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_OBJECT_free(a: PASN1_OBJECT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ASN1_OBJECT(const a: PASN1_OBJECT; pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ASN1_OBJECT(a: PPASN1_OBJECT; const pp: PPByte; length: TIdC_LONG): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //DECLARE_ASN1_ITEM(ASN1_OBJECT)
  //
  //DEFINE_STACK_OF(ASN1_OBJECT)

  function ASN1_STRING_new: PASN1_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_STRING_free(a: PASN1_STRING) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_STRING_clear_free(a: PASN1_STRING) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_copy(dst: PASN1_STRING; const str: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_dup(const a: PASN1_STRING): PASN1_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_type_new(type_: TIdC_INT): PASN1_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_cmp(const a: PASN1_STRING; const b: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (*
   * Since this is used to store all sorts of things, via macros, for now,
   * make its data void *
   *)
  function ASN1_STRING_set(str: PASN1_STRING; const data: Pointer; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_STRING_set0(str: PASN1_STRING; data: Pointer; len: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_length(const x: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_STRING_length_set(x: PASN1_STRING; n: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_type(const x: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_get0_data(const x: PASN1_STRING): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  //DECLARE_ASN1_FUNCTIONS(ASN1_BIT_STRING)
  function ASN1_BIT_STRING_set(a: PASN1_BIT_STRING; d: PByte; length: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_BIT_STRING_set_bit(a: PASN1_BIT_STRING; n: TIdC_INT; value: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_BIT_STRING_get_bit(const a: PASN1_BIT_STRING; n: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_BIT_STRING_check(const a: PASN1_BIT_STRING; const flags: PByte; flags_len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_BIT_STRING_name_print(out_: PBIO; bs: PASN1_BIT_STRING; tbl: PBIT_STRING_BITNAME; indent: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_BIT_STRING_num_asc(const name: PIdAnsiChar; tbl: PBIT_STRING_BITNAME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_BIT_STRING_set_asc(bs: PASN1_BIT_STRING; const name: PIdAnsiChar; value: TIdC_INT; tbl: PBIT_STRING_BITNAME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_INTEGER_new: PASN1_INTEGER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_INTEGER_free(a: PASN1_INTEGER) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ASN1_INTEGER(a: PPASN1_INTEGER; const in_: PPByte; len: TIdC_Long): PASN1_INTEGER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ASN1_INTEGER(a: PASN1_INTEGER; out_: PPByte): TIdC_Int cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function d2i_ASN1_UINTEGER(a: PPASN1_INTEGER; const pp: PPByte; length: TIdC_LONG): PASN1_INTEGER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_INTEGER_dup(const x: PASN1_INTEGER): PASN1_INTEGER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_INTEGER_cmp(const x: PASN1_INTEGER; const y: PASN1_INTEGER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  // DECLARE_ASN1_FUNCTIONS(ASN1_ENUMERATED)

  function ASN1_UTCTIME_check(const a: PASN1_UTCTIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_UTCTIME_set(s: PASN1_UTCTIME; t: TIdC_TIMET): PASN1_UTCTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_UTCTIME_adj(s: PASN1_UTCTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_UTCTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_UTCTIME_set_string(s: PASN1_UTCTIME; const str: PAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_UTCTIME_cmp_time_t(const s: PASN1_UTCTIME; t: TIdC_TIMET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_GENERALIZEDTIME_check(const a: PASN1_GENERALIZEDTIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_GENERALIZEDTIME_set(s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET): PASN1_GENERALIZEDTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_GENERALIZEDTIME_adj(s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_GENERALIZEDTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_GENERALIZEDTIME_set_string(s: pASN1_GENERALIZEDTIME; const str: PAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_TIME_diff(pday: PIdC_INT; psec: PIdC_INT; const from: PASN1_TIME; const to_: PASN1_TIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  // DECLARE_ASN1_FUNCTIONS(ASN1_OCTET_STRING)
  function ASN1_OCTET_STRING_dup(const a: PASN1_OCTET_STRING): PASN1_OCTET_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_OCTET_STRING_cmp(const a: PASN1_OCTET_STRING; const b: PASN1_OCTET_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_OCTET_STRING_set(str: PASN1_OCTET_STRING; const data: PByte; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //DECLARE_ASN1_FUNCTIONS(ASN1_VISIBLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UNIVERSALSTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UTF8STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_NULL)
  //DECLARE_ASN1_FUNCTIONS(ASN1_BMPSTRING)

  function UTF8_getc(const str: PByte; len: TIdC_INT; val: PIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function UTF8_putc(str: PIdAnsiChar; len: TIdC_INT; value: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, ASN1_PRINTABLE)
  //
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DIRECTORYSTRING)
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DISPLAYTEXT)
  //DECLARE_ASN1_FUNCTIONS(ASN1_PRINTABLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_T61STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_IA5STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_GENERALSTRING)

  function ASN1_UTCTIME_new: PASN1_UTCTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_UTCTIME_free(a: PASN1_UTCTIME) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ASN1_UTCTIME(a: PPASN1_UTCTIME; const in_: PPByte; len: TIdC_LONG): PASN1_UTCTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ASN1_UTCTIME(a: PASN1_UTCTIME; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_GENERALIZEDTIME_new: PASN1_GENERALIZEDTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_GENERALIZEDTIME_free(a: PASN1_GENERALIZEDTIME) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ASN1_GENERALIZEDTIME(a: PPASN1_GENERALIZEDTIME; const in_: PPByte; len: TIdC_LONG): PASN1_GENERALIZEDTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ASN1_GENERALIZEDTIME(a: PASN1_GENERALIZEDTIME; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_TIME_new: PASN1_TIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_TIME_free(a: PASN1_TIME) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function d2i_ASN1_TIME(a: PPASN1_TIME; const in_: PPByte; len: TIdC_LONG): PASN1_TIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2d_ASN1_TIME(a: PASN1_TIME; out_: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  // DECLARE_ASN1_ITEM(ASN1_OCTET_STRING_NDEF)

  function ASN1_TIME_set(s: PASN1_TIME; t: TIdC_TIMET): PASN1_TIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_adj(s: PASN1_TIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_TIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_check(const t: PASN1_TIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_to_generalizedtime(const t: PASN1_TIME; out_: PPASN1_GENERALIZEDTIME): PASN1_GENERALIZEDTIME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_set_string(s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_set_string_X509(s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_TIME_to_tm(const s: PASN1_TIME; tm: PIdC_TM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_TIME_normalize(s: PASN1_TIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_TIME_cmp_time_t(const s: PASN1_TIME; t: TIdC_TIMET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_TIME_compare(const a: PASN1_TIME; const b: PASN1_TIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function i2a_ASN1_INTEGER(bp: PBIO; const a: PASN1_INTEGER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function a2i_ASN1_INTEGER(bp: PBIO; bs: PASN1_INTEGER; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2a_ASN1_ENUMERATED(bp: PBIO; const a: PASN1_ENUMERATED): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function a2i_ASN1_ENUMERATED(bp: PBIO; bs: PASN1_ENUMERATED; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2a_ASN1_OBJECT(bp: PBIO; const a: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function a2i_ASN1_STRING(bp: PBIO; bs: PASN1_STRING; buf: PAnsiChar; size: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2a_ASN1_STRING(bp: PBIO; const a: PASN1_STRING; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function i2t_ASN1_OBJECT(buf: PAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function a2d_ASN1_OBJECT(out_: PByte; olen: TIdC_INT; const buf: PIdAnsiChar; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_OBJECT_create(nid: TIdC_INT; data: PByte; len: TIdC_INT; const sn: PAnsiChar; const ln: PAnsiChar): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_INTEGER_get_int64(pr: PIdC_Int64; const a: PASN1_INTEGER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_INTEGER_set_int64(a: PASN1_INTEGER; r: TIdC_Int64): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_INTEGER_get_uint64(pr: PIdC_UInt64; const a: PASN1_INTEGER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_INTEGER_set_uint64(a: PASN1_INTEGER; r: TIdC_UInt64): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function ASN1_INTEGER_set(a: PASN1_INTEGER; v: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_INTEGER_get(const a: PASN1_INTEGER): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BN_to_ASN1_INTEGER(const bn: PBIGNUM; ai: PASN1_INTEGER): PASN1_INTEGER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_INTEGER_to_BN(const ai: PASN1_INTEGER; bn: PBIGNUM): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_ENUMERATED_get_int64(pr: PIdC_Int64; const a: PASN1_ENUMERATED): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_ENUMERATED_set_int64(a: PASN1_ENUMERATED; r: TIdC_Int64): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}


  function ASN1_ENUMERATED_set(a: PASN1_ENUMERATED; v: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_ENUMERATED_get(const a: PASN1_ENUMERATED): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BN_to_ASN1_ENUMERATED(const bn: PBIGNUM; ai: PASN1_ENUMERATED): PASN1_ENUMERATED cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_ENUMERATED_to_BN(const ai: PASN1_ENUMERATED; bn: PBIGNUM): PBIGNUM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* General *)
  (* given a string, return the correct type, max is the maximum length *)
  function ASN1_PRINTABLE_type(const s: PByte; max: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_tag2bit(tag: TIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* SPECIALS *)
  function ASN1_get_object(const pp: PPByte; plength: PIdC_LONG; ptag: PIdC_INT; pclass: PIdC_INT; omax: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_check_infinite_end(p: PPByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_const_check_infinite_end(const p: PPByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_put_object(pp: PPByte; constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT; xclass: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_put_eoc(pp: PPByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_object_size(constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* Used to implement other functions *)
  //void *ASN1_dup(i2d_of_void *i2d, d2i_of_void *d2i, void *x);
  //
  //# define ASN1_dup_of(type,i2d,d2i,x) \
  //    ((type*)ASN1_dup(CHECKED_I2D_OF(type, i2d), \
  //                     CHECKED_D2I_OF(type, d2i), \
  //                     CHECKED_PTR_OF(type, x)))
  //
  //# define ASN1_dup_of_const(type,i2d,d2i,x) \
  //    ((type*)ASN1_dup(CHECKED_I2D_OF(const type, i2d), \
  //                     CHECKED_D2I_OF(type, d2i), \
  //                     CHECKED_PTR_OF(const type, x)))
  //
  function ASN1_item_dup(const it: PASN1_ITEM; x: Pointer): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

    (* ASN1 alloc/free macros for when a type is only used internally *)

  //# define M_ASN1_new_of(type) (type *)ASN1_item_new(ASN1_ITEM_rptr(type))
  //# define M_ASN1_free_of(x, type) \
  //                ASN1_item_free(CHECKED_PTR_OF(type, x), ASN1_ITEM_rptr(type))
  //
  //# ifndef OPENSSL_NO_STDIO
  //void *ASN1_d2i_fp(void *(*xnew) (void), d2i_of_void *d2i, FILE *in, void **x);

  //#  define ASN1_d2i_fp_of(type,xnew,d2i,in,x) \
  //    ((type*)ASN1_d2i_fp(CHECKED_NEW_OF(type, xnew), \
  //                        CHECKED_D2I_OF(type, d2i), \
  //                        in, \
  //                        CHECKED_PPTR_OF(type, x)))
  //
  //function ASN1_item_d2i_fp(const it: PASN1_ITEM; in_: PFILE; x: Pointer): Pointer;
  //function ASN1_i2d_fp(i2d: Pi2d_of_void; out_: PFILE; x: Pointer): TIdC_INT;
  //
  //#  define ASN1_i2d_fp_of(type,i2d,out,x) \
  //    (ASN1_i2d_fp(CHECKED_I2D_OF(type, i2d), \
  //                 out, \
  //                 CHECKED_PTR_OF(type, x)))
  //
  //#  define ASN1_i2d_fp_of_const(type,i2d,out,x) \
  //    (ASN1_i2d_fp(CHECKED_I2D_OF(const type, i2d), \
  //                 out, \
  //                 CHECKED_PTR_OF(const type, x)))
  //
  //function ASN1_item_i2d_fp(const it: PASN1_ITEM; out_: PFILE; x: Pointer): TIdC_INT;
  //function ASN1_STRING_print_ex_fp(&fp: PFILE; const str: PASN1_STRING; flags: TIdC_ULONG): TIdC_INT;
  //# endif

  function ASN1_STRING_to_UTF8(out_: PPByte; const in_: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //void *ASN1_d2i_bio(void *(*xnew) (void), d2i_of_void *d2i, BIO *in, void **x);

  //#  define ASN1_d2i_bio_of(type,xnew,d2i,in,x) \
  //    ((type*)ASN1_d2i_bio( CHECKED_NEW_OF(type, xnew), \
  //                          CHECKED_D2I_OF(type, d2i), \
  //                          in, \
  //                          CHECKED_PPTR_OF(type, x)))

  function ASN1_item_d2i_bio(const it: PASN1_ITEM; in_: PBIO; x: Pointer): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_i2d_bio(i2d: Pi2d_of_void; out_: PBIO; x: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //#  define ASN1_i2d_bio_of(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(type, x)))
  //
  //#  define ASN1_i2d_bio_of_const(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(const type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(const type, x)))

  function ASN1_item_i2d_bio(const it: PASN1_ITEM; out_: PBIO; x: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_UTCTIME_print(fp: PBIO; const a: PASN1_UTCTIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_GENERALIZEDTIME_print(fp: PBIO; const a: PASN1_GENERALIZEDTIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TIME_print(fp: PBIO; const a: PASN1_TIME): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_print(bp: PBIO; const v: PASN1_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_print_ex(out_: PBIO; const str: PASN1_STRING; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_buf_print(bp: PBIO; const buf: PByte; buflen: TIdC_SIZET; off: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_bn_print(bp: PBIO; const number: PIdAnsiChar; const num: PBIGNUM; buf: PByte; off: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_parse(bp: PBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_parse_dump(bp: PPBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT; dump: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_tag2str(tag: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* Used to load and write Netscape format cert *)

  function ASN1_UNIVERSALSTRING_to_string(s: PASN1_UNIVERSALSTRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_TYPE_set_octetstring(a: PASN1_TYPE; data: PByte; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TYPE_get_octetstring(const a: PASN1_TYPE; data: PByte; max_len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TYPE_set_int_octetstring(a: PASN1_TYPE; num: TIdC_LONG; data: PByte; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_TYPE_get_int_octetstring(const a: PASN1_TYPE; num: PIdC_LONG; data: PByte; max_len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_item_unpack(const oct: PASN1_STRING; const it: PASN1_ITEM): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_item_pack(obj: Pointer; const it: PASN1_ITEM; oct: PPASN1_OCTET_STRING): PASN1_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure ASN1_STRING_set_default_mask(mask: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_set_default_mask_asc(const p: PAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_get_default_mask: TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_mbstring_copy(out_: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_mbstring_ncopy(out_: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG; minsize: TIdC_LONG; maxsize: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_STRING_set_by_NID(out_: PPASN1_STRING; const in_: PByte; inlen: TIdC_INT; inform: TIdC_INT; nid: TIdC_INT): PASN1_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_TABLE_get(nid: TIdC_INT): PASN1_STRING_TABLE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_STRING_TABLE_add(v1: TIdC_INT; v2: TIdC_LONG; v3: TIdC_LONG; v4: TIdC_ULONG; v5: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_STRING_TABLE_cleanup cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* ASN1 template functions *)

  (* Old API compatible functions *)
  function ASN1_item_new(const it: PASN1_ITEM): PASN1_VALUE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_item_free(val: PASN1_VALUE; const it: PASN1_ITEM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_item_d2i(val: PPASN1_VALUE; const in_: PPByte; len: TIdC_LONG; const it: PASN1_ITEM): PASN1_VALUE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_item_i2d(val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_item_ndef_i2d(val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure ASN1_add_oid_module cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_add_stable_module cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function ASN1_generate_nconf(const str: PAnsiChar; nconf: PCONF): PASN1_TYPE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_generate_v3(const str: PAnsiChar; cnf: PX509V3_CTX): PASN1_TYPE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_str2mask(const str: PByte; pmask: PIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function ASN1_item_print(out_: PBIO; ifld: PASN1_VALUE; indent: TIdC_INT; const it: PASN1_ITEM; const pctx: PASN1_PCTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_new: PASN1_PCTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_free(p: PASN1_PCTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_get_flags(const p: PASN1_PCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_set_flags(p: PASN1_PCTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_get_nm_flags(const p: PASN1_PCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_set_nm_flags(p: PASN1_PCTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_get_cert_flags(const p: PASN1_PCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_set_cert_flags(p: PASN1_PCTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_get_oid_flags(const p: PASN1_PCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_set_oid_flags(p: PASN1_PCTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function ASN1_PCTX_get_str_flags(const p: PASN1_PCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure ASN1_PCTX_set_str_flags(p: PASN1_PCTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //ASN1_SCTX *ASN1_SCTX_new(int (*scan_cb) (ASN1_SCTX *ctx));
  procedure ASN1_SCTX_free(p: PASN1_SCTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_SCTX_get_item(p: PASN1_SCTX): PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_SCTX_get_template(p: PASN1_SCTX): PASN1_TEMPLATE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_SCTX_get_flags(p: PASN1_SCTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure ASN1_SCTX_set_app_data(p: PASN1_SCTX; data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_SCTX_get_app_data(p: PASN1_SCTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_f_asn1: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_new_NDEF(out_: PBIO; val: PASN1_VALUE; const it: PASN1_ITEM): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function i2d_ASN1_bio_stream(out_: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const it: PASN1_ITEM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function PEM_write_bio_ASN1_stream(out_: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const hdr: PAnsiChar; const it: PASN1_ITEM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //function SMIME_write_ASN1(bio: PBIO; val: PASN1_VALUE; data: PBIO; flags: TIdC_INT;
  //                     ctype_nid: TIdC_INT; econt_nid: TIdC_INT;
  //                     STACK_OF(X509_ALGOR) *mdalgs, const ASN1_ITEM *it): TIdC_INT;
  function SMIME_read_ASN1(bio: PBIO; bcont: PPBIO; const it: PASN1_ITEM): PASN1_VALUE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SMIME_crlf_copy(in_: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function SMIME_text(in_: PBIO; out_: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function ASN1_ITEM_lookup(const name: PIdAnsiChar): PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function ASN1_ITEM_get(i: TIdC_SIZET): PASN1_ITEM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

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
  ASN1_TYPE_pack_sequence_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TYPE_unpack_sequence_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_STRING_get0_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TIME_set_string_X509_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TIME_to_tm_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TIME_normalize_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TIME_cmp_time_t_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_TIME_compare_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_INTEGER_get_int64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_INTEGER_set_int64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_INTEGER_get_uint64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_INTEGER_set_uint64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_ENUMERATED_get_int64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_ENUMERATED_set_int64_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_buf_print_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_add_stable_module_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_str2mask_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_get_item_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_get_template_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_get_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_set_app_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_SCTX_get_app_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_ITEM_lookup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ASN1_ITEM_get_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
function  ERR_ASN1_TYPE_pack_sequence(const it: PASN1_ITEM; s: Pointer; t: PPASN1_TYPE): PASN1_TYPE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TYPE_pack_sequence');
end;


function  ERR_ASN1_TYPE_unpack_sequence(const it: PASN1_ITEM; const t: PASN1_TYPE): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TYPE_unpack_sequence');
end;


function  ERR_ASN1_STRING_get0_data(const x: PASN1_STRING): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_STRING_get0_data');
end;


function  ERR_ASN1_TIME_set_string_X509(s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TIME_set_string_X509');
end;


function  ERR_ASN1_TIME_to_tm(const s: PASN1_TIME; tm: PIdC_TM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TIME_to_tm');
end;


function  ERR_ASN1_TIME_normalize(s: PASN1_TIME): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TIME_normalize');
end;


function  ERR_ASN1_TIME_cmp_time_t(const s: PASN1_TIME; t: TIdC_TIMET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TIME_cmp_time_t');
end;


function  ERR_ASN1_TIME_compare(const a: PASN1_TIME; const b: PASN1_TIME): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_TIME_compare');
end;


function  ERR_ASN1_INTEGER_get_int64(pr: PIdC_Int64; const a: PASN1_INTEGER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_INTEGER_get_int64');
end;


function  ERR_ASN1_INTEGER_set_int64(a: PASN1_INTEGER; r: TIdC_Int64): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_INTEGER_set_int64');
end;


function  ERR_ASN1_INTEGER_get_uint64(pr: PIdC_UInt64; const a: PASN1_INTEGER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_INTEGER_get_uint64');
end;


function  ERR_ASN1_INTEGER_set_uint64(a: PASN1_INTEGER; r: TIdC_UInt64): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_INTEGER_set_uint64');
end;


function  ERR_ASN1_ENUMERATED_get_int64(pr: PIdC_Int64; const a: PASN1_ENUMERATED): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_ENUMERATED_get_int64');
end;


function  ERR_ASN1_ENUMERATED_set_int64(a: PASN1_ENUMERATED; r: TIdC_Int64): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_ENUMERATED_set_int64');
end;


function  ERR_ASN1_buf_print(bp: PBIO; const buf: PByte; buflen: TIdC_SIZET; off: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_buf_print');
end;


procedure  ERR_ASN1_add_stable_module; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_add_stable_module');
end;


function  ERR_ASN1_str2mask(const str: PByte; pmask: PIdC_ULONG): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_str2mask');
end;


procedure  ERR_ASN1_SCTX_free(p: PASN1_SCTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_free');
end;


function  ERR_ASN1_SCTX_get_item(p: PASN1_SCTX): PASN1_ITEM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_get_item');
end;


function  ERR_ASN1_SCTX_get_template(p: PASN1_SCTX): PASN1_TEMPLATE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_get_template');
end;


function  ERR_ASN1_SCTX_get_flags(p: PASN1_SCTX): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_get_flags');
end;


procedure  ERR_ASN1_SCTX_set_app_data(p: PASN1_SCTX; data: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_set_app_data');
end;


function  ERR_ASN1_SCTX_get_app_data(p: PASN1_SCTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_SCTX_get_app_data');
end;


function  ERR_ASN1_ITEM_lookup(const name: PIdAnsiChar): PASN1_ITEM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_ITEM_lookup');
end;


function  ERR_ASN1_ITEM_get(i: TIdC_SIZET): PASN1_ITEM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ASN1_ITEM_get');
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
  ASN1_TYPE_get := LoadFunction('ASN1_TYPE_get',AFailed);
  ASN1_TYPE_set := LoadFunction('ASN1_TYPE_set',AFailed);
  ASN1_TYPE_set1 := LoadFunction('ASN1_TYPE_set1',AFailed);
  ASN1_TYPE_cmp := LoadFunction('ASN1_TYPE_cmp',AFailed);
  ASN1_OBJECT_new := LoadFunction('ASN1_OBJECT_new',AFailed);
  ASN1_OBJECT_free := LoadFunction('ASN1_OBJECT_free',AFailed);
  i2d_ASN1_OBJECT := LoadFunction('i2d_ASN1_OBJECT',AFailed);
  d2i_ASN1_OBJECT := LoadFunction('d2i_ASN1_OBJECT',AFailed);
  ASN1_STRING_new := LoadFunction('ASN1_STRING_new',AFailed);
  ASN1_STRING_free := LoadFunction('ASN1_STRING_free',AFailed);
  ASN1_STRING_clear_free := LoadFunction('ASN1_STRING_clear_free',AFailed);
  ASN1_STRING_copy := LoadFunction('ASN1_STRING_copy',AFailed);
  ASN1_STRING_dup := LoadFunction('ASN1_STRING_dup',AFailed);
  ASN1_STRING_type_new := LoadFunction('ASN1_STRING_type_new',AFailed);
  ASN1_STRING_cmp := LoadFunction('ASN1_STRING_cmp',AFailed);
  ASN1_STRING_set := LoadFunction('ASN1_STRING_set',AFailed);
  ASN1_STRING_set0 := LoadFunction('ASN1_STRING_set0',AFailed);
  ASN1_STRING_length := LoadFunction('ASN1_STRING_length',AFailed);
  ASN1_STRING_length_set := LoadFunction('ASN1_STRING_length_set',AFailed);
  ASN1_STRING_type := LoadFunction('ASN1_STRING_type',AFailed);
  ASN1_BIT_STRING_set := LoadFunction('ASN1_BIT_STRING_set',AFailed);
  ASN1_BIT_STRING_set_bit := LoadFunction('ASN1_BIT_STRING_set_bit',AFailed);
  ASN1_BIT_STRING_get_bit := LoadFunction('ASN1_BIT_STRING_get_bit',AFailed);
  ASN1_BIT_STRING_check := LoadFunction('ASN1_BIT_STRING_check',AFailed);
  ASN1_BIT_STRING_name_print := LoadFunction('ASN1_BIT_STRING_name_print',AFailed);
  ASN1_BIT_STRING_num_asc := LoadFunction('ASN1_BIT_STRING_num_asc',AFailed);
  ASN1_BIT_STRING_set_asc := LoadFunction('ASN1_BIT_STRING_set_asc',AFailed);
  ASN1_INTEGER_new := LoadFunction('ASN1_INTEGER_new',AFailed);
  ASN1_INTEGER_free := LoadFunction('ASN1_INTEGER_free',AFailed);
  d2i_ASN1_INTEGER := LoadFunction('d2i_ASN1_INTEGER',AFailed);
  i2d_ASN1_INTEGER := LoadFunction('i2d_ASN1_INTEGER',AFailed);
  d2i_ASN1_UINTEGER := LoadFunction('d2i_ASN1_UINTEGER',AFailed);
  ASN1_INTEGER_dup := LoadFunction('ASN1_INTEGER_dup',AFailed);
  ASN1_INTEGER_cmp := LoadFunction('ASN1_INTEGER_cmp',AFailed);
  ASN1_UTCTIME_check := LoadFunction('ASN1_UTCTIME_check',AFailed);
  ASN1_UTCTIME_set := LoadFunction('ASN1_UTCTIME_set',AFailed);
  ASN1_UTCTIME_adj := LoadFunction('ASN1_UTCTIME_adj',AFailed);
  ASN1_UTCTIME_set_string := LoadFunction('ASN1_UTCTIME_set_string',AFailed);
  ASN1_UTCTIME_cmp_time_t := LoadFunction('ASN1_UTCTIME_cmp_time_t',AFailed);
  ASN1_GENERALIZEDTIME_check := LoadFunction('ASN1_GENERALIZEDTIME_check',AFailed);
  ASN1_GENERALIZEDTIME_set := LoadFunction('ASN1_GENERALIZEDTIME_set',AFailed);
  ASN1_GENERALIZEDTIME_adj := LoadFunction('ASN1_GENERALIZEDTIME_adj',AFailed);
  ASN1_GENERALIZEDTIME_set_string := LoadFunction('ASN1_GENERALIZEDTIME_set_string',AFailed);
  ASN1_TIME_diff := LoadFunction('ASN1_TIME_diff',AFailed);
  ASN1_OCTET_STRING_dup := LoadFunction('ASN1_OCTET_STRING_dup',AFailed);
  ASN1_OCTET_STRING_cmp := LoadFunction('ASN1_OCTET_STRING_cmp',AFailed);
  ASN1_OCTET_STRING_set := LoadFunction('ASN1_OCTET_STRING_set',AFailed);
  UTF8_getc := LoadFunction('UTF8_getc',AFailed);
  UTF8_putc := LoadFunction('UTF8_putc',AFailed);
  ASN1_UTCTIME_new := LoadFunction('ASN1_UTCTIME_new',AFailed);
  ASN1_UTCTIME_free := LoadFunction('ASN1_UTCTIME_free',AFailed);
  d2i_ASN1_UTCTIME := LoadFunction('d2i_ASN1_UTCTIME',AFailed);
  i2d_ASN1_UTCTIME := LoadFunction('i2d_ASN1_UTCTIME',AFailed);
  ASN1_GENERALIZEDTIME_new := LoadFunction('ASN1_GENERALIZEDTIME_new',AFailed);
  ASN1_GENERALIZEDTIME_free := LoadFunction('ASN1_GENERALIZEDTIME_free',AFailed);
  d2i_ASN1_GENERALIZEDTIME := LoadFunction('d2i_ASN1_GENERALIZEDTIME',AFailed);
  i2d_ASN1_GENERALIZEDTIME := LoadFunction('i2d_ASN1_GENERALIZEDTIME',AFailed);
  ASN1_TIME_new := LoadFunction('ASN1_TIME_new',AFailed);
  ASN1_TIME_free := LoadFunction('ASN1_TIME_free',AFailed);
  d2i_ASN1_TIME := LoadFunction('d2i_ASN1_TIME',AFailed);
  i2d_ASN1_TIME := LoadFunction('i2d_ASN1_TIME',AFailed);
  ASN1_TIME_set := LoadFunction('ASN1_TIME_set',AFailed);
  ASN1_TIME_adj := LoadFunction('ASN1_TIME_adj',AFailed);
  ASN1_TIME_check := LoadFunction('ASN1_TIME_check',AFailed);
  ASN1_TIME_to_generalizedtime := LoadFunction('ASN1_TIME_to_generalizedtime',AFailed);
  ASN1_TIME_set_string := LoadFunction('ASN1_TIME_set_string',AFailed);
  i2a_ASN1_INTEGER := LoadFunction('i2a_ASN1_INTEGER',AFailed);
  a2i_ASN1_INTEGER := LoadFunction('a2i_ASN1_INTEGER',AFailed);
  i2a_ASN1_ENUMERATED := LoadFunction('i2a_ASN1_ENUMERATED',AFailed);
  a2i_ASN1_ENUMERATED := LoadFunction('a2i_ASN1_ENUMERATED',AFailed);
  i2a_ASN1_OBJECT := LoadFunction('i2a_ASN1_OBJECT',AFailed);
  a2i_ASN1_STRING := LoadFunction('a2i_ASN1_STRING',AFailed);
  i2a_ASN1_STRING := LoadFunction('i2a_ASN1_STRING',AFailed);
  i2t_ASN1_OBJECT := LoadFunction('i2t_ASN1_OBJECT',AFailed);
  a2d_ASN1_OBJECT := LoadFunction('a2d_ASN1_OBJECT',AFailed);
  ASN1_OBJECT_create := LoadFunction('ASN1_OBJECT_create',AFailed);
  ASN1_INTEGER_set := LoadFunction('ASN1_INTEGER_set',AFailed);
  ASN1_INTEGER_get := LoadFunction('ASN1_INTEGER_get',AFailed);
  BN_to_ASN1_INTEGER := LoadFunction('BN_to_ASN1_INTEGER',AFailed);
  ASN1_INTEGER_to_BN := LoadFunction('ASN1_INTEGER_to_BN',AFailed);
  ASN1_ENUMERATED_set := LoadFunction('ASN1_ENUMERATED_set',AFailed);
  ASN1_ENUMERATED_get := LoadFunction('ASN1_ENUMERATED_get',AFailed);
  BN_to_ASN1_ENUMERATED := LoadFunction('BN_to_ASN1_ENUMERATED',AFailed);
  ASN1_ENUMERATED_to_BN := LoadFunction('ASN1_ENUMERATED_to_BN',AFailed);
  ASN1_PRINTABLE_type := LoadFunction('ASN1_PRINTABLE_type',AFailed);
  ASN1_tag2bit := LoadFunction('ASN1_tag2bit',AFailed);
  ASN1_get_object := LoadFunction('ASN1_get_object',AFailed);
  ASN1_check_infinite_end := LoadFunction('ASN1_check_infinite_end',AFailed);
  ASN1_const_check_infinite_end := LoadFunction('ASN1_const_check_infinite_end',AFailed);
  ASN1_put_object := LoadFunction('ASN1_put_object',AFailed);
  ASN1_put_eoc := LoadFunction('ASN1_put_eoc',AFailed);
  ASN1_object_size := LoadFunction('ASN1_object_size',AFailed);
  ASN1_item_dup := LoadFunction('ASN1_item_dup',AFailed);
  ASN1_STRING_to_UTF8 := LoadFunction('ASN1_STRING_to_UTF8',AFailed);
  ASN1_item_d2i_bio := LoadFunction('ASN1_item_d2i_bio',AFailed);
  ASN1_i2d_bio := LoadFunction('ASN1_i2d_bio',AFailed);
  ASN1_item_i2d_bio := LoadFunction('ASN1_item_i2d_bio',AFailed);
  ASN1_UTCTIME_print := LoadFunction('ASN1_UTCTIME_print',AFailed);
  ASN1_GENERALIZEDTIME_print := LoadFunction('ASN1_GENERALIZEDTIME_print',AFailed);
  ASN1_TIME_print := LoadFunction('ASN1_TIME_print',AFailed);
  ASN1_STRING_print := LoadFunction('ASN1_STRING_print',AFailed);
  ASN1_STRING_print_ex := LoadFunction('ASN1_STRING_print_ex',AFailed);
  ASN1_bn_print := LoadFunction('ASN1_bn_print',AFailed);
  ASN1_parse := LoadFunction('ASN1_parse',AFailed);
  ASN1_parse_dump := LoadFunction('ASN1_parse_dump',AFailed);
  ASN1_tag2str := LoadFunction('ASN1_tag2str',AFailed);
  ASN1_UNIVERSALSTRING_to_string := LoadFunction('ASN1_UNIVERSALSTRING_to_string',AFailed);
  ASN1_TYPE_set_octetstring := LoadFunction('ASN1_TYPE_set_octetstring',AFailed);
  ASN1_TYPE_get_octetstring := LoadFunction('ASN1_TYPE_get_octetstring',AFailed);
  ASN1_TYPE_set_int_octetstring := LoadFunction('ASN1_TYPE_set_int_octetstring',AFailed);
  ASN1_TYPE_get_int_octetstring := LoadFunction('ASN1_TYPE_get_int_octetstring',AFailed);
  ASN1_item_unpack := LoadFunction('ASN1_item_unpack',AFailed);
  ASN1_item_pack := LoadFunction('ASN1_item_pack',AFailed);
  ASN1_STRING_set_default_mask := LoadFunction('ASN1_STRING_set_default_mask',AFailed);
  ASN1_STRING_set_default_mask_asc := LoadFunction('ASN1_STRING_set_default_mask_asc',AFailed);
  ASN1_STRING_get_default_mask := LoadFunction('ASN1_STRING_get_default_mask',AFailed);
  ASN1_mbstring_copy := LoadFunction('ASN1_mbstring_copy',AFailed);
  ASN1_mbstring_ncopy := LoadFunction('ASN1_mbstring_ncopy',AFailed);
  ASN1_STRING_set_by_NID := LoadFunction('ASN1_STRING_set_by_NID',AFailed);
  ASN1_STRING_TABLE_get := LoadFunction('ASN1_STRING_TABLE_get',AFailed);
  ASN1_STRING_TABLE_add := LoadFunction('ASN1_STRING_TABLE_add',AFailed);
  ASN1_STRING_TABLE_cleanup := LoadFunction('ASN1_STRING_TABLE_cleanup',AFailed);
  ASN1_item_new := LoadFunction('ASN1_item_new',AFailed);
  ASN1_item_free := LoadFunction('ASN1_item_free',AFailed);
  ASN1_item_d2i := LoadFunction('ASN1_item_d2i',AFailed);
  ASN1_item_i2d := LoadFunction('ASN1_item_i2d',AFailed);
  ASN1_item_ndef_i2d := LoadFunction('ASN1_item_ndef_i2d',AFailed);
  ASN1_add_oid_module := LoadFunction('ASN1_add_oid_module',AFailed);
  ASN1_generate_nconf := LoadFunction('ASN1_generate_nconf',AFailed);
  ASN1_generate_v3 := LoadFunction('ASN1_generate_v3',AFailed);
  ASN1_item_print := LoadFunction('ASN1_item_print',AFailed);
  ASN1_PCTX_new := LoadFunction('ASN1_PCTX_new',AFailed);
  ASN1_PCTX_free := LoadFunction('ASN1_PCTX_free',AFailed);
  ASN1_PCTX_get_flags := LoadFunction('ASN1_PCTX_get_flags',AFailed);
  ASN1_PCTX_set_flags := LoadFunction('ASN1_PCTX_set_flags',AFailed);
  ASN1_PCTX_get_nm_flags := LoadFunction('ASN1_PCTX_get_nm_flags',AFailed);
  ASN1_PCTX_set_nm_flags := LoadFunction('ASN1_PCTX_set_nm_flags',AFailed);
  ASN1_PCTX_get_cert_flags := LoadFunction('ASN1_PCTX_get_cert_flags',AFailed);
  ASN1_PCTX_set_cert_flags := LoadFunction('ASN1_PCTX_set_cert_flags',AFailed);
  ASN1_PCTX_get_oid_flags := LoadFunction('ASN1_PCTX_get_oid_flags',AFailed);
  ASN1_PCTX_set_oid_flags := LoadFunction('ASN1_PCTX_set_oid_flags',AFailed);
  ASN1_PCTX_get_str_flags := LoadFunction('ASN1_PCTX_get_str_flags',AFailed);
  ASN1_PCTX_set_str_flags := LoadFunction('ASN1_PCTX_set_str_flags',AFailed);
  BIO_f_asn1 := LoadFunction('BIO_f_asn1',AFailed);
  BIO_new_NDEF := LoadFunction('BIO_new_NDEF',AFailed);
  i2d_ASN1_bio_stream := LoadFunction('i2d_ASN1_bio_stream',AFailed);
  PEM_write_bio_ASN1_stream := LoadFunction('PEM_write_bio_ASN1_stream',AFailed);
  SMIME_read_ASN1 := LoadFunction('SMIME_read_ASN1',AFailed);
  SMIME_crlf_copy := LoadFunction('SMIME_crlf_copy',AFailed);
  SMIME_text := LoadFunction('SMIME_text',AFailed);
  ASN1_TYPE_pack_sequence := LoadFunction('ASN1_TYPE_pack_sequence',nil); {introduced 1.1.0}
  ASN1_TYPE_unpack_sequence := LoadFunction('ASN1_TYPE_unpack_sequence',nil); {introduced 1.1.0}
  ASN1_STRING_get0_data := LoadFunction('ASN1_STRING_get0_data',nil); {introduced 1.1.0}
  ASN1_TIME_set_string_X509 := LoadFunction('ASN1_TIME_set_string_X509',nil); {introduced 1.1.0}
  ASN1_TIME_to_tm := LoadFunction('ASN1_TIME_to_tm',nil); {introduced 1.1.0}
  ASN1_TIME_normalize := LoadFunction('ASN1_TIME_normalize',nil); {introduced 1.1.0}
  ASN1_TIME_cmp_time_t := LoadFunction('ASN1_TIME_cmp_time_t',nil); {introduced 1.1.0}
  ASN1_TIME_compare := LoadFunction('ASN1_TIME_compare',nil); {introduced 1.1.0}
  ASN1_INTEGER_get_int64 := LoadFunction('ASN1_INTEGER_get_int64',nil); {introduced 1.1.0}
  ASN1_INTEGER_set_int64 := LoadFunction('ASN1_INTEGER_set_int64',nil); {introduced 1.1.0}
  ASN1_INTEGER_get_uint64 := LoadFunction('ASN1_INTEGER_get_uint64',nil); {introduced 1.1.0}
  ASN1_INTEGER_set_uint64 := LoadFunction('ASN1_INTEGER_set_uint64',nil); {introduced 1.1.0}
  ASN1_ENUMERATED_get_int64 := LoadFunction('ASN1_ENUMERATED_get_int64',nil); {introduced 1.1.0}
  ASN1_ENUMERATED_set_int64 := LoadFunction('ASN1_ENUMERATED_set_int64',nil); {introduced 1.1.0}
  ASN1_buf_print := LoadFunction('ASN1_buf_print',nil); {introduced 1.1.0}
  ASN1_add_stable_module := LoadFunction('ASN1_add_stable_module',nil); {introduced 1.1.0}
  ASN1_str2mask := LoadFunction('ASN1_str2mask',nil); {introduced 1.1.0}
  ASN1_SCTX_free := LoadFunction('ASN1_SCTX_free',nil); {introduced 1.1.0}
  ASN1_SCTX_get_item := LoadFunction('ASN1_SCTX_get_item',nil); {introduced 1.1.0}
  ASN1_SCTX_get_template := LoadFunction('ASN1_SCTX_get_template',nil); {introduced 1.1.0}
  ASN1_SCTX_get_flags := LoadFunction('ASN1_SCTX_get_flags',nil); {introduced 1.1.0}
  ASN1_SCTX_set_app_data := LoadFunction('ASN1_SCTX_set_app_data',nil); {introduced 1.1.0}
  ASN1_SCTX_get_app_data := LoadFunction('ASN1_SCTX_get_app_data',nil); {introduced 1.1.0}
  ASN1_ITEM_lookup := LoadFunction('ASN1_ITEM_lookup',nil); {introduced 1.1.0}
  ASN1_ITEM_get := LoadFunction('ASN1_ITEM_get',nil); {introduced 1.1.0}
  if not assigned(ASN1_TYPE_pack_sequence) then 
  begin
    {$if declared(ASN1_TYPE_pack_sequence_introduced)}
    if LibVersion < ASN1_TYPE_pack_sequence_introduced then
      {$if declared(FC_ASN1_TYPE_pack_sequence)}
      ASN1_TYPE_pack_sequence := @FC_ASN1_TYPE_pack_sequence
      {$else}
      ASN1_TYPE_pack_sequence := @ERR_ASN1_TYPE_pack_sequence
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TYPE_pack_sequence_removed)}
   if ASN1_TYPE_pack_sequence_removed <= LibVersion then
     {$if declared(_ASN1_TYPE_pack_sequence)}
     ASN1_TYPE_pack_sequence := @_ASN1_TYPE_pack_sequence
     {$else}
       {$IF declared(ERR_ASN1_TYPE_pack_sequence)}
       ASN1_TYPE_pack_sequence := @ERR_ASN1_TYPE_pack_sequence
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TYPE_pack_sequence) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TYPE_pack_sequence');
  end;


  if not assigned(ASN1_TYPE_unpack_sequence) then 
  begin
    {$if declared(ASN1_TYPE_unpack_sequence_introduced)}
    if LibVersion < ASN1_TYPE_unpack_sequence_introduced then
      {$if declared(FC_ASN1_TYPE_unpack_sequence)}
      ASN1_TYPE_unpack_sequence := @FC_ASN1_TYPE_unpack_sequence
      {$else}
      ASN1_TYPE_unpack_sequence := @ERR_ASN1_TYPE_unpack_sequence
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TYPE_unpack_sequence_removed)}
   if ASN1_TYPE_unpack_sequence_removed <= LibVersion then
     {$if declared(_ASN1_TYPE_unpack_sequence)}
     ASN1_TYPE_unpack_sequence := @_ASN1_TYPE_unpack_sequence
     {$else}
       {$IF declared(ERR_ASN1_TYPE_unpack_sequence)}
       ASN1_TYPE_unpack_sequence := @ERR_ASN1_TYPE_unpack_sequence
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TYPE_unpack_sequence) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TYPE_unpack_sequence');
  end;


  if not assigned(ASN1_STRING_get0_data) then 
  begin
    {$if declared(ASN1_STRING_get0_data_introduced)}
    if LibVersion < ASN1_STRING_get0_data_introduced then
      {$if declared(FC_ASN1_STRING_get0_data)}
      ASN1_STRING_get0_data := @FC_ASN1_STRING_get0_data
      {$else}
      ASN1_STRING_get0_data := @ERR_ASN1_STRING_get0_data
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_STRING_get0_data_removed)}
   if ASN1_STRING_get0_data_removed <= LibVersion then
     {$if declared(_ASN1_STRING_get0_data)}
     ASN1_STRING_get0_data := @_ASN1_STRING_get0_data
     {$else}
       {$IF declared(ERR_ASN1_STRING_get0_data)}
       ASN1_STRING_get0_data := @ERR_ASN1_STRING_get0_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_STRING_get0_data) and Assigned(AFailed) then 
     AFailed.Add('ASN1_STRING_get0_data');
  end;


  if not assigned(ASN1_TIME_set_string_X509) then 
  begin
    {$if declared(ASN1_TIME_set_string_X509_introduced)}
    if LibVersion < ASN1_TIME_set_string_X509_introduced then
      {$if declared(FC_ASN1_TIME_set_string_X509)}
      ASN1_TIME_set_string_X509 := @FC_ASN1_TIME_set_string_X509
      {$else}
      ASN1_TIME_set_string_X509 := @ERR_ASN1_TIME_set_string_X509
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TIME_set_string_X509_removed)}
   if ASN1_TIME_set_string_X509_removed <= LibVersion then
     {$if declared(_ASN1_TIME_set_string_X509)}
     ASN1_TIME_set_string_X509 := @_ASN1_TIME_set_string_X509
     {$else}
       {$IF declared(ERR_ASN1_TIME_set_string_X509)}
       ASN1_TIME_set_string_X509 := @ERR_ASN1_TIME_set_string_X509
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TIME_set_string_X509) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TIME_set_string_X509');
  end;


  if not assigned(ASN1_TIME_to_tm) then 
  begin
    {$if declared(ASN1_TIME_to_tm_introduced)}
    if LibVersion < ASN1_TIME_to_tm_introduced then
      {$if declared(FC_ASN1_TIME_to_tm)}
      ASN1_TIME_to_tm := @FC_ASN1_TIME_to_tm
      {$else}
      ASN1_TIME_to_tm := @ERR_ASN1_TIME_to_tm
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TIME_to_tm_removed)}
   if ASN1_TIME_to_tm_removed <= LibVersion then
     {$if declared(_ASN1_TIME_to_tm)}
     ASN1_TIME_to_tm := @_ASN1_TIME_to_tm
     {$else}
       {$IF declared(ERR_ASN1_TIME_to_tm)}
       ASN1_TIME_to_tm := @ERR_ASN1_TIME_to_tm
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TIME_to_tm) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TIME_to_tm');
  end;


  if not assigned(ASN1_TIME_normalize) then 
  begin
    {$if declared(ASN1_TIME_normalize_introduced)}
    if LibVersion < ASN1_TIME_normalize_introduced then
      {$if declared(FC_ASN1_TIME_normalize)}
      ASN1_TIME_normalize := @FC_ASN1_TIME_normalize
      {$else}
      ASN1_TIME_normalize := @ERR_ASN1_TIME_normalize
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TIME_normalize_removed)}
   if ASN1_TIME_normalize_removed <= LibVersion then
     {$if declared(_ASN1_TIME_normalize)}
     ASN1_TIME_normalize := @_ASN1_TIME_normalize
     {$else}
       {$IF declared(ERR_ASN1_TIME_normalize)}
       ASN1_TIME_normalize := @ERR_ASN1_TIME_normalize
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TIME_normalize) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TIME_normalize');
  end;


  if not assigned(ASN1_TIME_cmp_time_t) then 
  begin
    {$if declared(ASN1_TIME_cmp_time_t_introduced)}
    if LibVersion < ASN1_TIME_cmp_time_t_introduced then
      {$if declared(FC_ASN1_TIME_cmp_time_t)}
      ASN1_TIME_cmp_time_t := @FC_ASN1_TIME_cmp_time_t
      {$else}
      ASN1_TIME_cmp_time_t := @ERR_ASN1_TIME_cmp_time_t
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TIME_cmp_time_t_removed)}
   if ASN1_TIME_cmp_time_t_removed <= LibVersion then
     {$if declared(_ASN1_TIME_cmp_time_t)}
     ASN1_TIME_cmp_time_t := @_ASN1_TIME_cmp_time_t
     {$else}
       {$IF declared(ERR_ASN1_TIME_cmp_time_t)}
       ASN1_TIME_cmp_time_t := @ERR_ASN1_TIME_cmp_time_t
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TIME_cmp_time_t) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TIME_cmp_time_t');
  end;


  if not assigned(ASN1_TIME_compare) then 
  begin
    {$if declared(ASN1_TIME_compare_introduced)}
    if LibVersion < ASN1_TIME_compare_introduced then
      {$if declared(FC_ASN1_TIME_compare)}
      ASN1_TIME_compare := @FC_ASN1_TIME_compare
      {$else}
      ASN1_TIME_compare := @ERR_ASN1_TIME_compare
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_TIME_compare_removed)}
   if ASN1_TIME_compare_removed <= LibVersion then
     {$if declared(_ASN1_TIME_compare)}
     ASN1_TIME_compare := @_ASN1_TIME_compare
     {$else}
       {$IF declared(ERR_ASN1_TIME_compare)}
       ASN1_TIME_compare := @ERR_ASN1_TIME_compare
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_TIME_compare) and Assigned(AFailed) then 
     AFailed.Add('ASN1_TIME_compare');
  end;


  if not assigned(ASN1_INTEGER_get_int64) then 
  begin
    {$if declared(ASN1_INTEGER_get_int64_introduced)}
    if LibVersion < ASN1_INTEGER_get_int64_introduced then
      {$if declared(FC_ASN1_INTEGER_get_int64)}
      ASN1_INTEGER_get_int64 := @FC_ASN1_INTEGER_get_int64
      {$else}
      ASN1_INTEGER_get_int64 := @ERR_ASN1_INTEGER_get_int64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_INTEGER_get_int64_removed)}
   if ASN1_INTEGER_get_int64_removed <= LibVersion then
     {$if declared(_ASN1_INTEGER_get_int64)}
     ASN1_INTEGER_get_int64 := @_ASN1_INTEGER_get_int64
     {$else}
       {$IF declared(ERR_ASN1_INTEGER_get_int64)}
       ASN1_INTEGER_get_int64 := @ERR_ASN1_INTEGER_get_int64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_INTEGER_get_int64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_INTEGER_get_int64');
  end;


  if not assigned(ASN1_INTEGER_set_int64) then 
  begin
    {$if declared(ASN1_INTEGER_set_int64_introduced)}
    if LibVersion < ASN1_INTEGER_set_int64_introduced then
      {$if declared(FC_ASN1_INTEGER_set_int64)}
      ASN1_INTEGER_set_int64 := @FC_ASN1_INTEGER_set_int64
      {$else}
      ASN1_INTEGER_set_int64 := @ERR_ASN1_INTEGER_set_int64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_INTEGER_set_int64_removed)}
   if ASN1_INTEGER_set_int64_removed <= LibVersion then
     {$if declared(_ASN1_INTEGER_set_int64)}
     ASN1_INTEGER_set_int64 := @_ASN1_INTEGER_set_int64
     {$else}
       {$IF declared(ERR_ASN1_INTEGER_set_int64)}
       ASN1_INTEGER_set_int64 := @ERR_ASN1_INTEGER_set_int64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_INTEGER_set_int64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_INTEGER_set_int64');
  end;


  if not assigned(ASN1_INTEGER_get_uint64) then 
  begin
    {$if declared(ASN1_INTEGER_get_uint64_introduced)}
    if LibVersion < ASN1_INTEGER_get_uint64_introduced then
      {$if declared(FC_ASN1_INTEGER_get_uint64)}
      ASN1_INTEGER_get_uint64 := @FC_ASN1_INTEGER_get_uint64
      {$else}
      ASN1_INTEGER_get_uint64 := @ERR_ASN1_INTEGER_get_uint64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_INTEGER_get_uint64_removed)}
   if ASN1_INTEGER_get_uint64_removed <= LibVersion then
     {$if declared(_ASN1_INTEGER_get_uint64)}
     ASN1_INTEGER_get_uint64 := @_ASN1_INTEGER_get_uint64
     {$else}
       {$IF declared(ERR_ASN1_INTEGER_get_uint64)}
       ASN1_INTEGER_get_uint64 := @ERR_ASN1_INTEGER_get_uint64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_INTEGER_get_uint64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_INTEGER_get_uint64');
  end;


  if not assigned(ASN1_INTEGER_set_uint64) then 
  begin
    {$if declared(ASN1_INTEGER_set_uint64_introduced)}
    if LibVersion < ASN1_INTEGER_set_uint64_introduced then
      {$if declared(FC_ASN1_INTEGER_set_uint64)}
      ASN1_INTEGER_set_uint64 := @FC_ASN1_INTEGER_set_uint64
      {$else}
      ASN1_INTEGER_set_uint64 := @ERR_ASN1_INTEGER_set_uint64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_INTEGER_set_uint64_removed)}
   if ASN1_INTEGER_set_uint64_removed <= LibVersion then
     {$if declared(_ASN1_INTEGER_set_uint64)}
     ASN1_INTEGER_set_uint64 := @_ASN1_INTEGER_set_uint64
     {$else}
       {$IF declared(ERR_ASN1_INTEGER_set_uint64)}
       ASN1_INTEGER_set_uint64 := @ERR_ASN1_INTEGER_set_uint64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_INTEGER_set_uint64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_INTEGER_set_uint64');
  end;


  if not assigned(ASN1_ENUMERATED_get_int64) then 
  begin
    {$if declared(ASN1_ENUMERATED_get_int64_introduced)}
    if LibVersion < ASN1_ENUMERATED_get_int64_introduced then
      {$if declared(FC_ASN1_ENUMERATED_get_int64)}
      ASN1_ENUMERATED_get_int64 := @FC_ASN1_ENUMERATED_get_int64
      {$else}
      ASN1_ENUMERATED_get_int64 := @ERR_ASN1_ENUMERATED_get_int64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_ENUMERATED_get_int64_removed)}
   if ASN1_ENUMERATED_get_int64_removed <= LibVersion then
     {$if declared(_ASN1_ENUMERATED_get_int64)}
     ASN1_ENUMERATED_get_int64 := @_ASN1_ENUMERATED_get_int64
     {$else}
       {$IF declared(ERR_ASN1_ENUMERATED_get_int64)}
       ASN1_ENUMERATED_get_int64 := @ERR_ASN1_ENUMERATED_get_int64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_ENUMERATED_get_int64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_ENUMERATED_get_int64');
  end;


  if not assigned(ASN1_ENUMERATED_set_int64) then 
  begin
    {$if declared(ASN1_ENUMERATED_set_int64_introduced)}
    if LibVersion < ASN1_ENUMERATED_set_int64_introduced then
      {$if declared(FC_ASN1_ENUMERATED_set_int64)}
      ASN1_ENUMERATED_set_int64 := @FC_ASN1_ENUMERATED_set_int64
      {$else}
      ASN1_ENUMERATED_set_int64 := @ERR_ASN1_ENUMERATED_set_int64
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_ENUMERATED_set_int64_removed)}
   if ASN1_ENUMERATED_set_int64_removed <= LibVersion then
     {$if declared(_ASN1_ENUMERATED_set_int64)}
     ASN1_ENUMERATED_set_int64 := @_ASN1_ENUMERATED_set_int64
     {$else}
       {$IF declared(ERR_ASN1_ENUMERATED_set_int64)}
       ASN1_ENUMERATED_set_int64 := @ERR_ASN1_ENUMERATED_set_int64
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_ENUMERATED_set_int64) and Assigned(AFailed) then 
     AFailed.Add('ASN1_ENUMERATED_set_int64');
  end;


  if not assigned(ASN1_buf_print) then 
  begin
    {$if declared(ASN1_buf_print_introduced)}
    if LibVersion < ASN1_buf_print_introduced then
      {$if declared(FC_ASN1_buf_print)}
      ASN1_buf_print := @FC_ASN1_buf_print
      {$else}
      ASN1_buf_print := @ERR_ASN1_buf_print
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_buf_print_removed)}
   if ASN1_buf_print_removed <= LibVersion then
     {$if declared(_ASN1_buf_print)}
     ASN1_buf_print := @_ASN1_buf_print
     {$else}
       {$IF declared(ERR_ASN1_buf_print)}
       ASN1_buf_print := @ERR_ASN1_buf_print
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_buf_print) and Assigned(AFailed) then 
     AFailed.Add('ASN1_buf_print');
  end;


  if not assigned(ASN1_add_stable_module) then 
  begin
    {$if declared(ASN1_add_stable_module_introduced)}
    if LibVersion < ASN1_add_stable_module_introduced then
      {$if declared(FC_ASN1_add_stable_module)}
      ASN1_add_stable_module := @FC_ASN1_add_stable_module
      {$else}
      ASN1_add_stable_module := @ERR_ASN1_add_stable_module
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_add_stable_module_removed)}
   if ASN1_add_stable_module_removed <= LibVersion then
     {$if declared(_ASN1_add_stable_module)}
     ASN1_add_stable_module := @_ASN1_add_stable_module
     {$else}
       {$IF declared(ERR_ASN1_add_stable_module)}
       ASN1_add_stable_module := @ERR_ASN1_add_stable_module
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_add_stable_module) and Assigned(AFailed) then 
     AFailed.Add('ASN1_add_stable_module');
  end;


  if not assigned(ASN1_str2mask) then 
  begin
    {$if declared(ASN1_str2mask_introduced)}
    if LibVersion < ASN1_str2mask_introduced then
      {$if declared(FC_ASN1_str2mask)}
      ASN1_str2mask := @FC_ASN1_str2mask
      {$else}
      ASN1_str2mask := @ERR_ASN1_str2mask
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_str2mask_removed)}
   if ASN1_str2mask_removed <= LibVersion then
     {$if declared(_ASN1_str2mask)}
     ASN1_str2mask := @_ASN1_str2mask
     {$else}
       {$IF declared(ERR_ASN1_str2mask)}
       ASN1_str2mask := @ERR_ASN1_str2mask
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_str2mask) and Assigned(AFailed) then 
     AFailed.Add('ASN1_str2mask');
  end;


  if not assigned(ASN1_SCTX_free) then 
  begin
    {$if declared(ASN1_SCTX_free_introduced)}
    if LibVersion < ASN1_SCTX_free_introduced then
      {$if declared(FC_ASN1_SCTX_free)}
      ASN1_SCTX_free := @FC_ASN1_SCTX_free
      {$else}
      ASN1_SCTX_free := @ERR_ASN1_SCTX_free
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_free_removed)}
   if ASN1_SCTX_free_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_free)}
     ASN1_SCTX_free := @_ASN1_SCTX_free
     {$else}
       {$IF declared(ERR_ASN1_SCTX_free)}
       ASN1_SCTX_free := @ERR_ASN1_SCTX_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_free) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_free');
  end;


  if not assigned(ASN1_SCTX_get_item) then 
  begin
    {$if declared(ASN1_SCTX_get_item_introduced)}
    if LibVersion < ASN1_SCTX_get_item_introduced then
      {$if declared(FC_ASN1_SCTX_get_item)}
      ASN1_SCTX_get_item := @FC_ASN1_SCTX_get_item
      {$else}
      ASN1_SCTX_get_item := @ERR_ASN1_SCTX_get_item
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_get_item_removed)}
   if ASN1_SCTX_get_item_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_get_item)}
     ASN1_SCTX_get_item := @_ASN1_SCTX_get_item
     {$else}
       {$IF declared(ERR_ASN1_SCTX_get_item)}
       ASN1_SCTX_get_item := @ERR_ASN1_SCTX_get_item
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_get_item) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_get_item');
  end;


  if not assigned(ASN1_SCTX_get_template) then 
  begin
    {$if declared(ASN1_SCTX_get_template_introduced)}
    if LibVersion < ASN1_SCTX_get_template_introduced then
      {$if declared(FC_ASN1_SCTX_get_template)}
      ASN1_SCTX_get_template := @FC_ASN1_SCTX_get_template
      {$else}
      ASN1_SCTX_get_template := @ERR_ASN1_SCTX_get_template
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_get_template_removed)}
   if ASN1_SCTX_get_template_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_get_template)}
     ASN1_SCTX_get_template := @_ASN1_SCTX_get_template
     {$else}
       {$IF declared(ERR_ASN1_SCTX_get_template)}
       ASN1_SCTX_get_template := @ERR_ASN1_SCTX_get_template
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_get_template) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_get_template');
  end;


  if not assigned(ASN1_SCTX_get_flags) then 
  begin
    {$if declared(ASN1_SCTX_get_flags_introduced)}
    if LibVersion < ASN1_SCTX_get_flags_introduced then
      {$if declared(FC_ASN1_SCTX_get_flags)}
      ASN1_SCTX_get_flags := @FC_ASN1_SCTX_get_flags
      {$else}
      ASN1_SCTX_get_flags := @ERR_ASN1_SCTX_get_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_get_flags_removed)}
   if ASN1_SCTX_get_flags_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_get_flags)}
     ASN1_SCTX_get_flags := @_ASN1_SCTX_get_flags
     {$else}
       {$IF declared(ERR_ASN1_SCTX_get_flags)}
       ASN1_SCTX_get_flags := @ERR_ASN1_SCTX_get_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_get_flags) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_get_flags');
  end;


  if not assigned(ASN1_SCTX_set_app_data) then 
  begin
    {$if declared(ASN1_SCTX_set_app_data_introduced)}
    if LibVersion < ASN1_SCTX_set_app_data_introduced then
      {$if declared(FC_ASN1_SCTX_set_app_data)}
      ASN1_SCTX_set_app_data := @FC_ASN1_SCTX_set_app_data
      {$else}
      ASN1_SCTX_set_app_data := @ERR_ASN1_SCTX_set_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_set_app_data_removed)}
   if ASN1_SCTX_set_app_data_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_set_app_data)}
     ASN1_SCTX_set_app_data := @_ASN1_SCTX_set_app_data
     {$else}
       {$IF declared(ERR_ASN1_SCTX_set_app_data)}
       ASN1_SCTX_set_app_data := @ERR_ASN1_SCTX_set_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_set_app_data) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_set_app_data');
  end;


  if not assigned(ASN1_SCTX_get_app_data) then 
  begin
    {$if declared(ASN1_SCTX_get_app_data_introduced)}
    if LibVersion < ASN1_SCTX_get_app_data_introduced then
      {$if declared(FC_ASN1_SCTX_get_app_data)}
      ASN1_SCTX_get_app_data := @FC_ASN1_SCTX_get_app_data
      {$else}
      ASN1_SCTX_get_app_data := @ERR_ASN1_SCTX_get_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_SCTX_get_app_data_removed)}
   if ASN1_SCTX_get_app_data_removed <= LibVersion then
     {$if declared(_ASN1_SCTX_get_app_data)}
     ASN1_SCTX_get_app_data := @_ASN1_SCTX_get_app_data
     {$else}
       {$IF declared(ERR_ASN1_SCTX_get_app_data)}
       ASN1_SCTX_get_app_data := @ERR_ASN1_SCTX_get_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_SCTX_get_app_data) and Assigned(AFailed) then 
     AFailed.Add('ASN1_SCTX_get_app_data');
  end;


  if not assigned(ASN1_ITEM_lookup) then 
  begin
    {$if declared(ASN1_ITEM_lookup_introduced)}
    if LibVersion < ASN1_ITEM_lookup_introduced then
      {$if declared(FC_ASN1_ITEM_lookup)}
      ASN1_ITEM_lookup := @FC_ASN1_ITEM_lookup
      {$else}
      ASN1_ITEM_lookup := @ERR_ASN1_ITEM_lookup
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_ITEM_lookup_removed)}
   if ASN1_ITEM_lookup_removed <= LibVersion then
     {$if declared(_ASN1_ITEM_lookup)}
     ASN1_ITEM_lookup := @_ASN1_ITEM_lookup
     {$else}
       {$IF declared(ERR_ASN1_ITEM_lookup)}
       ASN1_ITEM_lookup := @ERR_ASN1_ITEM_lookup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_ITEM_lookup) and Assigned(AFailed) then 
     AFailed.Add('ASN1_ITEM_lookup');
  end;


  if not assigned(ASN1_ITEM_get) then 
  begin
    {$if declared(ASN1_ITEM_get_introduced)}
    if LibVersion < ASN1_ITEM_get_introduced then
      {$if declared(FC_ASN1_ITEM_get)}
      ASN1_ITEM_get := @FC_ASN1_ITEM_get
      {$else}
      ASN1_ITEM_get := @ERR_ASN1_ITEM_get
      {$ifend}
    else
    {$ifend}
   {$if declared(ASN1_ITEM_get_removed)}
   if ASN1_ITEM_get_removed <= LibVersion then
     {$if declared(_ASN1_ITEM_get)}
     ASN1_ITEM_get := @_ASN1_ITEM_get
     {$else}
       {$IF declared(ERR_ASN1_ITEM_get)}
       ASN1_ITEM_get := @ERR_ASN1_ITEM_get
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ASN1_ITEM_get) and Assigned(AFailed) then 
     AFailed.Add('ASN1_ITEM_get');
  end;


end;

procedure Unload;
begin
  ASN1_TYPE_get := nil;
  ASN1_TYPE_set := nil;
  ASN1_TYPE_set1 := nil;
  ASN1_TYPE_cmp := nil;
  ASN1_TYPE_pack_sequence := nil; {introduced 1.1.0}
  ASN1_TYPE_unpack_sequence := nil; {introduced 1.1.0}
  ASN1_OBJECT_new := nil;
  ASN1_OBJECT_free := nil;
  i2d_ASN1_OBJECT := nil;
  d2i_ASN1_OBJECT := nil;
  ASN1_STRING_new := nil;
  ASN1_STRING_free := nil;
  ASN1_STRING_clear_free := nil;
  ASN1_STRING_copy := nil;
  ASN1_STRING_dup := nil;
  ASN1_STRING_type_new := nil;
  ASN1_STRING_cmp := nil;
  ASN1_STRING_set := nil;
  ASN1_STRING_set0 := nil;
  ASN1_STRING_length := nil;
  ASN1_STRING_length_set := nil;
  ASN1_STRING_type := nil;
  ASN1_STRING_get0_data := nil; {introduced 1.1.0}
  ASN1_BIT_STRING_set := nil;
  ASN1_BIT_STRING_set_bit := nil;
  ASN1_BIT_STRING_get_bit := nil;
  ASN1_BIT_STRING_check := nil;
  ASN1_BIT_STRING_name_print := nil;
  ASN1_BIT_STRING_num_asc := nil;
  ASN1_BIT_STRING_set_asc := nil;
  ASN1_INTEGER_new := nil;
  ASN1_INTEGER_free := nil;
  d2i_ASN1_INTEGER := nil;
  i2d_ASN1_INTEGER := nil;
  d2i_ASN1_UINTEGER := nil;
  ASN1_INTEGER_dup := nil;
  ASN1_INTEGER_cmp := nil;
  ASN1_UTCTIME_check := nil;
  ASN1_UTCTIME_set := nil;
  ASN1_UTCTIME_adj := nil;
  ASN1_UTCTIME_set_string := nil;
  ASN1_UTCTIME_cmp_time_t := nil;
  ASN1_GENERALIZEDTIME_check := nil;
  ASN1_GENERALIZEDTIME_set := nil;
  ASN1_GENERALIZEDTIME_adj := nil;
  ASN1_GENERALIZEDTIME_set_string := nil;
  ASN1_TIME_diff := nil;
  ASN1_OCTET_STRING_dup := nil;
  ASN1_OCTET_STRING_cmp := nil;
  ASN1_OCTET_STRING_set := nil;
  UTF8_getc := nil;
  UTF8_putc := nil;
  ASN1_UTCTIME_new := nil;
  ASN1_UTCTIME_free := nil;
  d2i_ASN1_UTCTIME := nil;
  i2d_ASN1_UTCTIME := nil;
  ASN1_GENERALIZEDTIME_new := nil;
  ASN1_GENERALIZEDTIME_free := nil;
  d2i_ASN1_GENERALIZEDTIME := nil;
  i2d_ASN1_GENERALIZEDTIME := nil;
  ASN1_TIME_new := nil;
  ASN1_TIME_free := nil;
  d2i_ASN1_TIME := nil;
  i2d_ASN1_TIME := nil;
  ASN1_TIME_set := nil;
  ASN1_TIME_adj := nil;
  ASN1_TIME_check := nil;
  ASN1_TIME_to_generalizedtime := nil;
  ASN1_TIME_set_string := nil;
  ASN1_TIME_set_string_X509 := nil; {introduced 1.1.0}
  ASN1_TIME_to_tm := nil; {introduced 1.1.0}
  ASN1_TIME_normalize := nil; {introduced 1.1.0}
  ASN1_TIME_cmp_time_t := nil; {introduced 1.1.0}
  ASN1_TIME_compare := nil; {introduced 1.1.0}
  i2a_ASN1_INTEGER := nil;
  a2i_ASN1_INTEGER := nil;
  i2a_ASN1_ENUMERATED := nil;
  a2i_ASN1_ENUMERATED := nil;
  i2a_ASN1_OBJECT := nil;
  a2i_ASN1_STRING := nil;
  i2a_ASN1_STRING := nil;
  i2t_ASN1_OBJECT := nil;
  a2d_ASN1_OBJECT := nil;
  ASN1_OBJECT_create := nil;
  ASN1_INTEGER_get_int64 := nil; {introduced 1.1.0}
  ASN1_INTEGER_set_int64 := nil; {introduced 1.1.0}
  ASN1_INTEGER_get_uint64 := nil; {introduced 1.1.0}
  ASN1_INTEGER_set_uint64 := nil; {introduced 1.1.0}
  ASN1_INTEGER_set := nil;
  ASN1_INTEGER_get := nil;
  BN_to_ASN1_INTEGER := nil;
  ASN1_INTEGER_to_BN := nil;
  ASN1_ENUMERATED_get_int64 := nil; {introduced 1.1.0}
  ASN1_ENUMERATED_set_int64 := nil; {introduced 1.1.0}
  ASN1_ENUMERATED_set := nil;
  ASN1_ENUMERATED_get := nil;
  BN_to_ASN1_ENUMERATED := nil;
  ASN1_ENUMERATED_to_BN := nil;
  ASN1_PRINTABLE_type := nil;
  ASN1_tag2bit := nil;
  ASN1_get_object := nil;
  ASN1_check_infinite_end := nil;
  ASN1_const_check_infinite_end := nil;
  ASN1_put_object := nil;
  ASN1_put_eoc := nil;
  ASN1_object_size := nil;
  ASN1_item_dup := nil;
  ASN1_STRING_to_UTF8 := nil;
  ASN1_item_d2i_bio := nil;
  ASN1_i2d_bio := nil;
  ASN1_item_i2d_bio := nil;
  ASN1_UTCTIME_print := nil;
  ASN1_GENERALIZEDTIME_print := nil;
  ASN1_TIME_print := nil;
  ASN1_STRING_print := nil;
  ASN1_STRING_print_ex := nil;
  ASN1_buf_print := nil; {introduced 1.1.0}
  ASN1_bn_print := nil;
  ASN1_parse := nil;
  ASN1_parse_dump := nil;
  ASN1_tag2str := nil;
  ASN1_UNIVERSALSTRING_to_string := nil;
  ASN1_TYPE_set_octetstring := nil;
  ASN1_TYPE_get_octetstring := nil;
  ASN1_TYPE_set_int_octetstring := nil;
  ASN1_TYPE_get_int_octetstring := nil;
  ASN1_item_unpack := nil;
  ASN1_item_pack := nil;
  ASN1_STRING_set_default_mask := nil;
  ASN1_STRING_set_default_mask_asc := nil;
  ASN1_STRING_get_default_mask := nil;
  ASN1_mbstring_copy := nil;
  ASN1_mbstring_ncopy := nil;
  ASN1_STRING_set_by_NID := nil;
  ASN1_STRING_TABLE_get := nil;
  ASN1_STRING_TABLE_add := nil;
  ASN1_STRING_TABLE_cleanup := nil;
  ASN1_item_new := nil;
  ASN1_item_free := nil;
  ASN1_item_d2i := nil;
  ASN1_item_i2d := nil;
  ASN1_item_ndef_i2d := nil;
  ASN1_add_oid_module := nil;
  ASN1_add_stable_module := nil; {introduced 1.1.0}
  ASN1_generate_nconf := nil;
  ASN1_generate_v3 := nil;
  ASN1_str2mask := nil; {introduced 1.1.0}
  ASN1_item_print := nil;
  ASN1_PCTX_new := nil;
  ASN1_PCTX_free := nil;
  ASN1_PCTX_get_flags := nil;
  ASN1_PCTX_set_flags := nil;
  ASN1_PCTX_get_nm_flags := nil;
  ASN1_PCTX_set_nm_flags := nil;
  ASN1_PCTX_get_cert_flags := nil;
  ASN1_PCTX_set_cert_flags := nil;
  ASN1_PCTX_get_oid_flags := nil;
  ASN1_PCTX_set_oid_flags := nil;
  ASN1_PCTX_get_str_flags := nil;
  ASN1_PCTX_set_str_flags := nil;
  ASN1_SCTX_free := nil; {introduced 1.1.0}
  ASN1_SCTX_get_item := nil; {introduced 1.1.0}
  ASN1_SCTX_get_template := nil; {introduced 1.1.0}
  ASN1_SCTX_get_flags := nil; {introduced 1.1.0}
  ASN1_SCTX_set_app_data := nil; {introduced 1.1.0}
  ASN1_SCTX_get_app_data := nil; {introduced 1.1.0}
  BIO_f_asn1 := nil;
  BIO_new_NDEF := nil;
  i2d_ASN1_bio_stream := nil;
  PEM_write_bio_ASN1_stream := nil;
  SMIME_read_ASN1 := nil;
  SMIME_crlf_copy := nil;
  SMIME_text := nil;
  ASN1_ITEM_lookup := nil; {introduced 1.1.0}
  ASN1_ITEM_get := nil; {introduced 1.1.0}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
