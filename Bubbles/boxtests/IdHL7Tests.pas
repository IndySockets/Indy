{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11263: IdHL7Tests.pas 
{
{   Rev 1.0    11/12/2002 09:18:56 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit IdHL7Tests;

interface

uses
  TestFramework,
  IdHL7;

type
  TIdHL7Tests = class(TTestCase)
  Private
    procedure MessageReply(Sender: TObject; Msg: String; var VHandled: Boolean; var Reply: String);
  Published
    procedure TestConnection;
    procedure TestConnectionLimit;
    procedure TestSyncForwards;
    procedure TestSyncBackwards;
    procedure TestSyncForwards1000;
    procedure TestSyncBackwards1000;
  end;

implementation

uses windows, sysutils;

const
  TEST_PORT = 20032; // err, we hope that this is unused

  { TIdHL7Tests }

procedure TIdHL7Tests.MessageReply(Sender: TObject; Msg: String; var VHandled: Boolean; var Reply: String);
begin
  VHandled := True;
  reply := Msg + 'Return';
end;

procedure TIdHL7Tests.TestConnection;
var
  FIn: TIdHL7;
  FOut: TIdHL7;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.Port := TEST_PORT;
    FIn.IsListener := True;
    FIn.OnReceiveMessage := MessageReply;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.IsListener := False;
      FOut.Address := 'localhost';
      FOut.Port := TEST_PORT;
      FOut.Start;
      sleep(500);
      Check(FIn.Connected and FOut.Connected);
      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

procedure TIdHL7Tests.TestConnectionLimit;
var
  FIn: TIdHL7;
  FOut, FOut2: TIdHL7;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.ConnectionLimit := 1;
    FIn.Port := TEST_PORT;
    FIn.IsListener := True;
    FIn.OnReceiveMessage := MessageReply;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.Address := 'localhost';
      FOut.Port := TEST_PORT;
      FOut.IsListener := False;
      FOut.Start;
      sleep(500);

      FOut2 := TIdHL7.Create(NIL);
      try
        FOut2.CommunicationMode := cmSynchronous;
        FOut2.Address := 'localhost';
        FOut2.Port := TEST_PORT;
        FOut2.IsListener := False;
        FOut2.Start;
        sleep(500);

        Check(FIn.Connected and FOut.Connected and not FOut2.connected);
        FOut2.PreStop;
        FOut2.Stop;
      finally
        FOut2.Free;
        end;

      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

procedure TIdHL7Tests.TestSyncForwards;
var
  FIn: TIdHL7;
  FOut: TIdHL7;
  FMsg: String;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.Port := TEST_PORT;
    FIn.OnReceiveMessage := MessageReply;
    FIn.IsListener := True;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.IsListener := False;
      FOut.Address := 'localhost';
      FOut.Port := TEST_PORT;
      FOut.Start;
      sleep(500);
      check(FOut.SynchronousSend('test', FMsg) = srOK);
      check(FMsg = 'testReturn');
      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

procedure TIdHL7Tests.TestSyncBackwards;
var
  FIn: TIdHL7;
  FOut: TIdHL7;
  FMsg: String;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.Address := 'localhost';
    FIn.Port := TEST_PORT;
    FIn.IsListener := True;
    FIn.OnReceiveMessage := MessageReply;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.IsListener := False;
      FOut.Port := TEST_PORT;
      FOut.Start;
      sleep(500);
      check(FOut.SynchronousSend('test', FMsg) = srOK);
      check(FMsg = 'testReturn');
      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

procedure TIdHL7Tests.TestSyncForwards1000;
var
  FIn: TIdHL7;
  FOut: TIdHL7;
  FMsg: String;
  i: Integer;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.Port := TEST_PORT;
    FIn.OnReceiveMessage := MessageReply;
    FIn.IsListener := True;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.IsListener := False;
      FOut.Address := 'localhost';
      FOut.Port := TEST_PORT;
      FOut.Start;
      sleep(500);
      for i := 0 to 1000 do
        begin
        check(FOut.SynchronousSend('test' + IntToStr(i), FMsg) = srOK);
        check(FMsg = 'test' + IntToStr(i) + 'Return');
        end;
      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

procedure TIdHL7Tests.TestSyncBackwards1000;
var
  FIn: TIdHL7;
  FOut: TIdHL7;
  FMsg: String;
  i: Integer;
begin
  FIn := TIdHL7.Create(NIL);
  try
    FIn.CommunicationMode := cmSynchronous;
    FIn.Address := 'localhost';
    FIn.Port := TEST_PORT;
    FIn.IsListener := True;
    FIn.OnReceiveMessage := MessageReply;
    FIn.Start;
    FOut := TIdHL7.Create(NIL);
    try
      FOut.CommunicationMode := cmSynchronous;
      FOut.IsListener := False;
      FOut.Port := TEST_PORT;
      FOut.Start;
      sleep(500);
      for i := 0 to 1000 do
        begin
        check(FOut.SynchronousSend('test' + IntToStr(i), FMsg) = srOK);
        check(FMsg = 'test' + IntToStr(i) + 'Return');
        end;
      FOut.PreStop;
      FOut.Stop;
    finally
      FOut.Free;
      end;
    FIn.PreStop;
    FIn.Stop;
  finally
    FIn.Free;
    end;
end;

Initialization
  TestFramework.RegisterTest(TIdHL7Tests.Suite);
end.
