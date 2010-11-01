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
  TIdSASLListEntry = class(TCollectionItem)
  protected
    FSASL : TIdSASL;
    function GetDisplayName: String; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property SASL : TIdSASL read FSASL write FSASL;
  end;

  TIdSASLEntries = class ( TOwnedCollection )
  protected
    procedure CheckIfEmpty;
    function GetItem(Index: Integer) : TIdSASLListEntry;
    procedure SetItem(Index: Integer; const Value: TIdSASLListEntry);
  public
    constructor Create ( AOwner : TPersistent ); reintroduce;
    function Add: TIdSASLListEntry;
    procedure LoginSASL(const ACmd, AHost, AProtocolName: String; const AOkReplies, AContinueReplies: array of string;
      AClient : TIdTCPConnection; ACapaReply : TStrings;
      const AAuthString : String = 'AUTH'); overload;      {Do not Localize}
    procedure LoginSASL(const ACmd, AHost, AProtocolName: String; const AServiceName: String;
      const AOkReplies, AContinueReplies: array of string; AClient : TIdTCPConnection;
      ACapaReply : TStrings; const AAuthString : String = 'AUTH'); overload;      {Do not Localize}
    function ParseCapaReply(ACapaReply: TStrings; const AAuthString: String = 'AUTH') : TStrings; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use ParseCapaReplyToList()'{$ENDIF};{$ENDIF} {do not localize}
    procedure ParseCapaReplyToList(ACapaReply, ADestList: TStrings; const AAuthString: String = 'AUTH'); {do not localize}
    function FindSASL(const AServiceName: String): TIdSASL;
    function Insert(Index: Integer): TIdSASLListEntry;
    procedure RemoveByComp(AComponent : TComponent);
    function IndexOfComp(AItem : TIdSASL): Integer;
    property Items[Index: Integer] : TIdSASLListEntry read GetItem write SetItem; default;
  end;

  EIdSASLException = class(EIdException);
  EIdSASLNotSupported = class(EIdSASLException);
  EIdSASLNotReady = class(EIdSASLException);
  EIdSASLMechNeeded = class(EIdSASLException);

implementation

uses
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
    FSASL := TIdSASLListEntry(Source).SASL;
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

{ TIdSASLEntries }

function CheckStrFail(const AStr : String; const AOk, ACont: array of string) : Boolean;
begin
  Result := (PosInStrArray(AStr, AOk) = -1) and
    (PosInStrArray(AStr, ACont) = -1);
end;

function PerformSASLLogin(const ACmd, AHost, AProtocolName: String; ASASL: TIdSASL; AEncoder: TIdEncoder;
  ADecoder: TIdDecoder; const AOkReplies, AContinueReplies: array of string;
  AClient : TIdTCPConnection): Boolean;
var
  S: String;
begin
  Result := False;
  AClient.SendCmd(ACmd + ' ' + String(ASASL.ServiceName), []);//[334, 504]);
  if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then begin
    Exit; // this mechanism is not supported
  end;
  if (PosInStrArray(AClient.LastCmdResult.Code, AOkReplies) > -1) then begin
    Result := True;
    Exit; // we've authenticated successfully :)
  end;
  S := ADecoder.DecodeString(TrimRight(AClient.LastCmdResult.Text.Text));
  S := ASASL.StartAuthenticate(S, AHost, AProtocolName);
  AClient.SendCmd(AEncoder.Encode(S));
  if CheckStrFail(AClient.LastCmdResult.Code, AOkReplies, AContinueReplies) then
  begin
    ASASL.FinishAuthenticate;
    Exit;
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
  EIdSASLMechNeeded.Toss(RSSASLRequired);
end;

function TIdSASLEntries.GetItem(Index: Integer): TIdSASLListEntry;
begin
  Result := TIdSASLListEntry(inherited Items[Index]);
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

procedure TIdSASLEntries.LoginSASL(const ACmd, AHost, AProtocolName: String; const AOkReplies,
  AContinueReplies: array of string; AClient: TIdTCPConnection;
  ACapaReply: TStrings; const AAuthString: String);
var
  i : Integer;
  LE : TIdEncoderMIME;
  LD : TIdDecoderMIME;
  LSupportedSASL : TStrings;
  LSASLList: TList;
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
  LSASLList := TList.Create;
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
      EIdSASLNotSupported.Toss(RSSASLNotSupported);
    end;

    //now do it
    LE := nil;
    try
      LD := nil;
      try
        LError := nil;
        try
          for i := 0 to LSASLList.Count-1 do begin
            LSASL := TIdSASL(LSASLList.Items[i]);
            if not LSASL.IsReadyToStart then begin
              Continue;
            end;
            if not Assigned(LE) then begin
              LE := TIdEncoderMIME.Create(nil);
            end;
            if not Assigned(LD) then begin
              LD := TIdDecoderMIME.Create(nil);
            end;
            if PerformSASLLogin(ACmd, AHost, AProtocolName, LSASL, LE, LD, AOkReplies, AContinueReplies, AClient) then begin
              Exit;
            end;
            if not Assigned(LError) then begin
              LError := SetupErrorReply;
            end;
          end;
          if Assigned(LError) then begin
            LError.RaiseReplyError;
          end else begin
            EIdSASLNotReady.Toss(RSSASLNotReady);
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

procedure TIdSASLEntries.LoginSASL(const ACmd, AHost, AProtocolName: String; const AServiceName: String;
  const AOkReplies, AContinueReplies: array of string; AClient: TIdTCPConnection;
  ACapaReply: TStrings; const AAuthString: String);
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
    EIdSASLNotSupported.Toss(RSSASLNotSupported);
  end
  else if not LSASL.IsReadyToStart then begin
    EIdSASLNotReady.Toss(RSSASLNotReady);
  end;

  //now do it
  LE := TIdEncoderMIME.Create(nil);
  try
    LD := TIdDecoderMIME.Create(nil);
    try
      if not PerformSASLLogin(ACmd, AHost, AProtocolName, LSASL, LE, LD, AOkReplies, AContinueReplies, AClient) then begin
        AClient.RaiseExceptionForLastCmdResult;
      end;
    finally
      FreeAndNil(LD);
    end;
  finally
    FreeAndNil(LE);
  end;
end;

function TIdSASLEntries.ParseCapaReply(ACapaReply: TStrings; const AAuthString: String): TStrings;
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
        s := StringReplace(s, '=', ' ', [rfReplaceAll]);    {Do not Localize}
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

