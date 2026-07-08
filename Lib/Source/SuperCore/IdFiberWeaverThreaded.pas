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
  Rev 1.4    6/11/2004 8:39:56 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.3    2004-04-23 19:46:52  Mattias
  TTempThread now uses WaitForFibers instead of sleep

  Rev 1.2    2004.04.22 11:45:18 PM  czhower
  Bug fixes

  Rev 1.1    2004.02.09 9:16:40 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:38:54 AM  czhower
  Move

  Rev 1.2    2003.10.21 12:19:22 AM  czhower
  TIdTask support and fiber bug fixes.

  Rev 1.1    2003.10.19 4:38:32 PM  czhower
  Updates
}

unit IdFiberWeaverThreaded;

interface

uses
  Classes,
  IdFiberWeaverInline,
  IdThread, IdSchedulerOfThread, IdFiberWeaver, IdFiber;

type
  TTempThread = class(TIdThread)
  protected
    FFiberWeaver: TIdFiberWeaverInline;
    //
    procedure AfterRun; override;
    procedure BeforeRun; override;
    procedure Run; override;
  end;

  TIdFiberWeaverThreaded = class(TIdFiberWeaver)
  protected
    FThreadScheduler: TIdSchedulerOfThread;
    FTempThread: TTempThread;
    //
    procedure InitComponent; override;
  public
    procedure Add(
      AFiber: TIdFiber
      ); override;
    destructor Destroy;
      override;
  published
    property ThreadScheduler: TIdSchedulerOfThread read FThreadScheduler
      write FThreadScheduler;
  end;

implementation

uses
  SysUtils;

{ TTempThread }

procedure TTempThread.AfterRun;
begin
  inherited;
  FreeAndNil(FFiberWeaver);
end;

procedure TTempThread.BeforeRun;
begin
  inherited;
  //TODO: Make this pluggable at run time? depends where threads come
  //from - merge to scheduler? Base is in IdFiber though....
  FFiberWeaver := TIdFiberWeaverInline.Create(nil);
  FFiberWeaver.FreeFibersOnCompletion := True;
end;

procedure TTempThread.Run;
begin
  //TODO: Temp hack
  if FFiberWeaver.HasFibers then begin
    FFiberWeaver.ProcessInThisThread;
  end else begin
    //Sleep(50);
    FFiberWeaver.WaitForFibers(50);
  end;
end;

{ TIdFiberWeaverThreaded }

procedure TIdFiberWeaverThreaded.Add(AFiber: TIdFiber);
begin
  FTempThread.FFiberWeaver.Add(AFiber);
end;

destructor TIdFiberWeaverThreaded.Destroy;
begin
  // is only created at run time
  if FTempThread <> nil then begin
    FTempThread.TerminateAndWaitFor;
    FreeAndNil(FTempThread);
  end;
  inherited;
end;

procedure TIdFiberWeaverThreaded.InitComponent;
begin
  inherited;
  if not (csDesigning in ComponentState) then begin
    FTempThread := TTempThread.Create(False, True, 'TIdSchedulerOfFiber Temp'); {do not localize}
  end;
end;

end.
