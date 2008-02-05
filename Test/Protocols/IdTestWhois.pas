unit IdTestWhois;

interface

uses
  IdTest,
  IdSys,
  IdWhois;

type

  TIdTestWhois = class(TIdTest)
  published
    procedure TestBasic;
  end;

implementation

procedure TIdTestWhois.TestBasic;
var
 w:TIdWhois;
 s:string;
begin
 w:=TIdWhois.Create(nil);
 try
  s:=w.WhoIs('www.google.com');
  Assert(s<>'');
 finally
  Sys.FreeAndNil(w);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestWhois);
  
end.
