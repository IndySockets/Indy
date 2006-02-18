{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.0    27-03-05 10:04:26  MterWoord
  Second import, first time the filenames weren't prefixed with Id

  Rev 1.0    27-03-05 09:09:00  MterWoord
  Created
}

unit IdTlsClientOptions;

interface

uses
  Mono.Security.Protocol.Tls, System.Security.Cryptography.X509Certificates;

type
  TIdTlsClientOptions = class
  private
    FProtocol: SecurityProtocolType;
    FCertificateCollection: X509CertificateCollection;
    procedure SetProtocol(const Value: SecurityProtocolType);
  public
    constructor Create;
    procedure set_CertificateCollection(const Value: X509CertificateCollection);
  published
    property Protocol: SecurityProtocolType read FProtocol write SetProtocol;
    property CertificateCollection: X509CertificateCollection read FCertificateCollection write set_CertificateCollection;
  end;

implementation

{ TIdTlsServerOptions }

procedure TIdTlsClientOptions.SetProtocol(const Value: SecurityProtocolType);
begin
  FProtocol := Value;
end;

constructor TIdTlsClientOptions.Create;
begin
  inherited;
  FProtocol := SecurityProtocolType.Tls;
end;

procedure TIdTlsClientOptions.set_CertificateCollection(
  const Value: X509CertificateCollection);
begin
  FCertificateCollection := Value;
end;

end.
