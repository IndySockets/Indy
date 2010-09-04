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
  Rev 1.6    2/8/2005 6:28:02 AM  JPMugaas
  Should now work properly.  I omitted a feild when outputting bytes from the
  packet object.  OOPS!!!

  Rev 1.5    6/1/2004 9:09:00 PM  DSiders
  Correct calculation for RoundTripDelay as per RFC 2030 errata.

  Rev 1.4    2/9/2004 11:26:46 AM  JPMugaas
  Fixed some bugs reading the time.  SHould work.

  Rev 1.3    2/8/2004 4:15:54 PM  JPMugaas
  SNTP ported to DotNET.

  Rev 1.2    2004.02.03 5:44:24 PM  czhower
  Name changes

  Rev 1.1    1/21/2004 4:03:42 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:01:12 AM  JPMugaas

  2002 Jan 21 Don
    Added suggestions from R. Brian Lindahl.
    Added CheckStratum property.
    Modified Disregard to use CheckStratum property.
    Modified GetAdjustmentTime to ignore optional NTP authentication in response.

  2002 Jan 3 Don
    Corrected errors introduced in previous revision.
    Added TIdSNTP.Create to assign port number for the SNTP protocol.

  2002 Jan 3 Don
    Corrected error in TIdSNTP.GetDateTime as per Bug Report
    http://sourceforge.net/tracker/?func=detail&atid=431491&aid=498843&group_id=41862

  2001 Sep 4 Don
    Corrected error in Flip() as reported on BCB newsgroup

  2000 Apr 21 Kudzu
    Updated to match UDP core changes

  2000 Mar 28 Hadi
    Continued conversion to Indy

	2000 Mar 24 Kudzu
    Converted to Indy

	2000 Jan 13 MTL
  	Moved to new Palette Tab scheme (Winshoes Clients)
    1999
}

unit IdSNTP;

{*
  Winshoe SNTP (Simple Network Time Protocol)
  Behaves more or less according to RFC-2030
  R. Brian Lindahl - Original Author
*}

interface
{$i IdCompilerDefines.inc}

uses
	Classes,
  IdGlobal,
  IdUDPClient;

const
  NTPMaxInt = 4294967297.0;

type
  // NTP Datagram format
  TNTPGram = packed record
    Head1 : byte;
    Head2: byte;
    Head3: byte;
    Head4: byte;
    RootDelay: LongWord;
    RootDispersion: LongWord;
    RefID: LongWord;
    Ref1: LongWord;
    Ref2: LongWord;
    Org1: LongWord;
    Org2: LongWord;
    Rcv1: LongWord;
    Rcv2: LongWord;
    Xmit1: LongWord;
    Xmit2: LongWord;
  end;

  TIdSNTP = class(TIdUDPClient)
  protected
    FDestinationTimestamp: TDateTime;   // Destination Timestamp   T4   time reply received by client
    FLocalClockOffset: TDateTime;       // = ((T2 - T1) + (T3 - T4)) / 2
    FOriginateTimestamp: TDateTime;     // Originate Timestamp     T1   time request sent by client
    FReceiveTimestamp: TDateTime;       // Receive Timestamp       T2   time request received by server
    FRoundTripDelay: TDateTime;         // = (T4 - T1) - (T2 - T3)
    FTransmitTimestamp: TDateTime;      // Transmit Timestamp      T3   time reply sent by server
    FCheckStratum: Boolean;
    //
    procedure DateTimeToNTP(ADateTime: TDateTime; var Second, Fraction: LongWord);
    function NTPToDateTime(Second, Fraction: LongWord): TDateTime;

    function Disregard(const ANTPMessage: TNTPGram): Boolean;
    function GetAdjustmentTime: TDateTime;
    function GetDateTime: TDateTime;
    procedure InitComponent; override;
  public
    function SyncTime: Boolean;        // get datetime and adjust if needed
    //
    property AdjustmentTime: TDateTime read GetAdjustmentTime;
    property DateTime: TDateTime read GetDateTime;
    property RoundTripDelay: TDateTime read FRoundTripDelay;
    property CheckStratum: Boolean read FCheckStratum write FCheckStratum default True;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  PosixSysTime,
  PosixTime,
  {$ENDIF}
  IdGlobalProtocols,
  IdAssignedNumbers,
  IdStack,
  SysUtils;

procedure TIdSNTP.DateTimeToNTP(ADateTime: TDateTime; var Second, Fraction: LongWord);
var
  Value1, Value2: Double;
begin
  Value1 := (ADateTime + TimeZoneBias - 2) * 86400;
  Value2 := Value1;

  if Value2 > NTPMaxInt then
  begin
    Value2 := Value2 - NTPMaxInt;
  end;

  Second := LongWord(Trunc(Value2));
  Value2 := ((Frac(Value1) * 1000) / 1000) * NTPMaxInt;

  if Value2 > NTPMaxInt then
  begin
    Value2 := Value2 - NTPMaxInt;
  end;

  Fraction := Trunc(Value2);
end;

function TIdSNTP.NTPToDateTime(Second, Fraction: LongWord): TDateTime;
var
  Value1: Double;
  Value2: Double;
