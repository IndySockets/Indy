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
  Rev 1.4    11/15/04 11:32:50 AM  RLebeau
  Bug fix for OutboundConnect() assigning the IOHandler.ConnectTimeout property
  before the IOHandler has been assigned.

  Rev 1.3    11/14/04 11:40:00 AM  RLebeau
  Removed typecast in OutboundConnect()

  Rev 1.2    2004.02.03 5:45:52 PM  czhower
  Name changes

  Rev 1.1    2/2/2004 4:12:02 PM  JPMugaas
  Should now compile in DotNET.

  Rev 1.0    2/1/2004 4:22:50 AM  JPMugaas
  Components from IdMappedPort are now in their own units.
}

unit IdMappedTelnet;

interface

{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdMappedPortTCP,
  IdTCPServer;

type
  TIdMappedTelnetThread = class (TIdMappedPortContext)
  protected
    FAllowedConnectAttempts: Integer;
    //
    procedure OutboundConnect; override;
  public
    property  AllowedConnectAttempts: Integer read FAllowedConnectAttempts;
  end;

  TIdMappedTelnetCheckHostPort = procedure (AContext: TIdMappedPortContext; const AHostPort: String; var VHost, VPort: String) of object;

  TIdCustomMappedTelnet = class (TIdMappedPortTCP)
  protected
    FAllowedConnectAttempts: Integer;
    FOnCheckHostPort: TIdMappedTelnetCheckHostPort;

    procedure DoCheckHostPort (AThread: TIdMappedPortContext; const AHostPort: String; var VHost, VPort: String); virtual;
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
  end;

  TIdMappedTelnet = class (TIdCustomMappedTelnet)
  published
    property  AllowedConnectAttempts: Integer read FAllowedConnectAttempts write SetAllowedConnectAttempts default -1;
    //
    property  OnCheckHostPort: TIdMappedTelnetCheckHostPort read FOnCheckHostPort write FOnCheckHostPort;
  end;

implementation

uses
  IdGlobal, IdException, IdResourceStringsProtocols,
  IdIOHandlerSocket, IdTCPClient, SysUtils;

const
  NAMESEP = #0+#9+' :'; {do not localize}

{ TIdCustomMappedTelnet }

procedure TIdCustomMappedTelnet.InitComponent;
begin
  inherited InitComponent;
  FAllowedConnectAttempts := -1;
  FContextClass := TIdMappedTelnetThread;
  DefaultPort := IdPORT_TELNET;
  MappedPort := IdPORT_TELNET;
end;

procedure TIdCustomMappedTelnet.DoCheckHostPort(AContext: TIdMappedPortContext;
  const AHostPort: String; var VHost, VPort: String);
Begin
  if Assigned(FOnCheckHostPort) then begin
    FOnCheckHostPort(AContext, AHostPort, VHost, VPort);
  end;
end;

procedure TIdCustomMappedTelnet.ExtractHostAndPortFromLine(AContext: TIdMappedPortContext;
  const AHostPort: String);
var
  LHost, LPort: String;
  i : Integer;
Begin
  LHost := '';    {Do not Localize}
  LPort := '';    {Do not Localize}

  if Length(AHostPort) > 0 then
  begin
    i := 1;
    while (i <= Length(AHostPort)) and (not CharIsInSet(AHostPort, i, NAMESEP)) do
    begin
      LHost := LHost + AHostPort[i];
      Inc(i);
    end;
    Inc(i);
    while (i <= Length(AHostPort)) and (not CharIsInSet(AHostPort, i, NAMESEP)) do
    begin
      LPort := LPort + AHostPort[i];
      Inc(i);
    end;
    LHost := TrimRight(LHost);
    LPort := TrimLeft(LPort);
  end;

  DoCheckHostPort(AThread, AHostPort, LHost, LPort);

  if Length(LHost) > 0 then begin
    TIdTcpClient(AThread.OutboundClient).Host := LHost;
  end;

  if Length(LPort) > 0 then begin
    TIdTcpClient(AThread.OutboundClient).Port := IndyStrToInt(LPort, TIdTcpClient(AThread.OutboundClient).Port);
  end;
end;

procedure TIdMappedTelnetThread.OutboundConnect;
var
  LHostPort: String;
Begin
  //don`t call inherited, NEW behavior
  FOutboundClient := TIdTCPClient.Create(nil);
  with TIdCustomMappedTelnet(Server) do
  begin
    with TIdTcpClient(FOutboundClient) do begin
      Port := MappedPort;
      Host := MappedHost;
    end;//with

    Self.FAllowedConnectAttempts := AllowedConnectAttempts;
    DoLocalClientConnect(Self);

    repeat
      if FAllowedConnectAttempts > 0 then begin
        Dec(FAllowedConnectAttempts);
      end;
      try
        LHostPort := Trim(Connection.IOHandler.InputLn); //~telnet input
        ExtractHostAndPortFromLine(Self, LHostPort);

        if Length(TIdTcpClient(FOutboundClient).Host) < 1 then begin
          raise EIdException.Create(RSEmptyHost);
        end;

        with TIdTcpClient(FOutboundClient) do
        begin
          ConnectTimeout := Self.FConnectTimeOut;
          Connect;
         end;
      except
        on E: Exception do // DONE: Handle connect failures
        begin
          FNetData := 'ERROR: ['+E.ClassName+'] ' + E.Message;    {Do not Localize}
          DoException(Self, E);
          Connection.IOHandler.WriteLn(FNetData);
        end;
      end;//trye
    until FOutboundClient.Connected or (FAllowedConnectAttempts = 0);

    if FOutboundClient.Connected then begin
      DoOutboundClientConnect(Self);
    end else begin
      Connection.Disconnect; //prevent all next work
    end;
  end;//with
end;

procedure TIdCustomMappedTelnet.SetAllowedConnectAttempts(const Value: Integer);
Begin
  if Value >= 0 then begin
    FAllowedConnectAttempts := Value;
  end else begin
    FAllowedConnectAttempts := -1; //unlimited
  end;
end;

end.
