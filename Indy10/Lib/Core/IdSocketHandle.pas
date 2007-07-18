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
  Rev 1.8    4/11/2005 2:17:46 PM  JPMugaas
  Fix from Ben Taylor for where a pointer is used after it's freed causing an
  invalid pointer operation.

  Rev 1.7    23.3.2005 ã. 20:50:04  DBondzhev
  Fixed problem on multi CPU systems when connection is closed while it get's
  connected at the end of the timeout period.

  Rev 1.6    11/15/2004 11:40:08 PM  JPMugaas
  Added IPAddressType parameter to SetBinding )AIPVersion).  This would set the
  same variable as the SetPeer AIPVersion parameter.  It's just a convenience
  sake since both the receiver and sender must have the same type of IP address
  (unless there's a gateway thing we support).

  Rev 1.5    11/12/2004 11:30:18 AM  JPMugaas
  Expansions for IPv6.

  Rev 1.4    09/06/2004 09:48:42  CCostelloe
  Kylix 3 patch

  Rev 1.3    4/26/04 12:40:26 PM  RLebeau
  Removed recursion from Readable()

  Rev 1.2    2004.03.07 11:48:48 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.1    3/6/2004 5:16:14 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.0    2004.02.03 3:14:40 PM  czhower
  Move and updates

  Rev 1.23    2/2/2004 12:09:16 AM  JPMugaas
  GetSockOpt should now work in DotNET.

  Rev 1.22    2/1/2004 6:10:46 PM  JPMugaas
  GetSockOpt.

  Rev 1.21    12/31/2003 9:51:58 PM  BGooijen
  Added IPv6 support

  Rev 1.20    10/26/2003 12:29:40 PM  BGooijen
  DotNet

  Rev 1.19    10/22/2003 04:40:48 PM  JPMugaas
  Should compile with some restored functionality.  Still not finished.

  Rev 1.18    2003.10.11 5:50:26 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.17    10/5/2003 9:55:30 PM  BGooijen
  TIdTCPServer works on D7 and DotNet now

  Rev 1.16    2003.10.02 12:44:42 PM  czhower
  Fix for Bind, Connect

  Rev 1.15    2003.10.02 10:16:28 AM  czhower
  .Net

  Rev 1.14    2003.10.01 9:11:20 PM  czhower
  .Net

  Rev 1.13    2003.10.01 5:05:14 PM  czhower
  .Net

  Rev 1.12    2003.10.01 2:30:40 PM  czhower
  .Net

  Rev 1.10    10/1/2003 12:14:12 AM  BGooijen
  DotNet: removing CheckForSocketError

  Rev 1.9    2003.10.01 1:12:36 AM  czhower
  .Net

  Rev 1.8    2003.09.30 1:23:02 PM  czhower
  Stack split for DotNet

  Rev 1.7    20.09.2003 16:33:28  ARybin
  bug fix:
  NOT Integer <> 0 is not boolean operation, because:
  (NOT Integer) = inverted integer

  Rev 1.6    2003.07.14 1:57:24 PM  czhower
  -First set of IOCP fixes.
  -Fixed a threadsafe problem with the stack class.

  Rev 1.5    7/1/2003 05:20:36 PM  JPMugaas
  Minor optimizations.  Illiminated some unnecessary string operations.

  Rev 1.4    7/1/2003 03:39:52 PM  JPMugaas
  Started numeric IP function API calls for more efficiency.

    Rev 1.3    5/11/2003 11:59:06 AM  BGooijen
  Added OverLapped property

    Rev 1.2    5/11/2003 12:35:30 AM  BGooijen
  temporary creates overlapped socked handles

  Rev 1.1    3/21/2003 01:50:08 AM  JPMugaas
  SetBinding method added as per request received in private E-Mail.

  Rev 1.0    11/13/2002 08:58:46 AM  JPMugaas
}

unit IdSocketHandle;

interface

uses
  Classes,
  IdException, IdGlobal, IdStackConsts, IdStack, IdBaseComponent;

