{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  115447: VersionMarker.dpr 
{
{   Rev 1.5    3/28/2005 6:02:02 AM  JPMugaas
{ New packages.
}
{
{   Rev 1.4    3/3/2005 7:44:44 PM  JPMugaas
{ Version information for packages.
}
{
{   Rev 1.3    3/3/2005 4:46:10 PM  JPMugaas
{ Now manages version info for other stuff.
}
{
{   Rev 1.2    3/03/05 1:32:34 PM  czhower
{ update
}
program VersionMarker;

{$APPTYPE CONSOLE}

uses
  ExceptionLog,
  Classes,
  INIFiles,
  SysUtils;

const
  MASK_COPYRIGHT = '{COPYRIGHT}';
  MASK_COMPANY = '{COMPANY}';
  MASK_MAJOR = '{MAJORVER}';
  MASK_MINOR = '{MINORVER}';
  MASK_POINT = '{POINTVER}';
  NASK_TITLE = '{TITLE}';
  MASK_DESCRIPTION = '{DESCRIPTION}';

//I know that globals look sloppy but this might be a good case
//for them

const
  xIdVersFile = 'W:\source\Indy10\Lib\System\IdVers.inc';
var
  xINI: TINIFile;
  xVerMajor: Integer;
  xVerMinor: Integer;
  xVerPoint: Integer;
  xVerString: string;
  xCopyright: string;
  xCompany : String;
  xTitle : String;
  xDescription : String;

procedure ReplaceInFile(const ASourceFileName, ADestFileName : String);
var S : TStrings;
  LTmp : String;
begin
  s := TStringList.Create;
  try
    s.LoadFromFile( ASourceFileName);
    LTmp := s.Text;      //xVerString
    LTmp := SysUtils.StringReplace(LTmp,MASK_COPYRIGHT,xCopyright,[rfReplaceAll]);
    LTmp := SysUtils.StringReplace(LTmp,MASK_COMPANY,xCompany,[rfReplaceAll]);
    LTmp := SysUtils.StringReplace(LTmp,MASK_DESCRIPTION,xDescription+' '+ xVerString,[rfReplaceAll]);
    LTmp := SysUtils.StringReplace(LTmp,NASK_TITLE,xTitle,[rfReplaceAll]);

    LTmp := SysUtils.StringReplace(LTmp,MASK_MAJOR,IntToStr(xVerMajor),[rfReplaceAll]);
    LTmp := SysUtils.StringReplace(LTmp,MASK_MINOR,IntToStr(xVerMinor),[rfReplaceAll]);
    LTmp := SysUtils.StringReplace(LTmp,MASK_POINT,IntToStr(xVerPoint),[rfReplaceAll]);

    s.Text := LTmp;
    s.SaveToFile( ADestFileName );
  finally
    FreeAndNil(s);
  end;
end;

procedure Main;

begin
  try
    xINI := TINIFile.Create(ChangeFileExt(ParamStr(0), '.ini')); try
      xVerMajor := xINI.ReadInteger('Version', 'Major', 10);
      xVerMinor := xINI.ReadInteger('Version', 'Minor', 0);
      xVerPoint := xINI.ReadInteger('Version', 'Point', 60) + 1;
      xVerString := IntToStr(xVerMajor) + '.' + IntToStr(xVerMinor) + '.'
        + IntToStr(xVerPoint);
      xCopyright := xINI.ReadString('Version','Copyright','Copyright © 1993 - 2005 Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew');
      xCompany := xINI.ReadString('Version','Company','Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew');
      xTitle := xINI.ReadString('Version','Title','Indy');
      xDescription := xINI.ReadString('Version','Description','Internet Direct (Indy)');

      with TStringList.Create do try
        LoadFromFile(xIdVersFile);
        Strings[0] := '  gsIdVersion = ''' + xVerString + '''; {do not localize}';
        SaveToFile(xIdVersFile);
      finally Free; end;

      // FB script for VS.NET

      xINI.WriteInteger('Version', 'Major', xVerMajor);
      xINI.WriteInteger('Version', 'Minor', xVerMinor);
      xINI.WriteInteger('Version', 'Point', xVerPoint);
      xINI.WriteString('Version', 'String', xVerString);
      //
      xINI.WriteString(xVerString, 'Date', DateToStr(Date));

      WriteLn(xVerString);
    finally FreeAndNil(xINI); end;
    //protocols packages - design time
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndy100.rc','w:\source\Indy10\Lib\Protocols\dclIndyProtocols100.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndy90.rc','w:\source\Indy10\Lib\Protocols\dclIndyProtocols90.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndy70.rc','w:\source\Indy10\Lib\Protocols\dclIndyProtocols70.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndy60.rc','w:\source\Indy10\Lib\Protocols\dclIndyProtocols60.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndy50.rc','w:\source\Indy10\Lib\Protocols\dclIndyProtocols50.rc');
    //protocols packages - run time
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\Indy100.rc','w:\source\Indy10\Lib\Protocols\IndyProtocols100.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\Indy90.rc','w:\source\Indy10\Lib\Protocols\IndyProtocols90.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\Indy70.rc','w:\source\Indy10\Lib\Protocols\IndyProtocols70.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\Indy60.rc','w:\source\Indy10\Lib\Protocols\IndyProtocols60.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\Indy50.rc','w:\source\Indy10\Lib\Protocols\IndyProtocols50.rc');

    //core package - design time
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndyCore100.rc','w:\source\Indy10\Lib\Core\dclIndyCore100.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndyCore90.rc','w:\source\Indy10\Lib\Core\dclIndyCore90.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndyCore70.rc','w:\source\Indy10\Lib\Core\dclIndyCore70.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndyCore60.rc','w:\source\Indy10\Lib\Core\dclIndyCore60.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\dclIndyCore50.rc','w:\source\Indy10\Lib\Core\dclIndyCore50.rc');
    //core package - run time
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndyCore100.rc','w:\source\Indy10\Lib\Core\IndyCore100.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndyCore90.rc','w:\source\Indy10\Lib\Core\IndyCore90.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndyCore70.rc','w:\source\Indy10\Lib\Core\IndyCore70.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndyCore60.rc','w:\source\Indy10\Lib\Core\IndyCore60.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndyCore50.rc','w:\source\Indy10\Lib\Core\IndyCore50.rc');
    //core package - run time
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndySystem100.rc','w:\source\Indy10\Lib\System\IndySystem100.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndySystem90.rc','w:\source\Indy10\Lib\System\IndySystem90.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndySystem70.rc','w:\source\Indy10\Lib\System\IndySystem70.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndySystem60.rc','w:\source\Indy10\Lib\System\IndySystem60.rc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IndySystem50.rc','w:\source\Indy10\Lib\System\IndySystem50.rc');
    // Borland Delphi Studio Packages for DotNET version info
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IdSystem90ASM90.inc','w:\source\Indy10\Lib\System\IdSystem90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IddclCore90ASM90.inc','w:\source\Indy10\Lib\Core\IddclCore90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IdCore90ASM90.inc','w:\source\Indy10\Lib\Core\IdCore90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IddclProtocols90ASM90.inc','w:\source\Indy10\Lib\Protocols\IddclProtocols90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IdProtocols90ASM90.inc','w:\source\Indy10\Lib\Protocols\IdProtocols90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IddclSecurity90ASM90.inc','w:\source\Indy10\Lib\Security\IddclSecurity90ASM90.inc');
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IdSecurity90ASM90.inc','w:\source\Indy10\Lib\Security\IdSecurity90ASM90.inc');
    //IdAssemblyInfo for Visual Studio .NET
    ReplaceInFile(ExtractFilePath(ParamStr(0))+ 'Data\IdAssemblyInfo.pas','w:\source\Indy10\Lib\System\IdAssemblyInfo.pas');
  except
    on E: Exception do begin
      WriteLn(E.Message);
      ReadLn;
    end;
  end;
end;

begin
  Main;
end.
