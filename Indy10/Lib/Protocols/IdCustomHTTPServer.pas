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
  IdAssignedNumbers,
  IdContext, IdException,
  IdGlobal, IdStack,
  IdExceptionCore, IdGlobalProtocols, IdHeaderList, IdCustomTCPServer, IdTCPConnection, IdThread, IdCookie,
  IdHTTPHeaderInfo, IdStackConsts,
  IdBaseComponent;

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
  HTTPRequestStrings: array[0..ord(high(THTTPCommandType))] of string = ('UNKNOWN', 'HEAD','GET','POST','DELETE','PUT','TRACE', 'OPTIONS'); {do not localize}

type
  // Forwards
  TIdHTTPSession = class;
  TIdHTTPCustomSessionList = class;
  TIdHTTPRequestInfo = class;
  TIdHTTPResponseInfo = class;
  TIdCustomHTTPServer = class;

  //events
  TOnSessionEndEvent = procedure(Sender: TIdHTTPSession) of object;
  TOnSessionStartEvent = procedure(Sender: TIdHTTPSession) of object;
  TOnCreateSession = procedure(ASender:TIdContext;
   var VHTTPSession: TIdHTTPSession) of object;
  TOnCreatePostStream = procedure(AContext: TIdContext; AHeaders: TIdHeaderList; var VPostStream: TStream) of object;
  TIdHTTPCommandEvent = procedure(AContext:TIdContext;
   ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo) of object;
  TIdHTTPInvalidSessionEvent = procedure(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
    var VContinueProcessing: Boolean; const AInvalidSessionID: String) of object;
  TIdHTTPHeadersAvailableEvent = procedure(AContext: TIdContext; AHeaders: TIdHeaderList; var VContinueProcessing: Boolean) of object;
  TIdHTTPHeadersBlockedEvent = procedure(AContext: TIdContext; AHeaders: TIdHeaderList; var VResponseNo: Integer; var VResponseText, VContentText: String) of object;
  TIdHTTPHeaderExpectationsEvent = procedure(AContext: TIdContext; const AExpectations: String; var VContinueProcessing: Boolean) of object;

  //objects
  EIdHTTPServerError = class(EIdException);
  EIdHTTPHeaderAlreadyWritten = class(EIdHTTPServerError);
  EIdHTTPErrorParsingCommand = class(EIdHTTPServerError);
  EIdHTTPUnsupportedAuthorisationScheme = class(EIdHTTPServerError);
  EIdHTTPCannotSwitchSessionStateWhenActive = class(EIdHTTPServerError);

  TIdHTTPRequestInfo = class(TIdRequestHeaderInfo)
  protected
    FAuthExists: Boolean;
    FCookies: TIdServerCookies;
    FParams: TStrings;
    FPostStream: TStream;
    FRawHTTPCommand: string;
    FRemoteIP: string;
    FSession: TIdHTTPSession;
    FDocument: string;
    FCommand: string;
    FVersion: string;
    FAuthUsername: string;
    FAuthPassword: string;
    FUnparsedParams: string;
    FQueryParams: string;
    FFormParams: string;
    FCommandType: THTTPCommandType;
    //
    procedure DecodeAndSetParams(const AValue: String); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Session: TIdHTTPSession read FSession;
    //
    property AuthExists: Boolean read FAuthExists;
    property AuthPassword: string read FAuthPassword;
    property AuthUsername: string read FAuthUsername;
    property Command: string read FCommand;
    property CommandType: THTTPCommandType read FCommandType;
    property Cookies: TIdServerCookies read FCookies;
    property Document: string read FDocument write FDocument; // writable for isapi compatibility. Use with care
    property Params: TStrings read FParams;
    property PostStream: TStream read FPostStream write FPostStream;
    property RawHTTPCommand: string read FRawHTTPCommand;
    property RemoteIP: String read FRemoteIP;
    property UnparsedParams: string read FUnparsedParams write FUnparsedParams; // writable for isapi compatibility. Use with care
    property FormParams: string read FFormParams write FFormParams; // writable for isapi compatibility. Use with care
    property QueryParams: string read FQueryParams write FQueryParams; // writable for isapi compatibility. Use with care
    property Version: string read FVersion;
  end;

  TIdHTTPResponseInfo = class(TIdResponseHeaderInfo)
  protected
    FAuthRealm: string;
    FConnection: TIdTCPConnection;
    FResponseNo: Integer;
    FCookies: TIdServerCookies;
    FContentStream: TStream;
    FContentText: string;
    FCloseConnection: Boolean;
    FFreeContentStream: Boolean;
    FHeaderHasBeenWritten: Boolean;
    FResponseText: string;
    FHTTPServer: TIdCustomHTTPServer;
    FSession: TIdHTTPSession;
    //
    procedure ReleaseContentStream;
    procedure SetCookies(const AValue: TIdServerCookies);
    procedure SetHeaders; override;
    procedure SetResponseNo(const AValue: Integer);
    procedure SetCloseConnection(const Value: Boolean);
  public
    function GetServer: string;
    procedure SetServer(const Value: string);
  public
    procedure CloseSession;
    constructor Create(AConnection: TIdTCPConnection; AServer: TIdCustomHTTPServer ); reintroduce;
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
    property Cookies: TIdServerCookies read FCookies write SetCookies;
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
    FOwner: TIdHTTPCustomSessionList;
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

  TIdHTTPCustomSessionList = class(TIdBaseComponent)
  private
    FSessionTimeout: Integer;
    FOnSessionEnd: TOnSessionEndEvent;
    FOnSessionStart: TOnSessionStartEvent;
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
    property OnSessionEnd: TOnSessionEndEvent read FOnSessionEnd write FOnSessionEnd;
    property OnSessionStart: TOnSessionStartEvent read FOnSessionStart write FOnSessionStart;
  end;

  TIdCustomHTTPServer = class(TIdCustomTCPServer)
  protected
    FAutoStartSession: Boolean;
    FKeepAlive: Boolean;
    FParseParams: Boolean;
    FServerSoftware: string;
    FMIMETable: TIdMimeTable;
    FSessionList: TIdHTTPCustomSessionList;
    FSessionState: Boolean;
    FSessionTimeOut: Integer;
    //
    FOnCreatePostStream: TOnCreatePostStream;
    FOnCreateSession: TOnCreateSession;
    FOnInvalidSession: TIdHTTPInvalidSessionEvent;
    FOnSessionEnd: TOnSessionEndEvent;
    FOnSessionStart: TOnSessionStartEvent;
    FOnCommandGet: TIdHTTPCommandEvent;
    FOnCommandOther: TIdHTTPCommandEvent;
    FOnHeadersAvailable: TIdHTTPHeadersAvailableEvent;
    FOnHeadersBlocked: TIdHTTPHeadersBlockedEvent;
    FOnHeaderExpectations: TIdHTTPHeaderExpectationsEvent;
    //
    FSessionCleanupThread: TIdThread;
    FMaximumHeaderLineCount: Integer;
    //
    procedure CreatePostStream(ASender: TIdContext; AHeaders: TIdHeaderList; var VPostStream: TStream); virtual;
    procedure DoOnCreateSession(AContext:TIdContext; var VNewSession: TIdHTTPSession); virtual;
    procedure DoInvalidSession(AContext:TIdContext;
     ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
     var VContinueProcessing: Boolean; const AInvalidSessionID: String); virtual;
    procedure DoCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo); virtual;
    procedure DoCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo); virtual;
    procedure DoConnect(AContext: TIdContext); override;
    function DoHeadersAvailable(ASender: TIdContext; AHeaders: TIdHeaderList): Boolean; virtual;
    procedure DoHeadersBlocked(ASender: TIdContext; AHeaders: TIdHeaderList; var VResponseNo: Integer; var VResponseText, VContentText: String); virtual;
    function DoHeaderExpectations(ASender: TIdContext; const AExpectations: String): Boolean; virtual;
    //
    function DoExecute(AContext:TIdContext): Boolean; override;
    //
    procedure SetActive(AValue: Boolean); override;
    procedure SetSessionState(const Value: Boolean);
    function GetSessionFromCookie(AContext:TIdContext;
     AHTTPrequest: TIdHTTPRequestInfo; AHTTPResponse: TIdHTTPResponseInfo;
     var VContinueProcessing: Boolean): TIdHTTPSession;
    procedure InitComponent; override;
    { to be published in TIdHTTPServer}
    property OnCreatePostStream: TOnCreatePostStream read FOnCreatePostStream write FOnCreatePostStream;
    property OnCommandGet: TIdHTTPCommandEvent read FOnCommandGet write FOnCommandGet;
  public
    function CreateSession(AContext:TIdContext;
     HTTPResponse: TIdHTTPResponseInfo;
     HTTPRequest: TIdHTTPRequestInfo): TIdHTTPSession;
    destructor Destroy; override;
    function EndSession(const SessionName: string): boolean;
    //
    property MIMETable: TIdMimeTable read FMIMETable;
    property SessionList: TIdHTTPCustomSessionList read FSessionList;
  published
    property MaximumHeaderLineCount: Integer read FMaximumHeaderLineCount write FMaximumHeaderLineCount default Id_TId_HTTPMaximumHeaderLineCount;
    property AutoStartSession: boolean read FAutoStartSession write FAutoStartSession default Id_TId_HTTPAutoStartSession;
    property DefaultPort default IdPORT_HTTP;
    property OnInvalidSession: TIdHTTPInvalidSessionEvent read FOnInvalidSession write FOnInvalidSession;
    property OnSessionStart: TOnSessionStartEvent read FOnSessionStart write FOnSessionStart;
    property OnSessionEnd: TOnSessionEndEvent read FOnSessionEnd write FOnSessionEnd;
    property OnCreateSession: TOnCreateSession read FOnCreateSession write FOnCreateSession;
    property OnHeadersAvailable: TIdHTTPHeadersAvailableEvent read FOnHeadersAvailable write FOnHeadersAvailable;
    property OnHeadersBlocked: TIdHTTPHeadersBlockedEvent read FOnHeadersBlocked write FOnHeadersBlocked;
    property OnHeaderExpectations: TIdHTTPHeaderExpectationsEvent read FOnHeaderExpectations write FOnHeaderExpectations;
    property KeepAlive: Boolean read FKeepAlive write FKeepAlive
     default Id_TId_HTTPServer_KeepAlive;
    property ParseParams: boolean read FParseParams write FParseParams
     default Id_TId_HTTPServer_ParseParams;
    property ServerSoftware: string read FServerSoftware write FServerSoftware;
    property SessionState: Boolean read FSessionState write SetSessionState
     default Id_TId_HTTPServer_SessionState;
    property SessionTimeOut: Integer read FSessionTimeOut write FSessionTimeOut
     default Id_TId_HTTPSessionTimeOut;
    property OnCommandOther: TIdHTTPCommandEvent read FOnCommandOther
     write FOnCommandOther;
  end;

  TIdHTTPDefaultSessionList = Class(TIdHTTPCustomSessionList)
  protected
    FSessionList: TThreadList;
    procedure RemoveSession(Session: TIdHTTPSession); override;
    // remove a session surgically when list already locked down (prevent deadlock)
    procedure RemoveSessionFromLockedList(AIndex: Integer; ALockedSessionList: TList);
  protected
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    property SessionList: TThreadList read FSessionList;
    procedure Clear; override;
    procedure Add(ASession: TIdHTTPSession); override;
    procedure PurgeStaleSessions(PurgeAll: Boolean = false); override;
    function CreateUniqueSession(const RemoteIP: String): TIdHTTPSession; override;
    function CreateSession(const RemoteIP, SessionID: String): TIdHTTPSession; override;
    function GetSession(const SessionID, RemoteIP: string): TIdHTTPSession; override;
  end;

