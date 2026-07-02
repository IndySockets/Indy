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
  Classes,
  IniFiles;

type
  TCompiler = (
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
    ctDelphiPre2010NR, ctDelphiPre2010NRNet, // was not released, skipped to v14 (D2010)
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
    ctDelphiFlorence,
    ctDotNet,                           // Visual Studio
    ctKylix3
  );

  TCompilers = set of TCompiler;

  TGenerateFlag = (
    gfRunTime, gfDesignTime, gfTemplate, gfDebug
  );
  TGenerateFlags = set of TGenerateFlag;

const
  Delphi_DotNet = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net, ctDelphi2007Net, ctDelphi2009Net, ctDelphiPre2010NRNet];
  Delphi_DotNet_1_1 = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net];
  Delphi_DotNet_2_Or_Later = [ctDelphi2007Net, ctDelphi2009Net, ctDelphiPre2010NRNet];

  Delphi_Native_Lowest = ctDelphi4;
  Delphi_Native_Highest = ctDelphiFlorence;
  Delphi_Native = [Delphi_Native_Lowest..Delphi_Native_Highest] - Delphi_DotNet;
  Delphi_Native_Ifdef_Rtl = Delphi_Native - [Delphi_Native_Lowest..ctDelphiXE];
  Delphi_Native_Ifdef_Rtl_CheckIOS = Delphi_Native_Ifdef_Rtl - [ctDelphiXE2..ctDelphiXE3];

  Delphi_NoVCLPosix = [Delphi_Native_Lowest..ctDelphiXE, ctKylix3] + Delphi_DotNet;

  // Native Delphi versions that support the LIBSUFFIX feature (Delphi 6+).
  // These drop the version suffix from the package filename/identifier and
  // instead carry it via a {$LIBSUFFIX} directive, so the .bpl name is unchanged.
  // (Delphi 4/5 predate LIBSUFFIX, and .NET/Kylix do not use it, so those keep
  //  the suffix baked into the package name.)
  Delphi_Native_LibSuffix = Delphi_Native - [ctDelphi4, ctDelphi5];
  // Delphi 11+ can use the automatic LIBSUFFIX feature ({$LIBSUFFIX AUTO}).
  Delphi_Native_LibSuffix_Auto = [ctDelphiAlexandria..Delphi_Native_Highest] ;
  // Native Delphi versions whose IDE project format is .dproj (MSBuild). Delphi 2007
  // introduced .dproj; earlier versions used .dpk(+.cfg) / .bdsproj and get no .dproj.
  // (ctDelphiPre2010NR / the .NET variants are excluded.)
  Delphi_Native_Dproj = [ctDelphi2007..Delphi_Native_Highest];

  // Stable per-package ProjectGuid values (used for the .dproj <ProjectGuid>).
  GuidIndySystem       = '{168608C4-572C-4A59-BDC9-217C6E49D16A}';
  GuidIndyCore         = '{EC04471C-07B1-417C-AAB7-9057CDC19654}';
  GuidIndyProtocols    = '{449AFDFE-87E5-4A27-A606-3D18DCC49E19}';
  GuidDclIndyCore      = '{1D46A695-5727-4259-8F1C-AD2CF5BB5BA3}';
  GuidDclIndyProtocols = '{2197FF7F-515A-47D7-B1DF-E5B6705CE0F8}';

