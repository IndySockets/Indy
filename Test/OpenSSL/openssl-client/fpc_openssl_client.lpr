program fpc_openssl_client;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, TestClient;


var
  Application: TBasicHttpsClient;
begin
  Application:=TBasicHttpsClient.Create(nil);
  Application.Title:='Basic Https Client Test';
  Application.Run;
  Application.Free;
end.

