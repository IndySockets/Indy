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
  Rev 1.2    6/11/2004 8:40:06 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.1    2004.02.09 9:16:48 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:38:58 AM  czhower
  Move

  Rev 1.9    2003.10.24 1:00:06 PM  czhower
  Name change

  Rev 1.8    2003.10.21 12:19:20 AM  czhower
  TIdTask support and fiber bug fixes.

  Rev 1.7    2003.10.19 4:38:34 PM  czhower
  Updates

  Rev 1.6    2003.10.19 2:50:40 PM  czhower
  Fiber cleanup

  Rev 1.5    2003.10.19 1:04:28 PM  czhower
  Updates

  Rev 1.4    2003.10.14 11:17:06 PM  czhower
  Updates to match core changes.

  Rev 1.3    2003.10.11 5:43:48 PM  czhower
  Chained servers now functional.

  Rev 1.2    2003.09.19 10:09:42 PM  czhower
  Next stage of fiber support in servers.
}

unit IdSchedulerOfFiber;

interface

uses
  Classes,
  IdFiberWeaver, IdTask, IdFiber, IdScheduler, IdYarn;

type
  TIdSchedulerOfFiber = class;

  TIdYarnOfFiber = class(TIdYarn)
  protected
    FFiber: TIdFiberWithTask;
    FScheduler: TIdScheduler;
  public
    constructor Create(
      AScheduler: TIdScheduler;
      AFiber: TIdFiberWithTask
      ); reintroduce; virtual;
    destructor Destroy;
      override;
    //
    property Fiber: TIdFiberWithTask read FFiber;
  end;

  TIdSchedulerOfFiber = class(TIdScheduler)
  protected
    FFiberWeaver: TIdFiberWeaver;
  public
    function AcquireYarn
      : TIdYarn;
      override;
    procedure StartYarn(
      AYarn: TIdYarn;
      ATask: TIdTask
      ); override;
    procedure TerminateYarn(
      AYarn: TIdYarn
      ); override;
  published
    //TODO: Need to add notification for this prop
    //TODO: Dont allow setting while active
    property FiberWeaver: TIdFiberWeaver read FFiberWeaver write FFiberWeaver;
  end;

implementation

uses
  IdGlobal,
  SysUtils;

{ TIdSchedulerOfFiber }

function TIdSchedulerOfFiber.AcquireYarn: TIdYarn;
var
  LFiber: TIdFiberWithTask;
begin
  LFiber := TIdFiberWithTask.Create(nil, nil, Format('%s User', [Name])); {do not localize}
  Result := TIdYarnOfFiber.Create(Self, LFiber);
  ActiveYarns.Add(Result);
end;

procedure TIdSchedulerOfFiber.StartYarn(
  AYarn: TIdYarn;
  ATask: TIdTask
  );
begin
  inherited;
  TIdYarnOfFiber(AYarn).Fiber.Task := ATask;
  // Last - Put it in the queue to be scheduled
  Assert(FiberWeaver<>nil);
  FiberWeaver.Add(TIdYarnOfFiber(AYarn).Fiber);
end;

procedure TIdSchedulerOfFiber.TerminateYarn(AYarn: TIdYarn);
begin
  // Fibers dont "run", so we dont terminate them
  FreeAndNil(AYarn);
end;

{ TIdYarnOfFiber }

constructor TIdYarnOfFiber.Create(
  AScheduler: TIdScheduler;
  AFiber: TIdFiberWithTask
  );
begin
  inherited Create;
  FScheduler := AScheduler;
  FFiber := AFiber;
  AFiber.Yarn := Self;
end;

destructor TIdYarnOfFiber.Destroy;
begin
  FScheduler.ReleaseYarn(Self);
  inherited;
end;

end.
