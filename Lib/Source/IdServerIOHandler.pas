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
  Rev 1.7    2003.10.11 5:49:56 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.6    2003.09.19 11:54:32 AM  czhower
  -Completed more features necessary for servers
  -Fixed some bugs

  Rev 1.5    2003.09.18 4:10:28 PM  czhower
  Preliminary changes for Yarn support.

  Rev 1.4    3/23/2003 11:26:08 PM  BGooijen
  Added SetScheduler,MakeClientIOHandler

  Rev 1.3    3/13/2003 10:18:22 AM  BGooijen
  Server side fibers, bug fixes

  Rev 1.2    1-17-2003 22:22:02  BGooijen
  new design

  Rev 1.1    1-1-2003 16:28:58  BGooijen
  Changed TIdThread to TIdYarn

  Rev 1.0    11/13/2002 08:46:16 AM  JPMugaas
}

unit IdServerIOHandler;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdSocketHandle, IdComponent, IdIOHandlerStack,
  IdIOHandler, IdThread, IdScheduler, IdYarn;

type
  TIdServerIOHandler = class(TIdComponent)
  protected
    {$IF DEFINED(HAS_UNSAFE_OBJECT_REF)}[Unsafe]
    {$ELSEIF DEFINED(HAS_WEAK_OBJECT_REF)}[Weak]
    {$IFEND} FScheduler: TIdScheduler;
    //
    {$IFDEF USE_OBJECT_REF_FREENOTIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$ENDIF}
  public
    // This is a thread and not a yarn. Its the listener thread.
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread; AYarn: TIdYarn ): TIdIOHandler; virtual;
    function MakeClientIOHandler(AYarn: TIdYarn): TIdIOHandler; virtual;
    // Init is called when the server goes active
    procedure Init; virtual;
    procedure Shutdown; virtual;
    // SetScheduler is called by the user (normally TCPServer) automatically
    procedure SetScheduler(AScheduler: TIdScheduler); virtual;
    //
    property Scheduler: TIdScheduler read FScheduler: write SetScheduler;
  end;

implementation

procedure TIdServerIOHandler.Init;
begin
end;

function TIdServerIOHandler.Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread;
  AYarn: TIdYarn): TIdIOHandler;
begin
  Result := nil;
end;

function TIdServerIOHandler.MakeClientIOHandler(AYarn: TIdYarn): TIdIOHandler;
begin
  Result := nil;
end;

// under ARC, all weak references to a freed object get nil'ed automatically
{$IFDEF USE_OBJECT_REF_FREENOTIF}
procedure TIdServerIOHandler.Notification(AComponent: TComponent; Operation: TOperation);
begin
  // Remove the reference to the linked Scheduler if it is deleted
  if (Operation = opRemove) and (AComponent = FScheduler) then begin
    FScheduler := nil;
  end;
  inherited Notification(AComponent, Operation);
end;
{$ENDIF}

// RLebeau: not IFDEF'ing the entire method since it is virtual and could be
// overridden in user code...
procedure TIdServerIOHandler.SetScheduler(AScheduler: TIdScheduler);
begin
  {$IFDEF USE_OBJECT_REF_FREENOTIF}
  if FScheduler <> AScheduler then begin
    // Remove self from the Scheduler's notification list
    if Assigned(FScheduler) then begin
      FScheduler.RemoveFreeNotification(Self);
    end;
    FScheduler := AScheduler;
    // Add self to the Scheduler's notification list
    if Assigned(FScheduler) then begin
      FScheduler.FreeNotification(Self);
    end;
  end;
  {$ELSE}
  // under ARC, all weak references to a freed object get nil'ed automatically
  FScheduler := AScheduler;
  {$ENDIF}
end;

procedure TIdServerIOHandler.Shutdown;
begin
end;

end.
