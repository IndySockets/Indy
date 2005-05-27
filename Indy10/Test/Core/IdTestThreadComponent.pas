unit IdTestThreadComponent;

interface

uses
  IdTest,
  IdSys,
  IdThreadComponent;

type

  TIdThreadComponentAccess = class(TIdThreadComponent)
  end;

  TIdTestThreadComponent = class(TIdTest)
  private
    procedure Callback(Sender:TIdThreadComponent);
  published
    procedure TestLoaded;
  end;

implementation

procedure TIdTestThreadComponent.Callback;
begin
end;

procedure TIdTestThreadComponent.TestLoaded;
//check for AV bug if component is loaded with an terminate event
var
 c:TIdThreadComponent;
begin
 c:=TIdThreadComponent.Create(nil);
 try
 c.OnTerminate:=Self.Callback;
 TIdThreadComponentAccess(c).Loaded;
 finally
 Sys.FreeAndNil(c);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestThreadComponent);

end.
