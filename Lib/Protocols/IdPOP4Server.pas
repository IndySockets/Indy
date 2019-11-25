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

unit IdPOP4Server;
{
This is an experimental proposal based on Kudzu's idea.
}
interface
uses
  Classes,
  IdAssignedNumbers,
  IdCmdTCPServer,
  IdCommandHandlers,
  IdContext,
  IdCustomTCPServer, //for TIdServerContext
  IdEMailAddress,
  IdException,
  IdExplicitTLSClientServerBase,
  IdReply,
  IdReplyRFC,
  IdReplySMTP,
  IdTCPConnection,
  IdTCPServer,
  IdYarn,
  IdStack;

const
  POP4_PORT = 1970;  //my birthday
  
type
  TIdPOP4ServerContext = class;
  TOnUserLoginEvent = procedure(ASender: TIdPOP4ServerContext; const AUsername, APassword: string;
    var VAuthenticated: Boolean) of object;
  TIdPOP4ServerState = (Auth, Trans, Update);
  TIdPOP4Server = class(TIdExplicitTLSServer)
  protected
    FOnUserLogin : TOnUserLoginEvent;
    procedure CmdBadSequenceError(ASender: TIdCommand);
    procedure CmdAuthFailed(ASender: TIdCommand);
    procedure CmdSyntaxError(ASender: TIdCommand); overload;
    procedure CmdSyntaxError(AContext: TIdContext; ALine: string;
      const AReply: TIdReply=nil);  overload;
    procedure CmdMustUseTLS(ASender: TIdCommand);
    procedure InvalidSyntax(ASender: TIdCommand);

    function DoAuthLogin(ASender: TIdCommand; const Login:string): Boolean;

    procedure InitComponent; override;
    procedure InitializeCommandHandlers; override;
    procedure CommandAUTH(ASender: TIdCommand);
    procedure CommandCAPA(ASender: TIdCommand);
    procedure CommandSTARTTLS(ASender : TIdCommand);
    procedure DoReplyUnknownCommand(AContext: TIdContext; ALine: string); override;

  published
    property OnUserLogin : TOnUserLoginEvent read FOnUserLogin write FOnUserLogin;
    property DefaultPort default IdPORT_POP3;
  end;
  TIdPOP4ServerContext = class(TIdServerContext)
  protected
    FPipeLining : Boolean;
    FState :TIdPOP4ServerState;
    FUser,
    FPassword : String;
    function GetUsingTLS: boolean;
    procedure SetPipeLining(const AValue: Boolean);

  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TThreadList = nil
      ); override;
    procedure CheckPipeLine;
    property State    : TIdPOP4ServerState read FState write FState;
    property Username : String read fUser write fUser;
    property Password : String read fPassword write fPassword;
    property UsingTLS:boolean read GetUsingTLS;
    property PipeLining : Boolean read FPipeLining write SetPipeLining;
  end;

implementation
uses IdResourceStringsProtocols, IdCoderMIME, IdGlobal, IdGlobalProtocols, IdSSL, SysUtils;

{ TIdPOP4Server }

procedure TIdPOP4Server.InitializeCommandHandlers;
var LCmd : TIdCommandHandler;
begin
  inherited;
  LCmd := CommandHandlers.Add;

  LCmd.Command :=  'CAPA';  {do not localize}
  LCmd.NormalReply.Code := '211';
  LCmd.OnCommand := CommandCAPA;
  LCmd.Description.Text := 'Syntax: CAPA (get capabilities)';

  //QUIT <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'QUIT';    {Do not Localize}
  LCmd.Disconnect := True;
  LCmd.NormalReply.SetReply(221,RSFTPQuitGoodby);    {Do not Localize}
  LCmd.Description.Text := 'Syntax: QUIT (terminate service)'; {do not localize}

end;

