unit MgrPkgGenDBMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, ActnList, ImgList, Menus,
  StdActns, DBActns, XPMan;

type
  TfrmPkgMain = class(TForm)
    dbgrdMain: TDBGrid;
    mmuMain: TMainMenu;
    imglstMain: TImageList;
    actlstMain: TActionList;
    FileExit1: TFileExit;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Entries1: TMenuItem;
    N1: TMenuItem;
    actDBEdit: TAction;
    actEdtAdd: TAction;
    AddRecord1: TMenuItem;
    EditRecord1: TMenuItem;
    ppmnuGrid: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    XPManifest1: TXPManifest;
    DataSetFirst1: TDataSetFirst;
    DataSetPrior1: TDataSetPrior;
    DataSetNext1: TDataSetNext;
    First1: TMenuItem;
    DataSetLast1: TDataSetLast;
    Prior1: TMenuItem;
    Next1: TMenuItem;
    Last1: TMenuItem;
    DataSetDelete1: TDataSetDelete;
    Delete1: TMenuItem;
    EditRecord2: TMenuItem;
    Delete2: TMenuItem;
    procedure actEdtAddExecute(Sender: TObject);
    procedure actDBEditExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure OnBeforeRecordDelete(DataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  frmPkgMain: TfrmPkgMain;

implementation

uses DModule, MgrPkgGenMgrDModDS, MgrPkgGenDBEntryEdit;

{$R *.dfm}

procedure TfrmPkgMain.FormCreate(Sender: TObject);
begin
   DM.tablFile.BeforeDelete := OnBeforeRecordDelete;
  Self.Caption := Self.Caption + ' - [' + DM.tablFile.DatabaseName + ']';
  Application.Title := Self.Caption;
//   DM.tablFile.TableName := 'File.DB';
   DM.tablFile.Exclusive := True;
   DM.tablFile.Active := True;
end;

procedure TfrmPkgMain.actDBEditExecute(Sender: TObject);
var LFrm : TfrmDBEntry;
begin
  DM.tablFile.Edit;
  try
    LFrm := TfrmDBEntry.Create(Application);
    try
      if LFrm.ShowModal = mrOk then
      begin
        DM.tablFile.Post;
      end
      else
      begin
        DM.tablFile.Cancel;
      end;
    finally
      FreeAndNil(LFrm);
    end;
  except

    on E : Exception do
    begin
        DM.tablFile.Cancel;
      Application.MessageBox(PChar('Error "'+ E.Message +'"?'),
    PChar('Error'),MB_OK);
    end;
  end;
end;

procedure TfrmPkgMain.actEdtAddExecute(Sender: TObject);
var LFrm : TfrmDBEntry;
begin
  DM.tablFile.Insert;
  try
    LFrm := TfrmDBEntry.Create(Application);
    try
      if LFrm.ShowModal = mrOk then
      begin
        DM.tablFile.Post;
      end
      else
      begin
        DM.tablFile.Cancel;
      end;
    finally
      FreeAndNil(LFrm);
    end;
  except

    on E : Exception do
    begin
        DM.tablFile.Cancel;
      Application.MessageBox(PChar('Error "'+ E.Message +'"?'),
    PChar('Error'),MB_OK);
    end;
  end;
end;

procedure TfrmPkgMain.OnBeforeRecordDelete(DataSet: TDataSet);
begin
  if Application.MessageBox(PChar('Delete "'+DM.tablFileFileName.Text+'"?'),
    PChar('Warning'),MB_YESNO)=IDNO then
  begin
    Abort;
  end;
end;

end.
