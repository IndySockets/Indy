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
  Rev 1.3    6/11/2004 8:39:48 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.2    2004.04.22 11:45:16 PM  czhower
  Bug fixes

  Rev 1.1    2004.02.09 9:16:34 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:38:48 AM  czhower
  Move

  Rev 1.8    2003.10.24 1:00:04 PM  czhower
  Name change

  Rev 1.7    2003.10.21 12:19:20 AM  czhower
  TIdTask support and fiber bug fixes.

  Rev 1.6    2003.10.19 2:50:38 PM  czhower
  Fiber cleanup

  Rev 1.5    2003.10.19 1:04:26 PM  czhower
  Updates

  Rev 1.3    2003.10.11 5:43:12 PM  czhower
  Chained servers now functional.

  Rev 1.2    2003.09.19 10:09:38 PM  czhower
  Next stage of fiber support in servers.

  Rev 1.1    2003.09.19 3:01:34 PM  czhower
  Changed to emulate IdThreads Run behaviour

  Rev 1.0    8/16/2003 11:09:14 AM  JPMugaas
  Moved from Indy Core dir as part of package reorg

  Rev 1.25    7/2/2003 2:06:40 PM  BGooijen
  changed IdSupportsFibers to TIdFiberBase.HaveFiberSupport

  Rev 1.24    7/1/2003 8:34:14 PM  BGooijen
  Added function IdSupportsFibers
  Fiber-functions are now loaded on runtime

  Rev 1.23    2003.06.30 7:33:50 PM  czhower
  Fix to exception handling.

  Rev 1.22    2003.06.30 6:52:20 PM  czhower
  Exposed FiberWeaver has a property.

  Rev 1.21    2003.06.03 11:05:02 PM  czhower
  Modified ProcessInThisFiber to support error flag return.

  Rev 1.20    2003.06.03 8:01:38 PM  czhower
  Completed fiber exception handling.

  Rev 1.19    2003.05.27 10:27:08 AM  czhower
  Put back original exception handling.

  Rev 1.18    5/16/2003 3:48:24 PM  BGooijen
  Added FreeOnTerminate

  Rev 1.17    4/17/2003 7:40:00 PM  BGooijen
  Added AAutoStart for fibers

  Rev 1.16    2003.04.17 7:44:56 PM  czhower

  Rev 1.15    2003.04.14 10:54:08 AM  czhower
  Fiber specific exceptions

  Rev 1.14    2003.04.12 11:53:56 PM  czhower
  Added DoExecute

  Rev 1.13    4/11/2003 1:46:58 PM  BGooijen
  added ProcessInThisFiber and WaitForFibers to TIdFiberWeaverBase

  Rev 1.12    2003.04.10 11:21:42 PM  czhower
  Yield support

  Rev 1.9    2003.03.27 1:29:14 AM  czhower
  Exception frame swapping.

  Rev 1.7    3/22/2003 09:45:28 PM  JPMugaas
  Now should compile under D4.

  Rev 1.6    2003.03.13 1:25:18 PM  czhower
  Moved check for parent fiber to SwitchTo

  Rev 1.5    3/13/2003 10:18:12 AM  BGooijen
  Server side fibers, bug fixes

  Rev 1.4    2003.02.18 1:25:04 PM  czhower
  Added exception if user tries to SwitchTo a completed fiber.

  Rev 1.3    2003.01.17 2:32:12 PM  czhower

  Rev 1.2    1-1-2003 16:25:10  BGooijen
  The property ParentFiber can now be written to
  Added class function TIdFiberBase.GetCurrentFiberBase, which returns the
  current TIdFiber

  Rev 1.1    12-28-2002 12:01:18  BGooijen
  Made a public read only property: ParentFiber

  Rev 1.0    11/13/2002 08:44:18 AM  JPMugaas
}

unit IdFiber;

interface

uses
  Classes,
  IdThreadSafe, IdBaseComponent, IdYarn, IdTask,
  SyncObjs, SysUtils,
  Windows;

