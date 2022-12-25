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
  Rev 2.1 25/12/2022 12:32 AM EJPretorius/ ShoraiTek
   Added FDefSendEncoding for sending encoding control / default to utf8
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
  IdStackConsts,
  IdIOHandlerSocket,
  DateUtils,
  SysUtils;

const
  MSG_START = #$0B;       {do not localize}
  MSG_END = #$1C#$0D;   {do not localize}
  BUFFER_SIZE_LIMIT = $FFFFFFF;  // buffer is allowed to grow to this size without any valid messages. Will be truncated with no notice (DoS protection) (268MB)

  WAIT_STOP = 5000; // nhow long we wait for things to shut down cleanly


type
  EHL7CommunicationError = class(EIdException)
  Protected
    FInterfaceName: String;
  Public
    constructor Create(AnInterfaceName, AMessage: String);
    property InterfaceName: String Read FInterfaceName;
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
    isTimedOut,      // we are a client, and there was no traffic, we we closed the connection (and we are not listening)
    isUnusable       // Not Usable - stop failed
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
  MILLISECOND_LENGTH = (1 / (24 * 60 * 60 * 1000));
  SEND_RESPONSE_NAMES : Array [TSendResponse] Of String = ('None', 'Error', 'NoConnection', 'Sent', 'OK', 'Timeout');

