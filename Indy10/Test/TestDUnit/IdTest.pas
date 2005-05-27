unit IdTest;

//provides adapter from Indy tests to the delphi DUnit test framework
//http://dunit.sourceforge.net

interface

uses
  TestFramework;

type
  
  TIdTest = class(TTestCase)
  public
    class procedure RegisterTest(const aClass:TTestCaseClass);
  end;

implementation

class procedure TIdTest.RegisterTest(const aClass:TTestCaseClass);
begin
 TestFramework.RegisterTest('Indy',TTestSuite.Create(aClass));
end;

end.
