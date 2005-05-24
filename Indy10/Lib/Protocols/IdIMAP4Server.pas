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

unit IdIMAP4Server;

{
  TODO (ex RFC 3501):

  Dont allow & to be used as a mailbox separator.

  Certain server data (unsolicited responses) MUST be recorded,
  see Server Responses section.

  UIDs must be unique to a mailbox AND any subsequent mailbox with
  the same name - record in a text file.

  \Recent cannot be changed by STORE or APPEND.

  COPY should preserve the date of the original message.


  TODO (mine):

  Add a file recording the UIDVALIDITY in each mailbox.

  Emails should be ordered in date order.

  Optional date/time param to be implemented in APPEND.

  Consider integrating IdUserAccounts into login mechanism
  (or per-user passwords).

  Implement utf mailbox encoding.

  Implement * in message numbers.

  Implement multiple-option FETCH commands (will need breaking out some
  options which are abbreviations into their subsets).

 Need some method of preserving flags permanently.
}

{
  IMPLEMENTATION NOTES:

  Major rewrite started 2nd February 2004, Ciaran Costelloe, ccostelloe@flogas.ie.
  Prior to this, it was a simple wrapper class with a few problems.

  Note that IMAP servers should return BAD for an unknown command or
  invalid arguments (synthax errors and unsupported commands) and BAD
  if the command is valid but there was some problem in executing
  (e.g. trying a change an email's flag if it is a read-only mailbox).

  FUseDefaultMechanismsForUnassignedCommands defaults to True: if you
  set it to False, you need to implement command handlers for all the
  commands you need to implement. If True, this class implements a
  default mechanism and provides default behaviour for all commands.
  It does not include any filesystem-specific functions, which you
  need to implement.

  The default behaviour uses a default password of 'admin' - change this
  if you have any consideration for security!

  FSaferMode defaults to False: you should probably leave it False for
  testing, because this generates diagnostically-useful error messages.
  However, setting it True generates minimal responses for the greeting
  and for login failures, making life more difficult for a hacker.

  WARNING: you should also implement one of the Indy-provided more-secure
  logins than the default plaintext password login!

  You may want to assign handlers to the OnBeforeCmd and OnBeforeSend
  events to easily log data in & out of the server.

  WARNING: TIdIMAP4PeerContext has a TIdMailBox which holds various
  status info, including UIDs in its message collection.  Do NOT use the
  message collection for loading messages into, or you may thrash message
  UIDs or flags!
}

interface
{$IFDEF INDY100}
  {$I Core\IdCompilerDefines.inc}
  {$IFDEF DOTNET}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$ENDIF}
{$ENDIF}

uses
  Classes,
  IdAssignedNumbers,
  IdCmdTCPServer,
  IdContext,
  IdCommandHandlers,
  IdException,
  IdExplicitTLSClientServerBase,
  IdIMAP4,
  IdMailBox,
  IdMessage,
  IdReply,
  IdReplyIMAP4,
  IdTCPConnection,
  IdTStrings,
  IdYarn;

const
  DEF_IMAP4_IMPLICIT_TLS = False;

{
resourcestring
  RSIMAP4SvrBeginTLSNegotiation = 'Begin TLS negotiation now';
  RSIMAP4SvrNotPermittedWithTLS = 'Command not permitted when TLS active';
  RSIMAP4SvrImplicitTLSRequiresSSL = 'Implicit IMAP4 requires that IOHandler be set to a TIdServerIOHandlerSSLBase.';
}

