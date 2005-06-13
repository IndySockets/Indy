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
//the problem here is that (without the cast) smallint is being cast to int64
//is smallint ever actually used as a param?
var
	TempInt: SmallInt;
begin
	TIdStack.IncUsage;
	try
		TempInt := 55;
		TempInt := GStack.HostToNetwork(Word(TempInt));
		TempInt := GStack.NetworkToHost(Word(TempInt));
		Assert(TempInt = 55);
	finally
		TIdStack.DecUsage;
	end;
end;

initialization

	TIdTest.RegisterTest(TIdTestStack);

end.