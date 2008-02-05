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
{   Rev 1.4    3/3/2005 7:46:24 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.3    04/09/2004 12:45:16  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.2    2004.06.13 8:06:12 PM  czhower
{ Update for D8
}
{
{   Rev 1.1    02/06/2004 17:00:48  HHariri
{ design-time added
}
{
{   Rev 1.0    2004.02.08 2:28:40 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageSystem;

interface

uses
  Package;

type
  TPackageSystem = class(TPackage)
  public
    procedure Generate(ACompiler: TCompiler); override;
  end;

implementation

uses DModule;

{ TPackageD7Core }

procedure TPackageSystem.Generate(ACompiler: TCompiler);
begin
  inherited;
  FName := 'IndySystem' + GCompilerID[Compiler];
  FDesc := 'System';
  GenHeader;
  GenOptions;
  Code('');
  Code('requires');
  if ACompiler = ctDelphi5 then begin
    Code('  Vcl50;');
  end else if ACompiler in DelphiNet then begin
    Code('Borland.Delphi,');
    Code('Borland.VclRtl;');
  end else begin
    Code('  rtl;');
  end;
  GenContains;
  if ACompiler in DelphiNet then
  begin
    //back door for embedding version information into an assembly
  //without having to do anything to the package directly.

    Code('{$I IdSystem90ASM90.inc}');
  end
  else
  begin
  end;
  WriteFile(DM.OutputPath + '\Lib\System\');
end;

end.

