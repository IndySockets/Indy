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

{$IFDEF VCL_10_3_OR_ABOVE}
  // until Delphi 10.3.2 can be detected in IdCompilerDefines.inc,
  // use {$IF DECLARED(...) here to enable the new platform values...)
  {$IFNDEF VCL_10_3_UPDATE2_OR_ABOVE} // TODO: does RTLVersion1032 exist?
    {$IF DECLARED(pidAllPlatforms)}
      {$DEFINE HAS_ComponentPlatformsAttribute_AllPlatforms}
      {$DEFINE HAS_ComponentPlatformsAttribute_OSX64}
    {$IFEND}
  {$ENDIF}
{$ENDIF}

type
  {$IFDEF HAS_ComponentPlatformsAttribute}
  [ComponentPlatformsAttribute(
    {$IFDEF HAS_ComponentPlatformsAttribute_AllPlatforms}pidAllPlatforms
    {$ELSE}
    pidWin32
    {$IFDEF HAS_ComponentPlatformsAttribute_Win64} or pidWin64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_OSX32} or pidOSX32{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Simulator32}or pidiOSSimulator32{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Simulator} or pidiOSSimulator{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_AndroidArm32} or pidAndroidArm32{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Android32Arm} or pidAndroid32Arm{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Android} or pidAndroid{$ENDIF}{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_Linux32} or pidLinux32{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Device32} or pidiOSDevice32{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Device} or pidiOSDevice{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_Linux64} or pidLinux64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_WinNX32} or pidWinNX32{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_WinIoT32} or pidWinIoT32{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Device64} or pidiOSDevice64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_WinARM32} or pidWinARM32{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Win32ARM} or pidWin32ARM{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_WinARM} or pidWinARM{$ENDIF}{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_OSXNX64} or pidOSXNX64{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_OSX64} or pidOSX64{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_LinuxArm32} or pidLinuxArm32{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Linux32Arm} or pidLinux32Arm{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_LinuxArm64} or pidLinuxArm64{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Linux64Arm} or pidLinux64Arm{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_AndroidArm64} or pidAndroidArm64{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Android64Arm} or pidAndroid64Arm{$ELSE}
    {$IFDEF HAS_ComponentPlatformsAttribute_Android64} or pidAndroid64{$ENDIF}{$ENDIF}{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_Simulator64} or pidiOSSimulator64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_OSXArm64} or pidOSXArm64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_WinArm64} or pidWinArm64{$ENDIF}
    {$IFDEF HAS_ComponentPlatformsAttribute_iOS_SimulatorArm64} or pidiOSSimulatorArm64{$ENDIF}
    {$ENDIF}
  )]
  {$ENDIF}
  TIdAntiFreeze = class(TIdAntiFreezeBase)
  public
    procedure Process; override;
  end;

implementation

uses
  {$IFDEF WIDGET_KYLIX}
  QForms,
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE}
  Forms,
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFNDEF FMX}
  Messages,
  Windows,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIDGET_WINFORMS}
  System.Windows.Forms,
  {$ENDIF}
  IdGlobal;

{$IFDEF UNIX}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.ProcessMessages;
end;
{$ENDIF}

{$IFDEF WINDOWS}

  {$IFNDEF FMX}
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
  {$ELSE}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.ProcessMessages;
end;
  {$ENDIF}

{$ENDIF}

{$IFDEF WIDGET_WINFORMS}
procedure TIdAntiFreeze.Process;
begin
  //TODO: Handle ApplicationHasPriority
  Application.DoEvents;
end;
{$ENDIF}

end.
