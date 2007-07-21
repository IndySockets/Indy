unit IdCTypes;
interface
{$i IdCompilerDefines.inc}

{This unit should not contain ANY program code.  It is meant to be extremely 
thin.  The idea is that the unit will contain type mappings that used for headers
and API calls using the headers.  The unit is here because in cross-platform
headers, the types may not always be the same as they would for Win32 on x86
Intel architecture.  We also want to be completely compatiable with Borland
Delphi for Win32.}
{$IFDEF FPC}
uses
  ctypes;
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
  TIdC_UINT32 = cint32;
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

  {$ENDIF}
  {$IFNDEF FPC}
  //this is necessary because Borland still doesn't support QWord
  // (unsigned 64bit type).
  qword = Int64;

  TIdC_LONG  = LongInt;
  PIdC_LONG  = ^TIdC_LONG;
  TIdC_ULONG = LongWord;
  PIdC_ULONG = ^TIdC_ULONG;

  TIdC_LONGLONG = Int64;
  PIdC_LONGLONG = ^TIdC_ULONGLONG;
  TIdC_ULONGLONG = qword;
  PIdC_ULONGLONG = ^TIdC_ULONGLONG;

  TIdC_SHORT = smallint;
  PIdC_SHORT = ^TIdC_SHORT;
  TIdC_USHORT = Word;
  PIdC_USHORT = ^TIdC_USHORT;

  TIdC_INT   = LongInt;
  PIdC_INT   = ^TIdC_INT;
  TIdC_UINT  = LongWord;
  PIdC_UINT  = ^TIdC_UINT;

  TIdC_SIGNED = LongInt;
  PIdC_SIGNED = ^TIdC_SIGNED;
  TIdC_UNSIGNED = LongWord;
  PIdC_UNSIGNED = ^TIdC_UNSIGNED;

  TIdC_INT8 = shortint;
  PIdC_INT8  = ^TIdC_INT8;
  TIdC_UINT8 = byte;
  PIdC_UINT8 = ^TIdC_UINT8;

  TIdC_INT16 = smallint;
  PIdC_INT16 = ^TIdC_INT16;
  TIdC_UINT16 = word;
  PIdC_UINT16 = ^TIdC_UINT16;

  TIdC_INT32 = longint;
  PIdC_INT32 = ^TIdC_INT32;
  TIdC_UINT32 = longword;
  PIdC_UINT32 = ^TIdC_UINT32;

  TIdC_INT64 = Int64;
  PIdC_INT64 = ^TIdC_INT64;
  TIdC_UINT64 = qword;
  PIdC_UINT64 = ^TIdC_UINT64;

    TIdC_FLOAT = single;
  PIdC_FLOAT = ^TIdC_FLOAT;
  TIdC_DOUBLE = double;
  PIdC_DOUBLE = ^TIdC_DOUBLE;
  TIdC_LONGDOUBLE = extended;
  PIdC_LONGDOUBLE = ^TIdC_LONGDOUBLE;
  
  {$ENDIF}
    

implementation

end.
