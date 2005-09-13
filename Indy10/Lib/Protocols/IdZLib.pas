{*******************************************************}
{                                                       }
{       Borland Delphi Supplemental Components          }
{       ZLIB Data Compression Interface Unit            }
{                                                       }
{       Copyright (c) 1997,99 Borland Corporation       }
{                                                       }
{*******************************************************}

{ Updated for zlib 1.2.x by Cosmin Truta <cosmint@cs.ubbcluj.ro> }

{
His readme is below:
==

Overview
========

This directory contains an update to the ZLib interface unit,
distributed by Borland as a Delphi supplemental component.

The original ZLib unit is Copyright (c) 1997,99 Borland Corp.,
and is based on zlib version 1.0.4.  There are a series of bugs
and security problems associated with that old zlib version, and
we recommend the users to update their ZLib unit.


Summary of modifications
========================

- Improved makefile, adapted to zlib version 1.2.1.

- Some field types from TZStreamRec are changed from Integer to
  Longint, for consistency with the zlib.h header, and for 64-bit
  readiness.

- The zlib_version constant is updated.

- The new Z_RLE strategy has its corresponding symbolic constant.

- The allocation and deallocation functions and function types
  (TAlloc, TFree, zlibAllocMem and zlibFreeMem) are now cdecl,
  and _malloc and _free are added as C RTL stubs.  As a result,
  the original C sources of zlib can be compiled out of the box,
  and linked to the ZLib unit.


Suggestions for improvements
============================

Currently, the ZLib unit provides only a limited wrapper around
the zlib library, and much of the original zlib functionality is
missing.  Handling compressed file formats like ZIP/GZIP or PNG
cannot be implemented without having this functionality.
Applications that handle these formats are either using their own,
duplicated code, or not using the ZLib unit at all.

Here are a few suggestions:

- Checksum class wrappers around adler32() and crc32(), similar
  to the Java classes that implement the java.util.zip.Checksum
  interface.

- The ability to read and write raw deflate streams, without the
  zlib stream header and trailer.  Raw deflate streams are used
  in the ZIP file format.

- The ability to read and write gzip streams, used in the GZIP
  file format, and normally produced by the gzip program.

- The ability to select a different compression strategy, useful
  to PNG and MNG image compression, and to multimedia compression
  in general.  Besides the compression level

    TCompressionLevel = (clNone, clFastest, clDefault, clMax);

  which, in fact, could have used the 'z' prefix and avoided
  TColor-like symbols

    TCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);

  there could be a compression strategy

    TCompressionStrategy = (zsDefault, zsFiltered, zsHuffmanOnly, zsRle);

- ZIP and GZIP stream handling via TStreams.


--
Cosmin Truta <cosmint@cs.ubbcluj.ro>

==
}
{
Aug. 25, 2005
J. Peter Mugaas - my revision notes:

- I basically expanded the unit with definitions from zlib.h from the
Zlib 1.23 distribution at http://www.zlib.net/ .
- I made sure to reexpose the basic raw ZLib API for compatibility and to
provide developers with the maximum amount of flexibility.
- I then updated the definitions so they could work on Kylix by statically
linking to the zlib.so.1 file.  This might not work with some older Linux
distributions that are unsupported and have older ZLib versions.  I do not
know because I have not tested those.

Aug 26, 2005 - J. Peter Mugaas
- I changed the ZLib exception class to have an error code property so
developers can diagnose errors better than they used to.
- CCheck and DCheck now raise exceptions with the error message from the ZLib
library itself instead of the 'error' message.  This is obtained through the
zError function I exposed yesterday.

Aug 27, 2005 - J. Peter Mugaas
-Added vernum constant
-Added Z_NUL constant
- Added Z_BLOCK constant

Note that I did use "Enhanced zlib implementation" from:
  Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>
as a reference to help with some new callback functions with inflate and for
double checking some of my interpretations.  I could not use his header because
I would have had to modify the header for Kylix compatibility and to be
compatible with Borland's original ZLIB.pas header.

}
unit IdZLib;
//note that we can't reference IdCompilerDefines for the moment.

// Delphi 4
{$IFDEF VER120}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL40}
  {$DEFINE DELPHI4}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE MSWINDOWS}
{$ENDIF}

// C++ Builder 4
{$IFDEF VER125}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL40}
  {$DEFINE CBUILDER4}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE MSWINDOWS}
{$ENDIF}

// Delphi 5 & CBuilder 5
{$IFDEF VER130}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL5}
  {$IFDEF BCB}
    {$DEFINE CBUILDER5}
  {$ELSE}
    {$DEFINE DELPHI5}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE MSWINDOWS}
{$ENDIF}

//Delphi 6
{$IFDEF VER140}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER6}
    {$DEFINE ALLOW_NAMED_THREADS}
  {$ELSE}
    {$DEFINE DELPHI6}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL60}
{$ENDIF}

//Delphi 7
{$IFDEF VER150}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL70}
  {$IFDEF BCB}
    {$DEFINE CBUILDER7}
  {$ELSE}
    {$DEFINE DELPHI7}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 8
{$IFDEF VER160}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL80}
  {$DEFINE DELPHI8}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 9
{$IFDEF VER170}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL90}
  {$DEFINE DELPHI9}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 10
{$IFDEF VER180}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL10}
  {$DEFINE DELPHI10}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 11
{$IFDEF VER190}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL11ORABOVE}
  {$DEFINE VCL11}
  {$DEFINE DELPHI11}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}
interface

uses SysUtils, Classes;

type
  PLongInt = ^LongInt;
  TAlloc = function (AppData: Pointer; Items, Size: Integer): Pointer; cdecl;
  TFree = procedure (AppData, Block: Pointer); cdecl;
  //the user has to set the Buf pointer to their buffer address
  TInFunc = function (AppData : Pointer; var Buf : Pointer) : Integer; cdecl;
  TOutFunc = function (AppData : Pointer; Buf : Pointer; Size : Integer) : Integer; cdecl;

{JPM addition}
//*
//     gzip header information passed to and from zlib routines.  See RFC 1952
//  for more details on the meanings of these fields.
//*/
//  in zlib.h, it's defined like this:
//typedef struct gz_header_s {
//    int     text;       /* true if compressed data believed to be text */
//    uLong   time;       /* modification time */
//    int     xflags;     /* extra flags (not used when writing a gzip file) */
//    int     os;         /* operating system */
//    Bytef   *extra;     /* pointer to extra field or Z_NULL if none */
//    uInt    extra_len;  /* extra field length (valid if extra != Z_NULL) */
//    uInt    extra_max;  /* space at extra (only when reading header) */
//    Bytef   *name;      /* pointer to zero-terminated file name or Z_NULL */
//    uInt    name_max;   /* space at name (only when reading header) */
//    Bytef   *comment;   /* pointer to zero-terminated comment or Z_NULL */
//    uInt    comm_max;   /* space at comment (only when reading header) */
//    int     hcrc;       /* true if there was or will be a header crc */
//    int     done;       /* true when done reading gzip header (not used
//                           when writing a gzip file) */
//} gz_header;
  PgzHeaderRec = ^TgzHeaderRec;
  TgzHeaderRec = packed record
    text : Integer;        //* true if compressed data believed to be text */
    time : Cardinal;       //* modification time */
    xflags : Integer;      //* extra flags (not used when writing a gzip file) */
    os : Integer;          //* operating system */
    extra : PChar;         //* pointer to extra field or Z_NULL if none */
    extra_len : Cardinal;  //* extra field length (valid if extra != Z_NULL) */
    extra_max : Cardinal;  //* space at extra (only when reading header) */
    name : PChar;          //* pointer to zero-terminated file name or Z_NULL */
    name_max : Cardinal;   //* space at name (only when reading header) */
    comment : Cardinal;    //* pointer to zero-terminated comment or Z_NULL */
    comm_max : Cardinal;   //* space at comment (only when reading header) */
    hcrc : Integer;        //* true if there was or will be a header crc */
    done : Integer;        //* true when done reading gzip header (not used
                           //  when writing a gzip file) */
  end;
{end addition}
  TZStreamRec = packed record
    next_in: PChar;       // next input byte
    avail_in: Integer;    // number of bytes available at next_in
    total_in: Longint;    // total nb of input bytes read so far

    next_out: PChar;      // next output byte should be put here
    avail_out: Integer;   // remaining free space at next_out
    total_out: Longint;   // total nb of bytes output so far

    msg: PChar;           // last error message, NULL if no error
    internal: Pointer;    // not visible by applications

    zalloc: TAlloc;       // used to allocate the internal state
    zfree: TFree;         // used to free the internal state
    AppData: Pointer;     // private data object passed to zalloc and zfree

    data_type: Integer;   // best guess about the data type: ascii or binary
    adler: Longint;       // adler32 value of the uncompressed data
    reserved: Longint;    // reserved for future use
  end;

  // Abstract ancestor class
  TCustomZlibStream = class(TStream)
  private
    FStrm: TStream;
    FStrmPos: Integer;
    FOnProgress: TNotifyEvent;
    FZRec: TZStreamRec;
    FBuffer: array [Word] of Char;
  protected
    procedure Progress(Sender: TObject); dynamic;
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
    constructor Create(Strm: TStream);
  end;

