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


  $Log$


   Rev 1.10    2/22/2004 12:04:00 AM  JPMugaas
 Updated for file rename.


   Rev 1.9    2/12/2004 11:28:04 PM  JPMugaas
 Modified compression intercept to use the ZLibEx unit.


   Rev 1.8    2004.02.09 9:56:00 PM  czhower
 Fixed for lib changes.


   Rev 1.7    5/12/2003 12:31:00 AM  GGrieve
 Get compiling again with DotNet Changes


   Rev 1.6    10/12/2003 1:49:26 PM  BGooijen
 Changed comment of last checkin


   Rev 1.5    10/12/2003 1:43:24 PM  BGooijen
 Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc


    Rev 1.3    6/27/2003 2:38:04 PM  BGooijen
  Fixed bug where last part was not compressed/send


    Rev 1.2    4/10/2003 4:12:42 PM  BGooijen
  Added TIdServerCompressionIntercept


    Rev 1.1    4/3/2003 2:55:48 PM  BGooijen
  Now calls DeinitCompressors on disconnect


   Rev 1.0    11/14/2002 02:15:50 PM  JPMugaas
}
unit IdCompressionIntercept;

{  This file implements an Indy intercept component that compresses a data
   stream using the open-source zlib compression library.  In order for this
   file to compile on Windows, the follow .obj files *must* be provided as
   delivered with this file:

   deflate.obj
   inflate.obj
   inftrees.obj
   trees.obj
   adler32.obj
   infblock.obj
   infcodes.obj
   infutil.obj
   inffast.obj

   On Linux, the shared-object file libz.so.1 *must* be available on the
   system.  Most modern Linux distributions include this file.

   Simply set the CompressionLevel property to a value between 1 and 9 to
   enable compressing of the data stream.  A setting of 0(zero) disables
   compression and the component is dormant.  The sender *and* received must
   have compression enabled in order to properly decompress the data stream.
   They do *not* have to use the same CompressionLevel as long as they are
   both set to a value between 1 and 9.

   Original Author: Allen Bauer

   This source file is submitted to the Indy project on behalf of Borland
   Sofware Corporation.  No warranties, express or implied are given with
   this source file.
}
interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdException,
  IdGlobal,
  IdGlobalProtocols,
  IdIntercept,
  IdTCPClient,
  IdTCPConnection,
  IdZLibHeaders,
  IdZLib;

type
  EIdCompressionException = class(EIdException);
  EIdCompressorInitFailure = class(EIdCompressionException);
  EIdDecompressorInitFailure = class(EIdCompressionException);
  EIdCompressionError = class(EIdCompressionException);
  EIdDecompressionError = class(EIdCompressionException);

  TIdCompressionLevel = 0..9;

  TIdCompressionIntercept = class(TIdConnectionIntercept)
  protected
    FCompressionLevel: TIdCompressionLevel;
    FCompressRec: TZStreamRec;
    FDecompressRec: TZStreamRec;
    FRecvBuf: TIdBytes;
    FRecvCount, FRecvSize: UInt32;
    FSendBuf: TIdBytes;
    FSendCount, FSendSize: UInt32;
    procedure SetCompressionLevel(Value: TIdCompressionLevel);
    procedure InitCompressors;
    procedure DeinitCompressors;
  public
    destructor Destroy; override;
    procedure Disconnect; override;
    procedure Receive(var VBuffer: TIdBytes); override;
    procedure Send(var VBuffer: TIdBytes); override;
  published
    property CompressionLevel: TIdCompressionLevel read FCompressionLevel write SetCompressionLevel;
  end;

  TIdServerCompressionIntercept = class(TIdServerIntercept)
  protected
    FCompressionLevel: TIdCompressionLevel;
  public
    procedure Init; override;
    function Accept(AConnection: TComponent): TIdConnectionIntercept; override;
  published
    property CompressionLevel: TIdCompressionLevel read FCompressionLevel write FCompressionLevel;
  end;


implementation

uses
  IdResourceStringsProtocols, IdExceptionCore;

{ TIdCompressionIntercept }

procedure TIdCompressionIntercept.DeinitCompressors;
begin
  if Assigned(FCompressRec.zalloc) then begin
    deflateEnd(FCompressRec);
    FillChar(FCompressRec, SizeOf(FCompressRec), 0);
  end;
  if Assigned(FDecompressRec.zalloc) then
  begin
    inflateEnd(FDecompressRec);
    FillChar(FDecompressRec, SizeOf(FDecompressRec), 0);
  end;
end;

destructor TIdCompressionIntercept.Destroy;
begin
  DeinitCompressors;
  SetLength(FRecvBuf, 0);
  SetLength(FSendBuf, 0);
  inherited Destroy;
end;

procedure TIdCompressionIntercept.Disconnect;
begin
  inherited Disconnect;
  DeinitCompressors;
end;

procedure TIdCompressionIntercept.InitCompressors;
begin
  if not Assigned(FCompressRec.zalloc) then
  begin
    FCompressRec.zalloc := IdZLibHeaders.zlibAllocMem;
    FCompressRec.zfree := IdZLibHeaders.zlibFreeMem;
    if deflateInit_(FCompressRec, FCompressionLevel, zlib_Version, SizeOf(FCompressRec)) <> Z_OK then
    begin
      raise EIdCompressorInitFailure.Create(RSZLCompressorInitializeFailure);
    end;
  end;
  if not Assigned(FDecompressRec.zalloc) then
  begin
    FDecompressRec.zalloc := IdZLibHeaders.zlibAllocMem;
    FDecompressRec.zfree := IdZLibHeaders.zlibFreeMem;
    if inflateInit_(FDecompressRec, zlib_Version, SizeOf(FDecompressRec)) <> Z_OK then
    begin
      raise EIdDecompressorInitFailure.Create(RSZLDecompressorInitializeFailure);
    end;
  end;
