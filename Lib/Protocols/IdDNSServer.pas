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


    Rev 1.40    3/4/2005 12:35:32 PM  JPMugaas
  Removed some compiler warnings.


    Rev 1.39    2/9/2005 4:35:06 AM  JPMugaas
  Should compile.


    Rev 1.38    2/8/05 6:13:02 PM  RLebeau
  Updated to use new AppendString() function in IdGlobal unit

  Updated TIdDNS_ProcessThread.CompleteQuery() to use CopyTId...() functions
  instead of ToBytes() and AppendBytes().


    Rev 1.37    2005/1/25 下午 12:25:26  DChang
  Modify UpdateTree method, make the NS record can be save in the lower level
  node.


    Rev 1.36    2005/1/5 下午 04:21:06  DChang    Version: 1.36
  Fix parsing procedure while processing TXT record, in pass version, double
  quota will not be processed, but now, any charector between 2 double quotas
  will be treated as TXT message.


    Rev 1.35    2004/12/15 下午 12:05:26  DChang    Version: 1.35
  1. Move UpdateTree to public section.
  2. add DoUDPRead of TIdDNSServer.
  3. Fix TIdDNS_ProcessThread.CompleteQuery and
     InternalQuery to fit Indy 10 Core.


    Rev 1.34    12/2/2004 4:23:50 PM  JPMugaas
  Adjusted for changes in Core.


    Rev 1.33    2004.10.27 9:17:46 AM  czhower
  For TIdStrings


    Rev 1.32    10/26/2004 9:06:32 PM  JPMugaas
  Updated references.


    Rev 1.31    2004.10.26 1:06:26 PM  czhower
  Further fixes for aliaser


    Rev 1.30    2004.10.26 12:01:32 PM  czhower
  Resolved alias conflict.


    Rev 1.29    9/15/2004 4:59:52 PM  DSiders
  Added localization comments.


    Rev 1.28    22/07/2004 18:14:22  ANeillans
  Fixed compile error.


    Rev 1.27    7/21/04 2:38:04 PM  RLebeau
  Removed redundant string copying in TIdDNS_ProcessThread constructor and
  procedure QueryDomain() method

  Removed local variable from TIdDNS_ProcessThread.SendData(), not needed


    Rev 1.26    2004/7/21 下午 06:37:48  DChang
  Fix compile error in TIdDNS_ProcessThread.SendData, and mark a case statment
  to comments in TIdDNS_ProcessThread.SaveToCache.


    Rev 1.25    2004/7/19 下午 09:55:52  DChang
  1. Move all textmoderecords to IdDNSCommon.pas
  2. Making DNS Server load the domain definition file while DNS Server
     component is active.
  3. Add a new event : OnAfterCacheSaved
  4. Add Full name condition to indicate if a domain is empty
     (ConvertDNtoString)
  5. Make Query request processed with independent thread.
  6. Rewrite TIdDNSServer into multiple thread mode, all queries will search
     and assemble the answer, and then share the TIdSocketHandle to send answer
     back.
  7. Add version information in TIdDNSServer, so class CHAOS can be taken, but
     only for the label : "version.bind.".
   8. Fix TIdRR_TXT.BinQueryRecord, to make sure it can be parsed in DNS client.
   9. Modify the AXFR function, reduce the response data size and quantity.
  10. Move all TIdTextModeResourceRecord and derived classes to IdDNSCommon.pas


    Rev 1.24    7/8/04 11:43:54 PM  RLebeau
  Updated TIdDNS_TCPServer.DoConnect() to use new BytesToString() parameters


    Rev 1.23    7/7/04 1:45:16 PM  RLebeau
  Compiler fixes


    Rev 1.22    6/29/04 1:43:30 PM  RLebeau
  Bug fixes for various property setters


    Rev 1.21    2004.05.20 1:39:32 PM  czhower
  Last of the IdStream updates


    Rev 1.20    2004.03.01 9:37:06 PM  czhower
  Fixed name conflicts for .net


    Rev 1.19    2004.02.07 5:03:32 PM  czhower
  .net fixes.


    Rev 1.18    2/7/2004 5:39:44 AM  JPMugaas
  IdDNSServer should compile in both DotNET and WIn32.


    Rev 1.17    2004.02.03 5:45:58 PM  czhower
  Name changes


    Rev 1.16    1/22/2004 8:26:40 AM  JPMugaas
  Ansi* calls changed.


    Rev 1.15    1/21/2004 2:12:48 PM  JPMugaas
  InitComponent


    Rev 1.14    12/7/2003 8:07:26 PM  VVassiliev
  string -> TIdBytes


    Rev 1.13    2003.10.24 10:38:24 AM  czhower
  UDP Server todos


    Rev 1.12    10/19/2003 12:16:30 PM  DSiders
  Added localization comments.


    Rev 1.11    2003.10.12 3:50:40 PM  czhower
  Compile todos


    Rev 1.10    2003/5/14 上午 01:17:36  DChang
  Fix a flag named denoted in the function which check if a domain correct.
  Update the logic of UpdateTree functions (make them unified).
  Update the TextRecord function of all TIdRR_ classes, it checks if the RRName
  the same as FullName, if RRName = FullName, it will not append the Fullname
  to RRName.


    Rev 1.9    2003/5/10 上午 01:09:42  DChang
  Patch the domainlist update when axfr action.


    Rev 1.8    2003/5/9 上午 10:03:36  DChang
  Modify the sequence of records. To make sure when we resolve MX record, the
  mail host A record can be additional record section.


    Rev 1.7    2003/5/8 下午 08:11:34  DChang
  Add TIdDNSMap, TIdDomainNameServerMapping to monitor primary DNS, and
  detecting if the primary DNS record changed, it will update automatically if
  necessary.


    Rev 1.6    2003/5/2 下午 03:39:38  DChang
  Fix all compile warnings and hints.


    Rev 1.5    4/29/2003 08:26:30 PM  DenniesChang
  Fix TIdDNSServer Create, the older version miss to create the FBindings.
  fix AXFR procedure, fully support BIND 8 AXFR procedures.

    Rev 1.4    4/28/2003 02:30:58 PM  JPMugaas
  reverted back to the old one as the new one checked will not compile, has
  problametic dependancies on Contrs and Dialogs (both not permitted).

    Rev 1.3    04/28/2003 01:15:10 AM  DenniesChang


     Rev 1.2    4/28/2003 07:00:18 AM  JPMugaas
  Should now compile.


    Rev 1.0    11/14/2002 02:18:42 PM  JPMugaas

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

{$i IdCompilerDefines.inc}

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
  IdUDPBase,
  IdResourceStrings,
  IdExceptionCore,
  IdDNSResolver,
  IdUDPServer,
  IdCustomTCPServer,
  IdStackConsts,
  IdThread,
  IdDNSCommon;

type
  TIdDomainExpireCheckThread = class(TIdThread)
  protected
    FInterval: UInt32;
    FSender: TObject;
    FTimerEvent: TNotifyEvent;
    FBusy : Boolean;
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
  TIdDomainNameServerMapping = class(TObject)
  private
    FHost: string;
    FDomainName: string;
    FBusy : Boolean;
    FInterval: UInt32;
    FList: TIdDNSMap;
    procedure SetHost(const Value: string);
    procedure SetInterval(const Value: UInt32);
  protected
    CheckScheduler : TIdDomainExpireCheckThread;
    property Interval : UInt32 read FInterval write SetInterval;
    property List : TIdDNSMap read FList write FList;
  public
    constructor Create(AList : TIdDNSMap);
    destructor Destroy; override;
  //You can not make methods and properties published in this class.
  //If you want to make properties publishes, this has to derrive from TPersistant
  //and be used by TPersistant in a published property.
  //  published
    procedure SyncAndUpdate(Sender : TObject);
    property Host : string read FHost write SetHost;
    property DomainName : string read FDomainName write FDomainName;
  end;

  TIdDNSMap = class(TIdObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdDomainNameServerMapping>{$ENDIF})
  private
    FServer: TIdDNS_UDPServer;
    {$IFNDEF HAS_GENERICS_TObjectList}
    function GetItem(Index: Integer): TIdDomainNameServerMapping;
    procedure SetItem(Index: Integer; const Value: TIdDomainNameServerMapping);
    {$ENDIF}
    procedure SetServer(const Value: TIdDNS_UDPServer);
  public
    constructor Create(Server: TIdDNS_UDPServer);
    {$IFNDEF USE_OBJECT_ARC}
    destructor Destroy; override;
    {$ENDIF}
    property Server : TIdDNS_UDPServer read FServer write SetServer;
    {$IFNDEF HAS_GENERICS_TObjectList}
    property Items[Index: Integer]: TIdDomainNameServerMapping read GetItem write SetItem; default;
    {$ENDIF}
  end;

  TIdMWayTreeNodeClass = class of TIdMWayTreeNode;
  // TODO: derive from TObjectList instead and remove SubTree member?
  TIdMWayTreeNode = class(TObject)
  private
    SubTree : TIdObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdMWayTreeNode>{$ENDIF};
    FFundmentalClass: TIdMWayTreeNodeClass;
    function GetTreeNode(Index: Integer): TIdMWayTreeNode;
    procedure SetFundmentalClass(const Value: TIdMWayTreeNodeClass);
    procedure SetTreeNode(Index: Integer; const Value: TIdMWayTreeNode);
  public
    constructor Create(NodeClass : TIdMWayTreeNodeClass); virtual;
    destructor Destroy; override;
    property FundmentalClass : TIdMWayTreeNodeClass read FFundmentalClass write SetFundmentalClass;
    property Children[Index : Integer] : TIdMWayTreeNode read GetTreeNode write SetTreeNode;
    function AddChild : TIdMWayTreeNode;
    function InsertChild(Index : Integer) : TIdMWayTreeNode;
    procedure RemoveChild(Index : Integer);
  end;

  TIdDNTreeNode = class(TIdMWayTreeNode)
  private
    FCLabel : String;
    FRRs: TIdTextModeRRs;
    FChildIndex: TStrings;
    FParentNode: TIdDNTreeNode;
    FAutoSortChild: Boolean;
    procedure SetCLabel(const Value: String);
    procedure SetRRs(const Value: TIdTextModeRRs);
    function GetNode(Index: integer): TIdDNTreeNode;
    procedure SetNode(Index: integer; const Value: TIdDNTreeNode);
    procedure SetChildIndex(const Value: TStrings);
    function GetFullName: string;
    function ConvertToDNString : string;
    function DumpAllBinaryData(var RecordCount:integer) : TIdBytes;
  public
    property ParentNode : TIdDNTreeNode read FParentNode write FParentNode;
    property CLabel : String read FCLabel write SetCLabel;
    property RRs : TIdTextModeRRs read FRRs write SetRRs;
    property Children[Index : Integer] : TIdDNTreeNode read GetNode write SetNode;
    property ChildIndex : TStrings read FChildIndex write SetChildIndex;
    property AutoSortChild : Boolean read FAutoSortChild write FAutoSortChild;
    property FullName : string read GetFullName;

    constructor Create(AParentNode : TIdDNTreeNode); reintroduce;
    destructor Destroy; override;
    function AddChild : TIdDNTreeNode;
    function InsertChild(Index : Integer) : TIdDNTreeNode;
    procedure RemoveChild(Index : Integer);
    procedure SortChildren;
    procedure Clear;
    procedure SaveToFile(Filename : String);
    function IndexByLabel(CLabel : String): Integer;
    function IndexByNode(ANode : TIdDNTreeNode) : Integer;
  end;

  TIdDNS_TCPServer = class(TIdCustomTCPServer)
  protected
    FAccessList: TStrings;
    FAccessControl: Boolean;
    //
    procedure DoConnect(AContext: TIdContext); override;
    procedure InitComponent; override;
    procedure SetAccessList(const Value: TStrings);
  public
    destructor Destroy; override;
  published
    property AccessList : TStrings read FAccessList write SetAccessList;
    property AccessControl : boolean read FAccessControl write FAccessControl;
  end;

  TIdDNS_ProcessThread = class(TIdThread)
  protected
    FMyBinding: TIdSocketHandle;
    FMainBinding: TIdSocketHandle;
    FMyData: TStream;
    FData : TIdBytes;
    FServer: TIdDNS_UDPServer;
    procedure SetMyBinding(const Value: TIdSocketHandle);
    procedure SetMyData(const Value: TStream);
    procedure SetServer(const Value: TIdDNS_UDPServer);
    procedure ComposeErrorResult(var VFinal: TIdBytes; OriginalHeader: TDNSHeader;
      OriginalQuestion : TIdBytes; ErrorStatus: Integer);
    function CombineAnswer(Header : TDNSHeader; const EQuery, Answer : TIdBytes): TIdBytes;
    procedure InternalSearch(Header: TDNSHeader; QName: string; QType: UInt16;
      var Answer: TIdBytes; IfMainQuestion: Boolean; IsSearchCache: Boolean = False;
      IsAdditional: Boolean = False; IsWildCard : Boolean = False;
      WildCardOrgName: string = '');
    procedure ExternalSearch(ADNSResolver: TIdDNSResolver; Header: TDNSHeader;
      Question: TIdBytes; var Answer: TIdBytes);
    function CompleteQuery(DNSHeader: TDNSHeader; Question: string;
      OriginalQuestion: TIdBytes; var Answer : TIdBytes; QType, QClass : UInt16;
      DNSResolver : TIdDNSResolver) : string;
    procedure SaveToCache(ResourceRecord : TIdBytes; QueryName : string; OriginalQType : UInt16);
    function SearchTree(Root : TIdDNTreeNode; QName : String; QType : UInt16): TIdDNTreeNode;

    procedure Run; override;
    procedure QueryDomain;
    procedure SendData;
  public
    property MyBinding : TIdSocketHandle read FMyBinding write SetMyBinding;
    property MyData: TStream read FMyData write SetMyData;
    property Server : TIdDNS_UDPServer read FServer write SetServer;

    constructor Create(ACreateSuspended: Boolean = True; Data : TIdBytes = nil;
      MainBinding : TIdSocketHandle = nil; Binding : TIdSocketHandle = nil;
      Server : TIdDNS_UDPServer = nil); reintroduce; overload;

    destructor Destroy; override;
  end;

  TIdDNSBeforeQueryEvent = procedure(ABinding: TIdSocketHandle; ADNSHeader: TDNSHeader; var ADNSQuery: TIdBytes) of object;
  TIdDNSAfterQueryEvent = procedure(ABinding: TIdSocketHandle; ADNSHeader: TDNSHeader; var QueryResult: TIdBytes; var ResultCode: string; Query : TIdBytes) of object;
  TIdDNSAfterCacheSaved = procedure(CacheRoot : TIdDNTreeNode) of object;

  TIdDNS_UDPServer = class(TIdUDPServer)
  private
    FBusy: Boolean;
  protected
    FAutoUpdateZoneInfo: Boolean;
    FZoneMasterFiles: TStrings;
    FRootDNS_NET: TStrings;
    FCacheUnknowZone: Boolean;
    FCached_Tree: TIdDNTreeNode;
    FHanded_Tree: TIdDNTreeNode;
    FHanded_DomainList: TStrings;
    FAutoLoadMasterFile: Boolean;
    FOnAfterQuery: TIdDNSAfterQueryEvent;
    FOnBeforeQuery: TIdDNSBeforeQueryEvent;
    FCS: TIdCriticalSection;
    FOnAfterSendBack: TIdDNSAfterQueryEvent;
    FOnAfterCacheSaved: TIdDNSAfterCacheSaved;
    FGlobalCS: TIdCriticalSection;
    FDNSVersion: string;
    FofferDNSVersion: Boolean;

    procedure DoBeforeQuery(ABinding: TIdSocketHandle; ADNSHeader: TDNSHeader;
      var ADNSQuery : TIdBytes); dynamic;

    procedure DoAfterQuery(ABinding: TIdSocketHandle; ADNSHeader: TDNSHeader;
      var QueryResult : TIdBytes; var ResultCode : String; Query : TIdBytes); dynamic;

    procedure DoAfterSendBack(ABinding: TIdSocketHandle; ADNSHeader: TDNSHeader;
      var QueryResult : TIdBytes; var ResultCode : String; Query : TIdBytes); dynamic;

    procedure DoAfterCacheSaved(CacheRoot : TIdDNTreeNode); dynamic;

    procedure SetZoneMasterFiles(const Value: TStrings);
    procedure SetRootDNS_NET(const Value: TStrings);
    procedure SetHanded_DomainList(const Value: TStrings);
    procedure InternalSearch(Header: TDNSHeader; QName: string; QType: UInt16;
      var Answer: TIdBytes; IfMainQuestion: boolean; IsSearchCache: Boolean = False;
      IsAdditional: Boolean = False; IsWildCard : Boolean = False;
      WildCardOrgName: string = '');
    procedure ExternalSearch(ADNSResolver: TIdDNSResolver; Header: TDNSHeader;
      Question: TIdBytes; var Answer: TIdBytes);
    //modified in May 2004 by Dennies Chang.
    //procedure SaveToCache(ResourceRecord : string);
    procedure SaveToCache(ResourceRecord : TIdBytes; QueryName : string; OriginalQType : UInt16);
    //procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TResultRecord); overload;
    //MoveTo Public section for RaidenDNSD.

    procedure InitComponent; override;
    // Hide this property temporily, this property is prepared to maintain the
    // TTL expired record auto updated;
    property AutoUpdateZoneInfo : boolean read FAutoUpdateZoneInfo write FAutoUpdateZoneInfo;
    property CS: TIdCriticalSection read FCS;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
  public
    destructor Destroy; override;
    function AXFR(Header : TDNSHeader; Question : string; var Answer : TIdBytes) : string;
    function CompleteQuery(DNSHeader: TDNSHeader; Question: string;
      OriginalQuestion: TIdBytes; var Answer : TIdBytes; QType, QClass : UInt16;
      DNSResolver : TIdDNSResolver) : string; {$IFDEF HAS_DEPRECATED}deprecated;{$ENDIF}
    function LoadZoneFromMasterFile(MasterFileName : String) : boolean;
    function LoadZoneStrings(FileStrings: TStrings; Filename : String;
      TreeRoot : TIdDNTreeNode): Boolean;
    function SearchTree(Root : TIdDNTreeNode; QName : String; QType : UInt16): TIdDNTreeNode;
    procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TIdTextModeResourceRecord); overload;
    function FindNodeFullName(Root : TIdDNTreeNode; QName : String; QType : UInt16) : string;
    function FindHandedNodeByName(QName : String; QType : UInt16) : TIdDNTreeNode;
    procedure UpdateTree(TreeRoot : TIdDNTreeNode; RR : TResultRecord); overload;

    property RootDNS_NET : TStrings read FRootDNS_NET write SetRootDNS_NET;
    property Cached_Tree : TIdDNTreeNode read FCached_Tree {write SetCached_Tree};
    property Handed_Tree : TIdDNTreeNode read FHanded_Tree {write SetHanded_Tree};
    property Busy : Boolean read FBusy;
    property GlobalCS : TIdCriticalSection read FGlobalCS;
  published
    property DefaultPort default IdPORT_DOMAIN;
    property AutoLoadMasterFile : Boolean read FAutoLoadMasterFile write FAutoLoadMasterFile Default False;

    //property AutoUpdateZoneInfo : boolean read FAutoUpdateZoneInfo write SetAutoUpdateZoneInfo;
    property ZoneMasterFiles : TStrings read FZoneMasterFiles write SetZoneMasterFiles;
    property CacheUnknowZone : Boolean read FCacheUnknowZone write FCacheUnknowZone default False;
    property Handed_DomainList : TStrings read FHanded_DomainList write SetHanded_DomainList;
    property DNSVersion : string read FDNSVersion write FDNSVersion;
    property offerDNSVersion : Boolean read FofferDNSVersion write FofferDNSVersion;

    property OnBeforeQuery : TIdDNSBeforeQueryEvent read FOnBeforeQuery write FOnBeforeQuery;
    property OnAfterQuery : TIdDNSAfterQueryEvent read FOnAfterQuery write FOnAfterQuery;
    property OnAfterSendBack : TIdDNSAfterQueryEvent read FOnAfterSendBack write FOnAfterSendBack;
    property OnAfterCacheSaved : TIdDNSAfterCacheSaved read FOnAfterCacheSaved write FOnAfterCacheSaved;
  end;

  TIdDNSServer = class(TIdComponent)
  protected
    FActive: Boolean;
    FTCPACLActive: Boolean;
    FServerType: TDNSServerTypes;
    FTCPTunnel: TIdDNS_TCPServer;
    FUDPTunnel: TIdDNS_UDPServer;
    FAccessList: TStrings;
    FBindings: TIdSocketHandles;
    procedure SetAccessList(const Value: TStrings);
    procedure SetActive(const Value: Boolean);
    procedure SetTCPACLActive(const Value: Boolean);
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure TimeToUpdateNodeData(Sender : TObject);
    procedure InitComponent; override;
  public
     BackupDNSMap : TIdDNSMap;

     destructor Destroy; override;
     procedure CheckIfExpire(Sender: TObject);
  published
     property Active : Boolean read FActive write SetActive;
     property AccessList : TStrings read FAccessList write SetAccessList;
     property Bindings: TIdSocketHandles read FBindings write SetBindings;

     property TCPACLActive : Boolean read FTCPACLActive write SetTCPACLActive;
     property ServerType: TDNSServerTypes read FServerType write FServerType;
     property TCPTunnel : TIdDNS_TCPServer read FTCPTunnel write FTCPTunnel;
     property UDPTunnel : TIdDNS_UDPServer read FUDPTunnel write FUDPTunnel;
  end;

