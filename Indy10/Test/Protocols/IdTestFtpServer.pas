unit IdTestFtpServer;

interface

uses
  IdGlobal,
  IdSys,
  IdObjs,
  IdTest,
  IdTcpClient,
  IdIOHandlerStack,
  IdLogDebug,
  IdFtp,
  IdFtpServer;

type

  TIdTestFtpServer = class(TIdTest)
  private
    procedure CallbackStore(ASender: TIdFTPServerContext; const AFileName: string; AAppend: Boolean; var VStream: TIdStream2);
  published
    procedure TestBasic;
    procedure TestMethods;
  end;

  TIdTestStream = class(TIdMemoryStream)
  public
    destructor Destroy;override;
  end;

implementation

const
  cGreeting='HELLO';
  cTestFtpPort=20021;
  cContent='HELLO';
  cUploadTo='file.txt';

procedure TIdTestFtpServer.CallbackStore(ASender: TIdFTPServerContext;
  const AFileName: string; AAppend: Boolean; var VStream: TIdStream2);
var
  s:string;
begin
  Assert(VStream=nil);
  if AFileName=cUploadTo then
   begin
   VStream:=TIdTestStream.Create;
   //s:=ReadStringFromStream(VStream);
   //Assert(s=cContent);
   end;
end;

procedure TIdTestFtpServer.TestBasic;
var
  s:TIdFTPServer;
  c:TIdTCPClient;
  aStr:string;
  aIntercept:TIdLogDebug;
begin
  s:=TIdFTPServer.Create(nil);
  c:=TIdTCPClient.Create(nil);
  try
    c.CreateIOHandler;
    aIntercept := TIdLogDebug.Create;
    c.IOHandler.Intercept := aIntercept;
    aIntercept.Active := true;
    try
      s.Greeting.Text.Text:=cGreeting;
      s.DefaultPort:=cTestFtpPort;
      s.Active:=True;

      c.Port:=cTestFtpPort;
      c.Host:='127.0.0.1';
      c.Connect;
      c.IOHandler.ReadTimeout:=500;

      //expect a greeting. typical="220 FTP Server Ready."
      aStr:=c.IOHandler.Readln;
      Assert(aStr = '220 ' + cGreeting, cGreeting);

      //ftp server should only process a command after crlf
      //see TIdFTPServer.ReadCommandLine
      c.IOHandler.Write('U');
      aStr:=c.IOHandler.Readln;
      Assert(aStr='',aStr);

      //complete the rest of the command
      c.IOHandler.WriteLn('SER ANONYMOUS');
      aStr:=c.IOHandler.Readln;
      Assert(aStr<>'',aStr);

      //attempt to start a transfer when no datachannel setup.
      //should give 550 error?
      //typical quit='221 Goodbye.'
    finally
      aIntercept.Active := False;
    end;
  finally
    Sys.FreeAndNil(aIntercept);
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(s);
  end;
end;


procedure TIdTestFtpServer.TestMethods;
var
  s:TIdFTPServer;
  c:TIdFTP;
  aStream:TIdStringStream;
const
  cTestFtpPort=20021;
begin
  s:=TIdFTPServer.Create(nil);
  c:=TIdFTP.Create(nil);
  try
    s.Greeting.Text.Text:=cGreeting;
    s.DefaultPort:=cTestFtpPort;
    s.OnStoreFile:=CallbackStore;
    s.Active:=True;

    c.Port:=cTestFtpPort;
    c.Host:='127.0.0.1';
    c.CreateIOHandler;
    c.IOHandler.ReadTimeout:=1000;
    c.AutoLogin:=False;
    c.Connect;

    //check invalid login
    //check valid login
    //check allow/disallow anonymous login

    s.AllowAnonymousLogin:=True;
    c.Username:='anonymous';
    c.Password:='bob@example.com';
    c.Login;

    //check stream upload 
    aStream:=TIdStringStream.Create(cContent);
    try
    c.Put(aStream,cUploadTo);
    finally
    Sys.FreeAndNil(aStream);
    end;

    //check no dest filename
    //check missing source file
    //check file upload rejected by server

    //check normal file upload. create a temp file? use c:\?
    //c.Put('c:\test.txt',cUploadTo);

  finally
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(s);
  end;
end;

destructor TIdTestStream.Destroy;
begin
  inherited;
end;

initialization

  TIdTest.RegisterTest(TIdTestFtpServer);

end.
