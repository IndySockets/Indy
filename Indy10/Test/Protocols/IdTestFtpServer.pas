unit IdTestFtpServer;

//todo test commands return 'not logged in' error correctly

interface

uses
  IdGlobal,
  IdSys,
  IdObjs,
  IdTest,
  IdTcpClient,
  IdFTPListOutput,
  IdIOHandlerStack,
  IdLogDebug,
  IdFtp,
  IdThreadSafe,
  IdFtpServer;

type

  TIdTestFtpServer = class(TIdTest)
  private
    FDirectory:TIdThreadSafeString;
    procedure CallbackRetrieve(ASender: TIdFTPServerContext; const AFileName: string; var VStream: TIdStream);
    procedure CallbackStore(ASender: TIdFTPServerContext; const AFileName: string; AAppend: Boolean; var VStream: TIdStream);
    procedure CallbackListDirectory(ASender: TIdFTPServerContext; const APath: string;
      ADirectoryListing: TIdFTPListOutput; const ACmd : String; const ASwitches : string);
    procedure CallbackChangeDirectory(ASender: TIdFTPServerContext; var VDirectory: string);
  protected
    procedure Setup;override;
    procedure TearDown;override;
  published
    procedure TestBasic;
    procedure TestMethods;
    procedure TestBasic2;
  end;

  TIdTestStream = class(TIdMemoryStream)
  public
    destructor Destroy;override;
  end;

implementation

const
  cGreeting='HELLO';
  cTestFtpPort=20021;
  cContent='MYCONTENT';
  cPathOk='okpath';
  cPathError='errorpath';
  cUploadTo='file.txt';
  cGoodFilename='good.txt';
  cUnknownFilename='unknown.txt';
  cErrorFilename='error.txt';

procedure TIdTestFtpServer.CallbackChangeDirectory(
  ASender: TIdFTPServerContext; var VDirectory: string);
begin
  FDirectory.Value:=VDirectory;
end;

procedure TIdTestFtpServer.CallbackListDirectory(
  ASender: TIdFTPServerContext; const APath: string;
  ADirectoryListing: TIdFTPListOutput; const ACmd, ASwitches: string);
var
  aItem:TIdFTPListOutputItem;
begin
  if APath=cPathError then
    begin
    end
  else if APath=cPathOk then
    begin
    aItem:=ADirectoryListing.Add;
    aItem.FileName:='file1.txt';
    //int64 filesize
    aItem.Size:=5000000000;
    aItem.ModifiedDate:=Sys.Now;
    end;
end;

procedure TIdTestFtpServer.CallbackRetrieve(ASender: TIdFTPServerContext;
  const AFileName: string; var VStream: TIdStream);
begin
 if AFileName=cGoodFilename then
   begin
   VStream:=TIdStringStream.Create(cContent);
   end
 else if AFileName=cErrorFilename then
   begin
   Assert(False);
   end
 else if AFileName=cUnknownFilename then
   begin
   end;
end;

procedure TIdTestFtpServer.CallbackStore(ASender: TIdFTPServerContext;
  const AFileName: string; AAppend: Boolean; var VStream: TIdStream);
//var
//  s:string;
begin
  Assert(VStream=nil);
  if AFileName=cUploadTo then
   begin
   VStream:=TIdTestStream.Create;
   //s:=ReadStringFromStream(VStream);
   //Assert(s=cContent);
   end;
end;

procedure TIdTestFtpServer.Setup;
begin
  inherited;
  FDirectory:=TIdThreadSafeString.Create;
end;

procedure TIdTestFtpServer.TearDown;
begin
  Sys.FreeAndNil(FDirectory);
  inherited;
end;

procedure TIdTestFtpServer.TestBasic;
var
  s:TIdFTPServer;
  c:TIdTCPClient;
  aStr:string;
begin
  s:=TIdFTPServer.Create(nil);
  c:=TIdTCPClient.Create(nil);
  try
    s.Greeting.Text.Text:=cGreeting;
    s.DefaultPort:=cTestFtpPort;
    s.AllowAnonymousLogin:=True;
    s.OnListDirectory:=CallbackListDirectory;
    s.Active:=True;

    c.Port:=cTestFtpPort;
    c.Host:='127.0.0.1';
    c.CreateIOHandler;
    c.ReadTimeout:=500;
    c.Connect;

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

    c.IOHandler.WriteLn('PASS a@b.com');
    aStr:=c.IOHandler.Readln;
    Assert(aStr<>'',aStr);

    //attempt to start a transfer when no datachannel setup.
    //should give 550 error?
    //typical quit='221 Goodbye.'

    //test commands that aren't currently in the ftp client?
    //nlst needs a data connection.
    //calling without causes an AV and memleak. should be fixed
    //c.IOHandler.WriteLn('NLST');
    //aStr:=c.IOHandler.Readln;
    //Assert(aStr<>'',aStr);
  finally
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(s);
  end;
end;


procedure TIdTestFtpServer.TestBasic2;
var
  s:TIdFTPServer;
  c:TIdFTP;
  //aStr:string;
  aList:TIdStringList;
begin
  s:=TIdFTPServer.Create;
  c:=TIdFTP.Create;
  try
    s.Greeting.Text.Text:=cGreeting;
    s.DefaultPort:=cTestFtpPort;
    s.AllowAnonymousLogin:=True;
    s.Greeting.Text.Text:=cGreeting;
    s.OnListDirectory:=Self.CallbackListDirectory;
    s.OnChangeDirectory:=Self.CallbackChangeDirectory;
    s.Active:=True;

    c.Port:=cTestFtpPort;
    c.Host:='127.0.0.1';
    c.Username:='anonymous';
    c.Password:='a@b.com';
    c.Connect;

    Assert(c.Greeting.Text.Text=cGreeting+EOL);

    aList:=TIdStringList.Create;
    try
    c.List(aList);
    Assert(aList.Count>0);

    c.ChangeDir(cPathError);

    aList.Clear;
    c.List(aList);
    finally
    Sys.FreeAndNil(aList);
    end;

  finally
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(s);
  end;
end;

procedure TIdTestFtpServer.TestMethods;
var
  s:TIdFTPServer;
  c:TIdFTP;
  aStream:TIdMemoryStream;
begin
  s:=TIdFTPServer.Create(nil);
  c:=TIdFTP.Create(nil);
  try
    s.Greeting.Text.Text:=cGreeting;
    s.DefaultPort:=cTestFtpPort;
    s.OnStoreFile:=CallbackStore;
    s.OnRetrieveFile:=CallbackRetrieve;
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

    repeat
    //check stream upload
    aStream:=TIdMemoryStream.Create;
    try
      WriteStringToStream(aStream, cContent);
      aStream.Position := 0;
      c.Put(aStream,cUploadTo);
    finally
      Sys.FreeAndNil(aStream);
    end;

    //check no dest filename
    //check missing source file
    //check file upload rejected by server. eg out of space?

    //check normal file upload. create a temp file? use c:\?
    //c.Put('c:\test.txt',cUploadTo);

    //test resume
    //test download unknown file

    aStream:=TIdMemoryStream.Create;
    try
    //test download to stream
    c.Get(cGoodFilename,aStream);
    //Assert(aStream.DataString=cContent);

    //test exception on server gets sent to client
{    aStream.Size:=0;
    try
    c.Get(cUnknownFilename,aStream);
    Assert(False);
    except
    //expect to be here
    end;
}
    finally
    Sys.FreeAndNil(aStream);
    end;
      if c.Passive then
      begin
        break;
      end;

//OutputLn('PASV Mode tests');
      c.Passive := True;
    until False;
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
