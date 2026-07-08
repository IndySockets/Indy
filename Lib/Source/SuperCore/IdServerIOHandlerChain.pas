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

  Rev 1.1    2004.02.09 9:16:50 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:39:00 AM  czhower
  Move

  Rev 1.6    2003.10.19 4:38:34 PM  czhower
  Updates

  Rev 1.5    2003.10.19 2:51:10 PM  czhower
  Fiber cleanup

  Rev 1.4    2003.10.14 11:17:10 PM  czhower
  Updates to match core changes.

  Rev 1.3    2003.10.11 5:43:56 PM  czhower
  Chained servers now functional.

  Rev 1.2    2003.09.19 10:09:42 PM  czhower
  Next stage of fiber support in servers.

  Rev 1.1    2003.09.18 5:54:32 PM  czhower
  TIdYarnFix

  Rev 1.0    8/16/2003 11:09:02 AM  JPMugaas
  Moved from Indy Core dir as part of package reorg

  Rev 1.6    7/6/2003 8:04:08 PM  BGooijen
  Renamed IdScheduler* to IdSchedulerOf*

  Rev 1.5    4/11/2003 01:09:54 PM  JPMugaas

  Rev 1.4    3/29/2003 5:55:02 PM  BGooijen
  now calls AfterAccept

  Rev 1.3    3/27/2003 12:51:30 PM  BGooijen
  changed for IdSchedulerFiberBase

  Rev 1.2    3/25/2003 11:05:30 PM  BGooijen
  The ChainEngine is now a property

  Rev 1.1    3/23/2003 11:30:26 PM  BGooijen
  Moved a lot of code to IdSchedulerFiber, added MakeClientIOHandler

  Rev 1.0    3/13/2003 11:51:14 AM  BGooijen
  Initial check in
}

unit IdServerIOHandlerChain;

interface

uses
  IdServerIOHandler, IdIOHandlerChain, IdYarn,
  IdSocketHandle, IdThread, IdIOHandler, IdScheduler, IdFiber,
  Classes;

type
  TIdServerIOHandlerChain = class(TIdServerIOHandler)
  protected
    FChainEngine: TIdChainEngine;
  public
    function Accept(
      ASocket: TIdSocketHandle;
      AListenerThread: TIdThread;
      AYarn: TIdYarn
      ): TIdIOHandler;
      override;
    function MakeClientIOHandler(
      AYarn: TIdYarn
      ): TIdIOHandler;
      override;
    procedure SetScheduler(
      AScheduler: TIdScheduler
      ); override;
  published
    //TODO: Need to add notification for this prop
    property ChainEngine: TIdChainEngine read FChainEngine write FChainEngine;
  end;

implementation

uses
  IdGlobal, IdSchedulerOfFiber, IdException, IdFiberWeaver,
  SysUtils;

procedure TIdServerIOHandlerChain.SetScheduler(
  AScheduler: TIdScheduler
  );
begin
  if AScheduler <> nil then begin
    EIdException.IfFalse(AScheduler is TIdSchedulerOfFiber
     , 'Scheduler not a fiber scheduler'); {do not localize}
  end;
  FScheduler := AScheduler;
end;

function TIdServerIOHandlerChain.Accept(
  ASocket: TIdSocketHandle;
  AListenerThread: TIdThread;
  AYarn: TIdYarn
  ): TIdIOHandler;
var
  LIOHandler: TIdIOHandlerChain;
begin
  EIdException.IfNotAssigned(FChainEngine, 'No ChainEngine defined.'); {do not localize}
  LIOHandler := TIdIOHandlerChain.Create(nil, FChainEngine
   //TODO: Can remove this cast later
   , TIdFiberWeaver(TIdSchedulerOfFiber(FScheduler).FiberWeaver)
   , TIdYarnOfFiber(AYarn).Fiber);
  LIOHandler.Open;
  Result := nil;
  if AListenerThread <> nil then begin
    while not AListenerThread.Stopped do try
      if ASocket.Select(100) then begin  // Wait for 100 ms
        if LIOHandler.Binding.Accept(ASocket.Handle) then begin
          LIOHandler.AfterAccept;
          Result := LIOHandler;
          Exit;
        end else begin
          FreeAndNil(LIOHandler);
          Exit;
        end;
      end;
    finally
      if AListenerThread.Stopped then begin
        FreeAndNil(LIOHandler);
      end;
    end;
  end else begin
    // Old way for compatibility
    if LIOHandler.Binding.Accept(ASocket.Handle) then begin
      Result := LIOHandler;
      Exit;
    end else begin
      FreeAndNil(LIOHandler);
    end;
  end;
end;

function TIdServerIOHandlerChain.MakeClientIOHandler(
  AYarn: TIdYarn
  ): TIdIOHandler;
begin
  Result := TIdIOHandlerChain.Create(nil, FChainEngine
   //TODO: CAn remove this cast later.
   , TIdFiberWeaver(TIdSchedulerOfFiber(FScheduler).FiberWeaver)
   , TIdYarnOfFiber(AYarn).Fiber);
end;

end.

