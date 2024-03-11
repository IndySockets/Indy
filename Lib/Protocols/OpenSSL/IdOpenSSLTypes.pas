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

unit IdOpenSSLTypes;

interface

uses
  IdOpenSSLX509;

{$i IdCompilerDefines.inc}

type
  TGetPassword = procedure(Sender: TObject; var Password: string; const IsWrite: Boolean) of object;

  TKeyLog = procedure(Sender: TObject; const ALine: string) of object;

  /// <summary>
  ///   Callback type for custom x509 verification
  /// </summary>
  /// <param name="Sender">
  ///   <see cref="IdOpenSSLContext|TIdOpenSSLContext"/> which triggers this callback.
  /// </param>
  /// <param name="x509">
  ///   <see cref="IdOpenSSLX509|TIdOpenSSLX509"/> information about the current certificate.
  /// </param>
  /// <param name="VerifyResult">
  ///   The result code of the OpenSSL verification.
  ///   See IdOpenSSLHeaders_x509_vfy.<see cref="IdOpenSSLHeaders_x509_vfy|X509_V_OK"/> (0) and following for named constants.
  /// </param>
  /// <param name="Depth">
  ///   The depth of the current certificate. The depth count is
  ///   "level 0: peer certificate", "level 1: CA certificate",
  ///   "level 2: higher level CA certificate", and so on.
  /// </param>
  /// <param name="Accepted">
  ///   The validation result. Will be initialized with the result of the
  ///   OpenSSL verification result. To leave it unchanged is valid.
  /// </param>
  TVerifyCallback = procedure(
    Sender: TObject;
    const x509: TIdOpenSSLX509;
    const VerifyResult: Integer;
    const Depth: Integer;
    var Accepted: Boolean) of object;

implementation

end.
