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
  Rev 1.10    2004.02.03 5:43:56 PM  czhower
  Name changes

  Rev 1.9    1/21/2004 3:11:20 PM  JPMugaas
  InitComponent

  Rev 1.8    10/19/2003 5:23:20 PM  DSiders
  Added localization comments.

  Rev 1.7    2003.10.18 9:42:08 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.6    8/2/2003 05:03:46 AM  JPMugaas
  Hopefully should now support IRCS (IRC over TLS/SSL)

  Rev 1.5    7/18/2003 4:26:30 PM  SPerry
  New IRC server using command handlers

  Rev 1.4    2/24/2003 09:07:18 PM  JPMugaas

  Rev 1.3    1/17/2003 07:10:36 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.2    1-1-2003 20:13:22  BGooijen
  Changed to support the new TIdContext class

  Rev 1.1    12/7/2002 06:43:02 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 07:55:52 AM  JPMugaas

  2002-10-July: Sergio Perry
    -Switched to using TIdCmdServer

  2002-17-Aug: Bas Gooijen
    -Changed to DoXXXXX

  2000-15-May:  Renamed events to Id Prefix

  2000-22-Apr: J Peter Mugass
    -Ported to Indy

  2000-13-Jan MTL
    -Moved to new Palette Scheme (Winshoes Servers)

  1999-13-Apr
    -Final Version
}

unit IdIrcServer;

interface

{
  Original Author: Ozz Nixon
  -RFC 1459 - Internet Relay Chat
}

uses
  IdCommandHandlers, IdCmdTCPServer, IdContext, IdServerIOHandler;

