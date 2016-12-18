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
  Rev 1.36    2/8/05 5:59:04 PM  RLebeau
  Updated various CommandHandlers to call TIdReply.SetReply() instead of
  setting the Code and Text properties individually

  Rev 1.35    12/2/2004 4:23:56 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.34    7/6/2004 4:53:38 PM  DSiders
  Corrected spelling of Challenge in properties, methods, types.

  Rev 1.33    6/16/04 12:54:16 PM  RLebeau
  Removed redundant localization comments

  Rev 1.31    6/16/04 12:31:08 PM  RLebeau
  compiler error

  Rev 1.30    6/16/04 12:13:04 PM  RLebeau
  Added overrides for CreateExceptionReply, CreateGreeting, CreateHelpReply,
  CreateMaxConnectionReply, and CreateReplyUnknownCommand methods

  Rev 1.29    5/16/04 5:25:22 PM  RLebeau
  Added GetReplyClass() and GetRepliesClass() overrides.

  Rev 1.28    3/1/2004 1:08:36 PM  JPMugaas
  Fixed for new code.

  Rev 1.27    2004.02.03 5:44:14 PM  czhower
  Name changes

  Rev 1.26    1/29/2004 9:14:46 AM  JPMugaas
  POP3Server should now compile in DotNET.

  Rev 1.25    1/21/2004 3:27:08 PM  JPMugaas
  InitComponent

  Rev 1.24    10/25/2003 06:52:16 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.23    10/24/2003 4:38:00 PM  DSiders
  Added localization comments.
  Modified to use OK and ERR constants in response messages.

  Rev 1.22    2003.10.21 9:13:12 PM  czhower
  Now compiles.

  Rev 1.21    2003.10.12 4:04:18 PM  czhower
  compile todos

  Rev 1.20    9/19/2003 03:30:20 PM  JPMugaas
  Now should compile again.

  Rev 1.19    7/9/2003 10:59:16 PM  BGooijen
  Added IdCommandHandlers to the uses-clause

  Rev 1.18    5/30/2003 9:05:14 PM  BGooijen
  changed numeric replycodes to text reply codes

  Rev 1.17    5/30/2003 8:49:48 PM  BGooijen
  Changed TextCode to Code

  Rev 1.16    5/26/2003 04:28:22 PM  JPMugaas
  Removed GenerateReply and ParseResponse calls because those functions are
  being removed.

  Rev 1.15    5/26/2003 12:24:02 PM  JPMugaas

  Rev 1.14    5/25/2003 03:46:00 AM  JPMugaas

  Rev 1.13    5/21/2003 2:25:06 PM  BGooijen
  changed due to change in IdCmdTCPServer from ExceptionReplyCode: Integer to
  ExceptionReply: TIdReply

  Rev 1.12    5/20/2003 10:58:24 AM  JPMugaas
  SetExceptionReplyCode now validated by TIdReplyPOP3.  This way, it can only
  accept our integer codes for +OK, -ERR, and +.

  Rev 1.11    5/19/2003 08:59:30 PM  JPMugaas
  Now uses new reply object for all commands.

  Rev 1.9    5/15/2003 08:30:32 AM  JPMugaas

  Rev 1.9    5/15/2003 07:38:50 AM  JPMugaas
  No longer adds a challenge banner to the main Greeting TIdRFCReply.

  Rev 1.8    5/13/2003 08:12:12 PM  JPMugaas

  Rev 1.7    5/13/2003 12:43:20 PM  JPMugaas
  APOP redesigned so that it will handle the Challenge in the banner and do the
  hashes itself.  A Challenge will be displayed in the banner if the APOP event
  is used.

  Rev 1.6    3/20/2003 07:22:28 AM  JPMugaas

  Rev 1.5    3/17/2003 02:25:30 PM  JPMugaas
  Updated to use new TLS framework.  Now can require that users use TLS.  Note
  that this setting create an incompatiability with Norton AntiVirus because
  that does act as a "man in the middle" when intercepting E-Mail for virus
  scanning.

  Rev 1.4    3/14/2003 10:44:34 PM  BGooijen
  Removed warnings, changed StartSSL to PassThrough:=false;

  Rev 1.2    3/13/2003 10:05:30 AM  JPMugaas
  Updated component to work with the new SSL restructure.

  Rev 1.1    2/6/2003 03:18:20 AM  JPMugaas
  Updated components that compile with Indy 10.

  Rev 1.0    11/13/2002 07:58:28 AM  JPMugaas

  28-Sep-2002: Bas Gooijen
      - Added CAPA and STLS (RFC 2449 and 2595)
      - Added ImplicitTLS

  02-May-2002: Andy Neillans
      - Bug Fix 551116 -Sys. StrToInt needed 'Sys.Trimming#

  30-Apr-2002: Allen O'Neill.
      - Failsafe .. added check for ParamCount in reading Username and password - previously
        if either were sent in blank we got an IndexOutOfBounds error.

  13-Apr-2002:
    - Corrections :) And some Greeting.Text / And other response, glitches

  3-Apr-2002:
    - Minor changes. (Greeting.Text)

  1-Apr-2002:
    - Completed rewrite! At Last!

  15-Feb-2002: Andy
    - Started rewrite for use of CommandHandlers

  13-Jan-2002:
      -Fixed Sys.Formatting bug.

  26-Dec-2000:
      -Andrew Neillans found a bug on line 157. Originally it was
      if Assigned(OnCommandLIST) then OnCommandRETR(...).
      Changed to OnCommandLIST(...). Thanks Andrew!

  29-Oct-2000:
      -I discovered I really shouldn't program at night.
      The error wasn't that it shouldn't be Succ (Because it should), but
      because I forgot to implement LIST

  27-Oct-2000:
      -Fixed a dumb bug. Originally coded command parsing as Succ(PosInStrArray)
      Should be just PosInStrArray b/c it is not a dynamic array. The bounds
      are constant.

  25-Oct-2000:
      -Created Unit.
      -Created new IdPOP3Server Server Component according to RFC 1939
}

