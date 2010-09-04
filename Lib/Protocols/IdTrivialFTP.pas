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
  Rev 1.7    2/8/05 6:08:04 PM  RLebeau
  Changed CheckOptionAck() to use TextIsSame() instead of SameText()

  Rev 1.6    7/23/04 6:41:50 PM  RLebeau
  TFileStream access right tweak for Put()

  Rev 1.5    2/7/2004 7:25:58 PM  JPMugaas
  Deleted error msg code in error packet.  OOPS!!!

  Rev 1.4    2/7/2004 7:20:16 PM  JPMugaas
  DotNET to go!! and YES - I want fries with that :-).

  Rev 1.3    2004.02.03 5:44:38 PM  czhower
  Name changes

  Rev 1.2    1/21/2004 4:21:04 PM  JPMugaas
  InitComponent

  Rev 1.1    2003.10.12 6:36:46 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:03:32 AM  JPMugaas
}

unit IdTrivialFTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers,
  IdGlobal,
  IdTrivialFTPBase,
  IdUDPClient;

const
  GTransferMode = tfOctet;
  GFRequestedBlockSize = 1500;
  GReceiveTimeout = 4000;

type
  TIdTrivialFTP = class(TIdUDPClient)
  protected
    FMode: TIdTFTPMode;
    FRequestedBlockSize: Integer;
    FPeerPort: TIdPort;
    FPeerIP: String;
    function ModeToStr: string;
    procedure CheckOptionAck(const OptionPacket: TIdBytes; Reading: Boolean);
  protected
    procedure SendAck(const BlockNumber: Word);
    procedure RaiseError(const ErrorPacket: TIdBytes);
    procedure InitComponent; override;
  public
    procedure Get(const ServerFile: String; DestinationStream: TStream); overload;
    procedure Get(const ServerFile, LocalFile: String); overload;
    procedure Put(SourceStream: TStream; const ServerFile: String); overload;
    procedure Put(const LocalFile, ServerFile: String); overload;
  published
    property TransferMode: TIdTFTPMode read FMode write FMode Default GTransferMode;
    property RequestedBlockSize: Integer read FRequestedBlockSize write FRequestedBlockSize default 1500;
    property OnWork;
    property OnWorkBegin;
    property OnWorkEnd;
  end;

implementation

uses
  {$IFDEF DOTNET}
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdComponent,
  IdExceptionCore,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdStack,
  SysUtils;

procedure TIdTrivialFTP.CheckOptionAck(const OptionPacket: TIdBytes; Reading: Boolean);
var
  LOptName, LOptValue: String;
  LOffset, Idx, OptionIdx: Integer;
begin
  LOffset := 2; // skip packet opcode

  try
    while LOffset < Length(OptionPacket) do
    begin
      Idx := ByteIndex(0, OptionPacket, LOffset);
      if Idx = -1 then begin
        raise EIdTFTPOptionNegotiationFailed.Create('');
      end;

      LOptName := BytesToString(OptionPacket, LOffset, Idx-LOffset, TIdTextEncoding.ASCII);
      LOffset := Idx+1;

      OptionIdx := PosInStrArray(LOptName, [sBlockSize, sTransferSize], False);
      if OptionIdx = -1 then begin
        raise EIdTFTPOptionNegotiationFailed.CreateFmt(RSTFTPUnsupportedOption, [LOptName]);
      end;

      Idx := ByteIndex(0, OptionPacket, LOffset);
      if Idx = -1 then begin
        raise EIdTFTPOptionNegotiationFailed.Create('');
      end;

      LOptValue := BytesToString(OptionPacket, LOffset, Idx-LOffset, TIdTextEncoding.ASCII);
      LOffset := Idx+1;

      case OptionIdx of
        0:
          begin
            BufferSize := IndyStrToInt(LOptValue) + 4;
            if (BufferSize < 8) or (BufferSize > 65464) then begin
              raise EIdTFTPOptionNegotiationFailed.CreateFmt(RSTFTPUnsupportedOptionValue, [LOptValue, LOptName]);
            end;
          end;
        1:
          begin
            if Reading then
            begin
              // TODO
              {
              if (IndyStrToInt(LOptValue) is not available) then begin
                raise raise EIdTFTPAllocationExceeded.Create('');
              end;
              }
            end;
          end;
      end;
    end;
  except
    on E: Exception do begin
      SendError(Self, FPeerIP, FPeerPort, E);
      raise;
    end;
  end;

  SendAck(0);
