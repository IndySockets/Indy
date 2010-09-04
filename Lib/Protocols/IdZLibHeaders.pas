unit IdZLibHeaders;

{
 zlibpas -- Pascal interface to the zlib data compression library
 * Gabriel Corneanu (gabrielcorneanu(AT)yahoo.com)
       Derived from original sources by Bob Dellaca and Cosmin Truta.
   - TZStreamType
   - deflateInitEx
   - inflateInitEx
*}
{
JPM - note that I made dynamic loading for FreePascal (since that still may not
suppport external .obj files properly.  It also makes it easier to support several
different platforms in one file.
}

interface

{$i IdCompilerDefines.inc}

{$WRITEABLECONST OFF}

{$UNDEF STATICLOAD_ZLIB}
{$IFDEF DCC}
  {$IFDEF WIN32}
{
For Delphi, we use some .obj files.  These .objs were compiled from the ZLib
source-code folder with "make -f contrib\delphi\zlibd32.mak" using Borland's
"make" and "bcc32".  The .objs are compiled with the
"-DZEXPORT=__fastcall -DZEXPORTVA=__cdecl"  parameter.  Do NOT change
the function calling conventions unless you know what you are doing and
the C++ objects are compiled appropriately.

The only things that still are cdecl are the callback functions.
}
    {$DEFINE STATICLOAD_ZLIB}
  	{$ALIGN OFF}
  {$ENDIF}
  {$IFDEF WIN64}
    {$ALIGN ON}
  {$ENDIF}
{$ELSE}
    {$packrecords C}
{$ENDIF}

uses
  //reference off_t
  {$IFDEF KYLIXCOMPAT}
   libc,
  {$ENDIF}

  {$IFDEF USE_VCL_POSIX}
  PosixSysTypes,
  {$ENDIF}
  {$IFDEF USE_BASEUNIX}
    baseunix,
  {$ENDIF}
  IdCTypes
  {$IFNDEF STATICLOAD_ZLIB}
  , IdException
  {$ENDIF};

const
  {$EXTERNALSYM ZLIB_VERSION}
  ZLIB_VERSION = '1.2.5';
  {$EXTERNALSYM ZLIB_VERNUM}
  ZLIB_VERNUM = $1250;
  {$EXTERNALSYM ZLIB_VER_MAJOR}
  ZLIB_VER_MAJOR = 1;
  {$EXTERNALSYM ZLIB_VER_MINOR}
  ZLIB_VER_MINOR = 2;
  {$EXTERNALSYM ZLIB_VER_REVISION}
  ZLIB_VER_REVISION = 5;
  {$EXTERNALSYM ZLIB_VER_SUBREVISION}
  ZLIB_VER_SUBREVISION = 0;

type
{JPM - I made some types from our old header to the new C types defined originally
 for compatability.}
  {$EXTERNALSYM z_off_t}
  {$IFDEF USE_VCL_POSIX}
  z_off_t = off_t;
  {$ENDIF}
  {$IFDEF KYLIXCOMPAT}
  z_off_t = off_t;
  {$ENDIF}
  {$IFDEF USE_BASEUNIX}
  z_off_t = off_t;
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
   z_off_t = TIdC_LONG;
  {$ENDIF}
  {$EXTERNALSYM alloc_func}
  alloc_func = function(opaque: Pointer; items, size: TIdC_UINT): Pointer;  cdecl;
  {$EXTERNALSYM TAlloc}
  TAlloc     = alloc_func;
  {$EXTERNALSYM  free_func}
  free_func  = procedure(opaque, address: Pointer); cdecl;
 {$EXTERNALSYM  TFree}
  TFree      = free_func;
 {$EXTERNALSYM  in_func}
  in_func    = function(opaque: Pointer; var buf: PByte): TIdC_UNSIGNED; cdecl;
 {$EXTERNALSYM TInFunc}
  TInFunc    = in_func;
 {$EXTERNALSYM out_func}
  out_func   = function(opaque: Pointer; buf: PByte; size: TIdC_UNSIGNED): TIdC_INT; cdecl;
  {$EXTERNALSYM TOutFunc}
  TOutFunc   = out_func;
   {$EXTERNALSYM z_streamp}
  z_streamp = ^z_stream;
   {$EXTERNALSYM z_stream}
  z_stream = record
    next_in: PAnsiChar;       (* next input byte *)
    avail_in: TIdC_UINT;    (* number of bytes available at next_in *)
    total_in: TIdC_ULONG;    (* total nb of input bytes read so far *)

    next_out: PAnsiChar;      (* next output byte should be put there *)
    avail_out: TIdC_UINT;   (* remaining free space at next_out *)
    total_out: TIdC_ULONG;   (* total nb of bytes output so far *)

    msg: PAnsiChar;           (* last error message, NULL if no error *)
    state: Pointer;       (* not visible by applications *)

    zalloc: alloc_func;   (* used to allocate the internal state *)
    zfree: free_func;     (* used to free the internal state *)
    opaque: Pointer;      (* private data object passed to zalloc and zfree *)

    data_type: TIdC_INT;   (* best guess about the data type: ascii or binary *)
    adler: TIdC_ULONG;       (* adler32 value of the uncompressed data *)
    reserved: TIdC_ULONG;    (* reserved for future use *)
  end;
   {$EXTERNALSYM TZStreamRec}
  TZStreamRec = z_stream;
   {$EXTERNALSYM PZStreamRec}
  PZStreamRec = z_streamp;

(*
  gzip header information passed to and from zlib routines.  See RFC 1952
  for more details on the meanings of these fields.
*)
  {$EXTERNALSYM gz_headerp}
  gz_headerp = ^gz_header;
  {$EXTERNALSYM gz_header}
  gz_header = record
    text       : TIdC_INT;   //* true if compressed data believed to be text */
    time       : TIdC_ULONG;  //* modification time */
    xflags     : TIdC_INT;   //* extra flags (not used when writing a gzip file) */
    os         : TIdC_INT;   //* operating system */
    extra      : PByte;     //* pointer to extra field or Z_NULL if none */
    extra_len  : TIdC_UINT;  //* extra field length (valid if extra != Z_NULL) */
    extra_max  : TIdC_UINT;  //* space at extra (only when reading header) */
    name       : PAnsiChar;     //* pointer to zero-terminated file name or Z_NULL */
    name_max   : TIdC_UINT;  //* space at name (only when reading header) */
    comment    : PAnsiChar;     //* pointer to zero-terminated comment or Z_NULL */
    comm_max   : TIdC_UINT;  //* space at comment (only when reading header) */
    hcrc       : TIdC_INT;   //* true if there was or will be a header crc */
    done       : TIdC_INT;   //* true when done reading gzip header (not used when writing a gzip file) */
  end;
   {$EXTERNALSYM PgzHeaderRec}
  PgzHeaderRec = gz_headerp;
   {$EXTERNALSYM TgzHeaderRec}
  TgzHeaderRec = gz_header;

type
{not sure if these should be externalsymed but might not be a bad idea}
   {$EXTERNALSYM TZStreamType}
  TZStreamType = (
    zsZLib,  //standard zlib stream
    zsGZip,  //gzip stream
    zsRaw);  //raw stream (without any header)

(* constants *)
const
   {$EXTERNALSYM Z_NO_FLUSH}
  Z_NO_FLUSH      = 0;
  {$EXTERNALSYM  Z_PARTIAL_FLUSH}
  Z_PARTIAL_FLUSH = 1;
  {$EXTERNALSYM Z_PARTIAL_FLUSH}
  Z_SYNC_FLUSH    = 2;
  {$EXTERNALSYM Z_SYNC_FLUSH}
  Z_FULL_FLUSH    = 3;
  {$EXTERNALSYM Z_FINISH}
  Z_FINISH        = 4;
  {$EXTERNALSYM Z_BLOCK}
  Z_BLOCK         = 5;
  {$EXTERNALSYM Z_TREES}
  Z_TREES         = 6;
  {$EXTERNALSYM Z_OK}
  Z_OK            =  0;
  {$EXTERNALSYM Z_FINISH}
  Z_STREAM_END    =  1;
  {$EXTERNALSYM Z_FINISH}
  Z_NEED_DICT     =  2;
  {$EXTERNALSYM Z_FINISH}
  Z_ERRNO         = -1;
  {$EXTERNALSYM Z_FINISH}
  Z_STREAM_ERROR  = -2;
  {$EXTERNALSYM Z_FINISH}
  Z_DATA_ERROR    = -3;
  {$EXTERNALSYM Z_FINISH}
  Z_MEM_ERROR     = -4;
  {$EXTERNALSYM Z_FINISH}
  Z_BUF_ERROR     = -5;
  {$EXTERNALSYM Z_FINISH}
  Z_VERSION_ERROR = -6;

  {$EXTERNALSYM Z_FINISH}
  Z_NO_COMPRESSION       =  0;
  {$EXTERNALSYM Z_FINISH}
  Z_BEST_SPEED           =  1;
  {$EXTERNALSYM Z_FINISH}
  Z_BEST_COMPRESSION     =  9;
  {$EXTERNALSYM Z_FINISH}
  Z_DEFAULT_COMPRESSION  = -1;

  {$EXTERNALSYM Z_FINISH}
  Z_FILTERED            = 1;
    {$EXTERNALSYM Z_FINISH}
  Z_HUFFMAN_ONLY        = 2;
  {$EXTERNALSYM Z_FINISH}
  Z_RLE                 = 3;
  {$EXTERNALSYM Z_FINISH}
  Z_DEFAULT_STRATEGY    = 0;

  {$EXTERNALSYM Z_FINISH}
  Z_BINARY   = 0;
    {$EXTERNALSYM Z_FINISH}
  Z_TEXT     = 1;
    {$EXTERNALSYM Z_FINISH}
  Z_ASCII    = Z_TEXT;   //* for compatibility with 1.2.2 and earlier */
  {$EXTERNALSYM Z_FINISH}
  Z_UNKNOWN  = 2;

  {$EXTERNALSYM Z_DEFLATED}
  Z_DEFLATED = 8;
  {$EXTERNALSYM Z_NULL}
  Z_NULL = 0;  //* for initializing zalloc, zfree, opaque */

  {$EXTERNALSYM MAX_WBITS}
  MAX_WBITS = 15; { 32K LZ77 window }

  {$EXTERNALSYM MAX_MEM_LEVEL}
  MAX_MEM_LEVEL = 9;
  {$EXTERNALSYM DEF_MEM_LEVEL}
  DEF_MEM_LEVEL = 8; { if MAX_MEM_LEVEL > 8 }

  {$EXTERNALSYM inflateInit}
function inflateInit(var strm: z_stream): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM inflateBackInit}
function inflateBackInit(var strm: z_stream;
                         windowBits: TIdC_INT; window: PAnsiChar): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM inflateInit2}