type
  { Events }
  TIdIRCGetEvent = procedure(AContext: TIdCommand) of object;
  TIdIRCOtherEvent = procedure(AContext: TIdCommand; Command, AParm: string) of object;
  TIdIRCOneParmEvent = procedure(AContext: TIdCommand; AParm: string) of object;
  TIdIRCTwoParmEvent = procedure(AContext: TIdCommand; AParm1, AParm2: string) of object;
  TIdIRCThreeParmEvent = procedure(AContext: TIdCommand; AParm1, AParm2, AParm3: string) of object;
  TIdIRCFiveParmEvent = procedure(AContext: TIdCommand; AParm1, AParm2, AParm3, AParm4, AParm5: string) of object;
  TIdIRCUserEvent = procedure(AContext: TIdCommand; UserName, HostName, ServerName, RealName: string) of object;
  TIdIRCServerEvent = procedure(AContext: TIdCommand; ServerName, Hopcount, Info: string) of object;

  { TIdIRCServer }
  TIdIRCServer = class(TIdCmdTCPServer)
  protected
    fOnCommandOther: TIdIRCOtherEvent;
    fOnCommandPass: TIdIRCOneParmEvent;
    fOnCommandNick: TIdIRCTwoParmEvent;
    fOnCommandUser: TIdIRCUserEvent;
    fOnCommandServer: TIdIRCServerEvent;
    fOnCommandOper: TIdIRCTwoParmEvent;
    fOnCommandQuit: TIdIRCOneParmEvent;
    fOnCommandSQuit: TIdIRCTwoParmEvent;
    fOnCommandJoin: TIdIRCTwoParmEvent;
    fOnCommandPart: TIdIRCOneParmEvent;
    fOnCommandMode: TIdIRCFiveParmEvent;
    fOnCommandTopic: TIdIRCTwoParmEvent;
    fOnCommandNames: TIdIRCOneParmEvent;
    fOnCommandList: TIdIRCTwoParmEvent;
    fOnCommandInvite: TIdIRCTwoParmEvent;
    fOnCommandKick: TIdIRCThreeParmEvent;
    fOnCommandVersion: TIdIRCOneParmEvent;
    fOnCommandStats: TIdIRCTwoParmEvent;
    fOnCommandLinks: TIdIRCTwoParmEvent;
    fOnCommandTime: TIdIRCOneParmEvent;
    fOnCommandConnect: TIdIRCThreeParmEvent;
    fOnCommandTrace: TIdIRCOneParmEvent;
    fOnCommandAdmin: TIdIRCOneParmEvent;
    fOnCommandInfo: TIdIRCOneParmEvent;
    fOnCommandPrivMsg: TIdIRCTwoParmEvent;
    fOnCommandNotice: TIdIRCTwoParmEvent;
    fOnCommandWho: TIdIRCTwoParmEvent;
    fOnCommandWhoIs: TIdIRCTwoParmEvent;
    fOnCommandWhoWas: TIdIRCThreeParmEvent;
    fOnCommandKill: TIdIRCTwoParmEvent;
    fOnCommandPing: TIdIRCTwoParmEvent;
    fOnCommandPong: TIdIRCTwoParmEvent;
    fOnCommandError: TIdIRCOneParmEvent;
    fOnCommandAway: TIdIRCOneParmEvent;
    fOnCommandRehash: TIdIRCGetEvent;
    fOnCommandRestart: TIdIRCGetEvent;
    fOnCommandSummon: TIdIRCTwoParmEvent;
    fOnCommandUsers: TIdIRCOneParmEvent;
    fOnCommandWallops: TIdIRCOneParmEvent;
    fOnCommandUserHost: TIdIRCOneParmEvent;
    fOnCommandIsOn: TIdIRCOneParmEvent;
    //
    procedure InitializeCommandHandlers; override;
    //
    procedure DoCommandOther(ASender: TIdCommandHandler; ACommand: TIdCommand;
      const AData, AMessage: String);
    procedure DoCommandPass(ASender: TIdCommand);
    procedure DoCommandNick(ASender: TIdCommand);
    procedure DoCommandUser(ASender: TIdCommand);
    procedure DoCommandServer(ASender: TIdCommand);
    procedure DoCommandOper(ASender: TIdCommand);
    procedure DoCommandQuit(ASender: TIdCommand);
    procedure DoCommandSQuit(ASender: TIdCommand);
    procedure DoCommandJoin(ASender: TIdCommand);
    procedure DoCommandPart(ASender: TIdCommand);
    procedure DoCommandMode(ASender: TIdCommand);
    procedure DoCommandTopic(ASender: TIdCommand);
    procedure DoCommandNames(ASender: TIdCommand);
    procedure DoCommandList(ASender: TIdCommand);
    procedure DoCommandInvite(ASender: TIdCommand);
    procedure DoCommandKick(ASender: TIdCommand);
    procedure DoCommandVersion(ASender: TIdCommand);
    procedure DoCommandStats(ASender: TIdCommand);
    procedure DoCommandLinks(ASender: TIdCommand);
    procedure DoCommandTime(ASender: TIdCommand);
    procedure DoCommandConnect(ASender: TIdCommand);
    procedure DoCommandTrace(ASender: TIdCommand);
    procedure DoCommandAdmin(ASender: TIdCommand);
    procedure DoCommandInfo(ASender: TIdCommand);
    procedure DoCommandPrivMsg(ASender: TIdCommand);
    procedure DoCommandNotice(ASender: TIdCommand);
    procedure DoCommandWho(ASender: TIdCommand);
    procedure DoCommandWhoIs(ASender: TIdCommand);
    procedure DoCommandWhoWas(ASender: TIdCommand);
    procedure DoCommandKill(ASender: TIdCommand);
    procedure DoCommandPing(ASender: TIdCommand);
    procedure DoCommandPong(ASender: TIdCommand);
    procedure DoCommandError(ASender: TIdCommand);
    procedure DoCommandAway(ASender: TIdCommand);
    procedure DoCommandRehash(ASender: TIdCommand);
    procedure DoCommandRestart(ASender: TIdCommand);
    procedure DoCommandSummon(ASender: TIdCommand);
    procedure DoCommandUsers(ASender: TIdCommand);
    procedure DoCommandWallops(ASender: TIdCommand);
    procedure DoCommandUserHost(ASender: TIdCommand);
    procedure DoCommandIsOn(ASender: TIdCommand);
    procedure DoCommandNotHandled(ASender: TIdCommandHandler; ACommand: TIdCommand;
      const AData, AMessage: String);
    //overrides for TLS support
    procedure DoConnect(AContext: TIdContext); override;
    procedure SetIOHandler(const AValue: TIdServerIOHandler); override;
    procedure InitComponent; override;
  published
    property OnCommandPass: TIdIRCOneParmEvent read fOnCommandPass write fOnCommandPass;
    property OnCommandNick: TIdIRCTwoParmEvent read fOnCommandNick write fOnCommandNick;
    property OnCommandUser: TIdIRCUserEvent read fOnCommandUser write fOnCommandUser;
    property OnCommandServer: TIdIRCServerEvent read fOnCommandServer write fOnCommandServer;
    property OnCommandOper: TIdIRCTwoParmEvent read fOnCommandOper write fOnCommandOper;
    property OnCommandQuit: TIdIRCOneParmEvent read fOnCommandQuit write fOnCommandQuit;
    property OnCommandSQuit: TIdIRCTwoParmEvent read fOnCommandSQuit write fOnCommandSQuit;
    property OnCommandJoin: TIdIRCTwoParmEvent read fOnCommandJoin write fOnCommandJoin;
    property OnCommandPart: TIdIRCOneParmEvent read fOnCommandPart write fOnCommandPart;
    property OnCommandMode: TIdIRCFiveParmEvent read fOnCommandMode write fOnCommandMode;
    property OnCommandTopic: TIdIRCTwoParmEvent read fOnCommandTopic write fOnCommandTopic;
    property OnCommandNames: TIdIRCOneParmEvent read fOnCommandNames write fOnCommandNames;
    property OnCommandList: TIdIRCTwoParmEvent read fOnCommandList write fOnCommandList;
    property OnCommandInvite: TIdIRCTwoParmEvent read fOnCommandInvite write fOnCommandInvite;
    property OnCommandKick: TIdIRCThreeParmEvent read fOnCommandKick write fOnCommandKick;
    property OnCommandVersion: TIdIRCOneParmEvent read fOnCommandVersion write fOnCommandVersion;
    property OnCommandStats: TIdIRCTwoParmEvent read fOnCommandStats write fOnCommandStats;
    property OnCommandLinks: TIdIRCTwoParmEvent read fOnCommandLinks write fOnCommandLinks;
    property OnCommandTime: TIdIRCOneParmEvent read fOnCommandTime write fOnCommandTime;
    property OnCommandConnect: TIdIRCThreeParmEvent read fOnCommandConnect write fOnCommandConnect;
    property OnCommandTrace: TIdIRCOneParmEvent read fOnCommandTrace write fOnCommandTrace;
    property OnCommandAdmin: TIdIRCOneParmEvent read fOnCommandAdmin write fOnCommandAdmin;
    property OnCommandInfo: TIdIRCOneParmEvent read fOnCommandInfo write fOnCommandInfo;
    property OnCommandPrivMsg: TIdIRCTwoParmEvent read fOnCommandPrivMsg write fOnCommandPrivMsg;
    property OnCommandNotice: TIdIRCTwoParmEvent read fOnCommandNotice write fOnCommandNotice;
    property OnCommandWho: TIdIRCTwoParmEvent read fOnCommandWho write fOnCommandWho;
    property OnCommandWhoIs: TIdIRCTwoParmEvent read fOnCommandWhoIs write fOnCommandWhoIs;
    property OnCommandWhoWas: TIdIRCThreeParmEvent read fOnCommandWhoWas write fOnCommandWhoWas;
    property OnCommandKill: TIdIRCTwoParmEvent read fOnCommandKill write fOnCommandKill;
    property OnCommandPing: TIdIRCTwoParmEvent read fOnCommandPing write fOnCommandPing;
    property OnCommandPong: TIdIRCTwoParmEvent read fOnCommandPong write fOnCommandPong;
    property OnCommandError: TIdIRCOneParmEvent read fOnCommandError write fOnCommandError;
    property OnCommandAway: TIdIRCOneParmEvent read fOnCommandAway write fOnCommandAway;
    property OnCommandRehash: TIdIRCGetEvent read fOnCommandRehash write fOnCommandRehash;
    property OnCommandRestart: TIdIRCGetEvent read fOnCommandRestart write fOnCommandRestart;
    property OnCommandSummon: TIdIRCTwoParmEvent read fOnCommandSummon write fOnCommandSummon;
    property OnCommandUsers: TIdIRCOneParmEvent read fOnCommandUsers write fOnCommandUsers;
    property OnCommandWallops: TIdIRCOneParmEvent read fOnCommandWallops write fOnCommandWallops;
    property OnCommandUserHost: TIdIRCOneParmEvent read fOnCommandUserHost write fOnCommandUserHost;
    property OnCommandIsOn: TIdIRCOneParmEvent read fOnCommandIsOn write fOnCommandIsOn;
    property OnCommandOther: TIdIRCOtherEvent read fOnCommandOther write fOnCommandOther;
  end;

