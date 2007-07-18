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
  Rev 1.9    10/26/2004 8:45:26 PM  JPMugaas
  Should compile.

  Rev 1.8    10/26/2004 8:42:58 PM  JPMugaas
  Should be more portable with new references to TIdStrings and TIdStringList.

  Rev 1.7    5/19/2004 10:44:28 PM  DSiders
  Corrected spelling for TIdIPAddress.MakeAddressObject method.

  Rev 1.6    2/3/2004 11:34:26 AM  JPMugaas
  Should compile.

  Rev 1.5.1.0    2/3/2004 11:32:26 AM  JPMugaas
  Should compile.

  Rev 1.5    2/1/2004 2:44:20 AM  JPMugaas
  Bindings editor should be fully functional including IPv6 support.

  Rev 1.4    2/1/2004 1:03:34 AM  JPMugaas
  This now work properly in both Win32 and DotNET.  The behavior had to change
  in DotNET because of some missing functionality and because implementing that
  functionality creates more problems than it would solve.

  Rev 1.3    2003.12.31 10:42:22 PM  czhower
  Warning removed

  Rev 1.2    10/15/2003 10:12:32 PM  DSiders
  Added localization comments.

  Rev 1.1    2003.10.11 5:47:46 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.0    11/13/2002 08:43:58 AM  JPMugaas
}

unit IdDsnPropEdBindingVCL;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF LINUX}
  IdSocketHandle, QActnList, QStdCtrls, QForms, QExtCtrls, QControls, QComCtrls, QGraphics, Qt, Types;
  {$ELSE}
  ActnList,  Controls,
  ExtCtrls, Forms, Graphics, IdSocketHandle,

  StdCtrls;
  {$ENDIF}

{
  Design Note:  It turns out that in DotNET, there are no services file functions and
  IdPorts does not work as expected in DotNET.  It is probably possible to read the
  services file ourselves but that creates some portability problems as the placement
  is different in every operating system.

  e.g.

  Linux and Unix-like systems - /etc
  Windows 95, 98, and ME - c:\windows
  Windows NT systems - c:\winnt\system32\drivers\etc

  Thus, it will undercut whatever benefit we could get with DotNET.

  About the best I could think of is to use an edit control because
  we can't offer anything from the services file in DotNET.

  TODO:  Maybe there might be a way to find the location in a more elegant
  manner than what I described.
}

type
  TIdDsnPropEdBindingVCL = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lblBindings: TLabel;
    edtPort: TComboBox;
    rdoBindingType: TRadioGroup;
    lblIPAddress: TLabel;
    lblPort: TLabel;
    btnNew: TButton;
    btnDelete: TButton;
    ActionList1: TActionList;
    btnBindingsNew: TAction;
    btnBindingsDelete: TAction;
    edtIPAddress: TComboBox;
    lbBindings: TListBox;
    procedure btnBindingsNewExecute(Sender: TObject);
    procedure btnBindingsDeleteExecute(Sender: TObject);
    procedure btnBindingsDeleteUpdate(Sender: TObject);
    procedure edtPortKeyPress(Sender: TObject; var Key: Char);
    procedure edtIPAddressChange(Sender: TObject);
    procedure edtPortChange(Sender: TObject);
    procedure rdoBindingTypeClick(Sender: TObject);
    procedure lbBindingsClick(Sender: TObject);
  private
    procedure SetHandles(const Value: TIdSocketHandles);
    procedure SetIPv4Addresses(const Value: TStrings);
    procedure SetIPv6Addresses(const Value: TStrings);
    procedure UpdateBindingList;
  protected
    FHandles : TIdSocketHandles;
    FDefaultPort : Integer;
    FIPv4Addresses : TStrings;
    FIPv6Addresses : TStrings;
    fCreatedStack : Boolean;
    FCurrentHandle : TIdSocketHandle;
    procedure UpdateEditControls;
    function PortDescription(const PortNumber: integer): string;
  public
    Constructor Create(AOwner : TComponent); overload; override;
    constructor Create; reintroduce; overload;
    Destructor Destroy; override;
    function Execute : Boolean;
    function GetList: string;
    procedure SetList(const AList: string);
    property Handles : TIdSocketHandles read FHandles write SetHandles;
    property DefaultPort : Integer read FDefaultPort write FDefaultPort;
    property IPv4Addresses : TStrings read FIPv4Addresses write SetIPv4Addresses;
    property IPv6Addresses : TStrings read FIPv6Addresses write SetIPv6Addresses;
  end;

