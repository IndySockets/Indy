program LazPkgGen;

{$APPTYPE CONSOLE}

uses
  ShellAPI,
  Windows,
  Classes,
  SysUtils,
  IdGlobal,
  DBTables,
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

//i is a var that this procedure will cmanage for the main loop.
procedure WriteLRSEntry(var VEntryCount : Integer; var VOutput : String);
var s : String;
begin
  Inc(VEntryCount);
  s := '      <Item'+IntToStr(VEntryCount)+'>'+EOL;
  s := s +'        <Filename Value="' +DM.tablFileFileName.Value + '.pas"/>'+EOL;
  if DM.tablFileFPCHasRegProc.Value then
  begin
    s := s +'        <HasRegisterProc Value="True"/>'+EOL;
  end;
  s := s +'        <UnitName Value="'+ DM.tablFileFileName.Value + '"/>'+EOL;
  s := s +'      </Item'+IntToStr(VEntryCount)+'>'+EOL;
  if DM.tablFileFPCHasLRSFile.Value then
  begin
    Inc(VEntryCount);
    s := s +'      <Item'+IntToStr(VEntryCount)+'>'+EOL;
    s := s +'        <Filename Value="'+DM.tablFileFileName.Value +'.lrs"/>'+EOL;
    s := s +'        <Type Value="LRS"/>'+EOL;
    s := s +'      </Item'+IntToStr(VEntryCount)+'>'+EOL;
  end;
  VOUtput := VOUtput + s;
end;

function MakeLRS(const AWhere: string; const APackageName : String; const AFileName : String) : String;
var i : Integer;
  s : String;
  LS : TStrings;