{ TCompressionStream compresses data on the fly as data is written to it, and
  stores the compressed data to another stream.

  TCompressionStream is write-only and strictly sequential. Reading from the
  stream will raise an exception. Using Seek to move the stream pointer
  will raise an exception.

  Output data is cached internally, written to the output stream only when
  the internal output buffer is full.  All pending output data is flushed
  when the stream is destroyed.

  The Position property returns the number of uncompressed bytes of
  data that have been written to the stream so far.

  CompressionRate returns the on-the-fly percentage by which the original
  data has been compressed:  (1 - (CompressedBytes / UncompressedBytes)) * 100
  If raw data size = 100 and compressed data size = 25, the CompressionRate
  is 75%

  The OnProgress event is called each time the output buffer is filled and
  written to the output stream.  This is useful for updating a progress
  indicator when you are writing a large chunk of data to the compression
  stream in a single call.}


  TCompressionLevel = (clNone, clFastest, clDefault, clMax);

  TCompressionStream = class(TCustomZlibStream)
  private
    function GetCompressionRate: Single;
  public
    constructor Create(CompressionLevel: TCompressionLevel; Dest: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    property CompressionRate: Single read GetCompressionRate;
    property OnProgress;
  end;

{ TDecompressionStream decompresses data on the fly as data is read from it.

  Compressed data comes from a separate source stream.  TDecompressionStream
  is read-only and unidirectional; you can seek forward in the stream, but not
  backwards.  The special case of setting the stream position to zero is
  allowed.  Seeking forward decompresses data until the requested position in
  the uncompressed data has been reached.  Seeking backwards, seeking relative
  to the end of the stream, requesting the size of the stream, and writing to
  the stream will raise an exception.

  The Position property returns the number of bytes of uncompressed data that
  have been read from the stream so far.

  The OnProgress event is called each time the internal input buffer of
  compressed data is exhausted and the next block is read from the input stream.
  This is useful for updating a progress indicator when you are reading a
  large chunk of data from the decompression stream in a single call.}

  TDecompressionStream = class(TCustomZlibStream)
  public
    constructor Create(Source: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    property OnProgress;
  end;



{ CompressBuf compresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
  Out: OutBuf = ptr to newly allocated buffer containing decompressed data
       OutBytes = number of bytes in OutBuf   }
procedure CompressBuf(const InBuf: Pointer; InBytes: Integer;
                      out OutBuf: Pointer; out OutBytes: Integer);


{ DecompressBuf decompresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
       OutEstimate = zero, or est. size of the decompressed data
  Out: OutBuf = ptr to newly allocated buffer containing decompressed data
       OutBytes = number of bytes in OutBuf   }
procedure DecompressBuf(const InBuf: Pointer; InBytes: Integer;
 OutEstimate: Integer; out OutBuf: Pointer; out OutBytes: Integer);

{ DecompressToUserBuf decompresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
  Out: OutBuf = ptr to user-allocated buffer to contain decompressed data
       BufSize = number of bytes in OutBuf   }
procedure DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);

const
  zlib_version = '1.2.3';
  ZLIB_VERNUM = $1230;

  Z_NO_FLUSH      = 0;
  Z_PARTIAL_FLUSH = 1; // * will be removed, use Z_SYNC_FLUSH instead *
  Z_SYNC_FLUSH    = 2;
  Z_FULL_FLUSH    = 3;
  Z_FINISH        = 4;
  Z_BLOCK         = 5;
  
  Z_OK            = 0;
  Z_STREAM_END    = 1;
  Z_NEED_DICT     = 2;
  Z_ERRNO         = (-1);
  Z_STREAM_ERROR  = (-2);
  Z_DATA_ERROR    = (-3);
  Z_MEM_ERROR     = (-4);
  Z_BUF_ERROR     = (-5);
  Z_VERSION_ERROR = (-6);

  Z_NO_COMPRESSION       =   0;
  Z_BEST_SPEED           =   1;
  Z_BEST_COMPRESSION     =   9;
  Z_DEFAULT_COMPRESSION  = (-1);

  Z_FILTERED            = 1;
  Z_HUFFMAN_ONLY        = 2;
  Z_RLE                 = 3;
  Z_DEFAULT_STRATEGY    = 0;

  Z_BINARY   = 0;
  Z_ASCII    = 1;
  Z_UNKNOWN  = 2;

  Z_DEFLATED = 8;

  Z_NULL     = 0;  //* for initializing zalloc, zfree, opaque */

  //winbit constants
  MAX_WBITS = 15;   //standard zlib stream - { 32K LZ77 window }
  GZIP_WINBITS = MAX_WBITS + 16; //GZip format
  //negative values mean do not add any headers
  //adapted from "Enhanced zlib implementation"
  //by Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>
  RAW_WBITS = -MAX_WBITS; //raw stream (without any header)

  MAX_MEM_LEVEL = 9;
  DEF_MEM_LEVEL = 8; { if MAX_MEM_LEVEL > 8 }
    
type
  EZlibError = class(Exception)
  {JPM Additions, we need to be able to provide diangostic info
  in an exception}
  protected
    FErrorCode : Integer;
  public
    constructor CreateError(const AError : Integer);
    property ErrorCode : Integer read FErrorCode;
  end;
  ECompressionError = class(EZlibError);
  EDecompressionError = class(EZlibError);

//ZLib error functions.  They raise an exception for ZLib codes less than zero
function DCheck(code: Integer): Integer;
function CCheck(code: Integer): Integer;

//generic callback procedures for inflate and deflate calls
function zlibAllocMem(AppData: Pointer; Items, Size: Integer): Pointer; cdecl;
procedure zlibFreeMem(AppData, Block: Pointer); cdecl;

//compress stream; tries to use direct memory access on input stream
  //adapted from "Enhanced zlib implementation"
  //by Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>

//Note that unlike other things in this unit, you specify things with number
//values.  This is deliberate on my part because some things in Indy rely on
//API's where you specify the ZLib parameter as a number.  This is for the
//utmost flexibility.  In the FTP server, you can actually specify something
//like a compression level.
//The WinBits parameter is extremely powerful so do not underestimate it.
procedure CompressStream(InStream, OutStream: TStream;
  const level: Integer = Z_DEFAULT_COMPRESSION;
  const WinBits : Integer = MAX_WBITS;
  const MemLevel : Integer = MAX_MEM_LEVEL;
  const Stratagy : Integer = Z_DEFAULT_STRATEGY);
procedure DecompressStream(InStream, OutStream: TStream); overload;
//this is for where we know what the stream's WindowBits setting should be
//Note that this does have special handling for ZLIB values greater than
//32.  I'm trying to treat it as the inflateInit2_ call would.  I don't think
//InflateBack uses values greater than 16 so you have to make a workaround.
procedure DecompressStream(InStream, OutStream: TStream;
  const AWindowBits : Integer); overload;
// Direct ZLib access

// deflate compresses data
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar;
  recsize: Integer): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
function deflate(var strm: TZStreamRec; flush: Integer): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
function deflateEnd(var strm: TZStreamRec): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
// inflate decompresses data
function inflateInit_(var strm: TZStreamRec; version: PChar;
  recsize: Integer): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
