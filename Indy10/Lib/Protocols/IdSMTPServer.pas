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
  Rev 1.9    2/8/05 6:48:30 PM  RLebeau
  Misc. tweaks

  Rev 1.8    24/10/2004 21:26:14  ANeillans
  RCPTList can be set

    Rev 1.7    9/15/2004 5:02:06 PM  DSiders
  Added localization comments.

  Rev 1.6    31/08/2004 20:21:34  ANeillans
  Bug fix -- format problem.

  Rev 1.5    08/08/2004 21:03:10  ANeillans
  Continuing....

  Rev 1.4    02/08/2004 21:14:28  ANeillans
  Auth working

  Rev 1.3    01/08/2004 13:02:16  ANeillans
  Development.

  Rev 1.2    01/08/2004 09:50:26  ANeillans
  Continued development.

  Rev 1.1    7/28/2004 8:26:46 AM  JPMugaas
  Further work on the SMTP Server.  Not tested yet.

  Rev 1.0    7/27/2004 5:14:38 PM  JPMugaas
  Start on TIdSMTPServer rewrite.
}

unit IdSMTPServer;

interface

uses
  IdAssignedNumbers,
  IdCmdTCPServer,
  IdCommandHandlers,
  IdContext,
  IdEMailAddress,
  IdException,
  IdExplicitTLSClientServerBase,
  IdReply,
  IdReplyRFC,
  IdReplySMTP,
  IdTCPConnection,
  IdTCPServer,
  IdYarn,
  IdStack,
  IdSys,
  IdGlobal,
  IdObjs;

