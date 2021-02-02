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
  Rev 1.1    12/7/2002 06:43:48 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.


  Rev 1.0    11/13/2002 08:04:00 AM  JPMugaas
}

unit IdTunnelSlave;

interface

{$i IdCompilerDefines.inc}

uses
  SysUtils, Classes, SyncObjs,
  IdTunnelCommon, IdTCPServer, IdTCPClient,
  IdGlobal, IdStack, IdResourceStrings,
  IdThread, IdComponent, IdTCPConnection;

type
  TSlaveThread = class;
  TIdTunnelSlave = class;

  TTunnelEvent   = procedure(Thread: TSlaveThread) of object;

  ///////////////////////////////////////////////////////////////////////////////
  // Slave Tunnel classes
  //
  // Client data structure
  TClientData = class
  public
    Id: Integer;
    TimeOfConnection: TDateTime;
    DisconnectedOnRequest: Boolean;
    SelfDisconnected: Boolean;
    ClientAuthorised: Boolean;
    Locker: TCriticalSection;
    Port: Word;
    IpAddr: TIdInAddr;
    constructor Create;
    destructor Destroy; override;
  end;

  // Slave thread - tunnel thread to communicate with Master
  TSlaveThread = class(TIdThread)
  private
    FLock: TCriticalSection;
    FExecuted: Boolean;
    FConnection: TIdTCPClient;
  protected
    procedure SetExecuted(Value: Boolean);
    function  GetExecuted: Boolean;
    procedure AfterRun; override;
    procedure BeforeRun; override;
  public
    SlaveParent: TIdTunnelSlave;
    Receiver: TReceiver;
    property Executed: Boolean read GetExecuted write SetExecuted;
    property Connection: TIdTCPClient read fConnection;
    constructor Create(Slave: TIdTunnelSlave); reintroduce;
    destructor Destroy; override;
    procedure Execute; override;
    procedure Run; override;
  end;

//  TTunnelEvent   = procedure(Thread: TSlaveThread) of object;

  TIdTunnelSlave = class(TIdTCPServer)
  private
    fiMasterPort: Integer; // Port on which Master Tunnel accepts connections
    fsMasterHost: String; // Address of the Master Tunnel
    SClient: TIdTCPClient; // Client which talks to the Master Tunnel
//    fOnExecute, fOnConnect,
    fOnDisconnect: TIdServerThreadEvent;
    fOnStatus: TIdStatusEvent;
    fOnBeforeTunnelConnect: TSendTrnEventC;
    fOnTransformRead: TTunnelEventC;
    fOnInterpretMsg: TSendMsgEventC;
    fOnTransformSend: TSendTrnEventC;
    fOnTunnelDisconnect: TTunnelEvent;

    Sender: TSender; // Communication class
    OnlyOneThread: TCriticalSection; // Some locking code
    SendThroughTunnelLock: TCriticalSection; // Some locking code
    GetClientThreadLock: TCriticalSection; // Some locking code