end;

procedure TIdCompressionIntercept.Receive(var VBuffer: TIdBytes);
var
  LBuffer: TIdBytes;
  LPos : integer;
  nChars, C : UInt32;
  StreamEnd: Boolean;
begin
  // let the next Intercept in the chain decode its data first
  inherited Receive(VBuffer);

  SetLength(LBuffer, 2048);
  if FCompressionLevel in [1..9] then
  begin
    InitCompressors;
    StreamEnd := False;
    LPos := 0;
    repeat
      nChars := IndyMin(Length(VBuffer) - LPos, Length(LBuffer));
      if nChars = 0 then begin
        Break;
      end;
      CopyTIdBytes(VBuffer, LPos, LBuffer, 0, nChars);
      Inc(LPos, nChars);
      FDecompressRec.next_in := PIdAnsiChar(@LBuffer[0]);
      FDecompressRec.avail_in := nChars;
      FDecompressRec.total_in := 0;
      while FDecompressRec.avail_in > 0 do
      begin
        if FRecvCount = FRecvSize then begin
          if FRecvSize = 0 then begin
            FRecvSize := 2048;
          end else begin
            Inc(FRecvSize, 1024);
          end;
          SetLength(FRecvBuf, FRecvSize);
        end;
        FDecompressRec.next_out := PIdAnsiChar(@FRecvBuf[FRecvCount]);
        C := FRecvSize - FRecvCount;
        FDecompressRec.avail_out := C;
        FDecompressRec.total_out := 0;
        case inflate(FDecompressRec, Z_NO_FLUSH) of
          Z_STREAM_END:
            StreamEnd := True;
          Z_STREAM_ERROR,
          Z_DATA_ERROR,
          Z_MEM_ERROR:
            raise EIdDecompressionError.Create(RSZLDecompressionError);
        end;
        Inc(FRecvCount, C - FDecompressRec.avail_out);
      end;
    until StreamEnd;
    SetLength(VBuffer, FRecvCount);
    CopyTIdBytes(FRecvBuf, 0, VBuffer, 0, FRecvCount);
    FRecvCount := 0;
  end;
end;

procedure TIdCompressionIntercept.Send(var VBuffer: TIdBytes);
var
  LBuffer: TIdBytes;
  LLen, LSize: UInt32;
begin
  LBuffer := nil;
  if FCompressionLevel in [1..9] then
  begin
    InitCompressors;
    // Make sure the Send buffer is large enough to hold the input data
    LSize := Length(VBuffer);
    if LSize > FSendSize then
    begin
      if LSize > 2048 then begin
        FSendSize := LSize + (LSize + 1023) mod 1024;
      end else begin
        FSendSize := 2048;
      end;
      SetLength(FSendBuf, FSendSize);
    end;

    // Get the data from the input and save it off
    // TODO: get rid of FSendBuf and use ABuffer directly
    FSendCount := LSize;
    CopyTIdBytes(VBuffer, 0, FSendBuf, 0, FSendCount);
    FCompressRec.next_in := PIdAnsiChar(@FSendBuf[0]);
    FCompressRec.avail_in := FSendCount;
    FCompressRec.avail_out := 0;

    // clear the output stream in preparation for compression
    SetLength(VBuffer, 0);
    SetLength(LBuffer, 1024);

    // As long as data is being outputted, keep compressing
    while FCompressRec.avail_out = 0 do
    begin
      FCompressRec.next_out := PIdAnsiChar(@LBuffer[0]);
      FCompressRec.avail_out := Length(LBuffer);
      case deflate(FCompressRec, Z_SYNC_FLUSH) of
        Z_STREAM_ERROR,
        Z_DATA_ERROR,
        Z_MEM_ERROR: raise EIdCompressionError.Create(RSZLCompressionError);
      end;
      // Place the compressed data into the output stream
      LLen := Length(VBuffer);
      SetLength(VBuffer, LLen + UInt32(Length(LBuffer)) - FCompressRec.avail_out);
      CopyTIdBytes(LBuffer, 0, VBuffer, LLen, UInt32(Length(LBuffer)) - FCompressRec.avail_out);
    end;
  end;

  // let the next Intercept in the chain encode its data next
  inherited Send(VBuffer);
end;

procedure TIdCompressionIntercept.SetCompressionLevel(Value: TIdCompressionLevel);
begin
  if Value < 0 then begin
    Value := 0;
  end else if Value > 9 then begin
    Value := 9;
  end;
  if Value <> FCompressionLevel then begin
    DeinitCompressors;
    FCompressionLevel := Value;
  end;
end;

{ TIdServerCompressionIntercept }

procedure TIdServerCompressionIntercept.Init;
begin
end;

function TIdServerCompressionIntercept.Accept(AConnection: TComponent): TIdConnectionIntercept;
begin
  Result := TIdCompressionIntercept.Create(nil);
  TIdCompressionIntercept(Result).CompressionLevel := CompressionLevel;
end;

end.

