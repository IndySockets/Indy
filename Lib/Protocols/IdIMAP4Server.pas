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
  Prior revision history

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


  TODO (ccostelloe):

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

{$i IdCompilerDefines.inc}

{$IFDEF DOTNET}
{$I IdUnitPlatformOff.inc}
{$I IdSymbolPlatformOff.inc}
{$ENDIF}

uses
  Classes,
  IdAssignedNumbers,
  IdCustomTCPServer, //for TIdServerContext
  IdCmdTCPServer,
  IdContext,
  IdCommandHandlers,
  IdException,
  IdExplicitTLSClientServerBase,
  IdIMAP4, //For some defines like TIdIMAP4ConnectionState
  IdMailBox,
  IdMessage,
  IdReply,
  IdReplyIMAP4,
  IdTCPConnection,
  IdYarn;

const
  DEF_IMAP4_IMPLICIT_TLS = False;

type
  TIMAP4CommandEvent = procedure(AContext: TIdContext; const ATag, ACmd: String) of object;
  TIdIMAP4CommandBeforeEvent = procedure(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext) of object;
  TIdIMAP4CommandBeforeSendEvent = procedure(AContext: TIdContext; AData: string) of object;

  //For default mechanisms..
  TIdIMAP4DefMech1  = function(ALoginName, AMailbox: string): Boolean of object;
  TIdIMAP4DefMech2  = function(ALoginName, AMailBoxName: string; AMailBox: TIdMailBox): Boolean of object;
  TIdIMAP4DefMech3  = function(ALoginName, AMailbox: string): string of object;
  TIdIMAP4DefMech4  = function(ALoginName, AOldMailboxName, ANewMailboxName: string): Boolean of object;
  TIdIMAP4DefMech5  = function(ALoginName, AMailBoxName: string; AMailBoxNames: TStrings; AMailBoxFlags: TStrings): Boolean of object;
  TIdIMAP4DefMech6  = function(ALoginName, AMailbox: string; AMessage: TIdMessage): Boolean of object;
  TIdIMAP4DefMech7  = function(ALoginName, ASourceMailBox, AMessageUID, ADestinationMailbox: string): Boolean of object;
  TIdIMAP4DefMech8  = function(ALoginName, AMailbox: string; AMessage: TIdMessage): Int64 of object;
  TIdIMAP4DefMech9  = function(ALoginName, AMailbox: string; AMessage, ATargetMessage: TIdMessage): Boolean of object;
  TIdIMAP4DefMech10 = function(ALoginName, AMailbox: string; AMessage: TIdMessage; ALines: TStrings): Boolean of object;
  TIdIMAP4DefMech11 = function(ASender: TIdCommand; AReadOnly: Boolean): Boolean of object;
  TIdIMAP4DefMech12 = function(AParams: TStrings; AMailBoxParam: Integer): Boolean of object;
  TIdIMAP4DefMech13 = function(ALoginName, AMailBoxName, ANewUIDNext: string): Boolean of object;
  TIdIMAP4DefMech14 = function(ALoginName, AMailBoxName, AUID: string): string of object;

  EIdIMAP4ServerException = class(EIdException);
  EIdIMAP4ImplicitTLSRequiresSSL = class(EIdIMAP4ServerException);

  { custom IMAP4 context }
  TIdIMAP4PeerContext = class(TIdServerContext)
  protected
    FConnectionState : TIdIMAP4ConnectionState;
    FLoginName: string;
    FMailBox: TIdMailBox;
    FIMAP4Tag: String;
    FLastCommand: TIdReplyIMAP4;  //Used to record the client command we are currently processing
    function GetUsingTLS: Boolean;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdContextThreadList = nil
      ); override;
    destructor Destroy; override;
    property ConnectionState: TIdIMAP4ConnectionState read FConnectionState;
    property UsingTLS : Boolean read GetUsingTLS;
    property IMAP4Tag: String read FIMAP4Tag;
    property MailBox: TIdMailBox read FMailBox;
    property LoginName: string read FLoginName write FLoginName;
  end;

  { TIdIMAP4Server }
  TIdIMAP4Server = class(TIdExplicitTLSServer)
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
    //
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
    procedure SendOkReply(ASender: TIdCommand; const AText: string);
    procedure SendBadReply(ASender: TIdCommand; const AText: string); overload;
    procedure SendBadReply(ASender: TIdCommand; const AFormat: string; const Args: array of const); overload;
    procedure SendNoReply(ASender: TIdCommand; const AText: string = ''); overload;
    procedure SendNoReply(ASender: TIdCommand; const AFormat: string; const Args: array of const); overload;
    //
    //The following are used internally by the default mechanism...
    function  ExpungeRecords(ASender: TIdCommand): Boolean;
    function  MessageSetToMessageNumbers(AUseUID: Boolean; ASender: TIdCommand; AMessageNumbers: TStrings; AMessageSet: string): Boolean;
    function  GetRecordForUID(const AUID: String; AMailBox: TIdMailBox): Int64;
    procedure ProcessFetch(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
    procedure ProcessCopy(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
    function  ProcessStore(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings): Boolean;
    procedure ProcessSearch(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
    function  FlagStringToFlagList(AFlagList: TStrings; AFlagString: string): Boolean;
    function  StripQuotesIfNecessary(AName: string): string;
    function  ReassembleParams(ASeparator: char; AParams: TStrings; AParamToReassemble: integer): Boolean;
    function  ReinterpretParamAsMailBox(AParams: TStrings; AMailBoxParam: integer): Boolean;
    function  ReinterpretParamAsFlags(AParams: TStrings; AFlagsParam: integer): Boolean;
    function  ReinterpretParamAsQuotedStr(AParams: TStrings; AFlagsParam: integer): Boolean;
    function  ReinterpretParamAsDataItems(AParams: TStrings; AFlagsParam: integer): Boolean;
    //
    //The following are used internally by our default mechanism and are copies of
    //the same function in TIdIMAP4 (move to a base class?)...
    function  MessageFlagSetToStr(const AFlags: TIdMessageFlagsSet): String;
    //
    //DoBeforeCmd & DoSendReply are useful for a server to log all commands and
    //responses for debugging...
    procedure DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string; AContext: TIdContext);
    procedure DoSendReply(AContext: TIdContext; const AData: string); overload;
    procedure DoSendReply(AContext: TIdContext; const AFormat: string; const Args: array of const); overload;
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
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;
  published
    property DefaultPort default IdPORT_IMAP4;
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
    property OnDefMechOpenMailBox: TIdIMAP4DefMech11 read fOnDefMechOpenMailBox write fOnDefMechOpenMailBox;
    property OnDefMechReinterpretParamAsMailBox: TIdIMAP4DefMech12 read fOnDefMechReinterpretParamAsMailBox write fOnDefMechReinterpretParamAsMailBox;
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
  IdStream,
  SysUtils;

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
    DoSendReply(AContext, '* OK Indy IMAP server version ' + GetIndyVersion); {Do not Localize}
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

procedure TIdIMAP4Server.SendOkReply(ASender: TIdCommand; const AText: string);
begin
  DoSendReply(ASender.Context, TIdIMAP4PeerContext(ASender.Context).FLastCommand.SequenceNumber + ' OK ' + AText); {Do not Localize}
end;

procedure TIdIMAP4Server.SendBadReply(ASender: TIdCommand; const AText: string);
begin
  DoSendReply(ASender.Context, TIdIMAP4PeerContext(ASender.Context).FLastCommand.SequenceNumber + ' BAD ' + AText); {Do not Localize}
end;

procedure TIdIMAP4Server.SendBadReply(ASender: TIdCommand; const AFormat: string; const Args: array of const);
begin
  SendBadReply(ASender, IndyFormat(AFormat, Args));
end;

procedure TIdIMAP4Server.SendNoReply(ASender: TIdCommand; const AText: string = '');
begin
  if AText <> '' then begin
    DoSendReply(ASender.Context, TIdIMAP4PeerContext(ASender.Context).FLastCommand.SequenceNumber + ' NO ' + AText); {Do not Localize}
  end else begin
    DoSendReply(ASender.Context, TIdIMAP4PeerContext(ASender.Context).FLastCommand.SequenceNumber + ' NO'); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.SendNoReply(ASender: TIdCommand; const AFormat: string; const Args: array of const);
begin
  SendNoReply(ASender, IndyFormat(AFormat, Args));
end;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdIMAP4Server.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdIMAP4Server.InitComponent;
begin
  inherited InitComponent;
  //Todo:  Not sure which number is appropriate.  Should be tested
  FRegularProtPort := IdPORT_IMAP4;
  FImplicitTLSProtPort := IdPORT_IMAP4S;  //Id_PORT_imap4_ssl_dp;
  FExplicitTLSProtPort := IdPORT_IMAP4;
  DefaultPort := IdPORT_IMAP4;
  ContextClass := TIdIMAP4PeerContext;
  FSaferMode := False;
  FUseDefaultMechanismsForUnassignedCommands := True;
{$IFDEF UNIX}
  FRootPath := GPathDelim + 'var' + GPathDelim + 'imapmail'; {Do not Localize}
{$ELSE}
  FRootPath := GPathDelim + 'imapmail'; {Do not Localize}
{$ENDIF}
  FDefaultPassword := 'admin'; {Do not Localize}
  FMailBoxSeparator := '.';   {Do not Localize}
end;

destructor TIdIMAP4Server.Destroy;
begin
  inherited Destroy;
end;

function TIdIMAP4Server.CreateExceptionReply: TIdReply;
begin
  Result := TIdReplyIMAP4.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(IMAP_BAD, 'Unknown Internal Error'); {do not localize}
end;

function TIdIMAP4Server.CreateGreeting: TIdReply;
begin
  Result := TIdReplyIMAP4.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(IMAP_OK, 'Welcome'); {do not localize}
end;

function TIdIMAP4Server.CreateHelpReply: TIdReply;
begin
  Result := TIdReplyIMAP4.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(IMAP_OK, 'Help follows'); {do not localize}
end;

function TIdIMAP4Server.CreateMaxConnectionReply: TIdReply;
begin
  Result := TIdReplyIMAP4.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(IMAP_BAD, 'Too many connections. Try again later.'); {do not localize}
end;

function TIdIMAP4Server.CreateReplyUnknownCommand: TIdReply;
begin
  Result := TIdReplyIMAP4.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(IMAP_BAD, 'Unknown command'); {do not localize}
end;

constructor TIdIMAP4PeerContext.Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FMailBox := TIdMailBox.Create;
  FLastCommand := TIdReplyIMAP4.Create(nil);
  FConnectionState := csAny;
end;

destructor TIdIMAP4PeerContext.Destroy;
begin
  FreeAndNil(FLastCommand);
  FreeAndNil(FMailBox);
  inherited Destroy;
end;

function TIdIMAP4PeerContext.GetUsingTLS: Boolean;
begin
  if Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    Result := not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end else begin
    Result := False;
  end;
end;

procedure TIdIMAP4Server.DoReplyUnknownCommand(AContext: TIdContext; AText: string);
//AText is ignored by TIdIMAP4Server
var
  LText: string;
begin
  LText := TIdIMAP4PeerContext(AContext).FLastCommand.SequenceNumber;
  if LText = '' then begin
    //This should not happen!
    LText := '*';    {Do not Localize}
  end;
  DoSendReply(AContext, LText + ' NO Unknown command'); {Do not Localize}
end;

function  TIdIMAP4Server.ExpungeRecords(ASender: TIdCommand): Boolean;
var
  LN: integer;
  LMessage: TIdMessage;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //Delete all records that have the deleted flag set...
  LN := 0;
  Result := True;
  while LN < LContext.MailBox.MessageList.Count do begin
    LMessage := LContext.MailBox.MessageList.Messages[LN];
    if mfDeleted in LMessage.Flags then begin
      if not OnDefMechDeleteMessage(LContext.LoginName, LContext.MailBox.Name, LMessage) then
      begin
        Result := False;
      end;
      LContext.MailBox.MessageList.Delete(LN);
      LContext.MailBox.TotalMsgs := LContext.MailBox.TotalMsgs - 1;
    end else begin
      Inc(LN);
    end;
  end;
end;

function TIdIMAP4Server.MessageSetToMessageNumbers(AUseUID: Boolean; ASender: TIdCommand;
  AMessageNumbers: TStrings; AMessageSet: string): Boolean;
{AMessageNumbers may be '7' or maybe '2:4' (2, 3 & 4) or maybe '2,4,6' (2, 4 & 6)
or maybe '1:*'}
var
  LPos: integer;
  LStart: Int64;
  LN: Int64;
  LEnd: Int64;
  LTemp: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  AMessageNumbers.BeginUpdate;
  try
    AMessageNumbers.Clear;
    //See is it a sequence like 2:4 ...
    LPos := IndyPos(':', AMessageSet);      {Do not Localize}
    if LPos > 0 then begin
      LTemp := Copy(AMessageSet, 1, LPos-1);
      LStart := IndyStrToInt64(LTemp);
      LTemp := Copy(AMessageSet, LPos+1, MAXINT);
      if LTemp = '*' then begin  {Do not Localize}
        if AUseUID then begin
          LEnd := IndyStrToInt64(LContext.MailBox.UIDNext)-1;
        end else begin
          LEnd := LContext.MailBox.MessageList.Count;
        end;
      end else begin
        LEnd := IndyStrToInt64(LTemp);
      end;
      // RLebeau 2/4/2020: using a 'while' loop instead of a 'for' loop, because the
      // LN variable is an Int64 and Delphi prior to XE8 will fail to compile on it
      // with a "For loop control variable must have ordinal type" error...
      {
      for LN := LStart to LEnd do begin
        AMessageNumbers.Add(IntToStr(LN));
      end;
      }
      LN := LStart;
      while LN <= LEnd do begin
        AMessageNumbers.Add(IntToStr(LN));
        Inc(LN);
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
  finally
    AMessageNumbers.EndUpdate;
  end;
  Result := True;
end;

//Return -1 if not found
function TIdIMAP4Server.GetRecordForUID(const AUID: String; AMailBox: TIdMailBox): Int64;
var
  LN: Integer;
  LUID: Int64;
begin
  // TODO: do string comparisons instead so that conversions are not needed?
  LUID := IndyStrToInt64(AUID);
  for LN := 0 to AMailBox.MessageList.Count-1 do begin
    if IndyStrToInt64(AMailBox.MessageList.Messages[LN].UID) = LUID then begin
      Result := LN;
      Exit;
    end;
  end;
  Result := -1;
end;

function TIdIMAP4Server.StripQuotesIfNecessary(AName: string): string;
begin
  if Length(AName) > 0 then begin
    if (AName[1] = '"') and (AName[Length(Result)] = '"') then begin  {Do not Localize}
      Result := Copy(AName, 2, Length(AName)-2);
      Exit;
    end;
  end;
  Result := AName;
end;

function TIdIMAP4Server.ReassembleParams(ASeparator: Char; AParams: TStrings;
  AParamToReassemble: Integer): Boolean;
var
  LEndSeparator: char;
  LTemp: string;
  LN: integer;
  LReassembledParam: string;
begin
  Result := False;
  case ASeparator of
    '(': LEndSeparator := ')';           {Do not Localize}
    '[': LEndSeparator := ']';           {Do not Localize}
    else LEndSeparator := ASeparator;
  end;
  LTemp := AParams[AParamToReassemble];
  if (LTemp = '') or (LTemp[1] <> ASeparator) then begin
    Exit;
  end;
  if LTemp[Length(LTemp)] = LEndSeparator then begin
    AParams[AParamToReassemble] := Copy(LTemp, 2, Length(LTemp)-2);
    Result := True;
    Exit;
  end;
  LReassembledParam := Copy(LTemp, 2, MAXINT);
  LN := AParamToReassemble + 1;
  repeat
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
  until False;
end;

//This reorganizes the parameter list on the basis that AMailBoxParam is a
//mailbox name, which may (if enclosed in quotes) be in more than one param.
//Example 1: '43' '"My' 'Documents"' '5' -> '43' 'My Documents' '5'
//Example 2: '43' '"MyDocs"' '5'         -> '43' 'MyDocs' '5'
//Example 3: '43' 'MyDocs' '5'           -> '43' 'MyDocs' '5'
function TIdIMAP4Server.ReinterpretParamAsMailBox(AParams: TStrings; AMailBoxParam: Integer): Boolean;
var
  LTemp: string;
begin
  if (AMailBoxParam < 0) or (AMailBoxParam >= AParams.Count) then begin
    Result := False;
    Exit;
  end;
  LTemp := AParams[AMailBoxParam];
  if LTemp = '' then begin
    Result := False;
    Exit;
  end;
  if LTemp[1] <> '"' then begin   {Do not Localize}
    Result := True;
    Exit;  //This is example 3, no change.
  end;
  Result := ReassembleParams('"', AParams, AMailBoxParam);  {Do not Localize}
end;

function TIdIMAP4Server.ReinterpretParamAsFlags(AParams: TStrings; AFlagsParam: Integer): Boolean;
begin
  Result := ReassembleParams('(', AParams, AFlagsParam);  {Do not Localize}
end;

function TIdIMAP4Server.ReinterpretParamAsQuotedStr(AParams: TStrings; AFlagsParam: integer): Boolean;
begin
  Result := ReassembleParams('"', AParams, AFlagsParam);  {Do not Localize}
end;

function TIdIMAP4Server.ReinterpretParamAsDataItems(AParams: TStrings; AFlagsParam: Integer): Boolean;
begin
  Result := ReassembleParams('(', AParams, AFlagsParam);  {Do not Localize}
end;

function TIdIMAP4Server.FlagStringToFlagList(AFlagList: TStrings; AFlagString: string): Boolean;
var
  LTemp: string;
begin
  AFlagList.BeginUpdate;
  try
    AFlagList.Clear;
    if (AFlagString <> '') and (AFlagString[1] = '(') and (AFlagString[Length(AFlagString)] = ')') then begin  {Do not Localize}
      LTemp := Copy(AFlagString, 2, Length(AFlagString)-2);
      BreakApart(LTemp, ' ', AFlagList); {Do not Localize}
      Result := True;
    end else begin
      Result := False;
    end;
  finally
    AFlagList.EndUpdate;
  end;
end;

procedure TIdIMAP4Server.ProcessFetch(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
//There are a pile of options for this.
var
  LMessageNumbers: TStringList;
  LDataItems: TStringList;
  LM: integer;
  LN: integer;
  LLO: integer;
  LRecord: Int64;
  LSize: Int64;
  LMessageToCheck, LMessageTemp: TIdMessage;
  LMessageRaw: TStringList;
  LTemp: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TStringList.Create;
  try
    if not MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) then begin
      SendBadReply(ASender, 'Error in syntax of message set parameter'); {Do not Localize}
      Exit;
    end;
    if not ReinterpretParamAsDataItems(AParams, 1) then begin
      SendBadReply(ASender, 'Fetch data items parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    LDataItems := TStringList.Create;
    try
      BreakApart(AParams[1], ' ', LDataItems);
      for LN := 0 to LMessageNumbers.Count-1 do begin
        if AUseUID then begin
          LRecord := GetRecordForUID(LMessageNumbers[LN], LContext.MailBox);
          if LRecord = -1 then begin //It is OK to skip non-existent UID records
            Continue;
          end;
        end else begin
          LRecord := IndyStrToInt64(LMessageNumbers[LN])-1;
        end;
        if (LRecord < 0) or (LRecord > LContext.MailBox.MessageList.Count) then begin
          SendBadReply(ASender, 'Message number %d does not exist', [LRecord+1]); {Do not Localize}
          Exit;
        end;
        LMessageToCheck := LContext.MailBox.MessageList.Messages[LRecord];
        for LLO := 0 to LDataItems.Count-1 do begin
          if TextIsSame(LDataItems[LLO], 'UID') then begin  {Do not Localize}
            //Format:
            //C9 FETCH 490 (UID)
            //* 490 FETCH (UID 6545)
            //C9 OK Completed
            DoSendReply(ASender.Context, '* FETCH (UID %s)', [LMessageToCheck.UID]); {Do not Localize}
          end
          else if TextIsSame(LDataItems[LLO], 'FLAGS') then begin  {Do not Localize}
            //Format:
            //C10 UID FETCH 6545 (FLAGS)
            //* 490 FETCH (FLAGS (\Recent) UID 6545)
            //C10 OK Completed
            if AUseUID then begin
              DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s) UID %s)',  {Do not Localize}
                [LRecord+1, MessageFlagSetToStr(LMessageToCheck.Flags), LMessageNumbers[LN]]);
            end else begin
              DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s))',  {Do not Localize}
                [LRecord+1, MessageFlagSetToStr(LMessageToCheck.Flags)]);
            end;
          end
          else if TextIsSame(LDataItems[LLO], 'RFC822.HEADER') then begin  {Do not Localize}
            //Format:
            //C11 UID FETCH 6545 (RFC822.HEADER)
            //* 490 FETCH (UID 6545 RFC822.HEADER {1654}
            //Return-Path: <Christina_Powell@secondhandcars.com>
            //...
            //Content-Type: multipart/alternative;
            //	boundary="----=_NextPart_000_70BE_C8606D03.F4EA24EE"
            //C10 OK Completed
            //We don't want to thrash UIDs and flags in MailBox message, so load into LMessage
            LMessageTemp := TIdMessage.Create;
            try
              if not OnDefMechGetMessageHeader(LContext.LoginName, LContext.MailBox.Name, LMessageToCheck, LMessageTemp) then begin
                SendNoReply(ASender, 'Failed to get message header'); {Do not Localize}
                Exit;
              end;
              //Need to calculate the size of the headers...
              LSize := 0;
              for LM := 0 to LMessageTemp.Headers.Count-1 do begin
                Inc(LSize, Length(LMessageTemp.Headers.Strings[LM]) + 2); //Allow for CR+LF
              end;
              if AUseUID then begin
                DoSendReply(ASender.Context, '* %d FETCH (UID %s RFC822.HEADER {%d}',  {Do not Localize}
                  [LRecord+1, LMessageNumbers[LN], LSize]);
              end else begin
                DoSendReply(ASender.Context, '* %d FETCH (RFC822.HEADER {%d}',  {Do not Localize}
                  [LRecord+1, LSize]);
              end;
              for LM := 0 to LMessageTemp.Headers.Count-1 do begin
                DoSendReply(ASender.Context, LMessageTemp.Headers.Strings[LM]);
              end;
              DoSendReply(ASender.Context, ')');  {Do not Localize}
              //Finished with the headers, free the memory...
            finally
              FreeAndNil(LMessageTemp);
            end;
          end
          else if TextIsSame(LDataItems[LLO], 'RFC822.SIZE') then begin  {Do not Localize}
            //Format:
            //C12 UID FETCH 6545 (RFC822.SIZE)
            //* 490 FETCH (UID 6545 RFC822.SIZE 3447)
            //C12 OK Completed
            LSize := OnDefMechGetMessageSize(LContext.LoginName, LContext.MailBox.Name, LMessageToCheck);
            if LSize = -1 then begin
              SendNoReply(ASender, 'Failed to get message size'); {Do not Localize}
              Exit;
            end;
            if AUseUID then begin
              DoSendReply(ASender.Context, '* %d FETCH (UID %s RFC822.SIZE %d)',  {Do not Localize}
                [LRecord+1, LMessageNumbers[LN], LSize]);
            end else begin
              DoSendReply(ASender.Context, '* %d FETCH (RFC822.SIZE %d)',  {Do not Localize}
                [LRecord+1, LSize]);
            end;
          end
          else if PosInStrArray(LDataItems[LLO], ['BODY.PEEK[]', 'BODY[]', 'RFC822', 'RFC822.PEEK'], False) <> -1 then   {Do not Localize}
          begin
            //All are the same, except the return string is different...
            LMessageRaw := TStringList.Create;
            try
              if not OnDefMechGetMessageRaw(LContext.LoginName, LContext.MailBox.Name, LMessageToCheck, LMessageRaw) then
              begin
                SendNoReply(ASender, 'Failed to get raw message'); {Do not Localize}
                Exit;
              end;
              LSize := 0;
              for LM := 0 to LMessageToCheck.Headers.Count-1 do begin
                Inc(LSize, Length(LMessageRaw.Strings[LM]) + 2); //Allow for CR+LF
              end;
              Inc(LSize, 3);  //The message terminator '.CRLF'
              LTemp := Copy(AParams[1], 2, Length(AParams[1])-2);
              if AUseUID then begin
                DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s) UID %s %s {%d}',  {Do not Localize}
                  [LRecord+1, MessageFlagSetToStr(LMessageToCheck.Flags), LMessageNumbers[LN], LTemp, LSize]);
              end else begin
                DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s) %s {%d}',  {Do not Localize}
                  [LRecord+1, MessageFlagSetToStr(LMessageToCheck.Flags), LTemp, LSize]);
              end;
              for LM := 0 to LMessageToCheck.Headers.Count-1 do begin
                DoSendReply(ASender.Context, LMessageRaw.Strings[LM]);
              end;
              DoSendReply(ASender.Context, '.');  {Do not Localize}
              DoSendReply(ASender.Context, ')');  {Do not Localize}
              //Free the memory...
            finally
	      FreeAndNil(LMessageRaw);
            end;
          end
          else if TextIsSame(LDataItems[LLO], 'BODYSTRUCTURE') then begin  {Do not Localize}
            //Format:
            //C49 UID FETCH 6545 (BODYSTRUCTURE)
            //* 490 FETCH (UID 6545 BODYSTRUCTURE (("TEXT" "PLAIN" ("CHARSET" "iso-8859-1") NIL NIL "7BIT" 290 8 NIL NIL NIL)("TEXT" "HTML" ("CHARSET" "iso-8859-1") NIL NIL "7BIT" 1125 41 NIL NIL NIL) "ALTERNATIVE" ("BOUNDARY"
            //C12 OK Completed
            SendBadReply(ASender, 'Parameter not supported: ' + AParams[1]); {Do not Localize}
          end
          else if TextStartsWith(LDataItems[LLO], 'BODY[') or TextStartsWith(LDataItems[LLO], 'BODY.PEEK[') then begin  {Do not Localize}
            //Format:
            //C50 UID FETCH 6545 (BODY[1])
            //* 490 FETCH (FLAGS (\Recent \Seen) UID 6545 BODY[1] {290}
            //...
            //)
            //C50 OK Completed
            SendBadReply(ASender, 'Parameter not supported: ' + AParams[1]); {Do not Localize}
          end
          else begin
            SendBadReply(ASender, 'Parameter not supported: ' + AParams[1]); {Do not Localize}
            Exit;
          end;
        end;
      end;
    finally
      FreeAndNil(LDataItems);
    end;
  finally
    FreeAndNil(LMessageNumbers);
  end;
  SendOkReply(ASender, 'Completed');  {Do not Localize}
