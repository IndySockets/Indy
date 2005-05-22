{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log: }
{
//----------------------------------------------------------------------------//
  2003-11-Jul:
    Original author: Sergio Perry

  Based on TIRCClient component by Steve Williams (stevewilliams@kromestudios.com)
  ported to Indy by Daaron Dwyer (ddwyer@ncic.com)

  Matthew Elzer - bug fixes & modifications
//----------------------------------------------------------------------------//
}
unit IdIRC;

interface

uses
  Classes,
  IdAssignedNumbers, IdContext, IdCmdTCPClient, IdCommandHandlers, IdIOHandler,
  IdTStrings;

type
  TIdIRC = class;

//============================================================================//

  TIdIRCUserMode = (amAway, amInvisible, amWallops, amRestricted, amOperator,
    amLocalOperator, amReceiveServerNotices);
  TIdIRCUserModes = set of TIdIRCUserMode;
  TIdIRCStat = (stServerConnectionsList, stCommandUsageCount, stOperatorList,
    stUpTime);

//============================================================================//
  { Events }

  { -WELCOME- }
  TIdIRCServerWelcomeEvent = procedure(ASender: TIdContext;
    AWelcomeInfo: TIdStrings) of object;
  TIdIRCPingPongEvent = procedure(ASender: TIdContext) of object;
  { -MESSAGE- }
  TIdIRCPrivMessageEvent = procedure(ASender: TIdContext; const ANicknameFrom,
    AHost, ANicknameTo, AMessage: String) of object;
  { -NOTICE- }
  TIdIRCNoticeEvent = procedure(ASender: TIdContext; const ANicknameFrom,
    AHost, ANicknameTo, ANotice: String) of object;
  { -REHASH- }
  TIdIRCRehashEvent = procedure(ASender: TIdContext; ANickname, AHost: String) of object;
  { -SUMMON- }
  TIdIRCSummonEvent = procedure(ASender: TIdContext; ANickname, AHost: String) of object;
  { -WALLOPS- }
  TIdIRCWallopsEvent = procedure(ASender: TIdContext; const ANickname,
    AHost, AMessage: String) of object;
  { -ISON- }
  TIdIRCIsOnIRCEvent = procedure(ASender: TIdContext; ANickname, AHost: String) of object;
  { -AWAY- }
  TIdIRCAwayEvent = procedure(ASender: TIdContext; ANickname, AHost,
    AAwayMessage: String; UserAway: Boolean) of object;
  { -JOIN- }
  TIdIRCJoinEvent = procedure(ASender: TIdContext; ANickname, AHost, AChannel: String) of object;
  { -PART- }
  TIdIRCPartEvent = procedure(ASender: TIdContext; ANickname, AHost, AChannel: String) of object;
  { -TOPIC- }
  TIdIRCTopicEvent = procedure(ASender: TIdContext; ANickname, AHost, AChannel,
    ATopic: String) of object;
  { -KICK- }
  TIdIRCKickEvent = procedure(ASender: TIdContext; ANickname, AHost, AChannel,
    ATarget, AReason: String) of object;
  { -MOTD- }
  TIdIRCMOTDEvent = procedure(ASender: TIdContext; AMOTD: TIdStrings) of object;
  { -TRACE- }
  TIdIRCServerTraceEvent = procedure(ASender: TIdContext; ATraceInfo: TIdStrings) of object;
  { -OPER- }
  TIdIRCOpEvent = procedure(ASender: TIdContext; ANickname, AChannel, AHost: String) of object;
  { -INV- }
  TIdIRCInvitingEvent = procedure(ASender: TIdContext; ANickname, AHost: String) of object;
  TIdIRCInviteEvent = procedure(ASender: TIdContext; ANicknameFrom, AHost, ANicknameTo,
    AChannel: String) of object;
  { -LIST- }
  TIdIRCChanBANListEvent = procedure(ASender: TIdContext; AChannel: String;
    ABanList: TIdStrings) of object;
  TIdIRCChanEXCListEvent = procedure(ASender: TIdContext; AChannel: String;
    AExceptList: TIdStrings) of object;
  TIdIRCChanINVListEvent = procedure(ASender: TIdContext; AChannel: String;
    AInviteList: TIdStrings) of object;
  TIdIRCServerListEvent = procedure(ASender: TIdContext; AServerList: TIdStrings) of object;
  TIdIRCNickListEvent = procedure(ASender: TIdContext; AChannel: String;
    ANicknameList: TIdStrings) of object;
  { -STATS- }
  TIdIRCServerUsersEvent = procedure(ASender: TIdContext; AUsers: TIdStrings) of object;
  TIdIRCServerStatsEvent = procedure(ASender: TIdContext; AStatus: TIdStrings) of object;
  TIdIRCKnownServerNamesEvent = procedure(ASender: TIdContext; AKnownServers: TIdStrings) of object;
  { -INFO- }
  TIdIRCAdminInfoRecvEvent = procedure(ASender: TIdContext; AAdminInfo: TIdStrings) of object;
  TIdIRCUserInfoRecvEvent = procedure(ASender: TIdContext; AUserInfo: TIdStrings) of object;
  { -WHO- }
  TIdIRCWhoEvent = procedure(ASender: TIdContext; AWhoResults: TIdStrings) of object;
  TIdIRCWhoIsEvent = procedure(ASender: TIdContext; AWhoIsResults: TIdStrings) of object;
  TIdIRCWhoWasEvent = procedure(ASender: TIdContext; AWhoWasResults: TIdStrings) of object;
  { Mode }
  TIdIRCChanModeEvent = procedure(ASender: TIdContext) of object;
  TIdIRCUserModeEvent = procedure(ASender: TIdContext; ANickname, AHost,
    AUserMode: String) of object;
  { -CTCP- }
  TIdIRCCTCPQueryEvent = procedure(ASender: TIdContext; ANicknameFrom, AHost,
    ANicknameTo, AChannel, ACommand, AParams: String) of object;
  TIdIRCCTCPReplyEvent = procedure(ASender: TIdContext; ANicknameFrom, AHost,
    ANicknameTo, AChannel, ACommand, AParams: String) of object;
  { -DCC- }
  TIdIRCDCCChatEvent = procedure(ASender: TIdContext; ANickname, AHost: String;
    APort: Integer) of object;
  TIdIRCDCCSendEvent = procedure(ASender: TIdContext; ANickname, AHost,
    AFilename: String; APort, AFileSize: Integer) of object;
  TIdIRCDCCResumeEvent = procedure(ASender: TIdContext; ANickname, AHost,
    AFilename: String; APort, AFilePos: Integer) of object;
  TIdIRCDCCAcceptEvent = procedure(ASender: TIdContext; ANickname, AHost,
    AFilename: String; APort, AFilePos: Integer) of object;
  { -Errors- }
  TIdIRCServerErrorEvent = procedure(ASender: TIdContext; AErrorCode: Integer;
    AErrorMessage: String) of object;
  TIdIRCNickErrorEvent = procedure(ASender: TIdContext; AError: Integer) of object;
  TIdIRCKillErrorEvent = procedure(ASender: TIdContext) of object;
  { Other }
  TIdIRCNicknameChangedEvent = procedure(ASender: TIdContext; AOldNickname,
    AHost, ANewNickname: String) of object;
  TIdIRCKillEvent = procedure(ASender: TIdContext; ANicknameFrom, AHost,
    ANicknameTo, AReason: String) of object;
  TIdIRCQuitEvent = procedure(ASender: TIdContext; ANickname, AHost, AReason: String) of object;
  TIdIRCSvrTimeEvent = procedure(ASender: TIdContext; Host, Time: String) of object;
  TIdIRCServiceEvent = procedure(ASender: TIdContext) of object;
  TIdIRCSvrVersionEvent = procedure(ASender: TIdContext; Version, Host, Comments: String) of object;
  TIdIRCRawEvent = procedure(ASender: TIdContext; AIn: boolean; AMessage: String) of object;

