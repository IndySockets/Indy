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
  Rev 1.7    2/10/2005 2:24:38 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.6    2004.02.03 5:44:36 PM  czhower
  Name changes

  Rev 1.5    1/21/2004 4:21:00 PM  JPMugaas
  InitComponent

  Rev 1.4    1/3/2004 1:00:06 PM  JPMugaas
  These should now compile with Kudzu's change in IdCoreGlobal.

  Rev 1.3    10/26/2003 5:16:52 PM  BGooijen
  Works now, times in GetTickDiff were in wrong order

  Rev 1.2    10/22/2003 04:54:26 PM  JPMugaas
  Attempted to get these to work.

  Rev 1.1    2003.10.12 6:36:46 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:03:24 AM  JPMugaas
}

unit IdTimeUDP;

interface

{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdGlobal,
  IdAssignedNumbers, IdUDPBase, IdGlobalProtocols, IdUDPClient;

type
  TIdCustomTimeUDP = class(TIdUDPClient)
  protected
    FBaseDate: TDateTime;
    FRoundTripDelay: UInt32;
    //
    function GetDateTimeCard: UInt32;
    function GetDateTime: TDateTime;
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    {This synchronizes the local clock with the Time Server}
    function SyncTime: Boolean;
    {This is the number of seconds since 12:00 AM, 1900 - Jan-1}
    property DateTimeCard: UInt32 read GetDateTimeCard;
    {This is the current time according to the server.  TimeZone and Time used
    to receive the data are accounted for}
    property DateTime: TDateTime read GetDateTime;
    {This is the time it took to receive the Time from the server.  There is no
    need to use this to calculate the current time when using DateTime property
    as we have done that here}
    property RoundTripDelay: UInt32 read FRoundTripDelay;
  published
  end;

  TIdTimeUDP = class(TIdCustomTimeUDP)
  published
    {This property is used to set the Date that the Time server bases its
     calculations from.  If both the server and client are based from the same
     date which is higher than the original date, you can extend it beyond the
     year 2035}
    property BaseDate: TDateTime read FBaseDate write FBaseDate;
    property Port default IdPORT_TIME;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
    {$IFDEF OSX}
  Macapi.CoreServices,
    {$ENDIF}
  Posix.SysTime,
  {$ENDIF}
  IdStack, SysUtils; //Sysutils added to facilitate inlining.

{ TIdCustomTimeUDP }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdCustomTimeUDP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdCustomTimeUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_TIME;
  {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  FBaseDate := TIME_BASEDATE;
end;

function TIdCustomTimeUDP.GetDateTime: TDateTime;
var
  BufCard: UInt32;
begin
  BufCard := GetDateTimeCard;
  if BufCard <> 0 then begin
    {The formula is The Time cardinal we receive divided by (24 * 60*60 for days + RoundTrip divided by one-thousand since this is based on seconds
    - the Time Zone difference}
    Result := UTCTimeToLocalTime( ((BufCard + (FRoundTripDelay div 1000))/ (24 * 60 * 60) ) + Int(fBaseDate) );
  end else begin
    { Somehow, I really doubt we are ever going to really get a time such as
    12/30/1899 12:00 am so use that as a failure test}
    Result := 0;
  end;
end;

function TIdCustomTimeUDP.GetDateTimeCard: UInt32;
var
  LTimeBeforeRetrieve: TIdTicks;
  LBuffer : TIdBytes;
begin
  //Important - This must send an empty UDP Datagram
  Send('');    {Do not Localize}
  LTimeBeforeRetrieve := Ticks64;
  SetLength(LBuffer,4);

  ReceiveBuffer(LBuffer);
  Result := BytesToUInt32(LBuffer);
  Result := GStack.NetworkToHost(Result);
  {Theoritically, it should take about 1/2 of the time to receive the data
   but in practice, it could be any portion depending upon network conditions. This is also
   as per RFC standard}
  {This is just in case the TickCount rolled back to zero}
  FRoundTripDelay := GetElapsedTicks(LTimeBeforeRetrieve) div 2;
end;

function TIdCustomTimeUDP.SyncTime: Boolean;
var
  LBufTime: TDateTime;
begin
  LBufTime := DateTime;
  Result := LBufTime <> 0;
  if Result then begin
    Result := IndySetLocalTime(LBufTime);
  end;
end;

end.
