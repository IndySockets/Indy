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
{   Rev 1.7    9/8/2004 10:10:40 PM  JPMugaas
{ Now should work properly in DotNET versions of Delphi.
}
{
{   Rev 1.6    9/5/2004 3:16:58 PM  JPMugaas
{ Should work in D9 DotNET.
}
{
{   Rev 1.5    2/26/2004 8:53:22 AM  JPMugaas
{ Hack to restore the property editor for SASL mechanisms.
}
{
{   Rev 1.4    1/25/2004 3:11:10 PM  JPMugaas
{ SASL Interface reworked to make it easier for developers to use.
{ SSL and SASL reenabled components.
}
{
    Rev 1.3    10/19/2003 6:05:38 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.2    10/12/2003 1:49:30 PM  BGooijen
{ Changed comment of last checkin
}
{
{   Rev 1.1    10/12/2003 1:43:30 PM  BGooijen
{ Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc
}
{
{   Rev 1.0    11/14/2002 02:19:14 PM  JPMugaas
}
{
  2002-08 Johannes Berg
    Form for the SASL List Editor. It doesn't use a DFM/XFM to be
    more portable between Delphi/Kylix versions, and to make less
    trouble maintaining it.
}
unit IdDsnSASLListEditorFormVCL;

interface

{$I IdCompilerDefines.inc}
uses
  {$IFDEF Linux}
  QControls, QForms, QStdCtrls, QButtons, QExtCtrls, QActnList, QGraphics,
  {$ELSE}
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
    Button1: TButton;
    Button2: TButton;
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
    function Execute : Boolean;
    procedure SetList(const CopyFrom: TIdSASLEntries);
    procedure GetList(const CopyTo: TIdSASLEntries);
    procedure SetComponentName(const Name: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
   {$IFDEF WIN32}Windows,{$ENDIF}
  IdDsnCoreResourceStrings,
  IdResourceStrings, IdSASL, SysUtils;


{ TfrmSASLListEditorVCL }

{$R IdSASLListEditorForm.RES}

constructor TfrmSASLListEditorVCL.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  FormCreate;
  UpdateList;
end;

destructor TfrmSASLListEditorVCL.Destroy;
begin
  inherited Destroy;
end;

procedure TfrmSASLListEditorVCL.GetList(const CopyTo: TIdSASLEntries);
var
  i: integer;
  LCI : TIdSASLListEntry;
begin
  CopyTo.Clear;
  for i := 0 to SASLList.Count -1 do
  begin
    LCI := CopyTo.Add;
    LCI.Assign(SASLList[i]);
  end;
end;

procedure TfrmSASLListEditorVCL.SetList(const CopyFrom: TIdSASLEntries);
var
  i, idx: integer;
  LCI : TIdSASLListEntry;
begin
  SASLList.Clear;
  for i := 0 to CopyFrom.Count -1 do begin
    LCI := SASLList.Add;
    LCI.Assign(CopyFrom[i]);
  end;
  for i:=0 to CopyFrom.Count-1 do begin
    if Assigned(CopyFrom[i].SASL) then
    begin
      idx := lbAvailable.Items.IndexOf(CopyFrom[i].SASL.Name);
      if idx>=0 then begin
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
  lbAssigned.Clear;

  for i := 0 to SASLList.Count -1 do begin
    if Assigned(SASLList[i].SASL) then
    begin
      lbAssigned.Items.AddObject(SASLList[i].SASL.Name+': '+SASLList[i].SASL.ServiceName, SASLList[i]);
    end;
  end;
  lbAvailable.Clear;
  l := GlobalSASLList.LockList;
  try
    for i:=0 to l.count-1 do begin
      if SASLList.IndexOfComp(TIdSASL(l[i])) < 0 then begin
        if Assigned(l[i]) then
        begin
          lbAvailable.Items.AddObject(TIdSASL(l[i]).Name+': '+TIdSASL(l[i]).ServiceName, TIdSASL(l[i]));
        end;
      end;
    end;
  finally
    GlobalSASLList.UnlockList;
  end;
end;


procedure TfrmSASLListEditorVCL.SetComponentName(const Name: string);
begin
  Caption := Format(Caption, [Name]);
end;

procedure TfrmSASLListEditorVCL.FormCreate;
begin
  Left := 292;
  Top := 239;
  {$IFDEF LINUX} // should be CLX, but I can't find CLX defined
  BorderStyle := fbsDialog;
  {$ELSE}
  BorderStyle := bsDialog;
  {$ENDIF}
  Caption := RSADlgSLCaption;
  ClientHeight := 344;
  ClientWidth := 452;

  Position := poScreenCenter;
  //workaround for problem - form position does not work like in VCL
  Left := (Screen.Width - Width) div 2;
  Top  := (Screen.Height - Height) div 2;

  {we do the actions here so that the rest of the components can bind to them}
  actEditor:= TActionList.Create(Self);

  actAdd:= TAction.Create(Self);
  actAdd.ActionList := actEditor;
  actAdd.Hint := RSADlgSLAdd;
  actAdd.OnExecute := actAddExecute;
  actAdd.OnUpdate  := actAddUpdate;

  actRemove:= TAction.Create(Self);
  actRemove.ActionList := actEditor;
  actRemove.Hint := RSADlgSLRemove;
  actRemove.OnExecute := actRemoveExecute;
  actRemove.OnUpdate  := actRemoveUpdate;

  actMoveUp:= TAction.Create(Self);
  actMoveUp.ActionList := actEditor;
  actMoveUp.Hint := RSADlgSLMoveUp;
  actMoveUp.OnExecute := actMoveUpExecute;
  actMoveUp.OnUpdate  := actMoveUpUpdate;

  actMoveDown:= TAction.Create(Self);
  actMoveDown.ActionList := actEditor;
  actMoveDown.Hint := RSADlgSLMoveDown;
  actMoveDown.OnExecute := actMoveDownExecute;
  actMoveDown.OnUpdate  := actMoveDownUpdate;

  sbAdd := TSpeedButton.Create(Self);

  sbRemove := TSpeedButton.Create(Self);
  Label1 := TLabel.Create(Self);
  Label2 := TLabel.Create(Self);
  sbUp := TSpeedButton.Create(Self);
  sbDown := TSpeedButton.Create(Self);
  lbAvailable := TListBox.Create(Self);
  lbAssigned := TListBox.Create(Self);
  Button1 := TButton.Create(Self);
  Button2 := TButton.Create(Self);
  SASLList := TIdSASLEntries.Create(Self);
  with sbAdd do
  begin
    Name := 'sbAdd';  {do not localize}
    Parent := Self;
    Action := actAdd;
    Left := 184;
    Top := 88;
    Width := 57;
    Height := 25;
    ShowHint := True;
    Glyph.LoadFromResourceName(HInstance, 'ARROWRIGHT');  {do not localize}
    NumGlyphs := 2;
  end;
  with sbRemove do
  begin
    Name := 'sbRemove'; {do not localize}
    Parent := Self;
    Action := actRemove;
    Left := 184;
    Top := 128;
    Width := 57;
    Height := 25;
    ShowHint := True;

    Glyph.LoadFromResourceName(HInstance, 'ARROWLEFT'); {do not localize}
    NumGlyphs := 2;
  end;
  with Label1 do
  begin
    Name := 'Label1'; {do not localize}
    Parent := Self;
    Left := 8;
    Top := 8;
    Width := 42;
    Height := 13;
    Caption :=  RSADlgSLAvailable;
  end;
  with Label2 do
  begin
    Name := 'Label2'; {do not localize}
    Parent := Self;
    Left := 248;
    Top := 8;
    Width := 136;
    Height := 13;
    Caption := RSADlgSLAssigned
  end;
  with sbUp do
  begin
    Name := 'sbUp'; {do not localize}
    Parent := Self;
    Action := actMoveUp;
    Left := 424;
    Top := 88;
    Width := 23;
    Height := 22;
    ShowHint := True;
    Glyph.LoadFromResourceName(HInstance, 'ARROWUP'); {do not localize}
    NumGlyphs := 2;
  end;
  with sbDown do
  begin
    Name := 'sbDown'; {do not localize}
    Parent := Self;
    Action := actMoveDown;
    Left := 424;
    Top := 128;
    Width := 23;
    Height := 22;

    ShowHint := True;
    Glyph.LoadFromResourceName(HInstance, 'ARROWDOWN'); {do not localize}
    NumGlyphs := 2;
  end;
  with lbAvailable do
  begin
    Name := 'lbAvailable';  {do not localize}
    Parent := Self;
    Left := 8;
    Top := 24;
    Width := 169;
    Height := 281;
    ItemHeight := 13;
    TabOrder := 0;
  end;
  with lbAssigned do
  begin
    Name := 'lbAssigned'; {do not localize}
    Parent := Self;

    Left := 248;
    Top := 24;
    Width := 169;
    Height := 281;

    ItemHeight := 13;
    TabOrder := 1;
  end;
  with Button1 do
  begin
    Name := 'Button1';  {do not localize}

    Left := 368;
    Top := 312;
    Width := 75;
    Height := 25;

    Cancel := True;
    Caption := RSCancel;
    ModalResult := 2;

    Parent := Self;

  end;
  with Button2 do
  begin
    Name := 'Button2';  {do not localize}
    Parent := Self;

    Left := 287;
    Top := 312;
    Width := 75;
    Height := 25;

    Caption := RSOk;
    Default := True;
    ModalResult := 1;
    TabOrder := 2;

    TabOrder := 3;
  end;

end;


procedure TfrmSASLListEditorVCL.actAddExecute(Sender: TObject);
var
  sel: integer;
  LCI : TIdSASLListEntry;
begin
  sel := lbAvailable.ItemIndex;
  if sel >=0 then begin
    LCI := SASLList.Add;
    LCI.SASL := TIdSASL(lbAvailable.Items.Objects[sel]);
    UpdateList;
  end;
end;

procedure TfrmSASLListEditorVCL.actAddUpdate(Sender: TObject);
begin
  actAdd.Enabled := (lbAvailable.Items.Count <> 0) and
    (lbAvailable.ItemIndex <> -1);
end;

procedure TfrmSASLListEditorVCL.actMoveDownExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  if (sel>=0) and (sel<lbAssigned.Items.Count-1) then begin
    SASLList.Items[sel].Index := sel+1;
    Updatelist;
    lbAssigned.ItemIndex := sel+1;
  end;
end;

procedure TfrmSASLListEditorVCL.actMoveDownUpdate(Sender: TObject);
begin
  actMoveDown.Enabled := (lbAssigned.Items.Count > 1) and
    (lbAssigned.ItemIndex <> -1) and (lbAssigned.ItemIndex < (lbAssigned.Items.Count - 1));
end;

procedure TfrmSASLListEditorVCL.actMoveUpExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  // >0 is intentional, can't move the top element up!!
  if sel>0 then begin
     SASLList.Items[Sel].Index := sel-1;
     UpdateList;
     lbAssigned.ItemIndex := sel -1;
  end;
end;

procedure TfrmSASLListEditorVCL.actMoveUpUpdate(Sender: TObject);
begin
  sbUp.Enabled := (lbAssigned.Items.Count > 1) and
    (lbAssigned.ItemIndex > 0); // -1 not selected and 0 = top
end;

procedure TfrmSASLListEditorVCL.actRemoveExecute(Sender: TObject);
var
  sel: integer;
begin
  sel := lbAssigned.ItemIndex;
  if sel >= 0 then
  begin
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
begin
  actRemove.Enabled := (lbAssigned.Items.Count <> 0) and
    (lbAssigned.ItemIndex <> -1);
end;

function TfrmSASLListEditorVCL.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

end.
