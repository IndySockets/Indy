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
  aResponse: integer;
  aText: string;
const
  cTestPort=20202;
  cGreetingText = 'Hello There';
begin
  aClient:= TIdTCPClient.Create(nil);
  aServer:= TIdCmdTCPServer.Create(nil);
  try
    aServer.DefaultPort:=cTestPort;
    aServer.Greeting.Code := '200';
    aServer.Greeting.Text.Text := cGreetingText;
    Assert(aServer.Greeting.NumericCode<>0);
    aServer.Active:=True;
    aClient.Port:=cTestPort;
    aClient.Host:='127.0.0.1';
    aClient.ReadTimeout:=60000;
    aClient.Connect;
    aResponse:=aClient.GetResponse(200);
    Assert(aResponse = 200);
    aText := AClient.LastCmdResult.Text.Text;
    Assert(aText = cGreetingText+EOL, aText);
    aClient.Disconnect;
  finally
    Sys.FreeAndNil(aClient);
    Sys.FreeAndNil(aServer);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPServer);

end.