type
  TPackage = class
  protected
    FCode : TStringList;
    FCompiler : TCompiler;
    FContainsClause : string;
    FDesc : string;
    FDirs : TStringList;
    FExt : string;
    FName : string;
    FGuid : string;                     // the package's ProjectGuid; empty when the package has no .dproj
    FUnits : TStringList;
    FVersion : string;
    FDesignTime : Boolean;
    FDebug : Boolean;
    FTemplate : Boolean;
    FOutputSubDir : string;
    FSourceRoot : string;               // relative path from the output folder back to Lib\ (e.g. '..\..\Lib\')
    FIncludePath : string;
    FOutputBplName : string;            // the final (always-suffixed) .bpl base name, used for version info
    FDprojRefs : TStringList;           // <DCCReference> unit lines, built during GenContains for the .dproj
    //
    procedure Prepare(const ABase : string; ACompiler : TCompiler; const AGuid : string = '');
    procedure Code(const ACode : string);
    procedure GenHeader; virtual;
    procedure GenOptions; virtual;
    procedure GenPreRequiresClause; virtual;
    procedure GenRequires; virtual;
    procedure GenContains; overload; virtual;
    procedure GenContains(const aPrefix : string; const aWritePath : Boolean); overload; virtual;
    procedure GenFooter; virtual;
    procedure GenPreContainsClause; virtual;
    procedure GenPreContains; virtual;
    procedure GenPreContainsFile(const AUnit : string); virtual;
    procedure GenPostContainsFile(const AUnit : string; const AIsLastFile : Boolean); virtual;
    procedure GenResourceScript; virtual;
    function IgnoreContainsFile(const AUnit : string) : Boolean; virtual;
    procedure WriteFile;
  public
    procedure Clear;
    procedure AddUnit(const AName : string; const ADir : string = '');
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Generate(ACompiler : TCompiler); overload;
    procedure Generate(ACompiler : TCompiler; const AFlags : TGenerateFlags); overload; virtual;
    procedure Generate(ACompilers : TCompilers); overload;
    procedure Generate(ACompilers : TCompilers; const AFlags : TGenerateFlags); overload; virtual;
    procedure GenDproj(ACompiler : TCompiler);
    procedure GenerateRC(ACompiler : TCompiler); overload;
    procedure GenerateRC(ACompiler : TCompiler; const AFlags : TGenerateFlags); overload; virtual;
    procedure GenerateRC(ACompilers : TCompilers); overload;
    procedure GenerateRC(ACompilers : TCompilers; const AFlags : TGenerateFlags); overload; virtual;
    procedure Load(const ACriteria : string; const AUsePath : Boolean = True);
  end;

const
  GPackageVer   : array[TCompiler] of string = (
    '',                                 // Unversioned
    '40',                               // 4.0
    '50',                               // 5.0
    '60',                               // 6.0
    '70',                               // 7.0
    '80', '80Net',                      // 8.0
    '90', '90Net',                      // 2005
    '100', '100Net',                    // 2006
    '110', '110Net',                    // 2007
    '120', '120Net',                    // 2009
    '130', '130Net',                    // was not released, skipped to v14 (D2010)
    '140',                              // 2010
    '150',                              // XE
    '160',                              // XE2
    '170',                              // XE3
    '180',                              // XE4
    '190',                              // XE5
    '200',                              // XE6
    '210',                              // XE7
    '220',                              // XE8
    '230',                              // 10.0 Seattle
    '240',                              // 10.1 Berlin
    '250',                              // 10.2 Tokyo
    '260',                              // 10.3 Rio
    '270',                              // 10.4 Sydney
    '280',                              // 11.0 Alexandria
    '290',                              // 12.0 Athens
    '370',                              // 13.0 Florence (package version synced with compiler version!)
    '',                                 // .NET
    'K3');                              // Kylix

  GCompilerVer  : array[TCompiler] of string = (
    '',                                 // Unversioned
    '120',                              // 4.0
    '130',                              // 5.0
    '140',                              // 6.0
    '150',                              // 7.0
    '160', '160',                       // 8.0
    '170', '170',                       // 2005
    '180', '180',                       // 2006
    '185', '190',                       // 2007
    '200', '200',                       // 2009
    '', '',                             // was not released, skipped to v14 (D2010)
    '210',                              // 2010
    '220',                              // XE
    '230',                              // XE2
    '240',                              // XE3
    '250',                              // XE4
    '260',                              // XE5
    '270',                              // XE6
    '280',                              // XE7
    '290',                              // XE8
    '300',                              // 10.0 Seattle
    '310',                              // 10.1 Berlin
    '320',                              // 10.2 Tokyo
    '330',                              // 10.3 Rio
    '340',                              // 10.4 Sydney
    '350',                              // 11.0 Alexandria
    '360',                              // 12.0 Athens
    '370',                              // 13.0 Florence
    '',                                 // .NET
    '');                                // Kylix

  // Per-compiler output folder under Packages\ (matches the on-disk folder names).
  GPackageFolder : array[TCompiler] of string = (
    '',                                 // Unversioned
    'Delphi 4',                         // 4.0
    'Delphi 5',                         // 5.0
    'Delphi 6',                         // 6.0
    'Delphi 7',                         // 7.0
    'Delphi 8', 'Delphi 8 .NET',        // 8.0
    'Delphi 2005', 'Delphi 2005 .NET',  // 2005
    'RAD Studio 2006', 'RAD Studio 2006 .NET', // 2006
    'RAD Studio 2007', 'RAD Studio 2007 .NET', // 2007
    'RAD Studio 2009', 'RAD Studio 2009 .NET', // 2009
    '', '',                             // was not released, skipped to v14 (D2010)
    'RAD Studio 2010',                  // 2010
    'RAD Studio XE',                    // XE
    'RAD Studio XE2',                   // XE2
    'RAD Studio XE3',                   // XE3
    'RAD Studio XE4',                   // XE4
    'RAD Studio XE5',                   // XE5
    'RAD Studio XE6',                   // XE6
    'RAD Studio XE7',                   // XE7
    'RAD Studio XE8',                   // XE8
    'RAD Studio 10.0',                  // 10.0 Seattle
    'RAD Studio 10.1',                  // 10.1 Berlin
    'RAD Studio 10.2',                  // 10.2 Tokyo
    'RAD Studio 10.3',                  // 10.3 Rio
    'RAD Studio 10.4',                  // 10.4 Sydney
    'RAD Studio 11.0',                  // 11.0 Alexandria
    'RAD Studio 12.0',                  // 12.0 Athens
    'RAD Studio 13.0',                  // 13.0 Florence
    'Visual Studio',                    // .NET (Visual Studio)
    'Kylix 3');                         // Kylix

