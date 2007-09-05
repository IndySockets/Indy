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

{$i IdCompilerDefines.inc}

uses
  SysUtils,
  Classes,
  IdCTypes,
  IdGlobal,
  IdZLibHeaders;

type
  // Abstract ancestor class
  TCustomZlibStream = class(TIdBaseStream)
  private
    FStrm: TStream;
    FStrmPos: Integer;
    FOnProgress: TNotifyEvent;
    FZRec: TZStreamRec;
    FBuffer: array [Word] of Char;
    FNameBuffer: array [0..255] of Char;
    FGZHeader : IdZLibHeaders.gz_header;
    FStreamType : TZStreamType;
  protected
    procedure Progress; dynamic;
    procedure IdSetSize(ASize: Int64); override;
    property  OnProgress: TNotifyEvent read FOnProgress write FOnProgress;

  public
    constructor Create(Strm: TStream);
    destructor  Destroy; override;

    property    GZHeader: gz_header read FGZHeader;
  end;

  TCompressionLevel = (clNone, clFastest, clDefault, clMax);

  TCompressionStream = class(TCustomZlibStream)
  private
    function GetCompressionRate: Single;
  protected
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
  private
    FInitialPos : Int64;
  protected
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
function  GetStreamType(InBuffer: Pointer; InCount: TIdC_UINT; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType; overload;

//generic read header from a stream
//the stream position is preserved
function  GetStreamType(InStream: TStream; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType; overload;

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

const
  //winbit constants
  MAX_WBITS = 15;   //standard zlib stream - { 32K LZ77 window }
  GZIP_WINBITS = MAX_WBITS + 16; //GZip format
  //negative values mean do not add any headers
  //adapted from "Enhanced zlib implementation"
  //by Gabriel Corneanu <gabrielcorneanu(AT)yahoo.com>
  RAW_WBITS = -MAX_WBITS; //raw stream (without any header)

implementation

uses
  IdStream, IdZLibConst;

const
  Levels: array [TCompressionLevel] of ShortInt =
    (Z_NO_COMPRESSION, Z_BEST_SPEED, Z_DEFAULT_COMPRESSION, Z_BEST_COMPRESSION);

function CCheck(code: Integer): Integer;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := code;
  if code < 0 then begin
    raise ECompressionError.CreateError(code);
  end;
//    raise ECompressionError.Create('error'); //!!
end;

function DCheck(code: Integer): Integer;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := code;
  if code < 0 then begin
    raise EDecompressionError.CreateError(code);
 //   raise EDecompressionError.Create('error');  //!!
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
        strm.next_out := PChar(PtrUInt(OutBuf) + (PtrUInt(strm.next_out) - PtrUInt(P)));
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

function DMAOfStream(AStream: TStream; out Available: TIdC_UINT): Pointer;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if AStream.inheritsFrom(TCustomMemoryStream) then
  begin
    Result := TCustomMemoryStream(AStream).Memory;
  end
  else 
  begin
    if AStream.inheritsFrom(TStringStream) then
    begin
      Result := Pointer(TStringStream(AStream).DataString);
    end
    else
    begin
      Result := nil;
    end;
  end;
  if Result <> nil then
  begin
    //what if integer overflow?
    Available := AStream.Size - AStream.Position;
    Inc(PtrInt(Result), AStream.Position);
  end
  else
  begin 
    Available := 0;
  end;
end;

function CanResizeDMAStream(AStream: TStream): boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := AStream.inheritsFrom(TMemoryStream) or
            AStream.inheritsFrom(TStringStream);
end;

///tries to get the stream info
//strm.next_in and available_in needs enough data!
//strm should not contain an initialized inflate

function TryStreamType(var strm: TZStreamRec; gzheader: PgzHeaderRec; const AWinBitsValue : Integer): boolean;
var
  InitBuf: PChar;
  InitIn : TIdC_UINT;
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

//tries to get the stream info
//strm.next_in and available_in needs enough data!
//strm should not contain an initialized inflate
function  CheckInitInflateStream(var strm: TZStreamRec; gzheader: gz_headerp): TZStreamType; overload;
var
  InitBuf: PChar;
  InitIn : integer;
  function TryStreamType(AStreamType: TZStreamType): boolean;
  begin
    DCheck(inflateInitEx(strm, AStreamType));

    if (AStreamType = zsGZip) and (gzheader <> nil) then
      DCheck(inflateGetHeader(strm, gzheader^));

    Result := inflate(strm, Z_BLOCK) = Z_OK;
    DCheck(inflateEnd(strm));

    if Result then exit;
    //rollback
    strm.next_in  := InitBuf;
    strm.avail_in := InitIn;
  end;

begin
  if strm.next_out = nil then
    //needed for reading, but not used
    strm.next_out := strm.next_in;

  try
    InitBuf := strm.next_in;
    InitIn  := strm.avail_in;
    for Result := zsZLib to zsGZip do
      if TryStreamType(Result) then exit;
    Result := zsRaw;
  finally
    
  end;
end;

function  GetStreamType(InBuffer: Pointer; InCount: TIdC_UINT; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType;
var
  strm : TZStreamRec;
begin
  FillChar(strm, SizeOf(strm), 0);
  strm.next_in  := InBuffer;
  strm.avail_in := InCount;
  Result        := CheckInitInflateStream(strm, gzheader);
  HeaderSize    := InCount - strm.avail_in;
end;

function GetStreamType(InStream: TStream; gzheader: gz_headerp; out HeaderSize: TIdC_UINT): TZStreamType;
const
  StepSize = 20; //one step be enough, but who knows...
var
  N       : TIdC_UINT;
  Buff    : PChar;
  UseBuffer: boolean;
begin
  Buff := DMAOfStream(InStream, N);
  UseBuffer := Buff = nil;
  if UseBuffer then
    GetMem(Buff, StepSize);
  try
    repeat
      if UseBuffer then
        Inc(N, InStream.Read(Buff[N], StepSize));

      Result := GetStreamType(Buff, N, gzheader, HeaderSize);
      //do we need more data?
      //N mod StepSize <> 0 means no more data available
      if (HeaderSize < N) or (not UseBuffer) or (N mod StepSize <> 0) then break;
      ReallocMem(Buff, N + StepSize);
    until false;
  finally
    if UseBuffer then
    begin
      TIdStreamHelper.Seek(InStream, -N, soCurrent);
      FreeMem(Buff);
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
    InMem     : PChar; //direct memory access
    InMemSize : TIdC_UINT;
    ReadBuf   : array[word] of char;
    Window    : array[0..WindowSize] of char;
  end;

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
    TIdStreamHelper.Seek(S, Result, soCurrent);
  end else
  begin
    buf    := @BackObj.ReadBuf;
    Result := S.Read(buf^, SizeOf(BackObj.ReadBuf));
  end;
end;

function Strm_out_func(BackObj: PZBack; buf: PByte; size: Integer): Integer; cdecl;
begin
  Result := BackObj.OutStream.Write(buf^, size) - size;
end;

procedure DecompressStream(InStream, OutStream: TStream);
var
  strm   : z_stream;
  BackObj: PZBack;
begin
  FillChar(strm, sizeof(strm), 0);
  GetMem(BackObj, SizeOf(TZBack));
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
    DCheck(inflateBackInit(strm, MAX_WBITS, BackObj.Window));
    try
      DCheck(inflateBack(strm, @Strm_in_func, BackObj, @Strm_out_func, BackObj));
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
  TMemStreamHack = class(TMemoryStream);

function ExpandStream(AStream: TStream; const ACapacity : Int64): boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := true;
  AStream.Size := ACapacity;
  if AStream.InheritsFrom(TMemoryStream) then
    AStream.Size := TMemStreamHack(AStream).Capacity;
end;

procedure IndyCompressStream(InStream, OutStream: TStream;
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
  LastOutCount : TIdC_UINT;
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
      TIdStreamHelper.Seek(OutStream, LastOutCount - strm.avail_out, soCurrent);
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
    if UseInBuf then begin
      //seek back when unused data
      TIdStreamHelper.Seek(InStream, -strm.avail_in, soCurrent);
    end else begin
      //simple seek
      TIdStreamHelper.Seek(InStream, strm.total_in, soCurrent);
    end;

    CCheck(deflateEnd(strm));
  finally
    if InBuf <> nil then FreeMem(InBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;

end;

procedure DoCompressStreamEx(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType; UseDirectOut: boolean);
const
  //64 KB buffer
  BufSize = 65536;
var
  strm   : z_stream;
  InBuf, OutBuf : PChar;
  UseInBuf, UseOutBuf : boolean;
  LastOutCount : TIdC_UINT;

  procedure WriteOut;
  begin
    if UseOutBuf then
    begin
      if LastOutCount > 0 then OutStream.Write(OutBuf^, LastOutCount - strm.avail_out);
      strm.avail_out := BufSize;
      strm.next_out  := OutBuf;
    end
    else
    begin
      if (strm.avail_out = 0) then ExpandStream(OutStream, OutStream.Size + BufSize);
      TIdStreamHelper.Seek(OutStream, LastOutCount - strm.avail_out, soCurrent);
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

  UseOutBuf := not (UseDirectOut and CanResizeDMAStream(OutStream));
  if UseOutBuf then GetMem(OutBuf, BufSize);

  CCheck(deflateInitEx(strm, Levels[level], StreamType));
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
      if (strm.avail_in = 0) and (strm.avail_out = 0) then
      begin
        WriteOut;
      end;
      Finished := CCheck(deflate(strm, Z_FINISH)) = Z_STREAM_END;
      WriteOut;
    until Finished;

    if not UseOutBuf then
    begin
      //truncate when using direct output
      OutStream.Size := OutStream.Position;
    end;

    //adjust position of the input stream
    if UseInBuf then begin
      //seek back when unused data
      TIdStreamHelper.Seek(InStream, -strm.avail_in, soCurrent);
    end else begin
      //simple seek
      TIdStreamHelper.Seek(InStream, strm.total_in, soCurrent);
    end;

    CCheck(deflateEnd(strm));
  finally
    if InBuf <> nil then FreeMem(InBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
end;

procedure CompressStream(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
begin
  DoCompressStreamEx(InStream, OutStream, level, StreamType, false);
end;

procedure CompressStreamEx(InStream, OutStream: TStream; level: TCompressionLevel; StreamType : TZStreamType);
begin
  DoCompressStreamEx(InStream, OutStream, level, StreamType, true);
end;

function CompressString(const InString: string; level: TCompressionLevel; StreamType : TZStreamType): string;
var
  S, D : TStringStream;
begin
  S := TStringStream.Create(InString);
  D := TStringStream.Create('');
  CompressStream(S, D, level, StreamType);
  Result := D.DataString;
  D.Free;
  S.Free;
end;

procedure DecompressBuf(const InBuf: Pointer; InBytes: Integer;
  OutEstimate: Integer; out OutBuf: Pointer; out OutBytes: Integer);
var
  strm: z_stream;
  P: Pointer;
  BufInc: Integer;
begin
  FillChar(strm, sizeof(strm), 0);
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
    DCheck(inflateInit(strm));
    try
      while DCheck(inflate(strm, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, BufInc);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out := PChar(PtrUInt(OutBuf) + (PtrUInt(strm.next_out) - PtrUInt(P)));
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
  strm: z_stream;
begin
  FillChar(strm, sizeof(strm), 0);
  strm.next_in := InBuf;
  strm.avail_in := InBytes;
  strm.next_out := OutBuf;
  strm.avail_out := BufSize;
  DCheck(inflateInit(strm));
  try
    if DCheck(inflate(strm, Z_FINISH)) <> Z_STREAM_END then
      raise EZlibError.CreateRes(@sTargetBufferTooSmall);
  finally
    DCheck(inflateEnd(strm));
  end;
end;

{ EZlibError }

constructor EZlibError.CreateError(const AError: Integer);
begin
  inherited Create( zError(AError) );
  FErrorCode := AError;
end;

// TCustomZlibStream
constructor TCustomZLibStream.Create(Strm: TStream);
begin
  inherited Create;
  FStrm    := Strm;
  FStrmPos := Strm.Position;
  fillchar(FZRec, SizeOf(FZRec), 0);
  FZRec.next_out  := FBuffer;
  FZRec.avail_out := 0;
  FZRec.next_in   := FBuffer;
  FZRec.avail_in  := 0;
  fillchar(FGZHeader, SizeOf(FGZHeader), 0);
  FStreamType := zsZLib;
  FGZHeader.name := FNameBuffer;
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
begin
  inherited Create(Dest);
  FZRec.next_out := FBuffer;
  FZRec.avail_out := sizeof(FBuffer);
  FStreamType := StreamType;
  CCheck(deflateInitEx(FZRec, Levels[CompressionLevel], StreamType));
  if StreamType = zsGZip then
  begin
    FGZHeader.time := ATime;
    StrPLCopy(FGZHeader.name, AName, FGZHeader.name_max);
    deflateSetHeader(FZRec, FGZHeader);
  end;
end;

constructor TCompressionStream.Create(CompressionLevel: TCompressionLevel; Dest: TStream; const AIncludeHeaders : Boolean = True);
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

function TCompressionStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  raise ECompressionError.CreateRes(@sInvalidStreamOp);
end;

function TCompressionStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  FZRec.next_in := @ABuffer[AOffset];
  FZRec.avail_in := ACount;
  if FStrm.Position <> FStrmPos then begin
    FStrm.Position := FStrmPos;
  end;
  while FZRec.avail_in > 0 do
  begin
    CCheck(deflate(FZRec, 0));
    if FZRec.avail_out = 0 then
    begin
      FStrm.WriteBuffer(FBuffer, sizeof(FBuffer));
      FZRec.next_out := FBuffer;
      FZRec.avail_out := sizeof(FBuffer);
      FStrmPos := FStrm.Position;
      Progress;
    end;
  end;
  Result := ACount;
end;

function TCompressionStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  if (AOffset = 0) and (AOrigin = soCurrent) then begin
    Result := FZRec.total_in
  end else begin
    raise ECompressionError.CreateRes(@sInvalidStreamOp);
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
  if FZRec.total_in > 0 then exit;

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
  FZRec.next_in  := FBuffer;
  FZRec.avail_in := N;

  DCheck(inflateInitEx(FZRec, FStreamType));
end;

function TDecompressionStream.IdRead(var VBuffer: TIdBytes; AOffset,
  ACount: Integer): Longint;
begin
  FZRec.next_out := @VBuffer[AOffset];
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

      FZRec.avail_in := FStrm.Read(FBuffer, sizeof(FBuffer));
      if FZRec.avail_in = 0 then begin
        Break;
      end;
      FZRec.next_in := FBuffer;
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
  raise EDecompressionError.CreateRes(@sInvalidStreamOp);
end;

function TDecompressionStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
var
  I: Integer;
  Buf: array [0..4095] of Char;
  LOffset : Int64;
begin
  if (AOffset = 0) and (AOrigin = soBeginning) then
  begin
    DCheck(inflateReset(FZRec));
    FZRec.next_in := FBuffer;
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
    raise EDecompressionError.CreateRes(@sInvalidStreamOp);
  end;
  Result := FZRec.total_out;
end;

function TDecompressionStream.IsGZip: boolean;
begin
  Result := (FStreamType = zsGZip) and (FGZHeader.done = 1);
end;

end.
