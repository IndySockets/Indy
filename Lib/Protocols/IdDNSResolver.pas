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


  $Log$


  4/19/2005 BTaylor

  Added support for SVR and NAPTR records. (Used for SIP/VOIP) (parts by Frank Shearar)

  Added TResultRecord.Section, .FilterBySection , .FilterByClass
  DNS lookups can now be generated exactly the same as NsLookup.

  Improved .Assign support on many objects. QueryResult object+items can now be properly cloned.

  TIdDNSResolver.FDNSHeader was a public field, now it's a public readonly property, TIdDNSResolver.DNSHeader

  fixed TMXRecord.Parse bug, .Preference will now contain correct value.

  fixed TTextRecord.Parse issue. DomainKeys (yahoo's anti-spam method) can now be used.

  Minor cleanups/spelling errors fixed.


    Rev 1.26    3/21/2005 10:36:20 PM  VVassiliev
  NextDNSLabel fix
  TTextRecord.Parse fix
  ClearInternalQuery before resolving


    Rev 1.25    2/9/05 2:10:34 AM  RLebeau
  Removed compiler hint


   Rev 1.24    2/8/05 6:17:14 PM  RLebeau
  Updated CreateQuery() to use Fetch() and AppendString() instead of Pos(),
  ToBytes(), and AppendBytes()


    Rev 1.23    10/26/2004 9:06:30 PM  JPMugaas
  Updated references.


    Rev 1.22    2004.10.25 10:18:38 PM  czhower
  Removed unused var.


    Rev 1.21    25/10/2004 15:55:28  ANeillans
  Bug fix:
  http://apps.atozedsoftware.com/cgi-bin/BBGIndy/BugBeGoneISAPI.dll/?item=122

  Checked in for Dennies Chang


    Rev 1.20    2004/7/19 ¤U¤È 09:40:52  DChang
  1. fix the TIdResolver.ParseAnswers, add 2 parameters for the function to
  check if QueryResult should be clear or not, TIdResolver.FillResult  is
  modified at the same time. 
 
  Fix AXFR procedure, fully support BIND 8 AXFR procedures.
 
  2. Replace the original type indicator in TQueryResult.Add. 
  It can understand AAAA type correctly.
 
  3. Add qtIXFR type for TIdDNSResover, add 2 parameters for
   TIdDNSResolver.Resolver, add one parameter for TIdDNSResolver.CreateHeader.
 
  4. Support query type CHAOS, but only for checking version.bind. (Check DNS
  server version.)


    Rev 1.19    7/12/2004 9:42:26 PM  DSiders
  Removed TODO for Address property.


    Rev 1.18    7/12/2004 9:24:04 PM  DSiders
  Added TODOs for property name inconsistencies.


    Rev 1.17    7/8/04 11:48:28 PM  RLebeau
  Tweaked TQueryResult.NextDNSLabel()


    Rev 1.16    2004.05.20 1:39:30 PM  czhower
  Last of the IdStream updates


    Rev 1.15    2004.04.08 3:57:28 PM  czhower
  Removal of bytes from buffer.


    Rev 1.14    2004.03.01 9:37:04 PM  czhower
  Fixed name conflicts for .net


    Rev 1.13    2/11/2004 5:47:26 AM  JPMugaas
  Can now assign a port for the DNS host as well as IPVersion.

  In addition, you can now use socks with TCP zone transfers.

 
    Rev 1.12    2/11/2004 5:21:16 AM  JPMugaas
  Vladimir Vassiliev changes for removal of byte flipping.  Network conversion
  order conversion functions are used instead.
  IPv6 addresses are returned in the standard form.
  In WKS records, Address was changed to IPAddress to be consistant with other
  record types.  Address can also imply a hostname.


    Rev 1.11    2/9/2004 11:27:36 AM  JPMugaas
  Some functions weren't working as expected.  Renamed them to describe them
  better.


    Rev 1.10    2004.02.03 5:45:58 PM  czhower
  Name changes


    Rev 1.9    11/13/2003 5:46:54 PM  VVassiliev
  DotNet
  AAAA record fix
  Add PTR for IPV6


    Rev 1.8    10/25/2003 06:51:54 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.


    Rev 1.7    10/19/2003 11:57:32 AM  DSiders
  Added localization comments.


    Rev 1.6    2003.10.12 3:50:38 PM  czhower
  Compile todos


    Rev 1.5    2003/4/30 ¤U¤È 12:39:54  DChang
  fix the TIdResolver.ParseAnswers, add 2 parameters for the function
  to check if QueryResult should be clear or not, TIdResolver.FillResult
  is modified at the same time.
  fix AXFR procedure, fully support BIND 8 AXFR procedures.


    Rev 1.4    4/28/2003 02:30:50 PM  JPMugaas
  reverted back to the old one as the new one checked will not compile, has
  problametic dependancies on Contrs and Dialogs (both not permitted).


    Rev 1.2    4/28/2003 07:00:10 AM  JPMugaas
  Should now compile.


    Rev 1.0    11/14/2002 02:18:34 PM  JPMugaas
    Rev 1.3    04/26/2003 02:30:10 PM  DenniesChang


  IdDNSResolver.

  Started: sometime.
  Finished: 2003/04/26

  IdDNSResolver has integrate UDP and TCP tunnel to resolve then types defined in RFC 1035,
  and AAAA, which is defined in RFC 1884, 1886.

  AXFR command, which is defined in RFC 1995, is also implemented in 2003/04/26

  The resolver also does not support Chaos RR. Only IN RR are supported as of this time.
  Part of code from Ray Malone


// Dennies Chang : Combine TIdDNSSyncResolver and TIdDNSCommResolver as TIdDNSResolver.
// 2003/04/26.
// Dennies Chang : Rename TIdDNSResolver as TIdDNSCommonResolver. 2003/04/23
// Dennies Chang : Add TIdDNSSyncClient to implement AXFR command. 2003/04/15
// Dennies Chang : Add atAAAA and TAAAARecord (2002 Oct.)
// Dennies Chang : Add TDNSHeader for IDHeader to maintain DNS Header, but not complete yet.
// SG 28/1/02: Changed the DNSStrToDomain function according to original Author of the old comp: Ray Malone
SG 10/07/01 Added support for qrStar query
VV 12/09/01 Added construction of reverse query (PTR)
DS 12/31/01 Corrected ReponsiblePerson spelling
VV 01/02/03 TQueryResult.DNSStrToDomain fix

 TODO : Add structure of IDHEADER IN FIGURE }

unit IdDNSResolver;

interface

