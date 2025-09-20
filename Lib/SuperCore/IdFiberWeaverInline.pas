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
  Rev 1.2    6/11/2004 8:39:52 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.1    2004.02.09 9:16:38 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:38:52 AM  czhower
  Move

  Rev 1.2    2003.11.04 3:51:20 PM  czhower
  Update to sync TC

  Rev 1.1    2003.10.21 12:19:22 AM  czhower
  TIdTask support and fiber bug fixes.

  Rev 1.0    2003.10.19 2:50:54 PM  czhower
  Fiber cleanup

  Rev 1.4    2003.10.19 1:04:26 PM  czhower
  Updates

  Rev 1.3    2003.10.11 5:43:20 PM  czhower
  Chained servers now functional.

  Rev 1.2    2003.09.19 10:09:40 PM  czhower
  Next stage of fiber support in servers.

  Rev 1.1    2003.08.20 1:46:22 PM  czhower
  Update to compile.

  Rev 1.0    8/16/2003 11:09:12 AM  JPMugaas
  Moved from Indy Core dir as part of package reorg

  Rev 1.8    7/26/2003 12:20:02 PM  BGooijen
  Small fix to prevent some exceptions

  Rev 1.7    2003.06.30 7:33:50 PM  czhower
  Fix to exception handling.

  Rev 1.6    2003.06.25 1:25:58 AM  czhower
  Small changes.

  Rev 1.4    2003.06.03 11:05:02 PM  czhower
  Modified ProcessInThisFiber to support error flag return.

  Rev 1.3    2003.04.17 7:44:58 PM  czhower

  Rev 1.2    4/11/2003 6:37:38 PM  BGooijen
  ProcessInThisFiber and WaitForFibers are now overridden here

  Rev 1.1    2003.04.10 10:51:06 PM  czhower

  Rev 1.14    3/27/2003 12:34:02 PM  BGooijen
  very little clean-up

  Rev 1.13    2003.03.27 1:31:18 AM  czhower
  Removal of hack cast.

  Rev 1.12    2003.03.27 1:29:16 AM  czhower
  Exception frame swapping.

  Rev 1.11    2003.03.27 12:45:58 AM  czhower
  Fixed AV relating to preparation changes for exception frame swapping

  Rev 1.10    2003.03.27 12:18:06 AM  czhower

  Rev 1.9    3/26/2003 8:37:50 PM  BGooijen
  Added WaitForFibers

  Rev 1.8    2003.03.26 12:48:30 AM  czhower

  Rev 1.7    3/25/2003 01:58:20 PM  JPMugaas
  Fixed a type-error.

  Rev 1.6    3/25/2003 01:27:56 AM  JPMugaas
  Made a custom exception class that descends from EIdSIlentException so that
  the component does not always raise an exception in the server if there's no
  client connection.

  Rev 1.5    2003.03.16 12:49:32 PM  czhower

  Rev 1.4    3/13/2003 10:18:14 AM  BGooijen
  Server side fibers, bug fixes

  Rev 1.3    12-15-2002 17:08:00  BGooijen
  Removed  AssignList, and added a hack-cast to use .Assign

  Rev 1.2    2002.12.07 11:10:30 PM  czhower
  Removed unneeded code.

  Rev 1.1    12-6-2002 20:34:10  BGooijen
  Now compiles on Delphi 5

  Rev 1.0    11/13/2002 08:44:26 AM  JPMugaas
}

unit IdFiberWeaverInline;

interface

uses
  Classes, IdException,
  IdGlobal, IdFiber, IdFiberWeaver, IdThreadSafe,
  SyncObjs;