function inflate(var strm: TZStreamRec; flush: Integer): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
function inflateEnd(var strm: TZStreamRec): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
function inflateReset(var strm: TZStreamRec): Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{JPM Additions, note that I start with the pasted C++ definition followed by any
documentation, and then the Pascal definition.

{ int deflateInit2 (z_streamp strm, int level, int method, int windowBits,
 int memLevel, int strategy);

This is another version of deflateInit with more compression options. The
fields next_in, zalloc, zfree and opaque must be initialized before by the
caller.

The method parameter is the compression method. It must be Z_DEFLATED in this
version of the library.

The windowBits parameter is the base two logarithm of the window size (the size
of the history buffer). It should be in the range 8..15 for this version of the
library. Larger values of this parameter result in better compression at the
expense of memory usage. The default value is 15 if deflateInit is used instead.

The memLevel parameter specifies how much memory should be allocated for the
internal compression state. memLevel=1 uses minimum memory but is slow and
reduces compression ratio ; memLevel=9 uses maximum memory for optimal speed.
The default value is 8. See zconf.h for total memory usage as a function of
windowBits and memLevel.

The strategy parameter is used to tune the compression algorithm. Use the value
Z_DEFAULT_STRATEGY for normal data, Z_FILTERED for data produced by a filter
(or predictor), or Z_HUFFMAN_ONLY to force Huffman encoding only (no string
match). Filtered data consists mostly of small values with a somewhat random
distribution. In this case, the compression algorithm is tuned to compress them
better. The effect of Z_FILTERED is to force more Huffman coding and less string
matching ; it is somewhat intermediate between Z_DEFAULT and Z_HUFFMAN_ONLY. The
strategy parameter only affects the compression ratio but not the correctness of
the compressed output even if it is not set appropriately.

deflateInit2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
memory, Z_STREAM_ERROR if a parameter is invalid (such as an invalid method).
msg is set to null if there is no error message. deflateInit2 does not perform
any compression: this will be done by deflate().
}
function deflateInit2_(var strm: TZStreamRec; level : Integer; method : Integer;
  windowBits : Integer; memLevel : Integer; strategy : Integer; version: PChar;
  recsize: Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{int deflateSetDictionary (z_streamp strm, const Bytef *dictionary,
  uInt dictLength);

Initializes the compression dictionary from the given byte sequence without
producing any compressed output. This function must be called immediately after
deflateInit, deflateInit2 or deflateReset, before any call of deflate. The
compressor and decompressor must use exactly the same dictionary (see
inflateSetDictionary).

The dictionary should consist of strings (byte sequences) that are likely to be
encountered later in the data to be compressed, with the most commonly used
strings preferably put towards the end of the dictionary. Using a dictionary is
most useful when the data to be compressed is short and can be predicted with
good accuracy ; the data can then be compressed better than with the default
empty dictionary.

Depending on the size of the compression data structures selected by deflateInit
or deflateInit2, a part of the dictionary may in effect be discarded, for
example if the dictionary is larger than the window size in deflate or deflate2.
Thus the strings most likely to be useful should be put at the end of the
dictionary, not at the front.

Upon return of this function, strm-> adler is set to the Adler32 value of the
dictionary ; the decompressor may later use this value to determine which
dictionary has been used by the compressor. (The Adler32 value applies to the
whole dictionary even if only a subset of the dictionary is actually used by the
compressor.)

deflateSetDictionary returns Z_OK if success, or Z_STREAM_ERROR if a parameter
is invalid (such as NULL dictionary) or the stream state is inconsistent (for
example if deflate has already been called for this stream or if the compression
method is bsort). deflateSetDictionary does not perform any compression: this
will be done by deflate().
}
function deflateSetDictionary (var strm: TZStreamRec; const dictionary : PChar;
  dictLength : Cardinal) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ int deflateCopy (z_streamp dest, z_streamp source);

Sets the destination stream as a complete copy of the source stream.

This function can be useful when several compression strategies will be tried,
for example when there are several ways of pre-processing the input data with a
filter. The streams that will be discarded should then be freed by calling
deflateEnd. Note that deflateCopy duplicates the internal compression state
which can be quite large, so this strategy is slow and can consume lots of
memory.

deflateCopy returns Z_OK if success, Z_MEM_ERROR if there was not enough memory,
Z_STREAM_ERROR if the source stream state was inconsistent (such as zalloc being
NULL). msg is left unchanged in both source and destination.
}
function deflateCopy (var dest : TZStreamRec; var source : TZStreamRec)
 : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{int deflateReset (z_streamp strm);

This function is equivalent to deflateEnd followed by deflateInit, but does not
free and reallocate all the internal compression state. The stream will keep the
same compression level and any other attributes that may have been set by
deflateInit2.

deflateReset returns Z_OK if success, or Z_STREAM_ERROR if the source stream
state was inconsistent (such as zalloc or state being NULL).
}
function deflateReset (var strm : TZStreamRec) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{int deflateParams (z_streamp strm, int level, int strategy);

Dynamically update the compression level and compression strategy. The
interpretation of level and strategy is as in deflateInit2. This can be used to
switch between compression and straight copy of the input data, or to switch to
a different kind of input data requiring a different strategy. If the
compression level is changed, the input available so far is compressed with the
old level (and may be flushed); the new level will take effect only at the next
call of deflate().

Before the call of deflateParams, the stream state must be set as for a call of
deflate(), since the currently available input may have to be compressed and
flushed. In particular, strm-> avail_out must be non-zero.

deflateParams returns Z_OK if success, Z_STREAM_ERROR if the source stream state
was inconsistent or if a parameter was invalid, Z_BUF_ERROR if strm-&gtavail_out
was zero.
}
function deflateParams (var strm : TZStreamRec; level : Integer;
  strategy : Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT deflateTune OF((z_streamp strm,
                                    int good_length,
                                    int max_lazy,
                                    int nice_length,
                                    int max_chain));

/*
     Fine tune deflate's internal compression parameters.  This should only be
   used by someone who understands the algorithm used by zlib's deflate for
   searching for the best matching string, and even then only by the most
   fanatic optimizer trying to squeeze out the last compressed bit for their
   specific input data.  Read the deflate.c source code for the meaning of the
   max_lazy, good_length, nice_length, and max_chain parameters.

     deflateTune() can be called after deflateInit() or deflateInit2(), and
   returns Z_OK on success, or Z_STREAM_ERROR for an invalid deflate stream.
 */
}
function deflateTune(var strm : TZStreamRec; good_length : Integer;
  max_lazy : Integer; nice_length : Integer; max_chain : Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN uLong ZEXPORT deflateBound OF((z_streamp strm,
                                       uLong sourceLen));

/*
     deflateBound() returns an upper bound on the compressed size after
   deflation of sourceLen bytes.  It must be called after deflateInit()
   or deflateInit2().  This would be used to allocate an output buffer
   for deflation in a single pass, and so would be called before deflate().
*/
}
function deflateBound(var strm : TZStreamRec; sourceLen : Cardinal) : Cardinal;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN int ZEXPORT deflatePrime OF((z_streamp strm,
                                     int bits,
                                     int value));
/*
     deflatePrime() inserts bits in the deflate output stream.  The intent
  is that this function is used to start off the deflate output with the
  bits leftover from a previous deflate stream when appending to it.  As such,
  this function can only be used for raw deflate, and must be used before the
  first deflate() call after a deflateInit2() or deflateReset().  bits must be
  less than or equal to 16, and that many of the least significant bits of
  value will be inserted in the output.

      deflatePrime returns Z_OK if success, or Z_STREAM_ERROR if the source
   stream state was inconsistent.
*/
}
function deflatePrime(var strm : TZStreamRec; bits : Integer; value : Integer)
  : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN int ZEXPORT deflateSetHeader OF((z_streamp strm,
                                         gz_headerp head));
/*
      deflateSetHeader() provides gzip header information for when a gzip
   stream is requested by deflateInit2().  deflateSetHeader() may be called
   after deflateInit2() or deflateReset() and before the first call of
   deflate().  The text, time, os, extra field, name, and comment information
   in the provided gz_header structure are written to the gzip header (xflag is
   ignored -- the extra flags are set according to the compression level).  The
   caller must assure that, if not Z_NULL, name and comment are terminated with
   a zero byte, and that if extra is not Z_NULL, that extra_len bytes are
   available there.  If hcrc is true, a gzip header crc is included.  Note that
   the current versions of the command-line version of gzip (up through version
   1.3.x) do not support header crc's, and will report that it is a "multi-part
   gzip file" and give up.

      If deflateSetHeader is not used, the default gzip header has text false,
   the time set to zero, and os set to 255, with no extra, name, or comment
   fields.  The gzip header is returned to the default state by deflateReset().

      deflateSetHeader returns Z_OK if success, or Z_STREAM_ERROR if the source
   stream state was inconsistent.
*/

}
function deflateSetHeader(var strm : TZStreamRec; var head : TgzHeaderRec) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}

{int inflateInit2 (z_streamp strm, int windowBits);

This is another version of inflateInit with an extra parameter. The fields
next_in, avail_in, zalloc, zfree and opaque must be initialized before by the
caller.

The windowBits parameter is the base two logarithm of the maximum window size
(the size of the history buffer). It should be in the range 8..15 for this
version of the library. The default value is 15 if inflateInit is used instead.
If a compressed stream with a larger window size is given as input, inflate()
will return with the error code Z_DATA_ERROR instead of trying to allocate a
larger window.

inflateInit2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
memory, Z_STREAM_ERROR if a parameter is invalid (such as a negative memLevel).
msg is set to null if there is no error message. inflateInit2 does not perform
any decompression apart from reading the zlib header if present: this will be
done by inflate(). (So next_in and avail_in may be modified, but next_out and
avail_out are unchanged.)
}

