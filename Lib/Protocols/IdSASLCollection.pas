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
  Rev 1.5    11/27/2004 8:27:14 PM  JPMugaas
  Fix for compiler errors.

  Rev 1.4    11/27/04 2:56:40 AM  RLebeau
  Added support for overloaded version of LoginSASL().

  Added GetDisplayName() method to TIdSASLListEntry, and FindSASL() method to
  TIdSASLEntries.

  Rev 1.3    10/26/2004 10:55:32 PM  JPMugaas
  Updated refs.

    Rev 1.2    6/11/2004 9:38:38 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.1    2004.02.03 5:45:50 PM  czhower
  Name changes

  Rev 1.0    1/25/2004 3:09:54 PM  JPMugaas
  New collection class for SASL mechanism processing.
}

unit IdSASLCollection;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent,
  IdCoder,
  IdException,
  IdSASL,
  IdTCPConnection;

type
  TIdSASLEntries = class;

  TIdSASLListEntry = class(TCollectionItem)
  protected
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FSASL : TIdSASL;
    function GetDisplayName: String; override;
    function GetOwnerComponent: TComponent;
    function GetSASLEntries: TIdSASLEntries;
    procedure SetSASL(AValue : TIdSASL);
  public
    procedure Assign(Source: TPersistent); override;
    property OwnerComponent: TComponent read GetOwnerComponent;
    property SASLEntries: TIdSASLEntries read GetSASLEntries;
  published
    property SASL : TIdSASL read FSASL write SetSASL;
  end;

  TIdSASLEntries = class ( TOwnedCollection )
  protected
    procedure CheckIfEmpty;
    function GetItem(Index: Integer) : TIdSASLListEntry;
    function GetOwnerComponent: TComponent;
    procedure SetItem(Index: Integer; const Value: TIdSASLListEntry);
  public
    constructor Create ( AOwner : TPersistent ); reintroduce;
    function Add: TIdSASLListEntry;
    procedure LoginSASL(const ACmd, AHost, AProtocolName: String;
      const AOkReplies, AContinueReplies: array of string; AClient : TIdTCPConnection;
      ACapaReply : TStrings; const AAuthString : String = 'AUTH';      {Do not Localize}
      ACanAttemptIR: Boolean = True); overload;
    procedure LoginSASL(const ACmd, AHost, AProtocolName, AServiceName: String;
      const AOkReplies, AContinueReplies: array of string; AClient : TIdTCPConnection;
      ACapaReply : TStrings; const AAuthString : String = 'AUTH';      {Do not Localize}
      ACanAttemptIR: Boolean = True); overload;
    function ParseCapaReply(ACapaReply: TStrings; const AAuthString: String = 'AUTH') : TStrings; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use ParseCapaReplyToList()'{$ENDIF};{$ENDIF} {do not localize}
    procedure ParseCapaReplyToList(ACapaReply, ADestList: TStrings; const AAuthString: String = 'AUTH'); {do not localize}
    function FindSASL(const AServiceName: String): TIdSASL;
    function Insert(Index: Integer): TIdSASLListEntry;
    procedure RemoveByComp(AComponent : TComponent);
    function IndexOfComp(AItem : TIdSASL): Integer;
    property Items[Index: Integer] : TIdSASLListEntry read GetItem write SetItem; default;
    property OwnerComponent: TComponent read GetOwnerComponent;
  end;

  EIdSASLException = class(EIdException);
  EIdSASLNotSupported = class(EIdSASLException);
  EIdSASLNotReady = class(EIdSASLException);
  EIdSASLMechNeeded = class(EIdSASLException);

implementation

uses
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdAssignedNumbers,
  IdCoderMIME,
  IdGlobal,
  IdGlobalProtocols,
  IdReply,
  IdResourceStringsProtocols,
  SysUtils;

{ TIdSASLListEntry }

procedure TIdSASLListEntry.Assign(Source: TPersistent);
begin
  if Source is TIdSASLListEntry then begin
    SASL := TIdSASLListEntry(Source).SASL;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdSASLListEntry.GetDisplayName: String;
begin
  if FSASL <> nil then begin
    Result := String(FSASL.ServiceName);
  end else begin
    Result := inherited GetDisplayName;
  end;
end;

function TIdSASLListEntry.GetOwnerComponent: TComponent;
var
  LEntries: TIdSASLEntries;
begin
  LEntries := SASLEntries;
  if Assigned(LEntries) then begin
    Result := LEntries.OwnerComponent;
  end else begin
    Result := nil;
  end;
end;

