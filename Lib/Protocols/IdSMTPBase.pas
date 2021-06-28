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
  Rev 1.19    10/01/2005 16:31:20  ANeillans
  Minor bug fix for Exim compatibility.

  Rev 1.18    11/27/04 3:03:22 AM  RLebeau
  Bug fix for 'STARTTLS' response handling

    Rev 1.17    6/11/2004 9:38:44 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.16    2004.02.03 5:45:46 PM  czhower
  Name changes

  Rev 1.15    2004.02.03 2:12:18 PM  czhower
  $I path change

  Rev 1.14    1/28/2004 8:08:10 PM  JPMugaas
  Fixed a bug in SendGreeting.  It was sending an invalid EHLO and probably an
  invalid HELO command.  The problem is that it was getting the computer name.
  There's an issue in NET with that which  Kudzu commented on in IdGlobal.
  Thus, "EHLO<space>" and probably "HELO<space>" were being sent causing a
  failure.  The fix is to to try to get the local computer's DNS name with
  GStack.HostName.  We only use the computer name if GStack.HostName fails.

  Rev 1.13    1/25/2004 3:11:48 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.12    2004.01.22 10:29:58 PM  czhower
  Now supports default login mechanism with just username and pw.

  Rev 1.11    1/21/2004 4:03:24 PM  JPMugaas
  InitComponent

  Rev 1.10    22/12/2003 00:46:36  CCostelloe
  .NET fixes

  Rev 1.9    4/12/2003 10:24:08 PM  GGrieve
  Fix to Compile

  Rev 1.8    25/11/2003 12:24:22 PM  SGrobety
  various IdStream fixes with ReadLn/D6

    Rev 1.7    10/17/2003 1:02:56 AM  DSiders
  Added localization comments.

  Rev 1.6    2003.10.14 1:31:16 PM  czhower
  DotNet

  Rev 1.5    2003.10.12 6:36:42 PM  czhower
  Now compiles.

  Rev 1.4    10/11/2003 7:14:36 PM  BGooijen
  Changed IdCompilerDefines.inc path

  Rev 1.3    10/10/2003 10:45:12 PM  BGooijen
  DotNet

  Rev 1.2    2003.10.02 9:27:54 PM  czhower
  DotNet Excludes

  Rev 1.1    6/15/2003 03:28:24 PM  JPMugaas
  Minor class change.

  Rev 1.0    6/15/2003 01:06:48 PM  JPMugaas
  TIdSMTP and TIdDirectSMTP now share common code in this base class.
}

unit IdSMTPBase;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdEMailAddress,
  IdMessage,
  IdMessageClient,
  IdReply,
  IdTCPClient;

//default property values
const
  DEF_SMTP_PIPELINE = False;
  IdDEF_UseEhlo = True; //APR: default behavior
  IdDEF_UseVerp = False;

const
  CAPAPIPELINE = 'PIPELINING';  {do not localize}
  CAPAVERP = 'VERP';            {do not localize}
  XMAILER_HEADER = 'X-Mailer';  {do not localize}

const
  RCPTTO_ACCEPT : array [0..1] of Int16 = (250, 251);
  MAILFROM_ACCEPT : Int16 = 250;
  DATA_ACCEPT : Int16 = 354;
  DATA_PERIOD_ACCEPT : Int16 = 250;
  RSET_ACCEPT : Int16 = 250;

const
  RSET_CMD = 'RSET';            {do not localize}
  MAILFROM_CMD = 'MAIL FROM:';  {do not localize}
  RCPTTO_CMD = 'RCPT TO:';      {do not localize}
  DATA_CMD = 'DATA';            {do not localize}

