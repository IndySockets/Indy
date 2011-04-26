program LazPkgGen;

{$APPTYPE CONSOLE}

uses
  ShellAPI,
  Windows,
  Classes,
  SysUtils,
  DModule in 'DModule.pas' {DM: TDataModule};

{
I can't use PkgGen to create packages at all.

There are two reasons:

1) We are only going to make one complete set of .lpk (Lazarus package files.
The same .lpk file will be used for Linux, FreeBSD, Windows, and whatever else
because we will NOT list any system-specific units.  We let the compiler link
those in.  I am doing this to provide developers a way to cross-compile
Indy units and have more than one set of binaries for different
platform/operating system combinations.  I also do not have to know
what system Indy will be compiled on.  I'm thinking a hierarchy such as this:

===
  System
    lib
      i386-win32
      arm-wince
      i386-linux
      x64-linux
      sparc-linux
      ppc-linux
  Core
    lib
      i386-win32
      arm-wince
      i386-linux
      x64-linux
      sparc-linux
      ppc-linux
  Protocols
    lib
      i386-win32
      arm-wince
      i386-linux
      x64-linux
      sparc-linux
      ppc-linux
===

2) The program assumes all you pass to a code generation
procedure is a unit file name.  In Lazarus, this is NOT so.  In Lazarus,
each file is listed as an XML entry.  This entry has attributes such as
"hasregisterproc".  Then for a few design-time packages, there is an associated
(.LRS file that contains resources such as our XPM component icons and that an
additional entry.

Not only do you need file entries but a count of the entries.

The format is like this:

===
    <Files Count="9">
      <Item1>
        <Filename Value="IdAbout.pas"/>
        <UnitName Value="IdAbout"/>
      </Item1>
      <Item2>
        <Filename Value="IdAboutVCL.pas"/>
        <UnitName Value="IdAboutVCL"/>
      </Item2>
      <Item3>
        <Filename Value="IdAboutVCL.lrs"/>
        <Type Value="LRS"/>
      </Item3>
      <Item4>
        <Filename Value="IdAntiFreeze.pas"/>
        <UnitName Value="IdAntiFreeze"/>
      </Item4>
      <Item5>
        <Filename Value="IdDsnBaseCmpEdt.pas"/>
        <UnitName Value="IdDsnBaseCmpEdt"/>
      </Item5>
      <Item6>
        <Filename Value="IdDsnCoreResourceStrings.pas"/>
        <UnitName Value="IdDsnCoreResourceStrings"/>
      </Item6>
      <Item7>
        <Filename Value="IdRegisterCore.pas"/>
        <HasRegisterProc Value="True"/>
        <UnitName Value="IdRegisterCore"/>
      </Item7>
      <Item8>
        <Filename Value="IdRegisterCore.lrs"/>
        <Type Value="LRS"/>
      </Item8>
      <Item9>
        <Filename Value="IdCoreDsnRegister.pas"/>
        <HasRegisterProc Value="True"/>
        <UnitName Value="IdCoreDsnRegister"/>
      </Item9>
    </Files>
===
}

const
  LF = #10;
  CR = #13;
  EOL = CR + LF;
  
//i is a var that this procedure will cmanage for the main loop.
procedure WriteLRSEntry(const AFile: String; var VEntryCount : Integer; var VOutput : String);
var
  s : String;
begin
  Inc(VEntryCount);
  s := '      <Item'+IntToStr(VEntryCount)+'>'+EOL;
  s := s +'        <Filename Value="' + AFile + '.pas"/>'+EOL;
  if StrToBoolDef(DM.Ini.ReadString(AFile, 'FPCHasRegProc', ''), False) then
  begin
    s := s +'        <HasRegisterProc Value="True"/>'+EOL;
  end;
  s := s +'        <UnitName Value="'+ AFile + '"/>'+EOL;
  s := s +'      </Item'+IntToStr(VEntryCount)+'>'+EOL;
  if StrToBoolDef(DM.Ini.ReadString(AFile, 'FPCHasLRSFile', ''), False) then
  begin
    Inc(VEntryCount);
    s := s +'      <Item'+IntToStr(VEntryCount)+'>'+EOL;
    s := s +'        <Filename Value="' + AFile +'.lrs"/>'+EOL;
    s := s +'        <Type Value="LRS"/>'+EOL;
    s := s +'      </Item'+IntToStr(VEntryCount)+'>'+EOL;
  end;
  VOutput := VOutput + s;