unit IdPOP3Server;

interface
{$i IdCompilerDefines.inc}

{
 Indy POP3 Server

 Original Programmer: Luke Croteau
 Current Maintainer:  Andrew Neillans
 No Copyright. Code is given to the Indy Pit Crew.

 Quick Notes:
    A few of the methods return a default message number if a number isn't entered.
    The LIST, DELE, RETR, UIDL, and TOP command will return a -1 in the parameters
    if the value isn't specified by the client.
    Some functions require this capability. For example, the LIST command can operate
    either by a certain message number or a with no arguments. See RFC1939 for details.
}

uses
  Classes,
  IdAssignedNumbers,
  IdCommandHandlers,
  IdContext,
  IdCustomTCPServer,
  IdCmdTCPServer,
  IdException,
  IdExplicitTLSClientServerBase,
  IdGlobal,
  IdReply,
  IdTCPServer,
  IdServerIOHandler,
  IdMailBox,
  IdBaseComponent,
  IdTCPConnection, IdYarn;

{
  We can not port APOP to NET due to the use of GetSystemClock and a process ID
  Kudzu: Why not? .NET can get these.....
}

const
  DEF_POP3_IMPLICIT_TLS = False;

type
  TIdPOP3ServerContext = class(TIdServerContext)
  protected
    // what needs to be stored...
    fUsername : String;
    fPassword : String;
    fAuthenticated: boolean;
    fAPOP3Challenge : String;
    //
    function GetUsingTLS: Boolean;
    function GetCanUseExplicitTLS: Boolean;
    function GetTLSIsRequired: Boolean;
  public
    // Any functions for vars
    property APOP3Challenge: string read FAPOP3Challenge write FAPOP3Challenge;
    property Authenticated: boolean read fAuthenticated;
    property Username: string read fUsername;
    property Password: string read fPassword;
    property UsingTLS: Boolean read GetUsingTLS;
    property CanUseExplicitTLS: Boolean read GetCanUseExplicitTLS;
    property TLSIsRequired: Boolean read GetTLSIsRequired;
  end;

  TIdPOP3ServerNoParamEvent = procedure (aCmd: TIdCommand) of object;
  TIdPOP3ServerStatEvent = procedure(aCmd: TIdCommand; out oCount: integer; out oSize: Int64) of object;
  TIdPOP3ServerMessageNumberEvent = procedure (aCmd: TIdCommand; AMsgNo :Integer) of object;

  TIdPOP3ServerLogin = procedure(aContext: TIdContext; aServerContext: TIdPOP3ServerContext) of object;
  TIdPOP3ServerCAPACommandEvent = procedure(aContext: TIdContext; aCapabilities: TStrings) of object;

  //Note that we require the users valid password so we can hash it with the Challenge we greeted the user with.
  TIdPOP3ServerAPOPCommandEvent = procedure (aCmd: TIdCommand; aMailboxID: String; var vUsersPassword: String) of object;
  TIdPOP3ServerTOPCommandEvent = procedure (aCmd: TIdCommand; aMsgNo: Integer; aLines: Integer) of object;

  EIdPOP3ServerException = class(EIdException);
  EIdPOP3ImplicitTLSRequiresSSL = class(EIdPOP3ServerException);


  TIdPOP3Server = class(TIdExplicitTLSServer)
  protected
    fCommandLogin : TIdPOP3ServerLogin;
    fCommandList,
    fCommandRetr,
    fCommandDele,
    fCommandUIDL  : TIdPOP3ServerMessageNumberEvent;
    fCommandTop   : TIdPOP3ServerTOPCommandEvent;
    fCommandQuit: TIdPOP3ServerNoParamEvent;
    fCommandStat: TIdPOP3ServerStatEvent;
    fCommandRset  : TIdPOP3ServerNoParamEvent;
    fCommandAPOP  : TIdPOP3ServerAPOPCommandEvent;
    fCommandCapa  : TIdPOP3ServerCAPACommandEvent;

    function IsAuthed(aCmd: TIdCommand; aAssigned: boolean): boolean;
    procedure MustUseTLS(aCmd: TIdCommand);
    // CommandHandlers
    procedure CommandUser(aCmd: TIdCommand);
    procedure CommandPass(aCmd: TIdCommand);
    procedure CommandList(aCmd: TIdCommand);
    procedure CommandRetr(aCmd: TIdCommand);
    procedure CommandDele(aCmd: TIdCommand);
    procedure CommandQuit(aCmd: TIdCommand);
    procedure CommandAPOP(aCmd: TIdCommand);
    procedure CommandStat(aCmd: TIdCommand);
    procedure CommandRset(aCmd: TIdCommand);
    procedure CommandTop(aCmd: TIdCommand);
    procedure CommandUIDL(aCmd: TIdCommand);
    procedure CommandSTLS(aCmd: TIdCommand);
    procedure CommandCAPA(aCmd: TIdCommand);

    function CreateExceptionReply: TIdReply; override;
    function CreateGreeting: TIdReply; override;
    function CreateHelpReply: TIdReply; override;
    function CreateMaxConnectionReply: TIdReply; override;
    function CreateReplyUnknownCommand: TIdReply; override;

    procedure InitializeCommandHandlers; override;
    procedure DoReplyUnknownCommand(AContext: TIdContext; ALine: string); override;
    function GetReplyClass: TIdReplyClass; override;
    function GetRepliesClass: TIdRepliesClass; override;
    procedure SendGreeting(AContext : TIdContext; AGreeting : TIdReply); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_POP3;
    // These procedures / functions are exposed
    property OnCheckUser   : TIdPOP3ServerLogin              read fCommandLogin write fCommandLogin;
    property OnList      : TIdPOP3ServerMessageNumberEvent read fCommandList write fCommandList;
    property OnRetrieve      : TIdPOP3ServerMessageNumberEvent read fCommandRetr write fCommandRetr;
    property OnDelete      : TIdPOP3ServerMessageNumberEvent read fCommandDele write fCommandDele;
    property OnUIDL      : TIdPOP3ServerMessageNumberEvent read fCommandUidl write fCommandUidl;
    property OnStat: TIdPOP3ServerStatEvent read fCommandStat write fCommandStat;
    property OnTop      : TIdPOP3ServerTOPCommandEvent    read fCommandTop  write fCommandTop;
    property OnReset      : TIdPOP3ServerNoParamEvent       read fCommandRset write fCommandRset;
    property OnQuit      : TIdPOP3ServerNoParamEvent       read fCommandQuit write fCommandQuit;
    property OnAPOP      : TIdPOP3ServerAPOPCommandEvent   read fCommandApop write fCommandApop;
    property OnCAPA      : TIdPOP3ServerCAPACommandEvent   read fCommandCapa write fCommandCapa;

    property UseTLS;
  end;

