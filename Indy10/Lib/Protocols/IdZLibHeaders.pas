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

//This is for chip architectures such as ARM or Sparc that require data alignment.
{$IFDEF REQUIRES_PROPER_ALIGNMENT}
   {$ALIGN ON}
{$ELSE}
  {$ALIGN OFF}
  {$WRITEABLECONST OFF}
{$ENDIF}

{$IFNDEF FPC}
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
    {$DEFINE STATICLOAD}
  {$ENDIF}
{$ENDIF}

{$IFNDEF STATICLOAD}
uses
  IdCTypes,
  IdException;
{$ELSE}
uses
  IdCTypes;
{$ENDIF}

const
  ZLIB_VERSION = '1.2.3';

type
{JPM - I made some types from our old header to the new C types defined originally
 for compatability.}
  alloc_func = function(opaque: Pointer; items, size: TIdC_UINT): Pointer;  cdecl;
  TAlloc     = alloc_func;
  free_func  = procedure(opaque, address: Pointer); cdecl;
  TFree      = free_func;
  in_func    = function(opaque: Pointer; var buf: PByte): TIdC_UNSIGNED; cdecl;
  TInFunc    = in_func;
  out_func   = function(opaque: Pointer; buf: PByte; size: TIdC_UNSIGNED): TIdC_INT; cdecl;
  TOutFunc   = out_func;

  z_streamp = ^z_stream;
  z_stream = record
    next_in: PChar;       (* next input byte *)
    avail_in: TIdC_UINT;    (* number of bytes available at next_in *)
    total_in: TIdC_ULONG;    (* total nb of input bytes read so far *)

    next_out: PChar;      (* next output byte should be put there *)
    avail_out: TIdC_UINT;   (* remaining free space at next_out *)
    total_out: TIdC_ULONG;   (* total nb of bytes output so far *)

    msg: PChar;           (* last error message, NULL if no error *)
    state: Pointer;       (* not visible by applications *)

    zalloc: alloc_func;   (* used to allocate the internal state *)
    zfree: free_func;     (* used to free the internal state *)
    opaque: Pointer;      (* private data object passed to zalloc and zfree *)

    data_type: TIdC_INT;   (* best guess about the data type: ascii or binary *)
    adler: TIdC_ULONG;       (* adler32 value of the uncompressed data *)
    reserved: TIdC_ULONG;    (* reserved for future use *)
  end;
  TZStreamRec = z_stream;
  PZStreamRec = z_streamp;

(*
  gzip header information passed to and from zlib routines.  See RFC 1952
  for more details on the meanings of these fields.
*)
  gz_headerp = ^gz_header;
  gz_header = record
    text       : TIdC_INT;   //* true if compressed data believed to be text */
    time       : TIdC_ULONG;  //* modification time */
    xflags     : TIdC_INT;   //* extra flags (not used when writing a gzip file) */
    os         : TIdC_INT;   //* operating system */
    extra      : PByte;     //* pointer to extra field or Z_NULL if none */
    extra_len  : TIdC_UINT;  //* extra field length (valid if extra != Z_NULL) */
    extra_max  : TIdC_UINT;  //* space at extra (only when reading header) */
    name       : PChar;     //* pointer to zero-terminated file name or Z_NULL */
    name_max   : TIdC_UINT;  //* space at name (only when reading header) */
    comment    : PChar;     //* pointer to zero-terminated comment or Z_NULL */
    comm_max   : TIdC_UINT;  //* space at comment (only when reading header) */
    hcrc       : TIdC_INT;   //* true if there was or will be a header crc */
    done       : TIdC_INT;   //* true when done reading gzip header (not used when writing a gzip file) */
  end;
  PgzHeaderRec = gz_headerp;
  TgzHeaderRec = gz_header;

type
  TZStreamType = (
    zsZLib,  //standard zlib stream
    zsGZip,  //gzip stream
    zsRaw);  //raw stream (without any header)

