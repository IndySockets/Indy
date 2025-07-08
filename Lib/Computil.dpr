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

var
  CmdParam, RegCompanyName, RegProductName, RegRoot, EnvName: string;
  ProductLanguage: Char;
  ProductVersion, RegVersion: Integer;

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

  procedure SetEnvPaths;
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
          Writeln(EnvName + ', Checking Registry: ' + RegRoot);
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
  CmdParam := UpperCase(ParamStr(1));

  // RLebeau 11/24/23: not using TWhichOption enum anymore, because it had
  // to be updated every time a new Delphi/C++Builder version is released.
  // Now parsing the input parameter and building up the required values
  // dynamically so the code is a bit more future-proof. It shouldn't need
  // to be updated again until the schema for the Registry key changes ...

  if CmdParam = 'HPPMODIFY' then begin
    HPPModify;
    Exit;
  end;

  if (Length(CmdParam) >= 7) and (Copy(CmdParam, 1, 5) = 'SETUP') then begin

    // 'SETUP' <Language> <Version>
    // ie 'SETUPD29' for Delphi v29.0, etc...
    // ie 'SETUPC29' for C++Builder v29.0, etc...

    ProductLanguage := CmdParam[6];
    if ((ProductLanguage = 'C') or (ProductLanguage = 'D')) and
       TryStrToInt(Copy(CmdParam, 7, MaxInt), ProductVersion) then
    begin
      // Determine Company registry key name...
      if ProductVersion >= 15 then begin
        RegCompanyName := 'Embarcadero';
      end
      else if ProductVersion >= 13 then begin
        RegCompanyName := 'CodeGear';
      end
      else begin
        RegCompanyName := 'Borland';
      end;

      // Determine Product registry key name...
      if ProductVersion >= 9 then begin
        RegProductName := 'BDS';
      end
      else if ProductLanguage = 'D' then begin
        RegProductName := 'Delphi';
      end else begin
        RegProductName := 'C++Builder';
      end;

      // Determine Product Version registry key name
      //
      // Note: Embarcadero resynced their internal product version
      // to match the compiler version in RAD Studio 13.0 Florence!
      //
      // RAD 12.0 = Product v29 -> BDS v23
      // RAD 13.0 = Product v37 -> BDS v37
      //
      if ProductVersion >= 37 then begin
        RegVersion := ProductVersion;  // Product v37+ -> BDS v37+
      end
      else if ProductVersion >= 30 then begin
        // no Product versions
        RegVersion := 0;
      end
      else if ProductVersion >= 20 then begin
        RegVersion := ProductVersion - 6;  // Product v20+ -> BDS v14+
      end
      else if ProductVersion >= 14 then begin
        RegVersion := ProductVersion - 7; // Product v14..19 -> BDS v7..12 (no v13)
      end
      else if ProductVersion = 13 then begin
        RegVersion := 0; // no Product v13
      end
      else if (ProductVersion = 12) and (ProductLanguage = 'D') then begin
        RegVersion := 5;  // Delphi 2007
      end
      else if (ProductVersion > 9) or
              ((ProductVersion = 9) and (ProductLanguage = 'D')) then // (no C++Builder v9)
      begin
        RegVersion := ProductVersion - 6; // Product v9..12 (no v13) -> BDS v3..6
      end
      else if (ProductLanguage = 'D') and (ProductVersion >= 2) then begin
        RegVersion := ProductVersion; // Product v2..8 (no v1)
      end
      else if (ProductLanguage = 'C') and
              (ProductVersion >= 1) and (ProductVersion <= 6) and
              (ProductVersion <> 2) then
      begin
        RegVersion := ProductVersion; // Product v1..6 (no v2, v7, or v8)
      end else begin
        RegVersion := 0;
      end;

      if RegVersion > 0 then begin
        EnvName := Format('ND%s%d', [ProductLanguage, ProductVersion]);
        RegRoot := Format('Software\%s\%s\%d.0', [RegCompanyName, RegProductName, RegVersion]);
        SetEnvPaths;
        Exit;
      end;
    end;
  end;

  Writeln('Invalid Parameter');
end.
