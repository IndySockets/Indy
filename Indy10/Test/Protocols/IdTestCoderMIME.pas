unit IdTestCoderMIME;

interface

uses
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
 cEnc1: string='TWFya3RlaW5m/GhydW5nIGVpbmVzIHb2bGxpZyBuZXVlbiBLb256ZXB0cw==';
 cDec1 = 'Markteinführung eines völlig neuen Konzepts';

procedure TIdTestCoderMIME.TestDecodeMIME;
var
 s:string;
begin
 s:=TIdDecoderMIME.DecodeString(cEnc1);
 Assert(s=cDec1);
end;

procedure TIdTestCoderMIME.TestDecodeLineByLine;
var
 s: string;
 d: TIdDecoderMIMELineByLine;
 TempStream: TIdMemoryStream;
begin
 s:=TIdDecoderMIMELineByLine.DecodeString(cEnc1);
 Assert(s=cDec1,s);
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