type
  // the connection is provided in these events so that applications can obtain information about the
  // the peer. It's never OK to write to these connections
  TMessageArriveEvent = Procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String) Of Object;
  TMessageReceiveEvent = Procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String; Var VHandled: Boolean; Var VReply: String) Of Object;
  TReceiveErrorEvent = Procedure(ASender: TObject; AConnection: TIdTCPConnection; AMsg: String; AException: Exception; Var VReply: String; Var VDropConnection: Boolean) Of Object;

  TIdHL7 = class;
  TIdHL7ConnCountEvent = procedure (ASender : TIdHL7; AConnCount : integer) of object;

  { TIdHl7KeepAlive }

  TIdHl7KeepAlive = class(TPersistent)
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
  Protected
    FClient: TIdTCPClient;
    FCloseEvent: TIdLocalEvent;
    FOwner: TIdHL7;
    FLastTraffic : TDateTime;
    Function TimedOut : Boolean;
    procedure Execute; Override;
    procedure PollStack;
  Public
    constructor Create(aOwner: TIdHL7);
    destructor Destroy; Override;
  end;

  TIdHL7 = class(TIdBaseComponent)
  Private
    FConnectionTimeout: LongWord;
    FDefSendEncoding: IIdTextEncoding;
    FKeepAlive: TIdHl7KeepAlive;
    procedure SetDefSendEncoding(AValue: IIdTextEncoding);
  Protected
    FLock: TIdCriticalSection;
    FStatus: TIdHL7Status;
    FStatusDesc: String;

    // these queues hold messages when running in singlethread mode
    FMsgQueue: TList;
    FHndMsgQueue: TList;

    FAddress: String;
    FCommunicationMode: THL7CommunicationMode;
    FConnectionLimit: Word;
    FIPMask: String;
    FIPRestriction: String;
    FIPMaskVal : LongWord;
    FIPRestrictionVal : LongWord;
    FIsListener: Boolean;
    FObject: TObject;
    FPreStopped: Boolean;
    FPort: Word;
    FReconnectDelay: LongWord;
    FTimeOut: LongWord;
    FReceiveTimeout: LongWord;
    FServerConnections : TObjectList;

    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    FOnConnCountChange : TIdHL7ConnCountEvent;
    FOnMessageArrive: TMessageArriveEvent;
    FOnReceiveMessage: TMessageReceiveEvent;
    FOnReceiveError: TReceiveErrorEvent;

    FIsServer: Boolean;
    // current connection count (server only) (can only exceed 1 when mode is not
    // asynchronous and we are listening)
    FConnCount: Integer;
    FServer: TIdTCPServer;
    // if we are a server, and the mode is not asynchronous, and we are not listening, then
    // we will track the current server connection with this, so we can initiate sending on it
    FServerConn: TIdTCPConnection;

    // A thread exists to connect and receive incoming tcp traffic
    FClientThread: TIdHL7ClientThread;
    FClient: TIdTCPClient;

    // these fields are used for handling message response in synchronous mode
    FWaitingForAnswer: Boolean;
    FWaitStop: TDateTime;
    FMsgReply: String;
    FReplyResponse: TSendResponse;
    FWaitEvent: TIdLocalEvent;

    procedure SetAddress(const AValue: String);
    procedure SetKeepAlive(const Value: TIdHl7KeepAlive);
    procedure SetConnectionLimit(const AValue: Word);
    procedure SetIPMask(const AValue: String);
    procedure SetIPRestriction(const AValue: String);
    procedure SetPort(const AValue: Word);
    procedure SetReconnectDelay(const AValue: LongWord);
    Procedure SetConnectionTimeout(Const AValue: LongWord);
    procedure SetTimeOut(const AValue: LongWord);
    procedure SetCommunicationMode(const AValue: THL7CommunicationMode);
    procedure SetIsListener(const AValue: Boolean);
    function GetStatus: TIdHL7Status;
    function GetStatusDesc: String;

    procedure InternalSetStatus(const AStatus: TIdHL7Status; ADesc: String);

    procedure CheckServerParameters;
    procedure StartServer;
    procedure StopServer;
    procedure DropServerConnection;
    Procedure ServerConnect(AThread: TIdContext);
    Procedure ServerExecute(AThread: TIdContext);
    Procedure ServerDisconnect(AThread: TIdContext);

    procedure CheckClientParameters;
    procedure StartClient;
    procedure StopClient;
    procedure DropClientConnection;
    Procedure ReConnectFromTimeout;

    Procedure HandleIncoming(Var VBuffer: String; AConnection: TIdTCPConnection);
    Function HandleMessage(Const AMsg: String; AConn: TIdTCPConnection; Var VReply: String): Boolean;
    procedure InitComponent; override;
  Public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; Override;

    procedure EnforceWaitReplyTimeout;

    function Going: Boolean;

    // for the app to use to hold any related object
    property ObjTag: TObject Read FObject Write FObject;

    // status
    property Status: TIdHL7Status Read GetStatus;
    property StatusDesc: String Read GetStatusDesc;
    function Connected: Boolean;

    property IsServer: Boolean Read FIsServer;
    procedure Start;
    procedure PreStop; // call this in advance to start the shut down process. You do not need to call this
    procedure Stop;

    procedure WaitForConnection(AMaxLength: Integer); // milliseconds

    // asynchronous.
    function AsynchronousSend(AMsg: String): TSendResponse;
    property OnMessageArrive: TMessageArriveEvent Read FOnMessageArrive Write FOnMessageArrive;

    // synchronous
    function SynchronousSend(AMsg: String; var VReply: String): TSendResponse;
    property OnReceiveMessage: TMessageReceiveEvent Read FOnReceiveMessage Write FOnReceiveMessage;
    procedure CheckSynchronousSendResult(AResult: TSendResponse; AMsg: String);

    // single thread - like SynchronousSend, but don't hold the thread waiting
    procedure SendMessage(AMsg: String);
    // you can't call SendMessage again without calling GetReply first
    function GetReply(var VReply: String): TSendResponse;
    function GetMessage(var VMsg: String): pointer;  // return nil if no messages
    // if you don't call SendReply then no reply will be sent.
    procedure SendReply(AMsgHnd: pointer; AReply: String);

    Function HasClientConnection : Boolean;
    Procedure Disconnect;
    property DefSendEncoding : IIdTextEncoding read FDefSendEncoding write SetDefSendEncoding ;

  Published
    // basic properties
    property Address: String Read FAddress Write SetAddress;  // leave blank and we will be server
    property Port: Word Read FPort Write SetPort Default DEFAULT_PORT;

    Property KeepAlive : TIdHl7KeepAlive read FKeepAlive write SetKeepAlive;

    // milliseconds - message timeout - how long we wait for other system to reply
    Property TimeOut: LongWord Read FTimeOut Write SetTimeOut Default DEFAULT_TIMEOUT;

    // milliseconds - message timeout. When running cmSingleThread, how long we wait for the application to process an incoming message before giving up
    Property ReceiveTimeout: LongWord Read FReceiveTimeout Write FReceiveTimeout Default DEFAULT_RECEIVE_TIMEOUT;

    // server properties
    property ConnectionLimit: Word Read FConnectionLimit Write SetConnectionLimit Default DEFAULT_CONN_LIMIT; // ignored if isListener is false
    property IPRestriction: String Read FIPRestriction Write SetIPRestriction;
    property IPMask: String Read FIPMask Write SetIPMask;

    // client properties

    // milliseconds - how long we wait after losing connection to retry
    Property ReconnectDelay: LongWord Read FReconnectDelay Write SetReconnectDelay Default DEFAULT_RECONNECT_DELAY;

    // milliseconds - how long we allow a connection to be open without traffic (damn firewalls)
    Property ConnectionTimeout : LongWord Read FConnectionTimeout Write SetConnectionTimeout Default DEFAULT_CONNECTION_TIMEOUT;
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

    property CommunicationMode: THL7CommunicationMode Read FCommunicationMode Write SetCommunicationMode Default DEFAULT_COMM_MODE;

    // note that IsListener is not related to which end is client. Either end
    // may make the connection, and thereafter only one end will be the initiator
    // and one end will be the listener. Generally it is recommended that the
    // listener be the server. If the client is listening, network conditions
    // may lead to a state where the client has a phantom connection and it will
    // never find out since it doesn't initiate traffic. In this case, restart
    // the interface if there isn't traffic for a period
    property IsListener: Boolean Read FIsListener Write SetIsListener Default DEFAULT_IS_LISTENER;

    // useful for application
    property OnConnect: TNotifyEvent Read FOnConnect Write FOnConnect;
    property OnDisconnect: TNotifyEvent Read FOnDisconnect Write FOnDisconnect;
    // this is called whenever OnConnect and OnDisconnect are called, and at other times, but only when server
    // it will be called after OnConnect and before OnDisconnect
    Property OnConnCountChange: TIdHL7ConnCountEvent Read FOnConnCountChange Write FOnConnCountChange;

    // this is called when an unhandled exception is generated by the
    // hl7 object or the application. It allows the application to
    // construct a useful return error, log the exception, and drop the
    // connection if it wants
    property OnReceiveError: TReceiveErrorEvent Read FOnReceiveError Write FOnReceiveError;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
    {$IFDEF OSX}
 CoreServices,
    {$ENDIF}
  PosixSysSelect,
  PosixSysTime,
  {$ENDIF}
  IdGlobalProtocols,
  IdResourceStringsProtocols;

type
  TIdQueuedMessage = class(TIdInterfacedObject)
  Private
    FEvent: TIdLocalEvent;
    FMsg: String;
    FTimeOut: LongWord;
    FReply: String;
    procedure Wait;
  Public
    constructor Create(aMsg: String; ATimeOut: LongWord);
    destructor Destroy; Override;
    Function _AddRef: Integer; Stdcall;
    Function _Release: Integer; Stdcall;
  end;

{ TIdHl7KeepAlive }