end;

procedure TIdTrivialFTP.InitComponent;
begin
  inherited;
  TransferMode := GTransferMode;
  Port := IdPORT_TFTP;
  FRequestedBlockSize := GFRequestedBlockSize;
  ReceiveTimeout := GReceiveTimeout;
end;

procedure TIdTrivialFTP.Get(const ServerFile: String; DestinationStream: TStream);
var
  Buffer, LServerFile, LMode, LBlockSize, LBlockOctets, LTransferSize, LTransferOctets: TIdBytes;
  DataLen, LOffset: Integer;
  ExpectedBlockCtr, BlockCtr: Word;
  TerminateTransfer: Boolean;
begin
  try
    BufferSize := 516;   // BufferSize as specified by RFC 1350

    LServerFile := ToBytes(ServerFile);
    LMode := ToBytes(ModeToStr);
    LBlockSize := ToBytes(sBlockSize);
    LBlockOctets := ToBytes(IntToStr(FRequestedBlockSize));
    LTransferSize := ToBytes(sTransferSize);
    LTransferOctets := ToBytes(IntToStr(0));

    SetLength(Buffer, 2+Length(LServerFile)+1+Length(LMode)+1+Length(LBlockSize)+1+Length(LBlockOctets)+1+Length(LTransferSize)+1+Length(LTransferOctets)+1);
    LOffset := 0;

    CopyTIdWord(GStack.HostToNetwork(Word(TFTP_RRQ)), Buffer, LOffset);
    Inc(LOffset, 2);
    CopyTIdBytes(LServerFile, 0, Buffer, LOffset, Length(LServerFile));
    Inc(LOffset, Length(LServerFile));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LMode, 0, Buffer, LOffset, Length(LMode));
    Inc(LOffset, Length(LMode));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LBlockSize, 0, Buffer, LOffset, Length(LBlockSize));
    Inc(LOffset, Length(LBlockSize));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LBlockOctets, 0, Buffer, LOffset, Length(LBlockOctets));
    Inc(LOffset, Length(LBlockOctets));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LTransferSize, 0, Buffer, LOffset, Length(LTransferSize));
    Inc(LOffset, Length(LTransferSize));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LTransferOctets, 0, Buffer, LOffset, Length(LTransferOctets));
    Inc(LOffset, Length(LTransferOctets));
    Buffer[LOffset] := 0;

    SendBuffer(Buffer);

    ExpectedBlockCtr := 1;
    TerminateTransfer := False;

    BeginWork(wmRead);
    try
      repeat
        SetLength(Buffer, BufferSize);
        DataLen := ReceiveBuffer(Buffer, FPeerIP, FPeerPort, ReceiveTimeout);
        if DataLen <= 0 then begin
          if TerminateTransfer then begin
            Break;
          end;
          // TODO: re-transmit the last sent packet again instead of erroring...
          raise EIdTFTPException.Create(RSTimeOut);
        end;
        SetLength(Buffer, DataLen);
        // TODO: validate the correct peer is sending the data...
        case GStack.NetworkToHost(BytesToWord(Buffer)) of
          TFTP_DATA:
            begin
              if TerminateTransfer then begin
                // have already reached the max block counter allowed, can't validate any more...
                SendError(Self, FPeerIP, FPeerPort, ErrIllegalOperation, '');
                raise EIdTFTPException.CreateFmt(RSTFTPUnexpectedOp, [FPeerIP, FPeerPort]);
              end;
              BlockCtr := GStack.NetworkToHost(BytesToWord(Buffer, 2));
              if BlockCtr = ExpectedBlockCtr then
              begin
                DataLen := Length(Buffer) - 4;
                try
                  WriteTIdBytesToStream(DestinationStream, Buffer, DataLen, 4);
                  DoWork(wmRead, DataLen);
                except
                  on E: Exception do
                  begin
                    SendError(Self, FPeerIP, FPeerPort, E);
                    raise;
                  end;
                end;
                SendAck(BlockCtr);
                if BlockCtr = High(Word) then begin
                  TerminateTransfer := True; // end of transfer, a block counter cannot wrap back to 0
                end else begin
                  ExpectedBlockCtr := BlockCtr + 1;
                  TerminateTransfer := Length(Buffer) < BufferSize;
                end;
              end;
            end;
          TFTP_ERROR:
            begin
            RaiseError(Buffer);
            end;
          TFTP_OACK:
            begin
              CheckOptionAck(Buffer, True);
            end;
          else
            begin
              SendError(Self, FPeerIP, FPeerPort, ErrIllegalOperation, '');
              raise EIdTFTPException.CreateFmt(RSTFTPUnexpectedOp, [FPeerIP, FPeerPort]);
            end;
        end;
      until False;
    finally
      EndWork(wmRead);
    end;
  finally
    Binding.CloseSocket;
  end;
