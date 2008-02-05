program IndyDUnit;

uses
  GUITestRunner,
  IdRegisterTests;

{$R *.res}

begin

  TGUITestRunner.RunRegisteredTests;

end.