implementation

uses
  IdFIPS,
  IdGlobalProtocols, IdHash,
  IdHashMessageDigest,
  IdReplyPOP3,
  IdResourceStringsProtocols,
  IdSSL,
  IdStack, SysUtils;

procedure TIdPOP3Server.DoReplyUnknownCommand(AContext: TIdContext; ALine: string);
var
  LReply: TIdReply;
  LLine : String;
begin
  LLine := ALine;
  // RLebeau 03/17/2007: TIdCmdTCPServer.DoReplyUnknownCommand() adds the
  // offending command as a multi-line response generically for all servers.
  // POP3 Error replies are not mult-line, however, so overriding the
  // behavior here to not do that!
  LReply := FReplyClass.CreateWithReplyTexts(nil, ReplyTexts);
  try
    LReply.SetReply(ST_ERR, IndyFormat(RSPOP3SvrUnknownCmdFmt, [Fetch(LLine)]));
    AContext.Connection.IOHandler.Write(LReply.FormattedReply);
  finally
    FreeAndNil(LReply);
  end;
end;

procedure TIdPOP3Server.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  inherited;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'USER';  {do not localize}
  LCommandHandler.OnCommand := CommandUSER;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'PASS';  {do not localize}
  LCommandHandler.OnCommand := CommandPass;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST';  {do not localize}
  LCommandHandler.OnCommand := CommandList;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'RETR';  {do not localize}
  LCommandHandler.OnCommand := CommandRetr;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'DELE';  {do not localize}
  LCommandHandler.OnCommand := CommandDele;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'UIDL';  {do not localize}
  LCommandHandler.OnCommand := CommandUIDL;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STAT';  {do not localize}
  LCommandHandler.OnCommand := CommandSTAT;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'TOP'; {do not localize}
  LCommandHandler.OnCommand := CommandTOP;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NOOP';  {do not localize}
  LCommandHandler.NormalReply.SetReply(ST_OK, RSPOP3SvrNoOp);
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'APOP';  {do not localize}
  LCommandHandler.OnCommand := CommandAPOP;
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'RSET';  {do not localize}
  LCommandHandler.NormalReply.SetReply(ST_OK, RSPOP3SvrReset);
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.OnCommand := CommandRset;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'QUIT';  {do not localize}
  LCommandHandler.OnCommand := CommandQuit;
  LCommandHandler.Disconnect := True;
  LCommandHandler.NormalReply.SetReply(ST_OK, RSPOP3SvrClosingConnection);
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STLS';  {do not localize}
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.OnCommand := CommandSTLS;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CAPA';  {do not localize}
  LCommandHandler.NormalReply.Code := ST_OK;
  LCommandHandler.ExceptionReply.Code := ST_ERR;
  LCommandHandler.OnCommand := CommandCAPA;

