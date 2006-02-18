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

uses
  IdAssignedNumbers,
  IdGlobal,
  IdThreadSafe,
  IdTrivialFTPBase,
  IdSocketHandle,
  IdObjs,
  IdUDPServer;

type
  TPeerInfo = record
    PeerIP: string;
    PeerPort: Integer;
  end;

  TAccessFileEvent = procedure (Sender: TObject; var FileName: String; const PeerInfo: TPeerInfo;
    var GrantAccess: Boolean; var AStream: TIdStream; var FreeStreamOnComplete: Boolean) of object;
  TTransferCompleteEvent = procedure (Sender: TObject; const Success: Boolean;
    const PeerInfo: TPeerInfo; var AStream: TIdStream; const WriteOperation: Boolean) of object;

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
    procedure DoTransferComplete(const Success: Boolean; const PeerInfo: TPeerInfo; var SourceStream: TIdStream; const WriteOperation: Boolean); virtual;
    procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
    //    procedure DoUDPRead(AData: TStream; ABinding: TIdSocketHandle); override;
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
  IdSys,
  IdUDPClient;

type
  TIdTFTPServerThread = class(TIdNativeThread)
  private
    FStream: TIdStream;
    FUDPClient: TIdUDPClient;
    FRequestedBlkSize: Integer;
    EOT,
    FFreeStrm: Boolean;
    FOwner: TIdTrivialFTPServer;
    procedure TransferComplete;
  protected
    procedure Execute; override;
  public
    constructor Create(AnOwner: TIdTrivialFTPServer; const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo;
      AStream: TIdStream; const FreeStreamOnTerminate: boolean; const RequestedBlockSize: Integer = 0); virtual;
    destructor Destroy; override;
  end;

  TIdTFTPServerSendFileThread = class(TIdTFTPServerThread);
  TIdTFTPServerReceiveFileThread = class(TIdTFTPServerThread);

{ TIdTrivialFTPServer }

procedure TIdTrivialFTPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_TFTP;
  FThreadList := TIdThreadSafeList.Create;
end;

procedure TIdTrivialFTPServer.DoReadFile(FileName: String; const Mode: TIdTFTPMode;
  const PeerInfo: TPeerInfo; RequestedBlockSize: Integer = 0);
var
  CanRead,
  FreeOnComplete: Boolean;
  SourceStream: TIdStream;
begin
  CanRead := True;
  SourceStream := nil;
  FreeOnComplete := True;
  try
    if Assigned(FOnReadFile) then
    begin
      FOnReadFile(Self, FileName, PeerInfo, CanRead, SourceStream, FreeOnComplete);
    end;
    if CanRead then
    begin
      if SourceStream = nil then
      begin
        SourceStream :=  TReadFileExclusiveStream.Create(FileName);
        FreeOnComplete := True;
      end;
      TIdTFTPServerSendFileThread.Create(self, Mode, PeerInfo, SourceStream,
        FreeOnComplete, RequestedBlockSize);
    end
    else
      raise EIdTFTPAccessViolation.Create(Sys.Format(RSTFTPAccessDenied, [FileName]));
  except
    on E: Exception do
      raise EIdTFTPFileNotFound.Create(E.Message);
  end;
end;

procedure TIdTrivialFTPServer.DoTransferComplete(const Success: Boolean;
  const PeerInfo: TPeerInfo;var SourceStream: TIdStream; const WriteOperation: Boolean);
begin
  if Assigned(FOnTransferComplete) then
  begin
    FOnTransferComplete(Self, Success, PeerInfo, SourceStream, WriteOperation)
  end
  else
  begin
    Sys.FreeAndNil(SourceStream); // free the stream regardless, unless the component user steps up to the plate
  end;
end;

procedure TIdTrivialFTPServer.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
var
  wOp: Word;
  LBuf,
  FileName: String;
  RequestedBlkSize: integer;
  Mode: TIdTFTPMode;
  PeerInfo: TPeerInfo;