implementation

uses
  IdAssignedNumbers, IdGlobal, IdGlobalProtocols, IdResourceStringsProtocols, IdSSL, IdSys;

procedure TIdIRCServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_IRC;
end;

procedure TIdIRCServer.InitializeCommandHandlers;
begin
  with CommandHandlers.Add do
  begin
    Command := 'ADMIN'; {do not localize}
    OnCommand := DoCommandADMIN;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'AWAY';  {do not localize}
    OnCommand := DoCommandAWAY;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'CONNECT'; {do not localize}
    OnCommand := DoCommandCONNECT;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'ERROR'; {do not localize}
    OnCommand := DoCommandERROR;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'INFO';  {do not localize}
    OnCommand := DoCommandINFO;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'INVITE';  {do not localize}
    OnCommand := DoCommandINVITE;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'ISON';  {do not localize}
    OnCommand := DoCommandISON;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'JOIN';  {do not localize}
    OnCommand := DoCommandJOIN;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'KICK';  {do not localize}
    OnCommand := DoCommandKICK;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'KILL';  {do not localize}
    OnCommand := DoCommandKILL;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'LINKS'; {do not localize}
    OnCommand := DoCommandLINKS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'LIST';  {do not localize}
    OnCommand := DoCommandLIST;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'MODE';  {do not localize}
    OnCommand := DoCommandMODE;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'NAMES'; {do not localize}
    OnCommand := DoCommandNAMES;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'NICK';  {do not localize}
    OnCommand := DoCommandNICK;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'NOTICE';  {do not localize}
    OnCommand := DoCommandNOTICE;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'OPER';  {do not localize}
    OnCommand := DoCommandOPER;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'PART';  {do not localize}
    OnCommand := DoCommandPART;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'PASS';  {do not localize}
    OnCommand := DoCommandPASS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'PING';  {do not localize}
    OnCommand := DoCommandPING;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'PONG';  {do not localize}
    OnCommand := DoCommandPONG;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'PRIVMSG'; {do not localize}
    OnCommand := DoCommandPRIVMSG;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'QUIT';  {do not localize}
    OnCommand := DoCommandQUIT;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'REHASH';  {do not localize}
    OnCommand := DoCommandREHASH;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'RESTART'; {do not localize}
    OnCommand := DoCommandRESTART;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'SERVER';  {do not localize}
    OnCommand := DoCommandSERVER;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'SQUIT'; {do not localize}
    OnCommand := DoCommandSQUIT;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'STATS'; {do not localize}
    OnCommand := DoCommandSTATS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'SUMMON';  {do not localize}
    OnCommand := DoCommandSUMMON;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'TIME';  {do not localize}
    OnCommand := DoCommandTIME;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'TOPIC'; {do not localize}
    OnCommand := DoCommandTOPIC;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'TRACE'; {do not localize}
    OnCommand := DoCommandTRACE;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'USER';  {do not localize}
    OnCommand := DoCommandUSER;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'USERHOST';  {do not localize}
    OnCommand := DoCommandUSERHOST;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'USERS'; {do not localize}
    OnCommand := DoCommandUSERS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'VERSION'; {do not localize}
    OnCommand := DoCommandVERSION;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'WALLOPS'; {do not localize}
    OnCommand := DoCommandWALLOPS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'WHO'; {do not localize}
    OnCommand := DoCommandWHO;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'WHOIS'; {do not localize}
    OnCommand := DoCommandWHOIS;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'WHOWAS';  {do not localize}
    OnCommand := DoCommandWHOWAS;
  end;
  { OTHER }
  with CommandHandlers.Add do
  begin
    Command := '*^*';  {do not localize} // does not exist - so use it to handle errors
  end;
