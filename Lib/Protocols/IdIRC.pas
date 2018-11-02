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

{ Based on RFC 2812 }

interface

{$i IdCompilerDefines.inc}

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
  TIdIRCServerMsgEvent = procedure(ASender: TIdContext; const AMsg: String) of object;
  TIdIRCMyInfoEvent = procedure(ASender: TIdContext; const AServer, AVersion, AUserModes, AChanModes, AExtra: String) of object;
  TIdIRCBounceEvent = procedure(ASender: TIdContext; const AHost: String; APort: Integer; const AInfo: String) of object;
  TIdIRCISupportEvent = procedure(ASender: TIdContext; AParameters: TStrings) of object;
  { -PING- }
  TIdIRCPingPongEvent = procedure(ASender: TIdContext) of object;
  { -MESSAGE- }
  TIdIRCPrivMessageEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATarget, AMessage: String) of object;
  { -NOTICE- }
  TIdIRCNoticeEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATarget, ANotice: String) of object;
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
  TIdIRCPartEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel, APartMessage: String) of object;
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
  TIdIRCInviteEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATarget, AChannel: String) of object;
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
  TIdIRCUserInfoRecvEvent = procedure(ASender: TIdContext; const AUserInfo: String) of object;
  { -WHO- }
  TIdIRCWhoEvent = procedure(ASender: TIdContext; AWhoResults: TStrings) of object;
  TIdIRCWhoIsEvent = procedure(ASender: TIdContext; AWhoIsResults: TStrings) of object;
  TIdIRCWhoWasEvent = procedure(ASender: TIdContext; AWhoWasResults: TStrings) of object;
  { Mode }
  TIdIRCChanModeEvent = procedure(ASender: TIdContext; const ANickname, AHost, AChannel, AMode, AParams: String) of object;
  TIdIRCUserModeEvent = procedure(ASender: TIdContext; const ANickname, AHost, AMode: String) of object;
  { -CTCP- }
  TIdIRCCTCPQueryEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATarget, ACommand, AParams: String) of object;
  TIdIRCCTCPReplyEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATarget, ACommand, AParams: String) of object;
  { -DCC- }
  TIdIRCDCCChatEvent = procedure(ASender: TIdContext; const ANickname, AHost: String; APort: Integer) of object;
  TIdIRCDCCSendEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort: TIdPort; AFileSize: Int64) of object;
  TIdIRCDCCResumeEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort: TIdPort;  AFilePos: Int64) of object;
  TIdIRCDCCAcceptEvent = procedure(ASender: TIdContext; const ANickname, AHost, AFilename: String; APort: TIdPort; AFilePos: Int64) of object;
  { -Errors- }
  TIdIRCServerErrorEvent = procedure(ASender: TIdContext; AErrorCode: Integer; const AErrorMessage: String) of object;
  TIdIRCNickErrorEvent = procedure(ASender: TIdContext; AError: Integer) of object;
  TIdIRCKillErrorEvent = procedure(ASender: TIdContext) of object;
  { Other }
  TIdIRCNicknameChangedEvent = procedure(ASender: TIdContext; const AOldNickname, AHost, ANewNickname: String) of object;
  TIdIRCKillEvent = procedure(ASender: TIdContext; const ANickname, AHost, ATargetNickname, AReason: String) of object;
  TIdIRCQuitEvent = procedure(ASender: TIdContext; const ANickname, AHost, AReason: String) of object;
  TIdIRCSvrQuitEvent = procedure(ASender: TIdContext; const ANickname, AHost, AServer, AReason: String) of object;
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
    FAltNickUsed: Boolean;
    //
    FUsername: String;
    FRealName: String;
    FPassword: String;
    FUserMode: TIdIRCUserModes;
    FUserAway: Boolean;
    FReplies: TIdIRCReplies;
    //
    FSenderNick: String;
    FSenderHost: String;
    //
    FBans: TStrings;
    FExcepts: TStrings;
    FInvites: TStrings;
    FLinks: TStrings;
    FMotd: TStrings;
    FNames: TStrings;
    FWho: TStrings;
    FWhoIs: TStrings;
    FWhoWas: TStrings;
    FSvrList: TStrings;
    FUsers: TStrings;
    //
    FOnSWelcome: TIdIRCServerMsgEvent;
    FOnYourHost: TIdIRCServerMsgEvent;
    FOnSCreated: TIdIRCServerMsgEvent;
    FOnMyInfo: TIdIRCMyInfoEvent;
    FOnBounce: TIdIRCBounceEvent;
    FOnISupport: TIdIRCISupportEvent;
    FOnSError: TIdIRCServerMsgEvent;
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
    FOnSvrQuit: TIdIRCSvrQuitEvent;
    FOnSvrTime: TIdIRCSvrTimeEvent;
    FOnService: TIdIRCServiceEvent;
    FOnSvrVersion: TIdIRCSvrVersionEvent;
    FOnRaw: TIdIRCRawEvent;
    //
    function GetUsedNickname: String;
    procedure SetNickname(const AValue: String);
    procedure SetUsername(const AValue: String);
    procedure SetIdIRCUserMode(AValue: TIdIRCUserModes);
    procedure SetIdIRCReplies(AValue: TIdIRCReplies);
    function GetUserMode: String;
    procedure ParseDCC(AContext: TIdContext; const ADCC: String);
    //Command handlers
    procedure DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
    procedure DoReplyUnknownCommand(AContext: TIdContext; ALine: string); override;
    procedure DoBounce(ASender: TIdCommand; ALegacy: Boolean);
    procedure CommandPRIVMSG(ASender: TIdCommand);
    procedure CommandNOTICE(ASender: TIdCommand);
    procedure CommandJOIN(ASender: TIdCommand);
    procedure CommandPART(ASender: TIdCommand);
    procedure CommandKICK(ASender: TIdCommand);
    procedure CommandMODE(ASender: TIdCommand);
    procedure CommandNICK(ASender: TIdCommand);
    procedure CommandQUIT(ASender: TIdCommand);
    procedure CommandSQUIT(ASender: TIdCommand);
    procedure CommandINVITE(ASender: TIdCommand);
    procedure CommandKILL(ASender: TIdCommand);
    procedure CommandPING(ASender: TIdCommand);
    procedure CommandERROR(ASender: TIdCommand);
    procedure CommandWALLOPS(ASender: TIdCommand);
    procedure CommandTOPIC(ASender: TIdCommand);
    procedure CommandWELCOME(ASender: TIdCommand);
    procedure CommandYOURHOST(ASender: TIdCommand);
    procedure CommandCREATED(ASender: TIdCommand);
    procedure CommandMYINFO(ASender: TIdCommand);
    procedure CommandISUPPORT(ASender: TIdCommand);
    procedure CommandBOUNCE(ASender: TIdCommand);
    procedure CommandUSERHOST(ASender: TIdCommand);
    procedure CommandISON(ASender: TIdCommand);
    procedure CommandWHOIS(ASender: TIdCommand);
    procedure CommandENDOFWHOIS(ASender: TIdCommand);
    procedure CommandWHOWAS(ASender: TIdCommand);
    procedure CommandENDOFWHOWAS(ASender: TIdCommand);
    procedure CommandLISTSTART(ASender: TIdCommand);
    procedure CommandLIST(ASender: TIdCommand);
    procedure CommandLISTEND(ASender: TIdCommand);
    procedure CommandAWAY(ASender: TIdCommand);
    procedure CommandINVITING(ASender: TIdCommand);
    procedure CommandSUMMONING(ASender: TIdCommand);
    procedure CommandINVITELIST(ASender: TIdCommand);
    procedure CommandENDOFINVITELIST(ASender: TIdCommand);
    procedure CommandEXCEPTLIST(ASender: TIdCommand);
    procedure CommandENDOFEXCEPTLIST(ASender: TIdCommand);
    procedure CommandWHOREPLY(ASender: TIdCommand);
    procedure CommandENDOFWHO(ASender: TIdCommand);
    procedure CommandNAMEREPLY(ASender: TIdCommand);
    procedure CommandENDOFNAMES(ASender: TIdCommand);
    procedure CommandLINKS(ASender: TIdCommand);
    procedure CommandENDOFLINKS(ASender: TIdCommand);
    procedure CommandBANLIST(ASender: TIdCommand);
    procedure CommandENDOFBANLIST(ASender: TIdCommand);
    procedure CommandINFO(ASender: TIdCommand);
    procedure CommandENDOFINFO(ASender: TIdCommand);
    procedure CommandMOTD(ASender: TIdCommand);
    procedure CommandENDOFMOTD(ASender: TIdCommand);
    procedure CommandREHASHING(ASender: TIdCommand);
    procedure CommandUSERSSTART(ASender: TIdCommand);
    procedure CommandUSERS(ASender: TIdCommand);
    procedure CommandENDOFUSERS(ASender: TIdCommand);
    procedure CommandENDOFSTATS(ASender: TIdCommand);
    procedure CommandSERVLIST(ASender: TIdCommand);
    procedure CommandSERVLISTEND(ASender: TIdCommand);
    procedure CommandTIME(ASender: TIdCommand);
    procedure CommandSERVICE(ASender: TIdCommand);
    procedure CommandVERSION(ASender: TIdCommand);
    procedure CommandCHANMODE(ASender: TIdCommand);
    procedure CommandOPER(ASender: TIdCommand);
    procedure CommandNICKINUSE(ASender: TIdCommand);
    //
    procedure AssignIRCClientCommands;
    function GetCmdHandlerClass: TIdCommandHandlerClass; override;
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
    procedure Kick(const AChannel, ANickname: String; const AReason: String = '');
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
    procedure RequestServerConnect(const ATargetHost: String; APort: Integer; const ARemoteHost: String = '');
    procedure TraceServer(const ATarget: String = '');
    procedure GetAdminInfo(const ATarget: String = '');
    procedure GetServerInfo(const ATarget: String = '');
    procedure ListNetworkServices(const AHostMask: String = ''; const AType: String = '');
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
    procedure GetUsersInfo(const ANicknames: array of String);
    procedure IsOnIRC(const ANickname: String); overload;
    procedure IsOnIRC(const ANicknames: array of String); overload;
    procedure BecomeOp(const ANickname, APassword: String);
    procedure SQuit(const AHost, AComment: String);
    procedure SetChannelLimit(const AChannel: String; ALimit: Integer);
    procedure SetChannelKey(const AChannel, AKey: String);
    //
    property Away: Boolean read FUserAway;
  published
    property Nickname: String read FNickname write SetNickname;
    property AltNickname: String read FAltNickname write FAltNickname;
    property UsedNickname: String read GetUsedNickname; // returns Nickname or AltNickname
    property Username: String read FUsername write SetUsername;
    property RealName: String read FRealName write FRealName;
    property Password: String read FPassword write FPassword;
    property Port default IdPORT_IRC;
    property Replies: TIdIRCReplies read FReplies write SetIdIRCReplies;
    property UserMode: TIdIRCUserModes read FUserMode write SetIdIRCUserMode;
    { Events }
    property OnServerWelcome: TIdIRCServerMsgEvent read FOnSWelcome write FOnSWelcome;
    property OnYourHost: TIdIRCServerMsgEvent read FOnYourHost write FOnYourHost;
    property OnServerCreated: TIdIRCServerMsgEvent read FOnSCreated write FOnSCreated;
    property OnMyInfo: TIdIRCMyInfoEvent read FOnMyInfo write FOnMyInfo;
    property OnBounce: TIdIRCBounceEvent read FOnBounce write FOnBounce;
    property OnISupport: TIdIRCISupportEvent read FOnISupport write FOnISupport;
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
    property OnServerQuit: TIdIRCSvrQuitEvent read FOnSvrQuit write FOnSvrQuit;
    property OnServerTime: TIdIRCSvrTimeEvent read FOnSvrTime write FOnSvrTime;
    property OnService: TIdIRCServiceEvent read FOnService write FOnService;
    property OnServerVersion: TIdIRCSvrVersionEvent read FOnSvrVersion write FOnSvrVersion;
    property OnRaw: TIdIRCRawEvent read FOnRaw write FOnRaw;
  end;

