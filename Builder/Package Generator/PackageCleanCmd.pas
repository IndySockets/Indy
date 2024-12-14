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
{   Rev 1.0    1/24/2024 4:49:00 PM  RLebeau
{ Clean_xxx.cmd generation.
}
unit PackageCleanCmd;

interface

uses
  Package;

type
  TCleanCmd = class(TPackage)
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils;

{ TCleanCmd }

constructor TCleanCmd.Create;
begin
  inherited;
  FOutputSubDir := 'Lib';
end;

type
  TCleanInfo = record
    ProductName: string;
    Symbol: string;
    FileSuffix: string;
  end;
const
  GCleanCompilers: array[TCompiler] of TCleanInfo = (
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: 'Delphi XE3';           Symbol: 'D17';  FileSuffix: 'XE3'),
    (ProductName: 'Delphi XE4';           Symbol: 'D18';  FileSuffix: 'XE4'),
    (ProductName: 'Delphi XE5';           Symbol: 'D19';  FileSuffix: 'XE5'),
    (ProductName: 'Delphi XE6';           Symbol: 'D20';  FileSuffix: 'XE6'),
    (ProductName: 'Delphi XE7';           Symbol: 'D21';  FileSuffix: 'XE7'),
    (ProductName: 'Delphi XE8';           Symbol: 'D22';  FileSuffix: 'XE8'),
    (ProductName: 'Delphi 10.0 Seattle';  Symbol: 'D23';  FileSuffix: 'Seattle'),
    (ProductName: 'Delphi 10.1 Berlin';   Symbol: 'D24';  FileSuffix: 'Berlin'),
    (ProductName: 'Delphi 10.2 Tokyo';    Symbol: 'D25';  FileSuffix: 'Tokyo'),
    (ProductName: 'Delphi 10.3 Rio';      Symbol: 'D26';  FileSuffix: 'Rio'),
    (ProductName: 'Delphi 10.4 Sydney';   Symbol: 'D27';  FileSuffix: 'Sydney'),
    (ProductName: 'Delphi 11 Alexandria'; Symbol: 'D28';  FileSuffix: 'Alexandria'),
    (ProductName: 'Delphi 12 Athens';     Symbol: 'D29';  FileSuffix: 'Athens'),
    (ProductName: '';                     Symbol: '';     FileSuffix: ''),
    (ProductName: '';                     Symbol: '';     FileSuffix: '')
  );

procedure TCleanCmd.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.
  //inherited;

  if (GCleanCompilers[ACompiler].ProductName = '') or
     (GCleanCompilers[ACompiler].Symbol = '') then Exit;

  FName := 'Clean_' + GCleanCompilers[ACompiler].FileSuffix;
  FExt := '.cmd';

  FCompiler := ACompiler;
  FCode.Clear;
  FDesignTime := False;

  Code('@echo off');
  Code('set DelphiProd=' + GCleanCompilers[ACompiler].ProductName);
  Code('');
  Code('if exist SetEnv.bat del SetEnv.bat');
  Code('if not exist computil.exe goto NoComputil');
  Code('computil Setup' + GCleanCompilers[ACompiler].Symbol);
  Code('if defined ND' + GCleanCompilers[ACompiler].Symbol + ' goto RSVARS');
  Code('if not exist SetEnv.bat goto NoNDD');
  Code('');
  Code('call SetEnv.bat > nul:');
  Code('if not defined ND' + GCleanCompilers[ACompiler].Symbol + ' goto NoNDD');
  Code('');
  Code(':RSVARS');
  Code('call "%ND' + GCleanCompilers[ACompiler].Symbol + '%bin\rsvars.bat"');
  Code('if not defined BDS goto NoBDS');
  Code('');
  Code('set logfn=Clean' + GCleanCompilers[ACompiler].Symbol + '.log');
  Code('');
  Code('call Clean_IDE.cmd');
  Code('goto END');
  Code('');
  Code(':NoCompUtil');
  Code('echo Computil.exe not found--run this batch script from the "Lib" folder of the Indy repository, recently pulled from GitHub.');
  Code('goto END');
  Code('');
  Code(':NoNDD');
  Code('echo Computil.exe did not create the batch script for setting up the environment for %DelphiProd%. Aborting.');
  Code('goto END');
  Code('');
  Code(':NoBDS');
  Code('echo Calling RSVars did not set up the environment for %DelphiProd%. Aborting.');
  Code('');
  Code(':END');
  Code('set logfn=');
  Code('set DelphiProd=');

  WriteFile;
end;

end.

