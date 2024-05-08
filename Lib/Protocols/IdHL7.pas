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
  Rev 2.2 30/12/2022 5:40 PM RLebeau
    Code Review:
    Proper handling of TIdQueuedMessage as an interfaced object (removing manual reference counting).
    Handling of incoming messages more efficiently (not reading byte by byte, not treating message delimiters as encoded strings).
    Updating String encoding to support non-Unicode compilers.
    General code cleanup

  Rev 2.1 25/12/2022 12:32 AM EJPretorius/ ShoraiTek
   Added DefStringEncoding for sending encoding control / default to utf8
   Use dateutils functions rather where possible
   remove TIdPeerThread  classes logic us TIdContext  rather directly
   use indy KeepAlive functions (timeouts to be set)
   use global.ticks rather
   non-type casting of socket - use direct property rather
   use IPv4ToUInt32 rather than custom function
   reverse Cardinal change back to longword
   readbyte ansichar cast changed to char cast for charsets

  Rev 2.0   23/12/2022 19:52 PM EJPretorius
  Combined Indy code with last source code release by original author (Grahame Grieve) in 2013
    http://www.healthintersections.com.au/?p=1596  

  Rev 1.9    9/30/2004 5:04:18 PM  BGooijen
  Self was not initialized

    Rev 1.8    6/11/2004 9:36:14 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.7    2004.02.07 5:03:02 PM  czhower
  .net fixes.

  Rev 1.6    2004.02.03 5:43:44 PM  czhower
  Name changes

  Rev 1.5    1/21/2004 2:42:46 PM  JPMugaas
  InitComponent

  Rev 1.4    1/3/2004 12:59:54 PM  JPMugaas
  These should now compile with Kudzu's change in IdCoreGlobal.

  Rev 1.3    4/12/2003 9:21:32 PM  GGrieve
  give up on Indy10 for the moment

  Rev 1.2    10/15/2003 9:53:42 PM  GGrieve
  DotNet changes

  Rev 1.1    23/6/2003 22:33:54  GGrieve
  update for indy10 IOHandler model

  Rev 1.0    11/13/2002 07:53:58 AM  JPMugaas

  05/09/2002   Grahame Grieve
  Fixed SingleThread Timeout Issues + WaitForConnection

  23/01/2002   Grahame Grieve
  Fixed for network changes to TIdTCPxxx wrote DUnit testing,
  increased assertions change OnMessageReceive,
  added VHandled parameter

  07/12/2001   Grahame Grieve      Various fixes for cmSingleThread mode

  05/11/2001   Grahame Grieve      Merge into Indy

  03/09/2001   Grahame Grieve      Prepare for Indy
}

{
  Indy HL7 Minimal Lower Layer Protocol TIdHL7

    Original author Grahame Grieve

    This code was donated by HL7Connect.com
    For more HL7 open source code see
    http://www.hl7connect.com/tools

  This unit implements support for the Standard HL7 minimal Lower Layer
  protocol. For further details, consult the HL7 standard (www.hl7.org).

  Before you can use this component, you must set the following properties:
    CommunicationMode
    Address (if you want to be a client)
    Port
    isListener
  and hook the appropriate events (see below)

  This component will operate as either a server or a client depending on
  the configuration
}

(*
  note: Events are structurally important for this component. However there is
  a bug in SyncObjs for Linux under Kylix 1 and 2 where TEvent.WaitFor cannot be
  used with timeouts. If you compile your own RTL, then you can fix the routine
  like this:

    function TEvent.WaitFor(Timeout: LongWord): TWaitResult;
    {$IFDEF LINUX}
    var ts : TTimeSpec;
    begin
      ts.tv_sec  := timeout div 1000;
      ts.tv_nsec := (timeout mod 1000) * 1000000;
      if sem_timedwait(FSem, ts) = 0 then
        result := wrSignaled
      else
        result := wrTimeOut;
    {$ENDIF}

  and then disable this define:

  this is a serious issue - unless you fix the RTL, this component does not
    function properly on Linux at the present time. This may be fixed in a
  future version
*)

{ TODO : use Server.MaxConnections }

unit IdHL7;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  Contnrs,
  IdBaseComponent,
  IdContext,
  IdException,
  IdGlobal,
  IdTCPClient,
  IdTCPConnection,
  IdTCPServer,
  SysUtils;

const
  MSG_START: array[0..0] of Byte = ($0B);
  MSG_END: array[0..1] of Byte = ($1C, $0D);
  BUFFER_SIZE_LIMIT = $FFFFFFF;  // buffer is allowed to grow to this size without any valid messages. Will be truncated with no notice (DoS protection) (268MB)

  WAIT_STOP = 5000; // how long we wait for things to shut down cleanly


type
  EHL7CommunicationError = class(EIdException)
  protected
    FInterfaceName: String;
  public
    constructor Create(AnInterfaceName, AMessage: String);
    property InterfaceName: String read FInterfaceName;
  end;


  THL7CommunicationMode = (cmUnknown,        // not valid - default setting must be changed by application
    cmAsynchronous,   // see comments below for meanings of the other parameters
    cmSynchronous,
    cmSingleThread);

  TSendResponse = (srNone,          // internal use only - never returned
    srError,         // internal use only - never returned
    srNoConnection,  // you tried to send but there was no connection
    srSent,          // you asked to send without waiting, and it has been done
    srOK,            // sent ok, and response returned
    srTimeout);      // we sent but there was no response (connection will be dropped internally

  TIdHL7Status = (isStopped,       // not doing anything
    isNotConnected,  // not Connected (Server state)
    isConnecting,    // Client is attempting to connect
    isWaitReconnect, // Client is in delay loop prior to attempting to connect
    isConnected,     // connected OK
    isUnusable,      // Not Usable - stop failed
    isTimedOut       // we are a client, and there was no traffic, so we closed the connection (and we are not listening)
    );

const
  { default property values }
  DEFAULT_ADDRESS = '';         {do not localize}
  DEFAULT_PORT = 0;
  DEFAULT_TIMEOUT = 30000;
  DEFAULT_RECEIVE_TIMEOUT = 30000;
  NULL_IP = '0.0.0.0';  {do not localize}
  DEFAULT_CONN_LIMIT = 1;
  DEFAULT_RECONNECT_DELAY = 15000;
  DEFAULT_CONNECTION_TIMEOUT = 0;
  DEFAULT_COMM_MODE = cmUnknown;
  DEFAULT_IS_LISTENER = True;
  SEND_RESPONSE_NAMES: array[TSendResponse] of String = ('None', 'Error', 'NoConnection', 'Sent', 'OK', 'Timeout'); {Do not Localize}