type
  TIdSocketHandle = class;

  TIdSocketHandles = class(TOwnedCollection)
  protected
    FDefaultPort: TIdPort;
    //
    function GetItem(Index: Integer): TIdSocketHandle;
    procedure SetItem(Index: Integer; const Value: TIdSocketHandle);
  public
    constructor Create(AOwner: TComponent); reintroduce;
    function Add: TIdSocketHandle; reintroduce;
    function BindingByHandle(const AHandle: TIdStackSocketHandle): TIdSocketHandle;
    property Items[Index: Integer]: TIdSocketHandle read GetItem write SetItem; default;
    //
    property DefaultPort: TIdPort read FDefaultPort write FDefaultPort;
  end;

  TIdSocketHandle = class(TCollectionItem)
  protected
    FClientPortMin: Integer;
    FClientPortMax: Integer;
    FHandle: TIdStackSocketHandle;
    FHandleAllocated: Boolean;
    FIP: string;
    FPeerIP: string;
    FPort: TIdPort;
    FPeerPort: TIdPort;
    FReadSocketList: TIdSocketList;
    FOverLapped: Boolean;
    FIPVersion: TIdIPVersion;
    FConnectionHandle: TIdCriticalSection;
    //
    function BindPortReserved: Boolean;
    procedure SetOverLapped(const AValue:boolean);
    procedure SetHandle(AHandle: TIdStackSocketHandle);
    procedure SetIPVersion(const Value: TIdIPVersion);
    function TryBind: Boolean;
  public
    function Accept(ASocket: TIdStackSocketHandle): Boolean;
{$IFDEF LINUX}
    procedure AllocateSocket(const ASocketType: TIdSocketType = TIdSocketType(Id_SOCK_STREAM);
     const AProtocol: TIdSocketProtocol = Id_IPPROTO_IP);
{$ELSE}
    procedure AllocateSocket(const ASocketType: TIdSocketType = Id_SOCK_STREAM;
     const AProtocol: TIdSocketProtocol = Id_IPPROTO_IP);
{$ENDIF}
    // Returns True if error was ignored (Matches iIgnore), false if no error occurred
    procedure Assign(Source: TPersistent); override;
    procedure Bind;
    procedure CloseSocket; virtual;
    procedure Connect; virtual;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
