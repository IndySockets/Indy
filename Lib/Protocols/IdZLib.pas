(*
  Enhanced zlib implementation
  Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>

  Base implementation follows the original zlib unit.

  Key features:
  Using last zlib library (1.2.3).
  Removed all imported functions, which are now in zlibpas. This can be used
  standalone (as many other projects that need zlib do).

  The compression stream can create different type of streams:
  zlib, gzip and raw deflate (see constructors).

  The decompression stream can read all type of streams (autodetect),
  plus that the stream type and gzip info is available for public access.
  If the stream is not zlib or gzip, it is assumed raw. An error will
  occur during decompressing if the data format is not valid.

  The DecompressStream function is using the InflateBack call together
  with direct memory access on the source stream 
  (if available, which means TStringStream or TCustomMemoryStream descendant).
  It should be the fastest decompression routine!

  The CompressStreamEx function is using direct memory access on both
  source and destination stream (if available).
  It should be faster than CompressStream.

  CompressString or CompressStream can be used to compress a http response

History:
  - Aug 2005: Initial release
*)

unit IdZLib;

interface

{$I IdCompilerDefines.inc}

uses
  SysUtils,
  Classes,
  IdCTypes,
  IdGlobal,
  IdZLibHeaders;

type
  // Abstract ancestor class
  TCustomZlibStream = class(TIdBaseStream)
  protected
    FStrm: TStream;
    FStrmPos: Integer;
    FOnProgress: TNotifyEvent;
    FZRec: TZStreamRec;
    FBuffer: array [Word] of TIdAnsiChar;
    FNameBuffer: array [0..255] of TIdAnsiChar;
    FGZHeader : IdZLibHeaders.gz_header;
    FStreamType : TZStreamType;

    procedure Progress; dynamic;
    procedure IdSetSize(ASize: Int64); override;
    property  OnProgress: TNotifyEvent read FOnProgress write FOnProgress;

  public
    constructor Create(Strm: TStream);
    destructor Destroy; override;

    property GZHeader: gz_header read FGZHeader;
  end;

  TCompressionLevel = (clNone, clFastest, clDefault, clMax);

  TCompressionStream = class(TCustomZlibStream)
  protected
    function GetCompressionRate: Single;
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
  public
    constructor CreateEx(CompressionLevel: TCompressionLevel; Dest: TStream;
      const StreamType: TZStreamType;
      const AName: string = ''; ATime: Integer = 0);
    constructor Create(CompressionLevel: TCompressionLevel; Dest: TStream; const AIncludeHeaders : Boolean = True);
    constructor CreateGZ(CompressionLevel: TCompressionLevel; Dest: TStream;
      const AName: string = ''; ATime: Integer = 0); overload;
    destructor Destroy; override;
    property CompressionRate: Single read GetCompressionRate;
    property OnProgress;
  end;

  TDecompressionStream = class(TCustomZlibStream)
  protected
    FInitialPos : Int64;
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
  public
    constructor Create(Source: TStream);
    destructor Destroy; override;
    procedure  InitRead;
    function IsGZip: boolean;
    property OnProgress;
  end;

{ CompressBuf compresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
  Out: OutBuf = ptr to newly allocated buffer containing decompressed data
       OutBytes = number of bytes in OutBuf   }
procedure CompressBuf(const InBuf: Pointer; InBytes: Integer;
                      out OutBuf: Pointer; out OutBytes: TIdC_UINT);

