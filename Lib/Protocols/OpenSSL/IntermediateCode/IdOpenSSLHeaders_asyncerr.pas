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

unit IdOpenSSLHeaders_asyncerr;

interface

// Headers for OpenSSL 1.1.1
// asyncerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  //
  // ASYNC function codes.
  //
  ASYNC_F_ASYNC_CTX_NEW                            = 100;
  ASYNC_F_ASYNC_INIT_THREAD                        = 101;
  ASYNC_F_ASYNC_JOB_NEW                            = 102;
  ASYNC_F_ASYNC_PAUSE_JOB                          = 103;
  ASYNC_F_ASYNC_START_FUNC                         = 104;
  ASYNC_F_ASYNC_START_JOB                          = 105;
  ASYNC_F_ASYNC_WAIT_CTX_SET_WAIT_FD               = 106;

  //
  // ASYNC reason codes.
  //
  ASYNC_R_FAILED_TO_SET_POOL                       = 101;
  ASYNC_R_FAILED_TO_SWAP_CONTEXT                   = 102;
  ASYNC_R_INIT_FAILED                              = 105;
  ASYNC_R_INVALID_POOL_SIZE                        = 103;

var
  function ERR_load_ASYNC_strings: TIdC_INT;

implementation

end.
