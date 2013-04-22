unit IdAboutVCL;

interface

{$I IdCompilerDefines.inc}

uses
{$IFDEF WIDGET_KYLIX}
  QStdCtrls, QForms, QExtCtrls, QControls, QComCtrls, QGraphics, Qt,
{$ENDIF}
{$IFDEF WIDGET_VCL_LIKE}
  StdCtrls, Buttons, ExtCtrls, Graphics, Controls, ComCtrls, Forms,
{$ENDIF}
{$IFDEF HAS_UNIT_Types}
  Types,
{$ENDIF}
{$IFDEF WIDGET_LCL}
  LResources,
{$ENDIF}
  Classes, SysUtils;

type
  TfrmAbout = class(TForm)
  protected
    FimLogo : TImage;
    FlblCopyRight : TLabel;
    FlblName : TLabel;
    FlblVersion : TLabel;
    FlblPleaseVisitUs : TLabel;
    FlblURL : TLabel;
    //for LCL, we use a TBitBtn to be consistant with some GUI interfaces
    //and the Lazarus IDE.
    {$IFDEF USE_TBitBtn}
    FbbtnOk : TBitBtn;
    {$ELSE}
    FbbtnOk : TButton;
    {$ENDIF}
    procedure lblURLClick(Sender: TObject);
    function GetProductName: String;
    procedure SetProductName(const AValue: String);
    function GetVersion: String;
    procedure SetVersion(const AValue: String);
  public
    class procedure ShowDlg;
    class procedure ShowAboutBox(const AProductName, AProductVersion: String);
    constructor Create(AOwner : TComponent); overload; override;
    constructor Create; reintroduce; overload; 
    property ProductName : String read GetProductName write SetProductName;
    property Version : String read GetVersion write SetVersion;
  end;

implementation

{$IFNDEF WIDGET_LCL}
  {$IFDEF WIN32}
  {$R IdAboutVCL.RES}
  {$ENDIF}
  {$IFDEF KYLIX}
  {$R IdAboutVCL.RES}
  {$ENDIF}
{$ENDIF}

