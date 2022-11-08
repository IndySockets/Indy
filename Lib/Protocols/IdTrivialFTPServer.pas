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
  Rev 1.6    2/7/2004 7:20:20 PM  JPMugaas
  DotNET to go!! and YES - I want fries with that :-).

  Rev 1.5    2004.02.03 5:44:38 PM  czhower
  Name changes

  Rev 1.4    1/21/2004 4:21:06 PM  JPMugaas
  InitComponent

  Rev 1.3    10/25/2003 06:52:20 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.2    2003.10.24 10:43:12 AM  czhower
  TIdSTream to dos

  Rev 1.1    2003.10.12 6:36:48 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:03:42 AM  JPMugaas
}

unit IdTrivialFTPServer;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdAssignedNumbers,
  IdGlobal,
  IdThreadSafe,
  IdTrivialFTPBase,
  IdSocketHandle,
  IdUDPServer
  {$IFDEF HAS_GENERICS_TObjectList}
  , IdThread
  {$ENDIF}
  ;

type
  TPeerInfo = record
    PeerIP: string;
    PeerPort: Integer;
  end;

  TAccessFileEvent = procedure (Sender: TObject; var FileName: String; const PeerInfo: TPeerInfo;
    var GrantAccess: Boolean; var AStream: TStream; var FreeStreamOnComplete: Boolean) of object;
  TTransferCompleteEvent = procedure (Sender: TObject; const Success: Boolean;
    const PeerInfo: TPeerInfo; var AStream: TStream; const WriteOperation: Boolean) of object;

  TIdTFTPThreadList = TIdThreadSafeObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdThread>{$ENDIF};

  TIdTrivialFTPServer = class(TIdUDPServer)
  protected
    FThreadList: TIdTFTPThreadList;
    FOnTransferComplete: TTransferCompleteEvent;
    FOnReadFile,
    FOnWriteFile: TAccessFileEvent;
    function StrToMode(mode: string): TIdTFTPMode;
  protected
    procedure DoReadFile(FileName: String; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; RequestedBlockSize: Integer; IncludeTransferSize: Boolean); virtual;
    procedure DoWriteFile(FileName: String; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; RequestedBlockSize: Integer; RequestedTransferSize: TIdStreamSize); virtual;
    procedure DoTransferComplete(const Success: Boolean; const PeerInfo: TPeerInfo; var SourceStream: TStream; const WriteOperation: Boolean); virtual;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  public
    //should deactivate server, check all threads finished, before destroying
    function ActiveThreads:Integer;
    destructor Destroy;override;
  published
    property OnReadFile: TAccessFileEvent read FOnReadFile write FOnReadFile;
    property OnWriteFile: TAccessFileEvent read FOnWriteFile write FOnWriteFile;
    property OnTransferComplete: TTransferCompleteEvent read FOnTransferComplete write FOnTransferComplete;
    property DefaultPort default IdPORT_TFTP;
  end;

implementation

uses
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.Threading,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF VCL_2010_OR_ABOVE}
    {$IFDEF WINDOWS}
  Windows,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysTime,
  {$ENDIF}
  {$IFDEF DOTNET}
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdExceptionCore,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdStack,
  {$IFNDEF HAS_GENERICS_TObjectList}
  IdThread,
  {$ENDIF}
  {$IFDEF VCL_XE3_OR_ABOVE}
  System.Types,
  {$ENDIF}
  IdUDPClient,
  SysUtils;

