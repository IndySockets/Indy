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
{   Rev 1.8    25/11/2004 8:10:20 AM  czhower
{ Removed D4, D8, D10, D11
}
{
{   Rev 1.7    2004.11.14 10:35:34 AM  czhower
{ Update
}
{
{   Rev 1.6    12/10/2004 17:51:36  HHariri
{ Fixes for VS
}
{
{   Rev 1.5    2004.08.30 11:27:56  czhower
{ Updates
}
{
{   Rev 1.4    2004.06.13 8:06:10 PM  czhower
{ Update for D8
}
{
{   Rev 1.3    09/06/2004 12:06:40  CCostelloe
{ Added Kylix 3
}
{
{   Rev 1.2    02/06/2004 17:00:44  HHariri
{ design-time added
}
{
{   Rev 1.1    2004.05.19 10:01:48 AM  czhower
{ Updates
}
{
{   Rev 1.0    2004.01.22 8:18:32 PM  czhower
{ Initial checkin
}
unit Package;

interface

uses
  Classes, IniFiles;

type
  TCompiler =(
   ctUnversioned,
   ctDelphi4,
   ctDelphi5,
   ctDelphi6,
   ctDelphi7,
   ctDelphi8, ctDelphi8Net,
   ctDelphi2005, ctDelphi2005Net,
   ctDelphi2006, ctDelphi2006Net,
   ctDelphi2007, ctDelphi2007Net,
   ctDelphi2009, ctDelphi2009Net,
   ctDelphi13, ctDelphi13Net, // was not released, skipped to v14 (D2010)
   ctDelphi2010,
   ctDelphiXE,
   ctDelphiXE2,
   ctDelphiXE3,
   ctDelphiXE4,
   ctDelphiXE5,
   ctDelphiXE6,
   ctDelphiXE7,
   ctDelphiXE8,
   ctDelphiSeattle,
   ctDelphiBerlin,
   ctDelphiTokyo,
   ctDelphiRio,
   ctDelphiSydney,
   ctDelphiAlexandria,
   ctDelphiAthens,
   ctDotNet, // Visual Studio
   ctKylix3);

  TCompilers = Set of TCompiler;

  TGenerateFlag = (gfRunTime, gfDesignTime, gfTemplate, gfDebug);
  TGenerateFlags = Set of TGenerateFlag;

const
  Delphi_DotNet                         = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net, ctDelphi2007Net, ctDelphi2009Net, ctDelphi13Net];
  Delphi_DotNet_1_1                     = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net];
  Delphi_DotNet_2_Or_Later              = [ctDelphi2007Net, ctDelphi2009Net, ctDelphi13Net];

  Delphi_Native_Lowest                  = ctDelphi4;
  Delphi_Native_Highest                 = ctDelphiAthens;
  Delphi_Native                         = [Delphi_Native_Lowest..Delphi_Native_Highest] - Delphi_DotNet;
  Delphi_Native_Ifdef_Rtl               = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Ifdef_Rtl_CheckIOS      = Delphi_Native_Ifdef_Rtl - [ctDelphiXE2..ctDelphiXE3];

  Delphi_NoVCLPosix                     = [Delphi_Native_Lowest..ctDelphiXE, ctKylix3] + Delphi_DotNet;

type
  TPackage = class
  protected
    FCode: TStringList;
    FCompiler: TCompiler;
    FContainsClause: string;
    FDesc: string;
    FDirs: TStringList;
    FExt: string;
    FName: string;
    FUnits: TStringList;
    FVersion: string;
    FDesignTime: Boolean;
    FDebug: Boolean;
    FTemplate: Boolean;
    FOutputSubDir: string;
    //
    procedure Code(const ACode: string);
    procedure GenHeader; virtual;
    procedure GenOptions; virtual;
    procedure GenPreRequiresClause; virtual;
    procedure GenRequires; virtual;
    procedure GenContains; overload; virtual;
    procedure GenContains(const aPrefix: string; const aWritePath: Boolean); overload; virtual;
    procedure GenFooter; virtual;
    procedure GenPreContainsClause; virtual;
    procedure GenPreContains; virtual;
    procedure GenPreContainsFile(const AUnit: string); virtual;
    procedure GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean); virtual;
    procedure GenResourceScript; virtual;
    function IgnoreContainsFile(const AUnit: string): Boolean; virtual;
    procedure WriteFile;
  public
    procedure Clear;
    procedure AddUnit(const AName: string; const ADir: string = '');
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Generate(ACompiler: TCompiler); overload;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); overload; virtual;
    procedure Generate(ACompilers: TCompilers); overload;
    procedure Generate(ACompilers: TCompilers; const AFlags: TGenerateFlags); overload; virtual;
    procedure GenerateRC(ACompiler: TCompiler); overload;
    procedure GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags); overload; virtual;
    procedure GenerateRC(ACompilers: TCompilers); overload;
    procedure GenerateRC(ACompilers: TCompilers; const AFlags: TGenerateFlags); overload; virtual;
    procedure Load(const ACriteria: string; const AUsePath: Boolean = False);
  end;

const
  GCompilerID: array[TCompiler] of string = (
    '',               // Unversioned
    '40',             // 4.0
    '50',             // 5.0
    '60',             // 6.0
    '70',             // 7.0
    '80', '80Net',    // 8.0
    '90', '90Net',    // 2005
    '100', '100Net',  // 2006
    '110', '110Net',  // 2007
    '120', '120Net',  // 2009
    '130', '130Net',  // was not released, skipped to v14 (D2010)
    '140',            // 2010
    '150',            // XE
    '160',            // XE2
    '170',            // XE3
    '180',            // XE4
    '190',            // XE5
    '200',            // XE6
    '210',            // XE7
    '220',            // XE8
    '230',            // 10.0 Seattle
    '240',            // 10.1 Berlin
    '250',            // 10.2 Tokyo
    '260',            // 10.3 Rio
    '270',            // 10.4 Sydney
    '280',            // 11.0 Alexandria
    '290',            // 12.0 Athens
    '',               // .NET
    'K3');            // Kylix

  GCompilerVer: array[TCompiler] of string = (
    '',               // Unversioned
    '120',            // 4.0
    '130',            // 5.0
    '140',            // 6.0
    '150',            // 7.0
    '160', '160',     // 8.0
    '170', '170',     // 2005
    '180', '180',     // 2006
    '185', '190',     // 2007
    '200', '200',     // 2009
    '',    '',        // was not released, skipped to v14 (D2010)
    '210',            // 2010
    '220',            // XE
    '230',            // XE2
    '240',            // XE3
    '250',            // XE4
    '260',            // XE5
    '270',            // XE6
    '280',            // XE7
    '290',            // XE8
    '300',            // 10.0 Seattle
    '310',            // 10.1 Berlin
    '320',            // 10.2 Tokyo
    '330',            // 10.3 Rio
    '340',            // 10.4 Sydney
    '350',            // 11.0 Alexandria
    '360',            // 12.0 Athens
    '',               // .NET
    '');              // Kylix

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;  overload;
function iif(ATest: Boolean; const ATrue: string; const AFalse: string): string; overload;
function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;

var
  IndyVersion_Major_Str: string = '';
  IndyVersion_Minor_Str: string = '';
  IndyVersion_Release_Str: string = '';
  IndyVersion_Build_Str: string = '';
  IndyVersion_Build_Template: string = '';

  IndyVersion_ProductVersion_Str: string = '';
  IndyVersion_FileVersion_Str: string = '';
  IndyVersion_FileVersion_Template: string = '';

  IndyVersion_VersionInfo_ProductVersion_Str: string = '';
  IndyVersion_VersionInfo_FileVersion_Str: string = '';
  IndyVersion_VersionInfo_FileVersion_Template: string = '';

implementation

uses
  SysUtils, DateUtils, DModule;

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: string; const AFalse: string): string;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

{ TPackage }

procedure TPackage.AddUnit(const AName: string; const ADir: string);
begin
  FUnits.Add(AName);
  FDirs.Add(ADir);
end;

procedure TPackage.Clear;
begin
  FCode.Clear;
  FDirs.Clear;
  FUnits.Clear;
end;

procedure TPackage.Code(const ACode: string);
begin
  FCode.Add(ACode);
end;

constructor TPackage.Create;
begin
  FContainsClause := 'contains';
  FExt := '.dpk';
  FVersion := IndyVersion_Major_Str;
  FCode := TStringList.Create;
  FDirs := TStringList.Create;
  FUnits := TStringList.Create;
end;

destructor TPackage.Destroy;
begin
  FreeAndNil(FUnits);
  FreeAndNil(FDirs);
  FreeAndNil(FCode);
  inherited;
end;

procedure TPackage.GenContains;
begin
  GenContains('', True);
end;

procedure TPackage.GenContains(const aPrefix: string; const aWritePath: Boolean);
var
  i: Integer;
  xPath, lastUnit, lastPath: string;
begin
  Code('');
  GenPreContainsClause;
  Code(FContainsClause);
  GenPreContains;
  lastUnit := '';
  lastPath := '';
  for i := 0 to FUnits.Count - 1 do begin
    if APrefix <> '' then begin
      FUnits[i] := StringReplace(FUnits[i], 'Id', APrefix, []);
    end;
    if not IgnoreContainsFile(FUnits[i]) then begin
      xPath := '';
      if aWritePath and (FDirs[i] <> '') then begin
        xPath := IncludeTrailingPathDelimiter(FDirs[i]);
      end;
      xPath := xPath + FUnits[i] + '.pas';
      if (lastUnit <> '') or (lastPath <> '') then begin
        GenPreContainsFile(lastUnit);
        Code('  ' + lastUnit + ' in ''' + lastPath + '''');
        GenPostContainsFile(lastUnit, False);
      end;
      lastUnit := FUnits[i];
      lastPath := xPath;
    end;
  end;
  if (lastUnit <> '') or (lastPath <> '') then begin
    GenPreContainsFile(lastUnit);
    Code('  ' + lastUnit + ' in ''' + lastPath + '''');
    GenPostContainsFile(lastUnit, True);
  end;
end;

procedure TPackage.GenPreContainsFile(const AUnit: string);
begin
end;

procedure TPackage.GenPostContainsFile(const AUnit: string; const AIsLastFile: Boolean);
begin
  if FCode.Count > 0 then begin
    FCode[FCode.Count-1] := FCode[FCode.Count-1] + iif(AIsLastFile, ';', ',');
  end;
end;

function TPackage.IgnoreContainsFile(const AUnit: string): Boolean;
begin
  Result := False;
end;

procedure TPackage.GenPreRequiresClause;
begin
end;

procedure TPackage.GenRequires;
begin
end;

procedure TPackage.GenFooter;
begin
  Code('');
  Code('end.');
end;

procedure TPackage.Generate(ACompiler: TCompiler);
begin
  Generate(ACompiler, [gfRunTime]);
end;

procedure TPackage.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FCompiler := ACompiler;
  FCode.Clear;
  FDesignTime := gfDesignTime in AFlags;
  FDebug := gfDebug in AFlags;
  GenHeader;
  GenOptions;
  GenPreRequiresClause;
  GenRequires;
  GenContains;
  GenFooter;
end;

procedure TPackage.Generate(ACompilers: TCompilers);
begin
  Generate(ACompilers, [gfRunTime]);
end;

procedure TPackage.Generate(ACompilers: TCompilers; const AFlags: TGenerateFlags);
var
  LCompiler: TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Generate(LCompiler, AFlags);
    end;
  end;
end;

procedure TPackage.GenerateRC(ACompiler: TCompiler);
begin
  GenerateRC(ACompiler, [gfRunTime]);
end;

procedure TPackage.GenerateRC(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FCompiler := ACompiler;
  FTemplate := gfTemplate in AFlags;
  FDebug := gfDebug in AFlags;
  if gfRunTime in AFlags then begin
    FCode.Clear;
    FDesignTime := False;
    GenResourceScript;
  end;
  if gfDesignTime in AFlags then begin
    FCode.Clear;
    FDesignTime := True;
    GenResourceScript;
  end;
end;

procedure TPackage.GenerateRC(ACompilers: TCompilers);
begin
  GenerateRC(ACompilers, [gfRunTime]);
end;

procedure TPackage.GenerateRC(ACompilers: TCompilers; const AFlags: TGenerateFlags);
var
  LCompiler: TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      GenerateRC(LCompiler, AFlags);
    end;
  end;
end;

procedure TPackage.GenHeader;
begin
  Code('package ' + FName + ';');
end;

// TODO: make the options configurable...
procedure TPackage.GenOptions;
const
  DelphiNative_Align8 = Delphi_Native - [Delphi_Native_Lowest..ctDelphi13] + [ctDelphi2005];
begin
  Code('');
  if FCompiler in Delphi_DotNet then begin
    Code('{$ALIGN 0}');
  end else begin
    Code('{$R *.res}');
    if FCompiler in DelphiNative_Align8 then begin
      Code('{$ALIGN 8}');
    end;
  end;
//  Code('{$ASSERTIONS ON}');
  Code('{$BOOLEVAL OFF}');
//  Code('{$DEBUGINFO ON}');
  Code('{$EXTENDEDSYNTAX ON}');
  Code('{$IMPORTEDDATA ON}');
//  Code('{$IOCHECKS ON}');
  Code('{$LOCALSYMBOLS ON}');
  Code('{$LONGSTRINGS ON}');
  Code('{$OPENSTRINGS ON}');
  Code('{$OPTIMIZATION ON}');
//  Code('{$OVERFLOWCHECKS ON}');
//  Code('{$RANGECHECKS ON}');
  Code('{$REFERENCEINFO ON}');
  Code('{$SAFEDIVIDE OFF}');
  Code('{$STACKFRAMES OFF}');
  Code('{$TYPEDADDRESS OFF}');
  Code('{$VARSTRINGCHECKS ON}');
  Code('{$WRITEABLECONST OFF}');
  Code('{$MINENUMSIZE 1}');
  Code('{$IMAGEBASE $400000}');
  Code('{$DESCRIPTION ''Indy ' + FVersion + TrimRight(' ' + FDesc) + '''}');
  Code(iif(FDesignTime, '{$DESIGNONLY}', '{$RUNONLY}'));
  Code('{$IMPLICITBUILD ON}');
end;

procedure TPackage.Load(const ACriteria: string; const AUsePath: Boolean = False);
var
  LFiles: TStringList;
  LDir: string;
  I: Integer;
begin
  Clear;
  LFiles := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LFiles);
    for I := 0 to LFiles.Count - 1 do
    begin
      if AUsePath then begin
        LDir := DM.Ini.ReadString(LFiles[I], 'Pkg', '');
      end else begin
        LDir := '';
      end;
      AddUnit(LFiles[I], LDir);
    end;
  finally
    LFiles.Free;
  end;
end;

procedure TPackage.WriteFile;
var
  LCodeOld: string;
  LPathname: string;
  LSubDir: string;
begin
  LPathname := SysUtils.IncludeTrailingPathDelimiter(DM.OutputPath);
  if FOutputSubDir <> '' then begin
    LSubDir := SysUtils.IncludeTrailingPathDelimiter(FOutputSubDir);
    LPathname := LPathname + LSubDir;
  end;
  LPathname := LPathname + FName + FExt;
  LCodeOld := '';
  if FileExists(LPathname) then begin
    with TStringList.Create do try
      LoadFromFile(LPathname);
      LCodeOld := Text;
    finally Free; end;
  end;
  // Only write out the code if its different. This prevents unnecessary checkins as well
  // as not requiring user to lock all packages
  if (LCodeOld = '') or (LCodeOld <> FCode.Text) then begin
    FCode.SaveToFile(LPathname);
    WriteLn('Generated ' + LSubDir + FName + FExt);
  end;
end;

procedure TPackage.GenPreContainsClause;
begin
end;

procedure TPackage.GenPreContains;
begin
end;

procedure TPackage.GenResourceScript;
var
  FileVersion : string;
begin
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.

  FileVersion := iif(FTemplate,
    IndyVersion_VersionInfo_FileVersion_Template,
    IndyVersion_VersionInfo_FileVersion_Str);

  Code('1 VERSIONINFO ');
  Code('FILEVERSION ' + FileVersion);
  Code('PRODUCTVERSION ' + FileVersion);
  Code('FILEFLAGSMASK 0x3FL');
  Code('FILEFLAGS 0x00L');
  Code('FILEOS 0x40004L');
  Code('FILETYPE 0x1L');

  FileVersion := iif(FTemplate,
    IndyVersion_FileVersion_Template,
    IndyVersion_FileVersion_Str);

  Code('FILESUBTYPE 0x0L');
  Code('{');
  Code(' BLOCK "StringFileInfo"');
  Code(' {');
  Code('  BLOCK "000104E4"');
  Code('  {');
  Code('   VALUE "CompanyName", "Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew\0"');
  Code('   VALUE "FileDescription", "Internet Direct (Indy) ' + IndyVersion_ProductVersion_Str + ' - ' + FDesc + ' Package\0"');
  Code('   VALUE "FileVersion", "' + FileVersion + '\0"');
  Code('   VALUE "InternalName", "' + FName + '\0"');
  Code('   VALUE "LegalCopyright", "Copyright © 1993 - ' + IntToStr(DateUtils.YearOf(Date)) + ' Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew\0"');
  Code('   VALUE "OriginalFilename", "' + FName + '.bpl\0"');
  Code('   VALUE "ProductName", "Indy\0"');
  Code('   VALUE "ProductVersion", "' + IndyVersion_ProductVersion_Str + '\0"');
  Code('  }');
  Code('');
  Code(' }');
  Code('');
  Code(' BLOCK "VarFileInfo"');
  Code(' {');
  Code('  VALUE "Translation", 0x0001, 1252');
  Code(' }');
  Code('');
  Code('}');
end;

procedure InitVersionNumbers;
var
  LMajor, LMinor, LRelease, LBuild, LPos: Integer;
  LParam: string;
begin
  if not FindCmdLineSwitch('version', LParam) then
    raise Exception.Create('Version parameter is missing');

  try
    LPos := Pos('.', LParam);
    LMajor := StrToInt(Copy(LParam, 1, LPos-1));
    Delete(LParam, 1, LPos);

    LPos := Pos('.', LParam);
    LMinor := StrToInt(Copy(LParam, 1, LPos-1));
    Delete(LParam, 1, LPos);

    LPos := Pos('.', LParam);
    LRelease := StrToInt(Copy(LParam, 1, LPos-1));
    Delete(LParam, 1, LPos);

    LBuild := StrToInt(LParam);
  except
    Exception.RaiseOuterException(Exception.Create('Version parameter value is invalid'));
    Exit;
  end;

  IndyVersion_Major_Str := IntToStr(LMajor);
  IndyVersion_Minor_Str := IntToStr(LMinor);
  IndyVersion_Release_Str := IntToStr(LRelease);
  IndyVersion_Build_Str := IntToStr(LBuild);
  IndyVersion_Build_Template := '$WCREV$';

  IndyVersion_ProductVersion_Str := Format('%d.%d.%d', [LMajor, LMinor, LRelease]);
  IndyVersion_FileVersion_Str := Format('%d.%d.%d.%d', [LMajor, LMinor, LRelease, LBuild]);
  IndyVersion_FileVersion_Template := Format('%d.%d.%d.%s', [LMajor, LMinor, LRelease, IndyVersion_Build_Template]);

  IndyVersion_VersionInfo_ProductVersion_Str := Format('%d,%d,%d', [LMajor, LMinor, LRelease]);
  IndyVersion_VersionInfo_FileVersion_Str := Format('%d,%d,%d,%d', [LMajor, LMinor, LRelease, LBuild]);
  IndyVersion_VersionInfo_FileVersion_Template := Format('%d,%d,%d,%s', [LMajor, LMinor, LRelease, IndyVersion_Build_Template]);
end;

initialization
  InitVersionNumbers;

end.
