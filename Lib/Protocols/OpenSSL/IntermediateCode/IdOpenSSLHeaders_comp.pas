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

unit IdOpenSSLHeaders_comp;

interface

// Headers for OpenSSL 1.1.1
// comp.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ;

var
  function COMP_CTX_new(meth: PCOMP_METHOD): PCOMP_CTX;
  function COMP_CTX_get_method(const ctx: PCOMP_CTX): PCOMP_METHOD;
  function COMP_CTX_get_type(const comp: PCOMP_CTX): TIdC_INT;
  function COMP_get_type(const meth: PCOMP_METHOD): TIdC_INT;
  function COMP_get_name(const meth: PCOMP_METHOD): PIdAnsiChar;
  procedure COMP_CTX_free(ctx: PCOMP_CTX);

  function COMP_compress_block(ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT;
  function COMP_expand_block(ctx: PCOMP_CTX; out_: PByte; olen: TIdC_INT; in_: PByte; ilen: TIdC_INT): TIdC_INT;

  function COMP_zlib: PCOMP_METHOD;

  function BIO_f_zlib: PBIO_METHOD;

implementation

end.
