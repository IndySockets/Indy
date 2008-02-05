unit IdTestGlobal;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdException,
  IdGlobal;

type

  TIdTestGlobal = class(TIdTest)
  published
    procedure TestToBytes;
    procedure TestBytesToChar;
    procedure TestReadStringFromStream;
    procedure TestReadTIdBytesFromStream;
    procedure TestBytesToString;
    procedure TestPosIdx;
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

procedure TIdTestGlobal.TestBytesToString;
var
  aBytes:TIdBytes;
  aStr:string;
  aExpected:Boolean;
const
  cStr='12345';
begin
  aBytes := ToBytes(cStr);

  aStr:=BytesToString(aBytes);
  Assert(aStr=cStr);

  aStr:=BytesToString(aBytes,0,0);
  Assert(aStr='');

  aStr:=BytesToString(aBytes,0,1);
  Assert(aStr='1');

  aStr:=BytesToString(aBytes,1,1);
  Assert(aStr='2');

  aStr:=BytesToString(aBytes,4,1);
  Assert(aStr='5');

  aStr:=BytesToString(aBytes,0,5);
  Assert(aStr=cStr);

  //start past end of buffer
  aExpected:=False;
  try
  aStr:=BytesToString(aBytes,5,1);
  Assert(aStr='5');
  except
  on e:Exception do
   begin
   aExpected:=e is EIdRangeException;
   end;
  end;
  Assert(aExpected);

  //read past end of buffer
  aStr:=BytesToString(aBytes,0,10);
  Assert(aStr=cStr);

end;

procedure TIdTestGlobal.TestPosIdx;
var
  i:Integer;
begin
  i:=PosIdx('1234','12345',4);
  Assert(i=0);

  i:=PosIdx('23','12345',0);
  Assert(i=2);

  i:=PosIdx('23','12345',2);
  Assert(i=2);

  i:=PosIdx('a','12345',2);
  Assert(i=0);

  i:=PosIdx('123','1');
  Assert(i=0);
end;

initialization

  TIdTest.RegisterTest(TIdTestGlobal);

end.