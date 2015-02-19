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

    Rev 1.29    1/31/2005 9:02:44 PM  JPMugaas
  Should compile again.  OOPS!!


    Rev 1.28    1/28/2005 8:06:08 PM  JPMugaas
  Bug with MINFO, it was not returning the responsible E-Mail address.


    Rev 1.27    1/28/2005 7:12:34 PM  JPMugaas
  Minor formatting adjustments.


    Rev 1.26    1/28/2005 3:46:18 PM  JPMugaas
  Should compile.


    Rev 1.25    2005/1/28 下午 12:40:08  DChang
  Add a new method for TIdTextModeResourceRecord to clean the created FAnswer,
  then while the record updated, new data can be used in the FAnswer.


    Rev 1.23    2005/1/25 下午 12:24:14  DChang
  For speeding up the query, one private variable is added into all TIdRR_
  series object, only first time query will generate the binary codes, the
  others will read the result form the first time generated.


    Rev 1.22    2004/12/15 上午 11:12:18  DChang    Version: 1.22
  Fix all BinQueryRecord method of TIdRR_*,
  TIdRR_TXT.BinQueryRecord is completed,
  and remark the comment of TIdTextModeResourceRecord.BinQueryRecord,
  it's should be empty.


    Rev 1.21    10/26/2004 9:06:30 PM  JPMugaas
  Updated references.


    Rev 1.20    9/15/2004 4:59:34 PM  DSiders
  Added localization comments.


    Rev 1.19    2004/7/19 下午 09:43:40  DChang
  1. Move the TIdTextModeResourceRecords which was defined in
  IdDNSServer.pas to here.
  2. Add a QueryType (DqtIXFR) in TDNSQueryRecordTypes.


    Rev 1.18    6/29/04 1:22:32 PM  RLebeau
  Updated NormalStrToDNSStr() to use CopyTIdBytes() instead of AppendBytes()


    Rev 1.17    2/11/2004 5:21:12 AM  JPMugaas
  Vladimir Vassiliev changes for removal of byte flipping.  Network conversion
  order conversion functions are used instead.
  IPv6 addresses are returned in the standard form.
  In WKS records, Address was changed to IPAddress to be consistant with other
  record types.  Address can also imply a hostname.


    Rev 1.16    2/7/2004 7:18:30 PM  JPMugaas
  Moved some functions out of IdDNSCommon so we can use them elsewhere.


    Rev 1.15    2004.02.07 5:45:10 PM  czhower
  Fixed compile error in D7.


    Rev 1.14    2004.02.07 5:03:26 PM  czhower
  .net fixes.


    Rev 1.13    2004.02.03 5:45:56 PM  czhower
  Name changes


    Rev 1.12    12/7/2003 8:07:24 PM  VVassiliev
  string -> TIdBytes


    Rev 1.11    11/15/2003 1:16:06 PM  VVassiliev
  Move AppendByte from IdDNSCommon to IdCoreGlobal


    Rev 1.10    11/13/2003 5:46:04 PM  VVassiliev
  DotNet


    Rev 1.9    10/25/2003 06:51:50 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.


    Rev 1.8    10/19/2003 11:56:12 AM  DSiders
  Added localization comments.


    Rev 1.7    2003.10.12 3:50:38 PM  czhower
  Compile todos


    Rev 1.6    2003/5/8 下午 08:07:12  DChang
  Add several constants for IdDNSServer


    Rev 1.5    4/28/2003 03:34:56 PM  JPMugaas
  Illiminated constant for the service path.  IFDEF's for platforms are only
  allowed in designated units.  Besides, the location of the services file is
  different in Win9x operating systems than NT operating systems.


    Rev 1.4    4/28/2003 02:30:46 PM  JPMugaas
  reverted back to the old one as the new one checked will not compile, has
  problametic dependancies on Contrs and Dialogs (both not permitted).


    Rev 1.2    4/28/2003 07:00:04 AM  JPMugaas
  Should now compile.


    Rev 1.0    11/14/2002 02:18:20 PM  JPMugaas
    Rev 1.3    04/28/2003 01:15:20 AM  DenniesChang


    // Add iRCode mode constants in May 4, 2003.
    // Modify all DNS relative header in IdDNSCommon.pas
    // Apr. 28, 2003

    // Jun. 03, 2002.
    // Add AXFR function
    Duplicate some varible and constants in DNSCommon,
    because Indy change version very frequently, these
    varlibles and objects are isolated.

    I had added some methods into IdDNSResolver of Indy 9.02,
    for parsing DN record directly and skip some check actions
    from original query, but this modification will not relfect
    the action of DN Query.

    Original Programmer: Dennies Chang <dennies@ms4.hinet.net>
    No Copyright. Code is given to the Indy Pit Crew.

    Started: Jan. 20, 2002.
    Finished:
}

unit IdDNSCommon;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdContainers,
  IdException,
  IdGlobal,
  IdResourceStrings,
  IdResourceStringsProtocols;

