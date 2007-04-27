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
  Rev 1.47    1/7/05 3:29:34 PM  RLebeau
  Fix for AV in Notification()

  Rev 1.46    11/28/04 2:31:38 PM  RLebeau
  Updated Authenticate() to create the TIdEncoderMIME instance before sending
  the 'AUTH LOGIN' command.

  Rev 1.45    11/27/2004 8:58:14 PM  JPMugaas
  Compile errors.

  Rev 1.44    11/27/04 3:21:30 AM  RLebeau
  Fixed bug in ownership of SASLMechanisms property.
  Recoded Authenticate() to use a "case of" statement instead.

  Rev 1.43    10/26/2004 10:55:34 PM  JPMugaas
  Updated refs.

  Rev 1.42    6/11/2004 9:38:40 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.41    2004.03.06 1:31:52 PM  czhower
  To match Disconnect changes to core.

  Rev 1.40    2/25/2004 5:41:28 AM  JPMugaas
  Authentication bug fixed.

  Rev 1.39    2004.02.03 5:44:20 PM  czhower
  Name changes

  Rev 1.38    1/31/2004 3:12:56 AM  JPMugaas
  Removed dependancy on Math unit.  It isn't needed and is problematic in some
  versions of Dlephi which don't include it.

  Rev 1.37    26/01/2004 01:51:38  CCostelloe
  Changed implementation of supressing BCC List generation

  Rev 1.36    25/01/2004 21:16:16  CCostelloe
  Added support for SuppressBCCListInHeader

  Rev 1.35    1/25/2004 3:11:44 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.34    2004.01.22 10:29:56 PM  czhower
  Now supports default login mechanism with just username and pw.

  Rev 1.33    1/21/2004 4:03:22 PM  JPMugaas
  InitComponent

  Rev 1.32    12/28/2003 4:47:02 PM  BGooijen
  Removed ChangeReplyClass

  Rev 1.31    22/12/2003 00:46:16  CCostelloe
  .NET fixes

  Rev 1.30    24/10/2003 20:53:02  CCostelloe
  Bug fix of LRecipients.EMailAddresses in Send.

  Rev 1.29    2003.10.17 6:15:16 PM  czhower
  Bug fix with quit.

  Rev 1.28    10/17/2003 1:01:04 AM  DSiders
  Added localization comments.

  Rev 1.27    2003.10.14 1:28:04 PM  czhower
  DotNet

  Rev 1.26    10/11/2003 7:14:36 PM  BGooijen
  Changed IdCompilerDefines.inc path

  Rev 1.25    10/10/2003 10:45:10 PM  BGooijen
  DotNet

  Rev 1.24    2003.10.02 9:27:52 PM  czhower
  DotNet Excludes

  Rev 1.23    6/15/2003 03:28:30 PM  JPMugaas
  Minor class change.

  Rev 1.22    6/15/2003 01:13:40 PM  JPMugaas
  Now uses new base class.

  Rev 1.21    6/5/2003 04:54:08 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.20    6/4/2003 04:10:40 PM  JPMugaas
  Removed hacked GetInternelResponse.

  Updated to use Kudzu's new string reply code.

  Rev 1.19    5/26/2003 12:24:04 PM  JPMugaas

  Rev 1.18    5/25/2003 03:54:48 AM  JPMugaas

  Rev 1.17    5/25/2003 12:13:22 AM  JPMugaas
  SMTP StartTLS code moved into IdSMTPCommon for sharing with TIdDirectSMTP.
  StartTLS is now called in Authenticate to prevent unintentional unencrypted
  password transmission (e.g. AUTH LOGIN being called before STARTTLS).

  Rev 1.16    5/23/2003 04:52:26 AM  JPMugaas
  Work started on TIdDirectSMTP to support enhanced error codes.

  Rev 1.15    5/22/2003 05:26:16 PM  JPMugaas
  RFC 2034

  Rev 1.14    5/18/2003 02:31:42 PM  JPMugaas
  Reworked some things so IdSMTP and IdDirectSMTP can share code including
  stuff for pipelining.

  Rev 1.13    5/15/2003 11:09:46 AM  JPMugaas
  "RFC 2197 SMTP  Service Extension for Command Pipelining" now supported.  It
  should increase efficiency in TIdSMTP.

  Rev 1.12    5/13/2003 07:35:06 AM  JPMugaas
  Made UseEHLO a requirement for explicit TLS because explicit TLS using EHLO
  to determine if the server supports explicit TLS. Setting UseEHLO will the
  UseTLS property be the default (no encryption) and setting UseTLS to an
  explicit TLS setting will cause the UseEHLO property to be true.

  Rev 1.11    5/13/2003 07:03:48 AM  JPMugaas
  Ciaran Costelloe reported a bug in the Assign method.  Username and Password
  were still being assigned even though the SMTP component does not publish or
  use them.  I have updated the SMTP assign method with the new properties and
  removed the references to Password and Username.

  Rev 1.10    5/10/2003 10:10:40 PM  JPMugaas
  Bug fixes.

  Rev 1.9    5/8/2003 08:44:22 PM  JPMugaas
  Moved some SASL authentication code down to an anscestor for reuse.  WIll
  clean up soon.

  Rev 1.8    5/8/2003 03:18:30 PM  JPMugaas
  Flattened ou the SASL authentication API, made a custom descendant of SASL
  enabled TIdMessageClient classes.

  Rev 1.7    5/8/2003 11:28:14 AM  JPMugaas
  Moved feature negoation properties down to the ExplicitTLSClient level as
  feature negotiation goes hand in hand with explicit TLS support.

  Rev 1.6    5/8/2003 02:18:18 AM  JPMugaas
  Fixed an AV in IdPOP3 with SASL list on forms.  Made exceptions for SASL
  mechanisms missing more consistant, made IdPOP3 support feature feature
  negotiation, and consolidated some duplicate code.

  Rev 1.5    4/5/2003 02:06:32 PM  JPMugaas
  TLS handshake itself can now be handled.

  Rev 1.4    3/27/2003 05:46:50 AM  JPMugaas
  Updated framework with an event if the TLS negotiation command fails.
  Cleaned up some duplicate code in the clients.

  Rev 1.3    3/26/2003 04:19:34 PM  JPMugaas
  Cleaned-up some code and illiminated some duplicate things.

  Rev 1.2    3/13/2003 09:49:32 AM  JPMugaas
  Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
  can plug-in their products.

  Rev 1.1    12/15/2002 05:50:18 PM  JPMugaas
  SMTP and IMAP4 compile.  IdPOP3, IdFTP, IMAP4, and IdSMTP now restored in
  IdRegister.

  Rev 1.0    11/13/2002 08:00:48 AM  JPMugaas
}

