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
  SysUtils, Classes, DB, DBTables;

type
  TDM = class(TDataModule)
    tablFile: TTable;
    tablFileFileID: TAutoIncField;
    tablFileFileName: TStringField;
    tablFileDotNet: TBooleanField;
    tablFileDelphiDotNet: TBooleanField;
    tablFileVCL: TBooleanField;
    tablFileKylix: TBooleanField;
    tablFilePkg: TStringField;
    tablFileDesignUnit: TBooleanField;
    tablFileFTPParser: TBooleanField;
    tablFileDescrShort: TStringField;
    tablFileProtocol: TStringField;
    tablFileRelease: TBooleanField;
    tablFileReleaseNative: TBooleanField;
    tablFileReleaseDotNet: TBooleanField;
    tablFileReleaseComment: TStringField;
    tablFileBubbleExists: TBooleanField;
    tablFileIFDEFPermitted: TBooleanField;
    tablFileOwners: TStringField;
    tablFileFPC: TBooleanField;
    tablFileFPCListInPkg: TBooleanField;
    tablFileFPCHasRegProc: TBooleanField;
    tablFileFPCHasLRSFile: TBooleanField;
    tablFileDotNet2_0OrAboveOnly: TBooleanField;
  private
  protected
    FDataPath : String;
    FOutputPath : String;
    procedure SetDataPath(const AValue : String);
  public
    constructor Create(AOwner: TComponent); override;
    property DataPath : String read FDataPath write SetDataPath;
    property OutputPath : String read FOutputPath write FOutputPath;
  end;

var
  DM: TDM;
  
var
  GIndyPath : String = 'W:\Source\Indy10\';

implementation
{$R *.dfm}

function UpTwoDirs(const APath : String):String;
begin
  Result := SysUtils.ExcludeTrailingPathDelimiter( APath);
  Result := ExtractFilePath(Result);
  Result := SysUtils.ExcludeTrailingPathDelimiter( Result);
  Result := ExtractFilePath(Result);
end;

{ TDM }

constructor TDM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Default Output Path is w:\source\Indy10
  OutputPath := SysUtils.ExcludeTrailingPathDelimiter( GIndyPath );
  // Default Data Path is W:\source\Indy10\builder\Package Generator\Data
  DataPath   := GIndyPath+ 'builder\Package Generator\Data';

end;

procedure TDM.SetDataPath(const AValue: String);
begin
  FDataPath := AValue;
  if not tablFile.Active then
  begin
    tablFile.DatabaseName := AValue;
  end;
end;

initialization
  if ParamCount > 0 then  begin
     GIndyPath := IncludeTrailingPathDelimiter(ParamStr(1));
  end else begin
    GIndyPath := UpTwoDirs(ExtractFilePath(ParamStr(0)));
  end;
end.
 
