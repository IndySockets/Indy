unit IdDsnSASLListEditorFormNET;

interface

uses
  Classes,
  System.Drawing, System.Collections, System.ComponentModel,
  System.Windows.Forms, System.Data, IdSASLCollection;

type
  TfrmSASLListEditor = class(System.Windows.Forms.Form)
  {$REGION 'Designer Managed Code'}
  strict private
    /// <summary>
    /// Required designer variable.
    /// </summary>
    Components: System.ComponentModel.Container;
    btnOk: System.Windows.Forms.Button;
    btnCancel: System.Windows.Forms.Button;
    lblAvailable: System.Windows.Forms.Label;
    lblAssigned: System.Windows.Forms.Label;
    lbAvailable: System.Windows.Forms.ListBox;
    lbAssigned: System.Windows.Forms.ListBox;
    btnRemove: System.Windows.Forms.Button;
    btnAdd: System.Windows.Forms.Button;
    btnUp: System.Windows.Forms.Button;
    btnDown: System.Windows.Forms.Button;
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    procedure InitializeComponent;
    procedure lbAvailable_SelectedIndexChanged(sender: System.Object; e: System.EventArgs);
    procedure btnAdd_Click(sender: System.Object; e: System.EventArgs);
    procedure btnRemove_Click(sender: System.Object; e: System.EventArgs);
    procedure btnUp_Click(sender: System.Object; e: System.EventArgs);
    procedure btnDown_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict protected
    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    procedure Dispose(Disposing: Boolean); override;
  private
    { Private Declarations }
    FSASLList: TIdSASLEntries;
    FAvailObjs : TList;
    procedure LoadBitmaps;
    procedure UpdateList;
    procedure UpdateGUI;
  public
    constructor Create;
    procedure SetList(const CopyFrom: TIdSASLEntries);
    procedure GetList(const CopyTo: TIdSASLEntries);
    procedure SetComponentName(const Name: string);
    function Execute : Boolean;
  end;

  [assembly: RuntimeRequiredAttribute(TypeOf(TfrmSASLListEditor))]

implementation

uses
  System.Reflection, System.Resources,
  IdDsnCoreResourceStrings,
  IdGlobal,
  IdResourceStrings,
  IdSASL,
  SysUtils;

{$R IdSASLListEditorForm.resources}
const
  ResourceBaseName = 'IdSASLListEditorForm';

{$AUTOBOX ON}

