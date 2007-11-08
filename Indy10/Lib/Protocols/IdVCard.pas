{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.7    2004.10.27 9:17:52 AM  czhower
  For TIdStrings


  Rev 1.6    10/26/2004 10:54:16 PM  JPMugaas
  Updated refs.


  Rev 1.5    2004.02.08 2:43:32 PM  czhower
  Fixed compile error.


  Rev 1.4    2/7/2004 12:47:16 PM  JPMugaas
  Should work in DotNET and not touch the system settings at all.


  Rev 1.3    2004.02.03 5:44:42 PM  czhower
  Name changes


  Rev 1.2    1/21/2004 4:21:10 PM  JPMugaas
  InitComponent


  Rev 1.1    6/13/2003 08:19:52 AM  JPMugaas
  Should now compile with new codders.


  Rev 1.0    11/13/2002 08:04:32 AM  JPMugaas
}
unit IdVCard;

{*******************************************************}
{                                                       }
{       Indy VCardObject TIdCard                        }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2000-May-06                                     }
{       Based on RFC 2425, 2426                         }
{                                                       }
{*******************************************************}

{

2002-Jan-20 DOn Siders
 - Corrected spelling errors in Categories properties, members, methods

2000-07-24 Peter Mee
 - Added preliminary embedded vCard checking
 - Added QP Check & Decode of individual properties
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent;

{ TODO:

Agent property does not work and the current parsing stops whenever it
sees END:VCard meaning that the VCard will be truncated if AGENT is
used to embed a VCard.

I omitted a property for spelling out a sound.  Appearently VCard 2.1
permitted a charactor representation of sound in addition to an embedded
sound, and a URL.

I am not sure how well the KEY property works.  That is used for
embedding some encryption keys into a VCard such as PGP public-key or
something from Versign.

VCard does not have any Quoted Printable decoding or Base64 encoding
and decoding.  Some routines may have to be changed to accomodate
this although I don't have the where-with-all.   

VCards can not be saved. }

type

  {This contains the object for Sound, Logo, Photo, Key, and Agent property}
  TIdVCardEmbeddedObject = class(TPersistent)
  protected
    FObjectType : String;
    FObjectURL  : String;
    FBase64Encoded : Boolean;
    FEmbeddedData : TStrings;
    {Embeded data property set method}
    procedure SetEmbeddedData(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    {this indicates the type of media such as the file type or key type}
    property ObjectType : String read FObjectType write FObjectType;
    {pointer to the URL where the object is located if it is NOT in this card
    itself}
    property ObjectURL  : String read FObjectURL write FObjectURL;
    {The object }
    property Base64Encoded : Boolean read FBase64Encoded write FBase64Encoded;
    {The data for the object if it is in the VCard.  This is usually in an
    encoded format such as BASE64 although some keys may not require encoding}
    property EmbeddedData : TStrings read FEmbeddedData write SetEmbeddedData;
  end;

  {VCard business information}
  TIdVCardBusinessInfo = class(TPersistent)
  protected
    FTitle : String;
    FRole : String;
    FOrganization : String;
    FDivisions : TStrings;
    procedure SetDivisions(Value : TStrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    {The organization name such as XYZ Corp. }
    property Organization : String read FOrganization write FOrganization;
    { The divisions in the orginization the person is in - e.g.
      West Virginia Office, Computing Service}
    property Divisions: TStrings read FDivisions write SetDivisions;
    {The person's formal title in the business such
     "Director of Computing Services"}
    property Title : String read FTitle write FTitle;
    {The person's role in an organization such as "system administrator" }    
    property Role : String read FRole write FRole;
  end;

  {Geographical information such as Latitude/Longitude and Time Zone}
  TIdVCardGeog = class(TPersistent)
  protected
    FLatitude : Real;
    FLongitude : Real;
    FTimeZoneStr : String;
  published
    {Geographical latitude the person is in}
    property Latitude : Real read FLatitude write  FLatitude;
    {Geographical longitude the person is in}
    property Longitude : Real read FLongitude write FLongitude;
    {The time zone the person is in}
    property TimeZoneStr : String read FTimeZoneStr write FTimeZoneStr;
  end;

  TIdPhoneAttribute = ( tpaHome, tpaVoiceMessaging, tpaWork, tpaPreferred,
    tpaVoice, tpaFax, tpaCellular, tpaVideo, tpaBBS, tpaModem, tpaCar,
    tpaISDN, tpaPCS, tpaPager );

  TIdPhoneAttributes = set of TIdPhoneAttribute;

  { This encapsolates a telephone number }
  TIdCardPhoneNumber = class(TCollectionItem)
  protected
    FPhoneAttributes: TIdPhoneAttributes;
    FNumber : String;
  public
    procedure Assign(Source: TPersistent); override;
  published
    {This is a descriptor for the phone number }
    property PhoneAttributes: TIdPhoneAttributes read FPhoneAttributes write FPhoneAttributes;
    { the telephone number itself}
    property Number : String read FNumber write FNumber;
  end;

  {Since a person can have more than one address, we put them into this collection}
  TIdVCardTelephones = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer) : TIdCardPhoneNumber;
    procedure SetItem(Index: Integer; const Value: TIdCardPhoneNumber);
  public
    constructor Create(AOwner : TPersistent); reintroduce;
    function Add: TIdCardPhoneNumber;
    property Items[Index: Integer] : TIdCardPhoneNumber read GetItem write SetItem; default;
  end;

  TIdCardAddressAttribute = ( tatHome, tatDomestic, tatInternational, tatPostal, tatParcel, tatWork, tatPreferred );
  TIdCardAddressAttributes = set of TIdCardAddressAttribute;

  {This encapsulates a person's address}    {Do not Localize}
  TIdCardAddressItem = class(TCollectionItem)
  protected
    FAddressAttributes : TIdCardAddressAttributes;
    FPOBox : String;
    FExtendedAddress : String;
    FStreetAddress : String;
    FLocality : String;
    FRegion : String;
    FPostalCode : String;
    FNation : String;
  public
    procedure Assign(Source: TPersistent); override;
  published
    { attributes for this address such as Home or Work, postal, parcel, etc.}
    property AddressAttributes : TIdCardAddressAttributes read FAddressAttributes write FAddressAttributes;
    { This is the P. O. Box for an address}
    property POBox : String read FPOBox write FPOBox;
    { This could be something such as an Office identifier for a building or
      an appartment number }
    property ExtendedAddress : String read FExtendedAddress write FExtendedAddress;
    {This is the streat address such as "101 Sample Avenue" }
    property StreetAddress : String read FStreetAddress write FStreetAddress;
    { This is a city or town (e.g. Chicago, New York City, Montreol }
    property Locality : String read FLocality write FLocality;
    { This is the political subdivision of a nation such as a Providence in Canda - Quebec,
     a State in US such as "West Virginia", or a county in England such as "Kent"}
    property Region : String read FRegion write FRegion;
    { This is the postal code for the locality such as a ZIP Code in the US }
    property PostalCode : String read FPostalCode write FPostalCode;
    { This is the nation such as Canada, U.S.A., Mexico, Russia, etc }
    property Nation : String read FNation write FNation;
  end;

  {Since a person can have more than one address, we put them into this collection}
  TIdVCardAddresses = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer) : TIdCardAddressItem;
    procedure SetItem(Index: Integer; const Value: TIdCardAddressItem);
  public
    constructor Create(AOwner : TPersistent); reintroduce;
    function Add: TIdCardAddressItem;
    property Items[Index: Integer] : TIdCardAddressItem read GetItem write SetItem; default;
  end;

  {This type holds a mailing label }
  TIdVCardMailingLabelItem = class(TCollectionItem)
  private
    FAddressAttributes : TIdCardAddressAttributes;
    FMailingLabel : TStrings;
    procedure SetMailingLabel(Value : TStrings);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    { attributes for this mailing label such as Home or Work, postal, parcel,
      etc.}
    property AddressAttributes : TIdCardAddressAttributes read FAddressAttributes write FAddressAttributes;
    { The mailing label itself}
    property MailingLabel : TStrings read FMailingLabel write SetMailingLabel;
  end;

  {This type holds the }
  TIdVCardMailingLabels = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer) : TIdVCardMailingLabelItem;
    procedure SetItem(Index: Integer; const Value: TIdVCardMailingLabelItem);
  public
    constructor Create(AOwner : TPersistent); reintroduce;
    function Add : TIdVCardMailingLabelItem;
    property Items[Index: Integer] : TIdVCardMailingLabelItem read GetItem write SetItem; default;
  end;

  { This type is used to indicate the type E-Mail indicated in the VCard
    which can be of several types }
  TIdVCardEMailType = (
    ematAOL, {America On-Line}
    ematAppleLink, {AppleLink}
    ematATT,   { AT&T Mail }
    ematCIS,   { CompuServe Information Service }
    emateWorld, { eWorld }
    ematInternet, {Internet SMTP (default)}
    ematIBMMail, { IBM Mail }
    ematMCIMail, { Indicates MCI Mail }
    ematPowerShare, { PowerShare }
    ematProdigy, { Prodigy information service }
    ematTelex, { Telex number }
    ematX400 { X.400 service }
  );

  {This object encapsolates an E-Mail address in a Collection}
  TIdVCardEMailItem = class(TCollectionItem)
  protected
    FEMailType : TIdVCardEMailType;
    FPreferred : Boolean;
    FAddress : String;
  public
    constructor Create(Collection: TCollection); override;
    { This is the type of E-Mail address which defaults to Internet }
    procedure Assign(Source: TPersistent); override;
  published
    property EMailType : TIdVCardEMailType read FEMailType write FEMailType;
    { Is this the person's prefered E-Mail address? }    {Do not Localize}
    property Preferred : Boolean read FPreferred write FPreferred;
    { The user's E-Mail address itself }    {Do not Localize}
    property Address : String read FAddress write FAddress;
  end;

  TIdVCardEMailAddresses = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer) : TIdVCardEMailItem;
    procedure SetItem(Index: Integer; const Value: TIdVCardEMailItem);
  public
    constructor Create(AOwner : TPersistent); reintroduce;
    function Add: TIdVCardEMailItem;
    property Items[Index: Integer] : TIdVCardEMailItem read GetItem write SetItem; default;
  end;

  TIdVCardName = class(TPersistent)
  protected
    FFirstName : String;
    FSurName : String;
    FOtherNames : TStrings;
    FPrefix : String;
    FSuffix : String;
    FFormattedName : String;
    FSortName : String;
    FNickNames : TStrings;
    procedure SetOtherNames(Value : TStrings);
    procedure SetNickNames(Value : TStrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    {This is the person's first name, in the case of "J. Peter Mugaas",
    this would be "J."}
    property FirstName : String read FFirstName write FFirstName;
    {This is the person's last name, in the case of "J. Peter Mugaas",
    this would be "Mugaas"}
    property SurName : String read FSurName write FSurName;
    {This is a place for a middle name and some other names such as a woman's  
    maiden name.  In the case of "J. Peter Mugaas", this would be "Peter".}
    property OtherNames : TStrings read FOtherNames write SetOtherNames;
    {This is a properly formatted name which was listed in the VCard}
    property FormattedName : String read FFormattedName write FFormattedName;
    {This is a prefix added to a name such as
    "Mr.", "Dr.", "Hon.", "Prof.", "Reverend", etc.}
    property Prefix : String read FPrefix write FPrefix;
    {This is a suffix added to a name such as
    "Ph.D.", "M.D.", "Esq.", "Jr.", "Sr.", "III", etc.}
    property Suffix : String read FSuffix write FSuffix;
    {The string used for sorting a name.  It may not always be the person's last    
    name}
    property SortName : String read FSortName write  FSortName;
    { Nick names which a person may have such as "Bill" or "Billy" for Wiliam.}
    property NickNames : TStrings read FNickNames write SetNickNames;
  end;

  TIdVCard = class(TIdBaseComponent)
  protected
    FComments : TStrings;
    FCategories : TStrings;
    FBusinessInfo : TIdVCardBusinessInfo;
    FGeography : TIdVCardGeog;
    FFullName : TIdVCardName;
    FRawForm : TStrings;
    FURLs : TStrings;
    FEMailProgram : String;
    FEMailAddresses : TIdVCardEMailAddresses;
    FAddresses : TIdVCardAddresses;
    FMailingLabels : TIdVCardMailingLabels;
    FTelephones : TIdVCardTelephones;
    FVCardVersion : Real;
    FProductID : String;
    FUniqueID : String;
    FClassification : String;
    FLastRevised : TDateTime;
    FBirthDay : TDateTime;
    FPhoto : TIdVCardEmbeddedObject;
    FLogo  : TIdVCardEmbeddedObject;
    FSound : TIdVCardEmbeddedObject;
    FKey : TIdVCardEmbeddedObject;
    procedure SetComments(Value : TStrings);
    procedure SetCategories(Value : TStrings);
    procedure SetURLs(Value : TStrings);
    {This processes some types of variables after reading the string}
    procedure SetVariablesAfterRead;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    { This reads a VCard from a TStrings object }
    procedure ReadFromStrings(s : TStrings);
    { This is the raw form of the VCard }
    property RawForm : TStrings read FRawForm;
  published
    { This is the VCard specification version used }
    property VCardVersion : Real read FVCardVersion;
    { URL's associated with the VCard such as the person's or organication's  
    webpage.  There can be more than one.}
    property URLs : TStrings read FURLs write SetURLs;
    { This is the product ID for the program which created this VCard}
    property ProductID : String read FProductID write FProductID;
    { This is a unique indentifier for the VCard }
    property UniqueID : String read FUniqueID write FUniqueID;
    { Intent of the VCard owner for general access to information described by the vCard
     VCard.}
    property Classification : String read FClassification write FClassification;
    { This is the person's birthday and possibly, time of birth}    {Do not Localize}
    property BirthDay : TDateTime read FBirthDay write FBirthDay;
    { This is the person's name }    {Do not Localize}
    property FullName : TIdVCardName read FFullName write FFullName;
    { This is the E-Mail program used by the card's owner}    {Do not Localize}
    property EMailProgram : String read FEMailProgram write FEMailProgram;
    { This is a list of the person's E-Mail address }    {Do not Localize}
    property EMailAddresses : TIdVCardEMailAddresses read FEMailAddresses;
    { This is a list of telephone numbers }
    property Telephones : TIdVCardTelephones read FTelephones;
    { This is busines related information on a VCard}
    property BusinessInfo : TIdVCardBusinessInfo read  FBusinessInfo;
    { This is a list of Categories used for classification }
    property Categories : TStrings read FCategories write SetCategories;
    { This is a list of addresses }
    property Addresses : TIdVCardAddresses read FAddresses;
    { This is a list of mailing labels }
    property MailingLabels : TIdVCardMailingLabels read FMailingLabels;
    { This is a miscellaneous comments, additional information, or whatever the
     VCard wishes to say }
    property Comments : TStrings read FComments write SetComments;
    { The owner's photograph}    {Do not Localize}
    property Photo : TIdVCardEmbeddedObject read FPhoto;
    { Organization's logo}    {Do not Localize}
    property Logo  : TIdVCardEmbeddedObject read FLogo;
    { A sound associated with the VCard such as how to pronounce a person's name  
      or something cute }
    property Sound : TIdVCardEmbeddedObject read FSound;
    { This is for an encryption key such as S/MIME, VeriSign, or PGP }
    property Key : TIdVCardEmbeddedObject read FKey;
  end;

  //public for testing
  function ParseDateTimeStamp(const DateString: string): TDateTime;

implementation

uses
  IdCoderQuotedPrintable,
  IdGlobal,
  IdGlobalProtocols, SysUtils;

const VCardProperties : array [0..27] of string = (
  'FN', 'N', 'NICKNAME', 'PHOTO',    {Do not Localize}
  'BDAY', 'ADR', 'LABEL', 'TEL',    {Do not Localize}
  'EMAIL', 'MAILER', 'TZ', 'GEO',    {Do not Localize}
  'TITLE',  'ROLE', 'LOGO', 'AGENT',    {Do not Localize}
  'ORG', 'CATEGORIES', 'NOTE', 'PRODID',    {Do not Localize}
  'REV', 'SORT-STRING', 'SOUND', 'URL',    {Do not Localize}
  'UID', 'VERSION', 'CLASS', 'KEY'    {Do not Localize}
);

{ These constants are for testing the VCard for E-Mail types.
  Don't alter these }    {Do not Localize}
const EMailTypePropertyParameter : array [0..11] of string = (
  'AOL', {America On-Line}    {Do not Localize}
  'APPLELINK',   {AppleLink}    {Do not Localize}
  'ATTMAIL', { AT&T Mail }    {Do not Localize}
  'CIS', { CompuServe Information Service }    {Do not Localize}
  'EWORLD', { eWorld }    {Do not Localize}
  'INTERNET', {Internet SMTP (default) }    {Do not Localize}
  'IBMMAIL', { IBM Mail }    {Do not Localize}
  'MCIMAIL', { MCI Mail }    {Do not Localize}
  'POWERSHARE', { PowerShare }    {Do not Localize}
  'PRODIGY', { Prodigy information service }    {Do not Localize}
  'TLX', { Telex number }    {Do not Localize}
  'X400' { X.400 service }    {Do not Localize}
);

//This is designed for decimals as written in the English language.
//We require this because some protocols may require this as standard representation
//for floats
function IndyStrToFloat(const AStr: string): Extended;
var
  LBuf : String;
  LHi, LLo : Cardinal;
  i : Integer;
begin
  LBuf := AStr;
  //strip off
  for i := Length(LBuf) downto 1 do begin
    if LBuf[i] = ',' then begin
     IdDelete(LBuf, i, 1);
    end;
  end;
  LHi := IndyStrToInt(Fetch(LBuf,'.'), 0);
  LBuf := PadString(LBuf, 2, '0');
  LLo := IndyStrToInt(Copy(LBuf,1,2), 0);
  Result := LHi + (LLo / 100);
end;

{This only adds Value to strs if it is not zero}
procedure AddValueToStrings(strs : TStrings; Value : String);
begin
  if Length(Value) > 0 then begin
    strs.Add(Value);
  end; //  if Legnth ( Value ) then
end;

{This parses a delinated string into a TStrings}
procedure ParseDelimiterToStrings(strs : TStrings; str : String; const Delimiter : Char = ',');    {Do not Localize}
begin
  while str <> '' do begin   {Do not Localize}
    AddValueToStrings(strs, Fetch(str, Delimiter));
  end;
end;

{This parses time stamp from DateString and returns it as TDateTime
This assumes the date Time stamp will be like this:

1995-10-31T22:27:10Z

1997-11-15
}
function ParseDateTimeStamp(const DateString : String) : TDateTime;
var
  Year, Day, Month : Integer;
  Hour, Minute, Second : Integer;
begin
  //outlook format = 20050531T195358Z
  if CharEquals(DateString, 9, 'T') then begin
    Year  := IndyStrToInt(Copy(DateString, 1, 4));
    Month := IndyStrToInt(Copy(DateString, 5, 2));
    Day   := IndyStrToInt(Copy(DateString, 7, 2));
    Hour   := IndyStrToInt(Copy(DateString, 10, 2));
    Minute := IndyStrToInt(Copy(DateString, 12, 2));
    Second := IndyStrToInt(Copy(DateString, 14, 2));
  end else begin
    Year  := IndyStrToInt(Copy(DateString, 1, 4));
    Month := IndyStrToInt(Copy(DateString, 6, 2));
    Day   := IndyStrToInt(Copy(DateString, 9, 2));
    //where does 14 come from?
    if Length(DateString) > 14 then begin
      Hour := IndyStrToInt(Copy(DateString, 12, 2));
      Minute := IndyStrToInt(Copy(DateString, 15, 2));
      Second := IndyStrToInt(Copy(DateString, 18, 2));
    end else begin
      { no date }
      Hour   := 0;
      Minute := 0;
      Second := 0;
    end;
    //DateStamp.AsISO8601Calender := DateString;
  end;
  Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, 0);
end;

{This function returns a stringList with an item's
attributes and sets value to the value of the item}
function GetAttributesAndValue(Data : String; var Value : String) : TStringList;
var
  Buff, Buff2 : String;
begin
  Result := TStringList.Create;
  try
    if IndyPos(':', Data) <> 0 then    {Do not Localize}
    begin
      Buff := Fetch(Data, ':');    {Do not Localize}
      {This handles a VCard property attribute delimiter ","}
      Buff := StringReplace(Buff, ',', ';',[rfReplaceAll]);    {Do not Localize}
      while Buff <> '' do begin   {Do not Localize}
        Buff2 := Fetch(Buff, ';');    {Do not Localize}
        if Length(Buff2) > 0 then begin
          Result.Add(Buff2);
        end;
      end;
    end;
    Value := Data;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

{This parses the organization line from OrgString into}
procedure ParseOrg(OrgObj : TIdVCardBusinessInfo; OrgStr : String);
begin
  { Organization name }
  OrgObj.Organization := Fetch(OrgStr, ';');
  { Divisions }
  ParseDelimiterToStrings(OrgObj.Divisions, OrgStr, ';');    {Do not Localize}
end;

{This parses the geography latitude and longitude from GeogStr and
 puts it in Geog}
procedure ParseGeography(Geog : TIdVCardGeog; GeogStr : String);
begin
  {Latitude}
  Geog.Latitude := IndyStrToFloat(Fetch(GeogStr, ';'));    {Do not Localize}
  {Longitude}
  Geog.Longitude := IndyStrToFloat(Fetch(GeogStr, ';'));    {Do not Localize}
end;

{This parses  PhoneStr and places the attributes in PhoneObj }
procedure ParseTelephone(PhoneObj : TIdCardPhoneNumber; PhoneStr : String);
const
  TelephoneTypePropertyParameter : array [0..13] of string  = (
    'HOME', 'MSG',   'WORK', 'PREF',  'VOICE',  'FAX',    {Do not Localize}
    'CELL', 'VIDEO',  'BBS', 'MODEM', 'CAR',   'ISDN',    {Do not Localize}
    'PCS', 'PAGER'    {Do not Localize}
  );
var
  Value : String;
  idx : Integer;
  Attribs : TStringList;
begin
  attribs := GetAttributesAndValue(PhoneStr, Value);
  try
    for idx := 0 to Attribs.Count-1 do begin
      case PosInStrArray(attribs[idx], TelephoneTypePropertyParameter, False) of
        { home }
        0 : Include(PhoneObj.FPhoneAttributes, tpaHome);
        { voice messaging }
        1 : Include(PhoneObj.FPhoneAttributes, tpaVoiceMessaging);
        { work }
        2 : Include(PhoneObj.FPhoneAttributes, tpaWork);
        { preferred }
        3 : Include(PhoneObj.FPhoneAttributes, tpaPreferred);
        { Voice }
        4 : Include(PhoneObj.FPhoneAttributes, tpaVoice);
        { Fax }
        5 : Include(PhoneObj.FPhoneAttributes, tpaFax);
        { Cellular phone }
        6 : Include(PhoneObj.FPhoneAttributes, tpaCellular);
        { Video conferancing number }
        7 : Include(PhoneObj.FPhoneAttributes, tpaVideo);
        { Bulleton Board System (BBS) telephone number }
        8 : Include(PhoneObj.FPhoneAttributes, tpaBBS);
        { MODEM Connection number }
        9 : Include(PhoneObj.FPhoneAttributes, tpaModem);
        { Car phone number }
       10 : Include(PhoneObj.FPhoneAttributes, tpaCar);
        { ISDN Service Number }
       11 : Include(PhoneObj.FPhoneAttributes, tpaISDN);
       { personal communication services telephone number }
       12 : Include(PhoneObj.FPhoneAttributes, tpaPCS);
       { pager }
       13 : Include(PhoneObj.FPhoneAttributes, tpaPager);
      end;
    end;
    { default telephon number }
    if Attribs.Count = 0 then begin
      PhoneObj.PhoneAttributes := [tpaVoice];
    end;
    PhoneObj.Number := Value;
  finally
    FreeAndNil(attribs);
  end;
end;

{This parses AddressStr and places the attributes in AddressObj }
procedure ParseAddress(AddressObj : TIdCardAddressItem; AddressStr : String);
const
  AttribsArray : array[0..6] of String = (
    'HOME', 'DOM', 'INTL', 'POSTAL', 'PARCEL', 'WORK', 'PREF'    {Do not Localize}
  );
var
  Value : String;
  Attribs : TStringList;
  idx : Integer;
begin
  Attribs := GetAttributesAndValue(AddressStr, Value);
  try
    for idx := 0 to Attribs.Count-1 do begin
      case PosInStrArray(attribs[idx], AttribsArray, False) of
        { home }
        0 : Include(AddressObj.FAddressAttributes, tatHome);
        { domestic }
        1 : Include(AddressObj.FAddressAttributes, tatDomestic);
        { international }
        2 : Include(AddressObj.FAddressAttributes, tatInternational);
        { Postal }
        3 : Include(AddressObj.FAddressAttributes, tatPostal);
        { Parcel }
        4 : Include(AddressObj.FAddressAttributes, tatParcel);
        { Work }
        5 : Include(AddressObj.FAddressAttributes, tatWork);
        { Preferred }
        6 : Include(AddressObj.FAddressAttributes, tatPreferred);
      end;
    end;
    if Attribs.Count = 0 then begin
      AddressObj.AddressAttributes := [tatInternational, tatPostal, tatParcel, tatWork];
    end;
    AddressObj.POBox := Fetch(Value, ';');    {Do not Localize}
    AddressObj.ExtendedAddress := Fetch(Value, ';');    {Do not Localize}
    AddressObj.StreetAddress := Fetch(Value, ';');    {Do not Localize}
    AddressObj.Locality := Fetch(Value, ';');    {Do not Localize}
    AddressObj.Region := Fetch (Value, ';');    {Do not Localize}
    AddressObj.PostalCode := Fetch(Value, ';');    {Do not Localize}
    AddressObj.Nation := Fetch (Value, ';');    {Do not Localize}
  finally
    FreeAndNil(Attribs);
  end;
end;

{This parses LabelStr and places the attributes in TIdVCardMailingLabelItem }
procedure ParseMailingLabel(LabelObj : TIdVCardMailingLabelItem; LabelStr : String);
const
  AttribsArray : array[0..6] of String = (
    'HOME', 'DOM', 'INTL', 'POSTAL', 'PARCEL', 'WORK', 'PREF'    {Do not Localize}
  );
var
  Value : String;
  Attribs : TStringList;
  idx : Integer;
begin
  Attribs := GetAttributesAndValue(LabelStr, Value);
  try
    for idx := 0 to Attribs.Count-1 do begin
      case PosInStrArray(attribs[idx], AttribsArray, False) of
        { home }
        0 : Include(LabelObj.FAddressAttributes, tatHome);
        { domestic }
        1 : Include(LabelObj.FAddressAttributes, tatDomestic);
        { international }
        2 : Include(LabelObj.FAddressAttributes, tatInternational);
        { Postal }
        3 : Include(LabelObj.FAddressAttributes, tatPostal);
        { Parcel }
        4 : Include(LabelObj.FAddressAttributes, tatParcel);
        { Work }
        5 : Include(LabelObj.FAddressAttributes, tatWork);
        { Preferred }
        6 : Include(LabelObj.FAddressAttributes, tatPreferred);
      end;
    end;
    {Default Values}
    if Attribs.Count = 0 then begin
      LabelObj.AddressAttributes := [tatInternational,  tatPostal, tatParcel, tatWork];
    end;
    LabelObj.MailingLabel.Add(Value);
  finally
    FreeAndNil(Attribs);
  end;
end;

{This parses the Name and places the name in the TIdVCardName}
procedure ParseName(NameObj : TIdVCardName; NameStr : String);
var
  OtherNames : String;
begin
  { surname }
  NameObj.SurName := Fetch(NameStr, ';');    {Do not Localize}
  { first name }
  NameObj.FirstName := Fetch(NameStr, ';');    {Do not Localize}
  { middle and other names}
  OtherNames := Fetch(NameStr, ';');    {Do not Localize}
  { Prefix }
  NameObj.Prefix := Fetch(NameStr, ';');    {Do not Localize}
  { Suffix }
  NameObj.Suffix := Fetch(NameStr, ';');    {Do not Localize}
  OtherNames := StringReplace(OtherNames, ' ', ',',[rfReplaceAll]);    {Do not Localize}
  ParseDelimiterToStrings(NameObj.OtherNames, OtherNames);
end;

{This parses EMailStr and places the attributes in EMailObj }
procedure ParseEMailAddress(EMailObj : TIdVCardEMailItem; EMailStr : String);
var
  Value : String;
  Attribs : TStringList;
  idx : Integer;
  {this is for testing the type so we can break out of the loop}
  ps : Integer;

  function IsPreferred: Boolean;
  var
    idx2: Integer;
  begin
    for idx2 := 0 to Attribs.Count-1 do begin
      if TextIsSame(Attribs[idx2], 'PREF') then begin    {Do not Localize}
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  Attribs := GetAttributesAndValue (EMailStr, Value);
  try
    EMailObj.Address := Value;
    EMailObj.Preferred := IsPreferred;
    for idx := 0 to Attribs.Count-1 do begin
      ps := PosInStrArray(Attribs[idx], EMailTypePropertyParameter);
      if ps <> -1 then begin
        case ps of
          0 : EMailObj.EMailType := ematAOL; {America On-Line}
          1 : EMailObj.EMailType := ematAppleLink; {AppleLink}
          2 : EMailObj.EMailType := ematATT;   { AT&T Mail }
          3 : EMailObj.EMailType := ematCIS;   { CompuServe Information Service }
          4 : EMailObj.EMailType := emateWorld; { eWorld }
          5 : EMailObj.EMailType := ematInternet; {Internet SMTP (default)}
          6 : EMailObj.EMailType := ematIBMMail; { IBM Mail }
          7 : EMailObj.EMailType := ematMCIMail; { Indicates MCI Mail }
          8 : EMailObj.EMailType := ematPowerShare; { PowerShare }
          9 : EMailObj.EMailType := ematProdigy; { Prodigy information service }
         10 : EMailObj.EMailType := ematTelex; { Telex number }
         11 : EMailObj.EMailType := ematX400; { X.400 service }
        end;
        Break;
      end;
    end;
  finally
    FreeAndNil(Attribs);
  end;
end;

{ TIdVCard }

procedure TIdVCard.InitComponent;
begin
  inherited InitComponent;
  FPhoto := TIdVCardEmbeddedObject.Create;
  FLogo  := TIdVCardEmbeddedObject.Create;
  FSound := TIdVCardEmbeddedObject.Create;
  FKey := TIdVCardEmbeddedObject.Create;
  FComments := TStringList.Create;
  FCategories := TStringList.Create;
  FBusinessInfo := TIdVCardBusinessInfo.Create;
  FGeography := TIdVCardGeog.Create;
  FFullName := TIdVCardName.Create;
  FRawForm := TStringList.Create;
  FEMailAddresses := TIdVCardEMailAddresses.Create(Self);
  FAddresses := TIdVCardAddresses.Create(Self);
  FTelephones := TIdVCardTelephones.Create(Self);
  FURLs := TStringList.Create;
  FMailingLabels := TIdVCardMailingLabels.Create(Self);
end;

destructor TIdVCard.Destroy;
begin
  FreeAndNil(FKey);
  FreeAndNil(FPhoto);
  FreeAndNil(FLogo);
  FreeAndNil(FSound);
  FreeAndNil(FComments);
  FreeAndNil(FMailingLabels);
  FreeAndNil(FCategories);
  FreeAndNil(FBusinessInfo);
  FreeAndNil(FGeography);
  FreeAndNil(FURLs);
  FreeAndNil(FTelephones);
  FreeAndNil(FAddresses);
  FreeAndNil(FEMailAddresses);
  FreeAndNil(FFullName);
  FreeAndNil(FRawForm);
  inherited Destroy;
end;

procedure TIdVCard.ReadFromStrings(s: TStrings);
var
  idx, level : Integer;
begin
  FRawForm.Clear;
  {Find the begin mark and accomodate broken VCard implemntations}
  level := 0;
  for idx := 0 to s.Count-1 do begin
    if TextIsSame(Trim(s[idx]), 'BEGIN:VCARD') then begin    {Do not Localize}
      Break;
    end;
  end;
  {Keep adding until end VCard }
  while idx < s.Count do begin
    if Length(s[idx]) > 0 then begin
      case PosInStrArray(Trim(s[idx]), ['BEGIN:VCARD', 'END:VCARD'], False) of {Do not Localize}
        0: begin
          // Have a new object - increment the counter & add
          Inc(level);
        end;
        1: begin
          // Have an END:
          Dec(level);
        end;
      end;
      // regardless of content, add it 
      FRawForm.Add(s[idx]);
      if level < 1 then begin
        Break;
      end;
    end;
    Inc(idx);
  end;
  SetVariablesAfterRead;
end;

procedure TIdVCard.SetCategories(Value: TStrings);
begin
  FCategories.Assign(Value);
end;

procedure TIdVCard.SetComments(Value: TStrings);
begin
  FComments.Assign(Value);
end;

procedure TIdVCard.SetURLs(Value: TStrings);
begin
  FURLs.Assign(Value);
end;

procedure TIdVCard.SetVariablesAfterRead;
var
  idx : Integer;
  OrigLine : String;
  Line : String;
  Attribs : String;
  Data : String;
  Test : String;
  Colon : Integer;
  SColon : Integer;
  ColonFind : Integer;
  QPCoder : TIdDecoderQuotedPrintable;

  {These subroutines increment idx to prevent unneded comparisons of folded lines}

  function UnfoldLines : String;
  begin
    Result := '';    {Do not Localize}
    Inc(idx);
    while (idx < FRawForm.Count) and CharIsInSet(FRawForm[idx], 1, ' '#9) do    {Do not Localize}
    begin
      Result := Result + Trim(FRawForm[idx]);
      Inc(idx);
    end; // while
    {Correct for increment in the main while loop}
    Dec(idx);
  end;

  procedure ProcessAgent;
  begin
    // The current idx of FRawForm could be an embedded vCard.
    { TODO : Eliminate embedded vCard }
  end;

  procedure ParseEmbeddedObject(EmObj : TIdVCardEmbeddedObject; StLn : String);
  var
    Value : String;
    LAttribs : TStringList;
    idx2 : Integer;
    {this is for testing the type so we can break out of the loop}
  begin
    LAttribs := GetAttributesAndValue(StLn, Value);
    try
      for idx2 := 0 to LAttribs.Count-1 do begin
        if PosInStrArray(LAttribs[idx2], ['ENCODING=BASE64', 'BASE64']) <> -1 then begin   {Do not Localize}
          emObj.Base64Encoded := True;
        end
        else if PosInStrArray(LAttribs[idx2], ['VALUE=URI', 'VALUE=URL', 'URI', 'URL']) = -1 then begin   {Do not Localize}
          emObj.ObjectType := LAttribs[idx2];
        end;
      end;
      if (LAttribs.IndexOf('VALUE=URI') > -1) or    {Do not Localize}
          (LAttribs.IndexOf('VALUE=URL') > -1) or    {Do not Localize}
          (LAttribs.IndexOf('URI') > -1) or    {Do not Localize}
          (LAttribs.IndexOf('URL') > -1)  then    {Do not Localize}
      begin
        emObj.ObjectURL := Value + UnfoldLines;
      end else begin
        AddValueToStrings(EmObj.EmbeddedData, Value);
        {Add any folded lines}
        Inc(idx);
        while (idx < FRawForm.Count) and CharIsInSet(FRawForm[idx], 1, ' '#9) do begin   {Do not Localize}
          AddValueToStrings(EmObj.EmbeddedData, Trim(FRawForm[idx]));
          Inc(idx);
        end;
        {Correct for increment in the main while loop}
        Dec(idx);
      end;
    finally
      FreeAndNil(LAttribs);
    end;
  end;

begin
  // At this point, FRawForm contains the entire vCard - including possible
  // embedded vCards.

  QPCoder := TIdDecoderQuotedPrintable.Create(Self);
  try
    idx := 0;
    while idx < FRawForm.Count do
    begin
      // Grab the line
      Line := FRawForm[idx];

      {We separate the property name from the parameters and values here.
      We have be careful because sometimes a property in a vCard is separed by a
      ; or : even if the RFC and standards don't permit this   
      - broken VCard creation tools }
      Colon := IndyPos(':', Line);    {Do not Localize}

      // Store the property & complete attributes
      Attribs := Copy(Line, 1, Colon - 1);

      // Must now check for Quoted-printable attribute.  vCard v2.1 allows
      // QP to be used in any field.

      //****  Begin QP check & decode
      if IndyPos('QUOTED-PRINTABLE', UpperCase(Attribs)) > 0 then begin   {Do not Localize}
        // First things first - make a copy of the Line.
        OrigLine := Line;

        // Set Data to be the data contained on this line of the vCard
        Data := Copy(Line, Colon + 1, MaxInt);

        // The problem with QP-embedded objects is that the Colon character is
        // not standard QP-encoded... however, it is the only reliable way to
        // discover the next property.  So loop here until the next property is
        // found (i.e., the next line with a colon).
        Inc(idx);
        ColonFind := IndyPos(':', FRawForm[idx]);    {Do not Localize}
        while ColonFind = 0 do begin
          Data := Data + TrimLeft(FRawForm[idx]);
          Inc(idx);
          if idx <> FRawForm.Count then begin
            ColonFind := IndyPos(':', FRawForm[idx]);    {Do not Localize}
          end else begin
            ColonFind := 1;
          end;
        end;
        // Return idx to this property's (last) line    {Do not Localize}
        Dec(idx);

        Data := QPCoder.DecodeString(Data);

        // Now reorganise property so that it does not have a QP attribute.
        ColonFind := IndyPos(';', Attribs);    {Do not Localize}
        Line := '';    {Do not Localize}
        while ColonFind <> 0 do begin
          Test := Copy(Attribs, 1, ColonFind);
          if IndyPos('QUOTED-PRINTABLE', UpperCase(Test)) = 0 then begin   {Do not Localize}
            // Add to Line.
            Line := Line + Test;
          end;
          Attribs := Copy(Attribs, ColonFind + 1, MaxInt);
          ColonFind := IndyPos(';', Attribs);    {Do not Localize}
        end;

        // Clean up variables
        if Length(Attribs) <> 0 then begin
          // Does Quoted-Printable occur in what's left?    {Do not Localize}
          if IndyPos('QUOTED-PRINTABLE', UpperCase(Attribs)) = 0 then begin   {Do not Localize}
            // Add to line
            Line := Line + Attribs;
          end;
        end;

        // Check if the last char of Line is a semi-colon.  If so, remove it.
        ColonFind := Length(Line);
        If ColonFind > 0 then
        begin
          if Line[ColonFind] = ';' then begin   {Do not Localize}
            Line := Copy(Line, 1, ColonFind - 1);
          end;
        end;
        Line := Line + ':' + Data;    {Do not Localize}
      end;
      //****  End QP check & decode

      Colon := IndyPos(':', Line);    {Do not Localize}
      SColon := IndyPos(';', Line);    {Do not Localize}
      if (Colon < SColon) or (SColon = 0) then begin
        Line := ReplaceOnlyFirst(Line, ':', ';');    {Do not Localize}
      end;

      // Grab the property name
      Test := Fetch(Line, ';');    {Do not Localize}

      // Discover which property it is.
      case PosInStrArray(Test, VCardProperties, False) of
        {'FN'}    {Do not Localize}
        0 : FFullName.FormattedName := Line + UnfoldLines;
        {'N'}    {Do not Localize}
        1 : ParseName(FFullName, Line + UnfoldLines);
        {'NICKNAME'}    {Do not Localize}
        2 : ParseDelimiterToStrings(FFullName.NickNames, Line + UnfoldLines);
        {'PHOTO'}    {Do not Localize}
        3 : ParseEmbeddedObject(FPhoto, Line);
        {'BDAY'}    {Do not Localize}
        4 : FBirthDay := ParseDateTimeStamp(Line + UnfoldLines);
        {'ADR'}    {Do not Localize}
        5 : ParseAddress(FAddresses.Add, Line + UnfoldLines);
        {'LABEL'}    {Do not Localize}
        6 : ParseMailingLabel(FMailingLabels.Add, Line + UnfoldLines);
        {'TEL'}    {Do not Localize}
        7 : ParseTelephone(FTelephones.Add, Line + UnfoldLines);
        {'EMAIL'}    {Do not Localize}
        8 : ParseEMailAddress(FEMailAddresses.Add, Line + UnfoldLines);
        {'MAILER'}    {Do not Localize}
        9 : FEMailProgram := Line + UnfoldLines;
        {'TZ'}    {Do not Localize}
       10 : FGeography.TimeZoneStr := Line + UnfoldLines;
        {'GEO'}    {Do not Localize}
       11 : ParseGeography(FGeography, Line + UnfoldLines);
        {'TITLE'}    {Do not Localize}
       12 : FBusinessInfo.Title := Line + UnfoldLines;
        {'ROLE'}    {Do not Localize}
       13 : FBusinessInfo.Role := Line + UnfoldLines;
        {'LOGO'}    {Do not Localize}
       14 : ParseEmbeddedObject (FLogo, Line);
        {'AGENT'}    {Do not Localize}
       15 : ProcessAgent;
        {'ORG'}    {Do not Localize}
       16 : ParseOrg(FBusinessInfo, Line + UnfoldLines);
        {'CATEGORIES'}    {Do not Localize}
       17 :  ParseDelimiterToStrings(FCategories, Line + UnfoldLines);
         {'NOTE'}    {Do not Localize}
       18 :  FComments.Add(Line + UnfoldLines);
        {'PRODID' }    {Do not Localize}
       19 : FProductID := Line + UnfoldLines;
        {'REV'}    {Do not Localize}
       20 : FLastRevised := ParseDateTimeStamp(Line + UnfoldLines);
        {'SORT-STRING'}    {Do not Localize}
       21 : FFullName.SortName := Line + UnfoldLines;
        {'SOUND'}    {Do not Localize}
       22 :  ParseEmbeddedObject(FSound, Line);
        {'URL'}    {Do not Localize}
       23 : AddValueToStrings(FURLs, Line + UnfoldLines);
        {'UID'}    {Do not Localize}
       24 : FUniqueID := Line + UnfoldLines;
        {'VERSION'}    {Do not Localize}
       25 : FVCardVersion := IndyStrToFloat(Line  + UnfoldLines);
        {'CLASS'}    {Do not Localize}
       26 :  FClassification := Line + UnfoldLines;
        {'KEY'}    {Do not Localize}
       27 : ParseEmbeddedObject(FKey, Line);
      end;
      Inc(idx);
    end;
  finally
    FreeAndNil(QPCoder);
  end;
end;

{ TIdVCardEMailAddresses }

function TIdVCardEMailAddresses.Add: TIdVCardEMailItem;
begin
  Result := TIdVCardEMailItem(inherited Add);
end;

constructor TIdVCardEMailAddresses.Create(AOwner : TPersistent);
begin
  inherited Create(AOwner, TIdVCardEMailItem);
end;

function TIdVCardEMailAddresses.GetItem(Index: Integer): TIdVCardEMailItem;
begin
  Result := TIdVCardEMailItem(inherited Items[Index]);
end;

procedure TIdVCardEMailAddresses.SetItem(Index: Integer; const Value: TIdVCardEMailItem);
begin
  inherited SetItem(Index, Value);
end;

{ TIdVCardEMailItem }

procedure TIdVCardEMailItem.Assign(Source: TPersistent);
var
  EMail : TIdVCardEMailItem;
begin
  if Source is TIdVCardEMailItem then begin
    EMail := Source as TIdVCardEMailItem;
    EMailType := EMail.EMailType;
    Preferred := EMail.Preferred;
    Address := EMail.Address;
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdVCardEMailItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEMailType := ematInternet;
end;

{ TIdVCardAddresses }

function TIdVCardAddresses.Add: TIdCardAddressItem;
begin
  Result := TIdCardAddressItem(inherited Add);
end;

constructor TIdVCardAddresses.Create(AOwner : TPersistent);
begin
  inherited Create(AOwner, TIdCardAddressItem);
end;

function TIdVCardAddresses.GetItem(Index: Integer): TIdCardAddressItem;
begin
  Result := TIdCardAddressItem(inherited Items[Index]);
end;

procedure TIdVCardAddresses.SetItem(Index: Integer; const Value: TIdCardAddressItem);
begin
  inherited SetItem(Index, Value);
end;

{ TIdVCardTelephones }

function TIdVCardTelephones.Add: TIdCardPhoneNumber;
begin
  Result := TIdCardPhoneNumber(inherited Add);
end;

constructor TIdVCardTelephones.Create(AOwner : TPersistent);
begin
   inherited Create(AOwner, TIdCardPhoneNumber);
end;

function TIdVCardTelephones.GetItem(Index: Integer): TIdCardPhoneNumber;
begin
  Result := TIdCardPhoneNumber(inherited Items[Index]);
end;

procedure TIdVCardTelephones.SetItem(Index: Integer; const Value: TIdCardPhoneNumber);
begin
  inherited SetItem(Index, Value);
end;

{ TIdVCardName }

constructor TIdVCardName.Create;
begin
  inherited Create;
  FOtherNames := TStringList.Create;
  FNickNames := TStringList.Create;
end;

destructor TIdVCardName.Destroy;
begin
  FreeAndNil(FNickNames);
  FreeAndNil(FOtherNames);
  inherited Destroy;
end;

procedure TIdVCardName.SetNickNames(Value: TStrings);
begin
  FNickNames.Assign(Value);
end;

procedure TIdVCardName.SetOtherNames(Value: TStrings);
begin
  FOtherNames.Assign(Value);
end;

{ TIdVCardBusinessInfo }

constructor TIdVCardBusinessInfo.Create;
begin
  inherited Create;
  FDivisions := TStringList.Create;
end;

destructor TIdVCardBusinessInfo.Destroy;
begin
  FreeAndNil(FDivisions);
  inherited Destroy;
end;

procedure TIdVCardBusinessInfo.SetDivisions(Value: TStrings);
begin
  FDivisions.Assign(Value);
end;

{ TIdVCardMailingLabelItem }

procedure TIdVCardMailingLabelItem.Assign(Source: TPersistent);
var
  lbl : TIdVCardMailingLabelItem;
begin
  if Source is TIdVCardMailingLabelItem then begin
    lbl := Source as TIdVCardMailingLabelItem;
    AddressAttributes := lbl.AddressAttributes;
    MailingLabel.Assign(lbl.MailingLabel);
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdVCardMailingLabelItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FMailingLabel := TStringList.Create;
end;

destructor TIdVCardMailingLabelItem.Destroy;
begin
  FreeAndNil(FMailingLabel);
  inherited Destroy;
end;

procedure TIdVCardMailingLabelItem.SetMailingLabel(Value: TStrings);
begin
  FMailingLabel.Assign(Value);
end;

{ TIdVCardMailingLabels }

function TIdVCardMailingLabels.Add: TIdVCardMailingLabelItem;
begin
  Result := TIdVCardMailingLabelItem(inherited Add);
end;

constructor TIdVCardMailingLabels.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdVCardMailingLabelItem);
end;

function TIdVCardMailingLabels.GetItem(Index: Integer): TIdVCardMailingLabelItem;
begin
  Result := TIdVCardMailingLabelItem(inherited GetItem(Index));
end;

procedure TIdVCardMailingLabels.SetItem(Index: Integer; const Value: TIdVCardMailingLabelItem);
begin
  inherited SetItem(Index, Value);
end;

{ TIdEmbeddedObject }

constructor TIdVCardEmbeddedObject.Create;
begin
  inherited Create;
  FEmbeddedData := TStringList.Create;
end;

destructor TIdVCardEmbeddedObject.Destroy;
begin
  FreeAndNil(FEmbeddedData);
  inherited Destroy;
end;

procedure TIdVCardEmbeddedObject.SetEmbeddedData(const Value: TStrings);
begin
  FEmbeddedData.Assign(Value);
end;

{ TIdCardPhoneNumber }

procedure TIdCardPhoneNumber.Assign(Source: TPersistent);
var
  Phone : TIdCardPhoneNumber;
begin
  if Source is TIdCardPhoneNumber then begin
    Phone := Source as TIdCardPhoneNumber;
    PhoneAttributes := Phone.PhoneAttributes;
    Number := Phone.Number;
  end else begin
    inherited Assign(Source);
  end;
end;

{ TIdCardAddressItem }

procedure TIdCardAddressItem.Assign(Source: TPersistent);
var
  LAddr : TIdCardAddressItem;
begin
  if Source is TIdCardAddressItem then begin
    LAddr := Source as TIdCardAddressItem;
    AddressAttributes := LAddr.AddressAttributes;
    POBox := LAddr.POBox;
    ExtendedAddress := LAddr.ExtendedAddress;
    StreetAddress := LAddr.StreetAddress;
    Locality := LAddr.Locality;
    Region := LAddr.Region;
    PostalCode := LAddr.PostalCode;
    Nation := LAddr.Nation;
  end else begin
    inherited Assign(Source);
  end;
end;

end.
