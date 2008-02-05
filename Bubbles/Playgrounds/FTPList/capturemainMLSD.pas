{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16038: capturemainMLSD.pas 
{
{   Rev 1.0    2/13/2003 03:04:10 PM  JPMugaas
{ Box tests and capture program for MLSD output.  We handle that separately
{ from regular LIST data.
}
{
{   Rev 1.0    11/12/2002 09:23:10 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit capturemainMLSD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdIntercept, IdLogBase, IdLogEvent, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP, IdFTPList;

type
  TfrmCapture = class(TForm)
    mmoLog: TMemo;
    chkUsePasv: TCheckBox;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtHost: TEdit;
    edtFileName: TEdit;
    lblHost: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblCaptureFileName: TLabel;
    btnGo: TButton;
    btnBrowse: TButton;
    svdlgCapture: TSaveDialog;
    IdFTPCapture: TIdFTP;
    IdLog: TIdLogEvent;
    edtRemoteDir: TEdit;
    lblRemoteDir: TLabel;
    edtParams: TEdit;
    lblParameters: TLabel;
    procedure btnBrowseClick(Sender: TObject);
    procedure IdLogReceived(ASender: TComponent; const AText,
      AData: String);
    procedure IdLogSent(ASender: TComponent; const AText, AData: String);
    procedure btnGoClick(Sender: TObject);
    procedure IdFTPCaptureCheckListFormat(ASender: TObject;
      const ALine: String; var VListFormat: TIdFTPListFormat);
    procedure IdFTPCaptureParseCustomListFormat(AItem: TIdFTPListItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCapture: TfrmCapture;

implementation

{$R *.dfm}

procedure TfrmCapture.btnBrowseClick(Sender: TObject);
begin
  svdlgCapture.FileName := edtFileName.Text;
  if svdlgCapture.Execute then
  begin
    edtFileName.Text := svdlgCapture.FileName;
  end;
end;

procedure TfrmCapture.IdLogReceived(ASender: TComponent; const AText,
  AData: String);
begin
  mmoLog.Lines.Add('Received:   '+AData);
end;

procedure TfrmCapture.IdLogSent(ASender: TComponent; const AText,
  AData: String);
begin
  mmoLog.Lines.Add('Sent:       '+AData);
end;

procedure TfrmCapture.btnGoClick(Sender: TObject);
var s : TStrings;
begin
  IdFTPCapture.Host := edtHost.Text;
  IdFTPCapture.Username := edtUsername.Text;
  IdFTPCapture.Password := edtPassword.Text;
  IdFTPCapture.Passive := chkUsePasv.Checked;
  IdFTPCapture.Connect;
  try
    s := TStringList.Create;
    try
      if edtRemoteDir.Text <> '' then
      begin
        IdFTPCapture.ChangeDir(edtRemoteDir.Text);
      end;
      IdFTPCapture.List(s,edtParams.Text);
      s.SaveToFile(edtFileName.Text);
    finally
      FreeAndNil(s);
    end;
  finally
    IdFTPCapture.Disconnect;
  end;
end;

procedure TfrmCapture.IdFTPCaptureCheckListFormat(ASender: TObject;
  const ALine: String; var VListFormat: TIdFTPListFormat);
begin
  //
end;

procedure TfrmCapture.IdFTPCaptureParseCustomListFormat(
  AItem: TIdFTPListItem);
begin
  //
end;

end.
