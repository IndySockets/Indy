unit IdTestSMTPServer;

interface

uses
  IdGlobal,
  IdReplySMTP,
  IdTCPClient,
  IdSMTPServer,
  IdMessage,
  IdObjs,
  IdSMTP,
  IdSys,
  IdTest;

type

  TIdTestSMTPServer = class(TIdTest)
  private
    FReceivedMsg:TIdMessage;
    procedure CallbackRcptTo(ASender: TIdSMTPServerContext; const AAddress : string;
    var VAction : TIdRCPToReply; var VForward : string);
    procedure CallbackMsgReceive(ASender: TIdSMTPServerContext; AMsg : TIdStream2;var LAction : TIdDataReply);
  published
    //could enhance to a more complete TestDialogue
    procedure TestGreeting;
    procedure TestReceive;
  end;

implementation

procedure TIdTestSMTPServer.CallbackMsgReceive(
  ASender: TIdSMTPServerContext; AMsg: TIdStream2;
  var LAction: TIdDataReply);
begin
 AMsg.Position:=0;
 FReceivedMsg.LoadFromStream(AMsg);
end;

procedure TIdTestSMTPServer.CallbackRcptTo(ASender: TIdSMTPServerContext;
  const AAddress: string; var VAction: TIdRCPToReply;
  var VForward: string);
begin
 VAction:=rAddressOk;
end;

procedure TIdTestSMTPServer.TestGreeting;
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

procedure TIdTestSMTPServer.TestReceive;
//do a round-trip message send using smtp client and server
var
 aServer:TIdSMTPServer;
 aClient:TIdSMTP;
 aMessage:TIdMessage;
const
 cSubject='mysubject';
 cBody='1,2,3';
 cAddress='a@b.com';
 cPriority:TIdMessagePriority=mpHigh;
begin
 FReceivedMsg:=TIdMessage.Create(nil);
 aClient:=TIdSMTP.Create(nil);
 aServer:=TIdSMTPServer.Create(nil);
 aMessage:=TIdMessage.Create(nil);
 try

 aServer.OnMsgReceive:=CallbackMsgReceive;
 aServer.OnRcptTo:=CallbackRcptTo;
 aServer.DefaultPort:=20202;
 aServer.Active:=True;

 aClient.Port:=20202;
 aClient.Host:='127.0.0.1';
 aClient.Connect;

 aMessage.Subject:=cSubject;
 aMessage.Body.CommaText:=cBody;
 aMessage.Recipients.Add.Address:=cAddress;
 aMessage.Priority:=cPriority;
 aClient.Send(aMessage);

 //check that what we received is same as sent
 Assert(FReceivedMsg.Subject=cSubject);
 Assert(FReceivedMsg.Body.CommaText=cBody);
 Assert(FReceivedMsg.Recipients.EMailAddresses=cAddress);
 Assert(FReceivedMsg.Priority=cPriority);
 //also check the "Received:" header
 //also check attachments

 finally
 Sys.FreeAndNil(FReceivedMsg);
 Sys.FreeAndNil(aMessage);
 Sys.FreeAndNil(aClient);
 Sys.FreeAndNil(aServer);
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestSMTPServer);

end.
