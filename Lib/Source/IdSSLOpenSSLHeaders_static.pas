unit IdSSLOpenSSLHeaders_static;

interface

{$I IdCompilerDefines.inc}

{$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}

{$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$HPPEMIT '#pragma link "IdSSLOpenSSLHeaders_static"'}
{$ENDIF}

implementation

{$IFDEF STATICLOAD_OPENSSL}
uses
  IdGlobal, Posix.SysTypes, IdCTypes, IdSSLOpenSSLHeaders;

const
  SSL_LIB_name         = 'libssl.a'; {Do not Localize}
  SSLCLIB_LIB_name     = 'libcrypto.a'; {Do not Localize}

function SSL_CTX_set_cipher_list_func(_para1: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_cipher_list';

function SSL_CTX_new_func(meth: PSSL_METHOD): PSSL_CTX cdecl; external SSL_LIB_NAME name 'SSL_CTX_new';

procedure SSL_CTX_free_proc(_para1: PSSL_CTX) cdecl; external SSL_LIB_NAME name 'SSL_CTX_free';

function SSL_set_fd_func(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_set_fd';

function SSL_CTX_use_PrivateKey_file_func(ctx: PSSL_CTX; const _file: PIdAnsiChar; _type: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_use_PrivateKey_file';

function SSL_CTX_use_PrivateKey_func(ctx: PSSL_CTX; pkey: PEVP_PKEY): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_use_PrivateKey';

function SSL_CTX_use_certificate_func(ctx: PSSL_CTX; x: PX509): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_use_certificate';

function SSL_CTX_use_certificate_file_func(ctx: PSSL_CTX; const _file: PIdAnsiChar; _type: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_use_certificate_file';

procedure SSL_load_error_strings_proc cdecl; external SSL_LIB_NAME name 'SSL_load_error_strings';

function SSL_state_string_long_func(s: PSSL): PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_state_string_long';

function SSL_alert_desc_string_long_func(value : TIdC_INT) : PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_alert_desc_string_long';

function SSL_alert_type_string_long_func(value : TIdC_INT) : PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_alert_type_string_long';

function SSL_get_peer_certificate_func(s: PSSL): PX509 cdecl; external SSL_LIB_NAME name 'SSL_get_peer_certificate';

procedure SSL_CTX_set_verify_proc(ctx: PSSL_CTX; mode: TIdC_INT; callback: TSSL_CTX_set_verify_callback) cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_verify';

procedure SSL_CTX_set_verify_depth_proc(ctx: PSSL_CTX; depth: TIdC_INT) cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_verify_depth';

function SSL_CTX_get_verify_depth_func(ctx: PSSL_CTX): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_get_verify_depth';

procedure SSL_CTX_set_default_passwd_cb_proc(ctx: PSSL_CTX; cb: ppem_password_cb) cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_default_passwd_cb';

procedure SSL_CTX_set_default_passwd_cb_userdata_proc(ctx: PSSL_CTX; u: Pointer) cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_default_passwd_cb_userdata';

function SSL_CTX_check_private_key_func(ctx: PSSL_CTX): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_check_private_key';

function SSL_new_func(ctx: PSSL_CTX): PSSL cdecl; external SSL_LIB_NAME name 'SSL_new';

procedure SSL_free_proc(ssl: PSSL) cdecl; external SSL_LIB_NAME name 'SSL_free';

function SSL_accept_func(ssl: PSSL): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_accept';

function SSL_connect_func(ssl: PSSL): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_connect';

function SSL_read_func(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_read';

function SSL_peek_func(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_peek';

function SSL_pending_func(ssl : PSSL) : TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_pending';

function SSL_write_func(ssl: PSSL; const buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_write';

function SSL_ctrl_func(ssl : PSSL; cmd : TIdC_INT; larg : TIdC_LONG; parg : Pointer) : TIdC_LONG cdecl; external SSL_LIB_NAME name 'SSL_ctrl';

function SSL_callback_ctrl_func(ssl : PSSL; cmd : TIdC_INT; fp : SSL_callback_ctrl_fp) : TIdC_LONG cdecl; external SSL_LIB_NAME name 'SSL_callback_ctrl';

function SSL_CTX_ctrl_func(ssl: PSSL_CTX; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external SSL_LIB_NAME name 'SSL_CTX_ctrl';

function SSL_CTX_callback_ctrl_func(ssl : PSSL_CTX; cmd : TIdC_INT; fp : SSL_callback_ctrl_fp) : TIdC_LONG cdecl; external SSL_LIB_NAME name 'SSL_CTX_callback_ctrl';

function SSL_get_error_func(s: PSSL; ret_code: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_get_error';

{$IFNDEF OPENSSL_NO_SSL2}
function SSLv2_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv2_method';

function SSLv2_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv2_server_method';

function SSLv2_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv2_client_method';
{$ENDIF}

function SSLv3_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv3_method';

function SSLv3_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv3_server_method';

function SSLv3_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv3_client_method';

function SSLv23_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv23_method';

function SSLv23_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv23_server_method';

function SSLv23_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'SSLv23_client_method';

function TLSv1_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_method';

function TLSv1_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_server_method';

function TLSv1_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_client_method';

function TLSv1_1_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_1_method';

function TLSv1_1_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_1_server_method';

function TLSv1_1_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_1_client_method';

function TLSv1_2_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_2_method';

function TLSv1_2_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_2_server_method';

function TLSv1_2_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'TLSv1_2_client_method';

function DTLSv1_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'DTLSv1_method';

function DTLSv1_server_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'DTLSv1_server_method';

function DTLSv1_client_method_func: PSSL_METHOD cdecl; external SSL_LIB_NAME name 'DTLSv1_client_method';

function SSL_shutdown_func(s: PSSL): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_shutdown';

procedure SSL_set_connect_state_proc(s: PSSL) cdecl; external SSL_LIB_NAME name 'SSL_set_connect_state';

procedure SSL_set_accept_state_proc(s: PSSL) cdecl; external SSL_LIB_NAME name 'SSL_set_accept_state';

procedure SSL_set_shutdown_proc(ssl: PSSL; mode: TIdC_INT) cdecl; external SSL_LIB_NAME name 'SSL_set_shutdown';

function SSL_CTX_load_verify_locations_func(ctx: PSSL_CTX; const CAfile: PIdAnsiChar; const CApath: PIdAnsiChar): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_load_verify_locations';

function SSL_get_session_func(const ssl: PSSL): PSSL_SESSION cdecl; external SSL_LIB_NAME name 'SSL_get_session';

function SSLeay_add_ssl_algorithms_func: TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_library_init';

function SSL_SESSION_get_id_func(const s: PSSL_SESSION; length: PIdC_UINT): PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_SESSION_get_id';

procedure SSL_copy_session_id_proc(sslTo: PSSL; const sslFrom: PSSL) cdecl; external SSL_LIB_NAME name 'SSL_copy_session_id';

function SSLeay_version_func(_type : TIdC_INT) : PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'SSLeay_version';

function SSLeay_func: TIdC_ULONG cdecl; external SSLCLIB_LIB_name name 'SSLeay';

function d2i_X509_NAME_func(pr : PPX509_NAME; _in : PPByte; length : TIdC_LONG):PX509_NAME cdecl; external SSLCLIB_LIB_name name 'd2i_X509_NAME';

function i2d_X509_NAME_func(x : PX509_NAME; buf : PPByte) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509_NAME';

function X509_NAME_oneline_func(a: PX509_NAME; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'X509_NAME_oneline';

function X509_NAME_cmp_func(const a, b: PX509_NAME): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_NAME_cmp';

function X509_NAME_hash_func(x: PX509_NAME): TIdC_ULONG cdecl; external SSLCLIB_LIB_name name 'X509_NAME_hash';

function X509_set_issuer_name_func(x: PX509; name: PX509_NAME): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_issuer_name';

function X509_get_issuer_name_func(a: PX509): PX509_NAME cdecl; external SSLCLIB_LIB_name name 'X509_get_issuer_name';

function X509_set_subject_name_func(x: PX509; name: PX509_NAME): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_subject_name';

function X509_get_subject_name_func(a: PX509): PX509_NAME cdecl; external SSLCLIB_LIB_name name 'X509_get_subject_name';

function X509_digest_func(const data: PX509; const _type: PEVP_MD;
  md: PByte; var len: TIdC_UINT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_digest';

function X509_LOOKUP_ctrl_func(ctx : PX509_LOOKUP; cmd : TIdC_INT; argc : PIdAnsiChar; arg1 : TIdC_LONG; ret : PPIdAnsiChar) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_LOOKUP_ctrl';

function X509_STORE_add_cert_func(ctx : PX509_STORE; x : PX509) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_STORE_add_cert';

function X509_STORE_add_crl_func(ctx : PX509_STORE; x : PX509_CRL) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_STORE_add_crl';

function X509_STORE_CTX_get_ex_data_func(ctx: PX509_STORE_CTX; idx: TIdC_INT): Pointer cdecl; external SSLCLIB_LIB_name name 'X509_STORE_CTX_get_ex_data';

function X509_STORE_CTX_get_error_func(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_STORE_CTX_get_error';

procedure X509_STORE_CTX_set_error_proc(ctx: PX509_STORE_CTX; s: TIdC_INT) cdecl; external SSLCLIB_LIB_name name 'X509_STORE_CTX_set_error';

function X509_STORE_CTX_get_error_depth_func(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_STORE_CTX_get_error_depth';

function X509_STORE_CTX_get_current_cert_func(ctx: PX509_STORE_CTX): PX509 cdecl; external SSLCLIB_LIB_name name 'X509_STORE_CTX_get_current_cert';

function X509_STORE_add_lookup_func(v : PX509_STORE; m : PX509_LOOKUP_METHOD) : PX509_LOOKUP cdecl; external SSLCLIB_LIB_name name 'X509_STORE_add_lookup';

function X509_STORE_load_locations_func( ctx : PX509_STORE; const _file, path : PIdAnsiChar) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_STORE_load_locations';

function i2d_DSAPrivateKey_func(x: PDSA; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_DSAPrivateKey';

function d2i_DSAPrivateKey_func(pr : PDSA; _in : PPByte; len : TIdC_INT): PDSA cdecl; external SSLCLIB_LIB_name name 'd2i_DSAPrivateKey';

function d2i_PrivateKey_func(pr : PEVP_PKEY; _in : PPByte; len : TIdC_INT): PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'd2i_PrivateKey';

function d2i_PrivateKey_bio_func(bp : PBIO; a : PPEVP_PKEY) : PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'd2i_PrivateKey_bio';

function X509_sign_func(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_sign';

function X509_REQ_sign_func(x: PX509_REQ; pkey: PEVP_PKEY; const md: PEVP_MD): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_REQ_sign';

function X509_REQ_add_extensions_func(req: PX509_REQ; exts: PSTACK_OF_X509_EXTENSION): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_REQ_add_extensions';

function X509V3_EXT_conf_nid_func(conf: PLHASH; ctx: PX509V3_CTX; ext_nid: TIdC_INT; value: PIdAnsiChar): PX509_EXTENSION cdecl; external SSLCLIB_LIB_name name 'X509V3_EXT_conf_nid';

function X509_EXTENSION_create_by_NID_func(ex: PPX509_EXTENSION; nid: TIdC_INT;
  crit: TIdC_INT; data: PASN1_OCTET_STRING): PX509_EXTENSION cdecl; external SSLCLIB_LIB_name name 'X509_EXTENSION_create_by_NID';

procedure X509V3_set_ctx_proc(ctx: PX509V3_CTX; issuer, subject: PX509; req: PX509_REQ; crl: PX509_CRL; flags: TIdC_INT) cdecl; external SSLCLIB_LIB_name name 'X509V3_set_ctx';

procedure X509_EXTENSION_free_proc(ex: PX509_EXTENSION) cdecl; external SSLCLIB_LIB_name name 'X509_EXTENSION_free';

function X509_add_ext_func(cert: PX509; ext: PX509_EXTENSION; loc: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_add_ext';

{$IFNDEF OPENSSL_NO_BIO}
function X509_print_func(bp : PBIO; x : PX509) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_print';
{$ENDIF}

procedure RAND_cleanup_func; cdecl; external SSLCLIB_LIB_name name 'RAND_cleanup';

function RAND_bytes_func(buf : PIdAnsiChar; num : integer) : integer; cdecl; external SSLCLIB_LIB_name name 'RAND_bytes';

function RAND_pseudo_bytes_func(buf : PIdAnsiChar; num : integer) : integer; cdecl; external SSLCLIB_LIB_name name 'RAND_pseudo_bytes';

procedure RAND_seed_proc(buf : PIdAnsiChar; num : integer); cdecl; external SSLCLIB_LIB_name name 'RAND_seed';

procedure RAND_add_proc(buf : PIdAnsiChar; num : integer; entropy : integer); cdecl; external SSLCLIB_LIB_name name 'RAND_add';

function RAND_status_func: integer; cdecl; external SSLCLIB_LIB_name name 'RAND_status';

{$IFDEF SYS_WIN}
procedure RAND_screen_proc cdecl; external SSLCLIB_LIB_name name 'RAND_screen';

function RAND_event_func(iMsg : UINT; wp : wparam; lp : lparam) : integer; cdecl; external SSLCLIB_LIB_name name 'RAND_event';
{$ENDIF}

{$IFNDEF OPENSSL_NO_DES}
procedure DES_set_odd_parity_proc(key: Pdes_cblock) cdecl; external SSLCLIB_LIB_name name 'DES_set_odd_parity';

function DES_set_key_func(key: Pconst_DES_cblock; schedule: DES_key_schedule): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'DES_set_key';

procedure DES_ecb_encrypt_proc(input, output: Pconst_DES_cblock; ks: DES_key_schedule; enc: TIdC_INT) cdecl; external SSLCLIB_LIB_name name 'DES_ecb_encrypt';

//procedure Id_ossl_old_des_set_odd_parity_proc(key : p_ossl_old_des_cblock) cdecl; external SSLCLIB_LIB_name name 'Id_ossl_old_des_set_odd_parity';

//function Id_ossl_old_des_set_key_func(key : P_ossl_old_des_cblock; schedule : _ossl_old_des_key_schedule) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'Id_ossl_old_des_set_key';

//procedure Id_ossl_old_des_ecb_encrypt_proc( input : p_ossl_old_des_cblock; output : p_ossl_old_des_cblock; ks : p_ossl_old_des_key_schedule; enc : TIdC_int) cdecl; external SSLCLIB_LIB_name name 'Id_ossl_old_des_ecb_encrypt';
{$ENDIF}

function SSL_set_ex_data_func(ssl: PSSL; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_set_ex_data';

function SSL_get_ex_data_func(ssl: PSSL; idx: TIdC_INT): Pointer cdecl; external SSL_LIB_NAME name 'SSL_get_ex_data';

function SSL_load_client_CA_file_func(const _file: PIdAnsiChar): PSTACK_OF_X509_NAME cdecl; external SSL_LIB_NAME name 'SSL_load_client_CA_file';

procedure SSL_CTX_set_client_CA_list_proc(ctx: PSSL_CTX; list: PSTACK_OF_X509_NAME) cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_client_CA_list';

function SSL_CTX_set_default_verify_paths_func(ctx: PSSL_CTX): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_default_verify_paths';

function SSL_CTX_set_session_id_context_func(ctx: PSSL_CTX; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CTX_set_session_id_context';

function SSL_CIPHER_description_func(_para1: PSSL_CIPHER; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_CIPHER_description';

function SSL_get_current_cipher_func(const s: PSSL): PSSL_CIPHER cdecl; external SSL_LIB_NAME name 'SSL_get_current_cipher';

function SSL_CIPHER_get_name_func(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_CIPHER_get_name';

function SSL_CIPHER_get_version_func(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external SSL_LIB_NAME name 'SSL_CIPHER_get_version';

function SSL_CIPHER_get_bits_func(const c: PSSL_CIPHER; var alg_bits: TIdC_INT): TIdC_INT cdecl; external SSL_LIB_NAME name 'SSL_CIPHER_get_bits';

procedure CRYPTO_lock_proc(mode, _type : TIdC_INT; const _file : PIdAnsiChar; line : TIdC_INT) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_lock';

function CRYPTO_num_locks_func: TIdC_INT cdecl; external SSLCLIB_LIB_name name 'CRYPTO_num_locks';

procedure CRYPTO_set_locking_callback_proc(func: TIdSslLockingCallback) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_set_locking_callback';

function CRYPTO_THREADID_set_callback_func(threadid_func : TCRYPTO_THREADID_set_callback_threadid_func) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'CRYPTO_THREADID_set_callback';

procedure CRYPTO_THREADID_set_numeric_proc(id : PCRYPTO_THREADID; val : TIdC_ULONG) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_THREADID_set_numeric';

procedure CRYPTO_THREADID_set_pointer_proc(id : PCRYPTO_THREADID; ptr : Pointer) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_THREADID_set_pointer';

procedure ERR_put_error_proc(lib, func, reason : TIdC_INT; _file : PIdAnsiChar; line : TIdC_INT) cdecl; external SSLCLIB_LIB_name name 'ERR_put_error';

function ERR_get_error_func: TIdC_ULONG cdecl; external SSLCLIB_LIB_name name 'ERR_get_error';

function ERR_peek_error_func: TIdC_ULONG cdecl; external SSLCLIB_LIB_name name 'ERR_peek_error';

function ERR_peek_last_error_func: TIdC_ULONG cdecl; external SSLCLIB_LIB_name name 'ERR_peek_last_error';

procedure ERR_clear_error_proc cdecl; external SSLCLIB_LIB_name name 'ERR_clear_error';

function ERR_error_string_func(e: TIdC_ULONG; buf: PIdAnsiChar): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'ERR_error_string';

procedure ERR_error_string_n_proc(e: TIdC_ULONG; buf: PIdAnsiChar; len : size_t) cdecl; external SSLCLIB_LIB_name name 'ERR_error_string_n';

function ERR_lib_error_string_func(e : TIdC_ULONG): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'ERR_lib_error_string';

function ERR_func_error_string_func(e : TIdC_ULONG): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'ERR_func_error_string';

function ERR_reason_error_string_func(e : TIdC_ULONG): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'ERR_reason_error_string';

procedure ERR_load_ERR_strings_proc cdecl; external SSLCLIB_LIB_name name 'ERR_load_ERR_strings';

procedure ERR_load_crypto_strings_proc cdecl; external SSLCLIB_LIB_name name 'ERR_load_crypto_strings';

procedure ERR_free_strings_proc cdecl; external SSLCLIB_LIB_name name 'ERR_free_strings';

procedure ERR_remove_thread_state_proc(const tId : PCRYPTO_THREADID) cdecl; external SSLCLIB_LIB_name name 'ERR_remove_thread_state';

procedure CRYPTO_cleanup_all_ex_data_proc cdecl; external SSLCLIB_LIB_name name 'CRYPTO_cleanup_all_ex_data';

function SSL_COMP_get_compression_methods_func: PSTACK_OF_SSL_COMP cdecl; external SSL_LIB_NAME name 'SSL_COMP_get_compression_methods';

procedure SSL_COMP_free_compression_methods_func; cdecl; external SSL_LIB_NAME name 'SSL_COMP_free_compression_methods'

procedure sk_pop_free_proc(st: PSTACK; func: Tsk_pop_free_func) cdecl; external SSLCLIB_LIB_name name 'sk_pop_free';

procedure RSA_free_proc(rsa: PRSA) cdecl; external SSLCLIB_LIB_name name 'RSA_free';

function RSA_generate_key_func(bits: TIdC_INT; e: TIdC_ULONG; callback: TRSA_generate_key_callback; cb_arg: Pointer): PRSA cdecl; external SSLCLIB_LIB_name name 'RSA_generate_key';

function RSA_check_key_func(const rsa: PRSA): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'RSA_check_key';

function RSA_generate_key_ex_func(rsa : PRSA; bits : TIdC_INT; e : PBIGNUM; cb : PBN_GENCB) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'RSA_generate_key_ex';

function RSA_new_func: PRSA cdecl; external SSLCLIB_LIB_name name 'RSA_new';

function RSA_size_func(key: PRSA): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'RSA_size';

function RSA_private_decrypt_func(flen: TIdC_INT; from: PByte; _to: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'RSA_private_decrypt';

function RSA_public_encrypt_func(flen: TIdC_INT; from: PByte; _to: PByte; rsa: PRSA; padding: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'RSA_public_encrypt';

procedure DH_free_proc(dh: PDH) cdecl; external SSLCLIB_LIB_name name 'DH_free';

function BN_new_func: PBIGNUM cdecl; external SSLCLIB_LIB_name name 'BN_new';

procedure BN_free_proc(a: PBIGNUM) cdecl; external SSLCLIB_LIB_name name 'BN_free';

function BN_hex2bn_func(var n:PBIGNUM; const Str: PIdAnsiChar): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BN_hex2bn';

function BN_bn2hex_func(const n:PBIGNUM): PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'BN_bn2hex';

function BN_set_word_func(a: PBIGNUM; w: TIdC_ULONG): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BN_set_word';

function BIO_new_func(_type: PBIO_METHOD): PBIO cdecl; external SSLCLIB_LIB_name name 'BIO_new';

function BIO_free_func(bio: PBIO): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BIO_free';

function BIO_new_mem_buf_func(buf : Pointer; len : TIdC_INT) : PBIO cdecl; external SSLCLIB_LIB_name name 'BIO_new_mem_buf';

function BIO_s_mem_func: PBIO_METHOD cdecl; external SSLCLIB_LIB_name name 'BIO_s_mem';

function BIO_s_file_func: PBIO_METHOD cdecl; external SSLCLIB_LIB_name name 'BIO_s_file';

function BIO_ctrl_func(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external SSLCLIB_LIB_name name 'BIO_ctrl';

function BIO_int_ctrl_func(bp : PBIO; cmd : TIdC_INT; larg : TIdC_LONG; iArg : TIdC_INT) : TIdC_LONG cdecl; external SSLCLIB_LIB_name name 'BIO_int_ctrl';

function BIO_ptr_ctrl_func(bp : PBIO; cmd : TIdC_INT; larg : TIdC_LONG) : PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'BIO_ptr_ctrl';

function BIO_new_file_func(const filename: PIdAnsiChar; const mode: PIdAnsiChar): PBIO cdecl; external SSLCLIB_LIB_name name 'BIO_new_file';

function BIO_puts_func(b: PBIO; const txt: PIdAnsiChar): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BIO_puts';

function BIO_read_func(b: PBIO; data: Pointer; len: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BIO_read';

function BIO_write_func(b: PBIO; const buf: Pointer; len: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'BIO_write';

function i2d_X509_bio_func(bp: PBIO; x: PX509): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509_bio';

function i2d_PrivateKey_bio_func(b: PBIO; pkey: PEVP_PKEY): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_PrivateKey_bio';

function d2i_X509_bio_func(bp: PBIO; x: PPx509): PX509 cdecl; external SSLCLIB_LIB_name name 'd2i_X509_bio';

function i2d_X509_REQ_bio_func(x: PX509_REQ; bp: PBIO): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509_REQ_bio';

function i2d_PKCS7_func(x: PPKCS7; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_PKCS7';

function d2i_PKCS7_func(pr : PPKCS7; _in : PPByte; len : TIdC_INT): PPKCS7 cdecl; external SSLCLIB_LIB_name name 'd2i_PKCS7';

function i2d_X509_func(x: PX509;  buf: PPByte) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509';

function d2i_X509_func(pr : PX509; _in : PPByte; len : TIdC_INT): PX509 cdecl; external SSLCLIB_LIB_name name 'd2i_X509';

function i2d_X509_REQ_func(x: PX509_REQ;  buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509_REQ';

function d2i_X509_REQ_func(pr : PX509_REQ; _in : PPByte; len : TIdC_INT): PX509_REQ cdecl; external SSLCLIB_LIB_name name 'd2i_X509_REQ';

function i2d_X509_CRL_func(x: PX509_CRL; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_X509_CRL';

function d2i_X509_CRL_func(pr : PX509_CRL; _in : PPByte; len : TIdC_INT): PX509_REQ cdecl; external SSLCLIB_LIB_name name 'd2i_X509_CRL';

function i2d_RSAPrivateKey_func(x: PRSA; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_RSAPrivateKey';

function d2i_RSAPrivateKey_func(pr : PRSA; _in : PPByte; len : TIdC_INT): PRSA cdecl; external SSLCLIB_LIB_name name 'd2i_RSAPrivateKey';

function i2d_RSAPublicKey_func(x: PRSA; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_RSAPublicKey';

function d2i_RSAPublicKey_func(pr : PRSA; _in : PPByte; len : TIdC_INT): PRSA cdecl; external SSLCLIB_LIB_name name 'd2i_RSAPublicKey';

function i2d_PrivateKey_func(x: PEVP_PKEY; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_PrivateKey';

function i2d_DSAparams_func(x: PDSA; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_DSAparams';

function d2i_DSAparams_func(pr : PDSA; _in : PPByte; len : TIdC_INT): PDSA cdecl; external SSLCLIB_LIB_name name 'd2i_DSAparams';

function i2d_DHparams_func(x: PDH; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_DHparams';

function d2i_DHparams_func(pr : PDH; _in : PPByte; len : TIdC_INT): PDH cdecl; external SSLCLIB_LIB_name name 'd2i_DHparams';

function i2d_NETSCAPE_CERT_SEQUENCE_func(x: PNETSCAPE_CERT_SEQUENCE; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_NETSCAPE_CERT_SEQUENCE';

function d2i_NETSCAPE_CERT_SEQUENCE_func(pr : PNETSCAPE_CERT_SEQUENCE; _in : PPByte; len : TIdC_INT): PNETSCAPE_CERT_SEQUENCE cdecl; external SSLCLIB_LIB_name name 'd2i_NETSCAPE_CERT_SEQUENCE';

function i2d_PUBKEY_func(x: PEVP_PKEY; buf: PPByte): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_PUBKEY';

function d2i_PUBKEY_func(pr : PEVP_PKEY; _in : PPByte; len : TIdC_INT): PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'd2i_PUBKEY';

function X509_get_default_cert_file_func: PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'X509_get_default_cert_file';

function X509_get_default_cert_file_env_func: PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'X509_get_default_cert_file_env';

function X509_new_func: PX509 cdecl; external SSLCLIB_LIB_name name 'X509_new';

procedure X509_free_proc(x: PX509) cdecl; external SSLCLIB_LIB_name name 'X509_free';

function X509_REQ_new_func: PX509_REQ cdecl; external SSLCLIB_LIB_name name 'X509_REQ_new';

procedure X509_REQ_free_proc(x:PX509_REQ) cdecl; external SSLCLIB_LIB_name name 'X509_REQ_free';

function X509_to_X509_REQ_func(x: PX509; pkey: PEVP_PKEY; const md: PEVP_MD): PX509_REQ cdecl; external SSLCLIB_LIB_name name 'X509_to_X509_REQ';

function X509_NAME_new_func: PX509_NAME cdecl; external SSLCLIB_LIB_name name 'X509_NAME_new';

procedure X509_NAME_free_proc(x:PX509_NAME) cdecl; external SSLCLIB_LIB_name name 'X509_NAME_free';

function X509_NAME_add_entry_by_txt_func(name: PX509_NAME; const field: PIdAnsiChar; _type: TIdC_INT;
  const bytes: PIdAnsiChar; len, loc, _set: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_NAME_add_entry_by_txt';

procedure X509_INFO_free_proc(a : PX509_INFO) cdecl; external SSLCLIB_LIB_name name 'X509_INFO_free';

function X509_set_version_func(x: PX509; version: TIdC_LONG): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_version';

function X509_get_serialNumber_func(x: PX509): PASN1_INTEGER cdecl; external SSLCLIB_LIB_name name 'X509_get_serialNumber';

function X509_gmtime_adj_func(s: PASN1_TIME; adj: TIdC_LONG): PASN1_TIME cdecl; external SSLCLIB_LIB_name name 'X509_gmtime_adj';

function X509_set_notBefore_func(x: PX509; tm: PASN1_TIME): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_notBefore';

function X509_set_notAfter_func(x: PX509; tm: PASN1_TIME): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_notAfter';

function X509_set_pubkey_func(x: PX509; pkey: PEVP_PKEY): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_set_pubkey';

function X509_REQ_set_pubkey_func(x: PX509_REQ; pkey: PEVP_PKEY): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_REQ_set_pubkey';

function X509_PUBKEY_get_func(key: PX509_PUBKEY): PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'X509_PUBKEY_get';

function X509_verify_func(x509: PX509; pkey: PEVP_PKEY): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'X509_verify';

{$IFNDEF SSLEAY_MACROS}
function PEM_read_bio_X509_func(bp: PBIO; x: PPX509; cb: ppem_password_cb; u: Pointer): PX509 cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_X509';

function PEM_read_bio_X509_REQ_func(bp :PBIO; x : PPX509_REQ; cb :ppem_password_cb; u: PIdAnsiChar) : PX509_REQ cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_X509_REQ';

function PEM_read_bio_X509_CRL_func(bp : PBIO; x : PPX509_CRL;cb : ppem_password_cb; u: Pointer) : PX509_CRL cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_X509_CRL';

function PEM_read_bio_RSAPrivateKey_func(bp : PBIO; x : PPRSA; cb : ppem_password_cb; u: Pointer) : PRSA cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_RSAPrivateKey';

function PEM_read_bio_RSAPublicKey_func(bp : PBIO; x : PPRSA; cb : ppem_password_cb; u: Pointer) : PRSA cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_RSAPublicKey';

function PEM_read_bio_DSAPrivateKey_func(bp : PBIO; x : PPDSA; cb : ppem_password_cb; u : Pointer) : PDSA cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_DSAPrivateKey';

function PEM_read_bio_PrivateKey_func(bp : PBIO; x : PPEVP_PKEY; cb : ppem_password_cb; u : Pointer) : PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_PrivateKey';

function PEM_read_bio_PKCS7_func(bp : PBIO; x : PPPKCS7; cb : ppem_password_cb; u : Pointer) : PPKCS7 cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_PKCS7';

function PEM_read_bio_DHparams_func(bp : PBIO; x : PPDH; cb : ppem_password_cb; u : Pointer) : PDH cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_DHparams';

function PEM_read_bio_DSAparams_func(bp : PBIO; x : PPDSA; cb : ppem_password_cb; u : Pointer) : PDSA cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_DSAparams';

function PEM_read_bio_NETSCAPE_CERT_SEQUENCE_func(bp : PBIO; x : PPNETSCAPE_CERT_SEQUENCE;
  cb : ppem_password_cb; u : Pointer) : PNETSCAPE_CERT_SEQUENCE cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_NETSCAPE_CERT_SEQUENCE';

function PEM_read_bio_PUBKEY_func(bp : PBIO; x : PPEVP_PKEY; cb : ppem_password_cb; u : Pointer) : PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_PUBKEY';

function PEM_write_bio_X509_func(b: PBIO; x: PX509): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_X509';

function PEM_write_bio_X509_REQ_func(bp: PBIO; x: PX509_REQ): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_X509_REQ';

function PEM_write_bio_X509_CRL_func(bp : PBIO; x : PX509_CRL) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_X509_CRL';

function PEM_write_bio_RSAPrivateKey_func(bp : PBIO; x : PRSA; const enc : PEVP_CIPHER;
  kstr : PIdAnsiChar; klen : TIdC_INT; cb : Ppem_password_cb; u : Pointer) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_RSAPrivateKey';

function PEM_write_bio_RSAPublicKey_func(bp : PBIO; x : PRSA) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_RSAPublicKey';

function PEM_write_bio_DSAPrivateKey_func(bp : PBIO; x : PDSA; const enc : PEVP_CIPHER;
  kstr : PIdAnsiChar; klen : TIdC_INT; cb : Ppem_password_cb; u : Pointer) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_DSAPrivateKey';

function PEM_write_bio_PrivateKey_func(bp : PBIO; x : PEVP_PKEY; const enc : PEVP_CIPHER;
  kstr : PIdAnsiChar; klen : TIdC_INT; cb : Ppem_password_cb; u : Pointer) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_PrivateKey';

function PEM_write_bio_PKCS7_func(bp : PBIO; x : PPKCS7) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_PKCS7';

function PEM_write_bio_DHparams_func(bp : PBIO; x : PDH): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_DHparams';

function PEM_write_bio_DSAparams_func(bp : PBIO; x : PDSA) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_DSAparams';

function PEM_write_bio_NETSCAPE_CERT_SEQUENCE_func(bp : PBIO; x : PDSA) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_NETSCAPE_CERT_SEQUENCE';

function PEM_write_bio_PKCS8PrivateKey_func(bp: PBIO; key: PEVP_PKEY; enc: PEVP_CIPHER;
  kstr: PIdAnsiChar; klen: TIdC_INT; cb: ppem_password_cb; u: Pointer): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_PKCS8PrivateKey';

function PEM_write_bio_PUBKEY_func(bp: PBIO; x: PEVP_PKEY): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_write_bio_PUBKEY';
{$ELSE}
function PEM_ASN1_write_bio_func(i2d: i2d_of_void; const name: PIdAnsiChar;
  bp: PBIO; x: PIdAnsiChar; const enc: PEVP_CIPHER; kstr: PIdAnsiChar; klen: TIdC_INT;
  cb: ppem_password_cb; u: Pointer):TIdC_INT cdecl; external SSLCLIB_LIB_name name 'PEM_ASN1_write_bio';

function PEM_ASN1_read_bio_func(d2i: d2i_OF_void; name: PIdAnsiChar; bp: PBIO;
  x: PPointer; cb: ppem_password_cb; u:Pointer): Pointer cdecl; external SSLCLIB_LIB_name name 'PEM_ASN1_read_bio';
{$ENDIF}

function PEM_X509_INFO_read_bio_func(bp : PBIO; sk : PSTACK_OF_X509_INFO;
  cb : ppem_password_cb; u : Pointer) : PSTACK_OF_X509_INFO cdecl; external SSLCLIB_LIB_name name 'PEM_X509_INFO_read_bio';

function PEM_read_bio_X509_AUX_func(bp : PBIO; x : PPX509;
  cb : ppem_password_cb; u : Pointer) : PX509 cdecl; external SSLCLIB_LIB_name name 'PEM_read_bio_X509_AUX';

{$IFNDEF OPENSSL_NO_DES}
function EVP_des_ede3_cbc_func: PEVP_CIPHER cdecl; external SSLCLIB_LIB_name name 'EVP_des_ede3_cbc';
{$ENDIF}

{$IFNDEF OPENSSL_NO_SHA512}
function EVP_sha512_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_sha512';

function EVP_sha384_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_sha384';
{$ENDIF}

{$IFNDEF OPENSSL_NO_SHA256}
function EVP_sha256_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_sha256';

function EVP_sha224_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_sha224';
{$ENDIF}

{$IFNDEF OPENSSL_NO_SHA}
function EVP_sha1_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_sha1';
{$ENDIF}

{$IFNDEF OPENSSL_NO_MD5}
function EVP_md5_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_md5';
{$ENDIF}

{$IFNDEF OPENSSL_NO_MD4}
function EVP_md4_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_md4';
{$ENDIF}

//{$IFNDEF OPENSSL_NO_MD2}
//function EVP_md2_func: PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_md2';
//{$ENDIF}

procedure EVP_MD_CTX_init_proc(ctx : PEVP_MD_CTX) cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_init';

function EVP_MD_CTX_cleanup_func(ctx : PEVP_MD_CTX) : TIdC_Int cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_cleanup';

function EVP_MD_CTX_create_func : PEVP_MD_CTX cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_create';

procedure EVP_MD_CTX_destroy_proc(ctx : PEVP_MD_CTX) cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_destroy';

function EVP_MD_CTX_copy_func(_out : PEVP_MD_CTX; _in: PEVP_MD_CTX) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_copy';

function EVP_MD_CTX_copy_ex_func(_out : PEVP_MD_CTX; const _in: PEVP_MD_CTX) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'EVP_MD_CTX_copy_ex';

function  EVP_DigestInit_ex_func(ctx : PEVP_MD_CTX; const AType : PEVP_MD; impl : PENGINE) : TIdC_Int cdecl; external SSLCLIB_LIB_name name 'EVP_DigestInit_ex';

function  EVP_DigestUpdate_func(ctx : PEVP_MD_CTX; d : Pointer; cnt : size_t) : TIdC_Int cdecl; external SSLCLIB_LIB_name name 'EVP_DigestUpdate';

function EVP_DigestFinal_ex_func(ctx : PEVP_MD_CTX; md : PIdAnsiChar; var s : TIdC_UInt) : TIdC_Int cdecl; external SSLCLIB_LIB_name name 'EVP_DigestFinal_ex';

function EVP_PKEY_type_func(_type : TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'EVP_PKEY_type';

function EVP_PKEY_new_func: PEVP_PKEY cdecl; external SSLCLIB_LIB_name name 'EVP_PKEY_new';

procedure EVP_PKEY_free_proc(pkey: PEVP_PKEY) cdecl; external SSLCLIB_LIB_name name 'EVP_PKEY_free';

function EVP_PKEY_assign_func(pkey: PEVP_PKEY; _type: TIdC_INT; key: PIdAnsiChar): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'EVP_PKEY_assign';

function EVP_get_digestbyname_func(const name: PIdAnsiChar): PEVP_MD cdecl; external SSLCLIB_LIB_name name 'EVP_get_digestbyname';

{$IFNDEF OPENSSL_NO_HMAC}
procedure HMAC_CTX_init_proc(ctx : PHMAC_CTX) cdecl; external SSLCLIB_LIB_name name 'HMAC_CTX_init';

function HMAC_Init_ex_func(ctx : PHMAC_CTX; key : Pointer; len : TIdC_INT;
  md : PEVP_MD; impl : PENGINE) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'HMAC_Init_ex';

function HMAC_Update_func(ctx : PHMAC_CTX; data : PIdAnsiChar; len : size_t) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'HMAC_Update';

function HMAC_Final_func(ctx : PHMAC_CTX; md : PIdAnsiChar; len : PIdC_UINT) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'HMAC_Final';

procedure HMAC_CTX_cleanup_proc(ctx : PHMAC_CTX) cdecl; external SSLCLIB_LIB_name name 'HMAC_CTX_cleanup';
{$ENDIF}

function  OBJ_obj2nid_func(const o: PASN1_OBJECT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'OBJ_obj2nid';

function  OBJ_nid2obj_func(n : TIdC_INT) : PASN1_OBJECT cdecl; external SSLCLIB_LIB_name name 'OBJ_nid2obj';

function  OBJ_nid2ln_func(n : TIdC_INT) : PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'OBJ_nid2ln';

function  OBJ_nid2sn_func(n : TIdC_INT) : PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'OBJ_nid2sn';

function ASN1_INTEGER_set_func(a: PASN1_INTEGER; v: TIdC_LONG): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'ASN1_INTEGER_set';

function ASN1_INTEGER_get_func(a: PASN1_INTEGER) : TIdC_LONG cdecl; external SSLCLIB_LIB_name name 'ASN1_INTEGER_get';

function ASN1_STRING_type_new_func(_type: TIdC_INT): PASN1_STRING cdecl; external SSLCLIB_LIB_name name 'ASN1_STRING_type_new';

procedure ASN1_STRING_free_proc(a: PASN1_STRING) cdecl; external SSLCLIB_LIB_name name 'ASN1_STRING_free';

function ASN1_dup_func(i2d : i2d_of_void; d2i : d2i_of_void; x : PIdAnsiChar) : Pointer cdecl; external SSLCLIB_LIB_name name 'ASN1_dup';

function CRYPTO_set_mem_functions_func(
  m: TCRYPTO_set_mem_functions_m;
  r: TCRYPTO_set_mem_functions_r;
  f: TCRYPTO_set_mem_functions_f): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'CRYPTO_set_mem_functions';

function CRYPTO_malloc_func(num: TIdC_INT; const _file: PIdAnsiChar; line: TIdC_INT): Pointer cdecl; external SSLCLIB_LIB_name name 'CRYPTO_malloc';

procedure CRYPTO_free_proc(ptr : Pointer) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_free';

procedure CRYPTO_mem_leaks_proc(b:PBIO) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_mem_leaks';

function CRYPTO_mem_ctrl_func(mode: TIdC_INT): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'CRYPTO_mem_ctrl';

procedure CRYPTO_set_mem_debug_functions_proc(
  m: Tset_mem_debug_functions_m;
  r: Tset_mem_debug_functions_r;
  f : Tset_mem_debug_functions_f;
  so : Tset_mem_debug_functions_so;
  go : Tset_mem_debug_functions_go) cdecl; external SSLCLIB_LIB_name name 'CRYPTO_set_mem_debug_functions';

function PKCS12_create_func(pass, name: PIdAnsiChar; pkey: PEVP_PKEY; cert : PX509;
  ca: PSTACK_OF_X509; nid_key, nid_cert, iter, mac_iter, keytype : TIdC_INT) : PPKCS12 cdecl; external SSLCLIB_LIB_name name 'PKCS12_create';

function i2d_PKCS12_bio_func(b: PBIO; p12: PPKCS12) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'i2d_PKCS12_bio';

procedure PKCS12_free_proc(p12: PPKCS12) cdecl; external SSLCLIB_LIB_name name 'PKCS12_free';

//procedure OpenSSL_add_all_algorithms_proc cdecl; external SSLCLIB_LIB_name name 'OpenSSL_add_all_algorithms';

procedure OpenSSL_add_all_ciphers_proc cdecl; external SSLCLIB_LIB_name name 'OpenSSL_add_all_ciphers';

procedure OpenSSL_add_all_digests_proc cdecl; external SSLCLIB_LIB_name name 'OpenSSL_add_all_digests';

procedure EVP_cleanup_proc cdecl; external SSLCLIB_LIB_name name 'EVP_cleanup';

function sk_num_func(const x : PSTACK) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'sk_num';

function sk_new_func( cmp : Tsk_new_cmp) : PStack cdecl; external SSLCLIB_LIB_name name 'sk_new';

function sk_new_null_func: PSTACK cdecl; external SSLCLIB_LIB_name name 'sk_new_null';

procedure sk_free_proc(st : PSTACK) cdecl; external SSLCLIB_LIB_name name 'sk_free';

function sk_push_func(st: PSTACK; data: PIdAnsiChar): TIdC_INT cdecl; external SSLCLIB_LIB_name name 'sk_push';

function sk_dup_func(st : PSTACK) : PSTACK cdecl; external SSLCLIB_LIB_name name 'sk_dup';

function sk_find_func(st : PSTACK; Data : PIdAnsiChar) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'sk_find';

function sk_value_func(x : PSTACK; i : TIdC_INT) : PIdAnsiChar cdecl; external SSLCLIB_LIB_name name 'sk_value';

{$IFDEF OPENSSL_FIPS}
//function FIPS_mode_set_func(onoff : TIdC_INT) : TIdC_INT cdecl; external SSLCLIB_LIB_name name 'FIPS_mode_set';

//function FIPS_mode_func: TIdC_INT cdecl; external SSLCLIB_LIB_name name 'FIPS_mode';
{$ENDIF}

procedure LoadSymbols;
begin
  SSL_CTX_set_cipher_list := SSL_CTX_set_cipher_list_func;
  SSL_CTX_new := SSL_CTX_new_func;
  SSL_CTX_free := SSL_CTX_free_proc;
  SSL_set_fd := SSL_set_fd_func;
  SSL_CTX_use_PrivateKey_file := SSL_CTX_use_PrivateKey_file_func;
  SSL_CTX_use_PrivateKey := SSL_CTX_use_PrivateKey_func;
  SSL_CTX_use_certificate := SSL_CTX_use_certificate_func;
  SSL_CTX_use_certificate_file := SSL_CTX_use_certificate_file_func;
  SSL_load_error_strings := SSL_load_error_strings_proc;
  SSL_state_string_long := SSL_state_string_long_func;
  SSL_alert_desc_string_long := SSL_alert_desc_string_long_func;
  SSL_alert_type_string_long := SSL_alert_type_string_long_func;

  SSL_get_peer_certificate := SSL_get_peer_certificate_func;
  SSL_CTX_set_verify := SSL_CTX_set_verify_proc;
  SSL_CTX_set_verify_depth := SSL_CTX_set_verify_depth_proc;
  SSL_CTX_get_verify_depth := SSL_CTX_get_verify_depth_func;
  SSL_CTX_set_default_passwd_cb := SSL_CTX_set_default_passwd_cb_proc;
  SSL_CTX_set_default_passwd_cb_userdata:= SSL_CTX_set_default_passwd_cb_userdata_proc;
  SSL_CTX_check_private_key := SSL_CTX_check_private_key_func;
  SSL_new := SSL_new_func;
  SSL_free := SSL_free_proc;
  SSL_accept := SSL_accept_func;
  SSL_connect := SSL_connect_func;
  SSL_read := SSL_read_func;
  SSL_peek := SSL_peek_func;
  SSL_pending := SSL_pending_func;
  SSL_write := SSL_write_func;
  SSL_ctrl := SSL_ctrl_func;
  SSL_callback_ctrl := SSL_callback_ctrl_func;
  SSL_CTX_ctrl := SSL_CTX_ctrl_func;
  SSL_CTX_callback_ctrl := SSL_CTX_callback_ctrl_func;
  SSL_get_error := SSL_get_error_func;
  {$IFNDEF OPENSSL_NO_SSL2}
  SSLv2_method := SSLv2_method_func;
  SSLv2_server_method := SSLv2_server_method_func;
  SSLv2_client_method := SSLv2_client_method_func;
  {$ELSE}
  SSLv2_method := nil;
  SSLv2_server_method := nil;
  SSLv2_client_method := nil;
  {$ENDIF}
  SSLv3_method := SSLv3_method_func;
  SSLv3_server_method := SSLv3_server_method_func;
  SSLv3_client_method := SSLv3_client_method_func;
  SSLv23_method := SSLv23_method_func;
  SSLv23_server_method := SSLv23_server_method_func;
  SSLv23_client_method := SSLv23_client_method_func;
  TLSv1_method := TLSv1_method_func;
  TLSv1_server_method := TLSv1_server_method_func;
  TLSv1_client_method := TLSv1_client_method_func;
  TLSv1_1_method := TLSv1_1_method_func;
  TLSv1_1_server_method := TLSv1_1_server_method_func;
  TLSv1_1_client_method := TLSv1_1_client_method_func;
  TLSv1_2_method := TLSv1_2_method_func;
  TLSv1_2_server_method := TLSv1_2_server_method_func;
  TLSv1_2_client_method := TLSv1_2_client_method_func;
  DTLSv1_method := DTLSv1_method_func;
  DTLSv1_server_method := DTLSv1_server_method_func;
  DTLSv1_client_method := DTLSv1_client_method_func;
  SSL_shutdown := SSL_shutdown_func;
  SSL_set_connect_state := SSL_set_connect_state_proc;
  SSL_set_accept_state := SSL_set_accept_state_proc;
  SSL_set_shutdown := SSL_set_shutdown_proc;
  SSL_CTX_load_verify_locations := SSL_CTX_load_verify_locations_func;
  SSL_get_session := SSL_get_session_func;
  SSLeay_add_ssl_algorithms := SSLeay_add_ssl_algorithms_func;
  SSL_SESSION_get_id := SSL_SESSION_get_id_func;
  SSL_copy_session_id := SSL_copy_session_id_proc;
   // CRYPTO LIB
  _SSLeay_version := SSLeay_version_func;
  SSLeay := SSLeay_func;
  d2i_X509_NAME := d2i_X509_NAME_func;
  i2d_X509_NAME := i2d_X509_NAME_func;
  X509_NAME_oneline := X509_NAME_oneline_func;
  X509_NAME_cmp := X509_NAME_cmp_func;
  X509_NAME_hash := X509_NAME_hash_func;
  X509_set_issuer_name := X509_set_issuer_name_func;
  X509_get_issuer_name := X509_get_issuer_name_func;
  X509_set_subject_name := X509_set_subject_name_func;
  X509_get_subject_name := X509_get_subject_name_func;
  X509_digest := X509_digest_func;
  X509_LOOKUP_ctrl := X509_LOOKUP_ctrl_func;
  X509_STORE_add_cert := X509_STORE_add_cert_func;
  X509_STORE_add_crl := X509_STORE_add_crl_func;
  X509_STORE_CTX_get_ex_data := X509_STORE_CTX_get_ex_data_func;
  X509_STORE_CTX_get_error := X509_STORE_CTX_get_error_func;
  X509_STORE_CTX_set_error := X509_STORE_CTX_set_error_proc;
  X509_STORE_CTX_get_error_depth := X509_STORE_CTX_get_error_depth_func;
  X509_STORE_CTX_get_current_cert := X509_STORE_CTX_get_current_cert_func;
  X509_STORE_add_lookup := X509_STORE_add_lookup_func;
  X509_STORE_load_locations := X509_STORE_load_locations_func;
  i2d_DSAPrivateKey := i2d_DSAPrivateKey_func;
  d2i_DSAPrivateKey := d2i_DSAPrivateKey_func;
  d2i_PrivateKey := d2i_PrivateKey_func;
  d2i_PrivateKey_bio := d2i_PrivateKey_bio_func;
  X509_sign := X509_sign_func;
  X509_REQ_sign := X509_REQ_sign_func;
  X509_REQ_add_extensions := X509_REQ_add_extensions_func;
  X509V3_EXT_conf_nid := X509V3_EXT_conf_nid_func;
  X509_EXTENSION_create_by_NID := X509_EXTENSION_create_by_NID_func;
  X509V3_set_ctx := X509V3_set_ctx_proc;
  X509_EXTENSION_free := X509_EXTENSION_free_proc;
  X509_add_ext := X509_add_ext_func;
  {$IFNDEF OPENSSL_NO_BIO}
  //X509_print
  X509_print := X509_print_func;
  {$ENDIF}
//  _RAND_cleanup := RAND_cleanup_func;
//  _RAND_bytes := RAND_bytes_func;
//  _RAND_pseudo_bytes := RAND_pseudo_bytes_func;
//  _RAND_seed := RAND_seed_proc;
//  _RAND_add := RAND_add_proc;
//  _RAND_status := RAND_status_func;
  {$IFDEF SYS_WIN}
  _RAND_screen := RAND_screen_proc;
  _RAND_event := RAND_event_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_DES}
  // 3DES
  DES_set_odd_parity := DES_set_odd_parity_proc;
  DES_set_key := DES_set_key_func;
  DES_ecb_encrypt := DES_ecb_encrypt_proc;
//  Id_ossl_old_des_set_odd_parity := Id_ossl_old_des_set_odd_parity_proc;
//  Id_ossl_old_des_set_key := Id_ossl_old_des_set_key_func;
//  Id_ossl_old_des_ecb_encrypt := Id_ossl_old_des_ecb_encrypt_proc;
  {$ENDIF}
  // More SSL functions
  SSL_set_ex_data := SSL_set_ex_data_func;
  SSL_get_ex_data := SSL_get_ex_data_func;
  SSL_load_client_CA_file := SSL_load_client_CA_file_func;
  SSL_CTX_set_client_CA_list := SSL_CTX_set_client_CA_list_proc;
  SSL_CTX_set_default_verify_paths := SSL_CTX_set_default_verify_paths_func;
  SSL_CTX_set_session_id_context := SSL_CTX_set_session_id_context_func;
  SSL_CIPHER_description := SSL_CIPHER_description_func;
  SSL_get_current_cipher := SSL_get_current_cipher_func;
  SSL_CIPHER_get_name := SSL_CIPHER_get_name_func;
  SSL_CIPHER_get_version := SSL_CIPHER_get_version_func;
  SSL_CIPHER_get_bits  := SSL_CIPHER_get_bits_func;
  // Thread safe
  _CRYPTO_lock := CRYPTO_lock_proc;
  _CRYPTO_num_locks := CRYPTO_num_locks_func;
  CRYPTO_set_locking_callback := CRYPTO_set_locking_callback_proc;
  {$IFNDEF WIN32_OR_WIN64}
{
In OpenSSL 1.0.0, you should use these callback functions instead of the
depreciated set_id_callback.  They are not in the older 0.9.8 OpenSSL series so
we have to handle both cases.
}
  CRYPTO_THREADID_set_callback := CRYPTO_THREADID_set_callback_func;
  CRYPTO_THREADID_set_numeric := CRYPTO_THREADID_set_numeric_proc;
  CRYPTO_THREADID_set_pointer := CRYPTO_THREADID_set_pointer_proc;  {Do not localize}
//  if not assigned(CRYPTO_THREADID_set_callback) then begin
//    @CRYPTO_set_id_callback := LoadFunctionCLib(fn_CRYPTO_set_id_callback);
//  end;
  {$ENDIF}
  ERR_put_error := ERR_put_error_proc;
  ERR_get_error := ERR_get_error_func;
  ERR_peek_error := ERR_peek_error_func;
  ERR_peek_last_error := ERR_peek_last_error_func;
  ERR_clear_error := ERR_clear_error_proc;
  ERR_error_string := ERR_error_string_func;
  ERR_error_string_n := ERR_error_string_n_proc;
  ERR_lib_error_string := ERR_lib_error_string_func;
  ERR_func_error_string := ERR_func_error_string_func;
  ERR_reason_error_string := ERR_reason_error_string_func;
  ERR_load_ERR_strings := ERR_load_ERR_strings_proc;
  ERR_load_crypto_strings := ERR_load_crypto_strings_proc;
  ERR_free_strings := ERR_free_strings_proc;
  ERR_remove_thread_state := ERR_remove_thread_state_proc;
//  if not Assigned(ERR_remove_thread_state) then begin
//    @ERR_remove_state := LoadFunctionCLib(fn_ERR_remove_state);
//  end;
  CRYPTO_cleanup_all_ex_data := CRYPTO_cleanup_all_ex_data_proc;
  SSL_COMP_get_compression_methods := SSL_COMP_get_compression_methods_func;
  SSL_COMP_free_compression_methods := SSL_COMP_free_compression_methods_func;
  sk_pop_free := sk_pop_free_proc;
  //RSA
  RSA_free := RSA_free_proc;
  RSA_generate_key := RSA_generate_key_func;
  RSA_check_key := RSA_check_key_func;
  RSA_generate_key_ex := RSA_generate_key_ex_func;
  RSA_new := RSA_new_func;
  RSA_size := RSA_size_func;
  RSA_private_decrypt := RSA_private_decrypt_func;
  RSA_public_encrypt := RSA_public_encrypt_func;
  //DH
  DH_free := DH_free_proc;
  //BN
  BN_new := BN_new_func;
  BN_free := BN_free_proc;
  BN_hex2bn := BN_hex2bn_func;
  BN_bn2hex := BN_bn2hex_func;
  BN_set_word := BN_set_word_func;
  //BIO
  BIO_new := BIO_new_func;
  BIO_free := BIO_free_func;
  BIO_new_mem_buf := BIO_new_mem_buf_func;
  BIO_s_mem := BIO_s_mem_func;
  BIO_s_file := BIO_s_file_func;
  BIO_ctrl := BIO_ctrl_func;
  BIO_int_ctrl := BIO_int_ctrl_func;
  BIO_ptr_ctrl := BIO_ptr_ctrl_func;
  BIO_new_file := BIO_new_file_func;
  BIO_puts := BIO_puts_func;
  BIO_read := BIO_read_func;
  BIO_write := BIO_write_func;
  //i2d
  i2d_X509_bio := i2d_X509_bio_func;
  i2d_PrivateKey_bio := i2d_PrivateKey_bio_func;
  d2i_X509_bio := d2i_X509_bio_func;
  i2d_X509_REQ_bio := i2d_X509_REQ_bio_func;
  i2d_PKCS7 := i2d_PKCS7_func;
  d2i_PKCS7 := d2i_PKCS7_func;
  i2d_X509 := i2d_X509_func;
  d2i_X509 := d2i_X509_func;
  i2d_X509_REQ := i2d_X509_REQ_func;
  d2i_X509_REQ := d2i_X509_REQ_func;
  i2d_X509_CRL := i2d_X509_CRL_func;
  d2i_X509_CRL := d2i_X509_CRL_func;
  i2d_RSAPrivateKey := i2d_RSAPrivateKey_func;
  d2i_RSAPrivateKey := d2i_RSAPrivateKey_func;
  i2d_RSAPublicKey := i2d_RSAPublicKey_func;
  d2i_RSAPublicKey := d2i_RSAPublicKey_func;
  i2d_PrivateKey := i2d_PrivateKey_func;
  d2i_PrivateKey := d2i_PrivateKey_func;

  i2d_DSAparams := i2d_DSAparams_func;
  d2i_DSAparams := d2i_DSAparams_func;
  i2d_DHparams := i2d_DHparams_func;
  d2i_DHparams := d2i_DHparams_func;
  i2d_NETSCAPE_CERT_SEQUENCE := i2d_NETSCAPE_CERT_SEQUENCE_func;
  d2i_NETSCAPE_CERT_SEQUENCE := d2i_NETSCAPE_CERT_SEQUENCE_func;
  i2d_PUBKEY := i2d_PUBKEY_func;
  d2i_PUBKEY := d2i_PUBKEY_func;

  //X509
  X509_get_default_cert_file := X509_get_default_cert_file_func;
  X509_get_default_cert_file_env := X509_get_default_cert_file_env_func;
  X509_new := X509_new_func;
  X509_free := X509_free_proc;
  X509_REQ_new := X509_REQ_new_func;
  X509_REQ_free := X509_REQ_free_proc;
  X509_to_X509_REQ := X509_to_X509_REQ_func;
  X509_NAME_new := X509_NAME_new_func;
  X509_NAME_free := X509_NAME_free_proc;
  X509_NAME_add_entry_by_txt := X509_NAME_add_entry_by_txt_func;
  X509_INFO_free := X509_INFO_free_proc;
  X509_set_version := X509_set_version_func;
  X509_get_serialNumber := X509_get_serialNumber_func;
  X509_gmtime_adj := X509_gmtime_adj_func;
  X509_set_notBefore := X509_set_notBefore_func;
  X509_set_notAfter := X509_set_notAfter_func;
  X509_set_pubkey := X509_set_pubkey_func;
  X509_REQ_set_pubkey := X509_REQ_set_pubkey_func;
  X509_PUBKEY_get := X509_PUBKEY_get_func;
  X509_verify := X509_verify_func;
  //PEM
  {$IFNDEF SSLEAY_MACROS}
  _PEM_read_bio_X509 := PEM_read_bio_X509_func;
  _PEM_read_bio_X509_REQ := PEM_read_bio_X509_REQ_func;
  _PEM_read_bio_X509_CRL := PEM_read_bio_X509_CRL_func;
  _PEM_read_bio_RSAPrivateKey := PEM_read_bio_RSAPrivateKey_func;
  _PEM_read_bio_RSAPublicKey := PEM_read_bio_RSAPublicKey_func;
  _PEM_read_bio_DSAPrivateKey := PEM_read_bio_DSAPrivateKey_func;
  _PEM_read_bio_PrivateKey := PEM_read_bio_PrivateKey_func;
  _PEM_read_bio_PKCS7 := PEM_read_bio_PKCS7_func;
  _PEM_read_bio_DHparams := PEM_read_bio_DHparams_func;
  _PEM_read_bio_DSAparams := PEM_read_bio_DSAparams_func;
  _PEM_read_bio_NETSCAPE_CERT_SEQUENCE := PEM_read_bio_NETSCAPE_CERT_SEQUENCE_func;
  _PEM_read_bio_PUBKEY := PEM_read_bio_PUBKEY_func;
  _PEM_write_bio_X509 := PEM_write_bio_X509_func;
  _PEM_write_bio_X509_REQ := PEM_write_bio_X509_REQ_func;
  _PEM_write_bio_X509_CRL := PEM_write_bio_X509_CRL_func;
  _PEM_write_bio_RSAPrivateKey := PEM_write_bio_RSAPrivateKey_func;
  _PEM_write_bio_RSAPublicKey := PEM_write_bio_RSAPublicKey_func;
  _PEM_write_bio_DSAPrivateKey := PEM_write_bio_DSAPrivateKey_func;
  _PEM_write_bio_PrivateKey := PEM_write_bio_PrivateKey_func;
  _PEM_write_bio_PKCS7 := PEM_write_bio_PKCS7_func;
  _PEM_write_bio_DHparams := PEM_write_bio_DHparams_func;
  _PEM_write_bio_DSAparams := PEM_write_bio_DSAparams_func;
  _PEM_write_bio_NETSCAPE_CERT_SEQUENCE := PEM_write_bio_NETSCAPE_CERT_SEQUENCE_func;
  _PEM_write_bio_PKCS8PrivateKey := PEM_write_bio_PKCS8PrivateKey_func;
  _PEM_write_bio_PUBKEY := PEM_write_bio_PUBKEY_func;
  {$ELSE}
  PEM_ASN1_write_bio := PEM_ASN1_write_bio_func;
  PEM_ASN1_read_bio := PEM_ASN1_read_bio_func;
  {$ENDIF}
  PEM_X509_INFO_read_bio := PEM_X509_INFO_read_bio_func;
  PEM_read_bio_X509_AUX := PEM_read_bio_X509_AUX_func;
  //EVP
  {$IFNDEF OPENSSL_NO_DES}
  EVP_des_ede3_cbc := EVP_des_ede3_cbc_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_SHA512}
  EVP_sha512 := EVP_sha512_func;
  EVP_sha384 := EVP_sha384_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_SHA256}
  EVP_sha256 := EVP_sha256_func;
  EVP_sha224 := EVP_sha224_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_SHA}
  EVP_sha1 := EVP_sha1_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_MD5}
  EVP_md5 := EVP_md5_func;
  {$ENDIF}
  {$IFNDEF OPENSSL_NO_MD4}
  EVP_md4 := EVP_md4_func;
  {$ENDIF}
//  {$IFNDEF OPENSSL_NO_MD2}
//  EVP_md2 := EVP_md2_func;
//  {$ENDIF}
  EVP_MD_CTX_init := EVP_MD_CTX_init_proc;
  EVP_MD_CTX_cleanup := EVP_MD_CTX_cleanup_func;
  EVP_MD_CTX_create := EVP_MD_CTX_create_func;
  EVP_MD_CTX_destroy := EVP_MD_CTX_destroy_proc;
  EVP_MD_CTX_copy := EVP_MD_CTX_copy_func;
  EVP_MD_CTX_copy_ex := EVP_MD_CTX_copy_ex_func;
  EVP_DigestInit_ex := EVP_DigestInit_ex_func;
  EVP_DigestUpdate := EVP_DigestUpdate_func;
  EVP_DigestFinal_ex := EVP_DigestFinal_ex_func;
  EVP_MD_CTX_cleanup := EVP_MD_CTX_cleanup_func;
  EVP_PKEY_type := EVP_PKEY_type_func;
  EVP_PKEY_new := EVP_PKEY_new_func;
  EVP_PKEY_free := EVP_PKEY_free_proc;
  EVP_PKEY_assign := EVP_PKEY_assign_func;
  EVP_get_digestbyname := EVP_get_digestbyname_func;
  //HMAC
  {$IFNDEF OPENSSL_NO_HMAC}
  HMAC_CTX_init := HMAC_CTX_init_proc;
//  if IsOpenSSL_1x then begin
    _1_0_HMAC_Init_ex :=  HMAC_Init_ex_func;
    _1_0_HMAC_Update  := HMAC_Update_func;
    _1_0_HMAC_Final := HMAC_Final_func;
//  end else begin
//    @_HMAC_Init_ex := LoadFunctionCLib(fn_HMAC_Init_ex);
//    @_HMAC_Update := LoadFunctionCLib(fn_HMAC_Update);
//    @_HMAC_Final := LoadFunctionCLib(fn_HMAC_Final);
//  end;
  HMAC_CTX_cleanup := HMAC_CTX_cleanup_proc;
  {$ENDIF}
  //OBJ
  OBJ_obj2nid := OBJ_obj2nid_func;
  OBJ_nid2obj := OBJ_nid2obj_func;
  OBJ_nid2ln := OBJ_nid2ln_func;
  OBJ_nid2sn := OBJ_nid2sn_func;
  //ASN1
  ASN1_INTEGER_set := ASN1_INTEGER_set_func;
  ASN1_INTEGER_get := ASN1_INTEGER_get_func;
  ASN1_STRING_type_new := ASN1_STRING_type_new_func;
  ASN1_STRING_free := ASN1_STRING_free_proc;
  ASN1_dup := ASN1_dup_func;
  CRYPTO_set_mem_functions := CRYPTO_set_mem_functions_func;
  CRYPTO_malloc := CRYPTO_malloc_func;
  CRYPTO_free := CRYPTO_free_proc;
  CRYPTO_mem_leaks := CRYPTO_mem_leaks_proc;
  CRYPTO_mem_ctrl := CRYPTO_mem_ctrl_func;
  CRYPTO_set_mem_debug_functions := CRYPTO_set_mem_debug_functions_proc;
  PKCS12_create := PKCS12_create_func;
  i2d_PKCS12_bio := i2d_PKCS12_bio_func;
  PKCS12_free := PKCS12_free_proc;
//  OpenSSL_add_all_algorithms := OpenSSL_add_all_algorithms_proc;
  OpenSSL_add_all_ciphers := OpenSSL_add_all_ciphers_proc;
  OpenSSL_add_all_digests := OpenSSL_add_all_digests_proc;
  EVP_cleanup := EVP_cleanup_proc;

  sk_num := sk_num_func;
  sk_new := sk_new_func;
  sk_new_null := sk_new_null_func;
  sk_free := sk_free_proc;
  sk_push := sk_push_func;
  sk_dup := sk_dup_func;
  sk_find := sk_find_func;
  sk_value := sk_value_func;
  {$IFDEF OPENSSL_FIPS}
//  _FIPS_mode_set := FIPS_mode_set_func;
//  _FIPS_mode := FIPS_mode_func;
  {$ENDIF}
end;

initialization
  LoadSymbols;

{$ENDIF}

end.