type
  // the connection is provided in these events so that applications can obtain information about the
  // the peer. It's never OK to write to these connections
  TMessageArriveEvent = procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String) of object;
  TMessageReceiveEvent = procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String; var VHandled: Boolean; var VReply: String) of object;
  TReceiveErrorEvent = procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String; AException: Exception; var VReply: String; var VDropConnection: Boolean) of object;

  TIdHL7 = class;
  TIdHL7ConnCountEvent = procedure(ASender: TIdHL7; AConnCount: integer) of object;

  { TIdHL7KeepAlive }

  TIdHL7KeepAlive = class(TPersistent)
  protected
    FUseKeepAlive: Boolean;
    FIdleTimeMS: Integer;
    FIntervalMS: Integer;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property UseKeepAlive: Boolean read FUseKeepAlive write FUseKeepAlive;
    property IdleTimeMS: Integer read FIdleTimeMS write FIdleTimeMS;
    property IntervalMS: Integer read FIntervalMS write FIntervalMS;
  end;

  TIdHL7ClientThread = class(TThread)
  protected
    FClient: TIdTCPClient;
    FCloseEvent: TIdLocalEvent;
    FOwner: TIdHL7;
    FLastTraffic: TIdTicks;
    procedure Execute; override;
    procedure PollStack;
    function TimedOut: Boolean;
  public
    constructor Create(AOwner: TIdHL7);
    destructor Destroy; override;
  end;

  TIdHL7 = class(TIdBaseComponent)
  protected
    FLock: TIdCriticalSection;
    FStatus: TIdHL7Status;
    FStatusDesc: String;

    // these queues hold messages when running in singlethread mode
    FMsgQueue: TInterfaceList;
    FHndMsgQueue: TInterfaceList;

    FAddress: String;
    FCommunicationMode: THL7CommunicationMode;
    FConnectionLimit: Word;
    FIPMask: String;
    FIPRestriction: String;
    FIPMaskVal: UInt32;
    FIPRestrictionVal: UInt32;
    FIsListener: Boolean;
    FObject: TObject;
    FPreStopped: Boolean;
    FPort: Word;
    FReconnectDelay: LongWord;
    FTimeOut: UInt32;
    FReceiveTimeout: LongWord;
    FServerConnections: TObjectList;

    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    FOnConnCountChange: TIdHL7ConnCountEvent;
    FOnMessageArrive: TMessageArriveEvent;
    FOnReceiveMessage: TMessageReceiveEvent;
    FOnReceiveError: TReceiveErrorEvent;

    FIsServer: Boolean;
    FServer: TIdTCPServer;
    // if we are a server, and the mode is not asynchronous, and we are not listening, then
    // we will track the current server connection with this, so we can initiate sending on it
    FServerConn: TIdTCPConnection;
    FIsServerExecuting: Boolean;

    // A thread exists to connect and receive incoming tcp traffic
    FClientThread: TIdHL7ClientThread;
    FClient: TIdTCPClient;

    // these fields are used for handling message response in synchronous mode
    FWaitingForAnswer: Boolean;
    FWaitStart: TIdTicks;
    FMsgReply: String;
    FReplyResponse: TSendResponse;
    FWaitEvent: TIdLocalEvent;

    FKeepAlive: TIdHL7KeepAlive;
    FConnectionTimeout: UInt32;

    FDefStringEncoding: IIdTextEncoding;
    {$IFDEF STRING_IS_ANSI}
    FDefAnsiEncoding: IIdTextEncoding;
    {$ENDIF}

    procedure SetAddress(const AValue: String);
    procedure SetKeepAlive(const AValue: TIdHL7KeepAlive);
    procedure SetConnectionLimit(const AValue: Word);
    procedure SetIPMask(const AValue: String);
    procedure SetIPRestriction(const AValue: String);
    procedure SetPort(const AValue: Word);
    procedure SetReconnectDelay(const AValue: LongWord);
    procedure SetConnectionTimeout(const AValue: UInt32);
    procedure SetTimeOut(const AValue: UInt32);
    procedure SetCommunicationMode(const AValue: THL7CommunicationMode);
    procedure SetIsListener(const AValue: Boolean);
    procedure SetDefStringEncoding(const AValue: IIdTextEncoding);
    {$IFDEF STRING_IS_ANSI}
    procedure SetDefAnsiEncoding(const AValue: IIdTextEncoding);
    {$ENDIF}

    function GetStatus: TIdHL7Status;
    function GetStatusDesc: String;

    procedure InternalSetStatus(const AStatus: TIdHL7Status; ADesc: String);

    procedure CheckServerParameters;
    procedure StartServer;
    procedure StopServer;
    procedure DropServerConnection;
    procedure ServerConnect(AContext: TIdContext);
    procedure ServerExecute(AContext: TIdContext);
    procedure ServerDisconnect(AContext: TIdContext);

    procedure CheckClientParameters;
    procedure StartClient;
    procedure StopClient;
    procedure DropClientConnection;
    procedure ReConnectFromTimeout;

    procedure HandleIncoming(var VBuffer: TIdBytes; AConnection: TIdTCPConnection);
    function HandleMessage(const AMsg: String; AConn: TIdTCPConnection; var VReply: String): Boolean;
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;

    procedure EnforceWaitReplyTimeout;

    function Going: Boolean;

    // for the app to use to hold any related object
    property ObjTag: TObject read FObject write FObject;

    // status
    property Status: TIdHL7Status read GetStatus;
    property StatusDesc: String read GetStatusDesc;
    function Connected: Boolean;

    property IsServer: Boolean read FIsServer;

    procedure Start;
    procedure PreStop; // call this in advance to start the shut down process. You do not need to call this
    procedure Stop;

    procedure WaitForConnection(AMaxLength: UInt32); // milliseconds

    // asynchronous.
    function AsynchronousSend(const AMsg: String; ASyncConnection: TIdTCPConnection = nil): TSendResponse;
    property OnMessageArrive: TMessageArriveEvent read FOnMessageArrive write FOnMessageArrive;

    // synchronous
    function SynchronousSend(const AMsg: String; var VReply: String): TSendResponse;
    property OnReceiveMessage: TMessageReceiveEvent read FOnReceiveMessage write FOnReceiveMessage;
    procedure CheckSynchronousSendResult(AResult: TSendResponse; const AMsg: String);

    // single thread - like SynchronousSend, but don't hold the thread waiting
    procedure SendMessage(const AMsg: String);
    // you can't call SendMessage again without calling GetReply first
    function GetReply(var VReply: String): TSendResponse;
    function GetMessage(var VMsg: String): IInterface;  // return nil if no messages
    // if you don't call SendReply then no reply will be sent.
    procedure SendReply(AMsgHnd: IInterface; const AReply: String);

    function HasClientConnection : Boolean;
    procedure Disconnect;

    property DefStringEncoding: IIdTextEncoding read FDefStringEncoding write SetDefStringEncoding;
    {$IFDEF STRING_IS_ANSI}
    property DefAnsiEncoding: IIdTextEncoding read FDefAnsiEncoding write SetDefAnsiEncoding;
    {$ENDIF}

    property IsServerExecuting: Boolean read FIsServerExecuting;

  published
    // basic properties
    property Address: String read FAddress write SetAddress;  // leave blank and we will be server
    property Port: Word read FPort write SetPort default DEFAULT_PORT;

    property KeepAlive: TIdHL7KeepAlive read FKeepAlive write SetKeepAlive;

    // milliseconds - message timeout - how long we wait for other system to reply
    property TimeOut: UInt32 read FTimeOut write SetTimeOut default DEFAULT_TIMEOUT;

    // milliseconds - message timeout. When running cmSingleThread, how long we wait for the application to process an incoming message before giving up
    property ReceiveTimeout: LongWord read FReceiveTimeout write FReceiveTimeout default DEFAULT_RECEIVE_TIMEOUT;

    // server properties
    property ConnectionLimit: Word read FConnectionLimit write SetConnectionLimit default DEFAULT_CONN_LIMIT; // ignored if isListener is false
    property IPRestriction: String read FIPRestriction write SetIPRestriction;
    property IPMask: String read FIPMask write SetIPMask;

    // client properties

    // milliseconds - how long we wait after losing connection to retry
    property ReconnectDelay: LongWord read FReconnectDelay write SetReconnectDelay default DEFAULT_RECONNECT_DELAY;

    // milliseconds - how long we allow a connection to be open without traffic (damn firewalls)
    property ConnectionTimeout: UInt32 read FConnectionTimeout write SetConnectionTimeout default DEFAULT_CONNECTION_TIMEOUT;

    // message flow

    // Set this to one of 4 possibilities:
    //
    //    cmUnknown
    //       Default at start up. You must set a value before starting
    //
    //    cmAsynchronous
    //        Send Messages with AsynchronousSend. does not wait for
    //                   remote side to respond before returning
    //        Receive Messages with OnMessageArrive. Message may
    //                   be response or new message
    //       The application is responsible for responding to the remote
    //       application and dropping the link as required
    //       You must hook the OnMessageArrive Event before setting this mode
    //       The property IsListener has no meaning in this mode
    //
    //   cmSynchronous
    //       Send Messages with SynchronousSend. Remote applications response
    //                   will be returned (or timeout). Only use if IsListener is false
    //       Receive Messages with OnReceiveMessage. Only if IsListener is
    //                   true
    //       In this mode, the object will wait for a response when sending,
    //       and expects the application to reply when a message arrives.
    //       In this mode, the interface can either be the listener or the
    //       initiator but not both. IsListener controls which one.
    //       note that OnReceiveMessage must be thread safe if you allow
    //       more than one connection to a server
    //
    //   cmSingleThread
    //       Send Messages with SendMessage. Poll for answer using GetReply.
    //                   Only if isListener is false
    //       Receive Messages using GetMessage. Return a response using
    //                   SendReply. Only if IsListener is true
    //       This mode is the same as cmSynchronous, but the application is
    //       assumed to be single threaded. The application must poll to
    //       find out what is happening rather than being informed using
    //       an event in a different thread

    property CommunicationMode: THL7CommunicationMode read FCommunicationMode write SetCommunicationMode default DEFAULT_COMM_MODE;

    // note that IsListener is not related to which end is client. Either end
    // may make the connection, and thereafter only one end will be the initiator
    // and one end will be the listener. Generally it is recommended that the
    // listener be the server. If the client is listening, network conditions
    // may lead to a state where the client has a phantom connection and it will
    // never find out since it doesn't initiate traffic. In this case, restart
    // the interface if there isn't traffic for a period
    property IsListener: Boolean read FIsListener write SetIsListener default DEFAULT_IS_LISTENER;

    // useful for application
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
    // this is called whenever OnConnect and OnDisconnect are called, and at other times, but only when server
    // it will be called after OnConnect and before OnDisconnect
    property OnConnCountChange: TIdHL7ConnCountEvent read FOnConnCountChange write FOnConnCountChange;

    // this is called when an unhandled exception is generated by the
    // hl7 object or the application. It allows the application to
    // construct a useful return error, log the exception, and drop the
    // connection if it wants
    property OnReceiveError: TReceiveErrorEvent read FOnReceiveError write FOnReceiveError;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
    {$IFDEF OSX}
  CoreServices,
    {$ENDIF}
  {$ENDIF}
  IdGlobalProtocols,
  IdResourceStringsProtocols;

