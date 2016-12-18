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
  Rev 1.8    7/23/04 1:32:08 PM  RLebeau
  Bug fix for TIdSyslogFacility where sfUUCP and sfClockDeamonOne were in the
  wrong order

  Rev 1.7    7/8/04 11:43:08 PM  RLebeau
  Updated ReadFromBytes(c) to use new BytesToString() parameters

  Rev 1.6    2004.02.03 5:44:28 PM  czhower
  Name changes

  Rev 1.5    1/31/2004 1:23:24 PM  JPMugaas
  Eliminated Todo item.

  Rev 1.4    2004.01.22 3:23:36 PM  czhower
  IsCharInSet

  Rev 1.3    1/21/2004 4:03:58 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 01:58:30 PM  JPMugaas
  Attempt to port Syslog over to new code.

  Rev 1.1    2003.10.12 6:36:44 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:02:12 AM  JPMugaas
}

unit IdSysLogMessage;

{
  Copyright the Indy pit crew
  Original Author: Stephane Grobety (grobety@fulgan.com)
  Release history:
  25/2/02; - Stephane Grobety
    - Moved Facility and Severity translation functions out of the class
    - Restored the "SendToHost" method
    - Changed the ASCII check tzo include only the PRI and HEADER part.
    - Now allow nul chars in message result (Special handeling should be required, though)
  09/20/01;  - J. Peter Mugaas
    Added more properties dealing with Msg parts of the SysLog Message
  09/19/01; - J. Peter Mugaas
    restructured syslog classes
  08/09/01: Dev started
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdGlobalProtocols, IdBaseComponent;

type
//  TIdSyslogSeverity = ID_SYSLOG_SEVERITY_EMERGENCY..ID_SYSLOG_SEVERITY_DEBUG;
//  TIdSyslogFacility = ID_SYSLOG_FACILITY_KERNEL..ID_SYSLOG_FACILITY_LOCAL7;
  TIdSyslogPRI = 0..191;
  TIdSyslogFacility = (sfKernel, { ID_SYSLOG_FACILITY_KERNEL}
                      sfUserLevel, { ID_SYSLOG_FACILITY_USER }
                      sfMailSystem, { ID_SYSLOG_FACILITY_MAIL }
                      sfSystemDaemon, { ID_SYSLOG_FACILITY_SYS_DAEMON }
                      sfSecurityOne, { ID_SYSLOG_FACILITY_SECURITY1 }
                      sfSysLogInternal, { ID_SYSLOG_FACILITY_INTERNAL }
                      sfLPR, {ID_SYSLOG_FACILITY_LPR}
                      sfNNTP, { ID_SYSLOG_FACILITY_NNTP }
                      sfUUCP, { ID_SYSLOG_FACILITY_UUCP }
                      sfClockDaemonOne, { CILITY_CLOCK1 }
                      sfSecurityTwo, { ID_SYSLOG_FACILITY_SECURITY2 }
                      sfFTPDaemon, { ID_SYSLOG_FACILITY_FTP }
                      sfNTP, { ID_SYSLOG_FACILITY_NTP }
                      sfLogAudit, { ID_SYSLOG_FACILITY_AUDIT  }
                      sfLogAlert, { ID_SYSLOG_FACILITY_ALERT }
                      sfClockDaemonTwo, { ID_SYSLOG_FACILITY_CLOCK2 }
                      sfLocalUseZero, { ID_SYSLOG_FACILITY_LOCAL0 }
                      sfLocalUseOne, { ID_SYSLOG_FACILITY_LOCAL1 }
                      sfLocalUseTwo, { ID_SYSLOG_FACILITY_LOCAL2 }
                      sfLocalUseThree, { ID_SYSLOG_FACILITY_LOCAL3 }
                      sfLocalUseFour, { ID_SYSLOG_FACILITY_LOCAL4 }
                      sfLocalUseFive, { ID_SYSLOG_FACILITY_LOCAL5 }
                      sfLocalUseSix, { ID_SYSLOG_FACILITY_LOCAL6 }
                      sfLocalUseSeven); { ID_SYSLOG_FACILITY_LOCAL7  }

  TIdSyslogSeverity = (slEmergency, {0 - emergency - system unusable}
              slAlert, {1 - action must be taken immediately }
              slCritical, { 2 - critical conditions }
              slError, {3 - error conditions }
              slWarning, {4 - warning conditions }
              slNotice, {5 - normal but signification condition }
              slInformational, {6 - informational }
              slDebug); {7 - debug-level messages }

  TIdSysLogMsgPart = class(TPersistent)
  protected
    FPIDAvailable: Boolean;
    FProcess: String;
    FPID: Integer;
    FContent: String;
    procedure SetPID(AValue: Integer);
    procedure SetProcess(const AValue: String);
    function GetText: String;
    procedure SetText(const AValue: String);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Text: String read GetText write SetText;
    property PIDAvailable : Boolean read FPIDAvailable write FPIDAvailable stored false;
    property Process : String read FProcess write SetProcess stored false;
    property PID : Integer read FPID write SetPID stored false;
    property Content : String read FContent write FContent stored false;
  end;

  TIdSysLogMessage = class(TIdBaseComponent)
  protected
    FMsg : TIdSysLogMsgPart;
    FFacility: TidSyslogFacility;
    FSeverity: TIdSyslogSeverity;
    FHostname: string;
    FMessage: String;
    FTimeStamp: TDateTime;
    FRawMessage: String;
    FPeer: String;
    FPri: TIdSyslogPRI;
    FUDPCliComp: TIdBaseComponent;
    procedure SetFacility(const AValue: TidSyslogFacility);
    procedure SetSeverity(const AValue: TIdSyslogSeverity);
    procedure SetHostname(const AValue: string);
    procedure SetRawMessage(const Value: string);
    procedure SetTimeStamp(const AValue: TDateTime);
    procedure SetMsg(const AValue : TIdSysLogMsgPart);
    procedure SetPri(const Value: TIdSyslogPRI);
    function GetHeader: String;
    procedure CheckASCIIRange(var Data: String); virtual;
    procedure ReadPRI(var StartPos: Integer); virtual;
    procedure ReadHeader(var StartPos: Integer); virtual;
    procedure ReadMSG(var StartPos: Integer); virtual;
    procedure Parse; virtual;
    procedure UpdatePRI; virtual;
    function DecodeTimeStamp(TimeStampString: String): TDateTime; virtual;
    procedure InitComponent; override;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    function EncodeMessage: String; virtual;
    procedure ReadFromBytes(const ASrc: TIdBytes; const APeer : String); virtual;
    //
    property RawMessage: string read FRawMessage write SetRawMessage;
    procedure SendToHost(const Dest: String);
    property Peer: string read FPeer write FPeer;
    property TimeStamp: TDateTime read FTimeStamp write SetTimeStamp;
  published
    property Pri: TIdSyslogPRI read FPri write SetPri default 13;
    property Facility: TidSyslogFacility read FFacility write SetFacility stored false;
    property Severity: TIdSyslogSeverity read FSeverity write SetSeverity stored false;
    property Hostname: string read FHostname write SetHostname stored false;
    property Msg : TIdSysLogMsgPart read FMsg write SetMsg;
  end; // class

function FacilityToString(AFac: TIdSyslogFacility): string;
function SeverityToString(ASec: TIdsyslogSeverity): string;
function NoToSeverity(ASev :  Word) : TIdSyslogSeverity;
function logSeverityToNo(ASev :  TIdSyslogSeverity) : Word;
function NoToFacility(AFac : Word) : TIdSyslogFacility;
function logFacilityToNo(AFac : TIdSyslogFacility) : Word;

implementation

uses
  IdAssignedNumbers, IdException, IdExceptionCore, IdResourceStringsProtocols, IdStack, IdStackConsts, IdUDPClient, SysUtils;

const
  // facility
  ID_SYSLOG_FACILITY_KERNEL     = 0;  // kernel messages
  ID_SYSLOG_FACILITY_USER       = 1;  // user-level messages
  ID_SYSLOG_FACILITY_MAIL       = 2;  // mail system
  ID_SYSLOG_FACILITY_SYS_DAEMON = 3;  // system daemons
  ID_SYSLOG_FACILITY_SECURITY1  = 4;  // security/authorization messages (1)
  ID_SYSLOG_FACILITY_INTERNAL   = 5;  // messages generated internally by syslogd
  ID_SYSLOG_FACILITY_LPR        = 6;  // line printer subsystem
  ID_SYSLOG_FACILITY_NNTP       = 7;  // network news subsystem
  ID_SYSLOG_FACILITY_UUCP       = 8;  // UUCP subsystem
  ID_SYSLOG_FACILITY_CLOCK1     = 9;  // clock daemon (1)
  ID_SYSLOG_FACILITY_SECURITY2  = 10; // security/authorization messages (2)
  ID_SYSLOG_FACILITY_FTP        = 11; // FTP daemon
  ID_SYSLOG_FACILITY_NTP        = 12; // NTP subsystem
  ID_SYSLOG_FACILITY_AUDIT      = 13; // log audit
  ID_SYSLOG_FACILITY_ALERT      = 14; // log alert
  ID_SYSLOG_FACILITY_CLOCK2     = 15; // clock daemon (2)
  ID_SYSLOG_FACILITY_LOCAL0     = 16; // local use 0  (local0)
  ID_SYSLOG_FACILITY_LOCAL1     = 17; // local use 1  (local1)
  ID_SYSLOG_FACILITY_LOCAL2     = 18; // local use 2  (local2)
  ID_SYSLOG_FACILITY_LOCAL3     = 19; // local use 3  (local3)
  ID_SYSLOG_FACILITY_LOCAL4     = 20; // local use 4  (local4)
  ID_SYSLOG_FACILITY_LOCAL5     = 21; // local use 5  (local5)
  ID_SYSLOG_FACILITY_LOCAL6     = 22; // local use 6  (local6)
  ID_SYSLOG_FACILITY_LOCAL7     = 23; // local use 7  (local7)

  // Severity
  ID_SYSLOG_SEVERITY_EMERGENCY     = 0; // Emergency: system is unusable
  ID_SYSLOG_SEVERITY_ALERT         = 1; // Alert: action must be taken immediately
  ID_SYSLOG_SEVERITY_CRITICAL      = 2; // Critical: critical conditions
  ID_SYSLOG_SEVERITY_ERROR         = 3; // Error: error conditions
  ID_SYSLOG_SEVERITY_WARNING       = 4; // Warning: warning conditions
  ID_SYSLOG_SEVERITY_NOTICE        = 5; // Notice: normal but significant condition
  ID_SYSLOG_SEVERITY_INFORMATIONAL = 6; // Informational: informational messages
  ID_SYSLOG_SEVERITY_DEBUG         = 7; // Debug: debug-level messages

function logFacilityToNo(AFac : TIdSyslogFacility) : Word;
begin
  case AFac of
   sfKernel : Result := ID_SYSLOG_FACILITY_KERNEL;
   sfUserLevel : Result := ID_SYSLOG_FACILITY_USER;
   sfMailSystem : Result := ID_SYSLOG_FACILITY_MAIL;
   sfSystemDaemon : Result := ID_SYSLOG_FACILITY_SYS_DAEMON;
   sfSecurityOne : Result := ID_SYSLOG_FACILITY_SECURITY1;
   sfSysLogInternal : Result := ID_SYSLOG_FACILITY_INTERNAL;
   sfLPR : Result := ID_SYSLOG_FACILITY_LPR;
   sfNNTP : Result := ID_SYSLOG_FACILITY_NNTP;
   sfClockDaemonOne : Result := ID_SYSLOG_FACILITY_CLOCK1;
   sfUUCP : Result := ID_SYSLOG_FACILITY_UUCP;
   sfSecurityTwo : Result := ID_SYSLOG_FACILITY_SECURITY2;
   sfFTPDaemon : Result := ID_SYSLOG_FACILITY_FTP;
   sfNTP : Result := ID_SYSLOG_FACILITY_NTP;
   sfLogAudit : Result := ID_SYSLOG_FACILITY_AUDIT;
   sfLogAlert : Result := ID_SYSLOG_FACILITY_ALERT;
   sfClockDaemonTwo : Result := ID_SYSLOG_FACILITY_CLOCK2;
   sfLocalUseZero : Result := ID_SYSLOG_FACILITY_LOCAL0;
   sfLocalUseOne : Result := ID_SYSLOG_FACILITY_LOCAL1;
   sfLocalUseTwo : Result := ID_SYSLOG_FACILITY_LOCAL2;
   sfLocalUseThree : Result := ID_SYSLOG_FACILITY_LOCAL3;
   sfLocalUseFour : Result := ID_SYSLOG_FACILITY_LOCAL4;
   sfLocalUseFive : Result := ID_SYSLOG_FACILITY_LOCAL5;
   sfLocalUseSix : Result := ID_SYSLOG_FACILITY_LOCAL6;
   sfLocalUseSeven : Result := ID_SYSLOG_FACILITY_LOCAL7;
  else
    Result := ID_SYSLOG_FACILITY_LOCAL7;
  end;
end;

function NoToFacility(AFac : Word) : TIdSyslogFacility;
begin
  case AFac of
    ID_SYSLOG_FACILITY_KERNEL : Result := sfKernel;
    ID_SYSLOG_FACILITY_USER : Result := sfUserLevel;
    ID_SYSLOG_FACILITY_MAIL : Result := sfMailSystem;
    ID_SYSLOG_FACILITY_SYS_DAEMON : Result := sfSystemDaemon;
    ID_SYSLOG_FACILITY_SECURITY1 : Result := sfSecurityOne;
    ID_SYSLOG_FACILITY_INTERNAL : Result := sfSysLogInternal;
    ID_SYSLOG_FACILITY_LPR : Result := sfLPR;
    ID_SYSLOG_FACILITY_NNTP : Result := sfNNTP;
    ID_SYSLOG_FACILITY_CLOCK1 : Result := sfClockDaemonOne;
    ID_SYSLOG_FACILITY_UUCP : Result := sfUUCP;
    ID_SYSLOG_FACILITY_SECURITY2 : Result := sfSecurityTwo;
    ID_SYSLOG_FACILITY_FTP : Result := sfFTPDaemon;
    ID_SYSLOG_FACILITY_NTP : Result := sfNTP;
    ID_SYSLOG_FACILITY_AUDIT : Result := sfLogAudit;
    ID_SYSLOG_FACILITY_ALERT : Result := sfLogAlert;
    ID_SYSLOG_FACILITY_CLOCK2 : Result := sfClockDaemonTwo;
    ID_SYSLOG_FACILITY_LOCAL0 : Result := sfLocalUseZero;
    ID_SYSLOG_FACILITY_LOCAL1 : Result := sfLocalUseOne;
    ID_SYSLOG_FACILITY_LOCAL2 : Result := sfLocalUseTwo;
    ID_SYSLOG_FACILITY_LOCAL3 : Result := sfLocalUseThree;
    ID_SYSLOG_FACILITY_LOCAL4 : Result := sfLocalUseFour;
    ID_SYSLOG_FACILITY_LOCAL5 : Result := sfLocalUseFive;
    ID_SYSLOG_FACILITY_LOCAL6 : Result := sfLocalUseSix;
    ID_SYSLOG_FACILITY_LOCAL7 : Result := sfLocalUseSeven;
    else
      Result := sfLocalUseSeven;
  end;
end;

function logSeverityToNo(ASev :  TIdSyslogSeverity) : Word;
begin
  case ASev of
    slEmergency : Result := ID_SYSLOG_SEVERITY_EMERGENCY;
    slAlert :  Result := ID_SYSLOG_SEVERITY_ALERT;
    slCritical : Result := ID_SYSLOG_SEVERITY_CRITICAL;
    slError : Result := ID_SYSLOG_SEVERITY_ERROR;
    slWarning : Result := ID_SYSLOG_SEVERITY_WARNING;
    slNotice : Result := ID_SYSLOG_SEVERITY_NOTICE;
    slInformational : Result := ID_SYSLOG_SEVERITY_INFORMATIONAL;
    slDebug : Result := ID_SYSLOG_SEVERITY_DEBUG;
  else
    Result := ID_SYSLOG_SEVERITY_DEBUG;
  end;
end;

function NoToSeverity(ASev :  Word) : TIdSyslogSeverity;
begin
  case ASev of
    ID_SYSLOG_SEVERITY_EMERGENCY : Result := slEmergency;
    ID_SYSLOG_SEVERITY_ALERT : Result := slAlert;
    ID_SYSLOG_SEVERITY_CRITICAL : Result := slCritical;
    ID_SYSLOG_SEVERITY_ERROR : Result := slError;
    ID_SYSLOG_SEVERITY_WARNING : Result := slWarning;
    ID_SYSLOG_SEVERITY_NOTICE : Result := slNotice;
    ID_SYSLOG_SEVERITY_INFORMATIONAL : Result := slInformational;
    ID_SYSLOG_SEVERITY_DEBUG : Result := slDebug;
  else
    Result := slDebug;
  end;
end;

function SeverityToString(ASec: TIdsyslogSeverity): string;
begin
  case ASec of
    slEmergency: Result := STR_SYSLOG_SEVERITY_EMERGENCY;
    slAlert: Result := STR_SYSLOG_SEVERITY_ALERT;
    slCritical: Result := STR_SYSLOG_SEVERITY_CRITICAL;
    slError: Result := STR_SYSLOG_SEVERITY_ERROR;
    slWarning: Result := STR_SYSLOG_SEVERITY_WARNING;
    slNotice: Result := STR_SYSLOG_SEVERITY_NOTICE;
    slInformational: Result := STR_SYSLOG_SEVERITY_INFORMATIONAL;
    slDebug: Result := STR_SYSLOG_SEVERITY_DEBUG;
  else
    Result := STR_SYSLOG_SEVERITY_UNKNOWN;
  end;
end;

function FacilityToString(AFac: TIdSyslogFacility): string;
begin
  case AFac of
    sfKernel: Result := STR_SYSLOG_FACILITY_KERNEL;
    sfUserLevel: Result := STR_SYSLOG_FACILITY_USER;
    sfMailSystem: Result := STR_SYSLOG_FACILITY_MAIL;
    sfSystemDaemon: Result := STR_SYSLOG_FACILITY_SYS_DAEMON;
    sfSecurityOne: Result := STR_SYSLOG_FACILITY_SECURITY1;
    sfSysLogInternal: Result := STR_SYSLOG_FACILITY_INTERNAL;
    sfLPR: Result := STR_SYSLOG_FACILITY_LPR;
    sfNNTP: Result := STR_SYSLOG_FACILITY_NNTP;
    sfClockDaemonOne: Result := STR_SYSLOG_FACILITY_CLOCK1;
    sfUUCP: Result := STR_SYSLOG_FACILITY_UUCP;
    sfSecurityTwo: Result := STR_SYSLOG_FACILITY_SECURITY2;
    sfFTPDaemon: Result := STR_SYSLOG_FACILITY_FTP;
    sfNTP: Result := STR_SYSLOG_FACILITY_NTP;
    sfLogAudit: Result := STR_SYSLOG_FACILITY_AUDIT;
    sfLogAlert: Result := STR_SYSLOG_FACILITY_ALERT;
    sfClockDaemonTwo: Result := STR_SYSLOG_FACILITY_CLOCK2;
    sfLocalUseZero: Result := STR_SYSLOG_FACILITY_LOCAL0;
    sfLocalUseOne: Result := STR_SYSLOG_FACILITY_LOCAL1;
    sfLocalUseTwo: Result := STR_SYSLOG_FACILITY_LOCAL2;
    sfLocalUseThree: Result := STR_SYSLOG_FACILITY_LOCAL3;
    sfLocalUseFour: Result := STR_SYSLOG_FACILITY_LOCAL4;
    sfLocalUseFive: Result := STR_SYSLOG_FACILITY_LOCAL5;
    sfLocalUseSix: Result := STR_SYSLOG_FACILITY_LOCAL6;
    sfLocalUseSeven: Result := STR_SYSLOG_FACILITY_LOCAL7;
  else
    Result := STR_SYSLOG_FACILITY_UNKNOWN;
  end;
end;

function ExtractAlphaNumericStr(var VString : String) : String;
var
  i, len : Integer;
begin
  len := 0;  
  for i := 1 to IndyMin(Length(VString), 32) do begin
    //numbers or alphabet only
    if IsAlphaNumeric(VString[i]) then begin
      Inc(len);
    end else begin
      Break;
    end;
  end;
  Result := Copy(VString, 1, len);
  VString := Copy(VString, len+1, MaxInt);
end;

{ TIdSysLogMessage }

procedure TIdSysLogMessage.Assign(Source: TPersistent);
var
  ms : TIdSysLogMessage;
begin
  if Source is TIdSysLogMessage then begin
    ms := Source as TIdSysLogMessage;
    {Priority and facility properties are set with this so those assignments
    are not needed}
    Pri := Ms.Pri;
    HostName := ms.Hostname;
    FMsg.Assign(ms.Msg);
    TimeStamp := ms.TimeStamp;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdSysLogMessage.DecodeTimeStamp(TimeStampString: String): TDateTime;
var
  AYear, AMonth, ADay, AHour, AMin, ASec: Word;
  LDate : TDateTime;
begin
  // SG 25/2/02: Check the ASCII range
  CheckASCIIRange(TimeStampString);
  // Get the current date to get the current year
  LDate := Now;
  DecodeDate(LDate, AYear, AMonth, ADay);
  if Length(TimeStampString) <> 16 then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  // Month
  AMonth := StrToMonth(Copy(TimeStampString, 1, 3));
  if not (AMonth in [1..12]) then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  // day
  ADay := IndyStrToInt(Copy(TimeStampString, 5, 2), 0);
  if not (ADay in [1..31]) then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  // Time
  AHour := IndyStrToInt(Copy(TimeStampString, 8, 2), 0);
  if not (AHour in [0..23]) then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  AMin := IndyStrToInt(Copy(TimeStampString, 11, 2), 0);
  if not (AMin in [0..59]) then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  ASec := IndyStrToInt(Copy(TimeStampString, 14, 2), 0);
  if not (ASec in [0..59]) then begin
    raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  if TimeStampString[16] <> ' ' then begin   {Do not Localize}
    Raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogTimeStamp, [TimeStampString]);
  end;
  Result := EncodeDate(AYear, AMonth, ADay) + EncodeTime(AHour, AMin, ASec, 0);