function inflateInit2_(var strm : TZStreamRec; windowBits : Integer;
  version: PChar; recsize: Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
int inflateSetDictionary (z_streamp strm, const Bytef *dictionary,
uInt dictLength);

Initializes the decompression dictionary from the given uncompressed byte
sequence. This function must be called immediately after a call of inflate
if this call returned Z_NEED_DICT. The dictionary chosen by the compressor can
be determined from the Adler32 value returned by this call of inflate. The
compressor and decompressor must use exactly the same dictionary
(see deflateSetDictionary).

inflateSetDictionary returns Z_OK if success, Z_STREAM_ERROR if a parameter is
invalid (such as NULL dictionary) or the stream state is inconsistent,
Z_DATA_ERROR if the given dictionary doesn't match the expected one
(incorrect Adler32 value). inflateSetDictionary does not perform any
decompression: this will be done by subsequent calls of inflate().
}
function inflateSetDictionary (var strm : TZStreamRec; const dictionary : PChar;
  dictLength : Cardinal) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
int inflateSync (z_streamp strm); 
Skips invalid compressed data until a full flush point (see above the
description of deflate with Z_FULL_FLUSH) can be found, or until all available
input is skipped. No output is provided.

inflateSync returns Z_OK if a full flush point has been found, Z_BUF_ERROR if no
more input was provided, Z_DATA_ERROR if no flush point has been found, or
Z_STREAM_ERROR if the stream structure was inconsistent. In the success case,
the application may save the current current value of total_in which indicates
where valid compressed data was found. In the error case, the application may
repeatedly call inflateSync, providing more input each time, until success or
end of the input data.
}
function inflateSync (var strm : TZStreamRec) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN int ZEXPORT inflateCopy OF((z_streamp dest,
                                    z_streamp source));
/*
     Sets the destination stream as a complete copy of the source stream.

     This function can be useful when randomly accessing a large stream.  The
   first pass through the stream can periodically record the inflate state,
   allowing restarting inflate at those points when randomly accessing the
   stream.

     inflateCopy returns Z_OK if success, Z_MEM_ERROR if there was not
   enough memory, Z_STREAM_ERROR if the source stream state was inconsistent
   (such as zalloc being NULL). msg is left unchanged in both source and
   destination.
*/
}
function inflateCopy (var dest : TZStreamRec; var source : TZStreamRec)
  : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT inflatePrime OF((z_streamp strm,
                                     int bits,
                                     int value));
/*
     This function inserts bits in the inflate input stream.  The intent is
  that this function is used to start inflating at a bit position in the
  middle of a byte.  The provided bits will be used before any bytes are used
  from next_in.  This function should only be used with raw inflate, and
  should be used before the first inflate() call after inflateInit2() or
  inflateReset().  bits must be less than or equal to 16, and that many of the
  least significant bits of value will be inserted in the input.

      inflatePrime returns Z_OK if success, or Z_STREAM_ERROR if the source
   stream state was inconsistent.
*/
}
function inflatePrime (var strm : TZStreamRec; bits : Integer; value : Integer)
  : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT inflateGetHeader OF((z_streamp strm,
                                         gz_headerp head));
/*
      inflateGetHeader() requests that gzip header information be stored in the
   provided gz_header structure.  inflateGetHeader() may be called after
   inflateInit2() or inflateReset(), and before the first call of inflate().
   As inflate() processes the gzip stream, head->done is zero until the header
   is completed, at which time head->done is set to one.  If a zlib stream is
   being decoded, then head->done is set to -1 to indicate that there will be
   no gzip header information forthcoming.  Note that Z_BLOCK can be used to
   force inflate() to return immediately after header processing is complete
   and before any actual data is decompressed.

      The text, time, xflags, and os fields are filled in with the gzip header
   contents.  hcrc is set to true if there is a header CRC.  (The header CRC
   was valid if done is set to one.)  If extra is not Z_NULL, then extra_max
   contains the maximum number of bytes to write to extra.  Once done is true,
   extra_len contains the actual extra field length, and extra contains the
   extra field, or that field truncated if extra_max is less than extra_len.
   If name is not Z_NULL, then up to name_max characters are written there,
   terminated with a zero unless the length is greater than name_max.  If
   comment is not Z_NULL, then up to comm_max characters are written there,
   terminated with a zero unless the length is greater than comm_max.  When
   any of extra, name, or comment are not Z_NULL and the respective field is
   not present in the header, then that field is set to Z_NULL to signal its
   absence.  This allows the use of deflateSetHeader() with the returned
   structure to duplicate the header.  However if those fields are set to
   allocated memory, then the application will need to save those pointers
   elsewhere so that they can be eventually freed.

      If inflateGetHeader is not used, then the header information is simply
   discarded.  The header is always checked for validity, including the header
   CRC if present.  inflateReset() will reset the process to discard the header
   information.  The application would need to call inflateGetHeader() again to
   retrieve the header from the next gzip stream.

      inflateGetHeader returns Z_OK if success, or Z_STREAM_ERROR if the source
   stream state was inconsistent.
*/

}
function inflateGetHeader (var strm : TZStreamRec; var head : TgzHeaderRec)
 : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{/*
ZEXTERN int ZEXPORT inflateBackInit OF((z_streamp strm, int windowBits,
                                        unsigned char FAR *window));

     Initialize the internal stream state for decompression using inflateBack()
   calls.  The fields zalloc, zfree and opaque in strm must be initialized
   before the call.  If zalloc and zfree are Z_NULL, then the default library-
   derived memory allocation routines are used.  windowBits is the base two
   logarithm of the window size, in the range 8..15.  window is a caller
   supplied buffer of that size.  Except for special applications where it is
   assured that deflate was used with small window sizes, windowBits must be 15
   and a 32K byte window must be supplied to be able to decompress general
   deflate streams.

     See inflateBack() for the usage of these routines.

     inflateBackInit will return Z_OK on success, Z_STREAM_ERROR if any of
   the paramaters are invalid, Z_MEM_ERROR if the internal state could not
   be allocated, or Z_VERSION_ERROR if the version of the library does not
   match the version of the header file.
*/ }
function inflateBackInit_(var strm : TZStreamRec; windowBits : Integer;
  window : PChar; version: PChar; recsize: Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT inflateBack OF((z_streamp strm,
                                    in_func in, void FAR *in_desc,
                                    out_func out, void FAR *out_desc));
/*
     inflateBack() does a raw inflate with a single call using a call-back
   interface for input and output.  This is more efficient than inflate() for
   file i/o applications in that it avoids copying between the output and the
   sliding window by simply making the window itself the output buffer.  This
   function trusts the application to not change the output buffer passed by
   the output function, at least until inflateBack() returns.

     inflateBackInit() must be called first to allocate the internal state
   and to initialize the state with the user-provided window buffer.
   inflateBack() may then be used multiple times to inflate a complete, raw
   deflate stream with each call.  inflateBackEnd() is then called to free
   the allocated state.

     A raw deflate stream is one with no zlib or gzip header or trailer.
   This routine would normally be used in a utility that reads zip or gzip
   files and writes out uncompressed files.  The utility would decode the
   header and process the trailer on its own, hence this routine expects
   only the raw deflate stream to decompress.  This is different from the
   normal behavior of inflate(), which expects either a zlib or gzip header and
   trailer around the deflate stream.

     inflateBack() uses two subroutines supplied by the caller that are then
   called by inflateBack() for input and output.  inflateBack() calls those
   routines until it reads a complete deflate stream and writes out all of the
   uncompressed data, or until it encounters an error.  The function's
   parameters and return types are defined above in the in_func and out_func
   typedefs.  inflateBack() will call in(in_desc, &buf) which should return the
   number of bytes of provided input, and a pointer to that input in buf.  If
   there is no input available, in() must return zero--buf is ignored in that
   case--and inflateBack() will return a buffer error.  inflateBack() will call
   out(out_desc, buf, len) to write the uncompressed data buf[0..len-1].  out()
   should return zero on success, or non-zero on failure.  If out() returns
   non-zero, inflateBack() will return with an error.  Neither in() nor out()
   are permitted to change the contents of the window provided to
   inflateBackInit(), which is also the buffer that out() uses to write from.
   The length written by out() will be at most the window size.  Any non-zero
   amount of input may be provided by in().

     For convenience, inflateBack() can be provided input on the first call by
   setting strm->next_in and strm->avail_in.  If that input is exhausted, then
   in() will be called.  Therefore strm->next_in must be initialized before
   calling inflateBack().  If strm->next_in is Z_NULL, then in() will be called
   immediately for input.  If strm->next_in is not Z_NULL, then strm->avail_in
   must also be initialized, and then if strm->avail_in is not zero, input will
   initially be taken from strm->next_in[0 .. strm->avail_in - 1].

     The in_desc and out_desc parameters of inflateBack() is passed as the
   first parameter of in() and out() respectively when they are called.  These
   descriptors can be optionally used to pass any information that the caller-
   supplied in() and out() functions need to do their job.

     On return, inflateBack() will set strm->next_in and strm->avail_in to
   pass back any unused input that was provided by the last in() call.  The
   return values of inflateBack() can be Z_STREAM_END on success, Z_BUF_ERROR
   if in() or out() returned an error, Z_DATA_ERROR if there was a format
   error in the deflate stream (in which case strm->msg is set to indicate the
   nature of the error), or Z_STREAM_ERROR if the stream was not properly
   initialized.  In the case of Z_BUF_ERROR, an input or output error can be
   distinguished using strm->next_in which will be Z_NULL only if in() returned
   an error.  If strm->next is not Z_NULL, then the Z_BUF_ERROR was due to
   out() returning non-zero.  (in() will always be called before out(), so
   strm->next_in is assured to be defined if out() returns non-zero.)  Note
   that inflateBack() cannot return Z_OK.
*/

}
//note that you can't use in and out as parameter names
function inflateBack(var strm : TZStreamRec;
  in_fn : TInFunc; in_desc : Pointer;
  fn_out : TOutFunc; out_desc : Pointer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT inflateBackEnd OF((z_streamp strm));
/*
     All memory allocated by inflateBackInit() is freed.

     inflateBackEnd() returns Z_OK on success, or Z_STREAM_ERROR if the stream
   state was inconsistent.
*/
}
function inflateBackEnd (var strm : TZStreamRec) : Integer; 
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN uLong ZEXPORT zlibCompileFlags OF((void));
/* Return flags indicating compile-time options.

    Type sizes, two bits each, 00 = 16 bits, 01 = 32, 10 = 64, 11 = other:
     1.0: size of uInt
     3.2: size of uLong
     5.4: size of voidpf (pointer)
     7.6: size of z_off_t

    Compiler, assembler, and debug options:
     8: DEBUG
     9: ASMV or ASMINF -- use ASM code
     10: ZLIB_WINAPI -- exported functions use the WINAPI calling convention
     11: 0 (reserved)

    One-time table building (smaller code, but not thread-safe if true):
     12: BUILDFIXED -- build static block decoding tables when needed
     13: DYNAMIC_CRC_TABLE -- build CRC calculation tables when needed
     14,15: 0 (reserved)

    Library content (indicates missing functionality):
     16: NO_GZCOMPRESS -- gz* functions cannot compress (to avoid linking
                          deflate code when not needed)
     17: NO_GZIP -- deflate can't write gzip streams, and inflate can't detect
                    and decode gzip streams (to avoid linking crc code)
     18-19: 0 (reserved)

    Operation variations (changes in library functionality):
     20: PKZIP_BUG_WORKAROUND -- slightly more permissive inflate
     21: FASTEST -- deflate algorithm with only one, lowest compression level
     22,23: 0 (reserved)

    The sprintf variant used by gzprintf (zero is best):
     24: 0 = vs*, 1 = s* -- 1 means limited to 20 arguments after the format
     25: 0 = *nprintf, 1 = *printf -- 1 means gzprintf() not secure!
     26: 0 = returns value, 1 = void -- 1 means inferred string length returned

    Remainder:
     27-31: 0 (reserved)
 */
}
function zlibCompileFlags : Cardinal;
{$IFDEF LINUX} cdecl; {$ENDIF}
//const char * zError (int err);