begin
  Value1 := Second;

  if Value1 < 0 then
  begin
    Value1 := NTPMaxInt + Value1 - 1;
  end;

  Value2 := Fraction;

  if Value2 < 0 then
  begin
    Value2 := NTPMaxInt + Value2 - 1;
  end;

  // Value2 := Value2 / NTPMaxInt;
  // Value2 := Trunc(Value2 * 1000) / 1000;

  Value2 := Trunc(Value2 / NTPMaxInt * 1000) / 1000;
  Result := ((Value1 + Value2) / 86400) - TimeZoneBias + 2;
end ;

{ TIdSNTP }

procedure TIdSNTP.InitComponent;
begin
  inherited;
  FPort := IdPORT_SNTP;
  FCheckStratum := True;
end;


function TIdSNTP.Disregard(const ANTPMessage: TNTPGram): Boolean;
var
  LvStratum: Byte;
  LvLeapIndicator: Byte;
begin
  LvLeapIndicator := (ANTPMessage.Head1 and $C0) shr 6;
  LvStratum := ANTPMessage.Head2;

  Result := (LvLeapIndicator = 3) or
    (((Int(FTransmitTimestamp)) = 0.0) and (Frac(FTransmitTimestamp) = 0.0));

  // DS ignore NTPGram when stratum is used, and value is reserved or unspecified
  if FCheckStratum and ((LvStratum > 15) or (LvStratum = 0)) then
  begin
    Result := True;
  end;
end;


function TIdSNTP.GetAdjustmentTime: TDateTime;
begin
  Result := FLocalClockOffset;
end;

function TIdSNTP.GetDateTime: TDateTime;
var
  LNTPDataGram: TNTPGram;
  LBuffer : TIdBytes;
begin
  // DS default result is an empty TDateTime value
  Result := 0.0;

  SetLength(LBuffer, SizeOf(TNTPGram));
  FillBytes(LBuffer, SizeOf(TNTPGram), $00);

  LBuffer[0] := $1B;
  DateTimeToNTP(Now, LNTPDataGram.Xmit1, LNTPDataGram.Xmit2);
  CopyTIdLongWord(GStack.HostToNetwork(LNTPDataGram.Xmit1), LBuffer, 40);
  CopyTIdLongWord(GStack.HostToNetwork(LNTPDataGram.Xmit2), LBuffer, 44);

  SendBuffer(LBuffer);
  ReceiveBuffer(LBuffer);

  // DS response may contain optional NTP authentication scheme info not in NTPGram
  if Length(LBuffer) >= SizeOf(TNTPGram) then
  begin
    FDestinationTimeStamp := Now;

    // DS copy result data back into NTPDataGram
    // DS ignore optional NTP authentication scheme info in response

    LNTPDataGram.Head1            := LBuffer[0];
    LNTPDataGram.Head2            := LBuffer[1];
    LNTPDataGram.Head3            := LBuffer[2];
    LNTPDataGram.Head4            := LBuffer[3];
    LNTPDataGram.RootDelay        := GStack.NetworkToHost(BytesToLongWord(LBuffer, 4));
    LNTPDataGram.RootDispersion   := GStack.NetworkToHost(BytesToLongWord(LBuffer, 8));
    LNTPDataGram.RefID            := GStack.NetworkToHost(BytesToLongWord(LBuffer, 12));
    LNTPDataGram.Ref1             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 16));
    LNTPDataGram.Ref2             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 20));
    LNTPDataGram.Org1             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 24));
    LNTPDataGram.Org2             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 28));
    LNTPDataGram.Rcv1             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 32));
    LNTPDataGram.Rcv2             := GStack.NetworkToHost(BytesToLongWord(LBuffer, 36));
    LNTPDataGram.Xmit1            := GStack.NetworkToHost(BytesToLongWord(LBuffer, 40));
    LNTPDataGram.Xmit2            := GStack.NetworkToHost(BytesToLongWord(LBuffer, 44));

    FOriginateTimeStamp := NTPToDateTime(LNTPDataGram.Org1, LNTPDataGram.Org2);
    FReceiveTimestamp := NTPToDateTime(LNTPDataGram.Rcv1, LNTPDataGram.Rcv2);
    FTransmitTimestamp := NTPToDateTime(LNTPDataGram.Xmit1, LNTPDataGram.Xmit2);

    // corrected as per RFC 2030 errata
    FRoundTripDelay := (FDestinationTimestamp - FOriginateTimestamp) -
      (FTransmitTimestamp - FReceiveTimestamp);

    FLocalClockOffset := ((FReceiveTimestamp - FOriginateTimestamp) +
      (FTransmitTimestamp - FDestinationTimestamp)) / 2;

    // DS update date/time when NTP datagram is not ignored
    if not Disregard(LNTPDataGram) then begin
      Result := FTransmitTimestamp;
    end;
  end;
end;

function TIdSNTP.SyncTime: Boolean;
begin
  Result := DateTime <> 0.0;
  if Result then begin
    Result := IndySetLocalTime(FOriginateTimestamp + FLocalClockOffset + FRoundTripDelay);
  end;
end;

end.
