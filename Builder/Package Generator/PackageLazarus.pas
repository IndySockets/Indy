{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
{   Rev 1.0    4/17/2024 5:22:00 PM  RLebeau
{ indylaz.lpk generation.
}
unit PackageLazarus;

interface

uses
  Package;

type
  TPackageLazarus = class(TPackage)
  private
    procedure GenLaz;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils, DModule;

{ TBuildRes }

constructor TPackageLazarus.Create;
begin
  inherited;
  FName := 'indylaz';
  FOutputSubDir := 'Lib';
end;

procedure TPackageLazarus.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
begin
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.
  //inherited;

  FCompiler := ACompiler;
  FDesignTime := False;

  FTemplate := True;
  FExt := '.lpk.tmpl';
  GenLaz;
  WriteFile;

  FTemplate := False;
  FExt := '.lpk';
  GenLaz;
  WriteFile;
end;

procedure TPackageLazarus.GenLaz;
var
  BuildStr: String;
begin
  FCode.Clear;

  if FTemplate then
    BuildStr := '$WCREV$'
  else
    BuildStr := IndyVersion_Build_Str;

  Code('<?xml version="1.0" encoding="UTF-8"?>');
  Code('<CONFIG>');
  Code('  <Package Version="5">');
  Code('    <PathDelim Value="\"/>');
  Code('    <Name Value="indylaz"/>');
  Code('    <Type Value="RunAndDesignTime"/>');
  Code('    <AddToProjectUsesSection Value="True"/>');
  Code('    <Author Value="Chad Z. Hower (Kudzu) and the Indy Pit Crew - http://www.indyproject.org/"/>');
  Code('    <CompilerOptions>');
  Code('      <Version Value="11"/>');
  Code('      <PathDelim Value="\"/>');
  Code('      <SearchPaths>');
  Code('        <IncludeFiles Value=".;Core;Protocols;System"/>');
  Code('        <OtherUnitFiles Value=".;Core;Protocols;System"/>');
  Code('        <UnitOutputDirectory Value="lib\$(TargetCPU)-$(TargetOS)"/>');
  Code('      </SearchPaths>');
  Code('      <Parsing>');
  Code('        <SyntaxOptions>');
  Code('          <SyntaxMode Value="Delphi"/>');
  Code('          <UseAnsiStrings Value="False"/>');
  Code('        </SyntaxOptions>');
  Code('      </Parsing>');
  Code('      <Other>');
  Code('        <CustomOptions Value="$(IDEBuildOptions)');
  Code('-dDEBUG"/>');
  Code('      </Other>');
  Code('    </CompilerOptions>');
  Code('    <Description Value="Components for networking, Web services, protocols (SMTP, POP3, IMAP, NNTP, HTTP, FTP), sockets."/>');
  Code('    <License Value="Duel License');
  Code('');
  Code('MPL ');
  Code('');
  Code('Indy Modified BSD License');
  Code('Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:');
  Code('Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. ');
  Code('');
  Code('Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation, about box and/or other materials provided with the distribution. ');
  Code('');
  Code('No personal names or organizations names associated with the Indy project may be used to endorse or promote products derived from this software without specific prior written permission of the specific individual or organization. ');
  Code('');
  Code('THIS SOFTWARE IS PROVIDED BY Chad Z. Hower (Kudzu) and the Indy Pit Crew &amp;quot;AS IS&apos;&apos; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.');
  Code('"/>');
  Code('    <Version Major="' + IndyVersion_Major_Str + '" Minor="' + IndyVersion_Minor_Str + '" Release="' + IndyVersion_Release_Str + '" Build="' + BuildStr + '"/>');

{ TODO: update the DB And then uncomment this...

  var TotalCount := FUnits.Count;
  for I := 0 to FUnits.Count-1 do
  begin
    if DB.Ini.ReadBool(FUnits[I], 'FPCHasLRSFile', False) then begin
      Inc(TotalCount);
    end;
  end;

  Code('    <Files Count="' + IntToStr(TotalCount) + '">');

  var ItemNum := 1;
  for I := 0 to FUnits.Count-1 do
  begin
    var LDir := IncludeTrailingPathDelimiter(FDirs[i]);
    Code('      <Item' + IntToStr(ItemNum) + '>');
    Code('        <Filename Value="' + LDir + FUnits[I] + '.pas"/>');
    if LFiles[I].FPCHasRegProc then begin
      Code('        <HasRegisterProc Value="True"/>');
    end;
    Code('        <UnitName Value="' + FUnits[I] + '"/>');
    Code('      </Item' + IntToStr(ItemNum) + '>');
    Inc(ItemNum);
    if DB.Ini.ReadBool(FUnits[I], 'FPCHasLRSFile', False) then begin
      Code('      <Item' + IntToStr(ItemNum) + '>');
      Code('        <Filename Value="' + LDir + FUnits[I] + '.lrs"/>');
      Code('        <Type Value="LRS"/>');
      Code('      </Item' + IntToStr(ItemNum) + '>');
      Inc(ItemNum);
    end;
  end;

  Code('    </Files>');
}
  Code('    <Files Count="16">');
  Code('      <Item1>');
  Code('        <Filename Value="Core\IdAboutVCL.pas"/>');
  Code('        <UnitName Value="IdAboutVCL"/>');
  Code('      </Item1>');
  Code('      <Item2>');
  Code('        <Filename Value="Core\IdAboutVCL.lrs"/>');
  Code('        <Type Value="LRS"/>');
  Code('      </Item2>');
  Code('      <Item3>');
  Code('        <Filename Value="Core\IdAntiFreeze.pas"/>');
  Code('        <UnitName Value="IdAntiFreeze"/>');
  Code('      </Item3>');
  Code('      <Item4>');
  Code('        <Filename Value="Core\IdCoreDsnRegister.pas"/>');
  Code('        <HasRegisterProc Value="True"/>');
  Code('        <UnitName Value="IdCoreDsnRegister"/>');
  Code('      </Item4>');
  Code('      <Item5>');
  Code('        <Filename Value="Core\IdDsnCoreResourceStrings.pas"/>');
  Code('        <UnitName Value="IdDsnCoreResourceStrings"/>');
  Code('      </Item5>');
  Code('      <Item6>');
  Code('        <Filename Value="Core\IdDsnPropEdBindingVCL.pas"/>');
  Code('        <UnitName Value="IdDsnPropEdBindingVCL"/>');
  Code('      </Item6>');
  Code('      <Item7>');
  Code('        <Filename Value="Protocols\IdDsnRegister.pas"/>');
  Code('        <HasRegisterProc Value="True"/>');
  Code('        <UnitName Value="IdDsnRegister"/>');
  Code('      </Item7>');
  Code('      <Item8>');
  Code('        <Filename Value="Protocols\IdDsnResourceStrings.pas"/>');
  Code('        <UnitName Value="IdDsnResourceStrings"/>');
  Code('      </Item8>');
  Code('      <Item9>');
  Code('        <Filename Value="Protocols\IdDsnSASLListEditorFormVCL.pas"/>');
  Code('        <UnitName Value="IdDsnSASLListEditorFormVCL"/>');
  Code('      </Item9>');
  Code('      <Item10>');
  Code('        <Filename Value="Protocols\IdDsnSASLListEditorFormVCL.lrs"/>');
  Code('        <Type Value="LRS"/>');
  Code('      </Item10>');
  Code('      <Item11>');
  Code('        <Filename Value="Protocols\IdRegister.pas"/>');
  Code('        <HasRegisterProc Value="True"/>');
  Code('        <UnitName Value="IdRegister"/>');
  Code('      </Item11>');
  Code('      <Item12>');
  Code('        <Filename Value="Protocols\IdRegister.lrs"/>');
  Code('        <Type Value="LRS"/>');
  Code('      </Item12>');
  Code('      <Item13>');
  Code('        <Filename Value="Core\IdRegisterCore.pas"/>');
  Code('        <HasRegisterProc Value="True"/>');
  Code('        <UnitName Value="IdRegisterCore"/>');
  Code('      </Item13>');
  Code('      <Item14>');
  Code('        <Filename Value="Core\IdRegisterCore.lrs"/>');
  Code('        <Type Value="LRS"/>');
  Code('      </Item14>');
  Code('      <Item15>');
  Code('        <Filename Value="System\IdStreamVCL.pas"/>');
  Code('        <UnitName Value="IdStreamVCL"/>');
  Code('      </Item15>');
  Code('      <Item16>');
  Code('        <Filename Value="System\IdStream.pas"/>');
  Code('        <UnitName Value="IdStream"/>');
  Code('      </Item16>');
  Code('    </Files>');

  Code('    <CompatibilityMode Value="True"/>');
  Code('    <RequiredPkgs Count="3">');
  Code('      <Item1>');
  Code('        <PackageName Value="LCL"/>');
  Code('      </Item1>');
  Code('      <Item2>');
  Code('        <PackageName Value="IDEIntf"/>');
  Code('      </Item2>');
  Code('      <Item3>');
  Code('        <PackageName Value="FCL"/>');
  Code('        <MinVersion Major="1" Valid="True"/>');
  Code('      </Item3>');
  Code('    </RequiredPkgs>');
  Code('    <UsageOptions>');
  Code('      <UnitPath Value="$(PkgOutDir)"/>');
  Code('    </UsageOptions>');
  Code('    <PublishOptions>');
  Code('      <Version Value="2"/>');
  Code('    </PublishOptions>');
  Code('  </Package>');
  Code('</CONFIG>');
end;

end.