function TIdSASLListEntry.GetSASLEntries: TIdSASLEntries;
begin
  if Collection is TIdSASLEntries then begin
    Result := TIdSASLEntries(Collection);
  end else begin
    Result := nil;
  end;
end;

procedure TIdSASLListEntry.SetSASL(AValue : TIdSASL);
var
  LOwnerComp: TComponent;
begin
  if FSASL <> AValue then begin
    LOwnerComp := OwnerComponent;
    if (FSASL <> nil) and (LOwnerComp <> nil) then begin
      FSASL.RemoveFreeNotification(LOwnerComp);
    end;
    FSASL := AValue;
    if (FSASL <> nil) and (LOwnerComp <> nil) then begin
      FSASL.FreeNotification(LOwnerComp);
    end;
  end;
end;

{ TIdSASLEntries }

// RLebeau 2/8/2013: WARNING!!! To work around a design limitation in the way
// TIdIMAP4 implements SendCmd(), it cannot use TIdSASLEntries.LoginSASL() for
// SASL authentication because the SASL commands sent in this unit will not end
// up being IMAP-compatible!  Until that can be addressed, any changes made to
// PerformSASLLogin() or LoginSASL() in this unit need to be duplicated in the
// IdIMAP4.pas unit for the TIdIMAP4.Login() method as well...

function CheckStrFail(const AStr : String; const AOk, ACont: array of string) : Boolean;
begin
  Result := (PosInStrArray(AStr, AOk) = -1) and
    (PosInStrArray(AStr, ACont) = -1);
end;

function PerformSASLLogin(const ACmd, AHost, AProtocolName: String; ASASL: TIdSASL;
  AEncoder: TIdEncoder; ADecoder: TIdDecoder; const AOkReplies, AContinueReplies: array of string;
  AClient : TIdTCPConnection; ACanAttemptIR: Boolean): Boolean;
var
  S: String;
  AuthStarted: Boolean;
begin
  Result := False;
  AuthStarted := False;

  // TODO: handle ACanAttemptIR based on AProtocolName.
  //
  // SASL in SMTP and DICT supported Initial-Response from the beginning,
  // as should any new SASL-enabled protocol moving forward.
  //
  // SASL in IMAP did not originally support Initial-Response, but it was
  // added in RFC 4959 along with an explicit capability ('SASL-IR') to
  // indicate when Initial-Response is supported. SASL in IMAP is currently
  // handled by TIdIMAP4 directly, but should it be updated to use
  // TIdSASLEntries.LoginSASL() in the future then it will set the
  // ACanAttemptIR parameter accordingly.
  //
  // SASL in POP3 did not originally support Initial-Response. It was added
  // in RFC 2449 along with the CAPA command. If a server supports the CAPA
  // command then it *should* also support Initial-Response as well, however
  // many POP3 servers support CAPA but do not support Initial-Response
  // (which was formalized in RFC 5034). So, to handle that descrepency,
  // TIdPOP3 currently sets ACanAttemptIR to false.  In the future, we could
  // let it set ACanAttemptIR to True instead, and then if Initial-Response
  // fails here for POP3 then re-attempt without Initial-Response before
  // exiting with a failure.

  if ACanAttemptIR then begin
    if ASASL.TryStartAuthenticate(AHost, AProtocolName, S) then begin
      AClient.SendCmd(ACmd + ' ' + String(ASASL.ServiceName) + ' ' + AEncoder.Encode(S), []);//[334, 504]);
      if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then begin
        if not TextIsSame(AProtocolName, IdGSKSSN_pop) then begin
          ASASL.FinishAuthenticate;
          Exit; // this mechanism is not supported
        end;
      end else begin
        AuthStarted := True;
      end;
    end;
  end;
  if not AuthStarted then begin
    AClient.SendCmd(ACmd + ' ' + String(ASASL.ServiceName), []);//[334, 504]);
    if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then begin
      Exit; // this mechanism is not supported
    end;
  end;
  if (PosInStrArray(AClient.LastCmdResult.Code, AOkReplies) > -1) then begin
    if AuthStarted then begin
      ASASL.FinishAuthenticate;
    end;
    Result := True;
    Exit; // we've authenticated successfully :)
  end;
  // must be a continue reply...
  if not AuthStarted then begin
    S := ADecoder.DecodeString(TrimRight(AClient.LastCmdResult.Text.Text));
    S := ASASL.StartAuthenticate(S, AHost, AProtocolName);
    AClient.SendCmd(AEncoder.Encode(S));
    if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then
    begin
      ASASL.FinishAuthenticate;
      Exit;
    end;
  end;
  while PosInStrArray(AClient.LastCmdResult.Code, AContinueReplies) > -1 do begin
    S := ADecoder.DecodeString(TrimRight(AClient.LastCmdResult.Text.Text));
    S := ASASL.ContinueAuthenticate(S, AHost, AProtocolName);
    AClient.SendCmd(AEncoder.Encode(S));
    if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then
    begin
      ASASL.FinishAuthenticate;
      Exit;
    end;
  end;
  Result := (PosInStrArray(AClient.LastCmdResult.Code, AOkReplies) > -1);
  ASASL.FinishAuthenticate;
