unit IdAboutVCL;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAbout = class(TForm)
  protected
    FimLogo : TImage;
    FlblCopyRight : TLabel;
    FlblName : TLabel;
    FlblVersion : TLabel;
    FlblPleaseVisitUs : TLabel;
    FlblURL : TLabel;
    FbbtnOk : TButton;
    procedure lblURLClick(Sender: TObject);
    function GetProductName: String;
    procedure SetProductName(const AValue: String);
    function GetVersion: String;
    procedure SetVersion(const AValue: String);
  public
    constructor Create(AOwner : TComponent); override;
    class Procedure ShowAboutBox(const AProductName, AProductVersion : String);
    class Procedure ShowDlg;
    property ProductName : String read GetProductName write SetProductName;
    property Version : String read GetVersion write SetVersion;
  end;



implementation
{$R IdAboutVCL.RES}
uses
  {$IFNDEF Linux}ShellApi, {$ENDIF}
  IdDsnCoreResourceStrings,
  IdGlobal;

class Procedure TfrmAbout.ShowAboutBox(const AProductName, AProductVersion : String);
begin
  with TfrmAbout.Create(Application) do
  try
    ProductName := AProductName;
    Version := Format ( RSAAboutBoxVersion, [ AProductVersion ] );
    ShowModal;
  finally
    Free;
  end;
end;

class Procedure TfrmAbout.ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

{ TfrmAbout }

constructor TfrmAbout.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner,0);
    ClientHeight := 372;
  ClientWidth := 637;

  PixelsPerInch := 96;
  Constraints.MaxHeight := Height;
  Constraints.MaxWidth := Width;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;



  
  FimLogo := TImage.Create(Self);
  FlblCopyRight := TLabel.Create(Self);
  FlblName := TLabel.Create(Self);
  FlblVersion := TLabel.Create(Self);
  FlblPleaseVisitUs := TLabel.Create(Self);
  FlblURL := TLabel.Create(Self);
  FbbtnOk := TButton.Create(Self);
  Font.Color := clBtnText;
  {$IFNDEF LINUX}
  Font.Charset := DEFAULT_CHARSET;
  Font.Name := 'MS Sans Serif';    {Do not Localize}
  BorderStyle := bsDialog;
  {$ELSE}
  Font.Name := 'helvetica';    {Do not Localize}
  BorderStyle := fbsDialog;
  CenterForm;
  {$ENDIF}
    Name := 'formAbout';
    Left := 0;
    Top := 0;
    Anchors := [];//[akLeft, akTop, akRight,akBottom];
    BorderIcons := [biSystemMenu];
    BorderStyle := bsDialog;
    Caption := RSAAboutFormCaption;
    Height := 372;
    ClientWidth := 643;
    Color := clBtnFace;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -11;
    Font.Name := 'Tahoma';
    Font.Style := [];
    OldCreateOrder := False;
    Position := poScreenCenter;
    Scaled := True;
    PixelsPerInch := 96;
  with FimLogo do
  begin
    Name := 'imLogo';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 431;
    Height := 267;
   // AutoSize := True;
    Picture.Bitmap.LoadFromResourceName(HInstance, 'TIDKITCHENSINK');    {Do not Localize}
    Transparent := True;
  end;
  with FlblCopyRight do
  begin
    Name := 'lblCopyRight';
    Parent := Self;
    Left := 438;
    Top := 80;
    Width := 195;
    Height := 75;
    Alignment := taCenter;
    Anchors := [akLeft, akTop, akRight];
    AutoSize := False;
    Caption := RSAAboutBoxCopyright;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -11;
    Font.Name := 'Times New Roman';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    WordWrap := True;
  end;
  with FlblName do
  begin
    Name := 'lblName';
    Parent := Self;
    Left := 438;
    Top := 16;
    Width := 193;
    Height := 49;
    Alignment := taCenter;
    AutoSize := False;
    Anchors := [akLeft, akTop, akRight];
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -19;
    Font.Name := 'Times New Roman';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    WordWrap := True;

  end;
  with FlblVersion do
  begin
    Name := 'lblVersion';
    Parent := Self;
    Left := 438;
    Top := 56;
    Width := 193;
    Height := 13;
    Alignment := taCenter;
    AutoSize := False;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -13;
    Font.Name := 'Times New Roman';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    Anchors := [akLeft, akTop, akRight];
  end;
  with FlblPleaseVisitUs do
  begin
    Name := 'lblPleaseVisitUs';
    Parent := Self;
    Left := 8;
    Top := 271;
    Width := 623;
    Height := 13;
    Alignment := taCenter;
    AutoSize := False;
    Transparent := True;
    Caption := RSAAboutBoxPleaseVisit;
    Anchors := [akLeft, akTop, akRight];
  end;
  with FlblURL do
  begin
    Name := 'lblURL';
    Parent := Self;
    Left := 8;
    Top := 148;  // 288;
    Width := 623;
    Height := 13;
  {$IFNDEF LINUX}
    Font.Name := 'Tahoma';
    Cursor := crHandPoint;
    Font.Color := clBtnHighlight;
    OnClick := lblURLClick;
    Font.Style := [fsUnderline];
    Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}
    Alignment := taCenter;
    AutoSize := False;
    Font.Height := -11;


    ParentFont := False;
    Transparent := True;
    OnClick := lblURLClick;
    Caption := RSAAboutBoxIndyWebsite;
    Anchors := [akLeft, akTop, akRight];
    BringToFront;
  end;
  with FbbtnOk do
  begin
    Name := 'bbtnOk';
    Parent := Self;
    Left := 558;
    Top := 338;
    Width := 75;
    Height := 25;
    Anchors := [akRight, akBottom];
    Cancel := True;
    Default := True;
    ModalResult := 1;
    TabOrder := 0;
    Caption := RSOk;
  end;
end;

{$IFDEF LINUX}
procedure TformAbout.CenterForm;
//workaround for problem - form position does not work like in VCL
begin
 Left := (Screen.Width - Width) div 2;
 Top  := (Screen.Height - Height) div 2;
end;
{$ENDIF}

function TfrmAbout.GetVersion: String;
begin
  Result :=  FlblVersion.Caption;
end;

function TfrmAbout.GetProductName: String;
begin
  Result := FlblName.Caption;
end;

procedure TfrmAbout.lblURLClick(Sender: TObject);
begin
  {$IFNDEF LINUX}
  ShellAPI.shellExecute((Self as TControl).Handle,PChar('open'),PChar(FlblURL.Caption),nil,nil, 0);    {Do not Localize}
              FlblURL.Font.Color := clBtnShadow;
  {$ENDIF}
end;

procedure TfrmAbout.SetVersion(const AValue: String);
begin
  FlblVersion.Caption := AValue;
end;

procedure TfrmAbout.SetProductName(const AValue: String);
begin
  FlblName.Caption := AValue;
end;

end.
