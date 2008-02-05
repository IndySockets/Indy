{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11271: RexecTest.pas 
{
    Rev 1.1    4/4/2003 7:54:06 PM  BGooijen
  compiles again
}
{
{   Rev 1.0    11/12/2002 09:19:36 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit RexecTest;

interface
uses
  IndyBox,
  Classes,
  IdContext,
  IdTCPServer,
  IdTCPClient;

type
  TRexecServer = class(TIndyBox)
    procedure DoClient;
    procedure RexecCommand(AContext:TIdContext;
        AStdErr : TIdTCPClient; AUserName, APassword, ACommand : String);
  public
    procedure Test; override;
  end;

implementation
uses IdRexec, IdRexecServer, SysUtils;
{ TRexecServer }

procedure TRexecServer.RexecCommand(AContext:TIdContext;
  AStdErr: TIdTCPClient; AUserName, APassword, ACommand: String);
begin
  AContext.Connection.IOHandler.WriteLn('Listening Port: '+IntToStr(AStdErr.Port ));
  AContext.Connection.IOHandler.WriteLn('User ID:        '+AUserName);
  AContext.Connection.IOHandler.WriteLn('Password:       '+APassword);
  AContext.Connection.IOHandler.WriteLn('Command:        '+ACommand);
end;

procedure TRexecServer.DoClient;
begin
  with TIdRexec.Create(nil) do try
    UserName := 'TESTUSER';
    PassWord := 'PASSWORD';
    Host := '127.0.0.1';
    Status( Execute('TEST /f /s'));
  finally
    Free;
  end;
end;

procedure TRexecServer.Test;
begin
  with TIdRexecServer.Create(nil) do
  try
    OnCommand := RexecCommand;
    Active := True;
    DoClient;
  finally
    Free;
  end;
end;

initialization
  TIndyBox.RegisterBox(TRexecServer, 'Rexec Server', 'Servers');
end.
