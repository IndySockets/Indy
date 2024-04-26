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
{   Rev 1.10    3/4/2005 3:22:12 PM  JPMugaas
{ Updated for fix.
}
{
{   Rev 1.9    3/4/2005 3:12:40 PM  JPMugaas
{ Attempt to make D5 package work.
}
{
{   Rev 1.8    3/4/2005 3:02:06 PM  JPMugaas
{ Remove D5 VCL dependancy in run-time package.
}
{
{   Rev 1.7    3/3/2005 7:46:24 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.6    25/11/2004 8:10:22 AM  czhower
{ Removed D4, D8, D10, D11
}
{
{   Rev 1.5    9/7/2004 3:50:46 PM  JPMugaas
{ Updates.
}
{
{   Rev 1.4    04/09/2004 12:45:18  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.3    2004.08.30 11:27:58  czhower
{ Updates
}
{
{   Rev 1.2    03/06/2004 7:50:26  HHariri
{ Fixed Protocols Package Description
}
{
{   Rev 1.1    02/06/2004 17:00:46  HHariri
{ design-time added
}
{
{   Rev 1.0    2004.02.08 2:28:38 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageProtocols;

interface

uses
  Package;

type
  TPackageProtocols = class(TPackage)
  protected
    procedure GenOptions; override;
    procedure GenPreRequiresClause; override;
    procedure GenRequires; override;
    procedure GenPreContainsClause; override;
    procedure GenPreContainsFile(const AUnit: string); override;
    procedure GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean); override;
    procedure GenFooter; override;
    procedure GenResourceScript; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
    procedure GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils;

const
  Delphi_Native_Ifdef_Windows_In_Contains       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Ifdef_Rtl_2                     = Delphi_Native_Ifdef_Rtl - [ctDelphiXE2..ctDelphiXE3];
  Delphi_Native_Define_Windows_Before_Contains  = Delphi_Native_Ifdef_Windows_In_Contains;

{ TPackageProtocols }

constructor TPackageProtocols.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\Protocols';
end;

procedure TPackageProtocols.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
var
  LFlags: TGenerateFlags;
begin
  LFlags := AFlags;
  if (LFlags * [gfRunTime, gfDesignTime]) = [] then begin
    Include(LFlags, gfRunTime);
  end;

  if gfRunTime in LFlags then begin
    FName := 'IndyProtocols' + GCompilerID[ACompiler];
    FDesc := 'Protocols';
    FExt := '.dpk';
    inherited Generate(ACompiler, LFlags - [gfDesignTime]);
    WriteFile;
  end;

  if gfDesignTime in LFlags then begin
    FName := 'dclIndyProtocols' + GCompilerID[ACompiler];
    FDesc := 'Protocols Design Time';
    FExt := '.dpk';
    inherited Generate(ACompiler, LFlags - [gfRunTime]);
    WriteFile;
  end;
end;

// TODO: make the options configurable...
procedure TPackageProtocols.GenOptions;
const
  Delphi_Native_Align8                    = Delphi_Native - [Delphi_Native_Lowest..ctDelphi13] + [ctDelphi2005];
  Delphi_OmittedOptions_DT                = [Delphi_Native_Lowest..ctDelphiXE, ctKylix3] - [ctDelphi8Net];
  Delphi_OmittedOptions_RT                = [Delphi_Native_Lowest..ctDelphiXE, ctKylix3];
  Delphi_Native_Ifdef_ImplicitBuilding    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_DebugInfo_Off       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE7];
  Delphi_Native_Force_Optimization_Off    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_OverflowChecks_Off  = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_RangeChecks_Off     = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_StackFrames_On      = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Define_DebugRelease       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Define_Ver                = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE3];
  Delphi_Force_ImplicitBuild_Off_DT       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiSydney] + [ctDelphi8Net];
  Delphi_Force_ImplicitBuild_Off_RT       = [ctDelphiXE4..ctDelphiTokyo];

  function OnOrOff(const AForceOff, AForceOn: TCompilers; const ADefault: Boolean): string;
  begin
    if FCompiler in AForceOff then begin
      Result := 'OFF';
    end
    else if FCompiler in AForceOn then begin
      Result := 'ON';
    end
    else begin
      Result := iif(ADefault, 'ON', 'OFF');
    end;
  end;

begin
  Code('');
  if FCompiler in Delphi_DotNet then begin
    Code('{$ALIGN 0}');
  end else begin
    Code('{$R *.res}');
    if FCompiler in Delphi_Native_Ifdef_ImplicitBuilding then begin
      Code('{$IFDEF IMPLICITBUILDING This IFDEF should not be used by users}');
    end;
    if FCompiler in Delphi_Native_Align8 then begin
      Code('{$ALIGN 8}');
    end;
  end;
  if FDesignTime then begin
    if not (FCompiler in Delphi_OmittedOptions_DT) then begin
      Code('{$ASSERTIONS ON}');
    end;
  end else begin
    if not (FCompiler in Delphi_OmittedOptions_RT) then begin
      Code('{$ASSERTIONS ON}');
    end;
  end;
  Code('{$BOOLEVAL OFF}');
  if FDesignTime then begin
    if not (FCompiler in Delphi_OmittedOptions_DT) then begin
      Code('{$DEBUGINFO ' + OnOrOff(Delphi_Native_Force_DebugInfo_Off, [], FDebug) + '}');
    end;
  end else begin
    if not (FCompiler in Delphi_OmittedOptions_RT) then begin
      Code('{$DEBUGINFO ' + OnOrOff(Delphi_Native_Force_DebugInfo_Off, [], FDebug) + '}');
    end;
  end;
  Code('{$EXTENDEDSYNTAX ON}');
  Code('{$IMPORTEDDATA ON}');
  if FDesignTime then begin
    if not (FCompiler in Delphi_OmittedOptions_DT) then begin
      Code('{$IOCHECKS ON}');
    end;
  end else begin
    if not (FCompiler in Delphi_OmittedOptions_RT) then begin
      Code('{$IOCHECKS ON}');
    end;
  end;
  Code('{$LOCALSYMBOLS ' + OnOrOff([], [], FDebug) + '}');
  Code('{$LONGSTRINGS ON}');
  Code('{$OPENSTRINGS ON}');
  Code('{$OPTIMIZATION ' + OnOrOff(Delphi_Native_Force_Optimization_Off, [], FDebug) +'}');
  if FDesignTime then begin
    if not (FCompiler in Delphi_OmittedOptions_DT) then begin
      Code('{$OVERFLOWCHECKS ' + OnOrOff(Delphi_Native_Force_OverflowChecks_Off, [], FDebug) + '}');
      Code('{$RANGECHECKS ' + OnOrOff(Delphi_Native_Force_RangeChecks_Off, [], FDebug) + '}');
    end;
  end else begin
    if not (FCompiler in Delphi_OmittedOptions_RT) then begin
      Code('{$OVERFLOWCHECKS ' + OnOrOff(Delphi_Native_Force_OverflowChecks_Off, [], FDebug) + '}');
      Code('{$RANGECHECKS ' + OnOrOff(Delphi_Native_Force_RangeChecks_Off, [], FDebug) + '}');
    end;
  end;
  Code('{$REFERENCEINFO ' + OnOrOff([], [], FDebug) + '}');
  Code('{$SAFEDIVIDE OFF}');
  Code('{$STACKFRAMES ' + OnOrOff([], Delphi_Native_Force_StackFrames_On, not FDebug) + '}');
  Code('{$TYPEDADDRESS OFF}');
  Code('{$VARSTRINGCHECKS ON}');
  Code('{$WRITEABLECONST OFF}');
  Code('{$MINENUMSIZE 1}');
  Code('{$IMAGEBASE $400000}');
  if FCompiler in Delphi_Native_Define_DebugRelease then begin
    Code('{$DEFINE ' + iif(FDebug, 'DEBUG', 'RELEASE') + '}');
  end;
  if FCompiler in Delphi_Native_Define_Ver then begin
    Code('{$DEFINE VER' + GCompilerVer[FCompiler] + '}');
  end;
  if FCompiler in Delphi_Native_Ifdef_ImplicitBuilding then begin
    Code('{$ENDIF IMPLICITBUILDING}');
  end;
  Code('{$DESCRIPTION ''Indy ' + FVersion + TrimRight(' ' + FDesc) + '''}');
  Code(iif(FDesignTime, '{$DESIGNONLY}', '{$RUNONLY}'));
  if FDesignTime then begin
    Code('{$IMPLICITBUILD ' + OnOrOff(Delphi_Force_ImplicitBuild_Off_DT, [], True) + '}');
  end else begin
    Code('{$IMPLICITBUILD ' + OnOrOff(Delphi_Force_ImplicitBuild_Off_RT, [], True) + '}');
  end;
end;

procedure TPackageProtocols.GenPreRequiresClause;
begin
  if not FDesignTime then begin
    if (FCompiler in Delphi_Native_Ifdef_Rtl) or
       (FCompiler in Delphi_Native_Ifdef_Windows_In_Contains) then
    begin
      Code('');
      Code('// RLebeau: cannot use IdCompilerDefines.inc here!');
    end;
  end;
end;

procedure TPackageProtocols.GenRequires;
begin
  Code('');
  if (not FDesignTime) and (FCompiler in Delphi_Native_Ifdef_Rtl_2) then begin
    Code('{$DEFINE HAS_PKG_RTL}');
    code('{$IFDEF NEXTGEN}');
    Code('  {$IFDEF IOS}');
    Code('    // there is no RTL package available for iOS');
    Code('    {$UNDEF HAS_PKG_RTL}');
    Code('  {$ENDIF}');
    Code('{$ENDIF}');
    Code('');
  end;
  Code('requires');
  if FDesignTime then begin
    if FCompiler in Delphi_DotNet then
    begin
      Code('  System.Windows.Forms,');
      Code('  Borland.Studio.Vcl.Design,');
    end
    else if FCompiler = ctDelphi4 then
    begin
      Code('  Vcl40,');
    end
    else if FCompiler = ctDelphi5 then
    begin
      Code('  Vcl50,');
    end else
    begin
      if FCompiler in [ctDelphi6, ctDelphi7] then
      begin
        Code('  vcl,');
      end;
      Code('  designide,');
    end;
    Code('  IndyProtocols' + GCompilerID[FCompiler] + ',');
    Code('  IndySystem' + GCompilerID[FCompiler] + ',');
    Code('  IndyCore' + GCompilerID[FCompiler] + ',');
    Code('  dclIndyCore' + GCompilerID[FCompiler] + ';');
  end else
  begin
    if FCompiler in Delphi_DotNet then begin
      Code('  Borland.Delphi,');
      Code('  Borland.VclRtl,');
    end
    else if FCompiler = ctDelphi4 then begin
      //Code('  Vcl40,');
    end
    else if FCompiler = ctDelphi5 then begin
      //Code('  Vcl50,');
    end else
    begin
      if FCompiler in Delphi_Native_Ifdef_Rtl_2 then begin
        Code('  {$IFDEF HAS_PKG_RTL}');
      end
      else if FCompiler = ctDelphiXE3 then begin
        Code('  {$IFNDEF NEXTGEN}');
      end;
      Code('  rtl,');
      if (FCompiler in Delphi_Native_Ifdef_Rtl_2) or
         (FCompiler = ctDelphiXE3) then
      begin
        Code('  {$ENDIF}');
      end;
    end;
    Code('  IndySystem' + GCompilerID[FCompiler] + ',');
    Code('  IndyCore' + GCompilerID[FCompiler] + ';');
  end;
end;

procedure TPackageProtocols.GenPreContainsClause;
begin
  if (not FDesignTime) and
     (FCompiler in Delphi_Native_Define_Windows_Before_Contains) then
  begin
    Code('{$IFNDEF WINDOWS}');
    Code('  {$IFDEF MSWINDOWS}');
    Code('    {$DEFINE WINDOWS}');
    Code('  {$ENDIF}');
    Code('{$ENDIF}');
    Code('');
  end;
end;

procedure TPackageProtocols.GenPreContainsFile(const AUnit: string);
begin
  if FCompiler in Delphi_Native_Ifdef_Windows_In_Contains then begin
    if SameText(AUnit, 'IdAuthenticationSSPI') or
       SameText(AUnit, 'IdSSPI') then
    begin
      Code('  {$IFDEF WINDOWS}');
    end;
  end;
end;

procedure TPackageProtocols.GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean);
begin
  if FCompiler in Delphi_Native_Ifdef_Windows_In_Contains then begin
    if SameText(AUnit, 'IdAuthenticationSSPI') or
       SameText(AUnit, 'IdSSPI') then
    begin
      inherited GenPostContainsFile(AUnit, AIsLastFile);
      Code('  {$ENDIF}');
      Exit;
    end;
  end;
  inherited GenPostContainsFile(AUnit, AIsLastFile);
end;

procedure TPackageProtocols.GenFooter;
begin
  if FCompiler in Delphi_DotNet then begin
    //back door for embedding version information into an assembly
    //without having to do anything to the package directly.
    Code(iif(FDesignTime, '{$I IddclProtocols90ASM90.inc}', '{$I IdProtocols90ASM90.inc}'));
  end;
  inherited GenFooter;
end;

procedure TPackageProtocols.GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags);
var
  LFlags: TGenerateFlags;
begin
  LFlags := AFlags;
  if (LFlags * [gfRunTime, gfDesignTime]) = [] then begin
    Include(LFlags, gfRunTime);
  end;

  if gfRunTime in LFlags then begin
    FName := 'IndyProtocols' + GCompilerID[ACompiler];
    FDesc := 'Protocols Run-Time';

    FExt := '.rc.tmpl';
    inherited GenerateRC(ACompiler, LFlags - [gfDesignTime] + [gfTemplate]);
    WriteFile;

    FExt := '.rc';
    inherited GenerateRC(ACompiler, LFlags - [gfDesignTime, gfTemplate]);
    WriteFile;
  end;

  if gfDesignTime in LFlags then begin
    FName := 'dclIndyProtocols' + GCompilerID[ACompiler];
    FDesc := 'Protocols Design-Time';

    FExt := '.rc.tmpl';
    inherited GenerateRC(ACompiler, LFlags - [gfRunTime] + [gfTemplate]);
    WriteFile;

    FExt := '.rc';
    inherited GenerateRC(ACompiler, LFlags - [gfRunTime, gfTemplate]);
    WriteFile;
  end;
end;

procedure TPackageProtocols.GenResourceScript;
begin
  inherited GenResourceScript;
  WriteFile;
end;

end.

