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
  Rev 1.2    1/21/2004 3:27:22 PM  JPMugaas
  InitComponent

  Rev 1.1    1/31/2003 02:32:14 PM  JPMugaas
  Should now compile.

  Rev 1.0    11/13/2002 08:00:02 AM  JPMugaas
}

unit IdRSHServer;

{
  based on
  http://www.private.org.il/mini-tcpip.faq.html

  2001, Feb  17 - J. Peter Mugaas
    based this unit on the simplied IdRexec unit with extremely
    minor modifications (the parameters for our event had to be modified
    to better represent what they are in this protocol.  The only difference
    between this protocol and Rexec is that the server handles authoriation
    differently and the port is different.  In RSH, authentication is usually
    done by refusing connections from ports which are NOT reserved, and from
    .rhosts files in Unix.

  WARNING:
    RSH should ONLY be considered for computer systems behind a firewall as there
    are no passwords and it is easy to falsify user names (you even have to evesdrop
    on network traffic to do it. Even then, you should consider other protocols.

    You assume any and all risks involved with RSH.

    !!!YOU HAVE BEEN WANRED!!!

    The only reason we provide this component is to complement the RSH client
    and it does have one merit (CVS is partly based on it).  I personally have
    agonized over writing this component at all due to these risks.
}

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdContext, IdRemoteCMDServer, IdTCPClient, IdTCPServer;

const
  RSH_FORCEPORTSINRANGE = True;

type
  TIdRSHCommandEvent = procedure (AThread: TIdContext;
   AStdError : TIdTCPClient; AClientUserName, AHostUserName, ACommand : String) of object;

  TIdRSHServer = class(TIdRemoteCMDServer)
  protected
    FOnCommand : TIdRSHCommandEvent;
    //
    procedure DoCMD(AThread: TIdContext;
     AStdError : TIdTCPClient; AParam1, AParam2, ACommand : String); override;
    procedure InitComponent; override;
  published
    property OnCommand : TIdRSHCommandEvent read FOnCommand write FOnCommand;
    property DefaultPort default IdPORT_cmd;
    property ForcePortsInRange : Boolean read FForcePortsInRange write FForcePortsInRange default RSH_FORCEPORTSINRANGE;
  end;

implementation

{ TIdRSHServer }

procedure TIdRSHServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_cmd;
  FForcePortsInRange := RSH_FORCEPORTSINRANGE;
  FStdErrorPortsInRange := True;
end;

procedure TIdRSHServer.DoCMD(AThread: TIdContext;
  AStdError: TIdTCPClient; AParam1, AParam2, ACommand: String);
begin
  if Assigned(FOnCommand) then begin
    FOnCommand(AThread,AStdError,AParam1,AParam2,ACommand);
  end;
end;

end.