end;

procedure TIdIMAP4Server.ProcessSearch(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
//if AUseUID is True, return UIDs rather than relative message numbers.
var
  LSearchString: string;
  LN: Integer;
  LM: Integer;
  LItem: Integer;
  LMessageToCheck, LMessageTemp: TIdMessage;
  LHits: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //Watch out: you could become an old man trying to implement all the IMAP
  //search options, just do a subset.
  //Format:
  //C1065 UID SEARCH FROM "visible"
  //* SEARCH 5769 5878
  //C1065 OK Completed (2 msgs in 0.010 secs)
  if AParams.Count < 2 then begin  //The only search options we support are 2-param ones
    SendIncorrectNumberOfParameters(ASender);
    //LParams.Free;
    Exit;
  end;
  LItem := PosInStrArray(AParams[0], ['FROM', 'TO', 'CC', 'BCC', 'SUBJECT'], False);
  if LItem = -1 then begin {Do not Localize}
    SendBadReply(ASender, 'Unsupported search method'); {Do not Localize}
    Exit;
  end;
  //Reassemble the other params into a line, because "Ciaran Costelloe" will be params 1 & 2...
  LSearchString := AParams[1];
  for LN := 2 to AParams.Count-1 do begin
    LSearchString := LSearchString + ' ' + AParams[LN];  {Do not Localize}
  end;
  if (LSearchString[1] = '"') and (LSearchString[Length(LSearchString)] = '"') then begin  {Do not Localize}
    LSearchString := Copy(LSearchString, 2, Length(LSearchString)-2);
  end;

  LHits := '';
  LMessageTemp := TIdMessage.Create;
  try
    for LN := 0 to LContext.MailBox.MessageList.Count-1 do begin
      LMessageToCheck := LContext.MailBox.MessageList.Messages[LN];
      if not OnDefMechGetMessageHeader(LContext.LoginName, LContext.MailBox.Name, LMessageToCheck, LMessageTemp) then
      begin
        SendNoReply(ASender, 'Failed to get message header'); {Do not Localize}
        Exit;
      end;
      case LItem of
        0: // FROM   {Do not Localize}
          begin
            if Pos(UpperCase(LSearchString), UpperCase(LMessageTemp.From.Address)) > 0 then begin
              if AUseUID then begin
                LHits := LHits + LMessageToCheck.UID + ' ';  {Do not Localize}
              end else begin
                LHits := LHits + IntToStr(LN+1) + ' ';  {Do not Localize}
              end;
            end;
          end;
        1: // TO   {Do not Localize}
          begin
            for LM := 0 to LMessageTemp.Recipients.Count-1 do begin
              if Pos(UpperCase(LSearchString), UpperCase(LMessageTemp.Recipients.Items[LM].Address)) > 0 then begin
                if AUseUID then begin
                  LHits := LHits + LMessageToCheck.UID + ' ';  {Do not Localize}
                end else begin
                  LHits := LHits + IntToStr(LN+1) + ' ';  {Do not Localize}
                end;
                Break; //Don't want more than 1 hit on this record
              end;
            end;
          end;
        2: // CC   {Do not Localize}
          begin
            for LM := 0 to LMessageTemp.Recipients.Count-1 do begin
              if Pos(UpperCase(LSearchString), UpperCase(LMessageTemp.CCList.Items[LM].Address)) > 0 then begin
                if AUseUID then begin
                  LHits := LHits + LMessageToCheck.UID + ' ';  {Do not Localize}
                end else begin
                  LHits := LHits + IntToStr(LN+1) + ' ';  {Do not Localize}
                end;
                Break; //Don't want more than 1 hit on this record
              end;
            end;
          end;
        3: // BCC   {Do not Localize}
          begin
            for LM := 0 to LMessageTemp.Recipients.Count-1 do begin
              if Pos(UpperCase(LSearchString), UpperCase(LMessageTemp.BCCList.Items[LM].Address)) > 0 then begin
                if AUseUID then begin
                  LHits := LHits + LMessageToCheck.UID + ' ';  {Do not Localize}
                end else begin
                  LHits := LHits + IntToStr(LN+1) + ' ';  {Do not Localize}
                end;
                Break; //Don't want more than 1 hit on this record
              end;
            end;
          end;
      else // SUBJECT   {Do not Localize}
        begin
          if Pos(UpperCase(LSearchString), UpperCase(LMessageTemp.Subject)) > 0 then begin
            if AUseUID then begin
              LHits := LHits + LMessageToCheck.UID + ' ';  {Do not Localize}
            end else begin
              LHits := LHits + IntToStr(LN+1) + ' ';  {Do not Localize}
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(LMessageTemp);
  end;
  DoSendReply(ASender.Context, '* SEARCH ' + TrimRight(LHits)); {Do not Localize}
  SendOkReply(ASender, 'Completed');  {Do not Localize}
end;

procedure TIdIMAP4Server.ProcessCopy(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings);
var
  LMessageNumbers: TStringList;
  LN: Integer;
  LRecord: Int64;
  LResult: Boolean;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //Format is "C1 COPY 2:4 MEETINGFOLDER"
  if AParams.Count < 2 then begin
    SendIncorrectNumberOfParameters(ASender);
    Exit;
  end;
  if not OnDefMechReinterpretParamAsMailBox(AParams, 1) then begin
    SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
    Exit;
  end;
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TStringList.Create;
  try
    if not MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) then begin
      SendBadReply(ASender, 'Error in syntax of message set parameter'); {Do not Localize}
      Exit;
    end;
    if not Assigned(OnDefMechDoesImapMailBoxExist) then begin
      SendUnassignedDefaultMechanism(ASender);
      Exit;
    end;
    if not OnDefMechDoesImapMailBoxExist(LContext.LoginName, AParams[1]) then begin
      SendNoReply(ASender, 'Mailbox does not exist.'); {Do not Localize}
      Exit;
    end;
    LResult := True;
    for LN := 0 to LMessageNumbers.Count-1 do begin
      if AUseUID then begin
        LRecord := GetRecordForUID(LMessageNumbers[LN], LContext.MailBox);
        if LRecord = -1 then begin //It is OK to skip non-existent UID records
          Continue;
        end;
      end else begin
        LRecord := IndyStrToInt64(LMessageNumbers[LN])-1;
      end;
      if (LRecord < 0) or (LRecord >= LContext.MailBox.MessageList.Count) then begin
        LResult := False;
      end
      else if not OnDefMechCopyMessage(LContext.LoginName, LContext.MailBox.Name,
        LContext.MailBox.MessageList.Messages[LRecord].UID, AParams[1]) then
      begin
        LResult := False;
      end;
    end;
    if LResult then begin
      SendOkReply(ASender, 'Completed');  {Do not Localize}
    end else begin
      SendNoReply(ASender, 'Copy failed for one or more messages'); {Do not Localize}
    end;
  finally
    FreeAndNil(LMessageNumbers);
  end;
