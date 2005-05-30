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

 cIn2='=?iso-8859-1?Q?J=F6rg_Meier?= <briefe@jmeiersoftware.de>';
 cOut2='Jörg Meier <briefe@jmeiersoftware.de>';

 cIn3='böb <bob@example.com>';
 cOut3='=?ISO-8859-1?Q?b=F6b?= <bob@example.com>';

 cIn4='böb <böb@example.cöm>';
 cOut4='=?ISO-8859-1?Q?b=F6b <b=F6b@example.c=F6m>?=';
var
 s:string;
begin

 //from TIdMessage.GenerateHeader

 //edge case
 s:=DecodeHeader('');
 Assert(s='');

 //s:=DecodeHeader(cIn1);
 //Assert(s=cOut1);

 s:=EncodeHeader(cIn3,'','Q',bit8,'ISO-8859-1');
 Assert(s=cOut3);
 s:=DecodeHeader(cOut3);
 Assert(s=cIn3);

 s:=EncodeHeader(cIn4,'','Q',bit8,'ISO-8859-1');
 Assert(s=cOut4);
 s:=DecodeHeader(cOut4);
 Assert(s=cIn4,s);

end;

initialization

  TIdTest.RegisterTest(TIdTestCoderHeader);

end.
