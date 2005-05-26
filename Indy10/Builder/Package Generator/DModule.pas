{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  55375: DataModule.pas 
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
  private
  protected
    FDataPath : String;
    FOutputPath : String;
    procedure SetDataPath(const AValue : String);
  public
    property DataPath : String read FDataPath write SetDataPath;
    property OutputPath : String read FOutputPath write FOutputPath;
  end;

var
  DM: TDM;

implementation
{$R *.dfm}

{ TDM }

procedure TDM.SetDataPath(const AValue: String);
begin
  FDataPath := AValue;
  if not tablFile.Active then
  begin
    tablFile.DatabaseName := AValue;
  end;
end;

end.
 
