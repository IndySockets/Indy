  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_conf.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_conf.h2pas
     and this file regenerated. IdOpenSSLHeaders_conf.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 

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

unit IdOpenSSLHeaders_conf;

interface

// Headers for OpenSSL 1.1.1
// conf.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ;

type
  CONF_parse_list_list_cb = function (const elem: PAnsiChar; len: TIdC_INT; usr: Pointer): TIdC_INT;

  CONF_VALUE = record
    section: PAnsiChar;
    name: PAnsiChar;
    value: PAnsiChar;
  end;
  PCONF_VALUE = ^CONF_VALUE;

//DEFINE_STACK_OF(CONF_VALUE)
//DEFINE_LHASH_OF(CONF_VALUE);

  conf_st = type Pointer;
  conf_method_st = type Pointer;
  CONF_METHOD = conf_method_st;
  PCONF_METHOD = ^conf_method_st;
  CONF = conf_st;
  PCONF = ^CONF;

  (*conf_method_st = record
    const char *name;
    CONF *(*create) (CONF_METHOD *meth);
    int (*init) (CONF *conf);
    int (*destroy) (CONF *conf);
    int (*destroy_data) (CONF *conf);
    int (*load_bio) (CONF *conf, BIO *bp, long *eline);
    int (*dump) (const CONF *conf, BIO *bp);
    int (*is_number) (const CONF *conf, char c);
    int (*to_int) (const CONF *conf, char c);
    int (*load) (CONF *conf, const char *name, long *eline);
  end; *)

//* Module definitions */

  conf_imodule_st = type Pointer;
  CONF_IMODULE = conf_imodule_st;
  PCONF_IMODULE = ^CONF_IMODULE;
  conf_module_st = type Pointer;
  CONF_MODULE = conf_module_st;
  PCONF_MODULE = ^CONF_MODULE;

//DEFINE_STACK_OF(CONF_MODULE)
//DEFINE_STACK_OF(CONF_IMODULE)

//* DSO module function typedefs */
  conf_init_func = function(md: PCONF_IMODULE; const cnf: PCONF): TIdC_INT;
  conf_finish_func = procedure(md: PCONF_IMODULE);

const
  CONF_MFLAGS_IGNORE_ERRORS = $1;
  CONF_MFLAGS_IGNORE_RETURN_CODES = $2;
  CONF_MFLAGS_SILENT = $4;
  CONF_MFLAGS_NO_DSO = $8;
  CONF_MFLAGS_IGNORE_MISSING_FILE = $10;
  CONF_MFLAGS_DEFAULT_SECTION = $20;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM CONF_set_default_method}
  {$EXTERNALSYM NCONF_new}
  {$EXTERNALSYM NCONF_default}
  {$EXTERNALSYM NCONF_WIN32}
  {$EXTERNALSYM NCONF_free}
  {$EXTERNALSYM NCONF_free_data}
  {$EXTERNALSYM NCONF_load}
  {$EXTERNALSYM NCONF_load_bio}
  {$EXTERNALSYM NCONF_get_string}
  {$EXTERNALSYM NCONF_get_number_e}
  {$EXTERNALSYM NCONF_dump_bio}
  {$EXTERNALSYM CONF_modules_load}
  {$EXTERNALSYM CONF_modules_load_file}
  {$EXTERNALSYM CONF_modules_unload}
  {$EXTERNALSYM CONF_modules_finish}
  {$EXTERNALSYM CONF_module_add}
  {$EXTERNALSYM CONF_imodule_get_usr_data}
  {$EXTERNALSYM CONF_imodule_set_usr_data}
  {$EXTERNALSYM CONF_imodule_get_module}
  {$EXTERNALSYM CONF_imodule_get_flags}
  {$EXTERNALSYM CONF_imodule_set_flags}
  {$EXTERNALSYM CONF_module_get_usr_data}
  {$EXTERNALSYM CONF_module_set_usr_data}
  {$EXTERNALSYM CONF_get1_default_config_file}
  {$EXTERNALSYM CONF_parse_list}
  {$EXTERNALSYM OPENSSL_load_builtin_modules}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  CONF_set_default_method: function(meth: PCONF_METHOD): TIdC_INT; cdecl = nil;