function iif(ATest : Boolean; const ATrue : Integer; const AFalse : Integer) : Integer; overload;
function iif(ATest : Boolean; const ATrue : string; const AFalse : string) : string; overload;
function iif(ATest : Boolean; const ATrue : Boolean; const AFalse : Boolean) : Boolean; overload;

// Package identifier for a given base name + compiler: de-suffixed for native
// Delphi 6+ (which use LIBSUFFIX), suffixed otherwise (Delphi 4/5, .NET, Kylix).
function PackageName(const ABase : string; ACompiler : TCompiler) : string;
// The {$LIBSUFFIX} directive for a native Delphi 6+ compiler ('AUTO' for 11+).
function LibSuffixDirective(ACompiler : TCompiler) : string;

var
  IndyVersion_Major_Str : string = '';
  IndyVersion_Minor_Str : string = '';
  IndyVersion_Release_Str : string = '';
  IndyVersion_Build_Str : string = '';
  IndyVersion_Build_Template : string = '';

  IndyVersion_ProductVersion_Str : string = '';
  IndyVersion_FileVersion_Str : string = '';
  IndyVersion_FileVersion_Template : string = '';

  IndyVersion_VersionInfo_ProductVersion_Str : string = '';
  IndyVersion_VersionInfo_FileVersion_Str : string = '';
  IndyVersion_VersionInfo_FileVersion_Template : string = '';

procedure InitVersionNumbers;

implementation

uses
  SysUtils,
  DateUtils,
  DModule;

function iif(ATest : Boolean; const ATrue : Integer; const AFalse : Integer) : Integer;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if ATest then
  begin
    Result := ATrue;
  end
  else
  begin
    Result := AFalse;
  end;
end;

function iif(ATest : Boolean; const ATrue : string; const AFalse : string) : string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if ATest then
  begin
    Result := ATrue;
  end
  else
  begin
    Result := AFalse;
  end;
end;

function iif(ATest : Boolean; const ATrue : Boolean; const AFalse : Boolean) : Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if ATest then
  begin
    Result := ATrue;
  end
  else
  begin
    Result := AFalse;
  end;
end;

function PackageName(const ABase : string; ACompiler : TCompiler) : string;
begin
  if ACompiler in Delphi_Native_LibSuffix then
  begin
    Result := ABase;
  end
  else
  begin
    Result := ABase + GPackageVer[ACompiler];
  end;
end;

