unit IdTestStack;

interface

uses
	IdTest,
	IdStack;

type
	TIdTestStack = class(TIdTest)
	published
		procedure TestConversionSmallInt;
	end;

implementation

procedure TIdTestStack.TestConversionSmallInt;
var
	TempInt: SmallInt;
begin
	TIdStack.IncUsage;
	try
		TempInt := 55;
		TempInt := GStack.HostToNetwork(TempInt);
		TempInt := GStack.NetworkToHost(TempInt);
		Assert(TempInt = 55);
	finally
		TIdStack.DecUsage;
	end;
end;

initialization
	TIdTest.RegisterTest(TIdTestStack);
end.