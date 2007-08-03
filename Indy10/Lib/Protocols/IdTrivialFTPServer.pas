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
  IdAssignedNumbers,
  IdGlobal,
  IdThreadSafe,
  IdTrivialFTPBase,
  IdSocketHandle,
  IdUDPServer;

type
  TPeerInfo = record
    PeerIP: string;
    PeerPort: Integer;
  end;

  TAccessFileEvent = procedure (Sender: TObject; var FileName: String; const PeerInfo: TPeerInfo;
    var GrantAccess: Boolean; var AStream: TStream; var FreeStreamOnComplete: Boolean) of object;
  TTransferCompleteEvent = procedure (Sender: TObject; const Success: Boolean;
    const PeerInfo: TPeerInfo; var AStream: TStream; const WriteOperation: Boolean) of object;

  TIdTrivialFTPServer = class(TIdUDPServer)
  protected
    FThreadList:TIdThreadSafeList;
    FOnTransferComplete: TTransferCompleteEvent;
    FOnReadFile,
    FOnWriteFile: TAccessFileEvent;
    function StrToMode(mode: string): TIdTFTPMode;
  protected
    procedure DoReadFile(FileName: String; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; RequestedBlockSize: Integer = 0); virtual;
    procedure DoWriteFile(FileName: String; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; RequestedBlockSize: Integer = 0); virtual;
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
  end;

implementation

uses
  IdExceptionCore,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdStack,
  IdThread,
  IdUDPClient,
  SysUtils;

type
  TIdTFTPServerThread = class(TIdThread)
  private
    FStream: TStream;
    FBlkCounter: Integer;
    FResponse: String;
    FRetryCtr: Integer;
    FUDPClient: TIdUDPClient;
    FRequestedBlkSize: Integer;
    FEOT, FFreeStrm: Boolean;
    FOwner: TIdTrivialFTPServer;
    procedure TransferComplete;
  protected
    procedure AfterRun; override;
    procedure BeforeRun; override;
    function HandleRunException(AException: Exception): Boolean; override;
    procedure Run; override;
  public
    constructor Create(AOwner: TIdTrivialFTPServer; const Mode: TIdTFTPMode;
      const PeerInfo: TPeerInfo; AStream: TStream; const FreeStreamOnTerminate: Boolean;
      const RequestedBlockSize: Integer = 0); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TIdTFTPServerSendFileThread = class(TIdTFTPServerThread);
  TIdTFTPServerReceiveFileThread = class(TIdTFTPServerThread);

{ TIdTrivialFTPServer }

procedure TIdTrivialFTPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_TFTP;
  FThreadList := TIdThreadSafeList.Create;
end;

procedure TIdTrivialFTPServer.DoReadFile(FileName: String; const Mode: TIdTFTPMode;
  const PeerInfo: TPeerInfo; RequestedBlockSize: Integer = 0);
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
    TIdTFTPServerSendFileThread.Create(Self, Mode, PeerInfo, LStream, FreeOnComplete, RequestedBlockSize);

  {$IFNDEF DOTNET}
  except
    // TODO: implement this in a platform-neutral manner.  EFOpenError is VCL-specific
    on E: EFOpenError do begin
      raise EIdTFTPFileNotFound.Create(E.Message);
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
  wOp: Word;
  s, FileName: String;
  RequestedBlkSize: integer;
  Mode: TIdTFTPMode;
  PeerInfo: TPeerInfo;
