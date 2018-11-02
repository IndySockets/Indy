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
  Rev 1.42    3/14/05 11:45:50 AM  RLebeau
  Buf fix for DoExecute() not not filling in the TIdHTTPRequestInfo.FormParams
  correctly.

  Removed LImplicitPostStream variable from DoExecute(), no longer used.
  TIdHTTPRequestInfo takes ownership of the PostStream anyway, so no need to
  free it early.  This also allows the PostStream to always be available in the
  OnCommand... event handlers.

  Rev 1.41    2/9/05 2:11:02 AM  RLebeau
  Removed compiler hint

  Rev 1.40    2/9/05 1:19:26 AM  RLebeau
  Fixes for Compiler errors

  Rev 1.39    2/8/05 6:47:46 PM  RLebeau
  updated OnCommandOther to have ARequestInfo and AResponseInfo parameters

  Rev 1.38    12/16/04 2:15:20 AM  RLebeau
  Another DoExecute() update

  Rev 1.37    12/15/04 9:03:50 PM  RLebeau
  Renamed TIdHTTPRequestInfo.DecodeCommand() to DecodeHTTPCommand() and made it
  into a standalone function.

  Rev 1.36    12/15/04 4:17:42 PM  RLebeau
  Updated DoExecute() to call LRequestInfo.DecodeCommand()

  Rev 1.35    12/2/2004 4:23:48 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.34    10/26/2004 8:59:32 PM  JPMugaas
  Updated with new TStrings references for more portability.

  Rev 1.33    2004.05.20 11:37:12 AM  czhower
  IdStreamVCL

  Rev 1.32    5/6/04 3:19:00 PM  RLebeau
  Added extra comments

  Rev 1.31    2004.04.18 12:52:06 AM  czhower
  Big bug fix with server disconnect and several other bug fixed that I found
  along the way.

  Rev 1.30    2004.04.08 1:46:32 AM  czhower
  Small Optimizations

  Rev 1.29    7/4/2004 4:10:44 PM  SGrobety
  Small fix to keep it synched with the IOHandler properties

  Rev 1.28    6/4/2004 5:15:02 PM  SGrobety
  Implemented MaximumHeaderLineCount property (default to 1024)

  Rev 1.27    2004.02.03 5:45:02 PM  czhower
  Name changes

  Rev 1.26    1/27/2004 3:58:52 PM  SPerry
  StringStream ->IdStringStream

  Rev 1.25    2004.01.22 5:58:58 PM  czhower
  IdCriticalSection

  Rev 1.24    1/22/2004 8:26:28 AM  JPMugaas
  Ansi* calls changed.

  Rev 1.23    1/21/2004 1:57:30 PM  JPMugaas
  InitComponent

  Rev 1.22    21.1.2004 ã. 13:22:18  DBondzhev
  Fix for Dccil bug

  Rev 1.21    10/25/2003 06:51:44 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.20    2003.10.24 10:43:02 AM  czhower
  TIdSTream to dos

    Rev 1.19    10/19/2003 11:49:40 AM  DSiders
  Added localization comments.

    Rev 1.18    10/17/2003 12:05:40 AM  DSiders
  Corrected spelling error in resource string.

  Rev 1.17    10/15/2003 11:10:16 PM  GGrieve
  DotNet changes

  Rev 1.16    2003.10.12 3:37:58 PM  czhower
  Now compiles again.

    Rev 1.15    6/24/2003 11:38:50 AM  BGooijen
  Fixed ssl support

    Rev 1.14    6/18/2003 11:44:04 PM  BGooijen
  Moved ServeFile and SmartServeFile to TIdHTTPResponseInfo.
  Added TIdHTTPResponseInfo.HTTPServer field

  Rev 1.13    05.6.2003 ã. 11:11:12  DBondzhev
  Socket exceptions should  not be stopped after DoCommandGet.

    Rev 1.12    4/9/2003 9:38:40 PM  BGooijen
  fixed av on FSessionList.PurgeStaleSessions(Terminated);

  Rev 1.11    20/3/2003 19:49:24  GGrieve
  Define SmartServeFile

    Rev 1.10    3/13/2003 10:21:14 AM  BGooijen
  Changed result of function .execute

    Rev 1.9    2/25/2003 10:43:36 AM  BGooijen
  removed unneeded assignment

    Rev 1.8    2/25/2003 10:38:46 AM  BGooijen
  The Serversoftware wasn't send to the client, because of duplicate properties
  (.Server and .ServerSoftware).

  Rev 1.7    2/24/2003 08:20:50 PM  JPMugaas
  Now should compile with new code.

  Rev 1.6    11.2.2003 13:36:14  TPrami
  - Fixed URL get paremeter handling (SeeRFC 1866 section 8.2.1.)

  Rev 1.5    1/17/2003 05:35:20 PM  JPMugaas
  Now compiles with new design.

  Rev 1.4    1-1-2003 20:12:44  BGooijen
  Changed to support the new TIdContext class

  Rev 1.3    12-15-2002 13:08:38  BGooijen
  simplified TimeStampInterval

  Rev 1.2    6/12/2002 10:59:34 AM  SGrobety    Version: 1.1
  Made to work with Indy 10

  Rev 1.0    21/11/2002 12:41:04 PM  SGrobety    Version: Indy 10

  Rev 1.0    11/14/2002 02:16:32 PM  JPMugaas
}

unit IdCustomHTTPServer;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdAssignedNumbers,
  IdContext, IdException,
  IdGlobal, IdStack,
  IdExceptionCore, IdGlobalProtocols, IdHeaderList, IdCustomTCPServer,
  IdTCPConnection, IdThread, IdCookie, IdHTTPHeaderInfo, IdStackConsts,
  IdBaseComponent, IdThreadSafe,
  SysUtils;

type
  // Enums
  THTTPCommandType = (hcUnknown, hcHEAD, hcGET, hcPOST, hcDELETE, hcPUT, hcTRACE, hcOPTION);

const
  Id_TId_HTTPServer_KeepAlive = false;
  Id_TId_HTTPServer_ParseParams = True;
  Id_TId_HTTPServer_SessionState = False;
  Id_TId_HTTPSessionTimeOut = 0;
  Id_TId_HTTPAutoStartSession = False;

  Id_TId_HTTPMaximumHeaderLineCount = 1024;

  GResponseNo = 200;
  GFContentLength = -1;
  GServerSoftware = gsIdProductName + '/' + gsIdVersion;    {Do not Localize}
  GContentType = 'text/html';    {Do not Localize}
  GSessionIDCookie = 'IDHTTPSESSIONID';    {Do not Localize}
  HTTPRequestStrings: array[0..Ord(High(THTTPCommandType))] of string = ('UNKNOWN', 'HEAD','GET','POST','DELETE','PUT','TRACE', 'OPTIONS'); {do not localize}