//============================================================================//

  { TIdIRCReplies }
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

//============================================================================//

  { TIdIRC }
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
    FTmp: TIdStrings;
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
    procedure SetNickname(AValue: String);
    procedure SetUsername(AValue: String);
    procedure SetIdIRCUserMode(AValue: TIdIRCUserModes);
    procedure SetIdIRCReplies(AValue: TIdIRCReplies);
    function GetUserMode: String;
    procedure ParseCTCPQuery(CTCPQuery, AChannel: String);
    procedure ParseCTCPReply(CTCPReply, AChannel: String);
    procedure ParseDCC(ADCC: String);
    //Command handlers
    procedure DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string;
      AContext: TIdContext);
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
    procedure Disconnect(AReason: String = ''); reintroduce;
    //
    function IsChannel(AChannel: String): Boolean;
    function IsOp(ANickname: String): Boolean;
    function IsVoice(ANickname: String): Boolean;
    procedure Raw(ALine: String);
    procedure Say(ATarget, AMsg: String);
    procedure Notice(ATarget, AMsg: String);
    procedure Action(ATarget, AMsg: String);
    procedure CTCPQuery(ATarget, ACommand, AParameters: String);
    procedure CTCPReply(ATarget, ACTCP, AReply: String);
    procedure Join(AChannel: String; const AKey: String ='');
    procedure Part(AChannel: String; const AReason: String = '');
    procedure Kick(AChannel, ANickname, AReason: String);
    procedure SetChannelMode(AChannel, AMode: String; const AParams: String = '');
    procedure SetUserMode(ANickname, AMode: String);
    procedure GetChannelTopic(AChannel: String);
    procedure SetChannelTopic(AChannel, ATopic: String);
    procedure SetAway(AMsg: String);
    procedure Op(AChannel, ANickname: String);
    procedure Deop(AChannel, ANickname: String);
    procedure Voice(AChannel, ANickname: String);
    procedure Devoice(AChannel, ANickname: String);
    procedure Ban(AChannel, AHostmask: String);
    procedure Unban(AChannel, AHostmask: String);
    procedure RegisterService(const ANickname, ADistribution, AInfo: String;
      AType: Integer);
    procedure ListChannelNicknames(AChannel: String; ATarget: String = '');
    procedure ListChannel(AChannel: String; ATarget: String = '');
    procedure Invite(ANickname, AChannel: String);
    procedure GetMessageOfTheDay(ATarget: String = '');
    procedure GetNetworkStatus(AHostMask: String = ''; ATarget: String = '');
    procedure GetServerVersion(ATarget: String = '');
    procedure GetServerStatus(AQuery: TIdIRCStat; ATarget: String = '');
    procedure ListKnownServerNames(ARemoteHost: String = ''; AHostMask: String = '');
    procedure QueryServerTime(ATarget: String = '');
    procedure RequestServerConnect(ATarget, AHost: String; APort: Integer;
      ARemoteHost: String = '');
    procedure TraceServer(ATarget: String = '');
    procedure GetAdminInfo(ATarget: String = '');
    procedure GetServerInfo(ATarget: String = '');
    procedure ListNetworkServices(AHostMask: String; AType: String = '');
    procedure QueryService(AServiceName, AMessage: String);
    procedure Who(AMask: String; AOnlyAdmins: Boolean);
    procedure WhoIs(AMask: String; ATarget: String = '');
    procedure WhoWas(ANickname: String; ACount: Integer = -1; ATarget: String = '');
    procedure Kill(ANickname, AComment: String);
    procedure Ping(AServer1: String; AServer2: String = '');
    procedure Pong(AServer1: String; AServer2: String = '');
    procedure Error(AMessage: String);
    procedure ReHash;
    procedure Die;
    procedure Restart;
    procedure Summon(ANickname: String; ATarget: String = ''; AChannel: String = '');
    procedure ListServerUsers(ATarget: String = '');
    procedure SayWALLOPS(AMessage: String);
    procedure GetUserInfo(ANickname: String);
    procedure IsOnIRC(ANickname: String);
    procedure BecomeOp(ANickname, APassword: String);
    procedure SQuit(AHost, AComment: String);
    procedure SetChannelLimit(AChannel: String; ALimit: Integer);
    procedure SetChannelKey(AChannel, AKey: String);
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
    property OnPrivateMessage: TIdIRCPrivMessageEvent read FOnPrivMessage
      write FOnPrivMessage;
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
    property OnExceptionListReceived: TIdIRCChanEXCListEvent read FOnEXCList
      write FOnEXCList;
    property OnInvitationListReceived: TIdIRCChanINVListEvent read FOnINVList
      write FOnINVList;
    property OnServerListReceived: TIdIRCServerListEvent read FOnSvrList write FOnSvrList;
    property OnNicknamesListReceived: TIdIRCNickListEvent read FOnNickList write FOnNickList;
    property OnServerUsersListReceived: TIdIRCServerUsersEvent read FOnSvrUsers
      write FOnSvrUsers;
    property OnServerStatsReceived: TIdIRCServerStatsEvent read FOnSvrStats
      write FOnSvrStats;
    property OnKnownServersListReceived: TIdIRCKnownServerNamesEvent read FOnKnownSvrs
      write FOnKnownSvrs;
    property OnAdminInfoReceived: TIdIRCAdminInfoRecvEvent read FOnAdminInfo
      write FOnAdminInfo;
    property OnUserInfoReceived: TIdIRCUserInfoRecvEvent read FOnUserInfo
      write FOnUserInfo;
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

