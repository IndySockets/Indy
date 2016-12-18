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
  Rev 1.6    7/21/04 3:14:04 PM  RLebeau
  Removed local Buffer variable from TIdMappedPortUDP.DoUDPRead(), not needed

  Rev 1.5    2004.02.03 5:44:00 PM  czhower
  Name changes

  Rev 1.4    2/2/2004 4:20:30 PM  JPMugaas
  Removed warning from Delphi 8.  It now should compile in DotNET.

  Rev 1.3    1/21/2004 3:11:34 PM  JPMugaas
  InitComponent

  Rev 1.2    10/25/2003 06:52:14 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.1    2003.10.24 10:38:28 AM  czhower
  UDP Server todos

  Rev 1.0    11/13/2002 07:56:46 AM  JPMugaas
}

unit IdMappedPortUDP;

interface

{$i IdCompilerDefines.inc}

{
  - Syncronized with Indy standards by Gregor Ibic
  - Original DNS mapped port by Gregor Ibic
}

uses
  Classes,
  IdGlobal,
  IdUDPServer,
  IdSocketHandle,
  IdGlobalProtocols;

type
  TIdMappedPortUDP = class(TIdUDPServer)
  protected
    FMappedPort: TIdPort;
    FMappedHost: String;
    FOnRequest: TNotifyEvent;
    //
    procedure DoRequestNotify; virtual;
    procedure InitComponent; override;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
  published
    property MappedHost: string read FMappedHost write FMappedHost;
    property MappedPort: TIdPort read FMappedPort write FMappedPort;
    property OnRequest: TNotifyEvent read FOnRequest write FOnRequest;
  end;

implementation

uses
  IdAssignedNumbers,
  IdUDPClient, SysUtils;

procedure TIdMappedPortUDP.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DOMAIN;
end;

procedure TIdMappedPortUDP.DoRequestNotify;
begin
  if Assigned(OnRequest) then begin
    OnRequest(Self);
  end;
end;

procedure TIdMappedPortUDP.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LClient: TIdUDPClient;
  LData: TIdBytes;
  i: Integer;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  DoRequestNotify;
  LClient := TIdUDPClient.Create(nil);
  try
    LClient.Host := FMappedHost;
    LClient.Port := FMappedPort;
    LClient.SendBuffer(AData);
    SetLength(LData, LClient.BufferSize);
    i := LClient.ReceiveBuffer(LData);
    if i > 0 then begin
      SetLength(LData, i);
      ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, LData, 0, i, ABinding.IPVersion);
    end;
  finally
    FreeAndNil(LClient);
  end;
end;

end.
