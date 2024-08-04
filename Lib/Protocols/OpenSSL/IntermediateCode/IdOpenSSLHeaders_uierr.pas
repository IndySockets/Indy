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

unit IdOpenSSLHeaders_uierr;

interface

// Headers for OpenSSL 1.1.1
// uierr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * UI function codes.
   *)
  UI_F_CLOSE_CONSOLE = 115;
  UI_F_ECHO_CONSOLE = 116;
  UI_F_GENERAL_ALLOCATE_BOOLEAN = 108;
  UI_F_GENERAL_ALLOCATE_PROMPT = 109;
  UI_F_NOECHO_CONSOLE = 117;
  UI_F_OPEN_CONSOLE = 114;
  UI_F_UI_CONSTRUCT_PROMPT = 121;
  UI_F_UI_CREATE_METHOD = 112;
  UI_F_UI_CTRL = 111;
  UI_F_UI_DUP_ERROR_STRING = 101;
  UI_F_UI_DUP_INFO_STRING = 102;
  UI_F_UI_DUP_INPUT_BOOLEAN = 110;
  UI_F_UI_DUP_INPUT_STRING = 103;
  UI_F_UI_DUP_USER_DATA = 118;
  UI_F_UI_DUP_VERIFY_STRING = 106;
  UI_F_UI_GET0_RESULT = 107;
  UI_F_UI_GET_RESULT_LENGTH = 119;
  UI_F_UI_NEW_METHOD = 104;
  UI_F_UI_PROCESS = 113;
  UI_F_UI_SET_RESULT = 105;
  UI_F_UI_SET_RESULT_EX = 120;

  (*
   * UI reason codes.
   *)
  UI_R_COMMON_OK_AND_CANCEL_CHARACTERS = 104;
  UI_R_INDEX_TOO_LARGE = 102;
  UI_R_INDEX_TOO_SMALL = 103;
  UI_R_NO_RESULT_BUFFER = 105;
  UI_R_PROCESSING_ERROR = 107;
  UI_R_RESULT_TOO_LARGE = 100;
  UI_R_RESULT_TOO_SMALL = 101;
  UI_R_SYSASSIGN_ERROR = 109;
  UI_R_SYSDASSGN_ERROR = 110;
  UI_R_SYSQIOW_ERROR = 111;
  UI_R_UNKNOWN_CONTROL_COMMAND = 106;
  UI_R_UNKNOWN_TTYGET_ERRNO_VALUE = 108;
  UI_R_USER_DATA_DUPLICATION_UNSUPPORTED = 112;

var
  function ERR_load_UI_strings: TIdC_INT;

implementation

end.
