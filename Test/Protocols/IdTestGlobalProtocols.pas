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
    procedure TestStrToWord;
    procedure TestMimeTable;
  end;

implementation

procedure TIdTestGlobalProtocols.TestStrToWord;
begin
  //edge case
  StrToWord('');
end;

procedure TIdTestGlobalProtocols.TestRPos;
begin
  Assert(RPos(' ', 'Hello, World!', -1) = 7);
  Assert(RPos('_', 'Hello, World!', -1) = 0);
end;

procedure TIdTestGlobalProtocols.TestMimeTable;
var
  m:TIdMimeTable;
begin
  m:=TIdMimeTable.Create(False);
  try
    m.LoadTypesFromOS:=True;
    m.BuildCache;
  finally
    Sys.FreeAndNil(m);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestGlobalProtocols);

end.