implementation

uses
  {$IFDEF VCL_XE3_OR_ABOVE}
    {$IFNDEF NEXTGEN}
  System.Contnrs,
    {$ENDIF}
  System.SyncObjs,
  System.Types,
  {$ENDIF}
  IdException,
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.Threading,
  System.IO,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysTime,
  {$ENDIF}
  IdIOHandler,
  IdStack,
  SysUtils;

{Common Utilities}

function CompareItems(Item1, Item2: {$IFDEF HAS_GENERICS_TObjectList}TIdMWayTreeNode{$ELSE}TObject{$ENDIF}): Integer;
var
  LObj1, LObj2 : TIdDNTreeNode;
begin
  LObj1 := Item1 as TIdDNTreeNode;
  LObj2 := Item2 as TIdDNTreeNode;
  Result := CompareStr(LObj1.CLabel, LObj2.CLabel);
end;

// TODO: move to IdGlobal.pas
function PosBytes(const SubBytes, SBytes: TIdBytes): Integer;
var
  LSubLen, LBytesLen, I: Integer;
begin
  LSubLen := Length(SubBytes);
  LBytesLen := Length(SBytes);
  if (LSubLen > 0) and (LBytesLen >= LSubLen) then
  begin
    for Result := 0 to LBytesLen-LSubLen do
    begin
      if SBytes[Result] = SubBytes[0] then
      begin
        for I := 1 to LSubLen-1 do
        begin
          if SBytes[Result+I] <> SubBytes[I] then begin
            Break;
          end;
        end;
        if I = LSubLen then begin
          Exit;
        end;
      end;
    end;
  end;
  Result := -1;
end;

// TODO: move to IdGlobal.pas
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
    Result := ToBytes(AInput, LPos);
    if ADelete then begin
      //slower Delete(AInput, 1, LPos + Length(ADelim) - 1);
      RemoveBytes(AInput, LPos + Length(ADelim));
    end;
  end;
end;

{ TIdMWayTreeNode }