type
  // Forwards
  TIdHTTPSession = class;
  TIdHTTPCustomSessionList = class;
  TIdHTTPRequestInfo = class;
  TIdHTTPResponseInfo = class;
  TIdCustomHTTPServer = class;

  //events
  TIdHTTPSessionEndEvent = procedure(Sender: TIdHTTPSession) of object;
  TIdHTTPSessionStartEvent = procedure(Sender: TIdHTTPSession) of object;
  TIdHTTPCreateSession = procedure(ASender:TIdContext;
    var VHTTPSession: TIdHTTPSession) of object;
  TIdHTTPCreatePostStream = procedure(AContext: TIdContext; AHeaders: TIdHeaderList; var VPostStream: TStream) of object;
  TIdHTTPDoneWithPostStream = procedure(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; var VCanFree: Boolean) of object;
  TIdHTTPParseAuthenticationEvent = procedure(AContext: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String; var VHandled: Boolean) of object;
  TIdHTTPCommandEvent = procedure(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo) of object;
  TIdHTTPCommandError = procedure(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
    AException: Exception) of object;
  TIdHTTPInvalidSessionEvent = procedure(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
    var VContinueProcessing: Boolean; const AInvalidSessionID: String) of object;
  TIdHTTPHeadersAvailableEvent = procedure(AContext: TIdContext; const AUri: string; AHeaders: TIdHeaderList; var VContinueProcessing: Boolean) of object;
  TIdHTTPHeadersBlockedEvent = procedure(AContext: TIdContext; AHeaders: TIdHeaderList; var VResponseNo: Integer; var VResponseText, VContentText: String) of object;
  TIdHTTPHeaderExpectationsEvent = procedure(AContext: TIdContext; const AExpectations: String; var VContinueProcessing: Boolean) of object;
  TIdHTTPQuerySSLPortEvent = procedure(APort: TIdPort; var VUseSSL: Boolean) of object;

  //objects
  EIdHTTPServerError = class(EIdException);
  EIdHTTPHeaderAlreadyWritten = class(EIdHTTPServerError);
  EIdHTTPErrorParsingCommand = class(EIdHTTPServerError);
  EIdHTTPUnsupportedAuthorisationScheme = class(EIdHTTPServerError);
  EIdHTTPCannotSwitchSessionStateWhenActive = class(EIdHTTPServerError);
  EIdHTTPCannotSwitchSessionIDCookieNameWhenActive = class(EIdHTTPServerError);

  TIdHTTPRequestInfo = class(TIdRequestHeaderInfo)
  protected
    FAuthExists: Boolean;
    FCookies: TIdCookies;
    FParams: TStrings;
    FPostStream: TStream;
    FRawHTTPCommand: string;
    FRemoteIP: string;
    FSession: TIdHTTPSession;
    FDocument: string;
    FURI: string;
    FCommand: string;
    FVersion: string;
    FVersionMajor: Integer;
    FVersionMinor: Integer;
    FAuthUsername: string;
    FAuthPassword: string;
    FUnparsedParams: string;
    FQueryParams: string;
    FFormParams: string;
    FCommandType: THTTPCommandType;
    //
    procedure DecodeAndSetParams(const AValue: String); virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    //
    function IsVersionAtLeast(const AMajor, AMinor: Integer): Boolean;
    property Session: TIdHTTPSession read FSession;
    //
    property AuthExists: Boolean read FAuthExists;
    property AuthPassword: string read FAuthPassword;
    property AuthUsername: string read FAuthUsername;
    property Command: string read FCommand;
    property CommandType: THTTPCommandType read FCommandType;
    property Cookies: TIdCookies read FCookies;
    property Document: string read FDocument write FDocument; // writable for isapi compatibility. Use with care
    property URI: string read FURI;
    property Params: TStrings read FParams;
    property PostStream: TStream read FPostStream write FPostStream;
    property RawHTTPCommand: string read FRawHTTPCommand;
    property RemoteIP: String read FRemoteIP;
    property UnparsedParams: string read FUnparsedParams write FUnparsedParams; // writable for isapi compatibility. Use with care
    property FormParams: string read FFormParams write FFormParams; // writable for isapi compatibility. Use with care
    property QueryParams: string read FQueryParams write FQueryParams; // writable for isapi compatibility. Use with care
    property Version: string read FVersion;
    property VersionMajor: Integer read FVersionMajor;
    property VersionMinor: Integer read FVersionMinor;
  end;

  TIdHTTPResponseInfo = class(TIdResponseHeaderInfo)
  protected
    FAuthRealm: string;
    FConnection: TIdTCPConnection;
    FResponseNo: Integer;
    FCookies: TIdCookies;
    FContentStream: TStream;
    FContentText: string;
    FCloseConnection: Boolean;
    FFreeContentStream: Boolean;
    FHeaderHasBeenWritten: Boolean;
    FResponseText: string;
    FHTTPServer: TIdCustomHTTPServer;
    FSession: TIdHTTPSession;
    FRequestInfo: TIdHTTPRequestInfo;
    //
    procedure ReleaseContentStream;
    procedure SetCookies(const AValue: TIdCookies);
    procedure SetHeaders; override;
    procedure SetResponseNo(const AValue: Integer);
    procedure SetCloseConnection(const Value: Boolean);
  public
    function GetServer: string;
    procedure SetServer(const Value: string);
  public
    procedure CloseSession;
    constructor Create(AServer: TIdCustomHTTPServer; ARequestInfo: TIdHTTPRequestInfo; AConnection: TIdTCPConnection); reintroduce;
    destructor Destroy; override;
    procedure Redirect(const AURL: string);
    procedure WriteHeader;
    procedure WriteContent;
    //
    function ServeFile(AContext: TIdContext; const AFile: String): Int64; virtual;
    function SmartServeFile(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; const AFile: String): Int64;
    //
    property AuthRealm: string read FAuthRealm write FAuthRealm;
    property CloseConnection: Boolean read FCloseConnection write SetCloseConnection;
    property ContentStream: TStream read FContentStream write FContentStream;
    property ContentText: string read FContentText write FContentText;
    property Cookies: TIdCookies read FCookies write SetCookies;
    property FreeContentStream: Boolean read FFreeContentStream write FFreeContentStream;
    // writable for isapi compatibility. Use with care
    property HeaderHasBeenWritten: Boolean read FHeaderHasBeenWritten write FHeaderHasBeenWritten;
    property ResponseNo: Integer read FResponseNo write SetResponseNo;
    property ResponseText: String read FResponseText write FResponseText;
    property HTTPServer: TIdCustomHTTPServer read FHTTPServer;
    property ServerSoftware: string read GetServer write SetServer;
    property Session: TIdHTTPSession read FSession;
  end;

  TIdHTTPSession = Class(TObject)
  protected
    FContent: TStrings;
    FLastTimeStamp: TDateTime;
    FLock: TIdCriticalSection;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FOwner: TIdHTTPCustomSessionList;
    FSessionID: string;
    FRemoteHost: string;
    //
    procedure SetContent(const Value: TStrings);
    function IsSessionStale: boolean; virtual;
    procedure DoSessionEnd; virtual;
  public
    constructor Create(AOwner: TIdHTTPCustomSessionList); virtual;
    constructor CreateInitialized(AOwner: TIdHTTPCustomSessionList; const SessionID,
                                  RemoteIP: string); virtual;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    //
    property Content: TStrings read FContent write SetContent;
    property LastTimeStamp: TDateTime read FLastTimeStamp;
    property RemoteHost: string read FRemoteHost;
    property SessionID: String read FSessionID;
  end;

  {$IFDEF HAS_GENERICS_TThreadList}
  TIdHTTPSessionThreadList = TThreadList<TIdHTTPSession>;
  TIdHTTPSessionList = TList<TIdHTTPSession>;
  {$ELSE}
  // TODO: flesh out to match TThreadList<TIdHTTPSession> and TList<TIdHTTPSession> for non-Generics compilers
  TIdHTTPSessionThreadList = TThreadList;
  TIdHTTPSessionList = TList;
  {$ENDIF}

  TIdHTTPCustomSessionList = class(TIdBaseComponent)
  private
    FSessionTimeout: Integer;
    FOnSessionEnd: TIdHTTPSessionEndEvent;
    FOnSessionStart: TIdHTTPSessionStartEvent;
  protected
    // remove a session from the session list. Called by the session on "Free"
    procedure RemoveSession(Session: TIdHTTPSession); virtual; abstract;
  public
    procedure Clear; virtual; abstract;
    procedure PurgeStaleSessions(PurgeAll: Boolean = false); virtual; abstract;
    function CreateUniqueSession(const RemoteIP: String): TIdHTTPSession; virtual; abstract;
    function CreateSession(const RemoteIP, SessionID: String): TIdHTTPSession; virtual; abstract;
    function GetSession(const SessionID, RemoteIP: string): TIdHTTPSession; virtual; abstract;
    procedure Add(ASession: TIdHTTPSession); virtual; Abstract;
  published
    property SessionTimeout: Integer read FSessionTimeout write FSessionTimeout;
    property OnSessionEnd: TIdHTTPSessionEndEvent read FOnSessionEnd write FOnSessionEnd;
    property OnSessionStart: TIdHTTPSessionStartEvent read FOnSessionStart write FOnSessionStart;
  end;

  TIdThreadSafeMimeTable = class(TIdThreadSafe)
  protected
    FTable: TIdMimeTable;
    function GetLoadTypesFromOS: Boolean;
    procedure SetLoadTypesFromOS(AValue: Boolean);
    function GetOnBuildCache: TNotifyEvent;
    procedure SetOnBuildCache(AValue: TNotifyEvent);
  public
    constructor Create(const AutoFill: Boolean = True); reintroduce;
    destructor Destroy; override;
    procedure BuildCache;
    procedure AddMimeType(const Ext, MIMEType: string; const ARaiseOnError: Boolean = True);
    function GetFileMIMEType(const AFileName: string): string;
    function GetDefaultFileExt(const MIMEType: string): string;
    procedure LoadFromStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    procedure SaveToStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    function Lock: TIdMimeTable; reintroduce;
    procedure Unlock; reintroduce;
    //
    property LoadTypesFromOS: Boolean read GetLoadTypesFromOS write SetLoadTypesFromOS;
    property OnBuildCache: TNotifyEvent read GetOnBuildCache write SetOnBuildCache;
  end;

  TIdCustomHTTPServer = class(TIdCustomTCPServer)
  protected
    FAutoStartSession: Boolean;
    FKeepAlive: Boolean;
    FParseParams: Boolean;
    FServerSoftware: string;
    FMIMETable: TIdThreadSafeMimeTable;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FSessionList: TIdHTTPCustomSessionList;
    FImplicitSessionList: Boolean;
    FSessionState: Boolean;
    FSessionTimeOut: Integer;
    //
    FOnCreatePostStream: TIdHTTPCreatePostStream;
    FOnDoneWithPostStream: TIdHTTPDoneWithPostStream;
    FOnCreateSession: TIdHTTPCreateSession;
    FOnInvalidSession: TIdHTTPInvalidSessionEvent;
    FOnParseAuthentication: TIdHTTPParseAuthenticationEvent;
    FOnSessionEnd: TIdHTTPSessionEndEvent;
    FOnSessionStart: TIdHTTPSessionStartEvent;
    FOnCommandGet: TIdHTTPCommandEvent;
    FOnCommandOther: TIdHTTPCommandEvent;
    FOnCommandError: TIdHTTPCommandError;
    FOnHeadersAvailable: TIdHTTPHeadersAvailableEvent;
    FOnHeadersBlocked: TIdHTTPHeadersBlockedEvent;
    FOnHeaderExpectations: TIdHTTPHeaderExpectationsEvent;
    FOnQuerySSLPort: TIdHTTPQuerySSLPortEvent;
    //
    FSessionCleanupThread: TIdThread;
    FMaximumHeaderLineCount: Integer;
    FSessionIDCookieName: string;
    //
    procedure CreatePostStream(ASender: TIdContext; AHeaders: TIdHeaderList; var VPostStream: TStream); virtual;
    procedure DoneWithPostStream(ASender: TIdContext; ARequestInfo: TIdHTTPRequestInfo); virtual;
    procedure DoOnCreateSession(AContext: TIdContext; var VNewSession: TIdHTTPSession); virtual;
    procedure DoInvalidSession(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
      var VContinueProcessing: Boolean; const AInvalidSessionID: String); virtual;
    procedure DoCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo); virtual;
    procedure DoCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo); virtual;
    procedure DoCommandError(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; AException: Exception); virtual;
    procedure DoConnect(AContext: TIdContext); override;
    function DoHeadersAvailable(ASender: TIdContext; const AUri: String; AHeaders: TIdHeaderList): Boolean; virtual;
    procedure DoHeadersBlocked(ASender: TIdContext; AHeaders: TIdHeaderList; var VResponseNo: Integer; var VResponseText, VContentText: String); virtual;
    function DoHeaderExpectations(ASender: TIdContext; const AExpectations: String): Boolean; virtual;
    function DoParseAuthentication(ASender: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String): Boolean;
    function DoQuerySSLPort(APort: TIdPort): Boolean; virtual;
    procedure DoSessionEnd(Sender: TIdHTTPSession); virtual;
    procedure DoSessionStart(Sender: TIdHTTPSession); virtual;
    //
    function DoExecute(AContext:TIdContext): Boolean; override;
    //
    procedure Startup; override;
    procedure Shutdown; override;
    procedure SetSessionList(const AValue: TIdHTTPCustomSessionList);
    procedure SetSessionState(const Value: Boolean);
    procedure SetSessionIDCookieName(const AValue: string);
    function IsSessionIDCookieNameStored: Boolean;
    function GetSessionFromCookie(AContext:TIdContext;
     AHTTPrequest: TIdHTTPRequestInfo; AHTTPResponse: TIdHTTPResponseInfo;
     var VContinueProcessing: Boolean): TIdHTTPSession;
    procedure InitComponent; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { to be published in TIdHTTPServer}
    property OnCreatePostStream: TIdHTTPCreatePostStream read FOnCreatePostStream write FOnCreatePostStream;
    property OnDoneWithPostStream: TIdHTTPDoneWithPostStream read FOnDoneWithPostStream write FOnDoneWithPostStream;
    property OnCommandGet: TIdHTTPCommandEvent read FOnCommandGet write FOnCommandGet;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    function CreateSession(AContext:TIdContext;
     HTTPResponse: TIdHTTPResponseInfo;
     HTTPRequest: TIdHTTPRequestInfo): TIdHTTPSession;
    destructor Destroy; override;
    function EndSession(const SessionName: String; const RemoteIP: String = ''): Boolean;
    //
    property MIMETable: TIdThreadSafeMimeTable read FMIMETable;
    property SessionList: TIdHTTPCustomSessionList read FSessionList write SetSessionList;
  published
    property AutoStartSession: boolean read FAutoStartSession write FAutoStartSession default Id_TId_HTTPAutoStartSession;
    property DefaultPort default IdPORT_HTTP;
    property KeepAlive: Boolean read FKeepAlive write FKeepAlive default Id_TId_HTTPServer_KeepAlive;
    property MaximumHeaderLineCount: Integer read FMaximumHeaderLineCount write FMaximumHeaderLineCount default Id_TId_HTTPMaximumHeaderLineCount;
    property ParseParams: boolean read FParseParams write FParseParams default Id_TId_HTTPServer_ParseParams;
    property ServerSoftware: string read FServerSoftware write FServerSoftware;
    property SessionState: Boolean read FSessionState write SetSessionState default Id_TId_HTTPServer_SessionState;
    property SessionTimeOut: Integer read FSessionTimeOut write FSessionTimeOut default Id_TId_HTTPSessionTimeOut;
    property SessionIDCookieName: string read FSessionIDCookieName write SetSessionIDCookieName stored IsSessionIDCookieNameStored;
    //
    property OnCommandError: TIdHTTPCommandError read FOnCommandError write FOnCommandError;
    property OnCommandOther: TIdHTTPCommandEvent read FOnCommandOther write FOnCommandOther;
    property OnCreateSession: TIdHTTPCreateSession read FOnCreateSession write FOnCreateSession;
    property OnInvalidSession: TIdHTTPInvalidSessionEvent read FOnInvalidSession write FOnInvalidSession;
    property OnHeadersAvailable: TIdHTTPHeadersAvailableEvent read FOnHeadersAvailable write FOnHeadersAvailable;
    property OnHeadersBlocked: TIdHTTPHeadersBlockedEvent read FOnHeadersBlocked write FOnHeadersBlocked;
    property OnHeaderExpectations: TIdHTTPHeaderExpectationsEvent read FOnHeaderExpectations write FOnHeaderExpectations;
    property OnParseAuthentication: TIdHTTPParseAuthenticationEvent read FOnParseAuthentication write FOnParseAuthentication;
    property OnQuerySSLPort: TIdHTTPQuerySSLPortEvent read FOnQuerySSLPort write FOnQuerySSLPort;
    property OnSessionStart: TIdHTTPSessionStartEvent read FOnSessionStart write FOnSessionStart;
    property OnSessionEnd: TIdHTTPSessionEndEvent read FOnSessionEnd write FOnSessionEnd;
  end;

  TIdHTTPDefaultSessionList = Class(TIdHTTPCustomSessionList)
  protected
    FSessionList: TIdHTTPSessionThreadList;
    procedure RemoveSession(Session: TIdHTTPSession); override;
    // remove a session surgically when list already locked down (prevent deadlock)
    procedure RemoveSessionFromLockedList(AIndex: Integer; ALockedSessionList: TIdHTTPSessionList);
  protected
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    property SessionList: TIdHTTPSessionThreadList read FSessionList;
    procedure Clear; override;
    procedure Add(ASession: TIdHTTPSession); override;
    procedure PurgeStaleSessions(PurgeAll: Boolean = false); override;
    function CreateUniqueSession(const RemoteIP: String): TIdHTTPSession; override;
    function CreateSession(const RemoteIP, SessionID: String): TIdHTTPSession; override;
    function GetSession(const SessionID, RemoteIP: string): TIdHTTPSession; override;
  end;

  TIdHTTPRangeStream = class(TIdBaseStream)
  private
    FSourceStream: TStream;
    FOwnsSource: Boolean;
    FRangeStart, FRangeEnd: Int64;
    FResponseCode: Integer;
  protected
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    procedure IdSetSize(ASize: Int64); override;
  public
    constructor Create(ASource: TStream; ARangeStart, ARangeEnd: Int64; AOwnsSource: Boolean = True);
    destructor Destroy; override;
    property ResponseCode: Integer read FResponseCode;
    property RangeStart: Int64 read FRangeStart;
    property RangeEnd: Int64 read FRangeEnd;
    property SourceStream: TStream read FSourceStream;
  end;

