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
  2003-11-Jul:
    Original author: Sergio Perry
    Matthew Elzer - bug fixes & modifications
}

unit IdIRC;

{
  Based on TIRCClient component by Steve Williams (stevewilliams@kromestudios.com)
  ported to Indy by Daaron Dwyer (ddwyer@ncic.com)
}

interface

uses
  Classes,
  IdAssignedNumbers, IdContext, IdCmdTCPClient, IdCommandHandlers,
  IdIOHandler, IdGlobal, IdException;

type
  TIdIRC = class;

  TIdIRCUserMode = (amAway, amInvisible, amWallops, amRestricted, amOperator, amLocalOperator, amReceiveServerNotices);
  TIdIRCUserModes = set of TIdIRCUserMode;

  TIdIRCStat = (stServerConnectionsList, stCommandUsageCount, stOperatorList, stUpTime);

  { -WELCOME- }
  TIdIRCServerWelcomeEvent = procedure(ASender: TIdContext; AWelcomeInfo: TStrings) of object;
  TIdIRCPingPongEvent = procedure(ASender: TIdContext) of object;
  { -MESSAGE- }
  TIdIRCPrivMessageEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, AMessage: String) of object;
  { -NOTICE- }
  TIdIRCNoticeEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, ANotice: String) of object;
  { -REHASH- }
  TIdIRCRehashEvent = procedure(ASender: TIdContext; const ANickname, AHost: String) of object;
  { -SUMMON- }
  TIdIRCSummonEvent = procedure(ASender: TIdContext; const ANickname, AHost: String) of object;
  { -WALLOPS- }
  TIdIRCWallopsEvent = procedure(ASender: TIdContext; const ANickname, AHost, AMessage: String) of object;
  { -ISON- }
  TIdIRCIsOnIRCEvent = procedure(ASender: TIdContext; const ANickname, AHost: String) of object;
  { -AWAY- }
  TIdIRCAwayEvent = procedure(ASender: TIdContext; const ANickname, AHost, AAwayMessage: String; UserAway: Boolean) of object;
  { -JOIN- }
  TIdIRCJoinEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel: String) of object;
  { -PART- }
  TIdIRCPartEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel: String) of object;
  { -TOPIC- }
  TIdIRCTopicEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel, ATopic: String) of object;
  { -KICK- }
  TIdIRCKickEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel, ATarget, AReason: String) of object;
  { -MOTD- }
  TIdIRCMOTDEvent = procedure(ASender: TIdContext; AMOTD: TStrings) of object;
  { -TRACE- }
  TIdIRCServerTraceEvent = procedure(ASender: TIdContext; ATraceInfo: TStrings) of object;
  { -OPER- }
  TIdIRCOpEvent = procedure(ASender: TIdContext; const ANickname, AChannel, AHost: String) of object;
  { -INV- }
  TIdIRCInvitingEvent = procedure(ASender: TIdContext; const ANickname, AHost: String) of object;
  TIdIRCInviteEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, AChannel: String) of object;
  { -LIST- }
  TIdIRCChanBANListEvent = procedure(ASender: TIdContext; const AChannel: String; ABanList: TStrings) of object;
  TIdIRCChanEXCListEvent = procedure(ASender: TIdContext; const AChannel: String; AExceptList: TStrings) of object;
  TIdIRCChanINVListEvent = procedure(ASender: TIdContext; const AChannel: String; AInviteList: TStrings) of object;
  TIdIRCServerListEvent = procedure(ASender: TIdContext; AServerList: TStrings) of object;
  TIdIRCNickListEvent = procedure(ASender: TIdContext; const AChannel: String; ANicknameList: TStrings) of object;
  { -STATS- }
  TIdIRCServerUsersEvent = procedure(ASender: TIdContext; AUsers: TStrings) of object;
  TIdIRCServerStatsEvent = procedure(ASender: TIdContext; AStatus: TStrings) of object;
  TIdIRCKnownServerNamesEvent = procedure(ASender: TIdContext; AKnownServers: TStrings) of object;
  { -INFO- }
  TIdIRCAdminInfoRecvEvent = procedure(ASender: TIdContext; AAdminInfo: TStrings) of object;
  TIdIRCUserInfoRecvEvent = procedure(ASender: TIdContext; AUserInfo: TStrings) of object;
  { -WHO- }
  TIdIRCWhoEvent = procedure(ASender: TIdContext; AWhoResults: TStrings) of object;
  TIdIRCWhoIsEvent = procedure(ASender: TIdContext; AWhoIsResults: TStrings) of object;
  TIdIRCWhoWasEvent = procedure(ASender: TIdContext; AWhoWasResults: TStrings) of object;
  { Mode }
  TIdIRCChanModeEvent = procedure(ASender: TIdContext) of object;
  TIdIRCUserModeEvent = procedure(ASender: TIdContext; const ANickname, AHost, AUserMode: String) of object;
  { -CTCP- }
  TIdIRCCTCPQueryEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, AChannel, ACommand, AParams: String) of object;
  TIdIRCCTCPReplyEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, AChannel, ACommand, AParams: String) of object;
  { -DCC- }
  TIdIRCDCCChatEvent = procedure(ASender: TIdContext; const ANickname, AHost: String; APort: Integer) of object;
  TIdIRCDCCSendEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort, AFileSize: Integer) of object;
  TIdIRCDCCResumeEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort, AFilePos: Integer) of object;
  TIdIRCDCCAcceptEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort, AFilePos: Integer) of object;
  { -Errors- }
  TIdIRCServerErrorEvent = procedure(ASender: TIdContext; AErrorCode: Integer; const AErrorMessage: String) of object;
  TIdIRCNickErrorEvent = procedure(ASender: TIdContext; AError: Integer) of object;
  TIdIRCKillErrorEvent = procedure(ASender: TIdContext) of object;
  { Other }
  TIdIRCNicknameChangedEvent = procedure(ASender: TIdContext; const AOldNickname, AHost, ANewNickname: String) of object;
  TIdIRCKillEvent = procedure(ASender: TIdContext; const ANicknameFrom, AHost, ANicknameTo, AReason: String) of object;
  TIdIRCQuitEvent = procedure(ASender: TIdContext; const ANickname, AHost, AReason: String) of object;
  TIdIRCSvrTimeEvent = procedure(ASender: TIdContext; const AHost, ATime: String) of object;
  TIdIRCServiceEvent = procedure(ASender: TIdContext) of object;
  TIdIRCSvrVersionEvent = procedure(ASender: TIdContext; const AVersion, AHost, AComments: String) of object;
  TIdIRCRawEvent = procedure(ASender: TIdContext; AIn: Boolean; const AMessage: String) of object;

  EIdIRCError = class(EIdException);

  TIdIRCReplies = class(TPersistent)
  protected
    FFinger: String;
    FVersion: String;
    FUserInfo: String;
    FClientInfo: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property Finger: String read FFinger write FFinger;
    property Version: String read FVersion write FVersion;
    property UserInfo: String read FUserInfo write FUserInfo;
    property ClientInfo: String read FClientInfo write FClientInfo;
  end;

  TIdIRC = class(TIdCmdTCPClient)
  protected
    FNickname: String;
    FAltNickname: String;
    FUsername: String;
    FRealName: String;
    FPassword: String;
    FUserMode: TIdIRCUserModes;
    FUserAway: Boolean;
    FReplies: TIdIRCReplies;
    //
    FSenderNick: String;
    FSenderHost: String;
    FTmp: TStrings;
    //
    FOnSWelcome: TIdIRCServerWelcomeEvent;
    FOnPingPong: TIdIRCPingPongEvent;
    FOnPrivMessage: TIdIRCPrivMessageEvent;
    FOnNotice: TIdIRCNoticeEvent;
    FOnRehash: TIdIRCRehashEvent;
    FOnSummon: TIdIRCSummonEvent;
    FOnWallops: TIdIRCWallopsEvent;
    FOnIsOnIRC: TIdIRCIsOnIRCEvent;
    FOnAway: TIdIRCAwayEvent;
    FOnJoin: TIdIRCJoinEvent;
    FOnPart: TIdIRCPartEvent;
    FOnTopic: TIdIRCTopicEvent;
    FOnKick: TIdIRCKickEvent;
    FOnMOTD: TIdIRCMOTDEvent;
    FOnTrace: TIdIRCServerTraceEvent;
    FOnOp: TIdIRCOpEvent;
    FOnInviting: TIdIRCInvitingEvent;
    FOnInvite: TIdIRCInviteEvent;
    FOnBANList: TIdIRCChanBANListEvent;
    FOnEXCList: TIdIRCChanEXCListEvent;
    FOnINVList: TIdIRCChanINVListEvent;
    FOnSvrList: TIdIRCServerListEvent;
    FOnNickList: TIdIRCNickListEvent;
    FOnSvrUsers: TIdIRCServerUsersEvent;
    FOnSvrStats: TIdIRCServerStatsEvent;
    FOnKnownSvrs: TIdIRCKnownServerNamesEvent;
    FOnAdminInfo: TIdIRCAdminInfoRecvEvent;
    FOnUserInfo: TIdIRCUserInfoRecvEvent;
    FOnWho: TIdIRCWhoEvent;
    FOnWhoIs: TIdIRCWhoIsEvent;
    FOnWhoWas: TIdIRCWhoWasEvent;
    FOnChanMode: TIdIRCChanModeEvent;
    FOnUserMode: TIdIRCUserModeEvent;
    FOnCTCPQry: TIdIRCCTCPQueryEvent;
    FOnCTCPRep: TIdIRCCTCPReplyEvent;
    FOnDCCChat: TIdIRCDCCChatEvent;
    FOnDCCSend: TIdIRCDCCSendEvent;
    FOnDCCResume: TIdIRCDCCResumeEvent;
    FOnDCCAccept: TIdIRCDCCAcceptEvent;
    FOnServerError: TIdIRCServerErrorEvent;
    FOnNickError: TIdIRCNickErrorEvent;
    FOnKillError: TIdIRCKillErrorEvent;
    FOnNickChange: TIdIRCNicknameChangedEvent;
    FOnKill: TIdIRCKillEvent;
    FOnQuit: TIdIRCQuitEvent;
    FOnSvrTime: TIdIRCSvrTimeEvent;
    FOnService: TIdIRCServiceEvent;
    FOnSvrVersion: TIdIRCSvrVersionEvent;
    FOnRaw: TIdIRCRawEvent;
    //
    procedure SetNickname(const AValue: String);
    procedure SetUsername(const AValue: String);
    procedure SetIdIRCUserMode(AValue: TIdIRCUserModes);
    procedure SetIdIRCReplies(AValue: TIdIRCReplies);
    function GetUserMode: String;
    procedure ParseCTCPQuery(AContext: TIdContext; const CTCPQuery, AChannel: String);
    procedure ParseCTCPReply(AContext: TIdContext; const CTCPReply, AChannel: String);
    procedure ParseDCC(AContext: TIdContext; const ADCC: String);
    //Command handlers
    procedure DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
    procedure DoCmdHandlersException(ACommand: String; AContext: TIdContext);
    procedure CommandPRIVMSG(ASender: TIdCommand);
    procedure CommandNOTICE(ASender: TIdCommand);
    procedure CommandJOIN(ASender: TIdCommand);
    procedure CommandPART(ASender: TIdCommand);
    procedure CommandKICK(ASender: TIdCommand);
    procedure CommandMODE(ASender: TIdCommand);
    procedure CommandNICK(ASender: TIdCommand);
    procedure CommandQUIT(ASender: TIdCommand);
    procedure CommandINVITE(ASender: TIdCommand);
    procedure CommandKILL(ASender: TIdCommand);
    procedure CommandPING(ASender: TIdCommand);
    procedure CommandWALLOPS(ASender: TIdCommand);
    procedure CommandTOPIC(ASender: TIdCommand);
    procedure CommandServerWelcome(ASender: TIdCommand);
    procedure CommandUSERHOST(ASender: TIdCommand);
    procedure CommandISON(ASender: TIdCommand);
    procedure CommandENDOFWHOIS(ASender: TIdCommand);
    procedure CommandENDOFWHOWAS(ASender: TIdCommand);
    procedure CommandLISTEND(ASender: TIdCommand);
    procedure CommandINVITING(ASender: TIdCommand);
    procedure CommandSUMMONING(ASender: TIdCommand);
    procedure CommandENDOFINVITELIST(ASender: TIdCommand);
    procedure CommandENDOFEXCEPTLIST(ASender: TIdCommand);
    procedure CommandENDOFWHO(ASender: TIdCommand);
    procedure CommandENDOFNAMES(ASender: TIdCommand);
    procedure CommandENDOFLINKS(ASender: TIdCommand);
    procedure CommandENDOFBANLIST(ASender: TIdCommand);
    procedure CommandENDOFINFO(ASender: TIdCommand);
    procedure CommandENDOFMOTD(ASender: TIdCommand);
    procedure CommandREHASHING(ASender: TIdCommand);
    procedure CommandENDOFUSERS(ASender: TIdCommand);
    procedure CommandENDOFSTATS(ASender: TIdCommand);
    procedure CommandSERVLISTEND(ASender: TIdCommand);
    procedure CommandSTIME(ASender: TIdCommand);
    procedure CommandSERVICE(ASender: TIdCommand);
    procedure CommandSVERSION(ASender: TIdCommand);
    procedure CommandCHANMODE(ASender: TIdCommand);
    procedure CommandOPER(ASender: TIdCommand);
    //
    procedure AssignIRCClientCommands;
    procedure SetIOHandler(AValue: TIdIOHandler); override;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    //
    procedure Connect; override;
    procedure Disconnect(const AReason: String = ''); reintroduce;
    //
    function IsChannel(const AChannel: String): Boolean;
    function IsOp(const ANickname: String): Boolean;
    function IsVoice(const ANickname: String): Boolean;
    procedure Raw(const ALine: String);
    procedure Say(const ATarget, AMsg: String);
    procedure Notice(const ATarget, AMsg: String);
    procedure Action(const ATarget, AMsg: String);
    procedure CTCPQuery(const ATarget, ACommand, AParameters: String);
    procedure CTCPReply(const ATarget, ACTCP, AReply: String);
    procedure Join(const AChannel: String; const AKey: String ='');
    procedure Part(const AChannel: String; const AReason: String = '');
    procedure Kick(const AChannel, ANickname, AReason: String);
    procedure SetChannelMode(const AChannel, AMode: String; const AParams: String = '');
    procedure SetUserMode(const ANickname, AMode: String);
    procedure GetChannelTopic(const AChannel: String);
    procedure SetChannelTopic(const AChannel, ATopic: String);
    procedure SetAway(const AMsg: String);
    procedure Op(const AChannel, ANickname: String);
    procedure Deop(const AChannel, ANickname: String);
    procedure Voice(const AChannel, ANickname: String);
    procedure Devoice(const AChannel, ANickname: String);
    procedure Ban(const AChannel, AHostmask: String);
    procedure Unban(const AChannel, AHostmask: String);
    procedure RegisterService(const ANickname, ADistribution, AInfo: String; AType: Integer);
    procedure ListChannelNicknames(const AChannel: String; const ATarget: String = '');
    procedure ListChannel(const AChannel: String; const ATarget: String = '');
    procedure Invite(const ANickname, AChannel: String);
    procedure GetMessageOfTheDay(const ATarget: String = '');
    procedure GetNetworkStatus(const AHostMask: String = ''; const ATarget: String = '');
    procedure GetServerVersion(const ATarget: String = '');
    procedure GetServerStatus(AQuery: TIdIRCStat; const ATarget: String = '');
    procedure ListKnownServerNames(const ARemoteHost: String = ''; const AHostMask: String = '');
    procedure QueryServerTime(const ATarget: String = '');
    procedure RequestServerConnect(const ATarget, AHost: String; APort: Integer; const ARemoteHost: String = '');
    procedure TraceServer(const ATarget: String = '');
    procedure GetAdminInfo(const ATarget: String = '');
    procedure GetServerInfo(const ATarget: String = '');
    procedure ListNetworkServices(const AHostMask: String; const AType: String = '');
    procedure QueryService(const AServiceName, AMessage: String);
    procedure Who(const AMask: String; AOnlyAdmins: Boolean);
    procedure WhoIs(const AMask: String; const ATarget: String = '');
    procedure WhoWas(const ANickname: String; ACount: Integer = -1; const ATarget: String = '');
    procedure Kill(const ANickname, AComment: String);
    procedure Ping(const AServer1: String; const AServer2: String = '');
    procedure Pong(const AServer1: String; const AServer2: String = '');
    procedure Error(const AMessage: String);
    procedure ReHash;
    procedure Die;
    procedure Restart;
    procedure Summon(const ANickname: String; const ATarget: String = ''; const AChannel: String = '');
    procedure ListServerUsers(const ATarget: String = '');
    procedure SayWALLOPS(const AMessage: String);
    procedure GetUserInfo(const ANickname: String);
    procedure IsOnIRC(const ANickname: String);
    procedure BecomeOp(const ANickname, APassword: String);
    procedure SQuit(const AHost, AComment: String);
    procedure SetChannelLimit(const AChannel: String; ALimit: Integer);
    procedure SetChannelKey(const AChannel, AKey: String);
    //
    property Away: Boolean read FUserAway;
  published
    property Nickname: String read FNickname write SetNickname;
    property AltNickname: String read FAltNickname write FAltNickname;
    property Username: String read FUsername write SetUsername;
    property RealName: String read FRealName write FRealName;
    property Password: String read FPassword write FPassword;
    property Replies: TIdIRCReplies read FReplies write SetIdIRCReplies;
    property UserMode: TIdIRCUserModes read FUserMode write SetIdIRCUserMode;
    { Events }
    property OnServerWelcome: TIdIRCServerWelcomeEvent read FOnSWelcome write FOnSWelcome;
    property OnPingPong: TIdIRCPingPongEvent read FOnPingPong write FOnPingPong;
    property OnPrivateMessage: TIdIRCPrivMessageEvent read FOnPrivMessage write FOnPrivMessage;
    property OnNotice: TIdIRCNoticeEvent read FOnNotice write FOnNotice;
    property OnRehash: TIdIRCRehashEvent read FOnRehash write FOnRehash;
    property OnSummon: TIdIRCSummonEvent read FOnSummon write FOnSummon;
    property OnWallops: TIdIRCWallopsEvent read FOnWallops write FOnWallops;
    property OnIsOnIRC: TIdIRCIsOnIRCEvent read FOnIsOnIRC write FOnIsOnIRC;
    property OnAway: TIdIRCAwayEvent read FOnAway write FOnAway;
    property OnJoin: TIdIRCJoinEvent read FOnJoin write FOnJoin;
    property OnPart: TIdIRCPartEvent read FOnPart write FOnPart;
    property OnTopic: TIdIRCTopicEvent read FOnTopic write FOnTopic;
    property OnKick: TIdIRCKickEvent read FOnKick write FOnKick;
    property OnMOTD: TIdIRCMOTDEvent read FOnMOTD write FOnMOTD;
    property OnTrace: TIdIRCServerTraceEvent read FOnTrace write FOnTrace;
    property OnOp: TIdIRCOpEvent read FOnOp write FOnOp;
    property OnInviting: TIdIRCInvitingEvent read FOnInviting write FOnInviting;
    property OnInvite: TIdIRCInviteEvent read FOnInvite write FOnInvite;
    property OnBanListReceived: TIdIRCChanBANListEvent read FOnBANList write FOnBANList;
    property OnExceptionListReceived: TIdIRCChanEXCListEvent read FOnEXCList write FOnEXCList;
    property OnInvitationListReceived: TIdIRCChanINVListEvent read FOnINVList write FOnINVList;
    property OnServerListReceived: TIdIRCServerListEvent read FOnSvrList write FOnSvrList;
    property OnNicknamesListReceived: TIdIRCNickListEvent read FOnNickList write FOnNickList;
    property OnServerUsersListReceived: TIdIRCServerUsersEvent read FOnSvrUsers write FOnSvrUsers;
    property OnServerStatsReceived: TIdIRCServerStatsEvent read FOnSvrStats write FOnSvrStats;
    property OnKnownServersListReceived: TIdIRCKnownServerNamesEvent read FOnKnownSvrs write FOnKnownSvrs;
    property OnAdminInfoReceived: TIdIRCAdminInfoRecvEvent read FOnAdminInfo write FOnAdminInfo;
    property OnUserInfoReceived: TIdIRCUserInfoRecvEvent read FOnUserInfo write FOnUserInfo;
    property OnWho: TIdIRCWhoEvent read FOnWho write FOnWho;
    property OnWhoIs: TIdIRCWhoIsEvent read FOnWhoIs write FOnWhoIs;
    property OnWhoWas: TIdIRCWhoWasEvent read FOnWhoWas write FOnWhoWas;
    property OnChannelMode: TIdIRCChanModeEvent read FOnChanMode write FOnChanMode;
    property OnUserMode: TIdIRCUserModeEvent read FOnUserMode write FOnUserMode;
    property OnCTCPQuery: TIdIRCCTCPQueryEvent read FOnCTCPQry write FOnCTCPQry;
    property OnCTCPReply: TIdIRCCTCPReplyEvent read FOnCTCPRep write FOnCTCPRep;
    property OnDCCChat: TIdIRCDCCChatEvent read FOnDCCChat write FOnDCCChat;
    property OnDCCSend: TIdIRCDCCSendEvent read FOnDCCSend write FOnDCCSend;
    property OnDCCResume: TIdIRCDCCResumeEvent read FOnDCCResume write FOnDCCResume;
    property OnDCCAccept: TIdIRCDCCAcceptEvent read FOnDCCAccept write FOnDCCAccept;
    property OnServerError: TIdIRCServerErrorEvent read FOnServerError write FOnServerError;
    property OnNicknameError: TIdIRCNickErrorEvent read FOnNickError write FOnNickError;
    property OnKillError: TIdIRCKillErrorEvent read FOnKillError write FOnKillError;
    property OnNicknameChange: TIdIRCNicknameChangedEvent read FOnNickChange write FOnNickChange;
    property OnKill: TIdIRCKillEvent read FOnKill write FOnKill;
    property OnQuit: TIdIRCQuitEvent read FOnQuit write FOnQuit;
    property OnServerTime: TIdIRCSvrTimeEvent read FOnSvrTime write FOnSvrTime;
    property OnService: TIdIRCServiceEvent read FOnService write FOnService;
    property OnServerVersion: TIdIRCSvrVersionEvent read FOnSvrVersion write FOnSvrVersion;
    property OnRaw: TIdIRCRawEvent read FOnRaw write FOnRaw;
    property Port default IdPORT_IRC;
  end;

