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
  Rev 1.54    2/9/2005 8:45:38 PM  JPMugaas
  Should work.

  Rev 1.53    2/8/05 6:37:38 PM  RLebeau
  Added default value to ASize parameter of ReadStringFromStream()

  Rev 1.52    2/8/05 5:57:10 PM  RLebeau
  added AppendString(), CopyTIdLongWord(), and CopyTIdString() functions

  Rev 1.51    1/31/05 6:01:40 PM  RLebeau
  Renamed GetCurrentThreadHandle() to CurrentThreadId() and changed the return
  type from THandle to to TIdPID.

  Reworked conditionals for SetThreadName() and updated the implementation to
  support naming threads under DotNet.

  Rev 1.50    1/27/05 3:40:04 PM  RLebeau
  Updated BytesToShort() to actually use the AIndex parameter that was added
  earlier.

  Rev 1.49    1/24/2005 7:35:36 PM  JPMugaas
  Foxed ma,e om CopyTIdIPV6Address/

  Rev 1.48    1/17/2005 7:26:44 PM  JPMugaas
  Made an IPv6 address byte copy function.

  Rev 1.47    1/15/2005 6:01:38 PM  JPMugaas
  Removed some new procedures for extracting  int values from a TIdBytes and
  made some other procedures have an optional index paramter.

  Rev 1.46    1/13/05 11:11:20 AM  RLebeau
  Changed BytesToRaw() to pass TIdBytes by 'const' rather than by 'var'

  Rev 1.45    1/8/2005 3:56:58 PM  JPMugaas
  Added routiens for copying integer values to and from TIdBytes.  These are
  useful for some protocols.

  Rev 1.44    24/11/2004 16:26:24  ANeillans
  GetTickCount corrected, as per Paul Cooper's post in
  atozedsoftware.indy.general.

  Rev 1.43    11/13/04 10:47:28 PM  RLebeau
  Fixed compiler errors

  Rev 1.42    11/12/04 1:02:42 PM  RLebeau
  Added RawToBytesF() and BytesToRaw() functions

  Added asserts to BytesTo...() functions

  Rev 1.41    10/26/2004 8:20:02 PM  JPMugaas
  Fixed some oversights with conversion.  OOPS!!!

  Rev 1.40    10/26/2004 8:00:54 PM  JPMugaas
  Now uses TIdStrings for DotNET portability.

  Rev 1.39    2004.10.26 7:35:16 PM  czhower
  Moved IndyCat to CType in IdBaseComponent

  Rev 1.38    24/10/2004 21:29:52  ANeillans
  Corrected error in GetTickCount,
  was Result := Trunc(nTime / (Freq * 1000))
  should be Result := Trunc((nTime / Freq) * 1000)

  Rev 1.37    20/10/2004 01:08:20  CCostelloe
  Bug fix

  Rev 1.36    28.09.2004 20:36:58  Andreas Hausladen
  Works now with Delphi 5

    Rev 1.35    9/23/2004 11:36:04 PM  DSiders
  Modified Ticks function (Win32) to correct RangeOverflow error.  (Reported by
  Mike Potter)

  Rev 1.34    24.09.2004 02:16:04  Andreas Hausladen
  Added ReadTIdBytesFromStream and ReadCharFromStream function to supress .NET
  warnings.

  Rev 1.33    9/5/2004 2:55:00 AM  JPMugaas
  function BytesToWord(const AValue: TIdBytes): Word; was not listed in the
  interface.

  Rev 1.32    04.09.2004 17:12:56  Andreas Hausladen
  New PosIdx function (without pointers)

  Rev 1.31    27.08.2004 22:02:20  Andreas Hausladen
  Speed optimization ("const" for string parameters)
  rewritten PosIdx function with AStartPos = 0 handling
  new ToArrayF() functions (faster in native code because the TIdBytes array
  must have the required len before the ToArrayF function is called)

  Rev 1.30    24.08.2004 19:48:28  Andreas Hausladen
  Some optimizations
  Removed IFDEF for IdDelete and IdInsert

  Rev 1.29    8/17/2004 2:54:08 PM  JPMugaas
  Fix compiler warning about widening operends.  Int64 can sometimes incur a
  performance penalty.

  Rev 1.28    8/15/04 5:57:06 PM  RLebeau
  Tweaks to PosIdx()

  Rev 1.27    7/23/04 10:13:16 PM  RLebeau
  Updated ReadStringFromStream() to resize the result using the actual number
  of bytes read from the stream

    Rev 1.26    7/18/2004 2:45:38 PM  DSiders
  Added localization comments.

  Rev 1.25    7/9/04 4:25:20 PM  RLebeau
  Renamed ToBytes(raw) to RawToBytes() to fix an ambiquity error with
  ToBytes(TIdBytes)

  Rev 1.24    7/9/04 4:07:06 PM  RLebeau
  Compiler fix for TIdBaseStream.Write()

  Rev 1.23    09/07/2004 22:17:52  ANeillans
  Fixed IdGlobal.pas(761) Error: ';', ')' or '=' expected but ':=' found

  Rev 1.22    7/8/04 11:56:10 PM  RLebeau
  Added additional parameters to BytesToString()

  Bug fix for ReadStringFromStream()

  Updated TIdBaseStream.Write() to use ToBytes()

  Rev 1.21    7/8/04 4:22:36 PM  RLebeau
  Added ToBytes() overload for raw pointers under non-DotNet platfoms.

  Rev 1.20    2004.07.03 19:39:38  czhower
  UTF8

  Rev 1.19    6/15/2004 7:18:06 PM  JPMugaas
  IdInsert for stuff needing to call the Insert procedure.

  Rev 1.18    2004.06.13 8:06:46 PM  czhower
  .NET update

    Rev 1.17    6/11/2004 8:28:30 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.16    2004.06.08 7:11:14 PM  czhower
  Typo fix.

  Rev 1.15    2004.06.08 6:34:48 PM  czhower
  .NET bug with Ticks workaround.

  Rev 1.14    07/06/2004 21:30:32  CCostelloe
  Kylix 3 changes

  Rev 1.13    5/3/04 12:17:44 PM  RLebeau
  Updated ToBytes(string) and BytesToString() under DotNet to use
  System.Text.Encoding.ASCII instead of AnsiEncoding

  Rev 1.12    4/24/04 12:41:36 PM  RLebeau
  Conversion support to/from TIdBytes for Char values

  Rev 1.11    4/18/04 2:45:14 PM  RLebeau
  Conversion support to/from TIdBytes for Int64 values

  Rev 1.10    2004.04.08 4:50:06 PM  czhower
  Comments

  Rev 1.9    2004.04.08 1:45:42 AM  czhower
  tiny string optimization

  Rev 1.8    4/7/2004 3:20:50 PM  JPMugaas
  PosIdx was not working in DotNET.  In DotNET, it was returning a Pos value
  without adding the startvalue -1.  It was throwing off the FTP list parsers.

  Two uneeded IFDEF's were removed.

  Rev 1.7    2004.03.13 5:51:28 PM  czhower
  Fixed stack overflow in Sleep for .net

  Rev 1.6    3/6/2004 5:16:02 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.5    3/6/2004 4:54:12 PM  JPMugaas
  Write to const bug fix.

  Rev 1.4    2/17/2004 12:02:44 AM  JPMugaas
  A few routines that might be needed later for RFC 3490 support.

  Rev 1.3    2/16/2004 1:56:04 PM  JPMugaas
  Moved some routines here to lay the groundwork for RFC 3490 support.  Started
  work on RFC 3490 support.

  Rev 1.2    2/11/2004 5:12:30 AM  JPMugaas
  Moved IPv6 address definition here.

  I also made a function for converting a TIdBytes to an IPv6 address.

  Rev 1.1    2004.02.03 3:15:52 PM  czhower
  Updates to move to System.

  Rev 1.0    2004.02.03 2:28:30 PM  czhower
  Move

  Rev 1.91    2/1/2004 11:16:04 PM  BGooijen
  ToBytes

  Rev 1.90    2/1/2004 1:28:46 AM  JPMugaas
  Disabled IdPort functionality in DotNET.  It can't work there in it's current
  form and trying to get it to work will introduce more problems than it
  solves.  It was only used by the bindings editor and we did something
  different in DotNET so IdPorts wouldn't used there.

  Rev 1.89    2004.01.31 1:51:10 AM  czhower
  IndyCast for VB.

  Rev 1.88    30/1/2004 4:47:46 PM  SGrobety
  Added "WriteMemoryStreamToStream" to take care of Win32/dotnet difference in
  the TMemoryStream.Memory type and the Write buffer parameter

  Rev 1.87    1/30/2004 11:59:24 AM  BGooijen
  Added WriteTIdBytesToStream, because we can convert almost everything to
  TIdBytes, and TIdBytes couldn't be written to streams easily

  Rev 1.86    2004.01.27 11:44:36 PM  czhower
  .Net Updates

  Rev 1.85    2004.01.27 8:15:54 PM  czhower
  Fixed compile error + .net helper.

  Rev 1.84    27/1/2004 1:55:10 PM  SGrobety
  TIdStringStream introduced to fix a bug in DOTNET TStringStream
  implementation.

  Rev 1.83    2004.01.27 1:42:00 AM  czhower
  Added parameter check

  Rev 1.82    25/01/2004 21:55:40  CCostelloe
  Added portable IdFromBeginning/FromCurrent/FromEnd, to be used instead of
  soFromBeginning/soBeginning, etc.

  Rev 1.81    24/01/2004 20:18:46  CCostelloe
  Added IndyCompareStr (to be used in place of AnsiCompareStr for .NET
  compatibility)

  Rev 1.80    2004.01.23 9:56:30 PM  czhower
  CharIsInSet now checks length and returns false if no character.

  Rev 1.79    2004.01.23 9:49:40 PM  czhower
  CharInSet no longer accepts -1, was unneeded and redundant.

  Rev 1.78    1/22/2004 5:47:46 PM  SPerry
  fixed CharIsInSet

  Rev 1.77    2004.01.22 5:33:46 PM  czhower
  TIdCriticalSection

  Rev 1.76    2004.01.22 3:23:18 PM  czhower
  IsCharInSet

  Rev 1.75    2004.01.22 2:00:14 PM  czhower
  iif change

  Rev 1.74    14/01/2004 00:17:34  CCostelloe
  Added IndyLowerCase/IndyUpperCase to replace AnsiLowerCase/AnsiUpperCase for
  .NET code

  Rev 1.73    1/11/2004 9:50:54 PM  BGooijen
  Added ToBytes function for Socks

  Rev 1.72    2003.12.31 7:32:40 PM  czhower
  InMainThread now for .net too.

  Rev 1.71    2003.12.29 6:48:38 PM  czhower
  TextIsSame

  Rev 1.70    2003.12.28 1:11:04 PM  czhower
  Conditional typo fixed.

  Rev 1.69    2003.12.28 1:05:48 PM  czhower
  .Net changes.

  Rev 1.68    5/12/2003 9:11:00 AM  GGrieve
  Add WriteStringToStream

  Rev 1.67    5/12/2003 12:32:48 AM  GGrieve
  fix DotNet warnings

  Rev 1.66    22/11/2003 12:03:02 AM  GGrieve
  fix IdMultiPathFormData.pas implementation

  Rev 1.65    11/15/2003 1:15:36 PM  VVassiliev
  Move AppendByte from IdDNSCommon to IdCoreGlobal

  Rev 1.64    10/28/2003 8:43:48 PM  BGooijen
  compiles, and removed call to setstring

  Rev 1.63    2003.10.24 10:44:50 AM  czhower
  IdStream implementation, bug fixes.

  Rev 1.62    10/18/2003 4:53:18 PM  BGooijen
  Added ToHex

  Rev 1.61    2003.10.17 6:17:24 PM  czhower
  Some parts moved to stream

    Rev 1.60    10/15/2003 8:28:16 PM  DSiders
  Added localization comments.

  Rev 1.59    2003.10.14 9:27:12 PM  czhower
  Fixed compile erorr with missing )

  Rev 1.58    10/14/2003 3:31:04 PM  SPerry
  Modified ByteToHex() and IPv4ToHex

  Rev 1.57    10/13/2003 5:06:46 PM  BGooijen
  Removed local constant IdOctalDigits in favor of the unit constant. - attempt
  2

    Rev 1.56    10/13/2003 10:07:12 AM  DSiders
  Reverted prior change; local constant for IdOctalDigits is restored.

    Rev 1.55    10/12/2003 11:55:42 AM  DSiders
  Removed local constant IdOctalDigits in favor of the unit constant.

  Rev 1.54    2003.10.11 5:47:22 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.53    10/8/2003 10:14:34 PM  GGrieve
  add WriteStringToStream

  Rev 1.52    10/8/2003 9:55:30 PM  GGrieve
  Add IdDelete

  Rev 1.51    10/7/2003 11:33:30 PM  GGrieve
  Fix ReadStringFromStream

  Rev 1.50    10/7/2003 10:07:30 PM  GGrieve
  Get IdHTTP compiling for DotNet

  Rev 1.49    6/10/2003 5:48:48 PM  SGrobety
  DotNet updates

  Rev 1.48    10/5/2003 12:26:46 PM  BGooijen
  changed parameter names at some places

  Rev 1.47    10/4/2003 7:08:26 PM  BGooijen
  added some conversion routines type->TIdBytes->type, and fixed existing ones

  Rev 1.46    10/4/2003 3:53:40 PM  BGooijen
  added some ToBytes functions

  Rev 1.45    04/10/2003 13:38:28  HHariri
  Write(Integer) support

  Rev 1.44    10/3/2003 10:44:54 PM  BGooijen
  Added WriteBytesToStream

  Rev 1.43    2003.10.02 8:29:14 PM  czhower
  Changed names of byte conversion routines to be more readily understood and
  not to conflict with already in use ones.

  Rev 1.42    10/2/2003 5:15:16 PM  BGooijen
  Added Grahame's functions

  Rev 1.41    10/1/2003 8:02:20 PM  BGooijen
  Removed some ifdefs and improved code

  Rev 1.40    2003.10.01 9:10:58 PM  czhower
  .Net

  Rev 1.39    2003.10.01 2:46:36 PM  czhower
  .Net

  Rev 1.38    2003.10.01 2:30:36 PM  czhower
  .Net

  Rev 1.37    2003.10.01 12:30:02 PM  czhower
  .Net

  Rev 1.35    2003.10.01 1:12:32 AM  czhower
  .Net

  Rev 1.34    2003.09.30 7:37:14 PM  czhower
  Typo fix.

  Rev 1.33    30/9/2003 3:58:08 PM  SGrobety
  More .net updates

  Rev 1.31    2003.09.30 3:19:30 PM  czhower
  Updates for .net

  Rev 1.30    2003.09.30 1:22:54 PM  czhower
  Stack split for DotNet

  Rev 1.29    2003.09.30 12:09:36 PM  czhower
  DotNet changes.

  Rev 1.28    2003.09.30 10:36:02 AM  czhower
  Moved stack creation to IdStack
  Added DotNet stack.

  Rev 1.27    9/29/2003 03:03:28 PM  JPMugaas
  Changed CIL to DOTNET.

  Rev 1.26    9/28/2003 04:22:00 PM  JPMugaas
  IFDEF'ed out MemoryPos in NET because that will not work there.

  Rev 1.25    9/26/03 11:20:50 AM  RLebeau
  Updated defines used with SetThreadName() to allow it to work under BCB6.

  Rev 1.24    9/24/2003 11:42:42 PM  JPMugaas
  Minor changes to help compile under NET

  Rev 1.23    2003.09.20 10:25:42 AM  czhower
  Added comment and chaned for D6 compat.

  Rev 1.22    9/18/2003 07:43:12 PM  JPMugaas
  Moved GetThreadHandle to IdGlobals so the ThreadComponent can be in this
  package.

  Rev 1.21    9/8/2003 11:44:38 AM  JPMugaas
  Fix for problem that was introduced in an optimization.

  Rev 1.20    2003.08.19 1:54:34 PM  czhower
  Removed warning

  Rev 1.19    11/8/2003 6:25:44 PM  SGrobety
  IPv4ToDWord: Added overflow checking disabling ($Q+) and changed "* 256"  by
  "SHL 8".

  Rev 1.18    2003.07.08 2:41:42 PM  czhower
  This time I saved the file before checking in.

  Rev 1.16    7/1/2003 03:39:38 PM  JPMugaas
  Started numeric IP function API calls for more efficiency.

  Rev 1.15    2003.07.01 3:49:56 PM  czhower
  Added SetThreadName

    Rev 1.14    7/1/2003 12:03:56 AM  BGooijen
  Added functions to switch between IPv6 addresses in string and in
  TIdIPv6Address form

  Rev 1.13    6/30/2003 06:33:58 AM  JPMugaas
  Fix for range check error.

  Rev 1.12    6/27/2003 04:43:30 PM  JPMugaas
  Made IPv4ToDWord overload that returns a flag for an error message.
  Moved MakeCanonicalIPv4Address code into IPv4ToDWord because most of that
  simply reduces IPv4 addresses into a DWord.  That also should make the
  function more useful in reducing various alternative forms of IPv4 addresses
  down to DWords.

  Rev 1.11    6/27/2003 01:19:38 PM  JPMugaas
  Added MakeCanonicalIPv4Address for converting various IPv4 address forms
  (mentioned at http://www.pc-help.org/obscure.htm) into a standard dotted IP
  address.  Hopefully, we should soon support octal and hexidecimal addresses.

  Rev 1.9    6/27/2003 04:36:08 AM  JPMugaas
  Function for converting DWord to IP adcdress.

  Rev 1.8    6/26/2003 07:54:38 PM  JPMugaas
  Routines for converting standard dotted IPv4 addresses into dword,
  hexidecimal, and octal forms.

    Rev 1.7    5/11/2003 11:57:06 AM  BGooijen
  Added RaiseLastOSError

  Rev 1.6    4/28/2003 03:19:00 PM  JPMugaas
  Made a function for obtaining the services file FQN.  That's in case
  something else besides IdPorts needs it.

  Rev 1.5    2003.04.16 10:06:42 PM  czhower
  Moved DebugOutput to IdCoreGlobal

  Rev 1.4    12/29/2002 2:15:30 PM  JPMugaas
  GetCurrentThreadHandle function created as per Bas's instructions.  Moved
  THandle to IdCoreGlobal for this function.

  Rev 1.3    12-15-2002 17:02:58  BGooijen
  Added comments to TIdExtList

  Rev 1.2    12-15-2002 16:45:42  BGooijen
  Added TIdList

  Rev 1.1    29/11/2002 10:08:50 AM  SGrobety    Version: 1.1
  Changed GetTickCount to use high-performance timer if available under windows

  Rev 1.0    21/11/2002 12:36:18 PM  SGrobety    Version: Indy 10

  Rev 1.0    11/13/2002 08:41:24 AM  JPMugaas
}

unit IdGlobal;

interface

{$I IdCompilerDefines.inc}

uses
  SysUtils,
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFDEF FPC}
  windows,
    {$ELSE}
  Windows,
    {$ENDIF}
  {$ENDIF}
  Classes,
  syncobjs,
  {$IFDEF UNIX}
    {$IFDEF KYLIXCOMPAT}
    Libc,
    {$ELSE}
      {$IFDEF FPC}
      DynLibs, // better add DynLibs only for fpc
      {$ENDIF}
      {$IFDEF USE_VCL_POSIX}
      Posix.SysTypes, Posix.Pthread, Posix.Unistd,
      {$ENDIF}
      {$IFDEF USE_BASEUNIX}
      BaseUnix, Unix, Sockets, UnixType,
      {$ENDIF}
      {$IFDEF USE_ICONV_ENC}iconvenc, {$ENDIF}
      {$IFDEF USE_LCONVENC}LConvEncoding, {$ENDIF}
    {$ENDIF}
    {$IF DEFINED(OSX) AND (NOT DEFINED(FPC))}
    //RLebeau: FPC does not provide mach_timebase_info() and mach_absolute_time() yet...
    Macapi.Mach,
    {$IFEND}
  {$ENDIF}
  IdException;

// TODO: add a 'TId' prefix to the following types?

{$IF DEFINED(HAS_QWord) AND (NOT DEFINED(HAS_PQWord))}
type
  PQWord = ^QWord;
{$IFEND}

{$IFNDEF HAS_PInt8}
type
  PInt8 = {^Int8}PShortint;
  {$NODEFINE PInt8}
{$ENDIF}

{$IFNDEF HAS_PUInt8}
type
  PUInt8 = {^UInt8}PByte;
  {$NODEFINE PUInt8}
{$ENDIF}

{$IFNDEF HAS_PInt16}
type
  PInt16 = {^Int16}PSmallint;
  {$NODEFINE PInt16}
{$ENDIF}

{$IFNDEF HAS_PUInt16}
type
  PUInt16 = {^UInt16}PWord;
  {$NODEFINE PUInt16}
{$ENDIF}

{$IFNDEF HAS_PInt32}
type
  PInt32 = {^Int32}PInteger;
  {$NODEFINE PInt32}
{$ENDIF}

{$IFNDEF HAS_PUInt32}
type
  PUInt32 = {^UInt32}PCardinal;
  {$NODEFINE PUInt32}
{$ENDIF}

{$IFNDEF HAS_PUInt64}
type
  PUInt64 = ^UInt64;
  {$NODEFINE PUInt64}
{$ENDIF}

type
  TIdUInt64 = UInt64 deprecated 'Use UInt64';

const
  {This is the only unit with references to OS specific units and IFDEFs. NO OTHER units
  are permitted to do so except .pas files which are counterparts to dfm/xfm files, and only for
  support of that.}

  //We make the version things an Inc so that they can be managed independantly
  //by the package builder.
  {$I IdVers.inc}

  {$IFNDEF HAS_TIMEUNITS}
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
  {$ENDIF}

  // FPC's DynLibs unit is not included in this unit's interface 'uses' clause on
  // all platforms, so map to what DynLibs.NilHandle maps to...
  {$IFDEF FPC}
  IdNilHandle = {DynLibs.NilHandle}{$IFDEF WINDOWS}PtrUInt(0){$ELSE}PtrInt(0){$ENDIF};
  {$ELSE}
  IdNilHandle = THandle(0);
  {$ENDIF}

  LF = #10;
  CR = #13;

  // RLebeau: EOL is NOT to be used as a platform-specific line break!  Most
  // text-based protocols that Indy implements are defined to use CRLF line
  // breaks. DO NOT change this!  If you need a platform-based line break,
  // use sLineBreak instead.
  EOL = CR + LF;
  //
  CHAR0 = #0;
  BACKSPACE = #8;

  TAB = #9;
  CHAR32 = #32;

  //Timeout values
  IdTimeoutDefault = -1;
  IdTimeoutInfinite = -2;
  //Fetch Defaults
  IdFetchDelimDefault = ' ';    {Do not Localize}
  IdFetchDeleteDefault = True;
  IdFetchCaseSensitiveDefault = True;

  IdWhiteSpace = [0..12, 14..32]; {do not localize}

  IdHexDigits: array [0..15] of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'); {do not localize}
  IdOctalDigits: array [0..7] of Char = ('0','1','2','3','4','5','6','7'); {do not localize}
  IdHexPrefix = '0x';  {Do not translate}

type
  //thread and PID stuff
  {$IF DEFINED(UNIX)}

    {$IF DEFINED(KYLIXCOMPAT)}
  TIdPID = Int32;
  TIdThreadId = Int32;
  TIdThreadHandle = {$IFDEF FPC}TThreadID{$ELSE}UInt32{$ENDIF};
  TIdThreadPriority = {$IFDEF INT_THREAD_PRIORITY}-20..19{$ELSE}TThreadPriority{$ENDIF};

    {$ELSEIF DEFINED(USE_BASEUNIX)}
  TIdPID = TPid;
  TIdThreadId = TThreadId;
  TIdThreadHandle = TIdThreadId;
  TIdThreadPriority = TThreadPriority;

    {$ELSEIF DEFINED(USE_VCL_POSIX)}
  TIdPID = pid_t;
  TIdThreadId = NativeUInt;
  TIdThreadHandle = NativeUInt;
  TIdThreadPriority = {$IFDEF INT_THREAD_PRIORITY}-20..19{$ELSE}TThreadPriority{$ENDIF};
    {$IFEND}

  {$ELSEIF DEFINED(WINDOWS)}

  TIdPID = UInt32;
  TIdThreadId = UInt32;
  TIdThreadHandle = THandle;
    {$I IdSymbolPlatformOff.inc}
  TIdThreadPriority = TThreadPriority;
    {$I IdSymbolPlatformOn.inc}

  {$IFEND}

  TIdTicks = UInt64;

  {$IFDEF INT_THREAD_PRIORITY}
const
  // approximate values, its finer grained on Linux
  tpIdle = 19;
  tpLowest = 12;
  tpLower = 6;
  tpNormal = 0;
  tpHigher = -7;
  tpHighest = -13;
  tpTimeCritical = -20;
  {$ENDIF}
  {CH tpIdLowest = tpLowest; }
  {CH tpIdBelowNormal = tpLower; }
  {CH tpIdNormal = tpNormal; }
  {CH tpIdAboveNormal = tpHigher; }
  {CH tpIdHighest = tpHighest; }
  //end thread stuff

const
  //leave this as zero.  It's significant in many socket calls that specify ports
  DEF_PORT_ANY = 0;

type
  TIdUnicodeString = UnicodeString deprecated 'Use UnicodeString';

  // the Delphi next-gen compiler eliminates AnsiString/AnsiChar/PAnsiChar,
  // but we still need to deal with Ansi data. Unfortunately, the compiler
  // won't let us use its secret _AnsiChr types either, so we have to use
  // Byte instead unless we can find a better solution...

  {$IFDEF HAS_AnsiChar}
  TIdAnsiChar = AnsiChar;
  {$ELSE}
  TIdAnsiChar = Byte;
  {$ENDIF}

  {$IF DEFINED(HAS_PAnsiChar)}
  PIdAnsiChar = PAnsiChar;
  {$ELSEIF DEFINED(HAS_MarshaledAString)}
  PIdAnsiChar = MarshaledAString;
  {$ELSE}
  PIdAnsiChar = PByte;
  {$IFEND}

  {$IFDEF HAS_PPAnsiChar}
  PPIdAnsiChar = PPAnsiChar;
  {$ELSE}
  PPIdAnsiChar = ^PIdAnsiChar;
  {$ENDIF}
  PPPIdAnsiChar = ^PPIdAnsiChar;

  {$IFNDEF HAS_PRawByteString}
  {$EXTERNALSYM PRawByteString}
  PRawByteString = ^RawByteString;
  {$ENDIF}

  TIdWideChar = WideChar deprecated 'Use WideChar';
  PIdWideChar = PWideChar deprecated 'Use PWideChar';

  {$IFDEF WINDOWS}
  // Delphi 2009+ supports UNICODE strings natively!
  //
  // FreePascal 3.0.0+ supports UnicodeString, but maps its native
  // String type to UnicodeString only when {$MODE DelphiUnicode} or
  // {$MODESWITCH UnicodeStrings} is enabled.  However, UNICODE is not
  // defined in that mode yet until FreePascal's RTL has been updated to
  // support UnicodeString.  STRING_UNICODE_MISMATCH is defined in
  // IdCompilerDefines.inc when the compiler's native String/Char types do
  // not map to the same types that API functions are expecting based on
  // whether UNICODE is defined or not.  So we will create special Platform
  // typedefs here to help with API function calls when dealing with that
  // mismatch...
    {$IFDEF UNICODE}
  TIdPlatformString = UnicodeString;
  TIdPlatformChar = WideChar;
  PIdPlatformChar = PWideChar;
    {$ELSE}
  TIdPlatformString = AnsiString;
  TIdPlatformChar = TIdAnsiChar;
  PIdPlatformChar = PIdAnsiChar;
    {$ENDIF}
  {$ENDIF}

  TIdBytes = array of Byte;
  TIdWideChars = array of WideChar;

  //NOTE:  The code below assumes a 32bit Linux architecture (such as target i386-linux)

  // native signed and unsigned integer sized pointer types
  // TODO: drop the 'TId' prefix from the following types?

  {$IF DEFINED(HAS_NativeInt)}
  TIdNativeInt = NativeInt;
  {$ELSEIF DEFINED(CPU32)}
  TIdNativeInt = Int32;
  {$ELSEIF DEFINED(CPU64)}
  TIdNativeInt = Int64;
  {$IFEND}

  {$IF DEFINED(HAS_NativeUInt)}
  TIdNativeUInt = NativeUInt;
  {$ELSEIF DEFINED(CPU32)}
  TIdNativeUInt = UInt32;
  {$ELSEIF DEFINED(CPU64)}
  TIdNativeUInt = UInt64;
  {$IFEND}

  {$IFNDEF HAS_PtrInt}
  PtrInt = TIdNativeInt;
  {$ENDIF}
  {$IFNDEF HAS_PtrUInt}
  PtrUInt = TIdNativeUInt;
  {$ENDIF}

  TIdStreamSize = Int64 deprecated 'Use Int64';

  {$IFNDEF HAS_SIZE_T}
  {$EXTERNALSYM size_t}
  size_t = PtrUInt;
  {$ENDIF}

  {$IFNDEF HAS_PSIZE_T}
  {$EXTERNALSYM Psize_t}
  Psize_t = ^size_t;
  {$ENDIF}

  // RLebeau 12/1/2018: FPC's System unit defines an HMODULE type as a PtrUInt. But,
  // the DynLibs unit defines its own HModule type that is a TLibHandle, which is a
  // PtrInt instead. And to make matters worse, although FPC's System.THandle is a
  // platform-dependant type, it is not always defined as 8 bytes on 64bit platforms
  // (https://bugs.freepascal.org/view.php?id=21669), which has been known to cause
  // overflows when dynamic libraries are loaded at high addresses! (FPC bug?)  So,
  // we can't rely on THandle to hold correct handles for libraries that we load
  // dynamically at runtime (which is probably why FPC defines TLibHandle in the first
  // place, but why is it signed instead of unsigned?).
  //
  // Delphi's HMODULE is a System.THandle, which is a NativeUInt, and so is defined
  // with a proper byte size across all 32bit and 64bit platforms.
  //
  // Since (Safe)LoadLibrary(), GetProcAddress(), etc all use TLibHandle in FPC, but
  // use HMODULE in Delphi. this does mean we have a small descrepency between using
  // signed vs unsigned library handles.  I would prefer to use unsigned everywhere,
  // but we should use what is more natural for each compiler...

  // FPC's DynLibs unit is not included in this unit's interface 'uses' clause on all
  // platforms, so map to what DynLibs.TLibHandle maps to...

  // RLebeau 4/29/2020: to make metters worse, FPC defines TLibHandle as System.THandle
  // on Windows, not as PtrInt as previously observed!  And FPC's Windows.GetProcAddress()
  // uses HINST, which is also defined as System.THandle.  But, as we know from above,
  // FPC's System.THandle has problems on some 64bit systems! But does that apply on
  // Windows?  I THINK the latest FPC uses QWord/DWord (aka PtrUInt) for all Windows
  // platforms, which is good...

  {$IFDEF FPC}
  // TODO: use the THANDLE_(32|64|CPUBITS) defines in IdCompilerDefines.inc to decide
  // how to define TIdLibHandle when not using the DynLibs unit?
  TIdLibHandle = {DynLibs.TLibHandle}{$IFDEF WINDOWS}PtrUInt{$ELSE}PtrInt{$ENDIF};
  {$ELSE}
  TIdLibHandle = THandle;
  {$ENDIF}

  { IMPORTANT!!!

  WindowsCE only has a Unicode (WideChar) version of GetProcAddress.  We could use
  a version of GetProcAddress in the FreePascal dynlibs unit but that does a
  conversion from ASCII to Unicode which might not be necessary since most calls
  pass a constant anyway.
  }
  TIdLibFuncName = UnicodeString deprecated 'Use UnicodeString';
  PIdLibFuncNameChar = PWideChar deprecated 'Use PWideChar';

  {$IFDEF STRING_IS_IMMUTABLE}
  // In .NET and Delphi next-gen, strings are immutable (and zero-indexed), so we
  // need to use a StringBuilder whenever we need to modify individual characters
  // of a string...
  TIdStringBuilder = TStringBuilder deprecated 'Use TStringBuilder';
  {$ENDIF}

  {
  Delphi/C++Builder 2009+ have a TEncoding class which mirrors System.Text.Encoding
  in .NET, but does not have a TDecoder class which mirrors System.Text.Decoder
  in .NET.  TEncoding's interface changes from version to version, in some ways
  that cause compatibility issues when trying to write portable code, so we will
  not rely on it.  IIdTextEncoding is our own wrapper so we have control over
  text encodings.

  This way, Indy can have a unified internal interface for String<->Byte conversions
  without using IFDEFs everywhere.
  }

  {$IFNDEF HAS_IInterface}
  IInterface = IUnknown;
  {$ENDIF}

  IIdTextEncoding = interface(IInterface)
  ['{FA87FAE5-E3E3-4632-8FCA-2FB786848655}']
    function GetByteCount(const AChars: TIdWideChars): Integer; overload;
    function GetByteCount(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; overload;
    function GetByteCount(const AStr: UnicodeString): Integer; overload;
    function GetByteCount(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetBytes(const AChars: TIdWideChars): TIdBytes; overload;
    function GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload;
    function GetBytes(const AStr: UnicodeString): TIdBytes; overload;
    function GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): Integer; overload;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; overload;
    function GetChars(const ABytes: TIdBytes): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer): TIdWideChars; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; overload;
    function GetIsSingleByte: Boolean;
    function GetMaxByteCount(ACharCount: Integer): Integer;
    function GetMaxCharCount(AByteCount: Integer): Integer;
    function GetPreamble: TIdBytes;
    function GetString(const ABytes: TIdBytes): UnicodeString; overload;
    function GetString(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): UnicodeString; overload;
    function GetString(const ABytes: PByte; AByteCount: Integer): UnicodeString; overload;
    property IsSingleByte: Boolean read GetIsSingleByte;
  end;

  IdTextEncodingType = (encIndyDefault, encOSDefault, enc8Bit, encASCII, encUTF16BE, encUTF16LE, encUTF7, encUTF8);

  function IndyTextEncoding(AType: IdTextEncodingType): IIdTextEncoding; overload;
  function IndyTextEncoding(ACodepage: UInt16): IIdTextEncoding; overload;
  function IndyTextEncoding(const ACharSet: String): IIdTextEncoding; overload;
  {$IFDEF HAS_TEncoding}
  function IndyTextEncoding(AEncoding: TEncoding; AFreeEncoding: Boolean = False): IIdTextEncoding; overload;
  {$ENDIF}

  function IndyTextEncoding_Default: IIdTextEncoding;
  function IndyTextEncoding_OSDefault: IIdTextEncoding;
  function IndyTextEncoding_8Bit: IIdTextEncoding;
  function IndyTextEncoding_ASCII: IIdTextEncoding;
  function IndyTextEncoding_UTF16BE: IIdTextEncoding;
  function IndyTextEncoding_UTF16LE: IIdTextEncoding;
  function IndyTextEncoding_UTF7: IIdTextEncoding;
  function IndyTextEncoding_UTF8: IIdTextEncoding;

var
  {RLebeau: using ASCII by default because most Internet protocols that Indy
  implements are based on ASCII specifically, not Ansi.  Non-ASCII data has
  to be explicitally allowed by RFCs, in which case the caller should not be
  using nil IIdTextEncoding objects to begin with...}
  GIdDefaultTextEncoding: IdTextEncodingType = encASCII;

  {$IFDEF USE_ICONV}
  // This indicates whether encOSDefault should map to an OS dependant Ansi
  // locale or to ASCII.  Defaulting to ASCII for now to maintain compatibility
  // with earlier Indy 10 releases...
  GIdIconvUseLocaleDependantAnsiEncoding: Boolean = False;

  // This indicates whether Iconv should ignore characters that cannot be
  // converted.  Defaulting to false for now to maintain compatibility with
  // earlier Indy 10 releases...
  GIdIconvIgnoreIllegalChars: Boolean = False;

  // This indicates whether Iconv should transliterate characters that cannot
  // be converted.  Defaulting to false for now to maintain compatibility with
  // earlier Indy 10 releases...
  GIdIconvUseTransliteration: Boolean = False;
  {$ENDIF}

