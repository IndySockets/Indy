{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11663: IdMappedPortTCP.pas
{
{   Rev 1.28    12/2/2004 4:23:54 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.27    11/15/04 11:32:22 AM  RLebeau
{ Changed OutboundConnect() to assign the TIdTcpClient.ConnectTimeout property
{ instead of the IOHandler.ConnectTimeout property.
}
{
{   Rev 1.26    10/6/2004 10:22:12 PM  BGooijen
{ Removed PEVerify errors in this unit
}
{
{   Rev 1.25    8/2/04 5:55:00 PM  RLebeau
{ Updated TIdMappedPortContext.OutboundConnect() with ConnectTimeout property
{ change.
}
{
{   Rev 1.24    3/1/04 7:17:02 PM  RLebeau
{ Minor correction to previous change
}
{
{   Rev 1.23    3/1/04 7:14:34 PM  RLebeau
{ Updated TIdMappedPortContext.OutboundConnect() to call CreateIOHandler()
{ before attempting to use the outbound client's IOHandler property.
}
{
{   Rev 1.22    2004.02.03 5:43:58 PM  czhower
{ Name changes
}
{
{   Rev 1.21    2/1/2004 4:23:32 AM  JPMugaas
{ Should now compile in DotNET.
}
{
{   Rev 1.20    1/21/2004 3:11:30 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.19    12/14/03 7:16:20 PM  RLebeau
{ Typo fixes when accessing OutboudClient.IOHandler
}
{
{   Rev 1.18    2003.11.29 10:19:04 AM  czhower
{ Updated for core change to InputBuffer.
}
{
{   Rev 1.17    2003.10.21 9:13:10 PM  czhower
{ Now compiles.
}
{
    Rev 1.16    10/19/2003 5:25:10 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.15    2003.10.18 9:42:10 PM  czhower
{ Boatload of bug fixes to command handlers.
}
{
{   Rev 1.14    2003.10.12 4:04:00 PM  czhower
{ compile todos
}
{
{   Rev 1.13    9/19/2003 03:30:06 PM  JPMugaas
{ Now should compile again.
}
{
{   Rev 1.12    04.06.2003 14:09:28  ARybin
{ updated for new IoHandler behavior
}
{
{   Rev 1.11    3/6/2003 5:08:46 PM  SGrobety
{ Updated the read buffer methodes to fit the new core (InputBuffer ->
{ InputBufferAsString + call to CheckForDataOnSource)
}
{
{   Rev 1.10    28.05.2003 17:35:34  ARybin
{ right bug fix
}
{
{   Rev 1.9    28.05.2003 16:55:30  ARybin
{ bug fix
}
{
{   Rev 1.8    5/26/2003 12:23:46 PM  JPMugaas
}
{
    Rev 1.7    4/3/2003 7:26:10 PM  BGooijen
  Re-enabled .ConnectTimeout and .Connect
}
{
{   Rev 1.6    3/21/2003 11:45:36 AM  JPMugaas
{ Added OnBeforeConnect method so the TIdMappedPort component is more flexible.
}
{
{   Rev 1.5    2/24/2003 09:14:38 PM  JPMugaas
}
{
    Rev 1.4    1/20/2003 1:15:32 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes
}
{
{   Rev 1.3    1/17/2003 06:45:12 PM  JPMugaas
{ Now compiles with new framework.
}
{
{   Rev 1.2    1-8-2003 22:20:40  BGooijen
{ these compile (TIdContext)
}
{
{   Rev 1.1    12/7/2002 06:43:10 PM  JPMugaas
{ These should now compile except for Socks server.  IPVersion has to be a
{ property someplace for that.
}
{
{   Rev 1.0    11/13/2002 07:56:42 AM  JPMugaas
}
unit IdMappedPortTCP;
interface
{
2001-12-xx - Andrew P.Rybin
  -new architecture
2002-02-02 - Andrew P.Rybin
  -DoDisconnect fix
}

uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer,
  IdGlobal,  IdStack, IdSys, IdTCPConnection, IdTCPServer, IdYarn;

type
  TIdMappedPortTCP = class;
  TIdMappedPortContext = class (TIdContext)
  protected
    FOutboundClient: TIdTCPConnection;//was TIdTCPClient
    FReadList: TIdSocketList;
    FDataAvailList: TIdSocketList;
    FNetData: String; //data buf
    FConnectTimeOut: Integer;
    FServer : TIdMappedPortTCP;
    //
    procedure OutboundConnect; virtual;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TThreadList = nil
      ); override;
    destructor Destroy; override;
    //
    property  Server : TIdMappedPortTCP Read FServer write FServer;
    property  ConnectTimeOut: Integer read FConnectTimeOut write FConnectTimeOut default IdTimeoutDefault;
    property  NetData: String read FNetData write FNetData;
    property  OutboundClient: TIdTCPConnection read FOutboundClient write FOutboundClient;

    property  ReadList: TIdSocketList read FReadList;
    property  DataAvailList: TIdSocketList read FDataAvailList;
  End;//TIdMappedPortContext

  TIdMappedPortOutboundConnectEvent = procedure(AContext:TIdContext; AException: Exception) of object;//E=NIL-OK

  TIdMappedPortTCP = class(TIdTCPServer)
  protected
    FMappedHost: String;
    FMappedPort: Integer;

    //AThread.Connection.Server & AThread.OutboundClient
    FOnOutboundConnect: TIdMappedPortOutboundConnectEvent;
    FOnOutboundData: TIdServerThreadEvent;
    FOnOutboundDisConnect: TIdServerThreadEvent;
    //
    procedure ContextCreated(AContext:TIdContext); override;
    procedure DoConnect(AContext:TIdContext); override;
    function  DoExecute(AContext:TIdContext): boolean; override;
    procedure DoDisconnect(AContext:TIdContext); override; //DoLocalClientDisconnect
    procedure DoLocalClientConnect(AContext:TIdContext); virtual;
    procedure DoLocalClientData(AContext:TIdContext); virtual;//APR: bServer

    procedure DoOutboundClientConnect(AContext:TIdContext; const AException: Exception=NIL); virtual;
    procedure DoOutboundClientData(AContext:TIdContext); virtual;
    procedure DoOutboundDisconnect(AContext:TIdContext); virtual;
    function  GetOnBeforeConnect: TIdServerThreadEvent;
    function  GetOnConnect: TIdServerThreadEvent;
    function  GetOnExecute: TIdServerThreadEvent;
    procedure SetOnBeforeConnect(const Value: TIdServerThreadEvent);
    procedure SetOnConnect(const Value: TIdServerThreadEvent);
    procedure SetOnExecute(const Value: TIdServerThreadEvent);
    function  GetOnDisconnect: TIdServerThreadEvent;
    procedure SetOnDisconnect(const Value: TIdServerThreadEvent);
    procedure InitComponent; override;
  published
    property  OnBeforeConnect: TIdServerThreadEvent read GetOnBeforeConnect write SetOnBeforeConnect;
    property  MappedHost: String read FMappedHost write FMappedHost;
    property  MappedPort: Integer read FMappedPort write FMappedPort;
    //
    property  OnConnect: TIdServerThreadEvent read GetOnConnect write SetOnConnect; //OnLocalClientConnect
    property  OnOutboundConnect: TIdMappedPortOutboundConnectEvent read FOnOutboundConnect write FOnOutboundConnect;

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
Begin
  inherited;
  FContextClass := TIdMappedPortContext;
End;//

procedure TIdMappedPortTCP.ContextCreated(AContext: TIdContext);
begin
  (AContext As TIdMappedPortContext).Server := Self;
end;

procedure TIdMappedPortTCP.DoLocalClientConnect(AContext:TIdContext);
Begin
  if Assigned(FOnConnect) then FOnConnect(AContext);
End;//

procedure TIdMappedPortTCP.DoOutboundClientConnect(AContext:TIdContext; const AException: Exception=NIL);
Begin
  if Assigned(FOnOutboundConnect) then FOnOutboundConnect(AContext,AException);
End;//

procedure TIdMappedPortTCP.DoLocalClientData(AContext:TIdContext);
Begin
  if Assigned(FOnExecute) then FOnExecute(AContext);
End;//

procedure TIdMappedPortTCP.DoOutboundClientData(AContext:TIdContext);
Begin
  if Assigned(FOnOutboundData) then FOnOutboundData(AContext);
End;//

procedure TIdMappedPortTCP.DoDisconnect(AContext:TIdContext);
Begin
  inherited DoDisconnect(AContext);
  if Assigned(TIdMappedPortContext(AContext).FOutboundClient) and
    TIdMappedPortContext(AContext).FOutboundClient.Connected
  then begin//check for loop
    TIdMappedPortContext(AContext).FOutboundClient.Disconnect;
  end;
End;//DoDisconnect

procedure TIdMappedPortTCP.DoOutboundDisconnect(AContext:TIdContext);
Begin
  if Assigned(FOnOutboundDisconnect) then begin
    FOnOutboundDisconnect(AContext);
  end;
  AContext.Connection.Disconnect; //disconnect local
End;//


procedure TIdMappedPortTCP.DoConnect(AContext:TIdContext);
begin
  if Assigned(FOnBeforeConnect) then begin
    FOnBeforeConnect(AContext);
  end;
  //WARNING: Check TIdTCPServer.DoConnect and synchronize code. Don't call inherited!=> OnConnect in OutboundConnect    {Do not Localize}
  TIdMappedPortContext(AContext).OutboundConnect;

  //cache
  with TIdMappedPortContext(AContext).FReadList do begin
    Clear;
    Add((AContext.Connection.IOHandler as TIdIOHandlerSocket).Binding.Handle);
    Add((TIdMappedPortContext(AContext).FOutboundClient.IOHandler as TIdIOHandlerSocket).Binding.Handle);
  end;
End;//TIdMappedPortTCP.DoConnect

function TIdMappedPortTCP.DoExecute(AContext:TIdContext): boolean;
begin
  Result := TRUE;
  with TIdMappedPortContext(AContext) do begin
    try
      if FReadList.SelectReadList(FDataAvailList, IdTimeoutInfinite) then begin
        //1.LConnectionHandle
        if FDataAvailList.Contains((AContext.Connection.IOHandler as TIdIOHandlerSocket).Binding.Handle) then begin
          // TODO: WSAECONNRESET (Exception [EIdSocketError] Socket Error # 10054 Connection reset by peer)
          AContext.Connection.IOHandler.CheckForDataOnSource;
          FNetData := AContext.Connection.IOHandler.InputBufferAsString;
          //CurrentReadBuffer;
          if Length(FNetData)>0 then begin
            DoLocalClientData(AContext);//bServer
            FOutboundClient.IOHandler.Write(FNetData);
          end;//if
        end;
        //2.LOutBoundHandle
        if FDataAvailList.Contains((FOutboundClient.IOHandler as TIdIOHandlerSocket).Binding.Handle) then begin
          FOutboundClient.IOHandler.CheckForDataOnSource;
          FNetData := FOutboundClient.IOHandler.InputBufferAsString;
          //CurrentReadBuffer;
          if Length(FNetData)>0 then begin
            DoOutboundClientData(AContext);
            AContext.Connection.IOHandler.Write(FNetData);
          end;//if
        end;
      end;//if select
    finally
      if NOT FOutboundClient.Connected then begin
        DoOutboundDisconnect(AContext); //&Connection.Disconnect
      end;//if
    end;//tryf
  end;//with
End;//TIdMappedPortTCP.DoExecute

function TIdMappedPortTCP.GetOnConnect: TIdServerThreadEvent;
Begin
  Result:=FOnConnect;
End;//

function TIdMappedPortTCP.GetOnExecute: TIdServerThreadEvent;
Begin
  Result:=FOnExecute;
End;//

function TIdMappedPortTCP.GetOnDisconnect: TIdServerThreadEvent;
Begin
  Result:=FOnDisconnect;
End;//OnDisconnect

procedure TIdMappedPortTCP.SetOnConnect(const Value: TIdServerThreadEvent);
Begin
  FOnConnect:=Value;
End;//

procedure TIdMappedPortTCP.SetOnExecute(const Value: TIdServerThreadEvent);
Begin
  FOnExecute:=Value;
End;//

procedure TIdMappedPortTCP.SetOnDisconnect(const Value: TIdServerThreadEvent);
Begin
  FOnDisconnect:=Value;
End;//OnDisconnect


{ TIdMappedPortContext }

constructor TIdMappedPortContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TThreadList = nil
  );
begin
  inherited Create(AConnection, AYarn, AList);
  FReadList := TIdSocketList.CreateSocketList;
  FDataAvailList := TIdSocketList.CreateSocketList;
  FConnectTimeOut := IdTimeoutDefault;
end;

destructor TIdMappedPortContext.Destroy;
begin
  //^Sys.FreeAndNIL(FOutboundClient);
  Sys.FreeAndNIL(FOutboundClient);
  Sys.FreeAndNIL(FReadList);
  Sys.FreeAndNIL(FDataAvailList);
  inherited Destroy;
End;

procedure TIdMappedPortContext.OutboundConnect;
Begin
  FOutboundClient := TIdTCPClient.Create(NIL);
  with TIdMappedPortTCP(Server) do begin
    try
      with TIdTcpClient(FOutboundClient) do begin
        Port := MappedPort;
        Host := MappedHost;
      end;//with
      DoLocalClientConnect(Self);

      FOutboundClient.CreateIOHandler(TIdIOHandlerSocket);

      TIdTcpClient(FOutboundClient).ConnectTimeout := FConnectTimeOut;
      TIdTcpClient(FOutboundClient).Connect;
      DoOutboundClientConnect(Self);

      //APR: buffer can contain data from prev (users) read op.
      FNetData := Connection.IOHandler.InputBufferAsString;
      if FNetData <> '' then begin
        DoLocalClientData(SELF);
        FOutboundClient.IOHandler.Write(FNetData);
      end;//if

      FNetData := FOutboundClient.IOHandler.InputBufferAsString;
      if FNetData <> '' then begin
        DoOutboundClientData(SELF);
        Connection.IOHandler.Write(FNetData);
      end;//if
    except
      on E: Exception do begin
        DoOutboundClientConnect(Self,E); // DONE: Handle connect failures
        Connection.Disconnect; //req IdTcpServer with "Stop this thread if we were disconnected"
        raise;
      end;
    end;//trye
  end;//with
End;//for easy inheritance

function TIdMappedPortTCP.GetOnBeforeConnect: TIdServerThreadEvent;
begin
  Result:=FOnBeforeConnect;
end;

procedure TIdMappedPortTCP.SetOnBeforeConnect(
  const Value: TIdServerThreadEvent);
begin
  FOnBeforeConnect := Value;
end;

END.