function TIdMWayTreeNode.AddChild: TIdMWayTreeNode;
begin
  Result := FundmentalClass.Create(FundmentalClass);
  try
    SubTree.Add(Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

constructor TIdMWayTreeNode.Create(NodeClass : TIdMWayTreeNodeClass);
begin
  inherited Create;
  FundmentalClass := NodeClass;
  SubTree := TIdObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdMWayTreeNode>{$ENDIF}.Create;
end;

destructor TIdMWayTreeNode.Destroy;
begin
  FreeAndNil(SubTree);
  inherited Destroy;
end;

function TIdMWayTreeNode.GetTreeNode(Index: Integer): TIdMWayTreeNode;
begin
  Result := {$IFDEF HAS_GENERICS_TObjectList}SubTree.Items[Index]{$ELSE}TIdMWayTreeNode(SubTree.Items[Index]){$ENDIF};
end;

function TIdMWayTreeNode.InsertChild(Index: Integer): TIdMWayTreeNode;
begin
  Result := FundmentalClass.Create(FundmentalClass);
  try
    SubTree.Insert(Index, Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdMWayTreeNode.RemoveChild(Index: Integer);
begin
  SubTree.Delete(Index);
end;

procedure TIdMWayTreeNode.SetFundmentalClass(const Value: TIdMWayTreeNodeClass);
begin
  FFundmentalClass := Value;
end;

procedure TIdMWayTreeNode.SetTreeNode(Index: Integer; const Value: TIdMWayTreeNode);
begin
  {$IFNDEF USE_OBJECT_ARC}
  SubTree.Items[Index].Free;
  {$ENDIF}
  SubTree.Items[Index] := Value;
end;

{ TIdDNTreeNode }

function TIdDNTreeNode.AddChild: TIdDNTreeNode;
begin
  Result := TIdDNTreeNode.Create(Self);
  try
    SubTree.Add(Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdDNTreeNode.Clear;
var
  I : Integer;
begin
  for I := SubTree.Count - 1 downto 0 do begin
    RemoveChild(I);
  end;
end;

function TIdDNTreeNode.ConvertToDNString: string;
var
  Count : Integer;
begin
  Result := '$ORIGIN ' + FullName + EOL;  {do not localize}

  for Count := 0 to RRs.Count-1 do begin
    Result := Result + RRs.Items[Count].TextRecord(FullName);
  end;

  for Count := 0 to FChildIndex.Count-1 do begin
    Result := Result + Children[Count].ConvertToDNString;
  end;
end;

constructor TIdDNTreeNode.Create(AParentNode : TIdDNTreeNode);
begin
  inherited Create(TIdDNTreeNode);
  FRRs := TIdTextModeRRs.Create;
  FChildIndex := TStringList.Create;
  FParentNode := AParentNode;
end;

destructor TIdDNTreeNode.Destroy;
begin
  FreeAndNil(FRRs);
  FreeAndNil(FChildIndex);
  inherited Destroy;
end;

function TIdDNTreeNode.DumpAllBinaryData(var RecordCount: Integer): TIdBytes;
var
  Count, ChildCount : integer;
  MyString, ChildString : TIdBytes;
begin
  SetLength(ChildString, 0);
  SetLength(MyString, 0);
  Inc(RecordCount, RRs.Count + 1);

  for Count := 0 to RRs.Count -1 do
  begin
    AppendBytes(MyString, RRs.Items[Count].BinQueryRecord(FullName));
  end;

  for Count := 0 to FChildIndex.Count -1 do
  begin
    // RLebeau: should ChildCount be set to 0 each time?
    AppendBytes(ChildString, Children[Count].DumpAllBinaryData(ChildCount));
    Inc(RecordCount, ChildCount);
  end;

  if RRs.Count > 0 then begin
    if RRs.Items[0] is TIdRR_SOA then begin
       AppendBytes(MyString, RRs.Items[0].BinQueryRecord(FullName));
       Inc(RecordCount);
    end;
  end;

  Result := MyString;
  AppendBytes(Result, ChildString);

  if RRs.Count > 0 then begin
    AppendBytes(Result, RRs.Items[0].BinQueryRecord(FullName));
  end;
end;

function TIdDNTreeNode.GetFullName: string;
begin
  if ParentNode = nil then begin
    if CLabel = '.' then begin
      Result := '';
    end else begin
      Result := CLabel;
    end;
  end else begin
    Result := CLabel + '.' + ParentNode.FullName;
  end;
end;

function TIdDNTreeNode.GetNode(Index: Integer): TIdDNTreeNode;
begin
  Result := TIdDNTreeNode(SubTree.Items[Index]);
end;

function TIdDNTreeNode.IndexByLabel(CLabel: String): Integer;
begin
  Result := FChildIndex.IndexOf(CLabel);
end;

function TIdDNTreeNode.IndexByNode(ANode: TIdDNTreeNode): Integer;
begin
  Result := SubTree.IndexOf(ANode);
end;

function TIdDNTreeNode.InsertChild(Index: Integer): TIdDNTreeNode;
begin
  Result := TIdDNTreeNode.Create(Self);
  try
    SubTree.Insert(Index, Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdDNTreeNode.RemoveChild(Index: Integer);
begin
  SubTree.Remove(SubTree.Items[Index]);
  FChildIndex.Delete(Index);
end;

procedure TIdDNTreeNode.SaveToFile(Filename: String);
var
  DNSs : TStrings;
begin
  DNSs := TStringList.Create;
  try
    DNSs.Add(ConvertToDNString);
    ToDo('SaveToFile() method of TIdDNTreeNode class is not implemented yet'); {do not localized}
//    DNSs.SaveToFile(Filename);
  finally
    FreeAndNil(DNSs);
  end;
end;

procedure TIdDNTreeNode.SetChildIndex(const Value: TStrings);
begin
  FChildIndex.Assign(Value);
end;

procedure TIdDNTreeNode.SetCLabel(const Value: String);
begin
  FCLabel := Value;
  if ParentNode <> nil then begin
     ParentNode.ChildIndex.Insert(ParentNode.SubTree.IndexOf(Self), Value);
  end;
  if AutoSortChild then begin
    SortChildren;
  end;
end;

procedure TIdDNTreeNode.SetNode(Index: Integer; const Value: TIdDNTreeNode);
begin
  SubTree.Items[Index] := Value;
end;

procedure TIdDNTreeNode.SetRRs(const Value: TIdTextModeRRs);
begin
  FRRs.Assign(Value);
end;

procedure TIdDNTreeNode.SortChildren;
begin
  SubTree.BubbleSort(CompareItems);
  TStringList(FChildIndex).Sort;
end;

{ TIdDNSServer }

{$I IdDeprecatedImplBugOff.inc}
function TIdDNS_UDPServer.CompleteQuery(DNSHeader : TDNSHeader; Question: string;
  OriginalQuestion: TIdBytes; var Answer: TIdBytes; QType, QClass: UInt16;
  DNSResolver : TIdDNSResolver): string;
{$I IdDeprecatedImplBugOn.inc}
var
  IsMyDomains : Boolean;
  LAnswer: TIdBytes;
  WildQuestion, TempDomain : string;
begin
  // QClass = 1  => IN, we support only "IN" class now.
  // QClass = 2  => CS,
  // QClass = 3  => CH,
  // QClass = 4  => HS.

  if QClass <> 1 then begin
    Result := cRCodeQueryNotImplement;
    Exit;
  end;

  TempDomain := LowerCase(Question);
  IsMyDomains := (Handed_DomainList.IndexOf(TempDomain) > -1);
  if not IsMyDomains then begin
    Fetch(TempDomain, '.');
    IsMyDomains := (Handed_DomainList.IndexOf(TempDomain) > -1);
  end;

  if IsMyDomains then begin
    InternalSearch(DNSHeader, Question, QType, LAnswer, True, False, False);
    Answer := LAnswer;

    if (QType in [TypeCode_A, TypeCode_AAAA]) and (Length(Answer) = 0) then
    begin
      InternalSearch(DNSHeader, Question, TypeCode_CNAME, LAnswer, True, False, True);
      AppendBytes(Answer, LAnswer);
    end;

    WildQuestion := Question;
    Fetch(WildQuestion, '.');
    WildQuestion := '*.' + WildQuestion;
    InternalSearch(DNSHeader, WildQuestion, QType, LAnswer, True, False, False, True, Question);
    AppendBytes(Answer, LAnswer);

    if Length(Answer) > 0 then begin
      Result := cRCodeQueryOK;
    end else begin
      Result := cRCodeQueryNotFound;
    end;
  end else
  begin
    InternalSearch(DNSHeader, Question, QType, Answer, True, True, False);

    if (QType in [TypeCode_A, TypeCode_AAAA]) and (Length(Answer) = 0) then
    begin
      InternalSearch(DNSHeader, Question, TypeCode_CNAME, LAnswer, True, True, False);
      AppendBytes(Answer, LAnswer);
    end;

    if Length(Answer) > 0 then begin
      Result := cRCodeQueryCacheOK;
      Exit;
    end;

    InternalSearch(DNSHeader, Question, TypeCode_Error, Answer, True, True, False);
    if BytesToString(Answer) = 'Error' then begin {do not localize}
      Result := cRCodeQueryCacheFindError;
      Exit;
    end;

    ExternalSearch(DNSResolver, DNSHeader, OriginalQuestion, Answer);
    if Length(Answer) > 0 then begin
      Result := cRCodeQueryReturned;
    end else begin
      Result := cRCodeQueryNotImplement;
    end;
  end
end;

procedure TIdDNS_UDPServer.InitComponent;
begin
  inherited InitComponent;

  FRootDNS_NET := TStringList.Create;
  FRootDNS_NET.Add('209.92.33.150'); // nic.net         {do not localize}
  FRootDNS_NET.Add('209.92.33.130'); // nic.net         {do not localize}
  FRootDNS_NET.Add('203.37.255.97'); // apnic.net       {do not localize}
  FRootDNS_NET.Add('202.12.29.131'); // apnic.net       {do not localize}
  FRootDNS_NET.Add('12.29.20.2');    // nanic.net       {do not localize}
  FRootDNS_NET.Add('204.145.119.2'); // nanic.net       {do not localize}
  FRootDNS_NET.Add('140.111.1.2');   // a.twnic.net.tw  {do not localize}

  FCached_Tree := TIdDNTreeNode.Create(nil);
  FCached_Tree.AutoSortChild := True;
  FCached_Tree.CLabel := '.';

  FHanded_Tree := TIdDNTreeNode.Create(nil);
  FHanded_Tree.AutoSortChild := True;
  FHanded_Tree.CLabel := '.';

  FHanded_DomainList := TStringList.Create;
  FZoneMasterFiles := TStringList.Create;

  DefaultPort := IdPORT_DOMAIN;
  FCS := TIdCriticalSection.Create;
  FGlobalCS := TIdCriticalSection.Create;
  FBusy := False;
end;

destructor TIdDNS_UDPServer.Destroy;
begin
  FreeAndNil(FCached_Tree);
  FreeAndNil(FHanded_Tree);
  FreeAndNil(FRootDNS_NET);
  FreeAndNil(FHanded_DomainList);
  FreeAndNil(FZoneMasterFiles);
  FreeAndNil(FCS);
  FreeAndNil(FGlobalCS);
  inherited Destroy;
end;

procedure TIdDNS_UDPServer.DoAfterQuery(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var QueryResult: TIdBytes; var ResultCode : String;
  Query : TIdBytes);
begin
  if Assigned(FOnAfterQuery) then begin
    FOnAfterQuery(ABinding, ADNSHeader, QueryResult, ResultCode, Query);
  end;
end;

procedure TIdDNS_UDPServer.DoBeforeQuery(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var ADNSQuery: TIdBytes);
begin
  if Assigned(FOnBeforeQuery) then begin
    FOnBeforeQuery(ABinding, ADNSHeader, ADNSQuery);
  end;
end;

procedure TIdDNS_UDPServer.ExternalSearch(ADNSResolver : TIdDNSResolver;
  Header: TDNSHeader; Question: TIdBytes; var Answer: TIdBytes);
var
  Server_Index : Integer;
  MyDNSResolver : TIdDNSResolver;
begin
  if RootDNS_NET.Count = 0 then begin
    Exit;
  end;
  Server_Index := 0;
  if ADNSResolver = nil then begin
    MyDNSResolver := TIdDNSResolver.Create(Self);
    MyDNSResolver.WaitingTime := 5000;
  end else begin
    MyDNSResolver := ADNSResolver;
  end;
  try
    repeat
      MyDNSResolver.Host := RootDNS_NET.Strings[Server_Index];
      try
        MyDNSResolver.InternalQuery := Question;
        MyDNSResolver.Resolve('');
        Answer := MyDNSResolver.PlainTextResult;
      except
        // Todo: Create DNS server interal resolver error.
        on EIdDnsResolverError do begin
          //Empty Event, for user to custom the event handle.
        end;
        on EIdSocketError do begin
        end;

        else
        begin
        end;
      end;

      Inc(Server_Index);
    until (Server_Index >= RootDNS_NET.Count) or (Length(Answer) > 0);
  finally
    if ADNSResolver = nil then begin
       FreeAndNil(MyDNSResolver);
    end;
  end;
end;

function TIdDNS_UDPServer.FindHandedNodeByName(QName: String; QType: UInt16): TIdDNTreeNode;
begin
  Result := SearchTree(Handed_Tree, QName, QType);
end;

function TIdDNS_UDPServer.FindNodeFullName(Root: TIdDNTreeNode; QName: String; QType : UInt16): string;
var
  MyNode : TIdDNTreeNode;
begin
  MyNode := SearchTree(Root, QName, QType);
  if MyNode <> nil then begin
    Result := MyNode.FullName;
  end else begin
    Result := '';
  end;
end;

function TIdDNS_UDPServer.LoadZoneFromMasterFile(MasterFileName: String): Boolean;
var
  FileStrings : TStrings;
begin
  {MakeTagList;}
  Result := FileExists(MasterFileName);

  if Result then begin
    FileStrings := TStringList.Create;
    try
      Todo('LoadZoneFromMasterFile() method of TIdDNS_UDPServer class is not implemented yet'); {do not localize}
//      FileStrings.LoadFromFile(MasterFileName);
      Result := LoadZoneStrings(FileStrings, MasterFileName, Handed_Tree);
    finally
      FreeAndNil(FileStrings);
    end;
  end;
  {FreeTagList;}
end;

function TIdDNS_UDPServer.LoadZoneStrings(FileStrings: TStrings; Filename : String;
  TreeRoot : TIdDNTreeNode): Boolean;
var
  TagList : TStrings;

  function IsMSDNSFileName(theFileName : String; var DN: string) : Boolean;
  var
    namepart : TStrings;
    Fullname : string;
    Count : Integer;
  begin
    Fullname := theFilename;
    repeat
      if Pos('\', Fullname) > 0 then begin
        Fetch(Fullname, '\');
      end;
    until Pos('\', Fullname) = 0;

    namepart := TStringList.Create;
    try
      repeat
         namepart.Add(Fetch(Fullname, '.'));
      until Fullname = '';

      Result := namepart.Strings[namepart.Count-1] = 'dns';  {do not localize}
      if Result then begin
        Count := 0;
        DN := namepart.Strings[Count];
        repeat
          Inc(Count);
          if Count <= namepart.Count -2 then begin
            DN := DN + '.' + namepart.Strings[Count];
          end;
        until Count >= (namepart.Count-2);
      end;
    finally
      FreeAndNil(namepart);
    end;
  end;

  procedure MakeTagList;
  begin
    TagList := TStringList.Create;
    try
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
    except
      FreeAndNil(TagList);
      raise;
    end;
  end;

  procedure FreeTagList;
  begin
    FreeAndNil(TagList);
  end;

  function ClearDoubleQutoa(Strs : TStrings): Boolean;
  var
    SSCount : Integer;
    Mark, Found : Boolean;
  begin
    SSCount := 0;
    Mark := False;

    while SSCount <= (Strs.Count-1) do begin
      Found := Pos('"', Strs.Strings[SSCount]) > 0;
      while Found do begin
        Mark := Mark xor Found;
        Strs.Strings[SSCount] := ReplaceSpecString(Strs.Strings[SSCount], '"', '', False);
        Found := Pos('"', Strs.Strings[SSCount]) > 0;
      end;

      if not Mark then begin
        Inc(SSCount);
      end else begin
        Strs.Strings[SSCount] := Strs.Strings[SSCount] + ' ' + Strs.Strings[SSCount + 1];
        Strs.Delete(SSCount + 1);
      end;
    end;

    Result := not Mark;
  end;

  function IsValidMasterFile : Boolean;
  var
    EachLinePart : TStrings;
    CurrentLineNum, TagField, Count : Integer;
    LineData, DataBody, {Comment,} FPart, LTag : string;
    Denoted, Stop, PassQuota : Boolean;
  begin
    EachLinePart := TStringList.Create;
    try
      CurrentLineNum := 0;
      Stop := False;
      // Check Denoted;
      Denoted := false;

      if FileStrings.Count > 0 then begin
        repeat
          LineData := Trim(FileStrings.Strings[CurrentLineNum]);
          DataBody := Fetch(LineData, ';');
          //Comment := LineData;
          PassQuota := Pos('(', DataBody) = 0;

          // Split each item into TStrings.
          repeat
            if not PassQuota then begin
              Inc(CurrentLineNum);
              LineData := Trim(FileStrings.Strings[CurrentLineNum]);
              DataBody := DataBody + ' ' + Fetch(LineData, ';');
              PassQuota := Pos(')', DataBody) > 0;
            end;
          until PassQuota or (CurrentLineNum > (FileStrings.Count-1));

          Stop := not PassQuota;

          if not Stop then begin
            EachLinePart.Clear;
            DataBody := ReplaceSpecString(DataBody, '(', '');
            DataBody := ReplaceSpecString(DataBody, ')', '');

            repeat
              DataBody := Trim(DataBody);
              FPart := Fetch(DataBody, #9);

              repeat
                FPart := Trim(FPart);
                LTag := Fetch(FPart,' ');

                if (LTag <> '') and (LTag <> '(') and (LTag <> ')') then begin
                  EachLinePart.Add(LTag);
                end;
              until FPart = '';
            until DataBody = '';

            if not Denoted then begin
              if EachLinePart.Count > 1 then begin
                Denoted := (EachLinePart.Strings[0] = cOrigin) or (EachLinePart.IndexOf(cSOA) <> -1);
              end else begin
                Denoted := False;
              end;
            end;

            // Check Syntax;
            if not ((EachLinePart.Count > 0) and (EachLinePart.Strings[0] = cOrigin)) then
            begin
              if not Denoted then begin
                if EachLinePart.Count > 0 then begin
                  Stop := (EachLinePart.Count > 0) and (EachLinePart.IndexOf(cSOA) = -1);
                end else begin
                  Stop := False;
                end;
              end else begin
                //TagField := -1;
                //FieldCount := 0;

                // Search Tag Named 'IN';
                TagField := EachLinePart.IndexOf('IN'); {do not localize}

                if TagField = -1 then begin
                  Count := 0;
                  repeat
                    if EachLinePart.Count > 0 then begin
                      TagField := TagList.IndexOf(EachLinePart.Strings[Count]);
                    end;
                    Inc(Count);
                  until (Count >= EachLinePart.Count -1) or (TagField <> -1);

                  if TagField <> -1 then begin
                    TagField := Count;
                  end;
                end else begin
                  if TagList.IndexOf(EachLinePart.Strings[TagField + 1]) = -1 then begin
                    TagField := -1;
                  end else begin
                    Inc(TagField);
                  end;
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

                    // HINFO should has 2 fields : CPU and OS. but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_HINFO:
                      begin
                        Stop := not (ClearDoubleQutoa(EachLinePart) and
                          ((EachLinePart.Count - TagField - 1) = 2));
                      end;

                    // Check RMailBX and EMailBX  but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_MINFO:
                      begin
                        Stop := ((EachLinePart.Count - TagField - 1) <> 2);
                        if not Stop then begin
                          Stop :=  not (IsHostName(EachLinePart.Strings[TagField + 1]) and
                            IsHostName(EachLinePart.Strings[TagField + 2]));
                        end;
                      end;

                    // Check Pref(Numeric) and Exchange.  but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_MX:
                      begin
                        Stop := ((EachLinePart.Count - TagField - 1) <> 2);
                        if not Stop then begin
                          Stop := not (IsNumeric(EachLinePart.Strings[TagField + 1]) and
                            IsHostName(EachLinePart.Strings[TagField + 2]));
                        end;
                      end;

                    // TStrings is 0 base, so that we have to minus one
                    TypeCode_SOA:
                      begin
                        Stop := ((EachLinePart.Count - TagField - 1) <> 7);
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

                    TypeCode_WKS: Stop := ((EachLinePart.Count - TagField) = 1);
                  end;
                end else begin
                  if EachLinePart.Count > 0 then
                    Stop := True;
                  end;
                end;
              end;
            end;
            Inc(CurrentLineNum);
         until (CurrentLineNum > (FileStrings.Count-1)) or Stop;
      end;
      Result := not Stop;
    finally
      FreeAndNil(EachLinePart);
    end;
  end;

  function LoadMasterFile : Boolean;
  var
    Checks, EachLinePart, DenotedDomain : TStrings;
    CurrentLineNum,  TagField, Count, LastTTL : Integer;
    LineData, DataBody,  FPart, LTag, LText,
      RName, LastDenotedDomain, LastTag, NewDomain, SingleHostName {CH: , PrevDNTag}  : string;
    Stop, PassQuota, Found {, canChangPrevDNTag } : Boolean;
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
    EachLinePart := TStringList.Create;
    try
      DenotedDomain := TStringList.Create;
      try
        CurrentLineNum := 0;
        LastDenotedDomain := '';
        LastTag := '';
        NewDomain := '';
      //  PrevDNTag := '';
        Stop := False;
        //canChangPrevDNTag := True;

        if IsMSDNSFileName(FileName, LastDenotedDomain) then begin
          //canChangPrevDNTag := False;
          Filename := Uppercase(Filename);
        end else begin
          LastDenotedDomain := '';
        end;

        if FileStrings.Count > 0 then begin
          repeat
            LineData := Trim(FileStrings.Strings[CurrentLineNum]);
            DataBody := Fetch(LineData, ';');
       //     Comment := LineData;
            PassQuota := Pos('(', DataBody) = 0;

            // Split each item into TStrings.
            repeat
              if not PassQuota then begin
                Inc(CurrentLineNum);
                LineData := Trim(FileStrings.Strings[CurrentLineNum]);
                DataBody := DataBody + ' ' + Fetch(LineData, ';');
                PassQuota := Pos(')', DataBody) > 0;
              end;
            until PassQuota;

            EachLinePart.Clear;
            DataBody := ReplaceSpecString(DataBody, '(', '');
            DataBody := ReplaceSpecString(DataBody, ')', '');
            repeat
              DataBody := Trim(DataBody);
              FPart := Fetch(DataBody, #9);

              repeat
                FPart := Trim(FPart);
                if Pos('"', FPart) = 1 then begin
                  Fetch(FPart, '"');
                  LText := Fetch(FPart, '"');
                  EachLinePart.Add(LText);
                end;

                LTag := Fetch(FPart, ' ');
                if (TagList.IndexOf(LTag) = -1) and (LTag <> 'IN') then begin {do not localize}
                  LTag := LowerCase(LTag);
                end;

                if (LTag <> '') and (LTag <> '(') and (LTag <> ')') then begin
                  EachLinePart.Add(LTag);
                end;
              until FPart = '';
            until DataBody = '';

            if EachLinePart.Count > 0 then begin
              if EachLinePart.Strings[0] = cOrigin then begin
                // One Domain is found.
                NewDomain := EachLinePart.Strings[1];
                if TextEndsWith(NewDomain, '.') then begin
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
                  Found := TagList.IndexOf(EachLinePart.Strings[Count]) > -1;
                  if Found then begin
                    TagField := Count;
                  end;
                  Inc(Count);
                until Found or (Count > (EachLinePart.Count-1));

                // To initialize LastTTL;
                LastTTL := 86400;
                if TagField > -1 then begin
                  case TagField of
                    1 :
                      if EachLinePart.Strings[0] <> 'IN' then begin {do not localize}
//                        canChangPrevDNTag := True;
                        LastTag := EachLinePart.Strings[0];
                        if EachLinePart.Strings[TagField] <> 'SOA' then begin  {do not localize}
                         // PrevDNTag := '';
                        end else begin
                          LastTTL := IndyStrToInt(EachLinePart.Strings[TagField + 6]);
                        end;
//                      end else begin
//                        canChangPrevDNTag := False;
                      end;
                    2 :
                      if EachLinePart.Strings[1] = 'IN' then begin  {do not localize}
                        LastTag := EachLinePart.Strings[0];
//                        canChangPrevDNTag := True;
                        if EachLinePart.Strings[TagField] <> 'SOA' then begin  {do not localize}
                         // PrevDNTag := '';
                        end else begin
                          LastTTL := IndyStrToInt(EachLinePart.Strings[TagField + 6]);
                        end;
                      end else begin
//                        canChangPrevDNTag := False;
                      end;
                    else
                      begin
//                        canChangPrevDNTag := False;
                        LastTTL := 86400;
                      end;
                  end;

                  //if (EachLinePart.Strings[0] = cAt) or (PrevDNTag = 'SOA') then
                  if EachLinePart.Strings[0] = cAt then begin
                    SingleHostName := LastDenotedDomain
                  end else begin
                    if LastTag = cAt then begin
                      LastTag := SingleHostName;
                    end;
                    if not TextEndsWith(LastTag, '.') then begin
                      SingleHostName := LastTag + '.' + LastDenotedDomain
                    end else begin
                      SingleHostName := LastTag;
                    end;
                  end;

                  case TagList.IndexOf(EachLinePart.Strings[TagField]) of
                    // Check ip
                    TypeCode_A :
                      begin
                        LLRR_A := TIdRR_A.Create;
                        LLRR_A.RRName := SingleHostName;
                        LLRR_A.Address := EachLinePart.Strings[TagField + 1];
                        LLRR_A.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_A);
                      //  if canChangPrevDNTag then begin
                      //    PrevDNTag := 'A';
                      //  end;
                      end;

                    // Check IPv6 ip address 10/29,2002
                    0 :
                      begin
                        LLRR_AAAA := TIdRR_AAAA.Create;
                        LLRR_AAAA.RRName := SingleHostName;
                        LLRR_AAAA.Address := ConvertToValidv6IP(EachLinePart.Strings[TagField + 1]);
                        LLRR_AAAA.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_AAAA);
                      //  if canChangPrevDNTag then begin
                      //    PrevDNTag := 'AAAA'; {do not localize}
                      //  end;
                      end;

                    // Check Domain Name
                    TypeCode_CName:
                      begin
                        LLRR_Name := TIdRR_CName.Create;
                        LLRR_Name.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_Name.CName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_Name.CName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_Name.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_Name);
                       // if canChangPrevDNTag then begin
                       //   PrevDNTag := 'CNAME'; {do not localize}
                       // end;
                      end;

                    TypeCode_NS :
                      begin
                        LLRR_NS := TIdRR_NS.Create;
                        LLRR_NS.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_NS.NSDName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_NS.NSDName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_NS.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_NS);
                      //  if canChangPrevDNTag then begin
                      //    PrevDNTag := 'NS';  {do not localize}
                      //  end;
                      end;

                    TypeCode_MR :
                      begin
                        LLRR_MR := TIdRR_MR.Create;
                        LLRR_MR.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_MR.NewName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_MR.NewName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_MR.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_MR);
                       // if canChangPrevDNTag then begin
                       //   PrevDNTag := 'MR';  {do not localize}
                       // end;
                      end;

                    TypeCode_MD, TypeCode_MB, TypeCode_MF :
                      begin
                        LLRR_MB := TIdRR_MB.Create;
                        LLRR_MB.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_MB.MADName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_MB.MADName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_MB.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_MB);
                        // if canChangPrevDNTag then begin
                        //  PrevDNTag := 'MF';  {do not localize}
                        // end;
                      end;

                    TypeCode_MG :
                      begin
                        LLRR_MG := TIdRR_MG.Create;
                        LLRR_MG.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_MG.MGMName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_MG.MGMName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_MG.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_MG);
                        // if canChangPrevDNTag then begin
                        //  PrevDNTag := 'MG'; {do not localize}
                        // end;
                      end;

                    // Can be anything
                    TypeCode_TXT, TypeCode_NULL:
                      begin
                        LLRR_TXT := TIdRR_TXT.Create;
                        LLRR_TXT.RRName := SingleHostName;
                        LLRR_TXT.TXT := EachLinePart.Strings[TagField + 1];
                        LLRR_TXT.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_TXT);
                       // if canChangPrevDNTag then begin
                       //   PrevDNTag := 'TXT';  {do not localize}
                       // end;
                      end;

                    // Must be FQDN.
                    TypeCode_PTR:
                      begin
                        LLRR_PTR := TIdRR_PTR.Create;
                        LLRR_PTR.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_PTR.PTRDName := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_PTR.PTRDName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;
                        LLRR_PTR.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_PTR);
                        // if canChangPrevDNTag then begin
                        //  PrevDNTag := 'PTR';  {do not localize}
                        // end;
                      end;

                    // HINFO should has 2 fields : CPU and OS. but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_HINFO:
                      begin
                        ClearDoubleQutoa(EachLinePart);

                        LLRR_HINFO := TIdRR_HINFO.Create;
                        LLRR_HINFO.RRName := SingleHostName;
                        LLRR_HINFO.CPU := EachLinePart.Strings[TagField + 1];
                        LLRR_HINFO.OS := EachLinePart.Strings[TagField + 2];
                        LLRR_HINFO.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_HINFO);
                       // if canChangPrevDNTag then begin
                       //   PrevDNTag := 'HINFO';  {do not localize}
                       // end;
                      end;

                    // Check RMailBX and EMailBX but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_MINFO:
                      begin
                        LLRR_MINFO := TIdRR_MINFO.Create;
                        LLRR_MINFO.RRName := SingleHostName;
                        if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                          LLRR_MINFO.Responsible_Mail := EachLinePart.Strings[TagField + 1];
                        end else begin
                          LLRR_MINFO.Responsible_Mail := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                        end;

                        if TextEndsWith(EachLinePart.Strings[TagField + 2], '.') then begin
                          LLRR_MINFO.ErrorHandle_Mail := EachLinePart.Strings[TagField + 2];
                        end else begin
                          LLRR_MINFO.ErrorHandle_Mail := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;
                        end;

                        LLRR_MINFO.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_MINFO);
                      //  if canChangPrevDNTag then begin
                      //    PrevDNTag := 'MINFO'; {do not localize}
                      //  end;
                      end;

                    // Check Pref(Numeric) and Exchange. but TStrings
                    // is 0 base, so that we have to minus one
                    TypeCode_MX:
                      begin
                        LLRR_MX := TIdRR_MX.Create;
                        LLRR_MX.RRName := SingleHostName;
                        LLRR_MX.Preference := EachLinePart.Strings[TagField + 1];
                        if TextEndsWith(EachLinePart.Strings[TagField + 2], '.') then begin
                          LLRR_MX.Exchange := EachLinePart.Strings[TagField + 2];
                        end else begin
                          LLRR_MX.Exchange := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;
                        end;
                        LLRR_MX.TTL := LastTTL;

                        UpdateTree(TreeRoot, LLRR_MX);
                      //  if canChangPrevDNTag then begin
                      //    PrevDNTag := 'MX'; {do not localize}
                      //  end;
                      end;

                      // TStrings is 0 base, so that we have to minus one
                      TypeCode_SOA:
                        begin
                          LLRR_SOA := TIdRR_SOA.Create;

                          if TextEndsWith(EachLinePart.Strings[TagField + 1], '.') then begin
                            LLRR_SOA.MName := EachLinePart.Strings[TagField + 1];
                          end else begin
                            LLRR_SOA.MName := EachLinePart.Strings[TagField + 1] + '.' + LastDenotedDomain;
                          end;

                          //LLRR_SOA.RRName:= LLRR_SOA.MName;
                          if (SingleHostName = '') and (LastDenotedDomain = '') then begin
                            {$IFDEF STRING_IS_UNICODE}
                            LastDenotedDomain := String(LLRR_SOA.MName); // explicit convert to Unicode
                            {$ELSE}
                            LastDenotedDomain := LLRR_SOA.MName;
                            {$ENDIF}
                            Fetch(LastDenotedDomain, '.');
                            SingleHostName := LastDenotedDomain;
                          end;
                          LLRR_SOA.RRName := SingleHostName;

                          // Update the Handed List
                          {
                          if Handed_DomainList.IndexOf(LLRR_SOA.MName) = -1 then begin
                            Handed_DomainList.Add(LLRR_SOA.MName);
                          end;
                          }
                          if Handed_DomainList.IndexOf(LLRR_SOA.RRName) = -1 then begin
                            Handed_DomainList.Add(LLRR_SOA.RRName);
                          end;

                          {
                          if DenotedDomain.IndexOf(LLRR_SOA.MName) = -1 then begin
                            DenotedDomain.Add(LLRR_SOA.MName);
                          end;
                          LastDenotedDomain := LLRR_SOA.MName;
                          }

                          if DenotedDomain.IndexOf(LLRR_SOA.RRName) = -1 then begin
                            DenotedDomain.Add(LLRR_SOA.RRName);
                          end;
                          //LastDenotedDomain := LLRR_SOA.RRName;

                          if TextEndsWith(EachLinePart.Strings[TagField + 2], '.') then begin
                            LLRR_SOA.RName := EachLinePart.Strings[TagField + 2];
                          end else begin
                            LLRR_SOA.RName := EachLinePart.Strings[TagField + 2] + '.' + LastDenotedDomain;
                          end;

                          Checks := TStringList.Create;
                          try
                            {$IFDEF STRING_IS_UNICODE}
                            RName := String(LLRR_SOA.RName); // explicit convert to Unicode
                            {$ELSE}
                            RName := LLRR_SOA.RName;
                            {$ENDIF}

                            while RName <> '' do begin
                              Checks.Add(Fetch(RName, '.'));
                            end;

                            RName := '';
                            For Count := 0 to Checks.Count -1 do begin
                              if Checks.Strings[Count] <> '' then begin
                                RName := RName + Checks.Strings[Count] + '.';
                              end;
                            end;

                            LLRR_SOA.RName := RName;
                          finally
                            FreeAndNil(Checks);
                          end;

                          LLRR_SOA.Serial := EachLinePart.Strings[TagField + 3];
                          LLRR_SOA.Refresh := EachLinePart.Strings[TagField + 4];
                          LLRR_SOA.Retry := EachLinePart.Strings[TagField + 5];
                          LLRR_SOA.Expire := EachLinePart.Strings[TagField + 6];
                          LLRR_SOA.Minimum := EachLinePart.Strings[TagField + 7];
                          LastTTL := IndyStrToInt(LLRR_SOA.Expire);
                          LLRR_SOA.TTL := LastTTL;
                          UpdateTree(TreeRoot, LLRR_SOA);

                          // if canChangPrevDNTag then begin
                          //   PrevDNTag := 'SOA'; {do not localize}
                          // end;
                        end;

                      TypeCode_WKS:
                        begin
                         // if canChangPrevDNTag then begin
                         //   PrevDNTag := 'WKS'; {do not localize}
                         // end;
                        end;
                  end;
                end;
              end; // if EachLinePart.Count == 0 => Only Comment
            end;
            Inc(CurrentLineNum);
          until (CurrentLineNum > (FileStrings.Count -1));
        end;
        Result := not Stop;
      finally
        FreeAndNil(DenotedDomain);
      end;
    finally
      FreeAndNil(EachLinePart);
    end;
   end;

