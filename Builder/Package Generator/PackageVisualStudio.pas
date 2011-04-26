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
{   Rev 1.5    2004.11.14 10:35:34 AM  czhower
{ Update
}
{
{   Rev 1.4    12/10/2004 17:52:34  HHariri
{ Fixes for VS
}
{
{   Rev 1.3    12/10/2004 15:39:30  HHariri
{ Fixes for VS
}
{
{   Rev 1.2    04/09/2004 12:45:16  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.1    2004.05.19 10:01:52 AM  czhower
{ Updates
}
{
{   Rev 1.0    2004.01.22 8:18:36 PM  czhower
{ Initial checkin
}
unit PackageVisualStudio;

interface

uses
  Package;

type
  TPackageVisualStudio = class(TPackage)
  public
    Debug: Boolean;
    //
    constructor Create; override;
    procedure GenHeader; override;
    procedure GenOptions(ADesignTime: Boolean = False); override;
    procedure Generate(ACompiler: TCompiler); override;
  end;

implementation

uses DModule;

{ TPackageVisualStudio }

constructor TPackageVisualStudio.Create;
begin
  inherited;
  FContainsClause := 'uses';
  FExt := '.dpr';
end;

procedure TPackageVisualStudio.Generate(ACompiler: TCompiler);
begin
  inherited;
  if Debug then begin
    FName := 'Indy.SocketsDebug';
  end else begin
    FName := 'Indy.Sockets';
  end;
  FDesc := '.Net Assembly';
  AddUnit('IdAssemblyInfo', 'System');
  GenHeader;
  GenOptions;
  if Debug then begin
    GenContains();
  end else begin
    GenContains('Indy.Sockets.Id', False);
  end;
  Code('');
  Code('begin');
  WriteFile(DM.OutputPath + '\Lib\');
end;

procedure TPackageVisualStudio.GenHeader;
begin
  Code('library ' + FName + ';');
end;

procedure TPackageVisualStudio.GenOptions(ADesignTime: Boolean);
begin
  Code('');
  Code('{%DelphiDotNetAssemblyCompiler ''$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.dll''}');
  // Dont seem to need .Delphi? But internal errors when not included sometimes
  Code('{%DelphiDotNetAssemblyCompiler ''$(CommonProgramFiles)\borland shared\bds\shared assemblies\3.0\Borland.Delphi.dll''}');
  // Doesnt seem to need this either - likely the visual parts are here
  //Code('{%DelphiDotNetAssemblyCompiler ''$(CommonProgramFiles)\borland shared\bds\shared assemblies\3.0\Borland.Vcl.dll''}');
  Code('{%DelphiDotNetAssemblyCompiler ''$(CommonProgramFiles)\borland shared\bds\shared assemblies\3.0\Borland.VclRtl.dll''}');
  Code('');
end;

end.
