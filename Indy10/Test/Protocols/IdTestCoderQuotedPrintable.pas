unit IdTestCoderQuotedPrintable;

interface

//http://www.freesoft.org/CIE/RFC/1521/6.htm

uses
  IdCoderQuotedPrintable,
  IdStack,
  IdStream,
  IdTest,
  IdSys;

type

  TIdTestCoderQuotedPrintable = class(TIdTest)
  private
  protected
    function EncDec(const aStr:string):boolean;
  published
    procedure TestCodec;
  end;

implementation

//this should be elsewhere, or a proper function
function StrRight(const aStr:string;const aCount:integer):string;
begin
  Result:=Copy(aStr,Length(aStr)-aCount+1,aCount);
end;

function TIdTestCoderQuotedPrintable.EncDec;
//do a round-trip encode>decode, and check
var
 aEnc,aDec:string;
 aExpect:string;
begin
 aEnc:=TIdEncoderQuotedPrintable.EncodeString(aStr);
 aDec:=TIdDecoderQuotedPrintable.DecodeString(aEnc);

 //seems that it adds a crlf if not already there
 if StrRight(aStr,2)=#13#10 then aExpect:=aStr
 else aExpect:=aStr+#13#10;

 Result:=(aDec=aExpect);
end;

procedure TIdTestCoderQuotedPrintable.TestCodec;
var
 s:string;
const
 cStr='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
begin

 //should do a loop from 1..100?
 s:=cStr+#13#10;
 Assert(EncDec(s));

 Assert(EncDec('one'#13#10'.two.'#13#10));

 Assert(EncDec('='));

 Assert(EncDec('1aAzZ<>!@#$%^&*()-=/;[]"'));

 Assert(EncDec('.'));

 Assert(EncDec('.test.'));

 Assert(EncDec('.line1.'#13#10'.line2.'));

end;

initialization

  TIdTest.RegisterTest(TIdTestCoderQuotedPrintable);

end.
