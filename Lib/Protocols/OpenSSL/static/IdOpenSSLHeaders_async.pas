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

unit IdOpenSSLHeaders_async;

interface

// Headers for OpenSSL 1.1.1
// async.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  ASYNC_ERR = 0;
  ASYNC_NO_JOBS = 0;
  ASYNC_PAUSE = 2;
  ASYNC_FINISH = 3;

type
  async_job_st = type Pointer;
  ASYNC_JOB = async_job_st;
  PASYNC_JOB = ^ASYNC_JOB;
  PPASYNC_JOB = ^PASYNC_JOB;
  
  async_wait_ctx_st = type Pointer;
  ASYNC_WAIT_CTX = async_wait_ctx_st;
  PASYNC_WAIT_CTX = ^ASYNC_WAIT_CTX;
  
  OSSL_ASYNC_FD = type TIdC_INT;
  POSSL_ASYNC_FD = ^OSSL_ASYNC_FD;

  ASYNC_WAIT_CTX_set_wait_fd_cleanup = procedure(v1: PASYNC_WAIT_CTX;
    const v2: Pointer; v3: OSSL_ASYNC_FD; v4: Pointer);
  ASYNC_start_job_cb = function(v1: Pointer): TIdC_INT;

  function ASYNC_init_thread(max_size: TIdC_SIZET; init_size: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  procedure ASYNC_cleanup_thread cdecl; external CLibCrypto;

  function ASYNC_WAIT_CTX_new: PASYNC_WAIT_CTX cdecl; external CLibCrypto;
  procedure ASYNC_WAIT_CTX_free(ctx: PASYNC_WAIT_CTX) cdecl; external CLibCrypto;
  function ASYNC_WAIT_CTX_set_wait_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: OSSL_ASYNC_FD; custom_data: Pointer; cleanup_cb: ASYNC_WAIT_CTX_set_wait_fd_cleanup): TIdC_INT cdecl; external CLibCrypto;
  function ASYNC_WAIT_CTX_get_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: POSSL_ASYNC_FD; custom_data: PPointer): TIdC_INT cdecl; external CLibCrypto;
  function ASYNC_WAIT_CTX_get_all_fds(ctx: PASYNC_WAIT_CTX; fd: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function ASYNC_WAIT_CTX_get_changed_fds(ctx: PASYNC_WAIT_CTX; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function ASYNC_WAIT_CTX_clear_fd(ctx: PASYNC_WAIT_CTX; const key: Pointer): TIdC_INT cdecl; external CLibCrypto;

  function ASYNC_is_capable: TIdC_INT cdecl; external CLibCrypto;

  function ASYNC_start_job(job: PPASYNC_JOB; ctx: PASYNC_WAIT_CTX; ret: PIdC_INT; func: ASYNC_start_job_cb; args: Pointer; size: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function ASYNC_pause_job: TIdC_INT cdecl; external CLibCrypto;

  function ASYNC_get_current_job: PASYNC_JOB cdecl; external CLibCrypto;
  function ASYNC_get_wait_ctx(job: PASYNC_JOB): PASYNC_WAIT_CTX cdecl; external CLibCrypto;
  procedure ASYNC_block_pause cdecl; external CLibCrypto;
  procedure ASYNC_unblock_pause cdecl; external CLibCrypto;

implementation

end.