end;

{ Command Handler Functions here }

procedure TIdPOP3Server.CommandUser(aCmd: TIdCommand);
var
  LContext: TIdPOP3ServerContext;
begin
  LContext := TIdPOP3ServerContext(aCmd.Context);
  if LContext.TLSIsRequired then
  begin
    MustUseTLS(aCmd);
    Exit;
  end;
  if aCmd.Params.Count > 0 then begin
    LContext.fUsername := aCmd.Params.Strings[0];
  end;
  aCmd.Reply.SetReply(ST_OK, RSPOP3SvrPasswordRequired);
end;

procedure TIdPOP3Server.CommandPass(aCmd: TIdCommand);
var
  LContext: TIdPOP3ServerContext;
begin
  LContext := TIdPOP3ServerContext(aCmd.Context);
  if LContext.TLSIsRequired then
  begin
    MustUseTLS(aCmd);
    Exit;
  end;
  if aCmd.Params.Count > 0 then begin
    LContext.fPassword := aCmd.Params.Strings[0];
  end;
  if Assigned(OnCheckUser) then begin
    OnCheckUser(aCmd.Context, LContext);
  end;
  LContext.fAuthenticated := True;
  aCmd.Reply.SetReply(ST_OK, RSPOP3SvrLoginOk);
end;

