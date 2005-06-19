unit IdTestTcpClient;

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
  LStream: TIdMemoryStream;
begin
  LStream := TIdMemoryStream.Create;
  try
    AContext.Connection.IOHandler.CheckForDataOnSource;
    AContext.Connection.IOHandler.InputBufferToStream(LStream);
    if FServerShouldEcho then
    begin
      LStream.Position := 0;
      AContext.Connection.IOHandler.Write(LStream);
    end;
  finally
    Sys.FreeAndNil(LStream);
  end;
end;

procedure TIdTestTcpClient.TestTimeouts;
const
  cServerPort = 20200;
var
  FServer: TIdTcpServer;
  FClient: TIdTcpClient;
  LResult: string;
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
      Assert(FClient.IOHandler.ReadLn = '');
      FServerShouldEcho := True;
      FClient.IOHandler.WriteLn('Hello, World!');
      LResult := FClient.IOHandler.ReadLn;
      Assert(LResult = 'Hello, World!', LResult);
{
	Make some test regarding the readtimeout property and the atimeout param
	of some methods. 

	So the methods needing tests include:
		+	WriteChar
		+	ReadChar
		+	WriteString
		+	ReadString
		+	WriteBytes
		+	ReadBytes
		+	WriteInteger
		+	ReadInteger

	Try for some of them the timeout stuff. the ReadTimeout property is the default.
	It defaults to -1 (IdTimeoutInfinite). When ReadTimeout is set, that's the 
	default for all read* methods. when a specific read method has a ATimeout property,
	try setting that one to see if it overrides the ReadTimeout property.
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