type
  TIMAP4CommandEvent = procedure(AContext: TIdContext; const ATag,
    ACmd: String) of object;
  TIdIMAP4CommandBeforeEvent = procedure(ASender: TIdCommandHandlers; var AData: string;
      AContext: TIdContext) of object;
  TIdIMAP4CommandBeforeSendEvent = procedure(AContext: TIdContext; AData: string) of object;

  //For default mechanisms..
  TIdIMAP4DefMech1  = function(ALoginName, AMailbox: string): Boolean of object;
  TIdIMAP4DefMech2  = function(ALoginName, AMailBoxName: string; AMailBox: TIdMailBox): Boolean of object;
  TIdIMAP4DefMech3  = function(ALoginName, AMailbox: string): string of object;
  TIdIMAP4DefMech4  = function(ALoginName, AOldMailboxName, ANewMailboxName: string): Boolean of object;
  TIdIMAP4DefMech5  = function(ALoginName, AMailBoxName: string; var AMailBoxNames: TIdStringList; var AMailBoxFlags: TIdStringList): Boolean of object;
  TIdIMAP4DefMech6  = function(ALoginName, AMailbox: string; AMessage: TIdMessage): Boolean of object;
  TIdIMAP4DefMech7  = function(ALoginName, ASourceMailBox, AMessageUID, ADestinationMailbox: string): Boolean of object;
  TIdIMAP4DefMech8  = function(ALoginName, AMailbox: string; AMessage: TIdMessage): integer of object;
  TIdIMAP4DefMech9  = function(ALoginName, AMailbox: string; AMessage, ATargetMessage: TIdMessage): Boolean of object;
  TIdIMAP4DefMech10 = function(ALoginName, AMailbox: string; AMessage: TIdMessage; ALines: TIdStringList): Boolean of object;
  TIdIMAP4DefMech11 = function(ASender: TIdCommand; AReadOnly: Boolean): Boolean of object;
  TIdIMAP4DefMech12 = function(var AParams: TIdStringList; AMailBoxParam: integer): Boolean of object;
  TIdIMAP4DefMech13 = function(ALoginName, AMailBoxName, ANewUIDNext: string): Boolean of object;
  TIdIMAP4DefMech14 = function(ALoginName, AMailBoxName, AUID: string): string of object;

  EIdIMAP4ServerException = class(EIdException);
  EIdIMAP4ImplicitTLSRequiresSSL = class(EIdIMAP4ServerException);

  { Tag object }
  TIdIMAP4Tag = class(TObject)
  public
    IMAP4Tag: String;
  end;

  { custom IMAP4 context }
  TIdIMAP4PeerContext = class(TIdContext)
  protected
    FConnectionState : TIdIMAP4ConnectionState;
    FLoginName: string;
    FMailBox: TIdMailBox;
    FTagData: TIdIMAP4Tag;
    function GetUsingTLS:boolean;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TThreadList = nil
      ); override;
    destructor Destroy; override;
    property UsingTLS : boolean read GetUsingTLS;
    property TagData: TIdIMAP4Tag read FTagData write FTagData;
    property MailBox: TIdMailBox read FMailBox write FMailBox;
    property LoginName: string read FLoginName write FLoginName;
  end;

  { TIdIMAP4Server }
  TIdIMAP4Server = class(TIdExplicitTLSServer)
  private
    FLastCommand: TIdReplyIMAP4;  //Used to record the client command we are currently processing
  protected
    //
    FSaferMode: Boolean;                                  //See IMPLEMENTATION NOTES above
    FUseDefaultMechanismsForUnassignedCommands: Boolean;  //See IMPLEMENTATION NOTES above
    FRootPath: string;                                    //See IMPLEMENTATION NOTES above
    FDefaultPassword: string;                             //See IMPLEMENTATION NOTES above
    FMailBoxSeparator: Char;
    //
    fOnDefMechDoesImapMailBoxExist:             TIdIMAP4DefMech1;
    fOnDefMechCreateMailBox:                    TIdIMAP4DefMech1;
    fOnDefMechDeleteMailBox:                    TIdIMAP4DefMech1;
    fOnDefMechIsMailBoxOpen:                    TIdIMAP4DefMech1;
    fOnDefMechSetupMailbox:                     TIdIMAP4DefMech2;
    fOnDefMechNameAndMailBoxToPath:             TIdIMAP4DefMech3;
    fOnDefMechGetNextFreeUID:                   TIdIMAP4DefMech3;
    fOnDefMechRenameMailBox:                    TIdIMAP4DefMech4;
    fOnDefMechListMailBox:                      TIdIMAP4DefMech5;
    fOnDefMechDeleteMessage:                    TIdIMAP4DefMech6;
    fOnDefMechCopyMessage:                      TIdIMAP4DefMech7;
    fOnDefMechGetMessageSize:                   TIdIMAP4DefMech8;
    fOnDefMechGetMessageHeader:                 TIdIMAP4DefMech9;
    fOnDefMechGetMessageRaw:                    TIdIMAP4DefMech10;
    fOnDefMechOpenMailBox:                      TIdIMAP4DefMech11;
    fOnDefMechReinterpretParamAsMailBox:        TIdIMAP4DefMech12;
    fOnDefMechUpdateNextFreeUID:                TIdIMAP4DefMech13;
    fOnDefMechGetFileNameToWriteAppendMessage:  TIdIMAP4DefMech14;
    //
    fOnBeforeCmd:                   TIdIMAP4CommandBeforeEvent;
    fOnBeforeSend:                  TIdIMAP4CommandBeforeSendEvent;
    fOnCommandCAPABILITY:           TIMAP4CommandEvent;
    fONCommandNOOP:                 TIMAP4CommandEvent;
    fONCommandLOGOUT:               TIMAP4CommandEvent;
    fONCommandAUTHENTICATE:         TIMAP4CommandEvent;
    fONCommandLOGIN:                TIMAP4CommandEvent;
    fONCommandSELECT:               TIMAP4CommandEvent;
    fONCommandEXAMINE:              TIMAP4CommandEvent;
    fONCommandCREATE:               TIMAP4CommandEvent;
    fONCommandDELETE:               TIMAP4CommandEvent;
    fONCommandRENAME:               TIMAP4CommandEvent;
    fONCommandSUBSCRIBE:            TIMAP4CommandEvent;
    fONCommandUNSUBSCRIBE:          TIMAP4CommandEvent;
    fONCommandLIST:                 TIMAP4CommandEvent;
    fONCommandLSUB:                 TIMAP4CommandEvent;
    fONCommandSTATUS:               TIMAP4CommandEvent;
    fONCommandAPPEND:               TIMAP4CommandEvent;
    fONCommandCHECK:                TIMAP4CommandEvent;
    fONCommandCLOSE:                TIMAP4CommandEvent;
    fONCommandEXPUNGE:              TIMAP4CommandEvent;
    fONCommandSEARCH:               TIMAP4CommandEvent;
    fONCommandFETCH:                TIMAP4CommandEvent;
    fONCommandSTORE:                TIMAP4CommandEvent;
    fONCommandCOPY:                 TIMAP4CommandEvent;
    fONCommandUID:                  TIMAP4CommandEvent;
    fONCommandX:                    TIMAP4CommandEvent;
    fOnCommandError:                TIMAP4CommandEvent;
    //
    function CreateExceptionReply: TIdReply; override;
    function CreateGreeting: TIdReply; override;
    function CreateHelpReply: TIdReply; override;
    function CreateMaxConnectionReply: TIdReply; override;
    function CreateReplyUnknownCommand: TIdReply; override;
    //The following are internal commands that help support the IMAP protocol...
    procedure InitializeCommandHandlers; override;
    function  GetReplyClass:TIdReplyClass; override;
    function  GetRepliesClass:TIdRepliesClass; override;
    procedure SendGreeting(AContext: TIdContext; AGreeting: TIdReply); override;
    procedure SendWrongConnectionState(ASender: TIdCommand);
    procedure SendUnsupportedCommand(ASender: TIdCommand);
    procedure SendIncorrectNumberOfParameters(ASender: TIdCommand);
    procedure SendUnassignedDefaultMechanism(ASender: TIdCommand);
    procedure DoReplyUnknownCommand(AContext: TIdContext; AText: string); override;
    procedure SendErrorOpenedReadOnly(ASender: TIdCommand);
    procedure SendOkCompleted(ASender: TIdCommand);
    procedure SendBadReply(ASender: TIdCommand; AText: string);
    procedure SendNoReply(ASender: TIdCommand; AText: string);
    //
    //The following are used internally by the default mechanism...
    function  ExpungeRecords(ASender: TIdCommand): Boolean;
    function  MessageSetToMessageNumbers(AUseUID: Boolean; ASender: TIdCommand; var AMessageNumbers: TIdStringList; AMessageSet: string): Boolean;
    function  GetRecordForUID(AMessageNumber: integer; AMailBox: TIdMailBox): integer;
    procedure ProcessFetch(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
    procedure ProcessCopy(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
    function  ProcessStore(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList): Boolean;
    procedure ProcessSearch(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
    function  FlagStringToFlagList(var AFlagList: TIdStringList; AFlagString: string): Boolean;
    function  StripQuotesIfNecessary(AName: string): string;
    function  ReassembleParams(ASeparator: char; var AParams: TIdStringList; AParamToReassemble: integer): Boolean;
    function  ReinterpretParamAsMailBox(var AParams: TIdStringList; AMailBoxParam: integer): Boolean;
    function  ReinterpretParamAsFlags(var AParams: TIdStringList; AFlagsParam: integer): Boolean;
    function  ReinterpretParamAsDataItems(var AParams: TIdStringList; AFlagsParam: integer): Boolean;
    //
    //The following are used internally by our default mechanism and are copies of
    //the same function in TIdIMAP4 (move to a base class?)...
    function  MessageFlagSetToStr(const AFlags: TIdMessageFlagsSet): String;
    //
    //DoBeforeCmd & DoSendReply are useful for a server to log all commands and
    //responses for debugging...
    procedure DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
    procedure DoSendReply(AContext: TIdContext; AData: string);
    //
    //Command handlers...
    procedure DoCmdHandlersException(ACommand: String; AContext: TIdContext);
    procedure DoCommandCAPABILITY(ASender: TIdCommand);
    procedure DoCommandNOOP(ASender: TIdCommand);
    procedure DoCommandLOGOUT(ASender: TIdCommand);
    procedure DoCommandAUTHENTICATE(ASender: TIdCommand);
    procedure DoCommandLOGIN(ASender: TIdCommand);
    procedure DoCommandSELECT(ASender: TIdCommand);
    procedure DoCommandEXAMINE(ASender: TIdCommand);
    procedure DoCommandCREATE(ASender: TIdCommand);
    procedure DoCommandDELETE(ASender: TIdCommand);
    procedure DoCommandRENAME(ASender: TIdCommand);
    procedure DoCommandSUBSCRIBE(ASender: TIdCommand);
    procedure DoCommandUNSUBSCRIBE(ASender: TIdCommand);
    procedure DoCommandLIST(ASender: TIdCommand);
    procedure DoCommandLSUB(ASender: TIdCommand);
    procedure DoCommandSTATUS(ASender: TIdCommand);
    procedure DoCommandAPPEND(ASender: TIdCommand);
    procedure DoCommandCHECK(ASender: TIdCommand);
    procedure DoCommandCLOSE(ASender: TIdCommand);
    procedure DoCommandEXPUNGE(ASender: TIdCommand);
    procedure DoCommandSEARCH(ASender: TIdCommand);
    procedure DoCommandFETCH(ASender: TIdCommand);
    procedure DoCommandSTORE(ASender: TIdCommand);
    procedure DoCommandCOPY(ASender: TIdCommand);
    procedure DoCommandUID(ASender: TIdCommand);
    procedure DoCommandX(ASender: TIdCommand);
    procedure DoCommandSTARTTLS(ASender: TIdCommand);
    // common code for command handlers
    procedure MustUseTLS(ASender: TIdCommand);
    //
    procedure InitComponent; override;
  public
    destructor Destroy; override;
  published
    property SaferMode: Boolean read FSaferMode write FSaferMode default False;
    property UseDefaultMechanismsForUnassignedCommands: Boolean read FUseDefaultMechanismsForUnassignedCommands write FUseDefaultMechanismsForUnassignedCommands default True;
    property RootPath: string read FRootPath write FRootPath;
    property DefaultPassword: string read FDefaultPassword write FDefaultPassword;
    property MailBoxSeparator: Char read FMailBoxSeparator;
    {Default mechansisms}
    property OnDefMechDoesImapMailBoxExist: TIdIMAP4DefMech1 read fOnDefMechDoesImapMailBoxExist write fOnDefMechDoesImapMailBoxExist;
    property OnDefMechCreateMailBox: TIdIMAP4DefMech1 read fOnDefMechCreateMailBox write fOnDefMechCreateMailBox;
    property OnDefMechDeleteMailBox: TIdIMAP4DefMech1 read fOnDefMechDeleteMailBox write fOnDefMechDeleteMailBox;
    property OnDefMechIsMailBoxOpen: TIdIMAP4DefMech1 read fOnDefMechIsMailBoxOpen write fOnDefMechIsMailBoxOpen;
    property OnDefMechSetupMailbox: TIdIMAP4DefMech2 read fOnDefMechSetupMailbox write fOnDefMechSetupMailbox;
    property OnDefMechNameAndMailBoxToPath: TIdIMAP4DefMech3 read fOnDefMechNameAndMailBoxToPath write fOnDefMechNameAndMailBoxToPath;
    property OnDefMechGetNextFreeUID: TIdIMAP4DefMech3 read fOnDefMechGetNextFreeUID write fOnDefMechGetNextFreeUID;
    property OnDefMechRenameMailBox: TIdIMAP4DefMech4 read fOnDefMechRenameMailBox write fOnDefMechRenameMailBox;
    property OnDefMechListMailBox: TIdIMAP4DefMech5 read fOnDefMechListMailBox write fOnDefMechListMailBox;
    property OnDefMechDeleteMessage: TIdIMAP4DefMech6 read fOnDefMechDeleteMessage write fOnDefMechDeleteMessage;
    property OnDefMechCopyMessage: TIdIMAP4DefMech7 read fOnDefMechCopyMessage write fOnDefMechCopyMessage;
    property OnDefMechGetMessageSize: TIdIMAP4DefMech8 read fOnDefMechGetMessageSize write fOnDefMechGetMessageSize;
    property OnDefMechGetMessageHeader: TIdIMAP4DefMech9 read fOnDefMechGetMessageHeader write fOnDefMechGetMessageHeader;
    property OnDefMechGetMessageRaw: TIdIMAP4DefMech10 read fOnDefMechGetMessageRaw write fOnDefMechGetMessageRaw;
    property OnDefMechOpenMailBox:TIdIMAP4DefMech11 read fOnDefMechOpenMailBox write fOnDefMechOpenMailBox;
    property OnDefMechReinterpretParamAsMailBox:TIdIMAP4DefMech12 read fOnDefMechReinterpretParamAsMailBox write fOnDefMechReinterpretParamAsMailBox;
    property OnDefMechUpdateNextFreeUID: TIdIMAP4DefMech13 read fOnDefMechUpdateNextFreeUID write fOnDefMechUpdateNextFreeUID;
    property OnDefMechGetFileNameToWriteAppendMessage: TIdIMAP4DefMech14 read fOnDefMechGetFileNameToWriteAppendMessage write fOnDefMechGetFileNameToWriteAppendMessage;
    { Events }
    property OnBeforeCmd: TIdIMAP4CommandBeforeEvent read fOnBeforeCmd write fOnBeforeCmd;
    property OnBeforeSend: TIdIMAP4CommandBeforeSendEvent read fOnBeforeSend write fOnBeforeSend;
    property OnCommandCAPABILITY: TIMAP4CommandEvent read fOnCommandCAPABILITY write fOnCommandCAPABILITY;
    property OnCommandNOOP: TIMAP4CommandEvent read fONCommandNOOP write fONCommandNOOP;
    property OnCommandLOGOUT: TIMAP4CommandEvent read fONCommandLOGOUT write fONCommandLOGOUT;
    property OnCommandAUTHENTICATE: TIMAP4CommandEvent read fONCommandAUTHENTICATE write fONCommandAUTHENTICATE;
    property OnCommandLOGIN: TIMAP4CommandEvent read fONCommandLOGIN write fONCommandLOGIN;
    property OnCommandSELECT: TIMAP4CommandEvent read fONCommandSELECT write fONCommandSELECT;
    property OnCommandEXAMINE:TIMAP4CommandEvent read fOnCommandEXAMINE write fOnCommandEXAMINE;
    property OnCommandCREATE: TIMAP4CommandEvent read fONCommandCREATE write fONCommandCREATE;
    property OnCommandDELETE: TIMAP4CommandEvent read fONCommandDELETE write fONCommandDELETE;
    property OnCommandRENAME: TIMAP4CommandEvent read fOnCommandRENAME write fOnCommandRENAME;
    property OnCommandSUBSCRIBE: TIMAP4CommandEvent read fONCommandSUBSCRIBE write fONCommandSUBSCRIBE;
    property OnCommandUNSUBSCRIBE: TIMAP4CommandEvent read fONCommandUNSUBSCRIBE write fONCommandUNSUBSCRIBE;
    property OnCommandLIST: TIMAP4CommandEvent read fONCommandLIST write fONCommandLIST;
    property OnCommandLSUB: TIMAP4CommandEvent read fOnCommandLSUB write fOnCommandLSUB;
    property OnCommandSTATUS: TIMAP4CommandEvent read fONCommandSTATUS write fONCommandSTATUS;
    property OnCommandAPPEND: TIMAP4CommandEvent read fOnCommandAPPEND write fOnCommandAPPEND;
    property OnCommandCHECK: TIMAP4CommandEvent read fONCommandCHECK write fONCommandCHECK;
    property OnCommandCLOSE: TIMAP4CommandEvent read fOnCommandCLOSE write fOnCommandCLOSE;
    property OnCommandEXPUNGE: TIMAP4CommandEvent read fONCommandEXPUNGE write fONCommandEXPUNGE;
    property OnCommandSEARCH: TIMAP4CommandEvent read fOnCommandSEARCH write fOnCommandSEARCH;
    property OnCommandFETCH: TIMAP4CommandEvent read fONCommandFETCH write fONCommandFETCH;
    property OnCommandSTORE: TIMAP4CommandEvent read fOnCommandSTORE write fOnCommandSTORE;
    property OnCommandCOPY: TIMAP4CommandEvent read fOnCommandCOPY write fOnCommandCOPY;
    property OnCommandUID: TIMAP4CommandEvent read fONCommandUID write fONCommandUID;
    property OnCommandX: TIMAP4CommandEvent read fOnCommandX write fOnCommandX;
    property OnCommandError: TIMAP4CommandEvent read fOnCommandError write fOnCommandError;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  IdMessageCollection,
  IdResourceStrings,
  IdResourceStringsProtocols,
  IdSSL,
  IdStreamVCL,
  IdSys;

function TIdIMAP4Server.GetReplyClass: TIdReplyClass;
begin
  Result := TIdReplyIMAP4;
end;

function TIdIMAP4Server.GetRepliesClass: TIdRepliesClass;
begin
  Result := TIdRepliesIMAP4;
end;

procedure TIdIMAP4Server.SendGreeting(AContext: TIdContext; AGreeting: TIdReply);
begin
  if FSaferMode then begin
    DoSendReply(AContext, '* OK');     {Do not Localize}
  end else begin
    DoSendReply(AContext, '* OK Indy IMAP server version '+Self.GetVersion); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.SendWrongConnectionState(ASender: TIdCommand);
begin
  SendNoReply(ASender, 'Wrong connection state'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendErrorOpenedReadOnly(ASender: TIdCommand);
begin
  SendNoReply(ASender, 'Mailbox was opened read-only'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendUnsupportedCommand(ASender: TIdCommand);
begin
  SendBadReply(ASender, 'Unsupported command'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendIncorrectNumberOfParameters(ASender: TIdCommand);
begin
  SendBadReply(ASender, 'Incorrect number of parameters'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendUnassignedDefaultMechanism(ASender: TIdCommand);
begin
  SendBadReply(ASender, 'Server internal error: unassigned procedure'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendOkCompleted(ASender: TIdCommand);
begin
  DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' OK Completed'); {Do not Localize}
end;

procedure TIdIMAP4Server.SendBadReply(ASender: TIdCommand; AText: string);
begin
  DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' BAD '+AText); {Do not Localize}
end;

procedure TIdIMAP4Server.SendNoReply(ASender: TIdCommand; AText: string);
begin
  DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' NO '+AText); {Do not Localize}
end;

procedure TIdIMAP4Server.InitComponent;
begin
  inherited;
  //Todo:  Not sure which number is appropriate.  Should be tested
  FImplicitTLSProtPort := IdPORT_IMAP4S;  //Id_PORT_imap4_ssl_dp;
  FRegularProtPort := IdPORT_IMAP4;
  DefaultPort := IdPORT_IMAP4;
  ContextClass := TIdIMAP4PeerContext;
  FSaferMode := False;
  FUseDefaultMechanismsForUnassignedCommands := True;
  if FRootPath = '' then begin
{$IFDEF LINUX}
    FRootPath := GPathDelim+'var'+PathDelim+'imapmail'; {Do not Localize}
{$ELSE}
    FRootPath := GPathDelim+'imapmail'; {Do not Localize}
{$ENDIF}
  end;
  if FDefaultPassword = '' then begin
    FDefaultPassword := 'admin'; {Do not Localize}
  end;
  FLastCommand := TIdReplyIMAP4.Create;
  FMailBoxSeparator := '.';   {Do not Localize}
end;

destructor TIdIMAP4Server.Destroy;
begin
  Sys.FreeAndNil(FLastCommand);
  inherited;
end;

function TIdIMAP4Server.CreateExceptionReply: TIdReply;
begin
  Result := TIdReplyIMAP4.Create(nil, ReplyTexts);
  Result.SetReply('BAD', 'Unknown Internal Error'); {do not localize}
end;

function TIdIMAP4Server.CreateGreeting: TIdReply;
begin
  Result := TIdReplyIMAP4.Create(nil, ReplyTexts);
  Result.SetReply('OK', 'Welcome'); {do not localize}
end;

function TIdIMAP4Server.CreateHelpReply: TIdReply;
begin
  Result := TIdReplyIMAP4.Create(nil, ReplyTexts);
  Result.SetReply('OK', 'Help follows'); {do not localize}
end;

function TIdIMAP4Server.CreateMaxConnectionReply: TIdReply;
begin
  Result := TIdReplyIMAP4.Create(nil, ReplyTexts);
  Result.SetReply('BAD', 'Too many connections. Try again later.'); {do not localize}
end;

function TIdIMAP4Server.CreateReplyUnknownCommand: TIdReply;
begin
  Result := TIdReplyIMAP4.Create(nil, ReplyTexts);
  Result.SetReply('BAD', 'Unknown command'); {do not localize}
end;

constructor TIdIMAP4PeerContext.Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FTagData := TIdIMAP4Tag.Create;
  FConnectionState := csAny;
end;

destructor TIdIMAP4PeerContext.Destroy;
begin
  Sys.FreeAndNil(FTagData);
  inherited;
end;

function TIdIMAP4PeerContext.GetUsingTLS:boolean;
begin
  Result:=Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if result then
    Result:=not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
end;

procedure TIdIMAP4Server.DoReplyUnknownCommand(AContext: TIdContext; AText: string);
//AText is ignored by TIdIMAP4Server
var
  LText: string;
begin
  LText := '';
  if FLastCommand.SequenceNumber = '' then begin
    //This should not happen!
    LText := '*';    {Do not Localize}
  end else begin
    LText := FLastCommand.SequenceNumber;
  end;
  LText := LText + ' NO Unknown command'; {Do not Localize}
  DoSendReply(AContext, LText);
end;

function  TIdIMAP4Server.ExpungeRecords(ASender: TIdCommand): Boolean;
var
  LN: integer;
begin
  //Delete all records that have the deleted flag set...
  LN := 0;
  Result := True;
  while LN < TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Count do begin
    if mfDeleted in TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].Flags then begin
      if OnDefMechDeleteMessage(TIdIMAP4PeerContext(ASender.Context).FLoginName,
       TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
       TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN]) = False then begin
        Result := False;
      end;
      TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Delete(LN);
      TIdIMAP4PeerContext(ASender.Context).FMailBox.TotalMsgs :=
       TIdIMAP4PeerContext(ASender.Context).FMailBox.TotalMsgs - 1;
    end else begin
      Inc(LN);
    end;
  end;
end;

function  TIdIMAP4Server.MessageSetToMessageNumbers(AUseUID: Boolean; ASender: TIdCommand; var AMessageNumbers: TIdStringList; AMessageSet: string): Boolean;
{AMessageNumbers may be '7' or maybe '2:4' (2, 3 & 4) or maybe '2,4,6' (2, 4 & 6)
or maybe '1:*'}
var
  LPos: integer;
  LStart: integer;
  LN: integer;
  LEnd: integer;
  LTemp: string;
begin
  AMessageNumbers.Clear;
  //See is it a sequence like 2:4 ...
  LPos := IndyPos(':', AMessageSet);      {Do not Localize}
  if LPos > 0 then begin
    LTemp := Copy(AMessageSet, 1, LPos-1);
    LStart := Sys.StrToInt(LTemp);
    LTemp := Copy(AMessageSet, LPos+1, MAXINT);
    if LTemp = '*' then begin  {Do not Localize}
      if AUseUID = True then begin
        LEnd := Sys.StrToInt(TIdIMAP4PeerContext(ASender.Context).FMailBox.UIDNext)-1;
        for LN := LStart to LEnd do begin
          AMessageNumbers.Add(Sys.IntToStr(LN));
        end;
      end else begin
        LEnd := TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Count;
        for LN := LStart to LEnd do begin
          AMessageNumbers.Add(Sys.IntToStr(LN));
        end;
      end;
    end else begin
      LEnd := Sys.StrToInt(LTemp);
      for LN := LStart to LEnd do begin
        AMessageNumbers.Add(Sys.IntToStr(LN));
      end;
    end;
  end else begin
    //See is it a comma-separated list...
    LPos := IndyPos(',', AMessageSet);        {Do not Localize}
    if LPos = 0 then begin
      AMessageNumbers.Add(AMessageSet);
    end else begin
      BreakApart(AMessageSet, ',', AMessageNumbers); {Do not Localize}
    end;
  end;
  Result := True;
end;

function TIdIMAP4Server.GetRecordForUID(AMessageNumber: integer; AMailBox: TIdMailBox): integer;
  //Return -1 if not found
var
  LN: integer;
begin
  for LN := 0 to AMailBox.MessageList.Count-1 do begin
    if Sys.StrToInt(AMailBox.MessageList.Messages[LN].UID) = AMessageNumber then begin
      Result := LN;
      Exit;
    end;
  end;
  Result := -1;
end;

function  TIdIMAP4Server.StripQuotesIfNecessary(AName: string): string;
begin
  Result := AName;
  if Length(Result) < 1 then begin
    Exit;
  end;
  if ((Result[1] = '"') and (Result[Length(Result)] = '"')) then begin  {Do not Localize}
    Result := Copy(Result, 2, Length(Result)-2);
  end;
end;

function  TIdIMAP4Server.ReassembleParams(ASeparator: char; var AParams: TIdStringList; AParamToReassemble: integer): Boolean;
label
  GetAnotherParam;
var
  LEndSeparator: char;
  LTemp: string;
  LN: integer;
  LReassembledParam: string;
begin
  case ASeparator of
   '(': LEndSeparator := ')';           {Do not Localize}
   '[': LEndSeparator := ']';           {Do not Localize}
   else LEndSeparator := ASeparator;
  end;
  LTemp := AParams[AParamToReassemble];
  if LTemp[1] <> ASeparator then begin
    Result := False;
    Exit;
  end;
  if LTemp[Length(LTemp)] = LEndSeparator then begin
    AParams[AParamToReassemble] := Copy(LTemp, 2, Length(LTemp)-2);
    Result := True;
    Exit;
  end;
  LReassembledParam := Copy(LTemp, 2, MAXINT);
  LN := AParamToReassemble + 1;
 GetAnotherParam:
  if LN >= AParams.Count - 1 then begin
    Result := False;
    Exit;  //Error
  end;
  LTemp := AParams[LN];
  AParams.Delete(LN);
  if LTemp[Length(LTemp)] = LEndSeparator then begin
    AParams[AParamToReassemble] := LReassembledParam + ' ' + Copy(LTemp, 1, Length(LTemp)-1);  {Do not Localize}
    Result := True;
    Exit;  //This is example 1
  end;
  LReassembledParam := LReassembledParam + ' ' + LTemp;  {Do not Localize}
  goto GetAnotherParam;
end;

function  TIdIMAP4Server.ReinterpretParamAsMailBox(var AParams: TIdStringList; AMailBoxParam: integer): Boolean;
var
  LTemp: string;
begin
  //This reorganises the parameter list on the basis that AMailBoxParam is a
  //mailbox name, which may (if enclosed in quotes) be in more than one param.
  //Example 1: '43' '"My' 'Documents"' '5' -> '43' 'My Documents' '5'
  //Example 2: '43' '"MyDocs"' '5'         -> '43' 'MyDocs' '5'
  //Example 3: '43' 'MyDocs' '5'           -> '43' 'MyDocs' '5'
  if AMailBoxParam > AParams.Count - 1 then begin
    Result := False;
    Exit;  //Error
  end;
  if AParams[AMailBoxParam] = '' then begin
    Result := False;
    Exit;  //Error
  end;
  LTemp := AParams[AMailBoxParam];
  if LTemp[1] <> '"' then begin   {Do not Localize}
    Result := True;
    Exit;  //This is example 3, no change.
  end;
  Result := ReassembleParams('"', AParams, AMailBoxParam);  {Do not Localize}
end;

function  TIdIMAP4Server.ReinterpretParamAsFlags(var AParams: TIdStringList; AFlagsParam: integer): Boolean;
begin
  Result := ReassembleParams('(', AParams, AFlagsParam);  {Do not Localize}
end;

function  TIdIMAP4Server.ReinterpretParamAsDataItems(var AParams: TIdStringList; AFlagsParam: integer): Boolean;
begin
  Result := ReassembleParams('(', AParams, AFlagsParam);  {Do not Localize}
end;

function  TIdIMAP4Server.FlagStringToFlagList(var AFlagList: TIdStringList; AFlagString: string): Boolean;
var
  LTemp: string;
begin
  Result := False;
  LTemp := AFlagString;
  if ( (LTemp[1] <> '(') or (LTemp[Length(LTemp)] <> ')') ) then begin  {Do not Localize}
    Exit;
  end;
  LTemp := Copy(LTemp, 2, Length(LTemp)-2);
  AFlagList.Clear;
  BreakApart(LTemp, ' ', AFlagList); {Do not Localize}
  Result := True;
end;

procedure TIdIMAP4Server.ProcessFetch(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
//There are a pile of options for this.
var
  LMessageNumbers: TIdStringList;
  LDataItems: TIdStringList;
  LM: integer;
  LN: integer;
  LO: integer;
  LRecord: integer;
  LSize: integer;
  LMessage: TIdMessage;
  LMessageRaw: TIdStringList;
  LTemp: string;
begin
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TIdStringList.Create;
  if MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) = False then begin
    SendBadReply(ASender, 'Error in synthax of message set parameter'); {Do not Localize}
    LMessageNumbers.Free;
    Exit;
  end;
  if ReinterpretParamAsDataItems(AParams, 1) = False then begin
    SendBadReply(ASender, 'Fetch data items parameter is invalid.'); {Do not Localize}
    Exit;
  end;
  LDataItems := TIdStringList.Create;
  BreakApart(AParams[1], ' ', LDataItems);
  for LN := 0 to LMessageNumbers.Count-1 do begin
    if AUseUID = False then begin
      LRecord := Sys.StrToInt(LMessageNumbers[LN])-1;
    end else begin
      LRecord := GetRecordForUID(Sys.StrToInt(LMessageNumbers[LN]), TIdIMAP4PeerContext(ASender.Context).FMailBox);
      if LRecord = -1 then continue; //It is OK to skip non-existent UID records
    end;
    if ( (LRecord < 0) or (LRecord > TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Count) ) then begin
      SendBadReply(ASender, 'Message number '+Sys.IntToStr(LRecord+1)+' does not exist'); {Do not Localize}
      LMessageNumbers.Free;
      LDataItems.Free;
      Exit;
    end;
    for LO := 0 to LDataItems.Count-1 do begin
      if LDataItems[LO] = 'UID' then begin  {Do not Localize}
        //Format:
        //C9 FETCH 490 (UID)
        //* 490 FETCH (UID 6545)
        //C9 OK Completed
        DoSendReply(ASender.Context, '* FETCH (UID ' + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].UID + ')'); {Do not Localize}
      end else if LDataItems[LO] = 'FLAGS' then begin  {Do not Localize}
        //Format:
        //C10 UID FETCH 6545 (FLAGS)
        //* 490 FETCH (FLAGS (\Recent) UID 6545)
        //C10 OK Completed
        LTemp := '* ' + Sys.IntToStr(LRecord+1) + ' FETCH (FLAGS ('  {Do not Localize}
         +Sys.Trim(MessageFlagSetToStr(TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags));
        if AUseUID = False then begin
          LTemp := LTemp + '))';  {Do not Localize}
        end else begin
          LTemp := LTemp + ') UID '+LMessageNumbers[LN]+')';  {Do not Localize}
        end;
        DoSendReply(ASender.Context, LTemp);
      end else if LDataItems[LO] = 'RFC822.HEADER' then begin  {Do not Localize}
        //Format:
        //C11 UID FETCH 6545 (RFC822.HEADER)
        //* 490 FETCH (UID 6545 RFC822.HEADER {1654}
        //Return-Path: <Christina_Powell@secondhandcars.com>
        //...
        //Content-Type: multipart/alternative;
        //	boundary="----=_NextPart_000_70BE_C8606D03.F4EA24EE"
        //C10 OK Completed
        //We don't want to thrash UIDs and flags in MailBox message, so load into LMessage
        LMessage := TIdMessage.Create;
        if OnDefMechGetMessageHeader(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord],
         LMessage) = False then begin
          SendNoReply(ASender, 'Failed to get message header'); {Do not Localize}
          LMessage.Free;
          LMessageNumbers.Free;
          LDataItems.Free;
          Exit;
        end;
        //Need to calculate the size of the headers...
        LSize := 0;
        for LM := 0 to LMessage.Headers.Count-1 do begin
          LSize := LSize + Length(LMessage.Headers.Strings[LM]) + 2; //Allow for CR+LF
        end;
        LTemp := '* ' + Sys.IntToStr(LRecord+1) + ' FETCH (';  {Do not Localize}
        if AUseUID = True then begin
          LTemp := LTemp + 'UID '+LMessageNumbers[LN]+' ';  {Do not Localize}
        end;
        LTemp := LTemp + 'RFC822.HEADER {'+Sys.IntToStr(LSize)+'}';  {Do not Localize}
        DoSendReply(ASender.Context, LTemp);
        for LM := 0 to LMessage.Headers.Count-1 do begin
          DoSendReply(ASender.Context, LMessage.Headers.Strings[LM]);
        end;
        DoSendReply(ASender.Context, ')');  {Do not Localize}
        //Finished with the headers, free the memory...
        LMessage.Free;
      end else if LDataItems[LO] = 'RFC822.SIZE' then begin  {Do not Localize}
        //Format:
        //C12 UID FETCH 6545 (RFC822.SIZE)
        //* 490 FETCH (UID 6545 RFC822.SIZE 3447)
        //C12 OK Completed
        LSize := OnDefMechGetMessageSize(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord]);
        if LSize = -1 then begin
          SendNoReply(ASender, 'Failed to get message size'); {Do not Localize}
          LMessageNumbers.Free;
          LDataItems.Free;
          Exit;
        end;
        LTemp := '* ' + Sys.IntToStr(LRecord+1) + ' FETCH (';  {Do not Localize}
        if AUseUID = True then begin
          LTemp := LTemp + 'UID '+LMessageNumbers[LN]+' ';  {Do not Localize}
        end;
        LTemp := LTemp + 'RFC822.SIZE '+Sys.IntToStr(LSize)+')';  {Do not Localize}
        DoSendReply(ASender.Context, LTemp);
      end else if ( (LDataItems[LO] = 'BODY.PEEK[]') or (LDataItems[LO] = 'BODY[]') or (LDataItems[LO] = 'RFC822') or (LDataItems[LO] = 'RFC822.PEEK') ) then begin  {Do not Localize}
        //All are the same, except the return string is different...
        //Get a pointer to the message rather than repetitively calculating it (or typing it in!)...
        LMessage := TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord];
        LMessageRaw := TIdStringList.Create;
        if OnDefMechGetMessageRaw(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         LMessage,
         LMessageRaw) = False then begin
          SendNoReply(ASender, 'Failed to get raw message'); {Do not Localize}
          LMessageRaw.Free;
          LMessageNumbers.Free;
          LDataItems.Free;
          Exit;
        end;
        LSize := 0;
        for LM := 0 to LMessage.Headers.Count-1 do begin
          LSize := LSize + Length(LMessageRaw.Strings[LM]) + 2; //Allow for CR+LF
        end;
        LSize := LSize + 3;  //The message terminator '.CRLF'
        LTemp := '* ' + Sys.IntToStr(LRecord+1) + ' FETCH (';  {Do not Localize}
        LTemp := LTemp + 'FLAGS ('  {Do not Localize}
         + Sys.Trim(MessageFlagSetToStr(TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags))
         + ') ';  {Do not Localize}
        if AUseUID = True then begin
          LTemp := LTemp + 'UID '+LMessageNumbers[LN]+' ';  {Do not Localize}
        end;
        LTemp := LTemp + Copy(AParams[1], 2, Length(AParams[1])-2)+' {'+Sys.IntToStr(LSize)+'}';  {Do not Localize}
        DoSendReply(ASender.Context, LTemp);
        for LM := 0 to LMessage.Headers.Count-1 do begin
          DoSendReply(ASender.Context, LMessageRaw.Strings[LM]);
        end;
        DoSendReply(ASender.Context, '.');  {Do not Localize}
        DoSendReply(ASender.Context, ')');  {Do not Localize}
        //Free the memory...
        LMessageRaw.Free;
      end else if LDataItems[LO] = 'BODYSTRUCTURE' then begin  {Do not Localize}
        //Format:
        //C49 UID FETCH 6545 (BODYSTRUCTURE)
        //* 490 FETCH (UID 6545 BODYSTRUCTURE (("TEXT" "PLAIN" ("CHARSET" "iso-8859-1") NIL NIL "7BIT" 290 8 NIL NIL NIL)("TEXT" "HTML" ("CHARSET" "iso-8859-1") NIL NIL "7BIT" 1125 41 NIL NIL NIL) "ALTERNATIVE" ("BOUNDARY"
        //C12 OK Completed



        SendBadReply(ASender, 'Parameter not supported: '+AParams[1]); {Do not Localize}
      end else if ( (Copy(LDataItems[LO],1,6) = 'BODY[') or (Copy(LDataItems[LO],1,11) = 'BODY.PEEK[') ) then begin  {Do not Localize}
        //Format:
        //C50 UID FETCH 6545 (BODY[1])
        //* 490 FETCH (FLAGS (\Recent \Seen) UID 6545 BODY[1] {290}
        //...
        //)
        //C50 OK Completed



        SendBadReply(ASender, 'Parameter not supported: '+AParams[1]); {Do not Localize}
      end else begin
        SendBadReply(ASender, 'Parameter not supported: '+AParams[1]); {Do not Localize}
        LMessageNumbers.Free;
        LDataItems.Free;
        Exit;
      end;
    end;
  end;
  LDataItems.Free;
  LMessageNumbers.Free;
  SendOkCompleted(ASender);
