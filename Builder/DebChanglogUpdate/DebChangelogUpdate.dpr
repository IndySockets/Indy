program DebChangelogUpdate;
{$APPTYPE CONSOLE}
{$R 'ExecutionLevelAsInvokerManifest.res' 'ExecutionLevelAsInvokerManifest.rc'}
uses
  Windows,
  Classes,
  SysUtils;

type
  EIdFailedToRetreiveTimeZoneInfo = class(Exception);

const
  RSFailedTimeZoneInfo = 'Failed to obtain timezone';

const
  wdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'); {do not localize}
  monthnames: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', {do not localize}
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); {do not localize}

procedure WriteStringToStream(AStream: TStream; const AStr: string);
var LLen : Integer;
begin
  LLen := Length(AStr);
  if LLen>0 then
  begin
    AStream.Write(AStr[1],LLen);
  end;
end;

function GetEnglishSetting: TFormatSettings;
inline;
begin
  Result.CurrencyFormat := $00; // 0 = '$1'
  Result.NegCurrFormat := $00; //0 = '($1)'
  Result.CurrencyString := '$';
  Result.CurrencyDecimals := 2;

  Result.ThousandSeparator := ',';
  Result.DecimalSeparator := '.';

  Result.DateSeparator := '/';
  Result.ShortDateFormat := 'M/d/yyyy';
  Result.LongDateFormat := 'dddd, MMMM dd, yyyy';

  Result.TimeSeparator := ':';
  Result.TimeAMString := 'AM';
  Result.TimePMString := 'PM';
  Result.LongTimeFormat := 'h:mm:ss AMPM';
  Result.ShortTimeFormat := 'h:mm AMPM';

  Result.ShortMonthNames[1] := monthnames[1]; //'Jan';
  Result.ShortMonthNames[2] := monthnames[2]; //'Feb';
  Result.ShortMonthNames[3] := monthnames[3]; //'Mar';
  Result.ShortMonthNames[4] := monthnames[4]; //'Apr';
  Result.ShortMonthNames[5] := monthnames[5]; //'May';
  Result.ShortMonthNames[6] := monthnames[6]; //'Jun';
  Result.ShortMonthNames[7] := monthnames[7]; //'Jul';
  Result.ShortMonthNames[8] := monthnames[8]; //'Aug';
  Result.ShortMonthNames[9] := monthnames[9]; //'Sep';
  Result.ShortMonthNames[10] := monthnames[10];// 'Oct';
  Result.ShortMonthNames[11] := monthnames[11]; //'Nov';
  Result.ShortMonthNames[12] := monthnames[12]; //'Dec';

  Result.LongMonthNames[1] := 'January';
  Result.LongMonthNames[2] := 'February';
  Result.LongMonthNames[3] := 'March';
  Result.LongMonthNames[4] := 'April';
  Result.LongMonthNames[5] := 'May';
  Result.LongMonthNames[6] := 'June';
  Result.LongMonthNames[7] := 'July';
  Result.LongMonthNames[8] := 'August';
  Result.LongMonthNames[9] := 'September';
  Result.LongMonthNames[10] := 'October';
  Result.LongMonthNames[11] := 'November';
  Result.LongMonthNames[12] := 'December';

  Result.ShortDayNames[1] := wdays[1]; //'Sun';
  Result.ShortDayNames[2] := wdays[2]; //'Mon';
  Result.ShortDayNames[3] := wdays[3]; //'Tue';
  Result.ShortDayNames[4] := wdays[4]; //'Wed';
  Result.ShortDayNames[5] := wdays[5]; //'Thu';
  Result.ShortDayNames[6] := wdays[6]; //'Fri';
  Result.ShortDayNames[7] := wdays[7]; //'Sat';

  Result.LongDayNames[1] := 'Sunday';
  Result.LongDayNames[2] := 'Monday';
  Result.LongDayNames[3] := 'Tuesday';
  Result.LongDayNames[4] := 'Wednesday';
  Result.LongDayNames[5] := 'Thursday';
  Result.LongDayNames[6] := 'Friday';
  Result.LongDayNames[7] := 'Saturday';

  Result.ListSeparator := ',';
end;

function IndyFormat(const AFormat: string; const Args: array of const): string;
begin
  Result := SysUtils.Format(AFormat, Args, GetEnglishSetting);
end;

function DateTimeToGmtOffSetStr(ADateTime: TDateTime; SubGMT: Boolean): string;
var
  AHour, AMin, ASec, AMSec: Word;