procedure TIdPOP3Server.CommandList(aCmd: TIdCommand);
begin
  if IsAuthed(aCmd, Assigned(fCommandList)) then begin
    OnList(aCmd, IndyStrToInt(aCmd.Params.Text, -1));
  end;
end;

procedure TIdPOP3Server.CommandRetr(aCmd: TIdCommand);
begin
  if IsAuthed(aCmd, Assigned(fCommandRetr)) then begin
    OnRetrieve(aCmd, IndyStrToInt(aCmd.Params[0]));
  end;
end;

procedure TIdPOP3Server.CommandDele(aCmd: TIdCommand);
begin
  if IsAuthed(aCmd, Assigned(fCommandDele)) then begin
    OnDelete(aCmd, IndyStrToInt(aCmd.Params.Text));
  end;
end;

procedure TIdPOP3Server.CommandQuit(aCmd: TIdCommand);
begin
  if Assigned(fCommandQuit) then begin
    OnQuit(aCmd);
  end;
end;

procedure TIdPOP3Server.CommandAPOP(aCmd: TIdCommand);
var
  LContext: TIdPOP3ServerContext;
  LValidPassword : String;
  LValidHash : String;
  LMD5: TIdHashMessageDigest5;
begin
  LContext := TIdPOP3ServerContext(aCmd.Context);
  if LContext.Authenticated then
  begin
    aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrWrongState);
    Exit;
  end;
  if LContext.TLSIsRequired then
  begin
    MustUseTLS(aCmd);
    Exit;
  end;
  if not Assigned(fCommandAPOP) then
  begin
    aCmd.Reply.SetReply(ST_ERR, IndyFormat(RSPOP3SVRNotHandled, ['APOP'])); {do not localize}
    Exit;
  end;
  OnAPOP(aCmd, aCmd.Params.Strings[0], LValidPassword);
  LMD5 := TIdHashMessageDigest5.Create;
  try
    LValidHash := IndyLowerCase(LMD5.HashStringAsHex(LContext.APOP3Challenge + LValidPassword));
  finally
    LMD5.Free;
  end;

  LContext.fAuthenticated := (LValidHash = aCmd.Params[1]);

  // User to set return state of LThread.State as required.
  if not LContext.Authenticated then begin
    aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrLoginFailed);
  end else begin
    aCmd.Reply.SetReply(ST_OK, RSPOP3SvrLoginOk);
  end;
end;

