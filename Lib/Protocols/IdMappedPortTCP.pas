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
  Rev 1.28    12/2/2004 4:23:54 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.27    11/15/04 11:32:22 AM  RLebeau
  Changed OutboundConnect() to assign the TIdTcpClient.ConnectTimeout property
  instead of the IOHandler.ConnectTimeout property.

  Rev 1.26    10/6/2004 10:22:12 PM  BGooijen
  Removed PEVerify errors in this unit

  Rev 1.25    8/2/04 5:55:00 PM  RLebeau
  Updated TIdMappedPortContext.OutboundConnect() with ConnectTimeout property
  change.

  Rev 1.24    3/1/04 7:17:02 PM  RLebeau
  Minor correction to previous change

  Rev 1.23    3/1/04 7:14:34 PM  RLebeau
  Updated TIdMappedPortContext.OutboundConnect() to call CreateIOHandler()
  before attempting to use the outbound client's IOHandler property.

  Rev 1.22    2004.02.03 5:43:58 PM  czhower
  Name changes

  Rev 1.21    2/1/2004 4:23:32 AM  JPMugaas
  Should now compile in DotNET.

  Rev 1.20    1/21/2004 3:11:30 PM  JPMugaas
  InitComponent

  Rev 1.19    12/14/03 7:16:20 PM  RLebeau
  Typo fixes when accessing OutboudClient.IOHandler

  Rev 1.18    2003.11.29 10:19:04 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.17    2003.10.21 9:13:10 PM  czhower
  Now compiles.

  Rev 1.16    10/19/2003 5:25:10 PM  DSiders
  Added localization comments.

  Rev 1.15    2003.10.18 9:42:10 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.14    2003.10.12 4:04:00 PM  czhower
  compile todos

  Rev 1.13    9/19/2003 03:30:06 PM  JPMugaas
  Now should compile again.

  Rev 1.12    04.06.2003 14:09:28  ARybin
  updated for new IoHandler behavior

  Rev 1.11    3/6/2003 5:08:46 PM  SGrobety
  Updated the read buffer methodes to fit the new core (InputBuffer ->
  InputBufferAsString + call to CheckForDataOnSource)

  Rev 1.10    28.05.2003 17:35:34  ARybin
  right bug fix

  Rev 1.9    28.05.2003 16:55:30  ARybin
  bug fix

  Rev 1.8    5/26/2003 12:23:46 PM  JPMugaas

  Rev 1.7    4/3/2003 7:26:10 PM  BGooijen
  Re-enabled .ConnectTimeout and .Connect

  Rev 1.6    3/21/2003 11:45:36 AM  JPMugaas
  Added OnBeforeConnect method so the TIdMappedPort component is more flexible.

  Rev 1.5    2/24/2003 09:14:38 PM  JPMugaas

  Rev 1.4    1/20/2003 1:15:32 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes

  Rev 1.3    1/17/2003 06:45:12 PM  JPMugaas
  Now compiles with new framework.

  Rev 1.2    1-8-2003 22:20:40  BGooijen
  these compile (TIdContext)

  Rev 1.1    12/7/2002 06:43:10 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 07:56:42 AM  JPMugaas

  2001-12-xx - Andrew P.Rybin
    -new architecture

  2002-02-02 - Andrew P.Rybin
    -DoDisconnect fix
}

unit IdMappedPortTCP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer,
  IdGlobal, IdStack, IdTCPConnection, IdTCPServer, IdYarn, SysUtils;

