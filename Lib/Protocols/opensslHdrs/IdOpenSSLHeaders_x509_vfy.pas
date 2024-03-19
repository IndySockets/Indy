  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_x509_vfy.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_x509_vfy.h2pas
     and this file regenerated. IdOpenSSLHeaders_x509_vfy.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_x509_vfy;

interface

// Headers for OpenSSL 1.1.1
// x509_vfy.h


{$MINENUMSIZE 4}

uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ssl,
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
   * chain. Alternate chain checking was introduced 1.1.0. Setting this flag
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
    const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT; cdecl;
  X509_LOOKUP_get_by_subject_fn = function(ctx: PX509_LOOKUP;
    type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT; cdecl;
  X509_LOOKUP_get_by_issuer_serial_fn = function(ctx: PX509_LOOKUP;
    type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT; cdecl;
  X509_LOOKUP_get_by_fingerprint_fn = function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE;
    const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT; cdecl;
  X509_LOOKUP_get_by_alias_fn = function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE;
    const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT; cdecl;

  //DEFINE_STACK_OF(X509_LOOKUP)
  //DEFINE_STACK_OF(X509_OBJECT)
  //DEFINE_STACK_OF(X509_VERIFY_PARAM)

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM X509_STORE_set_depth}
  {$EXTERNALSYM X509_STORE_CTX_set_depth}
  {$EXTERNALSYM X509_OBJECT_up_ref_count}
  {$EXTERNALSYM X509_OBJECT_new} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_free} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_get_type} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_get0_X509} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_set1_X509} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_get0_X509_CRL} {introduced 1.1.0}
  {$EXTERNALSYM X509_OBJECT_set1_X509_CRL} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_new}
  {$EXTERNALSYM X509_STORE_free}
  {$EXTERNALSYM X509_STORE_lock} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_unlock} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_flags}
  {$EXTERNALSYM X509_STORE_set_purpose}
  {$EXTERNALSYM X509_STORE_set_trust}
  {$EXTERNALSYM X509_STORE_set1_param}
  {$EXTERNALSYM X509_STORE_get0_param} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_verify} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_set_verify} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_verify} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_verify_cb}
  {$EXTERNALSYM X509_STORE_get_verify_cb} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_get_issuer} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_get_issuer} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_check_issued} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_check_issued} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_check_revocation} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_check_revocation} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_get_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_get_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_check_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_check_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_cert_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_cert_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_check_policy} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_check_policy} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_set_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_get_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_new}
  {$EXTERNALSYM X509_STORE_CTX_get1_issuer}
  {$EXTERNALSYM X509_STORE_CTX_free}
  {$EXTERNALSYM X509_STORE_CTX_cleanup}
  {$EXTERNALSYM X509_STORE_CTX_get0_store}
  {$EXTERNALSYM X509_STORE_CTX_get0_cert} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_set_verify_cb}
  {$EXTERNALSYM X509_STORE_CTX_get_verify_cb} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_verify} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_get_issuer} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_check_issued} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_check_revocation} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_get_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_check_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_cert_crl} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_check_policy} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_cleanup} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_add_lookup}
  {$EXTERNALSYM X509_LOOKUP_hash_dir}
  {$EXTERNALSYM X509_LOOKUP_file}
  {$EXTERNALSYM X509_LOOKUP_meth_new} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_free} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_set_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_get_ctrl} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_set_get_by_subject} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_get_get_by_subject} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_set_get_by_issuer_serial} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_get_get_by_issuer_serial} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_set_get_by_fingerprint} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_get_get_by_fingerprint} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_set_get_by_alias} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_meth_get_get_by_alias} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_add_cert}
  {$EXTERNALSYM X509_STORE_add_crl}
  {$EXTERNALSYM X509_STORE_CTX_get_by_subject} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_obj_by_subject} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_ctrl}
  {$EXTERNALSYM X509_load_cert_file}
  {$EXTERNALSYM X509_load_crl_file}
  {$EXTERNALSYM X509_load_cert_crl_file}
  {$EXTERNALSYM X509_LOOKUP_new}
  {$EXTERNALSYM X509_LOOKUP_free}
  {$EXTERNALSYM X509_LOOKUP_init}
  {$EXTERNALSYM X509_LOOKUP_by_subject}
  {$EXTERNALSYM X509_LOOKUP_by_issuer_serial}
  {$EXTERNALSYM X509_LOOKUP_by_fingerprint}
  {$EXTERNALSYM X509_LOOKUP_by_alias}
  {$EXTERNALSYM X509_LOOKUP_set_method_data} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_get_method_data} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_get_store} {introduced 1.1.0}
  {$EXTERNALSYM X509_LOOKUP_shutdown}
  {$EXTERNALSYM X509_STORE_load_locations}
  {$EXTERNALSYM X509_STORE_set_default_paths}
  {$EXTERNALSYM X509_STORE_CTX_set_ex_data}
  {$EXTERNALSYM X509_STORE_CTX_get_ex_data}
  {$EXTERNALSYM X509_STORE_CTX_get_error}
  {$EXTERNALSYM X509_STORE_CTX_set_error}
  {$EXTERNALSYM X509_STORE_CTX_get_error_depth}
  {$EXTERNALSYM X509_STORE_CTX_set_error_depth} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get_current_cert}
  {$EXTERNALSYM X509_STORE_CTX_set_current_cert} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get0_current_issuer}
  {$EXTERNALSYM X509_STORE_CTX_get0_current_crl}
  {$EXTERNALSYM X509_STORE_CTX_get0_parent_ctx}
  {$EXTERNALSYM X509_STORE_CTX_set_cert}
  {$EXTERNALSYM X509_STORE_CTX_set_purpose}
  {$EXTERNALSYM X509_STORE_CTX_set_trust}
  {$EXTERNALSYM X509_STORE_CTX_purpose_inherit}
  {$EXTERNALSYM X509_STORE_CTX_set_flags}
  {$EXTERNALSYM X509_STORE_CTX_get0_policy_tree}
  {$EXTERNALSYM X509_STORE_CTX_get_explicit_policy}
  {$EXTERNALSYM X509_STORE_CTX_get_num_untrusted} {introduced 1.1.0}
  {$EXTERNALSYM X509_STORE_CTX_get0_param}
  {$EXTERNALSYM X509_STORE_CTX_set0_param}
  {$EXTERNALSYM X509_STORE_CTX_set_default}
  {$EXTERNALSYM X509_STORE_CTX_set0_dane} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_new}
  {$EXTERNALSYM X509_VERIFY_PARAM_free}
  {$EXTERNALSYM X509_VERIFY_PARAM_inherit}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1_name}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_flags}
  {$EXTERNALSYM X509_VERIFY_PARAM_clear_flags}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_flags}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_purpose}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_trust}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_depth}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_auth_level} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_add0_policy}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_inh_flags} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_inh_flags} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1_host}
  {$EXTERNALSYM X509_VERIFY_PARAM_add1_host}
  {$EXTERNALSYM X509_VERIFY_PARAM_set_hostflags}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_hostflags} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_get0_peername}
  {$EXTERNALSYM X509_VERIFY_PARAM_move_peername} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1_email}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1_ip}
  {$EXTERNALSYM X509_VERIFY_PARAM_set1_ip_asc}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_depth}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_auth_level} {introduced 1.1.0}
  {$EXTERNALSYM X509_VERIFY_PARAM_get0_name}
  {$EXTERNALSYM X509_VERIFY_PARAM_add0_table}
  {$EXTERNALSYM X509_VERIFY_PARAM_get_count}
  {$EXTERNALSYM X509_VERIFY_PARAM_get0}
  {$EXTERNALSYM X509_VERIFY_PARAM_lookup}
  {$EXTERNALSYM X509_VERIFY_PARAM_table_cleanup}
  {$EXTERNALSYM X509_policy_tree_free}
  {$EXTERNALSYM X509_policy_tree_level_count}
  {$EXTERNALSYM X509_policy_tree_get0_level}
  {$EXTERNALSYM X509_policy_level_node_count}
  {$EXTERNALSYM X509_policy_level_get0_node}
  {$EXTERNALSYM X509_policy_node_get0_policy}
  {$EXTERNALSYM X509_policy_node_get0_parent}
{helper_functions}
function X509_LOOKUP_load_file(ctx: PX509_LOOKUP; name: PIdAnsiChar; type_: TIdC_LONG): TIdC_INT;
{\helper_functions}


