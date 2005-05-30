unit IdTestCoderMIME;

interface

uses
  IdCoderMIME,
  IdSys,
  IdTest;

type

  TIdTestCoderMIME = class(TIdTest)
  published
    procedure TestDecodeLineByLine;
    procedure TestDecodeMIME;
  end;

implementation

const
 cEnc1:string='TWFya3RlaW5m/GhydW5nIGVpbmVzIHb2bGxpZyBuZXVlbiBLb256ZXB0cw==';
 cDec1='Markteinführung eines völlig neuen Konzepts';

procedure TIdTestCoderMIME.TestDecodeMIME;
var
 s:string;
begin
 s:=TIdDecoderMIME.DecodeString(cEnc1);
 Assert(s=cDec1);
end;

procedure TIdTestCoderMIME.TestDecodeLineByLine;
var
 s:string;
begin
 s:=TIdDecoderMIMELineByLine.DecodeString(cEnc1);
 Assert(s=cDec1,s);
end;

initialization

  TIdTest.RegisterTest(TIdTestCoderMIME);

end.
