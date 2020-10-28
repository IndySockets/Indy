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

unit IdOpenSSLHeaders_cterr;

interface

// Headers for OpenSSL 1.1.1
// cterr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  ///*
  // * CT function codes.
  // */
  CT_F_CTLOG_NEW = 117;
  CT_F_CTLOG_NEW_FROM_BASE64 = 118;
  CT_F_CTLOG_NEW_FROM_CONF = 119;
  CT_F_CTLOG_STORE_LOAD_CTX_NEW = 122;
  CT_F_CTLOG_STORE_LOAD_FILE = 123;
  CT_F_CTLOG_STORE_LOAD_LOG = 130;
  CT_F_CTLOG_STORE_NEW = 131;
  CT_F_CT_BASE64_DECODE = 124;
  CT_F_CT_POLICY_EVAL_CTX_NEW = 133;
  CT_F_CT_V1_LOG_ID_FROM_PKEY = 125;
  CT_F_I2O_SCT = 107;
  CT_F_I2O_SCT_LIST = 108;
  CT_F_I2O_SCT_SIGNATURE = 109;
  CT_F_O2I_SCT = 110;
  CT_F_O2I_SCT_LIST = 111;
  CT_F_O2I_SCT_SIGNATURE = 112;
  CT_F_SCT_CTX_NEW = 126;
  CT_F_SCT_CTX_VERIFY = 128;
  CT_F_SCT_NEW = 100;
  CT_F_SCT_NEW_FROM_BASE64 = 127;
  CT_F_SCT_SET0_LOG_ID = 101;
  CT_F_SCT_SET1_EXTENSIONS = 114;
  CT_F_SCT_SET1_LOG_ID = 115;
  CT_F_SCT_SET1_SIGNATURE = 116;
  CT_F_SCT_SET_LOG_ENTRY_TYPE = 102;
  CT_F_SCT_SET_SIGNATURE_NID = 103;
  CT_F_SCT_SET_VERSION = 104;


  ///*
  // * CT reason codes.
  // */
  CT_R_BASE64_DECODE_ERROR =  108;
  CT_R_INVALID_LOG_ID_LENGTH =  100;
  CT_R_LOG_CONF_INVALID =  109;
  CT_R_LOG_CONF_INVALID_KEY =  110;
  CT_R_LOG_CONF_MISSING_DESCRIPTION =  111;
  CT_R_LOG_CONF_MISSING_KEY =  112;
  CT_R_LOG_KEY_INVALID =  113;
  CT_R_SCT_FUTURE_TIMESTAMP =  116;
  CT_R_SCT_INVALID =   104;
  CT_R_SCT_INVALID_SIGNATURE =  107;
  CT_R_SCT_LIST_INVALID =  105;
  CT_R_SCT_LOG_ID_MISMATCH =  114;
  CT_R_SCT_NOT_SET =   106;
  CT_R_SCT_UNSUPPORTED_VERSION =  115;
  CT_R_UNRECOGNIZED_SIGNATURE_NID =  101;
  CT_R_UNSUPPORTED_ENTRY_TYPE =  102;
  CT_R_UNSUPPORTED_VERSION =  103;

  function ERR_load_CT_strings: TIdC_INT cdecl; external CLibCrypto;


implementation

end.
