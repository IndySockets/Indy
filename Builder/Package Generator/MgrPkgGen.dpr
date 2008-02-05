program MgrPkgGen;

uses
  Forms,
  MgrPkgGenDBMain in 'MgrPkgGenDBMain.pas' {frmPkgMain},
  DModule in 'DModule.pas' {DM: TDataModule},
  MgrPkgGenDBEntryEdit in 'MgrPkgGenDBEntryEdit.pas' {frmDBEntry},
  MgrPkgGenMgrDModDS in 'MgrPkgGenMgrDModDS.pas' {DMDS: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMDS, DMDS);
  Application.CreateForm(TfrmPkgMain, frmPkgMain);
  Application.Run;
end.