{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM X509_STORE_CTX_get_app_data} {removed 1.0.0}
  X509_STORE_set_depth: function(store: PX509_STORE; depth: TIdC_INT): TIdC_INT; cdecl = nil;

  X509_STORE_CTX_set_depth: procedure(ctx: PX509_STORE_CTX; depth: TIdC_INT); cdecl = nil;

  //# define X509_STORE_CTX_set_app_data(ctx,data) \
  //        X509_STORE_CTX_set_ex_data(ctx,0,data)
  //# define X509_STORE_CTX_get_app_data(ctx) \
  //        X509_STORE_CTX_get_ex_data(ctx,0)
  X509_STORE_CTX_get_app_data: function(ctx: PX509_STORE_CTX): Pointer; cdecl = nil; {removed 1.0.0}
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
  X509_OBJECT_up_ref_count: function(a: PX509_OBJECT): TIdC_INT; cdecl = nil;
  X509_OBJECT_new: function: PX509_OBJECT; cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_free: procedure(a: PX509_OBJECT); cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_get_type: function(const a: PX509_OBJECT): X509_LOOKUP_TYPE; cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_get0_X509: function(const a: PX509_OBJECT): PX509; cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_set1_X509: function(a: PX509_OBJECT; obj: PX509): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_get0_X509_CRL: function(a: PX509_OBJECT): PX509_CRL; cdecl = nil; {introduced 1.1.0}
  X509_OBJECT_set1_X509_CRL: function(a: PX509_OBJECT; obj: PX509_CRL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_STORE_new: function: PX509_STORE; cdecl = nil;
  X509_STORE_free: procedure(v: PX509_STORE); cdecl = nil;
  X509_STORE_lock: function(ctx: PX509_STORE): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_STORE_unlock: function(ctx: PX509_STORE): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_STORE_up_ref: function(v: PX509_STORE): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  //STACK_OF(X509_OBJECT) *X509_STORE_get0_objects(X509_STORE *v);

  //STACK_OF(X509) *X509_STORE_CTX_get1_certs(X509_STORE_CTX *st, X509_NAME *nm);
  //STACK_OF(X509_CRL) *X509_STORE_CTX_get1_crls(X509_STORE_CTX *st, X509_NAME *nm);
  X509_STORE_set_flags: function(ctx: PX509_STORE; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;
  X509_STORE_set_purpose: function(ctx: PX509_STORE; purpose: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_STORE_set_trust: function(ctx: PX509_STORE; trust: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_STORE_set1_param: function(ctx: PX509_STORE; pm: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  X509_STORE_get0_param: function(ctx: PX509_STORE): PX509_VERIFY_PARAM; cdecl = nil; {introduced 1.1.0}

  X509_STORE_set_verify: procedure(ctx: PX509_STORE; verify: X509_STORE_CTX_verify_fn); cdecl = nil; {introduced 1.1.0}
  //#define X509_STORE_set_verify_func(ctx, func) \
  //            X509_STORE_set_verify((ctx),(func))
  X509_STORE_CTX_set_verify: procedure(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_verify: function(ctx: PX509_STORE): X509_STORE_CTX_verify_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_verify_cb: procedure(ctx: PX509_STORE; verify_cb: X509_STORE_CTX_verify_cb); cdecl = nil;
  //# define X509_STORE_set_verify_cb_func(ctx,func) \
  //            X509_STORE_set_verify_cb((ctx),(func))
  X509_STORE_get_verify_cb: function(ctx: PX509_STORE): X509_STORE_CTX_verify_cb; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_get_issuer: procedure(ctx: PX509_STORE; get_issuer: X509_STORE_CTX_get_issuer_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_get_issuer: function(ctx: PX509_STORE): X509_STORE_CTX_get_issuer_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_check_issued: procedure(ctx: PX509_STORE; check_issued: X509_STORE_CTX_check_issued_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_check_issued: function(ctx: PX509_STORE): X509_STORE_CTX_check_issued_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_check_revocation: procedure(ctx: PX509_STORE; check_revocation: X509_STORE_CTX_check_revocation_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_check_revocation: function(ctx: PX509_STORE): X509_STORE_CTX_check_revocation_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_get_crl: procedure(ctx: PX509_STORE; get_crl: X509_STORE_CTX_get_crl_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_get_crl: function(ctx: PX509_STORE): X509_STORE_CTX_get_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_check_crl: procedure(ctx: PX509_STORE; check_crl: X509_STORE_CTX_check_crl_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_check_crl: function(ctx: PX509_STORE): X509_STORE_CTX_check_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_cert_crl: procedure(ctx: PX509_STORE; cert_crl: X509_STORE_CTX_cert_crl_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_cert_crl: function(ctx: PX509_STORE): X509_STORE_CTX_cert_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_set_check_policy: procedure(ctx: PX509_STORE; check_policy: X509_STORE_CTX_check_policy_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_check_policy: function(ctx: PX509_STORE): X509_STORE_CTX_check_policy_fn; cdecl = nil; {introduced 1.1.0}
//  procedure X509_STORE_set_lookup_certs(ctx: PX509_STORE; lookup_certs: X509_STORE_CTX_lookup_certs_fn);
//  function X509_STORE_get_lookup_certs(ctx: PX509_STORE): X509_STORE_CTX_lookup_certs_fn;
//  procedure X509_STORE_set_lookup_crls(ctx: PX509_STORE; lookup_crls: X509_STORE_CTX_lookup_crls_fn);
//  #define X509_STORE_set_lookup_crls_cb(ctx, func) \
//      X509_STORE_set_lookup_crls((ctx), (func))
//  function X509_STORE_get_lookup_crls(ctx: PX509_STORE): X509_STORE_CTX_lookup_crls_fn;
  X509_STORE_set_cleanup: procedure(ctx: PX509_STORE; cleanup: X509_STORE_CTX_cleanup_fn); cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_cleanup: function(ctx: PX509_STORE): X509_STORE_CTX_cleanup_fn; cdecl = nil; {introduced 1.1.0}

  //#define X509_STORE_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE, l, p, newf, dupf, freef)
  X509_STORE_set_ex_data: function(ctx: PX509_STORE; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_STORE_get_ex_data: function(ctx: PX509_STORE; idx: TIdC_INT): Pointer; cdecl = nil; {introduced 1.1.0}

  X509_STORE_CTX_new: function: PX509_STORE_CTX; cdecl = nil;

  X509_STORE_CTX_get1_issuer: function(issuer: PPX509; ctx: PX509_STORE_CTX; x: PX509): TIdC_INT; cdecl = nil;

  X509_STORE_CTX_free: procedure(ctx: PX509_STORE_CTX); cdecl = nil;
//  TIdC_INT X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: P STACK_OF(X509));
//  procedure X509_STORE_CTX_set0_trusted_stack(ctx: PX509_STORE_CTX; sk: P STACK_OF(X509));
  X509_STORE_CTX_cleanup: procedure(ctx: PX509_STORE_CTX); cdecl = nil;

  X509_STORE_CTX_get0_store: function(ctx: PX509_STORE_CTX): PX509_STORE; cdecl = nil;
  X509_STORE_CTX_get0_cert: function(ctx: PX509_STORE_CTX): PX509; cdecl = nil; {introduced 1.1.0}
  //STACK_OF(X509)* X509_STORE_CTX_get0_untrusted(X509_STORE_CTX *ctx);
  //void X509_STORE_CTX_set0_untrusted(X509_STORE_CTX *ctx, STACK_OF(X509) *sk);
  X509_STORE_CTX_set_verify_cb: procedure(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_cb); cdecl = nil;
  X509_STORE_CTX_get_verify_cb: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_cb; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_verify: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_get_issuer: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_issuer_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_issued: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_issued_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_revocation: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_revocation_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_get_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_cert_crl: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_cert_crl_fn; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_policy: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_policy_fn; cdecl = nil; {introduced 1.1.0}
//  function X509_STORE_CTX_get_lookup_certs(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_certs_fn;
//  function X509_STORE_CTX_get_lookup_crls(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_crls_fn;
  X509_STORE_CTX_get_cleanup: function(ctx: PX509_STORE_CTX): X509_STORE_CTX_cleanup_fn; cdecl = nil; {introduced 1.1.0}

  X509_STORE_add_lookup: function(v: PX509_STORE; m: PX509_LOOKUP_METHOD): PX509_LOOKUP; cdecl = nil;
  X509_LOOKUP_hash_dir: function: PX509_LOOKUP_METHOD; cdecl = nil;
  X509_LOOKUP_file: function: PX509_LOOKUP_METHOD; cdecl = nil;

  X509_LOOKUP_meth_new: function(const name: PIdAnsiChar): PX509_LOOKUP_METHOD; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_free: procedure(method: PX509_LOOKUP_METHOD); cdecl = nil; {introduced 1.1.0}

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

  X509_LOOKUP_meth_set_ctrl: function(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_ctrl: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_ctrl_fn; cdecl = nil; {introduced 1.1.0}

  X509_LOOKUP_meth_set_get_by_subject: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_subject_fn): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_subject: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_subject_fn; cdecl = nil; {introduced 1.1.0}

  X509_LOOKUP_meth_set_get_by_issuer_serial: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_issuer_serial_fn): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_issuer_serial: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_issuer_serial_fn; cdecl = nil; {introduced 1.1.0}

  X509_LOOKUP_meth_set_get_by_fingerprint: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_fingerprint_fn): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_fingerprint: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_fingerprint_fn; cdecl = nil; {introduced 1.1.0}

  X509_LOOKUP_meth_set_get_by_alias: function(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_alias_fn): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_alias: function(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_alias_fn; cdecl = nil; {introduced 1.1.0}

  X509_STORE_add_cert: function(ctx: PX509_STORE; x: PX509): TIdC_INT; cdecl = nil;
  X509_STORE_add_crl: function(ctx: PX509_STORE; x: PX509_CRL): TIdC_INT; cdecl = nil;

  X509_STORE_CTX_get_by_subject: function(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_obj_by_subject: function(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME): PX509_OBJECT; cdecl = nil; {introduced 1.1.0}

  X509_LOOKUP_ctrl: function(ctx: PX509_LOOKUP; cmd: TIdC_INT; const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT; cdecl = nil;

  X509_load_cert_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_load_crl_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_load_cert_crl_file: function(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;

  X509_LOOKUP_new: function(method: PX509_LOOKUP_METHOD): PX509_LOOKUP; cdecl = nil;
  X509_LOOKUP_free: procedure(ctx: PX509_LOOKUP); cdecl = nil;
  X509_LOOKUP_init: function(ctx: PX509_LOOKUP): TIdC_INT; cdecl = nil;
  X509_LOOKUP_by_subject: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT; cdecl = nil;
  X509_LOOKUP_by_issuer_serial: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT; cdecl = nil;
  X509_LOOKUP_by_fingerprint: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT; cdecl = nil;
  X509_LOOKUP_by_alias: function(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT; cdecl = nil;
  X509_LOOKUP_set_method_data: function(ctx: PX509_LOOKUP; data: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_get_method_data: function(const ctx: PX509_LOOKUP): Pointer; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_get_store: function(const ctx: PX509_LOOKUP): PX509_STORE; cdecl = nil; {introduced 1.1.0}
  X509_LOOKUP_shutdown: function(ctx: PX509_LOOKUP): TIdC_INT; cdecl = nil;

  X509_STORE_load_locations: function(ctx: PX509_STORE; const file_: PIdAnsiChar; const dir: PIdAnsiChar): TIdC_INT; cdecl = nil;
  X509_STORE_set_default_paths: function(ctx: PX509_STORE): TIdC_INT; cdecl = nil;

  //#define X509_STORE_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE_CTX, l, p, newf, dupf, freef)
  X509_STORE_CTX_set_ex_data: function(ctx: PX509_STORE_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_get_ex_data: function(ctx: PX509_STORE_CTX; idx: TIdC_INT): Pointer; cdecl = nil;
  X509_STORE_CTX_get_error: function(ctx: PX509_STORE_CTX): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_set_error: procedure(ctx: X509_STORE_CTX; s: TIdC_INT); cdecl = nil;
  X509_STORE_CTX_get_error_depth: function(ctx: PX509_STORE_CTX): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_set_error_depth: procedure(ctx: PX509_STORE_CTX; depth: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get_current_cert: function(ctx: PX509_STORE_CTX): PX509; cdecl = nil;
  X509_STORE_CTX_set_current_cert: procedure(ctx: PX509_STORE_CTX; x: PX509); cdecl = nil; {introduced 1.1.0}
  X509_STORE_CTX_get0_current_issuer: function(ctx: PX509_STORE_CTX): PX509; cdecl = nil;
  X509_STORE_CTX_get0_current_crl: function(ctx: PX509_STORE_CTX): PX509_CRL; cdecl = nil;
  X509_STORE_CTX_get0_parent_ctx: function(ctx: PX509_STORE_CTX): PX509_STORE_CTX; cdecl = nil;
//  STACK_OF(X509) *X509_STORE_CTX_get0_chain(X509_STORE_CTX *ctx);
//  STACK_OF(X509) *X509_STORE_CTX_get1_chain(X509_STORE_CTX *ctx);
  X509_STORE_CTX_set_cert: procedure(c: PX509_STORE_CTX; x: PX509); cdecl = nil;
//  void X509_STORE_CTX_set0_verified_chain(X509_STORE_CTX *c, STACK_OF(X509) *sk);
//  void X509_STORE_CTX_set0_crls(X509_STORE_CTX *c, STACK_OF(X509_CRL) *sk);
  X509_STORE_CTX_set_purpose: function(ctx: PX509_STORE_CTX; purpose: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_set_trust: function(ctx: PX509_STORE_CTX; trust: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_purpose_inherit: function(ctx: PX509_STORE_CTX; def_purpose: TIdC_INT; purpose: TIdC_INT; trust: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_set_flags: procedure(ctx: PX509_STORE_CTX; flags: TIdC_ULONG); cdecl = nil;
//  procedure X509_STORE_CTX_set_time(ctx: PX509_STORE_CTX; flags: TIdC_ULONG; t: TIdC_TIMET);

  X509_STORE_CTX_get0_policy_tree: function(ctx: PX509_STORE_CTX): PX509_POLICY_TREE; cdecl = nil;
  X509_STORE_CTX_get_explicit_policy: function(ctx: PX509_STORE_CTX): TIdC_INT; cdecl = nil;
  X509_STORE_CTX_get_num_untrusted: function(ctx: PX509_STORE_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  X509_STORE_CTX_get0_param: function(ctx: PX509_STORE_CTX): PX509_VERIFY_PARAM; cdecl = nil;
  X509_STORE_CTX_set0_param: procedure(ctx: PX509_STORE_CTX; param: PX509_VERIFY_PARAM); cdecl = nil;
  X509_STORE_CTX_set_default: function(ctx: PX509_STORE_CTX; const name: PIdAnsiChar): TIdC_INT; cdecl = nil;

  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  X509_STORE_CTX_set0_dane: procedure(ctx: PX509_STORE_CTX; dane: PSSL_DANE); cdecl = nil; {introduced 1.1.0}

  (* X509_VERIFY_PARAM functions *)

  X509_VERIFY_PARAM_new: function: PX509_VERIFY_PARAM; cdecl = nil;
  X509_VERIFY_PARAM_free: procedure(param: PX509_VERIFY_PARAM); cdecl = nil;
  X509_VERIFY_PARAM_inherit: function(to_: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set1: function(to_: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set1_name: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_clear_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_get_flags: function(param: PX509_VERIFY_PARAM): TIdC_ULONG; cdecl = nil;
  X509_VERIFY_PARAM_set_purpose: function(param: PX509_VERIFY_PARAM; purpose: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set_trust: function(param: PX509_VERIFY_PARAM; trust: TIdC_INT): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set_depth: procedure(param: PX509_VERIFY_PARAM; depth: TIdC_INT); cdecl = nil;
  X509_VERIFY_PARAM_set_auth_level: procedure(param: PX509_VERIFY_PARAM; auth_level: TIdC_INT); cdecl = nil; {introduced 1.1.0}
//  function X509_VERIFY_PARAM_get_time(const param: PX509_VERIFY_PARAM): TIdC_TIMET;
//  procedure X509_VERIFY_PARAM_set_time(param: PX509_VERIFY_PARAM; t: TIdC_TIMET);
  X509_VERIFY_PARAM_add0_policy: function(param: PX509_VERIFY_PARAM; policy: PASN1_OBJECT): TIdC_INT; cdecl = nil;
  //TIdC_INT X509_VERIFY_PARAM_set1_policies(X509_VERIFY_PARAM *param,
  //                                    STACK_OF(ASN1_OBJECT) *policies);

  X509_VERIFY_PARAM_set_inh_flags: function(param: PX509_VERIFY_PARAM; flags: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_get_inh_flags: function(const param: PX509_VERIFY_PARAM): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}

  X509_VERIFY_PARAM_set1_host: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_add1_host: function(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set_hostflags: procedure(param: PX509_VERIFY_PARAM; flags: TIdC_UINT); cdecl = nil;
  X509_VERIFY_PARAM_get_hostflags: function(const param: PX509_VERIFY_PARAM): TIdC_UINT; cdecl = nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_get0_peername: function(v1: PX509_VERIFY_PARAM): PIdAnsiChar; cdecl = nil;
  X509_VERIFY_PARAM_move_peername: procedure(v1: PX509_VERIFY_PARAM; v2: PX509_VERIFY_PARAM); cdecl = nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_set1_email: function(param: PX509_VERIFY_PARAM; const email: PIdAnsiChar; emaillen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set1_ip: function(param: PX509_VERIFY_PARAM; const ip: PByte; iplen: TIdC_SIZET): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_set1_ip_asc: function(param: PX509_VERIFY_PARAM; const ipasc: PIdAnsiChar): TIdC_INT; cdecl = nil;

  X509_VERIFY_PARAM_get_depth: function(const param: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_get_auth_level: function(const param: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_get0_name: function(const param: PX509_VERIFY_PARAM): PIdAnsiChar; cdecl = nil;

  X509_VERIFY_PARAM_add0_table: function(param: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_get_count: function: TIdC_INT; cdecl = nil;
  X509_VERIFY_PARAM_get0: function(id: TIdC_INT): PX509_VERIFY_PARAM; cdecl = nil;
  X509_VERIFY_PARAM_lookup: function(const name: PIdAnsiChar): X509_VERIFY_PARAM; cdecl = nil;
  X509_VERIFY_PARAM_table_cleanup: procedure; cdecl = nil;

  //TIdC_INT X509_policy_check(X509_POLICY_TREE **ptree, TIdC_INT *pexplicit_policy,
  //                      STACK_OF(X509) *certs,
  //                      STACK_OF(ASN1_OBJECT) *policy_oids, TIdC_UINT flags);

  X509_policy_tree_free: procedure(tree: PX509_POLICY_TREE); cdecl = nil;

  X509_policy_tree_level_count: function(const tree: PX509_POLICY_TREE): TIdC_INT; cdecl = nil;
  X509_policy_tree_get0_level: function(const tree: PX509_POLICY_TREE; i: TIdC_INT): PX509_POLICY_LEVEL; cdecl = nil;

  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_policies(const
  //                                                           X509_POLICY_TREE
  //                                                           *tree);
  //
  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_user_policies(const
  //                                                                X509_POLICY_TREE
  //                                                                *tree);

  X509_policy_level_node_count: function(level: PX509_POLICY_LEVEL): TIdC_INT; cdecl = nil;

  X509_policy_level_get0_node: function(level: PX509_POLICY_LEVEL; i: TIdC_INT): PX509_POLICY_NODE; cdecl = nil;

  X509_policy_node_get0_policy: function(const node: PX509_POLICY_NODE): PASN1_OBJECT; cdecl = nil;

  //STACK_OF(POLICYQUALINFO) *X509_policy_node_get0_qualifiers(const
  //                                                           X509_POLICY_NODE
  //                                                           *node);
  X509_policy_node_get0_parent: function(const node: PX509_POLICY_NODE): PX509_POLICY_NODE; cdecl = nil;

{$ELSE}
  function X509_STORE_set_depth(store: PX509_STORE; depth: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure X509_STORE_CTX_set_depth(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  function X509_OBJECT_up_ref_count(a: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_OBJECT_new: PX509_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_OBJECT_free(a: PX509_OBJECT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_OBJECT_get_type(const a: PX509_OBJECT): X509_LOOKUP_TYPE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_OBJECT_get0_X509(const a: PX509_OBJECT): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_OBJECT_set1_X509(a: PX509_OBJECT; obj: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_OBJECT_get0_X509_CRL(a: PX509_OBJECT): PX509_CRL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_OBJECT_set1_X509_CRL(a: PX509_OBJECT; obj: PX509_CRL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_new: PX509_STORE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_free(v: PX509_STORE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_lock(ctx: PX509_STORE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_unlock(ctx: PX509_STORE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_up_ref(v: PX509_STORE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //STACK_OF(X509_OBJECT) *X509_STORE_get0_objects(X509_STORE *v);

  //STACK_OF(X509) *X509_STORE_CTX_get1_certs(X509_STORE_CTX *st, X509_NAME *nm);
  //STACK_OF(X509_CRL) *X509_STORE_CTX_get1_crls(X509_STORE_CTX *st, X509_NAME *nm);
  function X509_STORE_set_flags(ctx: PX509_STORE; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_set_purpose(ctx: PX509_STORE; purpose: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_set_trust(ctx: PX509_STORE; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_set1_param(ctx: PX509_STORE; pm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_get0_param(ctx: PX509_STORE): PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  procedure X509_STORE_set_verify(ctx: PX509_STORE; verify: X509_STORE_CTX_verify_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //#define X509_STORE_set_verify_func(ctx, func) \
  //            X509_STORE_set_verify((ctx),(func))
  procedure X509_STORE_CTX_set_verify(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_verify(ctx: PX509_STORE): X509_STORE_CTX_verify_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_verify_cb(ctx: PX509_STORE; verify_cb: X509_STORE_CTX_verify_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //# define X509_STORE_set_verify_cb_func(ctx,func) \
  //            X509_STORE_set_verify_cb((ctx),(func))
  function X509_STORE_get_verify_cb(ctx: PX509_STORE): X509_STORE_CTX_verify_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_get_issuer(ctx: PX509_STORE; get_issuer: X509_STORE_CTX_get_issuer_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_get_issuer(ctx: PX509_STORE): X509_STORE_CTX_get_issuer_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_check_issued(ctx: PX509_STORE; check_issued: X509_STORE_CTX_check_issued_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_check_issued(ctx: PX509_STORE): X509_STORE_CTX_check_issued_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_check_revocation(ctx: PX509_STORE; check_revocation: X509_STORE_CTX_check_revocation_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_check_revocation(ctx: PX509_STORE): X509_STORE_CTX_check_revocation_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_get_crl(ctx: PX509_STORE; get_crl: X509_STORE_CTX_get_crl_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_get_crl(ctx: PX509_STORE): X509_STORE_CTX_get_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_check_crl(ctx: PX509_STORE; check_crl: X509_STORE_CTX_check_crl_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_check_crl(ctx: PX509_STORE): X509_STORE_CTX_check_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_cert_crl(ctx: PX509_STORE; cert_crl: X509_STORE_CTX_cert_crl_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_cert_crl(ctx: PX509_STORE): X509_STORE_CTX_cert_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_STORE_set_check_policy(ctx: PX509_STORE; check_policy: X509_STORE_CTX_check_policy_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_check_policy(ctx: PX509_STORE): X509_STORE_CTX_check_policy_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
//  procedure X509_STORE_set_lookup_certs(ctx: PX509_STORE; lookup_certs: X509_STORE_CTX_lookup_certs_fn);
//  function X509_STORE_get_lookup_certs(ctx: PX509_STORE): X509_STORE_CTX_lookup_certs_fn;
//  procedure X509_STORE_set_lookup_crls(ctx: PX509_STORE; lookup_crls: X509_STORE_CTX_lookup_crls_fn);
//  #define X509_STORE_set_lookup_crls_cb(ctx, func) \
//      X509_STORE_set_lookup_crls((ctx), (func))
//  function X509_STORE_get_lookup_crls(ctx: PX509_STORE): X509_STORE_CTX_lookup_crls_fn;
  procedure X509_STORE_set_cleanup(ctx: PX509_STORE; cleanup: X509_STORE_CTX_cleanup_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_cleanup(ctx: PX509_STORE): X509_STORE_CTX_cleanup_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  //#define X509_STORE_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE, l, p, newf, dupf, freef)
  function X509_STORE_set_ex_data(ctx: PX509_STORE; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_get_ex_data(ctx: PX509_STORE; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_STORE_CTX_new: PX509_STORE_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_STORE_CTX_get1_issuer(issuer: PPX509; ctx: PX509_STORE_CTX; x: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure X509_STORE_CTX_free(ctx: PX509_STORE_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  TIdC_INT X509_STORE_CTX_init(ctx: PX509_STORE_CTX; store: PX509_STORE; x509: PX509; chain: P STACK_OF(X509));
//  procedure X509_STORE_CTX_set0_trusted_stack(ctx: PX509_STORE_CTX; sk: P STACK_OF(X509));
  procedure X509_STORE_CTX_cleanup(ctx: PX509_STORE_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_STORE_CTX_get0_store(ctx: PX509_STORE_CTX): PX509_STORE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get0_cert(ctx: PX509_STORE_CTX): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  //STACK_OF(X509)* X509_STORE_CTX_get0_untrusted(X509_STORE_CTX *ctx);
  //void X509_STORE_CTX_set0_untrusted(X509_STORE_CTX *ctx, STACK_OF(X509) *sk);
  procedure X509_STORE_CTX_set_verify_cb(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_verify_cb(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_verify(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_get_issuer(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_issuer_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_check_issued(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_issued_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_check_revocation(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_revocation_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_get_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_check_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_cert_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_cert_crl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_check_policy(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_policy_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
//  function X509_STORE_CTX_get_lookup_certs(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_certs_fn;
//  function X509_STORE_CTX_get_lookup_crls(ctx: PX509_STORE_CTX): X509_STORE_CTX_lookup_crls_fn;
  function X509_STORE_CTX_get_cleanup(ctx: PX509_STORE_CTX): X509_STORE_CTX_cleanup_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_STORE_add_lookup(v: PX509_STORE; m: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_hash_dir: PX509_LOOKUP_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_file: PX509_LOOKUP_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_LOOKUP_meth_new(const name: PIdAnsiChar): PX509_LOOKUP_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure X509_LOOKUP_meth_free(method: PX509_LOOKUP_METHOD) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

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

  function X509_LOOKUP_meth_set_ctrl(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_meth_get_ctrl(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_ctrl_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_LOOKUP_meth_set_get_by_subject(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_subject_fn): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_meth_get_get_by_subject(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_subject_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_LOOKUP_meth_set_get_by_issuer_serial(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_issuer_serial_fn): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_meth_get_get_by_issuer_serial(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_issuer_serial_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_LOOKUP_meth_set_get_by_fingerprint(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_fingerprint_fn): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_meth_get_get_by_fingerprint(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_fingerprint_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_LOOKUP_meth_set_get_by_alias(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_alias_fn): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_meth_get_get_by_alias(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_alias_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_STORE_add_cert(ctx: PX509_STORE; x: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_add_crl(ctx: PX509_STORE; x: PX509_CRL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_STORE_CTX_get_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_obj_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME): PX509_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_LOOKUP_ctrl(ctx: PX509_LOOKUP; cmd: TIdC_INT; const argc: PIdAnsiChar; argl: TIdC_LONG; ret: PPIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_load_cert_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_load_crl_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_load_cert_crl_file(ctx: PX509_LOOKUP; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_LOOKUP_new(method: PX509_LOOKUP_METHOD): PX509_LOOKUP cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_LOOKUP_free(ctx: PX509_LOOKUP) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_init(ctx: PX509_LOOKUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_by_subject(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_by_issuer_serial(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; name: PX509_NAME; serial: PASN1_INTEGER; ret: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_by_fingerprint(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const bytes: PByte; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_by_alias(ctx: PX509_LOOKUP; type_: X509_LOOKUP_TYPE; const str: PIdAnsiChar; len: TIdC_INT; ret: PX509_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_LOOKUP_set_method_data(ctx: PX509_LOOKUP; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_get_method_data(const ctx: PX509_LOOKUP): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_get_store(const ctx: PX509_LOOKUP): PX509_STORE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_LOOKUP_shutdown(ctx: PX509_LOOKUP): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_STORE_load_locations(ctx: PX509_STORE; const file_: PIdAnsiChar; const dir: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_set_default_paths(ctx: PX509_STORE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //#define X509_STORE_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_X509_STORE_CTX, l, p, newf, dupf, freef)
  function X509_STORE_CTX_set_ex_data(ctx: PX509_STORE_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_ex_data(ctx: PX509_STORE_CTX; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_error(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_CTX_set_error(ctx: X509_STORE_CTX; s: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_error_depth(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_CTX_set_error_depth(ctx: PX509_STORE_CTX; depth: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get_current_cert(ctx: PX509_STORE_CTX): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_CTX_set_current_cert(ctx: PX509_STORE_CTX; x: PX509) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_STORE_CTX_get0_current_issuer(ctx: PX509_STORE_CTX): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get0_current_crl(ctx: PX509_STORE_CTX): PX509_CRL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get0_parent_ctx(ctx: PX509_STORE_CTX): PX509_STORE_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  STACK_OF(X509) *X509_STORE_CTX_get0_chain(X509_STORE_CTX *ctx);
//  STACK_OF(X509) *X509_STORE_CTX_get1_chain(X509_STORE_CTX *ctx);
  procedure X509_STORE_CTX_set_cert(c: PX509_STORE_CTX; x: PX509) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  void X509_STORE_CTX_set0_verified_chain(X509_STORE_CTX *c, STACK_OF(X509) *sk);
//  void X509_STORE_CTX_set0_crls(X509_STORE_CTX *c, STACK_OF(X509_CRL) *sk);
  function X509_STORE_CTX_set_purpose(ctx: PX509_STORE_CTX; purpose: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_set_trust(ctx: PX509_STORE_CTX; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_purpose_inherit(ctx: PX509_STORE_CTX; def_purpose: TIdC_INT; purpose: TIdC_INT; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_CTX_set_flags(ctx: PX509_STORE_CTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  procedure X509_STORE_CTX_set_time(ctx: PX509_STORE_CTX; flags: TIdC_ULONG; t: TIdC_TIMET);

  function X509_STORE_CTX_get0_policy_tree(ctx: PX509_STORE_CTX): PX509_POLICY_TREE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_explicit_policy(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_get_num_untrusted(ctx: PX509_STORE_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_STORE_CTX_get0_param(ctx: PX509_STORE_CTX): PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_STORE_CTX_set0_param(ctx: PX509_STORE_CTX; param: PX509_VERIFY_PARAM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_STORE_CTX_set_default(ctx: PX509_STORE_CTX; const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  procedure X509_STORE_CTX_set0_dane(ctx: PX509_STORE_CTX; dane: PSSL_DANE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  (* X509_VERIFY_PARAM functions *)

  function X509_VERIFY_PARAM_new: PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_free(param: PX509_VERIFY_PARAM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_inherit(to_: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set1(to_: PX509_VERIFY_PARAM; const from: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set1_name(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set_flags(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_clear_flags(param: PX509_VERIFY_PARAM; flags: TIdC_ULONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_get_flags(param: PX509_VERIFY_PARAM): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set_purpose(param: PX509_VERIFY_PARAM; purpose: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set_trust(param: PX509_VERIFY_PARAM; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_set_depth(param: PX509_VERIFY_PARAM; depth: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_set_auth_level(param: PX509_VERIFY_PARAM; auth_level: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
//  function X509_VERIFY_PARAM_get_time(const param: PX509_VERIFY_PARAM): TIdC_TIMET;
//  procedure X509_VERIFY_PARAM_set_time(param: PX509_VERIFY_PARAM; t: TIdC_TIMET);
  function X509_VERIFY_PARAM_add0_policy(param: PX509_VERIFY_PARAM; policy: PASN1_OBJECT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  //TIdC_INT X509_VERIFY_PARAM_set1_policies(X509_VERIFY_PARAM *param,
  //                                    STACK_OF(ASN1_OBJECT) *policies);

  function X509_VERIFY_PARAM_set_inh_flags(param: PX509_VERIFY_PARAM; flags: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_VERIFY_PARAM_get_inh_flags(const param: PX509_VERIFY_PARAM): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function X509_VERIFY_PARAM_set1_host(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_add1_host(param: PX509_VERIFY_PARAM; const name: PIdAnsiChar; namelen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_set_hostflags(param: PX509_VERIFY_PARAM; flags: TIdC_UINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_get_hostflags(const param: PX509_VERIFY_PARAM): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_VERIFY_PARAM_get0_peername(v1: PX509_VERIFY_PARAM): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_move_peername(v1: PX509_VERIFY_PARAM; v2: PX509_VERIFY_PARAM) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_VERIFY_PARAM_set1_email(param: PX509_VERIFY_PARAM; const email: PIdAnsiChar; emaillen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set1_ip(param: PX509_VERIFY_PARAM; const ip: PByte; iplen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_set1_ip_asc(param: PX509_VERIFY_PARAM; const ipasc: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_VERIFY_PARAM_get_depth(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_get_auth_level(const param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function X509_VERIFY_PARAM_get0_name(const param: PX509_VERIFY_PARAM): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_VERIFY_PARAM_add0_table(param: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_get_count: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_get0(id: TIdC_INT): PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_VERIFY_PARAM_lookup(const name: PIdAnsiChar): X509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure X509_VERIFY_PARAM_table_cleanup cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //TIdC_INT X509_policy_check(X509_POLICY_TREE **ptree, TIdC_INT *pexplicit_policy,
  //                      STACK_OF(X509) *certs,
  //                      STACK_OF(ASN1_OBJECT) *policy_oids, TIdC_UINT flags);

  procedure X509_policy_tree_free(tree: PX509_POLICY_TREE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_policy_tree_level_count(const tree: PX509_POLICY_TREE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function X509_policy_tree_get0_level(const tree: PX509_POLICY_TREE; i: TIdC_INT): PX509_POLICY_LEVEL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_policies(const
  //                                                           X509_POLICY_TREE
  //                                                           *tree);
  //
  //STACK_OF(X509_POLICY_NODE) *X509_policy_tree_get0_user_policies(const
  //                                                                X509_POLICY_TREE
  //                                                                *tree);

  function X509_policy_level_node_count(level: PX509_POLICY_LEVEL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_policy_level_get0_node(level: PX509_POLICY_LEVEL; i: TIdC_INT): PX509_POLICY_NODE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function X509_policy_node_get0_policy(const node: PX509_POLICY_NODE): PASN1_OBJECT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  //STACK_OF(POLICYQUALINFO) *X509_policy_node_get0_qualifiers(const
  //                                                           X509_POLICY_NODE
  //                                                           *node);
  function X509_policy_node_get0_parent(const node: PX509_POLICY_NODE): PX509_POLICY_NODE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

function X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX): Pointer; {removed 1.0.0}
{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  
const
  X509_OBJECT_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_get_type_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_get0_X509_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_set1_X509_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_get0_X509_CRL_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_OBJECT_set1_X509_CRL_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_lock_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_unlock_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get0_param_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_set_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_verify_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_get_issuer_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_get_issuer_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_check_issued_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_check_issued_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_check_revocation_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_check_revocation_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_get_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_get_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_check_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_check_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_cert_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_cert_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_check_policy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_check_policy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_set_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_get_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get0_cert_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_verify_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_verify_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_get_issuer_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_check_issued_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_check_revocation_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_get_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_check_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_cert_crl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_check_policy_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_cleanup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_set_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_get_ctrl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_set_get_by_subject_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_get_get_by_subject_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_set_get_by_issuer_serial_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_get_get_by_issuer_serial_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_set_get_by_fingerprint_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_get_get_by_fingerprint_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_set_get_by_alias_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_meth_get_get_by_alias_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_by_subject_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_obj_by_subject_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_set_method_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_get_method_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_LOOKUP_get_store_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_set_error_depth_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_set_current_cert_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_num_untrusted_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_set0_dane_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_set_auth_level_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_set_inh_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_get_inh_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_get_hostflags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_move_peername_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_VERIFY_PARAM_get_auth_level_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  X509_STORE_CTX_get_app_data_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);

{helper_functions}
function X509_LOOKUP_load_file(ctx: PX509_LOOKUP; name: PIdAnsiChar; type_: TIdC_LONG): TIdC_INT;
begin
  Result := X509_LOOKUP_ctrl(ctx,X509_L_FILE_LOAD,name,type_,nil);
end;
{\helper_functions}


{$IFNDEF USE_EXTERNAL_LIBRARY}

function _X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX): Pointer; cdecl;
begin
  Result := X509_STORE_CTX_get_ex_data(ctx,SSL_get_ex_data_X509_STORE_CTX_idx);
end;


{forward_compatibility}
type
 _PX509_LOOKUP_METHOD      = ^_X509_LOOKUP_METHOD;
 _X509_LOOKUP_METHOD = record
    name : PIdAnsiChar;
    new_item : function (ctx : PX509_LOOKUP): TIdC_INT; cdecl;
    free : procedure (ctx : PX509_LOOKUP); cdecl;
    init : function(ctx : PX509_LOOKUP) : TIdC_INT; cdecl;
    shutdown : function(ctx : PX509_LOOKUP) : TIdC_INT; cdecl;
    ctrl: function(ctx : PX509_LOOKUP; cmd : TIdC_INT; const argc : PIdAnsiChar; argl : TIdC_LONG; out ret : PIdAnsiChar ) : TIdC_INT; cdecl;
    get_by_subject: function(ctx : PX509_LOOKUP; _type : TIdC_INT; name : PX509_NAME; ret : PX509_OBJECT ) : TIdC_INT; cdecl;
    get_by_issuer_serial : function(ctx : PX509_LOOKUP; _type : TIdC_INT; name : PX509_NAME; serial : PASN1_INTEGER; ret : PX509_OBJECT) : TIdC_INT; cdecl;
    get_by_fingerprint : function (ctx : PX509_LOOKUP; _type : TIdC_INT; bytes : PIdAnsiChar; len : TIdC_INT; ret : PX509_OBJECT): TIdC_INT; cdecl;
    get_by_alias : function(ctx : PX509_LOOKUP; _type : TIdC_INT; str : PIdAnsiChar; ret : PX509_OBJECT) : TIdC_INT; cdecl;
  end;

const
  Indy_x509_unicode_file_lookup: _X509_LOOKUP_METHOD =
    (
    name: 'Load file into cache';
    new_item: nil; // * new */
    free: nil; // * free */
    init: nil; // * init */
    shutdown: nil; // * shutdown */
    ctrl: nil; // * ctrl */
    get_by_subject: nil; // * get_by_subject */
    get_by_issuer_serial: nil; // * get_by_issuer_serial */
    get_by_fingerprint: nil; // * get_by_fingerprint */
    get_by_alias: nil // * get_by_alias */
    );

function FC_X509_LOOKUP_meth_new(const name: PIdAnsiChar): PX509_LOOKUP_METHOD; cdecl;
begin
  Result := @Indy_x509_unicode_file_lookup;
end;

procedure FC_X509_LOOKUP_meth_free(method: PX509_LOOKUP_METHOD); cdecl;
begin
  //Do nothing
end;

function FC_X509_LOOKUP_meth_set_ctrl(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT; cdecl;
begin
  _PX509_LOOKUP_METHOD(method)^.ctrl := @ctrl_fn;
  Result := 1;
end;
(*
struct x509_lookup_st {
    int init;                   /* have we been started */
    int skip;                   /* don't use us. */
    X509_LOOKUP_METHOD *method; /* the functions */
    char *method_data;          /* method data */
    X509_STORE *store_ctx;      /* who owns us */
} /* X509_LOOKUP */ ;
*)

type
  _PX509_LOOKUP = ^_X509_LOOKUP;
  _X509_LOOKUP = record
    init: TIdC_INT;
    skip: TIdC_INT;
    method: PX509_LOOKUP_METHOD;
    method_data: PIdAnsiChar;
    store_ctx: PX509_STORE;
  end;

function FC_X509_LOOKUP_get_store(const ctx: PX509_LOOKUP): PX509_STORE; cdecl;
begin
  Result := _PX509_LOOKUP(ctx)^.store_ctx;
end;

{/forward_compatibility}
{$WARN  NO_RETVAL OFF}
function ERR_X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_app_data');
end;


function ERR_X509_OBJECT_new: PX509_OBJECT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_new');
end;


procedure ERR_X509_OBJECT_free(a: PX509_OBJECT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_free');
end;


function ERR_X509_OBJECT_get_type(const a: PX509_OBJECT): X509_LOOKUP_TYPE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_get_type');
end;


function ERR_X509_OBJECT_get0_X509(const a: PX509_OBJECT): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_get0_X509');
end;


function ERR_X509_OBJECT_set1_X509(a: PX509_OBJECT; obj: PX509): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_set1_X509');
end;


function ERR_X509_OBJECT_get0_X509_CRL(a: PX509_OBJECT): PX509_CRL; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_get0_X509_CRL');
end;


function ERR_X509_OBJECT_set1_X509_CRL(a: PX509_OBJECT; obj: PX509_CRL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_OBJECT_set1_X509_CRL');
end;


function ERR_X509_STORE_lock(ctx: PX509_STORE): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_lock');
end;


function ERR_X509_STORE_unlock(ctx: PX509_STORE): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_unlock');
end;


function ERR_X509_STORE_up_ref(v: PX509_STORE): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_up_ref');
end;


function ERR_X509_STORE_get0_param(ctx: PX509_STORE): PX509_VERIFY_PARAM; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get0_param');
end;


procedure ERR_X509_STORE_set_verify(ctx: PX509_STORE; verify: X509_STORE_CTX_verify_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_verify');
end;


procedure ERR_X509_STORE_CTX_set_verify(ctx: PX509_STORE_CTX; verify: X509_STORE_CTX_verify_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_set_verify');
end;


function ERR_X509_STORE_get_verify(ctx: PX509_STORE): X509_STORE_CTX_verify_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_verify');
end;


function ERR_X509_STORE_get_verify_cb(ctx: PX509_STORE): X509_STORE_CTX_verify_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_verify_cb');
end;


procedure ERR_X509_STORE_set_get_issuer(ctx: PX509_STORE; get_issuer: X509_STORE_CTX_get_issuer_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_get_issuer');
end;


function ERR_X509_STORE_get_get_issuer(ctx: PX509_STORE): X509_STORE_CTX_get_issuer_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_get_issuer');
end;


procedure ERR_X509_STORE_set_check_issued(ctx: PX509_STORE; check_issued: X509_STORE_CTX_check_issued_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_check_issued');
end;


function ERR_X509_STORE_get_check_issued(ctx: PX509_STORE): X509_STORE_CTX_check_issued_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_check_issued');
end;


procedure ERR_X509_STORE_set_check_revocation(ctx: PX509_STORE; check_revocation: X509_STORE_CTX_check_revocation_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_check_revocation');
end;


function ERR_X509_STORE_get_check_revocation(ctx: PX509_STORE): X509_STORE_CTX_check_revocation_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_check_revocation');
end;


procedure ERR_X509_STORE_set_get_crl(ctx: PX509_STORE; get_crl: X509_STORE_CTX_get_crl_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_get_crl');
end;


function ERR_X509_STORE_get_get_crl(ctx: PX509_STORE): X509_STORE_CTX_get_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_get_crl');
end;


procedure ERR_X509_STORE_set_check_crl(ctx: PX509_STORE; check_crl: X509_STORE_CTX_check_crl_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_check_crl');
end;


function ERR_X509_STORE_get_check_crl(ctx: PX509_STORE): X509_STORE_CTX_check_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_check_crl');
end;


procedure ERR_X509_STORE_set_cert_crl(ctx: PX509_STORE; cert_crl: X509_STORE_CTX_cert_crl_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_cert_crl');
end;


function ERR_X509_STORE_get_cert_crl(ctx: PX509_STORE): X509_STORE_CTX_cert_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_cert_crl');
end;


procedure ERR_X509_STORE_set_check_policy(ctx: PX509_STORE; check_policy: X509_STORE_CTX_check_policy_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_check_policy');
end;


function ERR_X509_STORE_get_check_policy(ctx: PX509_STORE): X509_STORE_CTX_check_policy_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_check_policy');
end;


procedure ERR_X509_STORE_set_cleanup(ctx: PX509_STORE; cleanup: X509_STORE_CTX_cleanup_fn); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_cleanup');
end;


function ERR_X509_STORE_get_cleanup(ctx: PX509_STORE): X509_STORE_CTX_cleanup_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_cleanup');
end;


function ERR_X509_STORE_set_ex_data(ctx: PX509_STORE; idx: TIdC_INT; data: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_set_ex_data');
end;


function ERR_X509_STORE_get_ex_data(ctx: PX509_STORE; idx: TIdC_INT): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_get_ex_data');
end;


function ERR_X509_STORE_CTX_get0_cert(ctx: PX509_STORE_CTX): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get0_cert');
end;


function ERR_X509_STORE_CTX_get_verify_cb(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_verify_cb');
end;


function ERR_X509_STORE_CTX_get_verify(ctx: PX509_STORE_CTX): X509_STORE_CTX_verify_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_verify');
end;


function ERR_X509_STORE_CTX_get_get_issuer(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_issuer_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_get_issuer');
end;


function ERR_X509_STORE_CTX_get_check_issued(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_issued_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_check_issued');
end;


function ERR_X509_STORE_CTX_get_check_revocation(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_revocation_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_check_revocation');
end;


function ERR_X509_STORE_CTX_get_get_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_get_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_get_crl');
end;


function ERR_X509_STORE_CTX_get_check_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_check_crl');
end;


function ERR_X509_STORE_CTX_get_cert_crl(ctx: PX509_STORE_CTX): X509_STORE_CTX_cert_crl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_cert_crl');
end;


function ERR_X509_STORE_CTX_get_check_policy(ctx: PX509_STORE_CTX): X509_STORE_CTX_check_policy_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_check_policy');
end;


function ERR_X509_STORE_CTX_get_cleanup(ctx: PX509_STORE_CTX): X509_STORE_CTX_cleanup_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_cleanup');
end;


function ERR_X509_LOOKUP_meth_new(const name: PIdAnsiChar): PX509_LOOKUP_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_new');
end;


procedure ERR_X509_LOOKUP_meth_free(method: PX509_LOOKUP_METHOD); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_free');
end;


function ERR_X509_LOOKUP_meth_set_ctrl(method: PX509_LOOKUP_METHOD; ctrl_fn: X509_LOOKUP_ctrl_fn): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_set_ctrl');
end;


function ERR_X509_LOOKUP_meth_get_ctrl(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_ctrl_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_get_ctrl');
end;


function ERR_X509_LOOKUP_meth_set_get_by_subject(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_subject_fn): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_set_get_by_subject');
end;


function ERR_X509_LOOKUP_meth_get_get_by_subject(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_subject_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_get_get_by_subject');
end;


function ERR_X509_LOOKUP_meth_set_get_by_issuer_serial(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_issuer_serial_fn): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_set_get_by_issuer_serial');
end;


function ERR_X509_LOOKUP_meth_get_get_by_issuer_serial(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_issuer_serial_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_get_get_by_issuer_serial');
end;


function ERR_X509_LOOKUP_meth_set_get_by_fingerprint(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_fingerprint_fn): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_set_get_by_fingerprint');
end;


function ERR_X509_LOOKUP_meth_get_get_by_fingerprint(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_fingerprint_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_get_get_by_fingerprint');
end;


function ERR_X509_LOOKUP_meth_set_get_by_alias(method: PX509_LOOKUP_METHOD; fn: X509_LOOKUP_get_by_alias_fn): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_set_get_by_alias');
end;


function ERR_X509_LOOKUP_meth_get_get_by_alias(const method: PX509_LOOKUP_METHOD): X509_LOOKUP_get_by_alias_fn; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_meth_get_get_by_alias');
end;


function ERR_X509_STORE_CTX_get_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME; ret: PX509_OBJECT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_by_subject');
end;


function ERR_X509_STORE_CTX_get_obj_by_subject(vs: PX509_STORE_CTX; type_: X509_LOOKUP_TYPE; name: PX509_NAME): PX509_OBJECT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_obj_by_subject');
end;


function ERR_X509_LOOKUP_set_method_data(ctx: PX509_LOOKUP; data: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_set_method_data');
end;


function ERR_X509_LOOKUP_get_method_data(const ctx: PX509_LOOKUP): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_get_method_data');
end;


function ERR_X509_LOOKUP_get_store(const ctx: PX509_LOOKUP): PX509_STORE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_LOOKUP_get_store');
end;


procedure ERR_X509_STORE_CTX_set_error_depth(ctx: PX509_STORE_CTX; depth: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_set_error_depth');
end;


procedure ERR_X509_STORE_CTX_set_current_cert(ctx: PX509_STORE_CTX; x: PX509); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_set_current_cert');
end;


function ERR_X509_STORE_CTX_get_num_untrusted(ctx: PX509_STORE_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_get_num_untrusted');
end;


procedure ERR_X509_STORE_CTX_set0_dane(ctx: PX509_STORE_CTX; dane: PSSL_DANE); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_STORE_CTX_set0_dane');
end;


procedure ERR_X509_VERIFY_PARAM_set_auth_level(param: PX509_VERIFY_PARAM; auth_level: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_set_auth_level');
end;


function ERR_X509_VERIFY_PARAM_set_inh_flags(param: PX509_VERIFY_PARAM; flags: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_set_inh_flags');
end;


function ERR_X509_VERIFY_PARAM_get_inh_flags(const param: PX509_VERIFY_PARAM): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_get_inh_flags');
end;


function ERR_X509_VERIFY_PARAM_get_hostflags(const param: PX509_VERIFY_PARAM): TIdC_UINT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_get_hostflags');
end;


procedure ERR_X509_VERIFY_PARAM_move_peername(v1: PX509_VERIFY_PARAM; v2: PX509_VERIFY_PARAM); 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_move_peername');
end;


function ERR_X509_VERIFY_PARAM_get_auth_level(const param: PX509_VERIFY_PARAM): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('X509_VERIFY_PARAM_get_auth_level');
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
  X509_STORE_set_depth := LoadFunction('X509_STORE_set_depth',AFailed);
  X509_STORE_CTX_set_depth := LoadFunction('X509_STORE_CTX_set_depth',AFailed);
  X509_OBJECT_up_ref_count := LoadFunction('X509_OBJECT_up_ref_count',AFailed);
  X509_STORE_new := LoadFunction('X509_STORE_new',AFailed);
  X509_STORE_free := LoadFunction('X509_STORE_free',AFailed);
  X509_STORE_set_flags := LoadFunction('X509_STORE_set_flags',AFailed);
  X509_STORE_set_purpose := LoadFunction('X509_STORE_set_purpose',AFailed);
  X509_STORE_set_trust := LoadFunction('X509_STORE_set_trust',AFailed);
  X509_STORE_set1_param := LoadFunction('X509_STORE_set1_param',AFailed);
  X509_STORE_set_verify_cb := LoadFunction('X509_STORE_set_verify_cb',AFailed);
  X509_STORE_CTX_new := LoadFunction('X509_STORE_CTX_new',AFailed);
  X509_STORE_CTX_get1_issuer := LoadFunction('X509_STORE_CTX_get1_issuer',AFailed);
  X509_STORE_CTX_free := LoadFunction('X509_STORE_CTX_free',AFailed);
  X509_STORE_CTX_cleanup := LoadFunction('X509_STORE_CTX_cleanup',AFailed);
  X509_STORE_CTX_get0_store := LoadFunction('X509_STORE_CTX_get0_store',AFailed);
  X509_STORE_CTX_set_verify_cb := LoadFunction('X509_STORE_CTX_set_verify_cb',AFailed);
  X509_STORE_add_lookup := LoadFunction('X509_STORE_add_lookup',AFailed);
  X509_LOOKUP_hash_dir := LoadFunction('X509_LOOKUP_hash_dir',AFailed);
  X509_LOOKUP_file := LoadFunction('X509_LOOKUP_file',AFailed);
  X509_STORE_add_cert := LoadFunction('X509_STORE_add_cert',AFailed);
  X509_STORE_add_crl := LoadFunction('X509_STORE_add_crl',AFailed);
  X509_LOOKUP_ctrl := LoadFunction('X509_LOOKUP_ctrl',AFailed);
  X509_load_cert_file := LoadFunction('X509_load_cert_file',AFailed);
  X509_load_crl_file := LoadFunction('X509_load_crl_file',AFailed);
  X509_load_cert_crl_file := LoadFunction('X509_load_cert_crl_file',AFailed);
  X509_LOOKUP_new := LoadFunction('X509_LOOKUP_new',AFailed);
  X509_LOOKUP_free := LoadFunction('X509_LOOKUP_free',AFailed);
  X509_LOOKUP_init := LoadFunction('X509_LOOKUP_init',AFailed);
  X509_LOOKUP_by_subject := LoadFunction('X509_LOOKUP_by_subject',AFailed);
  X509_LOOKUP_by_issuer_serial := LoadFunction('X509_LOOKUP_by_issuer_serial',AFailed);
  X509_LOOKUP_by_fingerprint := LoadFunction('X509_LOOKUP_by_fingerprint',AFailed);
  X509_LOOKUP_by_alias := LoadFunction('X509_LOOKUP_by_alias',AFailed);
  X509_LOOKUP_shutdown := LoadFunction('X509_LOOKUP_shutdown',AFailed);
  X509_STORE_load_locations := LoadFunction('X509_STORE_load_locations',AFailed);
  X509_STORE_set_default_paths := LoadFunction('X509_STORE_set_default_paths',AFailed);
  X509_STORE_CTX_set_ex_data := LoadFunction('X509_STORE_CTX_set_ex_data',AFailed);
  X509_STORE_CTX_get_ex_data := LoadFunction('X509_STORE_CTX_get_ex_data',AFailed);
  X509_STORE_CTX_get_error := LoadFunction('X509_STORE_CTX_get_error',AFailed);
  X509_STORE_CTX_set_error := LoadFunction('X509_STORE_CTX_set_error',AFailed);
  X509_STORE_CTX_get_error_depth := LoadFunction('X509_STORE_CTX_get_error_depth',AFailed);
  X509_STORE_CTX_get_current_cert := LoadFunction('X509_STORE_CTX_get_current_cert',AFailed);
  X509_STORE_CTX_get0_current_issuer := LoadFunction('X509_STORE_CTX_get0_current_issuer',AFailed);
  X509_STORE_CTX_get0_current_crl := LoadFunction('X509_STORE_CTX_get0_current_crl',AFailed);
  X509_STORE_CTX_get0_parent_ctx := LoadFunction('X509_STORE_CTX_get0_parent_ctx',AFailed);
  X509_STORE_CTX_set_cert := LoadFunction('X509_STORE_CTX_set_cert',AFailed);
  X509_STORE_CTX_set_purpose := LoadFunction('X509_STORE_CTX_set_purpose',AFailed);
  X509_STORE_CTX_set_trust := LoadFunction('X509_STORE_CTX_set_trust',AFailed);
  X509_STORE_CTX_purpose_inherit := LoadFunction('X509_STORE_CTX_purpose_inherit',AFailed);
  X509_STORE_CTX_set_flags := LoadFunction('X509_STORE_CTX_set_flags',AFailed);
  X509_STORE_CTX_get0_policy_tree := LoadFunction('X509_STORE_CTX_get0_policy_tree',AFailed);
  X509_STORE_CTX_get_explicit_policy := LoadFunction('X509_STORE_CTX_get_explicit_policy',AFailed);
  X509_STORE_CTX_get0_param := LoadFunction('X509_STORE_CTX_get0_param',AFailed);
  X509_STORE_CTX_set0_param := LoadFunction('X509_STORE_CTX_set0_param',AFailed);
  X509_STORE_CTX_set_default := LoadFunction('X509_STORE_CTX_set_default',AFailed);
  X509_VERIFY_PARAM_new := LoadFunction('X509_VERIFY_PARAM_new',AFailed);
  X509_VERIFY_PARAM_free := LoadFunction('X509_VERIFY_PARAM_free',AFailed);
  X509_VERIFY_PARAM_inherit := LoadFunction('X509_VERIFY_PARAM_inherit',AFailed);
  X509_VERIFY_PARAM_set1 := LoadFunction('X509_VERIFY_PARAM_set1',AFailed);
  X509_VERIFY_PARAM_set1_name := LoadFunction('X509_VERIFY_PARAM_set1_name',AFailed);
  X509_VERIFY_PARAM_set_flags := LoadFunction('X509_VERIFY_PARAM_set_flags',AFailed);
  X509_VERIFY_PARAM_clear_flags := LoadFunction('X509_VERIFY_PARAM_clear_flags',AFailed);
  X509_VERIFY_PARAM_get_flags := LoadFunction('X509_VERIFY_PARAM_get_flags',AFailed);
  X509_VERIFY_PARAM_set_purpose := LoadFunction('X509_VERIFY_PARAM_set_purpose',AFailed);
  X509_VERIFY_PARAM_set_trust := LoadFunction('X509_VERIFY_PARAM_set_trust',AFailed);
  X509_VERIFY_PARAM_set_depth := LoadFunction('X509_VERIFY_PARAM_set_depth',AFailed);
  X509_VERIFY_PARAM_add0_policy := LoadFunction('X509_VERIFY_PARAM_add0_policy',AFailed);
  X509_VERIFY_PARAM_set1_host := LoadFunction('X509_VERIFY_PARAM_set1_host',AFailed);
  X509_VERIFY_PARAM_add1_host := LoadFunction('X509_VERIFY_PARAM_add1_host',AFailed);
  X509_VERIFY_PARAM_set_hostflags := LoadFunction('X509_VERIFY_PARAM_set_hostflags',AFailed);
  X509_VERIFY_PARAM_get0_peername := LoadFunction('X509_VERIFY_PARAM_get0_peername',AFailed);
  X509_VERIFY_PARAM_set1_email := LoadFunction('X509_VERIFY_PARAM_set1_email',AFailed);
  X509_VERIFY_PARAM_set1_ip := LoadFunction('X509_VERIFY_PARAM_set1_ip',AFailed);
  X509_VERIFY_PARAM_set1_ip_asc := LoadFunction('X509_VERIFY_PARAM_set1_ip_asc',AFailed);
  X509_VERIFY_PARAM_get_depth := LoadFunction('X509_VERIFY_PARAM_get_depth',AFailed);
  X509_VERIFY_PARAM_get0_name := LoadFunction('X509_VERIFY_PARAM_get0_name',AFailed);
  X509_VERIFY_PARAM_add0_table := LoadFunction('X509_VERIFY_PARAM_add0_table',AFailed);
  X509_VERIFY_PARAM_get_count := LoadFunction('X509_VERIFY_PARAM_get_count',AFailed);
  X509_VERIFY_PARAM_get0 := LoadFunction('X509_VERIFY_PARAM_get0',AFailed);
  X509_VERIFY_PARAM_lookup := LoadFunction('X509_VERIFY_PARAM_lookup',AFailed);
  X509_VERIFY_PARAM_table_cleanup := LoadFunction('X509_VERIFY_PARAM_table_cleanup',AFailed);
  X509_policy_tree_free := LoadFunction('X509_policy_tree_free',AFailed);
  X509_policy_tree_level_count := LoadFunction('X509_policy_tree_level_count',AFailed);
  X509_policy_tree_get0_level := LoadFunction('X509_policy_tree_get0_level',AFailed);
  X509_policy_level_node_count := LoadFunction('X509_policy_level_node_count',AFailed);
  X509_policy_level_get0_node := LoadFunction('X509_policy_level_get0_node',AFailed);
  X509_policy_node_get0_policy := LoadFunction('X509_policy_node_get0_policy',AFailed);
  X509_policy_node_get0_parent := LoadFunction('X509_policy_node_get0_parent',AFailed);
  X509_STORE_CTX_get_app_data := LoadFunction('X509_STORE_CTX_get_app_data',nil); {removed 1.0.0}
  X509_OBJECT_new := LoadFunction('X509_OBJECT_new',nil); {introduced 1.1.0}
  X509_OBJECT_free := LoadFunction('X509_OBJECT_free',nil); {introduced 1.1.0}
  X509_OBJECT_get_type := LoadFunction('X509_OBJECT_get_type',nil); {introduced 1.1.0}
  X509_OBJECT_get0_X509 := LoadFunction('X509_OBJECT_get0_X509',nil); {introduced 1.1.0}
  X509_OBJECT_set1_X509 := LoadFunction('X509_OBJECT_set1_X509',nil); {introduced 1.1.0}
  X509_OBJECT_get0_X509_CRL := LoadFunction('X509_OBJECT_get0_X509_CRL',nil); {introduced 1.1.0}
  X509_OBJECT_set1_X509_CRL := LoadFunction('X509_OBJECT_set1_X509_CRL',nil); {introduced 1.1.0}
  X509_STORE_lock := LoadFunction('X509_STORE_lock',nil); {introduced 1.1.0}
  X509_STORE_unlock := LoadFunction('X509_STORE_unlock',nil); {introduced 1.1.0}
  X509_STORE_up_ref := LoadFunction('X509_STORE_up_ref',nil); {introduced 1.1.0}
  X509_STORE_get0_param := LoadFunction('X509_STORE_get0_param',nil); {introduced 1.1.0}
  X509_STORE_set_verify := LoadFunction('X509_STORE_set_verify',nil); {introduced 1.1.0}
  X509_STORE_CTX_set_verify := LoadFunction('X509_STORE_CTX_set_verify',nil); {introduced 1.1.0}
  X509_STORE_get_verify := LoadFunction('X509_STORE_get_verify',nil); {introduced 1.1.0}
  X509_STORE_get_verify_cb := LoadFunction('X509_STORE_get_verify_cb',nil); {introduced 1.1.0}
  X509_STORE_set_get_issuer := LoadFunction('X509_STORE_set_get_issuer',nil); {introduced 1.1.0}
  X509_STORE_get_get_issuer := LoadFunction('X509_STORE_get_get_issuer',nil); {introduced 1.1.0}
  X509_STORE_set_check_issued := LoadFunction('X509_STORE_set_check_issued',nil); {introduced 1.1.0}
  X509_STORE_get_check_issued := LoadFunction('X509_STORE_get_check_issued',nil); {introduced 1.1.0}
  X509_STORE_set_check_revocation := LoadFunction('X509_STORE_set_check_revocation',nil); {introduced 1.1.0}
  X509_STORE_get_check_revocation := LoadFunction('X509_STORE_get_check_revocation',nil); {introduced 1.1.0}
  X509_STORE_set_get_crl := LoadFunction('X509_STORE_set_get_crl',nil); {introduced 1.1.0}
  X509_STORE_get_get_crl := LoadFunction('X509_STORE_get_get_crl',nil); {introduced 1.1.0}
  X509_STORE_set_check_crl := LoadFunction('X509_STORE_set_check_crl',nil); {introduced 1.1.0}
  X509_STORE_get_check_crl := LoadFunction('X509_STORE_get_check_crl',nil); {introduced 1.1.0}
  X509_STORE_set_cert_crl := LoadFunction('X509_STORE_set_cert_crl',nil); {introduced 1.1.0}
  X509_STORE_get_cert_crl := LoadFunction('X509_STORE_get_cert_crl',nil); {introduced 1.1.0}
  X509_STORE_set_check_policy := LoadFunction('X509_STORE_set_check_policy',nil); {introduced 1.1.0}
  X509_STORE_get_check_policy := LoadFunction('X509_STORE_get_check_policy',nil); {introduced 1.1.0}
  X509_STORE_set_cleanup := LoadFunction('X509_STORE_set_cleanup',nil); {introduced 1.1.0}
  X509_STORE_get_cleanup := LoadFunction('X509_STORE_get_cleanup',nil); {introduced 1.1.0}
  X509_STORE_set_ex_data := LoadFunction('X509_STORE_set_ex_data',nil); {introduced 1.1.0}
  X509_STORE_get_ex_data := LoadFunction('X509_STORE_get_ex_data',nil); {introduced 1.1.0}
  X509_STORE_CTX_get0_cert := LoadFunction('X509_STORE_CTX_get0_cert',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_verify_cb := LoadFunction('X509_STORE_CTX_get_verify_cb',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_verify := LoadFunction('X509_STORE_CTX_get_verify',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_get_issuer := LoadFunction('X509_STORE_CTX_get_get_issuer',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_check_issued := LoadFunction('X509_STORE_CTX_get_check_issued',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_check_revocation := LoadFunction('X509_STORE_CTX_get_check_revocation',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_get_crl := LoadFunction('X509_STORE_CTX_get_get_crl',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_check_crl := LoadFunction('X509_STORE_CTX_get_check_crl',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_cert_crl := LoadFunction('X509_STORE_CTX_get_cert_crl',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_check_policy := LoadFunction('X509_STORE_CTX_get_check_policy',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_cleanup := LoadFunction('X509_STORE_CTX_get_cleanup',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_new := LoadFunction('X509_LOOKUP_meth_new',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_free := LoadFunction('X509_LOOKUP_meth_free',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_set_ctrl := LoadFunction('X509_LOOKUP_meth_set_ctrl',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_get_ctrl := LoadFunction('X509_LOOKUP_meth_get_ctrl',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_subject := LoadFunction('X509_LOOKUP_meth_set_get_by_subject',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_subject := LoadFunction('X509_LOOKUP_meth_get_get_by_subject',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_issuer_serial := LoadFunction('X509_LOOKUP_meth_set_get_by_issuer_serial',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_issuer_serial := LoadFunction('X509_LOOKUP_meth_get_get_by_issuer_serial',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_fingerprint := LoadFunction('X509_LOOKUP_meth_set_get_by_fingerprint',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_fingerprint := LoadFunction('X509_LOOKUP_meth_get_get_by_fingerprint',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_alias := LoadFunction('X509_LOOKUP_meth_set_get_by_alias',nil); {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_alias := LoadFunction('X509_LOOKUP_meth_get_get_by_alias',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_by_subject := LoadFunction('X509_STORE_CTX_get_by_subject',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_obj_by_subject := LoadFunction('X509_STORE_CTX_get_obj_by_subject',nil); {introduced 1.1.0}
  X509_LOOKUP_set_method_data := LoadFunction('X509_LOOKUP_set_method_data',nil); {introduced 1.1.0}
  X509_LOOKUP_get_method_data := LoadFunction('X509_LOOKUP_get_method_data',nil); {introduced 1.1.0}
  X509_LOOKUP_get_store := LoadFunction('X509_LOOKUP_get_store',nil); {introduced 1.1.0}
  X509_STORE_CTX_set_error_depth := LoadFunction('X509_STORE_CTX_set_error_depth',nil); {introduced 1.1.0}
  X509_STORE_CTX_set_current_cert := LoadFunction('X509_STORE_CTX_set_current_cert',nil); {introduced 1.1.0}
  X509_STORE_CTX_get_num_untrusted := LoadFunction('X509_STORE_CTX_get_num_untrusted',nil); {introduced 1.1.0}
  X509_STORE_CTX_set0_dane := LoadFunction('X509_STORE_CTX_set0_dane',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_set_auth_level := LoadFunction('X509_VERIFY_PARAM_set_auth_level',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_set_inh_flags := LoadFunction('X509_VERIFY_PARAM_set_inh_flags',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_get_inh_flags := LoadFunction('X509_VERIFY_PARAM_get_inh_flags',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_get_hostflags := LoadFunction('X509_VERIFY_PARAM_get_hostflags',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_move_peername := LoadFunction('X509_VERIFY_PARAM_move_peername',nil); {introduced 1.1.0}
  X509_VERIFY_PARAM_get_auth_level := LoadFunction('X509_VERIFY_PARAM_get_auth_level',nil); {introduced 1.1.0}
  if not assigned(X509_STORE_CTX_get_app_data) then 
  begin
    {$if declared(X509_STORE_CTX_get_app_data_introduced)}
    if LibVersion < X509_STORE_CTX_get_app_data_introduced then
      {$if declared(FC_X509_STORE_CTX_get_app_data)}
      X509_STORE_CTX_get_app_data := @FC_X509_STORE_CTX_get_app_data
      {$else}
      X509_STORE_CTX_get_app_data := @ERR_X509_STORE_CTX_get_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_app_data_removed)}
   if X509_STORE_CTX_get_app_data_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_app_data)}
     X509_STORE_CTX_get_app_data := @_X509_STORE_CTX_get_app_data
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_app_data)}
       X509_STORE_CTX_get_app_data := @ERR_X509_STORE_CTX_get_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_app_data) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_app_data');
  end;


  if not assigned(X509_OBJECT_new) then 
  begin
    {$if declared(X509_OBJECT_new_introduced)}
    if LibVersion < X509_OBJECT_new_introduced then
      {$if declared(FC_X509_OBJECT_new)}
      X509_OBJECT_new := @FC_X509_OBJECT_new
      {$else}
      X509_OBJECT_new := @ERR_X509_OBJECT_new
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_new_removed)}
   if X509_OBJECT_new_removed <= LibVersion then
     {$if declared(_X509_OBJECT_new)}
     X509_OBJECT_new := @_X509_OBJECT_new
     {$else}
       {$IF declared(ERR_X509_OBJECT_new)}
       X509_OBJECT_new := @ERR_X509_OBJECT_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_new) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_new');
  end;


  if not assigned(X509_OBJECT_free) then 
  begin
    {$if declared(X509_OBJECT_free_introduced)}
    if LibVersion < X509_OBJECT_free_introduced then
      {$if declared(FC_X509_OBJECT_free)}
      X509_OBJECT_free := @FC_X509_OBJECT_free
      {$else}
      X509_OBJECT_free := @ERR_X509_OBJECT_free
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_free_removed)}
   if X509_OBJECT_free_removed <= LibVersion then
     {$if declared(_X509_OBJECT_free)}
     X509_OBJECT_free := @_X509_OBJECT_free
     {$else}
       {$IF declared(ERR_X509_OBJECT_free)}
       X509_OBJECT_free := @ERR_X509_OBJECT_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_free) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_free');
  end;


  if not assigned(X509_OBJECT_get_type) then 
  begin
    {$if declared(X509_OBJECT_get_type_introduced)}
    if LibVersion < X509_OBJECT_get_type_introduced then
      {$if declared(FC_X509_OBJECT_get_type)}
      X509_OBJECT_get_type := @FC_X509_OBJECT_get_type
      {$else}
      X509_OBJECT_get_type := @ERR_X509_OBJECT_get_type
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_get_type_removed)}
   if X509_OBJECT_get_type_removed <= LibVersion then
     {$if declared(_X509_OBJECT_get_type)}
     X509_OBJECT_get_type := @_X509_OBJECT_get_type
     {$else}
       {$IF declared(ERR_X509_OBJECT_get_type)}
       X509_OBJECT_get_type := @ERR_X509_OBJECT_get_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_get_type) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_get_type');
  end;


  if not assigned(X509_OBJECT_get0_X509) then 
  begin
    {$if declared(X509_OBJECT_get0_X509_introduced)}
    if LibVersion < X509_OBJECT_get0_X509_introduced then
      {$if declared(FC_X509_OBJECT_get0_X509)}
      X509_OBJECT_get0_X509 := @FC_X509_OBJECT_get0_X509
      {$else}
      X509_OBJECT_get0_X509 := @ERR_X509_OBJECT_get0_X509
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_get0_X509_removed)}
   if X509_OBJECT_get0_X509_removed <= LibVersion then
     {$if declared(_X509_OBJECT_get0_X509)}
     X509_OBJECT_get0_X509 := @_X509_OBJECT_get0_X509
     {$else}
       {$IF declared(ERR_X509_OBJECT_get0_X509)}
       X509_OBJECT_get0_X509 := @ERR_X509_OBJECT_get0_X509
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_get0_X509) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_get0_X509');
  end;


  if not assigned(X509_OBJECT_set1_X509) then 
  begin
    {$if declared(X509_OBJECT_set1_X509_introduced)}
    if LibVersion < X509_OBJECT_set1_X509_introduced then
      {$if declared(FC_X509_OBJECT_set1_X509)}
      X509_OBJECT_set1_X509 := @FC_X509_OBJECT_set1_X509
      {$else}
      X509_OBJECT_set1_X509 := @ERR_X509_OBJECT_set1_X509
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_set1_X509_removed)}
   if X509_OBJECT_set1_X509_removed <= LibVersion then
     {$if declared(_X509_OBJECT_set1_X509)}
     X509_OBJECT_set1_X509 := @_X509_OBJECT_set1_X509
     {$else}
       {$IF declared(ERR_X509_OBJECT_set1_X509)}
       X509_OBJECT_set1_X509 := @ERR_X509_OBJECT_set1_X509
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_set1_X509) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_set1_X509');
  end;


  if not assigned(X509_OBJECT_get0_X509_CRL) then 
  begin
    {$if declared(X509_OBJECT_get0_X509_CRL_introduced)}
    if LibVersion < X509_OBJECT_get0_X509_CRL_introduced then
      {$if declared(FC_X509_OBJECT_get0_X509_CRL)}
      X509_OBJECT_get0_X509_CRL := @FC_X509_OBJECT_get0_X509_CRL
      {$else}
      X509_OBJECT_get0_X509_CRL := @ERR_X509_OBJECT_get0_X509_CRL
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_get0_X509_CRL_removed)}
   if X509_OBJECT_get0_X509_CRL_removed <= LibVersion then
     {$if declared(_X509_OBJECT_get0_X509_CRL)}
     X509_OBJECT_get0_X509_CRL := @_X509_OBJECT_get0_X509_CRL
     {$else}
       {$IF declared(ERR_X509_OBJECT_get0_X509_CRL)}
       X509_OBJECT_get0_X509_CRL := @ERR_X509_OBJECT_get0_X509_CRL
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_get0_X509_CRL) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_get0_X509_CRL');
  end;


  if not assigned(X509_OBJECT_set1_X509_CRL) then 
  begin
    {$if declared(X509_OBJECT_set1_X509_CRL_introduced)}
    if LibVersion < X509_OBJECT_set1_X509_CRL_introduced then
      {$if declared(FC_X509_OBJECT_set1_X509_CRL)}
      X509_OBJECT_set1_X509_CRL := @FC_X509_OBJECT_set1_X509_CRL
      {$else}
      X509_OBJECT_set1_X509_CRL := @ERR_X509_OBJECT_set1_X509_CRL
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_OBJECT_set1_X509_CRL_removed)}
   if X509_OBJECT_set1_X509_CRL_removed <= LibVersion then
     {$if declared(_X509_OBJECT_set1_X509_CRL)}
     X509_OBJECT_set1_X509_CRL := @_X509_OBJECT_set1_X509_CRL
     {$else}
       {$IF declared(ERR_X509_OBJECT_set1_X509_CRL)}
       X509_OBJECT_set1_X509_CRL := @ERR_X509_OBJECT_set1_X509_CRL
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_OBJECT_set1_X509_CRL) and Assigned(AFailed) then 
     AFailed.Add('X509_OBJECT_set1_X509_CRL');
  end;


  if not assigned(X509_STORE_lock) then 
  begin
    {$if declared(X509_STORE_lock_introduced)}
    if LibVersion < X509_STORE_lock_introduced then
      {$if declared(FC_X509_STORE_lock)}
      X509_STORE_lock := @FC_X509_STORE_lock
      {$else}
      X509_STORE_lock := @ERR_X509_STORE_lock
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_lock_removed)}
   if X509_STORE_lock_removed <= LibVersion then
     {$if declared(_X509_STORE_lock)}
     X509_STORE_lock := @_X509_STORE_lock
     {$else}
       {$IF declared(ERR_X509_STORE_lock)}
       X509_STORE_lock := @ERR_X509_STORE_lock
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_lock) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_lock');
  end;


  if not assigned(X509_STORE_unlock) then 
  begin
    {$if declared(X509_STORE_unlock_introduced)}
    if LibVersion < X509_STORE_unlock_introduced then
      {$if declared(FC_X509_STORE_unlock)}
      X509_STORE_unlock := @FC_X509_STORE_unlock
      {$else}
      X509_STORE_unlock := @ERR_X509_STORE_unlock
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_unlock_removed)}
   if X509_STORE_unlock_removed <= LibVersion then
     {$if declared(_X509_STORE_unlock)}
     X509_STORE_unlock := @_X509_STORE_unlock
     {$else}
       {$IF declared(ERR_X509_STORE_unlock)}
       X509_STORE_unlock := @ERR_X509_STORE_unlock
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_unlock) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_unlock');
  end;


  if not assigned(X509_STORE_up_ref) then 
  begin
    {$if declared(X509_STORE_up_ref_introduced)}
    if LibVersion < X509_STORE_up_ref_introduced then
      {$if declared(FC_X509_STORE_up_ref)}
      X509_STORE_up_ref := @FC_X509_STORE_up_ref
      {$else}
      X509_STORE_up_ref := @ERR_X509_STORE_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_up_ref_removed)}
   if X509_STORE_up_ref_removed <= LibVersion then
     {$if declared(_X509_STORE_up_ref)}
     X509_STORE_up_ref := @_X509_STORE_up_ref
     {$else}
       {$IF declared(ERR_X509_STORE_up_ref)}
       X509_STORE_up_ref := @ERR_X509_STORE_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_up_ref) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_up_ref');
  end;


  if not assigned(X509_STORE_get0_param) then 
  begin
    {$if declared(X509_STORE_get0_param_introduced)}
    if LibVersion < X509_STORE_get0_param_introduced then
      {$if declared(FC_X509_STORE_get0_param)}
      X509_STORE_get0_param := @FC_X509_STORE_get0_param
      {$else}
      X509_STORE_get0_param := @ERR_X509_STORE_get0_param
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get0_param_removed)}
   if X509_STORE_get0_param_removed <= LibVersion then
     {$if declared(_X509_STORE_get0_param)}
     X509_STORE_get0_param := @_X509_STORE_get0_param
     {$else}
       {$IF declared(ERR_X509_STORE_get0_param)}
       X509_STORE_get0_param := @ERR_X509_STORE_get0_param
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get0_param) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get0_param');
  end;


  if not assigned(X509_STORE_set_verify) then 
  begin
    {$if declared(X509_STORE_set_verify_introduced)}
    if LibVersion < X509_STORE_set_verify_introduced then
      {$if declared(FC_X509_STORE_set_verify)}
      X509_STORE_set_verify := @FC_X509_STORE_set_verify
      {$else}
      X509_STORE_set_verify := @ERR_X509_STORE_set_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_verify_removed)}
   if X509_STORE_set_verify_removed <= LibVersion then
     {$if declared(_X509_STORE_set_verify)}
     X509_STORE_set_verify := @_X509_STORE_set_verify
     {$else}
       {$IF declared(ERR_X509_STORE_set_verify)}
       X509_STORE_set_verify := @ERR_X509_STORE_set_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_verify) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_verify');
  end;


  if not assigned(X509_STORE_CTX_set_verify) then 
  begin
    {$if declared(X509_STORE_CTX_set_verify_introduced)}
    if LibVersion < X509_STORE_CTX_set_verify_introduced then
      {$if declared(FC_X509_STORE_CTX_set_verify)}
      X509_STORE_CTX_set_verify := @FC_X509_STORE_CTX_set_verify
      {$else}
      X509_STORE_CTX_set_verify := @ERR_X509_STORE_CTX_set_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_set_verify_removed)}
   if X509_STORE_CTX_set_verify_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_set_verify)}
     X509_STORE_CTX_set_verify := @_X509_STORE_CTX_set_verify
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_set_verify)}
       X509_STORE_CTX_set_verify := @ERR_X509_STORE_CTX_set_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_set_verify) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_set_verify');
  end;


  if not assigned(X509_STORE_get_verify) then 
  begin
    {$if declared(X509_STORE_get_verify_introduced)}
    if LibVersion < X509_STORE_get_verify_introduced then
      {$if declared(FC_X509_STORE_get_verify)}
      X509_STORE_get_verify := @FC_X509_STORE_get_verify
      {$else}
      X509_STORE_get_verify := @ERR_X509_STORE_get_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_verify_removed)}
   if X509_STORE_get_verify_removed <= LibVersion then
     {$if declared(_X509_STORE_get_verify)}
     X509_STORE_get_verify := @_X509_STORE_get_verify
     {$else}
       {$IF declared(ERR_X509_STORE_get_verify)}
       X509_STORE_get_verify := @ERR_X509_STORE_get_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_verify) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_verify');
  end;


  if not assigned(X509_STORE_get_verify_cb) then 
  begin
    {$if declared(X509_STORE_get_verify_cb_introduced)}
    if LibVersion < X509_STORE_get_verify_cb_introduced then
      {$if declared(FC_X509_STORE_get_verify_cb)}
      X509_STORE_get_verify_cb := @FC_X509_STORE_get_verify_cb
      {$else}
      X509_STORE_get_verify_cb := @ERR_X509_STORE_get_verify_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_verify_cb_removed)}
   if X509_STORE_get_verify_cb_removed <= LibVersion then
     {$if declared(_X509_STORE_get_verify_cb)}
     X509_STORE_get_verify_cb := @_X509_STORE_get_verify_cb
     {$else}
       {$IF declared(ERR_X509_STORE_get_verify_cb)}
       X509_STORE_get_verify_cb := @ERR_X509_STORE_get_verify_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_verify_cb) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_verify_cb');
  end;


  if not assigned(X509_STORE_set_get_issuer) then 
  begin
    {$if declared(X509_STORE_set_get_issuer_introduced)}
    if LibVersion < X509_STORE_set_get_issuer_introduced then
      {$if declared(FC_X509_STORE_set_get_issuer)}
      X509_STORE_set_get_issuer := @FC_X509_STORE_set_get_issuer
      {$else}
      X509_STORE_set_get_issuer := @ERR_X509_STORE_set_get_issuer
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_get_issuer_removed)}
   if X509_STORE_set_get_issuer_removed <= LibVersion then
     {$if declared(_X509_STORE_set_get_issuer)}
     X509_STORE_set_get_issuer := @_X509_STORE_set_get_issuer
     {$else}
       {$IF declared(ERR_X509_STORE_set_get_issuer)}
       X509_STORE_set_get_issuer := @ERR_X509_STORE_set_get_issuer
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_get_issuer) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_get_issuer');
  end;


  if not assigned(X509_STORE_get_get_issuer) then 
  begin
    {$if declared(X509_STORE_get_get_issuer_introduced)}
    if LibVersion < X509_STORE_get_get_issuer_introduced then
      {$if declared(FC_X509_STORE_get_get_issuer)}
      X509_STORE_get_get_issuer := @FC_X509_STORE_get_get_issuer
      {$else}
      X509_STORE_get_get_issuer := @ERR_X509_STORE_get_get_issuer
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_get_issuer_removed)}
   if X509_STORE_get_get_issuer_removed <= LibVersion then
     {$if declared(_X509_STORE_get_get_issuer)}
     X509_STORE_get_get_issuer := @_X509_STORE_get_get_issuer
     {$else}
       {$IF declared(ERR_X509_STORE_get_get_issuer)}
       X509_STORE_get_get_issuer := @ERR_X509_STORE_get_get_issuer
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_get_issuer) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_get_issuer');
  end;


  if not assigned(X509_STORE_set_check_issued) then 
  begin
    {$if declared(X509_STORE_set_check_issued_introduced)}
    if LibVersion < X509_STORE_set_check_issued_introduced then
      {$if declared(FC_X509_STORE_set_check_issued)}
      X509_STORE_set_check_issued := @FC_X509_STORE_set_check_issued
      {$else}
      X509_STORE_set_check_issued := @ERR_X509_STORE_set_check_issued
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_check_issued_removed)}
   if X509_STORE_set_check_issued_removed <= LibVersion then
     {$if declared(_X509_STORE_set_check_issued)}
     X509_STORE_set_check_issued := @_X509_STORE_set_check_issued
     {$else}
       {$IF declared(ERR_X509_STORE_set_check_issued)}
       X509_STORE_set_check_issued := @ERR_X509_STORE_set_check_issued
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_check_issued) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_check_issued');
  end;


  if not assigned(X509_STORE_get_check_issued) then 
  begin
    {$if declared(X509_STORE_get_check_issued_introduced)}
    if LibVersion < X509_STORE_get_check_issued_introduced then
      {$if declared(FC_X509_STORE_get_check_issued)}
      X509_STORE_get_check_issued := @FC_X509_STORE_get_check_issued
      {$else}
      X509_STORE_get_check_issued := @ERR_X509_STORE_get_check_issued
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_check_issued_removed)}
   if X509_STORE_get_check_issued_removed <= LibVersion then
     {$if declared(_X509_STORE_get_check_issued)}
     X509_STORE_get_check_issued := @_X509_STORE_get_check_issued
     {$else}
       {$IF declared(ERR_X509_STORE_get_check_issued)}
       X509_STORE_get_check_issued := @ERR_X509_STORE_get_check_issued
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_check_issued) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_check_issued');
  end;


  if not assigned(X509_STORE_set_check_revocation) then 
  begin
    {$if declared(X509_STORE_set_check_revocation_introduced)}
    if LibVersion < X509_STORE_set_check_revocation_introduced then
      {$if declared(FC_X509_STORE_set_check_revocation)}
      X509_STORE_set_check_revocation := @FC_X509_STORE_set_check_revocation
      {$else}
      X509_STORE_set_check_revocation := @ERR_X509_STORE_set_check_revocation
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_check_revocation_removed)}
   if X509_STORE_set_check_revocation_removed <= LibVersion then
     {$if declared(_X509_STORE_set_check_revocation)}
     X509_STORE_set_check_revocation := @_X509_STORE_set_check_revocation
     {$else}
       {$IF declared(ERR_X509_STORE_set_check_revocation)}
       X509_STORE_set_check_revocation := @ERR_X509_STORE_set_check_revocation
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_check_revocation) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_check_revocation');
  end;


  if not assigned(X509_STORE_get_check_revocation) then 
  begin
    {$if declared(X509_STORE_get_check_revocation_introduced)}
    if LibVersion < X509_STORE_get_check_revocation_introduced then
      {$if declared(FC_X509_STORE_get_check_revocation)}
      X509_STORE_get_check_revocation := @FC_X509_STORE_get_check_revocation
      {$else}
      X509_STORE_get_check_revocation := @ERR_X509_STORE_get_check_revocation
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_check_revocation_removed)}
   if X509_STORE_get_check_revocation_removed <= LibVersion then
     {$if declared(_X509_STORE_get_check_revocation)}
     X509_STORE_get_check_revocation := @_X509_STORE_get_check_revocation
     {$else}
       {$IF declared(ERR_X509_STORE_get_check_revocation)}
       X509_STORE_get_check_revocation := @ERR_X509_STORE_get_check_revocation
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_check_revocation) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_check_revocation');
  end;


  if not assigned(X509_STORE_set_get_crl) then 
  begin
    {$if declared(X509_STORE_set_get_crl_introduced)}
    if LibVersion < X509_STORE_set_get_crl_introduced then
      {$if declared(FC_X509_STORE_set_get_crl)}
      X509_STORE_set_get_crl := @FC_X509_STORE_set_get_crl
      {$else}
      X509_STORE_set_get_crl := @ERR_X509_STORE_set_get_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_get_crl_removed)}
   if X509_STORE_set_get_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_set_get_crl)}
     X509_STORE_set_get_crl := @_X509_STORE_set_get_crl
     {$else}
       {$IF declared(ERR_X509_STORE_set_get_crl)}
       X509_STORE_set_get_crl := @ERR_X509_STORE_set_get_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_get_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_get_crl');
  end;


  if not assigned(X509_STORE_get_get_crl) then 
  begin
    {$if declared(X509_STORE_get_get_crl_introduced)}
    if LibVersion < X509_STORE_get_get_crl_introduced then
      {$if declared(FC_X509_STORE_get_get_crl)}
      X509_STORE_get_get_crl := @FC_X509_STORE_get_get_crl
      {$else}
      X509_STORE_get_get_crl := @ERR_X509_STORE_get_get_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_get_crl_removed)}
   if X509_STORE_get_get_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_get_get_crl)}
     X509_STORE_get_get_crl := @_X509_STORE_get_get_crl
     {$else}
       {$IF declared(ERR_X509_STORE_get_get_crl)}
       X509_STORE_get_get_crl := @ERR_X509_STORE_get_get_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_get_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_get_crl');
  end;


  if not assigned(X509_STORE_set_check_crl) then 
  begin
    {$if declared(X509_STORE_set_check_crl_introduced)}
    if LibVersion < X509_STORE_set_check_crl_introduced then
      {$if declared(FC_X509_STORE_set_check_crl)}
      X509_STORE_set_check_crl := @FC_X509_STORE_set_check_crl
      {$else}
      X509_STORE_set_check_crl := @ERR_X509_STORE_set_check_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_check_crl_removed)}
   if X509_STORE_set_check_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_set_check_crl)}
     X509_STORE_set_check_crl := @_X509_STORE_set_check_crl
     {$else}
       {$IF declared(ERR_X509_STORE_set_check_crl)}
       X509_STORE_set_check_crl := @ERR_X509_STORE_set_check_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_check_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_check_crl');
  end;


  if not assigned(X509_STORE_get_check_crl) then 
  begin
    {$if declared(X509_STORE_get_check_crl_introduced)}
    if LibVersion < X509_STORE_get_check_crl_introduced then
      {$if declared(FC_X509_STORE_get_check_crl)}
      X509_STORE_get_check_crl := @FC_X509_STORE_get_check_crl
      {$else}
      X509_STORE_get_check_crl := @ERR_X509_STORE_get_check_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_check_crl_removed)}
   if X509_STORE_get_check_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_get_check_crl)}
     X509_STORE_get_check_crl := @_X509_STORE_get_check_crl
     {$else}
       {$IF declared(ERR_X509_STORE_get_check_crl)}
       X509_STORE_get_check_crl := @ERR_X509_STORE_get_check_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_check_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_check_crl');
  end;


  if not assigned(X509_STORE_set_cert_crl) then 
  begin
    {$if declared(X509_STORE_set_cert_crl_introduced)}
    if LibVersion < X509_STORE_set_cert_crl_introduced then
      {$if declared(FC_X509_STORE_set_cert_crl)}
      X509_STORE_set_cert_crl := @FC_X509_STORE_set_cert_crl
      {$else}
      X509_STORE_set_cert_crl := @ERR_X509_STORE_set_cert_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_cert_crl_removed)}
   if X509_STORE_set_cert_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_set_cert_crl)}
     X509_STORE_set_cert_crl := @_X509_STORE_set_cert_crl
     {$else}
       {$IF declared(ERR_X509_STORE_set_cert_crl)}
       X509_STORE_set_cert_crl := @ERR_X509_STORE_set_cert_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_cert_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_cert_crl');
  end;


  if not assigned(X509_STORE_get_cert_crl) then 
  begin
    {$if declared(X509_STORE_get_cert_crl_introduced)}
    if LibVersion < X509_STORE_get_cert_crl_introduced then
      {$if declared(FC_X509_STORE_get_cert_crl)}
      X509_STORE_get_cert_crl := @FC_X509_STORE_get_cert_crl
      {$else}
      X509_STORE_get_cert_crl := @ERR_X509_STORE_get_cert_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_cert_crl_removed)}
   if X509_STORE_get_cert_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_get_cert_crl)}
     X509_STORE_get_cert_crl := @_X509_STORE_get_cert_crl
     {$else}
       {$IF declared(ERR_X509_STORE_get_cert_crl)}
       X509_STORE_get_cert_crl := @ERR_X509_STORE_get_cert_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_cert_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_cert_crl');
  end;


  if not assigned(X509_STORE_set_check_policy) then 
  begin
    {$if declared(X509_STORE_set_check_policy_introduced)}
    if LibVersion < X509_STORE_set_check_policy_introduced then
      {$if declared(FC_X509_STORE_set_check_policy)}
      X509_STORE_set_check_policy := @FC_X509_STORE_set_check_policy
      {$else}
      X509_STORE_set_check_policy := @ERR_X509_STORE_set_check_policy
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_check_policy_removed)}
   if X509_STORE_set_check_policy_removed <= LibVersion then
     {$if declared(_X509_STORE_set_check_policy)}
     X509_STORE_set_check_policy := @_X509_STORE_set_check_policy
     {$else}
       {$IF declared(ERR_X509_STORE_set_check_policy)}
       X509_STORE_set_check_policy := @ERR_X509_STORE_set_check_policy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_check_policy) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_check_policy');
  end;


  if not assigned(X509_STORE_get_check_policy) then 
  begin
    {$if declared(X509_STORE_get_check_policy_introduced)}
    if LibVersion < X509_STORE_get_check_policy_introduced then
      {$if declared(FC_X509_STORE_get_check_policy)}
      X509_STORE_get_check_policy := @FC_X509_STORE_get_check_policy
      {$else}
      X509_STORE_get_check_policy := @ERR_X509_STORE_get_check_policy
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_check_policy_removed)}
   if X509_STORE_get_check_policy_removed <= LibVersion then
     {$if declared(_X509_STORE_get_check_policy)}
     X509_STORE_get_check_policy := @_X509_STORE_get_check_policy
     {$else}
       {$IF declared(ERR_X509_STORE_get_check_policy)}
       X509_STORE_get_check_policy := @ERR_X509_STORE_get_check_policy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_check_policy) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_check_policy');
  end;


  if not assigned(X509_STORE_set_cleanup) then 
  begin
    {$if declared(X509_STORE_set_cleanup_introduced)}
    if LibVersion < X509_STORE_set_cleanup_introduced then
      {$if declared(FC_X509_STORE_set_cleanup)}
      X509_STORE_set_cleanup := @FC_X509_STORE_set_cleanup
      {$else}
      X509_STORE_set_cleanup := @ERR_X509_STORE_set_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_cleanup_removed)}
   if X509_STORE_set_cleanup_removed <= LibVersion then
     {$if declared(_X509_STORE_set_cleanup)}
     X509_STORE_set_cleanup := @_X509_STORE_set_cleanup
     {$else}
       {$IF declared(ERR_X509_STORE_set_cleanup)}
       X509_STORE_set_cleanup := @ERR_X509_STORE_set_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_cleanup) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_cleanup');
  end;


  if not assigned(X509_STORE_get_cleanup) then 
  begin
    {$if declared(X509_STORE_get_cleanup_introduced)}
    if LibVersion < X509_STORE_get_cleanup_introduced then
      {$if declared(FC_X509_STORE_get_cleanup)}
      X509_STORE_get_cleanup := @FC_X509_STORE_get_cleanup
      {$else}
      X509_STORE_get_cleanup := @ERR_X509_STORE_get_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_cleanup_removed)}
   if X509_STORE_get_cleanup_removed <= LibVersion then
     {$if declared(_X509_STORE_get_cleanup)}
     X509_STORE_get_cleanup := @_X509_STORE_get_cleanup
     {$else}
       {$IF declared(ERR_X509_STORE_get_cleanup)}
       X509_STORE_get_cleanup := @ERR_X509_STORE_get_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_cleanup) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_cleanup');
  end;


  if not assigned(X509_STORE_set_ex_data) then 
  begin
    {$if declared(X509_STORE_set_ex_data_introduced)}
    if LibVersion < X509_STORE_set_ex_data_introduced then
      {$if declared(FC_X509_STORE_set_ex_data)}
      X509_STORE_set_ex_data := @FC_X509_STORE_set_ex_data
      {$else}
      X509_STORE_set_ex_data := @ERR_X509_STORE_set_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_set_ex_data_removed)}
   if X509_STORE_set_ex_data_removed <= LibVersion then
     {$if declared(_X509_STORE_set_ex_data)}
     X509_STORE_set_ex_data := @_X509_STORE_set_ex_data
     {$else}
       {$IF declared(ERR_X509_STORE_set_ex_data)}
       X509_STORE_set_ex_data := @ERR_X509_STORE_set_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_set_ex_data) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_set_ex_data');
  end;


  if not assigned(X509_STORE_get_ex_data) then 
  begin
    {$if declared(X509_STORE_get_ex_data_introduced)}
    if LibVersion < X509_STORE_get_ex_data_introduced then
      {$if declared(FC_X509_STORE_get_ex_data)}
      X509_STORE_get_ex_data := @FC_X509_STORE_get_ex_data
      {$else}
      X509_STORE_get_ex_data := @ERR_X509_STORE_get_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_get_ex_data_removed)}
   if X509_STORE_get_ex_data_removed <= LibVersion then
     {$if declared(_X509_STORE_get_ex_data)}
     X509_STORE_get_ex_data := @_X509_STORE_get_ex_data
     {$else}
       {$IF declared(ERR_X509_STORE_get_ex_data)}
       X509_STORE_get_ex_data := @ERR_X509_STORE_get_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_get_ex_data) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_get_ex_data');
  end;


  if not assigned(X509_STORE_CTX_get0_cert) then 
  begin
    {$if declared(X509_STORE_CTX_get0_cert_introduced)}
    if LibVersion < X509_STORE_CTX_get0_cert_introduced then
      {$if declared(FC_X509_STORE_CTX_get0_cert)}
      X509_STORE_CTX_get0_cert := @FC_X509_STORE_CTX_get0_cert
      {$else}
      X509_STORE_CTX_get0_cert := @ERR_X509_STORE_CTX_get0_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get0_cert_removed)}
   if X509_STORE_CTX_get0_cert_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get0_cert)}
     X509_STORE_CTX_get0_cert := @_X509_STORE_CTX_get0_cert
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get0_cert)}
       X509_STORE_CTX_get0_cert := @ERR_X509_STORE_CTX_get0_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get0_cert) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get0_cert');
  end;


  if not assigned(X509_STORE_CTX_get_verify_cb) then 
  begin
    {$if declared(X509_STORE_CTX_get_verify_cb_introduced)}
    if LibVersion < X509_STORE_CTX_get_verify_cb_introduced then
      {$if declared(FC_X509_STORE_CTX_get_verify_cb)}
      X509_STORE_CTX_get_verify_cb := @FC_X509_STORE_CTX_get_verify_cb
      {$else}
      X509_STORE_CTX_get_verify_cb := @ERR_X509_STORE_CTX_get_verify_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_verify_cb_removed)}
   if X509_STORE_CTX_get_verify_cb_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_verify_cb)}
     X509_STORE_CTX_get_verify_cb := @_X509_STORE_CTX_get_verify_cb
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_verify_cb)}
       X509_STORE_CTX_get_verify_cb := @ERR_X509_STORE_CTX_get_verify_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_verify_cb) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_verify_cb');
  end;


  if not assigned(X509_STORE_CTX_get_verify) then 
  begin
    {$if declared(X509_STORE_CTX_get_verify_introduced)}
    if LibVersion < X509_STORE_CTX_get_verify_introduced then
      {$if declared(FC_X509_STORE_CTX_get_verify)}
      X509_STORE_CTX_get_verify := @FC_X509_STORE_CTX_get_verify
      {$else}
      X509_STORE_CTX_get_verify := @ERR_X509_STORE_CTX_get_verify
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_verify_removed)}
   if X509_STORE_CTX_get_verify_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_verify)}
     X509_STORE_CTX_get_verify := @_X509_STORE_CTX_get_verify
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_verify)}
       X509_STORE_CTX_get_verify := @ERR_X509_STORE_CTX_get_verify
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_verify) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_verify');
  end;


  if not assigned(X509_STORE_CTX_get_get_issuer) then 
  begin
    {$if declared(X509_STORE_CTX_get_get_issuer_introduced)}
    if LibVersion < X509_STORE_CTX_get_get_issuer_introduced then
      {$if declared(FC_X509_STORE_CTX_get_get_issuer)}
      X509_STORE_CTX_get_get_issuer := @FC_X509_STORE_CTX_get_get_issuer
      {$else}
      X509_STORE_CTX_get_get_issuer := @ERR_X509_STORE_CTX_get_get_issuer
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_get_issuer_removed)}
   if X509_STORE_CTX_get_get_issuer_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_get_issuer)}
     X509_STORE_CTX_get_get_issuer := @_X509_STORE_CTX_get_get_issuer
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_get_issuer)}
       X509_STORE_CTX_get_get_issuer := @ERR_X509_STORE_CTX_get_get_issuer
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_get_issuer) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_get_issuer');
  end;


  if not assigned(X509_STORE_CTX_get_check_issued) then 
  begin
    {$if declared(X509_STORE_CTX_get_check_issued_introduced)}
    if LibVersion < X509_STORE_CTX_get_check_issued_introduced then
      {$if declared(FC_X509_STORE_CTX_get_check_issued)}
      X509_STORE_CTX_get_check_issued := @FC_X509_STORE_CTX_get_check_issued
      {$else}
      X509_STORE_CTX_get_check_issued := @ERR_X509_STORE_CTX_get_check_issued
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_check_issued_removed)}
   if X509_STORE_CTX_get_check_issued_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_check_issued)}
     X509_STORE_CTX_get_check_issued := @_X509_STORE_CTX_get_check_issued
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_check_issued)}
       X509_STORE_CTX_get_check_issued := @ERR_X509_STORE_CTX_get_check_issued
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_check_issued) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_check_issued');
  end;


  if not assigned(X509_STORE_CTX_get_check_revocation) then 
  begin
    {$if declared(X509_STORE_CTX_get_check_revocation_introduced)}
    if LibVersion < X509_STORE_CTX_get_check_revocation_introduced then
      {$if declared(FC_X509_STORE_CTX_get_check_revocation)}
      X509_STORE_CTX_get_check_revocation := @FC_X509_STORE_CTX_get_check_revocation
      {$else}
      X509_STORE_CTX_get_check_revocation := @ERR_X509_STORE_CTX_get_check_revocation
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_check_revocation_removed)}
   if X509_STORE_CTX_get_check_revocation_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_check_revocation)}
     X509_STORE_CTX_get_check_revocation := @_X509_STORE_CTX_get_check_revocation
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_check_revocation)}
       X509_STORE_CTX_get_check_revocation := @ERR_X509_STORE_CTX_get_check_revocation
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_check_revocation) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_check_revocation');
  end;


  if not assigned(X509_STORE_CTX_get_get_crl) then 
  begin
    {$if declared(X509_STORE_CTX_get_get_crl_introduced)}
    if LibVersion < X509_STORE_CTX_get_get_crl_introduced then
      {$if declared(FC_X509_STORE_CTX_get_get_crl)}
      X509_STORE_CTX_get_get_crl := @FC_X509_STORE_CTX_get_get_crl
      {$else}
      X509_STORE_CTX_get_get_crl := @ERR_X509_STORE_CTX_get_get_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_get_crl_removed)}
   if X509_STORE_CTX_get_get_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_get_crl)}
     X509_STORE_CTX_get_get_crl := @_X509_STORE_CTX_get_get_crl
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_get_crl)}
       X509_STORE_CTX_get_get_crl := @ERR_X509_STORE_CTX_get_get_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_get_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_get_crl');
  end;


  if not assigned(X509_STORE_CTX_get_check_crl) then 
  begin
    {$if declared(X509_STORE_CTX_get_check_crl_introduced)}
    if LibVersion < X509_STORE_CTX_get_check_crl_introduced then
      {$if declared(FC_X509_STORE_CTX_get_check_crl)}
      X509_STORE_CTX_get_check_crl := @FC_X509_STORE_CTX_get_check_crl
      {$else}
      X509_STORE_CTX_get_check_crl := @ERR_X509_STORE_CTX_get_check_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_check_crl_removed)}
   if X509_STORE_CTX_get_check_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_check_crl)}
     X509_STORE_CTX_get_check_crl := @_X509_STORE_CTX_get_check_crl
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_check_crl)}
       X509_STORE_CTX_get_check_crl := @ERR_X509_STORE_CTX_get_check_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_check_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_check_crl');
  end;


  if not assigned(X509_STORE_CTX_get_cert_crl) then 
  begin
    {$if declared(X509_STORE_CTX_get_cert_crl_introduced)}
    if LibVersion < X509_STORE_CTX_get_cert_crl_introduced then
      {$if declared(FC_X509_STORE_CTX_get_cert_crl)}
      X509_STORE_CTX_get_cert_crl := @FC_X509_STORE_CTX_get_cert_crl
      {$else}
      X509_STORE_CTX_get_cert_crl := @ERR_X509_STORE_CTX_get_cert_crl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_cert_crl_removed)}
   if X509_STORE_CTX_get_cert_crl_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_cert_crl)}
     X509_STORE_CTX_get_cert_crl := @_X509_STORE_CTX_get_cert_crl
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_cert_crl)}
       X509_STORE_CTX_get_cert_crl := @ERR_X509_STORE_CTX_get_cert_crl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_cert_crl) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_cert_crl');
  end;


  if not assigned(X509_STORE_CTX_get_check_policy) then 
  begin
    {$if declared(X509_STORE_CTX_get_check_policy_introduced)}
    if LibVersion < X509_STORE_CTX_get_check_policy_introduced then
      {$if declared(FC_X509_STORE_CTX_get_check_policy)}
      X509_STORE_CTX_get_check_policy := @FC_X509_STORE_CTX_get_check_policy
      {$else}
      X509_STORE_CTX_get_check_policy := @ERR_X509_STORE_CTX_get_check_policy
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_check_policy_removed)}
   if X509_STORE_CTX_get_check_policy_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_check_policy)}
     X509_STORE_CTX_get_check_policy := @_X509_STORE_CTX_get_check_policy
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_check_policy)}
       X509_STORE_CTX_get_check_policy := @ERR_X509_STORE_CTX_get_check_policy
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_check_policy) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_check_policy');
  end;


  if not assigned(X509_STORE_CTX_get_cleanup) then 
  begin
    {$if declared(X509_STORE_CTX_get_cleanup_introduced)}
    if LibVersion < X509_STORE_CTX_get_cleanup_introduced then
      {$if declared(FC_X509_STORE_CTX_get_cleanup)}
      X509_STORE_CTX_get_cleanup := @FC_X509_STORE_CTX_get_cleanup
      {$else}
      X509_STORE_CTX_get_cleanup := @ERR_X509_STORE_CTX_get_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_cleanup_removed)}
   if X509_STORE_CTX_get_cleanup_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_cleanup)}
     X509_STORE_CTX_get_cleanup := @_X509_STORE_CTX_get_cleanup
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_cleanup)}
       X509_STORE_CTX_get_cleanup := @ERR_X509_STORE_CTX_get_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_cleanup) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_cleanup');
  end;


  if not assigned(X509_LOOKUP_meth_new) then 
  begin
    {$if declared(X509_LOOKUP_meth_new_introduced)}
    if LibVersion < X509_LOOKUP_meth_new_introduced then
      {$if declared(FC_X509_LOOKUP_meth_new)}
      X509_LOOKUP_meth_new := @FC_X509_LOOKUP_meth_new
      {$else}
      X509_LOOKUP_meth_new := @ERR_X509_LOOKUP_meth_new
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_new_removed)}
   if X509_LOOKUP_meth_new_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_new)}
     X509_LOOKUP_meth_new := @_X509_LOOKUP_meth_new
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_new)}
       X509_LOOKUP_meth_new := @ERR_X509_LOOKUP_meth_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_new) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_new');
  end;


  if not assigned(X509_LOOKUP_meth_free) then 
  begin
    {$if declared(X509_LOOKUP_meth_free_introduced)}
    if LibVersion < X509_LOOKUP_meth_free_introduced then
      {$if declared(FC_X509_LOOKUP_meth_free)}
      X509_LOOKUP_meth_free := @FC_X509_LOOKUP_meth_free
      {$else}
      X509_LOOKUP_meth_free := @ERR_X509_LOOKUP_meth_free
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_free_removed)}
   if X509_LOOKUP_meth_free_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_free)}
     X509_LOOKUP_meth_free := @_X509_LOOKUP_meth_free
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_free)}
       X509_LOOKUP_meth_free := @ERR_X509_LOOKUP_meth_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_free) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_free');
  end;


  if not assigned(X509_LOOKUP_meth_set_ctrl) then 
  begin
    {$if declared(X509_LOOKUP_meth_set_ctrl_introduced)}
    if LibVersion < X509_LOOKUP_meth_set_ctrl_introduced then
      {$if declared(FC_X509_LOOKUP_meth_set_ctrl)}
      X509_LOOKUP_meth_set_ctrl := @FC_X509_LOOKUP_meth_set_ctrl
      {$else}
      X509_LOOKUP_meth_set_ctrl := @ERR_X509_LOOKUP_meth_set_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_set_ctrl_removed)}
   if X509_LOOKUP_meth_set_ctrl_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_set_ctrl)}
     X509_LOOKUP_meth_set_ctrl := @_X509_LOOKUP_meth_set_ctrl
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_set_ctrl)}
       X509_LOOKUP_meth_set_ctrl := @ERR_X509_LOOKUP_meth_set_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_set_ctrl) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_set_ctrl');
  end;


  if not assigned(X509_LOOKUP_meth_get_ctrl) then 
  begin
    {$if declared(X509_LOOKUP_meth_get_ctrl_introduced)}
    if LibVersion < X509_LOOKUP_meth_get_ctrl_introduced then
      {$if declared(FC_X509_LOOKUP_meth_get_ctrl)}
      X509_LOOKUP_meth_get_ctrl := @FC_X509_LOOKUP_meth_get_ctrl
      {$else}
      X509_LOOKUP_meth_get_ctrl := @ERR_X509_LOOKUP_meth_get_ctrl
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_get_ctrl_removed)}
   if X509_LOOKUP_meth_get_ctrl_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_get_ctrl)}
     X509_LOOKUP_meth_get_ctrl := @_X509_LOOKUP_meth_get_ctrl
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_get_ctrl)}
       X509_LOOKUP_meth_get_ctrl := @ERR_X509_LOOKUP_meth_get_ctrl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_get_ctrl) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_get_ctrl');
  end;


  if not assigned(X509_LOOKUP_meth_set_get_by_subject) then 
  begin
    {$if declared(X509_LOOKUP_meth_set_get_by_subject_introduced)}
    if LibVersion < X509_LOOKUP_meth_set_get_by_subject_introduced then
      {$if declared(FC_X509_LOOKUP_meth_set_get_by_subject)}
      X509_LOOKUP_meth_set_get_by_subject := @FC_X509_LOOKUP_meth_set_get_by_subject
      {$else}
      X509_LOOKUP_meth_set_get_by_subject := @ERR_X509_LOOKUP_meth_set_get_by_subject
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_set_get_by_subject_removed)}
   if X509_LOOKUP_meth_set_get_by_subject_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_set_get_by_subject)}
     X509_LOOKUP_meth_set_get_by_subject := @_X509_LOOKUP_meth_set_get_by_subject
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_set_get_by_subject)}
       X509_LOOKUP_meth_set_get_by_subject := @ERR_X509_LOOKUP_meth_set_get_by_subject
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_set_get_by_subject) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_set_get_by_subject');
  end;


  if not assigned(X509_LOOKUP_meth_get_get_by_subject) then 
  begin
    {$if declared(X509_LOOKUP_meth_get_get_by_subject_introduced)}
    if LibVersion < X509_LOOKUP_meth_get_get_by_subject_introduced then
      {$if declared(FC_X509_LOOKUP_meth_get_get_by_subject)}
      X509_LOOKUP_meth_get_get_by_subject := @FC_X509_LOOKUP_meth_get_get_by_subject
      {$else}
      X509_LOOKUP_meth_get_get_by_subject := @ERR_X509_LOOKUP_meth_get_get_by_subject
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_get_get_by_subject_removed)}
   if X509_LOOKUP_meth_get_get_by_subject_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_get_get_by_subject)}
     X509_LOOKUP_meth_get_get_by_subject := @_X509_LOOKUP_meth_get_get_by_subject
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_get_get_by_subject)}
       X509_LOOKUP_meth_get_get_by_subject := @ERR_X509_LOOKUP_meth_get_get_by_subject
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_get_get_by_subject) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_get_get_by_subject');
  end;


  if not assigned(X509_LOOKUP_meth_set_get_by_issuer_serial) then 
  begin
    {$if declared(X509_LOOKUP_meth_set_get_by_issuer_serial_introduced)}
    if LibVersion < X509_LOOKUP_meth_set_get_by_issuer_serial_introduced then
      {$if declared(FC_X509_LOOKUP_meth_set_get_by_issuer_serial)}
      X509_LOOKUP_meth_set_get_by_issuer_serial := @FC_X509_LOOKUP_meth_set_get_by_issuer_serial
      {$else}
      X509_LOOKUP_meth_set_get_by_issuer_serial := @ERR_X509_LOOKUP_meth_set_get_by_issuer_serial
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_set_get_by_issuer_serial_removed)}
   if X509_LOOKUP_meth_set_get_by_issuer_serial_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_set_get_by_issuer_serial)}
     X509_LOOKUP_meth_set_get_by_issuer_serial := @_X509_LOOKUP_meth_set_get_by_issuer_serial
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_set_get_by_issuer_serial)}
       X509_LOOKUP_meth_set_get_by_issuer_serial := @ERR_X509_LOOKUP_meth_set_get_by_issuer_serial
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_set_get_by_issuer_serial) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_set_get_by_issuer_serial');
  end;


  if not assigned(X509_LOOKUP_meth_get_get_by_issuer_serial) then 
  begin
    {$if declared(X509_LOOKUP_meth_get_get_by_issuer_serial_introduced)}
    if LibVersion < X509_LOOKUP_meth_get_get_by_issuer_serial_introduced then
      {$if declared(FC_X509_LOOKUP_meth_get_get_by_issuer_serial)}
      X509_LOOKUP_meth_get_get_by_issuer_serial := @FC_X509_LOOKUP_meth_get_get_by_issuer_serial
      {$else}
      X509_LOOKUP_meth_get_get_by_issuer_serial := @ERR_X509_LOOKUP_meth_get_get_by_issuer_serial
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_get_get_by_issuer_serial_removed)}
   if X509_LOOKUP_meth_get_get_by_issuer_serial_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_get_get_by_issuer_serial)}
     X509_LOOKUP_meth_get_get_by_issuer_serial := @_X509_LOOKUP_meth_get_get_by_issuer_serial
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_get_get_by_issuer_serial)}
       X509_LOOKUP_meth_get_get_by_issuer_serial := @ERR_X509_LOOKUP_meth_get_get_by_issuer_serial
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_get_get_by_issuer_serial) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_get_get_by_issuer_serial');
  end;


  if not assigned(X509_LOOKUP_meth_set_get_by_fingerprint) then 
  begin
    {$if declared(X509_LOOKUP_meth_set_get_by_fingerprint_introduced)}
    if LibVersion < X509_LOOKUP_meth_set_get_by_fingerprint_introduced then
      {$if declared(FC_X509_LOOKUP_meth_set_get_by_fingerprint)}
      X509_LOOKUP_meth_set_get_by_fingerprint := @FC_X509_LOOKUP_meth_set_get_by_fingerprint
      {$else}
      X509_LOOKUP_meth_set_get_by_fingerprint := @ERR_X509_LOOKUP_meth_set_get_by_fingerprint
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_set_get_by_fingerprint_removed)}
   if X509_LOOKUP_meth_set_get_by_fingerprint_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_set_get_by_fingerprint)}
     X509_LOOKUP_meth_set_get_by_fingerprint := @_X509_LOOKUP_meth_set_get_by_fingerprint
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_set_get_by_fingerprint)}
       X509_LOOKUP_meth_set_get_by_fingerprint := @ERR_X509_LOOKUP_meth_set_get_by_fingerprint
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_set_get_by_fingerprint) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_set_get_by_fingerprint');
  end;


  if not assigned(X509_LOOKUP_meth_get_get_by_fingerprint) then 
  begin
    {$if declared(X509_LOOKUP_meth_get_get_by_fingerprint_introduced)}
    if LibVersion < X509_LOOKUP_meth_get_get_by_fingerprint_introduced then
      {$if declared(FC_X509_LOOKUP_meth_get_get_by_fingerprint)}
      X509_LOOKUP_meth_get_get_by_fingerprint := @FC_X509_LOOKUP_meth_get_get_by_fingerprint
      {$else}
      X509_LOOKUP_meth_get_get_by_fingerprint := @ERR_X509_LOOKUP_meth_get_get_by_fingerprint
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_get_get_by_fingerprint_removed)}
   if X509_LOOKUP_meth_get_get_by_fingerprint_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_get_get_by_fingerprint)}
     X509_LOOKUP_meth_get_get_by_fingerprint := @_X509_LOOKUP_meth_get_get_by_fingerprint
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_get_get_by_fingerprint)}
       X509_LOOKUP_meth_get_get_by_fingerprint := @ERR_X509_LOOKUP_meth_get_get_by_fingerprint
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_get_get_by_fingerprint) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_get_get_by_fingerprint');
  end;


  if not assigned(X509_LOOKUP_meth_set_get_by_alias) then 
  begin
    {$if declared(X509_LOOKUP_meth_set_get_by_alias_introduced)}
    if LibVersion < X509_LOOKUP_meth_set_get_by_alias_introduced then
      {$if declared(FC_X509_LOOKUP_meth_set_get_by_alias)}
      X509_LOOKUP_meth_set_get_by_alias := @FC_X509_LOOKUP_meth_set_get_by_alias
      {$else}
      X509_LOOKUP_meth_set_get_by_alias := @ERR_X509_LOOKUP_meth_set_get_by_alias
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_set_get_by_alias_removed)}
   if X509_LOOKUP_meth_set_get_by_alias_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_set_get_by_alias)}
     X509_LOOKUP_meth_set_get_by_alias := @_X509_LOOKUP_meth_set_get_by_alias
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_set_get_by_alias)}
       X509_LOOKUP_meth_set_get_by_alias := @ERR_X509_LOOKUP_meth_set_get_by_alias
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_set_get_by_alias) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_set_get_by_alias');
  end;


  if not assigned(X509_LOOKUP_meth_get_get_by_alias) then 
  begin
    {$if declared(X509_LOOKUP_meth_get_get_by_alias_introduced)}
    if LibVersion < X509_LOOKUP_meth_get_get_by_alias_introduced then
      {$if declared(FC_X509_LOOKUP_meth_get_get_by_alias)}
      X509_LOOKUP_meth_get_get_by_alias := @FC_X509_LOOKUP_meth_get_get_by_alias
      {$else}
      X509_LOOKUP_meth_get_get_by_alias := @ERR_X509_LOOKUP_meth_get_get_by_alias
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_meth_get_get_by_alias_removed)}
   if X509_LOOKUP_meth_get_get_by_alias_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_meth_get_get_by_alias)}
     X509_LOOKUP_meth_get_get_by_alias := @_X509_LOOKUP_meth_get_get_by_alias
     {$else}
       {$IF declared(ERR_X509_LOOKUP_meth_get_get_by_alias)}
       X509_LOOKUP_meth_get_get_by_alias := @ERR_X509_LOOKUP_meth_get_get_by_alias
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_meth_get_get_by_alias) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_meth_get_get_by_alias');
  end;


  if not assigned(X509_STORE_CTX_get_by_subject) then 
  begin
    {$if declared(X509_STORE_CTX_get_by_subject_introduced)}
    if LibVersion < X509_STORE_CTX_get_by_subject_introduced then
      {$if declared(FC_X509_STORE_CTX_get_by_subject)}
      X509_STORE_CTX_get_by_subject := @FC_X509_STORE_CTX_get_by_subject
      {$else}
      X509_STORE_CTX_get_by_subject := @ERR_X509_STORE_CTX_get_by_subject
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_by_subject_removed)}
   if X509_STORE_CTX_get_by_subject_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_by_subject)}
     X509_STORE_CTX_get_by_subject := @_X509_STORE_CTX_get_by_subject
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_by_subject)}
       X509_STORE_CTX_get_by_subject := @ERR_X509_STORE_CTX_get_by_subject
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_by_subject) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_by_subject');
  end;


  if not assigned(X509_STORE_CTX_get_obj_by_subject) then 
  begin
    {$if declared(X509_STORE_CTX_get_obj_by_subject_introduced)}
    if LibVersion < X509_STORE_CTX_get_obj_by_subject_introduced then
      {$if declared(FC_X509_STORE_CTX_get_obj_by_subject)}
      X509_STORE_CTX_get_obj_by_subject := @FC_X509_STORE_CTX_get_obj_by_subject
      {$else}
      X509_STORE_CTX_get_obj_by_subject := @ERR_X509_STORE_CTX_get_obj_by_subject
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_obj_by_subject_removed)}
   if X509_STORE_CTX_get_obj_by_subject_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_obj_by_subject)}
     X509_STORE_CTX_get_obj_by_subject := @_X509_STORE_CTX_get_obj_by_subject
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_obj_by_subject)}
       X509_STORE_CTX_get_obj_by_subject := @ERR_X509_STORE_CTX_get_obj_by_subject
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_obj_by_subject) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_obj_by_subject');
  end;


  if not assigned(X509_LOOKUP_set_method_data) then 
  begin
    {$if declared(X509_LOOKUP_set_method_data_introduced)}
    if LibVersion < X509_LOOKUP_set_method_data_introduced then
      {$if declared(FC_X509_LOOKUP_set_method_data)}
      X509_LOOKUP_set_method_data := @FC_X509_LOOKUP_set_method_data
      {$else}
      X509_LOOKUP_set_method_data := @ERR_X509_LOOKUP_set_method_data
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_set_method_data_removed)}
   if X509_LOOKUP_set_method_data_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_set_method_data)}
     X509_LOOKUP_set_method_data := @_X509_LOOKUP_set_method_data
     {$else}
       {$IF declared(ERR_X509_LOOKUP_set_method_data)}
       X509_LOOKUP_set_method_data := @ERR_X509_LOOKUP_set_method_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_set_method_data) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_set_method_data');
  end;


  if not assigned(X509_LOOKUP_get_method_data) then 
  begin
    {$if declared(X509_LOOKUP_get_method_data_introduced)}
    if LibVersion < X509_LOOKUP_get_method_data_introduced then
      {$if declared(FC_X509_LOOKUP_get_method_data)}
      X509_LOOKUP_get_method_data := @FC_X509_LOOKUP_get_method_data
      {$else}
      X509_LOOKUP_get_method_data := @ERR_X509_LOOKUP_get_method_data
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_get_method_data_removed)}
   if X509_LOOKUP_get_method_data_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_get_method_data)}
     X509_LOOKUP_get_method_data := @_X509_LOOKUP_get_method_data
     {$else}
       {$IF declared(ERR_X509_LOOKUP_get_method_data)}
       X509_LOOKUP_get_method_data := @ERR_X509_LOOKUP_get_method_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_get_method_data) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_get_method_data');
  end;


  if not assigned(X509_LOOKUP_get_store) then 
  begin
    {$if declared(X509_LOOKUP_get_store_introduced)}
    if LibVersion < X509_LOOKUP_get_store_introduced then
      {$if declared(FC_X509_LOOKUP_get_store)}
      X509_LOOKUP_get_store := @FC_X509_LOOKUP_get_store
      {$else}
      X509_LOOKUP_get_store := @ERR_X509_LOOKUP_get_store
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_LOOKUP_get_store_removed)}
   if X509_LOOKUP_get_store_removed <= LibVersion then
     {$if declared(_X509_LOOKUP_get_store)}
     X509_LOOKUP_get_store := @_X509_LOOKUP_get_store
     {$else}
       {$IF declared(ERR_X509_LOOKUP_get_store)}
       X509_LOOKUP_get_store := @ERR_X509_LOOKUP_get_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_LOOKUP_get_store) and Assigned(AFailed) then 
     AFailed.Add('X509_LOOKUP_get_store');
  end;


  if not assigned(X509_STORE_CTX_set_error_depth) then 
  begin
    {$if declared(X509_STORE_CTX_set_error_depth_introduced)}
    if LibVersion < X509_STORE_CTX_set_error_depth_introduced then
      {$if declared(FC_X509_STORE_CTX_set_error_depth)}
      X509_STORE_CTX_set_error_depth := @FC_X509_STORE_CTX_set_error_depth
      {$else}
      X509_STORE_CTX_set_error_depth := @ERR_X509_STORE_CTX_set_error_depth
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_set_error_depth_removed)}
   if X509_STORE_CTX_set_error_depth_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_set_error_depth)}
     X509_STORE_CTX_set_error_depth := @_X509_STORE_CTX_set_error_depth
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_set_error_depth)}
       X509_STORE_CTX_set_error_depth := @ERR_X509_STORE_CTX_set_error_depth
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_set_error_depth) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_set_error_depth');
  end;


  if not assigned(X509_STORE_CTX_set_current_cert) then 
  begin
    {$if declared(X509_STORE_CTX_set_current_cert_introduced)}
    if LibVersion < X509_STORE_CTX_set_current_cert_introduced then
      {$if declared(FC_X509_STORE_CTX_set_current_cert)}
      X509_STORE_CTX_set_current_cert := @FC_X509_STORE_CTX_set_current_cert
      {$else}
      X509_STORE_CTX_set_current_cert := @ERR_X509_STORE_CTX_set_current_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_set_current_cert_removed)}
   if X509_STORE_CTX_set_current_cert_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_set_current_cert)}
     X509_STORE_CTX_set_current_cert := @_X509_STORE_CTX_set_current_cert
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_set_current_cert)}
       X509_STORE_CTX_set_current_cert := @ERR_X509_STORE_CTX_set_current_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_set_current_cert) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_set_current_cert');
  end;


  if not assigned(X509_STORE_CTX_get_num_untrusted) then 
  begin
    {$if declared(X509_STORE_CTX_get_num_untrusted_introduced)}
    if LibVersion < X509_STORE_CTX_get_num_untrusted_introduced then
      {$if declared(FC_X509_STORE_CTX_get_num_untrusted)}
      X509_STORE_CTX_get_num_untrusted := @FC_X509_STORE_CTX_get_num_untrusted
      {$else}
      X509_STORE_CTX_get_num_untrusted := @ERR_X509_STORE_CTX_get_num_untrusted
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_get_num_untrusted_removed)}
   if X509_STORE_CTX_get_num_untrusted_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_get_num_untrusted)}
     X509_STORE_CTX_get_num_untrusted := @_X509_STORE_CTX_get_num_untrusted
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_get_num_untrusted)}
       X509_STORE_CTX_get_num_untrusted := @ERR_X509_STORE_CTX_get_num_untrusted
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_get_num_untrusted) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_get_num_untrusted');
  end;


  if not assigned(X509_STORE_CTX_set0_dane) then 
  begin
    {$if declared(X509_STORE_CTX_set0_dane_introduced)}
    if LibVersion < X509_STORE_CTX_set0_dane_introduced then
      {$if declared(FC_X509_STORE_CTX_set0_dane)}
      X509_STORE_CTX_set0_dane := @FC_X509_STORE_CTX_set0_dane
      {$else}
      X509_STORE_CTX_set0_dane := @ERR_X509_STORE_CTX_set0_dane
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_STORE_CTX_set0_dane_removed)}
   if X509_STORE_CTX_set0_dane_removed <= LibVersion then
     {$if declared(_X509_STORE_CTX_set0_dane)}
     X509_STORE_CTX_set0_dane := @_X509_STORE_CTX_set0_dane
     {$else}
       {$IF declared(ERR_X509_STORE_CTX_set0_dane)}
       X509_STORE_CTX_set0_dane := @ERR_X509_STORE_CTX_set0_dane
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_STORE_CTX_set0_dane) and Assigned(AFailed) then 
     AFailed.Add('X509_STORE_CTX_set0_dane');
  end;


  if not assigned(X509_VERIFY_PARAM_set_auth_level) then 
  begin
    {$if declared(X509_VERIFY_PARAM_set_auth_level_introduced)}
    if LibVersion < X509_VERIFY_PARAM_set_auth_level_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_set_auth_level)}
      X509_VERIFY_PARAM_set_auth_level := @FC_X509_VERIFY_PARAM_set_auth_level
      {$else}
      X509_VERIFY_PARAM_set_auth_level := @ERR_X509_VERIFY_PARAM_set_auth_level
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_set_auth_level_removed)}
   if X509_VERIFY_PARAM_set_auth_level_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_set_auth_level)}
     X509_VERIFY_PARAM_set_auth_level := @_X509_VERIFY_PARAM_set_auth_level
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_set_auth_level)}
       X509_VERIFY_PARAM_set_auth_level := @ERR_X509_VERIFY_PARAM_set_auth_level
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_set_auth_level) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_set_auth_level');
  end;


  if not assigned(X509_VERIFY_PARAM_set_inh_flags) then 
  begin
    {$if declared(X509_VERIFY_PARAM_set_inh_flags_introduced)}
    if LibVersion < X509_VERIFY_PARAM_set_inh_flags_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_set_inh_flags)}
      X509_VERIFY_PARAM_set_inh_flags := @FC_X509_VERIFY_PARAM_set_inh_flags
      {$else}
      X509_VERIFY_PARAM_set_inh_flags := @ERR_X509_VERIFY_PARAM_set_inh_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_set_inh_flags_removed)}
   if X509_VERIFY_PARAM_set_inh_flags_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_set_inh_flags)}
     X509_VERIFY_PARAM_set_inh_flags := @_X509_VERIFY_PARAM_set_inh_flags
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_set_inh_flags)}
       X509_VERIFY_PARAM_set_inh_flags := @ERR_X509_VERIFY_PARAM_set_inh_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_set_inh_flags) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_set_inh_flags');
  end;


  if not assigned(X509_VERIFY_PARAM_get_inh_flags) then 
  begin
    {$if declared(X509_VERIFY_PARAM_get_inh_flags_introduced)}
    if LibVersion < X509_VERIFY_PARAM_get_inh_flags_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_get_inh_flags)}
      X509_VERIFY_PARAM_get_inh_flags := @FC_X509_VERIFY_PARAM_get_inh_flags
      {$else}
      X509_VERIFY_PARAM_get_inh_flags := @ERR_X509_VERIFY_PARAM_get_inh_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_get_inh_flags_removed)}
   if X509_VERIFY_PARAM_get_inh_flags_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_get_inh_flags)}
     X509_VERIFY_PARAM_get_inh_flags := @_X509_VERIFY_PARAM_get_inh_flags
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_get_inh_flags)}
       X509_VERIFY_PARAM_get_inh_flags := @ERR_X509_VERIFY_PARAM_get_inh_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_get_inh_flags) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_get_inh_flags');
  end;


  if not assigned(X509_VERIFY_PARAM_get_hostflags) then 
  begin
    {$if declared(X509_VERIFY_PARAM_get_hostflags_introduced)}
    if LibVersion < X509_VERIFY_PARAM_get_hostflags_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_get_hostflags)}
      X509_VERIFY_PARAM_get_hostflags := @FC_X509_VERIFY_PARAM_get_hostflags
      {$else}
      X509_VERIFY_PARAM_get_hostflags := @ERR_X509_VERIFY_PARAM_get_hostflags
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_get_hostflags_removed)}
   if X509_VERIFY_PARAM_get_hostflags_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_get_hostflags)}
     X509_VERIFY_PARAM_get_hostflags := @_X509_VERIFY_PARAM_get_hostflags
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_get_hostflags)}
       X509_VERIFY_PARAM_get_hostflags := @ERR_X509_VERIFY_PARAM_get_hostflags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_get_hostflags) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_get_hostflags');
  end;


  if not assigned(X509_VERIFY_PARAM_move_peername) then 
  begin
    {$if declared(X509_VERIFY_PARAM_move_peername_introduced)}
    if LibVersion < X509_VERIFY_PARAM_move_peername_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_move_peername)}
      X509_VERIFY_PARAM_move_peername := @FC_X509_VERIFY_PARAM_move_peername
      {$else}
      X509_VERIFY_PARAM_move_peername := @ERR_X509_VERIFY_PARAM_move_peername
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_move_peername_removed)}
   if X509_VERIFY_PARAM_move_peername_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_move_peername)}
     X509_VERIFY_PARAM_move_peername := @_X509_VERIFY_PARAM_move_peername
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_move_peername)}
       X509_VERIFY_PARAM_move_peername := @ERR_X509_VERIFY_PARAM_move_peername
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_move_peername) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_move_peername');
  end;


  if not assigned(X509_VERIFY_PARAM_get_auth_level) then 
  begin
    {$if declared(X509_VERIFY_PARAM_get_auth_level_introduced)}
    if LibVersion < X509_VERIFY_PARAM_get_auth_level_introduced then
      {$if declared(FC_X509_VERIFY_PARAM_get_auth_level)}
      X509_VERIFY_PARAM_get_auth_level := @FC_X509_VERIFY_PARAM_get_auth_level
      {$else}
      X509_VERIFY_PARAM_get_auth_level := @ERR_X509_VERIFY_PARAM_get_auth_level
      {$ifend}
    else
    {$ifend}
   {$if declared(X509_VERIFY_PARAM_get_auth_level_removed)}
   if X509_VERIFY_PARAM_get_auth_level_removed <= LibVersion then
     {$if declared(_X509_VERIFY_PARAM_get_auth_level)}
     X509_VERIFY_PARAM_get_auth_level := @_X509_VERIFY_PARAM_get_auth_level
     {$else}
       {$IF declared(ERR_X509_VERIFY_PARAM_get_auth_level)}
       X509_VERIFY_PARAM_get_auth_level := @ERR_X509_VERIFY_PARAM_get_auth_level
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(X509_VERIFY_PARAM_get_auth_level) and Assigned(AFailed) then 
     AFailed.Add('X509_VERIFY_PARAM_get_auth_level');
  end;


