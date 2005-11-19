unit IdTestIOHandler;

interface

uses
  IdTest,
  IdIOHandler,
  IdObjs,
  IdStream,
  IdIntercept,
  IdExceptionCore,
  IdResourceStringsCore,
  IdGlobal,
  IdSys;

type

  //reads and writes to its own inputbuffer, makes easy to test
  TIdLoopbackIOHandler = class(TIdIOHandler)
  protected
    function ReadFromSource(
     ARaiseExceptionIfDisconnected: Boolean;
     ATimeout: Integer;
     ARaiseExceptionOnTimeout: Boolean
     ): Integer; override;
  public
    procedure CheckForDataOnSource(ATimeout:Integer); override;
    procedure CheckForDisconnect(
     ARaiseExceptionIfDisconnected: Boolean;
     AIgnoreBuffer: Boolean
     ); override;
    procedure WriteDirect(var ABuffer: TIdBytes); override;
  end;

  TIdExampleIntercept = class(TIdConnectionIntercept)
  public
    procedure Send(var ABuffer: TIdBytes); override;
  end;

  TIdTestIOHandler = class(TIdTest)
  private
    procedure RunStream(const io:TIdIOHandler;const aLarge:Boolean);
  published
    procedure TestReadWrite;
    procedure TestReadLn;
    procedure TestStreamSize;
    procedure TestIntercept;
    procedure TestWriteBuffered;
    procedure TestBuffered;
  end;

implementation

const
  cStr='abc123';
  //for intercept test
  cPlain='abcdef';
  cEncoded='123456';

procedure TIdLoopbackIOHandler.CheckForDataOnSource(ATimeout: Integer);
begin
 // inherited;
end;

procedure TIdLoopbackIOHandler.CheckForDisconnect;
begin
 // inherited;
end;

function TIdLoopbackIOHandler.ReadFromSource(
  ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
  ARaiseExceptionOnTimeout: Boolean): Integer;
begin
 //always report a timeout happened, ie there's no more data expected
 Result:=-1;
 EIdReadTimeout.IfTrue(ARaiseExceptionOnTimeout and (Result = -1), RSReadTimeout);

end;

procedure TIdLoopbackIOHandler.WriteDirect(var ABuffer: TIdBytes);
begin
  inherited;
  FInputBuffer.Write(abuffer);
end;

procedure TIdTestIOHandler.RunStream(const io: TIdIOHandler;const aLarge:Boolean);
//given iohandler in large/smallfile mode, check read/write ok
var
 aStream:TIdStringStream;
 aStr:string;
begin
 io.InputBuffer.Clear;
 io.LargeStream:=aLarge;
 aStream:=TIdStringStream.Create(cStr);
 try
 //write the stream to the iohandler
 io.Write(aStream,0,True);
 //buffer should contain length+data. stream unchanged.
 Assert(io.InputBuffer.Size>0);
 Assert(aStream.DataString=cStr);

 //reset and read
 aStream.Size:=0;
 io.ReadStream(aStream,-1);
 aStream.Position:=0;
 aStr:=aStream.DataString;
 Assert(aStr=cStr);

 finally
 Sys.FreeAndNil(aStream);
 end;

end;

procedure TIdTestIOHandler.TestBuffered;
var
  io:TIdLoopbackIOHandler;
begin
  io:=TIdLoopbackIOHandler.Create(nil);
  try
    io.Open;
    io.WriteBufferOpen(2);

    //check that writes less than buffer size arent sent
    io.Write('1');
    Assert(io.InputBufferAsString='');

    //write >1 buffersize of data, check all is sent
    io.Write('2345');
    Assert(io.InputBufferAsString='1234');
  finally
    Sys.FreeAndNil(io);
  end;

end;

procedure TIdTestIOHandler.TestIntercept;
var
  io:TIdLoopbackIOHandler;
  aStr:string;
  aIntercept:TIdExampleIntercept;
begin
  io:=TIdLoopbackIOHandler.Create(nil);
  aIntercept:=TIdExampleIntercept.Create;
  try
    io.Intercept:=aIntercept;
    io.Open;

    //check that the intercept actually changes data that gets written
    io.Write(cPlain);
    aStr:=io.InputBuffer.AsString;
    Assert(aStr=cEncoded,aStr);

    //todo test nested intercepts
  finally
    Sys.FreeAndNil(io);
    Sys.FreeAndNil(aIntercept);
  end;

end;

procedure TIdTestIOHandler.TestReadLn;
//tests that read timeout happens
var
  io:TIdLoopbackIOHandler;
  aStr:string;
const
  cPart='U';
