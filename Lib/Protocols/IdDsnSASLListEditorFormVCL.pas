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
  Rev 1.7    9/8/2004 10:10:40 PM  JPMugaas
  Now should work properly in DotNET versions of Delphi.

  Rev 1.6    9/5/2004 3:16:58 PM  JPMugaas
  Should work in D9 DotNET.

  Rev 1.5    2/26/2004 8:53:22 AM  JPMugaas
  Hack to restore the property editor for SASL mechanisms.

  Rev 1.4    1/25/2004 3:11:10 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.3    10/19/2003 6:05:38 PM  DSiders
  Added localization comments.

  Rev 1.2    10/12/2003 1:49:30 PM  BGooijen
  Changed comment of last checkin

  Rev 1.1    10/12/2003 1:43:30 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/14/2002 02:19:14 PM  JPMugaas

  2002-08 Johannes Berg
  Form for the SASL List Editor. It doesn't use a DFM/XFM to be
  more portable between Delphi/Kylix versions, and to make less
  trouble maintaining it.
}

unit IdDsnSASLListEditorFormVCL;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF WIDGET_KYLIX}
  QControls, QForms, QStdCtrls, QButtons, QExtCtrls, QActnList, QGraphics,
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE}
  Controls, Forms, StdCtrls, Buttons, ExtCtrls, ActnList, Graphics,
  {$ENDIF}
  Classes, IdSASLCollection;

type
  TfrmSASLListEditorVCL = class(TForm)
  protected
    lbAvailable: TListBox;
    lbAssigned: TListBox;
    sbAdd: TSpeedButton;
    sbRemove: TSpeedButton;
    {$IFDEF USE_TBitBtn}
    BtnCancel: TBitBtn;
    BtnOk: TBitBtn;
    {$ELSE}
    BtnCancel: TButton;
    BtnOk: TButton;
    {$ENDIF}
    Label1: TLabel;
    Label2: TLabel;
    sbUp: TSpeedButton;
    sbDown: TSpeedButton;
    SASLList: TIdSASLEntries;
    FListOwner: TComponent;
    actEditor: TActionList;
    actAdd : TAction;
    actRemove : TAction;
    actMoveUp : TAction;
    actMoveDown : TAction;
    procedure actAddUpdate(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actRemoveUpdate(Sender:TObject);
    procedure actRemoveExecute(Sender:TObject);
    procedure actMoveUpUpdate(Sender:TObject);
    procedure actMoveUpExecute(Sender:TObject);
    procedure actMoveDownExecute(Sender:TObject);
    procedure actMoveDownUpdate(Sender:TObject);
    procedure FormCreate;
    procedure UpdateList;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function Execute : Boolean;
    procedure SetList(const CopyFrom: TIdSASLEntries);
    procedure GetList(const CopyTo: TIdSASLEntries);
    procedure SetComponentName(const Name: string);
  end;

implementation

uses
  {$IFDEF WIDGET_LCL}
  LResources,
  {$ENDIF}
  IdDsnCoreResourceStrings,
  IdGlobal, IdResourceStrings, IdSASL,
  SysUtils;

{ TfrmSASLListEditorVCL }

{$IFNDEF WIDGET_LCL}
  {$IFDEF WINDOWS}
  {$R IdSASLListEditorForm.RES}
  {$ENDIF}
  {$IFDEF KYLIX}
  {$R IdSASLListEditorForm.RES}
  {$ENDIF}
{$ENDIF}

constructor TfrmSASLListEditorVCL.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner,0);
  FormCreate;
  UpdateList;
end;

procedure TfrmSASLListEditorVCL.GetList(const CopyTo: TIdSASLEntries);
begin
  CopyTo.Assign(SASLList);
end;

procedure TfrmSASLListEditorVCL.SetList(const CopyFrom: TIdSASLEntries);
var
  i, idx: integer;
begin
  SASLList.Assign(CopyFrom);
  for i := 0 to CopyFrom.Count-1 do begin
    if Assigned(CopyFrom[i].SASL) then
    begin
      idx := lbAvailable.Items.IndexOf(CopyFrom[i].SASL.Name);
      if idx >= 0 then begin
        lbAvailable.Items.Delete(idx);
      end;
    end;
  end;
  UpdateList;
end;

procedure TfrmSASLListEditorVCL.UpdateList;
var
  i: integer;
  l : TList;
