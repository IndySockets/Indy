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
  Rev 1.9    1/4/2005 5:27:20 PM  JPMugaas
  Removed Windows unit from uses clause.

  Rev 1.8    04/01/2005 15:34:18  ANeillans
  Renamed InternalSend to RelayInternalSend, as it was conflicting with
  InternalSend in IdSMTPBase, and no e-mails were ever being sent.
  Some formatting and spelling corrections

  Rev 1.7    10/26/2004 10:55:34 PM  JPMugaas
  Updated refs.

  Rev 1.6    2004.03.06 1:31:52 PM  czhower
  To match Disconnect changes to core.

  Rev 1.5    2004.02.07 4:57:20 PM  czhower
  Fixed warning.

  Rev 1.4    2004.02.03 5:45:48 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 4:03:26 PM  JPMugaas
  InitComponent

  Rev 1.2    11/4/2003 10:22:56 PM  DSiders
  Use IdException for exceptions moved to the unit.

  Rev 1.1    2003.10.18 9:42:14 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.0    6/15/2003 03:27:18 PM  JPMugaas
  Renamed IdDirect SMTP to IdSMTPRelay.

  Rev 1.15    6/15/2003 01:09:30 PM  JPMugaas
  Now uses new base class in TIdSMTPBase.  I removed the old original
  unoptimized code that made a connection for each recipient for better
  maintenance and because I doubt anyone would use that anyway.

  Rev 1.14    6/5/2003 04:54:16 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.13    5/26/2003 12:21:50 PM  JPMugaas

  Rev 1.12    5/25/2003 03:54:12 AM  JPMugaas

  Rev 1.11    5/25/2003 01:41:08 AM  JPMugaas
  Sended changed to Sent.  TryImplicitTLS now will only be true if
  UseSSL<>NoSSL.  UseEHLO=False will now disable TLS usage and TLS usage being
  set causes UseEHLO to be true.  StatusItem collection Items now have default
  values for Sent and ReplyCode.

  Rev 1.10    5/25/2003 12:40:34 AM  JPMugaas
  Published events from TIdExplicitTLSClient to be consistant with other
  components in Indy and for any custom handling of certain TLS negotiatiation
  problems.

  Rev 1.9    5/25/2003 12:17:16 AM  JPMugaas
  Now can support SSL (either requiring SSL or using it if available).  This is
  in addition, it can optionally support ImplicitTLS (note that I do not
  recommend this because that is depreciated -and the port for it was
  deallocated and this does incur a performance penalty with an additional
  connect attempt - and possibly a timeout in some firewall situations).

  Rev 1.8    5/23/2003 7:48:12 PM  BGooijen
  TIdSMTPRelayStatusItem.FEnhancedCode object was not created

  Rev 1.7    5/23/2003 05:02:42 AM  JPMugaas

  Rev 1.6    5/23/2003 04:52:22 AM  JPMugaas
  Work started on TIdSMTPRelay to support enhanced error codes.

  Rev 1.5    5/18/2003 02:31:50 PM  JPMugaas
  Reworked some things so IdSMTP and IdDirectSMTP can share code including
  stuff for pipelining.

  Rev 1.4    4/28/2003 03:36:22 PM  JPMugaas
  Revered back to the version I checked in earlier because of my API changes to
  the DNS classes.

  Rev 1.2    4/28/2003 07:00:02 AM  JPMugaas
  Should now compile.

  Rev 1.1    12/6/2002 02:35:22 PM  JPMugaas
  Now compiles with Indy 10.

  Rev 1.0    11/14/2002 02:17:28 PM  JPMugaas
}

unit IdSMTPRelay;

