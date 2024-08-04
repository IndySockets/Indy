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

// Generation date: 06.11.2020 07:16:52

unit IdOpenSSLHeaders_cmac;

interface

// Headers for OpenSSL 1.1.1
// cmac.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_ossl_typ;

//* Opaque */
type
  CMAC_CTX_st = type Pointer;
  CMAC_CTX = CMAC_CTX_st;
  PCMAC_CTX = ^CMAC_CTX;

  function CMAC_CTX_new: PCMAC_CTX cdecl; external CLibCrypto;
  procedure CMAC_CTX_cleanup(ctx: PCMAC_CTX) cdecl; external CLibCrypto;
  procedure CMAC_CTX_free(ctx: PCMAC_CTX) cdecl; external CLibCrypto;
  function CMAC_CTX_get0_cipher_ctx(ctx: PCMAC_CTX): PEVP_CIPHER_CTX cdecl; external CLibCrypto;
  function CMAC_CTX_copy(out_: PCMAC_CTX; const in_: PCMAC_CTX): TIdC_INT cdecl; external CLibCrypto;
  function CMAC_Init(ctx: PCMAC_CTX; const key: Pointer; keylen: TIdC_SIZET; const cipher: PEVP_Cipher; impl: PENGINe): TIdC_INT cdecl; external CLibCrypto;
  function CMAC_Update(ctx: PCMAC_CTX; const data: Pointer; dlen: TIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function CMAC_Final(ctx: PCMAC_CTX; out_: PByte; poutlen: PIdC_SIZET): TIdC_INT cdecl; external CLibCrypto;
  function CMAC_resume(ctx: PCMAC_CTX): TIdC_INT cdecl; external CLibCrypto;


implementation

end.