{$i IdCompilerDefines.inc}

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
  IdUDPClient;

(*$HPPEMIT '#if defined(_VCL_ALIAS_RECORDS)' *)
(*$HPPEMIT '#if !defined(UNICODE)' *)
(*$HPPEMIT '#pragma alias "@Iddnsresolver@TIdDNSResolver@SetPortA$qqrxus"="@Iddnsresolver@TIdDNSResolver@SetPort$qqrxus"' *)
(*$HPPEMIT '#else' *)
(*$HPPEMIT '#pragma alias "@Iddnsresolver@TIdDNSResolver@SetPortW$qqrxus"="@Iddnsresolver@TIdDNSResolver@SetPort$qqrxus"' *)
(*$HPPEMIT '#endif' *)
(*$HPPEMIT '#endif' *)

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
  
  // Lookup table for query record values.
  QueryRecordCount = 30;
  QueryRecordValues: array [0..QueryRecordCount] of UInt16 = (
                     TypeCode_A, TypeCode_NS, TypeCode_MD, TypeCode_MF,
                     TypeCode_CName, TypeCode_SOA, TypeCode_MB, TypeCode_MG,
                     TypeCode_MR, TypeCode_NULL, TypeCode_WKS, TypeCode_PTR,
                     TypeCode_HINFO, TypeCode_MINFO, TypeCode_MX, TypeCode_TXT,
                     //TypeCode_RP, TypeCode_AFSDB, TypeCode_X25, TypeCode_ISDN,
                     TypeCode_RT, TypeCode_NSAP, TypeCode_NSAP_PTR, TypeCode_SIG,
                     //TypeCode_KEY, TypeCode_PX, TypeCode_QPOS,
                     TypeCode_AAAA,
                     //TypeCode_LOC, TypeCode_NXT, TypeCode_R31, TypeCode_R32,
                     TypeCode_Service,
                     //TypeCode_R34,
                     TypeCode_NAPTR,
                     //TypeCode_KX,
                     TypeCode_CERT, TypeCode_V6Addr, TypeCode_DNAME, TypeCode_R40,
                     TypeCode_OPTIONAL, TypeCode_IXFR, TypeCode_AXFR, TypeCode_STAR);
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

  TResultSection = (rsAnswer, rsNameServer, rsAdditional);
  TResultSections = set of TResultSection;

  TResultRecord = class(TCollectionItem) // Rename to REsourceRecord
  protected
    FRecType: TQueryRecordTypes;
    FRecClass: UInt16;
    FName: string;
    FTTL: UInt32;
    FRDataLength: Integer;
    FRData: TIdBytes;
    FSection: TResultSection;
    FTypeCode: UInt16;
  public
    procedure Assign(Source: TPersistent); override;
    // Parse the data (descendants only)
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); virtual;
    { TODO : This needs to change (to what? why?) }
    {RLebeau: because it only supports a subset of available DNS types!
    Adding TypeCode further below so unknown types can still be recognized.}
    property RecType: TQueryRecordTypes read FRecType;
    property RecClass: UInt16 read FRecClass;
    property Name: string read FName;
    property TTL: UInt32 read FTTL;
    property RDataLength: Integer read FRDataLength;
    property RData: TIdBytes read FRData;
    property Section: TResultSection read FSection;
    property TypeCode: UInt16 read FTypeCode;
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
    FProtocol: UInt16;
    //
    function GetABit(AIndex: Integer): UInt8;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;
    //
    property IPAddress: String read FIPAddress;
    property Protocol: UInt16 read FProtocol;
    property BitMap[index: integer]: UInt8 read GetABit;
    property ByteCount: integer read FByteCount;
  end;

  TMXRecord = class(TResultRecord)
  protected
    FExchangeServer: string;
    FPreference: UInt16;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;

    property ExchangeServer: string read FExchangeServer;
    property Preference: UInt16 read FPreference;
  end;

  TTextRecord = class(TResultRecord)
  protected
    FText: TStrings;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    Property Text: TStrings read FText;
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
    FSerial: UInt32;
    FMinimumTTL: UInt32;
    FRefresh: UInt32;
    FRetry: UInt32;
    FMNAME: string;
    FRNAME: string;
    FExpire: UInt32;
  public
    procedure Parse(CompleteMessage: TIdBytes; APos: Integer); override;
    procedure Assign(Source: TPersistent); override;

    property Primary: string read FMNAME;
    property ResponsiblePerson: string read FRNAME;
    property Serial: UInt32 read FSerial;
    property Refresh: UInt32 read FRefresh;
    property Retry: UInt32 read FRetry;
    property Expire: UInt32 read FExpire;

    property MinimumTTL: UInt32 read FMinimumTTL;
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

  TDNAMERecord = class(TNAMERecord)
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
    FQueryClass: UInt16;
    FQueryType: UInt16;
    FQueryPointerList: TStringList;
    procedure SetItem(Index: Integer; Value: TResultRecord);
    function GetItem(Index: Integer): TResultRecord;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Add(Answer: TIdBytes; var APos: Integer): TResultRecord;
    procedure Clear; reintroduce;
    procedure FilterBySection(const AKeep: TResultSections=[rsAnswer]);
    procedure FilterByClass(const AKeep: TResultRecordClass);

    Property QueryClass: UInt16 read FQueryClass;
    Property QueryType: UInt16 read FQueryType;
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
    procedure SetPort(const AValue: TIdPort); virtual;
  public
    property DNSHeader:TDNSHeader read FDNSHeader;
    procedure ClearInternalQuery;
    destructor Destroy; override;
    procedure ParseAnswers(DNSHeader: TDNSHeader; Answer: TIdBytes; ResetResult: Boolean = True);
    procedure CreateQuery(ADomain: string; SOARR : TIdRR_SOA; QueryClass:integer = Class_IN);
    procedure FillResult(AResult: TIdBytes; checkID : boolean = true;
              ResetResult : boolean = true);
    procedure FillResultWithOutCheckId(AResult: TIdBytes); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use FillResult() with checkID=False'{$ENDIF};{$ENDIF}
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
    property Port : TIdPort read FPort write SetPort default IdPORT_DOMAIN;
    property IPVersion: TIdIPVersion read FIPVersion write SetIPVersion default ID_DEFAULT_IP_VERSION;
  end;

function DNSStrToDomain(const DNSStr: TIdBytes; var VPos: Integer): string;
function NextDNSLabel(const DNSStr: TIdBytes; var VPos: Integer): string;

implementation

uses
  IdBaseComponent,
  IdResourceStringsProtocols,
  IdStack, SysUtils,
  IdException;

