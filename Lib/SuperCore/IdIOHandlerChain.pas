{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.6    9/16/2004 8:11:40 PM  JPMugaas
  Should compile again.

  Rev 1.5    6/11/2004 8:39:58 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.4    2004.05.06 1:47:26 PM  czhower
  Now uses IndexOf

  Rev 1.3    2004.04.13 10:37:56 PM  czhower
  Updates

  Rev 1.2    2004.03.07 11:46:08 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.1    2004.02.09 9:16:44 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:38:56 AM  czhower
  Move

  Rev 1.6    2003.10.24 10:37:38 AM  czhower
  IdStream

  Rev 1.5    2003.10.19 4:38:32 PM  czhower
  Updates

  Rev 1.4    2003.10.19 2:50:40 PM  czhower
  Fiber cleanup

  Rev 1.3    2003.10.14 11:17:02 PM  czhower
  Updates to match core changes.

  Rev 1.2    2003.10.11 5:43:30 PM  czhower
  Chained servers now functional.

  Rev 1.1    2003.09.19 10:09:40 PM  czhower
  Next stage of fiber support in servers.

  Rev 1.0    8/16/2003 11:09:08 AM  JPMugaas
  Moved from Indy Core dir as part of package reorg

  Rev 1.49    2003.07.17 4:42:06 PM  czhower
  More IOCP improvements.

  Rev 1.45    2003.07.14 11:46:46 PM  czhower
  IOCP now passes all bubbles.

  Rev 1.43    2003.07.14 1:10:52 AM  czhower
  Now passes all bubble tests for chained stack.

  Rev 1.41    7/7/2003 1:34:06 PM  BGooijen
  Added WriteFile(...)

  Rev 1.40    7/3/2003 2:03:52 PM  BGooijen
  IOCP works server-side now

  Rev 1.39    2003.06.30 5:41:54 PM  czhower
  -Fixed AV that occurred sometimes when sockets were closed with chains
  -Consolidated code that was marked by a todo for merging as it no longer
  needed to be separate
  -Removed some older code that was no longer necessary

  Passes bubble tests.

  Rev 1.38    6/29/2003 10:56:26 PM  BGooijen
  Removed .Memory from the buffer, and added some extra methods

  Rev 1.37    2003.06.25 4:30:02 PM  czhower
  Temp hack fix for AV problem. Working on real solution now.

  Rev 1.36    6/24/2003 11:17:44 PM  BGooijen
  change in TIdIOHandlerChain.ReadLn, LTermPos= 0 is now handled differently

  Rev 1.35    23/6/2003 22:33:18  GGrieve
  fix CheckForDataOnSource - specify timeout

  Rev 1.34    6/22/2003 11:22:22 PM  JPMugaas
  Should now compile.

  Rev 1.33    6/4/2003 1:08:40 AM  BGooijen
  Added CheckForDataOnSource and removed some (duplicate) code

  Rev 1.32    6/3/2003 8:07:20 PM  BGooijen
  Added TIdIOHandlerChain.AllData

  Rev 1.31    5/11/2003 2:37:58 PM  BGooijen
  Bindings are updated now

  Rev 1.30    5/11/2003 12:00:08 PM  BGooijen

  Rev 1.29    5/11/2003 12:03:16 AM  BGooijen

  Rev 1.28    2003.05.09 10:59:24 PM  czhower

  Rev 1.27    2003.04.22 9:48:50 PM  czhower

  Rev 1.25    2003.04.17 11:01:14 PM  czhower

  Rev 1.19    2003.04.10 10:51:04 PM  czhower

  Rev 1.18    4/2/2003 3:39:26 PM  BGooijen
  Added Intercepts

  Rev 1.17    3/29/2003 5:53:52 PM  BGooijen
  added AfterAccept

  Rev 1.16    3/27/2003 2:57:58 PM  BGooijen
  Added a RawWrite for streams, implemented WriteStream, changed
  WriteToDestination to use TIdWorkOpUnitWriteBuffer

  Rev 1.15    2003.03.26 12:20:28 AM  czhower
  Moved visibility of execute to protected.

  Rev 1.14    3/25/2003 11:07:58 PM  BGooijen
  ChainEngine descends now from TIdBaseComponent

  Rev 1.13    3/25/2003 01:33:48 AM  JPMugaas
  Fixed compiler warnings.

  Rev 1.12    3/24/2003 11:03:50 PM  BGooijen
  Various fixes to readln:
  - uses connection default now
  - doesn't raise an exception on timeout any more

  Rev 1.11    2003.03.13 1:22:58 PM  czhower
  Typo fixed. lenth --> Length

  Rev 1.10    3/13/2003 10:18:20 AM  BGooijen
  Server side fibers, bug fixes

  Rev 1.9    3/2/2003 12:36:22 AM  BGooijen
  Added woReadBuffer and TIdWorkOpUnitReadBuffer to read a buffer. Now
  ReadBuffer doesn't use ReadStream any more.
  TIdIOHandlerChain.ReadLn now supports MaxLineLength (splitting, and
  exceptions).
  woReadLn doesn't check the intire buffer any more, but continued where it
  stopped the last time.
  Added basic support for timeouts (probably only on read operations, and maybe
  connect), accuratie of timeout is currently 500msec.

  Rev 1.8    2/28/2003 10:15:16 PM  BGooijen
  bugfix: changed some occurrences of FRecvBuffer to FInputBuffer

  Rev 1.7    2/27/2003 10:11:12 PM  BGooijen

  Rev 1.6    2/26/2003 1:08:52 PM  BGooijen

  Rev 1.5    2/25/2003 10:36:28 PM  BGooijen
  Added more opcodes, methods, and moved opcodes to separate files.

  Rev 1.4    2003.02.25 9:02:32 PM  czhower
  Hand off to Bas

  Rev 1.3    2003.02.25 1:36:04 AM  czhower

  Rev 1.2    2002.12.11 11:00:58 AM  czhower

  Rev 1.1    2002.12.07 12:26:06 AM  czhower

  Rev 1.0    11/13/2002 08:45:00 AM  JPMugaas
}
unit IdIOHandlerChain;

