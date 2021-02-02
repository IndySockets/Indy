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
  Rev 1.9    3/5/2005 3:33:54 PM  JPMugaas
  Fix for some compiler warnings having to do with TStream.Read being platform
  specific.  This was fixed by changing the Compressor API to use TIdStreamVCL
  instead of TStream.  I also made appropriate adjustments to other units for
  this.

  Rev 1.8    10/24/2004 2:40:28 PM  JPMugaas
  Made a better fix for the problem with SmartFTP.  It turns out that we may
  not be able to avoid a Z_BUF_ERROR in some cases.

  Rev 1.7    10/24/2004 11:17:08 AM  JPMugaas
  Reimplemented ZLIB Decompression in FTP better.  It now should work properly
  at ftp://ftp.smartftp.com.

  Rev 1.6    9/16/2004 3:24:04 AM  JPMugaas
  TIdFTP now compresses to the IOHandler and decompresses from the IOHandler.

  Noted some that the ZLib code is based was taken from ZLibEx.

  Rev 1.4    9/11/2004 10:58:04 AM  JPMugaas
  FTP now decompresses output directly to the IOHandler.

  Rev 1.3    6/21/2004 12:10:52 PM  JPMugaas
  Attempt to expand the ZLib support for Int64 support.

  Rev 1.2    2/21/2004 3:32:58 PM  JPMugaas
  Foxed for Unit rename.

  Rev 1.1    2/14/2004 9:59:50 PM  JPMugaas
  Reworked the API.  There is now a separate API for the Inflate_ and
  InflateInit2_ functions as well as separate functions for DeflateInit_ and
  DeflateInit2_.  This was required for FTP.  The API also includes an optional
  output stream for the servers.

  Rev 1.0    2/12/2004 11:27:22 PM  JPMugaas
  New compressor based on ZLibEx.
}

unit IdCompressorZLib;

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdException,
  IdIOHandler,
  IdZLibCompressorBase,
  IdZLibHeaders;

type
  TIdCompressorZLib = class(TIdZLibCompressorBase)
  protected
    function GetIsReady : Boolean; override;
    procedure InternalDecompressStream(LZstream: TZStreamRec; AIOHandler : TIdIOHandler;
      AOutStream: TStream);
  public

    procedure DeflateStream(AInStream, AOutStream : TStream;
      const ALevel : TIdCompressionLevel=0); override;
    procedure InflateStream(AInStream, AOutStream : TStream); override;

    procedure CompressStream(AInStream, AOutStream : TStream; const ALevel : TIdCompressionLevel; const AWindowBits, AMemLevel,
      AStrategy: Integer); override;
    procedure DecompressStream(AInStream, AOutStream : TStream; const AWindowBits : Integer); override;
    procedure CompressFTPToIO(AInStream : TStream; AIOHandler : TIdIOHandler;
      const ALevel, AWindowBits, AMemLevel, AStrategy: Integer); override;
     procedure DecompressFTPFromIO(AIOHandler : TIdIOHandler; AOutputStream : TStream;
       const AWindowBits : Integer); override;
  end;

  EIdCompressionException = class(EIdException);
  EIdCompressorInitFailure = class(EIdCompressionException);
  EIdDecompressorInitFailure = class(EIdCompressionException);
  EIdCompressionError = class(EIdCompressionException);
  EIdDecompressionError = class(EIdCompressionException);

implementation

uses
  IdAntiFreezeBase, IdComponent, IdResourceStringsProtocols, IdGlobal,
  IdGlobalProtocols, IdZLib, SysUtils;

const
  bufferSize = 32768;

{ TIdCompressorZLib }

