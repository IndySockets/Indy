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
  Rev 1.1    12/7/2002 06:43:42 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.


  Rev 1.0    11/13/2002 08:03:54 AM  JPMugaas
}

unit IdTunnelMaster;

interface
{$i IdCompilerDefines.inc}

uses
  Classes, SyncObjs,
  IdTCPServer, IdTCPClient, IdTunnelCommon;

type
  TIdTunnelMaster = class;

  ///////////////////////////////////////////////////////////////////////////////
  // Master Tunnel classes
  //
  // Thread to communicate with the service
  MClientThread = class(TThread)
  public
    MasterParent: TIdTunnelMaster;
    UserId: Integer;
    MasterThread: TIdPeerThread;
    OutboundClient: TIdTCPClient;
    DisconnectedOnRequest: Boolean;
    Locker: TCriticalSection;
    SelfDisconnected: Boolean;

    procedure Execute; override;
    constructor Create(AMaster: TIdTunnelMaster);
    destructor Destroy; override;
  end;

  // Slave thread - communicates with the Master, tunnel
  TSlaveData = class(TObject)
  public
    Receiver: TReceiver;
    Sender: TSender;
    Locker: TCriticalSection;
    SelfDisconnected: Boolean;
    UserData: TObject;
  end;

  TIdSendMsgEvent  = procedure(Thread: TIdPeerThread; var CustomMsg: String) of object;
  TIdSendTrnEvent  = procedure(Thread: TIdPeerThread; var Header: TIdHeader; var CustomMsg: String) of object;
  TIdSendTrnEventC = procedure(var Header: TIdHeader; var CustomMsg: String) of object;
  TIdTunnelEventC  = procedure(Receiver: TReceiver) of object;
  TIdSendMsgEventC = procedure(var CustomMsg: String) of object;