end;

procedure TIdSysLogMessage.ReadFromBytes(const ASrc: TIdBytes; const APeer : String);
const
  MSGLEN = 1024;
begin
  FPeer := APeer;
  RawMessage := BytesToString(ASrc, 0, MSGLEN);
end;

procedure TIdSysLogMessage.Parse;
var
  APos: Integer;
begin
  APos := 1;
  ReadPRI(APos);
  ReadHeader(APos);
  ReadMSG(APos);
end;

procedure TIdSysLogMessage.ReadHeader(var StartPos: Integer);
var
  AHostNameEnd: Integer;
begin
  // DateTimeToInternetStr and StrInternetToDateTime
  // Time stamp string is 15 char long
  try
    FTimeStamp := DecodeTimeStamp(Copy(FRawMessage, StartPos, 16));
    Inc(StartPos, 16);
    // HostName
    AHostNameEnd := StartPos;
    while (AHostNameEnd < Length(FRawMessage)) and (FRawMessage[AHostNameEnd] <> ' ') do begin    {Do not Localize}
      Inc(AHostNameEnd);
    end;    // while

    FHostname := Copy(FRawMessage, StartPos, AHostNameEnd - StartPos);

    if Pos(':', FHostname) <> 0 then begin // check if the hostname doesn't contain a semicolon (so it's not a process)
      FHostname := Peer;
    end else begin
      StartPos := AHostNameEnd + 1;
    end;

    // SG 25/2/02: Check the ASCII range of host name
    CheckASCIIRange(FHostname);
  except
    on e: Exception do
    begin
      FTimeStamp := Now;
      FHostname := FPeer;
    end;
  end;
