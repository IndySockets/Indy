unit IdTestBuffer;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdBuffer;

type

  TIdTestBuffer = class(TIdTest)
  published
    procedure TestBufferToStream;
    procedure TestStreamToBuffer;
  end;

implementation

const
 cString='12345';

procedure TIdTestBuffer.TestBufferToStream;
var
 aBuffer:TIdBuffer;
 aStream:TIdStringStream;
begin
 aBuffer:=TIdBuffer.Create;
 aStream:=TIdStringStream.Create('');
 try
 aBuffer.Write(cString);

 aBuffer.SaveToStream(aStream);
 Assert(aStream.DataString=cString);
 Assert(aBuffer.Size=5);

 //extract with index=-1 and >0 to test execution paths

 //index>-1 doesn't delete data from buffer
 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,2,3);
 Assert(aStream.DataString='45');
 Assert(aBuffer.Size=5);

 //does delete data from buffer
 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,3);
 Assert(aStream.DataString='123');
 Assert(aBuffer.Size=2);

 aStream.Size:=0;
 aBuffer.ExtractToStream(aStream,2);
 Assert(aStream.DataString='45');
 Assert(aBuffer.Size=0);

 finally
 Sys.FreeAndNil(aStream);
 Sys.FreeAndNil(aBuffer);
 end;
end;

procedure TIdTestBuffer.TestStreamToBuffer;
var
 aBuffer:TIdBuffer;
 aStream:TIdStringStream;
begin
 aBuffer:=TIdBuffer.Create;
 aStream:=TIdStringStream.Create('');
 try
 aStream.WriteString(cString);
 aStream.Position:=0;

 //copy specific
 aBuffer.Write(aStream,2);
 Assert(aStream.Position=2);
 Assert(aBuffer.AsString='12');

 //copy remaining
 aBuffer.Write(aStream,-1);
 Assert(aStream.Position=5);
 Assert(aBuffer.AsString=cString);

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

initialization

  TIdTest.RegisterTest(TIdTestBuffer);

end.
