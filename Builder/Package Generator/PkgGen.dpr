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
  DModule in 'DModule.pas';



procedure Main;
begin
  DM := TDM.Create(nil); try
    with DM do begin
      WriteLn('Path: '+ Ini.FileName );

      if FindCmdLineSwitch('checkini') then begin
        CheckForMissingFiles;
        Exit;
      end;

      with TPackageVisualStudio.Create do try
        Load('DotNet=True, DesignUnit=False', True);
        Generate(ctDotNet);
      finally Free; end;

      // Debug version
      with TPackageVisualStudio.Create do try
        Debug := True;
        Load('DotNet=True, DesignUnit=False', True);
        Generate(ctDotNet);
      finally Free; end;

      with TPackageD8Master.Create do try
        Load('DelphiDotNet=True, DesignUnit=False', True);
        Generate(DelphiNet);
      finally Free; end;

      with TPackageSystem.Create do try
        Load('VCL=True, Pkg=System, DesignUnit=False');
        Generate(DelphiNative);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=System, DesignUnit=False');
        Generate(DelphiNet1_1);
         //
        Load('DelphiDotNet=True, Pkg=System, DesignUnit=False');
        Generate(DelphiNet2OrLater);
        //
        Load('Kylix=True, Pkg=System');
        Generate(ctKylix3);
      finally Free; end;

      with TPackageCore.Create do try
        Load('VCL=True, Pkg=Core, DesignUnit=False');
        Generate(DelphiNative);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Core, DesignUnit=False');
        Generate(DelphiNet1_1);
        //
        Load('DelphiDotNet=True, Pkg=Core, DesignUnit=False');
        Generate(DelphiNet2OrLater);
        //
        Load('Kylix=True, Pkg=Core, DesignUnit=False');
        Generate(ctKylix3);
        //
        Load('VCL=True, Pkg=Core, DesignUnit=True');
        GenerateDT(DelphiNative);
        //
        Load('DelphiDotNet=True, Pkg=Core, DesignUnit=True');
        GenerateDT(DelphiNet);
        //
        Load('Kylix=True, Pkg=Core, DesignUnit=True');
        GenerateDT(ctKylix3);
      finally Free; end;

      with TPackageProtocols.Create do try
        Load('VCL=True, Pkg=Protocols, DesignUnit=False');
        Generate(DelphiNative);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Protocols, DesignUnit=False');
        Generate(DelphiNet1_1);
        //
        Load('DelphiDotNet=True, Pkg=Protocols, DesignUnit=False');
        Generate(DelphiNet2OrLater);
        //
        Load('Kylix=True, Pkg=Protocols, DesignUnit=False');
        Generate(ctKylix3);
        //
        Load('VCL=True, Pkg=Protocols, DesignUnit=True');
        GenerateDT(DelphiNative);
        //
        Load('DelphiDotNet=True, DotNet2_0OrAboveOnly=False, Pkg=Protocols, DesignUnit=True');
        GenerateDT(DelphiNet1_1);
        //
        Load('DelphiDotNet=True, Pkg=Protocols, DesignUnit=True');
        GenerateDT(DelphiNet2OrLater);
        //
        Load('Kylix=True, Pkg=Protocols, DesignUnit=True');
        GenerateDT(ctKylix3);
      finally Free; end;

      with TPackageSecurity.Create do try
        //We are not going to support the Security package in NET 2.0.
        Load('DelphiDotNet=True, Pkg=Security, DesignUnit=False');
        Generate(DelphiNet1_1);
        //
        Load('DelphiDotNet=True, Pkg=Security, DesignUnit=True');
        GenerateDT(DelphiNet1_1);
      finally Free; end;

      with TPackageSuperCore.Create do try
        Load('VCL=True, Pkg=SuperCore');
        Generate(ctDelphi7);
      finally Free; end;

      // FTP Parsers
      with TFTPParsers.Create do try
        Load('VCL=True, Pkg=Protocols, FTPParser=True, DesignUnit=False');
        Generate(ctDelphi7);
      finally Free; end;
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

  WriteLn('Done! Press ENTER to exit...');
  ReadLn;
end.
