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
{   Rev 1.0    1/24/2024 4:49:00 PM  RLebeau
{ BuildRes.bat generation.
}
unit PackageBuildRes;

interface

uses
  Package;

type
  TBuildRes = class(TPackage)
  private
    procedure RunBuildRes;
  public
    constructor Create; override;
    procedure Generate(ACompilers: TCompilers; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils, DModule, Windows;

{ TBuildRes }

constructor TBuildRes.Create;
begin
  inherited;
  FOutputSubDir := 'Lib';
end;

procedure TBuildRes.Generate(ACompilers: TCompilers; const AFlags: TGenerateFlags);
var
  LCompiler: TCompiler;
begin
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.
  //inherited;

  FName := 'buildres';
  FExt := '.bat';

  FCompiler := ctUnversioned;
  FCode.Clear;
  FDesignTime := False;

  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Code('brcc32 System\IndySystem'+GPackageVer[LCompiler]+'.rc');
    end;
  end;

  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Code('brcc32 Core\dclIndyCore'+GPackageVer[LCompiler]+'.rc');
    end;
  end;

  Code('brcc32 Core\IdAboutVCL.rc');

  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Code('brcc32 Core\IndyCore'+GPackageVer[LCompiler]+'.rc');
    end;
  end;

  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Code('brcc32 Protocols\dclIndyProtocols'+GPackageVer[LCompiler]+'.rc');
    end;
  end;

  for LCompiler := Low(TCompiler) to High(TCompiler) do begin
    if LCompiler in ACompilers then begin
      Code('brcc32 Protocols\IndyProtocols'+GPackageVer[LCompiler]+'.rc');
    end;
  end;

  WriteFile;

  // TODO: run buildres.bat only if any .rc files were actually (re-)generated...
  RunBuildRes;
end;

procedure TBuildRes.RunBuildRes;
var
  LPathname: string;
  LSubDir: string;
  LCmdLine: string;
  SI: TStartupInfo;
  PI: TProcessInformation;
  LExitCode: DWORD;
begin
  LPathname := SysUtils.IncludeTrailingPathDelimiter(DM.OutputPath);
  if FOutputSubDir <> '' then begin
    LSubDir := SysUtils.IncludeTrailingPathDelimiter(FOutputSubDir);
    LPathname := LPathname + LSubDir;
  end;
  WriteLn('Building resource files...');
  LCmdLine := 'cmd.exe /C ' + AnsiQuotedStr(LPathname + FName + FExt, '"');
  ZeroMemory(@SI, sizeof(SI));
  SI.cb := sizeof(SI);
  if CreateProcess(nil, PChar(LCmdLine), nil, nil, False, CREATE_NO_WINDOW, nil, PChar(LPathname), SI, PI) then
  begin
    CloseHandle(PI.hThread);
    WaitForSingleObject(PI.hProcess, INFINITE);
    GetExitCodeProcess(PI.hProcess, LExitCode);
    CloseHandle(PI.hProcess);
    if LExitCode <> 0 then
      WriteLn('Error from ' + LSubDir + FName + FExt);
  end else
  begin
    WriteLn('Unable to run ' + LSubDir + FName + FExt);
  end;
end;

end.

