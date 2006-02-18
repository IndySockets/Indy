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
  Rev 1.5    10/26/2004 11:08:04 PM  JPMugaas
  Updated refs.

  Rev 1.4    2004.02.03 5:43:54 PM  czhower
  Name changes

  Rev 1.3    2/1/2004 3:33:46 AM  JPMugaas
  Reenabled.  SHould work in DotNET.

  Rev 1.2    1/21/2004 3:11:12 PM  JPMugaas
  InitComponent

  Rev 1.1    2003.10.12 4:03:58 PM  czhower
  compile todos

  Rev 1.0    11/13/2002 07:55:32 AM  JPMugaas

  2000-Dec-22 Kudzu
    -Changed from a TTimer to a sleeping thread to eliminate the reference to ExtCtrls. This was the
    only unit in all of Indy that used this unit and caused the pkg to rely on extra pkgs.
    -Changed Enabled to Active to be more consistent
    -Active now also defaults to false to be more consistent

  2000-MAY-10 Hadi Hariri
    -Added new feature to Force Check of status

  2000-Apr-23 Hadi Hariri
    -Converted to Indy

  2000-Mar-01 Johannes Berg <johannes@sipsolutions.com>
    - new property HistoryFilename
    - new property MaxHistoryEntries
    - new property HistoryEnabled

  2000-Jan-13 MTL
    -Moved to new Palette Scheme (Winshoes Misc)
}

unit IdIPWatch;

{
  Simple component determines Online status,
  returns current IP address, and (optionally) keeps history on
  IP's issued.

  Original Author: Dave Nosker - AfterWave Technologies (allbyte@jetlink.net)
}

interface

uses
  IdComponent, IdThread, IdObjs;

const
  IP_WATCH_HIST_MAX = 25;
  IP_WATCH_HIST_FILENAME = 'iphist.dat';    {Do not Localize}
  IP_WATCH_INTERVAL = 1000;

type
  TIdIPWatchThread = class(TIdThread)
  protected
    FInterval: Integer;
    FSender: TObject;
    FTimerEvent: TIdNotifyEvent;
    //
    procedure Run; override;
    procedure TimerEvent;
  end;

  TIdIPWatch = class(TIdComponent)
  protected
    FActive: Boolean;
    FCurrentIP: string;
    FHistoryEnabled: Boolean;
    FHistoryFilename: string;
    FIPHistoryList: TIdStringList;
    FIsOnline: Boolean;
    FLocalIPHuntBusy: Boolean;
    FMaxHistoryEntries: Integer;
    FOnLineCount: Integer;
    FOnStatusChanged: TIdNotifyEvent;
    FPreviousIP: string;
    FThread: TIdIPWatchThread;
    FWatchInterval: Cardinal;
    //
    procedure AddToIPHistoryList(Value: string);
    procedure CheckStatus(Sender: TObject);
    procedure SetActive(Value: Boolean);
    procedure SetMaxHistoryEntries(Value: Integer);
    procedure SetWatchInterval(Value: Cardinal);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    function ForceCheck: Boolean;
    procedure LoadHistory;
    function LocalIP: string;
    procedure SaveHistory;
    //
    property CurrentIP: string read FCurrentIP;
    property IPHistoryList: TIdStringList read FIPHistoryList;
    property IsOnline: Boolean read FIsOnline;
    property PreviousIP: string read FPreviousIP;
  published
    property Active: Boolean read FActive write SetActive;
    property HistoryEnabled: Boolean read FHistoryEnabled write FHistoryEnabled default True;
    property HistoryFilename: string read FHistoryFilename write FHistoryFilename;
    property MaxHistoryEntries: Integer read FMaxHistoryEntries write SetMaxHistoryEntries
     default IP_WATCH_HIST_MAX;
    property OnStatusChanged: TIdNotifyEvent read FOnStatusChanged write FOnStatusChanged;
    property WatchInterval: Cardinal read FWatchInterval write SetWatchInterval
     default IP_WATCH_INTERVAL;
  end;

implementation

uses
  IdGlobal, IdStack, IdSys;

{ TIdIPWatch }

procedure TIdIPWatch.AddToIPHistoryList(Value: string);
begin
  if (Value = '') or (Value = '127.0.0.1') then    {Do not Localize}
  begin
    Exit;
  end;

  // Make sure the last entry does not allready contain the new one...
  if FIPHistoryList.Count > 0 then
  begin
    if FIPHistoryList[FIPHistoryList.Count-1] = Value then
    begin
      Exit;
    end;
  end;

  FIPHistoryList.Add(Value);
  if FIPHistoryList.Count > MaxHistoryEntries then
  begin
    FIPHistoryList.Delete(0);
  end;
end;

procedure TIdIPWatch.CheckStatus(Sender: TObject);
var
  WasOnLine: Boolean;
  OldIP: string;
