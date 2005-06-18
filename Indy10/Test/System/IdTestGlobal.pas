unit IdTestGlobal;

interface

uses
	IdTest,
	IdGlobal;

type
	TIdTestGlobal = class(TIdTest)
	published
		procedure TestToBytes;
	end;

implementation

procedure TIdTestGlobal.TestToBytes;
const
	cTestString1 = 'U';
var
	cTestBytes1 : TIdBytes;
begin
//	cTestBytes1[0] := 85;
	Assert(ToBytes(cTestString1)[0] = 85);
end;

initialization
	TIdTest.RegisterTest(TIdTestGlobal);
end.