function LibSuffixDirective(ACompiler : TCompiler) : string;
begin
  if ACompiler in Delphi_Native_LibSuffix_Auto then
  begin
    Result := '{$LIBSUFFIX AUTO}';
  end
  else
  begin
    Result := '{$LIBSUFFIX ''' + GPackageVer[ACompiler] + '''}';
  end;
end;

{ TPackage }

procedure TPackage.Prepare(const ABase : string; ACompiler : TCompiler; const AGuid : string);
begin
  FGuid := AGuid;
  // The package filename/identifier (de-suffixed for native D6+, suffixed otherwise)
  FName := PackageName(ABase, ACompiler);
  // The final .bpl base name always keeps the suffix (LIBSUFFIX restores it)
  FOutputBplName := ABase + GPackageVer[ACompiler];
  // All packages for a compiler now live together in one Packages\<version> folder
  if GPackageFolder[ACompiler] <> '' then
  begin
    FOutputSubDir := 'Packages\' + GPackageFolder[ACompiler];
  end;
end;

procedure TPackage.AddUnit(const AName : string; const ADir : string);
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

procedure TPackage.Code(const ACode : string);
begin
  FCode.Add(ACode);
end;

constructor TPackage.Create;
begin
  FContainsClause := 'contains';
  FExt := '.dpk';
  FVersion := IndyVersion_Major_Str;
  // Packages now live in Packages\<version>\, two levels above Lib\<subdir>\ where
  // the source still resides, so 'contains' entries are written relative to there.
  FSourceRoot := '..\..\Lib\';
  FIncludePath := FSourceRoot + 'Includes';
  FCode := TStringList.Create;
  FDirs := TStringList.Create;
  FUnits := TStringList.Create;
  FDprojRefs := TStringList.Create;
end;

destructor TPackage.Destroy;
begin
  FreeAndNil(FDprojRefs);
  FreeAndNil(FUnits);
  FreeAndNil(FDirs);
  FreeAndNil(FCode);
  inherited;
end;

procedure TPackage.GenContains;
begin
  GenContains('', True);
end;

procedure TPackage.GenContains(const aPrefix : string; const aWritePath : Boolean);
var
  i : Integer;
  xPath, lastUnit, lastPath : string;
begin
  Code('');
  GenPreContainsClause;
  Code(FContainsClause);
  GenPreContains;
  // The .dproj (if any) gets a flat <DCCReference> for the same units, built here so the
  // DB-driven unit list is walked once and feeds both the .dpk contains and the .dproj.
  FDprojRefs.Clear;
  lastUnit := '';
  lastPath := '';
  for i := 0 to FUnits.Count - 1 do
  begin
    if APrefix <> '' then
    begin
      FUnits[i] := StringReplace(FUnits[i], 'Id', APrefix, []);
    end;
    if not IgnoreContainsFile(FUnits[i]) then
    begin
      xPath := '';
      if aWritePath then
      begin
        xPath := FSourceRoot;
        if FDirs[i] <> '' then
        begin
          xPath := xPath + IncludeTrailingPathDelimiter(FDirs[i]);
        end;
      end;
      xPath := xPath + FUnits[i] + '.pas';
      // flat DCCReference for the .dproj (no {$IFDEF} wrapping, unlike the .dpk contains)
      FDprojRefs.Add('        <DCCReference Include="' + xPath + '"/>');
      if (lastUnit <> '') or (lastPath <> '') then
      begin
        GenPreContainsFile(lastUnit);
        Code('  ' + lastUnit + ' in ''' + lastPath + '''');
        GenPostContainsFile(lastUnit, False);
      end;
      lastUnit := FUnits[i];
      lastPath := xPath;
    end;
  end;
  if (lastUnit <> '') or (lastPath <> '') then
  begin
    GenPreContainsFile(lastUnit);
    Code('  ' + lastUnit + ' in ''' + lastPath + '''');
    GenPostContainsFile(lastUnit, True);
  end;
end;

procedure TPackage.GenPreContainsFile(const AUnit : string);
begin
end;

procedure TPackage.GenPostContainsFile(const AUnit : string; const AIsLastFile : Boolean);
begin
  if FCode.Count > 0 then
  begin
    FCode[FCode.Count - 1] := FCode[FCode.Count - 1] + iif(AIsLastFile, ';', ',');
  end;
end;

function TPackage.IgnoreContainsFile(const AUnit : string) : Boolean;
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

procedure TPackage.Generate(ACompiler : TCompiler);
begin
  Generate(ACompiler, [gfRunTime]);
end;

procedure TPackage.Generate(ACompiler : TCompiler; const AFlags : TGenerateFlags);
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

procedure TPackage.Generate(ACompilers : TCompilers);
begin
  Generate(ACompilers, [gfRunTime]);
end;

procedure TPackage.Generate(ACompilers : TCompilers; const AFlags : TGenerateFlags);
var
  LCompiler : TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do
  begin
    if LCompiler in ACompilers then
    begin
      Generate(LCompiler, AFlags);
    end;
  end;
end;

procedure TPackage.GenDproj(ACompiler : TCompiler);
const
  Q             = '''';                 // a single-quote character, to keep the embedded MSBuild conditions readable
var
  LPlats : TStringList;
  LTargeted, i : Integer;
  LGuid, LProjVer, LLibSuffix, LDesc, LPkgKind, LPersonality : string;

  function PlatBit(const APlat : string) : Integer;
  begin
    if APlat = 'Win32' then
      Result := 1
    else if APlat = 'Win64' then
      Result := 2
    else if APlat = 'Win64x' then
      Result := 1048576
    else if APlat = 'WinARM64EC' then
      Result := 2097152
    else
      Result := 0;
  end;

  procedure Dcp(const ADcp : string);
  begin
    Code('        <DCCReference Include="' + ADcp + '"/>');
  end;