end;

procedure TIdIMAP4Server.ProcessSearch(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
//if AUseUID is True, return UIDs rather than relative message numbers.
var
  //LParams: TIdStringList;
  LSearchString: string;
  LN: integer;
  LM: integer;
  LMessage: TIdMessage;
  LHits: string;
begin
  //Watch out: you could become an old man trying to implement all the IMAP
  //search options, just do a subset.
  //Format:
  //C1065 UID SEARCH FROM "visible"
  //* SEARCH 5769 5878
  //C1065 OK Completed (2 msgs in 0.010 secs)
  //LParams := TIdStringList.Create;
  //BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
  if AParams.Count < 2 then begin  //The only search options we support are 2-param ones
    SendIncorrectNumberOfParameters(ASender);
    //LParams.Free;
    Exit;
  end;
  if (
   (Sys.UpperCase(AParams[0]) <> 'FROM') and  {Do not Localize}
   (Sys.UpperCase(AParams[0]) <> 'TO') and    {Do not Localize}
   (Sys.UpperCase(AParams[0]) <> 'CC') and    {Do not Localize}
   (Sys.UpperCase(AParams[0]) <> 'BCC') and   {Do not Localize}
   (Sys.UpperCase(AParams[0]) <> 'SUBJECT')   {Do not Localize}
   ) then begin
    SendBadReply(ASender, 'Unsupported search method'); {Do not Localize}
    //LParams.Free;
    Exit;
  end;
  //Reassemble the other params into a line, because "Ciaran Costelloe" will be params 1 & 2...
  LSearchString := AParams[1];
  for LN := 2 to AParams.Count-1 do begin
    LSearchString := LSearchString + ' ' + AParams[LN];  {Do not Localize}
  end;
  if ( (LSearchString[1] = '"') and (LSearchString[Length(LSearchString)] = '"') ) then begin  {Do not Localize}
    LSearchString := Copy(LSearchString, 2, Length(LSearchString)-2);
  end;

  LMessage := TIdMessage.Create;
  for LN := 0 to TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Count-1 do begin
    if OnDefMechGetMessageHeader(TIdIMAP4PeerContext(ASender.Context).FLoginName,
     TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
     TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN],
     LMessage) = False then begin
      SendNoReply(ASender, 'Failed to get message header'); {Do not Localize}
      LMessage.Free;
      //LParams.Free;
      Exit;
    end;
    if Sys.UpperCase(AParams[0]) = 'FROM' then begin  {Do not Localize}
      if Pos(Sys.UpperCase(LSearchString), Sys.UpperCase(LMessage.From.Address)) > 0 then begin
        if AUseUID = False then begin
          LHits := LHits + Sys.IntToStr(LN+1) + ' ';  {Do not Localize}
        end else begin
          LHits := LHits + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].UID + ' ';  {Do not Localize}
        end;
      end;
    end else if Sys.UpperCase(AParams[0]) = 'TO' then begin  {Do not Localize}
      for LM := 0 to LMessage.Recipients.Count-1 do begin
        if Pos(Sys.UpperCase(LSearchString), Sys.UpperCase(LMessage.Recipients.Items[LM].Address)) > 0 then begin
          if AUseUID = False then begin
            LHits := LHits + Sys.IntToStr(LN+1) + ' ';  {Do not Localize}
          end else begin
            LHits := LHits + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].UID + ' ';  {Do not Localize}
          end;
          break; //Don't want more than 1 hit on this record
        end;
      end;
    end else if Sys.UpperCase(AParams[0]) = 'CC' then begin  {Do not Localize}
      for LM := 0 to LMessage.Recipients.Count-1 do begin
        if Pos(Sys.UpperCase(LSearchString), Sys.UpperCase(LMessage.CCList.Items[LM].Address)) > 0 then begin
          if AUseUID = False then begin
            LHits := LHits + Sys.IntToStr(LN+1) + ' ';  {Do not Localize}
          end else begin
            LHits := LHits + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].UID + ' ';  {Do not Localize}
          end;
          break; //Don't want more than 1 hit on this record
        end;
      end;
    end else if Sys.UpperCase(AParams[0]) = 'BCC' then begin  {Do not Localize}
      for LM := 0 to LMessage.Recipients.Count-1 do begin
        if Pos(Sys.UpperCase(LSearchString), Sys.UpperCase(LMessage.BCCList.Items[LM].Address)) > 0 then begin
          if AUseUID = False then begin
            LHits := LHits + Sys.IntToStr(LN+1) + ' ';  {Do not Localize}
          end else begin
            LHits := LHits + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].UID + ' ';  {Do not Localize}
          end;
          break; //Don't want more than 1 hit on this record
        end;
      end;
    end else if Sys.UpperCase(AParams[0]) = 'SUBJECT' then begin  {Do not Localize}
      if Pos(Sys.UpperCase(LSearchString), Sys.UpperCase(LMessage.Subject)) > 0 then begin
        if AUseUID = False then begin
          LHits := LHits + Sys.IntToStr(LN+1) + ' ';  {Do not Localize}
        end else begin
          LHits := LHits + TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LN].UID + ' ';  {Do not Localize}
        end;
      end;
    end;
  end;
  LMessage.Free;
  //LParams.Free;
  Sys.Trim(LHits);
  DoSendReply(ASender.Context, '* SEARCH '+LHits); {Do not Localize}
  SendOkCompleted(ASender);