type
  TIdTFTPServerThread = class(TIdThread)
  protected
    FStream: TStream;
    FBlkCounter: UInt16;
    FResponse: TIdBytes;
    FRetryCtr: Integer;
    FUDPClient: TIdUDPClient;
    FRequestedBlkSize: Integer;
    FEOT, FFreeStrm: Boolean;
    FOwner: TIdTrivialFTPServer;
    procedure AfterRun; override;
    procedure BeforeRun; override;
    function HandleRunException(AException: Exception): Boolean; override;
    procedure TransferComplete;
  public
    constructor Create(AOwner: TIdTrivialFTPServer; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; AStream: TStream; const FreeStreamOnTerminate: Boolean;
      const RequestedBlockSize: Integer); reintroduce;
    destructor Destroy; override;
  end;

  TIdTFTPServerSendFileThread = class(TIdTFTPServerThread)
  private
    FSendTransferSize: Boolean;
  protected
    procedure BeforeRun; override;
    procedure Run; override;
  public
    constructor Create(AOwner: TIdTrivialFTPServer; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; AStream: TStream; const FreeStreamOnTerminate: Boolean;
      const RequestedBlockSize: Integer; SendTransferSize: Boolean); reintroduce;
  end;

  TIdTFTPServerReceiveFileThread = class(TIdTFTPServerThread)
  protected
    FTransferSize: TIdStreamSize;
    FReceivedSize: TIdStreamSize;
  protected
    procedure BeforeRun; override;
    {$IFNDEF DOTNET}
    function HandleRunException(AException: Exception): Boolean; override;
    {$ENDIF}
    procedure Run; override;
  public
    constructor Create(AOwner: TIdTrivialFTPServer; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; AStream: TStream; const FreeStreamOnTerminate: Boolean;
      const RequestedBlockSize: Integer; const RequestedTransferSize: TIdStreamSize); reintroduce;
  end;

{ TIdTrivialFTPServer }

procedure TIdTrivialFTPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_TFTP;
  FThreadList := TIdTFTPThreadList.Create;
end;

procedure TIdTrivialFTPServer.DoReadFile(FileName: String; const Mode: TIdTFTPMode;
  const PeerInfo: TPeerInfo; RequestedBlockSize: Integer; IncludeTransferSize: Boolean);
var
  CanRead,
  FreeOnComplete: Boolean;
  LStream: TStream;
begin
  CanRead := True;
  LStream := nil;
  FreeOnComplete := True;

  {$IFNDEF DOTNET}
  try
  {$ENDIF}

    if Assigned(FOnReadFile) then begin
      FOnReadFile(Self, FileName, PeerInfo, CanRead, LStream, FreeOnComplete);
    end;
    if not CanRead then begin
      raise EIdTFTPAccessViolation.CreateFmt(RSTFTPAccessDenied, [FileName]);
    end;
    if LStream = nil then begin
      LStream := TIdReadFileExclusiveStream.Create(FileName);
      FreeOnComplete := True;
    end;

    TIdTFTPServerSendFileThread.Create(Self, Mode, PeerInfo, LStream, FreeOnComplete, RequestedBlockSize, IncludeTransferSize);

  {$IFNDEF DOTNET}
  except
    // TODO: implement this in a platform-neutral manner.  EFOpenError is VCL-specific
    on E: EFOpenError do begin
      IndyRaiseOuterException(EIdTFTPFileNotFound.Create(E.Message));
    end;
  end;
  {$ENDIF}
end;

procedure TIdTrivialFTPServer.DoTransferComplete(const Success: Boolean;
  const PeerInfo: TPeerInfo; var SourceStream: TStream; const WriteOperation: Boolean);
begin
  if Assigned(FOnTransferComplete) then begin
    FOnTransferComplete(Self, Success, PeerInfo, SourceStream, WriteOperation)
  end else begin
    FreeAndNil(SourceStream); // free the stream regardless, unless the component user steps up to the plate
  end;
end;