begin
  // .dproj is the project format from Delphi 2007 onward (others: .dpk/.bdsproj).
  if not (ACompiler in Delphi_Native_Dproj) then
  begin
    Exit;
  end;

  // Stable per-package identity, supplied by Prepare(); empty -> no .dproj.
  if FGuid = '' then
    Exit;
  LGuid := FGuid;

  case ACompiler of
    ctDelphi2007 : LProjVer := '11.0';
    ctDelphi2009 : LProjVer := '12.0';
    ctDelphi2010 : LProjVer := '12.0';
    ctDelphiXE : LProjVer := '12.3';
    ctDelphiXE2 : LProjVer := '13.4';
    ctDelphiXE3 : LProjVer := '14.3';
    ctDelphiXE4 : LProjVer := '14.6';
    ctDelphiXE5 : LProjVer := '15.1';
    ctDelphiXE6 : LProjVer := '15.4';
    ctDelphiXE7 : LProjVer := '16.0';
    ctDelphiXE8 : LProjVer := '17.2';
    ctDelphiSeattle : LProjVer := '17.2';
    ctDelphiBerlin : LProjVer := '18.2';
    ctDelphiTokyo : LProjVer := '18.3';
    ctDelphiRio : LProjVer := '18.3';
    ctDelphiSydney : LProjVer := '19.1';
    ctDelphiAlexandria : LProjVer := '19.4';
    ctDelphiAthens : LProjVer := '20.2';
  else
    LProjVer := '20.2';                 // Florence
  end;

  if ACompiler in Delphi_Native_LibSuffix_Auto then
  begin
    LLibSuffix := '$(Auto)';
  end
  else
  begin
    LLibSuffix := GPackageVer[ACompiler];
  end;

  LDesc := 'Indy ' + FVersion + TrimRight(' ' + FDesc);
  LPkgKind := iif(FDesignTime, 'DesignOnlyPackage', 'RuntimeOnlyPackage');
  // Delphi 2007 used the unversioned personality; 2009+ use Delphi.Personality.12
  LPersonality := iif(ACompiler = ctDelphi2007, 'Delphi.Personality', 'Delphi.Personality.12');

  LPlats := TStringList.Create;
  try
    // Packages are a Windows/desktop concept; canonical platform set:
    //   runtime: Win32; +Win64 (XE2+); +Win64x (Athens+); +WinARM64EC (Florence)
    //   design : Win32; +Win64 (Athens+)
    LPlats.Add('Win32');
    if FDesignTime then
    begin
      if ACompiler >= ctDelphiAthens then
        LPlats.Add('Win64');
    end
    else
    begin
      if ACompiler >= ctDelphiXE2 then
        LPlats.Add('Win64');
      if ACompiler >= ctDelphiAthens then
        LPlats.Add('Win64x');
      if ACompiler >= ctDelphiFlorence then
        LPlats.Add('WinARM64EC');
    end;
    LTargeted := 0;
    for i := 0 to LPlats.Count - 1 do
    begin
      Inc(LTargeted, PlatBit(LPlats[i]));
    end;

    FCode.Clear;
    FExt := '.dproj';

    Code('<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">');
    Code('    <PropertyGroup>');
    Code('        <ProjectGuid>' + LGuid + '</ProjectGuid>');
    Code('        <MainSource>' + FName + '.dpk</MainSource>');
    Code('        <Base>True</Base>');
    Code('        <Config Condition="' + Q + '$(Config)' + Q + '==' + Q + Q + '">Release</Config>');
    Code('        <TargetedPlatforms>' + IntToStr(LTargeted) + '</TargetedPlatforms>');
    Code('        <AppType>Package</AppType>');
    Code('        <FrameworkType>None</FrameworkType>');
    Code('        <ProjectVersion>' + LProjVer + '</ProjectVersion>');
    Code('        <Platform Condition="' + Q + '$(Platform)' + Q + '==' + Q + Q + '">Win32</Platform>');
    Code('        <ProjectName Condition="' + Q + '$(ProjectName)' + Q + '==' + Q + Q + '">' + FName + '</ProjectName>');
    Code('    </PropertyGroup>');
    Code('    <PropertyGroup Condition="' + Q + '$(Config)' + Q + '==' + Q + 'Base' + Q + ' or ' + Q + '$(Base)' + Q + '!=' + Q + Q + '">');
    Code('        <Base>true</Base>');
    Code('    </PropertyGroup>');
    for i := 0 to LPlats.Count - 1 do
    begin
      Code('    <PropertyGroup Condition="(' + Q + '$(Platform)' + Q + '==' + Q + LPlats[i] + Q + ' and ' + Q + '$(Base)' + Q + '==' + Q + 'true' + Q + ') or '
        + Q + '$(Base_' + LPlats[i] + ')' + Q + '!=' + Q + Q + '">');
      Code('        <Base_' + LPlats[i] + '>true</Base_' + LPlats[i] + '>');
      Code('        <CfgParent>Base</CfgParent>');
      Code('        <Base>true</Base>');
      Code('    </PropertyGroup>');
    end;
    Code('    <PropertyGroup Condition="' + Q + '$(Config)' + Q + '==' + Q + 'Release' + Q + ' or ' + Q + '$(Cfg_1)' + Q + '!=' + Q + Q + '">');
    Code('        <Cfg_1>true</Cfg_1>');
    Code('        <CfgParent>Base</CfgParent>');
    Code('        <Base>true</Base>');
    Code('    </PropertyGroup>');
    Code('    <PropertyGroup Condition="' + Q + '$(Config)' + Q + '==' + Q + 'Debug' + Q + ' or ' + Q + '$(Cfg_2)' + Q + '!=' + Q + Q + '">');
    Code('        <Cfg_2>true</Cfg_2>');
    Code('        <CfgParent>Base</CfgParent>');
    Code('        <Base>true</Base>');
    Code('    </PropertyGroup>');
    Code('    <PropertyGroup Condition="' + Q + '$(Base)' + Q + '!=' + Q + Q + '">');
    // The package DLL suffix property is <DllSuffix> (what the IDE reads/writes);
    // <DCC_LibSuffix> is NOT recognised, so the suffix would be lost on an IDE/MSBuild build.
    Code('        <DllSuffix>' + LLibSuffix + '</DllSuffix>');
    Code('        <DCC_Description>' + LDesc + '</DCC_Description>');
    // Design-time packages pull in VCL units (e.g. Vcl.StdCtrls via IdAboutVCL), so they need
    // the Vcl unit-scope namespace; runtime packages are non-visual and don't.
    Code('        <DCC_Namespace>System;Xml;Data;Datasnap;Web;Soap;Winapi;' + iif(FDesignTime, 'Vcl;', '') + 'System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;$(DCC_Namespace)</DCC_Namespace>');
    Code('        <DCC_UnitSearchPath>' + ExcludeTrailingPathDelimiter(FIncludePath) + ';$(DCC_UnitSearchPath)</DCC_UnitSearchPath>');
    Code('        <' + LPkgKind + '>true</' + LPkgKind + '>');
    Code('        <GenDll>true</GenDll>');
    Code('        <GenPackage>true</GenPackage>');
    // Packages are pre-built; never implicitly rebuild their .dcps (mirrors {$IMPLICITBUILD OFF} in the .dpk).
    Code('        <DCC_OutputNeverBuildDcps>true</DCC_OutputNeverBuildDcps>');
    // Runtime packages also emit the C++Builder support files (.hpp/.bpi/.lib/.obj); 'All' = generate them all.
    // The Fullc_*.bat scripts supply DCC_HppOutput/DCC_BpiOutput/DCC_ObjOutput at build time.
    if not FDesignTime then
    begin
      Code('        <DCC_CBuilderOutput>All</DCC_CBuilderOutput>');
    end;
    Code('        <DCC_ImageBase>00400000</DCC_ImageBase>');
    Code('    </PropertyGroup>');
    Code('    <PropertyGroup Condition="' + Q + '$(Cfg_1)' + Q + '!=' + Q + Q + '">');
    Code('        <DCC_Define>RELEASE;$(DCC_Define)</DCC_Define>');
    // DCC_DebugInformation was a Boolean (false/true) through Delphi XE4; from XE5
    // onward MSBuild requires the integer form (0=none, 1=limited, 2=full).
    Code('        <DCC_DebugInformation>' + iif(ACompiler <= ctDelphiXE4, 'false', '0') + '</DCC_DebugInformation>');
    Code('        <DCC_LocalDebugSymbols>false</DCC_LocalDebugSymbols>');
    Code('        <DCC_SymbolReferenceInfo>0</DCC_SymbolReferenceInfo>');
    Code('    </PropertyGroup>');
    Code('    <PropertyGroup Condition="' + Q + '$(Cfg_2)' + Q + '!=' + Q + Q + '">');
    Code('        <DCC_Define>DEBUG;$(DCC_Define)</DCC_Define>');
    Code('        <DCC_Optimize>false</DCC_Optimize>');
    Code('        <DCC_GenerateStackFrames>true</DCC_GenerateStackFrames>');
    Code('    </PropertyGroup>');
    Code('    <ItemGroup>');
    Code('        <DelphiCompile Include="$(MainSource)">');
    Code('            <MainSource>MainSource</MainSource>');
    Code('        </DelphiCompile>');
    // .dcp dependencies (flat, de-suffixed; mirror the .dpk requires)
    if FName = 'IndySystem' then
    begin
      Dcp('rtl.dcp');
    end
    else if FName = 'IndyCore' then
    begin
      Dcp('rtl.dcp');
      Dcp('IndySystem.dcp');
    end
    else if FName = 'IndyProtocols' then
    begin
      Dcp('rtl.dcp');
      Dcp('IndySystem.dcp');
      Dcp('IndyCore.dcp');
    end
    else if FName = 'dclIndyCore' then
    begin
      Dcp('designide.dcp');
      Dcp('IndySystem.dcp');
      Dcp('IndyCore.dcp');
    end
    else if FName = 'dclIndyProtocols' then
    begin
      Dcp('designide.dcp');
      Dcp('IndyProtocols.dcp');
      Dcp('IndySystem.dcp');
      Dcp('IndyCore.dcp');
      Dcp('dclIndyCore.dcp');
    end;
    // dynamic unit references, built during GenContains (same loop as the .dpk contains)
    FCode.AddStrings(FDprojRefs);
    Code('        <BuildConfiguration Include="Release">');
    Code('            <Key>Cfg_1</Key>');
    Code('            <CfgParent>Base</CfgParent>');
    Code('        </BuildConfiguration>');
    Code('        <BuildConfiguration Include="Base">');
    Code('            <Key>Base</Key>');
    Code('        </BuildConfiguration>');
    Code('        <BuildConfiguration Include="Debug">');
    Code('            <Key>Cfg_2</Key>');
    Code('            <CfgParent>Base</CfgParent>');
    Code('        </BuildConfiguration>');
    Code('    </ItemGroup>');
    Code('    <ProjectExtensions>');
    Code('        <Borland.Personality>' + LPersonality + '</Borland.Personality>');
    Code('        <Borland.ProjectType>Package</Borland.ProjectType>');
    Code('        <BorlandProject>');
    Code('            <Delphi.Personality>');
    Code('                <Source>');
    Code('                    <Source Name="MainSource">' + FName + '.dpk</Source>');
    Code('                </Source>');
    Code('                <Platforms>');
    for i := 0 to LPlats.Count - 1 do
    begin
      Code('                    <Platform value="' + LPlats[i] + '">True</Platform>');
    end;
    Code('                </Platforms>');
    Code('            </Delphi.Personality>');
    Code('        </BorlandProject>');
    Code('    </ProjectExtensions>');
    Code('    <Import Project="$(BDS)\Bin\CodeGear.Delphi.Targets" Condition="Exists(' + Q + '$(BDS)\Bin\CodeGear.Delphi.Targets' + Q + ')"/>');
    Code('    <Import Project="$(APPDATA)\Embarcadero\$(BDSAPPDATABASEDIR)\$(PRODUCTVERSION)\UserTools.proj" Condition="Exists(' + Q +
      '$(APPDATA)\Embarcadero\$(BDSAPPDATABASEDIR)\$(PRODUCTVERSION)\UserTools.proj' + Q + ')"/>');
    Code('</Project>');

    WriteFile;
  finally
    LPlats.Free;
  end;
