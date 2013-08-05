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
  Rev 1.4    2004.02.03 5:45:08 PM  czhower
  Name changes

  Rev 1.3    1/22/2004 7:10:04 AM  JPMugaas
  Tried to fix AnsiSameText depreciation.

  Rev 1.2    1/21/2004 3:27:52 PM  JPMugaas
  InitComponent

  Rev 1.1    10/23/2003 03:50:52 AM  JPMugaas
  TIdEchoUDP Ported.

  Rev 1.0    11/14/2002 02:19:38 PM  JPMugaas
}

unit IdEchoUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdEchoUDPServer = class(TIdUDPServer)
  protected
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_ECHO;
  end;

implementation

{ TIdEchoUDPServer }

procedure TIdEchoUDPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_ECHO;
end;

procedure TIdEchoUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, AData, ABinding.IPVersion);
end;

end.
