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
{   Rev 1.0    1/24/2024 6:25:00 PM  RLebeau
{ IdVers.inc generation.
}
unit PackageVersInc;

interface

uses
  Package;

type
  TVersInc = class(TPackage)
  private
    procedure GenIdVers;
    procedure GenAsmVers;
    procedure GenAsmInfo;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  Classes, SysUtils, DateUtils, DModule;

{ TVersInc }

constructor TVersInc.Create;
begin
  inherited;
  FExt := '.inc';
end;

procedure TVersInc.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  FCompiler := ACompiler;
  FDesignTime := False;
  FTemplate := False;

  if gfTemplate in AFlags then begin
    FTemplate := True;

    FName := 'IdVers';
    FExt := '.inc.tmpl';
    GenIdVers;
    FOutputSubDir := 'Lib\System';
    WriteFile;
    FOutputSubDir := 'Lib\FCL';
    WriteFile;

    FTemplate := False;
    FExt := '.inc';
  end;

  if gfRunTime in AFlags then begin
    FDesignTime := False;

    FName := 'IdVers';
    GenIdVers;
    FOutputSubDir := 'Lib\System';
    WriteFile;
    FOutputSubDir := 'Lib\FCL';
    WriteFile;

    FName := 'IdSystem90ASM90';
    FDesc := 'System Run-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\System';
    WriteFile;

    FName := 'IdCore90ASM90';
    FDesc := 'Core Run-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Core';
    WriteFile;

    FName := 'IdProtocols90ASM90';
    FDesc := 'Protocols Run-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Protocols';
    WriteFile;

    FName := 'IdSecurity90ASM90';
    FDesc := 'Security Run-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Security';
    WriteFile;

    // Why is the above file also in the Protocols directory???
    FOutputSubDir := 'Lib\Protocols';
    WriteFile;

    FName := 'IdAssemblyInfo';
    FDesc := '';
    FOutputSubDir := 'Lib\System';
    GenAsmInfo;
    WriteFile;
  end;

  if gfDesignTime in AFlags then begin
    FDesignTime := True;

    FName := 'IddclCore90ASM90';
    FDesc := 'Core Design-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Core';
    WriteFile;

    FName := 'IddclProtocols90ASM90';
    FDesc := 'Protocols Design-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Protocols';
    WriteFile;

    FName := 'IddclSecurity90ASM90';
    FDesc := 'Security Design-Time';
    GenAsmVers;
    FOutputSubDir := 'Lib\Security';
    WriteFile;
  end;
end;

procedure TVersInc.GenIdVers;
var
  FileVersion, BuildStr: String;
begin
  FCode.Clear;

  BuildStr := iif(FTemplate,
    IndyVersion_Build_Template,
    IndyVersion_Build_Str);

  FileVersion := iif(FTemplate,
    IndyVersion_FileVersion_Template,
    IndyVersion_FileVersion_Str);

  Code('  gsIdVersionMajor = ' + IndyVersion_Major_Str + ';');
  Code('  {$NODEFINE gsIdVersionMajor}');
  Code('  gsIdVersionMinor = ' + IndyVersion_Minor_Str + ';');
  Code('  {$NODEFINE gsIdVersionMinor}');
  Code('  gsIdVersionRelease = ' + IndyVersion_Release_Str + ';');
  Code('  {$NODEFINE gsIdVersionRelease}');
  Code('  gsIdVersionBuild = ' + BuildStr + ';');
  Code('  {$NODEFINE gsIdVersionBuild}');
  Code('');
  Code('  (*$HPPEMIT ''#define gsIdVersionMajor ' + IndyVersion_Major_Str + '''*)');
  Code('  (*$HPPEMIT ''#define gsIdVersionMinor ' + IndyVersion_Minor_Str + '''*)');
  Code('  (*$HPPEMIT ''#define gsIdVersionRelease ' + IndyVersion_Release_Str + '''*)');
  Code('  (*$HPPEMIT ''#define gsIdVersionBuild ' + BuildStr + '''*)');
  Code('  (*$HPPEMIT ''''*)');
  Code('');
  Code('  gsIdVersion = ''' + FileVersion + '''; {do not localize}');
  Code('  gsIdProductName = ''Indy'';  {do not localize}');
  Code('  gsIdProductVersion = ''' + IndyVersion_ProductVersion_Str + '''; {do not localize}');
end;

procedure TVersInc.GenAsmVers;
begin
  FCode.Clear;

  Code('[assembly: AssemblyDescription(''Internet Direct (Indy) ' + IndyVersion_ProductVersion_Str + ' ' + FDesc + ' Package for Borland Developer Studio'')]');
  Code('[assembly: AssemblyConfiguration('''')]');
  Code('[assembly: AssemblyCompany(''Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew'')]');
  Code('[assembly: AssemblyProduct(''Indy for Microsoft .NET Framework'')]');
  Code('[assembly: AssemblyCopyright(''Copyright © 1993 - ' + IntToStr(YearOf(Date)) + ' Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew'')]');
  Code('[assembly: AssemblyTrademark('''')]');
  Code('[assembly: AssemblyCulture('''')]');
  Code('[assembly: AssemblyTitle(''Indy .NET ' + FDesc + ' Package'')]');
  Code('[assembly: AssemblyVersion(''' + IndyVersion_ProductVersion_Str + '.*'')]');
  Code('[assembly: AssemblyDelaySign(false)]');
  Code('[assembly: AssemblyKeyFile('''')]');
  Code('[assembly: AssemblyKeyName('''')]');
end;

procedure TVersInc.GenAsmInfo;
var
  LFileName, LLine: string;
  Data: TStringList;
  I: Integer;
begin
  FCode.Clear;

  LFileName := DM.OutputPath + 'Lib\System\IdAssemblyInfo.pas';
  if FileExists(LFileName) then begin
    // TStreamReader would be preferred, but its broken!
    Data := TStringList.Create;
    try
      Data.LoadFromFile(LFileName);
      for I := 0 to Data.Count-1 do begin
        LLine := Data[I];
        if LLine <> 'unit IdAssemblyInfo;' then
          Code(LLine)
        else
          Break;
      end;
    finally
      Data.Free;
    end;
  end;

  Code('unit IdAssemblyInfo;');
  Code('');
  Code('interface');
  Code('');
  Code('uses');
  Code('  System.Reflection, System.Runtime.CompilerServices;');
  Code('');
  Code('//');
  Code('// General Information about an assembly is controlled through the following');
  Code('// set of attributes. Change these attribute values to modify the information');
  Code('// associated with an assembly.');
  Code('//');
  Code('[assembly: AssemblyTitle(''Indy'')]');
  Code('[assembly: AssemblyDescription(''Internet Direct (Indy) ' + IndyVersion_ProductVersion_Str +' for Visual Studio .NET'')]');
  Code('[assembly: AssemblyConfiguration('''')]');
  Code('[assembly: AssemblyCompany(''Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew'')]');
  Code('[assembly: AssemblyProduct(''Indy for Microsoft .NET Framework'')]');
  Code('[assembly: AssemblyCopyright(''Copyright © 1993 - ' + IntToStr(YearOf(Date)) + ' Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew'')]');
  Code('[assembly: AssemblyTrademark('''')]');
  Code('[assembly: AssemblyCulture('''')]');
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
  Code('[assembly: AssemblyVersion(''' + IndyVersion_ProductVersion_Str + '.*'')]');
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
  Code('//       relative to the project output directory which is');
  Code('//       %Project Directory%\bin\<configuration>. For example, if your KeyFile is');
  Code('//       located in the project directory, you would specify the AssemblyKeyFile');
  Code('//       attribute as [assembly: AssemblyKeyFile(''..\\..\\mykey.snk'')]');
  Code('//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework');
  Code('//       documentation for more information on this.');
  Code('//');
  Code('[assembly: AssemblyDelaySignAttribute(true)]');
  Code('[assembly: AssemblyKeyFileAttribute(''Indy.snk'')]');
  Code('[assembly: AssemblyKeyName('''')]');
  Code('');
  Code('implementation');
  Code('');
  Code('end.');
end;

end.