{$REGION 'Windows Form Designer generated code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TfrmSASLListEditor.InitializeComponent;
begin
  Self.btnOk := System.Windows.Forms.Button.Create;
  Self.btnCancel := System.Windows.Forms.Button.Create;
  Self.lblAvailable := System.Windows.Forms.Label.Create;
  Self.lblAssigned := System.Windows.Forms.Label.Create;
  Self.lbAvailable := System.Windows.Forms.ListBox.Create;
  Self.lbAssigned := System.Windows.Forms.ListBox.Create;
  Self.btnAdd := System.Windows.Forms.Button.Create;
  Self.btnRemove := System.Windows.Forms.Button.Create;
  Self.btnUp := System.Windows.Forms.Button.Create;
  Self.btnDown := System.Windows.Forms.Button.Create;
  Self.SuspendLayout;
  // 
  // btnOk
  // 
  Self.btnOk.Anchor := (System.Windows.Forms.AnchorStyles((System.Windows.Forms.AnchorStyles.Bottom 
    or System.Windows.Forms.AnchorStyles.Right)));
  Self.btnOk.DialogResult := System.Windows.Forms.DialogResult.OK;
  Self.btnOk.Location := System.Drawing.Point.Create(294, 323);
  Self.btnOk.Name := 'btnOk';
  Self.btnOk.TabIndex := 0;
  // 
  // btnCancel
  // 
  Self.btnCancel.DialogResult := System.Windows.Forms.DialogResult.Cancel;
  Self.btnCancel.Location := System.Drawing.Point.Create(374, 323);
  Self.btnCancel.Name := 'btnCancel';
  Self.btnCancel.TabIndex := 1;
  // 
  // lblAvailable
  // 
  Self.lblAvailable.AutoSize := True;
  Self.lblAvailable.Location := System.Drawing.Point.Create(8, 8);
  Self.lblAvailable.Name := 'lblAvailable';
  Self.lblAvailable.Size := System.Drawing.Size.Create(38, 16);
  Self.lblAvailable.TabIndex := 2;
  Self.lblAvailable.Text := 'Label1';
  // 
  // lblAssigned
  // 
  Self.lblAssigned.Anchor := (System.Windows.Forms.AnchorStyles((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Right)));
  Self.lblAssigned.Location := System.Drawing.Point.Create(248, 8);
  Self.lblAssigned.Name := 'lblAssigned';
  Self.lblAssigned.Size := System.Drawing.Size.Create(168, 16);
  Self.lblAssigned.TabIndex := 3;
  Self.lblAssigned.Text := 'Label2';
  // 
  // lbAvailable
  // 
  Self.lbAvailable.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Bottom) or System.Windows.Forms.AnchorStyles.Left)));
  Self.lbAvailable.Location := System.Drawing.Point.Create(8, 24);
  Self.lbAvailable.Name := 'lbAvailable';
  Self.lbAvailable.Size := System.Drawing.Size.Create(169, 277);
  Self.lbAvailable.TabIndex := 4;
  Include(Self.lbAvailable.SelectedIndexChanged, Self.lbAvailable_SelectedIndexChanged);
  // 
  // lbAssigned
  // 
  Self.lbAssigned.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Bottom) or System.Windows.Forms.AnchorStyles.Right)));
  Self.lbAssigned.Location := System.Drawing.Point.Create(248, 24);
  Self.lbAssigned.Name := 'lbAssigned';
  Self.lbAssigned.Size := System.Drawing.Size.Create(169, 277);
  Self.lbAssigned.TabIndex := 5;
  Include(Self.lbAssigned.SelectedIndexChanged, Self.lbAvailable_SelectedIndexChanged);
  // 
  // btnAdd
  // 
  Self.btnAdd.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Left) or System.Windows.Forms.AnchorStyles.Right)));
  Self.btnAdd.Location := System.Drawing.Point.Create(184, 88);
  Self.btnAdd.Name := 'btnAdd';
  Self.btnAdd.Size := System.Drawing.Size.Create(57, 23);
  Self.btnAdd.TabIndex := 6;
  Include(Self.btnAdd.Click, Self.btnAdd_Click);
  // 
  // btnRemove
  // 
  Self.btnRemove.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Left) or System.Windows.Forms.AnchorStyles.Right)));
  Self.btnRemove.Location := System.Drawing.Point.Create(184, 128);
  Self.btnRemove.Name := 'btnRemove';
  Self.btnRemove.Size := System.Drawing.Size.Create(57, 23);
  Self.btnRemove.TabIndex := 7;
  Include(Self.btnRemove.Click, Self.btnRemove_Click);
  // 
  // btnUp
  // 
  Self.btnUp.Anchor := (System.Windows.Forms.AnchorStyles((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Right)));
  Self.btnUp.Location := System.Drawing.Point.Create(424, 88);
  Self.btnUp.Name := 'btnUp';
  Self.btnUp.Size := System.Drawing.Size.Create(23, 23);
  Self.btnUp.TabIndex := 8;
  Include(Self.btnUp.Click, Self.btnUp_Click);
  // 
  // btnDown
  // 
  Self.btnDown.Anchor := (System.Windows.Forms.AnchorStyles((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Right)));
  Self.btnDown.Location := System.Drawing.Point.Create(424, 128);
  Self.btnDown.Name := 'btnDown';
  Self.btnDown.Size := System.Drawing.Size.Create(23, 23);
  Self.btnDown.TabIndex := 9;
  Include(Self.btnDown.Click, Self.btnDown_Click);
  // 
  // TfrmSASLListEditor
  // 
  Self.AcceptButton := Self.btnOk;
  Self.AutoScaleBaseSize := System.Drawing.Size.Create(5, 13);
  Self.CancelButton := Self.btnCancel;
  Self.ClientSize := System.Drawing.Size.Create(454, 354);
  Self.Controls.Add(Self.btnDown);
  Self.Controls.Add(Self.btnUp);
  Self.Controls.Add(Self.btnRemove);
  Self.Controls.Add(Self.btnAdd);
  Self.Controls.Add(Self.lbAssigned);
  Self.Controls.Add(Self.lbAvailable);
  Self.Controls.Add(Self.lblAssigned);
  Self.Controls.Add(Self.lblAvailable);
  Self.Controls.Add(Self.btnCancel);
  Self.Controls.Add(Self.btnOk);
  Self.FormBorderStyle := System.Windows.Forms.FormBorderStyle.FixedDialog;
  Self.MaximizeBox := False;
  Self.MaximumSize := System.Drawing.Size.Create(460, 386);
  Self.MinimizeBox := False;
  Self.MinimumSize := System.Drawing.Size.Create(460, 386);
  Self.Name := 'TfrmSASLListEditor';
  Self.StartPosition := System.Windows.Forms.FormStartPosition.CenterScreen;
  Self.Text := 'WinForm';
  Self.ResumeLayout(False);