procedure EnsureEncoding(var VEncoding : IIdTextEncoding; ADefEncoding: IdTextEncodingType = encIndyDefault);
procedure CheckByteEncoding(var VBytes: TIdBytes; ASrcEncoding, ADestEncoding: IIdTextEncoding);
function GetEncodingCodePage(AEncoding: IIdTextEncoding): UInt16; deprecated;

type
  TIdAppendFileStream = class(TFileStream)
  public
    constructor Create(const AFile : String);
  end;

  TIdReadFileExclusiveStream = class(TFileStream)
  public
    constructor Create(const AFile : String);
  end;

  TIdReadFileNonExclusiveStream = class(TFileStream)
  public
    constructor Create(const AFile : String);
  end;

  TIdFileCreateStream = class(TFileStream)
  public
    constructor Create(const AFile : String);
  end;

  {$IFNDEF NO_REDECLARE}
 // TCriticalSection = SyncObjs.TCriticalSection;
  {$ENDIF}

  TIdLocalEvent = class(TEvent)
  public
    constructor Create(const AInitialState: Boolean = False;
     const AManualReset: Boolean = False); reintroduce;
    function WaitForEver: TWaitResult; overload;
  end;

  // This is here to reduce all the warnings about imports. We may also ifdef
  // it to provide a non warning implementatino on this unit too later.
  TIdCriticalSection = class(TCriticalSection)
  end;

  //Only needed for ToBytes(Short) and BytesToShort
  {$IFDEF UNIX}
  Short = Int16 deprecated 'Use Int16';
  {$ENDIF}
  {$IFNDEF NO_REDECLARE}
  PShort = ^Short;
  {$ENDIF}

  //This usually is a property editor exception
  EIdCorruptServicesFile = class(EIdException);
  EIdEndOfStream = class(EIdException);
  EIdInvalidIPv6Address = class(EIdException);
  EIdNoEncodingSpecified = class(EIdException);
  //This is called whenever there is a failure to retreive the time zone information
  EIdFailedToRetreiveTimeZoneInfo = class(EIdException);

  TIdPort = UInt16;

  //We don't have a native type that can hold an IPv6 address.
  {$NODEFINE TIdIPv6Address}
  TIdIPv6Address = array [0..7] of UInt16;

  // C++ does not allow an array to be returned by a function,
  // so wrapping the array in a struct as a workaround...
  //
  // This is one place where Word is being used instead of UInt16.
  // On OSX/iOS, UInt16 is defined in mactypes.h, not in System.hpp!
  // don't want to use a bunch of IFDEF's trying to figure out where
  // UInt16 is coming from...
  //
  {$IFDEF HAS_DIRECTIVE_HPPEMIT_NAMESPACE}
  {$HPPEMIT OPENNAMESPACE}
  {$ELSE}
  (*$HPPEMIT 'namespace Idglobal'*)
  (*$HPPEMIT '{'*)
  {$ENDIF
  (*$HPPEMIT '    struct TIdIPv6Address'*)
  (*$HPPEMIT '    {'*)
  (*$HPPEMIT '        ::System::Word data[8];'*)
  (*$HPPEMIT '        ::System::Word& operator[](int index) { return data[index]; }'*)
  (*$HPPEMIT '        const ::System::Word& operator[](int index) const { return data[index]; }'*)
  (*$HPPEMIT '        operator const ::System::Word*() const { return data; }'*)
  (*$HPPEMIT '        operator ::System::Word*() { return data; }'*)
  (*$HPPEMIT '    };'*)
  {$IFDEF HAS_DIRECTIVE_HPPEMIT_NAMESPACE}
  {$HPPEMIT CLOSENAMESPACE}
  {$ELSE}
  (*$HPPEMIT '}'*)
  {$ENDIF}

  {This way instead of a boolean for future expansion of other actions}
  TIdMaxLineAction = (maException, maSplit);
  TIdOSType = (otUnknown, otUnix, otWindows);
  //This is for IPv6 support when merged into the core
  TIdIPVersion = (Id_IPv4, Id_IPv6);

  TPosProc = function(const substr, str: String): Integer;
  TStrScanProc = function(Str: PChar; Chr: Char): PChar;
  TIdReuseSocket = (rsOSDependent, rsTrue, rsFalse);

  TIdBaseStream = class(TStream)
  protected
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; virtual; abstract;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; virtual; abstract;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; virtual; abstract;
    procedure IdSetSize(ASize: Int64); virtual; abstract;
    procedure SetSize(const NewSize: Int64); override;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end deprecated 'Use TStream';

  TIdCalculateSizeStream = class(TStream)
  protected
    FPosition: Int64;
    FSize: Int64;
    procedure SetSize(const NewSize: Int64); override;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

  TIdStreamReadEvent = procedure(var ABuffer; ACount: Longint; var VResult: Longint) of object;
  TIdStreamWriteEvent = procedure(const ABuffer; ACount: Longint; var VResult: Longint) of object;
  TIdStreamSeekEvent = procedure(const AOffset: Int64; AOrigin: TSeekOrigin; var VPosition: Int64) of object;
  TIdStreamSetSizeEvent = procedure(const ANewSize: Int64) of object;

  TIdEventStream = class(TStream)
  protected
    FOnRead: TIdStreamReadEvent;
    FOnWrite: TIdStreamWriteEvent;
    FOnSeek: TIdStreamSeekEvent;
    FOnSetSize: TIdStreamSetSizeEvent;
    procedure SetSize(const NewSize: Int64); override;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property OnRead: TIdStreamReadEvent read FOnRead write FOnRead;
    property OnWrite: TIdStreamWriteEvent read FOnWrite write FOnWrite;
    property OnSeek: TIdStreamSeekEvent read FOnSeek write FOnSeek;
    property OnSetSize: TIdStreamSetSizeEvent read FOnSetSize write FOnSetSize;
  end;

  {$IFDEF HAS_TPointerStream}

  TIdMemoryBufferStream = class(TPointerStream)
  public
    constructor Create(APtr: Pointer; ASize: TIdNativeInt); reintroduce;
  end;

  TIdReadOnlyMemoryBufferStream = class(TPointerStream)
  public
    constructor Create(APtr: Pointer; ASize: TIdNativeInt); reintroduce;
  end;

  {$ELSE}  

  TIdMemoryBufferStream = class(TCustomMemoryStream)
  public
    constructor Create(APtr: Pointer; ASize: TIdNativeInt);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

  TIdReadOnlyMemoryBufferStream = class(TIdMemoryBufferStream)
  public
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

  {$ENDIF}

const
  {$IF DEFINED(UNIX)}

  GOSType = otUnix;
  GPathDelim = '/'; {do not localize}
  INFINITE = UInt32($FFFFFFFF);     { Infinite timeout }

  {$ELSEIF DEFINED(WINDOWS)}

  GOSType = otWindows;
  GPathDelim = '\'; {do not localize}
  Infinite = Windows.INFINITE; { redeclare here for use elsewhere without using Windows.pas }  // cls modified 1/23/2002

  {$ELSE}

  GOSType = otUnknown;

  {$IFEND}

  // S.G. 4/9/2002: IP version general switch for defaults
  {$IFDEF IdIPv6}
  ID_DEFAULT_IP_VERSION = Id_IPv6;
  {$ELSE}
  ID_DEFAULT_IP_VERSION = Id_IPv4;
  {$ENDIF}

//The power constants are for processing IP addresses
//They are powers of 255.
const
  POWER_1 = $000000FF;
  POWER_2 = $0000FFFF;
  POWER_3 = $00FFFFFF;
  POWER_4 = $FFFFFFFF;

// utility functions to calculate the usable length of a given buffer.
// If ALength is <0 then the actual Buffer length is returned,
// otherwise the minimum of the two lengths is returned instead.
function IndyLength(const ABuffer: String; const ALength: Integer = -1; const AIndex: Integer = 1): Integer; overload;
function IndyLength(const ABuffer: TIdBytes; const ALength: Integer = -1; const AIndex: Integer = 0): Integer; overload;
function IndyLength(const ABuffer: TStream; const ALength: Int64 = -1): Int64; overload;

function IndyFormat(const AFormat: string; const Args: array of const): string;
function IndyIncludeTrailingPathDelimiter(const S: string): string; deprecated 'Use SysUtils.IncludeTrailingPathDelimiter()';
function IndyExcludeTrailingPathDelimiter(const S: string): string; deprecated 'Use SysUtils.ExcludeTrailingPathDelimiter()';

procedure IndyRaiseLastError;

// This can only be called inside of an 'except' block! This is so that
// Exception.RaiseOuterException() (when available) can capture the current
// exception into the InnerException property of a new Exception that is
// being raised...
procedure IndyRaiseOuterException(AOuterException: Exception);

//You could possibly use the standard StrInt and StrIntDef but these
//also remove spaces from the string using the trim functions.
function IndyStrToInt(const S: string): Integer; overload;
function IndyStrToInt(const S: string; ADefault: Integer): Integer; overload;

function IndyFileAge(const AFileName: string): TDateTime;
function IndyDirectoryExists(const ADirectory: string): Boolean; deprecated 'Use SysUtils.DirectoryExists()';

//You could possibly use the standard StrToInt and StrToInt64Def
//functions but these also remove spaces using the trim function
function IndyStrToInt64(const S: string; const ADefault: Int64): Int64; overload;
function IndyStrToInt64(const S: string): Int64;  overload;

//This converts the string to an Integer or Int64 depending on the bit size TStream uses
function IndyStrToStreamSize(const S: string; const ADefault: Int64): Int64; overload;
function IndyStrToStreamSize(const S: string): Int64; overload;

function AddMSecToTime(const ADateTime: TDateTime; const AMSec: Integer): TDateTime; deprecated 'Use DateUtils.IncMilliSecond()';

// To and From Bytes conversion routines
function ToBytes(const AValue: string; ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
function ToBytes(const AValue: string; const ALength: Integer; const AIndex: Integer = 1;
  ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
function ToBytes(const AValue: Char; ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
function ToBytes(const AValue: Int8): TIdBytes; overload;
function ToBytes(const AValue: UInt8): TIdBytes; overload;
function ToBytes(const AValue: Int16): TIdBytes; overload;
function ToBytes(const AValue: UInt16): TIdBytes; overload;
function ToBytes(const AValue: Int32): TIdBytes; overload;
function ToBytes(const AValue: UInt32): TIdBytes; overload;
function ToBytes(const AValue: Int64): TIdBytes; overload;
function ToBytes(const AValue: UInt64): TIdBytes; overload;
function ToBytes(const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0): TIdBytes; overload;
// RLebeau - not using the same "ToBytes" naming convention for RawToBytes()
// in order to prevent ambiquious errors with ToBytes(TIdBytes) above
function RawToBytes(const AValue; const ASize: Integer): TIdBytes;

// The following functions are faster but except that Bytes[] must have enough
// space for at least SizeOf(AValue) bytes.
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Char; ADestEncoding: IIdTextEncoding = nil); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int8); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt8); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int16); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt16); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int32); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt32); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int64); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt64); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0); overload;
// RLebeau - not using the same "ToBytesF" naming convention for RawToBytesF()
// in order to prevent ambiquious errors with ToBytesF(TIdBytes) above
procedure RawToBytesF(var Bytes: TIdBytes; const AValue; const ASize: Integer; const ADestIndex: Integer = 0);

function ToHex(const AValue: TIdBytes; const ACount: Integer = -1; const AIndex: Integer = 0): string; overload;
function ToHex(const AValue: array of UInt32): string; overload; // for IdHash
function BytesToString(const AValue: TIdBytes; AByteEncoding: IIdTextEncoding = nil): string; overload;
function BytesToString(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1; AByteEncoding: IIdTextEncoding = nil): string; overload;

// BytesToStringRaw() differs from BytesToString() in that it stores the
// byte octets as-is, whereas BytesToString() may decode character encodings
function BytesToStringRaw(const AValue: TIdBytes): string; overload;
function BytesToStringRaw(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1): string; overload;

function BytesToChar(const AValue: TIdBytes; const AIndex: Integer = 0; AByteEncoding: IIdTextEncoding = nil): Char; overload;
function BytesToChar(const AValue: TIdBytes; var VChar: Char; const AIndex: Integer = 0; AByteEncoding: IIdTextEncoding = nil): Integer; overload;
function BytesToInt16(const AValue: TIdBytes; const AIndex: Integer = 0): Int16;
function BytesToUInt16(const AValue: TIdBytes; const AIndex : Integer = 0): UInt16;
function BytesToInt32(const AValue: TIdBytes; const AIndex: Integer = 0): Int32;
function BytesToUInt32(const AValue: TIdBytes; const AIndex : Integer = 0): UInt32;
function BytesToInt64(const AValue: TIdBytes; const AIndex: Integer = 0): Int64;
function BytesToUInt64(const AValue: TIdBytes; const AIndex: Integer = 0): UInt64;

function BytesToIPv4Str(const AValue: TIdBytes; const AIndex: Integer = 0): String;
procedure BytesToIPv6(const AValue: TIdBytes; var VAddress: TIdIPv6Address; const AIndex: Integer = 0);
function BytesToTicks(const AValue: TIdBytes; const AIndex: Integer = 0): TIdTicks;
procedure BytesToRaw(const AValue: TIdBytes; var VBuffer; const ASize: Integer);

// TIdBytes utilities
procedure AppendBytes(var VBytes: TIdBytes; const AToAdd: TIdBytes; const AIndex: Integer = 0; const ALength: Integer = -1);
procedure AppendByte(var VBytes: TIdBytes; const AByte: Byte);
procedure AppendString(var VBytes: TIdBytes; const AStr: String; const ALength: Integer = -1; ADestEncoding: IIdTextEncoding = nil);
procedure ExpandBytes(var VBytes: TIdBytes; const AIndex: Integer; const ACount: Integer; const AFillByte: Byte = 0);
procedure InsertBytes(var VBytes: TIdBytes; const ADestIndex: Integer; const ASource: TIdBytes; const ASourceIndex: Integer = 0);
procedure InsertByte(var VBytes: TIdBytes; const AByte: Byte; const AIndex: Integer);
procedure RemoveBytes(var VBytes: TIdBytes; const ACount: Integer; const AIndex: Integer = 0);

// Common Streaming routines
function ReadLnFromStream(AStream: TStream; var VLine: String; AMaxLineLength: Integer = -1; AByteEncoding: IIdTextEncoding = nil): Boolean; overload;
function ReadLnFromStream(AStream: TStream; AMaxLineLength: Integer = -1; AExceptionIfEOF: Boolean = False; AByteEncoding: IIdTextEncoding = nil): string; overload;
function ReadStringFromStream(AStream: TStream; ASize: Integer = -1; AByteEncoding: IIdTextEncoding = nil): string; overload;
procedure WriteStringToStream(AStream: TStream; const AStr: string; ADestEncoding: IIdTextEncoding); overload;
procedure WriteStringToStream(AStream: TStream; const AStr: string; const ALength: Integer = -1; const AIndex: Integer = 1; ADestEncoding: IIdTextEncoding = nil); overload;
function ReadCharFromStream(AStream: TStream; var VChar: Char; AByteEncoding: IIdTextEncoding = nil): Integer;

// RLebeau: must use a 'var' and not an 'out' for the VBytes parameter,
// or else any preallocated buffer the caller passes in will get wiped out!
function ReadTIdBytesFromStream(const AStream: TStream; var VBytes: TIdBytes; const ACount: Int64; const AIndex: Integer = 0): Int64;
function WriteTIdBytesToStream(const AStream: TStream; const ABytes: TIdBytes; const ASize: Integer = -1; const AIndex: Integer = 0): Integer;
function SeekStream(const AStream: TStream; const AOffset: Int64; const AOrigin: TSeekOrigin): Int64; deprecated 'Use TStream.Seek()';

function ByteToHex(const AByte: Byte): string;
function ByteToOctal(const AByte: Byte): string;

function UInt32ToHex(const ALongWord : UInt32) : String;

procedure CopyTIdBytes(const ASource: TIdBytes; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer);

procedure CopyTIdByteArray(const ASource: array of Byte; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer);

