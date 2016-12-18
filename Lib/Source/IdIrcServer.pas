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

{$i IdCompilerDefines.inc}

{
Original Author: Ozz Nixon
  -RFC 1459 - Internet Relay Chat
}

uses
  IdAssignedNumbers, IdCommandHandlers, IdCmdTCPServer, IdContext, IdServerIOHandler;

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
    property DefaultPort default IdPORT_IRC;
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
  IdGlobal, IdGlobalProtocols, IdResourceStringsProtocols, IdSSL, SysUtils;

procedure TIdIRCServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_IRC;
end;

procedure TIdIRCServer.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'ADMIN'; {do not localize}
  LCommandHandler.OnCommand := DoCommandADMIN;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AWAY';  {do not localize}
  LCommandHandler.OnCommand := DoCommandAWAY;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CONNECT'; {do not localize}
  LCommandHandler.OnCommand := DoCommandCONNECT;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'ERROR'; {do not localize}
  LCommandHandler.OnCommand := DoCommandERROR;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'INFO';  {do not localize}
  LCommandHandler.OnCommand := DoCommandINFO;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'INVITE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandINVITE;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'ISON';  {do not localize}
  LCommandHandler.OnCommand := DoCommandISON;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'JOIN';  {do not localize}
  LCommandHandler.OnCommand := DoCommandJOIN;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'KICK';  {do not localize}
  LCommandHandler.OnCommand := DoCommandKICK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'KILL';  {do not localize}
  LCommandHandler.OnCommand := DoCommandKILL;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LINKS'; {do not localize}
  LCommandHandler.OnCommand := DoCommandLINKS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST';  {do not localize}
  LCommandHandler.OnCommand := DoCommandLIST;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'MODE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandMODE;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NAMES'; {do not localize}
  LCommandHandler.OnCommand := DoCommandNAMES;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NICK';  {do not localize}
  LCommandHandler.OnCommand := DoCommandNICK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NOTICE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandNOTICE;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'OPER';  {do not localize}
  LCommandHandler.OnCommand := DoCommandOPER;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PART';  {do not localize}
  LCommandHandler.OnCommand := DoCommandPART;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PASS';  {do not localize}
  LCommandHandler.OnCommand := DoCommandPASS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PING';  {do not localize}
  LCommandHandler.OnCommand := DoCommandPING;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PONG';  {do not localize}
  LCommandHandler.OnCommand := DoCommandPONG;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PRIVMSG'; {do not localize}
  LCommandHandler.OnCommand := DoCommandPRIVMSG;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'QUIT';  {do not localize}
  LCommandHandler.OnCommand := DoCommandQUIT;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'REHASH';  {do not localize}
  LCommandHandler.OnCommand := DoCommandREHASH;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'RESTART'; {do not localize}
  LCommandHandler.OnCommand := DoCommandRESTART;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SERVER';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSERVER;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SQUIT'; {do not localize}
  LCommandHandler.OnCommand := DoCommandSQUIT;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STATS'; {do not localize}
  LCommandHandler.OnCommand := DoCommandSTATS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SUMMON';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSUMMON;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'TIME';  {do not localize}
  LCommandHandler.OnCommand := DoCommandTIME;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'TOPIC'; {do not localize}
  LCommandHandler.OnCommand := DoCommandTOPIC;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'TRACE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandTRACE;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'USER';  {do not localize}
  LCommandHandler.OnCommand := DoCommandUSER;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'USERHOST';  {do not localize}
  LCommandHandler.OnCommand := DoCommandUSERHOST;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'USERS'; {do not localize}
  LCommandHandler.OnCommand := DoCommandUSERS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'VERSION'; {do not localize}
  LCommandHandler.OnCommand := DoCommandVERSION;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'WALLOPS'; {do not localize}
  LCommandHandler.OnCommand := DoCommandWALLOPS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'WHO'; {do not localize}
  LCommandHandler.OnCommand := DoCommandWHO;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'WHOIS'; {do not localize}
  LCommandHandler.OnCommand := DoCommandWHOIS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'WHOWAS';  {do not localize}
  LCommandHandler.OnCommand := DoCommandWHOWAS;

  { OTHER }
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '*^*';  {do not localize} // does not exist - so use it to handle errors
end;


{ Command handlers }

procedure TIdIRCServer.DoCommandNotHandled(ASender: TIdCommandHandler;
  ACommand: TIdCommand; const AData, AMessage: String);
begin
  ACommand.Context.Connection.IOHandler.WriteLn(IndyFormat('%s %s', ['421', RSCMDNotRecognized]));  {do not localize}
end;

procedure TIdIRCServer.DoCommandOther(ASender: TIdCommandHandler;
  ACommand: TIdCommand; const AData, AMessage: String);
