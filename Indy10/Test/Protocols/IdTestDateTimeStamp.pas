unit IdTestDateTimeStamp;

interface

uses
  IdTest,
  IdDateTimeStamp,
  //IdObjs,
  IdSys;

type

  TIdTestDateTimeStamp = class(TIdTest)
  published
    procedure TestSet;
  end;

implementation

procedure TIdTestDateTimeStamp.TestSet;
var
 D: TIdDateTimeStamp;
const
 cYear=2005;
 cMonth=12;
 cDay=31;
begin
 D := TIdDateTimeStamp.Create(nil);
 try
 D.SetFromTDateTime(Sys.EncodeDate(cYear, cMonth, cDay));
 Assert(d.Year=cYear);
 Assert(d.MonthOfYear=cMonth);
 Assert(D.DayOfMonth=cDay);
 finally
   Sys.FreeAndNil(d);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestDateTimeStamp);

end.
