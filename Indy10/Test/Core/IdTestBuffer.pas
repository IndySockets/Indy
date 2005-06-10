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
    procedure TestStream;
  end;

implementation

procedure TIdTestBuffer.TestStream;
var
 aBuffer:TIdBuffer;
 aStream:TIdStringStream;
begin
 aBuffer:=TIdBuffer.Create;
 aStream:=TIdStringStream.Create('');
 try
 aBuffer.Write('12345');
 aBuffer.SaveToStream(aStream);
 finally
 Sys.FreeAndNil(aStream);
 Sys.FreeAndNil(aBuffer);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestBuffer);

end.