begin
  MakeTagList;
  try
    Result := IsValidMasterFile;
    // IsValidMasterFile is used in local, so I design with not
    // any parameter.
    if Result then begin
      Result := LoadMasterFile;
    end;
  finally
    FreeTagList;
  end;
end;

procedure TIdDNS_UDPServer.SaveToCache(ResourceRecord: TIdBytes; QueryName : string; OriginalQType : UInt16);
var
  TempResolver : TIdDNSResolver;
  Count : Integer;
begin
  TempResolver := TIdDNSResolver.Create(nil);
  try
    // RLebeau: FillResultWithOutCheckId() is deprecated, but not using FillResult()
    // here yet because it validates the DNSHeader.RCode, and I do not know if that
    // is needed here. I don't want to break this logic...
    TempResolver.FillResultWithOutCheckId(ResourceRecord);
    if TempResolver.DNSHeader.ANCount > 0 then begin
      for Count := 0 to TempResolver.QueryResult.Count - 1 do begin
        UpdateTree(Cached_Tree, TempResolver.QueryResult.Items[Count]);
      end;
    end;
  finally
    FreeAndNil(TempResolver);
  end;
end;

function TIdDNS_UDPServer.SearchTree(Root: TIdDNTreeNode; QName: String; QType : UInt16): TIdDNTreeNode;
var
  RRIndex : integer;
  NodeCursor : TIdDNTreeNode;
  NameLabels : TStrings;
  OneNode, FullName : string;
  Found : Boolean;