const
  IdDNSServerVersion = 'Indy DNSServer 20040121301'; {do not localize}
  cRCodeNoError   = 0;
  cRCodeFormatErr = 1;
  cRCodeServerErr = 2;
  cRCodeNameErr   = 3;
  cRCodeNotImplemented = 4;
  cRCodeRefused  = 5;

  iRCodeQueryNotImplement = 0;
  iRCodeQueryReturned = 1;
  iRCodeQueryOK = 2;
  iRCodeQueryNotFound = 3;

  iRCodeNoError = 0;
  iRCodeFormatError = 1;
  iRCodeServerFailure = 2;
  iRCodeNameError = 3;
  iRCodeNotImplemented = 4;
  iRCodeRefused = 5;

  iQr_Question = 0;
  iQr_Answer = 1;

  iAA_NotAuthoritative = 0;
  iAA_Authoritative = 1;

  cRCodeQueryNotImplement = 'NA'; {do not localize}
  cRCodeQueryReturned = 'RC'; // Return Completed.  {do not localize}
  cRCodeQueryOK = 'OK'; {do not localize}
  cRCodeQueryCacheOK = 'COK'; {do not localize}
  cRCodeQueryNotFound = 'NOTFOUND'; {do not localize}
  cRCodeQueryCacheFindError = 'CFoundError'; {do not localize}

  RSDNSServerAXFRError_QuerySequenceError = 'First record must be SOA!';  {do not localize}
  RSDNSServerSettingError_MappingHostError = 'Host must be an IP address'; {do not localize}

  cOrigin = '$ORIGIN';    {do not localize}
  cInclude = '$INCLUDE';  {do not localize}
  cAAAA    = 'AAAA';      {do not localize}
  cAt     = '@';          {do not localize}
  cA      = 'A';          {do not localize}
  cNS     = 'NS';         {do not localize}
  cMD     = 'MD';         {do not localize}
  cMF     = 'MF';         {do not localize}
  cCName  = 'CNAME';      {do not localize}
  cSOA    = 'SOA';        {do not localize}
  cMB     = 'MB';         {do not localize}
  cMG     = 'MG';         {do not localize}
  cMR     = 'MR';         {do not localize}
  cNULL   = 'NULL';       {do not localize}
  cWKS    = 'WKS';        {do not localize}
  cPTR    = 'PTR';        {do not localize}
  cHINFO  = 'HINFO';      {do not localize}
  cMINFO  = 'MINFO';      {do not localize}
  cMX     = 'MX';         {do not localize}
  cTXT    = 'TXT';        {do not localize}
  cNSAP   = 'NSAP';       {do not localize}
  cNSAP_PTR = 'NSAP-PTR'; {do not localize}
  cLOC      = 'LOC';      {do not localize}
  cAXFR     = 'AXFR';     {do not localize}
  cIXFR     = 'IXFR';     {do not localize}
  cSTAR     = 'STAR';     {do not localize}

  cRCodeStrs : Array[cRCodeNoError..cRCodeRefused] Of String =
    (RSCodeNoError,
     RSCodeQueryFormat,
     RSCodeQueryServer,
     RSCodeQueryName,
     RSCodeQueryNotImplemented,
     RSCodeQueryQueryRefused);

  Class_IN = 1;
  Class_CHAOS = 3;

  TypeCode_A            = 1;
  TypeCode_NS           = 2;
  TypeCode_MD           = 3;
  TypeCode_MF           = 4;
  TypeCode_CName        = 5;
  TypeCode_SOA          = 6;
  TypeCode_MB           = 7;
  TypeCode_MG           = 8;
  TypeCode_MR           = 9;
  TypeCode_NULL         = 10;
  TypeCode_WKS          = 11;
  TypeCode_PTR          = 12;
  TypeCode_HINFO        = 13;
  TypeCode_MINFO        = 14;
  TypeCode_MX           = 15;
  TypeCode_TXT          = 16;
  TypeCode_RP           = 17;
  TypeCode_AFSDB        = 18;
  TypeCode_X25          = 19;
  TypeCode_ISDN         = 20;
  TypeCode_RT           = 21;
  TypeCode_NSAP         = 22;
  TypeCode_NSAP_PTR     = 23;
  TypeCode_SIG          = 24;
  TypeCode_KEY          = 25;
  TypeCode_PX           = 26;
  TypeCode_QPOS         = 27;
  TypeCode_AAAA         = 28;
  TypeCode_LOC          = 29;
  TypeCode_NXT          = 30;
  TypeCode_R31          = 31;
  TypeCode_R32          = 32;
  TypeCode_Service      = 33;
  TypeCode_R34          = 34;
  TypeCode_NAPTR        = 35;
  TypeCode_KX           = 36;
  TypeCode_CERT         = 37;
  TypeCode_V6Addr       = 38;
  TypeCode_DNAME        = 39;
  TypeCode_R40          = 40;
  TypeCode_OPTIONAL     = 41;
  TypeCode_IXFR         = 251;
  TypeCode_AXFR         = 252;
  TypeCode_STAR         = 255;
  TypeCode_Error        = 0;

