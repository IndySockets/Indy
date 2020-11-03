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

// Generation date: 03.11.2020 09:35:33

unit IdOpenSSLHeaders_crypto;

interface

// Headers for OpenSSL 1.1.1
// crypto.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  CRYPTO_THREAD_lock_new: function: PCRYPTO_RWLOCK cdecl = nil;
  CRYPTO_THREAD_read_lock: function(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl = nil;
  CRYPTO_THREAD_write_lock: function(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl = nil;
  CRYPTO_THREAD_unlock: function(lock: PCRYPTO_RWLOCK): TIdC_INT cdecl = nil;
  CRYPTO_THREAD_lock_free: procedure(lock: PCRYPTO_RWLOCK) cdecl = nil;

  CRYPTO_atomic_add: function(val: PIdC_INT; amount: TIdC_INT; ret: PIdC_INT; lock: PCRYPTO_RWLOCK): TIdC_INT cdecl = nil;

  CRYPTO_mem_ctrl: function(mode: TIdC_INT): TIdC_INT cdecl = nil;

  OPENSSL_strlcpy: function(dst: PIdAnsiChar; const src: PIdAnsiChar; siz: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  OPENSSL_strlcat: function(dst: PIdAnsiChar; const src: PIdAnsiChar; siz: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  OPENSSL_strnlen: function(const str: PIdAnsiChar; maxlen: TIdC_SIZET): TIdC_SIZET cdecl = nil;
  OPENSSL_buf2hexstr: function(const buffer: PByte; len: TIdC_LONG): PIdAnsiChar cdecl = nil;
  OPENSSL_hexstr2buf: function(const str: PIdAnsiChar; len: PIdC_LONG): PByte cdecl = nil;
  OPENSSL_hexchar2int: function(c: Byte): TIdC_INT cdecl = nil;

  // # define OPENSSL_MALLOC_MAX_NELEMS(type)  (((1U<<(sizeof(int)*8-1))-1)/sizeof(type))

  OpenSSL_version_num: function: TIdC_ULONG cdecl = nil;
  OpenSSL_version: function(&type: TIdC_INT): PIdAnsiChar cdecl = nil;

  OPENSSL_issetugid: function: TIdC_INT cdecl = nil;

  (* No longer use an index. *)
  //function CRYPTO_free_ex_index(class_index: TIdC_INT; idx: TIdC_INT): TIdC_INT;

  (*
   * Initialise/duplicate/free CRYPTO_EX_DATA variables corresponding to a
   * given class (invokes whatever per-class callbacks are applicable)
   *)
  CRYPTO_new_ex_data: function(class_index: TIdC_INT; obj: Pointer; ad: PCRYPTO_EX_DATA): TIdC_INT cdecl = nil;
  CRYPTO_dup_ex_data: function(class_index: TIdC_INT; to_: PCRYPTO_EX_DATA; const from: PCRYPTO_EX_DATA): TIdC_INT cdecl = nil;

  CRYPTO_free_ex_data: procedure(class_index: TIdC_INT; obj: Pointer; ad: PCRYPTO_EX_DATA) cdecl = nil;

  (*
   * Get/set data in a CRYPTO_EX_DATA variable corresponding to a particular
   * index (relative to the class type involved)
   *)
  CRYPTO_set_ex_data: function(ad: PCRYPTO_EX_DATA; idx: TIdC_INT; val: Pointer): TIdC_INT cdecl = nil;
  CRYPTO_get_ex_data: function(const ad: PCRYPTO_EX_DATA; idx: TIdC_INT): Pointer cdecl = nil;

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

  CRYPTO_set_mem_functions: function(m: CRYPTO_set_mem_functions_m; r: CRYPTO_set_mem_functions_r; f: CRYPTO_set_mem_functions_f): TIdC_INT cdecl = nil;
  CRYPTO_set_mem_debug: function(flag: TIdC_INT): TIdC_INT cdecl = nil;
  //void CRYPTO_get_mem_functions(
  //        void *(**m) (TIdC_SIZET, const char *, int),
  //        void *(**r) (void *, TIdC_SIZET, const char *, int),
  //        void (**f) (void *, const char *, int));

  CRYPTO_malloc: function(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_zalloc: function(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_memdup: function(const str: Pointer; siz: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_strdup: function(const str: PIdAnsiChar; const file_: PIdAnsiChar; line: TIdC_INT): PIdAnsiChar cdecl = nil;
  CRYPTO_strndup: function(const str: PIdAnsiChar; s: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): PIdAnsiChar cdecl = nil;
  CRYPTO_free: procedure(ptr: Pointer; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_clear_free: procedure(ptr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_realloc: function(addr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_clear_realloc: function(addr: Pointer; old_num: TIdC_SIZET; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;

  CRYPTO_secure_malloc_init: function(sz: TIdC_SIZET; minsize: TIdC_INT): TIdC_INT cdecl = nil;
  CRYPTO_secure_malloc_done: function: TIdC_INT cdecl = nil;
  CRYPTO_secure_malloc: function(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_secure_zalloc: function(num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT): Pointer cdecl = nil;
  CRYPTO_secure_free: procedure(ptr: Pointer; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_secure_clear_free: procedure(ptr: Pointer; num: TIdC_SIZET; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_secure_allocated: function(const ptr: Pointer): TIdC_INT cdecl = nil;
  CRYPTO_secure_malloc_initialized: function: TIdC_INT cdecl = nil;
  CRYPTO_secure_actual_size: function(ptr: Pointer): TIdC_SIZET cdecl = nil;
  CRYPTO_secure_used: function: TIdC_SIZET cdecl = nil;

  OPENSSL_cleanse: procedure(ptr: Pointer; len: TIdC_SIZET) cdecl = nil;

  CRYPTO_mem_debug_push: function(const info: PIdAnsiChar; const file_: PIdAnsiChar; line: TIdC_INT): TIdC_INT cdecl = nil;
  CRYPTO_mem_debug_pop: function: TIdC_INT cdecl = nil;
  CRYPTO_get_alloc_counts: procedure(mcount: PIdC_INT; rcount: PIdC_INT; fcount: PIdC_INT) cdecl = nil;

  (*
   * Debugging functions (enabled by CRYPTO_set_mem_debug(1))
   * The flag argument has the following significance:
   *   0:   called before the actual memory allocation has taken place
   *   1:   called after the actual memory allocation has taken place
   *)
  CRYPTO_mem_debug_malloc: procedure(addr: Pointer; num: TIdC_SIZET; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_mem_debug_realloc: procedure(addr1: Pointer; addr2: Pointer; num: TIdC_SIZET; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;
  CRYPTO_mem_debug_free: procedure(addr: Pointer; flag: TIdC_INT; const file_: PIdAnsiChar; line: TIdC_INT) cdecl = nil;

  CRYPTO_mem_leaks_cb: function(cb: CRYPTO_mem_leaks_cb_cb; u: Pointer): TIdC_INT cdecl = nil;

//  function CRYPTO_mem_leaks_fp(&FILE: Pointer): TIdC_INT;
  CRYPTO_mem_leaks: function(BIO: PBIO): TIdC_INT cdecl = nil;

  //* die if we have to */
  //ossl_noreturn void OPENSSL_die(const char *assertion, const char *file, int line);

  //# define OPENSSL_assert(e) \
  //    (void)((e) ? 0 : (OPENSSL_die("assertion failed: " #e, OPENSSL_FILE, OPENSSL_LINE), 1))

  OPENSSL_isservice: function: TIdC_INT cdecl = nil;

  FIPS_mode: function: TIdC_INT cdecl = nil;
  FIPS_mode_set: function(r: TIdC_INT): TIdC_INT cdecl = nil;

  OPENSSL_init: procedure cdecl = nil;

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
  CRYPTO_memcmp: function(const in_a: Pointer; const in_b: Pointer; len: TIdC_SIZET): TIdC_INT cdecl = nil;

  (* Library initialisation functions *)
  OPENSSL_cleanup: procedure cdecl = nil;
  OPENSSL_init_crypto: function(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT cdecl = nil;
  // int OPENSSL_atexit(void (*handler)(void));
  OPENSSL_thread_stop: procedure cdecl = nil;

  (* Low-level control of initialization *)
  OPENSSL_INIT_new: function: POPENSSL_INIT_SETTINGS cdecl = nil;
  //int OPENSSL_INIT_set_config_filename(OPENSSL_INIT_SETTINGS *settings,
  //                                     const char *config_filename);
  //void OPENSSL_INIT_set_config_file_flags(OPENSSL_INIT_SETTINGS *settings,
  //                                        unsigned long flags);
  //int OPENSSL_INIT_set_config_appname(OPENSSL_INIT_SETTINGS *settings,
  //                                    const char *config_appname);
  OPENSSL_INIT_free: procedure(settings: POPENSSL_INIT_SETTINGS) cdecl = nil;

  CRYPTO_THREAD_run_once: function(once: PCRYPTO_ONCE; init: CRYPTO_THREAD_run_once_init): TIdC_INT cdecl = nil;

  //type
  //  CRYPTO_THREAD_init_local_cleanup = procedure(v1: Pointer);
  //
  //function CRYPTO_THREAD_init_local(key: PCRYPTO_THREAD_LOCAL; cleanup: CRYPTO_THREAD_init_local_cleanup): TIdC_INT;
  CRYPTO_THREAD_get_local: function(key: PCRYPTO_THREAD_LOCAL): Pointer cdecl = nil;
  CRYPTO_THREAD_set_local: function(key: PCRYPTO_THREAD_LOCAL; val: Pointer): TIdC_INT cdecl = nil;
  CRYPTO_THREAD_cleanup_local: function(key: PCRYPTO_THREAD_LOCAL): TidC_INT cdecl = nil;

  CRYPTO_THREAD_get_current_id: function: CRYPTO_THREAD_ID cdecl = nil;
  CRYPTO_THREAD_compare_id: function(a: CRYPTO_THREAD_ID; b: CRYPTO_THREAD_ID): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  CRYPTO_THREAD_lock_new := LoadFunction('CRYPTO_THREAD_lock_new', AFailed);
  CRYPTO_THREAD_read_lock := LoadFunction('CRYPTO_THREAD_read_lock', AFailed);
  CRYPTO_THREAD_write_lock := LoadFunction('CRYPTO_THREAD_write_lock', AFailed);
  CRYPTO_THREAD_unlock := LoadFunction('CRYPTO_THREAD_unlock', AFailed);
  CRYPTO_THREAD_lock_free := LoadFunction('CRYPTO_THREAD_lock_free', AFailed);
  CRYPTO_atomic_add := LoadFunction('CRYPTO_atomic_add', AFailed);
  CRYPTO_mem_ctrl := LoadFunction('CRYPTO_mem_ctrl', AFailed);
  OPENSSL_strlcpy := LoadFunction('OPENSSL_strlcpy', AFailed);
  OPENSSL_strlcat := LoadFunction('OPENSSL_strlcat', AFailed);
  OPENSSL_strnlen := LoadFunction('OPENSSL_strnlen', AFailed);
  OPENSSL_buf2hexstr := LoadFunction('OPENSSL_buf2hexstr', AFailed);
  OPENSSL_hexstr2buf := LoadFunction('OPENSSL_hexstr2buf', AFailed);
  OPENSSL_hexchar2int := LoadFunction('OPENSSL_hexchar2int', AFailed);
  OpenSSL_version_num := LoadFunction('OpenSSL_version_num', AFailed);
  OpenSSL_version := LoadFunction('OpenSSL_version', AFailed);
  OPENSSL_issetugid := LoadFunction('OPENSSL_issetugid', AFailed);
  CRYPTO_new_ex_data := LoadFunction('CRYPTO_new_ex_data', AFailed);
  CRYPTO_dup_ex_data := LoadFunction('CRYPTO_dup_ex_data', AFailed);
  CRYPTO_free_ex_data := LoadFunction('CRYPTO_free_ex_data', AFailed);
  CRYPTO_set_ex_data := LoadFunction('CRYPTO_set_ex_data', AFailed);
  CRYPTO_get_ex_data := LoadFunction('CRYPTO_get_ex_data', AFailed);
  CRYPTO_set_mem_functions := LoadFunction('CRYPTO_set_mem_functions', AFailed);
  CRYPTO_set_mem_debug := LoadFunction('CRYPTO_set_mem_debug', AFailed);
  CRYPTO_malloc := LoadFunction('CRYPTO_malloc', AFailed);
  CRYPTO_zalloc := LoadFunction('CRYPTO_zalloc', AFailed);
  CRYPTO_memdup := LoadFunction('CRYPTO_memdup', AFailed);
  CRYPTO_strdup := LoadFunction('CRYPTO_strdup', AFailed);
  CRYPTO_strndup := LoadFunction('CRYPTO_strndup', AFailed);
  CRYPTO_free := LoadFunction('CRYPTO_free', AFailed);
  CRYPTO_clear_free := LoadFunction('CRYPTO_clear_free', AFailed);
  CRYPTO_realloc := LoadFunction('CRYPTO_realloc', AFailed);
  CRYPTO_clear_realloc := LoadFunction('CRYPTO_clear_realloc', AFailed);
  CRYPTO_secure_malloc_init := LoadFunction('CRYPTO_secure_malloc_init', AFailed);
  CRYPTO_secure_malloc_done := LoadFunction('CRYPTO_secure_malloc_done', AFailed);
  CRYPTO_secure_malloc := LoadFunction('CRYPTO_secure_malloc', AFailed);
  CRYPTO_secure_zalloc := LoadFunction('CRYPTO_secure_zalloc', AFailed);
  CRYPTO_secure_free := LoadFunction('CRYPTO_secure_free', AFailed);
  CRYPTO_secure_clear_free := LoadFunction('CRYPTO_secure_clear_free', AFailed);
  CRYPTO_secure_allocated := LoadFunction('CRYPTO_secure_allocated', AFailed);
  CRYPTO_secure_malloc_initialized := LoadFunction('CRYPTO_secure_malloc_initialized', AFailed);
  CRYPTO_secure_actual_size := LoadFunction('CRYPTO_secure_actual_size', AFailed);
  CRYPTO_secure_used := LoadFunction('CRYPTO_secure_used', AFailed);
  OPENSSL_cleanse := LoadFunction('OPENSSL_cleanse', AFailed);
  CRYPTO_mem_debug_push := LoadFunction('CRYPTO_mem_debug_push', AFailed);
  CRYPTO_mem_debug_pop := LoadFunction('CRYPTO_mem_debug_pop', AFailed);
  CRYPTO_get_alloc_counts := LoadFunction('CRYPTO_get_alloc_counts', AFailed);
  CRYPTO_mem_debug_malloc := LoadFunction('CRYPTO_mem_debug_malloc', AFailed);
  CRYPTO_mem_debug_realloc := LoadFunction('CRYPTO_mem_debug_realloc', AFailed);
  CRYPTO_mem_debug_free := LoadFunction('CRYPTO_mem_debug_free', AFailed);
  CRYPTO_mem_leaks_cb := LoadFunction('CRYPTO_mem_leaks_cb', AFailed);
  CRYPTO_mem_leaks := LoadFunction('CRYPTO_mem_leaks', AFailed);
  OPENSSL_isservice := LoadFunction('OPENSSL_isservice', AFailed);
  FIPS_mode := LoadFunction('FIPS_mode', AFailed);
  FIPS_mode_set := LoadFunction('FIPS_mode_set', AFailed);
  OPENSSL_init := LoadFunction('OPENSSL_init', AFailed);
  CRYPTO_memcmp := LoadFunction('CRYPTO_memcmp', AFailed);
  OPENSSL_cleanup := LoadFunction('OPENSSL_cleanup', AFailed);
  OPENSSL_init_crypto := LoadFunction('OPENSSL_init_crypto', AFailed);
  OPENSSL_thread_stop := LoadFunction('OPENSSL_thread_stop', AFailed);
  OPENSSL_INIT_new := LoadFunction('OPENSSL_INIT_new', AFailed);
  OPENSSL_INIT_free := LoadFunction('OPENSSL_INIT_free', AFailed);
  CRYPTO_THREAD_run_once := LoadFunction('CRYPTO_THREAD_run_once', AFailed);
  CRYPTO_THREAD_get_local := LoadFunction('CRYPTO_THREAD_get_local', AFailed);
  CRYPTO_THREAD_set_local := LoadFunction('CRYPTO_THREAD_set_local', AFailed);
  CRYPTO_THREAD_cleanup_local := LoadFunction('CRYPTO_THREAD_cleanup_local', AFailed);
  CRYPTO_THREAD_get_current_id := LoadFunction('CRYPTO_THREAD_get_current_id', AFailed);
  CRYPTO_THREAD_compare_id := LoadFunction('CRYPTO_THREAD_compare_id', AFailed);
end;

procedure UnLoad;
begin
  CRYPTO_THREAD_lock_new := nil;
  CRYPTO_THREAD_read_lock := nil;
  CRYPTO_THREAD_write_lock := nil;
  CRYPTO_THREAD_unlock := nil;
  CRYPTO_THREAD_lock_free := nil;
  CRYPTO_atomic_add := nil;
  CRYPTO_mem_ctrl := nil;
  OPENSSL_strlcpy := nil;
  OPENSSL_strlcat := nil;
  OPENSSL_strnlen := nil;
  OPENSSL_buf2hexstr := nil;
  OPENSSL_hexstr2buf := nil;
  OPENSSL_hexchar2int := nil;
  OpenSSL_version_num := nil;
  OpenSSL_version := nil;
  OPENSSL_issetugid := nil;
  CRYPTO_new_ex_data := nil;
  CRYPTO_dup_ex_data := nil;
  CRYPTO_free_ex_data := nil;
  CRYPTO_set_ex_data := nil;
  CRYPTO_get_ex_data := nil;
  CRYPTO_set_mem_functions := nil;
  CRYPTO_set_mem_debug := nil;
  CRYPTO_malloc := nil;
  CRYPTO_zalloc := nil;
  CRYPTO_memdup := nil;
  CRYPTO_strdup := nil;
  CRYPTO_strndup := nil;
  CRYPTO_free := nil;
  CRYPTO_clear_free := nil;
  CRYPTO_realloc := nil;
  CRYPTO_clear_realloc := nil;
  CRYPTO_secure_malloc_init := nil;
  CRYPTO_secure_malloc_done := nil;
  CRYPTO_secure_malloc := nil;
  CRYPTO_secure_zalloc := nil;
  CRYPTO_secure_free := nil;
  CRYPTO_secure_clear_free := nil;
  CRYPTO_secure_allocated := nil;
  CRYPTO_secure_malloc_initialized := nil;
  CRYPTO_secure_actual_size := nil;
  CRYPTO_secure_used := nil;
  OPENSSL_cleanse := nil;
  CRYPTO_mem_debug_push := nil;
  CRYPTO_mem_debug_pop := nil;
  CRYPTO_get_alloc_counts := nil;
  CRYPTO_mem_debug_malloc := nil;
  CRYPTO_mem_debug_realloc := nil;
  CRYPTO_mem_debug_free := nil;
  CRYPTO_mem_leaks_cb := nil;
  CRYPTO_mem_leaks := nil;
  OPENSSL_isservice := nil;
  FIPS_mode := nil;
  FIPS_mode_set := nil;
  OPENSSL_init := nil;
  CRYPTO_memcmp := nil;
  OPENSSL_cleanup := nil;
  OPENSSL_init_crypto := nil;
  OPENSSL_thread_stop := nil;
  OPENSSL_INIT_new := nil;
  OPENSSL_INIT_free := nil;
  CRYPTO_THREAD_run_once := nil;
  CRYPTO_THREAD_get_local := nil;
  CRYPTO_THREAD_set_local := nil;
  CRYPTO_THREAD_cleanup_local := nil;
  CRYPTO_THREAD_get_current_id := nil;
  CRYPTO_THREAD_compare_id := nil;
end;

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