end;

function TIdSASLEntries.Add: TIdSASLListEntry;
begin
  Result := TIdSASLListEntry(inherited Add);
end;

constructor TIdSASLEntries.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdSASLListEntry);
end;

procedure TIdSASLEntries.CheckIfEmpty;
var
  I: Integer;
begin
  for I := 0 to Count-1 do begin
    if Items[I].SASL <> nil then begin
      Exit;
    end;
  end;
  raise EIdSASLMechNeeded.Create(RSSASLRequired);
end;

function TIdSASLEntries.GetItem(Index: Integer): TIdSASLListEntry;
begin
  Result := TIdSASLListEntry(inherited Items[Index]);
end;

function TIdSASLEntries.GetOwnerComponent: TComponent;
var
  LOwner: TPersistent;
begin
  LOwner := inherited GetOwner;
  if LOwner is TComponent then begin
    Result := TComponent(LOwner);
  end else begin
    Result := nil;
  end;
end;

function TIdSASLEntries.IndexOfComp(AItem: TIdSASL): Integer;
begin
  for Result := 0 to Count -1 do
  begin
    if Items[Result].SASL = AItem then
    begin
      Exit;
    end;
  end;
  Result := -1;
end;

function TIdSASLEntries.Insert(Index: Integer): TIdSASLListEntry;
begin
  Result := TIdSASLListEntry( inherited Insert(Index) );
end;

type
  {$IFDEF HAS_GENERICS_TList}
  TIdSASLList = TList<TIdSASL>;
  {$ELSE}
  // TODO: flesh out to match TList<TIdSASL> for non-Generics compilers
  TIdSASLList = TList;
  {$ENDIF}

procedure TIdSASLEntries.LoginSASL(const ACmd, AHost, AProtocolName: String; const AOkReplies,
  AContinueReplies: array of string; AClient: TIdTCPConnection;
  ACapaReply: TStrings; const AAuthString: String; ACanAttemptIR: Boolean);
var
  i : Integer;
  LE : TIdEncoderMIME;
  LD : TIdDecoderMIME;
  LSupportedSASL : TStrings;
  LSASLList: TIdSASLList;
  LSASL : TIdSASL;
  LError : TIdReply;

  function SetupErrorReply: TIdReply;
  begin
    Result := TIdReplyClass(AClient.LastCmdResult.ClassType).Create(nil);
    Result.Assign(AClient.LastCmdResult);
  end;

begin
  // make sure the collection is not empty
  CheckIfEmpty;

  //create a list of mechanisms that both parties support
  LSASLList := TIdSASLList.Create;
  try
    LSupportedSASL := TStringList.Create;
    try
      ParseCapaReplyToList(ACapaReply, LSupportedSASL, AAuthString);
      for i := Count-1 downto 0 do begin
        LSASL := Items[i].SASL;
        if LSASL <> nil then begin
          if not LSASL.IsAuthProtocolAvailable(LSupportedSASL) then begin
            Continue;
          end;
          if LSASLList.IndexOf(LSASL) = -1 then begin
            LSASLList.Add(LSASL);
          end;
        end;
      end;
    finally
      FreeAndNil(LSupportedSASL);
    end;

    if LSASLList.Count = 0 then begin
      raise EIdSASLNotSupported.Create(RSSASLNotSupported);
    end;

    //now do it
    LE := nil;
    try
      LD := nil;
      try
        LError := nil;
        try
          for i := 0 to LSASLList.Count-1 do begin
            LSASL := {$IFDEF HAS_GENERICS_TList}LSASLList.Items[i]{$ELSE}TIdSASL(LSASLList.Items[i]){$ENDIF};
            if not LSASL.IsReadyToStart then begin
              Continue;
            end;
            if not Assigned(LE) then begin
              LE := TIdEncoderMIME.Create(nil);
            end;
            if not Assigned(LD) then begin
              LD := TIdDecoderMIME.Create(nil);
            end;
            if PerformSASLLogin(ACmd, AHost, AProtocolName, LSASL, LE, LD, AOkReplies, AContinueReplies, AClient, ACanAttemptIR) then begin
              Exit;
            end;
            if not Assigned(LError) then begin
              LError := SetupErrorReply;
            end;
          end;
          if Assigned(LError) then begin
            LError.RaiseReplyError;
          end else begin
            raise EIdSASLNotReady.Create(RSSASLNotReady);
          end;
        finally
          FreeAndNil(LError);
        end;
      finally
        FreeAndNil(LD);
      end;
    finally
      FreeAndNil(LE);
    end;
  finally
    FreeAndNil(LSASLList);
  end;