type
  {NormalTags = (cA, cNS, cMD, cMF, cCName, cSOA, cMB, cMG, cMR, cNULL, cWKS, cPTR,
                cHINFO, cMINFO, cMX, cTXT);  }
  TDNSQueryRecordTypes = (DqtA, DqtNS, DqtMD, DqtMF, DqtName, DqtSOA, DqtMB,
    DqtMG, DqtMR, DqtNull, DqtWKS, DqtPTR, DqtHINFO, DqtMINFO, DqtMX, DqtTXT,
    DqtNSAP, DqtNSAP_PTR, DqtLOC, DqtIXFR, DqtAXFR, DqtSTAR, DqtAAAA);

  TDNSServerTypes = (stPrimary, stSecondary);

  EIdDNSServerSyncException = class(EIdSilentException);
  EIdDNSServerSettingException = class(EIdSilentException);

  // TODO: enable AD and CD properties. Those fields are reserved in RFC 1035, but defined in RFC 6895
  TDNSHeader = class
  private
    FID: UInt16;
    FBitCode: UInt16;
    FQDCount: UInt16;
    FANCount: UInt16;
    FNSCount: UInt16;
    FARCount: UInt16;
    function GetAA: UInt16;
    //function GetAD: UInt16;
    //function GetCD: UInt16;
    function GetOpCode: UInt16;
    function GetQr: UInt16;
    function GetRA: UInt16;
    function GetRCode: UInt16;
    function GetRD: UInt16;
    function GetTC: UInt16;
    procedure SetAA(const Value: UInt16);
    //procedure SetAD(const Value: UInt16);
    //procedure SetCD(const Value: UInt16);
    procedure SetOpCode(const Value: UInt16);
    procedure SetQr(const Value: UInt16);
    procedure SetRA(const Value: UInt16);
    procedure SetRCode(const Value: UInt16);
    procedure SetRD(const Value: UInt16);
    procedure SetTC(const Value: UInt16);
    procedure SetBitCode(const Value: UInt16);
  public
    constructor Create;
    procedure ClearByteCode;
    function ParseQuery(Data : TIdBytes) : integer;
    function GenerateBinaryHeader : TIdBytes;

    property ID: UInt16 read FID write FID;
    property Qr: UInt16 read GetQr write SetQr;
    property OpCode: UInt16 read GetOpCode write SetOpCode;
    property AA: UInt16 read GetAA write SetAA;
    //property AD: UInt16 get GetAD write SetAD;
    //property CD: UInt16 get GetCD write SetCD;
    property TC: UInt16 read GetTC write SetTC;
    property RD: UInt16 read GetRD write SetRD;
    property RA: UInt16 read GetRA write SetRA;
    property RCode: UInt16 read GetRCode write SetRCode;
    property BitCode: UInt16 read FBitCode write SetBitCode;
    property QDCount: UInt16 read FQDCount write FQDCount;
    property ANCount: UInt16 read FANCount write FANCount;
    property NSCount: UInt16 read FNSCount write FNSCount;
    property ARCount: UInt16 read FARCount write FARCount;
  end;

  TIdTextModeResourceRecord = class(TObject)
  protected
    FAnswer : TIdBytes;
    FRRName: string;
    FRRDatas: TStrings;  //TODO Should not be TIdStrings
    FTTL: Int32;
    FTypeCode: Integer;
    FTimeOut: string;
    function FormatQName(const AFullName: string): string; overload;
    function FormatQName(const AName, AFullName: string): string; overload;
    function FormatQNameFull(const AFullName: string): string;
    function FormatRecord(const AFullName: String; const ARRData: TIdBytes): TIdBytes;
    procedure SetRRDatas(const Value: TStrings);
    procedure SetTTL(const Value: Int32);
  public
    constructor CreateInit(const ARRName: String; ATypeCode: Integer);
    destructor Destroy; override;
    property TypeCode : Integer read FTypeCode;
    property RRName : string read FRRName write FRRName;
    property RRDatas : TStrings read FRRDatas write SetRRDatas;
    property TTL : integer read FTTL write SetTTL;
    property TimeOut : string read FTimeOut write FTimeOut;
    function ifAddFullName(AFullName: string; AGivenName: string = ''): boolean;
    function GetValue(const AName: String): String;
    procedure SetValue(const AName: String; const AValue: String);
    function ItemCount : Integer;
    function BinQueryRecord(AFullName: string): TIdBytes; virtual;
    function TextRecord(AFullName: string): string; virtual;
    procedure ClearAnswer;
  end;

  TIdTextModeRRs = class(TIdObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdTextModeResourceRecord>{$ENDIF})
  private
    FItemNames : TStrings;
    {$IFNDEF HAS_GENERICS_TObjectList}
    function GetItem(Index: Integer): TIdTextModeResourceRecord;
    procedure SetItem(Index: Integer; const Value: TIdTextModeResourceRecord);
    {$ENDIF}
    procedure SetItemNames(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;

    property ItemNames : TStrings read FItemNames write SetItemNames;
    {$IFNDEF HAS_GENERICS_TObjectList}
    property Items[Index: Integer]: TIdTextModeResourceRecord read GetItem write SetItem; default;
    {$ENDIF}
  end;


  TIdRR_CName = class(TIdTextModeResourceRecord)
  protected
    function GetCName: String;
    procedure SetCName(const Value: String);
  public
    constructor Create;
    property CName : String read GetCName write SetCName;
    function BinQueryRecord(AFullName: string): TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_HINFO = class(TIdTextModeResourceRecord)
  protected
    procedure SetCPU(const Value: String);
    function GetCPU: String;
    function GetOS: String;
    procedure SetOS(const Value: String);
  public
    constructor Create;
    property CPU : String read GetCPU write SetCPU;
    property OS : String read GetOS write SetOS;
    function BinQueryRecord(AFullName : string): TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_MB = class(TIdTextModeResourceRecord)
  protected
    function GetMADName: String;
    procedure SetMADName(const Value: String);
  public
    constructor Create;
    property MADName : String read GetMADName write SetMADName;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_MG = class(TIdTextModeResourceRecord)
  protected
    function GetMGMName: String;
    procedure SetMGMName(const Value: String);
  public
    constructor Create;
    property MGMName : String read GetMGMName write SetMGMName;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_MINFO = class(TIdTextModeResourceRecord)
  protected
    procedure SetErrorHandle_Mail(const Value: String);
    procedure SetResponsible_Mail(const Value: String);
    function GetEMail: String;
    function GetRMail: String;
  public
    constructor Create;
    property Responsible_Mail : String read GetRMail write SetResponsible_Mail;
    property ErrorHandle_Mail : String read GetEMail write SetErrorHandle_Mail;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_MR = class(TIdTextModeResourceRecord)
  protected
    function GetNewName: String;
    procedure SetNewName(const Value: String);
  public
    constructor Create;
    property NewName : String read GetNewName write SetNewName;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_MX = class(TIdTextModeResourceRecord)
  protected
    function GetExchang: String;
    procedure SetExchange(const Value: String);
    function GetPref: String;
    procedure SetPref(const Value: String);
  public
    constructor Create;
    property Exchange : String read GetExchang write SetExchange;
    property Preference : String read GetPref write SetPref;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_NS = class(TIdTextModeResourceRecord)
  protected
    function GetNS: String;
    procedure SetNS(const Value: String);
  public
    constructor Create;
    property NSDName : String read GetNS write SetNS;
    function BinQueryRecord(AFullName : string): TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_PTR = class(TIdTextModeResourceRecord)
  protected
    function GetPTRName: String;
    procedure SetPTRName(const Value: String);
  public
    constructor Create;
    property PTRDName : String read GetPTRName write SetPTRName;
    function BinQueryRecord(AFullName : string): TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_SOA = class(TIdTextModeResourceRecord)
  protected
    function GetName(const CLabel : String): String;
    procedure SetName(const CLabel: String; const Value : String);
    function GetMName: String;
    function GetRName: String;
    procedure SetMName(const Value: String);
    procedure SetRName(const Value: String);
    function GetMin: String;
    function GetRefresh: String;
    function GetRetry: String;
    function GetSerial: String;
    procedure SetMin(const Value: String);
    procedure SetRefresh(const Value: String);
    procedure SetRetry(const Value: String);
    procedure SetSerial(const Value: String);
    function GetExpire: String;
    procedure SetExpire(const Value: String);
  public
    constructor Create;
    property MName : String read GetMName write SetMName;
    property RName : String read GetRName write SetRName;
    property Serial : String read GetSerial write SetSerial;
    property Refresh : String read GetRefresh write SetRefresh;
    property Retry : String read GetRetry write SetRetry;
    property Expire : String read GetExpire write SetExpire;
    property Minimum : String read GetMin write SetMin;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;


  TIdRR_A = class(TIdTextModeResourceRecord)
  protected
    function GetA: String;
    procedure SetA(const Value: String);
  public
    constructor Create;
    property Address : String read GetA write SetA;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;

  TIdRR_AAAA = class(TIdTextModeResourceRecord)
  protected
    function GetA: String;
    procedure SetA(const Value: String);
  public
     constructor Create;
     property Address : String read GetA write SetA;
     function BinQueryRecord(AFullName : string) : TIdBytes; override;
     function TextRecord(AFullName : string) : string; override;
  end;

     { TODO : implement WKS record class }
  TIdRR_WKS = class(TIdTextModeResourceRecord)
  public
    constructor Create;
  end;

  TIdRR_TXT = class(TIdTextModeResourceRecord)
  protected
    function GetTXT: String;
    procedure SetTXT(const Value: String);
  public
    constructor Create;
    property TXT : String read GetTXT write SetTXT;
    function BinQueryRecord(AFullName : string) : TIdBytes; override;
    function TextRecord(AFullName : string) : string; override;
  end;

  TIdRR_Error = class(TIdTextModeResourceRecord)
  public
    constructor Create;
  end;

function DomainNameToDNSStr(const ADomain : String): TIdBytes;
function NormalStrToDNSStr(const Str : String): TIdBytes;
function IPAddrToDNSStr(const IPAddress : String): TIdBytes;
function IsValidIPv6(const v6Address : String): Boolean;
function ConvertToValidv6IP(const OrgIP : String) : string;
function ConvertToCanonical6IP(const OrgIP : String) : string;
function IPv6AAAAToDNSStr(const AIPv6Address : String): TIdBytes;
function GetErrorStr(const Code, Id: Integer): String;
function GetRCodeStr(RCode : Integer): String;
function ReplaceSpecString(Source, Target, NewString : string; ReplaceAll : boolean = True) : string;
function IsBig5(ch1, ch2: Char) : Boolean;

implementation

uses
  {$IFDEF VCL_XE3_OR_ABOVE}
    {$IFNDEF NEXTGEN}
  System.Contnrs,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_UNIT_DateUtils}
  DateUtils,
  {$ENDIF}
  IdGlobalProtocols,
  IdStack, SysUtils;

const
  ValidHexChars = '0123456789ABCDEFabcdef';

procedure IdBytesCopyBytes(const ASource: TIdBytes; var VDest: TIdBytes; var VDestIndex: Integer);
begin
  CopyTIdBytes(ASource, 0, VDest, VDestIndex, Length(ASource));
  Inc(VDestIndex, Length(ASource));
end;

procedure IdBytesCopyUInt16(const ASource: UInt16; var VDest: TIdBytes; var VDestIndex: Integer);
begin
  CopyTIdUInt16(ASource, VDest, VDestIndex);
  Inc(VDestIndex, SizeOf(UInt16));