{
  Original Author: Maximiliano Di Rienzo
    dirienzo@infovia.com.ar
    Variation of the TIdSMTP that connects directly with the recipient's SMTP server
    and delivers the message, it doesn't use a relay SMTP server to deliver the message.

    Hides the procs Connect and Disconnect (protected now) because these are called
    internally to connect to the dynamically resolved host based on the MX server of the
    recipient's domain. The procs related to the auth schema have been removed because
    they aren't needed.

    Introduces the property
      property StatusList:TIdSMTPRelayStatusList;
    it's a collection containing the status of each recipient's address after the Send
    method is called

    and the event
      property OnDirectSMTPStatus:TIdSMTPRelayStatus;
    to keep track of the status as the sending is in progress.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdException, IdExceptionCore,
  IdEMailAddress, IdGlobal, IdHeaderList,
  IdDNSResolver, IdMessage, IdMessageClient, IdBaseComponent,
  IdSMTPBase, IdReplySMTP, SysUtils;

const
  DEF_OneConnectionPerDomain = True;

type
  TIdSMTPRelayStatusAction = (dmResolveMS, dmConnecting, dmConnected, dmSending, dmWorkBegin, dmWorkEndOK, dmWorkEndWithException);
  TIdSMTPRelayStatus = procedure(Sender: TObject; AEMailAddress: TIdEmailAddressItem; Action: TIdSMTPRelayStatusAction) of Object;

  EIdDirectSMTPCannotAssignHost = class(EIdException);
  EIdDirectSMTPCannotResolveMX = class(EIdException);

  TIdSSLSupport = (NoSSL, SupportSSL, RequireSSL);

const
  DEF_SSL_SUPPORT = NoSSL;
  DEF_TRY_IMPLICITTLS = False;
  DEF_REPLY_CODE = 0;
  DEF_SENT = False;

type
  TIdSMTPRelayStatusItem = class(TCollectionItem)
  protected
    FSent: Boolean;
    FExceptionMessage: String;
    FEmailAddress: String;
    FReplyCode : Integer;
    FEnhancedCode : TIdSMTPEnhancedCode;
    procedure SetEnhancedCode(const Value: TIdSMTPEnhancedCode);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property EmailAddress: String read FEmailAddress write FEmailAddress;
    // TODO: add an ExceptionClassName property, or even capture the Exception itself
    property ExceptionMessage: String read FExceptionMessage write FExceptionMessage;
    property Sent: Boolean read FSent write FSent default DEF_SENT;
    property ReplyCode : Integer read FReplyCode write FReplyCode default DEF_REPLY_CODE;
    property EnhancedCode : TIdSMTPEnhancedCode read FEnhancedCode write SetEnhancedCode;
  end;

  TIdSMTPRelayStatusList = class(TOwnedCollection)
  protected
    function GetItems(Index: Integer): TIdSMTPRelayStatusItem;
    procedure SetItems(Index: Integer;const Value: TIdSMTPRelayStatusItem);
  public
    function Add : TIdSMTPRelayStatusItem;
    property Items[Index: Integer]: TIdSMTPRelayStatusItem read GetItems write SetItems; default;
  end;

  TIdSMTPRelay = class;

  TIdSSLSupportOptions = class(TIdBaseComponent)
  protected
    FSSLSupport : TIdSSLSupport;
    FTryImplicitTLS : Boolean;
    FOwner : TIdSMTPRelay;

    procedure SetSSLSupport(const Value: TIdSSLSupport);
    procedure SetTryImplicitTLS(const Value: Boolean);
  public
    constructor Create(AOwner : TIdSMTPRelay);
    procedure Assign(Source: TPersistent); override;
  published
    property SSLSupport : TIdSSLSupport read FSSLSupport write SetSSLSupport default DEF_SSL_SUPPORT;
    property TryImplicitTLS : Boolean read FTryImplicitTLS write SetTryImplicitTLS default DEF_TRY_IMPLICITTLS;
  end;

  TIdSMTPRelay = class(TIdSMTPBase)
  protected
    FMXServerList: TStrings;
    FStatusList: TIdSMTPRelayStatusList;
    FDNSServer: String;
    FOnDirectSMTPStatus: TIdSMTPRelayStatus;
    FSSLOptions : TIdSSLSupportOptions;
    FRelaySender: String;
    procedure Connect(AEMailAddress : TIdEMailAddressItem); reintroduce;
    procedure ResolveMXServers(AAddress:String);
    procedure SetDNSServer(const Value: String);
    procedure SetOnStatus(const Value: TIdSMTPRelayStatus);
    procedure SetUseEhlo(const AValue : Boolean); override;
    procedure SetHost(const Value: String); override;
    function GetSupportsTLS : boolean; override;
    procedure ProcessException(AException: Exception; AEMailAddress : TIdEMailAddressItem);
    procedure SetSSLOptions(const Value: TIdSSLSupportOptions);
    procedure SetRelaySender(const Value: String);
    //
    procedure InitComponent; override;
    //
    // holger: .NET compatibility change
    property Port;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    procedure DisconnectNotifyPeer; override;
    procedure Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList); override;
  published
    property DNSServer: String read FDNSServer write SetDNSServer;
    property RelaySender: String read FRelaySender write SetRelaySender;
    property StatusList: TIdSMTPRelayStatusList read FStatusList;
    property SSLOptions: TIdSSLSupportOptions read FSSLOptions write SetSSLOptions;
    property OnDirectSMTPStatus: TIdSMTPRelayStatus read FOnDirectSMTPStatus write SetOnStatus;
    property OnTLSHandShakeFailed;
    property OnTLSNotAvailable;
    property OnTLSNegCmdFailed;
  end;

