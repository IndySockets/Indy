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
  Rev 1.1    9/15/2004 5:04:20 PM  DSiders
  Added localization comments.

  Rev 1.0    2004.02.03 12:39:04 AM  czhower
  Move

  Rev 1.5    2003.10.19 4:38:36 PM  czhower
  Updates

  Rev 1.4    2003.10.19 2:50:40 PM  czhower
  Fiber cleanup

  Rev 1.3    2003.10.19 1:04:28 PM  czhower
  Updates

  Rev 1.2    2003.08.20 1:45:14 PM  czhower
  Fixes.

  Rev 1.1    8/19/2003 12:16:32 PM  JPMugaas
  Should now compile in new packages.

  Rev 1.0    8/16/2003 11:03:52 AM  JPMugaas
  Moved from Core as part of a package reorganization
}

unit IdSuperCoreRegister;

interface

uses
  Classes;

{
  Note:  We separate this from IdCoreRegister because in Delphi 7,
  these will be in a separate package.  This is particularly important as
  some of this is in a different stage of development than most of Indy 10.
}

procedure Register;

implementation

uses
  IdDsnCoreResourceStrings,
  IdFiberWeaverInline,
  IdIOHandlerChain,
  IdServerIOHandlerChain,
  IdFiberWeaverThreaded,
  IdSchedulerOfFiber;

{$I ..\Core\IdCompilerDefines.inc}

{$IFDEF DOTNET}
  {$R IconsDotNet\TIdChainEngine.bmp}
  {$R IconsDotNet\TIdFiberWeaverInline.bmp}
  {$R IconsDotNet\TIdFiberWeaverThreaded.bmp}
  {$R IconsDotNet\TIdSchedulerOfFiber.bmp}
  {$R IconsDotNet\TIdServerIOHandlerChain.bmp}
{$ELSE}
  {$IFDEF Borland}
    {$R IdSuperCoreRegister.dcr}
  {$ELSE}
    {$R IdSuperCoreRegisterCool.dcr}
  {$ENDIF}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Indy Super Core',  {do not localize}
  [ TIdChainEngine,
    TIdFiberWeaverInline,
    TIdFiberWeaverThreaded,
    TIdSchedulerOfFiber,
    TIdServerIOHandlerChain
   ]);
end;

end.