type
  TIdSMTPFailedRecipient = procedure(Sender: TObject; const AAddress, ACode, AText: String;
    var VContinue: Boolean) of object;
  TIdSMTPFailedEHLO = procedure(Sender: TObject; const ACode, AText: String;
    var VContinue: Boolean) of object;

  TIdSMTPBase = class(TIdMessageClient)
  protected
    FMailAgent: string;
    FHeloName : String;
    FPipeline : Boolean;
    FUseEhlo : Boolean;
    FUseVerp : Boolean;
    FVerpDelims: string;
    FOnFailedRecipient: TIdSMTPFailedRecipient;
    FOnFailedEHLO: TIdSMTPFailedEHLO;
    //
    function GetSupportsTLS : Boolean; override;
    function GetReplyClass: TIdReplyClass; override;
    procedure InitComponent; override;
    procedure SendGreeting;
    procedure SetUseEhlo(const AValue: Boolean); virtual;
    procedure SetPipeline(const AValue: Boolean);
    procedure StartTLS;

    function FailedRecipientCanContinue(const AAddress: string): Boolean;
    //No pipeline send methods
    function WriteRecipientNoPipelining(const AEmailAddress: TIdEmailAddressItem): Boolean;
    procedure WriteRecipientsNoPipelining(AList: TIdEmailAddressList);
    procedure SendNoPipelining(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList);
    //pipeline send methods
    procedure WriteRecipientPipeLine(const AEmailAddress: TIdEmailAddressItem);
    procedure WriteRecipientsPipeLine(AList: TIdEmailAddressList);
    procedure SendPipelining(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList);
    //
    procedure InternalSend(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList); virtual;
  public
    procedure Send(AMsg: TIdMessage); overload; virtual;
    procedure Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList); overload; virtual;
    procedure Send(AMsg: TIdMessage; const AFrom: string); overload; virtual;
    procedure Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList; const AFrom: string); overload; virtual;
  published
    property MailAgent: string read FMailAgent write FMailAgent;
    property HeloName : string read FHeloName write FHeloName;
    property UseEhlo: Boolean read FUseEhlo write SetUseEhlo default IdDEF_UseEhlo;
    property PipeLine : Boolean read FPipeLine write SetPipeline default DEF_SMTP_PIPELINE;
    property UseVerp: Boolean read FUseVerp write FUseVerp default IdDEF_UseVerp;
    property VerpDelims: string read FVerpDelims write FVerpDelims;
    //
    property OnFailedRecipient: TIdSMTPFailedRecipient read FOnFailedRecipient write FOnFailedRecipient;
    property OnFailedEHLO: TIdSMTPFailedEHLO read FOnFailedEHLO write FOnFailedEHLO;
  end;

implementation

uses
  {$IFDEF VCL_XE3_OR_ABOVE}
  System.Classes,
  {$ENDIF}
  IdAssignedNumbers, IdException,
  IdExplicitTLSClientServerBase,
  IdGlobalProtocols, IdIOHandler, IdReplySMTP,
  IdSSL,
  IdStack, SysUtils; //required as we need to get the local computer DNS hostname.

{ TIdSMTPBase }

function TIdSMTPBase.GetReplyClass:TIdReplyClass;
begin
  Result := TIdReplySMTP;
end;

procedure TIdSMTPBase.InitComponent;
begin
  inherited InitComponent;
  FRegularProtPort := IdPORT_SMTP;
  FImplicitTLSProtPort := IdPORT_ssmtp;
  FExplicitTLSProtPort := 587; // TODO: define a constant for this!
  FPipeLine := DEF_SMTP_PIPELINE;
  FUseEhlo := IdDEF_UseEhlo;
  FUseVerp := IdDEF_UseVerp;
  FMailAgent := '';
  FHeloName := '';
  Port := IdPORT_SMTP;
end;

function TIdSMTPBase.GetSupportsTLS: Boolean;
begin
  Result := ( FCapabilities.IndexOf('STARTTLS') > -1 ); //do not localize
end;

procedure TIdSMTPBase.SendGreeting;
var
  LNameToSend : String;
  LContinue: Boolean;
  LError: TIdReply;