end;

procedure Unload;
begin
  X509_STORE_set_depth := nil;
  X509_STORE_CTX_set_depth := nil;
  X509_STORE_CTX_get_app_data := nil; {removed 1.0.0}
  X509_OBJECT_up_ref_count := nil;
  X509_OBJECT_new := nil; {introduced 1.1.0}
  X509_OBJECT_free := nil; {introduced 1.1.0}
  X509_OBJECT_get_type := nil; {introduced 1.1.0}
  X509_OBJECT_get0_X509 := nil; {introduced 1.1.0}
  X509_OBJECT_set1_X509 := nil; {introduced 1.1.0}
  X509_OBJECT_get0_X509_CRL := nil; {introduced 1.1.0}
  X509_OBJECT_set1_X509_CRL := nil; {introduced 1.1.0}
  X509_STORE_new := nil;
  X509_STORE_free := nil;
  X509_STORE_lock := nil; {introduced 1.1.0}
  X509_STORE_unlock := nil; {introduced 1.1.0}
  X509_STORE_up_ref := nil; {introduced 1.1.0}
  X509_STORE_set_flags := nil;
  X509_STORE_set_purpose := nil;
  X509_STORE_set_trust := nil;
  X509_STORE_set1_param := nil;
  X509_STORE_get0_param := nil; {introduced 1.1.0}
  X509_STORE_set_verify := nil; {introduced 1.1.0}
  X509_STORE_CTX_set_verify := nil; {introduced 1.1.0}
  X509_STORE_get_verify := nil; {introduced 1.1.0}
  X509_STORE_set_verify_cb := nil;
  X509_STORE_get_verify_cb := nil; {introduced 1.1.0}
  X509_STORE_set_get_issuer := nil; {introduced 1.1.0}
  X509_STORE_get_get_issuer := nil; {introduced 1.1.0}
  X509_STORE_set_check_issued := nil; {introduced 1.1.0}
  X509_STORE_get_check_issued := nil; {introduced 1.1.0}
  X509_STORE_set_check_revocation := nil; {introduced 1.1.0}
  X509_STORE_get_check_revocation := nil; {introduced 1.1.0}
  X509_STORE_set_get_crl := nil; {introduced 1.1.0}
  X509_STORE_get_get_crl := nil; {introduced 1.1.0}
  X509_STORE_set_check_crl := nil; {introduced 1.1.0}
  X509_STORE_get_check_crl := nil; {introduced 1.1.0}
  X509_STORE_set_cert_crl := nil; {introduced 1.1.0}
  X509_STORE_get_cert_crl := nil; {introduced 1.1.0}
  X509_STORE_set_check_policy := nil; {introduced 1.1.0}
  X509_STORE_get_check_policy := nil; {introduced 1.1.0}
  X509_STORE_set_cleanup := nil; {introduced 1.1.0}
  X509_STORE_get_cleanup := nil; {introduced 1.1.0}
  X509_STORE_set_ex_data := nil; {introduced 1.1.0}
  X509_STORE_get_ex_data := nil; {introduced 1.1.0}
  X509_STORE_CTX_new := nil;
  X509_STORE_CTX_get1_issuer := nil;
  X509_STORE_CTX_free := nil;
  X509_STORE_CTX_cleanup := nil;
  X509_STORE_CTX_get0_store := nil;
  X509_STORE_CTX_get0_cert := nil; {introduced 1.1.0}
  X509_STORE_CTX_set_verify_cb := nil;
  X509_STORE_CTX_get_verify_cb := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_verify := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_get_issuer := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_issued := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_revocation := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_get_crl := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_crl := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_cert_crl := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_check_policy := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_cleanup := nil; {introduced 1.1.0}
  X509_STORE_add_lookup := nil;
  X509_LOOKUP_hash_dir := nil;
  X509_LOOKUP_file := nil;
  X509_LOOKUP_meth_new := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_free := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_set_ctrl := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_ctrl := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_subject := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_subject := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_issuer_serial := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_issuer_serial := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_fingerprint := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_fingerprint := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_set_get_by_alias := nil; {introduced 1.1.0}
  X509_LOOKUP_meth_get_get_by_alias := nil; {introduced 1.1.0}
  X509_STORE_add_cert := nil;
  X509_STORE_add_crl := nil;
  X509_STORE_CTX_get_by_subject := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_obj_by_subject := nil; {introduced 1.1.0}
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
  X509_LOOKUP_set_method_data := nil; {introduced 1.1.0}
  X509_LOOKUP_get_method_data := nil; {introduced 1.1.0}
  X509_LOOKUP_get_store := nil; {introduced 1.1.0}
  X509_LOOKUP_shutdown := nil;
  X509_STORE_load_locations := nil;
  X509_STORE_set_default_paths := nil;
  X509_STORE_CTX_set_ex_data := nil;
  X509_STORE_CTX_get_ex_data := nil;
  X509_STORE_CTX_get_error := nil;
  X509_STORE_CTX_set_error := nil;
  X509_STORE_CTX_get_error_depth := nil;
  X509_STORE_CTX_set_error_depth := nil; {introduced 1.1.0}
  X509_STORE_CTX_get_current_cert := nil;
  X509_STORE_CTX_set_current_cert := nil; {introduced 1.1.0}
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
  X509_STORE_CTX_get_num_untrusted := nil; {introduced 1.1.0}
  X509_STORE_CTX_get0_param := nil;
  X509_STORE_CTX_set0_param := nil;
  X509_STORE_CTX_set_default := nil;
  X509_STORE_CTX_set0_dane := nil; {introduced 1.1.0}
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
  X509_VERIFY_PARAM_set_auth_level := nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_add0_policy := nil;
  X509_VERIFY_PARAM_set_inh_flags := nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_get_inh_flags := nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_set1_host := nil;
  X509_VERIFY_PARAM_add1_host := nil;
  X509_VERIFY_PARAM_set_hostflags := nil;
  X509_VERIFY_PARAM_get_hostflags := nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_get0_peername := nil;
  X509_VERIFY_PARAM_move_peername := nil; {introduced 1.1.0}
  X509_VERIFY_PARAM_set1_email := nil;
  X509_VERIFY_PARAM_set1_ip := nil;
  X509_VERIFY_PARAM_set1_ip_asc := nil;
  X509_VERIFY_PARAM_get_depth := nil;
  X509_VERIFY_PARAM_get_auth_level := nil; {introduced 1.1.0}
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
{$ELSE}
function X509_STORE_CTX_get_app_data(ctx: PX509_STORE_CTX): Pointer;
begin
  Result := X509_STORE_CTX_get_ex_data(ctx,SSL_get_ex_data_X509_STORE_CTX_idx);
end;


{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
