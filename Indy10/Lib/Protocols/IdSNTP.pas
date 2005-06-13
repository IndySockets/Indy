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
{   Rev 1.6    2/8/2005 6:28:02 AM  JPMugaas
{ Should now work properly.  I omitted a feild when outputting bytes from the
{ packet object.  OOPS!!!
}
{
    Rev 1.5    6/1/2004 9:09:00 PM  DSiders
  Correct calculation for RoundTripDelay as per RFC 2030 errata.
}
{
{   Rev 1.4    2/9/2004 11:26:46 AM  JPMugaas
{ Fixed some bugs reading the time.  SHould work.
}
{
{   Rev 1.3    2/8/2004 4:15:54 PM  JPMugaas
{ SNTP ported to DotNET.
}
{
{   Rev 1.2    2004.02.03 5:44:24 PM  czhower
{ Name changes
}
{
{   Rev 1.1    1/21/2004 4:03:42 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 08:01:12 AM  JPMugaas
}
unit IdSNTP;

{*
  Winshoe SNTP (Simple Network Time Protocol)
  Behaves more or less according to RFC-2030

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

  	R. Brian Lindahl - Original Author
*}

interface

uses
	Classes,
  IdGlobal,
  IdUDPClient;

const
  NTPMaxInt = 4294967297.0;

type
	// NTP Datagram format
{  TNTPGram	= packed record
    Head1: byte;
    Head2: byte;
    Head3: byte;
    Head4: byte;
    RootDelay: Cardinal;
    RootDispersion: Cardinal;
    RefID: Cardinal;
    Ref1: Cardinal;
    Ref2: Cardinal;
    Org1: Cardinal;
    Org2: Cardinal;
    Rcv1: Cardinal;
    Rcv2: Cardinal;
    Xmit1: Cardinal;
    Xmit2: Cardinal;
  end;    }

  TNTPGram	= class(TObject)
  protected
    FHead1 : byte;
    FHead2: byte;
    FHead3: byte;
    FHead4: byte;
    FRootDelay: Cardinal;
    FRootDispersion: Cardinal;
    FRefID: Cardinal;
    FRef1: Cardinal;
    FRef2: Cardinal;
    FOrg1: Cardinal;
    FOrg2: Cardinal;
    FRcv1: Cardinal;
    FRcv2: Cardinal;
    FXmit1: Cardinal;
    FXmit2: Cardinal;
        function GetBytes: TIdBytes;
    procedure SetBytes(const AValue: TIdBytes);
  public
    property Bytes : TIdBytes read GetBytes write SetBytes;
    property Head1: byte read FHead1 write FHead1;
    property Head2: byte read FHead2 write FHead2;
    property Head3: byte read FHead3 write FHead3;
    property Head4: byte read FHead4 write FHead4;
    property RootDelay: Cardinal read FRootDelay write FRootDelay;
    property RootDispersion: Cardinal read FRootDispersion write FRootDispersion;
    property RefID: Cardinal read FRefID write FRefID;
    property Ref1: Cardinal read FRef1 write FRef1;
    property Ref2: Cardinal read FRef2 write FRef2;
    property Org1: Cardinal read FOrg1 write FOrg1;
    property Org2: Cardinal read FOrg2 write FOrg2;
    property Rcv1: Cardinal read FRcv1 write FRcv1;
    property Rcv2: Cardinal read FRcv2 write FRcv2;
    property Xmit1: Cardinal read FXmit1 write FXmit1;
    property Xmit2: Cardinal read FXmit2 write FXmit2;
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
    procedure DateTimeToNTP(ADateTime: TDateTime;var Second,Fraction: Cardinal);
    function NTPToDateTime(Second, Fraction: Cardinal): TDateTime;

    function Disregard(ANTPMessage: TNTPGram): Boolean;
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
  IdGlobalProtocols,
  IdAssignedNumbers,
  IdStack,
  SysUtils;

const NTGRAMSIZE = 48;

procedure TIdSNTP.DateTimeToNTP(ADateTime: TDateTime;var Second,Fraction: Cardinal);
var
  Value1,
  Value2: Double;
begin
  Value1 := (ADateTime + TimeZoneBias - 2) * 86400;
  Value2 := Value1;

  if Value2 > NTPMaxInt then
  begin
    Value2 := Value2 - NTPMaxInt;
  end;

  Second := Cardinal(Trunc(Value2));
  Value2 := ((Frac(Value1) * 1000) / 1000) * NTPMaxInt;

  if Value2 > NTPMaxInt then
  begin
    Value2 := Value2 - NTPMaxInt;
  end;

  Fraction := Trunc(Value2);
end;

function TIdSNTP.NTPToDateTime(Second, Fraction: Cardinal): TDateTime;
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


function TIdSNTP.Disregard(ANTPMessage: TNTPGram): Boolean;
var
  LvStratum: Integer;
  LvLeapIndicator: Integer;
begin
  LvLeapIndicator := (ANTPMessage.Head1 and 192 ) shr 6;
  LvStratum := ANTPMessage.Head2;

  Result := (LvLeapIndicator = 3) or
    { (Stratum > 15) or (Stratum = 0) or }
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
  LResultStr : String;
begin
//  FillChar(NTPDataGram, SizeOf(NTPDataGram), 0);
  LNTPDataGram := TNTPGram.Create;

  try
    LNTPDataGram.Head1 := $1B;
    DateTimeToNTP(Now, LNTPDataGram.FXmit1, LNTPDataGram.FXmit2);
    LNTPDataGram.Xmit1 := GStack.HostToNetwork(LNTPDataGram.Xmit1);
    LNTPDataGram.Xmit2 := GStack.HostToNetwork(LNTPDataGram.Xmit2);

    LResultStr := BytesToString(LNTPDataGram.Bytes);
    Send(LResultStr);
    LResultStr := ReceiveString;

    // DS default result is an empty TDateTime value
    Result := 0.0;

    // DS response may contain optional NTP authentication scheme info not in NTPGram
    if Length(LResultStr) >= NTGRAMSIZE then
    begin
      FDestinationTimeStamp := Now ;

      // DS copy result data back into NTPDataGram
      // DS ignore optional NTP authentication scheme info in response
      LNTPDataGram.Bytes := ToBytes(LResultStr);

      FOriginateTimeStamp := NTPToDateTime(GStack.NetworkToHost(LNTPDataGram.FOrg1),
        GStack.NetworkToHost(LNTPDataGram.FOrg2));
      FReceiveTimestamp := NTPToDateTime(GStack.NetworkToHost(LNTPDataGram.FRcv1),
        GStack.NetworkToHost(LNTPDataGram.FRcv2));
      FTransmitTimestamp := NTPToDateTime(GStack.NetworkToHost(LNTPDataGram.FXmit1),
        GStack.NetworkToHost(LNTPDataGram.FXmit2));

      // corrected as per RFC 2030 errata
      FRoundTripDelay := (FDestinationTimestamp - FOriginateTimestamp) -
        (FTransmitTimestamp - FReceiveTimestamp);

      FLocalClockOffset := ((FReceiveTimestamp - FOriginateTimestamp) +
        (FTransmitTimestamp - FDestinationTimestamp)) / 2;

      // DS update date/time when NTP datagram is not ignored
      if not Disregard(LNTPDataGram) then
      begin
        Result := NTPToDateTime(GStack.NetworkToHost(LNTPDataGram.FXmit1),
          GStack.NetworkToHost(LNTPDataGram.FXmit2));
      end;
    end;
  finally
    FreeAndNil(LNTPDataGram);
  end;
end;

function TIdSNTP.SyncTime: Boolean;
begin
  Result := DateTime <> 0.0;

  if Result then
  begin
    Result := SetLocalTime(FOriginateTimestamp + FLocalClockOffset
      + FRoundTripDelay);
  end;
end;

{ TNTPGram }


function TNTPGram.GetBytes: TIdBytes;
begin
  SetLength(Result,0);
  AppendByte(Result,Head1);
  AppendByte(Result,Head2);
  AppendByte(Result,Head3);
  AppendByte(Result,Head4);
  AppendBytes(Result,ToBytes(FRootDelay));
  AppendBytes(Result,ToBytes(FRootDispersion));
  AppendBytes(Result,ToBytes(FRefID));
  AppendBytes(Result,ToBytes(FRef1));
  AppendBytes(Result,ToBytes(FRef2));
  AppendBytes(Result,ToBytes(FOrg1));
  AppendBytes(Result,ToBytes(FOrg2));
  AppendBytes(Result,ToBytes(FRcv1));
  AppendBytes(Result,ToBytes(FRcv2));
  AppendBytes(Result,ToBytes(FXmit1));
  AppendBytes(Result,ToBytes(FXmit2));
end;

procedure TNTPGram.SetBytes(const AValue: TIdBytes);
{  TNTPGram	= packed record
    Head1: byte;                0
    Head2: byte;                1
    Head3: byte;                2
    Head4: byte;                3
    RootDelay: Cardinal;      4567    4- 7
    RootDispersion: Cardinal; 8901    8-11
    RefID: Cardinal;          2345   12-15
    Ref1: Cardinal;           6789   16-19
    Ref2: Cardinal;           0123   20-23
    Org1: Cardinal;           4567   24-27
    Org2: Cardinal;           8901   28-31
    Rcv1: Cardinal;           2345   32-35
    Rcv2: Cardinal;           6789   36-39
    Xmit1: Cardinal;          0123   40-43
    Xmit2: Cardinal;          4567   44-47
  end;    }
begin
  if Length(AValue)>0 then
  begin
    Head1 := AValue[0];
  end;
  if Length(AValue)>1 then
  begin
    Head2 := AValue[1];
  end;
  if Length(AValue)>2 then
  begin
    Head3 := AValue[2];
  end;
  if Length(AValue)>3 then
  begin
    Head4 := AValue[3];
  end;
  if Length(AValue)>6 then
  begin
    //4-7
    FRootDelay      := OrdFourByteToCardinal(AValue[4],AValue[5],AValue[6],AValue[7]);
  end;
  if Length(AValue)>10 then
  begin
    //8-11
    FRootDispersion := OrdFourByteToCardinal(AValue[8],AValue[9],AValue[10],AValue[11]);
  end;
  if Length(AValue)>14 then
  begin
    //12-16
    FRefID         := OrdFourByteToCardinal(AValue[12],AValue[13],AValue[14],AValue[15]);
  end;
  if Length(AValue)>18 then
  begin
  //16-19
    FRef1          := OrdFourByteToCardinal(AValue[16],AValue[17],AValue[18],AValue[19]);
  end;
  if Length(AValue)>22 then
  begin
    //20-23
    FRef2          := OrdFourByteToCardinal(AValue[20],AValue[21],AValue[22],AValue[23]);
  end;
  if Length(AValue)>26 then
  begin
    //24-27
    FOrg1          := OrdFourByteToCardinal(AValue[24],AValue[25],AValue[26],AValue[27]);
  end;
  if Length(AValue)>30 then
  begin
    //28-31
    FOrg2          := OrdFourByteToCardinal(AValue[28],AValue[29],AValue[30],AValue[31]);
  end;
  if Length(AValue)>34 then
  begin
    //32-35
    FRcv1          := OrdFourByteToCardinal(AValue[32],AValue[33],AValue[34],AValue[35]);
  end;
  if Length(AValue)>38 then
  begin
    //36-39
    FRcv2          := OrdFourByteToCardinal(AValue[36],AValue[37],AValue[38],AValue[39]);
  end;
  if Length(AValue)>42 then
  begin
    //40-43
    FXmit1         := OrdFourByteToCardinal(AValue[40],AValue[41],AValue[42],AValue[43]);
  end;
  if Length(AValue)>46 then
  begin
    //44-47
    Xmit2         := OrdFourByteToCardinal(AValue[44],AValue[45],AValue[46],AValue[47]);
  end;
end;

end.
