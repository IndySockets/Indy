unit IdTestCoderHeader;

//http://www.faqs.org/rfcs/rfc1522.html

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
 cIn1='This is a simple test for MIME encoding simple =?Windows-1252?Q?=7F?= strings.';
 cOut1 = 'This is a simple test for MIME encoding simple '#127' strings.';

 cIn2='=?iso-8859-1?Q?J=F6rg_Meier?= <briefe@jmeiersoftware.de>';
 cOut2='Jörg Meier <briefe@jmeiersoftware.de>';

 cIn3='böb <bob@example.com>';
 cOut3='=?ISO-8859-1?Q?b=F6b?= <bob@example.com>';

 //not legal to have special chars in actual address?
 //cIn4='böb <böb@example.cöm>';
 //cOut4='=?ISO-8859-1?Q?b=F6b <b=F6b@example.c=F6m>?=';
var
 s:string;
begin

 //from TIdMessage.GenerateHeader
 //s := DecodeHeader(cIn1);
 //Assert(s = cOut1);

 s:=DecodeHeader('=?iso-8859-1?q?this=20is=20some=20text?=');
 Assert(s='this is some text',s);
 //edge case
{ s:=DecodeHeader('');
 Assert(s='');

 s:=DecodeHeader(cIn1);
 Assert(s=cOut1);

 s:=EncodeHeader(cIn3,'','Q',bit8,'ISO-8859-1');
 Assert(s=cOut3);
 s:=DecodeHeader(cOut3);
 Assert(s=cIn3);}

 //encodes leaving a space as-is, then aborts decode due to the space
 //IdCoderHeader 306: if CharIsInSet(Header, i, Whitespace) then begin
 {
 s:=EncodeHeader(cIn4,'','Q',bit8,'ISO-8859-1');
 Assert(s=cOut4);
 s:=DecodeHeader(cOut4);
 Assert(s=cIn4,s);
 }
end;

initialization

  TIdTest.RegisterTest(TIdTestCoderHeader);

end.
