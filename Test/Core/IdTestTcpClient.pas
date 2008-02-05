unit IdTestTcpClient;

//todo add test to TIdCustomTCPServer to ensure OnDisconnect is called
//when connection is closed, also when exception happens, eg graceful close

{
observations:

  IdDefTimeout = 0;
  IdTimeoutDefault = -1;
  IdTimeoutInfinite = -2;

IdTimeoutDefault when passed as a default param means 'use Self.ReadTimeout' ?

From help file:

IdDefTimeout
Default timeout value when establishing socket-based connections.
IdDefTimeout is an Integer constant that represents the value to
use as the default timeout value for socket-based connection operations.
used in
  TIdIOHandlerStack.ReadTimeout,
  TIdFTP.TransferTimeout (but actually sets FDataChannel.IOHandler.ReadTimeout)

property TIdIOHandlerStack.ReadTimeout: Integer;
Indicates the milliseconds to wait for a readable IOHandler connection.
If ReadTimeout contains the value 0 (zero), the value in IdTimeoutInfinite
is used as the timeout interval.

TIdIOHandlerStack
  published
    property ReadTimeout default IdDefTimeout;
but actually initialised to:
  FReadTimeOut := IdTimeoutDefault;

It can seem more intuitive that timeout=0 means immediate timeout?
or assume it means 'no timeout' eg infinite
currently have 2 options for infinite, none for immediate

how to test that a client is actually using infinite timeout?
}

interface

uses
  IdTest,
  IdStack,
  IdComponent,
  IdGlobal,
  IdExceptionCore,
  IdTcpClient,
  IdObjs,
  IdSys,
  IdThreadSafe,
  IdTcpServer,
  IdContext;

type

  TIdTestTcpClient = class(TIdTest)
  private
    FList:TIdThreadSafeStringList;
    FServerShouldEcho: Boolean;
    procedure DoServerExecute(AContext: TIdContext);
    procedure CallbackConnect(Sender:TObject);
    procedure CallbackDisconnect(Sender:TObject);
    procedure CallbackStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  published
    procedure TestTimeouts;
    procedure TestConnectErrors;
    procedure TestEvent;
  end;

implementation

procedure TIdTestTcpClient.CallbackConnect(Sender: TObject);
var
 astr:string;
begin
 aStr:='OnConnect: Sender='+sender.Classname;
 FList.Add(astr);
end;

procedure TIdTestTcpClient.CallbackDisconnect(Sender: TObject);
var
 astr:string;
begin
 aStr:='OnDisconnect: Sender='+Sender.ClassName;
 FList.Add(astr);
end;

procedure TIdTestTcpClient.CallbackStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
var
 astr:string;
begin
 aStr:='OnStatus: Sender='+ASender.ClassName+' Text='+AStatusText;
 FList.Add(aStr);
end;

procedure TIdTestTcpClient.DoServerExecute(AContext: TIdContext);
var
  aStr:string;
begin
  aStr:=AContext.Connection.IOHandler.Readln;
  if FServerShouldEcho then
  begin
    AContext.Connection.IOHandler.WriteLn(aStr);
  end;

  if aStr='normal' then
   begin
   AContext.Connection.IOHandler.WriteLn('reply');
   end
  else if aStr='dropme' then
   begin
   AContext.Connection.Disconnect;
   end;
end;

procedure TIdTestTcpClient.TestConnectErrors;
//checks that exceptions are raised as expected
var
  aClient:TIdTCPClient;
  aExpected:Boolean;
begin

  aClient:=TIdTCPClient.Create(nil);
  try

  //no host given
  try
  aExpected:=False;
  aClient.Port:=80;
  aClient.Host:='';
  aClient.Connect;
  except
  on e:Exception do
   begin
   aExpected:=e is EIdHostRequired;
   end;
  end;
  Assert(aExpected);

  //no port given
  try
  aExpected:=False;
  aClient.Port:=0;
  aClient.Host:='127.0.0.1';
  aClient.Connect;
  except
  on e:Exception do
   begin
   aExpected:=e is EIdPortRequired;
   end;
  end;
  Assert(aExpected);

  //hoping that this port is unused (its the max port number)
  try
  aExpected:=False;
  aClient.Port:=65535;
  aClient.Host:='127.0.0.1';
  //odd. specifying timeout gives EIdNotASocket
  //aClient.ConnectTimeout:=500;
  aClient.Connect;
  except
  on e:Exception do
   begin
   aExpected:=e is EIdSocketError;
   end;
  end;
  Assert(aExpected);

  finally
  Sys.FreeAndNil(aClient);
  end;
