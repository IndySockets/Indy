unit IdTestSMTPServer;

interface

uses
  IdGlobal,
  IdReplySMTP,
  IdTCPClient,
  IdSMTPServer,
  IdSys,
  IdTest;

type

  TIdTestSMTPServer = class(TIdTest)
  published
    //could enhance to a more complete TestDialogue
    procedure btTestGreeting;
  end;

implementation

procedure TIdTestSMTPServer.btTestGreeting;
var
 aServer:TIdSMTPServer;
 aClient:TIdTCPClient;
 s:string;
begin
 aClient:=TIdTCPClient.Create(nil);
 aServer:=TIdSMTPServer.Create(nil);
 try
 aServer.DefaultPort:=20202;
 aServer.Active:=True;
 //Set a specific greeting, makes easy to test
 (aServer.Greeting as TIdReplySMTP).SetEnhReply(220, '' ,'HELLO');

 aClient.Port:=20202;
 aClient.Host:='127.0.0.1';
 aClient.Connect;

 s:=aClient.IOHandler.Readln;
 //eg '220 mail.orcon.net.nz ESMTP'
 Assert(s='220 HELLO');
 aClient.Disconnect;

 finally
 Sys.FreeAndNil(aClient);
 Sys.FreeAndNil(aServer);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestSMTPServer);

end.