begin
  Capabilities.Clear;
  if HeloName <> '' then begin
    LNameToSend := HeloName;
  end else begin
    //Note:  IndyComputerName gets the computer name.
    //This is not always reliable in Indy because in Dot.NET,
    //it is done with System.Windows.Forms.SystemInformation.ComputerName
    //and that requires that we link to a problematic dependancy (System.Windows.Forms).
    //Besides, I think RFC 821 was refering to the computer's Internet
    //DNS name.  We use the Computer name only if we can't get the DNS name.
     LNameToSend := GStack.HostName;
     if LNameToSend = '' then
     begin
       LNameToSend := IndyComputerName;
     end;
  end;
  if UseEhlo then begin //APR: user can prevent EHLO
    if SendCmd('EHLO ' + LNameToSend) = 250 then begin {Do not Localize}
      Capabilities.AddStrings(LastCmdResult.Text);
      if Capabilities.Count > 0 then begin
        //we drop the initial greeting.  We only want the feature list
        Capabilities.Delete(0);
      end;
      Exit;
    end;
    // RLebeau: let the user decide whether to continue with HELO or QUIT...
    LContinue := True;
    if Assigned(FOnFailedEhlo) then begin
      FOnFailedEhlo(Self, LastCmdResult.Code, LastCmdResult.Text.Text, LContinue);
    end;
    if not LContinue then begin
      LError := FReplyClass.Create(nil);
      try
        LError.Assign(LastCmdResult);
        Disconnect(True);
        LError.RaiseReplyError;
      finally
        FreeAndNil(LError);
      end;
      Exit;
    end;
  end;
  SendCmd('HELO ' + LNameToSend, 250);    {Do not Localize}
end;

procedure TIdSMTPBase.SetPipeline(const AValue: Boolean);
begin
  FPipeLine := AValue;
  if AValue then begin
    FUseEhlo := True;
  end;
end;

procedure TIdSMTPBase.SetUseEhlo(const AValue: Boolean);
begin
  FUseEhlo := AValue;
  if not AValue then
  begin
    FPipeLine := False;
  end;
end;

procedure TIdSMTPBase.SendNoPipelining(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList);
var
  LCmd: string;
begin
  LCmd := MAILFROM_CMD + '<' + AFrom + '>';    {Do not Localize}
  if FUseVerp then begin
    if Capabilities.IndexOf(CAPAVERP) > -1 then begin
      LCmd := LCmd + ' VERP';                   {Do not Localize}
    end else begin
      LCmd := LCmd + ' XVERP';                  {Do not Localize}
    end;
    if FVerpDelims <> '' then begin
     LCmd := LCmd + '=' + FVerpDelims;          {Do not Localize}
    end;
  end;

  // RLebeau 4/29/2013: DO NOT send a RSET command before the MAIL FROM command!
  // Some servers are buggy and will reset the entire session, including any
  // previously accepted authentication, when they are supposed to reset only
  // their mail sending buffers and nothing else.  Send a RSET only if the mail
  // transaction fails and needs to be cleaned up...
  // TODO: make this configurable?

  //SendCmd(RSET_CMD);
  SendCmd(LCmd, MAILFROM_ACCEPT);
  try
    WriteRecipientsNoPipelining(ARecipients);
    SendCmd(DATA_CMD, DATA_ACCEPT);
    // TODO: if the server supports the UTF8SMTP extension, force TIdMessage
    // to encode headers as raw 8bit UTF-8, even if the TIdMessage.OnInitializeISO
    // event has a handler assigned...
    SendMsg(AMsg);
    SendCmd('.', DATA_PERIOD_ACCEPT);    {Do not Localize}
  except
    on E: EIdSMTPReplyError do begin
      SendCmd(RSET_CMD);
      raise;
    end;
    on E: Exception do begin
      // the state of the communication is indeterminate at this point, so the
      // only sane thing to do is just close the socket...
      Disconnect(False);
      raise;
    end;
  end;
end;

procedure TIdSMTPBase.SendPipelining(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList);
var
  LError : TIdReply;
  I, LFailedRecips : Integer;
  LCmd: string;
  LBufferingStarted: Boolean;

  function SetupErrorReply: TIdReply;
  begin
    Result := FReplyClass.Create(nil);
    Result.Assign(LastCmdResult);
  end;

