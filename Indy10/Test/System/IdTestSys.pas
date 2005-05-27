unit IdTestSys;

interface

uses
  IdTest,
  IdSys;

type

  TIdTestSys = class(TIdTest)
  published
    procedure TestStrToInt64;
    procedure TestFormat;
    procedure TestStringReplace;
  end;

implementation

const
 cLargeStr='6000000000';
 cLargeNum=6000000000;

procedure TIdTestSys.TestFormat;
var
 s:string;
begin
 s:=Sys.Format('%d',[cLargeNum]);
 assert(s=clargestr);
end;

procedure TIdTestSys.TestStringReplace;
var
 s:string;
begin
 s:=Sys.StringReplace('12',['1','2'],['a','b']);
 Assert(s='ab',s);
end;

procedure TIdTestSys.TestStrToInt64;
const
 cBadNumStr='abc';
 cDef=123;
var
 i:Int64;
begin
 i:=Sys.StrToInt64(cLargeStr);
 Assert(i=cLargeNum);

 i:=Sys.StrToInt64(cBadNumStr,cDef);
 Assert(i=cDef);
end;

initialization

  TIdTest.RegisterTest(TIdTestSys);

end.