procedure TIdHl7KeepAlive.Assign(Source: TPersistent);
var
  LSource: TIdHl7KeepAlive;
begin
  if Source is TIdHl7KeepAlive then begin
    LSource := TIdHl7KeepAlive(Source);
    FUseKeepAlive := LSource.UseKeepAlive;
    FIdleTimeMS := LSource.IdleTimeMS;
    FIntervalMS := LSource.IntervalMS;
  end else begin
    inherited Assign(Source);
  end;
end;

  { TIdQueuedMessage }

constructor TIdQueuedMessage.Create(aMsg: String; ATimeOut: LongWord);
begin
  Assert(Length(aMsg) > 0, 'Attempt to queue an empty message'); {do not localize}
  Assert(ATimeout <> 0, 'Attempt to queue a message with a 0 timeout'); {do not localize}
  inherited Create;
  FEvent := TIdLocalEvent.Create(False, False);
  FMsg := aMsg;
  FTimeOut := ATimeOut;
end;

destructor TIdQueuedMessage.Destroy;
begin
  assert(self <> NIL);
  FreeAndNil(FEvent);
  inherited;
end;

procedure TIdQueuedMessage.Wait;
begin
  assert(Assigned(Self));
  assert(Assigned(FEvent));
  FEvent.WaitFor(FTimeOut);
end;

Function TIdQueuedMessage._AddRef: Integer;
Begin
  Result := Inherited _AddRef;
End;

Function TIdQueuedMessage._Release: Integer;
Begin
  Result := Inherited _Release;
End;


{ EHL7CommunicationError }

constructor EHL7CommunicationError.Create(AnInterfaceName, AMessage: String);
begin
  //  assert(AInterfaceName <> '', 'Attempt to create an exception for an unnamed interface')
  //  assert(AMessage <> '', 'Attempt to create an exception with an empty message')
  //  actually, we do not enforce either of these conditions, though they should both be true,
  //  since we are already raising an exception
  FInterfaceName := AnInterfaceName;
  if FInterfaceName <> '' then         {do not localize}
    begin
    inherited Create('[' + AnInterfaceName + '] ' + AMessage)
    end
  else
    begin
    inherited Create(AMessage);
    end
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
  FKeepAlive:= TIdHl7KeepAlive.Create;
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
  FOnReceiveMessage := NIL;
  FOnConnect := NIL;
  FOnDisconnect := NIL;
  FObject := NIL;

  // initialise status
  FStatus := IsStopped;
  FStatusDesc := RSHL7StatusStopped;

  // build internal infrastructure
  Flock := TIdCriticalSection.Create;
  FConnCount := 0;
  FServer := NIL;
// todo  FServerConn := Nil;
  FClientThread := NIL;
  FClient := NIL;
  FMsgQueue := TList.Create;
  FHndMsgQueue := TList.Create;
  FWaitingForAnswer := False;
  SetLength(FMsgReply, 0);   {do not localize}
  FReplyResponse := srNone;
  FWaitEvent := TIdLocalEvent.Create(False, False);
  FServerConnections := TObjectList.Create;
  FServerConnections.OwnsObjects := False;

  FDefSendEncoding := IndyTextEncoding_UTF8;
end;

destructor TIdHL7.Destroy;
begin
  assert(Assigned(Self));
  try
    if Going then
    begin
      Stop;
    end;
  finally
    FreeAndNil(FServerConnections);
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

procedure TIdHL7.SetDefSendEncoding(AValue: IIdTextEncoding);
begin
  if FDefSendEncoding=AValue then Exit;
  FDefSendEncoding:=AValue;
end;

procedure TIdHL7.SetAddress(const AValue: String);
begin
  assert(Assigned(Self));
  // we don't make any assertions about AValue - will be '' if we are a server
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Address']));   {do not localize??}
    end;
  FAddress := AValue;
end;

procedure TIdHL7.SetConnectionLimit(const AValue: Word);
begin
  assert(Assigned(Self));
  // no restrictions on AValue
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['ConnectionLimit'])); {do not localize??}
    end;
  FConnectionLimit := AValue;
end;

procedure TIdHL7.SetIPMask(const AValue: String);
begin
  assert(Assigned(Self));
  // to do: enforce that AValue is a valid Subnet mask
  If Going Then
    Begin
    Raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IP Mask']));  {do not localize??}
    End;
  FIPMaskVal := IdGlobal.IPv4ToUInt32(AValue);

  FIPMask := AValue;
end;

procedure TIdHL7.SetIPRestriction(const AValue: String);
begin
  assert(Assigned(Self));
  // to do: enforce that AValue is a valid IP address range
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IP Restriction']));    {do not localize??}
    end;
  FIPRestrictionVal := IdGlobal.IPv4ToUInt32(AValue);
  FIPRestriction := AValue;
end;

procedure TIdHL7.SetPort(const AValue: Word);
begin
  assert(Assigned(Self));
  assert(AValue <> 0, 'Attempt to use Port 0 for HL7 Communications'); {do not localize}
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Port'])); {do not localize}
    end;
  FPort := AValue;
end;

procedure TIdHL7.SetReconnectDelay(const AValue: LongWord);
begin
  assert(Assigned(Self));
  // any value for AValue is accepted, although this may not make sense
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Reconnect Delay'])); {do not localize}
    end;
  FReconnectDelay := AValue;
end;

procedure TIdHL7.SetTimeOut(const AValue: LongWord);
begin
  assert(Assigned(Self));
  assert(FTimeout > 0, 'Attempt to configure TIdHL7 with a Timeout of 0'); {do not localize}
  // we don't fucntion at all if timeout is 0, though there is circumstances where it's not relevent
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['Time Out']));          {do not localize??}
    end;
  FTimeOut := AValue;
