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

unit IdOpenSSLHeaders_x509_vfy;

interface

// Headers for OpenSSL 1.1.1
// x509_vfy.h

{$i IdCompilerDefines.inc}

{$MINENUMSIZE 4}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  X509_L_FILE_LOAD = 1;
  X509_L_ADD_DIR   = 2;

  X509_V_OK                                       = 0;
  X509_V_ERR_UNSPECIFIED                          = 1;
  X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT            = 2;
  X509_V_ERR_UNABLE_TO_GET_CRL                    = 3;
  X509_V_ERR_UNABLE_TO_DECRYPT_CERT_SIGNATURE     = 4;
  X509_V_ERR_UNABLE_TO_DECRYPT_CRL_SIGNATURE      = 5;
  X509_V_ERR_UNABLE_TO_DECODE_ISSUER_PUBLIC_KEY   = 6;
  X509_V_ERR_CERT_SIGNATURE_FAILURE               = 7;
  X509_V_ERR_CRL_SIGNATURE_FAILURE                = 8;
  X509_V_ERR_CERT_NOT_YET_VALID                   = 9;
  X509_V_ERR_CERT_HAS_EXPIRED                     = 10;
  X509_V_ERR_CRL_NOT_YET_VALID                    = 11;
  X509_V_ERR_CRL_HAS_EXPIRED                      = 12;
  X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD       = 13;
  X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD        = 14;
  X509_V_ERR_ERROR_IN_CRL_LAST_UPDATE_FIELD       = 15;
  X509_V_ERR_ERROR_IN_CRL_NEXT_UPDATE_FIELD       = 16;
  X509_V_ERR_OUT_OF_MEM                           = 17;
  X509_V_ERR_DEPTH_ZERO_SELF_SIGNED_CERT          = 18;
  X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN            = 19;
  X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY    = 20;
  X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE      = 21;
  X509_V_ERR_CERT_CHAIN_TOO_LONG                  = 22;
  X509_V_ERR_CERT_REVOKED                         = 23;
  X509_V_ERR_INVALID_CA                           = 24;
  X509_V_ERR_PATH_LENGTH_EXCEEDED                 = 25;
  X509_V_ERR_INVALID_PURPOSE                      = 26;
  X509_V_ERR_CERT_UNTRUSTED                       = 27;
  X509_V_ERR_CERT_REJECTED                        = 28;
  (* These are 'informational' when looking for issuer cert *)
  X509_V_ERR_SUBJECT_ISSUER_MISMATCH              = 29;
  X509_V_ERR_AKID_SKID_MISMATCH                   = 30;
  X509_V_ERR_AKID_ISSUER_SERIAL_MISMATCH          = 31;
  X509_V_ERR_KEYUSAGE_NO_CERTSIGN                 = 32;
  X509_V_ERR_UNABLE_TO_GET_CRL_ISSUER             = 33;
  X509_V_ERR_UNHANDLED_CRITICAL_EXTENSION         = 34;
  X509_V_ERR_KEYUSAGE_NO_CRL_SIGN                 = 35;
  X509_V_ERR_UNHANDLED_CRITICAL_CRL_EXTENSION     = 36;
  X509_V_ERR_INVALID_NON_CA                       = 37;
  X509_V_ERR_PROXY_PATH_LENGTH_EXCEEDED           = 38;
  X509_V_ERR_KEYUSAGE_NO_DIGITAL_SIGNATURE        = 39;
  X509_V_ERR_PROXY_CERTIFICATES_NOT_ALLOWED       = 40;
  X509_V_ERR_INVALID_EXTENSION                    = 41;
  X509_V_ERR_INVALID_POLICY_EXTENSION             = 42;
  X509_V_ERR_NO_EXPLICIT_POLICY                   = 43;
  X509_V_ERR_DIFFERENT_CRL_SCOPE                  = 44;
  X509_V_ERR_UNSUPPORTED_EXTENSION_FEATURE        = 45;
  X509_V_ERR_UNNESTED_RESOURCE                    = 46;
  X509_V_ERR_PERMITTED_VIOLATION                  = 47;
  X509_V_ERR_EXCLUDED_VIOLATION                   = 48;
  X509_V_ERR_SUBTREE_MINMAX                       = 49;
  (* The application is not happy *)
  X509_V_ERR_APPLICATION_VERIFICATION             = 50;
  X509_V_ERR_UNSUPPORTED_CONSTRAINT_TYPE          = 51;
  X509_V_ERR_UNSUPPORTED_CONSTRAINT_SYNTAX        = 52;
  X509_V_ERR_UNSUPPORTED_NAME_SYNTAX              = 53;
  X509_V_ERR_CRL_PATH_VALIDATION_ERROR            = 54;
  (* Another issuer check debug option *)
  X509_V_ERR_PATH_LOOP                            = 55;
  (* Suite B mode algorithm violation *)
  X509_V_ERR_SUITE_B_INVALID_VERSION              = 56;
  X509_V_ERR_SUITE_B_INVALID_ALGORITHM            = 57;
  X509_V_ERR_SUITE_B_INVALID_CURVE                = 58;
  X509_V_ERR_SUITE_B_INVALID_SIGNATURE_ALGORITHM  = 59;
  X509_V_ERR_SUITE_B_LOS_NOT_ALLOWED              = 60;
  X509_V_ERR_SUITE_B_CANNOT_SIGN_P_384_WITH_P_256 = 61;
  (* Host, email and IP check errors *)
  X509_V_ERR_HOSTNAME_MISMATCH                    = 62;
  X509_V_ERR_EMAIL_MISMATCH                       = 63;
  X509_V_ERR_IP_ADDRESS_MISMATCH                  = 64;
  (* DANE TLSA errors *)
  X509_V_ERR_DANE_NO_MATCH                        = 65;
  (* security level errors *)
  X509_V_ERR_EE_KEY_TOO_SMALL                     = 66;
  X509_V_ERR_CA_KEY_TOO_SMALL                     = 67;
  X509_V_ERR_CA_MD_TOO_WEAK                       = 68;
  (* Caller error *)
  X509_V_ERR_INVALID_CALL                         = 69;
  (* Issuer lookup error *)
  X509_V_ERR_STORE_LOOKUP                         = 70;
  (* Certificate transparency *)
  X509_V_ERR_NO_VALID_SCTS                        = 71;

  X509_V_ERR_PROXY_SUBJECT_NAME_VIOLATION         = 72;
  (* OCSP status errors *)
  X509_V_ERR_OCSP_VERIFY_NEEDED                   = 73;  (* Need OCSP verification *)
  X509_V_ERR_OCSP_VERIFY_FAILED                   = 74;  (* Couldn't verify cert through OCSP *)
  X509_V_ERR_OCSP_CERT_UNKNOWN                    = 75;  (* Certificate wasn't recognized by the OCSP responder *)

  (* Certificate verify flags *)

  (* Use check time instead of current time *)
  X509_V_FLAG_USE_CHECK_TIME       = $2;
  (* Lookup CRLs *)
  X509_V_FLAG_CRL_CHECK            = $4;
  (* Lookup CRLs for whole chain *)
  X509_V_FLAG_CRL_CHECK_ALL        = $8;
  (* Ignore unhandled critical extensions *)
  X509_V_FLAG_IGNORE_CRITICAL      = $10;
  (* Disable workarounds for broken certificates *)
  X509_V_FLAG_X509_STRICT          = $20;
  (* Enable proxy certificate validation *)
  X509_V_FLAG_ALLOW_PROXY_CERTS    = $40;
  (* Enable policy checking *)
  X509_V_FLAG_POLICY_CHECK         = $80;
  (* Policy variable require-explicit-policy *)
  X509_V_FLAG_EXPLICIT_POLICY      = $100;
  (* Policy variable inhibit-any-policy *)
  X509_V_FLAG_INHIBIT_ANY          = $200;
  (* Policy variable inhibit-policy-mapping *)
  X509_V_FLAG_INHIBIT_MAP          = $400;
  (* Notify callback that policy is OK *)
  X509_V_FLAG_NOTIFY_POLICY        = $800;
  (* Extended CRL features such as indirect CRLs, alternate CRL signing keys *)
  X509_V_FLAG_EXTENDED_CRL_SUPPORT = $1000;
  (* Delta CRL support *)
  X509_V_FLAG_USE_DELTAS           = $2000;
  (* Check self-signed CA signature *)
  X509_V_FLAG_CHECK_SS_SIGNATURE   = $4000;
  (* Use trusted store first *)
  X509_V_FLAG_TRUSTED_FIRST        = $8000;
  (* Suite B 128 bit only mode: not normally used *)
  X509_V_FLAG_SUITEB_128_LOS_ONLY  = $10000;
  (* Suite B 192 bit only mode *)
  X509_V_FLAG_SUITEB_192_LOS       = $20000;
  (* Suite B 128 bit mode allowing 192 bit algorithms *)
  X509_V_FLAG_SUITEB_128_LOS       = $30000;
  (* Allow partial chains if at least one certificate is in trusted store *)
  X509_V_FLAG_PARTIAL_CHAIN        = $80000;
  (*
   * If the initial chain is not trusted, do not attempt to build an alternative
   * chain. Alternate chain checking was introduced in 1.1.0. Setting this flag
   * will force the behaviour to match that of previous versions.
   *)
  X509_V_FLAG_NO_ALT_CHAINS        = $100000;
  (* Do not check certificate/CRL validity against current time *)
  X509_V_FLAG_NO_CHECK_TIME        = $200000;

  X509_VP_FLAG_DEFAULT             = $1;
  X509_VP_FLAG_OVERWRITE           = $2;
  X509_VP_FLAG_RESET_FLAGS         = $4;
  X509_VP_FLAG_LOCKED              = $8;
  X509_VP_FLAG_ONCE                = $10;

  (* Internal use: mask of policy related options *)
  X509_V_FLAG_POLICY_MASK = X509_V_FLAG_POLICY_CHECK or X509_V_FLAG_EXPLICIT_POLICY
    or X509_V_FLAG_INHIBIT_ANY or X509_V_FLAG_INHIBIT_MAP;


  DANE_FLAG_NO_DANE_EE_NAMECHECKS = TIdC_Long(1) shl 0;

  (* Non positive return values are errors *)
  X509_PCY_TREE_FAILURE  = -2; (* Failure to satisfy explicit policy *)
  X509_PCY_TREE_INVALID  = -1; (* Inconsistent or invalid extensions *)
  X509_PCY_TREE_INTERNAL = 0; (* Internal error, most likely malloc *)

  (*
   * Positive return values form a bit mask, all but the first are internal to
   * the library and don't appear in results from X509_policy_check().
   *)
  X509_PCY_TREE_VALID    = 1; (* The policy tree is valid *)
  X509_PCY_TREE_EMPTY    = 2; (* The policy tree is empty *)
  X509_PCY_TREE_EXPLICIT = 4; (* Explicit policy required *)

type
  (*-
  SSL_CTX -> X509_STORE
                  -> X509_LOOKUP
                          ->X509_LOOKUP_METHOD
                  -> X509_LOOKUP
                          ->X509_LOOKUP_METHOD

  SSL     -> X509_STORE_CTX
                  ->X509_STORE

  The X509_STORE holds the tables etc for verification stuff.
  A X509_STORE_CTX is used while validating a single certificate.
  The X509_STORE has X509_LOOKUPs for looking up certs.
  The X509_STORE then calls a function to actually verify the
  certificate chain.
  *)

  X509_LOOKUP_TYPE = (
    X509_LU_NONE = 0,
    X509_LU_X509,
    X509_LU_CRL
  );

  X509_STORE_CTX_verify_cb = function(v1: TIdC_INT; v2: PX509_STORE_CTX): TIdC_INT;
  X509_STORE_CTX_verify_fn = function(v1: PX509_STORE_CTX): TIdC_INT;
  X509_STORE_CTX_get_issuer_fn = function(issuer: PPX509; ctx: PX509_STORE_CTX; x: PX509): TIdC_INT;
  X509_STORE_CTX_check_issued_fn = function(ctx: PX509_STORE_CTX; x: PX509; issuer: PX509): TIdC_INT;
  X509_STORE_CTX_check_revocation_fn = function(ctx: PX509_STORE_CTX): TIdC_INT;
  X509_STORE_CTX_get_crl_fn = function(ctx: PX509_STORE_CTX; crl: PPX509_CRL; x: PX509): TIdC_INT;
  X509_STORE_CTX_check_crl_fn = function(ctx: PX509_STORE_CTX; crl: PX509_CRL): TIdC_INT;
  X509_STORE_CTX_cert_crl_fn = function(ctx: PX509_STORE_CTX; crl: PX509_CRL; x: PX509): TIdC_INT;
  X509_STORE_CTX_check_policy_fn = function(ctx: PX509_STORE_CTX): TIdC_INT;
//  typedef STACK_OF(X509) *(*X509_STORE_CTX_lookup_certs_fn)(X509_STORE_CTX *ctx,
//                                                            X509_NAME *nm);
//  typedef STACK_OF(X509_CRL) *(*X509_STORE_CTX_lookup_crls_fn)(X509_STORE_CTX *ctx,
//                                                               X509_NAME *nm);
  X509_STORE_CTX_cleanup_fn = function(ctx: PX509_STORE_CTX): TIdC_INT;

  X509_LOOKUP_ctrl_fn = function(ctx: PX509_LOOKUP; cmd: TIdC_INT;
    const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT;
  X509_LOOKUP_get_by_subject_fn = function(ctx: PX509_LOOKUP;
    type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT;
  X509_LOOKUP_get_by_issuer_serial_fn = function(ctx: PX509_LOOKUP;
    type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT;
  X509_LOOKUP_get_by_fingerprint_fn = function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE;
    const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT;
  X509_LOOKUP_get_by_alias_fn = function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE;
    const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  //DEFINE_STACK_OF(X509_LOOKUP)
  //DEFINE_STACK_OF(X509_OBJECT)
  //DEFINE_STACK_OF(X509_VERIFY_PARAM)

  X509_STORE_set_depth: function(store: PX509_STORE; depth: TIdC_INT): TIdC_INT cdecl = nil;

  X509_STORE_CTX_set_depth: procedure(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl = nil;

  //# define X509_STORE_CTX_set_app_data(ctx,data) \
  //        X509_STORE_CTX_set_ex_data(ctx,0,data)
  //# define X509_STORE_CTX_get_app_data(ctx) \
  //        X509_STORE_CTX_get_ex_data(ctx,0)
  //
  //# define X509_LOOKUP_load_file(x,name,type) \
  //                X509_LOOKUP_ctrl((x),X509_L_FILE_LOAD,(name),(TIdC_LONG)(type),NULL)
  //
  //# define X509_LOOKUP_add_dir(x,name,type) \
  //                X509_LOOKUP_ctrl((x),X509_L_ADD_DIR,(name),(TIdC_LONG)(type),NULL)
  //
  //TIdC_INT X509_OBJECT_idx_by_subject(STACK_OF(X509_OBJECT) *h, X509_LOOKUP_TYPE type,
  //                               X509_NAME *name);
  //X509_OBJECT *X509_OBJECT_retrieve_by_subject(STACK_OF(X509_OBJECT) *h,
  //                                             X509_LOOKUP_TYPE type,
  //                                             X509_NAME *name);
  //X509_OBJECT *X509_OBJECT_retrieve_match(STACK_OF(X509_OBJECT) *h,
  //                                        X509_OBJECT *x);
  X509_OBJECT_up_ref_count: function(a: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_OBJECT_new: function: PX509_OBJECT cdecl = nil;
  X509_OBJECT_free: procedure(a: PX509_OBJECT) cdecl = nil;
  X509_OBJECT_get_type: function(const a: PX509_OBJECT): X509_LOOKUP_TYPE cdecl = nil;
  X509_OBJECT_get0_X509: function(const a: PX509_OBJECT): PX509 cdecl = nil;
  X509_OBJECT_set1_X509: function(a: PX509_OBJECT; obj: PX509): TIdC_INT cdecl = nil;
  X509_OBJECT_get0_X509_CRL: function(a: PX509_OBJECT): PX509_CRL cdecl = nil;
  X509_OBJECT_set1_X509_CRL: function(a: PX509_OBJECT; obj: PX509_CRL): TIdC_INT cdecl = nil;
  X509_STORE_new: function: PX509_STORE cdecl = nil;
  X509_STORE_free: procedure(v: PX509_STORE) cdecl = nil;
  X509_STORE_lock: function(ctx: PX509_STORE): TIdC_INT cdecl = nil;
  X509_STORE_unlock: function(ctx: PX509_STORE): TIdC_INT cdecl = nil;
  X509_STORE_up_ref: function(v: PX509_STORE): TIdC_INT cdecl = nil;
  //STACK_OF(X509_OBJECT) *X509_STORE_get0_objects(X509_STORE *v);

  //STACK_OF(X509) *X509_STORE_CTX_get1_certs(X509_STORE_CTX *st, X509_NAME *nm);
  //STACK_OF(X509_CRL) *X509_STORE_CTX_get1_crls(X509_STORE_CTX *st, X509_NAME *nm);
  X509_STORE_set_flags: function(ctx: PX509_STORE; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_STORE_set_purpose: function(ctx: PX509_STORE; purpose: TIdC_INT): TIdC_INT cdecl = nil;
  X509_STORE_set_trust: function(ctx: PX509_STORE; trust: TIdC_INT): TIdC_INT cdecl = nil;
  X509_STORE_set1_param: function(ctx: PX509_STORE; pm: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_STORE_get0_param: function(ctx: PX509_STORE): PX509_VERIFY_PARAM cdecl = nil;

  X509_STORE_set_verify: procedure(ctx: PX509_STORE; verify: X509_STORE_CTX_verify_fn) cdecl = nil;
  //#define X509_STORE_set_verify_func(ctx, func) \
  //            X509_STORE_set_verify((ctx),(func))
  X509_STORE_CTX_set_verify: procedure(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_fn) cdecl = nil;
  X509_STORE_get_verify: function(ctx: PX509_STORE): X509_STORE_CTX_verify_fn cdecl = nil;
  X509_STORE_set_verify_cb: procedure(ctx: PX509_STORE; verify_cb: X509_STORE_CTX_verify_cb) cdecl = nil;
  //# define X509_STORE_set_verify_cb_func(ctx,func) \
  //            X509_STORE_set_verify_cb((ctx),(func))
  X509_STORE_get_verify_cb: function(ctx: PX509_STORE): X509_STORE_CTX_verify_cb cdecl = nil;
  X509_STORE_set_get_issuer: procedure(ctx: PX509_STORE; get_issuer: X509_STORE_CTX_get_issuer_fn) cdecl = nil;
  X509_STORE_get_get_issuer: function(ctx: PX509_STORE): X509_STORE_CTX_get_issuer_fn cdecl = nil;
  X509_STORE_set_check_issued: procedure(ctx: PX509_STORE; check_issued: X509_STORE_CTX_check_issued_fn) cdecl = nil;
  X509_STORE_get_check_issued: function(ctx: PX509_STORE): X509_STORE_CTX_check_issued_fn cdecl = nil;
  X509_STORE_set_check_revocation: procedure(ctx: PX509_STORE; check_revocation: X509_STORE_CTX_check_revocation_fn) cdecl = nil;
  X509_STORE_get_check_revocation: function(ctx: PX509_STORE): X509_STORE_CTX_check_revocation_fn cdecl = nil;
  X509_STORE_set_get_crl: procedure(ctx: PX509_STORE; get_crl: X509_STORE_CTX_get_crl_fn) cdecl = nil;
  X509_STORE_get_get_crl: function(ctx: PX509_STORE): X509_STORE_CTX_get_crl_fn cdecl = nil;
  X509_STORE_set_check_crl: procedure(ctx: PX509_STORE; check_crl: X509_STORE_CTX_check_crl_fn) cdecl = nil;
  X509_STORE_get_check_crl: function(ctx: PX509_STORE): X509_STORE_CTX_check_crl_fn cdecl = nil;
  X509_STORE_set_cert_crl: procedure(ctx: PX509_STORE; cert_crl: X509_STORE_CTX_cert_crl_fn) cdecl = nil;
  X509_STORE_get_cert_crl: function(ctx: PX509_STORE): X509_STORE_CTX_cert_crl_fn cdecl = nil;
  X509_STORE_set_check_policy: procedure(ctx: PX509_STORE; check_policy: X509_STORE_CTX_check_policy_fn) cdecl = nil;
  X509_STORE_get_check_policy: function(ctx: PX509_STORE): X509_STORE_CTX_check_policy_fn cdecl = nil;
//  procedure X509_STORE_set_lookup_certs(ctx: PX509_STORE; lookup_certs: X509_STORE_CTX_lookup_certs_fn);
//  function X509_STORE_get_lookup_certs(ctx: PX509_STORE): X509_STORE_CTX_lookup_certs_fn;
//  procedure X509_STORE_set_lookup_crls(ctx: PX509_STORE; lookup_crls: X509_STORE_CTX_lookup_crls_fn);
//  #define X509_STORE_set_lookup_crls_cb(ctx, func) \
//      X509_STORE_set_lookup_crls((ctx), (func))
//  function X509_STORE_get_lookup_crls(ctx: PX509_STORE): X509_STORE_CTX_lookup_crls_fn;
  X509_STORE_set_cleanup: procedure(ctx: PX509_STORE; cleanup: X509_STORE_CTX_cleanup_fn) cdecl = nil;
  X509_STORE_get_cleanup: function(ctx: PX509_STORE): X509_STORE_CTX_cleanup_fn cdecl = nil;

  //#define X509_STORE_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE, l, p, newf, dupf, freef)
  X509_STORE_set_ex_data: function(ctx: PX509_STORE; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl = nil;
  X509_STORE_get_ex_data: function(ctx: PX509_STORE; idx: TIdC_INT): Pointer cdecl = nil;

  X509_STORE_CTX_new: function: PX509_STORE_CTX cdecl = nil;

  X509_STORE_CTX_get1_issuer: function(issuer: PPX509; ctx: PX509_STORE_CTX; x: PX509): TIdC_INT cdecl = nil;

  X509_STORE_CTX_free: procedure(ctx: PX509_STORE_CTX) cdecl = nil;
//  TIdC_INT X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: P STACK_OF(X509));
//  procedure X509_STORE_CTX_set0_trusted_stack(ctx: PX509_STORE_CTX; sk: P STACK_OF(X509));
  X509_STORE_CTX_cleanup: procedure(ctx: PX509_STORE_CTX) cdecl = nil;

  X509_STORE_CTX_get0_store: function(ctx: PX509_STORE_CTX): PX509_STORE cdecl = nil;
  X509_STORE_CTX_get0_cert: function(ctx: PX509_STORE_CTX): PX509 cdecl = nil;
  //STACK_OF(X509)* X509_STORE_CTX_get0_untrusted(X509_STORE_CTX *ctx);
  //void X509_STORE_CTX_set0_untrusted(X509_STORE_CTX *ctx, STACK_OF(X509) *sk);
  X509_STORE_CTX_set_verify_cb: procedure(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_cb) cdecl = nil;
  X509_STORE_CTX_get_verify_cb: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_cb cdecl = nil;
  X509_STORE_CTX_get_verify: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_fn cdecl = nil;
  X509_STORE_CTX_get_get_issuer: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_issuer_fn cdecl = nil;
  X509_STORE_CTX_get_check_issued: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_issued_fn cdecl = nil;
  X509_STORE_CTX_get_check_revocation: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_revocation_fn cdecl = nil;
  X509_STORE_CTX_get_get_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_crl_fn cdecl = nil;
  X509_STORE_CTX_get_check_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_crl_fn cdecl = nil;
  X509_STORE_CTX_get_cert_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_cert_crl_fn cdecl = nil;
  X509_STORE_CTX_get_check_policy: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_policy_fn cdecl = nil;
//  function X509_STORE_CTX_get_lookup_certs(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_certs_fn;
//  function X509_STORE_CTX_get_lookup_crls(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_crls_fn;
  X509_STORE_CTX_get_cleanup: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_cleanup_fn cdecl = nil;

  X509_STORE_add_lookup: function(v: PX509_STORE; m: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl = nil;
  X509_LOOKUP_hash_dir: function: PX509_LOOKUP_METHOD cdecl = nil;
  X509_LOOKUP_file: function: PX509_LOOKUP_METHOD cdecl = nil;

  X509_LOOKUP_meth_new: function(const name: PIdAnsiChar): PX509_LOOKUP_METHOD cdecl = nil;
  X509_LOOKUP_meth_free: procedure(method: PX509_LOOKUP_METHOD) cdecl = nil;

  //TIdC_INT X509_LOOKUP_meth_set_new_item(X509_LOOKUP_METHOD *method,
  //                                  TIdC_INT (*new_item) (X509_LOOKUP *ctx));
  //TIdC_INT (*X509_LOOKUP_meth_get_new_item(const X509_LOOKUP_METHOD* method))
  //    (X509_LOOKUP *ctx);
  //
  //TIdC_INT X509_LOOKUP_meth_set_free(X509_LOOKUP_METHOD *method,
  //                              void (*free_fn) (X509_LOOKUP *ctx));
  //void (*X509_LOOKUP_meth_get_free(const X509_LOOKUP_METHOD* method))
  //    (X509_LOOKUP *ctx);
  //
  //TIdC_INT X509_LOOKUP_meth_set_init(X509_LOOKUP_METHOD *method,
  //                              TIdC_INT (*init) (X509_LOOKUP *ctx));
  //TIdC_INT (*X509_LOOKUP_meth_get_init(const X509_LOOKUP_METHOD* method))
  //    (X509_LOOKUP *ctx);
  //
  //TIdC_INT X509_LOOKUP_meth_set_shutdown(X509_LOOKUP_METHOD *method,
  //                                  TIdC_INT (*shutdown) (X509_LOOKUP *ctx));
  //TIdC_INT (*X509_LOOKUP_meth_get_shutdown(const X509_LOOKUP_METHOD* method))
  //    (X509_LOOKUP *ctx);

  X509_LOOKUP_meth_set_ctrl: function(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT cdecl = nil;
  X509_LOOKUP_meth_get_ctrl: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_ctrl_fn cdecl = nil;

  X509_LOOKUP_meth_set_get_by_subject: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_subject_fn): TIdC_INT cdecl = nil;
  X509_LOOKUP_meth_get_get_by_subject: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_subject_fn cdecl = nil;

  X509_LOOKUP_meth_set_get_by_issuer_serial: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_issuer_serial_fn): TIdC_INT cdecl = nil;
  X509_LOOKUP_meth_get_get_by_issuer_serial: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_issuer_serial_fn cdecl = nil;

  X509_LOOKUP_meth_set_get_by_fingerprint: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_fingerprint_fn): TIdC_INT cdecl = nil;
  X509_LOOKUP_meth_get_get_by_fingerprint: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_fingerprint_fn cdecl = nil;

  X509_LOOKUP_meth_set_get_by_alias: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_alias_fn): TIdC_INT cdecl = nil;
  X509_LOOKUP_meth_get_get_by_alias: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_alias_fn cdecl = nil;

  X509_STORE_add_cert: function(ctx: PX509_STORE; x: PX509): TIdC_INT cdecl = nil;
  X509_STORE_add_crl: function(ctx: PX509_STORE; x: PX509_CRL): TIdC_INT cdecl = nil;

  X509_STORE_CTX_get_by_subject: function(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_STORE_CTX_get_obj_by_subject: function(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME): PX509_OBJECT cdecl = nil;

  X509_LOOKUP_ctrl: function(ctx: PX509_LOOKUP; cmd: TIdC_INT; const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT cdecl = nil;

  X509_load_cert_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_load_crl_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl = nil;
  X509_load_cert_crl_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl = nil;

  X509_LOOKUP_new: function(method: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl = nil;
  X509_LOOKUP_free: procedure(ctx: PX509_LOOKUP) cdecl = nil;
  X509_LOOKUP_init: function(ctx: PX509_LOOKUP): TIdC_INT cdecl = nil;
  X509_LOOKUP_by_subject: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_LOOKUP_by_issuer_serial: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_LOOKUP_by_fingerprint: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_LOOKUP_by_alias: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl = nil;
  X509_LOOKUP_set_method_data: function(ctx: PX509_LOOKUP; data: Pointer): TIdC_INT cdecl = nil;
  X509_LOOKUP_get_method_data: function(const ctx: PX509_LOOKUP): Pointer cdecl = nil;
  X509_LOOKUP_get_store: function(const ctx: PX509_LOOKUP): PX509_STORE cdecl = nil;
  X509_LOOKUP_shutdown: function(ctx: PX509_LOOKUP): TIdC_INT cdecl = nil;

  X509_STORE_load_locations: function(ctx: PX509_STORE; const file_: PIdAnsiChar; const dir: PIdAnsiChar): TIdC_INT cdecl = nil;
  X509_STORE_set_default_paths: function(ctx: PX509_STORE): TIdC_INT cdecl = nil;

  //#define X509_STORE_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE_CTX, l, p, newf, dupf, freef)
  X509_STORE_CTX_set_ex_data: function(ctx: PX509_STORE_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl = nil;
  X509_STORE_CTX_get_ex_data: function(ctx: PX509_STORE_CTX; idx: TIdC_INT): Pointer cdecl = nil;
  X509_STORE_CTX_get_error: function(ctx: PX509_STORE_CTX): TIdC_INT cdecl = nil;
  X509_STORE_CTX_set_error: procedure(ctx: X509_STORE_CTX; s: TIdC_INT) cdecl = nil;
  X509_STORE_CTX_get_error_depth: function(ctx: PX509_STORE_CTX): TIdC_INT cdecl = nil;
  X509_STORE_CTX_set_error_depth: procedure(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl = nil;
  X509_STORE_CTX_get_current_cert: function(ctx: PX509_STORE_CTX): PX509 cdecl = nil;
  X509_STORE_CTX_set_current_cert: procedure(ctx: PX509_STORE_CTX; x: PX509) cdecl = nil;
  X509_STORE_CTX_get0_current_issuer: function(ctx: PX509_STORE_CTX): PX509 cdecl = nil;
  X509_STORE_CTX_get0_current_crl: function(ctx: PX509_STORE_CTX): PX509_CRL cdecl = nil;
  X509_STORE_CTX_get0_parent_ctx: function(ctx: PX509_STORE_CTX): PX509_STORE_CTX cdecl = nil;
//  STACK_OF(X509) *X509_STORE_CTX_get0_chain(X509_STORE_CTX *ctx);
//  STACK_OF(X509) *X509_STORE_CTX_get1_chain(X509_STORE_CTX *ctx);
  X509_STORE_CTX_set_cert: procedure(c: PX509_STORE_CTX; x: PX509) cdecl = nil;
//  void X509_STORE_CTX_set0_verified_chain(X509_STORE_CTX *c, STACK_OF(X509) *sk);
//  void X509_STORE_CTX_set0_crls(X509_STORE_CTX *c, STACK_OF(X509_CRL) *sk);
  X509_STORE_CTX_set_purpose: function(ctx: PX509_STORE_CTX; purpose: TIdC_INT): TIdC_INT cdecl = nil;
  X509_STORE_CTX_set_trust: function(ctx: PX509_STORE_CTX; trust: TIdC_INT): TIdC_INT cdecl = nil;
  X509_STORE_CTX_purpose_inherit: function(ctx: PX509_STORE_CTX; def_purpose: TIdC_INT; purpose: TIdC_INT; trust: TIdC_INT): TIdC_INT cdecl = nil;
  X509_STORE_CTX_set_flags: procedure(ctx: PX509_STORE_CTX; flags: TIdC_ULONG) cdecl = nil;
//  procedure X509_STORE_CTX_set_time(ctx: PX509_STORE_CTX; flags: TIdC_ULONG; t: TIdC_TIMET);

  X509_STORE_CTX_get0_policy_tree: function(ctx: PX509_STORE_CTX): PX509_POLICY_TREE cdecl = nil;
  X509_STORE_CTX_get_explicit_policy: function(ctx: PX509_STORE_CTX): TIdC_INT cdecl = nil;
  X509_STORE_CTX_get_num_untrusted: function(ctx: PX509_STORE_CTX): TIdC_INT cdecl = nil;

  X509_STORE_CTX_get0_param: function(ctx: PX509_STORE_CTX): PX509_VERIFY_PARAM cdecl = nil;
  X509_STORE_CTX_set0_param: procedure(ctx: PX509_STORE_CTX; param: PX509_VERIFY_PARAM) cdecl = nil;
  X509_STORE_CTX_set_default: function(ctx: PX509_STORE_CTX; const name: PIdAnsiChar): TIdC_INT cdecl = nil;

  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  X509_STORE_CTX_set0_dane: procedure(ctx: PX509_STORE_CTX; dane: PSSL_DANE) cdecl = nil;

  (* X509_VERIFY_PARAM functions *)

  X509_VERIFY_PARAM_new: function: PX509_VERIFY_PARAM cdecl = nil;
  X509_VERIFY_PARAM_free: procedure(param: PX509_VERIFY_PARAM) cdecl = nil;
  X509_VERIFY_PARAM_inherit: function(&to: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set1: function(&to: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set1_name: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_clear_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get_flags: function(param: PX509_VERIFY_PARAM): TIdC_ULONG cdecl = nil;
  X509_VERIFY_PARAM_set_purpose: function(param: PX509_VERIFY_PARAM; purpose: TIdC_INT): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set_trust: function(param: PX509_VERIFY_PARAM; trust: TIdC_INT): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set_depth: procedure(param: PX509_VERIFY_PARAM; depth: TIdC_INT) cdecl = nil;
  X509_VERIFY_PARAM_set_auth_level: procedure(param: PX509_VERIFY_PARAM; auth_level: TIdC_INT) cdecl = nil;
//  function X509_VERIFY_PARAM_get_time(const param: PX509_VERIFY_PARAM): TIdC_TIMET;
//  procedure X509_VERIFY_PARAM_set_time(param: PX509_VERIFY_PARAM; t: TIdC_TIMET);
  X509_VERIFY_PARAM_add0_policy: function(param: PX509_VERIFY_PARAM; policy: PASN1_OBJECT): TIdC_INT cdecl = nil;
  //TIdC_INT X509_VERIFY_PARAM_set1_policies(X509_VERIFY_PARAM *param,
  //                                    STACK_OF(ASN1_OBJECT) *policies);

  X509_VERIFY_PARAM_set_inh_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_UINT32): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get_inh_flags: function(const param: PX509_VERIFY_PARAM): TIdC_UINT32 cdecl = nil;

  X509_VERIFY_PARAM_set1_host: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_add1_host: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set_hostflags: procedure(param: PX509_VERIFY_PARAM; flags: TIdC_UINT) cdecl = nil;
  X509_VERIFY_PARAM_get_hostflags: function(const param: PX509_VERIFY_PARAM): TIdC_UINT cdecl = nil;
  X509_VERIFY_PARAM_get0_peername: function(v1: PX509_VERIFY_PARAM): PIdAnsiChar cdecl = nil;
  X509_VERIFY_PARAM_move_peername: procedure(v1: PX509_VERIFY_PARAM; v2: PX509_VERIFY_PARAM) cdecl = nil;
  X509_VERIFY_PARAM_set1_email: function(param: PX509_VERIFY_PARAM; const email: PIdAnsiChar; emaillen: TIdC_SIZET): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set1_ip: function(param: PX509_VERIFY_PARAM; const ip: PByte; iplen: TIdC_SIZET): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_set1_ip_asc: function(param: PX509_VERIFY_PARAM; const ipasc: PIdAnsiChar): TIdC_INT cdecl = nil;

  X509_VERIFY_PARAM_get_depth: function(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get_auth_level: function(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get0_name: function(const param: PX509_VERIFY_PARAM): PIdAnsiChar cdecl = nil;

  X509_VERIFY_PARAM_add0_table: function(param: PX509_VERIFY_PARAM): TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get_count: function: TIdC_INT cdecl = nil;
  X509_VERIFY_PARAM_get0: function(id: TIdC_INT): PX509_VERIFY_PARAM cdecl = nil;
  X509_VERIFY_PARAM_lookup: function(const name: PIdAnsiChar): X509_VERIFY_PARAM cdecl = nil;
  X509_VERIFY_PARAM_table_cleanup: procedure cdecl = nil;

  //TIdC_INT X509_policy_check(X509_POLICY_TREE **ptree, TIdC_INT *pexplicit_policy,
  //                      STACK_OF(X509) *certs,
  //                      STACK_OF(ASN1_OBJECT) *policy_oids, TIdC_UINT flags);

  X509_policy_tree_free: procedure(tree: PX509_POLICY_TREE) cdecl = nil;

  X509_policy_tree_level_count: function(const tree: PX509_POLICY_TREE): TIdC_INT cdecl = nil;
  X509_policy_tree_get0_level: function(const tree: PX509_POLICY_TREE; i: TIdC_INT): PX509_POLICY_LEVEL cdecl = nil;

  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_policies(const
  //                                                           X509_POLICY_TREE
  //                                                           *tree);
  //
  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_user_policies(const
  //                                                                X509_POLICY_TREE
  //                                                                *tree);

  X509_policy_level_node_count: function(level: PX509_POLICY_LEVEL): TIdC_INT cdecl = nil;

  X509_policy_level_get0_node: function(level: PX509_POLICY_LEVEL; i: TIdC_INT): PX509_POLICY_NODE cdecl = nil;

  X509_policy_node_get0_policy: function(const node: PX509_POLICY_NODE): PASN1_OBJECT cdecl = nil;

  //STACK_OF(POLICYQUALINFO) *X509_policy_node_get0_qualifiers(const
  //                                                           X509_POLICY_NODE
  //                                                           *node);
  X509_policy_node_get0_parent: function(const node: PX509_POLICY_NODE): PX509_POLICY_NODE cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  X509_STORE_set_depth := LoadFunction('X509_STORE_set_depth', AFailed);
  X509_STORE_CTX_set_depth := LoadFunction('X509_STORE_CTX_set_depth', AFailed);
  X509_OBJECT_up_ref_count := LoadFunction('X509_OBJECT_up_ref_count', AFailed);
  X509_OBJECT_new := LoadFunction('X509_OBJECT_new', AFailed);
  X509_OBJECT_free := LoadFunction('X509_OBJECT_free', AFailed);
  X509_OBJECT_get_type := LoadFunction('X509_OBJECT_get_type', AFailed);
  X509_OBJECT_get0_X509 := LoadFunction('X509_OBJECT_get0_X509', AFailed);
  X509_OBJECT_set1_X509 := LoadFunction('X509_OBJECT_set1_X509', AFailed);
  X509_OBJECT_get0_X509_CRL := LoadFunction('X509_OBJECT_get0_X509_CRL', AFailed);
  X509_OBJECT_set1_X509_CRL := LoadFunction('X509_OBJECT_set1_X509_CRL', AFailed);
  X509_STORE_new := LoadFunction('X509_STORE_new', AFailed);
  X509_STORE_free := LoadFunction('X509_STORE_free', AFailed);
  X509_STORE_lock := LoadFunction('X509_STORE_lock', AFailed);
  X509_STORE_unlock := LoadFunction('X509_STORE_unlock', AFailed);
  X509_STORE_up_ref := LoadFunction('X509_STORE_up_ref', AFailed);
  X509_STORE_set_flags := LoadFunction('X509_STORE_set_flags', AFailed);
  X509_STORE_set_purpose := LoadFunction('X509_STORE_set_purpose', AFailed);
  X509_STORE_set_trust := LoadFunction('X509_STORE_set_trust', AFailed);
  X509_STORE_set1_param := LoadFunction('X509_STORE_set1_param', AFailed);
  X509_STORE_get0_param := LoadFunction('X509_STORE_get0_param', AFailed);
  X509_STORE_set_verify := LoadFunction('X509_STORE_set_verify', AFailed);
  X509_STORE_CTX_set_verify := LoadFunction('X509_STORE_CTX_set_verify', AFailed);
  X509_STORE_get_verify := LoadFunction('X509_STORE_get_verify', AFailed);
  X509_STORE_set_verify_cb := LoadFunction('X509_STORE_set_verify_cb', AFailed);
  X509_STORE_get_verify_cb := LoadFunction('X509_STORE_get_verify_cb', AFailed);
  X509_STORE_set_get_issuer := LoadFunction('X509_STORE_set_get_issuer', AFailed);
  X509_STORE_get_get_issuer := LoadFunction('X509_STORE_get_get_issuer', AFailed);
  X509_STORE_set_check_issued := LoadFunction('X509_STORE_set_check_issued', AFailed);
  X509_STORE_get_check_issued := LoadFunction('X509_STORE_get_check_issued', AFailed);
  X509_STORE_set_check_revocation := LoadFunction('X509_STORE_set_check_revocation', AFailed);
  X509_STORE_get_check_revocation := LoadFunction('X509_STORE_get_check_revocation', AFailed);
  X509_STORE_set_get_crl := LoadFunction('X509_STORE_set_get_crl', AFailed);
  X509_STORE_get_get_crl := LoadFunction('X509_STORE_get_get_crl', AFailed);
  X509_STORE_set_check_crl := LoadFunction('X509_STORE_set_check_crl', AFailed);
  X509_STORE_get_check_crl := LoadFunction('X509_STORE_get_check_crl', AFailed);
  X509_STORE_set_cert_crl := LoadFunction('X509_STORE_set_cert_crl', AFailed);
  X509_STORE_get_cert_crl := LoadFunction('X509_STORE_get_cert_crl', AFailed);
  X509_STORE_set_check_policy := LoadFunction('X509_STORE_set_check_policy', AFailed);
  X509_STORE_get_check_policy := LoadFunction('X509_STORE_get_check_policy', AFailed);
  X509_STORE_set_cleanup := LoadFunction('X509_STORE_set_cleanup', AFailed);
  X509_STORE_get_cleanup := LoadFunction('X509_STORE_get_cleanup', AFailed);
  X509_STORE_set_ex_data := LoadFunction('X509_STORE_set_ex_data', AFailed);
  X509_STORE_get_ex_data := LoadFunction('X509_STORE_get_ex_data', AFailed);
  X509_STORE_CTX_new := LoadFunction('X509_STORE_CTX_new', AFailed);
  X509_STORE_CTX_get1_issuer := LoadFunction('X509_STORE_CTX_get1_issuer', AFailed);
  X509_STORE_CTX_free := LoadFunction('X509_STORE_CTX_free', AFailed);
  X509_STORE_CTX_cleanup := LoadFunction('X509_STORE_CTX_cleanup', AFailed);
  X509_STORE_CTX_get0_store := LoadFunction('X509_STORE_CTX_get0_store', AFailed);
  X509_STORE_CTX_get0_cert := LoadFunction('X509_STORE_CTX_get0_cert', AFailed);
  X509_STORE_CTX_set_verify_cb := LoadFunction('X509_STORE_CTX_set_verify_cb', AFailed);
  X509_STORE_CTX_get_verify_cb := LoadFunction('X509_STORE_CTX_get_verify_cb', AFailed);
  X509_STORE_CTX_get_verify := LoadFunction('X509_STORE_CTX_get_verify', AFailed);
  X509_STORE_CTX_get_get_issuer := LoadFunction('X509_STORE_CTX_get_get_issuer', AFailed);
  X509_STORE_CTX_get_check_issued := LoadFunction('X509_STORE_CTX_get_check_issued', AFailed);
  X509_STORE_CTX_get_check_revocation := LoadFunction('X509_STORE_CTX_get_check_revocation', AFailed);
  X509_STORE_CTX_get_get_crl := LoadFunction('X509_STORE_CTX_get_get_crl', AFailed);
  X509_STORE_CTX_get_check_crl := LoadFunction('X509_STORE_CTX_get_check_crl', AFailed);
  X509_STORE_CTX_get_cert_crl := LoadFunction('X509_STORE_CTX_get_cert_crl', AFailed);
  X509_STORE_CTX_get_check_policy := LoadFunction('X509_STORE_CTX_get_check_policy', AFailed);
  X509_STORE_CTX_get_cleanup := LoadFunction('X509_STORE_CTX_get_cleanup', AFailed);
  X509_STORE_add_lookup := LoadFunction('X509_STORE_add_lookup', AFailed);
  X509_LOOKUP_hash_dir := LoadFunction('X509_LOOKUP_hash_dir', AFailed);
  X509_LOOKUP_file := LoadFunction('X509_LOOKUP_file', AFailed);
  X509_LOOKUP_meth_new := LoadFunction('X509_LOOKUP_meth_new', AFailed);
  X509_LOOKUP_meth_free := LoadFunction('X509_LOOKUP_meth_free', AFailed);
  X509_LOOKUP_meth_set_ctrl := LoadFunction('X509_LOOKUP_meth_set_ctrl', AFailed);
  X509_LOOKUP_meth_get_ctrl := LoadFunction('X509_LOOKUP_meth_get_ctrl', AFailed);
  X509_LOOKUP_meth_set_get_by_subject := LoadFunction('X509_LOOKUP_meth_set_get_by_subject', AFailed);
  X509_LOOKUP_meth_get_get_by_subject := LoadFunction('X509_LOOKUP_meth_get_get_by_subject', AFailed);
  X509_LOOKUP_meth_set_get_by_issuer_serial := LoadFunction('X509_LOOKUP_meth_set_get_by_issuer_serial', AFailed);
  X509_LOOKUP_meth_get_get_by_issuer_serial := LoadFunction('X509_LOOKUP_meth_get_get_by_issuer_serial', AFailed);
  X509_LOOKUP_meth_set_get_by_fingerprint := LoadFunction('X509_LOOKUP_meth_set_get_by_fingerprint', AFailed);
  X509_LOOKUP_meth_get_get_by_fingerprint := LoadFunction('X509_LOOKUP_meth_get_get_by_fingerprint', AFailed);
  X509_LOOKUP_meth_set_get_by_alias := LoadFunction('X509_LOOKUP_meth_set_get_by_alias', AFailed);
  X509_LOOKUP_meth_get_get_by_alias := LoadFunction('X509_LOOKUP_meth_get_get_by_alias', AFailed);
  X509_STORE_add_cert := LoadFunction('X509_STORE_add_cert', AFailed);
  X509_STORE_add_crl := LoadFunction('X509_STORE_add_crl', AFailed);
  X509_STORE_CTX_get_by_subject := LoadFunction('X509_STORE_CTX_get_by_subject', AFailed);
  X509_STORE_CTX_get_obj_by_subject := LoadFunction('X509_STORE_CTX_get_obj_by_subject', AFailed);
  X509_LOOKUP_ctrl := LoadFunction('X509_LOOKUP_ctrl', AFailed);
  X509_load_cert_file := LoadFunction('X509_load_cert_file', AFailed);
  X509_load_crl_file := LoadFunction('X509_load_crl_file', AFailed);
  X509_load_cert_crl_file := LoadFunction('X509_load_cert_crl_file', AFailed);
  X509_LOOKUP_new := LoadFunction('X509_LOOKUP_new', AFailed);
  X509_LOOKUP_free := LoadFunction('X509_LOOKUP_free', AFailed);
  X509_LOOKUP_init := LoadFunction('X509_LOOKUP_init', AFailed);
  X509_LOOKUP_by_subject := LoadFunction('X509_LOOKUP_by_subject', AFailed);
  X509_LOOKUP_by_issuer_serial := LoadFunction('X509_LOOKUP_by_issuer_serial', AFailed);
  X509_LOOKUP_by_fingerprint := LoadFunction('X509_LOOKUP_by_fingerprint', AFailed);
  X509_LOOKUP_by_alias := LoadFunction('X509_LOOKUP_by_alias', AFailed);
  X509_LOOKUP_set_method_data := LoadFunction('X509_LOOKUP_set_method_data', AFailed);
  X509_LOOKUP_get_method_data := LoadFunction('X509_LOOKUP_get_method_data', AFailed);
  X509_LOOKUP_get_store := LoadFunction('X509_LOOKUP_get_store', AFailed);
  X509_LOOKUP_shutdown := LoadFunction('X509_LOOKUP_shutdown', AFailed);
  X509_STORE_load_locations := LoadFunction('X509_STORE_load_locations', AFailed);
  X509_STORE_set_default_paths := LoadFunction('X509_STORE_set_default_paths', AFailed);
  X509_STORE_CTX_set_ex_data := LoadFunction('X509_STORE_CTX_set_ex_data', AFailed);
  X509_STORE_CTX_get_ex_data := LoadFunction('X509_STORE_CTX_get_ex_data', AFailed);
  X509_STORE_CTX_get_error := LoadFunction('X509_STORE_CTX_get_error', AFailed);
  X509_STORE_CTX_set_error := LoadFunction('X509_STORE_CTX_set_error', AFailed);
  X509_STORE_CTX_get_error_depth := LoadFunction('X509_STORE_CTX_get_error_depth', AFailed);
  X509_STORE_CTX_set_error_depth := LoadFunction('X509_STORE_CTX_set_error_depth', AFailed);
  X509_STORE_CTX_get_current_cert := LoadFunction('X509_STORE_CTX_get_current_cert', AFailed);
  X509_STORE_CTX_set_current_cert := LoadFunction('X509_STORE_CTX_set_current_cert', AFailed);
  X509_STORE_CTX_get0_current_issuer := LoadFunction('X509_STORE_CTX_get0_current_issuer', AFailed);
  X509_STORE_CTX_get0_current_crl := LoadFunction('X509_STORE_CTX_get0_current_crl', AFailed);
  X509_STORE_CTX_get0_parent_ctx := LoadFunction('X509_STORE_CTX_get0_parent_ctx', AFailed);
  X509_STORE_CTX_set_cert := LoadFunction('X509_STORE_CTX_set_cert', AFailed);
  X509_STORE_CTX_set_purpose := LoadFunction('X509_STORE_CTX_set_purpose', AFailed);
  X509_STORE_CTX_set_trust := LoadFunction('X509_STORE_CTX_set_trust', AFailed);
  X509_STORE_CTX_purpose_inherit := LoadFunction('X509_STORE_CTX_purpose_inherit', AFailed);
  X509_STORE_CTX_set_flags := LoadFunction('X509_STORE_CTX_set_flags', AFailed);
  X509_STORE_CTX_get0_policy_tree := LoadFunction('X509_STORE_CTX_get0_policy_tree', AFailed);
  X509_STORE_CTX_get_explicit_policy := LoadFunction('X509_STORE_CTX_get_explicit_policy', AFailed);
  X509_STORE_CTX_get_num_untrusted := LoadFunction('X509_STORE_CTX_get_num_untrusted', AFailed);
  X509_STORE_CTX_get0_param := LoadFunction('X509_STORE_CTX_get0_param', AFailed);
  X509_STORE_CTX_set0_param := LoadFunction('X509_STORE_CTX_set0_param', AFailed);
  X509_STORE_CTX_set_default := LoadFunction('X509_STORE_CTX_set_default', AFailed);
  X509_STORE_CTX_set0_dane := LoadFunction('X509_STORE_CTX_set0_dane', AFailed);
  X509_VERIFY_PARAM_new := LoadFunction('X509_VERIFY_PARAM_new', AFailed);
  X509_VERIFY_PARAM_free := LoadFunction('X509_VERIFY_PARAM_free', AFailed);
  X509_VERIFY_PARAM_inherit := LoadFunction('X509_VERIFY_PARAM_inherit', AFailed);
  X509_VERIFY_PARAM_set1 := LoadFunction('X509_VERIFY_PARAM_set1', AFailed);
  X509_VERIFY_PARAM_set1_name := LoadFunction('X509_VERIFY_PARAM_set1_name', AFailed);
  X509_VERIFY_PARAM_set_flags := LoadFunction('X509_VERIFY_PARAM_set_flags', AFailed);
  X509_VERIFY_PARAM_clear_flags := LoadFunction('X509_VERIFY_PARAM_clear_flags', AFailed);
  X509_VERIFY_PARAM_get_flags := LoadFunction('X509_VERIFY_PARAM_get_flags', AFailed);
  X509_VERIFY_PARAM_set_purpose := LoadFunction('X509_VERIFY_PARAM_set_purpose', AFailed);
  X509_VERIFY_PARAM_set_trust := LoadFunction('X509_VERIFY_PARAM_set_trust', AFailed);
  X509_VERIFY_PARAM_set_depth := LoadFunction('X509_VERIFY_PARAM_set_depth', AFailed);
  X509_VERIFY_PARAM_set_auth_level := LoadFunction('X509_VERIFY_PARAM_set_auth_level', AFailed);
  X509_VERIFY_PARAM_add0_policy := LoadFunction('X509_VERIFY_PARAM_add0_policy', AFailed);
  X509_VERIFY_PARAM_set_inh_flags := LoadFunction('X509_VERIFY_PARAM_set_inh_flags', AFailed);
  X509_VERIFY_PARAM_get_inh_flags := LoadFunction('X509_VERIFY_PARAM_get_inh_flags', AFailed);
  X509_VERIFY_PARAM_set1_host := LoadFunction('X509_VERIFY_PARAM_set1_host', AFailed);
  X509_VERIFY_PARAM_add1_host := LoadFunction('X509_VERIFY_PARAM_add1_host', AFailed);
  X509_VERIFY_PARAM_set_hostflags := LoadFunction('X509_VERIFY_PARAM_set_hostflags', AFailed);
  X509_VERIFY_PARAM_get_hostflags := LoadFunction('X509_VERIFY_PARAM_get_hostflags', AFailed);
  X509_VERIFY_PARAM_get0_peername := LoadFunction('X509_VERIFY_PARAM_get0_peername', AFailed);
  X509_VERIFY_PARAM_move_peername := LoadFunction('X509_VERIFY_PARAM_move_peername', AFailed);
  X509_VERIFY_PARAM_set1_email := LoadFunction('X509_VERIFY_PARAM_set1_email', AFailed);
  X509_VERIFY_PARAM_set1_ip := LoadFunction('X509_VERIFY_PARAM_set1_ip', AFailed);
  X509_VERIFY_PARAM_set1_ip_asc := LoadFunction('X509_VERIFY_PARAM_set1_ip_asc', AFailed);
  X509_VERIFY_PARAM_get_depth := LoadFunction('X509_VERIFY_PARAM_get_depth', AFailed);
  X509_VERIFY_PARAM_get_auth_level := LoadFunction('X509_VERIFY_PARAM_get_auth_level', AFailed);
  X509_VERIFY_PARAM_get0_name := LoadFunction('X509_VERIFY_PARAM_get0_name', AFailed);
  X509_VERIFY_PARAM_add0_table := LoadFunction('X509_VERIFY_PARAM_add0_table', AFailed);
  X509_VERIFY_PARAM_get_count := LoadFunction('X509_VERIFY_PARAM_get_count', AFailed);
  X509_VERIFY_PARAM_get0 := LoadFunction('X509_VERIFY_PARAM_get0', AFailed);
  X509_VERIFY_PARAM_lookup := LoadFunction('X509_VERIFY_PARAM_lookup', AFailed);
  X509_VERIFY_PARAM_table_cleanup := LoadFunction('X509_VERIFY_PARAM_table_cleanup', AFailed);
  X509_policy_tree_free := LoadFunction('X509_policy_tree_free', AFailed);
  X509_policy_tree_level_count := LoadFunction('X509_policy_tree_level_count', AFailed);
  X509_policy_tree_get0_level := LoadFunction('X509_policy_tree_get0_level', AFailed);
  X509_policy_level_node_count := LoadFunction('X509_policy_level_node_count', AFailed);
  X509_policy_level_get0_node := LoadFunction('X509_policy_level_get0_node', AFailed);
  X509_policy_node_get0_policy := LoadFunction('X509_policy_node_get0_policy', AFailed);
  X509_policy_node_get0_parent := LoadFunction('X509_policy_node_get0_parent', AFailed);
end;

procedure UnLoad;
begin
  X509_STORE_set_depth := nil;
  X509_STORE_CTX_set_depth := nil;
  X509_OBJECT_up_ref_count := nil;
  X509_OBJECT_new := nil;
  X509_OBJECT_free := nil;
  X509_OBJECT_get_type := nil;
  X509_OBJECT_get0_X509 := nil;
  X509_OBJECT_set1_X509 := nil;
  X509_OBJECT_get0_X509_CRL := nil;
  X509_OBJECT_set1_X509_CRL := nil;
  X509_STORE_new := nil;
  X509_STORE_free := nil;
  X509_STORE_lock := nil;
  X509_STORE_unlock := nil;
  X509_STORE_up_ref := nil;
  X509_STORE_set_flags := nil;
  X509_STORE_set_purpose := nil;
  X509_STORE_set_trust := nil;
  X509_STORE_set1_param := nil;
  X509_STORE_get0_param := nil;
  X509_STORE_set_verify := nil;
  X509_STORE_CTX_set_verify := nil;
  X509_STORE_get_verify := nil;
  X509_STORE_set_verify_cb := nil;
  X509_STORE_get_verify_cb := nil;
  X509_STORE_set_get_issuer := nil;
  X509_STORE_get_get_issuer := nil;
  X509_STORE_set_check_issued := nil;
  X509_STORE_get_check_issued := nil;
  X509_STORE_set_check_revocation := nil;
  X509_STORE_get_check_revocation := nil;
  X509_STORE_set_get_crl := nil;
  X509_STORE_get_get_crl := nil;
  X509_STORE_set_check_crl := nil;
  X509_STORE_get_check_crl := nil;
  X509_STORE_set_cert_crl := nil;
  X509_STORE_get_cert_crl := nil;
  X509_STORE_set_check_policy := nil;
  X509_STORE_get_check_policy := nil;
  X509_STORE_set_cleanup := nil;
  X509_STORE_get_cleanup := nil;
  X509_STORE_set_ex_data := nil;
  X509_STORE_get_ex_data := nil;
  X509_STORE_CTX_new := nil;
  X509_STORE_CTX_get1_issuer := nil;
  X509_STORE_CTX_free := nil;
  X509_STORE_CTX_cleanup := nil;
  X509_STORE_CTX_get0_store := nil;
  X509_STORE_CTX_get0_cert := nil;
  X509_STORE_CTX_set_verify_cb := nil;
  X509_STORE_CTX_get_verify_cb := nil;
  X509_STORE_CTX_get_verify := nil;
  X509_STORE_CTX_get_get_issuer := nil;
  X509_STORE_CTX_get_check_issued := nil;
  X509_STORE_CTX_get_check_revocation := nil;
  X509_STORE_CTX_get_get_crl := nil;
  X509_STORE_CTX_get_check_crl := nil;
  X509_STORE_CTX_get_cert_crl := nil;
  X509_STORE_CTX_get_check_policy := nil;
  X509_STORE_CTX_get_cleanup := nil;
  X509_STORE_add_lookup := nil;
  X509_LOOKUP_hash_dir := nil;
  X509_LOOKUP_file := nil;
  X509_LOOKUP_meth_new := nil;
  X509_LOOKUP_meth_free := nil;
  X509_LOOKUP_meth_set_ctrl := nil;
  X509_LOOKUP_meth_get_ctrl := nil;
  X509_LOOKUP_meth_set_get_by_subject := nil;
  X509_LOOKUP_meth_get_get_by_subject := nil;
  X509_LOOKUP_meth_set_get_by_issuer_serial := nil;
  X509_LOOKUP_meth_get_get_by_issuer_serial := nil;
  X509_LOOKUP_meth_set_get_by_fingerprint := nil;
  X509_LOOKUP_meth_get_get_by_fingerprint := nil;
  X509_LOOKUP_meth_set_get_by_alias := nil;
  X509_LOOKUP_meth_get_get_by_alias := nil;
  X509_STORE_add_cert := nil;
  X509_STORE_add_crl := nil;
  X509_STORE_CTX_get_by_subject := nil;
  X509_STORE_CTX_get_obj_by_subject := nil;
  X509_LOOKUP_ctrl := nil;
  X509_load_cert_file := nil;
  X509_load_crl_file := nil;
  X509_load_cert_crl_file := nil;
  X509_LOOKUP_new := nil;
  X509_LOOKUP_free := nil;
  X509_LOOKUP_init := nil;
  X509_LOOKUP_by_subject := nil;
  X509_LOOKUP_by_issuer_serial := nil;
  X509_LOOKUP_by_fingerprint := nil;
  X509_LOOKUP_by_alias := nil;
  X509_LOOKUP_set_method_data := nil;
  X509_LOOKUP_get_method_data := nil;
  X509_LOOKUP_get_store := nil;
  X509_LOOKUP_shutdown := nil;
  X509_STORE_load_locations := nil;
  X509_STORE_set_default_paths := nil;
  X509_STORE_CTX_set_ex_data := nil;
  X509_STORE_CTX_get_ex_data := nil;
  X509_STORE_CTX_get_error := nil;
  X509_STORE_CTX_set_error := nil;
  X509_STORE_CTX_get_error_depth := nil;
  X509_STORE_CTX_set_error_depth := nil;
  X509_STORE_CTX_get_current_cert := nil;
  X509_STORE_CTX_set_current_cert := nil;
  X509_STORE_CTX_get0_current_issuer := nil;
  X509_STORE_CTX_get0_current_crl := nil;
  X509_STORE_CTX_get0_parent_ctx := nil;
  X509_STORE_CTX_set_cert := nil;
  X509_STORE_CTX_set_purpose := nil;
  X509_STORE_CTX_set_trust := nil;
  X509_STORE_CTX_purpose_inherit := nil;
  X509_STORE_CTX_set_flags := nil;
  X509_STORE_CTX_get0_policy_tree := nil;
  X509_STORE_CTX_get_explicit_policy := nil;
  X509_STORE_CTX_get_num_untrusted := nil;
  X509_STORE_CTX_get0_param := nil;
  X509_STORE_CTX_set0_param := nil;
  X509_STORE_CTX_set_default := nil;
  X509_STORE_CTX_set0_dane := nil;
  X509_VERIFY_PARAM_new := nil;
  X509_VERIFY_PARAM_free := nil;
  X509_VERIFY_PARAM_inherit := nil;
  X509_VERIFY_PARAM_set1 := nil;
  X509_VERIFY_PARAM_set1_name := nil;
  X509_VERIFY_PARAM_set_flags := nil;
  X509_VERIFY_PARAM_clear_flags := nil;
  X509_VERIFY_PARAM_get_flags := nil;
  X509_VERIFY_PARAM_set_purpose := nil;
  X509_VERIFY_PARAM_set_trust := nil;
  X509_VERIFY_PARAM_set_depth := nil;
  X509_VERIFY_PARAM_set_auth_level := nil;
  X509_VERIFY_PARAM_add0_policy := nil;
  X509_VERIFY_PARAM_set_inh_flags := nil;
  X509_VERIFY_PARAM_get_inh_flags := nil;
  X509_VERIFY_PARAM_set1_host := nil;
  X509_VERIFY_PARAM_add1_host := nil;
  X509_VERIFY_PARAM_set_hostflags := nil;
  X509_VERIFY_PARAM_get_hostflags := nil;
  X509_VERIFY_PARAM_get0_peername := nil;
  X509_VERIFY_PARAM_move_peername := nil;
  X509_VERIFY_PARAM_set1_email := nil;
  X509_VERIFY_PARAM_set1_ip := nil;
  X509_VERIFY_PARAM_set1_ip_asc := nil;
  X509_VERIFY_PARAM_get_depth := nil;
  X509_VERIFY_PARAM_get_auth_level := nil;
  X509_VERIFY_PARAM_get0_name := nil;
  X509_VERIFY_PARAM_add0_table := nil;
  X509_VERIFY_PARAM_get_count := nil;
  X509_VERIFY_PARAM_get0 := nil;
  X509_VERIFY_PARAM_lookup := nil;
  X509_VERIFY_PARAM_table_cleanup := nil;
  X509_policy_tree_free := nil;
  X509_policy_tree_level_count := nil;
  X509_policy_tree_get0_level := nil;
  X509_policy_level_node_count := nil;
  X509_policy_level_get0_node := nil;
  X509_policy_node_get0_policy := nil;
  X509_policy_node_get0_parent := nil;
end;

end.
