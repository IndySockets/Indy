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
{   Rev 1.19    10/01/2005 16:31:20  ANeillans
{ Minor bug fix for Exim compatibility.
}
{
{   Rev 1.18    11/27/04 3:03:22 AM  RLebeau
{ Bug fix for 'STARTTLS' response handling
}
{
    Rev 1.17    6/11/2004 9:38:44 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.16    2004.02.03 5:45:46 PM  czhower
{ Name changes
}
{
{   Rev 1.15    2004.02.03 2:12:18 PM  czhower
{ $I path change
}
{
{   Rev 1.14    1/28/2004 8:08:10 PM  JPMugaas
{ Fixed a bug in SendGreeting.  It was sending an invalid EHLO and probably an
{ invalid HELO command.  The problem is that it was getting the computer name.
{ There's an issue in NET with that which  Kudzu commented on in IdGlobal.
{ Thus, "EHLO<space>" and probably "HELO<space>" were being sent causing a
{ failure.  The fix is to to try to get the local computer's DNS name with
{ GStack.HostName.  We only use the computer name if GStack.HostName fails.
}
{
{   Rev 1.13    1/25/2004 3:11:48 PM  JPMugaas
{ SASL Interface reworked to make it easier for developers to use.
{ SSL and SASL reenabled components.
}
{
{   Rev 1.12    2004.01.22 10:29:58 PM  czhower
{ Now supports default login mechanism with just username and pw.
}
{
{   Rev 1.11    1/21/2004 4:03:24 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.10    22/12/2003 00:46:36  CCostelloe
{ .NET fixes
}
{
{   Rev 1.9    4/12/2003 10:24:08 PM  GGrieve
{ Fix to Compile
}
{
{   Rev 1.8    25/11/2003 12:24:22 PM  SGrobety
{ various IdStream fixes with ReadLn/D6
}
{
    Rev 1.7    10/17/2003 1:02:56 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.6    2003.10.14 1:31:16 PM  czhower
{ DotNet
}
{
{   Rev 1.5    2003.10.12 6:36:42 PM  czhower
{ Now compiles.
}
{
{   Rev 1.4    10/11/2003 7:14:36 PM  BGooijen
{ Changed IdCompilerDefines.inc path
}
{
{   Rev 1.3    10/10/2003 10:45:12 PM  BGooijen
{ DotNet
}
{
{   Rev 1.2    2003.10.02 9:27:54 PM  czhower
{ DotNet Excludes
}
{
{   Rev 1.1    6/15/2003 03:28:24 PM  JPMugaas
{ Minor class change.
}
{
{   Rev 1.0    6/15/2003 01:06:48 PM  JPMugaas
{ TIdSMTP and TIdDirectSMTP now share common code in this base class.
}
unit IdSMTPBase;

{$I IdCompilerDefines.inc}

interface

uses
  IdEMailAddress,
  IdMessage,
  IdMessageClient,
  IdReply,
  IdSys,
  IdTCPClient;

//default property values
const
  DEF_SMTP_PIPELINE = True;
  IdDEF_UseEhlo = TRUE; //APR: default behavior

const
  CAPAPIPELINE = 'PIPELINING';  {do not localize}
  XMAILER_HEADER = 'X-Mailer';  {do not localize}

const
  RCPTTO_ACCEPT : array [0..1] of SmallInt = (250, 251);
  MAILFROM_ACCEPT : SmallInt = 250;
  DATA_ACCEPT : SmallInt = 354;
  DATA_PERIOD_ACCEPT : SmallInt = 250;

const
  RSET_CMD = 'RSET';            {do not localize}
  MAILFROM_CMD = 'MAIL FROM:';  {do not localize}
  RCPTTO_CMD = 'RCPT TO:';      {do not localize}
  DATA_CMD = 'DATA';            {do not localize}

type
  TIdSMTPBase = class(TIdMessageClient)
  protected
    FMailAgent: string;
    FHeloName : String;
    FPipeline : Boolean;
    FUseEHLO : Boolean;
    //
    function GetSupportsTLS : Boolean; override;
    function GetReplyClass:TIdReplyClass; override;
    procedure InitComponent; override;
    procedure SendGreeting;
    procedure SetUseEhlo(const AValue: Boolean); virtual;
    procedure SetPipeline(const AValue: Boolean);
    procedure StartTLS;

    //No pipeline send methods
    procedure WriteRecipientNoPipelining(const AEmailAddress: TIdEmailAddressItem);
    procedure WriteRecipientsNoPipelining(AList: TIdEmailAddressList);
    procedure SendNoPipelining(AMsg: TIdMessage; ARecipients : TIdEMailAddressList); overload;
    //pipeline send methods
    procedure WriteRecipientPipeLine(const AEmailAddress: TIdEmailAddressItem);
    procedure WriteRecipientsPipeLine(AList: TIdEmailAddressList);
    procedure SendPipelining(AMsg: TIdMessage; ARecipients : TIdEMailAddressList);
    procedure InternalSend(AMsg: TIdMessage; ARecipients : TIdEMailAddressList); overload;
  public
    procedure Send(AMsg: TIdMessage); virtual; abstract;
  published
    property MailAgent: string read FMailAgent write FMailAgent;
    property HeloName : string read FHeloName write FHeloName;
    property UseEhlo: Boolean read FUseEhlo write SetUseEhlo default IdDEF_UseEhlo;
    property PipeLine : Boolean read FPipeLine write SetPipeline default DEF_SMTP_PIPELINE;
  end;

implementation

uses
  IdAssignedNumbers, IdException, IdGlobal,
  IdExplicitTLSClientServerBase,
  IdGlobalProtocols, IdIOHandler, IdReplySMTP,
  IdSSL,
  IdStack; //required as we need to get the local computer DNS hostname.

{ TIdSMTPBase }

function TIdSMTPBase.GetReplyClass:TIdReplyClass;
begin
  result:=TIdReplySMTP;
end;

procedure TIdSMTPBase.InitComponent;
begin
  inherited;
  FImplicitTLSProtPort := IdPORT_ssmtp;
  FRegularProtPort := IdPORT_SMTP;
  FPipeLine := DEF_SMTP_PIPELINE;
  FUseEhlo:=IdDEF_UseEhlo;
  Port := IdPORT_SMTP;
end;

function TIdSMTPBase.GetSupportsTLS: Boolean;
begin
  Result := ( FCapabilities.IndexOf('STARTTLS')>-1); //do not localize
end;

procedure TIdSMTPBase.SendGreeting;
var LNameToSend : String;
begin
  Capabilities.Clear;
  if HeloName <> '' then begin
    LNameToSend := HeloName;
  end else begin
    //Note:  IndyComputerName gets the computer name.
    //This is not always reliable in Indy because in Dot.NET,
    //it is done with This is available through System.Windows.Forms.SystemInformation.ComputerName
    //and that requires that we link to a problematic dependancy (Wystem.Windows.Forms).
    //Besides, I think RFC 821 was refering to the computer's Internet
    //DNS name.  We use the Computer name only if we can't get the DNS name.
     LNameToSend := GStack.HostName;
     if LNameToSend = '' then
     begin
       LNameToSend := IndyComputerName;
     end;
  end;
  if UseEhlo and (SendCmd('EHLO ' + LNameToSend ) = 250) then begin //APR: user can prevent EHLO    {Do not Localize}
    Capabilities.AddStrings(LastCmdResult.Text);
    if Capabilities.Count > 0 then begin
      //we drop the initial greeting.  We only want the feature list
      Capabilities.Delete(0);
    end;
  end else begin
    SendCmd('HELO ' + LNameToSend, 250);    {Do not Localize}
  end;
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
  if NOT AValue then
  begin
    FPipeLine := False;
  end;
end;

procedure TIdSMTPBase.SendNoPipelining(AMsg: TIdMessage;
  ARecipients: TIdEMailAddressList);
begin
  SendCmd(RSET_CMD);    {Do not Localize}
  SendCmd(MAILFROM_CMD+' <'+AMsg.From.Address + '>', MAILFROM_ACCEPT);    {Do not Localize}
  WriteRecipientsNoPipelining(ARecipients);

  SendCmd(DATA_CMD, DATA_ACCEPT);    {Do not Localize}
  SendMsg(AMsg);
  SendCmd('.', DATA_PERIOD_ACCEPT);    {Do not Localize}
end;

procedure TIdSMTPBase.SendPipelining(AMsg: TIdMessage;
  ARecipients: TIdEMailAddressList);
var
  LError : TIdReplySMTP;
  i : Integer;

  function SetupErrorReply(AClient : TIdMessageCLient) : TIdReplySMTP;
  begin
    Result := TIdReplySMTP.Create(nil);
    Result.Text.Text := AClient.LastCmdResult.Text.Text;
    Result.NumericCode := AClient.LastCmdResult.NumericCode;
    Result.EnhancedCode.ReplyAsStr := (AClient.LastCmdResult as TIdReplySMTP).EnhancedCode.ReplyAsStr;
  end;

begin
  LError := nil;
  try
    IOHandler.WriteBufferOpen;
    try
      IOHandler.WriteLn(RSET_CMD);
      IOHandler.WriteLn(MAILFROM_CMD+' <'+AMsg.From.Address + '>');
      WriteRecipientsPipeLine(ARecipients);
      IOHandler.WriteLn(DATA_CMD);
    finally
      IOHandler.WriteBufferClose;
    end;
    //RSET
    GetResponse([]);
    //MAIL FROM:
    if PosInSmallIntArray(GetResponse([]),MAILFROM_ACCEPT)=-1 then
    begin
      LError := SetupErrorReply(Self);
    end;
    //RCPT TO:
    for i := 1 to ARecipients.Count do
    begin
      if PosInSmallIntArray(GetResponse([]),RCPTTO_ACCEPT)=-1 then
      begin
        if Assigned(LError)=False then
        begin
          LError := SetupErrorReply(Self);
        end;
      end;
    end;
    //DATA - last in the batch
    if PosInSmallIntArray(GetResponse([]),DATA_ACCEPT)=-1 then
    begin
      if Assigned(LError)=False then
      begin
        LError := SetupErrorReply(Self);
      end;
      LError.RaiseReplyError;
    end;
    if Assigned(LError) then
    begin
      //cancel the message send - there was an error in the replies
      SendCmd('.');
      //raise the exception from the first error code
      LError.RaiseReplyError;
    end
    else
    begin
      SendMsg(AMsg);
      SendCmd('.', DATA_PERIOD_ACCEPT);    {Do not Localize}
    end;
  finally
    Sys.FreeAndNil(LError);
  end;
end;

procedure TIdSMTPBase.StartTLS;
var
  LIO : TIdSSLIOHandlerSocketBase;
begin
  try
    if (IOHandler is TIdSSLIOHandlerSocketBase) and (FUseTLS<>utNoTLSSupport) then
    begin
      LIO := TIdSSLIOHandlerSocketBase(IOHandler);
      //we check passthrough because we can either be using TLS currently with
      //implicit TLS support or because STARTLS was issued previously.
      if LIO.PassThrough then
      begin
        if SupportsTLS then
        begin
          if SendCmd('STARTTLS') = 220 then begin {do not localize}
            TLSHandshake;
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
    Disconnect;
    Raise;
  end;
end;

procedure TIdSMTPBase.WriteRecipientNoPipelining(
  const AEmailAddress: TIdEmailAddressItem);
var
  sTemp: string;
begin
  sTemp := AEMailAddress.Address;
  sTemp := 'RCPT TO:'+'<'+sTemp+ '>'; {do not localize}
  //SendCmd(RCPTTO_CMD+'<' + AEMailAddress.Address + '>', RCPTTO_ACCEPT);    {Do not Localize}
  SendCmd(sTemp, RCPTTO_ACCEPT); {do not localize}
end;

procedure TIdSMTPBase.WriteRecipientPipeLine(
  const AEmailAddress: TIdEmailAddressItem);
begin
  //we'll read the reply - LATER
  IOHandler.WriteLn(RCPTTO_CMD+'<' + AEMailAddress.Address + '>');
end;

procedure TIdSMTPBase.WriteRecipientsNoPipelining(
  AList: TIdEmailAddressList);
var
  i: integer;
  LEmailAddress: TIdEmailAddressItem;
begin
  for i := 0 to AList.Count - 1 do begin
    //WriteRecipientNoPipelining(AList[i]);
    LEmailAddress := AList.Items[i];
    WriteRecipientNoPipelining(LEmailAddress);
  end;
end;

procedure TIdSMTPBase.WriteRecipientsPipeLine(AList: TIdEmailAddressList);
var
    i: integer;
begin
  for i := 0 to AList.Count - 1 do begin
    WriteRecipientPipeLine(AList[i]);
  end;
end;

procedure TIdSMTPBase.InternalSend(AMsg: TIdMessage;
  ARecipients: TIdEMailAddressList);
begin
  if Pipeline and (Capabilities.IndexOf(CAPAPIPELINE)>-1) then
  begin
    SendPipelining(AMsg,ARecipients);
  end
  else
  begin
    SendNoPipelining(AMsg,ARecipients);
  end;
end;

end.
