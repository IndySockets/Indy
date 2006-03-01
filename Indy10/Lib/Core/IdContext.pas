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
  Rev 1.14    6/16/2004 2:08:48 PM  JPMugaas
  Binding made public for the FTP Server.

  Rev 1.13    6/4/2004 1:34:24 PM  DSiders
  Removed unused TIdContextDoRun, TIdContextMethod types.

  Rev 1.12    2004.02.03 4:17:08 PM  czhower
  For unit name changes.

  Rev 1.11    21.1.2004 ã. 12:31:04  DBondzhev
  Fix for Indy source. Workaround for dccil bug
  now it can be compiled using Compile instead of build

  Rev 1.10    2003.10.21 12:18:58 AM  czhower
  TIdTask support and fiber bug fixes.

  Rev 1.9    2003.10.11 5:47:18 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.8    2003.09.19 11:54:28 AM  czhower
  -Completed more features necessary for servers
  -Fixed some bugs

  Rev 1.7    3/22/2003 09:45:26 PM  JPMugaas
  Now should compile under D4.

  Rev 1.6    3/13/2003 10:18:38 AM  BGooijen
  Server side fibers, bug fixes

  Rev 1.5    1/31/2003 7:24:18 PM  BGooijen
  Added a .Binding function

  Rev 1.4    1/23/2003 8:33:20 PM  BGooijen

  Rev 1.3    1/23/2003 11:06:06 AM  BGooijen


  Rev 1.2    1-17-2003 23:58:30  BGooijen
  removed OnCreate/OnDestroy again, they had no use

  Rev 1.0    1-17-2003 22:28:58  BGooijen
}

unit IdContext;

interface

uses
  IdObjs,
  IdSocketHandle, IdSys, IdTCPConnection, IdTask, IdYarn;

type
  TIdContext = class;
  TIdContextClass = class of TIdContext;
  TIdContextRun = function (AContext: TIdContext): Boolean of object;
  TIdContextBeforeRun = procedure (AContext: TIdContext) of object;
  TIdContextAfterRun = procedure (AContext: TIdContext) of object;

  TIdContext = class(TIdTask)
  protected
    // A list in which this context is registered, this can be nil, and should
    // therefore not be used
    FContextList: TIdThreadList;
    FConnection: TIdTCPConnection;
    FOwnsConnection: Boolean;
    FOnRun: TIdContextRun;
    FOnBeforeRun: TIdContextBeforeRun;
    FOnAfterRun: TIdContextAfterRun;
    //
    procedure BeforeRun; override;
    function Run: Boolean; override;
    procedure AfterRun; override;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdThreadList = nil
      ); reintroduce; virtual;
    destructor Destroy; override;
    procedure RemoveFromList;
    function Binding: TIdSocketHandle;
    //
    property Connection: TIdTCPConnection read FConnection;
    //
    property OnAfterRun:TIdContextAfterRun read FOnAfterRun
      write FOnAfterRun;
    property OnBeforeRun:TIdContextBeforeRun read FOnBeforeRun
      write FOnBeforeRun;
    property OnRun:TIdContextRun read FOnRun write FOnRun;
  end;

implementation

{ TIdContext }

uses
  IdGlobal,
  IdIOHandlerSocket;

constructor TIdContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdThreadList = nil
  );
begin
  inherited Create(AYarn);
  FConnection := AConnection;
  FOwnsConnection:=True;
  FContextList := AList;
end;

destructor TIdContext.Destroy;
begin
  if FContextList<>nil then begin
    FContextList.Remove(Self);
  end;

  if FOwnsConnection then begin
    Sys.FreeAndNil(FConnection);
  end;
  inherited Destroy;
end;

procedure TIdContext.RemoveFromList;
begin
  FContextList := nil;
end;

procedure TIdContext.BeforeRun;
begin
  //Context must be added to ContextList outside of create. This avoids
  //the possibility of another thread accessing a context (specifically
  //a subclass) that is still creating. similar logic for remove/destroy.
  if FContextList <> nil then begin
    FContextList.Add(Self);
  end;

  if Assigned(OnBeforeRun) then begin
    OnBeforeRun(Self);
  end;
end;

function TIdContext.Run: Boolean;
begin
  if Assigned(OnRun) then begin
    Result := OnRun(Self);
  end else begin
    Result := True;
  end;
end;

procedure TIdContext.AfterRun;
begin
  if Assigned(OnAfterRun) then begin
    OnAfterRun(Self);
  end;

  if FContextList <> nil then begin
    FContextList.Remove(Self);
  end;
end;

function TIdContext.Binding: TIdSocketHandle;
begin
  Result := nil;
  if Connection <> nil then begin
    if Connection.Socket <> nil then begin
      Result := Connection.Socket.Binding;
    end;
  end;
end;

end.