end;

procedure TIdHL7.SetCommunicationMode(const AValue: THL7CommunicationMode);
begin
  assert(Assigned(Self));
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
  assert(Assigned(Self));
  // AValue isn't checked
  if Going then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWhileWorking, ['IsListener'])); {do not localize}
    end;
  FIsListener := AValue;
end;

function TIdHL7.GetStatus: TIdHL7Status;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := FStatus;
  finally
    FLock.Leave;
    end;
end;

function TIdHL7.Connected: Boolean;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := FStatus = IsConnected;
  finally
    FLock.Leave;
    end;
end;

function TIdHL7.GetStatusDesc: String;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    Result := FStatusDesc;
  finally
    FLock.Leave;
    end;
end;

procedure TIdHL7.InternalSetStatus(const AStatus: TIdHL7Status; ADesc: String);
begin
  assert(Assigned(Self));
  Assert((AStatus >= Low(TIdHL7Status)) and (AStatus <= High(TIdHL7Status)), 'Value for TIdHL7.CommunicationMode not in range'); {do not localize}
  // ADesc is allowed to be anything at all
  assert(Assigned(FLock));
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
  assert(Assigned(Self));
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
  if FIsServer then
    begin
    StartServer
    end
  else
    begin
    StartClient;
    end;
  FPreStopped := False;
  FWaitingForAnswer := False;
end;

procedure TIdHL7.PreStop;
  procedure JoltList(l: TList);
  var
    i: Integer;
    begin
    for i := 0 to l.Count - 1 do
      begin
      TIdQueuedMessage(l[i]).FEvent.SetEvent;
      end;
    end;
begin
  assert(Assigned(Self));
  if FCommunicationMode = cmSingleThread then
    begin
    assert(Assigned(FLock));
    assert(Assigned(FMsgQueue));
    assert(Assigned(FHndMsgQueue));
    FLock.Enter;
    try
      JoltList(FMsgQueue);
      JoltList(FHndMsgQueue);
    finally
      FLock.Leave;
      end;
    End
  Else If FCommunicationMode = cmSynchronous Then
    Begin
    FWaitEvent.SetEvent;
    end;
  FPreStopped := True;
end;

procedure TIdHL7.Stop;
begin
  assert(Assigned(Self));
  if not Going then
    begin
    raise EHL7CommunicationError.Create(Name, RSHL7AlreadyStopped);
    end;

  if not FPreStopped then
    begin
    PreStop;
    IndySleep(10); // give other threads a chance to clean up
    end;

  if FIsServer then
    begin
    StopServer
    end
  else
    begin
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
  assert(Assigned(Self));
  LStatus := GetStatus;
  Result := (LStatus <> IsStopped) and (LStatus <> IsUnusable);
end;

procedure TIdHL7.WaitForConnection(AMaxLength: Integer);
var
  LStopWaiting: TDateTime;
begin
  LStopWaiting := Now + (AMaxLength * ((1 / (24 * 60)) / (60 * 1000)));
  while not Connected and (LStopWaiting > Now) do
    IndySleep(50);
end;

procedure TIdHL7.CheckSynchronousSendResult(AResult: TSendResponse; AMsg: String);
begin
  case AResult of
    srNone:
      raise EHL7CommunicationError.Create(Name,RSHL7ErrInternalsrNone);
    srError:
      raise EHL7CommunicationError.Create(Name, AMsg);
    srNoConnection:
      raise EHL7CommunicationError.Create(Name,RSHL7ErrNotConn);
    srSent:
      // cause this should only be returned asynchronously
      raise EHL7CommunicationError.Create(Name,RSHL7ErrInternalsrSent);
    srOK:; // all ok
    srTimeout:
      raise EHL7CommunicationError.Create(Name,RSHL7ErrNoResponse);
    else
      raise EHL7CommunicationError.Create(Name,RSHL7ErrInternalUnknownVal + IntToStr(Ord(AResult))); {do not localize}
    end;
end;

procedure TIdHL7.SetConnectionTimeout(const AValue: LongWord);
Begin
  // any value for AValue is accepted, although this may not make sense
  If Going Then
    Begin
    Raise EHL7CommunicationError.Create(Name, Format(RSHL7NotWhileWorking, ['Connection Timeout']));   {do not localize??}
    End;
  FConnectionTimeout := AValue;
End;

procedure TIdHL7.ReConnectFromTimeout;
Var
  iLoop : Integer;
Begin
  Assert(Not FIsServer, 'Cannot try to reconnect from a timeout if is a server');
  StartClient;
  sleep(50);
  iLoop := 0;
  While Not Connected And (iLoop < 100) And Not FPreStopped Do
    Begin
    sleep(100);
    Inc(iLoop);
    End;
End;

procedure TIdHL7.SetKeepAlive(const Value: TIdHl7KeepAlive);
begin
  If Going Then
    Begin
    Raise EHL7CommunicationError.Create(Name, Format(RSHL7NotWhileWorking, ['KeepAlive']));   {do not localize??}
    End;
  FKeepAlive := Value;
end;

function TIdHL7.HasClientConnection: Boolean;
begin
  result := FClientThread <> nil;
end;

procedure TIdHL7.Disconnect;
var
  i : integer;
begin
  if FIsServer Then
  Begin
    FLock.Enter;
    Try
      For i := 0 to FServerConnections.Count - 1 Do
        (FServerConnections[i] as TIdContext).Connection.Disconnect;
    Finally
      FLock.Leave;
    End;
  End
  Else
    FClientThread.FClient.Disconnect;
end;

procedure TIdHL7.CheckServerParameters;
begin
  assert(Assigned(Self));
  if (FCommunicationMode = cmAsynchronous) or not FIsListener then
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
  i : integer;
  d : LongWord;