end;

procedure TIdIMAP4Server.ProcessCopy(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList);
var
  LMessageNumbers: TIdStringList;
  LN: integer;
  LRecord: integer;
  LResult: Boolean;
begin
  //Format is "C1 COPY 2:4 MEETINGFOLDER"
  if OnDefMechReinterpretParamAsMailBox(AParams, 1) = False then begin
    SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
    Exit;
  end;
  if AParams.Count <> 2 then begin
    SendIncorrectNumberOfParameters(ASender);
    Exit;
  end;
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TIdStringList.Create;
  if MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) = False then begin
    SendBadReply(ASender, 'Error in synthax of message set parameter'); {Do not Localize}
    LMessageNumbers.Free;
    Exit;
  end;
  if not Assigned(OnDefMechDoesImapMailBoxExist) then begin
    SendUnassignedDefaultMechanism(ASender);
    LMessageNumbers.Free;
    Exit;
  end;
  if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, AParams[1]) = False then begin
    SendNoReply(ASender, 'NO Mailbox does not exist.'); {Do not Localize}
    LMessageNumbers.Free;
    Exit;
  end;
  LResult := True;
  for LN := 0 to LMessageNumbers.Count-1 do begin
    if AUseUID = False then begin
      LRecord := Sys.StrToInt(LMessageNumbers[LN])-1;
    end else begin
      LRecord := GetRecordForUID(Sys.StrToInt(LMessageNumbers[LN]), TIdIMAP4PeerContext(ASender.Context).FMailBox);
      if LRecord = -1 then continue; //It is OK to skip non-existent UID records
    end;
    if OnDefMechCopyMessage(TIdIMAP4PeerContext(ASender.Context).FLoginName,
     TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
     TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].UID,
     AParams[1]) = False then begin
      LResult := False;
    end;
  end;
  if LResult = True then begin
    SendOkCompleted(ASender);
  end else begin
    SendNoReply(ASender, 'Copy failed for one or more messages'); {Do not Localize}
  end;
  LMessageNumbers.Free;