interface

uses
  Classes,
  IdBaseComponent, IdBuffer, IdGlobal, IdIOHandler, IdIOHandlerSocket,
  IdFiber, IdThreadSafe, IdWorkOpUnit, IdStackConsts, IdWinsock2, IdThread,
  IdFiberWeaver, IdStream, IdStreamVCL,
  Windows;

type
  TIdConnectMode = (cmNonBlock, cmIOCP);
  TIdIOHandlerChain = class;
  TIdChainEngineThread = class;

  TIdChainEngine = class(TIdBaseComponent)
  protected
    FCompletionPort: THandle;
    FThread: TIdChainEngineThread;
    //
    procedure Execute;
    function GetInputBuffer(const AIOHandler: TIdIOHandler): TIdBuffer;
    procedure InitComponent; override;
    procedure SetIOHandlerOptions(AIOHandler: TIdIOHandlerChain);
    procedure Terminating;
  public
    procedure AddWork(AWorkOpUnit: TIdWorkOpUnit);
    procedure BeforeDestruction; override;
    destructor Destroy; override;
    procedure RemoveSocket(AIOHandler: TIdIOHandlerChain);
    procedure SocketAccepted(AIOHandler: TIdIOHandlerChain);
  end;

  TIdIOHandlerChain = class(TIdIOHandlerSocket)
  protected
    FChainEngine: TIdChainEngine;
    FConnectMode: TIdConnectMode;
    FFiber: TIdFiber;
    FFiberWeaver: TIdFiberWeaver;
    FOverlapped: PIdOverlapped;
    //
    procedure ConnectClient; override;
    procedure QueueAndWait(
      AWorkOpUnit: TIdWorkOpUnit;
      ATimeout: Integer = IdTimeoutDefault;
      AFreeWorkOpUnit: Boolean = True;
      AAllowGracefulException: Boolean = True
      );
    procedure WorkOpUnitCompleted(
      AWorkOpUnit: TIdWorkOpUnit
      );
  public
    procedure AfterAccept; override;
    function AllData: string; override;
    procedure CheckForDataOnSource(
      ATimeout : Integer = 0
      ); override;
    procedure CheckForDisconnect(
      ARaiseExceptionIfDisconnected: Boolean = True;
      AIgnoreBuffer: Boolean = False
      ); override;
    constructor Create(
      AOwner: TComponent;
      AChainEngine: TIdChainEngine;
      AFiberWeaver: TIdFiberWeaver;
      AFiber: TIdFiber
      ); reintroduce; virtual;
    destructor Destroy; override;
    procedure Open; override;
    function ReadFromSource(ARaiseExceptionIfDisconnected: Boolean = True;
     ATimeout: Integer = IdTimeoutDefault;
     ARaiseExceptionOnTimeout: Boolean = True): Integer; override;
    procedure ReadStream(AStream: TIdStreamVCL; AByteCount: Int64;
      AReadUntilDisconnect: Boolean);  override;
    // TODO: Allow ReadBuffer to by pass the internal buffer. Will it really
    // help? Only ReadBuffer would be able to use this optimiztion in most
    // cases and it is not used by many. Most calls are to stream (disk) based
    // or strings as ReadLn.
    procedure ReadBytes(var VBuffer: TIdBytes; AByteCount: Integer; AAppend: Boolean = True);
     override;
    function ReadLn(
      ATerminator: string = LF;
      ATimeout: Integer = IdTimeoutDefault;
      AMaxLineLength: Integer = -1
      ): string;
      override;
