{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16034: boxMLSD.dpr 
{
{   Rev 1.0    2/13/2003 03:04:02 PM  JPMugaas
{ Box tests and capture program for MLSD output.  We handle that separately
{ from regular LIST data.
}
{
{   Rev 1.0    11/12/2002 09:22:40 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
program boxMLSD;

uses
  Forms,
  ftplistmainMLSD in 'ftplistmainMLSD.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