procedure TIdTrivialFTPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  wOp: UInt16;
  FileName, LOptName, LOptValue: String;
  Idx, LOffset, RequestedBlkSize: Integer;
  RequestedTxSize: Int64;
  Mode: TIdTFTPMode;
  PeerInfo: TPeerInfo;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  try
    if Length(AData) > 1 then begin
      wOp := GStack.NetworkToHost(BytesToUInt16(AData));
    end else begin
      wOp := 0;
    end;

    if not (wOp in [TFTP_RRQ, TFTP_WRQ]) then begin
      raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
    end;

    LOffset := 2;

    Idx := ByteIndex(0, AData, LOffset);
    if Idx = -1 then begin
      raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
    end;

    FileName := BytesToString(AData, LOffset, Idx-LOffset, IndyTextEncoding_ASCII);
    LOffset := Idx+1;

    Idx := ByteIndex(0, AData, LOffset);
    if Idx = -1 then begin
      raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
    end;

    Mode := StrToMode(BytesToString(AData, LOffset, Idx-LOffset, IndyTextEncoding_ASCII));
    LOffset := Idx+1;

    RequestedBlkSize := 512;
    RequestedTxSize := -1;

    while LOffset < Length(AData) do
    begin
      Idx := ByteIndex(0, AData, LOffset);
      if Idx = -1 then begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
      end;

      LOptName := BytesToString(AData, LOffset, Idx-LOffset, IndyTextEncoding_ASCII);
      LOffset := Idx+1;
      
      Idx := ByteIndex(0, AData, LOffset);
      if Idx = -1 then begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
      end;

      LOptValue := BytesToString(AData, LOffset, Idx-LOffset, IndyTextEncoding_ASCII);
      LOffset := Idx+1;

      if TextStartsWith(LOptName, sBlockSize) then
      begin
        RequestedBlkSize := IndyStrToInt(LOptValue);
        if (RequestedBlkSize < 8) or (RequestedBlkSize > 65464) then begin
          raise EIdTFTPOptionNegotiationFailed.CreateFmt(RSTFTPUnsupportedOptionValue, [LOptValue, LOptName]);
        end;
      end
      else if TextStartsWith(LOptName, sTransferSize) then
      begin
        RequestedTxSize := IndyStrToInt64(LOptValue);
        if wOp = TFTP_RRQ then begin
          if RequestedTxSize <> 0 then begin
            raise EIdTFTPOptionNegotiationFailed.CreateFmt(RSTFTPUnsupportedOptionValue, [LOptValue, LOptName]);
          end;
        end
        else if RequestedTxSize > High(TIdStreamSize) then begin
          raise EIdTFTPOptionNegotiationFailed.CreateFmt(RSTFTPUnsupportedOptionValue, [LOptValue, LOptName]);
        end;
      end;
    end;

    PeerInfo.PeerIP := ABinding.PeerIP;
    PeerInfo.PeerPort := ABinding.PeerPort;

    if wOp = TFTP_RRQ then begin
      DoReadFile(FileName, Mode, PeerInfo, RequestedBlkSize, RequestedTxSize = 0);
    end else begin
      DoWriteFile(FileName, Mode, PeerInfo, RequestedBlkSize, TIdStreamSize(RequestedTxSize));
    end;
  except
    on E: EIdTFTPException do begin
      SendError(Self, ABinding.PeerIP, ABinding.PeerPort, E);
    end;
    on E: Exception do begin
      SendError(Self, ABinding.PeerIP, ABinding.PeerPort, E);
      raise;
    end;
  end;  { try..except }
end;

// TODO: move this into IdGlobal.pas
procedure AdjustStreamSize(const AStream: TStream; const ASize: TIdStreamSize);
var
  LStreamPos: TIdStreamSize;
begin
  LStreamPos := AStream.Position;
  AStream.Size := ASize;
  // Must reset to original value in cases where size changes position
  if AStream.Position <> LStreamPos then begin
    AStream.Position := LStreamPos;
  end;
end;

procedure TIdTrivialFTPServer.DoWriteFile(FileName: String; const Mode: TIdTFTPMode;
  const PeerInfo: TPeerInfo; RequestedBlockSize: Integer; RequestedTransferSize: TIdStreamSize);
var
  CanWrite,
  FreeOnComplete: Boolean;
  LStream: TStream;