//  function WriteFile(
//    AFile: string;
//    AEnableTransferFile: Boolean
//    ): Cardinal; override;
    function WriteFile(
      const AFile: String;
      AEnableTransferFile: Boolean): Int64; override;
{    procedure Write(
      AStream: TIdStream;
      ASize: Integer = 0;
      AWriteByteCount: Boolean = False);
      override;  }
    procedure Write(
      AStream: TIdStreamVCL;
      ASize: Int64 = 0;
      AWriteByteCount: Boolean = False
      ); override;
    procedure WriteDirect(
      ABuffer: TIdBytes
      ); override;
    //
    property ConnectMode: TIdConnectMode read FConnectMode write FConnectMode;
    property Overlapped: PIdOverlapped read FOverlapped;
  end;

  TIdChainEngineThread = class(TIdThread)
  protected
    FChainEngine: TIdChainEngine;
  public
    constructor Create(
      AOwner: TIdChainEngine;
      const AName: string
      ); reintroduce;
    procedure Run; override;
    property Terminated;
  end;

implementation

uses
  IdComponent, IdException, IdExceptionCore, IdStack, IdResourceStrings, IdWorkOpUnits,
  IdStackBSDBase, IdStackWindows,
  SysUtils;

const
  GCompletionKeyTerminate = $F0F0F0F0;

{ TIdIOHandlerChain }

procedure TIdIOHandlerChain.CheckForDataOnSource(ATimeout: Integer = 0);
begin
  // TODO: Change this so we dont have to rely on an exception trap
  try
    QueueAndWait(TIdWorkOpUnitReadAvailable.Create, ATimeout, True, False);
  except
    on E: EIdReadTimeout do begin
      // Nothing
    end else begin
      raise;
    end;
  end;
end;