implementation

uses
  {$IFDEF VCL_XE3_OR_ABOVE}
  System.SyncObjs,
  {$ENDIF}
  {$IFDEF KYLIXCOMPAT}
  Libc,
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysTime,
  {$ENDIF}
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.IO,
  System.Threading,
    {$ENDIF}
    {$IFDEF WINDOWS}
  Windows,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF VCL_2010_OR_ABOVE}
    {$IFDEF WINDOWS}
  Windows,
    {$ENDIF}
  {$ENDIF}
  IdCoderMIME, IdResourceStringsProtocols, IdURI, IdIOHandler, IdIOHandlerSocket,
  IdSSL, IdResourceStringsCore, IdStream;

const
  SessionCapacity = 128;
  ContentTypeFormUrlencoded = 'application/x-www-form-urlencoded'; {Do not Localize}

  // Calculate the number of MS between two TimeStamps

function TimeStampInterval(const AStartStamp, AEndStamp: TDateTime): integer;
begin
  Result := Trunc((AEndStamp - AStartStamp) * MSecsPerDay);
end;

{ //(Bas Gooijen) was:
function TimeStampInterval(StartStamp, EndStamp: TDateTime): integer;
var
  days: Integer;
  hour, min, s, ms: Word;
begin
  days := Trunc(EndStamp - StartStamp); // whole days
  DecodeTime(EndStamp - StartStamp, hour, min, s, ms);
  Result := (((days * 24 + hour) * 60 + min) * 60 + s) * 1000 + ms;
end;
}


function GetRandomString(NumChar: UInt32): string;
const
  CharMap = 'qwertzuiopasdfghjklyxcvbnmQWERTZUIOPASDFGHJKLYXCVBNM1234567890';    {Do not Localize}
  MaxChar: UInt32 = Length(CharMap) - 1;
var
  i: integer;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  randomize;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(NumChar);
  {$ELSE}
  SetLength(Result, NumChar);
  {$ENDIF}
  for i := 1 to NumChar do
  begin
    // Add one because CharMap is 1-based
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB.Append(CharMap[Random(MaxChar) + 1]);
    {$ELSE}
    Result[i] := CharMap[Random(MaxChar) + 1];
    {$ENDIF}
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

function DecodeHTTPCommand(const ACmd: string): THTTPCommandType;
var
  I: Integer;
begin
  Result := hcUnknown;
  for I := Low(HTTPRequestStrings) to High(HTTPRequestStrings) do begin
    if TextIsSame(ACmd, HTTPRequestStrings[i]) then begin
      Result := THTTPCommandType(i);
      Exit;
    end;
  end;    // for
end;

type
  TIdHTTPSessionCleanerThread = Class(TIdThread)
  protected
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FSessionList: TIdHTTPCustomSessionList;
  public
    constructor Create(SessionList: TIdHTTPCustomSessionList); reintroduce;
    procedure AfterRun; override;
    procedure Run; override;
  end; // class

function InternalReadLn(AIOHandler: TIdIOHandler): String;
begin
  Result := AIOHandler.ReadLn;
  if AIOHandler.ReadLnTimedout then begin
    raise EIdReadTimeout.Create(RSReadTimeout);
  end;
end;

{ TIdThreadSafeMimeTable }

constructor TIdThreadSafeMimeTable.Create(const AutoFill: Boolean = True);
begin
  inherited Create;
  FTable := TIdMimeTable.Create(AutoFill);
end;

destructor TIdThreadSafeMimeTable.Destroy;
begin
  inherited Lock;
  try
    FreeAndNil(FTable);
  finally
    inherited Unlock;
  end;
  inherited Destroy;
end;

function TIdThreadSafeMimeTable.GetLoadTypesFromOS: Boolean;
begin
  Lock;
  try
    Result := FTable.LoadTypesFromOS;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.SetLoadTypesFromOS(AValue: Boolean);
begin
  Lock;
  try
    FTable.LoadTypesFromOS := AValue;
  finally
    Unlock;
  end;
end;

function TIdThreadSafeMimeTable.GetOnBuildCache: TNotifyEvent;
begin
  Lock;
  try
    Result := FTable.OnBuildCache;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.SetOnBuildCache(AValue: TNotifyEvent);
begin
  Lock;
  try
    FTable.OnBuildCache := AValue;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.BuildCache;
begin
  Lock;
  try
    FTable.BuildCache;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.AddMimeType(const Ext, MIMEType: string; const ARaiseOnError: Boolean = True);
begin
  Lock;
  try
    FTable.AddMimeType(Ext, MIMEType, ARaiseOnError);
  finally
    Unlock;
  end;
end;

function TIdThreadSafeMimeTable.GetFileMIMEType(const AFileName: string): string;
begin
  Lock;
  try
    Result := FTable.GetFileMIMEType(AFileName);
  finally
    Unlock;
  end;
end;

function TIdThreadSafeMimeTable.GetDefaultFileExt(const MIMEType: string): string;
begin
  Lock;
  try
    Result := FTable.GetDefaultFileExt(MIMEType);
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.LoadFromStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
begin
  Lock;
  try
    FTable.LoadFromStrings(AStrings, MimeSeparator);
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeMimeTable.SaveToStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
begin
  Lock;
  try
    FTable.SaveToStrings(AStrings, MimeSeparator);
  finally
    Unlock;
  end;
end;

function TIdThreadSafeMimeTable.Lock: TIdMimeTable;
begin
  inherited Lock;
  Result := FTable;
end;

procedure TIdThreadSafeMimeTable.Unlock;
begin
  inherited Unlock;
end;

{ TIdHTTPRangeStream }

constructor TIdHTTPRangeStream.Create(ASource: TStream; ARangeStart, ARangeEnd: Int64;
  AOwnsSource: Boolean = True);
var
  LSize: Int64;
begin
  inherited Create;
  FSourceStream := ASource;
  FOwnsSource := AOwnsSource;
  FResponseCode := 200;
  if (ARangeStart > -1) or (ARangeEnd > -1) then begin
    LSize := ASource.Size;
    if ARangeStart > -1 then begin
      // requesting prefix range from BOF
      if ARangeStart >= LSize then begin
        // range unsatisfiable
        FResponseCode := 416;
        Exit;
      end;
      if ARangeEnd > -1 then begin
        if ARangeEnd < ARangeStart then begin
          // invalid syntax
          Exit;
        end;
        ARangeEnd := IndyMin(ARangeEnd, LSize-1);
      end else begin
        ARangeEnd := LSize-1;
      end;
    end else begin
      // requesting suffix range from EOF
      if ARangeEnd = 0 then begin
        // range unsatisfiable
        FResponseCode := 416;
        Exit;
      end;
      ARangeStart := IndyMax(LSize - ARangeEnd, 0);
      ARangeEnd := LSize-1;
    end;
    FResponseCode := 206;
    FRangeStart := ARangeStart;
    FRangeEnd := ARangeEnd;
  end;
end;

destructor TIdHTTPRangeStream.Destroy;
begin
  if FOwnsSource then begin
    IdDisposeAndNil(FSourceStream);
  end;
  inherited Destroy;
end;

function TIdHTTPRangeStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  if FResponseCode = 206 then begin
    ACount := Longint(IndyMin(Int64(ACount), (FRangeEnd+1) - FSourceStream.Position));
  end;
  Result := TIdStreamHelper.ReadBytes(FSourceStream, VBuffer, ACount, AOffset);
end;

function TIdHTTPRangeStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
var
  LOffset: Int64;
begin
  if FResponseCode = 206 then begin
    case AOrigin of
      soBeginning: LOffset := FRangeStart + AOffset;
      soCurrent: LOffset := FSourceStream.Position + AOffset;
      soEnd: LOffset := (FRangeEnd+1) + AOffset;
    else
      // TODO: move this into IdResourceStringsProtocols.pas
      raise EIdException.Create('Unknown Seek Origin'); {do not localize}
    end;
    LOffset := IndyMax(LOffset, FRangeStart);
    LOffset := IndyMin(LOffset, FRangeEnd+1);
    Result := TIdStreamHelper.Seek(FSourceStream, LOffset, soBeginning) - FRangeStart;
  end else begin
    Result := TIdStreamHelper.Seek(FSourceStream, AOffset, AOrigin);
  end;
end;

function TIdHTTPRangeStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  Result := 0;
end;

procedure TIdHTTPRangeStream.IdSetSize(ASize: Int64);
begin
end;

{ TIdCustomHTTPServer }

procedure TIdCustomHTTPServer.InitComponent;
begin
  inherited InitComponent;
  FSessionState := Id_TId_HTTPServer_SessionState;
  DefaultPort := IdPORT_HTTP;
  ParseParams := Id_TId_HTTPServer_ParseParams;
  FMIMETable := TIdThreadSafeMimeTable.Create(False);
  FSessionTimeOut := Id_TId_HTTPSessionTimeOut;
  FAutoStartSession := Id_TId_HTTPAutoStartSession;
  FKeepAlive := Id_TId_HTTPServer_KeepAlive;
  FMaximumHeaderLineCount := Id_TId_HTTPMaximumHeaderLineCount;
  FSessionIDCookieName := GSessionIDCookie;
