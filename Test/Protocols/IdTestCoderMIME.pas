unit IdTestCoderMIME;

interface

uses
  IdCoder,
  IdCoderMIME,
  IdSys,
  IdGlobal,
  IdObjs,
  IdTest;

type

  TIdTestCoderMIME = class(TIdTest)
  published
    procedure TestDecodeLineByLine;
    procedure TestDecodeMIME;
  end;

implementation

const
 cEnc1: string = 'VGhpcyBpcyBhIHNpbXBsZSB0ZXN0IGZvciBNSU1FIGVuY29kaW5nIHNpbXBsZSBzdHJpbmdzLg==';
 cDec1 = 'This is a simple test for MIME encoding simple strings.';

procedure TIdTestCoderMIME.TestDecodeMIME;
var
 s:string;
begin
 s:=DecodeString(TIdDecoderMIME,cEnc1);
 Assert(s=cDec1);
end;

procedure TIdTestCoderMIME.TestDecodeLineByLine;
var
 s: string;
 d: TIdDecoderMIMELineByLine;
 TempStream: TIdMemoryStream;
begin
 //using class method
 s:=DecodeString(TIdDecoderMIMELineByLine,cEnc1);
 Assert(s=cDec1,s);

 //using 'manually'
 d := TIdDecoderMIMELineByLine.Create;
 try
  TempStream := TIdMemoryStream.Create;
  try
   d.DecodeBegin(TempStream);
   d.Decode(cEnc1);
   TempStream.Position := 0;
   s := ReadStringFromStream(TempStream);
   Assert(s = cDec1, Sys.Format('Is "%s", should be "%s"', [s, cDec1]));
  finally
   d.DecodeEnd;
   Sys.FreeAndNil(TempStream);
  end;
 finally
  Sys.FreeAndNil(d);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestCoderMIME);

end.
