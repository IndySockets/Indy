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

// Generation date: 27.04.2020 15:01:04

unit IdOpenSSLHeaders_kdferr;

interface

// Headers for OpenSSL 1.1.1
// kdferr.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * KDF function codes.
   *)
  KDF_F_PKEY_HKDF_CTRL_STR = 103;
  KDF_F_PKEY_HKDF_DERIVE = 102;
  KDF_F_PKEY_HKDF_INIT = 108;
  KDF_F_PKEY_SCRYPT_CTRL_STR = 104;
  KDF_F_PKEY_SCRYPT_CTRL_UINT64 = 105;
  KDF_F_PKEY_SCRYPT_DERIVE = 109;
  KDF_F_PKEY_SCRYPT_INIT = 106;
  KDF_F_PKEY_SCRYPT_SET_MEMBUF = 107;
  KDF_F_PKEY_TLS1_PRF_CTRL_STR = 100;
  KDF_F_PKEY_TLS1_PRF_DERIVE = 101;
  KDF_F_PKEY_TLS1_PRF_INIT = 110;
  KDF_F_TLS1_PRF_ALG = 111;

  (*
   * KDF reason codes.
   *)
  KDF_R_INVALID_DIGEST = 100;
  KDF_R_MISSING_ITERATION_COUNT = 109;
  KDF_R_MISSING_KEY = 104;
  KDF_R_MISSING_MESSAGE_DIGEST = 105;
  KDF_R_MISSING_PARAMETER = 101;
  KDF_R_MISSING_PASS = 110;
  KDF_R_MISSING_SALT = 111;
  KDF_R_MISSING_SECRET = 107;
  KDF_R_MISSING_SEED = 106;
  KDF_R_UNKNOWN_PARAMETER_TYPE = 103;
  KDF_R_VALUE_ERROR = 108;
  KDF_R_VALUE_MISSING = 102;

{$REGION 'Generated loading and unloading methods'}
procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;
{$ENDREGION}

var
  ERR_load_KDF_strings: function: TIdC_INT cdecl = nil;

implementation

{$REGION 'Generated loading and unloading methods'}
procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  ERR_load_KDF_strings := LoadFunction('ERR_load_KDF_strings', AFailed);
end;

procedure UnLoad;
begin
  ERR_load_KDF_strings := nil;
end;
{$ENDREGION}

end.
