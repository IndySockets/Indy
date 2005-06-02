unit IdTestHTTP;

interface

uses
  IdSys,
  IdContext,
  IdTCPServer,
  IdTest,
  IdHTTP;

type

  //this test shows a memory leak due to AResponse.KeepAlive being called in a
  //finally block, and raising an exception.
  //seperate test class as it has private callbacks for the server
  //the actual result of this test (a memory leak) will only properly be detected
  //on application shutdown, when running an appropriate memory checker
  TIdTestHTTP_01 = class(TIdTest)
  private
    procedure CallbackExecute(AContext:TIdContext);
  published
    procedure TestMemoryLeak;
  end;

implementation

procedure TIdTestHTTP_01.CallbackExecute(AContext: TIdContext);
begin
  AContext.Connection.Disconnect;
end;

procedure TIdTestHTTP_01.TestMemoryLeak;
var
 aClient:TIdHTTP;
 aServer:TIdTCPServer;
begin
 aClient:=TIdHTTP.Create(nil);
 aServer:=TIdTCPServer.Create(nil);
 try
 aServer.DefaultPort:=20202;
 aServer.OnExecute:=Self.CallbackExecute;
 aServer.Active:=True;

 //the circumstances for the memory leak also require a ConnectionTimeout
 //haven't investigated why
 aClient.ConnectTimeout:=2000;
 try
 aClient.Get('http://127.0.0.1:20202');
 except
 //we're expecting this exception, ignore it
 end;

 finally
 Sys.FreeAndNil(aClient);
 Sys.FreeAndNil(aServer);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestHTTP_01);

end.