function inflateInit2(var strm: z_stream; windowBits: TIdC_INT): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM deflateInit}
function deflateInit(var strm: z_stream; level: TIdC_INT): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM deflateInit2}
function deflateInit2(var strm: z_stream; level, method, windowBits,
                      memLevel, strategy: TIdC_INT): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{not sure if these should be externalsymed but might not be a bad idea}
  {$EXTERNALSYM deflateInitEx}
function deflateInitEx(var strm: z_stream; level: TIdC_INT; streamtype: TZStreamType = zsZLib): TIdC_INT;
  {$EXTERNALSYM inflateInitEx}
function inflateInitEx(var strm: z_stream; streamtype: TZStreamType = zsZLib): TIdC_INT;

  {$EXTERNALSYM adler32}
  {$EXTERNALSYM adler32_combine}
  {$EXTERNALSYM compress}
  {$EXTERNALSYM compress2}
  {$EXTERNALSYM compressBound}
  {$EXTERNALSYM crc32}
  {$EXTERNALSYM crc32_combine}
  {$EXTERNALSYM deflate}
  {$EXTERNALSYM deflateBound}
  {$EXTERNALSYM deflateCopy}
  {$EXTERNALSYM deflateEnd}
  {$EXTERNALSYM deflateInit_}
  {$EXTERNALSYM deflateInit2_}
  {$EXTERNALSYM deflateParams}
  {$EXTERNALSYM deflatePrime}
  {$EXTERNALSYM deflateTune}
  {$EXTERNALSYM deflateReset}
  {$EXTERNALSYM deflateSetDictionary}
  {$EXTERNALSYM inflate}
  {$EXTERNALSYM inflateBack}
  {$EXTERNALSYM inflateBackEnd}
  {$EXTERNALSYM inflateBackInit_}
  {$EXTERNALSYM inflateCopy}
  {$EXTERNALSYM inflateEnd; external}
  {$EXTERNALSYM inflateInit_}
  {$EXTERNALSYM inflateInit2_}
  {$EXTERNALSYM inflateReset}
  {$EXTERNALSYM inflateReset2}
  {$EXTERNALSYM inflateSetDictionary}
  {$EXTERNALSYM inflateSync}
  {$EXTERNALSYM uncompress}
  {$EXTERNALSYM zlibCompileFlags}
  {$EXTERNALSYM zError}
  {$EXTERNALSYM inflateSyncPoint}
  {$EXTERNALSYM get_crc_table}
  {$EXTERNALSYM inflateUndermine}
  {$EXTERNALSYM zlibVersion}
  {$EXTERNALSYM deflateSetHeader}
  {$EXTERNALSYM inflatePrime}
  {$EXTERNALSYM inflateMark}
  {$EXTERNALSYM inflateGetHeader}

