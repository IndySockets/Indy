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

unit IdOpenSSLHeaders_dherr;

interface

// Headers for OpenSSL 1.1.1
// dherr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  // DH function codes
  DH_F_COMPUTE_KEY               = 102;
  DH_F_DHPARAMS_PRINT_FP         = 101;
  DH_F_DH_BUILTIN_GENPARAMS      = 106;
  DH_F_DH_CHECK_EX               = 121;
  DH_F_DH_CHECK_PARAMS_EX        = 122;
  DH_F_DH_CHECK_PUB_KEY_EX       = 123;
  DH_F_DH_CMS_DECRYPT            = 114;
  DH_F_DH_CMS_SET_PEERKEY        = 115;
  DH_F_DH_CMS_SET_SHARED_INFO    = 116;
  DH_F_DH_METH_DUP               = 117;
  DH_F_DH_METH_NEW               = 118;
  DH_F_DH_METH_SET1_NAME         = 119;
  DH_F_DH_NEW_BY_NID             = 104;
  DH_F_DH_NEW_METHOD             = 105;
  DH_F_DH_PARAM_DECODE           = 107;
  DH_F_DH_PKEY_PUBLIC_CHECK      = 124;
  DH_F_DH_PRIV_DECODE            = 110;
  DH_F_DH_PRIV_ENCODE            = 111;
  DH_F_DH_PUB_DECODE             = 108;
  DH_F_DH_PUB_ENCODE             = 109;
  DH_F_DO_DH_PRINT               = 100;
  DH_F_GENERATE_KEY              = 103;
  DH_F_PKEY_DH_CTRL_STR          = 120;
  DH_F_PKEY_DH_DERIVE            = 112;
  DH_F_PKEY_DH_INIT              = 125;
  DH_F_PKEY_DH_KEYGEN            = 113;

  // DH reason codes
  DH_R_BAD_GENERATOR             = 101;
  DH_R_BN_DECODE_ERROR           = 109;
  DH_R_BN_ERROR                  = 106;
  DH_R_CHECK_INVALID_J_VALUE     = 115;
  DH_R_CHECK_INVALID_Q_VALUE     = 116;
  DH_R_CHECK_PUBKEY_INVALID      = 122;
  DH_R_CHECK_PUBKEY_TOO_LARGE    = 123;
  DH_R_CHECK_PUBKEY_TOO_SMALL    = 124;
  DH_R_CHECK_P_NOT_PRIME         = 117;
  DH_R_CHECK_P_NOT_SAFE_PRIME    = 118;
  DH_R_CHECK_Q_NOT_PRIME         = 119;
  DH_R_DECODE_ERROR              = 104;
  DH_R_INVALID_PARAMETER_NAME    = 110;
  DH_R_INVALID_PARAMETER_NID     = 114;
  DH_R_INVALID_PUBKEY            = 102;
  DH_R_KDF_PARAMETER_ERROR       = 112;
  DH_R_KEYS_NOT_SET              = 108;
  DH_R_MISSING_PUBKEY            = 125;
  DH_R_MODULUS_TOO_LARGE         = 103;
  DH_R_NOT_SUITABLE_GENERATOR    = 120;
  DH_R_NO_PARAMETERS_SET         = 107;
  DH_R_NO_PRIVATE_VALUE          = 100;
  DH_R_PARAMETER_ENCODING_ERROR  = 105;
  DH_R_PEER_KEY_ERROR            = 111;
  DH_R_SHARED_INFO_ERROR         = 113;
  DH_R_UNABLE_TO_CHECK_GENERATOR = 121;

var
  function ERR_load_DH_strings: TIdC_INT;

implementation

end.
