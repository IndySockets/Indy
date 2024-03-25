  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_err.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_err.h2pas
     and this file regenerated. IdOpenSSLHeaders_err.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_err;

interface

// Headers for OpenSSL 1.1.1
// err.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  ERR_TXT_MALLOCED = $01;
  ERR_TXT_STRING = $02;
  ERR_FLAG_MARK = $01;
  ERR_FLAG_CLEAR = $02;

  ERR_NUM_ERRORS = 16;

//* library */
  ERR_LIB_SYS =    2;
  ERR_LIB_BN =    3;
  ERR_LIB_RSA =    4;
  ERR_LIB_DH =    5;
  ERR_LIB_EVP =    6;
  ERR_LIB_BUF =    7;
  ERR_LIB_OBJ =    8;
  ERR_LIB_PEM =    9;
  ERR_LIB_DSA =    10;
  ERR_LIB_X509 =    11;
  // ERR_LIB_METH         12
  ERR_LIB_ASN1 =    13;
  ERR_LIB_CONF =    14;
  ERR_LIB_CRYPTO =   15;
  ERR_LIB_EC =    16;
  ERR_LIB_SSL =    20;
(* #define ERR_LIB_SSL23        21 *)
(* #define ERR_LIB_SSL2         22 *)
(* #define ERR_LIB_SSL3         23 *)
(* #define ERR_LIB_RSAREF       30 *)
(* #define ERR_LIB_PROXY        31 *)
  ERR_LIB_BIO =    32;
  ERR_LIB_PKCS7 =    33;
  ERR_LIB_X509V3 =   34;
  ERR_LIB_PKCS12 =   35;
  ERR_LIB_RAND =    36;
  ERR_LIB_DSO =    37;
  ERR_LIB_ENGINE =   38;
  ERR_LIB_OCSP =    39;
  ERR_LIB_UI =    40;
  ERR_LIB_COMP =    41;
  ERR_LIB_ECDSA =    42;
  ERR_LIB_ECDH =    43;
  ERR_LIB_OSSL_STORE =  44;
  ERR_LIB_FIPS =    45;
  ERR_LIB_CMS =    46;
  ERR_LIB_TS =    47;
  ERR_LIB_HMAC =    48;
(* # define ERR_LIB_JPAKE       49 *)
  ERR_LIB_CT =    50;
  ERR_LIB_ASYNC =    51;
  ERR_LIB_KDF =    52;
  ERR_LIB_SM2 =    53;
  ERR_LIB_USER =    128;

//* OS functions */
  SYS_F_FOPEN = 1;
  SYS_F_CONNECT = 2;
  SYS_F_GETSERVBYNAME = 3;
  SYS_F_SOCKET = 4;
  SYS_F_IOCTLSOCKET = 5;
  SYS_F_BIND = 6;
  SYS_F_LISTEN = 7;
  SYS_F_ACCEPT = 8;
  SYS_F_WSASTARTUP = 9; (* Winsock stuff *)
  SYS_F_OPENDIR = 10;
  SYS_F_FREAD = 11;
  SYS_F_GETADDRINFO = 12;
  SYS_F_GETNAMEINFO = 13;
  SYS_F_SETSOCKOPT = 14;
  SYS_F_GETSOCKOPT = 15;
  SYS_F_GETSOCKNAME = 16;
  SYS_F_GETHOSTBYNAME = 17;
  SYS_F_FFLUSH = 18;
  SYS_F_OPEN = 19;
  SYS_F_CLOSE = 20;
  SYS_F_IOCTL = 21;
  SYS_F_STAT = 22;
  SYS_F_FCNTL = 23;
  SYS_F_FSTAT = 24;

//* reasons */
  ERR_R_SYS_LIB = ERR_LIB_SYS; //2
  ERR_R_BN_LIB = ERR_LIB_BN; //3
  ERR_R_RSA_LIB = ERR_LIB_RSA; //4
  ERR_R_DH_LIB = ERR_LIB_DH; //5
  ERR_R_EVP_LIB = ERR_LIB_EVP; //6
  ERR_R_BUF_LIB = ERR_LIB_BUF; //7
  ERR_R_OBJ_LIB = ERR_LIB_OBJ; //8
  ERR_R_PEM_LIB = ERR_LIB_PEM; //9
  ERR_R_DSA_LIB = ERR_LIB_DSA; //10
  ERR_R_X509_LIB = ERR_LIB_X509; //11
  ERR_R_ASN1_LIB = ERR_LIB_ASN1; //13
  ERR_R_EC_LIB = ERR_LIB_EC; //16
  ERR_R_BIO_LIB = ERR_LIB_BIO; //32
  ERR_R_PKCS7_LIB = ERR_LIB_PKCS7; //33
  ERR_R_X509V3_LIB = ERR_LIB_X509V3; //34
  ERR_R_ENGINE_LIB = ERR_LIB_ENGINE; //38
  ERR_R_UI_LIB = ERR_LIB_UI; //40
  ERR_R_ECDSA_LIB = ERR_LIB_ECDSA; //42
  ERR_R_OSSL_STORE_LIB = ERR_LIB_OSSL_STORE; //44

  ERR_R_NESTED_ASN1_ERROR =  58;
  ERR_R_MISSING_ASN1_EOS =  63;

  //* fatal error */
  ERR_R_FATAL =  64;
  ERR_R_MALLOC_FAILURE = (1 or ERR_R_FATAL);
  ERR_R_SHOULD_NOT_HAVE_BEEN_CALLED = (2 or ERR_R_FATAL);
  ERR_R_PASSED_NULL_PARAMETER = (3 or ERR_R_FATAL);
  ERR_R_INTERNAL_ERROR = (4 or ERR_R_FATAL);
  ERR_R_DISABLED = (5 or ERR_R_FATAL);
  ERR_R_INIT_FAIL = (6 or ERR_R_FATAL);
  ERR_R_PASSED_INVALID_ARGUMENT = (7);
  ERR_R_OPERATION_FAIL = (8 or ERR_R_FATAL);
  ERR_R_PKCS12_LIB = ERR_LIB_PKCS12;


(*
 * 99 is the maximum possible ERR_R_... code, higher values are reserved for
 * the individual libraries
 *)

type
  err_state_st = record
    err_flags: array[0..ERR_NUM_ERRORS -1] of TIdC_INT;
    err_buffer: array[0..ERR_NUM_ERRORS -1] of TIdC_ULONG;
    err_data: array[0..ERR_NUM_ERRORS -1] of PIdAnsiChar;
    err_data_flags: array[0..ERR_NUM_ERRORS -1] of TIdC_INT;
    err_file: array[0..ERR_NUM_ERRORS -1] of PIdAnsiChar;
    err_line: array[0..ERR_NUM_ERRORS -1] of TIdC_INT;
    top, bottom: TIdC_INT;
  end;
  ERR_STATE = err_state_st;
  PERR_STATE = ^ERR_STATE;

  ERR_string_data_st = record
    error: TIdC_ULONG;
    string_: PIdAnsiChar;
  end;
  ERR_STRING_DATA = ERR_string_data_st;
  PERR_STRING_DATA = ^ERR_STRING_DATA;

  ERR_print_errors_cb_cb = function(str: PIdAnsiChar; len: TIdC_SIZET; u: Pointer): TIdC_INT; cdecl;

// DEFINE_LHASH_OF(ERR_STRING_DATA);

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_new} {introduced 3.0.0}
  {$EXTERNALSYM ERR_set_debug}  {introduced 3.0.0}
  {$EXTERNALSYM ERR_set_error} {introduced 3.0.0}
  {$EXTERNALSYM ERR_set_error_data}
  {$EXTERNALSYM ERR_get_error}
  {$EXTERNALSYM ERR_get_error_line}
  {$EXTERNALSYM ERR_get_error_line_data}
  {$EXTERNALSYM ERR_peek_error}
  {$EXTERNALSYM ERR_peek_error_line}
  {$EXTERNALSYM ERR_peek_error_line_data}
  {$EXTERNALSYM ERR_peek_last_error}
  {$EXTERNALSYM ERR_peek_last_error_line}
  {$EXTERNALSYM ERR_peek_last_error_line_data}
  {$EXTERNALSYM ERR_clear_error}
  {$EXTERNALSYM ERR_error_string}
  {$EXTERNALSYM ERR_error_string_n}
  {$EXTERNALSYM ERR_lib_error_string}
  {$EXTERNALSYM ERR_func_error_string}
  {$EXTERNALSYM ERR_reason_error_string}
  {$EXTERNALSYM ERR_print_errors_cb}
  {$EXTERNALSYM ERR_print_errors}
  {$EXTERNALSYM ERR_load_strings}
  {$EXTERNALSYM ERR_load_strings_const} {introduced 1.1.0}
  {$EXTERNALSYM ERR_unload_strings}
  {$EXTERNALSYM ERR_load_ERR_strings}
  {$EXTERNALSYM ERR_get_state}
  {$EXTERNALSYM ERR_get_next_error_library}
  {$EXTERNALSYM ERR_set_mark}
  {$EXTERNALSYM ERR_pop_to_mark}
  {$EXTERNALSYM ERR_clear_last_mark} {introduced 1.1.0}
{helper_functions}
function ERR_GET_LIB(l: TIdC_INT): TIdC_ULONG;
{\helper_functions}


{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM ERR_put_error} {removed 3.0.0}
  {$EXTERNALSYM SSLErr} {removed 1.0.0}
  {$EXTERNALSYM X509err} {removed 1.0.0}
  {$EXTERNALSYM ERR_GET_REASON} {removed 1.0.0}
  ERR_put_error: procedure (lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT); cdecl = nil; {removed 3.0.0}

{ From 3.0 onwards, replaced by a macro
  define ERR_put_error(lib, func, reason, file, line)
    (ERR_new(),
     ERR_set_debug((file), (line), OPENSSL_FUNC),
     ERR_set_error((lib), (reason), NULL))}

  ERR_new: procedure ; cdecl = nil; {introduced 3.0.0}
  ERR_set_debug: procedure (const file_: PIdAnsiChar; line: integer; const func: PIdAnsiChar); cdecl = nil;  {introduced 3.0.0}
  ERR_set_error: procedure (lib: integer; reason: integer; fmt: PIdAnsiChar; args: array of const); cdecl = nil; {introduced 3.0.0}


  ERR_set_error_data: procedure (data: PIdAnsiChar; flags: TIdC_INT); cdecl = nil;
  
  ERR_get_error: function : TIdC_ULONG; cdecl = nil;
  ERR_get_error_line: function (file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG; cdecl = nil;
  ERR_get_error_line_data: function (file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG; cdecl = nil;

  ERR_peek_error: function : TIdC_ULONG; cdecl = nil;
  ERR_peek_error_line: function (file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG; cdecl = nil;
  ERR_peek_error_line_data: function (file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG; cdecl = nil;

  ERR_peek_last_error: function : TIdC_ULONG; cdecl = nil;
  ERR_peek_last_error_line: function (file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG; cdecl = nil;
  ERR_peek_last_error_line_data: function (file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG; cdecl = nil;

  ERR_clear_error: procedure ; cdecl = nil;
  ERR_error_string: function (e: TIdC_ULONG; buf: PIdAnsiChar): PIdAnsiChar; cdecl = nil;
  ERR_error_string_n: procedure (e: TIdC_ULONG; buf: PIdAnsiChar; len: TIdC_SIZET); cdecl = nil;
  ERR_lib_error_string: function (e: TIdC_ULONG): PIdAnsiChar; cdecl = nil;
  ERR_func_error_string: function (e: TIdC_ULONG): PIdAnsiChar; cdecl = nil;
  ERR_reason_error_string: function (e: TIdC_ULONG): PIdAnsiChar; cdecl = nil;
  ERR_print_errors_cb: procedure (cb: ERR_print_errors_cb_cb; u: Pointer); cdecl = nil;

  ERR_print_errors: procedure (bp: PBIO); cdecl = nil;
  // void ERR_add_error_data(int num, ...);
  // procedure ERR_add_error_vdata(num: TIdC_INT; args: va_list);
  ERR_load_strings: function (lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT; cdecl = nil;
  ERR_load_strings_const: function (str: PERR_STRING_DATA): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  ERR_unload_strings: function (lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT; cdecl = nil;
  ERR_load_ERR_strings: function : TIdC_INT; cdecl = nil;

  ERR_get_state: function : PERR_STATE; cdecl = nil;
  ERR_get_next_error_library: function : TIdC_INT; cdecl = nil;
  ERR_set_mark: function : TIdC_INT; cdecl = nil;
  ERR_pop_to_mark: function : TIdC_INT; cdecl = nil;
  ERR_clear_last_mark: function : TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSLErr: procedure (func: TIdC_INT; reason: TIdC_INT); cdecl = nil; {removed 1.0.0}
  X509err: procedure (const f,r : TIdC_INT); cdecl = nil; {removed 1.0.0}
  ERR_GET_REASON: function (const l : TIdC_INT) : TIdC_INT; cdecl = nil; {removed 1.0.0}

{$ELSE}

{ From 3.0 onwards, replaced by a macro
  define ERR_put_error(lib, func, reason, file, line)
    (ERR_new(),
     ERR_set_debug((file), (line), OPENSSL_FUNC),
     ERR_set_error((lib), (reason), NULL))}

  procedure ERR_new cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}
  procedure ERR_set_debug(const file_: PIdAnsiChar; line: integer; const func: PIdAnsiChar) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};  {introduced 3.0.0}
  procedure ERR_set_error(lib: integer; reason: integer; fmt: PIdAnsiChar; args: array of const) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 3.0.0}


  procedure ERR_set_error_data(data: PIdAnsiChar; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  
  function ERR_get_error: TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_get_error_line(file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_get_error_line_data(file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function ERR_peek_error: TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_peek_error_line(file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_peek_error_line_data(file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function ERR_peek_last_error: TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_peek_last_error_line(file_: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_peek_last_error_line_data(file_: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure ERR_clear_error cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_error_string(e: TIdC_ULONG; buf: PIdAnsiChar): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure ERR_error_string_n(e: TIdC_ULONG; buf: PIdAnsiChar; len: TIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_lib_error_string(e: TIdC_ULONG): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_func_error_string(e: TIdC_ULONG): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_reason_error_string(e: TIdC_ULONG): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  procedure ERR_print_errors_cb(cb: ERR_print_errors_cb_cb; u: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  procedure ERR_print_errors(bp: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  // void ERR_add_error_data(int num, ...);
  // procedure ERR_add_error_vdata(num: TIdC_INT; args: va_list);
  function ERR_load_strings(lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_load_strings_const(str: PERR_STRING_DATA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}
  function ERR_unload_strings(lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_load_ERR_strings: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

  function ERR_get_state: PERR_STATE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_get_next_error_library: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_set_mark: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_pop_to_mark: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function ERR_clear_last_mark: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF}; {introduced 1.1.0}


  procedure ERR_put_error(lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT); {removed 3.0.0}
  procedure SSLErr(func: TIdC_INT; reason: TIdC_INT); {removed 1.0.0}
  procedure X509err(const f,r : TIdC_INT); {removed 1.0.0}
  function ERR_GET_REASON(const l : TIdC_INT) : TIdC_INT; {removed 1.0.0}
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
  ERR_new_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  ERR_set_debug_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  ERR_set_error_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  ERR_load_strings_const_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ERR_clear_last_mark_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  ERR_put_error_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  SSLErr_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  X509err_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  ERR_GET_REASON_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);

{helper_functions}
function ERR_GET_LIB(l: TIdC_INT): TIdC_ULONG;
begin
  Result := (l shr 24) and $ff;
end;
{\helper_functions}

{$IFNDEF USE_EXTERNAL_LIBRARY}

procedure  _SSLErr(func: TIdC_INT; reason: TIdC_INT); cdecl;
begin
  ERR_put_error(ERR_LIB_SSL,func,reason,'',0);
end; 

procedure  _ERR_put_error(lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT); cdecl;
{ From 3.0 onwards, replaced by a macro
  define ERR_put_error(lib, func, reason, file, line)
    (ERR_new(),
     ERR_set_debug((file), (line), OPENSSL_FUNC),
     ERR_set_error((lib), (reason), '',[]))}
begin
  ERR_new;
  ERR_set_debug(file_,line, '');
  ERR_set_error(lib,reason,'',[]);
end;

procedure  _X509err(const f,r : TIdC_INT); cdecl;
begin
  ERR_PUT_error(ERR_LIB_X509,f,r,nil,0);
end;

function  _ERR_GET_REASON(const l : TIdC_INT) : TIdC_INT; cdecl;
begin
  Result := l and $fff;
end;

{$WARN  NO_RETVAL OFF}
procedure  ERR_ERR_put_error(lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_put_error');
end;


procedure  ERR_ERR_new; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_new');
end;


procedure  ERR_ERR_set_debug(const file_: PIdAnsiChar; line: integer; const func: PIdAnsiChar); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_set_debug');
end;


procedure  ERR_ERR_set_error(lib: integer; reason: integer; fmt: PIdAnsiChar; args: array of const); 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_set_error');
end;


function  ERR_ERR_load_strings_const(str: PERR_STRING_DATA): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_load_strings_const');
end;


function  ERR_ERR_clear_last_mark: TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_clear_last_mark');
end;


procedure  ERR_SSLErr(func: TIdC_INT; reason: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSLErr');
end;


procedure  ERR_X509err(const f,r : TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509err');
end;


function  ERR_ERR_GET_REASON(const l : TIdC_INT) : TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('ERR_GET_REASON');
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
  ERR_set_error_data := LoadFunction('ERR_set_error_data',AFailed);
  ERR_get_error := LoadFunction('ERR_get_error',AFailed);
  ERR_get_error_line := LoadFunction('ERR_get_error_line',AFailed);
  ERR_get_error_line_data := LoadFunction('ERR_get_error_line_data',AFailed);
  ERR_peek_error := LoadFunction('ERR_peek_error',AFailed);
  ERR_peek_error_line := LoadFunction('ERR_peek_error_line',AFailed);
  ERR_peek_error_line_data := LoadFunction('ERR_peek_error_line_data',AFailed);
  ERR_peek_last_error := LoadFunction('ERR_peek_last_error',AFailed);
  ERR_peek_last_error_line := LoadFunction('ERR_peek_last_error_line',AFailed);
  ERR_peek_last_error_line_data := LoadFunction('ERR_peek_last_error_line_data',AFailed);
  ERR_clear_error := LoadFunction('ERR_clear_error',AFailed);
  ERR_error_string := LoadFunction('ERR_error_string',AFailed);
  ERR_error_string_n := LoadFunction('ERR_error_string_n',AFailed);
  ERR_lib_error_string := LoadFunction('ERR_lib_error_string',AFailed);
  ERR_func_error_string := LoadFunction('ERR_func_error_string',AFailed);
  ERR_reason_error_string := LoadFunction('ERR_reason_error_string',AFailed);
  ERR_print_errors_cb := LoadFunction('ERR_print_errors_cb',AFailed);
  ERR_print_errors := LoadFunction('ERR_print_errors',AFailed);
  ERR_load_strings := LoadFunction('ERR_load_strings',AFailed);
  ERR_unload_strings := LoadFunction('ERR_unload_strings',AFailed);
  ERR_load_ERR_strings := LoadFunction('ERR_load_ERR_strings',AFailed);
  ERR_get_state := LoadFunction('ERR_get_state',AFailed);
  ERR_get_next_error_library := LoadFunction('ERR_get_next_error_library',AFailed);
  ERR_set_mark := LoadFunction('ERR_set_mark',AFailed);
  ERR_pop_to_mark := LoadFunction('ERR_pop_to_mark',AFailed);
  ERR_put_error := LoadFunction('ERR_put_error',nil); {removed 3.0.0}
  ERR_new := LoadFunction('ERR_new',nil); {introduced 3.0.0}
  ERR_set_debug := LoadFunction('ERR_set_debug',nil);  {introduced 3.0.0}
  ERR_set_error := LoadFunction('ERR_set_error',nil); {introduced 3.0.0}
  ERR_load_strings_const := LoadFunction('ERR_load_strings_const',nil); {introduced 1.1.0}
  ERR_clear_last_mark := LoadFunction('ERR_clear_last_mark',nil); {introduced 1.1.0}
  SSLErr := LoadFunction('SSLErr',nil); {removed 1.0.0}
  X509err := LoadFunction('X509err',nil); {removed 1.0.0}
  ERR_GET_REASON := LoadFunction('ERR_GET_REASON',nil); {removed 1.0.0}
  if not assigned(ERR_put_error) then 
  begin
    {$if declared(ERR_put_error_introduced)}
    if LibVersion < ERR_put_error_introduced then
      {$if declared(FC_ERR_put_error)}
      ERR_put_error := @FC_ERR_put_error
      {$else}
      ERR_put_error := @ERR_ERR_put_error
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_put_error_removed)}
   if ERR_put_error_removed <= LibVersion then
     {$if declared(_ERR_put_error)}
     ERR_put_error := @_ERR_put_error
     {$else}
       {$IF declared(ERR_ERR_put_error)}
       ERR_put_error := @ERR_ERR_put_error
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_put_error) and Assigned(AFailed) then 
     AFailed.Add('ERR_put_error');
  end;


  if not assigned(ERR_new) then 
  begin
    {$if declared(ERR_new_introduced)}
    if LibVersion < ERR_new_introduced then
      {$if declared(FC_ERR_new)}
      ERR_new := @FC_ERR_new
      {$else}
      ERR_new := @ERR_ERR_new
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_new_removed)}
   if ERR_new_removed <= LibVersion then
     {$if declared(_ERR_new)}
     ERR_new := @_ERR_new
     {$else}
       {$IF declared(ERR_ERR_new)}
       ERR_new := @ERR_ERR_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_new) and Assigned(AFailed) then 
     AFailed.Add('ERR_new');
  end;


  if not assigned(ERR_set_debug) then 
  begin
    {$if declared(ERR_set_debug_introduced)}
    if LibVersion < ERR_set_debug_introduced then
      {$if declared(FC_ERR_set_debug)}
      ERR_set_debug := @FC_ERR_set_debug
      {$else}
      ERR_set_debug := @ERR_ERR_set_debug
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_set_debug_removed)}
   if ERR_set_debug_removed <= LibVersion then
     {$if declared(_ERR_set_debug)}
     ERR_set_debug := @_ERR_set_debug
     {$else}
       {$IF declared(ERR_ERR_set_debug)}
       ERR_set_debug := @ERR_ERR_set_debug
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_set_debug) and Assigned(AFailed) then 
     AFailed.Add('ERR_set_debug');
  end;


  if not assigned(ERR_set_error) then 
  begin
    {$if declared(ERR_set_error_introduced)}
    if LibVersion < ERR_set_error_introduced then
      {$if declared(FC_ERR_set_error)}
      ERR_set_error := @FC_ERR_set_error
      {$else}
      ERR_set_error := @ERR_ERR_set_error
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_set_error_removed)}
   if ERR_set_error_removed <= LibVersion then
     {$if declared(_ERR_set_error)}
     ERR_set_error := @_ERR_set_error
     {$else}
       {$IF declared(ERR_ERR_set_error)}
       ERR_set_error := @ERR_ERR_set_error
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_set_error) and Assigned(AFailed) then 
     AFailed.Add('ERR_set_error');
  end;


  if not assigned(ERR_load_strings_const) then 
  begin
    {$if declared(ERR_load_strings_const_introduced)}
    if LibVersion < ERR_load_strings_const_introduced then
      {$if declared(FC_ERR_load_strings_const)}
      ERR_load_strings_const := @FC_ERR_load_strings_const
      {$else}
      ERR_load_strings_const := @ERR_ERR_load_strings_const
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_load_strings_const_removed)}
   if ERR_load_strings_const_removed <= LibVersion then
     {$if declared(_ERR_load_strings_const)}
     ERR_load_strings_const := @_ERR_load_strings_const
     {$else}
       {$IF declared(ERR_ERR_load_strings_const)}
       ERR_load_strings_const := @ERR_ERR_load_strings_const
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_load_strings_const) and Assigned(AFailed) then 
     AFailed.Add('ERR_load_strings_const');
  end;


  if not assigned(ERR_clear_last_mark) then 
  begin
    {$if declared(ERR_clear_last_mark_introduced)}
    if LibVersion < ERR_clear_last_mark_introduced then
      {$if declared(FC_ERR_clear_last_mark)}
      ERR_clear_last_mark := @FC_ERR_clear_last_mark
      {$else}
      ERR_clear_last_mark := @ERR_ERR_clear_last_mark
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_clear_last_mark_removed)}
   if ERR_clear_last_mark_removed <= LibVersion then
     {$if declared(_ERR_clear_last_mark)}
     ERR_clear_last_mark := @_ERR_clear_last_mark
     {$else}
       {$IF declared(ERR_ERR_clear_last_mark)}
       ERR_clear_last_mark := @ERR_ERR_clear_last_mark
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_clear_last_mark) and Assigned(AFailed) then 
     AFailed.Add('ERR_clear_last_mark');
  end;


  if not assigned(SSLErr) then 
  begin
    {$if declared(SSLErr_introduced)}
    if LibVersion < SSLErr_introduced then
      {$if declared(FC_SSLErr)}
      SSLErr := @FC_SSLErr
      {$else}
      SSLErr := @ERR_SSLErr
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLErr_removed)}
   if SSLErr_removed <= LibVersion then
     {$if declared(_SSLErr)}
     SSLErr := @_SSLErr
     {$else}
       {$IF declared(ERR_SSLErr)}
       SSLErr := @ERR_SSLErr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLErr) and Assigned(AFailed) then 
     AFailed.Add('SSLErr');
  end;


  if not assigned(X509err) then 
  begin
    {$if declared(X509err_introduced)}
    if LibVersion < X509err_introduced then
      {$if declared(FC_X509err)}
      X509err := @FC_X509err
      {$else}
      X509err := @ERR_X509err
      {$ifend}
    else
    {$ifend}
   {$if declared(X509err_removed)}
   if X509err_removed <= LibVersion then
     {$if declared(_X509err)}
     X509err := @_X509err
     {$else}
       {$IF declared(ERR_X509err)}
       X509err := @ERR_X509err
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509err) and Assigned(AFailed) then 
     AFailed.Add('X509err');
  end;


  if not assigned(ERR_GET_REASON) then 
  begin
    {$if declared(ERR_GET_REASON_introduced)}
    if LibVersion < ERR_GET_REASON_introduced then
      {$if declared(FC_ERR_GET_REASON)}
      ERR_GET_REASON := @FC_ERR_GET_REASON
      {$else}
      ERR_GET_REASON := @ERR_ERR_GET_REASON
      {$ifend}
    else
    {$ifend}
   {$if declared(ERR_GET_REASON_removed)}
   if ERR_GET_REASON_removed <= LibVersion then
     {$if declared(_ERR_GET_REASON)}
     ERR_GET_REASON := @_ERR_GET_REASON
     {$else}
       {$IF declared(ERR_ERR_GET_REASON)}
       ERR_GET_REASON := @ERR_ERR_GET_REASON
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(ERR_GET_REASON) and Assigned(AFailed) then 
     AFailed.Add('ERR_GET_REASON');
  end;


end;

procedure Unload;
begin
  ERR_put_error := nil; {removed 3.0.0}
  ERR_new := nil; {introduced 3.0.0}
  ERR_set_debug := nil;  {introduced 3.0.0}
  ERR_set_error := nil; {introduced 3.0.0}
  ERR_set_error_data := nil;
  ERR_get_error := nil;
  ERR_get_error_line := nil;
  ERR_get_error_line_data := nil;
  ERR_peek_error := nil;
  ERR_peek_error_line := nil;
  ERR_peek_error_line_data := nil;
  ERR_peek_last_error := nil;
  ERR_peek_last_error_line := nil;
  ERR_peek_last_error_line_data := nil;
  ERR_clear_error := nil;
  ERR_error_string := nil;
  ERR_error_string_n := nil;
  ERR_lib_error_string := nil;
  ERR_func_error_string := nil;
  ERR_reason_error_string := nil;
  ERR_print_errors_cb := nil;
  ERR_print_errors := nil;
  ERR_load_strings := nil;
  ERR_load_strings_const := nil; {introduced 1.1.0}
  ERR_unload_strings := nil;
  ERR_load_ERR_strings := nil;
  ERR_get_state := nil;
  ERR_get_next_error_library := nil;
  ERR_set_mark := nil;
  ERR_pop_to_mark := nil;
  ERR_clear_last_mark := nil; {introduced 1.1.0}
  SSLErr := nil; {removed 1.0.0}
  X509err := nil; {removed 1.0.0}
  ERR_GET_REASON := nil; {removed 1.0.0}
end;
{$ELSE}
procedure SSLErr(func: TIdC_INT; reason: TIdC_INT);
begin
  ERR_put_error(ERR_LIB_SSL,func,reason,'',0);
end; 

procedure ERR_put_error(lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT);
{ From 3.0 onwards, replaced by a macro
  define ERR_put_error(lib, func, reason, file, line)
    (ERR_new(),
     ERR_set_debug((file), (line), OPENSSL_FUNC),
     ERR_set_error((lib), (reason), '',[]))}
begin
  ERR_new;
  ERR_set_debug(file_,line, '');
  ERR_set_error(lib,reason,'',[]);
end;

procedure X509err(const f,r : TIdC_INT);
begin
  ERR_PUT_error(ERR_LIB_X509,f,r,nil,0);
end;

function ERR_GET_REASON(const l : TIdC_INT) : TIdC_INT;
begin
  Result := l and $fff;
end;

{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