type
  EIdNotEnoughData = class(EIdException);

function ParseUInt8(const Buffer: TIdBytes; var VPos: Integer): UInt8;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if VPos >= Length(Buffer) then begin
    raise EIdNotEnoughData.Create('');
  end;
  Result := Buffer[VPos];
  Inc(VPos);
end;

function ParseUInt16(const Buffer: TIdBytes; var VPos: Integer; const AConvert: Boolean = True): UInt16; overload;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if (VPos+1) >= Length(Buffer) then begin
    raise EIdNotEnoughData.Create('');
  end;
  // TODO can/should we use BytesToUInt16() instead of TwoByteToUInt16()?
  Result := TwoByteToUInt16(Buffer[VPos], Buffer[VPos + 1]);
  Inc(VPos, 2);
  if AConvert then begin
    Result := GStack.NetworkToHost(Result);
  end;
end;

function ParseUInt16(const Byte1, Byte2: Byte; const AConvert: Boolean = True): UInt16; overload;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TwoByteToUInt16(Byte1, Byte2);
  if AConvert then begin
    Result := GStack.NetworkToHost(Result);
  end;
end;

function ParseUInt32(const Buffer: TIdBytes; var VPos: Integer): UInt32;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if (VPos+3) >= Length(Buffer) then begin
    raise EIdNotEnoughData.Create('');
  end;
  // TODO can/should we use BytesToUInt32() instead of OrdFourByteToUInt32()?
  Result := GStack.NetworkToHost(OrdFourByteToUInt32(Buffer[VPos], Buffer[VPos + 1], Buffer[VPos + 2], Buffer[VPos + 3]));
  Inc(VPos, 4);
end;

// SG 28/1/02: Changed that function according to original Author of the old comp: Ray Malone
function DNSStrToDomain(const DNSStr: TIdBytes; var VPos: Integer): string;
var
  LabelStr : String;
  Len : Integer;
  SavedIdx : Integer;
  B : Byte;
  PackSize: Integer;
begin
  Result := ''; {Do not Localize}
  PackSize := Length(DNSStr);
  SavedIdx := -1;

  while VPos < PackSize do // name field ends with nul byte
  begin
    Len := DNSStr[VPos];
    Inc(VPos);

    // RLebeau 5/4/2009: sometimes the first entry of a domain's record is
    // not defined, so account for that here at the top of the loop instead
    // of at the bottom, otherwise a Range Check error can occur when
    // trying to access the non-existant data...
    if Len = 0 then begin
      Break;
    end;

    while (Len and $C0) = $C0 do  // {!!0.01} added loop for pointer
    begin                         // that points to a pointer. Removed  >63 hack. Am I really that stupid?
      if SavedIdx < 0 then begin
        SavedIdx := Succ(VPos);  // it is important to return to original index of next element when we go down more than 1 level.
      end;
      if VPos >= Length(DNSStr) then begin
        raise EIdNotEnoughData.Create('');
      end;
      B := Len and $3F;                       // strip first two bits ($C) from first byte of offset pos
      VPos := ParseUInt16(B, DNSStr[VPos]);
      if VPos >= Length(DNSStr) then begin
        raise EIdNotEnoughData.Create('');
      end;
      Len := DNSStr[VPos]; // if len is another $Cx we will (while) loop again
      Inc(VPos);
    end;

    if VPos >= PackSize then begin
      raise EIdNotEnoughData.Create(''); // loop screwed up. This very very unlikely now could be removed.
    end;

    LabelStr := BytesToString(DNSStr, VPos, Len);
    Inc(VPos, Len);

    if VPos >= PackSize then begin // len byte was corrupted puting us past end of packet
      raise EIdNotEnoughData.Create('');
    end;

    Result := Result + LabelStr + '.';  // concat and add period.  {Do not Localize}
  end;

  if TextEndsWith(Result, '.') then begin // remove final period    {Do not Localize}
    SetLength(Result, Length(Result) - 1);
  end;

  if SavedIdx >= 0 then begin
    VPos := SavedIdx; // restore original Idx
  end;
end;

function NextDNSLabel(const DNSStr: TIdBytes; var VPos: Integer): string;
var
  LabelLength: Byte;
begin
  if VPos < Length(DNSStr) then begin
    LabelLength := DNSStr[VPos];
    Inc(VPos);
    //VV Shouldn't be pointers in Text messages
    if LabelLength > 0 then begin
      Result := BytesToString(DNSStr, VPos, LabelLength);
      Inc(VPos, LabelLength);
      Exit;
    end;
  end;
  Result := ''; {Do not Localize}
end;

{ TARecord }

procedure TRDATARecord.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TRDATARecord then begin
    FIPAddress := TRDATARecord(Source).IPAddress;
  end;
end;

procedure TRDATARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  FIPAddress := MakeUInt32IntoIPv4Address(ParseUInt32(CompleteMessage, APos));
end;

{ TMXRecord }

procedure TMXRecord.Assign(Source: TPersistent);
var
  LSource: TMXRecord;
begin
  inherited Assign(Source);
  if Source is TMXRecord then
  begin
    LSource := TMXRecord(Source);
    FExchangeServer := LSource.ExchangeServer;
    FPreference := LSource.Preference;
  end;
end;

{ TCNAMERecord }

procedure TNAMERecord.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TNAMERecord then begin
    FHostName := TNAMERecord(Source).HostName;
  end;
end;

{ TQueryResult }

function TQueryResult.Add(Answer: TIdBytes; var APos: Integer): TResultRecord;
var
  RRName: String;
  RR_type, RR_Class: UInt16;
  RR_TTL: UInt32;
  RD_Length: UInt16;
  RData: TIdBytes;
