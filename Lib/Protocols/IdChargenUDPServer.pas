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
  Rev 1.4    2004.02.03 5:44:56 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 1:49:36 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 02:54:50 PM  JPMugaas
  These should now work with the new code.

  Rev 1.1    2003.10.24 10:38:24 AM  czhower
  UDP Server todos

  Rev 1.0    11/14/2002 02:14:08 PM  JPMugaas

  2001 - Sep 17
    J. Peter Mugaas
      Started this with code from Rune Moburg's UDP Chargen Server
}

unit IdChargenUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdChargenUDPServer = class(TIdUDPServer)
  protected
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_CHARGEN;
  end;

implementation

{ TIdChargenUDPServer }

procedure TIdChargenUDPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_CHARGEN;
end;

procedure TIdChargenUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
const
  rowlength = 75;
var
  s: string;
  i, row, ln : integer;
  c: Char;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  i := 1;
  c := '0';     {Do not Localize}
  s := '';       {Do not Localize}
  ln := Random(512);
  Row := 0;
  while i <= ln do
  begin
    if c > #95 then
    begin
      c := '0';   {Do not Localize}
    end;
    if i mod (rowlength + 1) = 0 then
    begin
      s := s + #13;
      c := chr(ord('0') + row mod (95 - ord('0')));   {Do not Localize}
      inc(row);
    end
    else
    begin
      s := s + c;
    end;
    inc(i);
    inc(c);
  end;
  ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(s), ABinding.IPVersion);
end;

end.
