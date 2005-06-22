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
    class procedure ShowDlg;
    class procedure ShowAboutBox(const AProductName, AProductVersion: String);
    constructor Create(AOwner : TComponent); overload; override;
    constructor Create; overload; 
    property ProductName : String read GetProductName write SetProductName;
    property Version : String read GetVersion write SetVersion;
  end;

Procedure ShowAboutBox(const AProductName, AProductVersion : String);
Procedure ShowDlg;

implementation
{$R IdAboutVCL.RES}
uses
  {$IFNDEF Linux}ShellApi, {$ENDIF}
  IdDsnCoreResourceStrings,
  IdGlobal,
  IdSys;

Procedure ShowAboutBox(const AProductName, AProductVersion : String);
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

Procedure ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

{ TfrmAbout }

constructor TfrmAbout.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner,0);

  FimLogo := TImage.Create(Self);
  FlblCopyRight := TLabel.Create(Self);
  FlblName := TLabel.Create(Self);
  FlblVersion := TLabel.Create(Self);
  FlblPleaseVisitUs := TLabel.Create(Self);
  FlblURL := TLabel.Create(Self);
  FbbtnOk := TButton.Create(Self);

    Name := 'formAbout';
    Left := 0;
    Top := 0;
    Anchors := [];//[akLeft, akTop, akRight,akBottom];
    BorderIcons := [biSystemMenu];
    BorderStyle := bsDialog;

    Caption := RSAAboutFormCaption;
    ClientHeight := 336;
    ClientWidth := 554;
    Color := clBtnFace;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -11;
    Font.Name := 'Tahoma';
    Font.Style := [];
    OldCreateOrder := False;
    Position := poScreenCenter;
    Scaled := True;
    Self.Constraints.MinHeight := Height;
     Self.Constraints.MinWidth := Width;
  //  PixelsPerInch := 96;
  with FimLogo do
  begin
    Name := 'imLogo';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 388;
    Height := 240;
   // AutoSize := True;
    Picture.Bitmap.LoadFromResourceName(HInstance, 'INDYCAR');    {Do not Localize}
    Transparent := True;
  end;
  with FlblName do
  begin
    Name := 'lblName';
    Parent := Self;
    Left := 390;
    Top := 8;
    Width := 160;
    Height := 104;
    Alignment := taCenter;
    AutoSize := False;
    Anchors := [akLeft, akTop, akRight];
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -16;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    WordWrap := True;

  end;
  with FlblVersion do
  begin
    Name := 'lblVersion';
    Parent := Self;
    Left := 390;
    Top := 72;
    Width := 160;
    Height := 40;
    Alignment := taCenter;
    AutoSize := False;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -15;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    Anchors := [akLeft, akTop, akRight];
  end;
  with FlblCopyRight do
  begin
    Name := 'lblCopyRight';
    Parent := Self;
    Left := 390;
    Top := 128;
    Width := 160;
    Height := 112;
    Alignment := taCenter;
    Anchors := [akLeft, akTop, akRight];
    AutoSize := False;
    Caption := RSAAboutBoxCopyright;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBtnText;
    Font.Height := -13;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
    Transparent := True;
    WordWrap := True;
  end;


  with FlblPleaseVisitUs do
  begin
    Name := 'lblPleaseVisitUs';
    Parent := Self;
    Left := 8;
    Top := 244;
    Width := 540;
    Height := 23;
    Alignment := taCenter;
    AutoSize := False;
    Transparent := True;
    Font.Height := -13;
    Font.Name := 'Verdana';
    Caption := RSAAboutBoxPleaseVisit;
    Anchors := [akLeft, akTop, akRight];
  end;
  with FlblURL do
  begin
    Name := 'lblURL';
    Left := 8;
    Top := 260;
    Width := 540;
    Height := 23;

    Cursor := crHandPoint;
    Alignment := taCenter;
    AutoSize := False;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlue;
    Font.Height := -13;
    Font.Name := 'Verdana';
    Font.Style := [fsUnderline];
    ParentFont := False;
   Transparent := True;
    OnClick := lblURLClick;
    Caption := RSAAboutBoxIndyWebsite;
    Anchors := [akLeft, akTop, akRight];
    Parent := Self;
  end;
  with FbbtnOk do
  begin
    Name := 'bbtnOk';

    Left := 475;
    Top := 302;
    Width := 75;
    Height := 25;
    Anchors := [akRight, akBottom];
    Cancel := True;
    Default := True;
    ModalResult := 1;
    TabOrder := 0;
     Caption := RSOk;
    Anchors := [akLeft, akTop, akRight];
    Parent := Self;

  end;
end;

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
  {$IFDEF MSWINDOWS}
  ShellAPI.shellExecute((Self as TControl).Handle,PChar('open'),PChar(FlblURL.Caption),nil,nil, 0);    {Do not Localize}
  FlblURL.Font.Color := clPurple;
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

class procedure TfrmAbout.ShowAboutBox(const AProductName,
  AProductVersion: String);
begin
  with TfrmAbout.Create do
  try
     Version := Sys.Format ( RSAAboutBoxVersion, [AProductVersion] );
     ProductName := AProductName;
     ShowModal;
  finally
    Free;
  end;
end;

class procedure TfrmAbout.ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

constructor TfrmAbout.Create;
begin
  Create(nil);
end;

end.