type
  TIdMappedPortTCP = class;

  TIdMappedPortContext = class(TIdServerContext)
  protected
    FOutboundClient: TIdTCPConnection;//was TIdTCPClient
    FReadList: TIdSocketList;
    FDataAvailList: TIdSocketList;
    FConnectTimeOut: Integer;
    FNetData: TIdBytes;
    FServer : TIdMappedPortTCP;
    //
    procedure CheckForData(DoRead: Boolean); virtual;
    procedure HandleLocalClientData; virtual;
    procedure HandleOutboundClientData; virtual;
    procedure OutboundConnect; virtual;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdContextThreadList = nil
      ); override;
    destructor Destroy; override;
    //
    property  Server : TIdMappedPortTCP Read FServer write FServer;
    property  ConnectTimeOut: Integer read FConnectTimeOut write FConnectTimeOut default IdTimeoutDefault;
    property  NetData: TIdBytes read FNetData write FNetData;
    property  OutboundClient: TIdTCPConnection read FOutboundClient write FOutboundClient;
  end;//TIdMappedPortContext

  TIdMappedPortTCP = class(TIdCustomTCPServer)
  protected
    FMappedHost: string;
    FMappedPort: TIdPort;
    FOnBeforeConnect: TIdServerThreadEvent;

    //AThread.Connection.Server & AThread.OutboundClient
    FOnOutboundConnect: TIdServerThreadEvent;
    FOnOutboundData: TIdServerThreadEvent;
    FOnOutboundDisConnect: TIdServerThreadEvent;
    //
    procedure ContextCreated(AContext:TIdContext); override;
    procedure DoBeforeConnect(AContext: TIdContext); virtual;
    procedure DoConnect(AContext: TIdContext); override;
    function  DoExecute(AContext: TIdContext): boolean; override;
    procedure DoDisconnect(AContext: TIdContext); override; //DoLocalClientDisconnect
    procedure DoLocalClientConnect(AContext: TIdContext); virtual;
    procedure DoLocalClientData(AContext: TIdContext); virtual;//APR: bServer

    procedure DoOutboundClientConnect(AContext: TIdContext); virtual;
    procedure DoOutboundClientData(AContext: TIdContext); virtual;
    procedure DoOutboundDisconnect(AContext: TIdContext); virtual;
    function  GetOnConnect: TIdServerThreadEvent;
    function  GetOnExecute: TIdServerThreadEvent;
    procedure SetOnConnect(const Value: TIdServerThreadEvent);
    procedure SetOnExecute(const Value: TIdServerThreadEvent);
    function  GetOnDisconnect: TIdServerThreadEvent;
    procedure SetOnDisconnect(const Value: TIdServerThreadEvent);
    procedure InitComponent; override;
  published
    property  OnBeforeConnect: TIdServerThreadEvent read FOnBeforeConnect write FOnBeforeConnect;
    property  MappedHost: String read FMappedHost write FMappedHost;
    property  MappedPort: TIdPort read FMappedPort write FMappedPort;
    //
    property  OnConnect: TIdServerThreadEvent read GetOnConnect write SetOnConnect; //OnLocalClientConnect
    property  OnOutboundConnect: TIdServerThreadEvent read FOnOutboundConnect write FOnOutboundConnect;

    property  OnExecute: TIdServerThreadEvent read GetOnExecute write SetOnExecute;//OnLocalClientData
    property  OnOutboundData: TIdServerThreadEvent read FOnOutboundData write FOnOutboundData;

    property  OnDisconnect: TIdServerThreadEvent read GetOnDisconnect write SetOnDisconnect;//OnLocalClientDisconnect
    property  OnOutboundDisconnect: TIdServerThreadEvent read FOnOutboundDisconnect write FOnOutboundDisconnect;
  End;//TIdMappedPortTCP

Implementation

uses
  IdException,
  IdIOHandler, IdIOHandlerSocket, IdResourceStrings,IdStackConsts, IdTCPClient;

procedure TIdMappedPortTCP.InitComponent;
begin
  inherited InitComponent;
  FContextClass := TIdMappedPortContext;
end;

procedure TIdMappedPortTCP.ContextCreated(AContext: TIdContext);
begin
  TIdMappedPortContext(AContext).Server := Self;
end;

procedure TIdMappedPortTCP.DoBeforeConnect(AContext: TIdContext);
begin
  if Assigned(FOnBeforeConnect) then begin
    FOnBeforeConnect(AContext);
  end;
end;

procedure TIdMappedPortTCP.DoLocalClientConnect(AContext: TIdContext);
begin
  if Assigned(FOnConnect) then begin
    FOnConnect(AContext);
  end;
end;

procedure TIdMappedPortTCP.DoOutboundClientConnect(AContext: TIdContext);
begin
  if Assigned(FOnOutboundConnect) then begin
    FOnOutboundConnect(AContext);
  end;
end;

procedure TIdMappedPortTCP.DoLocalClientData(AContext: TIdContext);
begin
  if Assigned(FOnExecute) then begin
    FOnExecute(AContext);
  end;
end;

procedure TIdMappedPortTCP.DoOutboundClientData(AContext: TIdContext);
begin
  if Assigned(FOnOutboundData) then begin
    FOnOutboundData(AContext);
  end;
end;

procedure TIdMappedPortTCP.DoDisconnect(AContext: TIdContext);
begin
  inherited DoDisconnect(AContext);
  //check for loop
  if Assigned(TIdMappedPortContext(AContext).FOutboundClient) and
    TIdMappedPortContext(AContext).FOutboundClient.Connected then
  begin
    TIdMappedPortContext(AContext).FOutboundClient.Disconnect;
  end;
end;

procedure TIdMappedPortTCP.DoOutboundDisconnect(AContext: TIdContext);
begin
  if Assigned(FOnOutboundDisconnect) then begin
    FOnOutboundDisconnect(AContext);
  end;
  AContext.Connection.Disconnect; //disconnect local
end;

procedure TIdMappedPortTCP.DoConnect(AContext: TIdContext);
var
  LContext: TIdMappedPortContext;
begin
  DoBeforeConnect(AContext);

  LContext := TIdMappedPortContext(AContext);

  //WARNING: Check TIdTCPServer.DoConnect and synchronize code. Don't call inherited!=> OnConnect in OutboundConnect    {Do not Localize}
  LContext.OutboundConnect;

  //cache
  LContext.FReadList.Clear;
  LContext.FReadList.Add(AContext.Binding.Handle);
  LContext.FReadList.Add(LContext.FOutboundClient.Socket.Binding.Handle);
