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

unit IdOpenSSLHeaders_dsaerr;

interface

// Headers for OpenSSL 1.1.1
// dsaerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  ///*
  // * DSA function codes.
  // */
  DSA_F_DSAPARAMS_PRINT = 100;
  DSA_F_DSAPARAMS_PRINT_FP = 101;
  DSA_F_DSA_BUILTIN_PARAMGEN = 125;
  DSA_F_DSA_BUILTIN_PARAMGEN2 = 126;
  DSA_F_DSA_DO_SIGN = 112;
  DSA_F_DSA_DO_VERIFY = 113;
  DSA_F_DSA_METH_DUP = 127;
  DSA_F_DSA_METH_NEW = 128;
  DSA_F_DSA_METH_SET1_NAME = 129;
  DSA_F_DSA_NEW_METHOD = 103;
  DSA_F_DSA_PARAM_DECODE = 119;
  DSA_F_DSA_PRINT_FP = 105;
  DSA_F_DSA_PRIV_DECODE = 115;
  DSA_F_DSA_PRIV_ENCODE = 116;
  DSA_F_DSA_PUB_DECODE = 117;
  DSA_F_DSA_PUB_ENCODE = 118;
  DSA_F_DSA_SIGN = 106;
  DSA_F_DSA_SIGN_SETUP = 107;
  DSA_F_DSA_SIG_NEW = 102;
  DSA_F_OLD_DSA_PRIV_DECODE = 122;
  DSA_F_PKEY_DSA_CTRL = 120;
  DSA_F_PKEY_DSA_CTRL_STR = 104;
  DSA_F_PKEY_DSA_KEYGEN = 121;

  ///*
  // * DSA reason codes.
  // */
  DSA_R_BAD_Q_VALUE = 102;
  DSA_R_BN_DECODE_ERROR = 108;
  DSA_R_BN_ERROR = 109;
  DSA_R_DECODE_ERROR = 104;
  DSA_R_INVALID_DIGEST_TYPE = 106;
  DSA_R_INVALID_PARAMETERS = 112;
  DSA_R_MISSING_PARAMETERS = 101;
  DSA_R_MISSING_PRIVATE_KEY = 111;
  DSA_R_MODULUS_TOO_LARGE = 103;
  DSA_R_NO_PARAMETERS_SET = 107;
  DSA_R_PARAMETER_ENCODING_ERROR = 105;
  DSA_R_Q_NOT_PRIME = 113;
  DSA_R_SEED_LEN_SMALL = 110;

  function ERR_load_DSA_strings: TIdC_INT cdecl; external CLibCrypto;

implementation

end.
