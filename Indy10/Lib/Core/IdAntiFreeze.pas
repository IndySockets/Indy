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
  Rev 1.6    2004.02.03 4:16:42 PM  czhower
  For unit name changes.

  Rev 1.5    2004.01.01 3:13:32 PM  czhower
  Updated comment.

  Rev 1.4    2003.12.31 10:30:24 PM  czhower
  Comment update.

  Rev 1.3    2003.12.31 7:25:14 PM  czhower
  Now works in .net

  Rev 1.2    10/4/2003 9:52:08 AM  GGrieve
  add IdCoreGlobal to uses list

  Rev 1.1    2003.10.01 1:12:30 AM  czhower
  .Net

  Rev 1.0    11/13/2002 08:37:36 AM  JPMugaas
}

unit IdAntiFreeze;

{
  NOTE - This unit must NOT appear in any Indy uses clauses. This is a ONE way
  relationship and is linked in IF the user uses this component. This is done to
  preserve the isolation from the massive FORMS unit.

  Because it links to Forms:

  - The Application.ProcessMessages cannot be done in IdCoreGlobal as an OS
    independent function, and thus this unit is allowed to violate the IFDEF
    restriction.
}

interface

uses
  Classes,
  IdAntiFreezeBase,
  IdBaseComponent;

{ Directive needed for C++Builder HPP and OBJ files for this that will force it
to be statically compiled into the code }

{$I IdCompilerDefines.inc}

{$IFDEF MSWINDOWS}
{$HPPEMIT '#pragma link "IdAntiFreeze.obj"'}    {Do not Localize}
{$ENDIF}

{$IFDEF LINUX}
{$HPPEMIT '#pragma link "IdAntiFreeze.o"'}    {Do not Localize}
{$ENDIF}

type
  TIdAntiFreeze = class(TIdAntiFreezeBase)
  public
    procedure Process; override;
    // This here and not the base class because it uses InMainThread, which is
    // not in DotNet right now. Can be moved back to base class and virtual
    // removed otherwise.
    class function ShouldUse: Boolean; override;
  end;

implementation

uses
  {$IFDEF LINUX}
  QForms,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  Forms,
  Messages,
  Windows,
  {$ENDIF}
  {$IFDEF DOTNET}
  System.Windows.Forms,
  {$ENDIF}
  IdGlobal;

{$IFDEF LINUX}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.ProcessMessages;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TIdAntiFreeze.Process;
var
  Msg: TMsg;
begin
  if ApplicationHasPriority then begin
    Application.ProcessMessages;
  end else begin
    // This guarantees it will not ever call Application.Idle
    if PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) then begin
      Application.HandleMessage;
    end;
  end;
end;
{$ENDIF}

{$IFDEF DOTNET}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.DoEvents;
end;
{$ENDIF}

class function TIdAntiFreeze.ShouldUse: Boolean;
begin
  // InMainThread - Only process if calling client is in the main thread
  Result := (GAntiFreeze <> nil) and InMainThread;
  if Result then begin
    Result := GAntiFreeze.Active;
  end;
end;

end.