implementation

uses
  IdGlobalProtocols, IdStack, IdCoderMIME, IdDNSCommon,
  IdResourceStringsProtocols, IdExplicitTLSClientServerBase,
  IdSSL, IdStackConsts, IdTCPClient, IdTCPConnection;

{ TIdSMTPRelay }

procedure TIdSMTPRelay.Assign(Source: TPersistent);
begin
  if Source is TIdSMTPRelay then
  begin
    MailAgent := TIdSMTPRelay(Source).MailAgent;
    Port := TIdSMTPRelay(Source).Port;
    DNSServer := TIdSMTPRelay(Source).DNSServer;
  end else begin
    inherited Assign(Source);
  end;
end;

procedure TIdSMTPRelay.Connect(AEMailAddress : TIdEMailAddressItem);
var
  LCanImplicitTLS: Boolean;
begin
  LCanImplicitTLS := Self.FSSLOptions.TryImplicitTLS;
  if LCanImplicitTLS then
  begin
    try
      UseTLS := utUseImplicitTLS;
      inherited Connect;
    except
      on E: EIdSocketError do
      begin
       // If 10061 - connection refused - retry without ImplicitTLS
       // If 10060 - connection timed out - retry without ImplicitTLS
        if (E.LastError = Id_WSAECONNREFUSED) or
          (E.LastError = Id_WSAETIMEDOUT) then
        begin
          LCanImplicitTLS := False;
        end else begin
          raise;
        end;
      end;
    end;
  end;
  if not LCanImplicitTLS then
  begin
    case Self.FSSLOptions.FSSLSupport of
     SupportSSL : FUseTLS := utUseExplicitTLS;
     RequireSSL : FUseTLS := utUseRequireTLS;
    else
      FUseTLS := utNoTLSSupport;
    end;
    inherited Connect;
  end;
  try
    GetResponse(220);
    SendGreeting;
    StartTLS;
  except
    on E : Exception do
    begin
      // RLebeau: calling ProcessException() here can cause multiple status
      // items to be created for the same address!  Do we want this?  If not,
      // then just raise the exception to the caller and let it call
      // ProcessException() when appropriate...
      ProcessException(E,AEMailAddress);
      Disconnect;
      raise;
    end;
  end;
end;

