unit IdTestCoderHeader;

interface

uses
  IdCoderHeader,
  IdTest;

type

  TIdTestCoderHeader = class(TIdTest)
  published
    procedure TestDecodeHeader;
  end;

implementation

procedure TIdTestCoderHeader.TestDecodeHeader;
const
 //bug, used to decode to: 'Markteinführung einesMarkteinführung eines völlig neuen Konzepts'
 cIn1='=?Windows-1252?B?TWFya3RlaW5m/GhydW5nIGVpbmVz?='
  +'=?Windows-1252?B?IHb2bGxpZyBuZXVlbiBLb256ZXB0cw==?=';
 cOut1='Markteinführung eines völlig neuen Konzepts';
var
 s:string;
begin
 //edge case
 s:=DecodeHeader('');
 Assert(s='');

 //3175ms for 10000 loops in old version
 //2493ms in new
 s:=DecodeHeader(cIn1);
 Assert(s=cOut1);

end;

initialization

  TIdTest.RegisterTest(TIdTestCoderHeader);

end.
