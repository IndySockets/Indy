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

unit IdOpenSSLHeaders_bnerr;

interface

// Headers for OpenSSL 1.1.1
// bnerr.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * BN function codes.
   *)
  BN_F_BNRAND = 127;
  BN_F_BNRAND_RANGE = 138;
  BN_F_BN_BLINDING_CONVERT_EX = 100;
  BN_F_BN_BLINDING_CREATE_PARAM = 128;
  BN_F_BN_BLINDING_INVERT_EX = 101;
  BN_F_BN_BLINDING_NEW = 102;
  BN_F_BN_BLINDING_UPDATE = 103;
  BN_F_BN_BN2DEC = 104;
  BN_F_BN_BN2HEX = 105;
  BN_F_BN_COMPUTE_WNAF = 142;
  BN_F_BN_CTX_GET = 116;
  BN_F_BN_CTX_NEW = 106;
  BN_F_BN_CTX_START = 129;
  BN_F_BN_DIV = 107;
  BN_F_BN_DIV_RECP = 130;
  BN_F_BN_EXP = 123;
  BN_F_BN_EXPAND_INTERNAL = 120;
  BN_F_BN_GENCB_NEW = 143;
  BN_F_BN_GENERATE_DSA_NONCE = 140;
  BN_F_BN_GENERATE_PRIME_EX = 141;
  BN_F_BN_GF2M_MOD = 131;
  BN_F_BN_GF2M_MOD_EXP = 132;
  BN_F_BN_GF2M_MOD_MUL = 133;
  BN_F_BN_GF2M_MOD_SOLVE_QUAD = 134;
  BN_F_BN_GF2M_MOD_SOLVE_QUAD_ARR = 135;
  BN_F_BN_GF2M_MOD_SQR = 136;
  BN_F_BN_GF2M_MOD_SQRT = 137;
  BN_F_BN_LSHIFT = 145;
  BN_F_BN_MOD_EXP2_MONT = 118;
  BN_F_BN_MOD_EXP_MONT = 109;
  BN_F_BN_MOD_EXP_MONT_CONSTTIME = 124;
  BN_F_BN_MOD_EXP_MONT_WORD = 117;
  BN_F_BN_MOD_EXP_RECP = 125;
  BN_F_BN_MOD_EXP_SIMPLE = 126;
  BN_F_BN_MOD_INVERSE = 110;
  BN_F_BN_MOD_INVERSE_NO_BRANCH = 139;
  BN_F_BN_MOD_LSHIFT_QUICK = 119;
  BN_F_BN_MOD_SQRT = 121;
  BN_F_BN_MONT_CTX_NEW = 149;
  BN_F_BN_MPI2BN = 112;
  BN_F_BN_NEW = 113;
  BN_F_BN_POOL_GET = 147;
  BN_F_BN_RAND = 114;
  BN_F_BN_RAND_RANGE = 122;
  BN_F_BN_RECP_CTX_NEW = 150;
  BN_F_BN_RSHIFT = 146;
  BN_F_BN_SET_WORDS = 144;
  BN_F_BN_STACK_PUSH = 148;
  BN_F_BN_USUB = 115;

  (*
   * BN reason codes.
   *)
  BN_R_ARG2_LT_ARG3 = 100;
  BN_R_BAD_RECIPROCAL = 101;
  BN_R_BIGNUM_TOO_LONG = 114;
  BN_R_BITS_TOO_SMALL = 118;
  BN_R_CALLED_WITH_EVEN_MODULUS = 102;
  BN_R_DIV_BY_ZERO = 103;
  BN_R_ENCODING_ERROR = 104;
  BN_R_EXPAND_ON_STATIC_BIGNUM_DATA = 105;
  BN_R_INPUT_NOT_REDUCED = 110;
  BN_R_INVALID_LENGTH = 106;
  BN_R_INVALID_RANGE = 115;
  BN_R_INVALID_SHIFT = 119;
  BN_R_NOT_A_SQUARE = 111;
  BN_R_NOT_INITIALIZED = 107;
  BN_R_NO_INVERSE = 108;
  BN_R_NO_SOLUTION = 116;
  BN_R_PRIVATE_KEY_TOO_LARGE = 117;
  BN_R_P_IS_NOT_PRIME = 112;
  BN_R_TOO_MANY_ITERATIONS = 113;
  BN_R_TOO_MANY_TEMPORARY_VARIABLES = 109;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  ERR_load_BN_strings: function: TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ERR_load_BN_strings := LoadFunction('ERR_load_BN_strings', AFailed);
end;

procedure UnLoad;
begin
  ERR_load_BN_strings := nil;
end;

end.
