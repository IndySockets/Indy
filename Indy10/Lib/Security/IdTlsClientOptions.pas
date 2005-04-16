{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  116694: IdTlsClientOptions.pas 
{
{   Rev 1.0    27-03-05 10:04:26  MterWoord
{ Second import, first time the filenames weren't prefixed with Id
}
{
{   Rev 1.0    27-03-05 09:09:00  MterWoord
{ Created
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