end;

procedure TPackage.GenerateRC(ACompiler : TCompiler);
begin
  GenerateRC(ACompiler, [gfRunTime]);
end;

procedure TPackage.GenerateRC(ACompiler : TCompiler; const AFlags : TGenerateFlags);
begin
  FCompiler := ACompiler;
  FTemplate := gfTemplate in AFlags;
  FDebug := gfDebug in AFlags;
  if gfRunTime in AFlags then
  begin
    FCode.Clear;
    FDesignTime := False;
    GenResourceScript;
  end;
  if gfDesignTime in AFlags then
  begin
    FCode.Clear;
    FDesignTime := True;
    GenResourceScript;
  end;
end;

procedure TPackage.GenerateRC(ACompilers : TCompilers);
begin
  GenerateRC(ACompilers, [gfRunTime]);
end;

procedure TPackage.GenerateRC(ACompilers : TCompilers; const AFlags : TGenerateFlags);
var
  LCompiler : TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do
  begin
    if LCompiler in ACompilers then
    begin
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
  DelphiNative_Align8 = Delphi_Native - [Delphi_Native_Lowest..ctDelphiPre2010NR] + [ctDelphi2005];
begin
  Code('');
  if FCompiler in Delphi_DotNet then
  begin
    Code('{$ALIGN 0}');
  end
  else
  begin
    Code('{$R *.res}');
    if FCompiler in DelphiNative_Align8 then
    begin
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
  Code('{$IMPLICITBUILD OFF}');
  // Native Delphi 6+ carry the version via LIBSUFFIX instead of a name suffix.
  if FCompiler in Delphi_Native_LibSuffix then
  begin
    Code(LibSuffixDirective(FCompiler));
  end;