end;

procedure IdBytesCopyUInt32(const ASource: UInt32; var VDest: TIdBytes; var VDestIndex: Integer);
begin
  CopyTIdUInt32(ASource, VDest, VDestIndex);
  Inc(VDestIndex, SizeOf(UInt32));
end;

function DomainNameToDNSStr(const ADomain : string): TIdBytes;
var
  BufStr, LDomain : String;
  LIdx : Integer;
  LLen: Byte;
begin
  if Length(ADomain) = 0 then begin
    SetLength(Result, 0);
  end else begin
    // TODO: ned to re-write this...
    SetLength(Result, Length(ADomain)+1);
    LIdx := 0;
    LDomain := ADomain;
    repeat
      BufStr := Fetch(LDomain, '.');
      LLen := Length(BufStr);
      Result[LIdx] := LLen;
      CopyTIdString(BufStr, Result, LIdx+1, LLen);
      Inc(LIdx, LLen+1);
    until LDomain = '';
    Result[LIdx] := 0;
    SetLength(Result, LIdx+1);
  end;
end;

function NormalStrToDNSStr(const Str : String): TIdBytes;
var
  LLen: Byte;
  LStr: TIdBytes;
begin
  LStr := ToBytes(Str);
  LLen := IndyMin(Length(LStr), $FF);
  SetLength(Result, 1 + LLen);
  Result[0] := LLen;
  CopyTIdBytes(LStr, 0, Result, 1, LLen);
end;

function IPAddrToDNSStr(const IPAddress : String): TIdBytes;
Var
  j, i: Integer;
  s : string;
begin
  SetLength(Result, 0);
  if IsValidIP(IPAddress) then begin
    s := Trim(IPAddress);
    SetLength(Result, 4);
    for i := 0 to 3 do begin
      j := IndyStrToInt(Fetch(s, '.'), -1); {do not localize}
      if (j < 0) or (j > 255) then begin
        Result := ToBytes('Error IP'); {do not localize}
        Exit;
      end;
      Result[I] := Byte(j);
    end;
  end else begin
    Result := ToBytes('Error IP'); {do not localize}
  end;
end;

procedure IdHexToBin(const AText: TIdBytes; var Buffer: TIdBytes; const BufSize: Integer);
const
  Convert: array['0'..'f'] of Int16 =                   {do not localize}
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);
var
  BufferPos, TextPos: Integer;
  ValidChars: TIdBytes;
begin
  ValidChars := ToBytes(ValidHexChars);
  BufferPos := 0;
  TextPos := 0;
  repeat
    if (not ByteIsInSet(AText, TextPos, ValidChars)) or
      (not ByteIsInSet(AText, TextPos+1, ValidChars)) then
    begin
      Break;
    end;
    Buffer[BufferPos] := (Convert[Char(AText[TextPos])] shl 4) + Convert[Char(AText[TextPos + 1])];
    Inc(BufferPos);
    Inc(TextPos, 2);
  until False;
end;

function IPv6AAAAToDNSStr(const AIPv6Address : String): TIdBytes;
var
  LAddr : TIdIPv6Address;
begin
  IPv6ToIdIPv6Address(AIPv6Address, LAddr);
  SetLength(Result, 16);
  CopyTIdIPV6Address(LAddr, Result, 0);
end;

function IsValidIPv6(const v6Address : String): boolean;
var
  Temps : TStrings;
  Apart, All: String;
  Count, Loc, Goal : integer;
begin
  All := v6Address;
  Temps := TStringList.Create;
  try
    // Check Double Colon existence, but only single.
    Count := 0;

    repeat
      Loc := IndyPos('::', All);               {do not localize}
      if Loc > 0 then begin
        Count := Count + 1;
        IdDelete(All, Loc, 2);
      end;
    until Loc = 0;

    if Count <= 1 then begin
      // Convert Double colon into compatible format.
      All := ReplaceSpecString(v6Address, '::', ':Multi:'); {do not localize}
      repeat
        Apart := Fetch(All, ':');                     {do not localize}
        Temps.Add(Apart);
      until All = '';                               {do not localize}

      Loc := Temps.IndexOf('Multi');  {do not localize}
      if Loc > -1 then begin
        Goal := 8 - Temps.Count;
        Temps.Strings[Loc] := '0000';  {do not localize}
        for Count := 0 to Goal -1 do begin
          Temps.Insert(Loc, '0000'); {do not localize}
        end;
        if Temps.Strings[0] = '' then begin {do not localize}
          Temps.Strings[0] := '0000';  {do not localize}
        end;
      end;

      All := ReplaceSpecString(Temps.CommaText, ',', ':');      {do not localize}
      Result := True;
      Temps.Clear;

      repeat
        Apart := Trim(Fetch(All, ':'));             {do not localize}
        if Length(Apart) <= 4 then begin
          Apart := '0000' + Apart;  {do not localize}
          Apart := Copy(Apart, Length(Apart)-3, 4);
          Temps.Add(Apart);
        end else begin
          Result := False;
        end;
      until (All = '') or (not Result);            {do not localize}

      if (not Result) or (Temps.Count > 8) then begin
        Result := False;
      end else begin
        for Count := 0 to Temps.Count -1 do begin
          All := All + Temps.Strings[Count];
        end;
        Result := Length(All) > 0;
        for Count := 1 to Length(All) do begin
          Result := CharIsInSet(All, Count, ValidHexChars);
          if not Result then begin
            Break;
          end;
        end;
      end;
    end else begin
       // mulitple Double colon, it's an incorrect IPv6 address.
      Result := False;
    end;
  finally
    FreeAndNil(Temps);
  end;
end;

function ConvertToValidv6IP(const OrgIP : String) : string;
var
  All, Apart : string;
  Temps : TStrings;
  Count, Loc, Goal : integer;
begin
  Result := '';
  All := OrgIP;
  Temps := TStringList.Create;
  try
    // Check Double Colon existence, but only single.
    // Count := 0;

    repeat
      Loc := IndyPos('::', All);    {do not localize}
      if Loc > 0 then begin
        //    Count := Count + 1;
        IdDelete(All, Loc, 2);
      end;
    until Loc = 0;

    // Convert Double colon into compatible format.
    All := ReplaceSpecString(OrgIP, '::', ':Multi:');  {do not localize}
    repeat
      Apart := Fetch(All, ':');  {do not localize}
      Temps.Add(Apart);
    until All = '';             {do not localize}

    Loc := Temps.IndexOf('Multi'); {do not localize}
    if Loc > -1 then begin
      Goal := 8 - Temps.Count;
      Temps.Strings[Loc] := '0000'; {do not localize}
      for Count := 0 to Goal -1 do begin
        Temps.Insert(Loc, '0000');  {do not localize}
      end;
      if Temps.Strings[0] = '' then begin
        Temps.Strings[0] := '0000'; {do not localize}
      end;
    end;
    Result := ReplaceSpecString(Temps.CommaText, ',', ':'); {do not localize}
  finally
    FreeAndNil(Temps);
  end;
end;

function ConvertToCanonical6IP(const OrgIP : String) : string;
var
  All, Apart: string;
