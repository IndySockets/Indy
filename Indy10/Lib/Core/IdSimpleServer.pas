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
{   Rev 1.17    7/13/04 6:46:36 PM  RLebeau
{ Added support for BoundPortMin/Max propeties
}
{
{   Rev 1.16    6/6/2004 12:49:40 PM  JPMugaas
{ Removed old todo's for things that have already been done.
}
{
{   Rev 1.15    5/6/2004 6:04:44 PM  JPMugaas
{ Attempt to reenable TransparentProxy.Bind.
}
{
{   Rev 1.14    5/5/2004 2:08:40 PM  JPMugaas
{ Reenabled Socks Listen for TIdSimpleServer.
}
{
{   Rev 1.13    2004.02.03 4:16:52 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.12    2004.01.20 10:03:34 PM  czhower
{ InitComponent
}
{
{   Rev 1.11    1/2/2004 12:02:16 AM  BGooijen
{ added OnBeforeBind/OnAfterBind
}
{
{   Rev 1.10    1/1/2004 10:57:58 PM  BGooijen
{ Added IPv6 support
}
{
{   Rev 1.9    10/26/2003 10:08:44 PM  BGooijen
{ Compiles in DotNet
}
{
{   Rev 1.8    10/20/2003 03:04:56 PM  JPMugaas
{ Should now work without Transparant Proxy.  That still needs to be enabled.
}
{
{   Rev 1.7    2003.10.14 9:57:42 PM  czhower
{ Compile todos
}
{
{   Rev 1.6    2003.10.11 5:50:12 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.5    2003.09.30 1:23:02 PM  czhower
{ Stack split for DotNet
}
{
    Rev 1.4    5/16/2003 9:25:36 AM  BGooijen
  TransparentProxy support
}
{
    Rev 1.3    3/29/2003 5:55:04 PM  BGooijen
  now calls AfterAccept
}
{
    Rev 1.2    3/23/2003 11:24:46 PM  BGooijen
  changed cast from TIdIOHandlerStack to TIdIOHandlerSocket
}
{
{   Rev 1.1    1-6-2003 21:39:00  BGooijen
{ The handle to the listening socket was not closed when accepting a
{ connection. This is fixed by merging the responsible code from 9.00.11
}
{
{   Rev 1.0    11/13/2002 08:58:40 AM  JPMugaas
}
unit IdSimpleServer;

interface

uses
  IdException,
  IdGlobal,
  IdSocketHandle,
  IdTCPConnection,
  IdObjs,
  IdStackConsts,
  IdIOHandler;

const
  ID_ACCEPT_WAIT = 1000;

type
  TIdSimpleServer = class(TIdTCPConnection)
  protected
    FAbortedRequested: Boolean;
    FAcceptWait: Integer;
    FBoundIP: String;
    FBoundPort: Integer;
    FBoundPortMin: Integer;
    FBoundPortMax: Integer;
    FIPVersion: TIdIPVersion;
    FListenHandle: TIdStackSocketHandle;
    FListening: Boolean;
    FOnBeforeBind: TIdNotifyEvent;
    FOnAfterBind: TIdNotifyEvent;
    //
    procedure Bind;
    procedure DoBeforeBind; virtual;
    procedure DoAfterBind; virtual;
    function GetIPVersion: TIdIPVersion;
    function GetBinding: TIdSocketHandle;
    procedure InitComponent; override;
    procedure SetIPVersion(const AValue: TIdIPVersion);
  public
    procedure Abort; virtual;
    procedure BeginListen; virtual;
    procedure CreateBinding;
    procedure EndListen; virtual;
    function Listen: Boolean; virtual;
    //
    property AcceptWait: Integer read FAcceptWait write FAcceptWait default ID_ACCEPT_WAIT;
  published
    property BoundIP: string read FBoundIP write FBoundIP;
    property BoundPort: Integer read FBoundPort write FBoundPort;
    property BoundPortMin: Integer read FBoundPortMin write FBoundPortMin;
    property BoundPortMax: Integer read FBoundPortMax write FBoundPortMax;
    property Binding: TIdSocketHandle read GetBinding;
    property IPVersion: TIdIPVersion read GetIPVersion write SetIPVersion;

    property OnBeforeBind:TIdNotifyEvent read FOnBeforeBind write FOnBeforeBind;
    property OnAfterBind:TIdNotifyEvent read FOnAfterBind write FOnAfterBind;
  end;

  EIdCannotUseNonSocketIOHandler = class(EIdException);

implementation

uses
  IdIOHandlerStack, IdIOHandlerSocket, IdStack;

{ TIdSimpleServer }

procedure TIdSimpleServer.Abort;
begin
  FAbortedRequested := True;
end;

procedure TIdSimpleServer.BeginListen;
begin
  if TIdIOHandlerSocket(IOHandler).TransparentProxy.Enabled then begin
    TIdIOHandlerSocket(IOHandler).TransparentProxy.Bind(FIOHandler, BoundPort);
  end else begin
   // Must be before IOHandler as it resets it
   if not Assigned(Binding) then begin
      EndListen;
      CreateBinding;
    end;
    Bind;
    Binding.Listen(15);
  end;
  FListening := True;
end;

procedure TIdSimpleServer.Bind;
begin
  with Binding do begin
    try
      DoBeforeBind;
      IPVersion := FIPVersion;  // needs to be before AllocateSocket, because AllocateSocket uses this
      AllocateSocket;
      FListenHandle := Handle;
      IP := BoundIP;
      Port := BoundPort;
      ClientPortMin := BoundPortMin;
      ClientPortMax := BoundPortMax;
      Bind;
      DoAfterBind;
    except
      FListenHandle := Id_INVALID_SOCKET;
      raise;
    end;
  end;
end;

procedure TIdSimpleServer.CreateBinding;
begin
  if not assigned(IOHandler) then begin
    CreateIOHandler();
  end;
  IOHandler.Open;
end;

procedure TIdSimpleServer.DoBeforeBind;
begin
  if Assigned(FOnBeforeBind) then begin
    FOnBeforeBind(self);
  end;
end;

procedure TIdSimpleServer.DoAfterBind;
begin
  if Assigned(FOnAfterBind) then begin
    FOnAfterBind(self);
  end;
end;

procedure TIdSimpleServer.EndListen;
begin
  FAbortedRequested := False;
  FListening := False;
end;

function TIdSimpleServer.GetBinding: TIdSocketHandle;
begin
  Result := nil;
  if Assigned(IOHandler) then begin
    if IOHandler is TIdIOHandlerSocket then begin
      Result := TIdIOHandlerSocket(IOHandler).Binding;
    end;
  end;
end;

procedure TIdSimpleServer.SetIPVersion(const AValue: TIdIPVersion);
begin
  FIPVersion := AValue;
  if Assigned(IOHandler) then begin
    if IOHandler is TIdIOHandlerSocket then begin
      TIdIOHandlerSocket(IOHandler).IPVersion := AValue;
    end;
  end;
end;

function TIdSimpleServer.GetIPVersion: TIdIPVersion;
begin
  result := FIPVersion;
end;

function TIdSimpleServer.Listen: Boolean;
begin
  Result := False;
  if TIdIOHandlerSocket(IOHandler).TransparentProxy.Enabled then begin
    if not FListening then begin
      BeginListen;
    end;
    with Binding do begin
      if FAbortedRequested = False then begin
        while (FAbortedRequested = False) and (Result = False) do begin
          Result := TIdIOHandlerSocket(IOHandler).TransparentProxy.Listen(IOHandler,AcceptWait);
        end;
      end;
    end;
  end else begin
    if not FListening then begin
      BeginListen;
    end;
    with Binding do begin
      if FAbortedRequested = False then begin
        while (FAbortedRequested = False) and (Result = False) do begin
          Result := Readable(AcceptWait);
        end;
      end;
      if Result then begin
        Binding.Listen(1);
        Binding.Accept(Binding.Handle);
        IOHandler.AfterAccept;
      end;

// This is now proteced. Disconnect replaces it - but it also calls shutdown.
// Im not sure we want to call shutdown here? Need to investigate before fixing
// this.
      GStack.Disconnect(FListenHandle);
      FListenHandle := Id_INVALID_SOCKET;
    end;
  end;
end;


procedure TIdSimpleServer.InitComponent;
begin
  inherited InitComponent;
  FAcceptWait := ID_ACCEPT_WAIT;
  FListenHandle := Id_INVALID_SOCKET;
end;

end.