begin
  // extract the RR data
  RRName := DNSStrToDomain(Answer, APos);
  RR_Type := ParseUInt16(Answer, APos);
  RR_Class := ParseUInt16(Answer, APos);
  RR_TTL := ParseUInt32(Answer, APos);
  RD_Length := ParseUInt16(Answer, APos);
  RData := Copy(Answer, APos, RD_Length);
  // remove what we have read from the buffer
  // Read the record type
  // Dennies Chang had modified this part to indicate type by RR_type
  // because RR_type is integer, we can use TypeCode which is defined
  // in IdDNSCommon to select all record type.
  case RR_Type of
    TypeCode_A ://qtA:
      begin
        Result := TARecord.Create(Self);
      end;
    TypeCode_NS : //qtNS:
      begin
        Result := TNSRecord.Create(Self);
      end;
    TypeCode_MX ://qtMX:
      begin
        Result := TMXRecord.Create(Self);
      end;
    TypeCode_CName : // qtName:
      begin
        Result := TNAMERecord.Create(Self);
      end;
    TypeCode_SOA : //qtSOA:
      begin
        Result := TSOARecord.Create(Self);
      end;
    TypeCode_HINFO : //qtHINFO:
      begin
        Result := THINFORecord.Create(Self);
      end;
    TypeCode_TXT ://qtTXT:
      begin
        Result := TTextRecord.Create(Self);
      end;
    TypeCode_WKS ://qtWKS:
      begin
        Result := TWKSRecord.Create(Self);
      end;
    TypeCode_PTR :// qtPTR:
      begin
        Result := TPTRRecord.Create(Self);
      end;
    TypeCode_MINFO ://qtMINFO:
      begin
        Result := TMINFORecord.Create(Self);
      end;
    TypeCode_AAAA : //qtAAAA:
      begin
        Result := TAAAARecord.Create(Self);
      end;
    TypeCode_Service : //qtService
      begin
        Result := TSRVRecord.Create(Self);
      end;
    TypeCode_NAPTR : //qtNAPTR
      begin
        Result := TNAPTRRecord.Create(Self);
      end;
    TypeCode_DNAME : //qtDNAME
      begin
        Result := TDNAMERecord.Create(Self);
      end;
    else begin
      // Unsupported query type, return generic record
      Result := TResultRecord.Create(Self);
    end;
  end; // case

  try
    // Set the "general purpose" options

    //if RR_Type <= High(QueryRecordTypes) then
    // modified in 2004 7/15.
    case RR_Type of
      TypeCode_A:      Result.FRecType := qtA;
      TypeCode_NS:     Result.FRecType := qtNS;
      TypeCode_MD:     Result.FRecType := qtMD;
      TypeCode_MF:     Result.FRecType := qtMF;
      TypeCode_CName:  Result.FRecType := qtName;
      TypeCode_SOA:    Result.FRecType := qtSOA;
      TypeCode_MB:     Result.FRecType := qtMB;
      TypeCode_MG:     Result.FRecType := qtMG;
      TypeCode_MR:     Result.FRecType := qtMR;
      TypeCode_NULL:   Result.FRecType := qtNull;
      TypeCode_WKS:    Result.FRecType := qtWKS;
      TypeCode_PTR:    Result.FRecType := qtPTR;
      TypeCode_HINFO:  Result.FRecType := qtHINFO;
      TypeCode_MINFO:  Result.FRecType := qtMINFO;
      TypeCode_MX:     Result.FRecType := qtMX;
      TypeCode_TXT:    Result.FRecType := qtTXT;
      //TypeCode_RP:   Result.FRecType := qtRP;
      //TypeCode_AFSDB: Result.FRecType := qtAFSDB;
      //TypeCode_X25:  Result.FRecType := qtX25;
      //TypeCode_ISDN: Result.FRecType := qtISDN;
      TypeCode_RT:     Result.FRecType := qtRT;
      TypeCode_NSAP:   Result.FRecType := qtNSAP;
      TypeCode_NSAP_PTR: Result.FRecType := qtNSAP_PTR;
      TypeCode_SIG:    Result.FRecType := qtSIG;
      //TypeCode_KEY:  Result.FRecType := qtKEY;
      //TypeCode:PX:   Result.FREcType := qtPX;
      //TypeCode_QPOS: Result.FRecType := qtQPOS;
      TypeCode_AAAA:   Result.FRecType := qtAAAA;
      //TypeCode_LOC:  Result.FRecType := qtLOC;
      //TypeCode_NXT:  Result.FRecType := qtNXT;
      //TypeCode_R31:  Result.FRecType := qtR31;
      //TypeCode_R32:  Result.FRecType := qtR32;
      TypeCode_Service:Result.FRecType := qtService;
      //TypeCode_R34:  Result.FRecType := qtR34;
      TypeCode_NAPTR:  Result.FRecType := qtNAPTR;
      //TypeCode_KX:   Result.FRecType := qtKX;
      TypeCode_CERT:   Result.FRecType := qtCERT;
      TypeCode_V6Addr: Result.FRecType := qtV6Addr;
      TypeCode_DNAME:  Result.FRecType := qtDName;
      TypeCode_R40:    Result.FRecType := qtR40;
      TypeCode_OPTIONAL: Result.FRecType := qtOptional;
      TypeCode_IXFR:   Result.FRecType := qtIXFR;
      TypeCode_AXFR:   Result.FRecType := qtAXFR;
      TypeCode_STAR:   Result.FRecType := qtSTAR;
    end;

    Result.FRecClass := RR_Class;
    Result.FName := RRName;
    Result.FTTL := RR_TTL;
    Result.FRData := Copy(RData, 0, Length(RData));
    Result.FRDataLength := RD_Length;
    Result.FTypeCode := RR_Type;

    // Parse the result
    // Since the DNS message can be compressed, we need to have the whole message to parse it, in case
    // we encounter a pointer
    Result.Parse(Answer, APos);
  except
    on EIdNotEnoughData do begin
      // let the caller handle truncated data as needed...
    end;
  end;

  // Set the new position
  Inc(APos, RD_Length);
end;

constructor TQueryResult.Create;
begin
  inherited Create(TResultRecord);
  FQueryPointerList := TStringList.Create;
end;

destructor TQueryResult.Destroy;
begin
  FreeAndNil(FQueryPointerList);
  inherited Destroy;
end;

function TQueryResult.GetItem(Index: Integer): TResultRecord;
begin
  Result := TResultRecord(inherited GetItem(Index));
end;

procedure TQueryResult.SetItem(Index: Integer; Value: TResultRecord);
begin
  inherited SetItem(Index, Value);
end;

{ TResultRecord }

procedure TResultRecord.Assign(Source: TPersistent);
var
  LSource: TResultRecord;
begin
  if Source is TResultRecord then
  begin
    LSource := TResultRecord(Source);
    FRecType := LSource.RecType;
    FRecClass := LSource.RecClass;
    FName := LSource.Name;
    FTTL := LSource.TTL;
    FRDataLength := LSource.RDataLength;
    FRData := Copy(LSource.RData, 0, Length(LSource.RData));
    FSection := LSource.Section;
    FTypeCode := LSource.TypeCode;
  end else begin
    inherited Assign(Source);
  end;
end;

procedure TResultRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
end;

{ TNAMERecord }

procedure TNAMERecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  FHostName := DNSStrToDomain(CompleteMessage, APos);
end;

{ TQueryResult }

procedure TQueryResult.Clear;
begin
  inherited Clear;
  FQueryPointerList.Clear;