begin
  lbAssigned.Items.BeginUpdate;
  try
    lbAssigned.Clear;
    for i := 0 to SASLList.Count -1 do begin
      if Assigned(SASLList[i].SASL) then
      begin
        lbAssigned.Items.AddObject(SASLList[i].SASL.Name + ': ' + String(SASLList[i].SASL.ServiceName), SASLList[i]);
      end;
    end;
  finally
    lbAssigned.Items.EndUpdate;
  end;
  lbAvailable.Items.BeginUpdate;
  try
    lbAvailable.Clear;
    l := GlobalSASLList.LockList;
    try
      for i := 0 to l.Count-1 do begin
        if SASLList.IndexOfComp(TIdSASL(l[i])) < 0 then begin
          if Assigned(l[i]) then
          begin
            lbAvailable.Items.AddObject(TIdSASL(l[i]).Name + ': ' + String(TIdSASL(l[i]).ServiceName), TIdSASL(l[i]));
          end;
        end;
      end;
    finally
      GlobalSASLList.UnlockList;
    end;
  finally
    lbAvailable.Items.EndUpdate;
  end;
end;

procedure TfrmSASLListEditorVCL.SetComponentName(const Name: string);
begin
  Caption := IndyFormat(Caption, [Name]);
end;

procedure TfrmSASLListEditorVCL.FormCreate;
begin
  SASLList := TIdSASLEntries.Create(Self);

  Left := 292;
  Top := 239;

  {$IFDEF WIDGET_KYLIX}
  BorderStyle := fbsDialog;
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE}
  BorderStyle := bsDialog;
  {$ENDIF}

  Caption := RSADlgSLCaption;

  {$IFDEF USE_TBitBtn}
  ClientHeight := 349;
  {$ELSE}
  ClientHeight := 344;
  {$ENDIF}
  ClientWidth := 452;

  Position := poScreenCenter;
  //workaround for problem - form position does not work like in VCL
  Left := (Screen.Width - Width) div 2;
  Top  := (Screen.Height - Height) div 2;

  {we do the actions here so that the rest of the components can bind to them}
  actEditor := TActionList.Create(Self);

  actAdd := TAction.Create(Self);
  actAdd.ActionList := actEditor;
  actAdd.Hint := RSADlgSLAdd;
  actAdd.OnExecute := actAddExecute;
  actAdd.OnUpdate  := actAddUpdate;

  actRemove := TAction.Create(Self);
  actRemove.ActionList := actEditor;
  actRemove.Hint := RSADlgSLRemove;
  actRemove.OnExecute := actRemoveExecute;
  actRemove.OnUpdate  := actRemoveUpdate;

  actMoveUp := TAction.Create(Self);
  actMoveUp.ActionList := actEditor;
  actMoveUp.Hint := RSADlgSLMoveUp;
  actMoveUp.OnExecute := actMoveUpExecute;
  actMoveUp.OnUpdate  := actMoveUpUpdate;

  actMoveDown := TAction.Create(Self);
  actMoveDown.ActionList := actEditor;
  actMoveDown.Hint := RSADlgSLMoveDown;
  actMoveDown.OnExecute := actMoveDownExecute;
  actMoveDown.OnUpdate  := actMoveDownUpdate;

  sbAdd := TSpeedButton.Create(Self);
  sbAdd.Name := 'sbAdd';  {do not localize}
  sbAdd.Parent := Self;
  sbAdd.Action := actAdd;
  sbAdd.Left := 184;
  sbAdd.Top := 88;
  sbAdd.Width := 57;
  sbAdd.Height := 25;
  sbAdd.ShowHint := True;
  {$IFDEF WIDGET_LCL}
  sbAdd.Glyph.LoadFromLazarusResource('DIS_ARROWRIGHT');  {do not localize}
  {$ELSE}
    {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  sbAdd.Glyph.LoadFromResourceName(HInstance, 'ARROWRIGHT');  {do not localize}
  sbAdd.NumGlyphs := 2;
    {$ENDIF}
  {$ENDIF}

  sbRemove := TSpeedButton.Create(Self);
  sbRemove.Name := 'sbRemove'; {do not localize}
  sbRemove.Parent := Self;
  sbRemove.Action := actRemove;
  sbRemove.Left := 184;
  sbRemove.Top := 128;
  sbRemove.Width := 57;
  sbRemove.Height := 25;
  sbRemove.ShowHint := True;
  {$IFDEF WIDGET_LCL}
  sbRemove.Glyph.LoadFromLazarusResource('DIS_ARROWLEFT');  {do not localize}
  {$ELSE}
    {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  sbRemove.Glyph.LoadFromResourceName(HInstance, 'ARROWLEFT'); {do not localize}
  sbRemove.NumGlyphs := 2;
    {$ENDIF}
  {$ENDIF}

  Label1 := TLabel.Create(Self);
  Label1.Name := 'Label1'; {do not localize}
  Label1.Parent := Self;
  Label1.Left := 8;
  Label1.Top := 8;
  Label1.Width := 42;
  Label1.Height := 13;
  Label1.Caption :=  RSADlgSLAvailable;

  Label2 := TLabel.Create(Self);
  Label2.Name := 'Label2'; {do not localize}
  Label2.Parent := Self;
  Label2.Left := 248;
  Label2.Top := 8;
  Label2.Width := 136;
  Label2.Height := 13;
  Label2.Caption := RSADlgSLAssigned;

  sbUp := TSpeedButton.Create(Self);
  sbUp.Name := 'sbUp'; {do not localize}
  sbUp.Parent := Self;
  sbUp.Action := actMoveUp;
  sbUp.Left := 424;
  sbUp.Top := 88;
  sbUp.Width := 23;
  sbUp.Height := 22;
  sbUp.ShowHint := True;
  {$IFDEF WIDGET_LCL}
  sbUp.Glyph.LoadFromLazarusResource('DIS_ARROWUP');  {do not localize}
  {$ELSE}
    {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  sbUp.Glyph.LoadFromResourceName(HInstance, 'ARROWUP'); {do not localize}
  sbUp.NumGlyphs := 2;
    {$ENDIF}
  {$ENDIF}

  sbDown := TSpeedButton.Create(Self);
  sbDown.Name := 'sbDown'; {do not localize}
  sbDown.Parent := Self;
  sbDown.Action := actMoveDown;
  sbDown.Left := 424;
  sbDown.Top := 128;
  sbDown.Width := 23;
  sbDown.Height := 22;
  sbDown.ShowHint := True;
  {$IFDEF WIDGET_LCL}
  sbDown.Glyph.LoadFromLazarusResource('DIS_ARROWDOWN');  {do not localize}
  {$ELSE}
    {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  sbDown.Glyph.LoadFromResourceName(HInstance, 'ARROWDOWN'); {do not localize}
  sbDown.NumGlyphs := 2;
    {$ENDIF}
  {$ENDIF}

  lbAvailable := TListBox.Create(Self);
  lbAvailable.Name := 'lbAvailable';  {do not localize}
  lbAvailable.Parent := Self;
  lbAvailable.Left := 8;
  lbAvailable.Top := 24;
  lbAvailable.Width := 169;
  lbAvailable.Height := 281;
  lbAvailable.ItemHeight := 13;
  lbAvailable.TabOrder := 0;

  lbAssigned := TListBox.Create(Self);
  lbAssigned.Name := 'lbAssigned'; {do not localize}
  lbAssigned.Parent := Self;
  lbAssigned.Left := 248;
  lbAssigned.Top := 24;
  lbAssigned.Width := 169;
  lbAssigned.Height := 281;
  lbAssigned.ItemHeight := 13;
  lbAssigned.TabOrder := 1;

  {$IFDEF USE_TBitBtn}
  BtnCancel := TBitBtn.Create(Self);
  {$ELSE}
  BtnCancel := TButton.Create(Self);
  {$ENDIF}
  BtnCancel.Name := 'BtnCancel';  {do not localize}
  BtnCancel.Left := 368;
  BtnCancel.Top := 312;
  BtnCancel.Width := 75;
  {$IFDEF WIDGET_LCL}
  BtnCancel.Height := 30;
  BtnCancel.Kind := bkCancel;
  {$ELSE}
  BtnCancel.Height := 25;
  BtnCancel.Cancel := True;
  BtnCancel.Caption := RSCancel;
  BtnCancel.ModalResult := 2;
  {$ENDIF}
  BtnCancel.Parent := Self;

  {$IFDEF USE_TBitBtn}
  BtnOk := TBitBtn.Create(Self);
  {$ELSE}
  BtnOk := TButton.Create(Self);
  {$ENDIF}
  BtnOk.Name := 'BtnOk';  {do not localize}
  BtnOk.Parent := Self;
  BtnOk.Left := 287;
  BtnOk.Top := 312;
  BtnOk.Width := 75;
  {$IFDEF WIDGET_LCL}
  BtnOk.Height := 30;
  BtnOk.Kind := bkOk;
  {$ELSE}
  BtnOk.Height := 25;
  BtnOk.Caption := RSOk;
  BtnOk.Default := True;
  BtnOk.ModalResult := 1;
  {$ENDIF}
  BtnOk.TabOrder := 2;
  BtnOk.TabOrder := 3;
end;

procedure TfrmSASLListEditorVCL.actAddExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAvailable.ItemIndex;
  if sel >= 0 then begin
    SASLList.Add.SASL := TIdSASL(lbAvailable.Items.Objects[sel]);
    UpdateList;
  end;
end;

procedure TfrmSASLListEditorVCL.actAddUpdate(Sender: TObject);
var
  LEnabled : Boolean;
begin
  //we do this in a round about way because we should update the glyph
  //with an enabled/disabled form so a user can see what is applicable

   LEnabled := (lbAvailable.Items.Count <> 0) and
    (lbAvailable.ItemIndex <> -1);

  {$IFDEF WIDGET_LCL}
  if LEnabled <> actAdd.Enabled then
  begin
    if LEnabled then begin
      sbAdd.Glyph.LoadFromLazarusResource('ARROWRIGHT');  {do not localize}
    end else begin
      sbAdd.Glyph.LoadFromLazarusResource('DIS_ARROWRIGHT');  {do not localize}
    end;
  end;
  {$ENDIF}

  actAdd.Enabled := LEnabled;
end;

procedure TfrmSASLListEditorVCL.actMoveDownExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  if (sel >= 0) and (sel < lbAssigned.Items.Count-1) then begin
    SASLList.Items[sel].Index := sel+1;
    Updatelist;
    lbAssigned.ItemIndex := sel+1;
  end;
end;

procedure TfrmSASLListEditorVCL.actMoveDownUpdate(Sender: TObject);
var
  LEnabled : Boolean;
begin
  LEnabled := (lbAssigned.Items.Count > 1) and
    (lbAssigned.ItemIndex <> -1) and
      (lbAssigned.ItemIndex < (lbAssigned.Items.Count - 1));

  {$IFDEF WIDGET_LCL}
  if LEnabled <> actMoveDown.Enabled then
  begin
    if LEnabled then begin
      sbDown.Glyph.LoadFromLazarusResource('ARROWDOWN');  {do not localize}
    end else begin
      sbDown.Glyph.LoadFromLazarusResource('DIS_ARROWDOWN');  {do not localize}
    end;
  end;
  {$ENDIF}

  actMoveDown.Enabled := LEnabled;
end;

procedure TfrmSASLListEditorVCL.actMoveUpExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  // >0 is intentional, can't move the top element up!!
  if sel > 0 then begin
     SASLList.Items[Sel].Index := sel-1;
     UpdateList;
     lbAssigned.ItemIndex := sel -1;
  end;
end;

procedure TfrmSASLListEditorVCL.actMoveUpUpdate(Sender: TObject);
var
  LEnabled : Boolean;
begin
  //we do this in a round about way because we should update the glyph
  //with an enabled/disabled form so a user can see what is applicable

  LEnabled := (lbAssigned.Items.Count > 1) and
    (lbAssigned.ItemIndex > 0); // -1 not selected and 0 = top

  {$IFDEF WIDGET_LCL}
  if LEnabled <> actMoveUp.Enabled then
  begin
    if LEnabled then begin
      sbUp.Glyph.LoadFromLazarusResource('ARROWUP');  {do not localize}
    end else begin
      sbUp.Glyph.LoadFromLazarusResource('DIS_ARROWUP');  {do not localize}
    end;
  end;
  {$ENDIF}

  actMoveUp.Enabled := LEnabled;
end;

procedure TfrmSASLListEditorVCL.actRemoveExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  if sel >= 0 then begin
    SASLList.Delete(sel);
  end;
  UpdateList;
{  sel := lbAssigned.ItemIndex;
  if sel >= 0 then begin
    SASLList.Remove(TIdSASL(lbAssigned.Items.Objects[sel]));
    UpdateList;
  end;    }
end;

procedure TfrmSASLListEditorVCL.actRemoveUpdate(Sender: TObject);
var
  LEnabled : Boolean;
begin
  LEnabled := (lbAssigned.Items.Count <> 0) and
    (lbAssigned.ItemIndex <> -1);

  {$IFDEF WIDGET_LCL}
  if LEnabled <> actRemove.Enabled then
  begin
    if LEnabled then begin
      sbRemove.Glyph.LoadFromLazarusResource('ARROWLEFT');  {do not localize}
    end else begin
      sbRemove.Glyph.LoadFromLazarusResource('DIS_ARROWLEFT');  {do not localize}
    end;
  end;
  {$ENDIF}

  actRemove.Enabled := LEnabled;
end;

function TfrmSASLListEditorVCL.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

{$IFDEF WIDGET_LCL}
initialization
  {$I IdDsnSASLListEditorFormVCL.lrs}
{$ENDIF}

end.