type
  EIdSMTPServerError = class(EIdException);
  EIdSMTPServerNoRcptTo = class(EIdSMTPServerError);

  TIdMailFromReply = (mAccept, mReject);

  TIdRCPToReply =
    (
    rAddressOk, //address is okay
    rRelayDenied, //we do not relay for third-parties
    rInvalid, //invalid address
    rWillForward, //not local - we will forward
    rNoForward, //not local - will not forward - please use
    rTooManyAddresses, //too many addresses
    rDisabledPerm, //disabled permentantly - not accepting E-Mail
    rDisabledTemp //disabled temporarily - not accepting E-Mail
    );

  TIdDataReply =
    (
    dOk, //accept the mail message
    dMBFull, //Mail box full
    dSystemFull, //no more space on server
    dLocalProcessingError, //local processing error
    dTransactionFailed, //transaction failed
    dLimitExceeded  //exceeded administrative limit
    );

  TIdSMTPServerContext = class;

  TOnSMTPUserLoginEvent = procedure(ASender: TIdSMTPServerContext; const AUsername, APassword: string;
    var VAuthenticated: Boolean) of object;
  TOnMailFromEvent = procedure(ASender: TIdSMTPServerContext; const AAddress : string;
    var VAction : TIdMailFromReply) of object;
  TOnRcptToEvent = procedure(ASender: TIdSMTPServerContext; const AAddress : string;
    var VAction : TIdRCPToReply; var VForward : String) of object;
  TOnMsgReceive = procedure(ASender: TIdSMTPServerContext; AMsg: TIdStream;
    var LAction : TIdDataReply) of object;
  TOnReceived = procedure(ASender: TIdSMTPServerContext; var AReceived : String) of object;
  TOnSMTPEvent = procedure(ASender: TIdSMTPServerContext) of object;

  TIdSMTPServer = class(TIdExplicitTLSServer)
  protected
    //events
    FOnUserLogin : TOnSMTPUserLoginEvent;
    FOnMailFrom : TOnMailFromEvent;
    FOnRcptTo : TOnRcptToEvent;
    FOnMsgReceive : TOnMsgReceive;
    FOnReceived : TOnReceived;
    FOnReset: TOnSMTPEvent;
    //misc
    FServerName : String;
    //
    function CreateGreeting: TIdReply; override;
    function CreateReplyUnknownCommand: TIdReply; override;
    //
    function DoAuthLogin(ASender: TIdCommand; const Login: string): Boolean;
    //command handlers
    procedure CommandNOOP(ASender: TIdCommand);
    procedure CommandQUIT(ASender: TIdCommand);
    procedure CommandEHLO(ASender: TIdCommand);
    procedure CommandHELO(ASender: TIdCommand);
    procedure CommandAUTH(ASender: TIdCommand);
    procedure CommandMAIL(ASender: TIdCommand);
    procedure CommandRCPT(ASender: TIdCommand);
    procedure CommandDATA(ASender: TIdCommand);
    procedure CommandRSET(ASender: TIdCommand);
    procedure CommandSTARTTLS(ASender: TIdCommand);
    {
    Note that for SMTP, I make a lot of procedures for replies.

    The reason is that we use precise enhanced status codes.  These serve
    as diangostics and give much more information than the 3 number standard replies.
    The enhanced codes will sometimes appear in bounce notices.
    Note: Enhanced status codes should only appear if a client uses EHLO instead of HELO.

    }
    //common reply procs
    procedure AuthFailed(ASender: TIdCommand);
    procedure CmdSyntaxError(AContext: TIdContext; ALine: string; const AReply : TIdReply = nil); overload;
    procedure CmdSyntaxError(ASender: TIdCommand); overload;

    procedure BadSequenceError(ASender: TIdCommand);
    procedure InvalidSyntax(ASender: TIdCommand);
    procedure NoHello(ASender: TIdCommand);
    procedure MustUseTLS(ASender: TIdCommand);
    //Mail From
    procedure MailFromAccept(ASender: TIdCommand; const AAddress : String = '');
    procedure MailFromReject(ASender: TIdCommand; const AAddress : String = '');
    //address replies   - RCPT TO
    procedure AddrValid(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrInvalid(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrWillForward(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrNotWillForward(ASender: TIdCommand; const AAddress : String = ''; const ATo : String = '');
    procedure AddrDisabledPerm(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrDisabledTemp(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrNoRelaying(ASender: TIdCommand; const AAddress : String = '');
    procedure AddrTooManyRecipients(ASender: TIdCommand);
    //mail submit replies
    procedure MailSubmitOk(ASender: TIdCommand);
    procedure MailSubmitLimitExceeded(ASender: TIdCommand);
    procedure MailSubmitStorageExceededFull(ASender: TIdCommand);
    procedure MailSubmitTransactionFailed(ASender: TIdCommand);
    procedure MailSubmitLocalProcessingError(ASender: TIdCommand);
    procedure MailSubmitSystemFull(ASender: TIdCommand);
    procedure SetEnhReply(AReply: TIdReply; const ANumericCode: Integer;
      const AEnhReply, AText: String; const IsEHLO: Boolean);
    //  overrides for SMTP
    function GetReplyClass: TIdReplyClass; override;
    function GetRepliesClass: TIdRepliesClass; override;
    procedure InitComponent; override;
    procedure DoReplyUnknownCommand(AContext: TIdContext; ALine: string); override;
    procedure InitializeCommandHandlers; override;
    //
    procedure DoReset(AContext: TIdSMTPServerContext; AIsTLSReset: Boolean = False);
  published
    //events
    property OnMsgReceive : TOnMsgReceive read FOnMsgReceive write FOnMsgReceive;
    property OnUserLogin : TOnSMTPUserLoginEvent read FOnUserLogin write FOnUserLogin;
    property OnMailFrom : TOnMailFromEvent read FOnMailFrom write FOnMailFrom;
    property OnRcptTo : TOnRcptToEvent read FOnRcptTo write FOnRcptTo;
    property OnReceived: TOnReceived read FOnReceived write FOnReceived;
    property OnReset: TOnSMTPEvent read FOnReset write FOnReset;
    //properties
    property ServerName : String read FServerName write FServerName;
    property DefaultPort default IdPORT_SMTP;
    property UseTLS;
  end;

  TIdSMTPState = (idSMTPNone, idSMTPHelo, idSMTPMail, idSMTPRcpt, idSMTPData);

  TIdSMTPServerContext = class(TIdContext)
  protected
    FSMTPState: TIdSMTPState;
    FFrom: string;
    FRCPTList: TIdEMailAddressList;
    FHELO: Boolean;
    FEHLO: Boolean;
    FHeloString: String;
    FUsername: string;
    FPassword: string;
    FLoggedIn: Boolean;
    FPipeLining : Boolean;
    FFinalStage : Boolean;
    function GetUsingTLS: Boolean;
    procedure SetPipeLining(const AValue : Boolean);
  public
    constructor Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdThreadList = nil); override;
    destructor Destroy; override;
    //
    procedure CheckPipeLine;
    procedure Reset(AIsTLSReset: Boolean = False); virtual;
    //
    property SMTPState: TIdSMTPState read FSMTPState write FSMTPState;
    property From: string read FFrom write FFrom;
    property RCPTList: TIdEMailAddressList read FRCPTList write FRCPTList;
    property HELO: Boolean read FHELO write FHELO;
    property EHLO: Boolean read FEHLO write FEHLO;
    property HeloString : String read FHeloString write FHeloString;
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;
    property LoggedIn: Boolean read FLoggedIn write FLoggedIn;
    property FinalStage: Boolean read FFinalStage write FFinalStage;
    property UsingTLS: Boolean read GetUsingTLS;
    property PipeLining: Boolean read FPipeLining write SetPipeLining;
    //
  end;

const
 IdSMTPSvrReceivedString = 'Received: from $hostname[$ipaddress] (helo=$helo) by $svrhostname[$svripaddress] with $protocol ($servername)'; {do not localize}

implementation

uses
  IdCoderMIME,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdSSL;

{ TIdSMTPServer }

procedure TIdSMTPServer.CmdSyntaxError(AContext: TIdContext; ALine: string;
  const AReply: TIdReply);
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
      LReply := TIdReplySMTP.Create(nil, ReplyTexts);
      LReply.Assign(ReplyUnknownCommand);
    end;
    SetEnhReply(LReply, 500, '5.0.0', Sys.Format(RSFTPCmdNotRecognized, [LTmp]), {do not localize}
      TIdSMTPServerContext(AContext).Ehlo);
    AContext.Connection.IOHandler.Write(LReply.FormattedReply);
  finally
    if not Assigned(AReply) then begin
      Sys.FreeAndNil(LReply);
    end;
  end;
end;

procedure TIdSMTPServer.BadSequenceError(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 503, Id_EHR_PR_OTHER_PERM, RSSMTPSvrBadSequence,
   TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.CmdSyntaxError(ASender: TIdCommand);
begin
  CmdSyntaxError(ASender.Context, ASender.RawLine, FReplyUnknownCommand );
  ASender.PerformReply := False;
end;

function TIdSMTPServer.CreateGreeting: TIdReply;
begin
  Result := TIdReplySMTP.Create(nil, ReplyTexts);
  TIdReplySMTP(Result).SetEnhReply(220, '' ,RSSMTPSvrWelcome)
end;

function TIdSMTPServer.CreateReplyUnknownCommand: TIdReply;
begin
  Result := TIdReplySMTP.Create(nil, ReplyTexts);
  TIdReplySMTP(Result).SetEnhReply(500, Id_EHR_PR_SYNTAX_ERR, 'Syntax Error'); {do not localize}
end;

procedure TIdSMTPServer.CommandEHLO(ASender: TIdCommand);
var
  LContext : TIdSMTPServerContext;
begin
  LContext := TIdSMTPServerContext(ASender.Context);
  SetEnhReply(ASender.Reply, 250, '', Sys.Format(RSSMTPSvrHello, [ASender.UnparsedParams]), True);
  if Assigned(FOnUserLogin) then begin
    ASender.Reply.Text.Add('AUTH LOGIN');    {Do not Localize}
  end;
  ASender.Reply.Text.Add('ENHANCEDSTATUSCODES'); {do not localize}
  ASender.Reply.Text.Add('PIPELINING'); {do not localize}
  if (FUseTLS in ExplicitTLSVals) and (not LContent.UsingTLS) then begin
    ASender.Reply.Text.Add('STARTTLS');    {Do not Localize}
  end;
  DoReset(LContext);
  LContext.EHLO := True;
  LContext.SMTPState := idSMTPHelo;
  LContext.HeloString := ASender.UnparsedParams;
end;

procedure TIdSMTPServer.DoReplyUnknownCommand(AContext: TIdContext;
  ALine: string);
begin
  CmdSyntaxError(AContext,ALine);
end;

function TIdSMTPServer.GetRepliesClass: TIdRepliesClass;
begin
  Result := TIdRepliesSMTP;
end;

function TIdSMTPServer.GetReplyClass: TIdReplyClass;
begin
  Result := TIdReplySMTP;
end;

procedure TIdSMTPServer.InitComponent;
begin
  inherited;
  FContextClass := TIdSMTPServerContext;
  HelpReply.Code := ''; //we will handle the help ourselves
  FRegularProtPort := IdPORT_SMTP;
  FImplicitTLSProtPort := IdPORT_ssmtp;
  DefaultPort := IdPORT_SMTP;
  FServerName  := 'Indy SMTP Server'; {do not localize}
end;

procedure TIdSMTPServer.InitializeCommandHandlers;
var
  LCmd : TIdCommandHandler;
begin
  inherited InitializeCommandHandlers;

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'EHLO';  {do not localize}
  LCmd.OnCommand := CommandEHLO;
  LCmd.NormalReply.NumericCode := 250;
  LCmd.ParseParams := True;
  SetEnhReply(LCmd.ExceptionReply ,451,Id_EHR_PR_OTHER_TEMP, 'Internal Error', False); {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'HELO';  {do not localize}
  LCmd.OnCommand := CommandHELO;
  LCmd.NormalReply.NumericCode := 250;
  LCmd.ParseParams := True;
  SetEnhReply(LCmd.ExceptionReply ,451,Id_EHR_PR_OTHER_TEMP, 'Internal Error', False); {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'AUTH';  {do not localize}
  LCmd.OnCommand := CommandAUTH;
  LCmd.ParseParams := True;
  SetEnhReply(LCmd.ExceptionReply ,451,Id_EHR_PR_OTHER_TEMP, 'Internal Error', False); {do not localize}

  LCmd := CommandHandlers.Add;
  // NOOP
  LCmd.Command := 'NOOP';    {Do not Localize}
  SetEnhReply(LCmd.NormalReply ,250,Id_EHR_GENERIC_OK,RSSMTPSvrOk, True);
  LCmd.OnCommand := CommandNOOP;
  SetEnhReply(LCmd.ExceptionReply ,451,Id_EHR_PR_OTHER_TEMP, 'Internal Error', False); {do not localize}

  LCmd := CommandHandlers.Add;
  // QUIT
  LCmd.Command := 'QUIT';    {Do not Localize}
  LCmd.CmdDelimiter := ' ';    {Do not Localize}
  LCmd.Disconnect := True;
  SetEnhReply(LCmd.NormalReply, 221, Id_EHR_GENERIC_OK, RSSMTPSvrQuit, False);
  LCmd.OnCommand := CommandQUIT;

  LCmd := CommandHandlers.Add;
  // RCPT <SP> TO:<forward-path> <CRLF>
  LCmd.Command := 'RCPT';    {Do not Localize}
  LCmd.CmdDelimiter := ' ';    {Do not Localize}
  LCmd.OnCommand := CommandRcpt;
  SetEnhReply(LCmd.NormalReply, 250, Id_EHR_MSG_VALID_DEST,'', False);
  SetEnhReply(LCmd.ExceptionReply,550,Id_EHR_MSG_BAD_DEST,'', False);

  LCmd := CommandHandlers.Add;
  // MAIL <SP> FROM:<reverse-path> <CRLF>
  LCmd.Command := 'MAIL';    {Do not Localize}
  LCmd.CmdDelimiter := ' ';    {Do not Localize}
  LCmd.OnCommand := CommandMail;
  SetEnhReply(LCmd.NormalReply, 250, Id_EHR_MSG_OTH_OK,'',False);
  SetEnhReply(LCmd.ExceptionReply,451,Id_EHR_MSG_BAD_SENDER_ADDR,'', False);

  LCmd := CommandHandlers.Add;
  // DATA <CRLF>
  LCmd.Command := 'DATA'; {Do not Localize}
  LCmd.OnCommand := CommandDATA;
  SetEnhReply(LCmd.NormalReply , 354, '', RSSMTPSvrStartData, False);
  SetEnhReply(LCmd.ExceptionReply, 451, Id_EHR_PR_OTHER_TEMP, 'Internal Error' , False); {do not localize}

  LCmd := CommandHandlers.Add;
  // RSET <CRLF>
  LCmd.Command := 'RSET';    {Do not Localize}
  LCmd.NormalReply.SetReply(250, RSSMTPSvrOk);
  LCmd.OnCommand := CommandRSET;

  LCmd := CommandHandlers.Add;
  // STARTTLS <CRLF>
  LCmd.Command := 'STARTTLS';    {Do not Localize}
  SetEnhReply(LCmd.NormalReply, 220, Id_EHR_GENERIC_OK, RSSMTPSvrReadyForTLS, False);
  LCmd.OnCommand := CommandStartTLS;
end;

procedure TIdSMTPServer.MustUseTLS(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 530, Id_EHR_USE_STARTTLS, RSSMTPSvrReqSTARTTLS,
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.CommandAUTH(ASender: TIdCommand);
var
  Login: string;
begin
  //Note you can not use PIPELINING with AUTH
  TIdSMTPServerContext(ASender.Context).PipeLining := False;
  if not TIdSMTPServerContext(ASender.Context).EHLO then begin // Only available with EHLO
    BadSequenceError(ASender);
    Exit;
  end;
  if (FUseTLS = utUseRequireTLS) and (not TIdSMTPServerContext(ASender.Context).UsingTLS) then begin
    MustUseTLS(ASender);
    Exit;
  end;
  if not Assigned(FOnUserLogin) then begin
    AuthFailed(ASender);
    Exit;
  end;
  if Length(ASender.UnparsedParams) > 0 then begin
    DoAuthLogin(ASender, ASender.UnparsedParams);
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdSMTPServer.CommandHELO(ASender: TIdCommand);
var
  LContext : TIdSMTPServerContext;
begin
  LContext := TIdSMTPServerContext(ASender.Context);
  if LContext.SMTPState <> idSMTPNone then begin
    BadSequenceError(ASender);
    Exit;
  end;
  if Length(ASender.UnparsedParams) > 0 then begin
    ASender.Reply.SetReply(250, Sys.Format(RSSMTPSvrHello, [ASender.UnparsedParams]));
    DoReset(LContext);
    LContext.HELO := True;
    LContext.SMTPState := idSMTPHelo;
    LContext.HeloString := ASender.UnparsedParams;
  end else begin
    ASender.Reply.SetReply(501, RSSMTPSvrParmErr);
  end;
end;

function TIdSMTPServer.DoAuthLogin(ASender: TIdCommand; const Login: string): Boolean;
var
  S: string;
  LUsername, LPassword: string;
  LAuthFailed: Boolean;
  LAccepted: Boolean;
  LContext : TIdSMTPServerContext;
  LEncoder: TIdEncoderMIME;
  LDecoder: TIdDecoderMIME;
begin
  LContext := TIdSMTPServerContext(ASender.Context);
  Result := False;
  LAuthFailed := False;
  LContext.PipeLining := False;
  if TextIsSame(Login, 'LOGIN') then begin   {Do not Localize}
    // LOGIN USING THE LOGIN AUTH - BASE64 ENCODED
    try
      LEncoder := TIdEncoderMIME.Create;
      try
        // Encoding a string literal?
        s := LEncoder.Encode('Username:');     {Do not Localize}
        //  s := SendRequest( '334 ' + s );    {Do not Localize}
        ASender.Reply.SetReply(334, s);    {Do not Localize}
        ASender.SendReply;
        s := Sys.Trim(LContext.Connection.IOHandler.ReadLn);
        if s <> '' then begin   {Do not Localize}
          LDecoder := TIdDecoderMIME.Create;
          try
            LUsername := LDecoder.DecodeString(s);
            // What? Encode this string literal?
            s := LEncoder.Encode('Password:');    {Do not Localize}
            ASender.Reply.SetReply(334, s);    {Do not Localize}
            ASender.SendReply;
            s := Sys.Trim(ASender.Context.Connection.IOHandler.ReadLn);
            if s <> '' then begin
              LPassword := LDecoder.DecodeString(s);
            end else begin
              LAuthFailed := True;
            end;
          // when TIdDecoderMime.DecodeString(s) raise a exception,catch it and set AuthFailed as true
          finally
            Sys.FreeAndNil(LDecoder);
          end;
        end else begin
          LAuthFailed := True;
        end;
      finally
        Sys.FreeAndNil(LEncoder);
      end;
    except
      LAuthFailed := True;
    end;
  end;

  // Add other login units here

  if LAuthFailed then begin
    Result := False;
    AuthFailed(ASender);
  end else begin
    LAccepted := False;
    if Assigned(FOnUserLogin) then begin
      FOnUserLogin(LContext, LUsername, LPassword, LAccepted);
    end else begin
      LAccepted := True;
    end;
    LContext.LoggedIn := LAccepted;
    LContext.Username := LUsername;
    if not LAccepted then begin
      AuthFailed(ASender);
    end else begin
      SetEnhReply(ASender.Reply, 235, Id_EHR_SEC_OTHER_OK, ' welcome ' + Sys.Trim(LUsername), LContext.EHLO);    {Do not Localize}
      ASender.SendReply;
    end;
  end;
end;

procedure TIdSMTPServer.SetEnhReply(AReply: TIdReply; const ANumericCode: Integer;
  const AEnhReply, AText: String; const IsEHLO: Boolean);
begin
  if IsEHLO and (AReply is TIdReplySMTP) then begin
    TIdReplySMTP(AReply).SetEnhReply(ANumericCode, AEnhReply, AText);
  end else begin
    AReply.SetReply(ANumericCode, AText);
  end;
end;

procedure TIdSMTPServer.AuthFailed(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 535, Id_EHR_SEC_OTHER_PERM, RSSMTPSvrAuthFailed,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.AddrInvalid(ASender: TIdCommand; const AAddress : String = '');
begin
  SetEnhReply(ASender.Reply, 500, Id_EHR_MSG_BAD_DEST, Sys.Format(RSSMTPSvrAddressError, [AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrNotWillForward(ASender: TIdCommand; const AAddress : String = ''; const ATo : String = '');
begin
  SetEnhReply(ASender.Reply, 521, Id_EHR_SEC_DEL_NOT_AUTH, Sys.Format(RSSMTPUserNotLocal, [AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrValid(ASender: TIdCommand; const AAddress : String = '');
begin
  SetEnhReply(ASender.Reply,250, Id_EHR_MSG_VALID_DEST,Sys.Format(RSSMTPSvrAddressOk, [AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrNoRelaying(ASender: TIdCommand;
  const AAddress: String);
begin
  SetEnhReply(ASender.Reply, 550, Id_EHR_SEC_DEL_NOT_AUTH, Sys.Format(RSSMTPSvrNoRelay, [AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrWillForward(ASender: TIdCommand; const AAddress : String = '');
begin
// Note, changed format from RSSMTPUserNotLocal as it now has two %s.
  SetEnhReply(ASender.Reply, 251, Id_EHR_MSG_VALID_DEST, Sys.Format(RSSMTPUserNotLocalNoAddr, [AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrTooManyRecipients(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply,250,Id_EHR_PR_TOO_MANY_RECIPIENTS_PERM, RSSMTPTooManyRecipients,
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrDisabledPerm(ASender: TIdCommand;
  const AAddress: String);
begin
  SetEnhReply(ASender.Reply, 550, Id_EHR_MB_DISABLED_PERM, Sys.Format(RSSMTPAccountDisabled,[AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.AddrDisabledTemp(ASender: TIdCommand;
  const AAddress: String);
begin
  SetEnhReply(ASender.Reply, 550, Id_EHR_MB_DISABLED_TEMP, Sys.Format(RSSMTPAccountDisabled,[AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.MailSubmitLimitExceeded(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 552, Id_EHR_MB_MSG_LEN_LIMIT, RSSMTPMsgLenLimit,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailSubmitLocalProcessingError(
  ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 451, Id_EHR_MD_OTHER_TRANS, RSSMTPLocalProcessingError,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailSubmitOk(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 250, '', RSSMTPSvrOk, TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailSubmitStorageExceededFull(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 552, Id_EHR_MB_FULL, RSSMTPSvrExceededStorageAlloc,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailSubmitSystemFull(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 452, Id_EHR_MD_MAIL_SYSTEM_FULL, RSSMTPSvrInsufficientSysStorage,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailSubmitTransactionFailed(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 554, Id_EHR_MB_OTHER_STATUS_TRANS, RSSMTPSvrTransactionFailed,
    TIdSMTPServerContext(ASender.Context).EHLO);
  ASender.SendReply;
end;

procedure TIdSMTPServer.MailFromAccept(ASender: TIdCommand; const AAddress : String = '');
begin
  SetEnhReply(ASender.Reply, 250, Id_EHR_MSG_OTH_OK, Sys.Format(RSSMTPSvrAddressOk,[AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.MailFromReject(ASender: TIdCommand; const AAddress : String = '');
begin
  SetEnhReply(ASender.Reply, 550, Id_EHR_SEC_DEL_NOT_AUTH, Sys.Format(RSSMTPSvrNotPermitted,[AAddress]),
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.NoHello(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 501, Id_EHR_PR_OTHER_PERM, RSSMTPSvrNoHello,
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.CommandMAIL(ASender: TIdCommand);
var
  EMailAddress: TIdEMailAddressItem;
  LContext : TIdSMTPServerContext;
  LM : TIdMailFromReply;
begin
  //Note that unlike other protocols, it might not be possible
  //to completely disable MAIL FROM for people not using SSL
  //because SMTP is also used from server to server mail transfers.
  LContext := TIdSMTPServerContext(ASender.Context);
  if LContext.HELO or LContext.EHLO then begin // Looking for either HELO or EHLO
    //reset all information
    LContext.From := '';    {Do not Localize}
    LContext.RCPTList.Clear;
    if TextStartsWith(ASender.UnparsedParams, 'FROM:') then begin   {Do not Localize}
      EMailAddress := TIdEMailAddressItem.Create(nil);
      try
        EMailAddress.Text := Sys.Trim(Copy(ASender.UnparsedParams, 6, MaxInt));
        LM := mAccept;
        if Assigned(FOnMailFrom) then begin
          FOnMailFrom(LContext, EMailAddress.Address, LM);
        end;
        case LM of
          mAccept :
          begin
            MailFromAccept(ASender, EMailAddress.Address);
            LContext.From := EMailAddress.Address;
            LContext.SMTPState := idSMTPMail;
          end;
          mReject :
          begin
            MailFromReject(ASender, EMailAddress.Text);
          end;
        end;
      finally
        Sys.FreeAndNil(EMailAddress);
      end;
    end else begin
      InvalidSyntax(ASender);
    end;
  end else begin // No EHLO / HELO was received
    NoHello(ASender);
  end;
  LContext.CheckPipeLine;
end;

procedure TIdSMTPServer.InvalidSyntax(ASender: TIdCommand);
begin
  SetEnhReply(ASender.Reply, 501, Id_EHR_PR_INVALID_CMD_ARGS, RSPOP3SvrInvalidSyntax,
    TIdSMTPServerContext(ASender.Context).EHLO);
end;

procedure TIdSMTPServer.CommandRCPT(ASender: TIdCommand);
var
  EMailAddress: TIdEMailAddressItem;
  LContext : TIdSMTPServerContext;
  LAction : TIdRCPToReply;
  LForward : String;
begin
  LForward := '';
  LContext := TIdSMTPServerContext(ASender.Context);
  if not LContext.SMTPState in [idSMTPMail, idSMTPRcpt] then begin
    BadSequenceError(ASender);
    Exit;
  end;
  if LContext.HELO or LContext.EHLO then begin
    if TextStartsWith(ASender.UnparsedParams, 'TO:') then begin   {Do not Localize}
      LAction :=  rRelayDenied;
      //do not change this in the OnRcptTo event unless one of the following
      //things is TRUE:
      //
      //1.  The user authenticated to the SMTP server
      //
      //2.  The user is from an IP address being served by the SMTP server.
      //    Test the IP address for this.
      //
      //3.  Another SMTP server outside of your network is sending E-Mail to a
      //    user on YOUR system.
      //
      //The reason is that you do not want to relay E-Messages for outsiders
      //if the E-Mail is from outside of your network.  Be very CAREFUL.  Otherwise,
      //you have a security hazard that spammers can abuse.
      EMailAddress := TIdEMailAddressItem.Create(nil);
      try
        EMailAddress.Text := Sys.Trim(Copy(ASender.UnparsedParams, 4, MaxInt));
        if Assigned(FOnRcptTo) then begin
          FOnRcptTo(LContext, EMailAddress.Address, LAction, LForward);
          case LAction of
            rAddressOk :
            begin
              AddrValid(ASender, EMailAddress.Address);
              LContext.RCPTList.Add.Text := EMailAddress.Text;
              LContext.SMTPState := idSMTPRcpt;
            end;
            rRelayDenied :
            begin
              AddrNoRelaying(ASender, EMailAddress.Address);
            end;
            rWillForward :
            begin
              AddrWillForward(ASender, EMailAddress.Address);
              LContext.RCPTList.Add.Text := EMailAddress.Text;
              LContext.SMTPState := idSMTPRcpt;
            end;
            rNoForward : AddrNotWillForward(ASender, EMailAddress.Address, LForward);
            rTooManyAddresses : AddrTooManyRecipients(ASender);
            rDisabledPerm : AddrDisabledPerm(ASender, EMailAddress.Address);
            rDisabledTemp : AddrDisabledTemp(ASender, EMailAddress.Address);
          else
            AddrInvalid(ASender, EMailAddress.Address);
          end;
        end else begin
          raise EIdSMTPServerNoRcptTo.Create(RSSMTPNoOnRcptTo);
        end;
      finally
       Sys.FreeAndNil(EMailAddress);
      end;
    end else begin
      SetEnhReply(ASender.Reply, 501, Id_EHR_PR_SYNTAX_ERR,RSSMTPSvrParmErrRcptTo,
        LContext.EHLO);
    end;
  end else begin // No EHLO / HELO was received
    NoHello(ASender);
  end;
  LContext.CheckPipeLine;
end;

procedure TIdSMTPServer.CommandSTARTTLS(ASender: TIdCommand);
var
  LContext : TIdSMTPServerContext;
begin
  LContext := TIdSMTPServerContext(ASender.Context);
  if not LContext.EHLO then begin
    BadSequenceError(ASender);
    Exit;
  end;
  if FUseTLS in ExplicitTLSVals then begin
    if LContext.UsingTLS then begin // we are already using TLS
      BadSequenceError(ASender);
      Exit;
    end;
    SetEnhReply(ASender.Reply, 220, Id_EHR_GENERIC_OK, RSSMTPSvrReadyForTLS, LContext.EHLO);
    ASender.SendReply;
    TIdSSLIOHandlerSocketBase(LContext.Connection.IOHandler).PassThrough := False;
    DoReset(LContext, True);
  end else begin
    CmdSyntaxError(ASender);
    LContext.PipeLining := False;
  end;
end;

procedure TIdSMTPServer.CommandNOOP(ASender: TIdCommand);
begin
//we just use the default NOOP and only clear pipelining for synchronization
  TIdSMTPServerContext(ASender.Context).PipeLining := False;
end;

procedure TIdSMTPServer.CommandQUIT(ASender: TIdCommand);
begin
//clear pipelining before exit
  TIdSMTPServerContext(ASender.Context).PipeLining := False;
  ASender.SendReply;
end;

procedure TIdSMTPServer.CommandRSET(ASender: TIdCommand);
begin
  DoReset(TIdSMTPServerContext(ASender.Context));
end;

procedure TIdSMTPServer.CommandDATA(ASender: TIdCommand);
var
  LContext : TIdSMTPServerContext;
  LStream: TIdStream;
  AMsg : TIdStream;
  LAction : TIdDataReply;
  LReceivedString : String;

  // RLebeau: if HostByAddress() fails, the received
  // message gets lost, so trapping any exceptions here
  function AddrFromHost(const AIP: String): String;
  begin
    try
      Result := GStack.HostByAddress(AIP);
    except
      Result := 'unknown'; {do not localize}
    end;
  end;

  // RLebeau: processing the tokens dynamically now
  // so that only the tokens that are actually present
  // will be processed.  This helps to avoid unnecessary
  // lookups for tokens that are not actually used
  procedure ReplaceReceivedTokens;
  var
    LTokens: TIdStringList;
    i, LPos: Integer;
    //we do it this way so we can take advantage of the StringBuilder in DotNET.
    ReplaceOld, ReplaceNew: array of string;
  begin
    LTokens := TIdStringList.Create;
    try
      if Pos('$hostname', LReceivedString) <> 0 then begin                  {do not localize}
        LTokens.Add('$hostname=' + AddrFromHost(LContext.Binding.PeerIP));  {do not localize}
      end;

      if Pos('$ipaddress', LReceivedString) <> 0 then begin                 {do not localize}
        LTokens.Add('$ipaddress=' + LContext.Binding.PeerIP);               {do not localize}
      end;

      if Pos('$helo', LReceivedString) <> 0 then begin                      {do not localize}
        LTokens.Add('$helo=' + LContext.HeloString);                        {do not localize}
      end;

      if Pos('$helo', LReceivedString) <> 0 then begin                      {do not localize}
        LTokens.Add('$helo=' + LContext.HeloString);                        {do not localize}
      end;

      if Pos('$protocol', LReceivedString) <> 0 then begin                  {do not localize}
        LTokens.Add('$protocol=' + iif(LContext.EHLO, 'esmtp', 'smtp'));    {do not localize}
      end;

      if Pos('$servername', LReceivedString) <> 0 then begin                {do not localize}
        LTokens.Add('$servername=' + FServerName);                          {do not localize}
      end;

      if Pos('$svrhostname', LReceivedString) <> 0 then begin               {do not localize}
        LTokens.Add('$svrhostname=' + AddrFromHost(LContext.Binding.IP));   {do not localize}
      end;

      if Pos('$svripaddress', LReceivedString) <> 0 then begin              {do not localize}
        LTokens.Add('$svripaddress=' + LContext.Binding.IP);                {do not localize}
      end;

      if LTokens.Count > 0 then
      begin
        SetLength(ReplaceNew, LTokens.Count);
        SetLength(ReplaceOld, LTokens.Count);

        for i := 0 to LTokens.Count-1 do begin
          LPos := Pos('=', LTokens.Strings[i]);
          ReplaceOld[i] := Copy(LTokens.Strings[i], 1, LPos-1);
          ReplaceNew[i] := Copy(LTokens.Strings[i], LPos+1, MaxInt);
        end;

        LReceivedString := Sys.StringReplace(LReceivedString, ReplaceOld, ReplaceNew);
      end;
    finally
      Sys.FreeAndNil(LTokens);
    end;
  end;

begin
  LReceivedString := IdSMTPSvrReceivedString;
  LContext := TIdSMTPServerContext(ASender.Context);
  if (LContext.SMTPState <> idSMTPRcpt) then begin
    BadSequenceError(ASender);
    Exit;
  end;
  if LContext.HELO or LContext.EHLO then begin
    SetEnhReply(ASender.Reply, 354, '', RSSMTPSvrStartData, LContext.EHLO);
    ASender.SendReply;
    LContext.PipeLining := False;
    LStream := TIdMemoryStream.Create;
    try
      // RLebeau: TODO - do not even create the stream if the OnMsgReceive event is not assigned
      AMsg := TIdMemoryStream.Create;
      try
        LAction := dOk;
        LContext.Connection.IOHandler.Capture(LStream, '.', True);    {Do not Localize}
        LStream.Position := 0;
        if Assigned(FOnReceived) then begin
          FOnReceived(LContext, LReceivedString);
        end;
        if LContext.FinalStage then begin
          // If at the final delivery stage, add the Return-Path line for the received MAIL FROM line.
          WriteStringToStream(AMsg, 'Received-Path: <' + LContext.From + '>' + EOL); {do not localize}
        end;
        if LReceivedString <> '' then begin
          ReplaceReceivedTokens;
          WriteStringToStream(AMsg, LReceivedString + EOL);
        end;
        AMsg.CopyFrom(LStream, 0); // Copy the contents that was captured to the new stream.
        AMsg.Position := 0; // RLebeau: CopyFrom() does not reset the Position
        if Assigned(FOnMsgReceive) then begin
          FOnMsgReceive(LContext, AMsg, LAction);
        end;
      finally
        Sys.FreeAndNil(AMsg);
      end;
    finally
      Sys.FreeAndNil(LStream);
    end;
    case LAction of
    dOk                   : MailSubmitOk(ASender); //accept the mail message
    dMBFull               : MailSubmitStorageExceededFull(ASender); //Mail box full
    dSystemFull           : MailSubmitSystemFull(ASender); //no more space on server
    dLocalProcessingError : MailSubmitLocalProcessingError(ASender); //local processing error
    dTransactionFailed    : MailSubmitTransactionFailed(ASender); //transaction failed
    dLimitExceeded        : MailSubmitLimitExceeded(ASender); //exceeded administrative limit
    end;
  end else begin // No EHLO / HELO was received
    NoHello(ASender);
  end;
  LContext.PipeLining := False;
end;

procedure TIdSMTPServer.DoReset(AContext: TIdSMTPServerContext; AIsTLSReset: Boolean = False);
begin
  AContext.Reset(AIsTLSReset);
  if Assigned(FOnReset) then begin
    FOnReset(AContext);
  end;
end;

{ TIdSMTPServerContext }

procedure TIdSMTPServerContext.CheckPipeLine;
begin
  if not Connection.IOHandler.InputBufferIsEmpty then begin
    PipeLining := True;
  end;
end;

constructor TIdSMTPServerContext.Create(AConnection: TIdTCPConnection;
  AYarn: TIdYarn; AList: TIdThreadList);
begin
  inherited;
  SMTPState := idSMTPNone;
  From := '';
  HELO := False;
  EHLO := False;
  Username := '';
  Password := '';
  LoggedIn := False;
  Sys.FreeAndNil(FRCPTList);
  FRCPTList := TIdEMailAddressList.Create(nil);
end;

destructor TIdSMTPServerContext.Destroy;
begin
  Sys.FreeAndNil(FRCPTList);
  inherited;
end;

function TIdSMTPServerContext.GetUsingTLS: Boolean;
begin
  Result := Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if Result then begin
    Result := not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end;
end;

procedure TIdSMTPServerContext.Reset(AIsTLSReset: Boolean = False);
begin
  if (not AIsTLSReset) and (FEHLO or FHELO) then begin
    FSMTPState := idSMTPHelo;
  end else begin
    FSMTPState := idSMTPNone;
    FEHLO := False;
    FHELO := False;
  end;
  FFrom := '';
  FHeloString := '';
  FRCPTList.Clear;
  FUsername := '';
  FPassword := '';
  FLoggedIn := False;
  FFinalStage := False;
  CheckPipeLine;
end;

procedure TIdSMTPServerContext.SetPipeLining(const AValue: Boolean);
begin
  if AValue and (not PipeLining) then begin
    Connection.IOHandler.WriteBufferOpen;
  end else if (not AValue) and PipeLining then begin
    Connection.IOHandler.WriteBufferClose;
  end;
  FPipeLining := AValue;
end;

end.
