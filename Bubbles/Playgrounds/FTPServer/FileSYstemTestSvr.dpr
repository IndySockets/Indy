{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17159: FileSYstemTestSvr.dpr 
{
{   Rev 1.0    3/14/2003 06:59:16 PM  JPMugaas
{ FTPFileSystem Test program.
}
program FileSYstemTestSvr;

uses
  Forms,
  FileSYstemTestMain in 'FileSYstemTestMain.pas' {frmServer},
  IdFTPBaseFileSystem in '..\..\source\Indy10\IdFTPBaseFileSystem.pas',
  IdFTPServer in '..\..\source\Indy10\IdFTPServer.pas',
  IdFTPFileSystem in '..\..\source\Indy10\IdFTPFileSystem.pas',
  IdFTPList in '..\..\source\Indy10\IdFTPList.pas',
  IdFTPListOutput in '..\..\source\Indy10\IdFTPListOutput.pas',
  IdSync in '..\..\source\Indy10\Core\IdSync.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmServer, frmServer);
  Application.Run;
end.