begin
  try
    if FLocalIPHuntBusy then
    begin
      Exit;
    end;
    WasOnLine := FIsOnline;
    OldIP := FCurrentIP;
    FCurrentIP := LocalIP;
    FIsOnline := (FCurrentIP <> '127.0.0.1') and (FCurrentIP <> '');    {Do not Localize}

    if (WasOnline) and (not FIsOnline) then
    begin
      if (OldIP <> '127.0.0.1') and (OldIP <> '') then    {Do not Localize}
      begin
        FPreviousIP := OldIP;
      end;
      AddToIPHistoryList(FPreviousIP);
    end;

    if (not WasOnline) and (FIsOnline) then
    begin
      if FOnlineCount = 0 then
      begin
        FOnlineCount := 1;
      end;
      if FOnlineCount = 1 then
      begin
        if FPreviousIP = FCurrentIP then
        begin
          // Del last history item...
          if FIPHistoryList.Count > 0 then
          begin
            FIPHistoryList.Delete(FIPHistoryList.Count-1);
          end;
          // Change the Previous IP# to the remaining last item on the list
          // OR to blank if none on list.
          if FIPHistoryList.Count > 0 then
          begin
            FPreviousIP :=  FIPHistoryList[FIPHistoryList.Count-1];
          end
          else
          begin
            FPreviousIP := '';    {Do not Localize}
          end;
        end;
      end;
      FOnlineCount := 2;
    end;

    if ((WasOnline) and (not FIsOnline)) or ((not WasOnline) and (FIsOnline)) then
    begin
      if (not IsDesignTime) and Assigned(FOnStatusChanged) then
      begin
        FOnStatusChanged(Self);
      end;
    end;
  except
  end;
end;

procedure TIdIPWatch.InitComponent;
begin
  inherited;
  FIPHistoryList := TIdStringList.Create;
  FIsOnLine := False;
  FOnLineCount := 0;
  FWatchInterval := IP_WATCH_INTERVAL;
  FActive := False;
  FPreviousIP := '';    {Do not Localize}
  FLocalIPHuntBusy := False;
  FHistoryEnabled:= True;
  FHistoryFilename:= IP_WATCH_HIST_FILENAME;
  FMaxHistoryEntries:= IP_WATCH_HIST_MAX;
end;

destructor TIdIPWatch.Destroy;
begin
  if FIsOnLine then begin
    AddToIPHistoryList(FCurrentIP);
  end;
  Active := False;
  SaveHistory;
  FIPHistoryList.Free;
  inherited;
end;

function TIdIPWatch.ForceCheck: Boolean;
begin
  // Forces a check and doesn't wait for the timer to fire.    {Do not Localize}
  // It will return true if online.
  CheckStatus(nil);
  Result := FIsOnline;
end;

procedure TIdIPWatch.LoadHistory;
begin
  if not IsDesignTime then begin
    FIPHistoryList.Clear;
    if (Sys.FileExists(FHistoryFilename)) and (FHistoryEnabled) then
    begin
      FIPHistoryList.LoadFromFile(FHistoryFileName);
      if FIPHistoryList.Count > 0 then
      begin
        FPreviousIP := FIPHistoryList[FIPHistoryList.Count-1];
      end;
    end;
  end;
end;

function TIdIPWatch.LocalIP: string;
begin
  FLocalIpHuntBusy := True;
  try
    Result := GStack.LocalAddress;
  finally
    FLocalIPHuntBusy := False;
  end;
end;

procedure TIdIPWatch.SaveHistory;
begin
  if (not IsDesignTime) and FHistoryEnabled then begin
    FIPHistoryList.SaveToFile(FHistoryFilename);
  end;
end;

procedure TIdIPWatch.SetActive(Value: Boolean);
begin
  if Value <> FActive then begin
    FActive := Value;
    if not IsDesignTime then begin
      if FActive then begin
        FThread := TIdIPWatchThread.Create;
        with FThread do begin
          FSender := Self;
          FTimerEvent := CheckStatus;
          FInterval := FWatchInterval;
          Start;
        end;
      end else begin
        FThread.TerminateAndWaitFor;
        Sys.FreeAndNil(FThread);
      end;
    end;
  end;
end;

procedure TIdIPWatch.SetMaxHistoryEntries(Value: Integer);
begin
  FMaxHistoryEntries:= Value;
  while FIPHistoryList.Count > MaxHistoryEntries do // delete the oldest...
    FIPHistoryList.Delete(0);
end;

procedure TIdIPWatch.SetWatchInterval(Value: Cardinal);
begin
  if Value <> FWatchInterval then begin
    FWatchInterval := Value;
  end;

  // might be necessary even if its the same, for example
  // when loading (not 100% sure though)
  if Assigned(FThread) then begin
    FThread.FInterval := FWatchInterval;
  end;
end;

{ TIdIPWatchThread }

procedure TIdIPWatchThread.Run;
var
  LInterval: Integer;
begin
  LInterval := FInterval;
  while LInterval > 0 do begin
    if LInterval > 500 then begin
      Sleep(500);
      LInterval := LInterval - 500;
    end else begin
      Sleep(LInterval);
      LInterval := 0;
    end;
    if Terminated then begin
      exit;
    end;
    Synchronize(TimerEvent);
  end;
end;

procedure TIdIPWatchThread.TimerEvent;
begin
  FTimerEvent(FSender);
end;

end.
