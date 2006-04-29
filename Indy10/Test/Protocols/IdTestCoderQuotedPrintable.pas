unit IdTestCoderQuotedPrintable;

interface

//http://www.freesoft.org/CIE/RFC/1521/6.htm

uses
  IdCoder,
  IdCoderQuotedPrintable,
  IdObjs,
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
 aList:TIdStringList;
 i:Integer;
begin
 aEnc:=EncodeString(TIdEncoderQuotedPrintable,aStr);

 //check that no lines start with a .
 aList:=TIdStringList.Create;
 try
 aList.Text:=aEnc;
 for i:=0 to aList.Count-1 do
  begin
  if aList[i]='' then Continue;
  if aList[i][1]='.' then Assert(False,aList[i]);
  end;
 finally
 Sys.FreeAndNil(aList);
 end;

 aDec:=DecodeString(TIdDecoderQuotedPrintable,aEnc);

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

 s:=EncodeString(TIdEncoderQuotedPrintable,'abc   ');
 Assert(s='abc  =20'#13#10);

 s:=EncodeString(TIdEncoderQuotedPrintable,'...');
 Assert(s='=2E..'#13#10);

 s:='123456789 123456789 123456789 123456789 123456789 123456789 123456789 .23456789';
 Assert(EncDec(s));

end;

initialization

  TIdTest.RegisterTest(TIdTestCoderQuotedPrintable);

end.
