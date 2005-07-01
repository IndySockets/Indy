unit IdTestHttpServer;

interface

uses
  IdGlobal,
  IdContext,
  IdHttp,
  IdIOHandlerStack,
  IdCustomHttpServer,
  IdHttpServer,
  IdLogDebug,
  IdServerInterceptLogFile,
  IdHttpHeaderInfo,
  IdObjs,
  IdSys,
  IdTcpClient,
  IdTest;

type
  TIdTestHttpServer = class(TIdTest)
  private
    FException: Exception;
    procedure HandleSimpleGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HandleException(AContext:TIdContext; AException: Exception);
  published
    procedure TestSimpleGet;
  end;

implementation

procedure TIdTestHttpServer.HandleException(AContext:TIdContext; AException: Exception);
begin
  if FException = nil then
  begin
    FException := AException;
  end; 
end;

procedure TIdTestHttpServer.HandleSimpleGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := 'Hello, World!';
end;

procedure TIdTestHttpServer.TestSimpleGet;
var
  HttpSrv: TIdHttpServer;
  HttpCli: TIdHttp;
  TcpCli: TIdTcpClient;
  TempString: string;
  aDebug:TIdLogDebug;
  aIntercept:TIdServerInterceptLogFile;
begin
  HttpSrv := TIdHttpServer.Create;
  aIntercept := TIdServerInterceptLogFile.Create;
  try
    HttpSrv.OnCommandGet := HandleSimpleGet;
    HttpSrv.DefaultPort := 1234;
    HttpSrv.OnException := HandleException;
    HttpSrv.Intercept := aIntercept;
    aIntercept.FileName := 'w:\httpsrv.log';
    HttpSrv.Active := True;
    try
      aDebug := TIdLogDebug.Create;
      TcpCli := TIdTcpClient.Create;
      try
        TcpCli.Host := '127.0.0.1';
        TcpCli.Port := 1234;
//        TcpCli.ReadTimeout := 250;
        TcpCli.CreateIOHandler;
        TcpCli.IOHandler.Intercept := aDebug;
        TIdLogDebug(TcpCli.IOHandler.Intercept).Active := True;
        TcpCli.Connect;
        TcpCli.IOHandler.WriteLn('GET /index.html HTTP/1.1');
        TcpCli.IOHandler.WriteLn('Accept: */*');
        TcpCli.IOHandler.WriteLn('Accept-Language: en,nl;q=0.5');
        TcpCli.IOHandler.WriteLn('Accept-Encoding: gzip, deflate');
        TcpCli.IOHandler.WriteLn('User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322; .NET CLR 1.0.3705)');
        TcpCli.IOHandler.WriteLn('Host: 127.0.0.1');
        TcpCli.IOHandler.WriteLn('Connection: close');
        TcpCli.IOHandler.WriteLn('');
        if FException <> nil then
          raise FException;
        TempString := TcpCli.IOHandler.ReadLn('', -1);
        Assert(not TcpCli.IOHandler.ReadLnTimedOut, 'Timed out (1)');
        Assert(TempString = 'HTTP/1.1 200 OK', TempString);
        TcpCli.IOHandler.AllData;
        TcpCli.Disconnect;
      finally
        Sys.FreeAndNil(TcpCli);
      end;
      HttpCli := TIdHttp.Create;
      try
        HttpCli.ReadTimeout := 2500;
        Assert(HttpCli.Get('http://127.0.0.1:1234/index.html') = 'Hello, World!');
      finally
        Sys.FreeAndNil(HttpCli);
        Sys.FreeAndNil(aDebug);
      end;
    finally
      HttpSrv.Active := False;
    end;
  finally
    Sys.FreeAndNil(HttpSrv);
    Sys.FreeAndNil(aIntercept);
  end;
end;

initialization
  TIdTest.RegisterTest(TIdTestHttpServer);
end.