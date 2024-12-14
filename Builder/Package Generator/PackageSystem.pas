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
{   Rev 1.4    3/3/2005 7:46:24 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.3    04/09/2004 12:45:16  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.2    2004.06.13 8:06:12 PM  czhower
{ Update for D8
}
{
{   Rev 1.1    02/06/2004 17:00:48  HHariri
{ design-time added
}
{
{   Rev 1.0    2004.02.08 2:28:40 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageSystem;

interface

uses
  Package;

type
  TPackageSystem = class(TPackage)
  protected
    procedure GenOptions; override;
    procedure GenPreRequiresClause; override;
    procedure GenRequires; override;
    procedure GenPreContainsClause; override;
    procedure GenPreContainsFile(const AUnit: string); override;
    procedure GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean); override;
    function IgnoreContainsFile(const AUnit: string): Boolean; override;
    procedure GenFooter; override;
    procedure GenResourceScript; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
    procedure GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  DModule, SysUtils;

const
  Delphi_Native_Ifdef_Windows_In_Contains       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Define_Windows_Before_Requires  = [ctDelphiXE8..ctDelphiTokyo];
  Delphi_Native_Ifdef_Requires                  = Delphi_Native_Ifdef_Rtl - Delphi_Native_Define_Windows_Before_Requires;
  Delphi_Native_Define_Windows_Before_Contains  = Delphi_Native_Ifdef_Windows_In_Contains - Delphi_Native_Define_Windows_Before_Requires;
  Delphi_Native_Ifdef_Fmx                       = Delphi_Native_Define_Windows_Before_Requires;

{ TPackageSystem }

constructor TPackageSystem.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\System';
end;

procedure TPackageSystem.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FName := 'IndySystem' + GCompilerID[ACompiler];
  FDesc := 'System';
  FExt := '.dpk';
  inherited Generate(ACompiler, AFlags - [gfDesignTime]);
  WriteFile;
end;

// TODO: make the options configurable...
procedure TPackageSystem.GenOptions;
const
  Delphi_Native_Align8                    = Delphi_Native - [Delphi_Native_Lowest..ctDelphi13] + [ctDelphi2005];
  Delphi_OmittedOptions                   = [Delphi_Native_Lowest..ctDelphiXE, ctKylix3] - [ctDelphi8Net];
  Delphi_Native_Ifdef_ImplicitBuilding    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_DebugInfo_Off       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE7];
  Delphi_Native_Force_Optimization_On     = [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_Optimization_Off    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_OverflowChecks_Off  = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_RangeChecks_Off     = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_StackFrames_Off     = Delphi_Native - [ctDelphiXE2..Delphi_Native_Highest] + Delphi_DotNet + [ctKylix3];
  Delphi_Native_Force_StackFrames_On      = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Define_DebugRelease       = [ctDelphiXE2..ctDelphiSydney];
  Delphi_Native_Define_Ver                = [ctDelphiXE4..ctDelphiSydney];
  Delphi_Force_ImplicitBuild_Off          = [ctDelphiXE4..ctDelphiTokyo, ctDelphi8Net];

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
  if not (FCompiler in Delphi_OmittedOptions) then begin
    Code('{$ASSERTIONS ON}');
  end;
  Code('{$BOOLEVAL OFF}');
  if not (FCompiler in Delphi_OmittedOptions) then begin
    Code('{$DEBUGINFO ' + OnOrOff(Delphi_Native_Force_DebugInfo_Off, [], FDebug) + '}');
  end;
  Code('{$EXTENDEDSYNTAX ON}');
  Code('{$IMPORTEDDATA ON}');
  if not (FCompiler in Delphi_OmittedOptions) then begin
    Code('{$IOCHECKS ON}');
  end;
  Code('{$LOCALSYMBOLS ON}');
  Code('{$LONGSTRINGS ON}');
  Code('{$OPENSTRINGS ON}');
  Code('{$OPTIMIZATION ' + OnOrOff(Delphi_Native_Force_Optimization_Off, Delphi_Native_Force_Optimization_On, FDebug) + '}');
  if not (FCompiler in Delphi_OmittedOptions) then begin
    Code('{$OVERFLOWCHECKS ' + OnOrOff(Delphi_Native_Force_OverflowChecks_Off, [], FDebug) + '}');
    Code('{$RANGECHECKS ' + OnOrOff(Delphi_Native_Force_RangeChecks_Off, [], FDebug) + '}');
  end;
  Code('{$REFERENCEINFO ON}');
  Code('{$SAFEDIVIDE OFF}');
  Code('{$STACKFRAMES ' + OnOrOff(Delphi_Native_Force_StackFrames_Off, Delphi_Native_Force_StackFrames_On, {not} FDebug) + '}');
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
  Code('{$IMPLICITBUILD ' + OnOrOff(Delphi_Force_ImplicitBuild_Off, [], True) + '}');
end;

procedure TPackageSystem.GenPreRequiresClause;
begin
  if (FCompiler in Delphi_Native_Ifdef_Rtl) or
     (FCompiler in Delphi_Native_Ifdef_Windows_In_Contains) then
  begin
    Code('');
    Code('// RLebeau: cannot use IdCompilerDefines.inc here!');
  end;
  if FCompiler in Delphi_Native_Define_Windows_Before_Requires then begin
    Code('');
    Code('{$IFNDEF WINDOWS}');
    Code('  {$IFDEF MSWINDOWS}');
    Code('    {$DEFINE WINDOWS}');
    Code('  {$ENDIF}');
    Code('{$ENDIF}')
  end;
end;

procedure TPackageSystem.GenRequires;
begin
  Code('');
  if FCompiler in Delphi_Native_Ifdef_Requires then begin
    if FCompiler in Delphi_Native_Ifdef_Rtl_CheckIOS then begin
      Code('{$DEFINE HAS_PKG_RTL}');
      code('{$IFDEF NEXTGEN}');
      Code('  {$IFDEF IOS}');
      Code('    // there is no RTL package available for iOS');
      Code('    {$UNDEF HAS_PKG_RTL}');
      Code('  {$ENDIF}');
      Code('{$ENDIF}');
      Code('');
      Code('{$IFDEF HAS_PKG_RTL}');
    end else begin
      Code('{$IFNDEF NEXTGEN}');
    end;
  end;
  Code('requires');
  if FCompiler in Delphi_DotNet then begin
    Code('  Borland.Delphi,');
    Code('  Borland.VclRtl;');
  end
  else if FCompiler = ctDelphi4 then begin
    Code('  Vcl40;');
  end
  else if FCompiler = ctDelphi5 then begin
    Code('  Vcl50;');
  end
  else if FCompiler in Delphi_Native_Ifdef_Fmx then begin
    Code('  rtl');
    Code('  {$IFNDEF WINDOWS}');
    Code('  , fmx');
    Code('  {$ENDIF}');
    Code('  ;');
  end
  else begin
    Code('  rtl;');
  end;
  if FCompiler in Delphi_Native_Ifdef_Requires then begin
    Code('{$ENDIF}');
  end;
end;

procedure TPackageSystem.GenPreContainsClause;
begin
  if FCompiler in Delphi_Native_Define_Windows_Before_Contains then begin
    Code('{$IFNDEF WINDOWS}');
    Code('  {$IFDEF MSWINDOWS}');
    Code('    {$DEFINE WINDOWS}');
    Code('  {$ENDIF}');
    Code('{$ENDIF}');
    Code('');
  end;
end;

procedure TPackageSystem.GenPreContainsFile(const AUnit: string);
begin
  if FCompiler in Delphi_Native_Ifdef_Windows_In_Contains then begin
    if SameText(AUnit, 'IdResourceStringsUnix') then begin
      Code('  {$IFNDEF WINDOWS}');
    end
    else if SameText(AUnit, 'IdStackWindows') or
            SameText(AUnit, 'IdWinsock2') then
    begin
      Code('  {$IFDEF WINDOWS}');
    end
    else if SameText(AUnit, 'IdStackVCLPosix') or
            SameText(AUnit, 'IdVCLPosixSupplemental') then
    begin
      Code('  {$ELSE}');
    end;
  end;
end;

procedure TPackageSystem.GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean);
begin
  if FCompiler in Delphi_Native_Ifdef_Windows_In_Contains then begin
    if SameText(AUnit, 'IdResourceStringsVCLPosix') or
       SameText(AUnit, 'IdStackVCLPosix') then
    begin
      inherited GenPostContainsFile(AUnit, AIsLastFile);
      Code('  {$ENDIF}');
      Exit;
    end;
    if SameText(AUnit, 'IdVCLPosixSupplemental') then
    begin
      Code('  {$ENDIF}');
      Code('  ');
    end
    else if SameText(AUnit, 'IdWship6') then begin
      Exit;
    end;
  end;
  inherited GenPostContainsFile(AUnit, AIsLastFile);
end;

function TPackageSystem.IgnoreContainsFile(const AUnit: string): Boolean;
begin
  if FCompiler in Delphi_NoVCLPosix then begin
    // can't use Ini.ReadBool() because it only handles '0'/'1', not 'False'/'True'
    //Result := DM.Ini.ReadBool(AUnit, 'VCLPosix', False);
    Result := StrToBoolDef(DM.Ini.ReadString(AUnit, 'VCLPosix', ''), False);
    if Result then Exit;
  end;
  Result := inherited IgnoreContainsFile(AUnit);
end;

procedure TPackageSystem.GenFooter;
begin
  if FCompiler in Delphi_DotNet then begin
    //back door for embedding version information into an assembly
    //without having to do anything to the package directly.
    Code('{$I IdSystem90ASM90.inc}');
  end;
  inherited GenFooter;
end;

procedure TPackageSystem.GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FName := 'IndySystem' + GCompilerID[ACompiler];
  FDesc := 'System Run-Time';

  FExt := '.rc.tmpl';
  inherited GenerateRC(ACompiler, AFlags - [gfDesignTime] + [gfTemplate]);
  WriteFile;

  FExt := '.rc';
  inherited GenerateRC(ACompiler, AFlags - [gfDesignTime, gfTemplate]);
  WriteFile;
end;

procedure TPackageSystem.GenResourceScript;
begin
  inherited GenResourceScript;
  WriteFile;
end;

end.

