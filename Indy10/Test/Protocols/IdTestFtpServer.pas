unit IdTestFtpServer;

interface

uses
  IdSys,
  IdTest,
  IdTcpClient,
  IdIOHandlerStack,
  IdLogDebug,
  IdFtp,
  IdFtpServer;

type

  TIdTestFtpServer = class(TIdTest)
  published
    procedure TestBasic;
  end;

implementation

procedure TIdTestFtpServer.TestBasic;
var
	s:TIdFTPServer;
	c:TIdTCPClient;
	aStr:string;
const
	cGreeting='HELLO';
	cTestFtpPort=20021;
begin
	s:=TIdFTPServer.Create(nil);
	c:=TIdTCPClient.Create(nil);
	try
		c.IOHandler := TIdIOHandlerStack.Create;
		c.IOHandler.Intercept := TIdLogDebug.Create;
		TIdLogDebug(c.IOHandler.Intercept).Active := true;

		s.Greeting.Text.Text:=cGreeting;
		s.DefaultPort:=cTestFtpPort;
		s.Active:=True;

		c.Port:=cTestFtpPort;
		c.Host:='127.0.0.1';
		c.Connect;
		c.IOHandler.ReadTimeout:=500;

		//expect a greeting. typical="220 FTP Server Ready."
		aStr:=c.IOHandler.Readln;
		Assert(aStr = '220 ' + cGreeting, cGreeting);

		//ftp server should only process a command after crlf
		//see TIdFTPServer.ReadCommandLine
		c.IOHandler.Write('U');
		aStr:=c.IOHandler.Readln;
		Assert(aStr='',aStr);

		//complete the rest of the command
		c.IOHandler.WriteLn('SER ANONYMOUS');
		aStr:=c.IOHandler.Readln;
		Assert(aStr<>'',aStr);

		//attempt to start a transfer when no datachannel setup.
		//should give 550 error?

		//typical quit='221 Goodbye.'

	finally
		Sys.FreeAndNil(c);
		Sys.FreeAndNil(s);
	end;
end;


initialization

  TIdTest.RegisterTest(TIdTestFtpServer);

end.