type
  TIdFiberWeaverInline = class;

  TIdFiberNotifyEvent = procedure(AFiberWeaver: TIdFiberWeaverInline;
   AFiber: TIdFiberBase) of object;

  TIdFiberWeaverInline = class(TIdFiberWeaver)
  protected
    // TIdThreadSafeInteger cannot be used for FActiveFiberList because the
    // semantics cause the first fiber to be counted more than once during
    // finish, and possibly other fibers as well. The only other solution
    // involves using TIdFiber itself, and that would cause changes to TIdFiber
    // that would be made only for the accomodation of TIdFiberWeaverInline.
    //
    // As it is TIdFiber itself has no knowledge ot TIdFiberWeaverInline.
    //
    // FActiveFiberList is used by ProcessInThisThread to detect when all fibers
    // have finished.
    FActiveFiberList: TIdThreadSafeList;
    FAddEvent: TEvent;
    // FActiveFiberList contains a list of fibers to schedule. Fibers are
    // removed when they are running or are suspened. When a fiber is ready to
    // excecuted again it is added to FActiveFiberList and the fiber weaver will
    // schedule it.
    FFiberList: TIdThreadSafeList;
    FFreeFibersOnCompletion: Boolean;
    FOnIdle: TNotifyEvent;
    FOnSwitch: TIdFiberNotifyEvent;
    FSelfFiber: TIdConvertedFiber;
    //
    procedure DoIdle;
    procedure DoSwitch(AFiber: TIdFiberBase); virtual;
    procedure InitComponent; override;
    procedure Relinquish(
      AFiber: TIdFiber;
      AReschedule: Boolean
      ); override;
    procedure ScheduleFiber(
      ACurrentFiber: TIdFiberBase;
      ANextFiber: TIdFiber
      );
  public
    procedure Add(AFiber: TIdFiber); override;
    destructor Destroy; override;
    function HasFibers: Boolean;
    function ProcessInThisThread: Boolean;
    function WaitForFibers(
      ATimeout: Cardinal = Infinite
      ): Boolean;
      override;
  published
    property FreeFibersOnCompletion: Boolean read FFreeFibersOnCompletion
      write FFreeFibersOnCompletion;
    //
    property OnIdle: TNotifyEvent read FOnIdle write FOnIdle;
    property OnSwitch: TIdFiberNotifyEvent read FOnSwitch write FOnSwitch;
  end;
  EIdNoFibersToSchedule = class(EIdSilentException);

implementation

uses
  SysUtils,
  Windows;

{ TIdFiberWeaverInline }

procedure TIdFiberWeaverInline.Add(AFiber: TIdFiber);
begin
  inherited;
  AFiber.SetRelinquishHandler(Relinquish);
  with FFiberList.LockList do try
    Add(AFiber);
    FAddEvent.SetEvent;
  finally FFiberList.UnlockList; end;
end;

destructor TIdFiberWeaverInline.Destroy;
begin
  FreeAndNil(FActiveFiberList);
  FreeAndNil(FFiberList);
  FreeAndNil(FAddEvent);
  inherited;
end;

procedure TIdFiberWeaverInline.DoIdle;
begin
  if Assigned(FOnIdle) then begin
    FOnIdle(Self);
  end;
end;

procedure TIdFiberWeaverInline.DoSwitch(AFiber: TIdFiberBase);
begin
  if Assigned(FOnSwitch) then begin
    FOnSwitch(Self, AFiber);
  end;
end;

function TIdFiberWeaverInline.HasFibers: Boolean;
begin
  Result := not FFiberList.IsCountLessThan(1);
end;

procedure TIdFiberWeaverInline.InitComponent;
begin
  inherited;
  FActiveFiberList := TIdThreadSafeList.Create;
  FAddEvent := TEvent.Create(nil, False, False, '');
  FFiberList := TIdThreadSafeList.Create;
end;

function TIdFiberWeaverInline.ProcessInThisThread: Boolean;
// Returns true if ANY fiber terminated because of an unhandled exception.
// If false, user does not need to loop through the fibers to look.
var
  LFiber: TIdFiber;
  LFiberList: TList;
