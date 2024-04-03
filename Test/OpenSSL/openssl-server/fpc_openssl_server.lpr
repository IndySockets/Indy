program fpc_openssl_server;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, TestServer;

var
  Application: TOpenSSLServerTest;
begin
  Application:=TOpenSSLServerTest.Create(nil);
  Application.Title:='Open SSL Server Test';
  Application.Run;
  Application.Free;
end.

