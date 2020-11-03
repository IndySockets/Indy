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

// Generation date: 03.11.2020 09:35:30

unit IdOpenSSLHeaders_crypto;

interface

// Headers for OpenSSL 1.1.1
// crypto.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ,
  {$IFDEF VCL_XE3_OR_ABOVE}System.Types{$ELSE}Types{$ENDIF};

{$MINENUMSIZE 4}

const
  CRYPTO_MEM_CHECK_OFF = $0;   //* Control only */
  CRYPTO_MEM_CHECK_ON = $1;   //* Control and mode bit */
  CRYPTO_MEM_CHECK_ENABLE = $2;   //* Control and mode bit */
  CRYPTO_MEM_CHECK_DISABLE = $3;   //* Control only */

  CRYPTO_EX_INDEX_SSL = 0;
  CRYPTO_EX_INDEX_SSL_CTX = 1;
  CRYPTO_EX_INDEX_SSL_SESSION = 2;
  CRYPTO_EX_INDEX_X509 = 3;
  CRYPTO_EX_INDEX_X509_STORE = 4;
  CRYPTO_EX_INDEX_X509_STORE_CTX = 5;
  CRYPTO_EX_INDEX_DH = 6;
  CRYPTO_EX_INDEX_DSA = 7;
  CRYPTO_EX_INDEX_EC_KEY = 8;
  CRYPTO_EX_INDEX_RSA = 9;
  CRYPTO_EX_INDEX_ENGINE = 10;
  CRYPTO_EX_INDEX_UI = 11;
  CRYPTO_EX_INDEX_BIO = 12;
  CRYPTO_EX_INDEX_APP = 13;
  CRYPTO_EX_INDEX_UI_METHOD = 14;
  CRYPTO_EX_INDEX_DRBG = 15;
  CRYPTO_EX_INDEX__COUNT = 16;
  
  // Added _CONST to prevent nameclashes
  OPENSSL_VERSION_CONST = 0;
  OPENSSL_CFLAGS = 1;
  OPENSSL_BUILT_ON = 2;
  OPENSSL_PLATFORM = 3;
  OPENSSL_DIR = 4;
  OPENSSL_ENGINES_DIR = 5;

  (*
   * These defines where used in combination with the old locking callbacks,
   * they are not called anymore, but old code that's not called might still
   * use them.
   *)
  CRYPTO_LOCK = 1;
  CRYPTO_UNLOCK = 2;
  CRYPTO_READ = 4;
  CRYPTO_WRITE = 8;

  (* Standard initialisation options *)
  OPENSSL_INIT_NO_LOAD_CRYPTO_STRINGS = TIdC_Long($00000001);
  OPENSSL_INIT_LOAD_CRYPTO_STRINGS = TIdC_Long($00000002);
  OPENSSL_INIT_ADD_ALL_CIPHERS = TIdC_Long($00000004);
  OPENSSL_INIT_ADD_ALL_DIGESTS = TIdC_Long($00000008);
  OPENSSL_INIT_NO_ADD_ALL_CIPHERS = TIdC_Long($00000010);
  OPENSSL_INIT_NO_ADD_ALL_DIGESTS = TIdC_Long($00000020);
  OPENSSL_INIT_LOAD_CONFIG = TIdC_Long($00000040);
  OPENSSL_INIT_NO_LOAD_CONFIG = TIdC_Long($00000080);
  OPENSSL_INIT_ASYNC = TIdC_Long($00000100);
  OPENSSL_INIT_ENGINE_RDRAND = TIdC_Long($00000200);
  OPENSSL_INIT_ENGINE_DYNAMIC = TIdC_Long($00000400);
  OPENSSL_INIT_ENGINE_OPENSSL = TIdC_Long($00000800);
  OPENSSL_INIT_ENGINE_CRYPTODEV = TIdC_Long($00001000);
  OPENSSL_INIT_ENGINE_CAPI = TIdC_Long($00002000);
  OPENSSL_INIT_ENGINE_PADLOCK = TIdC_Long($00004000);
  OPENSSL_INIT_ENGINE_AFALG = TIdC_Long($00008000);
  (* OPENSSL_INIT_ZLIB = TIdC_Long($00010000); *)
  OPENSSL_INIT_ATFORK = TIdC_Long(00020000);
  (* OPENSSL_INIT_BASE_ONLY = TIdC_Long(00040000); *)
  OPENSSL_INIT_NO_ATEXIT = TIdC_Long(00080000);
  (* OPENSSL_INIT flag range 0xfff00000 reserved for OPENSSL_init_ssl() *)
  (* Max OPENSSL_INIT flag value is 0x80000000 *)

  (* openssl and dasync not counted as builtin *)
  OPENSSL_INIT_ENGINE_ALL_BUILTIN = OPENSSL_INIT_ENGINE_RDRAND
    or OPENSSL_INIT_ENGINE_DYNAMIC or OPENSSL_INIT_ENGINE_CRYPTODEV
    or OPENSSL_INIT_ENGINE_CAPI or OPENSSL_INIT_ENGINE_PADLOCK;

  CRYPTO_ONCE_STATIC_INIT = 0;

