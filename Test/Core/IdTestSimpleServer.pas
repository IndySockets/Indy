unit IdTestSimpleServer;

interface

uses
  IdTest,
  IdExceptionCore,
  IdObjs,
  IdSys,
  IdGlobal,
  IdSimpleServer;

type

  TIdTestSimpleServer = class(TIdTest)
  published
    procedure TestListen;
  end;

implementation

procedure TIdTestSimpleServer.TestListen;
var
 aServer:TIdSimpleServer;
 aOk:Boolean;
begin

 aServer:=TIdSimpleServer.Create;
 try
  aServer.BoundPort:=22290;

  try
   aOk:=False;
   aServer.Listen(1000);
  except
   on e:EIdAcceptTimeout do aOk:=True;
  end;
  Assert(aOk);
  //add tests for normal operation

 finally
  Sys.FreeAndNil(aServer);
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestSimpleServer);

end.
