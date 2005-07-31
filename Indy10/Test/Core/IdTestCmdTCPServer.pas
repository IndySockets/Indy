unit IdTestCmdTCPServer;

{
session from known non-indy smtp:
-----------------------------------------
220 mail.example.com ESMTP
?
500 5.5.1 Command unrecognized: "?"
-----------------------------------------

non-indy pop3
-----------------------------------------
+OK DBMAIL pop3 server ready to rock
?
-ERR your command does not compute
-----------------------------------------

current indy cmdserver functionality:
-----------------------------------------
200 Test Greeting
?
400-Unknown Command
400 ?
-----------------------------------------
}

interface

uses
  IdCmdTCPServer,
  IdCommandHandlers,
  IdContext,
  IdGlobal,
  IdIOHandlerStack,
  IdLogDebug,
  IdTCPClient,
  IdTCPConnection,
  IdTest,
  IdSys;

type

  TIdTestCmdTCPServer = class(TIdTest)
  private
    //use a basic tcpclient to ensure isolate errors to the server component
    FClient: TIdTCPClient;
    FServer: TIdCmdTCPServer;
    procedure CommandTEST(ASender: TIdCommand);
    procedure CommandError(ASender: TIdCommand);
    procedure GetGreeting;
  protected
    procedure SetUp;override;
    procedure TearDown;override;
  published
    procedure TestCompleteCommand;
    procedure TestResultCode;
    procedure TestServerException;
    procedure TestUnknownCommand;
  end;

  EIdTestException = class(Exception);

implementation

const
  cTestCommand='TEST';
  cTestResponse='TestResponse';
  cTestCode=202;
  cNotTestCode=203;
  cErrorCommand='CAUSEERROR';
  cErrorResponse='My Error Message';
  cUnknownCommand='UNKNOWN';
  cTestPort=20202;
  cGreetingText = 'Test Greeting';

procedure TIdTestCmdTCPServer.CommandError(ASender: TIdCommand);
begin
  raise EIdTestException.Create(cErrorResponse);
end;

procedure TIdTestCmdTCPServer.CommandTEST(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(cTestCode,cTestResponse);
end;

procedure TIdTestCmdTCPServer.SetUp;
var
  aCommand:TIdCommandHandler;
begin
  inherited;
  FServer:= TIdCmdTCPServer.Create(nil);
  FServer.DefaultPort:=cTestPort;
  FServer.HelpReply.Code := '111';
  FServer.Greeting.Code := '200';
  FServer.Greeting.Text.Text := cGreetingText;
  Assert(FServer.Greeting.NumericCode<>0);

  aCommand:=FServer.CommandHandlers.Add;
  aCommand.Command := cTestCommand;
  aCommand.OnCommand := CommandTEST;

  aCommand:=FServer.CommandHandlers.Add;
  aCommand.Command := cErrorCommand;
  aCommand.OnCommand := CommandError;

  //uncomment to test using external telnet app
  //Sleep(5*60*1000);

  //setup client
  FClient:= TIdTCPClient.Create(nil);
  FClient.Port:=cTestPort;
  FClient.Host:='127.0.0.1';
  FClient.ReadTimeout:=1000;
  FClient.ConnectTimeout:=1000;

  //start
  FServer.Active:=True;
  FClient.Connect;

  GetGreeting;
end;

procedure TIdTestCmdTCPServer.TearDown;
begin
  Sys.FreeAndNil(FClient);
  Sys.FreeAndNil(FServer);
  inherited;
end;

procedure TIdTestCmdTCPServer.TestCompleteCommand;
//check that commands are only processed after EOL is sent
var
  aStr:string;
begin
  FClient.IOHandler.Write('TE');
  aStr:=FClient.IOHandler.Readln;
  Assert(aStr = '',aStr);
  FClient.IOHandler.Write('ST' + EOL);
  Assert(FClient.GetResponse(cTestCode) = cTestCode);
  Assert(FClient.LastCmdResult.Text.Text = cTestResponse + EOL);
end;

procedure TIdTestCmdTCPServer.GetGreeting;
//greeting is sent by server immediately after connect
//already read in setup
var
  aResponse:integer;
  aStr:string;
begin
  aResponse:=FClient.GetResponse(200);
  Assert(aResponse = 200);
  aStr := FClient.LastCmdResult.Text.Text;
  Assert(aStr = cGreetingText+EOL, aStr);
end;

procedure TIdTestCmdTCPServer.TestResultCode;
//check unexpected resultcode raises error
//TEST doesnt return 203, so this should fail
var
  aExpected:Boolean;
begin
  try
  FClient.SendCmd(cTestCommand,[cNotTestCode]);
  aExpected:=False;
  except
  aExpected:=True;
  end;
  Assert(aExpected);
  //SendCmd function result invalid here due to exception raised
  Assert(FClient.LastCmdResult.NumericCode=cTestCode);
end;

procedure TIdTestCmdTCPServer.TestServerException;
//check exception on server sent to client ok.
//exceptions should be response 500
//possible to get actual server-side exception class?
var
  aResponse: integer;
  aStr:string;
begin
  FClient.IOHandler.WriteLn(cErrorCommand);
  aResponse:=FClient.GetResponse(500);
  aStr:=FClient.LastCmdResult.Text.Text;
  Assert(aResponse=500);
  Assert(aStr=cErrorResponse+EOL);
end;

procedure TIdTestCmdTCPServer.TestUnknownCommand;
//check that unknown command is handled correctly
//see TIdCmdTCPServer.CreateReplyUnknownCommand
var
  aResponse:integer;
  aStr:string;
begin
  aResponse:=FClient.SendCmd(cUnknownCommand);
  Assert(aResponse=400);
  aStr:=FClient.LastCmdResult.Text.Text;
  Assert(aStr='Unknown Command'+EOL+cUnknownCommand+EOL);
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPServer);

end.
