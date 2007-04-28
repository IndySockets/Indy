{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13362: Computil.dpr 
{
{   Rev 1.0    11/13/2002 02:50:46 PM  JPMugaas
}
program CompUtil;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Registry, Classes;

type
  TWhichOption = (woHppModify,woSetupD2,woSetupD3,woSetupD4,woSetupD5,woSetupD6,
   woSetupD7,woSetupD8,woSetupD9,woSetupD10,woSetupD11,woSetupC1,woSetupC3,
   woSetupC4,woSetupC5,woSetupC6,woSetupC7,woSetupC8,woSetupC9,woInvalid);

var
  Options: array[TWhichOption] of String = ('HppModify','SetupD2','SetupD3',
   'SetupD4','SetupD5','SetupD6','SetupD7','SetupD8','SetupD9','SetupD10',
   'SetupD11','SetupC1','SetupC3','SetupC4','SetupC5','SetupC6','SetupC7',
   'SetupC8','SetupC9','Invalid');
  WhichOption: TWhichOption;
  CmdParam: string;

  procedure HPPModify;
  var
    InFile: file;
    OutFile: text;
    Line: string;
    Buffer: pointer;
    BufPtr: PChar;
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
  const
    MaxPathLen = 67;
  var
    CompilerFound: boolean;
    SysDirFound: boolean;
    VarName: string;
    EnvList: TStringList;
    SysDir: string;
    ShortPath: string;
    LongPath: string;
  begin
    VarName := EnvName;
    CompilerFound := GetEnvironmentVariable(@VarName[1],nil,0) <> 0;
    VarName := 'NDWINSYS';
    SysDirFound := GetEnvironmentVariable(@VarName[1],nil,0) <> 0;

    If not CompilerFound or not SysDirFound then begin
      EnvList := TStringList.Create;
      try
        If FileExists('SetEnv.bat') then begin { Read in existing file }
          EnvList.LoadFromFile('SetEnv.bat');
        end; { if }

        If not CompilerFound then begin { Get compiler path and add to string list }
          With TRegistry.Create do try
            RootKey := HKEY_LOCAL_MACHINE;
            If OpenKey(RegRoot,false) and ValueExists('RootDir') then begin
              LongPath := ReadString('RootDir');
              SetLength(ShortPath, MaxPathLen);	// when casting to a PChar, be sure the string is not empty
              SetLength(ShortPath, GetShortPathName(PChar(LongPath), PChar(ShortPath), MaxPathLen) );
              If (ShortPath[1] = #0) or (Length(ShortPath) = Length(LongPath)) then begin
                ShortPath := LongPath;
              end;
              EnvList.Add('SET ' + EnvName + '=' + ShortPath);
              EnvList.SaveToFile('SetEnv.bat');
            end else begin
              Writeln('Compiler not installed!');
              Halt(1);
            end; { else }
          finally
            Free;
          end; { with }
        end; { if }

        If not SysDirFound then begin { Get System Directory and add to string list }
          VarName := 'NDWINSYS';
          If GetEnvironmentVariable(@VarName[1],nil,0) = 0 then begin { Not found }
            SetLength(SysDir,255);
            SetLength(SysDir,GetSystemDirectory(@SysDir[1],255));
            EnvList.Add('SET NDWINSYS=' + SysDir);
            EnvList.SaveToFile('SetEnv.bat');
          end; { if }
        end; { if }
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
    woSetupC1:  SetPath('NDC1','Software\Borland\C++Builder\1.0');
    woSetupC3:  SetPath('NDC3','Software\Borland\C++Builder\3.0');
    woSetupC4:  SetPath('NDC4','Software\Borland\C++Builder\4.0');
    woSetupC5:  SetPath('NDC5','Software\Borland\C++Builder\5.0');
    woSetupC6:  SetPath('NDC6','Software\Borland\C++Builder\6.0');
    woInvalid:  Writeln('Invalid Parameter');
  end; { case }
end.