//    LockClientNumber: TCriticalSection;
    StatisticsLocker: TCriticalSection;
    ManualDisconnected: Boolean;  // We trigered the disconnection
    StopTransmiting: Boolean;
    fbActive: Boolean;
    fbSocketize: Boolean;
    SlaveThread: TSlaveThread; // Thread which receives data from the Master
    fLogger: TLogger;

    // Statistics counters
    flConnectedClients,        // Number of connected clients
    fNumberOfConnectionsValue,
    fNumberOfPacketsValue,
    fCompressionRatioValue,
    fCompressedBytes,
    fBytesRead,
    fBytesWrite: Integer;

    SlaveThreadTerminated: Boolean;

    procedure SendMsg(var Header: TIdHeader; s: String);
    procedure ClientOperation(Operation: Integer; UserId: Integer; s: String);
    procedure DisconectAllUsers;
    //procedure DoStatus(Sender: TComponent; const sMsg: String);
    function GetNumClients: Integer;
    procedure TerminateTunnelThread;
    function GetClientThread(UserID: Integer): TIdPeerThread;
    procedure OnTunnelThreadTerminate(Sender: TObject);
  protected
    fbAcceptConnections: Boolean; // status if we accept new connections
                                  // it is used with tunnels with some athentication
                                  // procedure between slave and master tunnel

    procedure DoConnect(Thread: TIdPeerThread); override;
    procedure DoDisconnect(Thread: TIdPeerThread); override;
    function DoExecute(Thread: TIdPeerThread): boolean; override;
    procedure DoBeforeTunnelConnect(var Header: TIdHeader; var CustomMsg: String); virtual;
    procedure DoTransformRead(Receiver: TReceiver); virtual;
    procedure DoInterpretMsg(var CustomMsg: String); virtual;
    procedure DoTransformSend(var Header: TIdHeader; var CustomMsg: String); virtual;
    procedure DoStatus(Sender: TComponent; const sMsg: String); virtual;
    procedure DoTunnelDisconnect(Thread: TSlaveThread); virtual;
    procedure LogEvent(Msg: String);
    procedure SetActive(pbValue: Boolean); override;
  public
    procedure SetStatistics(Module: Integer; Value: Integer);
    procedure GetStatistics(Module: Integer; var Value: Integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    property Active: Boolean read FbActive write SetActive;
    property Logger: TLogger read fLogger write fLogger;
    property NumClients: Integer read GetNumClients;
  published
    property MasterHost: string read fsMasterHost write fsMasterHost;
    property MasterPort: Integer read fiMasterPort write fiMasterPort;
    property Socks4: Boolean read fbSocketize write fbSocketize default False;
//    property OnConnect: TIdServerThreadEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TIdServerThreadEvent read FOnDisconnect write FOnDisconnect;
//    property OnExecute: TIdServerThreadEvent read FOnExecute write FOnExecute;
    property OnBeforeTunnelConnect: TSendTrnEventC read fOnBeforeTunnelConnect
                                                  write fOnBeforeTunnelConnect;
    property OnTransformRead: TTunnelEventC read fOnTransformRead
                                            write fOnTransformRead;
    property OnInterpretMsg: TSendMsgEventC read fOnInterpretMsg write fOnInterpretMsg;
    property OnTransformSend: TSendTrnEventC read fOnTransformSend write fOnTransformSend;
    property OnStatus: TIdStatusEvent read FOnStatus write FOnStatus;
    property OnTunnelDisconnect: TTunnelEvent read FOnTunnelDisconnect write FOnTunnelDisconnect;
  end;
  //
  // END Slave Tunnel classes
  ///////////////////////////////////////////////////////////////////////////////

implementation

uses
  IdCoreGlobal,
  IdException,
  IdSocks,
  IdThreadSafe;

Var
  GUniqueID: TIdThreadSafeInteger;

function GetNextID: Integer;
begin
  if Assigned(GUniqueID) then begin
    Result := GUniqueID.Increment;
  end
  else
    result := -1;
end;

///////////////////////////////////////////////////////////////////////////////
// Slave Tunnel classes
//
constructor TIdTunnelSlave.Create(AOwner: TComponent);
begin
  inherited;
  fbActive := False;
  flConnectedClients := 0;
  fNumberOfConnectionsValue := 0;
  fNumberOfPacketsValue := 0;
  fCompressionRatioValue := 0;
  fCompressedBytes := 0;
  fBytesRead := 0;
  fBytesWrite := 0;

  fbAcceptConnections := True;
  SlaveThreadTerminated := False;
  OnlyOneThread := TCriticalSection.Create;
  SendThroughTunnelLock := TCriticalSection.Create;
  GetClientThreadLock := TCriticalSection.Create;
//  LockClientNumber := TCriticalSection.Create;
  StatisticsLocker := TCriticalSection.Create;

  Sender := TSender.Create;
  SClient := TIdTCPClient.Create(nil);
// POZOR MOŽNA NAPAKA
//  SClient.OnStatus := self.DoStatus;  ORIGINAL
  SClient.OnStatus := self.OnStatus; // TODO: assign DoStatus() instead of the handler directly...

  ManualDisconnected := False;
  StopTransmiting := False;

end;


destructor TIdTunnelSlave.Destroy;
begin

  fbAcceptConnections := False;
  StopTransmiting := True;
  ManualDisconnected := True;

  Active := False;

//  DisconectAllUsers;

  try
    if SClient.Connected then begin
//      DisconnectedByServer := False;
      SClient.Disconnect;
    end;
  except
    ;
  end;

//  if Assigned(SlaveThread) then
//    if not SlaveThread.Executed then
//      SlaveThread.TerminateAndWaitFor;
  if not SlaveThreadTerminated then
    TerminateTunnelThread;

  FreeAndNil(SClient);
  FreeAndNil(Sender);
//  FreeAndNil(LockClientNumber);
  FreeAndNil(OnlyOneThread);
  FreeAndNil(SendThroughTunnelLock);
  FreeAndNil(GetClientThreadLock);
  FreeAndNil(StatisticsLocker);
  Logger := nil;

  inherited Destroy;
end;

procedure TIdTunnelSlave.LogEvent(Msg: String);
begin
  if Assigned(fLogger) then
    fLogger.LogEvent(Msg);
end;

procedure TIdTunnelSlave.DoStatus(Sender: TComponent; const sMsg: String);
begin
  if Assigned(OnStatus) then begin
    OnStatus(self, hsStatusText, sMsg);
  end;
end;

procedure TIdTunnelSlave.SetActive(pbValue: Boolean);
var
  ErrorConnecting: Boolean;
begin
  // Active = False gets called again by inherited destructor
  if OnlyOneThread = nil then begin
    exit;
  end;

  OnlyOneThread.Enter;
  try

    if fbActive = pbValue then begin
      exit;
    end;

  //  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then begin
      if pbValue then begin
  //      DisconnectedByServer := False;
        ManualDisconnected := False;
        StopTransmiting := False;
        ErrorConnecting := False;
        SClient.Host := fsMasterHost;
        SClient.Port := fiMasterPort;
        try
          SClient.Connect;
        except
          fbActive := False;
          IndyRaiseOuterException(EIdTunnelConnectToMasterFailed.Create(RSTunnelConnectToMasterFailed));
          //Exit;
        end;
        if not ErrorConnecting then begin
          SlaveThread := TSlaveThread.Create(self);
          SlaveThreadTerminated := False;
          SlaveThread.Start;
          // Maybe we wait here till authentication of Slave happens
          // here can happen the error if the port is already occupied
          // we must handle this
          try
            inherited SetActive(True);
            fbActive := True;
            fbAcceptConnections := True;
          except
            StopTransmiting := False;
            DisconectAllUsers;
            SClient.Disconnect;
            TerminateTunnelThread;
            fbActive := False;
          end;
        end;
      end
      else begin
        fbAcceptConnections := False;
        StopTransmiting := True;
        ManualDisconnected := True;
//        inherited Active := False;       // Cancel accepting new clients
        inherited SetActive(False);

        DisconectAllUsers;               // Disconnect existing ones
        SClient.Disconnect;
        TerminateTunnelThread;

        fbActive := pbValue;
      end;

  //  end;
    //fbActive := pbValue;

  finally
    OnlyOneThread.Leave;
  end;


end;

function TIdTunnelSlave.GetNumClients: Integer;
var
  ClientsNo: Integer;
begin
  GetStatistics(NumberOfClientsType, ClientsNo);
  Result := ClientsNo;
end;



procedure TIdTunnelSlave.SetStatistics(Module: Integer; Value: Integer);
var
  packets: Real;
  ratio: Real;
begin
  StatisticsLocker.Enter;
  try
    case Module of
      NumberOfClientsType: begin
        if TIdStatisticsOperation(Value) = soIncrease then begin
          Inc(flConnectedClients);
          Inc(fNumberOfConnectionsValue);
        end
        else begin
          Dec(flConnectedClients);
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

      BytesWriteType:  begin
          fBytesWrite := fBytesWrite + Value;
      end;
    end;
  finally
    StatisticsLocker.Leave;
  end;
end;


procedure TIdTunnelSlave.GetStatistics(Module: Integer; var Value: Integer);
begin
  StatisticsLocker.Enter;
  try
    case Module of

      NumberOfClientsType: begin
         Value := flConnectedClients;
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


////////////////////////////////////////////////////////////////
//
//  CLIENT SERVICES
//
////////////////////////////////////////////////////////////////
procedure TIdTunnelSlave.DoConnect(Thread: TIdPeerThread);
const
  MAXLINE=255;
var
  SID: Integer;
  s: String;
  req: TIdSocksRequest;
  res: TIdSocksResponse;
  numread: Integer;
  Header: TIdHeader;
begin

  if not fbAcceptConnections then begin
    Thread.Connection.Disconnect;
    // don't allow to enter in OnExecute    {Do not Localize}
    raise EIdTunnelDontAllowConnections.Create (RSTunnelDontAllowConnections);
  end;

  SetStatistics(NumberOfClientsType, Integer(soIncrease));

  Thread.Data := TClientData.Create;

  // Socket version begin
  if fbSocketize then begin
    try
      Thread.Connection.IOHandler.ReadBuffer(req, 8);
    except
      try
        Thread.Connection.Disconnect;
      except
        ;
      end;
      Thread.Terminate;
      Exit;
    end;

    numread := 0;
    repeat
      s := Thread.Connection.ReadString(1);
      req.UserName[numread+1] := s[1];
      Inc(numread);
    until ((numread >= MAXLINE) or (s[1] = #0));
    SetLength(req.UserName, numread);

    s := GStack.TInAddrToString(req.IpAddr);

    res.Version := 0;
    res.OpCode := 90;
    res.Port := req.Port;
    res.IpAddr := req.IpAddr;
    SetString(s, PChar(@res), SizeOf(res));
    {$IFDEF STRING_IS_ANSI}
    // TODO: do we need to use SetCodePage() here?
    {$ENDIF}
    Thread.Connection.Write(s);
  end;

  with TClientData(Thread.Data) do begin
    // Id := Thread.Handle;
    SID := Id;
    TimeOfConnection := Now;
    DisconnectedOnRequest := False;
    if fbSocketize then begin
      Port := GStack.WSNToHs(req.Port);
      IpAddr := req.IpAddr;
    end
    else begin
      Port := self.DefaultPort;
      IpAddr.S_addr := 0;
    end;
    Header.Port := Port;
    Header.IpAddr := IpAddr;
  end;

  Header.MsgType := tmConnect;
  Header.UserId := SID;
  SendMsg(Header, RSTunnelConnectMsg);

end;

procedure TIdTunnelSlave.DoDisconnect(Thread: TIdPeerThread);
var
  Header: TIdHeader;
begin

  try
    with TClientData(Thread.Data) do begin
      if DisconnectedOnRequest = False then begin
        Header.MsgType := tmDisconnect;
        Header.UserId := Id;
        SendMsg(Header, RSTunnelDisconnectMsg);
      end;
    end;

    SetStatistics(NumberOfClientsType, Integer(soDecrease));
  except
    ;
  end;

end;

// Thread to communicate with the user
// reads the requests and transmits them through the tunnel
function TIdTunnelSlave.DoExecute(Thread: TIdPeerThread): boolean;
var
  user: TClientData;
  s: String;
  Header: TIdHeader;
begin
  result := true;

  if Thread.Connection.IOHandler.Readable(IdTimeoutInfinite) then  begin
    s := Thread.Connection.CurrentReadBuffer;
    try
      user := TClientData(Thread.Data);
      Header.MsgType := tmData;
      Header.UserId := user.Id;
      SendMsg(Header, s);
    except
      Thread.Connection.Disconnect;
      raise;
    end;
  end;
end;

procedure TIdTunnelSlave.SendMsg(var Header: TIdHeader; s: String);
var
  tmpString: String;
begin

  SendThroughTunnelLock.Enter;
  try
    try

      if not StopTransmiting then begin
        if Length(s) > 0 then begin
          try
            // Custom data transformation before send
            tmpString := s;
            try
              DoTransformSend(Header, tmpString);
            except
              on E: Exception do begin
                raise;
              end;
            end;
            if Header.MsgType = 0 then begin // error ocured in transformation
              raise EIdTunnelTransformErrorBeforeSend.Create(RSTunnelTransformErrorBS);
            end;

            try
            Sender.PrepareMsg(Header, PChar(tmpString), Length(tmpString));
            except
              raise;
            end;

            try
              SClient.Write(Sender.Msg);
            except
              StopTransmiting := True;
              raise;
            end;
          except
            ;
            raise;
          end;
        end
      end;

    except
      SClient.Disconnect;
    end;

  finally
    SendThroughTunnelLock.Leave;
  end;

end;

procedure TIdTunnelSlave.DoBeforeTunnelConnect(var Header: TIdHeader; var CustomMsg: String);
begin

  if Assigned(fOnBeforeTunnelConnect) then
    fOnBeforeTunnelConnect(Header, CustomMsg);

end;

procedure TIdTunnelSlave.DoTransformRead(Receiver: TReceiver);
begin

  if Assigned(fOnTransformRead) then
    fOnTransformRead(Receiver);

end;

procedure TIdTunnelSlave.DoInterpretMsg(var CustomMsg: String);
begin

  if Assigned(fOnInterpretMsg) then
    fOnInterpretMsg(CustomMsg);

end;

procedure TIdTunnelSlave.DoTransformSend(var Header: TIdHeader; var CustomMsg: String);
begin

  if Assigned(fOnTransformSend) then
    fOnTransformSend(Header, CustomMsg);

end;

procedure TIdTunnelSlave.DoTunnelDisconnect(Thread: TSlaveThread);
begin

  try
    StopTransmiting := True;
    if not ManualDisconnected then begin
      if Active then begin
        Active := False;
      end;
    end;
  except
    ;
  end;

  If Assigned(OnTunnelDisconnect) then
    OnTunnelDisconnect(Thread);

end;

procedure TIdTunnelSlave.OnTunnelThreadTerminate(Sender:TObject);
begin
  // Just set the flag
  SlaveThreadTerminated := True;
end;


function TIdTunnelSlave.GetClientThread(UserID: Integer): TIdPeerThread;
var
  user: TClientData;
  Thread: TIdPeerThread;
  i: integer;
begin

//  GetClientThreadLock.Enter;
  Result := nil;
  with ThreadMgr.ActiveThreads.LockList do
  try
    try
      for i := 0 to Count-1 do begin
        try
          if Assigned(Items[i]) then begin
            Thread := TIdPeerThread(Items[i]);
            if Assigned(Thread.Data) then begin
              user := TClientData(Thread.Data);
              if user.Id = UserID then begin
                Result := Thread;
                break;
              end;
            end;
          end;
        except
          Result := nil;
        end;
      end;
    except
      Result := nil;
    end;
  finally
    ThreadMgr.ActiveThreads.UnlockList;
//    GetClientThreadLock.Leave;
  end;
end;


procedure TIdTunnelSlave.TerminateTunnelThread;
begin

  OnlyOneThread.Enter;
  try
    if Assigned(SlaveThread) then begin
      if not IsCurrentThread(SlaveThread) then begin
        SlaveThread.TerminateAndWaitFor;
        SlaveThread.Free;
        SlaveThread := nil;
      end else begin
        SlaveThread.FreeOnTerminate := True;
      end;
    end;
  finally
    OnlyOneThread.Leave;
  end;
end;



procedure TIdTunnelSlave.ClientOperation(Operation: Integer; UserId: Integer; s: String);
var
  Thread: TIdPeerThread;
  user: TClientData;
begin
  if StopTransmiting then begin
    Exit;
  end;
  Thread := GetClientThread(UserID);
  if Assigned(Thread) then begin
    try
      case Operation of
        1:
        begin
          try
            if Thread.Connection.Connected then begin
              try
                Thread.Connection.Write(s);
              except
              end;
            end;
          except
            try
              Thread.Connection.Disconnect;
            except
            end;
          end;
        end;
        2:
        begin
          user := TClientData(Thread.Data);
          user.DisconnectedOnRequest := True;
          Thread.Connection.Disconnect;
        end;
      end;
    except
    end;
  end;
end;

procedure TIdTunnelSlave.DisconectAllUsers;
begin
  TerminateAllThreads;
end;
//
// END Slave Tunnel classes
///////////////////////////////////////////////////////////////////////////////

constructor TClientData.Create;
begin
  inherited Create;
  id := GetNextID;
  Locker := TCriticalSection.Create;
  SelfDisconnected := False;
end;

destructor TClientData.Destroy;
begin
  Locker.Free;
  inherited Destroy;
end;

constructor TSlaveThread.Create(Slave: TIdTunnelSlave);
begin
  SlaveParent := Slave;
//  FreeOnTerminate := True;
  FreeOnTerminate := False;
  FExecuted := False;
  FConnection := Slave.SClient;
  OnTerminate := Slave.OnTunnelThreadTerminate;
//  InitializeCriticalSection(FLock);
  FLock := TCriticalSection.Create;
  Receiver := TReceiver.Create;
  inherited Create(True);
  StopMode := smTerminate;
end;

destructor TSlaveThread.Destroy;
begin
//  Executed := True;
  Connection.Disconnect;
  Receiver.Free;
//  DeleteCriticalSection(FLock);
  FLock.Destroy;
  inherited Destroy;
end;


procedure TSlaveThread.SetExecuted(Value: Boolean);
begin
//  Lock;
  FLock.Enter;
  try
    FExecuted := Value;
  finally
//    Unlock;
    FLock.Leave;
  end;
end;

function TSlaveThread.GetExecuted: Boolean;
begin
//  Lock;
  FLock.Enter;
  try
    Result := FExecuted;
  finally
//    Unlock;
    FLock.Leave;
  end;
end;

procedure TSlaveThread.Execute;
begin
  inherited;
  Executed := True;
end;

procedure TSlaveThread.Run;
var
  Header: TIdHeader;
  s: String;
  CustomMsg: String;
begin
  try
    if Connection.IOHandler.Readable(IdTimeoutInfinite) then begin
//    if Connection.Binding.Readable(IdTimeoutDefault) then begin
      Receiver.Data := Connection.CurrentReadBuffer;

      // increase the packets counter
      SlaveParent.SetStatistics(NumberOfPacketsType, 0);

      while (Receiver.TypeDetected) and (not Terminated) do begin
        if Receiver.NewMessage then begin
          if Receiver.CRCFailed then begin
            raise EIdTunnelCRCFailed.Create(RSTunnelCRCFailed);
          end;

          try
          // Custom data transformation
            SlaveParent.DoTransformRead(Receiver);
          except
            IndyRaiseOuterException(EIdTunnelTransformError.Create(RSTunnelTransformError));
          end;

          // Action
          case Receiver.Header.MsgType of
            0:  // transformation of data failed, disconnect the tunnel
              begin
                SlaveParent.ManualDisconnected := False;
                raise EIdTunnelMessageTypeRecognitionError.Create(RSTunnelMessageTypeError);
              end; // Failure END


            1:  // Data
              begin
                try
                  SetString(s, Receiver.Msg, Receiver.MsgLen);
                  {$IFDEF STRING_IS_ANSI}
                  // TODO: do we need to use SetCodePage() here?
                  {$ENDIF}
                  SlaveParent.ClientOperation(1, Receiver.Header.UserId, s);
                except
                  IndyRaiseOuterException(EIdTunnelMessageHandlingFailed.Create(RSTunnelMessageHandlingError));
                end;
              end; // Data END

            2:  // Disconnect
              begin
                try
                  SlaveParent.ClientOperation(2, Receiver.Header.UserId, '');    {Do not Localize}
                except
                  IndyRaiseOuterException(EIdTunnelMessageHandlingFailed.Create(RSTunnelMessageHandlingError));
                end;
              end;

            99:  // Session
              begin
                // Custom data interpretation
                CustomMsg := '';    {Do not Localize}
                SetString(CustomMsg, Receiver.Msg, Receiver.MsgLen);
                {$IFDEF STRING_IS_ANSI}
                // TODO: do we need to use SetCodePage() here?
                {$ENDIF}
                try
                  try
                    SlaveParent.DoInterpretMsg(CustomMsg);
                  except
                    IndyRaiseOuterException(EIdTunnelInterpretationOfMessageFailed.Create(RSTunnelMessageInterpretError));
                  end;
                  if Length(CustomMsg) > 0 then begin
                    Header.MsgType := 99;
                    Header.UserId := 0;
                    SlaveParent.SendMsg(Header, CustomMsg);
                  end;
                except
                  SlaveParent.ManualDisconnected := False;
                  IndyRaiseOuterException(EIdTunnelCustomMessageInterpretationFailure.Create(RSTunnelMessageCustomInterpretError));
                end;

              end;

          end; // case

          // Shift of data
          Receiver.ShiftData;

        end
        else
          break;  // break the loop

      end; // end while
    end; // if readable
  except
    on E: EIdSocketError do begin
      case E.LastError of
        10054: Connection.Disconnect;
      else
        begin
          Terminate;
        end;
      end;
    end;
    on EIdClosedSocket do ;
  else
    raise;
  end;
  if not Connection.Connected then
    Terminate;
end;

procedure TSlaveThread.AfterRun;
begin
  SlaveParent.DoTunnelDisconnect(self);
end;

procedure TSlaveThread.BeforeRun;
var
  Header: TIdHeader;
  tmpString: String;
begin
  tmpString := '';    {Do not Localize}
  try
    SlaveParent.DoBeforeTunnelConnect(Header, tmpString);
  except
    ;
  end;
  if Length(tmpString) > 0 then begin
    Header.MsgType := 99;
    Header.UserId := 0;
    SlaveParent.SendMsg(Header, tmpString);
  end;

end;

initialization
  GUniqueID := TIdThreadSafeInteger.Create;
finalization
  FreeAndNil(GUniqueID);
end.
