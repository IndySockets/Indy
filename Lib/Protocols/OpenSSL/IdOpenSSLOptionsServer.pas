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

unit IdOpenSSLOptionsServer;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdOpenSSLOptions;

const
  CDefaultRequestCertificate = False;
  CDefaultFailIfNoPeerCertificate = False;
  CDefaultRequestCertificateOnlyOnce = False;

type
  TIdOpenSSLOptionsServer = class(TIdOpenSSLOptionsBase)
  private
    FRequestCertificate: Boolean;
    FFailIfNoPeerCertificate: Boolean;
    FRequestCertificateOnlyOnce: Boolean;
  public
    constructor Create; override;

    procedure AssignTo(Dest: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
  published
    /// <summary>
    ///   The server sends a client certificate request to the client. The
    ///   certificate returned (if any) is checked. If the verification process
    ///   fails, the TLS/SSL handshake is immediately terminated with an alert
    ///   message containing the reason for the verification failure.
    /// </summary>
    property RequestCertificate: Boolean read FRequestCertificate write FRequestCertificate default CDefaultRequestCertificate;

    /// <summary>
    ///   If the client did not return a certificate, the TLS/SSL handshake is
    ///   immediately terminated with a "handshake failure" alert.
    /// </summary>
    /// <remarks>
    ///   Will be ignored if <see cref="RequestCertificate"/> is False.
    /// </remarks>
    property FailIfNoPeerCertificate: Boolean read FFailIfNoPeerCertificate write FFailIfNoPeerCertificate default CDefaultFailIfNoPeerCertificate;

    /// <summary>
    ///   Only request a client certificate once during the connection. Do not
    ///   ask for a client certificate again during renegotiation or
    ///   post-authentication if a certificate was requested during the initial
    ///   handshake.
    /// </summary>
    /// <remarks>
    ///   Will be ignored if <see cref="RequestCertificate"/> is False.
    /// </remarks>
    property RequestCertificateOnlyOnce: Boolean read FRequestCertificateOnlyOnce write FRequestCertificateOnlyOnce default CDefaultRequestCertificateOnlyOnce;
  end;

  TIdOpenSSLOptionsServerClass = class of TIdOpenSSLOptionsServer;

implementation

{ TIdOpenSSLOptionsServer }

procedure TIdOpenSSLOptionsServer.AssignTo(Dest: TPersistent);
var
  LDest: TIdOpenSSLOptionsServer;
begin
  inherited;
  if Dest is TIdOpenSSLOptionsServer then
  begin
    LDest := TIdOpenSSLOptionsServer(Dest);
    LDest.FRequestCertificate := FRequestCertificate;
    LDest.FFailIfNoPeerCertificate := FFailIfNoPeerCertificate;
    LDest.FRequestCertificateOnlyOnce := FRequestCertificateOnlyOnce;
  end;
end;

constructor TIdOpenSSLOptionsServer.Create;
begin
  inherited;
  FRequestCertificate := CDefaultRequestCertificate;
  FFailIfNoPeerCertificate := CDefaultFailIfNoPeerCertificate;
  FRequestCertificateOnlyOnce := CDefaultRequestCertificateOnlyOnce;
end;

function TIdOpenSSLOptionsServer.Equals(Obj: TObject): Boolean;
var
  LObj: TIdOpenSSLOptionsServer;
begin
  Result := inherited Equals(Obj);
  if Result and (Obj is TIdOpenSSLOptionsServer) then
  begin
    LObj := TIdOpenSSLOptionsServer(Obj);
    Result := (FRequestCertificate = LObj.FRequestCertificate)
      and (FFailIfNoPeerCertificate = LObj.FFailIfNoPeerCertificate)
      and (FRequestCertificateOnlyOnce = LObj.FRequestCertificateOnlyOnce);
  end;
end;

end.