//generic read header from a buffer
function GetStreamType(InBuffer: Pointer; InCount: TIdC_UINT; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType; overload;

//generic read header from a stream
//the stream position is preserved
function GetStreamType(InStream: TStream; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType; overload;

//Note that unlike other things in this unit, you specify things with number
//values.  This is deliberate on my part because some things in Indy rely on
//API's where you specify the ZLib parameter as a number.  This is for the
//utmost flexibility.  In the FTP server, you can actually specify something
//like a compression level.
//The WinBits parameter is extremely powerful so do not underestimate it.
procedure IndyCompressStream(InStream, OutStream: TStream;
  const level: Integer = Z_DEFAULT_COMPRESSION;
  const WinBits : Integer = MAX_WBITS;
  const MemLevel : Integer = MAX_MEM_LEVEL;
  const Stratagy : Integer = Z_DEFAULT_STRATEGY); 
//compress stream; tries to use direct memory access on input stream
procedure CompressStream(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
//compress stream; tries to use direct memory access on both streams
procedure CompressStreamEx(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
//compress a string
function  CompressString(const InString: string; level: TCompressionLevel; StreamType : TZStreamType): string;

//this is for where we know what the stream's WindowBits setting should be
//Note that this does have special handling for ZLIB values greater than
//32.  I'm trying to treat it as the inflateInit2_ call would.  I don't think
//InflateBack uses values greater than 16 so you have to make a workaround.
procedure IndyDecompressStream(InStream, OutStream: TStream;
  const AWindowBits : Integer); 
//fast decompress stream!
//using direct memory access to source stream (if available) and
//direct write (using inflateBack)
procedure DecompressStream(InStream, OutStream: TStream);

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

type
  EZlibError = class(Exception)
  {JPM Additions, we need to be able to provide diagnostic info in an exception}
  protected
    FErrorCode : Integer;
  public
    class procedure RaiseException(const AError: Integer);
    //
    property ErrorCode : Integer read FErrorCode;
  end;
  ECompressionError = class(EZlibError);
  EDecompressionError = class(EZlibError);

//ZLib error functions.  They raise an exception for ZLib codes less than zero
function DCheck(code: Integer): Integer;
function CCheck(code: Integer): Integer;

const
  //winbit constants
  MAX_WBITS = IdZLibHeaders.MAX_WBITS;
  {$EXTERNALSYM MAX_WBITS}
  GZIP_WINBITS = MAX_WBITS + 16; //GZip format
  {$EXTERNALSYM GZIP_WINBITS}
  //negative values mean do not add any headers
  //adapted from "Enhanced zlib implementation"
  //by Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>
  RAW_WBITS = -MAX_WBITS; //raw stream (without any header)
  {$EXTERNALSYM RAW_WBITS}

implementation

uses
  IdGlobalProtocols, IdStream, IdZLibConst
  {$IFDEF HAS_AnsiStrings_StrPLCopy}
  , AnsiStrings
  {$ENDIF}
  ;

const
  Levels: array [TCompressionLevel] of Int8 =
    (Z_NO_COMPRESSION, Z_BEST_SPEED, Z_DEFAULT_COMPRESSION, Z_BEST_COMPRESSION);

function CCheck(code: Integer): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := code;
  if code < 0 then begin
    ECompressionError.RaiseException(code);
  end;
end;

function DCheck(code: Integer): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := code;
  if code < 0 then begin
    EDecompressionError.RaiseException(code);
  end;
end;

procedure CompressBuf(const InBuf: Pointer; InBytes: Integer;
                      out OutBuf: Pointer; out OutBytes: TIdC_UINT);
var
  strm: z_stream;
  P: Pointer;
begin
  FillChar(strm, sizeof(strm), 0);
  OutBytes := ((InBytes + (InBytes div 10) + 12) + 255) and not 255;
  GetMem(OutBuf, OutBytes);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := OutBytes;
    CCheck(deflateInit(strm, Z_BEST_COMPRESSION));
    try
      while CCheck(deflate(strm, Z_FINISH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, 256);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out := PIdAnsiChar(PtrUInt(OutBuf) + (PtrUInt(strm.next_out) - PtrUInt(P)));
        strm.avail_out := 256;
      end;
    finally
      CCheck(deflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    OutBytes := strm.total_out;
  except
    FreeMem(OutBuf);
    raise;
  end;
end;

function DMAOfStream(AStream: TStream; out Available: TIdC_UINT): Pointer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if AStream is TCustomMemoryStream then begin
    Result := TCustomMemoryStream(AStream).Memory;
  end
  {$IFDEF STRING_IS_ANSI}
  // In D2009, the DataString property was changed to use a getter method
  // that returns a temporary string, so it is not a direct access to the
  // stream contents anymore.  TStringStream was updated to derive from
  // TBytesStream now, which is a TCustomMemoryStream descendant, and so
  // will be handled above...
  else if AStream is TStringStream then begin
    Result := Pointer(TStringStream(AStream).DataString);
  end
  {$ENDIF}
  else begin
    Result := nil;
  end;
  if Result <> nil then
  begin
    //handle integer overflow
    {$IFDEF STREAM_SIZE_64}
    Available := TIdC_UINT(IndyMin(AStream.Size - AStream.Position, High(TIdC_UINT)));
    // TODO: account for a 64-bit position in a 32-bit environment
    Inc(PtrUInt(Result), AStream.Position);
    {$ELSE}
    Available := AStream.Size - AStream.Position;
    Inc(PtrUInt(Result), AStream.Position);
    {$ENDIF}
  end else begin
    Available := 0;
  end;
end;

function CanResizeDMAStream(AStream: TStream): boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (AStream is TCustomMemoryStream)
            {$IFDEF STRING_IS_ANSI}
            // In D2009, TStringStream was updated to derive from TBytesStream now,
            // which is a TCustomMemoryStream descendant, and so will be handled above...
            or (AStream is TStringStream)
            {$ENDIF}
            ;
end;

///tries to get the stream info
//strm.next_in and available_in needs enough data!
//strm should not contain an initialized inflate

function TryStreamType(var strm: TZStreamRec; gzheader: PgzHeaderRec; const AWinBitsValue : Integer): boolean;
var
  InitBuf: PIdAnsiChar;
  InitIn : TIdC_UINT;
begin
  InitBuf := strm.next_in;
  InitIn  := strm.avail_in;
  DCheck(inflateInit2_(strm, AWinBitsValue, zlib_version, SizeOf(TZStreamRec)));

  if (AWinBitsValue = GZIP_WINBITS) and (gzheader <> nil) then begin
    DCheck(inflateGetHeader(strm, gzheader^));
  end;

  Result := inflate(strm, Z_BLOCK) = Z_OK;
  DCheck(inflateEnd(strm));

  if Result then begin
    Exit;
  end;

  //rollback
  strm.next_in  := InitBuf;
  strm.avail_in := InitIn;
end;

//tries to get the stream info
//strm.next_in and available_in needs enough data!
//strm should not contain an initialized inflate
function CheckInitInflateStream(var strm: TZStreamRec; gzheader: gz_headerp): TZStreamType; overload;
var
  InitBuf: PIdAnsiChar;
  InitIn: Integer;

  function LocalTryStreamType(AStreamType: TZStreamType): Boolean;
  begin
    DCheck(inflateInitEx(strm, AStreamType));

    if (AStreamType = zsGZip) and (gzheader <> nil) then begin
      DCheck(inflateGetHeader(strm, gzheader^));
    end;

    Result := inflate(strm, Z_BLOCK) = Z_OK;
    DCheck(inflateEnd(strm));

    if Result then begin
      Exit;
    end;

    //rollback
    strm.next_in  := InitBuf;
    strm.avail_in := InitIn;
  end;

begin
  if strm.next_out = nil then begin
    //needed for reading, but not used
    strm.next_out := strm.next_in;
  end;

  InitBuf := strm.next_in;
  InitIn  := strm.avail_in;

  for Result := zsZLib to zsGZip do
  begin
    if LocalTryStreamType(Result) then begin
      Exit;
    end;
  end;

  Result := zsRaw;
end;

function GetStreamType(InBuffer: Pointer; InCount: TIdC_UINT; gzheader: gz_headerp;
  out HeaderSize: TIdC_UINT): TZStreamType;
var
  strm : TZStreamRec;
begin
  FillChar(strm, SizeOf(strm), 0);
  strm.next_in  := InBuffer;
  strm.avail_in := InCount;
  Result        := CheckInitInflateStream(strm, gzheader);
  HeaderSize    := InCount - strm.avail_in;
end;

function GetStreamType(InStream: TStream; gzheader: gz_headerp;
  out HeaderSize: TIdC_UINT): TZStreamType;
const
  StepSize = 20; //one step be enough, but who knows...
var
  N       : TIdC_UINT;
  Buff    : PIdAnsiChar;
  UseBuffer: Boolean;
begin
  Buff := DMAOfStream(InStream, N);
  UseBuffer := Buff = nil;
  if UseBuffer then begin
    GetMem(Buff, StepSize);
  end;
  try
    repeat
      if UseBuffer then begin
        Inc(N, InStream.Read(Buff[N], StepSize));
      end;
      Result := GetStreamType(Buff, N, gzheader, HeaderSize);
      //do we need more data?
      //N mod StepSize <> 0 means no more data available
      if (HeaderSize < N) or (not UseBuffer) or ((N mod StepSize) <> 0) then begin
        Break;
      end;
      ReallocMem(Buff, N + StepSize);
    until False;
  finally
    if UseBuffer then
    begin
      try
        TIdStreamHelper.Seek(InStream, -N, soCurrent);
      finally
        FreeMem(Buff);
      end;
    end;
  end;
end;

const
  WindowSize = 1 shl MAX_WBITS;

type
  PZBack = ^TZBack;
  TZBack = record
    InStream  : TStream;
    OutStream : TStream;
    InMem     : PIdAnsiChar; //direct memory access
    InMemSize : TIdC_UINT;
    ReadBuf   : array[Word] of TIdAnsiChar;
    Window    : array[0..WindowSize] of TIdAnsiChar;
  end;

function Strm_in_func(opaque: Pointer; var buf: PByte): TIdC_UNSIGNED; cdecl;
var
  S : TStream;
  BackObj : PZBack;
begin
   BackObj := PZBack( opaque );
  S := BackObj.InStream; //help optimizations
  if BackObj.InMem <> nil then
  begin
    //direct memory access if available!
    buf := Pointer(BackObj.InMem);
    //handle integer overflow
    {$IFDEF STREAM_SIZE_64}
    Result := TIdC_UNSIGNED(IndyMin(S.Size - S.Position, High(TIdC_UNSIGNED)));
    {$ELSE}
    Result := S.Size - S.Position;
    {$ENDIF}
    TIdStreamHelper.Seek(S, Result, soCurrent);
  end else
  begin
    buf    := PByte(@BackObj.ReadBuf);
    Result := S.Read(buf^, SizeOf(BackObj.ReadBuf));
  end;
end;

function Strm_out_func(opaque: Pointer; buf: PByte; size: TIdC_UNSIGNED): TIdC_INT; cdecl;
begin
  Result := TIdC_INT(PZBack(opaque).OutStream.Write(buf^, size) - TIdC_SIGNED(size));
end;

procedure DecompressStream(InStream, OutStream: TStream);
var
  strm   : z_stream;
  BackObj: PZBack;
begin
  FillChar(strm, sizeof(strm), 0);
  GetMem(BackObj, SizeOf(TZBack));
  try
    //Darcy
    FillChar(BackObj^, sizeof(TZBack), 0);

    //direct memory access if possible!
    BackObj.InMem := DMAOfStream(InStream, BackObj.InMemSize);

    BackObj.InStream  := InStream;
    BackObj.OutStream := OutStream;

    //use our own function for reading
    strm.avail_in := Strm_in_func(BackObj, PByte(strm.next_in));
    strm.next_out := PIdAnsiChar(@BackObj.Window[0]);
    strm.avail_out := 0;

    CheckInitInflateStream(strm, nil);

    strm.next_out := nil;
    strm.avail_out := 0;
    DCheck(inflateBackInit(strm, MAX_WBITS, @BackObj.Window[0]));
    try
      DCheck(inflateBack(strm, Strm_in_func, BackObj, Strm_out_func, BackObj));
    //  DCheck(inflateBack(strm, @Strm_in_func, BackObj, @Strm_out_func, BackObj));
      //seek back when unused data
      TIdStreamHelper.Seek(InStream, -strm.avail_in, soCurrent);
      //now trailer can be checked
    finally
      DCheck(inflateBackEnd(strm));
    end;
  finally
    FreeMem(BackObj);
  end;
end;

procedure IndyDecompressStream(InStream, OutStream: TStream;
  const AWindowBits : Integer);
var
  strm   : TZStreamRec;
  BackObj: PZBack;
  LWindowBits : Integer;
begin
  LWindowBits := AWindowBits;
  FillChar(strm, sizeof(strm), 0);
  GetMem(BackObj, SizeOf(TZBack));
  try
    //direct memory access if possible!
    BackObj.InMem := DMAOfStream(InStream, BackObj.InMemSize);

    BackObj.InStream  := InStream;
    BackObj.OutStream := OutStream;

    //use our own function for reading
    strm.avail_in := Strm_in_func(BackObj, PByte(strm.next_in));
    strm.next_out := PIdAnsiChar(@BackObj.Window[0]);
    strm.avail_out := 0;

    //note that you can not use a WinBits parameter greater than 32 with
    //InflateBackInit.  That was used in the inflate functions
    //for automatic detection of header bytes and trailer bytes.
    //Se lets try this ugly workaround for it.
    if AWindowBits > 32 then
    begin
      LWindowBits := Abs(AWindowBits - 32);
      if not TryStreamType(strm, nil, LWindowBits) then
      begin
        if TryStreamType(strm, nil, LWindowBits + 16) then
        begin
          Inc(LWindowBits, 16);
        end else
        begin
          TryStreamType(strm, nil, -LWindowBits);
        end;
      end;
    end;
    strm.next_out := nil;
    strm.avail_out := 0;
    DCheck(inflateBackInit_(strm,LWindowBits, @BackObj.Window[0],
      zlib_version, SizeOf(TZStreamRec)));
    try
      DCheck(inflateBack(strm, Strm_in_func, BackObj, Strm_out_func, BackObj));
      //seek back when unused data
      TIdStreamHelper.Seek(InStream, -strm.avail_in, soCurrent);
      //now trailer can be checked
    finally
      DCheck(inflateBackEnd(strm));
    end;
  finally
    FreeMem(BackObj);
  end;
end;

type
  TMemStreamAccess = class(TMemoryStream);

function ExpandStream(AStream: TStream; const ACapacity : TIdStreamSize): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := True;
  AStream.Size := ACapacity;
  if AStream is TMemoryStream then begin
    {$I IdObjectChecksOff.inc}
    AStream.Size := TMemStreamAccess(AStream).Capacity;
    {$I IdObjectChecksOn.inc}
  end;
end;

procedure DoCompressStream(var strm: z_stream; InStream, OutStream: TStream; UseDirectOut: boolean);
const
  //64 KB buffer
  BufSize = 65536;

var
  InBuf, OutBuf : array of TIdAnsiChar;
  pLastOutBuf : PIdAnsiChar;
  UseInBuf, UseOutBuf : boolean;
  LastOutCount : TIdC_UINT;

  procedure WriteOut;
  var
    NumWritten : TIdC_UINT;
  begin
    if (LastOutCount > 0) and (strm.avail_out < LastOutCount) then begin
      NumWritten := LastOutCount - strm.avail_out;
      if UseOutBuf then begin
        OutStream.Write(pLastOutBuf^, NumWritten);
      end else begin
        TIdStreamHelper.Seek(OutStream, NumWritten, soCurrent);
      end;
    end;
  end;

  procedure NextOut;
  begin
    if UseOutBuf then
    begin
      strm.next_out  := PIdAnsiChar(OutBuf);
      strm.avail_out := Length(OutBuf);
    end else
    begin
      ExpandStream(OutStream, OutStream.Size + BufSize);
      strm.next_out := DMAOfStream(OutStream, strm.avail_out);
      //because we can't really know how much resize is increasing!
    end;
  end;

  procedure ExpandOut;
  begin
    if UseOutBuf then begin
      SetLength(OutBuf, Length(OutBuf) + BufSize);
    end;
    NextOut;
  end;

  function DeflateOut(FlushFlag: TIdC_INT): TIdC_INT;
  begin
    if strm.avail_out = 0 then begin
      NextOut;
    end;

    repeat
      pLastOutBuf := strm.next_out;
      LastOutCount := strm.avail_out;

      Result := deflate(strm, FlushFlag);
      if Result <> Z_BUF_ERROR then begin
        Break;
      end;

      ExpandOut;
    until False;

    CCheck(Result);
    WriteOut;
  end;

begin
  pLastOutBuf := nil;
  LastOutCount := 0;

  strm.next_in := DMAOfStream(InStream, strm.avail_in);
  UseInBuf := strm.next_in = nil;

  if UseInBuf then begin
    SetLength(InBuf, BufSize);
  end;

  UseOutBuf := not (UseDirectOut and CanResizeDMAStream(OutStream));
  if UseOutBuf then begin
    SetLength(OutBuf, BufSize);
  end;

  { From the zlib manual at http://www.zlib.net/manual.html

  deflate() returns Z_OK if some progress has been made (more input processed
  or more output produced), Z_STREAM_END if all input has been consumed and all
  output has been produced (only when flush is set to Z_FINISH), Z_STREAM_ERROR
  if the stream state was inconsistent (for example if next_in or next_out was
  NULL), Z_BUF_ERROR if no progress is possible (for example avail_in or avail_out
  was zero). Note that Z_BUF_ERROR is not fatal, and deflate() can be called again
  with more input and more output space to continue compressing.
  }

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
    if strm.avail_in = 0 then
    begin
      if UseInBuf then
      begin
        strm.next_in  := PIdAnsiChar(InBuf);
        strm.avail_in := InStream.Read(strm.next_in^, Length(InBuf));
        // TODO: if Read() returns < 0, raise an exception
      end;
      if strm.avail_in = 0 then begin
        Break;
      end;
    end;
    DeflateOut(Z_NO_FLUSH);
  until False;

  repeat until DeflateOut(Z_FINISH) = Z_STREAM_END;

  if not UseOutBuf then
  begin
    //truncate when using direct output
    OutStream.Size := OutStream.Position;
  end;

  if not UseInBuf then begin
    //adjust position of direct input
    TIdStreamHelper.Seek(InStream, strm.total_in, soCurrent);
  end;
end;

procedure IndyCompressStream(InStream, OutStream: TStream;
  const level: Integer = Z_DEFAULT_COMPRESSION;
  const WinBits : Integer = MAX_WBITS;
  const MemLevel : Integer = MAX_MEM_LEVEL;
  const Stratagy : Integer = Z_DEFAULT_STRATEGY);
var
  strm : z_stream;
begin
  FillChar(strm, SizeOf(strm), 0);
  CCheck(deflateInit2_(strm, level, Z_DEFLATED, WinBits, MemLevel, Stratagy, zlib_version, SizeOf(TZStreamRec)));
  try
    DoCompressStream(strm, InStream, OutStream, True);
  finally
    CCheck(deflateEnd(strm));
  end;
end;

procedure CompressStream(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
var
  strm : z_stream;
begin
  FillChar(strm, SizeOf(strm), 0);
  CCheck(deflateInitEx(strm, Levels[level], StreamType));
  try
    DoCompressStream(strm, InStream, OutStream, False);
  finally
    CCheck(deflateEnd(strm));
  end;
end;

procedure CompressStreamEx(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
var
  strm : z_stream;
begin
  FillChar(strm, SizeOf(strm), 0);
  CCheck(deflateInitEx(strm, Levels[level], StreamType));
  try
    DoCompressStream(strm, InStream, OutStream, True);
  finally
    CCheck(deflateEnd(strm));
  end;
end;

function CompressString(const InString: string; level: TCompressionLevel; StreamType : TZStreamType): string;
var
  S, D : TStringStream;
begin
  S := TStringStream.Create(InString);
  try
    D := TStringStream.Create('');
    try
      CompressStream(S, D, level, StreamType);
      Result := D.DataString;
    finally
      D.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure DecompressBuf(const InBuf: Pointer; InBytes: Integer;
  OutEstimate: Integer; out OutBuf: Pointer; out OutBytes: Integer);
var
  strm: z_stream;
  P: Pointer;
  BufInc: Integer;
begin
  FillChar(strm, SizeOf(strm), 0);
  BufInc := (InBytes + 255) and not 255;
  if OutEstimate = 0 then begin
    OutBytes := BufInc;
  end else begin
    OutBytes := OutEstimate;
  end;
  GetMem(OutBuf, OutBytes);
  try
    strm.next_in := InBuf;
    strm.avail_in := InBytes;
    strm.next_out := OutBuf;
    strm.avail_out := OutBytes;
    DCheck(inflateInit(strm));
    try
      while DCheck(inflate(strm, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, BufInc);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out := PIdAnsiChar(PtrUInt(OutBuf) + (PtrUInt(strm.next_out) - PtrUInt(P)));
        strm.avail_out := BufInc;
      end;
    finally
      DCheck(inflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    OutBytes := strm.total_out;
  except
    FreeMem(OutBuf);
    raise;
  end;
end;

procedure DecompressToUserBuf(const InBuf: Pointer; InBytes: Integer;
  const OutBuf: Pointer; BufSize: Integer);
var
  strm: z_stream;
begin
  FillChar(strm, SizeOf(strm), 0);
  strm.next_in := InBuf;
  strm.avail_in := InBytes;
  strm.next_out := OutBuf;
  strm.avail_out := BufSize;
  DCheck(inflateInit(strm));
  try
    if DCheck(inflate(strm, Z_FINISH)) <> Z_STREAM_END then begin
      raise EZlibError.Create(sTargetBufferTooSmall);
    end;
  finally
    DCheck(inflateEnd(strm));
  end;
end;

{ EZlibError }

class procedure EZlibError.RaiseException(const AError: Integer);
var
  LException: EZlibError;
begin
  LException := CreateFmt(sZLibError, [AError]);
  LException.FErrorCode := AError;
  raise LException;
end;

// TCustomZlibStream
constructor TCustomZLibStream.Create(Strm: TStream);
begin
  inherited Create;
  FStrm    := Strm;
  FStrmPos := Strm.Position;
  fillchar(FZRec, SizeOf(FZRec), 0);
  FZRec.next_out  := @FBuffer[0];
  FZRec.avail_out := 0;
  FZRec.next_in   := @FBuffer[0];
  FZRec.avail_in  := 0;
  fillchar(FGZHeader, SizeOf(FGZHeader), 0);
  FStreamType := zsZLib;
  FGZHeader.name := @FNameBuffer[0];
  FGZHeader.name_max := SizeOf(FNameBuffer);
end;

destructor TCustomZlibStream.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomZLibStream.Progress;
begin
  if Assigned(FOnProgress) then begin
    FOnProgress(Self);
  end;
end;

procedure TCustomZLibStream.IdSetSize(ASize: Int64);
begin
  // do nothing here. IdSetSize is abstract, so it has
  // to be overriden, but we don't actually use it here
end;

// TCompressionStream
constructor TCompressionStream.CreateEx(CompressionLevel: TCompressionLevel;
  Dest: TStream; const StreamType: TZStreamType;
  const AName: string = ''; ATime: Integer = 0);
{$IFDEF USE_MARSHALLED_PTRS}
type
  TBytesPtr = ^TBytes;
{$ENDIF}
var
  LBytes: TIdBytes;
  {$IFDEF HAS_AnsiString}
  LName: AnsiString;
  {$ENDIF}
begin
  inherited Create(Dest);
  LBytes := nil; // keep the compiler happy
  FZRec.next_out := @FBuffer[0];
  FZRec.avail_out := SizeOf(FBuffer);
  FStreamType := StreamType;
  CCheck(deflateInitEx(FZRec, Levels[CompressionLevel], StreamType));
  if StreamType = zsGZip then
  begin
    FGZHeader.time := ATime;
    //zero-terminated file name
    //RFC 1952
    //                           The name must consist of ISO
    //8859-1 (LATIN-1) characters; on operating systems using
    //EBCDIC or any other character set for file names, the name
    //must be translated to the ISO LATIN-1 character set.

    // Rebeau 2/20/09: Indy's 8-bit encoding class currently uses ISO-8859-1
    // so we could technically use that, but since the RFC is very specific
    // about the charset, we'll force it here in case Indy's 8-bit encoding
    // class is changed later on...
    LBytes := CharsetToEncoding('ISO-8859-1').GetBytes(AName);
    {$IFDEF USE_MARSHALLED_PTRS}
    // TODO: optimize this
    FillChar(FGZHeader.name^, FGZHeader.name_max, 0);
    TMarshal.Copy(TBytesPtr(@LBytes)^, 0, TPtrWrapper.Create(FGZHeader.name), IndyMin(Length(LBytes), FGZHeader.name_max));
    {$ELSE}
    // TODO: use Move() instead...
    SetString(LName, PAnsiChar(LBytes), Length(LBytes));
    {$IFDEF HAS_AnsiStrings_StrPLCopy}AnsiStrings.{$ENDIF}StrPLCopy(FGZHeader.name, LName, FGZHeader.name_max);
    {$ENDIF}
    deflateSetHeader(FZRec, FGZHeader);
  end;
end;

constructor TCompressionStream.Create(CompressionLevel: TCompressionLevel;
  Dest: TStream; const AIncludeHeaders : Boolean = True);
begin
  if AIncludeHeaders then begin
    CreateEx(CompressionLevel, Dest, zsZLib);
  end else begin
    CreateEx(CompressionLevel, Dest, zsRaw);
  end;
end;

constructor TCompressionStream.CreateGZ(CompressionLevel: TCompressionLevel;
  Dest: TStream; const AName: string; ATime: Integer);
begin
  CreateEx(CompressionLevel, Dest, zsGZip, AName, ATime);
end;

destructor TCompressionStream.Destroy;
begin
  FZRec.next_in := nil;
  FZRec.avail_in := 0;
  try
    if FStrm.Position <> FStrmPos then begin
      FStrm.Position := FStrmPos;
    end;
    while (CCheck(deflate(FZRec, Z_FINISH)) <> Z_STREAM_END) and (FZRec.avail_out = 0) do
    begin
      FStrm.WriteBuffer(FBuffer[0], SizeOf(FBuffer));
      FZRec.next_out := @FBuffer[0];
      FZRec.avail_out := SizeOf(FBuffer);
    end;
    if FZRec.avail_out < SizeOf(FBuffer) then begin
      FStrm.WriteBuffer(FBuffer, SizeOf(FBuffer) - FZRec.avail_out);
    end;
  finally
    deflateEnd(FZRec);
  end;
  inherited Destroy;
end;

function TCompressionStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  raise ECompressionError.Create(sInvalidStreamOp);
end;

function TCompressionStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  FZRec.next_in := PIdAnsiChar(@ABuffer[AOffset]);
  FZRec.avail_in := ACount;
  if FStrm.Position <> FStrmPos then begin
    FStrm.Position := FStrmPos;
  end;
  while FZRec.avail_in > 0 do
  begin
    CCheck(deflate(FZRec, 0));
    if FZRec.avail_out = 0 then
    begin
      FStrm.WriteBuffer(FBuffer[0], SizeOf(FBuffer));
      FZRec.next_out := @FBuffer[0];
      FZRec.avail_out := SizeOf(FBuffer);
      FStrmPos := FStrm.Position;
      Progress;
    end;
  end;
  Result := ACount;
end;

function TCompressionStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  if (AOffset = 0) and (AOrigin = soCurrent) then begin
    Result := FZRec.total_in;
  end else begin
    raise ECompressionError.Create(sInvalidStreamOp);
  end;
end;

function TCompressionStream.GetCompressionRate: Single;
begin
  if FZRec.total_in = 0 then begin
    Result := 0;
  end else begin
    Result := (1.0 - (FZRec.total_out / FZRec.total_in)) * 100.0;
  end;
end;

// TDecompressionStream
constructor TDecompressionStream.Create(Source: TStream);
begin
  inherited Create(Source);
  FInitialPos := FStrmPos;
  FStreamType := zsRaw; //unknown
  InitRead;
end;

destructor TDecompressionStream.Destroy;
begin
  TIdStreamHelper.Seek(FStrm, -FZRec.avail_in, soCurrent);
  inflateEnd(FZRec);
  inherited Destroy;
end;

procedure TDecompressionStream.InitRead;
var
  N, S : TIdC_UINT;
begin
  //never call this after starting!
  if FZRec.total_in > 0 then begin
    Exit;
  end;

  N := FStrm.Read(FBuffer, SizeOf(FBuffer));
  //64k should always be enough
  FStreamType := GetStreamType(@FBuffer, N, @FGZHeader, S);
  if (S = N) or (FStreamType = zsGZip) and (FGZHeader.done = 0) then
  //need more data???
  //theoretically it can happen with a veeeeery long gzip name or comment
  //this is more generic, but some extra steps
  begin
    TIdStreamHelper.Seek(FStrm, -N, soCurrent);
    FStreamType := GetStreamType(FStrm, @FGZHeader, S);
  end;

  //open
  FZRec.next_in  := @FBuffer[0];
  FZRec.avail_in := N;

  DCheck(inflateInitEx(FZRec, FStreamType));
end;

function TDecompressionStream.IdRead(var VBuffer: TIdBytes; AOffset,
  ACount: Longint): Longint;
begin
  FZRec.next_out := PIdAnsiChar(@VBuffer[AOffset]);
  FZRec.avail_out := ACount;
  if FStrm.Position <> FStrmPos then begin
    FStrm.Position := FStrmPos;
  end;
  while FZRec.avail_out > 0 do
  begin
    if FZRec.avail_in = 0 then
    begin
      //init read if necessary
      //if FZRec.total_in = 0 then InitRead;

      FZRec.avail_in := FStrm.Read(FBuffer[0], SizeOf(FBuffer));
      if FZRec.avail_in = 0 then begin
        Break;
      end;
      FZRec.next_in := @FBuffer[0];
      FStrmPos := FStrm.Position;
      Progress;
    end;
    if CCheck(inflate(FZRec, 0)) = Z_STREAM_END then begin
      Break;
    end;
  end;
  Result := TIdC_UINT(ACount) - FZRec.avail_out;
end;

function TDecompressionStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  raise EDecompressionError.Create(sInvalidStreamOp);
end;

function TDecompressionStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
var
  I: Integer;
  Buf: array [0..4095] of TIdAnsiChar;
  LOffset : Int64;
begin
  if (AOffset = 0) and (AOrigin = soBeginning) then
  begin
    DCheck(inflateReset(FZRec));
    FZRec.next_in := @FBuffer[0];
    FZRec.avail_in := 0;
    FStrm.Position := FInitialPos;
    FStrmPos := FInitialPos;
  end
  else if ((AOffset >= 0) and (AOrigin = soCurrent)) or
          (((TIdC_UINT(AOffset) - FZRec.total_out) > 0) and (AOrigin = soBeginning)) then
  begin
    LOffset := AOffset;
    if AOrigin = soBeginning then begin
      Dec(LOffset, FZRec.total_out);
    end;
    if LOffset > 0 then
    begin
      for I := 1 to LOffset div sizeof(Buf) do begin
        ReadBuffer(Buf, sizeof(Buf));
      end;
      ReadBuffer(Buf, LOffset mod sizeof(Buf));
    end;
  end else
  begin
   // raise EDecompressionError.CreateRes(@sInvalidStreamOp);
   raise EDecompressionError.Create(sInvalidStreamOp);
  end;
  Result := FZRec.total_out;
end;

function TDecompressionStream.IsGZip: boolean;
begin
  Result := (FStreamType = zsGZip) and (FGZHeader.done = 1);
end;

end.