begin
  if (ADateTime = 0.0) and SubGMT then
  begin
    Result := 'GMT'; {do not localize}
    Exit;
  end;
  DecodeTime(ADateTime, AHour, AMin, ASec, AMSec);
  Result := IndyFormat(' %0.2d%0.2d', [AHour, AMin]); {do not localize}
  if ADateTime < 0.0 then begin
    Result[1] := '-'; {do not localize}
  end else begin
    Result[1] := '+';  {do not localize}
  end;
end;

function OffsetFromUTC: TDateTime;

var
  iBias: Integer;
  tmez: TTimeZoneInformation;

begin
  case GetTimeZoneInformation(tmez) of
    TIME_ZONE_ID_INVALID:
    begin
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    end;
    TIME_ZONE_ID_UNKNOWN  :
       iBias := tmez.Bias;
    TIME_ZONE_ID_DAYLIGHT :
      iBias := tmez.Bias + tmez.DaylightBias;
    TIME_ZONE_ID_STANDARD :
      iBias := tmez.Bias + tmez.StandardBias;
    else
    begin
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    end;
  end;
  {We use ABS because EncodeTime will only accept positive values}
  Result := EncodeTime(Abs(iBias) div 60, Abs(iBias) mod 60, 0, 0);
  {The GetTimeZone function returns values oriented towards converting
   a GMT time into a local time.  We wish to do the opposite by returning
   the difference between the local time and GMT.  So I just make a positive
   value negative and leave a negative value as positive}
  if iBias > 0 then begin
    Result := 0 - Result;
  end;
end;

{This should never be localized}
function DateTimeToInternetStr(const Value: TDateTime; const AIsGMT : Boolean = False) : String;
var
  wDay,
  wMonth,
  wYear: Word;
begin
  DecodeDate(Value, wYear, wMonth, wDay);
  Result := IndyFormat('%s, %d %s %d %s %s',    {do not localize}
                   [wdays[DayOfWeek(Value)], wDay, monthnames[wMonth],
                    wYear, FormatDateTime('HH":"nn":"ss', Value), {do not localize}
                    DateTimeToGmtOffSetStr(OffsetFromUTC, AIsGMT)]);
end;

var GFileName : String;
  GVer : String;
  GFileContents : TStrings;
  GPkgName : String;
  i : Integer;
  GF : TFileStream;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    //parameters
    if ParamCount < 5 then
    begin
      WriteLn(ExtractFileName(ParamStr(0))+' dir major_ver minor_ver point_ver');
      WriteLn('');
      WriteLn('dir - directory changlog is located in');
      WriteLn('pkg_name = name of Debian package');
      WriteLn('major_ver - major version of package');
      WriteLn('minor_ver - minor version of package');
      WriteLn('point_ver - point version of package');
      ReadLn;
      Exit;
    end
    else
    begin
      GFileName := ParamStr(1)+'\changelog';
    end;
    GPkgName := ParamStr(2);
    GVer := IntToStr(StrToIntDef(ParamStr(3),0));
    GVer := GVer + '.' + IntToStr(StrToIntDef(ParamStr(4),0));
    GVer := GVer + '.0.' + IntToStr(StrToIntDef(ParamStr(5),0));
    GFileContents := TStringList.Create;
    try
      GFileContents.LoadFromFile(GFileName);
      if Pos(GPkgName + ' ('+GVer,GFileContents.Text) = 0 then
      begin
        GFileContents.Insert(0,'');
        GFileContents.Insert(0,'');
        GFileContents.Insert(0,' -- J. Peter Mugaas <oma00215@mail.wvnet.edu>  ' + DateTimeToInternetStr(Now) );
        GFileContents.Insert(0,'');
        GFileContents.Insert(0,'  * '+GVer);
        GFileContents.Insert(0,'');
        GFileContents.Insert(0,GPkgName+' ('+GVer+'-1) unstable; urgency=low');

        GF := TFileStream.Create(GFileName,fmCreate,fmShareExclusive);
        //We don't use  GFileContents.SaveToFile because we want a LF line-ending
        //not a CRLF.  After all, the Debian changelog is for Unix-like operating systems
        try
          for i := 0 to GFileContents.Count - 1 do
          begin
            WriteStringToStream(GF,TrimRight(GFileContents[i])+#10);
          end;
        finally
          FreeAndNil(GF);
        end;
        WriteLn('changelog updated.')
      end
      else
      begin
        WriteLn('changelog did not need update.');
      end;
    finally
      FreeAndNil(GFileContents);
    end;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