procedure TIdSMTPRelay.InitComponent;
begin
  inherited InitComponent;
  FSSLOptions := TIdSSLSupportOptions.Create(Self);
  FMXServerList := TStringList.Create;
  FStatusList := TIdSMTPRelayStatusList.Create(Self, TIdSMTPRelayStatusItem);
end;

destructor TIdSMTPRelay.Destroy;
begin
  FreeAndNil(FSSLOptions);
  FreeAndNil(FMXServerList);
  FreeAndNil(FStatusList);
  inherited Destroy;
end;

procedure TIdSMTPRelay.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', 221);    {Do not Localize}
end;

function TIdSMTPRelay.GetSupportsTLS: boolean;
begin
   Result := ( FCapabilities.IndexOf('STARTTLS') > -1 ); //do not localize
end;

procedure TIdSMTPRelay.ProcessException(AException: Exception; AEMailAddress : TIdEMailAddressItem);
var
  LE: EIdSMTPReplyError;
  LStatus: TIdSMTPRelayStatusItem;
begin
  LStatus := FStatusList.Add;
  LStatus.EmailAddress := AEmailAddress.Address;
  LStatus.Sent := False;
  LStatus.ExceptionMessage := AException.Message;
  if AException is EIdSMTPReplyError then
  begin
    LE := AException as EIdSMTPReplyError;
    LStatus.ReplyCode :=  LE.ErrorCode;
    LStatus.EnhancedCode.ReplyAsStr := LE.EnhancedCode.ReplyAsStr;
  end;
  if Assigned(FOnDirectSMTPStatus) then
  begin
    FOnDirectSMTPStatus(Self, AEmailAddress, dmWorkEndWithException);
  end;
end;

procedure TIdSMTPRelay.ResolveMXServers(AAddress: String);
var
  IdDNSResolver1: TIdDNSResolver;
  DnsResource : TResultRecord;
  LMx: TMxRecord;
  LDomain:String;
  i: Integer;
  iPref: Word;
begin
  { Get the list of MX Servers for a given domain into FMXServerList }
  i := Pos('@', AAddress);
  if i = 0 then
  begin
    raise EIdDirectSMTPCannotResolveMX.CreateFmt(RSDirSMTPInvalidEMailAddress, [AAddress]);
  end;
  LDomain := Copy(AAddress, i+1, MaxInt);
  IdDNSResolver1 := TIdDNSResolver.Create(Self);
  try
    FMXServerList.Clear;
    IdDNSResolver1.AllowRecursiveQueries := True;
    if Assigned(IOHandler) and (IOHandler.ReadTimeOut > 0) then
    begin
      //thirty seconds - maximum amount of time allowed for DNS query
      IdDNSResolver1.WaitingTime := IOHandler.ReadTimeout;
    end else begin
      IdDNSResolver1.WaitingTime := 30000;
    end;
    IdDNSResolver1.QueryType := [qtMX];
    IdDNSResolver1.Host := DNSServer;
    IdDNSResolver1.Resolve(LDomain);
    if IdDNSResolver1.QueryResult.Count > 0 then
    begin
      iPref := High(Word);
      for i := 0 to IdDNSResolver1.QueryResult.Count - 1 do
      begin
        DnsResource := IdDNSResolver1.QueryResult[i];
        if (DnsResource is TMXRecord) then
        begin
          LMx := TMXRecord(DnsResource);
          // lower preference values at top of the list
          // could use AddObject and CustomSort, or TIdBubbleSortStringList
          // currently inserts lower values at top
          if LMx.Preference < iPref then
          begin
            iPref := LMx.Preference;
            FMXServerList.Insert(0, LMx.ExchangeServer);
          end else begin
            FMXServerList.Add(LMx.ExchangeServer);
          end;
        end;
      end;
    end;
    if FMXServerList.Count = 0 then
    begin
      raise EIdDirectSMTPCannotResolveMX.CreateFmt(RSDirSMTPNoMXRecordsForDomain, [LDomain]);
    end;
  finally
    FreeAndNil(IdDNSResolver1);
  end;