end;
{$ENDREGION}

procedure TfrmSASLListEditor.Dispose(Disposing: Boolean);
begin
  if Disposing then
  begin
    if Components <> nil then begin
      Components.Dispose();
    end;
    FreeAndNil(FSASLList);
    FreeAndNil(FAvailObjs);
  end;
  inherited Dispose(Disposing);
end;

constructor TfrmSASLListEditor.Create;
begin
  inherited Create;
  //
  // Required for Windows Form Designer support
  //
  InitializeComponent;
  //
  // TODO: Add any constructor code after InitializeComponent call
  //
  //captions
  Text := RSADlgSLCaption;
  lblAvailable.Text :=  RSADlgSLAvailable;
  lblAssigned.Text := RSADlgSLAssigned;
  FSASLList := TIdSASLEntries.Create(Self);
  FAvailObjs := TList.Create;
  LoadBitmaps;
  btnCancel.Text := RSCancel;
  btnOk.Text := RSOk;
end;

function TfrmSASLListEditor.Execute: Boolean;
begin
  Result := Self.ShowDialog = System.Windows.Forms.DialogResult.OK;
end;

procedure TfrmSASLListEditor.btnDown_Click(sender: System.Object; e: System.EventArgs);
var
  sel: integer;
begin
  sel := lbAssigned.SelectedIndex;
  if (sel >= 0) and (sel < lbAssigned.Items.Count-1) then begin
    FSASLList.Items[sel].Index := sel+1;
    Updatelist;
    lbAssigned.SelectedIndex := sel+1;
  end;
end;

procedure TfrmSASLListEditor.btnUp_Click(sender: System.Object; e: System.EventArgs);
var
  sel : Integer;
begin
  sel := lbAssigned.SelectedIndex;
  // >0 is intentional, can't move the top element up!!
  if sel > 0 then begin
     FSASLList.Items[Sel].Index := sel-1;
     UpdateList;
     lbAssigned.SelectedIndex := sel-1;
  end;
end;

procedure TfrmSASLListEditor.btnRemove_Click(sender: System.Object; e: System.EventArgs);
var
  sel : Integer;
begin
  sel := lbAssigned.SelectedIndex;
  if sel >= 0 then
  begin
    FSASLList.Delete(sel);
  end;
  UpdateList;
end;

procedure TfrmSASLListEditor.btnAdd_Click(sender: System.Object; e: System.EventArgs);
var
  sel: integer;
  LCI : TIdSASLListEntry;
begin
  sel := lbAvailable.SelectedIndex ;
  if sel >= 0 then begin
    LCI := FSASLList.Add;
    LCI.SASL := TIdSASL(FAvailObjs[sel]);
 //   SASLList.Add(TIdSASL(lbAvailable.Items.Objects[sel]));
    UpdateList;
  end;