end;

procedure TQueryResult.Assign(Source: TPersistent);
//TCollection.Assign doesn't create correct Item class.
var
  i: Integer;
  LRec: TResultRecord;
  LNew: TResultRecord;
begin
  if Source is TQueryResult then
  begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TQueryResult(Source).Count-1 do
      begin
        LRec := TQueryResult(Source).Items[i];
        LNew := TResultRecordClass(LRec.ClassType).Create(Self);
        try
          LNew.Assign(LRec);
        except
          FreeAndNil(LNew);
          raise;
        end;
      end;
    finally
      EndUpdate;
    end;
  end else begin
    inherited Assign(Source);
  end;
end;

{ TMXRecord }

procedure TMXRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  FPreference := ParseUInt16(CompleteMessage, APos);
  FExchangeServer := DNSStrToDomain(CompleteMessage, APos);
end;

{ TTextRecord }

procedure TTextRecord.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TTextRecord then begin
    FText.Assign(TTextRecord(Source).Text);
  end;
end;

constructor TTextRecord.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FText := TStringList.Create;
end;

destructor TTextRecord.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

//the support for long text values is required for DomainKeys,
//which has an encoded public key
procedure TTextRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var
  LEnd: Integer;
  Buffer: string;
begin
  FText.Clear;

  inherited Parse(CompleteMessage, APos);

  LEnd := APos + Length(RData);
  while APos < LEnd do
  begin
    Buffer := NextDNSLabel(CompleteMessage, APos);
    if Buffer <> '' then begin  {Do not Localize}
      FText.Add(Buffer);
    end;
  end;

  if APos > Length(CompleteMessage) then begin // len byte was corrupted puting us past end of packet
    raise EIdNotEnoughData.Create('');
  end;
end;

{ TSOARecord }

procedure TSOARecord.Assign(Source: TPersistent);
var
  LSource: TSOARecord;
begin
  inherited Assign(Source);
  if Source is TSOARecord then begin
    LSource := TSOARecord(Source);
    FSerial := LSource.Serial;
    FMinimumTTL := LSource.MinimumTTL;
    FRefresh := LSource.Refresh;
    FRetry := LSource.Retry;
    FMNAME := LSource.FMNAME;
    FRNAME := LSource.FRNAME;
    FExpire := LSource.Expire;
  end;
end;

procedure TSOARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  FMNAME := DNSStrToDomain(CompleteMessage, APos);
  FRNAME := DNSStrToDomain(CompleteMessage, APos);
  FSerial := ParseUInt32(CompleteMessage, APos);
  FRefresh := ParseUInt32(CompleteMessage, APos);
  FRetry := ParseUInt32(CompleteMessage, APos);
  FExpire := ParseUInt32(CompleteMessage, APos);
  FMinimumTTL := ParseUInt32(CompleteMessage, APos);
end;

{ TWKSRecord }

procedure TWKSRecord.Assign(Source: TPersistent);
var
  LSource: TWKSRecord;
begin
  inherited Assign(Source);
  if Source is TWKSRecord then begin
    LSource := TWKSRecord(Source);
    FIPAddress := LSource.IPAddress;
    FProtocol := LSource.Protocol;
    FByteCount := LSource.ByteCount;
    FData := Copy(LSource.FData, 0, Length(LSource.FData));
  end;
end;

function TWKSRecord.GetABit(AIndex: Integer): UInt8;
begin
  Result := FData[AIndex];
end;

procedure TWKSRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  APos := 0;
  FIPAddress := MakeUInt32IntoIPv4Address(ParseUInt32(RData, APos));
  FProtocol := UInt16(ParseUInt8(RData, APos));
  FData := Copy(RData, APos, MaxInt);
end;

{ TMINFORecord }

procedure TMINFORecord.Assign(Source: TPersistent);
var
  LSource: TMINFORecord;
begin
  inherited Assign(Source);
  if Source is TMINFORecord then
  begin
    LSource := TMINFORecord(Source);
    FResponsiblePerson := LSource.ResponsiblePersonMailbox;
    FErrorMailbox := LSource.ErrorMailbox;
  end;
end;

procedure TMINFORecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);
  FResponsiblePerson := DNSStrToDomain(CompleteMessage, APos);
  FErrorMailbox := DNSStrToDomain(CompleteMessage, APos);
end;

{ THINFORecord }

procedure THINFORecord.Assign(Source: TPersistent);
var
  LSource: THINFORecord;
begin
  inherited Assign(Source);
  if Source is THINFORecord then
  begin
    LSource := THINFORecord(Source);
    FCPU := LSource.CPU;
    FOS := LSource.OS;
  end;
end;

procedure THINFORecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);

  FCPU := NextDNSLabel(CompleteMessage, APos);
  FOS := NextDNSLabel(CompleteMessage, APos);

  if APos > Length(CompleteMessage) then begin // len byte was corrupted puting us past end of packet
    raise EIdNotEnoughData.Create('');
  end;
end;


{ TAAAARecord }

procedure TAAAARecord.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TAAAARecord then begin
    FAddress := TAAAARecord(Source).Address;
  end;
end;

procedure TAAAARecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var
  FIP6 : TIdIPv6Address;
  i : Integer;
begin
  inherited Parse(CompleteMessage, APos);
  if Length(RData) > 0 then begin
    if Length(RData) < 16 then begin
      raise EIdNotEnoughData.Create('');
    end;
    BytesToIPv6(RData, FIP6);
    for i := 0 to 7 do begin
      FIP6[i] := GStack.NetworkToHost(FIP6[i]);
    end;
    FAddress := IPv6AddressToStr(FIP6);
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
  begin
    SetLength(Result, 0);
    while Length(ADNS) > 0 do begin
      BufStr := Fetch(ADNS, '.');    {Do not Localize}
      LLen := Length(BufStr);
      AppendByte(Result, LLen);
      AppendString(Result, BufStr, LLen);
    end;
  end;

  function DoHostAddressV6(const ADNS: String): TIdBytes;
  var
    IPV6Str, IPV6Ptr: string;
    i: Integer;
  begin
    if not IsValidIPv6(ADNS) then begin
      raise EIdDnsResolverError.CreateFmt(RSQueryInvalidIpV6, [aDNS]);
    end;
    IPV6Str := ConvertToCanonical6IP(ADNS);
    IPV6Ptr := '';                               {Do not Localize}
    for i := Length(IPV6Str) downto 1 do begin
      if IPV6Str[i] <> ':' then begin           {Do not Localize}
        IPV6Ptr := IPV6Ptr + IPV6Str[i] + '.';  {Do not Localize}
      end;
    end;
    IPV6Ptr := IPV6Ptr + 'IP6.INT';  {Do not Localize}
    Result := DoDomainName(IPV6Ptr);
  end;

  function DoHostAddress(const ADNS: String): TIdBytes;
  var
    BufStr, First, Second, Third, Fourth: String;
    LLen: Byte;
  begin                         { DoHostAddress }
    if Pos(':', ADNS) > 0 then begin  {Do not Localize}
      Result := DoHostAddressV6(ADNS);
    end else begin
      SetLength(Result, 0);
      BufStr := ADNS;

      First := Fetch(BufStr, '.');
      Second := Fetch(BufStr, '.');
      Third := Fetch(BufStr, '.');
      Fourth := BufStr;

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
  end;

