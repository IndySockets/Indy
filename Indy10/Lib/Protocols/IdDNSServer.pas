{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13802: IdDNSServer.pas
{
{   Rev 1.40    3/4/2005 12:35:32 PM  JPMugaas
{ Removed some compiler warnings.
}
{
{   Rev 1.39    2/9/2005 4:35:06 AM  JPMugaas
{ Should compile.
}
{
{   Rev 1.38    2/8/05 6:13:02 PM  RLebeau
{ Updated to use new AppendString() function in IdGlobal unit
{ 
{ Updated TIdDNS_ProcessThread.CompleteQuery() to use CopyTId...() functions
{ instead of ToBytes() and AppendBytes().
}
{
{   Rev 1.37    2005/1/25 下午 12:25:26  DChang
{ Modify UpdateTree method, make the NS record can be save in the lower level
{ node.
}
{
{   Rev 1.36    2005/1/5 下午 04:21:06  DChang    Version: 1.36
{ Fix parsing procedure while processing TXT record, in pass version, double
{ quota will not be processed, but now, any charector between 2 double quotas
{ will be treated as TXT message.
}
{
{   Rev 1.35    2004/12/15 下午 12:05:26  DChang    Version: 1.35
{ 1. Move UpdateTree to public section.
{ 2. add DoUDPRead of TIdDNSServer.
{ 3. Fix TIdDNS_ProcessThread.CompleteQuery and
{     InternalQuery to fit Indy 10 Core.
}
{
{   Rev 1.34    12/2/2004 4:23:50 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.33    2004.10.27 9:17:46 AM  czhower
{ For TIdStrings
}
{
{   Rev 1.32    10/26/2004 9:06:32 PM  JPMugaas
{ Updated references.
}
{
{   Rev 1.31    2004.10.26 1:06:26 PM  czhower
{ Further fixes for aliaser
}
{
{   Rev 1.30    2004.10.26 12:01:32 PM  czhower
{ Resolved alias conflict.
}
{
    Rev 1.29    9/15/2004 4:59:52 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.28    22/07/2004 18:14:22  ANeillans
{ Fixed compile error.
}
{
{   Rev 1.27    7/21/04 2:38:04 PM  RLebeau
{ Removed redundant string copying in TIdDNS_ProcessThread constructor and
{ procedure QueryDomain() method
{
{ Removed local variable from TIdDNS_ProcessThread.SendData(), not needed
}
{
{   Rev 1.26    2004/7/21 下午 06:37:48  DChang
{ Fix compile error in TIdDNS_ProcessThread.SendData, and mark a case statment
{ to comments in TIdDNS_ProcessThread.SaveToCache.
}
{
{   Rev 1.25    2004/7/19 下午 09:55:52  DChang
{ 1. Move all textmoderecords to IdDNSCommon.pas
{ 2.Making DNS Server load the domain definition file while DNS Server
{ component is active.
{ 3. Add a new event : OnAfterCacheSaved
{ 4. Add Full name condition to indicate if a domain is empty
{ (ConvertDNtoString)
{ 5. Make Query request processed with independent thread.
{ 6. Rewrite TIdDNSServer into multiple thread mode, all queries will search
{ and assemble the answer, and then share the TIdSocketHandle to send answer
{ back.
{ 7. Add version information in TIdDNSServer, so class CHAOS can be taken, but
{ only for the label : "version.bind.".
{ 8. Fix TIdRR_TXT.BinQueryRecord, to make sure it can be parsed in DNS client.
{ 9. Modify the AXFR function, reduce the response data size and quantity.
{ 10. Move all TIdTextModeResourceRecord and derived classes to IdDNSCommon.pas
}
{
{   Rev 1.24    7/8/04 11:43:54 PM  RLebeau
{ Updated TIdDNS_TCPServer.DoConnect() to use new BytesToString() parameters
}
{
{   Rev 1.23    7/7/04 1:45:16 PM  RLebeau
{ Compiler fixes
}
{
{   Rev 1.22    6/29/04 1:43:30 PM  RLebeau
{ Bug fixes for various property setters
}
{
{   Rev 1.21    2004.05.20 1:39:32 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.20    2004.03.01 9:37:06 PM  czhower
{ Fixed name conflicts for .net
}
{
{   Rev 1.19    2004.02.07 5:03:32 PM  czhower
{ .net fixes.
}
{
{   Rev 1.18    2/7/2004 5:39:44 AM  JPMugaas
{ IdDNSServer should compile in both DotNET and WIn32.
}
{
{   Rev 1.17    2004.02.03 5:45:58 PM  czhower
{ Name changes
}
{
{   Rev 1.16    1/22/2004 8:26:40 AM  JPMugaas
{ Ansi* calls changed.
}
{
{   Rev 1.15    1/21/2004 2:12:48 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.14    12/7/2003 8:07:26 PM  VVassiliev
{ string -> TIdBytes
}
{
{   Rev 1.13    2003.10.24 10:38:24 AM  czhower
{ UDP Server todos
}
{
    Rev 1.12    10/19/2003 12:16:30 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.11    2003.10.12 3:50:40 PM  czhower
{ Compile todos
}
{
{   Rev 1.10    2003/5/14 上午 01:17:36  DChang
{ Fix a flag named denoted in the function which check if a domain correct.
{ Update the logic of UpdateTree functions (make them unified).
{ Update the TextRecord function of all TIdRR_ classes, it checks if the RRName
{ the same as FullName, if RRName = FullName, it will not append the Fullname
{ to RRName.
}
{
{   Rev 1.9    2003/5/10 上午 01:09:42  DChang
{ Patch the domainlist update when axfr action.
}
{
{   Rev 1.8    2003/5/9 上午 10:03:36  DChang
{ Modify the sequence of records. To make sure when we resolve MX record, the
{ mail host A record can be additional record section.
}
{
{   Rev 1.7    2003/5/8 下午 08:11:34  DChang
{ Add TIdDNSMap, TIdDomainNameServerMapping to monitor primary DNS, and
{ detecting if the primary DNS record changed, it will update automatically if
{ necessary.
}
{
{   Rev 1.6    2003/5/2 下午 03:39:38  DChang
{ Fix all compile warnings and hints.
}
{
{   Rev 1.5    4/29/2003 08:26:30 PM  DenniesChang
{ Fix TIdDNSServer Create, the older version miss to create the FBindings.
{ fix AXFR procedure, fully support BIND 8 AXFR procedures.
}
{   Rev 1.4    4/28/2003 02:30:58 PM  JPMugaas
{ reverted back to the old one as the new one checked will not compile, has
{ problametic dependancies on Contrs and Dialogs (both not permitted).
}
{   Rev 1.3    04/28/2003 01:15:10 AM  DenniesChang
}
{
{   Rev 1.2    4/28/2003 07:00:18 AM  JPMugaas
{ Should now compile.
}
{
{   Rev 1.0    11/14/2002 02:18:42 PM  JPMugaas
}
{
  // Ver: 2003-04-28-0115
  // Combine TCP, UDP Tunnel into single TIdDNSServer component.
  // Update TIdDNSServer from TIdUDPServer to TComponent.

  // Ver: 2003-04-26-1810
  // Add AXFR command.

  // Ver: 2002-10-30-1253
  // Add TIdRR_AAAA class, RFC 1884 (Ipv6 AAAA)
  // and add the coresponding fix in TIdDNSServer, but left
  // external search option for future.

  // Ver: 2002-07-10-1610
  // Add a new event : OnAfterSendBack to handle all
  // data logged after query result is sent back to
  // the client.

  // Ver: 2002-05-27-0910
  // Add a check function in SOA loading function.

  // Ver: 2002-04-25-1530
  // IdDNSServer. Ver: 2002-03-12-0900


  // To-do: RFC 2136 Zone transfer must be implemented.


  // Add FindHandedNodeByName to pass the TIdDNTreeNode Object back.
  // Append a blank char when ClearQuota, to avoid the possible of
  //        losting a field.
  // Add IdDNTree.SaveToFile
  // Fix SOA RRName assignment.
  // Fix PTRName RRName assignment.
  // Fix TIdDNTreeNode RemoveChild

  // IdDNSServer. Ver: 2002-02-26-1420
  // Convert the DN Tree Node type, earlier verison just
  // store the A, PTR in the upper domain node, current
  // version save SOA and its subdomain in upper node.
  //
  // Moreover, move Cached_Tree, Handed_Tree to public
  // section, for using convinent.
  //
  // I forget return CName data, fixed.
  // Seperate the seaching of Cache and handled tree into 2
  // parts with a flag.


  //IdDNSServer. Ver: 2002-02-24-1715
  // Move TIdDNSServer protected property RootDNS_NET to public


  //IdDNSServer. Ver: 2002-02-23-1800

  Original Programmer: Dennies Chang <dennies@ms4.hinet.net>
  No Copyright. Code is given to the Indy Pit Crew.

  This DNS Server supports only IN record, but not Chaos system.
  Most of resource records in DNS server was stored with text mode,
  event the TREE structure, it's just for convininet.

  Why I did it with this way is tring to increase the speed for
  implementation, with Delphi/Kylix internal class and object,
  we can promise the compatible in Windows and Linux.

  Started: Jan. 20, 2002.
  First Finished: Feb. 23, 2002.

  RFC 1035 WKS record is not implemented.

  ToDO: Load Master File automaticlly when DNS Server Active.
  ToDO: patch WKS record data type.
  ToDO: prepare a Tree Editor for DNS Server Construction. (optional)
}
unit IdDNSServer;

interface

uses
    Classes,
    IdContainers,
    IdAssignedNumbers,
    IdSocketHandle,
    IdIOHandlerSocket,
    IdGlobal,
    IdGlobalProtocols,
    IdBaseComponent,
    IdComponent,
    IdContext,
    IdUDPBase, IdResourceStrings,
    IdExceptionCore,
    IdDNSResolver,
    IdUDPServer,
    IdCustomTCPServer,
    IdStackConsts,
    IdThread,
    IdDNSCommon,
    IdTStrings;

type
  TIdDomainExpireCheckThread = class (TIdThread)
  protected
    FInterval: Cardinal;
    FSender: TObject;
    FTimerEvent: TNotifyEvent;
    FBusy : boolean;
    FDomain : string;
    FHost : string;
    //
    procedure Run; override;
    procedure TimerEvent;
  end;


  // forward declaration.
  TIdDNSMap = class;
  TIdDNS_UDPServer = class;

  // This class is to record the mapping of Domain and its primary DNS IP
  TIdDomainNameServerMapping = class (TObject)
  private
    FHost: string;
    FDomainName: string;
    FBusy : boolean;
    FInterval: Cardinal;
    FList: TIdDNSMap;
    procedure SetHost(const Value: string);
    procedure SetInterval(const Value: Cardinal);
  protected
     CheckScheduler : TIdDomainExpireCheckThread;
     property Interval : Cardinal read FInterval write SetInterval;
     property List : TIdDNSMap read FList write FList;
  public
     constructor Create(List :TIdDNSMap);
     destructor Destroy; override;
  published
     procedure SyncAndUpdate (Sender : TObject);

     property Host : string read FHost write SetHost;
     property DomainName : string read FDomainName write FDomainName;
  end;

  TIdDNSMap = class (TIdObjectList)
  private
    FServer: TIdDNS_UDPServer;
    function GetItem(Index: Integer): TIdDomainNameServerMapping;
    procedure SetItem(Index: Integer;
      const Value: TIdDomainNameServerMapping);
    procedure SetServer(const Value: TIdDNS_UDPServer);
  public
    constructor Create(Server: TIdDNS_UDPServer);
    destructor Destroy; override;

    property Server : TIdDNS_UDPServer read FServer write SetServer;
    property Items[Index: Integer]: TIdDomainNameServerMapping read GetItem write SetItem; default;
  end;


  TIdMWayTreeNodeClass = class of TIdMWayTreeNode;
  TIdMWayTreeNode = class (TObject)
  private
    SubTree : TIdObjectList;
    FFundmentalClass: TIdMWayTreeNodeClass;
    function GetTreeNode(Index: integer): TIdMWayTreeNode;
    procedure SetFundmentalClass(const Value: TIdMWayTreeNodeClass);
    procedure SetTreeNode(Index: integer; const Value: TIdMWayTreeNode);
  public
    constructor Create(NodeClass : TIdMWayTreeNodeClass);  virtual;
    destructor Destroy; override;
    property FundmentalClass : TIdMWayTreeNodeClass read FFundmentalClass write SetFundmentalClass;
    property Children[Index : integer] : TIdMWayTreeNode read GetTreeNode write SetTreeNode;
    function AddChild : TIdMWayTreeNode;
    function InsertChild(Index : integer) : TIdMWayTreeNode;
    procedure RemoveChild(Index : integer);
  end;


  TIdDNTreeNode = class (TIdMWayTreeNode)
  private
    FCLabel : AnsiString;
    FRRs: TIdTextModeRRs;
    FChildIndex: TStrings;
    FParentNode: TIdDNTreeNode;
    FAutoSortChild: boolean;
    procedure SetCLabel(const Value: AnsiString);
    procedure SetRRs(const Value: TIdTextModeRRs);
    function GetNode(Index: integer): TIdDNTreeNode;
    procedure SetNode(Index: integer; const Value: TIdDNTreeNode);
    procedure SetChildIndex(const Value: TStrings);
    function GetFullName: string;
    function ConvertToDNString : string;
    function DumpAllBinaryData(var RecordCount:integer) : TIdBytes;
  public
    property ParentNode : TIdDNTreeNode read FParentNode write FParentNode;
    property CLabel : AnsiString read FCLabel write SetCLabel;
    property RRs : TIdTextModeRRs read FRRs write SetRRs;
    property Children[Index : integer] : TIdDNTreeNode read GetNode write SetNode;
    property ChildIndex : TStrings read FChildIndex write SetChildIndex;
    property AutoSortChild : boolean read FAutoSortChild write FAutoSortChild;
    property FullName : string read GetFullName;

    constructor Create(ParentNode : TIdDNTreeNode); reintroduce;
    destructor Destroy; override;
    function AddChild : TIdDNTreeNode;
    function InsertChild(Index : integer) : TIdDNTreeNode;
    procedure RemoveChild(Index : integer);
    procedure SortChildren;
    procedure Clear;
    procedure SaveToFile(Filename : String);
    function IndexByLabel(CLabel : AnsiString): integer;
    function IndexByNode(ANode : TIdDNTreeNode) : integer;
  end;

  TIdDNS_TCPServer = class (TIdCustomTCPServer)
  protected
    FAccessList: TIdStrings;
    FAccessControl: boolean;
    //
    procedure DoConnect(AThread: TIdContext); override;
    procedure InitComponent; override;
    procedure SetAccessList(const Value: TIdStrings);
  public
    destructor Destroy; override;
  published
    property AccessList : TIdStrings read FAccessList write SetAccessList;
    property AccessControl : boolean read FAccessControl write FAccessControl;
  end;

  TIdDNS_ProcessThread = class (TIdThread)
  protected
    FMyBinding: TIdSocketHandle;
    FMainBinding: TIdSocketHandle;
    FMyData: TStream;
    FData : string;
    FDataSize : integer;
    FServer: TIdDNS_UDPServer;
    procedure SetMyBinding(const Value: TIdSocketHandle);
    procedure SetMyData(const Value: TStream);
    procedure SetServer(const Value: TIdDNS_UDPServer);
    procedure ComposeErrorResult(var Final: TIdBytes;
              OriginalHeader: TDNSHeader; OriginalQuestion : TIdBytes;
              ErrorStatus: integer);
    function CombineAnswer(Header : TDNSHeader; EQuery, Answer : TIdBytes): TIdBytes;
    procedure InternalSearch(Header: TDNSHeader; QName: string; QType: Word;
      var Answer: TIdBytes; IfMainQuestion: boolean; IsSearchCache: boolean = false;
      IsAdditional: boolean = false; IsWildCard : boolean = false;
      WildCardOrgName: string = '');
    procedure ExternalSearch(aDNSResolver: TIdDNSResolver; Header: TDNSHeader;
      Question: TIdBytes; var Answer: TIdBytes);
    function CompleteQuery(DNSHeader: TDNSHeader; Question: string;
      OriginalQuestion: TIdBytes; var Answer : TIdBytes; QType, QClass : word;
      DNSResolver : TIdDNSResolver) : string;
    procedure SaveToCache(ResourceRecord : string; QueryName : string; OriginalQType : Word);
    function SearchTree(Root : TIdDNTreeNode; QName : String; QType : Word): TIdDNTreeNode;

    procedure Run; override;
    procedure QueryDomain;
    procedure SendData;
  public
     property MyBinding : TIdSocketHandle read FMyBinding write SetMyBinding;
     property MyData: TStream read FMyData write SetMyData;
     property Server : TIdDNS_UDPServer read FServer write SetServer;

     constructor Create(ACreateSuspended: Boolean = True;
                 Data : String = ''; DataSize : integer = 0;
                 MainBinding : TIdSocketHandle = nil;
                 Binding : TIdSocketHandle = nil;
                 Server : TIdDNS_UDPServer = nil); reintroduce; overload;
     destructor Destroy; override;
  end;

  TIdDNSBeforeQueryEvent = procedure(ABinding: TIdSocketHandle;
   ADNSHeader: TDNSHeader; var ADNSQuery: string) of object;
  TIdDNSAfterQueryEvent = procedure(ABinding: TIdSocketHandle;
   ADNSHeader: TDNSHeader; var QueryResult: string; ResultCode: string;
   Query : string) of object;
  TIdDNSAfterCacheSaved = procedure(CacheRoot : TIdDNTreeNode) of object;

  TIdDNS_UDPServer = class (TIdUDPServer)
  private
    FBusy: boolean;
  protected
    FAutoUpdateZoneInfo: boolean;
    FZoneMasterFiles: TIdStrings;
    FRootDNS_NET: TIdStrings;
    FCacheUnknowZone: boolean;
    FCached_Tree: TIdDNTreeNode;
    FHanded_Tree: TIdDNTreeNode;
    FHanded_DomainList: TIdStrings;
    FAutoLoadMasterFile: Boolean;
    FOnAfterQuery: TIdDNSAfterQueryEvent;
    FOnBeforeQuery: TIdDNSBeforeQueryEvent;
    FCS: TIdCriticalSection;
    FOnAfterSendBack: TIdDNSAfterQueryEvent;
    FOnAfterCacheSaved: TIdDNSAfterCacheSaved;
    FGlobalCS: TIdCriticalSection;
    FDNSVersion: string;
    FofferDNSVersion: boolean;

    procedure DoBeforeQuery(ABinding: TIdSocketHandle;
              ADNSHeader: TDNSHeader; var ADNSQuery : String); dynamic;

    procedure DoAfterQuery(ABinding: TIdSocketHandle;
              ADNSHeader: TDNSHeader; var QueryResult : String;
              ResultCode : String; Query : string); dynamic;

    procedure DoAfterSendBack(ABinding: TIdSocketHandle;
              ADNSHeader: TDNSHeader; var QueryResult : String;
              ResultCode : String; Query : string); dynamic;

    procedure DoAfterCacheSaved(CacheRoot : TIdDNTreeNode); dynamic;

    procedure SetZoneMasterFiles(const Value: TIdStrings);
    procedure SetRootDNS_NET(const Value: TIdStrings);
    procedure SetHanded_DomainList(const Value: TIdStrings);
    procedure InternalSearch(Header: TDNSHeader; QName: string; QType: Word;
      var Answer: TIdBytes; IfMainQuestion: boolean; IsSearchCache: boolean = false;
      IsAdditional: boolean = false; IsWildCard : boolean = false;
      WildCardOrgName: string = '');
    procedure ExternalSearch(aDNSResolver: TIdDNSResolver; Header: TDNSHeader;
      Question: TIdBytes; var Answer: TIdBytes);
    //modified in May 2004 by Dennies Chang.
    //procedure SaveToCache(ResourceRecord : string);
    procedure SaveToCache(ResourceRecord : string; QueryName : string; OriginalQType : Word);
    //procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TResultRecord); overload;
    //MoveTo Public section for RaidenDNSD.

    procedure InitComponent; override;
    // Hide this property temporily, this property is prepared to maintain the
    // TTL expired record auto updated;
    property AutoUpdateZoneInfo : boolean read FAutoUpdateZoneInfo write FAutoUpdateZoneInfo;
    property CS: TIdCriticalSection read FCS;
    //procedure DoUDPRead(AData: TStream; ABinding: TIdSocketHandle); override;
    procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
  public
    destructor Destroy; override;
    function AXFR(Header : TDNSHeader; Question : string; var Answer :TIdBytes) : string;
    function CompleteQuery(DNSHeader: TDNSHeader; Question: string;
      OriginalQuestion: TIdBytes; var Answer : TIdBytes; QType, QClass : word;
      DNSResolver : TIdDNSResolver) : string;
    function LoadZoneFromMasterFile(MasterFileName : String) : boolean;
    function LoadZoneStrings(FileStrings: TIdStrings; Filename : String;
             TreeRoot : TIdDNTreeNode): boolean;
    function SearchTree(Root : TIdDNTreeNode; QName : String; QType : Word): TIdDNTreeNode;
    procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TIdTextModeResourceRecord); overload;
    function FindNodeFullName(Root : TIdDNTreeNode; QName : String; QType : Word) : string;
    function FindHandedNodeByName(QName : String; QType : Word) : TIdDNTreeNode;
    procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TResultRecord); overload;

    property RootDNS_NET : TIdStrings read FRootDNS_NET write SetRootDNS_NET;
    property Cached_Tree : TIdDNTreeNode read FCached_Tree {write SetCached_Tree};
    property Handed_Tree : TIdDNTreeNode read FHanded_Tree {write SetHanded_Tree};
    property Busy : boolean read FBusy;
    property GlobalCS : TIdCriticalSection read FGlobalCS;
  published
    property DefaultPort default IdPORT_DOMAIN;
    property AutoLoadMasterFile : Boolean read FAutoLoadMasterFile write FAutoLoadMasterFile Default False;

    //property AutoUpdateZoneInfo : boolean read FAutoUpdateZoneInfo write SetAutoUpdateZoneInfo;
    property ZoneMasterFiles : TIdStrings read FZoneMasterFiles write SetZoneMasterFiles;
    property CacheUnknowZone : boolean read FCacheUnknowZone write FCacheUnknowZone default False;
    property Handed_DomainList : TIdStrings read FHanded_DomainList write SetHanded_DomainList;
    property DNSVersion : string read FDNSVersion write FDNSVersion;
    property offerDNSVersion : boolean read FofferDNSVersion write FofferDNSVersion;

    property OnBeforeQuery : TIdDNSBeforeQueryEvent read FOnBeforeQuery write FOnBeforeQuery;
    property OnAfterQuery :TIdDNSAfterQueryEvent read FOnAfterQuery write FOnAfterQuery;
    property OnAfterSendBack :TIdDNSAfterQueryEvent read FOnAfterSendBack write FOnAfterSendBack;
    property OnAfterCacheSaved : TIdDNSAfterCacheSaved read FOnAfterCacheSaved write FOnAfterCacheSaved;
  end;


  TIdDNSServer = class (TIdComponent)
  protected
    FActive: boolean;
    FTCPACLActive: boolean;
    FServerType: TDNSServerTypes;
    FTCPTunnel: TIdDNS_TCPServer;
    FUDPTunnel: TIdDNS_UDPServer;
    FAccessList: TIdStrings;
    FBindings: TIdSocketHandles;
    procedure SetAccessList(const Value: TIdStrings);
    procedure SetActive(const Value: boolean);
    procedure SetTCPACLActive(const Value: boolean);
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure TimeToUpdateNodeData(Sender : TObject);
    procedure InitComponent; override;
  public
     BackupDNSMap : TIdDNSMap;

     destructor Destroy; override;
     procedure CheckIfExpire(Sender: TObject);
  published
     property Active : boolean read FActive write SetActive;
     property AccessList : TIdStrings read FAccessList write SetAccessList;
     property Bindings: TIdSocketHandles read FBindings write SetBindings;

     property TCPACLActive : boolean read FTCPACLActive write SetTCPACLActive;
     property ServerType: TDNSServerTypes read FServerType write FServerType;
     property TCPTunnel : TIdDNS_TCPServer read FTCPTunnel write FTCPTunnel;
     property UDPTunnel : TIdDNS_UDPServer read FUDPTunnel write FUDPTunnel;
  end;


  // CompareItems is to compare TIdDNTreeNode
  function CompareItems(Item1, Item2: TObject): Integer;
function FetchBytes(var AInput: TIdBytes; const ADelim: TIdBytes;
  const ADelete: Boolean = IdFetchDeleteDefault): TIdBytes;
function PosBytes(const SubBytes, SBytes: TIdBytes): integer;
function SameArray(const B1, B2: TIdBytes): boolean;

implementation

uses
  IdIOHandler, IdStack, IdSys;

{Common Utilities}
function CompareItems(Item1, Item2: TObject): Integer;
var LObj1, LObj2 : TIdDNTreeNode;
begin
  LObj1 := Item1 as TIdDNTreeNode;
  LObj2 := Item2 as TIdDNTreeNode;
  Result := Sys.CompareStr((LObj1 as TIdDNTreeNode).CLabel, (LObj2 as TIdDNTreeNode).CLabel);
end;

function SameArray(const B1, B2: TIdBytes): boolean;
var
  i, l1: integer;
begin
  Result := False;
  l1 := Length(B1);
  if l1 <> Length(B2) then
    Exit; //Different length
  for i := 0 to l1 - 1 do
  begin
    if B1[i] <> B2[i] then
      Exit;
  end;
  Result := True;
end;

function PosBytes(const SubBytes, SBytes: TIdBytes): integer;
var
  i, l: integer;
begin
  Result := -1;
  l := Length(SubBytes);
  for i := 0 to Length(SBytes) - l do
  begin
    if SameArray(SubBytes, copy(SBytes, i, l)) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;


function FetchBytes(var AInput: TIdBytes; const ADelim: TIdBytes;
  const ADelete: Boolean = IdFetchDeleteDefault): TIdBytes;
var
  LPos: integer;
begin
  LPos := PosBytes(ADelim, AInput);
  if LPos = -1 then begin
    Result := AInput;
    if ADelete then begin
      SetLength(AInput, 0);
    end;
  end
  else begin
    Result := Copy(AInput, 0, LPos);
    if ADelete then begin
      //slower Delete(AInput, 1, LPos + Length(ADelim) - 1);
      AInput:=Copy(AInput, LPos + Length(ADelim), MaxInt);
    end;
  end;
end;



{ TIdMWayTreeNode }

function TIdMWayTreeNode.AddChild: TIdMWayTreeNode;
begin
  Result := Self.FundmentalClass.Create(FundmentalClass);
  Self.SubTree.Add(Result);
end;

constructor TIdMWayTreeNode.Create(NodeClass : TIdMWayTreeNodeClass);
begin
   inherited Create;
   Self.FundmentalClass := NodeClass;
   Self.SubTree := TIdObjectList.Create;
end;

destructor TIdMWayTreeNode.Destroy;
begin
  SubTree.Free;
  inherited;
end;

function TIdMWayTreeNode.GetTreeNode(Index: integer): TIdMWayTreeNode;
begin
  Result := TIdMWayTreeNode(Self.SubTree.Items[Index]);
end;

function TIdMWayTreeNode.InsertChild(Index: integer): TIdMWayTreeNode;
begin
  Result := Self.FundmentalClass.Create(FundmentalClass);
  Self.SubTree.Insert(Index, Result);
end;

procedure TIdMWayTreeNode.RemoveChild(Index: integer);
begin
  Self.SubTree.Remove(SubTree.Items[Index]);
end;

procedure TIdMWayTreeNode.SetFundmentalClass(
  const Value: TIdMWayTreeNodeClass);
begin
  FFundmentalClass := Value;
end;

procedure TIdMWayTreeNode.SetTreeNode(Index: integer;
  const Value: TIdMWayTreeNode);
begin
  Self.SubTree.Items[Index] := Value;
end;

{ TIdDNTreeNode }

function TIdDNTreeNode.AddChild: TIdDNTreeNode;
begin
  Result := TIdDNTreeNode.Create(Self);
  Self.SubTree.Add(Result);
end;

procedure TIdDNTreeNode.Clear;
var
   Stop, Start : integer;
begin
   Start := Self.SubTree.Count - 1;
   for Stop := Start downto 0 do begin
       Self.RemoveChild(Stop);
   end;
end;

function TIdDNTreeNode.ConvertToDNString: string;
var
   Count : integer;
   MyString, ChildString : string;
begin
   ChildString := '';
   MyString := '';

   MyString := '$ORIGIN ' + Self.FullName + #13+#10;  {do not localize}
   for Count := 0 to Self.RRs.Count -1 do begin
       MyString := MyString + Self.RRs.Items[Count].TextRecord(Self.FullName);
   end;

   for Count := 0 to Self.FChildIndex.Count -1 do begin
       ChildString := ChildString + Self.Children[Count].ConvertToDNString;
   end;

   Result := MyString + ChildString;
end;

constructor TIdDNTreeNode.Create(ParentNode : TIdDNTreeNode);
begin
  Inherited Create(TIdDNTreeNode);
  Self.FRRs := TIdTextModeRRs.Create;
  Self.FChildIndex := TIdStringList.Create;
  Self.ParentNode := ParentNode;
end;

destructor TIdDNTreeNode.Destroy;
begin
  Self.FRRs.Free;
  Self.FChildIndex.Free;
  inherited;
end;

function TIdDNTreeNode.DumpAllBinaryData(var RecordCount:integer): TIdBytes;
var
  Count, ChildCount : integer;
  MyString, ChildString : TIdBytes;
begin
  SetLength(ChildString, 0);
  SetLength(MyString, 0);
  RecordCount := RecordCount + RRs.Count + 1;

  for Count := 0 to RRs.Count -1 do
  begin
    AppendBytes(MyString, RRs.Items[Count].BinQueryRecord(FullName));
  end;

  for Count := 0 to FChildIndex.Count -1 do
  begin
    AppendBytes(ChildString, Children[Count].DumpAllBinaryData(ChildCount));
    RecordCount := RecordCount + ChildCount;
  end;

  if RRs.Count > 0 then
  begin
    if (RRs.Items[0] is TIdRR_SOA) then
    begin
       RecordCount := RecordCount + 1;
       AppendBytes(MyString, RRs.Items[0].BinQueryRecord(FullName));
    end;
  end;

  Result := MyString;
  AppendBytes(Result, ChildString);
  AppendBytes(Result, RRs.Items[0].BinQueryRecord(FullName));
end;

function TIdDNTreeNode.GetFullName: string;
begin
  if Self.ParentNode = nil then
     if Self.CLabel = '.' then
        Result := ''
     else
         Result := Self.CLabel
  else
      Result := Self.CLabel + '.' +Self.ParentNode.FullName;
end;

function TIdDNTreeNode.GetNode(Index: integer): TIdDNTreeNode;
begin
  Result := TIdDNTreeNode(Self.SubTree.Items[Index]);
end;

function TIdDNTreeNode.IndexByLabel(CLabel: AnsiString): integer;
begin
  Result := Self.FChildIndex.IndexOf(CLabel);
end;

function TIdDNTreeNode.IndexByNode(ANode: TIdDNTreeNode): integer;
begin
  Result := Self.SubTree.IndexOf(ANode);
end;

function TIdDNTreeNode.InsertChild(Index: integer): TIdDNTreeNode;
begin
  Result := TIdDNTreeNode.Create(Self);
  Self.SubTree.Insert(Index, Result);
end;

procedure TIdDNTreeNode.RemoveChild(Index: integer);
begin
  Self.SubTree.Remove(Self.SubTree.Items[Index]);
  Self.FChildIndex.Delete(Index);
end;

procedure TIdDNTreeNode.SaveToFile(Filename: String);
var
  DNSs : TIdStrings;
begin
  DNSs := TIdStringList.Create;
  try
    DNSs.Add(Self.ConvertToDNString);
    DNSs.SaveToFile(Filename);
  finally
    DNSs.Free;
  end;
end;

procedure TIdDNTreeNode.SetChildIndex(const Value: TStrings);
begin
  Self.FChildIndex.Assign(Value);
end;

procedure TIdDNTreeNode.SetCLabel(const Value: AnsiString);
begin
  FCLabel := Value;
  if Self.ParentNode <> nil then
     Self.ParentNode.ChildIndex.Insert(ParentNode.SubTree.IndexOf(Self), Value);
  if Self.AutoSortChild then Self.SortChildren;
end;

procedure TIdDNTreeNode.SetNode(Index: integer;
  const Value: TIdDNTreeNode);
begin
  Self.SubTree.Items[Index] := Value;
end;

procedure TIdDNTreeNode.SetRRs(const Value: TIdTextModeRRs);
begin
  FRRs.Assign(Value);
end;

procedure TIdDNTreeNode.SortChildren;
begin
  Self.SubTree.BubbleSort(CompareItems);
  TStringList(Self.FChildIndex).Sort;
end;



{ TIdDNSServer }

function TIdDNS_UDPServer.CompleteQuery(DNSHeader : TDNSHeader; Question: string;
  OriginalQuestion: TIdBytes; var Answer: TIdBytes; QType, QClass: word;
  DNSResolver : TIdDNSResolver): string;
var
   IsMyDomains : boolean;
   lAnswer: TIdBytes;
   WildQuestion, TempDomain : string;
begin
  // QClass = 1  => IN, we support only "IN" class now.
  // QClass = 2  => CS,
  // QClass = 3  => CH,
  // QClass = 4  => HS.

        TempDomain := IndyLowerCase(Question);
        IsMyDomains := (Self.Handed_DomainList.IndexOf(TempDomain) > -1);
        if not IsMyDomains then
        begin
          Fetch(TempDomain, '.');
        end;
        IsMyDomains := (Self.Handed_DomainList.IndexOf(TempDomain) > -1);

  if (QClass = 1) then begin
      if IsMyDomains then begin

        Self.InternalSearch(DNSHeader, Question, QType, lAnswer, True, False, False);
        Answer := lAnswer;

        if ((QType = TypeCode_A) or (QType = TypeCode_AAAA)) and
           (Length(Answer) = 0) then begin
           Self.InternalSearch(DNSHeader, Question, TypeCode_CNAME, lAnswer, True, False, True);
           AppendBytes(Answer, lAnswer);
        end;

        //if lAnswer = '' then begin
           WildQuestion := Question;
           fetch(WildQuestion, '.');
           WildQuestion := '*.' + WildQuestion;
           Self.InternalSearch(DNSHeader, WildQuestion, QType, lAnswer, True, False, False, true, Question);
           AppendBytes(Answer, lAnswer);
        //end;

        if Length(Answer) > 0 then
          Result := cRCodeQueryOK
        else Result := cRCodeQueryNotFound;
      end else begin
          Self.InternalSearch(DNSHeader, Question, QType, Answer, True, True, False);

          if ((QType = TypeCode_A) or (QType = TypeCode_AAAA)) and
              (Length(Answer) = 0) then begin
              Self.InternalSearch(DNSHeader, Question, TypeCode_CNAME, lAnswer, True, True, False);
              AppendBytes(Answer, lAnswer);
          end;

          if Length(Answer) > 0 then
            Result := cRCodeQueryCacheOK
          else begin
               QType := TypeCode_Error;

               Self.InternalSearch(DNSHeader, Question, QType, Answer, True, True, False);
               if BytesToString(Answer) = 'Error' then begin {do not localize}
                  Result := cRCodeQueryCacheFindError;
               end else begin
                   Self.ExternalSearch(DNSResolver, DNSHeader, OriginalQuestion, Answer);

                   if Length(Answer) > 0 then
                      Result := cRCodeQueryReturned
                   else Result := cRCodeQueryNotImplement;
               end;
          end;
      end
  end else begin
      Result := cRCodeQueryNotImplement;
  end;
end;

procedure TIdDNS_UDPServer.InitComponent;
begin
  inherited;

  Self.FRootDNS_NET := TIdStringList.Create;
  Self.FRootDNS_NET.Add('209.92.33.150'); // nic.net         {do not localize}
  Self.FRootDNS_NET.Add('209.92.33.130'); // nic.net         {do not localize}
  Self.FRootDNS_NET.Add('203.37.255.97'); // apnic.net       {do not localize}
  Self.FRootDNS_NET.Add('202.12.29.131'); // apnic.net       {do not localize}
  Self.FRootDNS_NET.Add('12.29.20.2');    // nanic.net       {do not localize}
  Self.FRootDNS_NET.Add('204.145.119.2'); // nanic.net       {do not localize}
  Self.FRootDNS_NET.Add('140.111.1.2');   // a.twnic.net.tw  {do not localize}

  Self.FCached_Tree := TIdDNTreeNode.Create(nil);
  Self.FCached_Tree.AutoSortChild := True;
  Self.FCached_Tree.CLabel := '.';

  Self.FHanded_Tree := TIdDNTreeNode.Create(nil);
  Self.FHanded_Tree.AutoSortChild := True;
  Self.FHanded_Tree.CLabel := '.';

  Self.FHanded_DomainList := TIdStringList.Create;
  Self.FZoneMasterFiles := TIdStringList.Create;

  DefaultPort := IdPORT_DOMAIN;
  Self.FCS := TIdCriticalSection.Create;
  Self.FGlobalCS := TIdCriticalSection.Create;
  Self.FBusy := False;
end;

destructor TIdDNS_UDPServer.Destroy;
begin
  Self.FCached_Tree.Free;
  Self.FHanded_Tree.Free;
  Self.FRootDNS_NET.Free;
  Self.FHanded_DomainList.Free;
  Self.FZoneMasterFiles.Free;
  Self.FCS.Free;
  Self.FGlobalCS.Free;
  inherited;
end;

procedure TIdDNS_UDPServer.DoAfterQuery(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var QueryResult: String; ResultCode : String;
  Query : string);
begin
   if Assigned(FOnAfterQuery) then begin
      FOnAfterQuery(ABinding, ADNSHeader, QueryResult, ResultCode, Query);
   end;
end;

procedure TIdDNS_UDPServer.DoBeforeQuery(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var ADNSQuery: String);
begin
   if Assigned(FOnBeforeQuery) then begin
      FOnBeforeQuery(ABinding, ADNSHeader, ADNSQuery);
   end;
end;

(*procedure TIdDNS_UDPServer.DoUDPRead(AData: TStream;
  ABinding: TIdSocketHandle);
var
   ExternalQuery, QName, QLabel, Answer, RString, FinalResult : string;
   DNSHeader_Processing : TDNSHeader;
   QType, QClass : Word;
   QPos, QLength, LLength : integer;
   DNSResolver : TIdDNSResolver;
begin
  inherited DoUDPRead(AData, ABinding);

  //Self.CS.Acquire;

  SetLength(ExternalQuery, AData.Size);
  AData.Read(ExternalQuery[1], AData.Size);
  FinalResult := '';
  if AData.Size >= 12 then begin
     DNSHeader_Processing := TDNSHeader.Create;

     DNSResolver := TIdDNSResolver.Create(Self);
     DNSResolver.WaitingTime := 10000;
     try
        if DNSHeader_Processing.ParseQuery(ExternalQuery) <> 0 then begin
           //FinalResult := ComposeErrorResult
           DoAfterQuery(ABinding, DNSHeader_Processing, FinalResult, RString, ExternalQuery)
        end else begin
            if DNSHeader_Processing.QDCount > 0 then begin
               QPos := 13;
               QLength := Length(ExternalQuery);
               if (QLength > 12) then begin
                  QName := '';
                  repeat
                    Answer := '';
                    LLength := Byte(ExternalQuery[QPos]);
                    Inc(QPos);
                    QLabel := Copy(ExternalQuery, QPos, LLength);
                    Inc(QPos, LLength);

                    if QName <> '' then
                       QName := QName + QLabel + '.'
                    else
                        QName := QLabel + '.';
                  until ((QPos >= QLength) or (ExternalQuery[QPos] = #0));
                  //HD_QDPos := QPos;
                  Inc(QPos);

                  QType := TwoCharToWord(ExternalQuery[QPos], ExternalQuery[QPos + 1]);
                  Inc(QPos, 2);
                  QClass := TwoCharToWord(ExternalQuery[QPos], ExternalQuery[QPos + 1]);

                  DoBeforeQuery(ABinding, DNSHeader_Processing, ExternalQuery);

                  RString := Self.CompleteQuery(DNSHeader_Processing, QName, ExternalQuery, Answer, QType, QClass, DNSResolver);

                  if RString = cRCodeQueryNotImplement then begin
                     ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotImplement);
                  end else begin
                      if (RString = cRCodeQueryReturned) then
                         FinalResult := Answer
                      else begin
                           if (RString = cRCodeQueryNotFound) then
                              ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotFound)
                           else
                               FinalResult := CombineAnswer(DNSHeader_Processing, ExternalQuery, Answer);
                      end;
                  end;

                  DoAfterQuery(ABinding, DNSHeader_Processing, FinalResult, RString, ExternalQuery);
               end;
            end;
        end;
     finally
            try
               //Self.SendBuffer(ABinding.PeerIP, ABinding.Port, FinalResult[1], length(FinalResult));
               with ABinding do begin
                 SendTo(PeerIP, PeerPort, FinalResult[1], length(FinalResult));
               end;

               DoAfterSendBack(ABinding, DNSHeader_Processing, FinalResult, RString, ExternalQuery);

               if (((Self.CacheUnknowZone) and (RString = cRCodeQueryReturned)) or
                   (RString = cRCodeQueryCacheOK)) then
                   Self.SaveToCache(FinalResult);
            finally
               DNSResolver.Free;
               DNSHeader_Processing.Free;
            end;
     end;
  end;

  //Self.CS.Release;
end;
  *)
procedure TIdDNS_UDPServer.ExternalSearch(aDNSResolver : TIdDNSResolver;
  Header: TDNSHeader; Question: TIdBytes; var Answer: TIdBytes);
var
  Server_Index : integer;
  MyDNSResolver : TIdDNSResolver;
begin
  Server_Index := 0;
  if (aDNSResolver = nil) then
  begin
     MyDNSResolver := TIdDNSResolver.Create(Self);
     MyDNSResolver.WaitingTime := 5000;
  end else
  begin
      MyDNSResolver := aDNSResolver;
  end;

  repeat
    MyDNSResolver.Host := Self.RootDNS_NET.Strings[Server_Index];
    try
      MyDNSResolver.InternalQuery := Question;
      MyDNSResolver.Resolve('');
      Answer := MyDNSResolver.PlainTextResult;
    except
      // Todo: Create DNS server interal resolver error.
      on EIdDnsResolverError do
      begin
        //Empty Event, for user to custom the event handle.
      end;
      on EIdSocketError do
      begin
      end;

      else
      begin
      end;
    end;

    Inc(Server_Index);
  until ((Server_Index >= Self.RootDNS_NET.Count) or (Length(Answer) > 0));

  if (aDNSResolver = nil) then
  begin
     MyDNSResolver.Free
  end;
end;

function TIdDNS_UDPServer.FindHandedNodeByName(QName: String;
  QType: Word): TIdDNTreeNode;
begin
   Result := Self.SearchTree(Self.Handed_Tree, QName, QType);
end;

function TIdDNS_UDPServer.FindNodeFullName(Root: TIdDNTreeNode;
  QName: String; QType : Word): string;
var
   MyNode : TIdDNTreeNode;
begin
   MyNode := Self.SearchTree(Root, QName, QType);
   if MyNode = nil then Result := ''
   else begin
        Result := MyNode.FullName;
   end;
end;

function TIdDNS_UDPServer.LoadZoneFromMasterFile(
  MasterFileName: String): boolean;
var
   FileStrings : TIdStrings;
begin
   {MakeTagList;}
   Result := Sys.FileExists(MasterFileName);

   if Result then begin
      FileStrings := TIdStringList.Create;
      FileStrings.LoadFromFile(MasterFileName);
      Result := LoadZoneStrings(FileStrings, MasterFileName, Self.Handed_Tree);
      {
      Result := IsValidMasterFile;
      // IsValidMasterFile is used in local, so I design with not
      // any parameter.
      if Result then begin
         Result := LoadMasterFile;
      end;
      }
      FileStrings.Free;
   end;
   {FreeTagList;}
end;

function TIdDNS_UDPServer.LoadZoneStrings(FileStrings: TIdStrings; Filename : String;
         TreeRoot : TIdDNTreeNode): boolean;
var
   TagList : TIdStrings;

   function IsMSDNSFileName(theFileName : String; var DN:string) : boolean;
   var
      namepart : TIdStrings;
      Fullname : string;
      Count : integer;
   begin
      Fullname := theFilename;
      repeat
         if (Pos('\', Fullname) > 0) then fetch(Fullname, '\');
      until (Pos('\', Fullname) = 0);

      namepart := TIdStringList.Create;
      repeat
         namepart.Add(fetch(Fullname,'.'));
      until Fullname = '';

      Result := (namepart.Strings[namepart.Count -1] = 'dns');  {do not localize}
      if Result then begin
         Count := 0;
         DN := namepart.Strings[Count];
         repeat
            Inc(Count);
            if Count <= namepart.Count -2 then begin
               DN := DN + '.' + namepart.Strings[Count];
            end;
         until Count >= namepart.Count -2;
      end;
      namepart.Free;
   end;

   procedure MakeTagList;
   begin
     TagList := TIdStringList.Create;
     TagList.Add(cAAAA);
     TagList.Add(cA);
     TagList.Add(cNS);
     TagList.Add(cMD);
     TagList.Add(cMF);
     TagList.Add(cCName);
     TagList.Add(cSOA);
     TagList.Add(cMB);
     TagList.Add(cMG);
     TagList.Add(cMR);
     TagList.Add(cNULL);
     TagList.Add(cWKS);
     TagList.Add(cPTR);
     TagList.Add(cHINFO);
     TagList.Add(cMINFO);
     TagList.Add(cMX);
     TagList.Add(cTXT);

     // The Following Tags are used in master file, but not Resource Record.
     TagList.Add(cOrigin);
     TagList.Add(cInclude);
     //TagList.Add(cAt);
   end;

   procedure FreeTagList;
   begin
     TagList.Free;
   end;

   function ClearDoubleQutoa (Strs : TIdStrings): boolean;
   var
      SSCount : integer;
      Mark : boolean;
   begin
     SSCount := 0;
     Mark := False;

     while (SSCount <= Strs.Count -1) do begin
           repeat
           if Pos('"', Strs.Strings[SSCount]) > 0 then begin
              Mark := Mark xor (Pos('"', Strs.Strings[SSCount]) > 0);
              Strs.Strings[SSCount] := ReplaceSpecString(Strs.Strings[SSCount], '"', '', False);
           end;
           until (Pos('"', Strs.Strings[SSCount]) = 0);

           if not Mark then Inc(SSCount)
           else begin
                Strs.Strings[SSCount] := Strs.Strings[SSCount] + ' ' +
                                         Strs.Strings[SSCount + 1];
                Strs.Delete(SSCount + 1);
           end;
     end;

     Result := not Mark;
   end;

   function IsValidMasterFile : boolean;
   var
      EachLinePart : TIdStrings;
      CurrentLineNum, TagField, Count : integer;
      LineData, DataBody, Comment, FPart, Tag : string;
      denoted, Stop, PassQuota : boolean;
   begin
      EachLinePart := TIdStringList.Create;
      CurrentLineNum := 0;
      Stop := False;
      // Check Denoted;
      denoted := false;

      if FileStrings.Count > 0 then begin
         repeat
            LineData := Sys.Trim(FileStrings.Strings[CurrentLineNum]);
            DataBody := Fetch(LineData, ';');
            Comment := LineData;
            PassQuota := Pos('(', DataBody) = 0;

            // Split each item into TIdStrings.
            repeat
                  if not PassQuota then begin
                     Inc(CurrentLineNum);
                     LineData := Sys.Trim(FileStrings.Strings[CurrentLineNum]);
                     DataBody := DataBody + ' ' + Fetch(LineData, ';');
                     PassQuota := Pos(')', DataBody) > 0;
                  end;
            until PassQuota or (CurrentLineNum > (FileStrings.Count -1));

            Stop := not PassQuota;

            if not Stop then begin
               EachLinePart.Clear;
               DataBody := ReplaceSpecString(DataBody, '(', '');
               DataBody := ReplaceSpecString(DataBody, ')', '');

               repeat
                     DataBody := Sys.Trim(DataBody);
                     FPart := Fetch(DataBody, #9);

                     repeat
                       FPart := Sys.Trim(FPart);
                       Tag := Fetch(FPart,' ');

                       if (Tag <> '') and (Tag <> '(') and (Tag <> ')') then
                          EachLinePart.Add(Tag);
                     until (FPart='');
               until (DataBody= '');

               if not denoted then begin
                  if EachLinePart.Count > 1 then
                     denoted := (EachLinePart.Strings[0] = cOrigin) or (EachLinePart.IndexOf(cSOA) <> -1)
                  else
                      denoted := False;
               end;

               // Check Syntax;
               if not ( (EachLinePart.Count > 0) and
                        (EachLinePart.Strings[0] = cOrigin) ) then begin
                   if not denoted then begin
                      if EachLinePart.Count > 0 then
                         Stop := ((EachLinePart.Count > 0) and (EachLinePart.IndexOf(cSOA)= -1))
                      else Stop := False;
                   end else begin
                        //TagField := -1;
                        //FieldCount := 0;

                        // Search Tag Named 'IN';
                        TagField := EachLinePart.IndexOf('IN'); {do not localize}

                        if TagField = -1 then begin
                           Count := 0;
                           repeat
                                 if EachLinePart.Count > 0 then
                                    TagField := TagList.IndexOf(EachLinePart.Strings[Count]);
                                 Inc(Count);
                           until (Count >= EachLinePart.Count -1) or (TagField <> -1);

                           if TagField <> -1 then TagField := Count;
                        end else begin
                            if TagList.IndexOf(EachLinePart.Strings[TagField + 1]) = -1 then
                               TagField := -1
                            else Inc(TagField);
                        end;

                        if TagField > -1 then begin
                           case TagList.IndexOf(EachLinePart.Strings[TagField]) of
                                // Check ip
                                TypeCode_A : Stop := not IsValidIP(EachLinePart.Strings[TagField + 1]);
                                // Check ip v6
                                0 : Stop := not IsValidIPv6(EachLinePart.Strings[TagField + 1]);

                                // Check Domain Name
                                TypeCode_CName, TypeCode_NS, TypeCode_MR,
                                TypeCode_MD, TypeCode_MB, TypeCode_MG,
                                TypeCode_MF: Stop := not IsHostName(EachLinePart.Strings[TagField + 1]);

                                // Can be anything
                                TypeCode_TXT, TypeCode_NULL: Stop := False;

                                // Must be FQDN.
                                TypeCode_PTR: Stop := not IsFQDN(EachLinePart.Strings[TagField + 1]);

                                // HINFO should has 2 fields : CPU and OS. but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_HINFO: begin
                                                     Stop := not (ClearDoubleQutoa(EachLinePart) and
                                                             (EachLinePart.Count - TagField-1 = 2));
                                                end;

                                // Check RMailBX and EMailBX  but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_MINFO: begin
                                                  Stop := (EachLinePart.Count - TagField-1 <> 2);
                                                  if not Stop then begin
                                                     Stop :=  not (IsHostName(EachLinePart.Strings[TagField + 1]) and
                                                                   IsHostName(EachLinePart.Strings[TagField + 2]));
                                                  end;
                                                end;

                                // Check Pref(Numeric) and Exchange.  but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_MX: begin
                                               Stop := (EachLinePart.Count - TagField-1 <> 2);
                                               if not Stop then begin
                                                Stop := not (IsNumeric(EachLinePart.Strings[TagField + 1]) and
                                                             IsHostName(EachLinePart.Strings[TagField + 2]));
                                               end;
                                             end;

                                // TIdStrings is 0 base, so that we have to minus one
                                TypeCode_SOA: begin
                                                Stop := (EachLinePart.Count - TagField-1 <> 7);
                                                if not Stop then begin
                                                   Stop := not (IsHostName(EachLinePart.Strings[TagField + 1]) and
                                                                IsHostName(EachLinePart.Strings[TagField + 2]) and
                                                                IsNumeric(EachLinePart.Strings[TagField + 3]) and
                                                                IsNumeric(EachLinePart.Strings[TagField + 4]) and
                                                                IsNumeric(EachLinePart.Strings[TagField + 5]) and
                                                                IsNumeric(EachLinePart.Strings[TagField + 6]) and
                                                                IsNumeric(EachLinePart.Strings[TagField + 7])
                                                               );
                                                end;
                                              end;

                                TypeCode_WKS: Stop := (EachLinePart.Count - TagField = 1);
                           end;
                        end else begin
                            if EachLinePart.Count > 0 then
                               Stop := True;
                        end;
                   end;
               end;
            end;
            Inc(CurrentLineNum);
         until (CurrentLineNum > (FileStrings.Count -1)) or Stop;
      end;

      Result := not Stop;
      EachLinePart.Free;
   end;

   function LoadMasterFile : boolean;
   var
      Checks, EachLinePart, DenotedDomain : TIdStrings;
      CurrentLineNum, FieldCount, TagField, Count, LastTTL : integer;
      LineData, DataBody, Comment, FPart, Tag, Text,
      RName, LastDenotedDomain, LastTag, NewDomain, SingleHostName, PrevDNTag : string;
      denoted, Stop, PassQuota, Found, canChangPrevDNTag : boolean;
      LLRR_A : TIdRR_A;
      LLRR_AAAA : TIdRR_AAAA;
      LLRR_NS : TIdRR_NS;
      LLRR_MB : TIdRR_MB;
      LLRR_Name : TIdRR_CName;
      LLRR_SOA : TIdRR_SOA;
      LLRR_MG : TIdRR_MG;
      LLRR_MR : TIdRR_MR;
      LLRR_PTR : TIdRR_PTR;
      LLRR_HINFO : TIdRR_HINFO;
      LLRR_MINFO : TIdRR_MINFO;
      LLRR_MX : TIdRR_MX;
      LLRR_TXT : TIdRR_TXT;
   begin
      EachLinePart := TIdStringList.Create;
      DenotedDomain := TIdStringList.Create;
      CurrentLineNum := 0;
      LastDenotedDomain := '';
      LastTag := '';
      NewDomain := '';
      PrevDNTag := '';
      Stop := False;
      //canChangPrevDNTag := True;

      if IsMSDNSFileName(FileName, LastDenotedDomain) then begin
         //canChangPrevDNTag := False;
         Filename := Sys.Uppercase (Filename);
      end else LastDenotedDomain := '';

      if FileStrings.Count > 0 then begin
         repeat
            LineData := Sys.Trim(FileStrings.Strings[CurrentLineNum]);
            DataBody := Fetch(LineData, ';');
            Comment := LineData;
            PassQuota := Pos('(', DataBody) = 0;

            // Split each item into TIdStrings.
            repeat
                  if not PassQuota then begin
                     Inc(CurrentLineNum);
                     LineData := Sys.Trim(FileStrings.Strings[CurrentLineNum]);
                     DataBody := DataBody + ' ' + Fetch(LineData, ';');
                     PassQuota := Pos(')', DataBody) > 0;
                  end;
            until PassQuota;

            EachLinePart.Clear;
            DataBody := ReplaceSpecString(DataBody, '(', '');
            DataBody := ReplaceSpecString(DataBody, ')', '');
            repeat
               DataBody := Sys.Trim(DataBody);
               FPart := Fetch(DataBody, #9);

               repeat
                  FPart := Sys.Trim(FPart);
                  if Pos('"', FPart) = 1 then begin
                     Fetch(FPart, '"');
                     Text := Fetch(FPart, '"');
                     EachLinePart.Add(Text);
                  end;

                  Tag := Fetch(FPart,' ');
                  if (TagList.IndexOf(Tag) = -1) and (Tag <> 'IN') then {do not localize}
                     Tag := IndyLowerCase(Tag);

                  if (Tag <> '') and (Tag <> '(') and (Tag <> ')') then
                     EachLinePart.Add((Tag));
               until (FPart = '');
            until (DataBody= '');

               if EachLinePart.Count > 0 then begin
                  if (EachLinePart.Strings[0] = cOrigin) then begin
                     // One Domain is found.
                     NewDomain := EachLinePart.Strings[1];
                     if Copy(NewDomain, Length(NewDomain),1) = '.' then begin
                            LastDenotedDomain := NewDomain;
                            NewDomain := '';
                     end else begin
                         LastDenotedDomain := NewDomain + '.' + LastDenotedDomain;
                         NewDomain := '';
                     end;
                  end else begin
                      // Search RR Type Tag;
                      Count := 0;
                      TagField := -1;
                      repeat
                            Found := (TagList.IndexOf(EachLinePart.Strings[Count]) > -1);
                            if Found then TagField := Count;
                            Inc(Count)
                      until Found or (Count > EachLinePart.Count -1);

                      // To initialize LastTTL;
                      LastTTL := 86400;
                      if TagField > -1 then begin
                         case TagField of
                              1 : if EachLinePart.Strings[0] <> 'IN' then begin {do not localize}
                                     canChangPrevDNTag := True;
                                     LastTag := EachLinePart.Strings[0];
                                     if EachLinePart.Strings[TagField] <> 'SOA' then begin  {do not localize}
                                        PrevDNTag := '';
                                     end else begin
                                         LastTTL := Sys.StrToInt(EachLinePart.Strings[TagField + 6]);
                                     end;
                                  end else canChangPrevDNTag := False;
                              2 : if EachLinePart.Strings[1] = 'IN' then begin  {do not localize}
                                     LastTag := EachLinePart.Strings[0];
                                     canChangPrevDNTag := True;
                                     if EachLinePart.Strings[TagField] <> 'SOA' then begin  {do not localize}
                                        PrevDNTag := '';
                                     end else begin
                                         LastTTL := Sys.StrToInt(EachLinePart.Strings[TagField + 6]);
                                     end;
                                  end else canChangPrevDNTag := False;
                              else begin
                                   canChangPrevDNTag := False;
                                   LastTTL := 86400;
                              end;
                         end;

                         //if (EachLinePart.Strings[0] = cAt) or (PrevDNTag = 'SOA') then
                         if (EachLinePart.Strings[0] = cAt) then
                            SingleHostName := LastDenotedDomain
                         else begin
                             if LastTag = cAt then LastTag := SingleHostName;
                             if Copy(LastTag, Length(LastTag), 1) <> '.' then
                                SingleHostName := LastTag + '.' + LastDenotedDomain
                             else
                                 SingleHostName := LastTag;
                         end;

                         case TagList.IndexOf(EachLinePart.Strings[TagField]) of
                                // Check ip
                                TypeCode_A : begin
                                               LLRR_A := TIdRR_A.Create;
                                               LLRR_A.RRName := SingleHostName;
                                               LLRR_A.Address := EachLinePart.Strings[TagField + 1];
                                               LLRR_A.TTL := LastTTL;

                                               UpdateTree(TreeRoot, LLRR_A);
                                               if canChangPrevDNTag then PrevDNTag := 'A';
                                             end;
                                // Check IPv6 ip address 10/29,2002
                                0 : begin
                                               LLRR_AAAA := TIdRR_AAAA.Create;
                                               LLRR_AAAA.RRName := SingleHostName;
                                               LLRR_AAAA.Address := ConvertToVaildv6IP(EachLinePart.Strings[TagField + 1]);
                                               LLRR_AAAA.TTL := LastTTL;

                                               UpdateTree(TreeRoot, LLRR_AAAA);
                                               if canChangPrevDNTag then PrevDNTag := 'AAAA'; {do not localize}
                                             end;

                                // Check Domain Name
                                TypeCode_CName: begin
                                                  LLRR_Name := TIdRR_CName.Create;
                                                  LLRR_Name.RRName := SingleHostName;
                                                  if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_Name.CName := EachLinePart.Strings[TagField + 1]
                                                  else
                                                      LLRR_Name.CName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                                                  LLRR_Name.TTL := LastTTL;

                                                  UpdateTree(TreeRoot, LLRR_Name);
                                                  if canChangPrevDNTag then PrevDNTag := 'CNAME'; {do not localize}
                                                end;
                                TypeCode_NS : begin
                                                  LLRR_NS := TIdRR_NS.Create;
                                                  LLRR_NS.RRName := SingleHostName;
                                                  if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_NS.NSDName := EachLinePart.Strings[TagField + 1]
                                                  else
                                                      LLRR_NS.NSDName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                  LLRR_NS.TTL := LastTTL;

                                                  UpdateTree(TreeRoot, LLRR_NS);
                                                  if canChangPrevDNTag then PrevDNTag := 'NS';  {do not localize}
                                              end;
                                TypeCode_MR : begin
                                                  LLRR_MR := TIdRR_MR.Create;
                                                  LLRR_MR.RRName := SingleHostName;
                                                  if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_MR.NewName := EachLinePart.Strings[TagField + 1]
                                                  else
                                                      LLRR_MR.NewName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                  LLRR_MR.TTL := LastTTL;

                                                  UpdateTree(TreeRoot, LLRR_MR);
                                                  if canChangPrevDNTag then PrevDNTag := 'MR';  {do not localize}
                                              end;
                                TypeCode_MD, TypeCode_MB,
                                TypeCode_MF : begin
                                                  LLRR_MB := TIdRR_MB.Create;
                                                  LLRR_MB.RRName := SingleHostName;
                                                  if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_MB.MADName := EachLinePart.Strings[TagField + 1]
                                                  else
                                                      LLRR_MB.MADName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                  LLRR_MB.TTL := LastTTL;

                                                  UpdateTree(TreeRoot, LLRR_MB);
                                                  if canChangPrevDNTag then PrevDNTag := 'MF';  {do not localize}
                                              end;

                                TypeCode_MG : begin
                                                   LLRR_MG := TIdRR_MG.Create;
                                                   LLRR_MG.RRName := SingleHostName;
                                                   if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_MG.MGMName := EachLinePart.Strings[TagField + 1]
                                                   else
                                                      LLRR_MG.MGMName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                   LLRR_MG.TTL := LastTTL;

                                                   UpdateTree(TreeRoot, LLRR_MG);
                                                   if canChangPrevDNTag then PrevDNTag := 'MG'; {do not localize}
                                              end;

                                // Can be anything
                                TypeCode_TXT, TypeCode_NULL: begin
                                                   LLRR_TXT := TIdRR_TXT.Create;
                                                   LLRR_TXT.RRName := SingleHostName;
                                                   LLRR_TXT.TXT := EachLinePart.Strings[TagField + 1];
                                                   LLRR_TXT.TTL := LastTTL;

                                                   UpdateTree(TreeRoot, LLRR_TXT);
                                                   if canChangPrevDNTag then PrevDNTag := 'TXT';  {do not localize}
                                              end;

                                // Must be FQDN.
                                TypeCode_PTR: begin
                                                   LLRR_PTR := TIdRR_PTR.Create;
                                                   LLRR_PTR.RRName := SingleHostName;
                                                   if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_PTR.PTRDName := EachLinePart.Strings[TagField + 1]
                                                   else
                                                      LLRR_PTR.PTRDName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                   LLRR_PTR.TTL := LastTTL;

                                                   UpdateTree(TreeRoot, LLRR_PTR);
                                                   if canChangPrevDNTag then PrevDNTag := 'PTR';  {do not localize}
                                              end;

                                // HINFO should has 2 fields : CPU and OS. but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_HINFO: begin
                                                     ClearDoubleQutoa(EachLinePart);

                                                     LLRR_HINFO := TIdRR_HINFO.Create;
                                                     LLRR_HINFO.RRName := SingleHostName;
                                                     LLRR_HINFO.CPU := EachLinePart.Strings[TagField + 1];
                                                     LLRR_HINFO.OS := EachLinePart.Strings[TagField + 2];
                                                     LLRR_HINFO.TTL := LastTTL;

                                                     UpdateTree(TreeRoot, LLRR_HINFO);
                                                     if canChangPrevDNTag then PrevDNTag := 'HINFO';  {do not localize}
                                                end;

                                // Check RMailBX and EMailBX  but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_MINFO: begin
                                                  LLRR_MINFO := TIdRR_MINFO.Create;
                                                  LLRR_MINFO.RRName := SingleHostName;
                                                  if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                     LLRR_MINFO.Responsible_Mail := EachLinePart.Strings[TagField + 1]
                                                  else
                                                      LLRR_MINFO.Responsible_Mail := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                  if Copy(EachLinePart.Strings[TagField + 2], Length(EachLinePart.Strings[TagField + 2]),1) = '.' then
                                                     LLRR_MINFO.ErrorHandle_Mail := EachLinePart.Strings[TagField + 2]
                                                  else
                                                      LLRR_MINFO.ErrorHandle_Mail := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;
                                                  LLRR_MINFO.TTL := LastTTL;

                                                  UpdateTree(TreeRoot, LLRR_MINFO);
                                                  if canChangPrevDNTag then PrevDNTag := 'MINFO'; {do not localize}
                                                end;

                                // Check Pref(Numeric) and Exchange.  but TIdStrings
                                // is 0 base, so that we have to minus one
                                TypeCode_MX: begin
                                               LLRR_MX := TIdRR_MX.Create;
                                               LLRR_MX.RRName := SingleHostName;
                                               LLRR_MX.Preference := EachLinePart.Strings[TagField + 1];
                                               if Copy(EachLinePart.Strings[TagField + 2], Length(EachLinePart.Strings[TagField + 2]),1) = '.' then
                                                  LLRR_MX.Exchange := EachLinePart.Strings[TagField + 2]
                                               else
                                                   LLRR_MX.Exchange := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;

                                               LLRR_MX.TTL := LastTTL;

                                               UpdateTree(TreeRoot, LLRR_MX);
                                               if canChangPrevDNTag then PrevDNTag := 'MX'; {do not localize}
                                             end;

                                // TIdStrings is 0 base, so that we have to minus one
                                TypeCode_SOA: begin
                                                LLRR_SOA := TIdRR_SOA.Create;

                                                if Copy(EachLinePart.Strings[TagField + 1], Length(EachLinePart.Strings[TagField + 1]),1) = '.' then
                                                   LLRR_SOA.MName := EachLinePart.Strings[TagField + 1]
                                                else
                                                    LLRR_SOA.MName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;

                                                //LLRR_SOA.RRName:= LLRR_SOA.MName;
                                                if (SingleHostName = '') and (LastDenotedDomain = '') then begin
                                                   LastDenotedDomain := LLRR_SOA.MName;
                                                   Fetch(LastDenotedDomain, '.');
                                                   SingleHostName := LastDenotedDomain;
                                                end;
                                                LLRR_SOA.RRName := SingleHostName;

                                                // Update the Handed List
                                                {if Self.Handed_DomainList.IndexOf(LLRR_SOA.MName) = -1 then begin
                                                   Self.Handed_DomainList.Add(LLRR_SOA.MName);
                                                end;
                                                }
                                                if Self.Handed_DomainList.IndexOf(LLRR_SOA.RRName) = -1 then begin
                                                   Self.Handed_DomainList.Add(LLRR_SOA.RRName);
                                                end;

                                                {if DenotedDomain.IndexOf(LLRR_SOA.MName) = -1 then
                                                   DenotedDomain.Add(LLRR_SOA.MName);
                                                LastDenotedDomain := LLRR_SOA.MName;}

                                                if DenotedDomain.IndexOf(LLRR_SOA.RRName) = -1 then
                                                   DenotedDomain.Add(LLRR_SOA.RRName);
                                                //LastDenotedDomain := LLRR_SOA.RRName;

                                                if Copy(EachLinePart.Strings[TagField + 2], Length(EachLinePart.Strings[TagField + 2]),1) = '.' then
                                                   LLRR_SOA.RName := EachLinePart.Strings[TagField + 2]
                                                else
                                                    LLRR_SOA.RName := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;

                                                Checks := TIdStringList.Create;
                                                RName := LLRR_SOA.RName;
                                                while (RName <> '') do begin
                                                      Checks.Add(Fetch(RName, '.'));
                                                end;

                                                RName := '';
                                                For Count := 0 to Checks.Count -1 do begin
                                                    if Checks.Strings[Count] <> '' then
                                                       RName := RName + Checks.Strings[Count] + '.';
                                                end;
                                                LLRR_SOA.RName := RName;
                                                Checks.Free;

                                                LLRR_SOA.Serial :=EachLinePart.Strings[TagField + 3];
                                                LLRR_SOA.Refresh := EachLinePart.Strings[TagField + 4];
                                                LLRR_SOA.Retry := EachLinePart.Strings[TagField + 5];
                                                LLRR_SOA.Expire := EachLinePart.Strings[TagField + 6];
                                                LLRR_SOA.Minimum := EachLinePart.Strings[TagField + 7];

                                                LastTTL := Sys.StrToInt(LLRR_SOA.Expire);
                                                LLRR_SOA.TTL := LastTTL;
                                                UpdateTree(TreeRoot, LLRR_SOA);

                                                if canChangPrevDNTag then PrevDNTag := 'SOA'; {do not localize}
                                              end;

                                TypeCode_WKS: begin
                                                if canChangPrevDNTag then PrevDNTag := 'WKS'; {do not localize}
                                              end;
                         end;
                      end;
                  end; // if EachLinePart.Count == 0 => Only Comment
               end;
            Inc(CurrentLineNum);
         until (CurrentLineNum > (FileStrings.Count -1));
      end;

      Result := not Stop;
      EachLinePart.Free;
   end;
begin
   MakeTagList;

   //if Result then begin
      Result := IsValidMasterFile;
      // IsValidMasterFile is used in local, so I design with not
      // any parameter.
      if Result then begin
         Result := LoadMasterFile;
      end;
   //end;
   FreeTagList;
end;

procedure TIdDNS_UDPServer.SaveToCache(ResourceRecord: string;
          QueryName : string; OriginalQType : Word);
var
   TempResolver : TIdDNSResolver;
   count : integer;
   //QType : Word;
   RR : TResultRecord;
begin
   TempResolver := TIdDNSResolver.Create(nil);
   TempResolver.FillResultWithOutCheckId(ResourceRecord);

   if TempResolver.DNSHeader.ANCount > 0 then begin
      for count := 0 to TempResolver.QueryResult.Count - 1 do begin
          RR := TempResolver.QueryResult.Items[Count];
          { marked by Dennies Chang. 2004/7/16
          case RR.RecType of
            qtA : QType := TypeCode_A;
            qtAAAA : QType := TypeCode_AAAA;
            qtNS: QType := TypeCode_NS;
            qtMD: QType := TypeCode_MD;
            qtMF: QType := TypeCode_MF;
            qtName:QType := TypeCode_CName;
            qtSOA: QType := TypeCode_SOA;
            qtMB: QType := TypeCode_MB;
            qtMG: QType := TypeCode_MG;
            qtMR: QType := TypeCode_MR;
            qtNull:QType := TypeCode_Null;
            qtWKS:QType := TypeCode_WKS;
            qtPTR:QType := TypeCode_PTR;
            qtHINFO:QType := TypeCode_HINFO;
            qtMINFO:QType := TypeCode_MINFO;
            qtMX: QType := TypeCode_MX;
            qtTXT: QType := TypeCode_TXT;
            qtSTAR: QType := TypeCode_STAR;
            else QType := TypeCode_STAR;
          end;
          }

          UpdateTree(Self.Cached_Tree, RR);
      end;
   end;

   TempResolver.Free;
end;

function TIdDNS_UDPServer.SearchTree(Root: TIdDNTreeNode;
  QName: String; QType : Word): TIdDNTreeNode;
var
   RRIndex : integer;
   NodeCursor : TIdDNTreeNode;
   NameLabels : TIdStrings;
   OneNode, FullName : string;
   Found : Boolean;
begin
  Result := nil;
  NameLabels := TIdStringList.Create;
  FullName := QName;
  NodeCursor := Root;
  Found := False;

  repeat
    OneNode := Fetch(FullName, '.');
    if OneNode <> '' then
       NameLabels.Add(OneNode);
  until FullName = '';

  repeat
    //if (QType = TypeCode_A) or (QType = TypeCode_PTR) then begin
    if not (QType = TypeCode_SOA) then begin
         RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
         if RRIndex <> -1 then begin
            NameLabels.Delete(NameLabels.Count - 1);
            NodeCursor := NodeCursor.Children[RRIndex];

            if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                {
                if not Found then begin
                   Found := (NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[0]) <> -1);
                   if not Found then NameLabels.Clear;
                end
                }
             end else begin
                 Found := (NameLabels.Count = 0);
             end;
         end else begin
             if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                if not Found then NameLabels.Clear;
             end else begin
                 NameLabels.Clear;
             end;
         end;
    end else begin
        RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
         if RRIndex <> -1 then begin
            NameLabels.Delete(NameLabels.Count - 1);
            NodeCursor := NodeCursor.Children[RRIndex];

            if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                {
                if not Found then begin
                   Found := (NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[0]) <> -1);
                   if not Found then NameLabels.Clear;
                end
                }
             end else begin
                 Found := (NameLabels.Count = 0);
             end;
         end else begin
             if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                if not Found then NameLabels.Clear;
             end else begin
                 NameLabels.Clear;
             end;
         end;
         {
         RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
         if RRIndex <> -1 then begin
            NameLabels.Delete(NameLabels.Count - 1);
            Found := (NameLabels.Count = 0);
            if NodeCursor.Children[RRIndex] <> nil then
               NodeCursor := NodeCursor.Children[RRIndex];
         end else begin
             if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                if not Found then NameLabels.Clear;
             end else begin
                 NameLabels.Clear;
             end;
         end;
         }
    end;
  until (NameLabels.Count = 0) or (Found);

  if Found then Result := NodeCursor;

  NameLabels.Free;
end;

{
procedure TIdDNS_UDPServer.SetCached_Tree(const Value: TIdDNTreeNode);
begin
  FCached_Tree.Assign(Value);
end;
}

procedure TIdDNS_UDPServer.SetHanded_DomainList(const Value: TIdStrings);
begin
  FHanded_DomainList.Assign(Value);
end;

{
procedure TIdDNS_UDPServer.SetHanded_Tree(const Value: TIdDNTreeNode);
begin
  FHanded_Tree.Assign(Value);
end;
}

procedure TIdDNS_UDPServer.SetRootDNS_NET(const Value: TIdStrings);
begin
  FRootDNS_NET.Assign(Value);
end;

procedure TIdDNS_UDPServer.SetZoneMasterFiles(const Value: TIdStrings);
begin
  FZoneMasterFiles.Assign(Value);
end;

procedure TIdDNS_UDPServer.UpdateTree(TreeRoot: TIdDNTreeNode;
  RR: TResultRecord);
var
   NameNode : TIdStrings;
   RRName, APart : String;
   Count, NodeIndex : integer;
   NodeCursor : TIdDNTreeNode;
   LRR_A : TIdRR_A;
   LRR_AAAA : TIdRR_AAAA;
   LRR_NS : TIdRR_NS;
   LRR_MB : TIdRR_MB;
   LRR_Name : TIdRR_CName;
   LRR_SOA : TIdRR_SOA;
   LRR_MG : TIdRR_MG;
   LRR_MR : TIdRR_MR;
   LRR_PTR : TIdRR_PTR;
   LRR_HINFO : TIdRR_HINFO;
   LRR_MINFO : TIdRR_MINFO;
   LRR_MX : TIdRR_MX;
   LRR_TXT : TIdRR_TXT;
begin
  RRName := RR.Name;

  NameNode := TIdStringList.Create;
  repeat
     APart := Fetch(RRName, '.');
     if APart <> '' then NameNode.Add(APart);
  until RRName = '';

  NodeCursor := TreeRoot;
  RRName := RR.Name;
  if Copy(RRName, Length(RRName), 1) <> '.' then RRName := RRName + '.';
  if (not (RR.RecType = qtSOA)) and (Self.Handed_DomainList.IndexOf(IndyLowerCase(RRName)) = -1) and
     (not (RR.RecType = qtNS)) then begin
     For Count := NameNode.Count-1 downto 1 do begin
         NodeIndex := NodeCursor.ChildIndex.IndexOf(NameNode.Strings[Count]);
         if NodeIndex = -1 then begin
            NodeCursor := NodeCursor.AddChild;
            NodeCursor.AutoSortChild := True;
            NodeCursor.CLabel := NameNode.Strings[Count];
         end else begin
             NodeCursor := NodeCursor.Children[NodeIndex];
         end;
     end;

     RRName := NameNode.Strings[0];
  end else begin
      For Count := NameNode.Count-1 downto 0 do begin
         NodeIndex := NodeCursor.ChildIndex.IndexOf(NameNode.Strings[Count]);
         RRName := NameNode.Strings[Count];
         if NodeIndex = -1 then begin
            NodeCursor := NodeCursor.AddChild;
            //NodeCursor.CLabel := RRName;
            NodeCursor.AutoSortChild := True;
            NodeCursor.CLabel := RRName;
         end else begin
             NodeCursor := NodeCursor.Children[NodeIndex];
         end;
      end;
      RRName := RR.Name;
  end;

     NodeCursor.RRs.ItemNames.Add(RRName);
     case RR.RecType of
          qtA : begin
                  LRR_A := TIdRR_A.Create;
                  NodeCursor.RRs.Add(LRR_A);

                  LRR_A.RRName := RRName;
                  LRR_A.Address := TARecord(RR).IPAddress;
                  LRR_A.TTL := TARecord(RR).TTL;

                  if LRR_A.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_A.RRName := LRR_A.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtAAAA : begin
                  LRR_AAAA := TIdRR_AAAA.Create;
                  NodeCursor.RRs.Add(LRR_AAAA);

                  LRR_AAAA.RRName := RRName;
                  LRR_AAAA.Address := TAAAARecord(RR).Address;
                  LRR_AAAA.TTL := TAAAARecord(RR).TTL;

                  if LRR_AAAA.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_AAAA.RRName := LRR_AAAA.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtNS: begin
                  LRR_NS := TIdRR_NS.Create;
                  NodeCursor.RRs.Add(LRR_NS);

                  LRR_NS.RRName := RRName;
                  LRR_NS.NSDName := TNSRecord(RR).HostName;
                  LRR_NS.TTL := TNSRecord(RR).TTL;

                  if LRR_NS.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_NS.RRName := LRR_NS.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtMD,
          qtMF,
          qtMB: begin
                  LRR_MB := TIdRR_MB.Create;
                  NodeCursor.RRs.Add(LRR_MB);

                  LRR_MB.RRName := RRName;
                  LRR_MB.MADName := TNAMERecord(RR).HostName;
                  LRR_MB.TTL := TNAMERecord(RR).TTL;

                  if LRR_MB.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_MB.RRName := LRR_MB.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtName: begin
                  LRR_Name := TIdRR_CName.Create;
                  NodeCursor.RRs.Add(LRR_Name);

                  LRR_Name.RRName := RRName;
                  LRR_Name.CName := TNAMERecord(RR).HostName;
                  LRR_Name.TTL:= TNAMERecord(RR).TTL;

                  if LRR_Name.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_Name.RRName := LRR_Name.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtSOA: begin
                  LRR_SOA := TIdRR_SOA.Create;
                  NodeCursor.RRs.Add(LRR_SOA);

                  LRR_SOA.RRName := RRName;
                  LRR_SOA.MName := TSOARecord(RR).Primary;
                  LRR_SOA.RName := TSOARecord(RR).ResponsiblePerson;
                  LRR_SOA.Serial := Sys.IntToStr(TSOARecord(RR).Serial);
                  LRR_SOA.Minimum := Sys.IntToStr(TSOARecord(RR).MinimumTTL);
                  LRR_SOA.Refresh := Sys.IntToStr(TSOARecord(RR).Refresh);
                  LRR_SOA.Retry := Sys.IntToStr(TSOARecord(RR).Retry);
                  LRR_SOA.Expire := Sys.IntToStr(TSOARecord(RR).Expire);
                  LRR_SOA.TTL:= TSOARecord(RR).TTL;

                  if LRR_SOA.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_SOA.RRName := LRR_SOA.RRName + '.'+ NodeCursor.FullName;
                  end else begin
                      if Copy(LRR_SOA.RRName, Length(LRR_SOA.RRName), 1) <> '.' then LRR_SOA.RRName := LRR_SOA.RRName + '.';
                  end;
                end;
          qtMG : begin
                  LRR_MG := TIdRR_MG.Create;
                  NodeCursor.RRs.Add(LRR_MG);

                  LRR_MG.RRName := RRName;
                  LRR_MG.MGMName := TNAMERecord(RR).HostName;
                  LRR_MG.TTL := TNAMERecord(RR).TTL;

                  if LRR_MG.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_MG.RRName := LRR_MG.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtMR : begin
                  LRR_MR := TIdRR_MR.Create;
                  NodeCursor.RRs.Add(LRR_MR);

                  LRR_MR.RRName := RRName;
                  LRR_MR.NewName := TNAMERecord(RR).HostName;
                  LRR_MR.TTL := TNAMERecord(RR).TTL;

                  if LRR_MR.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_MR.RRName := LRR_MR.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtWKS: begin

                end;
          qtPTR: begin
                  LRR_PTR := TIdRR_PTR.Create;
                  NodeCursor.RRs.Add(LRR_PTR);

                  LRR_PTR.RRName := RRName;
                  LRR_PTR.PTRDName := TPTRRecord(RR).HostName;
                  LRR_PTR.TTL := TPTRRecord(RR).TTL;

                  if LRR_PTR.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_PTR.RRName := LRR_PTR.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtHINFO: begin
                  LRR_HINFO := TIdRR_HINFO.Create;
                  NodeCursor.RRs.Add(LRR_HINFO);

                  LRR_HINFO.RRName := RRName;
                  LRR_HINFO.CPU :=  THINFORecord(RR).CPU;
                  LRR_HINFO.OS := THINFORecord(RR).OS;
                  LRR_HINFO.TTL := THINFORecord(RR).TTL;

                  if LRR_HINFO.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_HINFO.RRName := LRR_HINFO.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtMINFO: begin
                  LRR_MINFO := TIdRR_MINFO.Create;
                  NodeCursor.RRs.Add(LRR_MINFO);

                  LRR_MINFO.RRName := RRName;
                  LRR_MINFO.Responsible_Mail := TMINFORecord(RR).ResponsiblePersonMailbox;
                  LRR_MINFO.ErrorHandle_Mail := TMINFORecord(RR).ErrorMailbox;
                  LRR_MINFO.TTL := TMINFORecord(RR).TTL;

                  if LRR_MINFO.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_MINFO.RRName := LRR_MINFO.RRName + '.' + NodeCursor.FullName;
                  end;
                end;
          qtMX: begin
                  LRR_MX := TIdRR_MX.Create;
                  NodeCursor.RRs.Add(LRR_MX);

                  LRR_MX.RRName := RRName;
                  LRR_MX.Exchange := TMXRecord(RR).ExchangeServer;
                  LRR_MX.Preference := Sys.IntToStr(TMXRecord(RR).Preference);
                  LRR_MX.TTL := TMXRecord(RR).TTL;

                  if LRR_MX.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_MX.RRName := LRR_MX.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          qtTXT, qtNULL: begin
                  LRR_TXT := TIdRR_TXT.Create;
                  NodeCursor.RRs.Add(LRR_TXT);

                  LRR_TXT.RRName := RRName;
                  LRR_TXT.TXT := TTextRecord(RR).Text.Text;
                  LRR_TXT.TTL := TTextRecord(RR).TTL;

                  if LRR_TXT.ifAddFullName(NodeCursor.FullName) then begin
                     LRR_TXT.RRName := LRR_TXT.RRName + '.'+ NodeCursor.FullName;
                  end;
                end;
          {qtSTAR: begin

                end;
          }
     end;
  //end;

  NameNode.Free;
end;

procedure TIdDNS_UDPServer.UpdateTree(TreeRoot: TIdDNTreeNode;
  RR: TIdTextModeResourceRecord);
var
   NameNode : TIdStrings;
   RRName, APart : String;
   Count, NodeIndex, RRIndex : integer;
   NodeCursor : TIdDNTreeNode;
   LRR_AAAA : TIdRR_AAAA;
   LRR_A : TIdRR_A;
   LRR_NS : TIdRR_NS;
   LRR_MB : TIdRR_MB;
   LRR_Name : TIdRR_CName;
   LRR_SOA : TIdRR_SOA;
   LRR_MG : TIdRR_MG;
   LRR_MR : TIdRR_MR;
   LRR_PTR : TIdRR_PTR;
   LRR_HINFO : TIdRR_HINFO;
   LRR_MINFO : TIdRR_MINFO;
   LRR_MX : TIdRR_MX;
   LRR_TXT : TIdRR_TXT;
   LRR_Error : TIdRR_Error;
begin
  RRName := RR.RRName;

  NameNode := TIdStringList.Create;
  repeat
     APart := Fetch(RRName, '.');
     if APart <> '' then NameNode.Add(APart);
  until RRName = '';

  NodeCursor := TreeRoot;
  RRName := RR.RRName;
  if Copy(RRName, Length(RRName), 1) <> '.' then RR.RRName := RR.RRName + '.';

  // VC: in2002-02-24-1715, it just denoted TIdRR_A and TIdRR_PTR,
  //     but that make search a domain name RR becoming complex,
  //     therefor I replace it with all RRs but not TIdRR_SOA
  //     SOA should own independent node.
  if (not (RR is TIdRR_SOA)) and (Self.Handed_DomainList.IndexOf(IndyLowerCase(RR.RRName)) =  -1) then begin
     For Count := NameNode.Count - 1 downto 1 do begin
         NodeIndex := NodeCursor.ChildIndex.IndexOf(NameNode.Strings[Count]);
         if NodeIndex = -1 then begin
            NodeCursor := NodeCursor.AddChild;
            NodeCursor.AutoSortChild := True;
            NodeCursor.CLabel := NameNode.Strings[Count];
         end else begin
             NodeCursor := NodeCursor.Children[NodeIndex];
         end;
     end;

     RRName := NameNode.Strings[0];
  end else begin
      For Count := NameNode.Count -1 downto 0 do begin
          NodeIndex := NodeCursor.ChildIndex.IndexOf(NameNode.Strings[Count]);
          RRName := NameNode.Strings[Count];
          if NodeIndex = -1 then begin
             NodeCursor := NodeCursor.AddChild;
             NodeCursor.AutoSortChild := True;
             NodeCursor.CLabel := RRName;
          end else begin
              NodeCursor := NodeCursor.Children[NodeIndex];
          end;
      end;

      RRName := RR.RRName;
  end;

  RRIndex := NodeCursor.RRs.ItemNames.IndexOf(RRName);
  if RRIndex = -1 then
     NodeCursor.RRs.ItemNames.Add(RRName)
  else begin
       repeat
          Inc(RRIndex);
          if RRIndex > NodeCursor.RRs.ItemNames.Count -1 then begin
             RRIndex := -1;
             break;
          end;
          if NodeCursor.RRs.ItemNames.Strings[RRIndex] <> RRName then
             break;
       until RRIndex > NodeCursor.RRs.ItemNames.Count -1;

       if RRIndex = -1 then
          NodeCursor.RRs.ItemNames.Add(RRName)
       else
          NodeCursor.RRs.ItemNames.Insert(RRIndex, RRName);
  end;

     case RR.TypeCode of
          TypeCode_Error : begin
                  LRR_Error := TIdRR_Error(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_Error)
                  else
                     NodeCursor.RRs.Insert(RRIndex, LRR_Error);
          end;
          TypeCode_A : begin
                  LRR_A := TIdRR_A(RR);

                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_A)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_A);
                end;
          TypeCode_AAAA : begin
                  LRR_AAAA := TIdRR_AAAA(RR);

                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_AAAA)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_AAAA);
                end;
          TypeCode_NS: begin
                  LRR_NS := TIdRR_NS(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_NS)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_NS);
                end;
          TypeCode_MF: begin
                  LRR_MB := TIdRR_MB(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_MB)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_MB);
                end;
          TypeCode_CName: begin
                  LRR_Name := TIdRR_CName(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_Name)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_Name);
                end;
          TypeCode_SOA: begin
                  LRR_SOA := TIdRR_SOA(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_SOA)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_SOA);
                end;
          TypeCode_MG : begin
                  LRR_MG := TIdRR_MG(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_MG)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_MG);
                end;
          TypeCode_MR : begin
                  LRR_MR := TIdRR_MR(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_MR)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_MR);
                end;
          TypeCode_WKS: begin

                end;
          TypeCode_PTR: begin
                  LRR_PTR := TIdRR_PTR(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_PTR)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_PTR);
                end;
          TypeCode_HINFO: begin
                  LRR_HINFO := TIdRR_HINFO(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_HINFO)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_HINFO);
                end;
          TypeCode_MINFO: begin
                  LRR_MINFO := TIdRR_MINFO(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_MINFO)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_MINFO);
                end;
          TypeCode_MX: begin
                  LRR_MX := TIdRR_MX(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_MX)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_MX);
                end;
          TypeCode_TXT, TypeCode_NULL: begin
                  LRR_TXT := TIdRR_TXT(RR);
                  if RRIndex = -1 then
                     NodeCursor.RRs.Add(LRR_TXT)
                  else
                      NodeCursor.RRs.Insert(RRIndex, LRR_TXT);
                end;
          {qtSTAR: begin

                end;
          }
     end;
  //end;

  NameNode.Free;
end;

procedure TIdDNS_UDPServer.DoAfterSendBack(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var QueryResult: String; ResultCode: String;
  Query : string);
begin
   if Assigned(FOnAfterSendBack) then begin
      FOnAfterSendBack(ABinding, ADNSHeader, QueryResult, ResultCode, Query);
   end;
end;

function TIdDNS_UDPServer.AXFR( Header : TDNSHeader; Question: string; var Answer: TIdBytes): string;
var
   TargetNode : TIdDNTreeNode;
   IsMyDomains : boolean;
   RRcount : integer;
   Temp: TIdBytes;
begin
   Question := IndyLowerCase(Question);

   IsMyDomains := (Self.Handed_DomainList.IndexOf(Question) > -1);
   if not IsMyDomains then begin
      Fetch(Question, '.');
      IsMyDomains := (Self.Handed_DomainList.IndexOf(Question) > -1);
   end;

   // Is my domain, go for searching the node.
   TargetNode := nil;
   SetLength(Answer, 0);
   Header.ANCount := 0;
   if IsMyDomains then TargetNode := SearchTree(Self.Handed_Tree, Question, TypeCode_SOA);
   if IsMyDomains and (TargetNode <> nil) then begin
      // combine the AXFR Data(So many)

      RRCount := 0;
      Answer := TargetNode.DumpAllBinaryData(RRCount);
      Header.ANCount := RRCount;

      Header.QR := iQr_Answer;
      Header.AA := iAA_Authoritative;
      Header.RCode := iRCodeNoError;
      Header.QDCount := 0;
      Header.ARCount := 0;
      Header.TC := 0;
      Temp := Header.GenerateBinaryHeader;
      AppendBytes(Temp, Answer);
      Answer := Temp;

      Result := cRCodeQueryOK;
   end else begin
       Header.QR := iQr_Answer;
       Header.AA := iAA_Authoritative;
       Header.RCode := iRCodeNameError;
       Header.QDCount := 0;
       Header.ARCount := 0;
       Header.TC := 0;

       Answer := Header.GenerateBinaryHeader;
       Result := cRCodeQueryNotFound;
   end;
end;

procedure TIdDNS_UDPServer.InternalSearch(Header: TDNSHeader; QName: string;
  QType : Word; var Answer: TIdBytes; IfMainQuestion : boolean;
  IsSearchCache : boolean = false; IsAdditional : boolean = false;
  IsWildCard : boolean = false; WildCardOrgName : string = '');
var
  MoreAddrSearch : TIdStrings;
  TargetNode : TIdDNTreeNode;
  Server_Index, RRIndex, Count : integer;
  LocalAnswer, TempBytes, TempAnswer: TIdBytes;
  temp_QName, temp: string;
  AResult: TIdBytes;
  Stop, Extra, IsMyDomains, ifAdditional : boolean;
  LDNSResolver : TIdDNSResolver;

begin
  SetLength(Answer, 0);
  SetLength(Aresult, 0);
  // Search the Handed Tree first.
  MoreAddrSearch := TIdStringList.Create;
  Extra := False;
  //Pushed := False;

  if not IsSearchCache then begin
    TargetNode := SearchTree(Self.Handed_Tree, QName, QType);

    if TargetNode <> nil then begin //Assemble the Answer.
      RRIndex := TargetNode.RRs.ItemNames.IndexOf(IndyLowerCase(QName));
      if RRIndex = -1 then begin
         { below are added again by Dennies Chang in 2004/7/15
         { According RFC 1035, a full domain name must be tailed by a '.',
         { but in normal behavior, user will not input '.' in last
         { position of the full name. So we have to compare both of the
         { cases.
         }
         if (Copy(QName, Length(QName), 1) = '.') then begin
            QName := Copy(QName, 1, Length(QName)-1);
         end;

         RRIndex := TargetNode.RRs.ItemNames.IndexOf(IndyLowerCase(QName));
         { above are added again by Dennies Chang in 2004/7/15}

         if RRIndex = -1 then begin
            QName:= Fetch(QName, '.');
            RRIndex := TargetNode.RRs.ItemNames.IndexOf(IndyLowerCase(QName));
         end;
         { marked by Dennies Chang in 2004/7/15
         QName:= Fetch(QName, '.');
         RRIndex := TargetNode.RRs.ItemNames.IndexOf(IndyLowerCase(QName));
         }
      end;

      repeat
        temp_QName := QName;
        SetLength(LocalAnswer, 0);

        if RRIndex <> -1 then begin
          case QType of
            TypeCode_A:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_A then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_AAAA:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_AAAA then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_NS:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_NS then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName)) then begin
                  MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MD:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MF:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_CName:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_CName then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName)) then begin
                    MoreAddrSearch.Add(TIdRR_CName(TargetNode.RRs.Items[RRIndex]).CName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_SOA:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_SOA then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName);
                end;
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MB:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MG:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MG then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MR:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MR then begin
                if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName)) and
                  (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName)) then begin
                    MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_NULL:
            begin
              {if TargetNode.RRs.Items[RRIndex] is TIdRR_NULL then
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              }
            end;
            TypeCode_WKS:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_WKS then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_PTR:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_PTR then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_HINFO:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_HINFO then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MINFO:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MINFO then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_MX:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_MX then begin
                if (not IsValidIP(TIdRR_MX(TargetNode.RRs.Items[RRIndex]).Exchange)) and
                  (IsHostName(TIdRR_MX(TargetNode.RRs.Items[RRIndex]).Exchange)) then begin
                    MoreAddrSearch.Add(TIdRR_MX(TargetNode.RRs.Items[RRIndex]).Exchange);
                end;
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_TXT:
            begin
              if TargetNode.RRs.Items[RRIndex] is TIdRR_TXT then begin
                LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;
            TypeCode_STAR:
              LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
          end;

          if IsWildCard and (Length(LocalAnswer) > 0) then begin
            {temp := DomainNameToDNSStr(QName+'.'+TargetNode.FullName);
            fetch(LocalAnswer, temp);}
            TempBytes := DomainNameToDNSStr(QName+'.'+TargetNode.FullName);
            FetchBytes(LocalAnswer, ToBytes(temp));
            TempBytes := DomainNameToDNSStr(WildCardOrgName);
            AppendBytes(TempBytes, LocalAnswer);
            LocalAnswer := TempBytes;
            //LocalAnswer := DomainNameToDNSStr(WildCardOrgName) + LocalAnswer;
          end;

          if Length(LocalAnswer) > 0 then
          begin
            AppendBytes(Answer, LocalAnswer);
            if ((not Extra) and (not IsAdditional)) or (QType = TypeCode_AAAA) then begin
              if (TargetNode.RRs.Items[RRIndex] is TIdRR_NS) then begin
                if IfMainQuestion then Header.ANCount := Header.ANCount + 1
                else Header.NSCount := Header.NSCount + 1;
              end else begin
                if IfMainQuestion then Header.ANCount := Header.ANCount + 1
                else Header.ARCount := Header.ARCount + 1;
              end;
            end else begin
              if IsAdditional then begin
                 Header.ARCount := Header.ARCount + 1;
              end else begin
                  Header.ANCount := Header.ANCount + 1;
              end;
              { modified by Dennies Chang in 2004/7/15
              { do not localize.....  because ANCount and ARCount
              { is different in DNSResolver.
              Header.ANCount := Header.ANCount + 1
              }
            end;

            Header.Qr := iQr_Answer;
            Header.AA := iAA_Authoritative;
            Header.RCode := iRCodeNoError;
          end;

          if RRIndex < TargetNode.RRs.ItemNames.Count -1 then begin
            Stop := False;
            Inc(RRIndex);
          end else begin
            Stop := True;
          end;
        end else begin
          Stop := True;
        end;

        if QName = temp_QName then temp_QName := '';
      until (RRIndex = -1) or
        (not ((IndyLowerCase(TargetNode.RRs.ItemNames.Strings[RRIndex]) <> IndyLowerCase(QName)) xor
        (IndyLowerCase(TargetNode.RRs.ItemNames.Strings[RRIndex]) <> IndyLowerCase(Fetch(temp_QName, '.')))))
        or (Stop);

      // Finish the Loop, but n record is found, we need to search if
      // there is a widechar record in its subdomain.
      // Main, Cache, Additional, Wildcard
      if Length(Answer) > 0 then begin
        InternalSearch(Header, '*.'+QName, QType, LocalAnswer, IfMAinQuestion,
                       False, False, True, QName);
        if LocalAnswer <> nil then
           AppendBytes(Answer, LocalAnswer);
      end;
    end else begin // Node can't be found.
      MoreAddrSearch.Clear;
    end;

    if MoreAddrSearch.Count > 0 then begin
      for Count := 0 to MoreAddrSearch.Count -1 do begin
        Server_Index := 0;
        if Self.Handed_DomainList.Count > 0 then begin
          repeat
            if (IndyPos(IndyLowerCase(Self.Handed_DomainList.Strings[Server_Index]),
              IndyLowerCase(MoreAddrSearch.Strings[Count])) > 0) then begin
              IsMyDomains := True;
            end else begin
              IsMyDomains := False;
            end;
            Inc(Server_Index);
          until IsMyDomains or (Server_Index > Self.Handed_DomainList.Count -1);
        end else begin
          IsMyDomains := False;
        end;

        if IsMyDomains then begin
          //ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);
          // modified by Dennies Chang in 2004/7/15.
          ifAdditional := (QType <> TypeCode_CName);

          //Search A record first.
          // Main, Cache, Additional, Wildcard
          InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A,
            LocalAnswer, True, False, ifAdditional, False);
          { modified by Dennies Chang in 2004/7/15.
          InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A,
            LocalAnswer, True, ifAdditional, True);}

          if Length(LocalAnswer) = 0 then begin
            temp := MoreAddrSearch.Strings[Count];
            Fetch(temp, '.');
            temp := '*.' + temp;
            InternalSearch(Header, temp, TypeCode_A,
              LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
            { marked by Dennies Chang in 2004/7/15.
            InternalSearch(Header, temp, TypeCode_A,
              LocalAnswer, True, ifAdditional, True, True, MoreAddrSearch.Strings[Count]);
            }
          end;

          TempAnswer := LocalAnswer;

          // Search for AAAA also.
          InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA,
            LocalAnswer, True, False, ifAdditional, True);
          { marked by Dennies Chang in 2004/7/15.
          InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA,
            LocalAnswer, True, ifAdditional, True);
          }

          if Length(LocalAnswer) = 0 then begin
            temp := MoreAddrSearch.Strings[Count];
            Fetch(temp, '.');
            temp := '*.' + temp;
            InternalSearch(Header, temp, TypeCode_AAAA,
              LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
            { marked by Dennies Chang in 2004/7/15.
            InternalSearch(Header, temp, TypeCode_AAAA,
              LocalAnswer, True, ifAdditional, True, True, MoreAddrSearch.Strings[Count]);
            }
          end;

          AppendBytes(TempAnswer, LocalAnswer);
          LocalAnswer := TempAnswer;
        end else begin
          // Need add AAAA Search in future.
          //QType := TypeCode_A;
          LDNSResolver := TIdDNSResolver.Create(self);
          Server_Index := 0;
          repeat
            LDNSResolver.Host := Self.RootDNS_NET.Strings[Server_Index];
            LDNSResolver.QueryType := [qtA];
            LDNSResolver.Resolve(MoreAddrSearch.Strings[Count]);
            AResult := LDNSResolver.PlainTextResult;
            Header.ARCount := Header.ARCount + LDNSResolver.QueryResult.Count;
          until (Server_Index >= Self.RootDNS_NET.Count - 1) or (Length(AResult) > 0);

          AppendBytes(LocalAnswer, Copy(AResult, 13, Length(AResult) -12));
          LDNSResolver.Free;
        end;

        if Length(LocalAnswer) > 0 then
           AppendBytes(Answer, LocalAnswer);
        //Answer := LocalAnswer;
      end;
    end;

  end else begin

    //Search the Cache Tree;
    { marked by Dennies Chang in 2004/7/15.
    { it's mark for querying cache only.
    {if Length(Answer) = 0 then begin
    }
      TargetNode := SearchTree(Self.Cached_Tree, QName, QType);
      if TargetNode <> nil then begin //Assemble the Answer.
        { modified by Dennies Chang in 2004/7/15}
        if (QType = TypeCode_A) or (QType = TypeCode_PTR) or
               (QType = TypeCode_AAAA) or (QType = TypeCode_Error) or (QType = TypeCode_CName) then
        begin
            QName:= Fetch(QName, '.');
        end;
        RRIndex := TargetNode.RRs.ItemNames.IndexOf(QName);

        repeat
          temp_QName := QName;
          SetLength(LocalAnswer, 0);

          if RRIndex <> -1 then begin

            // TimeOut, update the record.
            if Sys.CompareDate(Sys.Now,
              Sys.StrToDateTime(TargetNode.RRs.Items[RRIndex].TimeOut)) =1 then
            begin
              SetLength(LocalAnswer, 0)
            end else begin
              case QType of
                TypeCode_Error:
                begin
                  AppendString(Answer, 'Error'); {do not localize}
                end;
                TypeCode_A:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_A then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_AAAA:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_AAAA then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_NS:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_NS then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MD:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MF:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_CName:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_CName then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_SOA:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_SOA then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName);
                    end;
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MB:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MG:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MG then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MR:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MR then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_NULL:
                begin
                  {if TargetNode.RRs.Items[RRIndex] is TIdRR_NULL then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  }
                end;
                TypeCode_WKS:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_WKS then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_PTR:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_PTR then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_HINFO:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_HINFO then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MINFO:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MINFO then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_MX:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MX then begin
                    if (not IsValidIP((TargetNode.RRs.Items[RRIndex] as TIdRR_MX).Exchange)) and
                      (IsHostName((TargetNode.RRs.Items[RRIndex] as TIdRR_MX).Exchange)) then begin
                        MoreAddrSearch.Add((TargetNode.RRs.Items[RRIndex] as TIdRR_MX).Exchange);
                    end;
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_TXT:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_TXT then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
                TypeCode_STAR:
                  LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
              end;
            end;

            if BytesToString(LocalAnswer) = 'Error' then {do not localize}
               Stop := True
            else begin
                 if Length(LocalAnswer) > 0 then begin
                    AppendBytes(Answer, LocalAnswer);
                    if (TargetNode.RRs.Items[RRIndex] is TIdRR_NS) then begin
                       if IfMainQuestion then Header.ANCount := Header.ANCount + 1
                       else Header.NSCount := Header.NSCount + 1;
                    end else begin
                        if IfMainQuestion then Header.ANCount := Header.ANCount + 1
                        else Header.ARCount := Header.ARCount + 1;
                    end;

                    Header.Qr := iQr_Answer;
                    Header.AA := iAA_NotAuthoritative;
                    Header.RCode := iRCodeNoError;
                 end;

                 if RRIndex < TargetNode.RRs.ItemNames.Count -1 then begin
                    Stop := False;
                    Inc(RRIndex);
                 end else begin
                     Stop := True
                 end;
            end;
          end else begin
            Stop := True;
          end;
        until (RRIndex = -1) or
          (not ((IndyLowerCase(TargetNode.RRs.ItemNames.Strings[RRIndex]) <> IndyLowerCase(QName)) xor
          (IndyLowerCase(TargetNode.RRs.ItemNames.Strings[RRIndex]) <> IndyLowerCase(Fetch(temp_QName, '.')))))
          or (Stop);
      end;

      // Search MoreAddrSearch it's added in 2004/7/15, but the need is
      // found in 2004 Feb.
      if MoreAddrSearch.Count > 0 then begin
         for Count := 0 to MoreAddrSearch.Count -1 do begin
                Server_Index := 0;
                if Self.Handed_DomainList.Count > 0 then begin
                   repeat
                      if (IndyPos(IndyLowerCase(Self.Handed_DomainList.Strings[Server_Index]),
                              IndyLowerCase(MoreAddrSearch.Strings[Count])) > 0) then begin
                          IsMyDomains := True;
                      end else begin
                          IsMyDomains := False;
                      end;
                      Inc(Server_Index);
                   until IsMyDomains or (Server_Index > Self.Handed_DomainList.Count -1);
                end else begin
                    IsMyDomains := False;
                end;

                if IsMyDomains then begin
                   ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);

                   //Search A record first.
                   // Main, Cache, Additional, Wildcard
                   InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A,
                               LocalAnswer, True, False, ifAdditional, False);

                   if Length(LocalAnswer) = 0 then begin
                        temp := MoreAddrSearch.Strings[Count];
                        Fetch(temp, '.');
                        temp := '*.' + temp;
                        InternalSearch(Header, temp, TypeCode_A,
                               LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
                   end;

                   TempAnswer := LocalAnswer;

                   // Search for AAAA also.
                   InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA,
                               LocalAnswer, True, False, ifAdditional, True);
                   if Length(LocalAnswer) = 0 then begin
                        temp := MoreAddrSearch.Strings[Count];
                        Fetch(temp, '.');
                        temp := '*.' + temp;
                        InternalSearch(Header, temp, TypeCode_AAAA,
                               LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
                   end;

                   AppendBytes(TempAnswer, LocalAnswer);
	                 LocalAnswer := TempAnswer;
                end else begin
                    // 找Cache
                    TempAnswer := LocalAnswer;
                    ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);

                   //Search A record first.
                   // Main, Cache, Additional, Wildcard
                   InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A,
                               LocalAnswer, True, True, ifAdditional, False);

                   if Length(LocalAnswer) = 0 then begin
                        temp := MoreAddrSearch.Strings[Count];
                        Fetch(temp, '.');
                        temp := '*.' + temp;
                        InternalSearch(Header, temp, TypeCode_A,
                               LocalAnswer, True, True, ifAdditional, True, MoreAddrSearch.Strings[Count]);
                   end;

                   AppendBytes(TempAnswer, LocalAnswer);
	                 LocalAnswer := TempAnswer;

                   // Search for AAAA also.
                   InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA,
                               LocalAnswer, True, True, ifAdditional, True);

                   if Length(LocalAnswer) > 0 then
                      AppendBytes(TempAnswer, LocalAnswer);
	                 LocalAnswer := TempAnswer;
                end;

                Answer := LocalAnswer;
         end;
      end;
    { marked by Dennies Chang in 2004/7/15 (the bug is found in 2003 Dec.)
    end;
    }
  end; // End of search Cache.

  MoreAddrSearch.Free;
end;

{ TIdDNSServer }

procedure TIdDNSServer.CheckIfExpire(Sender: TObject);
begin

end;

procedure TIdDNSServer.InitComponent;
begin
  inherited;
  Self.FAccessList := TIdStringList.Create;
  Self.FUDPTunnel := TIdDNS_UDPServer.Create(Self);
  Self.FTCPTunnel := TIdDNS_TCPServer.Create(Self);

  Self.FBindings := TIdSocketHandles.Create(Self);
  Self.FTCPTunnel.DefaultPort := IdPORT_DOMAIN;
  Self.FUDPTunnel.DefaultPort := IdPORT_DOMAIN;
  Self.ServerType := stPrimary;
  Self.BackupDNSMap := TIdDNSMap.Create(Self.UDPTunnel);
end;

destructor TIdDNSServer.Destroy;
begin
  Self.FAccessList.Free;
  Self.FUDPTunnel.Free;
  Self.FTCPTunnel.Free;
  Self.FBindings.Free;

  Self.BackupDNSMap.Free;
  inherited Destroy;
end;

procedure TIdDNSServer.SetAccessList(const Value: TIdStrings);
begin
  FAccessList.Assign(Value);
  Self.FTCPTunnel.AccessList.Assign(Value);
end;

procedure TIdDNSServer.SetActive(const Value: boolean);
var
   Count : integer;
   DNSMap : TIdDomainNameServerMapping;
begin
  FActive := Value;
  Self.FUDPTunnel.Active := Value;
  if Self.ServerType = stSecondary then begin
     Self.TCPTunnel.Active := False;
     for Count := 0 to Self.BackupDNSMap.Count -1 do begin
         DNSMap := Self.BackupDNSMap.Items[Count];
         DNSMap.CheckScheduler.Start;
     end;
  end else Self.TCPTunnel.Active := Value;
end;

procedure TIdDNSServer.SetBindings(const Value: TIdSocketHandles);
begin
  FBindings.Assign(Value);
  Self.FUDPTunnel.Bindings.Assign(Value);
  Self.FTCPTunnel.Bindings.Assign(Value);
end;

procedure TIdDNSServer.SetTCPACLActive(const Value: boolean);
begin
  FTCPACLActive := Value;
  Self.TCPTunnel.AccessControl := Value;

  if Value then Self.FTCPTunnel.FAccessList.Assign(Self.FAccessList)
  else Self.FTCPTunnel.FAccessList.Clear;
end;

procedure TIdDNSServer.TimeToUpdateNodeData(Sender: TObject);
var
   Resolver : TIdDNSResolver;
   Count : integer;
begin
   Resolver := TIdDNSResolver.Create(Self);
   Resolver.Host := Self.UDPTunnel.RootDNS_NET.Strings[0];
   Resolver.QueryType := [qtAXFR];

   try
      Resolver.Resolve((Sender as TIdDNTreeNode).FullName);

      for Count := 0 to Resolver.QueryResult.Count -1 do begin
          Self.UDPTunnel.UpdateTree(Self.UDPTunnel.Handed_Tree, Resolver.QueryResult.items[Count]);
      end;
   finally
      Resolver.Free;
   end;
end;

{ TIdDNS_TCPServer }

procedure TIdDNS_TCPServer.InitComponent;
begin
  inherited;
  Self.FAccessList := TIdStringList.Create;
end;

destructor TIdDNS_TCPServer.Destroy;
begin
  Self.FAccessList.Free;
  inherited Destroy;
end;

procedure TIdDNS_TCPServer.DoConnect(AThread: TIdContext);
var
   Answer: TIdBytes;
   Data, Question: TIdBytes;
   QName, QLabel, QResult, PeerIP : string;
   LData, QPos, LLength :integer;
   TestHeader : TDNSHeader;

   procedure GenerateAXFRData;
   begin
      TestHeader := TDNSHeader.Create;
      try
        TestHeader.ParseQuery(Data);
        if TestHeader.QDCount >= 1 then begin
          // parse the question.
          QPos := 13;
          QLabel := '';
          QName := '';
          repeat
            LLength := Byte(Data[QPos]);
            Inc(QPos);
            QLabel := BytesToString(Data, QPos, LLength);
            Inc(QPos, LLength);

            if QName <> '' then begin
              QName := QName + QLabel + '.'
            end else begin
              QName := QLabel + '.';
            end;
          until ((QPos >= LData) or (Data[QPos] = 0));

          Question := Copy(Data, 13, length(Data)-12);
          QResult := TIdDNSServer(Self.Owner).UDPTunnel.AXFR(TestHeader, QName, Answer);
        end;
      finally
         TestHeader.Free;
      end;
   end;

   procedure GenerateAXFRRefuseData;
   begin
      TestHeader := TDNSHeader.Create;
      try
        TestHeader.ParseQuery(Data);
        TestHeader.Qr := iQr_Answer;
        TestHeader.RCode := iRCodeRefused;
        Answer := TestHeader.GenerateBinaryHeader;
      finally
        TestHeader.Free;
      end;
   end;
begin
  inherited DoConnect(AThread);

  LData := AThread.Connection.IOHandler.ReadSmallInt();
  SetLength(Data, 0);

  // RLebeau - why not use ReadBuffer() here?
  // Dennies - Sure, in older version, my concern is for real time generate system
  //           might not generate the data with correct data size we expect.
  AThread.Connection.IOHandler.ReadBytes(Data, LData);
  {for Count := 1 to LData do begin
    AppendByte(Data, Byte(AThread.Connection.IOHandler.ReadChar));
  end;
  }

  // PeerIP is ip address.
  PeerIP := (AThread.Connection.IOHandler as TIdIOHandlerSocket).Binding.PeerIP;
  if (Self.AccessControl) and (Self.AccessList.IndexOf(PeerIP) = -1) then begin
    GenerateAXFRRefuseData;
  end else begin
    GenerateAXFRData;
  end;

  AThread.Connection.IOHandler.Write(SmallInt(Length(Answer)));
  AThread.Connection.IOHandler.Write(Answer);
end;

procedure TIdDNS_TCPServer.SetAccessList(const Value: TIdStrings);
begin
  FAccessList.Assign(Value);
end;

{ TIdDomainExpireCheckThread }

procedure TIdDomainExpireCheckThread.Run;
var
  LInterval: Integer;
begin
  LInterval := FInterval;
  while LInterval > 0 do begin
    if LInterval > 500 then begin
      Sleep(500);
      LInterval := LInterval - 500;
    end else begin
      Sleep(LInterval);
      LInterval := 0;
    end;
    if Terminated then begin
      exit;
    end;

    Synchronize(TimerEvent);
  end;
end;

procedure TIdDomainExpireCheckThread.TimerEvent;
begin
   FTimerEvent(FSender);
end;


{ TIdDomainNameServerMapping }

constructor TIdDomainNameServerMapping.Create(List :TIdDNSMap);
begin
  inherited Create;

  Self.CheckScheduler := TIdDomainExpireCheckThread.Create();
  Self.CheckScheduler.FInterval := 100000;
  Self.CheckScheduler.FSender := self;
  Self.CheckScheduler.FDomain := Self.DomainName;
  Self.CheckScheduler.FHost := self.Host;
  Self.CheckScheduler.FTimerEvent := Self.SyncAndUpdate;

  Self.List := List;

  Self.FBusy := False;
end;

destructor TIdDomainNameServerMapping.Destroy;
begin
  //Self.CheckScheduler.TerminateAndWaitFor;
  Self.CheckScheduler.Terminate;
  Self.CheckScheduler.Free;
  inherited;
end;

procedure TIdDomainNameServerMapping.SetHost(const Value: string);
begin
  if IsValidIP(Value) or IsValidIPv6(Value) then begin
    FHost := Value;
  end else begin
    raise EIdDNSServerSettingException.Create(RSDNSServerSettingError_MappingHostError);
  end;
end;

procedure TIdDomainNameServerMapping.SetInterval(const Value: Cardinal);
begin
  FInterval := Value;
  Self.CheckScheduler.FInterval := Value;
end;

procedure TIdDomainNameServerMapping.SyncAndUpdate(Sender: TObject);
//Todo - Dennies Chang should append axfr and update Tree.
var
  Resolver : TIdDNSResolver;
  RR : TResultRecord;
  TNode : TIdDNTreeNode;
  Server : TIdDNS_UDPServer;
  NeedUpdated, NotThis : boolean;
  Count, TIndex : integer;
  RRName : string;
begin
  if Self.FBusy then begin
     Exit;
  end else begin
      Self.FBusy := True;
  end;

  Resolver := TIdDNSResolver.Create(nil);
  Resolver.Host := Self.Host;
  Resolver.QueryType := [qtAXFR];

  try
     Resolver.Resolve(Self.DomainName);

     RR := Resolver.QueryResult.Items[0];
     if RR.RecType <> qtSOA then begin
        raise EIdDNSServerSyncException.Create(RSDNSServerAXFRError_QuerySequenceError);
     end else begin
         Server := Self.List.Server;
         Self.Interval := TSOARecord(RR).Expire * 1000;

         {//Update MyDomain
         if Copy(RR.Name, Length(RR.Name),1) <> '.' then begin
            RRName := RR.Name + '.';
         end;
         }

         if Server.Handed_DomainList.IndexOf(RR.Name) = -1 then begin
            Server.Handed_DomainList.Add(RR.Name);
         end;

         TNode := Server.SearchTree(Server.Handed_Tree, RR.Name, TypeCode_SOA);

         if TNode = nil then begin
            NeedUpdated := True;
         end else begin
             RRName := RRName;
             RRName := Fetch(RRName, '.');
             TIndex := TNode.RRs.ItemNames.IndexOf(RR.Name);
             NotThis := True;

             while ((TIndex > -1) and (TIndex <= TNode.RRs.Count -1) and
                   (TNode.RRs.Items[TIndex].RRName = RR.Name) and (NotThis)) do begin
                   NotThis := not (TNode.RRs.Items[TIndex] is TIdRR_SOA);
                   Inc(TIndex);
             end;

             if not NotThis then begin
                Dec(TIndex);
                NeedUpdated := ((TNode.RRs.Items[TIndex] as TIdRR_SOA).Serial = Sys.IntToStr(TSOARecord(RR).Serial));
             end else begin
                 NeedUpdated := True;
             end;
         end;

         if NeedUpdated then begin
            if TNode <> nil then begin
               Server.Handed_Tree.RemoveChild(Server.Handed_Tree.IndexByNode(TNode));
            end;

            for count := 0 to Resolver.QueryResult.Count - 1 do begin
                RR := Resolver.QueryResult.Items[count];
                Server.UpdateTree(Server.Handed_Tree, RR);
            end;
         end;
     end;
  finally
    Self.FBusy := False;
    Resolver.Free;
  end;
end;

{ TIdDNSMap }

constructor TIdDNSMap.Create(Server: TIdDNS_UDPServer);
begin
  inherited Create;
  Self.FServer := Server;
end;

destructor TIdDNSMap.Destroy;
var
   Count : integer;
   DNSMP : TIdDomainNameServerMapping;
begin
  if Self.Count > 0 then begin
     for Count := Self.Count -1 downto 0 do begin
         DNSMP := Self.Items[Count];
         DNSMP.Free;

         Self.Delete(Count);
     end;
  end;
  inherited;
end;

function TIdDNSMap.GetItem(Index: Integer): TIdDomainNameServerMapping;
begin
   Result := TIdDomainNameServerMapping(inherited GetItem(Index));
end;

procedure TIdDNSMap.SetItem(Index: Integer;
  const Value: TIdDomainNameServerMapping);
begin
   inherited SetItem(Index, Value);
end;

procedure TIdDNSMap.SetServer(const Value: TIdDNS_UDPServer);
begin
  FServer := Value;
end;

{ TIdDNS_ProcessThread }

constructor TIdDNS_ProcessThread.Create(ACreateSuspended: Boolean;
  Data: String; DataSize: integer; MainBinding, Binding: TIdSocketHandle;
  Server: TIdDNS_UDPServer);
begin
   inherited Create(ACreateSuspended);

  Self.FMyData := nil;
  Self.FData := Data;
  Self.FDataSize := DataSize;

  Self.FMyBinding := Binding;
  Self.FMainBinding := MainBinding;

  Self.FServer := Server;
  Self.FreeOnTerminate := True;
end;

procedure TIdDNS_ProcessThread.ComposeErrorResult(var Final: TIdBytes;
              OriginalHeader: TDNSHeader; OriginalQuestion : TIdBytes;
              ErrorStatus: integer);
begin
  case ErrorStatus of
       iRCodeQueryNotImplement :
          begin
               OriginalHeader.Qr := iQr_Answer;
               OriginalHeader.RCode := iRCodeNotImplemented;

               Final := OriginalHeader.GenerateBinaryHeader;
               AppendBytes(Final, Copy(OriginalQuestion, 13, Length(OriginalQuestion) - 12));
          end;
       iRCodeQueryNotFound :
          begin
               OriginalHeader.Qr := iQr_Answer;
               OriginalHeader.RCode := iRCodeNameError;
               OriginalHeader.ANCount := 0;

               Final := OriginalHeader.GenerateBinaryHeader;
               //Final := Final;
          end;
  end;
end;

destructor TIdDNS_ProcessThread.Destroy;
begin
  Self.FServer := nil;
  Self.FMainBinding := nil;
  Self.FMyBinding.CloseSocket;
  Sys.FreeAndNil(Self.FMyBinding);
  //Self.FMyBinding := nil;

  if Self.FMyData <> nil then begin
     Sys.FreeAndNil(Self.FMyData);
  end;
  inherited;
end;

procedure TIdDNS_ProcessThread.QueryDomain;
var
   Temp, QName, QLabel, RString : string;
   ExternalQuery, Answer, FinalResult : TIdBytes;
   DNSHeader_Processing : TDNSHeader;
   QType, QClass : Word;
   QPos, QLength, LLength : integer;
   ABinding: TIdSocketHandle;
begin
  ExternalQuery := ToBytes(Self.FData);
  ABinding := Self.MyBinding;
  Temp := Self.FData;
  SetLength(FinalResult, 0);
  QType := TypeCode_A;

  if Self.FDataSize >= 12 then begin
     DNSHeader_Processing := TDNSHeader.Create;

     try
        if DNSHeader_Processing.ParseQuery(ExternalQuery) <> 0 then begin
           Self.FServer.DoAfterQuery(ABinding, DNSHeader_Processing, Temp, RString, BytesToString(ExternalQuery));
           AppendString(FinalResult, Temp); // Do not localize;
        end else begin
            if DNSHeader_Processing.QDCount > 0 then begin
               QPos := 12; //13; Modified in Dec. 13, 2004 by Dennies
               QLength := Length(ExternalQuery);
               if (QLength > 12) then begin
                  QName := '';
                  repeat
                    SetLength(Answer, 0);
                    LLength := ExternalQuery[QPos];
                    Inc(QPos);
                    QLabel := BytesToString(ExternalQuery, QPos, LLength);
                    Inc(QPos, LLength);

                    if QName <> '' then
                       QName := QName + QLabel + '.'
                    else
                        QName := QLabel + '.';
                  until ((QPos >= QLength) or (ExternalQuery[QPos] = 0));
                  Inc(QPos);

                  QType := GStack.NetworkToHost(TwoByteToWord(ExternalQuery[QPos], ExternalQuery[QPos + 1]));
                  Inc(QPos, 2);
                  QClass := GStack.NetworkToHost(TwoByteToWord(ExternalQuery[QPos], ExternalQuery[QPos + 1]));
                  Self.FServer.DoBeforeQuery(ABinding, DNSHeader_Processing, Temp);

                  RString := Self.CompleteQuery(DNSHeader_Processing, QName, ExternalQuery, Answer, QType, QClass, nil);

                  if RString = cRCodeQueryNotImplement then begin
                     ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotImplement);
                  end else begin
                      if (RString = cRCodeQueryReturned) then
                         FinalResult := Answer
                      else begin
                           if (RString = cRCodeQueryNotFound) or (RString = cRCodeQueryCacheFindError) then
                              ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotFound)
                           else
                               FinalResult := CombineAnswer(DNSHeader_Processing, ExternalQuery, Answer);
                      end;
                  end;

                  Self.FServer.DoAfterQuery(ABinding, DNSHeader_Processing, Temp, RString, Temp);
                  //AppendString(FinalResult, Temp);
               end;
            end;
        end;
      finally
        try
          Self.FData := BytesToString(FinalResult);
          Self.FDataSize := Length(Self.FData);

          Self.FServer.DoAfterSendBack(ABinding, DNSHeader_Processing, Temp, RString, BytesToString(ExternalQuery));

          if ( (Self.FServer.CacheUnknowZone) and
              (RString <> cRCodeQueryCacheFindError) and
              (RString <> cRCodeQueryCacheOK) and
              (RString <> cRCodeQueryOK) and
              (RString <> cRCodeQueryNotImplement) ) then
          begin
            Self.FServer.SaveToCache(BytesToString(FinalResult), QName, QType);
            Self.FServer.DoAfterCacheSaved(Self.FServer.FCached_Tree);
          end;
        finally
          Sys.FreeAndNil(DNSHeader_Processing);
        end;
      end;
  end;
end;

procedure TIdDNS_ProcessThread.Run;
begin
  //inherited;
  try
     //Synchronize(QueryDomain);
     QueryDomain;
     SendData;
  finally
         Self.Stop;
         Self.Terminate;
  end;
end;

procedure TIdDNS_ProcessThread.SetMyBinding(const Value: TIdSocketHandle);
begin
  FMyBinding := Value;
end;

procedure TIdDNS_ProcessThread.SetMyData(const Value: TStream);
begin
  FMyData := Value;
end;

procedure TIdDNS_ProcessThread.SetServer(const Value: TIdDNS_UDPServer);
begin
  FServer := Value;
end;

function TIdDNS_ProcessThread.CombineAnswer(Header: TDNSHeader;
  EQuery, Answer: TIdBytes): TIdBytes;
begin
   Result := Header.GenerateBinaryHeader;
   AppendBytes(Result, Copy(EQuery, 12, Length(EQuery) -12));
   AppendBytes(Result, Answer);
end;

procedure TIdDNS_ProcessThread.ExternalSearch(aDNSResolver: TIdDNSResolver; Header: TDNSHeader;
      Question: TIdBytes; var Answer: TIdBytes);
var
  Server_Index : integer;
  MyDNSResolver : TIdDNSResolver;
begin
  Server_Index := 0;
  if (aDNSResolver = nil) then
  begin
     MyDNSResolver := TIdDNSResolver.Create;
     MyDNSResolver.WaitingTime := 2000;
  end else
  begin
      MyDNSResolver := aDNSResolver;
  end;

  repeat
    MyDNSResolver.Host := Self.FServer.RootDNS_NET.Strings[Server_Index];
    try
      MyDNSResolver.InternalQuery := Question;
      MyDNSResolver.Resolve('');
      Answer := MyDNSResolver.PlainTextResult;
    except
      // Todo: Create DNS server interal resolver error.
      on EIdDnsResolverError do
      begin
        //Empty Event, for user to custom the event handle.
      end;
      on EIdSocketError do
      begin
      end;

      else
      begin
      end;
    end;

    Inc(Server_Index);
  until ((Server_Index >= Self.FServer.RootDNS_NET.Count) or (Length(Answer) > 0));

  if (aDNSResolver = nil) then
  begin
     MyDNSResolver.Free
  end;
end;

procedure TIdDNS_ProcessThread.InternalSearch(Header: TDNSHeader; QName: string; QType: Word;
      var Answer: TIdBytes; IfMainQuestion: boolean; IsSearchCache: boolean = false;
      IsAdditional: boolean = false; IsWildCard : boolean = false;
      WildCardOrgName: string = '');
begin

end;

procedure TIdDNS_ProcessThread.SaveToCache(ResourceRecord,
  QueryName: string; OriginalQType: Word);
var
   TempResolver : TIdDNSResolver;
   count : integer;
   QType : Word;
   RR : TResultRecord;
   TNode : TIdDNTreeNode;
   RR_Err : TIdRR_Error;
begin
   TempResolver := TIdDNSResolver.Create(nil);
   TempResolver.FillResultWithOutCheckId(ResourceRecord);

   if TempResolver.DNSHeader.ANCount > 0 then begin
      for count := 0 to TempResolver.QueryResult.Count - 1 do begin
          RR := TempResolver.QueryResult.Items[Count];
          {
          case RR.RecType of
            qtA : QType := TypeCode_A;
            qtAAAA : QType := TypeCode_AAAA;
            qtNS: QType := TypeCode_NS;
            qtMD: QType := TypeCode_MD;
            qtMF: QType := TypeCode_MF;
            qtName:QType := TypeCode_CName;
            qtSOA: QType := TypeCode_SOA;
            qtMB: QType := TypeCode_MB;
            qtMG: QType := TypeCode_MG;
            qtMR: QType := TypeCode_MR;
            qtNull:QType := TypeCode_Null;
            qtWKS:QType := TypeCode_WKS;
            qtPTR:QType := TypeCode_PTR;
            qtHINFO:QType := TypeCode_HINFO;
            qtMINFO:QType := TypeCode_MINFO;
            qtMX: QType := TypeCode_MX;
            qtTXT: QType := TypeCode_TXT;
            qtSTAR: QType := TypeCode_STAR;
            else QType := TypeCode_STAR;
          end;
          }

          Self.FServer.UpdateTree(Self.FServer.Cached_Tree, RR);
      end; // for loop
   end else begin
       QType := TypeCode_Error;
       TNode := Self.SearchTree(Self.FServer.Cached_Tree, QueryName, QType);
       if TNode = nil then begin
          RR_Err := TIdRR_Error.Create;
          RR_Err.RRName := QueryName;
          RR_Err.TTL := 600;

          Self.FServer.UpdateTree(Self.FServer.Cached_Tree, RR_Err);
       end;
   end;

   Sys.FreeAndNil(TempResolver);
end;

function TIdDNS_ProcessThread.SearchTree(Root: TIdDNTreeNode;
  QName: String; QType: Word): TIdDNTreeNode;
var
   RRIndex : integer;
   NodeCursor : TIdDNTreeNode;
   NameLabels : TIdStrings;
   OneNode, FullName : string;
   Found : Boolean;
begin
  Result := nil;
  NameLabels := TIdStringList.Create;
  FullName := QName;
  NodeCursor := Root;
  Found := False;

  repeat
    OneNode := Fetch(FullName, '.');
    if OneNode <> '' then
       NameLabels.Add(OneNode);
  until FullName = '';

  repeat
    sleep(0);
    if not (QType = TypeCode_SOA) then begin
         RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
         if RRIndex <> -1 then begin
            NameLabels.Delete(NameLabels.Count - 1);
            NodeCursor := NodeCursor.Children[RRIndex];

            if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
             end else begin
                 Found := (NameLabels.Count = 0);
             end;
         end else begin
             if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                if not Found then NameLabels.Clear;
             end else begin
                 NameLabels.Clear;
             end;
         end;
    end else begin
        RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
         if RRIndex <> -1 then begin
            NameLabels.Delete(NameLabels.Count - 1);
            NodeCursor := NodeCursor.Children[RRIndex];

            if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
             end else begin
                 Found := (NameLabels.Count = 0);
             end;
         end else begin
             if NameLabels.Count = 1 then begin
                Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
                if not Found then NameLabels.Clear;
             end else begin
                 NameLabels.Clear;
             end;
         end;
    end;
  until (NameLabels.Count = 0) or (Found);

  if Found then
  begin
    Result := NodeCursor;
  end;
  Sys.FreeAndNil(NameLabels);
end;

function TIdDNS_ProcessThread.CompleteQuery(DNSHeader: TDNSHeader;
  Question: string; OriginalQuestion: TIdBytes; var Answer : TIdBytes;
  QType, QClass : word; DNSResolver : TIdDNSResolver) : string;
var
   IsMyDomains : boolean;
   lAnswer, TempAnswer, RRData: TIdBytes;
   WildQuestion, TempDomain : string;
   LIdx: Integer;
begin
  // QClass = 1  => IN, we support only "IN" class now.
  // QClass = 2  => CS,
  // QClass = 3  => CH, we suppor "CHAOS" class now, but only "version.bind." info.
  //                    from 2004/6/28
  // QClass = 4  => HS.

  TempDomain := IndyLowerCase(Question);

  case QClass of
       Class_IN :
       begin
            IsMyDomains := (Self.FServer.Handed_DomainList.IndexOf(TempDomain) > -1);

            if not IsMyDomains then
            begin
              Fetch(TempDomain, '.');
            end;

            IsMyDomains := (Self.FServer.Handed_DomainList.IndexOf(TempDomain) > -1);

            if IsMyDomains then begin
               Self.FServer.InternalSearch(DNSHeader, Question, QType, lAnswer, True, False, False);
               Answer := lAnswer;

               if ((QType = TypeCode_A) or (QType = TypeCode_AAAA)) and
                  (Length(Answer) = 0) then
               begin
                 Self.FServer.InternalSearch( DNSHeader, Question,
                                              TypeCode_CNAME, lAnswer,
                                              True, False, True);
                 if lAnswer <> nil then
                    AppendBytes(Answer, lAnswer);
               end;

               WildQuestion := Question;
               fetch(WildQuestion, '.');
               WildQuestion := '*.' + WildQuestion;
               Self.FServer.InternalSearch( DNSHeader, WildQuestion, QType,
                                            lAnswer, True, False, False,
                                            true, Question);
               {Self.FServer.InternalSearch( DNSHeader, Question, QType,
                                            lAnswer, True, True, False);}
               if lAnswer <> nil then
                  AppendBytes(Answer, lAnswer);

               if Length(Answer) > 0 then
                  Result := cRCodeQueryOK
               else Result := cRCodeQueryNotFound;
            end else begin
                   Self.FServer.InternalSearch( DNSHeader, Question, QType,
                                                 Answer, True, True, False);

                   if ((QType = TypeCode_A) or (QType = TypeCode_AAAA)) and
                      (Length(Answer) = 0) then begin
                       Self.FServer.InternalSearch( DNSHeader, Question,
                                                    TypeCode_CNAME, lAnswer,
                                                    True, True, False);
                       if lAnswer <> nil then
                          AppendBytes(Answer, lAnswer);
                   end;

                   if Length(Answer) > 0 then
                      Result := cRCodeQueryCacheOK
                   else begin
                        QType := TypeCode_Error;

                        Self.FServer.InternalSearch( DNSHeader, Question,
                                                     QType, Answer, True,
                                                     True, False);
                        if BytesToString(Answer) = 'Error' then begin {do not localize}
                           Result := cRCodeQueryCacheFindError;
                        end else begin
                            Self.FServer.ExternalSearch(DNSResolver, DNSHeader,
                                                      OriginalQuestion, Answer);

                            if Length(Answer) > 0 then
                               Result := cRCodeQueryReturned
                            else Result := cRCodeQueryNotImplement;
                        end;
                   end;
            end;
       end; // End of Class_IN

       Class_CHAOS : begin
           if TempDomain = 'version.bind.' then begin {do not localize}
              if Self.FServer.offerDNSVersion then begin
                 TempAnswer := DomainNameToDNSStr('version.bind.'); {do not localize}
                 RRData := NormalStrToDNSStr(Self.FServer.DNSVersion);

                 SetLength(lAnswer, Length(TempAnswer)+(SizeOf(Word)*3)+SizeOf(Cardinal)+Length(RRData));
                 CopyTIdBytes(TempAnswer, 0, lAnswer, 0, Length(TempAnswer));
                 LIdx := Length(TempAnswer);
                 CopyTIdWord(GStack.HostToNetwork(Word(TypeCode_TXT)), lAnswer, LIdx);
                 Inc(LIdx, SizeOf(Word));
                 CopyTIdWord(GStack.HostToNetwork(Word(Class_CHAOS)), lAnswer, LIdx);
                 Inc(LIdx, SizeOf(Word));
                 CopyTIdCardinal(GStack.HostToNetwork(Cardinal(86400)), lAnswer, LIdx); {do not localize}
                 Inc(LIdx, SizeOf(Cardinal));
                 CopyTIdWord(GStack.HostToNetwork(Word(Length(RRData))), lAnswer, LIdx);
                 Inc(LIdx, SizeOf(Word));
                 CopyTIdBytes(RRData, 0, lAnswer, LIdx, Length(RRData));

                 Answer := lAnswer;
                 DNSHeader.ANCount := 1;
                 DNSHeader.AA := 1;
                 Result := cRCodeQueryOK;
              end else begin
                  Result := cRCodeQueryNotImplement;
              end;
           end else begin
               Result := cRCodeQueryNotImplement;
           end;
       end;

       else Result := cRCodeQueryNotImplement;
  end;
end;

procedure TIdDNS_ProcessThread.SendData;
begin
   Self.FServer.GlobalCS.Enter;
   try
      Self.FMainBinding.SendTo(Self.FMyBinding.PeerIP, Self.FMyBinding.PeerPort, ToBytes(Self.FData));
   finally
      Self.FServer.GlobalCS.Leave;
   end;
end;

procedure TIdDNS_UDPServer.DoAfterCacheSaved(CacheRoot: TIdDNTreeNode);
begin
   if Assigned(FOnAfterCacheSaved) then begin
      FOnAfterCacheSaved(CacheRoot);
   end;
end;

procedure TIdDNS_UDPServer.DoUDPRead(AData: TIdBytes;
  ABinding: TIdSocketHandle);
var
   PThread : TIdDNS_ProcessThread;
   ExternalQuery : string;
   BBinding : TIdSocketHandle;
   Binded : boolean;
begin
   inherited;
   ExternalQuery := BytesToString(AData);

   Binded := False;

   BBinding := TIdSocketHandle.Create(nil);
   BBinding.SetPeer(ABinding.PeerIP, ABinding.PeerPort);
   BBinding.IP := ABinding.IP;

   repeat
      try
         BBinding.Port := 53;
         BBinding.AllocateSocket(Id_SOCK_DGRAM);
         Binded := True;
      except
      end;
   until Binded;

   PThread := TIdDNS_ProcessThread.Create(True, ExternalQuery, Length(AData), ABinding, BBinding, Self);
   PThread.Start;
end;

end.