var
  IdPropEdBindingEntry: TIdDsnPropEdBindingVCL;

procedure FillHandleList(const AList: string; ADest: TIdSocketHandles);
function GetListValues(const ASocketHandles : TIdSocketHandles) : String;

implementation

uses
  IdGlobal,
  IdIPAddress,
  IdDsnCoreResourceStrings, IdStack,
  IdStackBSDBase,
   SysUtils;

const
  IPv6Wildcard1 = '::';                 {do not localize}
  IPv6Wildcard2 = '0:0:0:0:0:0:0:0';    {do not localize}
  IPv6Loopback  = '::1';                {do not localize}
  IPv4Wildcard  = '0.0.0.0';            {do not localize}
  IPv4Loopback  = '127.0.0.1';          {do not localize}

function IsValidIP(const AAddr : String): Boolean;
var LIP :  TIdIPAddress;
begin
  LIP :=  TIdIPAddress.MakeAddressObject(AAddr);
  Result := Assigned(LIP);
  if Result then
  begin
    FreeAndNil(LIP);
  end;
end;

procedure FillHandleList(const AList: string; ADest: TIdSocketHandles);
var
  LItems: TStringList;
  i: integer;
  LIPVersion: TIdIPVersion;
  LAddr, LText: string;
  LPort: integer;
begin
  ADest.Clear;
  LItems := TStringList.Create;
  try
    LItems.CommaText := AList;
    for i := 0 to LItems.Count-1 do begin
      if Length(LItems[i]) > 0 then begin
        if LItems[i][1] = '[' then begin
         //  ipv6
          LIPVersion := Id_IPv6;
          LText := Copy(LItems[i], 2, MaxInt);
          LAddr := Fetch(LText, ']:');
          LPort := StrToIntDef(LText, -1);

        end else begin
          // ipv4
          LIPVersion := Id_IPv4;
          LText := LItems[i];
          LAddr := Fetch(LText, ':');
          LPort := StrToIntDef(LText, -1);
          //Note that 0 is legal and indicates the server binds to a random port
        end;
        if IsValidIP(LAddr) and (LPort > -1) and (LPort < 65536) then begin
          with ADest.Add do begin
            IPVersion := LIPVersion;
            IP := LAddr;
            Port := LPort;
          end;
        end;
      end;
    end;
  finally
    LItems.Free;
  end;
end;

{ TIdDsnPropEdBindingVCL }

function NumericOnly(const AText : String) : String;
var i : Integer;

begin
  Result := '';
  for i := 1 to Length(AText) do
  begin
    if IsNumeric(AText[i]) then
    begin
      Result := Result + AText[i];
    end
    else
    begin
      Break;
    end;
  end;
  if (Length(Result) = 0) then
  begin
    Result := '0';
  end;
end;

function IndexOfNo(const ANo : Integer; AStrings : TStrings) : Integer;
begin
  for Result := 0 to AStrings.Count -1 do
  begin
    if ANo = StrToInt( NumericOnly(AStrings[Result])) then
    begin
      Exit;
    end;
  end;
  Result := -1;
end;

function GetDisplayString(const AIP : String; const APort : Integer; AIPVer : TIdIPVersion): string;
begin
  Result := '';
  case AIPVer of
      Id_IPv4 : Result := Format('%s:%d',[AIP,APort]);
      Id_IPv6 : Result := Format('[%s]:%d',[AIP,APort]);
  end;
end;

