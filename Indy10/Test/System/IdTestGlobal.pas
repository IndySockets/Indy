unit IdTestGlobal;

interface

uses
  IdTest,
  IdGlobal;

type

  TIdTestGlobal = class(TIdTest)
  published
    procedure TestToBytes;
    procedure TestBytesToChar;
  end;

implementation

procedure TIdTestGlobal.TestBytesToChar;
var
  aBytes:TIdBytes;
  aChar:char;
begin
  //test normal behaviour
  SetLength(aBytes,1);
  aBytes[0]:=$31;
  aChar:=BytesToChar(aBytes);
  Assert(aChar='1');

  //should fail trying to read from empty buffer
  SetLength(aBytes,0);
  try
  BytesToChar(aBytes);
  Assert(False);
  except
  //expect to be here
  end;

  //should fail trying to read from nil buffer
  aBytes:=nil;
  try
  BytesToChar(aBytes);
  Assert(False);
  except
  //expect to be here
  end;

end;

procedure TIdTestGlobal.TestToBytes;
const
  cTestString1 = 'U';
  cTestChar = 'U';
var
  aBytes : TIdBytes;
begin
  //test string
  aBytes := ToBytes(cTestString1);
  Assert(Length(aBytes)=1);
  Assert(aBytes[0] = 85);

  //test char
  aBytes := ToBytes(cTestChar);
  Assert(Length(aBytes)=1);
  Assert(aBytes[0] = 85);

  //todo, test other types
end;

initialization

  TIdTest.RegisterTest(TIdTestGlobal);

end.