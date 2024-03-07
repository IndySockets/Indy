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
  protected
    procedure GenRequires; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

{ TPackageD8Master }

constructor TPackageD8Master.Create;
begin
  inherited;
  FOutputSubDir := 'Lib';
end;

procedure TPackageD8Master.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FName := 'Indy' + GCompilerID[ACompiler];
  FDesc := 'Master';
  FExt := '.dpk';
  inherited Generate(ACompiler, AFlags);
  WriteFile;
end;

procedure TPackageD8Master.GenRequires;
begin
  Code('');
  Code('requires');
  Code('  Borland.Delphi,');
  Code('  Borland.Vcl,');
  Code('  Borland.VclRtl;');
end;

end.

