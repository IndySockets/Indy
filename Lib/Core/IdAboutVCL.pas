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

    {$IFDEF WIDGET_LCL}
    Picture.Bitmap.LoadFromLazarusResource('IndyCar');//this is XPM format
    {$ENDIF}
    {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
    Picture.Bitmap.LoadFromResourceName(HInstance, 'INDYCAR');    {Do not Localize}
    Transparent := True;
    {$ENDIF}
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
    {$IFDEF WIDGET_VCL}
    Font.Charset := DEFAULT_CHARSET;
    Transparent := True; 
    {$ENDIF}
    Font.Color := clBtnText;
    Font.Height := -16;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
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
    {$IFDEF WIDGET_VCL}
    Font.Charset := DEFAULT_CHARSET;
    Transparent := True;
    {$ENDIF}
    Font.Color := clBtnText;
    Font.Height := -15;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
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
    {$IFDEF WIDGET_VCL}
    Font.Charset := DEFAULT_CHARSET;
    Transparent := True;
    {$ENDIF}
    Font.Color := clBtnText;
    Font.Height := -13;
    Font.Name := 'Verdana';
    Font.Style := [fsBold];
    ParentFont := False;
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
    {$IFDEF WIDGET_VCL}
    Font.Charset := DEFAULT_CHARSET;
    Transparent := True;
    {$ENDIF}
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
    {$IFDEF WIDGET_VCL}
    Font.Charset := DEFAULT_CHARSET;
    Transparent := True;
    {$ENDIF}
    Font.Color := clBlue;
    Font.Height := -13;
    Font.Name := 'Verdana';
    Font.Style := [fsUnderline];
    ParentFont := False;
    OnClick := lblURLClick;
    Caption := RSAAboutBoxIndyWebsite;
    Anchors := [akLeft, akTop, akRight];
    Parent := Self;
  end;
  with FbbtnOk do
  begin
    Name := 'bbtnOk';

    Left := 475;
    {$IFDEF USE_TBitBtn}
    Top := 297;
    {$ELSE}
    Top := 302;
    Height := 25;
    {$ENDIF}
    Width := 75;

    Anchors := [akRight, akBottom];

    {$IFDEF USE_TBitBtn}
     Kind := bkOk;
    {$ELSE}
    Cancel := True;
    Default := True;
    ModalResult := 1;
    Caption := RSOk;
    {$ENDIF}

    TabOrder := 0;
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
  {$IFDEF WIN32}
  ShellAPI.shellExecute(Handle,PChar('open'),PChar(FlblURL.Caption),nil,nil, 0);    {Do not Localize}
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
begin
  with TfrmAbout.Create do
  try
     Version := IndyFormat(RSAAboutBoxVersion, [AProductVersion]);
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

{$IFDEF WIDGET_LCL}
initialization
  {$i IdAboutVCL.lrs}
{$ENDIF}
end.
