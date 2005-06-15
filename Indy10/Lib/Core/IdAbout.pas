unit IdAbout;

interface
{$I IdCompilerDefines.inc}
uses
  {$IFDEF DOTNET}
  IdAboutDotNET;
  {$ELSE}
  IdAboutVCL;
  {$ENDIF}

Procedure ShowAboutBox(const AProductName, AProductVersion : String);
Procedure ShowDlg;

implementation
 {$IFDEF DOTNET}
 //for some reason, the Winforms designer doesn't like this in the same unit
 //as the class it's for
 {$R 'IdAboutDotNET.TfrmAbout.resources' 'IdAboutDotNET.resx'}
 {$ENDIF}

Procedure ShowAboutBox(const AProductName, AProductVersion : String);
begin
  TfrmAbout.ShowAboutBox(AProductName, AProductVersion);
end;

Procedure ShowDlg;
begin
  TfrmAbout.ShowDlg;
end;

end.