type
  CRYPTO_RWLOCK = type Pointer;
  PCRYPTO_RWLOCK = ^CRYPTO_RWLOCK;
  //crypto_ex_data_st = record
  //  sk: PStackOfVoid;
  //end;
  //DEFINE_STACK_OF(void)

  // CRYPTO_EX_new = procedure(parent: Pointer; ptr: Pointer; CRYPTO_EX_DATA *ad; idx: TIdC_INT; argl: TIdC_LONG; argp: Pointer);
  //  CRYPTO_EX_free = procedure(void *parent, void *ptr, CRYPTO_EX_DATA *ad,
  //                             int idx, long argl, void *argp);
  //typedef int CRYPTO_EX_dup (CRYPTO_EX_DATA *to, const CRYPTO_EX_DATA *from,
  //                           void *from_d, int idx, long argl, void *argp);
  //__owur int CRYPTO_get_ex_new_index(int class_index, long argl, void *argp,
  //                            CRYPTO_EX_new *new_func, CRYPTO_EX_dup *dup_func,
  //                            CRYPTO_EX_free *free_func);

  CRYPTO_mem_leaks_cb_cb = function(const str: PIdAnsiChar; len: TIdC_SIZET; u: Pointer): TIdC_INT; cdecl;
  CRYPTO_THREAD_run_once_init = procedure; cdecl;

  CRYPTO_THREAD_LOCAL = type DWORD;
  PCRYPTO_THREAD_LOCAL = ^CRYPTO_THREAD_LOCAL;
  CRYPTO_THREAD_ID = type DWORD;
  CRYPTO_ONCE = type TIdC_LONG;
  PCRYPTO_ONCE = ^CRYPTO_ONCE;

  CRYPTO_set_mem_functions_m = function(size: TIdC_SIZET; const filename: PIdAnsiChar; linenumber: TIdC_INT): Pointer; cdecl;
  CRYPTO_set_mem_functions_r = function(buffer: Pointer; size: TIdC_SIZET; const filename: PIdAnsiChar; linenumber: TIdC_INT): Pointer; cdecl;
  CRYPTO_set_mem_functions_f = procedure(buffer: Pointer; const filename: PIdAnsiChar; const linenumber: TIdC_INT); cdecl;

