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
   ctUnknown,
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
   ctDotNet, // Visual Studio
   ctKylix3);

  TCompilers = Set of TCompiler;

const
  DelphiNet = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net, ctDelphi2007Net, ctDelphi2009Net, ctDelphi13Net];
  DelphiNet1_1 = [ctDelphi8Net, ctDelphi2005Net, ctDelphi2006Net];
  DelphiNet2OrLater = [ctDelphi2007Net, ctDelphi2009Net, ctDelphi13Net];
  DelphiNative = [ctDelphi5..ctDelphiXE2] - DelphiNet;
  DelphiNativeAlign8 = DelphiNative - [ctDelphi5..ctDelphi13] + [ctDelphi2005];

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
    //
    procedure Code(const ACode: string);
    procedure GenHeader; virtual;
    procedure GenOptions(ADesignTime: Boolean = False); virtual;
    procedure GenContains(const aPrefix: string = ''; const aWritePath: Boolean = True);
    procedure WriteFile(const APath: string);
    procedure WritePreContains; virtual;
  public
    procedure Clear;
    procedure AddUnit(const AName: string; const ADir: string = '');
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Generate(ACompiler: TCompiler); overload; virtual;
    procedure Generate(ACompilers: TCompilers); overload; virtual;
    procedure GenerateDT(ACompiler: TCompiler); overload; virtual;
    procedure GenerateDT(ACompilers: TCompilers); overload; virtual;
    procedure Load(const ACriteria: string; const AUsePath: Boolean = False);
    //
    property Compiler: TCompiler read FCompiler;
  end;

const
  GCompilerID: array[TCompiler] of string = (
    '',
    '50',
    '60',
    '70',
    '80', '80Net',
    '90', '90Net',    // 2005
    '100', '100Net',  // 2006
    '110', '110Net',  // 2007
    '120', '120Net',  // 2009
    '130', '130Net',  // was not released, skipped to v14 (D2010)
    '140',            // 2010
    '150',            // XE
    '160',            // XE2
    '',
    'K3');

   //Fetch Defaults
  IdFetchDelimDefault = ' ';    {Do not Localize}
  IdFetchDeleteDefault = True;
  IdFetchCaseSensitiveDefault = True;

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;  overload;
function iif(ATest: Boolean; const ATrue: string; const AFalse: string): string; overload;
function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;

implementation

uses
  SysUtils, DModule;

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
  FCode := TStringList.Create;
  FDirs := TStringList.Create;
  FUnits := TStringList.Create;
end;

procedure TPackage.Code(const ACode: string);
begin
  FCode.Add(ACode);
end;

constructor TPackage.Create;
begin
  FContainsClause := 'contains';
  FExt := '.dpk';
  FVersion := '10';
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
var
  i: Integer;
  xPath: string;
begin
  Code('');
  Code(FContainsClause);
  WritePreContains;
  for i := 0 to FUnits.Count - 1 do begin
    if APrefix <> '' then begin
      FUnits[i] := StringReplace(FUnits[i], 'Id', APrefix, []);
    end;
    xPath := '';
    if aWritePath and (FDirs[i] <> '') then begin
      xPath := FDirs[i] + '\';
    end;
    Code('  ' + FUnits[i] + ' in ''' + xPath + FUnits[i] + '.pas'''
     + iif(i < FUnits.Count - 1, ',', ';'));
  end;
end;

procedure TPackage.Generate(ACompiler: TCompiler);
begin
  FCompiler := ACompiler;
  FCode.Clear;
end;

procedure TPackage.Generate(ACompilers: TCompilers);
var
  LCompiler: TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Generate(LCompiler);
    end;
  end;
end;

procedure TPackage.GenerateDT(ACompiler: TCompiler);
begin
  FCompiler := ACompiler;
  FCode.Clear;
end;

procedure TPackage.GenerateDT(ACompilers: TCompilers);
var
  LCompiler: TCompiler;
begin
  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      GenerateDT(LCompiler);
    end;
  end;
end;

procedure TPackage.GenHeader;
begin
  Code('package ' + FName + ';');
end;

procedure TPackage.GenOptions(ADesignTime: Boolean = False);
begin
  Code('');
  if FCompiler in DelphiNet then begin
    Code('{$ALIGN 0}');
  end else begin
    Code('{$R *.res}');
    if FCompiler in DelphiNativeAlign8 then begin
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
  Code(iif(ADesignTime, '{$DESIGNONLY}', '{$RUNONLY}'));
  Code('{$IMPLICITBUILD ON}');
end;

procedure TPackage.Load(const ACriteria: string; const AUsePath: Boolean = False);
var
  LFiles: TStringList;
  I: Integer;
begin
  Clear;
  LFiles := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LFiles);
    for I := 0 to LFiles.Count - 1 do
    begin
      if AUsePath then begin
        AddUnit(LFiles[I], DM.Ini.ReadString(LFiles[I], 'Pkg', ''));
      end else begin
        AddUnit(LFiles[I]);
      end;
    end;
  finally
    LFiles.Free;
  end;
end;

procedure TPackage.WriteFile(const APath: string);
var
  LCodeOld: string;
  LPathname: string;
begin
  Code('');
  Code('end.');
  LPathname := APath + FName + FExt;
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
    WriteLn('Generated ' + FName + FExt);
  end;
end;

procedure TPackage.WritePreContains;
begin
end;

end.
