unit IdTestCmdTCPServer;

interface

uses
  IdTest,
  IdGlobal,
  IdTCPClient,
  IdCmdTCPServer,
  IdIOHandlerStack,
  IdLogDebug,
  IdSys;

type

  TIdTestCmdTCPServer = class(TIdTest)
  published
    procedure TestServer;
  end;

implementation

procedure TIdTestCmdTCPServer.TestServer;
var
	aClient: TIdTCPClient;
	aServer: TIdCmdTCPServer;
const
	cTestPort=20202;
	cGreetingText = 'Hello There';
begin
	aClient:= TIdTCPClient.Create(nil);
	aServer:= TIdCmdTCPServer.Create(nil);
	try
			aServer.DefaultPort:=cTestPort;
			aServer.Greeting.Text.Text := cGreetingText;
			aServer.Greeting.Code := '200';
			aServer.Active:=True;
			aClient.Port:=cTestPort;
			aClient.Host:='127.0.0.1';
			aClient.Connect;
			Assert(aClient.GetResponse(200) = 200);
			Assert(aClient.LastCmdResult.Text.Text = cGreetingText+EOL);
			aClient.Disconnect;
	finally
		Sys.FreeAndNil(aClient);
		Sys.FreeAndNil(aServer);
	end;
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPServer);

end.