begin
  LError := nil;
  LCmd := MAILFROM_CMD + '<' + AFrom + '>';    {Do not Localize}
  if FUseVerp then begin
    if Capabilities.IndexOf(CAPAVERP) > -1 then begin
      LCmd := LCmd + ' VERP';                   {Do not Localize}
    end else begin
      LCmd := LCmd + ' XVERP';                  {Do not Localize}
    end;
    if FVerpDelims <> '' then begin
     LCmd := LCmd + '=' + FVerpDelims;          {Do not Localize}
    end;
  end;
  try
    LBufferingStarted := not IOHandler.WriteBufferingActive;
    if LBufferingStarted then begin
      IOHandler.WriteBufferOpen;
    end;

    // RLebeau 4/29/2013: DO NOT send a RSET command before the MAIL FROM command!
    // Some servers are buggy and will reset the entire session, including any
    // previously accepted authentication, when they are supposed to reset only
    // their mail sending buffers and nothing else.  Send a RSET only if the mail
    // transaction fails and needs to be cleaned up...
    // TODO: make this configurable?

    try
      //IOHandler.WriteLn(RSET_CMD);
      IOHandler.WriteLn(LCmd);
      WriteRecipientsPipeLine(ARecipients);
      IOHandler.WriteLn(DATA_CMD);
      if LBufferingStarted then begin
        IOHandler.WriteBufferClose;
      end;
    except
      if LBufferingStarted then begin
        IOHandler.WriteBufferCancel;
      end;
      raise;
    end;
    {
    //RSET
    if PosInSmallIntArray(GetResponse, RSET_ACCEPT) = -1 then begin
      LError := SetupErrorReply;
    end;
    }
    //MAIL FROM:
    if PosInSmallIntArray(GetResponse, MAILFROM_ACCEPT) = -1 then begin
      if not Assigned(LError) then begin
        LError := SetupErrorReply;
      end;
    end;
    //RCPT TO:
    if ARecipients.Count > 0 then begin
      LFailedRecips := 0;
      for I := 0 to ARecipients.Count - 1 do begin
        if PosInSmallIntArray(GetResponse, RCPTTO_ACCEPT) = -1 then begin
          Inc(LFailedRecips);
          if not FailedRecipientCanContinue(ARecipients[I].Address) then begin
            if not Assigned(LError) then begin
              LError := SetupErrorReply;
            end;
          end;
        end;
      end;
      if not Assigned(LError) and (LFailedRecips = ARecipients.Count) then begin
        LError := SetupErrorReply;
      end;
    end;
    //DATA - last in the batch
    if PosInSmallIntArray(GetResponse, DATA_ACCEPT) <> -1 then begin
      // TODO: if the server supports the UTF8SMTP extension, force TIdMessage
      // to encode headers as raw 8bit UTF-8, even if the TIdMessage.OnInitializeISO
      // event has a handler assigned...
      try
        SendMsg(AMsg);
      except
        // the state of the communication is indeterminate at this point, so the
        // only sane thing to do is just close the socket...
        Disconnect(False);
        raise;
      end;
      if PosInSmallIntArray(SendCmd('.'), DATA_PERIOD_ACCEPT) = -1 then begin {Do not Localize}
        if not Assigned(LError) then begin
          LError := SetupErrorReply;
        end;
      end;
    end else begin
      if not Assigned(LError) then begin
        LError := SetupErrorReply;
      end;
    end;
    if Assigned(LError) then begin
      SendCmd(RSET_CMD);
      LError.RaiseReplyError;
    end;
  finally
    FreeAndNil(LError);
  end;
end;

procedure TIdSMTPBase.StartTLS;
var
  LIO : TIdSSLIOHandlerSocketBase;
  LSendQuitOnError: Boolean;
begin
  LSendQuitOnError := True;
  try
    if (IOHandler is TIdSSLIOHandlerSocketBase) and (FUseTLS <> utNoTLSSupport) then
    begin
      LIO := TIdSSLIOHandlerSocketBase(IOHandler);
      //we check passthrough because we can either be using TLS currently with
      //implicit TLS support or because STARTLS was issued previously.
      if LIO.PassThrough then
      begin
        if SupportsTLS then
        begin
          if SendCmd('STARTTLS') = 220 then begin {do not localize}
            LSendQuitOnError := False;
            TLSHandshake;
            LSendQuitOnError := True;
            //send EHLO
            SendGreeting;
          end else begin
            ProcessTLSNegCmdFailed;
          end;
        end else begin
          ProcessTLSNotAvail;
        end;
      end;
    end;
  except
    Disconnect(LSendQuitOnError); // RLebeau: do not send the QUIT command during the TLS handshake
    Raise;
  end;
end;