(* constants *)
const
  Z_NO_FLUSH      = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH    = 2;
  Z_FULL_FLUSH    = 3;
  Z_FINISH        = 4;
  Z_BLOCK         = 5;
  
  Z_OK            =  0;
  Z_STREAM_END    =  1;
  Z_NEED_DICT     =  2;
  Z_ERRNO         = -1;
  Z_STREAM_ERROR  = -2;
  Z_DATA_ERROR    = -3;
  Z_MEM_ERROR     = -4;
  Z_BUF_ERROR     = -5;
  Z_VERSION_ERROR = -6;

  Z_NO_COMPRESSION       =  0;
  Z_BEST_SPEED           =  1;
  Z_BEST_COMPRESSION     =  9;
  Z_DEFAULT_COMPRESSION  = -1;

  Z_FILTERED            = 1;
  Z_HUFFMAN_ONLY        = 2;
  Z_RLE                 = 3;
  Z_DEFAULT_STRATEGY    = 0;

  Z_BINARY   = 0;
  Z_ASCII    = 1;
  Z_UNKNOWN  = 2;

  Z_DEFLATED = 8;

  MAX_WBITS = 15; { 32K LZ77 window }

  MAX_MEM_LEVEL = 9;
  DEF_MEM_LEVEL = 8; { if MAX_MEM_LEVEL > 8 }
  
function inflateInit(var strm: z_stream): TIdC_INT;
{$IFDEF USEINLINE} inline; {$ENDIF}
function inflateBackInit(var strm: z_stream;
                         windowBits: TIdC_INT; window: PChar): TIdC_INT;
{$IFDEF USEINLINE} inline; {$ENDIF}
function inflateInit2(var strm: z_stream; windowBits: TIdC_INT): TIdC_INT;
{$IFDEF USEINLINE} inline; {$ENDIF}
function deflateInit(var strm: z_stream; level: TIdC_INT): TIdC_INT;
{$IFDEF USEINLINE} inline; {$ENDIF}
function deflateInit2(var strm: z_stream; level, method, windowBits,
                      memLevel, strategy: TIdC_INT): TIdC_INT;
{$IFDEF USEINLINE} inline; {$ENDIF}
function deflateInitEx(var strm: z_stream; level: TIdC_INT; streamtype: TZStreamType = zsZLib): TIdC_INT;
function inflateInitEx(var strm: z_stream; streamtype: TZStreamType = zsZLib): TIdC_INT;

