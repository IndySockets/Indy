unit IdTestStreamHelper;

interface

uses
  IdObjs,
  IdTest,
  IdSys,
  IdGlobal,
  IdStream;

type

  TIdTestStreamHelper = class(TIdTest)
  published
    procedure TestHelper;
  end;

implementation

procedure TIdTestStreamHelper.TestHelper;
var
 aStream:TIdMemoryStream;
 aBuffer,aBuffer2:TIdBytes;
 aStr:string;
const
 cText='0123456789';
begin

 aStream:=TIdMemoryStream.Create;
 try

 //text to buffer
 aBuffer:=ToBytes(cText);
 aStr:=BytesToString(aBuffer);
 Assert(aStr=cText);

 //buffer to stream
 TIdStreamHelper.Write(aStream,aBuffer);
 aStream.Position:=0;
 aStr:=ReadStringFromStream(aStream);
 Assert(aStr=cText);

 //stream to buffer
 TIdStreamHelper.ReadBytes(aStream,aBuffer2);
 aStr:=BytesToString(aBuffer);
 Assert(aStr=cText);

 //test read offsets
 //put the first char in stream into buffer[5]
 aBuffer:=ToBytes(cText);
 aStream.Size:=0;
 TIdStreamHelper.Write(aStream,aBuffer);
 aStream.Position:=0;
 TIdStreamHelper.ReadBytes(aStream,aBuffer,1,5);
 aStr:=BytesToString(aBuffer);
 Assert(aStr='0123406789');

 //test buffer to stream using count
 aBuffer:=ToBytes(cText);
 aStream.Size:=0;
 TIdStreamHelper.Write(aStream,aBuffer);
 aStream.Position:=2;
 TIdStreamHelper.Write(aStream,aBuffer,3);
 aStream.Position:=0;
 aStr:=ReadStringFromStream(aStream);
 Assert(aStr='0101256789');

 //test limits. try to write more bytes than available in buffer
 aBuffer:=ToBytes(cText);
 aStream.Size:=0;
 TIdStreamHelper.Write(aStream,aBuffer,100);
 aStream.Position:=0;
 aStr:=ReadStringFromStream(aStream);
 Assert(aStr=cText);

 finally
 Sys.FreeAndNil(aStream);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestStreamHelper);

end.
