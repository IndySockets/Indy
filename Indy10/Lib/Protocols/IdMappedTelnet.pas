{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  55983: IdMappedTelnet.pas 
{
{   Rev 1.4    11/15/04 11:32:50 AM  RLebeau
{ Bug fix for OutboundConnect() assigning the IOHandler.ConnectTimeout property
{ before the IOHandler has been assigned.
}
{
{   Rev 1.3    11/14/04 11:40:00 AM  RLebeau
{ Removed typecast in OutboundConnect()
}
{
{   Rev 1.2    2004.02.03 5:45:52 PM  czhower
{ Name changes
}
{
{   Rev 1.1    2/2/2004 4:12:02 PM  JPMugaas
{ Should now compile in DotNET.
}
{
{   Rev 1.0    2/1/2004 4:22:50 AM  JPMugaas
{ Components from IdMappedPort are now in their own units.
}
unit IdMappedTelnet;

interface
uses
  Classes, IdAssignedNumbers,
  IdMappedPortTCP, 
  IdTCPServer;
{uses
  Classes,
  IdContext, IdMappedPortTCP, IdStack,
  IdCoreGlobal, IdTCPConnection, IdTCPServer, IdAssignedNumbers,
  SysUtils; }
type
  //=============================================================================
  // * Telnet *
  //=============================================================================

  TIdMappedTelnetThread = class (TIdMappedPortContext)
  protected
    FAllowedConnectAttempts: Integer;
    //
    procedure OutboundConnect; override;
  public
    property  AllowedConnectAttempts: Integer read FAllowedConnectAttempts;
  End;//TIdMappedTelnetThread

  TIdMappedTelnetCheckHostPort = procedure (AThread: TIdMappedPortContext; const AHostPort: String; var VHost,VPort: String) of object;

  TIdCustomMappedTelnet = class (TIdMappedPortTCP)
  protected
    FAllowedConnectAttempts: Integer;
    FOnCheckHostPort: TIdMappedTelnetCheckHostPort;

    procedure DoCheckHostPort (AThread: TIdMappedPortContext; const AHostPort: String; var VHost,VPort: String); virtual;
    procedure SetAllowedConnectAttempts(const Value: Integer);
    procedure ExtractHostAndPortFromLine(AThread: TIdMappedPortContext; const AHostPort: String);
    procedure InitComponent; override;
  public
    //
    property  AllowedConnectAttempts: Integer read FAllowedConnectAttempts write SetAllowedConnectAttempts default -1;
    //
    property  OnCheckHostPort: TIdMappedTelnetCheckHostPort read FOnCheckHostPort write FOnCheckHostPort;
  published
    property  DefaultPort default IdPORT_TELNET;
    property  MappedPort default IdPORT_TELNET;
  End;//TIdCustomMappedTelnet

  TIdMappedTelnet = class (TIdCustomMappedTelnet)
  published
    property  AllowedConnectAttempts: Integer read FAllowedConnectAttempts write SetAllowedConnectAttempts default -1;
    //
    property  OnCheckHostPort: TIdMappedTelnetCheckHostPort read FOnCheckHostPort write FOnCheckHostPort;
  End;//TIdMappedTelnet

implementation

uses
  IdGlobal, IdException, IdResourceStringsProtocols, IdIOHandlerSocket, IdTCPClient, IdSysUtils;
//=============================================================================

const
  NAMESEP = [#0,#9,' ',':'];

{ TIdCustomMappedTelnet }

procedure TIdCustomMappedTelnet.InitComponent;
Begin
  inherited;
  FAllowedConnectAttempts := -1;
  FContextClass := TIdMappedTelnetThread;
  DefaultPort := IdPORT_TELNET;
  MappedPort := IdPORT_TELNET;
End;//TIdMappedTelnet.Create

procedure TIdCustomMappedTelnet.DoCheckHostPort(AThread: TIdMappedPortContext; const AHostPort: String; var VHost,VPort: String);
Begin
  if Assigned(FOnCheckHostPort) then
  begin
    FOnCheckHostPort(AThread,AHostPort,VHost,VPort);
  end;
End;//

{procedure TIdCustomMappedTelnet.ExtractHostAndPortFromLine(AThread: TIdMappedPortContext; const AHostPort: String);
var
  LHost,LPort: String;
  P,L: PChar;
Begin
  if Length(AHostPort)>0 then begin
    P := Pointer(AHostPort);
    L := P + Length(AHostPort);
    while (P<L) and NOT(P^ in [#0,#9,' ',':']) do begin {Do not Localize}
{      inc(P);
    end;
    SetString(LHost, PChar(Pointer(AHostPort)), P-Pointer(AHostPort));
    while (P<L) and (P^ in [#9,' ',':']) do begin {Do not Localize}
{      inc(P);
    end;
    SetString(LPort, P, L-P);
    LHost := TrimRight(LHost);
    LPort := TrimLeft(LPort);
  end
  else begin
    LHost := '';    {Do not Localize}
{    LPort := '';    {Do not Localize}
{  end;//if
  DoCheckHostPort(AThread, AHostPort,LHost,LPort);

  TIdTcpClient(AThread.OutboundClient).Host := LHost;
  TIdTcpClient(AThread.OutboundClient).Port := StrToIntDef(LPort,TIdTcpClient(AThread.OutboundClient).Port);
End;//ExtractHostAndPortFromLine    }


procedure TIdCustomMappedTelnet.ExtractHostAndPortFromLine(AThread: TIdMappedPortContext; const AHostPort: String);
var
  LHost,LPort: String;
  i : Integer;

Begin
  if Length(AHostPort)>0 then begin
    i := 1;
    LHost := '';
    while (i <= Length(AHostPort)) and
      ( not CharIsInSet( AHostPort, i, NAMESEP )) do
    begin
      LHost := LHost + AHostPort[i];
      Inc(i);
    end;
    LPort := '';
    inc(i);
    while (i <= Length(AHostPort)) and
      ( not CharIsInSet( AHostPort, i, NAMESEP )) do
    begin
      LPort := LPort + AHostPort[i];
      Inc(i);
    end;
    LHost := Sys.TrimRight(LHost);
    LPort := Sys.TrimLeft(LPort);
  end
  else begin
    LHost := '';    {Do not Localize}
    LPort := '';    {Do not Localize}
  end;//if
  DoCheckHostPort(AThread, AHostPort,LHost,LPort);

  TIdTcpClient(AThread.OutboundClient).Host := LHost;
  TIdTcpClient(AThread.OutboundClient).Port := Sys.StrToInt(LPort,TIdTcpClient(AThread.OutboundClient).Port);
End;//ExtractHostAndPortFromLine

procedure TIdMappedTelnetThread.OutboundConnect;
var
  LHostPort: String;
Begin
  //don`t call inherited, NEW behavior
  FOutboundClient := TIdTCPClient.Create(NIL);
  with TIdCustomMappedTelnet(Server) do begin
    with TIdTcpClient(FOutboundClient) do begin
      Port := MappedPort;
      Host := MappedHost;
    end;//with
    FAllowedConnectAttempts := TIdCustomMappedTelnet(Server).AllowedConnectAttempts;
    DoLocalClientConnect(Self);

    repeat
      if FAllowedConnectAttempts > 0 then begin
        Dec(FAllowedConnectAttempts);
      end;
      try
        LHostPort := Sys.Trim(Connection.IOHandler.InputLn); //~telnet input
        ExtractHostAndPortFromLine(SELF,LHostPort);

        if Length(TIdTcpClient(FOutboundClient).Host) < 1 then begin
          raise EIdException.Create(RSEmptyHost);
        end;
        TIdTcpClient(FOutboundClient).ConnectTimeout := FConnectTimeOut;
        TIdTcpClient(FOutboundClient).Connect;
      except
        on E: Exception do begin // DONE: Handle connect failures
          FNetData := 'ERROR: ['+E.ClassName+'] ' + E.Message;    {Do not Localize}
          DoOutboundClientConnect(Self,E);//?DoException(AThread,E);
          Connection.IOHandler.WriteLn(FNetData);
        end;
      end;//trye
    until FOutboundClient.Connected or (FAllowedConnectAttempts = 0);

    if FOutboundClient.Connected then begin
      DoOutboundClientConnect(Self)
    end
    else begin
      Connection.Disconnect; //prevent all next work
    end;
  end;//with
End;//TIdMappedTelnet.OutboundConnect

procedure TIdCustomMappedTelnet.SetAllowedConnectAttempts(const Value: Integer);
Begin
  if Value >= 0 then begin
    FAllowedConnectAttempts := Value
  end else begin
    FAllowedConnectAttempts := -1; //unlimited
  end;
End;//

end.
