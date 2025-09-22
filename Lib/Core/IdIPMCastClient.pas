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
  Rev 1.6    14/06/2004 21:38:28  CCostelloe
  Converted StringToTIn4Addr call

  Rev 1.5    09/06/2004 10:00:34  CCostelloe
  Kylix 3 patch

  Rev 1.4    2004.02.03 5:43:52 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 3:11:08 PM  JPMugaas
  InitComponent

  Rev 1.2    10/26/2003 09:11:52 AM  JPMugaas
  Should now work in NET.

  Rev 1.1    2003.10.12 4:03:56 PM  czhower
  compile todos

  Rev 1.0    11/13/2002 07:55:22 AM  JPMugaas
}

unit IdIPMCastClient;

interface

{$I IdCompilerDefines.inc}
//Put FPC into Delphi mode

uses
  Classes,
  IdException,
  IdGlobal,
  IdIPMCastBase,
  IdUDPBase,
  IdComponent,
  IdSocketHandle,
  IdThread;

const
  DEF_IMP_THREADEDEVENT = False;

type
  TIPMCastReadEvent = procedure(Sender: TObject; const AData: TIdBytes; ABinding: TIdSocketHandle) of object;

  TIdIPMCastClient = class;

  TIdIPMCastListenerThread = class(TIdThread)
  protected
    IncomingData: TIdSocketHandle;
    FAcceptWait: integer;
    FBuffer: TIdBytes;
    FBufferSize: integer;
    procedure Run; override;
  public
    FServer: TIdIPMCastClient;
    //
    constructor Create(AOwner: TIdIPMCastClient); reintroduce;
    destructor Destroy; override;

    procedure IPMCastRead;
    //
    property AcceptWait: integer read FAcceptWait write FAcceptWait;
  end;

  TIdIPMCastClient = class(TIdIPMCastBase)
  protected
    FBindings: TIdSocketHandles;
    FBufferSize: Integer;
    FCurrentBinding: TIdSocketHandle;
    FListenerThread: TIdIPMCastListenerThread;
    FOnBeforeBind: TIdSocketHandleEvent;
    FOnAfterBind: TNotifyEvent;
    FOnIPMCastRead: TIPMCastReadEvent;
    FThreadedEvent: boolean;
    //
    procedure CloseBinding; override;
    procedure DoBeforeBind(AHandle: TIdSocketHandle); virtual;
    procedure DoAfterBind; virtual;
    procedure DoIPMCastRead(const AData: TIdBytes; ABinding: TIdSocketHandle);virtual;
    function GetActive: Boolean; override;
    function GetBinding: TIdSocketHandle; override;
    function GetDefaultPort: integer;
    procedure PacketReceived(const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure SetDefaultPort(const AValue: integer);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    //
  published
    property IPVersion default ID_DEFAULT_IP_VERSION;
    property Active;
    property Bindings: TIdSocketHandles read FBindings write SetBindings;
    property BufferSize: Integer read FBufferSize write FBufferSize default ID_UDP_BUFFERSIZE;
    property DefaultPort: integer read GetDefaultPort write SetDefaultPort;
    property MulticastGroup;
    property ReuseSocket;
    property ThreadedEvent: boolean read FThreadedEvent write FThreadedEvent default DEF_IMP_THREADEDEVENT;
    property OnBeforeBind: TIdSocketHandleEvent read FOnBeforeBind write FOnBeforeBind;
    property OnAfterBind: TNotifyEvent read FOnAfterBind write FOnAfterBind;
    property OnIPMCastRead: TIPMCastReadEvent read FOnIPMCastRead write FOnIPMCastRead;
  end;

implementation

uses
  IdResourceStringsCore,
  IdStack,
  IdStackConsts,
  SysUtils;

{ TIdIPMCastClient }

procedure TIdIPMCastClient.InitComponent;
begin
  inherited InitComponent;
  BufferSize := ID_UDP_BUFFERSIZE;
  FThreadedEvent := DEF_IMP_THREADEDEVENT;
  FBindings := TIdSocketHandles.Create(Self);
end;

procedure TIdIPMCastClient.CloseBinding;
var
  i: integer;
begin
  if Assigned(FCurrentBinding) then begin
    // Necessary here - cancels the recvfrom in the listener thread
    FListenerThread.Stop;
    try
      for i := 0 to Bindings.Count - 1 do begin
        if Bindings[i].HandleAllocated then begin
          // RLebeau: DropMulticastMembership() can raise an exception if
          // the network cable has been pulled out...
          // TODO: update DropMulticastMembership() to not raise an exception...
          try
            Bindings[i].DropMulticastMembership(FMulticastGroup);
          except
          end;
        end;
        Bindings[i].CloseSocket;
      end;
    finally
      FListenerThread.WaitFor;
      FreeAndNil(FListenerThread);
      FCurrentBinding := nil;
    end;
  end;
end;

procedure TIdIPMCastClient.DoIPMCastRead(const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  if Assigned(OnIPMCastRead) then begin
    OnIPMCastRead(Self, AData, ABinding);
  end;
end;

procedure TIdIPMCastClient.DoBeforeBind(AHandle: TIdSocketHandle);
begin
  if Assigned(FOnBeforeBind) then begin
    FOnBeforeBind(AHandle);
  end;
end;

procedure TIdIPMCastClient.DoAfterBind;
begin
  if Assigned(FOnAfterBind) then begin
    FOnAfterBind(Self);
  end;
end;

function TIdIPMCastClient.GetActive: Boolean;
begin
  if IsDesignTime then begin
    // inherited GetActive keeps track of design-time Active property
    Result := inherited GetActive;
  end else begin
    Result := Assigned(FCurrentBinding);
    if Result then begin
      Result := FCurrentBinding.HandleAllocated;
    end;
  end;
end;

function TIdIPMCastClient.GetBinding: TIdSocketHandle;
var
  i: integer;
  LBinding: TIdSocketHandle;
begin
  if not Assigned(FCurrentBinding) then
  begin
    if Bindings.Count < 1 then begin
      if DefaultPort > 0 then begin
        Bindings.Add.IPVersion := FIPVersion;
      end else begin
        raise EIdMCastNoBindings.Create(RSNoBindingsSpecified);
      end;
    end;

    for i := 0 to Bindings.Count - 1 do begin
      try
        LBinding := Bindings[i];
        LBinding.AllocateSocket(Id_SOCK_DGRAM);
        // do not overwrite if the default. This allows ReuseSocket to be set per binding
        if FReuseSocket <> rsOSDependent then begin
          LBinding.ReuseSocket := FReuseSocket;
        end;
        DoBeforeBind(LBinding);
        LBinding.Bind;
        LBinding.AddMulticastMembership(FMulticastGroup);
        if not Assigned(FCurrentBinding) then begin
          FCurrentBinding := LBinding;
        end;
      except
      end;
    end;

    DoAfterBind;

    // RLebeau: why only one listener thread total, instead of one per Binding,
    // like TIdUDPServer uses?
    FListenerThread := TIdIPMCastListenerThread.Create(Self);
  end;

  Result := FCurrentBinding;
end;

function TIdIPMCastClient.GetDefaultPort: integer;
begin
  Result := FBindings.DefaultPort;
end;

procedure TIdIPMCastClient.PacketReceived(const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  FCurrentBinding := ABinding;
  DoIPMCastRead(AData, ABinding);
end;

procedure TIdIPMCastClient.SetBindings(const Value: TIdSocketHandles);
begin
  FBindings.Assign(Value);
end;

procedure TIdIPMCastClient.SetDefaultPort(const AValue: integer);
begin
  if (FBindings.DefaultPort <> AValue) then begin
    FBindings.DefaultPort := AValue;
    FPort := AValue;
  end;
end;

destructor TIdIPMCastClient.Destroy;
begin
  Active := False;
  FreeAndNil(FBindings);
  inherited Destroy;
end;

{ TIdIPMCastListenerThread }

constructor TIdIPMCastListenerThread.Create(AOwner: TIdIPMCastClient);
var
  LName: string;
begin
  FAcceptWait := 1000;
  FBufferSize := AOwner.BufferSize;
  FBuffer := nil;
  FServer := AOwner;
  LName := AOwner.Name;
  if LName = '' then begin
    LName := 'IdIPMCastClient'; {do not localize}
  end;
  inherited Create(False, False, LName + ' Listener'); {do not localize}
end;

destructor TIdIPMCastListenerThread.Destroy;
begin
  inherited Destroy;
end;

procedure TIdIPMCastListenerThread.Run;
var
  PeerIP: string;
  PeerPort: TIdPort;
  PeerIPVersion: TIdIPVersion;
  ByteCount: Integer;
  LSocketList, LReadList: TIdSocketList;
  i: Integer;
  LBuffer : TIdBytes;
begin
  SetLength(LBuffer, FBufferSize);

  // create a socket list to select for read
  LSocketList := TIdSocketList.CreateSocketList;
  try
    // fill list of socket handles for reading
    for i := 0 to FServer.Bindings.Count - 1 do
    begin
      LSocketList.Add(FServer.Bindings[i].Handle);
    end;

    LReadList := TIdSocketList.CreateSocketList;
    try
      while not Stopped do
      begin
        // select the handles for reading
        LReadList.Clear;
        if LSocketList.SelectReadList(LReadList, AcceptWait) then
        begin
          for i := 0 to LReadList.Count - 1 do
          begin
            // Doublecheck to see if we've been stopped
            // Depending on timing - may not reach here
            // if stopped the run method of the ancestor
            if Stopped then begin
              Exit;
            end;

            IncomingData := FServer.Bindings.BindingByHandle(LReadList[i]);
            if IncomingData <> nil then
            begin
              ByteCount := IncomingData.RecvFrom(LBuffer, PeerIP, PeerPort, PeerIPVersion);
              // RLebeau: some protocols make use of 0-length messages, so don't discard
              // them here. This is not connection-oriented, so recvfrom() only returns
              // 0 if a 0-length packet was actually received...
              if ByteCount >= 0 then
              begin
                SetLength(FBuffer, ByteCount);
                CopyTIdBytes(LBuffer, 0, FBuffer, 0, ByteCount);
                IncomingData.SetPeer(PeerIP, PeerPort, PeerIPVersion);
                if FServer.ThreadedEvent then begin
                  IPMCastRead;
                end else begin
                  Synchronize(IPMCastRead);
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      LReadList.Free;
    end;
  finally
    LSocketList.Free;
  end;
end;

procedure TIdIPMCastListenerThread.IPMCastRead;
begin
  FServer.PacketReceived(FBuffer, IncomingData);
end;

end.