end;

procedure TIdSysLogMessage.ReadMSG(var StartPos: Integer);
begin
  FMessage := Copy(FRawMessage, StartPos, Length(FRawMessage));
  Msg.Text := FMessage;
end;

procedure TIdSysLogMessage.ReadPRI(var StartPos: Integer);
var
  StartPosSave: Integer;
  Buffer: string;
begin
  StartPosSave := StartPos;
  try
    // Read the PRI string
    // PRI must start with "less than" sign
    Buffer := '';    {Do not Localize}
    if not CharEquals(FRawMessage, StartPos, '<') then begin   {Do not Localize}
      raise EInvalidSyslogMessage.Create(RSInvalidSyslogPRI);
    end;
    repeat
      Inc(StartPos);
      if CharEquals(FRawMessage, StartPos, '>') then begin   {Do not Localize}
        Break;
      end;
      if not IsNumeric(FRawMessage, 1, StartPos) then begin   {Do not Localize}
        raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogPRINumber, [Buffer]);
      end;
      Buffer := Buffer + FRawMessage[StartPos];
    until StartPos = StartPosSave + 5;

    // PRI must end with "greater than" sign
    if not CharEquals(FRawMessage, StartPos, '>') then begin   {Do not Localize}
      raise EInvalidSyslogMessage.Create(RSInvalidSyslogPRI);
    end;
    // Convert PRI to numerical value
    Inc(StartPos);
    CheckASCIIRange(Buffer);
    PRI := IndyStrToInt(Buffer, -1);
  except
    // as per RFC, on invalid/missing PRI, use value 13
    on e: Exception do
    begin
      Pri := 13;
      // Reset the position to saved value
      StartPos := StartPosSave;
    end;
  end;