function OPENSSL_malloc(num: TIdC_SIZET): Pointer;
function OPENSSL_zalloc(num: TIdC_SIZET): Pointer;
function OPENSSL_realloc(addr: Pointer; num: TIdC_SIZET): Pointer;
function OPENSSL_clear_realloc(addr: Pointer; old_num: TIdC_SIZET; num: TIdC_SIZET): Pointer;
procedure OPENSSL_clear_free(addr: Pointer; num: TIdC_SIZET);
procedure OPENSSL_free(addr: Pointer);
function OPENSSL_memdup(const str: Pointer; s: TIdC_SIZET): Pointer;
function OPENSSL_strdup(const str: PIdAnsiChar): PIdAnsiChar;
function OPENSSL_strndup(const str: PIdAnsiChar; n: TIdC_SIZET): PIdAnsiChar;
function OPENSSL_secure_malloc(num: TIdC_SIZET): Pointer;
function OPENSSL_secure_zalloc(num: TIdC_SIZET): Pointer;
procedure OPENSSL_secure_free(addr: Pointer);
procedure OPENSSL_secure_clear_free(addr: Pointer; num: TIdC_SIZET);
function OPENSSL_secure_actual_size(ptr: Pointer): TIdC_SIZET;

  function CRYPTO_THREAD_lock_new: PCRYPTO_RWLOCK cdecl; external CLibCrypto;
  function CRYPTO_THREAD_read_lock(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_THREAD_write_lock(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_THREAD_unlock(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl; external CLibCrypto;
  procedure CRYPTO_THREAD_lock_free(lock: PCRYPTO_RWLOCK) cdecl; external CLibCrypto;

  function CRYPTO_atomic_add(val: PIdC_INT; amount: TIdC_INT; ret: PIdC_INT; lock: PCRYPTO_RWLOCK): TIdC_INT cdecl; external CLibCrypto;

  function CRYPTO_mem_ctrl(mode: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function OPENSSL_strlcpy(dst: PIdAnsiChar; const src: PIdAnsiChar; siz: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;
  function OPENSSL_strlcat(dst: PIdAnsiChar; const src: PIdAnsiChar; siz: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;
  function OPENSSL_strnlen(const str: PIdAnsiChar; maxlen: TIdC_SIZET): TIdC_SIZET cdecl; external CLibCrypto;
  function OPENSSL_buf2hexstr(const buffer: PByte; len: TIdC_LONG): PIdAnsiChar cdecl; external CLibCrypto;
  function OPENSSL_hexstr2buf(const str: PIdAnsiChar; len: PIdC_LONG): PByte cdecl; external CLibCrypto;
  function OPENSSL_hexchar2int(c: Byte): TIdC_INT cdecl; external CLibCrypto;

  // # define OPENSSL_MALLOC_MAX_NELEMS(type)  (((1U<<(sizeof(int)*8-1))-1)/sizeof(type))

  function OpenSSL_version_num: TIdC_ULONG cdecl; external CLibCrypto;
  function OpenSSL_version(&type: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;

  function OPENSSL_issetugid: TIdC_INT cdecl; external CLibCrypto;

  (* No longer use an index. *)
  //function CRYPTO_free_ex_index(class_index: TIdC_INT; idx: TIdC_INT): TIdC_INT;

  (*
   * Initialise/duplicate/free CRYPTO_EX_DATA variables corresponding to a
   * given class (invokes whatever per-class callbacks are applicable)
   *)
  function CRYPTO_new_ex_data(class_index: TIdC_INT; obj: Pointer; ad: PCRYPTO_EX_DATA): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_dup_ex_data(class_index: TIdC_INT; to_: PCRYPTO_EX_DATA; const from: PCRYPTO_EX_DATA): TIdC_INT cdecl; external CLibCrypto;

  procedure CRYPTO_free_ex_data(class_index: TIdC_INT; obj: Pointer; ad: PCRYPTO_EX_DATA) cdecl; external CLibCrypto;

  (*
   * Get/set data in a CRYPTO_EX_DATA variable corresponding to a particular
   * index (relative to the class type involved)
   *)
  function CRYPTO_set_ex_data(ad: PCRYPTO_EX_DATA; idx: TIdC_INT; val: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_get_ex_data(const ad: PCRYPTO_EX_DATA; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;

  ///*
  // * The old locking functions have been removed completely without compatibility
  // * macros. This is because the old functions either could not properly report
  // * errors, or the returned error values were not clearly documented.
  // * Replacing the locking functions with no-ops would cause race condition
  // * issues in the affected applications. It is far better for them to fail at
  // * compile time.
  // * On the other hand, the locking callbacks are no longer used.  Consequently,
  // * the callback management functions can be safely replaced with no-op macros.
  // */
  //#  define CRYPTO_num_locks()            (1)
  //#  define CRYPTO_set_locking_callback(func)
  //#  define CRYPTO_get_locking_callback()         (NULL)
  //#  define CRYPTO_set_add_lock_callback(func)
  //#  define CRYPTO_get_add_lock_callback()        (NULL)

  ///* Only use CRYPTO_THREADID_set_[numeric|pointer]() within callbacks */
  //#  define CRYPTO_THREADID_set_numeric(id, val)
  //#  define CRYPTO_THREADID_set_pointer(id, ptr)
  //#  define CRYPTO_THREADID_set_callback(threadid_func)   (0)
  //#  define CRYPTO_THREADID_get_callback()                (NULL)
  //#  define CRYPTO_THREADID_current(id)
  //#  define CRYPTO_THREADID_cmp(a, b)                     (-1)
  //#  define CRYPTO_THREADID_cpy(dest, src)
  //#  define CRYPTO_THREADID_hash(id)                      (0UL)
  //
  //#  define CRYPTO_set_dynlock_create_callback(dyn_create_function)
  //#  define CRYPTO_set_dynlock_lock_callback(dyn_lock_function)
  //#  define CRYPTO_set_dynlock_destroy_callback(dyn_destroy_function)
  //#  define CRYPTO_get_dynlock_create_callback()          (NULL)
  //#  define CRYPTO_get_dynlock_lock_callback()            (NULL)
  //#  define CRYPTO_get_dynlock_destroy_callback()         (NULL)
  //# endif /* OPENSSL_API_COMPAT < 0x10100000L */

  function CRYPTO_set_mem_functions(m: CRYPTO_set_mem_functions_m; r: CRYPTO_set_mem_functions_r; f: CRYPTO_set_mem_functions_f): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_set_mem_debug(flag: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  //void CRYPTO_get_mem_functions(
  //        void *(**m) (TIdC_SIZET, const char *, int),
  //        void *(**r) (void *, TIdC_SIZET, const char *, int),
  //        void (**f) (void *, const char *, int));

  function CRYPTO_malloc(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function CRYPTO_zalloc(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function CRYPTO_memdup(const str: Pointer; siz: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function CRYPTO_strdup(const str: PIdAnsiChar; const file_: PIdAnsiChar; line: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  function CRYPTO_strndup(const str: PIdAnsiChar; s: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): PIdAnsiChar cdecl; external CLibCrypto;
  procedure CRYPTO_free(ptr: Pointer; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  procedure CRYPTO_clear_free(ptr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  function CRYPTO_realloc(addr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function CRYPTO_clear_realloc(addr: Pointer; old_num: TIdC_SIZET; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;

  function CRYPTO_secure_malloc_init(sz: TIdC_SIZET; minsize: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_secure_malloc_done: TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_secure_malloc(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function CRYPTO_secure_zalloc(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external CLibCrypto;
  procedure CRYPTO_secure_free(ptr: Pointer; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  procedure CRYPTO_secure_clear_free(ptr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  function CRYPTO_secure_allocated(const ptr: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_secure_malloc_initialized: TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_secure_actual_size(ptr: Pointer): TIdC_SIZET cdecl; external CLibCrypto;
  function CRYPTO_secure_used: TIdC_SIZET cdecl; external CLibCrypto;

  procedure OPENSSL_cleanse(ptr: Pointer; len: TIdC_SIZET) cdecl; external CLibCrypto;

  function CRYPTO_mem_debug_push(const info: PIdAnsiChar; const file_: PIdAnsiChar; line: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_mem_debug_pop: TIdC_INT cdecl; external CLibCrypto;
  procedure CRYPTO_get_alloc_counts(mcount: PIdC_INT; rcount: PIdC_INT; fcount: PIdC_INT) cdecl; external CLibCrypto;

  (*
   * Debugging functions (enabled by CRYPTO_set_mem_debug(1))
   * The flag argument has the following significance:
   *   0:   called before the actual memory allocation has taken place
   *   1:   called after the actual memory allocation has taken place
   *)
  procedure CRYPTO_mem_debug_malloc(addr: Pointer; num: TIdC_SIZET; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  procedure CRYPTO_mem_debug_realloc(addr1: Pointer; addr2: Pointer; num: TIdC_SIZET; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;
  procedure CRYPTO_mem_debug_free(addr: Pointer; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl; external CLibCrypto;

  function CRYPTO_mem_leaks_cb(cb: CRYPTO_mem_leaks_cb_cb; u: Pointer): TIdC_INT cdecl; external CLibCrypto;

//  function CRYPTO_mem_leaks_fp(&FILE: Pointer): TIdC_INT;
  function CRYPTO_mem_leaks(BIO: PBIO): TIdC_INT cdecl; external CLibCrypto;

  //* die if we have to */
  //ossl_noreturn void OPENSSL_die(const char *assertion, const char *file, int line);

  //# define OPENSSL_assert(e) \
  //    (void)((e) ? 0 : (OPENSSL_die("assertion failed: " #e, OPENSSL_FILE, OPENSSL_LINE), 1))

  function OPENSSL_isservice: TIdC_INT cdecl; external CLibCrypto;

  function FIPS_mode: TIdC_INT cdecl; external CLibCrypto;
  function FIPS_mode_set(r: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  procedure OPENSSL_init cdecl; external CLibCrypto;

  // struct tm *OPENSSL_gmtime(const TIdC_TIMET *timer, struct tm *result);

  //function OPENSSL_gmtime_adj(struct tm *tm, int offset_day, long offset_sec): TIdC_INT;
  //function OPENSSL_gmtime_diff(int *pday, int *psec, const struct tm *from, const struct tm *to): TIdC_INT;

  (*
   * CRYPTO_memcmp returns zero iff the |len| bytes at |a| and |b| are equal.
   * It takes an amount of time dependent on |len|, but independent of the
   * contents of |a| and |b|. Unlike memcmp, it cannot be used to put elements
   * into a defined order as the return value when a != b is undefined, other
   * than to be non-zero.
   *)
  function CRYPTO_memcmp(const in_a: Pointer; const in_b: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;

  (* Library initialisation functions *)
  procedure OPENSSL_cleanup cdecl; external CLibCrypto;
  function OPENSSL_init_crypto(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT cdecl; external CLibCrypto;
  // int OPENSSL_atexit(void (*handler)(void));
  procedure OPENSSL_thread_stop cdecl; external CLibCrypto;

  (* Low-level control of initialization *)
  function OPENSSL_INIT_new: POPENSSL_INIT_SETTINGS cdecl; external CLibCrypto;
  //int OPENSSL_INIT_set_config_filename(OPENSSL_INIT_SETTINGS *settings,
  //                                     const char *config_filename);
  //void OPENSSL_INIT_set_config_file_flags(OPENSSL_INIT_SETTINGS *settings,
  //                                        unsigned long flags);
  //int OPENSSL_INIT_set_config_appname(OPENSSL_INIT_SETTINGS *settings,
  //                                    const char *config_appname);
  procedure OPENSSL_INIT_free(settings: POPENSSL_INIT_SETTINGS) cdecl; external CLibCrypto;

  function CRYPTO_THREAD_run_once(once: PCRYPTO_ONCE; init: CRYPTO_THREAD_run_once_init): TIdC_INT cdecl; external CLibCrypto;

  //type
  //  CRYPTO_THREAD_init_local_cleanup = procedure(v1: Pointer);
  //
  //function CRYPTO_THREAD_init_local(key: PCRYPTO_THREAD_LOCAL; cleanup: CRYPTO_THREAD_init_local_cleanup): TIdC_INT;
  function CRYPTO_THREAD_get_local(key: PCRYPTO_THREAD_LOCAL): Pointer cdecl; external CLibCrypto;
  function CRYPTO_THREAD_set_local(key: PCRYPTO_THREAD_LOCAL; val: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function CRYPTO_THREAD_cleanup_local(key: PCRYPTO_THREAD_LOCAL): TidC_INT cdecl; external CLibCrypto;

  function CRYPTO_THREAD_get_current_id: CRYPTO_THREAD_ID cdecl; external CLibCrypto;
  function CRYPTO_THREAD_compare_id(a: CRYPTO_THREAD_ID; b: CRYPTO_THREAD_ID): TIdC_INT cdecl; external CLibCrypto;

implementation

// OPENSSL_FILE = __FILE__ = C preprocessor macro
// OPENSSL_LINE = __LINE__ = C preprocessor macro
// FPC hase an equivalent with {$I %FILE%} and {$I %LINENUM%}, see https://www.freepascal.org/docs-html/prog/progsu41.html#x47-460001.1.41
// Delphi has nothing :(

//# define OPENSSL_malloc(num) CRYPTO_malloc(num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_malloc(num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_malloc(num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_zalloc(num) CRYPTO_zalloc(num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_zalloc(num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_zalloc(num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_realloc(addr, num) CRYPTO_realloc(addr, num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_realloc(addr: Pointer; num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_realloc(addr, num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_clear_realloc(addr, old_num, num) CRYPTO_clear_realloc(addr, old_num, num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_clear_realloc(addr: Pointer; old_num: TIdC_SIZET; num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_clear_realloc(addr, old_num, num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_clear_free(addr, num) CRYPTO_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE)
procedure OPENSSL_clear_free(addr: Pointer; num: TIdC_SIZET);
begin
  CRYPTO_clear_free(addr, num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_free(addr) CRYPTO_free(addr, OPENSSL_FILE, OPENSSL_LINE)
procedure OPENSSL_free(addr: Pointer);
begin
  CRYPTO_free(addr, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_memdup(str, s) CRYPTO_memdup((str), s, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_memdup(const str: Pointer; s: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_memdup(str, s, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_strdup(str) CRYPTO_strdup(str, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_strdup(const str: PIdAnsiChar): PIdAnsiChar;
begin
  Result := CRYPTO_strdup(str, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_strndup(str, n) CRYPTO_strndup(str, n, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_strndup(const str: PIdAnsiChar; n: TIdC_SIZET): PIdAnsiChar;
begin
  Result := CRYPTO_strndup(str, n, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_secure_malloc(num) CRYPTO_secure_malloc(num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_secure_malloc(num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_secure_malloc(num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_secure_zalloc(num) CRYPTO_secure_zalloc(num, OPENSSL_FILE, OPENSSL_LINE)
function OPENSSL_secure_zalloc(num: TIdC_SIZET): Pointer;
begin
  Result := CRYPTO_secure_zalloc(num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_secure_free(addr) CRYPTO_secure_free(addr, OPENSSL_FILE, OPENSSL_LINE)
procedure OPENSSL_secure_free(addr: Pointer);
begin
  CRYPTO_secure_free(addr, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_secure_clear_free(addr, num) CRYPTO_secure_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE)
procedure OPENSSL_secure_clear_free(addr: Pointer; num: TIdC_SIZET);
begin
  CRYPTO_secure_clear_free(addr, num, {$IFNDEF FPC}''{$ELSE}{$I %FILE%}{$ENDIF}, {$IFNDEF FPC}-1{$ELSE}{$I %LINENUM%}{$ENDIF});
end;

//# define OPENSSL_secure_actual_size(ptr) CRYPTO_secure_actual_size(ptr)
function OPENSSL_secure_actual_size(ptr: Pointer): TIdC_SIZET;
begin
  Result := CRYPTO_secure_actual_size(ptr);
end;

end.