{$IFNDEF STATICLOAD}
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
  LPN_adler32 = function (adler: TIdC_ULONG; 
    const buf: PChar; len: TIdC_UINT): TIdC_ULONG; cdecl;
  LPN_compress = function (dest: PChar; var destLen: TIdC_ULONG;
    const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
  LPN_compress2 = function(dest: PChar; var destLen: TIdC_ULONG;
                  const source: PChar; sourceLen: TIdC_ULONG;
                  level: TIdC_INT): TIdC_INT; cdecl;

  LPN_compressBound = function (sourceLen: TIdC_ULONG): TIdC_ULONG;cdecl;
  LPN_crc32 = function (crc: TIdC_ULONG; const buf: PChar; 
                len: TIdC_UINT): TIdC_ULONG; cdecl;
  LPN_deflate = function (var strm: z_stream; flush: TIdC_INT): TIdC_INT; cdecl;
  LPN_deflateBound = function (var strm: z_stream; 
    sourceLen: TIdC_ULONG): TIdC_ULONG; cdecl;
  LPN_deflateCopy = function (var dest, source: z_stream): TIdC_INT; cdecl;
  LPN_deflateEnd = function (var strm: z_stream):  TIdC_INT; cdecl;
  LPN_deflateInit_ = function (var strm: z_stream; level: TIdC_INT;
                      const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
  LPN_deflateInit2_ = function (var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
  LPN_deflateParams = function (var strm: z_stream; level, strategy: TIdC_INT): TIdC_INT; cdecl;

  LPN_deflatePrime = function (var strm: z_stream; bits, value: TIdC_INT): TIdC_INT; cdecl;
  LPN_deflateTune = function (var strm : z_stream; good_length : TIdC_INT;
    max_lazy, nice_length, max_chain : TIdC_INT) : TIdC_INT; cdecl;
  LPN_deflateReset = function (var strm: z_stream): TIdC_INT; cdecl;
  LPN_deflateSetDictionary = function (var strm: z_stream; const dictionary: PChar;
                              dictLength: TIdC_UINT): TIdC_INT; cdecl;
  LPN_inflate = function (var strm: z_stream; flush: TIdC_INT): TIdC_INT; cdecl;
  LPN_inflateBack = function (var strm: z_stream; in_fn: in_func; in_desc: Pointer;
                     out_fn: out_func; out_desc: Pointer): TIdC_INT; cdecl;   
  LPN_inflateBackEnd = function (var strm: z_stream): TIdC_INT; cdecl;     

  LPN_inflateBackInit_ = function (var strm: z_stream;
                          windowBits: TIdC_INT; window: PChar;
                          const version: PChar; stream_size: TIdC_INT): TIdC_INT; cdecl;
  LPN_inflateCopy = function (var dest, source: z_stream): TIdC_INT; cdecl;
  LPN_inflateEnd = function (var strm: z_stream): TIdC_INT; cdecl;
  LPN_inflateInit_ = function (var strm: z_stream; const version: PChar;
                      stream_size: TIdC_INT): TIdC_INT; cdecl;
  LPN_inflateInit2_ = function (var strm: z_stream; windowBits: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
  LPN_inflateReset = function (var strm: z_stream): TIdC_INT; cdecl;
  LPN_inflateSetDictionary = function (var strm: z_stream; const dictionary: PChar;
                              dictLength: TIdC_UINT): TIdC_INT; cdecl;

  LPN_inflateSync = function (var strm: z_stream): TIdC_INT; cdecl;
  LPN_uncompress = function (dest: PChar; var destLen: TIdC_ULONG;
                   const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
  LPN_zlibCompileFlags = function : TIdC_ULONG; cdecl;
  LPN_zError = function (err : TIdC_INT) : PChar; cdecl;

  LPN_inflateSyncPoint = function (var z : TZStreamRec) : TIdC_INT; cdecl;
 
  LPN_get_crc_table = function : PIdC_ULONG; cdecl;

  LPN_zlibVersion = function : PChar; cdecl;

  LPN_deflateSetHeader = function (var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
  LPN_inflateGetHeader = function (var strm: z_stream; var head: gz_header): TIdC_INT; cdecl;
{Vars}
var
  adler32 : LPN_adler32 = nil;
  compress : LPN_compress = nil;
  compress2 : LPN_compress2 = nil;
  compressBound : LPN_compressBound = nil;
  crc32 : LPN_crc32 = nil;
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
  inflateSetDictionary : LPN_inflateSetDictionary = nil; 
  inflateSync : LPN_inflateSync = nil; 
  uncompress : LPN_uncompress = nil; 
  zlibCompileFlags : LPN_zlibCompileFlags = nil;
  zError : LPN_zError = nil; 
  inflateSyncPoint : LPN_inflateSyncPoint = nil;
  get_crc_table : LPN_get_crc_table = nil;
  
  zlibVersion : LPN_zlibVersion = nil;
  deflateSetHeader : LPN_deflateSetHeader = nil;
  inflateGetHeader : LPN_inflateGetHeader = nil;

{$ELSE}
(* basic functions *)
function zlibVersion: PChar; 

function deflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT;
function deflateEnd(var strm: z_stream): TIdC_INT;

function inflate(var strm: z_stream; flush: TIdC_INT): TIdC_INT;
function inflateEnd(var strm: z_stream): TIdC_INT;

(* advanced functions *)

function deflateSetDictionary(var strm: z_stream; const dictionary: PChar;
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

function inflateSetDictionary(var strm: z_stream; const dictionary: PChar;
                              dictLength: TIdC_UINT): TIdC_INT;
function inflateSync(var strm: z_stream): TIdC_INT;
function inflateCopy(var dest, source: z_stream): TIdC_INT;
function inflateReset(var strm: z_stream): TIdC_INT;

function inflateBack(var strm: z_stream; in_fn: in_func; in_desc: Pointer;
                     out_fn: out_func; out_desc: Pointer): TIdC_INT;
function inflateBackEnd(var strm: z_stream): TIdC_INT;

function zlibCompileFlags: TIdC_ULONG;

{JPM Additional functions}
function  zError (err : TIdC_INT) : PChar;
function inflateSyncPoint(var z : TZStreamRec) : TIdC_INT;
//const uLongf * get_crc_table (void);

function  get_crc_table : PIdC_ULONG;
{end JPM additions}

(* utility functions *)
function compress(dest: PChar; var destLen: TIdC_ULONG;
                  const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT;
function compress2(dest: PChar; var destLen: TIdC_ULONG;
                  const source: PChar; sourceLen: TIdC_ULONG;
                  level: TIdC_INT): TIdC_INT;
function compressBound(sourceLen: TIdC_ULONG): TIdC_ULONG;
function uncompress(dest: PChar; var destLen: TIdC_ULONG;
                   const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT;

(* checksum functions *)
function adler32(adler: TIdC_ULONG; 
    const buf: PChar; len: TIdC_UINT): TIdC_ULONG;
function crc32(crc: TIdC_ULONG; const buf: PChar; 
                len: TIdC_UINT): TIdC_ULONG;

(* various hacks, don't look :) *)
function deflateInit_(var strm: z_stream; level: TIdC_INT;
                      const version: PChar; stream_size: TIdC_INT): TIdC_INT;
function inflateInit_(var strm: z_stream; const version: PChar;
                      stream_size: TIdC_INT): TIdC_INT;
function deflateInit2_(var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;
function inflateInit2_(var strm: z_stream; windowBits: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;
function inflateBackInit_(var strm: z_stream;
                          windowBits: TIdC_INT; window: PChar;
                          const version: PChar; stream_size: TIdC_INT): TIdC_INT;

function deflateSetHeader(var strm: z_stream; var head: gz_header): TIdC_INT;
function inflateGetHeader(var strm: z_stream; var head: gz_header): TIdC_INT;
{$ENDIF}
function  zlibAllocMem(AppData: Pointer; Items, Size: TIdC_UINT): Pointer; cdecl;
procedure zlibFreeMem(AppData, Block: Pointer); cdecl;

function Load : Boolean;
procedure Unload;
function Loaded : Boolean;

implementation

uses
  SysUtils
  {$IFNDEF STATICLOAD}
  , IdZLibConst
  {$ENDIF}
  {$IFDEF KYLIX}
  , libc
  {$ENDIF}
  {$IFDEF FPC}
    {$IFDEF USELIBC}
    , libc
    {$ENDIF}
    , DynLibs // better add DynLibs only for fpc
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  , Windows
  {$ENDIF};

{$IFDEF STATICLOAD}
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
function compress; external;
function compress2; external;
function compressBound; external;
function crc32; external;
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
function inflateSetDictionary; external;
function inflateSync; external;
function uncompress; external;
function zlibCompileFlags; external;
function zError; external;
function inflateSyncPoint; external;
function get_crc_table; external;
function zlibVersion; external;
function deflateSetHeader; external;
function inflateGetHeader; external;
{$ELSE}
var
  hZLib: THandle = 0;
  
const
  {$IFDEF UNIX} 
  libzlib = 'libz.so.1';
  {$ENDIF}
  {$ifdef netware}  {zlib.nlm comes with netware6}
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
  end else
  begin
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
 
function stub_adler32(adler: TIdC_ULONG; const buf: PChar; 
  len: TIdC_UINT): TIdC_ULONG; cdecl;
begin
  adler32 := FixupStub(hZLib, 'adler32'); {Do not Localize}
  Result := adler32(adler, buf, len);
end;

function stub_compress(dest: PChar; var destLen: TIdC_ULONG;
    const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT; 
    cdecl;
begin
  compress := FixupStub(hZLib, 'compress'); {Do not Localize}
  Result := compress(dest,destLen,source,sourceLen);
end;

function stub_compress2(dest: PChar; var destLen: TIdC_ULONG;
                  const source: PChar; sourceLen: TIdC_ULONG;
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

function stub_crc32(crc: TIdC_ULONG; const buf: PChar; 
                len: TIdC_UINT): TIdC_ULONG; cdecl;
begin
  crc32 := FixupStub(hZLib, 'crc32'); {Do not Localize}
  Result := crc32(crc, buf, len);
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
                      const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
begin
  deflateInit_ := FixupStub(hZLib, 'deflateInit_'); {Do not Localize}
  Result := deflateInit_(strm, level, version, stream_size);
end;                

function stub_deflateInit2_(var strm: z_stream;
                       level, method, windowBits, memLevel, strategy: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
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
  
function stub_deflateSetDictionary(var strm: z_stream; const dictionary: PChar;
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
                          windowBits: TIdC_INT; window: PChar;
                          const version: PChar; stream_size: TIdC_INT): TIdC_INT; cdecl;
begin
  inflateBackInit_ := FixupStub(hZLib, 'inflateBackInit_'); {Do not Localize}
  Result := inflateBackInit_(strm, windowBits, window, version, stream_size);
end;

function stub_inflateInit2_(var strm: z_stream; windowBits: TIdC_INT;
                       const version: PChar; stream_size: TIdC_INT): TIdC_INT;cdecl;
begin
  inflateInit2_ := FixupStub(hZLib, 'inflateInit2_'); {Do not Localize}
  Result := inflateInit2_(strm, windowBits, version, stream_size);
end;

function stub_inflateCopy(var dest, source: z_stream): TIdC_INT; cdecl;
begin
  inflateCopy := FixupStub(hZLib, 'inflateCopy'); {Do not Localize}
  Result := inflateCopy(dest, source);
end;


function  stub_inflateInit_(var strm: z_stream; const version: PChar;
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

function stub_inflateSetDictionary(var strm: z_stream; const dictionary: PChar;
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
  
function stub_uncompress (dest: PChar; var destLen: TIdC_ULONG;
                   const source: PChar; sourceLen: TIdC_ULONG): TIdC_INT;cdecl;
begin
  uncompress := FixupStub(hZLib, 'uncompress'); {Do not Localize}
  Result := uncompress (dest, destLen, source, sourceLen);
end;
                   
function stub_zlibCompileFlags : TIdC_ULONG; cdecl;
begin
  zlibCompileFlags := FixupStub(hZLib, 'zlibCompileFlags'); {Do not Localize}
  Result := zlibCompileFlags;
end;

function stub_zError(err : TIdC_INT) : PChar; cdecl;
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
  
function stub_zlibVersion : PChar; cdecl;
begin
  zlibVersion := FixupStub(hZLib, 'zlibVersion'); {Do not Localize}
  Result := zlibVersion;
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
  compress := stub_compress;
  compress2 := stub_compress2;
  compressBound := stub_compressBound;
  crc32 := stub_crc32;
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
  inflateSetDictionary := stub_inflateSetDictionary;
  inflateSync := stub_inflateSync;
  uncompress := stub_uncompress; 
  zlibCompileFlags := stub_zlibCompileFlags;
  zError := stub_zError;

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
  if not Assigned(strm.zalloc) then
    strm.zalloc := zlibAllocMem;
  if not Assigned(strm.zfree)  then
    strm.zfree  := zlibFreeMem;
  Result := inflateInit2_(strm, windowBits, ZLIB_VERSION, sizeof(z_stream));
end;

function inflateBackInit(var strm: z_stream;
                         windowBits: TIdC_INT; window: PChar): TIdC_INT;
begin
  Result := inflateBackInit_(strm, windowBits, window,
                             ZLIB_VERSION, sizeof(z_stream));
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

{$IFDEF STATICLOAD}
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
  if not Loaded then
  begin
    //In Windows, you should use SafeLoadLibrary instead of the LoadLibrary API
    //call because LoadLibrary messes with the FPU control word.
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    hZLib := SafeLoadLibrary(libzlib);
    {$ELSE}
    hZLib := LoadLibrary(libzlib);
    {$ENDIF}
    Result := Loaded;
  end;
end;

procedure Unload;
begin
  if Loaded then
  begin
    FreeLibrary(hZLib);
    hZLib := 0;
    InitializeStubs;
  end;
end;

function Loaded : Boolean;
begin
  Result := (hZLib <> 0);
end;
{$ENDIF}

{$IFNDEF STATICLOAD}
initialization
  InitializeStubs;
  Load;
finalization
  Unload;
{$ENDIF}
end.