end;

function ListToCommaText(const aSafe:TIdThreadSafeStringList):string;
begin
 with aSafe.Lock do
  try
  Result:=CommaText;
  finally
  aSafe.Unlock;
  end;

end;

procedure ListToDebug(const aList:TIdStringList);
var
  i:Integer;
begin
  for i:=0 to aList.Count-1 do
    begin
    DebugOutput(aList[i]);
    end;
end;

procedure SafeListToDebug(const aSafe:TIdThreadSafeStringList);
var
 aList:TIdStringList;
begin
 aList:=aSafe.Lock;
 try
 ListToDebug(aList);
 finally
 aSafe.Unlock;
 end;
end;

procedure TIdTestTcpClient.TestEvent;
var
 aClient:TIdTCPClient;
 aServer:TIdTCPServer;
 aStr:string;
 //TIdIOHandlerStack.CheckForDisconnect( commented disconnect
begin
 FList:=TIdThreadSafeStringList.Create;
 aClient:=TIdTCPClient.Create;
 aServer:=TIdTCPServer.Create;
 try
 aServer.OnExecute:=Self.DoServerExecute;
 aServer.DefaultPort:=12121;
 aServer.Active:=True;

 aClient.OnStatus:=Self.CallbackStatus;
 aClient.OnDisconnected:=Self.CallbackDisconnect;
 aClient.OnConnected:=Self.CallbackConnect;
 aClient.Host:='127.0.0.1';
 aClient.Port:=12121;

 //scenario #1
 DebugOutput('Client Disconnects:');

 FList.Clear;

 aClient.Connect;
 aClient.IOHandler.WriteLn('normal');
 aStr:=aClient.IOHandler.Readln;
 aClient.Disconnect;

 SafeListToDebug(FList);

 //scenario #2
 DebugOutput('Server Disconnects:');

 FList.Clear;

 try
 aClient.Connect;
 aClient.IOHandler.WriteLn('dropme');
 aStr:=aClient.IOHandler.Readln;
 except
 //ignore the graceful disconnect exception
 end;

 SafeListToDebug(FList);

 //aStr:=ListToCommaText(FList);
 //Assert(aStr='',aStr);

 finally
 sys.FreeAndNil(aClient);
 sys.FreeAndNil(aServer);
 sys.FreeAndNil(FList);
 end;
end;

procedure TIdTestTcpClient.TestTimeouts;
const
  cServerPort = 20200;
var
  FServer: TIdTcpServer;
  FClient: TIdTcpClient;
  LResult: string;
  //LStart: Integer;
  //LEnd: Integer;
begin
  FServerShouldEcho := False;
  FServer := TIdTcpServer.Create;
  try
    FServer.DefaultPort := cServerPort;
    FServer.OnExecute := DoServerExecute;
    FServer.Active := true;
    FClient := TIdTcpClient.Create;
    try
      FClient.Connect('127.0.0.1', cServerPort);
      FClient.ReadTimeout := 500;

      LResult:=FClient.IOHandler.Readln;
      Assert(LResult = '');
      Assert(FClient.IOHandler.ReadLnTimedOut);

      FServerShouldEcho := True;
      FClient.IOHandler.WriteLn('Hello, World!');
      LResult := FClient.IOHandler.ReadLn;
      Assert(LResult = 'Hello, World!', LResult);
{
  Make some test regarding the readtimeout property and the atimeout param
  of some methods.

  So the methods needing tests include:
    WriteChar
    ReadChar
    WriteString
    ReadString
    WriteBytes
    ReadBytes
    WriteInteger
    ReadInteger

  Try for some of them the timeout stuff. the ReadTimeout property is the default.
  It defaults to -1 (IdTimeoutInfinite). When ReadTimeout is set, that's the
  default for all read* methods. when a specific read method has a ATimeout property,
  try setting that one to see if it overrides the ReadTimeout property.

  the length of timeout should also be measured.
  eg set timeout to 3000. read. check that the read method blocked for between 2 and 4 seconds.
  this ensures that timeouts aren't occurring instantly.
  needs a portable timing mechanism? gettickcount on windows?
}
    finally
      Sys.FreeAndNil(FClient);
    end;
  finally
    Sys.FreeAndNil(FServer);
  end;
end;

initialization
  TIdTest.RegisterTest(TIdTestTcpClient);
end.