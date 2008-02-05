unit IdTestSchedulerOfThreadPool;

interface

uses
  IdTest,
  IdSchedulerOfThreadPool,
  IdSys,
  IdCmdTCPServer;

type

  TIdTestSchedulerOfThreadPool = class(TIdTest)
  published
    procedure TestFree;
  end;

implementation

procedure TIdTestSchedulerOfThreadPool.TestFree;
//tests that a simple start/stop doesn't cause errors
var
 //better to use a simple tcpserver?
 aServer:TIdCmdTCPServer;
 aSchedule:TIdSchedulerOfThreadPool;
begin
 aServer:=TIdCmdTCPServer.Create(nil);
 aSchedule:=TIdSchedulerOfThreadPool.Create(nil);
 try
 aSchedule.PoolSize:=2;
 aServer.Scheduler:=aSchedule;
 //should set a port?
 aServer.Active:=True;
 //let things stabilize
 //Sleep(200);
 aServer.Active:=False;
 finally
 Sys.FreeAndNil(aServer);
 Sys.FreeAndNil(aSchedule);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestSchedulerOfThreadPool);

end.