begin
  Result := False;
  LFiberList := FFiberList.LockList; try
    if LFiberList.Count = 0 then begin
      raise EIdNoFibersToSchedule.Create('No fibers to schedule.'); {do not localize}
    end;
    FActiveFiberList.Assign(LFiberList);
  finally FFiberList.UnlockList; end;
  // This loop catches fibers as they finish. Relinquish accomplishes explicit
  // switching faster by performing only one switch instead of two.
  FSelfFiber := TIdConvertedFiber.Create; try
    while True do begin
      LFiber := TIdFiber(FFiberList.Pull);
      if LFiber = nil then begin
        if FActiveFiberList.IsEmpty then begin
          // All fibers finished
          Break;
        end else begin
          FAddEvent.WaitFor(Infinite);
        end;
      end else begin
        // So it will switch back here when finished so other fibers can be
        // processed.
        LFiber.ParentFiber := FSelfFiber;
        //
        ScheduleFiber(FSelfFiber, LFiber);
        // if any fiber terminated with a fatal exception return true
        // Dont set it to it, else false would reset it.
        if FSelfFiber.PriorFiber is TIdFiber then begin
          LFiber := TIdFiber(FSelfFiber.PriorFiber);
          if LFiber.FatalExceptionOccurred then begin
            Result := True;
          end;
          // Finished fibers always switch back to parent and will not short
          // circuit schedule
          if LFiber.Finished then begin
            FActiveFiberList.Remove(LFiber);
            if FreeFibersOnCompletion then begin
              FreeAndNil(LFiber);
            end;
          end;
        end;
      end;
    end;
  finally FreeAndNil(FSelfFiber); end;
end;

procedure TIdFiberWeaverInline.Relinquish(
  AFiber: TIdFiber;
  AReschedule: Boolean
  );
var
  LFiber: TIdFiber;
begin
  while True do begin
    LFiber := nil;
    // Get next fiber to schedule
    with FFiberList.LockList do try
      if Count > 0 then begin
        LFiber := TIdFiber(List[0]);
        Delete(0);
        if AReschedule then begin
          Add(AFiber);
        end;
      // If no fibers to schedule, we will rerun ourself if set to reschedule
      end else if AReschedule then begin
        // Soft cast as a check that a converted fiber has not been passed
        // with AReschedule = True
        LFiber := AFiber as TIdFiber;
      end;
    finally FFiberList.UnlockList; end;
    if LFiber = nil then begin
      // If there are no fibers to schedule, that means we are waiting on
      // ourself, or another relinquished fiber. Wait for one to get readded
      // to list.
      //
      //TODO: Allow a parameter for timeout and call DoIdle
      //TODO: Better yet - integrate with AntiFreeze also
      DoIdle;
      FAddEvent.WaitFor(Infinite);
    end else if LFiber = AFiber then begin
      // If the next fiber is ourself, simply exit to return to ourself
      Break;
    end else if LFiber <> nil then begin
      // Must set the parent fiber to self so that when it finishes we get
      // control again. The main ProcessInThisThread loop does this, but
      // only for ones it first starts. Fibers can get added to the list and
      // then scheduled here in this short circuit switch. When they finish
      // they will have no parent fiber.
      LFiber.ParentFiber := FSelfFiber;
      ScheduleFiber(AFiber, LFiber);
      // If we get switched back to, we have been scheduled so exit
      Break;
    end;
  end;
  // For future expansion when can switch between weavers
  AFiber.SetRelinquishHandler(Relinquish);
end;

procedure TIdFiberWeaverInline.ScheduleFiber(
  ACurrentFiber: TIdFiberBase;
  ANextFiber: TIdFiber
  );
begin
  DoSwitch(ANextFiber);
  ACurrentFiber.SwitchTo(ANextFiber);
end;

function TIdFiberWeaverInline.WaitForFibers(
  ATimeout: Cardinal = Infinite
  ): Boolean;
begin
  if not FFiberList.IsEmpty then begin
    Result := True;
  end else begin
    Result := (FAddEvent.WaitFor(ATimeout) = wrSignaled) and not FFiberList.IsEmpty;
  end;
end;

end.
