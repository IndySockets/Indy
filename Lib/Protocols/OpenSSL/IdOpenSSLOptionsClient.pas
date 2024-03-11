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
  CDefaultVerifyHostName = True;

type
  TIdOpenSSLOptionsClient = class(TIdOpenSSLOptionsBase)
  private
    FVerifyServerCertificate: Boolean;
    FVerifyHostName: Boolean;
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
    /// <summary>
    ///   Verify if the certificate Subject Alternative Name (SAN) or Subject CommonName (CN)
    ///   matches the specified hostname.
    /// </summary>
    /// <remarks>
    ///   Subject CommonName (CN) will only be used if no Subject Alternative Name (SAN) is present.
    ///   Wildcards are supported.
    /// </remarks>
    property VerifyHostName: Boolean read FVerifyHostName write FVerifyHostName;
  end;

  TIdOpenSSLOptionsClientClass = class of TIdOpenSSLOptionsClient;

implementation

{ TIdOpenSSLOptionsClient }

procedure TIdOpenSSLOptionsClient.AssignTo(Dest: TPersistent);
var
  LDest: TIdOpenSSLOptionsClient;
begin
  inherited;
  if Dest is TIdOpenSSLOptionsClient then
  begin
    LDest := TIdOpenSSLOptionsClient(Dest);
    LDest.FVerifyServerCertificate := FVerifyServerCertificate;
    LDest.FVerifyHostName := FVerifyHostName;
  end;
end;

constructor TIdOpenSSLOptionsClient.Create;
begin
  inherited;
  FVerifyServerCertificate := CDefaultVerifyServerCertificate;
  FVerifyHostName := CDefaultVerifyHostName;
end;

function TIdOpenSSLOptionsClient.Equals(Obj: TObject): Boolean;
var
  LObj: TIdOpenSSLOptionsClient;
begin
  Result := inherited Equals(Obj);
  if Result and (Obj is TIdOpenSSLOptionsClient) then
  begin
    LObj := TIdOpenSSLOptionsClient(Obj);
    Result := (FVerifyServerCertificate = LObj.FVerifyServerCertificate)
      and (FVerifyHostName = LObj.FVerifyHostName);
  end;
end;

end.