type
  IIdQueuedMessage = interface(IInterface)
    ['{CF62BBC6-784E-4B79-B58B-4930330EB173}']
    function GetMessage: String;
    function GetReply: String;
    procedure SetReply(const AValue: String);
    procedure SetEvent;
    procedure Wait;

    property Message: String read GetMessage;
    property Reply: String read GetReply write SetReply;
  end;

  TIdQueuedMessage = class(TIdInterfacedObject, IIdQueuedMessage)
  private
    FEvent: TIdLocalEvent;
    FMsg: String;
    FTimeOut: LongWord;
    FReply: String;
  public
    constructor Create(const AMsg: String; ATimeOut: LongWord);
    destructor Destroy; override;

    function GetMessage: String;
    function GetReply: String;
    procedure SetReply(const AValue: String);
    procedure SetEvent;
    procedure Wait;
  end;

{ TIdHL7KeepAlive }

procedure TIdHL7KeepAlive.Assign(Source: TPersistent);
var
  LSource: TIdHL7KeepAlive;
begin
  if Source is TIdHl7KeepAlive then begin
    LSource := TIdHL7KeepAlive(Source);
    FUseKeepAlive := LSource.UseKeepAlive;
    FIdleTimeMS := LSource.IdleTimeMS;
    FIntervalMS := LSource.IntervalMS;
  end else begin
    inherited Assign(Source);
  end;
end;

{ TIdQueuedMessage }

constructor TIdQueuedMessage.Create(const AMsg: String; ATimeOut: LongWord);
begin
  Assert(Length(AMsg) > 0, 'Attempt to queue an empty message'); {do not localize}
  Assert(ATimeout <> 0, 'Attempt to queue a message with no timeout'); {do not localize}
  inherited Create;
  FEvent := TIdLocalEvent.Create(False, False);
  FMsg := AMsg;
  FTimeOut := ATimeOut;
end;

destructor TIdQueuedMessage.Destroy;
begin
  Assert(Assigned(Self));
  FreeAndNil(FEvent);
  inherited;
end;

function TIdQueuedMessage.GetMessage: String;
begin
  Assert(Assigned(Self));
  Result := FMsg;
end;

function TIdQueuedMessage.GetReply: string;
begin
  Assert(Assigned(Self));
  Result := FReply;
end;

procedure TIdQueuedMessage.SetReply(const AValue: String);
begin
  Assert(Assigned(Self));
  FReply := AValue;
end;

procedure TIdQueuedMessage.SetEvent;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FEvent));
  FEvent.SetEvent;
end;

procedure TIdQueuedMessage.Wait;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FEvent));
  FEvent.WaitFor(FTimeOut);
end;

{ EHL7CommunicationError }

constructor EHL7CommunicationError.Create(AnInterfaceName, AMessage: String);
begin
  //Assert(AInterfaceName <> '', 'Attempt to create an exception for an unnamed interface')
  //Assert(AMessage <> '', 'Attempt to create an exception with an empty message')
  // actually, we do not enforce either of these conditions, though they should both be true,
  // since we are already raising an exception
  FInterfaceName := AnInterfaceName;
  if FInterfaceName <> '' then
  begin
    inherited Create('[' + AnInterfaceName + '] ' + AMessage); {do not localize}
  end else begin
    inherited Create(AMessage);
  end;
end;

{ TIdHL7 }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdHL7.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdHL7.InitComponent;
begin
  inherited;

  // partly redundant initialization of properties
  FKeepAlive := TIdHL7KeepAlive.Create;
  FIsListener := DEFAULT_IS_LISTENER;
  FCommunicationMode := DEFAULT_COMM_MODE;
  FTimeOut := DEFAULT_TIMEOUT;
  FReconnectDelay := DEFAULT_RECONNECT_DELAY;
  FReceiveTimeout := DEFAULT_RECEIVE_TIMEOUT;
  FConnectionLimit := DEFAULT_CONN_LIMIT;
  FIPMask := NULL_IP;
  FIPRestriction := NULL_IP;
  FAddress := DEFAULT_ADDRESS;
  FPort := DEFAULT_PORT;
  FOnReceiveMessage := nil;
  FOnConnect := nil;
  FOnDisconnect := nil;
  FObject := nil;

  // initialise status
  FStatus := IsStopped;
  FStatusDesc := RSHL7StatusStopped;

  // build internal infrastructure
  FLock := TIdCriticalSection.Create;
  FServer := nil;
  FServerConn := nil;
  FClientThread := nil;
  FClient := nil;
  FMsgQueue := TInterfaceList.Create;
  FHndMsgQueue := TInterfaceList.Create;
  FWaitingForAnswer := False;
  FMsgReply := '';
  FReplyResponse := srNone;
  FWaitEvent := TIdLocalEvent.Create(False, False);
  FServerConnections := TObjectList.Create;
  FServerConnections.OwnsObjects := False;

  FDefStringEncoding := IndyTextEncoding_UTF8;
  {$IFDEF STRING_IS_ANSI}
  FDefAnsiEncoding := IndyTextEncoding_OSDefault;
  {$ENDIF}
end;