//============================================================================//

const
  // ChannelModeChars: array [0..7] of Char = ('p', 's', 'i', 't', 'n', 'm', 'l', 'k'); {do not localize}
  IdIRCUserModeChars: array [0..6] of char = ('a', 'i', 'w', 'r', 'o', 'O', 's'); {do not localize}
  IdIRCStatChars: array[0..3] of char = ('l', 'm', 'o', 'u'); {do not localize}

  IdIRCCTCP: array [0..9] of String =
  (
    'ACTION', 'SOUND', 'PING', 'FINGER', 'USERINFO', 'VERSION', 'CLIENTINFO', {do not localize}
    'TIME', 'ERROR', 'DCC'  {do not localize}
  );

  IdIRCDCC: array [0..3] of String =
  (
    'SEND', 'CHAT', 'RESUME', 'ACCEPT'  {do not localize}
  );

//============================================================================//

implementation

uses
  IdGlobal, IdException, IdGlobalProtocols, IdResourceStringsProtocols, IdSSL,
  IdStack, IdSys;

//============================================================================//
{ TIdIRCReplies }

constructor TIdIRCReplies.Create;
begin
  inherited Create;
  //
end;

procedure TIdIRCReplies.Assign(Source: TPersistent);
begin
  if Source is TIdIRCReplies then
  begin
    FFinger := TIdIRCReplies(Source).Finger;
    FVersion := TIdIRCReplies(Source).Version;
    FUserInfo := TIdIRCReplies(Source).UserInfo;
    FClientInfo := TIdIRCReplies(Source).ClientInfo;
  end;
end;

//============================================================================//
{ TIdIRC }

procedure TIdIRC.InitComponent;
begin
  inherited;
  //
  FReplies := TIdIRCReplies.Create;
  FTmp := TIdStringList.Create;
  Port := IdPORT_IRC;
  FUserMode := [];
  //
  if not (csDesigning in ComponentState) then
  begin
    AssignIRCClientCommands;
  end;
end;

destructor TIdIRC.Destroy;
begin
  Sys.FreeAndNil(FReplies);
  Sys.FreeAndNil(FTmp);
  //
  inherited Destroy;
end;

function TIdIRC.GetUserMode: String;
var
  i: TIdIRCUserMode;
begin
  if FUserMode <> [] then
  begin
    result := '+';
    for i := amAway to amReceiveServerNotices do
    begin
      if i in FUserMode then
      begin
        result := result + IdIRCUserModeChars[ord(i)];
      end;
    end;
  end
  else
  begin
    result := '0';
  end;
end;

//============================================================================//