begin
  assert(Assigned(Self));
  CheckServerParameters;
  FServer := TIdTCPServer.Create(NIL);
  try
    FServer.DefaultPort := FPort;
    Fserver.OnConnect := ServerConnect;
    FServer.OnExecute := ServerExecute;
    FServer.OnDisconnect := ServerDisconnect;
    FServer.Active := True;
    if FKeepAlive.UseKeepAlive Then
    Begin
      d := $FFFFFFFF;
      for i := 0 to FServer.Bindings.count - 1 Do
        FServer.Bindings[i].SetKeepAliveValues(FKeepAlive.UseKeepAlive, FKeepAlive.IdleTimeMS, FKeepAlive.IntervalMS);
    End;
    InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
  except
    on e:
    Exception do
      begin
      InternalSetStatus(IsStopped, IndyFormat(RSHL7StatusFailedToStart, [e.message]));
      FreeAndNil(FServer);
      raise;
      end;
    end;
end;

procedure TIdHL7.StopServer;
begin
  assert(Assigned(Self));
  try
    FServer.Active := False;
    FreeAndNil(FServer);
    InternalSetStatus(IsStopped, RSHL7StatusStopped);
  except
    on e:
    Exception do
      begin
      // somewhat arbitrary decision: if for some reason we fail to shutdown,
      // we will stubbornly refuse to work again.
      InternalSetStatus(IsUnusable, IndyFormat(RSHL7StatusFailedToStop, [e.message]));
      FServer := NIL;
      raise
      end;
    end;
end;

procedure TIdHL7.ServerConnect(AThread: TIdContext);
var
  LNotify : Boolean;
  LConnCount : integer;
  LValid : Boolean;
  sIp : String;
  iIp : LongWord;
begin
  assert(Assigned(Self));
  Assert(Assigned(AThread));
  assert(Assigned(AThread.Connection));
  assert(Assigned(AThread.Connection.Socket));
  assert(Assigned(FLock));
  LConnCount := 0;
  sIp := AThread.Connection.Socket.Binding.PeerIP;
  iIp := IdGlobal.IPv4ToUInt32(sIp);
  If (iIp Xor FIPRestrictionVal) And FIPMaskVal <> 0 Then
    raise exception.Create('Denied');
  
  FLock.Enter;
  try
    LNotify := FConnCount = 0;
    LValid := FConnCount < FConnectionLimit;
    If LValid Then
    Begin
      If (FConnCount = 0) Then
      Begin
        FServerConn := AThread.Connection
      End
      Else
      Begin
        FServerConn := Nil;
      End;
      FServerConnections.Add(AThread);
      If LNotify Then
      Begin
        InternalSetStatus(IsConnected, RSHL7StatusConnected);
      End;
    inc(FConnCount);
      LConnCount := FConnCount;
          AThread.Data := Self;
    End;
  Finally
    FLock.Leave;
  End;

  if LValid then
    begin
    if LNotify and Assigned(FOnConnect) then
      begin
      FOnConnect(self);
      end;
    if Assigned(FOnConnCountChange) and (FConnectionLimit <> 1) then
      begin
      FOnConnCountChange(Self, LConnCount);
      end;
    end
  else
    begin
    // Thread exceeds connection limit
    // it would be better to stop getting here in the case of an invalid connection
    // cause here we drop it - nasty for the client. To be investigated later
    AThread.Connection.Disconnect;
    AThread.Data := nil;
    End;
end;

procedure TIdHL7.ServerDisconnect(AThread: TIdContext);
var
  LNotify: Boolean;
  LConnCount : integer;
  LIndex : Integer;
begin
  assert(Assigned(Self));
  Assert(Assigned(AThread));
  //assert(Assigned(AContext));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    if (AThread.Data <> nil) Then
		dec(FConnCount);
    AThread.Data := nil;
    LNotify := FConnCount = 0;
    LConnCount := FConnCount;
    LIndex := FServerConnections.IndexOf(AThread);
    if LIndex <> -1 Then
      FServerConnections.Delete(LIndex);

    If AThread.Connection = FServerConn Then
      begin
      FServerConn := NIL;
      end;
    if LNotify then
      begin
      InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
      end;
  finally
    FLock.Leave;
    end;
  if Assigned(FOnConnCountChange)  and (FConnectionLimit <> 1) then
    begin
    FOnConnCountChange(Self, LConnCount);
    end;
  if LNotify and Assigned(FOnDisconnect) then
    begin
    FOnDisconnect(self);
    end;
end;

procedure TIdHL7.ServerExecute(AThread: TIdContext);
var
  s : String;
begin
  assert(Assigned(Self));
 // assert(Assigned(AContext));
  assert(Assigned(AThread));

  try
    // 1. prompt the network for content.
//    AThread.Connection.IOHandler.ReadLn(MSG_START); // throw this content away
    while Assigned(AThread.Connection.IOHandler) do
      begin
      // here, we use AnsiEncoding - whatever the bytes that are sent, they will be round tripped into a
      // ansi string which is actually bytes not chars. But usually it would be chars anyway
      //s := String(AThread.Connection.IOHandler.ReadLn(MSG_END, FReceiveTimeout, -1, TEncoding.ANSI));
      s := s + char(AThread.Connection.IOHandler.ReadByte);
      if length(s) > 0 then
        begin
        HandleIncoming(s, AThread.Connection);
        end;
      end;
  except
    try
      // well, there was some network error. We aren't sure what it
      // was, and it doesn't matter for this layer. we're just going
      // to make sure that we start again.
      // to review: what happens to the error messages?
      AThread.Connection.Disconnect;
    except
    end;
  end;
End;


