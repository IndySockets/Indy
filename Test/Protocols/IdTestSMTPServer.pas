unit IdTestSMTPServer;

//odd: TIdCommandHandler.DoCommand: Response.Assign(Self.Response);

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
  IdLogDebug,
  IdTest;

type

  TIdTestSMTPServer = class(TIdTest)
  private
    FReceivedMsg:TIdMessage;
    FServer:TIdSMTPServer;
    FClient:TIdSMTP;
    FDebug:TIdLogDebug;
    //replace setup/teardown with virtuals
    procedure mySetup;
    procedure myTearDown;
    procedure CallbackRcptTo(ASender: TIdSMTPServerContext; const AAddress : string;
      var VAction : TIdRCPToReply; var VForward : string);
    procedure CallbackMsgReceive(ASender: TIdSMTPServerContext; AMsg : TIdStream;var LAction : TIdDataReply);
    procedure CallbackMailFrom(ASender: TIdSMTPServerContext; const AAddress : string;
      var VAction : TIdMailFromReply);
  published
    procedure TestGreeting;
    procedure TestReceive;
    procedure TestReject;
  end;

implementation

const
  cTestPort=20202;
  cSpammerAddress='spammer@example.com';

procedure TIdTestSMTPServer.mySetup;
begin
  Assert(FReceivedMsg=nil);
  FReceivedMsg:=TIdMessage.Create(nil);

  Assert(FServer=nil);
  FServer:=TIdSMTPServer.Create(nil);
  FServer.OnMsgReceive:=CallbackMsgReceive;
  FServer.OnRcptTo:=CallbackRcptTo;
  FServer.OnMailFrom:=CallbackMailFrom;
  FServer.DefaultPort:=cTestPort;

  FDebug:=TIdLogDebug.Create;

  Assert(FClient=nil);
  FClient:=TIdSMTP.Create(nil);
  FClient.ReadTimeout:=5000;
  FClient.Port:=cTestPort;
  FClient.Host:='127.0.0.1';
  FClient.CreateIOHandler;
  FClient.IOHandler.Intercept := FDebug;
  FDebug.Active := True;
end;

procedure TIdTestSMTPServer.myTearDown;
begin
  FDebug.Active := False;
  Sys.FreeAndNil(FDebug);
  Sys.FreeAndNil(FClient);
  Sys.FreeAndNil(FServer);
  Sys.FreeAndNil(FReceivedMsg);
end;

procedure TIdTestSMTPServer.CallbackMailFrom(ASender: TIdSMTPServerContext;
  const AAddress: string; var VAction: TIdMailFromReply);
begin
  if AAddress=cSpammerAddress then
  begin
    VAction:=mReject;
  end;
end;

procedure TIdTestSMTPServer.CallbackMsgReceive(
  ASender: TIdSMTPServerContext; AMsg: TIdStream;
  var LAction: TIdDataReply);
var
  aList:TIdStringList;
begin
  //do a precheck here.
  aList:=TIdStringList.Create;
  try
    AMsg.Position:=0;
    aList.Text:=ReadStringFromStream(AMsg);
    //should be at least headers for: received from subject to date
    //if this fails, then client hasn't written correctly, or server hasn't read
    Assert(aList.Count>=5);
  finally
    sys.FreeAndNil(aList);
  end;

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
//checks that the server returns a correct greeting
//uses tcpclient to check directly
var
  s:string;
  aClient:TIdTCPClient;
const
  cGreeting='HELLO';
begin
  aClient:=TIdTCPClient.Create(nil);
  try
    mySetup;

    //Set a specific greeting, makes easy to test
    (FServer.Greeting as TIdReplySMTP).SetEnhReply(220, '' ,cGreeting);
    FServer.Active:=True;

    aClient.Port:=cTestPort;
    aClient.Host:='127.0.0.1';
    aClient.ReadTimeout:=5000;
    aClient.Connect;

    s:=aClient.IOHandler.Readln;
    //real example '220 mail.example.com ESMTP'
    Assert(s='220 '+cGreeting);
    aClient.Disconnect;
  finally
    Sys.FreeAndNil(aClient);
    myTearDown;
  end;
end;

procedure TIdTestSMTPServer.TestReceive;
//do a round-trip message send using smtp client and server
//repeat with/without client pipelining?
var
  aMessage:TIdMessage;
const
  cFrom='bob@example.com';
  cSubject='mysubject';
  cBody='1,2,3';
  cAddress='mary@example.com';
  cPriority:TIdMessagePriority=mpHigh;
begin
  try
    mySetup;

    FServer.Active:=True;
    FClient.Connect;

    aMessage := TIdMessage.Create(nil);
    try
      aMessage.From.Address := cFrom;
      aMessage.Subject := cSubject;
      aMessage.Body.CommaText := cBody;
      //test with multiple recipients
      aMessage.Recipients.Add.Address := cAddress;
      aMessage.Priority :=cPriority;
      aMessage.Encoding := mePlaintext;
      FClient.Send(aMessage);
    finally
      Sys.FreeAndNil(aMessage);
    end;

    Assert(FClient.LastCmdResult.NumericCode =250, 'Code:' + Sys.IntToStr(FClient.LastCmdResult.NumericCode));

    //check that what the server received is same as sent
    Assert(FReceivedMsg.From.Address = cFrom, 'From:' + FReceivedMsg.From.Address);
    Assert(FReceivedMsg.Subject = cSubject, 'Subject:' + FReceivedMsg.Subject);
    Assert(FReceivedMsg.Body.CommaText = cBody, 'Body:' + FReceivedMsg.Body.CommaText);
    Assert(FReceivedMsg.Recipients.EMailAddresses = cAddress, 'To:' + FReceivedMsg.Recipients.EMailAddresses);
    Assert(FReceivedMsg.Priority = cPriority, 'Priority');
    //also check the "Received:" header
    //also check attachments

    //currently breaks due to ioHandler rev26
  finally
    myTearDown;
  end;
end;

procedure TIdTestSMTPServer.TestReject;
//check that if a message is rejected by server, (here using OnMailFrom)
//the correct status is returned.
var
  aMessage:TIdMessage;
begin

  try
    mySetup;

    FServer.Active:=True;
    FClient.Connect;

    aMessage:=TIdMessage.Create(nil);
    try
      aMessage.From.Address:=cSpammerAddress;
      aMessage.Subject:='spam';
      aMessage.Body.CommaText:='spam';
      aMessage.Recipients.Add.Address:='bob@example.com';
      try
        FClient.Send(aMessage);
      except
        //want to ignore the exception here
        //EIdSMTPReplyError
        //check class,content
        on E : Exception do
        begin
          //You can NOT do:
          //
          //Assert(FClient.LastCmdResult.NumericCode = 550, FClient.LastCmdResult.FormattedReply.Text);
          //
          //because the exception may be from a line in a pipelined sequence and
          //LastCmdResult probably contains the result from the last command in the pipelined
          //sequence
          if E is EIdSMTPReplyError then
          begin
            with (E as EIdSMTPReplyError) do
            begin
              Assert( (E as EIdSMTPReplyError).ErrorCode = 550, (E as EIdSMTPReplyError).Message);
            end;
          end;
        end;
      end;
    finally
      Sys.FreeAndNil(aMessage);
    end;

  finally
    myTearDown;
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestSMTPServer);

end.
