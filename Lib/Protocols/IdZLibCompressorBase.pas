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
  Rev 1.21    3/5/2005 3:33:54 PM  JPMugaas
  Fix for some compiler warnings having to do with TStream.Read being platform
  specific.  This was fixed by changing the Compressor API to use TIdStreamVCL
  instead of TStream.  I also made appropriate adjustments to other units for
  this.


  Rev 1.20    3/4/2005 12:36:58 PM  JPMugaas
  Removed some compiler warnings.


  Rev 1.19    9/16/2004 3:24:08 AM  JPMugaas
  TIdFTP now compresses to the IOHandler and decompresses from the IOHandler.

  Noted some that the ZLib code is based was taken from ZLibEx.


  Rev 1.18    9/12/2004 7:49:06 PM  JPMugaas
  Removed an abstract method that was removed from the descendant to prevent a
  warning.  It was part of an idea i had that hasn't yet developed due to
  another obsticle.


  Rev 1.17    9/11/2004 10:58:10 AM  JPMugaas
  FTP now decompresses output directly to the IOHandler.


  Rev 1.16    7/18/2004 3:01:44 PM  DSiders
  Added localization comments.


  Rev 1.15    6/15/2004 6:33:50 PM  JPMugaas
  Bug fix for RaidenFTPD and ShareIt FTP Server.  Since we now specifically
  look for the ZLIB headers, we pass the Window Bits value as negative
  DecompressFTPDeflate.  I have verified this on RaidenFTPD and ShareIt.

  Note that there is an inconsistancy in the FTP Deflate drafts

  http://community.roxen.com/developers/idocs/drafts/draft-preston-ftpext-deflat
  e-02.html

  and

  http://community.roxen.com/developers/idocs/drafts/draft-preston-ftpext-deflat
  e-00.html


  Rev 1.14    6/14/2004 6:14:42 PM  JPMugaas
  A fix from Bas.  RaidenFTPD 1455 (http://www.raidenftpd.com) was sending the

  2 byte header, the compression methods flags

  while ShareIt (www.noisette-software.com/products/windows/ShareIt/) was not
  doing so.


  Rev 1.13    2004.05.20 11:37:22 AM  czhower
  IdStreamVCL


  Rev 1.12    2/15/2004 6:56:44 AM  JPMugaas
  GZip decompression should now work again.


  Rev 1.11    2/15/2004 6:22:26 AM  JPMugaas
  Fixed some parameter errors.


  Rev 1.10    2/14/2004 9:59:48 PM  JPMugaas
  Reworked the API.  There is now a separate API for the Inflate_ and
  InflateInit2_ functions as well as separate functions for DeflateInit_ and
  DeflateInit2_.  This was required for FTP.  The API also includes an optional
  output stream for the servers.


  Rev 1.9    2/12/2004 11:35:00 PM  JPMugaas
  FTP Deflate preliminary support.  Work still needs to be done for upload and
  downloading.


  Rev 1.8    2/12/2004 11:11:24 AM  JPMugaas
  Added methods for HTTP Compression and decompression using RFC 1950.  I have
  verified these.


  Rev 1.7    2004.02.03 5:45:48 PM  czhower
  Name changes


  Rev 1.6    10/25/2003 06:52:26 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.


  Rev 1.5    10/24/2003 05:04:54 PM  JPMugaas
  SHould work as before.


  Rev 1.4    2003.10.24 10:43:14 AM  czhower
  TIdSTream to dos


  Rev 1.3    10/7/2003 10:07:08 PM  GGrieve
  Get HTTP compiling for DotNet


  Rev 1.2    7/13/2003 10:57:30 PM  BGooijen
  Fixed GZip and Deflate decoding


  Rev 1.1    7/13/2003 11:30:56 AM  JPMugaas
  Stub methods for Deflate and inflate methods if needed.


  Rev 1.0    7/13/2003 11:08:38 AM  JPMugaas
  classes for ZLib compression.
}
unit IdZLibCompressorBase;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent,
  IdStream,
  IdIOHandler;

type

  TIdCompressionLevel = 0..9;

  TIdZLibCompressorBase = class(TIdBaseComponent)
  protected
    //this is to prevent ZLib compression where a dynamically load
    //of ZLib fails.
    function GetIsReady : Boolean; virtual;
  public
    //these call the standard InflateInit and DeflateInit
    procedure DeflateStream(AInStream, AOutStream : TStream;
      const ALevel : TIdCompressionLevel=0); virtual; abstract;
    procedure InflateStream(AInStream, AOutStream : TStream); virtual; abstract;

    //VAdler32 is for the benefit of people needing the Adler32 for uncompressed data
    //these call the standard InflateInit2 and DeflateInit2
    procedure CompressStream(AInStream, AOutStream : TStream;
      const ALevel : TIdCompressionLevel;
      const AWindowBits, AMemLevel, AStrategy: Integer); virtual; abstract;

    procedure DecompressStream(AInStream, AOutStream : TStream;
      const AWindowBits : Integer); virtual; abstract;

    procedure DecompressDeflateStream(AInStream, AOutStream : TStream); virtual;

    //RFC 1950 complient input and output
    procedure CompressFTPDeflate(AInStream, AOutStream : TStream;
      const ALevel, AWindowBits, AMemLevel, AStrategy: Integer);
    procedure CompressFTPToIO(AInStream : TStream; AIOHandler : TIdIOHandler;
      const ALevel, AWindowBits, AMemLevel, AStrategy: Integer); virtual; abstract;
    procedure DecompressFTPFromIO(AIOHandler : TIdIOHandler; AOutputStream : TStream;
      const AWindowBits : Integer); virtual; abstract;
    procedure DecompressFTPDeflate(AInStream, AOutStream : TStream;
      const AWindowBits : Integer);
    procedure CompressHTTPDeflate(AInStream, AOutStream : TStream;
      const ALevel : TIdCompressionLevel);
    procedure DecompressHTTPDeflate(AInStream, AOutStream : TStream);
    //RFC 1952 complient input and output
    procedure DecompressGZipStream(AInStream, AOutStream : TStream); virtual;
    property IsReady : Boolean read GetIsReady;
  end;

  TIdZLibCompressorBaseClass = class of TIdZLibCompressorBase;

