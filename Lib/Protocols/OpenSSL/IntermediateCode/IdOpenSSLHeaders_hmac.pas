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

unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

var
  function HMAC_size(const e: PHMAC_CTX): TIdC_SIZET;
  function HMAC_CTX_new: PHMAC_CTX;
  function HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT;
  procedure HMAC_CTX_free(ctx: PHMAC_CTX);

  function HMAC_Init_ex(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT;
  function HMAC_Update(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT;
  function HMAC_Final(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT;
  function HMAC(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte;
  function HMAC_CTX_copy(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT;

  procedure HMAC_CTX_set_flags(ctx: PHMAC_CTX; flags: TIdC_ULONG);
  function HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD;

implementation

end.
