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
	o: &Object;
const
	cTestPort=20202;
	cGreetingText = 'Hello There';
begin
	aClient:= TIdTCPClient.Create(nil);
	aServer:= TIdCmdTCPServer.Create(nil);
	try
		aClient.IOHandler := TIdIOHandlerStack.Create;
		aClient.IOHandler.Intercept := TIdLogDebug.Create;
		TIdLogDebug(AClient.IOHandler.Intercept).Active := true;
		try
			aServer.DefaultPort:=cTestPort;
			aServer.Greeting.Text.Text := cGreetingText;
			aServer.Greeting.Code := '200';
			aServer.Active:=True;
			aClient.Port:=cTestPort;
			aClient.Host:='127.0.0.1';
			aClient.Connect;
			Assert(aClient.GetResponse(200) = 200);
			Console.WriteLine('LastCmdResult.Text = "{0}"', AClient.LastCmdResult.Text.Text);
			Assert(aClient.LastCmdResult.Text.Text = cGreetingText);
			aClient.Disconnect;
		finally
			o := AClient.IOHandler.Intercept;
			Sys.FreeAndNil(o);
			o := AClient.IOHandler;
			Sys.FreeAndNil(o);
		end;
	finally
		Sys.FreeAndNil(aClient);
		Sys.FreeAndNil(aServer);
	end;
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPServer);

end.
