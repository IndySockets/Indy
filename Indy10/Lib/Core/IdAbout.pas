unit IdAbout;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF DOTNET}
  IdAboutDotNET;
  {$ELSE}
  IdAboutVCL;
  {$ENDIF}

procedure ShowAboutBox(const AProductName, AProductVersion : String);
procedure ShowDlg;

implementation

{$IFDEF DOTNET}
  //for some reason, the Winforms designer doesn't like this in the same unit
  //as the class it's for
  {$R 'IdAboutDotNET.TfrmAbout.resources' 'IdAboutDotNET.resx'}
{$ENDIF}

procedure ShowAboutBox(const AProductName, AProductVersion : String);
begin
  TfrmAbout.ShowAboutBox(AProductName, AProductVersion);
end;

procedure ShowDlg;
begin
  TfrmAbout.ShowDlg;
end;

end.