begin
  Result := nil;
  NameLabels := TStringList.Create;
  try
    FullName := QName;
    NodeCursor := Root;
    Found := False;

    repeat
      OneNode := Fetch(FullName, '.');
      if OneNode <> '' then begin
        NameLabels.Add(OneNode);
      end;
    until FullName = '';

    repeat
      if QType <> TypeCode_SOA then begin
        RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
        if RRIndex <> -1 then begin
          NameLabels.Delete(NameLabels.Count - 1);
          NodeCursor := NodeCursor.Children[RRIndex];

          if NameLabels.Count = 1 then begin
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
          end else begin
            Found := NameLabels.Count = 0;
          end;
        end else begin
          if NameLabels.Count = 1 then begin
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
            if not Found then begin
              NameLabels.Clear;
            end;
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
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
          end else begin
            Found := NameLabels.Count = 0;
          end;
        end else begin
          if NameLabels.Count = 1 then begin
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
            if not Found then begin
              NameLabels.Clear;
            end;
          end else begin
            NameLabels.Clear;
          end;
        end;
      end;
    until (NameLabels.Count = 0) or Found;

    if Found then begin
      Result := NodeCursor;
    end;
  finally
    FreeAndNil(NameLabels);
  end;
end;

procedure TIdDNS_UDPServer.SetHanded_DomainList(const Value: TStrings);
begin
  FHanded_DomainList.Assign(Value);
end;

procedure TIdDNS_UDPServer.SetRootDNS_NET(const Value: TStrings);
begin
  FRootDNS_NET.Assign(Value);
end;

procedure TIdDNS_UDPServer.SetZoneMasterFiles(const Value: TStrings);
begin
  FZoneMasterFiles.Assign(Value);
end;

procedure TIdDNS_UDPServer.UpdateTree(TreeRoot: TIdDNTreeNode; RR: TResultRecord);
var
  NameNode : TStrings;
  RRName, APart : String;
  Count, NodeIndex : Integer;
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
  NameNode := TStringList.Create;
  try
    RRName := RR.Name;
    repeat
      APart := Fetch(RRName, '.');
      if APart <> '' then begin
        NameNode.Add(APart);
      end;
    until RRName = '';

    NodeCursor := TreeRoot;
    RRName := RR.Name;
    if not TextEndsWith(RRName, '.') then begin
      RRName := RRName + '.';
    end;
    if (RR.RecType <> qtSOA) and (Handed_DomainList.IndexOf(LowerCase(RRName)) = -1) and (RR.RecType <> qtNS) then begin
      for Count := NameNode.Count-1 downto 1 do begin
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
      for Count := NameNode.Count-1 downto 0 do begin
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
      qtA :
        begin
          LRR_A := TIdRR_A.Create;
          try
            NodeCursor.RRs.Add(LRR_A);
          except
            LRR_A.Free;
            raise;
          end;

          LRR_A.RRName := RRName;
          LRR_A.Address := TARecord(RR).IPAddress;
          LRR_A.TTL := TARecord(RR).TTL;

          if LRR_A.ifAddFullName(NodeCursor.FullName) then begin
            LRR_A.RRName := LRR_A.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtAAAA :
        begin
          LRR_AAAA := TIdRR_AAAA.Create;
          try
            NodeCursor.RRs.Add(LRR_AAAA);
          except
            LRR_AAAA.Free;
            raise;
          end;

          LRR_AAAA.RRName := RRName;
          LRR_AAAA.Address := TAAAARecord(RR).Address;
          LRR_AAAA.TTL := TAAAARecord(RR).TTL;

          if LRR_AAAA.ifAddFullName(NodeCursor.FullName) then begin
            LRR_AAAA.RRName := LRR_AAAA.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtNS:
        begin
          LRR_NS := TIdRR_NS.Create;
          try
            NodeCursor.RRs.Add(LRR_NS);
          except
            LRR_NS.Free;
            raise;
          end;

          LRR_NS.RRName := RRName;
          LRR_NS.NSDName := TNSRecord(RR).HostName;
          LRR_NS.TTL := TNSRecord(RR).TTL;

          if LRR_NS.ifAddFullName(NodeCursor.FullName) then begin
            LRR_NS.RRName := LRR_NS.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtMD, qtMF, qtMB:
        begin
          LRR_MB := TIdRR_MB.Create;
          try
            NodeCursor.RRs.Add(LRR_MB);
          except
            LRR_MB.Free;
            raise;
          end;

          LRR_MB.RRName := RRName;
          LRR_MB.MADName := TNAMERecord(RR).HostName;
          LRR_MB.TTL := TNAMERecord(RR).TTL;

          if LRR_MB.ifAddFullName(NodeCursor.FullName) then begin
            LRR_MB.RRName := LRR_MB.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtName:
        begin
          LRR_Name := TIdRR_CName.Create;
          try
            NodeCursor.RRs.Add(LRR_Name);
          except
            LRR_Name.Free;
            raise;
          end;

          LRR_Name.RRName := RRName;
          LRR_Name.CName := TNAMERecord(RR).HostName;
          LRR_Name.TTL:= TNAMERecord(RR).TTL;

          if LRR_Name.ifAddFullName(NodeCursor.FullName) then begin
            LRR_Name.RRName := LRR_Name.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtSOA:
        begin
          LRR_SOA := TIdRR_SOA.Create;
          try
            NodeCursor.RRs.Add(LRR_SOA);
          except
            LRR_SOA.Free;
            raise;
          end;

          LRR_SOA.RRName := RRName;

          LRR_SOA.MName := TSOARecord(RR).Primary;
          LRR_SOA.RName := TSOARecord(RR).ResponsiblePerson;
          LRR_SOA.Serial := IntToStr(TSOARecord(RR).Serial);
          LRR_SOA.Minimum := IntToStr(TSOARecord(RR).MinimumTTL);
          LRR_SOA.Refresh := IntToStr(TSOARecord(RR).Refresh);
          LRR_SOA.Retry := IntToStr(TSOARecord(RR).Retry);
          LRR_SOA.Expire := IntToStr(TSOARecord(RR).Expire);
          LRR_SOA.TTL:= TSOARecord(RR).TTL;

          if LRR_SOA.ifAddFullName(NodeCursor.FullName) then begin
            LRR_SOA.RRName := LRR_SOA.RRName + '.'+ NodeCursor.FullName;
          end
          else if not TextEndsWith(LRR_SOA.RRName, '.') then begin
            LRR_SOA.RRName := LRR_SOA.RRName + '.';
          end;
        end;
      qtMG :
        begin
          LRR_MG := TIdRR_MG.Create;
          try
            NodeCursor.RRs.Add(LRR_MG);
          except
            LRR_MG.Free;
            raise;
          end;

          LRR_MG.RRName := RRName;
          LRR_MG.MGMName := TNAMERecord(RR).HostName;
          LRR_MG.TTL := TNAMERecord(RR).TTL;

          if LRR_MG.ifAddFullName(NodeCursor.FullName) then begin
            LRR_MG.RRName := LRR_MG.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtMR :
        begin
          LRR_MR := TIdRR_MR.Create;
          try
            NodeCursor.RRs.Add(LRR_MR);
          except
            LRR_MR.Free;
            raise;
          end;

          LRR_MR.RRName := RRName;
          LRR_MR.NewName := TNAMERecord(RR).HostName;
          LRR_MR.TTL := TNAMERecord(RR).TTL;

          if LRR_MR.ifAddFullName(NodeCursor.FullName) then begin
            LRR_MR.RRName := LRR_MR.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtWKS:
        begin
        end;
      qtPTR:
        begin
          LRR_PTR := TIdRR_PTR.Create;
          try
            NodeCursor.RRs.Add(LRR_PTR);
          except
            LRR_PTR.Free;
            raise;
          end;

          LRR_PTR.RRName := RRName;
          LRR_PTR.PTRDName := TPTRRecord(RR).HostName;
          LRR_PTR.TTL := TPTRRecord(RR).TTL;

          if LRR_PTR.ifAddFullName(NodeCursor.FullName) then begin
            LRR_PTR.RRName := LRR_PTR.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtHINFO:
        begin
          LRR_HINFO := TIdRR_HINFO.Create;
          try
            NodeCursor.RRs.Add(LRR_HINFO);
          except
            LRR_HINFO.Free;
            raise;
          end;

          LRR_HINFO.RRName := RRName;
          LRR_HINFO.CPU :=  THINFORecord(RR).CPU;
          LRR_HINFO.OS := THINFORecord(RR).OS;
          LRR_HINFO.TTL := THINFORecord(RR).TTL;

          if LRR_HINFO.ifAddFullName(NodeCursor.FullName) then begin
            LRR_HINFO.RRName := LRR_HINFO.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtMINFO:
        begin
          LRR_MINFO := TIdRR_MINFO.Create;
          try
            NodeCursor.RRs.Add(LRR_MINFO);
          except
            LRR_MINFO.Free;
            raise;
          end;

          LRR_MINFO.RRName := RRName;
          LRR_MINFO.Responsible_Mail := TMINFORecord(RR).ResponsiblePersonMailbox;
          LRR_MINFO.ErrorHandle_Mail := TMINFORecord(RR).ErrorMailbox;
          LRR_MINFO.TTL := TMINFORecord(RR).TTL;

          if LRR_MINFO.ifAddFullName(NodeCursor.FullName) then begin
            LRR_MINFO.RRName := LRR_MINFO.RRName + '.' + NodeCursor.FullName;
          end;
        end;
      qtMX:
        begin
          LRR_MX := TIdRR_MX.Create;
          try
            NodeCursor.RRs.Add(LRR_MX);
          except
            LRR_MX.Free;
            raise;
          end;

          LRR_MX.RRName := RRName;
          LRR_MX.Exchange := TMXRecord(RR).ExchangeServer;
          LRR_MX.Preference := IntToStr(TMXRecord(RR).Preference);
          LRR_MX.TTL := TMXRecord(RR).TTL;

          if LRR_MX.ifAddFullName(NodeCursor.FullName) then begin
            LRR_MX.RRName := LRR_MX.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
      qtTXT, qtNULL:
        begin
          LRR_TXT := TIdRR_TXT.Create;
          try
            NodeCursor.RRs.Add(LRR_TXT);
          except
            LRR_TXT.Free;
            raise;
          end;

          LRR_TXT.RRName := RRName;
          LRR_TXT.TXT := TTextRecord(RR).Text.Text;
          LRR_TXT.TTL := TTextRecord(RR).TTL;

          if LRR_TXT.ifAddFullName(NodeCursor.FullName) then begin
            LRR_TXT.RRName := LRR_TXT.RRName + '.'+ NodeCursor.FullName;
          end;
        end;
    end;
  finally
    FreeAndNil(NameNode);
  end;
end;

procedure TIdDNS_UDPServer.UpdateTree(TreeRoot: TIdDNTreeNode; RR: TIdTextModeResourceRecord);
var
  NameNode : TStrings;
  RRName, APart : String;
  Count, NodeIndex, RRIndex : Integer;
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
  NameNode := TStringList.Create;
  try
    RRName := RR.RRName;
    repeat
      APart := Fetch(RRName, '.');
      if APart <> '' then begin
        NameNode.Add(APart);
      end;
    until RRName = '';

    NodeCursor := TreeRoot;
    RRName := RR.RRName;
    if not TextEndsWith(RRName, '.') then begin
      RR.RRName := RR.RRName + '.';
    end;

    // VC: in2002-02-24-1715, it just denoted TIdRR_A and TIdRR_PTR,
    //     but that make search a domain name RR becoming complex,
    //     therefor I replace it with all RRs but not TIdRR_SOA
    //     SOA should own independent node.
    if (not (RR is TIdRR_SOA)) and (Handed_DomainList.IndexOf(LowerCase(RR.RRName)) = -1) then begin
      for Count := NameNode.Count - 1 downto 1 do begin
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
      for Count := NameNode.Count -1 downto 0 do begin
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
    if RRIndex = -1 then begin
      NodeCursor.RRs.ItemNames.Add(RRName);
    end else begin
      repeat
        Inc(RRIndex);
        if RRIndex > NodeCursor.RRs.ItemNames.Count -1 then begin
          RRIndex := -1;
          Break;
        end;
        if NodeCursor.RRs.ItemNames.Strings[RRIndex] <> RRName then begin
          Break;
        end;
      until RRIndex > (NodeCursor.RRs.ItemNames.Count-1);

      if RRIndex = -1 then begin
        NodeCursor.RRs.ItemNames.Add(RRName);
      end else begin
        NodeCursor.RRs.ItemNames.Insert(RRIndex, RRName);
      end;
    end;

    case RR.TypeCode of
      TypeCode_Error :
        begin
          LRR_Error := TIdRR_Error(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_Error);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_Error);
          end;
        end;
      TypeCode_A :
        begin
          LRR_A := TIdRR_A(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_A);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_A);
          end;
        end;
      TypeCode_AAAA :
        begin
          LRR_AAAA := TIdRR_AAAA(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_AAAA);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_AAAA);
          end;
        end;
      TypeCode_NS:
        begin
          LRR_NS := TIdRR_NS(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_NS);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_NS);
          end;
        end;
      TypeCode_MF:
        begin
          LRR_MB := TIdRR_MB(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_MB);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_MB);
          end;
        end;
      TypeCode_CName:
        begin
          LRR_Name := TIdRR_CName(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_Name);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_Name);
          end;
        end;
      TypeCode_SOA:
        begin
          LRR_SOA := TIdRR_SOA(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_SOA);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_SOA);
          end;
        end;
      TypeCode_MG :
        begin
          LRR_MG := TIdRR_MG(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_MG);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_MG);
          end;
        end;
      TypeCode_MR :
        begin
          LRR_MR := TIdRR_MR(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_MR);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_MR);
          end;
        end;
      TypeCode_WKS:
        begin
        end;
      TypeCode_PTR:
        begin
          LRR_PTR := TIdRR_PTR(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_PTR);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_PTR);
          end;
        end;
      TypeCode_HINFO:
        begin
          LRR_HINFO := TIdRR_HINFO(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_HINFO);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_HINFO);
          end;
        end;
      TypeCode_MINFO:
        begin
          LRR_MINFO := TIdRR_MINFO(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_MINFO);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_MINFO);
          end;
        end;
      TypeCode_MX:
        begin
          LRR_MX := TIdRR_MX(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_MX);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_MX);
          end;
        end;
      TypeCode_TXT, TypeCode_NULL:
        begin
          LRR_TXT := TIdRR_TXT(RR);
          if RRIndex = -1 then begin
            NodeCursor.RRs.Add(LRR_TXT);
          end else begin
            NodeCursor.RRs.Insert(RRIndex, LRR_TXT);
          end;
        end;
    end;
  finally
    FreeAndNil(NameNode);
  end;