var
  ARecType: TQueryRecordTypes;
  iQ: Integer;
  AQuestion, AAuthority: TIdBytes;
  TempBytes: TIdBytes;
  w : UInt16;
begin
  SetLength(TempBytes, 2);
  SetLength(AAuthority, 0);
  FDNSHeader.ID := Random(65535);

  FDNSHeader.ClearByteCode;
  FDNSHeader.Qr := 0;
  FDNSHeader.OpCode := 0;
  FDNSHeader.ANCount := 0;
  FDNSHeader.NSCount := 0;
  FDNSHeader.ARCount := 0;
  //do not reverse the bytes because this is a bit set
  FDNSHeader.RD := UInt16(FAllowRecursiveQueries);

  // Iterate thru questions
  { TODO : Optimize for non-double loop }
  if (QueryType * [qtAXFR, qtIXFR]) <> [] then
  begin
    iQ := 1; // if exec AXFR, there can be only one Question.
    if qtIXFR in QueryType then begin
      // if exec IXFR, we must include a SOA record in Authority Section (RFC 1995)
      if not Assigned(SOARR) then begin
        raise EIdDnsResolverError.Create(GetErrorStr(7, 3));
      end;
      AAuthority := SOARR.BinQueryRecord('');
      FDNSHeader.AA := 1;
    end;
  end else
  begin
    iQ := 0;
    for ARecType := Low(TQueryRecordTypes) to High(TQueryRecordTypes) do begin
      if ARecType in QueryType then begin
        Inc(iQ);
      end;
    end;
    FDNSHeader.ARCount := 1;
  end;

  FDNSHeader.QDCount := iQ;
  if FDNSHeader.QDCount = 0 then begin
    ClearInternalQuery;
    Exit;
  end;

  InternalQuery := FDNSHeader.GenerateBinaryHeader;

  if qtAXFR in QueryType then begin
    if (IndyPos('IN-ADDR', UpperCase(ADomain)) > 0) or   {Do not Localize}
       (IndyPos('IP6.INT', UpperCase(ADomain)) > 0) then {do not localize}
    begin
      AppendBytes(AQuestion, DoHostAddress(ADomain));
    end else
    begin
      AppendBytes(AQuestion, DoDomainName(ADomain));
    end;
    AppendByte(AQuestion, 0);
    //we do this in a round about manner because HostToNetwork will not always
    //work the same
    w := 252;
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // Type = AXFR
    w := QueryClass;
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes);
  end
  else if qtIXFR in QueryType then begin
    if (IndyPos('IN-ADDR', UpperCase(ADomain)) > 0) or   {Do not Localize}
       (IndyPos('IP6.INT', UpperCase(ADomain)) > 0) then {do not localize}
    begin
      AppendBytes(AQuestion, DoHostAddress(ADomain));
    end else
    begin
      AppendBytes(AQuestion, DoDomainName(ADomain));
    end;
    AppendByte(AQuestion, 0);
    //we do this in a round about manner because HostToNetwork will not always
    //work the same
    w := 251;
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // Type = IXFR
    w := QueryClass;
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes);
  end else
  begin
    for ARecType := Low(TQueryRecordTypes) to High(TQueryRecordTypes) do begin
      if ARecType in QueryType then begin
        // Create the question
        if (ARecType = qtPTR) and
           (IndyPos('IN-ADDR', UpperCase(ADomain)) = 0) and {Do not Localize}
           (IndyPos('IP6.INT', UpperCase(ADomain)) = 0) then {do not localize}
        begin
          AppendBytes(AQuestion, DoHostAddress(ADomain));
        end else begin
          AppendBytes(AQuestion, DoDomainName(ADomain));
        end;
        AppendByte(AQuestion, 0);
        w := QueryRecordValues[Ord(ARecType)];
        w := GStack.HostToNetwork(w);
        UInt16ToTwoBytes(w, TempBytes, 0);
        AppendBytes(AQuestion, TempBytes);
        w := QueryClass;
        w := GStack.HostToNetwork(w);
        UInt16ToTwoBytes(w, TempBytes, 0);
        AppendBytes(AQuestion, TempBytes);
      end;
    end;
  end;
  AppendBytes(FInternalQuery, AQuestion);

  if FDNSHeader.ARCount = 1 then
  begin
    // Create the additional OPT record to advertise our UDP receive size
    SetLength(AQuestion, 0);

    AppendByte(AQuestion, 0); // domain name (root, 0-length)

    w := TypeCode_OPTIONAL;
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // record type (OPT)

    w := 1280{8192}; // TODO: make this configurable
    w := GStack.HostToNetwork(w);
    UInt16ToTwoBytes(w, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // record class (OPT UDP size)

    UInt16ToTwoBytes(0, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // record TTL (OPT extended RCODE and version)

    UInt16ToTwoBytes(0, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // record TTL (OPT flags)

    UInt16ToTwoBytes(0, TempBytes, 0);
    AppendBytes(AQuestion, TempBytes); // record data size

    AppendBytes(FInternalQuery, AQuestion);
  end;

  FQuestionLength := Length(FInternalQuery);
  FDNSHeader.ParseQuery(FInternalQuery);
end;

destructor TIdDNSResolver.Destroy;
begin
  FreeAndNil(FQueryResult);
  FreeAndNil(FDNSHeader);
  inherited Destroy;
end;

procedure TIdDNSResolver.FillResult(AResult: TIdBytes; CheckID: Boolean = True;
  ResetResult: Boolean = True);
var
  ReplyId: UInt16;
  NAnswers: UInt16;
begin
  { TODO : Check bytes received }
  // Check to see if the reply is the one waited for
  if Length(AResult) < 12 then begin
    raise EIdDnsResolverError.Create(GetErrorStr(5, 29));
  end;
{
  if Length(AResult) < Self.FQuestionLength then begin
    raise EIdDnsResolverError.Create(GetErrorStr(5, 30));
  end;
}

  if CheckID then begin
    ReplyId := ParseUInt16(AResult[0], AResult[1]);
    if ReplyId <> FDNSHeader.Id then begin
      raise EIdDnsResolverError.Create(GetErrorStr(4, FDNSHeader.id));
    end;
  end;
  FDNSHeader.ParseQuery(AResult);

  if FDNSHeader.RCode <> 0 then begin
    raise EIdDnsResolverError.Create(GetRCodeStr(FDNSHeader.RCode));
  end;

  NAnswers := FDNSHeader.ANCount + FDNSHeader.NSCount + FDNSHeader.ARCount;
  if NAnswers > 0 then begin
    // Move Pointer to Start of answers
    if Length(AResult) > 12 then begin
      ParseAnswers(FDNSHeader, AResult, ResetResult);
    end;
  end;
end;

{$I IdDeprecatedImplBugOff.inc}
procedure TIdDNSResolver.FillResultWithOutCheckId(AResult: TIdBytes);
{$I IdDeprecatedImplBugOn.inc}
var
  NAnswers: UInt16;
begin
  if FDNSHeader.ParseQuery(AResult) <> 0 then begin
    raise EIdDnsResolverError.Create(GetErrorStr(5, 29));
  end;

  {
  if FDNSHeader.RCode <> 0 then begin
    raise EIdDnsResolverError.Create(GetRCodeStr(FDNSHeader.RCode));
  end;
  }

  NAnswers := FDNSHeader.ANCount + FDNSHeader.NSCount + FDNSHeader.ARCount;
  if NAnswers > 0 then begin
    // Move Pointer to Start of answers
    if Length(AResult) > 12 then begin
      ParseAnswers(FDNSHeader, AResult);
    end;
  end;
end;

procedure TQueryResult.FilterBySection(const AKeep: TResultSections);
var
  i: Integer;
begin
  for i := Count-1 downto 0 do
  begin
    if not (Items[i].Section in AKeep) then begin
      Delete(i);
    end;
  end;
end;

procedure TQueryResult.FilterByClass(const AKeep: TResultRecordClass);
var
  i: Integer;
begin
  for i := Count-1 downto 0 do
  begin
    if not (Items[i] is AKeep) then begin
      Delete(i);
    end;
  end;
end;

procedure TIdDNSResolver.InitComponent;
begin
  inherited InitComponent;
  FIPVersion := ID_DEFAULT_IP_VERSION;
  Port := IdPORT_DOMAIN;
  FQueryResult := TQueryResult.Create;
  FDNSHeader := TDNSHeader.Create;
  FAllowRecursiveQueries := true;
  Self.WaitingTime := 5000;
end;

procedure TIdDNSResolver.ParseAnswers(DNSHeader: TDNSHeader; Answer: TIdBytes;
  ResetResult: Boolean = True);
var
  i: integer;
  APos: Integer;
  QDomain: string;
  QType, QClass: UInt16;
begin
  if ResetResult then begin
    QueryResult.Clear;
  end;

  try
    APos := 12; //13; // Header is 12 byte long we need next byte
    // if QDCount = 1, we need to process Question first.

    i := 1;
    while (i <= DNSHeader.QDCount) and (APos < Length(Answer)) do begin
      QDomain := DNSStrToDomain(Answer, APos);
      QType := ParseUInt16(Answer, APos);
      QClass := ParseUInt16(Answer, APos);
      if i = 0 then
      begin
        // first, get the question
        // extract the domain name
        QueryResult.FDomainName := QDomain;
        // get the query type
        QueryResult.FQueryType := QType;
        // get the Query Class
        QueryResult.FQueryClass := QClass;
      end;
      Inc(i);
    end;

    i := 1;
    while (i <= DNSHeader.ANCount) and (APos < Length(Answer)) do begin
      QueryResult.Add(Answer, APos).FSection := rsAnswer;
      Inc(i);
    end;

    i := 1;
    while (i <= DNSHeader.NSCount) and (APos < Length(Answer)) do begin
      QueryResult.Add(Answer, APos).FSection := rsNameServer;
      Inc(i);
    end;

    i := 1;
    while (i <= DNSHeader.ARCount) and (APos < Length(Answer)) do begin
      QueryResult.Add(Answer, APos).FSection := rsAdditional;
      Inc(i);
    end;
  except
    on EIdNotEnoughData do begin
      if DNSHeader.TC = 0 then begin
        IndyRaiseOuterException(EIdDnsResolverError.Create(GetErrorStr(2, 3)));
      end;
    end;
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
  if ADomain <> '' then begin
    ClearInternalQuery;
  end;

  // Resolve queries the DNS for the records contained in the
  if FQuestionLength = 0 then begin
    if qtIXFR in QueryType then begin
      CreateQuery(ADomain, SOARR, QClass);
    end else begin
      CreateQuery(ADomain, nil, QClass)
    end;
  end;

  if FQuestionLength = 0 then begin
    raise EIdDnsResolverError.CreateFmt(RSQueryInvalidQueryCount, [0]);
  end;

  if qtAXFR in QueryType then begin
    // AXFR
    TCP_Tunnel := TIdTCPClient.Create;
    try
      TCP_Tunnel.Host := Host;
      TCP_Tunnel.Port := Port;
      TCP_Tunnel.IPVersion := IPVersion;
      TCP_Tunnel.IOHandler := IOHandler;

      try
        TCP_Tunnel.Connect;
        try
          TCP_Tunnel.IOHandler.Write(Int16(FQuestionLength));
          TCP_Tunnel.IOHandler.Write(InternalQuery);

          QueryResult.Clear;

          LRet := TCP_Tunnel.IOHandler.ReadInt16;
          TCP_Tunnel.IOHandler.ReadBytes(LResult, LRet, False);
          PlainTextResult := LResult;

          if LRet > 4 then begin
            FillResult(LResult, False, False);
            if QueryResult.Count = 0 then begin
              raise EIdDnsResolverError.Create(GetErrorStr(2,3));
            end;
          end else begin
            raise EIdDnsResolverError.Create(RSDNSTimeout);
          end;
        finally
          TCP_Tunnel.Disconnect;
        end;
      except
        on EIdConnectTimeout do begin
          SetLength(FPlainTextResult, 0);
          IndyRaiseOuterException(EIdDNSResolverError.Create(RSDNSTimeout));
        end;
        on EIdConnectException do begin
          SetLength(FPlainTextResult, 0);
          IndyRaiseOuterException(EIdDNSResolverError.Create(RSTunnelConnectToMasterFailed));
        end;
      end;
    finally
      FreeAndNil(TCP_Tunnel);
    end;
  end
  else if qtIXFR in QueryType then begin
    // IXFR
    TCP_Tunnel := TIdTCPClient.Create;
    try
      TCP_Tunnel.Host := Host;
      TCP_Tunnel.Port := Port;
      TCP_Tunnel.IPVersion := IPVersion;
      TCP_Tunnel.IOHandler := IOHandler;

      { Thanks RLebeau, you fix a lot of codes which I do not spend time to do - Dennies Chang. }

      try
        TCP_Tunnel.Connect;
        try
          TCP_Tunnel.IOHandler.Write(Int16(FQuestionLength));
          TCP_Tunnel.IOHandler.Write(InternalQuery);

          QueryResult.Clear;

          LRet := TCP_Tunnel.IOHandler.ReadInt16;
          SetLength(LResult, LRet);
          TCP_Tunnel.IOHandler.ReadBytes(LResult, LRet);
          PlainTextResult := LResult;

          if LRet > 4 then begin
            FillResult(LResult, False, False);
            if QueryResult.Count = 0 then begin
              raise EIdDnsResolverError.Create(GetErrorStr(2,3));
            end;
          end else begin
            raise EIdDnsResolverError.Create(RSDNSTimeout);
          end;
        finally
          TCP_Tunnel.Disconnect;
        end;
      except
        on EIdConnectTimeout do begin
          SetLength(FPlainTextResult, 0);
          IndyRaiseOuterException(EIdDNSResolverError.Create(RSDNSTimeout));
        end;
        on EIdConnectException do begin
          SetLength(FPlainTextResult, 0);
          IndyRaiseOuterException(EIdDNSResolverError.Create(RSTunnelConnectToMasterFailed));
        end;
      end;
    finally
      FreeAndNil(TCP_Tunnel);
    end;
  end
  else begin
    UDP_Tunnel := TIdUDPClient.Create;
    try
      UDP_Tunnel.Host := Host;
      UDP_Tunnel.Port := Port;
      UDP_Tunnel.IPVersion := IPVersion;

      UDP_Tunnel.SendBuffer(InternalQuery);

      SetLength(LResult, 8192); // TODO: make this configurable
      BytesReceived := UDP_Tunnel.ReceiveBuffer(LResult, WaitingTime);
    finally
      FreeAndNil(UDP_Tunnel);
    end;

    if BytesReceived > 0 then begin
      SetLength(LResult, BytesReceived);
    end else begin
      SetLength(LResult, 0);
    end;

    PlainTextResult := LResult;

    if BytesReceived > 4 then begin
      // TODO: if the response has the TrunCation flag set, retry the query
      // in TCP to handle larger responses...
      FillResult(LResult);
      if QueryResult.Count = 0 then begin
        raise EIdDnsResolverError.Create(GetErrorStr(2,3));
      end;
    end else begin
      raise EIdDnsResolverError.Create(RSDNSTimeout);
    end;
  end;
end;

procedure TIdDNSResolver.SetInternalQuery(const Value: TIdBytes);
begin
  FQuestionLength := Length(Value);
  FInternalQuery := Copy(Value, 0, FQuestionLength);
  Self.FDNSHeader.ParseQuery(Value);
end;

procedure TIdDNSResolver.SetIPVersion(const AValue: TIdIPVersion);
begin
   FIPVersion := AValue;
end;

procedure TIdDNSResolver.SetPlainTextResult(const Value: TIdBytes);
begin
  FPlainTextResult := Copy(Value, 0, Length(Value));
end;

procedure TIdDNSResolver.SetPort(const AValue: TIdPort);
begin
  FPort := AValue;
end;

procedure TSRVRecord.Assign(Source: TPersistent);
var
  LSource: TSRVRecord;
begin
  inherited Assign(Source);
  if Source is TSRVRecord then
  begin
    LSource := TSRVRecord(Source);
    FService := LSource.Service;
    FProtocol := LSource.Protocol;
    FPriority := LSource.Priority;
    FWeight := LSource.Weight;
    FPort := LSource.Port;
    FTarget := LSource.Target;
  end;
end;

function TSRVRecord.CleanIdent(const aStr: string): string;
begin
  Result := Copy(aStr, 2, MaxInt);
end;

function TSRVRecord.IsValidIdent(const AStr: string): Boolean;
begin
  Result := (Length(AStr) > 1) and TextStartsWith(AStr, '_'); {Do not Localize}
end;

procedure TSRVRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
var
  LName, LService, LProtocol: string;
begin
  inherited Parse(CompleteMessage, APos);

  FOriginalName := FName;

  //this is to split: _sip._udp.example.com
  LName := FName;
  LService := Fetch(LName, '.', True, False);
  LProtocol := Fetch(LName,'.', True, False);
  if IsValidIdent(LService) and IsValidIdent(LProtocol) and (LName <> '') then
  begin
    FService := CleanIdent(LService);
    FProtocol := CleanIdent(LProtocol);
    FName := LName;
  end;

  FPriority := ParseUInt16(CompleteMessage, APos);
  FWeight := ParseUInt16(CompleteMessage, APos);
  FPort := ParseUInt16(CompleteMessage, APos);
  FTarget := DNSStrToDomain(CompleteMessage, APos);
end;

procedure TNAPTRRecord.Assign(Source: TPersistent);
var
  LSource: TNAPTRRecord;
begin
  inherited Assign(Source);
  if Source is TNAPTRRecord then
  begin
    LSource := TNAPTRRecord(Source);
    FOrder := LSource.Order;
    FPreference := LSource.Preference;
    FFlags := LSource.FFlags;
    FService := LSource.Service;
    FRegExp := LSource.RegExp;
    FReplacement := LSource.Replacement;
  end;
end;

procedure TNAPTRRecord.Parse(CompleteMessage: TIdBytes; APos: Integer);
begin
  inherited Parse(CompleteMessage, APos);

  FOrder := ParseUInt16(CompleteMessage, APos);
  FPreference := ParseUInt16(CompleteMessage, APos);

  FFlags := NextDNSLabel(CompleteMessage, APos);
  FService := NextDNSLabel(CompleteMessage, APos);
  FRegExp := NextDNSLabel(CompleteMessage, APos);

  if APos > Length(CompleteMessage) then begin // len byte was corrupted puting us past end of packet
    raise EIdNotEnoughData.Create('');
  end;

  FReplacement := DNSStrToDomain(CompleteMessage, APos);
end;

end.