end;

function TIdIMAP4Server.ProcessStore(AUseUID: Boolean; ASender: TIdCommand; AParams: TIdStringList): Boolean;
var
  LMessageNumbers: TIdStringList;
  LFlagList: TIdStringList;
  LN: integer;
  LM: integer;
  LRecord: integer;
  LTemp: string;
  LStoreMethod: TIdIMAP4StoreDataItem;
  LSilent: Boolean;
begin
  //Format is:
  //C53 UID STORE 6545,6544 +FLAGS.SILENT (\Deleted)
  //C53 OK Completed
  Result := False;
  if AParams.Count < 3 then begin
    SendIncorrectNumberOfParameters(ASender);
    Exit;
  end;
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TIdStringList.Create;
  if MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) = False then begin
    SendBadReply(ASender, 'Error in synthax of message set parameter'); {Do not Localize}
    LMessageNumbers.Free;
    Exit;
  end;
  LTemp := AParams[1];
  if LTemp[1] = '+' then begin  {Do not Localize}
    LStoreMethod := sdAdd;
    LTemp := Copy(LTemp, 2, MAXINT);
  end else if LTemp[1] = '-' then begin  {Do not Localize}
    LStoreMethod := sdRemove;
    LTemp := Copy(LTemp, 2, MAXINT);
  end else begin
    LStoreMethod := sdReplace;
  end;
  if LTemp = 'FLAGS' then begin  {Do not Localize}
    LSilent := False;
  end else if LTemp = 'FLAGS.SILENT' then begin  {Do not Localize}
    LSilent := True;
  end else begin
    SendBadReply(ASender, 'Error in synthax of FLAGS parameter'); {Do not Localize}
    LMessageNumbers.Free;
    Exit;
  end;
  LFlagList := TIdStringList.Create;
  //Assemble remaining flags back into a string...
  LTemp := AParams[2];
  for LN := 3 to AParams.Count-1 do begin
    LTemp := ' '+AParams[LN];  {Do not Localize}
  end;
  if FlagStringToFlagList(LFlagList, LTemp) = False then begin
    SendBadReply(ASender, 'Error in synthax of flag set parameter'); {Do not Localize}
    LFlagList.Free;
    LMessageNumbers.Free;
    Exit;
  end;
  for LN := 0 to LMessageNumbers.Count-1 do begin
    if AUseUID = False then begin
      LRecord := Sys.StrToInt(LMessageNumbers[LN])-1;
    end else begin
      LRecord := GetRecordForUID(Sys.StrToInt(LMessageNumbers[LN]), TIdIMAP4PeerContext(ASender.Context).FMailBox);
      if LRecord = -1 then continue; //It is OK to skip non-existent UID records
    end;
    if LStoreMethod = sdReplace then begin
      TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags := [];
    end;
    case LStoreMethod of
      sdAdd, sdReplace:
        begin
          for LM := 0 to LFlagList.Count-1 do begin
            //Support \Answered \Flagged \Draft \Deleted \Seen
            if LFlagList[LM] = '\Answered' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags +
               [mfAnswered];
            end else if LFlagList[LM] = '\Flagged' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags +
               [mfFlagged];
            end else if LFlagList[LM] = '\Draft' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags +
               [mfDraft];
            end else if LFlagList[LM] = '\Deleted' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags +
               [mfDeleted];
            end else if LFlagList[LM] = '\Seen' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags +
               [mfSeen];
            end;
          end;
        end;
      sdRemove:
        begin
          for LM := 0 to LFlagList.Count-1 do begin
            //Support \Answered \Flagged \Draft \Deleted \Seen
            if LFlagList[LM] = '\Answered' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags -
               [mfAnswered];
            end else if LFlagList[LM] = '\Flagged' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags -
               [mfFlagged];
            end else if LFlagList[LM] = '\Draft' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags -
               [mfDraft];
            end else if LFlagList[LM] = '\Deleted' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags -
               [mfDeleted];
            end else if LFlagList[LM] = '\Seen' then begin  {Do not Localize}
              TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags :=
               TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags -
               [mfSeen];
            end;
          end;
        end;
    end;
    if LSilent = False then begin
      //In this case, send to the client the current flags.
      //The response is '* 43 FETCH (FLAGS (\Seen))' with the UID version
      //being '* 43 FETCH (FLAGS (\Seen) UID 1234)'.  Note the first number is the
      //relative message number in BOTH cases.
      LTemp := '* '+Sys.IntToStr(LRecord+1)+' FETCH (FLAGS ('  {Do not Localize}
       +Sys.Trim(MessageFlagSetToStr(TIdIMAP4PeerContext(ASender.Context).FMailBox.MessageList.Messages[LRecord].Flags));
      if AUseUID = False then begin
        LTemp := LTemp + '))'; {Do not Localize}
      end else begin
        LTemp := LTemp + ') UID ' + LMessageNumbers[LN] + ')'; {Do not Localize}
      end;
      DoSendReply(ASender.Context, LTemp);
    end;
  end;
  DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' OK STORE Completed'); {Do not Localize}
  LFlagList.Free;
  LMessageNumbers.Free;
  Result := True;
end;