procedure TIdHL7.DropServerConnection;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    if Assigned(FServerConn) then
      FServerConn.Disconnect;
  finally
    FLock.Leave;
    end;
end;


{==========================================================
  Client Connection Maintainance
 ==========================================================}

procedure TIdHL7.CheckClientParameters;
begin
  assert(Assigned(Self));
  if (FPort < 1) then
    begin
    raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7InvalidPort, [FPort]));
    end;
end;

procedure TIdHL7.StartClient;
begin
  assert(Assigned(Self));
  CheckClientParameters;
  FClientThread := TIdHL7ClientThread.Create(self);
  InternalSetStatus(isConnecting, RSHL7StatusConnecting);
end;

procedure TIdHL7.StopClient;
var
  LFinished: Boolean;
//  LWaitStop: LongWord;
  LStartTime : LongWord;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
	  If Assigned(FClientThread) Then
	  Begin

		FClientThread.Terminate;
		FClientThread.FClient.Disconnect;
		FClientThread.FCloseEvent.SetEvent;
      End
    Else
      InternalSetStatus(isStopped, 'Stopped');
  finally
    FLock.Leave;
    end;
  LStartTime :=  IdGlobal.Ticks();
//  LWaitStop := Ticks + 5000;
  repeat
    LFinished := (GetStatus = IsStopped);
    if not LFinished then
      begin
      IndySleep(10);
      end;
  Until LFinished Or (GetTickDiff(LStartTime, IdGlobal.Ticks()) > WAIT_STOP);
  if GetStatus <> IsStopped then
    begin
    // for some reason the client failed to shutdown. We will stubbornly refuse to work again
    InternalSetStatus(IsUnusable, IndyFormat(RSHL7StatusFailedToStop, [RSHL7ClientThreadNotStopped]));
    end;
end;


