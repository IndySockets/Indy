unit IdTestObjs;

interface

uses
  IdSys,
  IdTest,
  IdObjs;

type

  TIdTestStringStream = class(TIdTest)
  published
    procedure TestStream;
  end;

implementation

procedure TIdTestStringStream.TestStream;
var
 aStream:TIdStringStream;
const
 cStr='123';
 cStr2='abc';
begin
 aStream:=TIdStringStream.Create(cStr);
 try
   //check initial value
   Assert(aStream.DataString=cStr);

   //check reset
   aStream.Size:=0;
   Assert(aStream.DataString='');

   //check write
   aStream.WriteString(cStr);
   Assert(aStream.DataString=cStr);

   //check append
   aStream.WriteString(cStr);
   Assert(aStream.DataString=cStr+cStr);

   //check overwrite
   aStream.Position:=0;
   aStream.WriteString(cStr2);
   Assert(aStream.DataString=cStr2+cStr);

 finally
   Sys.FreeAndNil(aStream);
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestStringStream);

end.