function GetListValues(const ASocketHandles : TIdSocketHandles) : String;
var i : Integer;
begin
  Result := '';
  for i := 0 to ASocketHandles.Count -1 do begin
    Result := Result + ',' + GetDisplayString(ASocketHandles[i].IP,ASocketHandles[i].Port,ASocketHandles[i].IPVersion );
  end;
  Delete(Result,1,1);
end;

constructor TIdDsnPropEdBindingVCL.Create(AOwner: TComponent);
var i : Integer;
begin
  inherited CreateNew(AOwner);
  {$IFNDEF LINUX}
  Borderstyle := bsDialog;
  {$ENDIF}
  BorderIcons := [biSystemMenu];
 // Width := 480;
 // Height := 252;
  ClientWidth  := 472;
  ClientHeight := 225;
  Constraints.MaxWidth := Width;
  Constraints.MaxHeight := Height;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  Position := poScreenCenter;
  lblBindings := TLabel.Create(Self);
  lbBindings := TListBox.Create(Self);
  ActionList1 := TActionList.Create(Self);
  btnBindingsNew := TAction.Create(Self);
  btnBindingsDelete := TAction.Create(Self);
  btnNew := TButton.Create(Self);
  btnDelete := TButton.Create(Self);
  lblIPAddress := TLabel.Create(Self);
  edtIPAddress := TComboBox.Create(Self);
  lblPort := TLabel.Create(Self);

  edtPort := TComboBox.Create(Self);

  rdoBindingType := TRadioGroup.Create(Self);
  btnOk := TButton.Create(Self);
  btnCancel := TButton.Create(Self);
  with lblBindings do
  begin
    Name := 'lblBindings';  {do not localize}
    Parent := Self;
    Left := 8;
    Top := 8;
    Width := 35;
    Height := 13;
    Caption := '&Binding';  {do not localize}
  end;
  with lbBindings do
  begin
    Name := 'lbBindings';   {do not localize}
    Parent := Self;
    Left := 8;
    Top := 24;
    Width := 137;
    Height := 161;
    ItemHeight := 13;
    TabOrder := 8;
    OnClick := lbBindingsClick;
  end;
  with ActionList1 do
  begin
    Name := 'ActionList1';  {do not localize}
    Left := 152;
    Top := 32;
  end;
  with btnBindingsNew do
  begin
    Name := 'btnBindingsNew'; {do not localize}
    Caption := RSBindingNewCaption;
    OnExecute := btnBindingsNewExecute;
  end;
  with btnBindingsDelete do
  begin
    Name := 'btnBindingsDelete';  {do not localize}
    Caption := RSBindingDeleteCaption;
    OnExecute := btnBindingsDeleteExecute;
    OnUpdate := btnBindingsDeleteUpdate;
  end;
  with btnNew do
  begin
    Name := 'btnNew'; {do not localize}
    Parent := Self;
    Left := 152;
    Top := 72;
    Width := 75;
    Height := 25;
    Action := btnBindingsNew;
    TabOrder := 6;
  end;
  with btnDelete do
  begin
    Name := 'btnDelete';  {do not localize}
    Parent := Self;
    Left := 152;
    Top := 104;
    Width := 75;
    Height := 25;
    Action := btnBindingsDelete;
    TabOrder := 7;
  end;
  with lblIPAddress do
  begin
    Name := 'lblIPAddress'; {do not localize}
    Parent := Self;
    Left := 240;
    Top := 8;
    Width := 54;
    Height := 13;
    Caption := RSBindingHostnameLabel;
    Enabled := False;
  end;
  with edtIPAddress do
  begin
    Name := 'edtIPAddress'; {do not localize}
    Parent := Self;
    Left := 240;
    Top := 24;
    Width := 221;
    Height := 21;
    Style := csDropDownList;
    Enabled := False;
    ItemHeight := 13;
    TabOrder := 3;
    OnChange := edtIPAddressChange;
  end;
  with lblPort do
  begin
    Name := 'lblPort';  {do not localize}
    Parent := Self;
    Left := 240;
    Top := 56;
    Width := 22;
    Height := 13;
    Caption := RSBindingPortLabel;
    Enabled := False;
    FocusControl := edtPort;
  end;
  with edtPort do
  begin
    Name := 'edtPort';  {do not localize}
    Parent := Self;
    Left := 240;
    Top := 72;
    Width := 221;
    Height := 21;
    Enabled := False;
    ItemHeight := 13;
    TabOrder := 4;
    OnChange := edtPortChange;
    OnKeyPress := edtPortKeyPress;
  end;
  with rdoBindingType do
  begin
    Name := 'rdoBindingType'; {do not localize}
    Parent := Self;
    Left := 240;
    Top := 120;
    Width := 221;
    Height := 65;
    Caption := RSBindingIPVerLabel;
    Enabled := False;
    Items.Add(RSBindingIPV4Item);
    Items.Add(RSBindingIPV6Item);
    TabOrder := 5;
    OnClick := rdoBindingTypeClick;
  end;
  with btnOk do
  begin
    Name := 'btnOk';  {do not localize}
    Parent := Self;
    Left := 306;
    Top := 193;
    Width := 75;
    Height := 25;
    Anchors := [akRight, akBottom];
    Caption := RSOk;
    Default := True;
    ModalResult := 1;
    TabOrder := 0;
  end;
  with btnCancel do
  begin
    Name := 'btnCancel';  {do not localize}
    Parent := Self;
    Left := 386;
    Top := 193;
    Width := 75;
    Height := 25;
    Anchors := [akRight, akBottom];
    Cancel := True;
    Caption := RSCancel;
    ModalResult := 2;
    TabOrder := 1;
  end;
  FHandles := TIdSocketHandles.Create(nil);
  FIPv4Addresses := TStringList.Create;
  FIPv6Addresses := TStringList.Create;
  SetIPv4Addresses(nil);
  SetIPv6Addresses(nil);

  if Assigned(GStack) then begin
    fCreatedStack := False;
  end else begin
    TIdStack.Make;
    fCreatedStack := True;
  end;
  IPv4Addresses := GStack.LocalAddresses;

  try
    edtPort.Items.Add(PortDescription(0));
    edtPort.Items.BeginUpdate;
    for i := 0 to IdPorts.Count - 1 do
    begin
      edtPort.Items.Add(PortDescription(Integer(IdPorts[i])));
    end;
  finally
    edtPort.Items.EndUpdate;
  end;

  AutoScroll := False;
  Caption := RSBindingFormCaption;
  Scaled := False;
  Font.Color := clBtnText;
  Font.Height := -11;
  Font.Name := 'MS Sans Serif';    {Do not Localize}
  Font.Style := [];
  Position := poScreenCenter;
  PixelsPerInch := 96;
  UpdateEditControls;