unit IdSMTP;

interface

uses
  IdAssignedNumbers,
  IdEMailAddress,
  IdException,
  IdExplicitTLSClientServerBase,
  IdHeaderList,
  IdMessage,
  IdMessageClient,
  IdSASL,
  IdSASLCollection,
  IdSMTPBase,
  IdSys,
  IdBaseComponent,
  IdGlobal,
  IdObjs;

type
  TIdSMTPAuthenticationType = (atNone, atDefault, atSASL);

const
  DEF_SMTP_AUTH = atDefault;

type
//FSASLMechanisms
  TIdSMTP = class(TIdSMTPBase)
  protected
    FAuthType: TIdSMTPAuthenticationType;
    // This is just an internal flag we use to determine if we already authenticated to the server.
    FDidAuthenticate: Boolean;
    // FSASLMechanisms : TIdSASLList;
    FSASLMechanisms : TIdSASLEntries;
    //
    procedure SetAuthType(const Value: TIdSMTPAuthenticationType);
    procedure SetUseEhlo(const Value: Boolean); override;
    procedure SetUseTLS(AValue: TIdUseTLS); override;
    procedure SetSASLMechanisms(AValue: TIdSASLEntries);
    procedure InitComponent; override;
    procedure Notification(AComponent: TIdNativeComponent; Operation: TIdOperation); override;

    //
    // holger: .NET compatibility change, OnConnected being reintroduced
    property OnConnected;
  public
    destructor Destroy; override;
    procedure Assign(Source: TIdPersistent); override;
    function Authenticate: Boolean; virtual;
    procedure Connect; override;
    procedure Disconnect(ANotifyPeer: Boolean); override;
    procedure DisconnectNotifyPeer; override;
    class procedure QuickSend(const AHost, ASubject, ATo, AFrom, AText: string);
    procedure Send(AMsg: TIdMessage); override;
    procedure Expand(AUserName : String; AResults : TIdStrings); virtual;
    function Verify(AUserName : String) : String; virtual;
    //
    property DidAuthenticate: Boolean read FDidAuthenticate;
  published
    property AuthType: TIdSMTPAuthenticationType read FAuthType write FAuthType
     default DEF_SMTP_AUTH;
    property Host;
    property Password;
    property Port default IdPORT_SMTP;
   // property SASLMechanisms: TIdSASLList read FSASLMechanisms write FSASLMechanisms;
    property SASLMechanisms : TIdSASLEntries read FSASLMechanisms write SetSASLMechanisms;
    property UseTLS;
    property Username;
    //
    property OnTLSNotAvailable;
  end;