end;

function TIdIMAP4Server.ProcessStore(AUseUID: Boolean; ASender: TIdCommand; AParams: TStrings): Boolean;
const
  LCMsgFlags: array[0..4] of TIdMessageFlags = ( mfAnswered, mfFlagged, mfDeleted, mfDraft, mfSeen );
var
  LMessageNumbers: TStringList;
  LFlagList: TStringList;
  LN: integer;
  LM: integer;
  LRecord: Int64;
  LFlag: integer;
  LTemp: string;
  LStoreMethod: TIdIMAP4StoreDataItem;
  LSilent: Boolean;
  LMessage: TIdMessage;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //Format is:
  //C53 UID STORE 6545,6544 +FLAGS.SILENT (\Deleted)
  //C53 OK Completed
  Result := False;
  if AParams.Count < 3 then begin
    SendIncorrectNumberOfParameters(ASender);
    Exit;
  end;
  //First param is a message set, e.g. 41 or 2:5 (which is 2, 3, 4 & 5)
  LMessageNumbers := TStringList.Create;
  try
    if not MessageSetToMessageNumbers(AUseUID, ASender, LMessageNumbers, AParams[0]) then begin
      SendBadReply(ASender, 'Error in syntax of message set parameter'); {Do not Localize}
      Exit;
    end;
    LTemp := AParams[1];
    if LTemp[1] = '+' then begin  {Do not Localize}
      LStoreMethod := sdAdd;
      LTemp := Copy(LTemp, 2, MaxInt);
    end else if LTemp[1] = '-' then begin  {Do not Localize}
      LStoreMethod := sdRemove;
      LTemp := Copy(LTemp, 2, MaxInt);
    end else begin
      LStoreMethod := sdReplace;
    end;
    if TextIsSame(LTemp, 'FLAGS') then begin  {Do not Localize}
      LSilent := False;
    end else if TextIsSame(LTemp, 'FLAGS.SILENT') then begin  {Do not Localize}
      LSilent := True;
    end else begin
      SendBadReply(ASender, 'Error in syntax of FLAGS parameter'); {Do not Localize}
      Exit;
    end;
    LFlagList := TStringList.Create;
    try
      //Assemble remaining flags back into a string...
      LTemp := AParams[2];
      for LN := 3 to AParams.Count-1 do begin
        LTemp := LTemp + ' ' + AParams[LN];  {Do not Localize}
      end;
      if not FlagStringToFlagList(LFlagList, LTemp) then begin
        SendBadReply(ASender, 'Error in syntax of flag set parameter'); {Do not Localize}
        Exit;
      end;
      for LN := 0 to LMessageNumbers.Count-1 do begin
        if AUseUID then begin
          LRecord := GetRecordForUID(LMessageNumbers[LN], LContext.MailBox);
          if LRecord = -1 then begin //It is OK to skip non-existent UID records
            Continue;
          end;
        end else begin
          LRecord := IndyStrToInt64(LMessageNumbers[LN])-1;
        end;
        if (LRecord < 0) or (LRecord > LContext.MailBox.MessageList.Count) then begin
          SendBadReply(ASender, 'Message number %d does not exist', [LRecord+1]); {Do not Localize}
          Exit;
        end;
        LMessage := LContext.MailBox.MessageList.Messages[LRecord];
        if LStoreMethod = sdReplace then begin
          LMessage.Flags := [];
        end;
        for LM := 0 to LFlagList.Count-1 do begin
          //Support \Answered \Flagged \Deleted \Draft \Seen
          LFlag := PosInStrArray(LFlagList[LM], ['\Answered', '\Flagged', '\Deleted', '\Draft', '\Seen'], False);   {Do not Localize}
          if LFlag = -1 then begin
            Continue;
          end;
          case LStoreMethod of
            sdAdd, sdReplace:
              begin
                LMessage.Flags := LMessage.Flags + [LCMsgFlags[LFlag]];
              end;
            sdRemove:
              begin
                LMessage.Flags := LMessage.Flags - [LCMsgFlags[LFlag]];
              end;
          end;
        end;
        if not LSilent then begin
          //In this case, send to the client the current flags.
          //The response is '* 43 FETCH (FLAGS (\Seen))' with the UID version
          //being '* 43 FETCH (FLAGS (\Seen) UID 1234)'.  Note the first number is the
          //relative message number in BOTH cases.
          if AUseUID then begin
            DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s) UID %s)', {Do not Localize}
              [LRecord+1, MessageFlagSetToStr(LMessage.Flags), LMessageNumbers[LN]]);
          end else begin
            DoSendReply(ASender.Context, '* %d FETCH (FLAGS (%s))', {Do not Localize}
              [LRecord+1, MessageFlagSetToStr(LMessage.Flags)]);
          end;
        end;
      end;
      SendOkReply(ASender, 'STORE Completed'); {Do not Localize}
    finally
      FreeAndNil(LFlagList);
    end;
  finally
    FreeAndNil(LMessageNumbers);
  end;
  Result := True;
