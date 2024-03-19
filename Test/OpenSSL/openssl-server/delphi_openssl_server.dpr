program delphi_openssl_server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  testserver in 'testserver.pas',
  IdSSLOpenSSL in '..\..\..\runtime\protocols\IdSSLOpenSSL.pas';

var
  Application: TOpenSSLServerTest;
begin
  Application:=TOpenSSLServerTest.Create(nil);
  Application.Title:='Open SSL Server Test';
  Application.Run;
  Application.Free;
end.
