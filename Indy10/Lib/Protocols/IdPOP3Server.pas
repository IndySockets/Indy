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
{   Rev 1.36    2/8/05 5:59:04 PM  RLebeau
{ Updated various CommandHandlers to call TIdReply.SetReply() instead of
{ setting the Code and Text properties individually
}
{
{   Rev 1.35    12/2/2004 4:23:56 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
    Rev 1.34    7/6/2004 4:53:38 PM  DSiders
  Corrected spelling of Challenge in properties, methods, types.
}
{
{   Rev 1.33    6/16/04 12:54:16 PM  RLebeau
{ Removed redundant localization comments
}
{
{   Rev 1.31    6/16/04 12:31:08 PM  RLebeau
{ compiler error
}
{
{   Rev 1.30    6/16/04 12:13:04 PM  RLebeau
{ Added overrides for CreateExceptionReply, CreateGreeting, CreateHelpReply,
{ CreateMaxConnectionReply, and CreateReplyUnknownCommand methods
}
{
{   Rev 1.29    5/16/04 5:25:22 PM  RLebeau
{ Added GetReplyClass() and GetRepliesClass() overrides.
}
{
{   Rev 1.28    3/1/2004 1:08:36 PM  JPMugaas
{ Fixed for new code.
}
{
{   Rev 1.27    2004.02.03 5:44:14 PM  czhower
{ Name changes
}
{
{   Rev 1.26    1/29/2004 9:14:46 AM  JPMugaas
{ POP3Server should now compile in DotNET.
}
{
{   Rev 1.25    1/21/2004 3:27:08 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.24    10/25/2003 06:52:16 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.
}
{
    Rev 1.23    10/24/2003 4:38:00 PM  DSiders
  Added localization comments.
  Modified to use OK and ERR constants in response messages.
}
{
{   Rev 1.22    2003.10.21 9:13:12 PM  czhower
{ Now compiles.
}
{
{   Rev 1.21    2003.10.12 4:04:18 PM  czhower
{ compile todos
}
{
{   Rev 1.20    9/19/2003 03:30:20 PM  JPMugaas
{ Now should compile again.
}
{
    Rev 1.19    7/9/2003 10:59:16 PM  BGooijen
  Added IdCommandHandlers to the uses-clause
}
{
    Rev 1.18    5/30/2003 9:05:14 PM  BGooijen
  changed numeric replycodes to text reply codes
}
{
    Rev 1.17    5/30/2003 8:49:48 PM  BGooijen
  Changed TextCode to Code
}
{
{   Rev 1.16    5/26/2003 04:28:22 PM  JPMugaas
{ Removed GenerateReply and ParseResponse calls because those functions are
{ being removed.
}
{
{   Rev 1.15    5/26/2003 12:24:02 PM  JPMugaas
}
{
{   Rev 1.14    5/25/2003 03:46:00 AM  JPMugaas
}
{
    Rev 1.13    5/21/2003 2:25:06 PM  BGooijen
  changed due to change in IdCmdTCPServer from ExceptionReplyCode: Integer to
  ExceptionReply: TIdReply
}
{
{   Rev 1.12    5/20/2003 10:58:24 AM  JPMugaas
{ SetExceptionReplyCode now validated by TIdReplyPOP3.  This way, it can only
{ accept our integer codes for +OK, -ERR, and +.
}
{
{   Rev 1.11    5/19/2003 08:59:30 PM  JPMugaas
{ Now uses new reply object for all commands.
}
{
{   Rev 1.9    5/15/2003 08:30:32 AM  JPMugaas
}
{
{   Rev 1.9    5/15/2003 07:38:50 AM  JPMugaas
{ No longer adds a challenge banner to the main Greeting TIdRFCReply.
}
{
{   Rev 1.8    5/13/2003 08:12:12 PM  JPMugaas
}
{
{   Rev 1.7    5/13/2003 12:43:20 PM  JPMugaas
{ APOP redesigned so that it will handle the Challenge in the banner and do the
{ hashes itself.  A Challenge will be displayed in the banner if the APOP event
{ is used.
}
{
{   Rev 1.6    3/20/2003 07:22:28 AM  JPMugaas
}
{
{   Rev 1.5    3/17/2003 02:25:30 PM  JPMugaas
{ Updated to use new TLS framework.  Now can require that users use TLS.  Note
{ that this setting create an incompatiability with Norton AntiVirus because
{ that does act as a "man in the middle" when intercepting E-Mail for virus
{ scanning.
}
{
    Rev 1.4    3/14/2003 10:44:34 PM  BGooijen
  Removed warnings, changed StartSSL to PassThrough:=false;
}
{
{   Rev 1.2    3/13/2003 10:05:30 AM  JPMugaas
{ Updated component to work with the new SSL restructure.
}
{
{   Rev 1.1    2/6/2003 03:18:20 AM  JPMugaas
{ Updated components that compile with Indy 10.
}
{
{   Rev 1.0    11/13/2002 07:58:28 AM  JPMugaas
}
unit IdPOP3Server;

interface

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

 Revision History:
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
     If Assigned(OnCommandLIST) then OnCommandRETR(...).
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

uses
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
  IdSys,
  IdObjs,
  IdBaseComponent,
  IdTCPConnection, IdYarn;

{
We can not port APOP to NET due to the use of GetSystemClock and a process ID
}

const
  DEF_POP3_IMPLICIT_TLS = False;

const
  OK = '+OK';     {do not localize}
  ERR = '-ERR';   {do not localize}

type
  TIdPOP3ServerState = (Auth, Trans, Update);

  TIdPOP3ServerContext = class(TIdContext)
  protected
    // what needs to be stored...
    fUser : String;
    fPassword : String;
    fState :TIdPOP3ServerState;
    fAPOP3Challenge : String;
    function GetUsingTLS:boolean;

  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdThreadList = nil
      ); override;
    destructor Destroy; override;
   // Any functions for vars
    property APOP3Challenge : String read FAPOP3Challenge write FAPOP3Challenge;
    property Username : String read fUser write fUser;
    property Password : String read fPassword write fPassword;
    property State    : TIdPOP3ServerState read fState write fState;
    property UsingTLS : boolean read GetUsingTLS;

  end;

  TIdPOP3ServerNoParamEvent = procedure (ASender: TIdCommand) of object;
  TIdPOP3ServerMessageNumberEvent = procedure (ASender: TIdCommand; AMessageNum :Integer) of object;

  TIdPOP3ServerLogin = procedure (AThread :TIdContext; LThread : TIdPOP3ServerContext) of object;

  //Note that we require the users valid password so we can hash it with the Challenge we greeted the user with.
  TIdPOP3ServerAPOPCommandEvent = procedure (ASender: TIdCommand; AMailboxID :String; var VUsersPassword:String) of object;
  TIdPOP3ServerTOPCommandEvent = procedure (ASender: TIdCommand; AMessageNum :Integer; ANumLines :Integer) of object;

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
    fCommandQuit,
    fCommandStat,
    fCommandRset  : TIdPOP3ServerNoParamEvent;
    fCommandAPOP  : TIdPOP3ServerAPOPCommandEvent;
    procedure MustUseTLS(ASender: TIdCommand);
    // CommandHandlers
    procedure CommandUser(ASender: TIdCommand); //
    procedure CommandPass(ASender: TIdCommand); //
    procedure CommandList(ASender: TIdCommand); //
    procedure CommandRetr(ASender: TIdCommand); //
    procedure CommandDele(ASender: TIdCommand); //
    procedure CommandQuit(ASender: TIdCommand); //
    procedure CommandAPOP(ASender: TIdCommand); //
    procedure CommandStat(ASender: TIdCommand); //
    procedure CommandRset(ASender: TIdCommand); //
    procedure CommandTop(ASender: TIdCommand);  //
    procedure CommandUIDL(ASender: TIdCommand); //
    procedure CommandSTLS(ASender: TIdCommand); //
    procedure CommandCAPA(ASender: TIdCommand); //

    function CreateExceptionReply: TIdReply; override;
    function CreateGreeting: TIdReply; override;
    function CreateHelpReply: TIdReply; override;
    function CreateMaxConnectionReply: TIdReply; override;
    function CreateReplyUnknownCommand: TIdReply; override;

    procedure InitializeCommandHandlers; override;
    procedure DoConnect(AContext: TIdContext); override;
    function GetReplyClass: TIdReplyClass; override;
    function GetRepliesClass: TIdRepliesClass; override;
    procedure SendGreeting(AContext : TIdContext; AGreeting : TIdReply); override;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
  published
    property DefaultPort default IdPORT_POP3;
    // These procedures / functions are exposed
    property CheckUser   : TIdPOP3ServerLogin              read fCommandLogin write fCommandLogin;
    property OnLIST      : TIdPOP3ServerMessageNumberEvent read fCommandList write fCommandList;
    property OnRETR      : TIdPOP3ServerMessageNumberEvent read fCommandRetr write fCommandRetr;
    property OnDELE      : TIdPOP3ServerMessageNumberEvent read fCommandDele write fCommandDele;
    property OnUIDL      : TIdPOP3ServerMessageNumberEvent read fCommandUidl write fCommandUidl;
    property OnSTAT      : TIdPOP3ServerNoParamEvent       read fCommandStat write fCommandStat;
    property OnTOP       : TIdPOP3ServerTOPCommandEvent    read fCommandTop  write fCommandTop;
    property OnRSET      : TIdPOP3ServerNoParamEvent       read fCommandRset write fCommandRset;
    property OnQUIT      : TIdPOP3ServerNoParamEvent       read fCommandQuit write fCommandQuit;
    property OnAPOP      : TIdPOP3ServerAPOPCommandEvent   read fCommandApop write fCommandApop;
    property UseTLS;
  End;

implementation

uses
  IdGlobalProtocols, IdHash,
  IdHashMessageDigest,
  IdReplyPOP3,
  IdResourceStringsProtocols,
  IdSSL,
  IdStack;

procedure TIdPOP3Server.DoConnect(AContext: TIdContext);
begin
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    if FUseTLS=utUseImplicitTLS then begin
      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough:=false;
    end;
  end;
  inherited DoConnect(AContext);
end;

procedure TIdPOP3Server.InitializeCommandHandlers;
begin
  inherited;
  with CommandHandlers.Add do begin
    Command := 'USER';  {do not localize}
    OnCommand := CommandUSER;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'PASS';  {do not localize}
    OnCommand := CommandPass;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'LIST';  {do not localize}
    OnCommand := CommandList;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'RETR';  {do not localize}
    OnCommand := CommandRetr;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'DELE';  {do not localize}
    OnCommand := CommandDele;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'UIDL';  {do not localize}
    OnCommand := CommandUIDL;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'STAT';  {do not localize}
    OnCommand := CommandSTAT;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'TOP'; {do not localize}
    OnCommand := CommandTOP;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  end;
  with CommandHandlers.Add do begin
    Command := 'NOOP';  {do not localize}
    NormalReply.SetReply(OK, RSPOP3SvrNoOp);
    ExceptionReply.Code := ERR;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'APOP';  {do not localize}
    OnCommand := CommandAPOP;
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    ParseParams := True;
  End;
  with CommandHandlers.Add do begin
    Command := 'RSET';  {do not localize}
    NormalReply.SetReply(OK, RSPOP3SvrReset);
    ExceptionReply.Code := ERR;
    OnCommand := CommandRset;
    ParseParams := False;
  end;

  with CommandHandlers.Add do begin
    Command := 'QUIT';  {do not localize}
    OnCommand := CommandQuit;
    Disconnect := True;
    NormalReply.SetReply(OK, RSPOP3SvrClosingConnection);
    ExceptionReply.Code := ERR;
    ParseParams := False;
  end;

  with CommandHandlers.Add do begin
    Command := 'STLS';  {do not localize}
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    OnCommand := CommandSTLS;
  end;

  with CommandHandlers.Add do begin
    Command := 'CAPA';  {do not localize}
    NormalReply.Code := OK;
    ExceptionReply.Code := ERR;
    OnCommand := CommandCAPA;
  end;

end;

{ Command Handler Functions here }

procedure TIdPOP3Server.CommandUser(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context );
  if (FUseTLS =utUseRequireTLS) and ((ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough=True) then
  begin
    MustUseTLS(ASender);
  end
  else
  begin
    if ASender.Params.Count > 0 then
    begin
        LThread.Username := ASender.Params.Strings[0];
    end;
    ASender.Reply.SetReply(OK, RSPOP3SvrPasswordRequired);
  end;
end;

procedure TIdPOP3Server.CommandPass(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  if (FUseTLS =utUseRequireTLS) and ((ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough=True) then
  begin
    MustUseTLS(ASender);
  end
  else
  begin
    if ASender.Params.Count > 0 then
    begin
      LThread.Password := ASender.Params.Strings[0];
    end;
    if Assigned(CheckUser) then
    begin
      CheckUser(ASender.Context, LThread);
    end;
  // User to set return state of LThread.State as required.

    If LThread.State <> Trans Then
    begin
      ASender.Reply.SetReply(ERR,RSPOP3SvrLoginFailed);
    end
    Else
    begin
      ASender.Reply.SetReply(OK,RSPOP3SvrLoginOk);
    end;
  end;
end;

procedure TIdPOP3Server.CommandList(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
   Begin
    If Assigned(fCommandList) Then
    begin
      OnList(ASender,Sys.StrToInt(Sys.Trim(ASender.Params.Text), -1));
    end
    Else
    begin
      ASender.Reply.SetReply(ERR,Sys.Format(RSPOP3SVRNotHandled, ['LIST'])); {do not localize}
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ERR,RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandRetr(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
   Begin
    If Assigned(fCommandRetr) Then
    begin
      OnRetr(ASender,Sys. StrToInt(Sys.Trim(ASender.Params.Text), -1));
    end
    Else
    begin
      ASender.Reply.SetReply(ERR,Sys.Format(RSPOP3SVRNotHandled, ['RETR'])); {do not localize}
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ERR,RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandDele(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandDele) Then
    Begin
      Try
        Sys.StrToInt(Sys.Trim(ASender.Params.Text));
        OnDele(ASender, Sys.StrToInt(Sys.Trim(ASender.Params.Text)))
      Except
        ASender.Reply.SetReply(ERR,RSPOP3SvrInvalidMsgNo);
      End;
    End
    Else
    begin
      ASender.Reply.SetReply(ERR,Sys.Format(RSPOP3SVRNotHandled, ['DELE'])); {do not localize}
    end;
  End
  Else
  begin
   ASender.Context.Connection.IOHandler.WriteLn(ERR+' '+RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandQuit(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandQuit) Then
    begin
      OnQuit(ASender)
    end;
  End;
end;

procedure TIdPOP3Server.CommandAPOP(ASender: TIdCommand);
Var
 LThread: TIdPOP3ServerContext;
 LValidPassword : String;
 LValidHash : String;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Auth Then
  Begin
    if (FUseTLS =utUseRequireTLS) and ((ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough=True) then
    begin
      MustUseTLS(ASender);
    end
    else
    begin
      If Assigned(fCommandAPOP) Then
      Begin
       OnAPOP(ASender, ASender.Params.Strings[0], LValidPassword);
       with TIdHashMessageDigest5.Create do
       try
         LValidHash := Sys.LowerCase(TIdHash128.AsHex(
           HashValue(LThread.APOP3Challenge + LValidPassword)));
         if (LValidHash =ASender.Params[1]) then
         begin
           LThread.State := Trans;
         end;

       finally
         free;
       end;

       // User to set return state of LThread.State as required.
       If LThread.State <> Trans Then
       begin
         ASender.Reply.SetReply(ST_ERR,RSPOP3SvrLoginFailed);
       end
       else
       begin
         ASender.Reply.SetReply(ST_OK,RSPOP3SvrLoginOk);
       end;
      End
      Else
      begin
        ASender.Reply.SetReply(ST_ERR,Sys.Format(RSPOP3SVRNotHandled, ['APOP'])); {do not localize}
      end;
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ST_ERR,RSPOP3SvrWrongState);
  end;
end;

procedure TIdPOP3Server.CommandStat(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandStat) Then
    begin
      OnStat(ASender);
    end
    Else
    begin
      ASender.Reply.SetReply(ST_ERR,Sys.Format(RSPOP3SVRNotHandled, ['STAT'])); {do not localize}
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ST_ERR,RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandRset(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandRSET) Then
    begin
      OnRset(ASender);
    end
    Else
    begin
      ASender.Reply.SetReply(ST_ERR, Sys.Format(RSPOP3SVRNotHandled, ['RSET']));  {do not localize}
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ST_ERR, RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandTop(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandTop) Then
    Begin
      If (Sys.StrToInt(Sys.Trim(ASender.Params.Strings[0]), -1) <> -1) AND (Sys.StrToInt(Sys.Trim(ASender.Params.Strings[1]), -1) <> -1) Then
      begin
        OnTop(ASender, Sys.StrToInt(ASender.Params.Strings[0]), Sys.StrToInt(ASender.Params.Strings[1]))
      end
      Else
      begin
         ASender.Reply.SetReply(ST_ERR, RSPOP3SvrInvalidSyntax);
      end;
    End
    Else
    begin
      ASender.Reply.SetReply(ST_ERR, Sys.Format(RSPOP3SVRNotHandled, ['TOP'])); {do not localize}
    end;
  End
  Else
  begin
    ASender.Reply.SetReply(ST_ERR, RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandUIDL(ASender: TIdCommand);
Var
  LThread: TIdPOP3ServerContext;
begin
  LThread := TIdPOP3ServerContext(ASender.Context);
  If LThread.State = Trans Then
  Begin
    If Assigned(fCommandUidl) Then
    begin
       OnUidl(ASender,Sys.StrToInt(Sys.Trim(ASender.Params.Text), -1))
    end
    Else
    begin
      ASender.Reply.SetReply(ST_ERR, Sys.Format(RSPOP3SVRNotHandled, ['UIDL']));  {do not localize}
    end
  End
  Else
  begin
    ASender.Reply.SetReply(ST_ERR, RSPOP3SvrLoginFirst);
  end;
end;

procedure TIdPOP3Server.CommandSTLS(ASender: TIdCommand);
var LIO : TIdSSLIOHandlerSocketBase;
begin
  if (IOHandler is TIdServerIOHandlerSSLBase) and (FUseTLS in ExplicitTLSVals) then begin
    if TIdPOP3ServerContext(ASender.Context).UsingTLS then begin // we are already using TLS
      ASender.Reply.SetReply(ST_ERR, RSPOP3SvrNotPermittedWithTLS);    {Do not Localize}
      Exit;
    end;
    if TIdPOP3ServerContext(ASender.Context).State<>Auth then begin //STLS only allowed in auth-state
      ASender.Reply.SetReply(ST_ERR, RSPOP3SvrNotInThisState);    {Do not Localize}
      Exit;
    end;
    ASender.Reply.SetReply(ST_OK, RSPOP3SvrBeginTLSNegotiation);
    LIO := ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase;
    LIO.Passthrough := False;
  end else begin
    ASender.Reply.SetReply(ST_ERR, Sys.Format(RSPOP3SVRNotHandled, ['STLS']));    {do not localize}
  end;
end;

procedure TIdPOP3Server.CommandCAPA(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(ST_OK, RSPOP3SvrCapaList);
  ASender.SendReply;
  If Assigned(fCommandUidl) Then
    ASender.Context.Connection.IOHandler.WriteLn('UIDL'); {do not localize}
  If (IOHandler is TIdServerIOHandlerSSLBase) and
    (FUseTLS in ExplicitTLSVals) Then
  begin
    ASender.Context.Connection.IOHandler.WriteLn('STLS'); {do not localize}
  end;
  ASender.Context.Connection.IOHandler.WriteLn('USER'); {do not localize}
//  ASender.Context.Connection.IOHandler.WriteLn('SASL ......');   // like 'SASL CRAM-MD5 KERBEROS_V4'
  ASender.Context.Connection.IOHandler.WriteLn('.');
end;

{ Constructor / Destructors }

procedure TIdPOP3Server.InitComponent;
begin
  inherited;
  FContextClass := TIdPOP3ServerContext;
  FRegularProtPort := IdPORT_POP3;
  FImplicitTLSProtPort := IdPORT_POP3S;
  DefaultPort := IdPORT_POP3;
end;

destructor TIdPOP3Server.Destroy;
begin
  inherited;
end;

function TIdPOP3Server.CreateExceptionReply: TIdReply;
begin
  Result := TIdReplyPOP3.Create(nil, ReplyTexts);
  Result.SetReply(ERR, RSPOP3SvrInternalError);
end;

function TIdPOP3Server.CreateGreeting: TIdReply;
begin
  Result := TIdReplyPOP3.Create(nil, ReplyTexts);
  Result.SetReply(OK, RSPOP3SvrWelcome);
end;

function TIdPOP3Server.CreateHelpReply: TIdReply;
begin
  Result := TIdReplyPOP3.Create(nil, ReplyTexts);
  Result.SetReply(OK, RSPOP3SvrHelpFollows);
end;

function TIdPOP3Server.CreateMaxConnectionReply: TIdReply;
begin
  Result := TIdReplyPOP3.Create(nil, ReplyTexts);
  Result.SetReply(ERR, RSPOP3SvrTooManyCons);
end;

function TIdPOP3Server.CreateReplyUnknownCommand: TIdReply;
begin
  Result := TIdReplyPOP3.Create(nil, ReplyTexts);
  Result.SetReply(ERR, RSPOP3SvrUnknownCmd);
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

constructor TIdPOP3ServerContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdThreadList = nil
  );
begin
  inherited;
  FUser := '';
  fState := Auth;
  fPassword := '';
end;

destructor TIdPOP3ServerContext.Destroy;
begin
  inherited;
end;

function TIdPOP3ServerContext.GetUsingTLS:boolean;
begin
  Result:=Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if result then
    Result:=not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
end;

procedure TIdPOP3Server.MustUseTLS(ASender: TIdCommand);
begin
  ASender.Context.Connection.IOHandler.WriteLn(ERR+' '+RSPOP3SvrMustUseSTLS);
  ASender.Disconnect := True;
end;

procedure TIdPOP3Server.SendGreeting(AContext: TIdContext;
  AGreeting: TIdReply);
var
  LThread : TIdPOP3ServerContext;
  LGreeting : TIdReplyPOP3;
begin
//  AGreeting.Code := OK; {do not localize}
  if Assigned(fCommandAPOP) then
  begin
    LThread := TIdPOP3ServerContext(AContext);
    LGreeting := TIdReplyPOP3.Create(nil);
    try
      LThread.APOP3Challenge := '<'+
              Sys.IntToStr(Abs( CurrentProcessId )) +
        '.'+Sys.IntToStr(Abs( GetClockValue ))+'@'+ GStack.HostName +'>';
      if AGreeting.Text.Count > 0 then begin
        LGreeting.Text.Add(AGreeting.Text[0] + ' ' + LThread.APOP3Challenge);
      end else begin
        LGreeting.Text.Add('Welcome ' + LThread.APOP3Challenge); {do not localize}
      end;
      LGreeting.Code := OK;
      AContext.Connection.IOHandler.Write(LGreeting.FormattedReply);
    finally
      Sys.FreeAndNil(LGreeting);
    end;
  end
  else
  begin
    inherited SendGreeting(AContext, AGreeting);
  end;
end;

end.
