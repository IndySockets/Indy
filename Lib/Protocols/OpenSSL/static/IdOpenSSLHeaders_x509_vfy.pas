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

// Generation date: 28.10.2020 15:24:33

unit IdOpenSSLHeaders_x509_vfy;

interface

// Headers for OpenSSL 1.1.1
// x509_vfy.h

{$i IdCompilerDefines.inc}

{$MINENUMSIZE 4}

uses
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

  //DEFINE_STACK_OF(X509_LOOKUP)
  //DEFINE_STACK_OF(X509_OBJECT)
  //DEFINE_STACK_OF(X509_VERIFY_PARAM)

  function X509_STORE_set_depth(store: PX509_STORE; depth: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  procedure X509_STORE_CTX_set_depth(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl; external CLibCrypto;

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
  function X509_OBJECT_up_ref_count(a: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_OBJECT_new: PX509_OBJECT cdecl; external CLibCrypto;
  procedure X509_OBJECT_free(a: PX509_OBJECT) cdecl; external CLibCrypto;
  function X509_OBJECT_get_type(const a: PX509_OBJECT): X509_LOOKUP_TYPE cdecl; external CLibCrypto;
  function X509_OBJECT_get0_X509(const a: PX509_OBJECT): PX509 cdecl; external CLibCrypto;
  function X509_OBJECT_set1_X509(a: PX509_OBJECT; obj: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_OBJECT_get0_X509_CRL(a: PX509_OBJECT): PX509_CRL cdecl; external CLibCrypto;
  function X509_OBJECT_set1_X509_CRL(a: PX509_OBJECT; obj: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_new: PX509_STORE cdecl; external CLibCrypto;
  procedure X509_STORE_free(v: PX509_STORE) cdecl; external CLibCrypto;
  function X509_STORE_lock(ctx: PX509_STORE): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_unlock(ctx: PX509_STORE): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_up_ref(v: PX509_STORE): TIdC_INT cdecl; external CLibCrypto;
  //STACK_OF(X509_OBJECT) *X509_STORE_get0_objects(X509_STORE *v);

  //STACK_OF(X509) *X509_STORE_CTX_get1_certs(X509_STORE_CTX *st, X509_NAME *nm);
  //STACK_OF(X509_CRL) *X509_STORE_CTX_get1_crls(X509_STORE_CTX *st, X509_NAME *nm);
  function X509_STORE_set_flags(ctx: PX509_STORE; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_set_purpose(ctx: PX509_STORE; purpose: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_set_trust(ctx: PX509_STORE; trust: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_set1_param(ctx: PX509_STORE; pm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_get0_param(ctx: PX509_STORE): PX509_VERIFY_PARAM cdecl; external CLibCrypto;

  procedure X509_STORE_set_verify(ctx: PX509_STORE; verify: X509_STORE_CTX_verify_fn) cdecl; external CLibCrypto;
  //#define X509_STORE_set_verify_func(ctx, func) \
  //            X509_STORE_set_verify((ctx),(func))
  procedure X509_STORE_CTX_set_verify(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_verify(ctx: PX509_STORE): X509_STORE_CTX_verify_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_verify_cb(ctx: PX509_STORE; verify_cb: X509_STORE_CTX_verify_cb) cdecl; external CLibCrypto;
  //# define X509_STORE_set_verify_cb_func(ctx,func) \
  //            X509_STORE_set_verify_cb((ctx),(func))
  function X509_STORE_get_verify_cb(ctx: PX509_STORE): X509_STORE_CTX_verify_cb cdecl; external CLibCrypto;
  procedure X509_STORE_set_get_issuer(ctx: PX509_STORE; get_issuer: X509_STORE_CTX_get_issuer_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_get_issuer(ctx: PX509_STORE): X509_STORE_CTX_get_issuer_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_check_issued(ctx: PX509_STORE; check_issued: X509_STORE_CTX_check_issued_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_check_issued(ctx: PX509_STORE): X509_STORE_CTX_check_issued_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_check_revocation(ctx: PX509_STORE; check_revocation: X509_STORE_CTX_check_revocation_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_check_revocation(ctx: PX509_STORE): X509_STORE_CTX_check_revocation_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_get_crl(ctx: PX509_STORE; get_crl: X509_STORE_CTX_get_crl_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_get_crl(ctx: PX509_STORE): X509_STORE_CTX_get_crl_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_check_crl(ctx: PX509_STORE; check_crl: X509_STORE_CTX_check_crl_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_check_crl(ctx: PX509_STORE): X509_STORE_CTX_check_crl_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_cert_crl(ctx: PX509_STORE; cert_crl: X509_STORE_CTX_cert_crl_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_cert_crl(ctx: PX509_STORE): X509_STORE_CTX_cert_crl_fn cdecl; external CLibCrypto;
  procedure X509_STORE_set_check_policy(ctx: PX509_STORE; check_policy: X509_STORE_CTX_check_policy_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_check_policy(ctx: PX509_STORE): X509_STORE_CTX_check_policy_fn cdecl; external CLibCrypto;
//  procedure X509_STORE_set_lookup_certs(ctx: PX509_STORE; lookup_certs: X509_STORE_CTX_lookup_certs_fn);
//  function X509_STORE_get_lookup_certs(ctx: PX509_STORE): X509_STORE_CTX_lookup_certs_fn;
//  procedure X509_STORE_set_lookup_crls(ctx: PX509_STORE; lookup_crls: X509_STORE_CTX_lookup_crls_fn);
//  #define X509_STORE_set_lookup_crls_cb(ctx, func) \
//      X509_STORE_set_lookup_crls((ctx), (func))
//  function X509_STORE_get_lookup_crls(ctx: PX509_STORE): X509_STORE_CTX_lookup_crls_fn;
  procedure X509_STORE_set_cleanup(ctx: PX509_STORE; cleanup: X509_STORE_CTX_cleanup_fn) cdecl; external CLibCrypto;
  function X509_STORE_get_cleanup(ctx: PX509_STORE): X509_STORE_CTX_cleanup_fn cdecl; external CLibCrypto;

  //#define X509_STORE_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE, l, p, newf, dupf, freef)
  function X509_STORE_set_ex_data(ctx: PX509_STORE; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_get_ex_data(ctx: PX509_STORE; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;

  function X509_STORE_CTX_new: PX509_STORE_CTX cdecl; external CLibCrypto;

  function X509_STORE_CTX_get1_issuer(issuer: PPX509; ctx: PX509_STORE_CTX; x: PX509): TIdC_INT cdecl; external CLibCrypto;

  procedure X509_STORE_CTX_free(ctx: PX509_STORE_CTX) cdecl; external CLibCrypto;
//  TIdC_INT X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: P STACK_OF(X509));
//  procedure X509_STORE_CTX_set0_trusted_stack(ctx: PX509_STORE_CTX; sk: P STACK_OF(X509));
  procedure X509_STORE_CTX_cleanup(ctx: PX509_STORE_CTX) cdecl; external CLibCrypto;

  function X509_STORE_CTX_get0_store(ctx: PX509_STORE_CTX): PX509_STORE cdecl; external CLibCrypto;
  function X509_STORE_CTX_get0_cert(ctx: PX509_STORE_CTX): PX509 cdecl; external CLibCrypto;
  //STACK_OF(X509)* X509_STORE_CTX_get0_untrusted(X509_STORE_CTX *ctx);
  //void X509_STORE_CTX_set0_untrusted(X509_STORE_CTX *ctx, STACK_OF(X509) *sk);
  procedure X509_STORE_CTX_set_verify_cb(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_cb) cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_verify_cb(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_cb cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_verify(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_get_issuer(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_issuer_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_check_issued(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_issued_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_check_revocation(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_revocation_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_get_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_crl_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_check_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_crl_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_cert_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_cert_crl_fn cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_check_policy(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_policy_fn cdecl; external CLibCrypto;
//  function X509_STORE_CTX_get_lookup_certs(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_certs_fn;
//  function X509_STORE_CTX_get_lookup_crls(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_crls_fn;
  function X509_STORE_CTX_get_cleanup(ctx: PX509_STORE_CTX): X509_STORE_CTX_cleanup_fn cdecl; external CLibCrypto;

  function X509_STORE_add_lookup(v: PX509_STORE; m: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl; external CLibCrypto;
  function X509_LOOKUP_hash_dir: PX509_LOOKUP_METHOD cdecl; external CLibCrypto;
  function X509_LOOKUP_file: PX509_LOOKUP_METHOD cdecl; external CLibCrypto;

  function X509_LOOKUP_meth_new(const name: PIdAnsiChar): PX509_LOOKUP_METHOD cdecl; external CLibCrypto;
  procedure X509_LOOKUP_meth_free(method: PX509_LOOKUP_METHOD) cdecl; external CLibCrypto;

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

  function X509_LOOKUP_meth_set_ctrl(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_meth_get_ctrl(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_ctrl_fn cdecl; external CLibCrypto;

  function X509_LOOKUP_meth_set_get_by_subject(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_subject_fn): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_meth_get_get_by_subject(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_subject_fn cdecl; external CLibCrypto;

  function X509_LOOKUP_meth_set_get_by_issuer_serial(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_issuer_serial_fn): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_meth_get_get_by_issuer_serial(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_issuer_serial_fn cdecl; external CLibCrypto;

  function X509_LOOKUP_meth_set_get_by_fingerprint(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_fingerprint_fn): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_meth_get_get_by_fingerprint(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_fingerprint_fn cdecl; external CLibCrypto;

  function X509_LOOKUP_meth_set_get_by_alias(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_alias_fn): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_meth_get_get_by_alias(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_alias_fn cdecl; external CLibCrypto;

  function X509_STORE_add_cert(ctx: PX509_STORE; x: PX509): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_add_crl(ctx: PX509_STORE; x: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;

  function X509_STORE_CTX_get_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_obj_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME): PX509_OBJECT cdecl; external CLibCrypto;

  function X509_LOOKUP_ctrl(ctx: PX509_LOOKUP; cmd: TIdC_INT; const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;

  function X509_load_cert_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_load_crl_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_load_cert_crl_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function X509_LOOKUP_new(method: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl; external CLibCrypto;
  procedure X509_LOOKUP_free(ctx: PX509_LOOKUP) cdecl; external CLibCrypto;
  function X509_LOOKUP_init(ctx: PX509_LOOKUP): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_by_subject(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_by_issuer_serial(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_by_fingerprint(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_by_alias(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_set_method_data(ctx: PX509_LOOKUP; data: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function X509_LOOKUP_get_method_data(const ctx: PX509_LOOKUP): Pointer cdecl; external CLibCrypto;
  function X509_LOOKUP_get_store(const ctx: PX509_LOOKUP): PX509_STORE cdecl; external CLibCrypto;
  function X509_LOOKUP_shutdown(ctx: PX509_LOOKUP): TIdC_INT cdecl; external CLibCrypto;

  function X509_STORE_load_locations(ctx: PX509_STORE; const file_: PIdAnsiChar; const dir: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_set_default_paths(ctx: PX509_STORE): TIdC_INT cdecl; external CLibCrypto;

  //#define X509_STORE_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE_CTX, l, p, newf, dupf, freef)
  function X509_STORE_CTX_set_ex_data(ctx: PX509_STORE_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_ex_data(ctx: PX509_STORE_CTX; idx: TIdC_INT): Pointer cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_error(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_STORE_CTX_set_error(ctx: X509_STORE_CTX; s: TIdC_INT) cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_error_depth(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_STORE_CTX_set_error_depth(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_current_cert(ctx: PX509_STORE_CTX): PX509 cdecl; external CLibCrypto;
  procedure X509_STORE_CTX_set_current_cert(ctx: PX509_STORE_CTX; x: PX509) cdecl; external CLibCrypto;
  function X509_STORE_CTX_get0_current_issuer(ctx: PX509_STORE_CTX): PX509 cdecl; external CLibCrypto;
  function X509_STORE_CTX_get0_current_crl(ctx: PX509_STORE_CTX): PX509_CRL cdecl; external CLibCrypto;
  function X509_STORE_CTX_get0_parent_ctx(ctx: PX509_STORE_CTX): PX509_STORE_CTX cdecl; external CLibCrypto;
//  STACK_OF(X509) *X509_STORE_CTX_get0_chain(X509_STORE_CTX *ctx);
//  STACK_OF(X509) *X509_STORE_CTX_get1_chain(X509_STORE_CTX *ctx);
  procedure X509_STORE_CTX_set_cert(c: PX509_STORE_CTX; x: PX509) cdecl; external CLibCrypto;
//  void X509_STORE_CTX_set0_verified_chain(X509_STORE_CTX *c, STACK_OF(X509) *sk);
//  void X509_STORE_CTX_set0_crls(X509_STORE_CTX *c, STACK_OF(X509_CRL) *sk);
  function X509_STORE_CTX_set_purpose(ctx: PX509_STORE_CTX; purpose: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_CTX_set_trust(ctx: PX509_STORE_CTX; trust: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_CTX_purpose_inherit(ctx: PX509_STORE_CTX; def_purpose: TIdC_INT; purpose: TIdC_INT; trust: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_STORE_CTX_set_flags(ctx: PX509_STORE_CTX; flags: TIdC_ULONG) cdecl; external CLibCrypto;
//  procedure X509_STORE_CTX_set_time(ctx: PX509_STORE_CTX; flags: TIdC_ULONG; t: TIdC_TIMET);

  function X509_STORE_CTX_get0_policy_tree(ctx: PX509_STORE_CTX): PX509_POLICY_TREE cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_explicit_policy(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external CLibCrypto;
  function X509_STORE_CTX_get_num_untrusted(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external CLibCrypto;

  function X509_STORE_CTX_get0_param(ctx: PX509_STORE_CTX): PX509_VERIFY_PARAM cdecl; external CLibCrypto;
  procedure X509_STORE_CTX_set0_param(ctx: PX509_STORE_CTX; param: PX509_VERIFY_PARAM) cdecl; external CLibCrypto;
  function X509_STORE_CTX_set_default(ctx: PX509_STORE_CTX; const name: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;

  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  procedure X509_STORE_CTX_set0_dane(ctx: PX509_STORE_CTX; dane: PSSL_DANE) cdecl; external CLibCrypto;

  (* X509_VERIFY_PARAM functions *)

  function X509_VERIFY_PARAM_new: PX509_VERIFY_PARAM cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_free(param: PX509_VERIFY_PARAM) cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_inherit(&to: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set1(&to: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set1_name(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set_flags(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_clear_flags(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get_flags(param: PX509_VERIFY_PARAM): TIdC_ULONG cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set_purpose(param: PX509_VERIFY_PARAM; purpose: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set_trust(param: PX509_VERIFY_PARAM; trust: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_set_depth(param: PX509_VERIFY_PARAM; depth: TIdC_INT) cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_set_auth_level(param: PX509_VERIFY_PARAM; auth_level: TIdC_INT) cdecl; external CLibCrypto;
//  function X509_VERIFY_PARAM_get_time(const param: PX509_VERIFY_PARAM): TIdC_TIMET;
//  procedure X509_VERIFY_PARAM_set_time(param: PX509_VERIFY_PARAM; t: TIdC_TIMET);
  function X509_VERIFY_PARAM_add0_policy(param: PX509_VERIFY_PARAM; policy: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  //TIdC_INT X509_VERIFY_PARAM_set1_policies(X509_VERIFY_PARAM *param,
  //                                    STACK_OF(ASN1_OBJECT) *policies);

  function X509_VERIFY_PARAM_set_inh_flags(param: PX509_VERIFY_PARAM; flags: TIdC_UINT32): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get_inh_flags(const param: PX509_VERIFY_PARAM): TIdC_UINT32 cdecl; external CLibCrypto;

  function X509_VERIFY_PARAM_set1_host(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_add1_host(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_set_hostflags(param: PX509_VERIFY_PARAM; flags: TIdC_UINT) cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get_hostflags(const param: PX509_VERIFY_PARAM): TIdC_UINT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get0_peername(v1: PX509_VERIFY_PARAM): PIdAnsiChar cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_move_peername(v1: PX509_VERIFY_PARAM; v2: PX509_VERIFY_PARAM) cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set1_email(param: PX509_VERIFY_PARAM; const email: PIdAnsiChar; emaillen: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set1_ip(param: PX509_VERIFY_PARAM; const ip: PByte; iplen: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_set1_ip_asc(param: PX509_VERIFY_PARAM; const ipasc: PIdAnsiChar): TIdC_INT cdecl; external CLibCrypto;

  function X509_VERIFY_PARAM_get_depth(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get_auth_level(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get0_name(const param: PX509_VERIFY_PARAM): PIdAnsiChar cdecl; external CLibCrypto;

  function X509_VERIFY_PARAM_add0_table(param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get_count: TIdC_INT cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_get0(id: TIdC_INT): PX509_VERIFY_PARAM cdecl; external CLibCrypto;
  function X509_VERIFY_PARAM_lookup(const name: PIdAnsiChar): X509_VERIFY_PARAM cdecl; external CLibCrypto;
  procedure X509_VERIFY_PARAM_table_cleanup cdecl; external CLibCrypto;

  //TIdC_INT X509_policy_check(X509_POLICY_TREE **ptree, TIdC_INT *pexplicit_policy,
  //                      STACK_OF(X509) *certs,
  //                      STACK_OF(ASN1_OBJECT) *policy_oids, TIdC_UINT flags);

  procedure X509_policy_tree_free(tree: PX509_POLICY_TREE) cdecl; external CLibCrypto;

  function X509_policy_tree_level_count(const tree: PX509_POLICY_TREE): TIdC_INT cdecl; external CLibCrypto;
  function X509_policy_tree_get0_level(const tree: PX509_POLICY_TREE; i: TIdC_INT): PX509_POLICY_LEVEL cdecl; external CLibCrypto;

  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_policies(const
  //                                                           X509_POLICY_TREE
  //                                                           *tree);
  //
  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_user_policies(const
  //                                                                X509_POLICY_TREE
  //                                                                *tree);

  function X509_policy_level_node_count(level: PX509_POLICY_LEVEL): TIdC_INT cdecl; external CLibCrypto;

  function X509_policy_level_get0_node(level: PX509_POLICY_LEVEL; i: TIdC_INT): PX509_POLICY_NODE cdecl; external CLibCrypto;

  function X509_policy_node_get0_policy(const node: PX509_POLICY_NODE): PASN1_OBJECT cdecl; external CLibCrypto;

  //STACK_OF(POLICYQUALINFO) *X509_policy_node_get0_qualifiers(const
  //                                                           X509_POLICY_NODE
  //                                                           *node);
  function X509_policy_node_get0_parent(const node: PX509_POLICY_NODE): PX509_POLICY_NODE cdecl; external CLibCrypto;

implementation

end.