procedure TIdCompressorZLib.InternalDecompressStream(
  LZstream: TZStreamRec; AIOHandler: TIdIOHandler; AOutStream: TStream);
{Note that much of this is taken from the ZLibEx unit and adapted to use the IOHandler}
var
  zresult  : Integer;
  outBuffer: Array [0..bufferSize-1] of TIdAnsiChar;
  inSize   : Integer;
  outSize  : Integer;
  LBuf : TIdBytes;

  function RawReadFromIOHandler(ABuffer : TIdBytes; AOIHandler : TIdIOHandler; AMax : Integer) : Integer;
  begin
    //We don't use the IOHandler.ReadBytes because that will check
    // for disconnect and raise an exception that we don't want.

    // RLebeau 3/26/09: we need to raise exceptions here!  The socket component
    // that is performing the IO needs to know what is happening on the socket...

    {
    repeat
      AIOHandler.CheckForDataOnSource(1);
      Result := IndyMin(AIOHandler.InputBuffer.Size, AMax);
      if Result > 0 then begin
        AIOHandler.InputBuffer.ExtractToBytes(ABuffer, Result, False);
        Break;
      end;
    until not AIOHandler.Connected;
    }

    // TODO: ReadStream() has been re-written to not use ReadBytes() anymore, it
    // now reads directly from the InputBuffer into the target TStream via
    // IOHandler.ReadFromSource() and IOHandler.InputBuffer.ExtractToStream(),
    // so we should do something similar here...

    // copied from TIdIOHandler.ReadStream() and trimmed down...
    try
      AIOHandler.ReadBytes(ABuffer, AMax, False);
    except
      on E: Exception do begin
        // RLebeau - ReadFromSource() inside of ReadBytes()
        // could have filled the InputBuffer with more bytes
        // than actually requested, so don't extract too
        // many bytes here...
        AMax := IndyMin(AMax, AIOHandler.InputBuffer.Size);
        AIOHandler.InputBuffer.ExtractToBytes(ABuffer, AMax, False);
        if not (E is EIdConnClosedGracefully) then begin
          raise;
        end;
      end;
    end;
    TIdAntiFreezeBase.DoProcess;
    Result := AMax;
  end;

begin
  SetLength(LBuf, bufferSize);
  repeat
    inSize := RawReadFromIOHandler(LBuf, AIOHandler, bufferSize);
    if inSize < 1 then begin
      Break;
    end;

    LZstream.next_in := PIdAnsiChar(@LBuf[0]);
    LZstream.avail_in := inSize;

    repeat
      LZstream.next_out := @outBuffer[0];
      LZstream.avail_out := bufferSize;
      DCheck(inflate(LZstream,Z_NO_FLUSH));
      outSize := bufferSize - LZstream.avail_out;
      AOutStream.Write(outBuffer, outSize);
    until (LZstream.avail_in = 0) and (LZstream.avail_out > 0);
  until False;
  { From the ZLIB FAQ at http://www.gzip.org/zlib/FAQ.txt

 5. deflate() or inflate() returns Z_BUF_ERROR

    Before making the call, make sure that avail_in and avail_out are not
    zero. When setting the parameter flush equal to Z_FINISH, also make sure
    that avail_out is big enough to allow processing all pending input.
    Note that a Z_BUF_ERROR is not fatal--another call to deflate() or
    inflate() can be made with more input or output space. A Z_BUF_ERROR
    may in fact be unavoidable depending on how the functions are used, since
    it is not possible to tell whether or not there is more output pending
    when strm.avail_out returns with zero.
}
  repeat
    LZstream.next_out := @outBuffer[0];
    LZstream.avail_out := bufferSize;

    zresult := inflate(LZstream, Z_FINISH);
    if zresult <> Z_BUF_ERROR then
    begin
      zresult := DCheck(zresult);
    end;
    outSize := bufferSize - LZstream.avail_out;
    AOutStream.Write(outBuffer, outSize);

  until ((zresult = Z_STREAM_END) and (LZstream.avail_out > 0)) or (zresult = Z_BUF_ERROR);

  DCheck(inflateEnd(LZstream));
end;

procedure TIdCompressorZLib.DecompressFTPFromIO(AIOHandler : TIdIOHandler; AOutputStream : TStream;
       const AWindowBits : Integer);
{Note that much of this is taken from the ZLibEx unit and adapted to use the IOHandler}
var
  Lzstream: TZStreamRec;
  LWinBits : Integer;