uses
  {$IFDEF WIN32}ShellApi, {$ENDIF}
  {$IFNDEF WIDGET_LCL}
   //done this way because we reference HInstance in Delphi for loading
   //resources.  Lazarus does something different.  
    {$IFDEF WIN32} 
  Windows,
    {$ENDIF}
  {$ENDIF}
  IdDsnCoreResourceStrings,
  IdGlobal;

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
  {$IFDEF USE_TBitBtn}
  FbbtnOk := TBitBtn.Create(Self);
  {$ELSE}
  FbbtnOk := TButton.Create(Self);
  {$ENDIF}

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

  Font.Color := clBtnText;
  Font.Height := -11;
  Font.Name := 'Tahoma';
  Font.Style := [];
  Position := poScreenCenter;
  {$IFDEF WIDGET_VCL}
  Scaled := True;
  {$ENDIF}
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
  //  PixelsPerInch := 96;

  FimLogo.Name := 'imLogo';
  FimLogo.Parent := Self;
  FimLogo.Left := 0;
  FimLogo.Top := 0;
  FimLogo.Width := 388;
  FimLogo.Height := 240;

  {$IFDEF WIDGET_LCL}
  FimLogo.Picture.Bitmap.LoadFromLazarusResource('IndyCar');//this is XPM format
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  FimLogo.Picture.Bitmap.LoadFromResourceName(HInstance, 'INDYCAR');    {Do not Localize}
  FimLogo.Transparent := True;
  {$ENDIF}

  FlblName.Name := 'lblName';
  FlblName.Parent := Self;
  FlblName.Left := 390;
  FlblName.Top := 8;
  FlblName.Width := 160;
  FlblName.Height := 104;
  FlblName.Alignment := taCenter;
  FlblName.AutoSize := False;
  FlblName.Anchors := [akLeft, akTop, akRight];
  {$IFDEF WIDGET_VCL}
  FlblName.Font.Charset := DEFAULT_CHARSET;
  FlblName.Transparent := True;
  {$ENDIF}
  FlblName.Font.Color := clBtnText;
  FlblName.Font.Height := -16;
  FlblName.Font.Name := 'Verdana';
  FlblName.Font.Style := [fsBold];
  FlblName.ParentFont := False;
  FlblName.WordWrap := True;

  FlblVersion.Name := 'lblVersion';
  FlblVersion.Parent := Self;
  FlblVersion.Left := 390;
  FlblVersion.Top := 72;
  FlblVersion.Width := 160;
  FlblVersion.Height := 40;
  FlblVersion.Alignment := taCenter;
  FlblVersion.AutoSize := False;
  {$IFDEF WIDGET_VCL}
  FlblVersion.Font.Charset := DEFAULT_CHARSET;
  FlblVersion.Transparent := True;
  {$ENDIF}
  FlblVersion.Font.Color := clBtnText;
  FlblVersion.Font.Height := -15;
  FlblVersion.Font.Name := 'Verdana';
  FlblVersion.Font.Style := [fsBold];
  FlblVersion.ParentFont := False;
  FlblVersion.Anchors := [akLeft, akTop, akRight];

  FlblCopyRight.Name := 'lblCopyRight';
  FlblCopyRight.Parent := Self;
  FlblCopyRight.Left := 390;
  FlblCopyRight.Top := 128;
  FlblCopyRight.Width := 160;
  FlblCopyRight.Height := 112;
  FlblCopyRight.Alignment := taCenter;
  FlblCopyRight.Anchors := [akLeft, akTop, akRight];
  FlblCopyRight.AutoSize := False;
  FlblCopyRight.Caption := RSAAboutBoxCopyright;
  {$IFDEF WIDGET_VCL}
  FlblCopyRight.Font.Charset := DEFAULT_CHARSET;
  FlblCopyRight.Transparent := True;
  {$ENDIF}
  FlblCopyRight.Font.Color := clBtnText;
  FlblCopyRight.Font.Height := -13;
  FlblCopyRight.Font.Name := 'Verdana';
  FlblCopyRight.Font.Style := [fsBold];
  FlblCopyRight.ParentFont := False;
  FlblCopyRight.WordWrap := True;

  FlblPleaseVisitUs.Name := 'lblPleaseVisitUs';
  FlblPleaseVisitUs.Parent := Self;
  FlblPleaseVisitUs.Left := 8;
  FlblPleaseVisitUs.Top := 244;
  FlblPleaseVisitUs.Width := 540;
  FlblPleaseVisitUs.Height := 23;
  FlblPleaseVisitUs.Alignment := taCenter;
  FlblPleaseVisitUs.AutoSize := False;
  {$IFDEF WIDGET_VCL}
  FlblPleaseVisitUs.Font.Charset := DEFAULT_CHARSET;
  FlblPleaseVisitUs.Transparent := True;
  {$ENDIF}
  FlblPleaseVisitUs.Font.Height := -13;
  FlblPleaseVisitUs.Font.Name := 'Verdana';
  FlblPleaseVisitUs.Caption := RSAAboutBoxPleaseVisit;
  FlblPleaseVisitUs.Anchors := [akLeft, akTop, akRight];

  FlblURL.Name := 'lblURL';
  FlblURL.Left := 8;
  FlblURL.Top := 260;
  FlblURL.Width := 540;
  FlblURL.Height := 23;
  FlblURL.Cursor := crHandPoint;
  FlblURL.Alignment := taCenter;
  FlblURL.AutoSize := False;
  {$IFDEF WIDGET_VCL}
  FlblURL.Font.Charset := DEFAULT_CHARSET;
  FlblURL.Transparent := True;
  {$ENDIF}
  FlblURL.Font.Color := clBlue;
  FlblURL.Font.Height := -13;
  FlblURL.Font.Name := 'Verdana';
  FlblURL.Font.Style := [fsUnderline];
  FlblURL.ParentFont := False;
  FlblURL.OnClick := lblURLClick;
  FlblURL.Caption := RSAAboutBoxIndyWebsite;
  FlblURL.Anchors := [akLeft, akTop, akRight];
  FlblURL.Parent := Self;

  FbbtnOk.Name := 'bbtnOk';
  FbbtnOk.Left := 475;
  {$IFDEF USE_TBitBtn}
  FbbtnOk.Top := 297;
  {$ELSE}
  FbbtnOk.Top := 302;
  FbbtnOk.Height := 25;
  {$ENDIF}
  FbbtnOk.Width := 75;
  FbbtnOk.Anchors := [akRight, akBottom];
  {$IFDEF USE_TBitBtn}
  FbbtnOk.Kind := bkOk;
  {$ELSE}
  FbbtnOk.Cancel := True;
  FbbtnOk.Default := True;
  FbbtnOk.ModalResult := 1;
  FbbtnOk.Caption := RSOk;
  {$ENDIF}
  FbbtnOk.TabOrder := 0;
  FbbtnOk.Anchors := [akLeft, akTop, akRight];
  FbbtnOk.Parent := Self;
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
  {$IFDEF WIN32}
  ShellAPI.ShellExecute(Handle, PChar('open'), PChar(FlblURL.Caption), nil, nil, 0);    {Do not Localize}
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

class procedure TfrmAbout.ShowAboutBox(const AProductName, AProductVersion: String);
var
  LFrm: TfrmAbout;
begin
  LFrm := TfrmAbout.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
     LFrm.Version := IndyFormat(RSAAboutBoxVersion, [AProductVersion]);
     LFrm.ProductName := AProductName;
     LFrm.ShowModal;
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LFrm.Free;
  end;
  {$ENDIF}
end;

class procedure TfrmAbout.ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

constructor TfrmAbout.Create;
begin
  Create(nil);
end;

{$IFDEF WIDGET_LCL}
initialization
  {$i IdAboutVCL.lrs}
{$ENDIF}
end.
