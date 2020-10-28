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

unit IdOpenSSLHeaders_ts;

interface

// Headers for OpenSSL 1.1.1
// ts.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_asn1,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_pkcs7,
  IdOpenSSLHeaders_rsa,
  IdOpenSSLHeaders_tserr,
  IdOpenSSLHeaders_x509,
  IdOpenSSLHeaders_x509v3;

const
  (* Possible values for status. *)
  TS_STATUS_GRANTED = 0;
  TS_STATUS_GRANTED_WITH_MODS = 1;
  TS_STATUS_REJECTION = 2;
  TS_STATUS_WAITING = 3;
  TS_STATUS_REVOCATION_WARNING = 4;
  TS_STATUS_REVOCATION_NOTIFICATION = 5;


  (* Possible values for failure_info. *)
  TS_INFO_BAD_ALG = 0;
  TS_INFO_BAD_REQUEST = 2;
  TS_INFO_BAD_DATA_FORMAT = 5;
  TS_INFO_TIME_NOT_AVAILABLE = 14;
  TS_INFO_UNACCEPTED_POLICY = 15;
  TS_INFO_UNACCEPTED_EXTENSION = 16;
  TS_INFO_ADD_INFO_NOT_AVAILABLE = 17;
  TS_INFO_SYSTEM_FAILURE = 25;

  (* Optional flags for response generation. *)

  (* Don't include the TSA name in response. *)
  TS_TSA_NAME = $01;

  (* Set ordering to true in response. *)
  TS_ORDERING = $02;

  (*
   * Include the signer certificate and the other specified certificates in
   * the ESS signing certificate attribute beside the PKCS7 signed data.
   * Only the signer certificates is included by default.
   *)
  TS_ESS_CERT_ID_CHAIN = $04;

  (* At most we accept usec precision. *)
  TS_MAX_CLOCK_PRECISION_DIGITS = 6;

  (* Maximum status message length *)
  TS_MAX_STATUS_LENGTH = 1024 * 1024;

  (* Verify the signer's certificate and the signature of the response. *)
  TS_VFY_SIGNATURE = TIdC_UINT(1) shl 0;
  (* Verify the version number of the response. *)
  TS_VFY_VERSION = TIdC_UINT(1) shl 1;
  (* Verify if the policy supplied by the user matches the policy of the TSA. *)
  TS_VFY_POLICY = TIdC_UINT(1) shl 2;
  (*
   * Verify the message imprint provided by the user. This flag should not be
   * specified with TS_VFY_DATA.
   *)
  TS_VFY_IMPRINT = TIdC_UINT(1) shl 3;
  (*
   * Verify the message imprint computed by the verify method from the user
   * provided data and the MD algorithm of the response. This flag should not
   * be specified with TS_VFY_IMPRINT.
   *)
  TS_VFY_DATA = TIdC_UINT(1) shl 4;
  (* Verify the nonce value. *)
  TS_VFY_NONCE = TIdC_UINT(1) shl 5;
  (* Verify if the TSA name field matches the signer certificate. *)
  TS_VFY_SIGNER = TIdC_UINT(1) shl 6;
  (* Verify if the TSA name field equals to the user provided name. *)
  TS_VFY_TSA_NAME = TIdC_UINT(1) shl 7;

  (* You can use the following convenience constants. *)
  TS_VFY_ALL_IMPRINT = TS_VFY_SIGNATURE or TS_VFY_VERSION or TS_VFY_POLICY
    or TS_VFY_IMPRINT or TS_VFY_NONCE or TS_VFY_SIGNER or TS_VFY_TSA_NAME;

  TS_VFY_ALL_DATA = TS_VFY_SIGNATURE or TS_VFY_VERSION or TS_VFY_POLICY
    or TS_VFY_DATA or TS_VFY_NONCE or TS_VFY_SIGNER or TS_VFY_TSA_NAME;

type
  TS_msg_imprint_st = type Pointer;
  TS_req_st = type Pointer;
  TS_accuracy_st = type Pointer;
  TS_tst_info_st = type Pointer;

  TS_MSG_IMPRINT = TS_msg_imprint_st;
  PTS_MSG_IMPRINT = ^TS_MSG_IMPRINT;
  PPTS_MSG_IMPRINT = ^PTS_MSG_IMPRINT;

  TS_REQ = TS_req_st;
  PTS_REQ = ^TS_REQ;
  PPTS_REQ = ^PTS_REQ;

  TS_ACCURACY = TS_accuracy_st;
  PTS_ACCURACY = ^TS_ACCURACY;
  PPTS_ACCURACY = ^PTS_ACCURACY;

  TS_TST_INFO = TS_tst_info_st;
  PTS_TST_INFO = ^TS_TST_INFO;
  PPTS_TST_INFO = ^PTS_TST_INFO;

  TS_status_info_st = type Pointer;
  ESS_issuer_serial_st = type Pointer;
  ESS_cert_id_st = type Pointer;
  ESS_signing_cert_st = type Pointer;
  ESS_cert_id_v2_st = type Pointer;
  ESS_signing_cert_v2_st = type Pointer;

  TS_STATUS_INFO = TS_status_info_st;
  PTS_STATUS_INFO = ^TS_STATUS_INFO;
  PPTS_STATUS_INFO = ^PTS_STATUS_INFO;

  ESS_ISSUER_SERIAL = ESS_issuer_serial_st;
  PESS_ISSUER_SERIAL = ^ESS_ISSUER_SERIAL;
  PPESS_ISSUER_SERIAL = ^PESS_ISSUER_SERIAL;

  ESS_CERT_ID = ESS_cert_id_st;
  PESS_CERT_ID = ^ESS_CERT_ID;
  PPESS_CERT_ID = ^PESS_CERT_ID;

  ESS_SIGNING_CERT = ESS_signing_cert_st;
  PESS_SIGNING_CERT = ^ESS_SIGNING_CERT;
  PPESS_SIGNING_CERT = ^PESS_SIGNING_CERT;

// DEFINE_STACK_OF(ESS_CERT_ID)

  ESS_CERT_ID_V2 = ESS_cert_id_v2_st;
  PESS_CERT_ID_V2 = ^ESS_CERT_ID_V2;
  PPESS_CERT_ID_V2 = ^PESS_CERT_ID_V2;

  ESS_SIGNING_CERT_V2 = ESS_signing_cert_v2_st;
  PESS_SIGNING_CERT_V2 = ^ESS_SIGNING_CERT_V2;
  PPESS_SIGNING_CERT_V2 = ^PESS_SIGNING_CERT_V2;

// DEFINE_STACK_OF(ESS_CERT_ID_V2)
  TS_resp_st = type Pointer;
  TS_RESP = TS_resp_st;
  PTS_RESP = ^TS_RESP;
  PPTS_RESP = ^PTS_RESP;

  (* Forward declaration. *)
  TS_resp_ctx = type Pointer;
  PTS_resp_ctx = ^TS_resp_ctx;
  PPTS_resp_ctx = ^PTS_resp_ctx;

  (* This must return a unique number less than 160 bits long. *)
  TS_serial_cb = function({struct} v1: PTS_resp_ctx; v2: Pointer): PASN1_INTEGER;

  (*
   * This must return the seconds and microseconds since Jan 1, 1970 in the sec
   * and usec variables allocated by the caller. Return non-zero for success
   * and zero for failure.
   *)
  TS_time_cb = function({struct} v1: PTS_resp_ctx; v2: Pointer; sec: PIdC_LONG; usec: PIdC_LONG): TIdC_INT;

  (*
   * This must process the given extension. It can modify the TS_TST_INFO
   * object of the context. Return values: !0 (processed), 0 (error, it must
   * set the status info/failure info of the response).
   *)
  TS_extension_cb = function({struct} v1: PTS_resp_ctx; v2: PX509_Extension; v3: Pointer): TIdC_INT;

//  TS_VERIFY_CTX = TS_verify_ctx;
  TS_VERIFY_CTX = type Pointer;
  PTS_VERIFY_CTX = ^TS_VERIFY_CTX;

var
  function TS_REQ_new: PTS_REQ;
  procedure TS_REQ_free(a: PTS_REQ);
  function i2d_TS_REQ(a: PTS_REQ; pp: PPByte): TIdC_INT;
  function d2i_TS_REQ(a: PPTS_REQ; pp: PPByte; length: TIdC_LONG): PTS_REQ;

  function TS_REQ_dup(a: PTS_REQ): PTS_REQ;

  function d2i_TS_REQ_bio(fp: PBIO; a: PPTS_REQ): PTS_REQ;
  function i2d_TS_REQ_bio(fp: PBIO; a: PTS_REQ): TIdC_INT;

  function TS_MSG_IMPRINT_new: PTS_MSG_IMPRINT;
  procedure TS_MSG_IMPRINT_free(a: PTS_MSG_IMPRINT);
  function i2d_TS_MSG_IMPRINT(a: PTS_MSG_IMPRINT; pp: PPByte): TIdC_INT;
  function d2i_TS_MSG_IMPRINT(a: PPTS_MSG_IMPRINT; pp: PPByte; length: TIdC_LONG): PTS_MSG_IMPRINT;

  function TS_MSG_IMPRINT_dup(a: PTS_MSG_IMPRINT): PTS_MSG_IMPRINT;

  function d2i_TS_MSG_IMPRINT_bio(bio: PBIO; a: PPTS_MSG_IMPRINT): PTS_MSG_IMPRINT;
  function i2d_TS_MSG_IMPRINT_bio(bio: PBIO; a: PTS_MSG_IMPRINT): TIdC_INT;

  function TS_RESP_new: PTS_RESP;
  procedure TS_RESP_free(a: PTS_RESP);
  function i2d_TS_RESP(a: PTS_RESP; pp: PPByte): TIdC_INT;
  function d2i_TS_RESP(a: PPTS_RESP; pp: PPByte; length: TIdC_LONG): PTS_RESP;
  function PKCS7_to_TS_TST_INFO(token: PPKCS7): PTS_TST_Info;
  function TS_RESP_dup(a: PTS_RESP): PTS_RESP;

  function d2i_TS_RESP_bio(bio: PBIO; a: PPTS_RESP): PTS_RESP;
  function i2d_TS_RESP_bio(bio: PBIO; a: PTS_RESP): TIdC_INT;

  function TS_STATUS_INFO_new: PTS_STATUS_INFO;
  procedure TS_STATUS_INFO_free(a: PTS_STATUS_INFO);
  function i2d_TS_STATUS_INFO(a: PTS_STATUS_INFO; pp: PPByte): TIdC_INT;
  function d2i_TS_STATUS_INFO(a: PPTS_STATUS_INFO; pp: PPByte; length: TIdC_LONG): PTS_STATUS_INFO;
  function TS_STATUS_INFO_dup(a: PTS_STATUS_INFO): PTS_STATUS_INFO;

  function TS_TST_INFO_new: PTS_TST_Info;
  procedure TS_TST_INFO_free(a: PTS_TST_Info);
  function i2d_TS_TST_INFO(a: PTS_TST_Info; pp: PPByte): TIdC_INT;
  function d2i_TS_TST_INFO(a: PPTS_TST_Info; pp: PPByte; length: TIdC_LONG): PTS_TST_Info;
  function TS_TST_INFO_dup(a: PTS_TST_Info): PTS_TST_Info;

  function d2i_TS_TST_INFO_bio(bio: PBIO; a: PPTS_TST_Info): PTS_TST_Info;
  function i2d_TS_TST_INFO_bio(bio: PBIO; a: PTS_TST_Info): TIdC_INT;

  function TS_ACCURACY_new: PTS_ACCURACY;
  procedure TS_ACCURACY_free(a: PTS_ACCURACY);
  function i2d_TS_ACCURACY(a: PTS_ACCURACY; pp: PPByte): TIdC_INT;
  function d2i_TS_ACCURACY(a: PPTS_ACCURACY; pp: PPByte; length: TIdC_LONG): PTS_ACCURACY;
  function TS_ACCURACY_dup(a: PTS_ACCURACY): PTS_ACCURACY;

  function ESS_ISSUER_SERIAL_new: PESS_ISSUER_SERIAL;
  procedure ESS_ISSUER_SERIAL_free(a: PESS_ISSUER_SERIAL);
  function i2d_ESS_ISSUER_SERIAL( a: PESS_ISSUER_SERIAL; pp: PPByte): TIdC_INT;
  function d2i_ESS_ISSUER_SERIAL(a: PPESS_ISSUER_SERIAL; pp: PPByte; length: TIdC_LONG): PESS_ISSUER_SERIAL;
  function ESS_ISSUER_SERIAL_dup(a: PESS_ISSUER_SERIAL): PESS_ISSUER_SERIAL;

  function ESS_CERT_ID_new: PESS_CERT_ID;
  procedure ESS_CERT_ID_free(a: PESS_CERT_ID);
  function i2d_ESS_CERT_ID(a: PESS_CERT_ID; pp: PPByte): TIdC_INT;
  function d2i_ESS_CERT_ID(a: PPESS_CERT_ID; pp: PPByte; length: TIdC_LONG): PESS_CERT_ID;
  function ESS_CERT_ID_dup(a: PESS_CERT_ID): PESS_CERT_ID;

  function ESS_SIGNING_CERT_new: PESS_SIGNING_Cert;
  procedure ESS_SIGNING_CERT_free(a: PESS_SIGNING_Cert);
  function i2d_ESS_SIGNING_CERT( a: PESS_SIGNING_Cert; pp: PPByte): TIdC_INT;
  function d2i_ESS_SIGNING_CERT(a: PPESS_SIGNING_Cert; pp: PPByte; length: TIdC_LONG): PESS_SIGNING_Cert;
  function ESS_SIGNING_CERT_dup(a: PESS_SIGNING_Cert): PESS_SIGNING_Cert;

  function ESS_CERT_ID_V2_new: PESS_CERT_ID_V2;
  procedure ESS_CERT_ID_V2_free(a: PESS_CERT_ID_V2);
  function i2d_ESS_CERT_ID_V2( a: PESS_CERT_ID_V2; pp: PPByte): TIdC_INT;
  function d2i_ESS_CERT_ID_V2(a: PPESS_CERT_ID_V2; pp: PPByte; length: TIdC_LONG): PESS_CERT_ID_V2;
  function ESS_CERT_ID_V2_dup(a: PESS_CERT_ID_V2): PESS_CERT_ID_V2;

  function ESS_SIGNING_CERT_V2_new: PESS_SIGNING_CERT_V2;
  procedure ESS_SIGNING_CERT_V2_free(a: PESS_SIGNING_CERT_V2);
  function i2d_ESS_SIGNING_CERT_V2(a: PESS_SIGNING_CERT_V2; pp: PPByte): TIdC_INT;
  function d2i_ESS_SIGNING_CERT_V2(a: PPESS_SIGNING_CERT_V2; pp: PPByte; length: TIdC_LONG): PESS_SIGNING_CERT_V2;
  function ESS_SIGNING_CERT_V2_dup(a: PESS_SIGNING_CERT_V2): PESS_SIGNING_CERT_V2;

  function TS_REQ_set_version(a: PTS_REQ; version: TIdC_LONG): TIdC_INT;
  function TS_REQ_get_version(a: PTS_REQ): TIdC_LONG;

  function TS_STATUS_INFO_set_status(a: PTS_STATUS_INFO; i: TIdC_INT): TIdC_INT;
  function TS_STATUS_INFO_get0_status(const a: PTS_STATUS_INFO): PASN1_INTEGER;

  // const STACK_OF(ASN1_UTF8STRING) *TS_STATUS_INFO_get0_text(const TS_STATUS_INFO *a);

  // const ASN1_BIT_STRING *TS_STATUS_INFO_get0_failure_info(const TS_STATUS_INFO *a);

  function TS_REQ_set_msg_imprint(a: PTS_REQ; msg_imprint: PTS_MSG_IMPRINT): TIdC_INT;
  function TS_REQ_get_msg_imprint(a: PTS_REQ): PTS_MSG_IMPRINT;

  function TS_MSG_IMPRINT_set_algo(a: PTS_MSG_IMPRINT; alg: PX509_ALGOr): TIdC_INT;
  function TS_MSG_IMPRINT_get_algo(a: PTS_MSG_IMPRINT): PX509_ALGOr;

  function TS_MSG_IMPRINT_set_msg(a: PTS_MSG_IMPRINT; d: PByte; len: TIdC_INT): TIdC_INT;
  function TS_MSG_IMPRINT_get_msg(a: PTS_MSG_IMPRINT): PASN1_OCTET_STRING;

  function TS_REQ_set_policy_id(a: PTS_REQ; policy: PASN1_OBJECT): TIdC_INT;
  function TS_REQ_get_policy_id(a: PTS_REQ): PASN1_OBJECT;

  function TS_REQ_set_nonce(a: PTS_REQ; nonce: PASN1_INTEGER): TIdC_INT;
  function TS_REQ_get_nonce(const a: PTS_REQ): PASN1_INTEGER;

  function TS_REQ_set_cert_req(a: PTS_REQ; cert_req: TIdC_INT): TIdC_INT;
  function TS_REQ_get_cert_req(a: PTS_REQ): TIdC_INT;

  //STACK_OF(X509_EXTENSION) *TS_REQ_get_exts(TS_REQ *a);
  procedure TS_REQ_ext_free(a: PTS_REQ);
  function TS_REQ_get_ext_count(a: PTS_REQ): TIdC_INT;
  function TS_REQ_get_ext_by_NID(a: PTS_REQ; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function TS_REQ_get_ext_by_OBJ(a: PTS_REQ; obj: PASN1_Object; lastpos: TIdC_INT): TIdC_INT;
  function TS_REQ_get_ext_by_critical(a: PTS_REQ; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function TS_REQ_get_ext(a: PTS_REQ; loc: TIdC_INT): PX509_Extension;
  function TS_REQ_delete_ext(a: PTS_REQ; loc: TIdC_INT): PX509_Extension;
  function TS_REQ_add_ext(a: PTS_REQ; ex: PX509_Extension; loc: TIdC_INT): TIdC_INT;
  function TS_REQ_get_ext_d2i(a: PTS_REQ; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer;

  //* Function declarations for TS_REQ defined in ts/ts_req_print.c */

  function TS_REQ_print_bio(bio: PBIO; a: PTS_REQ): TIdC_INT;

  //* Function declarations for TS_RESP defined in ts/ts_resp_utils.c */

  function TS_RESP_set_status_info(a: PTS_RESP; info: PTS_STATUS_INFO): TIdC_INT;
  function TS_RESP_get_status_info(a: PTS_RESP): PTS_STATUS_INFO;

  //* Caller loses ownership of PKCS7 and TS_TST_INFO objects. */
  procedure TS_RESP_set_tst_info(a: PTS_RESP; p7: PPKCS7; tst_info: PTS_TST_Info);
  function TS_RESP_get_token(a: PTS_RESP): PPKCS7;
  function TS_RESP_get_tst_info(a: PTS_RESP): PTS_TST_Info;

  function TS_TST_INFO_set_version(a: PTS_TST_Info; version: TIdC_LONG): TIdC_INT;
  function TS_TST_INFO_get_version(const a: PTS_TST_Info): TIdC_LONG;

  function TS_TST_INFO_set_policy_id(a: PTS_TST_Info; policy_id: PASN1_Object): TIdC_INT;
  function TS_TST_INFO_get_policy_id(a: PTS_TST_Info): PASN1_Object;

  function TS_TST_INFO_set_msg_imprint(a: PTS_TST_Info; msg_imprint: PTS_MSG_IMPRINT): TIdC_INT;
  function TS_TST_INFO_get_msg_imprint(a: PTS_TST_Info): PTS_MSG_IMPRINT;

  function TS_TST_INFO_set_serial(a: PTS_TST_Info; const serial: PASN1_INTEGER): TIdC_INT;
  function TS_TST_INFO_get_serial(const a: PTS_TST_INFO): PASN1_INTEGER;

  function TS_TST_INFO_set_time(a: PTS_TST_Info; gtime: PASN1_GENERALIZEDTIME): TIdC_INT;
  function TS_TST_INFO_get_time(const a: PTS_TST_INFO): PASN1_GENERALIZEDTIME;

  function TS_TST_INFO_set_accuracy(a: PTS_TST_Info; accuracy: PTS_ACCURACY): TIdC_INT;
  function TS_TST_INFO_get_accuracy(a: PTS_TST_Info): PTS_ACCURACY;

  function TS_ACCURACY_set_seconds(a: PTS_ACCURACY; const seconds: PASN1_INTEGER): TIdC_INT;
  function TS_ACCURACY_get_seconds(const a: PTS_ACCURACY): PASN1_INTEGER;

  function TS_ACCURACY_set_millis(a: PTS_ACCURACY; const millis: PASN1_INTEGER): TIdC_INT;
  function TS_ACCURACY_get_millis(const a: PTS_ACCURACY): PASN1_INTEGER;

  function TS_ACCURACY_set_micros(a: PTS_ACCURACY; const micros: PASN1_INTEGER): TIdC_INT;
  function TS_ACCURACY_get_micros(const a: PTS_ACCURACY): PASN1_INTEGER;

  function TS_TST_INFO_set_ordering(a: PTS_TST_Info; ordering: TIdC_INT): TIdC_INT;
  function TS_TST_INFO_get_ordering(const a: PTS_TST_Info): TIdC_INT;

  function TS_TST_INFO_set_nonce(a: PTS_TST_Info; const nonce: PASN1_INTEGER): TIdC_INT;
  function TS_TST_INFO_get_nonce(const a: PTS_TST_INFO): PASN1_INTEGER;

  function TS_TST_INFO_set_tsa(a: PTS_TST_Info; tsa: PGENERAL_NAME): TIdC_INT;
  function TS_TST_INFO_get_tsa(a: PTS_TST_Info): PGENERAL_NAME;

  //STACK_OF(X509_EXTENSION) *TS_TST_INFO_get_exts(TS_TST_INFO *a);
  procedure TS_TST_INFO_ext_free(a: PTS_TST_Info);
  function TS_TST_INFO_get_ext_count(a: PTS_TST_Info): TIdC_INT;
  function TS_TST_INFO_get_ext_by_NID(a: PTS_TST_Info; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function TS_TST_INFO_get_ext_by_OBJ(a: PTS_TST_Info; const obj: PASN1_Object; lastpos: TIdC_INT): TIdC_INT;
  function TS_TST_INFO_get_ext_by_critical(a: PTS_TST_Info; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function TS_TST_INFO_get_ext(a: PTS_TST_Info; loc: TIdC_INT): PX509_Extension;
  function TS_TST_INFO_delete_ext(a: PTS_TST_Info; loc: TIdC_INT): PX509_Extension;
  function TS_TST_INFO_add_ext(a: PTS_TST_Info; ex: PX509_Extension; loc: TIdC_INT): TIdC_INT;
  function TS_TST_INFO_get_ext_d2i(a: PTS_TST_Info; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer;

  (*
   * Declarations related to response generation, defined in ts/ts_resp_sign.c.
   *)

  //DEFINE_STACK_OF_CONST(EVP_MD)

  (* Creates a response context that can be used for generating responses. *)
  function TS_RESP_CTX_new: PTS_RESP_CTX;
  procedure TS_RESP_CTX_free(ctx: PTS_RESP_CTX);

  (* This parameter must be set. *)
  function TS_RESP_CTX_set_signer_cert(ctx: PTS_RESP_CTX; signer: PX509): TIdC_INT;

  (* This parameter must be set. *)
  function TS_RESP_CTX_set_signer_key(ctx: PTS_RESP_CTX; key: PEVP_PKEY): TIdC_INT;

  function TS_RESP_CTX_set_signer_digest(ctx: PTS_RESP_CTX; signer_digest: PEVP_MD): TIdC_INT;
  function TS_RESP_CTX_set_ess_cert_id_digest(ctx: PTS_RESP_CTX; md: PEVP_MD): TIdC_INT;

  (* This parameter must be set. *)
  function TS_RESP_CTX_set_def_policy(ctx: PTS_RESP_CTX; def_policy: PASN1_Object): TIdC_INT;

  (* No additional certs are included in the response by default. *)
  // int TS_RESP_CTX_set_certs(TS_RESP_CTX *ctx, STACK_OF(X509) *certs);

  (*
   * Adds a new acceptable policy, only the default policy is accepted by
   * default.
   *)
  function TS_RESP_CTX_add_policy(ctx: PTS_RESP_CTX; const policy: PASN1_Object): TIdC_INT;

  (*
   * Adds a new acceptable message digest. Note that no message digests are
   * accepted by default. The md argument is shared with the caller.
   *)
  function TS_RESP_CTX_add_md(ctx: PTS_RESP_CTX; const md: PEVP_MD): TIdC_INT;

  (* Accuracy is not included by default. *)
  function TS_RESP_CTX_set_accuracy(ctx: PTS_RESP_CTX; secs: TIdC_INT; millis: TIdC_INT; micros: TIdC_INT): TIdC_INT;

  (*
   * Clock precision digits, i.e. the number of decimal digits: '0' means sec,
   * '3' msec, '6' usec, and so on. Default is 0.
   *)
  function TS_RESP_CTX_set_clock_precision_digits(ctx: PTS_RESP_CTX; clock_precision_digits: TIdC_UINT): TIdC_INT;

  (* No flags are set by default. *)
  procedure TS_RESP_CTX_add_flags(ctx: PTS_RESP_CTX; flags: TIdC_INT);

  (* Default callback always returns a constant. *)
  procedure TS_RESP_CTX_set_serial_cb(ctx: PTS_RESP_CTX; cb: TS_serial_cb; data: Pointer);

  (* Default callback uses the gettimeofday() and gmtime() system calls. *)
  procedure TS_RESP_CTX_set_time_cb(ctx: PTS_RESP_CTX; cb: TS_time_cb; data: Pointer);

  (*
   * Default callback rejects all extensions. The extension callback is called
   * when the TS_TST_INFO object is already set up and not signed yet.
   *)
  (* FIXME: extension handling is not tested yet. *)
  procedure TS_RESP_CTX_set_extension_cb(ctx: PTS_RESP_CTX; cb: TS_extension_cb; data: Pointer);

  (* The following methods can be used in the callbacks. *)
  function TS_RESP_CTX_set_status_info(ctx: PTS_RESP_CTX; status: TIdC_INT; text: PIdAnsiChar): TIdC_INT;

  (* Sets the status info only if it is still TS_STATUS_GRANTED. *)
  function TS_RESP_CTX_set_status_info_cond(ctx: PTS_RESP_CTX; status: TIdC_INT; text: PIdAnsiChar): TIdC_INT;

  function TS_RESP_CTX_add_failure_info(ctx: PTS_RESP_CTX; failure: TIdC_INT): TIdC_INT;

  (* The get methods below can be used in the extension callback. *)
  function TS_RESP_CTX_get_request(ctx: PTS_RESP_CTX): PTS_REQ;

  function TS_RESP_CTX_get_tst_info(ctx: PTS_RESP_CTX): PTS_TST_Info;

  (*
   * Creates the signed TS_TST_INFO and puts it in TS_RESP.
   * In case of errors it sets the status info properly.
   * Returns NULL only in case of memory allocation/fatal error.
   *)
  function TS_RESP_create_response(ctx: PTS_RESP_CTX; req_bio: PBIO): PTS_RESP;

  (*
   * Declarations related to response verification,
   * they are defined in ts/ts_resp_verify.c.
   *)

  //int TS_RESP_verify_signature(PKCS7 *token, STACK_OF(X509) *certs,
  //                             X509_STORE *store, X509 **signer_out);

  (* Context structure for the generic verify method. *)

  function TS_RESP_verify_response(ctx: PTS_VERIFY_CTX; response: PTS_RESP): TIdC_INT;
  function TS_RESP_verify_token(ctx: PTS_VERIFY_CTX; token: PPKCS7): TIdC_INT;

  (*
   * Declarations related to response verification context,
   *)
  function TS_VERIFY_CTX_new: PTS_VERIFY_CTX;
  procedure TS_VERIFY_CTX_init(ctx: PTS_VERIFY_CTX);
  procedure TS_VERIFY_CTX_free(ctx: PTS_VERIFY_CTX);
  procedure TS_VERIFY_CTX_cleanup(ctx: PTS_VERIFY_CTX);
  function TS_VERIFY_CTX_set_flags(ctx: PTS_VERIFY_CTX; f: TIdC_INT): TIdC_INT;
  function TS_VERIFY_CTX_add_flags(ctx: PTS_VERIFY_CTX; f: TIdC_INT): TIdC_INT;
  function TS_VERIFY_CTX_set_data(ctx: PTS_VERIFY_CTX; b: PBIO): PBIO;
  function TS_VERIFY_CTX_set_imprint(ctx: PTS_VERIFY_CTX; hexstr: PByte; len: TIdC_LONG): PByte;
  function TS_VERIFY_CTX_set_store(ctx: PTS_VERIFY_CTX; s: PX509_Store): PX509_Store;
  // STACK_OF(X509) *TS_VERIFY_CTS_set_certs(TS_VERIFY_CTX *ctx, STACK_OF(X509) *certs);

  (*-
   * If ctx is NULL, it allocates and returns a new object, otherwise
   * it returns ctx. It initialises all the members as follows:
   * flags = TS_VFY_ALL_IMPRINT & ~(TS_VFY_TSA_NAME | TS_VFY_SIGNATURE)
   * certs = NULL
   * store = NULL
   * policy = policy from the request or NULL if absent (in this case
   *      TS_VFY_POLICY is cleared from flags as well)
   * md_alg = MD algorithm from request
   * imprint, imprint_len = imprint from request
   * data = NULL
   * nonce, nonce_len = nonce from the request or NULL if absent (in this case
   *      TS_VFY_NONCE is cleared from flags as well)
   * tsa_name = NULL
   * Important: after calling this method TS_VFY_SIGNATURE should be added!
   *)
  function TS_REQ_to_TS_VERIFY_CTX(req: PTS_REQ; ctx: PTS_VERIFY_CTX): PTS_VERIFY_CTX;

  (* Function declarations for TS_RESP defined in ts/ts_resp_print.c *)

  function TS_RESP_print_bio(bio: PBIO; a: PTS_RESP): TIdC_INT;
  function TS_STATUS_INFO_print_bio(bio: PBIO; a: PTS_STATUS_INFO): TIdC_INT;
  function TS_TST_INFO_print_bio(bio: PBIO; a: PTS_TST_Info): TIdC_INT;

  (* Common utility functions defined in ts/ts_lib.c *)

  function TS_ASN1_INTEGER_print_bio(bio: PBIO; const num: PASN1_INTEGER): TIdC_INT;
  function TS_OBJ_print_bio(bio: PBIO; const obj: PASN1_Object): TIdC_INT;
  //function TS_ext_print_bio(bio: PBIO; const STACK_OF(): X509_Extension * extensions): TIdC_INT;
  function TS_X509_ALGOR_print_bio(bio: PBIO; const alg: PX509_ALGOr): TIdC_INT;
  function TS_MSG_IMPRINT_print_bio(bio: PBIO; msg: PTS_MSG_IMPRINT): TIdC_INT;

  (*
   * Function declarations for handling configuration options, defined in
   * ts/ts_conf.c
   *)

  function TS_CONF_load_cert(&file: PIdAnsiChar): PX509;
  function TS_CONF_load_key( file_: PIdAnsiChar; pass: PIdAnsiChar): PEVP_PKey;
  function TS_CONF_set_serial(conf: PCONF; section: PIdAnsiChar; cb: TS_serial_cb; ctx: PTS_RESP_CTX): TIdC_INT;
  //STACK_OF(X509) *TS_CONF_load_certs(const char *file);
  function TS_CONF_get_tsa_section(conf: PCONF; const section: PIdAnsiChar): PIdAnsiChar;
  function TS_CONF_set_crypto_device(conf: PCONF; section: PIdAnsiChar; device: PIdAnsiChar): TIdC_INT;
  function TS_CONF_set_default_engine(name: PIdAnsiChar): TIdC_INT;
  function TS_CONF_set_signer_cert(conf: PCONF; section: PIdAnsiChar; cert: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_certs(conf: PCONF; section: PIdAnsiChar; certs: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_signer_key(conf: PCONF; const section: PIdAnsiChar; key: PIdAnsiChar; pass: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_signer_digest(conf: PCONF; section: PIdAnsiChar; md: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_def_policy(conf: PCONF; section: PIdAnsiChar; policy: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_policies(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_digests(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_accuracy(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_clock_precision_digits(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_ordering(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_tsa_name(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_ess_cert_id_chain(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;
  function TS_CONF_set_ess_cert_id_digest(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT;

implementation

end.
