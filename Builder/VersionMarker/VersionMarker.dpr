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
 // xIdVersFile = 'W:\source\Indy10\Lib\System\IdVers.inc';
  gIdVersFile = 'Lib\System\IdVers.inc';

var
  gBasePath : string;
  gIniPath : String;
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

function CurrentYear : Word;
var lm, ld : Word;
begin
  SysUtils.DecodeDate(Now,Result,lm,ld);
end;

procedure Main;

begin
  //find base path
  if ParamCount > 0 then
  begin
    gBasePath := ParamStr(1)+'\';
  end
  else
  begin
    gBasePath := ExtractFilePath(ParamStr(0));
  end;
  gIniPath := gBasePath+'Builder\VersionMarker\'+ExtractFileName(ChangeFileExt(ParamStr(0), '.ini'));
  try
    //10.2.5
    xINI := TINIFile.Create(gIniPath); try
      xVerMajor := xINI.ReadInteger('Version', 'Major', 10);
      xVerMinor := xINI.ReadInteger('Version', 'Minor', 0);
      xVerPoint := xINI.ReadInteger('Version', 'Point', 60) + 1;
      xVerString := IntToStr(xVerMajor) + '.' + IntToStr(xVerMinor) + '.'
        + IntToStr(xVerPoint);
      xCopyright := xINI.ReadString('Version','Copyright','Copyright © 1993 - '+ IntToStr(CurrentYear)+ ' Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew');
      xCompany := xINI.ReadString('Version','Company','Chad Z. Hower a.k.a Kudzu and the Indy Pit Crew');
      xTitle := xINI.ReadString('Version','Title','Indy');
      xDescription := xINI.ReadString('Version','Description','Internet Direct (Indy)');

      with TStringList.Create do try
        LoadFromFile(gBasePath + gIdVersFile);
        Strings[0] := '  gsIdVersion = ''' + xVerString + '''; {do not localize}';
        SaveToFile(gBasePath + gIdVersFile);
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
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy100.rc',gBasePath+'\Lib\Protocols\dclIndyProtocols120.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy100.rc',gBasePath+'\Lib\Protocols\dclIndyProtocols100.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy90.rc',gBasePath+'Lib\Protocols\dclIndyProtocols90.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy70.rc',gBasePath+'Lib\Protocols\dclIndyProtocols70.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy60.rc',gBasePath+'Lib\Protocols\dclIndyProtocols60.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndy50.rc',gBasePath+'Lib\Protocols\dclIndyProtocols50.rc');
    //protocols packages - run time
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy100.rc',gBasePath+'Lib\Protocols\IndyProtocols120.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy100.rc',gBasePath+'Lib\Protocols\IndyProtocols100.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy90.rc',gBasePath+'Lib\Protocols\IndyProtocols90.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy70.rc',gBasePath+'Lib\Protocols\IndyProtocols70.rc');

    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy60.rc',gBasePath+'Lib\Protocols\IndyProtocols60.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\Indy50.rc',gBasePath+'Lib\Protocols\IndyProtocols50.rc');

    //core package - design time
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore120.rc',gBasePath+'Lib\Core\dclIndyCore120.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore100.rc',gBasePath+'Lib\Core\dclIndyCore100.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore90.rc',gBasePath+'Lib\Core\dclIndyCore90.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore70.rc',gBasePath+'Lib\Core\dclIndyCore70.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore60.rc',gBasePath+'Lib\Core\dclIndyCore60.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\dclIndyCore50.rc',gBasePath+'Lib\Core\dclIndyCore50.rc');
    //core package - run time
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore120.rc',gBasePath+'Lib\Core\IndyCore120.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore100.rc',gBasePath+'Lib\Core\IndyCore100.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore90.rc',gBasePath+'Lib\Core\IndyCore90.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore70.rc',gBasePath+'Lib\Core\IndyCore70.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore60.rc',gBasePath+'Lib\Core\IndyCore60.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndyCore50.rc',gBasePath+'Lib\Core\IndyCore50.rc');
    //core package - run time
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem120.rc',gBasePath+'Lib\System\IndySystem120.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem100.rc',gBasePath+'Lib\System\IndySystem100.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem90.rc',gBasePath+'Lib\System\IndySystem90.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem70.rc',gBasePath+'Lib\System\IndySystem70.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem60.rc',gBasePath+'Lib\System\IndySystem60.rc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IndySystem50.rc',gBasePath+'Lib\System\IndySystem50.rc');
    // Borland Delphi Studio Packages for DotNET version info
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IdSystem90ASM90.inc',gBasePath+'Lib\System\IdSystem90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IddclCore90ASM90.inc',gBasePath+'Lib\Core\IddclCore90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IdCore90ASM90.inc',gBasePath+'Lib\Core\IdCore90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IddclProtocols90ASM90.inc',gBasePath+'Lib\Protocols\IddclProtocols90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IdProtocols90ASM90.inc',gBasePath+'Lib\Protocols\IdProtocols90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IddclSecurity90ASM90.inc',gBasePath+'Lib\Security\IddclSecurity90ASM90.inc');
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IdSecurity90ASM90.inc',gBasePath+'Lib\Security\IdSecurity90ASM90.inc');
    //IdAssemblyInfo for Visual Studio .NET
    ReplaceInFile(gBasePath+ 'Builder\VersionMarker\Data\IdAssemblyInfo.pas',gBasePath+'Lib\System\IdAssemblyInfo.pas');
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
