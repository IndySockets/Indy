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

unit IdOpenSSLHeaders_err;

interface

// Headers for OpenSSL 1.1.1
// err.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
// DEFINE_LHASH_OF(ERR_STRING_DATA);

  ERR_put_error: procedure(lib: TIdC_INT; func: TIdC_INT; reason: TIdC_INT; file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  ERR_set_error_data: procedure(data: PIdAnsiChar; flags: TIdC_INT) cdecl = nil;
  
  ERR_get_error: function: TIdC_ULONG cdecl = nil;
  ERR_get_error_line: function(&file: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl = nil;
  ERR_get_error_line_data: function(&file: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl = nil;

  ERR_peek_error: function: TIdC_ULONG cdecl = nil;
  ERR_peek_error_line: function(&file: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl = nil;
  ERR_peek_error_line_data: function(&file: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl = nil;

  ERR_peek_last_error: function: TIdC_ULONG cdecl = nil;
  ERR_peek_last_error_line: function(&file: PPIdAnsiChar; line: PIdC_INT): TIdC_ULONG cdecl = nil;
  ERR_peek_last_error_line_data: function(&file: PPIdAnsiChar; line: PIdC_INT; data: PPIdAnsiChar; flags: PIdC_INT): TIdC_ULONG cdecl = nil;

  ERR_clear_error: procedure cdecl = nil;
  ERR_error_string: function(e: TIdC_ULONG; buf: PIdAnsiChar): PIdAnsiChar cdecl = nil;
  ERR_error_string_n: procedure(e: TIdC_ULONG; buf: PIdAnsiChar; len: TIdC_SIZET) cdecl = nil;
  ERR_lib_error_string: function(e: TIdC_ULONG): PIdAnsiChar cdecl = nil;
  ERR_func_error_string: function(e: TIdC_ULONG): PIdAnsiChar cdecl = nil;
  ERR_reason_error_string: function(e: TIdC_ULONG): PIdAnsiChar cdecl = nil;
  ERR_print_errors_cb: procedure(cb: ERR_print_errors_cb_cb; u: Pointer) cdecl = nil;

  ERR_print_errors: procedure(bp: PBIO) cdecl = nil;
  // void ERR_add_error_data(int num, ...);
  // procedure ERR_add_error_vdata(num: TIdC_INT; args: va_list);
  ERR_load_strings: function(lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT cdecl = nil;
  ERR_load_strings_const: function(str: PERR_STRING_DATA): TIdC_INT cdecl = nil;
  ERR_unload_strings: function(lib: TIdC_INT; str: PERR_STRING_DATA): TIdC_INT cdecl = nil;
  ERR_load_ERR_strings: function: TIdC_INT cdecl = nil;

  ERR_get_state: function: PERR_STATE cdecl = nil;
  ERR_get_next_error_library: function: TIdC_INT cdecl = nil;
  ERR_set_mark: function: TIdC_INT cdecl = nil;
  ERR_pop_to_mark: function: TIdC_INT cdecl = nil;
  ERR_clear_last_mark: function: TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ERR_put_error := LoadFunction('ERR_put_error', AFailed);
  ERR_set_error_data := LoadFunction('ERR_set_error_data', AFailed);
  ERR_get_error := LoadFunction('ERR_get_error', AFailed);
  ERR_get_error_line := LoadFunction('ERR_get_error_line', AFailed);
  ERR_get_error_line_data := LoadFunction('ERR_get_error_line_data', AFailed);
  ERR_peek_error := LoadFunction('ERR_peek_error', AFailed);
  ERR_peek_error_line := LoadFunction('ERR_peek_error_line', AFailed);
  ERR_peek_error_line_data := LoadFunction('ERR_peek_error_line_data', AFailed);
  ERR_peek_last_error := LoadFunction('ERR_peek_last_error', AFailed);
  ERR_peek_last_error_line := LoadFunction('ERR_peek_last_error_line', AFailed);
  ERR_peek_last_error_line_data := LoadFunction('ERR_peek_last_error_line_data', AFailed);
  ERR_clear_error := LoadFunction('ERR_clear_error', AFailed);
  ERR_error_string := LoadFunction('ERR_error_string', AFailed);
  ERR_error_string_n := LoadFunction('ERR_error_string_n', AFailed);
  ERR_lib_error_string := LoadFunction('ERR_lib_error_string', AFailed);
  ERR_func_error_string := LoadFunction('ERR_func_error_string', AFailed);
  ERR_reason_error_string := LoadFunction('ERR_reason_error_string', AFailed);
  ERR_print_errors_cb := LoadFunction('ERR_print_errors_cb', AFailed);
  ERR_print_errors := LoadFunction('ERR_print_errors', AFailed);
  ERR_load_strings := LoadFunction('ERR_load_strings', AFailed);
  ERR_load_strings_const := LoadFunction('ERR_load_strings_const', AFailed);
  ERR_unload_strings := LoadFunction('ERR_unload_strings', AFailed);
  ERR_load_ERR_strings := LoadFunction('ERR_load_ERR_strings', AFailed);
  ERR_get_state := LoadFunction('ERR_get_state', AFailed);
  ERR_get_next_error_library := LoadFunction('ERR_get_next_error_library', AFailed);
  ERR_set_mark := LoadFunction('ERR_set_mark', AFailed);
  ERR_pop_to_mark := LoadFunction('ERR_pop_to_mark', AFailed);
  ERR_clear_last_mark := LoadFunction('ERR_clear_last_mark', AFailed);
end;

procedure UnLoad;
begin
  ERR_put_error := nil;
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
  ERR_load_strings_const := nil;
  ERR_unload_strings := nil;
  ERR_load_ERR_strings := nil;
  ERR_get_state := nil;
  ERR_get_next_error_library := nil;
  ERR_set_mark := nil;
  ERR_pop_to_mark := nil;
  ERR_clear_last_mark := nil;
end;

end.
