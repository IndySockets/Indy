unit IdTestGlobal;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdGlobal;

type

  TIdTestGlobal = class(TIdTest)
  published
    procedure TestToBytes;
    procedure TestBytesToChar;
    procedure TestReadStringFromStream;
    procedure TestReadTIdBytesFromStream;
  end;

implementation

procedure TIdTestGlobal.TestReadStringFromStream;
var
  TempStream: TIdMemoryStream;
begin
  TempStream := TIdMemoryStream.Create;
  try
    Assert(ReadStringFromStream(TempStream) = '');
  finally
    Sys.FreeAndNil(TempStream);
  end;
end;

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
  cTestString1 = 'UA';
  cTestChar = 'U';
var
  aBytes : TIdBytes;
begin
  //test string
  aBytes := ToBytes(cTestString1);
  Assert(Length(aBytes)=2);
  Assert(aBytes[0] = 85);
  Assert(aBytes[1] = 65);

  //test char
  aBytes := ToBytes(cTestChar);
  Assert(Length(aBytes)=1);
  Assert(aBytes[0] = 85);

  //todo, test other types
end;

procedure TIdTestGlobal.TestReadTIdBytesFromStream;
var
  aStream:TIdMemoryStream;
  aBytes:TIdBytes;
  aStr:string;
const
  cStr='123';
begin
  aStream:=TIdMemoryStream.Create;
  try
  WriteStringToStream(aStream,cStr);
  aStream.Position:=0;
  ReadTIdBytesFromStream(aStream,aBytes,-1);
  aStr:=BytesToString(aBytes);
  Assert(aStr=cStr);
  finally
  Sys.FreeAndNil(aStream);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestGlobal);

end.