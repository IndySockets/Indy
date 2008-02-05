{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18311: TCPServer.pas }
{
{   Rev 1.18    2004.01.19 8:51:06 PM  czhower
{ No comment
}
{
{   Rev 1.17    2003.07.17 4:48:16 PM  czhower
{ Removed IdChainEngineStack
}
{
    Rev 1.16    7/14/2003 10:13:06 PM  BGooijen
  Added tcpserver test with IOCP
}
{
{   Rev 1.15    2003.07.11 4:07:46 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.14    2003.07.11 3:56:28 PM  czhower
{ Fixed to match changes in Indy.
}
{
{   Rev 1.13    6/24/2003 01:13:40 PM  JPMugaas
{ Updates for minor API change.
}
{
    Rev 1.12    6/4/2003 11:53:52 PM  BGooijen
  Removed tcpserver test with IOCP
}
{
    Rev 1.11    6/4/2003 9:40:28 PM  BGooijen
  Added tcpserver test with IOCP
}
{
    Rev 1.10    4/22/2003 11:50:52 PM  BGooijen
  Added Connect disconnect test
}
{
{   Rev 1.9    2003.04.22 4:12:04 PM  czhower
}
{
{   Rev 1.8    2003.04.16 8:20:14 PM  czhower
}
{
    Rev 1.7    4/16/2003 5:13:02 PM  BGooijen
}
{
{   Rev 1.6    2003.04.16 1:32:30 PM  czhower
}
{
{   Rev 1.5    2003.04.16 1:26:48 PM  czhower
}
{
    Rev 1.4    4/15/2003 8:28:50 PM  BGooijen
}
{
    Rev 1.3    4/15/2003 8:18:52 PM  BGooijen
}
{
    Rev 1.2    4/15/2003 8:12:54 PM  BGooijen
}
unit TCPServer;

interface

uses
  SysUtils, Classes, BXBubble, Forms, IdContext, IdServerIOHandler, IdScheduler,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TdmodTCPServer = class(TDataModule)
    TCPServer: TBXBubble;
    TCPServerPool: TBXBubble;
    TCPClient: TIdTCPClient;
    TCPServerFibersIOCP: TBXBubble;
    procedure TCPServerTest(Sender: TBXBubble);
    procedure TCPServerPoolTest(Sender: TBXBubble);
    procedure TCPServerFibersIOCPTest(Sender: TBXBubble);
  protected
    FBubble: TBXBubble;
    procedure DoClient(const APort: integer);
    procedure DoServer(const AIOHandler: TIdServerIOHandler; const AScheduler:TIdScheduler);
    procedure ServerExecute(AContext:TIdContext);
  public
  end;

var
  dmodTCPServer: TdmodTCPServer;

implementation
{$R *.dfm}

{ TdmodTCPServer }
uses
  IdCoreGlobal, IdTCPServer, IdServerIOHandlerChain, IdSchedulerOfFiber,
  IdSchedulerOfThreadPool, IdIOHandlerChain,
  BXGlobal;

procedure TdmodTCPServer.DoClient(const APort: integer);
var
  i, j: integer;
  LStream: TMemoryStream;
  LTime: LongWord;
begin
  FBubble.Check((APort = 6000) or (APort = 7000), 'Port mismatch.');
  with TCPClient do begin
    Port := APort;
    FBubble.Status('Connect and text test.');
    for i := 1 to 10 do begin
      FBubble.Status('  Test #' + IntToStr(i));
      Connect; try
        for j := 1 to 10 do begin
          SendCmd('Text ' + IntToStr(j), 200);
          FBubble.Check(StrToInt(IOHandler.ReadLn) = j * 2
           , 'Response string does not match.');
        end;
        SendCmd('Quit', 200);
      finally Disconnect; end;
    end;
    FBubble.Status('');
    FBubble.Status('Sized stream test.');
    Connect; try
      SendCmd('Stream', 200);
      LStream := TMemoryStream.Create; try
        LTime := Ticks;
todo;
//        IOHandler.ReadStream(LStream);
        LTime := Ticks - LTime;
        FBubble.Status(IntToStr(LStream.Size) + ' bytes read in ' + IntToStr(LTime));
      finally FreeAndNil(LStream); end;
      SendCmd('Quit', 200);
    finally Disconnect; end;
    FBubble.Status('Sized stream test complete.');
    FBubble.Status('');
    FBubble.Status('Unsized stream test.');
    Connect; try
      SendCmd('Stream Disconnect', 200);
      LStream := TMemoryStream.Create; try
        LTime := Ticks;
        IOHandler.ReadCardinal; // Throw away length byte
todo;
//        IOHandler.ReadStream(LStream, -1, True);
        LTime := Ticks - LTime;
        FBubble.Status(IntToStr(LStream.Size) + ' bytes read in ' + IntToStr(LTime));
      finally FreeAndNil(LStream); end;
    finally Disconnect; end;
    FBubble.Status('Unsized stream test complete.');
    FBubble.Status('');
    FBubble.Status('Connect disconnect test.');
    Connect;
    Disconnect;
    FBubble.Status('Connect disconnect test complete.');
  end;
end;

procedure TdmodTCPServer.ServerExecute(AContext:TIdContext);
var
  i: integer;
  s: string;
  LCmd: string;
  LParams: string;
  LStream: TMemoryStream;
begin
  with AContext.Connection do begin
    LParams := IOHandler.ReadLn;
    LCmd := Fetch(LParams);
    if AnsiSameText(LCmd, 'Text') then begin
      IOHandler.WriteLn('200 Ok');
      IOHandler.WriteLn(IntToStr(StrToInt(LParams) * 2));
    end else if AnsiSameText(LCmd, 'Stream') then begin
      IOHandler.WriteLn('200 Stream follows');
      SetLength(s, 256);
      for i := 0 to Length(s) - 1 do begin
        s[i + 1] := Chr(i and 255);
      end;
      LStream := TMemoryStream.Create; try
        LStream.SetSize(Length(s) * 4096); // 1MB
        for i := 1 to LStream.Size div Length(s) do begin
          LStream.WriteBuffer(s[1], Length(s));
        end;
todo;
//        AContext.Connection.IOHandler.WriteStream(LStream, 0, True);
      finally FreeAndNil(LStream); end;
      if AnsiSameText(LParams, 'Disconnect') then begin
        Disconnect;
      end;
    end else if AnsiSameText(LCmd, 'Quit') then begin
      IOHandler.WriteLn('200 Goodbye');
      Disconnect;
    end;
  end;
end;

procedure TdmodTCPServer.DoServer(const AIOHandler: TIdServerIOHandler; const AScheduler:TIdScheduler);
begin
  with TIdTCPServer.Create(nil) do try
    IOHandler := AIOHandler;
    Scheduler := AScheduler;
    DefaultPort := 6000;
    OnExecute := ServerExecute;
    Active := True;
    DoClient(Bindings[0].Port);

    FBubble.Status('Testing server reset.');
    Active := False;
    Active := True;
    DoClient(Bindings[0].Port);

    FBubble.Status('Testing multiple bindings.');
    Active := False;
    Bindings.Add.Port := 7000;
    Active := True;
    DoClient(7000);
  finally Free; end;
end;

procedure TdmodTCPServer.TCPServerTest(Sender: TBXBubble);
begin
  FBubble := Sender;
  DoServer(nil, nil);
end;

procedure TdmodTCPServer.TCPServerPoolTest(Sender: TBXBubble);
var
 LScheduler:TIdScheduler;
begin
  FBubble := Sender;
  LScheduler:=TIdSchedulerOfThreadPool.Create(nil);
  try
    DoServer(nil,LScheduler);
  finally
    FreeAndNil(LScheduler);
  end;
end;

procedure TdmodTCPServer.TCPServerFibersIOCPTest(Sender: TBXBubble);
var
 LIOHandler: TIdServerIOHandler;
 LScheduler:TIdScheduler;
begin
  FBubble := Sender;
  LIOHandler := TIdServerIOHandlerChain.Create(nil); try
    TIdServerIOHandlerChain(LIOHandler).ChainEngine
     := TIdChainEngine.Create(nil); try
      LScheduler:=TIdSchedulerOfFiber.Create(nil); try
        DoServer(LIOHandler,LScheduler);
      finally FreeAndNil(LScheduler); end;
    finally
      TIdServerIOHandlerChain(LIOHandler).ChainEngine.Free;
      TIdServerIOHandlerChain(LIOHandler).ChainEngine := nil;
    end;
  finally FreeAndNil(LIOHandler); end;
end;

end.