begin
  CanWrite := True;
  LStream := nil;
  FreeOnComplete := True;

  {$IFNDEF DOTNET}
  try
  {$ENDIF}

    if Assigned(FOnWriteFile) then begin
      FOnWriteFile(Self, FileName, PeerInfo, CanWrite, LStream, FreeOnComplete);
    end;
    if not CanWrite then begin
      raise EIdTFTPAccessViolation.CreateFmt(RSTFTPAccessDenied, [FileName]);
    end;
    if LStream = nil then begin
      LStream := TIdFileCreateStream.Create(FileName);
      FreeOnComplete := True;
    end;

    if RequestedTransferSize >= 0 then
    begin
      try
        AdjustStreamSize(LStream, RequestedTransferSize);
      except
        IndyRaiseOuterException(EIdTFTPAllocationExceeded.CreateFmt(RSTFTPDiskFull, [0]));
      end;
    end;

    TIdTFTPServerReceiveFileThread.Create(Self, Mode, PeerInfo, LStream, FreeOnComplete, RequestedBlockSize, RequestedTransferSize);

  {$IFNDEF DOTNET}
  except
    // TODO: implement this in a platform-neutral manner.  EFCreateError is VCL-specific
    on E: EFCreateError do begin
      IndyRaiseOuterException(EIdTFTPAllocationExceeded.Create(E.Message));
    end;
  end;
  {$ENDIF}
end;

function TIdTrivialFTPServer.StrToMode(mode: string): TIdTFTPMode;
begin
  case PosInStrArray(mode, ['octet', 'binary', 'netascii'], False) of    {Do not Localize}
    0, 1: Result := tfOctet;
    2: Result := tfNetAscii;
    else
      raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnsupportedTrxMode, [mode]); // unknown mode
  end;
end;

destructor TIdTrivialFTPServer.Destroy;
begin
  {
  if (not ThreadedEvent) and (ActiveThreads>0) then
    begin
    //some kind of error/warning about deadlock or possible AV due to
    //soon-to-be invalid pointer in the threads? (FOwner: TIdTrivialFTPServer;)
    //raise CantFreeYet?
    end;
  }

  //wait for threads to finish before we shutdown
  //should we set thread[i].terminated, or just wait?
  if ThreadedEvent then
  begin
    while FThreadList.Count > 0 do
    begin
      IndySleep(100);
    end;
  end;

  FreeAndNil(FThreadList);
  inherited Destroy;
end;

function TIdTrivialFTPServer.ActiveThreads: Integer;
begin
  Result := FThreadList.Count;
end;

{ TIdTFTPServerThread }

constructor TIdTFTPServerThread.Create(AOwner: TIdTrivialFTPServer;
  const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo; AStream: TStream;
  const FreeStreamOnTerminate: boolean; const RequestedBlockSize: Integer);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FStream := AStream;
  FFreeStrm := FreeStreamOnTerminate;
  FOwner := AOwner;
  FUDPClient := TIdUDPClient.Create(nil);
  FUDPClient.IPVersion := FOwner.IPVersion;
  FUDPClient.ReceiveTimeout := 1500;
  FUDPClient.Host := PeerInfo.PeerIP;
  FUDPClient.Port := PeerInfo.PeerPort;
  FUDPClient.BufferSize := RequestedBlockSize + 4;
  FOwner.FThreadList.Add(Self);
end;

destructor TIdTFTPServerThread.Destroy;
begin
  if FFreeStrm then begin
    FreeAndNil(FStream);
  end;
  FreeAndNil(FUDPClient);
  FOwner.FThreadList.Remove(Self);
  inherited Destroy;
end;

procedure TIdTFTPServerThread.AfterRun;
begin
  if FOwner.ThreadedEvent then begin
    TransferComplete;
  end else begin
    Synchronize(TransferComplete);
  end;
end;