function TIdSMTPBase.FailedRecipientCanContinue(const AAddress: string): Boolean;
begin
  Result := Assigned(FOnFailedRecipient);
  if Result then begin
    FOnFailedRecipient(Self, AAddress, LastCmdResult.Code, LastCmdResult.Text.Text, Result);
  end;
end;

function TIdSMTPBase.WriteRecipientNoPipelining(const AEmailAddress: TIdEmailAddressItem): Boolean;
var
  LReply: Int16;
begin
  LReply := SendCmd(RCPTTO_CMD + '<' + AEMailAddress.Address + '>'); {do not localize}
  Result := PosInSmallIntArray(LReply, RCPTTO_ACCEPT) <> -1;
end;

procedure TIdSMTPBase.WriteRecipientPipeLine(const AEmailAddress: TIdEmailAddressItem);
begin
  //we'll read the reply - LATER
  IOHandler.WriteLn(RCPTTO_CMD + '<' + AEMailAddress.Address + '>');
end;

procedure TIdSMTPBase.WriteRecipientsNoPipelining(AList: TIdEmailAddressList);
var
  I, LFailedRecips: Integer;
  LContinue: Boolean;
begin
  if AList.Count > 0 then begin
    LFailedRecips := 0;
    LContinue := True;
    for I := 0 to AList.Count - 1 do begin
      if not WriteRecipientNoPipelining(AList[I]) then begin
        Inc(LFailedRecips);
        if not FailedRecipientCanContinue(AList[I].Address) then begin
          LContinue := False;
          Break;
        end;
      end;
    end;
    if (not LContinue) or (LFailedRecips = AList.Count) then begin
      LastCmdResult.RaiseReplyError;
    end;
  end;
end;

procedure TIdSMTPBase.WriteRecipientsPipeLine(AList: TIdEmailAddressList);
var
  I: integer;
begin
  for I := 0 to AList.Count - 1 do begin
    WriteRecipientPipeLine(AList[I]);
  end;
end;

procedure TIdSMTPBase.InternalSend(AMsg: TIdMessage; const AFrom: String; ARecipients: TIdEMailAddressList);
begin
  if Pipeline and (Capabilities.IndexOf(CAPAPIPELINE) > -1) then begin
    SendPipelining(AMsg, AFrom, ARecipients);
  end else begin
    SendNoPipelining(AMsg, AFrom, ARecipients);
  end;
end;

// this version of Send() uses the TIdMessage to determine both the
// sender and the recipients...
procedure TIdSMTPBase.Send(AMsg: TIdMessage);
var
  LRecipients: TIdEMailAddressList;
begin
  LRecipients := TIdEMailAddressList.Create(Self);
  try
    LRecipients.AddItems(AMsg.Recipients);
    LRecipients.AddItems(AMsg.CCList);
    LRecipients.AddItems(AMsg.BccList);
    Send(AMsg, LRecipients);
  finally
    FreeAndNil(LRecipients);
  end;
end;

// this version of Send() uses the TIdMessage to determine the
// sender, but sends to the caller's specified recipients
procedure TIdSMTPBase.Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList);
var
  LSender: string;
begin
  LSender := Trim(AMsg.Sender.Address);
  if LSender = '' then begin
    LSender := Trim(AMsg.From.Address);
  end;
  InternalSend(AMsg, LSender, ARecipients);
end;

// this version of Send() uses the TIdMessage to determine the
// recipients, but sends using the caller's specified sender.
// The sender can be empty, which is useful for server-generated
// error messages...
procedure TIdSMTPBase.Send(AMsg: TIdMessage; const AFrom: string);
var
  LRecipients: TIdEMailAddressList;
begin
  LRecipients := TIdEMailAddressList.Create(Self);
  try
    LRecipients.AddItems(AMsg.Recipients);
    LRecipients.AddItems(AMsg.CCList);
    LRecipients.AddItems(AMsg.BccList);
    Send(AMsg, LRecipients, AFrom);
  finally
    FreeAndNil(LRecipients);
  end;
end;

// this version of Send() uses the caller's specified sender and
// recipients.  The sender can be empty, which is useful for
// server-generated error messages...
procedure TIdSMTPBase.Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList;
  const AFrom: string);
begin
  InternalSend(AMsg, AFrom, ARecipients);
end;

end.