procedure TIdIMAP4Server.InitializeCommandHandlers;
begin
  with CommandHandlers.Add do begin
    Command := 'CAPABILITY';  {do not localize}
    OnCommand := DoCommandCAPABILITY;
  end;
  with CommandHandlers.Add do begin
    Command := 'NOOP';  {do not localize}
    OnCommand := DoCommandNOOP;
  end;
  with CommandHandlers.Add do begin
    Command := 'LOGOUT';  {do not localize}
    OnCommand := DoCommandLOGOUT;
  end;
  with CommandHandlers.Add do begin
    Command := 'AUTHENTICATE';  {do not localize}
    OnCommand := DoCommandAUTHENTICATE;
  end;
  with CommandHandlers.Add do begin
    Command := 'LOGIN'; {do not localize}
    OnCommand := DoCommandLOGIN;
  end;
  with CommandHandlers.Add do begin
    Command := 'SELECT';  {do not localize}
    OnCommand := DoCommandSELECT;
  end;
  with CommandHandlers.Add do begin
    Command := 'EXAMINE'; {do not localize}
    OnCommand := DoCommandEXAMINE;
  end;
  with CommandHandlers.Add do begin
    Command := 'CREATE';  {do not localize}
    OnCommand := DoCommandCREATE;
  end;
  with CommandHandlers.Add do begin
    Command := 'DELETE';  {do not localize}
    OnCommand := DoCommandDELETE;
  end;
  with CommandHandlers.Add do begin
    Command := 'RENAME';  {do not localize}
    OnCommand := DoCommandRENAME;
  end;
  with CommandHandlers.Add do begin
    Command := 'SUBSCRIBE'; {do not localize}
    OnCommand := DoCommandSUBSCRIBE;
  end;
  with CommandHandlers.Add do begin
    Command := 'UNSUBSCRIBE'; {do not localize}
    OnCommand := DoCommandUNSUBSCRIBE;
  end;
  with CommandHandlers.Add do begin
    Command := 'LIST';  {do not localize}
    OnCommand := DoCommandLIST;
  end;
  with CommandHandlers.Add do begin
    Command := 'LSUB';  {do not localize}
    OnCommand := DoCommandLSUB;
  end;
  with CommandHandlers.Add do begin
    Command := 'STATUS';  {do not localize}
    OnCommand := DoCommandSTATUS;
  end;
  with CommandHandlers.Add do begin
    Command := 'APPEND';  {do not localize}
    OnCommand := DoCommandAPPEND;
  end;
  with CommandHandlers.Add do begin
    Command := 'CHECK'; {do not localize}
    OnCommand := DoCommandCHECK;
  end;
  with CommandHandlers.Add do begin
    Command := 'CLOSE'; {do not localize}
    OnCommand := DoCommandCLOSE;
  end;
  with CommandHandlers.Add do begin
    Command := 'EXPUNGE'; {do not localize}
    OnCommand := DoCommandEXPUNGE;
  end;
  with CommandHandlers.Add do begin
    Command := 'SEARCH';  {do not localize}
    OnCommand := DoCommandSEARCH;
  end;
  with CommandHandlers.Add do begin
    Command := 'FETCH'; {do not localize}
    OnCommand := DoCommandFETCH;
  end;
  with CommandHandlers.Add do begin
    Command := 'STORE'; {do not localize}
    OnCommand := DoCommandSTORE;
  end;
  with CommandHandlers.Add do begin
    Command := 'COPY';  {do not localize}
    OnCommand := DoCommandCOPY;
  end;
  with CommandHandlers.Add do begin
    Command := 'UID'; {do not localize}
    OnCommand := DoCommandUID;
  end;
  with CommandHandlers.Add do begin
    Command := 'X'; {do not localize}
    OnCommand := DoCommandX;
  end;
  with CommandHandlers.Add do begin
    Command := 'STARTTLS';  {do not localize}
    OnCommand := DoCommandSTARTTLS;
  end;

  with FCommandHandlers do begin
    OnBeforeCommandHandler := DoBeforeCmd;
    OnCommandHandlersException := DoCmdHandlersException;
  end;
end;

//Command handlers

procedure TIdIMAP4Server.DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string;
  AContext: TIdContext);
var
  LTmp: String;
