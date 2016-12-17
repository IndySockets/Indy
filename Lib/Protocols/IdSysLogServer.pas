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
  Rev 1.4    2004.02.03 5:44:28 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 4:04:02 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 01:58:34 PM  JPMugaas
  Attempt to port Syslog over to new code.

  Rev 1.1    2003.10.24 10:38:30 AM  czhower
  UDP Server todos

  Rev 1.0    11/13/2002 08:02:20 AM  JPMugaas
}

{
  IdSyslogServer component
  Server-side implementation of the RFC 3164 "The BSD syslog Protocol"
  Original Author: Stephane Grobety (grobety@fulgan.com)
  Copyright the Indy pit crew
  Release history:
  08/09/01: Dev started
}

unit IdSysLogServer;

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdBaseComponent,
  IdComponent,
  IdGlobal,
  IdException,
  IdSocketHandle,
  IdStackConsts,
  IdThread,
  IdUDPBase,
  IdUDPServer,
  IdSysLogMessage,
  IdSysLog;

type
  TOnSyslogEvent = procedure(Sender: TObject; ASysLogMessage: TIdSysLogMessage;
    ABinding: TIdSocketHandle) of object;

  TIdSyslogServer = class(TIdUDPServer)
  protected
    FOnSyslog: TOnSyslogEvent;
    //
    procedure DoSyslogEvent(AMsg: TIdSysLogMessage; ABinding: TIdSocketHandle); virtual;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_syslog;
    property OnSyslog: TOnSyslogEvent read FOnSyslog write FOnSysLog;
  end;

implementation

uses
  SysUtils;

{ TIdSyslogServer }

procedure TIdSyslogServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LMsg: TIdSysLogMessage;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  LMsg := TIdSysLogMessage.Create(Self);
  try
    LMsg.ReadFromBytes(AData, ABinding.PeerIP);
  //  ReadFromStream(AData, (AData as TMemoryStream).Size, ABinding.PeerIP);
    DoSyslogEvent(LMsg, ABinding);
  finally
    FreeAndNil(LMsg)
  end;
end;

procedure TIdSyslogServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_syslog;
end;

procedure TIdSyslogServer.DoSyslogEvent(AMsg: TIdSysLogMessage; ABinding: TIdSocketHandle);
begin
  if Assigned(FOnSyslog)  and assigned(AMsg)then begin
    FOnSyslog(Self, AMsg, ABinding);
  end;
end;

end.
