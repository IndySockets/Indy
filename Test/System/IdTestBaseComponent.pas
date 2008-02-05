unit IdTestBaseComponent;

interface

uses
  IdTest,
  IdBaseComponent,
  IdObjs,
  IdSys;

type

  TIdTestInitializerComponent = class(TIdTest)
  published
    procedure TestInitializerComponent;
  end;

implementation

procedure TIdTestInitializerComponent.TestInitializerComponent;
var
	c: TIdInitializerComponent;
begin
	c := TIdInitializerComponent.Create;
	try
		Assert(c.Owner = nil);
	finally
		sys.FreeAndNil(c);
	end;
end;


initialization

  TIdTest.RegisterTest(TIdTestInitializerComponent);

end.