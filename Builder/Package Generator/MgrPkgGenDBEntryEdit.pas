unit MgrPkgGenDBEntryEdit;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, DB, Mask, DBCtrls;

type
  TfrmDBEntry = class(TForm)
    pnlMain: TPanel;
    pnlButtons: TPanel;
    pgControlMain: TPageControl;
    tbshtMain: TTabSheet;
    tbshtUnitDetails: TTabSheet;
    tbshtRelease: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    lblUnitName: TLabel;
    dbedtFileName: TDBEdit;
    grpDevIDE: TGroupBox;
    dbchkDotNET: TDBCheckBox;
    dbchkDelphiDotNET: TDBCheckBox;
    dbchkVCL: TDBCheckBox;
    dbchkKylix: TDBCheckBox;
    lblPackage: TLabel;
    dbchkDesignTimeOnly: TDBCheckBox;
    dbchkFPCLazarus: TDBCheckBox;
    dbcboPackage: TDBComboBox;
    dbedtFTPListParser: TDBCheckBox;
    dbchkIFDEFPermitted: TDBCheckBox;
    dbchkHasRegisterProc: TDBCheckBox;
    dbchkHasAssociatedLazRes: TDBCheckBox;
    dbchkBubbleExists: TDBCheckBox;
    lblShortDescription: TLabel;
    dbedtShortDescription: TDBEdit;
    lblOwner: TLabel;
    dbedtOwners: TDBEdit;
    dbchkRelease: TDBCheckBox;
    dbchkReleaseNativeOS: TDBCheckBox;
    dbReleaseDotNET: TDBCheckBox;
    lblRelComment: TLabel;
    dbedtComment: TDBEdit;
    dbchkListInLazPackage: TDBCheckBox;
    lbldbProtocols: TLabel;
    dbedtProtocols: TDBEdit;
    dbcboNet20Framework: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure dbchkDesignTimeOnlyClick(Sender: TObject);
    procedure dbchkListInLazPackageClick(Sender: TObject);
    procedure dbchkFPCLazarusClick(Sender: TObject);
    procedure dbedtFileNameChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure UpdateGUI;
  public
  end;

var
  frmDBEntry: TfrmDBEntry;

implementation

uses DModule, MgrPkgGenMgrDModDS;

{$R *.dfm}

{ TfrmDBEntry }

procedure TfrmDBEntry.dbedtFileNameChange(Sender: TObject);
//This is so I know what unit I am entering information for,
//no matter where I am in the dialog-box
begin
  Caption := 'PkgGen Manager Data Entry';
  if dbedtFileName.Text <> '' then
  begin
    Caption := Caption + ' - '+ dbedtFileName.Text;
  end;
end;

procedure TfrmDBEntry.UpdateGUI;
//disable controls and update DB record for mutually exclusive options

{We only want associated .LRS files for design-time only units
so the RTL does NOT depend on the LCL in Lazarus.  We want our run-time
only units to run with FreePascal (including cross-compilation.}

begin
  if dbchkFPCLazarus.Checked then
  begin
     dbchkListInLazPackage.Enabled := True;
{    if dbchkListInLazPackage.Checked then
    begin
      dbchkHasAssociatedLazRes.Enabled := True;
    end
    else
    begin

      DM.tablFileFPCHasLRSFile.Value := False;
      dbchkHasAssociatedLazRes.Enabled := False;

    end;  }
  end
  else
  begin

    DM.tablFileFPCListInPkg.Value := False;
    dbchkListInLazPackage.Enabled := False;
  end;
  if dbchkDesignTimeOnly.Checked then
  begin
     if dbchkListInLazPackage.Checked then
     begin
        dbchkHasAssociatedLazRes.Enabled := True;
         dbchkHasRegisterProc.Enabled := True;
     end
     else
     begin

       DM.tablFileFPCHasLRSFile.Value := False;
       dbchkHasAssociatedLazRes.Enabled := False;
       DM.tablFileFPCHasRegProc.Value := False;
       dbchkHasRegisterProc.Enabled := False;
     end;
  end
  else
  begin

      DM.tablFileFPCHasLRSFile.Value := False;
      dbchkHasAssociatedLazRes.Enabled := False;

      DM.tablFileFPCHasRegProc.Value := False;
      dbchkHasRegisterProc.Enabled := False;
  end;
end;

procedure TfrmDBEntry.dbchkFPCLazarusClick(Sender: TObject);
begin
  UpdateGUI;
end;

procedure TfrmDBEntry.dbchkListInLazPackageClick(Sender: TObject);
begin
  UpdateGUI;
end;

procedure TfrmDBEntry.dbchkDesignTimeOnlyClick(Sender: TObject);
begin
  UpdateGUI;
end;

procedure TfrmDBEntry.FormCreate(Sender: TObject);

begin
  UpdateGUI;
end;

end.

