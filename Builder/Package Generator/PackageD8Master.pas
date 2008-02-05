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
{   Rev 1.3    04/09/2004 12:45:18  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.2    2004.08.30 11:27:56  czhower
{ Updates
}
{
{   Rev 1.1    2004.05.19 10:01:50 AM  czhower
{ Updates
}
{
{   Rev 1.0    2004.01.22 8:18:36 PM  czhower
{ Initial checkin
}
unit PackageD8Master;

interface

uses
  Package;

type
  TPackageD8Master = class(TPackage)
  public
    procedure Generate(ACompiler: TCompiler); override;
  end;

implementation

uses DModule;

{ TPackageD8Master }

procedure TPackageD8Master.Generate(ACompiler: TCompiler);
begin
  inherited;
  FName := 'Indy' + GCompilerID[Compiler];
  FDesc := 'Master';
  GenHeader;
  GenOptions;
  Code('');
  Code('requires');
  Code('  Borland.Delphi,');
  Code('  Borland.Vcl,');
  Code('  Borland.VclRtl;');
  GenContains;
  WriteFile(DM.OutputPath + '\Lib\');
end;

end.

