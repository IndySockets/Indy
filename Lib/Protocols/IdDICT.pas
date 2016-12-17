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
  Rev 1.8    10/26/2004 8:59:34 PM  JPMugaas
  Updated with new TStrings references for more portability.

  Rev 1.7    2004.10.26 11:47:54 AM  czhower
  Changes to fix a conflict with aliaser.

  Rev 1.6    7/6/2004 4:55:22 PM  DSiders
  Corrected spelling of Challenge.

  Rev 1.5    6/11/2004 9:34:08 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.4    6/11/2004 6:16:44 AM  DSiders
  Corrected spelling in class names, properties, and methods.

  Rev 1.3    3/8/2004 10:08:48 AM  JPMugaas
  IdDICT now compiles with new code.  IdDICT now added to palette.

  Rev 1.2    3/5/2004 7:23:56 AM  JPMugaas
  Fix for one server that does not send a feature list in the banner as RFC
  2229 requires.

  Rev 1.1    3/4/2004 3:55:02 PM  JPMugaas
  Untested work with SASL.
  Fixed a problem with multiple entries using default.  If AGetAll is true, a
  "*" is used for all of the databases.  "!" is for just the first database an
  entry is found in.

  Rev 1.0    3/4/2004 2:44:16 PM  JPMugaas
  RFC 2229 DICT client.  This is a preliminary version that was tested at
  dict.org
}

unit IdDICT;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdComponent,
  IdDICTCommon, IdSASLCollection, IdTCPClient, IdTCPConnection;

// TODO: MIME should be integrated into this.

type
  TIdDICTAuthenticationType = (datDefault, datSASL);

const
  DICT_AUTHDEF = datDefault;
  DEF_TRYMIME = False;

type
  TIdDICT = class(TIdTCPClient)
  protected
    FTryMIME: Boolean;
    FAuthType : TIdDICTAuthenticationType;
    FSASLMechanisms : TIdSASLEntries;
    FServer : String;
    FClient : String;
    //feature negotiation stuff
    FCapabilities : TStrings;
    procedure InitComponent; override;
    function IsCapaSupported(const ACapa : String) : Boolean;
    procedure SetClient(const AValue : String);
    procedure InternalGetList(const ACmd : String; AENtries : TCollection);
    procedure InternalGetStrs(const ACmd : String; AStrs : TStrings);
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;
    procedure Connect; override;
    procedure DisconnectNotifyPeer; override;
    procedure GetDictInfo(const ADict : String; AResults : TStrings);
    procedure GetSvrInfo(AResults : TStrings);
    procedure GetDBList(ADB : TIdDBList);
    procedure GetStrategyList(AStrats : TIdStrategyList);
    procedure Define(const AWord, ADBName : String; AResults : TIdDefinitions); overload;
    procedure Define(const AWord : String; AResults : TIdDefinitions; const AGetAll : Boolean = True); overload;
    procedure Match(const AWord, ADBName, AStrat : String; AResults : TIdMatchList); overload;
    procedure Match(const AWord, AStrat : String; AResults : TIdMatchList; const AGetAll : Boolean = True); overload;
    procedure Match(const AWord : String; AResults : TIdMatchList; const AGetAll : Boolean = True); overload;
    property Capabilities : TStrings read FCapabilities;
    property Server : String read FServer;
  published
    property TryMIME : Boolean read FTryMIME write FTryMIME default DEF_TRYMIME;
    property Client : String read FClient write SetClient;
    property AuthType : TIdDICTAuthenticationType read FAuthType write FAuthType default DICT_AUTHDEF;
    property SASLMechanisms : TIdSASLEntries read FSASLMechanisms write FSASLMechanisms;
    property Port default IdPORT_DICT;
    property Username;
    property Password;
  end;

implementation

uses
  IdFIPS,
  IdGlobal, IdGlobalProtocols, IdHash, IdHashMessageDigest, SysUtils;

const
  DEF_CLIENT_FMT = 'Indy Library %s'; {do not localize}