destructor TIdHL7.Destroy;
begin
  Assert(Assigned(Self));
  try
    if Going then
    begin
      Stop;
    end;
  finally
    FreeAndNil(FServerConnections);
    FreeAndNil(FKeepAlive);
    FreeAndNil(FMsgQueue);
    FreeAndNil(FHndMsgQueue);
    FreeAndNil(FWaitEvent);
    FreeAndNil(FLock);
    inherited;
  end;
end;

{==========================================================
  Property Servers
 ==========================================================}

procedure TIdHL7.SetDefStringEncoding(const AValue: IIdTextEncoding);
var
  LEncoding: IIdTextEncoding;
begin
  Assert(Assigned(Self));
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['DefStringEncoding'])); {do not localize}
  end;
  if FDefStringEncoding <> AValue then
  begin
    LEncoding := AValue;
    EnsureEncoding(LEncoding, encUTF8);
    FDefStringEncoding := LEncoding;
  end;
end;

{$IFDEF STRING_IS_ANSI}
procedure TIdHL7.SetDefAnsiEncoding(const AValue: IIdTextEncoding);
var
  LEncoding: IIdTextEncoding;
begin
  Assert(Assigned(Self));
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['DefAnsiEncoding'])); {do not localize}
  end;
  if FDefAnsiEncoding <> AValue then
  begin
    LEncoding := AValue;
    EnsureEncoding(LEncoding, encOSDefault);
    FDefAnsiEncoding := LEncoding;
  end;
end;
{$ENDIF}

procedure TIdHL7.SetAddress(const AValue: String);
begin
  Assert(Assigned(Self));
  // we don't make any assertions about AValue - will be '' if we are a server
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Address']));   {do not localize??}
  end;
  FAddress := AValue;
end;

procedure TIdHL7.SetConnectionLimit(const AValue: Word);
begin
  Assert(Assigned(Self));
  // no restrictions on AValue
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['ConnectionLimit'])); {do not localize??}
  end;
  FConnectionLimit := AValue;
end;

procedure TIdHL7.SetIPMask(const AValue: String);
begin
  Assert(Assigned(Self));
  // TODO: enforce that AValue is a valid Subnet mask
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IP Mask']));  {do not localize??}
  end;
  FIPMaskVal := IPv4ToUInt32(AValue);
  FIPMask := AValue;
end;

procedure TIdHL7.SetIPRestriction(const AValue: string);
begin
  Assert(Assigned(Self));
  // to do: enforce that AValue is a valid IP address range
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IP Restriction']));    {do not localize??}
  end;
  FIPRestrictionVal := IPv4ToUInt32(AValue);
  FIPRestriction := AValue;
end;

procedure TIdHL7.SetPort(const AValue: Word);
begin
  Assert(Assigned(Self));
  Assert(AValue <> 0, 'Attempt to use Port 0 for HL7 Communications'); {do not localize}
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Port'])); {do not localize}
  end;
  FPort := AValue;
end;

procedure TIdHL7.SetReconnectDelay(const AValue: LongWord);
begin
  Assert(Assigned(Self));
  // any value for AValue is accepted, although this may not make sense
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Reconnect Delay'])); {do not localize}
  end;
  FReconnectDelay := AValue;
end;

procedure TIdHL7.SetTimeOut(const AValue: UInt32);
begin
  Assert(Assigned(Self));
  Assert(AValue > 0, 'Attempt to configure TIdHL7 with a TimeOut of 0'); {do not localize}
  // we don't function at all if timeout is 0, though there are circumstances where it's not relevent
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Time Out']));          {do not localize??}
  end;
  FTimeOut := AValue;
end;

procedure TIdHL7.SetCommunicationMode(const AValue: THL7CommunicationMode);
begin
  Assert(Assigned(Self));
  Assert((AValue >= Low(THL7CommunicationMode)) and (AValue <= High(THL7CommunicationMode)), 'Value for TIdHL7.CommunicationMode not in range'); {do not localize}
  // only could arise if someone is typecasting?
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Communication Mode'])); {do not localize}
  end;
  FCommunicationMode := AValue;
end;

procedure TIdHL7.SetIsListener(const AValue: Boolean);
begin
  Assert(Assigned(Self));
  // AValue isn't checked
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IsListener'])); {do not localize}
  end;
  FIsListener := AValue;
end;

function TIdHL7.GetStatus: TIdHL7Status;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := FStatus;
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.Connected: boolean;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := (FStatus = IsConnected);
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.GetStatusDesc: String;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := FStatusDesc;
  finally
    FLock.Leave;
  end;
end;

procedure TIdHL7.InternalSetStatus(const AStatus: TIdHL7Status; ADesc: String);
begin
  Assert(Assigned(Self));
  Assert((AStatus >= Low(TIdHL7Status)) and (AStatus <= High(TIdHL7Status)), 'Value for TIdHL7.CommunicationMode not in range'); {do not localize}
  // ADesc is allowed to be anything at all
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    FStatus := AStatus;
    FStatusDesc := ADesc;
  finally
    FLock.Leave;
  end;
end;

{==========================================================
  Application Control
 ==========================================================}

procedure TIdHL7.Start;
var
  LStatus: TIdHL7Status;
begin
  Assert(Assigned(Self));
  LStatus := GetStatus;
  if LStatus = IsUnusable then
  begin
    raise EHL7CommunicationError.Create(Name, RSHL7NotFailedToStop);
  end;
  if LStatus <> IsStopped then
  begin
    raise EHL7CommunicationError.Create(Name, RSHL7AlreadyStarted);
  end;
  if FCommunicationMode = cmUnknown then
  begin
    raise EHL7CommunicationError.Create(Name, RSHL7ModeNotSet);
  end;
  if FCommunicationMode = cmAsynchronous then
  begin
    if not Assigned(FOnMessageArrive) then
    begin
      raise EHL7CommunicationError.Create(Name, RSHL7NoAsynEvent);
    end;
  end;
  if (FCommunicationMode = cmSynchronous) and IsListener then
  begin
    if not Assigned(FOnReceiveMessage) then
    begin
      raise EHL7CommunicationError.Create(Name, RSHL7NoSynEvent);
    end;
  end;
  FIsServer := (FAddress = '');
  FPreStopped := False;
  FWaitingForAnswer := False;
  if FIsServer then
  begin
    StartServer;
  end else begin
    StartClient;
  end;
end;

procedure TIdHL7.PreStop;

  procedure JoltList(list: TInterfaceList);
  var
    i: Integer;
  begin
    for i := 0 to list.Count - 1 do
    begin
      IIdQueuedMessage(list[i]).SetEvent;
    end;
  end;

begin
  Assert(Assigned(Self));
  if FCommunicationMode = cmSingleThread then
  begin
    Assert(Assigned(FLock));
    Assert(Assigned(FMsgQueue));
    Assert(Assigned(FHndMsgQueue));
    FLock.Enter;
    try
      JoltList(FMsgQueue);
      JoltList(FHndMsgQueue);
    finally
      FLock.Leave;
    end;
  end
  else if FCommunicationMode = cmSynchronous then
  begin
    Assert(Assigned(FWaitEvent));
    FWaitEvent.SetEvent;
  end;
  FPreStopped := True;
end;

procedure TIdHL7.Stop;
begin
  Assert(Assigned(Self));
  if not Going then
  begin
    raise EHL7CommunicationError.Create(Name, RSHL7AlreadyStopped);
  end;

  if not FPreStopped then
  begin
    PreStop;
    IndySleep(10); // give other threads a chance to clean up
  end;

  if FIsServer then begin
    StopServer;
  end else begin
    StopClient;
  end;
end;


{==========================================================
  Server Connection Maintainance
 ==========================================================}

procedure TIdHL7.EnforceWaitReplyTimeout;
begin
  Stop;
  Start;
end;

function TIdHL7.Going: Boolean;
var
  LStatus: TIdHL7Status;