function TIdPOP3Server.IsAuthed(aCmd: TIdCommand; aAssigned: boolean): boolean;
begin
  Result := TIdPOP3ServerContext(aCmd.Context).Authenticated;
  if Result then begin
    Result := aAssigned;
    if not Result then begin
      aCmd.Reply.SetReply(ST_ERR, IndyFormat(RSPOP3SVRNotHandled, [aCmd.CommandHandler.Command])); {do not localize}
    end;
  end else begin
    aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandStat(aCmd: TIdCommand);
var
  xCount: Integer;
  xSize: Int64;
begin
  // TODO: Need to make all use this form
  if IsAuthed(aCmd, Assigned(fCommandStat)) then begin
    OnStat(aCmd, xCount, xSize);
    aCmd.Reply.SetReply(ST_OK, IntToStr(xCount) + ' ' + IntToStr(xSize));
  end;
end;

procedure TIdPOP3Server.CommandRset(aCmd: TIdCommand);
begin
  if IsAuthed(aCmd, assigned(fCommandRSET)) then begin
    OnReset(aCmd);
  end;
end;

procedure TIdPOP3Server.CommandTop(aCmd: TIdCommand);
var
  xMsgNo: integer;
  xLines: integer;
begin
  if IsAuthed(aCmd, Assigned(fCommandTop)) then begin
    if aCmd.Params.Count = 2 then begin
      xMsgNo := IndyStrToInt(aCmd.Params.Strings[0], 0);
      xLines := IndyStrToInt(aCmd.Params.Strings[1], -1);
      if (xMsgNo >= 1) and (xLines >= 0) then begin
        OnTop(aCmd, xMsgNo, xLines);
        Exit;
      end;
    end;
    aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrInvalidSyntax);
  end;
end;

procedure TIdPOP3Server.CommandUIDL(aCmd: TIdCommand);
begin
  if IsAuthed(aCmd, Assigned(fCommandUidl)) then begin
    OnUidl(aCmd,IndyStrToInt(aCmd.Params.Text, -1))
  end;
end;

procedure TIdPOP3Server.CommandSTLS(aCmd: TIdCommand);
var
  LContext: TIdPOP3ServerContext;
begin
  LContext := TIdPOP3ServerContext(aCmd.Context);
  if LContext.CanUseExplicitTLS then begin
    if LContext.UsingTLS then begin // we are already using TLS
      aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrNotPermittedWithTLS);
      Exit;
    end;
    if LContext.Authenticated then begin //STLS only allowed in auth-state
      aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrNotInThisState);
      Exit;
    end;
    aCmd.Reply.SetReply(ST_OK, RSPOP3SvrbeginTLSNegotiation);
    aCmd.SendReply;
    TIdSSLIOHandlerSocketBase(aCmd.Context.Connection.IOHandler).PassThrough := False;
  end else begin
    aCmd.Reply.SetReply(ST_ERR, IndyFormat(RSPOP3SVRNotHandled, ['STLS']));    {do not localize}
  end;
end;

procedure TIdPOP3Server.CommandCAPA(aCmd: TIdCommand);
var
  LContext: TIdPOP3ServerContext;
begin
  LContext := TIdPOP3ServerContext(aCmd.Context);

  aCmd.Reply.SetReply(ST_OK, RSPOP3SvrCapaList);

  // RLebeau: in case no capabilities are specified, the terminating '.' still has to be sent.
  aCmd.SendEmptyResponse := True;

  if LContext.CanUseExplicitTLS and (not LContext.UsingTLS) then begin
    aCmd.Response.Add('STLS'); {do not localize}
  end;
  if Assigned(fCommandTop) then begin
    aCmd.Response.Add('TOP'); {do not localize}
  end;
  if Assigned(fCommandUidl) then begin
    aCmd.Response.Add('UIDL'); {do not localize}
  end;
  aCmd.Response.Add('USER'); {do not localize}
//  aCmd.Response.Add('SASL ......');   // like 'SASL CRAM-MD5 KERBEROS_V4'
  if Assigned(fCommandCapa) then begin
    OnCAPA(aCmd.Context, aCmd.Response);
  end;
end;