procedure TIdPOP4Server.InitComponent;
begin
  inherited;
  FContextClass := TIdPOP4ServerContext;
  FRegularProtPort := POP4_PORT;
  DefaultPort := POP4_PORT;
  Self.Greeting.Code := '200';
  Self.Greeting.Text.Text := 'Your text goes here!!!';
end;

procedure TIdPOP4Server.CommandCAPA(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(211, RSPOP3SvrCapaList);
  ASender.SendReply;
  If (IOHandler is TIdServerIOHandlerSSLBase) and
    (FUseTLS in ExplicitTLSVals) Then
  begin
    ASender.Context.Connection.IOHandler.WriteLn('STARTTLS'); {do not localize}
  end;
  if Assigned(FOnUserLogin) then
  begin
    ASender.Context.Connection.IOHandler.WriteLn('AUTH LOGIN');    {Do not Localize}
  end;
  ASender.Context.Connection.IOHandler.WriteLn('.');
  TIdPOP4ServerContext(ASender.Context).CheckPipeLine;
end;

procedure TIdPOP4Server.CommandSTARTTLS(ASender: TIdCommand);
begin
  if (ASender.Context.Connection.IOHandler is TIdSSLIOHandlerSocketBase) and (FUseTLS in ExplicitTLSVals) then begin
    if TIdPOP4ServerContext(ASender.Context).UsingTLS then begin // we are already using TLS
      InvalidSyntax(ASender);
      Exit;
    end;
    if TIdPOP4ServerContext(ASender.Context).State <> Auth then begin //STLS only allowed in auth-state
      ASender.Reply.SetReply(501, RSPOP3SvrNotInThisState);    {Do not Localize}
      Exit;
    end;
    ASender.Reply.SetReply(220, RSPOP3SvrBeginTLSNegotiation);
    ASender.SendReply;
    //You should never pipeline STARTTLS
    TIdPOP4ServerContext(ASender.Context).PipeLining := False;
    (ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdPOP4Server.CmdBadSequenceError(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(503, RSSMTPSvrBadSequence);
end;

procedure TIdPOP4Server.CmdSyntaxError(AContext: TIdContext; ALine: string; const AReply: TIdReply = nil);
var
  LTmp : String;
  LReply : TIdReply;
begin
  //First make the first word uppercase
  LTmp := UpCaseFirstWord(ALine);
  try
    if Assigned(AReply) then begin
      LReply := AReply;
    end else begin
      LReply := FReplyClass.Create(nil, ReplyTexts);
      LReply.Assign(ReplyUnknownCommand);
    end;
    LReply.SetReply(500, Sys.Format(RSFTPCmdNotRecognized, [LTmp]));
    AContext.Connection.IOHandler.Write(LReply.FormattedReply);
  finally
    if not Assigned(AReply) then begin
      Sys.FreeAndNil(LReply);
    end;
  end;
end;

procedure TIdPOP4Server.CmdSyntaxError(ASender: TIdCommand);
begin
  CmdSyntaxError(ASender.Context, ASender.RawLine, FReplyUnknownCommand );
  ASender.PerformReply := False;
end;

procedure TIdPOP4Server.CmdMustUseTLS(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(530,RSSMTPSvrReqSTARTTLS);
end;

procedure TIdPOP4Server.InvalidSyntax(ASender: TIdCommand);
begin
  ASender.Reply.SetReply( 501,RSPOP3SvrInvalidSyntax);
end;

procedure TIdPOP4Server.DoReplyUnknownCommand(AContext: TIdContext;
  ALine: string);
begin
  CmdSyntaxError(AContext,ALine);
end;

function TIdPOP4Server.DoAuthLogin(ASender: TIdCommand;
  const Login: string): Boolean;
var
  S: string;
  LUsername, LPassword: string;
  LAuthFailed: Boolean;
  LAccepted: Boolean;
  LS : TIdPOP4ServerContext;
begin
  LS := ASender.Context as TIdPOP4ServerContext;
  Result := False;
  LAuthFailed := False;
  TIdPOP4ServerContext(ASender.Context).PipeLining := False;
  if UpperCase(Login) = 'LOGIN' then    {Do not Localize}
  begin // LOGIN USING THE LOGIN AUTH - BASE64 ENCODED
    s := TIdEncoderMIME.EncodeString('Username:');     {Do not Localize}
    //  s := SendRequest( '334 ' + s );    {Do not Localize}
    ASender.Reply.SetReply (334, s);    {Do not Localize}
    ASender.SendReply;
    s := Trim(ASender.Context.Connection.IOHandler.ReadLn);
    if s <> '' then    {Do not Localize}
    begin
      try
        s := TIdDecoderMIME.DecodeString(s);

        LUsername := s;
        // What? Endcode this string literal?
        s := TIdEncoderMIME.EncodeString('Password:');    {Do not Localize}
        //    s := SendRequest( '334 ' + s );    {Do not Localize}
        ASender.Reply.SetReply(334, s);    {Do not Localize}
        ASender.SendReply;
        s := Trim(ASender.Context.Connection.IOHandler.ReadLn);
        if Length(s) = 0 then
        begin
          LAuthFailed := True;
        end
        else
        begin
          LPassword := TIdDecoderMIME.DecodeString(s);
        end;
      // when TIdDecoderMime.DecodeString(s) raise a exception,catch it and set AuthFailed as true
      except
        LAuthFailed := true;
      end;
    end
    else
    begin
      LAuthFailed := True;
    end;
  end;

  // Add other login units here

  if LAuthFailed then
  begin
    Result := False;
    CmdAuthFailed(ASender);
  end
  else
  begin
    LAccepted := False;
    if Assigned(fOnUserLogin) then
    begin
      fOnUserLogin(LS,  LUsername, LPassword, LAccepted);
    end
    else
    begin
      LAccepted := True;
    end;
    if LAccepted then
    begin
      LS.FState := Trans;
    end;
    LS.Username := LUsername;
    if not LAccepted then
    begin
      CmdAuthFailed(ASender);
    end
    else
    begin
      ASender.Reply.SetReply(235,' welcome ' + Trim(LUsername));    {Do not Localize}
      ASender.SendReply;
    end;
  end;
end;

procedure TIdPOP4Server.CmdAuthFailed(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(535,RSSMTPSvrAuthFailed);
  ASender.SendReply;
end;

procedure TIdPOP4Server.CommandAUTH(ASender: TIdCommand);
var
  Login: string;
begin
  //Note you can not use PIPELINING with AUTH
  TIdPOP4ServerContext(ASender.Context).PipeLining := False;
  if not ((FUseTLS=utUseRequireTLS) and not TIdSMTPServerContext(ASender.Context).UsingTLS) then
  begin
     Login := ASender.UnparsedParams;
     DoAuthLogin(ASender, Login);
  end
  else
  begin
    MustUseTLS(ASender);
  end;
end;

{ TIdPOP4ServerContext }

procedure TIdPOP4ServerContext.CheckPipeLine;
begin
  if Connection.IOHandler.InputBufferIsEmpty=False then
  begin
    PipeLining := True;
  end;
end;

constructor TIdPOP4ServerContext.Create(AConnection: TIdTCPConnection;
  AYarn: TIdYarn; AList: TThreadList);
begin
  inherited;
  FState := Auth;
  FUser := '';
  fPassword := '';
end;

function TIdPOP4ServerContext.GetUsingTLS: boolean;
begin
  Result := Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if Result then begin
    Result := not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end;
end;

procedure TIdPOP4ServerContext.SetPipeLining(const AValue: Boolean);
begin
  if AValue and (not PipeLining) then
  begin
    Connection.IOHandler.WriteBufferOpen;
  end
  else if (not AValue) and PipeLining then
  begin
    Connection.IOHandler.WriteBufferClose;
  end;
  FPipeLining := AValue;
end;

end.
