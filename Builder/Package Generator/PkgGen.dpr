{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  55378: PkgGen.dpr 
{
{   Rev 1.17    3/28/2005 5:53:16 AM  JPMugaas
{ New security package.
}
{
{   Rev 1.16    3/3/2005 7:46:22 PM  JPMugaas
{ Backdoors for BDS assembly version information.
}
{
{   Rev 1.15    25/11/2004 8:10:22 AM  czhower
{ Removed D4, D8, D10, D11
}
{
{   Rev 1.14    2004.11.14 10:35:34 AM  czhower
{ Update
}
{
{   Rev 1.13    12/10/2004 15:39:38  HHariri
{ Fixes for VS
}
{
{   Rev 1.12    9/7/2004 3:50:46 PM  JPMugaas
{ Updates.
}
{
{   Rev 1.11    04/09/2004 12:45:18  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.10    2004.08.30 11:27:54  czhower
{ Updates
}
{
{   Rev 1.9    2004.06.13 8:06:10 PM  czhower
{ Update for D8
}
{
{   Rev 1.8    6/10/2004 6:55:36 PM  JPMugaas
{ Bug fix, filtered was not true when it should've been causing units to be
{ added to the wrong packages.  This was a bug I introduced.  Sorry.
}
{
{   Rev 1.7    09/06/2004 12:06:54  CCostelloe
{ Added Kylix 3
}
{
{   Rev 1.6    6/8/2004 3:52:54 PM  JPMugaas
{ FTP List generation should work.
}
{
{   Rev 1.5    6/8/2004 2:16:36 PM  JPMugaas
{ Now does the FTP List parser listing unit.
}
{
{   Rev 1.4    02/06/2004 17:00:44  HHariri
{ design-time added
}
{
{   Rev 1.3    2004.05.19 10:01:54 AM  czhower
{ Updates
}
{
{   Rev 1.2    2004.01.22 8:17:58 PM  czhower
{ Updates
}
program PkgGen;

{$APPTYPE CONSOLE}

uses
  Classes,
  {$IFDEF WIN32}
  Windows,
  {$ENDIF}
  DB,
  SysUtils,
  Package in 'Package.pas',
  PackageVisualStudio in 'PackageVisualStudio.pas',
  PackageD8Master in 'PackageD8Master.pas',
  PackageSystem in 'PackageSystem.pas',
  PackageSuperCore in 'PackageSuperCore.pas',
  PackageCore in 'PackageCore.pas',
  PackageProtocols in 'PackageProtocols.pas',
  PackageFTPParsers in 'PackageFTPParsers.pas',
  PackageSecurity in 'PackageSecurity.pas',
  PackageBuildRes in 'PackageBuildRes.pas',
  PackageVersInc in 'PackageVersInc.pas',
  PackageCleanCmd in 'PackageCleanCmd.pas',
  PackageLazarus in 'PackageLazarus.pas',
  DModule in 'DModule.pas';

procedure Main;
var
  LDebugFlag: TGenerateFlags;
begin
  DM := TDM.Create(nil); try
    with DM do begin
      WriteLn('INI Path: ' + Ini.FileName );

      if FindCmdLineSwitch('checkini') then begin
        WriteLn('Checking for missing files to add to INI...');
        CheckForMissingFiles;
        Exit;
      end;

      InitVersionNumbers;

      LDebugFlag := [];
      if FindCmdLineSwitch('debugPkgs') then begin
        Include(LDebugFlag, gfDebug);
        WriteLn('Will Generate Debug Packages');
      end else begin
        WriteLn('Will Not Generate Debug Packages');
      end;

      WriteLn;
      WriteLn('Generating Visual Studio Package...');

      with TPackageVisualStudio.Create do try
        Load('DotNet=True, DesignUnit=False', True);
        Generate(ctDotNet);

        Load('DotNet=True, DesignUnit=False', True);
        Generate(ctDotNet, [gfDebug]{LDebugFlag});
      finally Free; end;

      WriteLn('Generating Lazarus Package...');

      with TPackageLazarus.Create do try
        // nothing to load from the database...
        //Load('FPC=True, FPCListInPkg=True');
        Generate(ctUnversioned, []{LDebugFlag});
      finally Free; end;

      WriteLn('Generating D8 Master Package...');

      with TPackageD8Master.Create do try
        Load('DelphiDotNet=True, DesignUnit=False', True);
        Generate(Delphi_DotNet, LDebugFlag);
      finally Free; end;

      WriteLn('Generating System Package...');

      with TPackageSystem.Create do try
        Load('VCL=True, Pkg=System, DesignUnit=False');
        Generate(Delphi_Native, LDebugFlag);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=System, DesignUnit=False');
        Generate(Delphi_DotNet_1_1, LDebugFlag);
         //
        Load('DelphiDotNet=True, Pkg=System, DesignUnit=False');
        Generate(Delphi_DotNet_2_Or_Later, LDebugFlag);
        //
        Load('Kylix=True, Pkg=System');
        Generate(ctKylix3, LDebugFlag);
        //
        GenerateRC([ctUnversioned] + Delphi_Native, [gfRunTime, gfDesignTime] + LDebugFlag);
      finally Free; end;

      WriteLn('Generating Core Package...');

      with TPackageCore.Create do try
        Load('VCL=True, Pkg=Core, DesignUnit=False');
        Generate(Delphi_Native, LDebugFlag);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Core, DesignUnit=False');
        Generate(Delphi_DotNet_1_1, LDebugFlag);
        //
        Load('DelphiDotNet=True, Pkg=Core, DesignUnit=False');
        Generate(Delphi_DotNet_2_Or_Later, LDebugFlag);
        //
        Load('Kylix=True, Pkg=Core, DesignUnit=False');
        Generate(ctKylix3, LDebugFlag);
        //
        Load('VCL=True, Pkg=Core, DesignUnit=True');
        Generate(Delphi_Native, [gfDesignTime] + LDebugFlag);
        //
        Load('DelphiDotNet=True, Pkg=Core, DesignUnit=True');
        Generate(Delphi_DotNet, [gfDesignTime] + LDebugFlag);
        //
        Load('Kylix=True, Pkg=Core, DesignUnit=True');
        Generate(ctKylix3, [gfDesignTime] + LDebugFlag);
        //
        GenerateRC([ctUnversioned] + Delphi_Native, [gfRunTime, gfDesignTime] + LDebugFlag);
        GenerateDsnCoreResourceStrings;
      finally Free; end;

      WriteLn('Generating Protocols Package...');

      with TPackageProtocols.Create do try
        Load('VCL=True, Pkg=Protocols, DesignUnit=False');
        Generate(Delphi_Native, LDebugFlag);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Protocols, DesignUnit=False');
        Generate(Delphi_DotNet_1_1, LDebugFlag);
        //
        Load('DelphiDotNet=True, Pkg=Protocols, DesignUnit=False');
        Generate(Delphi_DotNet_2_Or_Later, LDebugFlag);
        //
        Load('Kylix=True, Pkg=Protocols, DesignUnit=False');
        Generate(ctKylix3, LDebugFlag);
        //
        Load('VCL=True, Pkg=Protocols, DesignUnit=True');
        Generate(Delphi_Native, [gfDesignTime] + LDebugFlag);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Protocols, DesignUnit=True');
        Generate(Delphi_DotNet_1_1, [gfDesignTime] + LDebugFlag);
        //
        Load('DelphiDotNet=True, Pkg=Protocols, DesignUnit=True');
        Generate(Delphi_DotNet_2_Or_Later, [gfDesignTime] + LDebugFlag);
        //
        Load('Kylix=True, Pkg=Protocols, DesignUnit=True');
        Generate(ctKylix3, [gfDesignTime] + LDebugFlag);
        //
        GenerateRC([ctUnversioned] + Delphi_Native, [gfRunTime, gfDesignTime] + LDebugFlag);
      finally Free; end;

      WriteLn('Generating Security Package...');

      with TPackageSecurity.Create do try
        //We are not going to support the Security package in NET 2.0.
        Load('DelphiDotNet=True, Pkg=Security, DesignUnit=False');
        Generate(Delphi_DotNet_1_1, LDebugFlag);
        //
        Load('DelphiDotNet=True, Pkg=Security, DesignUnit=True');
        Generate(Delphi_DotNet_1_1, [gfDesignTime] + LDebugFlag);
      finally Free; end;

      WriteLn('Generating SuperCore Package...');

      with TPackageSuperCore.Create do try
        Load('VCL=True, Pkg=SuperCore');
        Generate(ctDelphi7, LDebugFlag);
      finally Free; end;

      WriteLn('Generating FTP Parsers unit...');

      // FTP Parsers
      with TFTPParsers.Create do try
        Load('VCL=True, Pkg=Protocols, FTPParser=True, DesignUnit=False');
        Generate(ctUnversioned, LDebugFlag);
      finally Free; end;

      WriteLn('Generating Version include files...');

      with TVersInc.Create do try
        // nothing to load from the database...
        Generate(ctUnversioned, [gfRunTime, gfDesignTime, gfTemplate]);
      finally Free; end;

      WriteLn('Generating Resource files...');

      with TBuildRes.Create do try
        // nothing to load from the database...
        Generate(Delphi_Native);
      finally Free; end;

      WriteLn('Generating Clean.cmd scripts...');

      with TCleanCmd.Create do try
        // nothing to load from the database...
        Generate([ctDelphiXE3..Delphi_Native_Highest]);
      finally Free; end;

      // TODO: generate FULLC_xxx.bat scripts...
    end;
  finally
    FreeAndNil(DM);
  end;
end;

begin
  try
    Main;
  except
    on E: Exception do begin
      WriteLn(E.Message);
   //   raise;
    end;
  end;

  WriteLn;
  WriteLn('Done! Press ENTER to exit...');
  ReadLn;
end.