end;

procedure TIdSysLogMessage.UpdatePRI;
begin
  PRI := logFacilityToNo(Facility) * 8 + logSeverityToNo(Severity);
end;

procedure TIdSysLogMessage.SetFacility(const AValue: TidSyslogFacility);
begin
  if FFacility <> AValue then begin
    FFacility := AValue;
    UpdatePRI;
  end;
end;

procedure TIdSysLogMessage.SetHostname(const AValue: string);
begin
  if FHostname <> AValue then begin
    if Pos(' ', AValue) <> 0 then begin   {Do not Localize}
      raise EInvalidSyslogMessage.CreateFmt(RSInvalidHostName, [AValue]);
    end;
    FHostname := AValue;
  end;
end;

procedure TIdSysLogMessage.SetSeverity(const AValue: TIdSyslogSeverity);
begin
  if FSeverity <> AValue then begin
    FSeverity := AValue;
    UpdatePRI;
  end;
end;

procedure TIdSysLogMessage.SetTimeStamp(const AValue: TDateTime);
begin
  FTimeStamp := AValue;
end;

function TIdSysLogMessage.GetHeader: String;
var
  AYear, AMonth, ADay, AHour, AMin, ASec, AMSec: Word;

  function YearOf(ADate : TDateTime) : Word;
  var
    mm, dd : Word;
  begin
    DecodeDate(ADate, Result, mm, dd);
  end;

  Function DayToStr(day: Word): String;
  begin
    if Day < 10 then begin
       Result :=  ' ' + IntToStr(day);    {Do not Localize}
    end else begin
      Result := IntToStr(day);
    end;
  end;
