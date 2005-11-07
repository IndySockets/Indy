{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11291: box.dpr 
{
{   Rev 1.0    11/12/2002 09:22:40 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
program box;

uses
  Forms,
  ftplistmain in 'ftplistmain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
