unit IdTestCmdTCPServer;

interface

uses
  IdTest,
  IdGlobal,
  IdTCPClient,
  IdCmdTCPServer,
  IdContext,
  IdIOHandlerStack,
  IdLogDebug,
  IdCommandHandlers,
  IdSys;

type

  TIdTestCmdTCPServer = class(TIdTest)
  private
    procedure CommandTEST(ASender: TIdCommand);
  published
    procedure TestServer;
  end;

implementation

procedure TIdTestCmdTCPServer.CommandTEST(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(200, 'Hello, World!');
end;

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
    AServer.HelpReply.Code := '111';
    with AServer.CommandHandlers.Add do
    begin
      Command := 'TEST';
      OnCommand := CommandTEST;
    end;
    aServer.Greeting.Code := '200';
    aServer.Greeting.Text.Text := cGreetingText;
    Assert(aServer.Greeting.NumericCode<>0);
    aServer.Active:=True;
    aClient.Port:=cTestPort;
    aClient.Host:='127.0.0.1';
    aClient.ReadTimeout:=5000;
    aClient.Connect;
    aResponse:=aClient.GetResponse(200);
    Assert(aResponse = 200);
    aText := AClient.LastCmdResult.Text.Text;
    Assert(aText = cGreetingText+EOL, aText);
    AClient.IOHandler.Write('TE');
    Assert(AClient.IOHandler.ReadLn = '');
    AClient.IOHandler.Write('ST' + EOL);
    Assert(AClient.GetResponse(200) = 200);
    Assert(AClient.LastCmdResult.Text.Text = 'Hello, World!' + EOL, '1');
    aClient.Disconnect;
  finally
    Sys.FreeAndNil(aClient);
    Sys.FreeAndNil(aServer);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPServer);

end.