begin
  // if the year of the message is not the current year, the timestamp is
  // invalid -> Create a new timestamp with the current date/time
  if YearOf(Now) <> YearOf(TimeStamp) then
  begin
    TimeStamp := Now;
  end;
  DecodeDate(TimeStamp, AYear, AMonth, ADay);
  DecodeTime(TimeStamp, AHour, AMin, ASec, AMSec);

  Result := IndyFormat('%s %s %.2d:%.2d:%.2d %s', [monthnames[AMonth], DayToStr(ADay), AHour, AMin, ASec, Hostname]);    {Do not Localize}

end;

function TIdSysLogMessage.EncodeMessage: String;
begin
  // Create a syslog message string
  // PRI
  Result := IndyFormat('<%d>%s %s', [PRI, GetHeader, FMsg.Text]);    {Do not Localize}
  // If the message is too long, tuncate it
  if Length(result) > 1024  then
  begin
    result := Copy(result, 1, 1024);
  end;
end;

procedure TIdSysLogMessage.SetPri(const Value: TIdSyslogPRI);
begin
  if FPri <> Value then begin
    if not (Value in [0..191]) then begin
      raise EInvalidSyslogMessage.CreateFmt(RSInvalidSyslogPRINumber, [IntToStr(value)]);
    end;
    FPri := Value;
    FFacility := NoToFacility(Value div 8);
    FSeverity := NoToSeverity(Value mod 8);
  end;