begin
  Assert(Assigned(Self));
  LStatus := GetStatus;
  Result := (LStatus <> IsStopped) and (LStatus <> IsUnusable);
end;

procedure TIdHL7.WaitForConnection(AMaxLength: UInt32);
var
  LStartTime: TIdTicks;
begin
  LStartTime := Ticks64;
  while (not Connected) and (GetElapsedTicks(LStartTime) < AMaxLength) do begin
    IndySleep(50);
  end;
end;

procedure TIdHL7.CheckSynchronousSendResult(AResult: TSendResponse; const AMsg: String);
begin
  case AResult of
    srNone:
      raise EHL7CommunicationError.Create(Name, RSHL7ErrInternalsrNone);
    srError:
      raise EHL7CommunicationError.Create(Name, AMsg);
    srNoConnection:
      raise EHL7CommunicationError.Create(Name, RSHL7ErrNotConn);
    srSent:
      // cause this should only be returned asynchronously
      raise EHL7CommunicationError.Create(Name, RSHL7ErrInternalsrSent);
    srOK: ; // all ok
    srTimeout:
      raise EHL7CommunicationError.Create(Name, RSHL7ErrNoResponse);
    else
      raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7ErrInternalUnknownVal, [Ord(AResult)]));
  end;
end;

procedure TIdHL7.SetConnectionTimeout(const AValue: UInt32);
begin
  Assert(Assigned(Self));
  // any value for AValue is accepted, although this may not make sense
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Connection Timeout']));   {do not localize??}
  end;
  FConnectionTimeout := AValue;
end;

procedure TIdHL7.ReConnectFromTimeout;
var
  iLoop : Integer;
begin
  Assert(Assigned(Self));
  Assert(not FIsServer, 'Cannot try to reconnect from a timeout if acting as a server'); {do not localize}
  StartClient;
  IndySleep(50);
  iLoop := 0;
  while (not Connected) and (iLoop < 100) and (not FPreStopped) do
  begin
    IndySleep(100);
    Inc(iLoop);
  end;
  // TODO: raise an error if not connected or prestopped?
end;

procedure TIdHL7.SetKeepAlive(const AValue: TIdHL7KeepAlive);
begin
  if Going then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['KeepAlive']));   {do not localize??}
  end;
  FKeepAlive.Assign(AValue);
end;

function TIdHL7.HasClientConnection: Boolean;
begin
  Result := Assigned(FClientThread);
end;

procedure TIdHL7.Disconnect;
var
  i: Integer;
begin
  if FIsServer then
  begin
    FLock.Enter;
    try
      for i := 0 to FServerConnections.Count - 1 do begin
        TIdContext(FServerConnections[i]).Connection.Disconnect;
      end;
    finally
      FLock.Leave;
    end;
  end
  else if Assigned(FClientThread) then begin
    FClientThread.FClient.Disconnect;
  end;
end;

procedure TIdHL7.CheckServerParameters;
begin
  Assert(Assigned(Self));
  if (FCommunicationMode = cmAsynchronous) or (not FIsListener) then
  begin
    FConnectionLimit := 1;
  end;

  if (FPort < 1) then // though we have already ensured that this cannot happen
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7InvalidPort, [FPort]));
  end;
end;

procedure TIdHL7.StartServer;
var
  i: Integer;
begin
  Assert(Assigned(Self));
  CheckServerParameters;
  FServer := TIdTCPServer.Create(nil);
  try
    FServer.DefaultPort := FPort;
    FServer.OnConnect := ServerConnect;
    FServer.OnExecute := ServerExecute;
    FServer.OnDisconnect := ServerDisconnect;
    // RLebeau: this unit does not currently support restriction of IPv6 clients, so
    // adding an explicit IPv4 binding to prevent TIdTCPServer from creating an implicit
    // IPv6 binding on systems that allow dual IPv4/IPv6 bindings on the same ip/port...
    FServer.Bindings.Add.IPVersion := Id_IPv4; // TODO: support IPv6 clients?
    FServer.Active := True;
    if FKeepAlive.UseKeepAlive then
    begin
      for i := 0 to FServer.Bindings.Count - 1 do begin
        FServer.Bindings[i].SetKeepAliveValues(True, FKeepAlive.IdleTimeMS, FKeepAlive.IntervalMS);
      end;
    end;
    InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
  except
    on e: Exception do
    begin
      InternalSetStatus(IsStopped, IndyFormat(RSHL7StatusFailedToStart, [e.Message]));
      FreeAndNil(FServer);
      raise;
    end;
  end;
end;

procedure TIdHL7.StopServer;
begin
  Assert(Assigned(Self));
  try
    FServer.Active := False;
    FreeAndNil(FServer);
    InternalSetStatus(IsStopped, RSHL7StatusStopped);
  except
    on e: Exception do
    begin
      // somewhat arbitrary decision: if for some reason we fail to shutdown,
      // we will stubbornly refuse to work again.
      InternalSetStatus(IsUnusable, IndyFormat(RSHL7StatusFailedToStop, [e.Message]));
      FServer := nil; // Note: potential memory leak!
      raise;
    end;
  end;
end;

procedure TIdHL7.ServerConnect(AContext: TIdContext);
var
  LNotify: Boolean;
  LConnCount: Integer;
  LValid: Boolean;
  LIPStr: String;
  LIPVal: UInt32;
begin
  Assert(Assigned(Self));
  Assert(Assigned(AContext));
  Assert(Assigned(AContext.Binding));
  Assert(Assigned(FLock));
  LConnCount := 0;
  LIPStr := AContext.Binding.PeerIP;
  LIPVal := IPv4ToUInt32(LIPStr);
  if ((LIPVal xor FIPRestrictionVal) and FIPMaskVal) <> 0 then
  begin
    raise Exception.Create('Denied'); {do not localize}
  end;
  FLock.Enter;
  try
    LConnCount := FServerConnections.Count;
    LNotify := (LConnCount = 0);
    LValid := (LConnCount < FConnectionLimit);
    if LValid then
    begin
      if (LConnCount = 0) then
      begin
        FServerConn := AContext.Connection;
      end else begin
        FServerConn := nil; // RLebeau: why?
      end;
      FServerConnections.Add(AContext);
      Inc(LConnCount);
      if LNotify then
      begin
        InternalSetStatus(IsConnected, RSHL7StatusConnected);
      end;
      AContext.Connection.IOHandler.ReadTimeout := FReceiveTimeout;
    end;
  finally
    FLock.Leave;
  end;

  if LValid then
  begin
    if LNotify and Assigned(FOnConnect) then begin
      FOnConnect(self);
    end;
    if Assigned(FOnConnCountChange) and (FConnectionLimit <> 1) then begin
      FOnConnCountChange(Self, LConnCount);
    end;
  end else begin
    // Thread exceeds connection limit
    // it would be better to stop getting here in the case of an invalid connection
    // cause here we drop it - nasty for the client. To be investigated later
    AContext.Connection.Disconnect;
  end;
end;

procedure TIdHL7.ServerDisconnect(AContext: TIdContext);
var
  LNotify: Boolean;
  LConnCount: Integer;
begin
  Assert(Assigned(Self));
  Assert(Assigned(AContext));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    FServerConnections.Remove(AContext);
    LConnCount := FServerConnections.Count;
    LNotify := (LConnCount = 0);

    if AContext.Connection = FServerConn then
    begin
      FServerConn := nil;
    end;
    if LNotify then
    begin
      InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
    end;
  finally
    FLock.Leave;
  end;
  //Note events outside of critical section as they are expected to have critical thread save logic build into them
  if Assigned(FOnConnCountChange) and (FConnectionLimit <> 1) then begin
    FOnConnCountChange(Self, LConnCount); //Current causes Thread to freeze if called event does something like write to memobox even if in a critical section
  end;
  if LNotify and Assigned(FOnDisconnect) then begin
    FOnDisconnect(Self);  //Current causes Thread to freeze if called event does something like write to memobox even if in a critical section
  end;
