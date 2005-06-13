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
{   Rev 1.10    2/22/2004 12:04:00 AM  JPMugaas
{ Updated for file rename.
}
{
{   Rev 1.9    2/12/2004 11:28:04 PM  JPMugaas
{ Modified compression intercept to use the ZLibEx unit.
}
{
{   Rev 1.8    2004.02.09 9:56:00 PM  czhower
{ Fixed for lib changes.
}
{
{   Rev 1.7    5/12/2003 12:31:00 AM  GGrieve
{ Get compiling again with DotNet Changes
}
{
{   Rev 1.6    10/12/2003 1:49:26 PM  BGooijen
{ Changed comment of last checkin
}
{
{   Rev 1.5    10/12/2003 1:43:24 PM  BGooijen
{ Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc
}
{
    Rev 1.3    6/27/2003 2:38:04 PM  BGooijen
  Fixed bug where last part was not compressed/send
}
{
    Rev 1.2    4/10/2003 4:12:42 PM  BGooijen
  Added TIdServerCompressionIntercept
}
{
    Rev 1.1    4/3/2003 2:55:48 PM  BGooijen
  Now calls DeinitCompressors on disconnect
}
{
{   Rev 1.0    11/14/2002 02:15:50 PM  JPMugaas
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
  IdZLibEx;

type
  EIdCompressionException = class(EIdException);
  EIdCompressorInitFailure = class(EIdCompressionException);
  EIdDecompressorInitFailure = class(EIdCompressionException);
  EIdCompressionError = class(EIdCompressionException);
  EIdDecompressionError = class(EIdCompressionException);
  TCompressionLevel = 0..9;

  TIdCompressionIntercept = class(TIdConnectionIntercept)
  protected
    FCompressionLevel: TCompressionLevel;
    FCompressRec: TZStreamRec;
    FDecompressRec: TZStreamRec;
    FRecvBuf: Pointer;
    FRecvCount, FRecvSize: Integer;
    FSendBuf: Pointer;
    FSendCount, FSendSize: Integer;
    procedure SetCompressionLevel(Value: TCompressionLevel);
    procedure InitCompressors;
    procedure DeinitCompressors;
  public
    destructor Destroy; override;
    procedure Disconnect; override;
    procedure Receive(var VBuffer: TIdBytes); override;
    procedure Send(var VBuffer: TIdBytes); override;
  published
    property CompressionLevel: TCompressionLevel read FCompressionLevel write SetCompressionLevel;
  end;

  TIdServerCompressionIntercept = class(TIdServerIntercept)
  protected
    FCompressionLevel: TCompressionLevel;
  public
    procedure Init; override;
    function Accept(AConnection: TComponent): TIdConnectionIntercept; override;
  published
    property CompressionLevel: TCompressionLevel read FCompressionLevel write FCompressionLevel;
  end;


implementation

uses
  IdResourceStringsProtocols, IdExceptionCore;

{ TIdCompressionIntercept }

procedure TIdCompressionIntercept.DeinitCompressors;
begin
  if Assigned(FCompressRec.zalloc) then
  begin
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
  FreeMem(FRecvBuf);
  FreeMem(FSendBuf);
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
    FCompressRec.zalloc := zcalloc;
    FCompressRec.zfree := zcfree;
    if deflateInit_(FCompressRec, FCompressionLevel, zlib_Version, SizeOf(FCompressRec)) <> Z_OK then
    begin
      raise EIdCompressorInitFailure.Create(RSZLCompressorInitializeFailure);
    end;
  end;
  if not Assigned(FDecompressRec.zalloc) then
  begin
    FDecompressRec.zalloc := zcalloc;
    FDecompressRec.zfree := zcfree;
    if inflateInit_(FDecompressRec, zlib_Version, SizeOf(FDecompressRec)) <> Z_OK then
    begin
      raise EIdDecompressorInitFailure.Create(RSZLDecompressorInitializeFailure);
    end;
  end;
end;

procedure TIdCompressionIntercept.Receive(var VBuffer: TIdBytes);
var
  Buffer: array[0..2047] of Char;
  LPos : integer;
  nChars, C: Integer;
  StreamEnd: Boolean;
begin
  if FCompressionLevel in [1..9] then
  begin
    InitCompressors;
    StreamEnd := False;
    LPos := 0;
    repeat
      nChars := max(Length(VBuffer) - LPos, SizeOf(Buffer));
      inc(LPos, nChars);
      if nChars = 0 then Break;
      FDecompressRec.next_in := Buffer;
      FDecompressRec.avail_in := nChars;
      FDecompressRec.total_in := 0;
      while FDecompressRec.avail_in > 0 do
      begin
        if FRecvCount = FRecvSize then
        begin
          if FRecvSize = 0 then
            FRecvSize := 2048
          else
            Inc(FRecvSize, 1024);
          ReallocMem(FRecvBuf, FRecvSize);
        end;
        FDecompressRec.next_out := PChar(FRecvBuf) + FRecvCount;
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
    move(FRecvBuf^, VBuffer[0], FRecvCount);
    FRecvCount := 0;
  end;
end;

procedure TIdCompressionIntercept.Send(var VBuffer: TIdBytes);
var
  Buffer: array[0..1023] of Char;
  LLen : integer;
begin
  if FCompressionLevel in [1..9] then
  begin
    InitCompressors;
    // Make sure the Send buffer is large enough to hold the input stream data
    if Length(VBuffer) > FSendSize then
    begin
      if Length(VBuffer) > 2048 then
      begin
        FSendSize := Length(VBuffer) + (Length(VBuffer) + 1023) mod 1024;
      end
      else
      begin
        FSendSize := 2048;
      end;
      ReallocMem(FSendBuf, FSendSize);
    end;
    // Get the data from the input stream and save it off
    FSendCount := Length(VBuffer);
    move(VBuffer[0], FSendBuf^, Length(VBuffer));
    FCompressRec.next_in := FSendBuf;
    FCompressRec.avail_in := FSendCount;
    FCompressRec.avail_out := 0;
    // reset and clear the input stream in preparation for compression
    SetLength(VBuffer, 0);
    // As long as data is being outputted, keep compressing
    while FCompressRec.avail_out = 0 do
    begin
      FCompressRec.next_out := Buffer;
      FCompressRec.avail_out := SizeOf(Buffer);
      case deflate(FCompressRec, Z_SYNC_FLUSH) of
        Z_STREAM_ERROR,
        Z_DATA_ERROR,
        Z_MEM_ERROR: raise EIdCompressionError.Create(RSZLCompressionError);
      end;
      // Place the compressed data back into the input stream
      LLen := Length(VBuffer);
      SetLength(VBuffer, Length(VBuffer) + SizeOf(Buffer) - FCompressRec.avail_out);
      move(Buffer, VBuffer[LLen], SizeOf(Buffer) - FCompressRec.avail_out);
    end;
  end;
end;

procedure TIdCompressionIntercept.SetCompressionLevel(Value: TCompressionLevel);
begin
  if Value <> FCompressionLevel then
  begin
    DeinitCompressors;
    if Value < 0 then
    begin
      Value := 0;
    end;
    if Value > 9 then
    begin
      Value := 9;
    end;
    FCompressionLevel := Value;
  end;
end;

{ TIdServerCompressionIntercept }

procedure TIdServerCompressionIntercept.Init;
begin
end;

function TIdServerCompressionIntercept.Accept(AConnection: TComponent): TIdConnectionIntercept;
begin
  Result:=TIdCompressionIntercept.create(nil);
  TIdCompressionIntercept(Result).CompressionLevel:=CompressionLevel;
end;

end.