end;

procedure TIdDNS_UDPServer.DoAfterSendBack(ABinding: TIdSocketHandle;
  ADNSHeader: TDNSHeader; var QueryResult: TIdBytes; var ResultCode: String;
  Query : TIdBytes);
begin
  if Assigned(FOnAfterSendBack) then begin
    FOnAfterSendBack(ABinding, ADNSHeader, QueryResult, ResultCode, Query);
  end;
end;

function TIdDNS_UDPServer.AXFR(Header : TDNSHeader; Question: string; var Answer: TIdBytes): string;
var
  TargetNode : TIdDNTreeNode;
  IsMyDomains : Boolean;
  RRcount : Integer;
  Temp: TIdBytes;
begin
  Question := LowerCase(Question);

  IsMyDomains := Handed_DomainList.IndexOf(Question) > -1;
  if not IsMyDomains then begin
    Fetch(Question, '.');
    IsMyDomains := Handed_DomainList.IndexOf(Question) > -1;
  end;

  // Is my domain, go for searching the node.
  TargetNode := nil;
  SetLength(Answer, 0);
  Header.ANCount := 0;
  if IsMyDomains then begin
    TargetNode := SearchTree(Handed_Tree, Question, TypeCode_SOA);
  end;
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
  QType : UInt16; var Answer: TIdBytes; IfMainQuestion : Boolean;
  IsSearchCache : Boolean = False; IsAdditional : Boolean = False;
  IsWildCard : Boolean = False; WildCardOrgName : string = '');
var
  MoreAddrSearch : TStrings;
  TargetNode : TIdDNTreeNode;
  Server_Index, RRIndex, Count : Integer;
  LocalAnswer, TempBytes, TempAnswer: TIdBytes;
  temp_QName, temp: string;
  AResult: TIdBytes;
  Stop, Extra, IsMyDomains, ifAdditional : Boolean;
  LDNSResolver : TIdDNSResolver;

  procedure CheckMoreAddrSearch(const AStr: String);
  begin
    if (not IsValidIP(AStr)) and IsHostName(AStr) then begin
      MoreAddrSearch.Add(AStr);
    end;
  end;

begin
  SetLength(Answer, 0);
  SetLength(Aresult, 0);
  // Search the Handed Tree first.
  MoreAddrSearch := TStringList.Create;
  try
    Extra := False;
    //Pushed := False;

    if not IsSearchCache then begin
      TargetNode := SearchTree(Handed_Tree, QName, QType);

      if TargetNode <> nil then begin //Assemble the Answer.
        RRIndex := TargetNode.RRs.ItemNames.IndexOf(LowerCase(QName));
        if RRIndex = -1 then begin
          { below are added again by Dennies Chang in 2004/7/15
          { According RFC 1035, a full domain name must be tailed by a '.',
          { but in normal behavior, user will not input '.' in last
          { position of the full name. So we have to compare both of the
          { cases. }
          if TextEndsWith(QName, '.') then begin
            QName := Copy(QName, 1, Length(QName)-1);
          end;

          RRIndex := TargetNode.RRs.ItemNames.IndexOf(LowerCase(QName));
          { above are added again by Dennies Chang in 2004/7/15}

          if RRIndex = -1 then begin
            QName := Fetch(QName, '.');
            RRIndex := TargetNode.RRs.ItemNames.IndexOf(LowerCase(QName));
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
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_MD:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_MF:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_CName:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_CName then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_SOA:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_SOA then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName);
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_MB:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_MG:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MG then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_MR:
                begin
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_MR then begin
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName);
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
                end;
              TypeCode_NULL:
                begin
                  {
                  if TargetNode.RRs.Items[RRIndex] is TIdRR_NULL then begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
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
                    CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MX).Exchange);
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
                begin
                  LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                end;
            end;

            if IsWildCard and (Length(LocalAnswer) > 0) then begin
              {
              temp := DomainNameToDNSStr(QName+'.'+TargetNode.FullName);
              Fetch(LocalAnswer, temp);
              }
              TempBytes := DomainNameToDNSStr(TargetNode.FullName);
              FetchBytes(LocalAnswer, TempBytes);
              TempBytes := DomainNameToDNSStr(WildCardOrgName);
              AppendBytes(TempBytes, LocalAnswer);
              LocalAnswer := TempBytes;
              //LocalAnswer := DomainNameToDNSStr(WildCardOrgName) + LocalAnswer;
            end;

            if Length(LocalAnswer) > 0 then begin
              AppendBytes(Answer, LocalAnswer);
              if ((not Extra) and (not IsAdditional)) or (QType = TypeCode_AAAA) then begin
                if (TargetNode.RRs.Items[RRIndex] is TIdRR_NS) then begin
                  if IfMainQuestion then begin
                    Header.ANCount := Header.ANCount + 1;
                  end else begin
                    Header.NSCount := Header.NSCount + 1;
                  end;
                end
                else if IfMainQuestion then begin
                  Header.ANCount := Header.ANCount + 1;
                end else begin
                  Header.ARCount := Header.ARCount + 1;
                end;
              end
              else if IsAdditional then begin
                Header.ARCount := Header.ARCount + 1;
              end
              else begin
                Header.ANCount := Header.ANCount + 1;
              end;

              Header.Qr := iQr_Answer;
              Header.AA := iAA_Authoritative;
              Header.RCode := iRCodeNoError;
            end;

            if RRIndex < (TargetNode.RRs.ItemNames.Count-1) then begin
              Stop := False;
              Inc(RRIndex);
            end else begin
              Stop := True;
            end;
          end else begin
            Stop := True;
          end;

          if QName = temp_QName then begin
            temp_QName := '';
          end;
        until (RRIndex = -1) or
          (not ((not TextIsSame(TargetNode.RRs.ItemNames.Strings[RRIndex], QName)) xor
            (not TextIsSame(TargetNode.RRs.ItemNames.Strings[RRIndex], Fetch(temp_QName, '.')))))
          or Stop;

        // Finish the Loop, but n record is found, we need to search if
        // there is a widechar record in its subdomain.
        // Main, Cache, Additional, Wildcard
        if Length(Answer) > 0 then begin
          InternalSearch(Header, '*.' + QName, QType, LocalAnswer, IfMAinQuestion, False, False, True, QName);
          if LocalAnswer <> nil then begin
            AppendBytes(Answer, LocalAnswer);
          end;
        end;
      end else begin // Node can't be found.
        MoreAddrSearch.Clear;
      end;

      if MoreAddrSearch.Count > 0 then begin
        for Count := 0 to MoreAddrSearch.Count -1 do begin
          Server_Index := 0;
          if Handed_DomainList.Count > 0 then begin
            repeat
              IsMyDomains := IndyPos(
                LowerCase(Handed_DomainList.Strings[Server_Index]),
                LowerCase(MoreAddrSearch.Strings[Count])) > 0;
              Inc(Server_Index);
            until IsMyDomains or (Server_Index > (Handed_DomainList.Count-1));
          end else begin
            IsMyDomains := False;
          end;

          if IsMyDomains then begin
            //ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);
            // modified by Dennies Chang in 2004/7/15.
            ifAdditional := (QType <> TypeCode_CName);

            //Search A record first.
            // Main, Cache, Additional, Wildcard
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A, LocalAnswer, True, False, ifAdditional, False);
            { modified by Dennies Chang in 2004/7/15.
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A,
            LocalAnswer, True, ifAdditional, True);
            }

            if Length(LocalAnswer) = 0 then begin
              temp := MoreAddrSearch.Strings[Count];
              Fetch(temp, '.');
              temp := '*.' + temp;
              InternalSearch(Header, temp, TypeCode_A, LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
              { marked by Dennies Chang in 2004/7/15.
              InternalSearch(Header, temp, TypeCode_A, LocalAnswer, True, ifAdditional, True, True, MoreAddrSearch.Strings[Count]);
              }
            end;

            TempAnswer := LocalAnswer;

            // Search for AAAA also.
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA, LocalAnswer, True, False, ifAdditional, True);
            { marked by Dennies Chang in 2004/7/15.
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA, LocalAnswer, True, ifAdditional, True);
            }

            if Length(LocalAnswer) = 0 then begin
              temp := MoreAddrSearch.Strings[Count];
              Fetch(temp, '.');
              temp := '*.' + temp;
              InternalSearch(Header, temp, TypeCode_AAAA, LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
              { marked by Dennies Chang in 2004/7/15.
              InternalSearch(Header, temp, TypeCode_AAAA, LocalAnswer, True, ifAdditional, True, True, MoreAddrSearch.Strings[Count]);
              }
            end;

            AppendBytes(TempAnswer, LocalAnswer);
            LocalAnswer := TempAnswer;
          end else begin
            // Need add AAAA Search in future.
            //QType := TypeCode_A;
            LDNSResolver := TIdDNSResolver.Create(Self);
            try
              Server_Index := 0;
              repeat
                LDNSResolver.Host := RootDNS_NET.Strings[Server_Index];
                LDNSResolver.QueryType := [qtA];
                LDNSResolver.Resolve(MoreAddrSearch.Strings[Count]);
                AResult := LDNSResolver.PlainTextResult;
                Header.ARCount := Header.ARCount + LDNSResolver.QueryResult.Count;
              until (Server_Index >= (RootDNS_NET.Count-1)) or (Length(AResult) > 0);

              AppendBytes(LocalAnswer, AResult, 12);
            finally
              FreeAndNil(LDNSResolver);
            end;
          end;

          if Length(LocalAnswer) > 0 then begin
            AppendBytes(Answer, LocalAnswer);
          end;
          //Answer := LocalAnswer;
        end;
      end;
    end else begin
      //Search the Cache Tree;
      { marked by Dennies Chang in 2004/7/15.
      { it's mark for querying cache only.
      { if Length(Answer) = 0 then begin }
      TargetNode := SearchTree(Cached_Tree, QName, QType);
      if TargetNode <> nil then begin
        //Assemble the Answer.
        { modified by Dennies Chang in 2004/7/15}
        if (QType in [TypeCode_A, TypeCode_PTR, TypeCode_AAAA, TypeCode_Error, TypeCode_CName]) then begin
          QName := Fetch(QName, '.');
        end;

        RRIndex := TargetNode.RRs.ItemNames.IndexOf(QName);

        repeat
          temp_QName := QName;
          SetLength(LocalAnswer, 0);

          if RRIndex <> -1 then begin
            // TimeOut, update the record.
            if CompareDate(Now, StrToDateTime(TargetNode.RRs.Items[RRIndex].TimeOut)) = 1 then begin
              SetLength(LocalAnswer, 0);
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
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_NS).NSDName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_MD:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_MF:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_CName:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_CName then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_CName).CName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_SOA:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_SOA then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).MName);
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_SOA).RName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_MB:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_MB then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MB).MADName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_MG:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_MG then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MG).MGMName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_MR:
                  begin
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_MR then begin
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MR).NewName);
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
                  end;
                TypeCode_NULL:
                  begin
                    {
                    if TargetNode.RRs.Items[RRIndex] is TIdRR_NULL then begin
                      LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                    end;
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
                      CheckMoreAddrSearch((TargetNode.RRs.Items[RRIndex] as TIdRR_MX).Exchange);
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
                  begin
                    LocalAnswer := TargetNode.RRs.Items[RRIndex].BinQueryRecord(TargetNode.FullName);
                  end;
              end;
            end;

            if BytesToString(LocalAnswer) = 'Error' then begin {do not localize}
              Stop := True;
            end else begin
              if Length(LocalAnswer) > 0 then begin
                AppendBytes(Answer, LocalAnswer);
                if TargetNode.RRs.Items[RRIndex] is TIdRR_NS then begin
                  if IfMainQuestion then begin
                    Header.ANCount := Header.ANCount + 1;
                  end else begin
                    Header.NSCount := Header.NSCount + 1;
                  end;
                end
                else if IfMainQuestion then begin
                  Header.ANCount := Header.ANCount + 1;
                end
                else begin
                  Header.ARCount := Header.ARCount + 1;
                end;

                Header.Qr := iQr_Answer;
                Header.AA := iAA_NotAuthoritative;
                Header.RCode := iRCodeNoError;
              end;

              if RRIndex < (TargetNode.RRs.ItemNames.Count-1) then begin
                Stop := False;
                Inc(RRIndex);
              end else begin
                Stop := True;
              end;
            end;
          end else begin
            Stop := True;
          end;
        until (RRIndex = -1) or
          (not ((not TextIsSame(TargetNode.RRs.ItemNames.Strings[RRIndex], QName)) xor
            (not TextIsSame(TargetNode.RRs.ItemNames.Strings[RRIndex], Fetch(temp_QName, '.')))))
          or Stop;

      end;

      // Search MoreAddrSearch it's added in 2004/7/15, but the need is
      // found in 2004 Feb.
      if MoreAddrSearch.Count > 0 then begin
        for Count := 0 to MoreAddrSearch.Count -1 do begin
          Server_Index := 0;
          if Handed_DomainList.Count > 0 then begin
            repeat
              IsMyDomains := IndyPos(
                LowerCase(Handed_DomainList.Strings[Server_Index]),
                LowerCase(MoreAddrSearch.Strings[Count])) > 0;
              Inc(Server_Index);
            until IsMyDomains or (Server_Index > (Handed_DomainList.Count-1));
          end else begin
            IsMyDomains := False;
          end;

          if IsMyDomains then begin
            ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);

            //Search A record first.
            // Main, Cache, Additional, Wildcard
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A, LocalAnswer, True, False, ifAdditional, False);

            if Length(LocalAnswer) = 0 then begin
              temp := MoreAddrSearch.Strings[Count];
              Fetch(temp, '.');
              temp := '*.' + temp;
              InternalSearch(Header, temp, TypeCode_A, LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
            end;

            TempAnswer := LocalAnswer;

            // Search for AAAA also.
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA, LocalAnswer, True, False, ifAdditional, True);

            if Length(LocalAnswer) = 0 then begin
              temp := MoreAddrSearch.Strings[Count];
              Fetch(temp, '.');
              temp := '*.' + temp;
              InternalSearch(Header, temp, TypeCode_AAAA, LocalAnswer, True, False, ifAdditional, True, MoreAddrSearch.Strings[Count]);
            end;

            AppendBytes(TempAnswer, LocalAnswer);
            LocalAnswer := TempAnswer;
          end else begin
            // 找Cache
            TempAnswer := LocalAnswer;
            ifAdditional := (QType <> TypeCode_A) or (QType <> TypeCode_AAAA);

            //Search A record first.
            // Main, Cache, Additional, Wildcard
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_A, LocalAnswer, True, True, ifAdditional, False);

            if Length(LocalAnswer) = 0 then begin
              temp := MoreAddrSearch.Strings[Count];
              Fetch(temp, '.');
              temp := '*.' + temp;
              InternalSearch(Header, temp, TypeCode_A, LocalAnswer, True, True, ifAdditional, True, MoreAddrSearch.Strings[Count]);
            end;

            AppendBytes(TempAnswer, LocalAnswer);
            LocalAnswer := TempAnswer;

            // Search for AAAA also.
            InternalSearch(Header, MoreAddrSearch.Strings[Count], TypeCode_AAAA, LocalAnswer, True, True, ifAdditional, True);

            if Length(LocalAnswer) > 0 then begin
              AppendBytes(TempAnswer, LocalAnswer);
              LocalAnswer := TempAnswer;
            end;

            Answer := LocalAnswer;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(MoreAddrSearch);
  end;
