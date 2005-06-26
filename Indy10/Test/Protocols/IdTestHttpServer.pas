unit IdTestHttpServer;

interface

uses
  IdGlobal,
  IdContext,
  IdHttp,
  IdCustomHttpServer,
  IdHttpServer,
  IdHttpHeaderInfo,
  IdObjs,
  IdSys,
  IdTest;

type
  TIdTestHttpServer = class(TIdTest)
  private
    procedure HandleSimpleGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  published
    procedure TestSimpleGet;
  end;

implementation

procedure TIdTestHttpServer.HandleSimpleGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'Hello, World!';
end;

procedure TIdTestHttpServer.TestSimpleGet;
var
  HttpSrv: TIdHttpServer;
  HttpCli: TIdHttp;
begin
  HttpSrv := TIdHttpServer.Create;
  try
    HttpSrv.OnCommandGet := HandleSimpleGet;
    HttpSrv.DefaultPort := 1234;
    HttpSrv.Active := True;
    try
      HttpCli := TIdHttp.Create;
      try
        Assert(HttpCli.Get('http://127.0.0.1:1234/index.html') = 'Hello, World!');
      finally
        Sys.FreeAndNil(HttpCli);
      end;
    finally
      HttpSrv.Active := False;
    end;
  finally
    Sys.FreeAndNil(HttpSrv);
  end;
end;

initialization
  TIdTest.RegisterTest(TIdTestHttpServer);
end.