implementation

uses
  {$IFDEF DOTNET}
    {$IFDEF USEINLINE}
  System.IO,
  System.Threading,
    {$ENDIF}
  {$ENDIF}
  IdCoderMIME, IdResourceStringsProtocols, IdURI, IdIOHandlerSocket, IdSSL, SysUtils;

const
  SessionCapacity = 128;

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


function GetRandomString(NumChar: cardinal): string;
const
  CharMap='qwertzuiopasdfghjklyxcvbnmQWERTZUIOPASDFGHJKLYXCVBNM1234567890';    {Do not Localize}
var
  i: integer;
  MaxChar: cardinal;
begin
  randomize;
  MaxChar := length(CharMap) - 1;
  for i := 1 to NumChar do
  begin
    // Add one because CharMap is 1-based
    Result := result + CharMap[Random(maxChar) + 1];
  end;
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
    FSessionList: TIdHTTPCustomSessionList;
  public
    constructor Create(SessionList: TIdHTTPCustomSessionList); reintroduce;
    procedure AfterRun; override;
    procedure Run; override;
  end; // class

{ TIdCustomHTTPServer }

procedure TIdCustomHTTPServer.InitComponent;
begin
  inherited InitComponent;
  FSessionState := Id_TId_HTTPServer_SessionState;
  DefaultPort := IdPORT_HTTP;
  ParseParams := Id_TId_HTTPServer_ParseParams;
  FSessionList := TIdHTTPDefaultSessionList.Create(Self);
  FMIMETable := TIdMimeTable.Create(False);
  FSessionTimeOut := Id_TId_HTTPSessionTimeOut;
  FAutoStartSession := Id_TId_HTTPAutoStartSession;
  FKeepAlive := Id_TId_HTTPServer_KeepAlive;
  FMaximumHeaderLineCount := Id_TId_HTTPMaximumHeaderLineCount;
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
begin
  if SessionState then begin
    DoOnCreateSession(AContext, Result);
    if not Assigned(result) then
    begin
      result := FSessionList.CreateUniqueSession(HTTPRequest.RemoteIP);
    end
    else begin
      FSessionList.Add(result);
    end;

    with HTTPResponse.Cookies.Add do
    begin
      CookieName := GSessionIDCookie;
      Value := result.SessionID;
      Path := '/';    {Do not Localize}
      MaxAge := -1; // By default the cookies wil be valid until the user has closed his browser window.
      // MaxAge := SessionTimeOut div 1000;
    end;
    HTTPResponse.FSession := result;
    HTTPRequest.FSession := result;
  end else begin
    result := nil;
  end;
