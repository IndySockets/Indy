{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12006: IdThread.pas
{
{   Rev 1.34    03/16/05 10:29:40 AM  JSouthwell
{ Added a default thread name to ease debugging of IdThreads.
}
{
{   Rev 1.33    1/15/05 1:52:36 PM  RLebeau
{ Extra cleanup handling for the FYarn member
}
{
{   Rev 1.32    1/6/2005 10:02:58 PM  JPMugaas
{ This should compile.
}
{
{   Rev 1.31    1/6/05 2:33:04 PM  RLebeau
{ one more try...finally block, for Before/AfterExecute()
}
{
{   Rev 1.29    1/5/05 5:31:08 PM  RLebeau
{ Added extra try..finally block to Execute() to free the FYarn member.
}
{
    Rev 1.28    6/9/2004 10:38:46 PM  DSiders
  Fixed case for TIdNotifyThreadEvent.
}
{
{   Rev 1.27    3/12/2004 7:11:02 PM  BGooijen
{ Changed order of commands for dotnet
}
{
{   Rev 1.26    2004.03.01 5:12:44 PM  czhower
{ -Bug fix for shutdown of servers when connections still existed (AV)
{ -Implicit HELP support in CMDserver
{ -Several command handler bugs
{ -Additional command handler functionality.
}
{
{   Rev 1.25    2004.02.03 4:17:00 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.24    2004.01.22 5:59:12 PM  czhower
{ IdCriticalSection
}
{
{   Rev 1.23    2003.12.28 2:33:16 PM  czhower
{ .Net finalization fix.
}
{
{   Rev 1.22    2003.12.28 1:27:46 PM  czhower
{ .Net compatibility
}
{
{   Rev 1.21    2003.10.24 12:59:20 PM  czhower
{ Name change
}
{
{   Rev 1.20    2003.10.21 12:19:04 AM  czhower
{ TIdTask support and fiber bug fixes.
}
{
    Rev 1.19    10/15/2003 8:40:48 PM  DSiders
  Added locaization comments.
}
{
{   Rev 1.18    10/5/2003 3:19:58 PM  BGooijen
{ disabled some stuff for DotNet
}
{
{   Rev 1.17    2003.09.19 10:11:22 PM  czhower
{ Next stage of fiber support in servers.
}
{
{   Rev 1.14    2003.09.19 11:54:36 AM  czhower
{ -Completed more features necessary for servers
{ -Fixed some bugs
}
{
{   Rev 1.13    2003.09.18 4:43:18 PM  czhower
{ -Removed IdBaseThread
{ -Threads now have default names
}
{
{   Rev 1.12    12.9.2003 ã. 16:42:08  DBondzhev
{ Fixed AV when exception is raised in BeforeRun and thread is terminated
{ before Start is compleated
}
{
{   Rev 1.11    2003.07.08 2:41:52 PM  czhower
{ Avoid calling SetThreadName if we do not need to
}
{
{   Rev 1.10    08.07.2003 13:16:18  ARybin
{ tiny opt fix
}
{
    Rev 1.9    7/1/2003 7:11:30 PM  BGooijen
  Added comment
}
{
{   Rev 1.8    2003.07.01 4:14:58 PM  czhower
{ Consolidation.
{ Added Name, Loop
}
{
{   Rev 1.7    04.06.2003 14:06:20  ARybin
{ bug fix & limited waiting
}
{
{   Rev 1.6    28.05.2003 14:16:16  ARybin
{ WaitAllThreadsTerminated class method
}
{
{   Rev 1.5    08.05.2003 12:45:10  ARybin
{ "be sure" fix
}
{
    Rev 1.4    4/30/2003 4:53:26 PM  BGooijen
  Fixed bug in Kylix where GThreadCount was not decremented
}
{
    Rev 1.3    4/22/2003 4:44:06 PM  BGooijen
  changed Handle to ThreadID
}
{
    Rev 1.2    3/22/2003 12:53:26 PM  BGooijen
  - Exceptions in the constructor are now handled better.
  - GThreadCount can't become negative anymore
}
{
{   Rev 1.1    06.03.2003 11:54:24  ARybin
{ TIdThreadOptions: is thread Data owner, smart Cleanup
}
{
{   Rev 1.0    11/13/2002 09:01:14 AM  JPMugaas
}
unit IdThread;

{
2002-03-12 -Andrew P.Rybin
  -TerminatingExceptionClass, etc.
2002-06-20 -Andrew P.Rybin
  -"Terminated Start" bug fix (FLock.Leave AV)
  -Wait All threads termination in FINALIZATION (prevent AV in WinSock)
  -HandleRunException
2003-01-27 -Andrew P.Rybin
  -TIdThreadOptions
}
{$I IdCompilerDefines.inc}

interface

uses
  Classes,
  IdGlobal, IdException, IdSys, IdYarn, IdTask, IdThreadSafe;

const
  IdWaitAllThreadsTerminatedCount = 1 * 60 * 1000;
  IdWaitAllThreadsTerminatedStep  = 250;

type
  EIdThreadException = class(EIdException);
  EIdThreadTerminateAndWaitFor = class(EIdThreadException);

  TIdThreadStopMode = (smTerminate, smSuspend);
  TIdThread = class;
  TIdExceptionThreadEvent = procedure(AThread: TIdThread; AException: Exception) of object;
  TIdNotifyThreadEvent = procedure(AThread: TIdThread) of object;
  TIdSynchronizeThreadEvent = procedure(AThread: TIdThread; AData: Pointer) of object;

  TIdThreadOptions = set of (itoStopped, itoReqCleanup, itoDataOwner, itoTag);

  TIdThread = class(TThread)
  protected
    FData: TObject;
    FLock: TIdCriticalSection;
    FLoop: Boolean;
    FName: string;
    FStopMode: TIdThreadStopMode;
    FOptions: TIdThreadOptions;
    FTerminatingException: String;
    FTerminatingExceptionClass: TClass;
    FYarn: TIdYarn;
    //
    FOnException: TIdExceptionThreadEvent;
    FOnStopped: TIdNotifyThreadEvent;
    //
    procedure AfterRun; virtual; //3* not abstract - otherwise it is required
    procedure AfterExecute; virtual;//5 not abstract - otherwise it is required
    procedure BeforeExecute; virtual;//1 not abstract - otherwise it is required
    procedure BeforeRun; virtual; //2* not abstract - otherwise it is required
    procedure Cleanup; virtual;//4*
    procedure DoException (AException: Exception); virtual;
    procedure DoStopped; virtual;
    procedure Execute; override;
    function GetStopped: Boolean;
    function HandleRunException(AException: Exception): Boolean; virtual;
    procedure Run; virtual; abstract;
    class procedure WaitAllThreadsTerminated(
     AMSec: Integer = IdWaitAllThreadsTerminatedCount);
  public
    constructor Create(ACreateSuspended: Boolean = True;
     ALoop: Boolean = True; AName: string = ''); virtual;
    destructor Destroy; override;
    procedure Start; virtual;
    procedure Stop; virtual;
    procedure Synchronize(Method: TThreadMethod); overload;
//BGO:TODO    procedure Synchronize(Method: TMethod); overload;
    // Here to make virtual
    procedure Terminate; virtual;
    procedure TerminateAndWaitFor; virtual;
    //
    property Data: TObject read FData write FData;
    property Loop: Boolean read FLoop write FLoop;
    property Name: string read FName write FName;
    property ReturnValue;
    property StopMode: TIdThreadStopMode read FStopMode write FStopMode;
    property Stopped: Boolean read GetStopped;
    property Terminated;
    // TODO: Change this to be like TIdFiber. D6 implementation is not as good
    // as what is done in TIdFiber.
    property TerminatingException: string read FTerminatingException;
    property TerminatingExceptionClass: TClass read FTerminatingExceptionClass;
    property Yarn: TIdYarn read FYarn write FYarn;
    //
    property OnException: TIdExceptionThreadEvent read FOnException write FOnException;
    property OnStopped: TIdNotifyThreadEvent read FOnStopped write FOnStopped;
  end;

  TIdThreadWithTask = class(TIdThread)
  protected
    FTask: TIdTask;
    //
    procedure AfterRun; override;
    procedure BeforeRun; override;
    procedure Run; override;
  public
    // Defaults because
    // Must always create suspended so task can be set
    // And a bit crazy to create a non looped task
    constructor Create(
      ATask: TIdTask = nil;
      AName: string = ''
      ); reintroduce;
    destructor Destroy;
      override;
    //
    // Must be writeable because tasks are often created after thread or
    // thread is pooled
    property Task: TIdTask read FTask write FTask;
  end;

  TIdThreadClass = class of TIdThread;

var
  // GThreadCount shoudl be in implementation as it is not needed outside of
  // this unit. However with D8, GThreadCount will be deallocated before the
  // finalization can run and thus when the finalizaiton accesses GThreadCount
  // in TerminateAll an error occurs. Moving this declaration to the interface
  // "fixes" it.
  GThreadCount: TIdThreadSafeInteger = nil;

implementation

uses
  IdResourceStringsCore;

class procedure TIdThread.WaitAllThreadsTerminated(
 AMSec: Integer = IdWaitAllThreadsTerminatedCount);
begin
  while AMSec > 0 do begin
    if GThreadCount.Value = 0 then begin
      Break;
    end;
    Sleep(IdWaitAllThreadsTerminatedStep);
    AMSec := AMSec - IdWaitAllThreadsTerminatedStep;
  end;
end;

procedure TIdThread.TerminateAndWaitFor;
begin
  if FreeOnTerminate then begin
    raise EIdThreadTerminateAndWaitFor.Create(RSThreadTerminateAndWaitFor);
  end;
  Terminate;
  Start; //resume
  WaitFor;
end;

procedure TIdThread.BeforeRun;
begin
end;

procedure TIdThread.AfterRun;
begin
end;

procedure TIdThread.BeforeExecute;
begin
end;

procedure TIdThread.AfterExecute;
begin
end;

procedure TIdThread.Execute;
begin
  // Must make this call from INSIDE the thread. The call in Create
  // was naming the thread that was creating this thread. :(
  //
  // RLebeau - no need to put this inside the try blocks below as it
  // already uses its own try..except block internally
  if Name = '' then begin
    Name := 'IdThread (unknown)';
  end;
  SetThreadName(Name);

  try
    BeforeExecute;
    try
      while not Terminated do begin
        if Stopped then begin
          DoStopped;
          // It is possible that either in the DoStopped or from another thread,
          // the thread is restarted, in which case we dont want to restop it.
          if Stopped then begin // DONE: if terminated?
            if Terminated then begin
              Break;
            end;
            Suspend; // Thread manager will revive us
            if Terminated then begin
              Break;
            end;
          end;
        end;

        Include(FOptions, itoReqCleanup);
        try
          try
            BeforeRun;
            try
              if Loop then begin
                while not Stopped do begin
                  try
                    Run;
                  except
                    on E: Exception do begin
                      if not HandleRunException(E) then begin
                        Terminate;
                        raise;
                      end;
                    end;
                  end;
                end;
              end else begin
                try
                  Run;
                except
                  on E: Exception do begin
                    if not HandleRunException(E) then begin
                      Terminate;
                      raise;
                    end;
                  end;
                end;
              end;
            finally
              AfterRun;
            end;
          except
            Terminate;
            raise;
          end;
        finally
          Cleanup;
        end;
      end;
    finally
      AfterExecute;
    end;
  except
    on E: Exception do begin
      FTerminatingExceptionClass := E.ClassType;
      FTerminatingException := E.Message;
      DoException(E);
      Terminate;
    end;
  end;
end;

constructor TIdThread.Create(ACreateSuspended: Boolean; ALoop: Boolean;
 AName: string);
begin
{$IFDEF DOTNET}
  inherited Create(true);
{$ENDIF}
  FOptions := [itoDataOwner];
  if ACreateSuspended then begin
    Include(FOptions, itoStopped);
  end;
  FLock := TIdCriticalSection.Create;
  Loop := ALoop;
  Name := AName;
  //
{$IFDEF DOTNET}
  if not ACreateSuspended then begin
    Resume;
  end;
{$ELSE}
  //
  // Most things BEFORE inherited - inherited creates the actual thread and if
  // not suspended will start before we initialize
  inherited Create(ACreateSuspended);
{$ENDIF}
  {$IFNDEF VCL6ORABOVE}
  // Delphi 6 and above raise an exception when an error occures
  // while creating a thread (eg. not enough address space to allocate a stack)
  // Delphi 5 and below don't do that, which results in a TIdThread instance
  // with an invalid handle in it.
  // Therefore we raise the exceptions manually on D5 and below
  {$IFNDEF DOTNET}
  if (ThreadID = 0) then begin
    RaiseLastOSError;
  end;
  {$ENDIF}
  {$ENDIF}
  // Last, so we only do this if successful
  GThreadCount.Increment;
end;

destructor TIdThread.Destroy;
begin
  FreeOnTerminate := False; //prevent destroy between Terminate & WaitFor
  Terminate;
  inherited Destroy; //+WaitFor!
  try
    if itoReqCleanup in FOptions then begin
      Cleanup;
    end;
  finally
    // RLebeau- clean up the Yarn one more time, in case the thread was
    // terminated after the Yarn was assigned but the thread was not
    // re-started, so the Yarn would not be freed in Cleanup()
    try
      Sys.FreeAndNil(FYarn);
    finally
      // Protect FLock if thread was resumed by Start Method and we are still there.
      // This usually happens if Exception was raised in BeforeRun for some reason
      // And thread was terminated there before Start method is completed.
      FLock.Enter; try
      finally FLock.Leave; end;

      Sys.FreeAndNil(FLock);
      GThreadCount.Decrement;
    end;
  end;
End;

procedure TIdThread.Start;
begin
  FLock.Enter; try
    if Stopped then begin
      // Resume is also called for smTerminate as .Start can be used to initially start a
      // thread that is created suspended
      if Terminated then begin
        Include(FOptions,itoStopped);
      end else begin
        Exclude(FOptions,itoStopped);
      end;
      Resume;
      {APR: [in past] thread can be destroyed here! now Destroy wait FLock}
    end;
  finally FLock.Leave; end;
end;

procedure TIdThread.Stop;
begin
  FLock.Enter; try
    if not Stopped then begin
      case FStopMode of
        smTerminate: Terminate;
        smSuspend: {DO not suspend here. Suspend is immediate. See Execute for implementation};
      end;
      Include(FOptions, itoStopped);
    end;
  finally FLock.Leave; end;
end;

function TIdThread.GetStopped: Boolean;
begin
  if Assigned(FLock) then begin
    FLock.Enter; try
      // Suspended may be True if checking stopped from another thread
      Result := Terminated or (itoStopped in FOptions) or Suspended;
    finally FLock.Leave; end;
  end else begin
    Result := True; //user call Destroy
  end;
end;

procedure TIdThread.DoStopped;
begin
  if Assigned(OnStopped) then begin
    OnStopped(Self);
  end;
end;

procedure TIdThread.DoException (AException: Exception);
begin
  if Assigned(FOnException) then begin
    FOnException(self, AException);
  end;
end;

procedure TIdThread.Terminate;
begin
  Assert(FLock<>nil);
  FLock.Enter; try
    Include(FOptions, itoStopped);
    inherited Terminate;
  finally FLock.Leave; end;
end;

procedure TIdThread.Cleanup;
begin
  Exclude(FOptions, itoReqCleanup);
  Sys.FreeAndNil(FYarn);
  if itoDataOwner in FOptions then begin
    Sys.FreeAndNil(FData);
  end;
end;

function TIdThread.HandleRunException(AException: Exception): Boolean;
begin
  // Default behavior: Exception is death sentence
  Result := False;
end;

procedure TIdThread.Synchronize(Method: TThreadMethod);
begin
  inherited Synchronize(Method);
end;
//BGO:TODO
//procedure TIdThread.Synchronize(Method: TMethod);
//begin
//  inherited Synchronize(TThreadMethod(Method));
//end;

{ TIdThreadWithTask }

procedure TIdThreadWithTask.AfterRun;
begin
  FTask.DoAfterRun;
  inherited;
end;

procedure TIdThreadWithTask.BeforeRun;
begin
  inherited;
  FTask.DoBeforeRun;
end;

constructor TIdThreadWithTask.Create(
  ATask: TIdTask;
  AName: string
  );
begin
  inherited Create(True, True, AName);
  FTask := ATask;
end;

destructor TIdThreadWithTask.Destroy;
begin
  Sys.FreeAndNil(FTask);
  inherited;
end;

procedure TIdThreadWithTask.Run;
begin
  if not FTask.DoRun then begin
    Stop;
  end;
end;

initialization
  SetThreadName('Main');  {do not localize}
  GThreadCount := TIdThreadSafeInteger.Create;
finalization
  // This call hangs if not all threads have been properly destroyed.
  // But without this, bad threads can often have worse results. Catch 22.
//  TIdThread.WaitAllThreadsTerminated;
//  FreeAndNil(GThreadCount);
end.
