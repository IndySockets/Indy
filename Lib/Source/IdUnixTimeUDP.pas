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
  Rev 1.0    2/10/2005 2:26:38 PM  JPMugaas
  New UnixTime Service (port 519) components.
}

unit IdUnixTimeUDP;

interface

{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers, IdTimeUDP, IdUDPClient;

{
  This is based on a description at
  http://amo.net/AtomicTimeZone/help/ATZS_Protocols.htm#Unix

  UnixTime and UnixTime Protocol
  Unix is an operating system developed in 1969 by Ken Thompson. UnixTime counts
  "epochs" or seconds since the Year 1970. UnixTime recently hit it's billionth
  birthday.

  Because Unix is widely used in many environments, UnixTime was developed into
  a loose simple time protocol in the late 80's and early 90's. No formal
  UnixTime protocol has ever been officially published as an internet protocol -
  until now.

  UnixTime operates on the same UnixTime port - 519. Once a connection is
  requested on this port, exactly like in Time Protocol, the UnixTime value
  is sent back by either tcp/ip or udp/ip. When UDP/IP is used, a small packet
  of data must be received by the server in order to respond in the exact same
  fashion as Time Protocol. The UnixTime is then sent as an unsigned
  "unformatted" integer on the same port.
}

type
  TIdUnixTimeUDP = class(TIdCustomTimeUDP)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  published
    property Port default IdPORT_utime;
  end;

implementation

uses IdGlobalProtocols;

{ TIdTUniximeUDP }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdUnixTimeUDP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdUnixTimeUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_utime;
  FBaseDate := UNIXSTARTDATE;
end;

end.