end;

destructor TIdCustomHTTPServer.Destroy;
begin
  Active := False; // Set Active to false in order to close all active sessions.
  FreeAndNil(FMIMETable);
  FreeAndNil(FSessionList);
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

procedure TIdCustomHTTPServer.DoConnect(AContext: TIdContext);
begin
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough:=false;
  end;
  inherited DoConnect(AContext);
end;

function TIdCustomHTTPServer.DoHeadersAvailable(ASender: TIdContext; AHeaders: TIdHeaderList): Boolean;
begin
  Result := True;
  if Assigned(OnHeadersAvailable) then begin
    OnHeadersAvailable(ASender, AHeaders, Result);
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
    i: Integer;
    S: String;
  begin
    LRawCookies := TStringList.Create; try
      LRequestInfo.RawHeaders.Extract('cookie', LRawCookies);    {Do not Localize}
      for i := 0 to LRawCookies.Count -1 do begin
        S := LRawCookies[i];
        while IndyPos(';', S) > 0 do begin    {Do not Localize}
          LRequestInfo.Cookies.AddSrcCookie(Fetch(S, ';'));    {Do not Localize}
          S := Trim(S);
        end;
        if S <> '' then
          LRequestInfo.Cookies.AddSrcCookie(S);
      end;
    finally FreeAndNil(LRawCookies); end;
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
    LMajor, LMinor: Integer;
  begin
    // let the user decide if the request headers are acceptable
    Result := DoHeadersAvailable(AContext, LRequestInfo.RawHeaders);
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

    // if the client has already sent some or all of the request
    // body then don't bother checking for a v1.1 'Expect' header
    if not AContext.Connection.IOHandler.InputBufferIsEmpty then begin
      Exit;
    end;
    
    // the request body has not been read yet, get the HTTP version
    // and check for a v1.1 'Expect' header...
    S := LRequestInfo.Version;
    Fetch(S, '/');  {Do not localize}
    LMajor := IndyStrToInt(Fetch(S, '.'), -1);  {Do not Localize}
    LMinor := IndyStrToInt(S, -1);

    if (LMajor < 1) or ((LMajor = 1) and (LMinor < 1)) then begin
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
      LResponseInfo.ResponseText := '';
      LResponseInfo.ContentText := '';
      LResponseInfo.CloseConnection := True;
      LResponseInfo.WriteHeader;
      Exit;
    end;

    if Pos('100-continue', LowerCase(S)) > 0 then begin  {Do not Localize}
      // the client requested a '100-continue' expectation so send
      // a '100 Continue' reply now before the request body can be read
      with AContext.Connection.IOHandler do begin
        WriteBufferOpen; try
          WriteLn(LRequestInfo.Version + ' 100 ' + RSHTTPContinue);    {Do not Localize}
          WriteLn;
        finally
          WriteBufferClose;
        end;
      end;
    end;
  end;