begin
  if Assigned(OnCommandOther) then begin
    OnCommandOther(ACommand, ACommand.Params[0], ACommand.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPass(ASender: TIdCommand);
begin
  if Assigned(OnCommandPass) then begin
    OnCommandPass(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandNick(ASender: TIdCommand);
begin
  if Assigned(OnCommandNick) then begin
    OnCommandNick(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandUser(ASender: TIdCommand);
begin
  if Assigned(OnCommandUser) then begin
    OnCommandUser(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2], ASender.Params[3]);
  end;
end;

procedure TIdIRCServer.DoCommandServer(ASender: TIdCommand);
begin
  if Assigned(OnCommandServer) then begin
    OnCommandServer(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandOper(ASender: TIdCommand);
begin
  if Assigned(OnCommandNick) then begin
    OnCommandNick(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandQuit(ASender: TIdCommand);
begin
  if Assigned(OnCommandQuit) then begin
    OnCommandQuit(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandSQuit(ASender: TIdCommand);
begin
  if Assigned(OnCommandSQuit) then begin
    OnCommandSQuit(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandJoin(ASender: TIdCommand);
begin
  if Assigned(OnCommandJoin) then begin
    OnCommandJoin(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPart(ASender: TIdCommand);
begin
  if Assigned(OnCommandPart) then begin
    OnCommandPart(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandMode(ASender: TIdCommand);
begin
  if Assigned(OnCommandMode) then begin
    OnCommandMode(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2], ASender.Params[3], ASender.Params[4]);
  end;
end;

procedure TIdIRCServer.DoCommandTopic(ASender: TIdCommand);
begin
  if Assigned(OnCommandTopic) then begin
    OnCommandTopic(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandNames(ASender: TIdCommand);
begin
  if Assigned(OnCommandNames) then begin
    OnCommandNames(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandList(ASender: TIdCommand);
begin
  if Assigned(OnCommandList) then begin
    OnCommandList(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandInvite(ASender: TIdCommand);
begin
  if Assigned(OnCommandInvite) then begin
    OnCommandInvite(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandKick(ASender: TIdCommand);
begin
  if Assigned(OnCommandKick) then begin
    OnCommandKick(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandVersion(ASender: TIdCommand);
begin
  if Assigned(OnCommandVersion) then begin
    OnCommandVersion(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandStats(ASender: TIdCommand);
begin
  if Assigned(OnCommandStats) then begin
    OnCommandStats(ASender, ASender.Params[0], ASender.Params[1]) ;
  end;
end;

procedure TIdIRCServer.DoCommandLinks(ASender: TIdCommand);
begin
  if Assigned(OnCommandLinks) then begin
    OnCommandLinks(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandTime(ASender: TIdCommand);
var
  LTarget: String;
begin
  if Assigned(OnCommandTime) then begin
    if ASender.Params.Count > 0 then begin
      LTarget := ASender.Params[0];
    end;
    OnCommandTime(ASender, LTarget);
  end;
end;

procedure TIdIRCServer.DoCommandConnect(ASender: TIdCommand);
begin
  if Assigned(OnCommandConnect) then begin
    OnCommandConnect(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandTrace(ASender: TIdCommand);
begin
  if Assigned(OnCommandTrace) then begin
    OnCommandTrace(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandAdmin(ASender: TIdCommand);
begin
  if Assigned(OnCommandAdmin) then begin
    OnCommandAdmin(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandInfo(ASender: TIdCommand);
begin
  if Assigned(OnCommandInfo) then begin
    OnCommandInfo(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandPrivMsg(ASender: TIdCommand);
begin
  if Assigned(OnCommandPrivMsg) then begin
    OnCommandPrivMsg(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandNotice(ASender: TIdCommand);
begin
  if Assigned(OnCommandNotice) then begin
    OnCommandNotice(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWho(ASender: TIdCommand);
begin
  if Assigned(OnCommandWho) then begin
    OnCommandWho(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWhoIs(ASender: TIdCommand);
begin
  if Assigned(OnCommandWhoIs) then begin
    OnCommandWhoIs(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandWhoWas(ASender: TIdCommand);
begin
  if Assigned(OnCommandWhoWas) then begin
    OnCommandWhoWas(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRCServer.DoCommandKill(ASender: TIdCommand);
begin
  if Assigned(OnCommandKill) then begin
    OnCommandKill(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPing(ASender: TIdCommand);
begin
  if Assigned(OnCommandPing) then begin
    OnCommandPing(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandPong(ASender: TIdCommand);
begin
  if Assigned(OnCommandPong) then begin
    OnCommandPong(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandError(ASender: TIdCommand);
begin
  if Assigned(OnCommandError) then begin
    OnCommandError(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandAway(ASender: TIdCommand);
begin
  if Assigned(OnCommandAway) then begin
    OnCommandAway(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandRehash(ASender: TIdCommand);
begin
  if Assigned(OnCommandRehash) then begin
    OnCommandRehash(ASender);
  end;
end;

procedure TIdIRCServer.DoCommandRestart(ASender: TIdCommand);
begin
  if Assigned(OnCommandRestart) then begin
    OnCommandRestart(ASender);
  end;
end;

procedure TIdIRCServer.DoCommandSummon(ASender: TIdCommand);
begin
  if Assigned(OnCommandSummon) then begin
    OnCommandSummon(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRCServer.DoCommandUsers(ASender: TIdCommand);
begin
  if Assigned(OnCommandUsers) then begin
    OnCommandUsers(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandWallops(ASender: TIdCommand);
begin
  if Assigned(OnCommandWallops) then begin
    OnCommandWallops(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandUserHost(ASender: TIdCommand);
begin
  if Assigned(OnCommandUserHost) then begin
    OnCommandUserHost(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoCommandIsOn(ASender: TIdCommand);
begin
  if Assigned(OnCommandIsOn) then begin
    OnCommandIsOn(ASender, ASender.Params[0]);
  end;
end;

procedure TIdIRCServer.DoConnect(AContext: TIdContext);
begin
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough := False;
  end;
  inherited DoConnect(AContext);
end;

procedure TIdIRCServer.SetIOHandler(const AValue: TIdServerIOHandler);
begin
  inherited SetIOHandler(AValue);
  //we do it this way so that if a user is using a custom value <> default, the default port
  //is not set when the IOHandler is changed.
  if IOHandler is TIdServerIOHandlerSSLBase then
  begin
    if DefaultPort = IdPORT_IRC then begin
      DefaultPort := IdPORT_IRCS;
    end;
  end else
  begin
    if DefaultPort = IdPORT_IRCS then begin
      DefaultPort := IdPORT_IRC;
    end;
  end;
end;

end.

