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
{   Rev 1.1    3/28/2005 1:11:46 PM  JPMugaas
{ Package build errors.
}
{
{   Rev 1.0    3/28/2005 5:53:06 AM  JPMugaas
{ New security package.
}
unit PackageSecurity;

interface

uses
  Package;

type
  TPackageSecurity = class(TPackage)
  protected
    procedure GenRequires; override;
    procedure GenFooter; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler : TCompiler; const AFlags : TGenerateFlags); override;
  end;

implementation

uses
  DModule;

{ TPackageSecurity }

constructor TPackageSecurity.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\Security';
end;

procedure TPackageSecurity.Generate(ACompiler : TCompiler; const AFlags : TGenerateFlags);
begin
  if not (ACompiler in Delphi_DotNet) then
    Exit;
  Prepare(iif(gfDesignTime in AFlags, 'dclIndySecurity', 'IndySecurity'), ACompiler);
  FDesc := 'Security';
  FExt := '.dpk';
  inherited Generate(ACompiler, AFlags);
  WriteFile;
end;

procedure TPackageSecurity.GenRequires;
begin
  Code('');
  Code('requires');
  if FDesignTime then
  begin
    Code('  Borland.Studio.Vcl.Design,');
  end
  else
  begin
    Code('  Borland.Delphi,');
    Code('  Borland.VclRtl,');
  end;
  Code('  ' + PackageName('IndySystem', FCompiler) + ',');
  Code('  ' + PackageName('IndyCore', FCompiler) + ',');
  Code('  ' + PackageName('IndyProtocols', FCompiler) + ',');
  if FDesignTime then
  begin
    Code('  ' + PackageName('IndySecurity', FCompiler) + ',');
    Code('  ' + PackageName('dclIndyCore', FCompiler) + ',');
    Code('  ' + PackageName('dclIndyProtocols',  FCompiler) + ',');
  end;
  Code('  Mono.Security,');
  Code('  System,');
  Code('  System.Data,');
  Code('  System.XML;');
end;

procedure TPackageSecurity.GenFooter;
begin
  //back door for embedding version information into an assembly
  //without having to do anything to the package directly.
  Code(iif(FDesignTime, '{$I IddclSecurity90ASM90.inc}', '{$I IdSecurity90ASM90.inc}'));
  inherited GenFooter;
end;

end.