var
  i: integer;
  s, LInputLine, LCmd: String;
  LURI: TIdURI;
  LRawHTTPCommand: string;
  LContinueProcessing: Boolean;
  LCloseConnection: Boolean;
begin
  LContinueProcessing := True;
  Result := False;
  LCloseConnection := not KeepAlive;
  try
    try
      repeat
        with AContext.Connection do begin
          LInputLine := IOHandler.ReadLn;
          Assert(not IOHandler.ReadLnTimedOut);
          i := RPos(' ', LInputLine, -1);    {Do not Localize}
          if i = 0 then begin
            raise EIdHTTPErrorParsingCommand.Create(RSHTTPErrorParsingCommand);
          end;
          LRequestInfo := TIdHTTPRequestInfo.Create;
          try
            LResponseInfo := TIdHTTPResponseInfo.Create(AContext.Connection, Self);
            try
              LResponseInfo.CloseConnection := not (FKeepAlive and
                TextIsSame(LRequestInfo.Connection, 'Keep-alive')); {Do not Localize}

              // SG 05.07.99
              // Set the ServerSoftware string to what it's supposed to be.    {Do not Localize}
              LResponseInfo.ServerSoftware := Trim(ServerSoftware);

              // S.G. 6/4/2004: Set the maximum number of lines that will be catured
              // S.G. 6/4/2004: to prevent a remote resource starvation DOS
              IOHandler.MaxCapturedLines := MaximumHeaderLineCount;

              // Retrieve the HTTP version
              LRawHTTPCommand := LInputLine;
              LRequestInfo.FVersion := Copy(LInputLine, i + 1, MaxInt);
              SetLength(LInputLine, i - 1);

              // Retrieve the HTTP header
              LRequestInfo.RawHeaders.Clear;
              IOHandler.Capture(LRequestInfo.RawHeaders, '');    {Do not Localize}
              LRequestInfo.ProcessHeaders;

              {TODO Check for 1.0 only at this point}
              LCmd := UpperCase(Fetch(LInputLine, ' '));    {Do not Localize}

              LRequestInfo.FRawHTTPCommand := LRawHTTPCommand;
              LRequestInfo.FRemoteIP := GetRemoteIP(Socket);
              LRequestInfo.FCommand := LCmd;
              LRequestInfo.FCommandType := DecodeHTTPCommand(LCmd);

              // RLebeau 12/14/2005: provide the user with the headers and let the
              // user decide whether the response processing should continue...
              if not HeadersCanContinue then begin
                Break;
              end;

              // Grab Params so we can parse them
              // POSTed data - may exist with GETs also. With GETs, the action
              // params from the form element will be posted
              // TODO: Rune this is the area that needs fixed. Ive hacked it for now
              // Get data can exists with POSTs, but can POST data exist with GETs?
              // If only the first, the solution is easy. If both - need more
              // investigation.

              // i := StrToIntDef(LRequestInfo.Headers.Values['Content-Length'], -1);    {Do not Localize}
              LRequestInfo.PostStream := nil;
              CreatePostStream(AContext, LRequestInfo.RawHeaders, LRequestInfo.FPostStream);
              if LRequestInfo.FPostStream = nil then begin
                LRequestInfo.FPostStream := TMemoryStream.Create;    {Do not Localize}
              end;

              LRequestInfo.PostStream.Position := 0;
              if LRequestInfo.ContentLength > 0 then begin
                IOHandler.ReadStream(LRequestInfo.PostStream, LRequestInfo.ContentLength);
              end else if LRequestInfo.CommandType = hcPOST then begin
                if not LRequestInfo.HasContentLength then begin
                  IOHandler.ReadStream(LRequestInfo.PostStream, -1, True);
                end;
              end;

              // reset back to 0 before reading the string from the post stream
              LRequestInfo.PostStream.Position := 0;
              LRequestInfo.FormParams := ReadStringFromStream(LRequestInfo.PostStream);

              // reset back to 0 for the OnCommand... event handler
              LRequestInfo.PostStream.Position := 0;
              LRequestInfo.UnparsedParams := LRequestInfo.FormParams;

              // GET data - may exist with POSTs also
              LRequestInfo.QueryParams := LInputLine;
              LInputLine := Fetch(LRequestInfo.FQueryParams, '?');    {Do not Localize}
              // glue together parameters passed in the URL and those
              //
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
                if TextIsSame(LRequestInfo.ContentType, 'application/x-www-form-urlencoded') then begin    {Do not Localize}
                  LRequestInfo.DecodeAndSetParams(LRequestInfo.UnparsedParams);
                end else begin
                  // Parse only query params when content type is not 'application/x-www-form-urlencoded'    {Do not Localize}
                  LRequestInfo.DecodeAndSetParams(LRequestInfo.QueryParams);
                end;
              end;

              // Cookies
              ReadCookiesFromRequestHeader;

              // Host
              // LRequestInfo.FHost := LRequestInfo.Headers.Values['host'];    {Do not Localize}

              // Parse the document input line
              if LInputLine = '*' then begin    {Do not Localize}
                LRequestInfo.FDocument := '*';    {Do not Localize}
              end else begin
                LURI := TIdURI.Create(LInputLine);
                try
                  // SG 29/11/01: Per request of Doychin
                  // Try to fill the "host" parameter
                  LRequestInfo.FDocument := TIdURI.URLDecode(LURI.Path) + TIdURI.URLDecode(LURI.Document) + LURI.Params;
                  if (Length(LURI.Host) > 0) and (Length(LRequestInfo.FHost) = 0) then begin
                    LRequestInfo.FHost := LURI.Host;
                  end;
                finally
                  FreeAndNil(LURI);
                end;
              end;

              s := LRequestInfo.RawHeaders.Values['Authorization'];    {Do not Localize}
              LRequestInfo.FAuthExists := (Length(s) > 0);
              if LRequestInfo.AuthExists then begin
                if TextIsSame(Fetch(s, ' '), 'Basic') then begin    {Do not Localize}
                  with TIdDecoderMIME.Create do try
                    s := DecodeString(s);
                  finally Free; end;
                  LRequestInfo.FAuthUsername := Fetch(s, ':');    {Do not Localize}
                  LRequestInfo.FAuthPassword := s;
                end else begin
                  raise EIdHTTPUnsupportedAuthorisationScheme.Create(
                   RSHTTPUnsupportedAuthorisationScheme);
                end;
              end;

              // Session management
              GetSessionFromCookie(AContext, LRequestInfo, LResponseInfo, LContinueProcessing);
              if LContinueProcessing then begin
                try
                  // These essentially all "retrieve" so they are all "Get"s
                  if LRequestInfo.CommandType in [hcGET, hcPOST, hcHEAD] then begin
                    DoCommandGet(AContext, LRequestInfo, LResponseInfo);
                  end else begin
                    DoCommandOther(AContext, LRequestInfo, LResponseInfo);
                  end;
                except
                  on E: EIdSocketError do begin // don't stop socket exceptions
                    raise;
                  end;
                  on E: Exception do begin
                    LResponseInfo.ResponseNo := 500;
                    LResponseInfo.ContentText := E.Message;
                  end;
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
              LCloseConnection := LResponseInfo.CloseConnection;
              FreeAndNil(LResponseInfo);
            end;
          finally
            FreeAndNil(LRequestInfo);
          end;
        end;
      until LCloseConnection;
    except
      on E: EIdSocketError do begin
        if E.LastError <> Id_WSAECONNRESET then begin
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

