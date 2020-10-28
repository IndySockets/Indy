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

unit IdOpenSSLHeaders_asn1;

interface

// Headers for OpenSSL 1.1.1
// asn1.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
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

var
// DECLARE_ASN1_FUNCTIONS_fname(ASN1_TYPE, ASN1_ANY, ASN1_TYPE)
  function ASN1_TYPE_get(const a: PASN1_TYPE): TIdC_INT;
  procedure ASN1_TYPE_set(a: PASN1_TYPE; type_: TIdC_INT; value: Pointer);
  function ASN1_TYPE_set1(a: PASN1_TYPE; type_: TIdC_INT; const value: Pointer): TIdC_INT;
  function ASN1_TYPE_cmp(const a: PASN1_TYPE; const b: PASN1_TYPE): TIdC_INT;

  function ASN1_TYPE_pack_sequence(const it: PASN1_ITEM; s: Pointer; t: PPASN1_TYPE): PASN1_TYPE;
  function ASN1_TYPE_unpack_sequence(const it: PASN1_ITEM; const t: PASN1_TYPE): Pointer;

  function ASN1_OBJECT_new: PASN1_OBJECT;
  procedure ASN1_OBJECT_free(a: PASN1_OBJECT);
  function i2d_ASN1_OBJECT(const a: PASN1_OBJECT; pp: PPByte): TIdC_INT;
  function d2i_ASN1_OBJECT(a: PPASN1_OBJECT; const pp: PPByte; length: TIdC_LONG): PASN1_OBJECT;

  //DECLARE_ASN1_ITEM(ASN1_OBJECT)
  //
  //DEFINE_STACK_OF(ASN1_OBJECT)

  function ASN1_STRING_new: PASN1_STRING;
  procedure ASN1_STRING_free(a: PASN1_STRING);
  procedure ASN1_STRING_clear_free(a: PASN1_STRING);
  function ASN1_STRING_copy(dst: PASN1_STRING; const str: PASN1_STRING): TIdC_INT;
  function ASN1_STRING_dup(const a: PASN1_STRING): PASN1_STRING;
  function ASN1_STRING_type_new(&type: TIdC_INT): PASN1_STRING;
  function ASN1_STRING_cmp(const a: PASN1_STRING; const b: PASN1_STRING): TIdC_INT;

  (*
   * Since this is used to store all sorts of things, via macros, for now,
   * make its data void *
   *)
  function ASN1_STRING_set(str: PASN1_STRING; const data: Pointer; len: TIdC_INT): TIdC_INT;
  procedure ASN1_STRING_set0(str: PASN1_STRING; data: Pointer; len: TIdC_INT);
  function ASN1_STRING_length(const x: PASN1_STRING): TIdC_INT;
  procedure ASN1_STRING_length_set(x: PASN1_STRING; n: TIdC_INT);
  function ASN1_STRING_type(const x: PASN1_STRING): TIdC_INT;
  function ASN1_STRING_get0_data(const x: PASN1_STRING): PByte;

  //DECLARE_ASN1_FUNCTIONS(ASN1_BIT_STRING)
  function ASN1_BIT_STRING_set(a: PASN1_BIT_STRING; d: PByte; length: TIdC_INT): TIdC_INT;
  function ASN1_BIT_STRING_set_bit(a: PASN1_BIT_STRING; n: TIdC_INT; value: TIdC_INT): TIdC_INT;
  function ASN1_BIT_STRING_get_bit(const a: PASN1_BIT_STRING; n: TIdC_INT): TIdC_INT;
  function ASN1_BIT_STRING_check(const a: PASN1_BIT_STRING; const flags: PByte; flags_len: TIdC_INT): TIdC_INT;

  function ASN1_BIT_STRING_name_print(&out: PBIO; bs: PASN1_BIT_STRING; tbl: PBIT_STRING_BITNAME; indent: TIdC_INT): TIdC_INT;
  function ASN1_BIT_STRING_num_asc(const name: PIdAnsiChar; tbl: PBIT_STRING_BITNAME): TIdC_INT;
  function ASN1_BIT_STRING_set_asc(bs: PASN1_BIT_STRING; const name: PIdAnsiChar; value: TIdC_INT; tbl: PBIT_STRING_BITNAME): TIdC_INT;

  //DECLARE_ASN1_FUNCTIONS(ASN1_INTEGER)
  function d2i_ASN1_UINTEGER(a: PPASN1_INTEGER; const pp: PPByte; length: TIdC_LONG): PASN1_INTEGER;
  function ASN1_INTEGER_dup(const x: PASN1_INTEGER): PASN1_INTEGER;
  function ASN1_INTEGER_cmp(const x: PASN1_INTEGER; const y: PASN1_INTEGER): TIdC_INT;

  // DECLARE_ASN1_FUNCTIONS(ASN1_ENUMERATED)

  function ASN1_UTCTIME_check(const a: PASN1_UTCTIME): TIdC_INT;
  function ASN1_UTCTIME_set(s: PASN1_UTCTIME; t: TIdC_TIMET): PASN1_UTCTIME;
  function ASN1_UTCTIME_adj(s: PASN1_UTCTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_UTCTIME;
  function ASN1_UTCTIME_set_string(s: PASN1_UTCTIME; const str: PAnsiChar): TIdC_INT;
  function ASN1_UTCTIME_cmp_time_t(const s: PASN1_UTCTIME; t: TIdC_TIMET): TIdC_INT;

  function ASN1_GENERALIZEDTIME_check(const a: PASN1_GENERALIZEDTIME): TIdC_INT;
  function ASN1_GENERALIZEDTIME_set(s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET): PASN1_GENERALIZEDTIME;
  function ASN1_GENERALIZEDTIME_adj(s: PASN1_GENERALIZEDTIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_GENERALIZEDTIME;
  function ASN1_GENERALIZEDTIME_set_string(s: pASN1_GENERALIZEDTIME; const str: PAnsiChar): TIdC_INT;

  function ASN1_TIME_diff(pday: PIdC_INT; psec: PIdC_INT; const from: PASN1_TIME; const to_: PASN1_TIME): TIdC_INT;

  // DECLARE_ASN1_FUNCTIONS(ASN1_OCTET_STRING)
  function ASN1_OCTET_STRING_dup(const a: PASN1_OCTET_STRING): PASN1_OCTET_STRING;
  function ASN1_OCTET_STRING_cmp(const a: PASN1_OCTET_STRING; const b: PASN1_OCTET_STRING): TIdC_INT;
  function ASN1_OCTET_STRING_set(str: PASN1_OCTET_STRING; const data: PByte; len: TIdC_INT): TIdC_INT;

  //DECLARE_ASN1_FUNCTIONS(ASN1_VISIBLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UNIVERSALSTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UTF8STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_NULL)
  //DECLARE_ASN1_FUNCTIONS(ASN1_BMPSTRING)

  function UTF8_getc(const str: PByte; len: TIdC_INT; val: PIdC_ULONG): TIdC_INT;
  function UTF8_putc(str: PIdAnsiChar; len: TIdC_INT; value: TIdC_ULONG): TIdC_INT;

  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, ASN1_PRINTABLE)
  //
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DIRECTORYSTRING)
  //DECLARE_ASN1_FUNCTIONS_name(ASN1_STRING, DISPLAYTEXT)
  //DECLARE_ASN1_FUNCTIONS(ASN1_PRINTABLESTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_T61STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_IA5STRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_GENERALSTRING)
  //DECLARE_ASN1_FUNCTIONS(ASN1_UTCTIME)
  //DECLARE_ASN1_FUNCTIONS(ASN1_GENERALIZEDTIME)
  //DECLARE_ASN1_FUNCTIONS(ASN1_TIME)

  // DECLARE_ASN1_ITEM(ASN1_OCTET_STRING_NDEF)

  function ASN1_TIME_set(s: PASN1_TIME; t: TIdC_TIMET): PASN1_TIME;
  function ASN1_TIME_adj(s: PASN1_TIME; t: TIdC_TIMET; offset_day: TIdC_INT; offset_sec: TIdC_LONG): PASN1_TIME;
  function ASN1_TIME_check(const t: PASN1_TIME): TIdC_INT;
  function ASN1_TIME_to_generalizedtime(const t: PASN1_TIME; out_: PPASN1_GENERALIZEDTIME): PASN1_GENERALIZEDTIME;
  function ASN1_TIME_set_string(s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT;
  function ASN1_TIME_set_string_X509(s: PASN1_TIME; const str: PIdAnsiChar): TIdC_INT;
  function ASN1_TIME_to_tm(const s: PASN1_TIME; tm: PIdC_TM): TIdC_INT;
  function ASN1_TIME_normalize(s: PASN1_TIME): TIdC_INT;
  function ASN1_TIME_cmp_time_t(const s: PASN1_TIME; t: TIdC_TIMET): TIdC_INT;
  function ASN1_TIME_compare(const a: PASN1_TIME; const b: PASN1_TIME): TIdC_INT;

  function i2a_ASN1_INTEGER(bp: PBIO; const a: PASN1_INTEGER): TIdC_INT;
  function a2i_ASN1_INTEGER(bp: PBIO; bs: PASN1_INTEGER; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT;
  function i2a_ASN1_ENUMERATED(bp: PBIO; const a: PASN1_ENUMERATED): TIdC_INT;
  function a2i_ASN1_ENUMERATED(bp: PBIO; bs: PASN1_ENUMERATED; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT;
  function i2a_ASN1_OBJECT(bp: PBIO; const a: PASN1_OBJECT): TIdC_INT;
  function a2i_ASN1_STRING(bp: PBIO; bs: PASN1_STRING; buf: PAnsiChar; size: TIdC_INT): TIdC_INT;
  function i2a_ASN1_STRING(bp: PBIO; const a: PASN1_STRING; type_: TIdC_INT): TIdC_INT;
  function i2t_ASN1_OBJECT(buf: PAnsiChar; buf_len: TIdC_INT; const a: PASN1_OBJECT): TIdC_INT;

  function a2d_ASN1_OBJECT(&out: PByte; olen: TIdC_INT; const buf: PIdAnsiChar; num: TIdC_INT): TIdC_INT;
  function ASN1_OBJECT_create(nid: TIdC_INT; data: PByte; len: TIdC_INT; const sn: PAnsiChar; const ln: PAnsiChar): PASN1_OBJECT;

  function ASN1_INTEGER_get_int64(pr: PIdC_Int64; const a: PASN1_INTEGER): TIdC_INT;
  function ASN1_INTEGER_set_int64(a: PASN1_INTEGER; r: TIdC_Int64): TIdC_INT;
  function ASN1_INTEGER_get_uint64(pr: PIdC_UInt64; const a: PASN1_INTEGER): TIdC_INT;
  function ASN1_INTEGER_set_uint64(a: PASN1_INTEGER; r: TIdC_UInt64): TIdC_INT;

  function ASN1_INTEGER_set(a: PASN1_INTEGER; v: TIdC_LONG): TIdC_INT;
  function ASN1_INTEGER_get(const a: PASN1_INTEGER): TIdC_LONG;
  function BN_to_ASN1_INTEGER(const bn: PBIGNUM; ai: PASN1_INTEGER): PASN1_INTEGER;
  function ASN1_INTEGER_to_BN(const ai: PASN1_INTEGER; bn: PBIGNUM): PBIGNUM;

  function ASN1_ENUMERATED_get_int64(pr: PIdC_Int64; const a: PASN1_ENUMERATED): TIdC_INT;
  function ASN1_ENUMERATED_set_int64(a: PASN1_ENUMERATED; r: TIdC_Int64): TIdC_INT;


  function ASN1_ENUMERATED_set(a: PASN1_ENUMERATED; v: TIdC_LONG): TIdC_INT;
  function ASN1_ENUMERATED_get(const a: PASN1_ENUMERATED): TIdC_LONG;
  function BN_to_ASN1_ENUMERATED(const bn: PBIGNUM; ai: PASN1_ENUMERATED): PASN1_ENUMERATED;
  function ASN1_ENUMERATED_to_BN(const ai: PASN1_ENUMERATED; bn: PBIGNUM): PBIGNUM;

  (* General *)
  (* given a string, return the correct type, max is the maximum length *)
  function ASN1_PRINTABLE_type(const s: PByte; max: TIdC_INT): TIdC_INT;

  function ASN1_tag2bit(tag: TIdC_INT): TIdC_ULONG;

  (* SPECIALS *)
  function ASN1_get_object(const pp: PPByte; plength: PIdC_LONG; ptag: PIdC_INT; pclass: PIdC_INT; omax: TIdC_LONG): TIdC_INT;
  function ASN1_check_infinite_end(p: PPByte; len: TIdC_LONG): TIdC_INT;
  function ASN1_const_check_infinite_end(const p: PPByte; len: TIdC_LONG): TIdC_INT;
  procedure ASN1_put_object(pp: PPByte; constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT; xclass: TIdC_INT);
  function ASN1_put_eoc(pp: PPByte): TIdC_INT;
  function ASN1_object_size(constructed: TIdC_INT; length: TIdC_INT; tag: TIdC_INT): TIdC_INT;

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
  function ASN1_item_dup(const it: PASN1_ITEM; x: Pointer): Pointer;

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

  function ASN1_STRING_to_UTF8(&out: PPByte; const in_: PASN1_STRING): TIdC_INT;

  //void *ASN1_d2i_bio(void *(*xnew) (void), d2i_of_void *d2i, BIO *in, void **x);

  //#  define ASN1_d2i_bio_of(type,xnew,d2i,in,x) \
  //    ((type*)ASN1_d2i_bio( CHECKED_NEW_OF(type, xnew), \
  //                          CHECKED_D2I_OF(type, d2i), \
  //                          in, \
  //                          CHECKED_PPTR_OF(type, x)))

  function ASN1_item_d2i_bio(const it: PASN1_ITEM; in_: PBIO; x: Pointer): Pointer;
  function ASN1_i2d_bio(i2d: Pi2d_of_void; out_: PBIO; x: PByte): TIdC_INT;

  //#  define ASN1_i2d_bio_of(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(type, x)))
  //
  //#  define ASN1_i2d_bio_of_const(type,i2d,out,x) \
  //    (ASN1_i2d_bio(CHECKED_I2D_OF(const type, i2d), \
  //                  out, \
  //                  CHECKED_PTR_OF(const type, x)))

  function ASN1_item_i2d_bio(const it: PASN1_ITEM; out_: PBIO; x: Pointer): TIdC_INT;
  function ASN1_UTCTIME_print(fp: PBIO; const a: PASN1_UTCTIME): TIdC_INT;
  function ASN1_GENERALIZEDTIME_print(fp: PBIO; const a: PASN1_GENERALIZEDTIME): TIdC_INT;
  function ASN1_TIME_print(fp: PBIO; const a: PASN1_TIME): TIdC_INT;
  function ASN1_STRING_print(bp: PBIO; const v: PASN1_STRING): TIdC_INT;
  function ASN1_STRING_print_ex(&out: PBIO; const str: PASN1_STRING; flags: TIdC_ULONG): TIdC_INT;
  function ASN1_buf_print(bp: PBIO; const buf: PByte; buflen: TIdC_SIZET; off: TIdC_INT): TIdC_INT;
  function ASN1_bn_print(bp: PBIO; const number: PIdAnsiChar; const num: PBIGNUM; buf: PByte; off: TIdC_INT): TIdC_INT;
  function ASN1_parse(bp: PBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT): TIdC_INT;
  function ASN1_parse_dump(bp: PPBIO; const pp: PByte; len: TIdC_LONG; indent: TIdC_INT; dump: TIdC_INT): TIdC_INT;
  function ASN1_tag2str(tag: TIdC_INT): PIdAnsiChar;

  (* Used to load and write Netscape format cert *)

  function ASN1_UNIVERSALSTRING_to_string(s: PASN1_UNIVERSALSTRING): TIdC_INT;

  function ASN1_TYPE_set_octetstring(a: PASN1_TYPE; data: PByte; len: TIdC_INT): TIdC_INT;
  function ASN1_TYPE_get_octetstring(const a: PASN1_TYPE; data: PByte; max_len: TIdC_INT): TIdC_INT;
  function ASN1_TYPE_set_int_octetstring(a: PASN1_TYPE; num: TIdC_LONG; data: PByte; len: TIdC_INT): TIdC_INT;
  function ASN1_TYPE_get_int_octetstring(const a: PASN1_TYPE; num: PIdC_LONG; data: PByte; max_len: TIdC_INT): TIdC_INT;

  function ASN1_item_unpack(const oct: PASN1_STRING; const it: PASN1_ITEM): Pointer;

  function ASN1_item_pack(obj: Pointer; const it: PASN1_ITEM; oct: PPASN1_OCTET_STRING): PASN1_STRING;

  procedure ASN1_STRING_set_default_mask(mask: TIdC_ULONG);
  function ASN1_STRING_set_default_mask_asc(const p: PAnsiChar): TIdC_INT;
  function ASN1_STRING_get_default_mask: TIdC_ULONG;
  function ASN1_mbstring_copy(&out: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG): TIdC_INT;
  function ASN1_mbstring_ncopy(&out: PPASN1_STRING; const in_: PByte; len: TIdC_INT; inform: TIdC_INT; mask: TIdC_ULONG; minsize: TIdC_LONG; maxsize: TIdC_LONG): TIdC_INT;

  function ASN1_STRING_set_by_NID(&out: PPASN1_STRING; const in_: PByte; inlen: TIdC_INT; inform: TIdC_INT; nid: TIdC_INT): PASN1_STRING;
  function ASN1_STRING_TABLE_get(nid: TIdC_INT): PASN1_STRING_TABLE;
  function ASN1_STRING_TABLE_add(v1: TIdC_INT; v2: TIdC_LONG; v3: TIdC_LONG; v4: TIdC_ULONG; v5: TIdC_ULONG): TIdC_INT;
  procedure ASN1_STRING_TABLE_cleanup;

  (* ASN1 template functions *)

  (* Old API compatible functions *)
  function ASN1_item_new(const it: PASN1_ITEM): PASN1_VALUE;
  procedure ASN1_item_free(val: PASN1_VALUE; const it: PASN1_ITEM);
  function ASN1_item_d2i(val: PPASN1_VALUE; const in_: PPByte; len: TIdC_LONG; const it: PASN1_ITEM): PASN1_VALUE;
  function ASN1_item_i2d(val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT;
  function ASN1_item_ndef_i2d(val: PASN1_VALUE; out_: PPByte; const it: PASN1_ITEM): TIdC_INT;

  procedure ASN1_add_oid_module;
  procedure ASN1_add_stable_module;

  function ASN1_generate_nconf(const str: PAnsiChar; nconf: PCONF): PASN1_TYPE;
  function ASN1_generate_v3(const str: PAnsiChar; cnf: PX509V3_CTX): PASN1_TYPE;
  function ASN1_str2mask(const str: PByte; pmask: PIdC_ULONG): TIdC_INT;

  function ASN1_item_print(&out: PBIO; ifld: PASN1_VALUE; indent: TIdC_INT; const it: PASN1_ITEM; const pctx: PASN1_PCTX): TIdC_INT;
  function ASN1_PCTX_new: PASN1_PCTX;
  procedure ASN1_PCTX_free(p: PASN1_PCTX);
  function ASN1_PCTX_get_flags(const p: PASN1_PCTX): TIdC_ULONG;
  procedure ASN1_PCTX_set_flags(p: PASN1_PCTX; flags: TIdC_ULONG);
  function ASN1_PCTX_get_nm_flags(const p: PASN1_PCTX): TIdC_ULONG;
  procedure ASN1_PCTX_set_nm_flags(p: PASN1_PCTX; flags: TIdC_ULONG);
  function ASN1_PCTX_get_cert_flags(const p: PASN1_PCTX): TIdC_ULONG;
  procedure ASN1_PCTX_set_cert_flags(p: PASN1_PCTX; flags: TIdC_ULONG);
  function ASN1_PCTX_get_oid_flags(const p: PASN1_PCTX): TIdC_ULONG;
  procedure ASN1_PCTX_set_oid_flags(p: PASN1_PCTX; flags: TIdC_ULONG);
  function ASN1_PCTX_get_str_flags(const p: PASN1_PCTX): TIdC_ULONG;
  procedure ASN1_PCTX_set_str_flags(p: PASN1_PCTX; flags: TIdC_ULONG);

  //ASN1_SCTX *ASN1_SCTX_new(int (*scan_cb) (ASN1_SCTX *ctx));
  procedure ASN1_SCTX_free(p: PASN1_SCTX);
  function ASN1_SCTX_get_item(p: PASN1_SCTX): PASN1_ITEM;
  function ASN1_SCTX_get_template(p: PASN1_SCTX): PASN1_TEMPLATE;
  function ASN1_SCTX_get_flags(p: PASN1_SCTX): TIdC_ULONG;
  procedure ASN1_SCTX_set_app_data(p: PASN1_SCTX; data: Pointer);
  function ASN1_SCTX_get_app_data(p: PASN1_SCTX): Pointer;

  function BIO_f_asn1: PBIO_METHOD;

  function BIO_new_NDEF(&out: PBIO; val: PASN1_VALUE; const it: PASN1_ITEM): PBIO;

  function i2d_ASN1_bio_stream(&out: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const it: PASN1_ITEM): TIdC_INT;
  function PEM_write_bio_ASN1_stream(&out: PBIO; val: PASN1_VALUE; in_: PBIO; flags: TIdC_INT; const hdr: PAnsiChar; const it: PASN1_ITEM): TIdC_INT;
  //function SMIME_write_ASN1(bio: PBIO; val: PASN1_VALUE; data: PBIO; flags: TIdC_INT;
  //                     ctype_nid: TIdC_INT; econt_nid: TIdC_INT;
  //                     STACK_OF(X509_ALGOR) *mdalgs, const ASN1_ITEM *it): TIdC_INT;
  function SMIME_read_ASN1(bio: PBIO; bcont: PPBIO; const it: PASN1_ITEM): PASN1_VALUE;
  function SMIME_crlf_copy(&in: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT;
  function SMIME_text(&in: PBIO; out_: PBIO): TIdC_INT;

  function ASN1_ITEM_lookup(const name: PIdAnsiChar): PASN1_ITEM;
  function ASN1_ITEM_get(i: TIdC_SIZET): PASN1_ITEM;

implementation

end.