end;

procedure TPackage.Load(const ACriteria : string; const AUsePath : Boolean = True);
var
  LFiles : TStringList;
  LDir : string;
  I : Integer;
begin
  Clear;
  LFiles := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LFiles);
    for I := 0 to LFiles.Count - 1 do
    begin
      if AUsePath then
      begin
        LDir := DM.Ini.ReadString(LFiles[I], 'Pkg', '');
      end
      else
      begin
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
  LCodeOld : string;
  LPathname : string;
  LSubDir : string;
begin
  LPathname := SysUtils.IncludeTrailingPathDelimiter(DM.OutputPath);
  if FOutputSubDir <> '' then
  begin
    LSubDir := SysUtils.IncludeTrailingPathDelimiter(FOutputSubDir);
    LPathname := LPathname + LSubDir;
  end;
  LPathname := LPathname + FName + FExt;
  LCodeOld := '';
  if FileExists(LPathname) then
  begin
    with TStringList.Create do
    try
      LoadFromFile(LPathname);
      LCodeOld := Text;
    finally Free;
    end;
  end;
  // Only write out the code if its different. This prevents unnecessary checkins as well
  // as not requiring user to lock all packages
  if (LCodeOld = '') or (LCodeOld <> FCode.Text) then
  begin
    ForceDirectories(ExtractFilePath(LPathname)); // create Packages\<version>\ if needed
    FCode.SaveToFile(LPathname, TEncoding.UTF8); //force encoding for consistency.
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
  LBplName : string;