function TIdCustomHTTPServer.EndSession(const SessionName: string): boolean;
var
  ASession: TIdHTTPSession;
begin
  ASession := SessionList.GetSession(SessionName, '');    {Do not Localize}
  Result := Assigned(ASession);
  if Result then begin
    FreeAndNil(ASession);
  end;
end;

function TIdCustomHTTPServer.GetSessionFromCookie(AContext: TIdContext;
  AHTTPRequest: TIdHTTPRequestInfo; AHTTPResponse: TIdHTTPResponseInfo;
  var VContinueProcessing: Boolean): TIdHTTPSession;
var
  LIndex: Integer;
  LSessionId: String;
begin
  Result := nil;
  VContinueProcessing := True;
  if SessionState then
  begin
    LIndex := AHTTPRequest.Cookies.GetCookieIndex(0, GSessionIDCookie);
    while (Result = nil) and (LIndex >= 0) and VContinueProcessing do
    begin
      LSessionId := AHTTPRequest.Cookies.Items[LIndex].Value;
      Result := FSessionList.GetSession(LSessionID, AHTTPrequest.RemoteIP);
      if not Assigned(Result) then begin
        DoInvalidSession(AContext, AHTTPRequest, AHTTPResponse, VContinueProcessing, LSessionId);
      end;
      Inc(LIndex);
      LIndex := AHTTPRequest.Cookies.GetCookieIndex(LIndex, GSessionIDCookie);
    end;    { while }
    // check if a session was returned. If not and if AutoStartSession is set to
    // true, Create a new session
    if FAutoStartSession and VContinueProcessing and (Result = nil) then begin
      Result := CreateSession(AContext, AHTTPResponse, AHTTPrequest);
    end;
  end;
  AHTTPRequest.FSession := Result;
  AHTTPResponse.FSession := Result;