begin
  inherited DoUDPRead(AData, ABinding);
  try
    LBuf := BytesToString(AData);
    wOp := StrToWord(Copy(LBuf,1,2));
    wOp := GStack.NetworkToHost(wOp);
    //delete wOp from the request.
    IdDelete(LBuf,1,2);
    if wOp IN [TFTP_RRQ, TFTP_WRQ] then
    begin
      FileName := Fetch(LBuf, #0);
      Mode := StrToMode(Fetch(LBuf, #0));
      RequestedBlkSize := 0;
      if (Copy(LBuf,1,Length(sBlockSize))=sBlockSize) then
      begin
        Fetch(LBuf, #0);
        RequestedBlkSize := Sys.StrToInt(Fetch(LBuf, #0));
      end;
      PeerInfo.PeerIP := ABinding.PeerIP;
      PeerInfo.PeerPort := ABinding.PeerPort;
      if wOp = TFTP_RRQ then
      begin
        DoReadFile(FileName, Mode, PeerInfo, RequestedBlkSize);
      end
      else
      begin
        DoWriteFile(FileName, Mode, PeerInfo, RequestedBlkSize);
      end;
    end
    else
    begin
      raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]));
    end;
  except
    on E: EIdTFTPException do
      SendError(self, ABinding.PeerIP, ABinding.PeerPort, E);
    on E: Exception do
    begin
      SendError(self, ABinding.PeerIP, ABinding.PeerPort, E);
      raise;
    end;
  end;  { try..except }
end;

(*procedure TIdTrivialFTPServer.DoUDPRead(AData: TStream; ABinding: TIdSocketHandle);
var
  wOp: Word;
  s,
  FileName: String;
  RequestedBlkSize: integer;
  Mode: TIdTFTPMode;
  PeerInfo: TPeerInfo;
begin
  inherited;
  try
    AData.ReadBuffer(wOp, SizeOf(wOp));
    wOp := GStack.NetworkToHost(wOp);
    if wOp IN [TFTP_RRQ, TFTP_WRQ] then
    begin
      SetLength(s, AData.Size - AData.Position);
      AData.ReadBuffer(s[1], Length(s));
      FileName := Fetch(s, #0);
      Mode := StrToMode(Fetch(s, #0));
      RequestedBlkSize := 0;
      if StrLComp(pchar(s), sBlockSize, Length(sBlockSize)) = 0 then
      begin
        Fetch(s, #0);
        RequestedBlkSize := Sys.StrToInt(Fetch(s, #0));
      end;
      PeerInfo.PeerIP := ABinding.PeerIP;
      PeerInfo.PeerPort := ABinding.PeerPort;
      if wOp = TFTP_RRQ then
        DoReadFile(FileName, Mode, PeerInfo, RequestedBlkSize)
      else
        DoWriteFile(FileName, Mode, PeerInfo, RequestedBlkSize);
    end
    else
      raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnexpectedOp, [ABinding.PeerIP, ABinding.PeerPort]);
  except
    on E: EIdTFTPException do
      SendError(self, ABinding.PeerIP, ABinding.PeerPort, E);
    on E: Exception do
    begin
      SendError(self, ABinding.PeerIP, ABinding.PeerPort, E);
      raise;
    end;
  end;  { try..except }
end;*)

procedure TIdTrivialFTPServer.DoWriteFile(FileName: String;
  const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo;
  RequestedBlockSize: Integer);
var
  CanWrite,
  FreeOnComplete: Boolean;
  DestinationStream: TIdStream;
begin
  CanWrite := True;
  DestinationStream := nil;
  FreeOnComplete := True;
  try
    if Assigned(FOnWriteFile) then
    begin
      FOnWriteFile(Self, FileName, PeerInfo, CanWrite, DestinationStream, FreeOnComplete);
    end;
    if CanWrite then
    begin
      if DestinationStream = nil then
      begin
        DestinationStream := TFileCreateStream.Create(FileName);
        FreeOnComplete := True;
      end;
      TIdTFTPServerReceiveFileThread.Create(self, Mode, PeerInfo,
        DestinationStream, FreeOnComplete, RequestedBlockSize);
    end
    else
      raise EIdTFTPAccessViolation.Create(Sys.Format(RSTFTPAccessDenied, [FileName]));
  except
    on E: Exception do
      raise EIdTFTPAllocationExceeded.Create(E.Message);
  end;
end;

function TIdTrivialFTPServer.StrToMode(mode: string): TIdTFTPMode;
begin
  case PosInStrArray(mode, ['octet', 'binary', 'netascii'], False) of    {Do not Localize}
    0, 1: Result := tfOctet;
    2: Result := tfNetAscii;
    else
      raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnsupportedTrxMode, [mode])); // unknown mode
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
    while FThreadList.Count>0 do
      begin
      Sleep(100);
      end;
    end;

  Sys.FreeAndNil(FThreadList);
  inherited;
end;

function TIdTrivialFTPServer.ActiveThreads: Integer;
begin
  Result:=FThreadList.Count;
end;

{ TIdTFTPServerThread }

constructor TIdTFTPServerThread.Create(AnOwner: TIdTrivialFTPServer;
  const Mode: TIdTFTPMode; const PeerInfo: TPeerInfo;
  AStream: TIdStream; const FreeStreamOnTerminate: boolean; const RequestedBlockSize: Integer);
begin
  inherited Create(True);
  FStream := AStream;
  FUDPClient := TIdUDPClient.Create(nil);
  with FUDPClient do
  begin
    ReceiveTimeout := 1500;
    Host := PeerInfo.PeerIP;
    Port := PeerInfo.PeerPort;
    BufferSize := 516;
    FRequestedBlkSize := RequestedBlockSize;
  end;
  FFreeStrm := FreeStreamOnTerminate;
  FOwner := AnOwner;
  FreeOnTerminate := True;
  FOwner.FThreadList.Add(Self);
  Resume;
end;

destructor TIdTFTPServerThread.Destroy;
begin
  if FFreeStrm then
  begin
    Sys.FreeAndNil(FStream);
  end;

  if FOwner.ThreadedEvent then
    begin
    TransferComplete
    end
  else
    begin
    Synchronize(TransferComplete);
    end;

  Sys.FreeAndNil(FUDPClient);
  FOwner.FThreadList.Remove(Self);
  inherited;
end;

procedure TIdTFTPServerThread.Execute;
var
  Response,
  Buffer, LBuf : string;
  BlkCounter: integer;
  i,
  RetryCtr: integer;
begin
  Response := '';    {Do not Localize}
  BlkCounter := 0;
  RetryCtr := 0;
  EOT := False;
  SetLength(Response, Max(FRequestedBlkSize + hdrsize, FUDPClient.BufferSize));
  if FRequestedBlkSize > 0 then
  begin
    FUDPClient.BufferSize := Max(FRequestedBlkSize + hdrsize, FUDPClient.BufferSize);
    Response := WordToStr(GStack.NetworkToHost(Word(TFTP_OACK))) + 'blksize'#0    {Do not Localize}
     + Sys.IntToStr(FUDPClient.BufferSize - hdrsize) + #0#0;
  end
  else
  begin
    Response := '';    {Do not Localize}
  end;
  SetLength(Buffer, FUDPClient.BufferSize);
  try
    while true do
    begin
      if Response = '' then  // generate a new response packet for client    {Do not Localize}
      begin
        if (self is TIdTFTPServerReceiveFileThread) then
        begin
          Response := MakeAckPkt(BlkCounter);
        end
        else
        begin
          BlkCounter := Word(succ(BlkCounter));
          Response := WordToStr(GStack.NetworkToHost(Word(TFTP_DATA))) +
                      WordToStr(GStack.NetworkToHost(Word(BlkCounter)));
          LBuf := ReadStringFromStream( FStream,FUDPClient.BufferSize - hdrsize);
          i := Length(LBuf);
          Response := Response + LBuf;
          EOT := i < FUDPClient.BufferSize - hdrsize;
        end;
        RetryCtr := 0;
      end;
      if RetryCtr = 3 then
      begin
        raise EIdTFTPIllegalOperation.Create(RSTimeOut); // Timeout
      end;
      FUDPClient.Send(Response);
      Buffer := FUDPClient.ReceiveString;
      if Buffer = '' then    {Do not Localize}
      begin
        if EOT then
        begin
          break;
        end;
        inc(RetryCtr);
        Continue;
      end;
      case GStack.NetworkToHost(StrToWord(Buffer)) of
        TFTP_ACK:
        begin
          if not (self is TIdTFTPServerSendFileThread) then
          begin
            raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnexpectedOp,
              [FUDPClient.Host, FUDPClient.Port]));
          end;
          i := GStack.NetworkToHost(StrToWord(Copy(Buffer, 3, 2)));
          if i = BlkCounter then
          begin
            Response := '';    {Do not Localize}
          end;
          if EOT then
          begin
            break;
          end;
        end;
        TFTP_DATA:
        begin
          if not (self is TIdTFTPServerReceiveFileThread) then
          begin
            raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnexpectedOp,
              [FUDPClient.Host, FUDPClient.Port]));
          end;
          i := GStack.NetworkToHost(StrToWord(Copy(Buffer, 3, 2)));
          if i = Word(BlkCounter + 1) then
          begin
            WriteStringToStream(FStream, Copy(Buffer,hdrsize+1, Length(Buffer)-hdrsize));
            Response := '';    {Do not Localize}
            BlkCounter := Word(succ(BlkCounter));
          end;
          EOT := Length(Buffer) < FUDPClient.BufferSize;
        end;
        TFTP_ERROR: Sys.Abort;
        else
          raise EIdTFTPIllegalOperation.Create(Sys.Format(RSTFTPUnexpectedOp,
              [FUDPClient.Host, FUDPClient.Port]));
      end;  { case }
    end;
  except
    on E: EIdTFTPException do
      SendError(FUDPClient, E);
//    on E: EWriteError do
//      SendError(FUDPClient, ErrAllocationExceeded, Sys.Format(RSTFTPDiskFull, [FStream.Position]));
    on E: Exception do
      SendError(FUDPClient, E);
  end;
end;

procedure TIdTFTPServerThread.TransferComplete;
var
  PeerInfo: TPeerInfo;
begin
  PeerInfo.PeerIP := FUDPClient.Host;
  PeerInfo.PeerPort := FUDPClient.Port;
  FOwner.DoTransferComplete(EOT, PeerInfo, FStream, self is TIdTFTPServerReceiveFileThread);
end;

end.