procedure TIdIRC.Connect;
begin
  // I doubt that there is explicit SSL support in the IRC protocol
  if (IOHandler is TIdSSLIOHandlerSocketBase) then
  begin
    (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
  end;
  inherited;
  //
  try
    if FPassword <> '' then
    begin
      Raw(Sys.Format('PASS %s', [FPassword]));  {do not localize}
    end;

    SetNickname(FNickname);
    SetUsername(FUsername);
  except
    on E: EIdSocketError do begin
      raise EComponentError.Create(RSIRCCannotConnect);
    end;
  end;
end;

procedure TIdIRC.Disconnect(AReason: String = '');
begin
  Raw(Sys.Format('QUIT :%s', [AReason])); {do not localize}
  inherited Disconnect;
end;

procedure TIdIRC.Raw(ALine: String);
begin
  if Connected then
  begin
    if Assigned(FOnRaw) then
    begin
      FOnRaw(nil, False, ALine);
    end;

    IOHandler.WriteLn(ALine + EOL);
  end;
end;

//============================================================================//

procedure TIdIRC.AssignIRCClientCommands;
begin
  { Text commands }
  //PRIVMSG Nickname/#channel :message
  with CommandHandlers.Add do
  begin
    Command := 'PRIVMSG'; {do not localize}
    OnCommand := CommandPRIVMSG;
  end;
  //NOTICE Nickname/#channel :message
  with CommandHandlers.Add do
  begin
    Command := 'NOTICE';  {do not localize}
    OnCommand := CommandNOTICE;
  end;
  //JOIN #channel
  with CommandHandlers.Add do
  begin
    Command := 'JOIN';  {do not localize}
    OnCommand := CommandJOIN;
  end;
  //PART #channel
  with CommandHandlers.Add do
  begin
    Command := 'PART';  {do not localize}
    OnCommand := CommandPART;
  end;
  //KICK #channel target :reason
  with CommandHandlers.Add do
  begin
    Command := 'KICK';  {do not localize}
    OnCommand := CommandKICK;
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
  end;
  //QUIT :reason
  with CommandHandlers.Add do
  begin
    Command := 'QUIT';  {do not localize}
    OnCommand := CommandQUIT;
  end;
  //INVITE Nickname :#channel
  with CommandHandlers.Add do
  begin
    Command := 'INVITE';  {do not localize}
    OnCommand := CommandINVITE;
  end;
  //KILL Nickname :reason
  with CommandHandlers.Add do
  begin
    Command := 'KILL';  {do not localize}
    OnCommand := CommandKILL;
  end;
  //PING server
  with CommandHandlers.Add do
  begin
    Command := 'PING';  {do not localize}
    OnCommand := CommandPING;
  end;
  //WALLOPS :message
  with CommandHandlers.Add do
  begin
    Command := 'WALLOPS'; {do not localize}
    OnCommand := CommandWALLOPS;
  end;
  //TOPIC
  with CommandHandlers.Add do
  begin
    Command := 'TOPIC'; {do not localize}
    OnCommand := CommandTOPIC;
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

//============================================================================//

{ Command handlers }

procedure TIdIRC.DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string;
  AContext: TIdContext);
var
  LTmp: String;