//  (*
//  void CONF_set_nconf(CONF *conf, LHASH_OF(CONF_VALUE) *hash);
//  LHASH_OF(CONF_VALUE) *CONF_load(LHASH_OF(CONF_VALUE) *conf, const char *file, long *eline);
//  {$ifndef OPENSSL_NO_STDIO}
//  LHASH_OF(CONF_VALUE) *CONF_load_fp(LHASH_OF(CONF_VALUE) *conf, FILE *fp, long *eline);
//  {$endif}
//  LHASH_OF(CONF_VALUE) *CONF_load_bio(LHASH_OF(CONF_VALUE) *conf, BIO *bp,
//                                      long *eline);
//  STACK_OF(CONF_VALUE) *CONF_get_section(LHASH_OF(CONF_VALUE) *conf,
//                                         const char *section);
//  char *CONF_get_string(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                        const char *name);
//  long CONF_get_number(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                       const char *name);
//  void CONF_free(LHASH_OF(CONF_VALUE) *conf);
//  #ifndef OPENSSL_NO_STDIO
//  int CONF_dump_fp(LHASH_OF(CONF_VALUE) *conf, FILE *out);
//  #endif
//  int CONF_dump_bio(LHASH_OF(CONF_VALUE) *conf, BIO *out);
//
//  DEPRECATEDIN_1_1_0(void OPENSSL_config(const char *config_name))
//
//  #if OPENSSL_API_COMPAT < 0x10100000L
//  # define OPENSSL_no_config() \
//      OPENSSL_init_crypto(OPENSSL_INIT_NO_LOAD_CONFIG, NULL)
//  #endif
//  *)

  (*
   * New conf code.  The semantics are different from the functions above. If
   * that wasn't the case, the above functions would have been replaced
   *)

  //type     Doppelt???
  //  conf_st = record
  //    CONF_METHOD *meth;
  //    void *meth_data;
  //    LHASH_OF(CONF_VALUE) *data;
  //  end;

  NCONF_new: function(meth: PCONF_METHOD): PCONF; cdecl = nil;
  NCONF_default: function: PCONF_METHOD; cdecl = nil;
  NCONF_WIN32: function: PCONF_METHOD; cdecl = nil;
  NCONF_free: procedure(conf: PCONF); cdecl = nil;
  NCONF_free_data: procedure(conf: PCONF); cdecl = nil;

  NCONF_load: function(conf: PCONF; const file_: PAnsiChar; eline: PIdC_LONG): TIdC_INT; cdecl = nil;
  NCONF_load_bio: function(conf: PCONF; bp: PBIO; eline: PIdC_LONG): TIdC_INT; cdecl = nil;
  //STACK_OF(CONF_VALUE) *NCONF_get_section(const CONF *conf,
  //                                        const char *section);
  NCONF_get_string: function(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar): PAnsiChar; cdecl = nil;
  NCONF_get_number_e: function(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar; result: PIdC_LONG): TIdC_INT; cdecl = nil;
  NCONF_dump_bio: function(const conf: PCONf; out_: PBIO): TIdC_INT; cdecl = nil;

  //#define NCONF_get_number(c,g,n,r) NCONF_get_number_e(c,g,n,r)

  //* Module functions */

  CONF_modules_load: function(const cnf: PCONF; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;
  CONF_modules_load_file: function(const filename: PAnsiChar; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;

  CONF_modules_unload: procedure(all: TIdC_INT); cdecl = nil;
  CONF_modules_finish: procedure; cdecl = nil;
  CONF_module_add: function(const name: PAnsiChar; ifunc: conf_init_func; ffunc: conf_finish_func): TIdC_INT; cdecl = nil;

  //const char *CONF_imodule_get_name(const CONF_IMODULE *md);
  //const char *CONF_imodule_get_value(const CONF_IMODULE *md);
  CONF_imodule_get_usr_data: function(const md: PCONF_IMODULE): Pointer; cdecl = nil;
  CONF_imodule_set_usr_data: procedure(md: PCONF_IMODULE; usr_data: Pointer); cdecl = nil;
  CONF_imodule_get_module: function(const md: PCONF_IMODULE): PCONF_MODULE; cdecl = nil;
  CONF_imodule_get_flags: function(const md: PCONF_IMODULE): TIdC_ULONG; cdecl = nil;
  CONF_imodule_set_flags: procedure(md: PCONF_IMODULE; flags: TIdC_ULONG); cdecl = nil;
  CONF_module_get_usr_data: function(pmod: PCONF_MODULE): Pointer; cdecl = nil;
  CONF_module_set_usr_data: procedure(pmod: PCONF_MODULE; usr_data: Pointer); cdecl = nil;

  CONF_get1_default_config_file: function: PAnsiChar; cdecl = nil;
  CONF_parse_list: function(const list: PAnsiChar; sep: TIdC_INT; nospc: TIdC_INT; list_cb: CONF_parse_list_list_cb; arg: Pointer): TIdC_INT; cdecl = nil;

  OPENSSL_load_builtin_modules: procedure; cdecl = nil;

{$ELSE}
  function CONF_set_default_method(meth: PCONF_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  (*
//  void CONF_set_nconf(CONF *conf, LHASH_OF(CONF_VALUE) *hash);
//  LHASH_OF(CONF_VALUE) *CONF_load(LHASH_OF(CONF_VALUE) *conf, const char *file, long *eline);
//  {$ifndef OPENSSL_NO_STDIO}
//  LHASH_OF(CONF_VALUE) *CONF_load_fp(LHASH_OF(CONF_VALUE) *conf, FILE *fp, long *eline);
//  {$endif}
//  LHASH_OF(CONF_VALUE) *CONF_load_bio(LHASH_OF(CONF_VALUE) *conf, BIO *bp,
//                                      long *eline);
//  STACK_OF(CONF_VALUE) *CONF_get_section(LHASH_OF(CONF_VALUE) *conf,
//                                         const char *section);
//  char *CONF_get_string(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                        const char *name);
//  long CONF_get_number(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                       const char *name);
//  void CONF_free(LHASH_OF(CONF_VALUE) *conf);
//  #ifndef OPENSSL_NO_STDIO
//  int CONF_dump_fp(LHASH_OF(CONF_VALUE) *conf, FILE *out);
//  #endif
//  int CONF_dump_bio(LHASH_OF(CONF_VALUE) *conf, BIO *out);
//
//  DEPRECATEDIN_1_1_0(void OPENSSL_config(const char *config_name))
//
//  #if OPENSSL_API_COMPAT < 0x10100000L
//  # define OPENSSL_no_config() \
//      OPENSSL_init_crypto(OPENSSL_INIT_NO_LOAD_CONFIG, NULL)
//  #endif
//  *)

  (*
   * New conf code.  The semantics are different from the functions above. If
   * that wasn't the case, the above functions would have been replaced
   *)

  //type     Doppelt???
  //  conf_st = record
  //    CONF_METHOD *meth;
  //    void *meth_data;
  //    LHASH_OF(CONF_VALUE) *data;
  //  end;

  function NCONF_new(meth: PCONF_METHOD): PCONF cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function NCONF_default: PCONF_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function NCONF_WIN32: PCONF_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure NCONF_free(conf: PCONF) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure NCONF_free_data(conf: PCONF) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function NCONF_load(conf: PCONF; const file_: PAnsiChar; eline: PIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function NCONF_load_bio(conf: PCONF; bp: PBIO; eline: PIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //STACK_OF(CONF_VALUE) *NCONF_get_section(const CONF *conf,
  //                                        const char *section);
  function NCONF_get_string(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function NCONF_get_number_e(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar; result: PIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function NCONF_dump_bio(const conf: PCONf; out_: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //#define NCONF_get_number(c,g,n,r) NCONF_get_number_e(c,g,n,r)

  //* Module functions */

  function CONF_modules_load(const cnf: PCONF; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_modules_load_file(const filename: PAnsiChar; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure CONF_modules_unload(all: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CONF_modules_finish cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_module_add(const name: PAnsiChar; ifunc: conf_init_func; ffunc: conf_finish_func): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //const char *CONF_imodule_get_name(const CONF_IMODULE *md);
  //const char *CONF_imodule_get_value(const CONF_IMODULE *md);
  function CONF_imodule_get_usr_data(const md: PCONF_IMODULE): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CONF_imodule_set_usr_data(md: PCONF_IMODULE; usr_data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_imodule_get_module(const md: PCONF_IMODULE): PCONF_MODULE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_imodule_get_flags(const md: PCONF_IMODULE): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CONF_imodule_set_flags(md: PCONF_IMODULE; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_module_get_usr_data(pmod: PCONF_MODULE): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure CONF_module_set_usr_data(pmod: PCONF_MODULE; usr_data: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function CONF_get1_default_config_file: PAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function CONF_parse_list(const list: PAnsiChar; sep: TIdC_INT; nospc: TIdC_INT; list_cb: CONF_parse_list_list_cb; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure OPENSSL_load_builtin_modules cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  CONF_set_default_method := LoadFunction('CONF_set_default_method',AFailed);
  NCONF_new := LoadFunction('NCONF_new',AFailed);
  NCONF_default := LoadFunction('NCONF_default',AFailed);
  NCONF_WIN32 := LoadFunction('NCONF_WIN32',AFailed);
  NCONF_free := LoadFunction('NCONF_free',AFailed);
  NCONF_free_data := LoadFunction('NCONF_free_data',AFailed);
  NCONF_load := LoadFunction('NCONF_load',AFailed);
  NCONF_load_bio := LoadFunction('NCONF_load_bio',AFailed);
  NCONF_get_string := LoadFunction('NCONF_get_string',AFailed);
  NCONF_get_number_e := LoadFunction('NCONF_get_number_e',AFailed);
  NCONF_dump_bio := LoadFunction('NCONF_dump_bio',AFailed);
  CONF_modules_load := LoadFunction('CONF_modules_load',AFailed);
  CONF_modules_load_file := LoadFunction('CONF_modules_load_file',AFailed);
  CONF_modules_unload := LoadFunction('CONF_modules_unload',AFailed);
  CONF_modules_finish := LoadFunction('CONF_modules_finish',AFailed);
  CONF_module_add := LoadFunction('CONF_module_add',AFailed);
  CONF_imodule_get_usr_data := LoadFunction('CONF_imodule_get_usr_data',AFailed);
  CONF_imodule_set_usr_data := LoadFunction('CONF_imodule_set_usr_data',AFailed);
  CONF_imodule_get_module := LoadFunction('CONF_imodule_get_module',AFailed);
  CONF_imodule_get_flags := LoadFunction('CONF_imodule_get_flags',AFailed);
  CONF_imodule_set_flags := LoadFunction('CONF_imodule_set_flags',AFailed);
  CONF_module_get_usr_data := LoadFunction('CONF_module_get_usr_data',AFailed);
  CONF_module_set_usr_data := LoadFunction('CONF_module_set_usr_data',AFailed);
  CONF_get1_default_config_file := LoadFunction('CONF_get1_default_config_file',AFailed);
  CONF_parse_list := LoadFunction('CONF_parse_list',AFailed);
  OPENSSL_load_builtin_modules := LoadFunction('OPENSSL_load_builtin_modules',AFailed);
end;

procedure Unload;
begin
  CONF_set_default_method := nil;
  NCONF_new := nil;
  NCONF_default := nil;
  NCONF_WIN32 := nil;
  NCONF_free := nil;
  NCONF_free_data := nil;
  NCONF_load := nil;
  NCONF_load_bio := nil;
  NCONF_get_string := nil;
  NCONF_get_number_e := nil;
  NCONF_dump_bio := nil;
  CONF_modules_load := nil;
  CONF_modules_load_file := nil;
  CONF_modules_unload := nil;
  CONF_modules_finish := nil;
  CONF_module_add := nil;
  CONF_imodule_get_usr_data := nil;
  CONF_imodule_set_usr_data := nil;
  CONF_imodule_get_module := nil;
  CONF_imodule_get_flags := nil;
  CONF_imodule_set_flags := nil;
  CONF_module_get_usr_data := nil;
  CONF_module_set_usr_data := nil;
  CONF_get1_default_config_file := nil;
  CONF_parse_list := nil;
  OPENSSL_load_builtin_modules := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