end;

destructor TIdDsnPropEdBindingVCL.Destroy;
begin
  FreeAndNil(FIPv4Addresses);
  FreeAndNil(FIPv6Addresses);
  FreeAndNil(FHandles);
  if fCreatedStack then
  begin
    FreeAndNil(GStack);
  end;
  inherited Destroy;
end;

function TIdDsnPropEdBindingVCL.PortDescription(
  const PortNumber: integer): string;

begin
  with GBSDStack.WSGetServByPort(PortNumber) do try
    if PortNumber = 0 then
    begin
      Result := Format('%d: %s', [PortNumber, RSBindingAny]);
    end
    else
    begin
      Result := '';    {Do not Localize}
      if Count > 0 then begin
        Result := Format('%d: %s', [PortNumber, CommaText]);    {Do not Localize}
      end;
    end;
  finally
    Free;
  end;
end;

procedure TIdDsnPropEdBindingVCL.SetHandles(const Value: TIdSocketHandles);
begin
  FHandles.Assign(Value);
  UpdateBindingList;
end;

procedure TIdDsnPropEdBindingVCL.btnBindingsNewExecute(Sender: TObject);
begin
  FCurrentHandle := FHandles.Add;
  FCurrentHandle.IP := IPv4Wildcard;
  FCurrentHandle.Port := FDefaultPort;
  UpdateBindingList;
  edtIPAddress.Items.Assign(FIPv4Addresses);
  UpdateEditControls;
