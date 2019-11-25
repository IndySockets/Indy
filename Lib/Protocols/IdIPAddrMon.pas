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
  Rev 1.7    10/26/2004 10:20:04 PM  JPMugaas
  Updated refs.

  Rev 1.6    2004.02.03 5:45:14 PM  czhower
  Name changes

  Rev 1.5    1/31/2004 1:18:40 PM  JPMugaas
  Illiminated Todo; item so it should work in DotNET.

  Rev 1.4    1/21/2004 3:11:04 PM  JPMugaas
  InitComponent

    Rev 1.3    10/19/2003 4:51:34 PM  DSiders
  Added localization comments.

  Rev 1.2    2003.10.12 3:53:12 PM  czhower
  compile todos

    Rev 1.1    3/5/2003 11:41:14 PM  BGooijen
  Added IdCoreGlobal to the uses, this file was needed for the call to
  Sleep(...)

    Rev 1.0    12/28/2002 3:04:52 PM  DSiders
  Initial revision.
}

unit IdIPAddrMon;

{
  TIdIPAddrMon

  Monitors adapters known to the IP protocol stack for changes in any
  of the IP addresses.  Similar to TIdIPWatch, but monitors all IP
  addresses/adapters.

  Does not keep a permanent IP address history list.  But does trigger
  a TIdIPAddrMonEvent event to signal the adapter number, old IP, and
  new IP for the change in status.

  OnStatusChanged is used to capture changed IP addresses, and/or
  to sync with GUI display controls.  If you do not assign a procedure
  for the event handler, this component essentially does nothing except
  eat small amounts of CPU time.

  The thread instance is created and freed when the value in Active is
  changed.

  TIdIPAddrMonEvent

  An procedure use to handle notifications from the component. Includes
  parameters that represent the adapter number, previous IP or '<unknown>',
  and the current IP or '<unknown>'.

  TIdIPAddrMonThread

  Timer thread for the IP address monitor component.  Based on
  TIdIPWatchThread.

  Sleeps in increments of .5 seconds until the Interval has elapsed, and
  fires the timer event.  Sleep is called in increments to allow checking
  for Terminated when a long Interval has been specified.

  Original Author:

  Don Siders, Integral Systems, Fri 27 Dec 2002

  Donated to the Internet Direct (Indy) Project for use under the
  terms of the Indy Dual License.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdComponent,
  IdThread;

const
  IdIPAddrMonInterval = 500;

type
  TIdIPAddrMonEvent = procedure(ASender: TObject; AAdapter: Integer; AOldIP, ANewIP: string) of object;

  TIdIPAddrMonThread = class(TIdThread)
  protected
    FInterval: UInt32;
    FOnTimerEvent: TNotifyEvent;

    procedure Run; override;
    procedure DoTimerEvent;
  end;

  TIdIPAddrMon = class(TIdComponent)
  private
    FActive: Boolean;
    FBusy: Boolean;
    FInterval: UInt32;
    FAdapterCount: Integer;
    FThread: TIdIPAddrMonThread;
    // TODO: replace these with TIdStackLocalAddressList
    FIPAddresses: TStrings;
    FPreviousIPAddresses: TStrings;
    FOnStatusChanged: TIdIPAddrMonEvent;

    procedure SetActive(Value: Boolean);
    procedure SetInterval(Value: UInt32);
    procedure GetAdapterAddresses;
    procedure DoStatusChanged;

  protected
    procedure InitComponent; override;
    procedure Loaded; override;

  public
    destructor Destroy; override;
    procedure CheckAdapters(Sender: TObject);
    procedure ForceCheck;

    property AdapterCount: Integer read FAdapterCount;
    property Busy: Boolean read FBusy;
    property IPAddresses: TStrings read FIPAddresses;
    property Thread: TIdIPAddrMonThread read FThread;

  published
    property Active: Boolean read FActive write SetActive;
    property Interval: UInt32 read FInterval write SetInterval default IdIPAddrMonInterval;
    property OnStatusChanged: TIdIPAddrMonEvent read FOnStatusChanged write FOnStatusChanged;
  end;

implementation

uses
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.Threading,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysTime,
  {$ENDIF}
  IdStack,
  SysUtils;

procedure TIdIPAddrMon.InitComponent;
begin
  inherited InitComponent;

  FInterval := IdIPAddrMonInterval;
  FActive := False;
  FBusy := False;
  FAdapterCount := 0;

  // TODO: replace these with TIdStackLocalAddressList
  FIPAddresses := TStringList.Create;
  FPreviousIPAddresses := TStringList.Create;

  // FThread created when component becomes Active
end;

destructor TIdIPAddrMon.Destroy;
begin
  Active := False;
  FBusy := False;

  FIPAddresses.Free;
  FPreviousIPAddresses.Free;

  // FThread freed on Terminate

  inherited Destroy;
end;

procedure TIdIPAddrMon.Loaded;
begin
  inherited Loaded;
  // Active = True must not be performed before all other props are loaded
  if Active then begin
    FActive := False;
    Active := True;
  end;
end;

procedure TIdIPAddrMon.CheckAdapters(Sender: TObject);
begin
  // previous check could still be running...
  if FBusy then begin
    Exit;
  end;

  FBusy := True;
  try
    try
      GetAdapterAddresses;

      if IsDesignTime then begin
        Exit;
      end;

      // TODO: replace with TIdStackLocalAddressList
      {
      LChanged := FPreviousIPAddresses.Count <> FIPAddresses.Count;
      if not LChanged then
      begin
        for I := 0 to FIPAddresses.Count-1 do begin
          LChanged := FPreviousIPAddresses[I].IPAddress.Count <> FIPAddresses[I].IPAddress;
          if LChanged then begin
            Break;
          end;
        end;
      end;

      if LChanged then begin
        // something changed at runtime
        DoStatusChanged;
      end;
      }

      if (FPreviousIPAddresses.Count <> FIPAddresses.Count) or
         (FPreviousIPAddresses.Text <> FIPAddresses.Text) then
      begin
        // something changed at runtime
        DoStatusChanged;
      end;
    except
      // eat any exception
    end;
  finally
    FBusy := False;
  end;
end;

procedure TIdIPAddrMon.DoStatusChanged;
var
  iOldCount: Integer;
  iNewCount: Integer;
  iAdapter: Integer;
  sOldIP: string;
  sNewIP: string;
begin

  if not Assigned(FOnStatusChanged) then
  begin
    Exit;
  end;

  // figure out the change... new, removed, or altered IP for adapter(s)
  iOldCount := FPreviousIPAddresses.Count;
  iNewCount := FIPAddresses.Count;

  // find the new adapter IP address
  if iOldCount < iNewCount then
  begin
    sOldIP := '<unknown>';  {do not localize}

    for iAdapter := 0 to iNewCount - 1 do
    begin
      // TODO: replace with TIdStackLocalAddressList
      {
      sNewIP := FIPAddresses[iAdapter].IPAddress;

      if FPreviousIPAddresses.IndexOfIP(sNewIP, FIPAddresses[iAdapter].IPVersion) = -1 then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
      }

      sNewIP := FIPAddresses[iAdapter];

      if FPreviousIPAddresses.IndexOf(sNewIP) = -1 then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
    end;
  end

  // find the missing adapter IP address
  else if iOldCount > iNewCount then
  begin
    sNewIP := '<unknown>';  {do not localize}

    for iAdapter := 0 to iOldCount - 1 do
    begin
      // TODO: replace with TIdStackLocalAddressList
      {
      sOldIP := FPreviousIPAddresses[iAdapter].IPAddress;

      if FIPAddresses.IndexOfIP(sOldIP, FPreviousIPAddresses[iAdapter].IPVersion) = -1 then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
      }

      sOldIP := FPreviousIPAddresses[iAdapter];

      if FIPAddresses.IndexOf(sOldIP) = -1 then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
    end;
  end

  // find the altered adapter IP address
  else
  begin
    for iAdapter := 0 to AdapterCount - 1 do
    begin
      // TODO: replace with TIdStackLocalAddressList
      {
      sOldIP := FPreviousIPAddresses[iAdapter].IPAddress;
      sNewIP := FIPAddresses[iAdapter].IPAddress;

      if (FPreviousIPAddresses[iAdapter].IPVersion <> FIPAddresses[iAdapter].IPVersion) or
         (sOldIP <> sNewIP) then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
      }

      sOldIP := FPreviousIPAddresses[iAdapter];
      sNewIP := FIPAddresses[iAdapter];

      if sOldIP <> sNewIP then
      begin
        FOnStatusChanged(Self, iAdapter, sOldIP, sNewIP);
      end;
    end;
  end;

end;

procedure TIdIPAddrMon.ForceCheck;
begin
  CheckAdapters(nil);
end;

procedure TIdIPAddrMon.SetActive(Value: Boolean);
begin
  if Value <> FActive then
  begin
    if Value then
    begin
      // get initial addresses at start-up and allow display in IDE
      GetAdapterAddresses;
    end;
    if (not IsDesignTime) and (not IsLoading) then
    begin
      if Value then
      begin
        FThread := TIdIPAddrMonThread.Create(True);
        FThread.FOnTimerEvent := CheckAdapters;
        FThread.FInterval := Self.Interval;
        FThread.Start;
      end
      else if FThread <> nil then begin
        FThread.TerminateAndWaitFor;
        FreeAndNil(FThread);
      end;
    end;
    FActive := Value;
  end;
end;

procedure TIdIPAddrMon.SetInterval(Value: UInt32);
begin
  FInterval := Value;
  if Assigned(FThread) then begin
    FThread.FInterval := FInterval;
  end;
end;

procedure TIdIPAddrMonThread.Run;
var
  lInterval: Integer;
begin
  lInterval := FInterval;
  while lInterval > 0 do
  begin
    // force a check for terminated every .5 sec
    if lInterval > 500 then
    begin
      IndySleep(500);
      lInterval := lInterval - 500;
    end else
    begin
      IndySleep(lInterval);
      LInterval := 0;
    end;
    if Terminated then
    begin
      Exit;
    end;
  end;

  // interval has elapsed... fire the thread timer event
  Synchronize(DoTimerEvent);
end;

procedure TIdIPAddrMonThread.DoTimerEvent;
begin
  if Assigned(FOnTimerEvent) then begin
    FOnTimerEvent(Self);
  end;
end;

procedure TIdIPAddrMon.GetAdapterAddresses;
var
  LAddresses: TIdStackLocalAddressList;
  I: Integer;
begin
  {
    Doesn't keep a permanent history list like TIdIPWatch...
    but does track previous IP addresses to detect changes.
  }

  FPreviousIPAddresses.Assign(FIPAddresses);
  FIPAddresses.Clear;

  LAddresses := TIdStackLocalAddressList.Create;
  try
    GStack.GetLocalAddressList(LAddresses);
    for I := 0 to LAddresses.Count-1 do begin
      FIPAddresses.Add(LAddresses[I].IPAddress);
    end;
  finally
    LAddresses.Free;
  end;

  FAdapterCount := FIPAddresses.Count;
end;

end.
