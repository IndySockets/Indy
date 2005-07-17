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
{   Rev 1.14    11/12/2004 3:44:00 PM  JPMugaas
{ Compiler error fix.  OOPPS!!!
}
{
{   Rev 1.13    11/12/2004 11:30:20 AM  JPMugaas
{ Expansions for IPv6.
}
{
{   Rev 1.12    6/11/2004 11:48:34 PM  JPMugaas
{ Fix for mistake I made.  UDPReceive should have been UDPException
}
{
{   Rev 1.11    6/11/2004 4:05:34 PM  JPMugaas
{ RecvFrom should now work in the UDP server with IPv6.  
{ An OnException event was added for logging purposes.
}
{
{   Rev 1.10    09/06/2004 00:25:32  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.9    2004.02.03 4:17:02 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.8    2004.01.20 10:03:40 PM  czhower
{ InitComponent
}
{
{   Rev 1.7    2003.12.31 8:03:36 PM  czhower
{ Matched visibility
}
{
{   Rev 1.6    10/26/2003 6:01:44 PM  BGooijen
{ Fixed binding problem
}
{
{   Rev 1.5    10/24/2003 5:18:38 PM  BGooijen
{ Removed boolean shortcutting from .GetActive
}
{
{   Rev 1.4    10/22/2003 04:41:02 PM  JPMugaas
{ Should compile with some restored functionality.  Still not finished.
}
{
{   Rev 1.3    2003.10.11 9:58:50 PM  czhower
{ Started on some todos
}
{
{   Rev 1.2    2003.10.11 5:52:18 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.1    2003.09.30 1:23:10 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.0    11/13/2002 09:02:30 AM  JPMugaas
}
unit IdUDPServer;

interface

uses
  IdComponent,
  IdException,
  IdGlobal,
  IdSocketHandle,
  IdStackConsts,
  IdSys,
  IdThread,
  IdUDPBase,
  IdStack;

type
  //Exception is used instead of EIdException because the exception could be from somewhere else
  TIdUDPExceptionEvent = procedure(Sender :TObject; ABinding: TIdSocketHandle; const AMessage : String; const AExceptionClass : TClass) of object;
  TUDPReadEvent = procedure(Sender: TObject; AData: TIdBytes; ABinding: TIdSocketHandle) of object;

  TIdUDPServer = class;

  TIdUDPListenerThread = class(TIdThread)
  protected
    FIncomingData: TIdSocketHandle;
    FAcceptWait: integer;
    FBuffer: TIdBytes;
    FBufferSize: integer;
    FReadList: TIdSocketList;

    FCurrentException: String;
    FCurrentExceptionClass: TClass;
    //
    procedure AfterRun; override;
    procedure BeforeRun; override;
    procedure Run; override;
  public
    FServer: TIdUDPServer;
    //
    constructor Create(const ABufferSize: integer; Owner: TIdUDPServer); reintroduce;
    destructor Destroy; override;

    procedure UDPRead;
    procedure UDPException;
    //
    property AcceptWait: integer read FAcceptWait write FAcceptWait;
  published
  end;

  TIdUDPServer = class(TIdUDPBase)
  protected
    FBindings: TIdSocketHandles;
    FCurrentBinding: TIdSocketHandle;
    FListenerThread: TIdUDPListenerThread;
    FOnUDPRead: TUDPReadEvent;
    FOnUDPException : TIdUDPExceptionEvent;
    FThreadedEvent: boolean;
    //
    procedure BroadcastEnabledChanged; override;
    procedure CloseBinding; override;
    procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); virtual;
    procedure DoOnUDPException(ABinding: TIdSocketHandle; const AMessage : String; const AExceptionClass : TClass);  virtual;
    function GetActive: Boolean; override;
    function GetBinding: TIdSocketHandle; override;
    function GetDefaultPort: integer;
    procedure InitComponent; override;
    procedure PacketReceived(AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure ExceptionRaised(ABinding: TIdSocketHandle; const AMessage : String; const AExceptionClass : TClass);
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure SetDefaultPort(const AValue: integer);
  public
    destructor Destroy; override;
  published
    property Bindings: TIdSocketHandles read FBindings write SetBindings;
    property DefaultPort: integer read GetDefaultPort write SetDefaultPort;
    property OnUDPRead: TUDPReadEvent read FOnUDPRead write FOnUDPRead;
    property OnUDPException : TIdUDPExceptionEvent read FOnUDPException write FOnUDPException;
    property ThreadedEvent: boolean read FThreadedEvent write FThreadedEvent default False;
  end;
  EIdUDPServerException = class(EIdUDPException);

implementation

procedure TIdUDPServer.BroadcastEnabledChanged;
var
  i: integer;
begin
  if Assigned(FCurrentBinding) then begin
    for i := 0 to Bindings.Count - 1 do begin
      SetBroadcastFlag(BroadcastEnabled, Bindings[i]);
    end;
  end;
end;

procedure TIdUDPServer.CloseBinding;
var
  i: integer;
begin
  if Assigned(FCurrentBinding) then begin
    // Necessary here - cancels the recvfrom in the listener thread
    FListenerThread.Stop;
    for i := 0 to Bindings.Count - 1 do begin
      Bindings[i].CloseSocket;
    end;
    FListenerThread.WaitFor;
    Sys.FreeAndNil(FListenerThread);
    FCurrentBinding := nil;
  end;
end;

destructor TIdUDPServer.Destroy;
begin
  Active := False;
  Sys.FreeAndNil(FBindings);
  inherited Destroy;
end;

procedure TIdUDPServer.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  if assigned(OnUDPRead) then begin
    OnUDPRead(Self, AData, ABinding);
  end;
end;

procedure TIdUDPServer.DoOnUDPException(ABinding: TIdSocketHandle; const AMessage : String; const AExceptionClass : TClass);
begin
  if Assigned(FOnUDPException) then
  begin
    OnUDPException(Self,ABinding,AMessage,AExceptionClass);
  end;
end;

function TIdUDPServer.GetActive: Boolean;
begin
  // inherited GetActive keeps track of design-time Active property
  Result := inherited GetActive;
  if not Result then begin
    if Assigned(FCurrentBinding) then begin
      if FCurrentBinding.HandleAllocated then begin
        result:=true;
      end;
    end;
  end;
end;

function TIdUDPServer.GetBinding: TIdSocketHandle;
var
  i: integer;
begin
  if FCurrentBinding = nil then begin
    if Bindings.Count < 1 then begin
      Bindings.Add;
    end;
    for i := 0 to Bindings.Count - 1 do begin
{$IFDEF LINUX}
      Bindings[i].AllocateSocket(Integer(Id_SOCK_DGRAM));
{$ELSE}
      Bindings[i].AllocateSocket(Id_SOCK_DGRAM);
{$ENDIF}
      Bindings[i].Bind;
    end;
    FCurrentBinding := Bindings[0];
    FListenerThread := TIdUDPListenerThread.Create(BufferSize, Self);
    FListenerThread.Start;
    BroadcastEnabledChanged;
  end;
  Result := FCurrentBinding;
end;

function TIdUDPServer.GetDefaultPort: integer;
begin
  result := FBindings.DefaultPort;
end;

procedure TIdUDPServer.InitComponent;
begin
  inherited InitComponent;
  FBindings := TIdSocketHandles.Create(Self);
end;

procedure TIdUDPServer.PacketReceived(AData: TIdBytes;
  ABinding: TIdSocketHandle);
begin
  FCurrentBinding := ABinding;
  DoUDPRead(AData, ABinding);
end;

procedure TIdUDPServer.ExceptionRaised(ABinding: TIdSocketHandle; const AMessage : String; const AExceptionClass : TClass);
begin
  FCurrentBinding := ABinding;
  DoOnUDPException(ABinding,AMessage, AExceptionClass );
end;

procedure TIdUDPServer.SetBindings(const Value: TIdSocketHandles);
begin
  FBindings.Assign(Value);
end;

procedure TIdUDPServer.SetDefaultPort(const AValue: integer);
begin
  FBindings.DefaultPort := AValue;
end;

{ TIdUDPListenerThread }

// TODO: get rid of buffersize arg... there's no reason why this thread can't simply check its owner's buffersize property    {Do not Localize}
procedure TIdUDPListenerThread.AfterRun;
begin
  FReadList.Free;
end;

procedure TIdUDPListenerThread.BeforeRun;
var
  i: integer;
begin
  // fill list of socket handles
  FReadList := TIdSocketList.CreateSocketList;
  for i := 0 to FServer.Bindings.Count - 1 do begin
    FReadList.Add(FServer.Bindings[i].Handle);
  end;
end;

constructor TIdUDPListenerThread.Create(const ABufferSize: integer; Owner: TIdUDPServer);
begin
  inherited Create(True);
  FAcceptWait := 1000;
  FBufferSize := ABufferSize;
  SetLength(FBuffer,FBufferSize);
  FServer := Owner;
end;

destructor TIdUDPListenerThread.Destroy;
begin
  SetLength(FBuffer,0);
  inherited Destroy;
end;

procedure TIdUDPListenerThread.Run;
var
  PeerIP: string;
  i, PeerPort, ByteCount: Integer;
begin
  FReadList.SelectRead(AcceptWait);
  for i := 0 to FReadList.Count - 1 do try
    // Doublecheck to see if we've been stopped    {Do not Localize}
    // Depending on timing - may not reach here if it is in ancestor run when thread is stopped
    if not Stopped then begin
      FIncomingData := FServer.Bindings.BindingByHandle(TIdStackSocketHandle(FReadList[i]));
      SetLength(FBuffer,FBufferSize);
      ByteCount := GStack.ReceiveFrom(FIncomingData.Handle,FBuffer,PeerIP,PeerPort,FIncomingData.IPVersion );
      SetLength(FBuffer,ByteCount);
      FIncomingData.SetPeer(PeerIP, PeerPort,FIncomingData.IPVersion);
      if FServer.ThreadedEvent then begin
        UDPRead;
      end else begin
      {$IFDEF DotNetDistro}
        UDPRead;
      {$ELSE}
        Synchronize(UDPRead);
      {$ENDIF}
      end;
    end;
  except
    // exceptions should be ignored so that other clients can be served in case of a DOS attack
    on E : Exception do
    begin
      FCurrentException := E.Message;
      FCurrentExceptionClass := E.ClassType;
      if FServer.ThreadedEvent then begin
          UDPException;
      end else begin
        {$IFDEF DotNetDistro}
          UDPException;
        {$ELSE}
          Synchronize(UDPException);
        {$ENDIF}
      end;
    end;
  end;
end;

procedure TIdUDPListenerThread.UDPRead;
begin
  FServer.PacketReceived(FBuffer, FIncomingData);
end;

procedure TIdUDPListenerThread.UDPException;
begin
  FServer.ExceptionRaised(FIncomingData,FCurrentException,FCurrentExceptionClass);
end;

end.
