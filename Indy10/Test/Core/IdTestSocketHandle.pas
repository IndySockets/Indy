unit IdTestSocketHandle;

interface

uses
  IdSocketHandle,
  IdStack,
  IdTest,
  IdSys;

type

  TIdTestSocketHandle = class(TIdTest)
  published
    procedure TestSocketFree;
  end;

implementation

procedure TIdTestSocketHandle.TestSocketFree;
//used to be a bug with incorrect freeing critical section, then using it.
var
 s:TIdSocketHandle;
begin

 TIdStack.IncUsage;
 s:=TIdSocketHandle.Create(nil);
 try
  s.AllocateSocket;
 finally
 Sys.FreeAndNil(s);
 TIdStack.DecUsage;
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestSocketHandle);

end.
