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
{   Rev 1.5    9/4/2004 10:46:20 AM  JPMugaas
{ Now some path settings were hard coded into the data module DFM causing
{ strange resutls.
}
{
{   Rev 1.4    04/09/2004 12:45:16  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.3    6/9/2004 7:47:16 AM  JPMugaas
{ New feild for FTP Parser class.
}
{
{   Rev 1.2    02/06/2004 17:00:44  HHariri
{ design-time added
}
{
{   Rev 1.1    2004.01.22 8:17:58 PM  czhower
{ Updates
}
{
{   Rev 1.0    2004.01.22 1:52:42 AM  czhower
{ Initial checkin
}
unit DModule;

interface

uses
  SysUtils, Classes, IniFiles;

type
  TDM = class(TDataModule)
  private
  protected
    FDataPath : String;
    FOutputPath : String;
    FIni: TMemIniFile;
    procedure SetDataPath(const AValue : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckForMissingFiles;
    procedure GetFileList(const ACriteria: String; AFiles: TStrings);
    property DataPath : String read FDataPath write SetDataPath;
    property OutputPath : String read FOutputPath write FOutputPath;
    property Ini: TMemIniFile read FIni;
  end;

var
  DM: TDM;
  
var
  GIndyPath : String = 'W:\Source\Indy10\';

procedure DumpData(const AFile: String);

implementation

{$R *.dfm}

procedure DumpData(const AFile: String);
var
  LNames: TStringList;
  I: Integer;
begin
  LNames := TStringList.Create;
  try
    DM.Ini.ReadSection(AFile, LNames);
    for I := 0 to LNames.Count-1 do
      WriteLn(LNames[I] + ' = "' + DM.Ini.ReadString(AFile, LNames[I], '') + '"');
  finally
    LNames.Free;
  end;
end;

function UpTwoDirs(const APath : String):String;
begin
  Result := SysUtils.ExcludeTrailingPathDelimiter(APath);
  Result := ExtractFilePath(Result);
  Result := SysUtils.ExcludeTrailingPathDelimiter(Result);
  Result := ExtractFilePath(Result);
end;

{ TDM }

constructor TDM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Default Output Path is w:\source\Indy10\
  OutputPath := SysUtils.IncludeTrailingPathDelimiter(GIndyPath);
  // Default Data Path is W:\source\Indy10\Builder\Package Generator\Data
  DataPath   := OutputPath + 'Builder\Package Generator\Data\';
end;

destructor TDM.Destroy;
begin
  FreeAndNil(FIni);
  inherited Destroy;
end;

procedure TDM.CheckForMissingFiles;
var
  SR: TSearchRec;
  UnitName: String;
begin
  if FindFirst(GIndyPath + 'Lib\System\*.pas', faAnyFile, SR) = 0 then
  try
    repeat
      UnitName := ChangeFileExt(SR.Name, '');
      if not FIni.SectionExists(UnitName) then
      begin
        FIni.WriteString(UnitName, 'Pkg', 'System');
        FIni.WriteBool(UnitName, 'SettingsNeeded', True);
        WriteLn('Missing settings for: System\' + UnitName);
      end;
    until FindNext(SR) <> 0;
  finally
    FindClose(SR);
  end;

  if FindFirst(GIndyPath + 'Lib\Core\*.pas', faAnyFile, SR) = 0 then
  try
    repeat
      UnitName := ChangeFileExt(SR.Name, '');
      if not FIni.SectionExists(UnitName) then
      begin
        FIni.WriteString(UnitName, 'Pkg', 'Core');
        FIni.WriteBool(UnitName, 'SettingsNeeded', True);
        WriteLn('Missing settings for: Core\' + UnitName);
      end;
    until FindNext(SR) <> 0;
  finally
    FindClose(SR);
  end;

  if FindFirst(GIndyPath + 'Lib\Protocols\*.pas', faAnyFile, SR) = 0 then
  try
    repeat
      UnitName := ChangeFileExt(SR.Name, '');
      if not FIni.SectionExists(UnitName) then
      begin
        FIni.WriteString(UnitName, 'Pkg', 'Protocols');
        FIni.WriteBool(UnitName, 'SettingsNeeded', True);
        WriteLn('Missing settings for: Protocols\' + UnitName);
      end;
    until FindNext(SR) <> 0;
  finally
    FindClose(SR);
  end;
end;

procedure TDM.GetFileList(const ACriteria: String; AFiles: TStrings);
var
  LFiles: TStringList;
  LCriteria: TStringList;
  I, J: Integer;
  LMatches: Boolean;
  LCriteriaName, LCriteriaValue, LFileValue: String;
begin
  AFiles.Clear;
  LFiles := TStringList.Create;
  try
    FIni.ReadSections(LFiles);
    //LFiles.Sort;
    LCriteria := TStringList.Create;
    try
      LCriteria.CommaText := ACriteria;
      for I := 0 to LFiles.Count-1 do
      begin
        LMatches := True;
        for J := 0 to LCriteria.Count-1 do
        begin
          LCriteriaName := LCriteria.Names[J];
          LCriteriaValue := LCriteria.ValueFromIndex[J];
          LFileValue := FIni.ReadString(LFiles[I], LCriteriaName, '');
          if LFileValue <> LCriteriaValue then
          begin
            LMatches := False;
            Break;
          end;
        end;
        if LMatches then
        begin
          AFiles.Add(LFiles[I]);
        end;
      end;
    finally
      LCriteria.Free;
    end;
  finally
    LFiles.Free;
  end;
end;

procedure TDM.SetDataPath(const AValue: String);
begin
  FDataPath := SysUtils.IncludeTrailingPathDelimiter(AValue);
  FreeAndNil(FIni);
  FIni := TMemIniFile.Create(FDataPath + 'File.ini');
  FIni.AutoSave := True;
end;

procedure SetIndyPath;
var
  Param: String;
  I: Integer;
begin
  if ParamCount > 0 then begin
    for I := 1 to ParamCount do begin
      Param := ParamStr(I);
      if not CharInSet(Param[1], ['/', '-']) then begin
        GIndyPath := IncludeTrailingPathDelimiter(Param);
        Exit;
      end;
    end;
  end;
  GIndyPath := UpTwoDirs(ExtractFilePath(ParamStr(0)));
end;

initialization
  SetIndyPath;
end.

