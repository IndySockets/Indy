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
{   Rev 1.1    04/09/2004 12:45:44  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.0    2004.06.02 3:19:56 PM  czhower
{ Initial Checkin
}
{
{   Rev 1.0    2004.02.08 2:28:38 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageSuperCore;

interface

uses
  Package;

type
  TPackageSuperCore = class(TPackage)
  protected
    procedure GenRequires; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

{ TPackageSuperCore }

constructor TPackageSuperCore.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\SuperCore';
end;

procedure TPackageSuperCore.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FName := 'IndySuperCore' + GCompilerID[ACompiler];
  FDesc := 'SuperCore';
  FExt := '.dpk';
  inherited Generate(ACompiler, AFlags - [gfDesignTime]);
  WriteFile;
end;

procedure TPackageSuperCore.GenRequires;
begin
  Code('');
  Code('requires');
  Code('  rtl,');
  Code('  IndySystem' + GCompilerID[FCompiler] + ',');
  Code('  IndyCore' + GCompilerID[FCompiler] + ';');
end;

end.

