{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  23932: EmailSender.pas 
{
{   Rev 1.1    01/10/2003 22:30:50  CCostelloe
{ Minor chane
}
{
{   Rev 1.0    26/09/2003 00:04:06  CCostelloe
{ Initial
}
unit EmailSender;

interface

{$I IdCompilerDefines.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
{$IFDEF INDY100}
  IdSASLList, IdUserPassProvider, IdSASLLogin,
{$ENDIF}
  IdSMTP
  ;

type
  TSendEmail = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
{$IFDEF INDY100}
    {This uses a different login system, need extra components (at least for SMTP)...}
    TheSASLList : TIdSASLList;
    ThePassProvider : TIdUserPassProvider;
    TheSASLLogin : TIdSASLLogin;
{$ENDIF}
    TheSmtp : TIdSMTP;
  public
    { Public declarations }
  end;

var
  SendEmail: TSendEmail;

implementation

uses EncoderPlayground;

{$R *.dfm}

procedure TSendEmail.BitBtn1Click(Sender: TObject);
var
    TheParams: TStringList;
begin
    //Send the email...
    if CheckBox1.Checked = True then begin
        //Save the settings...
        TheParams:= TStringList.Create;
        TheParams.Add('SmtpServer='+Edit1.Text);
        TheParams.Add('SmtpUsername='+Edit2.Text);
        TheParams.Add('SmtpPassword='+Edit3.Text);
        TheParams.Add('SmtpTo='+Edit4.Text);
        TheParams.Add('SmtpFrom='+Edit5.Text);
        TheParams.Add('SmtpSubject='+Edit6.Text);
        TheParams.SaveToFile('C:\IndyEncoderSmtp.dat');
        TheParams.Destroy;
    end;
    TheSmtp := TIdSMTP.Create(nil);
{$IFDEF INDY100}
    {This uses a different login system, need extra components (at least for SMTP)...}
    TheSASLList := TIdSASLList.Create(nil);
    ThePassProvider := TIdUserPassProvider.Create(nil);
    TheSASLLogin := TIdSASLLogin.Create(nil);
{$ENDIF}
    TheSmtp.Host := Edit1.Text;
{$IFDEF INDY100}
    {TheSmtp.AuthenticationType := atNone;  {Could use (atNone, atUserPass, atAPOP, atSASL) }
    TheSmtp.SASLMechanisms := TheSASLList;
    ThePassProvider.Username := Edit2.Text;
    ThePassProvider.Password := Edit3.Text;
    TheSASLLogin.UserPassProvider := ThePassProvider;
    TheSASLList.Add(TheSASLLogin);
{$ELSE}
    TheSmtp.Username := Edit2.Text;
    TheSmtp.Password := Edit3.Text;
{$ENDIF}
    formEncoderPlayground.SetupEmail;
    //Add From, To...
    formEncoderPlayground.TheMsg.From.Address := Edit5.Text;
    formEncoderPlayground.TheMsg.Recipients.Add.Address := Edit4.Text;
    formEncoderPlayground.TheMsg.Subject := Edit6.Text;
{$IFDEF INDY100}
    TheSmtp.Connect;
{$ELSE}
    TheSmtp.Connect(30000);
{$ENDIF}
    TheSmtp.Send(formEncoderPlayground.TheMsg);
    TheSmtp.Disconnect;
    ShowMessage('Email apparently successfully sent.');
    ModalResult := mrOK;
end;

procedure TSendEmail.FormActivate(Sender: TObject);
var
    TheParams: TStringList;
begin
    //See if there are saved params to display...
    if FileExists('\IndyEncoderSmtp.dat') = True then begin
        //Save the settings...
        TheParams:= TStringList.Create;
        TheParams.LoadFromFile('C:\IndyEncoderSmtp.dat');
        Edit1.Text := TheParams.Values['SmtpServer'];
        Edit2.Text := TheParams.Values['SmtpUsername'];
        Edit3.Text := TheParams.Values['SmtpPassword'];
        Edit4.Text := TheParams.Values['SmtpTo'];
        Edit5.Text := TheParams.Values['SmtpFrom'];
        Edit6.Text := TheParams.Values['SmtpSubject'];
        TheParams.Destroy;
    end;
end;

end.