end;

function MakeLRS(const ACriteria: string; const AFileName : String) : String;
var
  i, cnt : Integer;
  s : String;
  LFiles, LS : TStringList;
begin
  LS := TStringList.Create;
  try
    LS.LoadFromFile(DM.OutputPath+ '\Builder\Package Generator\LazTemplates\' + AFileName);
    Result := LS.Text;
  finally
    LS.Free;
  end;
  cnt := 0;
  s := '';
  LFiles := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LFiles);
    for I := 0 to LFiles.Count-1 do
    begin
      WriteLRSEntry(LFiles[i], cnt, s);
    end;
  finally
    LFiles.Free;
  end;
  s := '    <Files Count="'+IntToStr(cnt)+'">'+ EOL +
    s +'    </Files>';
  Result := StringReplace(Result,'{%FILES}', s, [rfReplaceAll]);
end;

procedure WriteFile(const AContents, AFileName : String);
var
  LCodeOld: string;
begin
  if FileExists(AFileName) then begin
    with TStringList.Create do try
      LoadFromFile(AFileName);
      LCodeOld := Text;
    finally Free; end;
  end;
 // Only write out the code if its different. This prevents unnecessary checkins as well
  // as not requiring user to lock all packages

  if (LCodeOld = '') or (LCodeOld <> AContents) then begin
    with TStringList.Create do try
      Text := AContents;
      SaveToFile(AFileName);
    finally Free; end;
    WriteLn('Generated ' + AFileName);
  end;
end;

procedure MakeFPCMasterPackage(const ACriteria: string; const AFileName : String;
  const AOutPath : String);
var
  LFiles, LS : TStringList;
  Lst : String;
  i : Integer;
  LTemp : String;