{ TIdDICT }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDICT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDICT.Connect;
var
  LBuf : String;
  LFeat : String;
  s : String;
  LMD5: TIdHashMessageDigest5;
begin
  LBuf := '';
  FCapabilities.Clear;

  FServer := '';
  try
    inherited Connect;
    IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
    GetResponse(220);
    if LastCmdResult.Text.Count > 0 then begin
      // 220 pan.alephnull.com dictd 1.8.0/rf on Linux 2.4.18-14 <auth.mime> <258510.25288.1078409724@pan.alephnull.com>
      LBuf := LastCmdResult.Text[0];
      //server
      FServer := TrimRight(Fetch(LBuf,'<'));
      //feature negotiation
      LFeat := Fetch(LBuf,'>');
      //One server I tested with has no feature negotiation at all and it returns something
      //like this:
      //220 dict.org Ho Ngoc Duc's DICT server 2.2 <1078465742246@dict.org>
      if (IndyPos('@',LFeat)=0) and (IndyPos('<',LBuf)>0) then begin
         BreakApart ( LFeat, '.', FCapabilities );
      end else begin
        LBuf := '<'+LFeat+'>';
      end;
      //LBuf is now for the APOP3 like Challenge
      LBuf := Trim(LBuf);
    end;
    SendCmd('CLIENT '+FClient); {do not localize}
    if FAuthType = datDefault then begin
      if IsCapaSupported('auth') then begin {do not localize}
        // RLebeau: why does this require FIPS?
        if GetFIPSMode and (FPassword <> '') and (FUserName <> '') then begin
          LMD5 := TIdHashMessageDigest5.Create;
          try
            S := LowerCase(LMD5.HashStringAsHex(LBuf+Password));
          finally
            LMD5.Free;
          end;//try
          SendCmd('AUTH ' + Username + ' ' + S, 230); {do not localize}
        end;
      end;
    end else begin
      FSASLMechanisms.LoginSASL('SASLAUTH',FHost, 'dict', ['230'], ['330'], Self, FCapabilities, ''); {do not localize}
    end;
    if FTryMIME and IsCapaSupported('MIME') then begin {do not localize}
      SendCmd('OPTION MIME'); {do not localize}
    end;
  except
    Disconnect(False);
    raise;
  end;
end;

procedure TIdDICT.Define(const AWord, ADBName : String; AResults : TIdDefinitions);
var LDef : TIdDefinition;
  LBuf : String;
begin
  AResults.BeginUpdate;
  try
    AResults.Clear;
    SendCmd('DEFINE '+ ADBName + ' ' + AWord); {do not localize}
    repeat
      if (LastCmdResult.NumericCode div 100) = 1 then begin
        //Good, we got a response
        LBuf := LastCmdResult.Text[0];
        case LastCmdResult.NumericCode of
          151 :
          begin
            LDef := AResults.Add;
            //151 "Stuart" wn "WordNet (r) 2.0"
            IOHandler.Capture(LDef.Definition);
            //Word
            Fetch(LBuf,'"');
            LDef.Word := Fetch(LBuf,'"');
            //db Name
            Fetch(LBuf);
            LDef.DB.Name := Fetch(LBuf);
            //DB Description
            Fetch(LBuf,'"');
            LDef.DB.Desc := Fetch(LBuf,'"');
          end;
          150 :
          begin
            // not sure what to do with the number
            //get the defintions
          end;
        end;
        Self.GetInternalResponse;
      end else begin
        Break;
      end;
    until False;
  finally
    AResults.EndUpdate;
  end;
end;

procedure TIdDICT.Define(const AWord : String; AResults : TIdDefinitions; const AGetAll : Boolean = True);
begin
  if AGetAll then begin
    Define(AWord,'*',AResults);
  end else begin
    Define(AWord,'!',AResults);
  end;
end;

destructor TIdDICT.Destroy;
begin
  FreeAndNil(FSASLMechanisms);
  FreeAndNil(FCapabilities);
  inherited Destroy;
end;

procedure TIdDICT.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', 221);    {Do not Localize}
end;

