{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11293: capture.dpr 
{
{   Rev 1.0    11/12/2002 09:23:06 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
program capture;

uses
  Forms,
  capturemain in 'capturemain.pas' {frmCapture};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCapture, frmCapture);
  Application.Run;
end.
