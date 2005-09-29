unit IdAboutDotNET;

interface

uses
  System.Drawing, System.Collections, System.ComponentModel,
  System.Windows.Forms, System.Data;

type
  TfrmAbout = class(System.Windows.Forms.Form)
  {$REGION 'Designer Managed Code'}
  strict private
    /// <summary>
    /// Required designer variable.
    /// </summary>
    Components: System.ComponentModel.Container;
    imgLogo: System.Windows.Forms.PictureBox;
    bbtnOk: System.Windows.Forms.Button;
    lblName: System.Windows.Forms.Label;
    lblVersion: System.Windows.Forms.Label;
    lblCopyright: System.Windows.Forms.Label;
    lblPleaseVisitUs: System.Windows.Forms.Label;
    lblURL: System.Windows.Forms.LinkLabel;
    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    procedure InitializeComponent;
    procedure lblURL_LinkClicked(sender: System.Object; e: System.Windows.Forms.LinkLabelLinkClickedEventArgs);
  {$ENDREGION}
  strict protected
    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    procedure Dispose(Disposing: Boolean); override;
  protected
    { Private Declarations }
    function GetProductName: string;
    procedure SetProductName(const AValue: string);
    function GetVersion: string;
    procedure SetVersion(const AValue: string);
    function LoadBitmap(AResName: string): Bitmap;
  public
    constructor Create;
    //we have a method for providing a product name and version in case
    //we ever want to make another prdocut.
    class Procedure ShowAboutBox(const AProductName, AProductVersion : String);
    class Procedure ShowDlg;
   property ProductName : String read GetProductName write SetProductName;
   property Version : String read GetVersion write SetVersion;

  end;

  [assembly: RuntimeRequiredAttribute(TypeOf(TfrmAbout))]

implementation
uses   IdDsnCoreResourceStrings,  System.Diagnostics,
  IdGlobal, IdSys, System.Reflection, System.Resources;

const
  ResourceBaseName = 'IdAboutNET';
{$R 'AboutIndyNET.resources'}

{$AUTOBOX ON}

{$REGION 'Windows Form Designer generated code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TfrmAbout.InitializeComponent;
begin
  Self.imgLogo := System.Windows.Forms.PictureBox.Create;
  Self.bbtnOk := System.Windows.Forms.Button.Create;
  Self.lblName := System.Windows.Forms.Label.Create;
  Self.lblVersion := System.Windows.Forms.Label.Create;
  Self.lblCopyright := System.Windows.Forms.Label.Create;
  Self.lblPleaseVisitUs := System.Windows.Forms.Label.Create;
  Self.lblURL := System.Windows.Forms.LinkLabel.Create;
  Self.SuspendLayout;
  // 
  // imgLogo
  // 
  Self.imgLogo.Location := System.Drawing.Point.Create(0, 0);
  Self.imgLogo.Name := 'imgLogo';
  Self.imgLogo.Size := System.Drawing.Size.Create(431, 267);
  Self.imgLogo.TabIndex := 0;
  Self.imgLogo.TabStop := False;
  // 
  // bbtnOk
  // 
  Self.bbtnOk.Anchor := (System.Windows.Forms.AnchorStyles((System.Windows.Forms.AnchorStyles.Bottom 
    or System.Windows.Forms.AnchorStyles.Right)));
  Self.bbtnOk.DialogResult := System.Windows.Forms.DialogResult.Cancel;
  Self.bbtnOk.Location := System.Drawing.Point.Create(558, 338);
  Self.bbtnOk.Name := 'bbtnOk';
  Self.bbtnOk.TabIndex := 0;
  Self.bbtnOk.Text := 'Button1';
  // 
  // lblName
  // 
  Self.lblName.Font := System.Drawing.Font.Create('Times New Roman', 14.25, System.Drawing.FontStyle.Bold, 
      System.Drawing.GraphicsUnit.Point, (Byte(0)));
  Self.lblName.Location := System.Drawing.Point.Create(438, 16);
  Self.lblName.Name := 'lblName';
  Self.lblName.Size := System.Drawing.Size.Create(193, 72);
  Self.lblName.TabIndex := 1;
  Self.lblName.Text := 'Label1';
  Self.lblName.TextAlign := System.Drawing.ContentAlignment.TopCenter;
  // 
  // lblVersion
  // 
  Self.lblVersion.Font := System.Drawing.Font.Create('Times New Roman', 9.75, 
      System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (Byte(0)));
  Self.lblVersion.Location := System.Drawing.Point.Create(438, 56);
  Self.lblVersion.Name := 'lblVersion';
  Self.lblVersion.Size := System.Drawing.Size.Create(195, 17);
  Self.lblVersion.TabIndex := 2;
  Self.lblVersion.Text := 'Label2';
  Self.lblVersion.TextAlign := System.Drawing.ContentAlignment.TopCenter;
  // 
  // lblCopyright
  // 
  Self.lblCopyright.Font := System.Drawing.Font.Create('Times New Roman', 8, 
      System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (Byte(0)));
  Self.lblCopyright.Location := System.Drawing.Point.Create(438, 104);
  Self.lblCopyright.Name := 'lblCopyright';
  Self.lblCopyright.Size := System.Drawing.Size.Create(193, 75);
  Self.lblCopyright.TabIndex := 3;
  Self.lblCopyright.Text := 'Label3';
  Self.lblCopyright.TextAlign := System.Drawing.ContentAlignment.TopCenter;
  // 
  // lblPleaseVisitUs
  // 
  Self.lblPleaseVisitUs.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Left) or System.Windows.Forms.AnchorStyles.Right)));
  Self.lblPleaseVisitUs.Location := System.Drawing.Point.Create(8, 280);
  Self.lblPleaseVisitUs.Name := 'lblPleaseVisitUs';
  Self.lblPleaseVisitUs.Size := System.Drawing.Size.Create(623, 13);
  Self.lblPleaseVisitUs.TabIndex := 4;
  Self.lblPleaseVisitUs.Text := 'Label1';
  Self.lblPleaseVisitUs.TextAlign := System.Drawing.ContentAlignment.TopCenter;
  // 
  // lblURL
  // 
  Self.lblURL.Anchor := (System.Windows.Forms.AnchorStyles(((System.Windows.Forms.AnchorStyles.Top 
    or System.Windows.Forms.AnchorStyles.Left) or System.Windows.Forms.AnchorStyles.Right)));
  Self.lblURL.Location := System.Drawing.Point.Create(8, 296);
  Self.lblURL.Name := 'lblURL';
  Self.lblURL.Size := System.Drawing.Size.Create(623, 13);
  Self.lblURL.TabIndex := 5;
  Self.lblURL.TabStop := True;
  Self.lblURL.Text := 'LinkLabel1';
  Self.lblURL.TextAlign := System.Drawing.ContentAlignment.TopCenter;
  Include(Self.lblURL.LinkClicked, Self.lblURL_LinkClicked);
  // 
  // TfrmAbout
  // 
  Self.AcceptButton := Self.bbtnOk;
  Self.AutoScaleBaseSize := System.Drawing.Size.Create(5, 13);
  Self.CancelButton := Self.bbtnOk;
  Self.ClientSize := System.Drawing.Size.Create(637, 372);
  Self.Controls.Add(Self.lblURL);
  Self.Controls.Add(Self.lblPleaseVisitUs);
  Self.Controls.Add(Self.lblCopyright);
  Self.Controls.Add(Self.lblVersion);
  Self.Controls.Add(Self.lblName);
  Self.Controls.Add(Self.bbtnOk);
  Self.Controls.Add(Self.imgLogo);
  Self.FormBorderStyle := System.Windows.Forms.FormBorderStyle.FixedDialog;
  Self.MaximizeBox := False;
  Self.MinimizeBox := False;
  Self.Name := 'TfrmAbout';
  Self.ShowInTaskbar := False;
  Self.StartPosition := System.Windows.Forms.FormStartPosition.CenterScreen;
  Self.Text := 'WinForm';
  Self.ResumeLayout(False);