procedure CopyTIdChar(const ASource: Char; var VDest: TIdBytes; const ADestIndex: Integer; ADestEncoding: IIdTextEncoding = nil);
procedure CopyTIdInt16(const ASource: Int16; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdUInt16(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdInt32(const ASource: Int32; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdUInt32(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdInt64(const ASource: Int64; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdUInt64(const ASource: UInt64; var VDest: TIdBytes; const ADestIndex: Integer);

procedure CopyTIdIPV6Address(const ASource: TIdIPv6Address; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdTicks(const ASource: TIdTicks; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdString(const ASource: String; var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer = -1; ADestEncoding: IIdTextEncoding = nil); overload;
procedure CopyTIdString(const ASource: String; const ASourceIndex: Integer; var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer = -1; ADestEncoding: IIdTextEncoding = nil); overload;

// Need to change prob not to use this set
function CharPosInSet(const AString: string; const ACharPos: Integer; const ASet: String): Integer; {$IFDEF STRING_IS_IMMUTABLE}overload;{$ENDIF}
function CharIsInSet(const AString: string; const ACharPos: Integer; const ASet: String): Boolean; {$IFDEF STRING_IS_IMMUTABLE}overload;{$ENDIF}
function CharIsInEOL(const AString: string; const ACharPos: Integer): Boolean; {$IFDEF STRING_IS_IMMUTABLE}overload;{$ENDIF}
function CharEquals(const AString: string; const ACharPos: Integer; const AValue: Char): Boolean; {$IFDEF STRING_IS_IMMUTABLE}overload;{$ENDIF}

{$IFDEF STRING_IS_IMMUTABLE}
function CharPosInSet(const ASB: TIdStringBuilder; const ACharPos: Integer; const ASet: String): Integer; overload;
function CharIsInSet(const ASB: TIdStringBuilder; const ACharPos: Integer; const ASet: String): Boolean; overload;
function CharIsInEOL(const ASB: TIdStringBuilder; const ACharPos: Integer): Boolean; overload;
function CharEquals(const ASB: TIdStringBuilder; const ACharPos: Integer; const AValue: Char): Boolean; overload;
{$ENDIF}

function ByteIndex(const AByte: Byte; const ABytes: TIdBytes; const AStartIndex: Integer = 0): Integer;
function ByteIdxInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Integer;
function ByteIsInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Boolean;
function ByteIsInEOL(const ABytes: TIdBytes; const AIndex: Integer): Boolean;

function CompareDate(const D1, D2: TDateTime): Integer;
function CurrentProcessId: TIdPID;

// RLebeau: the input of these functions must be in GMT
function DateTimeGMTToHttpStr(const GMTValue: TDateTime) : String;
function DateTimeGMTToCookieStr(const GMTValue: TDateTime; const AUseNetscapeFmt: Boolean = True) : String;
function DateTimeGMTToImapStr(const GMTValue: TDateTime) : String;

// RLebeau: the input of these functions must be in local time
function LocalDateTimeToHttpStr(const Value: TDateTime) : String;
function LocalDateTimeToCookieStr(const Value: TDateTime; const AUseNetscapeFmt: Boolean = True) : String;
function LocalDateTimeToImapStr(const Value: TDateTime) : String;
function LocalDateTimeToGMT(const Value: TDateTime; const AUseGMTStr: Boolean = False) : String;

procedure DebugOutput(const AText: string);
function Fetch(var AInput: string; const ADelim: string = IdFetchDelimDefault;
  const ADelete: Boolean = IdFetchDeleteDefault;
  const ACaseSensitive: Boolean = IdFetchCaseSensitiveDefault): string;
function FetchCaseInsensitive(var AInput: string; const ADelim: string = IdFetchDelimDefault;
  const ADelete: Boolean = IdFetchDeleteDefault): string;

// TODO: add an index parameter
procedure FillBytes(var VBytes : TIdBytes; const ACount : Integer; const AValue : Byte);

function CurrentThreadId: TIdThreadID;
function GetThreadHandle(AThread: TThread): TIdThreadHandle;

//GetTickDiff required because GetTickCount will wrap (IdICMP uses this)
function GetTickDiff(const AOldTickCount, ANewTickCount: UInt32): UInt32; deprecated 'Use GetTickDiff64()';
function GetTickDiff64(const AOldTickCount, ANewTickCount: TIdTicks): TIdTicks;

// Most operations that use tick counters will never run anywhere near the
// 49.7 day limit that UInt32 imposes.  If an operation really were to
// run that long, use GetElapsedTicks64()...
function GetElapsedTicks(const AOldTickCount: TIdTicks): UInt32;
function GetElapsedTicks64(const AOldTickCount: TIdTicks): TIdTicks;

procedure IdDelete(var s: string; AOffset, ACount: Integer); deprecated;
procedure IdInsert(const Source: string; var S: string; Index: Integer); deprecated;

type
  // TODO: use "array of Integer" instead?
  {$IFDEF HAS_GENERICS_TList}
  TIdPortList = TList<Integer>; // TODO: use TIdPort instead?
  {$ELSE}
  // TODO: flesh out to match TList<Integer> for non-Generics compilers
  TIdPortList = TList;
  {$ENDIF}

function IdPorts: TIdPortList;

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer; overload;
function iif(ATest: Boolean; const ATrue: string; const AFalse: string = ''): string; overload; { do not localize }
function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;
function iif(const AEncoding, ADefEncoding: IIdTextEncoding; ADefEncodingType: IdTextEncodingType = encASCII): IIdTextEncoding; overload;

function InMainThread: Boolean;
function IPv6AddressToStr(const AValue: TIdIPv6Address): string;

//Note that there is NO need for Big Endian byte order functions because
//that's done through HostToNetwork byte order functions.
function HostToLittleEndian(const AValue : UInt16) : UInt16; overload;
function HostToLittleEndian(const AValue : UInt32): UInt32; overload;
function HostToLittleEndian(const AValue : Int32): Int32; overload;

function LittleEndianToHost(const AValue : UInt16) : UInt16; overload;
function LittleEndianToHost(const AValue : UInt32): UInt32; overload;
function LittleEndianToHost(const AValue : Int32): Int32; overload;

procedure WriteMemoryStreamToStream(Src: TMemoryStream; Dest: TStream; Count: Int64);
function IsCurrentThread(AThread: TThread): boolean;
function IPv4ToUInt32(const AIPAddress: string): UInt32; overload;
function IPv4ToUInt32(const AIPAddress: string; var VErr: Boolean): UInt32; overload;
function IPv4ToHex(const AIPAddress: string; const ADotted: Boolean = False): string;
function IPv4ToOctal(const AIPAddress: string): string;
procedure IPv6ToIdIPv6Address(const AIPAddress: String; var VAddress: TIdIPv6Address); overload;
procedure IPv6ToIdIPv6Address(const AIPAddress: String; var VAddress: TIdIPv6Address; var VErr : Boolean); overload;
function IsAlpha(const AChar: Char): Boolean; overload;
function IsAlpha(const AString: String; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
function IsAlphaNumeric(const AChar: Char): Boolean; overload;
function IsAlphaNumeric(const AString: String; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
function IsASCII(const AByte: Byte): Boolean; overload;
function IsASCII(const ABytes: TIdBytes): Boolean; overload;
function IsASCIILDH(const AByte: Byte): Boolean; overload;
function IsASCIILDH(const ABytes: TIdBytes): Boolean; overload;
function IsHexidecimal(const AChar: Char): Boolean; overload;
function IsHexidecimal(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
function IsNumeric(const AChar: Char): Boolean; overload;
function IsNumeric(const AString: string): Boolean; overload;
function IsNumeric(const AString: string; const ALength: Integer; const AIndex: Integer = 1): Boolean; overload;
function IsOctal(const AChar: Char): Boolean; overload;
function IsOctal(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
function InterlockedExchangePtr(var VTarget: Pointer; const AValue: Pointer): Pointer;
function InterlockedExchangeTHandle(var VTarget: THandle; const AValue: THandle): THandle;
function InterlockedExchangeTLibHandle(var VTarget: TIdLibHandle; const AValue: TIdLibHandle): TIdLibHandle;
function InterlockedCompareExchangePtr(var VTarget: Pointer; const AValue, Compare: Pointer): Pointer;
function InterlockedCompareExchangeObj(var VTarget: TObject; const AValue, Compare: TObject): TObject;
function InterlockedCompareExchangeIntf(var VTarget: IInterface; const AValue, Compare: IInterface): IInterface;
function MakeCanonicalIPv4Address(const AAddr: string): string;
function MakeCanonicalIPv6Address(const AAddr: string): string;
function MakeUInt32IntoIPv4Address(const ADWord: UInt32): string;
function IndyMin(const AValueOne, AValueTwo: Int64): Int64; overload;
function IndyMin(const AValueOne, AValueTwo: Int32): Int32; overload;
function IndyMin(const AValueOne, AValueTwo: UInt16): UInt16; overload;
function IndyMax(const AValueOne, AValueTwo: Int64): Int64; overload;
function IndyMax(const AValueOne, AValueTwo: Int32): Int32; overload;
function IndyMax(const AValueOne, AValueTwo: UInt16): UInt16; overload;
function IPv4MakeUInt32InRange(const AInt: Int64; const A256Power: Integer): UInt32;
{$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
function IndyRegisterExpectedMemoryLeak(AAddress: Pointer): Boolean;
{$ENDIF}
function LoadLibFunction(const ALibHandle: TIdLibHandle; const AProcName: UnicodeString): Pointer;
{$IFDEF UNIX}
function HackLoad(const ALibName : String; const ALibVersions : array of String) : TIdLibHandle;
{$ENDIF}
function MemoryPos(const ASubStr: string; MemBuff: PChar; MemorySize: Integer): Integer;
// TODO: have OffsetFromUTC() return minutes as an integer instead, and
// then use DateUtils.IncMinutes() when adding the offset to a TDateTime...
function OffsetFromUTC: TDateTime;
function UTCOffsetToStr(const AOffset: TDateTime; const AUseGMTStr: Boolean = False): string;

function LocalTimeToUTCTime(const Value: TDateTime): TDateTime;
function UTCTimeToLocalTime(const Value: TDateTime): TDateTime;

function PosIdx(const ASubStr, AStr: string; AStartPos: UInt32 = 0): UInt32; //For "ignoreCase" use AnsiUpperCase
function PosInSmallIntArray(const ASearchInt: Int16; const AArray: array of Int16): Integer;
function PosInStrArray(const SearchStr: string; const Contents: array of string; const CaseSensitive: Boolean = True): Integer;
function ServicesFilePath: string;
procedure IndySetThreadPriority(AThread: TThread; const APriority: TIdThreadPriority; const APolicy: Integer = -MaxInt);
procedure SetThreadName(const AName: string; AThreadID: UInt32 = $FFFFFFFF);
procedure IndySleep(ATime: UInt32);

// TODO: create TIdStringPositionList for non-Nextgen compilers...
{$IFDEF USE_OBJECT_ARC}
type
  TIdStringPosition = record
    Value: String;
    Position: Integer;
    constructor Create(const AValue: String; const APosition: Integer);
  end;
  TIdStringPositionList = TList<TIdStringPosition>;
{$ENDIF}

//For non-Nextgen compilers: Integer(TStrings.Objects[i]) = column position in AData
//For Nextgen compilers: use SplitDelimitedString() overload if column positions are needed
procedure SplitDelimitedString(const AData: string; AStrings: TStrings; ATrim: Boolean; const ADelim: string = ' '{$IFNDEF USE_OBJECT_ARC}; AIncludePositions: Boolean = False{$ENDIF}); {$IFDEF USE_OBJECT_ARC}overload;{$ENDIF}  {Do not Localize}
{$IFDEF USE_OBJECT_ARC}
procedure SplitDelimitedString(const AData: string; AStrings: TIdStringPositionList; ATrim: Boolean; const ADelim: string = ' '); overload;  {Do not Localize}
{$ENDIF}

function StartsWithACE(const ABytes: TIdBytes): Boolean;
function StringsReplace(const S: String; const OldPattern, NewPattern: array of string): string;
function ReplaceAll(const S, OldPattern, NewPattern: string): string;
function ReplaceOnlyFirst(const S, OldPattern, NewPattern: string): string;
function TextIsSame(const A1, A2: string): Boolean;
function TextStartsWith(const S, SubS: string): Boolean;
function TextEndsWith(const S, SubS: string): Boolean;
function IndyUpperCase(const A1: string): string;
function IndyLowerCase(const A1: string): string;
function IndyCompareStr(const A1: string; const A2: string): Integer;
function Ticks: UInt32; deprecated 'Use Ticks64()';
function Ticks64: TIdTicks;
procedure ToDo(const AMsg: string);

function TwoByteToUInt16(AByte1, AByte2: Byte): UInt16;

function IndyAddPair(AStrings: TStrings; const AName, AValue: String): TStrings; overload;
function IndyAddPair(AStrings: TStrings; const AName, AValue: String; AObject: TObject): TStrings; overload;

function IndyIndexOf(AStrings: TStrings; const AStr: string; const ACaseSensitive: Boolean = False): Integer; overload;
function IndyIndexOf(AStrings: TStringList; const AStr: string; const ACaseSensitive: Boolean = False): Integer; overload;

function IndyIndexOfName(AStrings: TStrings; const AName: string; const ACaseSensitive: Boolean = False): Integer; overload;
function IndyIndexOfName(AStrings: TStringList; const AName: string; const ACaseSensitive: Boolean = False): Integer; overload;
function IndyValueFromName(AStrings: TStrings; const AName: String; const ACaseSensitive: Boolean = False): String;{$IFDEF HAS_TStringList_CaseSensitive} overload;{$ENDIF}
function IndyValueFromName(AStrings: TStringList; const AName: String; const ACaseSensitive: Boolean = False): String; overload;

function IndyValueFromIndex(AStrings: TStrings; const AIndex: Integer): String;

{$IFDEF WINDOWS}
function IndyWindowsMajorVersion: Integer;
function IndyWindowsMinorVersion: Integer;
function IndyWindowsBuildNumber: Integer;
function IndyWindowsPlatform: Integer;
function IndyCheckWindowsVersion(const AMajor: Integer; const AMinor: Integer = 0): Boolean;
{$ENDIF}

// For non-Nextgen compilers: IdDisposeAndNil is the same as FreeAndNil()
// For Nextgen compilers: IdDisposeAndNil calls TObject.DisposeOf() to ensure
// the object is freed immediately even if it has active references to it,
// for instance when freeing an Owned component

// Embarcadero changed the signature of FreeAndNil() in 10.4 Denali:
// procedure FreeAndNil(const [ref] Obj: TObject); inline;

// TODO: Change the signature of IdDisposeAndNil() to match FreeAndNil() in 10.4+...
procedure IdDisposeAndNil(var Obj); {$IFDEF USE_INLINE}inline;{$ENDIF}

//RLebeau: FPC does not provide mach_timebase_info() and mach_absolute_time() yet...
{$IF DEFINED(UNIX) AND DEFINED(OSX) AND DEFINED(FPC)}
type
  TTimebaseInfoData = record
    numer: UInt32;
    denom: UInt32;
  end;
{$IFEND}

var
  {$IFDEF UNIX}

  // For linux the user needs to set this variable to be accurate where used (mail, etc)
  GOffsetFromUTC: TDateTime = 0{$IFDEF USE_SEMICOLON_BEFORE_DEPRECATED};{$ENDIF} deprecated;

    {$IFDEF OSX}
  GMachTimeBaseInfo: TTimebaseInfoData;
    {$ENDIF}
  {$ENDIF}

  IndyPos: TPosProc = nil;

{$IFDEF UNIX}
const
  {$IF DEFINED(HAS_SharedSuffix)}
  LIBEXT = '.' + SharedSuffix; {do not localize}
  {$ELSEIF DEFINED(OSX) OR DEFINED(IOS)}
  LIBEXT = '.dylib'; {do not localize}
  {$ELSE}
  LIBEXT = '.so'; {do not localize}
  {$IFEND}
{$ENDIF}

implementation

{$IF DEFINED(UNIX) AND DEFINED(LINUX) AND DEFINED(FPC)}
  {$linklib rt}
{$IFEND}

{$IF (DEFINED(UNIX) AND (DEFINED(LINUX) OR DEFINED(FREEBSD))) OR DEFINED(ANDROID)}
  {$DEFINE USE_clock_gettime}
{$IFEND}

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysSocket,
  Posix.Time,
  Posix.SysTime,
    {$IFDEF OSX}
  Macapi.CoreServices,
    {$ENDIF}
  {$ENDIF}
  {$IF DEFINED(REGISTER_EXPECTED_MEMORY_LEAK) AND (NOT DEFINED(HAS_System_RegisterExpectedMemoryLeak))}
    {$IF DEFINED(USE_FASTMM4)}
  FastMM4,
    {$ELSEIF DEFINED(USE_MADEXCEPT)}
  madExcept,
    {$ELSEIF DEFINED(USE_LEAKCHECK)}
  LeakCheck,
    {$IFEND}
  {$IFEND}
  {$IFDEF USE_LIBC}Libc,{$ENDIF}
  DateUtils,
  //do not bring in our IdIconv unit if we are using the libc unit directly.
  {$IFDEF USE_ICONV_UNIT}IdIconv, {$ENDIF}
  IdResourceStrings
  {$IFNDEF HAS_System_Pos_Offset}
  ,StrUtils
  {$ENDIF}
  ;

{$IF DEFINED(FPC) AND DEFINED(WINCE)}
//FreePascal for WindowsCE may not define these.
const
  CP_UTF7 = 65000;
  CP_UTF8 = 65001;
{$IFEND}

{$IF DEFINED(REGISTER_EXPECTED_MEMORY_LEAK) AND (NOT DEFINED(HAS_System_RegisterExpectedMemoryLeak)) AND DEFINED(USE_FASTMM4)}
// RLebeau 7/5/2018: Prior to Delphi 2009+, FastMM manually defines several of
// Delphi's native types.  Most importantly, it defines PByte, which then causes
// problems for IIdTextEncoding implementations below.  So, lets make sure that
// our definitions below are using the same RTL types that their declarations
// above were using, and not use FastMM's types by mistake, otherwise we get
// compiler errors!
type
  PByte = System.PByte;
  //NativeInt = System.NativeInt;
  //NativeUInt = System.NativeUInt;
  //PNativeUInt = System.PNativeUInt;
  //UIntPtr = System.UIntPtr;
{$IFEND}

procedure EnsureEncoding(var VEncoding : IIdTextEncoding; ADefEncoding: IdTextEncodingType = encIndyDefault);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if VEncoding = nil then begin
    VEncoding := IndyTextEncoding(ADefEncoding);
  end;
end;

procedure CheckByteEncoding(var VBytes: TIdBytes; ASrcEncoding, ADestEncoding: IIdTextEncoding);
begin
  if ASrcEncoding <> ADestEncoding then begin
    VBytes := ADestEncoding.GetBytes(ASrcEncoding.GetChars(VBytes));
  end;
end;

{$IFNDEF WINDOWS}
//FreePascal may not define this for non-Windows systems.
//#define MAKEWORD(a, b)      ((WORD)(((BYTE)(a)) | ((WORD)((BYTE)(b))) << 8))
function MakeWord(const a, b : Byte) : Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := Word(a) or (Word(b) shl 8);
end;
{$ENDIF}

var
  // TODO: use "array of Integer" instead?
  GIdPorts: TIdPortList = nil;

  GIdOSDefaultEncoding: IIdTextEncoding = nil;
  GId8BitEncoding: IIdTextEncoding = nil;
  GIdASCIIEncoding: IIdTextEncoding = nil;
  GIdUTF16BigEndianEncoding: IIdTextEncoding = nil;
  GIdUTF16LittleEndianEncoding: IIdTextEncoding = nil;
  GIdUTF7Encoding: IIdTextEncoding = nil;
  GIdUTF8Encoding: IIdTextEncoding = nil;

{ IIdTextEncoding implementations }

type
  TIdTextEncodingBase = class(TInterfacedObject, IIdTextEncoding)
  protected
    FIsSingleByte: Boolean;
    FMaxCharSize: Integer;
  public
    function GetByteCount(const AChars: TIdWideChars): Integer; overload;
    function GetByteCount(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; overload; virtual; abstract;
    function GetByteCount(const AStr: UnicodeString): Integer; overload;
    function GetByteCount(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetBytes(const AChars: TIdWideChars): TIdBytes; overload;
    function GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload; virtual; abstract;
    function GetBytes(const AStr: UnicodeString): TIdBytes; overload;
    function GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): TIdBytes; overload;
    function GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): Integer; overload;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; overload; virtual; abstract;
    function GetChars(const ABytes: TIdBytes): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer): TIdWideChars; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer; overload;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; overload; virtual; abstract;
    function GetIsSingleByte: Boolean;
    function GetMaxByteCount(ACharCount: Integer): Integer; virtual; abstract;
    function GetMaxCharCount(AByteCount: Integer): Integer; virtual; abstract;
    function GetPreamble: TIdBytes; virtual;
    function GetString(const ABytes: TIdBytes): UnicodeString; overload;
    function GetString(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): UnicodeString; overload;
    function GetString(const ABytes: PByte; AByteCount: Integer): UnicodeString; overload;
  end;

  {$IF DEFINED(USE_ICONV) OR DEFINED(USE_LCONVENC)}
    {$DEFINE SUPPORTS_CHARSET_ENCODING}
  {$ELSE}
    {$UNDEF SUPPORTS_CHARSET_ENCODING}
  {$IFEND}

  {$IF (NOT DEFINED(SUPPORTS_CHARSET_ENCODING)) AND (DEFINED(WINDOWS) OR DEFINED(HAS_LocaleCharsFromUnicode))}
    {$DEFINE SUPPORTS_CODEPAGE_ENCODING}
  {$ELSE}
    {$UNDEF SUPPORTS_CODEPAGE_ENCODING}
  {$IFEND}

  TIdMBCSEncoding = class(TIdTextEncodingBase)
  private
    {$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
    FCharSet: String;
    {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
    FCodePage: UInt32;
    FMBToWCharFlags: UInt32;
    FWCharToMBFlags: UInt32;
    {$IFEND}
  public
    constructor Create; overload; virtual;
    {$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
    constructor Create(const CharSet: String); overload; virtual;
    {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
    constructor Create(CodePage: Integer); overload; virtual;
    constructor Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer); overload; virtual;
    {$IFEND}
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; overload; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; overload; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; overload; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdUTF7Encoding = class(TIdMBCSEncoding)
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
  end;

  TIdUTF8Encoding = class(TIdMBCSEncoding)
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdUTF16LittleEndianEncoding = class(TIdTextEncodingBase)
  public
    constructor Create; virtual;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; overload; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; overload; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; overload; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdUTF16BigEndianEncoding = class(TIdUTF16LittleEndianEncoding)
  public
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; overload; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdASCIIEncoding = class(TIdTextEncodingBase)
  public
    constructor Create; virtual;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
  end;

  // TODO: change TId8BitEncoding to derive from TIdByteRangeEncoding and use 1 range for 0x00..0xFF?
  TId8BitEncoding = class(TIdTextEncodingBase)
  public
    constructor Create; virtual;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
  end;

  PIdCodeUnitByteInfo = ^TIdCodeUnitByteInfo;
  TIdCodeUnitByteInfo = packed record
    Size: UInt8;
    FirstByte: Byte;
    FirstCU: UInt16;
  end;

  TIdByteRangeEncoding = class(TIdTextEncodingBase)
  protected
    FRanges: PIdCodeUnitByteInfo;
    FNumRanges: Integer;
    FCodePage: UInt16;
  public
    constructor Create(const ACodePage: UInt16; const ARanges: array of TIdCodeUnitByteInfo); virtual;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
    property CodePage: UInt16 read FCodePage;
  end;

  TIdTextEncoding_ISO_8859_1 = class(TIdByteRangeEncoding)
  public
    constructor Create; reintroduce;
  end;
  
  TIdTextEncoding_ISO_8859_2 = class(TIdByteRangeEncoding)
  public
    constructor Create; reintroduce;
  end;

  TIdTextEncoding_Windows1252 = class(TIdByteRangeEncoding)
  public
    constructor Create; reintroduce;
  end;

  // TODO: implement other common charsets...

  {$IFDEF HAS_TEncoding}
  TIdVCLEncoding = class(TIdTextEncodingBase)
  protected
    FEncoding: TEncoding;
    FFreeEncoding: Boolean;
  public
    constructor Create(AEncoding: TEncoding; AFreeEncoding: Boolean); overload;
    {$IFDEF HAS_TEncoding_GetEncoding_ByEncodingName}
    constructor Create(const ACharset: String); overload;
    {$ENDIF}
    constructor Create(const ACodepage: UInt16); overload;
    destructor Destroy; override;
    function GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar; ACharCount: Integer): Integer; override;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
  end;
  {$ENDIF}

{ TIdTextEncodingBase }

function ValidateChars(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): PWideChar;
var
  Len: Integer;
begin
  Len := Length(AChars);
  if (ACharIndex < 0) or (ACharIndex >= Len) then begin
    raise Exception.CreateResFmt(PResStringRec(@RSCharIndexOutOfBounds), [ACharIndex]);
  end;
  if ACharCount < 0 then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [ACharCount]);
  end;
  if (Len - ACharIndex) < ACharCount then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [ACharCount]);
  end;
  if ACharCount > 0 then begin
    Result := @AChars[ACharIndex];
  end else begin
    Result := nil;
  end;
end;

function ValidateBytes(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): PByte; overload;
var
  Len: Integer;
begin
  Len := Length(ABytes);
  if (AByteIndex < 0) or (AByteIndex >= Len) then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidDestinationIndex), [AByteIndex]);
  end;
  if (Len - AByteIndex) < AByteCount then begin
    raise Exception.CreateRes(PResStringRec(@RSInvalidDestinationArray));
  end;
  if AByteCount > 0 then begin
    Result := @ABytes[AByteIndex];
  end else begin
    Result := nil;
  end;
end;

function ValidateBytes(const ABytes: TIdBytes; AByteIndex, AByteCount, ANeeded: Integer): PByte; overload;
var
  Len: Integer;
begin
  Len := Length(ABytes);
  if (AByteIndex < 0) or (AByteIndex >= Len) then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidDestinationIndex), [AByteIndex]);
  end;
  if (Len - AByteIndex) < ANeeded then begin
    raise Exception.CreateRes(PResStringRec(@RSInvalidDestinationArray));
  end;
  if AByteCount > 0 then begin
    Result := @ABytes[AByteIndex];
  end else begin
    Result := nil;
  end;
end;

function ValidateStr(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): PWideChar;
begin
  if ACharIndex < 1 then begin
    raise Exception.CreateResFmt(PResStringRec(@RSCharIndexOutOfBounds), [ACharIndex]);
  end;
  if ACharCount < 0 then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [ACharCount]);
  end;
  if (Length(AStr) - ACharIndex + 1) < ACharCount then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [ACharCount]);
  end;
  if ACharCount > 0 then begin
    Result := @AStr[ACharIndex];
  end else begin
    Result := nil;
  end;
end;

function TIdTextEncodingBase.GetByteCount(const AChars: TIdWideChars): Integer;
begin
  if AChars <> nil then begin
    Result := GetByteCount(PWideChar(AChars), Length(AChars));
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetByteCount(const AChars: TIdWideChars;
  ACharIndex, ACharCount: Integer): Integer;
var
  LChars: PWideChar;
begin
  LChars := ValidateChars(AChars, ACharIndex, ACharCount);
  if LChars <> nil then begin
    Result := GetByteCount(LChars, ACharCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetByteCount(const AStr: UnicodeString): Integer;
begin
  if AStr <> '' then begin
    Result := GetByteCount(PWideChar(AStr), Length(AStr));
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetByteCount(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): Integer;
var
  LChars: PWideChar;
begin
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  if LChars <> nil then begin
    Result := GetByteCount(LChars, ACharCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetBytes(const AChars: TIdWideChars): TIdBytes;
begin
  if AChars <> nil then begin
    Result := GetBytes(PWideChar(AChars), Length(AChars));
  end else begin
    Result := nil;
  end;
end;

function TIdTextEncodingBase.GetBytes(const AChars: TIdWideChars;
  ACharIndex, ACharCount: Integer): TIdBytes;
var
  Len: Integer;
begin
  Result := nil;
  Len := GetByteCount(AChars, ACharIndex, ACharCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetBytes(@AChars[ACharIndex], ACharCount, PByte(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetBytes(const AChars: TIdWideChars;
  ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer;
begin
  Result := GetBytes(
    ValidateChars(AChars, ACharIndex, ACharCount),
    ACharCount, VBytes, AByteIndex);
end;

function TIdTextEncodingBase.GetBytes(const AChars: PWideChar; ACharCount: Integer): TIdBytes;
var
  Len: Integer;
begin
  Result := nil;
  Len := GetByteCount(AChars, ACharCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetBytes(AChars, ACharCount, PByte(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  var VBytes: TIdBytes; AByteIndex: Integer): Integer;
var
  Len, LByteCount: Integer;
  LBytes: PByte;
begin
  if (AChars = nil) and (ACharCount <> 0) then begin
    raise Exception.CreateRes(PResStringRec(@RSInvalidSourceArray));
  end;
  if (VBytes = nil) and (ACharCount <> 0) then begin
    raise Exception.CreateRes(PResStringRec(@RSInvalidDestinationArray));
  end;
  if ACharCount < 0 then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [ACharCount]);
  end;
  Len := Length(VBytes);
  LByteCount := GetByteCount(AChars, ACharCount);
  LBytes := ValidateBytes(VBytes, AByteIndex, Len, LByteCount);
  Dec(Len, AByteIndex);
  if (ACharCount > 0) and (Len > 0) then begin
    Result := GetBytes(AChars, ACharCount, LBytes, LByteCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetBytes(const AStr: UnicodeString): TIdBytes;
var
  Len: Integer;
begin
  Result := nil;
  Len := GetByteCount(AStr);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetBytes(PWideChar(AStr), Length(AStr), PByte(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer): TIdBytes;
var
  Len: Integer;
  LChars: PWideChar;
begin
  Result := nil;
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  if LChars <> nil then begin
    Len := GetByteCount(LChars, ACharCount);
    if Len > 0 then begin
      SetLength(Result, Len);
      GetBytes(LChars, ACharCount, PByte(Result), Len);
    end;
  end;
end;

function TIdTextEncodingBase.GetBytes(const AStr: UnicodeString; ACharIndex, ACharCount: Integer;
  var VBytes: TIdBytes; AByteIndex: Integer): Integer;
var
  LChars: PWideChar;
begin
  LChars := ValidateStr(AStr, ACharIndex, ACharCount);
  if LChars <> nil then begin
    Result := GetBytes(LChars, ACharCount, VBytes, AByteIndex);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetCharCount(const ABytes: TIdBytes): Integer;
begin
  if ABytes <> nil then begin
    Result := GetCharCount(PByte(ABytes), Length(ABytes));
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetCharCount(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): Integer;
var
  LBytes: PByte;
begin
  LBytes := ValidateBytes(ABytes, AByteIndex, AByteCount);
  if LBytes <> nil then begin
    Result := GetCharCount(LBytes, AByteCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetChars(const ABytes: TIdBytes): TIdWideChars;
begin
  if ABytes <> nil then begin
    Result := GetChars(PByte(ABytes), Length(ABytes));
  end else begin
    Result := nil;
  end;
end;

function TIdTextEncodingBase.GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdWideChars;
var
  Len: Integer;
begin
  Result := nil;
  Len := GetCharCount(ABytes, AByteIndex, AByteCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetChars(@ABytes[AByteIndex], AByteCount, PWideChar(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetChars(const ABytes: TIdBytes;
  AByteIndex, AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer;
var
  LBytes: PByte;
begin
  LBytes := ValidateBytes(ABytes, AByteIndex, AByteCount);
  if LBytes <> nil then begin
    Result := GetChars(LBytes, AByteCount, VChars, ACharIndex);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetChars(const ABytes: PByte; AByteCount: Integer): TIdWideChars;
var
  Len: Integer;
begin
  Len := GetCharCount(ABytes, AByteCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetChars(ABytes, AByteCount, PWideChar(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetChars(const ABytes: PByte; AByteCount: Integer;
  var VChars: TIdWideChars; ACharIndex: Integer): Integer;
var
  LCharCount: Integer;
begin
  if (ABytes = nil) and (AByteCount <> 0) then begin
    raise Exception.CreateRes(PResStringRec(@RSInvalidSourceArray));
  end;
  if AByteCount < 0 then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidCharCount), [AByteCount]);
  end;
  if (ACharIndex < 0) or (ACharIndex > Length(VChars)) then begin
    raise Exception.CreateResFmt(PResStringRec(@RSInvalidDestinationIndex), [ACharIndex]);
  end;
  LCharCount := GetCharCount(ABytes, AByteCount);
  if LCharCount > 0 then begin
    if (ACharIndex + LCharCount) > Length(VChars) then begin
      raise Exception.CreateRes(PResStringRec(@RSInvalidDestinationArray));
    end;
    Result := GetChars(ABytes, AByteCount, @VChars[ACharIndex], LCharCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncodingBase.GetIsSingleByte: Boolean;
begin
  Result := FIsSingleByte;
end;

function TIdTextEncodingBase.GetPreamble: TIdBytes;
begin
  SetLength(Result, 0);
end;

function TIdTextEncodingBase.GetString(const ABytes: TIdBytes): UnicodeString;
begin
  if ABytes <> nil then begin
    Result := GetString(PByte(ABytes), Length(ABytes));
  end else begin
    Result := '';
  end;
end;

function TIdTextEncodingBase.GetString(const ABytes: TIdBytes;
  AByteIndex, AByteCount: Integer): UnicodeString;
var
  Len: Integer;
begin
  Result := '';
  Len := GetCharCount(ABytes, AByteIndex, AByteCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetChars(@ABytes[AByteIndex], AByteCount, PWideChar(Result), Len);
  end;
end;

function TIdTextEncodingBase.GetString(const ABytes: PByte; AByteCount: Integer): UnicodeString;
var
  Len: Integer;
begin
  Result := '';
  Len := GetCharCount(ABytes, AByteCount);
  if Len > 0 then begin
    SetLength(Result, Len);
    GetChars(ABytes, AByteCount, PWideChar(Result), Len);
  end;
end;

{ TIdMBCSEncoding }

function IsCharsetASCII(const ACharSet: string): Boolean;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: when the IdCharsets unit is moved to the System
  // package, use CharsetToCodePage() here...
  Result := PosInStrArray(ACharSet,
      [
      'US-ASCII',                                      {do not localize}
      'ANSI_X3.4-1968',                                {do not localize}
      'iso-ir-6',                                      {do not localize}
      'ANSI_X3.4-1986',                                {do not localize}
      'ISO_646.irv:1991',                              {do not localize}
      'ASCII',                                         {do not localize}
      'ISO646-US',                                     {do not localize}
      'us',                                            {do not localize}
      'IBM367',                                        {do not localize}
      'cp367',                                         {do not localize}
      'csASCII'                                        {do not localize}
      ], False) <> -1;
end;


{$IF (NOT DEFINED(SUPPORTS_CHARSET_ENCODING)) AND (NOT DEFINED(HAS_LocaleCharsFromUnicode)) AND DEFINED(WINDOWS)}
  {$IFNDEF HAS_PLongBool}
type
  PLongBool = ^LongBool;
  {$ENDIF}

function LocaleCharsFromUnicode(CodePage, Flags: Cardinal;
  UnicodeStr: PWideChar; UnicodeStrLen: Integer; LocaleStr: PAnsiChar;
  LocaleStrLen: Integer; DefaultChar: PAnsiChar; UsedDefaultChar: PLongBool): Integer; overload;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := WideCharToMultiByte(CodePage, Flags, UnicodeStr, UnicodeStrLen, LocaleStr, LocaleStrLen, DefaultChar, PBOOL(UsedDefaultChar));
end;
  {$DEFINE HAS_LocaleCharsFromUnicode}
{$IFEND}

{$IF (NOT DEFINED(SUPPORTS_CHARSET_ENCODING)) AND (NOT DEFINED(HAS_UnicodeFromLocaleChars)) AND DEFINED(WINDOWS)}
function UnicodeFromLocaleChars(CodePage, Flags: Cardinal; LocaleStr: PAnsiChar;
  LocaleStrLen: Integer; UnicodeStr: PWideChar; UnicodeStrLen: Integer): Integer; overload;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := MultiByteToWideChar(CodePage, Flags, LocaleStr, LocaleStrLen, UnicodeStr, UnicodeStrLen);
end;
  {$DEFINE HAS_UnicodeFromLocaleChars}
{$IFEND}

constructor TIdMBCSEncoding.Create;
begin
  {$IF DEFINED(USE_ICONV)}
  Create(iif(GIdIconvUseLocaleDependantAnsiEncoding, 'char', 'ASCII')); {do not localize}
  {$ELSEIF DEFINED(USE_LCONVENC)}
  Create(GetDefaultTextEncoding());
  {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
  Create(CP_ACP, 0, 0);
  {$ELSE}
  ToDo('TIdMBCSEncoding constructor is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

{$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
constructor TIdMBCSEncoding.Create(const CharSet: String);
const
  // RLebeau: iconv() does not provide a maximum character byte size like
  // Microsoft does, so have to determine the max bytes by manually encoding
  // an actual Unicode codepoint.  We'll encode the largest codepoint that
  // UTF-16 supports, U+10FFFF, for now...
  //
  cValue: array[0..3] of Byte = ({$IFDEF ENDIAN_BIG}$DB, $FF, $DF, $FF{$ELSE}$FF, $DB, $FF, $DF{$ENDIF});
  //cValue: array[0..1] of UInt16 = ($DBFF, $DFFF);
begin
  inherited Create;

  // RLebeau 5/2/2017: have seen some malformed emails that use 'utf8'
  // instead of 'utf-8', so let's check for that...

  // RLebeau 9/27/2017: updating to handle a few more UTFs without hyphens...

  // RLebeau 7/6/2018: iconv does not have a way to query the highest Unicode
  // codepoint a charset supports, let alone the max bytes needed to encode such
  // a codepoint, so use known values for select charsets, and calculate
  // MaxCharSize dynamically for the rest...

  // TODO: normalize the FCharSet to make comparisons easier...

  case PosInStrArray(CharSet, ['UTF-7', 'UTF7', 'UTF-8', 'UTF8', 'UTF-16', 'UTF16', 'UTF-16LE', 'UTF16LE', 'UTF-16BE', 'UTF16BE', 'UTF-32', 'UTF32', 'UTF-32LE', 'UTF32LE', 'UTF-32BE', 'UTF32BE'], False) of {Do not Localize}
    0, 1: begin
      FCharSet := 'UTF-7';    {Do not Localize}
      FMaxCharSize := 5;
    end;
    2, 3: begin
      FCharSet := 'UTF-8';    {Do not Localize}
      FMaxCharSize := 4;
    end;
    4..7: begin
      FCharSet := 'UTF-16LE'; {Do not Localize}
      FMaxCharSize := 4;
    end;
    8, 9: begin
      FCharSet := 'UTF-16BE'; {Do not Localize}
      FMaxCharSize := 4;
    end;
    10..13: begin
      FCharSet := 'UTF-32LE'; {Do not Localize}
      FMaxCharSize := 4;
    end;
    14, 15: begin
      FCharSet := 'UTF-32BE'; {Do not Localize}
      FMaxCharSize := 4;
    end;
  else
    FCharSet := CharSet;
    if TextStartsWith(CharSet, 'ISO-8859') or           {Do not Localize}
       TextStartsWith(CharSet, 'Windows') or            {Do not Localize}
       TextStartsWith(CharSet, 'KOI8') or               {Do not Localize}
       IsCharsetASCII(CharSet) then
    begin
      FMaxCharSize := 1;
    end
    else begin
      FMaxCharSize := GetByteCount(PWideChar(@cValue[0]), 2);
      // Not all charsets support all codepoints.  For example, ISO-8859-1 does
      // not support U+10FFFF.  If GetByteCount() fails above, FMaxCharSize gets
      // set to 0, preventing any character conversions.  So force FMaxCharSize
      // to 1 if GetByteCount() fails, until a better solution can be found.
      // Maybe loop through the codepoints until we find the largest one that is
      // supported by this charset..
      if FMaxCharSize = 0 then begin
        FMaxCharSize := 1;
      end;
    end;
  end;

  FIsSingleByte := (FMaxCharSize = 1);
end;
{$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
constructor TIdMBCSEncoding.Create(CodePage: Integer);
begin
  Create(CodePage, 0, 0);
end;

// TODO: when was GetCPInfoEx() added to FreePascal?
{$IF (DEFINED(WINDOWS) AND (NOT DEFINED(WINCE))) AND
     NOT ((DEFINED(DCC) AND DEFINED(DCC_2009_OR_ABOVE)) OR DEFINED(FPC))}
type
  TCPInfoEx = record
    MaxCharSize: UINT;                       { max length (bytes) of a char }
    DefaultChar: array[0..MAX_DEFAULTCHAR - 1] of Byte; { default character }
    LeadByte: array[0..MAX_LEADBYTES - 1] of Byte;      { lead byte ranges }
    UnicodeDefaultChar: WideChar;
    Codepage: UINT;
    CodePageName: array[0..MAX_PATH -1] of {$IFDEF UNICODE}WideChar{$ELSE}AnsiChar{$ENDIF};
  end;

function GetCPInfoEx(CodePage: UINT; dwFlags: DWORD; var lpCPInfoEx: TCPInfoEx): BOOL; stdcall; external 'KERNEL32' name {$IFDEF UNICODE}'GetCPInfoExW'{$ELSE}'GetCPInfoExA'{$ENDIF};
{$IFEND}

constructor TIdMBCSEncoding.Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer);
{$IFNDEF WINDOWS}
const
  // RLebeau: have to determine the max bytes by manually encoding an actual
  // Unicode codepoint.  We'll encode the largest codepoint that UTF-16 supports,
  // U+10FFFF, for now...
  //
  cValue: array[0..1] of UInt16 = ($DBFF, $DFFF);
{$ELSE}
var
  LCPInfo: {$IFDEF WINCE}TCPInfo{$ELSE}TCPInfoEx{$ENDIF};
  LError: Boolean;
{$ENDIF}
begin
  inherited Create;

  FCodePage := CodePage;
  FMBToWCharFlags := MBToWCharFlags;
  FWCharToMBFlags := WCharToMBFlags;

  {$IFDEF FPC} // TODO: do this for Delphi 2009+, too...
  if FCodePage = CP_ACP then begin
    FCodePage := DefaultSystemCodePage;
  end;
  {$ENDIF}

  {$IFDEF WINDOWS}

  LError := not {$IFDEF WINCE}GetCPInfo(FCodePage, LCPInfo){$ELSE}GetCPInfoEx(FCodePage, 0, LCPInfo){$ENDIF};
  if LError and (FCodePage = 20127) then begin
    // RLebeau: 20127 is the official codepage for ASCII, but not
    // all OS versions support that codepage, so fallback to 1252
    // or even 437...
    LError := not {$IFDEF WINCE}GetCPInfo(1252, LCPInfo){$ELSE}GetCPInfoEx(1252, 0, LCPInfo){$ENDIF};
    // just in case...
    if LError then begin
      LError := not {$IFDEF WINCE}GetCPInfo(437, LCPInfo){$ELSE}GetCPInfoEx(437, 0, LCPInfo){$ENDIF};
    end;
  end;
  if LError then begin
    raise EIdException.CreateResFmt(PResStringRec(@RSInvalidCodePage), [FCodePage]); // TODO: create a new Exception class for this
  end;

  {$IFNDEF WINCE}
  FCodePage := LCPInfo.CodePage;
  {$ENDIF}
  FMaxCharSize := LCPInfo.MaxCharSize;

  {$ELSE}

  case FCodePage of
    65000: begin
      FMaxCharSize := 5;
    end;
    65001: begin
      FMaxCharSize := 4;
    end;
    1200: begin
      FMaxCharSize := 4;
    end;
    1201: begin
      FMaxCharSize := 4;
    end;
    // TODO: add support for UTF-32...
    // TODO: add cases for 'ISO-8859-X', 'Windows-X', 'KOI8-X', and ASCII charsets...
  else
    FMaxCharSize := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags, @cValue[0], 2, nil, 0, nil, nil);
    if FMaxCharSize < 1 then begin
      raise EIdException.CreateResFmt(@RSInvalidCodePage, [FCodePage]); // TODO: create a new Exception class for this
    end;
    // Not all charsets support all codepoints.  For example, ISO-8859-1 does
    // not support U+10FFFF.  If LocaleCharsFromUnicode() fails above,
    // FMaxCharSize gets set to 0, preventing any character conversions.  So
    // force FMaxCharSize to 1 if GetByteCount() fails, until a better solution
    // can be found.  Maybe loop through the codepoints until we find the largest
    // one that is supported by this codepage (though that will take time). Or
    // at least implement a lookup table for the more commonly used charsets...
    if FMaxCharSize = 0 then begin
      FMaxCharSize := 1;
    end;
  end;

  {$ENDIF}

  FIsSingleByte := (FMaxCharSize = 1);
end;
{$IFEND}

{$IFDEF USE_ICONV}
function CreateIconvHandle(const ACharSet: String; AToUTF16: Boolean): iconv_t;
const
  // RLebeau: iconv() outputs a UTF-16 BOM if data is converted to the generic
  // "UTF-16" charset.  We do not want that, so we will use the "UTF-16LE/BE"
  // charset explicitally instead so no BOM is outputted. This also saves us
  // from having to manually detect the presense of a BOM and strip it out.
  //
  // TODO: should we be using UTF-16LE or UTF-16BE on big-endian systems?
  // Delphi uses UTF-16LE, but what does FreePascal use? Let's err on the
  // side of caution until we know otherwise...
  //
  cUTF16CharSet = {$IFDEF ENDIAN_BIG}'UTF-16BE'{$ELSE}'UTF-16LE'{$ENDIF}; {do not localize}
var
  LToCharSet, LFromCharSet, LFlags: String;
  {$IFDEF USE_MARSHALLED_PTRS}
  M: TMarshaller;
  {$ENDIF}
begin
  // on some systems, //IGNORE must be specified before //TRANSLIT if they
  // are used together, otherwise //IGNORE gets ignored!
  LFlags := '';
  if GIdIconvIgnoreIllegalChars then begin
    LFlags := LFlags + '//IGNORE'; {do not localize}
  end;
  if GIdIconvUseTransliteration then begin
    LFlags := LFlags + '//TRANSLIT'; {do not localize}
  end;

  if AToUTF16 then begin
    LToCharSet := cUTF16CharSet + LFlags;
    LFromCharSet := ACharSet;
  end else begin
    LToCharSet := ACharSet + LFlags;
    LFromCharSet := cUTF16CharSet;
  end;

  Result := iconv_open(
    {$IFDEF USE_MARSHALLED_PTRS}
    M.AsAnsi(LToCharSet).ToPointer,
    M.AsAnsi(LFromCharSet).ToPointer
    {$ELSE}
    PAnsiChar(AnsiString(LToCharSet)), // explicit convert to Ansi
    PAnsiChar(AnsiString(LFromCharSet)) // explicit convert to Ansi
    {$ENDIF}
  );
  if Result = iconv_t(-1) then begin
    if LFlags <> '' then begin
      raise EIdException.CreateResFmt(@RSInvalidCharSetConvWithFlags, [ACharSet, cUTF16CharSet, LFlags]); // TODO: create a new Exception class for this
    end else begin
      raise EIdException.CreateResFmt(@RSInvalidCharSetConv, [ACharSet, cUTF16CharSet]); // TODO: create a new Exception class for this
    end;
  end;
end;

function CalcUTF16ByteSize(AChars: PWideChar; ACharCount: Integer): Integer;
var
  C: WideChar;
  LCount: Integer;
begin
  C := AChars^;
  if (C >= #$D800) and (C <= #$DFFF) then
  begin
    Result := 0;
    if C > #$DBFF then begin
      // invalid high surrogate
      Exit;
    end;
    if ACharCount = 1 then begin
      // missing low surrogate
      Exit;
    end;
    Inc(AChars);
    C := AChars^;
    if (C < #$DC00) or (C > #$DFFF) then begin
      // invalid low surrogate
      Exit;
    end;
    LCount := 2;
  end else begin
    LCount := 1;
  end;
  Result := LCount * SizeOf(WideChar);
end;
{$ENDIF}

{$IFDEF USE_ICONV}
function DoIconvCharsToBytes(const ACharset: string; AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer; ABytesIsTemp: Boolean): Integer;
var
  LSrcCharsPtr: PWideChar;
  LCharsPtr, LBytesPtr: PAnsiChar;
  LSrcCharSize, LCharSize, LByteSize: size_t;
  LCharsRead, LBytesWritten: Integer;
  LIconv: iconv_t;
begin
  Result := 0;

  if (AChars = nil) or (ACharCount < 1) or ((ABytes <> nil) and (AByteCount < 1)) then begin
    Exit;
  end;

  LIconv := CreateIconvHandle(ACharSet, False);
  try
    // RLebeau: iconv() does not allow for querying a pre-calculated byte size
    // for the input like Microsoft does, so have to determine the max bytes
    // by actually encoding the Unicode data to a real buffer.  When ABytesIsTemp
    // is True, we are encoding to a small local buffer so we don't have to use
    // a lot of memory. We also have to encode the input 1 Unicode codepoint at
    // a time to avoid iconv() returning an E2BIG error if multiple UTF-16
    // sequences were decoded to a length that would exceed the size of the
    // local buffer.

    // reset to initial state
    LByteSize := 0;
    if iconv(LIconv, nil, nil, nil, @LByteSize) = size_t(-1) then begin
      Exit;
    end;

    // do the conversion
    LSrcCharsPtr := AChars;
    repeat
      if LSrcCharsPtr <> nil then begin
        LSrcCharSize := CalcUTF16ByteSize(LSrcCharsPtr, ACharCount);
        if LSrcCharSize = 0 then begin
          Result := 0;
          Exit;
        end;
      end else begin
        LSrcCharSize := 0;
      end;

      LCharsPtr := PAnsiChar(LSrcCharsPtr);
      LCharSize := LSrcCharSize;
      LBytesPtr := PAnsiChar(ABytes);
      LByteSize := AByteCount;
      if iconv(LIconv, @LCharsPtr, @LCharSize, @LBytesPtr, @LByteSize) = size_t(-1) then
      begin
        Exit;
      end;

      // LByteSize was decremented by the number of bytes stored in the output buffer
      LBytesWritten := AByteCount - LByteSize;
      Inc(Result, LBytesWritten);
      if LSrcCharsPtr = nil then begin
        Exit;
      end;

      if not ABytesIsTemp then begin
        Inc(ABytes, LBytesWritten);
        Dec(AByteCount, LBytesWritten);
      end;

      // LCharSize was decremented by the number of bytes read from the input buffer
      LCharsRead := (LSrcCharSize-LCharSize) div SizeOf(WideChar);
      Inc(LSrcCharsPtr, LCharsRead);
      Dec(ACharCount, LCharsRead);
      if ACharCount < 1 then
      begin
        // After all characters are handled, the output buffer has to be flushed
        // This is done by running one more iteration, without an input buffer
        LSrcCharsPtr := nil;
      end;
    until False;
  finally
    iconv_close(LIconv);
  end;
end;
{$ENDIF}

{$IFDEF USE_LCONVENC}
function DoLconvCharsToBytes(const ACharset: string; AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  LTmpStr : UnicodeString;
  LUTF8, LConverted : RawByteString;
  LEncoded : Boolean;
begin
  Result := 0;

  if (AChars = nil) or (ACharCount < 1) or ((ABytes <> nil) and (AByteCount < 1)) then begin
    Exit;
  end;
  
  // TODO: encode the input chars directly to UTF-8 without
  // having to create a temp UnicodeString first...
  SetString(LTmpStr, WideChar(AChars), ACharCount);
  LUTF8 := UTF8Encode(LTmpStr);

  case PosInStrArray(ACharSet, ['UTF-8', 'UTF8', EncodingAnsi], False) of {do not localize}
    0, 1: begin
      // For UTF-8 to UTF-8, ConvertEncodingFromUTF8() does nothing and returns False (FPC bug?).
      // The input has already been converted above, so let's just use the existing bytes as-is...
      LConverted := LUTF8;
    end;
    2: begin
      // For UTF-8 to ANSI (system enc), ConvertEncodingFromUTF8() does nothing and returns False
      // if ConvertUTF8ToAnsi is not assigned, so let's just assume UTF-8 for now...
      LConverted := ConvertEncodingFromUTF8(LUTF8, ACharSet, LEncoded);
      if not LEncoded then begin
        LConverted := LUTF8;
      end;
    end;
  else
    LConverted := ConvertEncodingFromUTF8(LUTF8, ACharSet, LEncoded);
    if not LEncoded then begin
      // TODO: uncomment this?
      //raise EIdException.CreateResFmt(@RSInvalidCharSetConv, [ACharSet, cUTF16CharSet]); // TODO: create a new Exception class for this
      Exit;
    end;
  end;

  Result := Length(LConverted);

  if (ABytes <> nil) and (Result > 0) then begin
    Result := IndyMin(Result, AByteCount);
    // TODO: don't output partial character sequences...
    Move(PAnsiChar(LConverted)^, ABytes^, Result * SizeOf(AnsiChar));
  end;
end;
{$ENDIF}

function TIdMBCSEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  // TODO: size this dynamically to accomodate FMaxCharSize, plus some extra padding for safety...
  LBytes: array[0..7] of Byte;
{$ENDIF}
begin
  {$IF DEFINED(USE_ICONV)}
  Result := DoIconvCharsToBytes(FCharset, AChars, ACharCount, @LBytes[0], Length(LBytes), True);
  {$ELSEIF DEFINED(USE_LCONVENC)}
  Result := DoLconvCharsToBytes(FCharset, AChars, ACharCount, nil, 0);
  {$ELSEIF DEFINED(HAS_LocaleCharsFromUnicode)}
  Result := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags, AChars, ACharCount, nil, 0, nil, nil);
  {$ELSE}
  Result := 0;
  ToDo('TIdMBCSEncoding.GetByteCount() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function TIdMBCSEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer; ABytes: PByte;
  AByteCount: Integer): Integer;
begin
  {$IF DEFINED(USE_ICONV)}
  Assert (ABytes <> nil, 'TIdMBCSEncoding.GetBytes Bytes can not be nil');
  Result := DoIconvCharsToBytes(FCharset, AChars, ACharCount, ABytes, AByteCount, False);
  {$ELSEIF DEFINED(USE_LCONVENC)}
  Result := DoLconvCharsToBytes(FCharset, AChars, ACharCount, ABytes, AByteCount);
  {$ELSEIF DEFINED(HAS_LocaleCharsFromUnicode)}
  Result := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags, AChars, ACharCount, {$IFNDEF HAS_PAnsiChar}Pointer{$ELSE}PAnsiChar{$ENDIF}(ABytes), AByteCount, nil, nil);
  {$ELSE}
  Result := 0;
  ToDo('TIdMBCSEncoding.GetBytes() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

{$IFDEF USE_ICONV}
function DoIconvBytesToChars(const ACharset: string; const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer; AMaxCharSize: Integer; ACharsIsTemp: Boolean): Integer;
var
  LSrcBytesPtr: PByte;
  LBytesPtr, LCharsPtr: PAnsiChar;
  LByteSize, LCharsSize: size_t;
  I, LDestCharSize, LMaxBytesSize, LBytesRead, LCharsWritten: Integer;
  LConverted: Boolean;
  LIconv: iconv_t;
begin
  Result := 0;

  if (ABytes = nil) or (AByteCount = 0) or ((AChars <> nil) and (ACharCount < 1)) then begin
    Exit;
  end;

  LIconv := CreateIconvHandle(ACharset, True);
  try
    // RLebeau: iconv() does not allow for querying a pre-calculated character count
    // for the input like Microsoft does, so have to determine the max characters
    // by actually encoding the Ansi data to a real buffer.  If ACharsIsTemp is True
    // then we are encoding to a small local buffer so we don't have to use a lot of
    // memory.  We also have to encode the input 1 Unicode codepoint at a time to
    // avoid iconv() returning an E2BIG error if multiple MBCS sequences were decoded
    // to a length that would exceed the size of the local buffer.

    // reset to initial state
    LCharsSize := 0;
    if iconv(LIconv, nil, nil, nil, @LCharsSize) = size_t(-1) then
    begin
      Exit;
    end;

    // do the conversion
    LSrcBytesPtr := ABytes;
    repeat
      LMaxBytesSize := IndyMin(AByteCount, AMaxCharSize);
      LDestCharSize := ACharCount * SizeOf(WideChar);

      if LSrcBytesPtr = nil then
      begin
        LBytesPtr := nil;
        LByteSize := 0;
        LCharsPtr := PAnsiChar(AChars);
        LCharsSize := LDestCharSize;
        if iconv(LIconv, @LBytesPtr, @LByteSize, @LCharsPtr, @LCharsSize) = size_t(-1) then
        begin
          Result := 0;
        end else
        begin
          // LCharsSize was decremented by the number of bytes stored in the output buffer
          Inc(Result, (LDestCharSize-LCharsSize) div SizeOf(WideChar));
        end;
        Exit;
      end;

      // TODO: figure out a better way to calculate the number of input bytes
      // needed to generate a single UTF-16 output sequence...
      LMaxBytesSize := IndyMin(AByteCount, AMaxCharSize);
      LConverted := False;
      for I := 1 to LMaxBytesSize do
      begin
        LBytesPtr := PAnsiChar(LSrcBytesPtr);
        LByteSize := I;
        LCharsPtr := PAnsiChar(AChars);
        LCharsSize := LDestCharSize;
        if iconv(LIconv, @LBytesPtr, @LByteSize, @LCharsPtr, @LCharsSize) <> size_t(-1) then
        begin
          LConverted := True;

          // LCharsSize was decremented by the number of bytes stored in the output buffer
          LCharsWritten := (LDestCharSize-LCharsSize) div SizeOf(WideChar);
          Inc(Result, LCharsWritten);
          if LSrcBytesPtr = nil then begin
            Exit;
          end;

          if not ACharsIsTemp then begin
            Inc(AChars, LCharsWritten);
            Dec(ACharCount, LCharsWritten);
          end;

          // LByteSize was decremented by the number of bytes read from the input buffer
          LBytesRead := I - LByteSize;
          Inc(LSrcBytesPtr, LBytesRead);
          Dec(AByteCount, LBytesRead);
          if AByteCount < 1 then begin
            // After all bytes are handled, the output buffer has to be flushed
            // This is done by running one more iteration, without an input buffer
            LSrcBytesPtr := nil;
          end;

          Break;
        end;
      end;

      if not LConverted then begin
        Result := 0;
        Exit;
      end;
    until False;
  finally
    iconv_close(LIconv);
  end;
end;
{$ENDIF}

{$IFDEF USE_LCONVENC}
function DoLconvBytesToChars(const ACharset: string; const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
var
  LBytes, LConverted: RawByteString;
  LDecoded : UnicodeString;
  LEncoded : Boolean;
  C: WideChar;
begin
  Result := 0;

  if (ABytes = nil) or (AByteCount < 1) or ((AChars <> nil) and (ACharCount < 1)) then begin
    Exit;
  end;

  SetString(LBytes, PAnsiChar(ABytes), AByteCount);

  case PosInStrArray(ACharSet, ['UTF-8', 'UTF8', EncodingAnsi], False) of {do not localize}
    0, 1: begin
      // For UTF-8 to UTF-8, ConvertEncodingToUTF8() does nothing and returns False (FPC bug?).
      // The input is already in UTF-8, so let's just use the existing bytes as-is...
      LConverted := LBytes;
    end;
    2: begin
      // For ANSI (system enc) to UTF-8, ConvertEncodingToUTF8() does nothing and returns False
      // if ConvertAnsiToUTF8 is not assigned, so let's just assume UTF-8 for now...
      LConverted := ConvertEncodingToUTF8(LBytes, ACharSet, LEncoded);
      if not LEncoded then begin
        LConverted := LBytes;
      end;
    end;
  else
    LConverted := ConvertEncodingToUTF8(LBytes, ACharSet, LEncoded);
    if not LEncoded then begin
      // TODO: uncomment this?
      //raise EIdException.CreateResFmt(@RSInvalidCharSetConv, [ACharSet, cUTF16CharSet]); // TODO: create a new Exception class for this
      Exit;
    end;
  end;

  // TODO: decode the UTF-8 directly to the output chars without
  // having to create a temp UnicodeString first...
  LDecoded := UTF8Decode(LConverted);
  Result := Length(LDecoded);

  if (AChars <> nil) and (Result > 0) then begin
    Result := IndyMin(Result, ACharCount);
    // RLebeau: if the last encoded character is a UTF-16 high surrogate, don't output it...
    if Result > 0 then begin
      C := LDecoded[Result];
      if (C >= #$D800) and (C <= #$DBFF) then begin
        Dec(Result);
      end;
    end;
    Move(PWideChar(LDecoded)^, AChars^, Result * SizeOf(WideChar));
  end;
end;
{$ENDIF}

function TIdMBCSEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  LChars: array[0..3] of WideChar;
{$ENDIF}
begin
  {$IF DEFINED(USE_ICONV)}
  Result := DoIconvBytesToChars(FCharSet, ABytes, AByteCount, @LChars[0], Length(LChars), FMaxCharSize, True);
  {$ELSEIF DEFINED(USE_LCONVENC)}
  Result := DoLconvBytesToChars(FCharSet, ABytes, AByteCount, nil, 0);
  {$ELSEIF DEFINED(HAS_UnicodeFromLocaleChars)}
  Result := UnicodeFromLocaleChars(FCodePage, FMBToWCharFlags, {$IFNDEF HAS_PAnsiChar}Pointer{$ELSE}PAnsiChar{$ENDIF}(ABytes), AByteCount, nil, 0);
  {$ELSE}
  Result := 0;
  ToDo('TIdMBCSEncoding.GetCharCount() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function TIdMBCSEncoding.GetChars(const ABytes: PByte; AByteCount: Integer; AChars: PWideChar;
  ACharCount: Integer): Integer;
begin
  {$IF DEFINED(USE_ICONV)}
  Result := DoIconvBytesToChars(FCharSet, ABytes, AByteCount, AChars, ACharCount, FMaxCharSize, False);
  {$ELSEIF DEFINED(USE_LCONVENC)}
  Result := DoLconvBytesToChars(FCharSet, ABytes, AByteCount, AChars, ACharCount);
  {$ELSEIF DEFINED(HAS_UnicodeFromLocaleChars)}
  Result := UnicodeFromLocaleChars(FCodePage, FMBToWCharFlags, {$IFNDEF HAS_PAnsiChar}Pointer{$ELSE}PAnsiChar{$ENDIF}(ABytes), AByteCount, AChars, ACharCount);
  {$ELSE}
  Result := 0;
  ToDo('TIdMBCSEncoding.GetChars() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function TIdMBCSEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * FMaxCharSize;
end;

function TIdMBCSEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

function TIdMBCSEncoding.GetPreamble: TIdBytes;
begin
  {$IF DEFINED(SUPPORTS_CHARSET_ENCODING}
  // RLebeau 5/2/2017: have seen some malformed emails that use 'utf8'
  // instead of 'utf-8', so let's check for that...

  // RLebeau 9/27/2017: updating to handle a few more UTFs without hyphens...

  // TODO: normalize the FCharSet to make comparisons easier...

  case PosInStrArray(FCharSet, ['UTF-8', 'UTF8', 'UTF-16', 'UTF16', 'UTF-16LE', 'UTF16LE', 'UTF-16BE', 'UTF16BE', 'UTF-32', 'UTF32', 'UTF-32LE', 'UTF32LE', 'UTF-32BE', 'UTF32BE'], False) of {do not localize}
    0, 1: begin
      SetLength(Result, 3);
      Result[0] := $EF;
      Result[1] := $BB;
      Result[2] := $BF;
    end;
    2..5: begin
      SetLength(Result, 2);
      Result[0] := $FF;
      Result[1] := $FE;
    end;
    6, 7: begin
      SetLength(Result, 2);
      Result[0] := $FE;
      Result[1] := $FF;
    end;
    8..11: begin
      SetLength(Result, 4);
      Result[0] := $FF;
      Result[1] := $FE;
      Result[2] := $00;
      Result[3] := $00;
    end;
    12, 13: begin
      SetLength(Result, 4);
      Result[0] := $00;
      Result[1] := $00;
      Result[2] := $FE;
      Result[3] := $FF;
    end;
  else
    SetLength(Result, 0);
  end;
  {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
  case FCodePage of
    CP_UTF8: begin
      SetLength(Result, 3);
      Result[0] := $EF;
      Result[1] := $BB;
      Result[2] := $BF;
    end;
    1200: begin
      SetLength(Result, 2);
      Result[0] := $FF;
      Result[1] := $FE;
    end;
    1201: begin
      SetLength(Result, 2);
      Result[0] := $FE;
      Result[1] := $FF;
    end;
    12000: begin
      SetLength(Result, 4);
      Result[0] := $FF;
      Result[1] := $FE;
      Result[2] := $00;
      Result[3] := $00;
    end;
    12001: begin
      SetLength(Result, 4);
      Result[0] := $00;
      Result[1] := $00;
      Result[2] := $FE;
      Result[3] := $FF;
    end;
  else
    SetLength(Result, 0);
  end;
  {$ELSE}
  SetLength(Result, 0);
  ToDo('TIdMBCSEncoding.GetPreamble() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

{ TIdUTF7Encoding }

constructor TIdUTF7Encoding.Create;
begin
  {$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
  // RLebeau 7/6/2018: iconv does not have a way to query the highest Unicode codepoint
  // a charset supports, let alone the max bytes needed to encode such a codepoint, so
  // the inherited constructor tries to calculate MaxCharSize dynamically, which doesn't
  // work very well for most charsets.  Since we already know the exact value to use for
  // this charset, let's just skip the inherited constructor and hard-code the value here...
  //
  //inherited Create('UTF-7'); {do not localize}
  FCharSet := 'UTF-7'; {do not localize};
  FIsSingleByte := False;
  FMaxCharSize := 5;
  {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
  inherited Create(CP_UTF7);
  {$ELSE}
  ToDo('TIdUTF7Encoding constructor is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function TIdUTF7Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount * 3) + 2;
end;

function TIdUTF7Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

{ TIdUTF8Encoding }

// TODO: implement UTF-8 manually so we don't have to deal with codepage issues...

constructor TIdUTF8Encoding.Create;
begin
  {$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
  // RLebeau 7/6/2018: iconv does not have a way to query the highest Unicode codepoint
  // a charset supports, let alone the max bytes needed to encode such a codepoint, so
  // the inherited constructor tries to calculate MaxCharSize dynamically, which doesn't
  // work very well for most charsets.  Since we already know the exact value to use for
  // this charset, let's just skip the inherited constructor and hard-code the value here...
  //
  //inherited Create('UTF-8'); {do not localize}
  FCharSet := 'UTF-8'; {do not localize};
  FIsSingleByte := False;
  FMaxCharSize := 4;
  {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
  inherited Create(CP_UTF8);
  {$ELSE}
  ToDo('TIdUTF8Encoding constructor is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function TIdUTF8Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 3;
end;

function TIdUTF8Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount + 1;
end;

function TIdUTF8Encoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 3);
  Result[0] := $EF;
  Result[1] := $BB;
  Result[2] := $BF;
end;

{ TIdUTF16LittleEndianEncoding }

constructor TIdUTF16LittleEndianEncoding.Create;
begin
  inherited Create;
  FIsSingleByte := False;
  FMaxCharSize := 4;
end;

function TIdUTF16LittleEndianEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
begin
  // TODO: verify UTF-16 sequences
  Result := ACharCount * SizeOf(WideChar);
end;

function TIdUTF16LittleEndianEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
{$IFDEF ENDIAN_BIG}
var
  I: Integer;
  LChars: PWideChar;
  C: UInt16;
{$ENDIF}
begin
  // TODO: verify UTF-16 sequences
  {$IFDEF ENDIAN_BIG}
  LChars := AChars;
  for I := ACharCount - 1 downto 0 do
  begin
    C := UInt16(LChars^);
    ABytes^ := Hi(C);
    Inc(ABytes);
    ABytes^ := Lo(C);
    Inc(ABytes);
    Inc(LChars);
  end;
  Result := ACharCount * SizeOf(WideChar);
  {$ELSE}
  Result := ACharCount * SizeOf(WideChar);
  Move(AChars^, ABytes^, Result);
  {$ENDIF}
end;

function TIdUTF16LittleEndianEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
begin
  // TODO: verify UTF-16 sequences
  Result := AByteCount div SizeOf(WideChar);
end;

function TIdUTF16LittleEndianEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
{$IFDEF ENDIAN_BIG}
var
  LBytes1, LBytes2: PByte;
  I: Integer;
{$ENDIF}
begin
  // TODO: verify UTF-16 sequences
  {$IFDEF ENDIAN_BIG}
  LBytes1 := ABytes;
  LBytes2 := ABytes;
  Inc(LBytes2);
  for I := 0 to ACharCount - 1 do
  begin
    AChars^ := WideChar(MakeWord(LBytes2^, LBytes1^));
    Inc(LBytes1, 2);
    Inc(LBytes2, 2);
    Inc(AChars);
  end;
  Result := ACharCount;
  {$ELSE}
  Result := AByteCount div SizeOf(WideChar);
  Move(ABytes^, AChars^, Result * SizeOf(WideChar));
  {$ENDIF}
end;

function TIdUTF16LittleEndianEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 2;
end;

function TIdUTF16LittleEndianEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := (ByteCount div SizeOf(WideChar)) + (ByteCount and 1) + 1;
end;

function TIdUTF16LittleEndianEncoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 2);
  Result[0] := $FF;
  Result[1] := $FE;
end;

{ TIdUTF16BigEndianEncoding }

function TIdUTF16BigEndianEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
{$IFDEF ENDIAN_LITTLE}
var
  I: Integer;
  P: PWideChar;
  C: UInt16;
{$ENDIF}
begin
  {$IFDEF ENDIAN_LITTLE}
  P := AChars;
  for I := ACharCount - 1 downto 0 do
  begin
    C := UInt16(P^);
    ABytes^ := Hi(C);
    Inc(ABytes);
    ABytes^ := Lo(C);
    Inc(ABytes);
    Inc(P);
  end;
  Result := ACharCount * SizeOf(WideChar);
  {$ELSE}
  Result := ACharCount * SizeOf(WideChar);
  Move(AChars^, ABytes^, Result);
  {$ENDIF}
end;

function TIdUTF16BigEndianEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
{$IFDEF ENDIAN_LITTLE}
var
  P1, P2: PByte;
  I: Integer;
{$ENDIF}
begin
  {$IFDEF ENDIAN_LITTLE}
  P1 := ABytes;
  P2 := P1;
  Inc(P1);
  for I := 0 to ACharCount - 1 do
  begin
    AChars^ := WideChar(MakeWord(P1^, P2^));
    Inc(P2, 2);
    Inc(P1, 2);
    Inc(AChars);
  end;
  Result := ACharCount;
  {$ELSE}
  Result := AByteCount div SizeOf(WideChar);
  Move(ABytes^, AChars^, Result * SizeOf(WideChar));
  {$ENDIF}
end;

function TIdUTF16BigEndianEncoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 2);
  Result[0] := $FE;
  Result[1] := $FF;
end;

{ TIdASCIIEncoding }

constructor TIdASCIIEncoding.Create;
begin
  inherited Create;
  FIsSingleByte := True;
  FMaxCharSize := 1;
end;

function TIdASCIIEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while ACharCount > 0 do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode ASCII codepoints,
      // so surrogates will be replaced with '?' in GetBytes(), but we still
      // need to read them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
    end;
    Inc(Result);
  end;
end;

function TIdASCIIEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while (ACharCount > 0) and (AByteCount > 0) do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode ASCII codepoints,
      // so surrogates will be replaced with '?', but we still need to read
      // them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
      ABytes^ := Byte(Ord('?')); {do not localize} 
    end
    else if C > $007F then begin
      ABytes^ := Byte(Ord('?')); {do not localize} 
    end else begin
      ABytes^ := Byte(C);
    end;
    Inc(Result);
    // advance to next char
    Inc(ABytes);
    Dec(AByteCount);
  end;
end;

function TIdASCIIEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

function TIdASCIIEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := ABytes;
  while (AByteCount > 0) and (ACharCount > 0) do begin
    if P^ > $7F then begin
      // This is an invalid byte in the ASCII encoding.
      UInt16(AChars^) := $FFFD;
    end else begin
      UInt16(AChars^) := P^;
    end;
    Inc(Result);
    // advance to next byte
    Inc(P);
    Dec(AByteCount);
    Inc(AChars);
    Dec(ACharCount);
  end;
end;

function TIdASCIIEncoding.GetMaxByteCount(ACharCount: Integer): Integer;
begin
  Result := ACharCount;
end;

function TIdASCIIEncoding.GetMaxCharCount(AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

{ TId8BitEncoding }

constructor TId8BitEncoding.Create;
begin
  inherited Create;
  FIsSingleByte := True;
  FMaxCharSize := 1;
end;

function TId8BitEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while ACharCount > 0 do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode 8-bit codepoints,
      // so surrogates will be replaced with '?' in GetBytes(), but we still
      // need to read them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
    end;
    Inc(Result);
  end;
end;

function TId8BitEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while (ACharCount > 0) and (AByteCount > 0) do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode 8-bit codepoints,
      // so surrogates will be replaced with '?', but we still need to read
      // them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
      ABytes^ := Byte(Ord('?')); {do not localize} 
    end
    else if C > $00FF then begin
      ABytes^ := Byte(Ord('?')); {do not localize} 
    end else begin
      ABytes^ := Byte(C);
    end;
    Inc(Result);
    // advance to next char
    Inc(ABytes);
    Dec(AByteCount);
  end;
end;

function TId8BitEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

function TId8BitEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := ABytes;
  while (AByteCount > 0) and (ACharCount > 0) do begin
    UInt16(AChars^) := P^;
    Inc(Result);
    // advance to next byte
    Inc(P);
    Dec(AByteCount);
    Inc(AChars);
    Dec(ACharCount);
  end;
end;

function TId8BitEncoding.GetMaxByteCount(ACharCount: Integer): Integer;
begin
  Result := ACharCount;
end;

function TId8BitEncoding.GetMaxCharCount(AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

{ TIdByteRangeEncoding }

function EncodeCodeUnitToByte(const ACodeUnit: UInt16; const ARanges: PIdCodeUnitByteInfo; const ANumRanges: Integer): Byte;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LRange: PIdCodeUnitByteInfo;
  I: Integer;
begin
  LRange := ARanges;
  for I := 0 to ANumRanges-1 do begin
    if (LRange.Size = 1) and (ACodePoint = LRange.FirstCU) then begin
      Result := LRange.FirstByte;
      Exit;
    end;
    if (ACodeUnit >= LRange.FirstCU) and (ACodeUnit <= (LRange.FirstCU + (LRange.Size-1))) then begin
      Result := LRange.FirstByte + Byte(ACodeUnit - LRange.FirstCU);
      Exit;
    end;
    Inc(LRange);
  end;
  Result := Ord('?'); {do not localize}
end;

function DecodeByteToCodeUnit(const AByte: Byte; const ARanges: PIdCodeUnitByteInfo; const ANumRanges: Integer): UInt16;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LRange: PIdCodeUnitByteInfo;
  I: Integer;
begin
  LRange := ARanges;
  for I := 0 to ANumRanges-1 do begin
    if (LRange.Size = 1) and (AByte = LRange.FirstByte) then begin
      Result := LRange.FirstCU;
      Exit;
    end
    if (AByte >= LRange.FirstByte) and (AByte <= (LRange.FirstByte + (LRange.Size-1))) then begin
      Result := LRange.FirstCU + (AByte - LRange.FirstByte);
      Exit;
    end
    Inc(ARanges);
  end;
  Result := $FFFD;
end;

constructor TIdByteRangeEncoding.Create(const ACodePage: UInt16; const ARanges: array of TIdCodeUnitByteInfo);
begin
  inherited Create;
  FCodePage := ACodePage;
  FRanges := PIdCodeUnitByteInfo(ARanges);
  FNumRanges := Length(ARanges);
  FIsSingleByte := True;
  FMaxCharSize := 1;
end;

function TIdByteRangeEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while ACharCount > 0 do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode this charset's codepoints,
      // so surrogates will be replaced with '?' in GetBytes(), but we still
      // need to read them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
    end;
    Inc(Result);
  end;
end;

function TIdByteRangeEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  P: PWideChar;
  C: UInt16;
begin
  Result := 0;
  P := AChars;
  while (ACharCount > 0) and (AByteCount > 0) do begin
    C := UInt16(P^);
    Inc(P);
    Dec(ACharCount);
    if (C >= $D800) and (C <= $DFFF) then
    begin
      // UTF-16 surrogates should never be used to encode this charset's codepoints,
      // so surrogates will be replaced with '?', but we still need to read
      // them properly...
      if (C <= $DBFF) and (ACharCount > 0) then begin
        C := UInt16(P^);
        if (C >= $DC00) and (C <= $DFFF) then begin
          Inc(P);
          Dec(ACharCount);
        end;
      end;
      ABytes^ := Ord('?'); {do not localize}
    end else begin
      ABytes^ := EncodeCodeUnitToByte(C, FRanges, FNumRanges);
    end;
    Inc(Result);
    // advance to next char
    Inc(ABytes);
    Dec(AByteCount);
  end;
end;

function TIdByteRangeEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

function TIdByteRangeEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := ABytes;
  while (AByteCount > 0) and (ACharCount > 0) do begin
    UInt16(AChars^) := DecodeByteToCodeUnit(P^, FRanges, FNumRanges);
    Inc(AChars);
    Dec(ACharCount);
    // advance to next byte
    Inc(P);
    Dec(AByteCount);
  end;
end;

function TIdByteRangeEncoding.GetMaxByteCount(ACharCount: Integer): Integer;
begin
  Result := ACharCount;
end;

function TIdByteRangeEncoding.GetMaxCharCount(AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

{ TIdTextEncoding_ISO_8859_1 }

const
  cByteRanges_ISO_8859_1: array[0..1] of TIdCodeUnitByteInfo = (
    // bytes 0x00..0x1F unassigned
    (Size: 95; FirstByte: $20; FirstCU: $0020),
    // bytes 0x7F..0x9F unassigned
    (Size: 96; FirstByte: $A0; FirstCU: $00A0)
  end;

constructor TIdTextEncoding_ISO_8859_1.Create;
begin
  inherited Create(28591, cByteRanges_ISO_8859_1);
end;

{ TIdTextEncoding_ISO_8859_2 }

const
  cByteRanges_ISO_8859_2: array[0..86] of TIdCodeUnitByteInfo = (
    // bytes 0x00..0x1F unassigned
    (Size: 95; FirstByte: $20; FirstCU: $0020),
    // bytes 0x7F..0x9F unassigned
    (Size:  1; FirstByte: $A0; FirstCU: $00A0),
    (Size:  1; FirstByte: $A1; FirstCU: $0104),
    (Size:  1; FirstByte: $A2; FirstCU: $02D8),
    (Size:  1; FirstByte: $A3; FirstCU: $0141),
    (Size:  1; FirstByte: $A4; FirstCU: $00A4),
    (Size:  1; FirstByte: $A5; FirstCU: $013D),
    (Size:  1; FirstByte: $A6; FirstCU: $015A),
    (Size:  2; FirstByte: $A7; FirstCU: $00A7),
    (Size:  1; FirstByte: $A9; FirstCU: $0160),
    (Size:  1; FirstByte: $AA; FirstCU: $015E),
    (Size:  1; FirstByte: $AB; FirstCU: $0164),
    (Size:  1; FirstByte: $AC; FirstCU: $0179),
    (Size:  1; FirstByte: $AD; FirstCU: $00AD),
    (Size:  1; FirstByte: $AE; FirstCU: $017D),
    (Size:  1; FirstByte: $AF; FirstCU: $017B),
    (Size:  1; FirstByte: $B0; FirstCU: $00B0),
    (Size:  1; FirstByte: $B1; FirstCU: $0105),
    (Size:  1; FirstByte: $B2; FirstCU: $02DB),
    (Size:  1; FirstByte: $B3; FirstCU: $0142),
    (Size:  1; FirstByte: $B4; FirstCU: $00B4),
    (Size:  1; FirstByte: $B5; FirstCU: $013E),
    (Size:  1; FirstByte: $B6; FirstCU: $015B),
    (Size:  1; FirstByte: $B7; FirstCU: $02C7),
    (Size:  1; FirstByte: $B8; FirstCU: $00B8),
    (Size:  1; FirstByte: $B9; FirstCU: $0161),
    (Size:  1; FirstByte: $BA; FirstCU: $015F),
    (Size:  1; FirstByte: $BB; FirstCU: $0165),
    (Size:  1; FirstByte: $BC; FirstCU: $017A),
    (Size:  1; FirstByte: $BD; FirstCU: $02DD),
    (Size:  1; FirstByte: $BE; FirstCU: $017E),
    (Size:  1; FirstByte: $BF; FirstCU: $017C),
    (Size:  1; FirstByte: $C0; FirstCU: $0154),
    (Size:  2; FirstByte: $C1; FirstCU: $00C1),
    (Size:  1; FirstByte: $C3; FirstCU: $0102),
    (Size:  1; FirstByte: $C4; FirstCU: $00C4),
    (Size:  1; FirstByte: $C5; FirstCU: $0139),
    (Size:  1; FirstByte: $C6; FirstCU: $0106),
    (Size:  1; FirstByte: $C7; FirstCU: $00C7),
    (Size:  1; FirstByte: $C8; FirstCU: $010C),
    (Size:  1; FirstByte: $C9; FirstCU: $00C9),
    (Size:  1; FirstByte: $CA; FirstCU: $0118),
    (Size:  1; FirstByte: $CB; FirstCU: $00CB),
    (Size:  1; FirstByte: $CC; FirstCU: $011A),
    (Size:  2; FirstByte: $CD; FirstCU: $00CD),
    (Size:  1; FirstByte: $CF; FirstCU: $010E),
    (Size:  1; FirstByte: $D0; FirstCU: $0110),
    (Size:  1; FirstByte: $D1; FirstCU: $0143),
    (Size:  1; FirstByte: $D2; FirstCU: $0147),
    (Size:  2; FirstByte: $D3; FirstCU: $00D3),
    (Size:  1; FirstByte: $D5; FirstCU: $0150),
    (Size:  2; FirstByte: $D6; FirstCU: $00D6),
    (Size:  1; FirstByte: $D8; FirstCU: $0158),
    (Size:  1; FirstByte: $D9; FirstCU: $016E),
    (Size:  1; FirstByte: $DA; FirstCU: $00DA),
    (Size:  1; FirstByte: $DB; FirstCU: $0170),
    (Size:  2; FirstByte: $DC; FirstCU: $00DC),
    (Size:  1; FirstByte: $DE; FirstCU: $0162),
    (Size:  1; FirstByte: $DF; FirstCU: $00DF),
    (Size:  1; FirstByte: $E0; FirstCU: $0155),
    (Size:  2; FirstByte: $E1; FirstCU: $00E1),
    (Size:  1; FirstByte: $E3; FirstCU: $0103),
    (Size:  1; FirstByte: $E4; FirstCU: $00E4),
    (Size:  1; FirstByte: $E5; FirstCU: $013A),
    (Size:  1; FirstByte: $E6; FirstCU: $0107),
    (Size:  1; FirstByte: $E7; FirstCU: $00E7),
    (Size:  1; FirstByte: $E8; FirstCU: $010D),
    (Size:  1; FirstByte: $E9; FirstCU: $00E9),
    (Size:  1; FirstByte: $EA; FirstCU: $0119),
    (Size:  1; FirstByte: $EB; FirstCU: $00EB),
    (Size:  1; FirstByte: $EC; FirstCU: $011B),
    (Size:  2; FirstByte: $ED; FirstCU: $00ED),
    (Size:  1; FirstByte: $EF; FirstCU: $010F),
    (Size:  1; FirstByte: $F0; FirstCU: $0111),
    (Size:  1; FirstByte: $F1; FirstCU: $0144),
    (Size:  1; FirstByte: $F2; FirstCU: $0148),
    (Size:  2; FirstByte: $F3; FirstCU: $00F3),
    (Size:  1; FirstByte: $F5; FirstCU: $0151),
    (Size:  2; FirstByte: $F6; FirstCU: $00F6),
    (Size:  1; FirstByte: $F8; FirstCU: $0159),
    (Size:  1; FirstByte: $F9; FirstCU: $016F),
    (Size:  1; FirstByte: $FA; FirstCU: $00FA),
    (Size:  1; FirstByte: $FB; FirstCU: $0171),
    (Size:  2; FirstByte: $FC; FirstCU: $00FC),
    (Size:  1; FirstByte: $FE; FirstCU: $0163),
    (Size:  1; FirstByte: $FF; FirstCU: $02D9)
  );

constructor TIdTextEncoding_ISO_8859_2.Create;
begin
  inherited Create(28592, cByteRanges_ISO_8859_2);
end;

{ TIdTextEncoding_Windows1252 }

const
  cByteRanges_Windows1252: array[0..24] of TIdCodeUnitByteInfo = (
    (Size: 128; FirstByte: $00; FirstCU: $0000),
    (Size:   1; FirstByte: $80; FirstCU: $20AC),
    // byte 0x81 unassigned
    (Size:   1; FirstByte: $82; FirstCU: $201A),
    (Size:   1; FirstByte: $83; FirstCU: $0192),
    (Size:   1; FirstByte: $84; FirstCU: $201E),
    (Size:   1; FirstByte: $85; FirstCU: $2026),
    (Size:   2; FirstByte: $86; FirstCU: $2020),
    (Size:   1; FirstByte: $88; FirstCU: $02C6),
    (Size:   1; FirstByte: $89; FirstCU: $2030),
    (Size:   1; FirstByte: $8A; FirstCU: $0160),
    (Size:   1; FirstByte: $8B; FirstCU: $2039),
    (Size:   1; FirstByte: $8C; FirstCU: $0152),
    // byte 0x8D unassigned
    (Size:   1; FirstByte: $8E; FirstCU: $017D),
    // bytes 0x8F..0x90 unassigned
    (Size:   2; FirstByte: $91; FirstCU: $2018),
    (Size:   2; FirstByte: $93; FirstCU: $201C),
    (Size:   1; FirstByte: $95; FirstCU: $2022),
    (Size:   2; FirstByte: $96; FirstCU: $2013),
    (Size:   1; FirstByte: $98; FirstCU: $02DC),
    (Size:   1; FirstByte: $99; FirstCU: $2122),
    (Size:   1; FirstByte: $9A; FirstCU: $0161),
    (Size:   1; FirstByte: $9B; FirstCU: $203A),
    (Size:   1; FirstByte: $9C; FirstCU: $0153),
    // byte 0x9D unassigned
    (Size:   1; FirstByte: $9E; FirstCU: $017E),
    (Size:   1; FirstByte: $9F; FirstCU: $0178),
    (Size:  96; FirstByte: $A0; FirstCU: $00A0)
  end;

constructor TIdTextEncoding_Windows1252.Create;
begin
  inherited Create(1252, cByteRanges_Windows1252);
end;

{ TIdVCLEncoding }

{$IFDEF HAS_TEncoding}

// RLebeau: this is a hack.  The protected members of SysUtils.TEncoding are
// declared as 'STRICT protected', so a regular accessor will not work here.
// Only descendants can call them, so we have to expose our own methods that
// this unit can call, and have them call the inherited methods internally.

type
  TEncodingAccess = class(TEncoding)
  public
    function IndyGetByteCount(Chars: PChar; CharCount: Integer): Integer;
    function IndyGetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer;
    function IndyGetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
    function IndyGetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer;
  end;

function TEncodingAccess.IndyGetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
  Result := GetByteCount(Chars, CharCount);
end;

function TEncodingAccess.IndyGetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := GetBytes(Chars, CharCount, Bytes, ByteCount);
end;

function TEncodingAccess.IndyGetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := GetCharCount(Bytes, ByteCount);
end;

function TEncodingAccess.IndyGetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
begin
  Result := GetChars(Bytes, ByteCount, Chars, CharCount);
end;

constructor TIdVCLEncoding.Create(AEncoding: TEncoding; AFreeEncoding: Boolean);
begin
  inherited Create;
  FEncoding := AEncoding;
  FFreeEncoding := AFreeEncoding and not TEncoding.IsStandardEncoding(AEncoding);
  FIsSingleByte := FEncoding.IsSingleByte;
end;

{$IFDEF HAS_TEncoding_GetEncoding_ByEncodingName}
constructor TIdVCLEncoding.Create(const ACharset: String);
var
  LCharset: string;
begin
  // RLebeau 5/2/2017: have seen some malformed emails that use 'utf8'
  // instead of 'utf-8', so let's check for that...

  // RLebeau 9/27/2017: updating to handle a few more UTFs without hyphens...

  // normalize ACharset for easier comparisons...

  case PosInStrArray(ACharset, ['UTF7', 'UTF8', 'UTF16', 'UTF16LE', 'UTF16BE', 'UTF32', 'UTF32LE', 'UTF32BE'], False) of {Do not Localize}
    0:   LCharset := 'UTF-7';    {Do not Localize}
    1:   LCharset := 'UTF-8';    {Do not Localize}
    2,3: LCharset := 'UTF-16LE'; {Do not Localize}
    4:   LCharset := 'UTF-16BE'; {Do not Localize}
    5,6: LCharset := 'UTF-32LE'; {Do not Localize}
    7:   LCharset := 'UTF-32BE'; {Do not Localize}
  else
    LCharset := ACharset;
  end;

  Create(TEncoding.GetEncoding(LCharset), True);
end;
{$ENDIF}

constructor TIdVCLEncoding.Create(const ACodepage: UInt16);
begin
  Create(TEncoding.GetEncoding(ACodepage), True);
end;

destructor TIdVCLEncoding.Destroy;
begin
  if FFreeEncoding then begin
    FEncoding.Free;
  end;
  inherited Destroy;
end;

function TIdVCLEncoding.GetByteCount(const AChars: PWideChar; ACharCount: Integer): Integer;
begin
  {$I IdObjectChecksOff.inc}
  Result := TEncodingAccess(FEncoding).IndyGetByteCount(AChars, ACharCount);
  {$I IdObjectChecksOn.inc}
end;

function TIdVCLEncoding.GetBytes(const AChars: PWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
begin
  {$I IdObjectChecksOff.inc}
  Result := TEncodingAccess(FEncoding).IndyGetBytes(AChars, ACharCount, ABytes, AByteCount);
  {$I IdObjectChecksOn.inc}
end;

function TIdVCLEncoding.GetCharCount(const ABytes: PByte; AByteCount: Integer): Integer;
begin
  {$I IdObjectChecksOff.inc}
  Result := TEncodingAccess(FEncoding).IndyGetCharCount(ABytes, AByteCount);
  {$I IdObjectChecksOn.inc}
end;

function TIdVCLEncoding.GetChars(const ABytes: PByte; AByteCount: Integer;
  AChars: PWideChar; ACharCount: Integer): Integer;
begin
  {$I IdObjectChecksOff.inc}
  Result := TEncodingAccess(FEncoding).IndyGetChars(ABytes, AByteCount, AChars, ACharCount);
  {$I IdObjectChecksOn.inc}
end;

function TIdVCLEncoding.GetMaxByteCount(ACharCount: Integer): Integer;
begin
  Result := FEncoding.GetMaxByteCount(ACharCount);
end;

function TIdVCLEncoding.GetMaxCharCount(AByteCount: Integer): Integer;
begin
  Result := FEncoding.GetMaxCharCount(AByteCount);
end;
{$ENDIF}

function IndyTextEncoding(AType: IdTextEncodingType): IIdTextEncoding;
begin
  case AType of
    encIndyDefault: Result := IndyTextEncoding_Default;
    // encOSDefault handled further below
    enc8Bit:        Result := IndyTextEncoding_8Bit;
    encASCII:       Result := IndyTextEncoding_ASCII;
    encUTF16BE:     Result := IndyTextEncoding_UTF16BE;
    encUTF16LE:     Result := IndyTextEncoding_UTF16LE;
    encUTF7:        Result := IndyTextEncoding_UTF7;
    encUTF8:        Result := IndyTextEncoding_UTF8;
  else
    // encOSDefault
    Result := IndyTextEncoding_OSDefault;
  end;
end;

function IndyTextEncoding(ACodepage: UInt16): IIdTextEncoding;
begin
  case ACodepage of
    1200:
      Result := IndyTextEncoding_UTF16LE;
    1201:
      Result := IndyTextEncoding_UTF16BE;
    1252:
      Result := TIdTextEncoding_Windows1252.Create;
    20127:
      Result := IndyTextEncoding_ASCII;
    28591:
      Result := TIdTextEncoding_ISO_8859_1.Create;
    28592:
      Result := TIdTextEncoding_ISO_8859_2.Create;
    65000:
      Result := IndyTextEncoding_UTF7;
    65001:
      Result := IndyTextEncoding_UTF8;
    // TODO: add support for UTF-32...
  else
    {$IF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
    Result := TIdMBCSEncoding.Create(ACodepage);
    {$ELSEIF DEFINED(HAS_TEncoding)}
    Result := TIdVCLEncoding.Create(ACodepage);
    {$ELSE}
    Result := nil;
    raise EIdException.CreateResFmt(@RSUnsupportedCodePage, [ACodepage]); // TODO: create a new Exception class for this
    {$IFEND}
  end;
end;

function IndyTextEncoding(const ACharSet: String): IIdTextEncoding;
begin
  // TODO: move IdCharsets unit into the System package so the
  // IdGlobalProtocols.CharsetToEncoding() function can be moved
  // into this unit...
  if IsCharsetASCII(ACharSet) then begin
    Result := IndyTextEncoding_ASCII;
  end else begin
    // RLebeau 5/2/2017: have seen some malformed emails that use 'utf8'
    // instead of 'utf-8', so let's check for that...

    // RLebeau 9/27/2017: updating to handle a few more UTFs without hyphens...

    // TODO: normalize ACharSet for easier comparisons...

    case PosInStrArray(ACharSet, ['UTF-7', 'UTF7', 'UTF-8', 'UTF8', 'UTF-16', 'UTF16', 'UTF-16LE', 'UTF16LE', 'UTF-16BE', 'UTF16BE'], False) of {Do not Localize}
      0, 1: Result := IndyTextEncoding_UTF7;
      2, 3: Result := IndyTextEncoding_UTF8;
      4..7: Result := IndyTextEncoding_UTF16LE;
      8, 9: Result := IndyTextEncoding_UTF16BE;
      // TODO: add support for UTF-32...
    else
      case PosInStrArray(ACharSet, ['ISO-8859-1', 'ISO-8859-2', 'Windows-1252'], False) of {Do not Localize}
        0: Result := TIdTextEncoding_ISO_8859_1.Create;
        1: Result := TIdTextEncoding_ISO_8859_2.Create;
        // TODO: add support for more ISO-8859-X...
        2: Result := TIdTextEncoding_Windows1252.Create;
        // TODO: add support for more Windows-125X...
      else
        {$IF DEFINED(USE_ICONV) OR DEFINED(USE_LCONVENC)}
        Result := TIdMBCSEncoding.Create(ACharSet);
        {$ELSEIF DEFINED(HAS_TEncoding_GetEncoding_ByEncodingName)}
        Result := TIdVCLEncoding.Create(ACharSet);
        {$ELSE}
        // TODO: provide a hook that IdGlobalProtocols can assign to so we can call
        // CharsetToCodePage() here, at least until CharsetToEncoding() can be moved
        // to this unit once IdCharsets has been moved to the System package...
        Result := nil;
        raise EIdException.CreateFmt(RSUnsupportedCharSet, [ACharSet]); // TODO: create a new Exception class for this
        {$IFEND}
      end;
    end;
  end;
end;

{$IFDEF HAS_TEncoding}
function IndyTextEncoding(AEncoding: TEncoding; AFreeEncoding: Boolean = False): IIdTextEncoding;
begin
  Result := TIdVCLEncoding.Create(AEncoding, AFreeEncoding);
end;
{$ENDIF}

function IndyTextEncoding_Default: IIdTextEncoding;
var
  LType: IdTextEncodingType;
begin
  LType := GIdDefaultTextEncoding;
  if LType = encIndyDefault then begin
    LType := encASCII;
  end;
  Result := IndyTextEncoding(LType);
end;

function IndyTextEncoding_OSDefault: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdOSDefaultEncoding = nil then begin
    // SysUtils.TEncoding.Default uses ANSI on Windows
    // but uses UTF-8 on POSIX, so we should do the same...
    LEncoding := {$IFDEF WINDOWS}TIdMBCSEncoding{$ELSE}TIdUTF8Encoding{$ENDIF}.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdOSDefaultEncoding), LEncoding, nil);
  end;
  Result := GIdOSDefaultEncoding;
end;

function IndyTextEncoding_8Bit: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GId8BitEncoding = nil then begin
    LEncoding := TId8BitEncoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GId8BitEncoding), LEncoding, nil);
  end;
  Result := GId8BitEncoding;
end;

function IndyTextEncoding_ASCII: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdASCIIEncoding = nil then begin
    LEncoding := TIdASCIIEncoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdASCIIEncoding), LEncoding, nil);
  end;
  Result := GIdASCIIEncoding;
end;

function IndyTextEncoding_UTF16BE: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdUTF16BigEndianEncoding = nil then begin
    LEncoding := TIdUTF16BigEndianEncoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdUTF16BigEndianEncoding), LEncoding, nil);
  end;
  Result := GIdUTF16BigEndianEncoding;
end;

function IndyTextEncoding_UTF16LE: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdUTF16LittleEndianEncoding = nil then begin
    LEncoding := TIdUTF16LittleEndianEncoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdUTF16LittleEndianEncoding), LEncoding, nil);
  end;
  Result := GIdUTF16LittleEndianEncoding;
end;

function IndyTextEncoding_UTF7: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdUTF7Encoding = nil then begin
    LEncoding := TIdUTF7Encoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdUTF7Encoding), LEncoding, nil);
  end;
  Result := GIdUTF7Encoding;
end;

function IndyTextEncoding_UTF8: IIdTextEncoding;
var
  LEncoding: IIdTextEncoding;
begin
  if GIdUTF8Encoding = nil then begin
    LEncoding := TIdUTF8Encoding.Create;
    InterlockedCompareExchangeIntf(IInterface(GIdUTF8Encoding), LEncoding, nil);
  end;
  Result := GIdUTF8Encoding;
end;

function GetEncodingCodePage(AEncoding: IIdTextEncoding): UInt16;
begin
  Result := 0;
  if AEncoding = nil then begin
    Exit;
  end;

  // RLebeau 2/15/2019: AEncoding is checked this way until IIdTextEncoding is updated to expose its assigned CodePage...

  if AEncoding is TIdByteRangeEncoding then begin
    Result := TIdByteRangeEncoding(AEncoding).CodePage;
    Exit;
  end'

  {$IF DEFINED(SUPPORTS_CHARSET_ENCODING)}
  {
  if AEncoding is TIdMBCSEncoding then begin
    // TODO: normalize FCharSet for easier comparisons...
    case PosInStrArray(TIdMBCSEncoding(AEncoding).FCharSet, ['UTF-7', 'UTF7', 'UTF-8', 'UTF8', 'UTF-16', 'UTF16', 'UTF-16LE', 'UTF16LE', 'UTF-16BE', 'UTF16BE', 'char', 'ISO-8859-1', 'ISO-8859-2'], False) of
      0, 1: Result := 65000;
      2, 3: Result := 65001;
      4..7: Result := 1200;
      8, 9: Result := 1201;
      10:   Result := DefaultSystemCodePage;
      11:   Result := 28591;
      12:   Result := 28592;
      // TODO: add support for UTF-32...
    else
      if IsCharsetASCII(TIdMBCSEncoding(AEncoding).FCharSet) then begin
        Result := 20127;
      end;
    end;
  end
  else
  }
  {$ELSEIF DEFINED(SUPPORTS_CODEPAGE_ENCODING)}
  {
  if AEncoding is TIdMBCSEncoding then begin
    Result := TIdMBCSEncoding(AEncoding).FCodePage;
  end
  else
  }
  {$IFEND}

  if (AEncoding = GIdOSDefaultEncoding) then
  begin
    Result := DefaultSystemCodePage;
  end
  else if (AEncoding = GId8BitEncoding) {or (AEncoding is TId8BitEncoding)} then
  begin
    // TODO: maybe use codepage 437 instead?  While ISO-8859-1 has a 1:1
    // mapping where bytes 0..255 are mapped to Unicode codepoints of the
    // same numeric values, making it useful for binary data, technically
    // it has gaps where some of the bytes are not mapped to Unicode at all.
    // But so far in practice, I haven't noticed any problems with that.
    // Whereas codepage 437 has all bytes 0..255 mapped to Unicode, but some
    // of those codepoints do not use the same numeric values as the bytes,
    // which could cause problems interpretting binary data...
    Result := 28591;
  end
  else if (AEncoding = GIdASCIIEncoding) {or (AEncoding is TIdASCIIEncoding)} then
  begin
    Result := 20127;
  end
  else if (AEncoding = GIdUTF16BigEndianEncoding) {or (AEncoding is TIdUTF16BigEndianEncoding)} then
  begin
    Result := 1201;
  end
  else if (AEncoding = GIdUTF16LittleEndianEncoding) {or (AEncoding is TIdUTF16LittleEndianEncoding)} then
  begin
    Result := 1200;
  end
  else if (AEncoding = GIdUTF7Encoding) {or (AEncoding is TIdUTF7Encoding)} then
  begin
    Result := 65000;
  end
  else if (AEncoding = GIdUTF8Encoding) {or (AEncoding is TIdUTF8Encoding)} then
  begin
    Result := 65001;
  end;
end;

function LoadLibFunction(const ALibHandle: TIdLibHandle; const AProcName: UnicodeString): Pointer;
begin
  {$I IdRangeCheckingOff.inc}
  Result := {$IFDEF WINDOWS}Windows.{$ENDIF}GetProcAddress(ALibHandle, PWideChar(AProcName));
  {$I IdRangeCheckingOn.inc}
end;

{$IFDEF UNIX}
function HackLoadFileName(const ALibName, ALibVer : String) : string;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IF DEFINED(OSX) OR DEFINED(IOS)}
  Result := ALibName + ALibVer + LIBEXT;
  {$ELSE}
  Result := ALibName + LIBEXT + ALibVer;
  {$IFEND}
end;

function HackLoad(const ALibName : String; const ALibVersions : array of String) : TIdLibHandle;
var
  i : Integer;

  function LoadLibVer(const ALibVer: string): TIdLibHandle;
  var
    FileName: string;
  begin
    FileName := HackLoadFileName(ALibName, ALibVer);

    {$IF DEFINED(USE_SAFELOADLIBRARY)}
    Result := SafeLoadLibrary(FileName);
    {$ELSEIF DEFINED(KYLIXCOMPAT)}
    // Workaround that is required under Linux (changed RTLD_GLOBAL with RTLD_LAZY Note: also work with LoadLibrary())
    // TODO: use dynlibs.SysLoadLibraryU() instead:
    // Result := SysLoadLibraryU(FileName);
    Result := TIdLibHandle(dlopen(PAnsiChar(ToSingleByteFileSystemEncodedFileName(FileName)), RTLD_LAZY));
    {$ELSE}
    Result := LoadLibrary(FileName);
    {$IFEND}

    {$IFDEF USE_INVALIDATE_MOD_CACHE}
    InvalidateModuleCache;
    {$ENDIF}
  end;

begin
  if High(ALibVersions) > -1 then begin
    Result := IdNilHandle;
    for i := Low(ALibVersions) to High(ALibVersions) do
    begin
      Result := LoadLibVer(ALibVersions[i]);
      if Result <> IdNilHandle then begin
        Break;
      end;
    end;
  end else begin
    Result := LoadLibVer('');
  end;
end;
{$ENDIF}

procedure IndyRaiseLastError;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  RaiseLastOSError;
end;

{$IF DEFINED(HAS_Exception_RaiseOuterException)}
procedure IndyRaiseOuterException(AOuterException: Exception);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Exception.RaiseOuterException(AOuterException);
end;
{$ELSEIF DEFINED(DCC)}
// RLebeau: There is no Exception.InnerException property to capture the inner
// exception into, but we can still raise the outer exception using Delphi's
// 'raise ... at [address]' syntax, at least.  This way, the debugger (and
// exception loggers) can show the outer exception occuring in the caller
// rather than inside this function...
  {$IF DEFINED(HAS_System_ReturnAddress)}
procedure IndyRaiseOuterException(AOuterException: Exception);
begin
  raise AOuterException at ReturnAddress;
end;
  {$ELSE}
// RLebeau: Delphi RTL functions like SysUtils.Abort(), Classes.TList.Error(),
// and Classes.TStrings.Error() raise their respective exceptions at the
// caller's return address using Delphi's 'raise ... at [address]' syntax,
// however they do so in different ways depending on Delphi version!
//
// ----------------
// SysUtils.Abort()
// ----------------
// Delphi 5-2007: Abort() calls an internal helper function that returns the
// caller's return address from the call stack - [EBP-4] in Delphi 5, [EBP+4]
// in Delphi 6+ - and then passes that value to 'raise'. Not sure why [EBP-4]
// was being used in Delphi 5.  Maybe a typo?
//
// Delphi 2009-XE: Abort() JMP's into an internal helper procedure that takes
// a Pointer parameter as input (passed in EAX) and passes it to 'raise'.
// Delphi 2009-2010 POP's the caller's return address from the call stack
// into EAX. Delphi XE simply MOV's [ESP] into EAX instead.
// ----------------
// TList.Error()
// TStrings.Error()
// ----------------
// Delphi 5-2010: Error() calls an internal helper function that returns the
// caller's return address from the call stack - always [EBP+4] - and then passes
// that value to 'raise'.
//
// Delphi XE: no helper is used. Error() is wrapped with {$O-} to force a stack
// frame, and then reads the caller's return address directly from the call stack
// (using pointer math to find it) and passes it to 'raise'.
// ----------------
//
// To be safe, we will use the MOV [ESP] approach here, as it is the simplest.
// We only have to worry about this in Delphi's Windows 32bit compiler, as the
// 64bit and mobile compilers have System.ReturnAddress available...

// disable stack frames to reduce instructions
{$I IdStackFramesOff.inc}
procedure IndyRaiseOuterException(AOuterException: Exception);
  procedure RaiseE(E: Exception; ReturnAddr: Pointer);
  begin
    raise E at ReturnAddr;
  end;
asm
  // AOuterException is already in EAX...
  // MOV EAX, AOuterException
  MOV EDX, [ESP]
  JMP RaiseE
end;
{$I IdStackFramesOn.inc}

  {$IFEND}
{$ELSE}
procedure IndyRaiseOuterException(AOuterException: Exception);
begin
  {$IFDEF FPC}
  // TODO: is get_caller_frame() optional here?
  raise AOuterException at get_caller_addr(get_frame), get_caller_frame(get_frame);
  {$ELSE}
  // Just raise the exception as-is until we know what else to do with it...
  raise AOuterException;
  {$ENDIF}
end;
{$IFEND}

function InterlockedExchangePtr(var VTarget: Pointer; const AValue: Pointer): Pointer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TInterlocked}
  Result := TInterlocked.Exchange(VTarget, AValue);
  {$ELSE}
  Result := Pointer(
    {$IFDEF CPU64}InterlockedExchange64{$ELSE}InterlockedExchange{$ENDIF}
      (PtrInt(VTarget), PtrInt(AValue))
  );
  {$ENDIF}
end;

function InterlockedExchangeTHandle(var VTarget: THandle; const AValue: THandle): THandle;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IF DEFINED(THANDLE_32)}
  Result := THandle({$IFDEF HAS_TInterlocked}TInterlocked.Exchange{$ELSE}InterlockedExchange{$ENDIF}(Int32(VTarget), Int32(AValue)));
  {$ELSEIF DEFINED(THANDLE_64)}
  //Temporary workaround.  TInterlocked for Emb really should accept 64 bit unsigned values as set of parameters
  //for TInterlocked.Exchange since 64-bit wide integers are common on 64 bit platforms.
  Result := THandle({$IFDEF HAS_TInterlocked}TInterlocked.Exchange{$ELSE}InterlockedExchange64{$ENDIF}(Int64(VTarget), Int64(AValue)));
  {$ELSE}
  ToDo('InterlockedExchangeTHandle() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

function InterlockedExchangeTLibHandle(var VTarget: TIdLibHandle; const AValue: TIdLibHandle): TIdLibHandle;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TIdLibHandle(
    {$IF DEFINED(HAS_TInterlocked)}
    TInterlocked.Exchange(
      {$IFDEF CPU64}
      Int64(VTarget), Int64(AValue)
      {$ELSE}
      Integer(VTarget), Integer(AValue)
      {$ENDIF}
    )
    {$ELSEIF DEFINED(CPU64)}
    InterlockedExchange64(Int64(VTarget), Int64(AValue))
    {$ELSE}
    InterlockedExchange(Integer(VTarget), Integer(AValue))
    {$IFEND}
  );
end;

{$UNDEF DYNAMICLOAD_InterlockedCompareExchange}
{$IF NOT (DEFINED(HAS_TInterlocked) OR DEFINED(FPC))}
  // RLebeau: InterlockedCompareExchange() is not available prior to Win2K,
  // so need to fallback to some other logic on older systems.  Not too many
  // people still support those systems anymore, so we will make this optional.
  //
  // InterlockedCompareExchange64(), on the other hand, is not available until
  // Windows Vista (and not defined in any version of Windows.pas up to Delphi
  // XE), so always dynamically load it in order to support WinXP 64-bit...

  {$IFDEF CPU64}
    {$DEFINE DYNAMICLOAD_InterlockedCompareExchange}
  {$ELSE}
    {.$DEFINE STATICLOAD_InterlockedCompareExchange}
  {$ENDIF}
{$IFEND}

{$IFDEF DYNAMICLOAD_InterlockedCompareExchange}
// See http://code.google.com/p/delphi-toolbox/source/browse/trunk/RTLEx/RTLEx.BasicOp.Atomic.pas
// for how to perform interlocked operations in assembler...

type
  TInterlockedCompareExchangeFunc = function(var Destination: PtrInt; Exchange, Comparand: PtrInt): PtrInt; stdcall;

var
  InterlockedCompareExchange: TInterlockedCompareExchangeFunc = nil;

function Impl_InterlockedCompareExchange(var Destination: PtrInt; Exchange, Comparand: PtrInt): PtrInt; stdcall;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF CPU64}
  // TODO: use LOCK CMPXCHG8B directly so this is more atomic...
  {$ELSE}
  // TODO: use LOCK CMPXCHG directly so this is more atomic...
  {$ENDIF}
  Result := Destination;
  if Destination = Comparand then begin
    Destination := Exchange;
  end;
end;

function Stub_InterlockedCompareExchange(var Destination: PtrInt; Exchange, Comparand: PtrInt): PtrInt; stdcall;

  function GetImpl: Pointer;
  const
    cKernel32 = 'KERNEL32'; {do not localize}
    // TODO: what is Embarcadero's 64-bit define going to be?
    cInterlockedCompareExchange = {$IFDEF CPU64}'InterlockedCompareExchange64'{$ELSE}'InterlockedCompareExchange'{$ENDIF}; {do not localize}
  begin
    Result := LoadLibFunction(GetModuleHandle(cKernel32), cInterlockedCompareExchange);
    if Result = nil then begin
      Result := @Impl_InterlockedCompareExchange;
    end;
  end;

begin
  @InterlockedCompareExchange := GetImpl();
  Result := InterlockedCompareExchange(Destination, Exchange, Comparand);
end;

{$ENDIF}

function InterlockedCompareExchangePtr(var VTarget: Pointer; const AValue, Compare: Pointer): Pointer;
{$IFNDEF DYNAMICLOAD_InterlockedCompareExchange}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IF DEFINED(DYNAMICLOAD_InterlockedCompareExchange)}
  Result := Pointer(IdGlobal.InterlockedCompareExchange(PtrInt(VTarget), PtrInt(AValue), PtrInt(Compare)));
  {$ELSEIF DEFINED(HAS_TInterlocked)}
  Result := TInterlocked.CompareExchange(VTarget, AValue, Compare);
  {$ELSEIF DEFINED(HAS_InterlockedCompareExchangePointer)}
  Result := InterlockedCompareExchangePointer(VTarget, AValue, Compare);
  {$ELSEIF DEFINED(HAS_InterlockedCompareExchange_Pointers)}
  //work around a conflicting definition for InterlockedCompareExchange
  Result := {$IFDEF FPC}system.{$ENDIF}InterlockedCompareExchange(VTarget, AValue, Compare);
  {$ELSEIF DEFINED(FPC)}
  Result := Pointer(
    {$IFDEF CPU64}InterlockedCompareExchange64{$ELSE}InterlockedCompareExchange{$ENDIF}
      (PtrInt(VTarget), PtrInt(AValue), PtrInt(Compare))
     );
  {$ELSE}
  // Delphi 64-bit is handled by HAS_InterlockedCompareExchangePointer
  Result := Pointer(InterlockedCompareExchange(Integer(VTarget), Integer(AValue), Integer(Compare)));
  {$IFEND}
end;

function InterlockedCompareExchangeObj(var VTarget: TObject; const AValue, Compare: TObject): TObject;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TInterlocked}
  // for ARC, we have to use the TObject overload of TInterlocked to ensure
  // that the reference counts of the objects are managed correctly...
  Result := TInterlocked.CompareExchange(VTarget, AValue, Compare);
  {$ELSE}
  Result := TObject(InterlockedCompareExchangePtr(Pointer(VTarget), Pointer(AValue), Pointer(Compare)));
  {$ENDIF}
end;

function InterlockedCompareExchangeIntf(var VTarget: IInterface; const AValue, Compare: IInterface): IInterface;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TInterlocked does not have an overload for IInterface.
  // We have to ensure that the reference counts of the interfaces are managed correctly...
  if AValue <> nil then begin
    AValue._AddRef;
  end;
  Result := IInterface(InterlockedCompareExchangePtr(Pointer(VTarget), Pointer(AValue), Pointer(Compare)));
  if (AValue <> nil) and (Pointer(Result) <> Pointer(Compare)) then begin
    AValue._Release;
  end;
end;

{Little Endian Byte order functions from:

From: http://community.borland.com/article/0,1410,16854,00.html


Big-endian and little-endian formated integers - by Borland Developer Support Staff

Note that I will NOT do big Endian functions because the stacks can handle that
with HostToNetwork and NetworkToHost functions.

You should use these functions for writing data that sent and received in Little
Endian Form.  Do NOT assume endianness of what's written.  It can work in unpredictable
ways on other architectures.
}
function HostToLittleEndian(const AValue : UInt16) : UInt16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a NtoLE() function in its System unit to
  // "Convert Native-ordered integer to a Little Endian-ordered integer"

  {.$IFDEF FPC}
  //Result := NtoLE(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := swap(AValue);
    {$ELSE}
  ToDo('HostToLittleEndian() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

function HostToLittleEndian(const AValue : UInt32) : UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a NtoLE() function in its System unit to
  // "Convert Native-ordered integer to a Little Endian-ordered integer"

  {.$IFDEF FPC}
  //Result := NtoLE(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := swap(AValue shr 16) or (UInt32(swap(AValue and $FFFF)) shl 16);
    {$ELSE}
  ToDo('HostToLittleEndian() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

function HostToLittleEndian(const AValue : Integer) : Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a NtoLE() function in its System unit to
  // "Convert Native-ordered integer to a Little Endian-ordered integer"

  {.$IFDEF FPC}
  //Result := NtoLE(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := swap(AValue);
    {$ELSE}
  ToDo('HostToLittleEndian() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

function LittleEndianToHost(const AValue : UInt16) : UInt16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a LEtoN() function in its System unit to
  // "Convert Little Endian-ordered integer to Native-ordered integer"

  {.$IFDEF FPC}
  //Result := LEtoN(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := swap(AValue);
    {$ELSE}
  ToDo('LittleEndianToHost() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

function LittleEndianToHost(const AValue : UInt32): UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a LEtoN() function in its System unit to
  // "Convert Little Endian-ordered integer to Native-ordered integer"

  {.$IFDEF FPC}
  //Result := LEtoN(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := swap(AValue shr 16) or (UInt32(swap(AValue and $FFFF)) shl 16);
    {$ELSE}
  ToDo('LittleEndianToHost() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

function LittleEndianToHost(const AValue : Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: FreePascal has a LEtoN() function in its System unit to
  // "Convert Little Endian-ordered integer to Native-ordered integer"

  {.$IFDEF FPC}
  //Result := LEtoN(AValue);
  {.$ELSE}
    {$IF DEFINED(ENDIAN_LITTLE)}
  Result := AValue;
    {$ELSEIF DEFINED(ENDIAN_BIG)}
  Result := Swap(AValue);
    {$ELSE}
  ToDo('LittleEndianToHost() is not implemented for this platform yet'); {do not localize}
    {$IFEND}
  {.$ENDIF}
end;

// TODO: add an AIndex parameter
procedure FillBytes(var VBytes : TIdBytes; const ACount : Integer; const AValue : Byte);
var
  I: Integer;
begin
  // RLebeau: FillChar() is bad to use on Delphi/C++Builder 2009+ for filling
  // byte buffers as it is actually designed for filling character buffers
  // instead. Now that Char maps to WideChar, this causes problems for FillChar().

  // TODO: optimize this
  for I := 0 to ACount-1 do begin
    VBytes[I] := AValue;
  end;
end;

// RLebeau 10/22/2013: prior to Delphi 2010, fmCreate was an all-encompassing
// bitmask, no other flags could be combined with it.  The RTL was updated in
// Delphi 2010 to allow other flags to be specified along with fmCreate.  So
// at best, we will now be able to allow read-only access to other processes
// in Delphi 2010 and later, and at worst we will continue having exclusive
// rights to the file in Delphi 2009 and earlier, just like we always did...

constructor TIdFileCreateStream.Create(const AFile : String);
begin
  inherited Create(AFile, fmCreate or fmOpenReadWrite or fmShareDenyWrite);
end;

constructor TIdAppendFileStream.Create(const AFile : String);
begin
  if FileExists(AFile) then begin
    inherited Create(AFile, fmOpenReadWrite or fmShareDenyWrite);
    TIdStreamHelper.Seek(Self, 0, soEnd);
  end
  else begin
    inherited Create(AFile, fmCreate or fmOpenReadWrite or fmShareDenyWrite);
  end;
end;

constructor TIdReadFileNonExclusiveStream.Create(const AFile : String);
begin
  inherited Create(AFile, fmOpenRead or fmShareDenyNone);
end;

constructor TIdReadFileExclusiveStream.Create(const AFile : String);
begin
  inherited Create(AFile, fmOpenRead or fmShareDenyWrite);
end;

function IsASCIILDH(const AByte: Byte): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := True;
  //Verify the absence of non-LDH ASCII code points; that is, the
  //absence of 0..2C, 2E..2F, 3A..40, 5B..60, and 7B..7F.
  //Permissable chars are in this set
  //['-','0'..'9','A'..'Z','a'..'z']
  if AByte <= $2C then begin
    Result := False;
  end
  else if (AByte >= $2E) and (AByte <= $2F) then begin
    Result := False;
  end
  else if (AByte >= $3A) and (AByte <= $40) then begin
    Result := False;
  end
  else if (AByte >= $5B) and (AByte <= $60) then begin
    Result := False;
  end
  else if (AByte >= $7B) and (AByte <= $7F) then begin
    Result := False;
  end;
end;

function IsASCIILDH(const ABytes: TIdBytes): Boolean;
var
  i: Integer;
begin
  for i := 0 to Length(ABytes)-1 do begin
    if not IsASCIILDH(ABytes[i]) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function IsASCII(const AByte: Byte): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AByte <= $7F;
end;

function IsASCII(const ABytes: TIdBytes): Boolean;
var
  i: Integer;
begin
  for i := 0 to Length(ABytes) -1 do begin
    if not IsASCII(ABytes[i]) then begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function StartsWithACE(const ABytes: TIdBytes): Boolean;
const
  cDash = Ord('-');
var
  LS: {$IFDEF STRING_IS_IMMUTABLE}TIdStringBuilder{$ELSE}string{$ENDIF};
begin
  Result := False;
  if Length(ABytes) >= 4 then
  begin
    if (ABytes[2] = cDash) and (ABytes[3] = cDash) then
    begin
      // TODO: just do byte comparisons so String conversions are not needed...
      {$IFDEF STRING_IS_IMMUTABLE}
      LS := TIdStringBuilder.Create(2);
      LS.Append(Char(ABytes[0]));
      LS.Append(Char(ABytes[1]));
      {$ELSE}
      SetLength(LS, 2);
      LS[1] := Char(ABytes[0]);
      LS[2] := Char(ABytes[1]);
      {$ENDIF}
      Result := PosInStrArray(LS{$IFDEF STRING_IS_IMMUTABLE}.ToString{$ENDIF},
        ['bl','bq','dq','lq','mq','ra','wq','zq'], False) > -1;{do not localize}
    end;
  end;
end;

function PosInSmallIntArray(const ASearchInt: Int16; const AArray: array of Int16): Integer;
begin
  for Result := Low(AArray) to High(AArray) do begin
    if ASearchInt = AArray[Result] then begin
      Exit;
    end;
  end;
  Result := -1;
end;

{This searches an array of string for an occurance of SearchStr}
function PosInStrArray(const SearchStr: string; const Contents: array of string; const CaseSensitive: Boolean = True): Integer;
begin
  for Result := Low(Contents) to High(Contents) do begin
    if CaseSensitive then begin
      if SearchStr = Contents[Result] then begin
        Exit;
      end;
    end else begin
      if TextIsSame(SearchStr, Contents[Result]) then begin
        Exit;
      end;
    end;
  end;
  Result := -1;
end;

//IPv4 address conversion
function ByteToHex(const AByte: Byte): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
{$IFDEF STRING_IS_IMMUTABLE}
var
  LSB: TIdStringBuilder;
{$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(2);
  LSB.Append(IdHexDigits[(AByte and $F0) shr 4]);
  LSB.Append(IdHexDigits[AByte and $F]);
  Result := LSB.ToString;
  {$ELSE}
  SetLength(Result, 2);
  Result[1] := IdHexDigits[(AByte and $F0) shr 4];
  Result[2] := IdHexDigits[AByte and $F];
  {$ENDIF}
end;

function UInt32ToHex(const ALongWord : UInt32) : String;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ByteToHex((ALongWord shr 24) and $FF)
            + ByteToHex((ALongWord shr 16) and $FF)
            + ByteToHex((ALongWord shr 8) and $FF)
            + ByteToHex(ALongWord and $FF);

end;

function ToHex(const AValue: TIdBytes; const ACount: Integer = -1;
  const AIndex: Integer = 0): string;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I, LCount: Integer;
  CH1, CH2: Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ELSE}
  LOffset: Integer;
  {$ENDIF}
begin
  Result := '';
  LCount := IndyLength(AValue, ACount, AIndex);
  if LCount > 0 then begin
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB := TIdStringBuilder.Create(LCount*2);
    {$ELSE}
    SetLength(Result, LCount*2);
    LOffset := 0;
    {$ENDIF}
    for I := 0 to LCount-1 do begin
      CH1 := IdHexDigits[(AValue[AIndex+I] and $F0) shr 4];
      CH2 := IdHexDigits[AValue[AIndex+I] and $F];
      {$IFDEF STRING_IS_IMMUTABLE}
      LSB.Append(CH1);
      LSB.Append(CH2);
      {$ELSE}
      Result[LOffset+1] := CH1;
      Result[LOffset+2] := CH2;
      Inc(LOffset, 2);
      {$ENDIF}
    end;
    {$IFDEF STRING_IS_IMMUTABLE}
    Result := LSB.ToString;
    {$ENDIF}
  end;
end;

function ToHex(const AValue: array of UInt32): string;
var
  P: PByteArray;
  i, j, LCount: Integer;
  CH1, CH2: Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ELSE}
  LOffset: Integer;
  {$ENDIF}
begin
  Result := '';
  LCount := Length(AValue);
  if LCount > 0 then
  begin
    LCount := LCount * SizeOf(UInt32) * 2;
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB := TIdStringBuilder.Create(LCount);
    {$ELSE}
    SetLength(Result, LCount);
    LOffset := 0;
    {$ENDIF}
    for i := Low(AValue) to High(AValue) do begin
      P := PByteArray(@AValue[i]);
      for j := 0 to SizeOf(UInt32)-1 do begin
        CH1 := IdHexDigits[(P{$IFNDEF STRING_IS_IMMUTABLE}^{$ENDIF}[j] and $F0) shr 4];
        CH2 := IdHexDigits[P{$IFNDEF STRING_IS_IMMUTABLE}^{$ENDIF}[j] and $F];
        {$IFDEF STRING_IS_IMMUTABLE}
        LSB.Append(CH1);
        LSB.Append(CH2);
        {$ELSE}
        Result[LOffset+1] := CH1;
        Result[LOffset+2] := CH2;
        Inc(LOffset, 2);
        {$ENDIF}
      end;
    end;//for
    {$IFDEF STRING_IS_IMMUTABLE}
    Result := LSB.ToString;
    {$ENDIF}
  end;
end;

function IPv4ToHex(const AIPAddress: string; const ADotted: Boolean): string;
var
  i: Integer;
  LBuf, LTmp: string;
begin
  LBuf := Trim(AIPAddress);
  Result := IdHexPrefix;
  for i := 0 to 3 do begin
    LTmp := ByteToHex(IndyStrToInt(Fetch(LBuf, '.', True)));
    if ADotted then begin
      Result := Result + '.' + IdHexPrefix + LTmp;
    end else begin
      Result := Result + LTmp;
    end;
  end;
end;

function OctalToInt64(const AValue: string): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AValue) do begin
    Result := (Result shl 3) +  IndyStrToInt(AValue[i], 0);
  end;
end;

function ByteToOctal(const AByte: Byte): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  C: Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ELSE}
  LOffset: Integer;
  {$ENDIF}
begin
  C := IdOctalDigits[(AByte shr 6) and $7];
  {$IFDEF STRING_IS_IMMUTABLE}
  if C <> '0' then begin
    LSB := TIdStringBuilder.Create(4);
    LSB.Append(Char('0')); {do not localize}
  end else begin
    LSB := TIdStringBuilder.Create(3);
  end;
  LSB.Append(C);
  LSB.Append(IdOctalDigits[(AByte shr 3) and $7]);
  LSB.Append(IdOctalDigits[AByte and $7]);
  Result := LSB.ToString;
  {$ELSE}
  if C <> '0' then begin
    SetLength(Result, 4);
    Result[1] := '0'; {do not localize}
    LOffset := 2;
  end else begin
    SetLength(Result, 3);
    LOffset := 1;
  end;
  Result[LOffset+0] := C;
  Result[LOffset+1] := IdOctalDigits[(AByte shr 3) and $7];
  Result[LOffset+2] := IdOctalDigits[AByte and $7];
  {$ENDIF}
end;

function IPv4ToOctal(const AIPAddress: string): string;
var
  i: Integer;
  LBuf: string;
begin
  LBuf := Trim(AIPAddress);
  Result := ByteToOctal(IndyStrToInt(Fetch(LBuf, '.', True), 0));
  for i := 0 to 2 do begin
    Result := Result + '.' + ByteToOctal(IndyStrToInt(Fetch(LBuf, '.', True), 0));
  end;
end;

procedure CopyTIdBytes(const ASource: TIdBytes; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //if these asserts fail, then it indicates an attempted buffer overrun.
  Assert(ASourceIndex >= 0);
  Assert((ASourceIndex+ALength) <= Length(ASource));
  Move(ASource[ASourceIndex], VDest[ADestIndex], ALength);
end;

procedure CopyTIdChar(const ASource: Char; var VDest: TIdBytes; const ADestIndex: Integer;
  ADestEncoding: IIdTextEncoding = nil);
begin
  EnsureEncoding(ADestEncoding);
  ADestEncoding.GetBytes(@ASource, 1, VDest, ADestIndex);
end;

procedure CopyTIdInt16(const ASource: Int16; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PInt16(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdUInt16(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PUInt16(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdUInt32(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PUInt32(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdInt32(const ASource: Int32; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PInt32(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdInt64(const ASource: Int64; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PInt64(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdUInt64(const ASource: UInt64; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  PUInt64(@VDest[ADestIndex])^ := ASource;
end;

procedure CopyTIdTicks(const ASource: TIdTicks; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  CopyTIdUInt64(ASource, VDest, ADestIndex);
end;

procedure CopyTIdIPV6Address(const ASource: TIdIPv6Address; var VDest: TIdBytes; const ADestIndex: Integer);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Move(ASource, VDest[ADestIndex], 16);
end;

procedure CopyTIdByteArray(const ASource: array of Byte; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer);
begin
  Move(ASource[ASourceIndex], VDest[ADestIndex], ALength);
end;

procedure CopyTIdString(const ASource: String; var VDest: TIdBytes;
  const ADestIndex: Integer; const ALength: Integer = -1;
  ADestEncoding: IIdTextEncoding = nil); overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  CopyTIdString(ASource, 1, VDest, ADestIndex, ALength, ADestEncoding);
end;

procedure CopyTIdString(const ASource: String; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer = -1;
  ADestEncoding: IIdTextEncoding = nil); overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LLength: Integer;
begin
  LLength := IndyLength(ASource, ALength, ASourceIndex);
  if LLength > 0 then begin
    EnsureEncoding(ADestEncoding);
    ADestEncoding.GetBytes(ASource, ASourceIndex, LLength, VDest, ADestIndex);
  end;
end;

// TODO: define STRING_UNICODE_MISMATCH for WinCE in IdCompilerDefines.inc?
{$IF DEFINED(WINDOWS) AND (NOT DEFINED(WINCE)) AND DEFINED(STRING_UNICODE_MISMATCH)}
  {$DEFINE DEBUG_STRING_MISMATCH}
{$IFEND}

procedure DebugOutput(const AText: string);
{$IFNDEF DEBUG_STRING_MISMATCH}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  // TODO: support other debugging platforms

  {$IFDEF WINDOWS}
  OutputDebugString(
    {$IFDEF DEBUG_STRING_MISMATCH}
    PIdPlatformChar(TIdPlatformString(AText)) // explicit convert to Ansi/Unicode
    {$ELSE}
    PChar(AText)
    {$ENDIF}
  );
  {$ENDIF}
end;

function CurrentThreadId: TIdThreadID;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: is GetCurrentThreadId() available on Linux?
  Result := GetCurrentThreadID;
end;

function CurrentProcessId: TIdPID;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IF DEFINED(WINDOWS)}
  Result := GetCurrentProcessID;
  {$ELSEIF DEFINED(KYLIXCOMPAT) or DEFINED(USE_VCL_POSIX)}
  Result := getpid;
  {$ELSEIF DEFINED(USE_BASEUNIX)}
  Result := fpgetpid;
  {$ELSE}
  {$message error CurrentProcessId is not implemented on this platform!}
  Result := 0;
  {$IFEND}
end;

function Fetch(var AInput: string; const ADelim: string = IdFetchDelimDefault;
  const ADelete: Boolean = IdFetchDeleteDefault;
  const ACaseSensitive: Boolean = IdFetchCaseSensitiveDefault): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LPos: Integer;
begin
  if ACaseSensitive then begin
    if ADelim = #0 then begin
      // AnsiPos does not work with #0
      LPos := Pos(ADelim, AInput);
    end else begin
      LPos := IndyPos(ADelim, AInput);
    end;
    if LPos = 0 then begin
      Result := AInput;
      if ADelete then begin
        AInput := '';    {Do not Localize}
      end;
    end
    else begin
      Result := Copy(AInput, 1, LPos - 1);
      if ADelete then begin
        //slower Delete(AInput, 1, LPos + Length(ADelim) - 1); because the
        //remaining part is larger than the deleted
        AInput := Copy(AInput, LPos + Length(ADelim), MaxInt);
      end;
    end;
  end else begin
    Result := FetchCaseInsensitive(AInput, ADelim, ADelete);
  end;
end;

function FetchCaseInsensitive(var AInput: string; const ADelim: string;
  const ADelete: Boolean): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LPos: Integer;
begin
  if ADelim = #0 then begin
    // AnsiPos does not work with #0
    LPos := Pos(ADelim, AInput);
  end else begin
    //? may be AnsiUpperCase?
    LPos := IndyPos(UpperCase(ADelim), UpperCase(AInput));
  end;
  if LPos = 0 then begin
    Result := AInput;
    if ADelete then begin
      AInput := '';    {Do not Localize}
    end;
  end else begin
    Result := Copy(AInput, 1, LPos - 1);
    if ADelete then begin
      //faster than Delete(AInput, 1, LPos + Length(ADelim) - 1); because the
      //remaining part is larger than the deleted
      AInput := Copy(AInput, LPos + Length(ADelim), MaxInt);
    end;
  end;
end;

function GetThreadHandle(AThread: TThread): TIdThreadHandle;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IF DEFINED(UNIX)}
  Result := AThread.ThreadID; // RLebeau: is it right to return an ID where a thread object handle is expected instead?
  {$ELSEIF DEFINED(WINDOWS)}
  Result := AThread.Handle;
  {$ELSE}
  ToDo('GetThreadHandle() is not implemented for this platform yet'); {do not localize}
  {$IFEND}
end;

// RLebeau: breaking up the Ticks64() implementation into separate platform blocks,
// instead of trying to do it all in one implementation.  This way, the code is
// cleaner, and if I miss a platform then the compiler should complain about Ticks64()
// being unresolved...

// TODO: move these to platform-specific units instead, maybe even to the TIdStack classes?

{$IF DEFINED(WINDOWS)}
type
  TGetTickCount64Func = function: UInt64; stdcall;

var
  GetTickCount64: TGetTickCount64Func = nil;

{.$DEFINE USE_NtQuerySystemInformation}
{$IFDEF USE_NtQuerySystemInformation}

type
  TNtQuerySystemInformationFunc = function(SystemInformationClass: Int32; SystemInformation: Pointer; SystemInformationLength: ULONG; ReturnLength: PULONG): NTSTATUS; stdcall;

var
  NtQuerySystemInformation: TNtQuerySystemInformationFunc = nil;
  hNtDLL: TIdLibHandle = IdNilHandle;

function Impl_NtQuerySystemInformation(SystemInformationClass: Int32; SystemInformation: Pointer; SystemInformationLength: ULONG; ReturnLength: PULONG): NTSTATUS; stdcall;
begin
  Result := STATUS_NOT_IMPLEMENTED;
end;

function Stub_NtQuerySystemInformation(SystemInformationClass: Int32; SystemInformation: Pointer; SystemInformationLength: ULONG; ReturnLength: PULONG): NTSTATUS; stdcall;

  function Get_Impl: Pointer;
  begin
    Result := nil;
    if hNtDLL = IdNilHandle then begin
      hNtDLL := LoadLibrary('NTDLL.DLL');
    end;
    if hNtDll <> IdNilHandle then begin
      Result := GetProcAddress(hNtDll, 'NtQuerySystemInformation');
    end;
    if Result = nil then begin
      Result := @Impl_NtQuerySystemInformation;
    end;
  end;

begin
  @NtQuerySystemInformation := GetImpl;
  Result := NtQuerySystemInformation(SystemInformationClass, SystemInformation, SystemInformationLength, ReturnLength);
end;

function Impl_GetTickCount64: UInt64; stdcall;
type
  SYSTEM_TIMEOFDAY_INFORMATION = packed record
    BootTime: LARGE_INTEGER;
    CurrentTime: LARGE_INTEGER;
    TimeZoneBias: LARGE_INTEGER;
    TimeZoneId: ULONG;
    Reserved: ULONG;
    BootTimeBias: ULONGLONG;
    SleepTimeBias: ULONGLONG;
  end;
const
  SystemTimeOfDayInformation = $0003;
var
  tdi: SYSTEM_TIMEOFDAY_INFORMATION;
  status: NTSTATUS;
begin
  // Calculate the system uptime and convert it from 100 nanoseconds intervals to milliseconds
  status := NtQuerySystemInformation(SystemTimeOfDayInformation, @tdi, sizeof(tdi), nil);
  if NT_SUCCESS(status) then begin
     Result := UInt64((tdi.CurrentTime.QuadPart - tdi.BootTime.QuadPart) div 10000);
  end else begin
    // fallback for now...
    Result := UInt64(Windows.GetTickCount);
  end;
end;

{$ELSE}

function Impl_GetTickCount64: UInt64; stdcall;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: implement some kind of accumulator so the Result
  // keeps growing even when GetTickCount() wraps back to 0.
  // Or maybe access the CPU's TSC via the x86 RDTSC instruction...
  Result := UInt64(Windows.GetTickCount);
end;

{$ENDIF}

function Stub_GetTickCount64: UInt64; stdcall;

  function GetImpl: Pointer;
  begin
    Result := LoadLibFunction(GetModuleHandle('KERNEL32'), 'GetTickCount64'); {do not localize}
    if Result = nil then begin
      Result := @Impl_GetTickCount64;
    end;
  end;

begin
  @GetTickCount64 := GetImpl();
  Result := GetTickCount64();
end;

function Ticks64: TIdTicks;
  {$IFDEF USE_HI_PERF_COUNTER_FOR_TICKS}
var
  nTime, freq: {$IFDEF WINCE}LARGE_INTEGER{$ELSE}Int64{$ENDIF};
{$ENDIF}
begin
  // S.G. 27/11/2002: Changed to use high-performance counters as per suggested
  // S.G. 27/11/2002: by David B. Ferguson (david.mcs@ns.sympatico.ca)

  // RLebeau 11/12/2009: removed the high-performance counters again.  They
  // are not reliable on multi-core systems, and are now starting to cause
  // problems with TIdIOHandler.ReadLn() timeouts under Windows XP SP3, both
  // 32-bit and 64-bit.  Refer to these discussions:
  //
  // http://www.virtualdub.org/blog/pivot/entry.php?id=106
  // http://blogs.msdn.com/oldnewthing/archive/2008/09/08/8931563.aspx

  {$IFDEF USE_HI_PERF_COUNTER_FOR_TICKS}
  if Windows.QueryPerformanceCounter({$IFDEF WINCE}@{$ENDIF}nTime) then begin
    if Windows.QueryPerformanceFrequency({$IFDEF WINCE}@{$ENDIF}freq) then begin
      Result := Trunc((nTime{$IFDEF WINCE}.QuadPart{$ENDIF} / Freq{$IFDEF WINCE}.QuadPart{$ENDIF}) * 1000) and High(TIdTicks);
      Exit;
    end;
  end;
  {$ENDIF}

  Result := TIdTicks(GetTickCount64());
end;

{$ELSEIF DEFINED(USE_clock_gettime)}

  {$IF DEFINED(LINUX)}
// according to Linux's /usr/include/linux/time.h
const
  CLOCK_MONOTONIC = 1;
  {$ELSEIF DEFINED(FREEBSD)}
// according to FreeBSD's /usr/include/time.h
const
  CLOCK_MONOTONIC = 4;
  {$ELSEIF DEFINED(ANDROID)}
// according to Android NDK's /include/time.h
const
  CLOCK_MONOTONIC = 1;
  {$IFEND}

function clock_gettime(clockid: Integer; var pts: timespec): Integer; cdecl; external 'libc';

function Ticks64: TIdTicks;
var
  ts: timespec;
begin
  // TODO: use CLOCK_BOOTTIME on platforms that support it?  It takes system
  // suspension into account, whereas CLOCK_MONOTONIC does not...
  clock_gettime(CLOCK_MONOTONIC, ts);

  {$I IdRangeCheckingOff.inc}
  {$I IdOverflowCheckingOff.inc}
  Result := (Int64(ts.tv_sec) * 1000) + (ts.tv_nsec div 1000000);
  {$I IdOverflowCheckingOn.inc}
  {$I IdRangeCheckingOn.inc}
end;

{$ELSEIF DEFINED(UNIX)}

  {$IF DEFINED(OSX) AND DEFINED(FPC)}
//RLebeau: FPC does not provide mach_timebase_info() and mach_absolute_time() yet...
function mach_timebase_info(var TimebaseInfoData: TTimebaseInfoData): Integer; cdecl; external 'libc';
function mach_absolute_time: QWORD; cdecl; external 'libc';
  {$IFEND}

function Ticks64: TIdTicks;
  {$IFDEF OSX}
    {$IFDEF USE_INLINE} inline;{$ENDIF}
  {$ELSE}
var
  tv: timeval;
  {$ENDIF}
begin
  {$IFDEF OSX}

  // TODO: mach_absolute_time() does NOT count ticks while the system is
  // sleeping! We can use time() to account for that:
  //
  // "time() carries on incrementing while the device is asleep, but of
  // course can be manipulated by the operating system or user. However,
  // the Kernel boottime (a timestamp of when the system last booted)
  // also changes when the system clock is changed, therefore even though
  // both these values are not fixed, the offset between them is."
  //
  // time_t uptime()
  // {
  //   struct timeval boottime;
  //   int mib[2] = {CTL_KERN, KERN_BOOTTIME};
  //   size_t size = sizeof(boottime);
  //   time_t now;
  //   time_t uptime = -1;
  //   time(&now);
  //   if ((sysctl(mib, 2, &boottime, &size, NULL, 0) != -1) && (boottime.tv_sec != 0))
  //   {
  //     uptime = now - boottime.tv_sec;
  //   }
  //   return uptime;
  // }
  //
  // However, KERN_BOOTTIME only has *seconds* precision (timeval.tv_usecs is always 0).

  // mach_absolute_time() returns billionth of seconds, so divide by one million to get milliseconds
  Result := (mach_absolute_time() * GMachTimeBaseInfo.numer) div (1000000 * GMachTimeBaseInfo.denom);

  {$ELSE}

  // TODO: raise an exception if gettimeofday() fails...

    {$IF DEFINED(KYLIXCOMPAT) OR DEFINED(USE_VCL_POSIX)}
  gettimeofday(tv, nil);
    {$ELSEIF DEFINED(USE_BASEUNIX)}
  fpgettimeofday(@tv,nil);
    {$ELSE}
  {$message error gettimeofday is not called on this platform!}
  FillChar(tv, sizeof(tv), 0);
    {$IFEND}

  {
  I've implemented this correctly for now. I'll argue for using
  an int64 internally, since apparently quite some functionality
  (throttle, etc etc) depends on it, and this value may wrap
  at any point in time.
  For Windows: Uptime > 72 hours isn't really that rare any more,
  For Linux: no control over when this wraps.

  IdEcho has code to circumvent the wrap, but its not very good
  to have code for that at all spots where it might be relevant.
  }

  {$I IdRangeCheckingOff.inc}
  Result := (Int64(tv.tv_sec) * 1000) + (tv.tv_usec div 1000);
  {$I IdRangeCheckingOn.inc}

  {$ENDIF}

end;

{$ELSE}

function Ticks64: TIdTicks;
begin
  {$message error Ticks64 is not implemented on this platform!}
  Result := 0;
end;

{$IFEND}

function GetTickDiff(const AOldTickCount, ANewTickCount: UInt32): UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {This is just in case the TickCount rolled back to zero}
  if ANewTickCount >= AOldTickCount then begin
    Result := ANewTickCount - AOldTickCount;
  end else begin
    Result := ((High(UInt32) - AOldTickCount) + ANewTickCount) + 1;
  end;
end;

function GetTickDiff64(const AOldTickCount, ANewTickCount: TIdTicks): TIdTicks;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {This is just in case the TickCount rolled back to zero}
  if ANewTickCount >= AOldTickCount then begin
    Result := TIdTicks(ANewTickCount - AOldTickCount);
  end else begin
    Result := TIdTicks(((High(TIdTicks) - AOldTickCount) + ANewTickCount) + 1);
  end;
end;

function GetElapsedTicks(const AOldTickCount: TIdTicks): UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := UInt32(GetTickDiff64(AOldTickCount, Ticks64));
end;

function GetElapsedTicks64(const AOldTickCount: TIdTicks): TIdTicks;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := GetTickDiff64(AOldTickCount, Ticks64);
end;

// TODO: define STRING_UNICODE_MISMATCH for WinCE in IdCompilerDefines.inc?
{$IF DEFINED(WINDOWS) AND (NOT DEFINED(WINCE)) AND DEFINED(STRING_UNICODE_MISMATCH)}
  {$DEFINE SERVICE_STRING_MISMATCH}
{$IFEND}

function ServicesFilePath: string;
var
  sLocation: {$IFDEF SERVICE_STRING_MISMATCH}TIdPlatformString{$ELSE}string{$ENDIF};
begin
  {$IF DEFINED(UNIX)}

  sLocation := '/etc/';  // assume Berkeley standard placement   {do not localize}

  {$ELSEIF DEFINED(WINDOWS)}

    {$IFNDEF WINCE}
  SetLength(sLocation, MAX_PATH);
  SetLength(sLocation, GetWindowsDirectory(PIdPlatformChar(sLocation), MAX_PATH));
  sLocation := IndyIncludeTrailingPathDelimiter(string(sLocation));
  if IndyWindowsPlatform = VER_PLATFORM_WIN32_NT then begin
    sLocation := sLocation + 'system32\drivers\etc\'; {do not localize}
  end;
    {$ELSE}
  // GetWindowsDirectory() does not exist in WinCE, and there is no system folder, either
  sLocation := '\Windows\'; {do not localize}
    {$ENDIF}

  {$IFEND}

  Result := sLocation + 'services'; {do not localize}
end;


// IdPorts returns a list of defined ports in /etc/services
function IdPorts: TIdPortList;
var
  s: string;
  idx, iPosSlash: {$IFDEF BYTE_COMPARE_SETS}Byte{$ELSE}Integer{$ENDIF};
  i: {$IFDEF HAS_GENERICS_TList}Integer{$ELSE}PtrInt{$ENDIF};
  iPrev: PtrInt;
  sl: TStringList;
begin
  if GIdPorts = nil then
  begin
    GIdPorts := TIdPortList.Create;
    sl := TStringList.Create;
    try
      // TODO: use TStreamReader instead, on versions that support it
      sl.LoadFromFile(ServicesFilePath);  {do not localize}
      iPrev := 0;
      for idx := 0 to sl.Count - 1 do
      begin
        s := sl[idx];
        iPosSlash := IndyPos('/', s);   {do not localize}
        if (iPosSlash > 0) and (not (IndyPos('#', s) in [1..iPosSlash])) then {do not localize}
        begin // presumably found a port number that isn't commented    {Do not Localize}
          i := iPosSlash;
          repeat
            Dec(i);
            if i = 0 then begin
              raise EIdCorruptServicesFile.CreateFmt(RSCorruptServicesFile, [ServicesFilePath]); {do not localize}
            end;
          //TODO: Make Whitespace a function to elim warning
          until Ord(s[i]) in IdWhiteSpace;
          i := IndyStrToInt(Copy(s, i+1, iPosSlash-i-1));
          if i <> iPrev then begin
            GIdPorts.Add(
              {$IFDEF HAS_GENERICS_TList}i{$ELSE}Pointer(i){$ENDIF}
            );
          end;
          iPrev := i;
        end;
      end;
    finally
      sl.Free;
    end;
  end;
  Result := GIdPorts;
end;

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: string; const AFalse: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(const AEncoding, ADefEncoding: IIdTextEncoding; ADefEncodingType: IdTextEncodingType = encASCII): IIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AEncoding;
  if Result = nil then
  begin
    Result := ADefEncoding;
    EnsureEncoding(Result, ADefEncodingType);
  end;
end;

function InMainThread: Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := GetCurrentThreadID = MainThreadID;
end;

procedure WriteMemoryStreamToStream(Src: TMemoryStream; Dest: TStream; Count: Int64);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Dest.WriteBuffer(Src.Memory^, Count);
end;

function IsCurrentThread(AThread: TThread): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AThread.ThreadID = GetCurrentThreadID;
end;

//convert a dword into an IPv4 address in dotted form
function MakeUInt32IntoIPv4Address(const ADWord: UInt32): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IntToStr((ADWord shr 24) and $FF) + '.';
  Result := Result + IntToStr((ADWord shr 16) and $FF) + '.';
  Result := Result + IntToStr((ADWord shr 8) and $FF) + '.';
  Result := Result + IntToStr(ADWord and $FF);
end;

function IsAlpha(const AChar: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: under XE3.5+, use TCharHelper.IsLetter() instead
  // TODO: under D2009+, use TCharacter.IsLetter() instead

  // Do not use IsCharAlpha or IsCharAlphaNumeric - they are Win32 routines
  Result := ((AChar >= 'a') and (AChar <= 'z')) or ((AChar >= 'A') and (AChar <= 'Z')); {Do not Localize}
end;

function IsAlpha(const AString: String; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  LLen: Integer;
begin
  Result := False;
  LLen := IndyLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for i := 0 to LLen-1 do begin
      if not IsAlpha(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

function IsAlphaNumeric(const AChar: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // Do not use IsCharAlpha or IsCharAlphaNumeric - they are Win32 routines
  Result := IsAlpha(AChar) or IsNumeric(AChar);
end;

function IsAlphaNumeric(const AString: String; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  LLen: Integer;
begin
  Result := False;
  LLen := IndyLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for i := 0 to LLen-1 do begin
      if not IsAlphaNumeric(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

function IsOctal(const AChar: Char): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := (AChar >= '0') and (AChar <= '7') {Do not Localize}
end;

function IsOctal(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  LLen: Integer;
begin
  Result := False;
  LLen := IndyLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for i := 0 to LLen-1 do begin
      if not IsOctal(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

function IsHexidecimal(const AChar: Char): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ((AChar >= '0') and (AChar <= '9'))  {Do not Localize}
         or ((AChar >= 'A') and (AChar <= 'F'))  {Do not Localize}
         or ((AChar >= 'a') and (AChar <= 'f')); {Do not Localize}
end;

function IsHexidecimal(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  LLen: Integer;
begin
  Result := False;
  LLen := IndyLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for i := 0 to LLen-1 do begin
      if not IsHexidecimal(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

{$I IdHintsOff.inc}
function IsNumeric(const AString: string): Boolean;
var
  LCode: Integer;
  LVoid: Int64;
begin
  Val(AString, LVoid, LCode);
  Result := LCode = 0;
end;
{$I IdHintsOn.inc}

function IsNumeric(const AString: string; const ALength: Integer; const AIndex: Integer = 1): Boolean;
var
  I: Integer;
  LLen: Integer;
begin
  Result := False;
  LLen := IndyLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for I := 0 to LLen-1 do begin
      if not IsNumeric(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

function IsNumeric(const AChar: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: under XE3.5+, use TCharHelper.IsDigit() instead
  // TODO: under D2009+, use TCharacter.IsDigit() instead

  // Do not use IsCharAlpha or IsCharAlphaNumeric - they are Win32 routines
  Result := (AChar >= '0') and (AChar <= '9'); {Do not Localize}
end;

function IPv4MakeUInt32InRange(const AInt: Int64; const A256Power: Integer): UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
//Note that this function is only for stripping off some extra bits
//from an address that might appear in some spam E-Mails.
begin
  case A256Power of
    4: Result := (AInt and POWER_4);
    3: Result := (AInt and POWER_3);
    2: Result := (AInt and POWER_2);
  else
    Result := (AInt and POWER_1);
  end;
end;

function IPv4ToUInt32(const AIPAddress: string): UInt32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
begin
  Result := IPv4ToUInt32(AIPAddress, LErr);
end;

function IPv4ToUInt32(const AIPAddress: string; var VErr: Boolean): UInt32;
var
  LBuf, LBuf2: string;
  L256Power: Integer;
  LParts: Integer; //how many parts should we process at a time
begin
  VErr := True;
  Result := 0;
  // S.G. 11/8/2003: Added overflow checking disabling and change multiplys by SHLs.
  // Locally disable overflow checking so we can safely use SHL and SHR
  {$I IdOverflowCheckingOff.inc}
  L256Power := 4;
  LBuf2 := AIPAddress;
  repeat
    LBuf := Fetch(LBuf2, '.');
    if LBuf = '' then begin
      Break;
    end;
    //We do things this way because we have to treat
    //IP address parts differently than a whole number
    //and sometimes, there can be missing periods.
    if (LBuf2 = '') and (L256Power > 1) then begin
      LParts := L256Power;
      Result := Result shl (L256Power SHL 3);
    end else begin
      LParts := 1;
      Result := Result shl 8;
    end;
    if TextStartsWith(LBuf, IdHexPrefix) then begin
      //this is a hexideciaml number
      if not IsHexidecimal(Copy(LBuf, 3, MaxInt)) then begin
        Exit;
      end;
      Result := Result + IPv4MakeUInt32InRange(StrToInt64Def(LBuf, 0), LParts);
    end else begin
      if not IsNumeric(LBuf) then begin
        //There was an error meaning an invalid IP address
        Exit;
      end;
      if TextStartsWith(LBuf, '0') and IsOctal(LBuf) then begin {do not localize}
        //this is octal
        Result := Result + IPv4MakeUInt32InRange(OctalToInt64(LBuf), LParts);
      end else begin
        //this must be a decimal
        Result :=  Result + IPv4MakeUInt32InRange(StrToInt64Def(LBuf, 0), LParts);
      end;
    end;
    Dec(L256Power);
  until False;
  VErr := False;
  // Restore overflow checking
  {$I IdOverflowCheckingOn.inc}
end;

function IPv6AddressToStr(const AValue: TIdIPv6Address): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
begin
  Result := IntToHex(AValue[0], 4);
  for i := 1 to 7 do begin
    Result := Result + ':' + IntToHex(AValue[i], 4);
  end;
end;

function MakeCanonicalIPv4Address(const AAddr: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
  LIP: UInt32;
begin
  LIP := IPv4ToUInt32(AAddr, LErr);
  if LErr then begin
    Result := '';
  end else begin
    Result := MakeUInt32IntoIPv4Address(LIP);
  end;
end;

function MakeCanonicalIPv6Address(const AAddr: string): string;
// return an empty string if the address is invalid,
// for easy checking if its an address or not.
var
  p, i: Integer;
  {$IFDEF BYTE_COMPARE_SETS}
  dots, colons: Byte;
  {$ELSE}
  dots, colons: Integer;
  {$ENDIF}
  colonpos: array[1..8] of Integer;
  dotpos: array[1..3] of Integer;
  LAddr: string;
  num: Integer;
  haddoublecolon: boolean;
  fillzeros: Integer;
begin
  Result := ''; // error
  LAddr := AAddr;
  if LAddr = '' then begin
    Exit;
  end;
  if TextStartsWith(LAddr, ':') then begin
    LAddr := '0' + LAddr;
  end;
  if TextEndsWith(LAddr, ':') then begin
    LAddr := LAddr + '0';
  end;
  dots := 0;
  colons := 0;
  for p := 1 to Length(LAddr) do begin
    case LAddr[p] of
      '.': begin
              Inc(dots);
              if dots < 4 then begin
                dotpos[dots] := p;
              end else begin
                Exit; // error in address
              end;
            end;
      ':': begin
              Inc(colons);
              if colons < 8 then begin
                colonpos[colons] := p;
              end else begin
                Exit; // error in address
              end;
            end;
      'a'..'f',
      'A'..'F': if dots > 0 then Exit;
        // allow only decimal stuff within dotted portion, ignore otherwise
      '0'..'9': ; // do nothing
    else
      Exit; // error in address
    end; // case
  end; // for
  if not (dots in [0,3]) then begin
    Exit; // you have to write 0 or 3 dots...
  end;
  if dots = 3 then begin
    if not (colons in [2..6]) then begin
      Exit; // must not have 7 colons if we have dots
    end;
    if colonpos[colons] > dotpos[1] then begin
      Exit; // x:x:x.x:x:x is not valid
    end;
  end else begin
    if not (colons in [2..7]) then begin
      Exit; // must at least have two colons
    end;
  end;

  // now start :-)
  num := IndyStrToInt('$'+Copy(LAddr, 1, colonpos[1]-1), -1);
  if (num < 0) or (num > 65535) then begin
    Exit; // huh? odd number...
  end;
  Result := IntToHex(num, 1) + ':';

  haddoublecolon := False;
  for p := 2 to colons do begin
    if colonpos[p - 1] = colonpos[p]-1 then begin
      if haddoublecolon then begin
        Result := '';
        Exit; // only a single double-dot allowed!
      end;
      haddoublecolon := True;
      fillzeros := 8 - colons;
      if dots > 0 then begin
        Dec(fillzeros);
      end;
      for i := 1 to fillzeros do begin
        Result := Result + '0:'; {do not localize}
      end;
    end else begin
      num := IndyStrToInt('$' + Copy(LAddr, colonpos[p - 1] + 1, colonpos[p] - colonpos[p - 1] - 1), -1);
      if (num < 0) or (num > 65535) then begin
        Result := '';
        Exit; // huh? odd number...
      end;
      Result := Result + IntToHex(num,1) + ':';
    end;
  end; // end of colon separated part

  if dots = 0 then begin
    num := IndyStrToInt('$' + Copy(LAddr, colonpos[colons] + 1, MaxInt), -1);
    if (num < 0) or (num > 65535) then begin
      Result := '';
      Exit; // huh? odd number...
    end;
    Result := Result + IntToHex(num,1) + ':';
  end;

  if dots > 0 then begin
    num := IndyStrToInt(Copy(LAddr, colonpos[colons] + 1, dotpos[1] - colonpos[colons] -1),-1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + IntToHex(num, 2);
    num := IndyStrToInt(Copy(LAddr, dotpos[1]+1, dotpos[2]-dotpos[1]-1),-1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + IntToHex(num, 2) + ':';

    num := IndyStrToInt(Copy(LAddr, dotpos[2] + 1, dotpos[3] - dotpos[2] -1),-1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + IntToHex(num, 2);
    num := IndyStrToInt(Copy(LAddr, dotpos[3] + 1, 3), -1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + IntToHex(num, 2) + ':';
  end;
  SetLength(Result, Length(Result) - 1);
end;

procedure IPv6ToIdIPv6Address(const AIPAddress: String; var VAddress: TIdIPv6Address);
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
begin
  IPv6ToIdIPv6Address(AIPAddress, VAddress, LErr);
  if LErr then begin
    raise EIdInvalidIPv6Address.CreateFmt(RSInvalidIPv6Address, [AIPAddress]);
  end;
end;

procedure IPv6ToIdIPv6Address(const AIPAddress: String; var VAddress: TIdIPv6Address; var VErr: Boolean);
var
  LAddress: string;
  I: Integer;
begin
  LAddress := MakeCanonicalIPv6Address(AIPAddress);
  VErr := (LAddress = '');
  if VErr then begin
    Exit;
  end;
  for I := 0 to 7 do begin
    VAddress[I] := IndyStrToInt('$' + Fetch(LAddress,':'), 0);
  end;
end;

function IndyMax(const AValueOne, AValueTwo: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function IndyMax(const AValueOne, AValueTwo: Int32): Int32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function IndyMax(const AValueOne, AValueTwo: UInt16): UInt16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

// TODO: validate this with Unicode data
function MemoryPos(const ASubStr: string; MemBuff: PChar; MemorySize: Integer): Integer;
var
  LSearchLength: Integer;
  LS1: Integer;
  LChar: Char;
  LPS, LPM: PChar;
begin
  LSearchLength := Length(ASubStr);
  if (LSearchLength = 0) or (LSearchLength > (MemorySize * SizeOf(Char))) then begin
    Result := 0;
    Exit;
  end;

  LChar := PChar(Pointer(ASubStr))^; //first char
  LPS := PChar(Pointer(ASubStr))+1;//tail string
  LPM := MemBuff;
  LS1 := LSearchLength-1;
  LSearchLength := MemorySize-LS1;//MemorySize-LS+1
  if LS1 = 0 then begin //optimization for freq used LF
    while LSearchLength > 0 do begin
      if LPM^ = LChar then begin
        Result := LPM-MemBuff + 1;
        Exit;
      end;
      Inc(LPM);
      Dec(LSearchLength);
    end;//while
  end else begin
    while LSearchLength > 0 do begin
      if LPM^ = LChar then begin
        Inc(LPM);
        if CompareMem(LPM, LPS, LS1 * SizeOf(Char)) then begin
          Result := LPM - MemBuff;
          Exit;
        end;
      end else begin
        Inc(LPM);
      end;
      Dec(LSearchLength);
    end;
  end;
  Result := 0;
end;

function IndyMin(const AValueOne, AValueTwo: Int32): Int32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function IndyMin(const AValueOne, AValueTwo: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function IndyMin(const AValueOne, AValueTwo: UInt16): UInt16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function PosIdx(const ASubStr, AStr: string; AStartPos: UInt32): UInt32;

  // use best register allocation on Win32
  function FindStr(ALStartPos, EndPos: UInt32; StartChar: Char; const ALStr: string): UInt32;
  begin
    for Result := ALStartPos to EndPos do begin
      if ALStr[Result] = StartChar then begin
        Exit;
      end;
    end;
    Result := 0;
  end;

  // use best register allocation on Win32
  function FindNextStr(ALStartPos, EndPos: UInt32; const ALStr, ALSubStr: string): UInt32;
  begin
    for Result := ALStartPos + 1 to EndPos do begin
      if ALStr[Result] <> ALSubStr[Result - ALStartPos + 1] then begin
        Exit;
      end;
    end;
    Result := 0;
  end;

var
  StartChar: Char;
  LenSubStr, LenStr: UInt32;
  EndPos: UInt32;
begin
  if AStartPos = 0 then begin
    AStartPos := 1;
  end;
  Result := 0;
  LenSubStr := Length(ASubStr);
  LenStr := Length(AStr);
  if (LenSubStr = 0) or (AStr = '') or (LenSubStr > (LenStr - (AStartPos - 1))) then begin
    Exit;
  end;
  StartChar := ASubStr[1];
  EndPos := LenStr - LenSubStr + 1;
  if LenSubStr = 1 then begin
    Result := FindStr(AStartPos, EndPos, StartChar, AStr)
  end else
  begin
    repeat
      Result := FindStr(AStartPos, EndPos, StartChar, AStr);
      if Result = 0 then begin
        Break;
      end;
      AStartPos := Result;
      Result := FindNextStr(Result, AStartPos + LenSubStr - 1, AStr, ASubStr);
      if Result = 0 then
      begin
        Result := AStartPos;
        Exit;
      end;
      Inc(AStartPos);
    until False;
  end;
end;

function InternalSBPos(const Substr, S: string): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // Necessary because of "Compiler magic"
  Result := Pos(Substr, S);
end;

function InternalSBStrScan(Str: PChar; Chr: Char): PChar;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.StrScan(Str, Chr);
end;

//Don't rename this back to AnsiPos because that conceals a symbol in Windows
function InternalAnsiPos(const Substr, S: string): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.AnsiPos(Substr, S);
end;

function InternalAnsiStrScan(Str: PChar; Chr: Char): PChar;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.AnsiStrScan(Str, Chr);
end;

procedure IndySetThreadPriority(AThread: TThread; const APriority: TIdThreadPriority;
  const APolicy: Integer = -MaxInt);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // TODO: does this apply to VCL_POSIX as well?
  {$IF DEFINED(WINDOWS) OR (DEFINED(UNIX) AND DEFINED(KYLIXCOMPAT) AND (NOT DEFINED(INT_THREAD_PRIORITY)))}
  AThread.Priority := APriority;
  {$ELSEIF DEFINED(UNIX)}
  // Linux only allows root to adjust thread priorities, so we just ignore this call in Linux?
  // actually, why not allow it if root
  // and also allow setting *down* threadpriority (anyone can do that)
  // note that priority is called "niceness" and positive is lower priority
    {$IF DEFINED(KYLIXCOMPAT)}
  if (getpriority(PRIO_PROCESS, 0) < APriority) or (geteuid = 0) then begin
    setpriority(PRIO_PROCESS, 0, APriority);
  end;
    {$ELSEIF DEFINED(USE_BASEUNIX)}
  if (fpgetpriority(PRIO_PROCESS, 0) < cint(APriority)) or (fpgeteuid = 0) then begin
    fpsetpriority(PRIO_PROCESS, 0, cint(APriority));
  end;
    {$IFEND}
  {$IFEND}
end;

procedure IndySleep(ATime: UInt32);
{$IF DEFINED(USE_VCL_POSIX)}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LTime: TimeVal;
{$ELSEIF DEFINED(UNIX)}
var
  LTime: TTimeVal;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$IFEND}
begin
  {$IF DEFINED(WINDOWS)}

  Windows.Sleep(ATime);

  {$ELSEIF DEFINED(UNIX)}

  // *nix: Is there are reason for not using nanosleep?

  // what if the user just calls sleep? without doing anything...
  // cannot use GStack.WSSelectRead(nil, ATime)
  // since no readsocketlist exists to get the fdset
  LTime.tv_sec := ATime div 1000;
  LTime.tv_usec := (ATime mod 1000) * 1000;
    {$IF DEFINED(USE_VCL_POSIX)}
  select( 0, nil, nil, nil, @LTime);
    {$ELSEIF DEFINED(KYLIXCOMPAT)}
  Libc.Select(0, nil, nil, nil, @LTime);
    {$ELSEIF DEFINED(USE_BASEUNIX)}
  fpSelect(0, nil, nil, nil, @LTime);
    {$ELSE}
      {$message error select is not called on this platform!}
    {$IFEND}


  {$ELSE}
    {$message error IndySleep is not implemented on this platform!}
  {$IFEND}
end;

procedure SplitDelimitedString(const AData: string; AStrings: TStrings; ATrim: Boolean;
  const ADelim: string = ' '{$IFNDEF USE_OBJECT_ARC}; AIncludePositions: Boolean = False{$ENDIF});
var
  i: Integer;
  LData: string;
  LDelim: Integer; //delim len
  LLeft: string;
  LLastPos, LLeadingSpaceCnt: PtrInt;
begin
  Assert(Assigned(AStrings));
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    LDelim := Length(ADelim);
    LLastPos := 1;

    if ATrim then begin
      LData := Trim(AData);
      if LData = '' then begin //if WhiteStr
        Exit;
      end;

      LLeadingSpaceCnt := 0;
      while AData[LLeadingSpaceCnt + 1] <= #32 do begin
        Inc(LLeadingSpaceCnt);
      end;

      i := Pos(ADelim, LData);
      while I > 0 do begin
        LLeft := Copy(LData, LLastPos, I - LLastPos); //'abc d' len:=i(=4)-1    {Do not Localize}
        if LLeft > '' then begin    {Do not Localize}
          {$IFNDEF USE_OBJECT_ARC}
          if AIncludePositions then begin
            AStrings.AddObject(Trim(LLeft), TObject(LLastPos + LLeadingSpaceCnt));
          end else
          {$ENDIF}
          begin
            AStrings.Add(Trim(LLeft));
          end;
        end;
        LLastPos := I + LDelim; //first char after Delim
        i := PosIdx(ADelim, LData, LLastPos);
      end;//while found
      if LLastPos <= Length(LData) then begin
        {$IFNDEF USE_OBJECT_ARC}
        if AIncludePositions then begin
          AStrings.AddObject(Trim(Copy(LData, LLastPos, MaxInt)), TObject(LLastPos + LLeadingSpaceCnt));
        end else
        {$ENDIF}
        begin
          AStrings.Add(Trim(Copy(LData, LLastPos, MaxInt)));
        end;
      end;
    end else
    begin
      i := Pos(ADelim, AData);
      while I > 0 do begin
        LLeft := Copy(AData, LLastPos, I - LLastPos); //'abc d' len:=i(=4)-1    {Do not Localize}
        if LLeft <> '' then begin    {Do not Localize}
          {$IFNDEF USE_OBJECT_ARC}
          if AIncludePositions then begin
            AStrings.AddObject(LLeft, TObject(LLastPos));
          end else
          {$ENDIF}
          begin
            AStrings.Add(LLeft);
          end;
        end;
        LLastPos := I + LDelim; //first char after Delim
        i := PosIdx(ADelim, AData, LLastPos);
      end;
      if LLastPos <= Length(AData) then begin
        {$IFNDEF USE_OBJECT_ARC}
        if AIncludePositions then begin
          AStrings.AddObject(Copy(AData, LLastPos, MaxInt), TObject(LLastPos));
        end else
        {$ENDIF}
        begin
          AStrings.Add(Copy(AData, LLastPos, MaxInt));
        end;
      end;
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

{$IFDEF USE_OBJECT_ARC}
constructor TIdStringPosition.Create(const AValue: String; const APosition: Integer);
begin
  Value := AValue;
  Position := APosition;
end;

procedure SplitDelimitedString(const AData: string; AStrings: TIdStringPositionList;
  ATrim: Boolean; const ADelim: string = ' ');
var
  i: Integer;
  LData: string;
  LDelim: Integer; //delim len
  LLeft: string;
  LLastPos, LLeadingSpaceCnt: Integer;
begin
  Assert(Assigned(AStrings));
  AStrings.Clear;
  LDelim := Length(ADelim);
  LLastPos := 1;

  if ATrim then begin
    LData := Trim(AData);
    if LData = '' then begin //if WhiteStr
      Exit;
    end;

    LLeadingSpaceCnt := 0;
    while AData[LLeadingSpaceCnt + 1] <= #32 do begin
      Inc(LLeadingSpaceCnt);
    end;

    i := Pos(ADelim, LData);
    while I > 0 do begin
      LLeft := Copy(LData, LLastPos, I - LLastPos); //'abc d' len:=i(=4)-1    {Do not Localize}
      if LLeft > '' then begin    {Do not Localize}
        AStrings.Add(TIdStringPosition.Create(Trim(LLeft), LLastPos + LLeadingSpaceCnt));
      end;
      LLastPos := I + LDelim; //first char after Delim
      i := PosIdx(ADelim, LData, LLastPos);
    end;//while found
    if LLastPos <= Length(LData) then begin
      AStrings.Add(TIdStringPosition.Create(Trim(Copy(LData, LLastPos, MaxInt)), LLastPos + LLeadingSpaceCnt));
    end;
  end else
  begin
    i := Pos(ADelim, AData);
    while I > 0 do begin
      LLeft := Copy(AData, LLastPos, I - LLastPos); //'abc d' len:=i(=4)-1    {Do not Localize}
      if LLeft <> '' then begin    {Do not Localize}
        AStrings.Add(TIdStringPosition.Create(LLeft, LLastPos));
      end;
      LLastPos := I + LDelim; //first char after Delim
      i := PosIdx(ADelim, AData, LLastPos);
    end;
    if LLastPos <= Length(AData) then begin
      AStrings.Add(TIdStringPosition.Create(Copy(AData, LLastPos, MaxInt), LLastPos));
    end;
  end;
end;
{$ENDIF}

procedure SetThreadName(const AName: string; AThreadID: UInt32 = $FFFFFFFF);
{$IF DEFINED(HAS_TThread_NameThreadForDebugging)}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSEIF DEFINED(HAS_NAMED_THREADS)}
  {$IFDEF WINDOWS}
const
  MS_VC_EXCEPTION = $406D1388;
type
  TThreadNameInfo = record
    RecType: UInt32;    // Must be 0x1000
    Name: PAnsiChar;    // Pointer to name (in user address space)
    ThreadID: UInt32;   // Thread ID (-1 indicates caller thread)
    Flags: UInt32;      // Reserved for future use. Must be zero
  end;
var
  LName: AnsiString;
  LThreadNameInfo: TThreadNameInfo;
  {$ENDIF}
{$IFEND}
begin
  {$IF DEFINED(HAS_TThread_NameThreadForDebugging)}

  // TODO: FreePascal's implementation of TThread.NameThreadForDebugging() is empty!
  // It is provided only for compatibility with Delphi code. Indy does not define
  // HAS_NAMED_THREADS for FPC, so maybe IFDEF out this call completely on FPC?
  TThread.NameThreadForDebugging(
    {$IFDEF THREADNAME_IS_ANSISTRING}
    AnsiString(AName) // explicit convert to Ansi
    {$ELSE}
    AName
    {$ENDIF},
    AThreadID
  );

  {$ELSEIF DEFINED(HAS_NAMED_THREADS)}

    {$IFDEF WINDOWS}
  // TODO: use SetThreadDescription() on Win10 and later...
  LName := AnsiString(AName); // explicit convert to Ansi
  LThreadNameInfo.RecType := $1000;
  LThreadNameInfo.Name := PAnsiChar(LName);
  LThreadNameInfo.ThreadID := AThreadID;
  LThreadNameInfo.Flags := 0;
  try
    // This is a wierdo Windows way to pass the info in to the debugger
    RaiseException(MS_VC_EXCEPTION, 0, SizeOf(LThreadNameInfo) div SizeOf(UInt32),
      PDWord(@LThreadNameInfo));
  except
  end;
    {$ENDIF}

  {$ELSE}

  // Do nothing. No support in this compiler for it.

  {$IFEND}
end;

{ TIdLocalEvent }

constructor TIdLocalEvent.Create(const AInitialState: Boolean = False; const AManualReset: Boolean = False);
begin
  inherited Create(nil, AManualReset, AInitialState, '');    {Do not Localize}
end;

function TIdLocalEvent.WaitForEver: TWaitResult;
begin
  Result := WaitFor(Infinite);
end;

procedure ToDo(const AMsg: string);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  raise EIdException.Create(AMsg); // TODO: create a new Exception class for this
end;

// RLebeau: the following three functions are utility functions
// that determine the usable amount of data in various buffer types.
// There are many operations in Indy that allow the user to specify
// data sizes, or to have Indy calculate it.  So these functions
// help reduce code duplication.

function IndyLength(const ABuffer: String; const ALength: Integer = -1; const AIndex: Integer = 1): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: Integer;
begin
  Assert(AIndex >= 1);
  LAvailable := IndyMax(Length(ABuffer)-AIndex+1, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := IndyMin(LAvailable, ALength);
  end;
end;

function IndyLength(const ABuffer: TIdBytes; const ALength: Integer = -1; const AIndex: Integer = 0): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: Integer;
begin
  Assert(AIndex >= 0);
  LAvailable := IndyMax(Length(ABuffer)-AIndex, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := IndyMin(LAvailable, ALength);
  end;
end;

function IndyLength(const ABuffer: TStream; const ALength: Int64 = -1): Int64; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: Int64;
begin
  LAvailable := IndyMax(ABuffer.Size - ABuffer.Position, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := IndyMin(LAvailable, ALength);
  end;
end;

const
  wdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'); {do not localize}
  monthnames: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', {do not localize}
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); {do not localize}

//this should be changed to a singleton?
function GetEnglishSetting: TFormatSettings;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result.CurrencyFormat := $00; // 0 = '$1'
  Result.NegCurrFormat := $00; //0 = '($1)'
  Result.CurrencyString := '$';                               {do not localize}
  Result.CurrencyDecimals := 2;

  Result.ThousandSeparator := ',';                            {do not localize}
  Result.DecimalSeparator := '.';                             {do not localize}

  Result.DateSeparator := '/';                                {do not localize}
  Result.ShortDateFormat := 'M/d/yyyy';                       {do not localize}
  Result.LongDateFormat := 'dddd, MMMM dd, yyyy';             {do not localize}

  Result.TimeSeparator := ':';                                {do not localize}
  Result.TimeAMString := 'AM';                                {do not localize}
  Result.TimePMString := 'PM';                                {do not localize}
  Result.LongTimeFormat := 'h:mm:ss AMPM';                    {do not localize}
  Result.ShortTimeFormat := 'h:mm AMPM';                      {do not localize}

  // TODO: use hard-coded names instead?
  Result.ShortMonthNames[1] := monthnames[1]; //'Jan';
  Result.ShortMonthNames[2] := monthnames[2]; //'Feb';
  Result.ShortMonthNames[3] := monthnames[3]; //'Mar';
  Result.ShortMonthNames[4] := monthnames[4]; //'Apr';
  Result.ShortMonthNames[5] := monthnames[5]; //'May';
  Result.ShortMonthNames[6] := monthnames[6]; //'Jun';
  Result.ShortMonthNames[7] := monthnames[7]; //'Jul';
  Result.ShortMonthNames[8] := monthnames[8]; //'Aug';
  Result.ShortMonthNames[9] := monthnames[9]; //'Sep';
  Result.ShortMonthNames[10] := monthnames[10];// 'Oct';
  Result.ShortMonthNames[11] := monthnames[11]; //'Nov';
  Result.ShortMonthNames[12] := monthnames[12]; //'Dec';

  Result.LongMonthNames[1] := 'January';                      {do not localize}
  Result.LongMonthNames[2] := 'February';                     {do not localize}
  Result.LongMonthNames[3] := 'March';                        {do not localize}
  Result.LongMonthNames[4] := 'April';                        {do not localize}
  Result.LongMonthNames[5] := 'May';                          {do not localize}
  Result.LongMonthNames[6] := 'June';                         {do not localize}
  Result.LongMonthNames[7] := 'July';                         {do not localize}
  Result.LongMonthNames[8] := 'August';                       {do not localize}
  Result.LongMonthNames[9] := 'September';                    {do not localize}
  Result.LongMonthNames[10] := 'October';                     {do not localize}
  Result.LongMonthNames[11] := 'November';                    {do not localize}
  Result.LongMonthNames[12] := 'December';                    {do not localize}

  // TODO: use hard-coded names instead?
  Result.ShortDayNames[1] := wdays[1]; //'Sun';
  Result.ShortDayNames[2] := wdays[2]; //'Mon';
  Result.ShortDayNames[3] := wdays[3]; //'Tue';
  Result.ShortDayNames[4] := wdays[4]; //'Wed';
  Result.ShortDayNames[5] := wdays[5]; //'Thu';
  Result.ShortDayNames[6] := wdays[6]; //'Fri';
  Result.ShortDayNames[7] := wdays[7]; //'Sat';

  Result.LongDayNames[1] := 'Sunday';                         {do not localize}
  Result.LongDayNames[2] := 'Monday';                         {do not localize}
  Result.LongDayNames[3] := 'Tuesday';                        {do not localize}
  Result.LongDayNames[4] := 'Wednesday';                      {do not localize}
  Result.LongDayNames[5] := 'Thursday';                       {do not localize}
  Result.LongDayNames[6] := 'Friday';                         {do not localize}
  Result.LongDayNames[7] := 'Saturday';                       {do not localize}

  Result.ListSeparator := ',';                                {do not localize}
end;

// RLebeau 10/24/2008: In the RTM release of Delphi/C++Builder 2009, the
// overloaded version of SysUtils.Format() that has a TFormatSettings parameter
// has an internal bug that causes an EConvertError exception when UnicodeString
// parameters greater than 4094 characters are passed to it.  Refer to QC #67934
// for details.  The bug is fixed in 2009 Update 1.  For RTM, call FormatBuf()
// directly to work around the problem...
function IndyFormat(const AFormat: string; const Args: array of const): string;
var
  EnglishFmt: TFormatSettings;
  {$IFDEF BROKEN_FmtStr}
  Len, BufLen: Integer;
  Buffer: array[0..4095] of Char;
  {$ENDIF}
begin
  EnglishFmt := GetEnglishSetting;
  {$IFDEF BROKEN_FmtStr}
  BufLen := Length(Buffer);
  if Length(AFormat) < (Length(Buffer) - (Length(Buffer) div 4)) then
  begin
    Len := SysUtils.FormatBuf(Buffer, Length(Buffer) - 1, Pointer(AFormat)^,
      Length(AFormat), Args, EnglishFmt);
  end else
  begin
    BufLen := Length(AFormat);
    Len := BufLen;
  end;
  if Len >= BufLen - 1 then
  begin
    while Len >= BufLen - 1 do
    begin
      Inc(BufLen, BufLen);
      Result := '';          // prevent copying of existing data, for speed
      SetLength(Result, BufLen);
      Len := SysUtils.FormatBuf(PChar(Result), BufLen - 1, Pointer(AFormat)^,
        Length(AFormat), Args, EnglishFmt);
    end;
    SetLength(Result, Len);
  end else
  begin
    SetString(Result, Buffer, Len);
  end;
  {$ELSE}
  Result := SysUtils.Format(AFormat, Args, EnglishFmt);
  {$ENDIF}
end;

function DateTimeGMTToHttpStr(const GMTValue: TDateTime) : String;
// should adhere to RFC 2616
var
  wDay, wMonth, wYear: Word;
begin
  DecodeDate(GMTValue, wYear, wMonth, wDay);
  Result := IndyFormat('%s, %.2d %s %.4d %s %s',    {do not localize}
                   [wdays[DayOfWeek(GMTValue)], wDay, monthnames[wMonth],
                    wYear, FormatDateTime('HH":"nn":"ss',GMTValue), 'GMT']);  {do not localize}
end;

function DateTimeGMTToCookieStr(const GMTValue: TDateTime; const AUseNetscapeFmt: Boolean = True) : String;
var
  wDay, wMonth, wYear: Word;
  LDelim: Char;
begin
  DecodeDate(GMTValue, wYear, wMonth, wDay);
  // RLebeau: cookie draft-23 requires HTTP servers to format an Expires value as follows:
  //
  // Wdy, DD Mon YYYY HH:MM:SS GMT
  //
  // However, Netscape style formatting, which RFCs 2109 and 2965 allow
  // (but draft-23 obsoletes), are more common:
  //
  // Wdy, DD-Mon-YY HH:MM:SS GMT   (original)
  // Wdy, DD-Mon-YYYY HH:MM:SS GMT (RFC 1123)
  //
  if AUseNetscapeFmt then begin
    LDelim := '-';    {do not localize}
  end else begin
    LDelim := ' ';    {do not localize}
  end;
  Result := IndyFormat('%s, %.2d%s%s%s%.4d %s %s',    {do not localize}
                   [wdays[DayOfWeek(GMTValue)], wDay, LDelim, monthnames[wMonth], LDelim, wYear,
                   FormatDateTime('HH":"nn":"ss',GMTValue), 'GMT']);  {do not localize}
end;

function DateTimeGMTToImapStr(const GMTValue: TDateTime) : String;
var
  wDay, wMonth, wYear: Word;
  LDay: String;
begin
  DecodeDate(GMTValue, wYear, wMonth, wDay);
  LDay := IntToStr(wDay);
  if Length(LDay) < 2 then begin
    LDay := ' ' + LDay; // NOTE: space NOT zero!
  end;
  Result := IndyFormat('%s-%s-%d %s %s',    {do not localize}
                   [LDay, monthnames[wMonth], wYear, FormatDateTime('HH":"nn":"ss',GMTValue), {do not localize}
                    '+0000']); {do not localize}
end;

function LocalDateTimeToHttpStr(const Value: TDateTime) : String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeGMTToHttpStr(LocalTimeToUTCTime(Value));
end;

function LocalDateTimeToCookieStr(const Value: TDateTime; const AUseNetscapeFmt: Boolean = True) : String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeGMTToCookieStr(LocalTimeToUTCTime(Value), AUseNetscapeFmt);
end;

function LocalDateTimeToImapStr(const Value: TDateTime) : String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeGMTToImapStr(LocalTimeToUTCTime(Value));
end;

{This should never be localized}
function LocalDateTimeToGMT(const Value: TDateTime; const AUseGMTStr: Boolean = False) : String;
var
  wDay, wMonth, wYear: Word;
begin
  DecodeDate(Value, wYear, wMonth, wDay);
  Result := IndyFormat('%s, %d %s %d %s %s',    {do not localize}
                   [wdays[DayOfWeek(Value)], wDay, monthnames[wMonth],
                    wYear, FormatDateTime('HH":"nn":"ss', Value), {do not localize}
                    UTCOffsetToStr(OffsetFromUTC, AUseGMTStr)]);
end;

function OffsetFromUTC: TDateTime;
{$IF DEFINED(HAS_GetLocalTimeOffset) OR DEFINED(HAS_DateUtils_TTimeZone)}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSEIF DEFINED(WINDOWS)}
var
  iBias: Integer;
  tmez: TTimeZoneInformation;
{$ELSEIF (NOT DEFINED(HAS_GetLocalTimeOffset)) AND DEFINED(UNIX)}
  {$IF DEFINED(USE_VCL_POSIX)}
var
  T : Time_t;
  TV : TimeVal;
  UT : tm;
  {$ELSE}
var
  T : Time_T;
  TV : TTimeVal;
  UT : TUnixTime;
  {$IFEND}
{$IFEND}
begin
  {$IF DEFINED(HAS_GetLocalTimeOffset)}

  // RLebeau: Note that on Linux/Unix, this information may be inaccurate around
  // the DST time changes (for optimization). In that case, the unix.ReReadLocalTime()
  // function must be used to re-initialize the timezone information...

  // RLebeau 1/15/2022: the value returned by OffsetFromUTC() is meant to be *subtracted*
  // from a local time, and *added* to a UTC time.  However, the value returned by
  // FPC's GetLocalTimeOffset() is the opposite - it is meant to be *added* to local time,
  // and *subtracted* from UTC time.  So, we need to flip its sign here... 

  Result := -1 * (GetLocalTimeOffset() / 60 / 24);

  {$ELSEIF DEFINED(HAS_DateUtils_TTimeZone)}
  
  Result := -1 * (TTimeZone.Local.UtcOffset.TotalMinutes / 60 / 24);

  {$ELSEIF DEFINED(WINDOWS)}

  case GetTimeZoneInformation({$IFDEF WINCE}@{$ENDIF}tmez) of
    TIME_ZONE_ID_INVALID  :
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    TIME_ZONE_ID_UNKNOWN  :
       iBias := tmez.Bias;
    TIME_ZONE_ID_DAYLIGHT : begin
      iBias := tmez.Bias;
      if tmez.DaylightDate.wMonth <> 0 then begin
        iBias := iBias + tmez.DaylightBias;
      end;
    end;
    TIME_ZONE_ID_STANDARD : begin
      iBias := tmez.Bias;
      if tmez.StandardDate.wMonth <> 0 then begin
        iBias := iBias + tmez.StandardBias;
      end;
    end
  else
    begin
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    end;
  end;

  {We use ABS because EncodeTime will only accept positive values}
  Result := EncodeTime(Abs(iBias) div 60, Abs(iBias) mod 60, 0, 0);

  {The GetTimeZone function returns values oriented towards converting
   a GMT time into a local time.  We wish to do the opposite by returning
   the difference between the local time and GMT.  So I just make a positive
   value negative and leave a negative value as positive}
  if iBias > 0 then begin
    Result := 0.0 - Result;
  end;

  {$ELSEIF DEFINED(UNIX)}

  {from http://edn.embarcadero.com/article/27890 but without multiplying the Result by -1 - WHY???}

  if {$IFDEF USE_BASEUNIX}fpGetTimeOfDay(@TV, nil){$ELSE}gettimeofday(TV, nil){$ENDIF} <> 0 then begin
    raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
  end;
  T := TV.tv_sec;
  localtime_r({$IFDEF KYLIXCOMPAT}@{$ENDIF}T, UT);
  Result := {-1 *} UT.{$IFDEF KYLIXCOMPAT}__tm_gmtoff{$ELSE}tm_gmtoff{$ENDIF} / 60 / 60 / 24;

  {$ELSE}

  Result := GOffsetFromUTC;

  {$IFEND}
end;

function UTCOffsetToStr(const AOffset: TDateTime; const AUseGMTStr: Boolean = False): string;
var
  AHour, AMin, ASec, AMSec: Word;
  s: string;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  if (AOffset = 0.0) and AUseGMTStr then
  begin
    Result := 'GMT'; {do not localize}
  end else
  begin
    DecodeTime(AOffset, AHour, AMin, ASec, AMSec);
    s := IndyFormat(' %0.2d%0.2d', [AHour, AMin]); {do not localize}
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB := TIdStringBuilder.Create(5);
    LSB.Append(s);
    if AOffset < 0.0 then begin
      LSB[0] := '-'; {do not localize}
    end else begin
      LSB[0] := '+'; {do not localize}
    end;
    Result := LSB.ToString;
    {$ELSE}
    Result := s;
    if AOffset < 0.0 then begin
      Result[1] := '-'; {do not localize}
    end else begin
      Result[1] := '+';  {do not localize}
    end;
    {$ENDIF}
  end;
end;

function LocalTimeToUTCTime(const Value: TDateTime): TDateTime;
begin
  {$IFDEF HAS_LocalTimeToUniversal}
  Result := LocalTimeToUniversal(Value);
  {$ELSE}
    {$IFDEF HAS_DateUtils_TTimeZone}
  Result := TTimeZone.Local.ToUniversalTime(Value);
    {$ELSE}
  Result := Value - OffsetFromUTC;
    {$ENDIF}
  {$ENDIF}
end;

function UTCTimeToLocalTime(const Value: TDateTime): TDateTime;
begin
  {$IFDEF HAS_UniversalTimeToLocal}
  Result := UniversalTimeToLocal(Value);
  {$ELSE}
    {$IFDEF HAS_DateUtils_TTimeZone}
  Result := TTimeZone.Local.ToLocalTime(Value);
    {$ELSE}
  Result := Value + OffsetFromUTC;
    {$ENDIF}
  {$ENDIF}
end;

function IndyIncludeTrailingPathDelimiter(const S: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.IncludeTrailingPathDelimiter(S);
end;

function IndyExcludeTrailingPathDelimiter(const S: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.ExcludeTrailingPathDelimiter(S);
end;

function StringsReplace(const S: String; const OldPattern, NewPattern: array of string): string;
var
  i : Integer;
begin
  // TODO: re-write this to not use ReplaceAll() in a loop anymore.  If
  // OldPattern contains multiple strings, a string appearing later in the
  // list may be replaced multiple times by accident if it appears in the
  // Result of an earlier string replacement.
  Result := s;
  for i := Low(OldPattern) to High(OldPattern) do begin
    Result := ReplaceAll(Result, OldPattern[i], NewPattern[i]);
  end;
end;

function ReplaceAll(const S: String; const OldPattern, NewPattern: String): String;
var
  I, PatLen: Integer;
  NumBytes: Integer;
begin
  PatLen := Length(OldPattern);
  if Length(NewPattern) = PatLen then begin
    Result := S;
    I := Pos(OldPattern, Result);
    if I > 0 then begin
      UniqueString(Result);
      NumBytes := PatLen * SizeOf(Char);
      repeat
        Move(PChar(NewPattern)^, Result[I], NumBytes);
        I := {$IFDEF HAS_System_Pos_Offset}Pos{$ELSE}PosEx{$ENDIF}(OldPattern, Result, I + PatLen);
     until I = 0;
    end;
  end else begin
    Result := SysUtils.StringReplace(S, OldPattern, NewPattern, [rfReplaceAll]);
  end;
end;

function ReplaceOnlyFirst(const S, OldPattern, NewPattern: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.StringReplace(s, OldPattern, NewPattern, []);
end;

function IndyStrToInt(const S: string): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := StrToInt(Trim(S));
end;

function IndyStrToInt(const S: string; ADefault: Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := StrToIntDef(Trim(S), ADefault);
end;

function CompareDate(const D1, D2: TDateTime): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateUtils.CompareDateTime(D1, D2);
end;

function AddMSecToTime(const ADateTime: TDateTime; const AMSec: Integer): TDateTime;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateUtils.IncMilliSecond(ADateTime, AMSec);
end;

function IndyFileAge(const AFileName: string): TDateTime;
{$IFDEF HAS_2PARAM_FileAge}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  LAge: Integer;
{$ENDIF}
begin
  {$IFDEF HAS_2PARAM_FileAge}
  //single-parameter fileage is deprecated in d2006 and above
  if not FileAge(AFileName, Result) then begin
    Result := 0;
  end;
  {$ELSE}
  LAge := SysUtils.FileAge(AFileName);
  if LAge <> -1 then begin
    Result := FileDateToDateTime(LAge);
  end else begin
    Result := 0.0;
  end;
  {$ENDIF}
end;

function IndyDirectoryExists(const ADirectory: string): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.DirectoryExists(ADirectory);
end;

function IndyStrToInt64(const S: string; const ADefault: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.StrToInt64Def(Trim(S), ADefault);
end;

function IndyStrToInt64(const S: string): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.StrToInt64(Trim(S));
end;

function IndyStrToStreamSize(const S: string; const ADefault: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IndyStrToInt64(S, ADefault);
end;

function IndyStrToStreamSize(const S: string): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IndyStrToInt64(S);
end;

function ToBytes(const AValue: string; ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValue <> '' then begin
    EnsureEncoding(ADestEncoding);
    Result := ADestEncoding.GetBytes(AValue);
  end else begin
    SetLength(Result, 0);
  end;
end;

function ToBytes(const AValue: string; const ALength: Integer; const AIndex: Integer = 1;
  ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
var
  LLength: Integer;
begin
  LLength := IndyLength(AValue, ALength, AIndex);
  if LLength > 0 then
  begin
    EnsureEncoding(ADestEncoding);
    SetLength(Result, ADestEncoding.GetByteCount(AValue, AIndex, LLength));
    if Result <> nil then begin
      ADestEncoding.GetBytes(AValue, AIndex, LLength, Result, 0);
    end;
  end else begin
    SetLength(Result, 0);
  end;
end;

function ToBytes(const AValue: Char; ADestEncoding: IIdTextEncoding = nil): TIdBytes; overload;
begin
  EnsureEncoding(ADestEncoding);
  Result := ADestEncoding.GetBytes(@AValue, 1);
end;

function ToBytes(const AValue: Int64): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(Int64));
  PInt64(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: UInt64): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(UInt64));
  PUInt64(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: Int32): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(Int32));
  PInt32(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: UInt32): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(UInt32));
  PUInt32(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: Int16): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(Int16));
  PInt16(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: UInt16): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(UInt16));
  PUInt16(@Result[0])^ := AValue;
end;

function ToBytes(const AValue: Int8): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(Int8));
  Result[0] := Byte(AValue);
end;

function ToBytes(const AValue: UInt8): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(UInt8));
  Result[0] := AValue;
end;

function ToBytes(const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LSize: Integer;
begin
  LSize := IndyLength(AValue, ASize, AIndex);
  SetLength(Result, LSize);
  if LSize > 0 then begin
    CopyTIdBytes(AValue, AIndex, Result, 0, LSize);
  end;
end;

function RawToBytes(const AValue; const ASize: Integer): TIdBytes;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, ASize);
  if ASize > 0 then begin
    Move(AValue, Result[0], ASize);
  end;
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Char; ADestEncoding: IIdTextEncoding = nil);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  EnsureEncoding(ADestEncoding);
  Assert(Length(Bytes) >= ADestEncoding.GetByteCount(@AValue, 1));
  ADestEncoding.GetBytes(@AValue, 0, 1, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int32);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdInt32(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int16);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdInt16(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt16);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdUInt16(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int8);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  Bytes[0] := Byte(AValue);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt8);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  Bytes[0] := AValue;
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt32);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdUInt32(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int64);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdInt64(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: UInt64);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdUInt64(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= ASize);
  CopyTIdBytes(AValue, AIndex, Bytes, 0, ASize);
end;

procedure RawToBytesF(var Bytes: TIdBytes; const AValue; const ASize: Integer; const ADestIndex: Integer = 0);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= (ADestIndex+ASize));
  if ASize > 0 then begin
    Move(AValue, Bytes[ADestIndex], ASize);
  end;
end;

function BytesToChar(const AValue: TIdBytes; const AIndex: Integer = 0;
  AByteEncoding: IIdTextEncoding = nil): Char; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  BytesToChar(AValue, Result, AIndex, AByteEncoding);
end;

function BytesToChar(const AValue: TIdBytes; var VChar: Char; const AIndex: Integer = 0;
  AByteEncoding: IIdTextEncoding = nil): Integer; overload;
var
  I, J, NumChars, NumBytes: Integer;
  LChars: array[0..1] of WideChar;
begin
  Result := 0;
  EnsureEncoding(AByteEncoding);
  // 2 Chars to handle UTF-16 surrogates
  NumBytes := IndyMin(IndyLength(AValue, -1, AIndex), AByteEncoding.GetMaxByteCount(2));
  NumChars := 0;
  if NumBytes > 0 then
  begin
    for I := 1 to NumBytes do
    begin
      NumChars := AByteEncoding.GetChars(@AValue[AIndex], I, @LChars[0], 2);
      Inc(Result);
      if NumChars > 0 then begin
        // RLebeau 10/19/2012: when Indy switched to its own UTF-8 implementation
        // to avoid the MB_ERR_INVALID_CHARS flag on Windows, it accidentally broke
        // this loop!  Since this is not commonly used, this was not noticed until
        // now.  On Windows at least, GetChars() now returns >0 for an invalid
        // sequence, so we have to check if any of the returned characters are the
        // Unicode U+FFFD character, indicating bad data...
        for J := 0 to NumChars-1 do begin
          if LChars[J] = WideChar($FFFD) then begin
            // keep reading...
            NumChars := 0;
            Break;
          end;
        end;
        if NumChars > 0 then begin
          Break;
        end;
      end;
    end;
  end;

  // RLebeau: if the bytes were decoded into surrogates, the second
  // surrogate is lost here, as it can't be returned unless we cache
  // it somewhere for the the next BytesToChar() call to retreive.  Just
  // raise an error for now.  Users will have to update their code to
  // read surrogates differently...
  Assert(NumChars = 1);
  VChar := LChars[0];
end;

function BytesToInt32(const AValue: TIdBytes; const AIndex: Integer = 0): Int32;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Int32)));
  Result := PInt32(@AValue[AIndex])^;
end;

function BytesToInt64(const AValue: TIdBytes; const AIndex: Integer = 0): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Int64)));
  Result := PInt64(@AValue[AIndex])^;
end;

function BytesToUInt64(const AValue: TIdBytes; const AIndex: Integer = 0): UInt64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(UInt64)));
  Result := PUInt64(@AValue[AIndex])^;
end;

function BytesToTicks(const AValue: TIdBytes; const AIndex: Integer = 0): TIdTicks;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := BytesToUInt64(AValue, AIndex);
end;

function BytesToUInt16(const AValue: TIdBytes; const AIndex: Integer = 0): UInt16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(UInt16)));
  Result := PUInt16(@AValue[AIndex])^;
end;

function BytesToInt16(const AValue: TIdBytes; const AIndex: Integer = 0): Int16;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Int16)));
  Result := PInt16(@AValue[AIndex])^;
end;

function BytesToIPv4Str(const AValue: TIdBytes; const AIndex: Integer = 0): String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+4));
  Result := IntToStr(Ord(AValue[AIndex])) + '.' +
           IntToStr(Ord(AValue[AIndex+1])) + '.' +
           IntToStr(Ord(AValue[AIndex+2])) + '.' +
           IntToStr(Ord(AValue[AIndex+3]));
end;

procedure BytesToIPv6(const AValue: TIdBytes; var VAddress: TIdIPv6Address; const AIndex: Integer = 0);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+16));
  Move(AValue[AIndex], VAddress[0], 16);
end;

function BytesToUInt32(const AValue: TIdBytes; const AIndex: Integer = 0): UInt32;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(UInt32)));
  Result := PUInt32(@AValue[AIndex])^;
end;

function BytesToString(const AValue: TIdBytes; AByteEncoding: IIdTextEncoding = nil): string; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := BytesToString(AValue, 0, -1, AByteEncoding);
end;

function BytesToString(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1; AByteEncoding: IIdTextEncoding = nil): string; overload;
var
  LLength: Integer;
begin
  LLength := IndyLength(AValue, ALength, AStartIndex);
  if LLength > 0 then begin
    EnsureEncoding(AByteEncoding);
    Result := AByteEncoding.GetString(AValue, AStartIndex, LLength);
  end else begin
    Result := '';
  end;
end;

function BytesToStringRaw(const AValue: TIdBytes): string; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := BytesToStringRaw(AValue, 0, -1);
end;

function BytesToStringRaw(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1): string;
var
  LLength: Integer;
begin
  LLength := IndyLength(AValue, ALength, AStartIndex);
  if LLength > 0 then begin
    Result := IndyTextEncoding_8Bit.GetString(AValue, AStartIndex, LLength);
  end else begin
    Result := '';
  end;
end;

procedure BytesToRaw(const AValue: TIdBytes; var VBuffer; const ASize: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= ASize);
  Move(AValue[0], VBuffer, ASize);
end;

function TwoByteToUInt16(AByte1, AByte2: Byte): UInt16;
//Since Replys are returned as Strings, we need a routine to convert two
// characters which are a 2 byte U Int into a two byte unsigned Integer
var
  LWord: TIdBytes;
begin
  SetLength(LWord, SizeOf(UInt16));
  LWord[0] := AByte1;
  LWord[1] := AByte2;
  Result := BytesToUInt16(LWord);
//  Result := UInt16((AByte1 shl 8) and $FF00) or UInt16(AByte2 and $00FF);
end;

function ReadStringFromStream(AStream: TStream; ASize: Integer = -1;
  AByteEncoding: IIdTextEncoding = nil): string;
var
  LBytes: TIdBytes;
begin
  ASize := IndyLength(AStream, ASize);
  if ASize > 0 then begin
    SetLength(LBytes, ASize);
    AStream.ReadBuffer(LBytes[0], ASize);
    Result := BytesToString(LBytes, 0, ASize, AByteEncoding);
  end else begin
    Result := '';
  end;
end;

function ReadTIdBytesFromStream(const AStream: TStream; var VBytes: TIdBytes;
  const ACount: Int64; const AIndex: Integer = 0): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LSize: Integer;
begin
  LSize := Integer(IndyLength(AStream, IndyMin(ACount, MaxInt)));
  if LSize > 0 then begin
    if Length(VBytes) < (AIndex+LSize) then begin
      SetLength(VBytes, AIndex+LSize);
    end;
    Result := AStream.Read(VBytes[AIndex], LSize);
  end else begin
    Result := 0;
  end;
end;

function ReadCharFromStream(AStream: TStream; var VChar: Char;
  AByteEncoding: IIdTextEncoding = nil): Integer;
var
  StartPos: Int64;
  Lb: Byte;
  I, NumChars, NumBytes: Integer;
  LBytes: TIdBytes;
  LChars: array[0..1] of WideChar;

  function ReadByte: Byte;
  begin
    if AStream.Read(Result, 1) <> 1 then begin
      raise EIdException.Create('Unable to read byte'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
    end;
  end;

begin
  Result := 0;

  EnsureEncoding(AByteEncoding);
  StartPos := AStream.Position;

  // don't raise an exception here, backwards compatibility for now
  if AStream.Read(Lb, 1) <> 1 then begin
    Exit;
  end;
  Result := 1;

  // 2 Chars to handle UTF-16 surrogates
  NumBytes := AByteEncoding.GetMaxByteCount(2);
  SetLength(LBytes, NumBytes);

  try
    repeat
      LBytes[Result-1] := Lb;
      NumChars := AByteEncoding.GetChars(@LBytes[0], Result, @LChars[0], 2);
      if NumChars > 0 then begin
        // RLebeau 10/19/2012: when Indy switched to its own UTF-8 implementation
        // to avoid the MB_ERR_INVALID_CHARS flag on Windows, it accidentally broke
        // this loop!  Since this is not commonly used, this was not noticed until
        // now.  On Windows at least, GetChars() now returns >0 for an invalid
        // sequence, so we have to check if any of the returned characters are the
        // Unicode U+FFFD character, indicating bad data...
        for I := 0 to NumChars-1 do begin
          if LChars[I] = WideChar($FFFD) then begin
            // keep reading...
            NumChars := 0;
            Break;
          end;
        end;
        if NumChars > 0 then begin
          Break;
        end;
      end;
      if Result = NumBytes then begin
        Break;
      end;
      Lb := ReadByte;
      Inc(Result);
    until False;
  except
    AStream.Position := StartPos;
    raise;
  end;

  // RLebeau: if the bytes were decoded into surrogates, the second
  // surrogate is lost here, as it can't be returned unless we cache
  // it somewhere for the the next ReadTIdBytesFromStream() call to
  // retreive.  Just raise an error for now.  Users will have to
  // update their code to read surrogates differently...
  Assert(NumChars = 1);
  VChar := LChars[0];
end;

function WriteTIdBytesToStream(const AStream: TStream; const ABytes: TIdBytes;
  const ASize: Integer = -1; const AIndex: Integer = 0): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LSize: Integer;
begin
  LSize := IndyLength(ABytes, ASize, AIndex);
  if LSize > 0 then begin
    AStream.WriteBuffer(ABytes[AIndex], LSize);
    Result := LSize;
  end else begin
    Result := 0;
  end;
end;

procedure WriteStringToStream(AStream: TStream; const AStr: string;
  ADestEncoding: IIdTextEncoding);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  WriteStringToStream(AStream, AStr, -1, 1, ADestEncoding);
end;

procedure WriteStringToStream(AStream: TStream; const AStr: string;
  const ALength: Integer = -1; const AIndex: Integer = 1;
  ADestEncoding: IIdTextEncoding = nil);
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LLength: Integer;
  LBytes: TIdBytes;
begin
  LBytes := nil;
  LLength := IndyLength(AStr, ALength, AIndex);
  if LLength > 0 then
  begin
    LBytes := ToBytes(AStr, LLength, AIndex, ADestEncoding);
    AStream.WriteBuffer(PByte(LBytes)^, Length(LBytes));
  end;
end;

function SeekStream(const AStream: TStream; const AOffset: Int64;
  const AOrigin: TSeekOrigin) : Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AStream.Seek(AOffset, AOrigin);
end;

procedure TIdBaseStream.SetSize(const NewSize: Int64);
begin
  IdSetSize(NewSize);
end;

function TIdBaseStream.Read(var Buffer; Count: Longint): Longint;
var
  LBytes: TIdBytes;
begin
  SetLength(LBytes, Count);
  Result := IdRead(LBytes, 0, Count);
  if Result > 0 then begin
    Move(LBytes[0], Buffer, Result);
  end;
end;

function TIdBaseStream.Write(const Buffer; Count: Longint): Longint;
begin
  if Count > 0 then begin
    Result := IdWrite(RawToBytes(Buffer, Count), 0, Count);
  end else begin
    Result := 0;
  end;
end;

function TIdBaseStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := IdSeek(Offset, Origin);
end;

function TIdCalculateSizeStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := 0;
end;

function TIdCalculateSizeStream.Write(const Buffer; Count: Longint): Longint;
begin
  if Count > 0 then begin
    Inc(FPosition, Count);
    if FPosition > FSize then begin
      FSize := FPosition;
    end;
  end;
  Result := Count;
end;

function TIdCalculateSizeStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  case Origin of
    soBeginning: begin
      FPosition := Offset;
    end;
    soCurrent: begin
      FPosition := FPosition + Offset;
    end;
    soEnd: begin
      FPosition := FSize + Offset;
    end;
  end;
  if FPosition < 0 then begin
    FPosition := 0;
  end;
  Result := FPosition;
end;

procedure TIdCalculateSizeStream.SetSize(const NewSize: Int64);
var
  LSize: Int64;
begin
  LSize := NewSize;
  if LSize < 0 then begin
    LSize := 0;
  end;
  if FSize <> LSize then begin
    FSize := LSize;
    if FSize < FPosition then begin
      FPosition := FSize;
    end;
  end;
end;

function TIdEventStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := 0;
  if Assigned(FOnRead) then begin
    FOnRead(Buffer, Count, Result);
  end;
end;

function TIdEventStream.Write(const Buffer; Count: Longint): Longint;
begin
  if Assigned(FOnWrite) then begin
    Result := 0;
    FOnWrite(Buffer, Count, Result);
  end else begin
    Result := Count;
  end;
end;

function TIdEventStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := 0;
  if Assigned(FOnSeek) then begin
    FOnSeek(Offset, Origin, Result);
  end;
end;

procedure TIdEventStream.SetSize(const NewSize: Int64);
begin
  if Assigned(FOnSetSize) then begin
    FOnSetSize(NewSize);
  end;
end;

{$IFDEF HAS_TPointerStream}

constructor TIdMemoryBufferStream.Create(APtr: Pointer; ASize: TIdNativeInt);
begin
  inherited Create(APtr, ASize, False);
end;

constructor TIdReadOnlyMemoryBufferStream.Create(APtr: Pointer; ASize: TIdNativeInt);
begin
  inherited Create(APtr, ASize, True);
end;

{$ELSE}

constructor TIdMemoryBufferStream.Create(APtr: Pointer; ASize: TIdNativeInt);
begin
  inherited Create;
  SetPointer(APtr, ASize);
end;

{$IF DEFINED(FPC) OR DEFINED(DCC_XE2_OR_ABOVE)}
  {$DEFINE USE_PBYTE_ARITHMETIC}
{$ELSE}
  {$UNDEF USE_PBYTE_ARITHMETIC}
{$ENDIF}

function TIdMemoryBufferStream.Write(const Buffer; Count: Longint): Longint;
var
  LAvailable: Int64;
  LNumToCopy: Longint;
begin
  Result := 0;
  LAvailable := Size - Position;
  if LAvailable > 0 then
  begin
    LNumToCopy := Longint(IndyMin(LAvailable, Int64(Count)));
    if LNumToCopy > 0 then
    begin
      System.Move(Buffer,
        ({$IFDEF USE_PBYTE_ARITHMETIC}PByte{$ELSE}PAnsiChar{$ENDIF}(Memory) + Position)^,
        LNumToCopy
      );
      Seek(LNumToCopy, soCurrent);
      Result := LNumToCopy;
    end;
  end;
end;

function TIdReadOnlyMemoryBufferStream.Write(const Buffer; Count: Longint): Longint;
begin
  // TODO: raise an exception instead?
  Result := 0;
end;

{$ENDIF}

procedure AppendBytes(var VBytes: TIdBytes; const AToAdd: TIdBytes; const AIndex: Integer = 0; const ALength: Integer = -1);
var
  LOldLen, LAddLen: Integer;
begin
  LAddLen := IndyLength(AToAdd, ALength, AIndex);
  if LAddLen > 0 then begin
    LOldLen := Length(VBytes);
    SetLength(VBytes, LOldLen + LAddLen);
    CopyTIdBytes(AToAdd, AIndex, VBytes, LOldLen, LAddLen);
  end;
end;

procedure AppendByte(var VBytes: TIdBytes; const AByte: Byte);
var
  LOldLen: Integer;
begin
  LOldLen := Length(VBytes);
  SetLength(VBytes, LOldLen + 1);
  VBytes[LOldLen] := AByte;
end;

procedure AppendString(var VBytes: TIdBytes; const AStr: String; const ALength: Integer = -1;
  ADestEncoding: IIdTextEncoding = nil);
var
  LBytes: TIdBytes;
  LLength, LOldLen: Integer;
begin
  LBytes := nil; // keep the compiler happy
  LLength := IndyLength(AStr, ALength);
  if LLength > 0 then begin
    LBytes := ToBytes(AStr, LLength, 1, ADestEncoding);
    LOldLen := Length(VBytes);
    LLength := Length(LBytes);
    SetLength(VBytes, LOldLen + LLength);
    CopyTIdBytes(LBytes, 0, VBytes, LOldLen, LLength);
  end;
end;

procedure ExpandBytes(var VBytes: TIdBytes; const AIndex: Integer; const ACount: Integer; const AFillByte: Byte = 0);
var
  I: Integer;
begin
  if ACount > 0 then begin
    // if AIndex is at the end of the buffer then the operation is appending bytes
    if AIndex <> Length(VBytes) then begin
      //if these asserts fail, then it indicates an attempted buffer overrun.
      Assert(AIndex >= 0);
      Assert(AIndex < Length(VBytes));
    end;
    SetLength(VBytes, Length(VBytes) + ACount);
    // move any existing bytes at the index to the end of the buffer
    for I := Length(VBytes)-1 downto AIndex+ACount do begin
      VBytes[I] := VBytes[I-ACount];
    end;
    // fill in the new space with the fill byte
    for I := AIndex to AIndex+ACount-1 do begin
      VBytes[I] := AFillByte;
    end;
  end;
end;

procedure InsertBytes(var VBytes: TIdBytes; const ADestIndex: Integer;
  const ASource: TIdBytes; const ASourceIndex: Integer = 0);
var
  LAddLen: Integer;
begin
  LAddLen := IndyLength(ASource, -1, ASourceIndex);
  if LAddLen > 0 then begin
    ExpandBytes(VBytes, ADestIndex, LAddLen);
    CopyTIdBytes(ASource, ASourceIndex, VBytes, ADestIndex, LAddLen);
  end;
end;

procedure InsertByte(var VBytes: TIdBytes; const AByte: Byte; const AIndex: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  ExpandBytes(VBytes, AIndex, 1, AByte);
end;

procedure RemoveBytes(var VBytes: TIdBytes; const ACount: Integer; const AIndex: Integer = 0);
var
  I: Integer;
  LActual: Integer;
begin
  //TODO: check the reference count of VBytes, if >1 then make a new copy
  Assert(AIndex >= 0);
  LActual := IndyMin(Length(VBytes)-AIndex, ACount);
  if LActual > 0 then begin
    if (AIndex + LActual) < Length(VBytes) then begin
      // RLebeau: TODO - use Move() here instead?
      for I := AIndex to Length(VBytes)-LActual-1 do begin
        VBytes[I] := VBytes[I+LActual];
      end;
    end;
    SetLength(VBytes, Length(VBytes)-LActual);
  end;
end;

procedure IdDelete(var s: string; AOffset, ACount: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Delete(s, AOffset, ACount);
end;

procedure IdInsert(const Source: string; var S: string; Index: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Insert(Source, S, Index);
end;

function TextIsSame(const A1, A2: string): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AnsiCompareText(A1, A2) = 0;
end;

// TODO: define STRING_UNICODE_MISMATCH for WinCE in IdCompilerDefines.inc?
{$IF DEFINED(WINDOWS) AND (NOT DEFINED(WINCE)) AND DEFINED(STRING_UNICODE_MISMATCH)}
  {$DEFINE COMPARE_STRING_MISMATCH}
{$IFEND}

function TextStartsWith(const S, SubS: string): Boolean;
var
  LLen: Integer;
  {$IF DEFINED(WINDOWS) AND DEFINED(COMPARE_STRING_MISMATCH)}
  LS, LSubS: TIdPlatformString;
  P1, P2: PIdPlatformChar;
  {$IFEND}
begin
  LLen := Length(SubS);
  Result := LLen <= Length(S);
  if Result then
  begin
    {$IFDEF WINDOWS}
      {$IFDEF COMPARE_STRING_MISMATCH}
    // explicit convert to Ansi/Unicode
    LS := TIdPlatformString(S);
    LSubS := TIdPlatformString(SubS);
    LLen := Length(LSubS);
    Result := LLen <= Length(LS);
    if Result then begin
      P1 := PIdPlatformChar(LS);
      P2 := PIdPlatformChar(LSubS);
      Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P1, LLen, P2, LLen) = 2;
    end;
      {$ELSE}
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PChar(S), LLen, PChar(SubS), LLen) = 2;
      {$ENDIF}
    {$ELSE}
    Result := AnsiCompareText(Copy(S, 1, LLen), SubS) = 0; // TODO: is there a better function to use here to avoid the Copy()?
    {$ENDIF}
  end;
end;

function TextEndsWith(const S, SubS: string): Boolean;
var
  LLen: Integer;
  {$IFDEF WINDOWS}
    {$IFDEF COMPARE_STRING_MISMATCH}
  LS, LSubS: TIdPlatformString;
  P1, P2: PIdPlatformChar;
    {$ELSE}
  P: PChar;
    {$ENDIF}
  {$ENDIF}
begin
  LLen := Length(SubS);
  Result := LLen <= Length(S);
  if Result then
  begin
    {$IFDEF WINDOWS}
      {$IFDEF COMPARE_STRING_MISMATCH}
    // explicit convert to Ansi/Unicode
    LS := TIdPlatformString(S);
    LSubS := TIdPlatformString(SubS);
    LLen := Length(LSubS);
    Result := LLen <= Length(S);
    if Result then begin
      P1 := PIdPlatformChar(LS);
      P2 := PIdPlatformChar(LSubS);
      Inc(P1, Length(LS)-LLen);
      Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P1, LLen, P2, LLen) = 2;
    end;
      {$ELSE}
    P := PChar(S);
    Inc(P, Length(S)-LLen);
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P, LLen, PChar(SubS), LLen) = 2;
      {$ENDIF}
    {$ELSE}
    Result := AnsiCompareText(Copy(S, Length(S)-LLen+1, LLen), SubS) = 0; // TODO: is there a better function to use here to avoid the Copy()?
    {$ENDIF}
  end;
end;

function IndyLowerCase(const A1: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AnsiLowerCase(A1);
end;

function IndyUpperCase(const A1: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AnsiUpperCase(A1);
end;

function IndyCompareStr(const A1, A2: string): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AnsiCompareStr(A1, A2);
end;

function CharPosInSet(const AString: string; const ACharPos: Integer; const ASet: String): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LChar: Char;
  I: Integer;
begin
  Result := 0;
  if ACharPos < 1 then begin
    raise EIdException.Create('Invalid ACharPos');{ do not localize } // TODO: add a resource string, and create a new Exception class for this
  end;
  if ACharPos <= Length(AString) then begin
    // RLebeau 5/8/08: Calling Pos() with a Char as input creates a temporary
    // String.  Normally this is fine, but profiling reveils this to be a big
    // bottleneck for code that makes a lot of calls to CharIsInSet(), so we
    // will scan through ASet looking for the character without a conversion...
    //
    // Result := IndyPos(AString[ACharPos], ASet);
    //
    LChar := AString[ACharPos];
    for I := 1 to Length(ASet) do begin
      if ASet[I] = LChar then begin
        Result := I;
        Exit;
      end;
    end;
  end;
end;

function CharIsInSet(const AString: string; const ACharPos: Integer; const ASet:  String): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := CharPosInSet(AString, ACharPos, ASet) > 0;
end;

function CharIsInEOL(const AString: string; const ACharPos: Integer): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := CharPosInSet(AString, ACharPos, EOL) > 0;
end;

function CharEquals(const AString: string; const ACharPos: Integer; const AValue: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ACharPos < 1 then begin
    raise EIdException.Create('Invalid ACharPos');{ do not localize } // TODO: add a resource string, and create a new Exception class for this
  end;
  Result := ACharPos <= Length(AString);
  if Result then begin
    Result := AString[ACharPos] = AValue;
  end;
end;

{$IFDEF STRING_IS_IMMUTABLE}

{$IFDEF HAS_SysUtils_TStringHelper}
  {$DEFINE HAS_String_IndexOf}
{$ENDIF}

function CharPosInSet(const ASB: TIdStringBuilder; const ACharPos: Integer; const ASet: String): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
{$IFNDEF HAS_String_IndexOf}
var
  LChar: Char;
  I: Integer;
{$ENDIF}
begin
  Result := 0;
  if ACharPos < 1 then begin
    raise EIdException.Create('Invalid ACharPos');{ do not localize } // TODO: add a resource string, and create a new Exception class for this
  end;
  if ACharPos <= ASB.Length then begin
    {$IFDEF HAS_String_IndexOf}
    Result := ASet.IndexOf(ASB[ACharPos-1]) + 1;
    {$ELSE}
    // RLebeau 5/8/08: Calling Pos() with a Char as input creates a temporary
    // String.  Normally this is fine, but profiling reveils this to be a big
    // bottleneck for code that makes a lot of calls to CharIsInSet(), so we
    // will scan through ASet looking for the character without a conversion...
    //
    // Result := IndyPos(ASB[ACharPos-1], ASet);
    //
    LChar := ASB[ACharPos-1];
    for I := 1 to Length(ASet) do begin
      if ASet[I] = LChar then begin
        Result := I;
        Exit;
      end;
    end;
    {$ENDIF}
  end;
end;

function CharIsInSet(const ASB: TIdStringBuilder; const ACharPos: Integer; const ASet:  String): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := CharPosInSet(ASB, ACharPos, ASet) > 0;
end;

function CharIsInEOL(const ASB: TIdStringBuilder; const ACharPos: Integer): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := CharPosInSet(ASB, ACharPos, EOL) > 0;
end;

function CharEquals(const ASB: TIdStringBuilder; const ACharPos: Integer; const AValue: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ACharPos < 1 then begin
    raise EIdException.Create('Invalid ACharPos');{ do not localize } // TODO: add a resource string, and create a new Exception class for this
  end;
  Result := ACharPos <= ASB.Length;
  if Result then begin
    Result := ASB[ACharPos-1] = AValue;
  end;
end;

{$ENDIF}

function ByteIndex(const AByte: Byte; const ABytes: TIdBytes; const AStartIndex: Integer = 0): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := AStartIndex to Length(ABytes)-1 do begin
    if ABytes[I] = AByte then begin
      Result := I;
      Exit;
    end;
  end;
end;

function ByteIdxInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AIndex < 0 then begin
    raise EIdException.Create('Invalid AIndex'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
  if AIndex < Length(ABytes) then begin
    Result := ByteIndex(ABytes[AIndex], ASet);
  end else begin
    Result := -1;
  end;
end;

function ByteIsInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ByteIdxInSet(ABytes, AIndex, ASet) > -1;
end;

function ByteIsInEOL(const ABytes: TIdBytes; const AIndex: Integer): Boolean;
var
  LSet: TIdBytes;
begin
  SetLength(LSet, 2);
  LSet[0] := 13;
  LSet[1] := 10;
  Result := ByteIsInSet(ABytes, AIndex, LSet);
end;

function ReadLnFromStream(AStream: TStream; AMaxLineLength: Integer = -1;
  AExceptionIfEOF: Boolean = False; AByteEncoding: IIdTextEncoding = nil): string; overload;
begin
  if (not ReadLnFromStream(AStream, Result, AMaxLineLength, AByteEncoding)) and AExceptionIfEOF then
  begin
    raise EIdEndOfStream.CreateFmt(RSEndOfStream, ['ReadLnFromStream', AStream.Position]); // do not localize
  end;
end;

//TODO: Continue to optimize this function. Its performance severely impacts the coders
function ReadLnFromStream(AStream: TStream; var VLine: String; AMaxLineLength: Integer = -1;
  AByteEncoding: IIdTextEncoding = nil): Boolean; overload;
const
  LBUFMAXSIZE = 2048;
var
  LStringLen, LResultLen, LBufSize: Integer;
  LBuf: TIdBytes;
  LLine: TIdBytes;
  // LBuf: packed array [0..LBUFMAXSIZE] of Char;
  LStrmPos, LStrmSize: Int64; //LBytesToRead = stream size - Position
  LCrEncountered: Boolean;

  function FindEOL(const ABuf: TIdBytes; var VLineBufSize: Integer; var VCrEncountered: Boolean): Integer;
  var
    i: Integer;
  begin
    Result := VLineBufSize; //EOL not found => use all
    i := 0;
    while i < VLineBufSize do begin
      case ABuf[i] of
        Ord(LF): begin
            Result := i; {string size}
            VCrEncountered := True;
            VLineBufSize := i+1;
            Break;
          end;
        Ord(CR): begin
            Result := i; {string size}
            VCrEncountered := True;
            Inc(i); //crLF?
            if (i < VLineBufSize) and (ABuf[i] = Ord(LF)) then begin
              VLineBufSize := i+1;
            end else begin
              VLineBufSize := i;
            end;
            Break;
          end;
      end;
      Inc(i);
    end;
  end;

begin
  Assert(AStream<>nil);
  VLine := '';
  SetLength(LLine, 0);

  if AMaxLineLength < 0 then begin
    AMaxLineLength := MaxInt;
  end;

  { we store the stream size for the whole routine to prevent
  so do not incur a performance penalty with TStream.Size.  It has
  to use something such as Seek each time the size is obtained}
  {4 seek vs 3 seek}
  LStrmPos := AStream.Position;
  LStrmSize := AStream.Size;

  if LStrmPos >= LStrmSize then begin
    Result := False;
    Exit;
  end;

  SetLength(LBuf, LBUFMAXSIZE);
  LCrEncountered := False;

  repeat
    LBufSize := ReadTIdBytesFromStream(AStream, LBuf, IndyMin(LStrmSize - LStrmPos, LBUFMAXSIZE));
    if LBufSize < 1 then begin
      Break; // TODO: throw a stream read exception instead?
    end;

    LStringLen := FindEOL(LBuf, LBufSize, LCrEncountered);
    Inc(LStrmPos, LBufSize);

    LResultLen := Length(VLine);
    if (LResultLen + LStringLen) > AMaxLineLength then begin
      LStringLen := AMaxLineLength - LResultLen;
      LCrEncountered := True;
      Dec(LStrmPos, LBufSize);
      Inc(LStrmPos, LStringLen);
    end;
    if LStringLen > 0 then begin
      LBufSize := Length(LLine);
      SetLength(LLine, LBufSize+LStringLen);
      CopyTIdBytes(LBuf, 0, LLine, LBufSize, LStringLen);
    end;
  until (LStrmPos >= LStrmSize) or LCrEncountered;

  // RLebeau: why is the original Position being restored here, instead
  // of leaving the Position at the end of the line?
  AStream.Position := LStrmPos;
  VLine := BytesToString(LLine, 0, -1, AByteEncoding);
  Result := True;
end;

{$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
function IndyRegisterExpectedMemoryLeak(AAddress: Pointer): Boolean;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // use only System.RegisterExpectedMemoryLeak() on systems that support
  // it. We should use whatever the RTL's active memory manager is. The user
  // can override the RTL's version of FastMM (2006+ only) with any memory
  // manager they want, such as MadExcept.
  //
  // Fallback to specific memory managers if System.RegisterExpectedMemoryLeak()
  // is not available.

  {$IFDEF HAS_System_RegisterExpectedMemoryLeak}
  // RLebeau 4/21/08: not quite sure what the difference is between the
  // SysRegisterExpectedMemoryLeak() and RegisterExpectedMemoryLeak()
  // functions in the System unit, but calling RegisterExpectedMemoryLeak()
  // is causing stack overflows when FastMM is not active, so call
  // SysRegisterExpectedMemoryLeak() instead...

  // RLebeau 7/4/09: According to Pierre Le Riche, developer of FastMM:
  //
  // "SysRegisterExpectedMemoryLeak() is the leak registration routine for
  // the built-in memory manager. FastMM.RegisterExpectedMemoryLeak is the
  // leak registration code for FastMM. Both of these are thus hardwired to
  // a specific memory manager. In order to register a leak for the
  // *currently installed* memory manager, which is what you typically want
  // to do, you have to call System.RegisterExpectedMemoryLeak().
  // System.RegisterExpectedMemoryLeak() redirects to the leak registration
  // code of the installed memory manager."

    {$I IdSymbolPlatformOff.inc}
  //Result := System.SysRegisterExpectedMemoryLeak(AAddress);
  Result := System.RegisterExpectedMemoryLeak(AAddress);
    {$I IdSymbolPlatformOn.inc}

  {$ELSE}
    // RLebeau 10/5/2014: the user can override the RTL's version of FastMM
    // (2006+ only) with any memory manager, such as MadExcept, so check for
    // that...
    {$IF DEFINED(USE_FASTMM4)}
  Result := FastMM4.RegisterExpectedMemoryLeak(AAddress);
    {$ELSEIF DEFINED(USE_MADEXCEPT)}
  Result := madExcept.HideLeak(AAddress);
    {$ELSEIF DEFINED(USE_LEAKCHECK)}
  Result := LeakCheck.RegisterExpectedMemoryLeak(AAddress);
    {$ELSE}
  Result := False;
    {$IFEND}
  {$ENDIF}
end;
{$ENDIF}

function IndyAddPair(AStrings: TStrings; const AName, AValue: String): TStrings;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TStrings_AddPair}
  Result := AStrings.AddPair(AName, AValue);
  {$ELSE}
    {$IFDEF HAS_TStrings_NameValueSeparator}
  AStrings.Add(AName + AStrings.NameValueSeparator + AValue);
    {$ELSE}
  AStrings.Add(AName + '=' + AValue); {do not localize}
    {$ENDIF}
  Result := AStrings;
  {$ENDIF}
end;

function IndyAddPair(AStrings: TStrings; const AName, AValue: String; AObject: TObject): TStrings;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TStrings_AddPair}
  Result := AStrings.AddPair(AName, AValue, AObject);
  {$ELSE}
    {$IFDEF HAS_TStrings_NameValueSeparator}
  AStrings.AddObject(AName + AStrings.NameValueSeparator + AValue, AObject);
    {$ELSE}
  AStrings.AddObject(AName + '=' + AValue, AObject);
    {$ENDIF}
  Result := AStrings;
  {$ENDIF}
end;

function InternalIndyIndexOf(AStrings: TStrings; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AStrings.Count - 1 do begin
    if ACaseSensitive then begin
      if AStrings[I] = AStr then begin
        Result := I;
        Exit;
      end;
    end else begin
      if TextIsSame(AStrings[I], AStr) then begin
        Result := I;
        Exit;
      end;
    end;
  end;
end;

function IndyIndexOf(AStrings: TStrings; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings is TStringList then begin
    Result := IndyIndexOf(TStringList(AStrings), AStr, ACaseSensitive);
  end else begin
    Result := InternalIndyIndexOf(AStrings, AStr, ACaseSensitive);
  end;
end;

function IndyIndexOf(AStrings: TStringList; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings.CaseSensitive = ACaseSensitive then begin
    Result := AStrings.IndexOf(AStr);
  end else begin
    Result := InternalIndyIndexOf(AStrings, AStr, ACaseSensitive);
  end;
end;

function InternalIndyIndexOfName(AStrings: TStrings; const AName: string;
  const ACaseSensitive: Boolean = False): Integer;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AStrings.Count - 1 do begin
    if ACaseSensitive then begin
      if AStrings.Names[I] = AName then begin
        Result := I;
        Exit;
      end;
    end
    else if TextIsSame(AStrings.Names[I], AName) then begin
      Result := I;
      Exit;
    end;
  end;
end;

function IndyIndexOfName(AStrings: TStrings; const AName: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings is TStringList then begin
    Result := IndyIndexOfName(TStringList(AStrings), AName, ACaseSensitive);
  end else begin
    Result := InternalIndyIndexOfName(AStrings, AName, ACaseSensitive);
  end;
end;

function IndyIndexOfName(AStrings: TStringList; const AName: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings.CaseSensitive = ACaseSensitive then begin
    Result := AStrings.IndexOfName(AName);
  end else begin
    Result := InternalIndyIndexOfName(AStrings, AName, ACaseSensitive);
  end;
end;

function IndyValueFromName(AStrings: TStrings; const AName: String;
  const ACaseSensitive: Boolean = False): String;
var
  I: Integer;
begin
  if AStrings is TStringList then begin
    Result := IndyValueFromName(TStringList(AStrings), AName, ACaseSensitive);
  end else begin
    I := IndyIndexOfName(AStrings, AName, ACaseSensitive);
    if I >= 0 then begin
      Result := IndyValueFromIndex(AStrings, I);
    end else begin
      Result := '';
    end;
  end;
end;

function IndyValueFromName(AStrings: TStringList; const AName: String;
  const ACaseSensitive: Boolean = False): String;
var
  I: Integer;
begin
  I := IndyIndexOfName(AStrings, AName, ACaseSensitive);
  if I >= 0 then begin
    Result := IndyValueFromIndex(AStrings, I);
  end else begin
    Result := '';
  end;
end;

function IndyValueFromIndex(AStrings: TStrings; const AIndex: Integer): String;
{$IFNDEF HAS_TStrings_ValueFromIndex}
var
  LTmp: string;
  LPos: Integer;
  {$IFDEF HAS_TStrings_NameValueSeparator}
  LChar: Char;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF HAS_TStrings_ValueFromIndex}
  Result := AStrings.ValueFromIndex[AIndex];
  {$ELSE}
  Result := '';
  if AIndex >= 0 then
  begin
    LTmp := AStrings.Strings[AIndex];
    {$IFDEF HAS_TStrings_NameValueSeparator}
    // RLebeau 11/8/16: Calling Pos() with a Char as input creates a temporary
    // String.  Normally this is fine, but profiling reveils this to be a big
    // bottleneck for code that makes a lot of calls to Pos() in a loop, so we
    // will scan through the string looking for the character without a conversion...
    //
    // LPos := Pos(AStrings.NameValueSeparator, LTmp); {do not localize}
    // if LPos > 0 then begin
    //
    LChar := AStrings.NameValueSeparator;
    for LPos := 1 to Length(LTmp) do begin
      //if CharEquals(LTmp, LPos, LChar) then begin
      if LTmp[LPos] = LChar then begin
        Result := Copy(LTmp, LPos+1, MaxInt);
        Exit;
      end;
    end;
    {$ELSE}
    LPos := Pos('=', LTmp); {do not localize}
    if LPos > 0 then begin
      Result := Copy(LTmp, LPos+1, MaxInt);
    end;
    {$ENDIF}
  end;
  {$ENDIF}
end;

{$IFDEF WINDOWS}
function IndyWindowsMajorVersion: Integer;
begin
  {$IF DEFINED(HAS_SysUtils_TOSVersion)}
  Result := TOSVersion.Major;
  {$ELSEIF DEFINED(WINCE)}
  Result := SysUtils.WinCEMajorVersion;
  {$ELSE}
  Result := SysUtils.Win32MajorVersion;
  {$IFEND}
end;

function IndyWindowsMinorVersion: Integer;
begin
  {$IF DEFINED(HAS_SysUtils_TOSVersion)}
  Result := TOSVersion.Minor;
  {$ELSEIF DEFINED(WINCE)}
  Result := SysUtils.WinCEMinorVersion;
  {$ELSE}
  Result := SysUtils.Win32MinorVersion;
  {$IFEND}
end;

function IndyWindowsBuildNumber: Integer;
begin
  {$IF DEFINED(HAS_SysUtils_TOSVersion)}
  Result := TOSVersion.Build;
  {$ELSEIF DEFINED(WINCE)}
  Result := SysUtils.WinCEBuildNumber;
  {$ELSE}
  Result := SysUtils.Win32BuildNumber;
  {$IFEND}
  // for this, you need to strip off some junk to do comparisons
  Result := Result and $FFFF;
end;

function IndyWindowsPlatform: Integer;
begin
  // There is no TOSVersion equivilent for this!
  {$IFDEF WINCE}
  Result := SysUtils.WinCEPlatform;
  {$ELSE}
  Result := SysUtils.Win32Platform;
  {$ENDIF}
end;

function IndyCheckWindowsVersion(const AMajor: Integer; const AMinor: Integer = 0): Boolean;
{$IFNDEF HAS_SysUtils_TOSVersion}
var
  LMajor, LMinor: Integer;
{$ENDIF}
begin
  {$IFDEF HAS_SysUtils_TOSVersion}
  Result := TOSVersion.Check(AMajor, AMinor);
  {$ELSE}
  LMajor := IndyWindowsMajorVersion;
  LMinor := IndyWindowsMinorVersion;
  Result := (LMajor > AMajor) or ((LMajor = AMajor) and (LMinor >= AMinor));
  {$ENDIF}
end;
{$ENDIF}

procedure IdDisposeAndNil(var Obj);
{$IFDEF USE_OBJECT_ARC}
var
  Temp: {Pointer}TObject;
{$ENDIF}
begin
  {$IFDEF USE_OBJECT_ARC}
  // RLebeau: was originally calling DisposeOf() on Obj directly, but nil'ing
  // Obj first prevented the calling code from invoking __ObjRelease() on Obj.
  // Don't do that in ARC.  __ObjRelease() needs to be called, even if disposed,
  // to allow the compiler/RTL to finalize Obj so any managed members it has
  // can be cleaned up properly...
  {
  Temp := Pointer(Obj);
  Pointer(Obj) := nil;
  TObject(Temp).DisposeOf;
  }
  Pointer(Temp) := Pointer(Obj);
  Pointer(Obj) := nil;
  Temp.DisposeOf;
  // __ObjRelease() is called when Temp goes out of scope
  {$ELSE}
  // Embarcadero changed the signature of FreeAndNil() in 10.4 Denali...
  FreeAndNil(
    {$IF DEFINED(DCC) AND DEFINED(DCC_10_4_OR_ABOVE)}
    TObject(Obj)
    {$ELSE}
    Obj
    {$IFEND}
  );
  {$ENDIF}
end;

initialization
  // RLebeau 1/14/2021: if the system codepage is set to UTF-8 then set GIdDefaultTextEncoding to match...
  {$IF DEFINED(FPC)}
  // TODO: Delphi also has DefaultSystemCodePage, when was it added?
  if (DefaultSystemCodePage = CP_UTF8) then GIdDefaultTextEncoding := encUTF8;
  {$ELSEIF DEFINED(WINDOWS)}
  if (GetACP() = CP_UTF8) then GIdDefaultTextEncoding := encUTF8;
  {$IFEND}

  // AnsiPos does not handle strings with #0 and is also very slow compared to Pos
  if LeadBytes = [] then begin
    IndyPos := InternalSBPos;
  end else begin
    IndyPos := InternalAnsiPos;
  end;
  {$IFDEF DYNAMICLOAD_InterlockedCompareExchange}
  InterlockedCompareExchange := Stub_InterlockedCompareExchange;
  {$ENDIF}
  {$IFDEF WINDOWS}
  GetTickCount64 := Stub_GetTickCount64;
    {$IFDEF USE_NtQuerySystemInformation}
  NtQuerySystemInformation := Stub_NtQuerySystemInformation;
    {$ENDIF}
  {$ENDIF}
  {$IF DEFINED(UNIX) AND DEFINED(OSX)}
  mach_timebase_info(GMachTimeBaseInfo);
  {$IFEND}

finalization
  FreeAndNil(GIdPorts);

end.

