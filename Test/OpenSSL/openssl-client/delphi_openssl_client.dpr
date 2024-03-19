program delphi_openssl_client;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TestClient in 'TestClient.pas',
  IdSSLOpenSSL in '..\..\..\runtime\protocols\IdSSLOpenSSL.pas',
  IdSSLOpenSSLLoader in '..\..\..\runtime\protocols\IdSSLOpenSSLLoader.pas';

var
  Application: TBasicHttpsClient;
begin
  Application:=TBasicHttpsClient.Create(nil);
  Application.Title:='Basic Https Client Test';
  Application.Run;
  Application.Free;
end.

end.