{ Constructor / Destructors }

procedure TIdPOP3Server.InitComponent;
begin
  inherited;
  FContextClass := TIdPOP3ServerContext;
  FRegularProtPort := IdPORT_POP3;
  FImplicitTLSProtPort := IdPORT_POP3S;
  FExplicitTLSProtPort := IdPORT_POP3;
  DefaultPort := IdPORT_POP3;
end;

function TIdPOP3Server.CreateExceptionReply: TIdReply;
begin
  Result := TIdReplyPOP3.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(ST_ERR, RSPOP3SvrInternalError);
end;

function TIdPOP3Server.CreateGreeting: TIdReply;
begin
  Result := TIdReplyPOP3.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(ST_OK, RSPOP3SvrWelcome);
end;

function TIdPOP3Server.CreateHelpReply: TIdReply;
begin
  Result := TIdReplyPOP3.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(ST_OK, RSPOP3SvrHelpFollows);
end;

function TIdPOP3Server.CreateMaxConnectionReply: TIdReply;
begin
  Result := TIdReplyPOP3.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(ST_ERR, RSPOP3SvrTooManyCons);
end;

function TIdPOP3Server.CreateReplyUnknownCommand: TIdReply;
begin
  Result := TIdReplyPOP3.CreateWithReplyTexts(nil, ReplyTexts);
  Result.SetReply(ST_ERR, RSPOP3SvrUnknownCmd);
end;

function TIdPOP3Server.GetReplyClass: TIdReplyClass;
begin
  Result := TIdReplyPOP3;
end;

function TIdPOP3Server.GetRepliesClass: TIdRepliesClass;
begin
  Result := TIdRepliesPOP3;
end;

{ TIdPOP3ServerContext }

function TIdPOP3ServerContext.GetUsingTLS: Boolean;
begin
  Result := Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if Result then begin
    Result := not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end;
end;

function TIdPOP3ServerContext.GetCanUseExplicitTLS: Boolean;
begin
  Result := Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if Result then begin
    Result := TIdPOP3Server(Server).UseTLS in ExplicitTLSVals;
  end;
end;

function TIdPOP3ServerContext.GetTLSIsRequired: Boolean;
begin
  Result := TIdPOP3Server(Server).UseTLS = utUseRequireTLS;
  if Result then begin
    Result := not UsingTLS;
  end;
end;

procedure TIdPOP3Server.MustUseTLS(aCmd: TIdCommand);
begin
  aCmd.Reply.SetReply(ST_ERR, RSPOP3SvrMustUseSTLS);
  aCmd.Disconnect := True;
end;

procedure TIdPOP3Server.SendGreeting(AContext: TIdContext;
  AGreeting: TIdReply);
var
  LThread : TIdPOP3ServerContext;
  LGreeting : TIdReplyPOP3;
begin
//  AGreeting.Code := ST_OK; {do not localize}
  if ( not GetFIPSMode ) and Assigned(fCommandAPOP) then
  begin
    LThread := TIdPOP3ServerContext(AContext);
    LGreeting := TIdReplyPOP3.Create(nil);
    try
      LThread.APOP3Challenge := '<'+   {do not localize}
              IntToStr(Abs( CurrentProcessId )) +
        '.'+IntToStr(Abs( GetClockValue ))+'@'+ GStack.HostName +'>';    {do not localize}
      if AGreeting.Text.Count > 0 then begin
        LGreeting.Text.Add(AGreeting.Text[0] + ' ' + LThread.APOP3Challenge);   {do not localize}
      end else begin
        LGreeting.Text.Add(RSPOP3SvrWelcomeAPOP + LThread.APOP3Challenge);
      end;
      LGreeting.Code := ST_OK;
      AContext.Connection.IOHandler.Write(LGreeting.FormattedReply);
    finally
      FreeAndNil(LGreeting);
    end;
  end
  else
  begin
    inherited SendGreeting(AContext, AGreeting);
  end;
end;

end.
