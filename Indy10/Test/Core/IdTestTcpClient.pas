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
  IdTcpClient,
  IdObjs,
  IdSys,
  IdTcpServer,
  IdContext;

type

  TIdTestTcpClient = class(TIdTest)
  private
    FServerShouldEcho: Boolean;
    procedure DoServerExecute(AContext: TIdContext);
  published
    procedure TestTimeouts;
  end;

implementation

procedure TIdTestTcpClient.DoServerExecute(AContext: TIdContext);
var
  aStr:string;
begin
  aStr:=AContext.Connection.IOHandler.Readln;
  if FServerShouldEcho then
  begin
    AContext.Connection.IOHandler.WriteLn(aStr);
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