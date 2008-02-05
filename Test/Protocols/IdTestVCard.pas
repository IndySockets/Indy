unit IdTestVCard;

{
http://www.faqs.org/rfcs/rfc2425.html A MIME Content-Type for Directory Information
http://www.faqs.org/rfcs/rfc2426.html vCard MIME Directory Profile
http://www.faqs.org/rfcs/rfc2739.html Calendar Attributes for vCard and LDAP
}

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
    procedure TestParseDateTime;
  end;

implementation

const
  cEol=#13#10;

  cName='Holmes;Sherlock;;Mr';
  cFullName='Sherlock Holmes';
  //should test with more variations here
  cCompany='Example Company';
  cDivisions='Division 1;Division 2';
  cPhoneWorkVoice='+49 (555) 12345';
  cEmail='sherlock@example.com';

  {
  The structured type value corresponds,
  in sequence, to the post office box; the extended address; the street
  address; the locality (e.g., city); the region (e.g., state or
  province); the postal code; the country Name.
  }
  cAddrPOBox='My PO Box';
  cAddrExtended='More Address';
  cAddrStreet='My Street';
  cAddrLocality='My Locality';
  cAddrRegion='My Region';
  cAddrPostCode='12345';
  cAddrNation='My Nation';

  cData='BEGIN:VCARD'+cEol
 +'BEGIN:VCARD'+cEol
 +'VERSION:2.1'+cEol
 +'N:'+cName+cEol
 +'FN:'+cFullName+cEol
 +'ORG:'+cCompany+';'+cDivisions+cEol
 +'TEL;WORK;VOICE:'+cPhoneWorkVoice+cEol
 +'ADR;WORK:'+cAddrPOBox+';'+cAddrExtended+';'+cAddrStreet+';'+cAddrLocality+';'+cAddrRegion+';'+cAddrPostCode+';'+cAddrNation+cEol
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
 aCard.ReadFromStrings(aList);

 Assert(aCard.Telephones.Count=1);
 aPhone:=aCard.Telephones[0];
 Assert(aPhone.Number=cPhoneWorkVoice);
 Assert(aPhone.PhoneAttributes=[tpaWork,tpaVoice]);

 Assert(aCard.EMailAddresses.Count=1);
 aMail:=aCard.EMailAddresses[0];
 Assert(aMail.Preferred);
 Assert(aMail.Address=cEmail);
 Assert(aMail.EMailType=ematInternet);

 //see rfc2426 3.2.1 ADR Type Definition
 Assert(aCard.Addresses.Count=1);
 aAddr:=aCard.Addresses[0];
 Assert(aAddr.AddressAttributes=[tatWork]);
 Assert(aAddr.POBox=cAddrPOBox);
 Assert(aAddr.ExtendedAddress=cAddrExtended);
 Assert(aAddr.StreetAddress=cAddrStreet);
 Assert(aAddr.Locality=cAddrLocality);
 Assert(aAddr.Region=cAddrRegion);
 Assert(aAddr.PostalCode=cAddrPostCode);
 Assert(aAddr.Nation=cAddrNation);

 //LastRevised isnt published by vcard, fix?

 //see rfc2426 3.5.5 ORG Type Definition
 //fails, bug in procedure ParseOrg
 //example:
 //ORG:ABC\, Inc.;North American Division;Marketing
 //todo1 add a test for parsing an escaped-comma. could be in ANY property
 Assert(aCard.BusinessInfo.Organization=cCompany);

 aCard.BusinessInfo.Divisions.Delimiter:=';';
 //delimitedtext adds quotes
 //Assert(aCard.BusinessInfo.Divisions.DelimitedText=cDivisions);
 Assert(aCard.BusinessInfo.Divisions.Count=2);

 finally
 Sys.FreeAndNil(aCard);
 Sys.FreeAndNil(aList);
 end;
end;

procedure TIdTestVCard.TestParseDateTime;
const
 cFormat='yyyy-mm-dd hh:nn:ss';
 cDate1='1995-10-31T22:27:10Z';
 cDate1b='1995-10-31 22:27:10';
 cDate2='1997-11-15';
 cDate2b='1997-11-15 00:00:00';
 cOutlookFormat='20050531T195358Z';
 cOutlookFormatb='2005-05-31 19:53:58';
var
 aDate:TDateTime;
begin
 aDate:=ParseDateTimeStamp(cDate1);
 Assert(Sys.FormatDateTime(cFormat,aDate)=cDate1b);

 aDate:=ParseDateTimeStamp(cDate2);
 Assert(Sys.FormatDateTime(cFormat,aDate)=cDate2b);

 aDate:=ParseDateTimeStamp(cOutlookFormat);
 Assert(Sys.FormatDateTime(cFormat,aDate)=cOutlookFormatb);
end;

initialization

  TIdTest.RegisterTest(TIdTestVCard);

end.