end;

procedure TIdTrivialFTP.Get(const ServerFile, LocalFile: String);
var
  fs: TFileStream;
begin
  fs := TIdFileCreateStream.Create(LocalFile);
  try
    Get(ServerFile, fs);
  finally
    FreeAndNil(fs);
  end;
end;

function TIdTrivialFTP.ModeToStr: string;
begin
  case TransferMode of
    tfNetAscii: Result := 'netascii'; {Do not Localize}
    tfOctet:    Result := 'octet';    {Do not Localize}
  end;
end;

procedure TIdTrivialFTP.Put(SourceStream: TStream; const ServerFile: String);
var
  Buffer, LServerFile, LMode, LBlockSize, LBlockOctets, LTransferSize, LTransferOctets: TIdBytes;
  StreamLen: TIdStreamSize;
  LOffset, DataLen: Integer;
  ExpectedBlockCtr, BlockCtr: Word;
  TerminateTransfer: Boolean;
begin
  try
    BufferSize := 516;   // BufferSize as specified by RFC 1350

    StreamLen := SourceStream.Size - SourceStream.Position;

    LServerFile := ToBytes(ServerFile);
    LMode := ToBytes(ModeToStr);
    LBlockSize := ToBytes(sBlockSize);
    LBlockOctets := ToBytes(IntToStr(FRequestedBlockSize));
    LTransferSize := ToBytes(sTransferSize);
    LTransferOctets := ToBytes(IntToStr(StreamLen));

    SetLength(Buffer, 2+Length(LServerFile)+1+Length(LMode)+1+Length(LBlockSize)+1+Length(LBlockOctets)+1+Length(LTransferSize)+1+Length(LTransferOctets)+1);
    LOffset := 0;

    CopyTIdWord(GStack.HostToNetwork(Word(TFTP_WRQ)), Buffer, LOffset);
    Inc(LOffset, 2);
    CopyTIdBytes(LServerFile, 0, Buffer, LOffset, Length(LServerFile));
    Inc(LOffset, Length(LServerFile));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LMode, 0, Buffer, LOffset, Length(LMode));
    Inc(LOffset, Length(LMode));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LBlockSize, 0, Buffer, LOffset, Length(LBlockSize));
    Inc(LOffset, Length(LBlockSize));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LBlockOctets, 0, Buffer, LOffset, Length(LBlockOctets));
    Inc(LOffset, Length(LBlockOctets));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LTransferSize, 0, Buffer, LOffset, Length(LTransferSize));
    Inc(LOffset, Length(LTransferSize));
    Buffer[LOffset] := 0;
    Inc(LOffset);
    CopyTIdBytes(LTransferOctets, 0, Buffer, LOffset, Length(LTransferOctets));
    Inc(LOffset, Length(LTransferOctets));
    Buffer[LOffset] := 0;

    SendBuffer(Buffer);

    ExpectedBlockCtr := 0;
    TerminateTransfer := False;

    BeginWork(wmWrite, StreamLen);
    try
      repeat
        SetLength(Buffer, BufferSize);
        DataLen := ReceiveBuffer(Buffer, FPeerIP, FPeerPort, IndyMax(500, ReceiveTimeout));
        if DataLen <= 0 then begin
          if TerminateTransfer then begin
            Break;
          end;
          // TODO: re-transmit the last sent packet again instead of erroring...
          raise EIdTFTPException.Create(RSTimeOut);
        end;
        SetLength(Buffer, DataLen);
        // TODO: validate the correct peer is sending the data...
        case GStack.NetworkToHost(BytesToWord(Buffer)) of
          TFTP_ACK:
            begin
              BlockCtr := GStack.NetworkToHost(BytesToWord(Buffer, 2));
              if (BlockCtr = ExpectedBlockCtr) then begin
                if BlockCtr = High(Word) then
                begin
                  // end of transfer, a block counter cannot wrap back to 0
                  SendError(Self, FPeerIP, FPeerPort, ErrAllocationExceeded, '');
                  raise EIdTFTPAllocationExceeded.Create('');
                end;
                Inc(BlockCtr);
                DataLen := IndyMin(BufferSize-4, StreamLen);
                SetLength(Buffer, 4 + DataLen);
                CopyTIdWord(GStack.HostToNetwork(Word(TFTP_DATA)), Buffer, 0);
                CopyTIdWord(GStack.HostToNetwork(BlockCtr), Buffer, 2);
                try
                  ReadTIdBytesFromStream(SourceStream, Buffer, DataLen, 4);
                except
                  on E: Exception do
                  begin
                    SendError(Self, FPeerIP, FPeerPort, E);
                    raise;
                  end;
                end;
                SendBuffer(FPeerIP, FPeerPort, Buffer);
                DoWork(wmWrite, DataLen);
                Dec(StreamLen, DataLen);
                TerminateTransfer := DataLen < (BufferSize - 4);
                ExpectedBlockCtr := BlockCtr;
              end;
            end;
          TFTP_ERROR:
            begin
              RaiseError(Buffer);
            end;
          TFTP_OACK:
            begin
              CheckOptionAck(Buffer, False);
           end;
         else
            begin
              SendError(Self, FPeerIP, FPeerPort, ErrIllegalOperation, '');
              raise EIdTFTPException.CreateFmt(RSTFTPUnexpectedOp, [FPeerIP, FPeerPort]);
            end;
        end;
      until False;
    finally
      EndWork(wmWrite);
    end;
  finally
    Binding.CloseSocket;
  end;
