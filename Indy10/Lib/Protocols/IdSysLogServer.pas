{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11771: IdSysLogServer.pas 
{
{   Rev 1.4    2004.02.03 5:44:28 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/21/2004 4:04:02 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    10/24/2003 01:58:34 PM  JPMugaas
{ Attempt to port Syslog over to new code.
}
{
{   Rev 1.1    2003.10.24 10:38:30 AM  czhower
{ UDP Server todos
}
{
{   Rev 1.0    11/13/2002 08:02:20 AM  JPMugaas
}
////////////////////////////////////////////////////////////////////////////////
//  IdSyslogServer component
//  Server-side implementation of the RFC 3164 "The BSD syslog Protocol"
//  Original Author: Stephane Grobety (grobety@fulgan.com)
//  Copyright the Indy pit crew
//  Release history:
//  08/09/01: Dev started

unit IdSysLogServer;

interface

uses
  Classes,
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
    procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_syslog;
    property OnSyslog: TOnSyslogEvent read FOnSyslog write FOnSysLog;
  end;

implementation
uses IdSys;

{ TIdSyslogServer }

procedure TIdSyslogServer.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
//DoUDPRead(AData: TStream; ABinding: TIdSocketHandle);
var
  LMsg: TIdSysLogMessage;
begin
  inherited DoUDPRead(AData,ABinding);
  LMsg := TIdSysLogMessage.Create(Self);
  try
    LMsg.ReadFromBytes(AData,ABinding.PeerIP);
  //  ReadFromStream(AData, (AData as TMemoryStream).Size, ABinding.PeerIP);
    DoSyslogEvent(LMsg, ABinding);
  finally
    Sys.FreeAndNil(LMsg)
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