end;

{ TIdDNSServer }

procedure TIdDNSServer.CheckIfExpire(Sender: TObject);
begin
end;

procedure TIdDNSServer.InitComponent;
begin
  inherited InitComponent;
  FAccessList := TStringList.Create;
  FUDPTunnel := TIdDNS_UDPServer.Create(Self);
  FTCPTunnel := TIdDNS_TCPServer.Create(Self);

  FBindings := TIdSocketHandles.Create(Self);
  FTCPTunnel.DefaultPort := IdPORT_DOMAIN;
  FUDPTunnel.DefaultPort := IdPORT_DOMAIN;
  ServerType := stPrimary;
  BackupDNSMap := TIdDNSMap.Create(FUDPTunnel);
end;

destructor TIdDNSServer.Destroy;
begin
  FreeAndNil(FAccessList);
  FreeAndNil(FUDPTunnel);
  FreeAndNil(FTCPTunnel);
  FreeAndNil(FBindings);
  FreeAndNil(BackupDNSMap);
  inherited Destroy;
end;

procedure TIdDNSServer.SetAccessList(const Value: TStrings);
begin
  FAccessList.Assign(Value);
  FTCPTunnel.AccessList.Assign(Value);
end;

procedure TIdDNSServer.SetActive(const Value: Boolean);
var
  Count : Integer;
  DNSMap : TIdDomainNameServerMapping;
begin
  FActive := Value;
  FUDPTunnel.Active := Value;
  if ServerType = stSecondary then begin
     TCPTunnel.Active := False;
     // TODO: should this loop only be run if Value=True?
     for Count := 0 to BackupDNSMap.Count-1 do begin
         DNSMap := BackupDNSMap.Items[Count];
         DNSMap.CheckScheduler.Start;
     end;
  end else begin
    TCPTunnel.Active := Value;
  end;
end;

procedure TIdDNSServer.SetBindings(const Value: TIdSocketHandles);
begin
  FBindings.Assign(Value);
  FUDPTunnel.Bindings.Assign(Value);
  FTCPTunnel.Bindings.Assign(Value);
end;

procedure TIdDNSServer.SetTCPACLActive(const Value: Boolean);
begin
  FTCPACLActive := Value;
  TCPTunnel.AccessControl := Value;

  if Value then begin
    FTCPTunnel.FAccessList.Assign(FAccessList);
  end else begin
    FTCPTunnel.FAccessList.Clear;
  end;
end;

procedure TIdDNSServer.TimeToUpdateNodeData(Sender: TObject);
var
  Resolver : TIdDNSResolver;
  Count : Integer;
begin
  Resolver := TIdDNSResolver.Create(Self);
  try
    Resolver.Host := UDPTunnel.RootDNS_NET.Strings[0];
    Resolver.QueryType := [qtAXFR];

    Resolver.Resolve((Sender as TIdDNTreeNode).FullName);

    for Count := 0 to Resolver.QueryResult.Count-1 do begin
      UDPTunnel.UpdateTree(UDPTunnel.Handed_Tree, Resolver.QueryResult.Items[Count]);
    end;
  finally
    FreeAndNil(Resolver);
  end;
end;

{ TIdDNS_TCPServer }

procedure TIdDNS_TCPServer.InitComponent;
begin
  inherited InitComponent;
  FAccessList := TStringList.Create;
end;

destructor TIdDNS_TCPServer.Destroy;
begin
  FreeAndNil(FAccessList);
  inherited Destroy;
end;

procedure TIdDNS_TCPServer.DoConnect(AContext: TIdContext);
var
  Answer, Data, Question: TIdBytes;
  QName, QLabel, QResult, PeerIP : string;
  LData, QPos, LLength : Integer;
  TestHeader : TDNSHeader;

  procedure GenerateAXFRData;
  begin
    TestHeader := TDNSHeader.Create;
    try
      TestHeader.ParseQuery(Data);
      if TestHeader.QDCount > 0 then begin
        // parse the question.
        QPos := 13;
        QLabel := '';
        QName := '';

        repeat
          LLength := Byte(Data[QPos]);
          Inc(QPos);
          QLabel := BytesToString(Data, QPos, LLength);
          Inc(QPos, LLength);
          QName := QName + QLabel + '.';
        until (QPos >= LData) or (Data[QPos] = 0);

        Question := Copy(Data, 13, Length(Data)-12);
        QResult := TIdDNSServer(Owner).UDPTunnel.AXFR(TestHeader, QName, Answer);
      end;
    finally
      FreeAndNil(TestHeader);
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
      FreeAndNil(TestHeader);
    end;
  end;

begin
  inherited DoConnect(AContext);

  LData := AContext.Connection.IOHandler.ReadInt16;
  SetLength(Data, 0);

  // RLebeau - why not use ReadBuffer() here?
  // Dennies - Sure, in older version, my concern is for real time generate system
  //           might not generate the data with correct data size we expect.
  AContext.Connection.IOHandler.ReadBytes(Data, LData);
  {for Count := 1 to LData do begin
    AppendByte(Data, AThread.Connection.IOHandler.ReadByte);
  end;
  }

  // PeerIP is ip address.
  PeerIP := AContext.Binding.PeerIP;
  if AccessControl and (AccessList.IndexOf(PeerIP) = -1) then begin
    GenerateAXFRRefuseData;
  end else begin
    GenerateAXFRData;
  end;

  if Length(Answer) > 32767 then begin
    SetLength(Answer, 32767);
  end;

  AContext.Connection.IOHandler.Write(Int16(Length(Answer)));
  AContext.Connection.IOHandler.Write(Answer);
end;

procedure TIdDNS_TCPServer.SetAccessList(const Value: TStrings);
begin
  FAccessList.Assign(Value);
end;

{ TIdDomainExpireCheckThread }

procedure TIdDomainExpireCheckThread.Run;
var
  LInterval, LStep: Integer;
begin
  LInterval := FInterval;
  while LInterval > 0 do begin
    LStep := IndyMin(LInterval, 500);
    IndySleep(LStep);
    Dec(LInterval, LStep);
    if Terminated then begin
      Exit;
    end;
    if Assigned(FTimerEvent) then begin
      Synchronize(TimerEvent);
    end;
  end;
end;

procedure TIdDomainExpireCheckThread.TimerEvent;
begin
  if Assigned(FTimerEvent) then begin
    FTimerEvent(FSender);
  end;
end;

{ TIdDomainNameServerMapping }

constructor TIdDomainNameServerMapping.Create(AList : TIdDNSMap);
begin
  inherited Create;

  CheckScheduler := TIdDomainExpireCheckThread.Create;
  CheckScheduler.FInterval := 100000;
  CheckScheduler.FSender := Self;
  CheckScheduler.FDomain := DomainName;
  CheckScheduler.FHost := Host;
  CheckScheduler.FTimerEvent := SyncAndUpdate;

  FList := List;
  FBusy := False;
end;

destructor TIdDomainNameServerMapping.Destroy;
begin
  //Self.CheckScheduler.TerminateAndWaitFor;
  CheckScheduler.Terminate;
  FreeAndNil(CheckScheduler);
  inherited Destroy;
end;

procedure TIdDomainNameServerMapping.SetHost(const Value: string);
begin
  if (not IsValidIP(Value)) and (not IsValidIPv6(Value)) then begin
    raise EIdDNSServerSettingException.Create(RSDNSServerSettingError_MappingHostError);
  end;
  FHost := Value;
end;

procedure TIdDomainNameServerMapping.SetInterval(const Value: UInt32);
begin
  FInterval := Value;
  CheckScheduler.FInterval := Value;
end;

procedure TIdDomainNameServerMapping.SyncAndUpdate(Sender: TObject);
//Todo - Dennies Chang should append axfr and update Tree.
var
  Resolver : TIdDNSResolver;
  RR : TResultRecord;
  TNode : TIdDNTreeNode;
  Server : TIdDNS_UDPServer;
  NeedUpdated, NotThis : Boolean;
  Count, TIndex : Integer;
  RRName : string;
begin
  if FBusy then begin
    Exit;
  end;

  FBusy := True;
  try
    Resolver := TIdDNSResolver.Create(nil);
    try
      Resolver.Host := Host;
      Resolver.QueryType := [qtAXFR];

      Resolver.Resolve(DomainName);

      if Resolver.QueryResult.Count = 0 then begin
        raise EIdDNSServerSyncException.Create(RSDNSServerAXFRError_QuerySequenceError);
      end;

      RR := Resolver.QueryResult.Items[0];
      if RR.RecType <> qtSOA then begin
        raise EIdDNSServerSyncException.Create(RSDNSServerAXFRError_QuerySequenceError);
      end;

      Server := List.Server;
      Interval := TSOARecord(RR).Expire * 1000;

      {
      //Update MyDomain
      if not TextEndsWith(RR.Name, '.') then begin
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

        while (TIndex > -1) and (TIndex <= (TNode.RRs.Count-1)) and
          (TNode.RRs.Items[TIndex].RRName = RR.Name) and NotThis do
        begin
          NotThis := not (TNode.RRs.Items[TIndex] is TIdRR_SOA);
          Inc(TIndex);
        end;

        if not NotThis then begin
          Dec(TIndex);
          NeedUpdated := (TNode.RRs.Items[TIndex] as TIdRR_SOA).Serial = IntToStr(TSOARecord(RR).Serial);
        end else begin
          NeedUpdated := True;
        end;
      end;

      if NeedUpdated then begin
        if TNode <> nil then begin
          Server.Handed_Tree.RemoveChild(Server.Handed_Tree.IndexByNode(TNode));
        end;

        for Count := 0 to Resolver.QueryResult.Count-1 do begin
          RR := Resolver.QueryResult.Items[Count];
          Server.UpdateTree(Server.Handed_Tree, RR);
        end;
      end;
    finally
      FreeAndNil(Resolver);
    end;
  finally
    FBusy := False;
  end;
end;

{ TIdDNSMap }

constructor TIdDNSMap.Create(Server: TIdDNS_UDPServer);
begin
  inherited Create;
  FServer := Server;
end;

{$IFNDEF USE_OBJECT_ARC}
destructor TIdDNSMap.Destroy;
var
  I : Integer;
  DNSMP : TIdDomainNameServerMapping;
begin
  if Count > 0 then begin
    for I := Count-1 downto 0 do begin
      DNSMP := Items[I];
      FreeAndNil(DNSMP);
      Delete(I);
    end;
  end;
  inherited Destroy;
end;
{$ENDIF}

{$IFNDEF HAS_GENERICS_TObjectList}
function TIdDNSMap.GetItem(Index: Integer): TIdDomainNameServerMapping;
begin
   Result := TIdDomainNameServerMapping(inherited GetItem(Index));
end;

procedure TIdDNSMap.SetItem(Index: Integer; const Value: TIdDomainNameServerMapping);
begin
  inherited SetItem(Index, Value);
end;
{$ENDIF}

procedure TIdDNSMap.SetServer(const Value: TIdDNS_UDPServer);
begin
  FServer := Value;
end;

{ TIdDNS_ProcessThread }

constructor TIdDNS_ProcessThread.Create(ACreateSuspended: Boolean;
  Data: TIdBytes; MainBinding, Binding: TIdSocketHandle;
  Server: TIdDNS_UDPServer);
begin
  inherited Create(ACreateSuspended);

  FMyData := nil;
  FData := Data;

  FMyBinding := Binding;
  FMainBinding := MainBinding;

  FServer := Server;
  FreeOnTerminate := True;
end;

procedure TIdDNS_ProcessThread.ComposeErrorResult(var VFinal: TIdBytes;
  OriginalHeader: TDNSHeader; OriginalQuestion : TIdBytes;
  ErrorStatus: Integer);
begin
  case ErrorStatus of
    iRCodeQueryNotImplement :
      begin
        OriginalHeader.Qr := iQr_Answer;
        OriginalHeader.RCode := iRCodeNotImplemented;

        VFinal := OriginalHeader.GenerateBinaryHeader;
        AppendBytes(VFinal, OriginalQuestion, 12);
      end;
    iRCodeQueryNotFound :
      begin
        OriginalHeader.Qr := iQr_Answer;
        OriginalHeader.RCode := iRCodeNameError;
        OriginalHeader.ANCount := 0;

        VFinal := OriginalHeader.GenerateBinaryHeader;
        //VFinal := VFinal;
      end;
  end;
end;

destructor TIdDNS_ProcessThread.Destroy;
begin
  FServer := nil;
  FMainBinding := nil;
  FMyBinding.CloseSocket;
  FreeAndNil(FMyBinding);
  FreeAndNil(FMyData);
  inherited Destroy;
end;

procedure TIdDNS_ProcessThread.QueryDomain;
var
  QName, QLabel, RString : string;
  Temp, ExternalQuery, Answer, FinalResult : TIdBytes;
  DNSHeader_Processing : TDNSHeader;
  QType, QClass : UInt16;
  QPos, QLength, LLength : Integer;
  ABinding: TIdSocketHandle;
begin
  ExternalQuery := FData;
  ABinding := MyBinding;
  Temp := Copy(FData, 0, Length(FData));
  SetLength(FinalResult, 0);
  QType := TypeCode_A;

  if Length(FData) >= 12 then begin
    DNSHeader_Processing := TDNSHeader.Create;
    try
      // RLebeau: this does not make sense to me. ParseQuery() always returns
      // 0 when the data length is >= 12 unless an exception is raised, which
      // should only happen if the GStack object is invalid...
      //
      if DNSHeader_Processing.ParseQuery(ExternalQuery) <> 0 then begin
        FServer.DoAfterQuery(ABinding, DNSHeader_Processing, Temp, RString, ExternalQuery);
        AppendBytes(FinalResult, Temp);
      end else begin
        if DNSHeader_Processing.QDCount > 0 then begin

          QPos := 12; //13; Modified in Dec. 13, 2004 by Dennies
          QLength := Length(ExternalQuery);
          if QLength > 12 then begin
            QName := '';
            repeat
              SetLength(Answer, 0);
              LLength := ExternalQuery[QPos];
              Inc(QPos);
              QLabel := BytesToString(ExternalQuery, QPos, LLength);
              Inc(QPos, LLength);
              QName := QName + QLabel + '.';
            until (QPos >= QLength) or (ExternalQuery[QPos] = 0);
            Inc(QPos);

            QType := GStack.NetworkToHost(TwoByteToUInt16(ExternalQuery[QPos], ExternalQuery[QPos + 1]));
            Inc(QPos, 2);
            QClass := GStack.NetworkToHost(TwoByteToUInt16(ExternalQuery[QPos], ExternalQuery[QPos + 1]));
            FServer.DoBeforeQuery(ABinding, DNSHeader_Processing, Temp);

            RString := CompleteQuery(DNSHeader_Processing, QName, ExternalQuery, Answer, QType, QClass, nil);

            if RString = cRCodeQueryNotImplement then begin
              ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotImplement);
            end
            else if (RString = cRCodeQueryReturned) then begin
              FinalResult := Answer;
            end
            else if (RString = cRCodeQueryNotFound) or (RString = cRCodeQueryCacheFindError) then begin
              ComposeErrorResult(FinalResult, DNSHeader_Processing, ExternalQuery, iRCodeQueryNotFound);
            end
            else begin
              FinalResult := CombineAnswer(DNSHeader_Processing, ExternalQuery, Answer);
            end;

            FServer.DoAfterQuery(ABinding, DNSHeader_Processing, FinalResult, RString, Temp);
            //AppendString(FinalResult, Temp);
          end;
        end;
      end;
    finally
      try
        FData := FinalResult;

        FServer.DoAfterSendBack(ABinding, DNSHeader_Processing, FinalResult, RString, ExternalQuery);

        if (FServer.CacheUnknowZone) and
          (RString <> cRCodeQueryCacheFindError) and
          (RString <> cRCodeQueryCacheOK) and
          (RString <> cRCodeQueryOK) and
          (RString <> cRCodeQueryNotImplement) then
        begin
          FServer.SaveToCache(FinalResult, QName, QType);
          FServer.DoAfterCacheSaved(Self.FServer.FCached_Tree);
        end;
      finally
        FreeAndNil(DNSHeader_Processing);
      end;
    end;
  end;