end;

procedure TIdSASLEntries.LoginSASL(const ACmd, AHost, AProtocolName, AServiceName: String;
  const AOkReplies, AContinueReplies: array of string; AClient: TIdTCPConnection;
  ACapaReply: TStrings; const AAuthString: String; ACanAttemptIR: Boolean);
var
  LE : TIdEncoderMIME;
  LD : TIdDecoderMIME;
  LSupportedSASL : TStrings;
  LSASL : TIdSASL;
begin
  LSASL := nil;

  // make sure the collection is not empty
  CheckIfEmpty;

  //determine if both parties support the same mechanism
  LSupportedSASL := TStringList.Create;
  try
    ParseCapaReplyToList(ACapaReply, LSupportedSASL, AAuthString);
    if LSupportedSASL.IndexOf(AServiceName) <> -1 then begin
      LSASL := FindSASL(AServiceName);
    end;
  finally
    FreeAndNil(LSupportedSASL);
  end;

  if LSASL = nil then begin
    raise EIdSASLNotSupported.Create(RSSASLNotSupported);
  end;
  if not LSASL.IsReadyToStart then begin
    raise EIdSASLNotReady.Create(RSSASLNotReady);
  end;

  //now do it
  LE := TIdEncoderMIME.Create(nil);
  try
    LD := TIdDecoderMIME.Create(nil);
    try
      if not PerformSASLLogin(ACmd, AHost, AProtocolName, LSASL, LE, LD, AOkReplies, AContinueReplies, AClient, ACanAttemptIR) then begin
        AClient.RaiseExceptionForLastCmdResult;
      end;
    finally
      FreeAndNil(LD);
    end;
  finally
    FreeAndNil(LE);
  end;
end;

{$I IdDeprecatedImplBugOff.inc}
function TIdSASLEntries.ParseCapaReply(ACapaReply: TStrings; const AAuthString: String): TStrings;
{$I IdDeprecatedImplBugOn.inc}
begin
  Result := TStringList.Create;
  try
    ParseCapaReplyToList(ACapaReply, Result, AAuthString);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdSASLEntries.ParseCapaReplyToList(ACapaReply, ADestList: TStrings;
  const AAuthString: String = 'AUTH'); {do not localize}
const
  VALIDDELIMS: String = ' ='; {Do not Localize}
var
  i: Integer;
  s: string;
  LEntry : String;
begin
  if ACapaReply = nil then begin
    Exit;
  end;
  ADestList.BeginUpdate;
  try
    for i := 0 to ACapaReply.Count - 1 do
    begin
      s := ACapaReply[i];
      if TextStartsWith(s, AAuthString) and CharIsInSet(s, Length(AAuthString)+1, VALIDDELIMS) then
      begin
        s := UpperCase(Copy(s, Length(AAuthString)+1, MaxInt));
        s := ReplaceAll(s, '=', ' ');    {Do not Localize}
        while Length(s) > 0 do
        begin
          LEntry := Fetch(s, ' ');    {Do not Localize}
          if LEntry <> '' then
          begin
            if ADestList.IndexOf(LEntry) = -1 then begin
              ADestList.Add(LEntry);
            end;
          end;
        end;
      end;
    end;
  finally
    ADestList.EndUpdate;
  end;
end;

function TIdSASLEntries.FindSASL(const AServiceName: String): TIdSASL;
var
  i: Integer;
  LEntry: TIdSASLListEntry;
begin
  Result := nil;
  For i := 0 to Count-1 do begin
    LEntry := Items[i];
    if LEntry.SASL <> nil then begin
      if TextIsSame(String(LEntry.SASL.ServiceName), AServiceName) then begin
        Result := LEntry.SASL;
        Exit;
      end;
    end;
  end;
end;

procedure TIdSASLEntries.RemoveByComp(AComponent: TComponent);
var
  i : Integer;
begin
  for i := Count-1 downto 0 do
  begin
    if Items[i].SASL = AComponent then begin
      Delete(i);
    end;
  end;
end;

procedure TIdSASLEntries.SetItem(Index: Integer; const Value: TIdSASLListEntry);
begin
  inherited SetItem(Index, Value);
end;

end.