begin
  // ":sender!pc@domain"
  if AData <> '' then begin
    if AData[1] = ':' then begin
      LTmp := Fetch(AData, #32);
      FSenderNick := Fetch(LTmp, '!');
      FSenderHost := LTmp;
    end;
  end;

  if Assigned(FOnRaw) then
  begin
    FOnRaw(AContext, True, AData);
  end;
end;

procedure TIdIRC.DoCmdHandlersException(ACommand: String; AContext: TIdContext);
var
  ACmdCode: Integer;
begin
  ACmdCode := Sys.StrToInt(Fetch(ACommand, #32), -1);
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
        if Assigned(FOnAway) then
        begin
          if (ACmdCode = 305) or (ACmdCode = 306) then
            FUserAway := False
          else
            FUserAway := True;
          OnAway(AContext, FSenderNick, FSenderHost, Fetch(ACommand, #32), FUserAway);
        end;
      end;
    5,
    401..424,
    437..502:
      begin
        if Assigned(FOnServerError) then
        begin
          OnServerError(AContext, ACmdCode, ACommand);
        end;
      end;
    431,
    432,
    433,
    436:
      begin
        if Assigned(FOnNickError) then
        begin
          OnNicknameError(AContext, Sys.StrToInt(Fetch(ACommand, #32)));
        end;
      end;
    else
      { anything else, just add to TIdStrings }
      if ACmdCode <> -1 then
      begin
        if length(ACommand) <> 0 then
        begin
          FTmp.Add(ACommand);
        end;
      end;
  end;
end;

//============================================================================//

procedure TIdIRC.CommandPRIVMSG(ASender: TIdCommand);
var
  LTmp: String;
begin
  if ASender.Params[0][1] = #1 then
  begin
    ParseCTCPQuery(ASender.Params[1], ASender.Params[0]);
  end
  else if Assigned(FOnPrivMessage) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnPrivateMessage(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], LTmp);
  end;
end;

procedure TIdIRC.CommandNOTICE(ASender: TIdCommand);
var
  LTmp: String;
begin
  if ASender.Params[0][1] = #1 then
  begin
    ParseCTCPReply(ASender.Params[1], ASender.Params[0]);
  end
  else if Assigned(FOnNotice) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnNotice(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], LTmp);
  end;
end;

procedure TIdIRC.CommandJOIN(ASender: TIdCommand);
begin
  if Assigned(FOnJoin) then
  begin
    OnJoin(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandPART(ASender: TIdCommand);
begin
  if Assigned(FOnPart) then
  begin
    OnPart(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandKICK(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnKick) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnKick(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], ASender.Params[1], LTmp);
  end;
end;

procedure TIdIRC.CommandMODE(ASender: TIdCommand);
begin
  if IsChannel(ASender.Params[1]) then
  begin
    OnChannelMode(ASender.Context);
  end
  else if Assigned(FOnUserMode) then
  begin
    OnUserMode(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandNICK(ASender: TIdCommand);
begin
  if Assigned(FOnNickChange) then
  begin
    OnNicknameChange(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

procedure TIdIRC.CommandQUIT(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnQuit) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnQuit(ASender.Context, FSenderNick, FSenderHost, LTmp);
  end;
end;

procedure TIdIRC.CommandINVITE(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnInvite) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnInvite(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], LTmp);
  end;
end;

procedure TIdIRC.CommandKILL(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnKill) then
  begin
    OnKill(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], LTmp);
  end;
end;

procedure TIdIRC.CommandPING(ASender: TIdCommand);
begin
  Pong(ASender.Params[0]);
  if Assigned(FOnPingPong) then
  begin
    OnPingPong(ASender.Context);
  end;
end;

procedure TIdIRC.CommandWALLOPS(ASender: TIdCommand);
var
  LTmp: String;
begin
  if Assigned(FOnWallops) then
  begin
    LTmp := copy(ASender.Params[1], 2, length(ASender.Params[1]) - 2);
    OnWallops(ASender.Context, FSenderNick, FSenderHost, LTmp);
  end;
end;

procedure TIdIRC.CommandTOPIC(ASender: TIdCommand);
begin
  if Assigned(FOnTopic) then
  begin
    OnTopic(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRC.CommandServerWelcome(ASender: TIdCommand);
begin
  if Assigned(FOnSWelcome) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnServerWelcome(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandUSERHOST(ASender: TIdCommand);
begin
  if Assigned(FOnUserInfo) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnUserInfoReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandISON(ASender: TIdCommand);
begin
  if Assigned(FOnIsOnIRC) then
  begin
    OnIsOnIRC(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFWHOIS(ASender: TIdCommand);
begin
  if Assigned(FOnWhoIs) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnWhoIs(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFWHOWAS(ASender: TIdCommand);
begin
  if Assigned(FOnWhoWas) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnWhoWas(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandLISTEND(ASender: TIdCommand);
begin
  if Assigned(FOnSvrList) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnServerListReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandINVITING(ASender: TIdCommand);
begin
  if Assigned(FOnInviting) then
  begin
    OnInviting(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandSUMMONING(ASender: TIdCommand);
begin
  if Assigned(FOnSummon) then
  begin
    OnSummon(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFINVITELIST(ASender: TIdCommand);
begin
  if Assigned(FOnINVList) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnInvitationListReceived(ASender.Context, FSenderNick, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFEXCEPTLIST(ASender: TIdCommand);
begin
  if Assigned(FOnEXCList) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnExceptionListReceived(ASender.Context, FSenderNick, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFWHO(ASender: TIdCommand);
begin
  if Assigned(FOnWho) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnWho(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFNAMES(ASender: TIdCommand);
begin
  if Assigned(FOnNickList) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnNicknamesListReceived(ASender.Context, FSenderNick, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFLINKS(ASender: TIdCommand);
begin
  if Assigned(FOnKnownSvrs) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnKnownServersListReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFBANLIST(ASender: TIdCommand);
begin
  if Assigned(FOnBanList) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnBanListReceived(ASender.Context, FSenderNick, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFINFO(ASender: TIdCommand);
begin
  if Assigned(FOnUserInfo) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnUserInfoReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFMOTD(ASender: TIdCommand);
begin
  if Assigned(FOnMOTD) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnMOTD(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandREHASHING(ASender: TIdCommand);
begin
  if Assigned(FOnRehash) then
  begin
    OnRehash(ASender.Context, FSenderNick, FSenderHost);
  end;
end;

procedure TIdIRC.CommandENDOFUSERS(ASender: TIdCommand);
begin
  if Assigned(FOnSvrUsers) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnServerUsersListReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandENDOFSTATS(ASender: TIdCommand);
begin
  if Assigned(FOnSvrStats) then
  begin
    FTmp.Add(ASender.UnparsedParams);
    OnServerStatsReceived(ASender.Context, FTmp);
    if FTmp.Count > 0 then
    begin
      FTmp.Clear;
    end;
  end;
end;

procedure TIdIRC.CommandSERVLISTEND(ASender: TIdCommand);
begin
  //
end;

procedure TIdIRC.CommandSTIME(ASender: TIdCommand);
begin
  if Assigned(FOnSvrTime) then
  begin
    OnServerTime(ASender.Context, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdIRC.CommandSERVICE(ASender: TIdCommand);
begin
  if Assigned(FOnService) then
  begin
    OnService(ASender.Context);
  end;
end;

procedure TIdIRC.CommandSVERSION(ASender: TIdCommand);
begin
  if Assigned(FOnSvrVersion) then
  begin
    OnServerVersion(ASender.Context, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdIRC.CommandCHANMODE(ASender: TIdCommand);
begin
  if Assigned(FOnChanMode) then
  begin
    OnChannelMode(ASender.Context);
  end;
end;

procedure TIdIRC.CommandOPER(ASender: TIdCommand);
begin
  if Assigned(FOnOp) then
  begin
    OnOp(ASender.Context, FSenderNick, FSenderHost, ASender.Params[0]);
  end;
end;

//============================================================================//

procedure TIdIRC.ParseCTCPQuery(CTCPQuery, AChannel: String);
var
  CTCP: String;
  LTmp: String;
  LTmp1: String;
begin
  CTCP := CTCPQuery;
  LTmp := Fetch(CTCP, #32);
  LTmp1 := CTCP;

  case PosInStrArray(LTmp1, IdIRCCTCP) of
    0: { ACTION }
      begin
        //if Assigned(FOnAction) then
        //  FOnAction(FSenderNick, AChannel, LTmp1);
      end;
    1: { SOUND }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, LTmp, LTmp);
        end;
      end;
    2: { PING }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, LTmp, Ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, LTmp1, ltmp, ltmp, ltmp);
      end;
    3: { FINGER }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, LTmp, Ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, Replies.Finger, ltmp, ltmp, ltmp);
      end;
    4: { USERINFO }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, Ltmp, ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, Replies.UserInfo, ltmp, ltmp, ltmp);
      end;
    5: { VERSION }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, Replies.Version, ltmp, ltmp, ltmp);
      end;
    6: { CLIENTINFO }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, Replies.ClientInfo, ltmp, ltmp, ltmp);
      end;
    7: { TIME }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
        end;
        OnCTCPReply(nil, FSenderNick, LTmp, Sys.Format(RSIRCTimeIsNow, [Sys.DateTimeToStr(Sys.Now)]), ltmp, ltmp, ltmp);
      end;
    8: { ERROR }
      begin
        if Assigned(FOnCTCPQry) then
        begin
          FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
        end;
      end;
    9: { DCC }
      begin
        ParseDCC(LTmp1);
      end;
    else
      if Assigned(FOnCTCPQry) then
      begin
        FOnCTCPQry(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
      end;
  end;
end;

procedure TIdIRC.ParseCTCPReply(CTCPReply, AChannel: String);
var
  CTCP: String;
  LTmp: String;
  LTmp1: String;
begin
  CTCP := CTCPReply;
  LTmp := Fetch(CTCP, #32);
  LTmp1 := CTCP;

  if PosInStrArray(LTmp1, IdIRCCTCP) = 9 then { DCC }
  begin
    { FIXME: To be completed. }
  end
  else if Assigned(FOnCTCPRep) then
  begin
    FOnCTCPRep(nil, FSenderNick, AChannel, LTmp, LTmp1, ltmp, ltmp);
  end;
end;

procedure TIdIRC.ParseDCC(ADCC: String);
var
  LTmp: String;
  LTmp1, LTmp2, LTmp3: String;
begin
  LTmp := ADCC;
  LTmp1 := Fetch(LTmp, #32);
  LTmp2 := Fetch(LTmp, #32);
  LTmp3 := Fetch(LTmp, #32);
  //
  case PosInStrArray(LTmp1, IdIRCDCC) of
    0: {SEND}
      begin
        if Assigned(FOnDCCSend) then
        begin
          FOnDCCSend(nil, FSenderNick, LTmp2, LTmp3, Sys.StrToInt(LTmp1), Sys.StrToInt(LTmp));
        end;
      end;
    1: {CHAT}
      begin
        if Assigned(FOnDCCChat) then
        begin
          FOnDCCChat(nil, FSenderNick, LTmp2, Sys.StrToInt(LTmp3));
        end;
      end;
    2: {RESUME}
      begin
        if Assigned(FOnDCCResume) then
        begin
          FOnDCCResume(nil, FSenderNick, LTmp2, LTmp1, Sys.StrToInt(Ltmp1), Sys.StrToInt(LTmp3));
        end;
      end;
    3: {ACCEPT}
      begin
        if Assigned(FOnDCCAccept) then
        begin
          FOnDCCAccept(nil, FSenderNick, LTmp2, LTmp1, Sys.StrToInt(LTmp3), Sys.StrToInt(LTmp));
        end;
      end;
  end;
end;

//============================================================================//

procedure TIdIRC.SetNickname(AValue: String);
begin
  if not Connected then
  begin
    FNickname := AValue;
  end
  else
    Raw(Sys.Format('NICK %s', [AValue])); {do not localize}
end;

procedure TIdIRC.SetUsername(AValue: String);
begin
  if not Connected then
  begin
    FUsername := AValue;
  end
  else
    Raw(Sys.Format('USER %s %s %s :%s', [AValue, GetUserMode, '*', FRealName]));  {do not localize}
end;

procedure TIdIRC.SetIdIRCUserMode(AValue: TIdIRCUserModes);
begin
  FUserMode := AValue;
end;

procedure TIdIRC.SetIdIRCReplies(AValue: TIdIRCReplies);
begin
  FReplies.Assign(AValue);
end;

function TIdIRC.IsChannel(AChannel: String): Boolean;
begin
  //Result := (Length(AChannel) > 0) and CharIsInSet(AChannel, 1, ['&','#','+','!']);  {do not localize}
  Result := False;
  if Length(AChannel) > 0 then begin
    if CharIsInSet(AChannel, 1, '&#+!') then begin  {do not localize}
     Result := True;
    end;
  end;
end;

function TIdIRC.IsOp(ANickname: String): Boolean;
begin
  //Result := (Length(ANickname) > 0) and (ANickname[1] = '@');
  Result := False;
  if Length(ANickname) > 0 then begin
    if ANickname[1] = '@' then begin
      Result := True;
    end;
  end;
end;

function TIdIRC.IsVoice(ANickname: String): Boolean;
begin
  //Result := (Length(ANickname) > 0) and (ANickname[length(Nickname)] = '+');
  Result := False;
  if Length(ANickname) > 0 then begin
    if ANickname[length(Nickname)] = '+' then begin
      Result := True;
    end;
  end;
end;

procedure TIdIRC.Say(ATarget, AMsg: String);
begin
  Raw(Sys.Format('PRIVMSG %s :%s', [ATarget, AMsg])); {do not localize}
end;

procedure TIdIRC.Notice(ATarget, AMsg: String);
begin
  Raw(Sys.Format('NOTICE %s :%s', [ATarget, AMsg]));  {do not localize}
end;

procedure TIdIRC.Action(ATarget, AMsg: String);
begin
  CTCPQuery(ATarget, 'ACTION', AMsg); {do not localize}
end;

procedure TIdIRC.CTCPQuery(ATarget, ACommand, AParameters: String);
begin
  Say(ATarget, Sys.Format(#1'%s %s'#1, [Sys.UpperCase(ACommand), AParameters]));  {do not localize}
end;

procedure TIdIRC.CTCPReply(ATarget, ACTCP, AReply: String);
begin
  Notice(ATarget, Sys.Format(#1'%s %s'#1, [ACTCP, AReply]));  {do not localize}
end;

procedure TIdIRC.Join(AChannel: String; const AKey: String = '');
begin
  if IsChannel(AChannel) then
  begin
    if AKey <> '' then
    begin
      Raw(Sys.Format('JOIN %s %s', [AChannel, AKey])) {do not localize}
    end
    else
      Raw(Sys.Format('JOIN %s', [AChannel])); {do not localize}
  end;
end;

procedure TIdIRC.Part(AChannel: String; const AReason: String = '');
begin
  if IsChannel(AChannel) then
  begin
    if AReason <> '' then
    begin
      Raw(Sys.Format('PART %s :%s', [AChannel, AReason])) {do not localize}
    end
    else
      Raw(Sys.Format('PART %s', [AChannel])); {do not localize}
  end;
end;

procedure TIdIRC.Kick(AChannel, ANickname, AReason: String);
begin
  if IsChannel(AChannel) then
  begin
    Raw(Sys.Format('KICK %s %s :%s', [AChannel, ANickname, AReason]));  {do not localize}
  end;
end;

procedure TIdIRC.SetChannelMode(AChannel, AMode: String; const AParams: String = '');
begin
  if IsChannel(AChannel) then
  begin
    if AParams = '' then
    begin
      Raw(Sys.Format('MODE %s %s', [AChannel, AMode])); {do not localize}
    end
    else
      Raw(Sys.Format('MODE %s %s %s', [AChannel, AMode, AParams])); {do not localize}
  end;
end;

procedure TIdIRC.SetUserMode(ANickname, AMode: String);
begin
  Raw(Sys.Format('MODE %s %s', [ANickname, AMode]));  {do not localize}
end;

procedure TIdIRC.GetChannelTopic(AChannel: String);
begin
  if IsChannel(AChannel) then
  begin
    Raw(Sys.Format('TOPIC %s', [AChannel]));  {do not localize}
  end;
end;

procedure TIdIRC.SetChannelTopic(AChannel, ATopic: String);
begin
  if IsChannel(AChannel) then
  begin
    Raw(Sys.Format('TOPIC %s :%s', [AChannel, ATopic]));  {do not localize}
  end;
end;

procedure TIdIRC.SetAway(AMsg: String);
begin
  if AMsg <> '' then
  begin
    Raw(Sys.Format('AWAY %s', [AMsg])); {do not localize}
  end
  else
    Raw('AWAY');  {do not localize}
end;

procedure TIdIRC.Op(AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '+o', ANickname);  {do not localize}
end;

procedure TIdIRC.Deop(AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '-o', ANickname);  {do not localize}
end;

procedure TIdIRC.Voice(AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '+v', ANickname);  {do not localize}
end;

procedure TIdIRC.Devoice(AChannel, ANickname: String);
begin
  SetChannelMode(AChannel, '-v', ANickname);  {do not localize}
end;

procedure TIdIRC.Ban(AChannel, AHostmask: String);
begin
  SetChannelMode(AChannel, '+b', AHostmask);  {do not localize}
end;

procedure TIdIRC.Unban(AChannel, AHostmask: String);
begin
  SetChannelMode(AChannel, '-b', AHostmask);  {do not localize}
end;

procedure TIdIRC.RegisterService(const ANickname, ADistribution, AInfo: String;
  AType: Integer);
begin
  Raw(Sys.Format('SERVICE %s %s %s %s %s :%s',  {do not localize}
    [ANickname, '*', ADistribution, AType, '0', AInfo]));
end;

procedure TIdIRC.ListChannelNicknames(AChannel: String; ATarget: String = '');
begin
  if IsChannel(AChannel) then
  begin
    if ATarget <> '' then
    begin
      Raw(Sys.Format('NAMES %s %s', [AChannel, ATarget]));  {do not localize}
    end
    else
      Raw(Sys.Format('NAMES %s', [AChannel]));  {do not localize}
  end;
end;

procedure TIdIRC.ListChannel(AChannel: String; ATarget: String = '');
begin
  if IsChannel(AChannel) then
  begin
    if ATarget <> '' then
    begin
      Raw(Sys.Format('LIST %s %s', [AChannel, ATarget])); {do not localize}
    end
    else
      Raw(Sys.Format('LIST %s', [AChannel])); {do not localize}
  end;
end;

procedure TIdIRC.Invite(ANickname, AChannel: String);
begin
  if IsChannel(AChannel) then
  begin
    Raw(Sys.Format('INVITE %s %s', [ANickname, AChannel])); {do not localize}
  end;
end;

procedure TIdIRC.GetMessageOfTheDay(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('MOTD %s', [ATarget]));  {do not localize}
  end
  else
    Raw('MOTD');  {do not localize}
end;

procedure TIdIRC.GetNetworkStatus(AHostMask: String = ''; ATarget: String = '');
begin
  if ((AHostMask = '') and (ATarget = '')) then
  begin
    Raw('LUSERS');  {do not localize}
  end
  else if AHostMask = '' then
  begin
    Raw(Sys.Format('LUSERS %s', [ATarget]));  {do not localize}
  end
  else if ATarget = '' then
  begin
    Raw(Sys.Format('LUSERS %s', [AHostMask]));  {do not localize}
  end
  else
    Raw(Sys.Format('LUSERS %s %s', [AHostMask, ATarget]));  {do not localize}
end;

procedure TIdIRC.GetServerVersion(ATarget: String = '');
begin
  if ATarget = '' then
  begin
    Raw('VERSION'); {do not localize}
  end
  else
    Raw(Sys.Format('VERSION %s', [ATarget])); {do not localize}
end;

procedure TIdIRC.GetServerStatus(AQuery: TIdIRCStat; ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('STATS %s %s', [IdIRCStatChars[ord(AQuery)], ATarget])); {do not localize}
  end
  else
    Raw(Sys.Format('STATS %s', [IdIRCStatChars[ord(AQuery)]])); {do not localize}
end;

procedure TIdIRC.ListKnownServerNames(ARemoteHost: String = ''; AHostMask: String = '');
begin
  if ((ARemoteHost = '') and (AHostMask = '')) then
  begin
    Raw('LINKS'); {do not localize}
  end
  else if ARemoteHost = '' then
  begin
    Raw(Sys.Format('LINKS %s', [AHostMask])); {do not localize}
  end
  else
    Raw(Sys.Format('LINKS %s', [ARemoteHost])); {do not localize}
end;

procedure TIdIRC.QueryServerTime(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('TIME %s', [ATarget]));  {do not localize}
  end
  else
    Raw('TIME');  {do not localize}
end;

procedure TIdIRC.RequestServerConnect(ATarget, AHost: String; APort: Integer;
  ARemoteHost: String = '');
begin
  if ARemoteHost <> '' then
  begin
    Raw(Sys.Format('CONNECT %s %s %d %s', [ATarget, AHost, APort, ARemoteHost])); {do not localize}
  end
  else
    Raw(Sys.Format('CONNECT %s %s %d', [ATarget, AHost, APort])); {do not localize}
end;

procedure TIdIRC.TraceServer(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('TRACE %s', [ATarget])); {do not localize}
  end
  else
    Raw('TRACE'); {do not localize}
end;

procedure TIdIRC.GetAdminInfo(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('ADMIN %s', [ATarget])); {do not localize}
  end
  else
    Raw('ADMIN'); {do not localize}
end;

procedure TIdIRC.GetServerInfo(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('INFO %s', [ATarget]));  {do not localize}
  end
  else
    Raw('INFO');  {do not localize}
end;

procedure TIdIRC.ListNetworkServices(AHostMask: String; AType: String = '');
begin
  if AType <> '' then
  begin
    Raw(Sys.Format('SERVLIST %s %s', [AHostMask, AType]));  {do not localize}
  end
  else
    Raw(Sys.Format('SERVLIST %s', [AHostMask]));  {do not localize}
end;

procedure TIdIRC.QueryService(AServiceName, AMessage: String);
begin
  Raw(Sys.Format('SQUERY %s %s', [AServiceName, AMessage]));  {do not localize}
end;

procedure TIdIRC.Who(AMask: String; AOnlyAdmins: Boolean);
begin
  if AOnlyAdmins then
  begin
    Raw(Sys.Format('WHO %s o', [AMask])); {do not localize}
  end
  else
    Raw(Sys.Format('WHO %s', [AMask])); {do not localize}
end;

procedure TIdIRC.WhoIs(AMask: String; ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('WHOIS %s %s', [AMask, ATarget])); {do not localize}
  end
  else
    Raw(Sys.Format('WHOIS %s', [AMask])); {do not localize}
end;

procedure TIdIRC.WhoWas(ANickname: String; ACount: Integer = -1; ATarget: String = '');
begin
  if ((ATarget = '') and (ACount = -1)) then
  begin
    Raw(Sys.Format('WHOWAS %s', [ANickname]));  {do not localize}
  end
  else if ATarget = '' then
  begin
    Raw(Sys.Format('WHOWAS %s %d', [ANickname, ACount])); {do not localize}
  end
  else if ACount = -1 then
  begin
    raw(Sys.Format('WHOWAS %s %s', [ANickname, ATarget]));  {do not localize}
  end;
end;

procedure TIdIRC.Kill(ANickname, AComment: String);
begin
  Raw(Sys.Format('KILL %s %s', [ANickname, AComment])); {do not localize}
end;

procedure TIdIRC.Ping(AServer1: String; AServer2: String = '');
begin
  if AServer2 <> '' then
  begin
    Raw(Sys.Format('PING %s %s', [AServer1, AServer2]));  {do not localize}
  end
  else
    Raw(Sys.Format('PING %s', [AServer1])); {do not localize}
end;

procedure TIdIRC.Pong(AServer1: String; AServer2: String = '');
begin
  if AServer2 <> '' then
  begin
    Raw(Sys.Format('PONG %s %s', [AServer1, AServer2]));  {do not localize}
  end
  else
    Raw(Sys.Format('PONG %s', [AServer1])); {do not localize}
end;

procedure TIdIRC.Error(AMessage: String);
begin
  Raw(Sys.Format('ERROR %s', [AMessage]));  {do not localize}
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

procedure TIdIRC.Summon(ANickname: String; ATarget: String = ''; AChannel: String = '');
begin
  if ((ATarget = '') and (AChannel = '')) then
  begin
    Raw(Sys.Format('SUMMON %s', [ANickname]));  {do not localize}
  end
  else if ATarget = '' then
  begin
    if IsChannel(AChannel) then
    begin
      Raw(Sys.Format('SUMMON %s', [AChannel])); {do not localize}
    end;
  end
  else
    Raw(Sys.Format('SUMMON %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.ListServerUsers(ATarget: String = '');
begin
  if ATarget <> '' then
  begin
    Raw(Sys.Format('USERS %s', [ATarget])); {do not localize}
  end
  else
    Raw('USERS'); {do not localize}
end;

procedure TIdIRC.SayWALLOPS(AMessage: String);
begin
  Raw(Sys.Format('WALLOPS %s', [AMessage]));  {do not localize}
end;

procedure TIdIRC.GetUserInfo(ANickname: String);
begin
  Raw(Sys.Format('USERHOST %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.IsOnIRC(ANickname: String);
begin
  Raw(Sys.Format('ISON %s', [ANickname]));  {do not localize}
end;

procedure TIdIRC.BecomeOp(ANickname, APassword: String);
begin
  Raw(Sys.Format('OPER %s %s', [ANickname, APassword]));  {do not localize}
end;

procedure TIdIRC.SQuit(AHost, AComment: String);
begin
  Raw(Sys.Format('SQUIT %s %s', [AHost, AComment]));  {do not localize}
end;

procedure TIdIRC.SetChannelLimit(AChannel: String; ALimit: Integer);
begin
  SetChannelMode(AChannel, '+l', Sys.Format('%s', [ALimit])); {do not localize}
end;

procedure TIdIRC.SetChannelKey(AChannel, AKey: String);
begin
  SetChannelMode(AChannel, '+k', AKey); {do not localize}
end;

procedure TIdIRC.SetIOHandler(AValue: TIdIOHandler);
begin
  inherited;
  //we do it this way so that if a user is using a custom value <> default, the port
  //is not set when the IOHandler is changed.
  if (IOHandler is TIdSSLIOHandlerSocketBase) then
  begin
    if PORT = IdPORT_IRC then
    begin
      Port := IdPORT_IRCS;
    end;
  end
  else
  begin
    if PORT = IdPORT_IRCS then
    begin
      Port := IdPORT_IRC;
    end;
  end;
end;

end.