begin
  FLastCommand.ParseRequest(AData);  //Main purpose is to get sequence number, like C11 from 'C11 CAPABILITY'
  LTmp := Fetch(AData, #32);
  AData := Sys.Trim(AData);
  TIdIMAP4PeerContext(AContext).TagData.IMAP4Tag := LTmp;
  if Assigned(fOnBeforeCmd) then begin
    fOnBeforeCmd(ASender, AData, AContext);
  end;
end;

procedure TIdIMAP4Server.DoSendReply(AContext: TIdContext; AData: string);
begin
  if Assigned(fOnBeforeSend) then begin
    fOnBeforeSend(AContext, AData);
  end;
  AContext.Connection.IOHandler.WriteLn(AData);
end;

procedure TIdIMAP4Server.DoCmdHandlersException(ACommand: String; AContext: TIdContext);
var
  LTag, LCmd: String;
begin
  if Assigned(fOnCommandError) then begin
    LTag := Fetch(ACommand, #32);
    LCmd := Fetch(ACommand, #32);
    OnCommandError(AContext, LTag, LCmd);
  end;
end;

procedure TIdIMAP4Server.DoCommandCAPABILITY(ASender: TIdCommand);
begin
  if Assigned(fOnCommandCAPABILITY) then begin
    OnCommandCAPABILITY(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {Tell the client our capabilities...}
    DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' OK IMAP4rev1 AUTH=PLAIN'); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.DoCommandNOOP(ASender: TIdCommand);
begin
  if Assigned(fOnCommandNOOP) then begin
    OnCommandNOOP(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {On most servers, this does nothing (they use a timeout to disconnect users,
     irrespective of NOOP commands, so they always return OK.  If you really
     want to implement it, use a countdown timer to force disconnects but reset
     the counter if ANY command received, including NOOP.}
    SendOkCompleted(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandLOGOUT(ASender: TIdCommand);
begin
  if Assigned(fOnCommandLOGOUT) then begin
    OnCommandLOGOUT(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {Be nice and say ByeBye first...}
    DoSendReply(ASender.Context, '* BYE May your God go with you.'); {Do not Localize}
    SendOkCompleted(ASender);
    ASender.Context.Connection.Disconnect(False);
    TIdIMAP4PeerContext(ASender.Context).FMailBox.Free;
    ASender.Context.RemoveFromList;
  end;
end;

procedure TIdIMAP4Server.DoCommandAUTHENTICATE(ASender: TIdCommand);
begin
  if Assigned(fOnCommandAUTHENTICATE) then begin
    {
    Important, when usng TLS and FUseTLS=utUseRequireTLS, do not accept any authentication
    information until TLS negotiation is completed.  This insistance is a security feature.

    Some networks should choose security over interoperability while other places may
    sacrafice interoperability over security.  It comes down to sensible administrative
    judgement.
    }
    if (FUseTLS =utUseRequireTLS) and ((ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough=True) then begin
      MustUseTLS(ASender);
    end else begin
      OnCommandAUTHENTICATE(ASender.Context,TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag,
        ASender.UnparsedParams);
    end;
  end;
end;

procedure TIdIMAP4Server.MustUseTLS(ASender: TIdCommand);
begin
  DoSendReply(ASender.Context, 'NO '+RSSMTPSvrReqSTARTTLS); {Do not Localize}
  ASender.Disconnect := True;
end;

procedure TIdIMAP4Server.DoCommandLOGIN(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if Assigned(fOnCommandLOGIN) then begin
    {
    Important, when usng TLS and FUseTLS=utUseRequireTLS, do not accept any authentication
    information until TLS negotiation is completed.  This insistance is a security feature.

    Some networks should choose security over interoperability while other places may
    sacrafice interoperability over security.  It comes down to sensible administrative
    judgement.
    }
    if (FUseTLS =utUseRequireTLS) and ((ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough=True) then begin
      MustUseTLS(ASender);
    end else begin
      OnCommandLOGIN(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
    end;
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count <> 2 then begin
      //Incorrect number of params...
      if FSaferMode then begin
        DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' NO'); {Do not Localize}
      end else begin
        SendIncorrectNumberOfParameters(ASender);
      end;
      LParams.Free;
      Exit;
    end;
    //See if we have a directory under FRootPath of that user's name...
    if not Assigned(OnDefMechDoesImapMailBoxExist) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    //if DoesImapMailBoxExist(LParams[0], '') = False then begin
    if OnDefMechDoesImapMailBoxExist(LParams[0], '') = False then begin
      if FSaferMode then begin
        DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' NO'); {Do not Localize}
      end else begin
        SendNoReply(ASender, 'Unknown username'); {Do not Localize}
      end;
      LParams.Free;
      Exit;
    end;
    //See is it the correct password...
    if TextIsSame(FDefaultPassword, LParams[1]) = False then begin
      if FSaferMode then begin
        DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' NO'); {Do not Localize}
      end else begin
        SendNoReply(ASender, 'Incorrect password'); {Do not Localize}
      end;
      LParams.Free;
      Exit;
    end;
    //Successful login, change context's state to logged in...
    TIdIMAP4PeerContext(ASender.Context).FMailBox := TIdMailBox.Create;
    TIdIMAP4PeerContext(ASender.Context).FConnectionState := csAuthenticated;
    TIdIMAP4PeerContext(ASender.Context).FLoginName := LParams[0];
    SendOkCompleted(ASender);
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandSELECT(ASender: TIdCommand);
//SELECT and EXAMINE are the same except EXAMINE opens the mailbox read-only
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState = csSelected then begin
    TIdIMAP4PeerContext(ASender.Context).FMailBox.Clear;
    TIdIMAP4PeerContext(ASender.Context).FConnectionState := csAuthenticated;
  end;
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSELECT) then begin
    OnCommandSELECT(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    if not Assigned(OnDefMechOpenMailBox) then begin
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    if OnDefMechOpenMailBox(ASender, False) = True then begin  //SELECT opens the mailbox read-write
      TIdIMAP4PeerContext(ASender.Context).FConnectionState := csSelected;
      DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' OK [READ-WRITE] Completed'); {Do not Localize}
    end;
  end;
end;

procedure TIdIMAP4Server.DoCommandEXAMINE(ASender: TIdCommand);
//SELECT and EXAMINE are the same except EXAMINE opens the mailbox read-only
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandEXAMINE) then begin
    OnCommandEXAMINE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    if not Assigned(OnDefMechOpenMailBox) then begin
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    if OnDefMechOpenMailBox(ASender, True) = True then begin  //EXAMINE opens the mailbox read-only
      TIdIMAP4PeerContext(ASender.Context).FConnectionState := csSelected;
      DoSendReply(ASender.Context, FLastCommand.SequenceNumber + ' OK [READ-ONLY] Completed'); {Do not Localize}
    end;
  end;
end;

procedure TIdIMAP4Server.DoCommandCREATE(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(fOnCommandCREATE) then begin
    OnCommandCREATE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if ( (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or (not Assigned(OnDefMechDoesImapMailBoxExist))
     or (not Assigned(OnDefMechCreateMailBox)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 0) = False then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if LParams.Count <> 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = True then begin
      SendBadReply(ASender, 'Mailbox already exists.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechCreateMailBox(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = True then begin
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'Create failed'); {Do not Localize}
    end;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandDELETE(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(fOnCommandDELETE) then begin
    OnCommandDELETE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //Make sure we don't have the mailbox open by anyone
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if ( (not Assigned(OnDefMechDoesImapMailBoxExist))
     or  (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or  (not Assigned(OnDefMechDeleteMailBox))
     or  (not Assigned(OnDefMechIsMailBoxOpen)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 0) = False then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechIsMailBoxOpen(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = True then begin
      SendNoReply(ASender, 'Mailbox is in use.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if LParams.Count <> 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = False then begin
      SendNoReply(ASender, 'Mailbox does not exist.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechDeleteMailBox(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = True then begin
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'Delete failed'); {Do not Localize}
    end;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandRENAME(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(fOnCommandRENAME) then begin
    OnCommandRENAME(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //Make sure we don't have the mailbox open by anyone
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if ( (not Assigned(OnDefMechDoesImapMailBoxExist))
     or  (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or  (not Assigned(OnDefMechRenameMailBox))
     or  (not Assigned(OnDefMechIsMailBoxOpen)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 0) = False then begin
      SendBadReply(ASender, 'First mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechIsMailBoxOpen(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = True then begin
      SendNoReply(ASender, 'Mailbox is in use.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 1) = False then begin
      SendBadReply(ASender, 'Second mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if LParams.Count <> 2 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = False then begin
      SendNoReply(ASender, 'Mailbox to be renamed does not exist.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[1]) = True then begin
      SendNoReply(ASender, 'Destination mailbox already exists.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechRenameMailBox(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0], LParams[1]) = True then begin
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'Delete failed'); {Do not Localize}
    end;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandSUBSCRIBE(ASender: TIdCommand);
begin
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSUBSCRIBE) then begin
    OnCommandSUBSCRIBE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {Not clear exactly what this would do in this sample mechanism...}
    SendUnsupportedCommand(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandUNSUBSCRIBE(ASender: TIdCommand);
begin
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandUNSUBSCRIBE) then begin
    OnCommandUNSUBSCRIBE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {Not clear exactly what this would do in this sample mechanism...}
    SendUnsupportedCommand(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandLIST(ASender: TIdCommand);
var
  LParams: TIdStringList;
  LMailBoxNames: TIdStringList;
  LMailBoxFlags: TIdStringList;
  LN: integer;
  LEntry: string;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandLIST) then begin
    OnCommandLIST(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //The default mechanism only supports the following format:
    //  LIST "" *
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if not Assigned(OnDefMechListMailBox) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if LParams[1] <> '*' then begin  {Do not Localize}
      SendBadReply(ASender, 'Parameter not supported, 2nd (last) parameter must be *'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    LMailBoxNames := TIdStringList.Create;
    LMailBoxFlags := TIdStringList.Create;
    if OnDefMechListMailBox(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0], LMailBoxNames, LMailBoxFlags) = True then begin
      for LN := 0 to LMailBoxNames.Count-1 do begin
        //Replies are of the form:
        //* LIST (\HasNoChildren) "." "INBOX.CreatedFolder"
        LEntry := '* LIST (';  {Do not Localize}
        if LMailBoxFlags[LN] <> '' then begin
          LEntry := LEntry + LMailBoxFlags[LN];
        end;
        LEntry := LEntry + ') "'+MailBoxSeparator+'" "'+LMailBoxNames[LN]+'"';  {Do not Localize}
        DoSendReply(ASender.Context, LEntry); {Do not Localize}
      end;
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'List failed'); {Do not Localize}
    end;
    LMailBoxNames.Free;
    LMailBoxFlags.Free;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandLSUB(ASender: TIdCommand);
var
  LParams: TIdStringList;
  LMailBoxNames: TIdStringList;
  LMailBoxFlags: TIdStringList;
  LN: integer;
  LEntry: string;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandLSUB) then begin
    OnCommandLSUB(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //Treat this the same as LIST...
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if not Assigned(OnDefMechListMailBox) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if LParams[1] <> '*' then begin  {Do not Localize}
      SendBadReply(ASender, 'Parameter not supported, 2nd (last) parameter must be *'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    LMailBoxNames := TIdStringList.Create;
    LMailBoxFlags := TIdStringList.Create;
    if OnDefMechListMailBox(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0], LMailBoxNames, LMailBoxFlags) = True then begin
      for LN := 0 to LMailBoxNames.Count-1 do begin
        //Replies are of the form:
        //* LIST (\HasNoChildren) "." "INBOX.CreatedFolder"
        LEntry := '* LIST (';  {Do not Localize}
        if LMailBoxFlags[LN] <> '' then begin
          LEntry := LEntry + LMailBoxFlags[LN];
        end;
        LEntry := LEntry + ') "'+MailBoxSeparator+'" "'+LMailBoxNames[LN]+'"';  {Do not Localize}
        DoSendReply(ASender.Context, LEntry); {Do not Localize}
      end;
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'List failed'); {Do not Localize}
    end;
    LMailBoxNames.Free;
    LMailBoxFlags.Free;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandSTATUS(ASender: TIdCommand);
var
  LMailBox: TIdMailBox;
  LN: integer;
  LParams: TIdStringList;
  LTemp: string;
  LAnswer: string;
begin
  if ( (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated) and (TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected) ) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSTATUS) then begin
    OnCommandSTATUS(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //This can be issued for ANY mailbox, not just the currently selected one.
    //The format is:
    //C5 STATUS "INBOX" (MESSAGES RECENT UIDNEXT UIDVALIDITY UNSEEN)
    //* STATUS INBOX (MESSAGES 490 RECENT 132 UIDNEXT 6546 UIDVALIDITY 1065090323 UNSEEN 167)
    //C5 OK Completed
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if ( (not Assigned(OnDefMechDoesImapMailBoxExist))
     or  (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or  (not Assigned(OnDefMechSetupMailbox)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 0) = False then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]) = False then begin
      SendNoReply(ASender, 'Mailbox does not exist.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    {Get everything you need for this mailbox...}
    LMailBox := TIdMailBox.Create;
    OnDefMechSetupMailbox(TIdIMAP4PeerContext(ASender.Context).FLoginName,
      LParams[0],
      LMailBox);
    {Send the stats...}
    LAnswer := '* STATUS '+LParams[0]+' (';  {Do not Localize}
    for LN := 1 to LParams.Count-1 do begin
      LTemp := LParams[LN];
      if LTemp <> '' then begin
        //Strip brackets (will be on 1st & last param)
        if LTemp[1] = '(' then begin  {Do not Localize}
          LTemp := Copy(LTemp, 2, MAXINT);
        end;
        if LTemp[Length(LTemp)] = ')' then begin  {Do not Localize}
          LTemp := Copy(LTemp, 1, Length(LTemp)-1);
        end;
        if LTemp = 'MESSAGES' then begin  {Do not Localize}
          LAnswer := LAnswer + LTemp + ' ' + Sys.IntToStr(LMailBox.TotalMsgs) + ' ';  {Do not Localize}
        end else if LTemp = 'RECENT' then begin  {Do not Localize}
          LAnswer := LAnswer + LTemp + ' ' + Sys.IntToStr(LMailBox.RecentMsgs) + ' ';  {Do not Localize}
        end else if LTemp = 'UIDNEXT' then begin  {Do not Localize}
          LAnswer := LAnswer + LTemp + ' ' + LMailBox.UIDNext + ' ';  {Do not Localize}
        end else if LTemp = 'UIDVALIDITY' then begin  {Do not Localize}
          LAnswer := LAnswer + LTemp + ' ' + LMailBox.UIDValidity + ' ';  {Do not Localize}
        end else if LTemp = 'UNSEEN' then begin  {Do not Localize}
          LAnswer := LAnswer + LTemp + ' ' + Sys.IntToStr(LMailBox.UnseenMsgs) + ' ';  {Do not Localize}
        end else begin
          SendBadReply(ASender, 'Parameter not supported: '+LTemp); {Do not Localize}
          LMailBox.Free;
          LParams.Free;
          Exit;
        end;
      end;
    end;
    if LAnswer[Length(LAnswer)] = ' ' then begin  {Do not Localize}
      LAnswer := Copy(LAnswer, 1, Length(LAnswer)-1);
    end;
    LAnswer := LAnswer + ')';  {Do not Localize}
    DoSendReply(ASender.Context, LAnswer);
    SendOkCompleted(ASender);
    LMailBox.Free;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandAPPEND(ASender: TIdCommand);
var
  LUID: string;
  LStream: TFileStream;
  LIdStream: TIdStreamVCL;
  LFile: string;
  LTemp: string;
  LParams: TIdStringList;
  LParams2: TIdStringList;
  LFlagsList: TIdStringList;
  LSize: integer;
  LFlags: string;
  LN: integer;
  LMessage: TIdMessage;
begin
  //You do NOT need to be in selected state for this.
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csAuthenticated then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandAPPEND) then begin
    OnCommandAPPEND(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //Format (the flags are optional):
    //C323 APPEND "INBOX.Sent" (\Seen) {1876}
    //+ go ahead
    //...
    //C323 OK [APPENDUID 1065095982 105] Completed
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if ( (not Assigned(OnDefMechGetNextFreeUID))
     or  (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or  (not Assigned(OnDefMechUpdateNextFreeUID))
     or  (not Assigned(OnDefMechDeleteMessage))  //Needed to reverse out a save if setting flags fail
     or  (not Assigned(OnDefMechGetFileNameToWriteAppendMessage)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      LParams.Free;
      Exit;
    end;
    if OnDefMechReinterpretParamAsMailBox(LParams, 0) = False then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      LParams.Free;
      Exit;
    end;
    LFlags := '';
    LTemp := LParams[1];
    if LTemp[1] = '(' then begin  {Do not Localize}
      if ReinterpretParamAsFlags(LParams, 1) = False then begin
        SendBadReply(ASender, 'Flags parameter is invalid.'); {Do not Localize}
        LParams.Free;
        Exit;
      end;
      LFlags := LParams[1];
    end;
    LTemp := LParams[LParams.Count-1];
    LSize := Sys.StrToInt(Copy(LTemp, 2, Length(LTemp)-2));
    //Grab the next UID...
    LUID := OnDefMechGetNextFreeUID(TIdIMAP4PeerContext(ASender.Context).FLoginName, LParams[0]);
    //Get the message...
    LFile := OnDefMechGetFileNameToWriteAppendMessage(TIdIMAP4PeerContext(ASender.Context).FLoginName,
       TIdIMAP4PeerContext(ASender.Context).FMailBox.Name, LUID);
    LStream := TFileStream.Create(LFile, fmCreate);
    LIdStream := TIdStreamVCL.Create(LStream);
    ASender.Context.Connection.IOHandler.ReadStream(LIdStream, LSize);
    if LFlags = '' then begin
      SendOkCompleted(ASender);
      //Update the next free UID in the .uid file...
      OnDefMechUpdateNextFreeUID(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         Sys.IntToStr(Sys.StrToInt(LUID)+1));
    end else begin
      //Update the (optional) flags...
      LParams2 := TIdStringList.Create;
      LParams2.Clear;
      LParams2.Add(LUID);
      LParams2.Add('FLAGS.SILENT');  {Do not Localize}
      {
      for LN := 1 to LParams.Count-2 do begin
        LParams2.Add(LParams[LN]);
      end;
      }
      //The flags are in a string, need to reassemble...
      LFlagsList := TIdStringList.Create;
      BreakApart(LFlags, ' ', LFlagsList);  {Do not Localize}
      for LN := 0 to LFlagsList.Count-1 do begin
        LTemp := LFlagsList[LN];
        if LN = 0 then begin
          LTemp := '('+LTemp;  {Do not Localize}
        end;
        if LN = LFlagsList.Count-1 then begin
          LTemp := LTemp+')';  {Do not Localize}
        end;
        LParams2.Add(LTemp);
      end;
      if ProcessStore(True, ASender, LParams2) = False then begin
        //Have to reverse out our changes if ANYTHING fails..
        LMessage := TIdMessage.Create(Self);
        LMessage.UID := LUID;  //This is all we need for deletion
        OnDefMechDeleteMessage(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         LMessage);
        LMessage.Free;
      end else begin
        //Update the next free UID in the .uid file...
        OnDefMechUpdateNextFreeUID(TIdIMAP4PeerContext(ASender.Context).FLoginName,
         TIdIMAP4PeerContext(ASender.Context).FMailBox.Name,
         Sys.IntToStr(Sys.StrToInt(LUID)+1));
      end;
      LParams2.Free;
    end;
    LStream.Free;
    LIdStream.Free;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandCHECK(ASender: TIdCommand);
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandCHECK) then begin
    OnCommandCHECK(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {On most servers, this does nothing, they always return OK...}
    SendOkCompleted(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandCLOSE(ASender: TIdCommand);
var
  LResult: Boolean;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandCLOSE) then begin
    OnCommandCLOSE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    {This is an implicit expunge...}
    if not Assigned(OnDefMechDeleteMessage) then begin  //Used by ExpungeRecords
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    LResult := ExpungeRecords(ASender);
    {Now close it...}
    TIdIMAP4PeerContext(ASender.Context).FMailBox.Clear;
    TIdIMAP4PeerContext(ASender.Context).FConnectionState := csAuthenticated;
    if LResult = True then begin
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'Implicit expunge failed for one or more messages'); {Do not Localize}
    end;
  end;
end;

procedure TIdIMAP4Server.DoCommandEXPUNGE(ASender: TIdCommand);
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandEXPUNGE) then begin
    OnCommandEXPUNGE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    if not Assigned(OnDefMechDeleteMessage) then begin  //Used by ExpungeRecords
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    if ExpungeRecords(ASender) = True then begin
      SendOkCompleted(ASender);
    end else begin
      SendNoReply(ASender, 'Expunge failed for one or more messages'); {Do not Localize}
    end;
  end;
end;

procedure TIdIMAP4Server.DoCommandSEARCH(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSEARCH) then begin
    OnCommandSEARCH(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag,  ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    if not Assigned(OnDefMechGetMessageHeader) then begin  //Used by ProcessSearch
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessSearch(False, ASender, LParams);
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandFETCH(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandFETCH) then begin
    OnCommandFETCH(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    if ( (not Assigned(OnDefMechGetMessageHeader))  //Used by ProcessFetch
     or  (not Assigned(OnDefMechGetMessageSize))
     or  (not Assigned(OnDefMechGetMessageRaw)) ) then begin
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessFetch(False, ASender, LParams);
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandSTORE(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSTORE) then begin
    OnCommandSTORE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessStore(False, ASender, LParams);
    LParams.Free;
  end;
end;

function TIdIMAP4Server.MessageFlagSetToStr(const AFlags: TIdMessageFlagsSet): String;
begin
  Result := '';
  if mfAnswered in AFlags then begin
    Result := Result + MessageFlags[mfAnswered] + ' ';       {Do not Localize}
  end;
  if mfFlagged in AFlags then begin
    Result := Result + MessageFlags[mfFlagged] + ' ';        {Do not Localize}
  end;
  if mfDeleted in AFlags then begin
    Result := Result + MessageFlags[mfDeleted] + ' ';        {Do not Localize}
  end;
  if mfDraft in AFlags then begin
    Result := Result + MessageFlags[mfDraft] + ' ';          {Do not Localize}
  end;
  if mfSeen in AFlags then begin
    Result := Result + MessageFlags[mfSeen] + ' ';           {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.DoCommandCOPY(ASender: TIdCommand);
var
  LParams: TIdStringList;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if TIdIMAP4PeerContext(ASender.Context).FMailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandCOPY) then begin
    OnCommandCOPY(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    //Format is COPY 2:4 DestinationMailBoxName
    if ( (not Assigned(OnDefMechReinterpretParamAsMailBox))
     or  (not Assigned(OnDefMechCopyMessage)) ) then begin    //Needed for ProcessCopy
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessCopy(False, ASender, LParams);
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandUID(ASender: TIdCommand);
{UID before COPY, FETCH or STORE means the record numbers are UIDs.
 UID before SEARCH means SEARCH is to _return_ UIDs rather than relative numbers.}
var
  LParams: TIdStringList;
begin
  if TIdIMAP4PeerContext(ASender.Context).FConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandUID) then begin
    OnCommandUID(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    LParams := TIdStringList.Create;
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    //Map the commands to the general handler but remove the FETCH or whatever...
    if Sys.UpperCase(LParams[0]) = 'FETCH' then begin  {Do not Localize}
      LParams.Delete(0);
      if ( (not Assigned(OnDefMechGetMessageHeader))  //Used by ProcessFetch
       or  (not Assigned(OnDefMechGetMessageSize))
       or  (not Assigned(OnDefMechGetMessageRaw)) ) then begin
        SendUnassignedDefaultMechanism(ASender);
        LParams.Free;
        Exit;
      end;
      ProcessFetch(True, ASender, LParams);
    end else if Sys.UpperCase(LParams[0]) = 'COPY' then begin  {Do not Localize}
      LParams.Delete(0);
      if ( (not Assigned(OnDefMechReinterpretParamAsMailBox))
       or  (not Assigned(OnDefMechCopyMessage)) ) then begin    //Needed for ProcessCopy
        SendUnassignedDefaultMechanism(ASender);
        LParams.Free;
        Exit;
      end;
      ProcessCopy(True, ASender, LParams);
    end else if Sys.UpperCase(LParams[0]) = 'STORE' then begin  {Do not Localize}
      LParams.Delete(0);
      ProcessStore(True, ASender, LParams);
    end else if Sys.UpperCase(LParams[0]) = 'SEARCH' then begin  {Do not Localize}
      LParams.Delete(0);
      if not Assigned(OnDefMechGetMessageHeader) then begin  //Used by ProcessSearch
        SendUnassignedDefaultMechanism(ASender);
        LParams.Free;
        Exit;
      end;
      ProcessSearch(True, ASender, LParams);
    end else begin
      SendUnsupportedCommand(ASender);
    end;
    LParams.Free;
  end;
end;

procedure TIdIMAP4Server.DoCommandX(ASender: TIdCommand);
begin
  if Assigned(fOnCommandX) then begin
    OnCommandX(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    SendUnsupportedCommand(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandSTARTTLS(ASender: TIdCommand);
var LIO : TIdSSLIOHandlerSocketBase;
begin
  if (IOHandler is TIdServerIOHandlerSSLBase) and (FUseTLS in ExplicitTLSVals) then begin
    if TIdIMAP4PeerContext(ASender.Context).UsingTLS then begin // we are already using TLS
      DoSendReply(ASender.Context, Sys.Format('BAD %s', [RSIMAP4SvrNotPermittedWithTLS])); {do not localize}
      Exit;
    end;
    // TODO: STARTTLS may only be issued in auth-state
    DoSendReply(ASender.Context, Sys.Format('OK %s', [RSIMAP4SvrBeginTLSNegotiation]));  {do not localize}
    LIO := ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase;
    LIO.Passthrough := False;
  end else begin
    OnCommandError(ASender.Context, TIdIMAP4PeerContext(ASender.Context).TagData.IMAP4Tag, ASender.UnparsedParams);
  end;
end;

{
  Previous revision history

  Rev 1.31    2/9/2005 11:44:20 AM  JPMugaas
    Fixed compiler problem and removed some warnings about virtual
    methods hiding stuff in the base class.

  Rev 1.30    2/8/05 6:20:16 PM  RLebeau
    Added additional overriden methods.

  Rev 1.29    10/26/2004 11:08:06 PM  JPMugaas
    Updated refs.

  Rev 1.28    10/21/2004 1:49:12 PM  BGooijen
    Raid 214213

  Rev 1.27    09/06/2004 09:54:56  CCostelloe
    Kylix 3 patch

  Rev 1.26    2004.05.20 11:37:34 AM  czhower
    IdStreamVCL

  Rev 1.25    4/8/2004 11:49:56 AM  BGooijen
    Fix for D5

  Rev 1.24    03/03/2004 01:16:20  CCostelloe
    Yet another check-in as part of continuing development

  Rev 1.23    01/03/2004 23:32:24  CCostelloe
    Another check-in as part of continuing development

  Rev 1.22    3/1/2004 12:55:28 PM  JPMugaas
    Updated for problem with new code.

  Rev 1.21    26/02/2004 02:01:14  CCostelloe
    Another intermediate check-in, approx half of functions are debugged

  Rev 1.20    24/02/2004 10:34:50  CCostelloe
    Storage-specific code moved to IdIMAP4ServerDemo

  Rev 1.19    2/22/2004 12:09:54 AM  JPMugaas
    Fixes for IMAP4Server compile failure in DotNET.  This also fixes
    a potential problem where file handles can be leaked in the server
    needlessly.

  Rev 1.18    12/02/2004 02:40:56  CCostelloe
    Minor bugfix


  Rev 1.17    12/02/2004 02:24:30  CCostelloe
    Completed revision, apart from parts support and BODYSTRUCTURE, not
    yet debugged.

  Rev 1.16    05/02/2004 00:25:32  CCostelloe
    This version actually works!

  Rev 1.15    2/4/2004 2:37:38 AM  JPMugaas
    Moved more units down to the implementation clause in the units to
    make them easier to compile.

  Rev 1.14    2/3/2004 4:12:42 PM  JPMugaas
    Fixed up units so they should compile.

  Rev 1.13    1/29/2004 9:07:54 PM  JPMugaas
    Now uses TIdExplicitTLSServer so it can take advantage of that framework.

  Rev 1.12    1/21/2004 3:11:02 PM  JPMugaas
    InitComponent

  Rev 1.11    27/12/2003 22:28:48  ANeillans
    Design fix, Login event only passed the username (first param)

  Rev 1.10    2003.10.21 9:13:08 PM  czhower
    Now compiles.

  Rev 1.9    10/19/2003 6:00:24 PM  DSiders
    Added localization coimments.

  Rev 1.8    9/19/2003 03:29:58 PM  JPMugaas
    Now should compile again.

  Rev 1.7    07/09/2003 12:29:08  CCostelloe
    Warning that variable LIO is declared but never used in
    TIdIMAP4Server.DoCommandSTARTTLS fixed.

  Rev 1.6    7/20/2003 6:20:06 PM  SPerry
    Switched to IdCmdTCPServer, also some modifications

  Rev 1.5    3/14/2003 10:44:36 PM  BGooijen
    Removed warnings, changed StartSSL to PassThrough:=false;

  Rev 1.4    3/14/2003 10:04:10 PM  BGooijen
    Removed TIdServerIOHandlerSSLBase.PeerPassthrough, the ssl is now
    enabled in the server-protocol-files

  Rev 1.3    3/13/2003 09:49:20 AM  JPMugaas
    Now uses an abstract SSL base class instead of OpenSSL so
    3rd-party vendors can plug-in their products.

  Rev 1.2    2/24/2003 09:03:14 PM  JPMugaas

  Rev 1.1    2/6/2003 03:18:14 AM  JPMugaas
    Updated components that compile with Indy 10.

  Rev 1.0    11/13/2002 07:55:02 AM  JPMugaas

  2002-Apr-21 - J. Berg
    use fetch()

  2000-May-18 - J. Peter Mugaas
    Ported to Indy

  2000-Jan-13 - MTL
    Moved to new Palette Scheme (Winshoes Servers)

  1999-Aug-26 - Ray Malone
    Started unit
}

end.
