{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11996: IdSync.pas 
{
{   Rev 1.13    03/16/05 11:15:42 AM  JSouthwell
{ Named the IdNotify thread for simpler debugging.
}
{
{   Rev 1.12    2004.04.13 10:22:52 PM  czhower
{ Changed procedure to class method.
}
{
{   Rev 1.11    4/12/2004 11:44:36 AM  BGooijen
{ fix
}
{
{   Rev 1.10    4/12/2004 11:36:56 AM  BGooijen
{ NotifyThread can be cleaned up with procedure now
}
{
{   Rev 1.9    2004.03.11 10:14:46 AM  czhower
{ Improper cast fixed.
}
{
{   Rev 1.8    2004.02.29 8:23:16 PM  czhower
{ Fixed visibility mismatch.
}
{
{   Rev 1.7    2004.02.25 10:11:42 AM  czhower
{ Fixed visibility in notify
}
{
{   Rev 1.6    2004.02.03 4:16:54 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.5    1/1/2004 11:56:10 PM  PIonescu
{ Fix for TIdNotifyMethod's constructor
}
{
{   Rev 1.4    2003.12.31 7:33:20 PM  czhower
{ Constructor bug fix.
}
{
{   Rev 1.3    5/12/2003 9:17:42 AM  GGrieve
{ compile fix
}
{
{   Rev 1.2    2003.09.18 5:42:14 PM  czhower
{ Removed TIdThreadBase
}
{
{   Rev 1.1    05.6.2003 ã. 11:30:12  DBondzhev
{ Mem leak fix for notifiers created in main thread. Also WaitFor for waiting
{ notification to be executed.
}
{
{   Rev 1.0    11/13/2002 09:00:10 AM  JPMugaas
}
unit IdSync;

interface

// Author: Chad Z. Hower - a.k.a. Kudzu

uses
  IdGlobal, IdThread, IdObjs;

type
  TIdSync = class(TObject)
  protected
    FThread: TIdThread;
    //
    procedure DoSynchronize; virtual; abstract;
  public
    constructor Create; overload; virtual;
    constructor Create(AThread: TIdThread); overload; virtual;
    procedure Synchronize;
    class procedure SynchronizeMethod(AMethod: TIdThreadMethod);
    //
    property Thread: TIdThread read FThread;
  end;

  TIdNotify = class(TObject)
  protected
    FMainThreadUsesNotify: Boolean;
    //
    procedure DoNotify; virtual; abstract;
  public
    constructor Create; virtual; // here to make virtual
    procedure Notify;
    class procedure FreeThread;
    procedure WaitFor;
    class procedure NotifyMethod(AMethod: TIdThreadMethod);
    //
    property MainThreadUsesNotify: Boolean read FMainThreadUsesNotify write FMainThreadUsesNotify;
  end;

  TIdNotifyMethod = class(TIdNotify)
  protected
    FMethod: TIdThreadMethod;
    //
    procedure DoNotify; override;
  public
    constructor Create(AMethod: TIdThreadMethod); reintroduce; virtual;
  end;
  
implementation
uses IdSys;

type
  // This is done with a NotifyThread instead of PostMessage because starting
  // with D6/Kylix Borland radically modified the mecanisms for .Synchronize.
  // This is a bit more code in the end, but its source compatible and does not
  // rely on Indy directly accessing any OS APIs and performance is still more
  // than acceptable, especially considering Notifications are low priority.
  TIdNotifyThread = class(TIdThread)
  protected
    FEvent: TIdLocalEvent;
    FNotifications: TIdThreadList;
  public
    procedure AddNotification(ASync: TIdNotify);
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Run; override;
  end;

var
  GNotifyThread: TIdNotifyThread = nil;

procedure CreateNotifyThread;
begin
  if GNotifyThread = nil then begin
    GNotifyThread := TIdNotifyThread.Create;
  end;
end;

{ TIdSync }

constructor TIdSync.Create(AThread: TIdThread);
begin
  inherited Create;
  FThread := AThread;
end;

constructor TIdNotify.Create;
begin
  inherited Create;
end;

class procedure TIdNotify.FreeThread;
begin
  if GNotifyThread <> nil then begin
    GNotifyThread.Stop;
    GNotifyThread.FEvent.SetEvent;
    GNotifyThread.WaitFor;
    // Instead of FreeOnTerminate so we can set the reference to nil
    Sys.FreeAndNil(GNotifyThread);
  end;
end;

procedure TIdNotify.Notify;
begin
  if InMainThread and (MainThreadUsesNotify = False) then begin
    DoNotify;
    Free;
  end else begin
    CreateNotifyThread;
    GNotifyThread.AddNotification(Self);
  end;
end;

class procedure TIdNotify.NotifyMethod(AMethod: TIdThreadMethod);
begin
  TIdNotifyMethod.Create(AMethod).Notify;
end;

constructor TIdSync.Create;
begin
  CreateNotifyThread;
  Create(GNotifyThread);
end;

procedure TIdSync.Synchronize;
begin
  FThread.Synchronize(DoSynchronize);
end;

class procedure TIdSync.SynchronizeMethod(AMethod: TIdThreadMethod);
begin
  with Create do try
    FThread.Synchronize(AMethod);
  finally Free; end;
end;

{ TIdNotifyThread }

procedure TIdNotifyThread.AddNotification(ASync: TIdNotify);
begin
  FNotifications.Add(ASync);
  FEvent.SetEvent;
end;

constructor TIdNotifyThread.Create;
begin
  FEvent := TIdLocalEvent.Create;
  FNotifications := TIdThreadList.Create;
  // Must be before - Thread starts running when we call inherited
  inherited Create(False, False,'IdNotify');
end;

destructor TIdNotifyThread.Destroy;
begin
  // Free remaining Notifications if thre is somthing that is still in
  // the queue after thread was terminated
  with FNotifications.LockList do try
    while Count > 0 do begin
      TIdNotify(Items[0]).Free;
      Delete(0);
    end;
  finally FNotifications.UnlockList; end;
  Sys.FreeAndNil(FNotifications);
  Sys.FreeAndNil(FEvent);
  inherited Destroy;
end;

procedure TIdNotifyThread.Run;
// NOTE: Be VERY careful with making changes to this proc. It is VERY delicate and the order
// of execution is very important. Small changes can have drastic effects
var
  LNotifications: TIdList;
  LNotify: TIdNotify;
begin
  FEvent.WaitForEver;
  // If terminated while waiting on the event or during the loop
  while not Stopped do begin
    try
      LNotifications := FNotifications.LockList; try
        if LNotifications.Count = 0 then begin
          Break;
        end;
        LNotify := TIdNotify(LNotifications.Items[0]);
      finally FNotifications.UnlockList; end;
      Synchronize(LNotify.DoNotify);
      Sys.FreeAndNil(LNotify);
      with FNotifications.LockList do try
        Delete(0);
      finally FNotifications.UnlockList; end;
    except // Catch all exceptions especially these which are raised during the application close
    end;
  end;
end;

{ TIdNotifyMethod }

constructor TIdNotifyMethod.Create(AMethod: TIdThreadMethod);
begin
  inherited Create;
  FMethod := AMethod;
end;

procedure TIdNotifyMethod.DoNotify;
begin
  FMethod;
end;

procedure TIdNotify.WaitFor;
Var
  LNotifyIndex: Integer;
begin
  LNotifyIndex := 0;
  while LNotifyIndex <> -1 do begin
    with GNotifyThread.FNotifications.LockList do try
      LNotifyIndex := IndexOf(Self);
    finally GNotifyThread.FNotifications.UnlockList; end;
    Sleep(10);
  end;
end;

initialization
finalization
  TIdNotify.FreeThread
end.

