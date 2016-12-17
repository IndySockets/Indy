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
  Rev 1.4    2004.02.03 5:45:04 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 2:12:44 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 02:54:52 PM  JPMugaas
  These should now work with the new code.

  Rev 1.1    2003.10.24 10:38:24 AM  czhower
  UDP Server todos

  Rev 1.0    11/14/2002 02:17:18 PM  JPMugaas
}

unit IdDayTimeUDPServer;

interface
{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdDayTimeUDPServer = class(TIdUDPServer)
  protected
    FTimeZone : String;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  published
    property TimeZone: String read FTimeZone write FTimeZone;
    property DefaultPort default IdPORT_DAYTIME;
  end;

implementation

uses
  SysUtils;

{ TIdDayTimeUDPServer }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDayTimeUDPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDayTimeUDPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DAYTIME;
  FTimeZone := 'EST';  {Do not Localize}
end;

procedure TIdDayTimeUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s : String;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  s := FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss', Now) + ' -' + FTimeZone;  {Do not Localize}
  ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(s), ABinding.IPVersion);
end;

end.

