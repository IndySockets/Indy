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
  Rev 1.6    2/8/05 5:58:32 PM  RLebeau
  Updated InitComponent() to call TIdReply.SetReply() instead of setting the
  Code and Text properties individually

  Rev 1.5    11/15/04 11:31:20 AM  RLebeau
  Bug fix for OutboundConnect() assigning the IOHandler.ConnectTimeout property
  before the IOHandler has been assigned.

  Rev 1.4    11/14/04 11:39:24 AM  RLebeau
  Updated OutboundConnect() to send the Greeting

  Rev 1.3    5/18/04 1:02:02 PM  RLebeau
  Removed GetReplyClass() and GetRepliesClass() overrides.

  Rev 1.2    5/16/04 5:28:40 PM  RLebeau
  Added GetReplyClass() and GetRepliesClass() overrides.

  Rev 1.1    2004.02.03 5:45:52 PM  czhower
  Name changes

  Rev 1.0    2/2/2004 4:11:36 PM  JPMugaas
  Recased to be consistant with IdPOP3 and IdPOP3Server.  I also fixed several
  bugs that could cause AV's.

  Rev 1.0    2/1/2004 4:22:48 AM  JPMugaas
  Components from IdMappedPort are now in their own units.
}

unit IdMappedPOP3;

interface

{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdMappedPortTCP, IdMappedTelnet, IdReplyPOP3,
  IdTCPServer;

type

  TIdMappedPOP3Thread = class (TIdMappedTelnetThread)
  protected
    procedure OutboundConnect; override;
  public
  End;//TIdMappedPOP3Thread

  TIdMappedPOP3 = class (TIdMappedTelnet)
  protected
    FReplyUnknownCommand: TIdReplyPOP3;
    FGreeting: TIdReplyPOP3;
    FUserHostDelimiter: String;
    procedure InitComponent; override;
    procedure SetGreeting(AValue: TIdReplyPOP3);
    procedure SetReplyUnknownCommand(const AValue: TIdReplyPOP3);
  public
    destructor Destroy; override;
  published
    property Greeting : TIdReplyPOP3 read FGreeting write SetGreeting;
    property ReplyUnknownCommand: TIdReplyPOP3 read FReplyUnknownCommand
     write SetReplyUnknownCommand;
    property DefaultPort default IdPORT_POP3;
    property MappedPort default IdPORT_POP3;
    property UserHostDelimiter: String read FUserHostDelimiter write FUserHostDelimiter;
  End;//TIdMappedPOP3

implementation

uses
  IdGlobal, IdException, IdIOHandlerSocket, IdResourceStringsProtocols, IdTCPClient
  , IdTCPConnection, SysUtils;

{ TIdMappedPOP3 }

destructor TIdMappedPOP3.Destroy;
begin
  FreeAndNil(FReplyUnknownCommand);
  FreeAndNil(FGreeting);
  inherited Destroy;
end;

procedure TIdMappedPOP3.InitComponent;
Begin
  inherited InitComponent;

  FUserHostDelimiter := '#';//standard    {Do not Localize}
  FGreeting := TIdReplyPOP3.Create(nil);
  FGreeting.SetReply('+OK', RSPop3ProxyGreeting);    {Do not Localize}

  FReplyUnknownCommand := TIdReplyPOP3.Create(nil);
  FReplyUnknownCommand.SetReply('-ERR', RSPop3UnknownCommand);  {Do not Localize}

  DefaultPort := IdPORT_POP3;
  MappedPort := IdPORT_POP3;
  FContextClass := TIdMappedPOP3Thread;
end;

procedure TIdMappedPOP3.SetGreeting(AValue: TIdReplyPOP3);
begin
   FGreeting.Assign(AValue);
end;

procedure TIdMappedPOP3.SetReplyUnknownCommand(const AValue: TIdReplyPOP3);
begin
  FReplyUnknownCommand.Assign(AValue);
end;

{ TIdMappedPOP3Thread }

procedure TIdMappedPOP3Thread.OutboundConnect;
var
  LHostPort,LUserName,LPop3Cmd: String;
Begin
  //don`t call inherited, NEW behavior
  with TIdMappedPOP3(Server) do begin
    Connection.IOHandler.Write(Greeting.FormattedReply);   

    FOutboundClient := TIdTCPClient.Create(nil);
    with TIdTcpClient(FOutboundClient) do begin
      Port := MappedPort;
      Host := MappedHost;
    end;//with
    FAllowedConnectAttempts := TIdMappedPOP3(Server).AllowedConnectAttempts;
    DoLocalClientConnect(Self);

    repeat
      if FAllowedConnectAttempts > 0 then begin
        Dec(FAllowedConnectAttempts);
      end;
      try
        // Greeting
        LHostPort := Trim(Connection.IOHandler.ReadLn);//USER username#host OR QUIT
        LPop3Cmd := Fetch(LHostPort, ' ', True);    {Do not Localize}
        if TextIsSame(LPop3Cmd, 'QUIT') then begin    {Do not Localize}
          Connection.IOHandler.WriteLn('+OK ' + RSPop3QuitMsg);    {Do not Localize}
          Connection.Disconnect;
          Break;
        end else if TextIsSame(LPop3Cmd, 'USER') then begin    {Do not Localize}
          LUserName := Fetch(LHostPort, FUserHostDelimiter, True, False);//?:CaseSensetive
          FNetData := LUserName; //save for OnCheckHostPort
          LHostPort := TrimLeft(LHostPort); //TrimRight above
          ExtractHostAndPortFromLine(Self, LHostPort);
          LUserName := FNetData; //allow username substitution
        end else begin
          Connection.IOHandler.Write(ReplyUnknownCommand.FormattedReply);
          Continue;
        end;//if

        if Length(TIdTcpClient(FOutboundClient).Host) < 1 then begin
          raise EIdException.Create(RSEmptyHost);
        end;

        TIdTcpClient(FOutboundClient).ConnectTimeout := FConnectTimeOut;
        TIdTcpClient(FOutboundClient).Connect;
        FNetData := FOutboundClient.IOHandler.ReadLn;//Read Pop3 Banner for OnOutboundClientConnect

        FOutboundClient.IOHandler.WriteLn('USER ' + LUserName);    {Do not Localize}
      except
        on E: Exception do begin // DONE: Handle connect failures
          FNetData := '-ERR [' + E.ClassName + '] ' + E.Message;    {Do not Localize}
          DoOutboundClientConnect(Self, E);//?DoException(AThread,E);
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

end.
