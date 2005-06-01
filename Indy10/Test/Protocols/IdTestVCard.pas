unit IdTestVCard;

interface

uses
  IdSys,
  IdTest,
  IdObjs,
  IdVCard;

type

  TIdTestVCard = class(TIdTest)
  published
    procedure TestLoad;
  end;

implementation

const
  cEol=#13#10;

  cName='Holmes;Sherlock;;Mr';
  cFullName='Sherlock Holmes';
  cCompany='Example Company';
  cPhoneWorkVoice='+49 (555) 12345';
  cEmail='sherlock@example.com';
  cAddrPOBox='My PO Box';
  cAddrPostCode='12345';
  cAddrLocality='My Locality';
  cAddrNation='My Nation';
  cAddrStreet='My Street';
  cAddrRegion='My Region';

  cData='BEGIN:VCARD'+cEol
 +'BEGIN:VCARD'+cEol
 +'VERSION:2.1'+cEol
 +'N:'+cName+cEol
 +'FN:'+cFullName+cEol
 +'ORG:'+cCompany+cEol
 +'TEL;WORK;VOICE:'+cPhoneWorkVoice+cEol
 +'ADR;WORK:'+cAddrPOBox+';'+';'+cAddrStreet+';'+cAddrLocality+';'+cAddrRegion+';'+cAddrPostCode+';'+cAddrNation+cEol
 //LABEL;WORK;ENCODING=QUOTED-PRINTABLE:Testroad 1=0D=0AEntenhausen 12345=0D=0ADeutschland
 +'EMAIL;PREF;INTERNET:'+cEMail+cEol
 //REV:20050531T195358Z
 +'END:VCARD';

procedure TIdTestVCard.TestLoad;
//could also test
var
 aCard:TIdVCard;
 aList:TIdStringList;
 aPhone:TIdCardPhoneNumber;
 aMail:TIdVCardEMailItem;
 aAddr:TIdCardAddressItem;
begin
 aCard:=TIdVCard.Create(nil);
 aList:=TIdStringList.Create;
 try
 aList.Text:=cData;
 aCard.ReadFromTStrings(aList);

 Assert(aCard.Telephones.Count=1);
 aPhone:=aCard.Telephones[0];
 Assert(aPhone.Number=cPhoneWorkVoice);
 Assert(aPhone.PhoneAttributes=[tpaWork,tpaVoice]);

 Assert(aCard.EMailAddresses.Count=1);
 aMail:=aCard.EMailAddresses[0];
 Assert(aMail.Preferred);
 Assert(aMail.Address=cEmail);
 Assert(aMail.EMailType=ematInternet);

 Assert(aCard.Addresses.Count=1);
 aAddr:=aCard.Addresses[0];
 Assert(aAddr.AddressAttributes=[tatWork]);
 Assert(aAddr.Nation=cAddrNation);
 Assert(aAddr.PostalCode=cAddrPostCode);
 Assert(aAddr.POBox=cAddrPOBox);
 Assert(aAddr.Locality=cAddrLocality);
 Assert(aAddr.StreetAddress=cAddrStreet);
 Assert(aAddr.Region=cAddrRegion);

 //LastRevised isnt published by vcard, fix?

 //fails, bug in procedure ParseOrg
 Assert(aCard.BusinessInfo.Organization=cCompany);

 finally
 Sys.FreeAndNil(aCard);
 Sys.FreeAndNil(aList);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestVCard);

end.