//    procedure GetSockOpt(level, optname: Integer; optval: PChar; optlen: Integer);
    procedure Listen(const AQueueCount: Integer = 5);
    function Readable(AMSec: Integer = IdTimeoutDefault): boolean;
    function Receive(var VBuffer: TIdBytes): Integer;
    function RecvFrom(var ABuffer : TIdBytes; var VIP: string;
      var VPort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
    procedure Reset(const AResetLocal: boolean = True);
    function Send(
      const ABuffer: TIdBytes;
      AOffset: Integer;
      ASize: Integer = -1
      ): Integer;
    procedure SendTo(const AIP: string; const APort: Integer; const ABuffer : TIdBytes; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
    procedure SetPeer(const AIP: string; const APort: TIdPort; const AIPVersion : TIdIPVersion = ID_DEFAULT_IP_VERSION);
    procedure SetBinding(const AIP: string; const APort: TIdPort; const AIPVersion : TIdIPVersion = ID_DEFAULT_IP_VERSION);
    procedure GetSockOpt(ALevel:TIdSocketOptionLevel; AOptName: TIdSocketOption; out VOptVal: Integer);
    procedure SetSockOpt(ALevel:TIdSocketOptionLevel; AOptName: TIdSocketOption; AOptVal: Integer);
    function Select(ATimeout: Integer = IdTimeoutInfinite): Boolean;
    procedure UpdateBindingLocal;
    procedure UpdateBindingPeer;
    //
    property HandleAllocated: Boolean read FHandleAllocated;
    property Handle: TIdStackSocketHandle read FHandle;
    property OverLapped:boolean read FOverLapped write SetOverLapped;
    property PeerIP: string read FPeerIP;
    property PeerPort: TIdPort read FPeerPort;
  published
    property ClientPortMin : TIdPort read FClientPortMin write FClientPortMin default 0;
    property ClientPortMax : TIdPort read FClientPortMax write FClientPortMax default 0;
    property IP: string read FIP write FIP;
    property IPVersion: TIdIPVersion read FIPVersion write SetIPVersion default ID_DEFAULT_IP_VERSION;
    property Port: TIdPort read FPort write FPort;
  end;

implementation

uses
  IdAntiFreezeBase, IdComponent, IdResourceStrings, SysUtils;

{ TIdSocketHandle }

procedure TIdSocketHandle.AllocateSocket(
 const ASocketType: TIdSocketType;
 const AProtocol: TIdSocketProtocol);
begin
  // If we are reallocating a socket - close and destroy the old socket handle
  CloseSocket;
  if HandleAllocated then begin
    Reset;
  end;
  // Set property so it calls the writer
  SetHandle(GStack.NewSocketHandle(ASocketType, AProtocol, FIPVersion, FOverLapped));
end;

procedure TIdSocketHandle.CloseSocket;
begin
  if HandleAllocated then begin
    FConnectionHandle.Enter; try
      // Must be first, closing socket will trigger some errors, and they
      // may then call (in other threads) Connected, which in turn looks at
      // FHandleAllocated.
      FHandleAllocated := False;
      GStack.Disconnect(Handle);
      SetHandle(Id_INVALID_SOCKET);
    finally
      FConnectionHandle.Leave;
    end;
  end;
end;

procedure TIdSocketHandle.Connect;
begin
  GStack.Connect(Handle, PeerIP, PeerPort, FIPVersion);
  FConnectionHandle.Enter; try
    if (HandleAllocated) then begin
      // UpdateBindingLocal needs to be called even though Bind calls it. After
      // Bind is may be 0.0.0.0 (INADDR_ANY). After connect it will be a real IP.
      UpdateBindingLocal;
      //TODO: Could Peer binding ever be other than what we specified above?
      // Need to reread it?
      UpdateBindingPeer;
    end;
  finally
    FConnectionHandle.Leave;
  end;
end;

destructor TIdSocketHandle.Destroy;
begin
  CloseSocket;
  FreeAndNil(FConnectionHandle);
  FreeAndNil(FReadSocketList);
  inherited Destroy;
end;

function TIdSocketHandle.Receive(var VBuffer: TIdBytes): Integer;
begin
  Result := GStack.Receive(Handle, VBuffer);
end;

function TIdSocketHandle.Send(
  const ABuffer: TIdBytes;
  AOffset: Integer;
  ASize: Integer = -1
  ): Integer;
begin
  Result := GStack.Send(Handle, ABuffer, AOffset, ASize);
end;

procedure TIdSocketHandle.SetSockOpt(ALevel:TIdSocketOptionLevel; 
      AOptName: TIdSocketOption; AOptVal: Integer);
begin
  GStack.SetSocketOption(Handle,ALevel,AOptName,AOptVal);
////  (GStack as TIdStackBSDBase).WSSetSockOpt(Handle, level, optname, optval, optlen);
end;

procedure TIdSocketHandle.SendTo(const AIP: string; const APort: Integer; const ABuffer : TIdBytes; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  GStack.SendTo(Handle, ABuffer, 0, AIP, APort,AIPVersion);
end;

function TIdSocketHandle.RecvFrom(var ABuffer : TIdBytes; var VIP: string;
 var VPort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
begin
  Result := GStack.ReceiveFrom(Handle,ABuffer,VIP,VPort,AIPVersion);
end;

procedure TIdSocketHandle.Bind;
begin
  if (Port = 0) and (FClientPortMin <> 0) and (FClientPortMax <> 0) then begin
    if (FClientPortMin > FClientPortMax) then begin
      raise EIdInvalidPortRange.Create(IndyFormat(RSInvalidPortRange
       , [FClientPortMin, FClientPortMax]));
    end else if not BindPortReserved then begin
      raise EIdCanNotBindPortInRange.Create(IndyFormat(RSCanNotBindRange
       , [FClientPortMin, FClientPortMax]));
    end;
  end else if not TryBind then begin
    raise EIdCouldNotBindSocket.Create(RSCouldNotBindSocket);
  end;
end;

procedure TIdSocketHandle.SetPeer(const AIP: string; const APort: TIdPort;  const AIPVersion : TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  FPeerIP := AIP;
  FPeerPort := APort;
  FIPVersion := AIPVersion;
end;

procedure TIdSocketHandle.SetBinding(const AIP: string; const APort: TIdPort; const AIPVersion : TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  FIP := AIP;
  FPort := APort;
  FIPVersion := AIPVersion;
end;

procedure TIdSocketHandle.SetOverLapped(const AValue:boolean);
begin
  // TODO: check for HandleAllocated
  FOverLapped := AValue;
end;

procedure TIdSocketHandle.Listen(const AQueueCount: Integer = 5);
begin
  GStack.Listen(Handle, AQueueCount);
end;

function TIdSocketHandle.Accept(ASocket: TIdStackSocketHandle): Boolean;
var
  LAcceptedSocket: TIdStackSocketHandle;
begin
  Reset;
  LAcceptedSocket := GStack.Accept(ASocket, FIP, FPort, FIPVersion);
  Result := (LAcceptedSocket <> Id_INVALID_SOCKET);
  if Result then begin
    SetHandle(LAcceptedSocket);
    // UpdateBindingLocal is necessary as it may be listening on multiple IPs/Ports
    UpdateBindingLocal;
    UpdateBindingPeer;
  end;
end;

constructor TIdSocketHandle.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FConnectionHandle := TIdCriticalSection.Create;
  FReadSocketList := TIdSocketList.CreateSocketList;
  Reset;
  FClientPortMin := 0;
  FClientPortMax := 0;
  if Assigned(ACollection) then begin
    Port := TIdSocketHandles(ACollection).DefaultPort;
  end;
end;

function TIdSocketHandle.Readable(AMSec: Integer = IdTimeoutDefault): Boolean;

  function CheckIsReadable(AMSec: Integer): Boolean;
  begin
    EIdConnClosedGracefully.IfFalse(HandleAllocated, RSConnectionClosedGracefully);
    Result := Select(AMSec);
  end;

begin
  if AMSec = IdTimeoutDefault then begin
    AMSec := IdTimeoutInfinite;
  end;
  if TIdAntiFreezeBase.ShouldUse then begin
    if AMSec = IdTimeoutInfinite then begin
      repeat
        Result := CheckIsReadable(GAntiFreeze.IdleTimeOut);
      until Result;
      Exit;
    end;
    while AMSec > GAntiFreeze.IdleTimeOut do begin
      Result := CheckIsReadable(GAntiFreeze.IdleTimeOut);
      if Result then begin
        Exit;
      end;
      Dec(AMSec, GAntiFreeze.IdleTimeOut);
    end;
  end;
  Result := CheckIsReadable(AMSec);
end;

procedure TIdSocketHandle.Assign(Source: TPersistent);
var
  LSource: TIdSocketHandle;
begin
  if Source is TIdSocketHandle then begin
    LSource := TIdSocketHandle(Source);
    FIP := LSource.FIP;
    Port := LSource.Port;
    FPeerIP := LSource.FPeerIP;
    FPeerPort := LSource.FPeerPort;
    FIPVersion := LSource.IPVersion;
  end else begin
    inherited
  end;
end;

procedure TIdSocketHandle.UpdateBindingLocal;
begin
  GStack.GetSocketName(Handle, FIP, FPort);
end;

procedure TIdSocketHandle.UpdateBindingPeer;
begin
  GStack.GetPeerName(Handle, FPeerIP, FPeerPort);
end;

procedure TIdSocketHandle.Reset(const AResetLocal: boolean = True);
begin
  SetHandle(Id_INVALID_SOCKET);
  if AResetLocal then begin
    FIP := '';
    FPort := 0;
  end;
  FPeerIP := '';
  FPeerPort := 0;
  FIPVersion := ID_DEFAULT_IP_VERSION;
end;

function TIdSocketHandle.TryBind: Boolean;
begin
  try
    GStack.Bind(Handle, FIP, Port, FIPVersion);
    Result := True;
    UpdateBindingLocal;
  except
    Result := False;
  end;
end;

function TIdSocketHandle.BindPortReserved: Boolean;
var
  i : Integer;
begin
  Result := false;
  for i := FClientPortMax downto FClientPortMin do begin
    FPort := i;
    if TryBind then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TIdSocketHandle.GetSockOpt(ALevel:TIdSocketOptionLevel; AOptName: TIdSocketOption; out VOptVal: Integer);
begin
  GStack.GetSocketOption(Handle,ALevel,AOptName,VOptVal);
end;

function TIdSocketHandle.Select(ATimeOut: Integer = IdTimeoutInfinite): Boolean;
begin
  Result := FReadSocketList.SelectRead(ATimeOut);
  TIdAntiFreezeBase.DoProcess(Result = False);
end;

procedure TIdSocketHandle.SetHandle(AHandle: TIdStackSocketHandle);
begin
  if FHandle <> Id_INVALID_SOCKET then begin
    FReadSocketList.Remove(FHandle);
  end;
  FHandle := AHandle;
  FHandleAllocated := FHandle <> Id_INVALID_SOCKET;
  if FHandleAllocated then begin
    FReadSocketList.Add(FHandle);
  end;
end;

procedure TIdSocketHandle.SetIPVersion(const Value: TIdIPVersion);
begin
  if Value <> FIPVersion then begin
    if HandleAllocated then begin
      raise EIdCannotSetIPVersionWhenConnected.Create(RSCannotSetIPVersionWhenConnected);
    end;
    FIPVersion := Value;
  end;
end;

{ TIdSocketHandles }

function TIdSocketHandles.Add: TIdSocketHandle;
begin
  Result := inherited Add as TIdSocketHandle;
  Result.Port := DefaultPort;
end;

function TIdSocketHandles.BindingByHandle(const AHandle: TIdStackSocketHandle): TIdSocketHandle;
var
  i: integer;
begin
  Result := nil;
  i := Count - 1;
  while (i >= 0) and (Items[i].Handle <> AHandle) do begin
    dec(i);
  end;
  if i >= 0 then begin
    Result := Items[i];
  end;
end;

constructor TIdSocketHandles.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TIdSocketHandle);
end;

function TIdSocketHandles.GetItem(Index: Integer): TIdSocketHandle;
begin
  Result := TIdSocketHandle(inherited Items[index]);
end;

procedure TIdSocketHandles.SetItem(Index: Integer; const Value: TIdSocketHandle);
begin
  inherited SetItem(Index, Value);
end;

end.
