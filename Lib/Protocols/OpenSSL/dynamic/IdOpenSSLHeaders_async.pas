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

unit IdOpenSSLHeaders_async;

interface

// Headers for OpenSSL 1.1.1
// async.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  ASYNC_init_thread: function(max_size: TIdC_SIZET; init_size: TIdC_SIZET): TIdC_INT cdecl = nil;
  ASYNC_cleanup_thread: procedure cdecl = nil;

  ASYNC_WAIT_CTX_new: function: PASYNC_WAIT_CTX cdecl = nil;
  ASYNC_WAIT_CTX_free: procedure(ctx: PASYNC_WAIT_CTX) cdecl = nil;
  ASYNC_WAIT_CTX_set_wait_fd: function(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: OSSL_ASYNC_FD; custom_data: Pointer; cleanup_cb: ASYNC_WAIT_CTX_set_wait_fd_cleanup): TIdC_INT cdecl = nil;
  ASYNC_WAIT_CTX_get_fd: function(ctx: PASYNC_WAIT_CTX; const key: Pointer; fd: POSSL_ASYNC_FD; custom_data: PPointer): TIdC_INT cdecl = nil;
  ASYNC_WAIT_CTX_get_all_fds: function(ctx: PASYNC_WAIT_CTX; fd: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT cdecl = nil;
  ASYNC_WAIT_CTX_get_changed_fds: function(ctx: PASYNC_WAIT_CTX; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT cdecl = nil;
  ASYNC_WAIT_CTX_clear_fd: function(ctx: PASYNC_WAIT_CTX; const key: Pointer): TIdC_INT cdecl = nil;

  ASYNC_is_capable: function: TIdC_INT cdecl = nil;

  ASYNC_start_job: function(job: PPASYNC_JOB; ctx: PASYNC_WAIT_CTX; ret: PIdC_INT; func: ASYNC_start_job_cb; args: Pointer; size: TIdC_SIZET): TIdC_INT cdecl = nil;
  ASYNC_pause_job: function: TIdC_INT cdecl = nil;

  ASYNC_get_current_job: function: PASYNC_JOB cdecl = nil;
  ASYNC_get_wait_ctx: function(job: PASYNC_JOB): PASYNC_WAIT_CTX cdecl = nil;
  ASYNC_block_pause: procedure cdecl = nil;
  ASYNC_unblock_pause: procedure cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ASYNC_init_thread := LoadFunction('ASYNC_init_thread', AFailed);
  ASYNC_cleanup_thread := LoadFunction('ASYNC_cleanup_thread', AFailed);
  ASYNC_WAIT_CTX_new := LoadFunction('ASYNC_WAIT_CTX_new', AFailed);
  ASYNC_WAIT_CTX_free := LoadFunction('ASYNC_WAIT_CTX_free', AFailed);
  ASYNC_WAIT_CTX_set_wait_fd := LoadFunction('ASYNC_WAIT_CTX_set_wait_fd', AFailed);
  ASYNC_WAIT_CTX_get_fd := LoadFunction('ASYNC_WAIT_CTX_get_fd', AFailed);
  ASYNC_WAIT_CTX_get_all_fds := LoadFunction('ASYNC_WAIT_CTX_get_all_fds', AFailed);
  ASYNC_WAIT_CTX_get_changed_fds := LoadFunction('ASYNC_WAIT_CTX_get_changed_fds', AFailed);
  ASYNC_WAIT_CTX_clear_fd := LoadFunction('ASYNC_WAIT_CTX_clear_fd', AFailed);
  ASYNC_is_capable := LoadFunction('ASYNC_is_capable', AFailed);
  ASYNC_start_job := LoadFunction('ASYNC_start_job', AFailed);
  ASYNC_pause_job := LoadFunction('ASYNC_pause_job', AFailed);
  ASYNC_get_current_job := LoadFunction('ASYNC_get_current_job', AFailed);
  ASYNC_get_wait_ctx := LoadFunction('ASYNC_get_wait_ctx', AFailed);
  ASYNC_block_pause := LoadFunction('ASYNC_block_pause', AFailed);
  ASYNC_unblock_pause := LoadFunction('ASYNC_unblock_pause', AFailed);
end;

procedure UnLoad;
begin
  ASYNC_init_thread := nil;
  ASYNC_cleanup_thread := nil;
  ASYNC_WAIT_CTX_new := nil;
  ASYNC_WAIT_CTX_free := nil;
  ASYNC_WAIT_CTX_set_wait_fd := nil;
  ASYNC_WAIT_CTX_get_fd := nil;
  ASYNC_WAIT_CTX_get_all_fds := nil;
  ASYNC_WAIT_CTX_get_changed_fds := nil;
  ASYNC_WAIT_CTX_clear_fd := nil;
  ASYNC_is_capable := nil;
  ASYNC_start_job := nil;
  ASYNC_pause_job := nil;
  ASYNC_get_current_job := nil;
  ASYNC_get_wait_ctx := nil;
  ASYNC_block_pause := nil;
  ASYNC_unblock_pause := nil;
end;

end.
