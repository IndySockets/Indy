{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  10019: Computil.dpr 
{
{   Rev 1.4    24/08/2004 12:41:44  ANeillans
{ Modified to ensure the registry object is opened in Read Only mode.
}
{
{   Rev 1.3    7/14/04 1:40:26 PM  RLebeau
{ removed some repeating code
}
{
{   Rev 1.2    14/07/2004 21:15:38  ANeillans
{ Modification to allow both HKLM and HKCU to be used for fetching binary path.
}
{
{   Rev 1.1    03/05/2004 15:36:22  ANeillans
{ Bug fix: Rootdir blank causes AV.  Changes HKEY_LOCAL_MACHINE to
{ HKEY_CURRENT_USER.
}
{
{   Rev 1.0    2002.11.12 10:25:38 PM  czhower
}
program CompUtil;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Registry, Classes;

type
  TWhichOption = (
   woHppModify,

   woSetupD2,woSetupD3,woSetupD4,woSetupD5,woSetupD6,woSetupD7,woSetupD8,
   woSetupD9,woSetupD10,woSetupD11,woSetupD12,woSetupD14,woSetupD15,woSetupD16,
   woSetupD17,woSetupD18,woSetupD19,woSetupD20,woSetupD21,woSetupD22,woSetupD23,
   woSetupD24,woSetupD25,woSetupD26,

   woSetupC1,woSetupC3,woSetupC4,woSetupC5,woSetupC6,woSetupC7,woSetupC8,
   woSetupC9,woSetupC10,woSetupC11,woSetupC12,woSetupC14,woSetupC15,woSetupC16,
   woSetupC17,woSetupC18,woSetupC19,woSetupC20,woSetupC21,woSetupC22,woSetupC23,
   woSetupC24,woSetupC25,woSetupC26,

   woInvalid);

var
  Options: array[TWhichOption] of String = (
    'HppModify',

    'SetupD2','SetupD3','SetupD4','SetupD5','SetupD6','SetupD7','SetupD8',
    'SetupD9','SetupD10','SetupD11','SetupD12','SetupD14','SetupD15','SetupD16',
    'SetupD17','SetupD18','SetupD19','SetupD20','SetupD21','SetupD22','SetupD23',
    'SetupD24','SetupD25','SetupD26',

    'SetupC1','SetupC3','SetupC4','SetupC5','SetupC6','SetupC7','SetupC8',
    'SetupC9','SetupC10','SetupC11','SetupC12','SetupC14','SetupC15','SetupC16',
    'SetupC17','SetupC18','SetupC19','SetupC20','SetupC21','SetupC22','SetupC23',
    'SetupC24','SetupC25','SetupC26',

    'Invalid'
    );

  WhichOption: TWhichOption;
  CmdParam: string;

  procedure HPPModify;
  var
    InFile: file;
    OutFile: text;
    Line: AnsiString;
    Buffer: pointer;
    BufPtr: PAnsiChar;
    BufSize: longint;
    EOL: boolean;
  begin
  // Fix C++Builder HPP conversion bug:
  //   - Input line in RVDefine.pas is
  //       TRaveUnits = {$IFDEF WIN32}type{$ENDIF} TRaveFloat;
  //
  //   - Invalid output line in RVDefine.hpp is
  //       typedef TRaveUnits TRaveUnits;
  //
  //   - Valid output line in RVDefine.hpp should be
  //       typedef double TRaveUnits;

  { Read in RVDefine.hpp as binary }
    AssignFile(InFile,ParamStr(2) + 'RVDefine.hpp');
    Reset(InFile,1);
    BufSize := FileSize(InFile);
    GetMem(Buffer,BufSize);
    BlockRead(InFile,Buffer^,BufSize);
    CloseFile(InFile);
    BufPtr := Buffer;

  { Write out modified RVDefine.hpp as text }
    AssignFile(OutFile,ParamStr(2) + 'RVDefine.hpp');
    Rewrite(OutFile);
    While BufSize > 0 do begin
      Line := '';
      EOL := false;
      Repeat { Get a line of text }
        If BufPtr^ = #13 then begin
          Inc(BufPtr);
          Dec(BufSize);
          Inc(BufPtr);
          Dec(BufSize);
          EOL := true;
        end else begin
          Line := Line + BufPtr^;
          Inc(BufPtr);
          Dec(BufSize);
        end; { else }
      until EOL or (BufSize = 0);
      If Line = 'typedef TRaveUnits TRaveUnits;' then begin
        Line := 'typedef double TRaveUnits;';
      end; { if }
      Writeln(OutFile,Line);
    end; { while }
    CloseFile(OutFile);
  end; { HPPModify }

  procedure SetPath(EnvName: string; RegRoot: string);
  var
    CompilerFound: boolean;
    SysDirFound: boolean;
    KeyOpened: boolean;
    EnvUpdated: boolean;
    EnvList: TStringList;
    SysDir: string;
    ShortPath: string;
    LongPath: string;
  begin
    CompilerFound := GetEnvironmentVariable(PChar(EnvName), nil, 0) <> 0;
    SysDirFound := GetEnvironmentVariable('NDWINSYS', nil, 0) <> 0;

    If (not CompilerFound) or (not SysDirFound) then begin
      EnvUpdated := False;
      EnvList := TStringList.Create;
      try
        If FileExists('SetEnv.bat') then begin { Read in existing file }
          EnvList.LoadFromFile('SetEnv.bat');
        end; { if }

        If not CompilerFound then begin { Get compiler path and add to string list }
          With TRegistry.Create do try
            RootKey := HKEY_LOCAL_MACHINE;
            KeyOpened := OpenKeyReadOnly(RegRoot);
            if not KeyOpened then begin
              Writeln('Resetting registry rootkey to HKCU, and retrying');
              RootKey := HKEY_CURRENT_USER;
              KeyOpened := OpenKeyReadOnly(RegRoot);
            End;
            if KeyOpened and ValueExists('RootDir') then begin
              LongPath := ReadString('RootDir');
              SetLength(ShortPath, MAX_PATH);	// when casting to a PChar, be sure the string is not empty
              SetLength(ShortPath, GetShortPathName(PChar(LongPath), PChar(ShortPath), MAX_PATH) );
              If (ShortPath[1] = #0) or (Length(ShortPath) = Length(LongPath)) then begin
                ShortPath := LongPath;
              end;
              EnvList.Add('SET ' + EnvName + '=' + ShortPath);
              EnvUpdated := True;
            end else begin
              Writeln('Compiler not installed!');
              Halt(1);
            End; { else }
          finally
            Free;
          end; { with }
        end; { if }

        If not SysDirFound then begin { Get System Directory and add to string list }
          SetLength(SysDir, MAX_PATH);
          SetLength(SysDir, GetSystemDirectory(PChar(SysDir), MAX_PATH));
          EnvList.Add('SET NDWINSYS=' + SysDir);
          EnvUpdated := True;
        end; { if }

        If EnvUpdated then begin
          EnvList.SaveToFile('SetEnv.bat');
        End; { if }
      finally
        EnvList.Free;
      end; { tryf }
    end; { if }
  end;  { SetPath }

begin
{ Figure out which feature to run }
  CmdParam := ParamStr(1);
  WhichOption := Low(WhichOption);
  While WhichOption < High(WhichOption) do begin
    If UpperCase(CmdParam) = UpperCase(Options[WhichOption]) then begin
      Break;
    end; { if }
    Inc(WhichOption);
  end; { while }

  Case WhichOption of
    woHppModify: HPPModify;

    woSetupD2:  SetPath('NDD2','Software\Borland\Delphi\2.0');
    woSetupD3:  SetPath('NDD3','Software\Borland\Delphi\3.0');
    woSetupD4:  SetPath('NDD4','Software\Borland\Delphi\4.0');
    woSetupD5:  SetPath('NDD5','Software\Borland\Delphi\5.0');
    woSetupD6:  SetPath('NDD6','Software\Borland\Delphi\6.0');
    woSetupD7:  SetPath('NDD7','Software\Borland\Delphi\7.0');
    woSetupD8:  SetPath('NDD8','Software\Borland\Delphi\8.0');
    woSetupD9:  SetPath('NDD9','Software\Borland\BDS\3.0');
    woSetupD10: SetPath('NDD10','Software\Borland\BDS\4.0');
    woSetupD11: SetPath('NDD11','Software\Borland\BDS\5.0');
    woSetupD12: SetPath('NDD12','Software\CodeGear\BDS\6.0');
    woSetupD14: SetPath('NDD14','Software\CodeGear\BDS\7.0');
    woSetupD15: SetPath('NDD15','Software\Embarcadero\BDS\8.0');
    woSetupD16: SetPath('NDD16','Software\Embarcadero\BDS\9.0');
    woSetupD17: SetPath('NDD17','Software\Embarcadero\BDS\10.0');
    woSetupD18: SetPath('NDD18','Software\Embarcadero\BDS\11.0');
    woSetupD19: SetPath('NDD19','Software\Embarcadero\BDS\12.0');
    woSetupD20: SetPath('NDD20','Software\Embarcadero\BDS\14.0');
    woSetupD21: SetPath('NDD21','Software\Embarcadero\BDS\15.0');
    woSetupD22: SetPath('NDD22','Software\Embarcadero\BDS\16.0');
    woSetupD23: SetPath('NDD23','Software\Embarcadero\BDS\17.0');
    woSetupD24: SetPath('NDD24','Software\Embarcadero\BDS\18.0');
    woSetupD25: SetPath('NDD25','Software\Embarcadero\BDS\19.0');
    woSetupD26: SetPath('NDD26','Software\Embarcadero\BDS\20.0');

    woSetupC1:  SetPath('NDC1','Software\Borland\C++Builder\1.0');
    woSetupC3:  SetPath('NDC3','Software\Borland\C++Builder\3.0');
    woSetupC4:  SetPath('NDC4','Software\Borland\C++Builder\4.0');
    woSetupC5:  SetPath('NDC5','Software\Borland\C++Builder\5.0');
    woSetupC6:  SetPath('NDC6','Software\Borland\C++Builder\6.0');
    woSetupC10: SetPath('NDC10','Software\Borland\BDS\4.0');
    woSetupC11: SetPath('NDC11','Software\Borland\BDS\5.0');
    woSetupC12: SetPath('NDC12','Software\CodeGear\BDS\6.0');
    woSetupC14: SetPath('NDC14','Software\CodeGear\BDS\7.0');
    woSetupC15: SetPath('NDC15','Software\Embarcadero\BDS\8.0');
    woSetupC16: SetPath('NDC16','Software\Embarcadero\BDS\9.0');
    woSetupC17: SetPath('NDC17','Software\Embarcadero\BDS\10.0');
    woSetupC18: SetPath('NDC18','Software\Embarcadero\BDS\11.0');
    woSetupC19: SetPath('NDC19','Software\Embarcadero\BDS\12.0');
    woSetupC20: SetPath('NDC20','Software\Embarcadero\BDS\14.0');
    woSetupC21: SetPath('NDC21','Software\Embarcadero\BDS\15.0');
    woSetupC22: SetPath('NDC22','Software\Embarcadero\BDS\16.0');
    woSetupC23: SetPath('NDC23','Software\Embarcadero\BDS\17.0');
    woSetupC24: SetPath('NDC24','Software\Embarcadero\BDS\18.0');
    woSetupC25: SetPath('NDC25','Software\Embarcadero\BDS\19.0');
    woSetupC26: SetPath('NDC26','Software\Embarcadero\BDS\20.0');

    woInvalid:  Writeln('Invalid Parameter');
  end; { case }
end.
