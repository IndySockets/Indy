{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  21065: IPAddressForm.pas 
{
{   Rev 1.2    6/27/2003 01:21:26 PM  JPMugaas
{ Added test for making dotted IPv4 addresses from various forms.
}
{
{   Rev 1.1    6/27/2003 04:35:02 AM  JPMugaas
{ Added test for DWord to IPv4 address function.
}
{
{   Rev 1.0    6/26/2003 08:06:24 PM  JPMugaas
{ New test for IPv4 conversion.  The test converts from a dotted decimal
{ address to Hexidecimal, octal, and dword.
}
unit IPAddressForm;

interface

uses
  SysUtils, Classes, BXBubble;

type
  TdmodIPAddressForm = class(TDataModule)
    bxIPAddressForm: TBXBubble;
    bxDWordToIPv4: TBXBubble;
    bxConvertToDottedIPv4: TBXBubble;
    procedure bxIPAddressFormTest(Sender: TBXBubble);
    procedure bxDWordToIPv4Test(Sender: TBXBubble);
    procedure bxConvertToDottedIPv4Test(Sender: TBXBubble);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmodIPAddressForm: TdmodIPAddressForm;

implementation
uses IdCoreGlobal;

{$R *.dfm}

const
  IPTest1 = '206.191.158.55';
  IPHex1 = '0xCEBF9E37';
  IPDottedHex1 = '0xCE.0xBF.0x9E.0x37';
  IPOctal1 = '0316.0277.0236.067';
  IPDWord1 = 3468664375;

  IPTest2 = '127.0.0.1';
  IPHex2 = '0x7F000001';
  IPDottedHex2 = '0x7F.0x00.0x00.0x01';
  IPOctal2 = '0177.000.000.001';
  IPDWord2 = 2130706433;

  IPTest3 = '207.46.131.13';
  IPDWord3 = 031713501415;

procedure TdmodIPAddressForm.bxIPAddressFormTest(Sender: TBXBubble);
var LRes : String;
   LD : Cardinal;
begin
  LRes := IPv4ToHex(IPTest1);
  bxIPAddressForm.Check( LRes =IPHex1 ,'IPv4ToHex('+IPTest1+') must equal '+IPHex1+': equals '+LRes);
  LRes := IPv4ToHex(IPTest1,True);
  bxIPAddressForm.Check( LRes=IPDottedHex1 ,'IPv4ToHex('+IPTest1+',True) must equal '+IPDottedHex1+': equals '+LRes);
  LRes := IPv4ToOctal(IPTest1);
  bxIPAddressForm.Check( LRes=IPOctal1 ,'IPv4ToOctal('+IPTest1+') must equal '+IPOctal1+': equals '+LRes);
  LD := IPv4ToDWord(IPTest1);
  bxIPAddressForm.Check( LD=IPDWord1 ,'IPv4ToDWord('+IPTest1+') must equal '+IntToStr(IPDWord1)+': equals '+IntToStr(LD));

  LRes := IPv4ToHex(IPTest2);
  bxIPAddressForm.Check( LRes =IPHex2 ,'IPv4ToHex('+IPTest2+') must equal '+IPHex2+': equals '+LRes);
  LRes := IPv4ToHex(IPTest2,True);
  bxIPAddressForm.Check( LRes=IPDottedHex2 ,'IPv4ToHex('+IPTest2+',True) must equal '+IPDottedHex2+': equals '+LRes);
  LRes := IPv4ToOctal(IPTest2);
  bxIPAddressForm.Check( LRes=IPOctal2 ,'IPv4ToOctal('+IPTest2+') must equal '+IPOctal2+': equals '+LRes);
  LD := IPv4ToDWord(IPTest2);
  bxIPAddressForm.Check( LD=IPDWord2 ,'IPv4ToDWord('+IPTest2+') must equal '+IntToStr(IPDWord2)+': equals '+IntToStr(LD));

end;

procedure TdmodIPAddressForm.bxDWordToIPv4Test(Sender: TBXBubble);
var LRes : String;
begin
//MakeDWordIntoIPv4Address
  LRes := MakeDWordIntoIPv4Address(IPDWord1);
  bxDWordToIPv4.Check(LRes =IPTest1,'Must be '+IPTest1+' was '+LRes);
  LRes := MakeDWordIntoIPv4Address(IPDWord2);
  bxDWordToIPv4.Check(LRes =IPTest2,'Must be '+IPTest2+' was '+LRes);
end;

procedure TdmodIPAddressForm.bxConvertToDottedIPv4Test(Sender: TBXBubble);
//These are based on
//http://www.pc-help.org/obscure.htm
const
  EXPECTED = '206.191.158.55';
  TEST1 = '3468664375';
  TEST2 = '7763631671';
  TEST3 = '16353566263';
  TEST4 = '235396898359';
  TEST5 = '0xCeBF9e37';
  TEST6 = '0x9A3F0800CEBF9E37';
  TEST7 = '0xCE.0xBF.0x9E.0x37';
  TEST8 = '0316.0277.0236.067';
  TEST9 = '00000000316.000277.00000236.00000000067';
  TEST10 = '0xCE.191.0236.0x37';
  TEST11 = '206.12557879';
  TEST12 = '206.191.40503';
  TEST13 = '0xCE.0xBF9E37';
  TEST14 = '0xCE.0xBF.0x9E37';
  TEST15 = '0316.057717067';
  TEST16 = '0316.0xBF9E37';
  TEST17 = '206.0277.0x9E37';
var LRes : String;
begin
// DWord
//  3468664375
  LRes := MakeCanonicalIPv4Address(TEST1);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST1+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //7763631671
  LRes := MakeCanonicalIPv4Address(TEST2);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST2+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //16353566263
  LRes := MakeCanonicalIPv4Address(TEST3);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST3+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //235396898359
  LRes := MakeCanonicalIPv4Address(TEST4);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST4+' Error: Got '+LRes+' Expected: '+EXPECTED );

  //hexidecimal
  //0xCeBF9e37
  LRes := MakeCanonicalIPv4Address(TEST5);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST5+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //0x9A3F0800CEBF9E37
  LRes := MakeCanonicalIPv4Address(TEST6);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST6+' Error: Got '+LRes+' Expected: '+EXPECTED );
  // 0xCE.0xBF.0x9E.0x37
  LRes := MakeCanonicalIPv4Address(TEST7);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST7+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //octal
  //'0316.0277.0236.067'
  LRes := MakeCanonicalIPv4Address(TEST8);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST8+' Error: Got '+LRes+' Expected: '+EXPECTED );

  //00000000316.000277.00000236.00000000067
  LRes := MakeCanonicalIPv4Address(TEST8);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST8+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //'00000000316.000277.00000236.00000000067'
  LRes := MakeCanonicalIPv4Address(TEST9);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST9+' Error: Got '+LRes+' Expected: '+EXPECTED );

  //mixed formats
  //hex, dec, oct, hex
  //0xCE.191.0236.0x37
  LRes := MakeCanonicalIPv4Address(TEST10);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST10+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //206.12557879
  //dec and dword
  LRes := MakeCanonicalIPv4Address(TEST11);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST11+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //206.191.40503
  //dec, dec, dword
  LRes := MakeCanonicalIPv4Address(TEST12);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST12+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //0xCE.0xBF9E37
  //hex and hex
  LRes := MakeCanonicalIPv4Address(TEST13);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST13+' Error: Got '+LRes+' Expected: '+EXPECTED );

  //0xCE.0xBF.0x9E37
  //hex, hex, hex
  LRes := MakeCanonicalIPv4Address(TEST14);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST14+' Error: Got '+LRes+' Expected: '+EXPECTED );
 //0316.057717067
 //octal, octal
  LRes := MakeCanonicalIPv4Address(TEST15);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST15+' Error: Got '+LRes+' Expected: '+EXPECTED );
  //0316.0xBF9E37
  //octal, hex
  LRes := MakeCanonicalIPv4Address(TEST16);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST16+' Error: Got '+LRes+' Expected: '+EXPECTED );

  //206.0277.0x9E37
  //dec, octal, hex
  LRes := MakeCanonicalIPv4Address(TEST17);
  bxConvertToDottedIPv4.Check(LRes=EXPECTED,'From: '+TEST17+' Error: Got '+LRes+' Expected: '+EXPECTED );

end;

end.