end;
{$ENDREGION}

procedure TfrmAbout.Dispose(Disposing: Boolean);
begin
  if Disposing then
  begin
    if Components <> nil then
      Components.Dispose();
  end;
  inherited Dispose(Disposing);
end;

constructor TfrmAbout.Create;
var LBitmap : Bitmap;
begin
  inherited Create;
  //
  // Required for Windows Form Designer support
  //
  InitializeComponent;
  //
  // TODO: Add any constructor code after InitializeComponent call
  //
  Self.Text := RSAAboutFormCaption;
   lblCopyright.Text := RSAAboutBoxCopyright;
  lblPleaseVisitUs.Text := RSAAboutBoxPleaseVisit;
  lblURL.Text := RSAAboutBoxIndyWebsite;
  lblURL.Links.Add(0,Length(RSAABoutBoxIndyWebsite),RSAAboutBoxIndyWebsite);
  bbtnOk.Text := RSOk;
  LBitmap :=  LoadBitmap('IndyCar.bmp');
  LBitmap.MakeTransparent;
  imgLogo.Image := LBitmap;
end;

procedure TfrmAbout.SetProductName(const AValue : String);
begin
  Self.lblName.Text := AValue;
end;

procedure TfrmAbout.SetVersion(const AValue: string);
begin
   Self.lblVersion.Text := AValue;
end;

function TfrmAbout.GetVersion: string;

begin
  Result := Self.lblVersion.Text;
end;

function TfrmAbout.GetProductName: string;

begin
  Result := Self.lblName.Text;
end;

class procedure TfrmAbout.ShowAboutBox(const AProductName,
  AProductVersion: String);
begin
  with TfrmAbout.Create do
  try
     Version := Sys.Format ( RSAAboutBoxVersion, [AProductVersion] );
     ProductName := AProductName;
     Text := AProductName;
     ShowDialog;
  finally
    Dispose;
  end;
end;

class procedure TfrmAbout.ShowDlg;
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
end;

procedure TfrmAbout.lblURL_LinkClicked(sender: System.Object; e: System.Windows.Forms.LinkLabelLinkClickedEventArgs);
var LDest : String;
begin
  LDest := e.Link.LinkData as string;
   System.Diagnostics.Process.Start(LDest);
    e.Link.Visited := True;
end;

function TfrmAbout.LoadBitmap(AResName: string): Bitmap;
var
  LR: System.Resources.ResourceManager;

begin
  LR := System.Resources.ResourceManager.Create('AboutIndyNET', System.Reflection.Assembly.GetExecutingAssembly);
  Result := (Bitmap(LR.GetObject('IndyCar.bmp')));
  Result := Result;
end;


end.