end;

procedure TIdHL7.ServerExecute(AContext: TIdContext);
var
  LBuffer: TIdBytes;
begin
  Assert(Assigned(Self));
  Assert(Assigned(AContext));
  FIsServerExecuting := True;
  try
    // 1. prompt the network for content.
    while Assigned(AContext.Connection.IOHandler) do
    begin
      AContext.Connection.IOHandler.ReadBytes(LBuffer, -1, True);
      HandleIncoming(LBuffer, AContext.Connection);
    end;
  except
    try
      // well, there was some network error. We aren't sure what it
      // was, and it doesn't matter for this layer. we're just going
      // to make sure that we start again.
      // to review: what happens to the error messages?
      AContext.Connection.Disconnect;
    except
    end;
  end;
  FIsServerExecuting := False;
end;


procedure TIdHL7.DropServerConnection;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    if Assigned(FServerConn) then begin
      FServerConn.Disconnect;
    end;
  finally
    FLock.Leave;
  end;
end;


{==========================================================
  Client Connection Maintainance
 ==========================================================}

procedure TIdHL7.CheckClientParameters;
begin
  Assert(Assigned(Self));
  if (FPort < 1) then
  begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7InvalidPort, [FPort]));
  end;
end;

procedure TIdHL7.StartClient;
begin
  Assert(Assigned(Self));
  CheckClientParameters;
  FClientThread := TIdHL7ClientThread.Create(Self);
  InternalSetStatus(isConnecting, RSHL7StatusConnecting);
end;

procedure TIdHL7.StopClient;
var
  LFinished: Boolean;
  LStartTime: TIdTicks;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    if Assigned(FClientThread) then
    begin
      FClientThread.Terminate;
      FClientThread.FClient.Disconnect;
      FClientThread.FCloseEvent.SetEvent;
    end else begin
      InternalSetStatus(isStopped, 'Stopped'); {do not localize}
    end;
  finally
    FLock.Leave;
  end;
  LStartTime := Ticks64;
  repeat
    LFinished := (GetStatus = IsStopped);
    if not LFinished then begin
      IndySleep(10);
    end;
  until LFinished or (GetElapsedTicks(LStartTime) > WAIT_STOP);
  if GetStatus <> IsStopped then
  begin
    // for some reason the client failed to shutdown. We will stubbornly refuse to work again
    InternalSetStatus(IsUnusable, IndyFormat(RSHL7StatusFailedToStop, [RSHL7ClientThreadNotStopped]));
  end;
end;


procedure TIdHL7.DropClientConnection;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    if Assigned(FClientThread) then begin
      FClientThread.FClient.Disconnect;
    end else begin
      // This may happen validly because both ends are trying to drop the connection simultaineously
    end;
  finally
    FLock.Leave;
  end;
end;

{ TIdHL7ClientThread }

constructor TIdHL7ClientThread.Create(AOwner: TIdHL7);
begin
  Assert(Assigned(AOwner));
  FOwner := AOwner;
  FCloseEvent := TIdLocalEvent.Create(True, False);
  FClient := TIdTCPClient.Create(nil);
  FClient.Host := AOwner.Address;
  FClient.Port := AOwner.Port;
  FClient.ReadTimeout := AOwner.ReceiveTimeout;
  FClient.UseNagle := True;
  inherited Create(False);
  FreeOnTerminate := True;
end;

destructor TIdHL7ClientThread.Destroy;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FOwner));
  Assert(Assigned(FOwner.FLock));
  try
    FOwner.FLock.Enter;
    try
      FOwner.FClientThread := nil;
      if not TimedOut then begin
        FOwner.InternalSetStatus(isStopped, RSHL7StatusStopped);
      end;
    finally
      FOwner.FLock.Leave;
    end;
  except
    // it's really vaguely possible that the owner
    // may be dead before we are. If that is the case, we blow up here.
    // who cares.
  end;
  FreeAndNil(FCloseEvent);
  FreeAndNil(FClient);
  inherited;
end;

procedure TIdHL7ClientThread.PollStack;
var
  LBuffer: TIdBytes;
begin
  Assert(Assigned(Self));
  repeat
    // we don't send here - we just poll the stack for content
    // if the application wants to terminate us at this point,
    // then it will disconnect the socket and we will get thrown
    // out
    // we really don't care at all whether the disconnect was clean or ugly

    // but we do need to suppress exceptions that come from
    // indy otherwise the client thread will terminate

    try
      while Assigned(FClient.IOHandler) do
      begin
        FClient.IOHandler.ReadBytes(LBuffer, -1, True);
        FOwner.HandleIncoming(LBuffer, FClient);
      end;
    except
      try
        // well, there was some network error. We aren't sure what it
        // was, and it doesn't matter for this layer. we're just going
        // to make sure that we start again.
        // to review: what happens to the error messages?
        FClient.Disconnect;
      except
      end;
    end;
  until Terminated or (not FClient.Connected);
end;

const
  SECOND_LENGTH = 1000;
  MINUTE_LENGTH = SECOND_LENGTH * 60;
  HOUR_LENGTH = MINUTE_LENGTH * 60;
  DAY_LENGTH = HOUR_LENGTH * 24;

function DescribePeriod(Period: LongWord): String;
begin
  if Period < SECOND_LENGTH then begin
    Result := IntToStr(Period) + 'ms' {do not localize}
  end
  else if Period < (180 * SECOND_LENGTH) then begin
    Result := IntToStr(trunc(Period / SECOND_LENGTH)) + 'sec' {do not localize}
  end
  else if Period < (180 * MINUTE_LENGTH) then begin
    Result := IntToStr(trunc(Period / MINUTE_LENGTH)) + 'min' {do not localize}
  end
  else if Period < (72 * HOUR_LENGTH) then begin
    Result := IntToStr(trunc(Period / HOUR_LENGTH)) + 'hr' {do not localize}
  end else begin
    Result := IntToStr(trunc(Period / DAY_LENGTH)) + ' days'; {do not localize}
  end;
end;

procedure TIdHL7ClientThread.Execute;
begin
  Assert(Assigned(Self));
  try
    repeat
      // try to connect. Try indefinitely but wait Owner.FReconnectDelay
      // between attempts. Problems: how long does Connect take?
      repeat
        FOwner.InternalSetStatus(IsConnecting, rsHL7StatusConnecting);
        try
          FClient.Connect;
          Break;
        except
          on e: Exception do
          begin
            //now we can take more liberties with the time and date output because it's only
            //for human consumption (probably in a log
            FOwner.InternalSetStatus(IsWaitReconnect, IndyFormat(rsHL7StatusReConnect, [DescribePeriod(FOwner.FReconnectDelay), e.Message]));
          end;
        end;
        if Terminated then Break;
        // TODO: run this in a smaller loop checking Terminated on each iteration,
        // or hook up this event to TThread.TerminatedSet()...
        FCloseEvent.WaitFor(FOwner.FReconnectDelay);
      until Terminated;

      if Terminated then begin
        Exit;
      end;

      if FOwner.FKeepAlive.UseKeepAlive then begin
        FClient.Socket.Binding.SetKeepAliveValues(True, FOwner.FKeepAlive.IdleTimeMS, FOwner.FKeepAlive.IntervalMS);
      end;

      FLastTraffic := Ticks64;

      FOwner.FLock.Enter;
      try
        FOwner.FClient := FClient;
        FOwner.InternalSetStatus(IsConnected, rsHL7StatusConnected);
      finally
        FOwner.FLock.Leave;
      end;

      if Assigned(FOwner.FOnConnect) then begin
        FOwner.FOnConnect(FOwner);
      end;

      try
        PollStack;
      finally
        FOwner.FLock.Enter;
        try
          FOwner.FClient := nil;
          if TimedOut then begin
            FOwner.InternalSetStatus(isTimedOut, RSHL7StatusTimedout);
          end else begin
            FOwner.InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
          end;
        finally
          FOwner.FLock.Leave;
        end;
        if Assigned(FOwner.FOnDisconnect) then begin
          FOwner.FOnDisconnect(FOwner);
        end;
      end;
      if TimedOut then begin
        FClient.Disconnect;
      end
      else if not Terminated then
      begin
        // we got disconnected. ReconnectDelay applies.
        FOwner.InternalSetStatus(IsWaitReconnect, IndyFormat(rsHL7StatusReConnect, [DescribePeriod(FOwner.FReconnectDelay), 'Disconnected'])); {do not localize}
        // TODO: run this in a smaller loop checking Terminated on each iteration,
        // or hook up this event to TThread.TerminatedSet()...
        FCloseEvent.WaitFor(FOwner.FReconnectDelay);
      end;
    until Terminated or (not FOwner.IsListener and TimedOut);
  except
    on e: Exception do
    begin
      // presumably some comms or indy related exception
      // there's not really any good place to put this????
    end;
  end;