implementation

uses
  IdCoderMIME,
  IdGlobalProtocols,
  IdReplySMTP,
  IdSSL,
  IdResourceStringsProtocols,
  IdTCPConnection;

{ TIdSMTP }

procedure TIdSMTP.Assign(Source: TIdPersistent);
var
  LS: TIdSMTP;
begin
  if Source is TIdSMTP then begin
    LS := Source as TIdSMTP;
    AuthType := LS.AuthType;
    HeloName := LS.HeloName;
    SASLMechanisms := LS.SASLMechanisms;
    UseEhlo := LS.UseEhlo;
    UseTLS := LS.UseTLS;
    Host := LS.Host;
    MailAgent := LS.MailAgent;
    Port := LS.Port;
    Username := LS.Username;
    Password := LS.Password;
    Pipeline := LS.Pipeline;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdSMTP.Authenticate : Boolean;
var
  s : TIdStrings;
begin
  if FDidAuthenticate then
  begin
    Result := True;
    Exit;
  end;

  //This will look strange but we have logic in that method to make
  //sure that the STARTTLS command is used appropriately.
  //Note we put this in Authenticate only to ensure that TLS negotiation
  //is done before a password is sent over a network unencrypted.
  StartTLS;

  //note that we pass the reply numbers as strings so the SASL stuff can work
  //with IMAP4 and POP3 where non-numeric strings are used for reply codes
  case FAuthType of
    atNone:
      begin
        //do nothing
        FDidAuthenticate := True;
      end;
    atDefault:
      begin
        if Username <> '' then begin
          s := SASLMechanisms.ParseCapaReply(Capabilities);
          try
            //many servers today do not use username/password authentication
            if s.IndexOf('LOGIN') > -1 then begin
              with TIdEncoderMIME.Create(nil) do try
                SendCmd('AUTH LOGIN', 334);
                SendCmd(Encode(Username), 334);
                SendCmd(Encode(Password), 235);
              finally
                Free;
              end;
              FDidAuthenticate := True;
            end;
          finally
            Sys.FreeAndNil(s);
          end;
        end;
{
        RLebeau: TODO - implement the following code in the future
        instead of the code above.  This way, TIdSASLLogin can be utilized.

        EIdSASLMechNeeded.IfTrue(SASLMechanisms.Count = 0, RSASLRequired);
        FDidAuthenticate := SASLMechanisms.LoginSASL('AUTH', 'LOGIN', ['235'], ['334'], Self, Capabilities);
}
      end;
    atSASL:
      begin
        EIdSASLMechNeeded.IfTrue(SASLMechanisms.Count = 0, RSASLRequired);
        FDidAuthenticate := SASLMechanisms.LoginSASL('AUTH', ['235'], ['334'], Self, Capabilities); {do not localize}
      end;
  end;
  Result := FDidAuthenticate;
end;

