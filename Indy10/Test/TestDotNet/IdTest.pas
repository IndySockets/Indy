unit IdTest;

{
minimal/example test runner for .net/mono
feel free to improve this code
for example, better format for the output
}

interface

uses
  System.Reflection,
  System.Threading,
  IdObjs,
  IdBaseComponent;

type

  TIdTest = class;
  TIdTestClass = class of TIdTest;

  TOutputStringProcedure = procedure(const AString: string);

  TIdTest = class(TIdBaseComponent)
  private
    FOnOutputString: TOutputStringProcedure;
  protected
    procedure SetUp; virtual;
    procedure TearDown; virtual;
  public
    procedure OutputLn(const ALine: string);
    class procedure RegisterTest(const aClass:TIdTestClass);
    class function TestList:TIdList;
    property OnOutputString: TOutputStringProcedure read FOnOutputString write FOnOutputString;
  end;

  TIdBasicRunner = class(TObject)
  private
    FLockObj: &Object;
    FDebugInfo: Boolean;
    procedure WriteLn(const aStr:string);
    procedure WriteOutput(const AString: string);
    procedure RecordPass(const aTest:TIdTest;const aMethod:string);
    procedure RecordFail(const aTest:TIdTest;const aMethod:string;const e:exception);
    procedure WriteString(const AString: string);
  public
    PassCount:integer;
    FailCount:integer;
    constructor Create;
    procedure Execute;
  end;

implementation

var
 // this should really be a classlist
 FRegisterList:TIdList;

class procedure TIdTest.RegisterTest(const aClass: TIdTestClass);
begin
 TestList.Add(aClass.Create);
end;

class function TIdTest.TestList: TIdList;
begin
  if FRegisterList=nil then
  begin
    FRegisterList:=TIdList.Create;
  end;
  Result:=FRegisterList;
end;

procedure TIdTest.OutputLn(const ALine: string);
begin
  if Assigned(FOnOutputString) then
  begin
    FOnOutputString(ALine + Environment.NewLine);
  end;
end;

{ TIdBasicRunner }

constructor TIdBasicRunner.Create;
  function ShouldOutputDebuggingInfo: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to High(Environment.GetCommandLineArgs) do
      Result := Result or (Environment.GetCommandLineArgs[i].ToLower = '/debug');
  end;
begin
  inherited;
  FLockObj := &Object.Create;
  FDebugInfo := ShouldOutputDebuggingInfo;
end;

procedure TIdBasicRunner.WriteOutput(const AString: string);
begin
  WriteString('INFO: ' + AString);
end;

procedure TIdBasicRunner.WriteString(const AString: string);
begin
  if FDebugInfo then
  begin
    Monitor.Enter(FLockObj);
    try
      Console.Write('    ' + AString);
    finally
      Monitor.Exit(FLockObj);
    end;
  end;
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
    aTest.OnOutputString := WriteOutput;
    aMethods:=aTest.GetType.GetMethods;

    WriteLn('Test:'+aTest.classname);

    for aMethodCount:=low(aMethods) to high(aMethods) do
    begin
      aMethod:=aMethods[aMethodCount];
      if not aMethod.Name.StartsWith('Test') then continue;

      try
        WriteLn('  ' + aMethod.Name);
        aTest.SetUp;
        try
        aMethod.Invoke(aTest,[]);
        finally
        aTest.TearDown;
        end;
        //commented out, makes easier to see the fails
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
  WriteString('Passed' + Environment.NewLine);
end;

procedure TIdBasicRunner.RecordFail(const aTest: TIdTest; const aMethod: string;
  const e: exception);
var
  ie:TargetInvocationException;
begin
  inc(failcount);
  WriteLn('  Fail:');

  //this exception is raised as we are calling methods using reflection
  if e is TargetInvocationException then
  begin
    ie:=e as TargetInvocationException;
    WriteLn('    '+ie.InnerException.classname+':'+ie.InnerException.Message);
    WriteLn(ie.InnerException.StackTrace);
  end else begin
    WriteLn('    '+e.classname);
  end;
end;

procedure TIdBasicRunner.WriteLn(const aStr: string);
begin
  Monitor.Enter(FLockObj);
  try
    Console.WriteLine(AStr);
  finally
    Monitor.Exit(FLockObj);
  end;
end;

procedure TIdTest.SetUp;
begin
end;

procedure TIdTest.TearDown;
begin
end;

end.
