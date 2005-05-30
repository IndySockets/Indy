unit IdTestCoder3to4;

interface

uses
  IdCoder3to4,
  IdObjs,
  IdSys,
  IdCoderBinHex4,
  IdTest;

type

  TTestIdCoder3to4 = class(TIdTest)
  published
    procedure TestCoder;
  end;

implementation

procedure TTestIdCoder3to4.TestCoder;
var
 aCoder:TIdEncoder3to4;
 aStream:TIdStringStream;
 s:string;
begin
 aStream:=TIdStringStream.Create('abc');
 aCoder:=TIdEncoderBinHex4.Create(nil);
 try
 s:=aCoder.Encode(aStream,aStream.Size);
 Assert(s='B@*M');
 finally
 Sys.FreeAndNil(aStream);
 Sys.FreeAndNil(aCoder);
 end;
end;

initialization

  TIdTest.RegisterTest(TTestIdCoder3to4);

end.
