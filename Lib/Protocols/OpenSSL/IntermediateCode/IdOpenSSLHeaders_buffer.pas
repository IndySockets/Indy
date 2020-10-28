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

unit IdOpenSSLHeaders_buffer;

interface

// Headers for OpenSSL 1.1.1
// buffer.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  BUF_MEM_FLAG_SECURE = $01;

type
  buf_mem_st = record
    length: TIdC_SIZET;
    data: PIdAnsiChar;
    max: TIdC_SIZET;
    flags: TIdC_ULONG;
  end;

var
  function BUF_MEM_new: PBUF_MEM;
  function BUF_MEM_new_ex(flags: TIdC_ULONG): PBUF_MEM;
  procedure BUF_MEM_free(a: PBUF_MEM);
  function BUF_MEM_grow(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET;
  function BUF_MEM_grow_clean(str: PBUF_MEM; len: TIdC_SIZET): TIdC_SIZET;
  procedure BUF_reverse(&out: PByte; const in_: PByte; siz: TIdC_SIZET);

implementation

end.
