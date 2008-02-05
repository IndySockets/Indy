unit IdTestCmdTCPClient;

interface

uses
  IdTest,
  IdGlobal,
  IdCmdTCPClient,
  IdCmdTCPServer,
  IdSys;

type

  TIdSafeCmdTCPClient = class(TIdCmdTCPClient)
  public
    AllowFree:Boolean;
    destructor Destroy; override;
  end;

  TIdTestCmdTCPClient = class(TIdTest)
  published
    procedure TestFree;
  end;

implementation

procedure TIdTestCmdTCPClient.TestFree;
//this is to make sure a bug doesnt reappear. at one point, the
//TIdCmdTCPClientListeningThread freed its owner.
var
 aClient:TIdSafeCmdTCPClient;
 aServer:TIdCmdTCPServer;
const
 cTestPort=20202;
begin
 aClient:=TIdSafeCmdTCPClient.Create(nil);
 aServer:=TIdCmdTCPServer.Create(nil);
 try
 aServer.DefaultPort:=cTestPort;
 aServer.Active:=True;

 aClient.AllowFree:=False;
 aClient.Port:=cTestPort;
 aClient.Host:='127.0.0.1';
 aClient.Connect;

 aClient.Disconnect;

 finally
 aClient.AllowFree:=True;
 Sys.FreeAndNil(aClient);
 Sys.FreeAndNil(aServer);
 end;
end;

destructor TIdSafeCmdTCPClient.Destroy;
begin
 Assert(AllowFree);
 inherited;
end;

initialization

  TIdTest.RegisterTest(TIdTestCmdTCPClient);

end.
