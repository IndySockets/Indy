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

unit IdOpenSSLHeaders_randerr;

interface

// Headers for OpenSSL 1.1.1
// randerr.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * RAND function codes.
   *)
  RAND_F_DRBG_BYTES = 101;
  RAND_F_DRBG_GET_ENTROPY = 105;
  RAND_F_DRBG_SETUP = 117;
  RAND_F_GET_ENTROPY = 106;
  RAND_F_RAND_BYTES = 100;
  RAND_F_RAND_DRBG_ENABLE_LOCKING = 119;
  RAND_F_RAND_DRBG_GENERATE = 107;
  RAND_F_RAND_DRBG_GET_ENTROPY = 120;
  RAND_F_RAND_DRBG_GET_NONCE = 123;
  RAND_F_RAND_DRBG_INSTANTIATE = 108;
  RAND_F_RAND_DRBG_NEW = 109;
  RAND_F_RAND_DRBG_RESEED = 110;
  RAND_F_RAND_DRBG_RESTART = 102;
  RAND_F_RAND_DRBG_SET = 104;
  RAND_F_RAND_DRBG_SET_DEFAULTS = 121;
  RAND_F_RAND_DRBG_UNINSTANTIATE = 118;
  RAND_F_RAND_LOAD_FILE = 111;
  RAND_F_RAND_POOL_ACQUIRE_ENTROPY = 122;
  RAND_F_RAND_POOL_ADD = 103;
  RAND_F_RAND_POOL_ADD_BEGIN = 113;
  RAND_F_RAND_POOL_ADD_END = 114;
  RAND_F_RAND_POOL_ATTACH = 124;
  RAND_F_RAND_POOL_BYTES_NEEDED = 115;
  RAND_F_RAND_POOL_GROW = 125;
  RAND_F_RAND_POOL_NEW = 116;
  RAND_F_RAND_WRITE_FILE = 112;

  (*
   * RAND reason codes.
   *)
  RAND_R_ADDITIONAL_INPUT_TOO_LONG = 102;
  RAND_R_ALREADY_INSTANTIATED = 103;
  RAND_R_ARGUMENT_OUT_OF_RANGE = 105;
  RAND_R_CANNOT_OPEN_FILE = 121;
  RAND_R_DRBG_ALREADY_INITIALIZED = 129;
  RAND_R_DRBG_NOT_INITIALISED = 104;
  RAND_R_ENTROPY_INPUT_TOO_LONG = 106;
  RAND_R_ENTROPY_OUT_OF_RANGE = 124;
  RAND_R_ERROR_ENTROPY_POOL_WAS_IGNORED = 127;
  RAND_R_ERROR_INITIALISING_DRBG = 107;
  RAND_R_ERROR_INSTANTIATING_DRBG = 108;
  RAND_R_ERROR_RETRIEVING_ADDITIONAL_INPUT = 109;
  RAND_R_ERROR_RETRIEVING_ENTROPY = 110;
  RAND_R_ERROR_RETRIEVING_NONCE = 111;
  RAND_R_FAILED_TO_CREATE_LOCK = 126;
  RAND_R_FUNC_NOT_IMPLEMENTED = 101;
  RAND_R_FWRITE_ERROR = 123;
  RAND_R_GENERATE_ERROR = 112;
  RAND_R_INTERNAL_ERROR = 113;
  RAND_R_IN_ERROR_STATE = 114;
  RAND_R_NOT_A_REGULAR_FILE = 122;
  RAND_R_NOT_INSTANTIATED = 115;
  RAND_R_NO_DRBG_IMPLEMENTATION_SELECTED = 128;
  RAND_R_PARENT_LOCKING_NOT_ENABLED = 130;
  RAND_R_PARENT_STRENGTH_TOO_WEAK = 131;
  RAND_R_PERSONALISATION_STRING_TOO_LONG = 116;
  RAND_R_PREDICTION_RESISTANCE_NOT_SUPPORTED = 133;
  RAND_R_PRNG_NOT_SEEDED = 100;
  RAND_R_RANDOM_POOL_OVERFLOW = 125;
  RAND_R_RANDOM_POOL_UNDERFLOW = 134;
  RAND_R_REQUEST_TOO_LARGE_FOR_DRBG = 117;
  RAND_R_RESEED_ERROR = 118;
  RAND_R_SELFTEST_FAILURE = 119;
  RAND_R_TOO_LITTLE_NONCE_REQUESTED = 135;
  RAND_R_TOO_MUCH_NONCE_REQUESTED = 136;
  RAND_R_UNSUPPORTED_DRBG_FLAGS = 132;
  RAND_R_UNSUPPORTED_DRBG_TYPE = 120;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  ERR_load_RAND_strings: function: TIdC_INT cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ERR_load_RAND_strings := LoadFunction('ERR_load_RAND_strings', AFailed);
end;

procedure UnLoad;
begin
  ERR_load_RAND_strings := nil;
end;

end.