begin
  LFiles := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LFiles);
    //construct our make file
    LS := TStringList.Create;
    try
      LS.LoadFromFile(DM.OutputPath + '\Builder\Package Generator\LazTemplates\' + AFileName + '-Makefile.fpc');
      LTemp := LS.Text;
    finally
      FreeAndNil(LS);
    end;
    Lst := '';
    for i := 0 to LFiles.Count -1 do
    begin
      if (i = LFiles.Count -1) then
      begin
        LSt := Lst + '  ' + LFiles[i] + EOL;
      end else begin
        LSt := Lst + '  ' + LFiles[i] + ' \' + EOL;
      end;
    end;
    Lst := 'implicitunits=' + TrimLeft(Lst);
    LTemp := StringReplace(LTemp, '{%FILES}', LSt, [rfReplaceAll]);
    WriteFile(LTemp, AOutPath + '\' + AFileName + '-Makefile.fpc');
  finally
    LFiles.Free;
  end;
end;

procedure MakeFPCPackage(const ACriteria: string; const AFileName : String;
  const AOutPath : String);
var
  LCode, LS : TStringList;
  Lst : String;
  i : Integer;
  LTemp : String;
begin
  LCode := TStringList.Create;
  try
    DM.GetFileList(ACriteria, LCode);

    //construct our make file
    LS := TStringList.Create;
    try
      LS.LoadFromFile(GIndyPath + 'Builder\Package Generator\LazTemplates\' + AFileName + '-Makefile.fpc');
      LTemp := LS.Text;
    finally
      LS.Free;
    end;

    //now make our package file.  This is basically a dummy unit that lists

    Lst := '';
    for i := 0 to LCode.Count -1 do
    begin
      if (i = LCode.Count -1) then
      begin
        LSt := Lst + '  ' + LCode[i] + EOL;
      end else begin
        LSt := Lst + '  ' + LCode[i]+ ' \' + EOL;
      end;
    end;

    Lst := 'implicitunits=' + TrimLeft(Lst);
    LTemp := StringReplace(LTemp, '{%FILES}', LSt, [rfReplaceAll]);
    WriteFile(LTemp, AOutPath + '\Makefile.fpc');

    //all of the files.
    for i := 0 to LCode.Count -1 do
    begin
      if (i = LCode.Count-1)  then
      begin
        LCode[i] := '  ' + LCode[i] + ';';
      end else begin
        LCode[i] := '  ' + LCode[i] + ',';
      end;
    end;

    LCode.Insert(0, 'uses');
    LCode.Insert(0, '');
    LCode.Insert(0, 'interface');
    LCode.Insert(0, '');
    LCode.Insert(0, 'unit ' + AFileName + ';');
    //
    LCode.Add('');
    LCode.Add('implementation');
    LCode.Add('');
    LCode.Add('{');
    LCode.Add('disable hints about unused units.  This unit just causes');
    LCode.Add('FreePascal to compile implicitly listed units in a package.');
    LCode.Add('}');
    LCode.Add('{$hints off}');
    LCode.Add('');
    LCode.Add('end.');
    WriteFile(LCode.Text, AOutPath + '\' + AFileName + '.pas');
  finally
    LCode.Free;
  end;
end;

procedure WriteLPK(const ACriteria: string; const AFileName : String; const AOutPath : String);
begin
  WriteFile(MakeLRS(ACriteria, AFileName), AOutPath + '\' + AFileName);
end;

procedure MakeFileDistList;
var
  LFiles, s : TStringList;
  i: Integer;
begin
  s := TStringList.Create;
  try
    LFiles := TStringList.Create;
    try
      DM.GetFileList('FPC=True, DesignUnit=False', LFiles);
      for i := 0 to LFiles.Count-1  do
      begin
        s.Add(DM.Ini.ReadString(LFiles[i], 'Pkg', '') + '\' + LFiles[i] + '.pas');
        if StrToBoolDef(DM.Ini.ReadString(LFiles[i], 'FPCHasLRSFile', ''), False) then
        begin
          s.Add(DM.Ini.ReadString(LFiles[i], 'Pkg', '') + '\' + LFiles[i] + '.lrs');
        end;
      end;
      s.SaveToFile(DM.OutputPath + '\Lib\RTFileList.txt');
      s.Clear;
      DM.GetFileList('FPC=True, DesignUnit=True', LFiles);
      for i := 0 to LFiles.Count-1 do
      begin
        s.Add(DM.Ini.ReadString(LFiles[i], 'Pkg', '') + '\' + LFiles[i] + '.pas');
        if StrToBoolDef(DM.Ini.ReadString(LFiles[i], 'FPCHasLRSFile', ''), False) then
        begin
          s.Add(DM.Ini.ReadString(LFiles[i], 'Pkg', '') + '\' + LFiles[i] + '.lrs');
        end;
      end;
      s.SaveToFile(DM.OutputPath + '\Lib\DTFileList.txt');
    finally
      LFiles.Free;
    end;
  finally
    s.Free;
  end;
end;

procedure Main;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  DM := TDM.Create(nil); try
    with DM do begin
      WriteLn('Path: '+ Ini.FileName );
      if FindCmdLineSwitch('checkini') then begin
        CheckForMissingFiles;
        Exit;
      end;

      MakeFPCPackage('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=System', 'indysystemfpc', OutputPath + '\Lib\System');
      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=System', 'indysystemlaz.lpk', OutputPath + '\Lib\System');

      MakeFPCPackage('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=Core', 'indycorefpc', OutputPath + '\Lib\Core');
      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=Core', 'indycorelaz.lpk', OutputPath + '\Lib\Core');
      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=True, Pkg=Core', 'dclindycorelaz.lpk', OutputPath + '\Lib\Core');

      MakeFPCPackage('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=Protocols', 'indyprotocolsfpc', OutputPath + '\Lib\Protocols');
      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=False, Pkg=Protocols', 'indyprotocolslaz.lpk', OutputPath + '\Lib\Protocols');
      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=True, Pkg=Protocols', 'dclindyprotocolslaz.lpk', OutputPath + '\Lib\Protocols');

      WriteLPK('FPC=True, FPCListInPkg=True, DesignUnit=True', 'indylaz.lpk', OutputPath + '\Lib');

      MakeFileDistList;
      MakeFPCMasterPackage('FPC=True, FPCListInPkg=True, DesignUnit=False', 'indymaster', OutputPath + '\Lib');
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
