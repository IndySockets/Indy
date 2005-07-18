unit IdTestSimpleServer;

interface

uses
  IdTest,
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

uses SysUtils;

procedure TIdTestSimpleServer.TestListen;
var
 aServer:TIdSimpleServer;
 aExpect:Boolean;
begin

 aExpect:=False;
 aServer:=TIdSimpleServer.Create;
 try
  aServer.BoundPort:=22290;
  try
  //with no iohandler assigned, should get an assertion
  aServer.Listen;
  except
   on e:Exception do
    aExpect:=e is EAssertionFailed;
  end;
  Assert(aExpect);

  //add tests for normal operation

 finally
  Sys.FreeAndNil(aServer);
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestSimpleServer);

end.