function  zError (err : Integer) : PChar;
{$IFDEF LINUX} cdecl; {$ENDIF}
//int inflateSyncPoint (z_streamp z);

function inflateSyncPoint(var z : TZStreamRec) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
//const uLongf * get_crc_table (void);

function  get_crc_table : PLongInt;
{$IFDEF LINUX} cdecl; {$ENDIF}

{/*
     The following utility functions are implemented on top of the
   basic stream-oriented functions. To simplify the interface, some
   default options are assumed (compression level and memory usage,
   standard memory allocation functions). The source code of these
   utility functions can easily be modified if you need special options.
*/

ZEXTERN int ZEXPORT compress OF((Bytef *dest,   uLongf *destLen,
                                 const Bytef *source, uLong sourceLen));
/*
     Compresses the source buffer into the destination buffer.  sourceLen is
   the byte length of the source buffer. Upon entry, destLen is the total
   size of the destination buffer, which must be at least the value returned
   by compressBound(sourceLen). Upon exit, destLen is the actual size of the
   compressed buffer.
     This function can be used to compress a whole file at once if the
   input file is mmap'ed.
     compress returns Z_OK if success, Z_MEM_ERROR if there was not
   enough memory, Z_BUF_ERROR if there was not enough room in the output
   buffer.
*/
}

function compress (dest : PChar;  var destLen : Cardinal;
  const source : PChar; sourceLen : Cardinal) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT compress2 OF((Bytef *dest,   uLongf *destLen,
                                  const Bytef *source, uLong sourceLen,
                                  int level));
/*
     Compresses the source buffer into the destination buffer. The level
   parameter has the same meaning as in deflateInit.  sourceLen is the byte
   length of the source buffer. Upon entry, destLen is the total size of the
   destination buffer, which must be at least the value returned by
   compressBound(sourceLen). Upon exit, destLen is the actual size of the
   compressed buffer.

     compress2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
   memory, Z_BUF_ERROR if there was not enough room in the output buffer,
   Z_STREAM_ERROR if the level parameter is invalid.
*/
}
function compress2(dest : PChar; var destLen : Cardinal;
  const source : PChar;  sourceLen : Cardinal;
  level : Integer) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN uLong ZEXPORT compressBound OF((uLong sourceLen));
/*
     compressBound() returns an upper bound on the compressed size after
   compress() or compress2() on sourceLen bytes.  It would be used before
   a compress() or compress2() call to allocate the destination buffer.
*/ }
function compressBound ( sourceLen : Cardinal) : Cardinal;
{$IFDEF LINUX} cdecl; {$ENDIF}
{ZEXTERN int ZEXPORT uncompress OF((Bytef *dest,   uLongf *destLen,
                                   const Bytef *source, uLong sourceLen));
/*
     Decompresses the source buffer into the destination buffer.  sourceLen is
   the byte length of the source buffer. Upon entry, destLen is the total
   size of the destination buffer, which must be large enough to hold the
   entire uncompressed data. (The size of the uncompressed data must have
   been saved previously by the compressor and transmitted to the decompressor
   by some mechanism outside the scope of this compression library.)
   Upon exit, destLen is the actual size of the compressed buffer.
     This function can be used to decompress a whole file at once if the
   input file is mmap'ed.

     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not
   enough memory, Z_BUF_ERROR if there was not enough room in the output
   buffer, or Z_DATA_ERROR if the input data was corrupted or incomplete.
*/

}
function uncompress(dest : PChar; var destLen : Cardinal;
  const source : PChar; sourceLen : Cardinal) : Integer;
{$IFDEF LINUX} cdecl; {$ENDIF}
{                        /* checksum functions */

/*
     These functions are not related to compression but are exported
   anyway because they might be useful in applications using the
   compression library.
*/

ZEXTERN uLong ZEXPORT adler32 OF((uLong adler, const Bytef *buf, uInt len));
/*
     Update a running Adler-32 checksum with the bytes buf[0..len-1] and
   return the updated checksum. If buf is NULL, this function returns
   the required initial value for the checksum.
   An Adler-32 checksum is almost as reliable as a CRC32 but can be computed
   much faster. Usage example:

     uLong adler = adler32(0L, Z_NULL, 0);

     while (read_buffer(buffer, length) != EOF) {
       adler = adler32(adler, buffer, length);
     } {
     if (adler != original_adler) error();
*/
}
function adler32 (adler : Cardinal; const buf : PChar; len : Cardinal)
  : Cardinal;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN uLong ZEXPORT adler32_combine OF((uLong adler1, uLong adler2,
                                          z_off_t len2));