end;

procedure TIdSMTPRelay.Send(AMsg: TIdMessage; ARecipients: TIdEMailAddressList);
var
  LAllEntries, LCurDomEntries: TIdEMailAddressList;
  SDomains: TStrings;
  LFrom: String;
  i: Integer;

  procedure RelayInternalSend(const ALMsg: TIdMessage; const AFrom: String; const AEmailAddresses: TIdEMailAddressList);
  var
    ServerIndex:Integer;
    EMailSent: Boolean;
    LStatusItem: TIdSMTPRelayStatusItem;
  begin
    if AEmailAddresses.Count = 0 then
    begin
      Exit;
    end;
    EMailSent := False;
    if Assigned(FOnDirectSMTPStatus) then
    begin
      FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmWorkBegin);
    end;
    try
      try
        if Assigned(FOnDirectSMTPStatus) then
        begin
          FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmResolveMS);
        end;

        ResolveMXServers(AEMailAddresses[0].Address);
        ServerIndex := 0;

        while (ServerIndex <= FMXServerList.Count - 1) and (not EMailSent) do
        begin
          FHost := FMXServerList[ServerIndex];
          try
            if Connected then begin
              Disconnect;
            end;
            if Assigned(FOnDirectSMTPStatus) then
            begin
              FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmConnecting);
            end;
            Connect(AEmailAddresses[0]);
            if Assigned(FOnDirectSMTPStatus) then
            begin
              FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmConnected);
            end;
            if Assigned(FOnDirectSMTPStatus) then
            begin
              FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmSending);
            end;
            if Trim(MailAgent) <> '' then
            begin
              ALMsg.Headers.Values[XMAILER_HEADER] := Trim(MailAgent);
            end;
            InternalSend(ALMsg, AFrom, AEmailAddresses);
            EMailSent := True;
            LStatusItem := FStatusList.Add;
            LStatusItem.EmailAddress := AEmailAddresses[0].Address;
            LStatusItem.Sent := True;
            if Assigned(FOnDirectSMTPStatus) then
            begin
              FOnDirectSMTPStatus(Self, AEmailAddresses[0], dmWorkEndOK);
            end;
          except
            // Sit on the error, and move on to the next server.
            Inc(ServerIndex);
          end; 
        end;
        if (not Connected) and (not EMailSent) then // If we were unable to connect to all the servers, throw exception
        begin
           raise EIdTCPConnectionError.CreateFmt(RSDirSMTPCantConnectToSMTPSvr, [AEmailAddresses[0].Address]);
        end;
      except
        on E : Exception do
        begin
          ProcessException(E, AEmailAddresses[0]);
        end;
      end;
    finally
      Disconnect;
    end;
  end;

begin
  if Trim(FRelaySender) <> '' then begin
    LFrom := FRelaySender;
  end else begin
    LFrom := AMsg.From.Address;
  end;

  if Assigned(ARecipients) then begin
    LAllEntries := ARecipients;
  end else begin
    LAllEntries := TIdEMailAddressList.Create(nil);
  end;

  try
    if not Assigned(ARecipients) then begin
      LAllEntries.AddItems(AMsg.Recipients);
      LAllEntries.AddItems(AMsg.CCList);
      LAllEntries.AddItems(AMsg.BccList);
    end;
    SDomains := TStringList.Create;
    try
      LAllEntries.GetDomains(SDomains);
      LCurDomEntries := TIdEMailAddressList.Create(nil);
      try
        for i := 0 to SDomains.Count -1 do
        begin
          LAllEntries.AddressesByDomain(LCurDomEntries, SDomains[i]);
          RelayInternalSend(AMsg, LFrom, LCurDomEntries);
        end;
      finally
        FreeAndNil(LCurDomEntries);
      end;
    finally
      FreeAndNil(SDomains);
    end;
  finally
    if not Assigned(ARecipients) then begin
      FreeAndNil(LAllEntries);
    end;
  end;