procedure TIdIOHandlerChain.ConnectClient;
begin
  // TODO: Non blocking does not support Socks
  Binding.OverLapped := (ConnectMode = cmIOCP);
  inherited;
  case ConnectMode of
    cmNonBlock: begin
      //TODO: Non blocking DNS resolution too?
      Binding.SetPeer(GStack.ResolveHost(Host), Port);
      GBSDStack.SetBlocking(Binding.Handle, False);
      // Does not block
      Binding.Connect;
    end;
    cmIOCP: begin
      //TODO: For now we are doing blocking, just to get it to work. fix later
      // IOCP was not designed for connects, so we'll have to do some monkeying
      // maybe even create an engine thread just to watch for connect events.
      //TODO: Resolution too?
      Binding.SetPeer(GStack.ResolveHost(Host), Port);
      Binding.Connect;
      GBSDStack.SetBlocking(Binding.Handle, False);
    end;
    else begin
      raise EIdException.Create('Unrecognized ConnectMode'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
    end;
  end;
  QueueAndWait(TIdWorkOpUnitWaitConnected.Create);

  //Update the bindings
  Binding.UpdateBindingLocal;
  //TODO: Could Peer binding ever be other than what we specified above? Need to reread it?
  Binding.UpdateBindingPeer;
end;

procedure TIdIOHandlerChain.AfterAccept;
begin
  FChainEngine.SocketAccepted(self);
end;

procedure TIdIOHandlerChain.Open;
begin
  // Things before inherited, inherited actually connects and ConnectClient
  // needs these things
  inherited;
end;

procedure TIdIOHandlerChain.CheckForDisconnect(
  ARaiseExceptionIfDisconnected: Boolean; AIgnoreBuffer: Boolean);
var
  LDisconnected: Boolean;
begin
  // ClosedGracefully // Server disconnected
  // IOHandler = nil // Client disconnected
  if ClosedGracefully then begin
    if BindingAllocated then begin
      Close;
      // Call event handlers to inform the user program that we were disconnected
//      DoStatus(hsDisconnected);
      //DoOnDisconnected;
    end;
    LDisconnected := True;
  end else begin
    LDisconnected := not BindingAllocated;
  end;
  if LDisconnected then begin
    // Do not raise unless all data has been read by the user
    if Assigned(FInputBuffer) then begin
      if ((FInputBuffer.Size = 0) or AIgnoreBuffer)
       and ARaiseExceptionIfDisconnected then begin
        RaiseConnClosedGracefully;
      end;
    end;
  end;
end;

function TIdIOHandlerChain.ReadFromSource(
 ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
 ARaiseExceptionOnTimeout: Boolean): Integer;
begin
  Result := 0;
  raise EIdException.Create('Fall through error in ' + ClassName); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdIOHandlerChain.ReadStream(AStream: TIdStreamVCL; AByteCount: Int64;
      AReadUntilDisconnect: Boolean);
begin
  if AReadUntilDisconnect then begin
    QueueAndWait(TIdWorkOpUnitReadUntilDisconnect.Create(AStream.VCLStream), -1
     , True, False);
  end else begin
    QueueAndWait(TIdWorkOpUnitReadSizedStream.Create(AStream.VCLStream, AByteCount));
  end;
end;

procedure TIdIOHandlerChain.ReadBytes(var VBuffer: TIdBytes;
 AByteCount: Integer; AAppend: Boolean = True);
begin
  EIdException.IfFalse(AByteCount >= 0);
  if AByteCount > 0 then begin
    if FInputBuffer.Size < AByteCount then begin
      QueueAndWait(TIdWorkOpUnitReadSized.Create(AByteCount- FInputBuffer.Size));
    end;
    Assert(FInputBuffer.Size >= AByteCount);
    FInputBuffer.ExtractToBytes(VBuffer, AByteCount, AAppend);
  end;
end;

function TIdIOHandlerChain.ReadLn(ATerminator: string = LF;
  ATimeout: Integer = IdTimeoutDefault; AMaxLineLength: Integer = -1): string;
var
  LTermPos: Integer;
begin
  if AMaxLineLength = -1 then begin
    AMaxLineLength := MaxLineLength;
  end;
  // User may pass '' if they need to pass arguments beyond the first.
  if ATerminator = '' then begin
    ATerminator := LF;
  end;
  FReadLnSplit := False;
  FReadLnTimedOut := False;
  try
    LTermPos := FInputBuffer.IndexOf(ATerminator) + 1;
    if (LTermPos = 0) and ((AMaxLineLength = 0)
     or (FInputBuffer.Size < AMaxLineLength)) then begin
      QueueAndWait(TIdWorkOpUnitReadLn.Create(ATerminator, AMaxLineLength)
       , ATimeout);
      LTermPos := FInputBuffer.IndexOf(ATerminator) + 1;
    end;
    // LTermPos cannot be 0, and the code below can't handle it properly
    Assert(LTermPos > 0);
    if (AMaxLineLength <> 0) and (LTermPos > AMaxLineLength) then begin
      case FMaxLineAction of
        // TODO: find the right exception class here
        maException: raise EIdException.Create('MaxLineLength exceded'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
        maSplit: Result := FInputBuffer.Extract(AMaxLineLength);
      end;
    end else begin
      Result := FInputBuffer.Extract(LTermPos - 1);
      if (ATerminator = LF) and (Copy(Result, Length(Result), 1) = CR) then begin
        Delete(Result, Length(Result), 1);
      end;
      FInputBuffer.Extract(Length(ATerminator));// remove the terminator
    end;
  except on E: EIdReadTimeout do
    FReadLnTimedOut := True;
  end;
end;

function TIdIOHandlerChain.AllData: string;
var
  LStream: TStringStream;
begin
  BeginWork(wmRead); try
    Result := '';
    LStream := TStringStream.Create(''); try
      QueueAndWait(TIdWorkOpUnitReadUntilDisconnect.Create(LStream), -1
       , True, False);
      Result := LStream.DataString;
    finally FreeAndNil(LStream); end;
  finally EndWork(wmRead); end;
end;

function TIdIOHandlerChain.WriteFile(
      const AFile: String;
      AEnableTransferFile: Boolean): Int64;
var
  LWO:TIdWorkOpUnitWriteFile;
begin
  //BGO: we ignore AEnableTransferFile for now
  Result := 0;
//  if not Assigned(Intercept) then begin
    LWO := TIdWorkOpUnitWriteFile.Create(AFile);
    try
      QueueAndWait(LWO,IdTimeoutDefault, false);
    finally
//      Result := LWO.BytesSent;
      FreeAndNil(LWO);
    end;
//  end else begin
//    inherited WriteFile(AFile, AEnableTransferFile);
//  end;
end;

procedure TIdIOHandlerChain.Write(
      AStream: TIdStreamVCL;
      ASize: Int64 = 0;
      AWriteByteCount: Boolean = False
      );
var
  LStart: Integer;
  LThisSize: Integer;
begin
  if ASize < 0 then begin //"-1" All form current position
    LStart := AStream.VCLStream.Seek(0, soFromCurrent);
    ASize := AStream.VCLStream.Seek(0, soFromEnd) - LStart;
    AStream.VCLStream.Seek(LStart, soFromBeginning);
  end else if ASize = 0 then begin //"0" ALL
    LStart := 0;
    ASize := AStream.VCLStream.Seek(0, soFromEnd);
    AStream.VCLStream.Seek(0, soFromBeginning);
  end else begin //else ">0" ACount bytes
    LStart := AStream.VCLStream.Seek(0, soFromCurrent);
  end;

  if AWriteByteCount then begin
  	Write(ASize);
  end;

//  BeginWork(wmWrite, ASize);
  try
    while ASize > 0 do begin
      LThisSize := Min(128 * 1024, ASize); // 128K blocks
      QueueAndWait(TIdWorkOpUnitWriteStream.Create(AStream.VCLStream, LStart, LThisSize
       , False));
      Dec(ASize, LThisSize);
      Inc(LStart, LThisSize);
    end;
  finally
//    EndWork(wmWrite);
  end;
end;

procedure TIdIOHandlerChain.WriteDirect(
  ABuffer: TIdBytes
  );
begin
  QueueAndWait(TIdWorkOpUnitWriteBuffer.Create(@ABuffer[0], Length(ABuffer), False));
end;

procedure TIdIOHandlerChain.QueueAndWait(
  AWorkOpUnit: TIdWorkOpUnit;
  ATimeout: Integer = IdTimeoutDefault;
  AFreeWorkOpUnit: Boolean = True;
  AAllowGracefulException: Boolean = True
  );
var
  LWorkOpUnit: TIdWorkOpUnit;
begin
  try
    CheckForDisconnect(AAllowGracefulException);
    LWorkOpUnit := AWorkOpUnit;
    //
    if ATimeout = IdTimeoutInfinite then begin
      LWorkOpUnit.TimeOutAt := 0;
    end else begin
      if ATimeout = IdTimeoutDefault then begin
        if FReadTimeout <= 0 then begin
          LWorkOpUnit.TimeOutAt := 0;
        end else begin
          //we type cast FReadTimeOut as a cardinal to prevent the compiler from
          //expanding vars to an Int64 type.  That can incur a performance penalty.
          LWorkOpUnit.TimeOutAt := GetTickCount + Cardinal(FReadTimeout);
        end
      end else begin
        //FReadTimeOut is typecase as a cardinal to prevent the compiler from
        //expanding vars to an Int64 type which can incur a performance penalty.
        LWorkOpUnit.TimeOutAt := GetTickCount + Cardinal(ATimeout);
      end
    end;
    //
    LWorkOpUnit.Fiber := FFiber;
    LWorkOpUnit.IOHandler := Self;
    LWorkOpUnit.OnCompleted := WorkOpUnitCompleted;
    LWorkOpUnit.SocketHandle := Binding.Handle;
    // Add to queue and wait to be rescheduled when work is completed
    FChainEngine.AddWork(LWorkOpUnit);
    // Check to see if we need to reraise an exception
    LWorkOpUnit.RaiseException;
    // Check for timeout
    if LWorkOpUnit.TimedOut then begin
      raise EIdReadTimeout.Create('Timed out'); {do not localize}
    end;
    // Check to see if it was closed during this operation
    CheckForDisconnect(AAllowGracefulException);
  finally
    if AFreeWorkOpUnit then begin
      AWorkOpUnit.Free;
    end;
  end;
end;

constructor TIdIOHandlerChain.Create(
  AOwner: TComponent;
  AChainEngine: TIdChainEngine;
  AFiberWeaver: TIdFiberWeaver;
  AFiber: TIdFiber
  );
begin
  inherited Create(AOwner);
  //
  EIdException.IfNotAssigned(AChainEngine, 'No chain engine specified.'); {do not localize}
  FChainEngine := AChainEngine;
  FChainEngine.SetIOHandlerOptions(Self);
  //
  EIdException.IfNotAssigned(AFiberWeaver, 'No fiber weaver specified.'); {do not localize}
  FFiberWeaver := AFiberWeaver;
  //
  EIdException.IfNotAssigned(AFiber, 'No fiber specified.'); {do not localize}
  FFiber := AFiber;
  // Initialize Overlapped structure
  New(FOverlapped);
  ZeroMemory(FOverlapped, SizeOf(TIdOverLapped));
  New(FOverlapped.Buffer);
end;

procedure TIdIOHandlerChain.WorkOpUnitCompleted(AWorkOpUnit: TIdWorkOpUnit);
begin
  FFiberWeaver.Add(AWorkOpUnit.Fiber);
end;

destructor TIdIOHandlerChain.Destroy;
begin
  // Tell the chain engine that we are closing and to remove any references to
  // us and cease any usage.
  // Do not do this in close, it can cause deadlocks because the engine can
  // call close while in its Execute.
  FChainEngine.RemoveSocket(Self);
  Dispose(FOverlapped.Buffer);
  Dispose(FOverlapped);
  inherited;
end;

{ TIdChainEngine }

procedure TIdChainEngine.BeforeDestruction;
begin
  if FThread <> nil then begin
    // Signal thread for termination
    FThread.Terminate;
    // Tell the engine we are attempting termination
    Terminating;
    // Wait for the thread to terminate
    FThread.WaitFor;
    // Free thread
    FreeAndNil(FThread);
  end;
  inherited;
end;

function TIdChainEngine.GetInputBuffer(const AIOHandler:TIdIOHandler):TidBuffer;
begin
  Result := TIdIOHandlerChain(AIOHandler).FInputBuffer;
end;

procedure TIdChainEngine.SetIOHandlerOptions(AIOHandler: TIdIOHandlerChain);
begin
  AIOHandler.ConnectMode := cmIOCP;
end;

procedure TIdChainEngine.SocketAccepted(AIOHandler: TIdIOHandlerChain);
begin
  // Associate the socket with the completion port.
  if CreateIoCompletionPort(AIOHandler.Binding.Handle, FCompletionPort, 0, 0)
   = 0 then begin
    RaiseLastOSError;
  end;
end;

procedure TIdChainEngine.Terminating;
begin
  if not PostQueuedCompletionStatus(FCompletionPort, 0, GCompletionKeyTerminate
   , nil) then begin
    RaiseLastOSError;
  end;
end;

procedure TIdChainEngine.Execute;
var
  LBytesTransferred: DWord;
  LCompletionKey: DWord;
  LOverlapped: PIdOverlapped;
begin
  // Wait forever on the completion port.  If we are terminating, a terminate
  // signal is sent into the queue.
  if GetQueuedCompletionStatus(FCompletionPort, LBytesTransferred
   , LCompletionKey, POverLapped(LOverlapped), INFINITE) then begin
    if LCompletionKey <> GCompletionKeyTerminate then begin
      // Socket has been closed
      if LBytesTransferred = 0 then begin
        LOverlapped.WorkOpUnit.IOHandler.CloseGracefully;
      end;
      LOverlapped.WorkOpUnit.Process(LOverlapped, LBytesTransferred);
    end;
  end;
end;

procedure TIdChainEngine.RemoveSocket(AIOHandler: TIdIOHandlerChain);
begin
//  raise EIdException.Create('Fall through error in ' + Self.ClassName+'.RemoveSocket'); // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdChainEngine.AddWork(AWorkOpUnit: TIdWorkOpUnit);
begin
  if AWorkOpUnit is TIdWorkOpUnitWaitConnected then begin
    // Associate the socket with the completion port.
    if CreateIOCompletionPort(AWorkOpUnit.SocketHandle, FCompletionPort, 0, 0)
     = 0 then begin
      RaiseLastOSError;
    end;
    AWorkOpUnit.Complete;
  end;
  AWorkOpUnit.Start;
end;

destructor TIdChainEngine.Destroy;
begin
  if CloseHandle(FCompletionPort) = False then begin
    RaiseLastOSError;
  end;
  inherited;
end;

procedure TIdChainEngine.InitComponent;
begin
{
var SysInfo: TSystemInfo;
  GetSystemInfo(SysInfo);
  SysInfo.dwNumberOfProcessors

Use GetSystemInfo instead. It will return the all info on the local
system's architecture and will also return a valid ActiveProcessorMask
which is a DWORD to be read as a bit array of the processor on the
system...

CZH> And next
CZH> question - any one know off hand how to set affinity? :)

Use the SetProcessAffinityMask or SetThreadAffinityMask API depending
on wether you want to act on the whole process or just a single
thread (SetThreadIdealProcessor is another way to do it: it just gives
the scheduler a hint about where to run a thread without forcing it:
good for keeping two threads doing IO one with each other on the same
processor).
}
  inherited;
  if not (csDesigning in ComponentState) then begin
    // Cant use .Name, its not initialized yet in Create
    FThread := TIdChainEngineThread.Create(Self, 'Chain Engine'); {do not localize}
  end;
  //MS says destruction is automatic, but Google seems to say that this initial
  //one is not auto managed as MS says, and that CloseHandle should be called.
  FCompletionPort := CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, 0);
  if FCompletionPort = 0 then begin
    RaiseLastOSError;
  end;