type
  // TIdFiberBase is the base for both fiber types and contains
  // methods that are common to both and defines the general interface. All
  // references to fibers should generally use this base type.
  TIdFiberBase = class(TObject)
  protected
    FHandle: Pointer;
    FPriorFiber: TIdFiberBase;
    FName: string;
    FRaiseList: Pointer;
    // No descendants should ever call this. Its internal only
    // and should only be called after destruction or after the RaiseList has
    // been saved
    procedure SwitchToMeFrom(
      AFromFiber: TIdFiberBase
      );
  public
    constructor Create; reintroduce; virtual;
    procedure CheckRunnable; virtual;
    class function HaveFiberSupport: Boolean;
    procedure SwitchTo(AFiber: TIdFiberBase);
    //
    property Name: string read FName write FName;
    property PriorFiber: TIdFiberBase read FPriorFiber;
    property Handle: Pointer read FHandle;
  end;

  TIdFiber = class;
  TIdFiberRelinquishEvent = procedure(
    ASender: TIdFiber;
    AReschedule: Boolean
    ) of object;

  // TIdConvertedFiber is used to represent thread that have been converted to
  // fibers
  TIdConvertedFiber = class(TIdFiberBase)
  public
    constructor Create; override;
  end;

  // TIdFiber is the general purpose fiber. To implement fibers descend from
  // TIdFiber.
  TIdFiber = class(TIdFiberBase)
  protected
    FFatalException: Exception;
    FFatalExceptionOccurred: Boolean;
    FFinished: TIdThreadSafeBoolean;
    FFreeFatalException: Boolean;
    FFreeFiber: Boolean;
    FLoop: Boolean;
    FOnRelinquish: TIdFiberRelinquishEvent;
    FParentFiber: TIdFiberBase;
    FStarted: TIdThreadSafeBoolean;
    FStopped: TIdThreadSafeBoolean;
    FYarn: TIdYarn;
    //
    procedure AfterRun; virtual; //not abstract - otherwise it is required
    procedure BeforeRun; virtual; //not abstract - otherwise it is required
    function GetFinished: Boolean;
    function GetStarted: Boolean;
    function GetStopped: Boolean;
    procedure Execute;
    procedure Run; virtual; abstract;
    procedure SwitchToParent;
  public
    procedure CheckRunnable; override;
    constructor Create(
      AParentFiber: TIdFiberBase = nil;
      ALoop: Boolean = False;
      AStackSize: Integer = 0);
      reintroduce;
    destructor Destroy;
      override;
    procedure RaiseFatalException;
    // Relinquish is used when the fiber is stuck and cannot usefully do
    // anything. It will be removed from scheduling until something reschedules
    // it. This is different than yield.
    //
    // Relinquish is used with FiberWeavers to tell them that the fiber is done
    // or blocked. Something external such as more work, or completion of a task
    // must reschedule the fiber with the fiber weaver.
    procedure Relinquish;
    procedure SetRelinquishHandler(AValue: TIdFiberRelinquishEvent);
    procedure Stop; virtual;
    // Gives up execution time and tells scheduler to process next available
    // fiber.
    // For manual fibers (no weaver) relinquish is called
    // For woven fibers, the fiber is rescheduled and relinquished.
    procedure Yield;
    //
    property FatalExceptionOccurred: Boolean read FFatalExceptionOccurred;
    property Finished: Boolean read GetFinished;
    property Loop: Boolean read FLoop write FLoop;
    property Started: Boolean read GetStarted;
    property Stopped: Boolean read GetStopped;
    property ParentFiber: TIdFiberBase read FParentFiber write FParentFiber;
    property Yarn: TIdYarn read FYarn write FYarn;
  end;

  TIdFiberWithTask = class(TIdFiber)
  protected
    FTask: TIdTask;
  public
    procedure AfterRun; override;
    procedure BeforeRun; override;
    // Defaults because a bit crazy to create a non looped task
    constructor Create(
      AParentFiber: TIdFiberBase = nil;
      ATask: TIdTask = nil;
      AName: string = '';
      AStackSize: Integer = 0
      ); reintroduce;
    destructor Destroy;
      override;
    procedure Run;
      override;
    //
    // Must be writeable because tasks are often created after thread or
    // thread is pooled
    property Task: TIdTask read FTask write FTask;
  end;


implementation

uses
  IdGlobal, IdResourceStringsCore, IdExceptionCore, IdException;

var
  SwitchToFiber: function(lpFiber: Pointer): BOOL; stdcall = nil;
  CreateFiber: function(dwStackSize: DWORD; lpStartAddress: TFNFiberStartRoutine;
    lpParameter: Pointer): BOOL; stdcall=nil;
  DeleteFiber: function (lpFiber: Pointer): BOOL; stdcall = nil;
  ConvertThreadToFiber: function (lpParameter: Pointer): BOOL; stdcall = nil;

procedure LoadFiberFunctions;
var
  LKernel32Handle: THandle;
