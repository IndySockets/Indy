unit IdTestTcpClient;

interface

uses
	IdTest;

type
	TIdTestTcpClient = class(TIdTest)
	published
		procedure TestTimeouts;
	end;

implementation

procedure TIdTestTcpClient.TestTimeouts;
begin
{
	Make some test regarding the readtimeout property and the atimeout param
	of some methods. be sure to use the loopbackiohandler used in cmdtcpclient
	test too.

	So the methods needing tests include:
		+	WriteChar
		+	ReadChar
		+	WriteString
		+	ReadString
		+	WriteBytes
		+	ReadBytes
		+	WriteInteger
		+	ReadInteger

	Try for some of them the timeout stuff. the ReadTimeout property is the default.
	It defaults to -1 (IdTimeoutInfinite). When ReadTimeout is set, that's the 
	default for all read* methods. when a specific read method has a ATimeout property,
	try setting that one to see if it overrides the ReadTimeout property.
}
end;

end.