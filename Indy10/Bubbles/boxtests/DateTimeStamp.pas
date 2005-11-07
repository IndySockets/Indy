{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11235: DateTimeStamp.pas 
{
{   Rev 1.0    11/12/2002 09:15:16 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit DateTimeStamp;

interface

uses
  IndyBox,
  IdDateTimeStamp,
  SysUtils;

type
  TDateTimeStampBox = class(TIndyBox)
  protected
    strCmd, strIn, strOut : String;
    DTS, DTSIn, DTSOut: TIdDateTimeStamp;
    index : Integer;

    procedure AddItems(const AString : String;
      var ADTS : TIdDateTimeStamp);
    procedure CheckAgainstOutput(const AString : String;
      var ADTS : TIdDateTimeStamp);
    procedure GetNextPart(var AStr : String; var AChar : Char;
      var ANum : Integer);
    procedure ReadBasicFormat(const AString : String;
      var ADTS : TIdDateTimeStamp);
    procedure ReadTTimeStamp(const AString : String;
      var ATS : TTimeStamp);
    procedure SubtractItems(const AString : String;
      var ADTS : TIdDateTimeStamp);

    procedure DoNoTest;
    procedure DoAdd;
    procedure DoSubtract;
    procedure DoConvertFromRFC822;
    procedure DoConvertToRFC822;
    procedure DoConvertFromISO8601;
    procedure DoConvertToISO8601;
    procedure DoConvertTTimeStamp;
  public
    procedure Test; override;
  end;

implementation

uses
  Classes,
  Dialogs,
  IdGlobal,
  IdStrings;

{$RANGECHECKS ON}

{ TDateTimeStampBox }

procedure TDateTimeStampBox.DoAdd;
begin
  ReadBasicFormat(strIn, DTS);
  AddItems(Trim(Copy(strCmd, 2, length(strCmd))), DTS);
  CheckAgainstOutput(strOut, DTS);
end;

procedure TDateTimeStampBox.DoConvertFromISO8601;
begin
  DTS.SetFromISO8601(strIn);
  CheckAgainstOutput(strOut, DTS);
end;

procedure TDateTimeStampBox.DoConvertFromRFC822;
begin
  DTS.SetFromRFC822(strIn);
  CheckAgainstOutput(strOut, DTS);
end;

procedure TDateTimeStampBox.DoConvertToISO8601;
var
  s, format : String;
  i : Integer;
begin
  ReadBasicFormat(strIn, DTS);
  if length(strCmd) > 1 then
  begin
    i := 0;
    case strCmd[2] of
      '1' :
      begin
        s := DTS.GetAsISO8601Calendar;
        format := 'calender';
        i := 1;
      end;
      '2' :
      begin
        s := DTS.GetAsISO8601Ordinal;
        format := 'ordinal';
        i := 2;
      end;
      '3' :
      begin
        s := DTS.GetAsISO8601Week;
        format := 'week';
        i := 3;
      end;
    end;
    if i <> 0 then begin
      Check(Trim(strOut) = s,
        'Test ' + IntToStr(index + 1) +
        '.  Failed on convert to ISO 8601 ' + format + ' format.  Expected "'
        + strOut + '", got "' + s + '"');
    end;
  end;
end;

procedure TDateTimeStampBox.DoConvertToRFC822;
begin
  ReadBasicFormat(strIn, DTS);
  Status('Convert to RFC 822 = ' + DTS.GetAsRFC822);
  Check(Trim(strOut) = Trim(DTS.GetAsRFC822),
    'Test ' + IntToStr(index + 1) +
    '.  Failed on convert to RFC 822 format.  Expected "'
    + strOut + '", got "' + DTS.GetAsRFC822 + '"');
end;

procedure TDateTimeStampBox.DoNoTest;
begin
  ReadBasicFormat(strIn, DTS);
  CheckAgainstOutput(strOut, DTS);
end;

procedure TDateTimeStampBox.DoSubtract;
begin
  ReadBasicFormat(strIn, DTS);
  SubtractItems(Trim(Copy(strCmd, 2, length(strCmd))), DTS);
  CheckAgainstOutput(strOut, DTS);
end;

procedure TDateTimeStampBox.ReadBasicFormat(const AString: String;
  var ADTS: TIdDateTimeStamp);
var
  c : char;
  i : Integer;
  s : String;
begin
  s := Trim(AString);
  while length(s) > 0 do
  begin
    GetNextPart(s, c, i);
    case c of
      'Y' : ADTS.Year := i;
      'D' : ADTS.Day := i;
      'S' : ADTS.Second := i;
      'L' : ADTS.Millisecond := i;
      'Z' : ADTS.TimeZone := i;
    end;
  end;
end;

procedure TDateTimeStampBox.CheckAgainstOutput(const AString : String;
  var ADTS : TIdDateTimeStamp);
var
  c : char;
  i, j : Integer;
  resStr, s : String;
  res : Boolean;
begin
  s := Trim(AString);
  res := false;
  j := 0;
  while length(s) > 0 do
  begin
    GetNextPart(s, c, i);
    resStr := '';
    case c of
      'Y' :
      begin
        res := ADTS.Year = i;
        j := ADTS.Year;
        resStr := 'Year';
      end;
      'D' :
      begin
        res := ADTS.Day = i;
        j := ADTS.Day;
        resStr := 'Day of Year';
      end;
      'd' :
      begin
        res := ADTS.DayOfMonth = i;
        j := ADTS.DayOfMonth;
        resStr := 'Day of Month';
      end;
      'S' :
      begin
        res := ADTS.Second = i;
        j := ADTS.Second;
        resStr := 'Second';
      end;
      's' :
      begin
        res := ADTS.SecondOfMinute = i;
        j := ADTS.SecondOfMinute;
        resStr := 'Second of Minute';
      end;
      'L' :
      begin
        res := ADTS.Millisecond = i;
        j := ADTS.Millisecond;
        resStr := 'Millisecond';
      end;
      'Z' :
      begin
        res := ADTS.TimeZone = i;
        j := ADTS.TimeZone;
        resStr := 'Time Zone';
      end;
      'B' :
      begin
        res := ADTS.BeatOfDay = i;
        j := ADTS.BeatOfDay;
        resStr := 'Beat of day';
      end;
      'H' :
      begin
        res := ADTS.HourOf24Day = i;
        j := ADTS.HourOf24Day;
        resStr := '24-Hour';
      end;
      'h' :
      begin
        res := ADTS.HourOf12Day = i;
        j := ADTS.HourOf12Day;
        resStr := '12-Hour';
      end;
      'W' :
      begin
        res := ADTS.WeekOfYear = i;
        j := ADTS.WeekOfYear;
        resStr := 'Week of Year';
      end;
      'w' :
      begin
        res := ADTS.DayOfWeek = i;
        j := ADTS.DayOfWeek;
        resStr := 'Day of Week';
      end;
      'M' :
      begin
        res := ADTS.MonthOfYear = i;
        j := ADTS.MonthOfYear;
        resStr := 'Month of Year';
      end;
      'm' :
      begin
        res := ADTS.MinuteOfDay = i;
        j := ADTS.MinuteOfDay;
        resStr := 'Minute Of Day';
      end;
      'U' :
      begin
        res := ADTS.MinuteOfHour = i;
        j := ADTS.MinuteOfHour;
        resStr := 'Minute Of Hour';
      end;
    end;
    if length(resStr) <> 0 then
    begin
      Check(res, 'Test ' + IntToStr(index + 1) + '.  Failed on '
        + resStr + '.  Expected ' + IntToStr(i) + ', got '
        + IntToStr(j));
    end;
  end;
end;

procedure TDateTimeStampBox.SubtractItems(const AString : String;
  var ADTS : TIdDateTimeStamp);
var
  c : char;
  i : Integer;
  s : String;
begin
  s := Trim(AString);
  while length(s) > 0 do
  begin
    GetNextPart(s, c, i);
    case c of
      'Y' :
      begin
        ADTS.SubtractYears(i);
      end;
      'D' :
      begin
        ADTS.SubtractDays(i);
      end;
      'S' :
      begin
        ADTS.SubtractSeconds(i);
      end;
      'L' :
      begin
        ADTS.SubtractMilliseconds(i);
      end;
      'H', 'h' :
      begin
        ADTS.SubtractHours(i);
      end;
      'W' :
      begin
        ADTS.SubtractWeeks(i);
      end;
      'm' :
      begin
        ADTS.SubtractMinutes(i);
      end;
      'M' :
      begin
        ADTS.SubtractMonths(i);
      end;
{
       'Z' :
       begin
        res := ADTS.TimeZone = i;
        j := ADTS.TimeZone;
        resStr := 'Time Zone';
       end;
      'B' :
      begin
        res := ADTS.BeatOfDay = i;
        j := ADTS.BeatOfDay;
        resStr := 'Beat of day';
       end;
}
    end;
  end;
end;

procedure TDateTimeStampBox.AddItems(const AString : String;
  var ADTS : TIdDateTimeStamp);
var
  c : char;
  i : Integer;
  s : String;
begin
  s := Trim(AString);
  while length(s) > 0 do
  begin
    GetNextPart(s, c, i);
    case c of
      'Y' :
      begin
        ADTS.AddYears(i);
      end;
      'D' :
      begin
        ADTS.AddDays(i);
      end;
      'S' :
      begin
        ADTS.AddSeconds(i);
      end;
      'L' :
      begin
        ADTS.AddMilliseconds(i);
      end;
      'H', 'h' :
      begin
        ADTS.AddHours(i);
      end;
      'W' :
      begin
        ADTS.AddWeeks(i);
      end;
      'M' :
      begin
        ADTS.AddMonths(i);
      end;
      'm' :
      begin
        ADTS.AddMinutes(i);
      end;
{
       'Z' :
       begin
        res := ADTS.TimeZone = i;
        j := ADTS.TimeZone;
        resStr := 'Time Zone';
       end;
      'B' :
      begin
        res := ADTS.BeatOfDay = i;
        j := ADTS.BeatOfDay;
        resStr := 'Beat of day';
       end;
}
    end;
  end;
end;

procedure TDateTimeStampBox.Test;
var
  TestData : TStringList;
  sindex : Integer;
  s : String;
begin
  DTS := TIdDateTimeStamp.Create((Nil));
  DTSIn := TIdDateTimeStamp.Create(Nil);
  DTSOut := TIDDateTimeStamp.Create(Nil);
  TestData := TStringList.Create;
  try
    TestData.LoadFromFile(GetDataDir + 'DateTimeStamp.dat');
    index := 0;
    sindex := 0;
    while sindex < TestData.Count - 1 do
    begin
      s := TestData[sindex];
      if Length(s) > 0 then
      begin
        if s[1] = ':' then
        begin
          if TestData.Count > sindex + 3 then
          begin
            strCmd := TestData[sindex + 1];
            strIn := TestData[sindex + 2];
            strOut := TestData[sindex + 3];
            if length(strCmd) > 0 then begin
              DTS.Zero;
              DTSIn.Zero;
              DTSOut.Zero;
              case strCmd[1] of
                'N' :
                begin
                  DoNoTest;
                end;
                'A' :
                begin
                  DoAdd;
                end;
                'S' :
                begin
                  DoSubtract;
                end;
                'I' :
                begin
                  DoConvertFromRFC822;
                end;
                'i' :
                begin
                  DoConvertToRFC822;
                end;
                'V' :
                begin
                  DoConvertFromISO8601;
                end;
                'v' :
                begin
                  DoConvertToISO8601;
                end;
                'T' :
                begin
                  DoConvertTTimeStamp;
                end;
              end;
            end;
            Inc(sindex, 3);
            Inc(index);
          end;
        end;
      end;
      Inc(sindex);
    end;
  finally
    DTS.Free;
    DTSIn.Free;
    DTSOut.Free;
  end;
end;

procedure TDateTimeStampBox.GetNextPart(var AStr: String; var AChar: Char;
  var ANum: Integer);
var
  fnd : Integer;
  num : String;
begin
  AChar := ' ';
  ANum := 0;
  if Length(AStr) = 0 then exit;

  // Remove first character.
  AChar := AStr[1];
  System.Delete(AStr, 1, 1);

  // Should be followed by some numbers.
  fnd := FindFirstNotOf('-+0123456789', AStr);
  if fnd = 0 then
  begin
    num := AStr;
    AStr := '';
  end else
  begin
    num := Copy(AStr, 1, fnd - 1);
  end;
  AStr := Trim(Copy(AStr, fnd, length(AStr)));

  // num should now contain the numbers.
  if Length(num) = 0 then
  begin
    // The number has no content.
    exit;
  end;

  // Just to be on the safe side...
  if FindFirstNotOf('-+0123456789', num) > 0 then
  begin
    // The 'number' is not numeric.
    exit;
  end;

  ANum := StrToInt(num);
end;

procedure TDateTimeStampBox.DoConvertTTimeStamp;
var
  TS : TTimeStamp;
  DT : TDateTime;
  Date : Integer;
  Time : Integer;
begin
  ReadBasicFormat(strIn, DTS);

  TS := DTS.AsTTimeStamp;
  Date := TS.Date;
  Time := TS.Time;
  Status('TTimeStamp Date Got: ' + IntToStr(Date));
  Status('TTimeStamp Time Got: ' + IntToStr(Time));

  DT := EncodeDate(DTS.Year, DTS.MonthOfYear, DTS.DayOfMonth);
  TS := DateTimeToTimeStamp(DT);
  Status('TTimeStamp Date Expected: ' + IntToStr(TS.Date));
  Status('TTimeStamp Time Expected: ' + IntToStr(TS.Time));
  Check(Time = TS.Time, 'Test ' + IntToStr(index) +
    ': TTimeStamp.Time expected: ' + IntToStr(TS.Time) +
    ', got: ' + IntToStr(Time));
  Check(Date = TS.Date, 'Test ' + IntToStr(index) +
    ': TTimeStamp.Date expected: ' + IntToStr(TS.Date) +
    ', got: ' + IntToStr(Date));

end;

procedure TDateTimeStampBox.ReadTTimeStamp(const AString: String;
  var ATS: TTimeStamp);
var
  Date, Time : String;
  i : Integer;
begin
  Date := Copy(AString, 2, Length(AString));
  i := Pos('.', Date);
  if i = 0 then
  begin
    Check(false, 'Test ' + IntToStr(index) + ': '
      + 'Conversion of output data to TTimeStamp, no . found');
  end;

  Time := Copy(Date, i + 1, Length(Date));
  Date := Copy(Date, 0, i - 1);
  ATS.Time := StrToInt(Time);
  ATS.Date := StrToInt(Date);
end;

initialization
  TIndyBox.RegisterBox(TDateTimeStampBox, 'DateTimeStampProc', 'Misc');
end.
