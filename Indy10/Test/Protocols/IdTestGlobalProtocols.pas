unit IdTestGlobalProtocols;

interface

uses
  IdGlobal,
  IdObjs,
  IdGlobalProtocols,
  IdSys,
  IdTest;

type
  TIdTestGlobalProtocols = class(TIdTest)
  published
    procedure TestRPos;
  end;

implementation

procedure TIdTestGlobalProtocols.TestRPos;
begin
  Assert(RPos(' ', 'Hello, World!', -1) = 7);
  Assert(RPos('_', 'Hello, World!', -1) = 0);
end;

initialization
  TIdTest.RegisterTest(TIdTestGlobalProtocols);
end.