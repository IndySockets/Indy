program LazPkgGen;

{$APPTYPE CONSOLE}

uses
  ExceptionLog,
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
procedure WriteEntry(var VEntryCount : Integer; var VOutput : String);
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

function MakePackage(const AWhere: string; const APackageName : String; const AFileName : String) : String;
var i : Integer;
  s : String;
  LS : TStrings;
begin
  LS := TStringList.Create;
  try
    LS.LoadFromFile('W:\Source\Indy10\Builder\Package Generator\LazTemplates\'+AFileName);
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

    if DM.tablFilePkg.Value = APackageName then
    begin
      WriteEntry(i,s);
    end;
    DM.tablFile.Next;
  end;
  DM.tablFile.Filtered := False;
  s := '    <Files Count="'+IntToStr(i)+'">'+ EOL +
    s +'    </Files>';
  Result := StringReplace(Result,'{%FILES}',s,[rfReplaceAll]);
end;

procedure WriteFile(const AWhere: string; const AFileName : String; const APkgName : String; const AOutPath : String);
var
  LCodeOld: string;
  LNewCode : String;
  LPathname: string;
begin
  LPathname := AOutPath + '\' + AFileName;
  LCodeOld := '';
  if FileExists(LPathname) then begin
    with TStringList.Create do try
      LoadFromFile(LPathname);
      LCodeOld := Text;
    finally Free; end;
  end;
  LNewCode := MakePackage(AWhere,APkgName,AFileName);
  // Only write out the code if its different. This prevents unnecessary checkins as well
  // as not requiring user to lock all packages
  if (LCodeOld = '') or (LCodeOld <> LNewCode) then begin
    with TStringList.Create do try
      Text := LNewCode;
      SaveToFile(LPathName);
    finally Free; end;
  end;
    WriteLn('Generated ' + AFileName);
end;

procedure MakeFileDistList;
var s : TStringList;
  Lst : String;
begin
  DM.tablFile.Filter := 'FPC=True';
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
      WriteLn(LSt);
      DM.tablFile.Next;
    end;
    s.SaveToFile('W:\Source\Indy\Indy10FPC\Lib\FileList.txt');

  finally
    FreeAndNil(s);
  end;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  DM := TDM.Create(nil); try
    with DM do begin
      // Default Output Path is w:\source\Indy10
      DM.OutputPath := 'w:\source\Indy10';
      // Default Data Path is W:\source\Indy10\builder\Package Generator\Data
      DM.DataPath   := 'W:\source\Indy10\builder\Package Generator\Data';
      tablFile.Open;
      WriteFile('FPC=True and FPCListInPkg=True and DesignUnit=False','indysystemlaz.lpk','System','w:\source\Indy\Indy10FPC\Lib\System');
      WriteFile('FPC=True and FPCListInPkg=True and DesignUnit=False','indycorelaz.lpk','Core','w:\source\Indy\Indy10FPC\Lib\Core');
      WriteFile('FPC=True and FPCListInPkg=True and DesignUnit=true','dclindycorelaz.lpk', 'Core',          'w:\source\Indy\Indy10FPC\Lib\Core');
      WriteFile('FPC=True and FPCListInPkg=True and DesignUnit=False','indyprotocolslaz.lpk',  'Protocols', 'W:\Source\Indy\Indy10FPC\Lib\Protocols');
      WriteFile('FPC=True and FPCListInPkg=True and DesignUnit=true','dclindyprotocolslaz.lpk','Protocols', 'W:\Source\Indy\Indy10FPC\Lib\Protocols');
      MakeFileDistList;
    end;
  finally FreeAndNil(DM); end;
  ReadLn;
end.