end;

procedure TIdDsnPropEdBindingVCL.UpdateEditControls;
var i : Integer;

begin
  if Assigned(FCurrentHandle) then
  begin

    i := IndexOfNo(FCurrentHandle.Port,edtPort.Items);
    if i = -1 then
    begin
      edtPort.Text := IntToStr(FCurrentHandle.Port);
    end
    else
    begin
      edtPort.ItemIndex := i;
    end;

    case FCurrentHandle.IPVersion of
      Id_IPv4 :
      begin
        rdoBindingType.ItemIndex := 0;
        edtIPAddress.Items.Assign(FIPv4Addresses);
      end;
      Id_IPv6 :
      begin
        rdoBindingType.ItemIndex := 1;
        edtIPAddress.Items.Assign(FIPv6Addresses);
      end;
    end;
    edtIPAddress.ItemIndex := edtIPAddress.Items.IndexOf(FCurrentHandle.IP);
  end
  else
  begin
    edtIPAddress.Text := '';
    edtPort.ItemIndex := -2;
    edtPort.Text := '';
  end;

  lblIPAddress.Enabled := Assigned(FCurrentHandle);
  edtIPAddress.Enabled := Assigned(FCurrentHandle);
  lblPort.Enabled := Assigned(FCurrentHandle);
  edtPort.Enabled := Assigned(FCurrentHandle);
  rdoBindingType.Enabled := Assigned(FCurrentHandle);
  {$IFDEF LINUX}
  //WOrkaround for CLX quirk that might be Kylix 1
  for i := 0 to rdoBindingType.ControlCount -1 do
  begin
    rdoBindingType.Controls[i].Enabled := Assigned(FCurrentHandle);
  end;
  {$ENDIF}
  {$IFNDEF LINUX}
  //The Win32 VCL does not change the control background to a greyed look
  //when controls are disabled.  This quirk is not present in CLX.
  if Assigned(FCurrentHandle) then
  begin
    edtIPAddress.Color := clWindow;
    edtPort.Color := clWindow;
  end
  else
  begin
    edtIPAddress.Color := clBtnFace;
    edtPort.Color := clBtnFace;
  end;
  {$ENDIF}
end;

procedure TIdDsnPropEdBindingVCL.btnBindingsDeleteExecute(Sender: TObject);
var LSH : TIdSocketHandle;
begin
  if lbBindings.ItemIndex >= 0 then
  begin
    // Delete is not available in D4's collection classes
    // This should work just as well.
    LSH := Handles[lbBindings.ItemIndex];
    FreeAndNil(LSH);
    FCurrentHandle := nil;
    UpdateBindingList;
  end;
  lbBindingsClick(nil);
  UpdateEditControls;
end;

procedure TIdDsnPropEdBindingVCL.btnBindingsDeleteUpdate(Sender: TObject);
begin
  btnBindingsDelete.Enabled := lbBindings.ItemIndex >= 0;
end;

procedure TIdDsnPropEdBindingVCL.SetIPv4Addresses(const Value: TStrings);
begin
  if Assigned(Value) then
  begin
    FIPv4Addresses.Assign(Value);
  end;
    // Ensure that these two are always present
  if FIPv4Addresses.IndexOf(IPv6Loopback)=-1 then
  begin
    FIPv4Addresses.Insert(0,IPv4Loopback);
  end;

  if FIPv4Addresses.IndexOf(IPv4Wildcard)=-1 then
  begin
    FIPv4Addresses.Insert(0,IPv4Wildcard);
  end;

end;