end;

procedure TIdCustomHTTPServer.SetActive(AValue: Boolean);
begin
  if (not IsDesignTime) and (FActive <> AValue)
      and (not IsLoading) then begin
    if AValue then
    begin
      // starting server
      // set the session timeout and options
      if FSessionTimeOut <> 0 then
        FSessionList.FSessionTimeout := FSessionTimeOut
      else
        FSessionState := false;
      // Session events
      FSessionList.OnSessionStart := FOnSessionStart;
      FSessionList.OnSessionEnd := FOnSessionEnd;
      // If session handeling is enabled, create the housekeeper thread
      if SessionState then
        FSessionCleanupThread := TIdHTTPSessionCleanerThread.Create(FSessionList);
    end
    else
    begin
      // Stopping server
      // Boost the clear thread priority to give it a good chance to terminate
      if assigned(FSessionCleanupThread) then begin
        SetThreadPriority(FSessionCleanupThread, tpNormal);
        FSessionCleanupThread.TerminateAndWaitFor;
        FreeAndNil(FSessionCleanupThread);
      end;
      FSessionCleanupThread := nil;
      FSessionList.Clear;
    end;
  end;
  inherited SetActive(AValue);
end;

procedure TIdCustomHTTPServer.SetSessionState(const Value: Boolean);
begin
  // ToDo: Add thread multiwrite protection here
  if (not (IsDesignTime or IsLoading)) and Active then
    raise EIdHTTPCannotSwitchSessionStateWhenActive.Create(RSHTTPCannotSwitchSessionStateWhenActive);
  FSessionState := Value;
end;

procedure TIdCustomHTTPServer.CreatePostStream(ASender: TIdContext;
  AHeaders: TIdHeaderList; var VPostStream: TStream);
begin
  if Assigned(OnCreatePostStream) then begin
    OnCreatePostStream(ASender, AHeaders, VPostStream);
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

{TIdSession}
constructor TIdHTTPSession.CreateInitialized(AOwner: TIdHTTPCustomSessionList; const SessionID, RemoteIP: string);
begin
  inherited Create;

  FSessionID := SessionID;
  FRemoteHost := RemoteIP;
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
    FOwner.RemoveSession(self);
  end;
  inherited Destroy;
end;

procedure TIdHTTPSession.DoSessionEnd;
begin
  if assigned(FOwner) and assigned(FOwner.FOnSessionEnd) then
    FOwner.FOnSessionEnd(self);
end;

function TIdHTTPSession.IsSessionStale: boolean;
begin
  result := TimeStampInterval(FLastTimeStamp, Now) > Integer(FOwner.SessionTimeout);
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

constructor TIdHTTPRequestInfo.Create;
begin
  inherited Create;
  FCommandType := hcUnknown;
  FCookies := TIdServerCookies.Create(self);
  FParams  := TStringList.Create;
  ContentLength := -1;
end;

procedure TIdHTTPRequestInfo.DecodeAndSetParams(const AValue: String);
var
  i, j : Integer;
  s: string;
begin
  // Convert special characters
  // ampersand '&' separates values    {Do not Localize}
  Params.BeginUpdate;
  try
    Params.Clear;
    i := 1;
    while i <= length(AValue) do
    begin
      j := i;
      while (j <= length(AValue)) and (AValue[j] <> '&') do
      begin
        inc(j);
      end;
      s := copy(AValue, i, j-i);
      // See RFC 1866 section 8.2.1. TP
      s := StringReplace(s, '+', ' ', [rfReplaceAll]);  {do not localize}
      Params.Add(TIdURI.URLDecode(s));
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

{ TIdHTTPResponseInfo }

procedure TIdHTTPResponseInfo.CloseSession;
var
  i: Integer;
begin
  i := Cookies.GetCookieIndex(0, GSessionIDCookie);
  if i > -1 then begin
    Cookies.Delete(i);
  end;
  Cookies.Add.CookieName := GSessionIDCookie;
  FreeAndNil(FSession);
end;

constructor TIdHTTPResponseInfo.Create(AConnection: TIdTCPConnection; AServer: TIdCustomHTTPServer);
begin
  inherited Create;

  FFreeContentStream := True;
  ContentLength := GFContentLength;
  {Some clients may not support folded lines}
  RawHeaders.FoldLines := False;
  FCookies := TIdServerCookies.Create(self);
  {TODO Specify version - add a class method dummy that calls version}
  ServerSoftware := GServerSoftware;
  ContentType := ''; //GContentType;

  FConnection := AConnection;
  FHttpServer := AServer;
  ResponseNo := GResponseNo;
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
    FreeAndNil(FContentStream);
  end else begin
    FContentStream := nil;
  end;
end;

procedure TIdHTTPResponseInfo.SetCloseConnection(const Value: Boolean);
begin
  Connection := iif(Value, 'close', 'keep-alive');    {Do not Localize}
  FCloseConnection := Value;
end;

