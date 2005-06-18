unit IdTestGlobal;

interface

uses
  IdTest,
  IdGlobal;

type

  TIdTestGlobal = class(TIdTest)
  published
    procedure TestToBytes;
  end;

implementation

procedure TIdTestGlobal.TestToBytes;
const
  cTestString1 = 'U';
var
  aBytes : TIdBytes;
begin
  //test string
  aBytes := ToBytes(cTestString1);
  Assert(Length(aBytes)=1);
  Assert(aBytes[0] = 85);

  //todo, test other types
end;

initialization

  TIdTest.RegisterTest(TIdTestGlobal);

end.