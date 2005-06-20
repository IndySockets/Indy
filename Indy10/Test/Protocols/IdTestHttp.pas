unit IdTestHTTP;

interface

uses
  IdSys,
  IdContext,
  IdTCPServer,
  IdThreadSafe,
  IdCustomHTTPServer,
  IdHTTPServer,
  IdTest,
  IdHTTP;

type

  //http://www.io.com/~maus/HttpKeepAlive.html
  //re keep-alive, see TIdHTTPResponseInfo.WriteHeader. old comment, delete?
  TIdTestHTTP_KeepAlive = class(TIdTest)
  private
    FRequestCount:TIdThreadSafeInteger;
    FServerConnectCount:TIdThreadSafeInteger;
    procedure CallbackConnect(AContext:TIdContext);
    //procedure CallbackExecute(AContext:TIdContext);
    procedure CallbackGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  published
    //this currently seems unreliable. sometimes server will complete the
    //request, but client returns empty comment
    procedure TestKeepAlive;
  end;

  //basic subclass that keeps statistics
  TIdHTTPStats = class(TIdHTTP)
  protected
    procedure DoOnConnected;override;
  public
    CountConnect:Integer;
  end;

  //this test shows a memory leak due to AResponse.KeepAlive being called in a
  //finally block, and raising an exception.
  //seperate test class as it has private callbacks for the server
  //the actual result of this test (a memory leak) will only properly be detected
  //on application shutdown, when running an appropriate memory checker
  TIdTestHTTP_01 = class(TIdTest)
  private
    procedure CallbackExecute(AContext:TIdContext);
  published
    procedure TestMemoryLeak;
  end;

implementation

procedure TIdTestHTTP_01.CallbackExecute(AContext: TIdContext);
//check that the server disconnecting the client doesn't cause
//issues, eg memory leaks
begin
  AContext.Connection.Disconnect;
end;

procedure TIdTestHTTP_01.TestMemoryLeak;
var
 aClient:TIdHTTP;
 aServer:TIdTCPServer;
begin
 aClient:=TIdHTTP.Create(nil);
 aServer:=TIdTCPServer.Create(nil);
 try
 aServer.DefaultPort:=20202;
 aServer.OnExecute:=Self.CallbackExecute;
 aServer.Active:=True;

 //the circumstances for the memory leak also require a ConnectionTimeout
 //haven't investigated why
 aClient.ConnectTimeout:=2000;
 try
 aClient.Get('http://127.0.0.1:20202');
 except
 //we're expecting this exception, ignore it
 end;

 finally
 Sys.FreeAndNil(aClient);
 Sys.FreeAndNil(aServer);
 end;
end;

procedure TIdTestHTTP_KeepAlive.CallbackConnect(AContext: TIdContext);
begin
  FServerConnectCount.Increment;
end;

procedure TIdTestHTTP_KeepAlive.CallbackGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  FRequestCount.Increment;
  if ARequestInfo.Document='/1' then AResponseInfo.ContentText:='a'
  else if ARequestInfo.Document='/2' then AResponseInfo.ContentText:='b'
  else AResponseInfo.ContentText:='Unknown:'+ARequestInfo.Document;
end;

procedure TIdTestHTTP_KeepAlive.TestKeepAlive;
//in order to test that keepAlive is working, should count the connection
//attempts on client and server. repeat for keepAlive=true/false
//http client seems to be biased towards 1.1 (see TIdCustomHTTP.ConnectToHost),
//giving no keep-alive, but server is 1.0, expecting a keep-alive
//a fast-response, high requestcount keep-alive client could expect
//a 3x time reduction for the session
var
  c:TIdHTTPStats;
  aContent:string;
  aServer:TIdHTTPServer;
  i:Integer;
const
  cUrl='http://127.0.0.1:22280/';
  //makes easier to get a fail (empty response)
  cLoop=100;
begin
  FServerConnectCount:=TIdThreadSafeInteger.Create;
  FRequestCount:=TIdThreadSafeInteger.Create;
  aServer:=TIdHTTPServer.Create;
  c:=TIdHTTPStats.Create;
  try
    aServer.OnConnect:=CallbackConnect;
    aServer.OnCommandGet:=CallbackGet;
    //server currently like 1.0, requires explicit keep-alive request
    aServer.KeepAlive:=True;
    aServer.DefaultPort:=22280;
    aServer.Active:=True;

    //setting readtimeout makes this reliable. investigate why
    c.ReadTimeout:=1000;

    //firefox uses lowercase
    //seems to be the only place to specify on client
    c.Request.Connection:='keep-alive';

    //ensure content is different+correct for each request
    for i:=1 to cLoop do
    begin
    aContent:=c.Get(cUrl+'1');
    Assert(aContent='a',aContent);

    aContent:=c.Get(cUrl+'2');
    Assert(aContent='b',aContent);
    end;

    Assert(c.CountConnect=1);
    Assert(FServerConnectCount.Value=1);
    Assert(FRequestCount.Value=2*cLoop);
  finally
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(aServer);
    Sys.FreeAndNil(FServerConnectCount);
    Sys.FreeAndNil(FRequestCount);
  end;
end;

procedure TIdHTTPStats.DoOnConnected;
begin
  inherited;
  Inc(CountConnect);
end;

initialization

  TIdTest.RegisterTest(TIdTestHTTP_01);
  TIdTest.RegisterTest(TIdTestHTTP_KeepAlive);

end.