end;

procedure TIdTrivialFTP.Put(const LocalFile, ServerFile: String);
var
  fs: TIdReadFileExclusiveStream;
begin
  fs := TIdReadFileExclusiveStream.Create(LocalFile);
  try
    Put(fs, ServerFile);
  finally
    fs.Free;
  end;
end;

procedure TIdTrivialFTP.RaiseError(const ErrorPacket: TIdBytes);
var
  ErrMsg: string;
begin
  ErrMsg := BytesToString(ErrorPacket, 4, Length(ErrorPacket)-4, TIdTextEncoding.ASCII);
  case GStack.NetworkToHost(BytesToWord(ErrorPacket, 2)) of
    ErrFileNotFound:            raise EIdTFTPFileNotFound.Create(ErrMsg);
    ErrAccessViolation:         raise EIdTFTPAccessViolation.Create(ErrMsg);
    ErrAllocationExceeded:      raise EIdTFTPAllocationExceeded.Create(ErrMsg);
    ErrIllegalOperation:        raise EIdTFTPIllegalOperation.Create(ErrMsg);
    ErrUnknownTransferID:       raise EIdTFTPUnknownTransferID.Create(ErrMsg);
    ErrFileAlreadyExists:       raise EIdTFTPFileAlreadyExists.Create(ErrMsg);
    ErrNoSuchUser:              raise EIdTFTPNoSuchUser.Create(ErrMsg);
    ErrOptionNegotiationFailed: raise EIdTFTPOptionNegotiationFailed.Create(ErrMsg);
  else
    // usually ErrUndefined (see EIdTFTPException.Message if any)
    raise EIdTFTPException.Create(ErrMsg);
  end;
end;

procedure TIdTrivialFTP.SendAck(const BlockNumber: Word);
begin
  SendBuffer(FPeerIP, FPeerPort, MakeActPkt(BlockNumber));
end;

end.