implementation

uses
  IdException,
  IdGlobal, SysUtils;

procedure TIdZLibCompressorBase.DecompressGZipStream(AInStream, AOutStream : TStream);

  procedure GotoDataStart;
  var
    LFlags: TIdBytes; //used as a byte
    LExtra: TIdBytes; //used as a word
    LNullFindChar: TIdBytes; //used as char
  begin
    SetLength(LFlags,1);
    SetLength(LExtra,2);
    SetLength(LNullFindChar,1);

    //skip id1,id2,CompressionMethod (id1 should=31, id2=139, CM should=8)
    TIdStreamHelper.Seek(AInStream, 3, soCurrent);
    //read Flag
    TIdStreamHelper.ReadBytes(AInStream, LFlags, 1);
    //skip mtime,xfl,os
    TIdStreamHelper.Seek(AInStream, 6, soCurrent);

    // at pos 10 now

    if (LFlags[0] and $4) = $4 then begin // FEXTRA
      TIdStreamHelper.ReadBytes(AInStream, LExtra, 2);
      TIdStreamHelper.Seek(AInStream, BytesToUInt16(LExtra), soCurrent);
    end;

    if (LFlags[0] and $8) = $8 then begin // FNAME
      repeat
        TIdStreamHelper.ReadBytes(AInStream, LNullFindChar, 1);
      until LNullFindChar[0] = 0;
    end;

    if (LFlags[0] and $10) = $10 then begin // FCOMMENT
      repeat
        TIdStreamHelper.ReadBytes(AInStream, LNullFindChar, 1);
      until LNullFindChar[0] = 0;
    end;

    if (LFlags[0] and $2) = $2 then begin // FHCRC
      TIdStreamHelper.Seek(AInStream, 2, soCurrent); // CRC16
    end;
  end;

var
  LBytes : TIdBytes;
begin
  Assert(AInStream<>nil);
  GotoDataStart;
  TIdStreamHelper.Seek(AInStream, -2, soCurrent);
  SetLength(LBytes, 2);
  LBytes[0] := $78; //7=32K blocks, 8=deflate
  LBytes[1] := $9C;
  TIdStreamHelper.Write(AInStream, LBytes, 2);
  TIdStreamHelper.Seek(AInStream, -2, soCurrent);
  AInStream.size := AInStream.size - 8; // remove the CRC32 and the size
  InflateStream(AInStream, AOutStream);
end;

procedure TIdZLibCompressorBase.DecompressDeflateStream(AInStream, AOutStream : TStream);
begin
  TIdStreamHelper.Seek(AInStream, 10, soCurrent); // skip junk at front
  InflateStream(AInStream, AOutStream);
end;

procedure TIdZLibCompressorBase.DecompressFTPDeflate(AInStream, AOutStream : TStream; const AWindowBits : Integer);
var
  LWinBits : Integer;
begin
  {
  This is a workaround for some clients and servers that do not send decompression
  headers.  The reason is that there's an inconsistancy in Internet Drafts for ZLIB
  compression.  One says to include the headers while an older one says do not
  include the headers.
  }
  LWinBits :=  AWindowBits ;
{
   windowBits can also be greater than 15 for optional gzip decoding. Add
   32 to windowBits to enable zlib and gzip decoding with automatic header
   detection, or add 16 to decode only the gzip format (the zlib format will
   return a Z_DATA_ERROR).
}
  if LWinBits > 0 then begin
    LWinBits := Abs(LWinBits) + 32;
  end;

  DecompressStream(AInStream,AOutStream,LWinBits);
end;

procedure TIdZLibCompressorBase.CompressFTPDeflate(AInStream, AOutStream : TStream;
  const ALevel, AWindowBits, AMemLevel, AStrategy: Integer);
begin
  CompressStream(AInStream, AOutStream, ALevel, AWindowBits, AMemLevel, AStrategy);
end;

procedure TIdZLibCompressorBase.CompressHTTPDeflate(AInStream, AOutStream : TStream; const ALevel : TIdCompressionLevel);
begin
  DeflateStream(AInStream, AOutStream, ALevel);
end;

procedure TIdZLibCompressorBase.DecompressHTTPDeflate(AInStream, AOutStream : TStream);
var
  LBCmp : TIdBytes; //used as Byte
  LFlags : TIdBytes; //used as Byte
  LDict : TIdBytes; //used as Cardinal
  LOrgPos : TIdStreamSize;
begin
  SetLength(LBCmp, 1);
  SetLength(LFlags, 1);
  SetLength(LDict, 4);
  LOrgPos := AInStream.Position;
  TIdStreamHelper.ReadBytes(AInStream, LBCmp, 1);
  TIdStreamHelper.ReadBytes(AInStream, LFlags, 1);
  if (((LBCmp[0] * 256) + LFlags[0]) mod 31) <> 0 then begin
    raise EIdException.Create('Error - invalid header'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
  TIdStreamHelper.ReadBytes(AInStream, LDict, 4);
  AInStream.Position := LOrgPos;
  InflateStream(AInStream, AOutStream);
  AInStream.Position := LOrgPos;
end;

function TIdZLibCompressorBase.GetIsReady: Boolean;
begin
  Result := True;
end;

end.
