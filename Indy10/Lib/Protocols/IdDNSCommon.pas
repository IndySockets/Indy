{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13798: IdDNSCommon.pas
{
{   Rev 1.29    1/31/2005 9:02:44 PM  JPMugaas
{ Should compile again.  OOPS!!
}
{
{   Rev 1.28    1/28/2005 8:06:08 PM  JPMugaas
{ Bug with MINFO, it was not returning the responsible E-Mail address.
}
{
{   Rev 1.27    1/28/2005 7:12:34 PM  JPMugaas
{ Minor formatting adjustments.
}
{
{   Rev 1.26    1/28/2005 3:46:18 PM  JPMugaas
{ Should compile.
}
{
{   Rev 1.25    2005/1/28 下午 12:40:08  DChang
{ Add a new method for TIdTextModeResourceRecord to clean the created FAnswer,
{ then while the record updated, new data can be used in the FAnswer.
}
{
{   Rev 1.23    2005/1/25 下午 12:24:14  DChang
{ For speeding up the query, one private variable is added into all TIdRR_
{ series object, only first time query will generate the binary codes, the
{ others will read the result form the first time generated.
}
{
{   Rev 1.22    2004/12/15 上午 11:12:18  DChang    Version: 1.22
{ Fix all BinQueryRecord method of TIdRR_*, 
{ TIdRR_TXT.BinQueryRecord is completed,
{ and remark the comment of TIdTextModeResourceRecord.BinQueryRecord,
{ it's should be empty.
}
{
{   Rev 1.21    10/26/2004 9:06:30 PM  JPMugaas
{ Updated references.
}
{
    Rev 1.20    9/15/2004 4:59:34 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.19    2004/7/19 下午 09:43:40  DChang
{ 1. Move the TIdTextModeResourceRecords which was defined in
{ IdDNSServer.pas to here.
{ 2. Add a QueryType (DqtIXFR) in TDNSQueryRecordTypes.
}
{
{   Rev 1.18    6/29/04 1:22:32 PM  RLebeau
{ Updated NormalStrToDNSStr() to use CopyTIdBytes() instead of AppendBytes()
}
{
{   Rev 1.17    2/11/2004 5:21:12 AM  JPMugaas
{ Vladimir Vassiliev changes for removal of byte flipping.  Network conversion
{ order conversion functions are used instead.
{ IPv6 addresses are returned in the standard form.
{ In WKS records, Address was changed to IPAddress to be consistant with other
{ record types.  Address can also imply a hostname.
}
{
{   Rev 1.16    2/7/2004 7:18:30 PM  JPMugaas
{ Moved some functions out of IdDNSCommon so we can use them elsewhere.
}
{
{   Rev 1.15    2004.02.07 5:45:10 PM  czhower
{ Fixed compile error in D7.
}
{
{   Rev 1.14    2004.02.07 5:03:26 PM  czhower
{ .net fixes.
}
{
{   Rev 1.13    2004.02.03 5:45:56 PM  czhower
{ Name changes
}
{
{   Rev 1.12    12/7/2003 8:07:24 PM  VVassiliev
{ string -> TIdBytes
}
{
{   Rev 1.11    11/15/2003 1:16:06 PM  VVassiliev
{ Move AppendByte from IdDNSCommon to IdCoreGlobal
}
{
{   Rev 1.10    11/13/2003 5:46:04 PM  VVassiliev
{ DotNet
}
{
{   Rev 1.9    10/25/2003 06:51:50 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.
}
{
    Rev 1.8    10/19/2003 11:56:12 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.7    2003.10.12 3:50:38 PM  czhower
{ Compile todos
}
{
{   Rev 1.6    2003/5/8 下午 08:07:12  DChang
{ Add several constants for IdDNSServer
}
{
{   Rev 1.5    4/28/2003 03:34:56 PM  JPMugaas
{ Illiminated constant for the service path.  IFDEF's for platforms are only
{ allowed in designated units.  Besides, the location of the services file is
{ different in Win9x operating systems than NT operating systems.
}
{
{   Rev 1.4    4/28/2003 02:30:46 PM  JPMugaas
{ reverted back to the old one as the new one checked will not compile, has
{ problametic dependancies on Contrs and Dialogs (both not permitted).
}
{
{   Rev 1.2    4/28/2003 07:00:04 AM  JPMugaas
{ Should now compile.
}
{
{   Rev 1.0    11/14/2002 02:18:20 PM  JPMugaas
    Rev 1.3    04/28/2003 01:15:20 AM  DenniesChang
}
{
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

uses
  IdContainers,
  IdException,
  IdGlobal,
  IdResourceStrings,
  IdResourceStringsProtocols,
  IdSys,
  IdObjs;

Resourcestring
  RSQueryMustProvideSOARecord = 'You have to provide a TIdRR_SOA object with Serial number and Name to progress IXFR. %d';

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

  TDNSHeader = class
  private
    FID: Word;
    FBitCode: Word;
    FQDCount: Word;
    FANCount: Word;
    FNSCount: Word;
    FARCount: Word;
    function GetAA: Word;
    function GetOpCode: Word;
    function GetQr: Word;
    function GetRA: Word;
    function GetRCode: Word;
    function GetRD: Word;
    function GetTC: Word;
    procedure SetAA(const Value: Word);
    procedure SetOpCode(const Value: Word);
    procedure SetQr(const Value: Word);
    procedure SetRA(const Value: Word);
    procedure SetRCode(const Value: Word);
    procedure SetRD(const Value: Word);
    procedure SetTC(const Value: Word);
    procedure SetBitCode(const Value: Word);
  public
    constructor Create;
    procedure ClearByteCode;
    function ParseQuery(Data : TIdBytes) : integer;
    function GenerateBinaryHeader : TIdBytes ;

    property ID: Word read FID write FID;
    property Qr: Word read GetQr write SetQr;
    property OpCode: Word read GetOpCode write SetOpCode;
    property AA: Word read GetAA write SetAA;
    property TC: Word read GetTC write SetTC;
    property RD: Word read GetRD write SetRD;
    property RA: Word read GetRA write SetRA;
    property RCode: Word read GetRCode write SetRCode;
    property BitCode: Word read FBitCode write SetBitCode;
    property QDCount: Word read FQDCount write FQDCount;
    property ANCount: Word read FANCount write FANCount;
    property NSCount: Word read FNSCount write FNSCount;
    property ARCount: Word read FARCount write FARCount;
  end;

  TIdTextModeResourceRecord = class (TObject)
  private
    FRRName: string;
    FRRDatas: TIdStrings;  //TODO Should not be TIdStrings
    FTTL: integer;
    FTypeCode: integer;
    FTimeOut: string;
    procedure SetRRDatas(const Value: TIdStrings);
    procedure SetTTL(const Value: integer);
  protected
    FAnswer : TIdBytes;
  public
    constructor Create;
    destructor Destroy; override;
    property TypeCode : integer read FTypeCode write FTypeCode;
    property RRName : string read FRRName write FRRName;
    property RRDatas : TIdStrings read FRRDatas write SetRRDatas;
    property TTL : integer read FTTL write SetTTL;
    property TimeOut :string read FTimeOut write FTimeOut;
    procedure AddOneParameter(ParameterName, Value : string);
    function ifAddFullName(FullName : string; givenName : string= '') : boolean;
    function GetValue(ParameterName : string) : string;
    function ItemCount : integer;
    function BinQueryRecord(FullName : string): TIdBytes; virtual;
    function TextRecord(FullName : string) : string; virtual;
    procedure ClearAnswer;
  end;

  TIdTextModeRRs = class (TIdObjectList)
  private
    FItemNames : TIdStrings;
    function GetItem(Index: Integer): TIdTextModeResourceRecord;
    procedure SetItem(Index: Integer;
      const Value: TIdTextModeResourceRecord);
    procedure SetItemNames(const Value: TIdStrings);
  public
    constructor Create;
    destructor Destroy; override;

    property ItemNames : TIdStrings read FItemNames write SetItemNames;
    property Items[Index: Integer]: TIdTextModeResourceRecord read GetItem write SetItem; default;
  end;


  TIdRR_CName = class(TIdTextModeResourceRecord)
  private
    function GetCName: AnsiString;
    procedure SetCName(const Value: AnsiString);
  public
    constructor Create;
    property CName : AnsiString read GetCName write SetCName;
    function BinQueryRecord(FullName: string): TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_HINFO = class(TIdTextModeResourceRecord)
  private
    procedure SetCPU(const Value: AnsiString);
    function GetCPU: AnsiString;
    function GetOS: AnsiString;
    procedure SetOS(const Value: AnsiString);
  public
    constructor Create;
    property CPU : AnsiString read GetCPU write SetCPU;
    property OS : AnsiString read GetOS write SetOS;
    function BinQueryRecord(FullName : string): TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_MB = class(TIdTextModeResourceRecord)
  private
    function GetMADName: AnsiString;
    procedure SetMADName(const Value: AnsiString);
  public
    constructor Create;
    property MADName : AnsiString read GetMADName write SetMADName;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_MG = class(TIdTextModeResourceRecord)
  private
    function GetMGMName: AnsiString;
    procedure SetMGMName(const Value: AnsiString);
  public
    constructor Create;
    property MGMName : AnsiString read GetMGMName write SetMGMName;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_MINFO = class(TIdTextModeResourceRecord)
  private
    procedure SetErrorHandle_Mail(const Value: AnsiString);
    procedure SetResponsible_Mail(const Value: AnsiString);
    function GetEMail: AnsiString;
    function GetRMail: AnsiString;
  public
    constructor Create;
    property Responsible_Mail : AnsiString read GetRMail write SetResponsible_Mail;
    property ErrorHandle_Mail : AnsiString read GetEMail write SetErrorHandle_Mail;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_MR = class(TIdTextModeResourceRecord)
  private
    function GetNewName: AnsiString;
    procedure SetNewName(const Value: AnsiString);
  public
    constructor Create;
    property NewName : AnsiString read GetNewName write SetNewName;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_MX = class(TIdTextModeResourceRecord)
  private
    function GetExchang: AnsiString;
    procedure SetExchange(const Value: AnsiString);
    function GetPref: AnsiString;
    procedure SetPref(const Value: AnsiString);
  public
    constructor Create;
    property Exchange : AnsiString read GetExchang write SetExchange;
    property Preference : AnsiString read GetPref write SetPref;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_NS = class(TIdTextModeResourceRecord)
  private
    function GetNS: AnsiString;
    procedure SetNS(const Value: AnsiString);
  public
    constructor Create;
    property NSDName : AnsiString read GetNS write SetNS;
    function BinQueryRecord(FullName : string): TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_PTR = class(TIdTextModeResourceRecord)
  private
    function GetPTRName: AnsiString;
    procedure SetPTRName(const Value: AnsiString);
  public
    constructor Create;
    property PTRDName : AnsiString read GetPTRName write SetPTRName;
    function BinQueryRecord(FullName : string): TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_SOA = class(TIdTextModeResourceRecord)
  private
    function GetName(CLabel : string):AnsiString;
    procedure SetName(CLabel, Value : AnsiString);
    function GetMName: AnsiString;
    function GetRName: AnsiString;
    procedure SetMName(const Value: AnsiString);
    procedure SetRName(const Value: AnsiString);
    function GetMin: AnsiString;
    function GetRefresh: AnsiString;
    function GetRetry: AnsiString;
    function GetSerial: AnsiString;
    procedure SetMin(const Value: AnsiString);
    procedure SetRefresh(const Value: AnsiString);
    procedure SetRetry(const Value: AnsiString);
    procedure SetSerial(const Value: AnsiString);
    function GetExpire: AnsiString;
    procedure SetExpire(const Value: AnsiString);
  public
    constructor Create;
    property MName : AnsiString read GetMName write SetMName;
    property RName : AnsiString read GetRName write SetRName;
    property Serial : AnsiString read GetSerial write SetSerial;
    property Refresh : AnsiString read GetRefresh write SetRefresh;
    property Retry : AnsiString read GetRetry write SetRetry;
    property Expire : AnsiString read GetExpire write SetExpire;
    property Minimum : AnsiString read GetMin write SetMin;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;


  TIdRR_A = class(TIdTextModeResourceRecord)
  private
    function GetA: AnsiString;
    procedure SetA(const Value: AnsiString);
  public
    constructor Create;
    property Address : AnsiString read GetA write SetA;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;

  TIdRR_AAAA = class(TIdTextModeResourceRecord)
  private
    function GetA: AnsiString;
    procedure SetA(const Value: AnsiString);
  public
     constructor Create;
     property Address : AnsiString read GetA write SetA;
     function BinQueryRecord(FullName : string) : TIdBytes; override;
     function TextRecord(FullName : string) : string; override;
  end;

     { TODO : implement WKS record class }
  TIdRR_WKS = class(TIdTextModeResourceRecord)
  public
    constructor Create;
  end;

  TIdRR_TXT = class(TIdTextModeResourceRecord)
  private
    function GetTXT: AnsiString;
    procedure SetTXT(const Value: AnsiString);
  public
    constructor Create;
    property TXT : AnsiString read GetTXT write SetTXT;
    function BinQueryRecord(FullName : string) : TIdBytes; override;
    function TextRecord(FullName : string) : string; override;
  end;

  TIdRR_Error = class(TIdTextModeResourceRecord)
  public
    constructor Create;
  end;

//this can not be const because the temp copy is modified
function DomainNameToDNSStr(ADomain : String): TIdBytes;
function NormalStrToDNSStr(Str : String): TIdBytes;
function IPAddrToDNSStr(IPAddress : String): TIdBytes;
function IsValidIPv6(v6Address : String): boolean;
function ConvertToValidv6IP(OrgIP : String) : string;
function ConvertToCanonical6IP(OrgIP : String) : string;
function IPv6AAAAToDNSStr(const AIPv6Address : String): TIdBytes;
function GetErrorStr(Code, Id :Integer): String;
function GetRCodeStr(RCode : Integer): String;
function ReplaceSpecString(Source, Target, NewString : string; ReplaceAll : boolean = True) : string;
function IsBig5(ch1, ch2:char) : boolean;

implementation

uses
  IdGlobalProtocols,
  IdStack;

function DomainNameToDNSStr(ADomain : String): TIdBytes;
var
   BufStr : String;
   aPos : Integer;
begin                         { DomainNameToDNSStr }
  SetLength(Result, 0);
  while Length(ADomain) > 0 do
  begin
    aPos := IndyPos ( '.', ADomain );  {do not localize}
    if aPos = 0 then
    begin
      aPos := Length(ADomain) + 1;
    end; //if aPos = 0 then
    BufStr := Copy(ADomain, 1, aPos - 1);
    IdDelete(ADomain, 1, aPos);
    AppendByte(Result, Length (BufStr));
    AppendBytes(Result, ToBytes(BufStr));
  end;

  if Length(Result) > 0 then
  begin
    AppendByte(Result, 0);
  end;
end;

function NormalStrToDNSStr(Str : String): TIdBytes;
var
  LLen: Byte;
begin
  LLen := Length(Str);
  SetLength(Result, 1 + LLen);
  Result[0] := LLen;
  CopyTIdBytes(ToBytes(Str), 0, Result, 1, LLen);
  //AppendBytes(Result, ToBytes(Str));
  //Result := Chr(Length(Str)) + Str;
end;

function IPAddrToDNSStr(IPAddress : String): TIdBytes;
Var
  j, i: Integer;
  s : string;
  ret : boolean;
begin
  SetLength(Result, 0);
  if IsValidIP(IPAddress) then
  begin
    s := sYS.Trim(IPAddress);
    ret := True;
    for i := 1 to 4 do
    begin
      j := Sys.StrToInt(Fetch(IPAddress, '.'), -1); {do not localize}
      ret := ret and (j > -1) and (j < 256);
      if not ret then
      begin
        Result := ToBytes('Error IP'); {do not localize}
        break;
      end else
        AppendByte(Result, j);
    end;
  end else
    Result := ToBytes('Error IP'); {do not localize}
end;

function IdHexToBin(Text, Buffer: TIdBytes; BufSize: Integer): Integer;
const
  Convert: array['0'..'f'] of SmallInt =                   {do not localize}
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);
var
  I: Integer;
  s: string;
  BufferPos, TextPos: Integer;
begin
  I := BufSize;
  BufferPos := 0;
  TextPos := 0;
  s := BytesToString(Text);
  while I > 0 do begin
    if not CharIsInSet(s, TextPos, CharRange('0','9')+CharRange( 'a','f')+CharRange('A','F')) then begin
      Break;   {do not localize}
    end;
    Buffer[BufferPos] := (Convert[char(Text[TextPos])] shl 4) + Convert[char(Text[TextPos + 1])];
    Inc(BufferPos);
    Inc(TextPos, 2);
    Dec(I);
  end;
  Result := BufSize - I;
end;

function IPv6AAAAToDNSStr(const AIPv6Address : String): TIdBytes;
var
   TempAddr, Selected : string;
   TempMem : TIdBytes;
   //array [0..15] of char;
   TempOrg : TIdBytes;
   //array [0..31] of char;
   //PRet, Porg : PChar;
   Count : integer;
begin
  SetLength(Result, 0);
  TempAddr := AIPv6Address;
  repeat
     Selected := Fetch(TempAddr, ':');   {do not localize}
     AppendBytes(Result, ToBytes(Selected));
  until TempAddr = '';                   {do not localize}
  SetLength(TempMem, 16);
  SetLength(TempOrg, 32);
  {Porg := @TempOrg[0];
  StrPCopy(Porg, Result);
  PRet := @TempMem[0];}
  IdHexToBin(Result, TempMem, 16);
  SetLength(Result, 0);

  for Count := 0 to 15 do
  begin
    if TempMem[Count] <> 0 then
    begin
      AppendByte(Result, TempMem[Count]);
         //Result := Result + Copy(TempMem[Count], 1, 1)
    end
    else
    begin
      AppendByte(Result, 0);
    end;
  end;
end;

function IsValidIPv6(v6Address : String): boolean;
var
   Temps : TIdStrings;
   Apart, All: String;
   Count, Loc, Goal : integer;
begin
  All := v6Address;
  Temps := TIdStringList.Create;
  try
    // Check Double Colon existence, but only single.
    Count := 0;

    repeat
     Loc := IndyPos('::', All);               {do not localize}
     if Loc > 0 then
     begin
       Count := Count + 1;
       IdDelete(All, Loc, 2);
     end;
    until Loc = 0;

    if Count <= 1 then
    begin
      All := v6Address;

     // Convert Double colon into compatible format.
      All := ReplaceSpecString(All, '::', ':Multi:'); {do not localize}
      repeat
        Apart := Fetch(All, ':');                     {do not localize}
        Temps.Add(Apart);
      until (All = '');                               {do not localize}
      Loc := Temps.IndexOf('Multi');  {do not localize}
      if Loc > -1 then
      begin
        Goal := 8 - Temps.Count;
        Temps.Strings[Loc] := '0000';  {do not localize}
        for Count := 0 to Goal -1 do
        begin
          Temps.Insert(Loc, '0000'); {do not localize}
        end;
        if Temps.Strings[0] = '' then  {do not localize}
        begin
          Temps.Strings[0] := '0000';  {do not localize}
        end;
      end;
      All := Temps.CommaText;
      All := ReplaceSpecString(All, ',', ':');      {do not localize}
      Result := True;
      Temps.Clear;
      repeat
        Apart := Sys.Trim(Fetch(All, ':'));             {do not localize}
        if Length(Apart) <= 4 then
        begin
          Apart := '0000' + Apart;  {do not localize}
          Apart := Copy(Apart, Length(Apart)-3, 4);
          Temps.Add(Apart);
        end else
        begin
          Result := False;
        end;
      until (All = '') or (not Result);            {do not localize}

      if (not Result) or (Temps.Count > 8) then
      begin
        Result := False;
      end else
      begin
        for Count := 0 to Temps.Count -1 do
        begin
          All := All + Temps.Strings[Count];
        end;

        Result := Length(All) > 0;
        for Count := 1 to Length(All) do
        begin
          if not Result then begin
            Break;
          end;
          Result := Result and CharIsInSet(All, Count, CharRange('0','9')+CharRange('A','F')+CharRange( 'a','f')); {do not localize}
        end;
      end;
    end else
    begin
       // mulitple Double colon, it's an incorrect IPv6 address.
     Result := False;
    end;
  finally
    Temps.Free;
  end;
end;

function ConvertToValidv6IP(OrgIP : String) : string;
var
   All, Apart : string;
   Temps : TIdStrings;
   Count, Loc, Goal : integer;
begin
   All := OrgIP;
   Temps := TIdStringList.Create;

   // Check Double Colon existence, but only single.
  // Count := 0;

   repeat
      Loc := IndyPos('::', All);    {do not localize}
      if Loc > 0 then begin
     //    Count := Count + 1;
         IdDelete(All, Loc, 2);
      end;
   until Loc = 0;

   All := OrgIP;

   // Convert Double colon into compatible format.
   All := ReplaceSpecString(All, '::', ':Multi:');  {do not localize}
   repeat
      Apart := Fetch(All, ':');  {do not localize}
      Temps.Add(Apart);
   until (All = '');             {do not localize}
   Loc := Temps.IndexOf('Multi'); {do not localize}
   if Loc > -1 then begin
      Goal := 8 - Temps.Count;
      Temps.Strings[Loc] := '0000'; {do not localize}
      for Count := 0 to Goal -1 do begin
          Temps.Insert(Loc, '0000');  {do not localize}
      end;
      if Temps.Strings[0] = '' then Temps.Strings[0] := '0000'; {do not localize}
   end;
   All := Temps.CommaText;
   All := ReplaceSpecString(All, ',', ':'); {do not localize}

   Temps.Free;
   Result := All;
end;

function ConvertToCanonical6IP(OrgIP : String) : string;
var
  All, Apart: string;
begin
  {Supposed OrgIp is valid IPV6 string}
  All := ConvertToValidv6IP(OrgIp);
  Result := '';                      {do not localize}
  repeat
    Apart := Sys.Trim(Fetch(All, ':'));  {do not localize}
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
function GetErrorStr(Code, Id :Integer): String;
begin
  case code Of
    1 : Result := Sys.Format ( RSQueryInvalidQueryCount, [ Id ] );
    2 : Result := Sys.Format ( RSQueryInvalidPacketSize, [ Id ] );
    3 : Result := Sys.Format ( RSQueryLessThanFour, [ Id ] );
    4 : Result := Sys.Format ( RSQueryInvalidHeaderID, [ Id ] );
    5 : Result := Sys.Format ( RSQueryLessThanTwelve, [ Id ] );
    6 : Result := Sys.Format ( RSQueryPackReceivedTooSmall, [Id] );
  end;  //case code Of
end;

function GetRCodeStr(RCode : Integer): String;
begin
  if Rcode in [cRCodeNoError..cRCodeRefused] then
  begin
    Result :=  cRCodeStrs[Rcode];
  end  // if Rcode in [cRCodeNoError..cRCodeRefused] then
  else
  begin
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
  inherited;
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
    |QR|   Opcode  |AA|TC|RD|RA|   Z    |   RCODE   |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    QDCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    ANCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    NSCOUNT                    |
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
   WordToTwoBytes(GStack.HostToNetwork( Self.ID), Result, 0);
  //strip off reserved bits
  BitCode := BitCode and $F1FF; //E00
  WordToTwoBytes(GStack.HostToNetwork(Self.BitCode), Result, 2);
  WordToTwoBytes(GStack.HostToNetwork(Self.QDCount), Result, 4);
  WordToTwoBytes(GStack.HostToNetwork(Self.ANCount), Result, 6);
  WordToTwoBytes(GStack.HostToNetwork(Self.NSCount), Result, 8);
  WordToTwoBytes(GStack.HostToNetwork(Self.ARCount), Result, 10); 
end;

function TDNSHeader.GetAA: Word;
begin
  Result := (FBitCode and $0700) shr 10;
end;

function TDNSHeader.GetOpCode: Word;
begin
  Result := ((FBitCode and $7800) shr 11) and $000F;
end;

function TDNSHeader.GetQr: Word;
begin
  Result := FBitCode shr 15;
end;

function TDNSHeader.GetRA: Word;
begin
  Result := (FBitCode and $0800) shr 7;
end;

function TDNSHeader.GetRCode: Word;
begin
  Result := FBitCode and $000F;
end;

function TDNSHeader.GetRD: Word;
begin
  Result := (FBitCode and $0100) shr 8;
end;

function TDNSHeader.GetTC: Word;
begin
  Result := (FBitCode and $0200) shr 9;
end;

function TDNSHeader.ParseQuery(Data: TIdBytes): integer;
begin
  if Length(Data) >= 12 then
  try
     Self.ID := GStack.NetworkToHost(TwoByteToWord(Data[0],Data[1]));
     Self.BitCode := GStack.NetworkToHost(TwoByteToWord(Data[2], Data[3]));
     Self.QDCount := GStack.NetworkToHost(TwoByteToWord(Data[4], Data[5]));
     Self.ANCount := GStack.NetworkToHost(TwoByteToWord(Data[6], Data[7]));
     Self.NSCount := GStack.NetworkToHost(TwoByteToWord(Data[8], Data[9]));
     Self.ARCount := GStack.NetworkToHost(TwoByteToWord(Data[10], Data[11]));
     Result := 0;
  except
        Result := -1;
  end
  else
  begin
    Result := -1;
  end;
end;

procedure TDNSHeader.SetAA(const Value: Word);
begin
  if Value = 0 then begin
   // FBitCode := FBitCode and $FBFF;
   FBitCode := FBitCode and $FFDF;
  end else begin
    FBitCode := FBitCode or $0020;
//    FBitCode := FBitCode or $0400;
  end;
end;

procedure TDNSHeader.SetBitCode(const Value: Word);
begin
  FBitCode := Value;
end;

procedure TDNSHeader.SetOpCode(const Value: Word);
begin

  case Value of  // $1E should mask the bits
    0: FBitCode := FBitCode and $FFE1;
      //FBitCode := FBitCode and $87FF;
    1: FBitCode := (FBitCode and $FFE1) or $0002;
      //FBitCode := FBitCode and $8FFF;
    2: FBitCode := (FBitCode and $FFE1) or $0004;
      //FBitCode := FBitCode and $4BFF;
  end;
end;

procedure TDNSHeader.SetQr(const Value: Word);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FFFE;
//    FBitCode := FBitCode and $EFFF;
  end else begin
    FBitCode := FBitCode or  $0001;
//    FBitCode := FBitCode or $8000;
  end;
end;

procedure TDNSHeader.SetRA(const Value: Word);
begin
  if Value = 0 then begin
  //  FBitCode := FBitCode and $FF7F;
    FBitCode := FBitCode or $FEFF;
  end else begin
    FBitCode := FBitCode or  $100;
 //   FBitCode := FBitCode or $0080;
  end;
end;

procedure TDNSHeader.SetRCode(const Value: Word);
begin
  FBitCode := (FBitCode and $FFF0) or (Value and $000F);
end;

procedure TDNSHeader.SetRD(const Value: Word);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FEFFF;
  end else begin
    FBitCode := FBitCode or $0100;
  end;
end;

procedure TDNSHeader.SetTC(const Value: Word);
begin
  if Value = 0 then begin
    FBitCode := FBitCode and $FDFF;
  end else begin
    FBitCode := FBitCode or $0200;
  end;
end;


{ TIdTextModeResourceRecord }

procedure TIdTextModeResourceRecord.AddOneParameter(ParameterName,
  Value: string);
begin
  Self.RRDatas.Values[ParameterName] := Value;
end;

function TIdTextModeResourceRecord.BinQueryRecord(
  FullName: string): TIdBytes;
begin
  // This was empty? Where did it go?
  //todo;
  // Explain by Dennies : No, here must be empty, it's only a
  // virtual method, for child class to implement.
  Result := nil;
end;

procedure TIdTextModeResourceRecord.ClearAnswer;
begin
   FAnswer := toBytes('');
end;

constructor TIdTextModeResourceRecord.Create;
begin
  inherited;
  Self.FRRDatas := TIdStringList.Create;
  Self.TTL := 0;
end;

destructor TIdTextModeResourceRecord.Destroy;
begin
  Self.FRRDatas.Free;
  inherited;
end;

function TIdTextModeResourceRecord.GetValue(ParameterName: string): string;
begin
  Result := Self.RRDatas.Values[ParameterName];
end;

function TIdTextModeResourceRecord.ifAddFullName(FullName,
  givenName: string): boolean;
var
   TailString, BackString, Destination : string;
   LTS, LRR : integer;
   TailwithDot : boolean;
begin
   if givenName = '' then begin
      Destination := Self.RRName;
   end else begin
       Destination := givenName;
   end;

   TailwithDot := Copy(Destination, Length(Destination),1) = '.';

   if TailwithDot then begin
      Result := False;
   end else begin
       if Copy(FullName, Length(FullName),1) = '.' then begin
          TailString := Copy(FullName, 1, Length(FullName) - 1);
       end else begin
           TailString := FullName;
       end;

       LTS := Length(TailString);
       LRR := Length(Destination);

       if LRR >= LTS then begin
          BackString := Copy(Destination, LRR - LTS + 1 , LTS);
          Result := not (BackString = TailString);
       end else begin
           Result := True;
       end;
   end;
end;

function TIdTextModeResourceRecord.ItemCount: integer;
begin
  Result := Self.RRDatas.Count;
end;

procedure TIdTextModeResourceRecord.SetRRDatas(const Value: TIdStrings);
begin
  FRRDatas.Assign(Value);
end;

procedure TIdTextModeResourceRecord.SetTTL(const Value: integer);

begin
  FTTL := Value;
                                               
  Self.FTimeOut := Sys.DateTimeToStr(Sys.AddMSecToTime(Sys.Now,(Value * 1000)));
end;

function TIdTextModeResourceRecord.TextRecord(FullName: string): string;
begin

end;

{ TIdTextModeRRs }

constructor TIdTextModeRRs.Create;
begin
  inherited Create;
  Self.FItemNames := TIdStringList.Create;
end;

destructor TIdTextModeRRs.Destroy;
begin
  Self.FItemNames.Free;
  inherited;
end;

function TIdTextModeRRs.GetItem(Index: Integer): TIdTextModeResourceRecord;
begin
  Result := TIdTextModeResourceRecord(inherited GetItem(Index));
end;

procedure TIdTextModeRRs.SetItem(Index: Integer;
  const Value: TIdTextModeResourceRecord);
begin
  inherited SetItem(Index, Value);
end;

procedure TIdTextModeRRs.SetItemNames(const Value: TIdStrings);
begin
  FItemNames.Assign(Value);
end;

{ TIdRR_CName }

function TIdRR_CName.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName), 1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     
     RRData := DomainNameToDNSStr((Self.CName));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_CName))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_CName.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'CName'; {do not localize}
  Self.CName := '';
  Self.TypeCode := TypeCode_CName;
end;

function TIdRR_CName.GetCName: AnsiString;
begin
  Result := Self.GetValue('CName'); {do not localize}
end;

procedure TIdRR_CName.SetCName(const Value: AnsiString);
begin
  Self.RRDatas.Values['CName'] := Value;  {do not localize}
end;

function TIdRR_CName.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;

  Result := QName + Chr(9) + 'IN' + Chr(9) + 'CNAME' + Chr(9) + Self.CName + #13+#10; {do not localize}
end;

{ TIdRR_HINFO }

function TIdRR_HINFO.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName), 1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;

     RRData := NormalStrToDNSStr(Self.CPU);
     AppendBytes(RRData, NormalStrToDNSStr(Self.OS));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_HINFO))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_HINFO.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'HINFO'; {do not localize}
  Self.CPU := '';
  Self.OS := '';
  Self.TypeCode := TypeCode_HINFO;
end;

function TIdRR_HINFO.GetCPU: AnsiString;
begin
  Result := Self.RRDatas.Values['CPU']; {do not localize}
end;

function TIdRR_HINFO.GetOS: AnsiString;
begin
  Result := Self.RRDatas.Values['OS'];  {do not localize}
end;

procedure TIdRR_HINFO.SetCPU(const Value: AnsiString);
begin
  Self.RRDatas.Values['CPU'] := Value;  {do not localize}
end;

procedure TIdRR_HINFO.SetOS(const Value: AnsiString);
begin
  Self.RRDatas.Values['OS'] := Value; {do not localize}
end;

function TIdRR_HINFO.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'HINFO' + Chr(9) + '"' + Self.CPU + '" "' + Self.OS + '"' + #13+#10; {do not localize}
end;

{ TIdRR_MB }

function TIdRR_MB.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr((Self.MADName));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_MB))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_MB.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'MB';  {do not localize}
  Self.MADName := '';
  Self.TypeCode := TypeCode_MB;
end;

function TIdRR_MB.GetMADName: AnsiString;
begin
  Result := Self.RRDatas.Values['MADNAME']; {do not localize}
end;

procedure TIdRR_MB.SetMADName(const Value: AnsiString);
begin
  Self.RRDatas.Values['MADNAME'] := Value;  {do not localize}
end;

function TIdRR_MB.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'MB' + Chr(9) + Self.MADName + #13+#10;  {do not localize}
end;

{ TIdRR_MG }

function TIdRR_MG.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
        QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr((Self.MGMName));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word((TypeCode_MG)))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_MG.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'MG';  {do not localize}
  Self.MGMName := '';
  Self.TypeCode := TypeCode_MG;
end;

function TIdRR_MG.GetMGMName: AnsiString;
begin
  Result := Self.RRDatas.Values['MGMNAME']; {do not localize}
end;

procedure TIdRR_MG.SetMGMName(const Value: AnsiString);
begin
  Self.RRDatas.Values['MGMNAME'] := Value;  {do not localize}
end;

function TIdRR_MG.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'MG' + Chr(9) + Self.MGMName + #13+#10;  {do not localize}
end;

{ TIdRR_MINFO }

function TIdRR_MINFO.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: String;
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
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr(Self.Responsible_Mail);
     AppendBytes(RRData, DomainNameToDNSStr(Self.ErrorHandle_Mail));
                        
     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_MINFO))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal((Self.TTL)))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word((Length(RRData))))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_MINFO.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'MINFO'; {do not localize}
  Self.Responsible_Mail := '';
  Self.ErrorHandle_Mail := '';
  Self.TypeCode := TypeCode_MINFO;
end;

function TIdRR_MINFO.GetEMail: AnsiString;
begin
  Result := Self.RRDatas.Values['EMAILBX']; {do not localize}
end;

function TIdRR_MINFO.GetRMail: AnsiString;
begin
  Result := Self.RRDatas.Values['RMAILBX']; {do not localize}
end;

procedure TIdRR_MINFO.SetErrorHandle_Mail(const Value: AnsiString);
begin
  Self.RRDatas.Values['EMAILBX'] := Value;  {do not localize}
end;

procedure TIdRR_MINFO.SetResponsible_Mail(const Value: AnsiString);
begin
  Self.RRDatas.Values['RMAILBX'] := Value;  {do not localize}
end;

function TIdRR_MINFO.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'MINFO' + Chr(9) + Self.Responsible_Mail + ' ' + Self.ErrorHandle_Mail + #13+#10;  {do not localize}
end;

{ TIdRR_MR }

function TIdRR_MR.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr((Self.NewName));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_MR))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal((Self.TTL)))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_MR.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'MR';  {do not localize}
  Self.NewName := '';
  Self.TypeCode := TypeCode_MR;
end;

function TIdRR_MR.GetNewName: AnsiString;
begin
  Result := Self.RRDatas.Values['NewName']; {do not localize}
end;

procedure TIdRR_MR.SetNewName(const Value: AnsiString);
begin
  Self.RRDatas.Values['NewName'] := Value;  {do not localize}
end;

function TIdRR_MR.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'MR' + Chr(9) + Self.NewName + #13+#10;  {do not localize}
end;

{ TIdRR_MX }

function TIdRR_MX.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
   Pref : Word;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     Pref := Sys.StrToInt(Self.Preference);
     RRData := ToBytes(SmallInt(Pref));
     if Copy(Self.Exchange, Length(Self.Exchange),1) <> '.' then
     begin
        AppendBytes(RRData, DomainNameToDNSStr(Self.Exchange + '.' + FullName));
     end
     else
     begin
       AppendBytes(RRData, DomainNameToDNSStr((Self.Exchange)));
     end;
     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_MX))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal((Self.TTL)))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_MX.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'MX';  {do not localize}
  Self.Exchange := '';
  Self.TypeCode := TypeCode_MX;
end;

function TIdRR_MX.GetExchang: AnsiString;
begin
  Result := Self.RRDatas.Values['EXCHANGE'];  {do not localize}
end;

function TIdRR_MX.GetPref: AnsiString;
begin
  Result := Self.RRDatas.Values['PREF'];  {do not localize}
end;

procedure TIdRR_MX.SetExchange(const Value: AnsiString);
begin
  Self.RRDatas.Values['EXCHANGE'] := Value; {do not localize}
end;

procedure TIdRR_MX.SetPref(const Value: AnsiString);
begin
  Self.RRDatas.Values['PREF'] := Value; {do not localize}
end;

function TIdRR_MX.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'MX' + Chr(9) + Self.Preference + ' ' + Self.Exchange + #13+#10; {do not localize}
end;

{ TIdRR_NS }

function TIdRR_NS.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr((Self.NSDName));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_NS))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_NS.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'NS';  {do not localize}
  Self.NSDName := '';
  Self.TypeCode := TypeCode_NS;
end;

function TIdRR_NS.GetNS: AnsiString;
begin
  Result := Self.RRDatas.Values['NSDNAME']; {do not localize}
end;

procedure TIdRR_NS.SetNS(const Value: AnsiString);
begin
  Self.RRDatas.Values['NSDNAME'] := Value;  {do not localize}
end;

function TIdRR_NS.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'NS' + Chr(9) + Self.NSDName + #13+#10;  {do not localize}
end;

{ TIdRR_PTR }

function TIdRR_PTR.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := DomainNameToDNSStr(Self.PTRDName);

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_PTR))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_PTR.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'PTR'; {do not localize}
  Self.PTRDName := '';
  Self.TypeCode := TypeCode_PTR;
end;

function TIdRR_PTR.GetPTRName: AnsiString;
begin
  Result := Self.RRDatas.Values['PTRDNAME'];  {do not localize}
end;

procedure TIdRR_PTR.SetPTRName(const Value: AnsiString);
begin
  Self.RRDatas.Values['PTRDNAME'] := Value; {do not localize}
end;

function TIdRR_PTR.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'PTR' + Chr(9) + Self.PTRDName + #13+#10;  {do not localize}
end;

{ TIdRR_SOA }

function TIdRR_SOA.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;

     RRData := DomainNameToDNSStr((Self.MName));
     AppendBytes(RRData, DomainNameToDNSStr((Self.RName)));
     AppendBytes(RRData, ToBytes(GStack.HostToNetwork(Word(Sys.StrToInt(Self.Serial)))));
     AppendBytes(RRData, ToBytes(GStack.HostToNetwork(Word(Sys.StrToInt(Self.Refresh)))));
     AppendBytes(RRData, ToBytes(GStack.HostToNetwork(Word(Sys.StrToInt(Self.Retry)))));
     AppendBytes(RRData, ToBytes(GStack.HostToNetwork(Word(Sys.StrToInt(Self.Expire)))));
     AppendBytes(RRData, ToBytes(GStack.HostToNetwork(Word(Sys.StrToInt(Self.Minimum)))));

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_SOA))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_SOA.Create;
begin
  inherited;

  SetLength(FAnswer, 0);
  Self.RRName := 'SOA'; {do not localize}
  Self.TypeCode := TypeCode_SOA;

  Self.MName := '';
  Self.RName := '';
  Self.Serial := '';
  Self.Refresh := '';
  Self.Retry := '';
  Self.Expire := '';
  Self.Minimum := '';
end;

function TIdRR_SOA.GetExpire: AnsiString;
begin
  Result := Self.GetName('EXPIRE'); {do not localize}
end;

function TIdRR_SOA.GetMin: AnsiString;
begin
  Result := Self.GetName('MINIMUM');  {do not localize}
end;

function TIdRR_SOA.GetMName: AnsiString;
begin
  Result := Self.GetName('MNAME');  {do not localize}
end;

function TIdRR_SOA.GetName(CLabel: string): AnsiString;
begin
  Result := Self.RRDatas.Values[CLabel];
end;

function TIdRR_SOA.GetRefresh: AnsiString;
begin
  Result := Self.GetName('REFRESH');  {do not localize}
end;

function TIdRR_SOA.GetRetry: AnsiString;
begin
  Result := Self.GetName('RETRY');  {do not localize}
end;

function TIdRR_SOA.GetRName: AnsiString;
begin
  Result := Self.GetName('RNAME');  {do not localize}
end;

function TIdRR_SOA.GetSerial: AnsiString;
begin
  Result := Self.GetName('SERIAL'); {do not localize}
end;

procedure TIdRR_SOA.SetExpire(const Value: AnsiString);
begin
  Self.SetName('EXPIRE', Value);  {do not localize}
end;

procedure TIdRR_SOA.SetMin(const Value: AnsiString);
begin
  Self.SetName('MINIMUM', Value); {do not localize}
end;

procedure TIdRR_SOA.SetMName(const Value: AnsiString);
begin
  Self.SetName('MNAME', Value); {do not localize}
end;

procedure TIdRR_SOA.SetName(CLabel, Value: AnsiString);
begin
  Self.RRDatas.Values[CLabel] := Value;
end;

procedure TIdRR_SOA.SetRefresh(const Value: AnsiString);
begin
  Self.SetName('REFRESH', Value); {do not localize}
end;

procedure TIdRR_SOA.SetRetry(const Value: AnsiString);
begin
  Self.SetName('RETRY', Value); {do not localize}
end;

procedure TIdRR_SOA.SetRName(const Value: AnsiString);
begin
  Self.SetName('RNAME', Value); {do not localize}
end;

procedure TIdRR_SOA.SetSerial(const Value: AnsiString);
begin
  Self.SetName('SERIAL', Value);  {do not localize}
end;

function TIdRR_SOA.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'SOA' + Chr(9) +         {do not localize}
            Self.MName + ' ' + Self.RName + ' ' +
            Self.Serial + ' ' + Self.Refresh + ' ' + Self.Retry + ' '+
            Self.Expire + ' ' + Self.Minimum +
            #13+#10;
end;

{ TIdRR_A }

function TIdRR_A.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(Self.FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     RRData := IPAddrToDNSStr(Self.Address);

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_A))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
     AppendBytes(Result, RRData);

     Self.FAnswer := ToBytes(Result, Length(Result));
  end else begin
      SetLength(Result, 0);
      Result := ToBytes(Self.FAnswer, Length(Self.FAnswer));
  end;
end;

constructor TIdRR_A.Create;
begin
  inherited;
  SetLength(Self.FAnswer, 0);
  Self.RRName := 'A';   {do not localize}
  Self.Address := '';
  Self.TypeCode := TypeCode_A;
end;

function TIdRR_A.GetA: AnsiString;
begin
  Result := Self.RRDatas.Values['A']; {do not localize}
end;

procedure TIdRR_A.SetA(const Value: AnsiString);
begin
  Self.RRDatas.Values['A'] := Value;  {do not localize}
end;

function TIdRR_A.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'A' + Chr(9) + Self.Address + #13+#10; {do not localize}
end;

{ TIdRR_AAAA }

function TIdRR_AAAA.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(self.FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;

     RRData := IPv6AAAAToDNSStr(Self.Address);

     Result := DomainNameToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_AAAA))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(16))));
     AppendBytes(Result, RRData);

     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(Self.FAnswer, Length(Self.FAnswer));
  end;
end;

constructor TIdRR_AAAA.Create;
begin
inherited;
  SetLength(Self.FAnswer, 0);
  Self.RRName := 'AAAA';  {do not localize}
  Self.Address := '';
  Self.TypeCode := TypeCode_AAAA;
end;

function TIdRR_AAAA.GetA: AnsiString;
begin
  Result := Self.RRDatas.Values['AAAA'];  {do not localize}
end;

procedure TIdRR_AAAA.SetA(const Value: AnsiString);
begin
  Self.RRDatas.Values['AAAA'] := Value; {do not localize}
end;

function TIdRR_AAAA.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;
  Result := QName + Chr(9) + 'IN' + Chr(9) + 'AAAA' + Chr(9) + Self.Address + #13+#10;  {do not localize}

end;

{ TIdRR_TXT }

function TIdRR_TXT.BinQueryRecord(FullName: string): TIdBytes;
var
   QName: string;
   RRData: TIdBytes;
begin
  if Length(FAnswer) = 0 then begin
     SetLength(Result, 0);
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then
     begin
       QName := Self.RRName + '.' + FullName;
     end
     else
     begin
       QName := Self.RRName;
     end;
     Result := NormalStrToDNSStr((QName));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(TypeCode_TXT))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Class_IN))));
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Cardinal(Self.TTL))));
     RRData := NormalStrToDNSStr(Self.TXT);
     AppendBytes(Result, ToBytes(GStack.HostToNetwork(Word(Length(RRData)))));
                             //Fix here, make the RRData being DNSStr.
                             //Fixed in 2005 Jan 25.
     AppendBytes(Result, RRData);
     FAnswer := toBytes(Result, Length(Result));
  end else begin
      Result := toBytes(FAnswer, Length(FAnswer));
  end;
end;

constructor TIdRR_TXT.Create;
begin
  inherited;
  SetLength(Self.FAnswer, 0);
  Self.RRName := 'TXT'; {do not localize}
  Self.TXT := '';
  Self.TypeCode := TypeCode_TXT;
end;

function TIdRR_TXT.GetTXT: AnsiString;
begin
  Result := Self.RRDatas.Values['TXT']; {do not localize}
end;

procedure TIdRR_TXT.SetTXT(const Value: AnsiString);
begin
  Self.RRDatas.Values['TXT'] := Value;  {do not localize}
end;

function TIdRR_TXT.TextRecord(FullName: string): string;
var
   QName: string;
begin
  Result := '';
  QName := Self.RRName + '.';
  if QName <> FullName then begin
     if Copy(Self.RRName, Length(Self.RRName),1) <> '.' then begin
        QName := Self.RRName + '.' + FullName;
     end else begin
         QName := Self.RRName;
     end;
  end;

  if QName = FullName then
  begin
    QName := '@';
  end;

  Result := QName + Chr(9) + 'IN' + Chr(9) + 'TXT' + Chr(9) + '"' + Self.TXT + '"' + #13+#10; {do not localize}
end;

{ TIdRR_WKS }

constructor TIdRR_WKS.Create;
begin
  inherited;
  Self.RRName := 'WKS'; {do not localize}
  Self.TypeCode := TypeCode_WKS;
end;

{ TIdRR_Error }

constructor TIdRR_Error.Create;
begin
   inherited;

   Self.TypeCode := TypeCode_Error;
end;

function ReplaceSpecString(Source, Target, NewString : string; ReplaceAll : boolean = True) : string;
var
   FixingString, MiddleString, FixedString : string;
begin
   if Target = NewString then
   begin
     Result := Source;
   end
   else begin
        FixingString := Source;
        MiddleString := '';                     {do not localize}
        FixedString := '';                      {do not localize}

        if (IndyPos(Target, Source) > 0) then begin
           repeat
              MiddleString := Fetch(FixingString, Target);
              FixedString := FixedString + MiddleString + NewString;
           until (IndyPos(Target, FixingString) = 0) or (not ReplaceAll);
           FixedString := FixedString + FixingString;

           Result := FixedString;
        end else begin
            Result := Source;
        end;
   end;
end;

function IsBig5(ch1, ch2:char) : boolean;
begin
    if (not (((ch1 >= #161) and (ch1 <= #254)) or
           ((ch1 >= #142) and (ch1 <= #160)) or
           ((ch1 >= #129) and (ch1 <= #141))) ) or

       (not (((ch2 >= #64) and (ch2 <= #126)) or
           ((ch2 >= #161) and (ch2 <= #254))) ) then
    begin
       Result := False;
    end
    else
    begin
        Result := True;
    end;
end;

end.
