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
  Rev 1.2    1/21/2004 3:27:18 PM  JPMugaas
  InitComponent

  Rev 1.1    4/4/2003 8:02:58 PM  BGooijen
  made host published

  Rev 1.0    11/13/2002 07:59:46 AM  JPMugaas

  -2001.05.18 - J. Peter Mugaas
  I removed the property for forcing client ports
  into a specific range.  This was not necessary
  for Rexec.  It is required for the TIdRSH Component

  -2001.02.15 - J. Peter Mugaas
  I moved most of the Rexec code to
  TIdRemoteCMDClient and TIdRexec now inherits
  from that class.  This change was necessary to
  reduce duplicate code with a new addition, IdRSH.

  -2001.02.14 - J. Peter Mugaas
  Made it more complient with Rexec servers
  and handled the #0 or error indicator

  -2001.02.13 - Modified by Kudzu

  -2000.10.24 - Original Author: Laurence LIew
}

unit IdRexec;

{
  Indy Rexec Client TIdRexec
  Copyright (C) 2001 Winshoes Working Group
  Original author Laurence LIew
  2000-October-24
 }

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdRemoteCMDClient,
  IdTCPClient;

type
  TIdRexec = class(TIdRemoteCMDClient)
  protected
    procedure InitComponent; override;
  public
    Function Execute(ACommand: String): String; override;
  published
    property Username;
    property Password;
    property Port default Id_PORT_exec;
    property Host;
  end;

implementation

uses
  IdComponent,
  IdGlobal,
  IdSimpleServer,
  IdTCPConnection,
  IdThread;

procedure TIdRexec.InitComponent;
begin
  inherited;
  Port := Id_PORT_exec;
  {Rexec does not require ports to be in a specific range}
  FUseReservedPorts := False;
end;

function TIdRexec.Execute(ACommand: String): String;
begin
  Result := InternalExec(UserName,Password,ACommand);
end;

end.