/*
     Combine two Adler-32 checksums into one.  For two sequences of bytes, seq1
   and seq2 with lengths len1 and len2, Adler-32 checksums were calculated for
   each, adler1 and adler2.  adler32_combine() returns the Adler-32 checksum of
   seq1 and seq2 concatenated, requiring only adler1, adler2, and len2.
*/
}
function  adler32_combine(adler1 : Cardinal;  adler2 : Cardinal;
   len2 : LongInt) : Cardinal;
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN uLong ZEXPORT crc32   OF((uLong crc, const Bytef *buf, uInt len));
/*
     Update a running CRC-32 with the bytes buf[0..len-1] and return the
   updated CRC-32. If buf is NULL, this function returns the required initial
   value for the for the crc. Pre- and post-conditioning (one's complement) is
   performed within this function so it shouldn't be done by the application.
   Usage example:

     uLong crc = crc32(0L, Z_NULL, 0);

     while (read_buffer(buffer, length) != EOF) {
       crc = crc32(crc, buffer, length);
     }
    { if (crc != original_crc) error();
*/
}
function crc32 (crc : Cardinal; const buf : PChar; len : Cardinal) : Cardinal; 
{$IFDEF LINUX} cdecl; {$ENDIF}
{
ZEXTERN uLong ZEXPORT crc32_combine OF((uLong crc1, uLong crc2, z_off_t len2));

/*
     Combine two CRC-32 check values into one.  For two sequences of bytes,
   seq1 and seq2 with lengths len1 and len2, CRC-32 check values were
   calculated for each, crc1 and crc2.  crc32_combine() returns the CRC-32
   check value of seq1 and seq2 concatenated, requiring only crc1, crc2, and
   len2.
*/
}

implementation
uses IdZLibConst;
{$L adler32.obj}
{$L compress.obj}
{$L crc32.obj}
{$L deflate.obj}
{$L infback.obj}
{$L inffast.obj}
{$L inflate.obj}
{$L inftrees.obj}
{$L trees.obj}
{$L uncompr.obj}
{$L zutil.obj}

{$IFDEF LINUX}
const
  zlibso = 'libz.so.1';
{$ENDIF}

// deflate compresses data
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar;
  recsize: Integer): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateInit_';
{$ENDIF}

function deflate(var strm: TZStreamRec; flush: Integer): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflate';
{$ENDIF}

function deflateEnd(var strm: TZStreamRec): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateEnd';
{$ENDIF}

// inflate decompresses data
function inflateInit_(var strm: TZStreamRec; version: PChar;
  recsize: Integer): Integer; 
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateInit_';
{$ENDIF}

function inflate(var strm: TZStreamRec; flush: Integer): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflate';
{$ENDIF}

function inflateEnd(var strm: TZStreamRec): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateEnd';
{$ENDIF}

function inflateReset(var strm: TZStreamRec): Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateReset';
{$ENDIF}