end;

// under ARC, all weak references to a freed object get nil'ed automatically
// so this is mostly redundant
procedure TIdCustomHTTPServer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FSessionList) then begin
    FSessionList := nil;
    FImplicitSessionList := False;
  end;
  inherited Notification(AComponent, Operation);
end;

function TIdCustomHTTPServer.DoParseAuthentication(ASender: TIdContext;
  const AAuthType, AAuthData: String; var VUsername, VPassword: String): Boolean;
var
  s: String;
  LDecoder: TIdDecoderMIME;
begin
  Result := False;
  if Assigned(FOnParseAuthentication) then begin
    FOnParseAuthentication(ASender, AAuthType, AAuthData, VUsername, VPassword, Result);
  end;
  if (not Result) and TextIsSame(AAuthType, 'Basic') then begin    {Do not Localize}
    LDecoder := TIdDecoderMIME.Create;
    try
      s := LDecoder.DecodeString(AAuthData);
    finally
      LDecoder.Free;
    end;
    VUsername := Fetch(s, ':');    {Do not Localize}
    VPassword := s;
    Result := True;
  end;
end;

procedure TIdCustomHTTPServer.DoOnCreateSession(AContext: TIdContext; Var VNewSession: TIdHTTPSession);
begin
  VNewSession := nil;
  if Assigned(FOnCreateSession) then
  begin
    OnCreateSession(AContext, VNewSession);
  end;
end;

function TIdCustomHTTPServer.CreateSession(AContext: TIdContext; HTTPResponse: TIdHTTPResponseInfo;
  HTTPRequest: TIdHTTPRequestInfo): TIdHTTPSession;
var
  LCookie: TIdCookie;
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  Result := nil;
  if SessionState then begin
    LSessionList := FSessionList;
    if Assigned(LSessionList) then begin
      // TODO: pass the RemoteIP to the OnCreateSession event handler, or even
      // better the entire HTTPRequest object...
      DoOnCreateSession(AContext, Result);
      if not Assigned(Result) then begin
        Result := LSessionList.CreateUniqueSession(HTTPRequest.RemoteIP);
      end else begin
        LSessionList.Add(Result);
      end;

      LCookie := HTTPResponse.Cookies.Add;
      LCookie.CookieName := SessionIDCookieName;
      LCookie.Value := Result.SessionID;
      LCookie.Path := '/';    {Do not Localize}

      // By default the cookie will be valid until the user has closed his browser window.
      // MaxAge := SessionTimeOut div 1000;
      HTTPResponse.FSession := Result;
      HTTPRequest.FSession := Result;
    end;
  end;
end;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdCustomHTTPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

destructor TIdCustomHTTPServer.Destroy;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  Active := False; // Set Active to false in order to close all active sessions.
  FreeAndNil(FMIMETable);
  LSessionList := FSessionList;
  if Assigned(LSessionList) and FImplicitSessionList then begin
    FSessionList := nil;
    FImplicitSessionList := False;
    IdDisposeAndNil(LSessionList);
  end;
  inherited Destroy;
end;

procedure TIdCustomHTTPServer.DoCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if Assigned(FOnCommandGet) then begin
    FOnCommandGet(AContext, ARequestInfo, AResponseInfo);
  end;
end;

procedure TIdCustomHTTPServer.DoCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if Assigned(FOnCommandOther) then begin
    FOnCommandOther(AContext, ARequestInfo, AResponseInfo);
  end;
end;

procedure TIdCustomHTTPServer.DoCommandError(AContext: TIdContext; 
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  AException: Exception);
begin
  if Assigned(FOnCommandError) then begin
    FOnCommandError(AContext, ARequestInfo, AResponseInfo, AException);
  end;
end;

procedure TIdCustomHTTPServer.DoConnect(AContext: TIdContext);
begin
  // RLebeau 6/17/08: let the user decide whether to enable SSL in their
  // own event handler.  Indy should not be making any assumptions about
  // whether to implicitally force SSL on any given connection.  This
  // prevents a single server from handling both SSL and non-SSL connections
  // together.  The whole point of the PassThrough property is to allow
  // per-connection SSL handling.
  //
  // TODO: move this new logic into TIdCustomTCPServer directly somehow
  
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough :=
      not DoQuerySSLPort(AContext.Connection.Socket.Binding.Port);
  end;
  inherited DoConnect(AContext);
end;

function TIdCustomHTTPServer.DoQuerySSLPort(APort: TIdPort): Boolean;
begin
  // check for the default HTTPS port, but let the user override that if desired...
  Result := (APort = IdPORT_https);
  if Assigned(FOnQuerySSLPort) then begin
    FOnQuerySSLPort(APort, Result);
  end;
end;

function TIdCustomHTTPServer.DoHeadersAvailable(ASender: TIdContext; const AUri: String;
  AHeaders: TIdHeaderList): Boolean;
begin
  Result := True;
  if Assigned(OnHeadersAvailable) then begin
    OnHeadersAvailable(ASender, AUri, AHeaders, Result);
  end;
end;

procedure TIdCustomHTTPServer.DoHeadersBlocked(ASender: TIdContext; AHeaders: TIdHeaderList;
  var VResponseNo: Integer; var VResponseText, VContentText: String);
begin
  VResponseNo := 403;
  VResponseText := '';
  VContentText := ''; 
  if Assigned(OnHeadersBlocked) then begin
    OnHeadersBlocked(ASender, AHeaders, VResponseNo, VResponseText, VContentText);
  end;
end;

function TIdCustomHTTPServer.DoHeaderExpectations(ASender: TIdContext; const AExpectations: String): Boolean;
begin
  Result := TextIsSame(AExpectations, '100-continue');  {Do not Localize}
  if Assigned(OnHeaderExpectations) then begin
    OnHeaderExpectations(ASender, AExpectations, Result);
  end;
end;

function TIdCustomHTTPServer.DoExecute(AContext:TIdContext): boolean;
var
  LRequestInfo: TIdHTTPRequestInfo;
  LResponseInfo: TIdHTTPResponseInfo;

  procedure ReadCookiesFromRequestHeader;
  var
    LRawCookies: TStringList;
  begin
    LRawCookies := TStringList.Create;
    try
      LRequestInfo.RawHeaders.Extract('Cookie', LRawCookies);    {Do not Localize}
      LRequestInfo.Cookies.AddClientCookies(LRawCookies);
    finally
      FreeAndNil(LRawCookies);
    end;
  end;

  function GetRemoteIP(ASocket: TIdIOHandlerSocket): String;
  begin
    Result := '';
    if ASocket <> nil then begin
      if ASocket.Binding <> nil then begin
        Result := ASocket.Binding.PeerIP;
      end;
    end;
  end;

  function HeadersCanContinue: Boolean;
  var
    LResponseNo: Integer;
    LResponseText, LContentText, S: String;
  begin
    // let the user decide if the request headers are acceptable
    Result := DoHeadersAvailable(AContext, LRequestInfo.URI, LRequestInfo.RawHeaders);
    if not Result then begin
      DoHeadersBlocked(AContext, LRequestInfo.RawHeaders, LResponseNo, LResponseText, LContentText);
      LResponseInfo.ResponseNo := LResponseNo;
      if Length(LResponseText) > 0 then begin
        LResponseInfo.ResponseText := LResponseText;
      end; 
      LResponseInfo.ContentText := LContentText;
      LResponseInfo.CloseConnection := True;
      LResponseInfo.WriteHeader;
      if Length(LContentText) > 0 then begin
        LResponseInfo.WriteContent;
      end;
      Exit;
    end;

    // check for HTTP v1.1 'Host' and 'Expect' headers...

    if not LRequestInfo.IsVersionAtLeast(1, 1) then begin
      Exit;
    end;

    // MUST report a 400 (Bad Request) error if an HTTP/1.1
    // request does not include a 'Host' header
    S := LRequestInfo.RawHeaders.Values['Host'];
    if Length(S) = 0 then begin
      LResponseInfo.ResponseNo := 400;
      LResponseInfo.CloseConnection := True;
      LResponseInfo.WriteHeader;
      Exit;
    end;

    // if the client has already sent some or all of the request
    // body then don't bother checking for a v1.1 'Expect' header
    // TODO: call IOHandler.CheckForDataOnSource(0)...
    if not AContext.Connection.IOHandler.InputBufferIsEmpty then begin
      Exit;
    end;

    S := LRequestInfo.RawHeaders.Values['Expect'];
    if Length(S) = 0 then begin
      Exit;
    end;

    // check if the client expectations can be satisfied...
    Result := DoHeaderExpectations(AContext, S);
    if not Result then begin
      LResponseInfo.ResponseNo := 417;
      LResponseInfo.CloseConnection := True;
      LResponseInfo.WriteHeader;
      Exit;
    end;

    if Pos('100-continue', LowerCase(S)) > 0 then begin  {Do not Localize}
      // the client requested a '100-continue' expectation so send
      // a '100 Continue' reply now before the request body can be read
      AContext.Connection.IOHandler.WriteLn(LRequestInfo.Version + ' 100 ' + RSHTTPContinue + EOL);    {Do not Localize}
    end;
  end;

  function PreparePostStream: Boolean;
  var
    I, Size: Integer;
    S: String;
    LIOHandler: TIdIOHandler;
  begin
    Result := False;
    LIOHandler := AContext.Connection.IOHandler;

    // RLebeau 1/6/2009: don't create the PostStream unless there is
    // actually something to read. This should make it easier for the
    // request handler to know when to use the PostStream and when to
    // use the (Unparsed)Params instead...

    if (LRequestInfo.TransferEncoding <> '') and
      (not TextIsSame(LRequestInfo.TransferEncoding, 'identity')) then {do not localize}
    begin
      if IndyPos('chunked', LowerCase(LRequestInfo.TransferEncoding)) = 0 then begin {do not localize}
        LResponseInfo.ResponseNo := 400; // bad request
        LResponseInfo.CloseConnection := True;
        LResponseInfo.WriteHeader;
        Exit;
      end;
      CreatePostStream(AContext, LRequestInfo.RawHeaders, LRequestInfo.FPostStream);
      if LRequestInfo.FPostStream = nil then begin
        LRequestInfo.FPostStream := TMemoryStream.Create;
      end;
      // TODO: do not seek here.  Leave the Position where CreatePostStream()
      // left it, in case the user decides to use a custom stream that does
      // not start at Position 0.
      LRequestInfo.PostStream.Position := 0;
      repeat
        S := InternalReadLn(LIOHandler);
        I := IndyPos(';', S); {do not localize}
        if I > 0 then begin
          S := Copy(S, 1, I - 1);
        end;
        Size := IndyStrToInt('$' + Trim(S), 0);      {do not localize}
        if Size = 0 then begin
          Break;
        end;
        LIOHandler.ReadStream(LRequestInfo.PostStream, Size);
        InternalReadLn(LIOHandler); // CRLF at end of chunk data
      until False;
      // skip trailer headers
      repeat until InternalReadLn(LIOHandler) = '';
      // TODO: seek back to the original Position where CreatePostStream()
      // left it, not all the way back to Position 0.
      LRequestInfo.PostStream.Position := 0;
    end
    else if LRequestInfo.HasContentLength then
    begin
      CreatePostStream(AContext, LRequestInfo.RawHeaders, LRequestInfo.FPostStream);
      if LRequestInfo.FPostStream = nil then begin
        LRequestInfo.FPostStream := TMemoryStream.Create;
      end;
      // TODO: do not seek here.  Leave the Position where CreatePostStream()
      // left it, in case the user decides to use a custom stream that does
      // not start at Position 0.
      LRequestInfo.PostStream.Position := 0;
      if LRequestInfo.ContentLength > 0 then begin
        LIOHandler.ReadStream(LRequestInfo.PostStream, LRequestInfo.ContentLength);
        // TODO: seek back to the original Position where CreatePostStream()
        // left it, not all the way back to Position 0.
        LRequestInfo.PostStream.Position := 0;
      end;
    end
    // If HTTP Pipelining is used by the client, bytes may exist that belong to
    // the NEXT request!  We need to look at the CURRENT request and only check
    // for misreported body data if a body is actually expected.  GET and HEAD
    // requests do not have bodies...
    else if LRequestInfo.CommandType in [hcPOST, hcPUT] then
    begin
      // TODO: need to handle the case where the ContentType is 'multipart/...',
      // which is self-terminating and does not strictly require the above headers...
      if LIOHandler.InputBufferIsEmpty then begin
        LIOHandler.CheckForDataOnSource(1);
      end;
      if not LIOHandler.InputBufferIsEmpty then begin
        LResponseInfo.ResponseNo := 411; // length required
        LResponseInfo.CloseConnection := True;
        LResponseInfo.WriteHeader;
        Exit;
      end;
    end;
    Result := True;
  end;

