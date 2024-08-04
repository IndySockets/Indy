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

unit IdOpenSSLHeaders_pkcs7err;

interface

// Headers for OpenSSL 1.1.1
// pkcs7err.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * PKCS7 function codes.
   *)
  PKCS7_F_DO_PKCS7_SIGNED_ATTRIB                     = 136;
  PKCS7_F_PKCS7_ADD0_ATTRIB_SIGNING_TIME             = 135;
  PKCS7_F_PKCS7_ADD_ATTRIB_SMIMECAP                  = 118;
  PKCS7_F_PKCS7_ADD_CERTIFICATE                      = 100;
  PKCS7_F_PKCS7_ADD_CRL                              = 101;
  PKCS7_F_PKCS7_ADD_RECIPIENT_INFO                   = 102;
  PKCS7_F_PKCS7_ADD_SIGNATURE                        = 131;
  PKCS7_F_PKCS7_ADD_SIGNER                           = 103;
  PKCS7_F_PKCS7_BIO_ADD_DIGEST                       = 125;
  PKCS7_F_PKCS7_COPY_EXISTING_DIGEST                 = 138;
  PKCS7_F_PKCS7_CTRL                                 = 104;
  PKCS7_F_PKCS7_DATADECODE                           = 112;
  PKCS7_F_PKCS7_DATAFINAL                            = 128;
  PKCS7_F_PKCS7_DATAINIT                             = 105;
  PKCS7_F_PKCS7_DATAVERIFY                           = 107;
  PKCS7_F_PKCS7_DECRYPT                              = 114;
  PKCS7_F_PKCS7_DECRYPT_RINFO                        = 133;
  PKCS7_F_PKCS7_ENCODE_RINFO                         = 132;
  PKCS7_F_PKCS7_ENCRYPT                              = 115;
  PKCS7_F_PKCS7_FINAL                                = 134;
  PKCS7_F_PKCS7_FIND_DIGEST                          = 127;
  PKCS7_F_PKCS7_GET0_SIGNERS                         = 124;
  PKCS7_F_PKCS7_RECIP_INFO_SET                       = 130;
  PKCS7_F_PKCS7_SET_CIPHER                           = 108;
  PKCS7_F_PKCS7_SET_CONTENT                          = 109;
  PKCS7_F_PKCS7_SET_DIGEST                           = 126;
  PKCS7_F_PKCS7_SET_TYPE                             = 110;
  PKCS7_F_PKCS7_SIGN                                 = 116;
  PKCS7_F_PKCS7_SIGNATUREVERIFY                      = 113;
  PKCS7_F_PKCS7_SIGNER_INFO_SET                      = 129;
  PKCS7_F_PKCS7_SIGNER_INFO_SIGN                     = 139;
  PKCS7_F_PKCS7_SIGN_ADD_SIGNER                      = 137;
  PKCS7_F_PKCS7_SIMPLE_SMIMECAP                      = 119;
  PKCS7_F_PKCS7_VERIFY                               = 117;

  (*
   * PKCS7 reason codes.
   *)
  PKCS7_R_CERTIFICATE_VERIFY_ERROR                   = 117;
  PKCS7_R_CIPHER_HAS_NO_OBJECT_IDENTIFIER            = 144;
  PKCS7_R_CIPHER_NOT_INITIALIZED                     = 116;
  PKCS7_R_CONTENT_AND_DATA_PRESENT                   = 118;
  PKCS7_R_CTRL_ERROR                                 = 152;
  PKCS7_R_DECRYPT_ERROR                              = 119;
  PKCS7_R_DIGEST_FAILURE                             = 101;
  PKCS7_R_ENCRYPTION_CTRL_FAILURE                    = 149;
  PKCS7_R_ENCRYPTION_NOT_SUPPORTED_FOR_THIS_KEY_TYPE = 150;
  PKCS7_R_ERROR_ADDING_RECIPIENT                     = 120;
  PKCS7_R_ERROR_SETTING_CIPHER                       = 121;
  PKCS7_R_INVALID_NULL_POINTER                       = 143;
  PKCS7_R_INVALID_SIGNED_DATA_TYPE                   = 155;
  PKCS7_R_NO_CONTENT                                 = 122;
  PKCS7_R_NO_DEFAULT_DIGEST                          = 151;
  PKCS7_R_NO_MATCHING_DIGEST_TYPE_FOUND              = 154;
  PKCS7_R_NO_RECIPIENT_MATCHES_CERTIFICATE           = 115;
  PKCS7_R_NO_SIGNATURES_ON_DATA                      = 123;
  PKCS7_R_NO_SIGNERS                                 = 142;
  PKCS7_R_OPERATION_NOT_SUPPORTED_ON_THIS_TYPE       = 104;
  PKCS7_R_PKCS7_ADD_SIGNATURE_ERROR                  = 124;
  PKCS7_R_PKCS7_ADD_SIGNER_ERROR                     = 153;
  PKCS7_R_PKCS7_DATASIGN                             = 145;
  PKCS7_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE     = 127;
  PKCS7_R_SIGNATURE_FAILURE                          = 105;
  PKCS7_R_SIGNER_CERTIFICATE_NOT_FOUND               = 128;
  PKCS7_R_SIGNING_CTRL_FAILURE                       = 147;
  PKCS7_R_SIGNING_NOT_SUPPORTED_FOR_THIS_KEY_TYPE    = 148;
  PKCS7_R_SMIME_TEXT_ERROR                           = 129;
  PKCS7_R_UNABLE_TO_FIND_CERTIFICATE                 = 106;
  PKCS7_R_UNABLE_TO_FIND_MEM_BIO                     = 107;
  PKCS7_R_UNABLE_TO_FIND_MESSAGE_DIGEST              = 108;
  PKCS7_R_UNKNOWN_DIGEST_TYPE                        = 109;
  PKCS7_R_UNKNOWN_OPERATION                          = 110;
  PKCS7_R_UNSUPPORTED_CIPHER_TYPE                    = 111;
  PKCS7_R_UNSUPPORTED_CONTENT_TYPE                   = 112;
  PKCS7_R_WRONG_CONTENT_TYPE                         = 113;
  PKCS7_R_WRONG_PKCS7_TYPE                           = 114;

  function ERR_load_PKCS7_strings: TIdC_INT cdecl; external CLibCrypto;

implementation

end.
