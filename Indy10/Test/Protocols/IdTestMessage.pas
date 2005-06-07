unit IdTestMessage;

interface

uses
  IdTest,
  IdSys,
  IdMessage;

type

  TIdTestMessage = class(TIdTest)
  published
    procedure TestAddresses;
  end;

implementation

procedure TIdTestMessage.TestAddresses;
//check that an address string is parsed correctly
var
 m:TIdMessage;
const
 cAddress1='abc@example.com';
 cAddress2='tuv.xyz@example.co.uk';
begin
 m:=TIdMessage.Create(nil);
 try
 m.ReplyTo.EMailAddresses:=cAddress1+';'+cAddress2;
 Assert(m.ReplyTo.Count=2);
 Assert(m.ReplyTo.Items[0].Address=cAddress1);
 Assert(m.ReplyTo.Items[1].Address=cAddress2);
 finally
 Sys.FreeAndNil(m);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestMessage);

end.
