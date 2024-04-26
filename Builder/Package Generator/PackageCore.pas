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
{   Rev 1.5    3/3/2005 7:46:24 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.4    9/7/2004 3:50:46 PM  JPMugaas
{ Updates.
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
{   Rev 1.1    02/06/2004 17:00:46  HHariri
{ design-time added
}
{
{   Rev 1.0    2004.02.08 2:28:34 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageCore;

interface

uses
  Package;

type
  TPackageCore = class(TPackage)
  protected
    procedure GenOptions; override;
    procedure GenPreRequiresClause; override;
    procedure GenRequires; override;
    procedure GenFooter; override;
    procedure GenResourceScript; override;
    function IgnoreContainsFile(const AUnit: string): Boolean; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
    procedure GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils;

{ TPackageCore }

constructor TPackageCore.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\Core';
end;

procedure TPackageCore.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
var
  LFlags: TGenerateFlags;
begin
  LFlags := AFlags;
  if (LFlags * [gfRunTime, gfDesignTime]) = [] then begin
    Include(LFlags, gfRunTime);
  end;

  if gfRunTime in LFlags then begin
    FName := 'IndyCore' + GCompilerID[ACompiler];
    FDesc := 'Core';
    FExt := '.dpk';
    inherited Generate(ACompiler, LFlags - [gfDesignTime]);
    WriteFile;
  end;

  if gfDesignTime in LFlags then begin
    FName := 'dclIndyCore' + GCompilerID[ACompiler];
    FDesc := 'Core Design Time';
    FExt := '.dpk';
    inherited Generate(ACompiler, LFlags - [gfRunTime]);
    WriteFile;
  end;
end;

// TODO: make the options configurable...
procedure TPackageCore.GenOptions;
const
  Delphi_Native_Align8                    = Delphi_Native - [Delphi_Native_Lowest..ctDelphi13] + [ctDelphi2005];
  Delphi_OmittedOptions                   = [Delphi_Native_Lowest..ctDelphi13Net, ctKylix3] - [ctDelphi8Net] + [ctDelphiXE];
  Delphi_Native_Ifdef_ImplicitBuilding    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_DebugInfo_Off       = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE7];
  Delphi_Native_Force_Optimization_On     = Delphi_Native - [ctDelphiXE2..Delphi_Native_Highest] + Delphi_DotNet + [ctKylix3];
  Delphi_Native_Force_Optimization_Off    = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_OverflowChecks_Off  = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_RangeChecks_Off     = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Force_StackFrames_On      = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Define_DebugRelease       = [ctDelphiXE2..ctDelphiSydney];
  Delphi_Native_Define_Ver_DT             = [ctDelphiXE4..ctDelphiSydney] - [ctDelphiXE8..ctDelphiSeattle];
  Delphi_Native_Define_Ver_RT             = [ctDelphiXE4..ctDelphiSydney];
  Delphi_Force_ImplicitBuild_Off_DT       = [ctDelphiRio..ctDelphiTokyo, ctDelphi8Net];
  Delphi_Force_ImplicitBuild_Off_RT       = [ctDelphiXE4..ctDelphiTokyo, ctDelphi8Net];

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
  if FCompiler in Delphi_Native_Force_Optimization_On then begin
    Code('{$OPTIMIZATION ' + OnOrOff([], Delphi_Native_Force_Optimization_On, FDebug) + '}');
  end
  else if FCompiler in Delphi_Native_Force_Optimization_Off then begin
    Code('{$OPTIMIZATION ' + OnOrOff(Delphi_Native_Force_Optimization_Off, [], FDebug) + '}');
  end;
  if not (FCompiler in Delphi_OmittedOptions) then begin
    Code('{$OVERFLOWCHECKS ' + OnOrOff(Delphi_Native_Force_OverflowChecks_Off, [], FDebug) + '}');
    Code('{$RANGECHECKS ' + OnOrOff(Delphi_Native_Force_RangeChecks_Off, [], FDebug) + '}');
  end;
  Code('{$REFERENCEINFO ON}');
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
  if FDesignTime then begin
    if FCompiler in Delphi_Native_Define_Ver_DT then begin
      Code('{$DEFINE VER' + GCompilerVer[FCompiler] + '}');
    end;
  end else
  begin
    if FCompiler in Delphi_Native_Define_Ver_RT then begin
      Code('{$DEFINE VER' + GCompilerVer[FCompiler] + '}');
    end;
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

const
  DelphiNative_Ifdef_Rtl_2  = Delphi_Native_Ifdef_Rtl - [ctDelphiXE2];
  DelphiNative_Ifdef_Rtl_3  = DelphiNative_Ifdef_Rtl_2 - [ctDelphiXE3..ctDelphiXE4];

procedure TPackageCore.GenPreRequiresClause;
begin
  if (not FDesignTime) and (FCompiler in DelphiNative_Ifdef_Rtl_3) then begin
    Code('');
    Code('// RLebeau: cannot use IdCompilerDefines.inc here!');
  end;
end;

procedure TPackageCore.GenRequires;
begin
  if (not FDesignTime) and (FCompiler in DelphiNative_Ifdef_Rtl_2) then begin
    if FCompiler in Delphi_Native_Ifdef_Rtl_CheckIOS then begin
      Code('');
      Code('{$DEFINE HAS_PKG_RTL}');
      code('{$IFDEF NEXTGEN}');
      Code('  {$IFDEF IOS}');
      Code('    // there is no RTL package available for iOS');
      Code('    {$UNDEF HAS_PKG_RTL}');
      Code('  {$ENDIF}');
      Code('{$ENDIF}');
    end;
  end;
  Code('');
  Code('requires');
  if FDesignTime then begin
    if FCompiler = ctDelphi4 then begin
      Code('  Vcl40,');
    end
    else if FCompiler = ctDelphi5 then begin
      Code('  Vcl50,');
    end
    else if FCompiler in [ctDelphi6, ctDelphi7] then begin
      Code('  vcl,');
    end;
    if FCompiler in Delphi_DotNet then
    begin
      if FCompiler <> ctDelphi8Net then begin
        Code('  System.Windows.Forms,');
      end;
      Code('  Borland.Studio.Vcl.Design,');
    end
    else if not (FCompiler in [ctDelphi4..ctDelphi5]) then
    begin
      Code('  designide,');
    end;
    if FCompiler <> ctDelphi8Net then begin
      Code('  IndySystem' + GCompilerID[FCompiler] + ',');
    end;
    Code('  IndyCore' + GCompilerID[FCompiler] + ';');
  end else
  begin
    if FCompiler in Delphi_DotNet then begin
      Code('  Borland.Delphi,');
      Code('  Borland.VclRtl,');
    end
    else if FCompiler = ctDelphi4 then begin
      Code('  Vcl40,');
    end
    else if FCompiler = ctDelphi5 then begin
      Code('  Vcl50,');
    end else
    begin
      if FCompiler in DelphiNative_Ifdef_Rtl_2 then begin
        if FCompiler in Delphi_Native_Ifdef_Rtl_CheckIOS then begin
          Code('  {$IFDEF HAS_PKG_RTL}');
        end else begin
          Code('  {$IFNDEF NEXTGEN}');
        end;
      end;
      Code('  rtl,');
      if FCompiler in DelphiNative_Ifdef_Rtl_2 then begin
        Code('  {$ENDIF}');
      end;
    end;
    Code('  IndySystem' + GCompilerID[FCompiler] + ';');
  end;
end;

procedure TPackageCore.GenFooter;
begin
  if FCompiler in Delphi_DotNet then begin
    //back door for embedding version information into an assembly
    //without having to do anything to the package directly.
    Code(iif(FDesignTime, '{$I IddclCore90ASM90.inc}', '{$I IdCore90ASM90.inc}'));
  end;
  inherited GenFooter;
end;

procedure TPackageCore.GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags);
var
  LFlags: TGenerateFlags;
begin
  LFlags := AFlags;
  if (LFlags * [gfRunTime, gfDesignTime]) = [] then begin
    Include(LFlags, gfRunTime);
  end;

  if gfRunTime in LFlags then begin
    FName := 'IndyCore' + GCompilerID[ACompiler];
    FDesc := 'Core Run-Time';

    FExt := '.rc.tmpl';
    inherited GenerateRC(ACompiler, LFlags - [gfDesignTime] + [gfTemplate]);
    WriteFile;

    FExt := '.rc';
    inherited GenerateRC(ACompiler, LFlags - [gfDesignTime, gfTemplate]);
    WriteFile;
  end;

  if gfDesignTime in LFlags then begin
    FName := 'dclIndyCore' + GCompilerID[ACompiler];
    FDesc := 'Core Design-Time';

    FExt := '.rc.tmpl';
    inherited GenerateRC(ACompiler, LFlags - [gfRunTime] + [gfTemplate]);
    WriteFile;

    FExt := '.rc';
    inherited GenerateRC(ACompiler, LFlags - [gfRunTime, gfTemplate]);
    WriteFile;
  end;
end;

procedure TPackageCore.GenResourceScript;
begin
  inherited GenResourceScript;
  WriteFile;
end;

function TPackageCore.IgnoreContainsFile(const AUnit: string): Boolean;
begin
  if FDesignTime {and (FCompiler in [ctDelphi4..ctDelphi5])} then begin
    // TSelectionEditor was not available until Delphi 6...
    Result := SameText(AUnit, 'IdCoreSelectionEditors');
    if Result then Exit;
  end;
  Result := inherited IgnoreContainsFile(AUnit);
end;

end.

