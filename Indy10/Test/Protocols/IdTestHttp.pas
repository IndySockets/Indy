unit IdTestHTTP;

//todo test chunked Transfer-Encoding
//http://www.faqs.org/rfcs/rfc2616.html
//3.6 Transfer Codings, 19.4.6 Introduction of Transfer-Encoding

//todo test gzip compression

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

  TIdTestHTTP_Redirect = class(TIdTest)
  private
    procedure CallbackGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  published
    procedure TestRedirect;
  end;

  //basic subclass that keeps statistics
  TIdHTTPStats = class(TIdHTTP)
  protected
    procedure DoOnConnected;override;
  public
    //record actual tcp connections
    CountConnect:Integer;
  end;

  TIdHTTPServerStats = class(TIdHTTPServer)
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
const
  cUrl='http://127.0.0.1:22280/';
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

    //seems to be the only place to specify on client
    c.Request.Connection:='keep-alive';

    //ensure content is different+correct for each request
    aContent:=c.Get(cUrl+'1');
    Assert(aContent='a',aContent);

    aContent:=c.Get(cUrl+'2');
    Assert(aContent='b',aContent);

    Assert(c.CountConnect=1);
    Assert(FServerConnectCount.Value=1);
    Assert(FRequestCount.Value=2);
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

procedure TIdTestHTTP_Redirect.CallbackGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if ARequestInfo.Document='/1' then AResponseInfo.Redirect('/2')
  else if ARequestInfo.Document='/2' then AResponseInfo.ContentText:='b';
end;

procedure TIdTestHTTP_Redirect.TestRedirect;
var
  aClient:TIdHTTP;
  aServer:TIdHTTPServer;
  s:string;
  aCorrectClass:boolean;
  aClassName:string;
begin
  aClient:=TIdHTTP.Create;
  aServer:=TIdHTTPServer.Create;
  try
  aServer.OnCommandGet:=CallbackGet;
  aServer.DefaultPort:=22280;
  aServer.Active:=True;

  //this shouldnt be needed
  aClient.ReadTimeout:=10000;

  //first, try without redirects enabled. should get an exception.
  aClient.HandleRedirects:=False;
  try
  aCorrectClass:=True;
  s:=aClient.Get('http://127.0.0.1:22280/1');
  Assert(False);//should not get here
  except
  //expect to get here
  //check exception class. dont raise exception in except-block.
  on e:Exception do
   begin
   aClassName:=e.ClassName;
   aCorrectClass:=e is EIdHTTPProtocolException;
   end;
  end;
  //also check code (302)
  Assert(aCorrectClass,aClassName);

  //now let indy handle the redirection instructions from the server
  aClient.HandleRedirects:=True;
  s:=aClient.Get('http://127.0.0.1:22280/1');
  Assert(s='b',s);
  //todo count should really be 1?
  Assert(aClient.RedirectCount=1);

  finally
  Sys.FreeAndNil(aClient);
  Sys.FreeAndNil(aServer);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestHTTP_01);
  TIdTest.RegisterTest(TIdTestHTTP_KeepAlive);
  TIdTest.RegisterTest(TIdTestHTTP_Redirect);

end.