end;

procedure TIdIMAP4Server.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CAPABILITY';  {do not localize}
  LCommandHandler.OnCommand := DoCommandCAPABILITY;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NOOP';  {do not localize}
  LCommandHandler.OnCommand := DoCommandNOOP;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LOGOUT';  {do not localize}
  LCommandHandler.OnCommand := DoCommandLOGOUT;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTHENTICATE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandAUTHENTICATE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LOGIN'; {do not localize}
  LCommandHandler.OnCommand := DoCommandLOGIN;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SELECT';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSELECT;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'EXAMINE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandEXAMINE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CREATE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandCREATE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'DELETE';  {do not localize}
  LCommandHandler.OnCommand := DoCommandDELETE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'RENAME';  {do not localize}
  LCommandHandler.OnCommand := DoCommandRENAME;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SUBSCRIBE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandSUBSCRIBE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'UNSUBSCRIBE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandUNSUBSCRIBE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST';  {do not localize}
  LCommandHandler.OnCommand := DoCommandLIST;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LSUB';  {do not localize}
  LCommandHandler.OnCommand := DoCommandLSUB;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STATUS';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSTATUS;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'APPEND';  {do not localize}
  LCommandHandler.OnCommand := DoCommandAPPEND;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CHECK'; {do not localize}
  LCommandHandler.OnCommand := DoCommandCHECK;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CLOSE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandCLOSE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'EXPUNGE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandEXPUNGE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SEARCH';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSEARCH;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'FETCH'; {do not localize}
  LCommandHandler.OnCommand := DoCommandFETCH;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STORE'; {do not localize}
  LCommandHandler.OnCommand := DoCommandSTORE;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'COPY';  {do not localize}
  LCommandHandler.OnCommand := DoCommandCOPY;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'UID'; {do not localize}
  LCommandHandler.OnCommand := DoCommandUID;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'X'; {do not localize}
  LCommandHandler.OnCommand := DoCommandX;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STARTTLS';  {do not localize}
  LCommandHandler.OnCommand := DoCommandSTARTTLS;
  LCommandHandler.NormalReply.Code := IMAP_OK;

  FCommandHandlers.OnBeforeCommandHandler := DoBeforeCmd;
  FCommandHandlers.OnCommandHandlersException := DoCmdHandlersException;
