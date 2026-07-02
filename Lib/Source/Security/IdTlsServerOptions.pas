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

  Rev 1.0    27-03-05 09:09:02  MterWoord
  Created
}

unit IdTlsServerOptions;

interface

uses
  Mono.Security.Protocol.Tls, Mono.Security.Authenticode, System.Security.Cryptography.X509Certificates;

type
  TIdTlsServerOptions = class
  private
    FPrivateKey: PrivateKey;
    FPublicCertificate: X509Certificate;
    FProtocol: SecurityProtocolType;
    FClientNeedsCertificate: Boolean;
    procedure SetClientNeedsCertificate(const Value: Boolean);
    procedure SetPrivateKey(const Value: PrivateKey);
    procedure SetProtocol(const Value: SecurityProtocolType);
    procedure SetPublicCertificate(const Value: X509Certificate);
  public
    constructor Create;
    procedure LoadPublicCertificateFromFile(AFileName: string);
    procedure LoadPrivateKeyFromFile(AFileName: string; APassword: string = '');
  published
    property PublicCertificate: X509Certificate read FPublicCertificate write SetPublicCertificate;
    property PrivateKey: PrivateKey read FPrivateKey write SetPrivateKey;
    property Protocol: SecurityProtocolType read FProtocol write SetProtocol;
    property ClientNeedsCertificate: Boolean read FClientNeedsCertificate write SetClientNeedsCertificate;
  end;

implementation

{ TIdTlsServerOptions }

procedure TIdTlsServerOptions.SetPrivateKey(const Value: PrivateKey);
begin
  FPrivateKey := Value;
end;

procedure TIdTlsServerOptions.SetPublicCertificate(const Value: X509Certificate);
begin
  FPublicCertificate := Value;
end;

procedure TIdTlsServerOptions.SetProtocol(const Value: SecurityProtocolType);
begin
  FProtocol := Value;
end;

procedure TIdTlsServerOptions.SetClientNeedsCertificate(const Value: Boolean);
begin
  FClientNeedsCertificate := Value;
end;

constructor TIdTlsServerOptions.Create;
begin
  inherited;
  FProtocol := SecurityProtocolType.Tls;
	FClientNeedsCertificate := False;
end;

procedure TIdTlsServerOptions.LoadPrivateKeyFromFile(AFileName,
  APassword: string);
begin
  if APassword = '' then
  begin
    FPrivateKey := Mono.Security.Authenticode.PrivateKey.CreateFromFile(AFileName);
  end
  else
  begin
    FPrivateKey := Mono.Security.Authenticode.PrivateKey.CreateFromFile(AFileName, APassword);
  end;
end;

procedure TIdTlsServerOptions.LoadPublicCertificateFromFile(AFileName: string);
begin
  FPublicCertificate := X509Certificate.CreateFromCertFile(AFileName);
end;

end.
