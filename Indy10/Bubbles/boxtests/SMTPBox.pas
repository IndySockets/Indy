{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11273: SMTPBox.pas 
{
{   Rev 1.0    11/12/2002 09:19:42 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit SMTPBox;

interface

uses
 IndyBox;

type
  TSMTPBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  IdMessage, IdSMTP,
  SysUtils;

var
  GSMTP: string = '';
  GEMailAddr: string = '';

{ TSMTPBox }

procedure TSMTPBox.Test;
var
  LMsg: TIdMessage;
begin
  LMsg := TIdMessage.Create(nil); try
    with LMsg do begin
      From.Address := GlobalParamValue('EMail Address');
      Recipients.Add.Address := From.Address;
      Subject := 'SMTP Box Test';
      Body.Add('Hello this is a test message from the SMTP Box.');
      Check(Body.Count = 1, 'Body line count mismatch.');
    end;
    with TIdSMTP.Create(nil) do try
      Host := GlobalParamValue('SMTP Server');
      Connect; try
        Status('Connected to ' + Host);
        Check(Connected, 'Connected does not reflect properly.');
        Send(LMsg);
        Status('Message sent to ' + LMsg.Recipients[0].Address);
      finally Disconnect; end;
      Status('Disconnected.');
      Check(not Connected, 'Connected does not reflect properly.');
    finally Free; end;
  finally FreeAndNil(LMsg); end;
end;

initialization
  TIndyBox.RegisterBox(TSMTPBox, 'SMTP Client', 'Clients');
end.