end;

function TIdMappedPortTCP.DoExecute(AContext: TIdContext): Boolean;
var
  LContext: TIdMappedPortContext;
begin
  LContext := TIdMappedPortContext(AContext);
  try
    LContext.CheckForData(True);
  finally
    if not LContext.FOutboundClient.Connected then begin
      Result := False;
      DoOutboundDisconnect(AContext); //&Connection.Disconnect
    end else begin;
      Result := AContext.Connection.Connected;
    end;
  end;
end;

function TIdMappedPortTCP.GetOnConnect: TIdServerThreadEvent;
begin
  Result := FOnConnect;
end;

function TIdMappedPortTCP.GetOnExecute: TIdServerThreadEvent;
begin
  Result := FOnExecute;
end;

function TIdMappedPortTCP.GetOnDisconnect: TIdServerThreadEvent;
begin
  Result := FOnDisconnect;
end;

procedure TIdMappedPortTCP.SetOnConnect(const Value: TIdServerThreadEvent);
begin
  FOnConnect := Value;
end;

procedure TIdMappedPortTCP.SetOnExecute(const Value: TIdServerThreadEvent);
begin
  FOnExecute := Value;
end;

procedure TIdMappedPortTCP.SetOnDisconnect(const Value: TIdServerThreadEvent);
begin
  FOnDisconnect := Value;
end;


{ TIdMappedPortContext }

constructor TIdMappedPortContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdContextThreadList = nil
  );
begin
  inherited Create(AConnection, AYarn, AList);
  FReadList := TIdSocketList.CreateSocketList;
  FDataAvailList := TIdSocketList.CreateSocketList;
  FConnectTimeOut := IdTimeoutDefault;
end;

destructor TIdMappedPortContext.Destroy;
begin
  FreeAndNil(FOutboundClient);
  FreeAndNIL(FReadList);
  FreeAndNIL(FDataAvailList);
  inherited Destroy;
end;

procedure TIdMappedPortContext.CheckForData(DoRead: Boolean);
begin
  if DoRead and Connection.IOHandler.InputBufferIsEmpty and FOutboundClient.IOHandler.InputBufferIsEmpty then
  begin
    if FReadList.SelectReadList(FDataAvailList, IdTimeoutInfinite) then
    begin
      //1.LConnectionHandle
      if FDataAvailList.ContainsSocket(Connection.Socket.Binding.Handle) then
      begin
        // TODO: WSAECONNRESET (Exception [EIdSocketError] Socket Error # 10054 Connection reset by peer)
        Connection.IOHandler.CheckForDataOnSource(0);
      end;
      //2.LOutBoundHandle
      if FDataAvailList.ContainsSocket(FOutboundClient.Socket.Binding.Handle) then
      begin
        FOutboundClient.IOHandler.CheckForDataOnSource(0);
      end;
    end;        
  end;
  if not Connection.IOHandler.InputBufferIsEmpty then
  begin
    HandleLocalClientData;
  end;
  if not FOutboundClient.IOHandler.InputBufferIsEmpty then
  begin
    HandleOutboundClientData;
  end;
  Connection.IOHandler.CheckForDisconnect;
  FOutboundClient.IOHandler.CheckForDisconnect;
end;

procedure TIdMappedPortContext.HandleLocalClientData;
begin
  SetLength(FNetData, 0);
  Connection.IOHandler.InputBuffer.ExtractToBytes(FNetData);
  Server.DoLocalClientData(Self);
  FOutboundClient.IOHandler.Write(FNetData);
end;

procedure TIdMappedPortContext.HandleOutboundClientData;
begin
  SetLength(FNetData, 0);
  FOutboundClient.IOHandler.InputBuffer.ExtractToBytes(FNetData);
  Server.DoOutboundClientData(Self);
  Connection.IOHandler.Write(FNetData);
end;

procedure TIdMappedPortContext.OutboundConnect;
var
  LServer: TIdMappedPortTCP;
  LClient: TIdTCPClient;
begin
  FOutboundClient := TIdTCPClient.Create(nil);
  LServer := TIdMappedPortTCP(Server);
  try
    LClient := TIdTCPClient(FOutboundClient);

    LClient.Port := LServer.MappedPort;
    LClient.Host := LServer.MappedHost;

    LServer.DoLocalClientConnect(Self);

    LClient.ConnectTimeout := FConnectTimeOut;
    LClient.Connect;

    LServer.DoOutboundClientConnect(Self);

    //APR: buffer can contain data from prev (users) read op.
    CheckForData(False);
  except
    on E: Exception do
    begin
      DoException(E);// DONE: Handle connect failures
      Connection.Disconnect; //req IdTcpServer with "Stop this thread if we were disconnected"
      raise;
    end;
  end;
end;

end.
