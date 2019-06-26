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
  Rev 1.10    2/10/2005 2:24:42 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.9    2004.02.03 5:44:34 PM  czhower
  Name changes

  Rev 1.8    1/21/2004 4:20:56 PM  JPMugaas
  InitComponent

  Rev 1.7    1/3/2004 1:00:00 PM  JPMugaas
  These should now compile with Kudzu's change in IdCoreGlobal.

  Rev 1.6    4/11/2003 02:45:44 PM  JPMugaas

  Rev 1.5    4/5/2003 7:23:56 PM  BGooijen
  Raises exception on timeout now

  Rev 1.4    4/4/2003 8:02:34 PM  BGooijen
  made host published

  Rev 1.3    2/24/2003 10:37:00 PM  JPMugaas
  Should compile.  TODO:  Figure out what to do with TIdTime and the timeout
  feature.

  Rev 1.2    12/7/2002 06:43:38 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.1    12/6/2002 05:30:48 PM  JPMugaas
  Now descend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 08:03:14 AM  JPMugaas
}

unit IdTime;

{*******************************************************}
{                                                       }
{       Indy Time Client TIdTime                        }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2000-April-24                                   }
{       Based on RFC RFC 868                            }
{                                                       }
{*******************************************************}
{
 2001-Sep -21 J. Peter Mugaas
  - adjusted formula as suggested by Vaclav Korecek.  The old
  one would give wrong date, time if RoundTripDelay was over
   a value of 1000
 2000-May -04  J. Peter Mugaas
  -Changed RoundTripDelay to a cardinal and I now use the
   GetTickCount function for more accuracy
  -The formula had to adjusted for this.
 2000-May -03  J. Peter Mugaas
  -Added BaseDate to the date the calculations are based on can be
   adjusted to work after the year 2035
 2000-Apr.-29  J. Peter Mugaas
  -Made the time more accurate by taking into account time-zone
   bias by subtracting IdGlobal.TimeZoneBias.
  -I also added a correction for the time it took to receive the
   Integer from the server ( ReadInteger )
  -Changed Time property to DateTime and TimeCard to DateTimeCard
   to be more consistant with TIdSNTP.
}

interface

{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdGlobal,
  IdAssignedNumbers, IdGlobalProtocols, IdTCPClient;

const
  TIME_TIMEOUT = 2500;

type
  TIdCustomTime = class(TIdTCPClientCustom)
  protected
    FBaseDate: TDateTime;
    FRoundTripDelay: UInt32;
    FTimeout: Integer;
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
    property Timeout: Integer read FTimeout write FTimeout default TIME_TIMEOUT;
    property Host;
  end;

  TIdTime = class(TIdCustomTime)
  published
      {This property is used to set the Date that the Time server bases its
     calculations from.  If both the server and client are based from the same
     date which is higher than the original date, you can extend it beyond the
     year 2035}
    property BaseDate: TDateTime read FBaseDate write FBaseDate;
    property Timeout: Integer read FTimeout write FTimeout default TIME_TIMEOUT;
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
  IdTCPConnection;

{ TIdCustomTime }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdCustomTime.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdCustomTime.InitComponent;
begin
  inherited;
  Port := IdPORT_TIME;
  {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  FBaseDate := TIME_BASEDATE;
  FTimeout := TIME_TIMEOUT;
end;

function TIdCustomTime.GetDateTime: TDateTime;
var
  BufCard: UInt32;
begin
  BufCard := GetDateTimeCard;
  if BufCard <> 0 then begin
    {The formula is The Time cardinal we receive divided by (24 * 60*60 for days + RoundTrip divided by one-thousand since this is based on seconds
    - the Time Zone difference}
    Result := ( ((BufCard + (FRoundTripDelay div 1000))/ (24 * 60 * 60) ) + Int(fBaseDate))
    -TimeZoneBias;

  end else begin
    { Somehow, I really doubt we are ever going to really get a time such as
    12/30/1899 12:00 am so use that as a failure test}
    Result := 0;
  end;
end;

function TIdCustomTime.GetDateTimeCard: UInt32;
var
  LTimeBeforeRetrieve: TIdTicks;
begin
  Connect; try
    // Check for timeout
    // Timeout is actually a time with no traffic, not a total timeout.
    IOHandler.ReadTimeout:=Timeout;
    LTimeBeforeRetrieve := Ticks64;
    Result := IOHandler.ReadUInt32;
    {Theoritically, it should take about 1/2 of the time to receive the data
    but in practice, it could be any portion depending upon network conditions. This is also
    as per RFC standard}

    {This is just in case the TickCount rolled back to zero}
    FRoundTripDelay := GetElapsedTicks(LTimeBeforeRetrieve) div 2;
  finally Disconnect; end;
end;

function TIdCustomTime.SyncTime: Boolean;
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
