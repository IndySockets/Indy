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

unit IdOpenSSLHeaders_sha;

interface

// Headers for OpenSSL 1.1.1
// sha.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  SHA_LBLOCK = 16;
  SHA_CBLOCK = SHA_LBLOCK * 4;

  SHA_LAST_BLOCK = SHA_CBLOCK - 8;
  SHA_DIGEST_LENGTH = 20;

  SHA256_CBLOCK = SHA_LBLOCK * 4;

  SHA224_DIGEST_LENGTH = 28;
  SHA256_DIGEST_LENGTH = 32;
  SHA384_DIGEST_LENGTH = 48;
  SHA512_DIGEST_LENGTH = 64;

  SHA512_CBLOCK = SHA_LBLOCK * 8;

type
  SHA_LONG = TIdC_UINT;

  SHAstate_sf = record
    h0, h1, h2, h3, h4: SHA_LONG;
    Nl, Nh: SHA_LONG;
    data: array[0 .. SHA_LAST_BLOCK - 1] of SHA_LONG;
    num: TIdC_UINT;
  end;
  SHA_CTX = SHAstate_sf;
  PSHA_CTX = ^SHA_CTX;

  SHAstate256_sf = record
    h: array[0..7] of SHA_LONG;
    Nl, Nh: SHA_LONG;
    data: array[0 .. SHA_LAST_BLOCK - 1] of SHA_LONG;
    num, md_len: TIdC_UINT;
  end;
  SHA256_CTX = SHAstate256_sf;
  PSHA256_CTX = ^SHA256_CTX;

  SHA_LONG64 = TIdC_UINT64;

  SHA512state_st_u = record
    case Integer of
    0: (d: array[0 .. SHA_LBLOCK - 1] of SHA_LONG64);
    1: (p: array[0 .. SHA512_CBLOCK - 1] of Byte);
  end;

  SHA512state_st = record
    h: array[0..7] of SHA_LONG64;
    Nl, Nh: SHA_LONG64;
    u: SHA512state_st_u;
    num, md_len: TIdC_UINT;
  end;
  SHA512_CTX = SHA512state_st;
  PSHA512_CTX = ^SHA512_CTX;

var
  function SHA1_Init(c: PSHA_CTX): TIdC_INT;
  function SHA1_Update(c: PSHA_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT;
  function SHA1_Final(md: PByte; c: PSHA_CTX): TIdC_INT;
  function SHA1(const d: PByte; n: TIdC_SIZET; md: PByte): PByte;
  procedure SHA1_Transform(c: PSHA_CTX; const data: PByte);

  function SHA224_Init(c: PSHA256_CTX): TIdC_INT;
  function SHA224_Update(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT;
  function SHA224_Final(md: PByte; c: PSHA256_CTX): TIdC_INT;
  function SHA224(const d: PByte; n: TIdC_SIZET; md: PByte): PByte;

  function SHA256_Init(c: PSHA256_CTX): TIdC_INT;
  function SHA256_Update(c: PSHA256_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT;
  function SHA256_Final(md: PByte; c: PSHA256_CTX): TIdC_INT;
  function SHA256(const d: PByte; n: TIdC_SIZET; md: PByte): PByte;
  procedure SHA256_Transform(c: PSHA256_CTX; const data: PByte);

  function SHA384_Init(c: PSHA512_CTX): TIdC_INT;
  function SHA384_Update(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT;
  function SHA384_Final(md: PByte; c: PSHA512_CTX): TIdC_INT;
  function SHA384(const d: PByte; n: TIdC_SIZET; md: PByte): PByte;

  function SHA512_Init(c: PSHA512_CTX): TIdC_INT;
  function SHA512_Update(c: PSHA512_CTX; const data: Pointer; len: TIdC_SIZET): TIdC_INT;
  function SHA512_Final(md: PByte; c: PSHA512_CTX): TIdC_INT;
  function SHA512(const d: PByte; n: TIdC_SIZET; md: PByte): PByte;
  procedure SHA512_Transform(c: PSHA512_CTX; const data: PByte);

implementation

end.