begin
  AIOHandler.BeginWork(wmRead);
  try
    FillChar(Lzstream,SizeOf(TZStreamRec),0);
    {
    This is a workaround for some clients and servers that do not send decompression
    headers.  The reason is that there's an inconsistancy in Internet Drafts for ZLIB
    compression.  One says to include the headers while an older one says do not
    include the headers.

    If you add 32 to the Window Bits parameter, 
    }
    LWinBits := AWindowBits;
    if LWinBits > 0 then
    begin
      LWinBits := Abs( LWinBits) + 32;
    end;
    LZstream.zalloc := zlibAllocMem;
    LZstream.zfree := zlibFreeMem;
    DCheck(inflateInit2_(Lzstream,LWinBits,ZLIB_VERSION,SizeOf(TZStreamRec)));

    InternalDecompressStream(Lzstream,AIOHandler,AOutputStream);
  finally
    AIOHandler.EndWork(wmRead);
  end;
end;

procedure TIdCompressorZLib.CompressFTPToIO(AInStream : TStream;
      AIOHandler : TIdIOHandler;
      const ALevel, AWindowBits, AMemLevel, AStrategy: Integer);
{Note that much of this is taken from the ZLibEx unit and adapted to use the IOHandler}
var
  LCompressRec : TZStreamRec;

  zresult  : Integer;
  inBuffer : Array [0..bufferSize-1] of TIdAnsiChar;
  outBuffer: Array [0..bufferSize-1] of TIdAnsiChar;
  inSize   : Integer;
  outSize  : Integer;
begin
  AIOHandler.BeginWork(wmWrite, AInStream.Size);
  try
    FillChar(LCompressRec, SizeOf(TZStreamRec), 0);
    CCheck( deflateInit2_(LCompressRec, ALevel, Z_DEFLATED, AWindowBits, AMemLevel,
        AStrategy, ZLIB_VERSION,  SizeOf(LCompressRec)));

    inSize := AInStream.Read(inBuffer, bufferSize);

    while inSize > 0 do
    begin
      LCompressRec.next_in := @inBuffer[0];
      LCompressRec.avail_in := inSize;

      repeat
        LCompressRec.next_out := @outBuffer[0];
        LCompressRec.avail_out := bufferSize;

        CCheck(deflate(LCompressRec,Z_NO_FLUSH));

        // outSize := zstream.next_out - outBuffer;
        outSize := bufferSize - LCompressRec.avail_out;
        if outsize <> 0 then
        begin
          AIOHandler.Write(RawToBytes(outBuffer, outSize));
        end;
      until (LCompressRec.avail_in = 0) and (LCompressRec.avail_out > 0);

      inSize := AInStream.Read(inBuffer, bufferSize);
    end;

    repeat
      LCompressRec.next_out := @outBuffer[0];
      LCompressRec.avail_out := bufferSize;

      zresult := CCheck(deflate(LCompressRec,Z_FINISH));

      // outSize := zstream.next_out - outBuffer;
      outSize := bufferSize - LCompressRec.avail_out;

      // outStream.Write(outBuffer,outSize);
      if outSize <> 0 then
      begin
        AIOHandler.Write(RawToBytes(outBuffer, outSize));
      end;
    until (zresult = Z_STREAM_END) and (LCompressRec.avail_out > 0);

    CCheck(deflateEnd(LCompressRec));

  finally
    AIOHandler.EndWork(wmWrite);
  end;
end;

procedure TIdCompressorZLib.CompressStream(AInStream,AOutStream : TStream;
  const ALevel : TIdCompressionLevel;
  const AWindowBits, AMemLevel, AStrategy: Integer);

begin
  IdZLib.IndyCompressStream(AInStream,AOutStream,ALevel,AWindowBits,AMemLevel,AStrategy);
end;

procedure TIdCompressorZLib.DecompressStream(AInStream, AOutStream : TStream; const AWindowBits : Integer);
begin
  IdZLib.IndyDeCompressStream(AInStream,AOutStream, AWindowBits);
end;    

procedure TIdCompressorZLib.DeflateStream(AInStream, AOutStream : TStream; const ALevel : TIdCompressionLevel=0);
begin
  IdZLib.IndyCompressStream(AInStream,AOutStream,ALevel);
end;

function TIdCompressorZLib.GetIsReady: Boolean;
begin
  Result := IdZLibHeaders.Load;
end;

procedure TIdCompressorZLib.InflateStream(AInStream, AOutStream : TStream);
begin
  IdZlib.DeCompressStream(AInStream,AOutStream);
end;

end.