begin
  if TIdFiberBase.HaveFiberSupport then begin
    LKernel32Handle := GetModuleHandle(kernel32);
    SwitchToFiber := LoadLibFunction(LKernel32Handle,'SwitchToFiber'); {do not localize}
    CreateFiber := LoadLibFunction(LKernel32Handle,'CreateFiber'); {do not localize}
    DeleteFiber := LoadLibFunction(LKernel32Handle,'DeleteFiber'); {do not localize}
    ConvertThreadToFiber := LoadLibFunction(LKernel32Handle,'ConvertThreadToFiber'); {do not localize}
    if Assigned(@SwitchToFiber) and
     Assigned(@CreateFiber) and
     Assigned(@DeleteFiber) and
     Assigned(@ConvertThreadToFiber) then begin
      Exit;
    end else begin
      SwitchToFiber := nil;
      CreateFiber := nil;
      DeleteFiber := nil;
      ConvertThreadToFiber := nil;
    end;
  end;
  raise EIdFibersNotSupported.Create(RSFibersNotSupported);
end;

procedure FiberFunc(AFiber: TIdFiber); stdcall;
var
  LParentFiber: TIdFiberBase;
begin
  with AFiber do begin
    Execute;
    LParentFiber := ParentFiber;
  end;
  // Threads converted from Fibers have no parent. Also use may specify
  // nil if they want to control exit manually.
  //
  // We must do this last because with schedulers fibers get switched away
  // at this last point and not rescheduled. We do this outside the
  // execute as the fiber will likely be freed from somewhere else
  if LParentFiber <> nil then begin
    LParentFiber.SwitchToMeFrom(AFiber);
  end;
end;

{ TIdFiber }

procedure TIdFiber.AfterRun;
begin
end;

procedure TIdFiber.BeforeRun;
begin
end;

procedure TIdFiber.CheckRunnable;
begin
  inherited;
  EIdFiberFinished.IfTrue(Finished, 'Fiber is finished.'); {do not localize}
  EIdFiber.IfTrue((ParentFiber = nil) and (Assigned(FOnRelinquish) = False)
   , 'No parent fiber or fiber weaver specified.'); {do not localize}
end;

constructor TIdFiber.Create(
  AParentFiber: TIdFiberBase;
  ALoop: Boolean;
  AStackSize: Integer
  );
begin
  inherited Create;
  FFinished := TIdThreadSafeBoolean.Create;
  FStarted := TIdThreadSafeBoolean.Create;
  FStopped := TIdThreadSafeBoolean.Create;
  FFreeFiber := True;
  FLoop := ALoop;
  FParentFiber := AParentFiber;
  // Create Fiber
  FHandle := Pointer(CreateFiber(AStackSize, @FiberFunc, Self));
  Win32Check(LongBool(FHandle));
end;

destructor TIdFiber.Destroy;
begin
  EIdException.IfTrue(Started and (Finished = False), 'Fiber not finished.'); {do not localize}
  // Threads converted from Fibers will have nil parents and if we call
  // DeleteFiber it will exit the whole thread.
  if FFreeFiber then begin
    // Must never call from self. If so ExitThread is called
    // Because of this FreeOnTerminate cannot be suported because a fiber
    // cannot delete itself, and we never know where a fiber will go for sure
    // when it is done. It can be done that the next fiber deletes it, but
    // there are catches here too. Because of this I have made it the
    // responsibility of the user (manual) or the scheduler (optional).
    Win32Check(DeleteFiber(FHandle));
  end;
  FreeAndNil(FYarn);
  FreeAndNil(FFinished);
  FreeAndNil(FStarted);
  FreeAndNil(FStopped);
  // Kudzu:
  // Docs say to call ReleaseException, but its empty. But it appears that since
  // we are taking the exception and taking it from the raise list, that instead
  // what we need to do is call .Free on the exception instead and that the docs
  // are wrong. Need to run through a memory checker to verify the behaviour.
  //
  // Normally the except block frees the exception object, but we are stealing
  // it out fo the list, so it does not free it.
  //
  // Ive looked into TThread and this is what it does as well, so big surprise
  // that the docs are wrong.
  //
  // Update: We only free it if we dont reraise the exception. If we reraise it
  // the fiber may be freed in a finally, and thus when the exception is handled
  // again an AV or other will occur because the exception has been freed.
  // When it is reraised, it is added back into the exception list and the
  // VCL will free it as part of the final except block.
  //
  if FFreeFatalException then begin
    FreeAndNil(FFatalException);
  end;
  //
  inherited;
end;

procedure TIdFiber.Execute;
begin
  try
    try
      BeforeRun; try
        // This can be combined, but then it checks loop each run and its not
        // valid to toggle it after run has started and therefore adds an
        // unnecessary check
        if Loop then begin
          while not Stopped do begin
            Run;
            // If Weaver, this will let the weaver reschedule.
            // If manual it will switch back to parent to let it handle it.
            // If stopped just run through so it can clean up and exit
            if not Stopped then begin
              Yield;
            end;
          end;
        end else begin
          Run;
        end;
      finally AfterRun; end;
    except FFatalException := AcquireExceptionObject; end;
    if FFatalException <> nil then begin
      FFatalExceptionOccurred := True;
      FFreeFatalException := True;
    end;
  finally FFinished.Value := True; end;
