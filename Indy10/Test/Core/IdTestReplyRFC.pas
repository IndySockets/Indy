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
	R1: TIdReplyRFC;
	R2: TIdReplyRFC;
const
	CText = 'Hello, World!';
	CCode = '201';
begin
	R1 := TIdReplyRFC.Create(nil);
	try
		R2 := TIdReplyRFC.Create(nil);
		try
			R1.Code := CCode;
			R1.Text.Text := CText;
			R2.FormattedReply := R1.FormattedReply;
			Assert(R2.Code = CCode, R2.Code);
			Assert(R2.Text.Text = CText + EOL, R2.Text.Text);
		finally
			Sys.FreeAndNil(R2);
		end;
	finally
		Sys.FreeAndNil(R1);
	end;
end;

initialization
	TIdTest.RegisterTest(TIdTestReplyRFC);
end.