end;

procedure TIdSysLogMessage.InitComponent;
begin
  inherited;
  PRI := 13; //default
  {This stuff is necessary to prevent an AV in the IDE if GStack does not exist}
  // RLebeau: should we really be doing this here? At the least, maybe detect
  // DFM streaming and don't do this if it will just be overriden afterwards...
  TIdStack.IncUsage;
  try
    Hostname := GStack.HostName;
  finally
    TIdStack.DecUsage;
  end;
  FMsg := TIdSysLogMsgPart.Create;
end;

procedure TIdSysLogMessage.CheckASCIIRange(var Data: String);
var
  i: Integer;
  ValidChars : String;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  ValidChars := CharRange(#0, #127);
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(Data);
  for i := 0 to LSB.Length-1 do    // Iterate
  begin
    if not CharIsInSet(LSB, i, ValidChars) then begin
      LSB[i] := '?';    {Do not Localize}
    end;
  end;    // for
  Data := LSB.ToString;
  {$ELSE}
  for i := 1 to Length(Data) do    // Iterate
  begin
    if not CharIsInSet(Data, i, ValidChars) then begin
      Data[i] := '?';    {Do not Localize}
    end;
  end;    // for
  {$ENDIF}
end;

destructor TIdSysLogMessage.Destroy;
begin
  FreeAndNil(FMsg);
  inherited Destroy;
end;

procedure TIdSysLogMessage.SetMsg(const AValue: TIdSysLogMsgPart);
begin
  FMsg.Assign(AValue);
end;

procedure TIdSysLogMessage.SetRawMessage(const Value: string);
begin
  FRawMessage := Value;
  // check that message contains only valid ASCII chars.
  // Replace Invalid entries by "?"
  // SG 25/2/02: Moved to header decoding
  Parse;
end;

procedure TIdSysLogMessage.SendToHost(const Dest: String);
var
  LEncoding: IIdTextEncoding;
begin
  if not Assigned(FUDPCliComp) then begin
    FUDPCliComp := TIdUDPClient.Create(Self);
  end;
  LEncoding := IndyTextEncoding_8Bit;
  (FUDPCliComp as TIdUDPClient).Send(Dest, IdPORT_syslog, EncodeMessage, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

{ TIdSysLogMsgPart }

procedure TIdSysLogMsgPart.Assign(Source: TPersistent);
begin
  if Source is TIdSysLogMsgPart then begin
    {This sets about everything here}
    Text := (Source as TIdSysLogMsgPart).Text;
  end else begin
    inherited Assign(Source);
  end;
end;

procedure TIdSysLogMsgPart.SetPID(AValue: Integer);
begin
  FPID := AValue;
  FPIDAvailable := FPID <> -1;
end;

procedure TIdSysLogMsgPart.SetProcess(const AValue: String);
var
  LTmp: String;
begin
  //we have to ensure that the TAG field will never be greater than 32 characters
  //and the program name must contain alphanumeric characters
  LTmp := AValue;
  FProcess := ExtractAlphaNumericStr(LTmp);
end;

function TIdSysLogMsgPart.GetText: String;
begin
  Result := Process;
  if FPIDAvailable then begin
    Result := Result + IndyFormat('[%d]', [FPID]); {Do not Localize}
  end;
  Result := Result + ': ' + Content; {Do not Localize}
  if Result = ': ' then begin {Do not Localize}
    Result := '';
  end;
end;

procedure TIdSysLogMsgPart.SetText(const AValue: String);
var
  SBuf: String;
begin
  FProcess := '';  {Do not Localize}
  FPID := -1;
  FPIDAvailable := False;
  FContent := '';  {Do not Localize}

  SBuf := AValue;
  FProcess := ExtractAlphaNumericStr(SBuf);

  if TextStartsWith(SBuf, '[') then begin  {Do not Localize}
    SBuf := Copy(SBuf, 2, MaxInt);
    FPID := IndyStrToInt(Fetch(SBuf, ']'), -1);  {Do not Localize}
    FPIDAvailable := FPID <> -1;
  end;
  if TextStartsWith(SBuf, ': ') then begin  {Do not Localize}
    SBuf := Copy(SBuf, 3, MaxInt);
  end
  else if TextStartsWith(SBuf, ':') or TextStartsWith(SBuf, ' ') then begin  {Do not Localize}
    SBuf := Copy(SBuf, 2, MaxInt);
  end;

  FContent := SBuf;
end;

end.
