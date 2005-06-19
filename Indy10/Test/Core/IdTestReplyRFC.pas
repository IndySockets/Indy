unit IdTestReplyRFC;

interface

uses
	IdTest,
	IdReplyRFC,
	IdGlobal,
	IdObjs,
	IdSys;

type
	TIdTestReplyRFC = class(TIdTest)
	published
		procedure TestFormattedReply;
	end;

implementation

procedure TIdTestReplyRFC.TestFormattedReply;
var
  aStr:string;
  R1: TIdReplyRFC;
  R2: TIdReplyRFC;
const
  CText = 'Hello, World!';
  CCode = '201';
begin
  R1 := TIdReplyRFC.Create(nil);
  R2 := TIdReplyRFC.Create(nil);
  try
    R1.Code := CCode;
    R1.Text.Text := CText;
    aStr:=r1.FormattedReply.Text;
    Assert(aStr=CCode+' '+CText+EOL, '1:' + AStr);

    //check that assign works. eg used in TIdCmdTCPServer.DoConnect
    R2.Assign(R1);
    Assert(R2.Code = CCode, '2:' + R2.Code);
    aStr := R2.Text.Text;
    Assert(aStr = CText + EOL, '3:' + aStr);

  finally
    Sys.FreeAndNil(R1);
    Sys.FreeAndNil(R2);
  end;
end;

initialization
	TIdTest.RegisterTest(TIdTestReplyRFC);
end.