{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  55597: PackageVisualStudio.pas 
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

uses DataModule;

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
//  Code('[assembly: AssemblyTitle('''')]');
//  Code('[assembly: AssemblyDescription('''')]');
//  Code('[assembly: AssemblyConfiguration('''')]');
//  Code('[assembly: AssemblyCompany('''')]');
//  Code('[assembly: AssemblyProduct('''')]');
//  Code('[assembly: AssemblyCopyright('''')]');
//  Code('[assembly: AssemblyTrademark('''')]');
//  Code('[assembly: AssemblyCulture('''')]');
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
//  Code('[assembly: AssemblyVersion(''1.0.*'')]');
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
//  Code('[assembly: AssemblyDelaySign(false)]');
//  Code('[assembly: AssemblyKeyFile('')]');
//  Code('[assembly: AssemblyKeyName('')]');
  Code('');
  Code('//');
  Code('// Use the attributes below to control the COM visibility of your assembly. By');
  Code('// default the entire assembly is visible to COM. Setting ComVisible to false');
  Code('// is the recommended default for your assembly. To then expose a class and interface');
  Code('// to COM set ComVisible to true on each one. It is also recommended to add a');
  Code('// Guid attribute.');
  Code('//');
  Code('');
//  Code('[assembly: ComVisible(False)]');
  Code('//[assembly: Guid('')]');
  Code('//[assembly: TypeLibVersion(1, 0)]');
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
  // Dont seem to need .Delphi? But intenral errors when not included sometimes
  Code('{%DelphiDotNetAssemblyCompiler ''c:\program files\common files\borland shared\bds\shared assemblies\3.0\Borland.Delphi.dll''}');
  // Doesnt seem to need this either - likely the visual parts are here
  //Code('{%DelphiDotNetAssemblyCompiler ''c:\program files\common files\borland shared\bds\shared assemblies\3.0\Borland.Vcl.dll''}');
  Code('{%DelphiDotNetAssemblyCompiler ''c:\program files\common files\borland shared\bds\shared assemblies\3.0\Borland.VclRtl.dll''}');
  Code('');
end;

end.