implementation

uses
  IdGlobalProtocols, IdResourceStringsProtocols, IdSSL,
  IdStack, IdBaseComponent, SysUtils;

const 
  IdIRCCTCP: array[0..9] of String = ('ACTION', 'SOUND', 'PING', 'FINGER', {do not localize}
    'USERINFO', 'VERSION', 'CLIENTINFO', 'TIME', 'ERROR', 'DCC');  {do not localize}

{ TIdIRCReplies }

constructor TIdIRCReplies.Create;
begin
  inherited Create;
  //
end;

procedure TIdIRCReplies.Assign(Source: TPersistent);
var
  LSource: TIdIRCReplies;
begin
  if Source is TIdIRCReplies then
  begin
    LSource := TIdIRCReplies(Source);
    FFinger := LSource.Finger;
    FFinger := LSource.Finger;
    FVersion := LSource.Version;
    FUserInfo := LSource.UserInfo;
    FClientInfo := LSource.ClientInfo;
  end;
end;

{ TIdIRC }

function FetchIRCParam(var S: String): String;
var
  LTmp: String;
begin
  LTmp := TrimLeft(S);
  if (LTmp <> '') and (LTmp[1] = ':') then
  begin
    Result := Copy(LTmp, 2, MaxInt);
    S := '';
  end else
  begin
    Result := Fetch(LTmp, #32);
    S := TrimLeft(LTmp);
  end;
end;


procedure TIdIRC.InitComponent;
begin
  inherited InitComponent;
  //
  FReplies := TIdIRCReplies.Create;
  FTmp := TStringList.Create;
  Port := IdPORT_IRC;
  FUserMode := [];
  //
  if not IsDesignTime then begin
    AssignIRCClientCommands;
  end;
end;

destructor TIdIRC.Destroy;
begin
  FreeAndNil(FReplies);
  FreeAndNil(FTmp);
  //
  inherited Destroy;
end;

function TIdIRC.GetUserMode: String;
const
  IdIRCUserModeChars: array[TIdIRCUserMode] of Char = ('a', 'i', 'w', 'r', 'o', 'O', 's'); {do not localize}
var
  i: TIdIRCUserMode;
begin
  if FUserMode <> [] then
  begin
    Result := '+';
    for i := amAway to amReceiveServerNotices do begin
      if i in FUserMode then begin
        Result := Result + IdIRCUserModeChars[i];
      end;
    end;
  end else begin
    Result := '0';
  end;
end;

procedure TIdIRC.Connect;
begin
  // I doubt that there is explicit SSL support in the IRC protocol
  if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
  end;
  inherited Connect;
  //
  try
    if FPassword <> '' then begin
      Raw(IndyFormat('PASS %s', [FPassword]));  {do not localize}
    end;
    SetNickname(FNickname);
    SetUsername(FUsername);
  except
    on E: EIdSocketError do begin
      inherited Disconnect;
      raise EIdIRCError.Create(RSIRCCannotConnect);
    end;
  end;
end;

procedure TIdIRC.Disconnect(const AReason: String = '');
begin
  Raw(IndyFormat('QUIT :%s', [AReason])); {do not localize}
  inherited Disconnect;
end;

procedure TIdIRC.Raw(const ALine: String);
begin
  if Connected then begin
    if Assigned(FOnRaw) then begin
      FOnRaw(nil, False, ALine);
    end;
    IOHandler.WriteLn(ALine + EOL);
  end;
end;

procedure TIdIRC.AssignIRCClientCommands;
begin
  { Text commands }
  //PRIVMSG Nickname/#channel :message
  with CommandHandlers.Add do
  begin
    Command := 'PRIVMSG'; {do not localize}
    OnCommand := CommandPRIVMSG;
    ParseParams := False;
  end;
  //NOTICE Nickname/#channel :message
  with CommandHandlers.Add do
  begin
    Command := 'NOTICE';  {do not localize}
    OnCommand := CommandNOTICE;
    ParseParams := False;
  end;
  //JOIN #channel
  with CommandHandlers.Add do
  begin
    Command := 'JOIN';  {do not localize}
    OnCommand := CommandJOIN;
    ParseParams := False;
  end;
  //PART #channel
  with CommandHandlers.Add do
  begin
    Command := 'PART';  {do not localize}
    OnCommand := CommandPART;
    ParseParams := False;
  end;
  //KICK #channel target :reason
  with CommandHandlers.Add do
  begin
    Command := 'KICK';  {do not localize}
    OnCommand := CommandKICK;
    ParseParams := False;
  end;
  //MODE Nickname/#channel +/-modes parameters...
  with CommandHandlers.Add do
  begin
    Command := 'MODE';  {do not localize}
    OnCommand := CommandMODE;
  end;
  //Nickname newNickname
  with CommandHandlers.Add do
  begin
    Command := 'NICK';  {do not localize}
    OnCommand := CommandNICK;
    ParseParams := False;
  end;
  //QUIT :reason
  with CommandHandlers.Add do
  begin
    Command := 'QUIT';  {do not localize}
    OnCommand := CommandQUIT;
    ParseParams := False;
  end;
  //INVITE Nickname :#channel
  with CommandHandlers.Add do
  begin
    Command := 'INVITE';  {do not localize}
    OnCommand := CommandINVITE;
    ParseParams := False;
  end;
  //KILL Nickname :reason
  with CommandHandlers.Add do
  begin
    Command := 'KILL';  {do not localize}
    OnCommand := CommandKILL;
    ParseParams := False;
  end;
  //PING server
  with CommandHandlers.Add do
  begin
    Command := 'PING';  {do not localize}
    OnCommand := CommandPING;
    ParseParams := False;
  end;
  //WALLOPS :message
  with CommandHandlers.Add do
  begin
    Command := 'WALLOPS'; {do not localize}
    OnCommand := CommandWALLOPS;
    ParseParams := False;
  end;
  //TOPIC
  with CommandHandlers.Add do
  begin
    Command := 'TOPIC'; {do not localize}
    OnCommand := CommandTOPIC;
    ParseParams := False;
  end;

  { Numeric commands }
  //004
  with CommandHandlers.Add do
  begin
    Command := '004'; {do not localize}
    OnCommand := CommandServerWelcome;
  end;
  //ENDOFSTATS
  with CommandHandlers.Add do
  begin
    Command := '219'; {do not localize}
    OnCommand := CommandENDOFSTATS;
  end;
  //SERVLISTEND
  with CommandHandlers.Add do
  begin
    Command := '235'; {do not localize}
    OnCommand := CommandSERVLISTEND;
  end;
  //USERHOST
  with CommandHandlers.Add do
  begin
    Command := '302'; {do not localize}
    OnCommand := CommandUSERHOST;
  end;
  //ISON
  with CommandHandlers.Add do
  begin
    Command := '303'; {do not localize}
    OnCommand := CommandISON;
  end;
  //ENDOFWHO
  with CommandHandlers.Add do
  begin
    Command := '315'; {do not localize}
    OnCommand := CommandENDOFWHO;
  end;
  //ENDOFWHOIS
  with CommandHandlers.Add do
  begin
    Command := '318'; {do not localize}
    OnCommand := CommandENDOFWHOIS;
  end;
  //LISTEND
  with CommandHandlers.Add do
  begin
    Command := '323'; {do not localize}
    OnCommand := CommandLISTEND;
  end;
  //CHANMODEIS
  with CommandHandlers.Add do
  begin
    Command := '324'; {do not localize}
    OnCommand := CommandCHANMODE;
  end;
  //NOTOPIC
  with CommandHandlers.Add do
  begin
    Command := '331'; {do not localize}
    OnCommand := CommandTOPIC;
    ParseParams := False;
  end;
  //INVITING
  with CommandHandlers.Add do
  begin
    Command := '341'; {do not localize}
    OnCommand := CommandINVITING;
  end;
  //SUMMONING
  with CommandHandlers.Add do
  begin
    Command := '342'; {do not localize}
    OnCommand := CommandSUMMONING;
  end;
  //ENDOFINVITELIST
  with CommandHandlers.Add do
  begin
    Command := '347'; {do not localize}
    OnCommand := CommandENDOFINVITELIST;
  end;
  //ENDOFEXCEPTLIST
  with CommandHandlers.Add do
  begin
    Command := '349'; {do not localize}
    OnCommand := CommandENDOFEXCEPTLIST;
  end;
  //SVERSION
  with CommandHandlers.Add do
  begin
    Command := '351'; {do not localize}
    OnCommand := CommandSVERSION;
    ParseParams := False;
  end;
  //ENDOFLINKS
  with CommandHandlers.Add do
  begin
    Command := '365'; {do not localize}
    OnCommand := CommandENDOFLINKS;
  end;
  //ENDOFNAMES
  with CommandHandlers.Add do
  begin
    Command := '366'; {do not localize}
    OnCommand := CommandENDOFNAMES;
  end;
  //ENDOFBANLIST
  with CommandHandlers.Add do
  begin
    Command := '368'; {do not localize}
    OnCommand := CommandENDOFBANLIST;
  end;
  //ENDOFWHOWAS
  with CommandHandlers.Add do
  begin
    Command := '369'; {do not localize}
    OnCommand := CommandENDOFWHOWAS;
  end;
  //ENDOFINFO
  with CommandHandlers.Add do
  begin
    Command := '374'; {do not localize}
    OnCommand := CommandENDOFINFO;
  end;
  //ENDOFMOTD
  with CommandHandlers.Add do
  begin
    Command := '376'; {do not localize}
    OnCommand := CommandENDOFMOTD;
  end;
  //YOUREOPER
  with CommandHandlers.Add do
  begin
    Command := '381'; {do not localize}
    //OnCommand := CommandYOUAREOPER;
  end;
  //REHASHING
  with CommandHandlers.Add do
  begin
    Command := '382'; {do not localize}
    OnCommand := CommandREHASHING;
  end;
  //YOUARESERVICE
  with CommandHandlers.Add do
  begin
    Command := '383'; {do not localize}
    OnCommand := CommandSERVICE;
  end;
  //STIME
  with CommandHandlers.Add do
  begin
    Command := '391'; {do not localize}
    OnCommand := CommandSTIME;
    ParseParams := False;
  end;
  //ENDOFUSERS
  with CommandHandlers.Add do
  begin
    Command := '394'; {do not localize}
    OnCommand := CommandENDOFUSERS;
  end;
  with FCommandHandlers do
  begin
    OnBeforeCommandHandler := DoBeforeCmd;
    OnCommandHandlersException := DoCmdHandlersException;
  end;
end;

{ Command handlers }

procedure TIdIRC.DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
var
  LTmp: String;
begin
  // ":sender!pc@domain"
  if (AData <> '') and (AData[1] = ':') then begin
    LTmp := Fetch(AData, #32);
    Delete(LTmp, 1, 1); // remove ':'
    FSenderNick := Fetch(LTmp, '!');
    FSenderHost := LTmp;
  end else begin
    FSenderNick := '';
    FSenderHost := '';
  end;
  if Assigned(FOnRaw) then begin
    FOnRaw(AContext, True, AData);
  end;
end;

procedure TIdIRC.DoCmdHandlersException(ACommand: String; AContext: TIdContext);
var
  ACmdCode: Integer;
begin
  ACmdCode := IndyStrToInt(Fetch(ACommand, #32), -1);
  //
  case ACmdCode of
    6,
    7:
      begin
        //MAP
      end;
    301,
    305,
    306:
      begin
        if Assigned(FOnAway) then begin
          if (ACmdCode = 305) or (ACmdCode = 306) then begin
            FUserAway := False;
          end else begin
            FUserAway := True;
          end;
          OnAway(AContext, FSenderNick, FSenderHost, FetchIRCParam(ACommand), FUserAway);
        end;
      end;
    5,
    401..424,
    437..502:
      begin
        if Assigned(FOnServerError) then begin
          OnServerError(AContext, ACmdCode, ACommand);
        end;
      end;
    431,
    432,
    433,
    436:
      begin
        if Assigned(FOnNickError) then begin
          OnNicknameError(AContext, IndyStrToInt(FetchIRCParam(ACommand)));
        end;
      end;
    else
      { anything else, just add to TStrings }
      if ACmdCode <> -1 then begin
        if Length(ACommand) <> 0 then begin
          FTmp.Add(ACommand);
        end;
      end;
  end;
end;

procedure TIdIRC.CommandPRIVMSG(ASender: TIdCommand);
var
  LTmp, LParam: String;
begin
  LTmp := ASender.UnparsedParams;
  LParam := FetchIRCParam(LTmp);
  if (LParam <> '') and (LParam[1] = #1) then begin
    ParseCTCPQuery(ASender.Context, LTmp, LParam);
  end
  else if Assigned(FOnPrivMessage) then begin
    OnPrivateMessage(ASender.Context, FSenderNick, FSenderHost, LParam, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandNOTICE(ASender: TIdCommand);
var
  LTmp, LParam: String;
begin
  LTmp := ASender.UnparsedParams;
  LParam := FetchIRCParam(LTmp);
  if (LParam <> '') and (LParam[1] = #1) then begin
    ParseCTCPReply(ASender.Context, LTmp, LParam);
  end
  else if Assigned(FOnNotice) then begin
    OnNotice(ASender.Context, FSenderNick, FSenderHost, LParam, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandJOIN(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnJoin) then begin
    LTmp := ASender.UnparsedParams;
    OnJoin(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandPART(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnPart) then begin
    LTmp := ASender.UnparsedParams;
    OnPart(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandKICK(ASender: TIdCommand);
var
  LChannel, LNick, LReason, LTmp: String;
begin
  if Assigned(FOnKick) then begin
    LTmp := ASender.UnparsedParams;
    LChannel := FetchIRCParam(LTmp);
    LNick := FetchIRCParam(LTmp);
    LReason := FetchIRCParam(LTmp);
    OnKick(ASender.Context, FSenderNick, FSenderHost, LChannel, LNick, LReason);
  end;
end;

procedure TIdIRC.CommandMODE(ASender: TIdCommand);
begin
  if IsChannel(ASender.Params[1]) then begin
    if Assigned(FOnChanMode) then begin
      OnChannelMode(ASender.Context);
    end;
  end
  else if Assigned(FOnUserMode) then begin
    OnUserMode(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandNICK(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnNickChange) then begin
    LTmp := ASender.UnparsedParams;
    OnNicknameChange(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandQUIT(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnQuit) then begin
    LTmp := ASender.UnparsedParams;
    OnQuit(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandINVITE(ASender: TIdCommand);
var
  LTmp, LNick, LChannel: String;
begin
  if Assigned(FOnInvite) then begin
    LTmp := ASender.UnparsedParams;
    LNick := FetchIRCParam(LTmp);
    LChannel := FetchIRCParam(LTmp);
    OnInvite(ASender.Context, FSenderNick, FSenderHost, LNick, LChannel);
  end;
end;

procedure TIdIRC.CommandKILL(ASender: TIdCommand);
var
  LTmp, LNick, LComment: String;
begin
  if Assigned(FOnKill) then begin
    LTmp := ASender.UnparsedParams;
    LNick := FetchIRCParam(LTmp);
    LComment := FetchIRCParam(LTmp);
    OnKill(ASender.Context, FSenderNick, FSenderHost, LNick, LComment);
  end;
end;

procedure TIdIRC.CommandPING(ASender: TIdCommand);
var
  LTmp: String;
begin
  LTmp := ASender.UnparsedParams;
  Pong(FetchIRCParam(LTmp));
  if Assigned(FOnPingPong) then begin
    OnPingPong(ASender.Context);
  end;
end;

procedure TIdIRC.CommandWALLOPS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnWallops) then begin
    LTmp := ASender.UnparsedParams;
    OnWallops(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandTOPIC(ASender: TIdCommand);
var
  LTmp, LChannel, LTopic: String;
begin
  if Assigned(FOnTopic) then begin
    LTmp := ASender.UnparsedParams;
    LChannel := FetchIRCParam(LTmp);
    LTopic := FetchIRCParam(LTmp);
    OnTopic(ASender.Context, FSenderNick, FSenderHost, LChannel, LTopic);
  end;
end;

procedure TIdIRC.CommandServerWelcome(ASender: TIdCommand);
begin
  if Assigned(FOnSWelcome) then begin
    FTmp.Add(ASender.UnparsedParams);
    OnServerWelcome(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandUSERHOST(ASender: TIdCommand);
begin
  if Assigned(FOnUserInfo) then begin
    FTmp.Add(ASender.UnparsedParams);
    OnUserInfoReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandISON(ASender: TIdCommand);
begin
  if Assigned(FOnIsOnIRC) then begin
    OnIsOnIRC(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFWHOIS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnWhoIs) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnWhoIs(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFWHOWAS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnWhoWas) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnWhoWas(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandLISTEND(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnSvrList) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnServerListReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandINVITING(ASender: TIdCommand);
begin
  if Assigned(FOnInviting) then begin
    OnInviting(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandSUMMONING(ASender: TIdCommand);
begin
  if Assigned(FOnSummon) then begin
    OnSummon(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFINVITELIST(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnINVList) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnInvitationListReceived(ASender.Context, FSenderNick, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFEXCEPTLIST(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnEXCList) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnExceptionListReceived(ASender.Context, FSenderNick, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFWHO(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnWho) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnWho(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFNAMES(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnNickList) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnNicknamesListReceived(ASender.Context, FSenderNick, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFLINKS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnKnownSvrs) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnKnownServersListReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFBANLIST(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnBanList) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnBanListReceived(ASender.Context, FSenderNick, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFINFO(ASender: TIdCommand);
begin
  if Assigned(FOnUserInfo) then begin
    //LTmp := ASender.UnparsedParams;
    //FTmp.Add(FetchIRCParam(LTmp));
    OnUserInfoReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFMOTD(ASender: TIdCommand);
begin
  if Assigned(FOnMOTD) then begin
    //LTmp := ASender.UnparsedParams;
    //FTmp.Add(FetchIRCParam(LTmp));
    OnMOTD(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandREHASHING(ASender: TIdCommand);
begin
  if Assigned(FOnRehash) then begin
    OnRehash(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFUSERS(ASender: TIdCommand);
begin
  if Assigned(FOnSvrUsers) then begin
    // LTmp := ASender.UnparsedParams;
    // FTmp.Add(FetchIRCParam(LTmp));
    OnServerUsersListReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandENDOFSTATS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnSvrStats) then begin
    LTmp := ASender.UnparsedParams;
    FTmp.Add(FetchIRCParam(LTmp));
    OnServerStatsReceived(ASender.Context, FTmp);
    FTmp.Clear;
  end;
end;

procedure TIdIRC.CommandSERVLISTEND(ASender: TIdCommand);
begin
  //
end;

procedure TIdIRC.CommandSTIME(ASender: TIdCommand);
var
  LTmp, LServer, LTime: String;
begin
  if Assigned(FOnSvrTime) then begin
    LTmp := ASender.UnparsedParams;
    LServer := FetchIRCParam(LTmp);
    LTime := FetchIRCParam(LTmp);
    OnServerTime(ASender.Context, LServer, LTime);
  end;
end;

procedure TIdIRC.CommandSERVICE(ASender: TIdCommand);
begin
  if Assigned(FOnService) then begin
    OnService(ASender.Context);
  end;
end;

procedure TIdIRC.CommandSVERSION(ASender: TIdCommand);
var
  LTmp, LVersion, LServer, LComments: String;
begin
  if Assigned(FOnSvrVersion) then begin
    LTmp := ASender.UnparsedParams;
    LVersion := FetchIRCParam(LTmp);
    LServer := FetchIRCParam(LTmp);
    LComments := FetchIRCParam(LTmp);
    OnServerVersion(ASender.Context, LVersion, LServer, LComments);
  end;
end;

procedure TIdIRC.CommandCHANMODE(ASender: TIdCommand);
begin
  if Assigned(FOnChanMode) then begin
    OnChannelMode(ASender.Context);
  end;
end;

procedure TIdIRC.CommandOPER(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnOp) then begin
    LTmp := ASender.UnparsedParams;
    OnOp(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.ParseCTCPQuery(AContext: TIdContext; const CTCPQuery, AChannel: String);
var
  CTCP: String;
  LTmp: String;
  LTmp1: String;
begin
  CTCP := CTCPQuery;
  LTmp := FetchIRCParam(CTCP);
  LTmp1 := CTCP;

  case PosInStrArray(LTmp1, IdIRCCTCP) of
    0: { ACTION }
      begin
        //if Assigned(FOnAction) then begin
        //  FOnAction(FSenderNick, AChannel, LTmp1);
        //end;
      end;
    1: { SOUND }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
      end;
    2: { PING }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, LTmp1, LTmp, LTmp, LTmp);
      end;
    3: { FINGER }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, Replies.Finger, LTmp, LTmp, LTmp);
      end;
    4: { USERINFO }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, Replies.UserInfo, LTmp, LTmp, LTmp);
      end;
    5: { VERSION }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, Replies.Version, LTmp, LTmp, LTmp);
      end;
    6: { CLIENTINFO }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, Replies.ClientInfo, LTmp, LTmp, LTmp);
      end;
    7: { TIME }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
        OnCTCPReply(AContext, FSenderNick, LTmp, IndyFormat(RSIRCTimeIsNow, [DateTimeToStr(Now)]), LTmp, LTmp, LTmp);
      end;
    8: { ERROR }
      begin
        if Assigned(FOnCTCPQry) then begin
          FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
      end;
    9: { DCC }
      begin
        ParseDCC(AContext, LTmp1);
      end;
    else
      if Assigned(FOnCTCPQry) then begin
        FOnCTCPQry(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
      end;
  end;
end;

procedure TIdIRC.ParseCTCPReply(AContext: TIdContext; const CTCPReply, AChannel: String);
var
  CTCP: String;
  LTmp: String;
  LTmp1: String;
begin
  CTCP := CTCPReply;
  LTmp := FetchIRCParam(CTCP);
  LTmp1 := CTCP;

  if PosInStrArray(LTmp1, IdIRCCTCP) = 9 then begin { DCC }
    { FIXME: To be completed. }
  end
  else if Assigned(FOnCTCPRep) then begin
    FOnCTCPRep(AContext, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
  end;
end;

procedure TIdIRC.ParseDCC(AContext: TIdContext; const ADCC: String);
const
  IdIRCDCC: array[0..3] of String = ('SEND', 'CHAT', 'RESUME', 'ACCEPT');  {do not localize}
var
  LTmp: String;
  LTmp1, LTmp2, LTmp3: String;
begin
  LTmp := ADCC;
  LTmp1 := FetchIRCParam(LTmp);
  LTmp2 := FetchIRCParam(LTmp);
  LTmp3 := FetchIRCParam(LTmp);
  //
  case PosInStrArray(LTmp1, IdIRCDCC) of
    0: {SEND}
      begin
        if Assigned(FOnDCCSend) then begin
          FOnDCCSend(AContext, FSenderNick, LTmp2, LTmp3, IndyStrToInt(LTmp1), IndyStrToInt(LTmp));
        end;
      end;
    1: {CHAT}
      begin
        if Assigned(FOnDCCChat) then begin
          FOnDCCChat(AContext, FSenderNick, LTmp2, IndyStrToInt(LTmp3));
        end;
      end;
    2: {RESUME}
      begin
        if Assigned(FOnDCCResume) then begin
          FOnDCCResume(AContext, FSenderNick, LTmp2, LTmp1, IndyStrToInt(LTmp1), IndyStrToInt(LTmp3));
        end;
      end;
    3: {ACCEPT}
      begin
        if Assigned(FOnDCCAccept) then begin
          FOnDCCAccept(AContext, FSenderNick, LTmp2, LTmp1, IndyStrToInt(LTmp3), IndyStrToInt(LTmp));
        end;
      end;
  end;
end;

procedure TIdIRC.SetNickname(const AValue: String);
begin
  if not Connected then begin
    FNickname := AValue;
  end else begin
    Raw(IndyFormat('NICK %s', [AValue])); {do not localize}
  end;
end;

procedure TIdIRC.SetUsername(const AValue: String);
begin
  if not Connected then begin
    FUsername := AValue;
  end else begin
    Raw(IndyFormat('USER %s %s %s :%s', [AValue, GetUserMode, '*', FRealName]));  {do not localize}
  end;
end;

procedure TIdIRC.SetIdIRCUserMode(AValue: TIdIRCUserModes);
begin
  FUserMode := AValue;
end;

procedure TIdIRC.SetIdIRCReplies(AValue: TIdIRCReplies);
begin
  FReplies.Assign(AValue);
end;

function TIdIRC.IsChannel(const AChannel: String): Boolean;
begin
  //Result := (Length(AChannel) > 0) and CharIsInSet(AChannel, 1, ['&','#','+','!']);  {do not localize}
  Result := CharIsInSet(AChannel, 1, '&#+!');  {do not localize}
end;

function TIdIRC.IsOp(const ANickname: String): Boolean;
begin
  Result := (Length(ANickname) > 0) and (ANickname[1] = '@');
end;

function TIdIRC.IsVoice(const ANickname: String): Boolean;
begin
  Result := (Length(ANickname) > 0) and (ANickname[Length(Nickname)] = '+');
end;

procedure TIdIRC.Say(const ATarget, AMsg: String);
begin
  Raw(IndyFormat('PRIVMSG %s :%s', [ATarget, AMsg])); {do not localize}
end;

procedure TIdIRC.Notice(const ATarget, AMsg: String);
begin
  Raw(IndyFormat('NOTICE %s :%s', [ATarget, AMsg]));  {do not localize}
end;

procedure TIdIRC.Action(const ATarget, AMsg: String);
begin
  CTCPQuery(ATarget, 'ACTION', AMsg); {do not localize}
end;

procedure TIdIRC.CTCPQuery(const ATarget, ACommand, AParameters: String);
begin
  Say(ATarget, IndyFormat(#1'%s %s'#1, [UpperCase(ACommand), AParameters]));  {do not localize}
end;

procedure TIdIRC.CTCPReply(const ATarget, ACTCP, AReply: String);
begin
  Notice(ATarget, IndyFormat(#1'%s %s'#1, [ACTCP, AReply]));  {do not localize}
end;

procedure TIdIRC.Join(const AChannel: String; const AKey: String = '');
begin
  if IsChannel(AChannel) then begin
    if AKey <> '' then begin
      Raw(IndyFormat('JOIN %s %s', [AChannel, AKey])) {do not localize}
    end else begin
      Raw(IndyFormat('JOIN %s', [AChannel])); {do not localize}
    end;
  end;
end;

procedure TIdIRC.Part(const AChannel: String; const AReason: String = '');
begin
  if IsChannel(AChannel) then begin
    if AReason <> '' then begin
      Raw(IndyFormat('PART %s :%s', [AChannel, AReason])) {do not localize}
    end else begin
      Raw(IndyFormat('PART %s', [AChannel])); {do not localize}
    end;
  end;
end;

procedure TIdIRC.Kick(const AChannel, ANickname, AReason: String);
begin
  if IsChannel(AChannel) then begin
    Raw(IndyFormat('KICK %s %s :%s', [AChannel, ANickname, AReason]));  {do not localize}
  end;
end;

procedure TIdIRC.SetChannelMode(const AChannel, AMode: String; const AParams: String = '');
begin
  if IsChannel(AChannel) then begin
    if AParams = '' then begin
      Raw(IndyFormat('MODE %s %s', [AChannel, AMode])); {do not localize}
    end else begin
      Raw(IndyFormat('MODE %s %s %s', [AChannel, AMode, AParams])); {do not localize}
    end;
  end;
end;

procedure TIdIRC.SetUserMode(const ANickname, AMode: String);
begin
  Raw(IndyFormat('MODE %s %s', [ANickname, AMode]));  {do not localize}
end;

procedure TIdIRC.GetChannelTopic(const AChannel: String);
begin
  if IsChannel(AChannel) then begin
    Raw(IndyFormat('TOPIC %s', [AChannel]));  {do not localize}
  end;
end;

procedure TIdIRC.SetChannelTopic(const AChannel, ATopic: String);
begin
  if IsChannel(AChannel) then begin
    Raw(IndyFormat('TOPIC %s :%s', [AChannel, ATopic]));  {do not localize}
  end;
end;

procedure TIdIRC.SetAway(const AMsg: String);
begin
  if AMsg <> '' then begin
    Raw(IndyFormat('AWAY %s', [AMsg])); {do not localize}
  end else begin
    Raw('AWAY');  {do not localize}
  end;
end;

procedure TIdIRC.Op(const AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '+o', ANickname);  {do not localize}
end;

procedure TIdIRC.Deop(const AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '-o', ANickname);  {do not localize}
end;

procedure TIdIRC.Voice(const AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '+v', ANickname);  {do not localize}
end;

procedure TIdIRC.Devoice(const AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '-v', ANickname);  {do not localize}
end;

procedure TIdIRC.Ban(const AChannel, AHostmask: String);
begin
  SetChannelMode(AChannel, '+b', AHostmask);  {do not localize}
end;

procedure TIdIRC.Unban(const AChannel, AHostmask: String);
begin
  SetChannelMode(AChannel, '-b', AHostmask);  {do not localize}
end;

procedure TIdIRC.RegisterService(const ANickname, ADistribution, AInfo: String; AType: Integer);
begin
  Raw(IndyFormat('SERVICE %s %s %s %s %s :%s',  {do not localize}
    [ANickname, '*', ADistribution, AType, '0', AInfo]));
end;

procedure TIdIRC.ListChannelNicknames(const AChannel: String; const ATarget: String = '');
begin
  if IsChannel(AChannel) then begin
    if ATarget <> '' then begin
      Raw(IndyFormat('NAMES %s %s', [AChannel, ATarget]));  {do not localize}
    end else begin
      Raw(IndyFormat('NAMES %s', [AChannel]));  {do not localize}
    end;
  end;
end;

procedure TIdIRC.ListChannel(const AChannel: String; const ATarget: String = '');
begin
  if IsChannel(AChannel) then begin
    if ATarget <> '' then begin
      Raw(IndyFormat('LIST %s %s', [AChannel, ATarget])); {do not localize}
    end else begin
      Raw(IndyFormat('LIST %s', [AChannel])); {do not localize}
    end;
  end;
end;

procedure TIdIRC.Invite(const ANickname, AChannel: String);
begin
  if IsChannel(AChannel) then begin
    Raw(IndyFormat('INVITE %s %s', [ANickname, AChannel])); {do not localize}
  end;
end;

procedure TIdIRC.GetMessageOfTheDay(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('MOTD %s', [ATarget]));  {do not localize}
  end else begin
    Raw('MOTD');  {do not localize}
  end;
end;

procedure TIdIRC.GetNetworkStatus(const AHostMask: String = ''; const ATarget: String = '');
begin
  if (AHostMask = '') and (ATarget = '') then begin
    Raw('LUSERS');  {do not localize}
  end
  else if AHostMask = '' then begin
    Raw(IndyFormat('LUSERS %s', [ATarget]));  {do not localize}
  end
  else if ATarget = '' then begin
    Raw(IndyFormat('LUSERS %s', [AHostMask]));  {do not localize}
  end else begin
    Raw(IndyFormat('LUSERS %s %s', [AHostMask, ATarget]));  {do not localize}
  end;
end;

procedure TIdIRC.GetServerVersion(const ATarget: String = '');
begin
  if ATarget = '' then begin
    Raw('VERSION'); {do not localize}
  end else begin
    Raw(IndyFormat('VERSION %s', [ATarget])); {do not localize}
  end;
end;

procedure TIdIRC.GetServerStatus(AQuery: TIdIRCStat; const ATarget: String = '');
const
  IdIRCStatChars: array[TIdIRCStat] of Char = ('l', 'm', 'o', 'u'); {do not localize}
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('STATS %s %s', [IdIRCStatChars[AQuery], ATarget])); {do not localize}
  end else begin
    Raw(IndyFormat('STATS %s', [IdIRCStatChars[AQuery]])); {do not localize}
  end;
end;

procedure TIdIRC.ListKnownServerNames(const ARemoteHost: String = ''; const AHostMask: String = '');
begin
  if (ARemoteHost = '') and (AHostMask = '') then begin
    Raw('LINKS'); {do not localize}
  end
  else if ARemoteHost = '' then begin
    Raw(IndyFormat('LINKS %s', [AHostMask])); {do not localize}
  end else begin
    Raw(IndyFormat('LINKS %s', [ARemoteHost])); {do not localize}
  end;
end;

procedure TIdIRC.QueryServerTime(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('TIME %s', [ATarget]));  {do not localize}
  end else begin
    Raw('TIME');  {do not localize}
  end;
end;

procedure TIdIRC.RequestServerConnect(const ATarget, AHost: String; APort: Integer;
  const ARemoteHost: String = '');
begin
  if ARemoteHost <> '' then begin
    Raw(IndyFormat('CONNECT %s %s %d %s', [ATarget, AHost, APort, ARemoteHost])); {do not localize}
  end else begin
    Raw(IndyFormat('CONNECT %s %s %d', [ATarget, AHost, APort])); {do not localize}
  end;
end;

procedure TIdIRC.TraceServer(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('TRACE %s', [ATarget])); {do not localize}
  end else begin
    Raw('TRACE'); {do not localize}
  end;
end;

procedure TIdIRC.GetAdminInfo(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('ADMIN %s', [ATarget])); {do not localize}
  end else begin
    Raw('ADMIN'); {do not localize}
  end;
end;

procedure TIdIRC.GetServerInfo(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('INFO %s', [ATarget]));  {do not localize}
  end else begin
    Raw('INFO');  {do not localize}
  end;
end;

procedure TIdIRC.ListNetworkServices(const AHostMask: String; const AType: String = '');
begin
  if AType <> '' then begin
    Raw(IndyFormat('SERVLIST %s %s', [AHostMask, AType]));  {do not localize}
  end else begin
    Raw(IndyFormat('SERVLIST %s', [AHostMask]));  {do not localize}
  end;
end;

procedure TIdIRC.QueryService(const AServiceName, AMessage: String);
begin
  Raw(IndyFormat('SQUERY %s %s', [AServiceName, AMessage]));  {do not localize}
end;

procedure TIdIRC.Who(const AMask: String; AOnlyAdmins: Boolean);
begin
  if AOnlyAdmins then begin
    Raw(IndyFormat('WHO %s o', [AMask])); {do not localize}
  end else begin
    Raw(IndyFormat('WHO %s', [AMask])); {do not localize}
  end;
end;

procedure TIdIRC.WhoIs(const AMask: String; const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('WHOIS %s %s', [AMask, ATarget])); {do not localize}
  end else begin
    Raw(IndyFormat('WHOIS %s', [AMask])); {do not localize}
  end;
end;

procedure TIdIRC.WhoWas(const ANickname: String; ACount: Integer = -1; const ATarget: String = '');
begin
  if (ATarget = '') and (ACount < 0) then begin
    Raw(IndyFormat('WHOWAS %s', [ANickname]));  {do not localize}
  end
  else if ATarget = '' then begin
    Raw(IndyFormat('WHOWAS %s %d', [ANickname, ACount])); {do not localize}
  end
  else begin
    Raw(IndyFormat('WHOWAS %s %s', [ANickname, ATarget]));  {do not localize}
  end;
end;

procedure TIdIRC.Kill(const ANickname, AComment: String);
begin
  Raw(IndyFormat('KILL %s %s', [ANickname, AComment])); {do not localize}
end;

procedure TIdIRC.Ping(const AServer1: String; const AServer2: String = '');
begin
  if AServer2 <> '' then begin
    Raw(IndyFormat('PING %s %s', [AServer1, AServer2]));  {do not localize}
  end else begin
    Raw(IndyFormat('PING %s', [AServer1])); {do not localize}
  end;
end;

procedure TIdIRC.Pong(const AServer1: String; const AServer2: String = '');
begin
  if AServer2 <> '' then begin
    Raw(IndyFormat('PONG %s %s', [AServer1, AServer2]));  {do not localize}
  end else begin
    Raw(IndyFormat('PONG %s', [AServer1])); {do not localize}
  end;
end;

procedure TIdIRC.Error(const AMessage: String);
begin
  Raw(IndyFormat('ERROR %s', [AMessage]));  {do not localize}
end;

procedure TIdIRC.ReHash;
begin
  Raw('REHASH');  {do not localize}
end;

procedure TIdIRC.Die;
begin
  Raw('DIE'); {do not localize}
end;

procedure TIdIRC.Restart;
begin
  Raw('RESTART'); {do not localize}
end;

procedure TIdIRC.Summon(const ANickname: String; const ATarget: String = '';
  const AChannel: String = '');
begin
  if (ATarget = '') and (AChannel = '') then begin
    Raw(IndyFormat('SUMMON %s', [ANickname]));  {do not localize}
  end
  else if ATarget = '' then
  begin
    if IsChannel(AChannel) then begin
      Raw(IndyFormat('SUMMON %s', [AChannel])); {do not localize}
    end;
  end else begin
    Raw(IndyFormat('SUMMON %s', [ANickname]));  {do not localize}
  end;
end;

procedure TIdIRC.ListServerUsers(const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('USERS %s', [ATarget])); {do not localize}
  end else begin
    Raw('USERS'); {do not localize}
  end;
end;

procedure TIdIRC.SayWALLOPS(const AMessage: String);
begin
  Raw(IndyFormat('WALLOPS %s', [AMessage]));  {do not localize}
end;

procedure TIdIRC.GetUserInfo(const ANickname: String);
begin
  Raw(IndyFormat('USERHOST %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.IsOnIRC(const ANickname: String);
begin
  Raw(IndyFormat('ISON %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.BecomeOp(const ANickname, APassword: String);
begin
  Raw(IndyFormat('OPER %s %s', [ANickname, APassword]));  {do not localize}
end;

procedure TIdIRC.SQuit(const AHost, AComment: String);
begin
  Raw(IndyFormat('SQUIT %s %s', [AHost, AComment]));  {do not localize}
end;

procedure TIdIRC.SetChannelLimit(const AChannel: String; ALimit: Integer);
begin
  SetChannelMode(AChannel, '+l', IntToStr(ALimit)); {do not localize}
end;

procedure TIdIRC.SetChannelKey(const AChannel, AKey: String);
begin
  SetChannelMode(AChannel, '+k', AKey); {do not localize}
end;

procedure TIdIRC.SetIOHandler(AValue: TIdIOHandler);
begin
  inherited SetIOHandler(AValue);
  //we do it this way so that if a user is using a custom value <> default, the port
  //is not set when the IOHandler is changed.
  if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    if Port = IdPORT_IRC then begin
      Port := IdPORT_IRCS;
    end;
  end else begin
    if Port = IdPORT_IRCS then begin
      Port := IdPORT_IRC;
    end;
  end;
end;

end.


