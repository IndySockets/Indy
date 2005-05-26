{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  57051: PackageSystem.pas 
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
  if ACompiler = ctDelphi2005Net then
  begin
    //back door for embedding version information into an assembly
  //without having to do anything to the package directly.

    Code('{$I IdSystem90ASM90.inc}');
  end
  else
  begin
    if ACompiler in DelphiNet then begin
      Code('[assembly: AssemblyDescription('''')]');
      Code('[assembly: AssemblyConfiguration('''')]');
      Code('[assembly: AssemblyCompany('''')]');
      Code('[assembly: AssemblyProduct('''')]');
      Code('[assembly: AssemblyCopyright('''')]');
      Code('[assembly: AssemblyTrademark('''')]');
      Code('[assembly: AssemblyCulture('''')]');
      Code('[assembly: AssemblyTitle('''')]');
      // Major Version.Minor Version.Build Number.Revision
      // * can be used to specify no more items are specified. ie 10.*
      Code('[assembly: AssemblyVersion(''10.0.0.*'')]');
      {
      TODO: Sign it. Need to keep key private as well.
      Use the attributes below to control which key is used for signing.
      Notes:
      (*) If no key is specified, the assembly is not signed.
      (*) KeyName refers to a key that has been installed in the Crypto Service
          Provider (CSP) on your machine. KeyFile refers to a file which contains
          a key.
      (*) If the KeyFile and the KeyName values are both specified, the
          following processing occurs:
          (1) If the KeyName can be found in the CSP, that key is used.
          (2) If the KeyName does not exist and the KeyFile does exist, the key
              in the KeyFile is installed into the CSP and used.
      (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
          When specifying the KeyFile, the location of the KeyFile should be
          relative to the project output directory. For example, if your KeyFile is
          located in the project directory, you would specify the AssemblyKeyFile
          attribute as [assembly: AssemblyKeyFile('mykey.snk')], provided your output
          directory is the project directory (the default).
      (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
          documentation for more information on this.
    }
    Code('[assembly: AssemblyDelaySign(false)]');
    Code('[assembly: AssemblyKeyFile('''')]');
    Code('[assembly: AssemblyKeyName('''')]');
    end;
  end;
  WriteFile(DM.OutputPath + '\Lib\System\');
end;

end.