implementation

uses
  IdGlobalProtocols, IdResourceStringsProtocols, IdSSL,
  IdStack, IdBaseComponent, SysUtils;

const
  IdIRCCTCP: array[0..11] of String = ('ACTION', 'SOUND', 'PING', 'FINGER', {do not localize}
    'USERINFO', 'VERSION', 'CLIENTINFO', 'TIME', 'ERROR', 'DCC', 'SED', 'ERRMSG');  {do not localize}

  MQuote = #16;
  XDelim = #1;
  XQuote = #92;

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
  end else begin
    inherited Assign(Source);
  end;
end;

{ TIdIRC }

// RLebeau 1/7/2010: SysUtils.TrimLeft() removes all characters < #32, but
// CTC requires character #1, so don't remove that character when parsing
// IRC parameters in FetchIRCParam()...
//
function IRCTrimLeft(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') and (S[I] <> XDelim) do begin
    Inc(I);
  end;
  Result := Copy(S, I, Maxint);
end;

function FetchIRCParam(var S: String): String;
var
  LTmp: String;
begin
  LTmp := IRCTrimLeft(S);
  if TextStartsWith(LTmp, ':') then
  begin
    Result := Copy(LTmp, 2, MaxInt);
    S := '';
  end else
  begin
    Result := Fetch(LTmp, ' ');
    S := IRCTrimLeft(LTmp);
  end;
end;

function IRCQuote(const S: String): String;
begin
  // IMPORTANT! MQuote needs to be the first character in the replacement
  // list, otherwise it will end up being double-escaped if the other
  // character get replaced, which will produce the wrong output!!
  Result := StringsReplace(S, [MQuote, #0, LF, CR], [MQuote+MQuote, MQuote+'0', MQuote+'n', MQuote+'r']);
end;

{$IFDEF STRING_IS_IMMUTABLE}
function FindCharInSB(const ASB: TIdStringBuilder; AChar: Char; AStart: Integer): Integer;
begin
  for Result := AStart to ASB.Length-1 do begin
    if ASB[Result] = AChar then begin
      Exit;
    end;
  end;
  Result := -1;
end;
{$ENDIF}

function IRCUnquote(const S: String): String;
var
  I, L: Integer;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}

begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(S);
  L := LSB.Length;
  I := 0;
  while I < L do begin
    I := FindCharInSB(LSB, MQuote, I);
    if I = -1 then begin
      Break;
    end;
    LSB.Remove(I, 1);
    Dec(L);
    if I >= L then begin
      Break;
    end;
    case LSB[I] of
      '0': LSB[I] := #0;
      'n': LSB[I] := LF;
      'r': LSB[I] := CR;
    end;
    Inc(I);
  end;
  Result := LSB.ToString;
  {$ELSE}
  Result := S;
  L := Length(Result);
  I := 1;
  while I <= L do begin
    I := PosIdx(MQuote, Result, I);
    if I = 0 then begin
      Break;
    end;
    IdDelete(Result, I, 1);
    Dec(L);
    if I > L then begin
      Break;
    end;
    case Result[I] of
      '0': Result[I] := #0;
      'n': Result[I] := LF;
      'r': Result[I] := CR;
    end;
    Inc(I);
  end;
  {$ENDIF}
end;

function CTCPQuote(const S: String): String;
begin
  Result := StringsReplace(S, [XDelim, XQuote], [XQuote+'a', XQuote+XQuote]);
end;

function CTCPUnquote(const S: String): String;
var
  I, L: Integer;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(S);
  L := LSB.Length;
  I := 0;
  while I < L do begin
    I := FindCharInSB(LSB, XQuote, I);
    if I = -1 then begin
      Break;
    end;
    LSB.Remove(I, 1);
    Dec(L);
    if I >= L then begin
      Break;
    end;
    if LSB[I] = 'a' then begin
      LSB[I] := XDelim;
    end;
    Inc(I);
  end;
  Result := LSB.ToString;
  {$ELSE}
  Result := S;
  L := Length(Result);
  I := 1;
  while I <= L do begin
    I := PosIdx(XQuote, Result, I);
    if I = 0 then begin
      Break;
    end;
    IdDelete(Result, I, 1);
    Dec(L);
    if I > L then begin
      Break;
    end;
    if Result[I] = 'a' then begin
      Result[I] := XDelim;
    end;
    Inc(I);
  end;
  {$ENDIF}
end;

procedure ExtractCTCPs(var AText: String; CTCPs: TStrings);
var
  LTmp: String;
  I, J, K: Integer;
begin
  I := 1;
  repeat
    J := PosIdx(XDelim, AText, I);
    if J = 0 then begin
      Break;
    end;
    K := PosIdx(XDelim, AText, J+1);
    if K = 0 then begin
      Break;
    end;
    LTmp := Copy(AText, J+1, K-J-1);
    LTmp := CTCPUnquote(LTmp);
    CTCPs.Add(LTmp);
    IdDelete(AText, J, (K-J)+1);
    I := J;
  until False;
end;

type
  TIdIRCCommandHandler = class(TIdCommandHandler)
  public
    procedure DoParseParams(AUnparsedParams: string; AParams: TStrings); override;
  end;

procedure TIdIRCCommandHandler.DoParseParams(AUnparsedParams: string; AParams: TStrings);
begin
  AParams.BeginUpdate;
  try
    AParams.Clear;
    while AUnparsedParams <> '' do begin
      AParams.Add(FetchIRCParam(AUnparsedParams));
    end;
  finally
    AParams.EndUpdate;
  end;
end;

function TIdIRC.GetCmdHandlerClass: TIdCommandHandlerClass;
begin
  Result := TIdIRCCommandHandler;
end;

procedure TIdIRC.InitComponent;
begin
  inherited InitComponent;
  //
  FReplies := TIdIRCReplies.Create;
  Port := IdPORT_IRC;
  FUserMode := [];

  // RLebeau 2/21/08: for the IRC protocol, RFC 2812 section 2.4 says that
  // clients are not allowed to issue numeric replies for server-issued
  // commands.  Added the PerformReplies property so TIdIRC can specify
  // that behavior.
  CommandHandlers.PerformReplies := False;

  // RLebeau 3/11/08: most of the command handlers should parse parameters by default
  CommandHandlers.ParseParamsDefault := True;

  if not IsDesignTime then begin
    AssignIRCClientCommands;
  end;
end;

destructor TIdIRC.Destroy;
begin
  FreeAndNil(FReplies);
  FreeAndNil(FBans);
  FreeAndNil(FExcepts);
  FreeAndNil(FInvites);
  FreeAndNil(FLinks);
  FreeAndNil(FMotd);
  FreeAndNil(FNames);
  FreeAndNil(FWho);
  FreeAndNil(FWhoIs);
  FreeAndNil(FWhoWas);
  FreeAndNil(FSvrList);
  FreeAndNil(FUsers);
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
    FAltNickUsed := False;
    if FPassword <> '' then begin
      Raw(IndyFormat('PASS %s', [FPassword]));  {do not localize}
    end;
    SetNickname(FNickname);
    SetUsername(FUsername);
  except
    on E: EIdSocketError do begin
      inherited Disconnect;
      IndyRaiseOuterException(EIdIRCError.Create(RSIRCCannotConnect));
    end;
  end;
end;

procedure TIdIRC.Disconnect(const AReason: String = '');
begin
  try
    Raw(IndyFormat('QUIT :%s', [AReason])); {do not localize}
  finally
    inherited Disconnect;
  end;
end;

procedure TIdIRC.Raw(const ALine: String);
begin
  if Connected then begin
    if Assigned(FOnRaw) then begin
      // TODO: use FListeningThread.FContext instead of nil...
      FOnRaw(nil, False, ALine);
    end;
    IOHandler.WriteLn(IRCQuote(ALine));
  end;
end;

procedure TIdIRC.AssignIRCClientCommands;
var
  LCommandHandler: TIdCommandHandler;
begin
  { Text commands }
  //PRIVMSG Nickname/#channel :message
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PRIVMSG'; {do not localize}
  LCommandHandler.OnCommand := CommandPRIVMSG;
  LCommandHandler.ParseParams := False;

  //NOTICE Nickname/#channel :message
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NOTICE';  {do not localize}
  LCommandHandler.OnCommand := CommandNOTICE;
  LCommandHandler.ParseParams := False;

  //JOIN #channel
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'JOIN';  {do not localize}
  LCommandHandler.OnCommand := CommandJOIN;

  //PART #channel
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PART';  {do not localize}
  LCommandHandler.OnCommand := CommandPART;

  //KICK #channel target :reason
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'KICK';  {do not localize}
  LCommandHandler.OnCommand := CommandKICK;

  //MODE Nickname/#channel +/-modes parameters...
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'MODE';  {do not localize}
  LCommandHandler.OnCommand := CommandMODE;
  LCommandHandler.ParseParams := False;

  //NICK newNickname
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NICK';  {do not localize}
  LCommandHandler.OnCommand := CommandNICK;

  //QUIT :reason
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'QUIT';  {do not localize}
  LCommandHandler.OnCommand := CommandQUIT;

  //SQUIT server :reason
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SQUIT';  {do not localize}
  LCommandHandler.OnCommand := CommandSQUIT;

  //INVITE Nickname :#channel
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'INVITE';  {do not localize}
  LCommandHandler.OnCommand := CommandINVITE;

  //KILL Nickname :reason
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'KILL';  {do not localize}
  LCommandHandler.OnCommand := CommandKILL;

  //PING server
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PING';  {do not localize}
  LCommandHandler.OnCommand := CommandPING;

  //WALLOPS :message
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'WALLOPS'; {do not localize}
  LCommandHandler.OnCommand := CommandWALLOPS;
  LCommandHandler.ParseParams := False;

  //TOPIC
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'TOPIC'; {do not localize}
  LCommandHandler.OnCommand := CommandTOPIC;

  //ERROR message
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'ERROR'; {do not localize}
  LCommandHandler.OnCommand := CommandERROR;
  LCommandHandler.ParseParams := False;

  { Numeric commands, refer to http://www.alien.net.au/irc/irc2numerics.html }
  //RPL_WELCOME
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '001'; {do not localize}
  LCommandHandler.OnCommand := CommandWELCOME;
  LCommandHandler.ParseParams := False;

  //RPL_YOURHOST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '002'; {do not localize}
  LCommandHandler.OnCommand := CommandYOURHOST;

  //RPL_CREATED
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '003'; {do not localize}
  LCommandHandler.OnCommand := CommandCREATED;

  //RPL_MYINFO
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '004'; {do not localize}
  LCommandHandler.OnCommand := CommandMYINFO;
  LCommandHandler.ParseParams := False;

  //RPL_BOUNCE (deprecated), RPL_ISUPPORT (new)
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '005'; {do not localize}
  //LCommandHandler.OnCommand := CommandBOUNCE; // deprecated
  LCommandHandler.OnCommand := CommandISUPPORT;

  { TODO:
  008  RPL_SNOMASK  ircu   Server notice mask (hex)
  009  RPL_STATMEMTOT  ircu
  014  RPL_YOURCOOKIE  Hybrid?
  042  RPL_YOURID  IRCnet
  043  RPL_SAVENICK  IRCnet  :<info>  Sent to the client when their nickname was forced to change due to a collision
  050  RPL_ATTEMPTINGJUNC  aircd
  051  RPL_ATTEMPTINGREROUTE  aircd
  200  RPL_TRACELINK  RFC1459  Link <version>[.<debug_level>] <destination> <next_server> [V<protocol_version> <link_uptime_in_seconds> <backstream_sendq> <upstream_sendq>]  See RFC
  201  RPL_TRACECONNECTING  RFC1459  Try. <class> <server>  See RFC
  202  RPL_TRACEHANDSHAKE  RFC1459  H.S. <class> <server>  See RFC
  203  RPL_TRACEUNKNOWN  RFC1459  ???? <class> [<connection_address>]  See RFC
  204  RPL_TRACEOPERATOR  RFC1459  Oper <class> <nick>  See RFC
  205  RPL_TRACEUSER  RFC1459  User <class> <nick>  See RFC
  206  RPL_TRACESERVER  RFC1459  Serv <class> <int>S <int>C <server> <nick!user|*!*>@<host|server> [V<protocol_version>]  See RFC
  207  RPL_TRACESERVICE  RFC2812  Service <class> <name> <type> <active_type>  See RFC
  208  RPL_TRACENEWTYPE  RFC1459  <newtype> 0 <client_name>  See RFC
  209  RPL_TRACECLASS  RFC2812  Class <class> <count>  See RFC
  210  RPL_TRACERECONNECT  RFC2812
  210  RPL_STATS  aircd   Used instead of having multiple stats numerics
  211  RPL_STATSLINKINFO  RFC1459  <linkname> <sendq> <sent_msgs> <sent_bytes> <recvd_msgs> <rcvd_bytes> <time_open>  Reply to STATS (See RFC)
  212  RPL_STATSCOMMANDS  RFC1459  <command> <count> [<byte_count> <remote_count>]  Reply to STATS (See RFC)
  213  RPL_STATSCLINE  RFC1459  C <host> * <name> <port> <class>  Reply to STATS (See RFC)
  214  RPL_STATSNLINE  RFC1459  N <host> * <name> <port> <class>  Reply to STATS (See RFC), Also known as RPL_STATSOLDNLINE (ircu, Unreal)
  215  RPL_STATSILINE  RFC1459  I <host> * <host> <port> <class>  Reply to STATS (See RFC)
  216  RPL_STATSKLINE  RFC1459  K <host> * <username> <port> <class>  Reply to STATS (See RFC)
  217  RPL_STATSQLINE  RFC1459
  217  RPL_STATSPLINE  ircu
  218  RPL_STATSYLINE
  }
  // RPL_BOUNCE (new)
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '010'; {do not localize}
  LCommandHandler.OnCommand := CommandBOUNCE;

  //RPL_ENDOFSTATS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '219'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFSTATS;

  {TODO:
  221  RPL_UMODEIS  RFC1459  <user_modes> [<user_mode_params>]  Information about a user's own modes. Some daemons have extended the mode command and certain modes take parameters (like channel modes).
  }
  //RPL_SERVLIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '234'; {do not localize}
  LCommandHandler.OnCommand := CommandSERVLIST;

  //RPL_SERVLISTEND
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '235'; {do not localize}
  LCommandHandler.OnCommand := CommandSERVLISTEND;

  {TODO:
  236  RPL_STATSVERBOSE  ircu   Verbose server list?
  237  RPL_STATSENGINE  ircu   Engine name?
  239  RPL_STATSIAUTH  IRCnet
  241  RPL_STATSLLINE  RFC1459  L <hostmask> * <servername> <maxdepth>  Reply to STATS (See RFC)
  242  RPL_STATSUPTIME  RFC1459  :Server Up <days> days <hours>:<minutes>:<seconds>  Reply to STATS (See RFC)
  243  RPL_STATSOLINE  RFC1459  O <hostmask> * <nick> [:<info>]  Reply to STATS (See RFC); The info field is an extension found in some IRC daemons, which returns info such as an e-mail address or the name/job of an operator
  244  RPL_STATSHLINE  RFC1459  H <hostmask> * <servername>  Reply to STATS (See RFC)
  245  RPL_STATSSLINE  Bahamut, IRCnet, Hybrid
  250  RPL_STATSCONN  ircu, Unreal    
  251  RPL_LUSERCLIENT  RFC1459  :There are <int> users and <int> invisible on <int> servers  Reply to LUSERS command, other versions exist (eg. RFC2812); Text may vary.
  252  RPL_LUSEROP  RFC1459  <int> :<info>  Reply to LUSERS command - Number of IRC operators online
  253  RPL_LUSERUNKNOWN  RFC1459  <int> :<info>  Reply to LUSERS command - Number of unknown/unregistered connections
  254  RPL_LUSERCHANNELS  RFC1459  <int> :<info>  Reply to LUSERS command - Number of channels formed
  255  RPL_LUSERME  RFC1459  :I have <int> clients and <int> servers  Reply to LUSERS command - Information about local connections; Text may vary.
  256  RPL_ADMINME  RFC1459  <server> :<info>  Start of an RPL_ADMIN* reply. In practise, the server parameter is often never given, and instead the info field contains the text 'Administrative info about <server>'. Newer daemons seem to follow the RFC and output the server's hostname in the 'server' parameter, but also output the server name in the text as per traditional daemons.
  257  RPL_ADMINLOC1  RFC1459  :<admin_location>  Reply to ADMIN command (Location, first line)
  258  RPL_ADMINLOC2  RFC1459  :<admin_location>  Reply to ADMIN command (Location, second line)
  259  RPL_ADMINEMAIL  RFC1459  :<email_address>  Reply to ADMIN command (E-mail address of administrator)
  261  RPL_TRACELOG  RFC1459  File <logfile> <debug_level>  See RFC
  263  RPL_TRYAGAIN  RFC2812  <command> :<info>  When a server drops a command without processing it, it MUST use this reply. Also known as RPL_LOAD_THROTTLED and RPL_LOAD2HI, I'm presuming they do the same thing.
  265  RPL_LOCALUSERS  aircd, Hybrid, Hybrid, Bahamut   Also known as RPL_CURRENT_LOCAL
  266  RPL_GLOBALUSERS  aircd, Hybrid, Hybrid, Bahamut   Also known as RPL_CURRENT_GLOBAL
  267  RPL_START_NETSTAT  aircd
  268  RPL_NETSTAT  aircd
  269  RPL_END_NETSTAT  aircd
  270  RPL_PRIVS  ircu
  271  RPL_SILELIST  ircu
  272  RPL_ENDOFSILELIST  ircu
  273  RPL_NOTIFY  aircd
  276  RPL_VCHANEXIST     
  277  RPL_VCHANLIST
  278  RPL_VCHANHELP
  280  RPL_GLIST  ircu
  296  RPL_CHANINFO_KICKS  aircd
  299  RPL_END_CHANINFO  aircd
  300  RPL_NONE  RFC1459   Dummy reply, supposedly only used for debugging/testing new features, however has appeared in production daemons.
  }
  //RPL_AWAY
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '301'; {do not localize}
  LCommandHandler.OnCommand := CommandAWAY;

  //RPL_USERHOST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '302'; {do not localize}
  LCommandHandler.OnCommand := CommandUSERHOST;
  LCommandHandler.ParseParams := False;

  //RPL_ISON
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '303'; {do not localize}
  LCommandHandler.OnCommand := CommandISON;

  //RPL_UNAWAY
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '305'; {do not localize}
  LCommandHandler.OnCommand := CommandAWAY;

  //RPL_NOWAWAY
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '306'; {do not localize}
  LCommandHandler.OnCommand := CommandAWAY;

  //RPL_WHOISUSER
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '311'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOIS;

  //RPL_WHOISSERVER
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '312'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOIS;

  //RPL_WHOISOPERATOR
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '313'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOIS;

  //RPL_WHOWASUSER
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '314';
  LCommandHandler.OnCommand := CommandWHOWAS;

  //RPL_ENDOFWHO
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '315'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFWHO;

  //RPL_WHOISIDLE
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '317'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOIS;

  //RPL_ENDOFWHOIS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '318'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFWHOIS;

  //RPL_WHOISCHANNELS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '319'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOIS;

  {TODO:
  320  RPL_WHOISVIRT  AustHex
  320  RPL_WHOIS_HIDDEN  Anothernet
  320  RPL_WHOISSPECIAL  Unreal
  }
  //RPL_LISTSTART
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '321'; {do not localize}
  LCommandHandler.OnCommand := CommandLISTSTART;

  //RPL_LIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '322'; {do not localize}
  LCommandHandler.OnCommand := CommandLIST;

  //RPL_LISTEND
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '323'; {do not localize}
  LCommandHandler.OnCommand := CommandLISTEND;

  //RPL_CHANMODEIS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '324'; {do not localize}
  LCommandHandler.OnCommand := CommandCHANMODE;

  //RPL_UNIQOPIS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '325'; {do not localize}
  //LCommandHandler.OnCommand := CommandUNIQOP;

  {TODO:
  326  RPL_NOCHANPASS
  327  RPL_CHPASSUNKNOWN
  328  RPL_CHANNEL_URL  Bahamut, AustHex
  329  RPL_CREATIONTIME  Bahamut
  }
  //RPL_NOTOPIC
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '331'; {do not localize}
  LCommandHandler.OnCommand := CommandTOPIC;

  //RPL_TOPIC
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '332';
  LCommandHandler.OnCommand := CommandTOPIC;

  {TODO:
  333  RPL_TOPICWHOTIME  ircu
  339  RPL_BADCHANPASS
  340  RPL_USERIP  ircu
  }
  //RPL_INVITING
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '341'; {do not localize}
  LCommandHandler.OnCommand := CommandINVITING;

  //RPL_SUMMONING
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '342'; {do not localize}
  LCommandHandler.OnCommand := CommandSUMMONING;

  {TODO:
  345  RPL_INVITED  GameSurge  <channel> <user being invited> <user issuing invite> :<user being invited> has been invited by <user issuing invite>  Sent to users on a channel when an INVITE command has been issued
  }
  //RPL_INVITELIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '346'; {do not localize}
  LCommandHandler.OnCommand := CommandINVITELIST;

  //RPL_ENDOFINVITELIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '347'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFINVITELIST;

  //RPL_EXCEPTLIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '348'; {do not localize}
  LCommandHandler.OnCommand := CommandEXCEPTLIST;

  //RPL_ENDOFEXCEPTLIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '349'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFEXCEPTLIST;

  //RPL_VERSION
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '351'; {do not localize}
  LCommandHandler.OnCommand := CommandVERSION;

  //RPL_WHOREPLY
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '352'; {do not localize}
  LCommandHandler.OnCommand := CommandWHOREPLY;

  //RPL_NAMEREPLY
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '353'; {do not localize}
  LCommandHandler.OnCommand := CommandNAMEREPLY;

  { TODO:
  354  RPL_WHOSPCRPL  ircu   Reply to WHO, however it is a 'special' reply because it is returned using a non-standard (non-RFC1459) format. The format is dictated by the command given by the user, and can vary widely. When this is used, the WHO command was invoked in its 'extended' form, as announced by the 'WHOX' ISUPPORT tag.
  355  RPL_NAMREPLY_  QuakeNet  ( '=' / '*' / '@' ) <channel> ' ' : [ '@' / '+' ] <nick> *( ' ' [ '@' / '+' ] <nick> )  Reply to the "NAMES -d" command - used to show invisible users (when the channel is set +D, QuakeNet relative). The proper define name for this numeric is unknown at this time Also see #353.
  }
  //RPL_LINKS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '364'; {do not localize}
  LCommandHandler.OnCommand := CommandLINKS;

  //RPL_ENDOFLINKS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '365'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFLINKS;

  //RPL_ENDOFNAMES
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '366'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFNAMES;

  // RPL_BANLIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '367'; {do not localize}
  LCommandHandler.OnCommand := CommandBANLIST;

  //RPL_ENDOFBANLIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '368'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFBANLIST;

  //RPL_ENDOFWHOWAS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '369'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFWHOWAS;

  //RPL_INFO
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '371'; {do not localize}
  LCommandHandler.OnCommand := CommandINFO;

  //RPL_MOTD
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '372'; {do not localize}
  LCommandHandler.OnCommand := CommandMOTD;

  //RPL_ENDOFINFO
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '374'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFINFO;
  LCommandHandler.ParseParams := False;

  //RPL_MOTDSTART
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '375'; {do not localize}
  LCommandHandler.OnCommand := CommandMOTD;

  //RPL_ENDOFMOTD
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '376'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFMOTD;

  //RPL_YOUREOPER
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '381'; {do not localize}
  //LCommandHandler.OnCommand := CommandYOUAREOPER;

  //RPL_REHASHING
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '382'; {do not localize}
  LCommandHandler.OnCommand := CommandREHASHING;

  //RPL_YOUARESERVICE
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '383'; {do not localize}
  LCommandHandler.OnCommand := CommandSERVICE;

  {TODO:
  385  RPL_NOTOPERANYMORE  AustHex, Hybrid, Unreal
  388  RPL_ALIST  Unreal
  389  RPL_ENDOFALIST  Unreal
  }
  //RPL_TIME
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '391'; {do not localize}
  LCommandHandler.OnCommand := CommandTIME;

  //RPL_USERSSTART
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '392'; {do not localize}
  LCommandHandler.OnCommand := CommandUSERSSTART;

  //RPL_USERS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '393'; {do not localize}
  LCommandHandler.OnCommand := CommandUSERS;

  //RPL_ENDOFUSERS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '394'; {do not localize}
  LCommandHandler.OnCommand := CommandENDOFUSERS;

  //RPL_NOUSERS
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '395'; {do not localize}
  LCommandHandler.OnCommand := CommandUSERS;

  //ERR_NICKNAMEINUSE
  LCommandHandler := CommandHandlers.Add;
  // 433  ERR_NICKNAMEINUSE  RFC1459  <nick> :<reason>
  // Returned by the NICK command when the given nickname is already in use
  LCommandHandler.Command := '433'; {do not localize}
  LCommandHandler.OnCommand := CommandNICKINUSE;

  {TODO:
  396  RPL_HOSTHIDDEN  Undernet   Reply to a user when user mode +x (host masking) was set successfully
  400  ERR_UNKNOWNERROR   <command> [<?>] :<info>  Sent when an error occured executing a command, but it is not specifically known why the command could not be executed.
  401  ERR_NOSUCHNICK  RFC1459  <nick> :<reason>  Used to indicate the nickname parameter supplied to a command is currently unused
  402  ERR_NOSUCHSERVER  RFC1459  <server> :<reason>  Used to indicate the server name given currently doesn't exist
  403  ERR_NOSUCHCHANNEL  RFC1459  <channel> :<reason>  Used to indicate the given channel name is invalid, or does not exist
  404  ERR_CANNOTSENDTOCHAN  RFC1459  <channel> :<reason>  Sent to a user who does not have the rights to send a message to a channel
  405  ERR_TOOMANYCHANNELS  RFC1459  <channel> :<reason>  Sent to a user when they have joined the maximum number of allowed channels and they tried to join another channel
  406  ERR_WASNOSUCHNICK  RFC1459  <nick> :<reason>  Returned by WHOWAS to indicate there was no history information for a given nickname
  407  ERR_TOOMANYTARGETS  RFC1459  <target> :<reason>  The given target(s) for a command are ambiguous in that they relate to too many targets
  408  ERR_NOSUCHSERVICE  RFC2812  <service_name> :<reason>  Returned to a client which is attempting to send an SQUERY (or other message) to a service which does not exist
  409  ERR_NOORIGIN  RFC1459  :<reason>  PING or PONG message missing the originator parameter which is required since these commands must work without valid prefixes
  411  ERR_NORECIPIENT  RFC1459  :<reason>  Returned when no recipient is given with a command
  412  ERR_NOTEXTTOSEND  RFC1459  :<reason>  Returned when NOTICE/PRIVMSG is used with no message given
  413  ERR_NOTOPLEVEL  RFC1459  <mask> :<reason>  Used when a message is being sent to a mask without being limited to a top-level domain (i.e. * instead of *.au)
  414  ERR_WILDTOPLEVEL  RFC1459  <mask> :<reason>  Used when a message is being sent to a mask with a wild-card for a top level domain (i.e. *.*)
  415  ERR_BADMASK  RFC2812  <mask> :<reason>  Used when a message is being sent to a mask with an invalid syntax
  416  ERR_TOOMANYMATCHES  IRCnet  <command> [<mask>] :<info>  Returned when too many matches have been found for a command and the output has been truncated. An example would be the WHO command, where by the mask '*' would match everyone on the network! Ouch!
  416  ERR_QUERYTOOLONG  ircu   Same as ERR_TOOMANYMATCHES
  419  ERR_LENGTHTRUNCATED  aircd
  421  ERR_UNKNOWNCOMMAND  RFC1459  <command> :<reason>  Returned when the given command is unknown to the server (or hidden because of lack of access rights)
  422  ERR_NOMOTD  RFC1459  :<reason>  Sent when there is no MOTD to send the client
  423  ERR_NOADMININFO  RFC1459  <server> :<reason>  Returned by a server in response to an ADMIN request when no information is available. RFC1459 mentions this in the list of numerics. While it's not listed as a valid reply in section 4.3.7 ('Admin command'), it's confirmed to exist in the real world.
  424  ERR_FILEERROR  RFC1459  :<reason>  Generic error message used to report a failed file operation during the processing of a command
  425  ERR_NOOPERMOTD  Unreal
  429  ERR_TOOMANYAWAY  Bahamut
  430  ERR_EVENTNICKCHANGE  AustHex   Returned by NICK when the user is not allowed to change their nickname due to a channel event (channel mode +E)
  431  ERR_NONICKNAMEGIVEN  RFC1459  :<reason>  Returned when a nickname parameter expected for a command isn't found
  432  ERR_ERRONEUSNICKNAME  RFC1459  <nick> :<reason>  Returned after receiving a NICK message which contains a nickname which is considered invalid, such as it's reserved ('anonymous') or contains characters considered invalid for nicknames. This numeric is misspelt, but remains with this name for historical reasons :)
  436  ERR_NICKCOLLISION  RFC1459  <nick> :<reason>  Returned by a server to a client when it detects a nickname collision
  439  ERR_TARGETTOOFAST  ircu   Also known as many other things, RPL_INVTOOFAST, RPL_MSGTOOFAST etc  
  440  ERR_SERVICESDOWN  Bahamut, Unreal
  441  ERR_USERNOTINCHANNEL  RFC1459  <nick> <channel> :<reason>  Returned by the server to indicate that the target user of the command is not on the given channel
  442  ERR_NOTONCHANNEL  RFC1459  <channel> :<reason>  Returned by the server whenever a client tries to perform a channel effecting command for which the client is not a member  
  443  ERR_USERONCHANNEL  RFC1459  <nick> <channel> [:<reason>]  Returned when a client tries to invite a user to a channel they're already on  
  444  ERR_NOLOGIN  RFC1459  <user> :<reason>  Returned by the SUMMON command if a given user was not logged in and could not be summoned  
  445  ERR_SUMMONDISABLED  RFC1459  :<reason>  Returned by SUMMON when it has been disabled or not implemented  
  446  ERR_USERSDISABLED  RFC1459  :<reason>  Returned by USERS when it has been disabled or not implemented  
  447  ERR_NONICKCHANGE  Unreal    
  449  ERR_NOTIMPLEMENTED  Undernet  Unspecified  Returned when a requested feature is not implemented (and cannot be completed)  
  451  ERR_NOTREGISTERED  RFC1459  :<reason>  Returned by the server to indicate that the client must be registered before the server will allow it to be parsed in detail  
  452  ERR_IDCOLLISION     
  453  ERR_NICKLOST     
  455  ERR_HOSTILENAME  Unreal    
  456  ERR_ACCEPTFULL     
  457  ERR_ACCEPTEXIST
  458  ERR_ACCEPTNOT     
  459  ERR_NOHIDING  Unreal   Not allowed to become an invisible operator?  
  460  ERR_NOTFORHALFOPS  Unreal    
  461  ERR_NEEDMOREPARAMS  RFC1459  <command> :<reason>  Returned by the server by any command which requires more parameters than the number of parameters given  
  462  ERR_ALREADYREGISTERED  RFC1459  :<reason>  Returned by the server to any link which attempts to register again  
  463  ERR_NOPERMFORHOST  RFC1459  :<reason>  Returned to a client which attempts to register with a server which has been configured to refuse connections from the client's host  
  464  ERR_PASSWDMISMATCH  RFC1459  :<reason>  Returned by the PASS command to indicate the given password was required and was either not given or was incorrect  
  465  ERR_YOUREBANNEDCREEP  RFC1459  :<reason>  Returned to a client after an attempt to register on a server configured to ban connections from that client  
  466  ERR_YOUWILLBEBANNED  RFC1459   Sent by a server to a user to inform that access to the server will soon be denied  
  467  ERR_KEYSET  RFC1459  <channel> :<reason>  Returned when the channel key for a channel has already been set  
  468  ERR_INVALIDUSERNAME  ircu
  468  ERR_ONLYSERVERSCANCHANGE  Bahamut, Unreal    
  469  ERR_LINKSET  Unreal    
  470  ERR_LINKCHANNEL  Unreal    
  470  ERR_KICKEDFROMCHAN  aircd    
  471  ERR_CHANNELISFULL  RFC1459  <channel> :<reason>  Returned when attempting to join a channel which is set +l and is already full  
  472  ERR_UNKNOWNMODE  RFC1459  <char> :<reason>  Returned when a given mode is unknown  
  473  ERR_INVITEONLYCHAN  RFC1459  <channel> :<reason>  Returned when attempting to join a channel which is invite only without an invitation  
  474  ERR_BANNEDFROMCHAN  RFC1459  <channel> :<reason>  Returned when attempting to join a channel a user is banned from
  475  ERR_BADCHANNELKEY  RFC1459  <channel> :<reason>  Returned when attempting to join a key-locked channel either without a key or with the wrong key  
  476  ERR_BADCHANMASK  RFC2812  <channel> :<reason>  The given channel mask was invalid
  478  ERR_BANLISTFULL  RFC2812  <channel> <char> :<reason>  Returned when a channel access list (i.e. ban list etc) is full and cannot be added to
  479  ERR_BADCHANNAME  Hybrid
  479  ERR_LINKFAIL  Unreal
  481  ERR_NOPRIVILEGES  RFC1459  :<reason>  Returned by any command requiring special privileges (eg. IRC operator) to indicate the operation was unsuccessful
  482  ERR_CHANOPRIVSNEEDED  RFC1459  <channel> :<reason>  Returned by any command requiring special channel privileges (eg. channel operator) to indicate the operation was unsuccessful
  483  ERR_CANTKILLSERVER  RFC1459  :<reason>  Returned by KILL to anyone who tries to kill a server
  485  ERR_UNIQOPRIVSNEEDED  RFC2812  :<reason>  Any mode requiring 'channel creator' privileges returns this error if the client is attempting to use it while not a channel creator on the given channel
  488  ERR_TSLESSCHAN  IRCnet
  491  ERR_NOOPERHOST  RFC1459  :<reason>  Returned by OPER to a client who cannot become an IRC operator because the server has been configured to disallow the client's host
  493  ERR_NOFEATURE  ircu    
  494  ERR_BADFEATURE  ircu
  495  ERR_BADLOGTYPE  ircu
  496  ERR_BADLOGSYS  ircu
  497  ERR_BADLOGVALUE  ircu
  498  ERR_ISOPERLCHAN  ircu
  499  ERR_CHANOWNPRIVNEEDED  Unreal   Works just like ERR_CHANOPRIVSNEEDED except it indicates that owner status (+q) is needed. Also see #482.
  501  ERR_UMODEUNKNOWNFLAG  RFC1459  :<reason>  Returned by the server to indicate that a MODE message was sent with a nickname parameter and that the mode flag sent was not recognised
  502  ERR_USERSDONTMATCH  RFC1459  :<reason>  Error sent to any user trying to view or change the user mode for a user other than themselves
  503  ERR_GHOSTEDCLIENT  Hybrid
  504  ERR_USERNOTONSERV
  511  ERR_SILELISTFULL  ircu
  512  ERR_TOOMANYWATCH  Bahamut   Also known as ERR_NOTIFYFULL (aircd), I presume they are the same
  513  ERR_BADPING  ircu   Also known as ERR_NEEDPONG (Unreal/Ultimate) for use during registration, however it's not used in Unreal (and might not be used in Ultimate either).
  515  ERR_BADEXPIRE  ircu    
  516  ERR_DONTCHEAT  ircu
  517  ERR_DISABLED  ircu  <command> :<info/reason>
  522  ERR_WHOSYNTAX  Bahamut
  523  ERR_WHOLIMEXCEED  Bahamut
  525  ERR_REMOTEPFX  CAPAB USERCMDPFX  <nickname> :<reason>  Proposed.
  526  ERR_PFXUNROUTABLE  CAPAB USERCMDPFX  <nickname> :<reason>  Proposed.
  550  ERR_BADHOSTMASK  QuakeNet
  551  ERR_HOSTUNAVAIL  QuakeNet
  552  ERR_USINGSLINE  QuakeNet
  600  RPL_LOGON  Bahamut, Unreal
  601  RPL_LOGOFF  Bahamut, Unreal
  602  RPL_WATCHOFF  Bahamut, Unreal
  603  RPL_WATCHSTAT  Bahamut, Unreal
  604  RPL_NOWON  Bahamut, Unreal
  605  RPL_NOWOFF  Bahamut, Unreal
  606  RPL_WATCHLIST  Bahamut, Unreal
  607  RPL_ENDOFWATCHLIST  Bahamut, Unreal
  608  RPL_WATCHCLEAR  Ultimate
  611  RPL_ISLOCOP  Ultimate
  612  RPL_ISNOTOPER  Ultimate
  613  RPL_ENDOFISOPER  Ultimate
  618  RPL_DCCLIST
  624  RPL_OMOTDSTART  Ultimate    
  625  RPL_OMOTD  Ultimate
  626  RPL_ENDOFO Ultimate
  630  RPL_SETTINGS  Ultimate
  631  RPL_ENDOFSETTINGS  Ultimate
  660  RPL_TRACEROUTE_HOP  KineIRCd  <target> <hop#> [<address> [<hostname> | '*'] <usec_ping>]  Returned from the TRACEROUTE IRC-Op command when tracerouting a host
  661  RPL_TRACEROUTE_START  KineIRCd  <target> <target_FQDN> <target_address> <max_hops>  Start of an RPL_TRACEROUTE_HOP list
  662  RPL_MODECHANGEWARN  KineIRCd  ['+' | '-']<mode_char> :<warning>  Plain text warning to the user about turning on or off a user mode. If no '+' or '-' prefix is used for the mode char, '+' is presumed.
  663  RPL_CHANREDIR  KineIRCd  <old_chan> <new_chan> :<info>  Used to notify the client upon JOIN that they are joining a different channel than expected because the IRC Daemon has been set up to map the channel they attempted to join to the channel they eventually will join.
  664  RPL_SERVMODEIS  KineIRCd  <server> <modes> <parameters>..  Reply to MODE <servername>. KineIRCd supports server modes to simplify configuration of servers; Similar to RPL_CHANNELMODEIS
  665  RPL_OTHERUMODEIS  KineIRCd  <nickname> <modes>  Reply to MODE <nickname> to return the user-modes of another user to help troubleshoot connections, etc. Similar to RPL_UMODEIS, however including the target
  666  RPL_ENDOF_GENERIC  KineIRCd  <command> [<parameter> ...] :<info>  Generic response for new lists to save numerics.
  670  RPL_WHOWASDETAILS  KineIRCd  <nick> <type> :<information>  Returned by WHOWAS to return extended information (if available). The type field is a number indication what kind of information.
  671  RPL_WHOISSECURE  KineIRCd  <nick> <type> [:<info>]  Reply to WHOIS command - Returned if the target is connected securely, eg. type may be TLSv1, or SSLv2 etc. If the type is unknown, a '*' may be used.
  672  RPL_UNKNOWNMODES  Ithildin  <modes> :<info>  Returns a full list of modes that are unknown when a client issues a MODE command (rather than one numeric per mode)
  673  RPL_CANNOTSETMODES  Ithildin  <modes> :<info>  Returns a full list of modes that cannot be set when a client issues a MODE command
  678  RPL_LUSERSTAFF  KineIRCd  <staff_online_count> :<info>  Reply to LUSERS command - Number of network staff (or 'helpers') online (differs from Local/Global operators). Similar format to RPL_LUSEROP
  679  RPL_TIMEONSERVERIS  KineIRCd  <seconds> [<nanoseconds> | '0'] <timezone> <flags> :<info>  Optionally sent upon connection, and/or sent as a reply to the TIME command. This returns the time on the server in a uniform manner. The seconds (and optionally nanoseconds) is the time since the UNIX Epoch, and is used since many existing timestamps in the IRC-2 protocol are done this way (i.e. ban lists). The timezone is hours and minutes each of Greenwich ('[+/-]HHMM'). Since all timestamps sent from the server are in a similar format, this numeric is designed to give clients the ability to provide accurate timestamps to their users.
  682  RPL_NETWORKS  KineIRCd  <name> <through_name> <hops> :<info>  A reply to the NETWORKS command when requesting a list of known networks (within the IIRC domain).
  687  RPL_YOURLANGUAGEIS  KineIRCd  <code(s)> :<info>  Reply to the LANGUAGE command, informing the client of the language(s) it has set
  688  RPL_LANGUAGE  KineIRCd  <code> <revision> <maintainer> <flags> * :<info>  A language reply to LANGUAGE when requesting a list of known languages
  689  RPL_WHOISSTAFF  KineIRCd  :<info>  The user is a staff member. The information may explain the user's job role, or simply state that they are a part of the network staff. Staff members are not IRC operators, but rather people who have special access in association with network services. KineIRCd uses this numeric instead of the existing numerics due to the overwhelming number of conflicts.
  690  RPL_WHOISLANGUAGE  KineIRCd  <nick> <language codes>  Reply to WHOIS command - A list of languages someone can speak. The language codes are comma delimitered.
  702  RPL_MODLIST  RatBox  <?> 0x<?> <?> <?>  Output from the MODLIST command
  703  RPL_ENDOFMODLIST  RatBox  :<text>  Terminates MODLIST output
  704  RPL_HELPSTART  RatBox  <command> :<text>  Start of HELP command output
  705  RPL_HELPTXT  RatBox  <command> :<text>  Output from HELP command
  706  RPL_ENDOFHELP  RatBox  <command> :<text>  End of HELP command output
  708  RPL_ETRACEFULL  RatBox  <?> <?> <?> <?> <?> <?> <?> :<?>  Output from 'extended' trace  
  709  RPL_ETRACE  RatBox  <?> <?> <?> <?> <?> <?> :<?>  Output from 'extended' trace  
  710  RPL_KNOCK  RatBox  <channel> <nick>!<user>@<host> :<text>  Message delivered using KNOCK command  
  711  RPL_KNOCKDLVR  RatBox  <channel> :<text>  Message returned from using KNOCK command  
  712  ERR_TOOMANYKNOCK  RatBox  <channel> :<text>  Message returned when too many KNOCKs for a channel have been sent by a user  
  713  ERR_CHANOPEN  RatBox  <channel> :<text>  Message returned from KNOCK when the channel can be freely joined by the user  
  714  ERR_KNOCKONCHAN  RatBox  <channel> :<text>  Message returned from KNOCK when the user has used KNOCK on a channel they have already joined  
  715  ERR_KNOCKDISABLED  RatBox  :<text>  Returned from KNOCK when the command has been disabled
  716  RPL_TARGUMODEG  RatBox  <nick> :<info>  Sent to indicate the given target is set +g (server-side ignore)  
  717  RPL_TARGNOTIFY  RatBox  <nick> :<info>  Sent following a PRIVMSG/NOTICE to indicate the target has been notified of an attempt to talk to them while they are set +g  
  718  RPL_UMODEGMSG  RatBox  <nick> <user>@<host> :<info>  Sent to a user who is +g to inform them that someone has attempted to talk to them (via PRIVMSG/NOTICE), and that they will need to be accepted (via the ACCEPT command) before being able to talk to them  
  720  RPL_OMOTDSTART  RatBox  :<text>  IRC Operator MOTD header, sent upon OPER command  
  721  RPL_OMOTD  RatBox  :<text>  IRC Operator MOTD text (repeated, usually)  
  722  RPL_ENDOFOMOTD  RatBox  :<text>  IRC operator MOTD footer  
  723  ERR_NOPRIVS  RatBox  <command> :<text>  Returned from an oper command when the IRC operator does not have the relevant operator privileges.  
  724  RPL_TESTMARK  RatBox  <nick>!<user>@<host> <?> <?> :<text>  Reply from an oper command reporting how many users match a given user@host mask  
  725  RPL_TESTLINE  RatBox  <?> <?> <?> :<?>  Reply from an oper command reporting relevant I/K lines that will match a given user@host  
  726  RPL_NOTESTLINE  RatBox  <?> :<text>  Reply from oper command reporting no I/K lines match the given user@host  
  771  RPL_XINFO  Ithildin   Used to send 'eXtended info' to the client, a replacement for the STATS command to send a large variety of data and minimise numeric pollution.  
  773  RPL_XINFOSTART  Ithildin   Start of an RPL_XINFO list  
  774  RPL_XINFOEND  Ithildin   Termination of an RPL_XINFO list  
  972  ERR_CANNOTDOCOMMAND  Unreal   Works similarly to all of KineIRCd's CANNOT* numerics. This one indicates that a command could not be performed for an arbitrary reason. For example, a halfop trying to kick an op.  
  973  ERR_CANNOTCHANGEUMODE  KineIRCd  <mode_char> :<reason>  Reply to MODE when a user cannot change a user mode  
  974  ERR_CANNOTCHANGECHANMODE  KineIRCd  <mode_char> :<reason>  Reply to MODE when a user cannot change a channel mode  
  975  ERR_CANNOTCHANGESERVERMODE  KineIRCd  <mode_char> :<reason>  Reply to MODE when a user cannot change a server mode
  976  ERR_CANNOTSENDTONICK  KineIRCd  <nick> :<reason>  Returned from NOTICE, PRIVMSG or other commands to notify the user that they cannot send a message to a particular client. Similar to ERR_CANNOTSENDTOCHAN. KineIRCd uses this in conjunction with user-mode +R to allow users to block people who are not identified to services (spam avoidance)  
  977  ERR_UNKNOWNSERVERMODE  KineIRCd  <modechar> :<info>  Returned by MODE to inform the client they used an unknown server mode character.  
  979  ERR_SERVERMODELOCK  KineIRCd  <target> :<info>  Returned by MODE to inform the client the server has been set mode +L by an administrator to stop server modes being changed  
  980  ERR_BADCHARENCODING  KineIRCd  <command> <charset> :<info>  Returned by any command which may have had the given data modified because one or more glyphs were incorrectly encoded in the current charset (given). Such a use would be where an invalid UTF-8 sequence was given which may be considered insecure, or defines a character which is invalid within that context. For safety reasons, the invalid character is not returned to the client.  
  981  ERR_TOOMANYLANGUAGES  KineIRCd  <max_langs> :<info>  Returned by the LANGUAGE command to tell the client they cannot set as many languages as they have requested. To assist the client, the maximum languages which can be set at one time is given, and the language settings are not changed.  
  982  ERR_NOLANGUAGE  KineIRCd  <language_code> :<info>  Returned by the LANGUAGE command to tell the client it has specified an unknown language code.  
  983  ERR_TEXTTOOSHORT  KineIRCd  <command> :<info>  Returned by any command requiring text (such as a message or a reason), which was not long enough to be considered valid. This was created initially to combat '/wallops foo' abuse, but is also used by DIE and RESTART commands to attempt to encourage meaningful reasons.  
  999  ERR_NUMERIC_ERR  Bahamut  
  }

  FCommandHandlers.OnBeforeCommandHandler := DoBeforeCmd;
end;

{ Command handlers }

procedure TIdIRC.DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
var
  LTmp: String;
begin
  AData := IRCUnquote(AData);
  // ":nickname!user@host"
  if TextStartsWith(AData, ':') then begin
    LTmp := Fetch(AData, ' ');
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

procedure TIdIRC.DoReplyUnknownCommand(AContext: TIdContext; ALine: string);
var
  ACmdCode: Integer;
begin
  ACmdCode := IndyStrToInt(Fetch(ALine, ' '), -1);
  //
  case ACmdCode of
    6,
    7:
      begin
        //MAP
      end;
    5,
    400..424,
    437..502:
      begin
        if Assigned(FOnServerError) then begin
          OnServerError(AContext, ACmdCode, ALine);
        end;
      end;
    431..432,
    436:
      begin
        if Assigned(FOnNickError) then begin
          OnNicknameError(AContext, ACmdCode);
        end;
      end;
  end;
end;

procedure TIdIRC.CommandPRIVMSG(ASender: TIdCommand);
var
  LTmp, LTarget, LData, LCTCP: String;
  I: Integer;
  CTCPList: TStringList;
begin
  LTmp := ASender.UnparsedParams;
  LTarget := FetchIRCParam(LTmp);
  LData := FetchIRCParam(LTmp);

  CTCPList := TStringList.Create;
  try
    ExtractCTCPs(LData, CTCPList);
    if CTCPList.Count = 0 then begin
      if Assigned(FOnPrivMessage) then begin
        OnPrivateMessage(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
      end;
    end else
    begin
      if (LData <> '') and Assigned(FOnPrivMessage) then begin
        OnPrivateMessage(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
      end;
      for I := 0 to CTCPList.Count - 1 do begin
        LData := CTCPList[I];
        LCTCP := Fetch(LData, ' ');
        case PosInStrArray(LCTCP, IdIRCCTCP) of
          0: { ACTION }
            begin
              {
              if Assigned(FOnAction) then begin
                FOnAction(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
              end;
              }
              if Assigned(FOnCTCPQry) then begin
                FOnCTCPQry(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
              // RLebeau: CTCP ACTION does not send a reply back
              //CTCPReply(FSenderNick, 'ERRMSG', LCTCP +' ' + LData + ' unknown query'); {do not localize}
            end;
          1: { SOUND }
            begin
              {
              if Assigned(FOnSound) then begin
                FOnSound(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
              end;
              }
              if Assigned(FOnCTCPQry) then begin
                FOnCTCPQry(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
              CTCPReply(FSenderNick, 'ERRMSG', LCTCP +' ' + LData + ' unknown query'); {do not localize}
            end;
          2: { PING }
            begin
              {
              LTmp := '';
              if Assigned(FOnPing) then begin
                FOnPing(ASender.Context, LTmp);
              end;
              if LTmp = '' then begin
                LTmp := DateTimeToStr(Now);
              end;
              CTCPReply(FSenderNick, LCTCP, ':' + LTmp);
              }
              if Assigned(FOnCTCPQry) then begin
                FOnCTCPQry(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
              // AWinkelsdorf 3/10/2010 ToDo: CTCP Ping might need a CTIME result but
              // many clients do not send the required CTIME with the Ping Query...
              CTCPReply(FSenderNick, LCTCP, DateTimeToStr(Now)); {do not localize}
            end;
          3: { FINGER }
            begin
              CTCPReply(FSenderNick, LCTCP, Replies.Finger); {do not localize}
            end;
          4: { USERINFO }
            begin
              CTCPReply(FSenderNick, LCTCP, Replies.UserInfo); {do not localize}
            end;
          5: { VERSION }
            begin
              CTCPReply(FSenderNick, LCTCP, Replies.Version); {do not localize}
            end;
          6: { CLIENTINFO }
            begin
              // TODO: add OnClientInfoQuery event to handle per-command queries
              CTCPReply(FSenderNick, LCTCP, Replies.ClientInfo); {do not localize}
            end;
          7: { TIME }
            begin
              CTCPReply(FSenderNick, LCTCP, DateTimeToStr(Now));
            end;
          8: { ERROR }
            begin
              CTCPReply(FSenderNick, LCTCP, LData + ' No Error'); {do not localize}
            end;
          9: { DCC }
            begin
              ParseDCC(ASender.Context, LData);
            end;
          10: { SED }
            begin
              //ParseSED(AContext, LData);
              if Assigned(FOnCTCPQry) then begin
                FOnCTCPQry(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
              CTCPReply(FSenderNick, LCTCP, LData + ' unknown query'); {do not localize}
            end;
          11: { ERRMSG }
            begin
              CTCPReply(FSenderNick, LCTCP, LData + ' No Error'); {do not localize}
            end;
          else
            begin
              if Assigned(FOnCTCPQry) then begin
                FOnCTCPQry(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
              CTCPReply(FSenderNick, LCTCP, LData + ' unknown query'); {do not localize}
            end;
        end;
      end;
    end;
  finally
    CTCPList.Free;
  end;
end;

procedure TIdIRC.CommandNOTICE(ASender: TIdCommand);
var
  LTmp, LTarget, LData, LCTCP: String;
  I: Integer;
  CTCPList: TStringList;
begin
  LTmp := ASender.UnparsedParams;
  LTarget := FetchIRCParam(LTmp);
  LData := FetchIRCParam(LTmp);

  CTCPList := TStringList.Create;
  try
    ExtractCTCPs(LData, CTCPList);
    if CTCPList.Count = 0 then begin
      if Assigned(FOnNotice) then begin
        OnNotice(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
      end;
    end else
    begin
      if (LData <> '') and Assigned(FOnNotice) then begin
        OnNotice(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
      end;
      for I := 0 to CTCPList.Count - 1 do begin
        LData := CTCPList[I];
        LCTCP := Fetch(LData, ' ');
        case PosInStrArray(LCTCP, IdIRCCTCP) of
          0: { ACTION }
            begin
              {
              if Assigned(FOnAction) then begin
                FOnAction(ASender.Context, FSenderNick, FSenderHost, LTarget, LData);
              end;
              }
              if Assigned(FOnCTCPRep) then begin
                FOnCTCPRep(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
            end;
          9: { DCC }
            begin
              ParseDCC(ASender.Context, LData);
            end;
          10: { SED }
            begin
              //ParseSED(AContext, LData);
              if Assigned(FOnCTCPRep) then begin
                FOnCTCPRep(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
              end;
            end;
        else
          if Assigned(FOnCTCPRep) then begin
            FOnCTCPRep(ASender.Context, FSenderNick, FSenderHost, LTarget, LCTCP, LData);
          end;
        end;
      end;
    end;
  finally
    CTCPList.Free;
  end;
end;

procedure TIdIRC.CommandJOIN(ASender: TIdCommand);
begin
  if Assigned(FOnJoin) then begin
    OnJoin(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandPART(ASender: TIdCommand);
var
  LChannel, LMsg: string;
begin
  if Assigned(FOnPart) then begin
    if ASender.Params.Count > 0 then begin
      LChannel := ASender.Params[0];
    end;
    if ASender.Params.Count > 1 then begin
      LMsg := ASender.Params[1];
    end;
    OnPart(ASender.Context, FSenderNick, FSenderHost, LChannel, LMsg);
  end;
end;

procedure TIdIRC.CommandKICK(ASender: TIdCommand);
var
  LChannel, LTarget, LReason: string;
begin
  if Assigned(FOnKick) then begin
    if ASender.Params.Count > 0 then begin
      LChannel := ASender.Params[0];
    end;
    if ASender.Params.Count > 1 then begin
      LTarget := ASender.Params[1];
    end;
    if ASender.Params.Count > 2 then begin
      LReason := ASender.Params[2];
    end;
    OnKick(ASender.Context, FSenderNick, FSenderHost, LChannel, LTarget, LReason);
  end;
end;

procedure TIdIRC.CommandMODE(ASender: TIdCommand);
var
  LTmp, LParam: String;
begin
  LTmp := ASender.UnparsedParams;
  LParam := FetchIRCParam(LTmp);
  if IsChannel(LParam) then begin
    if Assigned(FOnChanMode) then begin
      OnChannelMode(ASender.Context, FSenderNick, FSenderHost, LParam, LTmp, '');
    end;
  end
  else if Assigned(FOnUserMode) then begin
    OnUserMode(ASender.Context, FSenderNick, FSenderHost, LTmp);
  end;
end;

procedure TIdIRC.CommandNICK(ASender: TIdCommand);
begin
  if Assigned(FOnNickChange) then begin
    OnNicknameChange(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandQUIT(ASender: TIdCommand);
var
  LReason: string;
begin
  if Assigned(FOnQuit) then begin
    if ASender.Params.Count > 0 then begin
      LReason := ASender.Params[0];
    end;
    OnQuit(ASender.Context, FSenderNick, FSenderHost, LReason);
  end;
end;

procedure TIdIRC.CommandSQUIT(ASender: TIdCommand);
var
  LServer, LComment: string;
begin
  if Assigned(FOnSvrQuit) then begin
    if ASender.Params.Count > 0 then begin
      LServer := ASender.Params[0];
    end;
    if ASender.Params.Count > 1 then begin
      LComment := ASender.Params[1];
    end;
    OnServerQuit(ASender.Context, FSenderNick, FSenderHost, LServer, LComment);
  end;
end;

procedure TIdIRC.CommandINVITE(ASender: TIdCommand);
begin
  if Assigned(FOnInvite) then begin
    OnInvite(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRC.CommandKILL(ASender: TIdCommand);
var
  LTarget, LReason: string;
begin
  if Assigned(FOnKill) then begin
    if ASender.Params.Count > 0 then begin
      LTarget := ASender.Params[0];
    end;
    if ASender.Params.Count > 1 then begin
      LReason := ASender.Params[1];
    end;
    OnKill(ASender.Context, FSenderNick, FSenderHost, LTarget, LReason);
  end;
end;

procedure TIdIRC.CommandPING(ASender: TIdCommand);
var
  LServer1: String;
begin
  if ASender.Params.Count > 0 then begin
    LServer1 := ASender.Params[0];
  end;
  Pong(LServer1);
  if Assigned(FOnPingPong) then begin
    OnPingPong(ASender.Context);
  end;
end;

procedure TIdIRC.CommandWALLOPS(ASender: TIdCommand);
var
  LTmp: string;
begin
  if Assigned(FOnWallops) then begin
    LTmp := ASender.UnparsedParams;
    OnWallops(ASender.Context, FSenderNick, FSenderHost, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandTOPIC(ASender: TIdCommand);
var
  LChannel, LTopic: String;
begin
  if Assigned(FOnTopic) then
  begin
    if ASender.Params.Count > 0 then begin
      LChannel := ASender.Params[0];
    end;
    if (ASender.CommandHandler.Command <> '331') and (ASender.Params.Count > 1) then begin {do not localize}
      LTopic := ASender.Params[1];
    end else begin
      LTopic := '';
    end;
    OnTopic(ASender.Context, FSenderNick, FSenderHost, LChannel, LTopic);
  end;
end;

procedure TIdIRC.CommandWELCOME(ASender: TIdCommand);
var
  LTmp: string;
begin
  if Assigned(FOnSWelcome) then begin
    LTmp := ASender.UnparsedParams;
    OnServerWelcome(ASender.Context, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandERROR(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnServerError) then begin
    LTmp := ASender.UnparsedParams;
    OnServerError(ASender.Context, 0, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandYOURHOST(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnYourHost) then begin
    LTmp := ASender.UnparsedParams;
    OnYourHost(ASender.Context, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandCREATED(ASender: TIdCommand);
var
  LTmp: string;
begin
  if Assigned(FOnSCreated) then begin
    LTmp := ASender.UnparsedParams;
    OnServerCreated(ASender.Context, FetchIRCParam(LTmp));
  end;
end;

procedure TIdIRC.CommandMYINFO(ASender: TIdCommand);
var
  LTmp, LServer, LVersion, LUserModes, LChanModes: String;
begin
  if Assigned(FOnMyInfo) then begin
    LTmp := ASender.UnparsedParams;
    LServer := FetchIRCParam(LTmp);
    LVersion := FetchIRCParam(LTmp);
    LUserModes := FetchIRCParam(LTmp);
    LChanModes := FetchIRCParam(LTmp);
    // TODO: <channel_modes_with_params> <user_modes_with_params> <server_modes> <server_modes_with_params>
    OnMyInfo(ASender.Context, LServer, LVersion, LUserModes, LChanModes, LTmp);
  end;
end;

procedure TIdIRC.DoBounce(ASender: TIdCommand; ALegacy: Boolean);
var
  LHost, LPort, LInfo: string;
begin
  if Assigned(FOnBounce) then begin
    if ALegacy then begin
      LInfo := ASender.Params[0];
      LHost := FetchIRCParam(LInfo);
      LPort := FetchIRCParam(LInfo);
    end else
    begin
      LHost := ASender.Params[0];
      LPort := ASender.Params[1];
      if ASender.Params.Count > 2 then begin
        LInfo := ASender.Params[2];
      end;
    end;
    // TODO: reconnect automatically
    OnBounce(ASender.Context, LHost, IndyStrToInt(LPort, 0), LInfo);
  end;
end;

procedure TIdIRC.CommandISUPPORT(ASender: TIdCommand);
var
  LParams: TStringList;
  I: Integer;
begin
  if ASender.Params.Count = 1 then begin
    DoBounce(ASender, True); // legacy, deprecated
    Exit;
  end;
  if Assigned(FOnISupport) then
  begin
    LParams := TStringList.Create;
    try
      for I := 1 to ASender.Params.Count-1 do // skip nickname
      begin
        LParams.Add(ASender.Params[I]);
      end;
      OnISupport(ASender.Context, LParams);
    finally
      LParams.Free;
    end;
  end;
end;

procedure TIdIRC.CommandBOUNCE(ASender: TIdCommand);
begin
  DoBounce(ASender, False);
end;

procedure TIdIRC.CommandAWAY(ASender: TIdCommand);
var
  LCmd: Integer;
begin
  LCmd := IndyStrToInt(ASender.CommandHandler.Command, 0);
  case LCmd of
    301:
    begin
      if Assigned(FOnAway) then begin
        OnAway(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], True);
      end;
    end;
    305, 306:
    begin
      FUserAway := (LCmd = 306);
      if Assigned(FOnAway) then begin
        OnAway(ASender.Context, GetUsedNickname, '', ASender.Params[0], FUserAway);
      end;
    end;
  end;
end;

procedure TIdIRC.CommandUSERHOST(ASender: TIdCommand);
begin
  if Assigned(FOnUserInfo) then begin
    OnUserInfoReceived(ASender.Context, ASender.UnparsedParams);
  end;
end;

procedure TIdIRC.CommandISON(ASender: TIdCommand);
begin
  if Assigned(FOnIsOnIRC) then begin
    OnIsOnIRC(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandWHOIS(ASender: TIdCommand);
begin
  if not Assigned(FWhoIs) then begin
    FWhoIs := TStringList.Create;
  end;
  FWhoIs.Add(ASender.Params[0]);
end;

procedure TIdIRC.CommandENDOFWHOIS(ASender: TIdCommand);
begin
  CommandWHOIS(ASender);
  if Assigned(FOnWhoIs) then begin
    OnWhoIs(ASender.Context, FWhoIs);
  end;
  FWhoIs.Clear;
end;

procedure TIdIRC.CommandWHOWAS(ASender: TIdCommand);
begin
  if not Assigned(FWhoWas) then begin
    FWhoWas := TStringList.Create;
  end;
  FWhoWas.Add(ASender.Params[0]);
end;

procedure TIdIRC.CommandENDOFWHOWAS(ASender: TIdCommand);
begin
  CommandWHOWAS(ASender);
  if Assigned(FOnWhoWas) then begin
    OnWhoWas(ASender.Context, FWhoWas);
  end;
  FWhoWas.Clear;
end;

procedure TIdIRC.CommandLISTSTART(ASender: TIdCommand);
begin
  if not Assigned(FSvrList) then begin
    FSvrList := TStringList.Create;
  end else begin
    FSvrList.Clear;
  end;
end;

procedure TIdIRC.CommandLIST(ASender: TIdCommand);
begin
  if not Assigned(FSvrList) then begin
    FSvrList := TStringList.Create;
  end;
  FSvrList.Add(ASender.Params[0] + ' ' + ASender.Params[1] + ' ' + ASender.Params[2]); {do not localize}
end;

procedure TIdIRC.CommandLISTEND(ASender: TIdCommand);
begin
  if not Assigned(FSvrList) then begin
    FSvrList := TStringList.Create;
  end;
  if Assigned(FOnSvrList) then begin
    OnServerListReceived(ASender.Context, FSvrList);
  end;
  FSvrList.Clear;
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

procedure TIdIRC.CommandINVITELIST(ASender: TIdCommand);
begin
  if not Assigned(FInvites) then begin
    FInvites := TStringList.Create;
  end;
  // TODO: use a collection instead
  FInvites.Add(ASender.Params[0] + ' ' + ASender.Params[1]); {do not localize}
end;

procedure TIdIRC.CommandENDOFINVITELIST(ASender: TIdCommand);
begin
  if not Assigned(FInvites) then begin
    FInvites := TStringList.Create;
  end;
  FInvites.Add(ASender.Params[0]);
  if Assigned(FOnINVList) then begin
    OnInvitationListReceived(ASender.Context, FSenderNick, FInvites);
  end;
  FInvites.Clear;
end;

procedure TIdIRC.CommandEXCEPTLIST(ASender: TIdCommand);
begin
  if not Assigned(FExcepts) then begin
    FExcepts := TStringList.Create;
  end;
  // TODO: use a collection instead
  FExcepts.Add(ASender.Params[0] + ' ' + ASender.Params[1]); {do not localize}
end;

procedure TIdIRC.CommandENDOFEXCEPTLIST(ASender: TIdCommand);
begin
  if not Assigned(FExcepts) then begin
    FExcepts := TStringList.Create;
  end;
  FExcepts.Add(ASender.Params[0]);
  if Assigned(FOnEXCList) then begin
    OnExceptionListReceived(ASender.Context, FSenderNick, FExcepts);
  end;
  FExcepts.Clear;
end;

procedure TIdIRC.CommandWHOREPLY(ASender: TIdCommand);
begin
  if not Assigned(FWho) then begin
    FWho := TStringList.Create;
  end;
  FWho.Add(''); // TODO
end;

procedure TIdIRC.CommandENDOFWHO(ASender: TIdCommand);
begin
  if not Assigned(FWho) then begin
    FWho := TStringList.Create;
  end;
  FWho.Add(ASender.Params[0]);
  if Assigned(FOnWho) then begin
    OnWho(ASender.Context, FWho);
  end;
  FWho.Clear;
end;

procedure TIdIRC.CommandNAMEREPLY(ASender: TIdCommand);
var
  LNames: string;
begin
  if not Assigned(FNames) then begin
    FNames := TStringList.Create;
  end;
  // AWinkelsdorf 3/10/2010 Rewrote logic to split Names into single Lines of FNames
  // RLebeau 1/27/2016: Rewrote to use a Fetch() loop instead of a temp TStringList
  if ASender.Params.Count >= 4 then begin // Names are in [3]
    LNames := ASender.Params[3];
    while LNames <> '' do begin
      FNames.Add(Fetch(LNames));
    end;
  end else begin
    FNames.Add(ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandENDOFNAMES(ASender: TIdCommand);
var
  LChannel: string;
begin
  if not Assigned(FNames) then begin
    FNames := TStringList.Create;
  end;
  LChannel := '';
  if ASender.Params.Count > 0 then begin
    LChannel := ASender.Params[1];
  end;
  if Assigned(FOnNickList) then begin
    OnNicknamesListReceived(ASender.Context, LChannel, FNames);
  end;
  FNames.Clear;
end;

procedure TIdIRC.CommandLINKS(ASender: TIdCommand);
var
  LHopCnt, LInfo: String;
begin
  if not Assigned(FLinks) then begin
    FLinks := TStringList.Create;
  end;
  LInfo := ASender.Params[2];
  LHopCnt := Fetch(LInfo);
  // TODO: use a collection instead
  FLinks.Add(ASender.Params[0] + ' ' + ASender.Params[1] + ' ' + LHopCnt + ' ' + LInfo); {do not localize}
end;

procedure TIdIRC.CommandENDOFLINKS(ASender: TIdCommand);
begin
  if not Assigned(FLinks) then begin
    FLinks := TStringList.Create;
  end;
  FLinks.Add(ASender.Params[0]);
  if Assigned(FOnKnownSvrs) then begin
    OnKnownServersListReceived(ASender.Context, FLinks);
  end;
  FLinks.Clear;
end;

procedure TIdIRC.CommandBANLIST(ASender: TIdCommand);
begin
  if not Assigned(FBans) then begin
    FBans := TStringList.Create;
  end;
  // TODO: use a collection instead
  FBans.Add(ASender.Params[0] + ' ' + ASender.Params[1]); {do not localize}
end;

procedure TIdIRC.CommandENDOFBANLIST(ASender: TIdCommand);
begin
  if not Assigned(FBans) then begin
    FBans := TStringList.Create;
  end;
  FBans.Add(ASender.Params[0]);
  if Assigned(FOnBanList) then begin
    OnBanListReceived(ASender.Context, FSenderNick, FBans);
  end;
  FBans.Clear;
end;

procedure TIdIRC.CommandINFO(ASender: TIdCommand);
begin
  // TODO
  {
  if not Assigned(FInfo) then begin
    FInfo := TStringList.Create;
  end;
  FInfo.Add(ASender.Params[0]);
  }
end;

procedure TIdIRC.CommandENDOFINFO(ASender: TIdCommand);
begin
  // TODO
  {
  if not Assigned(FInfo) then begin
    FInfo := TStringList.Create;
  end;
  }
  if Assigned(FOnUserInfo) then begin
    OnUserInfoReceived(ASender.Context, ASender.UnparsedParams);
    //OnUserInfoReceived(ASender.Context, FInfo);
  end;
  //FInfo.Clear;
end;

procedure TIdIRC.CommandMOTD(ASender: TIdCommand);
begin
  if not Assigned(FMotd) then begin
    FMotd := TStringList.Create;
  end;
  FMotd.Add(ASender.Params[0]);
end;

procedure TIdIRC.CommandENDOFMOTD(ASender: TIdCommand);
begin
  if not Assigned(FMotd) then begin
    FMotd := TStringList.Create;
  end;
  if Assigned(FOnMOTD) then begin
    OnMOTD(ASender.Context, FMotd);
  end;
  FMotd.Clear;
end;

procedure TIdIRC.CommandREHASHING(ASender: TIdCommand);
begin
  if Assigned(FOnRehash) then begin
    OnRehash(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandUSERSSTART(ASender: TIdCommand);
begin
  if not Assigned(FUsers) then begin
    FUsers := TStringList.Create;
  end else begin
    FUsers.Clear;
  end;
end;

procedure TIdIRC.CommandUSERS(ASender: TIdCommand);
begin
  if ASender.CommandHandler.Command = '393' then {do not localize}
  begin
    if not Assigned(FUsers) then begin
      FUsers := TStringList.Create;
    end;
    // TODO: use a collection instead
    FUsers.Add(ASender.Params[0] + ' ' + ASender.Params[1] + ' ' + ASender.Params[2]); {do not localize}
  end;
end;

procedure TIdIRC.CommandENDOFUSERS(ASender: TIdCommand);
begin
  if not Assigned(FUsers) then begin
    FUsers := TStringList.Create;
  end;
  if Assigned(FOnSvrUsers) then begin
    OnServerUsersListReceived(ASender.Context, FUsers);
  end;
  FUsers.Clear;
end;

procedure TIdIRC.CommandENDOFSTATS(ASender: TIdCommand);
begin
  if Assigned(FOnSvrStats) then begin
    OnServerStatsReceived(ASender.Context, nil); // TODO
  end;
end;

procedure TIdIRC.CommandSERVLIST(ASender: TIdCommand);
begin
  // <name> <server> <mask> <type> <hopcount> <info>
end;

procedure TIdIRC.CommandSERVLISTEND(ASender: TIdCommand);
begin
  // <mask> <type> :<info>
end;

procedure TIdIRC.CommandTIME(ASender: TIdCommand);
var
  LServer, LTimeString: String;
begin
  if Assigned(FOnSvrTime) then begin
    LServer := ASender.Params[0];
    case ASender.Params.Count of
      2: begin // "<server> :<time string>"
        LTimeString := ASender.Params[1];
        end;
      4: begin // "<server> <timestamp> <offset> :<time string>" or "<server> <timezone name> <microseconds> :<time string>"
        LTimeString := IndyFormat('%s %s %s', [ASender.Params[1], ASender.Params[2], ASender.Params[3]]); {do not localize}
        end;
      7: begin // "<server> <year> <month> <day> <hour> <minute> <second>"
        LTimeString := IndyFormat('%s %s %s %s %s %s', {do not localize}
          [ASender.Params[1], ASender.Params[2], ASender.Params[3],
          ASender.Params[4], ASender.Params[5], ASender.Params[6]]);
        end;
    end;
    OnServerTime(ASender.Context, LServer, LTimeString);
  end;
end;

procedure TIdIRC.CommandSERVICE(ASender: TIdCommand);
begin
  if Assigned(FOnService) then begin
    OnService(ASender.Context);
  end;
end;

procedure TIdIRC.CommandVERSION(ASender: TIdCommand);
begin
  if Assigned(FOnSvrVersion) then begin
    OnServerVersion(ASender.Context, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRC.CommandCHANMODE(ASender: TIdCommand);
begin
  if Assigned(FOnChanMode) then begin
    OnChannelMode(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRC.CommandOPER(ASender: TIdCommand);
begin
  if Assigned(FOnOp) then begin
    OnOp(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandNICKINUSE(ASender: TIdCommand);
begin
  if ASender.CommandHandler.Command = '433' then {do not localize}
  begin
    if (Connected) and (FAltNickname <> '') then
    begin
      if not FAltNickUsed then begin
        // try only once using AltNickname (FAltNickUsed is cleared in .Connect)
        SetNickname(FAltNickname);
        FAltNickUsed := True;
      end
      else
      begin
        // already tried to use AltNickName...
        if Assigned(FOnNickError) then begin
          OnNicknameError(ASender.Context, IndyStrToInt(ASender.CommandHandler.Command));
        end;
      end;
    end;
  end;
end;

procedure TIdIRC.ParseDCC(AContext: TIdContext; const ADCC: String);
const
  IdIRCDCC: array[0..3] of String = ('SEND', 'CHAT', 'RESUME', 'ACCEPT');  {do not localize}
var
  LTmp, LType, LArg, LAddr, LPort, LSize: String;
begin
  LTmp := ADCC;
  LType := FetchIRCParam(LTmp);
  LArg := FetchIRCParam(LTmp);
  LAddr := FetchIRCParam(LTmp);
  LPort := FetchIRCParam(LTmp);
  LSize := FetchIRCParam(LTmp);
  //
  case PosInStrArray(LType, IdIRCDCC) of
    0: {SEND}
      begin
        if Assigned(FOnDCCSend) then begin
          FOnDCCSend(AContext, FSenderNick, LAddr, ExtractFileName(LArg), IndyStrToInt(LPort), IndyStrToInt64(LSize));
        end;
      end;
    1: {CHAT}
      begin
        if Assigned(FOnDCCChat) then begin
          FOnDCCChat(AContext, FSenderNick, LAddr, IndyStrToInt(LPort));
        end;
      end;
    2: {RESUME}
      begin
        if Assigned(FOnDCCResume) then begin
          FOnDCCResume(AContext, FSenderNick, LAddr, LArg, IndyStrToInt(LPort), IndyStrToInt64(LSize));
        end;
      end;
    3: {ACCEPT}
      begin
        if Assigned(FOnDCCAccept) then begin
          FOnDCCAccept(AContext, FSenderNick, LAddr, LArg, IndyStrToInt(LPort), IndyStrToInt64(LSize));
        end;
      end;
  end;
end;

function TIdIRC.GetUsedNickname: String;
begin
  if FAltNickUsed then
    Result := FAltNickname
  else
    Result := FNickname;
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
  Result := TextStartsWith(ANickname, '@');
end;

function TIdIRC.IsVoice(const ANickname: String): Boolean;
begin
  Result := TextEndsWith(ANickname, '+');
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
var
  LTmp: String;
begin
  LTmp := UpperCase(ACommand);
  if AParameters <> '' then begin
    LTmp := LTmp + ' ' + AParameters;
  end;
  Say(ATarget, XDelim+CTCPQuote(LTmp)+XDelim);  {do not localize}
end;

procedure TIdIRC.CTCPReply(const ATarget, ACTCP, AReply: String);
var
  LTmp: String;
begin
  LTmp := ACTCP;
  if AReply <> '' then begin
    LTmp := LTmp + ' ' + AReply;
  end;
  Notice(ATarget, XDelim+CTCPQuote(LTmp)+XDelim); {do not localize}
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

procedure TIdIRC.Kick(const AChannel, ANickname: String; const AReason: String = '');
begin
  if IsChannel(AChannel) then begin
    if AReason <> '' then begin
      Raw(IndyFormat('KICK %s %s :%s', [AChannel, ANickname, AReason]));  {do not localize}
    end else begin
      Raw(IndyFormat('KICK %s %s', [AChannel, ANickname]));  {do not localize}
    end;
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
    Raw(IndyFormat('AWAY :%s', [AMsg])); {do not localize}
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
  Raw(IndyFormat('SERVICE %s * %s %s 0 :%s',  {do not localize}
    [ANickname, ADistribution, AType, AInfo]));
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
    Raw(IndyFormat('LINKS %s %s', [ARemoteHost, AHostMask])); {do not localize}
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

procedure TIdIRC.RequestServerConnect(const ATargetHost: String; APort: Integer;
  const ARemoteHost: String = '');
begin
  if ARemoteHost <> '' then begin
    Raw(IndyFormat('CONNECT %s %d %s', [ATargetHost, APort, ARemoteHost])); {do not localize}
  end else begin
    Raw(IndyFormat('CONNECT %s %d', [ATargetHost, APort])); {do not localize}
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

procedure TIdIRC.ListNetworkServices(const AHostMask: String = ''; const AType: String = '');
begin
  if (AHostMask = '') and (AType = '') then begin
    Raw('SERVLIST');  {do not localize}
  end
  else if AType <> '' then begin
    Raw(IndyFormat('SERVLIST %s %s', [AHostMask, AType]));  {do not localize}
  end else begin
    Raw(IndyFormat('SERVLIST %s', [AHostMask]));  {do not localize}
  end;
end;

procedure TIdIRC.QueryService(const AServiceName, AMessage: String);
begin
  Raw(IndyFormat('SQUERY %s :%s', [AServiceName, AMessage]));  {do not localize}
end;

procedure TIdIRC.Who(const AMask: String; AOnlyAdmins: Boolean);
begin
  if (AMask = '') and (not AOnlyAdmins) then begin
    Raw('WHO'); {do not localize}
  end
  else if AOnlyAdmins then begin
    Raw(IndyFormat('WHO %s o', [AMask])); {do not localize}
  end else begin
    Raw(IndyFormat('WHO %s', [AMask])); {do not localize}
  end;
end;

procedure TIdIRC.WhoIs(const AMask: String; const ATarget: String = '');
begin
  if ATarget <> '' then begin
    Raw(IndyFormat('WHOIS %s %s', [ATarget, AMask])); {do not localize}
  end else begin
    Raw(IndyFormat('WHOIS %s', [AMask])); {do not localize}
  end;
end;

procedure TIdIRC.WhoWas(const ANickname: String; ACount: Integer = -1; const ATarget: String = '');
begin
  if (ATarget = '') and (ACount < 0) then begin
    Raw(IndyFormat('WHOWAS %s', [ANickname]));  {do not localize}
  end
  else if ATarget <> '' then begin
    Raw(IndyFormat('WHOWAS %s %d %s', [ANickname, ACount, ATarget]));  {do not localize}
  end
  else begin
    Raw(IndyFormat('WHOWAS %s %d', [ANickname, ACount])); {do not localize}
  end;
end;

procedure TIdIRC.Kill(const ANickname, AComment: String);
begin
  Raw(IndyFormat('KILL %s :%s', [ANickname, AComment])); {do not localize}
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
  Raw(IndyFormat('ERROR :%s', [AMessage]));  {do not localize}
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
  else if AChannel <> '' then
  begin
    if IsChannel(AChannel) then begin
      Raw(IndyFormat('SUMMON %s %s %s', [ANickname, ATarget, AChannel])); {do not localize}
    end;
  end else begin
    Raw(IndyFormat('SUMMON %s %s', [ANickname, ATarget]));  {do not localize}
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
  Raw(IndyFormat('WALLOPS :%s', [AMessage]));  {do not localize}
end;

procedure TIdIRC.GetUserInfo(const ANickname: String);
begin
  Raw(IndyFormat('USERHOST %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.GetUsersInfo(const ANicknames: array of string);
var
  I: Integer;
  S: string;
begin
  if Length(ANicknames) > 0 then
  begin
    for I := Low(ANicknames) to High(ANicknames) do begin
      S := S + ' ' + ANicknames[I]; {do not localize}
    end;
    Raw(IndyFormat('USERHOST%s', [S]));  {do not localize}
  end;
end;

procedure TIdIRC.IsOnIRC(const ANickname: String);
begin
  Raw(IndyFormat('ISON %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.IsOnIRC(const ANicknames: array of String);
var
  I: Integer;
  S: string;
begin
  if Length(ANicknames) > 0 then
  begin
    for I := Low(ANicknames) to High(ANicknames) do begin
      S := S + ' ' + ANicknames[I]; {do not localize}
    end;
    Raw(IndyFormat('ISON%s', [S]));  {do not localize}
  end;
end;

procedure TIdIRC.BecomeOp(const ANickname, APassword: String);
begin
  Raw(IndyFormat('OPER %s %s', [ANickname, APassword]));  {do not localize}
end;

procedure TIdIRC.SQuit(const AHost, AComment: String);
begin
  Raw(IndyFormat('SQUIT %s :%s', [AHost, AComment]));  {do not localize}
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


