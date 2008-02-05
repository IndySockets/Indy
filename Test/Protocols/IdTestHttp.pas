unit IdTestHTTP;

{
http://www.schroepl.net/cgi-bin/http_trace.pl
useful to test exactly what headers a web server is receiving from the http client
allows you to check that the headers that http client writes are actually received
by the server, ie not modified by a proxy/firewall after they leave your pc
}

//todo test chunked Transfer-Encoding
//http://www.faqs.org/rfcs/rfc2616.html
//3.6 Transfer Codings, 19.4.6 Introduction of Transfer-Encoding

//todo standardize http ports used

{$I IdCompilerDefines.inc}

interface

//short term solution to allow trying alternate compression implementations
{.$DEFINE INDY_USE_ABBREVIA}

uses
  {$IFDEF INDY_USE_ABBREVIA}
  IdCompressorAbbrevia,
  {$ENDIF}
  {$IFNDEF DOTNET}
  IdCompressorZLibEx,
  {$ENDIF}
  IdZLibCompressorBase,
  IdObjs,
  IdLogDebug,
  IdCoder,
  IdCoderMime,
  IdSys,
  IdGlobal,
  IdContext,
  IdTCPServer,
  IdThreadSafe,
  IdCustomHTTPServer,
  IdHTTPServer,
  IdTest,
  IdHTTP;

