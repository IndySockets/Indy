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

unit IdOpenSSLHeaders_x509err;

interface

// Headers for OpenSSL 1.1.1
// x509err.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * X509 function codes.
   *)
  X509_F_ADD_CERT_DIR                       = 100;
  X509_F_BUILD_CHAIN                        = 106;
  X509_F_BY_FILE_CTRL                       = 101;
  X509_F_CHECK_NAME_CONSTRAINTS             = 149;
  X509_F_CHECK_POLICY                       = 145;
  X509_F_DANE_I2D                           = 107;
  X509_F_DIR_CTRL                           = 102;
  X509_F_GET_CERT_BY_SUBJECT                = 103;
  X509_F_I2D_X509_AUX                       = 151;
  X509_F_LOOKUP_CERTS_SK                    = 152;
  X509_F_NETSCAPE_SPKI_B64_DECODE           = 129;
  X509_F_NETSCAPE_SPKI_B64_ENCODE           = 130;
  X509_F_NEW_DIR                            = 153;
  X509_F_X509AT_ADD1_ATTR                   = 135;
  X509_F_X509V3_ADD_EXT                     = 104;
  X509_F_X509_ATTRIBUTE_CREATE_BY_NID       = 136;
  X509_F_X509_ATTRIBUTE_CREATE_BY_OBJ       = 137;
  X509_F_X509_ATTRIBUTE_CREATE_BY_TXT       = 140;
  X509_F_X509_ATTRIBUTE_GET0_DATA           = 139;
  X509_F_X509_ATTRIBUTE_SET1_DATA           = 138;
  X509_F_X509_CHECK_PRIVATE_KEY             = 128;
  X509_F_X509_CRL_DIFF                      = 105;
  X509_F_X509_CRL_METHOD_NEW                = 154;
  X509_F_X509_CRL_PRINT_FP                  = 147;
  X509_F_X509_EXTENSION_CREATE_BY_NID       = 108;
  X509_F_X509_EXTENSION_CREATE_BY_OBJ       = 109;
  X509_F_X509_GET_PUBKEY_PARAMETERS         = 110;
  X509_F_X509_LOAD_CERT_CRL_FILE            = 132;
  X509_F_X509_LOAD_CERT_FILE                = 111;
  X509_F_X509_LOAD_CRL_FILE                 = 112;
  X509_F_X509_LOOKUP_METH_NEW               = 160;
  X509_F_X509_LOOKUP_NEW                    = 155;
  X509_F_X509_NAME_ADD_ENTRY                = 113;
  X509_F_X509_NAME_CANON                    = 156;
  X509_F_X509_NAME_ENTRY_CREATE_BY_NID      = 114;
  X509_F_X509_NAME_ENTRY_CREATE_BY_TXT      = 131;
  X509_F_X509_NAME_ENTRY_SET_OBJECT         = 115;
  X509_F_X509_NAME_ONELINE                  = 116;
  X509_F_X509_NAME_PRINT                    = 117;
  X509_F_X509_OBJECT_NEW                    = 150;
  X509_F_X509_PRINT_EX_FP                   = 118;
  X509_F_X509_PUBKEY_DECODE                 = 148;
  X509_F_X509_PUBKEY_GET0                   = 119;
  X509_F_X509_PUBKEY_SET                    = 120;
  X509_F_X509_REQ_CHECK_PRIVATE_KEY         = 144;
  X509_F_X509_REQ_PRINT_EX                  = 121;
  X509_F_X509_REQ_PRINT_FP                  = 122;
  X509_F_X509_REQ_TO_X509                   = 123;
  X509_F_X509_STORE_ADD_CERT                = 124;
  X509_F_X509_STORE_ADD_CRL                 = 125;
  X509_F_X509_STORE_ADD_LOOKUP              = 157;
  X509_F_X509_STORE_CTX_GET1_ISSUER         = 146;
  X509_F_X509_STORE_CTX_INIT                = 143;
  X509_F_X509_STORE_CTX_NEW                 = 142;
  X509_F_X509_STORE_CTX_PURPOSE_INHERIT     = 134;
  X509_F_X509_STORE_NEW                     = 158;
  X509_F_X509_TO_X509_REQ                   = 126;
  X509_F_X509_TRUST_ADD                     = 133;
  X509_F_X509_TRUST_SET                     = 141;
  X509_F_X509_VERIFY_CERT                   = 127;
  X509_F_X509_VERIFY_PARAM_NEW              = 159;

  (*
   * X509 reason codes.
   *)
  X509_R_AKID_MISMATCH                      = 110;
  X509_R_BAD_SELECTOR                       = 133;
  X509_R_BAD_X509_FILETYPE                  = 100;
  X509_R_BASE64_DECODE_ERROR                = 118;
  X509_R_CANT_CHECK_DH_KEY                  = 114;
  X509_R_CERT_ALREADY_IN_HASH_TABLE         = 101;
  X509_R_CRL_ALREADY_DELTA                  = 127;
  X509_R_CRL_VERIFY_FAILURE                 = 131;
  X509_R_IDP_MISMATCH                       = 128;
  X509_R_INVALID_ATTRIBUTES                 = 138;
  X509_R_INVALID_DIRECTORY                  = 113;
  X509_R_INVALID_FIELD_NAME                 = 119;
  X509_R_INVALID_TRUST                      = 123;
  X509_R_ISSUER_MISMATCH                    = 129;
  X509_R_KEY_TYPE_MISMATCH                  = 115;
  X509_R_KEY_VALUES_MISMATCH                = 116;
  X509_R_LOADING_CERT_DIR                   = 103;
  X509_R_LOADING_DEFAULTS                   = 104;
  X509_R_METHOD_NOT_SUPPORTED               = 124;
  X509_R_NAME_TOO_LONG                      = 134;
  X509_R_NEWER_CRL_NOT_NEWER                = 132;
  X509_R_NO_CERTIFICATE_FOUND               = 135;
  X509_R_NO_CERTIFICATE_OR_CRL_FOUND        = 136;
  X509_R_NO_CERT_SET_FOR_US_TO_VERIFY       = 105;
  X509_R_NO_CRL_FOUND                       = 137;
  X509_R_NO_CRL_NUMBER                      = 130;
  X509_R_PUBLIC_KEY_DECODE_ERROR            = 125;
  X509_R_PUBLIC_KEY_ENCODE_ERROR            = 126;
  X509_R_SHOULD_RETRY                       = 106;
  X509_R_UNABLE_TO_FIND_PARAMETERS_IN_CHAIN = 107;
  X509_R_UNABLE_TO_GET_CERTS_PUBLIC_KEY     = 108;
  X509_R_UNKNOWN_KEY_TYPE                   = 117;
  X509_R_UNKNOWN_NID                        = 109;
  X509_R_UNKNOWN_PURPOSE_ID                 = 121;
  X509_R_UNKNOWN_TRUST_ID                   = 120;
  X509_R_UNSUPPORTED_ALGORITHM              = 111;
  X509_R_WRONG_LOOKUP_TYPE                  = 112;
  X509_R_WRONG_TYPE                         = 122;

var
  function ERR_load_X509_strings: TIdC_INT;

implementation

end.