end;

//Command handlers

procedure TIdIMAP4Server.DoBeforeCmd(ASender: TIdCommandHandlers; var AData: string;
  AContext: TIdContext);
begin
  TIdIMAP4PeerContext(AContext).FLastCommand.ParseRequest(AData);  //Main purpose is to get sequence number, like C11 from 'C11 CAPABILITY'
  TIdIMAP4PeerContext(AContext).FIMAP4Tag := Fetch(AData, ' ');
  AData := Trim(AData);
  if Assigned(FOnBeforeCmd) then begin
    FOnBeforeCmd(ASender, AData, AContext);
  end;
end;

procedure TIdIMAP4Server.DoSendReply(AContext: TIdContext; const AData: string);
begin
  if Assigned(FOnBeforeSend) then begin
    FOnBeforeSend(AContext, AData);
  end;
  AContext.Connection.IOHandler.WriteLn(AData);
end;

procedure TIdIMAP4Server.DoSendReply(AContext: TIdContext; const AFormat: string; const Args: array of const);
begin
  DoSendReply(AContext, IndyFormat(AFormat, Args));
end;

procedure TIdIMAP4Server.DoCmdHandlersException(ACommand: String; AContext: TIdContext);
var
  LTag, LCmd: String;
begin
  if Assigned(FOnCommandError) then begin
    LTag := Fetch(ACommand, ' ');
    LCmd := Fetch(ACommand, ' ');
    OnCommandError(AContext, LTag, LCmd);
  end;
end;