procedure TIdDICT.GetDBList(ADB: TIdDBList);
begin
  InternalGetList('SHOW DB', ADB); {do not localize}
end;

procedure TIdDICT.GetDictInfo(const ADict: String; AResults: TStrings);
begin
  InternalGetStrs('SHOW INFO ' + ADict, AResults); {do not localize}
end;

procedure TIdDICT.GetStrategyList(AStrats: TIdStrategyList);
begin
  InternalGetList('SHOW STRAT', AStrats); {do not localize}
end;

procedure TIdDICT.GetSvrInfo(AResults: TStrings);
begin
  InternalGetStrs('SHOW SERVER', AResults); {do not localize}
end;

procedure TIdDICT.InitComponent;
begin
  inherited InitComponent;
  FCapabilities := TStringList.create;
  FSASLMechanisms := TIdSASLEntries.Create(Self);
  FPort := IdPORT_DICT;
  FAuthType := DICT_AUTHDEF;
  FHost := 'dict.org'; {do not localize}
  FClient := IndyFormat(DEF_CLIENT_FMT, [gsIdVersion]);
end;

procedure TIdDICT.InternalGetList(const ACmd: String; AENtries: TCollection);
var
  LEnt : TIdGeneric;
  LS : TStrings;
  i : Integer;
  s : String;
begin
  AEntries.BeginUpdate;
  try
    AEntries.Clear;
    LS := TStringList.Create;
    try
      InternalGetStrs(ACmd,LS);
      for i := 0 to LS.Count - 1 do begin
        LEnt := AENtries.Add as TIdGeneric;
        s := LS[i];
        LEnt.Name := Fetch(s);
        Fetch(s, '"');
        LEnt.Desc := Fetch(s, '"');
      end;
    finally
      FreeAndNil(LS);
    end;
  finally
    AEntries.EndUpdate;
  end;
end;

procedure TIdDICT.InternalGetStrs(const ACmd: String; AStrs: TStrings);
begin
  AStrs.BeginUpdate;
  try
    AStrs.Clear;
    SendCmd(ACmd);
    if (LastCmdResult.NumericCode div 100) = 1 then begin
      IOHandler.Capture(AStrs);
      GetInternalResponse;
    end;
  finally
    AStrs.EndUpdate;
  end;
end;

function TIdDICT.IsCapaSupported(const ACapa: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to FCapabilities.Count-1 do begin
    Result := TextIsSame(ACapa, FCapabilities[i]);
    if Result then begin
      Break;
    end;
  end;
end;

procedure TIdDICT.Match(const AWord, ADBName, AStrat: String;
  AResults: TIdMatchList);
var
  LS : TStrings;
  i : Integer;
  s : String;
  LM : TIdMatchItem;
begin
  AResults.BeginUpdate;
  try
    AResults.Clear;
    LS := TStringList.Create;
    try
      InternalGetStrs('MATCH '+ADBName+' '+AStrat+' '+AWord,LS); {do not localize}
      for i := 0 to LS.Count -1 do begin
        s := LS[i];
        LM := AResults.Add;
        LM.DB := Fetch(s);
        Fetch(s, '"');
        LM.Word := Fetch(s, '"');
      end;
    finally
      FreeAndNil(LS);
    end;
  finally
    AResults.EndUpdate;
  end;
end;

procedure TIdDICT.Match(const AWord, AStrat: String;
  AResults: TIdMatchList; const AGetAll: Boolean);
begin
  if AGetAll then begin
    Match(AWord,'*','.',AResults);
  end else begin
    Match(AWord,'!','.',AResults);
  end;
end;

procedure TIdDICT.Match(const AWord: String; AResults: TIdMatchList;
  const AGetAll: Boolean);
begin
  Match(AWord,'.',AResults,AGetAll);
end;

procedure TIdDICT.SetClient(const AValue: String);
//RFC 2229 says that a CLIENT command should always be
//sent immediately after connection.
begin
  if AValue <> '' then begin
    FClient := AValue;
  end;
end;

end.