end;

procedure TfrmSASLListEditor.lbAvailable_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  UpdateGUI;
end;

procedure TfrmSASLListEditor.SetComponentName(const Name: string);
begin
  Text := IndyFormat(RSADlgSLCaption, [Name]);
end;

procedure TfrmSASLListEditor.GetList(const CopyTo: TIdSASLEntries);
begin
  CopyTo.Assign(FSASLList);
end;

procedure TfrmSASLListEditor.SetList(const CopyFrom: TIdSASLEntries);
var
  i, idx: integer;
begin
  FSASLList.Assign(CopyFrom);
  for i := 0 to CopyFrom.Count-1 do begin
    if Assigned(CopyFrom[i].SASL) then
    begin
      idx := lbAvailable.Items.IndexOf(CopyFrom[i].SASL.Name);
      if idx >= 0 then begin
        lbAvailable.Items.Remove(idx);
      end;
    end;
 //   SASLList.Add(CopyFrom[i]);
  end;
//  FListOwner := CopyFrom.Owner;
  UpdateList;
end;

procedure TfrmSASLListEditor.LoadBitmaps;
var
  LR: System.Resources.ResourceManager;
  LB : Bitmap;
begin
  LR := System.Resources.ResourceManager.Create(ResourceBaseName, System.Reflection.Assembly.GetExecutingAssembly);
  try
    LB := Bitmap(LR.GetObject( 'ARROWLEFT.bmp'));
    LB.MakeTransparent;
    Self.btnRemove.Image := LB;
    LB := Bitmap(LR.GetObject( 'ARROWRIGHT.bmp'));
    LB.MakeTransparent;
    Self.btnAdd.Image := LB;
    LB := Bitmap(LR.GetObject(  'ARROWUP.bmp'));
    LB.MakeTransparent;
    Self.btnUp.Image := LB;
    LB := Bitmap(LR.GetObject(  'ARROWDOWN.bmp'));
    LB.MakeTransparent;
    Self.btnDown.Image := LB;
  finally
    FreeAndNil(LR);
  end;
end;

procedure TfrmSASLListEditor.UpdateList;
var
  i: integer;
  l : TList;
begin
  lbAssigned.Items.Clear;
  FAvailObjs.Clear;
  for i := 0 to FSASLList.Count-1 do begin
    if Assigned(FSASLList[i].SASL) then begin
      lbAssigned.Items.Add(FSASLList[i].SASL.Name + ': ' + FSASLList[i].SASL.ServiceName);
    end;
  end;
  lbAvailable.Items.Clear;
  l := GlobalSASLList.LockList;
  try
    for i := 0 to l.Count-1 do begin
      if FSASLList.IndexOfComp(TIdSASL(l[i])) < 0 then begin
        if Assigned(l[i]) then
        begin
          FAvailObjs.Add(l[i]);
          lbAvailable.Items.Add(TIdSASL(l[i]).Name + ': ' + TIdSASL(l[i]).ServiceName);
        end;
      end;
    end;
  finally
    GlobalSASLList.UnlockList;
  end;
  UpdateGUI;
end;

procedure TfrmSASLListEditor.UpdateGUI;
//This is necessary because unlike VCL, WinForms does not
//have a native ActionList.
begin
  btnAdd.Enabled := (lbAvailable.Items.Count <> 0) and
    (lbAvailable.SelectedIndex <> -1);
  btnRemove.Enabled := (lbAssigned.Items.Count <> 0) and
    (lbAssigned.SelectedIndex <> -1);
  btnUp.Enabled := (lbAssigned.Items.Count > 1) and
    (lbAssigned.SelectedIndex > 0); // -1 not selected and 0 = top
  btnDown.Enabled :=  (lbAssigned.Items.Count > 1) and
    (lbAssigned.SelectedIndex <> -1) and (lbAssigned.SelectedIndex < (lbAssigned.Items.Count - 1));
end;

end.
