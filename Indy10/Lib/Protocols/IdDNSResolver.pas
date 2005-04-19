{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13800: IdDNSResolver.pas
{
  4/19/2005 BTaylor

  Added support for SVR and NAPTR records. (Used for SIP/VOIP) (parts by Frank Shearar)

  Added TResultRecord.Section, .FilterBySection , .FilterByClass
  DNS lookups can now be generated exactly the same as NsLookup.

  Improved .Assign support on many objects. QueryResult object+items can now be properly cloned.

  TIdDNSResolver.FDNSHeader was a public field, now it's a public readonly property, TIdDNSResolver.DNSHeader

  fixed TMXRecord.Parse bug, .Preference will now contain correct value.

  fixed TTextRecord.Parse issue. DomainKeys (yahoo's anti-spam method) can now be used.

  Minor cleanups/spelling errors fixed.
}
{
{   Rev 1.26    3/21/2005 10:36:20 PM  VVassiliev
{ NextDNSLabel fix
{ TTextRecord.Parse fix
{ ClearInternalQuery before resolving
}
{
{   Rev 1.25    2/9/05 2:10:34 AM  RLebeau
{ Removed compiler hint
}
{
{   Rev 1.24    2/8/05 6:17:14 PM  RLebeau
{ Updated CreateQuery() to use Fetch() and AppendString() instead of Pos(),
{ ToBytes(), and AppendBytes()
}
{
{   Rev 1.23    10/26/2004 9:06:30 PM  JPMugaas
{ Updated references.
}
{
{   Rev 1.22    2004.10.25 10:18:38 PM  czhower
{ Removed unused var.
}
{
{   Rev 1.21    25/10/2004 15:55:28  ANeillans
{ Bug fix: 
{ http://apps.atozedsoftware.com/cgi-bin/BBGIndy/BugBeGoneISAPI.dll/?item=122
{
{ Checked in for Dennies Chang
}
{
{   Rev 1.20    2004/7/19 ¤U¤È 09:40:52  DChang
{ 1. fix the TIdResolver.ParseAnswers, add 2 parameters for the function to
{ check if QueryResult should be clear or not, TIdResolver.FillResult  is
{ modified at the same time. 
{ 
{ Fix AXFR procedure, fully support BIND 8 AXFR procedures.
{ 
{ 2. Replace the original type indicator in TQueryResult.Add
{ . It can understand AAAA type correctly.
{ 
{ 3. Add qtIXFR type for TIdDNSResover, add 2 parameters for
{ TIdDNSResolver.Resolver, add one parameter for TIdDNSResolver.CreateHeader.
{ 
{ 4. Support query type CHAOS, but only for checking version.bind. (Check DNS
{ server version.)
}
{
    Rev 1.19    7/12/2004 9:42:26 PM  DSiders
  Removed TODO for Address property.
}
{
    Rev 1.18    7/12/2004 9:24:04 PM  DSiders
  Added TODOs for property name inconsistencies.
}
{
{   Rev 1.17    7/8/04 11:48:28 PM  RLebeau
{ Tweaked TQueryResult.NextDNSLabel()
}
{
{   Rev 1.16    2004.05.20 1:39:30 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.15    2004.04.08 3:57:28 PM  czhower
{ Removal of bytes from buffer.
}
{
{   Rev 1.14    2004.03.01 9:37:04 PM  czhower
{ Fixed name conflicts for .net
}
{
{   Rev 1.13    2/11/2004 5:47:26 AM  JPMugaas
{ Can now assign a port for the DNS host as well as IPVersion.
{
{ In addition, you can now use socks with TCP zone transfers.
}
{
{   Rev 1.12    2/11/2004 5:21:16 AM  JPMugaas
{ Vladimir Vassiliev changes for removal of byte flipping.  Network conversion
{ order conversion functions are used instead.
{ IPv6 addresses are returned in the standard form.
{ In WKS records, Address was changed to IPAddress to be consistant with other
{ record types.  Address can also imply a hostname.
}
{
{   Rev 1.11    2/9/2004 11:27:36 AM  JPMugaas
{ Some functions weren't working as expected.  Renamed them to describe them
{ better.
}
{
{   Rev 1.10    2004.02.03 5:45:58 PM  czhower
{ Name changes
}
{
{   Rev 1.9    11/13/2003 5:46:54 PM  VVassiliev
{ DotNet
{ AAAA record fix
{ Add PTR for IPV6
}
{
{   Rev 1.8    10/25/2003 06:51:54 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.
}
{
    Rev 1.7    10/19/2003 11:57:32 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.6    2003.10.12 3:50:38 PM  czhower
{ Compile todos
}
{
{   Rev 1.5    2003/4/30 ¤U¤È 12:39:54  DChang
{ fix the TIdResolver.ParseAnswers, add 2 parameters for the function
{ to check if QueryResult should be clear or not, TIdResolver.FillResult
{ is modified at the same time.
{ fix AXFR procedure, fully support BIND 8 AXFR procedures.
}
{
{   Rev 1.4    4/28/2003 02:30:50 PM  JPMugaas
{ reverted back to the old one as the new one checked will not compile, has
{ problametic dependancies on Contrs and Dialogs (both not permitted).
}
{
{   Rev 1.2    4/28/2003 07:00:10 AM  JPMugaas
{ Should now compile.
}
{
{   Rev 1.0    11/14/2002 02:18:34 PM  JPMugaas
    Rev 1.3    04/26/2003 02:30:10 PM  DenniesChang
}
{
  IdDNSResolver.

  Started: sometime.
  Finished: 2003/04/26

  IdDNSResolver has integrate UDP and TCP tunnel to resolve then types defined in RFC 1035,
  and AAAA, which is defined in RFC 1884, 1886.

  AXFR command, which is defined in RFC 1995, is also implemented in 2003/04/26

  The resolver also does not support Chaos RR. Only IN RR are supported as of this time.
  Part of code from Ray Malone
}

// Dennies Chang : Combine TIdDNSSyncResolver and TIdDNSCommResolver as TIdDNSResolver.
// 2003/04/26.
// Dennies Chang : Rename TIdDNSResolver as TIdDNSCommonResolver. 2003/04/23
// Dennies Chang : Add TIdDNSSyncClient to implement AXFR command. 2003/04/15
// Dennies Chang : Add atAAAA and TAAAARecord (2002 Oct.)
// Dennies Chang : Add TDNSHeader for IDHeader to maintain DNS Header, but not complete yet.
// SG 28/1/02: Changed the DNSStrToDomain function according to original Author of the old comp: Ray Malone
{SG 10/07/01 Added support for qrStar query}
{VV 12/09/01 Added construction of reverse query (PTR)}
{DS 12/31/01 Corrected ReponsiblePerson spelling}
{VV 01/02/03 TQueryResult.DNSStrToDomain fix}

{ TODO : Add structure of IDHEADER IN FIGURE }

unit IdDNSResolver;

interface

uses
  Classes,
  IdAssignedNumbers,
  IdBuffer,
  IdComponent,
  IdGlobal, IdExceptionCore,
  IdNetworkCalculator,
  IdGlobalProtocols,
  IdDNSCommon,
  IdTCPClient,
  IdTCPConnection,
  IdTStrings,
  IdUDPClient;


type
  { TODO : Solve problem with obsolete records }
  TQueryRecordTypes = (
                         qtA, qtNS, qtMD, qtMF,
                         qtName, qtSOA, qtMB, qtMG,
                         qtMR, qtNull, qtWKS, qtPTR,
                         qtHINFO, qtMINFO, qtMX, qtTXT,
                         //qtRP, qtAfsdb, qtX25, qtISDN,
                         qtRT, qtNSAP, qtNSAP_PTR, qtSIG,
                         //qtKEY, qtPX, qtQPOS,
                         qtAAAA,
                         //qtLOC, qtNXT, qtR31, qtR32,
                         qtService,
                         //qtR34,
                         qtNAPTR,
                         //qtKX,
                         qtCERT, qtV6Addr, qtDName, qtR40,
                         qtOptional, qtIXFR, qtAXFR, qtSTAR);


  {Marked by Dennies Chang at 2004/7/14.
  {TXFRTypes = (xtAXFR, xtIXFR);
  }
const
  Class_IN = 1;
  Class_CHAOS = 3;
  // Lookup table for query record values.
  QueryRecordCount=30;
  QueryRecordValues: array [0..QueryRecordCount] of word= (1,2,3,4,
                                             5,6,7,8,
                                             9,10,11,12,
                                             13,14,15,16,
                                             //17,18,19,20,
                                             21,22,23,24,
                                             //25,26,27,
                                             28,
                                             //29,30,31,32,
                                             33,
                                             //34,
                                             35,
                                             //36,
                                             37,38,39,40,
                                             41, 251, 252, 255);
  QueryRecordTypes: Array [0..QueryRecordCount] of TQueryRecordTypes = (
                    qtA, qtNS, qtMD, qtMF,
                    qtName, qtSOA, qtMB, qtMG,
                    qtMR, qtNull, qtWKS, qtPTR,
                    qtHINFO, qtMINFO, qtMX, qtTXT,
                    //qtRP, qtAfsdb, qtX25, qtISDN,
                    qtRT, qtNSAP, qtNSAP_PTR, qtSIG,
                    //qtKEY, qtPX, qtQPOS,
                    qtAAAA,
                    //qtLOC, qtNXT, qtR31, qtR32,
                    qtService,
                    //qtR34,
                    qtNAPTR,
                    //qtKX,
                    qtCERT, qtV6Addr, qtDName, qtR40,
                    qtOptional, qtIXFR, qtAXFR, qtSTAR);

type
  TQueryType = set of TQueryRecordTypes;

  TResultSection = (rsAnswer,rsNameServer,rsAdditional);
  TResultSections = set of TResultSection;

  TResultRecord = class(TCollectionItem) // Rename to REsourceRecord
  protected
    FRecType: TQueryRecordTypes;
    FRecClass: word;
    FName: string;
    FTTL: cardinal;
    FRDataLength: Integer;
    FRData: TIdBytes;
    FSection: TResultSection;
  public
    procedure Assign(Source: TPersistent); override;
    // Parse the data (descendants only)
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); virtual;
    { TODO : This needs to change (to what? why?) }
    property RecType: TQueryRecordTypes read FRecType;
    property RecClass: word read FRecClass;
    property Name: string read FName;
    property TTL: cardinal read FTTL;
    property RDataLength: Integer read FRDataLength;
    property RData: TIdBytes read FRData;
    property Section:TResultSection read FSection;
    destructor Destroy; override;
  end;

  TResultRecordClass = class of TResultRecord;

  TRDATARecord = class(TResultRecord)
  protected
    FIPAddress: String;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    property IPAddress: string read FIPAddress;
  end;

  TARecord = class(TRDATARecord)
  end;

  TAAAARecord = class (TResultRecord)
  protected
    FAddress: string;
  public
    //TODO: implement AssignTo instead of Assign. (why?)
    procedure Assign(Source: TPersistent); override;
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    //
    property Address : string read FAddress;
  end;

  TWKSRecord = Class(TResultRecord)
  protected
    FByteCount: integer;
    FData: TIdBytes;
    FIPAddress: String;
    FProtocol: Word;
    //
    function GetABit(AIndex: Integer): Byte;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    //
    property IPAddress: String read FIPAddress;
    property Protocol: Word read FProtocol;
    property BitMap[index: integer]: Byte read GetABit;
    property ByteCount: integer read FByteCount;
  end;

  TMXRecord = class(TResultRecord)
  protected
    FExchangeServer: string;
    FPreference: Word;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;

    property ExchangeServer: string read FExchangeServer;
    property Preference: word read FPreference;
  end;

  TTextRecord = class(TResultRecord)
  protected
    FText: TIdStrings;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    Property Text: TIdStrings read FText;
  end;

  TErrorRecord = class(TResultRecord)
  end;

  THINFORecord = Class(TTextRecord)
  protected
    FCPU: String;
    FOS: String;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    property CPU: String read FCPU;
    property OS: String read FOS;
  end;

  TMINFORecord = Class(TResultRecord)
  protected
    FResponsiblePerson: String;
    FErrorMailbox: String;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    property ResponsiblePersonMailbox: String read FResponsiblePerson;
    property ErrorMailbox: String read FErrorMailbox;
  end;

  TSOARecord = class(TResultRecord)
  protected
    FSerial: cardinal;
    FMinimumTTL: Cardinal;
    FRefresh: Cardinal;
    FRetry: Cardinal;
    FMNAME: string;
    FRNAME: string;
    FExpire: Cardinal;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;

    property Primary: string read FMNAME;
    property ResponsiblePerson: string read FRNAME;
    property Serial: cardinal read FSerial;
    property Refresh: Cardinal read FRefresh;
    property Retry: Cardinal read FRetry;
    property Expire: Cardinal read FExpire;

    property MinimumTTL: Cardinal read FMinimumTTL;
  end;

  TNAMERecord = class(TResultRecord)
  protected
    FHostName: string;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    property HostName: string read FHostName;
  end;

  TNSRecord = class(TNAMERecord)
  end;

  TCNRecord = class(TNAMERecord)
  end;

  TSRVRecord = class(TResultRecord)
  private
    FService: string;
    FProtocol: string;
    FPriority: integer;
    FWeight: integer;
    FPort: integer;
    FTarget: string;
    FOriginalName: string;
    function IsValidIdent(const aStr:string):Boolean;
    function CleanIdent(const aStr:string):string;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    property OriginalName:string read FOriginalName;
    property Service: string read FService;
    property Protocol: string read FProtocol;
    property Priority: integer read FPriority;
    property Weight: integer read FWeight;
    property Port: integer read FPort;
    property Target: string read FTarget;
  end;

  TNAPTRRecord = class(TResultRecord)
  private
    FOrder: integer;
    FPreference: integer;
    FFlags: string;
    FService: string;
    FRegExp: string;
    FReplacement: string;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;

    property Order:integer read fOrder;
    property Preference:integer read fPreference;
    property Flags:string read fFlags;
    property Service:string read fService;
    property RegExp:string read fRegExp;
    property Replacement:string read fReplacement;
  end;

  TQueryResult = class(TCollection)
  protected
    FDomainName: String;
    FQueryClass: Word;
    FQueryType: Word;
    FQueryPointerList: TIdStringList;
    function DNSStrToDomain(SrcStr: TIdBytes; var Idx: Integer): string;
    function NextDNSLabel(DNSStr: TIdBytes; Var APos: Integer): string;
    procedure SetItem(Index: Integer; Value: TResultRecord);
    function GetItem(Index: Integer): TResultRecord;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Add(Answer: TIdBytes; var APos: Integer): TResultRecord;
    procedure Clear; reintroduce;
    procedure FilterBySection(const aKeep:TResultSections=[rsAnswer]);
    procedure FilterByClass(const aKeep:TResultRecordClass);

    Property QueryClass: Word read FQueryClass;
    Property QueryType: Word read FQueryType;
    Property DomainName: String read FDomainName;

    property Items[Index: Integer]: TResultRecord read GetItem write SetItem; default;
  end;

  TPTRRecord = Class(TNAMERecord)
  end;

  //TIdTCPConnection looks odd for something that's supposed to be UDP.
  //However, DNS uses TCP for zone-transfers.
  TIdDNSResolver = class(TIdTCPConnection)
  protected
    FAllowRecursiveQueries: boolean;
    FInternalQuery: TIdBytes;
    FQuestionLength: Integer;
    FHost: string;
    FIPVersion: TIdIPVersion;
    FPort: TIdPort;
    FQueryResult: TQueryResult;
    FQueryType: TQueryType;
    FWaitingTime: integer;
    FPlainTextResult: TIdBytes;
    FDNSHeader : TDNSHeader;
    procedure SetInternalQuery(const Value: TIdBytes);
    procedure SetPlainTextResult(const Value: TIdBytes);
    procedure InitComponent; override;
    procedure SetIPVersion(const AValue: TIdIPVersion); virtual;
    function GetIPVersion: TIdIPVersion;
    function GetPort: TIdPort;
    procedure SetPort(const AValue: TIdPort); virtual;
  public
    property DNSHeader:TDNSHeader read FDNSHeader;
    procedure ClearInternalQuery;
    destructor Destroy; override;
    procedure ParseAnswers(DNSHeader: TDNSHeader; Answer: TIdBytes; ResetResult : boolean = true);
    procedure CreateQuery(ADomain: string; SOARR : TIdRR_SOA; QueryClass:integer = Class_IN);
    procedure FillResult(AResult: TIdBytes; checkID : boolean = true;
              ResetResult : boolean = true);
    procedure FillResultWithOutCheckId(AResult: string);
    procedure Resolve(ADomain: string; SOARR : TIdRR_SOA = nil; QClass: integer = Class_IN);
    property QueryResult: TQueryResult read FQueryResult;
    property InternalQuery: TIdBytes read FInternalQuery write SetInternalQuery;
    property PlainTextResult: TIdBytes read FPlainTextResult write SetPlainTextResult;
  published
    property QueryType : TQueryType read FQueryType write FQueryType;
    // TODO: rename to ReadTimeout?
    // Dennies's comment : it's ok, that's just a name.
    property WaitingTime : integer read FWaitingTime write FWaitingTime;
    property AllowRecursiveQueries : boolean read FAllowRecursiveQueries write FAllowRecursiveQueries;
    property Host : string read FHost write FHost;
    property Port : TIdPort read FPort write FPort default IdPORT_DOMAIN;
    property IPVersion: TIdIPVersion read GetIPVersion write SetIPVersion;
  end;

implementation

uses
  IdBaseComponent,
  IdResourceStringsProtocols,
  IdStack,
  SysUtils;

// SG 28/1/02: Changed that function according to original Author of the old comp: Ray Malone
function TQueryResult.DNSStrToDomain(SrcStr: TIdBytes; var Idx: Integer): string;
var
  LabelStr : String;
  Len : Integer;
  SavedIdx : Integer;
  AChar :Byte;
  fRPackSize: Integer;
  i: Integer;
begin
    Result := '';                {Do not Localize}
    fRPackSize := Length(SrcStr);
    SavedIdx := -1;
    repeat
      Len := SrcStr[Idx];
      while (Len and $C0) = $C0 do // {!!0.01} added loop for pointer
      begin                         // that points to a pointer. Removed  >63 hack. Am I really that stupid?
        if SavedIdx < 0 then
        begin
          SavedIdx := Succ(Idx); // it is important to return to original index  spot
        end;
	// when we go down more than 1 level.
        aChar := Len and $3F;                       // strip first two bits ($C) from first byte of offset pos
        Idx := GStack.NetworkToHost(TwoByteToWord(aChar, SrcStr[Idx + 1]));// + 1; // add one to index for delphi string index //VV
        Len := SrcStr[Idx];  // if len is another $Cx we will (while) loop again
      end;
      Assert(Idx < fRPackSize, GetErrorStr(2, 2)); // loop screwed up. This  very very unlikely now  could be removed.
      SetLength(LabelStr, Len);
      if Len > 0 then
      begin
        for i := 1 to Len do
        begin
          LabelStr[i] := Char(SrcStr[Idx + i]);
        //Move(SrcStr[Idx + 1], LabelStr[1], Length(LabelStr));
        end;
        Inc(Idx, Length(LabelStr) + 1);
      end;
      if Pred(Idx) > fRPackSize then // len byte was corrupted puting us past end of packet
        raise  EIdDnsResolverError.Create(GetErrorStr(2, 3));
      Result := Result + LabelStr + '.';  // concat and add period.  {Do not Localize}
    until (SrcStr[Idx] = 0) or (Idx >= Length(SrcStr)); // name field ends with nul byte
    if Result[Length(Result)] = '.' then  // remove final period    {Do not Localize}
    begin
      //System.Delete(Result, Length(Result), 1);
      SetLength(Result, Length(Result) - 1);
    end;
    if SavedIdx >= 0 then Idx := SavedIdx; // restore original Idx +1
    Inc(Idx); // set to first char of next item in  the resource
end;

function TQueryResult.NextDNSLabel(DNSStr: TIdBytes; Var APos: Integer): string;
var
  LabelLength: Byte;
begin
  if Length(DNSStr) > APos then begin
    LabelLength := Integer(DNSStr[APos]);
    Inc(APos);
    //VV Shouldn't be pointers in Text messages
      if (LabelLength > 0) then begin
        Result := BytesToString(DNSStr, APos, LabelLength);
        Inc(APos, LabelLength);
        Exit;
      end;
  end;
  Result := '';      {Do not Localize}
end;

procedure TRDATARecord.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TARecord then
  begin
    FIPAddress := TARecord(Source).IPAddress;
  end;
end;

procedure TRDATARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  if Length(RData) > 0 then
  begin
    FIPAddress := MakeDWordIntoIPv4Address( GStack.NetworkToHost( OrdFourByteToCardinal(RData[0], RData[1], RData[2], RData[3])));
//    FIPAddress := Format('%d.%d.%d.%d',[RData[0], RData[1], RData[2], RData[3]]);  {Do not Localize}
  end;
end;

{ TMXRecord }

procedure TMXRecord.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TMXRecord then
  begin
    FExchangeServer := TMXRecord(Source).ExchangeServer;
    FPreference := TMXRecord(Source).Preference;
  end;
end;

procedure TNAMERecord.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TNAMERecord then
  begin
    FHostName := TNAMERecord(Source).HostName;
  end;
end;

{ TQueryResult }

function TQueryResult.Add(Answer: TIdBytes; var APos: Integer): TResultRecord;
var
  RRName: String;
  RR_type, RR_Class: word;
  RR_TTL: Cardinal;
  RD_Length: word;
  RData: TIdBytes;
begin
  // extract the RR data
  RRName := DNSStrToDomain(Answer, APos);
  RR_Type := GStack.NetworkToHost( TwoByteToWord(Answer[APos], Answer[APos + 1]));
  RR_Class := GStack.NetworkToHost(TwoByteToWord(Answer[APos + 2], Answer[APos + 3]));
  RR_TTL := GStack.NetworkToHost( OrdFourByteToCardinal(Answer[APos + 4], Answer[APos + 5], Answer[APos + 6], Answer[APos + 7]));
  RD_Length := GStack.NetworkToHost(TwoByteToWord(Answer[APos + 8], Answer[APos + 9]));
  RData := Copy(Answer, APos + 10, RD_Length);
  // remove what we have read from the buffer
  // Read the record type
  // Dennies Chang had modified this part to indicate type by RR_type
  // because RR_type is integer, we can use TypeCode which is defined
  // in IdDNSCommon to select all record type.
  case RR_Type of
    TypeCode_A ://qtA:
    begin
      result := TARecord.Create(Self);
    end;
    TypeCode_NS : //qtNS:
    begin
      result := TNSRecord.Create(Self);
    end;
    TypeCode_MX ://qtMX:
    begin
      result := TMXRecord.Create(Self);
    end;
    TypeCode_CName : // qtName:
    begin
      result := TNAMERecord.Create(Self);
    end;
    TypeCode_SOA : //qtSOA:
    begin
      result := TSOARecord.Create(Self);
    end;
    TypeCode_HINFO : //qtHINFO:
    begin
      result := THINFORecord.Create(Self);
    end;
    TypeCode_TXT ://qtTXT:
    begin
      result := TTextRecord.Create(Self);
    end;
    TypeCode_WKS ://qtWKS:
    begin
      result := TWKSRecord.Create(Self);
    end;
    TypeCode_PTR :// qtPTR:
    begin
      result := TPTRRecord.Create(Self);
    end;
    TypeCode_MINFO ://qtMINFO:
    begin
      result := TMINFORecord.Create(Self);
    end;
    TypeCode_AAAA : //qtAAAA:
    begin
      result := TAAAARecord.Create(Self);
    end;
    TypeCode_Service :
    begin
      result := TSRVRecord.Create(Self);
    end;
    TypeCode_NAPTR :
    begin
      result := TNAPTRRecord.Create(Self);
    end;
    else
      // Unsupported query type, return generic record
      result := TResultRecord.Create(self);
  end; // case
  // Set the "general purpose" options
  if assigned(result) then
  begin
    //if RR_Type <= High(QueryRecordTypes) then
    // modified in 2004 7/15.
    case RR_Type of
         TypeCode_A : result.FRecType := qtA;
         TypeCode_NS : result.FRecType := qtNS;
         TypeCode_MD : result.FRecType := qtMD;
         TypeCode_MF : result.FRecType := qtMF;
         TypeCode_CName: result.FRecType := qtName;
         TypeCode_SOA  : result.FRecType := qtSOA;
         TypeCode_MB   : result.FRecType := qtMB;
         TypeCode_MG   : result.FRecType := qtMG;
         TypeCode_MR   : result.FRecType := qtMR;
         TypeCode_NULL : result.FRecType := qtNull;
         TypeCode_WKS  : result.FRecType := qtWKS;
         TypeCode_PTR  : result.FRecType := qtPTR;
         TypeCode_HINFO: result.FRecType := qtHINFO;
         TypeCode_MINFO: result.FRecType := qtMINFO;
         TypeCode_MX   : result.FRecType := qtMX;
         TypeCode_TXT  : result.FRecType := qtTXT;
         //TypeCode_NSAP : result.FRecType := QueryRecordTypes[Ord(RR_Type) - 1];
         //TypeCode_NSAP_PTR : result.FRecType := QueryRecordTypes[Ord(RR_Type) - 1];
         TypeCode_AAAA : result.FRecType := qtAAAA;
         //TypeCode_LOC :  result.FRecType := QueryRecordTypes[Ord(RR_Type) - 1];
         TypeCode_Service : Result.FRecType := qtService;
         TypeCode_NAPTR : Result.FRecType := qtNAPTR;
         TypeCode_AXFR : result.FRecType := qtAXFR;
         //TypeCode_STAR : result.FRecType := qtSTAR;
    end;

    result.FRecClass := RR_Class;
    result.FName := RRName;
    result.FTTL := RR_TTL;
    Result.FRData := Copy(RData, 0{1}, RD_Length);
    Result.FRDataLength := RD_Length;
    // Parse the result
    // Since the DNS message can be compressed, we need to have the whole message to parse it, in case
    // we encounter a pointer
    //Result.Parse(Copy(Answer, 0{1}, APos + 9 + RD_Length), APos + 10);
    Result.Parse(Answer, APos + 10);
  end;
  // Set the new position
  inc(APos, RD_Length + 10);
end;

constructor TQueryResult.Create;
begin
  inherited Create(TResultRecord);
  FQueryPointerList := TIdStringList.Create;
end;

destructor TQueryResult.destroy;
begin
  FreeAndNil(FQueryPointerList);
  inherited;
end;

function TQueryResult.GetItem(Index: Integer): TResultRecord;
begin
  Result := TResultRecord(inherited GetItem(Index));
end;

procedure TQueryResult.SetItem(Index: Integer; Value: TResultRecord);
begin
  inherited SetItem(Index, Value);
end;

procedure TResultRecord.Assign(Source: TPersistent);
var
 aSource:TResultRecord;
begin
 if Source is TResultRecord then
 begin
   aSource:=TResultRecord(Source);
   FRecType:=aSource.RecType;
   FRecClass:=aSource.RecClass;
   FName:=aSource.Name;
   FTTL:=aSource.TTL;
   FRDataLength:=aSource.RDataLength;
   FRData:=ToBytes(aSource.RData,Length(aSource.RData));
   FSection:=aSource.Section;
 end
 else
 begin
   inherited;
 end;
end;

destructor TResultRecord.Destroy;
begin
  inherited;
end;

procedure TResultRecord.Parse;
begin

end;

procedure TNAMERecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FHostName := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
end;


procedure TQueryResult.Clear;
begin
  inherited Clear;
  FQueryPointerList.Clear;
end;

procedure TMXRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FPreference := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos], CompleteMessage[APos + 1]));
  Inc(Apos, 2);
  FExchangeServer := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
end;

procedure TQueryResult.Assign(Source: TPersistent);
//TCollection.Assign doesn't create correct Item class.
var
 i:Integer;
 aRec:TResultRecord;
 aNew:TResultRecord;
begin
  //no inherited;
  if Source is TQueryResult then
  begin
    BeginUpdate;
    try
    Clear;
    for i:=0 to TQueryResult(Source).Count-1 do
    begin
      aRec:=TQueryResult(Source).Items[i];
      aNew:=TResultRecordClass(aRec.ClassType).Create(Self);
      aNew.Assign(aRec);
    end;
    finally
    EndUpdate;
    end;
  end
  else
  begin
    inherited;
  end;
end;

{ TTextRecord }

procedure TTextRecord.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TTextRecord then
  begin
    FText.Assign(TTextRecord(Source).Text);
  end;
end;

constructor TTextRecord.Create(Collection: TCollection);
begin
  inherited;
  FText := TIdStringList.Create;
end;

destructor TTextRecord.Destroy;
begin
  FreeAndNil(FText);
  inherited;
end;

procedure TTextRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
//the support for long text values is required for DomainKeys,
//which has an encoded public key
var
  aStart:Integer;
  Buffer: string;
begin
  FText.Clear;

  aStart:=APos;
  while APos<aStart+RDataLength do
  begin
    Buffer := Buffer+(Collection as TQueryResult).NextDNSLabel(CompleteMessage, APos);
  end;

  if Buffer <> '' then   {Do not Localize}
  begin
    FText.Add(Buffer);
  end;
  inherited;
end;

{ TSOARecord }

procedure TSOARecord.Assign(Source: TPersistent);
var
 aSource:TSOARecord;
begin
  inherited;
  aSource:=Source as TSOARecord;
  FSerial:=aSource.Serial;
  FMinimumTTL:=aSource.MinimumTTL;
  FRefresh:=aSource.Refresh;
  FRetry:=aSource.Retry;
  FMNAME:=aSource.FMNAME;
  FRNAME:=aSource.FRNAME;
  FExpire:=aSource.Expire;
end;

procedure TSOARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FMNAME := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
  FRNAME := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
  FSerial := GStack.NetworkToHost( OrdFourByteToCardinal(CompleteMessage[APos], CompleteMessage[APos + 1], CompleteMessage[APos + 2], CompleteMessage[APos + 3]));
  inc(Apos, 4);
  FRefresh := GStack.NetworkToHost( OrdFourByteToCardinal(CompleteMessage[APos], CompleteMessage[APos + 1], CompleteMessage[APos + 2], CompleteMessage[APos + 3]));
  inc(Apos, 4);
  FRetry := GStack.NetworkToHost( OrdFourByteToCardinal(CompleteMessage[APos], CompleteMessage[APos + 1], CompleteMessage[APos + 2], CompleteMessage[APos + 3]));
  inc(Apos, 4);
  FExpire := GStack.NetworkToHost( OrdFourByteToCardinal(CompleteMessage[APos], CompleteMessage[APos + 1], CompleteMessage[APos + 2], CompleteMessage[APos + 3]));
  inc(Apos, 4);
  FMinimumTTL := GStack.NetworkToHost( OrdFourByteToCardinal(CompleteMessage[APos], CompleteMessage[APos + 1], CompleteMessage[APos + 2], CompleteMessage[APos + 3]));
end;

{ TWKSRecord }

procedure TWKSRecord.Assign(Source: TPersistent);
var
  aSource:TWKSRecord;
begin
  inherited;
  aSource:=Source as TWKSRecord;
  FIPAddress:=aSource.IPAddress;
  FProtocol:=aSource.Protocol;
  FByteCount:=aSource.ByteCount;
  FData:=ToBytes(aSource.FData,Length(aSource.FData));
end;

function TWKSRecord.GetABit(AIndex: Integer): Byte;
begin
  Result := FData[AIndex];
end;

procedure TWKSRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FIPAddress := MakeDWordIntoIPv4Address( GStack.NetworkToHost( OrdFourByteToCardinal(RData[0], RData[1], RData[2], RData[3])));
    //Format('%d.%d.%d.%d',[Word(RData[0]), Word(RData[1]), Word(RData[2]), Word(RData[3])]);   {Do not Localize}
  FProtocol := Word(Rdata[4]);
  //TODO: This is really inefficient - just slice off the first 5 bytes instead. This code is old
  // and this way just because I ported it direct from an older implementation
  with TIdBuffer.Create do try
    Write(FRData);
    Remove(5);
    ExtractToBytes(FData);
  finally Free; end;
end;

{ TMINFORecord }

procedure TMINFORecord.Assign(Source: TPersistent);
var
 aSource:TMINFORecord;
begin
  inherited;
  aSource:=Source as TMINFORecord;
  FResponsiblePerson:=aSource.ResponsiblePersonMailbox;
  FErrorMailbox:=aSource.ErrorMailbox;
end;

procedure TMINFORecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FResponsiblePerson := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
  FErrorMailbox := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
end;

{ THINFORecord }

procedure THINFORecord.Assign(Source: TPersistent);
var
 aSource:THINFORecord;
begin
  inherited;
  aSource:=Source as THINFORecord;
  FCPU:=aSource.CPU;
  FOS:=aSource.OS;
end;

procedure THINFORecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited;
  FCPU := (Collection as TQueryResult).NextDNSLabel(CompleteMessage, APos);
  FOS := (Collection as TQueryResult).NextDNSLabel(CompleteMessage, APos);
end;

{ TAAAARecord }

procedure TAAAARecord.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TAAAARecord then
  begin
    FAddress := TAAAARecord(Source).Address;
  end;
end;

procedure TAAAARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var FIP6 : TIdIPv6Address;
  i : Integer;
begin
  inherited;
  if Length(RData) >= 15 then
  begin
     FIP6 := BytesToIPv6(RData);
     for i := 0 to 7 do
     begin
       FIP6[i] := GStack.NetworkToHost(FIP6[i]);
     end;
     FAddress :=  IPv6AddressToStr(FIP6);
     { := Format('%.2x%.2x:%.2x%.2x:%.2x%.2x:%.2x%.2x:%.2x%.2x:%.2x%.2x:%.2x%.2x:%.2x%.2x',  {Do not Localize}
{                            [RData[0], RData[1], RData[2], RData[3],
                             RData[4], RData[5], RData[6], RData[7],
                             RData[8], RData[9], RData[10], RData[11],
                             RData[12], RData[13], RData[14], RData[15]]); }
  end;
end;

{ TIdDNSResolver }

procedure TIdDNSResolver.ClearInternalQuery;
begin
  SetLength(FInternalQuery, 0);
  FQuestionLength := 0;
end;

procedure TIdDNSResolver.CreateQuery(ADomain: string; SOARR : TIdRR_SOA;
          QueryClass:integer=1);

  function DoDomainName(ADNS : String): TIdBytes;
  var
    BufStr : String;
    LLen : Byte;
  begin                         { DoDomainName }
    SetLength(Result, 0);
    while Length(aDns) > 0 do begin
      BufStr := Fetch(aDns, '.');    {Do not Localize}
      LLen := Length(BufStr);
      AppendByte(Result, LLen);
      AppendString(Result, BufStr, LLen);
    end;
  end;

  function DoHostAddressV6(const aDNS :String): TIdBytes;
  var
    IPV6str, IPV6Ptr: string;
    i: integer;
  begin
    if not IsValidIPv6(aDNS) then
      raise EIdDnsResolverError.CreateFmt(RSQueryInvalidIpV6, [aDNS]);
    IPV6str := ConvertToCanonical6IP(aDNS);
    IPV6Ptr := '';                               {Do not Localize}
    for i := Length(IPV6str) downto 1 do
    begin
      if IPV6str[i] <> ':' then                 {Do not Localize}
        IPV6Ptr := IPV6Ptr + IPV6str[i] + '.';  {Do not Localize}
    end;
    IPV6Ptr := IPV6Ptr + 'IP6.INT';  {Do not Localize}
    Result := DoDomainName(IPV6Ptr);
  end;

  function DoHostAddress(aDNS :String): TIdBytes;
  var
    sBufStr, First, Second, Third, Fourth : String;
    LLen: Byte;
  begin                         { DoHostAddress }
    if pos(':', aDNS) > 0 then begin  {Do not Localize}
      Result := DoHostAddressV6(aDNS)
    end else begin
      SetLength(Result, 0);
      sBufStr := aDNS;

      First := Fetch(sBufStr, '.');
      Second := Fetch(sBufStr, '.');
      Third := Fetch(sBufStr, '.');
      Fourth := sBufStr;

      LLen := Length(Fourth);
      AppendByte(Result, LLen);
      AppendString(Result, Fourth, LLen);

      LLen := Length(Third);
      AppendByte(Result, LLen);
      AppendString(Result, Third, LLen);

      LLen := Length(Second);
      AppendByte(Result, LLen);
      AppendString(Result, Second, LLen);

      LLen := Length(First);
      AppendByte(Result, LLen);
      AppendString(Result, First, LLen);

      AppendByte(Result, 7);
      AppendString(Result, 'in-addr', 7); {do not localize}
      AppendByte(Result, 4);
      AppendString(Result, 'arpa', 4); {do not localize}
    end;
  end;                          { DoHostAddress }


var
  ARecType: TQueryRecordTypes;
  iQ: Integer;
  AQuestion, AAuthority: TIdBytes;
  TempBytes: TIdBytes;
  w : Word;
begin
  SetLength(TempBytes, 2);
  SetLength(AAuthority, 0);
  FDNSHeader.ID := Random(65535);

  FDNSHeader.ClearByteCode;
  FDNSHeader.Qr := 0;
  FDNSHeader.OpCode := 0;
  FDNSHeader.ANCount := 0;
  FDNSHeader.NSCount :=0;
  FDNSHeader.ARCount :=0;
  //do not reverse the bytes because this is a bit set
  FDNSHeader.RD := Word(FAllowRecursiveQueries);

  iQ := 0;
  // Iterate thru questions
  { TODO : Optimize for non-double loop }
  if not ((qtAXFR in QueryType) and (qtIXFR in QueryType))then
  begin
    for ARecType := Low(TQueryRecordTypes) to High(TQueryRecordTypes) do
    begin
     if ARecType in QueryType then
     begin
       inc(iQ);
     end;
    end;
  end else
  begin
    iQ := 1; // if exec AXFR, there can be only one Question.

    if (qtIXFR in QueryType) then
    begin
         // if exec IXFR, we must include a SOA record in Authority Section (RFC 1995)
         if Assigned(SOARR) then begin
            AAuthority := SOARR.BinQueryRecord('');
         end else begin
             raise  EIdDnsResolverError.Create(GetErrorStr(7, 3));
         end;

         FDNSHeader.AA := 1;
    end;
  end;

  FDNSHeader.QDCount := iQ;
  if FDNSHeader.QDCount = 0 then
  begin
    ClearInternalQuery;
    Exit;
  end;

  InternalQuery := FDNSHeader.GenerateBinaryHeader;

  if (qtAXFR in Self.QueryType) then begin
    if (IndyPos('IN-ADDR', UpperCase(ADomain)) > 0) or   {Do not Localize}
      (IndyPos('IP6.INT', UpperCase(ADomain)) > 0) then  {do not localize}
    begin
      AppendBytes(AQuestion, DoHostAddress(ADomain));
      AppendByte(AQuestion, 0);
    end else
    begin
      AppendBytes(AQuestion, DoDomainName(ADomain));
      AppendByte(AQuestion, 0);
    end;
    //we do this in a round about manner because HostToNetwork will not always
    //work the same
    w := 252;
    w := GStack.HostToNetwork(w);
    WordToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes)   ; // Type = AXFR
    w := QueryClass;
    w := GStack.HostToNetwork(w);
    WordToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes);
  end else begin
    if (qtIXFR in Self.QueryType) then begin
         if (IndyPos('IN-ADDR', UpperCase(ADomain)) > 0) or   {Do not Localize}
            (IndyPos('IP6.INT', UpperCase(ADomain)) > 0) then  {do not localize}
         begin
              AppendBytes(AQuestion, DoHostAddress(ADomain));
              AppendByte(AQuestion, 0);
         end else
         begin
              AppendBytes(AQuestion, DoDomainName(ADomain));
              AppendByte(AQuestion, 0);
         end;
         //we do this in a round about manner because HostToNetwork will not always
         //work the same
         w := 251;
         w := GStack.HostToNetwork(w);
         WordToTwoBytes(w, TempBytes, 0);
         AppendBytes(AQuestion, TempBytes)   ; // Type = IXFR
         w := QueryClass;
         w := GStack.HostToNetwork(w);
         WordToTwoBytes(w, TempBytes, 0);
         AppendBytes(AQuestion, TempBytes);
    end else begin
         for ARecType := Low(TQueryRecordTypes) to High(TQueryRecordTypes) do begin
               if ARecType in QueryType then begin
                    // Create the question
                    if (ARecType = qtPTR) and (IndyPos('IN-ADDR', UpperCase(ADomain)) = 0) and {Do not Localize}
                       (IndyPos('IP6.INT', UpperCase(ADomain)) = 0) then begin {do not localize}
                          AppendBytes(AQuestion, DoHostAddress(ADomain));
                          AppendByte(AQuestion, 0);
                    end else begin
                         AppendBytes(AQuestion, DoDomainName(ADomain));
                         AppendByte(AQuestion, 0);
                    end;
                    w := QueryRecordValues[Ord(ARecType)];
                    w := GStack.HostToNetwork(w);
                    WordToTwoBytes(w, TempBytes, 0);
                    AppendBytes(AQuestion, TempBytes);
                    w := QueryClass;
                    w := GStack.HostToNetwork(w);
                    WordToTwoBytes(w, TempBytes, 0);
                    AppendBytes(AQuestion, TempBytes);
               end;
         end;
    end;
  end;
  AppendBytes(FInternalQuery, AQuestion);
  FQuestionLength := Length(FInternalQuery);
  FDNSHeader.ParseQuery(FInternalQuery);
end;

destructor TIdDNSResolver.Destroy;
begin
  FreeAndNil(FQueryResult);
  FreeAndNil(FDNSHeader);
  inherited Destroy;
end;

procedure TIdDNSResolver.FillResult(AResult: TIdBytes; checkID : boolean = true;
          ResetResult : boolean = true);
var
  ReplyId: Word;
  NAnswers: Word;
begin
  { TODO : Check bytes received }
  // Check to see if the reply is the one waited for
  if Length(AResult) < 12 then begin
    raise EIdDnsResolverError.Create(GetErrorStr(5, 29));
  end;
{  if Length(AResult) < Self.FQuestionLength then begin
    raise EIdDnsResolverError.Create(GetErrorStr(5, 30));
  end;      }

  ReplyId := GStack.NetworkToHost(TwoByteToWord(AResult[0],AResult[1]));

  if checkID then begin
     if ReplyId <> FDNSHeader.Id then raise EIdDnsResolverError.Create(GetErrorStr(4, FDNSHeader.id));
  end;
  FDNSHeader.ParseQuery(AResult);

  if FDNSHeader.RCode <> 0 then
  begin
    raise EIdDnsResolverError.Create(GetRCodeStr(FDNSHeader.RCode));
  end;

  NAnswers := FDNSHeader.ANCount + FDNSHeader.NSCount + FDNSHeader.ARCount;
  if NAnswers > 0 then begin
    // Move Pointer to Start of answers
    if Length(AResult) > 12 then
    begin
      ParseAnswers(FDNSHeader, AResult, ResetResult);
    end;
  end;
end;

procedure TIdDNSResolver.FillResultWithOutCheckId(AResult: string);
var
  NAnswers: Word;
  //TempHeader : TDNSHeader;
  InternalResult : TIdBytes;
begin
  SetLength(InternalResult, 0);
  InternalResult := ToBytes(AResult);
  Self.FDNSHeader.ParseQuery(InternalResult);

  if Length(InternalResult) < 12 then begin
    Raise EIdDnsResolverError.Create(GetErrorStr(5, 29));
  end;

  NAnswers := Self.FDNSHeader.ANCount +
           Self.FDNSHeader.NSCount + Self.FDNSHeader.ARCount;
  if NAnswers > 0 then begin
    // Move Pointer to Start of answers
    if Length(InternalResult) > 12 then
      ParseAnswers(Self.FDNSHeader, InternalResult);
  end;
end;


procedure TQueryResult.FilterBySection(const aKeep: TResultSections);
var
 i:Integer;
begin
 for i:=Count-1 downto 0 do
 begin
   if not (Items[i].Section in aKeep) then Delete(i);
 end;
end;

procedure TQueryResult.FilterByClass(const aKeep:TResultRecordClass);
var
 i:Integer;
begin
 for i:=Count-1 downto 0 do
 begin
   if not (Items[i] is aKeep) then Delete(i);
 end;
end;

function TIdDNSResolver.GetIPVersion: TIdIPVersion;
begin
  result := FIPVersion;
end;

function TIdDNSResolver.GetPort: TIdPort;
begin
  Result := FPort;
end;

procedure TIdDNSResolver.InitComponent;
begin
  inherited;
  Port := IdPORT_DOMAIN;
  FQueryResult := TQueryResult.Create;
  FDNSHeader := TDNSHeader.Create;
  FAllowRecursiveQueries := true;
  Self.WaitingTime := 5000;
end;

procedure TIdDNSResolver.ParseAnswers(DNSHeader: TDNSHeader; Answer: TIdBytes; ResetResult : boolean = true);
var
  i: integer;
  APos: Integer;
  aResult:TResultRecord;
begin
  if ResetResult then
  begin
    QueryResult.Clear;
  end;
  APos := 12; //13; // Header is 12 byte long we need next byte
  // if QDCount = 1, we need to process Question first.

  if DNSHeader.QDCount = 1 then begin
     // first, get the question
     // extract the domain name
     QueryResult.FDomainName :=  QueryResult.DNSStrToDomain(Answer, APos);
     // get the query type
     QueryResult.FQueryType := TwoByteToWord(Answer[APos], Answer[APos + 1]);
     Inc(APos, 2);
     // get the Query Class
     QueryResult.FQueryClass := TwoByteToWord(Answer[APos], Answer[APos + 1]);
     Inc(APos, 2);
  end;

  for i:= 1 to DNSHeader.ANCount do
  begin
    aResult:=QueryResult.Add(Answer, APos);
    aResult.FSection:=rsAnswer;
  end;

  for i:= 1 to DNSHeader.NSCount do
  begin
    aResult:=QueryResult.Add(Answer, APos);
    aResult.FSection:=rsNameServer;
  end;

  for i:= 1 to DNSHeader.ARCount do
  begin
    aResult:=QueryResult.Add(Answer, APos);
    aResult.FSection:=rsAdditional;
  end;

end;

procedure TIdDNSResolver.Resolve(ADomain: string; SOARR : TIdRR_SOA = nil;
          QClass: integer = Class_IN);
var
  UDP_Tunnel : TIdUDPClient;
  TCP_Tunnel : TIdTCPClient;
  LRet: Integer;
  LResult: TIdBytes;
  BytesReceived: Integer;
begin
  ClearInternalQuery;
  // Resolve queries the DNS for the records contained in the
  if FQuestionLength = 0 then begin
    if not (qtIXFR in Self.QueryType) then
       CreateQuery(ADomain, nil, QClass)
    else CreateQuery(ADomain, SOARR, QClass);
  end;

  if Self.FQuestionLength = 0 then begin
    raise EIdDnsResolverError.CreateFmt(RSQueryInvalidQueryCount, [0]);
  end;

  if not (qtAXFR in Self.QueryType) then begin
     if not (qtIXFR in Self.QueryType) then begin
        UDP_Tunnel := TIdUDPClient.Create(Self);
        try
           UDP_Tunnel.Host := Self.Host;
           UDP_Tunnel.Port := Self.Port;
           UDP_Tunnel.IPVersion := Self.IPVersion;

           UDP_Tunnel.SendBuffer(InternalQuery);

           SetLength(LResult, 8192);
           BytesReceived := UDP_Tunnel.ReceiveBuffer(LResult, WaitingTime);
           SetLength(LResult, BytesReceived);

           if Length(LResult) > 0 then begin
              PlainTextResult := LResult;
           end else begin
               SetLength(FPlainTextResult, 0);
           end;
        finally
           FreeAndNil(UDP_Tunnel);
        end;

        if Length(LResult) > 4 then begin
           FillResult(LResult);
        end;
        {
        end else begin
             raise EIdDnsResolverError.Create(RSDNSTimeout);
        end;
        }
     end else begin
         // IXFR
         TCP_Tunnel := TIdTCPClient.Create(Self);
         try
            TCP_Tunnel.Host := Self.Host;
            TCP_Tunnel.Port := Self.Port;
            TCP_Tunnel.IPVersion := Self.IPVersion;
            TCP_Tunnel.IOHandler := IOHandler;

            { Thanks RLebeau, you fix a lot of codes which I do not spend time
              to do - Dennies Chang.
            }

            try
               TCP_Tunnel.Connect;
               TCP_Tunnel.IOHandler.Write(SmallInt(Self.FQuestionLength));
               TCP_Tunnel.IOHandler.Write(Self.InternalQuery);

               Self.QueryResult.Clear;

               LRet := TCP_Tunnel.IOHandler.ReadSmallInt();
               SetLength(LResult, LRet);
               TCP_Tunnel.IOHandler.ReadBytes(LResult, LRet);
               PlainTextResult := LResult;

               if LRet > 4 then begin
                  FillResult(LResult, False, False);

                  if Self.QueryResult.Count = 0 then begin
                  {
                     for Count := 0 to Self.QueryResult.Count -1 do begin
                         if Self.QueryResult.Items[Count] is TSOARecord then
                            Inc(NSCount);
                     end;
                  end else begin
                  }
                      raise EIdDnsResolverError.Create(GetErrorStr(2,3));
                  end
               end else raise EIdDnsResolverError.Create(RSDNSTimeout);

               TCP_Tunnel.Disconnect;
            except
                  on EIdConnectTimeout do begin
                     SetLength(FPlainTextResult, 0);
                     EIdDNSResolverError.Create(RSDNSTimeout);
                  end;
                  on EIdConnectException do begin
                     SetLength(FPlainTextResult, 0);
                     EIdDNSResolverError.Create(RSTunnelConnectToMasterFailed);
                  end;
            end;
         finally
                FreeAndNil(TCP_Tunnel);
         end;
     end;
  end else begin
    // AXFR
    TCP_Tunnel := TIdTCPClient.Create(Self);
    try
      TCP_Tunnel.Host := Self.Host;
      TCP_Tunnel.Port := Self.Port;
      TCP_Tunnel.IPVersion := Self.IPVersion;
      TCP_Tunnel.IOHandler := IOHandler;

{ RLebeau - already performed above...
      if Self.FQuestionLength = 0 then begin
        raise EIdDnsResolverError.CreateFmt(RSQueryInvalidQueryCount, [0]);
      end;
}

      try
        TCP_Tunnel.Connect;
        TCP_Tunnel.IOHandler.Write(SmallInt(Self.FQuestionLength));
        TCP_Tunnel.IOHandler.Write(Self.InternalQuery);

        Self.QueryResult.Clear;

        LRet := TCP_Tunnel.IOHandler.ReadSmallInt();
        SetLength(LResult, LRet);
        TCP_Tunnel.IOHandler.ReadBytes(LResult, LRet);
        PlainTextResult := LResult;

        if LRet > 4 then begin
           FillResult(LResult, False, False);

           {for Count := 0 to Self.QueryResult.Count -1 do begin
               if Self.QueryResult.Items[Count] is TSOARecord then
                  Inc(NSCount);
           end;
           }

        end else raise EIdDnsResolverError.Create(RSDNSTimeout);

        TCP_Tunnel.Disconnect;
      except
        on EIdConnectTimeout do begin
          SetLength(FPlainTextResult, 0);
          EIdDNSResolverError.Create(RSDNSTimeout);
        end;
        on EIdConnectException do begin
          SetLength(FPlainTextResult, 0);
          EIdDNSResolverError.Create(RSTunnelConnectToMasterFailed);
        end;
      end;
    finally
      FreeAndNil(TCP_Tunnel);
    end;
  end;
end;

procedure TIdDNSResolver.SetInternalQuery(const Value: TIdBytes);
begin
  FQuestionLength := Length(Value);
  SetLength(FInternalQuery, FQuestionLength);
  CopyTIdByteArray(Value, 0, FInternalQuery, 0, FQuestionLength);
  Self.FDNSHeader.ParseQuery(Value);
end;

procedure TIdDNSResolver.SetIPVersion(const AValue: TIdIPVersion);
begin
   FIPVersion := AValue;
end;

procedure TIdDNSResolver.SetPlainTextResult(const Value: TIdBytes);
var
  l: integer;
begin
  l := Length(Value);
  SetLength(FPlainTextResult, l);
  CopyTIdByteArray(Value, 0, FPlainTextResult, 0, l);
end;

procedure TIdDNSResolver.SetPort(const AValue: TIdPort);
begin
 FPort := AValue;
end;

procedure TSRVRecord.Assign(Source: TPersistent);
var
 aSource:TSRVRecord;
begin
  inherited;

  if Source is TSRVRecord then
  begin
    aSource:=TSRVRecord(Source);
    FService := aSource.Service;
    FProtocol := aSource.Protocol;
    FPriority := aSource.Priority;
    FWeight := aSource.Weight;
    FPort := aSource.Port;
    FTarget := aSource.Target;
  end;

end;

function TSRVRecord.CleanIdent(const aStr: string): string;
begin
 Result:=Copy(aStr,2,Length(aStr)-1);
end;

function TSRVRecord.IsValidIdent(const aStr: string): Boolean;
begin
 Result:=(Length(aStr)>1) and (aStr[1]='_'); {Do not Localize}
end;

procedure TSRVRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var
 aName,aService,aProtocol:string;
begin
  inherited;

  FOriginalName:=FName;

  //this is to split: _sip._udp.example.com
  aName:=FName;
  aService:=Fetch(aName,'.',True,False);
  aProtocol:=Fetch(aName,'.',True,False);
  if IsValidIdent(aService) and IsValidIdent(aProtocol) and (aName<>'') then
  begin
    FService:=CleanIdent(aService);
    FProtocol:=CleanIdent(aProtocol);
    FName:=aName;
  end;

  Self.FPriority := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos],CompleteMessage[APos+1]));
  Inc(Apos, 2);

  Self.FWeight := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos],CompleteMessage[APos+1]));
  Inc(Apos, 2);

  Self.FPort := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos],CompleteMessage[APos+1]));
  Inc(Apos, 2);

  Self.FTarget := (Collection as TQueryResult).DNSStrToDomain(CompleteMessage, APos);
end;

procedure TNAPTRRecord.Assign(Source: TPersistent);
var
 aSource:TNAPTRRecord;
begin
 inherited;

 if Source is TNAPTRRecord then
 begin
   aSource:=Source as TNAPTRRecord;
   FOrder:=aSource.Order;
   FPreference:=aSource.Preference;
   FFlags:=aSource.FFlags;
   FService:=aSource.Service;
   FRegExp:=aSource.RegExp;
   FReplacement:=aSource.Replacement;
 end;

end;

procedure TNAPTRRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var
  aResult:TQueryResult;
begin
  inherited;
  Self.fOrder := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos],CompleteMessage[APos+1]));
  Inc(Apos, 2);

  Self.fPreference := GStack.NetworkToHost(TwoByteToWord(CompleteMessage[APos],CompleteMessage[APos+1]));
  Inc(Apos, 2);

  aResult:=(Collection as TQueryResult);
  Self.FFlags := aResult.NextDNSLabel(CompleteMessage, APos);
  Self.FService := aResult.NextDNSLabel(CompleteMessage, APos);
  Self.FRegExp := aResult.NextDNSLabel(CompleteMessage, APos);
  Self.FReplacement := aResult.DNSStrToDomain(CompleteMessage, APos);
end;

end.
