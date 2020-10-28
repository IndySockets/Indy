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

unit IdOpenSSLOptionsClient;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdOpenSSLOptions;

const
  CDefaultVerifyServerCertificate = True;

type
  TIdOpenSSLOptionsClient = class(TIdOpenSSLOptionsBase)
  private
    FVerifyServerCertificate: Boolean;
  public
    constructor Create; override;

    procedure AssignTo(Dest: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
  published
    /// <summary>
    ///   Verify the server certificate.
    /// </summary>
    /// <remarks>
    ///   If the verification process fails, the TLS/SSL handshake is
    ///   immediately terminated with an alert message containing the reason for
    ///   the verification failure. If no server certificate is sent, because an
    ///   anonymous cipher is used, this option is ignored.
    /// </remarks>
    property VerifyServerCertificate: Boolean read FVerifyServerCertificate write FVerifyServerCertificate default CDefaultVerifyServerCertificate;
  end;

  TIdOpenSSLOptionsClientClass = class of TIdOpenSSLOptionsClient;

implementation

{ TIdOpenSSLOptionsClient }

procedure TIdOpenSSLOptionsClient.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Dest is TIdOpenSSLOptionsClient then
    TIdOpenSSLOptionsClient(Dest).FVerifyServerCertificate := FVerifyServerCertificate;
end;

constructor TIdOpenSSLOptionsClient.Create;
begin
  inherited;
  FVerifyServerCertificate := CDefaultVerifyServerCertificate;
end;

function TIdOpenSSLOptionsClient.Equals(Obj: TObject): Boolean;
begin
  Result := inherited Equals(Obj);
  if Result and (Obj is TIdOpenSSLOptionsClient) then
    Result := FVerifyServerCertificate = TIdOpenSSLOptionsClient(Obj).FVerifyServerCertificate;
end;

end.
