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
  Rev 1.5    2004.02.03 5:44:26 PM  czhower
  Name changes

  Rev 1.4    1/21/2004 4:03:54 PM  JPMugaas
  InitComponent

  Rev 1.3    15.9.2003 12:36:44  TPrami
  - Process information will be written in SendLogMessages if AUsePID
  is false

  Rev 1.2    15.9.2003 12:22:10  TPrami
  - AUsePID was not honored is SendLogMessage

  Rev 1.1    15.9.2003 11:05:26  TPrami
  - SendLogMessage was not sending Pid and name correctly. Now
  AText goes to the Content, not to the Text property

  Rev 1.0    11/13/2002 08:02:06 AM  JPMugaas
}

unit IdSysLog;

{
  Copyright the Indy pit crew
  Original Author: Stephane Grobety (grobety@fulgan.com)
  Release history:
  09/19/01;  J. Peter Mugaas
    divided SysLogMessage into this unit
  08/09/01: Dev started
}

{ ToDo:  Somehow figure out how to make a bound port and bound IP property
  in UDP Client.  This will probably require some changes to the Indy core
  units though. }

interface

{$i IdCompilerDefines.inc}

uses IdAssignedNumbers, IdSocketHandle, IdSysLogMessage, IdUDPBase, IdUDPClient;

type
  TIdSysLog = class(TIdUDPClient)
  protected
    function GetBinding: TIdSocketHandle; override;
    procedure InitComponent; override;
  public
    procedure SendLogMessage(const AMsg: TIdSysLogMessage;
      const AAutoTimeStamp: Boolean = true); overload;
    procedure SendLogMessage(const AMsg: String;
      const AFacility : TidSyslogFacility;
      const ASeverity: TIdSyslogSeverity); overload;
    procedure SendLogMessage(const AProcess: String; const AText : String;
      const AFacility : TidSyslogFacility;
      const ASeverity: TIdSyslogSeverity;
      const AUsePID : Boolean = False;
      const APID : Integer = -1); overload;
  published
    property Port default IdPORT_syslog;
  end;

implementation

uses
  IdGlobal, IdStackConsts, SysUtils;

{ TIdSysLog }

procedure TIdSysLog.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_syslog;
end;


procedure TIdSysLog.SendLogMessage(const AMsg: TIdSyslogMessage; const AAutoTimeStamp: Boolean = true);
var
  LEncoding: IIdTextEncoding;
begin
  if AAutoTimeStamp then begin
    AMsg.TimeStamp := Now;
  end;
  LEncoding := IndyTextEncoding_8Bit;
  Send(AMsg.EncodeMessage, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;


function TIdSysLog.GetBinding: TIdSocketHandle;
//const FromPort = 514;
begin
  Result := inherited GetBinding;
//  if Result.Port <> FromPort then
//  begin
//    {Recommened by RFC 3164 - Use 514 as to connect to the SysLog server}
//    Result.Port := FromPort;
//    Result.SetSockOpt(Id_SOL_SOCKET, Id_SO_REUSEADDR, Id_SO_True);
//    Result.Bind;
//  end;
end;

procedure TIdSysLog.SendLogMessage(const AMsg: String;
  const AFacility: TidSyslogFacility;
  const ASeverity: TIdSyslogSeverity);
var
  LMsg : TIdSyslogMessage;
begin
  LMsg := TIdSyslogMessage.Create(nil);
  try
    LMsg.Msg.Text := AMsg;
    LMsg.Facility := AFacility;
    LMsg.Severity := ASeverity;
    SendLogMessage(LMsg);
  finally
    FreeAndNil(LMsg);
  end;
end;

procedure TIdSysLog.SendLogMessage(const AProcess, AText: String;
  const AFacility: TidSyslogFacility;
  const ASeverity: TIdSyslogSeverity;
  const AUsePID: Boolean;
  const APID: Integer);
var
  LMsg : TIdSyslogMessage;
begin
  LMsg := TIdSyslogMessage.Create(nil);
  try
    LMsg.Msg.PIDAvailable := AUsePID;

    // <TP>
    // AUsePID was not honored
    LMsg.Msg.PIDAvailable := AUsePID;
    if AUsePID then begin
      LMsg.Msg.PID := APID;
    end;
    LMsg.Msg.Content := AText;
    // </TP>

    LMsg.Msg.Process := AProcess;
    LMsg.Facility := AFacility;
    LMsg.Severity := ASeverity;
    SendLogMessage(LMsg);
  finally
    FreeAndNil(LMsg);
  end;
end;

end.