procedure TIdHL7.DropClientConnection;
begin
  assert(Assigned(Self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    if Assigned(FClientThread) and Assigned(FClientThread.FClient) then
      begin
      FClientThread.FClient.Disconnect;
      end
    else
      begin
      // This may happen validly because both ends are trying to drop the connection simultaineously
      end;
  finally
    FLock.Leave;
    end;
end;

{ TIdHL7ClientThread }

constructor TIdHL7ClientThread.Create(aOwner: TIdHL7);
begin
  assert(Assigned(AOwner));
  FOwner := aOwner;
  FCloseEvent := TIdLocalEvent.Create(True, False);
  inherited Create(False);
  FreeOnTerminate := True;
end;

destructor TIdHL7ClientThread.Destroy;
begin
  assert(Assigned(Self));
  assert(Assigned(FOwner));
  assert(Assigned(FOwner.FLock));
  FreeAndNil(FCloseEvent);
  try
    FOwner.FLock.Enter;
    try
      FOwner.FClientThread := NIL;
      If Not TimedOut Then
		FOwner.InternalSetStatus(isStopped, RSHL7StatusStopped);
    finally
      FOwner.FLock.Leave;
      end;
  except
    // it's really vaguely possible that the owner
    // may be dead before we are. If that is the case, we blow up here.
    // who cares.
    end;
  inherited;
end;

procedure TIdHL7ClientThread.PollStack;
var
  LBuffer: String;
begin
  assert(Assigned(Self));
  LBuffer := '';
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
			LBuffer := LBuffer + char(FClient.IOHandler.ReadByte);
			if LBuffer <> '' then
			  begin
			  FOwner.HandleIncoming(LBuffer, FClient);
			  end;
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
  until Terminated or not FClient.Connected;
end;

const
  MINUTE_LENGTH = 1 / (24 * 60);
  SECOND_LENGTH = MINUTE_LENGTH / 60;

function DescribePeriod(Period: TDateTime): String;
begin
  if period < 0 then
    period := -period;
  if Period < SECOND_LENGTH then
    Result := IntToStr(trunc(Period * 1000 / SECOND_LENGTH)) + 'ms'
  else if Period < 180 * SECOND_LENGTH then
    Result := IntToStr(trunc(Period / SECOND_LENGTH)) + 'sec'
  else if Period < 180 * MINUTE_LENGTH then
    Result := IntToStr(trunc(Period / MINUTE_LENGTH)) + 'min'
  else if Period < 72 * 60 * MINUTE_LENGTH then
    Result := IntToStr(trunc(Period / (MINUTE_LENGTH * 60))) + 'hr'
  else
    Result := IntToStr(trunc(Period)) + ' days';
end;

procedure TIdHL7ClientThread.Execute;
var
  LRecTime: TDateTime;
  d : LongWord;
begin
  assert(Assigned(Self));
  try
    FClient := TIdTCPClient.Create(NIL);
    try
      FClient.Host := FOwner.FAddress;
      FClient.Port := FOwner.FPort;
      repeat
        // try to connect. Try indefinitely but wait Owner.FReconnectDelay
        // between attempts. Problems: how long does Connect take?
        repeat
          FOwner.InternalSetStatus(IsConnecting, rsHL7StatusConnecting);
          try
            FClient.Connect;
            FClient.Socket.UseNagle := true;
            FLastTraffic := now;
          except
            on e:
            Exception do
              begin
              LRecTime := IncSecond(now,FOwner.FReconnectDelay);
              //not we can take more liberties with the time and date output because it's only
              //for human consumption (probably in a log
              FOwner.InternalSetStatus(IsWaitReconnect, IndyFormat(rsHL7StatusReConnect, [DescribePeriod(LRecTime - Now), e.message])); {do not localize??}

              end;
            end;
          if not Terminated and not FClient.Connected then
            begin
            FCloseEvent.WaitFor(FOwner.FReconnectDelay);
            end;
        until Terminated or FClient.Connected;
        if Terminated then
          begin
          exit;
          end;
        if FOwner.FKeepAlive.UseKeepAlive Then
        Begin
          d := $FFFFFFFF;
          FCLient.Socket.Binding.SetKeepAliveValues(FOwner.FKeepAlive.UseKeepAlive, FOwner.FKeepAlive.IdleTimeMS, FOwner.FKeepAlive.IntervalMS);
        End;

        FOwner.FLock.Enter;
        try
          FOwner.FClient := FClient;
          FOwner.InternalSetStatus(IsConnected, rsHL7StatusConnected);
        finally
          FOwner.FLock.Leave;
          end;
        if Assigned(FOwner.FOnConnect) then
          begin
          FOwner.FOnConnect(FOwner);
          end;
        try
          PollStack;
        finally
          FOwner.FLock.Enter;
          try
            FOwner.FClient := NIL;
            If TimedOut Then
              FOwner.InternalSetStatus(isTimedOut, RSHL7StatusTimedout)
            Else
            FOwner.InternalSetStatus(IsNotConnected, RSHL7StatusNotConnected);
          finally
            FOwner.FLock.Leave;
            end;
          if Assigned(FOwner.FOnDisconnect) then
            begin
            FOwner.FOnDisconnect(FOwner);
            end;
          end;
        If TimedOut Then
          Begin
          FClient.Disconnect;
          End
        Else If Not Terminated Then
          begin
          // we got disconnected. ReconnectDelay applies.
          LRecTime := IncSecond(now,FOwner.FReconnectDelay);
          FOwner.InternalSetStatus(IsWaitReconnect, Format(rsHL7StatusReConnect, [DescribePeriod(LRecTime - now), 'Disconnected'])); {do not localize??}
          FCloseEvent.WaitFor(FOwner.FReconnectDelay);
          end;
      Until Terminated Or (Not FOwner.IsListener And TimedOut);
    finally
      FreeAndNil(FClient);
      end;
  except
    on e:
    Exception do
      // presumably some comms or indy related exception
      // there's not really anyplace good to put this????
    end;
end;

{==========================================================
  Internal process management
 ==========================================================}

procedure TIdHL7.HandleIncoming(var VBuffer: String;
  AConnection: TIdTCPConnection);
var
  LStart, LEnd: Integer;
  LMsg, LReply : String;
  LBytes : TIdBytes;
  LString : String;
begin
  assert(Assigned(Self));
  Assert(Length(VBuffer) > 0, 'Attempt to handle an empty buffer'); {do not localize}
  
  assert(Assigned(AConnection));
  Try
    // process any messages in the buffer (may get more than one per packet)
    Repeat
      { use of Pos instead of Indypos is deliberate }
      LStart := Pos(MSG_START, VBuffer);
      LEnd := Pos(MSG_END, VBuffer);

      If (LStart > 0) And (LEnd > 0) Then
        Begin
        LMsg := Copy(VBuffer, LStart + Length(MSG_START), LEnd - (LStart + Length(MSG_START)));
        VBuffer := Copy(VBuffer, LEnd + Length(MSG_END), length(VBuffer) - (LEnd + Length(MSG_END)));
        If HandleMessage(LMsg, AConnection, LReply) Then
          Begin
          If Length(LReply) > 0 Then
            Begin
            LString := MSG_START + LReply + MSG_END;
            LBytes := ToBytes(LString, FDefSendEncoding) ;
            AConnection.IOHandler.Write(LBytes);
            End;
          End
        Else
          Begin
          AConnection.Disconnect;
          End;
        End
      Else if (LStart = -1) And (LEnd >= 0) Then
        VBuffer := Copy(VBuffer, LEnd + Length(MSG_END), length(VBuffer) - (LEnd + Length(MSG_END)));
    Until (LEnd = 0);
    If Length(VBuffer) > BUFFER_SIZE_LIMIT Then
      AConnection.Disconnect;

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
End;

function TIdHL7.HandleMessage(const AMsg: String; AConn: TIdTCPConnection;
  var VReply: String): Boolean;
var
  LQueMsg: TIdQueuedMessage;
  LIndex: Integer;
begin
  assert(Assigned(Self));
  assert(AMsg <> '', 'Attempt to handle an empty Message'); {do not localize}
  assert(Assigned(FLock));
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
        FOnMessageArrive(self, AConn, Amsg);
        end;
      cmSynchronous, cmSingleThread:
        begin
        if IsListener then
          begin
          if FCommunicationMode = cmSynchronous then
            begin
            Result := False;
            FOnReceiveMessage(self, AConn, AMsg, Result, VReply)
            end
          else
            begin
            LQueMsg := TIdQueuedMessage.Create(AMsg, FReceiveTimeout);
            LQueMsg._AddRef;
            try
              FLock.Enter;
              try
                FMsgQueue.Add(LQueMsg);
              finally
                FLock.Leave;
                end;
              LQueMsg.wait;
              // no locking. There is potential problems here. To be reviewed
              VReply := LQueMsg.FReply;
            finally
              FLock.Enter;
              try
                LIndex := FMsgQueue.IndexOf(LQueMsg);
                if LIndex > -1 then
                  FMsgQueue.Delete(LIndex);
              finally
                FLock.Leave;
                end;
              LQueMsg._Release;
              end;
            end
          end
        else
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
                assert(Assigned(FWaitEvent));
                FWaitEvent.SetEvent;
                end;
              end
            else
              begin
              // we could have got here by timing out, but this is quite unlikely,
              // since the connection will be dropped in that case. We will report
              // this as a spurious message
              raise EHL7CommunicationError.Create(Name, RSHL7UnexpectedMessage);
              end;
          finally
            FLock.Leave;
            end;
          end
        end;
      else
        begin
        raise EHL7CommunicationError.Create(Name, RSHL7UnknownMode);
        end;
      end;
  except
    on e:
    Exception do
      if Assigned(FOnReceiveError) then
        begin
        FOnReceiveError(self, AConn, AMsg, e, VReply, Result)
        end
    else
      begin
      Result := False;
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

function TIdHL7.AsynchronousSend(AMsg: String): TSendResponse;
var
  LBytes : TIdBytes;
  LString : String;
begin
  assert(Assigned(self));
  assert(AMsg <> '', 'Attempt to send an empty message'); {do not localize}
  assert(Assigned(FLock));
  Result := srNone; // just to suppress the compiler warning
  If GetStatus = isTimedOut Then
    Begin
    ReConnectFromTimeout;
    End;
  FLock.Enter;
  try
    if not Going then
      begin
      raise EHL7CommunicationError.Create(Name, IndyFormat(RSHL7NotWorking, [RSHL7SendMessage]))
      end
    else if GetStatus <> isConnected then
      begin
      Result := srNoConnection
      end
    else
      begin
      if FIsServer then
        begin
        if Assigned(FServerConn) then
          begin
          LString := MSG_START + AMsg + MSG_END;
          LBytes := ToBytes(LString, FDefSendEncoding) ;
          FServerConn.IOHandler.Write(LBytes);
          Result := srSent
          end
        else
          begin
          raise EHL7CommunicationError.Create(Name, RSHL7NoConnectionFound);
          end
        end
      else
        begin
        LString := MSG_START + AMsg + MSG_END;
        LBytes := ToBytes(LString, FDefSendEncoding) ;
        FClient.IOHandler.Write(LBytes);
        FClientThread.FLastTraffic := Now;
        Result := srSent
        end;
      end;
  finally
    FLock.Leave;
    end
end;

function TIdHL7.SynchronousSend(AMsg: String; var VReply: String
  ): TSendResponse;
begin
  assert(Assigned(self));
  assert(AMsg <> '', 'Attempt to send an empty message'); {do not localize}
  assert(Assigned(FLock));
  Result := srError;
  FLock.Enter;
  try
    FWaitingForAnswer := True;
    FWaitStop := Now + (FTimeOut * MILLISECOND_LENGTH);
    FReplyResponse := srTimeout;
    FMsgReply := '';
  finally
    FLock.Leave;
    end;
  try
    Result := AsynchronousSend(AMsg);
    if Result = srSent then
      begin
      assert(Assigned(FWaitEvent));
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
        if FIsServer then
          DropServerConnection
        else
          DropClientConnection;
        end;
      VReply := FMsgReply;
    finally
      FLock.Leave;
      end;
    end;
end;

procedure TIdHL7.SendMessage(AMsg: String);
begin
  assert(Assigned(self));
  //assert(AMsg <> '', 'Attempt to send an empty message'); {do not localize}
    Assert(Length(AMsg) > 0, 'Attempt to send an empty message');

  assert(Assigned(FLock));
  if FWaitingForAnswer then
    raise EHL7CommunicationError.Create(Name, RSHL7WaitForAnswer);

  FLock.Enter;
  try
    FWaitingForAnswer := True;
    FWaitStop := Now + (FTimeOut * MILLISECOND_LENGTH);
    FMsgReply := '';
    FReplyResponse := AsynchronousSend(AMsg);
  finally
    FLock.Leave;
  end;
end;

function TIdHL7.GetReply(var VReply: String): TSendResponse;
	begin
  assert(Assigned(self));
  assert(Assigned(FLock));
  FLock.Enter;
  try
    if FWaitingForAnswer then
      begin
      if FWaitStop < Now then
        begin
        Result := srTimeout;
        VReply := '';
        FWaitingForAnswer := False;
        FReplyResponse := srError;
        end
      else
        begin
        Result := srNone;
        end;
      end
    else
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

function TIdHL7.GetMessage(var VMsg: String): pointer;
begin
  assert(Assigned(self));
  assert(Assigned(FLock));
  assert(Assigned(FMsgQueue));
  FLock.Enter;
  try
    if FMsgQueue.Count = 0 then
      begin
      Result := NIL;
      end
    else
      begin
      Result := FMsgQueue[0];
      TIdQueuedMessage(Result)._AddRef;
      VMsg := TIdQueuedMessage(Result).FMsg;
      FMsgQueue.Delete(0);
      FHndMsgQueue.Add(Result);
      end;
  finally
    FLock.Leave;
    end;
end;

procedure TIdHL7.SendReply(AMsgHnd: pointer; AReply: String);
var
  qm: TIdQueuedMessage;
begin
  assert(Assigned(self));
  assert(Assigned(AMsgHnd));
//  assert(AReply <> '', 'Attempt to send an empty reply'); {do not localize}
  Assert(Length(AReply) > 0, 'Attempt to send an empty reply'); {do not localize}
  assert(Assigned(FLock));
  FLock.Enter;
  try
    qm := TObject(AMsgHnd) As TIdQueuedMessage;
    qm.FReply := AReply;
    qm.FEvent.SetEvent;
    qm._Release;
    FHndMsgQueue.Delete(FHndMsgQueue.IndexOf(AMsgHnd));
  finally
    FLock.Leave;
    end;
 //qm.FEvent.SetEvent;
end;

Function TIdHL7ClientThread.TimedOut: Boolean;
Var
  lGap : TDateTime;
Begin
  lGap := SecondOf(now - FLastTraffic)  * 1000;
  Result := (FOwner.FConnectionTimeout > 0) And ( lGap > FOwner.FConnectionTimeout);
End;


end.