end;

function TIdHL7ClientThread.TimedOut: boolean;
begin
  Result := (FOwner.FConnectionTimeout > 0) and (GetElapsedTicks(FLastTraffic) > FOwner.FConnectionTimeout);
end;

{==========================================================
  Internal process management
 ==========================================================}

function EncodeHL7Message(const AMsg: String; AByteEncoding: IIdTextEncoding
  {$IFDEF STRING_IS_ANSI}; AAnsiEncoding: IIdTextEncoding{$ENDIF}
  ): TIdBytes;
var
  LMsgLen, LIndex: Integer;
  {$IFDEF STRING_IS_ANSI}
  LTemp: TIdUnicodeString;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_ANSI}
  if AMsg <> '' then begin
    LTemp := AAnsiEncoding.GetString(
      {$IFNDEF VCL_6_OR_ABOVE}
      // RLebeau: for some reason, Delphi 5 causes a "There is no overloaded
      // version of 'GetString' that can be called with these arguments" compiler
      // error if the PByte type-cast is used, even though GetString() actually
      // expects a PByte as input.  Must be a compiler bug, as it compiles fine
      // in Delphi 6.  So, converting to TIdBytes until I find a better solution...
      RawToBytes(PAnsiChar(AMsg)^, Length(AMsg))
      {$ELSE}
      PByte(PAnsiChar(AMsg)), Length(AMsg)
      {$ENDIF}
    );
  end;
  LMsgLen := AByteEncoding.GetByteCount(LTemp);
  {$ELSE}
  LMsgLen := AByteEncoding.GetByteCount(AMsg);
  {$ENDIF}

  SetLength(Result, Length(MSG_START) + LMsgLen + Length(MSG_END));
  LIndex := 0;

  CopyTIdByteArray(MSG_START, 0, Result, LIndex, Length(MSG_START));
  Inc(LIndex, Length(MSG_START));

  AByteEncoding.GetBytes(
    {$IFDEF STRING_IS_ANSI}LTemp{$ELSE}AMsg{$ENDIF},
    1, Length({$IFDEF STRING_IS_ANSI}LTemp{$ELSE}AMsg{$ENDIF}),
    Result, LIndex
  );
  Inc(LIndex, LMsgLen);

  CopyTIdByteArray(MSG_END, 0, Result, LIndex, Length(MSG_END));
end;

procedure TIdHL7.HandleIncoming(var VBuffer: TIdBytes; AConnection: TIdTCPConnection);
var
  LStart, LEnd: Integer;
  LMsg, LReply: String;
  LBytes: TIdBytes;
  {$IFDEF STRING_IS_ANSI}
  LTemp: TIdUnicodeString;
  {$ENDIF}

  function FindBytes(const ABytesToSearch: TIdBytes; const ABytesToFind: array of Byte; AStart: Integer): Integer;
  var
    I: Integer;
    LBytesLen, LFindLen: Integer;
    LMatches: Boolean;
  begin
    LBytesLen := Length(ABytesToSearch);
    LFindLen := Length(ABytesToFind);
    while (AStart + LFindLen) <= LBytesLen do
    begin
      Result := ByteIndex(ABytesToFind[0], ABytesToSearch, AStart);
      if Result = -1 then Exit;
      LMatches := True;
      for I := 1 to High(ABytesToFind) do
      begin
        if ABytesToSearch[Result + I] <> ABytesToFind[I] then
        begin
          LMatches := False;
          Break;
        end;
      end;
      if LMatches then Exit;
      Inc(AStart);
    end;
    Result := -1;
  end;

begin
  Assert(Assigned(Self));
  Assert(Length(VBuffer) > 0, 'Attempt to handle an empty buffer'); {do not localize}
  Assert(Assigned(AConnection));
  try
    // process any messages in the buffer (may get more than one per packet)
    repeat
      LStart := FindBytes(VBuffer, MSG_START, 0);
      if LStart >= 0 then begin
        Inc(LStart, Length(MSG_START));
        LEnd := FindBytes(VBuffer, MSG_END, LStart);
      end else begin
        LEnd := FindBytes(VBuffer, MSG_END, 0);
      end;

      if (LStart >= 0) and (LEnd >= 0) then
      begin
        {$IFDEF STRING_IS_ANSI}
        LTemp := FDefStringEncoding.GetString(VBuffer, LStart, LEnd - LStart);
        LBytes := FDefAnsiEncoding.GetBytes(LTemp);
        SetString(LMsg, PAnsiChar(LBytes), Length(LBytes));
        {$ELSE}
        LMsg := FDefStringEncoding.GetString(VBuffer, LStart, LEnd - LStart);
        {$ENDIF}

        if HandleMessage(LMsg, AConnection, LReply) then
        begin
          if Length(LReply) > 0 then
          begin
            LBytes := EncodeHL7Message(LReply, FDefStringEncoding
              {$IFDEF STRING_IS_ANSI}, FDefAnsiEncoding{$ENDIF}
            );
            AConnection.IOHandler.Write(LBytes);
          end;
        end else begin
          AConnection.Disconnect;
        end;
      end;
      if LEnd >= 0 then begin
        VBuffer := Copy(VBuffer, LEnd + Length(MSG_END), MaxInt);
      end;
    until LEnd = -1;
    if Length(VBuffer) > BUFFER_SIZE_LIMIT then begin
      AConnection.Disconnect;
    end;
  except
    // well, we need to suppress the exception, and force a reconnection
    // we don't know why an exception has been allowed to propagate back
    // to us, it shouldn't be allowed. so what we're going to do, is drop
    // the connection so that we force all the network layers on both
    // ends to reconnect.
    // this is a waste of time if the error came from the application but
    // this is not supposed to happen
    try
      AConnection.Disconnect;
    except
      // nothing - suppress
    end;
  end;
end;

function TIdHL7.HandleMessage(const AMsg: String; AConn: TIdTCPConnection; var VReply: String): Boolean;
var
  LQueMsg: IIdQueuedMessage;
