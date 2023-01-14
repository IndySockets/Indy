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

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdAntiFreezeBase,
  IdBaseComponent;

{ Directive needed for generating a legacy non-UnitScoped C++Builder HPP }

{$IFDEF HAS_DIRECTIVE_HPPEMIT_LEGACYHPP}
  {$HPPEMIT LEGACYHPP}
{$ENDIF}

{ Directive needed for C++Builder HPP to force static linking to this unit }

{$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$IFDEF WINDOWS}
    {$HPPEMIT '#pragma link "IdAntiFreeze"'}    {Do not Localize}
  {$ENDIF}
  {$IFDEF UNIX}
    {$HPPEMIT '#pragma link "IdAntiFreeze.o"'}    {Do not Localize}
  {$ENDIF}
{$ENDIF}

type
  {$IFDEF HAS_ComponentPlatformsAttribute}
  [ComponentPlatformsAttribute(
    {$IF DECLARED(pidAllPlatforms)}pidAllPlatforms
    {$ELSE}
    pidWin32
    {$IF DECLARED(pidWin64)} or pidWin64{$IFEND}
    {$IF DECLARED(pidOSX32)} or pidOSX32{$IFEND}
    {$IF DECLARED(pidiOSSimulator32)}or pidiOSSimulator32
    {$ELSEIF DECLARED(pidiOSSimulator)} or pidiOSSimulator{$IFEND}
    {$IF DECLARED(pidAndroidArm32)} or pidAndroidArm32
    {$ELSEIF DECLARED(pidAndroid32Arm)} or pidAndroid32Arm
    {$ELSEIF DECLARED(pidAndroid)} or pidAndroid{$IFEND}
    {$IF DECLARED(pidLinux32)} or pidLinux32{$IFEND}
    {$IF DECLARED(pidiOSDevice32)} or pidiOSDevice32
    {$ELSEIF DECLARED(pidiOSDevice)} or pidiOSDevice{$IFEND}
    {$IF DECLARED(pidLinux64)} or pidLinux64{$IFEND}
    {$IF DECLARED(pidWinNX32)} or pidWinNX32{$IFEND}
    {$IF DECLARED(pidWinIoT32)} or pidWinIoT32{$IFEND}
    {$IF DECLARED(pidiOSDevice64)} or pidiOSDevice64{$IFEND}
    {$IF DECLARED(pidWinARM32)} or pidWinARM32
    {$ELSEIF DECLARED(pidWin32ARM)} or pidWin32ARM
    {$ELSEIF DECLARED(pidWinARM)} or pidWinARM{$IFEND}
    {$IF DECLARED(pidOSXNX64)} or pidOSXNX64
    {$ELSEIF DECLARED(pidOSX64)} or pidOSX64{$IFEND}
    {$IF DECLARED(pidLinuxArm32)} or pidLinuxArm32
    {$ELSEIF DECLARED(pidLinux32Arm)} or pidLinux32Arm{$IFEND}
    {$IF DECLARED(pidLinuxArm64)} or pidLinuxArm64
    {$ELSEIF DECLARED(pidLinux64Arm)} or pidLinux64Arm{$IFEND}
    {$IF DECLARED(pidAndroidArm64)} or pidAndroidArm64
    {$ELSEIF DECLARED(pidAndroid64Arm)} or pidAndroid64Arm
    {$ELSEIF DECLARED(pidAndroid64)} or pidAndroid64{$IFEND}
    {$IF DECLARED(pidiOSSimulator64)} or pidiOSSimulator64{$IFEND}
    {$IF DECLARED(pidOSXArm64)} or pidOSXArm64{$IFEND}
    {$IF DECLARED(pidWinArm64)} or pidWinArm64{$IFEND}
    {$IF DECLARED(pidiOSSimulatorArm64)} or pidiOSSimulatorArm64{$IFEND}
    {$IFEND}
  )]
  {$ENDIF}
  TIdAntiFreeze = class(TIdAntiFreezeBase)
  public
    procedure Process; override;
  end;

implementation

uses
  {$IFDEF WIDGET_VCL_LIKE}
  Forms,
  {$ENDIF}
  {$IF DEFINED(WINDOWS) AND (NOT DEFINED(FMX))}
  Messages,
  Windows,
  {$IFEND}
  IdGlobal;

{$IF DEFINED(UNIX) OR (DEFINED(WINDOWS) AND DEFINED(FMX))}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.ProcessMessages;
end;
{$ELSEIF DEFINED(WINDOWS)}
procedure TIdAntiFreeze.Process;
var
  LMsg: TMsg;
begin
  if ApplicationHasPriority then begin
    Application.ProcessMessages;
  end else begin
    // This guarantees it will not ever call Application.Idle
    if PeekMessage(LMsg, 0, 0, 0, PM_NOREMOVE) then begin
      Application.HandleMessage;
    end;
  end;
end;
{$IFEND}

end.
