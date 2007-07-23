{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.2    1/21/2004 3:27:20 PM  JPMugaas
  InitComponent

  Rev 1.1    1/31/2003 02:32:10 PM  JPMugaas
  Should now compile.

  Rev 1.0    11/13/2002 07:59:50 AM  JPMugaas

  2001, Feb  17 - J. Peter Mugaas
    moved much of the code into IdRemoteCMDServer so it can be
    reused in IdRSHServer

  2001, Feb 15 - J. Peter Mugaas
    made methods for error and sucess command results

  2001, Feb 14 - J. Peter Mugaas
    started this unit
}

unit IdRexecServer;

{
  based on
  http://www.winsock.com/hypermail/winsock2/2235.html
  http://www.private.org.il/mini-tcpip.faq.html

  This is based on the IdRexec.pas unit and
  programming comments at http://www.abandoned.org/nemon/rexeclib.py
}

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdContext, IdRemoteCMDServer, IdTCPClient, IdTCPServer;

type
  TIdRexecCommandEvent = procedure (AThread: TIdContext;
   AStdError : TIdTCPClient; AUserName, APassword, ACommand : String) of object;

  TIdRexecServer = class(TIdRemoteCMDServer)
  protected
    FOnCommand : TIdRexecCommandEvent;
    procedure DoCMD(AThread: TIdContext;
     AStdError : TIdTCPClient; AParam1, AParam2, ACommand : String); override;
    procedure InitComponent; override;
  published
    property OnCommand : TIdRexecCommandEvent read FOnCommand write FOnCommand;
    property DefaultPort default Id_PORT_exec;
  end;

implementation

{ TIdRexecServer }

procedure TIdRexecServer.InitComponent;
begin
  inherited;
  DefaultPort := Id_PORT_exec;
  {This variable is defined in the TIdRemoteCMDServer component.  We do not
  use it here because Rexec does not require it.  However, we have to set this to
  to false to disable forcing ports to be in a specific range. The variable in is the
  anscestor because only accepting clients in a specific range would require a change
  to the base component.}
  FForcePortsInRange := False;
  FStdErrorPortsInRange := False;
end;

procedure TIdRexecServer.DoCMD(AThread: TIdContext;
  AStdError: TIdTCPClient; AParam1, AParam2, ACommand: String);
begin
  if Assigned(FOnCommand) then begin
    FOnCommand(AThread,AStdError,AParam1,AParam2,ACommand);
  end;
end;

end.
