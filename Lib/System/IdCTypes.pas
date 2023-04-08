unit IdCTypes;

interface

{$I IdCompilerDefines.inc}

{
This unit should not contain ANY program code.  It is meant to be extremely 
thin.  The idea is that the unit will contain type mappings that used for headers
and API calls using the headers.  The unit is here because in cross-platform
headers, the types may not always be the same as they would for Win32 on x86
Intel architecture.  We also want to be completely compatiable with Borland
Delphi for Win32.
}

{$IFDEF FPC}
uses
  ctypes
  {$IFDEF HAS_UNIT_UnixType}
  , UnixType
  {$ENDIF}
  ;
{$ELSE}
  // Delphi defines (P)SIZE_T and (P)SSIZE_T in the Winapi.Windows unit in
  // XE2+, but we don't want to pull in that whole unit here just to define
  // a few aliases...
  {
  ($IFDEF WINDOWS)
    ($IFDEF VCL_XE2_OR_ABOVE)
uses Winapi.Windows;
    ($ENDIF)
  ($ENDIF)
  }
{$ENDIF}

{
IMPORTANT!!!

The types below are defined to hide architecture differences for various C++
types while also making this header compile with Borland Delphi.
}
type 
  {$IFDEF FPC}

  TIdC_LONG  = cLong;
  PIdC_LONG  = pcLong;
  TIdC_ULONG = cuLong;
  PIdC_ULONG = pculong;

  TIdC_LONGLONG = clonglong;
  PIdC_LONGLONG = pclonglong;
  TIdC_ULONGLONG = culonglong;
  PIdC_ULONGLONG = pculonglong;

  TIdC_SHORT = cshort;
  PIdC_SHORT = pcshort;
  TIdC_USHORT = cuShort;
  PIdC_USHORT = pcuShort;
  
  TIdC_INT   = cInt;
  PIdC_INT   = pcInt;
  PPIdC_INT  = ^PIdC_INT;
  TIdC_UINT  = cUInt;
  PIdC_UINT  = pcUInt;

  TIdC_SIGNED = csigned;
  PIdC_SIGNED = pcsigned;  
  TIdC_UNSIGNED = cunsigned;
  PIdC_UNSIGNED = pcunsigned;

  TIdC_INT8 = cint8;
  PIdC_INT8  = pcint8;
  TIdC_UINT8 = cuint8;
  PIdC_UINT8 = pcuint8;

  TIdC_INT16 = cint16;
  PIdC_INT16 = pcint16;
  TIdC_UINT16 = cuint16;
  PIdC_UINT16 = pcuint16;

  TIdC_INT32 = cint32;
  PIdC_INT32 = pcint32;
  TIdC_UINT32 = cuint32;
  PIdC_UINT32 = pcuint32;

  TIdC_INT64 = cint64;
  PIdC_INT64 = pcint64;
  TIdC_UINT64 = cuint64;
  PIdC_UINT64 = pcuint64;

  TIdC_FLOAT = cfloat;
  PIdC_FLOAT = pcfloat;
  TIdC_DOUBLE = cdouble;
  PIdC_DOUBLE = pcdouble;
  TIdC_LONGDOUBLE = clongdouble;
  PIdC_LONGDOUBLE =  pclongdouble;

  {$IFDEF HAS_SIZE_T}
  TIdC_SIZET = size_t;
  {$ELSE}
    {$IFDEF HAS_PtrUInt}
  TIdC_SIZET = PtrUInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SIZET = TIdC_UINT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SIZET = TIdC_UINT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_PSIZE_T}
  PIdC_SIZET = psize_t;
  {$ELSE}
  PIdC_SIZET = ^TIdC_SIZET;
  {$ENDIF}

  {$IFDEF HAS_SSIZE_T}
  TIdC_SSIZET = ssize_t;
  {$ELSE}
    {$IFDEF HAS_PtrInt}
  TIdC_SSIZET = PtrInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SSIZET = TIdC_INT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SSIZET = TIdC_INT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_PSSIZE_T}
  // in ptypes.inc, pssize_t is missing, but pSSize is present, and it is defined as ^ssize_t...
  PIdC_SSIZET = {pssize_t}pSSize;
  {$ELSE}
  PIdC_SSIZET = ^TIdC_SSIZET;
  {$ENDIF}

  {$IFDEF HAS_TIME_T}
  TIdC_TIMET = time_t;
  {$ELSE}
    {$IFDEF HAS_PtrUInt}
  TIdC_TIMET = PtrUInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_TIMET = TIdC_UINT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_TIMET = TIdC_UINT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_PTIME_T}
  PIdC_TIMET = ptime_t;
  {$ELSE}
  PIdC_TIMET = ^TIdC_TIMET;
  {$ENDIF}

  PPPByte = ^PPByte;
  {$ELSE}

  // this is necessary because Borland still doesn't support QWord
  // (unsigned 64bit type).
  {$IFNDEF HAS_QWord}
  qword = {$IFDEF HAS_UInt64}UInt64{$ELSE}Int64{$ENDIF};
  {$ENDIF}

  TIdC_LONG  = LongInt;
  PIdC_LONG  = ^TIdC_LONG;
  TIdC_ULONG = LongWord;
  PIdC_ULONG = ^TIdC_ULONG;

  TIdC_LONGLONG = Int64;
  PIdC_LONGLONG = ^TIdC_LONGLONG;
  TIdC_ULONGLONG = QWord;
  PIdC_ULONGLONG = ^TIdC_ULONGLONG;

  TIdC_SHORT = Smallint;
  PIdC_SHORT = ^TIdC_SHORT;
  TIdC_USHORT = Word;
  PIdC_USHORT = ^TIdC_USHORT;

  TIdC_INT   = Integer;
  PIdC_INT   = ^TIdC_INT;
  PPIdC_INT  = ^PIdC_INT;
  TIdC_UINT  = Cardinal;
  PIdC_UINT  = ^TIdC_UINT;

  TIdC_SIGNED = Integer;
  PIdC_SIGNED = ^TIdC_SIGNED;
  TIdC_UNSIGNED = Cardinal;
  PIdC_UNSIGNED = ^TIdC_UNSIGNED;

  TIdC_INT8 = Shortint;
  PIdC_INT8  = ^TIdC_INT8{PShortint};
  TIdC_UINT8 = Byte;
  PIdC_UINT8 = ^TIdC_UINT8{PByte};

  TIdC_INT16 = Smallint;
  PIdC_INT16 = ^TIdC_INT16{PSmallint};
  TIdC_UINT16 = Word;
  PIdC_UINT16 = ^TIdC_UINT16{PWord};

  TIdC_INT32 = Integer;
  PIdC_INT32 = ^TIdC_INT32{PInteger};
  TIdC_UINT32 = Cardinal;
  PIdC_UINT32 = ^TIdC_UINT32{PCardinal};

  TIdC_INT64 = Int64;
  PIdC_INT64 = ^TIdC_INT64{PInt64};
  TIdC_UINT64 = QWord;
  PIdC_UINT64 = ^TIdC_UINT64{PQWord};

  TIdC_FLOAT = Single;
  PIdC_FLOAT = ^TIdC_FLOAT{PSingle};
  TIdC_DOUBLE = Double;
  PIdC_DOUBLE = ^TIdC_DOUBLE{PDouble};
  TIdC_LONGDOUBLE = Extended;
  PIdC_LONGDOUBLE = ^TIdC_LONGDOUBLE{PExtended};

  {.$IFDEF HAS_SIZE_T}
  //TIdC_SIZET = Winapi.Windows.SIZE_T;
  {.$ELSE}
    {$IFDEF HAS_NativeUInt}
  TIdC_SIZET = NativeUInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SIZET = TIdC_UINT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SIZET = TIdC_UINT64;
      {$ENDIF}
    {$ENDIF}
  {.$ENDIF}
  {.$IFDEF HAS_PSIZE_T}
  //PIdC_SIZET = Winapi.Windows.PSIZE_T;
  {.$ELSE}
  PIdC_SIZET = ^TIdC_SIZET;
  {.$ENDIF}

  {.$IFDEF HAS_SSIZE_T}
  //TIdC_SSIZET = Winapi.Windows.SSIZE_T;
  {.$ELSE}
    {$IFDEF HAS_NativeInt}
  TIdC_SSIZET = NativeInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SSIZET = TIdC_INT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SSIZET = TIdC_INT64;
      {$ENDIF}
    {$ENDIF}
  {.$ENDIF}
  {.$IFDEF HAS_PSSIZE_T}
  //PIdC_SSIZET = Winapi.Windows.PSSIZE_T;
  {.$ELSE}
  PIdC_SSIZET = ^TIdC_SSIZET;
  {.$ENDIF}

  {$IFDEF HAS_TIME_T}
  TIdC_TIMET = time_t;
  {$ELSE}
    {$IFDEF HAS_NativeUInt}
  TIdC_TIMET = NativeUInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_TIMET = TIdC_UINT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_TIMET = TIdC_UINT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_PTIME_T}
  PIdC_TIMET = PTIME_T;
  {$ELSE}
  PIdC_TIMET = ^TIdC_TIMET;
  {$ENDIF}

  // Some headers require this in D5 or earlier.
  // FreePascal already has this in its system unit.
  {$IFNDEF HAS_PByte}PByte = ^Byte;{$ENDIF}
  PPByte = ^PByte;
  PPPByte = ^PPByte;
  {$IFNDEF HAS_PWord}PWord = ^Word;{$ENDIF}
  {$ENDIF}

  TIdC_TM = record
    tm_sec: TIdC_INT;         (* seconds,  range 0 to 59          *)
    tm_min: TIdC_INT;         (* minutes, range 0 to 59           *)
    tm_hour: TIdC_INT;        (* hours, range 0 to 23             *)
    tm_mday: TIdC_INT;        (* day of the month, range 1 to 31  *)
    tm_mon: TIdC_INT;         (* month, range 0 to 11             *)
    tm_year: TIdC_INT;        (* The number of years since 1900   *)
    tm_wday: TIdC_INT;        (* day of the week, range 0 to 6    *)
    tm_yday: TIdC_INT;        (* day in the year, range 0 to 365  *)
    tm_isdst: TIdC_INT;       (* daylight saving time             *)
  end;
  PIdC_TM = ^TIdC_TM;
  PPIdC_TM = ^PIdC_TM;

implementation

end.