function deflateInit2_(var strm: TZStreamRec; level : Integer; method : Integer;
  windowBits : Integer; memLevel : Integer; strategy : Integer; version: PChar;
  recsize: Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateInit2_';
{$ENDIF}

function deflateSetDictionary (var strm: TZStreamRec; const dictionary : PChar;
  dictLength : Cardinal) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateSetDictionary';
{$ENDIF}

function deflateCopy (var dest : TZStreamRec; var source : TZStreamRec)
 : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateCopyy';
{$ENDIF}

function deflateReset (var strm : TZStreamRec) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateReset';
{$ENDIF}

function deflateParams (var strm : TZStreamRec; level : Integer;
  strategy : Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateParams';
{$ENDIF}

function deflateTune(var strm : TZStreamRec; good_length : Integer;
  max_lazy : Integer; nice_length : Integer; max_chain : Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateTune';
{$ENDIF}

function deflateBound(var strm : TZStreamRec; sourceLen : Cardinal) : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateBound';
{$ENDIF}

function deflatePrime(var strm : TZStreamRec; bits : Integer; value : Integer)
  : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflatePrime';
{$ENDIF}

function deflateSetHeader(var strm : TZStreamRec; var head : TgzHeaderRec)
  : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'deflateSetHeader';
{$ENDIF}

function inflateInit2_(var strm : TZStreamRec; windowBits : Integer;
  version: PChar; recsize: Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateInit2_';
{$ENDIF}

function inflateSetDictionary (var strm : TZStreamRec; const dictionary : PChar;
  dictLength : Cardinal) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateSetDictionary';
{$ENDIF}

function inflateSync (var strm : TZStreamRec) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateSync';
{$ENDIF}

function inflateCopy (var dest : TZStreamRec; var source : TZStreamRec)
  : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateCopy';
{$ENDIF}

function inflatePrime (var strm : TZStreamRec; bits : Integer; value : Integer)
  : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflatePrime';
{$ENDIF}

function inflateGetHeader (var strm : TZStreamRec; var head : TgzHeaderRec)
 : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateGetHeader';
{$ENDIF}

function inflateBackInit_(var strm : TZStreamRec; windowBits : Integer;
  window : PChar; version: PChar; recsize: Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateBackInit_';
{$ENDIF}

function inflateBack(var strm : TZStreamRec;
  in_fn : TInFunc; in_desc : Pointer;
  fn_out : TOutFunc; out_desc : Pointer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateBack';
{$ENDIF}

function inflateBackEnd (var strm : TZStreamRec) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateBack';
{$ENDIF}

function zlibCompileFlags : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'zlibCompileFlags';
{$ENDIF}

function  zError (err : Integer) : PChar;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'zError';
{$ENDIF}

function inflateSyncPoint(var z : TZStreamRec) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'inflateSyncPoint';
{$ENDIF}

function  get_crc_table : PLongInt;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'get_crc_table';
{$ENDIF}

function compress (dest : PChar;  var destLen : Cardinal;
  const source : PChar; sourceLen : Cardinal) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'compress';
{$ENDIF}

function compress2(dest : PChar; var destLen : Cardinal;
  const source : PChar;  sourceLen : Cardinal;
  level : Integer) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'compress2';
{$ENDIF}

function compressBound ( sourceLen : Cardinal) : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'compressBound';
{$ENDIF}

function uncompress(dest : PChar; var destLen : Cardinal;
  const source : PChar; sourceLen : Cardinal) : Integer;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'uncompress';
{$ENDIF}

function adler32 (adler : Cardinal; const buf : PChar; len : Cardinal) : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'adler32';
{$ENDIF}

function  adler32_combine(adler1 : Cardinal;  adler2 : Cardinal;
   len2 : LongInt) : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'adler32_combine';
{$ENDIF}

function crc32 (crc : Cardinal; const buf : PChar; len : Cardinal) : Cardinal;
{$IFDEF MSWINDOWS}
  external;
{$ENDIF}
{$IFDEF LINUX}
  cdecl; external zlibso name 'crc32';
{$ENDIF}

function _malloc(Size: Integer): Pointer; cdecl;
begin
  Result := AllocMem(Size);
end;

procedure _free(Block: Pointer); cdecl;
begin
  FreeMem(Block);
end;

procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl;
begin
  FillChar(P^, count, B);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function zlibAllocMem(AppData: Pointer; Items, Size: Integer): Pointer; cdecl;
begin
//  GetMem(Result, Items*Size);
  Result := AllocMem(Items * Size);
end;

procedure zlibFreeMem(AppData, Block: Pointer); cdecl;
begin
  FreeMem(Block);
end;

{function zlibCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
    raise EZlibError.Create('error');    //!!
end;}

function CCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
  begin
    raise ECompressionError.CreateError(code);
  end;
//    raise ECompressionError.Create('error'); //!!
end;

function DCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
  begin
    raise EDecompressionError.CreateError(code);
 //   raise EDecompressionError.Create('error');  //!!
  end;
end;

procedure CompressBuf(const InBuf: Pointer; InBytes: Integer;
                      out OutBuf: Pointer; out OutBytes: Integer);
var
  strm: TZStreamRec;
  P: Pointer;
begin
  FillChar(strm, sizeof(strm), 0);
  strm.zalloc := zlibAllocMem;
  strm.zfree := zlibFreeMem;
  OutBytes := ((InBytes + (InBytes div 10) + 12) + 255) and not 255;
  GetMem(OutBuf, OutBytes);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := OutBytes;
    CCheck(deflateInit_(strm, Z_BEST_COMPRESSION, zlib_version, sizeof(strm)));
    try
      while CCheck(deflate(strm, Z_FINISH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, 256);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out := PChar(Integer(OutBuf) + (Integer(strm.next_out) - Integer(P)));
        strm.avail_out := 256;
      end;
    finally
      CCheck(deflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    OutBytes := strm.total_out;
  except
    FreeMem(OutBuf);
    raise
  end;
end;


procedure DecompressBuf(const InBuf: Pointer; InBytes: Integer;
  OutEstimate: Integer; out OutBuf: Pointer; out OutBytes: Integer);
var
  strm: TZStreamRec;
  P: Pointer;
  BufInc: Integer;
begin
  FillChar(strm, sizeof(strm), 0);
  strm.zalloc := zlibAllocMem;
  strm.zfree := zlibFreeMem;
  BufInc := (InBytes + 255) and not 255;
  if OutEstimate = 0 then
    OutBytes := BufInc
  else
    OutBytes := OutEstimate;
  GetMem(OutBuf, OutBytes);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := OutBytes;
    DCheck(inflateInit_(strm, zlib_version, sizeof(strm)));
    try
      while DCheck(inflate(strm, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, BufInc);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out := PChar(Integer(OutBuf) + (Integer(strm.next_out) - Integer(P)));
        strm.avail_out := BufInc;
      end;
    finally
      DCheck(inflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    OutBytes := strm.total_out;
  except
    FreeMem(OutBuf);
    raise
  end;
end;

procedure DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);
var
  strm: TZStreamRec;
begin
  FillChar(strm, sizeof(strm), 0);
  strm.zalloc := zlibAllocMem;
  strm.zfree := zlibFreeMem;
  strm.next_in := InBuf;
  strm.avail_in := InBytes;
  strm.next_out := OutBuf;
  strm.avail_out := BufSize;
  DCheck(inflateInit_(strm, zlib_version, sizeof(strm)));
  try
    if DCheck(inflate(strm, Z_FINISH)) <> Z_STREAM_END then
      raise EZlibError.CreateRes(@sTargetBufferTooSmall);
  finally
    DCheck(inflateEnd(strm));
  end;
end;

// TCustomZlibStream

constructor TCustomZLibStream.Create(Strm: TStream);
begin
  inherited Create;
  FStrm := Strm;
  FStrmPos := Strm.Position;
  FZRec.zalloc := zlibAllocMem;
  FZRec.zfree := zlibFreeMem;
end;

procedure TCustomZLibStream.Progress(Sender: TObject);
begin
  if Assigned(FOnProgress) then FOnProgress(Sender);
end;


// TCompressionStream

constructor TCompressionStream.Create(CompressionLevel: TCompressionLevel;
  Dest: TStream);
const
  Levels: array [TCompressionLevel] of ShortInt =
    (Z_NO_COMPRESSION, Z_BEST_SPEED, Z_DEFAULT_COMPRESSION, Z_BEST_COMPRESSION);
begin
  inherited Create(Dest);
  FZRec.next_out := FBuffer;
  FZRec.avail_out := sizeof(FBuffer);
  CCheck(deflateInit_(FZRec, Levels[CompressionLevel], zlib_version, sizeof(FZRec)));
end;

destructor TCompressionStream.Destroy;
begin
  FZRec.next_in := nil;
  FZRec.avail_in := 0;
  try
    if FStrm.Position <> FStrmPos then FStrm.Position := FStrmPos;
    while (CCheck(deflate(FZRec, Z_FINISH)) <> Z_STREAM_END)
      and (FZRec.avail_out = 0) do
    begin
      FStrm.WriteBuffer(FBuffer, sizeof(FBuffer));
      FZRec.next_out := FBuffer;
      FZRec.avail_out := sizeof(FBuffer);
    end;
    if FZRec.avail_out < sizeof(FBuffer) then
      FStrm.WriteBuffer(FBuffer, sizeof(FBuffer) - FZRec.avail_out);
  finally
    deflateEnd(FZRec);
  end;
  inherited Destroy;
end;

function TCompressionStream.Read(var Buffer; Count: Longint): Longint;
begin
  raise ECompressionError.CreateRes(@sInvalidStreamOp);
end;

function TCompressionStream.Write(const Buffer; Count: Longint): Longint;
begin
  FZRec.next_in := @Buffer;
  FZRec.avail_in := Count;
  if FStrm.Position <> FStrmPos then FStrm.Position := FStrmPos;
  while (FZRec.avail_in > 0) do
  begin
    CCheck(deflate(FZRec, 0));
    if FZRec.avail_out = 0 then
    begin
      FStrm.WriteBuffer(FBuffer, sizeof(FBuffer));
      FZRec.next_out := FBuffer;
      FZRec.avail_out := sizeof(FBuffer);
      FStrmPos := FStrm.Position;
      Progress(Self);
    end;
  end;
  Result := Count;
end;

function TCompressionStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  if (Offset = 0) and (Origin = soFromCurrent) then
    Result := FZRec.total_in
  else
    raise ECompressionError.CreateRes(@sInvalidStreamOp);
end;

function TCompressionStream.GetCompressionRate: Single;
begin
  if FZRec.total_in = 0 then
    Result := 0
  else
    Result := (1.0 - (FZRec.total_out / FZRec.total_in)) * 100.0;
end;


// TDecompressionStream

constructor TDecompressionStream.Create(Source: TStream);
begin
  inherited Create(Source);
  FZRec.next_in := FBuffer;
  FZRec.avail_in := 0;
  DCheck(inflateInit_(FZRec, zlib_version, sizeof(FZRec)));
end;

destructor TDecompressionStream.Destroy;
begin
  FStrm.Seek(-FZRec.avail_in, 1);
  inflateEnd(FZRec);
  inherited Destroy;
end;

function TDecompressionStream.Read(var Buffer; Count: Longint): Longint;
begin
  FZRec.next_out := @Buffer;
  FZRec.avail_out := Count;
  if FStrm.Position <> FStrmPos then FStrm.Position := FStrmPos;
  while (FZRec.avail_out > 0) do
  begin
    if FZRec.avail_in = 0 then
    begin
      FZRec.avail_in := FStrm.Read(FBuffer, sizeof(FBuffer));
      if FZRec.avail_in = 0 then
      begin
        Result := Count - FZRec.avail_out;
        Exit;
      end;
      FZRec.next_in := FBuffer;
      FStrmPos := FStrm.Position;
      Progress(Self);
    end;
    CCheck(inflate(FZRec, 0));
  end;
  Result := Count;
end;

function TDecompressionStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise EDecompressionError.CreateRes(@sInvalidStreamOp);
end;

function TDecompressionStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  I: Integer;
  Buf: array [0..4095] of Char;
begin
  if (Offset = 0) and (Origin = soFromBeginning) then
  begin
    DCheck(inflateReset(FZRec));
    FZRec.next_in := FBuffer;
    FZRec.avail_in := 0;
    FStrm.Position := 0;
    FStrmPos := 0;
  end
  else if ( (Offset >= 0) and (Origin = soFromCurrent)) or
          ( ((Offset - FZRec.total_out) > 0) and (Origin = soFromBeginning)) then
  begin
    if Origin = soFromBeginning then Dec(Offset, FZRec.total_out);
    if Offset > 0 then
    begin
      for I := 1 to Offset div sizeof(Buf) do
        ReadBuffer(Buf, sizeof(Buf));
      ReadBuffer(Buf, Offset mod sizeof(Buf));
    end;
  end
  else
    raise EDecompressionError.CreateRes(@sInvalidStreamOp);
  Result := FZRec.total_out;
end;


{ EZlibError }

constructor EZlibError.CreateError(const AError: Integer);
begin
  inherited Create( zError(AError) );
  FErrorCode := AError;
end;

//compress stream; tries to use direct memory access on input stream
  //adapted from "Enhanced zlib implementation"
  //by Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>

const WINBITARRAY : Array[0..2] of Integer = ( MAX_WBITS, GZIP_WINBITS, RAW_WBITS);



function DMAOfStream(AStream: TStream; out Available: integer): Pointer;
begin
  if AStream.inheritsFrom(TCustomMemoryStream) then
    Result := TCustomMemoryStream(AStream).Memory
  else if AStream.inheritsFrom(TStringStream) then
    Result := Pointer(TStringStream(AStream).DataString)
  else
    Result := nil;
  if Result <> nil then
  begin
    //what if integer overflow?
    Available := AStream.Size - AStream.Position;
    Inc(Integer(Result), AStream.Position);
  end
  else Available := 0;
end;

function CanResizeDMAStream(AStream: TStream): boolean;
begin
  Result := AStream.inheritsFrom(TMemoryStream) or
            AStream.inheritsFrom(TStringStream);
end;

//internal type for InflateBack function calls
const
  WindowSize = 1 shl MAX_WBITS;
  
type
  PZBack = ^TZBack;
  TZBack = record
    InStream  : TStream;
    OutStream : TStream;
    InMem     : PChar; //direct memory access
    InMemSize : integer;
    ReadBuf   : array[word] of char;
    Window    : array[0..WindowSize] of char;
  end;

//these are callback functions for InflateBack functions
function Strm_in_func(BackObj: PZBack; var buf: PByte): Integer; cdecl;
var
  S : TStream;

begin
  S := BackObj.InStream; //help optimizations
  if BackObj.InMem <> nil then
  begin
    //direct memory access if available!
    buf := Pointer(BackObj.InMem);
    //what if integer overflow?
    Result := S.Size - S.Position;
    S.Seek(Result, soFromCurrent);
  end
  else
  begin
    buf    := @BackObj.ReadBuf;
    Result := S.Read(buf^, SizeOf(BackObj.ReadBuf));
  end;
end;

function Strm_out_func(BackObj: PZBack; buf: PByte; size: Integer): Integer; cdecl;
begin
  Result := BackObj.OutStream.Write(buf^, size) - size;
end;

///tries to get the stream info
//strm.next_in and available_in needs enough data!
//strm should not contain an initialized inflate

function TryStreamType(var strm: TZStreamRec; gzheader: PgzHeaderRec; const AWinBitsValue : Integer): boolean;
var
  InitBuf: PChar;
  InitIn : integer;
begin
    InitBuf := strm.next_in;
    InitIn  := strm.avail_in;
  DCheck(inflateInit2_(strm, AWinBitsValue, zlib_version,SizeOf(TZStreamRec) ));

  if (AWinBitsValue = GZIP_WINBITS) and (gzheader <> nil) then
    DCheck(inflateGetHeader(strm, gzheader^));

  Result := inflate(strm, Z_BLOCK) = Z_OK;
  DCheck(inflateEnd(strm));

  if Result then
  begin
    exit;
  end;
      //rollback
      strm.next_in  := InitBuf;
      strm.avail_in := InitIn;
end;

function  CheckInitInflateStream(var strm: TZStreamRec; gzheader: PgzHeaderRec): Integer; overload;
var
  i : Integer;

begin
  if strm.next_out = nil then
    //needed for reading, but not used
    strm.next_out := strm.next_in;

  try

    for i := Low(WINBITARRAY) to High(WINBITARRAY) do
    begin
      Result := WINBITARRAY[0];
      if TryStreamType(strm,gzheader, Result) then
      begin
        exit;
      end;

    end;
    Result := -MAX_WBITS;
  finally
    
  end;
end;



procedure DecompressStream(InStream, OutStream: TStream);
var
  strm   : TZStreamRec;
  BackObj: PZBack;
begin
  FillChar(strm, sizeof(strm), 0);
  GetMem(BackObj, SizeOf(BackObj^));
  try
    //direct memory access if possible!
    BackObj.InMem := DMAOfStream(InStream, BackObj.InMemSize);

    BackObj.InStream  := InStream;
    BackObj.OutStream := OutStream;

    //use our own function for reading
    strm.avail_in := Strm_in_func(BackObj, PByte(strm.next_in));
    strm.next_out := @BackObj.Window;
    strm.avail_out := 0;

    CheckInitInflateStream(strm, nil);

    strm.next_out := nil;
    strm.avail_out := 0;
    DCheck(inflateBackInit_(strm, MAX_WBITS, BackObj.Window, zlib_version,SizeOf( TZStreamRec )));
    try
      DCheck(inflateBack(strm, @Strm_in_func, BackObj, @Strm_out_func, BackObj));
      //seek back when unused data
      InStream.Seek(-strm.avail_in, soFromCurrent);
      //now trailer can be checked
    finally
      DCheck(inflateBackEnd(strm));
    end;
  finally
    FreeMem(BackObj);
  end;
end;

procedure DecompressStream(InStream, OutStream: TStream;
  const AWindowBits : Integer);
var
  strm   : TZStreamRec;
  BackObj: PZBack;
  LWindowBits : Integer;
begin
  LWindowBits := AWindowBits;
  FillChar(strm, sizeof(strm), 0);
  GetMem(BackObj, SizeOf(BackObj^));
  try
    //direct memory access if possible!
    BackObj.InMem := DMAOfStream(InStream, BackObj.InMemSize);

    BackObj.InStream  := InStream;
    BackObj.OutStream := OutStream;

    //use our own function for reading
    strm.avail_in := Strm_in_func(BackObj, PByte(strm.next_in));
    strm.next_out := @BackObj.Window;
     strm.avail_out := 0;
    //note that you can not use a WinBits parameter greater than 32 with
    //InflateBackInit.  That was used in the inflate functions
    //for automatic detection of header bytes and trailer bytes.
    //Se lets try this ugly workaround for it.
    if AWindowBits > 32 then
    begin
      LWindowBits := Abs(AWindowBits - 32);

      if not TryStreamType(strm,nil,LWindowBits) then
      begin
        if TryStreamType(strm,nil,LWindowBits + 16) then
        begin
          LWindowBits := LWindowBits + 16;

        end
        else
        begin
          TryStreamType(strm,nil,-LWindowBits );

        end;
      end;
    end;
    strm.next_out := nil;
    strm.avail_out := 0;
    DCheck(inflateBackInit_(strm,LWindowBits, BackObj.Window,
      zlib_version,SizeOf( TZStreamRec )));
    try
      DCheck(inflateBack(strm, @Strm_in_func, BackObj, @Strm_out_func, BackObj));
      //seek back when unused data
      InStream.Seek(-strm.avail_in, soFromCurrent);
      //now trailer can be checked
    finally
      DCheck(inflateBackEnd(strm));
    end;
  finally
    FreeMem(BackObj);
  end;
end;

type
  TMemStreamHack = class(TMemoryStream);
function ExpandStream(AStream: TStream; const ACapacity : Int64): boolean;
begin
  Result := true;
  AStream.Size := ACapacity;
  if AStream.InheritsFrom(TMemoryStream) then
  begin
    AStream.Size := TMemStreamHack(AStream).Capacity;
  end;
end;

procedure CompressStream(InStream, OutStream: TStream;
  const level: Integer = Z_DEFAULT_COMPRESSION;
  const WinBits : Integer = MAX_WBITS;
  const MemLevel : Integer = MAX_MEM_LEVEL;
  const Stratagy : Integer = Z_DEFAULT_STRATEGY);

const
  //64 KB buffer
  BufSize = 65536;
var
  strm   : TZStreamRec;
  InBuf, OutBuf : PChar;
  UseInBuf, UseOutBuf : boolean;
  LastOutCount : integer;
  procedure WriteOut;
  begin
    if UseOutBuf then
    begin
      if LastOutCount > 0 then
      begin
        OutStream.Write(OutBuf^, LastOutCount - strm.avail_out);
      end;
      strm.avail_out := BufSize;
      strm.next_out  := OutBuf;
    end
    else
    begin
      if (strm.avail_out = 0) then
      begin
        ExpandStream(OutStream, OutStream.Size + BufSize);
      end;
      OutStream.Seek(LastOutCount - strm.avail_out, soFromCurrent);
      strm.next_out  := DMAOfStream(OutStream, strm.avail_out);
      //because we can't really know how much resize is increasing!
    end;
    LastOutCount := strm.avail_out;
  end;
var
  Finished : boolean;
begin
  FillChar(strm, sizeof(strm), 0);

  InBuf          := nil;
  OutBuf         := nil;
  LastOutCount   := 0;

  strm.next_in   := DMAOfStream(InStream, strm.avail_in);
  UseInBuf := strm.next_in = nil;

  if UseInBuf then
    GetMem(InBuf, BufSize);

  UseOutBuf := not ( CanResizeDMAStream(OutStream));
  if UseOutBuf then GetMem(OutBuf, BufSize);

  CCheck(deflateInit2_(strm, level, Z_DEFLATED, WinBits,MemLevel,Stratagy,zlib_version, SizeOf(TZStreamRec)));
  try
    repeat
      if strm.avail_in = 0 then
      begin
        if UseInBuf then
        begin
          strm.avail_in := InStream.Read(InBuf^, BufSize);
          strm.next_in  := InBuf;
        end;
        if strm.avail_in = 0 then break;
      end;
      if strm.avail_out = 0 then WriteOut;

      CCheck(deflate(strm, Z_NO_FLUSH));
    until false;

    repeat
      Finished := CCheck(deflate(strm, Z_FINISH)) = Z_STREAM_END;
      WriteOut;
    until Finished;

    if not UseOutBuf then
    begin
      //truncate when using direct output
      OutStream.Size := OutStream.Position;
    end;

    //adjust position of the input stream
    if UseInBuf then
      //seek back when unused data
      InStream.Seek(-strm.avail_in, soFromCurrent)
    else
      //simple seek
      InStream.Seek(strm.total_in, soFromCurrent);

    CCheck(deflateEnd(strm));
  finally
    if InBuf <> nil then FreeMem(InBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;

end;

end.