procedure TIdHTTPResponseInfo.SetCookies(const AValue: TIdServerCookies);
begin
  FCookies.Assign(AValue);
end;

procedure TIdHTTPResponseInfo.SetHeaders;
begin
  inherited SetHeaders;
  with RawHeaders do
  begin
    if Server <> '' then begin
      Values['Server'] := Server;    {Do not Localize}
    end;
    if Location <> '' then begin
      Values['Location'] := Location;    {Do not Localize}
    end;
    if FLastModified > 0 then begin
      Values['Last-Modified'] := DateTimeGMTToHttpStr(FLastModified); {do not localize}
    end;
    if AuthRealm <> '' then {Do not Localize}
    begin
      ResponseNo := 401;
      Values['WWW-Authenticate'] := 'Basic realm="' + AuthRealm + '"';    {Do not Localize}
      Values['Content-Type'] := 'text/html';    {Do not Localize}
      FContentText := '<HTML><BODY><B>' + IntToStr(ResponseNo) + ' ' + RSHTTPUnauthorized + '</B></BODY></HTML>';    {Do not Localize}
    end;
  end;
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
    413: ResponseText := RSHTTPRequestEntityToLong;
    414: ResponseText := RSHTTPRequestURITooLong;
    415: ResponseText := RSHTTPUnsupportedMediaType;
    417: ResponseText := RSHTTPExpectationFailed;
    // 5XX Server errors
    500: ResponseText := RSHTTPInternalServerError;
    501: ResponseText := RSHTTPNotImplemented;
    502: ResponseText := RSHTTPBadGateway;
    503: ResponseText := RSHTTPServiceUnavailable;
    504: ResponseText := RSHTTPGatewayTimeout;
    505: ResponseText := RSHTTPHTTPVersionNotSupported;
    else
      ResponseText := RSHTTPUnknownResponseCode;
  end;

  {if ResponseNo >= 400 then
    // Force COnnection closing when there is error during the request processing
    CloseConnection := true;
  end;}
end;

function TIdHTTPResponseInfo.ServeFile(AContext: TIdContext; const AFile: String): Int64;
begin
  if Length(ContentType) = 0 then begin
    ContentType := HTTPServer.MIMETable.GetFileMIMEType(AFile);
  end;
  ContentLength := FileSizeByName(AFile);
  if Length(ContentDisposition) = 0 then begin
    ContentDisposition := IndyFormat('attachment: filename="%s";', [ExtractFileName(AFile)]);
  end;
  WriteHeader;
  //TODO: allow TransferFileEnabled function
  Result := AContext.Connection.IOHandler.WriteFile(AFile);
end;

function TIdHTTPResponseInfo.SmartServeFile(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  const AFile: String): Int64;
var
  LFileDate : TDateTime;
  LReqDate : TDateTime;
begin
  LFileDate := IndyFileAge(AFile);
  LReqDate := GMTToLocalDateTime(ARequestInfo.RawHeaders.Values['If-Modified-Since']);  {do not localize}

  // if the file date in the If-Modified-Since header is within 2 seconds of the
  // actual file, then we will send a 304. We don't use the ETag - offers nothing
  // over the file date for static files on windows. Linux: consider using iNode
  if (LReqDate <> 0) and (abs(LReqDate - LFileDate) < 2 * (1 / (24 * 60 * 60))) then
  begin
    ResponseNo := 304;
    Result := 0;
  end else
  begin
    Date := LFileDate;
    Result := ServeFile(AContext, AFile);
  end;
end;

procedure TIdHTTPResponseInfo.WriteContent;
begin
  if not HeaderHasBeenWritten then begin
    WriteHeader;
  end;
  with FConnection do begin
    // Always check ContentText first
    if ContentText <> '' then begin
      IOHandler.Write(ContentText);
    end else if Assigned(ContentStream) then begin
      ContentStream.Position := 0;
      IOHandler.Write(ContentStream);
    end else begin
      FConnection.IOHandler.WriteLn('<HTML><BODY><B>' + IntToStr(ResponseNo) + ' ' + ResponseText    {Do not Localize}
       + '</B></BODY></HTML>');    {Do not Localize}
    end;
    // Clear All - This signifies that WriteConent has been called.
    ContentText := '';    {Do not Localize}
    ReleaseContentStream;
  end;
end;

procedure TIdHTTPResponseInfo.WriteHeader;
var
  i: Integer;
begin
  EIdHTTPHeaderAlreadyWritten.IfTrue(HeaderHasBeenWritten, RSHTTPHeaderAlreadyWritten);
  FHeaderHasBeenWritten := True;

  if ContentLength = -1 then begin
    // Always check ContentText first
    if ContentText <> '' then begin
      ContentLength := Length(ContentText);
    end else if Assigned(ContentStream) then begin
      ContentLength := ContentStream.Size;
    end;
  end;
  SetHeaders;
  FConnection.IOHandler.WriteBufferOpen; try
    // Write HTTP status response
    // Client will be forced to close the connection. We are not going to support
    // keep-alive feature for now
    FConnection.IOHandler.WriteLn('HTTP/1.1 ' + IntToStr(ResponseNo) + ' ' + ResponseText);    {Do not Localize}
    // Write headers
    for i := 0 to RawHeaders.Count -1 do begin
      FConnection.IOHandler.WriteLn(RawHeaders[i]);
    end;
    // Write cookies
    for i := 0 to Cookies.Count - 1 do begin
      FConnection.IOHandler.WriteLn('Set-Cookie: ' + Cookies[i].ServerCookie);    {Do not Localize}
    end;
    // HTTP headers ends with a double CR+LF
    FConnection.IOHandler.WriteLn;
  finally FConnection.IOHandler.WriteBufferClose; end;