procedure TIdTFTPServerThread.BeforeRun;
begin
  FBlkCounter := 0;
  FRetryCtr := 0;
  FEOT := False;

  if FUDPClient.BufferSize <> 516 then
  begin
    FResponse := ToBytes(GStack.HostToNetwork(UInt16(TFTP_OACK)));
    AppendString(FResponse, sBlockSize, -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
    AppendString(FResponse, IntToStr(FUDPClient.BufferSize - 4), -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
  end else begin
    SetLength(FResponse, 0);
  end;
end;

function TIdTFTPServerThread.HandleRunException(AException: Exception): Boolean;
begin
  Result := False;
  SendError(FUDPClient, AException);
end;

procedure TIdTFTPServerThread.TransferComplete;
var
  PeerInfo: TPeerInfo;
begin
  PeerInfo.PeerIP := FUDPClient.Host;
  PeerInfo.PeerPort := FUDPClient.Port;
  FOwner.DoTransferComplete(FEOT, PeerInfo, FStream, Self is TIdTFTPServerReceiveFileThread);
end;

{ TIdTFTPServerSendFileThread }

constructor TIdTFTPServerSendFileThread.Create(AOwner: TIdTrivialFTPServer;
  const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo; AStream: TStream;
  const FreeStreamOnTerminate: boolean; const RequestedBlockSize: Integer;
  SendTransferSize: Boolean);
begin
  inherited Create(AOwner, Mode, PeerInfo, AStream, FreeStreamOnTerminate, RequestedBlockSize);
  FSendTransferSize := SendTransferSize;
end;

procedure TIdTFTPServerSendFileThread.BeforeRun;
begin
  inherited BeforeRun;
  if FSendTransferSize then
  begin
    if Length(FResponse) = 0 then begin
      FResponse := ToBytes(GStack.HostToNetwork(UInt16(TFTP_OACK)));
    end;
    AppendString(FResponse, sTransferSize, -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
    AppendString(FResponse, IntToStr(FStream.Size - FStream.Position), -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
  end;
end;

procedure TIdTFTPServerSendFileThread.Run;
var
  Buffer: TIdBytes;
  LPeerIP: string;
  LPeerPort: TIdPort;
  i: Integer;
begin
  if Length(FResponse) = 0 then begin // generate a new response packet for client
    if FBlkCounter = High(UInt16) then begin
      raise EIdTFTPAllocationExceeded.Create('');
    end;
    Inc(FBlkCounter);
    SetLength(FResponse, FUDPClient.BufferSize);
    CopyTIdUInt16(GStack.HostToNetwork(UInt16(TFTP_DATA)), FResponse, 0);
    CopyTIdUInt16(GStack.HostToNetwork(FBlkCounter), FResponse, 2);
    i := ReadTIdBytesFromStream(FStream, FResponse, FUDPClient.BufferSize - 4, 4);
    SetLength(FResponse, 4 + i);
    if i < (FUDPClient.BufferSize - 4) then begin
      FEOT := True;
    end;
    FRetryCtr := 0;
  end;
  if FRetryCtr = 3 then begin
    raise EIdTFTPIllegalOperation.Create(RSTimeOut); // Timeout
  end;
  FUDPClient.SendBuffer(FResponse);
  SetLength(Buffer, FUDPClient.BufferSize);
  i := FUDPClient.ReceiveBuffer(Buffer, LPeerIP, LPeerPort);
  if i <= 0 then begin
    if FEOT then begin
      Stop;
      Exit;
    end;
    Inc(FRetryCtr);
    Exit;
  end;
  SetLength(Buffer, i);
  // TODO: validate the correct peer is sending the data...
  case GStack.NetworkToHost(BytesToUInt16(Buffer)) of
    TFTP_ACK:
      begin
        i := GStack.NetworkToHost(BytesToUInt16(Buffer, 2));
        if i = FBlkCounter then begin
          SetLength(FResponse, 0);
        end;
        if FEOT then begin
          Stop;
          Exit;
        end;
      end;
    TFTP_DATA:
      begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
      end;
    TFTP_ERROR:
      begin
        Abort;
      end;
    else
      begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
      end;
  end;
end;

{ TIdTFTPServerReceiveFileThread }

constructor TIdTFTPServerReceiveFileThread.Create(AOwner: TIdTrivialFTPServer;
  const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo; AStream: TStream;
  const FreeStreamOnTerminate: Boolean; const RequestedBlockSize: Integer;
  const RequestedTransferSize: TIdStreamSize);
begin
  inherited Create(AOwner, Mode, PeerInfo, AStream, FreeStreamOnTerminate, RequestedBlockSize);
  FTransferSize := RequestedTransferSize;
end;

procedure TIdTFTPServerReceiveFileThread.BeforeRun;
begin
  inherited BeforeRun;
  FReceivedSize := 0;
  if FTransferSize <> -1 then
  begin
    if Length(FResponse) = 0 then begin
      FResponse := ToBytes(GStack.HostToNetwork(UInt16(TFTP_OACK)));
    end;
    AppendString(FResponse, sTransferSize, -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
    AppendString(FResponse, IntToStr(FTransferSize), -1, IndyTextEncoding_ASCII);
    AppendByte(FResponse, 0);
  end;
  if Length(FResponse) > 0 then begin
    // RLebeau:  sending an OACK instead of an ACK, so expect
    // the next packet received to be a DATA packet...
    FBlkCounter := 1;
  end;
end;

{$IFNDEF DOTNET}
function TIdTFTPServerReceiveFileThread.HandleRunException(AException: Exception): Boolean;
begin
  // TODO: implement this in a platform-neutral manner.  EWriteError is VCL-specific
  if AException is EWriteError then
  begin
    Result := False;
    SendError(FUDPClient, ErrAllocationExceeded, IndyFormat(RSTFTPDiskFull, [FStream.Position]));
    Exit;
  end;
  Result := inherited HandleRunException(AException);
end;
{$ENDIF}

procedure TIdTFTPServerReceiveFileThread.Run;
var
  Buffer: TIdBytes;
  LPeerIP: string;
  LPeerPort: TIdPort;
  i: TIdStreamSize;
begin
  if Length(FResponse) = 0 then begin
    FResponse := MakeActPkt(FBlkCounter);
    if FBlkCounter = High(UInt16) then begin
      FEOT := True;
    end else begin
      Inc(FBlkCounter);
    end;
    FRetryCtr := 0;
  end;
  if FRetryCtr = 3 then begin
    raise EIdTFTPIllegalOperation.Create(RSTimeOut); // Timeout
  end;
  FUDPClient.SendBuffer(FResponse);
  SetLength(Buffer, FUDPClient.BufferSize);
  i := FUDPClient.ReceiveBuffer(Buffer, LPeerIP, LPeerPort);
  if i <= 0 then begin
    if FEOT then begin
      Stop;
      Exit;
    end;
    Inc(FRetryCtr);
    Exit;
  end;
  SetLength(Buffer, i);
  // TODO: validate the correct peer is sending the data...
  case GStack.NetworkToHost(BytesToUInt16(Buffer)) of
    TFTP_ACK:
      begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
      end;
    TFTP_DATA:
      begin
        i := GStack.NetworkToHost(BytesToUInt16(Buffer, 2));
        if i = FBlkCounter then
        begin
          if FEOT then begin
            raise EIdTFTPAllocationExceeded.CreateFmt(RSTFTPDiskFull, [FStream.Position]);
          end;
          if (FTransferSize >= 0) and ((FTransferSize - FReceivedSize) < (Length(Buffer) - 4)) then
          begin
            WriteTIdBytesToStream(FStream, Buffer, FTransferSize - FReceivedSize, 4);
            FReceivedSize := FTransferSize;
            FEOT := True;
            raise EIdTFTPAllocationExceeded.CreateFmt(RSTFTPDiskFull, [FStream.Position]);
          end;
          WriteTIdBytesToStream(FStream, Buffer, Length(Buffer) - 4, 4);
          Inc(FReceivedSize, Length(Buffer) - 4);
          SetLength(FResponse, 0);
          FEOT := (Length(Buffer) - 4) < (FUDPClient.BufferSize - 4);
        end;
      end;
    TFTP_ERROR:
      begin
        Abort;
      end;
    else
      begin
        raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
      end;
  end;
end;

end.
