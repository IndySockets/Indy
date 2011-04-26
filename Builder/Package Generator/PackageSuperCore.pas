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
  public
    procedure Generate(ACompiler: TCompiler); override;
  end;

implementation

uses
  DModule;

{ TPackageSuperCore }

procedure TPackageSuperCore.Generate(ACompiler: TCompiler);
begin
  inherited;
  FName := 'IndySuperCore' + GCompilerID[Compiler];
  FDesc := 'SuperCore';
  GenHeader;
  GenOptions;
  Code('');
  Code('requires');
  Code('  rtl,');
  Code('  IndySystem' + GCompilerID[Compiler] + ',');
  Code('  IndyCore' + GCompilerID[Compiler] + ';');
  GenContains;
  WriteFile(DM.OutputPath + '\Lib\SuperCore\');
end;

end.