end;

function TIdHTTPResponseInfo.GetServer: string;
begin
  result := Server;
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
  ASessionList: TList;
  i: Integer;
begin
  ASessionList := SessionList.LockList;
  try
    for i := ASessionList.Count - 1 DownTo 0 do
      if ASessionList[i] <> nil then
      begin
        TIdHTTPSession(ASessionList[i]).DoSessionEnd;
        TIdHTTPSession(ASessionList[i]).FOwner := nil;
        TIdHTTPSession(ASessionList[i]).Free;
      end;
    ASessionList.Clear;
    ASessionList.Capacity := SessionCapacity;
  finally
    SessionList.UnlockList;
  end;
end;

function TIdHTTPDefaultSessionList.CreateSession(const RemoteIP, SessionID: String): TIdHTTPSession;
begin
  result := TIdHTTPSession.CreateInitialized(Self, SessionID, RemoteIP);
  SessionList.Add(result);
end;

function TIdHTTPDefaultSessionList.CreateUniqueSession(
  const RemoteIP: String): TIdHTTPSession;
var
  SessionID: String;
begin
  SessionID := GetRandomString(15);
  while GetSession(SessionID, RemoteIP) <> nil do
  begin
    SessionID := GetRandomString(15);
  end;    // while
  result := CreateSession(RemoteIP, SessionID);
end;

destructor TIdHTTPDefaultSessionList.destroy;
begin
  Clear;
  FreeAndNil(FSessionList);
  inherited destroy;
end;

function TIdHTTPDefaultSessionList.GetSession(const SessionID, RemoteIP: string): TIdHTTPSession;
var
  ASessionList: TList;
  i: Integer;
  ASession: TIdHTTPSession;
begin
  Result := nil;
  ASessionList := SessionList.LockList;
  try
    // get current time stamp
    for i := 0 to ASessionList.Count - 1 do
    begin
      ASession := TIdHTTPSession(ASessionList[i]);
      Assert(ASession <> nil);
      // the stale sessions check has been removed... the cleanup thread should suffice plenty
      if TextIsSame(ASession.FSessionID, SessionID) and ((length(RemoteIP) = 0) or TextIsSame(ASession.RemoteHost, RemoteIP)) then
      begin
        // Session found
        ASession.FLastTimeStamp := Now;
        result := ASession;
        break;
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.InitComponent;
begin
  inherited InitComponent;

  FSessionList := TThreadList.Create;
  FSessionList.LockList.Capacity := SessionCapacity;
  FSessionList.UnlockList;
end;

procedure TIdHTTPDefaultSessionList.PurgeStaleSessions(PurgeAll: Boolean = false);
var
  i: Integer;
  aSessionList: TList;
begin
  // S.G. 24/11/00: Added a way to force a session purge (Used when thread is terminated)
  // Get necessary data
  Assert(SessionList<>nil);

  aSessionList := SessionList.LockList;
  try
    // Loop though the sessions.
    for i := aSessionList.Count - 1 downto 0 do
    begin
      // Identify the stale sessions
      if Assigned(ASessionList[i]) and
         (PurgeAll or TIdHTTPSession(aSessionList[i]).IsSessionStale) then
      begin
        RemoveSessionFromLockedList(i, aSessionList);
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.RemoveSession(Session: TIdHTTPSession);
var
  ASessionList: TList;
  Index: integer;
begin
  ASessionList := SessionList.LockList;
  try
    Index := ASessionList.IndexOf(TObject(Session));
    if index > -1 then
    begin
      ASessionList.Delete(index);
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TIdHTTPDefaultSessionList.RemoveSessionFromLockedList(AIndex: Integer;
  ALockedSessionList: TList);
begin
  TIdHTTPSession(ALockedSessionList[AIndex]).DoSessionEnd;
  // must set the owner to nil or the session will try to remove itself from the
  // session list and deadlock
  TIdHTTPSession(ALockedSessionList[AIndex]).FOwner := nil;
  TIdHTTPSession(ALockedSessionList[AIndex]).Free;
  ALockedSessionList.Delete(AIndex);
end;

{ TIdHTTPSessionClearThread }

procedure TIdHTTPSessionCleanerThread.AfterRun;
begin
  if Assigned(FSessionList) then
    FSessionList.PurgeStaleSessions(true);
  inherited AfterRun;
end;

constructor TIdHTTPSessionCleanerThread.Create(SessionList: TIdHTTPCustomSessionList);
begin
  inherited Create(false);
  // thread priority used to be set to tpIdle but this is not supported
  // under DotNet. How low do you want to go?
  SetThreadPriority(Self, tpLowest);
  FSessionList := SessionList;
  FreeOnTerminate := False;
end;

procedure TIdHTTPSessionCleanerThread.Run;
begin
  Sleep(1000);
  if Assigned(FSessionList) then begin
    FSessionList.PurgeStaleSessions(Terminated);
  end;
end;

end.