var
  i: integer;
  s, LInputLine, LRawHTTPCommand, LCmd, LContentType, LAuthType: String;
  LURI: TIdURI;
  LContinueProcessing, LCloseConnection: Boolean;
  LConn: TIdTCPConnection;
  LEncoding: IIdTextEncoding;
begin
  LContinueProcessing := True;
  Result := False;
  LCloseConnection := not KeepAlive;
  try
    try
      LConn := AContext.Connection;
      repeat
        LInputLine := InternalReadLn(LConn.IOHandler);
        i := RPos(' ', LInputLine, -1);    {Do not Localize}
        if i = 0 then begin
          raise EIdHTTPErrorParsingCommand.Create(RSHTTPErrorParsingCommand);
        end;
        // TODO: don't recreate the Request and Response objects on each loop
        // iteration. Just create them once before entering the loop, and then
        // reset them as needed on each iteration...
        LRequestInfo := TIdHTTPRequestInfo.Create(Self);
        try
          LResponseInfo := TIdHTTPResponseInfo.Create(Self, LRequestInfo, LConn);
          try
            // SG 05.07.99
            // Set the ServerSoftware string to what it's supposed to be.    {Do not Localize}
            LResponseInfo.ServerSoftware := Trim(ServerSoftware);

            // S.G. 6/4/2004: Set the maximum number of lines that will be catured
            // S.G. 6/4/2004: to prevent a remote resource starvation DOS
            LConn.IOHandler.MaxCapturedLines := MaximumHeaderLineCount;

            // Retrieve the HTTP version
            LRawHTTPCommand := LInputLine;
            LRequestInfo.FVersion := Copy(LInputLine, i + 1, MaxInt);

            s := LRequestInfo.Version;
            Fetch(s, '/');  {Do not localize}
            LRequestInfo.FVersionMajor := IndyStrToInt(Fetch(s, '.'), -1);  {Do not Localize}
            LRequestInfo.FVersionMinor := IndyStrToInt(S, -1);

            SetLength(LInputLine, i - 1);

            // Retrieve the HTTP header
            LRequestInfo.RawHeaders.Clear;
            LConn.IOHandler.Capture(LRequestInfo.RawHeaders, '', False);    {Do not Localize}
            // TODO: call HeadersCanContinue() here before the headers are parsed,
            // in case the user needs to overwrite any values...
            LRequestInfo.ProcessHeaders;

            // HTTP 1.1 connections are keep-alive by default
            if not FKeepAlive then begin
              LResponseInfo.CloseConnection := True;
            end
            else if LRequestInfo.IsVersionAtLeast(1, 1) then begin
              LResponseInfo.CloseConnection := TextIsSame(LRequestInfo.Connection, 'close'); {Do not Localize}
            end else begin
              LResponseInfo.CloseConnection := not TextIsSame(LRequestInfo.Connection, 'keep-alive'); {Do not Localize}
            end;

            {TODO Check for 1.0 only at this point}
            LCmd := UpperCase(Fetch(LInputLine, ' '));    {Do not Localize}

            // check for overrides when LCmd is 'POST'...
            if TextIsSame(LCmd, 'POST') then begin
              s := LRequestInfo.MethodOverride; // Google/GData
              if s = '' then begin
                // TODO: make RequestInfo properties for these
                s := LRequestInfo.RawHeaders.Values['X-HTTP-Method']; // Microsoft      {do not localize}
                if s = '' then begin
                  s := LRequestInfo.RawHeaders.Values['X-METHOD-OVERRIDE']; // IBM      {do not localize}
                end;
              end;
              if s <> '' then begin
                LCmd := UpperCase(s);
              end;
            end;

            LRequestInfo.FRawHTTPCommand := LRawHTTPCommand;
            LRequestInfo.FRemoteIP := GetRemoteIP(LConn.Socket);
            LRequestInfo.FCommand := LCmd;
            LRequestInfo.FCommandType := DecodeHTTPCommand(LCmd);

            // GET data - may exist with POSTs also
            LRequestInfo.QueryParams := LInputLine;
            LInputLine := Fetch(LRequestInfo.FQueryParams, '?');    {Do not Localize}

            // Host
            // the next line is done in TIdHTTPRequestInfo.ProcessHeaders()...
            // LRequestInfo.FHost := LRequestInfo.Headers.Values['host'];    {Do not Localize}

            LRequestInfo.FURI := LInputLine;

            // Parse the document input line
            if LInputLine = '*' then begin    {Do not Localize}
              LRequestInfo.FDocument := '*';    {Do not Localize}
            end else begin
              LURI := TIdURI.Create(LInputLine);
              try
                // SG 29/11/01: Per request of Doychin
                // Try to fill the "host" parameter
                LRequestInfo.FDocument := TIdURI.URLDecode(LURI.Path) + TIdURI.URLDecode(LURI.Document);
                if (Length(LURI.Host) > 0) and (Length(LRequestInfo.FHost) = 0) then begin
                  LRequestInfo.FHost := LURI.Host;
                end;
              finally
                FreeAndNil(LURI);
              end;
            end;

            // RLebeau 12/14/2005: provide the user with the headers and let the
            // user decide whether the response processing should continue...
            if not HeadersCanContinue then begin
              Break;
            end;

            // retreive the base ContentType with attributes omitted
            LContentType := ExtractHeaderItem(LRequestInfo.ContentType);

            // Grab Params so we can parse them
            // POSTed data - may exist with GETs also. With GETs, the action
            // params from the form element will be posted

            // TODO: Rune this is the area that needs fixed. Ive hacked it for now
            // Get data can exists with POSTs, but can POST data exist with GETs?
            // If only the first, the solution is easy. If both - need more
            // investigation.

            if not PreparePostStream then begin
              Break;
            end;

            try
              if LRequestInfo.PostStream <> nil then begin
                if TextIsSame(LContentType, ContentTypeFormUrlencoded) then
                begin
                  // decoding percent-encoded octets and applying the CharSet is handled by DecodeAndSetParams() further below...
                  EnsureEncoding(LEncoding, enc8Bit);
                  LRequestInfo.FormParams := ReadStringFromStream(LRequestInfo.PostStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
                  DoneWithPostStream(AContext, LRequestInfo); // don't need the PostStream anymore
                end;
              end;

              // glue together parameters passed in the URL and those
              //
              // RLebeau: should we really be doing this?  For a GET, it might
              // makes sense to do, but for a POST the FormParams is the content
              // and the QueryParams belongs to the URL only, not the content.
              // We should be keeping everything separate for accuracy...
              LRequestInfo.UnparsedParams := LRequestInfo.FormParams;
              if Length(LRequestInfo.QueryParams) > 0 then begin
                if Length(LRequestInfo.UnparsedParams) = 0 then begin
                  LRequestInfo.FUnparsedParams := LRequestInfo.QueryParams;
                end else begin
                  LRequestInfo.FUnparsedParams := LRequestInfo.UnparsedParams + '&'  {Do not Localize}
                   + LRequestInfo.QueryParams;
                end;
              end;

              // Parse Params
              if ParseParams then begin
                if TextIsSame(LContentType, ContentTypeFormUrlencoded) then begin
                  // TODO: decode the data using the algorithm outlined in HTML5 section 4.10.22.6 "URL-encoded form data"
                  LRequestInfo.DecodeAndSetParams(LRequestInfo.UnparsedParams);
                end else begin
                  // Parse only query params when content type is not 'application/x-www-form-urlencoded'    {Do not Localize}
                  // TODO: decode the data using a user-specified charset, defaulting to UTF-8
                  LRequestInfo.DecodeAndSetParams(LRequestInfo.QueryParams);
                end;
              end;

              // Cookies
              ReadCookiesFromRequestHeader;

              try
                // Authentication
                s := LRequestInfo.RawHeaders.Values['Authorization'];    {Do not Localize}
                if Length(s) > 0 then begin
                  LAuthType := Fetch(s, ' ');
                  LRequestInfo.FAuthExists := DoParseAuthentication(AContext, LAuthType, s, LRequestInfo.FAuthUsername, LRequestInfo.FAuthPassword);
                  if not LRequestInfo.FAuthExists then begin
                    raise EIdHTTPUnsupportedAuthorisationScheme.Create(
                      RSHTTPUnsupportedAuthorisationScheme);
                  end;
                end;

                // Session management
                GetSessionFromCookie(AContext, LRequestInfo, LResponseInfo, LContinueProcessing);
                if LContinueProcessing then begin
                  // These essentially all "retrieve" so they are all "Get"s
                  if LRequestInfo.CommandType in [hcGET, hcPOST, hcHEAD] then begin
                    DoCommandGet(AContext, LRequestInfo, LResponseInfo);
                  end else begin
                    DoCommandOther(AContext, LRequestInfo, LResponseInfo);
                  end;
                end;
              except
                on E: EIdSocketError do begin // don't stop socket exceptions
                  raise;
                end;
                on E: EIdHTTPUnsupportedAuthorisationScheme do begin
                  LResponseInfo.ResponseNo := 401;
                  LResponseInfo.ContentText := E.Message;
                  LContinueProcessing := True;
                  for i := 0 to LResponseInfo.WWWAuthenticate.Count - 1 do begin
                    S := LResponseInfo.WWWAuthenticate[i];
                    if TextIsSame(Fetch(S), 'Basic') then begin {Do not localize}
                      LContinueProcessing := False;
                      Break;
                    end;
                  end;
                  if LContinueProcessing then begin
                    LResponseInfo.WWWAuthenticate.Add('Basic');
                  end;
                end;
                on E: Exception do begin
                  LResponseInfo.ResponseNo := 500;
                  LResponseInfo.ContentText := E.Message;
                  DoCommandError(AContext, LRequestInfo, LResponseInfo, E);
                end;
              end;

              // Write even though WriteContent will, may be a redirect or other
              if not LResponseInfo.HeaderHasBeenWritten then begin
                LResponseInfo.WriteHeader;
              end;
              // Always check ContentText first
              if (Length(LResponseInfo.ContentText) > 0)
               or Assigned(LResponseInfo.ContentStream) then begin
                LResponseInfo.WriteContent;
              end;
            finally
              if LRequestInfo.PostStream <> nil then begin
                DoneWithPostStream(AContext, LRequestInfo); // don't need the PostStream anymore
              end;
            end;
          finally
            LCloseConnection := LResponseInfo.CloseConnection;
            FreeAndNil(LResponseInfo);
          end;
        finally
          FreeAndNil(LRequestInfo);
        end;
      until LCloseConnection;
    except
      on E: EIdSocketError do begin
        if not ((E.LastError = Id_WSAESHUTDOWN) or (E.LastError = Id_WSAECONNABORTED) or (E.LastError = Id_WSAECONNRESET)) then begin
          raise;
        end;
      end;
      on E: EIdClosedSocket do begin
        AContext.Connection.Disconnect;
      end;
    end;
  finally
    AContext.Connection.Disconnect(False);
  end;
end;

procedure TIdCustomHTTPServer.DoInvalidSession(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  var VContinueProcessing: Boolean; const AInvalidSessionID: String);
begin
  if Assigned(FOnInvalidSession) then begin
    FOnInvalidSession(AContext, ARequestInfo, AResponseInfo, VContinueProcessing, AInvalidSessionID)
  end;
end;

function TIdCustomHTTPServer.EndSession(const SessionName: String; const RemoteIP: String = ''): Boolean;
var
  LSession: TIdHTTPSession;
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  Result := False;
  LSessionList := SessionList;
  if Assigned(LSessionList) then begin
    LSession := SessionList.GetSession(SessionName, RemoteIP);    {Do not Localize}
    if Assigned(LSession) then begin
      LSessionList.RemoveSession(LSession);
      LSession.DoSessionEnd;
      // must set the owner to nil or the session will try to fire the OnSessionEnd
      // event again, and also remove itself from the session list and deadlock
      LSession.FOwner := nil;
      FreeAndNil(LSession);
      Result := True;
    end;
  end;
end;

procedure TIdCustomHTTPServer.DoSessionEnd(Sender: TIdHTTPSession);
begin
  if Assigned(FOnSessionEnd) then begin
    FOnSessionEnd(Sender);
  end;
end;

procedure TIdCustomHTTPServer.DoSessionStart(Sender: TIdHTTPSession);
begin
  if Assigned(FOnSessionStart) then begin
    FOnSessionStart(Sender);
  end;
end;

function TIdCustomHTTPServer.GetSessionFromCookie(AContext: TIdContext;
  AHTTPRequest: TIdHTTPRequestInfo; AHTTPResponse: TIdHTTPResponseInfo;
  var VContinueProcessing: Boolean): TIdHTTPSession;
var
  LIndex: Integer;
  LSessionID: String;
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  Result := nil;
  VContinueProcessing := True;
  if SessionState then
  begin
    LSessionList := FSessionList;
    LIndex := AHTTPRequest.Cookies.GetCookieIndex(SessionIDCookieName);
    while LIndex >= 0 do
    begin
      LSessionID := AHTTPRequest.Cookies[LIndex].Value;
      if Assigned(LSessionList) then begin
        Result := LSessionList.GetSession(LSessionID, AHTTPRequest.RemoteIP);
        if Assigned(Result) then begin
          Break;
        end;
      end;
      DoInvalidSession(AContext, AHTTPRequest, AHTTPResponse, VContinueProcessing, LSessionID);
      if not VContinueProcessing then begin
        Break;
      end;
      LIndex := AHTTPRequest.Cookies.GetCookieIndex(SessionIDCookieName, LIndex+1);
    end;    { while }
    // check if a session was returned. If not and if AutoStartSession is set to
    // true, Create a new session
    if (Result = nil) and VContinueProcessing and FAutoStartSession then begin
      Result := CreateSession(AContext, AHTTPResponse, AHTTPrequest);
    end;
  end;
  AHTTPRequest.FSession := Result;
  AHTTPResponse.FSession := Result;
end;

procedure TIdCustomHTTPServer.Startup;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  inherited Startup;

  // set the session timeout and options
  LSessionList := FSessionList;
  if not Assigned(LSessionList) then begin
    LSessionList := TIdHTTPDefaultSessionList.Create(Self);
    FSessionList := LSessionList;
    FImplicitSessionList := True;
  end;

  if FSessionTimeOut <> 0 then begin
    LSessionList.FSessionTimeout := FSessionTimeOut;
  end else begin
    FSessionState := False;
  end;

  // Session events
  LSessionList.OnSessionStart := DoSessionStart;
  LSessionList.OnSessionEnd := DoSessionEnd;

  // If session handling is enabled, create the housekeeper thread
  if SessionState then begin
    FSessionCleanupThread := TIdHTTPSessionCleanerThread.Create(LSessionList);
  end;
end;

procedure TIdCustomHTTPServer.Shutdown;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  // Boost the clear thread priority to give it a good chance to terminate
  if Assigned(FSessionCleanupThread) then begin
    IndySetThreadPriority(FSessionCleanupThread, tpNormal);
    FSessionCleanupThread.TerminateAndWaitFor;
    FreeAndNil(FSessionCleanupThread);
  end;

  // RLebeau: FSessionList might not be assignd yet if Shutdown() is being
  // called due to an exception raised in Startup()...
  LSessionList := FSessionList;
  if Assigned(LSessionList) then begin
    if FImplicitSessionList then begin
      SetSessionList(nil);
    end else begin
      LSessionList.Clear;
    end;
    {$IFDEF USE_OBJECT_ARC}LSessionList := nil;{$ENDIF}
  end;

  inherited Shutdown;
end;

procedure TIdCustomHTTPServer.SetSessionList(const AValue: TIdHTTPCustomSessionList);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  LSessionList := FSessionList;

  if LSessionList <> AValue then
  begin
    // RLebeau - is this really needed?  What should happen if this
    // gets called by Notification() if the sessionList is freed while
    // the server is still Active?
    if Active then begin
      raise EIdException.Create(RSHTTPCannotSwitchSessionListWhenActive);
    end;

    // under ARC, all weak references to a freed object get nil'ed automatically

    // If implicit one already exists free it
    // Free the default SessionList
    if FImplicitSessionList then begin
      // Under D8 notification gets called after .Free of FreeAndNil, but before
      // its set to nil with a side effect of IDisposable. To counteract this we
      // set it to nil first.
      // -Kudzu
      FSessionList := nil;
      FImplicitSessionList := False;
      IdDisposeAndNil(LSessionList);
    end;

    {$IFNDEF USE_OBJECT_ARC}
    // Ensure we will no longer be notified when the component is freed
    if LSessionList <> nil then begin
      LSessionList.RemoveFreeNotification(Self);
    end;
    {$ENDIF}

    FSessionList := AValue;

    {$IFNDEF USE_OBJECT_ARC}
    // Ensure we will be notified when the component is freed, even is it's on
    // another form
    if AValue <> nil then begin
      AValue.FreeNotification(Self);
    end;
    {$ENDIF}
  end;
end;

procedure TIdCustomHTTPServer.SetSessionState(const Value: Boolean);
begin
  // ToDo: Add thread multiwrite protection here
  if (not (IsDesignTime or IsLoading)) and Active then begin
    raise EIdHTTPCannotSwitchSessionStateWhenActive.Create(RSHTTPCannotSwitchSessionStateWhenActive);
  end;
  FSessionState := Value;
end;

procedure TIdCustomHTTPServer.SetSessionIDCookieName(const AValue: string);
var
  LCookieName: string;
begin
  // ToDo: Add thread multiwrite protection here
  if (not (IsDesignTime or IsLoading)) and Active then begin
    raise EIdHTTPCannotSwitchSessionIDCookieNameWhenActive.Create(RSHTTPCannotSwitchSessionIDCookieNameWhenActive);
  end;
  LCookieName := Trim(AValue);
  if LCookieName = '' then begin
    // TODO: move this into IdResourceStringsProtocols.pas
    raise EIdException.Create('Invalid cookie name'); {do not localize}
  end;
  FSessionIDCookieName := AValue;
end;

function TIdCustomHTTPServer.IsSessionIDCookieNameStored: Boolean;
begin
  Result := not TextIsSame(SessionIDCookieName, GSessionIDCookie);
end;

procedure TIdCustomHTTPServer.CreatePostStream(ASender: TIdContext;
  AHeaders: TIdHeaderList; var VPostStream: TStream);
begin
  if Assigned(OnCreatePostStream) then begin
    OnCreatePostStream(ASender, AHeaders, VPostStream);
  end;
end;

procedure TIdCustomHTTPServer.DoneWithPostStream(ASender: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo);
var
  LCanFree: Boolean;
  LStream: TStream;
begin
  LCanFree := True;
  if Assigned(FOnDoneWithPostStream) then begin
    FOnDoneWithPostStream(ASender, ARequestInfo, LCanFree);
  end;
  if LCanFree then begin
    LStream := ARequestInfo.FPostStream;
    ARequestInfo.FPostStream := nil;
    IdDisposeAndNil(LStream);
  end else begin
    ARequestInfo.FPostStream := nil;
  end;
end;

{ TIdHTTPSession }

constructor TIdHTTPSession.Create(AOwner: TIdHTTPCustomSessionList);
begin
  inherited Create;

  FLock := TIdCriticalSection.Create;
  FContent := TStringList.Create;
  FOwner := AOwner;
  if Assigned(AOwner) then
  begin
    if Assigned(AOwner.OnSessionStart) then begin
      AOwner.OnSessionStart(Self);
    end;
  end;
end;

constructor TIdHTTPSession.CreateInitialized(AOwner: TIdHTTPCustomSessionList; const SessionID, RemoteIP: string);
begin
  inherited Create;

  FSessionID := SessionID;
  FRemoteHost := RemoteIP;

  // TODO: use a timer to signal when the session becomes stale, instead of
  // pooling for stale sessions every second...
  FLastTimeStamp := Now;

  FLock := TIdCriticalSection.Create;
  FContent := TStringList.Create;
  FOwner := AOwner;
  if Assigned(AOwner) then
  begin
    if Assigned(AOwner.OnSessionStart) then begin
      AOwner.OnSessionStart(Self);
    end;
  end;
end;

destructor TIdHTTPSession.Destroy;
begin
// code added here should also be reflected in
// the TIdHTTPDefaultSessionList.RemoveSessionFromLockedList method
// Why? It calls this function and this code gets executed?
  DoSessionEnd;
  FreeAndNil(FContent);
  FreeAndNil(FLock);
  if Assigned(FOwner) then begin
    FOwner.RemoveSession(Self);
  end;
  inherited Destroy;
end;

procedure TIdHTTPSession.DoSessionEnd;
begin
  if Assigned(FOwner) and Assigned(FOwner.FOnSessionEnd) then begin
    FOwner.FOnSessionEnd(Self);
  end;
end;

function TIdHTTPSession.IsSessionStale: boolean;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LOwner: TIdHTTPCustomSessionList;
begin
  LOwner := FOwner;
  if Assigned(LOwner) then begin
    // TODO: use ticks to keep track of the session's duration instead of using
    // a date/time. Or, at least use a UTC date/time instead of a local date/time...
    Result := TimeStampInterval(FLastTimeStamp, Now) > Integer(LOwner.SessionTimeout);
  end else begin
    Result := True;
  end;
end;

procedure TIdHTTPSession.Lock;
begin
  // ToDo: Add session locking code here
  FLock.Enter;
end;

procedure TIdHTTPSession.SetContent(const Value: TStrings);
begin
  FContent.Assign(Value);
end;

procedure TIdHTTPSession.Unlock;
begin
  // ToDo: Add session unlocking code here
  FLock.Leave;
end;

{ TIdHTTPRequestInfo }

constructor TIdHTTPRequestInfo.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FCommandType := hcUnknown;
  FCookies := TIdCookies.Create(Self);
  FParams  := TStringList.Create;
  ContentLength := -1;
end;

procedure TIdHTTPRequestInfo.DecodeAndSetParams(const AValue: String);
var
  i, j : Integer;
  s: string;
  LEncoding: IIdTextEncoding;
begin
  // Convert special characters
  // ampersand '&' separates values    {Do not Localize}
  Params.BeginUpdate;
  try
    Params.Clear;
    // TODO: provide an event or property that lets the user specify
    // which charset to use for decoding query string parameters.  We
    // should not be using the 'Content-Type' charset for that.  For
    // 'application/x-www-form-urlencoded' forms, we should be, though...
    LEncoding := CharsetToEncoding(CharSet);
    i := 1;
    while i <= Length(AValue) do
    begin
      j := i;
      while (j <= Length(AValue)) and (AValue[j] <> '&') do {do not localize}
      begin
        Inc(j);
      end;
      s := Copy(AValue, i, j-i);
      // See RFC 1866 section 8.2.1. TP
      s := ReplaceAll(s, '+', ' ');  {do not localize}
      Params.Add(TIdURI.URLDecode(s, LEncoding));
      i := j + 1;
    end;
  finally
    Params.EndUpdate;
  end;
end;

destructor TIdHTTPRequestInfo.Destroy;
begin
  FreeAndNil(FCookies);
  FreeAndNil(FParams);
  FreeAndNil(FPostStream);
  inherited Destroy;
end;

function TIdHTTPRequestInfo.IsVersionAtLeast(const AMajor, AMinor: Integer): Boolean;
begin
  Result := (FVersionMajor > AMajor) or
            ((FVersionMajor = AMajor) and (FVersionMinor >= AMinor));
end;

{ TIdHTTPResponseInfo }

procedure TIdHTTPResponseInfo.CloseSession;
var
  i: Integer;
  LCookie: TIdCookie;
begin
  i := Cookies.GetCookieIndex(HTTPServer.SessionIDCookieName);
  while i > -1 do begin
    Cookies.Delete(i);
    i := Cookies.GetCookieIndex(HTTPServer.SessionIDCookieName, i);
  end;
  LCookie := Cookies.Add;
  LCookie.CookieName := HTTPServer.SessionIDCookieName;
  LCookie.Expires := Date-7;
  FreeAndNil(FSession);
end;

constructor TIdHTTPResponseInfo.Create(AServer: TIdCustomHTTPServer;
  ARequestInfo: TIdHTTPRequestInfo; AConnection: TIdTCPConnection);
begin
  inherited Create(AServer);

  FRequestInfo := ARequestInfo;
  FConnection := AConnection;
  FHttpServer := AServer;

  FFreeContentStream := True;

  ResponseNo := GResponseNo;
  ContentType := ''; //GContentType;
  ContentLength := GFContentLength;

  {Some clients may not support folded lines}
  RawHeaders.FoldLines := False;
  FCookies := TIdCookies.Create(Self);

  {TODO Specify version - add a class method dummy that calls version}
  ServerSoftware := GServerSoftware;

end;

destructor TIdHTTPResponseInfo.Destroy;
begin
  FreeAndNil(FCookies);
  ReleaseContentStream;
  inherited Destroy;
end;

procedure TIdHTTPResponseInfo.Redirect(const AURL: string);
begin
  ResponseNo := 302;
  Location := AURL;
end;

procedure TIdHTTPResponseInfo.ReleaseContentStream;
begin
  if FreeContentStream then begin
    IdDisposeAndNil(FContentStream);
  end else begin
    FContentStream := nil;
  end;
end;

procedure TIdHTTPResponseInfo.SetCloseConnection(const Value: Boolean);
begin
  Connection := iif(Value, 'close', 'keep-alive');    {Do not Localize}
  // TODO: include a 'Keep-Alive' header to specify a timeout value
  FCloseConnection := Value;
end;

procedure TIdHTTPResponseInfo.SetCookies(const AValue: TIdCookies);
begin
  FCookies.Assign(AValue);
end;

procedure TIdHTTPResponseInfo.SetHeaders;
var
  I: Integer;
begin
  inherited SetHeaders;
  if Server <> '' then begin
    FRawHeaders.Values['Server'] := Server;    {Do not Localize}
  end;
  if Location <> '' then begin
    FRawHeaders.Values['Location'] := Location;    {Do not Localize}
  end;
  if FLastModified > 0 then begin
    FRawHeaders.Values['Last-Modified'] := LocalDateTimeToHttpStr(FLastModified); {do not localize}
  end;
  if FWWWAuthenticate.Count > 0 then begin
    FRawHeaders.Values['WWW-Authenticate'] := ''; {Do not Localize}
    for I := 0 to FWWWAuthenticate.Count-1 do begin
      FRawHeaders.AddValue('WWW-Authenticate', FWWWAuthenticate[I]);    {Do not Localize}
    end;
  end
  else if AuthRealm <> '' then begin
    FRawHeaders.Values['WWW-Authenticate'] := 'Basic realm="' + AuthRealm + '"';    {Do not Localize}
  end;
  if FProxyAuthenticate.Count > 0 then begin
    FRawHeaders.Values['Proxy-Authenticate'] := ''; {Do not Localize}
    for I := 0 to FProxyAuthenticate.Count-1 do begin
      FRawHeaders.AddValue('Proxy-Authenticate', FProxyAuthenticate[I]);    {Do not Localize}
    end;
  end
end;

procedure TIdHTTPResponseInfo.SetResponseNo(const AValue: Integer);
begin
  FResponseNo := AValue;
  case FResponseNo of
    100: ResponseText := RSHTTPContinue;
    // 2XX: Success
    200: ResponseText := RSHTTPOK;
    201: ResponseText := RSHTTPCreated;
    202: ResponseText := RSHTTPAccepted;
    203: ResponseText := RSHTTPNonAuthoritativeInformation;
    204: ResponseText := RSHTTPNoContent;
    205: ResponseText := RSHTTPResetContent;
    206: ResponseText := RSHTTPPartialContent;
    // 3XX: Redirections
    301: ResponseText := RSHTTPMovedPermanently;
    302: ResponseText := RSHTTPMovedTemporarily;
    303: ResponseText := RSHTTPSeeOther;
    304: ResponseText := RSHTTPNotModified;
    305: ResponseText := RSHTTPUseProxy;
    // 4XX Client Errors
    400: ResponseText := RSHTTPBadRequest;
    401: ResponseText := RSHTTPUnauthorized;
    403: ResponseText := RSHTTPForbidden;
    404: begin
      ResponseText := RSHTTPNotFound;
      // Close connection
      CloseConnection := True;
    end;
    405: ResponseText := RSHTTPMethodNotAllowed;
    406: ResponseText := RSHTTPNotAcceptable;
    407: ResponseText := RSHTTPProxyAuthenticationRequired;
    408: ResponseText := RSHTTPRequestTimeout;
    409: ResponseText := RSHTTPConflict;
    410: ResponseText := RSHTTPGone;
    411: ResponseText := RSHTTPLengthRequired;
    412: ResponseText := RSHTTPPreconditionFailed;
    413: ResponseText := RSHTTPRequestEntityTooLong;
    414: ResponseText := RSHTTPRequestURITooLong;
    415: ResponseText := RSHTTPUnsupportedMediaType;
    417: ResponseText := RSHTTPExpectationFailed;
    428: ResponseText := RSHTTPPreconditionRequired;
    429: ResponseText := RSHTTPTooManyRequests;
    431: ResponseText := RSHTTPRequestHeaderFieldsTooLarge;
    // 5XX Server errors
    500: ResponseText := RSHTTPInternalServerError;
    501: ResponseText := RSHTTPNotImplemented;
    502: ResponseText := RSHTTPBadGateway;
    503: ResponseText := RSHTTPServiceUnavailable;
    504: ResponseText := RSHTTPGatewayTimeout;
    505: ResponseText := RSHTTPHTTPVersionNotSupported;
    511: ResponseText := RSHTTPNetworkAuthenticationRequired;
    else
      ResponseText := RSHTTPUnknownResponseCode;
  end;

  {if ResponseNo >= 400 then
    // Force COnnection closing when there is error during the request processing
    CloseConnection := true;
  end;}
end;

function TIdHTTPResponseInfo.ServeFile(AContext: TIdContext; const AFile: String): Int64;
var
  EnableTransferFile: Boolean;
begin
  if Length(ContentType) = 0 then begin
    ContentType := HTTPServer.MIMETable.GetFileMIMEType(AFile);
  end;
  ContentLength := FileSizeByName(AFile);
  if Length(ContentDisposition) = 0 then begin
    // TODO: use EncodeHeader() here...
    ContentDisposition := IndyFormat('attachment; filename="%s";', [ExtractFileName(AFile)]);  {do not localize}
  end;
  WriteHeader;
  EnableTransferFile := not (AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase);
  Result := AContext.Connection.IOHandler.WriteFile(AFile, EnableTransferFile);
end;

function TIdHTTPResponseInfo.SmartServeFile(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; const AFile: String): Int64;
var
  LFileDate : TDateTime;
  LReqDate : TDateTime;
begin
  LFileDate := IndyFileAge(AFile);
  if (LFileDate = 0.0) and (not FileExists(AFile)) then
  begin
    ResponseNo := 404;
    Result := 0;
  end else
  begin
    LReqDate := GMTToLocalDateTime(ARequestInfo.RawHeaders.Values['If-Modified-Since']);  {do not localize}
    // if the file date in the If-Modified-Since header is within 2 seconds of the
    // actual file, then we will send a 304. We don't use the ETag - offers nothing
    // over the file date for static files on windows. Linux: consider using iNode

    // RLebeau 2/21/2011: TODO - make use of ETag. It is supposed to be updated
    // whenever the file contents change, regardless of the file's timestamps.

    if (LReqDate <> 0) and (abs(LReqDate - LFileDate) < 2 * (1 / (24 * 60 * 60))) then
    begin
      ResponseNo := 304;
      Result := 0;
    end else
    begin
      Date := Now;
      LastModified := LFileDate;
      Result := ServeFile(AContext, AFile);
    end;
  end;
end;

procedure TIdHTTPResponseInfo.WriteContent;
begin
  if not HeaderHasBeenWritten then begin
    WriteHeader;
  end;

  // RLebeau 11/23/2014: Per RFC 2616 Section 4.3:
  //
  // For response messages, whether or not a message-body is included with
  // a message is dependent on both the request method and the response
  // status code (section 6.1.1). All responses to the HEAD request method
  // MUST NOT include a message-body, even though the presence of entity-
  // header fields might lead one to believe they do. All 1xx
  // (informational), 204 (no content), and 304 (not modified) responses
  // MUST NOT include a message-body. All other responses do include a
  // message-body, although it MAY be of zero length.

  if not (
    (FRequestInfo.CommandType = hcHEAD) or
    ((ResponseNo div 100) = 1) or   // informational
    (ResponseNo = 204) or           // no content
    (ResponseNo = 304)              // not modified
    ) then
  begin
    // Always check ContentText first
    if ContentText <> '' then begin
      FConnection.IOHandler.Write(ContentText, CharsetToEncoding(CharSet));
    end
    else if Assigned(ContentStream) then begin
      // If ContentLength has been assigned then do not send the entire file,
      // in case it grew after WriteHeader() generated the 'Content-Length'
      // header.  We cannot exceed the byte count that we told the client
      // we will be sending...

      // TODO: apply this rule to ContentText as well...

      // TODO: do not seek here.  Leave the Position where the user left it,
      // in case the user decides to use a custom stream that does not start
      // at Position 0.  Send from the current Position onwards.

      if HasContentLength then begin
        if ContentLength > 0 then begin
          ContentStream.Position := 0;
          FConnection.IOHandler.Write(ContentStream, ContentLength, False);
        end;
      end else begin
        ContentStream.Position := 0;
        FConnection.IOHandler.Write(ContentStream);
      end;
    end
    else begin
      FConnection.IOHandler.Write('<HTML><BODY><B>' + IntToStr(ResponseNo) + ' ' + ResponseText    {Do not Localize}
       + '</B></BODY></HTML>', CharsetToEncoding(CharSet));    {Do not Localize}
    end;
  end;

  // Clear All - This signifies that WriteConent has been called.
  ContentText := '';    {Do not Localize}
  ReleaseContentStream;
end;

procedure TIdHTTPResponseInfo.WriteHeader;
var
  i: Integer;
  LBufferingStarted: Boolean;
begin
  if HeaderHasBeenWritten then begin
    raise EIdHTTPHeaderAlreadyWritten.Create(RSHTTPHeaderAlreadyWritten);
  end;
  FHeaderHasBeenWritten := True;

  if AuthRealm <> '' then
  begin
    ResponseNo := 401;
    if (Length(ContentText) = 0) and (not Assigned(ContentStream)) then
    begin
      ContentType := 'text/html; charset=utf-8';    {Do not Localize}
      ContentText := '<HTML><BODY><B>' + IntToStr(ResponseNo) + ' ' + ResponseText + '</B></BODY></HTML>';    {Do not Localize}
      ContentLength := -1; // calculated below
    end;
  end;

  // RLebeau 5/15/2012: for backwards compatibility. We really should
  // make the user set this every time instead...
  if ContentType = '' then begin
    if (ContentText <> '') or (Assigned(ContentStream)) then begin
      ContentType := 'text/html; charset=ISO-8859-1'; {Do not Localize}
    end;
  end;

  // RLebeau: according to RFC 2616 Section 4.4:
  //
  // If a Content-Length header field (section 14.13) is present, its
  // decimal value in OCTETs represents both the entity-length and the
  // transfer-length. The Content-Length header field MUST NOT be sent
  // if these two lengths are different (i.e., if a Transfer-Encoding
  // header field is present). If a message is received with both a
  // Transfer-Encoding header field and a Content-Length header field,
  // the latter MUST be ignored.
  // ...
  // Messages MUST NOT include both a Content-Length header field and a
  // non-identity transfer-coding. If the message does include a non-
  // identity transfer-coding, the Content-Length MUST be ignored.

  if (ContentLength = -1) and
    ((TransferEncoding = '') or TextIsSame(TransferEncoding, 'identity')) then {do not localize}
  begin
    if not (
      (FRequestInfo.CommandType = hcHEAD) or
      ((ResponseNo div 100) = 1) or   // informational
      (ResponseNo = 204) or           // no content
      (ResponseNo = 304)              // not modified
      ) then
    begin
      // Always check ContentText first
      if ContentText <> '' then begin
        ContentLength := CharsetToEncoding(CharSet).GetByteCount(ContentText);
      end
      else if Assigned(ContentStream) then begin
        // TODO: take the current Position into account, in case the user decides
        // to use a custom stream that does not start at Position 0.  Send data
        // from the current Position onwards.
        ContentLength := ContentStream.Size;
      end else begin
        ContentType := 'text/html; charset=utf-8';    {Do not Localize}
        ContentText := '<HTML><BODY><B>' + IntToStr(ResponseNo) + ' ' + ResponseText + '</B></BODY></HTML>';    {Do not Localize}
        ContentLength := CharsetToEncoding(CharSet).GetByteCount(ContentText);
      end;
    end else begin
      ContentLength := 0;
    end;
  end;

  if Date <= 0 then begin
    Date := Now;
  end;

  SetHeaders;

  LBufferingStarted := not FConnection.IOHandler.WriteBufferingActive;
  if LBufferingStarted then begin
    FConnection.IOHandler.WriteBufferOpen;
  end;
  try
    // Write HTTP status response
    // TODO: if the client sent an HTTP/1.0 request, send an HTTP/1.0 response?
    FConnection.IOHandler.WriteLn('HTTP/1.1 ' + IntToStr(ResponseNo) + ' ' + ResponseText);    {Do not Localize}
    // Write headers
    FConnection.IOHandler.Write(RawHeaders);
    // Write cookies
    for i := 0 to Cookies.Count - 1 do begin
      FConnection.IOHandler.WriteLn('Set-Cookie: ' + Cookies[i].ServerCookie);    {Do not Localize}
    end;
    // HTTP headers end with a double CR+LF
    FConnection.IOHandler.WriteLn;
    if LBufferingStarted then begin
      FConnection.IOHandler.WriteBufferClose;
    end;
  except
    if LBufferingStarted then begin
      FConnection.IOHandler.WriteBufferCancel;
    end;
    raise;
  end;
end;

function TIdHTTPResponseInfo.GetServer: string;
begin
  Result := Server;
end;

procedure TIdHTTPResponseInfo.SetServer(const Value: string);
begin
  Server := Value;
end;

{ TIdHTTPDefaultSessionList }

procedure TIdHTTPDefaultSessionList.Add(ASession: TIdHTTPSession);
begin
  SessionList.Add(ASession);
end;

procedure TIdHTTPDefaultSessionList.Clear;
var
  LSessionList: TIdHTTPSessionList;
  LSession: TIdHTTPSession;
  i: Integer;
begin
  LSessionList := SessionList.LockList;
  try
    for i := LSessionList.Count - 1 DownTo 0 do
    begin
      LSession := {$IFDEF HAS_GENERICS_TList}LSessionList[i]{$ELSE}TIdHTTPSession(LSessionList[i]){$ENDIF};
      if LSession <> nil then
      begin
        LSession.DoSessionEnd;
        // must set the owner to nil or the session will try to fire the
        // OnSessionEnd event again, and also remove itself from the session
        // list and deadlock
        LSession.FOwner := nil;
        FreeAndNil(LSession);
      end;
    end;
    LSessionList.Clear;
    LSessionList.Capacity := SessionCapacity;
  finally
    SessionList.UnlockList;
  end;
end;

function TIdHTTPDefaultSessionList.CreateSession(const RemoteIP, SessionID: String): TIdHTTPSession;
begin
  Result := TIdHTTPSession.CreateInitialized(Self, SessionID, RemoteIP);
  SessionList.Add(Result);
end;

function TIdHTTPDefaultSessionList.CreateUniqueSession(
  const RemoteIP: String): TIdHTTPSession;
var
  SessionID: String;
begin
  SessionID := GetRandomString(15);
  // TODO: shouldn't this lock the SessionList before entering the
  // loop to prevent race conditions across multiple threads?
  {SessionList.LockList;
  try}
    while GetSession(SessionID, RemoteIP) <> nil do
    begin
      SessionID := GetRandomString(15);
    end;    // while
    Result := CreateSession(RemoteIP, SessionID);
  {finally
    SessionList.UnlockList;
  end;}
end;

destructor TIdHTTPDefaultSessionList.Destroy;
begin
  Clear;
  FreeAndNil(FSessionList);
  inherited destroy;
end;

function TIdHTTPDefaultSessionList.GetSession(const SessionID, RemoteIP: string): TIdHTTPSession;
var
  LSessionList: TIdHTTPSessionList;
  LSession: TIdHTTPSession;
  i: Integer;
begin
  Result := nil;
  LSessionList := SessionList.LockList;
  try
    // get current time stamp
    for i := 0 to LSessionList.Count - 1 do
    begin
      LSession := TIdHTTPSession(LSessionList[i]);
      // the stale sessions check has been removed... the cleanup thread should suffice plenty
      if Assigned(LSession) and TextIsSame(LSession.FSessionID, SessionID) and ((Length(RemoteIP) = 0) or TextIsSame(LSession.RemoteHost, RemoteIP)) then
      begin
        // Session found
        // TODO: use a timer to signal when the session becomes stale, instead of
        // pooling for stale sessions every second...
        LSession.FLastTimeStamp := Now;
        Result := LSession;
        Break;
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.InitComponent;
var
  LList: TIdHTTPSessionList;
begin
  inherited InitComponent;
  FSessionList := TIdHTTPSessionThreadList.Create;
  LList := FSessionList.LockList;
  try
    LList.Capacity := SessionCapacity;
  finally
    FSessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.PurgeStaleSessions(PurgeAll: Boolean = false);
var
  LSessionList: TIdHTTPSessionList;
  LSession: TIdHTTPSession;
  i: Integer;
begin
  // S.G. 24/11/00: Added a way to force a session purge (Used when thread is terminated)
  // Get necessary data
  Assert(SessionList<>nil);

  LSessionList := SessionList.LockList;
  try
    // Loop though the sessions.
    for i := LSessionList.Count - 1 downto 0 do
    begin
      // Identify the stale sessions
      LSession := {$IFDEF HAS_GENERICS_TList}LSessionList[i]{$ELSE}TIdHTTPSession(LSessionList[i]){$ENDIF};
      if Assigned(LSession) and (PurgeAll or LSession.IsSessionStale) then
      begin
        RemoveSessionFromLockedList(i, LSessionList);
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.RemoveSession(Session: TIdHTTPSession);
var
  LSessionList: TIdHTTPSessionList;
  Index: integer;
begin
  LSessionList := SessionList.LockList;
  try
    Index := LSessionList.IndexOf(Session);
    if index > -1 then
    begin
      LSessionList.Delete(index);
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.RemoveSessionFromLockedList(AIndex: Integer;
  ALockedSessionList: TIdHTTPSessionList);
var
  LSession: TIdHTTPSession;
begin
  LSession := {$IFDEF HAS_GENERICS_TList}ALockedSessionList[AIndex]{$ELSE}TIdHTTPSession(ALockedSessionList[AIndex]){$ENDIF};
  LSession.DoSessionEnd;
  // must set the owner to nil or the session will try to fire the OnSessionEnd
  // event again, and also remove itself from the session list and deadlock
  LSession.FOwner := nil;
  FreeAndNil(LSession);
  ALockedSessionList.Delete(AIndex);
end;

{ TIdHTTPSessionClearThread }

procedure TIdHTTPSessionCleanerThread.AfterRun;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  LSessionList := FSessionList;
  if Assigned(LSessionList) then begin
    LSessionList.PurgeStaleSessions(True);
  end;
  inherited AfterRun;
end;

constructor TIdHTTPSessionCleanerThread.Create(SessionList: TIdHTTPCustomSessionList);
begin
  inherited Create(false);
  // thread priority used to be set to tpIdle but this is not supported
  // under DotNet. How low do you want to go?
  IndySetThreadPriority(Self, tpLowest);
  FSessionList := SessionList;
end;

procedure TIdHTTPSessionCleanerThread.Run;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSessionList: TIdHTTPCustomSessionList;
begin
  // TODO: use a timer to signal when sessions becomes stale, instead of
  // pooling for stale sessions every second...
  IndySleep(1000);
  LSessionList := FSessionList;
  if Assigned(LSessionList) then begin
    LSessionList.PurgeStaleSessions(Terminated);
  end;
end;

end.
