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
  Rev 1.6    2/10/2005 2:24:38 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.5    2004.02.03 5:44:36 PM  czhower
  Name changes

  Rev 1.4    1/21/2004 4:21:02 PM  JPMugaas
  InitComponent

  Rev 1.3    10/22/2003 08:48:06 PM  JPMugaas
  Minor code cleanup.

  Rev 1.1    2003.10.12 6:36:46 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:03:28 AM  JPMugaas
}

unit IdTimeUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdCustomTimeUDPServer = class(TIdUDPServer)
  protected
    FBaseDate : TDateTime;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

  TIdTimeUDPServer = class(TIdCustomTimeUDPServer)
  published
    property DefaultPort default IdPORT_TIME;
    {This property is used to set the Date the Time server bases it's
    calculations from.  If both the server and client are based from the same
    date which is higher than the original date, you can extend it beyond the
    year 2035}
    property BaseDate : TDateTime read FBaseDate write FBaseDate;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.SysTime,
  {$ENDIF}
  IdGlobalProtocols, IdStack, SysUtils;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdCustomTimeUDPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdCustomTimeUDPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_TIME;
  {This indicates that the default date is Jan 1, 1900 which was specified
   by RFC 868.}
  FBaseDate := TIME_BASEDATE;
end;

procedure TIdCustomTimeUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LTime : UInt32;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  LTime := Trunc(Extended(LocalTimeToUTCTime(Now) - Int(FBaseDate)) * 24 * 60 * 60);
  LTime := GStack.HostToNetwork(LTime);
  ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(LTime), ABinding.IPVersion);
end;

end.
