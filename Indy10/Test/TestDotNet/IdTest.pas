unit IdTest;

//minimal/example test runner for .net/mono
//feel free to improve this code

interface

uses
  System.Reflection,
  IdObjs,
  IdBaseComponent;

type

  TIdTest = class;
  TIdTestClass = class of TIdTest;

  TIdTest = class(TIdBaseComponent)
  public
    class procedure RegisterTest(const aClass:TIdTestClass);
    class function TestList:TIdList;
  end;

  TIdBasicRunner = class(TObject)
  private
    procedure WriteLn(const aStr:string);
    procedure RecordPass(const aTest:TIdTest;const aMethod:string);
    procedure RecordFail(const aTest:TIdTest;const aMethod:string;const e:exception);
  public
    PassCount:integer;
    FailCount:integer;
    procedure Execute;
  end;

implementation

var
 // this should really be a classlist
 aList:TIdList;

class procedure TIdTest.RegisterTest(const aClass: TIdTestClass);
begin
 TestList.Add(aClass.Create);
end;

class function TIdTest.TestList: TIdList;
begin
 if aList=nil then aList:=TIdList.Create;
 result:=alist;
end;

procedure TIdBasicRunner.Execute;
var
 aMethods:array of methodinfo;
 aMethodCount:integer;
 aTestCount:integer;
 aMethod:methodinfo;
 aTest:TIdTest;
begin

  PassCount:=0;
  FailCount:=0;

  for aTestCount:=0 to TIdTest.TestList.Count-1 do
  begin
  aTest:=TIdTest.TestList[aTestCount] as TIdTest; //aClass.Create();

  aMethods:=aTest.GetType.GetMethods;

  WriteLn('Test:'+aTest.classname);

  for aMethodCount:=low(aMethods) to high(aMethods) do
  begin
  aMethod:=aMethods[aMethodCount];
  if not aMethod.Name.StartsWith('Test') then continue;

  try
  aMethod.Invoke(aTest,[]);
  RecordPass(aTest,aMethod.name);
  except
  on e:exception do
  begin
  RecordFail(aTest,aMethod.name,e);
  end;
  end;

  end; //methods

  end; //tests

  WriteLn('Results: Pass='+PassCount.ToString+', Fail='+FailCount.ToString);

end;

procedure TIdBasicRunner.RecordPass(const aTest: TIdTest;
  const aMethod: string);
begin
 inc(PassCount);
 WriteLn('  Pass:'+aTest.classname+'.'+aMethod);
end;

procedure TIdBasicRunner.RecordFail(const aTest: TIdTest; const aMethod: string;
  const e: exception);
var
 ie:TargetInvocationException;
begin
 inc(failcount);
 WriteLn(' >Fail:'+aTest.classname+'.'+aMethod);

 //this exception is raised as we are calling methods using reflection
 if e is TargetInvocationException then
  begin
  ie:=e as TargetInvocationException;
  WriteLn('    '+ie.InnerException.classname+':'+ie.InnerException.Message);
  end
 else
  begin
  WriteLn('    '+e.classname);
  end;
end;

procedure TIdBasicRunner.WriteLn(const aStr: string);
begin
 Console.WriteLine(aStr);
end;

end.
