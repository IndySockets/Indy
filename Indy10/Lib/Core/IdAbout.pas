{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11902: IdAbout.pas
{
{   Rev 1.11    9/8/2004 5:53:04 AM  JPMugaas
{ Fix for D9 DotNET.  We have to use .resources files instead of .res files in
{ DotNET.
}
{
{   Rev 1.10    8/17/2004 7:07:28 AM  JPMugaas
{ Removed dependancy on WinForms.
}
{
{   Rev 1.9    8/16/2004 12:54:26 PM  JPMugaas
{ Should now work in D8.
}
{
{   Rev 1.8    2/3/2004 11:42:54 AM  JPMugaas
{ Fixed for new design.
}
{
{   Rev 1.7    1/29/2004 8:54:28 AM  JPMugaas
{ Removed myself from the distribution Team Chairperson entry as I am resigning
{ from that role.
}
{
{   Rev 1.6    11/14/2003 3:47:12 AM  JPMugaas
{ Updated with Henrick Hellstrom
}
{
    Rev 1.5    10/15/2003 10:09:36 PM  DSiders
  Added localization comments, resource string in credits.
}
{
{   Rev 1.4    6/8/2003 05:46:02 AM  JPMugaas
{ The kitchen sink has now been implemented.
}
{
{   Rev 1.3    6/5/2003 06:49:02 AM  JPMugaas
{ Bas's name was omitted.
}
{
{   Rev 1.2    6/5/2003 06:27:40 AM  JPMugaas
{ Other personell changes.
}
{
{   Rev 1.1    12/15/2002 08:15:42 PM  JPMugaas
{ Updated due to personell changes.
}
{
{   Rev 1.0    11/13/2002 08:37:18 AM  JPMugaas
}
unit IdAbout;

interface

{$I IdCompilerDefines.inc}
uses
  {$IFDEF LINUX}
  QStdCtrls, QForms, QExtCtrls, QControls, QComCtrls, QGraphics, Types, Qt,
  {$ELSE}
  Windows, Messages, StdCtrls, Buttons, ExtCtrls, Graphics, Controls, ComCtrls, Forms,
  {$ENDIF}
  Classes, SysUtils;

type
  TformAbout = class(TForm)

  private
    { Private declarations }
    imgLogo: TImage;
    {$IFDEF LINUX}
    CreditList:TTextViewer;
    TextStrm : TStream;
    {$ELSE}
    CreditList: TRichEdit;
    {$ENDIF}
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TButton;

    lblCopyright: TLabel;
    lblVersion: TLabel;
    lblName: TLabel;
    lblPleaseVisitUs : TLabel;
    lblKitchenSink : TLabel;
    lblURL : TLabel;
    procedure BeginUpdate;
    procedure AddHeader(const AHeader : String);
    procedure AddEntry(const AName : String; const ACompany: String = '');
    procedure EndUpdate;
    procedure LogoClick(Sender: TObject);
    procedure DoCredits;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    {$IFDEF LINUX}
    //workaround for problem - form position does not work like in VCL
    procedure CenterForm;
    {$ELSE}
    procedure lblURLClick(Sender: TObject);
    {$ENDIF}
    procedure LoadPicRes(const AResName : String);
  end;

var
  formAbout: TformAbout;

Procedure ShowAboutBox(const AProductName, AProductVersion : String);

Procedure ShowDlg;

implementation

uses
  {$IFDEF DOTNET}System.Runtime.InteropServices,System.Reflection, {$ENDIF}
  {$IFNDEF Linux}ShellApi, mmsystem,{$ENDIF}
  IdDsnCoreResourceStrings,
  IdGlobal;

{$IFDEF DOTNET}
const
  ResourceBaseName = 'IdCreditsBitmap';
{$ENDIF}

{$IFNDEF DOTNET}
{$R IdCreditsBitmap.res}
{$ELSE}
{$R IdCreditsBitmap.resources}
{$ENDIF}

Procedure ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

{$IFDEF LINUX}
procedure StrToStream(const AStr : String; AStream : TStream);
begin
  if AStr <> '' then
  begin
    AStream.Write(AStr[1],Length(AStr));
  end;
end;
{$ENDIF}

Procedure ShowAboutBox(const AProductName, AProductVersion : String);
begin
  with TformAbout.Create(Application) do
  try
    lblName.Caption := AProductName;
    lblVersion.Caption := Format ( RSAAboutBoxVersion, [ AProductVersion ] );
    ShowModal;
  finally
    Free;
  end;
end;

{ TformAbout }

procedure TformAbout.AddEntry(const AName : String; const ACompany: String = '');
begin
  {$IFDEF LINUX}
  StrToStream(Format('<P>%s', [AName]), TextStrm);  {do not localize}
  if ACompany = '' then
  begin
    StrToStream('</P>', TextStrm); {do not localize}
  end
  else
  begin
    StrToStream(Format('<BR>%s</P>', [ACompany]), TextStrm); {do not localize}
  end;
  {$ELSE}
  CreditList.Lines.Add(AName);
  if ACompany <> '' then
  begin
    CreditList.Lines.Add(ACompany);
  end;
  CreditList.Lines.Add('');
  {$ENDIF}
end;

procedure TformAbout.AddHeader(const AHeader: String);
begin
  {$IFDEF LINUX}
  StrToStream(Format('<H1>%s</H1>', [AHeader]), TextStrm);  {do not localize}
  {$ELSE}
  CreditList.SelAttributes.Size := 14;
  CreditList.SelAttributes.Style := [fsBold];
  CreditList.Lines.Add(AHeader);
  {$ENDIF}
end;

procedure TformAbout.BeginUpdate;
begin
  {$IFDEF LINUX}
    CreditList.TextColor := clBlack;
  CreditList.Paper.Color := clWhite;
  TextStrm := TMemoryStream.Create;
  StrToStream('<HTML><BODY><CENTER>',TextStrm); {do not localize}
  {$ELSE}

  CreditList.Color := clWHite;
  CreditList.Clear;
  CreditList.Paragraph.Alignment := taCenter;
  CreditList.DefAttributes.Name := 'Arial';     {do not localize}
  CreditList.DefAttributes.Color := clBlack;
  CreditList.DefAttributes.Size := 10;
  CreditList.DefAttributes.Style := [];
  {$ENDIF}
end;

{$IFDEF LINUX}
procedure TformAbout.CenterForm;
//workaround for problem - form position does not work like in VCL
begin
 Left := (Screen.Width - Width) div 2;
 Top  := (Screen.Height - Height) div 2;
end;
{$ENDIF}

constructor TformAbout.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  BorderIcons := [biSystemMenu];
  ClientHeight := 384;
  ClientWidth := 435;
  Position := poScreenCenter;
  Color := clGray;
  Font.Color := clBlack;
  Font.Height := -11;
  {$IFNDEF LINUX}
  Font.Charset := DEFAULT_CHARSET;
  Font.Name := 'MS Sans Serif';    {Do not Localize}
  BorderStyle := bsDialog;
  {$ELSE}
  Font.Name := 'helvetica';    {Do not Localize}
  BorderStyle := fbsDialog;
  CenterForm;
  {$ENDIF}

  Constraints.MaxHeight := Height;
  Constraints.MaxWidth := Width;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;

  Caption := RSAAboutFormCaption;

  ClientWidth := 435;
  PixelsPerInch := 96;
  Font.Style := [];

  imgLogo := TImage.Create(Self);
  imgLogo.Parent := Self;


  imgLogo.AutoSize := True;
  imgLogo.OnClick := Self.LogoClick;
  imgLogo.Top := 8;
  imgLogo.Height := 8;
  imgLogo.Left := 8;
  LoadPicRes('TIDABOUTPICTURE');
  Panel1 := TPanel.Create(Self);
  Panel1.Parent := Self;
  Panel1.BevelOuter := bvNone;
  Panel1.BevelInner := bvNone;
  Panel1.ParentColor := True;
  Panel1.ParentFont := True;
  Panel1.Left := 224;
  Panel1.Top := 8;
  Panel1.Width := 203;
  Panel1.Height := 137;
  Panel1.Anchors := [akLeft,akTop,akRight];

  lblCopyright:= TLabel.Create(Self);
  lblCopyright.Parent := Panel1;
  lblCopyright.Left := 6;
  lblCopyright.Top := 80;
  lblCopyright.Width := 193;
  lblCopyright.Height := 75;
  lblCopyright.Alignment := taCenter;
  lblCopyright.Anchors := [akLeft, akTop, akRight];
  lblCopyright.AutoSize := False;
  lblCopyright.Caption := RSAAboutBoxCopyright;
  lblCopyright.Transparent := True;
  {$IFNDEF LINUX}
  lblCopyright.Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}
  lblCopyright.Font.Height := -11;
  lblCopyright.Font.Style := [];
  lblCopyright.ParentFont := False;
  lblCopyright.Transparent := True;
  lblCopyright.WordWrap := True;
  lblVersion := TLabel.Create(Self);
  lblVersion.Parent := Panel1;
  lblVersion.Left := 6;
  lblVersion.Top := 56;
  lblVersion.Width := 193;
  lblVersion.Height := 26;
  lblVersion.Alignment := taCenter;
  lblVersion.Anchors := [akLeft, akTop, akRight];
  lblVersion.AutoSize := False;
  lblVersion.Transparent := True;
  {$IFNDEF LINUX}
  lblVersion.Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}
  lblVersion.Font.Height := -13;
  lblVersion.Font.Name := 'Times New Roman';    {Do not Localize}
  lblVersion.Font.Style := [fsBold];
  lblVersion.ParentFont := False;
  lblVersion.Transparent := True;
  lblName:= TLabel.Create(Self);
  lblName.Transparent := True;
  lblName.Parent := Panel1;
  lblName.Left := 6;
  lblName.Top := 16;
  lblName.Width := 193;
  lblName.Height := 49;
  lblName.Alignment := taCenter;
  lblName.Anchors := [akLeft, akTop, akRight];
  lblName.AutoSize := False;
  {$IFNDEF LINUX}
  lblName.Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}
  lblName.Font.Height := -19;
  lblName.Font.Name := 'Times New Roman';    {Do not Localize}
  lblName.Font.Style := [fsBold];
  lblName.ParentFont := False;
  lblName.Transparent := True;

  //bottum panel owned controls
  Panel2 := TPanel.Create(Self);
  Panel2.Parent := Self;
  Panel2.Height := 40;
  Panel2.BevelInner := bvNone;
  Panel2.Align := alBottom;
  Panel2.ParentColor := True;
  Panel2.ParentFont := True;
  Panel2.BevelOuter := bvNone;
  Panel2.BevelInner := bvNone;
    {Panel1 owned-controls}
  lblPleaseVisitUs:= TLabel.Create(Self);
  lblPleaseVisitUs.Parent := Panel2;
  lblPleaseVisitUs.Left := 8;
  lblPleaseVisitUs.Top := 4;
  lblPleaseVisitUs.Width := 337; //304;
  lblPleaseVisitUs.Height := 17;
  lblPleaseVisitUs.Alignment := taCenter;
  lblPleaseVisitUs.Anchors := [akLeft, akTop, akRight];
  lblPleaseVisitUs.AutoSize := False;
  {$IFNDEF LINUX}
  lblPleaseVisitUs.Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}

  lblPleaseVisitUs.Font.Height := -11;
  lblPleaseVisitUs.Font.Style := [];
  lblPleaseVisitUs.ParentFont := False;
  lblPleaseVisitUs.Transparent := True;
  lblPleaseVisitUs.Caption := RSAAboutBoxPleaseVisit;
  lblURL:= TLabel.Create(Self);
  lblURL.Parent := Panel2;
  lblURL.AutoSize := False;
  lblURL.Left := 8;
  lblURL.Top := 20;
  lblURL.Width :=  304;
  lblURL.Height := 13;
  lblURL.Anchors := [akLeft, akTop, akRight];
  {$IFNDEF LINUX}
  lblURL.Cursor := crHandPoint;
  lblURL.Font.Color := clRed; //clBtnHighlight;
  lblURL.OnClick := lblURLClick;
  lblURL.Font.Style := [fsUnderline];
  lblURL.Font.Charset := DEFAULT_CHARSET;
  {$ENDIF}
  lblURL.Alignment := taCenter;
  lblURL.Anchors := [akLeft, akTop, akRight];
  lblURL.AutoSize := False;
  lblURL.Font.Height := -11;
  lblURL.ParentFont := False;
  lblURL.Transparent := True;
  lblURL.Caption := RSAAboutBoxIndyWebsite;
  btnOk := TButton.Create(Panel2);
  btnOk.Parent := Panel2;

  btnOk.Left := 352;
  btnOk.Top := 8;
  btnOk.Width := 75;
  btnOk.Height := 25;
  btnOk.Anchors := [akTop, akRight];
  btnOk.Cancel := True;
  btnOk.Caption := RSOk;
  btnOk.Default := True;
  btnOk.ModalResult := 1;
  btnOk.TabOrder := 0;
  {$IFDEF LINUX}
  CreditList := TTextViewer.Create(Self);
  {$ELSE}
  CreditList := TRichEdit.Create(Self);

  CreditList.ReadOnly := True;
  CreditList.ScrollBars := ssVertical;
  {$ENDIF}
  CreditList.Parent := Self;
  CreditList.Left := 8;
  CreditList.Top := 152;
  CreditList.Width := 419;
  CreditList.Height := 192;
  CreditList.Anchors := [akLeft,akTop,akRight,akBottom];
    //easter egg
  lblKitchenSink := TLabel.Create(Self);
  lblKitchenSink.Parent := Self;
  lblKitchenSink.Visible := False;
  lblKitchenSink.Font.Height := -19;
  lblKitchenSink.Font.Name := 'Times New Roman';    {Do not Localize}
  lblKitchenSink.Font.Style := [fsBold];
  lblKitchenSink.Font.Color := clBlack;
  //211 pic height + 16
  lblKitchenSink.AutoSize := False;
  lblKitchenSink.Top := 235;

  lblKitchenSink.Left := 8;
  lblKitchenSink.Width := ClientWidth - 16;
  lblKitchenSink.Caption := RSAAboutKitchenSink;
  lblKitchenSink.Height := ClientHeight - lblKitchenSink.Top - Panel2.Height;

  lblKitchenSink.Alignment := taCenter;
  DoCredits;
end;

procedure TformAbout.DoCredits;
begin
  BeginUpdate;
  AddHeader(RSAAboutCreditsCoordinator);

  AddEntry('Kudzu (Chad Z. Hower)','Atozed Software');        {do not localize}

  AddHeader(RSAAboutCreditsCoCordinator);
  AddEntry('Hadi Hariri','Atozed Software');                  {do not localize}

  AddHeader(RSAAboutCreditsIndyCrew);
  AddEntry('Allen Bauer','Borland Software Corporation');     {do not localize}
  AddEntry('Allen O''Neill','Springboard Technologies Ltd');  {do not localize}
  AddEntry('Andrew Cumming');                                 {do not localize}
  AddEntry('Andrew Neillans','ABCC Computers');               {do not localize}
  AddEntry('Andrew Peter Mee');                               {do not localize}
  AddEntry('Andrew P.Rybin');                                 {do not localize}
  AddEntry('Bas Gooijen');                                    {do not localize}
  AddEntry('Chuck Smith');                                    {do not localize}
  AddEntry('Ciaran Costelloe');                               {do not localize}
  AddEntry('Colin Wilson');                                   {do not localize}
  AddEntry('Darren Kosinski','Borland Software Corporation'); {do not localize}
  AddEntry('Dave Nottage');                                   {do not localize}
  AddEntry('Dennies Chang');                                  {do not localize}
  AddEntry('Don Siders');                                     {do not localize}
  AddEntry('Doychin Bondzhev','Atozed Software');             {do not localize}
  AddEntry('Grahame Grieve','Kestral Computing');             {do not localize}
  AddEntry('Gregor Ibic','Intelicom d.o.o.');                 {do not localize}
  AddEntry('Henrick Hellstrom','StreamSec');                  {do not localize}
  AddEntry('Idan Cohen');                                     {do not localize}
  AddEntry('J. Peter Mugaas');                                {do not localize}
  AddEntry('Jan Pedersen','JPSoft DK');                       {do not localize}
  AddEntry('Jim Gunkel','Nevrona Designs');                   {do not localize}
  AddEntry('Mark Holmes');                                    {do not localize}
  AddEntry('Remy Lebeau');                                    {do not localize}
  AddEntry('Slaven Radic','Poco Systems');                    {do not localize}
  AddEntry('Stephane Grobety');                               {do not localize}
  AddEntry('Sergio Perry');                                   {do not localize}
  AddEntry('Tommi Prami');                                    {do not localize}
  AddEntry('Vladimir Vassiliev');                             {do not localize}

  AddHeader(RSAAboutCreditsDocumentation);
  AddEntry('Don Siders');                                     {do not localize}

  AddHeader(RSAAboutCreditsDemos);
  AddEntry('Allen O''Neill','Springboard Technologies Ltd');  {do not localize}

  // AddHeader('Retired/Inactive Members');
  AddHeader(RSAAboutCreditsRetiredPast);
  AddEntry('Charles Stack');                                  {do not localize}
  AddEntry('Chuck Smith');                                    {do not localize}
  AddEntry('Johannes Berg');                                  {do not localize}
  AddEntry('Rune Moberg');                                    {do not localize}

  EndUpdate;
end;

procedure TformAbout.EndUpdate;
begin
  {$IFDEF LINUX}
  StrToStream('</CENTER></BODY></HTML>',TextStrm); {do not localize}
  CreditList.LoadFromStream(TextStrm);
  FreeAndNil(TextStrm);
  {$ELSE}
  CreditList.SelStart := 0;
  {$ENDIF}
end;
{$IFNDEF LINUX}
procedure TformAbout.lblURLClick(Sender: TObject);
begin

//  ShellAPI.shellExecute((Self as TControl).Handle,PChar('open'),PChar(lblURL.Caption),nil,nil, 0);    {Do not Localize}

end;
{$ENDIF}

procedure TformAbout.LoadPicRes(const AResName: String);
begin
   {$IFDEF DOTNET}
    imgLogo.Picture.Bitmap.LoadFromResourceName(AResName,ResourceBaseName,Assembly.GetExecutingAssembly);
//   imgLogo.Picture.Bitmap.LoadFromResourceName( HINST(Marshal.GetHInstance(Assembly.GetEntryAssembly.GetModules[0])) , AResName);    {Do not Localize}
  {$ELSE}
  imgLogo.Picture.Bitmap.LoadFromResourceName(HInstance, AResName);    {Do not Localize}
  {$ENDIF}
end;

procedure TformAbout.LogoClick(Sender: TObject);
begin
  BeginUpdate;
  try
    if Color = clGray then
    begin
      LoadPicRes('TIDKITCHENSINK');
      imgLogo.AutoSize := True;
      //hight is 221
      Panel1.Hide;
      CreditList.Hide;
      Color := clWhite;
      lblKitchenSink.Show;
    end
    else
    begin
      Color := clGray;
      LoadPicRes('TIDABOUTPICTURE');
      imgLogo.AutoSize := True;
      Panel1.Show;
      CreditList.Show;
      lblKitchenSink.Hide;
      DoCredits;
    end;
  finally
    EndUpdate;
  end;
  {$IFDEF WIN32}
    {$IFNDEF DOTNET}
  if Color = clWhite then
  begin

    PlaySound(PChar('TIDDRAIN'),HInstance,SND_RESOURCE or SND_NOWAIT or SND_ASYNC); {do not localize}
  end;
    {$ENDIF}
  {$ENDIF}
end;

end.