type

  {
  GZip compression tested using apache 2.0
  add following to httpd.conf to enable gzip on given types

  LoadModule deflate_module modules/mod_deflate.so
  AddOutputFilterByType DEFLATE text/html text/plain text/xml
  }
  {
  can test if a compressed stream is valid by renaming to .gz and
  opening with compression utility, eg winrar

  see also IdCompressorAbbrevia for a reimplementation
  }
  //Note that you can NOT do this test at all in DotNET because
  //we currently have no Indy code for it.
  {$IFNDEF DOTNET}
  TIdTestHTTP_GZip = class(TIdTest)
  private
    procedure CallbackGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  published
    procedure TestCompress;
    procedure TestGZip;
  end;
  {$ENDIF}

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

  //tests that redirection commands are followed properly
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

  TIdTestHTTP_02 = class(TIdTest)
  private
    FServer:TIdHTTPServer;
    FClient:TIdHTTP;
    procedure CallbackGet(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  protected
    procedure SetUp;override;
    procedure TearDown;override;
  published
    procedure TestRedirectedDownload;
  end;

implementation

uses IdBaseComponent;

const
  //base64 encoding of gzipped 'hello world'
  //used to test decompression
  cHelloWorldGz='H4sIAAAAAAAAC8tIzcnJVyjPL8pJAQCFEUoNCwAAAA==';
  //and what it decodes to
  cHelloWorld='hello world';

  //document on the server to ask for
  cDocGZip='gz';
  //content encoding constant
  cEncodingGZip='gzip';

  cRedirectData='data';

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
  Assert(aClient.RedirectCount=1);

  //todo test that RedirectMaximum is followed

  finally
  Sys.FreeAndNil(aClient);
  Sys.FreeAndNil(aServer);
  end;
end;

{
  //use to encode test data so it can be included in source easily
  aEncode:=TIdEncoderMIME.Create;
  aStream:=TIdMemoryStream.Create;
  try
  aStream.LoadFromFile('e:\test.txt');
  s:=aEncode.Encode(aStream);
  assert(s<>'');
  finally
  sys.FreeAndNil(aEncode);
  end;
  Exit;
}

{$IFNDEF DOTNET}
procedure TIdTestHTTP_GZip.CallbackGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
//currently content has to be manually compressed
//eg server doesnt auto-compress all "plain/text" content if client allows
begin
  if ARequestInfo.Document='/'+cDocGZip then
    begin
    //todo reply based on the requests ContentEncoding string
    AResponseInfo.ContentEncoding:=cEncodingGZip;
    AResponseInfo.ContentText:=DecodeString(TIdDecoderMIME,cHelloWorldGz);
    end
  else
    begin
    AResponseInfo.ContentText:='error';
    end;
end;

procedure TIdTestHTTP_GZip.TestCompress;
//tests the client correctly decompressed gzip content received from server
//basically the same as TestGZip but with the httpclient+server too
//todo also deflate?
var
  aClass:TIdZLibCompressorBaseClass;
  aCompress:TIdZLibCompressorBase;
  aClient:TIdHTTP;
  aStream:TIdStringStream;
  aServer:TIdHTTPServer;
begin
  {$IFDEF DOTNET}
  aClass:=nil;
  {$ELSE}
    {$IFDEF INDY_USE_ABBREVIA}
    aClass:=TIdCompressorAbbrevia;
    {$ELSE}
    aClass:=TIdCompressorZLibEx;
    {$ENDIF}
  {$ENDIF}

  //todo test that server only returns compressed data if we ask for it

  Assert(aClass<>nil);
  aCompress:=aClass.Create;
  aServer:=TIdHTTPServer.Create;
  aClient:=TIdHTTP.Create;
  aStream:=TIdStringStream.Create('');
  try
    aServer.DefaultPort:=22280;
    aServer.OnCommandGet:=Self.CallbackGet;
    aServer.Active:=True;

    aClient.Compressor:=aCompress;
    //identity is due to existing code in http unit, may be changed/removed in future.
    aClient.Request.AcceptEncoding := 'gzip, deflate, identity';
    aClient.CreateIOHandler;
    //aClient.HandleRedirects:=True;
    //aClient.Request.UserAgent:='';

    //can also test using an external web server, eg apache
    //aClient.Get('http://192.168.1.100:22280/helloworld.txt',aStream);
    aClient.Get('http://127.0.0.1:22280/'+cDocGZip,aStream);
    Assert(aStream.DataString='hello world',aClass.ClassName);
    //aStream.SaveToFile('e:\test.txt');
  finally
    Sys.FreeAndNil(aServer);
    Sys.FreeAndNil(aStream);
    Sys.FreeAndNil(aClient);
    Sys.FreeAndNil(aCompress);
  end;
end;

procedure TIdTestHTTP_GZip.TestGZip;
//basic gzip functionality test.
//doesn't really belong in this http unit
var
  aClass:TIdZLibCompressorBaseClass;
  aCompress:TIdZLibCompressorBase;
  //dont use stringstream as it acts differently
  aStream,aOutStream:TIdMemoryStream;
  s:string;
begin
  //string now contains a gz encoded test string
  s:=DecodeString(TIdDecoderMIME,cHelloWorldGz);

  //better way to do? eg iterate and test all registered compression classes?
  {$IFDEF DOTNET}
  aClass:=nil;
  {$ELSE}
    {$IFDEF INDY_USE_ABBREVIA}
    aClass:=TIdCompressorAbbrevia;
    {$ELSE}
    aClass:=TIdCompressorZLibEx;
    {$ENDIF}
  {$ENDIF}

  Assert(aClass<>nil);
  aStream:=TIdMemoryStream.Create;
  WriteStringToStream(aStream,s);
  aOutStream:=TIdMemoryStream.Create;
  aCompress:=aClass.Create;
  try
    aStream.Position:=0;
    aCompress.DecompressGZipStream(aStream,aOutStream);
    aOutStream.Position:=0;
    s:=ReadStringFromStream(aOutStream);
    Assert(s=cHelloWorld,s);
  finally
    Sys.FreeAndNil(aCompress);
    Sys.FreeAndNil(aStream);
    Sys.FreeAndNil(aOutStream);
  end;
end;
{$ENDIF}

procedure TIdTestHTTP_02.CallbackGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if ARequestInfo.Document='/redirect' then
    begin
    AResponseInfo.ContentText:='message';
    AResponseInfo.Redirect('/download');
    end
  else if ARequestInfo.Document='/download' then
    begin
    AResponseInfo.ContentText:=cRedirectData;
    end;
end;

procedure TIdTestHTTP_02.SetUp;
begin
  inherited;
  FServer:=TIdHTTPServer.Create;
  FServer.DefaultPort:=22280;
  FServer.OnCommandGet:=Self.CallbackGet;

  FClient:=TIdHTTP.Create;
end;

procedure TIdTestHTTP_02.TearDown;
begin
  Sys.FreeAndNil(FServer);
  Sys.FreeAndNil(FClient);
  inherited;
end;

procedure TIdTestHTTP_02.TestRedirectedDownload;
//this shows that when requesting a download from a server, content
//from the redirecting page is not included in the data from the
//actual download
var
  s:TIdMemoryStream;
  aStr:string;
begin
  FServer.Active:=True;

  s:=TIdMemoryStream.Create;
  try
    FClient.HandleRedirects:=True;
    FClient.Get('http://127.0.0.1:22280/redirect?download',s);
    s.Position:=0;
    aStr:=ReadStringFromStream(s);
    Assert(aStr=cRedirectData);
  finally
    sys.FreeAndNil(s);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestHTTP_01);
  TIdTest.RegisterTest(TIdTestHTTP_02);
  TIdTest.RegisterTest(TIdTestHTTP_KeepAlive);
  TIdTest.RegisterTest(TIdTestHTTP_Redirect);
  {$IFNDEF DOTNET}
  TIdTest.RegisterTest(TIdTestHTTP_GZip);
  {$ENDIF}
end.
