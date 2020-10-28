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

unit IdOpenSSLHeaders_ts;

interface

// Headers for OpenSSL 1.1.1
// ts.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  TS_REQ_new: function: PTS_REQ cdecl = nil;
  TS_REQ_free: procedure(a: PTS_REQ) cdecl = nil;
  i2d_TS_REQ: function(a: PTS_REQ; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_REQ: function(a: PPTS_REQ; pp: PPByte; length: TIdC_LONG): PTS_REQ cdecl = nil;

  TS_REQ_dup: function(a: PTS_REQ): PTS_REQ cdecl = nil;

  d2i_TS_REQ_bio: function(fp: PBIO; a: PPTS_REQ): PTS_REQ cdecl = nil;
  i2d_TS_REQ_bio: function(fp: PBIO; a: PTS_REQ): TIdC_INT cdecl = nil;

  TS_MSG_IMPRINT_new: function: PTS_MSG_IMPRINT cdecl = nil;
  TS_MSG_IMPRINT_free: procedure(a: PTS_MSG_IMPRINT) cdecl = nil;
  i2d_TS_MSG_IMPRINT: function(a: PTS_MSG_IMPRINT; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_MSG_IMPRINT: function(a: PPTS_MSG_IMPRINT; pp: PPByte; length: TIdC_LONG): PTS_MSG_IMPRINT cdecl = nil;

  TS_MSG_IMPRINT_dup: function(a: PTS_MSG_IMPRINT): PTS_MSG_IMPRINT cdecl = nil;

  d2i_TS_MSG_IMPRINT_bio: function(bio: PBIO; a: PPTS_MSG_IMPRINT): PTS_MSG_IMPRINT cdecl = nil;
  i2d_TS_MSG_IMPRINT_bio: function(bio: PBIO; a: PTS_MSG_IMPRINT): TIdC_INT cdecl = nil;

  TS_RESP_new: function: PTS_RESP cdecl = nil;
  TS_RESP_free: procedure(a: PTS_RESP) cdecl = nil;
  i2d_TS_RESP: function(a: PTS_RESP; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_RESP: function(a: PPTS_RESP; pp: PPByte; length: TIdC_LONG): PTS_RESP cdecl = nil;
  PKCS7_to_TS_TST_INFO: function(token: PPKCS7): PTS_TST_Info cdecl = nil;
  TS_RESP_dup: function(a: PTS_RESP): PTS_RESP cdecl = nil;

  d2i_TS_RESP_bio: function(bio: PBIO; a: PPTS_RESP): PTS_RESP cdecl = nil;
  i2d_TS_RESP_bio: function(bio: PBIO; a: PTS_RESP): TIdC_INT cdecl = nil;

  TS_STATUS_INFO_new: function: PTS_STATUS_INFO cdecl = nil;
  TS_STATUS_INFO_free: procedure(a: PTS_STATUS_INFO) cdecl = nil;
  i2d_TS_STATUS_INFO: function(a: PTS_STATUS_INFO; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_STATUS_INFO: function(a: PPTS_STATUS_INFO; pp: PPByte; length: TIdC_LONG): PTS_STATUS_INFO cdecl = nil;
  TS_STATUS_INFO_dup: function(a: PTS_STATUS_INFO): PTS_STATUS_INFO cdecl = nil;

  TS_TST_INFO_new: function: PTS_TST_Info cdecl = nil;
  TS_TST_INFO_free: procedure(a: PTS_TST_Info) cdecl = nil;
  i2d_TS_TST_INFO: function(a: PTS_TST_Info; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_TST_INFO: function(a: PPTS_TST_Info; pp: PPByte; length: TIdC_LONG): PTS_TST_Info cdecl = nil;
  TS_TST_INFO_dup: function(a: PTS_TST_Info): PTS_TST_Info cdecl = nil;

  d2i_TS_TST_INFO_bio: function(bio: PBIO; a: PPTS_TST_Info): PTS_TST_Info cdecl = nil;
  i2d_TS_TST_INFO_bio: function(bio: PBIO; a: PTS_TST_Info): TIdC_INT cdecl = nil;

  TS_ACCURACY_new: function: PTS_ACCURACY cdecl = nil;
  TS_ACCURACY_free: procedure(a: PTS_ACCURACY) cdecl = nil;
  i2d_TS_ACCURACY: function(a: PTS_ACCURACY; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_TS_ACCURACY: function(a: PPTS_ACCURACY; pp: PPByte; length: TIdC_LONG): PTS_ACCURACY cdecl = nil;
  TS_ACCURACY_dup: function(a: PTS_ACCURACY): PTS_ACCURACY cdecl = nil;

  ESS_ISSUER_SERIAL_new: function: PESS_ISSUER_SERIAL cdecl = nil;
  ESS_ISSUER_SERIAL_free: procedure(a: PESS_ISSUER_SERIAL) cdecl = nil;
  i2d_ESS_ISSUER_SERIAL: function( a: PESS_ISSUER_SERIAL; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ESS_ISSUER_SERIAL: function(a: PPESS_ISSUER_SERIAL; pp: PPByte; length: TIdC_LONG): PESS_ISSUER_SERIAL cdecl = nil;
  ESS_ISSUER_SERIAL_dup: function(a: PESS_ISSUER_SERIAL): PESS_ISSUER_SERIAL cdecl = nil;

  ESS_CERT_ID_new: function: PESS_CERT_ID cdecl = nil;
  ESS_CERT_ID_free: procedure(a: PESS_CERT_ID) cdecl = nil;
  i2d_ESS_CERT_ID: function(a: PESS_CERT_ID; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ESS_CERT_ID: function(a: PPESS_CERT_ID; pp: PPByte; length: TIdC_LONG): PESS_CERT_ID cdecl = nil;
  ESS_CERT_ID_dup: function(a: PESS_CERT_ID): PESS_CERT_ID cdecl = nil;

  ESS_SIGNING_CERT_new: function: PESS_SIGNING_Cert cdecl = nil;
  ESS_SIGNING_CERT_free: procedure(a: PESS_SIGNING_Cert) cdecl = nil;
  i2d_ESS_SIGNING_CERT: function( a: PESS_SIGNING_Cert; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ESS_SIGNING_CERT: function(a: PPESS_SIGNING_Cert; pp: PPByte; length: TIdC_LONG): PESS_SIGNING_Cert cdecl = nil;
  ESS_SIGNING_CERT_dup: function(a: PESS_SIGNING_Cert): PESS_SIGNING_Cert cdecl = nil;

  ESS_CERT_ID_V2_new: function: PESS_CERT_ID_V2 cdecl = nil;
  ESS_CERT_ID_V2_free: procedure(a: PESS_CERT_ID_V2) cdecl = nil;
  i2d_ESS_CERT_ID_V2: function( a: PESS_CERT_ID_V2; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ESS_CERT_ID_V2: function(a: PPESS_CERT_ID_V2; pp: PPByte; length: TIdC_LONG): PESS_CERT_ID_V2 cdecl = nil;
  ESS_CERT_ID_V2_dup: function(a: PESS_CERT_ID_V2): PESS_CERT_ID_V2 cdecl = nil;

  ESS_SIGNING_CERT_V2_new: function: PESS_SIGNING_CERT_V2 cdecl = nil;
  ESS_SIGNING_CERT_V2_free: procedure(a: PESS_SIGNING_CERT_V2) cdecl = nil;
  i2d_ESS_SIGNING_CERT_V2: function(a: PESS_SIGNING_CERT_V2; pp: PPByte): TIdC_INT cdecl = nil;
  d2i_ESS_SIGNING_CERT_V2: function(a: PPESS_SIGNING_CERT_V2; pp: PPByte; length: TIdC_LONG): PESS_SIGNING_CERT_V2 cdecl = nil;
  ESS_SIGNING_CERT_V2_dup: function(a: PESS_SIGNING_CERT_V2): PESS_SIGNING_CERT_V2 cdecl = nil;

  TS_REQ_set_version: function(a: PTS_REQ; version: TIdC_LONG): TIdC_INT cdecl = nil;
  TS_REQ_get_version: function(a: PTS_REQ): TIdC_LONG cdecl = nil;

  TS_STATUS_INFO_set_status: function(a: PTS_STATUS_INFO; i: TIdC_INT): TIdC_INT cdecl = nil;
  TS_STATUS_INFO_get0_status: function(const a: PTS_STATUS_INFO): PASN1_INTEGER cdecl = nil;

  // const STACK_OF(ASN1_UTF8STRING) *TS_STATUS_INFO_get0_text(const TS_STATUS_INFO *a);

  // const ASN1_BIT_STRING *TS_STATUS_INFO_get0_failure_info(const TS_STATUS_INFO *a);

  TS_REQ_set_msg_imprint: function(a: PTS_REQ; msg_imprint: PTS_MSG_IMPRINT): TIdC_INT cdecl = nil;
  TS_REQ_get_msg_imprint: function(a: PTS_REQ): PTS_MSG_IMPRINT cdecl = nil;

  TS_MSG_IMPRINT_set_algo: function(a: PTS_MSG_IMPRINT; alg: PX509_ALGOr): TIdC_INT cdecl = nil;
  TS_MSG_IMPRINT_get_algo: function(a: PTS_MSG_IMPRINT): PX509_ALGOr cdecl = nil;

  TS_MSG_IMPRINT_set_msg: function(a: PTS_MSG_IMPRINT; d: PByte; len: TIdC_INT): TIdC_INT cdecl = nil;
  TS_MSG_IMPRINT_get_msg: function(a: PTS_MSG_IMPRINT): PASN1_OCTET_STRING cdecl = nil;

  TS_REQ_set_policy_id: function(a: PTS_REQ; policy: PASN1_OBJECT): TIdC_INT cdecl = nil;
  TS_REQ_get_policy_id: function(a: PTS_REQ): PASN1_OBJECT cdecl = nil;

  TS_REQ_set_nonce: function(a: PTS_REQ; nonce: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_REQ_get_nonce: function(const a: PTS_REQ): PASN1_INTEGER cdecl = nil;

  TS_REQ_set_cert_req: function(a: PTS_REQ; cert_req: TIdC_INT): TIdC_INT cdecl = nil;
  TS_REQ_get_cert_req: function(a: PTS_REQ): TIdC_INT cdecl = nil;

  //STACK_OF(X509_EXTENSION) *TS_REQ_get_exts(TS_REQ *a);
  TS_REQ_ext_free: procedure(a: PTS_REQ) cdecl = nil;
  TS_REQ_get_ext_count: function(a: PTS_REQ): TIdC_INT cdecl = nil;
  TS_REQ_get_ext_by_NID: function(a: PTS_REQ; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_REQ_get_ext_by_OBJ: function(a: PTS_REQ; obj: PASN1_Object; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_REQ_get_ext_by_critical: function(a: PTS_REQ; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_REQ_get_ext: function(a: PTS_REQ; loc: TIdC_INT): PX509_Extension cdecl = nil;
  TS_REQ_delete_ext: function(a: PTS_REQ; loc: TIdC_INT): PX509_Extension cdecl = nil;
  TS_REQ_add_ext: function(a: PTS_REQ; ex: PX509_Extension; loc: TIdC_INT): TIdC_INT cdecl = nil;
  TS_REQ_get_ext_d2i: function(a: PTS_REQ; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl = nil;

  //* Function declarations for TS_REQ defined in ts/ts_req_print.c */

  TS_REQ_print_bio: function(bio: PBIO; a: PTS_REQ): TIdC_INT cdecl = nil;

  //* Function declarations for TS_RESP defined in ts/ts_resp_utils.c */

  TS_RESP_set_status_info: function(a: PTS_RESP; info: PTS_STATUS_INFO): TIdC_INT cdecl = nil;
  TS_RESP_get_status_info: function(a: PTS_RESP): PTS_STATUS_INFO cdecl = nil;

  //* Caller loses ownership of PKCS7 and TS_TST_INFO objects. */
  TS_RESP_set_tst_info: procedure(a: PTS_RESP; p7: PPKCS7; tst_info: PTS_TST_Info) cdecl = nil;
  TS_RESP_get_token: function(a: PTS_RESP): PPKCS7 cdecl = nil;
  TS_RESP_get_tst_info: function(a: PTS_RESP): PTS_TST_Info cdecl = nil;

  TS_TST_INFO_set_version: function(a: PTS_TST_Info; version: TIdC_LONG): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_version: function(const a: PTS_TST_Info): TIdC_LONG cdecl = nil;

  TS_TST_INFO_set_policy_id: function(a: PTS_TST_Info; policy_id: PASN1_Object): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_policy_id: function(a: PTS_TST_Info): PASN1_Object cdecl = nil;

  TS_TST_INFO_set_msg_imprint: function(a: PTS_TST_Info; msg_imprint: PTS_MSG_IMPRINT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_msg_imprint: function(a: PTS_TST_Info): PTS_MSG_IMPRINT cdecl = nil;

  TS_TST_INFO_set_serial: function(a: PTS_TST_Info; const serial: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_serial: function(const a: PTS_TST_INFO): PASN1_INTEGER cdecl = nil;

  TS_TST_INFO_set_time: function(a: PTS_TST_Info; gtime: PASN1_GENERALIZEDTIME): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_time: function(const a: PTS_TST_INFO): PASN1_GENERALIZEDTIME cdecl = nil;

  TS_TST_INFO_set_accuracy: function(a: PTS_TST_Info; accuracy: PTS_ACCURACY): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_accuracy: function(a: PTS_TST_Info): PTS_ACCURACY cdecl = nil;

  TS_ACCURACY_set_seconds: function(a: PTS_ACCURACY; const seconds: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_ACCURACY_get_seconds: function(const a: PTS_ACCURACY): PASN1_INTEGER cdecl = nil;

  TS_ACCURACY_set_millis: function(a: PTS_ACCURACY; const millis: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_ACCURACY_get_millis: function(const a: PTS_ACCURACY): PASN1_INTEGER cdecl = nil;

  TS_ACCURACY_set_micros: function(a: PTS_ACCURACY; const micros: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_ACCURACY_get_micros: function(const a: PTS_ACCURACY): PASN1_INTEGER cdecl = nil;

  TS_TST_INFO_set_ordering: function(a: PTS_TST_Info; ordering: TIdC_INT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ordering: function(const a: PTS_TST_Info): TIdC_INT cdecl = nil;

  TS_TST_INFO_set_nonce: function(a: PTS_TST_Info; const nonce: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_nonce: function(const a: PTS_TST_INFO): PASN1_INTEGER cdecl = nil;

  TS_TST_INFO_set_tsa: function(a: PTS_TST_Info; tsa: PGENERAL_NAME): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_tsa: function(a: PTS_TST_Info): PGENERAL_NAME cdecl = nil;

  //STACK_OF(X509_EXTENSION) *TS_TST_INFO_get_exts(TS_TST_INFO *a);
  TS_TST_INFO_ext_free: procedure(a: PTS_TST_Info) cdecl = nil;
  TS_TST_INFO_get_ext_count: function(a: PTS_TST_Info): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ext_by_NID: function(a: PTS_TST_Info; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ext_by_OBJ: function(a: PTS_TST_Info; const obj: PASN1_Object; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ext_by_critical: function(a: PTS_TST_Info; crit: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ext: function(a: PTS_TST_Info; loc: TIdC_INT): PX509_Extension cdecl = nil;
  TS_TST_INFO_delete_ext: function(a: PTS_TST_Info; loc: TIdC_INT): PX509_Extension cdecl = nil;
  TS_TST_INFO_add_ext: function(a: PTS_TST_Info; ex: PX509_Extension; loc: TIdC_INT): TIdC_INT cdecl = nil;
  TS_TST_INFO_get_ext_d2i: function(a: PTS_TST_Info; nid: TIdC_INT; crit: PIdC_INT; idx: PIdC_INT): Pointer cdecl = nil;

  (*
   * Declarations related to response generation, defined in ts/ts_resp_sign.c.
   *)

  //DEFINE_STACK_OF_CONST(EVP_MD)

  (* Creates a response context that can be used for generating responses. *)
  TS_RESP_CTX_new: function: PTS_RESP_CTX cdecl = nil;
  TS_RESP_CTX_free: procedure(ctx: PTS_RESP_CTX) cdecl = nil;

  (* This parameter must be set. *)
  TS_RESP_CTX_set_signer_cert: function(ctx: PTS_RESP_CTX; signer: PX509): TIdC_INT cdecl = nil;

  (* This parameter must be set. *)
  TS_RESP_CTX_set_signer_key: function(ctx: PTS_RESP_CTX; key: PEVP_PKEY): TIdC_INT cdecl = nil;

  TS_RESP_CTX_set_signer_digest: function(ctx: PTS_RESP_CTX; signer_digest: PEVP_MD): TIdC_INT cdecl = nil;
  TS_RESP_CTX_set_ess_cert_id_digest: function(ctx: PTS_RESP_CTX; md: PEVP_MD): TIdC_INT cdecl = nil;

  (* This parameter must be set. *)
  TS_RESP_CTX_set_def_policy: function(ctx: PTS_RESP_CTX; def_policy: PASN1_Object): TIdC_INT cdecl = nil;

  (* No additional certs are included in the response by default. *)
  // int TS_RESP_CTX_set_certs(TS_RESP_CTX *ctx, STACK_OF(X509) *certs);

  (*
   * Adds a new acceptable policy, only the default policy is accepted by
   * default.
   *)
  TS_RESP_CTX_add_policy: function(ctx: PTS_RESP_CTX; const policy: PASN1_Object): TIdC_INT cdecl = nil;

  (*
   * Adds a new acceptable message digest. Note that no message digests are
   * accepted by default. The md argument is shared with the caller.
   *)
  TS_RESP_CTX_add_md: function(ctx: PTS_RESP_CTX; const md: PEVP_MD): TIdC_INT cdecl = nil;

  (* Accuracy is not included by default. *)
  TS_RESP_CTX_set_accuracy: function(ctx: PTS_RESP_CTX; secs: TIdC_INT; millis: TIdC_INT; micros: TIdC_INT): TIdC_INT cdecl = nil;

  (*
   * Clock precision digits, i.e. the number of decimal digits: '0' means sec,
   * '3' msec, '6' usec, and so on. Default is 0.
   *)
  TS_RESP_CTX_set_clock_precision_digits: function(ctx: PTS_RESP_CTX; clock_precision_digits: TIdC_UINT): TIdC_INT cdecl = nil;

  (* No flags are set by default. *)
  TS_RESP_CTX_add_flags: procedure(ctx: PTS_RESP_CTX; flags: TIdC_INT) cdecl = nil;

  (* Default callback always returns a constant. *)
  TS_RESP_CTX_set_serial_cb: procedure(ctx: PTS_RESP_CTX; cb: TS_serial_cb; data: Pointer) cdecl = nil;

  (* Default callback uses the gettimeofday() and gmtime() system calls. *)
  TS_RESP_CTX_set_time_cb: procedure(ctx: PTS_RESP_CTX; cb: TS_time_cb; data: Pointer) cdecl = nil;

  (*
   * Default callback rejects all extensions. The extension callback is called
   * when the TS_TST_INFO object is already set up and not signed yet.
   *)
  (* FIXME: extension handling is not tested yet. *)
  TS_RESP_CTX_set_extension_cb: procedure(ctx: PTS_RESP_CTX; cb: TS_extension_cb; data: Pointer) cdecl = nil;

  (* The following methods can be used in the callbacks. *)
  TS_RESP_CTX_set_status_info: function(ctx: PTS_RESP_CTX; status: TIdC_INT; text: PIdAnsiChar): TIdC_INT cdecl = nil;

  (* Sets the status info only if it is still TS_STATUS_GRANTED. *)
  TS_RESP_CTX_set_status_info_cond: function(ctx: PTS_RESP_CTX; status: TIdC_INT; text: PIdAnsiChar): TIdC_INT cdecl = nil;

  TS_RESP_CTX_add_failure_info: function(ctx: PTS_RESP_CTX; failure: TIdC_INT): TIdC_INT cdecl = nil;

  (* The get methods below can be used in the extension callback. *)
  TS_RESP_CTX_get_request: function(ctx: PTS_RESP_CTX): PTS_REQ cdecl = nil;

  TS_RESP_CTX_get_tst_info: function(ctx: PTS_RESP_CTX): PTS_TST_Info cdecl = nil;

  (*
   * Creates the signed TS_TST_INFO and puts it in TS_RESP.
   * In case of errors it sets the status info properly.
   * Returns NULL only in case of memory allocation/fatal error.
   *)
  TS_RESP_create_response: function(ctx: PTS_RESP_CTX; req_bio: PBIO): PTS_RESP cdecl = nil;

  (*
   * Declarations related to response verification,
   * they are defined in ts/ts_resp_verify.c.
   *)

  //int TS_RESP_verify_signature(PKCS7 *token, STACK_OF(X509) *certs,
  //                             X509_STORE *store, X509 **signer_out);

  (* Context structure for the generic verify method. *)

  TS_RESP_verify_response: function(ctx: PTS_VERIFY_CTX; response: PTS_RESP): TIdC_INT cdecl = nil;
  TS_RESP_verify_token: function(ctx: PTS_VERIFY_CTX; token: PPKCS7): TIdC_INT cdecl = nil;

  (*
   * Declarations related to response verification context,
   *)
  TS_VERIFY_CTX_new: function: PTS_VERIFY_CTX cdecl = nil;
  TS_VERIFY_CTX_init: procedure(ctx: PTS_VERIFY_CTX) cdecl = nil;
  TS_VERIFY_CTX_free: procedure(ctx: PTS_VERIFY_CTX) cdecl = nil;
  TS_VERIFY_CTX_cleanup: procedure(ctx: PTS_VERIFY_CTX) cdecl = nil;
  TS_VERIFY_CTX_set_flags: function(ctx: PTS_VERIFY_CTX; f: TIdC_INT): TIdC_INT cdecl = nil;
  TS_VERIFY_CTX_add_flags: function(ctx: PTS_VERIFY_CTX; f: TIdC_INT): TIdC_INT cdecl = nil;
  TS_VERIFY_CTX_set_data: function(ctx: PTS_VERIFY_CTX; b: PBIO): PBIO cdecl = nil;
  TS_VERIFY_CTX_set_imprint: function(ctx: PTS_VERIFY_CTX; hexstr: PByte; len: TIdC_LONG): PByte cdecl = nil;
  TS_VERIFY_CTX_set_store: function(ctx: PTS_VERIFY_CTX; s: PX509_Store): PX509_Store cdecl = nil;
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
  TS_REQ_to_TS_VERIFY_CTX: function(req: PTS_REQ; ctx: PTS_VERIFY_CTX): PTS_VERIFY_CTX cdecl = nil;

  (* Function declarations for TS_RESP defined in ts/ts_resp_print.c *)

  TS_RESP_print_bio: function(bio: PBIO; a: PTS_RESP): TIdC_INT cdecl = nil;
  TS_STATUS_INFO_print_bio: function(bio: PBIO; a: PTS_STATUS_INFO): TIdC_INT cdecl = nil;
  TS_TST_INFO_print_bio: function(bio: PBIO; a: PTS_TST_Info): TIdC_INT cdecl = nil;

  (* Common utility functions defined in ts/ts_lib.c *)

  TS_ASN1_INTEGER_print_bio: function(bio: PBIO; const num: PASN1_INTEGER): TIdC_INT cdecl = nil;
  TS_OBJ_print_bio: function(bio: PBIO; const obj: PASN1_Object): TIdC_INT cdecl = nil;
  //function TS_ext_print_bio(bio: PBIO; const STACK_OF(): X509_Extension * extensions): TIdC_INT;
  TS_X509_ALGOR_print_bio: function(bio: PBIO; const alg: PX509_ALGOr): TIdC_INT cdecl = nil;
  TS_MSG_IMPRINT_print_bio: function(bio: PBIO; msg: PTS_MSG_IMPRINT): TIdC_INT cdecl = nil;

  (*
   * Function declarations for handling configuration options, defined in
   * ts/ts_conf.c
   *)

  TS_CONF_load_cert: function(&file: PIdAnsiChar): PX509 cdecl = nil;
  TS_CONF_load_key: function( file_: PIdAnsiChar; pass: PIdAnsiChar): PEVP_PKey cdecl = nil;
  TS_CONF_set_serial: function(conf: PCONF; section: PIdAnsiChar; cb: TS_serial_cb; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  //STACK_OF(X509) *TS_CONF_load_certs(const char *file);
  TS_CONF_get_tsa_section: function(conf: PCONF; const section: PIdAnsiChar): PIdAnsiChar cdecl = nil;
  TS_CONF_set_crypto_device: function(conf: PCONF; section: PIdAnsiChar; device: PIdAnsiChar): TIdC_INT cdecl = nil;
  TS_CONF_set_default_engine: function(name: PIdAnsiChar): TIdC_INT cdecl = nil;
  TS_CONF_set_signer_cert: function(conf: PCONF; section: PIdAnsiChar; cert: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_certs: function(conf: PCONF; section: PIdAnsiChar; certs: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_signer_key: function(conf: PCONF; const section: PIdAnsiChar; key: PIdAnsiChar; pass: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_signer_digest: function(conf: PCONF; section: PIdAnsiChar; md: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_def_policy: function(conf: PCONF; section: PIdAnsiChar; policy: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_policies: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_digests: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_accuracy: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_clock_precision_digits: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_ordering: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_tsa_name: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_ess_cert_id_chain: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;
  TS_CONF_set_ess_cert_id_digest: function(conf: PCONF; section: PIdAnsiChar; ctx: PTS_RESP_CTX): TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  TS_REQ_new := LoadFunction('TS_REQ_new', AFailed);
  TS_REQ_free := LoadFunction('TS_REQ_free', AFailed);
  i2d_TS_REQ := LoadFunction('i2d_TS_REQ', AFailed);
  d2i_TS_REQ := LoadFunction('d2i_TS_REQ', AFailed);
  TS_REQ_dup := LoadFunction('TS_REQ_dup', AFailed);
  d2i_TS_REQ_bio := LoadFunction('d2i_TS_REQ_bio', AFailed);
  i2d_TS_REQ_bio := LoadFunction('i2d_TS_REQ_bio', AFailed);
  TS_MSG_IMPRINT_new := LoadFunction('TS_MSG_IMPRINT_new', AFailed);
  TS_MSG_IMPRINT_free := LoadFunction('TS_MSG_IMPRINT_free', AFailed);
  i2d_TS_MSG_IMPRINT := LoadFunction('i2d_TS_MSG_IMPRINT', AFailed);
  d2i_TS_MSG_IMPRINT := LoadFunction('d2i_TS_MSG_IMPRINT', AFailed);
  TS_MSG_IMPRINT_dup := LoadFunction('TS_MSG_IMPRINT_dup', AFailed);
  d2i_TS_MSG_IMPRINT_bio := LoadFunction('d2i_TS_MSG_IMPRINT_bio', AFailed);
  i2d_TS_MSG_IMPRINT_bio := LoadFunction('i2d_TS_MSG_IMPRINT_bio', AFailed);
  TS_RESP_new := LoadFunction('TS_RESP_new', AFailed);
  TS_RESP_free := LoadFunction('TS_RESP_free', AFailed);
  i2d_TS_RESP := LoadFunction('i2d_TS_RESP', AFailed);
  d2i_TS_RESP := LoadFunction('d2i_TS_RESP', AFailed);
  PKCS7_to_TS_TST_INFO := LoadFunction('PKCS7_to_TS_TST_INFO', AFailed);
  TS_RESP_dup := LoadFunction('TS_RESP_dup', AFailed);
  d2i_TS_RESP_bio := LoadFunction('d2i_TS_RESP_bio', AFailed);
  i2d_TS_RESP_bio := LoadFunction('i2d_TS_RESP_bio', AFailed);
  TS_STATUS_INFO_new := LoadFunction('TS_STATUS_INFO_new', AFailed);
  TS_STATUS_INFO_free := LoadFunction('TS_STATUS_INFO_free', AFailed);
  i2d_TS_STATUS_INFO := LoadFunction('i2d_TS_STATUS_INFO', AFailed);
  d2i_TS_STATUS_INFO := LoadFunction('d2i_TS_STATUS_INFO', AFailed);
  TS_STATUS_INFO_dup := LoadFunction('TS_STATUS_INFO_dup', AFailed);
  TS_TST_INFO_new := LoadFunction('TS_TST_INFO_new', AFailed);
  TS_TST_INFO_free := LoadFunction('TS_TST_INFO_free', AFailed);
  i2d_TS_TST_INFO := LoadFunction('i2d_TS_TST_INFO', AFailed);
  d2i_TS_TST_INFO := LoadFunction('d2i_TS_TST_INFO', AFailed);
  TS_TST_INFO_dup := LoadFunction('TS_TST_INFO_dup', AFailed);
  d2i_TS_TST_INFO_bio := LoadFunction('d2i_TS_TST_INFO_bio', AFailed);
  i2d_TS_TST_INFO_bio := LoadFunction('i2d_TS_TST_INFO_bio', AFailed);
  TS_ACCURACY_new := LoadFunction('TS_ACCURACY_new', AFailed);
  TS_ACCURACY_free := LoadFunction('TS_ACCURACY_free', AFailed);
  i2d_TS_ACCURACY := LoadFunction('i2d_TS_ACCURACY', AFailed);
  d2i_TS_ACCURACY := LoadFunction('d2i_TS_ACCURACY', AFailed);
  TS_ACCURACY_dup := LoadFunction('TS_ACCURACY_dup', AFailed);
  ESS_ISSUER_SERIAL_new := LoadFunction('ESS_ISSUER_SERIAL_new', AFailed);
  ESS_ISSUER_SERIAL_free := LoadFunction('ESS_ISSUER_SERIAL_free', AFailed);
  i2d_ESS_ISSUER_SERIAL := LoadFunction('i2d_ESS_ISSUER_SERIAL', AFailed);
  d2i_ESS_ISSUER_SERIAL := LoadFunction('d2i_ESS_ISSUER_SERIAL', AFailed);
  ESS_ISSUER_SERIAL_dup := LoadFunction('ESS_ISSUER_SERIAL_dup', AFailed);
  ESS_CERT_ID_new := LoadFunction('ESS_CERT_ID_new', AFailed);
  ESS_CERT_ID_free := LoadFunction('ESS_CERT_ID_free', AFailed);
  i2d_ESS_CERT_ID := LoadFunction('i2d_ESS_CERT_ID', AFailed);
  d2i_ESS_CERT_ID := LoadFunction('d2i_ESS_CERT_ID', AFailed);
  ESS_CERT_ID_dup := LoadFunction('ESS_CERT_ID_dup', AFailed);
  ESS_SIGNING_CERT_new := LoadFunction('ESS_SIGNING_CERT_new', AFailed);
  ESS_SIGNING_CERT_free := LoadFunction('ESS_SIGNING_CERT_free', AFailed);
  i2d_ESS_SIGNING_CERT := LoadFunction('i2d_ESS_SIGNING_CERT', AFailed);
  d2i_ESS_SIGNING_CERT := LoadFunction('d2i_ESS_SIGNING_CERT', AFailed);
  ESS_SIGNING_CERT_dup := LoadFunction('ESS_SIGNING_CERT_dup', AFailed);
  ESS_CERT_ID_V2_new := LoadFunction('ESS_CERT_ID_V2_new', AFailed);
  ESS_CERT_ID_V2_free := LoadFunction('ESS_CERT_ID_V2_free', AFailed);
  i2d_ESS_CERT_ID_V2 := LoadFunction('i2d_ESS_CERT_ID_V2', AFailed);
  d2i_ESS_CERT_ID_V2 := LoadFunction('d2i_ESS_CERT_ID_V2', AFailed);
  ESS_CERT_ID_V2_dup := LoadFunction('ESS_CERT_ID_V2_dup', AFailed);
  ESS_SIGNING_CERT_V2_new := LoadFunction('ESS_SIGNING_CERT_V2_new', AFailed);
  ESS_SIGNING_CERT_V2_free := LoadFunction('ESS_SIGNING_CERT_V2_free', AFailed);
  i2d_ESS_SIGNING_CERT_V2 := LoadFunction('i2d_ESS_SIGNING_CERT_V2', AFailed);
  d2i_ESS_SIGNING_CERT_V2 := LoadFunction('d2i_ESS_SIGNING_CERT_V2', AFailed);
  ESS_SIGNING_CERT_V2_dup := LoadFunction('ESS_SIGNING_CERT_V2_dup', AFailed);
  TS_REQ_set_version := LoadFunction('TS_REQ_set_version', AFailed);
  TS_REQ_get_version := LoadFunction('TS_REQ_get_version', AFailed);
  TS_STATUS_INFO_set_status := LoadFunction('TS_STATUS_INFO_set_status', AFailed);
  TS_STATUS_INFO_get0_status := LoadFunction('TS_STATUS_INFO_get0_status', AFailed);
  TS_REQ_set_msg_imprint := LoadFunction('TS_REQ_set_msg_imprint', AFailed);
  TS_REQ_get_msg_imprint := LoadFunction('TS_REQ_get_msg_imprint', AFailed);
  TS_MSG_IMPRINT_set_algo := LoadFunction('TS_MSG_IMPRINT_set_algo', AFailed);
  TS_MSG_IMPRINT_get_algo := LoadFunction('TS_MSG_IMPRINT_get_algo', AFailed);
  TS_MSG_IMPRINT_set_msg := LoadFunction('TS_MSG_IMPRINT_set_msg', AFailed);
  TS_MSG_IMPRINT_get_msg := LoadFunction('TS_MSG_IMPRINT_get_msg', AFailed);
  TS_REQ_set_policy_id := LoadFunction('TS_REQ_set_policy_id', AFailed);
  TS_REQ_get_policy_id := LoadFunction('TS_REQ_get_policy_id', AFailed);
  TS_REQ_set_nonce := LoadFunction('TS_REQ_set_nonce', AFailed);
  TS_REQ_get_nonce := LoadFunction('TS_REQ_get_nonce', AFailed);
  TS_REQ_set_cert_req := LoadFunction('TS_REQ_set_cert_req', AFailed);
  TS_REQ_get_cert_req := LoadFunction('TS_REQ_get_cert_req', AFailed);
  TS_REQ_ext_free := LoadFunction('TS_REQ_ext_free', AFailed);
  TS_REQ_get_ext_count := LoadFunction('TS_REQ_get_ext_count', AFailed);
  TS_REQ_get_ext_by_NID := LoadFunction('TS_REQ_get_ext_by_NID', AFailed);
  TS_REQ_get_ext_by_OBJ := LoadFunction('TS_REQ_get_ext_by_OBJ', AFailed);
  TS_REQ_get_ext_by_critical := LoadFunction('TS_REQ_get_ext_by_critical', AFailed);
  TS_REQ_get_ext := LoadFunction('TS_REQ_get_ext', AFailed);
  TS_REQ_delete_ext := LoadFunction('TS_REQ_delete_ext', AFailed);
  TS_REQ_add_ext := LoadFunction('TS_REQ_add_ext', AFailed);
  TS_REQ_get_ext_d2i := LoadFunction('TS_REQ_get_ext_d2i', AFailed);
  TS_REQ_print_bio := LoadFunction('TS_REQ_print_bio', AFailed);
  TS_RESP_set_status_info := LoadFunction('TS_RESP_set_status_info', AFailed);
  TS_RESP_get_status_info := LoadFunction('TS_RESP_get_status_info', AFailed);
  TS_RESP_set_tst_info := LoadFunction('TS_RESP_set_tst_info', AFailed);
  TS_RESP_get_token := LoadFunction('TS_RESP_get_token', AFailed);
  TS_RESP_get_tst_info := LoadFunction('TS_RESP_get_tst_info', AFailed);
  TS_TST_INFO_set_version := LoadFunction('TS_TST_INFO_set_version', AFailed);
  TS_TST_INFO_get_version := LoadFunction('TS_TST_INFO_get_version', AFailed);
  TS_TST_INFO_set_policy_id := LoadFunction('TS_TST_INFO_set_policy_id', AFailed);
  TS_TST_INFO_get_policy_id := LoadFunction('TS_TST_INFO_get_policy_id', AFailed);
  TS_TST_INFO_set_msg_imprint := LoadFunction('TS_TST_INFO_set_msg_imprint', AFailed);
  TS_TST_INFO_get_msg_imprint := LoadFunction('TS_TST_INFO_get_msg_imprint', AFailed);
  TS_TST_INFO_set_serial := LoadFunction('TS_TST_INFO_set_serial', AFailed);
  TS_TST_INFO_get_serial := LoadFunction('TS_TST_INFO_get_serial', AFailed);
  TS_TST_INFO_set_time := LoadFunction('TS_TST_INFO_set_time', AFailed);
  TS_TST_INFO_get_time := LoadFunction('TS_TST_INFO_get_time', AFailed);
  TS_TST_INFO_set_accuracy := LoadFunction('TS_TST_INFO_set_accuracy', AFailed);
  TS_TST_INFO_get_accuracy := LoadFunction('TS_TST_INFO_get_accuracy', AFailed);
  TS_ACCURACY_set_seconds := LoadFunction('TS_ACCURACY_set_seconds', AFailed);
  TS_ACCURACY_get_seconds := LoadFunction('TS_ACCURACY_get_seconds', AFailed);
  TS_ACCURACY_set_millis := LoadFunction('TS_ACCURACY_set_millis', AFailed);
  TS_ACCURACY_get_millis := LoadFunction('TS_ACCURACY_get_millis', AFailed);
  TS_ACCURACY_set_micros := LoadFunction('TS_ACCURACY_set_micros', AFailed);
  TS_ACCURACY_get_micros := LoadFunction('TS_ACCURACY_get_micros', AFailed);
  TS_TST_INFO_set_ordering := LoadFunction('TS_TST_INFO_set_ordering', AFailed);
  TS_TST_INFO_get_ordering := LoadFunction('TS_TST_INFO_get_ordering', AFailed);
  TS_TST_INFO_set_nonce := LoadFunction('TS_TST_INFO_set_nonce', AFailed);
  TS_TST_INFO_get_nonce := LoadFunction('TS_TST_INFO_get_nonce', AFailed);
  TS_TST_INFO_set_tsa := LoadFunction('TS_TST_INFO_set_tsa', AFailed);
  TS_TST_INFO_get_tsa := LoadFunction('TS_TST_INFO_get_tsa', AFailed);
  TS_TST_INFO_ext_free := LoadFunction('TS_TST_INFO_ext_free', AFailed);
  TS_TST_INFO_get_ext_count := LoadFunction('TS_TST_INFO_get_ext_count', AFailed);
  TS_TST_INFO_get_ext_by_NID := LoadFunction('TS_TST_INFO_get_ext_by_NID', AFailed);
  TS_TST_INFO_get_ext_by_OBJ := LoadFunction('TS_TST_INFO_get_ext_by_OBJ', AFailed);
  TS_TST_INFO_get_ext_by_critical := LoadFunction('TS_TST_INFO_get_ext_by_critical', AFailed);
  TS_TST_INFO_get_ext := LoadFunction('TS_TST_INFO_get_ext', AFailed);
  TS_TST_INFO_delete_ext := LoadFunction('TS_TST_INFO_delete_ext', AFailed);
  TS_TST_INFO_add_ext := LoadFunction('TS_TST_INFO_add_ext', AFailed);
  TS_TST_INFO_get_ext_d2i := LoadFunction('TS_TST_INFO_get_ext_d2i', AFailed);
  TS_RESP_CTX_new := LoadFunction('TS_RESP_CTX_new', AFailed);
  TS_RESP_CTX_free := LoadFunction('TS_RESP_CTX_free', AFailed);
  TS_RESP_CTX_set_signer_cert := LoadFunction('TS_RESP_CTX_set_signer_cert', AFailed);
  TS_RESP_CTX_set_signer_key := LoadFunction('TS_RESP_CTX_set_signer_key', AFailed);
  TS_RESP_CTX_set_signer_digest := LoadFunction('TS_RESP_CTX_set_signer_digest', AFailed);
  TS_RESP_CTX_set_ess_cert_id_digest := LoadFunction('TS_RESP_CTX_set_ess_cert_id_digest', AFailed);
  TS_RESP_CTX_set_def_policy := LoadFunction('TS_RESP_CTX_set_def_policy', AFailed);
  TS_RESP_CTX_add_policy := LoadFunction('TS_RESP_CTX_add_policy', AFailed);
  TS_RESP_CTX_add_md := LoadFunction('TS_RESP_CTX_add_md', AFailed);
  TS_RESP_CTX_set_accuracy := LoadFunction('TS_RESP_CTX_set_accuracy', AFailed);
  TS_RESP_CTX_set_clock_precision_digits := LoadFunction('TS_RESP_CTX_set_clock_precision_digits', AFailed);
  TS_RESP_CTX_add_flags := LoadFunction('TS_RESP_CTX_add_flags', AFailed);
  TS_RESP_CTX_set_serial_cb := LoadFunction('TS_RESP_CTX_set_serial_cb', AFailed);
  TS_RESP_CTX_set_time_cb := LoadFunction('TS_RESP_CTX_set_time_cb', AFailed);
  TS_RESP_CTX_set_extension_cb := LoadFunction('TS_RESP_CTX_set_extension_cb', AFailed);
  TS_RESP_CTX_set_status_info := LoadFunction('TS_RESP_CTX_set_status_info', AFailed);
  TS_RESP_CTX_set_status_info_cond := LoadFunction('TS_RESP_CTX_set_status_info_cond', AFailed);
  TS_RESP_CTX_add_failure_info := LoadFunction('TS_RESP_CTX_add_failure_info', AFailed);
  TS_RESP_CTX_get_request := LoadFunction('TS_RESP_CTX_get_request', AFailed);
  TS_RESP_CTX_get_tst_info := LoadFunction('TS_RESP_CTX_get_tst_info', AFailed);
  TS_RESP_create_response := LoadFunction('TS_RESP_create_response', AFailed);
  TS_RESP_verify_response := LoadFunction('TS_RESP_verify_response', AFailed);
  TS_RESP_verify_token := LoadFunction('TS_RESP_verify_token', AFailed);
  TS_VERIFY_CTX_new := LoadFunction('TS_VERIFY_CTX_new', AFailed);
  TS_VERIFY_CTX_init := LoadFunction('TS_VERIFY_CTX_init', AFailed);
  TS_VERIFY_CTX_free := LoadFunction('TS_VERIFY_CTX_free', AFailed);
  TS_VERIFY_CTX_cleanup := LoadFunction('TS_VERIFY_CTX_cleanup', AFailed);
  TS_VERIFY_CTX_set_flags := LoadFunction('TS_VERIFY_CTX_set_flags', AFailed);
  TS_VERIFY_CTX_add_flags := LoadFunction('TS_VERIFY_CTX_add_flags', AFailed);
  TS_VERIFY_CTX_set_data := LoadFunction('TS_VERIFY_CTX_set_data', AFailed);
  TS_VERIFY_CTX_set_imprint := LoadFunction('TS_VERIFY_CTX_set_imprint', AFailed);
  TS_VERIFY_CTX_set_store := LoadFunction('TS_VERIFY_CTX_set_store', AFailed);
  TS_REQ_to_TS_VERIFY_CTX := LoadFunction('TS_REQ_to_TS_VERIFY_CTX', AFailed);
  TS_RESP_print_bio := LoadFunction('TS_RESP_print_bio', AFailed);
  TS_STATUS_INFO_print_bio := LoadFunction('TS_STATUS_INFO_print_bio', AFailed);
  TS_TST_INFO_print_bio := LoadFunction('TS_TST_INFO_print_bio', AFailed);
  TS_ASN1_INTEGER_print_bio := LoadFunction('TS_ASN1_INTEGER_print_bio', AFailed);
  TS_OBJ_print_bio := LoadFunction('TS_OBJ_print_bio', AFailed);
  TS_X509_ALGOR_print_bio := LoadFunction('TS_X509_ALGOR_print_bio', AFailed);
  TS_MSG_IMPRINT_print_bio := LoadFunction('TS_MSG_IMPRINT_print_bio', AFailed);
  TS_CONF_load_cert := LoadFunction('TS_CONF_load_cert', AFailed);
  TS_CONF_load_key := LoadFunction('TS_CONF_load_key', AFailed);
  TS_CONF_set_serial := LoadFunction('TS_CONF_set_serial', AFailed);
  TS_CONF_get_tsa_section := LoadFunction('TS_CONF_get_tsa_section', AFailed);
  TS_CONF_set_crypto_device := LoadFunction('TS_CONF_set_crypto_device', AFailed);
  TS_CONF_set_default_engine := LoadFunction('TS_CONF_set_default_engine', AFailed);
  TS_CONF_set_signer_cert := LoadFunction('TS_CONF_set_signer_cert', AFailed);
  TS_CONF_set_certs := LoadFunction('TS_CONF_set_certs', AFailed);
  TS_CONF_set_signer_key := LoadFunction('TS_CONF_set_signer_key', AFailed);
  TS_CONF_set_signer_digest := LoadFunction('TS_CONF_set_signer_digest', AFailed);
  TS_CONF_set_def_policy := LoadFunction('TS_CONF_set_def_policy', AFailed);
  TS_CONF_set_policies := LoadFunction('TS_CONF_set_policies', AFailed);
  TS_CONF_set_digests := LoadFunction('TS_CONF_set_digests', AFailed);
  TS_CONF_set_accuracy := LoadFunction('TS_CONF_set_accuracy', AFailed);
  TS_CONF_set_clock_precision_digits := LoadFunction('TS_CONF_set_clock_precision_digits', AFailed);
  TS_CONF_set_ordering := LoadFunction('TS_CONF_set_ordering', AFailed);
  TS_CONF_set_tsa_name := LoadFunction('TS_CONF_set_tsa_name', AFailed);
  TS_CONF_set_ess_cert_id_chain := LoadFunction('TS_CONF_set_ess_cert_id_chain', AFailed);
  TS_CONF_set_ess_cert_id_digest := LoadFunction('TS_CONF_set_ess_cert_id_digest', AFailed);
end;

procedure UnLoad;
begin
  TS_REQ_new := nil;
  TS_REQ_free := nil;
  i2d_TS_REQ := nil;
  d2i_TS_REQ := nil;
  TS_REQ_dup := nil;
  d2i_TS_REQ_bio := nil;
  i2d_TS_REQ_bio := nil;
  TS_MSG_IMPRINT_new := nil;
  TS_MSG_IMPRINT_free := nil;
  i2d_TS_MSG_IMPRINT := nil;
  d2i_TS_MSG_IMPRINT := nil;
  TS_MSG_IMPRINT_dup := nil;
  d2i_TS_MSG_IMPRINT_bio := nil;
  i2d_TS_MSG_IMPRINT_bio := nil;
  TS_RESP_new := nil;
  TS_RESP_free := nil;
  i2d_TS_RESP := nil;
  d2i_TS_RESP := nil;
  PKCS7_to_TS_TST_INFO := nil;
  TS_RESP_dup := nil;
  d2i_TS_RESP_bio := nil;
  i2d_TS_RESP_bio := nil;
  TS_STATUS_INFO_new := nil;
  TS_STATUS_INFO_free := nil;
  i2d_TS_STATUS_INFO := nil;
  d2i_TS_STATUS_INFO := nil;
  TS_STATUS_INFO_dup := nil;
  TS_TST_INFO_new := nil;
  TS_TST_INFO_free := nil;
  i2d_TS_TST_INFO := nil;
  d2i_TS_TST_INFO := nil;
  TS_TST_INFO_dup := nil;
  d2i_TS_TST_INFO_bio := nil;
  i2d_TS_TST_INFO_bio := nil;
  TS_ACCURACY_new := nil;
  TS_ACCURACY_free := nil;
  i2d_TS_ACCURACY := nil;
  d2i_TS_ACCURACY := nil;
  TS_ACCURACY_dup := nil;
  ESS_ISSUER_SERIAL_new := nil;
  ESS_ISSUER_SERIAL_free := nil;
  i2d_ESS_ISSUER_SERIAL := nil;
  d2i_ESS_ISSUER_SERIAL := nil;
  ESS_ISSUER_SERIAL_dup := nil;
  ESS_CERT_ID_new := nil;
  ESS_CERT_ID_free := nil;
  i2d_ESS_CERT_ID := nil;
  d2i_ESS_CERT_ID := nil;
  ESS_CERT_ID_dup := nil;
  ESS_SIGNING_CERT_new := nil;
  ESS_SIGNING_CERT_free := nil;
  i2d_ESS_SIGNING_CERT := nil;
  d2i_ESS_SIGNING_CERT := nil;
  ESS_SIGNING_CERT_dup := nil;
  ESS_CERT_ID_V2_new := nil;
  ESS_CERT_ID_V2_free := nil;
  i2d_ESS_CERT_ID_V2 := nil;
  d2i_ESS_CERT_ID_V2 := nil;
  ESS_CERT_ID_V2_dup := nil;
  ESS_SIGNING_CERT_V2_new := nil;
  ESS_SIGNING_CERT_V2_free := nil;
  i2d_ESS_SIGNING_CERT_V2 := nil;
  d2i_ESS_SIGNING_CERT_V2 := nil;
  ESS_SIGNING_CERT_V2_dup := nil;
  TS_REQ_set_version := nil;
  TS_REQ_get_version := nil;
  TS_STATUS_INFO_set_status := nil;
  TS_STATUS_INFO_get0_status := nil;
  TS_REQ_set_msg_imprint := nil;
  TS_REQ_get_msg_imprint := nil;
  TS_MSG_IMPRINT_set_algo := nil;
  TS_MSG_IMPRINT_get_algo := nil;
  TS_MSG_IMPRINT_set_msg := nil;
  TS_MSG_IMPRINT_get_msg := nil;
  TS_REQ_set_policy_id := nil;
  TS_REQ_get_policy_id := nil;
  TS_REQ_set_nonce := nil;
  TS_REQ_get_nonce := nil;
  TS_REQ_set_cert_req := nil;
  TS_REQ_get_cert_req := nil;
  TS_REQ_ext_free := nil;
  TS_REQ_get_ext_count := nil;
  TS_REQ_get_ext_by_NID := nil;
  TS_REQ_get_ext_by_OBJ := nil;
  TS_REQ_get_ext_by_critical := nil;
  TS_REQ_get_ext := nil;
  TS_REQ_delete_ext := nil;
  TS_REQ_add_ext := nil;
  TS_REQ_get_ext_d2i := nil;
  TS_REQ_print_bio := nil;
  TS_RESP_set_status_info := nil;
  TS_RESP_get_status_info := nil;
  TS_RESP_set_tst_info := nil;
  TS_RESP_get_token := nil;
  TS_RESP_get_tst_info := nil;
  TS_TST_INFO_set_version := nil;
  TS_TST_INFO_get_version := nil;
  TS_TST_INFO_set_policy_id := nil;
  TS_TST_INFO_get_policy_id := nil;
  TS_TST_INFO_set_msg_imprint := nil;
  TS_TST_INFO_get_msg_imprint := nil;
  TS_TST_INFO_set_serial := nil;
  TS_TST_INFO_get_serial := nil;
  TS_TST_INFO_set_time := nil;
  TS_TST_INFO_get_time := nil;
  TS_TST_INFO_set_accuracy := nil;
  TS_TST_INFO_get_accuracy := nil;
  TS_ACCURACY_set_seconds := nil;
  TS_ACCURACY_get_seconds := nil;
  TS_ACCURACY_set_millis := nil;
  TS_ACCURACY_get_millis := nil;
  TS_ACCURACY_set_micros := nil;
  TS_ACCURACY_get_micros := nil;
  TS_TST_INFO_set_ordering := nil;
  TS_TST_INFO_get_ordering := nil;
  TS_TST_INFO_set_nonce := nil;
  TS_TST_INFO_get_nonce := nil;
  TS_TST_INFO_set_tsa := nil;
  TS_TST_INFO_get_tsa := nil;
  TS_TST_INFO_ext_free := nil;
  TS_TST_INFO_get_ext_count := nil;
  TS_TST_INFO_get_ext_by_NID := nil;
  TS_TST_INFO_get_ext_by_OBJ := nil;
  TS_TST_INFO_get_ext_by_critical := nil;
  TS_TST_INFO_get_ext := nil;
  TS_TST_INFO_delete_ext := nil;
  TS_TST_INFO_add_ext := nil;
  TS_TST_INFO_get_ext_d2i := nil;
  TS_RESP_CTX_new := nil;
  TS_RESP_CTX_free := nil;
  TS_RESP_CTX_set_signer_cert := nil;
  TS_RESP_CTX_set_signer_key := nil;
  TS_RESP_CTX_set_signer_digest := nil;
  TS_RESP_CTX_set_ess_cert_id_digest := nil;
  TS_RESP_CTX_set_def_policy := nil;
  TS_RESP_CTX_add_policy := nil;
  TS_RESP_CTX_add_md := nil;
  TS_RESP_CTX_set_accuracy := nil;
  TS_RESP_CTX_set_clock_precision_digits := nil;
  TS_RESP_CTX_add_flags := nil;
  TS_RESP_CTX_set_serial_cb := nil;
  TS_RESP_CTX_set_time_cb := nil;
  TS_RESP_CTX_set_extension_cb := nil;
  TS_RESP_CTX_set_status_info := nil;
  TS_RESP_CTX_set_status_info_cond := nil;
  TS_RESP_CTX_add_failure_info := nil;
  TS_RESP_CTX_get_request := nil;
  TS_RESP_CTX_get_tst_info := nil;
  TS_RESP_create_response := nil;
  TS_RESP_verify_response := nil;
  TS_RESP_verify_token := nil;
  TS_VERIFY_CTX_new := nil;
  TS_VERIFY_CTX_init := nil;
  TS_VERIFY_CTX_free := nil;
  TS_VERIFY_CTX_cleanup := nil;
  TS_VERIFY_CTX_set_flags := nil;
  TS_VERIFY_CTX_add_flags := nil;
  TS_VERIFY_CTX_set_data := nil;
  TS_VERIFY_CTX_set_imprint := nil;
  TS_VERIFY_CTX_set_store := nil;
  TS_REQ_to_TS_VERIFY_CTX := nil;
  TS_RESP_print_bio := nil;
  TS_STATUS_INFO_print_bio := nil;
  TS_TST_INFO_print_bio := nil;
  TS_ASN1_INTEGER_print_bio := nil;
  TS_OBJ_print_bio := nil;
  TS_X509_ALGOR_print_bio := nil;
  TS_MSG_IMPRINT_print_bio := nil;
  TS_CONF_load_cert := nil;
  TS_CONF_load_key := nil;
  TS_CONF_set_serial := nil;
  TS_CONF_get_tsa_section := nil;
  TS_CONF_set_crypto_device := nil;
  TS_CONF_set_default_engine := nil;
  TS_CONF_set_signer_cert := nil;
  TS_CONF_set_certs := nil;
  TS_CONF_set_signer_key := nil;
  TS_CONF_set_signer_digest := nil;
  TS_CONF_set_def_policy := nil;
  TS_CONF_set_policies := nil;
  TS_CONF_set_digests := nil;
  TS_CONF_set_accuracy := nil;
  TS_CONF_set_clock_precision_digits := nil;
  TS_CONF_set_ordering := nil;
  TS_CONF_set_tsa_name := nil;
  TS_CONF_set_ess_cert_id_chain := nil;
  TS_CONF_set_ess_cert_id_digest := nil;
end;

end.