begin
  io:=TIdLoopbackIOHandler.Create(nil);
  try
    io.Open;

    //check with no data in buffer
    aStr:=io.Readln;
    Assert(aStr = '');

    //check with some data in buffer
    io.Write(cPart);
    aStr:=io.Readln;
    Assert(aStr = '');

    //check that buffer still contains expected data
    Assert(io.FInputBuffer.Size = 1, Sys.IntToStr(io.FInputBuffer.Size));

    //complete the data line
    io.WriteLn('');
    aStr:=io.Readln;
    Assert(aStr = cPart);
    Assert(io.FInputBuffer.Size = 0);

  finally
    Sys.FreeAndNil(io);
  end;

end;

procedure TIdTestIOHandler.TestReadWrite;
//use specific cast variables in the write calls to ensure correct
//overload is called
var
 io:TIdLoopbackIOHandler;
 aInt:Integer;
 aInt64:Int64;
 aSmall:Smallint;
 aStr:string;
 aCardinal:Cardinal;
 aChar:Char;
const
 cInt=High(Integer)-1;
 cCard=Cardinal(4000000000);
 cInt64=Low(Int64)+1;
 cSmall=High(Smallint)-1;
 cChar='x';
begin
 io:=TIdLoopbackIOHandler.Create(nil);
 try
 io.Open;
 //should check with/without conversion parameter
 //should also check edge cases, eg high/low

 //test with no data in buffer
 //aChar:=io.ReadChar;
 //Assert(aChar=#0);

 //integer types
 Assert(io.FInputBuffer.Size=0);
 aSmall:=cSmall;
 io.Write(aSmall,True);
 Assert(io.FInputBuffer.Size>0);
 aSmall:=io.ReadSmallInt(True);
 Assert(aSmall=cSmall);
 Assert(io.FInputBuffer.Size=0);

 aInt:=cInt;
 io.Write(aInt,True);
 aInt:=io.ReadInteger(True);
 Assert(aInt=cInt);
 Assert(io.FInputBuffer.Size=0);

 aCardinal:=cCard;
 io.Write(aCardinal,True);
 aCardinal:=io.ReadCardinal(True);
 Assert(aCardinal=cCard);
 Assert(io.FInputBuffer.Size=0);

 aInt64:=cInt64;
 io.Write(aInt64,True);
 aInt64:=io.ReadInt64(True);
 Assert(aInt64=cInt64);
 Assert(io.FInputBuffer.Size=0);

 //string types

 aChar:=cChar;
 io.Write(aChar);
 aChar:=io.ReadChar;
 Assert(aChar=cChar);
 Assert(io.FInputBuffer.Size=0);

 //test normal readln
 aStr:=cStr;
 io.WriteLn(aStr);
 Assert(io.FInputBuffer.Size>0);
 aStr:=io.Readln;
 Assert(aStr=cStr,aStr);
 Assert(io.FInputBuffer.Size=0);

 finally
 Sys.FreeAndNil(io);
 end;
end;

procedure TIdTestIOHandler.TestStreamSize;
var
 io:TIdLoopbackIOHandler;
begin
 io:=TIdLoopbackIOHandler.Create(nil);
 try
 io.Open;

 //integer-size stream
 RunStream(io,False);
 //int64 streams
 RunStream(io,True);

 finally
 Sys.FreeAndNil(io);
 end;

end;

procedure TIdExampleIntercept.Send(var ABuffer: TIdBytes);
begin
  inherited;
  ABuffer:=ToBytes(cEncoded);
end;

procedure TIdTestIOHandler.TestWriteBuffered;
var
  io:TIdLoopbackIOHandler;
  aStr:string;
  aIntercept:TIdExampleIntercept;
begin
  io:=TIdLoopbackIOHandler.Create(nil);
  aIntercept:=TIdExampleIntercept.Create;
  try
    io.Open;

    Assert(not io.WriteBufferingActive);
    io.WriteBufferOpen;
    Assert(io.WriteBufferingActive);

    //write some data. it should not be sent
    io.Write(cStr);
    aStr:=io.InputBuffer.AsString;
    Assert(aStr='');

    //flush the buffer. data should now be sent
    io.WriteBufferFlush;
    aStr:=io.InputBuffer.AsString;
    Assert(aStr=cStr);

    io.WriteBufferClose;

    //todo test threshhold. currently not implemented

    //leave the writebuffer open, to check for memory leaks
    io.WriteBufferOpen;
    //if writebuffer has contents when iohandler closed, should it
    //be flushed by iohandler?
  finally
    Sys.FreeAndNil(io);
    Sys.FreeAndNil(aIntercept);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestIOHandler);

end.