end;

procedure TIdDNS_ProcessThread.Run;
begin
  try
    QueryDomain;
    SendData;
  finally
    Stop;
    Terminate;
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

function TIdDNS_ProcessThread.CombineAnswer(Header: TDNSHeader; const EQuery, Answer: TIdBytes): TIdBytes;
begin
  Result := Header.GenerateBinaryHeader;
  AppendBytes(Result, EQuery, 12);
  AppendBytes(Result, Answer);
end;

procedure TIdDNS_ProcessThread.ExternalSearch(ADNSResolver: TIdDNSResolver; Header: TDNSHeader;
  Question: TIdBytes; var Answer: TIdBytes);
var
  Server_Index : Integer;
  MyDNSResolver : TIdDNSResolver;
begin
  Server_Index := 0;
  if ADNSResolver = nil then begin
     MyDNSResolver := TIdDNSResolver.Create;
     MyDNSResolver.WaitingTime := 2000;
  end else
  begin
    MyDNSResolver := ADNSResolver;
  end;

  try
    repeat
      MyDNSResolver.Host := FServer.RootDNS_NET.Strings[Server_Index];
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
    until (Server_Index >= FServer.RootDNS_NET.Count) or (Length(Answer) > 0);
  finally
    if ADNSResolver = nil then begin
      FreeAndNil(MyDNSResolver);
    end;
  end;
end;

procedure TIdDNS_ProcessThread.InternalSearch(Header: TDNSHeader; QName: string; QType: UInt16;
  var Answer: TIdBytes; IfMainQuestion: boolean; IsSearchCache: Boolean = False;
  IsAdditional: boolean = false; IsWildCard : boolean = false;
  WildCardOrgName: string = '');
begin
end;

procedure TIdDNS_ProcessThread.SaveToCache(ResourceRecord: TIdBytes; QueryName: string; OriginalQType: UInt16);
var
  TempResolver : TIdDNSResolver;
  Count : Integer;
  TNode : TIdDNTreeNode;
  RR_Err : TIdRR_Error;
begin
  TempResolver := TIdDNSResolver.Create(nil);
  try
    // RLebeau: FillResultWithOutCheckId() is deprecated, but not using FillResult()
    // here yet because it validates the DNSHeader.RCode, and I do not know if that
    // is needed here. I don't want to break this logic...
    TempResolver.FillResultWithOutCheckId(ResourceRecord);

    if TempResolver.DNSHeader.ANCount > 0 then begin
      for Count := 0 to TempResolver.QueryResult.Count-1 do begin
        FServer.UpdateTree(FServer.Cached_Tree, TempResolver.QueryResult.Items[Count]);
      end; // for loop
    end else begin
      TNode := Self.SearchTree(FServer.Cached_Tree, QueryName, TypeCode_Error);
      if TNode = nil then begin
        RR_Err := TIdRR_Error.Create;
        RR_Err.RRName := QueryName;
        RR_Err.TTL := 600;
        FServer.UpdateTree(FServer.Cached_Tree, RR_Err);
      end;
    end;
  finally
    FreeAndNil(TempResolver);
  end;
end;

function TIdDNS_ProcessThread.SearchTree(Root: TIdDNTreeNode; QName: String; QType: UInt16): TIdDNTreeNode;
var
  RRIndex : integer;
  NodeCursor : TIdDNTreeNode;
  NameLabels : TStrings;
  OneNode, FullName : string;
  Found : Boolean;
begin
  Result := nil;
  NameLabels := TStringList.Create;
  try
    FullName := QName;
    NodeCursor := Root;
    Found := False;

    repeat
      OneNode := Fetch(FullName, '.');
      if OneNode <> '' then begin
        NameLabels.Add(OneNode);
      end;
    until FullName = '';

    repeat
      IndySleep(0);
      if QType <> TypeCode_SOA then begin
        RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
        if RRIndex <> -1 then begin
          NameLabels.Delete(NameLabels.Count - 1);
          NodeCursor := NodeCursor.Children[RRIndex];

          if NameLabels.Count = 1 then begin
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
          end else begin
            Found := NameLabels.Count = 0;
          end;
        end
        else if NameLabels.Count = 1 then begin
          Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
          if not Found then begin
            NameLabels.Clear;
          end;
        end
        else begin
          NameLabels.Clear;
        end;
      end else begin
        RRIndex := NodeCursor.ChildIndex.IndexOf(NameLabels.Strings[NameLabels.Count - 1]);
        if RRIndex <> -1 then begin
          NameLabels.Delete(NameLabels.Count - 1);
          NodeCursor := NodeCursor.Children[RRIndex];

          if NameLabels.Count = 1 then begin
            Found := NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1;
          end else begin
            Found := NameLabels.Count = 0;
          end;
        end
        else if NameLabels.Count = 1 then begin
          Found := (NodeCursor.RRs.ItemNames.IndexOf(NameLabels.Strings[0]) <> -1);
          if not Found then begin
            NameLabels.Clear;
          end;
        end
        else begin
          NameLabels.Clear;
        end;
      end;
    until (NameLabels.Count = 0) or Found;

    if Found then begin
      Result := NodeCursor;
    end;
  finally
    FreeAndNil(NameLabels);
  end;
end;

function TIdDNS_ProcessThread.CompleteQuery(DNSHeader: TDNSHeader;
  Question: string; OriginalQuestion: TIdBytes; var Answer : TIdBytes;
  QType, QClass : UInt16; DNSResolver : TIdDNSResolver) : string;
var
  IsMyDomains : boolean;
  LAnswer, TempAnswer, RRData: TIdBytes;
  WildQuestion, TempDomain : string;
  LIdx: Integer;
begin
  // QClass = 1  => IN, we support only "IN" class now.
  // QClass = 2  => CS,
  // QClass = 3  => CH, we suppor "CHAOS" class now, but only "version.bind." info.
  //                    from 2004/6/28
  // QClass = 4  => HS.
  RRData     := nil;
  TempAnswer := nil;
  TempDomain := LowerCase(Question);

  case QClass of
    Class_IN :
      begin
        IsMyDomains := FServer.Handed_DomainList.IndexOf(TempDomain) > -1;
        if not IsMyDomains then begin
          Fetch(TempDomain, '.');
          IsMyDomains := FServer.Handed_DomainList.IndexOf(TempDomain) > -1;
        end;

        if IsMyDomains then begin
          FServer.InternalSearch(DNSHeader, Question, QType, LAnswer, True, False, False);
          Answer := LAnswer;

          if (QType in [TypeCode_A, TypeCode_AAAA]) and (Length(Answer) = 0) then begin
            FServer.InternalSearch(DNSHeader, Question, TypeCode_CNAME, LAnswer, True, False, True);
            if Length(LAnswer) > 0 then begin
              AppendBytes(Answer, LAnswer);
            end;
          end;

          WildQuestion := Question;
          Fetch(WildQuestion, '.');
          WildQuestion := '*.' + WildQuestion;
          FServer.InternalSearch(DNSHeader, WildQuestion, QType, LAnswer, True, False, False, True, Question);
          {
          FServer.InternalSearch(DNSHeader, Question, QType, LAnswer, True, True, False);
          }
          if Length(LAnswer) > 0 then begin
            AppendBytes(Answer, LAnswer);
          end;

          if Length(Answer) > 0 then begin
            Result := cRCodeQueryOK;
          end else begin
            Result := cRCodeQueryNotFound;
          end;
        end else begin
          FServer.InternalSearch(DNSHeader, Question, QType, Answer, True, True, False);

          if (QType in [TypeCode_A, TypeCode_AAAA]) and (Length(Answer) = 0) then begin
            FServer.InternalSearch(DNSHeader, Question, TypeCode_CNAME, LAnswer, True, True, False);
            if Length(LAnswer) > 0 then begin
              AppendBytes(Answer, LAnswer);
            end;
          end;

          if Length(Answer) > 0 then begin
            Result := cRCodeQueryCacheOK;
          end else begin
            //QType := TypeCode_Error;

            FServer.InternalSearch(DNSHeader, Question, QType, Answer, True, True, False);
            if BytesToString(Answer) = 'Error' then begin {do not localize}
              Result := cRCodeQueryCacheFindError;
            end else begin
              FServer.ExternalSearch(DNSResolver, DNSHeader, OriginalQuestion, Answer);

              if Length(Answer) > 0 then begin
                Result := cRCodeQueryReturned;
              end else begin
                Result := cRCodeQueryNotImplement;
              end;
            end;
          end;
        end;
      end;

    Class_CHAOS :
      begin
        if TempDomain = 'version.bind.' then begin {do not localize}
          if FServer.offerDNSVersion then begin
            TempAnswer := DomainNameToDNSStr('version.bind.'); {do not localize}
            RRData := NormalStrToDNSStr(FServer.DNSVersion);

            SetLength(LAnswer, Length(TempAnswer) + (SizeOf(UInt16)*3) + SizeOf(UInt32) + Length(RRData));
            CopyTIdBytes(TempAnswer, 0, LAnswer, 0, Length(TempAnswer));
            LIdx := Length(TempAnswer);
            CopyTIdUInt16(GStack.HostToNetwork(UInt16(TypeCode_TXT)), LAnswer, LIdx);
            Inc(LIdx, SizeOf(UInt16));
            CopyTIdUInt16(GStack.HostToNetwork(UInt16(Class_CHAOS)), LAnswer, LIdx);
            Inc(LIdx, SizeOf(UInt16));
            CopyTIdUInt32(GStack.HostToNetwork(UInt32(86400)), LAnswer, LIdx); {do not localize}
            Inc(LIdx, SizeOf(UInt32));
            CopyTIdUInt16(GStack.HostToNetwork(UInt16(Length(RRData))), LAnswer, LIdx);
            Inc(LIdx, SizeOf(UInt16));
            CopyTIdBytes(RRData, 0, LAnswer, LIdx, Length(RRData));

            Answer := LAnswer;
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

    else
      begin
        Result := cRCodeQueryNotImplement;
      end;
  end;
end;

procedure TIdDNS_ProcessThread.SendData;
begin
  FServer.GlobalCS.Enter;
  try
    FMainBinding.SendTo(FMyBinding.PeerIP, FMyBinding.PeerPort, FData, FMyBinding.IPVersion);
  finally
    FServer.GlobalCS.Leave;
  end;
end;

procedure TIdDNS_UDPServer.DoAfterCacheSaved(CacheRoot: TIdDNTreeNode);
begin
  if Assigned(FOnAfterCacheSaved) then begin
    FOnAfterCacheSaved(CacheRoot);
  end;
end;

procedure TIdDNS_UDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  PThread : TIdDNS_ProcessThread;
  BBinding : TIdSocketHandle;
  Binded : Boolean;
begin
  inherited DoUDPRead(AThread, AData, ABinding);

  Binded := False;

  BBinding := TIdSocketHandle.Create(nil);
  try
    BBinding.SetPeer(ABinding.PeerIP, ABinding.PeerPort, ABinding.IPVersion);
    BBinding.IP := ABinding.IP;

    repeat
      try
        BBinding.Port := 53;
        BBinding.AllocateSocket(Id_SOCK_DGRAM);
        Binded := True;
      except
      end;
    until Binded;

    PThread := TIdDNS_ProcessThread.Create(True, AData, ABinding, BBinding, Self);
  except
    FreeAndNil(BBinding);
    raise;
  end;

  PThread.Start;
end;

end.
