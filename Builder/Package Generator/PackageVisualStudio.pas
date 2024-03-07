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
  protected
    procedure GenHeader; override;
    procedure GenOptions; override;
    procedure GenContains; override;
    procedure GenFooter; override;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

{ TPackageVisualStudio }

constructor TPackageVisualStudio.Create;
begin
  inherited;
  FContainsClause := 'uses';
  FExt := '.dpr';
  FOutputSubDir := 'Lib';
end;

procedure TPackageVisualStudio.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FName := 'Indy.Sockets' + iif(gfDebug in AFlags, 'Debug', '');
  FDesc := '.Net Assembly';
  AddUnit('IdAssemblyInfo', 'System');
  inherited Generate(ACompiler, AFlags - [gfDesignTime]);
  WriteFile;
end;

procedure TPackageVisualStudio.GenHeader;
begin
  Code('library ' + FName + ';');
end;

procedure TPackageVisualStudio.GenOptions;
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

procedure TPackageVisualStudio.GenContains;
begin
  if FDebug then begin
    inherited GenContains();
  end else begin
    inherited GenContains('Indy.Sockets.Id', False);
  end;
end;

procedure TPackageVisualStudio.GenFooter;
begin
  Code('');
  Code('');
  Code('//');
  Code('// Version information for an assembly consists of the following four values:');
  Code('//');
  Code('//      Major Version');
  Code('//      Minor Version');
  Code('//      Build Number');
  Code('//      Revision');
  Code('//');
  Code('// You can specify all the values or you can default the Revision and Build Numbers');
  Code('// by using the ''*'' as shown below:');
  Code('');
  Code('');
  Code('//');
  Code('// In order to sign your assembly you must specify a key to use. Refer to the');
  Code('// Microsoft .NET Framework documentation for more information on assembly signing.');
  Code('//');
  Code('// Use the attributes below to control which key is used for signing.');
  Code('//');
  Code('// Notes:');
  Code('//   (*) If no key is specified, the assembly is not signed.');
  Code('//   (*) KeyName refers to a key that has been installed in the Crypto Service');
  Code('//       Provider (CSP) on your machine. KeyFile refers to a file which contains');
  Code('//       a key.');
  Code('//   (*) If the KeyFile and the KeyName values are both specified, the');
  Code('//       following processing occurs:');
  Code('//       (1) If the KeyName can be found in the CSP, that key is used.');
  Code('//       (2) If the KeyName does not exist and the KeyFile does exist, the key');
  Code('//           in the KeyFile is installed into the CSP and used.');
  Code('//   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.');
  Code('//       When specifying the KeyFile, the location of the KeyFile should be');
  Code('//       relative to the project output directory. For example, if your KeyFile is');
  Code('//       located in the project directory, you would specify the AssemblyKeyFile');
  Code('//       attribute as [assembly: AssemblyKeyFile(''mykey.snk'')], provided your output');
  Code('//       directory is the project directory (the default).');
  Code('//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework');
  Code('//       documentation for more information on this.');
  Code('//');
  Code('');
  Code('//');
  Code('// Use the attributes below to control the COM visibility of your assembly. By');
  Code('// default the entire assembly is visible to COM. Setting ComVisible to false');
  Code('// is the recommended default for your assembly. To then expose a class and interface');
  Code('// to COM set ComVisible to true on each one. It is also recommended to add a');
  Code('// Guid attribute.');
  Code('//');
  Code('');
  Code('//[assembly: Guid('')]');
  Code('//[assembly: TypeLibVersion(1, 0)]');
  Code('');
  Code('begin');
  inherited GenFooter;
end;

end.