begin
  {Supposed OrgIP is valid IPV6 string}
  Result := '';                      {do not localize}
  All := ConvertToValidv6IP(OrgIP);
  repeat
    Apart := Trim(Fetch(All, ':'));  {do not localize}
    if Length(Apart) < 4 then
    begin
      Apart := '0000' + Apart;  {do not localize}
      Apart := Copy(Apart, Length(Apart)-3, 4);
    end;
    Result := Result + Apart + ':'; {do not localize}
  until (All = '');                 {do not localize}
  SetLength(Result, Length(Result) - 1); //Remove last :
end;

{ TODO : Move these to member }
function GetErrorStr(const Code, Id: Integer): String;
begin
  case Code of
    1 : Result := IndyFormat(RSQueryInvalidQueryCount, [Id]);
    2 : Result := IndyFormat(RSQueryInvalidPacketSize, [Id]);
    3 : Result := IndyFormat(RSQueryLessThanFour, [Id]);
    4 : Result := IndyFormat(RSQueryInvalidHeaderID, [Id] );
    5 : Result := IndyFormat(RSQueryLessThanTwelve, [Id]);
    6 : Result := IndyFormat(RSQueryPackReceivedTooSmall, [Id]);
    else
        Result := IndyFormat(RSQueryUnknownError, [Code, Id]);
  end;  //case code Of
end;

function GetRCodeStr(RCode : Integer): String;
begin
  if Rcode in [cRCodeNoError..cRCodeRefused] then begin
    Result :=  cRCodeStrs[Rcode];
  end else begin // if Rcode in [cRCodeNoError..cRCodeRefused] then
    Result := RSCodeQueryUnknownError;
  end; //else.. if Rcode in [cRCodeNoError..cRCodeRefused] then
end;


{ TDNSHeader }

procedure TDNSHeader.ClearByteCode;
begin
  FBitCode := 0;
end;

constructor TDNSHeader.Create;
begin
  inherited Create;
  Randomize;
  FId := Random(65535);
end;

function TDNSHeader.GenerateBinaryHeader: TIdBytes;
{


The header contains the following fields:

                                    1  1  1  1  1  1
      0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                      ID                       |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |QR|   Opcode  |AA|TC|RD|RA| Z|AD|CD|   RCODE   |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                QDCOUNT/ZOCOUNT                |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                ANCOUNT/PRCOUNT                |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                NSCOUNT/UPCOUNT                |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    ARCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

where:

ID              A 16 bit identifier assigned by the program that
                generates any kind of query.  This identifier is copied
                the corresponding reply and can be used by the requester
                to match up replies to outstanding queries.

QR              A one bit field that specifies whether this message is a
                query (0), or a response (1).

OPCODE          A four bit field that specifies kind of query in this
                message.  This value is set by the originator of a query
                and copied into the response.  The values are:

                0               a standard query (QUERY)

                1               an inverse query (IQUERY)

                2               a server status request (STATUS)

                3-15            reserved for future use

AA              Authoritative Answer - this bit is valid in responses,
                and specifies that the responding name server is an
                authority for the domain name in question section.

                Note that the contents of the answer section may have
                multiple owner names because of aliases.  The AA bit

                corresponds to the name which matches the query name, or
                the first owner name in the answer section.

TC              TrunCation - specifies that this message was truncated
                due to length greater than that permitted on the
                transmission channel.

RD              Recursion Desired - this bit may be set in a query and
                is copied into the response.  If RD is set, it directs
                the name server to pursue the query recursively.
                Recursive query support is optional.

RA              Recursion Available - this be is set or cleared in a
                response, and denotes whether recursive query support is
                available in the name server.

Z               Reserved for future use.  Must be zero in all queries
                and responses.

AD              Authentic Data - signal indicating that the requester
                understands and is interested in the value of the AD bit
                in the response.  This allows a requester to indicate that
                it understands the AD bit without also requesting DNSSEC
                data via the DO bit.

CD              Checking Disabled

RCODE           Response code - this 4 bit field is set as part of
                responses.  The values have the following
                interpretation:

                0               No error condition

                1               Format error - The name server was
                                unable to interpret the query.

                2               Server failure - The name server was
                                unable to process this query due to a
                                problem with the name server.

                3               Name Error - Meaningful only for
                                responses from an authoritative name
                                server, this code signifies that the
                                domain name referenced in the query does
                                not exist.

                4               Not Implemented - The name server does
                                not support the requested kind of query.

                5               Refused - The name server refuses to
                                perform the specified operation for
                                policy reasons.  For example, a name
                                server may not wish to provide the
                                information to the particular requester,
                                or a name server may not wish to perform
                                a particular operation (e.g., zone

                                transfer) for particular data.

                6-15            Reserved for future use.

QDCOUNT         an unsigned 16 bit integer specifying the number of
                entries in the question section.

ANCOUNT         an unsigned 16 bit integer specifying the number of
                resource records in the answer section.

NSCOUNT         an unsigned 16 bit integer specifying the number of name
                server resource records in the authority records
                section.

ARCOUNT         an unsigned 16 bit integer specifying the number of
                resource records in the additional records section.
}
begin
  SetLength(Result, 12);
  UInt16ToTwoBytes(GStack.HostToNetwork(ID), Result, 0);
  UInt16ToTwoBytes(GStack.HostToNetwork(BitCode), Result, 2);
  UInt16ToTwoBytes(GStack.HostToNetwork(QDCount), Result, 4);
  UInt16ToTwoBytes(GStack.HostToNetwork(ANCount), Result, 6);
  UInt16ToTwoBytes(GStack.HostToNetwork(NSCount), Result, 8);
  UInt16ToTwoBytes(GStack.HostToNetwork(ARCount), Result, 10);
end;

function TDNSHeader.GetAA: UInt16;
begin
  Result := (FBitCode shr 10) and $0001;
end;

{
function TDNSHeader.GetAD: UInt16;
begin
  Result := (FBitCode shr 5) and $0001;
end;

function TDNSHeader.GetCD: UInt16;
begin
  Result := (FBitCode shr 4) and $0001;
end;
}

function TDNSHeader.GetOpCode: UInt16;
begin
  Result := (FBitCode shr 11) and $000F;
end;

function TDNSHeader.GetQr: UInt16;
begin
  Result := (FBitCode shr 15) and $0001;
end;

function TDNSHeader.GetRA: UInt16;
begin
  Result := (FBitCode shr 7) and $0001;
end;

function TDNSHeader.GetRCode: UInt16;
begin
  Result := FBitCode and $000F;
end;

function TDNSHeader.GetRD: UInt16;
begin
  Result := (FBitCode shr 8) and $0001;
end;

function TDNSHeader.GetTC: UInt16;
begin
  Result := (FBitCode shr 9) and $0001;
end;

function TDNSHeader.ParseQuery(Data: TIdBytes): integer;
begin
  Result := -1;
  if Length(Data) >= 12 then begin
    try
      ID      := GStack.NetworkToHost(BytesToUInt16(Data, 0));
      BitCode := GStack.NetworkToHost(BytesToUInt16(Data, 2));
      QDCount := GStack.NetworkToHost(BytesToUInt16(Data, 4));
      ANCount := GStack.NetworkToHost(BytesToUInt16(Data, 6));
      NSCount := GStack.NetworkToHost(BytesToUInt16(Data, 8));
      ARCount := GStack.NetworkToHost(BytesToUInt16(Data, 10));
      Result := 0;
    except
    end;
  end;