begin
  inherited DoUDPRead(AThread, AData, ABinding);
  try
    if Length(AData) > 1 then begin
      wOp := BytesToWord(AData);
      wOp := GStack.NetworkToHost(wOp);
    end else begin
      wOp := 0;
    end;

    if not (wOp in [TFTP_RRQ, TFTP_WRQ]) then begin
      raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
    end;

    //omit wOp from the request.
    s := BytesToString(AData, 2);

    FileName := Fetch(s, #0);
    Mode := StrToMode(Fetch(s, #0));
    RequestedBlkSize := 0;
    if TextStartsWith(s, sBlockSize) then begin
      Fetch(s, #0);
      RequestedBlkSize := IndyStrToInt(Fetch(s, #0));
    end;
    PeerInfo.PeerIP := ABinding.PeerIP;
    PeerInfo.PeerPort := ABinding.PeerPort;
    if wOp = TFTP_RRQ then begin
      DoReadFile(FileName, Mode, PeerInfo, RequestedBlkSize);
    end else begin
      DoWriteFile(FileName, Mode, PeerInfo, RequestedBlkSize);
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

procedure TIdTrivialFTPServer.DoWriteFile(FileName: String; const Mode: TIdTFTPMode;
  const PeerInfo: TPeerInfo; RequestedBlockSize: Integer);
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
    TIdTFTPServerReceiveFileThread.Create(Self, Mode, PeerInfo, LStream, FreeOnComplete, RequestedBlockSize);

  {$IFNDEF DOTNET}
  except
    // TODO: implement this in a platform-neutral manner.  EFCreateError is VCL-specific
    on E: EFCreateError do begin
      raise EIdTFTPAllocationExceeded.Create(E.Message);
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
      Sleep(100);
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
  FUDPClient := TIdUDPClient.Create(nil);
  FOwner := AOwner;
  with FUDPClient do
  begin
    ReceiveTimeout := 1500;
    Host := PeerInfo.PeerIP;
    Port := PeerInfo.PeerPort;
    BufferSize := 516;
    FRequestedBlkSize := RequestedBlockSize;
  end;
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
  if FRequestedBlkSize > 0 then begin
    FUDPClient.BufferSize := Max(FRequestedBlkSize + hdrsize, FUDPClient.BufferSize);
    FResponse := WordToStr(GStack.NetworkToHost(Word(TFTP_OACK))) + 'blksize'#0    {Do not Localize}
     + IntToStr(FUDPClient.BufferSize - hdrsize) + #0#0;
  end else begin
    FResponse := '';    {Do not Localize}
  end;
end;

function TIdTFTPServerThread.HandleRunException(AException: Exception): Boolean;
begin
  Result := False;
  {$IFNDEF DOTNET}
  // TODO: implement this in a platform-neutral manner.  EWriteError is VCL-specific
  if AException is EWriteError then begin
    SendError(FUDPClient, ErrAllocationExceeded, IndyFormat(RSTFTPDiskFull, [FStream.Position]));
    Exit;
  end;
  {$ENDIF}
  SendError(FUDPClient, AException);
end;

procedure TIdTFTPServerThread.Run;
var
  Buffer, LBuf : string;
  i: Integer;
begin
  SetLength(Buffer, FUDPClient.BufferSize);
  if FResponse = '' then begin // generate a new response packet for client    {Do not Localize}
    if Self is TIdTFTPServerReceiveFileThread then begin
      FResponse := MakeAckPkt(FBlkCounter);
    end else begin
      FBlkCounter := Word(succ(FBlkCounter));
      FResponse := WordToStr(GStack.NetworkToHost(Word(TFTP_DATA))) +
                   WordToStr(GStack.NetworkToHost(Word(FBlkCounter)));
      LBuf := ReadStringFromStream(FStream, Length(FResponse) - hdrsize);
      i := Length(LBuf);
      FResponse := FResponse + LBuf;
      FEOT := i < (FUDPClient.BufferSize - hdrsize);
    end;
    FRetryCtr := 0;
  end;
  if FRetryCtr = 3 then begin
    raise EIdTFTPIllegalOperation.Create(RSTimeOut); // Timeout
  end;
  FUDPClient.Send(FResponse);
  Buffer := FUDPClient.ReceiveString;
  if Buffer = '' then begin   {Do not Localize}
    if FEOT then begin
      Stop;
      Exit;
    end;
    Inc(FRetryCtr);
    Exit;
  end;
  case GStack.NetworkToHost(StrToWord(Buffer)) of
    TFTP_ACK:
      begin
        if not (Self is TIdTFTPServerSendFileThread) then begin
          raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
        end;
        i := GStack.NetworkToHost(StrToWord(Copy(Buffer, 3, 2)));
        if i = FBlkCounter then begin
          FResponse := '';    {Do not Localize}
        end;
        if FEOT then begin
          Stop;
          Exit;
        end;
      end;
    TFTP_DATA:
      begin
        if not (Self is TIdTFTPServerReceiveFileThread) then begin
          raise EIdTFTPIllegalOperation.CreateFmt(RSTFTPUnexpectedOp, [FUDPClient.Host, FUDPClient.Port]);
        end;
        i := GStack.NetworkToHost(StrToWord(Copy(Buffer, 3, 2)));
        if i = Word(FBlkCounter + 1) then begin
          WriteStringToStream(FStream, Copy(Buffer, hdrsize+1, Length(Buffer)-hdrsize));
          FResponse := '';    {Do not Localize}
          FBlkCounter := Word(succ(FBlkCounter));
        end;
        FEOT := Length(Buffer) < FUDPClient.BufferSize;
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

procedure TIdTFTPServerThread.TransferComplete;
var
  PeerInfo: TPeerInfo;
begin
  PeerInfo.PeerIP := FUDPClient.Host;
  PeerInfo.PeerPort := FUDPClient.Port;
  FOwner.DoTransferComplete(FEOT, PeerInfo, FStream, Self is TIdTFTPServerReceiveFileThread);
end;

end.
