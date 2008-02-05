{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16036: captureMLSD.dpr 
{
{   Rev 1.0    2/13/2003 03:04:06 PM  JPMugaas
{ Box tests and capture program for MLSD output.  We handle that separately
{ from regular LIST data.
}
{
{   Rev 1.0    11/12/2002 09:23:06 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
program captureMLSD;

uses
  Forms,
  capturemainMLSD in 'capturemainMLSD.pas' {frmCapture};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCapture, frmCapture);
  Application.Run;
end.
