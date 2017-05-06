unit IdAbout deprecated 'use IdAboutVCL unit';

interface

{$I IdCompilerDefines.inc}

uses
  IdAboutVCL;

//we have a procedure for providing a product name and version in case
//we ever want to make another product.
procedure ShowAboutBox(const AProductName, AProductName2, AProductVersion : String);
procedure ShowDlg;

implementation

procedure ShowAboutBox(const AProductName, AProductName2, AProductVersion : String);
begin
  TfrmAbout.ShowAboutBox(AProductName, AProductName2, AProductVersion);
end;

procedure ShowDlg;
begin
  TfrmAbout.ShowDlg;
end;

end.