end;

procedure TIdSMTPRelay.SetDNSServer(const Value: String);
begin
  FDNSServer := Value;
end;

procedure TIdSMTPRelay.SetHost(const Value: String);
begin
  raise EIdDirectSMTPCannotAssignHost.Create(RSDirSMTPCantAssignHost);
end;

procedure TIdSMTPRelay.SetOnStatus(const Value: TIdSMTPRelayStatus);
begin
  FOnDirectSMTPStatus := Value;
end;

procedure TIdSMTPRelay.SetSSLOptions(const Value: TIdSSLSupportOptions);
begin
  FSSLOptions.Assign(Value);
end;

procedure TIdSMTPRelay.SetUseEhlo(const AValue: Boolean);
begin
  inherited;
  FSSLOptions.FSSLSupport := noSSL;
end;

procedure TIdSMTPRelay.SetRelaySender(const Value: String);
begin
  FRelaySender := Value;
end;

{ TIdSMTPRelayStatusList }

function TIdSMTPRelayStatusList.Add: TIdSMTPRelayStatusItem;
begin
  Result := TIdSMTPRelayStatusItem(inherited Add);
end;

function TIdSMTPRelayStatusList.GetItems(Index: Integer): TIdSMTPRelayStatusItem;
begin
   Result := TIdSMTPRelayStatusItem(inherited Items[Index]);
end;

procedure TIdSMTPRelayStatusList.SetItems(Index: Integer; const Value: TIdSMTPRelayStatusItem);
begin
  Items[Index].Assign(Value);
end;

{ TIdSMTPRelayStatusItem }

constructor TIdSMTPRelayStatusItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEnhancedCode := TIdSMTPEnhancedCode.Create;
  FSent := DEF_SENT;
  FReplyCode := DEF_REPLY_CODE;
end;

destructor TIdSMTPRelayStatusItem.Destroy;
begin
  FreeAndNil(FEnhancedCode);
  inherited Destroy;
end;

procedure TIdSMTPRelayStatusItem.SetEnhancedCode(
  const Value: TIdSMTPEnhancedCode);
begin
  FEnhancedCode.ReplyAsStr := Value.ReplyAsStr;
end;

{ TIdSSLSupportOptions }

procedure TIdSSLSupportOptions.Assign(Source: TPersistent);
var
  LS: TIdSSLSupportOptions;
begin
  if (Source is TIdSSLSupportOptions) then
  begin
    LS := TIdSSLSupportOptions(Source);
    SSLSupport := LS.FSSLSupport;
    TryImplicitTLS := LS.TryImplicitTLS;
  end
  else
  begin
    inherited Assign(Source);
  end;
end;

constructor TIdSSLSupportOptions.Create(AOwner: TIdSMTPRelay);
begin
  inherited Create;
  FOwner := AOwner;
  FSSLSupport := DEF_SSL_SUPPORT;
  FTryImplicitTLS := DEF_TRY_IMPLICITTLS;
end;

procedure TIdSSLSupportOptions.SetSSLSupport(const Value: TIdSSLSupport);
begin
  if (Value <> noSSL) and (not IsLoading) then
  begin
    FOwner.CheckIfCanUseTLS;
  end;
  if (Value <> noSSL) and (not FOwner.UseEhlo) then
  begin
    FOwner.FUseEHLO := True;
  end;
  if (Value = noSSL) then
  begin
    FTryImplicitTLS := False;
  end;
  FSSLSupport := Value;
end;

procedure TIdSSLSupportOptions.SetTryImplicitTLS(const Value: Boolean);
begin
  if Value and (not IsLoading) then
  begin
    FOwner.CheckIfCanUseTLS;
  end;
  if Value and (Self.FSSLSupport=NoSSL) then
  begin
    SSLSupport := SupportSSL;
  end;
  FTryImplicitTLS := Value;
end;

end.