end;

procedure TDNSHeader.SetAA(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FBFF;
  end else begin
    FBitCode := FBitCode or $0400;
  end;
end;

{
procedure TDNSHeader.SetAD(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FFDF;
  end else begin
    FBitCode := FBitCode or $0020;
  end;
end;
}

procedure TDNSHeader.SetBitCode(const Value: UInt16);
begin
  FBitCode := Value;
end;

{
procedure TDNSHeader.SetCD(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FFEF;
  end else begin
    FBitCode := FBitCode or $0010;
  end;
end;
}

procedure TDNSHeader.SetOpCode(const Value: UInt16);
begin
  FBitCode := (FBitCode and $87FF) or ((Value and $000F) shl 11);
end;

procedure TDNSHeader.SetQr(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $7FFF;
  end else begin
    FBitCode := FBitCode or $8000;
  end;
end;

procedure TDNSHeader.SetRA(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FF7F;
  end else begin
    FBitCode := FBitCode or $0080;
  end;
end;

procedure TDNSHeader.SetRCode(const Value: UInt16);
begin
  FBitCode := (FBitCode and $FFF0) or (Value and $000F);
end;

procedure TDNSHeader.SetRD(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FEFF;
  end else begin
    FBitCode := FBitCode or $0100;
  end;
end;

procedure TDNSHeader.SetTC(const Value: UInt16);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FDFF;
  end else begin
    FBitCode := FBitCode or $0200;
  end;
end;


{ TIdTextModeResourceRecord }

function TIdTextModeResourceRecord.BinQueryRecord(AFullName: string): TIdBytes;
begin
  // This was empty? Where did it go?
  //todo;
  // Explain by Dennies : No, here must be empty, it's only a
  // virtual method, for child class to implement.
  Result := nil;
end;

procedure TIdTextModeResourceRecord.ClearAnswer;
begin
  SetLength(FAnswer, 0);
end;

constructor TIdTextModeResourceRecord.CreateInit(const ARRName: String; ATypeCode: Integer);
begin
  inherited Create;
  SetLength(FAnswer, 0);
  FRRName := ARRName;
  FTypeCode := ATypeCode;
  FRRDatas := TStringList.Create;
  TTL := 0;
end;

destructor TIdTextModeResourceRecord.Destroy;
begin
  FreeAndNil(FRRDatas);
  inherited Destroy;
end;

function TIdTextModeResourceRecord.FormatQName(const AFullName: string): string;
begin
  Result := FormatQName(FRRName, AFullName);
end;

function TIdTextModeResourceRecord.FormatQName(const AName, AFullName: string): string;
begin
  if Copy(AName, Length(AName), 1) <> '.' then begin
    Result := AName + '.' + AFullName;
  end else begin
    Result := AName;
  end;
end;

function TIdTextModeResourceRecord.FormatQNameFull(const AFullName: string): string;
var
  LQName: string;
begin
  LQName := FRRName + '.';
  if LQName <> AFullName then begin
    LQName := FormatQName(AFullName);
  end;
  if LQName = AFullName then begin
    Result := '@';
  end else begin
    Result := LQName;
  end;
end;

function TIdTextModeResourceRecord.FormatRecord(const AFullName: String; const ARRData: TIdBytes): TIdBytes;
var
  LDomain: TIdBytes;
  LIdx: Integer;
begin
  LDomain := DomainNameToDNSStr(FormatQName(AFullName));
  SetLength(Result, Length(LDomain)+(SizeOf(UInt16)*3)+SizeOf(UInt32)+Length(ARRData));
  LIdx := 0;
  IdBytesCopyBytes(LDomain, Result, LIdx);
  IdBytesCopyUInt16(GStack.HostToNetwork(UInt16(TypeCode)), Result, LIdx);
  IdBytesCopyUInt16(GStack.HostToNetwork(UInt16(Class_IN)), Result, LIdx);
  IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(TTL)), Result, LIdx);
  IdBytesCopyUInt16(GStack.HostToNetwork(UInt16(Length(ARRData))), Result, LIdx);
  IdBytesCopyBytes(ARRData, Result, LIdx);
end;

function TIdTextModeResourceRecord.GetValue(const AName: String): String;
begin
  Result := RRDatas.Values[AName];
end;

procedure TIdTextModeResourceRecord.SetValue(const AName: String; const AValue: String);
begin
  RRDatas.Values[AName] := AValue;
end;

function TIdTextModeResourceRecord.ifAddFullName(AFullName, AGivenName: string): boolean;
var
  LTailString, LBackString, LDestination : string;
  LTS, LRR : integer;
begin
  if AGivenName = '' then begin
    LDestination := RRName;
  end else begin
    LDestination := AGivenName;
  end;

  if TextEndsWith(LDestination, '.') then begin
    Result := False;
  end else begin
    if TextEndsWith(AFullName, '.') then begin
      LTailString := Copy(AFullName, 1, Length(AFullName) - 1);
    end else begin
      LTailString := AFullName;
    end;

    LTS := Length(LTailString);
    LRR := Length(LDestination);

    if LRR >= LTS then begin
      LBackString := Copy(LDestination, LRR - LTS + 1 , LTS);
      Result := not (LBackString = LTailString);
    end else begin
      Result := True;
    end;
  end;
end;

function TIdTextModeResourceRecord.ItemCount: integer;
begin
  Result := RRDatas.Count;
end;

procedure TIdTextModeResourceRecord.SetRRDatas(const Value: TStrings);
begin
  FRRDatas.Assign(Value);
end;

procedure TIdTextModeResourceRecord.SetTTL(const Value: integer);
begin
  FTTL := Value;
  FTimeOut := DateTimeToStr(AddMSecToTime(Now, Value * 1000));
end;

function TIdTextModeResourceRecord.TextRecord(AFullName: string): string;
begin
  Result := '';
end;

{ TIdTextModeRRs }

constructor TIdTextModeRRs.Create;
begin
  inherited Create;
  FItemNames := TStringList.Create;
end;

destructor TIdTextModeRRs.Destroy;
begin
  FreeAndNil(FItemNames);
  inherited Destroy;
end;

{$IFNDEF HAS_GENERICS_TObjectList}
function TIdTextModeRRs.GetItem(Index: Integer): TIdTextModeResourceRecord;
begin
  Result := TIdTextModeResourceRecord(inherited GetItem(Index));
end;

procedure TIdTextModeRRs.SetItem(Index: Integer; const Value: TIdTextModeResourceRecord);
begin
  inherited SetItem(Index, Value);
end;
{$ENDIF}

procedure TIdTextModeRRs.SetItemNames(const Value: TStrings);
begin
  FItemNames.Assign(Value);
end;

{ TIdRR_CName }

function TIdRR_CName.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(CName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_CName.Create;
begin
  inherited CreateInit('CName', TypeCode_CName); {do not localize}
  CName := '';
end;

function TIdRR_CName.GetCName: String;
begin
  Result := GetValue('CName'); {do not localize}
end;

procedure TIdRR_CName.SetCName(const Value: String);
begin
  SetValue('CName', Value);  {do not localize}
end;

function TIdRR_CName.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'CNAME' + Chr(9) + CName + EOL;  {do not localize}
end;

{ TIdRR_HINFO }

function TIdRR_HINFO.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
    RRData := NormalStrToDNSStr(CPU);
    AppendBytes(RRData, NormalStrToDNSStr(OS));
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_HINFO.Create;
begin
  inherited CreateInit('HINFO', TypeCode_HINFO); {do not localize}
  CPU := '';
  OS := '';
end;

function TIdRR_HINFO.GetCPU: String;
begin
  Result := GetValue('CPU'); {do not localize}
end;

function TIdRR_HINFO.GetOS: String;
begin
  Result := GetValue('OS');  {do not localize}
end;

procedure TIdRR_HINFO.SetCPU(const Value: String);
begin
  SetValue('CPU', Value);  {do not localize}
end;

procedure TIdRR_HINFO.SetOS(const Value: String);
begin
  SetValue('OS', Value); {do not localize}
end;

function TIdRR_HINFO.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'HINFO' + Chr(9)
    + '"' + CPU + '" "' + OS + '"' + EOL; {do not localize}
end;

{ TIdRR_MB }

function TIdRR_MB.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(MADName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_MB.Create;
begin
  inherited CreateInit('MB', TypeCode_MB);  {do not localize}
  MADName := '';
end;

function TIdRR_MB.GetMADName: String;
begin
  Result := GetValue('MADNAME'); {do not localize}
end;

procedure TIdRR_MB.SetMADName(const Value: String);
begin
  SetValue('MADNAME', Value);  {do not localize}
end;

function TIdRR_MB.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'MB' + Chr(9) + MADName + EOL;  {do not localize}
end;

{ TIdRR_MG }

function TIdRR_MG.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(MGMName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_MG.Create;
begin
  inherited CreateInit('MG', TypeCode_MG);  {do not localize}
  MGMName := '';
end;

function TIdRR_MG.GetMGMName: String;
begin
  Result := GetValue('MGMNAME'); {do not localize}
end;

procedure TIdRR_MG.SetMGMName(const Value: String);
begin
  SetValue('MGMNAME', Value);  {do not localize}
end;

function TIdRR_MG.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'MG' + Chr(9) + MGMName + EOL; {do not localize}
end;

{ TIdRR_MINFO }

function TIdRR_MINFO.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
{
From: http://www.its.uq.edu.au/DMT/RFC/rfc1035.html#MINFO_RR
3.3.7. MINFO RDATA format (EXPERIMENTAL)

    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    /                    RMAILBX                    /
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    /                    EMAILBX                    /
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
}
begin
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(Responsible_Mail);
    AppendBytes(RRData, DomainNameToDNSStr(ErrorHandle_Mail));
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_MINFO.Create;
begin
  inherited CreateInit('MINFO', TypeCode_MINFO); {do not localize}
  Responsible_Mail := '';
  ErrorHandle_Mail := '';
end;

function TIdRR_MINFO.GetEMail: String;
begin
  Result := GetValue('EMAILBX'); {do not localize}
end;

function TIdRR_MINFO.GetRMail: String;
begin
  Result := GetValue('RMAILBX'); {do not localize}
end;

procedure TIdRR_MINFO.SetErrorHandle_Mail(const Value: String);
begin
  SetValue('EMAILBX', Value);  {do not localize}
end;

procedure TIdRR_MINFO.SetResponsible_Mail(const Value: String);
begin
  SetValue('RMAILBX', Value);  {do not localize}
end;

function TIdRR_MINFO.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'MINFO' + Chr(9)  {do not localize}
    + Responsible_Mail + ' ' + ErrorHandle_Mail + EOL; {do not localize}
end;

{ TIdRR_MR }

function TIdRR_MR.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(NewName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_MR.Create;
begin
  inherited CreateInit('MR', TypeCode_MR);  {do not localize}
  NewName := '';
end;

function TIdRR_MR.GetNewName: String;
begin
  Result := GetValue('NewName'); {do not localize}
end;

procedure TIdRR_MR.SetNewName(const Value: String);
begin
  SetValue('NewName', Value);  {do not localize}
end;

function TIdRR_MR.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'MR' + Chr(9) + NewName + EOL; {do not localize}
end;

{ TIdRR_MX }

function TIdRR_MX.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData, Tmp: TIdBytes;
  Pref : UInt16;
begin
  Tmp := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    Pref := IndyStrToInt(Preference);
    RRData := ToBytes(GStack.HostToNetwork(Pref));
    Tmp := DomainNameToDNSStr(FormatQName(Exchange,AFullName));
    AppendBytes(RRData, Tmp);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_MX.Create;
begin
  inherited CreateInit('MX', TypeCode_MX);  {do not localize}
  Exchange := '';
end;

function TIdRR_MX.GetExchang: String;
begin
  Result := GetValue('EXCHANGE');  {do not localize}
end;

function TIdRR_MX.GetPref: String;
begin
  Result := GetValue('PREF');  {do not localize}
end;

procedure TIdRR_MX.SetExchange(const Value: String);
begin
  SetValue('EXCHANGE', Value); {do not localize}
end;

procedure TIdRR_MX.SetPref(const Value: String);
begin
  SetValue('PREF', Value); {do not localize}
end;

function TIdRR_MX.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'MX' + Chr(9) {do not localize}
    + Preference + ' ' + Exchange + EOL; {do not localize}
end;

{ TIdRR_NS }

function TIdRR_NS.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(NSDName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_NS.Create;
begin
  inherited CreateInit('NS', TypeCode_NS);  {do not localize}
  NSDName := '';
end;

function TIdRR_NS.GetNS: String;
begin
  Result := GetValue('NSDNAME'); {do not localize}
end;

procedure TIdRR_NS.SetNS(const Value: String);
begin
  SetValue('NSDNAME', Value);  {do not localize}
end;

function TIdRR_NS.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'NS' + Chr(9) + NSDName + EOL; {do not localize}
end;

{ TIdRR_PTR }

function TIdRR_PTR.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := DomainNameToDNSStr(PTRDName);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_PTR.Create;
begin
  inherited CreateInit('PTR', TypeCode_PTR); {do not localize}
  PTRDName := '';
end;

function TIdRR_PTR.GetPTRName: String;
begin
  Result := GetValue('PTRDNAME');  {do not localize}
end;

procedure TIdRR_PTR.SetPTRName(const Value: String);
begin
  SetValue('PTRDNAME', Value); {do not localize}
end;

function TIdRR_PTR.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'PTR' + Chr(9) + PTRDName + EOL; {do not localize}
end;

{ TIdRR_SOA }

function TIdRR_SOA.BinQueryRecord(AFullName: string): TIdBytes;
var
  LMName, LRName, RRData: TIdBytes;
  LIdx: Integer;
begin
  // keep the compiler happy
  LMName := nil; 
  LRName := nil;
  RRData := nil;

  if Length(FAnswer) = 0 then begin
    LMName := DomainNameToDNSStr(MName);
    LRName := DomainNameToDNSStr(RName);

    SetLength(RRData, Length(LMName)+Length(LRName)+(SizeOf(UInt32)*5));

    LIdx := 0;
    IdBytesCopyBytes(LMName, RRData, LIdx);
    IdBytesCopyBytes(LRName, RRData, LIdx);

    IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(IndyStrToInt(Serial))), RRData, LIdx);
    IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(IndyStrToInt(Refresh))), RRData, LIdx);
    IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(IndyStrToInt(Retry))), RRData, LIdx);
    IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(IndyStrToInt(Expire))), RRData, LIdx);
    IdBytesCopyUInt32(GStack.HostToNetwork(UInt32(IndyStrToInt(Minimum))), RRData, LIdx);

    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_SOA.Create;
begin
  inherited CreateInit('SOA', TypeCode_SOA); {do not localize}
  MName := '';
  RName := '';
  Serial := '';
  Refresh := '';
  Retry := '';
  Expire := '';
  Minimum := '';
end;

function TIdRR_SOA.GetExpire: String;
begin
  Result := GetName('EXPIRE'); {do not localize}
end;

function TIdRR_SOA.GetMin: String;
begin
  Result := GetName('MINIMUM');  {do not localize}
end;

function TIdRR_SOA.GetMName: String;
begin
  Result := GetName('MNAME');  {do not localize}
end;

function TIdRR_SOA.GetName(const CLabel: String): String;
begin
  Result := GetValue(CLabel);
end;

function TIdRR_SOA.GetRefresh: String;
begin
  Result := GetName('REFRESH');  {do not localize}
end;

function TIdRR_SOA.GetRetry: String;
begin
  Result := GetName('RETRY');  {do not localize}
end;

function TIdRR_SOA.GetRName: String;
begin
  Result := GetName('RNAME');  {do not localize}
end;

function TIdRR_SOA.GetSerial: String;
begin
  Result := GetName('SERIAL'); {do not localize}
end;

procedure TIdRR_SOA.SetExpire(const Value: String);
begin
  SetName('EXPIRE', Value);  {do not localize}
end;

procedure TIdRR_SOA.SetMin(const Value: String);
begin
  SetName('MINIMUM', Value); {do not localize}
end;

procedure TIdRR_SOA.SetMName(const Value: String);
begin
  SetName('MNAME', Value); {do not localize}
end;

procedure TIdRR_SOA.SetName(const CLabel: String; const Value: String);
begin
  SetValue(CLabel, Value);
end;

procedure TIdRR_SOA.SetRefresh(const Value: String);
begin
  SetName('REFRESH', Value); {do not localize}
end;

procedure TIdRR_SOA.SetRetry(const Value: String);
begin
  SetName('RETRY', Value); {do not localize}
end;

procedure TIdRR_SOA.SetRName(const Value: String);
begin
  SetName('RNAME', Value); {do not localize}
end;

procedure TIdRR_SOA.SetSerial(const Value: String);
begin
  SetName('SERIAL', Value);  {do not localize}
end;

function TIdRR_SOA.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'SOA' + Chr(9) {do not localize}
    + MName + ' ' + RName + ' ' + Serial + ' ' + Refresh + ' ' + Retry + ' ' {do not localize}
    + Expire + ' ' + Minimum + EOL; {do not localize}
end;

{ TIdRR_A }

function TIdRR_A.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(Self.FAnswer) = 0 then begin
    RRData := IPAddrToDNSStr(Address);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_A.Create;
begin
  inherited CreateInit('A', TypeCode_A);   {do not localize}
  Address := '';
end;

function TIdRR_A.GetA: String;
begin
  Result := GetValue('A'); {do not localize}
end;

procedure TIdRR_A.SetA(const Value: String);
begin
  SetValue('A', Value);  {do not localize}
end;

function TIdRR_A.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'A' + Chr(9) + Address + EOL; {do not localize}
end;

{ TIdRR_AAAA }

function TIdRR_AAAA.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    RRData := IPv6AAAAToDNSStr(Address);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_AAAA.Create;
begin
  inherited CreateInit('AAAA', TypeCode_AAAA);  {do not localize}
  Address := '';
end;

function TIdRR_AAAA.GetA: String;
begin
  Result := GetValue('AAAA');  {do not localize}
end;

procedure TIdRR_AAAA.SetA(const Value: String);
begin
  SetValue('AAAA', Value); {do not localize}
end;

function TIdRR_AAAA.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'AAAA' + Chr(9) + Address + EOL; {do not localize}
end;

{ TIdRR_TXT }

function TIdRR_TXT.BinQueryRecord(AFullName: string): TIdBytes;
var
  RRData: TIdBytes;
begin
  RRData := nil; // keep the compiler happy
  if Length(FAnswer) = 0 then begin
    //Fix here, make the RRData being DNSStr.
    //Fixed in 2005 Jan 25.
    RRData := NormalStrToDNSStr(TXT);
    FAnswer := FormatRecord(AFullName, RRData);
  end;
  Result := ToBytes(FAnswer, Length(FAnswer));
end;

constructor TIdRR_TXT.Create;
begin
  inherited CreateInit('TXT', TypeCode_TXT); {do not localize}
  TXT := '';
end;

function TIdRR_TXT.GetTXT: String;
begin
  Result := GetValue('TXT'); {do not localize}
end;

procedure TIdRR_TXT.SetTXT(const Value: String);
begin
  SetValue('TXT', Value);  {do not localize}
end;

function TIdRR_TXT.TextRecord(AFullName: string): string;
begin
  Result := FormatQNameFull(AFullName) + Chr(9) + 'IN' + Chr(9) + 'TXT' + Chr(9) {do not localize}
    + '"' + TXT + '"' + EOL; {do not localize}
end;

{ TIdRR_WKS }

constructor TIdRR_WKS.Create;
begin
  inherited CreateInit('WKS', TypeCode_WKS); {do not localize}
end;

{ TIdRR_Error }

constructor TIdRR_Error.Create;
begin
   inherited CreateInit('', TypeCode_Error); {do not localize}
end;

function ReplaceSpecString(Source, Target, NewString : string; ReplaceAll : boolean = True) : string;
var
  FixingString, MiddleString, FixedString : string;
begin
  if Target = NewString then begin
    Result := Source;
  end else begin
    FixingString := Source;
    MiddleString := '';                     {do not localize}
    FixedString := '';                      {do not localize}

    if Pos(Target, Source) > 0 then begin
      repeat
        MiddleString := Fetch(FixingString, Target);
        FixedString := FixedString + MiddleString + NewString;
      until (Pos(Target, FixingString) = 0) or (not ReplaceAll);
      Result := FixedString + FixingString;
    end else begin
      Result := Source;
    end;
  end;
end;

function IsBig5(ch1, ch2:char) : boolean;
begin
  // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...

  if (not (((ch1 >= Char(161)) and (ch1 <= Char(254))) or
    ((ch1 >= Char(142)) and (ch1 <= Char(160))) or
    ((ch1 >= Char(129)) and (ch1 <= Char(141)))) ) or
    (not (((ch2 >= #64) and (ch2 <= #126)) or
    ((ch2 >= Char(161)) and (ch2 <= Char(254)))) ) then
   begin
    Result := False;
  end else begin
    Result := True;
  end;
end;

end.
