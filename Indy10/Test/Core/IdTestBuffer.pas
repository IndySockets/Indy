unit IdTestBuffer;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdGlobal,
  IdBuffer;

type

  TIdTestBuffer = class(TIdTest)
  published
    procedure TestBufferToStream;
    procedure TestStreamToBuffer;
    procedure TestTypes;
  end;

implementation

const
 cString='12345';

procedure TIdTestBuffer.TestBufferToStream;
var
 aBuffer:TIdBuffer;
 aStream:TIdMemoryStream;
begin
 aBuffer:=TIdBuffer.Create;
 aStream:=TIdMemoryStream.Create;
 try
 aBuffer.Write(cString);
 aBuffer.SaveToStream(aStream);
 aStream.Position := 0;
 Assert(ReadStringFromStream(aStream)=cString);
 Assert(aBuffer.Size=5);

 //extract with index=-1 and >0 to test execution paths

 //index>-1 doesn't delete data from buffer
 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,2,3);
 aStream.Position := 0;
 Assert(ReadStringFromStream(aStream)='45');
 Assert(aBuffer.Size=5);

 //does delete data from buffer
 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,3);
 aStream.Position := 0;
 Assert(ReadStringFromStream(aStream)='123');
 Assert(aBuffer.Size=2);

 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,2);
 aStream.Position := 0;
 Assert(ReadStringFromStream(aStream)='45');
 Assert(aBuffer.Size=0);

 finally
 Sys.FreeAndNil(aStream);
 Sys.FreeAndNil(aBuffer);
 end;
end;

procedure TIdTestBuffer.TestStreamToBuffer;
var
 aBuffer:TIdBuffer;
 aStream:TIdMemoryStream;
begin
 aBuffer:=TIdBuffer.Create;
 aStream:=TIdMemoryStream.Create;
 try
   WriteStringToStream(AStream, cString);
 aStream.Position:=0;

 //copy specific
 aBuffer.Write(aStream,2);
 Assert(aStream.Position=2);
 Assert(aBuffer.AsString='12');
// aStream.Position := 0;
 //copy remaining
 aBuffer.Write(aStream,-1);
 Assert(aStream.Position=5);
 Assert(aBuffer.AsString=cString, aBuffer.AsString);

 //copy all. ensure stream position is >0,<size
 aBuffer.Clear;
 aStream.Position:=2;
 aBuffer.Write(aStream);
 Assert(aStream.Position=5);
 Assert(aBuffer.AsString=cString);

 finally
 Sys.FreeAndNil(aStream);
 Sys.FreeAndNil(aBuffer);
 end;
end;

procedure TIdTestBuffer.TestTypes;
var
  b:TIdBuffer;
  //aInt:Integer;
  i64:Int64;
  aCardinal:Cardinal;
  aWord:Word;
  aByte:Byte;
const
  //cInteger=2000000000;
  cCardinal=4000000000;
  cCardinal2=4000000001;
  c64=5000000000;
  c642=5000000001;
  cWord=60000;
  cWord2=60001;
  cByte=250;
  cByte2=255;
begin
  b:=TIdBuffer.Create;
  try

  {
  //integer currently gets sent to the int64 overload
  aInt:=cInteger;
  b.Write(aInt);
  aInt:=Integer(b.ExtractToCardinal(0));
  Assert(aInt=cInteger);
  Assert(b.Size=0);
  }

  //write 2 different bytes
  aByte:=cByte;
  b.Write(aByte);
  Assert(b.Size=SizeOf(Byte));
  aByte:=cByte2;
  b.Write(aByte);
  Assert(b.Size=2*SizeOf(Byte));
  //read the 2nd byte. index>-1 so doesnt actually extract
  aByte:=b.ExtractToByte(SizeOf(Byte));
  Assert(b.Size=2*SizeOf(Byte));
  Assert(aByte=cByte2);
  //and extract the data, check expected order (FIFO)
  aByte:=b.ExtractToByte(-1);
  Assert(aByte=cByte);
  Assert(b.Size=SizeOf(Byte));
  aByte:=b.ExtractToByte(-1);
  Assert(aByte=cByte2);
  Assert(b.Size=0);

  aCardinal:=cCardinal;
  b.Write(aCardinal);
  aCardinal:=cCardinal2;
  b.Write(aCardinal);
  Assert(b.Size=2*SizeOf(Cardinal));
  aCardinal:=b.ExtractToCardinal(SizeOf(Cardinal));
  Assert(b.Size=2*SizeOf(Cardinal));
  Assert(aCardinal=cCardinal2);
  aCardinal:=b.ExtractToCardinal(-1);
  Assert(aCardinal=cCardinal);
  aCardinal:=b.ExtractToCardinal(-1);
  Assert(aCardinal=cCardinal2);
  Assert(b.Size=0);

  i64:=c64;
  b.Write(i64);
  i64:=c642;
  b.Write(i64);
  Assert(b.Size=2*SizeOf(Int64));
  i64:=b.ExtractToInt64(SizeOf(Int64));
  Assert(i64=c642);
  Assert(b.Size=2*SizeOf(Int64));
  i64:=b.ExtractToInt64(-1);
  Assert(i64=c64);
  i64:=b.ExtractToInt64(-1);
  Assert(i64=c642);
  Assert(b.Size=0);

  aWord:=cWord;
  b.Write(aWord);
  aWord:=cWord2;
  b.Write(aWord);
  Assert(b.Size=2*SizeOf(Word));
  aWord:=b.ExtractToWord(SizeOf(Word));
  Assert(aWord=cWord2);
  Assert(b.Size=2*SizeOf(Word));
  aWord:=b.ExtractToWord(-1);
  Assert(aWord=cWord);
  aWord:=b.ExtractToWord(-1);
  Assert(aWord=cWord2);
  Assert(b.Size=0);

  finally
  Sys.FreeAndNil(b);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestBuffer);

end.