{$IFNDEF STATICLOAD_ZLIB}
type
  EIdZLibStubError = class(EIdException)
  protected
    FError : LongWord;
    FErrorMessage : String;
    FTitle : String;
  public
    constructor Build(const ATitle : String; AError : LongWord);
    property Error : LongWord read FError;
    property ErrorMessage : String read FErrorMessage;
    property Title : String read FTitle;
  end;

type
  {$EXTERNALSYM LPN_adler32}
  LPN_adler32 = function (adler: TIdC_ULONG;
    const buf: PAnsiChar; len: TIdC_UINT): TIdC_ULONG; cdecl;
  {$EXTERNALSYM LPN_adler32_combine}
  LPN_adler32_combine = function (crc1, crc2 : TIdC_ULONG;
    len2 : z_off_t) : TIdC_ULONG; cdecl;
  {$EXTERNALSYM LPN_compress}
  LPN_compress = function (dest: PAnsiChar; var destLen: TIdC_ULONG;
    const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
  {$EXTERNALSYM LPN_compress2}
  LPN_compress2 = function(dest: PAnsiChar; var destLen: TIdC_ULONG;
                  const source: PAnsiChar; sourceLen: TIdC_ULONG;
                  level: TIdC_INT): TIdC_INT; cdecl;
  {$EXTERNALSYM LPN_compressBound}
  LPN_compressBound = function (sourceLen: TIdC_ULONG): TIdC_ULONG;cdecl;
  {$EXTERNALSYM LPN_crc32}
  LPN_crc32 = function (crc: TIdC_ULONG; const buf: PAnsiChar;
                len: TIdC_UINT): TIdC_ULONG; cdecl;
  {$EXTERNALSYM LPN_crc32_combine}
  LPN_crc32_combine = function (crc1, crc2 : TIdC_ULONG;
    len2 : z_off_t) : TIdC_ULONG; cdecl;
  {$EXTERNALSYM LPN_deflate}
  LPN_deflate = function (var strm: z_stream; flush: TIdC_INT): TIdC_INT; cdecl;
  {$EXTERNALSYM LPN_deflateBound}
  LPN_deflateBound = function (var strm: z_stream;
    sourceLen: TIdC_ULONG): TIdC_ULONG; cdecl;
  {$EXTERNALSYM LPN_deflateCopy}
  LPN_deflateCopy = function (var dest, source: z_stream): TIdC_INT; cdecl;
  {$EXTERNALSYM LPN_deflateEnd}
  LPN_deflateEnd = function (var strm: z_stream):  TIdC_INT; cdecl;
  {$EXTERNALSYM LPN_deflateInit_}
  LPN_deflateInit_ = function (var strm: z_stream; level: TIdC_INT;
                      const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
  {$EXTERNALSYM LPN_deflateInit2_}
  LPN_deflateInit2_ = function (var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
  {$EXTERNALSYM LPN_deflateParams}
  LPN_deflateParams = function (var strm: z_stream; level, strategy: TIdC_INT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_deflatePrime}
  LPN_deflatePrime = function (var strm: z_stream; bits, value: TIdC_INT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_deflateTune}
  LPN_deflateTune = function (var strm : z_stream; good_length : TIdC_INT;
    max_lazy, nice_length, max_chain : TIdC_INT) : TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_deflateReset}
  LPN_deflateReset = function (var strm: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_deflateSetDictionary}
  LPN_deflateSetDictionary = function (var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflate}
  LPN_inflate = function (var strm: z_stream; flush: TIdC_INT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateBack}
  LPN_inflateBack = function (var strm: z_stream; in_fn: in_func; in_desc: Pointer;
                     out_fn: out_func; out_desc: Pointer): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateBackEnd}
  LPN_inflateBackEnd = function (var strm: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateBackInit_}
  LPN_inflateBackInit_ = function (var strm: z_stream;
                          windowBits: TIdC_INT; window: PAnsiChar;
                          const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateCopy}
  LPN_inflateCopy = function (var dest, source: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateEnd}
  LPN_inflateEnd = function (var strm: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateInit_}
  LPN_inflateInit_ = function (var strm: z_stream; const version: PAnsiChar;
                      stream_size: TIdC_INT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateInit2_}
  LPN_inflateInit2_ = function (var strm: z_stream; windowBits: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
   {$EXTERNALSYM LPN_inflateReset}
  LPN_inflateReset = function (var strm: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateReset2}
  LPN_inflateReset2 = function (var strm : z_stream; windowBits : TIdC_INT) : TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflatePrime}
  LPN_inflatePrime = function (var strm : z_stream; bits, value : TIdC_INT ) : TIdC_INT;  cdecl;
   {$EXTERNALSYM LPN_inflateMark}
  LPN_inflateMark = function (var strm : z_stream) : TIdC_LONG; cdecl;
   {$EXTERNALSYM LPN_inflateSetDictionary}
  LPN_inflateSetDictionary = function (var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateSync}
  LPN_inflateSync = function (var strm: z_stream): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_uncompress}
  LPN_uncompress = function (dest: PAnsiChar; var destLen: TIdC_ULONG;
                   const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
   {$EXTERNALSYM LPN_zlibCompileFlags}
  LPN_zlibCompileFlags = function : TIdC_ULONG; cdecl;
   {$EXTERNALSYM LPN_zError}
  LPN_zError = function (err : TIdC_INT) : PAnsiChar; cdecl;
   {$EXTERNALSYM LPN_inflateSyncPoint}
  LPN_inflateSyncPoint = function (var z : TZStreamRec) : TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_get_crc_table}
  LPN_get_crc_table = function : PIdC_ULONG; cdecl;
   {$EXTERNALSYM LPN_zlibVersion}
  LPN_zlibVersion = function : PAnsiChar; cdecl;
   {$EXTERNALSYM LPN_inflateUndermine}
  LPN_inflateUndermine = function (var strm: z_stream; subvert : TIdC_INT ) : TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_deflateSetHeader}
  LPN_deflateSetHeader = function (var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
   {$EXTERNALSYM LPN_inflateGetHeader}
  LPN_inflateGetHeader = function (var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
{Vars}
var
  adler32 : LPN_adler32 = nil;
  adler32_combine : LPN_adler32_combine = nil;
  compress : LPN_compress = nil;
  compress2 : LPN_compress2 = nil;
  compressBound : LPN_compressBound = nil;
  crc32 : LPN_crc32 = nil;
  crc32_combine : LPN_crc32_combine = nil;
  deflate : LPN_deflate = nil; 
  deflateBound : LPN_deflateBound = nil;
  deflateCopy : LPN_deflateCopy = nil;
  deflateEnd : LPN_deflateEnd = nil;
  deflateInit_ : LPN_deflateInit_ = nil; 
  deflateInit2_ : LPN_deflateInit2_ = nil;
  deflateParams : LPN_deflateParams = nil;
  
  deflatePrime :LPN_deflatePrime = nil;
  deflateTune : LPN_deflateTune = nil;
  deflateReset : LPN_deflateReset = nil;
  deflateSetDictionary : LPN_deflateSetDictionary = nil;
  inflate : LPN_inflate = nil; 
  inflateBack : LPN_inflateBack = nil;
  inflateBackEnd : LPN_inflateBackEnd = nil;
  inflateEnd : LPN_inflateEnd = nil; 
  inflateBackInit_ : LPN_inflateBackInit_ = nil;
  inflateCopy : LPN_inflateCopy = nil;
  inflateInit_ : LPN_inflateInit_ = nil;
  inflateInit2_ : LPN_inflateInit2_ = nil;
  inflateReset : LPN_inflateReset = nil;

  inflateReset2 : LPN_inflateReset2 = nil;
  inflatePrime : LPN_inflatePrime = nil;
  inflateMark : LPN_inflateMark = nil;

  inflateSetDictionary : LPN_inflateSetDictionary = nil;
  inflateSync : LPN_inflateSync = nil; 
  uncompress : LPN_uncompress = nil; 
  zlibCompileFlags : LPN_zlibCompileFlags = nil;
  zError : LPN_zError = nil; 
  inflateSyncPoint : LPN_inflateSyncPoint = nil;
  get_crc_table : LPN_get_crc_table = nil;
  inflateUndermine : LPN_inflateUndermine = nil;
  zlibVersion : LPN_zlibVersion = nil;
  deflateSetHeader : LPN_deflateSetHeader = nil;
  inflateGetHeader : LPN_inflateGetHeader = nil;

{$ELSE}
(* basic functions *)
function zlibVersion: PAnsiChar; 

function deflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT;
function deflateEnd(var strm: z_stream): TIdC_INT;

function inflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT;
function inflateEnd(var strm: z_stream): TIdC_INT;

(* advanced functions *)

function deflateSetDictionary(var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT;
function deflateCopy(var dest, source: z_stream): TIdC_INT;
function deflateReset(var strm: z_stream): TIdC_INT;
function deflateParams(var strm: z_stream; level, strategy: TIdC_INT): TIdC_INT;
{JPM Addition}
function deflateTune(var strm : z_stream; good_length : TIdC_INT;
    max_lazy, nice_length, max_chain : TIdC_INT) : TIdC_INT;
function deflateBound(var strm: z_stream;
    sourceLen: TIdC_ULONG): TIdC_ULONG;
function deflatePrime(var strm: z_stream; bits, value: TIdC_INT): TIdC_INT;

function inflateSetDictionary(var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT;
function inflateSync(var strm: z_stream): TIdC_INT;
function inflateCopy(var dest, source: z_stream): TIdC_INT;
function inflateReset(var strm: z_stream): TIdC_INT;
function inflateReset2(var strm : z_stream; windowBits : TIdC_INT) : TIdC_INT;
function inflatePrime(var strm : z_stream; bits, value : TIdC_INT ) : TIdC_INT;
function inflateMark(var strm : z_stream) : TIdC_LONG;
function inflateBack(var strm: z_stream; in_fn: in_func; in_desc: Pointer;
                     out_fn: out_func; out_desc: Pointer): TIdC_INT;
function inflateBackEnd(var strm: z_stream): TIdC_INT;

function zlibCompileFlags: TIdC_ULONG;

{JPM Additional functions}
function  zError (err : TIdC_INT) : PAnsiChar;
function inflateSyncPoint(var z : TZStreamRec) : TIdC_INT;
//const uLongf * get_crc_table (void);
function inflateUndermine(var strm: z_stream; subvert : TIdC_INT ) : TIdC_INT;

function  get_crc_table : PIdC_ULONG;
{end JPM additions}

(* utility functions *)
function compress(dest: PAnsiChar; var destLen: TIdC_ULONG;
                  const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT;
function compress2(dest: PAnsiChar; var destLen: TIdC_ULONG;
                  const source: PAnsiChar; sourceLen: TIdC_ULONG;
                  level: TIdC_INT): TIdC_INT;
function compressBound(sourceLen: TIdC_ULONG): TIdC_ULONG;
function uncompress(dest: PAnsiChar; var destLen: TIdC_ULONG;
                   const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT;

(* checksum functions *)
function adler32(adler: TIdC_ULONG;
    const buf: PAnsiChar; len: TIdC_UINT): TIdC_ULONG;
function adler32_combine(crc1, crc2 : TIdC_ULONG; len2 : z_off_t) : TIdC_ULONG;
function crc32(crc: TIdC_ULONG; const buf: PAnsiChar;
                len: TIdC_UINT): TIdC_ULONG;
function crc32_combine(crc1, crc2 : TIdC_ULONG; len2 : z_off_t) : TIdC_ULONG;
(* various hacks, don't look :) *)
function deflateInit_(var strm: z_stream; level: TIdC_INT;
                      const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;
function inflateInit_(var strm: z_stream; const version: PAnsiChar;
                      stream_size: TIdC_INT): TIdC_INT;
function deflateInit2_(var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;
function inflateInit2_(var strm: z_stream; windowBits: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;
function inflateBackInit_(var strm: z_stream;
                          windowBits: TIdC_INT; window: PAnsiChar;
                          const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;

function deflateSetHeader(var strm: z_stream; var head: gz_header): TIdC_INT;
function inflateGetHeader(var strm: z_stream; var head: gz_header): TIdC_INT;
{$ENDIF}
{$EXTERNALSYM  zlibAllocMem}
function  zlibAllocMem(AppData: Pointer; Items, Size: TIdC_UINT): Pointer; cdecl;
 {$EXTERNALSYM zlibFreeMem}
procedure zlibFreeMem(AppData, Block: Pointer); cdecl;
 {$EXTERNALSYM Load}
function Load : Boolean;
  {$EXTERNALSYM Unload}
procedure Unload;
  {$EXTERNALSYM Loaded}
function Loaded : Boolean;

{minor additional helper functions}
  {$EXTERNALSYM _malloc}
function _malloc(Size: Integer): Pointer; cdecl;
  {$EXTERNALSYM _free}
procedure _free(Block: Pointer); cdecl;
  {$EXTERNALSYM _memset}
procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl;
  {$EXTERNALSYM _memcpy}
procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;

implementation

uses
  SysUtils
  {$IFNDEF STATICLOAD_ZLIB}
  , IdZLibConst
  , IdGlobal
    {$IFDEF KYLIXCOMPAT}
  , libc
    {$ENDIF}
    {$IFDEF FPC}
  , DynLibs // better add DynLibs only for fpc
    {$ENDIF}	
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  , Windows
    {$ENDIF}
  {$ENDIF} ;

{$IFDEF STATICLOAD_ZLIB}
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

function adler32; external;
function adler32_combine; external;
function compress; external;
function compress2; external;
function compressBound; external;
function crc32; external;
function crc32_combine; external;
function deflate; external;
function deflateBound; external;
function deflateCopy; external;
function deflateEnd; external;
function deflateInit_; external;
function deflateInit2_; external;
function deflateParams; external;
function deflatePrime; external;
function deflateTune; external;
function deflateReset; external;
function deflateSetDictionary; external;
function inflate; external;
function inflateBack; external;
function inflateBackEnd; external;
function inflateBackInit_; external;
function inflateCopy; external;
function inflateEnd; external;
function inflateInit_; external;
function inflateInit2_; external;
function inflateReset; external;
function inflateReset2; external;
function inflateSetDictionary; external;
function inflateSync; external;
function uncompress; external;
function zlibCompileFlags; external;
function zError; external;
function inflateSyncPoint; external;
function get_crc_table; external;
function inflateUndermine; external;
function zlibVersion; external;
function deflateSetHeader; external;
function inflatePrime; external;
function inflateMark; external;
function inflateGetHeader; external;
{$ELSE}
var
  {$IFDEF UNIX}
  hZlib: HModule = nilhandle;
  {$ELSE}
  hZLib: THandle = 0;
  {$ENDIF}

const
  {$IFDEF UNIX} 
  //The extensions will be resolved by IdGlobal.HackLoad
  //This is a little messy because symbolic links to libraries may not always be the same
  //in various Unix types.  Even then, there could possibly be differences.
  libzlib = 'libz';
  libvers : array [0..3] of string = ('.1','','.3','.2');
  {$ENDIF}
  {$IFDEF NETWARE}  {zlib.nlm comes with netware6}
  libzlib = 'zlib';
  {$ENDIF}
  {$IFDEF WIN32}
  //Note that this is the official ZLIB1 .DLL from the http://www.zlib.net/
  libzlib = 'zlib1.dll'; 
  {$ENDIF}
  {$IFDEF WIN64}
  //Note that this is not an official ZLIB .DLL.  It was obtained from:
  //http://www.winimage.com/zLibDll/
  //
  //It is defined with the WINAPI conventions instead of the standard cdecl
  //conventions.  Get the DLL for Win32-x86.
  libzlib = 'zlibwapi.dll'; 
  {$ENDIF}  

  
constructor EIdZLibStubError.Build(const ATitle : String; AError : LongWord);
begin
  FTitle := ATitle;
  FError := AError;
  if AError = 0 then begin
    inherited Create(ATitle);
  end else begin
    FErrorMessage := SysUtils.SysErrorMessage(AError);
    inherited Create(ATitle + ': ' + FErrorMessage);    {Do not Localize}
  end;
end;

function FixupStub(hDll: THandle; const AName: string): Pointer;
begin
  if hDll = 0 then begin
    EIdZLibStubError.Build(Format(RSZLibCallError, [AName]), 0);
  end;
  Result := GetProcAddress(hDll, PChar(AName));
  if Result = nil then begin
    EIdZLibStubError.Build(Format(RSZLibCallError, [AName]), 10022);
  end;
end;
 
function stub_adler32(adler: TIdC_ULONG; const buf: PAnsiChar; 
  len: TIdC_UINT): TIdC_ULONG; cdecl;
begin
  adler32 := FixupStub(hZLib, 'adler32'); {Do not Localize}
  Result := adler32(adler, buf, len);
end;

function stub_adler32_combine (crc1, crc2 : TIdC_ULONG;
    len2 : z_off_t) : TIdC_ULONG; cdecl;
begin
  adler32_combine := FixupStub(hZLib, 'adler32_combine'); {Do not Localize}
  Result := adler32_combine(crc1, crc2, len2);
end;

function stub_compress(dest: PAnsiChar; var destLen: TIdC_ULONG;
    const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT; 
    cdecl;
begin
  compress := FixupStub(hZLib, 'compress'); {Do not Localize}
  Result := compress(dest,destLen,source,sourceLen);
end;

function stub_compress2(dest: PAnsiChar; var destLen: TIdC_ULONG;
                  const source: PAnsiChar; sourceLen: TIdC_ULONG;
                  level: TIdC_INT): TIdC_INT; cdecl;
begin
  compress2 := FixupStub(hZLib, 'compress2'); {Do not Localize}
  Result := compress2(dest, destLen, source, sourceLen, level);
end;


function stub_compressBound(sourceLen: TIdC_ULONG): TIdC_ULONG; cdecl;
begin
  compressBound := FixupStub(hZLib, 'compressBound'); {Do not Localize}
  Result := compressBound(sourcelen);
end;

function stub_crc32(crc: TIdC_ULONG; const buf: PAnsiChar; 
                len: TIdC_UINT): TIdC_ULONG; cdecl;
begin
  crc32 := FixupStub(hZLib, 'crc32'); {Do not Localize}
  Result := crc32(crc, buf, len);
end;

function stub_crc32_combine (crc1, crc2 : TIdC_ULONG;
    len2 : z_off_t) : TIdC_ULONG; cdecl;
begin
  crc32_combine := FixupStub(hZLib, 'crc32_combine'); {Do not Localize}
  Result := crc32_combine(crc1, crc2, len2);
end;

function stub_deflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT; cdecl;
begin
  deflate := FixupStub(hZLib, 'deflate'); {Do not Localize}
  Result := deflate(strm, flush);
end;

function stub_deflateBound(var strm: z_stream; 
    sourceLen: TIdC_ULONG): TIdC_ULONG; cdecl;
begin
  deflateBound := FixupStub(hZLib, 'deflateBound'); {Do not Localize}
  Result := deflateBound(strm, sourceLen);
end;

function stub_deflateCopy(var dest, source: z_stream): TIdC_INT; cdecl;
begin
  deflateCopy := FixupStub(hZLib, 'deflateCopy'); {Do not Localize}
  Result := deflateCopy(dest, source);
end;

function stub_deflateEnd(var strm: z_stream):  TIdC_INT; cdecl;
begin
  deflateEnd := FixupStub(hZLib, 'deflateEnd'); {Do not Localize}
  Result := deflateEnd(strm);
end;

function stub_deflateInit_(var strm: z_stream; level: TIdC_INT;
                      const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
begin
  deflateInit_ := FixupStub(hZLib, 'deflateInit_'); {Do not Localize}
  Result := deflateInit_(strm, level, version, stream_size);
end;                

function stub_deflateInit2_(var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
begin
  deflateInit2_ := FixupStub(hZLib, 'deflateInit2_'); {Do not Localize}
  Result := deflateInit2_(strm,level, method, windowBits, memLevel, strategy,
                       version, stream_size);
end;

function stub_deflateParams (var strm: z_stream; level, strategy: TIdC_INT): TIdC_INT; cdecl;
begin
  deflateParams := FixupStub(hZLib, 'deflateParams'); {Do not Localize}
  Result := deflateParams (strm, level, strategy);
end;

function stub_deflatePrime (var strm: z_stream; bits, value: TIdC_INT): TIdC_INT; cdecl;
begin
  deflatePrime := FixupStub(hZLib, 'deflatePrime'); {Do not Localize}
  Result := deflateParams (strm, bits, value);
end;

function stub_deflateTune(var strm : z_stream; good_length : TIdC_INT;
    max_lazy, nice_length, max_chain : TIdC_INT) : TIdC_INT; cdecl;
begin
  deflateTune := FixupStub(hZLib, 'deflateTune'); {Do not Localize}
  Result := deflateTune(strm, good_length, max_lazy, nice_length, max_chain) ;
end;

function stub_deflateReset (var strm: z_stream): TIdC_INT; cdecl;
begin
  deflateReset := FixupStub(hZLib, 'deflateReset'); {Do not Localize}
  Result := deflateReset(strm);
end;
  
function stub_deflateSetDictionary(var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT; cdecl;
begin
  deflateSetDictionary := FixupStub(hZLib, 'deflateSetDictionary'); {Do not Localize}
  Result := deflateSetDictionary(strm, dictionary, dictLength);
end;

function stub_inflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT;  cdecl;
begin
  inflate := FixupStub(hZLib, 'inflate'); {Do not Localize}
  Result := inflate(strm, flush);
end;

function stub_inflateBack(var strm: z_stream; in_fn: in_func; in_desc: Pointer;
                     out_fn: out_func; out_desc: Pointer): TIdC_INT; cdecl;  
begin
  inflateBack := FixupStub(hZLib, 'inflateBack'); {Do not Localize}
  Result := inflateBack(strm, in_fn, in_desc, out_fn, out_desc);
end;
 
function stub_inflateBackEnd(var strm: z_stream): TIdC_INT; cdecl;     
begin
  inflateBackEnd := FixupStub(hZLib, 'inflateBackEnd'); {Do not Localize}
  Result := inflateBackEnd(strm);
end;

function stub_inflateEnd(var strm: z_stream): TIdC_INT; cdecl;
begin
  inflateEnd := FixupStub(hZLib, 'inflateEnd'); {Do not Localize}
  Result := inflateEnd(strm);
end;

function stub_inflateBackInit_(var strm: z_stream;
                          windowBits: TIdC_INT; window: PAnsiChar;
                          const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT; cdecl;
begin
  inflateBackInit_ := FixupStub(hZLib, 'inflateBackInit_'); {Do not Localize}
  Result := inflateBackInit_(strm, windowBits, window, version, stream_size);
end;

function stub_inflateInit2_(var strm: z_stream; windowBits: TIdC_INT;
                       const version: PAnsiChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
begin
  inflateInit2_ := FixupStub(hZLib, 'inflateInit2_'); {Do not Localize}
  Result := inflateInit2_(strm, windowBits, version, stream_size);
end;

function stub_inflateCopy(var dest, source: z_stream): TIdC_INT; cdecl;
begin
  inflateCopy := FixupStub(hZLib, 'inflateCopy'); {Do not Localize}
  Result := inflateCopy(dest, source);
end;


function  stub_inflateInit_(var strm: z_stream; const version: PAnsiChar;
                      stream_size: TIdC_INT): TIdC_INT; cdecl;
begin
  inflateInit_ := FixupStub(hZLib, 'inflateInit_'); {Do not Localize}
  Result := inflateInit_(strm, version, stream_size);
end;

function stub_inflateReset(var strm: z_stream): TIdC_INT; cdecl;
begin
  inflateReset := FixupStub(hZLib, 'inflateReset'); {Do not Localize}
  Result := inflateReset(strm);
end;

function stub_inflateReset2(var strm : z_stream; windowBits : TIdC_INT) : TIdC_INT; cdecl;
begin
  inflateReset2 := FixupStub(hZLib, 'inflateReset2'); {Do not Localize}
  Result := inflateReset2(strm, windowBits);
end;

function stub_inflatePrime(var strm : z_stream; bits, value : TIdC_INT ) : TIdC_INT; cdecl;
begin
  inflatePrime := FixupStub(hZLib, 'inflatePrime'); {Do not Localize}
  Result := inflatePrime(strm, bits, value);
end;

function stub_inflateMark(var strm : z_stream) : TIdC_LONG; cdecl;
begin
  inflateMark := FixupStub(hZLib, 'inflateMark'); {Do not Localize}
  Result := inflateMark(strm);
end;

function stub_inflateSetDictionary(var strm: z_stream; const dictionary: PAnsiChar;
                              dictLength: TIdC_UINT): TIdC_INT;cdecl;
begin
  inflateSetDictionary := FixupStub(hZLib, 'inflateSetDictionary'); {Do not Localize}
  Result := inflateSetDictionary(strm, dictionary, dictLength);
end;                              

function stub_inflateSync(var strm: z_stream): TIdC_INT; cdecl;
begin
  inflateSync := FixupStub(hZLib, 'inflateSync'); {Do not Localize}
  Result := inflateSync(strm);
end;
  
function stub_uncompress (dest: PAnsiChar; var destLen: TIdC_ULONG;
                   const source: PAnsiChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
begin
  uncompress := FixupStub(hZLib, 'uncompress'); {Do not Localize}
  Result := uncompress (dest, destLen, source, sourceLen);
end;
                   
function stub_zlibCompileFlags : TIdC_ULONG; cdecl;
begin
  zlibCompileFlags := FixupStub(hZLib, 'zlibCompileFlags'); {Do not Localize}
  Result := zlibCompileFlags;
end;

function stub_zError(err : TIdC_INT) : PAnsiChar; cdecl;
begin
  zError := FixupStub(hZLib, 'zError'); {Do not Localize}
  Result := zError(err);
end;

function stub_inflateSyncPoint(var z : TZStreamRec) : TIdC_INT; cdecl;
begin
  inflateSyncPoint := FixupStub(hZLib, 'inflateSyncPoint'); {Do not Localize}
  Result := inflateSyncPoint(z);
end; 

function stub_get_crc_table : PIdC_ULONG; cdecl;
begin
  get_crc_table := FixupStub(hZLib, 'get_crc_table'); {Do not Localize}
  Result := get_crc_table;
end;

function stub_inflateUndermine(var strm: z_stream; subvert : TIdC_INT ) : TIdC_INT; cdecl;
begin
  inflateUndermine := FixupStub(hZLib, 'inflateUndermine'); {Do not Localize}
  Result := inflateUndermine(strm,subvert);
end;

function stub_zlibVersion : PAnsiChar; cdecl;
begin
  Result := '';
  zlibVersion := FixupStub(hZLib, 'zlibVersion'); {Do not Localize}
  if Assigned(zlibVersion) then begin
    Result := zlibVersion;
  end;
end;

function stub_deflateSetHeader(var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
begin
  deflateSetHeader := FixupStub(hZLib, 'deflateSetHeader'); {Do not Localize}
  Result := deflateSetHeader(strm, head);
end;  

function stub_inflateGetHeader(var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
begin
  inflateGetHeader := FixupStub(hZLib, 'inflateGetHeader'); {Do not Localize}
  Result := inflateGetHeader(strm, head);
end;



procedure InitializeStubs;
begin
  adler32 := stub_adler32;
  adler32_combine := stub_adler32_combine;
  compress := stub_compress;
  compress2 := stub_compress2;
  compressBound := stub_compressBound;
  crc32 := stub_crc32;
  crc32_combine := stub_crc32_combine;
  deflate := stub_deflate;
  deflateBound := stub_deflateBound;
  deflateCopy := stub_deflateCopy;
  deflateEnd := stub_deflateEnd;
  deflateInit_ := stub_deflateInit_;
  deflateInit2_ := stub_deflateInit2_;
  deflateParams := stub_deflateParams;
  deflatePrime := stub_deflatePrime;
  deflateTune := stub_deflateTune;
  deflateReset := stub_deflateReset;
  deflateSetDictionary := stub_deflateSetDictionary;
  inflate := stub_inflate;
  inflateBack := stub_inflateBack;
  inflateBackEnd := stub_inflateBackEnd;
  inflateBackInit_ := stub_inflateBackInit_;
  inflateCopy := stub_inflateCopy;
  inflateEnd := stub_inflateEnd;
  inflateInit_ := stub_inflateInit_;
  inflateInit2_ := stub_inflateInit2_;
  inflateReset := stub_inflateReset;
  inflateReset2 := stub_inflateReset2;
  inflatePrime := stub_inflatePrime;
  inflateMark := stub_inflateMark;

  inflateSetDictionary := stub_inflateSetDictionary;
  inflateSync := stub_inflateSync;
  uncompress := stub_uncompress; 
  zlibCompileFlags := stub_zlibCompileFlags;
  zError := stub_zError;
  inflateUndermine := stub_inflateUndermine;
  inflateSyncPoint := stub_inflateSyncPoint;

  get_crc_table := stub_get_crc_table;
  zlibVersion := stub_zlibVersion;
  deflateSetHeader := stub_deflateSetHeader;
  inflateGetHeader := stub_inflateGetHeader;
end;
{$ENDIF}

function deflateInit(var strm: z_stream; level: TIdC_INT): TIdC_INT;
begin
//  if not Assigned(strm.zalloc) then strm.zalloc := zlibAllocMem;
//  if not Assigned(strm.zfree)  then strm.zfree  := zlibFreeMem;
  Result := deflateInit_(strm, level, ZLIB_VERSION, sizeof(z_stream));
end;

function deflateInit2(var strm: z_stream; level, method, windowBits,
                      memLevel, strategy: TIdC_INT): TIdC_INT;
begin
//  if not Assigned(strm.zalloc) then strm.zalloc := zlibAllocMem;
//  if not Assigned(strm.zfree)  then strm.zfree  := zlibFreeMem;
  Result := deflateInit2_(strm, level, method, windowBits, memLevel, strategy,
                          ZLIB_VERSION, sizeof(z_stream));
end;

const
  WBits : array[TZStreamType] of TIdC_INT = (MAX_WBITS, MAX_WBITS + 16, -MAX_WBITS);

function deflateInitEx(var strm: z_stream; level: TIdC_INT; streamtype: TZStreamType = zsZLib): TIdC_INT;
begin
  Result := deflateInit2(strm, level, Z_DEFLATED, WBits[streamtype],
    MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
end;

function inflateInitEx(var strm: z_stream; streamtype: TZStreamType = zsZLib): TIdC_INT;
begin
  Result := inflateInit2(strm, WBits[streamtype]);
end;

function inflateInit(var strm: z_stream): TIdC_INT;
begin
//  if not Assigned(strm.zalloc) then strm.zalloc := zlibAllocMem;
//  if not Assigned(strm.zfree)  then strm.zfree  := zlibFreeMem;
  Result := inflateInit_(strm, ZLIB_VERSION, sizeof(z_stream));
end;

function inflateInit2(var strm: z_stream; windowBits: TIdC_INT): TIdC_INT;
begin
  if not Assigned(strm.zalloc) then begin
    strm.zalloc := zlibAllocMem;
  end;
  if not Assigned(strm.zfree) then begin
    strm.zfree  := zlibFreeMem;
  end;
  Result := inflateInit2_(strm, windowBits, ZLIB_VERSION, SizeOf(z_stream));
end;

function inflateBackInit(var strm: z_stream;
  windowBits: TIdC_INT; window: PAnsiChar): TIdC_INT;
begin
  Result := inflateBackInit_(strm, windowBits, window,
                             ZLIB_VERSION, SizeOf(z_stream));
end;


{minor additional helper functions}
function _malloc(Size: Integer): Pointer; cdecl;
begin
  GetMem(Result, Size);
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

function zlibAllocMem(AppData: Pointer; Items, Size: TIdC_UINT): Pointer; cdecl;
begin
  GetMem(Result, Items*Size);
//  Result := AllocMem(Items * Size);
end;

procedure zlibFreeMem(AppData, Block: Pointer); cdecl;
begin
  FreeMem(Block);
end;

{$IFDEF STATICLOAD_ZLIB}
function Load : Boolean;
begin
  Result := True;
end;

procedure Unload;
begin
end;

function Loaded : Boolean;
begin
  Result := True;
end;
{$ELSE}
function Load : Boolean;
begin
  Result := True;
  if not Loaded then begin
    //In Windows, you should use SafeLoadLibrary instead of the LoadLibrary API
    //call because LoadLibrary messes with the FPU control word.
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    hZLib := SafeLoadLibrary(libzlib);
    {$ELSE}
      {$IFDEF UNIX}
    hZLib := HackLoad(libzlib, libvers);
      {$ELSE}
    hZLib := LoadLibrary(libzlib);
        {$IFDEF USE_INVALIDATE_MOD_CACHE}
    InvalidateModuleCache;
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
    Result := Loaded;
  end;
end;

procedure Unload;
begin
  if Loaded then begin
    FreeLibrary(hZLib);
    {$IFDEF DELPHI_CROSS}
    InvalidateModuleCache;
    {$ENDIF}
    hZLib := 0;
    InitializeStubs;
  end;
end;

function Loaded : Boolean;
begin
  Result := (hZLib <> 0);
end;
{$ENDIF}

{$IFNDEF STATICLOAD_ZLIB}
initialization
  InitializeStubs;
  Load;

finalization
  Unload;
{$ENDIF}

end.