end;

{ TIdChainEngineThread }

constructor TIdChainEngineThread.Create(
  AOwner: TIdChainEngine;
  const AName: string
  );
begin
  FChainEngine := AOwner;
  inherited Create(False, True, AName);
end;

(*procedure TIdChainEngineIOCP.TransmitFileIOCP(const AWorkOpUnit:TIdWorkOpUnitWriteFile;const AFilename:string);
var
  LPOverlapped: PIdOverlapped;
  LHFile:THandle;
begin
  New(LPOverlapped);
  ZeroMemory(LPOverlapped,sizeof(TIdOverLapped));
  New(LPOverlapped^.Buffer);
  LPOverlapped^.IOhandler:=TIdIOHandlerChain(AWorkOpUnit.IOhandler);
  LPOverlapped^.WorkOpUnit:=AWorkOpUnit;
  LHFile:=CreateFile(pchar(AFilename),GENERIC_READ,FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_FLAG_SEQUENTIAL_SCAN,0);
  if LHFile=INVALID_HANDLE_VALUE then begin
    RaiseLastOSError;
  end;
  try
    if ServiceQueryTransmitFile(AWorkOpUnit.IOHandler.Binding.Handle,LHFile,0,0,POverlapped(LPOverlapped),nil,0) then begin
      AWorkOpUnit.Fiber.Relinquish;
    end else begin
      raise EIdException.Create('error in ServiceQueryTransmitFile'); // TODO: add a resource string, and create a new Exception class for this
    end;
  finally
    CloseHandle(LHFile);
  end;
end;
*)
(*procedure TIdChainEngineIOCP.TransmitFileAsStream(const AWorkOpUnit:TIdWorkOpUnitWriteFile;const AFilename:string);

  procedure CopyWorkUnit(ASrc,ADst: TIdWorkOpUnit);
  begin
    ADst.IOHandler   := ASrc.IOHandler;
    ADst.Fiber       := ASrc.Fiber;
    ADst.OnCompleted := ASrc.OnCompleted;
    ADst.SocketHandle:= ASrc.SocketHandle;
  end;

var
  LStream:TfileStream;
  LWorkOpUnit : TIdWorkOpUnitWriteStream;

  LBuf:pointer;
  LBufLen:integer;
begin
Assert(False, 'to do');
  LStream := TFileStream.Create(AFilename,fmOpenRead or fmShareDenyWrite);
  try
    LWorkOpUnit := TIdWorkOpUnitWriteStream.Create(LStream,0,LStream.size,false);
    try
      CopyWorkUnit(AWorkOpUnit,LWorkOpUnit);
      LBufLen:=Min(LStream.size,128*1024);
      getmem(LBuf,LBufLen);
      LWorkOpUnit.Stream.Position:=LWorkOpUnit.StartPos;
      LWorkOpUnit.Stream.Read(LBuf^,LBufLen);
      IssueWriteBuffer(LWorkOpUnit,LBuf,LBufLen);
    finally
      AWorkOpUnit.BytesSent := LStream.Size;
      LWorkOpUnit.free;
    end;
  finally
    LStream.free;
  end;
end;
*)

procedure TIdChainEngineThread.Run;
begin
  FChainEngine.Execute;
end;

end.