procedure TIdDsnPropEdBindingVCL.SetIPv6Addresses(const Value: TStrings);
begin
  if Assigned(Value) then
  begin
    FIPv6Addresses.Assign(Value);
  end;
  // Ensure that these two are always present
  if FIPv6Addresses.IndexOf(IPv6Loopback)=-1 then
  begin
    FIPv6Addresses.Insert(0,IPv6Loopback);
  end;
  if FIPv6Addresses.IndexOf(IPv6Wildcard1)=-1 then
  begin
    FIPv6Addresses.Insert(0,IPv6Wildcard1);
  end;
end;

procedure TIdDsnPropEdBindingVCL.edtPortKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key > #31) and (Key <  #128) then
    if not IsNumeric(Key) then    {Do not Localize}
    begin
      Key := #0;
    end;
end;

procedure TIdDsnPropEdBindingVCL.edtIPAddressChange(Sender: TObject);
begin
  FCurrentHandle.IP := edtIPAddress.Text;
  UpdateBindingList;
end;

procedure TIdDsnPropEdBindingVCL.edtPortChange(Sender: TObject);
begin
  if Assigned(FCurrentHandle) then
  begin
    FCurrentHandle.Port := StrToIntDef(NumericOnly(edtPort.Text),0);
  end;
  UpdateBindingList;
end;

procedure TIdDsnPropEdBindingVCL.rdoBindingTypeClick(Sender: TObject);
begin
  case rdoBindingType.ItemIndex of
    0 :
    begin
      if FCurrentHandle.IPVersion <> Id_IPv4 then
      begin
        FCurrentHandle.IPVersion := Id_IPv4;
        edtIPAddress.Items.Assign(FIPv4Addresses);
        FCurrentHandle.IP := IPv4Wildcard;
      end;
    end;
    1 :
    begin
      if FCurrentHandle.IPVersion <> Id_IPv6 then
      begin
        FCurrentHandle.IPVersion := Id_IPv6;
        edtIPAddress.Items.Assign(FIPv6Addresses);
        FCurrentHandle.IP := IPv6Wildcard1;
      end;
    end;
  end;
  UpdateEditControls;
  UpdateBindingList;
end;

function TIdDsnPropEdBindingVCL.GetList: string;
begin
  Result := GetListValues(Handles);
end;

procedure TIdDsnPropEdBindingVCL.lbBindingsClick(Sender: TObject);
begin
  if lbBindings.ItemIndex >= 0 then begin
    FCurrentHandle := FHandles[lbBindings.ItemIndex];
  end else begin
    FCurrentHandle := nil;
  end;
  UpdateEditControls;
end;

procedure TIdDsnPropEdBindingVCL.SetList(const AList: string);
begin
  FCurrentHandle := nil;
  FillHandleList(AList, Handles);
  UpdateBindingList;
  UpdateEditControls;
end;

procedure TIdDsnPropEdBindingVCL.UpdateBindingList;
var
  i: integer;
  selected: integer;
  s: string;
begin
  selected := lbBindings.ItemIndex;
  lbBindings.Items.BeginUpdate;
  try
    if lbBindings.Items.Count = FHandles.Count then begin
      for i := 0 to FHandles.Count - 1 do begin
        s := GetDisplayString(FHandles[i].IP, FHandles[i].Port, FHandles[i].IPVersion);
        if s <> lbBindings.Items[i] then begin
          lbBindings.Items[i] := s;
        end;
      end;
    end else begin
      lbBindings.Items.Clear;
      for i := 0 to FHandles.Count-1 do begin
        lbBindings.Items.Add(GetDisplayString(FHandles[i].IP, FHandles[i].Port,FHandles[i].IPVersion));
      end;
    end;
  finally
    lbBindings.Items.EndUpdate;
    if Assigned(FCurrentHandle) then begin
      lbBindings.ItemIndex := FCurrentHandle.Index;
    end else begin
      lbBindings.ItemIndex := Min(selected, lbBindings.Items.Count-1);
    end;
  end;
end;

function TIdDsnPropEdBindingVCL.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

constructor TIdDsnPropEdBindingVCL.Create;
begin
  Create(nil);
end;

end.
