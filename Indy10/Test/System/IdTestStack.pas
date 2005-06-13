unit IdTestStack;

interface

uses
	IdTest,
	IdStack;

type
	TIdTestStack = class(TIdTest)
	published
		procedure TestConversionShortInt;
	end;

implementation

procedure TIdTestStack.TestConversionShortInt;
//he problem here is that smallint is being cast to int64 in .net,
//whereas under win32 it's cast as word (which is the same size)
var
	TempInt: ShortInt;
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