begin
  LS := TStringList.Create;
  try
    LS.LoadFromFile(DM.OutputPath+ '\Builder\Package Generator\LazTemplates\'+AFileName);
    Result := LS.Text;
  finally
    FreeAndNil(LS);
  end;
  i := 0;
  s := '';
  DM.tablFile.Filter := AWhere;
  DM.tablFile.Filtered := True;
  DM.tablFile.First;
  while not DM.tablFile.EOF do begin
    if APackageName<>'' then
    begin
      if DM.tablFilePkg.Value = APackageName then
      begin
        WriteLRSEntry(i,s);
      end;
    end
    else
    begin
        WriteLRSEntry(i,s);
    end;
    DM.tablFile.Next;
  end;
  DM.tablFile.Filtered := False;
  s := '    <Files Count="'+IntToStr(i)+'">'+ EOL +
    s +'    </Files>';
  Result := StringReplace(Result,'{%FILES}',s,[rfReplaceAll]);
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
  end;
end;

function GetTempDirectory: String;

var  TempDir: TIdBytes;
   LLen : Cardinal;
begin
  SetLength(TempDir,MAX_PATH);
 // FillChar(TempDir[0],#0,MAX_PATH);
  repeat
    LLen := GetTempPath(MAX_PATH, @TempDir[0]);
    if (LLen=0) then
    begin
      Result := '';
      exit;
    end;
    if LLen > MAX_PATH then
    begin
       //increase array size, too small
       SetLength(TempDir,LLen);
    end
    else
    begin
      Break;
    end;
  until False;
  Result := IdGlobal.BytesToString(TempDir,0,LLen)
//  Result :=  PChar(@TempDir[0]);
end;

procedure MakeFPCMasterPackage(const AWhere: string; const AFileName : String;
   const AOutPath : String);
var s, LS : TStringList;
  Lst : String;
  i : Integer;
  LTemp : String;
begin
  DM.tablFile.Filter := AWhere;
  DM.tablFile.Filtered := True;
  DM.tablFile.First;
  s := TStringList.Create;
  try
    while not DM.tablFile.Eof do
    begin
      s.Add(DM.tablFileFileName.Value );
      DM.tablFile.Next;
    end;
    //construct our make file
    LS := TStringList.Create;
    try
      LS.LoadFromFile(DM.OutputPath+ '\Builder\Package Generator\LazTemplates\'+AFileName+'-Makefile.fpc');
      LTemp := LS.Text;
    finally
      FreeAndNil(LS);
    end;
    Lst := '';
     for i := 0 to s.Count -1 do
     begin
       if (i = s.Count -1) then
       begin
           LSt := Lst +'  '+s[i]+EOL;
       end
       else
       begin
          LSt := Lst + '  '+s[i]+' \'+EOL;
       end;
     end;

     Lst := 'implicitunits='+TrimLeft(Lst);
     LTemp := StringReplace(LTemp,'{%FILES}',LSt,[rfReplaceAll]);
     WriteFile(LTemp,AOutPath+'\'+AFileName+'-Makefile.fpc');
  finally
    FreeAndNil(s);
  end;
  DM.tablFile.Filtered := False;
end;

procedure MakeFPCPackage(const AWhere: string; const AFileName : String;
  const APkgName : String; const AOutPath : String);
var s, LS : TStringList;
  Lst : String;
  i : Integer;
  LTemp : String;

begin
  DM.tablFile.Filter := AWhere;
  DM.tablFile.Filtered := True;
  DM.tablFile.First;
  s := TStringList.Create;
  try
    while not DM.tablFile.Eof do
    begin
      if DM.tablFilePkg.Value = APkgName then
      begin
        s.Add(DM.tablFileFileName.Value );
      end;
      DM.tablFile.Next;
    end;
    //construct our make file
    LS := TStringList.Create;
    try
      LS.LoadFromFile(GIndyPath+ 'Builder\Package Generator\LazTemplates\'+AFileName+'-Makefile.fpc');
      LTemp := LS.Text;
    finally
      FreeAndNil(LS);
    end;

    //now make our package file.  This is basically a dummy unit that lists

     Lst := '';
     for i := 0 to s.Count -1 do
     begin
       if (i = s.Count -1) then
       begin
           LSt := Lst +'  '+s[i]+EOL;
       end
       else
       begin
          LSt := Lst + '  '+s[i]+' \'+EOL;
       end;
     end;

     Lst := 'implicitunits='+TrimLeft(Lst);
     LTemp := StringReplace(LTemp,'{%FILES}',LSt,[rfReplaceAll]);
     WriteFile(LTemp,AOutPath+ '\Makefile.fpc');

    //all of the files.
     for i := 0 to s.Count -1 do
     begin
       if (i = s.Count -1)  then
       begin
         s[i] := '  '+s[i]+';';
       end
       else
       begin
          s[i] := '  '+s[i]+',';
       end;
     end;

     s.Insert(0,'uses');
     s.Insert(0,'');
     s.Insert(0,'interface');
     s.Insert(0,'unit '+AFileName+';');
     //
     s.Add('');
     s.Add('implementation');
     s.Add('');
     s.Add('end.');
     WriteFile(s.text,AOutPath+ '\' + AFileName+'.pas');
  finally
    FreeAndNil(s);
  end;
  DM.tablFile.Filtered := False;
end;

procedure Writelpk(const AWhere: string; const AFileName : String; const APkgName : String; const AOutPath : String);
var
  LCodeOld: string;
  LNewCode : String;
  LPathname: string;
begin
  LPathname := AOutPath + '\' + AFileName;

  LNewCode := MakeLRS(AWhere,APkgName,AFileName);
  WriteFile(LNewCode,LPathName);
end;


procedure MakeFileDistList;
var s : TStringList;
  Lst : String;
begin
  DM.tablFile.Filter := 'FPC=True and DesignUnit=False';
  DM.tablFile.Filtered := True;
  DM.tablFile.First;
  s := TStringList.Create;
  try
    while not DM.tablFile.Eof do
    begin
      LSt := DM.tablFile.FieldByName('Pkg').AsString+'\' + DM.tablFile.FieldByName('FileName').AsString+'.pas';
      s.Add(LSt);
      if DM.tablFile.FieldByName('FPCHasLRSFile').AsBoolean then
      begin
        LSt := DM.tablFile.FieldByName('Pkg').AsString+'\' + DM.tablFile.FieldByName('FileName').AsString+'.lrs';
        s.Add(LSt);
      end;
      DM.tablFile.Next;
    end;
    s.SaveToFile(DM.OutputPath+ '\lib\RTFileList.txt');

  finally
    FreeAndNil(s);
  end;
  DM.tablFile.Filtered := False;
  DM.tablFile.Filter := 'FPC=True and DesignUnit=True';
  DM.tablFile.Filtered := True;
  DM.tablFile.First;
  s := TStringList.Create;
  try
    while not DM.tablFile.Eof do
    begin
      LSt := DM.tablFile.FieldByName('Pkg').AsString+'\' + DM.tablFile.FieldByName('FileName').AsString+'.pas';
      s.Add(LSt);
      if DM.tablFile.FieldByName('FPCHasLRSFile').AsBoolean then
      begin
        LSt := DM.tablFile.FieldByName('Pkg').AsString+'\' + DM.tablFile.FieldByName('FileName').AsString+'.lrs';
        s.Add(LSt);
      end;
      DM.tablFile.Next;
    end;
    s.SaveToFile(DM.OutputPath+ '\lib\DTFileList.txt');
  finally
    FreeAndNil(s);
  end;
end;

begin

  { TODO -oUser -cConsole Main : Insert code here }
  DM := TDM.Create(nil); try
    with DM do begin
   //our path settings in the module are created in its constructor now.
   //we use the defaults it provides so we can use this in various pathes
   //in subversion.
      tablFile.Open;
      MakeFPCPackage('FPC=True and FPCListInPkg=True and DesignUnit=False', 'indysystemfpc','System',DM.OutputPath+ '\Lib\System');
   //   WriteLPK('FPC=True and FPCListInPkg=True and DesignUnit=False','indysystemlaz.lpk','System',GIndyPath+ 'Lib\System');
      MakeFPCPackage('FPC=True and FPCListInPkg=True and DesignUnit=False','indycorefpc','Core',DM.OutputPath+ '\Lib\Core');
//    WriteLPK      ('FPC=True and FPCListInPkg=True and DesignUnit=False','indycorefpc','Core',GIndyPath+ 'Lib\Core');
      WriteLPK('FPC=True and FPCListInPkg=True and DesignUnit=true','dclindycorelaz.lpk', 'Core',DM.OutputPath+ '\Lib\Core');
      MakeFPCPackage('FPC=True and FPCListInPkg=True and DesignUnit=False','indyprotocolsfpc',  'Protocols', DM.OutputPath+ '\Lib\Protocols');
      WriteLPK('FPC=True and FPCListInPkg=True and DesignUnit=true','dclindyprotocolslaz.lpk','Protocols', DM.OutputPath+ '\Lib\Protocols');
      WriteLPK('FPC=True and FPCListInPkg=True and DesignUnit=true','indylaz.lpk','', DM.OutputPath+ '\Lib');
      MakeFileDistList;
      MakeFPCMasterPackage('FPC=True and FPCListInPkg=True and DesignUnit=False','indymaster',DM.OutputPath+  '\Lib');
    end;
  finally
    FreeAndNil(DM);
  end;
end.