begin
  Assert(Assigned(Self));
  Assert(Length(AMsg) > 0, 'Attempt to handle an empty message'); {do not localize}
  Assert(Assigned(FLock));
  VReply := '';
  Result := True;
  try
    case FCommunicationMode of
      cmUnknown:
      begin
        raise EHL7CommunicationError.Create(Name, RSHL7ImpossibleMessage);
      end;
      cmAsynchronous:
      begin
        FOnMessageArrive(Self, AConn, AMsg);
      end;
      cmSynchronous, cmSingleThread:
      begin
        if IsListener then
        begin
          if FCommunicationMode = cmSynchronous then
          begin
            Result := False;
            FOnReceiveMessage(Self, AConn, AMsg, Result, VReply);
          end else
          begin
            LQueMsg := TIdQueuedMessage.Create(AMsg, FReceiveTimeout);
            try
              FLock.Enter;
              try
                FMsgQueue.Add(LQueMsg);
              finally
                FLock.Leave;
              end;
              LQueMsg.Wait;
              // no locking. There is potential problems here. To be reviewed
              VReply := LQueMsg.Reply;
            finally
              FLock.Enter;
              try
                FMsgQueue.Remove(LQueMsg);
              finally
                FLock.Leave;
              end;
              LQueMsg := nil;
            end;
          end;
        end else
        begin
          FLock.Enter;
          try
            if FWaitingForAnswer then
            begin
              FWaitingForAnswer := False;
              FMsgReply := AMsg;
              FReplyResponse := srOK;
              if FCommunicationMode = cmSynchronous then
              begin
                Assert(Assigned(FWaitEvent));
                FWaitEvent.SetEvent;
              end;
            end else begin
              // we could have got here by timing out, but this is quite unlikely,
              // since the connection will be dropped in that case. We will report
              // this as a spurious message
              raise EHL7CommunicationError.Create(Name, RSHL7UnexpectedMessage);
            end;
          finally
            FLock.Leave;
          end;
        end;
      end;
    else
      begin
        raise EHL7CommunicationError.Create(Name, RSHL7UnknownMode);
      end;
    end;
  except
    on e: Exception do
    begin
      if Assigned(FOnReceiveError) then begin
        FOnReceiveError(Self, AConn, AMsg, e, VReply, Result);
      end else begin
        Result := False;
      end;
    end;
  end;
end;

{==========================================================
  Sending
 ==========================================================}

// this procedure is not technically thread safe.
// if the connection is disappearing when we are attempting
// to write, we can get transient access violations. Several
// strategies are available to prevent this but they significantly
// increase the scope of the locks, which costs more than it gains

function TIdHL7.AsynchronousSend(const AMsg: String; ASyncConnection: TIdTCPConnection = nil): TSendResponse;
var
  LBytes: TIdBytes;
begin
  Result := srNone; // just to suppress the compiler warning
  Assert(Assigned(Self));
  Assert(Length(AMsg) > 0, 'Attempt to send an empty message'); {do not localize}
  Assert(Assigned(FLock));
  if GetStatus = isTimedOut then
  begin
    ReConnectFromTimeout;
  end;
  FLock.Enter;
  try
    if not Going then
    begin
      raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWorking, [RSHL7SendMessage]));
    end
    else if GetStatus <> isConnected then
    begin
      Result := srNoConnection;
    end
    else if FIsServer then
    begin
      if (FCommunicationMode = cmAsynchronous) and Assigned(ASyncConnection) then
      begin
        LBytes := EncodeHL7Message(AMsg, FDefStringEncoding
          {$IFDEF STRING_IS_ANSI}, FDefAnsiEncoding{$ENDIF}
        );
        ASyncConnection.IOHandler.Write(LBytes);
        Result := srSent;
      end
      else if Assigned(FServerConn) then
      begin
        LBytes := EncodeHL7Message(AMsg, FDefStringEncoding
          {$IFDEF STRING_IS_ANSI}, FDefAnsiEncoding{$ENDIF}
        );
        FServerConn.IOHandler.Write(LBytes);
        Result := srSent;
      end else begin
        raise EHL7CommunicationError.Create(Name, RSHL7NoConnectionFound);
      end;
    end
    else if Assigned(FClientThread) and Assigned(FClient) then
    begin
      LBytes := EncodeHL7Message(AMsg, FDefStringEncoding
        {$IFDEF STRING_IS_ANSI}, FDefAnsiEncoding{$ENDIF}
      );
      FClient.IOHandler.Write(LBytes);
      FClientThread.FLastTraffic := Ticks64; // TODO: sync this?
      Result := srSent;
    end else begin
      raise EHL7CommunicationError.Create(Name, RSHL7NoConnectionFound);
    end;
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.SynchronousSend(const AMsg: String; var VReply: String): TSendResponse;
begin
  Assert(Assigned(self));
  Assert(Length(AMsg) > 0, 'Attempt to send an empty message'); {do not localize}
  Assert(Assigned(FLock));
  Result := srError;
  FLock.Enter;
  try
    FWaitingForAnswer := True;
    FWaitStart := Ticks64;
    FReplyResponse := srTimeout;
    FMsgReply := '';
  finally
    FLock.Leave;
  end;
  try
    Result := AsynchronousSend(AMsg);
    if Result = srSent then
    begin
      Assert(Assigned(FWaitEvent));
      FWaitEvent.WaitFor(FTimeOut);
    end;
  finally
    FLock.Enter;
    try
      FWaitingForAnswer := False;
      if Result = srSent then
      begin
        Result := FReplyResponse;
      end;
      if Result = srTimeout then
      begin
        if FIsServer then begin
          DropServerConnection;
        end else begin
          DropClientConnection;
        end;
      end;
      VReply := FMsgReply;
    finally
      FLock.Leave;
    end;
  end;
end;

procedure TIdHL7.SendMessage(const AMsg: String);
begin
  Assert(Assigned(Self));
  Assert(Length(AMsg) > 0, 'Attempt to send an empty message'); {do not localize}
  Assert(Assigned(FLock));
  if FWaitingForAnswer then begin
    raise EHL7CommunicationError.Create(Name, RSHL7WaitForAnswer);
  end;
  FLock.Enter;
  try
    FWaitingForAnswer := True;
    FWaitStart := Ticks64;
    FMsgReply := '';
    FReplyResponse := AsynchronousSend(AMsg);
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.GetReply(var VReply: String): TSendResponse;
begin
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    if FWaitingForAnswer then
    begin
      if GetElapsedTicks(FWaitStart) > FTimeOut then
      begin
        Result := srTimeout;
        VReply := '';
        FWaitingForAnswer := False;
        FReplyResponse := srError;
      end else begin
        Result := srNone;
      end;
    end else
    begin
      Result := FReplyResponse;
      if Result = srSent then
      begin
        Result := srTimeOut;
      end;
      VReply := FMsgReply;
      FWaitingForAnswer := False;
      FReplyResponse := srError;
    end;
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.GetMessage(var VMsg: String): IInterface;
var
  LQueMsg: IIdQueuedMessage;
begin
  Result := nil;
  Assert(Assigned(Self));
  Assert(Assigned(FLock));
  Assert(Assigned(FMsgQueue));
  FLock.Enter;
  try
    if FMsgQueue.Count > 0 then
    begin
      LQueMsg := IIdQueuedMessage(FMsgQueue[0]);
      VMsg := LQueMsg.Message;
      FMsgQueue.Delete(0);
      FHndMsgQueue.Add(LQueMsg);
      Result := LQueMsg;
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TIdHL7.SendReply(AMsgHnd: IInterface; const AReply: String);
var
  LQueMsg: IIdQueuedMessage;
begin
  Assert(Assigned(Self));
  Assert(Assigned(AMsgHnd));
  Assert(Length(AReply) > 0, 'Attempt to send an empty reply'); {do not localize}
  Assert(Assigned(FLock));
  FLock.Enter;
  try
    LQueMsg := AMsgHnd as IIdQueuedMessage;
    LQueMsg.Reply := AReply;
    LQueMsg.SetEvent;
    FHndMsgQueue.Remove(LQueMsg);
  finally
    FLock.Leave;
  end;
end;

end.
