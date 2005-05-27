unit IdTest;

{
uses rtti helper from
http://chris.lichti.org/Lab/RTTI_Lib/RTTI_Lib.shtml

demonstrates how to use rtti to discover and call published methods
}

interface

uses
  classes,
  sysutils,
  clRtti,
  btTest;

type

  TIdTest = class;
  TIdTestClass = class of TIdTest;

  TIdTestMethod = procedure of object;

  //TIdTest adapts indy's test classes to my test framework
  TIdTest = class(TbtTest)
  protected
    //this is what my test framework calls
    procedure btDoTest;override;
  public
    //this is the only method that has to be provided
    class procedure RegisterTest(const aClass:TbtTestClass);
  end;

implementation

procedure TIdTest.btDoTest;
var
 i:Integer;
 aList:TStringList;
 aMethod:TMethod;
 aObjMethod:TIdTestMethod;
begin
 inherited;
 aList:=TStringList.Create;
 try
 //build list of published methods for this class
 GetMethodList(Self,aList);

 //for each method, check it runs without failure
 for i:=0 to aList.Count-1 do
  begin
  aMethod.Code:=Pointer(aList.Objects[i]);
  aMethod.Data:=Self;
  aObjMethod:=TIdTestMethod(aMethod);
  //run the test
  //aTest.DoBeforeTest;
  try
   btExpectPass(aObjMethod);
  finally
  // aTest.DoAfterTest;
  end;
 end;

 finally
 FreeAndNil(aList);
 end;
end;

class procedure TIdTest.RegisterTest(const aClass:TbtTestClass);
begin
 //singleton list where test classes are registered in my framework
 SbtTestClassList.Add(aClass);
end;

end.
