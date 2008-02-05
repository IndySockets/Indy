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
{   Rev 1.10    3/4/2005 3:22:12 PM  JPMugaas
{ Updated for fix.
}
{
{   Rev 1.9    3/4/2005 3:12:40 PM  JPMugaas
{ Attempt to make D5 package work.
}
{
{   Rev 1.8    3/4/2005 3:02:06 PM  JPMugaas
{ Remove D5 VCL dependancy in run-time package.
}
{
{   Rev 1.7    3/3/2005 7:46:24 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.6    25/11/2004 8:10:22 AM  czhower
{ Removed D4, D8, D10, D11
}
{
{   Rev 1.5    9/7/2004 3:50:46 PM  JPMugaas
{ Updates.
}
{
{   Rev 1.4    04/09/2004 12:45:18  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.3    2004.08.30 11:27:58  czhower
{ Updates
}
{
{   Rev 1.2    03/06/2004 7:50:26  HHariri
{ Fixed Protocols Package Description
}
{
{   Rev 1.1    02/06/2004 17:00:46  HHariri
{ design-time added
}
{
{   Rev 1.0    2004.02.08 2:28:38 PM  czhower
{ Initial checkin
}
{
{   Rev 1.0    2004.01.22 8:18:34 PM  czhower
{ Initial checkin
}
unit PackageProtocols;

interface

uses
  Package;

type
  TPackageProtocols = class(TPackage)
  public
    procedure Generate(ACompiler: TCompiler); override;
    procedure GenerateDT(ACompiler: TCompiler); override;
  end;

implementation

uses DModule;

{ TPackageProtocols }

procedure TPackageProtocols.Generate(ACompiler: TCompiler);
begin
  inherited;
  FName := 'IndyProtocols' + GCompilerID[Compiler];
  FDesc := 'Protocols';
  GenHeader;
  GenOptions;
  Code('');
  Code('requires');
  if ACompiler = ctDelphi5 then
  begin
  end
  else
  begin
    if ACompiler in DelphiNet then begin
     // Code('  System.Windows.Forms,');
      Code('  Borland.Delphi,');
      Code('  Borland.VclRtl,');
    end else begin
      Code('  rtl,');
    end;
  end;
  Code('  IndySystem' + GCompilerID[Compiler] + ',');
  Code('  IndyCore' + GCompilerID[Compiler] + ';');
  GenContains;
    //back door for embedding version information into an assembly
  //without having to do anything to the package directly.
  if ACompiler in DelphiNet then
  begin
    Code('{$I IdProtocols90ASM90.inc}');
  end;
  WriteFile(DM.OutputPath + '\Lib\Protocols\');
end;

procedure TPackageProtocols.GenerateDT(ACompiler: TCompiler);
begin
  inherited;
  FName := 'dclIndyProtocols' + GCompilerID[Compiler];
  FDesc := 'Protocols Design Time';
  GenHeader;
  GenOptions(True);
  Code('');
  Code('requires');
  case ACompiler of
    ctDelphi2005Net:
    begin
      Code('  Borland.Delphi,');
      Code('  Borland.VclRtl,');
      Code('  Borland.Studio.Vcl.Design,');
    end;
    ctDelphi5: Code('  Vcl50,');
    ctDelphi6:
      begin
        Code('  Vcl,');
        Code('  designide,');
      end;
    ctDelphi7:
      begin
        Code('  rtl,');
        Code('  designide,');
        Code('  vclactnband,');
        Code('  vclx,');
        Code('  vcl,');
      end;
  end;
  Code('  IndyProtocols' + GCompilerID[Compiler] + ',');
  Code('  IndySystem' + GCompilerID[Compiler] + ',');
  Code('  IndyCore' + GCompilerID[Compiler] + ',');
  Code('  dclIndyCore' + GCompilerID[Compiler] + ';');
  GenContains;
    //back door for embedding version information into an assembly
  //without having to do anything to the package directly.
  if ACompiler in DelphiNet then
  begin
    Code('{$I IddclProtocols90ASM90.inc}');
  end;
  WriteFile(DM.OutputPath + '\Lib\Protocols\');
end;

end.