//  TTunnelEvent   = procedure(Thread: TSlaveThread) of object;

  TIdTunnelMaster = class(TIdTCPServer)
  protected
    fiMappedPort: Integer;
    fsMappedHost: String;
    Clients: TThreadList;
    fOnConnect,
    fOnDisconnect,
    fOnTransformRead: TIdServerThreadEvent;
    fOnTransformSend: TSendTrnEvent;
    fOnInterpretMsg: TSendMsgEvent;
    OnlyOneThread: TCriticalSection;

    // LockSlavesNumber: TCriticalSection;
    //LockServicesNumber: TCriticalSection;
    StatisticsLocker: TCriticalSection;
    fbActive: Boolean;
    fbLockDestinationHost: Boolean;
    fbLockDestinationPort: Boolean;
    fLogger: TLogger;

    // Statistics counters
    flConnectedSlaves,            // Number of connected slave tunnels
    flConnectedServices,          // Number of connected service threads
    fNumberOfConnectionsValue,
    fNumberOfPacketsValue,
    fCompressionRatioValue,
    fCompressedBytes,
    fBytesRead,
    fBytesWrite: Integer;
    procedure ClientOperation(Operation: Integer; UserId: Integer; s: String);
    procedure SendMsg(MasterThread: TIdPeerThread; var Header: TIdHeader; s: String);
    procedure DisconectAllUsers;
    procedure DisconnectAllSubThreads(TunnelThread: TIdPeerThread);
    function  GetNumSlaves: Integer;
    function  GetNumServices: Integer;
    function GetClientThread(UserID: Integer): MClientThread;
    procedure SetActive(pbValue: Boolean); override;
    procedure DoConnect(Thread: TIdPeerThread); override;
    procedure DoDisconnect(Thread: TIdPeerThread); override;
    function DoExecute(Thread: TIdPeerThread): boolean; override;
    procedure DoTransformRead(Thread: TIdPeerThread); virtual;
    procedure DoTransformSend(Thread: TIdPeerThread; var Header: TIdHeader; var CustomMsg: String);
     virtual;
    procedure DoInterpretMsg(Thread: TIdPeerThread; var CustomMsg: String); virtual;
    procedure LogEvent(Msg: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetStatistics(Module: Integer; Value: Integer);
    procedure GetStatistics(Module: Integer; var Value: Integer);

    property Active: Boolean read FbActive write SetActive Default True;
    property Logger: TLogger read fLogger write fLogger;
    property NumSlaves: Integer read GetNumSlaves;
    property NumServices: Integer read GetNumServices;
  published
    property MappedHost: string read fsMappedHost write fsMappedHost;
    property MappedPort: Integer read fiMappedPort write fiMappedPort;
    property LockDestinationHost: Boolean read fbLockDestinationHost write fbLockDestinationHost
     default False;
    property LockDestinationPort: Boolean read fbLockDestinationPort write fbLockDestinationPort
     default False;
    property OnConnect: TIdServerThreadEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TIdServerThreadEvent read FOnDisconnect write FOnDisconnect;
    property OnTransformRead: TIdServerThreadEvent read fOnTransformRead write fOnTransformRead;
    property OnTransformSend: TSendTrnEvent read fOnTransformSend write fOnTransformSend;
    property OnInterpretMsg: TSendMsgEvent read fOnInterpretMsg write fOnInterpretMsg;
  end;
  //
  // END Master Tunnel classes
  ///////////////////////////////////////////////////////////////////////////////


implementation
  uses IdCoreGlobal, IdException,
       IdGlobal, IdStack, IdResourceStrings, SysUtils;


///////////////////////////////////////////////////////////////////////////////
// Master Tunnel classes
//
constructor TIdTunnelMaster.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Clients := TThreadList.Create;

  fbActive := False;
  flConnectedSlaves := 0;
  flConnectedServices := 0;

  fNumberOfConnectionsValue := 0;
  fNumberOfPacketsValue := 0;
  fCompressionRatioValue := 0;
  fCompressedBytes := 0;
  fBytesRead := 0;
  fBytesWrite := 0;

  OnlyOneThread := TCriticalSection.Create;
  StatisticsLocker := TCriticalSection.Create;
end;

destructor TIdTunnelMaster.Destroy;
begin
  Logger := nil;
  Active := False;
  if (csDesigning in ComponentState) then begin
    DisconectAllUsers; // disconnects service threads
  end;

  FreeAndNil(Clients);
  FreeAndNil(OnlyOneThread);
  FreeAndNil(StatisticsLocker);

  inherited Destroy;
end;


procedure TIdTunnelMaster.SetActive(pbValue: Boolean);
begin
  if fbActive = pbValue then
    exit;

//  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
  if pbValue then begin
    inherited SetActive(True);
  end
  else begin
    inherited SetActive(False);
    DisconectAllUsers; // also disconnectes service threads
  end;

//  end;
  fbActive := pbValue;
end;

procedure TIdTunnelMaster.LogEvent(Msg: String);
begin
  if Assigned(fLogger) then
    fLogger.LogEvent(Msg);
end;

function TIdTunnelMaster.GetNumSlaves: Integer;
var
  ClientsNo: Integer;
begin
  GetStatistics(NumberOfSlavesType, ClientsNo);
  Result := ClientsNo;
end;

function TIdTunnelMaster.GetNumServices: Integer;
var
  ClientsNo: Integer;
begin
  GetStatistics(NumberOfServicesType, ClientsNo);
  Result := ClientsNo;
end;

procedure TIdTunnelMaster.GetStatistics(Module: Integer; var Value: Integer);
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfSlavesType: begin
         Value := flConnectedSlaves;
      end;

      NumberOfServicesType: begin
         Value := flConnectedServices;
      end;

      NumberOfConnectionsType: begin
        Value := fNumberOfConnectionsValue;
      end;

      NumberOfPacketsType: begin
        Value := fNumberOfPacketsValue;
      end;

      CompressionRatioType: begin
        if fCompressedBytes > 0 then begin
          Value := Trunc((fBytesRead * 1.0) / (fCompressedBytes * 1.0) * 100.0)
        end
        else begin
          Value := 0;
        end;
      end;

      CompressedBytesType: begin
         Value := fCompressedBytes;
      end;

      BytesReadType: begin
         Value := fBytesRead;
      end;

      BytesWriteType: begin
         Value := fBytesWrite;
      end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;

procedure TIdTunnelMaster.SetStatistics(Module: Integer; Value: Integer);
var
  packets: Real;
  ratio: Real;
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfSlavesType: begin
        if TIdStatisticsOperation(Value) = soIncrease then begin
          Inc(flConnectedSlaves);
        end
        else begin
          Dec(flConnectedSlaves);
        end;
      end;

      NumberOfServicesType: begin
        if TIdStatisticsOperation(Value) = soIncrease then begin
          Inc(flConnectedServices);
          Inc(fNumberOfConnectionsValue);
        end
        else begin
          Dec(flConnectedServices);
        end;
      end;

      NumberOfConnectionsType: begin
        Inc(fNumberOfConnectionsValue);
      end;

      NumberOfPacketsType: begin
        Inc(fNumberOfPacketsValue);
      end;

      CompressionRatioType: begin
        ratio := fCompressionRatioValue;
        packets := fNumberOfPacketsValue;
        ratio := (ratio/100.0 * (packets - 1.0) + Value/100.0) / packets;
        fCompressionRatioValue := Trunc(ratio * 100);
      end;

      CompressedBytesType: begin
        fCompressedBytes := fCompressedBytes + Value;
      end;

      BytesReadType: begin
        fBytesRead := fBytesRead + Value;
      end;

      BytesWriteType: begin
        fBytesWrite := fBytesWrite + Value;
      end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;

procedure TIdTunnelMaster.DoConnect(Thread: TIdPeerThread);
begin

  Thread.Data := TSlaveData.Create;
  with TSlaveData(Thread.Data) do begin
    Receiver := TReceiver.Create;
    Sender := TSender.Create;
    SelfDisconnected := False;
    Locker := TCriticalSection.Create;
  end;
  if Assigned(OnConnect) then begin
    OnConnect(Thread);
  end;
  SetStatistics(NumberOfSlavesType, Integer(soIncrease));

end;


procedure TIdTunnelMaster.DoDisconnect(Thread: TIdPeerThread);
begin

  SetStatistics(NumberOfSlavesType, Integer(soDecrease));
  // disconnect all service threads, owned by this tunnel
  DisconnectAllSubThreads(Thread);
  if Thread.Connection.Connected then
    Thread.Connection.Disconnect;

  If Assigned(OnDisconnect) then begin
    OnDisconnect(Thread);
  end;

  with TSlaveData(Thread.Data) do begin
    Receiver.Free;
    Sender.Free;
    Locker.Free;
    TSlaveData(Thread.Data).Free;
  end;
  Thread.Data := nil;

end;


function TIdTunnelMaster.DoExecute(Thread: TIdPeerThread): boolean;
var
  user: TSlaveData;
  clientThread: MClientThread;
  s: String;
  ErrorConnecting: Boolean;
  sIP: String;
  CustomMsg: String;
  Header: TIdHeader;
begin
  result := true;

  user := TSlaveData(Thread.Data);
  if Thread.Connection.IOHandler.Readable(IdTimeoutInfinite) then  begin
    user.receiver.Data := Thread.Connection.CurrentReadBuffer;

    // increase the packets counter
    SetStatistics(NumberOfPacketsType, 0);

    while user.receiver.TypeDetected do begin
      // security filter
      if not (user.receiver.Header.MsgType in [tmData, tmDisconnect, tmConnect, tmCustom]) then begin
        Thread.Connection.Disconnect;
        break;
      end;

      if user.receiver.NewMessage then begin
        if user.Receiver.CRCFailed then begin
          Thread.Connection.Disconnect;
          break;
        end;

        // Custom data transformation
        try
          DoTransformRead(Thread);
        except
          Thread.Connection.Disconnect;
          Break;
        end;



        // Action
        case user.Receiver.Header.MsgType of
          // transformation of data failed, disconnect the tunnel
          tmError: begin
            try
              Thread.Connection.Disconnect;
              break;
            except
              ;
            end;
          end; // Failure END


          // Data
          tmData: begin
            try
              SetString(s, user.Receiver.Msg, user.Receiver.MsgLen);
              {$IFDEF STRING_IS_ANSI}
              // TODO: do we need to use SetCodePage() here?
              {$ENDIF}
              ClientOperation(tmData, user.Receiver.Header.UserId, s);
            except
              ;
            end;
          end;  // Data END

          // Disconnect
          tmDisconnect: begin
            try
              ClientOperation(tmDisconnect, user.Receiver.Header.UserId, '');    {Do not Localize}
            except
              ;
            end;
          end;  // Disconnect END

          // Connect
          tmConnect: begin
            // Connection should be done synchroneusly
            // because more data could arrive before client
            // connects asyncroneusly
            try
              clientThread := MClientThread.Create(self);
              try
                ErrorConnecting := False;
                with clientThread do begin
                  UserId := user.Receiver.Header.UserId;
                  MasterThread := Thread;
                  OutboundClient := TIdTCPClient.Create(nil);
                  sIP := GStack.TInAddrToString(user.Receiver.Header.IpAddr);
                  if fbLockDestinationHost then begin
                    OutboundClient.Host := fsMappedHost;
                    if fbLockDestinationPort then
                      OutboundClient.Port := fiMappedPort
                    else
                      OutboundClient.Port := user.Receiver.Header.Port;
                  end
                  else begin
                    // do we tunnel all connections from the slave to the specified host
                    if sIP = '0.0.0.0' then begin    {Do not Localize}
                      OutboundClient.Host := fsMappedHost;
                      OutboundClient.Port := user.Receiver.Header.Port; //fiMappedPort;
                    end
                    else begin
                      OutboundClient.Host := sIP;
                      OutboundClient.Port := user.Receiver.Header.Port;
                    end;
                  end;
                  OutboundClient.Connect;
                end;
              except
                ErrorConnecting := True;
              end;
              if ErrorConnecting then begin
                clientThread.Destroy;
              end
              else begin
                clientThread.Resume;
              end;
            except
              ;
            end;

          end;  // Connect END

          // Custom data interpretation
          tmCustom: begin
            CustomMsg := '';    {Do not Localize}
            DoInterpretMsg(Thread, CustomMsg);
            if Length(CustomMsg) > 0 then begin
              Header.MsgType := tmCustom;
              Header.UserId := 0;
              SendMsg(Thread, Header, CustomMsg);
            end;
          end;

        end; // case

        // Shift of data
        user.Receiver.ShiftData;

      end
      else
        break;  // break the loop

    end; // end while
  end;  // readable
end;


procedure TIdTunnelMaster.DoTransformRead(Thread: TIdPeerThread);
begin

  if Assigned(fOnTransformRead) then
    fOnTransformRead(Thread);

end;

procedure TIdTunnelMaster.DoTransformSend(Thread: TIdPeerThread; var Header: TIdHeader; var CustomMsg: String);
begin

  if Assigned(fOnTransformSend) then
    fOnTransformSend(Thread, Header, CustomMsg);

end;

procedure TIdTunnelMaster.DoInterpretMsg(Thread: TIdPeerThread; var CustomMsg: String);
begin

  if Assigned(fOnInterpretMsg) then
    fOnInterpretMsg(Thread, CustomMsg);

end;


// Disconnect all services owned by tunnel thread
procedure TIdTunnelMaster.DisconnectAllSubThreads(TunnelThread: TIdPeerThread);
var
  Thread: MClientThread;
  i: integer;
  listTemp: TList;
begin

  OnlyOneThread.Enter; // for now it is done with locking
  listTemp := Clients.LockList;
  try
    for i := 0 to listTemp.count - 1 do begin
      if Assigned(listTemp[i]) then begin
        Thread := MClientThread(listTemp[i]);
        if Thread.MasterThread = TunnelThread then begin
          Thread.DisconnectedOnRequest := True;
          Thread.OutboundClient.Disconnect;
        end;
      end;
    end;
  finally
    Clients.UnlockList;
    OnlyOneThread.Leave;
  end;

end;


procedure TIdTunnelMaster.SendMsg(MasterThread: TIdPeerThread; var Header: TIdHeader; s: String);
var
  user: TSlaveData;
  tmpString: String;
begin

  if Assigned(MasterThread.Data) then begin


  TSlaveData(MasterThread.Data).Locker.Enter;
  try
    user := TSlaveData(MasterThread.Data);
    try
      // Custom data transformation before send
      tmpString := s;
      try
        DoTransformSend(MasterThread, Header, tmpString);
      except
        IndyRaiseOuterException(EIdTunnelTransformErrorBeforeSend.Create(RSTunnelTransformErrorBS));
      end;
      if Header.MsgType = tmError then begin // error ocured in transformation
        raise EIdTunnelTransformErrorBeforeSend.Create(RSTunnelTransformErrorBS);
      end;

      user.Sender.PrepareMsg(Header, PChar(tmpString), Length(tmpString));
      MasterThread.Connection.Write(user.Sender.Msg);
    except
      raise;
    end;
  finally
    TSlaveData(MasterThread.Data).Locker.Leave;
  end;


  end;
end;

function TIdTunnelMaster.GetClientThread(UserID: Integer): MClientThread;
var
  Thread: MClientThread;
  i: integer;
begin

  Result := nil;
  with Clients.LockList do
  try
    for i := 0 to Count-1 do begin
      try
        if Assigned(Items[i]) then begin
          Thread := MClientThread(Items[i]);
          if Thread.UserId = UserID then begin
            Result := Thread;
            break;
          end;
        end;
      except
        Result := nil;
      end;
    end;
  finally
    Clients.UnlockList;
  end;
end;


procedure TIdTunnelMaster.DisconectAllUsers;
begin
  TerminateAllThreads;
end;

procedure TIdTunnelMaster.ClientOperation(Operation: Integer; UserId: Integer; s: String);
var
  Thread: MClientThread;
begin
  Thread := GetClientThread(UserID);
  if Assigned(Thread) then begin
    Thread.Locker.Enter;
    try
      if not Thread.SelfDisconnected then begin
        case Operation of
          tmData: begin
            try
              Thread.OutboundClient.IOHandler.CheckForDisconnect;
              if Thread.OutboundClient.Connected then
                Thread.OutboundClient.Write(s);
            except
              try
                Thread.OutboundClient.Disconnect;
              except
                ;
              end;
            end;
          end;

          tmDisconnect: begin
            Thread.DisconnectedOnRequest := True;
            try
              Thread.OutboundClient.Disconnect;
            except
              ;
            end;
          end;
        end;
      end;
    finally
      Thread.Locker.Leave;
    end;
  end; // Assigned

end;


/////////////////////////////////////////////////////////////////
//
//  MClientThread thread, talks to the service
//
/////////////////////////////////////////////////////////////////
constructor MClientThread.Create(AMaster: TIdTunnelMaster);
begin
  MasterParent := AMaster;
  FreeOnTerminate := True;
  DisconnectedOnRequest := False;
  SelfDisconnected := False;
  Locker := TCriticalSection.Create;
  MasterParent.Clients.Add(self);
  AMaster.SetStatistics(NumberOfServicesType, Integer(soIncrease));

  inherited Create(True);
end;

destructor MClientThread.Destroy;
var
  Header: TIdHeader;
begin
  MasterParent.SetStatistics(NumberOfServicesType, Integer(soDecrease));

  MasterParent.Clients.Remove(self);
  try
    if not DisconnectedOnRequest then begin
     // service disconnected the thread
     try
       Header.MsgType := tmDisconnect;
       Header.UserId := UserId;
       MasterParent.SendMsg(MasterThread, Header, RSTunnelDisconnectMsg);
     except 
     end;
    end;

    if OutboundClient.Connected then
    begin
      OutboundClient.Disconnect;
    end;
  except
  end;

  MasterThread := nil;

  try
    OutboundClient.Free;
  except
  end;

  Locker.Free;
  Terminate; // dodano

  inherited Destroy;
end;

// thread which talks to the service
procedure MClientThread.Execute;
var
  s: String;
  Header: TIdHeader;
begin
  try
    while not Terminated do begin
      if OutboundClient.Connected then begin
        if OutboundClient.IOHandler.Readable(IdTimeoutInfinite) then  begin
          s := OutboundClient.CurrentReadBuffer;
          try
            Header.MsgType := tmData;
            Header.UserId := UserId;
            MasterParent.SendMsg(MasterThread, Header, s);
          except
            Terminate;
            break;
          end;
        end;
      end
      else begin
        Terminate;
        break;
      end;

    end;
  except
    ;
  end;

  Locker.Enter;
  try
    SelfDisconnected := True;
  finally
    Locker.Leave;
  end;
end;

end.