end;

function TIdFiber.GetFinished: Boolean;
begin
  Result := FFinished.Value;
end;

function TIdFiber.GetStarted: Boolean;
begin
  Result := FStarted.Value;
end;

function TIdFiber.GetStopped: Boolean;
begin
  Result := FStopped.Value;
end;

procedure TIdFiber.RaiseFatalException;
begin
  if FatalExceptionOccurred then begin
    FFreeFatalException := False;
    raise FFatalException;
  end;
end;

procedure TIdFiber.Stop;
begin
  FStopped.Value := True;
end;

procedure TIdFiber.SwitchToParent;
begin
  EIdException.IfNotAssigned(FParentFiber, 'No parent fiber to switch to.'); {do not localize}
  SwitchTo(FParentFiber);
end;

procedure TIdFiber.Relinquish;
begin
  if Assigned(FOnRelinquish) then begin
    FOnRelinquish(Self, False);
  end else begin
    SwitchToParent;
  end;
end;

procedure TIdFiber.Yield;
begin
  // If manual fiber, yield is same as relinquish
  if Assigned(FOnRelinquish) then begin
    FOnRelinquish(Self, True);
  end else begin
    SwitchToParent;
  end;
end;

procedure TIdFiber.SetRelinquishHandler(AValue: TIdFiberRelinquishEvent);
begin
  FOnRelinquish := AValue;
end;

{ TIdConvertedFiber }

constructor TIdConvertedFiber.Create;
begin
  inherited;
  FHandle := Pointer(ConvertThreadToFiber(Self));
end;

{ TIdFiberBase }

constructor TIdFiberBase.Create;
begin
  inherited;
  if not Assigned(@CreateFiber) then begin
    LoadFiberFunctions;
  end;
end;

procedure TIdFiberBase.CheckRunnable;
begin
end;

class function TIdFiberBase.HaveFiberSupport:boolean;
begin
  Result := IndyWindowsPlatform = VER_PLATFORM_WIN32_NT;
end;

procedure TIdFiberBase.SwitchTo(AFiber: TIdFiberBase);
begin
  //Kudzu
  // Be VERY careful in this section. This section takes care of Delphi's
  // exception handling mechanism.
  //
  // This section swaps out the exception frames for each fiber so that
  // exceptions are handled properly, preserved between switches, and across
  // threads.
  //
  // Notes:
  // -Only works on Windows, but we dont support fibers on Kylix right now
  //  anyways
  // -Developer MUST use our fibers and not call Fiber API calls directly.
  // -May not work on C++ Builder at this time.
  // -May not work on older Delphi editions at this time.
  // -If the user calls this method and the fiber is not the current fiber, will
  // be problems. Maybe lock against thread ID and check that.
  //
  // This could be extended to make ThreadVars "FiberVars" by swaping out the
  // TLS entry. I may make this an option in the future.
  // This would also take care of the exception stack by itself and may be
  // more portable to Linux, CB and older versions of Delphi. Will check later.
  //
  //
  // Save raise list for current fiber
  FRaiseList := RaiseList;
  AFiber.SwitchToMeFrom(Self);
end;

procedure TIdFiberBase.SwitchToMeFrom(
  AFromFiber: TIdFiberBase
  );
begin
  // See if we can run the fiber. If not it will raise an exception.
  CheckRunnable;
  FPriorFiber := AFromFiber;
  // Restore raise list
  SetRaiseList(FRaiseList);
  // Switch to the actual fiber
  SwitchToFiber(Handle);
end;

{ TIdFiberWithTask }

procedure TIdFiberWithTask.AfterRun;
begin
  FTask.DoAfterRun;
  inherited;
end;

procedure TIdFiberWithTask.BeforeRun;
begin
  inherited;
  FTask.DoBeforeRun;
end;

constructor TIdFiberWithTask.Create(
  AParentFiber: TIdFiberBase = nil;
  ATask: TIdTask = nil;
  AName: string = '';
  AStackSize: Integer = 0
  );
begin
  inherited Create(AParentFiber, True, AStackSize);
  FTask := ATask;
end;

destructor TIdFiberWithTask.Destroy;
begin
  FreeAndNil(FTask);
  inherited;
end;

procedure TIdFiberWithTask.Run;
begin
  if not FTask.DoRun then begin
    Stop;
  end;
end;

end.