procedure TIdIMAP4Server.DoCommandCAPABILITY(ASender: TIdCommand);
begin
  if Assigned(FOnCommandCAPABILITY) then begin
    OnCommandCAPABILITY(ASender.Context, TIdIMAP4PeerContext(ASender.Context).IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {Tell the client our capabilities...}
  DoSendReply(ASender.Context, '* CAPABILITY IMAP4rev1 AUTH=PLAIN'); {Do not Localize}
  SendOkReply(ASender, 'Completed'); {Do not Localize}
end;

procedure TIdIMAP4Server.DoCommandNOOP(ASender: TIdCommand);
begin
  if Assigned(FOnCommandNOOP) then begin
    OnCommandNOOP(ASender.Context, TIdIMAP4PeerContext(ASender.Context).IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {On most servers, this does nothing (they use a timeout to disconnect users,
  irrespective of NOOP commands, so they always return OK.  If you really
  want to implement it, use a countdown timer to force disconnects but reset
  the counter if ANY command received, including NOOP.}
  SendOkReply(ASender, 'Completed');  {Do not Localize}
end;

procedure TIdIMAP4Server.DoCommandLOGOUT(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if Assigned(FOnCommandLOGOUT) then begin
    OnCommandLOGOUT(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {Be nice and say ByeBye first...}
  DoSendReply(ASender.Context, '* BYE May your God go with you.'); {Do not Localize}
  SendOkReply(ASender, 'Completed');  {Do not Localize}
  LContext.Connection.Disconnect(False);
  LContext.MailBox.Clear;
  LContext.RemoveFromList;
end;

procedure TIdIMAP4Server.DoCommandAUTHENTICATE(ASender: TIdCommand);
begin
  if Assigned(FOnCommandAUTHENTICATE) then begin
    {
    Important, when usng TLS and FUseTLS=utUseRequireTLS, do not accept any authentication
    information until TLS negotiation is completed.  This insistance is a security feature.

    Some networks should choose security over interoperability while other places may
    sacrafice interoperability over security.  It comes down to sensible administrative
    judgement.
    }
    if (FUseTLS = utUseRequireTLS) and (not TIdIMAP4PeerContext(ASender.Context).UsingTLS) then begin
      MustUseTLS(ASender);
    end else begin
      OnCommandAUTHENTICATE(ASender.Context, TIdIMAP4PeerContext(ASender.Context).IMAP4Tag, ASender.UnparsedParams);
    end;
  end;
end;

procedure TIdIMAP4Server.MustUseTLS(ASender: TIdCommand);
begin
  DoSendReply(ASender.Context, 'NO ' + RSSMTPSvrReqSTARTTLS); {Do not Localize}
  ASender.Disconnect := True;
end;

procedure TIdIMAP4Server.DoCommandLOGIN(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);

  if Assigned(fOnCommandLOGIN) then begin
    {
    Important, when using TLS and FUseTLS=utUseRequireTLS, do not accept any authentication
    information until TLS negotiation is completed.  This insistance is a security feature.

    Some networks should choose security over interoperability while other places may
    sacrafice interoperability over security.  It comes down to sensible administrative
    judgement.
    }
    if (FUseTLS = utUseRequireTLS) and (not TIdIMAP4PeerContext(ASender.Context).UsingTLS) then begin
      MustUseTLS(ASender);
    end else begin
      OnCommandLOGIN(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    end;
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechDoesImapMailBoxExist) then begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 2 then begin
      //Incorrect number of params...
      if FSaferMode then begin
        SendNoReply(ASender);
      end else begin
        SendIncorrectNumberOfParameters(ASender);
      end;
      Exit;
    end;
    //See if we have a directory under FRootPath of that user's name...
    //if DoesImapMailBoxExist(LParams[0], '') = False then begin
    if not OnDefMechDoesImapMailBoxExist(LParams[0], '') then begin
      if FSaferMode then begin
        SendNoReply(ASender);
      end else begin
        SendNoReply(ASender, 'Unknown username'); {Do not Localize}
      end;
      Exit;
    end;
    //See is it the correct password...
    if not TextIsSame(FDefaultPassword, LParams[1]) then begin
      if FSaferMode then begin
        SendNoReply(ASender);
      end else begin
        SendNoReply(ASender, 'Incorrect password'); {Do not Localize}
      end;
      Exit;
    end;
    //Successful login, change context's state to logged in...
    LContext.LoginName := LParams[0];
    LContext.FConnectionState := csAuthenticated;
    SendOkReply(ASender, 'Completed');  {Do not Localize}
  finally
    FreeAndNil(LParams);
  end;
end;

//SELECT and EXAMINE are the same except EXAMINE opens the mailbox read-only
procedure TIdIMAP4Server.DoCommandSELECT(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState = csSelected then begin
    LContext.MailBox.Clear;
    LContext.FConnectionState := csAuthenticated;
  end;
  if LContext.ConnectionState <> csAuthenticated then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandSELECT) then begin
    OnCommandSELECT(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechOpenMailBox) then begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  if OnDefMechOpenMailBox(ASender, False) then begin  //SELECT opens the mailbox read-write
    LContext.FConnectionState := csSelected;
    SendOkReply(ASender, '[READ-WRITE] Completed'); {Do not Localize}
  end;
end;

//SELECT and EXAMINE are the same except EXAMINE opens the mailbox read-only
procedure TIdIMAP4Server.DoCommandEXAMINE(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandEXAMINE) then begin
    OnCommandEXAMINE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechOpenMailBox) then begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  if OnDefMechOpenMailBox(ASender, True) then begin  //EXAMINE opens the mailbox read-only
    LContext.FConnectionState := csSelected;
    SendOkReply(ASender, '[READ-ONLY] Completed'); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.DoCommandCREATE(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);

  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(FOnCommandCREATE) then begin
    OnCommandCREATE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechDoesImapMailBoxExist))
    or (not Assigned(OnDefMechCreateMailBox)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 0) then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(LContext.LoginName, LParams[0]) then begin
      SendBadReply(ASender, 'Mailbox already exists.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechCreateMailBox(LContext.LoginName, LParams[0]) then begin
      SendOkReply(ASender, 'Completed');  {Do not Localize}
    end else begin
      SendNoReply(ASender, 'Create failed'); {Do not Localize}
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandDELETE(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);

  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(FOnCommandDELETE) then begin
    OnCommandDELETE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechDoesImapMailBoxExist))
    or (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechDeleteMailBox))
    or (not Assigned(OnDefMechIsMailBoxOpen)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //Make sure we don't have the mailbox open by anyone
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 0) then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechIsMailBoxOpen(LContext.LoginName, LParams[0]) then begin
      SendNoReply(ASender, 'Mailbox is in use.'); {Do not Localize}
      Exit;
    end;
    if not OnDefMechDoesImapMailBoxExist(LContext.LoginName, LParams[0]) then begin
      SendNoReply(ASender, 'Mailbox does not exist.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechDeleteMailBox(LContext.LoginName, LParams[0]) then begin
      SendOkReply(ASender, 'Completed');  {Do not Localize}
    end else begin
      SendNoReply(ASender, 'Delete failed'); {Do not Localize}
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandRENAME(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  {
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  }
  if Assigned(FOnCommandRENAME) then begin
    OnCommandRENAME(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechDoesImapMailBoxExist))
    or (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechRenameMailBox))
    or (not Assigned(OnDefMechIsMailBoxOpen)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //Make sure we don't have the mailbox open by anyone
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 2 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 0) then begin
      SendBadReply(ASender, 'First mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechIsMailBoxOpen(LContext.LoginName, LParams[0]) then begin
      SendNoReply(ASender, 'Mailbox is in use.'); {Do not Localize}
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 1) then begin
      SendBadReply(ASender, 'Second mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    if not OnDefMechDoesImapMailBoxExist(LContext.LoginName, LParams[0]) then begin
      SendNoReply(ASender, 'Mailbox to be renamed does not exist.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechDoesImapMailBoxExist(LContext.LoginName, LParams[1]) then begin
      SendNoReply(ASender, 'Destination mailbox already exists.'); {Do not Localize}
      Exit;
    end;
    if OnDefMechRenameMailBox(LContext.LoginName, LParams[0], LParams[1]) then begin
      SendOkReply(ASender, 'Completed');  {Do not Localize}
    end else begin
      SendNoReply(ASender, 'Delete failed'); {Do not Localize}
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandSUBSCRIBE(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(FOnCommandSUBSCRIBE) then begin
    OnCommandSUBSCRIBE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {Not clear exactly what this would do in this sample mechanism...}
  SendUnsupportedCommand(ASender);
end;

procedure TIdIMAP4Server.DoCommandUNSUBSCRIBE(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(FOnCommandUNSUBSCRIBE) then begin
    OnCommandUNSUBSCRIBE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {Not clear exactly what this would do in this sample mechanism...}
  SendUnsupportedCommand(ASender);
end;

procedure TIdIMAP4Server.DoCommandLIST(ASender: TIdCommand);
var
  LParams: TStringList;
  LMailBoxNames: TStringList;
  LMailBoxFlags: TStringList;
  LN: integer;
  LEntry: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandLIST) then begin
    OnCommandLIST(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechListMailBox) then begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //The default mechanism only supports the following format:
  //  LIST "" *
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 2 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if LParams[1] <> '*' then begin  {Do not Localize}
      SendBadReply(ASender, 'Parameter not supported, 2nd (last) parameter must be *'); {Do not Localize}
      Exit;
    end;
    LMailBoxNames := TStringList.Create;
    try
      LMailBoxFlags := TStringList.Create;
      try
        if OnDefMechListMailBox(LContext.LoginName, LParams[0], LMailBoxNames, LMailBoxFlags) then begin
          for LN := 0 to LMailBoxNames.Count-1 do begin
            //Replies are of the form:
            //* LIST (\HasNoChildren) "." "INBOX.CreatedFolder"
            LEntry := '* LIST (';  {Do not Localize}
            if LMailBoxFlags[LN] <> '' then begin
              LEntry := LEntry + LMailBoxFlags[LN];
            end;
            LEntry := LEntry + ') "' + MailBoxSeparator + '" "' + LMailBoxNames[LN] + '"';  {Do not Localize}
            DoSendReply(ASender.Context, LEntry); {Do not Localize}
          end;
          SendOkReply(ASender, 'Completed');  {Do not Localize}
        end else begin
          SendNoReply(ASender, 'List failed'); {Do not Localize}
        end;
      finally
        FreeAndNil(LMailBoxFlags);
      end;
    finally
      FreeAndNil(LMailBoxNames);
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandLSUB(ASender: TIdCommand);
var
  LParams: TStringList;
  LMailBoxNames: TStringList;
  LMailBoxFlags: TStringList;
  LN: integer;
  LEntry: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandLSUB) then begin
    OnCommandLSUB(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechListMailBox) then begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //Treat this the same as LIST...
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 2 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if LParams[1] <> '*' then begin  {Do not Localize}
      SendBadReply(ASender, 'Parameter not supported, 2nd (last) parameter must be *'); {Do not Localize}
      Exit;
    end;
    LMailBoxNames := TStringList.Create;
    try
      LMailBoxFlags := TStringList.Create;
      try
        if OnDefMechListMailBox(LContext.LoginName, LParams[0], LMailBoxNames, LMailBoxFlags) then begin
          for LN := 0 to LMailBoxNames.Count-1 do begin
            //Replies are of the form:
            //* LIST (\HasNoChildren) "." "INBOX.CreatedFolder"
            LEntry := '* LIST (';  {Do not Localize}
            if LMailBoxFlags[LN] <> '' then begin
              LEntry := LEntry + LMailBoxFlags[LN];
            end;
            LEntry := LEntry + ') "' + MailBoxSeparator + '" "' + LMailBoxNames[LN] + '"';  {Do not Localize}
            DoSendReply(ASender.Context, LEntry); {Do not Localize}
          end;
          SendOkReply(ASender, 'Completed');  {Do not Localize}
        end else begin
          SendNoReply(ASender, 'List failed'); {Do not Localize}
        end;
      finally
        FreeAndNil(LMailBoxFlags);
      end;
    finally
      FreeAndNil(LMailBoxNames);
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandSTATUS(ASender: TIdCommand);
var
  LMailBox: TIdMailBox;
  LN: integer;
  LParams: TStringList;
  LTemp: string;
  LAnswer: string;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if not (LContext.ConnectionState in [csAuthenticated, csSelected]) then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandSTATUS) then begin
    OnCommandSTATUS(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechDoesImapMailBoxExist))
    or (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechSetupMailbox)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //This can be issued for ANY mailbox, not just the currently selected one.
  //The format is:
  //C5 STATUS "INBOX" (MESSAGES RECENT UIDNEXT UIDVALIDITY UNSEEN)
  //* STATUS INBOX (MESSAGES 490 RECENT 132 UIDNEXT 6546 UIDVALIDITY 1065090323 UNSEEN 167)
  //C5 OK Completed
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 0) then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    if not OnDefMechDoesImapMailBoxExist(LContext.LoginName, LParams[0]) then begin
      SendNoReply(ASender, 'Mailbox does not exist.'); {Do not Localize}
      Exit;
    end;
    {Get everything you need for this mailbox...}
    LMailBox := TIdMailBox.Create;
    try
      OnDefMechSetupMailbox(LContext.LoginName, LParams[0], LMailBox);
      {Send the stats...}
      LAnswer := '* STATUS ' + LParams[0] + ' (';  {Do not Localize}
      for LN := 1 to LParams.Count-1 do begin
        LTemp := LParams[LN];
        if LTemp <> '' then begin
          //Strip brackets (will be on 1st & last param)
          if LTemp[1] = '(' then begin  {Do not Localize}
            LTemp := Copy(LTemp, 2, MaxInt);
          end;
          if (LTemp <> '') and (LTemp[Length(LTemp)] = ')') then begin  {Do not Localize}
            LTemp := Copy(LTemp, 1, Length(LTemp)-1);
          end;
          case PosInStrArray(LTemp, ['MESSAGES', 'RECENT', 'UIDNEXT', 'UIDVALIDITY', 'UNSEEN'], False) of
            0: // MESSAGES   {Do not Localize}
              begin
                LAnswer := LAnswer + LTemp + ' ' + IntToStr(LMailBox.TotalMsgs) + ' ';  {Do not Localize}
              end;
            1: // RECENT   {Do not Localize}
              begin
                LAnswer := LAnswer + LTemp + ' ' + IntToStr(LMailBox.RecentMsgs) + ' ';  {Do not Localize}
              end;
            2: // UIDNEXT   {Do not Localize}
              begin
                LAnswer := LAnswer + LTemp + ' ' + LMailBox.UIDNext + ' ';  {Do not Localize}
              end;
            3: // UIDVALIDITY   {Do not Localize}
              begin
                LAnswer := LAnswer + LTemp + ' ' + LMailBox.UIDValidity + ' ';  {Do not Localize}
              end;
            4: // UNSEEN   {Do not Localize}
              begin
                LAnswer := LAnswer + LTemp + ' ' + IntToStr(LMailBox.UnseenMsgs) + ' ';  {Do not Localize}
              end;
          else
            begin
              SendBadReply(ASender, 'Parameter not supported: ' + LTemp);   {Do not Localize}
              Exit;
            end;
          end;
        end;
      end;
      if LAnswer[Length(LAnswer)] = ' ' then begin  {Do not Localize}
        LAnswer := Copy(LAnswer, 1, Length(LAnswer)-1);
      end;
      LAnswer := LAnswer + ')';  {Do not Localize}
      DoSendReply(ASender.Context, LAnswer);
      SendOkReply(ASender, 'Completed');  {Do not Localize}
    finally
      FreeAndNil(LMailBox);
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandAPPEND(ASender: TIdCommand);
var
  LUID: string;
  LStream: TStream;
  LFile: string;
  LTemp: string;
  LParams: TStringList;
  LParams2: TStringList;
  LFlagsList: TStringList;
  LSize: Int64;
  LFlags, LInternalDateTime: string;
  LN: integer;
  LMessage: TIdMessage;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  //You do NOT need to be in selected state for this.
  if LContext.ConnectionState <> csAuthenticated then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(FOnCommandAPPEND) then begin
    OnCommandAPPEND(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechGetNextFreeUID))
    or (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechUpdateNextFreeUID))
    or (not Assigned(OnDefMechDeleteMessage))  //Needed to reverse out a save if setting flags fail
    or (not Assigned(OnDefMechGetFileNameToWriteAppendMessage)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  //Format (the flags and date/time are optional):
  //C323 APPEND "INBOX.Sent" (\Seen) "internal date/time" {1876}
  //+ go ahead
  //...
  //C323 OK [APPENDUID 1065095982 105] Completed
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 2 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    if not OnDefMechReinterpretParamAsMailBox(LParams, 0) then begin
      SendBadReply(ASender, 'Mailbox parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    LFlags := '';
    LInternalDateTime := '';
    LN := 1;
    LTemp := LParams[Ln];
    if TextStartsWith(LTemp, '(') then begin  {Do not Localize}
      if not ReinterpretParamAsFlags(LParams, Ln) then begin
        SendBadReply(ASender, 'Flags parameter is invalid.'); {Do not Localize}
        Exit;
      end;
      LFlags := LParams[Ln];
      Inc(Ln);
    end
    else if TextIsSame(LTemp, 'NIL') then begin {Do not Localize}
      Inc(Ln);
    end;
    LTemp := LParams[Ln];
    if TextStartsWith(LTemp, '"') then begin  {Do not Localize}
      if not ReinterpretParamAsQuotedStr(LParams, Ln) then begin
        SendBadReply(ASender, 'InternalDateTime parameter is invalid.'); {Do not Localize}
        Exit;
      end;
      LInternalDateTime := LParams[Ln];
    end;
    LTemp := LParams[LParams.Count-1];
    if not TextStartsWith(LTemp, '{') then begin  {Do not Localize}
      SendBadReply(ASender, 'Size parameter is invalid.'); {Do not Localize}
      Exit;
    end;
    LSize := IndyStrToInt64(Copy(LTemp, 2, Length(LTemp)-2));
    //Grab the next UID...
    LUID := OnDefMechGetNextFreeUID(LContext.LoginName, LParams[0]);
    //Get the message...
    LFile := OnDefMechGetFileNameToWriteAppendMessage(LContext.LoginName, LContext.MailBox.Name, LUID);
    LStream := TIdFileCreateStream.Create(LFile);
    try
      ASender.Context.Connection.IOHandler.ReadStream(LStream, LSize);
      if LFlags = '' then begin
        SendOkReply(ASender, 'Completed');  {Do not Localize}
      end else begin
        //Update the (optional) flags...
        LParams2 := TStringList.Create;
        try
          LParams2.Add(LUID);
          LParams2.Add('FLAGS.SILENT');  {Do not Localize}
          {
          for LN := 1 to LParams.Count-2 do begin
            LParams2.Add(LParams[LN]);
          end;
          }
          //The flags are in a string, need to reassemble...
          LFlagsList := TStringList.Create;
          try
            BreakApart(LFlags, ' ', LFlagsList);  {Do not Localize}
            for LN := 0 to LFlagsList.Count-1 do begin
              LTemp := LFlagsList[LN];
              if LN = 0 then begin
                LTemp := '(' + LTemp;  {Do not Localize}
              end;
              if LN = LFlagsList.Count-1 then begin
                LTemp := LTemp + ')';  {Do not Localize}
              end;
              LParams2.Add(LTemp);
            end;
            if not ProcessStore(True, ASender, LParams2) then begin
              //Have to reverse out our changes if ANYTHING fails..
              LMessage := TIdMessage.Create(Self);
              try
                LMessage.UID := LUID;  //This is all we need for deletion
                OnDefMechDeleteMessage(LContext.LoginName, LContext.MailBox.Name, LMessage);
              finally
                FreeAndNil(LMessage);
              end;
              Exit;
            end;
          finally
            FreeAndNil(LFlagsList);
          end;
        finally
          FreeAndNil(LParams2);
        end;
      end;
      //Update the next free UID in the .uid file...
      OnDefMechUpdateNextFreeUID(LContext.LoginName, LContext.MailBox.Name, IntToStr(IndyStrToInt64(LUID)+1));
      // TODO: implement this
      {
      if LInternalDateTime <> '' then
      begin
        // what to do here?
      end;
      }
    finally
      FreeAndNil(LStream);
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandCHECK(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandCHECK) then begin
    OnCommandCHECK(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  {On most servers, this does nothing, they always return OK...}
  SendOkReply(ASender, 'Completed');  {Do not Localize}
end;

procedure TIdIMAP4Server.DoCommandCLOSE(ASender: TIdCommand);
var
  LResult: Boolean;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandCLOSE) then begin
    OnCommandCLOSE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechDeleteMessage) then begin  //Used by ExpungeRecords
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  {This is an implicit expunge...}
  LResult := ExpungeRecords(ASender);
  {Now close it...}
  LContext.MailBox.Clear;
  LContext.FConnectionState := csAuthenticated;
  if LResult then begin
    SendOkReply(ASender, 'Completed');  {Do not Localize}
  end else begin
    SendNoReply(ASender, 'Implicit expunge failed for one or more messages'); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.DoCommandEXPUNGE(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(FOnCommandEXPUNGE) then begin
    OnCommandEXPUNGE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechDeleteMessage) then begin  //Used by ExpungeRecords
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  if ExpungeRecords(ASender) then begin
    SendOkReply(ASender, 'Completed');  {Do not Localize}
  end else begin
    SendNoReply(ASender, 'Expunge failed for one or more messages'); {Do not Localize}
  end;
end;

procedure TIdIMAP4Server.DoCommandSEARCH(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSEARCH) then begin
    OnCommandSEARCH(ASender.Context, LContext.IMAP4Tag,  ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if not Assigned(OnDefMechGetMessageHeader) then begin  //Used by ProcessSearch
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessSearch(False, ASender, LParams);
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandFETCH(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(FOnCommandFETCH) then begin
    OnCommandFETCH(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  if (not Assigned(OnDefMechGetMessageHeader))  //Used by ProcessFetch
    or (not Assigned(OnDefMechGetMessageSize))
    or (not Assigned(OnDefMechGetMessageRaw)) then
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessFetch(False, ASender, LParams);
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandSTORE(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(fOnCommandSTORE) then begin
    OnCommandSTORE(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessStore(False, ASender, LParams);
  finally
    FreeAndNil(LParams);
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
  if Result <> '' then begin
    Result := TrimRight(Result);
  end;
end;

procedure TIdIMAP4Server.DoCommandCOPY(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if LContext.MailBox.State = msReadOnly then begin
    SendErrorOpenedReadOnly(ASender);
    Exit;
  end;
  if Assigned(FOnCommandCOPY) then begin
    OnCommandCOPY(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  //Format is COPY 2:4 DestinationMailBoxName
  if (not Assigned(OnDefMechReinterpretParamAsMailBox))
    or (not Assigned(OnDefMechCopyMessage)) then  //Needed for ProcessCopy
  begin
    SendUnassignedDefaultMechanism(ASender);
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    ProcessCopy(False, ASender, LParams);
  finally
    FreeAndNil(LParams);
  end;
end;

{UID before COPY, FETCH or STORE means the record numbers are UIDs.
 UID before SEARCH means SEARCH is to _return_ UIDs rather than relative numbers.}
procedure TIdIMAP4Server.DoCommandUID(ASender: TIdCommand);
var
  LParams: TStringList;
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if LContext.ConnectionState <> csSelected then begin
    SendWrongConnectionState(ASender);
    Exit;
  end;
  if Assigned(fOnCommandUID) then begin
    OnCommandUID(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if not FUseDefaultMechanismsForUnassignedCommands then begin
    Exit;
  end;
  LParams := TStringList.Create;
  try
    BreakApart(ASender.UnparsedParams, ' ', LParams); {Do not Localize}
    if LParams.Count < 1 then begin
      //Incorrect number of params...
      SendIncorrectNumberOfParameters(ASender);
      Exit;
    end;
    //Map the commands to the general handler but remove the FETCH or whatever...
    case PosInStrArray(LParams[0], ['FETCH', 'COPY', 'STORE', 'SEARCH'], False) of
      0: // FETCH   {Do not Localize}
        begin
          if (not Assigned(OnDefMechGetMessageHeader))  //Used by ProcessFetch
            or (not Assigned(OnDefMechGetMessageSize))
            or (not Assigned(OnDefMechGetMessageRaw)) then
          begin
            SendUnassignedDefaultMechanism(ASender);
            Exit;
          end;
          LParams.Delete(0);
          ProcessFetch(True, ASender, LParams);
        end;
      1: // COPY   {Do not Localize}
        begin
          if (not Assigned(OnDefMechReinterpretParamAsMailBox))
            or (not Assigned(OnDefMechCopyMessage)) then   //Needed for ProcessCopy
          begin
            SendUnassignedDefaultMechanism(ASender);
            Exit;
          end;
          LParams.Delete(0);
          ProcessCopy(True, ASender, LParams);
        end;
      2: // STORE   {Do not Localize}
        begin
          LParams.Delete(0);
          ProcessStore(True, ASender, LParams);
        end;
      3: // SEARCH   {Do not Localize}
        begin
          if not Assigned(OnDefMechGetMessageHeader) then begin  //Used by ProcessSearch
            SendUnassignedDefaultMechanism(ASender);
            Exit;
          end;
          LParams.Delete(0);
          ProcessSearch(True, ASender, LParams);
        end;
    else
      begin
        SendUnsupportedCommand(ASender);
      end;
    end;
  finally
    FreeAndNil(LParams);
  end;
end;

procedure TIdIMAP4Server.DoCommandX(ASender: TIdCommand);
begin
  if not Assigned(fOnCommandX) then begin
    OnCommandX(ASender.Context, TIdIMAP4PeerContext(ASender.Context).IMAP4Tag, ASender.UnparsedParams);
  end else if FUseDefaultMechanismsForUnassignedCommands then begin
    SendUnsupportedCommand(ASender);
  end;
end;

procedure TIdIMAP4Server.DoCommandSTARTTLS(ASender: TIdCommand);
var
  LContext: TIdIMAP4PeerContext;
begin
  LContext := TIdIMAP4PeerContext(ASender.Context);
  if (not (IOHandler is TIdServerIOHandlerSSLBase)) or (not (FUseTLS in ExplicitTLSVals)) then begin
    OnCommandError(ASender.Context, LContext.IMAP4Tag, ASender.UnparsedParams);
    Exit;
  end;
  if LContext.UsingTLS then begin // we are already using TLS
    DoSendReply(ASender.Context, 'BAD %s', [RSIMAP4SvrNotPermittedWithTLS]); {do not localize}
    Exit;
  end;
  // TODO: STARTTLS may only be issued in auth-state
  DoSendReply(ASender.Context, 'OK %s', [RSIMAP4SvrBeginTLSNegotiation]);  {do not localize}
  (ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
end;

end.