procedure TIdSMTP.Connect;
begin
  FDidAuthenticate := False;
  inherited Connect;
  try
    GetResponse(220);
    SendGreeting;
  except
    Disconnect(False);
    raise;
  end;
end;

procedure TIdSMTP.InitComponent;
begin
  inherited InitComponent;
  FSASLMechanisms := TIdSASLEntries.Create(Self);
  FAuthType := DEF_SMTP_AUTH;
end;

procedure TIdSMTP.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', 221);    {Do not Localize}
end;

procedure TIdSMTP.Expand(AUserName: String; AResults: TIdStrings);
begin
  SendCMD('EXPN ' + AUserName, [250, 251]);    {Do not Localize}
end;

class procedure TIdSMTP.QuickSend(const AHost, ASubject, ATo, AFrom, AText : String);
var
  LSMTP: TIdSMTP;
  LMsg: TIdMessage;
begin
  LSMTP := TIdSMTP.Create(nil); try
    LMsg := TIdMessage.Create(LSMTP); try
      with LMsg do begin
        Subject := ASubject;
        Recipients.EMailAddresses := ATo;
        From.Text := AFrom;
        Body.Text := AText;
      end;
      with LSMTP do begin
        Host := AHost;
        Connect; try;
          Send(LMsg);
        finally Disconnect; end;
      end;
    finally Sys.FreeAndNil(LMsg); end;
  finally Sys.FreeAndNil(LSMTP); end;
end;

procedure TIdSMTP.Send(AMsg: TIdMessage);
var
  LRecipients : TIdEMailAddressList;
begin
  //Authenticate now calls StartTLS
  //so that you do not send login information before TLS negotiation (big oops security wise).
  //It also should see if authentication should be done according to your settings.
  Authenticate;

  AMsg.ExtraHeaders.Values[XMAILER_HEADER] := MailAgent;
  //LRecipients := TIdEMailAddressList.Create(nil);
  LRecipients := TIdEMailAddressList.Create(Self);
  try
    LRecipients.AddItems(AMsg.Recipients);
    LRecipients.AddItems(AMsg.CCList);
    LRecipients.AddItems(AMsg.BccList);
    InternalSend(AMsg, AMsg.From.Address, LRecipients);
  finally
    Sys.FreeAndNil(LRecipients);
  end;
end;

procedure TIdSMTP.SetAuthType(const Value: TIdSMTPAuthenticationType);
Begin
  FAuthType := Value;
  if Value = atSASL then begin
    FUseEhlo := True;
  end;
end;

procedure TIdSMTP.SetUseEhlo(const Value: Boolean);
Begin
  FUseEhlo := Value;
  if not Value then
  begin
    FAuthType := atDefault;
    if FUseTLS in ExplicitTLSVals then
    begin
      FUseTLS := DEF_USETLS;
      FPipeLine := False;
    end;
  end;
End;

function TIdSMTP.Verify(AUserName: string): string;
begin
  SendCMD('VRFY ' + AUserName, [250, 251]);    {Do not Localize}
  Result := LastCmdResult.Text[0];
end;

procedure TIdSMTP.Notification(AComponent: TIdNativeComponent;
  Operation: TIdOperation);
begin
  if (Operation = opRemove) and (FSASLMechanisms <> nil) then begin
    FSASLMechanisms.RemoveByComp(AComponent);
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TIdSMTP.SetUseTLS(AValue: TIdUseTLS);
begin
  inherited SetUseTLS(AValue);
  if FUseTLS in ExplicitTLSVals then begin
    UseEhlo := True;
  end;
end;

procedure TIdSMTP.SetSASLMechanisms(AValue: TIdSASLEntries);
begin
  FSASLMechanisms.Assign(AValue);
end;

destructor TIdSMTP.Destroy;
begin
  Sys.FreeAndNil(FSASLMechanisms);
  inherited Destroy;
end;

procedure TIdSMTP.Disconnect(ANotifyPeer: Boolean);
begin
  try
    inherited Disconnect(ANotifyPeer);
  finally
    FDidAuthenticate := False;
  end;
end;

end.