begin
  // The .res/.rc filename follows the (possibly de-suffixed) package name, but the
  // version-info strings must name the final .bpl, which always keeps the suffix.
  LBplName := iif(FOutputBplName <> '', FOutputBplName, FName);
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
  Code('   VALUE "InternalName", "' + LBplName + '\0"');
  Code('   VALUE "LegalCopyright", "Copyright � 1993 - ' + IntToStr(DateUtils.YearOf(Date)) + ' Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew\0"');
  Code('   VALUE "OriginalFilename", "' + LBplName + '.bpl\0"');
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
  LMajor, LMinor, LRelease, LBuild, LPos : Integer;
  LVerNum, LTemp : string;
begin
  if FindCmdLineSwitch('version', LVerNum) then
    LVerNum := Trim(LVerNum);

  if LVerNum = '' then
  begin
    with TMemIniFile.Create(DM.DataPath + 'PkgGen.ini') do
    try
      LVerNum := Trim(ReadString('Settings', 'LastVersion', ''));
    finally
      Free;
    end;
    WriteLn;
    if LVerNum <> '' then
    begin
      WriteLn('Please enter a version number in #.#.#.# format');
      Write('or leave blank to reuse last version (', LVerNum, '): ');
    end
    else
    begin
      Write('Please enter a version number in #.#.#.# format: ');
    end;
    ReadLn(LTemp);
    LTemp := Trim(LTemp);
    if LTemp <> '' then
    begin
      LVerNum := LTemp;
    end
    else if LVerNum = '' then
    begin
      raise Exception.Create('Version number is missing');
    end;
  end;

  try
    LTemp := LVerNum;
    LPos := Pos('.', LTemp);
    LMajor := StrToInt(Copy(LTemp, 1, LPos - 1));
    Delete(LTemp, 1, LPos);

    LPos := Pos('.', LTemp);
    LMinor := StrToInt(Copy(LTemp, 1, LPos - 1));
    Delete(LTemp, 1, LPos);

    LPos := Pos('.', LTemp);
    LRelease := StrToInt(Copy(LTemp, 1, LPos - 1));
    Delete(LTemp, 1, LPos);

    LBuild := StrToInt(LTemp);
  except
    Exception.RaiseOuterException(Exception.Create('Version number is invalid'));
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

  with TMemIniFile.Create(DM.DataPath + 'PkgGen.ini') do
  try
    WriteString('Settings', 'LastVersion', LVerNum);
    UpdateFile;
  finally
    Free;
  end;

  WriteLn;
  WriteLn('Version Number set to ', LMajor, '.', LMinor, '.', LRelease, '.', LBuild);
end;

end.