end;


{ Command handlers }

procedure TIdIRCServer.DoCommandNotHandled(ASender: TIdCommandHandler;
  ACommand: TIdCommand; const AData, AMessage: String);
begin
  ACommand.Context.Connection.IOHandler.WriteLn(Sys.Format('%s %s', ['421', RSCMDNotRecognized]));  {do not localize}
end;

procedure TIdIRCServer.DoCommandOther(ASender: TIdCommandHandler;
  ACommand: TIdCommand; const AData, AMessage: String);
begin
  if Assigned(OnCommandOther) then
  begin
    OnCommandOther(ACommand, ACommand.Params[0], ACommand.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPass(ASender: TIdCommand);
begin
  if Assigned(OnCommandPass) then
  begin
    OnCommandPass(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandNick(ASender: TIdCommand);
begin
  if Assigned(OnCommandNick) then
  begin
    OnCommandNick(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandUser(ASender: TIdCommand);
begin
  if Assigned(OnCommandUser) then
  begin
    OnCommandUser(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2],
      ASender.Params[3]);
  end;
end;

procedure TIdIRCServer.DoCommandServer(ASender: TIdCommand);
begin
  if Assigned(OnCommandServer) then
  begin
    OnCommandServer(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandOper(ASender: TIdCommand);
begin
  if Assigned(OnCommandNick) then
  begin
    OnCommandNick(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandQuit(ASender: TIdCommand);
begin
  if Assigned(OnCommandQuit) then
  begin
    OnCommandQuit(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandSQuit(ASender: TIdCommand);
begin
  if Assigned(OnCommandSQuit) then
  begin
    OnCommandSQuit(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandJoin(ASender: TIdCommand);
begin
  if Assigned(OnCommandJoin) then
  begin
    OnCommandJoin(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPart(ASender: TIdCommand);
begin
  if Assigned(OnCommandPart) then
  begin
    OnCommandPart(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandMode(ASender: TIdCommand);
begin
  if Assigned(OnCommandMode) then
  begin
    OnCommandMode(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2],
      ASender.Params[3], ASender.Params[4]);
  end;
end;

procedure TIdIRCServer.DoCommandTopic(ASender: TIdCommand);
begin
  if Assigned(OnCommandTopic) then
  begin
    OnCommandTopic(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandNames(ASender: TIdCommand);
begin
  if Assigned(OnCommandNames) then
  begin
    OnCommandNames(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandList(ASender: TIdCommand);
begin
  if Assigned(OnCommandList) then
  begin
    OnCommandList(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandInvite(ASender: TIdCommand);
begin
  if Assigned(OnCommandInvite) then
  begin
    OnCommandInvite(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandKick(ASender: TIdCommand);
begin
  if Assigned(OnCommandKick) then
  begin
    OnCommandKick(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandVersion(ASender: TIdCommand);
begin
  if Assigned(OnCommandVersion) then
  begin
    OnCommandVersion(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandStats(ASender: TIdCommand);
begin
  if Assigned(OnCommandStats) then
  begin
    OnCommandStats(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandLinks(ASender: TIdCommand);
begin
  if Assigned(OnCommandLinks) then
  begin
    OnCommandLinks(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandTime(ASender: TIdCommand);
begin
  if Assigned(OnCommandTime) then
  begin
    OnCommandTime(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandConnect(ASender: TIdCommand);
begin
  if Assigned(OnCommandConnect) then
  begin
    OnCommandConnect(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandTrace(ASender: TIdCommand);
begin
  if Assigned(OnCommandTrace) then
  begin
    OnCommandTrace(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandAdmin(ASender: TIdCommand);
begin
  if Assigned(OnCommandAdmin) then
  begin
    OnCommandAdmin(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandInfo(ASender: TIdCommand);
begin
  if Assigned(OnCommandInfo) then
  begin
    OnCommandInfo(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandPrivMsg(ASender: TIdCommand);
begin
  if Assigned(OnCommandPrivMsg) then
  begin
    OnCommandPrivMsg(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandNotice(ASender: TIdCommand);
begin
  if Assigned(OnCommandNotice) then
  begin
    OnCommandNotice(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWho(ASender: TIdCommand);
begin
  if Assigned(OnCommandWho) then
  begin
    OnCommandWho(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWhoIs(ASender: TIdCommand);
begin
  if Assigned(OnCommandWhoIs) then
  begin
    OnCommandWhoIs(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWhoWas(ASender: TIdCommand);
begin
  if Assigned(OnCommandWhoWas) then
  begin
    OnCommandWhoWas(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandKill(ASender: TIdCommand);
begin
  if Assigned(OnCommandKill) then
  begin
    OnCommandKill(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPing(ASender: TIdCommand);
begin
  if Assigned(OnCommandPing) then
  begin
    OnCommandPing(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPong(ASender: TIdCommand);
begin
  if Assigned(OnCommandPong) then
  begin
    OnCommandPong(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandError(ASender: TIdCommand);
begin
  if Assigned(OnCommandError) then
  begin
    OnCommandError(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandAway(ASender: TIdCommand);
begin
  if Assigned(OnCommandAway) then
  begin
    OnCommandAway(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandRehash(ASender: TIdCommand);
begin
  if Assigned(OnCommandRehash) then
  begin
    OnCommandRehash(ASender);
  end;
end;

procedure TIdIRCServer.DoCommandRestart(ASender: TIdCommand);
begin
  if Assigned(OnCommandRestart) then
  begin
    OnCommandRestart(ASender);
  end;
end;

procedure TIdIRCServer.DoCommandSummon(ASender: TIdCommand);
begin
  if Assigned(OnCommandSummon) then
  begin
    OnCommandSummon(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandUsers(ASender: TIdCommand);
begin
  if Assigned(OnCommandUsers) then
  begin
    OnCommandUsers(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandWallops(ASender: TIdCommand);
begin
  if Assigned(OnCommandWallops) then
  begin
    OnCommandWallops(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandUserHost(ASender: TIdCommand);
begin
  if Assigned(OnCommandUserHost) then
  begin
    OnCommandUserHost(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandIsOn(ASender: TIdCommand);
begin
  if Assigned(OnCommandIsOn) then
  begin
    OnCommandIsOn(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoConnect(AContext: TIdContext);
begin
  inherited;
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough:=false;
  end;
end;

procedure TIdIRCServer.SetIOHandler(const AValue: TIdServerIOHandler);
begin
  inherited;
  //we do it this way so that if a user is using a custom value <> default, the default port
  //is not set when the IOHandler is changed.
  if (IOHandler is TIdServerIOHandlerSSLBase) then
  begin
    if DefaultPort = IdPORT_IRC then
    begin
      DefaultPort := IdPORT_IRCS;
    end;
  end
  else
  begin
    if DefaultPort = IdPORT_IRCS then
    begin
      DefaultPort := IdPORT_IRC;
    end;
  end;
end;

end.

