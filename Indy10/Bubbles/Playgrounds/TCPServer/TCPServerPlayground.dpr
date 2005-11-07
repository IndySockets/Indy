{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17083: TCPServerPlayground.dpr }
{
    Rev 1.0    3/13/2003 6:48:14 PM  BGooijen
}
{
    Rev 1.0    3/13/2003 5:03:20 PM  BGooijen
  Initial check in
}
{
{   Rev 1.3    2003.02.25 1:38:24 AM  czhower
}
{
{   Rev 1.1    2003.01.09 11:24:54 PM  czhower
}
{
{   Rev 1.0    2002.12.07 6:43:44 PM  czhower
}
program TCPServerPlayground;

{

// TODO:
-TIdThreadWeaver.Relinquish; - prob done now
-TIdWorkThread.HandleExceptOps - Can test by stopping web server
-In the future we'll need to add "hints". That is if you want to read 3 lines, before calling readln 3 times we'll call HintReadLn(3) so that the subsystem can operate more efficiently. It wont be required, but it will speed things up a LOT.
-Remove Reads/Writes from TCPConnection
-IOHandler at design time
}

uses
  Forms,
  Main in 'Main.pas' {formMain},
  Global in 'Global.pas',
  IdWorkOpUnits in '..\..\..\Core\IdWorkOpUnits.pas',
  IdServerIOHandlerChain in '..\..\..\Core\IdServerIOHandlerChain.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
