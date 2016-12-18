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
  Rev 1.4    2004.02.03 5:44:14 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 3:27:16 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 02:54:56 PM  JPMugaas
  These should now work with the new code.

  Rev 1.1    2003.10.24 10:38:30 AM  czhower
  UDP Server todos

  Rev 1.0    11/13/2002 07:58:52 AM  JPMugaas
}

unit IdQOTDUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdQotdUDPGetEvent = procedure (ABinding: TIdSocketHandle; var AQuote : String) of object;
  TIdQotdUDPServer = class(TIdUDPServer)
  protected
    FOnCommandQOTD : TIdQotdUDPGetEvent;
    procedure DoOnCommandQUOTD(ABinding: TIdSocketHandle; var AQuote : String); virtual;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_QOTD;
    property OnCommandQOTD : TIdQotdUDPGetEvent read FOnCommandQOTD write FOnCommandQOTD;
  end;

implementation

{ TIdQotdUDPServer }

procedure TIdQotdUDPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_QOTD;
end;

procedure TIdQotdUDPServer.DoOnCommandQUOTD(ABinding: TIdSocketHandle; var AQuote : String);
begin
  if Assigned(FOnCommandQOTD) then
  begin
    FOnCommandQOTD(ABinding, AQuote);
  end;
end;

procedure TIdQotdUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s : String;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  s := '';    {Do not Localize}
  DoOnCommandQUOTD(ABinding, s);
  if Length(s) > 0 then
  begin
    ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(s), ABinding.IPVersion);
  end;
end;

end.

