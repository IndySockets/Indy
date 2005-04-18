{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  15098: IdScheduler.pas 
{
{   Rev 1.14    4/8/2004 11:55:30 AM  BGooijen
{ Fix for D5
}
{
{   Rev 1.13    2004.03.01 5:12:38 PM  czhower
{ -Bug fix for shutdown of servers when connections still existed (AV)
{ -Implicit HELP support in CMDserver
{ -Several command handler bugs
{ -Additional command handler functionality.
}
{
{   Rev 1.12    2004.01.20 10:03:30 PM  czhower
{ InitComponent
}
{
{   Rev 1.11    2003.10.21 12:18:58 AM  czhower
{ TIdTask support and fiber bug fixes.
}
{
{   Rev 1.10    2003.10.14 11:18:08 PM  czhower
{ Fix for AV on shutdown and other bugs
}
{
{   Rev 1.9    2003.10.11 5:49:24 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.8    2003.09.19 10:11:16 PM  czhower
{ Next stage of fiber support in servers.
}
{
{   Rev 1.7    2003.09.19 11:54:30 AM  czhower
{ -Completed more features necessary for servers
{ -Fixed some bugs
}
{
{   Rev 1.6    2003.09.18 4:10:24 PM  czhower
{ Preliminary changes for Yarn support.
}
{
    Rev 1.5    3/27/2003 5:15:36 PM  BGooijen
  Moved some code from subclasses here, made MaxThreads published
}
{
    Rev 1.4    3/13/2003 10:18:36 AM  BGooijen
  Server side fibers, bug fixes
}
{
    Rev 1.1    1/23/2003 11:06:04 AM  BGooijen
}
{
{   Rev 1.0    1/17/2003 03:41:48 PM  JPMugaas
{ Scheduler base class.
}
unit IdScheduler;

interface

uses
  Classes,
  IdBaseComponent, IdThread, IdTask, IdYarn, IdThreadSafe;

type
  TIdScheduler = class(TIdBaseComponent)
  protected
    FActiveYarns: TIdThreadSafeList;
    //
    procedure InitComponent; override;
  public
    function AcquireYarn
      : TIdYarn;
      virtual; abstract;
    destructor Destroy;
      override;
    procedure Init;
      virtual;
    // ReleaseYarn is to remove a yarn from the list that has already been
    // terminated (usually self termination);
    procedure ReleaseYarn(
      AYarn: TIdYarn
      ); virtual;
    procedure StartYarn(
      AYarn: TIdYarn;
      ATask: TIdTask
      ); virtual; abstract;
    // TerminateYarn is to terminate a yarn explicitly and remove it also
    procedure TerminateYarn(
      AYarn: TIdYarn
      ); virtual; abstract;
    procedure TerminateAllYarns; virtual;
    //
    property ActiveYarns: TIdThreadSafeList read FActiveYarns;
  end;

implementation

uses
  IdGlobal;

{ TIdScheduler }

destructor TIdScheduler.Destroy;
begin
  Sys.FreeAndNil(FActiveYarns);
  inherited;
end;

procedure TIdScheduler.Init;
begin
end;

procedure TIdScheduler.InitComponent;
begin
  inherited;
  FActiveYarns := TIdThreadSafeList.Create;
end;

procedure TIdScheduler.ReleaseYarn(AYarn: TIdYarn);
begin
  ActiveYarns.Remove(AYarn);
end;

procedure TIdScheduler.TerminateAllYarns;
var
  i: Integer;
begin
  while True do begin
    // Must unlock each time to allow yarns that are temrinating to remove themselves from the list
    with FActiveYarns.LockList do try
      if Count = 0 then begin
        Break;
      end;
      for i := 0 to Count - 1 do begin
        TerminateYarn(TIdYarn(Items[i]));
      end;
    finally FActiveYarns.UnlockList; end;
    //TODO: Put terminate timeout check back
    Sleep(500); // Wait a bit before looping to prevent thrashing
  end;
end;

end.
