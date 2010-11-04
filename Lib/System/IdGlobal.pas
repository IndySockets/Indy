
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
  {$IFDEF DOTNET}
  System.Collections.Specialized,
  System.net,
  System.net.Sockets,
  System.Diagnostics,
  System.Threading,
  System.IO,
  System.Text,
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
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
      PosixGlue, PosixSysTypes, PosixPthread, PosixTodo,
      {$ENDIF}
      {$IFDEF USE_BASEUNIX}
      BaseUnix, Unix, Sockets, UnixType, 
      {$ENDIF}
      {$IFDEF USE_ICONV_ENC}iconvenc, {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  IdException;

const
  {This is the only unit with references to OS specific units and IFDEFs. NO OTHER units
  are permitted to do so except .pas files which are counterparts to dfm/xfm files, and only for
  support of that.}

  //We make the version things an Inc so that they can be managed independantly
  //by the package builder.
  {$I IdVers.inc}

  {$IFNDEF DOTNET}
    {$IFNDEF VCL_2007_OR_ABOVE}
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
    {$ENDIF}
  {$ENDIF}

  {$IFDEF DOTNET}
  // Timeout.Infinite is -1 which violates Cardinal which VCL uses for parameter
  // so we are just setting it to this as a hard coded constant until
  // the synchro classes and other are all ported directly to portable classes
  // (SyncObjs is platform specific)
  //Infinite = Timeout.Infinite;
  INFINITE = LongWord($FFFFFFFF);     { Infinite timeout }
  {$ENDIF}

  {$IFDEF KYLIX}
  NilHandle = 0;
  {$ENDIF}
  {$IFDEF DELPHI}
  NilHandle = 0;
  {$ENDIF}
  LF = #10;
  CR = #13;
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
  {$IFDEF DOTNET}
  TIdPID = LongWord;
  TIdThreadId = LongWord;
  TIdThreadHandle = System.Threading.Thread;
    {$IFDEF DOTNETDISTRO}
  TIdThreadPriority = System.Threading.ThreadPriority;
    {$ELSE}
  TIdThreadPriority = TThreadPriority;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF UNIX}
    {$IFDEF KYLIXCOMPAT}
  TIdPID = LongInt;
  TIdThreadId = LongInt;
      {$IFDEF FPC}
  TIdThreadHandle = TThreadID;
      {$ELSE}
  TIdThreadHandle = Cardinal;
      {$ENDIF}
      {$IFDEF INT_THREAD_PRIORITY}
  TIdThreadPriority = -20..19;
      {$ELSE}
  TIdThreadPriority = TThreadPriority;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
  TIdPID = TPid;
  TIdThreadId = TThreadId;
  TIdThreadHandle = TIdThreadId;
  TIdThreadPriority = TThreadPriority;
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
  TIdPID = pid_t;
  TIdThreadId = NativeUInt;
  TIdThreadHandle = NativeUInt;
      {$IFDEF INT_THREAD_PRIORITY}
  TIdThreadPriority = -20..19;
      {$ELSE}
  TIdThreadPriority = TThreadPriority;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  TIdPID = LongWord;
  TIdThreadId = LongWord;
  TIdThreadHandle = THandle;
  TIdThreadPriority = TThreadPriority;
  {$ENDIF}

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
  {$IFDEF VCL_2009_OR_ABOVE}
  TIdUnicodeString = String;
  TIdWideChar = Char;
  PIdWideChar = PChar;
  TIdBytes = TBytes;
  TIdWideChars = {$IFDEF DOTNET}array of Char{$ELSE}TCharArray{$ENDIF};
  {$ELSE}
  TIdUnicodeString = {$IFDEF DOTNET}System.String{$ELSE}WideString{$ENDIF};
  TIdWideChar = WideChar;
  PIdWideChar = PWideChar;
  TIdBytes = array of Byte;
  TIdWideChars = array of WideChar;
  {$ENDIF}

  {$IFNDEF DOTNET}
    {$IFNDEF FPC}
      //needed so that in FreePascal, we can use pointers of different sizes
      {$IFDEF CPU32}
   PtrInt  = LongInt;
   PtrUInt = LongWord;
      {$ENDIF}
      {$IFDEF CPU64}
   PtrInt  = Int64;
   PtrUInt = Int64;
      {$ENDIF}
//NOTE:  The code below asumes a 32bit Linux architecture (such as target i386-linux)
      {$IFDEF KYLIX}
   PtrInt  = LongInt;
   PtrUInt = LongWord;
      {$ENDIF}
     {$ENDIF}
  {$ENDIF}

  {$IFDEF STREAM_SIZE_64}
  TIdStreamSize = Int64;
  {$ELSE}
  TIdStreamSize = Integer;
  {$ENDIF}

  {
  Delphi/C++Builder 2009+ have a TEncoding class which mirrors System.Text.Encoding
  in .NET, but does not have a TDecoder class which mirrors System.Text.Decoder
  in .NET.  For earlier versions, or when the libiconv library is enabled,
  TIdTextEncoding is a wrapper class, otherwise it maps directly to the OS/RTL's
  encoding class.

  This way, Indy can have a unified internal interface for String<->Byte conversions
  without using IFDEFs everywhere.

  Note: Having the wrapper class use WideString in earlier versions adds extra
  overhead to string operations, but this is the only way to ensure that strings
  are encoded properly.  Later on, perhaps we can optimize the operations when
  Ansi-compatible encodings are being used with AnsiString values.
  }

  {$UNDEF TIdASCIIEncoding_NEEDED}
  {$IFDEF TIdTextEncoding_IS_NATIVE}
    {$IFDEF DOTNET}
  TIdTextEncoding = System.Text.Encoding;
  //TIdMBCSEncoding = ?
  TIdASCIIEncoding = System.Text.ASCIIEncoding;
  TIdUTF7Encoding = System.Text.UTF7Encoding;
  TIdUTF8Encoding = System.Text.UTF8Encoding;
  TIdUTF16LittleEndianEncoding = System.Text.UnicodeEncoding;
  TIdUTF16BigEndianEncoding = System.Text.UnicodeEncoding;
    {$ELSE}
  TIdTextEncoding = SysUtils.TEncoding;
  TIdMBCSEncoding = SysUtils.TMBCSEncoding;
  {$DEFINE TIdASCIIEncoding_NEEDED} // see further below
  TIdUTF7Encoding = SysUtils.TUTF7Encoding;
  TIdUTF8Encoding = SysUtils.TUTF8Encoding;
  TIdUTF16LittleEndianEncoding = SysUtils.TUnicodeEncoding;
  TIdUTF16BigEndianEncoding = SysUtils.TBigEndianUnicodeEncoding;
    {$ENDIF}
  {$ELSE}
  TIdTextEncoding = class
  {$IFDEF HAS_CLASSPROPERTIES}
  private
    class function GetASCII: TIdTextEncoding; static;
    class function GetBigEndianUnicode: TIdTextEncoding; static;
    class function GetDefault: TIdTextEncoding; static;
    class function GetUnicode: TIdTextEncoding; static;
    class function GetUTF7: TIdTextEncoding; static;
    class function GetUTF8: TIdTextEncoding; static;
  {$ENDIF}
  protected
    FIsSingleByte: Boolean;
    FMaxCharSize: Integer;
    function GetByteCount(AChars: PIdWideChar; ACharCount: Integer): Integer; overload; virtual; abstract;
    function GetBytes(AChars: PIdWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; overload; virtual; abstract;
    function GetCharCount(ABytes: PByte; AByteCount: Integer): Integer; overload; virtual; abstract;
    function GetChars(ABytes: PByte; AByteCount: Integer; AChars: PIdWideChar; ACharCount: Integer): Integer; overload; virtual; abstract;
  public
    class function Convert(ASource, ADestination: TIdTextEncoding; const ABytes: TIdBytes): TIdBytes; overload;
    class function Convert(ASource, ADestination: TIdTextEncoding; const ABytes: TIdBytes; AStartIndex, ACount: Integer): TIdBytes; overload;
    class procedure FreeEncodings;
    class function IsStandardEncoding(AEncoding: TIdTextEncoding): Boolean;
    class function GetBufferEncoding(const ABuffer: TIdBytes; var AEncoding: TIdTextEncoding): Integer;
    function GetByteCount(const AChars: TIdWideChars): Integer; overload;
    function GetByteCount(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetByteCount(const AStr: TIdUnicodeString): Integer; overload;
    function GetByteCount(const AStr: TIdUnicodeString; ACharIndex, ACharCount: Integer): Integer; overload;
    function GetBytes(const AChars: TIdWideChars): TIdBytes; overload;
    function GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetBytes(const AStr: TIdUnicodeString): TIdBytes; overload;
    function GetBytes(const AStr: TIdUnicodeString; ACharIndex, ACharCount: Integer; var VBytes: TIdBytes; AByteIndex: Integer): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes): Integer; overload;
    function GetCharCount(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): Integer; overload;
    function GetChars(const ABytes: TIdBytes): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdWideChars; overload;
    function GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer; var VChars: TIdWideChars; ACharIndex: Integer): Integer; overload;
    {$IFDEF USE_ICONV}
    class function GetEncoding(const ACharSet: String): TIdTextEncoding;
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    class function GetEncoding(ACodePage: Integer): TIdTextEncoding;
      {$ENDIF}
    {$ENDIF}
    function GetMaxByteCount(ACharCount: Integer): Integer; virtual; abstract;
    function GetMaxCharCount(AByteCount: Integer): Integer; virtual; abstract;
    function GetPreamble: TIdBytes; virtual; abstract;
    function GetString(const ABytes: TIdBytes): TIdUnicodeString; overload;
    function GetString(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdUnicodeString; overload;
    {$IFDEF HAS_CLASSPROPERTIES}
    class property ASCII: TIdTextEncoding read GetASCII;
    class property BigEndianUnicode: TIdTextEncoding read GetBigEndianUnicode;
    class property Default: TIdTextEncoding read GetDefault;
    {$ELSE}
    class function ASCII: TIdTextEncoding;
    class function BigEndianUnicode: TIdTextEncoding;
    class function Default: TIdTextEncoding;
    {$ENDIF}
    property IsSingleByte: Boolean read FIsSingleByte;
    {$IFDEF HAS_CLASSPROPERTIES}
    class property Unicode: TIdTextEncoding read GetUnicode;
    class property UTF7: TIdTextEncoding read GetUTF7;
    class property UTF8: TIdTextEncoding read GetUTF8;
    {$ELSE}
    class function Unicode: TIdTextEncoding;
    class function UTF7: TIdTextEncoding;
    class function UTF8: TIdTextEncoding;
    {$ENDIF}
  end;

  TIdMBCSEncoding = class(TIdTextEncoding)
  private
    {$IFDEF USE_ICONV}
    FToUTF16 : iconv_t;
    FFromUTF16 : iconv_t;
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    FCodePage: Cardinal;
    FMBToWCharFlags: Cardinal;
    FWCharToMBFlags: Cardinal;
      {$ENDIF}
    {$ENDIF}
  protected
    function GetByteCount(Chars: PWideChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; overload; virtual;
    {$IFDEF USE_ICONV}
    constructor Create(const CharSet : AnsiString); overload; virtual;
    destructor Destroy; override;
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    constructor Create(CodePage: Integer); overload; virtual;
    constructor Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer); overload; virtual;
      {$ENDIF}
    {$ENDIF}
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  {$DEFINE TIdASCIIEncoding_NEEDED} // see further below

  TIdUTF7Encoding = class(TIdMBCSEncoding)
  protected
    function GetByteCount(Chars: PWideChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
  end;

  TIdUTF8Encoding = class(TIdUTF7Encoding)
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdUTF16LittleEndianEncoding = class(TIdTextEncoding)
  protected
    function GetByteCount(Chars: PWideChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; virtual;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

  TIdUTF16BigEndianEncoding = class(TIdUTF16LittleEndianEncoding)
  protected
    function GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar; CharCount: Integer): Integer; overload; override;
  public
    function GetPreamble: TIdBytes; override;
  end;
  {$ENDIF}

  {$IFDEF TIdASCIIEncoding_NEEDED}
  TIdASCIIEncoding = class(TIdTextEncoding)
  protected
    function GetByteCount(AChars: PIdWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(AChars: PIdWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(ABytes: PByte; AByteCount: Integer; AChars: PIdWideChar; ACharCount: Integer): Integer; override;
  public
    constructor Create; virtual;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;
  {$ENDIF}

  // These are for backwards compatibility with past Indy 10 releases
  function enDefault: TIdTextEncoding; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use a nil TIdTextEncoding pointer'{$ENDIF};{$ENDIF}
  {$NODEFINE enDefault}
  function en7Bit: TIdTextEncoding; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use IndyASCIIEncoding()'{$ENDIF};{$ENDIF}
  {$NODEFINE en7Bit}
  function en8Bit: TIdTextEncoding; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use Indy8BitEncoding()'{$ENDIF};{$ENDIF}
  {$NODEFINE en8Bit}
  function enUTF8: TIdTextEncoding; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use IndyUTF8Encoding()'{$ENDIF};{$ENDIF}
  {$NODEFINE enUTF8}

  function Indy8BitEncoding{$IFNDEF DOTNET}(const AOwnedByIndy: Boolean = True){$ENDIF}: TIdTextEncoding;
  function IndyASCIIEncoding{$IFNDEF DOTNET}(const AOwnedByIndy: Boolean = True){$ENDIF}: TIdTextEncoding;
  function IndyUTF8Encoding{$IFNDEF DOTNET}(const AOwnedByIndy: Boolean = True){$ENDIF}: TIdTextEncoding;

  (*$HPPEMIT '// These are helper macros to handle differences in "class" properties between different C++Builder versions'*)
  {$IFDEF HAS_CLASSPROPERTIES}
  (*$HPPEMIT '#define TIdTextEncoding_ASCII TIdTextEncoding::ASCII'*)
  (*$HPPEMIT '#define TIdTextEncoding_BigEndianUnicode TIdTextEncoding::BigEndianUnicode'*)
  (*$HPPEMIT '#define TIdTextEncoding_Default TIdTextEncoding::Default'*)
  (*$HPPEMIT '#define TIdTextEncoding_Unicode TIdTextEncoding::Unicode'*)
  (*$HPPEMIT '#define TIdTextEncoding_UTF7 TIdTextEncoding::UTF7'*)
  (*$HPPEMIT '#define TIdTextEncoding_UTF8 TIdTextEncoding::UTF8'*)
  {$ELSE}
  (*$HPPEMIT '#define TIdTextEncoding_ASCII TIdTextEncoding::ASCII(__classid(TIdTextEncoding))'*)
  (*$HPPEMIT '#define TIdTextEncoding_BigEndianUnicode TIdTextEncoding::BigEndianUnicode(__classid(TIdTextEncoding))'*)
  (*$HPPEMIT '#define TIdTextEncoding_Default TIdTextEncoding::Default(__classid(TIdTextEncoding))'*)
  (*$HPPEMIT '#define TIdTextEncoding_Unicode TIdTextEncoding::Unicode(__classid(TIdTextEncoding))'*)
  (*$HPPEMIT '#define TIdTextEncoding_UTF7 TIdTextEncoding::UTF7(__classid(TIdTextEncoding))'*)
  (*$HPPEMIT '#define TIdTextEncoding_UTF8 TIdTextEncoding::UTF8(__classid(TIdTextEncoding))'*)
  {$ENDIF}
  (*$HPPEMIT ''*)

  (*$HPPEMIT '// These are for backwards compatibility with earlier Indy 10 releases'*)
  (*$HPPEMIT '#define enDefault ( ( TIdTextEncoding* )NULL )'*)
  {$IFDEF DOTNET}
  (*$HPPEMIT '#define en8Bit Indy8BitEncoding()'*)
  (*$HPPEMIT '#define en7Bit IndyASCIIEncoding()'*)
  (*$HPPEMIT '#define enUTF8 IndyUTF8Encoding()'*)
  {$ELSE}
  (*$HPPEMIT '#define en8Bit Indy8BitEncoding(true)'*)
  (*$HPPEMIT '#define en7Bit IndyASCIIEncoding(true)'*)
  (*$HPPEMIT '#define enUTF8 IndyUTF8Encoding(true)'*)
  {$ENDIF}
  (*$HPPEMIT ''*)

type
  IdAnsiEncodingType = (encIndyDefault, encOSDefault, encASCII, encUTF7, encUTF8);

var
  {RLebeau: using ASCII by default because most Internet protocols that Indy
  implements are based on ASCII specifically, not Ansi.  Non-ASCII data has
  to be explicitally allowed by RFCs, in which case the caller should not be
  using nil TIdTextEncoding objects to begin with...}

  GIdDefaultAnsiEncoding: IdAnsiEncodingType = encASCII;

procedure EnsureEncoding(var VEncoding : TIdTextEncoding; ADefEncoding: IdAnsiEncodingType = encIndyDefault);

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

  {$IFDEF DOTNET}
    {$IFNDEF DOTNET_2_OR_ABOVE}
  // dotNET implementation
  TWaitResult = (wrSignaled, wrTimeout, wrAbandoned, wrError);

  TEvent = class(TObject)
  protected
    FEvent: WaitHandle;
  public
    constructor Create(EventAttributes: IntPtr; ManualReset,
      InitialState: Boolean; const Name: string = ''); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure SetEvent;
    procedure ResetEvent;
    function WaitFor(Timeout: LongWord): TWaitResult; virtual;
  end;

  TCriticalSection = class(TObject)
  public
    procedure Acquire; virtual;
    procedure Release; virtual;
    function TryEnter: Boolean;
    procedure Enter;
    procedure Leave;
  end;
    {$ENDIF}
  {$ELSE}
    {$IFNDEF NO_REDECLARE}
 // TCriticalSection = SyncObjs.TCriticalSection;
    {$ENDIF}
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

  {$IFDEF DOTNET}
  Short = System.Int16;
  {$ENDIF}
  {$IFDEF UNIX}
  Short = Smallint;  //Only needed for ToBytes(Short) and BytesToShort
  {$ENDIF}
  {$IFNDEF DOTNET}
    {$IFNDEF NO_REDECLARE}
  PShort = ^Short;
    {$ENDIF}
  {$ENDIF}

  {$IFDEF VCL_4_OR_ABOVE}
    {$IFNDEF VCL_6_OR_ABOVE} // Delphi 6 has PCardinal
  PCardinal = ^Cardinal;
    {$ENDIF}
  {$ENDIF}

  //This usually is a property editor exception
  EIdCorruptServicesFile = class(EIdException);
  EIdEndOfStream = class(EIdException);
  EIdInvalidIPv6Address = class(EIdException);
  EIdNoEncodingSpecified = class(EIdException);
  //This is called whenever there is a failure to retreive the time zone information
  EIdFailedToRetreiveTimeZoneInfo = class(EIdException);

  TIdPort = Word;

  //We don't have a native type that can hold an IPv6 address.
  {$NODEFINE TIdIPv6Address}
  TIdIPv6Address = array [0..7] of word;

  // C++ does not allow an array to be returned by a function,
  // so wrapping the array in a struct as a workaround...
  (*$HPPEMIT 'namespace Idglobal'*)
  (*$HPPEMIT '{'*)
  (*$HPPEMIT '    struct TIdIPv6Address'*)
  (*$HPPEMIT '    {'*)
  (*$HPPEMIT '        Word data[8];'*)
  (*$HPPEMIT '        Word& operator[](int index) { return data[index]; }'*)
  (*$HPPEMIT '        const Word& operator[](int index) const { return data[index]; }'*)
  (*$HPPEMIT '        operator const Word*() const { return data; }'*)
  (*$HPPEMIT '        operator Word*() { return data; }'*)
  (*$HPPEMIT '    };'*)
  (*$HPPEMIT '}'*)

  {This way instead of a boolean for future expansion of other actions}
  TIdMaxLineAction = (maException, maSplit);
  TIdOSType = (otUnknown, otUnix, otWindows, otDotNet);
  //This is for IPv6 support when merged into the core
  TIdIPVersion = (Id_IPv4, Id_IPv6);

  {$IFNDEF NO_REDECLARE}
    {$IFDEF LINUX}
      {$IFNDEF VCL_6_OR_ABOVE}
  THandle = LongWord; //D6.System
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DOTNET}
  THandle = Integer;
  {$ELSE}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
//  THandle = Windows.THandle;
     {$ENDIF}
  {$ENDIF}
  TPosProc = function(const substr, str: String): LongInt;
  {$IFNDEF DOTNET}
  TStrScanProc = function(Str: PChar; Chr: Char): PChar;
  {$ENDIF}
  TIdReuseSocket = (rsOSDependent, rsTrue, rsFalse);

  {$IFNDEF VCL_6_OR_ABOVE}
  TIdExtList = class(TList) // We use this hack-class, because TList has no .assign on Delphi 5.
  public                      // Do NOT add DataMembers to this class !!!
    procedure Assign(AList: TList);
  end;
  {$ELSE}
  TIdExtList = class(TList);
  {$ENDIF}

  {$IFNDEF STREAM_SIZE_64}
  type
    TSeekOrigin = (soBeginning, soCurrent, soEnd);
  {$ENDIF}

  // TIdBaseStream is defined here to allow TIdMultiPartFormData to be defined
  // without any $IFDEFs in the unit IdMultiPartFormData - in accordance with Indy Coding rules
  TIdBaseStream = class(TStream)
  protected
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; virtual; abstract;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; virtual; abstract;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; virtual; abstract;
    procedure IdSetSize(ASize: Int64); virtual; abstract;
    {$IFDEF DOTNET}
    procedure SetSize(ASize: Int64); override;
    {$ELSE}
      {$IFDEF STREAM_SIZE_64}
    procedure SetSize(const NewSize: Int64); override;
      {$ELSE}
    procedure SetSize(ASize: Integer); override;
      {$ENDIF}
    {$ENDIF}
  public
    {$IFDEF DOTNET}
    function Read(var VBuffer: array of Byte; AOffset, ACount: Longint): Longint; override;
    function Write(const ABuffer: array of Byte; AOffset, ACount: Longint): Longint; override;
    function Seek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    {$ELSE}
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
      {$IFDEF STREAM_SIZE_64}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
      {$ELSE}
    function Seek(Offset: Longint; Origin: Word): Longint; override;
      {$ENDIF}
    {$ENDIF}
  end;

  TIdStreamReadEvent = procedure(var VBuffer: TIdBytes; AOffset, ACount: Longint; var VResult: Longint) of object;
  TIdStreamWriteEvent = procedure(const ABuffer: TIdBytes; AOffset, ACount: Longint; var VResult: Longint) of object;
  TIdStreamSeekEvent = procedure(const AOffset: Int64; AOrigin: TSeekOrigin; var VPosition: Int64) of object;
  TIdStreamSetSizeEvent = procedure(const ANewSize: Int64) of object;

  TIdEventStream = class(TIdBaseStream)
  protected
    FOnRead: TIdStreamReadEvent;
    FOnWrite: TIdStreamWriteEvent;
    FOnSeek: TIdStreamSeekEvent;
    FOnSetSize: TIdStreamSetSizeEvent;
    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    procedure IdSetSize(ASize: Int64); override;
  public
    property OnRead: TIdStreamReadEvent read FOnRead write FOnRead;
    property OnWrite: TIdStreamWriteEvent read FOnWrite write FOnWrite;
    property OnSeek: TIdStreamSeekEvent read FOnSeek write FOnSeek;
    property OnSetSize: TIdStreamSetSizeEvent read FOnSetSize write FOnSetSize;
  end;

const
  {$IFDEF UNIX}
  GOSType = otUnix;
  GPathDelim = '/'; {do not localize}
  INFINITE = LongWord($FFFFFFFF);     { Infinite timeout }
  {$ENDIF}

  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  GOSType = otWindows;
  GPathDelim = '\'; {do not localize}
  Infinite = Windows.INFINITE; { redeclare here for use elsewhere without using Windows.pas }  // cls modified 1/23/2002
  {$ENDIF}

  {$IFDEF DOTNET}
  GOSType = otDotNet;
  GPathDelim = '\'; {do not localize}
//  Infinite = ?; { redeclare here for use elsewhere without using Windows.pas }  // cls modified 1/23/2002
  {$ENDIF}

  // S.G. 4/9/2002: IP version general switch for defaults
  {$IFDEF IdIPv6}
  ID_DEFAULT_IP_VERSION = Id_IPv6;
  {$ELSE}
  ID_DEFAULT_IP_VERSION = Id_IPv4;
  {$ENDIF}

  {$IFNDEF VCL_6_OR_ABOVE}
  //Only D6 & Kylix have this constant
  sLineBreak = EOL;
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
function IndyLength(const ABuffer: TStream; const ALength: TIdStreamSize = -1): TIdStreamSize; overload;

function IndyFormat(const AFormat: string; const Args: array of const): string;
function IndyIncludeTrailingPathDelimiter(const S: string): string;
function IndyExcludeTrailingPathDelimiter(const S: string): string;

procedure IndyRaiseLastError;
//You could possibly use the standard StrInt and StrIntDef but these
//also remove spaces from the string using the trim functions.
function IndyStrToInt(const S: string): Integer; overload;
function IndyStrToInt(const S: string; ADefault: Integer): Integer; overload;

function IndyFileAge(const AFileName: string): TDateTime;
function IndyDirectoryExists(const ADirectory: string): Boolean;

//You could possibly use the standard StrToInt and StrToInt64Def
//functions but these also remove spaces using the trim function
function IndyStrToInt64(const S: string; const ADefault: Int64): Int64; overload;
function IndyStrToInt64(const S: string): Int64;  overload;

//This converts the string to an Integer or Int64 depending on the bit size TStream uses
function IndyStrToStreamSize(const S: string; const ADefault: TIdStreamSize): TIdStreamSize; overload;
function IndyStrToStreamSize(const S: string): TIdStreamSize; overload;

function AddMSecToTime(const ADateTime: TDateTime; const AMSec: Integer): TDateTime;

// To and From Bytes conversion routines
function ToBytes(const AValue: string; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
function ToBytes(const AValue: string; const ALength: Integer; const AIndex: Integer = 1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
function ToBytes(const AValue: Char; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
function ToBytes(const AValue: LongInt): TIdBytes; overload;
function ToBytes(const AValue: Short): TIdBytes; overload;
function ToBytes(const AValue: Word): TIdBytes; overload;
function ToBytes(const AValue: Byte): TIdBytes; overload;
function ToBytes(const AValue: LongWord): TIdBytes; overload;
function ToBytes(const AValue: Int64): TIdBytes; overload;
function ToBytes(const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0): TIdBytes; overload;
{$IFNDEF DOTNET}
// RLebeau - not using the same "ToBytes" naming convention for RawToBytes()
// in order to prevent ambiquious errors with ToBytes(TIdBytes) above
function RawToBytes(const AValue; const ASize: Integer): TIdBytes;
{$ENDIF}

// The following functions are faster but except that Bytes[] must have enough
// space for at least SizeOf(AValue) bytes.
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Char; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: LongInt); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Short); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Word); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Byte); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: LongWord); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int64); overload;
procedure ToBytesF(var Bytes: TIdBytes; const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0); overload;
{$IFNDEF DOTNET}
// RLebeau - not using the same "ToBytesF" naming convention for RawToBytesF()
// in order to prevent ambiquious errors with ToBytesF(TIdBytes) above
procedure RawToBytesF(var Bytes: TIdBytes; const AValue; const ASize: Integer);
{$ENDIF}

function ToHex(const AValue: TIdBytes; const ACount: Integer = -1; const AIndex: Integer = 0): string; overload;
function ToHex(const AValue: array of LongWord): string; overload; // for IdHash
function BytesToString(const AValue: TIdBytes; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
function BytesToString(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
function BytesToStringRaw(const AValue: TIdBytes): string; overload;
function BytesToStringRaw(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1): string; overload;
function BytesToChar(const AValue: TIdBytes; const AIndex: Integer = 0;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Char; overload;
function BytesToChar(const AValue: TIdBytes; var VChar: Char; const AIndex: Integer = 0;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Integer; overload;
function BytesToShort(const AValue: TIdBytes; const AIndex: Integer = 0): Short;
function BytesToWord(const AValue: TIdBytes; const AIndex : Integer = 0): Word;
function BytesToLongWord(const AValue: TIdBytes; const AIndex : Integer = 0): LongWord;
function BytesToLongInt(const AValue: TIdBytes; const AIndex: Integer = 0): LongInt;
function BytesToInt64(const AValue: TIdBytes; const AIndex: Integer = 0): Int64;
function BytesToIPv4Str(const AValue: TIdBytes; const AIndex: Integer = 0): String;
procedure BytesToIPv6(const AValue: TIdBytes; var VAddress: TIdIPv6Address; const AIndex: Integer = 0);
{$IFNDEF DOTNET}
procedure BytesToRaw(const AValue: TIdBytes; var VBuffer; const ASize: Integer);
{$ENDIF}

// TIdBytes utilities
procedure AppendBytes(var VBytes: TIdBytes; const AToAdd: TIdBytes; const AIndex: Integer = 0; const ALength: Integer = -1);
procedure AppendByte(var VBytes: TIdBytes; const AByte: Byte);
procedure AppendString(var VBytes: TIdBytes; const AStr: String; const ALength: Integer = -1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
procedure ExpandBytes(var VBytes: TIdBytes; const AIndex: Integer; const ACount: Integer; const AFillByte: Byte = 0);
procedure InsertBytes(var VBytes: TIdBytes; const ADestIndex: Integer; const ASource: TIdBytes; const ASourceIndex: Integer = 0);
procedure InsertByte(var VBytes: TIdBytes; const AByte: Byte; const AIndex: Integer);
procedure RemoveBytes(var VBytes: TIdBytes; const ACount: Integer; const AIndex: Integer = 0);

// Common Streaming routines
function ReadLnFromStream(AStream: TStream; var VLine: String; AMaxLineLength: Integer = -1;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Boolean; overload;
function ReadLnFromStream(AStream: TStream; AMaxLineLength: Integer = -1;
  AExceptionIfEOF: Boolean = False; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
function ReadStringFromStream(AStream: TStream; ASize: Integer = -1; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
procedure WriteStringToStream(AStream: TStream; const AStr: string; ADestEncoding: TIdTextEncoding
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
procedure WriteStringToStream(AStream: TStream; const AStr: string; const ALength: Integer = -1;
  const AIndex: Integer = 1; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
function ReadCharFromStream(AStream: TStream; var VChar: Char; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Integer;
function ReadTIdBytesFromStream(const AStream: TStream; var ABytes: TIdBytes;
  const Count: TIdStreamSize; const AIndex: Integer = 0): TIdStreamSize;
procedure WriteTIdBytesToStream(const AStream: TStream; const ABytes: TIdBytes;
  const ASize: Integer = -1; const AIndex: Integer = 0);

function ByteToHex(const AByte: Byte): string;
function ByteToOctal(const AByte: Byte): string;

function LongWordToHex(const ALongWord : LongWord) : String;

procedure CopyTIdBytes(const ASource: TIdBytes; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer);

procedure CopyTIdByteArray(const ASource: array of Byte; const ASourceIndex: Integer;
  var VDest: array of Byte; const ADestIndex: Integer; const ALength: Integer);

procedure CopyTIdChar(const ASource: Char; var VDest: TIdBytes; const ADestIndex: Integer;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
procedure CopyTIdShort(const ASource: Short; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdWord(const ASource: Word; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdLongInt(const ASource: LongInt; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdLongWord(const ASource: LongWord; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdInt64(const ASource: Int64; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdIPV6Address(const ASource: TIdIPv6Address; var VDest: TIdBytes; const ADestIndex: Integer);
procedure CopyTIdString(const ASource: String; var VDest: TIdBytes; const ADestIndex: Integer;
  const ALength: Integer = -1; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
procedure CopyTIdString(const ASource: String; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer = -1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;

// Need to change prob not to use this set
function CharPosInSet(const AString: string; const ACharPos: Integer; const ASet: String): Integer;
function CharIsInSet(const AString: string; const ACharPos: Integer; const ASet: String): Boolean;
function CharIsInEOL(const AString: string; const ACharPos: Integer): Boolean;
function CharEquals(const AString: string; const ACharPos: Integer; const AValue: Char): Boolean;

function ByteIndex(const AByte: Byte; const ABytes: TIdBytes; const AStartIndex: Integer = 0): Integer;
function ByteIdxInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Integer;
function ByteIsInSet(const ABytes: TIdBytes; const AIndex: Integer; const ASet: TIdBytes): Boolean;
function ByteIsInEOL(const ABytes: TIdBytes; const AIndex: Integer): Boolean;

function CompareDate(const D1, D2: TDateTime): Integer;
function CurrentProcessId: TIdPID;

// RLebeau: the input of these two functions must be in GMT
function DateTimeGMTToHttpStr(const GMTValue: TDateTime) : String;
function DateTimeGMTToCookieStr(const GMTValue: TDateTime) : String;

// RLebeau: the input of these functions must be in local time
function DateTimeToInternetStr(const Value: TDateTime; const AUseGMTStr: Boolean = False) : String; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use LocalDateTimeToGMT()'{$ENDIF};{$ENDIF}
function DateTimeToGmtOffSetStr(ADateTime: TDateTime; const AUseGMTStr: Boolean = False): string; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use UTCOffsetToStr()'{$ENDIF};{$ENDIF}
function LocalDateTimeToHttpStr(const Value: TDateTime) : String;
function LocalDateTimeToCookieStr(const Value: TDateTime) : String;
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
//GetTickDiff required because GetTickCount will wrap
function GetTickDiff(const AOldTickCount, ANewTickCount: LongWord): LongWord; //IdICMP uses it
procedure IdDelete(var s: string; AOffset, ACount: Integer);
procedure IdInsert(const Source: string; var S: string; Index: Integer);
{$IFNDEF DOTNET}
function IdPorts: TList;
{$ENDIF}
function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer; overload;
function iif(ATest: Boolean; const ATrue: string; const AFalse: string = ''): string; overload; { do not localize }
function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;
function iif(const AEncoding, ADefEncoding: TIdTextEncoding; ADefEncodingType: IdAnsiEncodingType = encASCII): TIdTextEncoding; overload;

function InMainThread: Boolean;
function IPv6AddressToStr(const AValue: TIdIPv6Address): string;

//Note that there is NO need for Big Endian byte order functions because
//that's done through HostToNetwork byte order functions.
function HostToLittleEndian(const AValue : Word) : Word; overload;
function HostToLittleEndian(const AValue : LongWord): LongWord; overload;
function HostToLittleEndian(const AValue : Integer): Integer; overload;

function LittleEndianToHost(const AValue : Word) : Word; overload;
function LittleEndianToHost(const AValue : LongWord): LongWord; overload;
function LittleEndianToHost(const AValue : Integer): Integer; overload;

procedure WriteMemoryStreamToStream(Src: TMemoryStream; Dest: TStream; Count: TIdStreamSize);
{$IFNDEF DOTNET_EXCLUDE}
function IsCurrentThread(AThread: TThread): boolean;
{$ENDIF}
function IPv4ToDWord(const AIPAddress: string): LongWord; overload;
function IPv4ToDWord(const AIPAddress: string; var VErr: Boolean): LongWord; overload;
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
{$IFNDEF DOTNET}
function InterlockedExchangeTHandle(var VTarget: THandle; const AValue: PtrUInt): THandle;
function InterlockedCompareExchangePtr(var VTarget: Pointer; const AValue, Compare: Pointer): Pointer;
{$ENDIF}
function MakeCanonicalIPv4Address(const AAddr: string): string;
function MakeCanonicalIPv6Address(const AAddr: string): string;
function MakeDWordIntoIPv4Address(const ADWord: LongWord): string;
function IndyMin(const AValueOne, AValueTwo: Int64): Int64; overload;
function IndyMin(const AValueOne, AValueTwo: LongInt): LongInt; overload;
function IndyMin(const AValueOne, AValueTwo: Word): Word; overload;
function IndyMax(const AValueOne, AValueTwo: Int64): Int64; overload;
function IndyMax(const AValueOne, AValueTwo: LongInt): LongInt; overload;
function IndyMax(const AValueOne, AValueTwo: Word): Word; overload;
function IPv4MakeLongWordInRange(const AInt: Int64; const A256Power: Integer): LongWord;
{$IFNDEF DOTNET}
  {$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
function IndyRegisterExpectedMemoryLeak(AAddress: Pointer): Boolean;
  {$ENDIF}
{$ENDIF}
{$IFDEF UNIX}
function HackLoad(const ALibName : String; const ALibVersions : array of String) : HMODULE;
{$ENDIF}
{$IFNDEF DOTNET}
function MemoryPos(const ASubStr: string; MemBuff: PChar; MemorySize: Integer): Integer;
{$ENDIF}
function OffsetFromUTC: TDateTime;
function UTCOffsetToStr(const AOffset: TDateTime; const AUseGMTStr: Boolean = False): string;

function PosIdx(const ASubStr, AStr: string; AStartPos: LongWord = 0): LongWord; //For "ignoreCase" use AnsiUpperCase
function PosInSmallIntArray(const ASearchInt: SmallInt; const AArray: array of SmallInt): Integer;
function PosInStrArray(const SearchStr: string; const Contents: array of string; const CaseSensitive: Boolean = True): Integer;
{$IFNDEF DOTNET}
function ServicesFilePath: string;
{$ENDIF}
procedure IndySetThreadPriority(AThread: TThread; const APriority: TIdThreadPriority; const APolicy: Integer = -MaxInt);
procedure SetThreadName(const AName: string; {$IFDEF DOTNET}AThread: System.Threading.Thread = nil{$ELSE}AThreadID: LongWord = $FFFFFFFF{$ENDIF});
procedure IndySleep(ATime: LongWord);
//in Integer(Strings.Objects[i]) - column position in AData
procedure SplitColumnsNoTrim(const AData: string; AStrings: TStrings; const ADelim: string = ' ');    {Do not Localize}
procedure SplitColumns(const AData: string; AStrings: TStrings; const ADelim: string = ' ');    {Do not Localize}
function StartsWithACE(const ABytes: TIdBytes): Boolean;
function StringsReplace(const S: String; const OldPattern, NewPattern: array of string): string;
function ReplaceOnlyFirst(const S, OldPattern, NewPattern: string): string;
function TextIsSame(const A1, A2: string): Boolean;
function TextStartsWith(const S, SubS: string): Boolean;
function TextEndsWith(const S, SubS: string): Boolean;
function IndyUpperCase(const A1: string): string;
function IndyLowerCase(const A1: string): string;
function IndyCompareStr(const A1: string; const A2: string): Integer;
function Ticks: LongWord;
procedure ToDo(const AMsg: string);
function TwoByteToWord(AByte1, AByte2: Byte): Word;

function IndyIndexOf(AStrings: TStrings; const AStr: string; const ACaseSensitive: Boolean = False): Integer;{$IFDEF HAS_TStringList_CaseSensitive} overload;{$ENDIF}
{$IFDEF HAS_TStringList_CaseSensitive}
function IndyIndexOf(AStrings: TStringList; const AStr: string; const ACaseSensitive: Boolean = False): Integer; overload;
{$ENDIF}

function IndyIndexOfName(AStrings: TStrings; const AStr: string; const ACaseSensitive: Boolean = False): Integer;{$IFDEF HAS_TStringList_CaseSensitive} overload;{$ENDIF}
{$IFDEF HAS_TStringList_CaseSensitive}
function IndyIndexOfName(AStrings: TStringList; const AStr: string; const ACaseSensitive: Boolean = False): Integer; overload;
{$ENDIF}

var
  {$IFDEF UNIX}

  // For linux the user needs to set this variable to be accurate where used (mail, etc)
  GOffsetFromUTC: TDateTime = 0;
  {$ENDIF}

  IndyPos: TPosProc = nil;

{$IFDEF UNIX}
const
  {$IFDEF DARWIN}
  LIBEXT = '.dylib'; {do not localize}
  {$ELSE}
  LIBEXT = '.so'; {do not localize}
  {$ENDIF}
{$ENDIF}

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  PosixSysSelect,
  PosixSysSocket,
  PosixTime, PosixSysTime,
  {$ENDIF}
  {$IFDEF VCL_CROSS_COMPILE}
    {$IFDEF MACOSX}
  CoreServices,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
    {$IFDEF USE_FASTMM4}FastMM4,{$ENDIF}
  {$ENDIF}
  {$IFDEF USE_LIBC}Libc,{$ENDIF}
  {$IFDEF VCL_6_OR_ABOVE}DateUtils,{$ENDIF}
  //do not bring in our IdIconv unit if we are using the libc unit directly.
  {$IFDEF USE_ICONV_UNIT}IdIconv, {$ENDIF}
  IdResourceStrings,
  IdStream;

{$IFDEF FPC}
  {$IFDEF WINCE}
  //FreePascal for WindowsCE may not define these.
const
  CP_UTF7 = 65000;
  CP_UTF8 = 65001;
  {$ENDIF}
{$ENDIF}

procedure EnsureEncoding(var VEncoding : TIdTextEncoding; ADefEncoding: IdAnsiEncodingType = encIndyDefault);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if VEncoding = nil then
  begin
    if ADefEncoding = encIndyDefault then begin
      ADefEncoding := GIdDefaultAnsiEncoding;
    end;
    case ADefEncoding of
      encASCII: VEncoding := IndyASCIIEncoding;
      encUTF7:  VEncoding := TIdTextEncoding.UTF7;
      encUTF8:  VEncoding := IndyUTF8Encoding;
    else
      VEncoding := TIdTextEncoding.Default;
    end;
  end;
end;

{$IFDEF FPC}
   {$IFNDEF WIN32_OR_WIN64_OR_WINCE}
//FreePascal may not define this for non-Windows systems.
//#define MAKEWORD(a, b)      ((WORD)(((BYTE)(a)) | ((WORD)((BYTE)(b))) << 8))
function MakeWord(const a, b : Byte) : Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := (a) or (b shl 8);
end;
   {$ENDIF}
{$ENDIF}

{$IFNDEF DOTNET}
var
  GIdPorts: TList = nil;
  GId8BitEncoding: TIdTextEncoding = nil;

  // RLebeau: ASCII is handled separate from other standard encodings
  // because we need to do special handling of its codepage regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  GIdASCIIEncoding: TIdTextEncoding = nil;

  // RLebeau: UTF-8 is handled separate from other standard encodings
  // because we need to avoid the MB_ERR_INVALID_CHARS flag regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  GIdUTF8Encoding: TIdTextEncoding = nil;
{$ENDIF}

{$IFNDEF TIdTextEncoding_IS_NATIVE}

var
  GIdBEUTF16Encoding: TIdTextEncoding = nil;
  GIdDefaultEncoding: TIdTextEncoding = nil;
  GIdLEUTF16Encoding: TIdTextEncoding = nil;
  GIdUTF7Encoding: TIdTextEncoding = nil;

{ TIdTextEncoding }

class function TIdTextEncoding.Convert(ASource, ADestination: TIdTextEncoding;
  const ABytes: TIdBytes): TIdBytes;
begin
  Result := ADestination.GetBytes(ASource.GetChars(ABytes));
end;

class function TIdTextEncoding.Convert(ASource, ADestination: TIdTextEncoding;
  const ABytes: TIdBytes; AStartIndex, ACount: Integer): TIdBytes;
begin
  Result := ADestination.GetBytes(ASource.GetChars(ABytes, AStartIndex, ACount));
end;

class procedure TIdTextEncoding.FreeEncodings;
begin
  FreeAndNil(GIdDefaultEncoding);

  // RLebeau: ASCII is handled separate from other standard encodings
  // because we need to do special handling of its codepage regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  //FreeAndNil(GIdASCIIEncoding);

  // RLebeau: UTF-8 is handled separate from other standard encodings
  // because we need to avoid the MB_ERR_INVALID_CHARS flag regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  //FreeAndNil(GIdUTF8Encoding);

  FreeAndNil(GIdUTF7Encoding);
  FreeAndNil(GIdLEUTF16Encoding);
  FreeAndNil(GIdBEUTF16Encoding);
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetASCII: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.ASCII: TIdTextEncoding;
{$ENDIF}
begin
  // RLebeau: ASCII is handled separate from other standard encodings
  // because we need to do special handling of its codepage regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  Result := IndyASCIIEncoding(True);
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetBigEndianUnicode: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.BigEndianUnicode: TIdTextEncoding;
{$ENDIF}
var
  LEncoding: TIdTextEncoding;
begin
  if GIdBEUTF16Encoding = nil then
  begin
    LEncoding := TIdUTF16BigEndianEncoding.Create;
    if InterlockedCompareExchangePtr(Pointer(GIdBEUTF16Encoding), LEncoding, nil) <> nil then
      LEncoding.Free;
  end;
  Result := GIdBEUTF16Encoding;
end;

class function TIdTextEncoding.GetBufferEncoding(const ABuffer: TIdBytes; var AEncoding: TIdTextEncoding): Integer;

  function ContainsPreamble(const Buffer, Signature: TIdBytes): Boolean;
  var
    I: Integer;
  begin
    if Length(Buffer) >= Length(Signature) then
    begin
      Result := True;
      for I := 0 to Length(Signature)-1 do
      begin
        if Buffer[I] <> Signature [I] then
        begin
          Result := False;
          Break;
        end;
      end;
    end else begin
      Result := False;
    end;
  end;

var
  Preamble: TIdBytes;
begin
  Result := 0;
  if AEncoding = nil then
  begin
    // Find the appropriate encoding
    if ContainsPreamble(ABuffer, TIdTextEncoding.Unicode.GetPreamble) then begin
      AEncoding := TIdTextEncoding.Unicode;
    end
    else if ContainsPreamble(ABuffer, TIdTextEncoding.BigEndianUnicode.GetPreamble) then begin
      AEncoding := TIdTextEncoding.BigEndianUnicode;
    end
    else if ContainsPreamble(ABuffer, IndyUTF8Encoding.GetPreamble) then begin
      AEncoding := IndyUTF8Encoding;
    end else
    begin
      AEncoding := TIdTextEncoding.Default;
    end;
    Result := Length(AEncoding.GetPreamble);
  end else
  begin
    Preamble := AEncoding.GetPreamble;
    if ContainsPreamble(ABuffer, Preamble) then
      Result := Length(Preamble);
  end;
end;

function TIdTextEncoding.GetByteCount(const AChars: TIdWideChars): Integer;
begin
  Result := GetByteCount(AChars, 0, Length(AChars));
end;

function TIdTextEncoding.GetByteCount(const AChars: TIdWideChars; ACharIndex,
  ACharCount: Integer): Integer;
begin
  if ACharIndex < 0 then
    raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);
  if ACharCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  if (Length(AChars) - ACharIndex) < ACharCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  if ACharCount > 0 then begin
    Result := GetByteCount(@AChars[ACharIndex], ACharCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncoding.GetByteCount(const AStr: TIdUnicodeString): Integer;
begin
  Result := GetByteCount(PWideChar(AStr), Length(AStr));
end;

function TIdTextEncoding.GetByteCount(const AStr: TIdUnicodeString; ACharIndex, ACharCount: Integer): Integer;
begin
  if ACharIndex < 1 then
    raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);
  if ACharCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  if (Length(AStr) - ACharIndex + 1) < ACharCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);

  if ACharCount > 0 then begin
    Result := GetByteCount(PWideChar(@AStr[ACharIndex]), ACharCount);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncoding.GetBytes(const AChars: TIdWideChars): TIdBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(AChars);
  SetLength(Result, Len);
  if Len > 0 then begin
    GetBytes(AChars, 0, Length(AChars), Result, 0);
  end;
end;

function TIdTextEncoding.GetBytes(const AChars: TIdWideChars; ACharIndex, ACharCount: Integer;
  var VBytes: TIdBytes; AByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (AChars = nil) and (ACharCount <> 0) then
    raise Exception.CreateRes(@RSInvalidSourceArray);
  if (VBytes = nil) and (ACharCount <> 0) then
    raise Exception.CreateRes(@RSInvalidDestinationArray);
  if ACharIndex < 0 then
    raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);
  if ACharCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  if (Length(AChars) - ACharIndex) < ACharCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  Len := Length(VBytes);
  if (AByteIndex < 0) or (AByteIndex > Len) then
    raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [AByteIndex]);
  if Len - AByteIndex < GetByteCount(AChars, ACharIndex, ACharCount) then
    raise Exception.CreateRes(@RSInvalidDestinationArray);

  Len := Len - AByteIndex;
  if (ACharCount > 0) and (Len > 0) then begin
    Result := GetBytes(@AChars[ACharIndex], ACharCount, @VBytes[AByteIndex], Len);
  end else begin
    Result := 0;
  end;
end;

function TIdTextEncoding.GetBytes(const AStr: TIdUnicodeString): TIdBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(AStr);
  SetLength(Result, Len);
  if Len > 0 then begin
    GetBytes(AStr, 1, Length(AStr), Result, 0);
  end;
end;

function TIdTextEncoding.GetBytes(const AStr: TIdUnicodeString; ACharIndex, ACharCount: Integer;
  var VBytes: TIdBytes; AByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (VBytes = nil) and (ACharCount <> 0) then
    raise Exception.CreateRes(@RSInvalidSourceArray);
  if ACharIndex < 1 then
    raise Exception.CreateResFmt(@RSCharIndexOutOfBounds, [ACharIndex]);
  if ACharCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  if (Length(AStr) - ACharIndex + 1) < ACharCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [ACharCount]);
  Len := Length(VBytes);
  if (AByteIndex < 0) or (AByteIndex > Len) then
    raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [AByteIndex]);
  if Len - AByteIndex < GetByteCount(AStr, ACharIndex, ACharCount) then
    raise Exception.CreateRes(@RSInvalidDestinationArray);

  Len := Len - AByteIndex;
  if (ACharCount > 0) and (Len > 0) then begin
    Result := GetBytes(@AStr[ACharIndex], ACharCount, @VBytes[AByteIndex], Len);
  end else begin
    Result := 0
  end;
end;

function TIdTextEncoding.GetCharCount(const ABytes: TIdBytes): Integer;
begin
  Result := GetCharCount(ABytes, 0, Length(ABytes));
end;

function TIdTextEncoding.GetCharCount(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): Integer;
begin
  if (ABytes = nil) and (AByteCount <> 0) then
    raise Exception.CreateRes(@RSInvalidSourceArray);
  if AByteIndex < 0 then
    raise Exception.CreateResFmt(@RSByteIndexOutOfBounds, [AByteIndex]);
  if AByteCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);
  if (Length(ABytes) - AByteIndex) < AByteCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);

  if AByteCount > 0 then begin
    Result := GetCharCount(@ABytes[AByteIndex], AByteCount);
  end else begin
    Result := 0
  end;
end;

function TIdTextEncoding.GetChars(const ABytes: TIdBytes): TIdWideChars;
begin
  Result := GetChars(ABytes, 0, Length(ABytes));
end;

function TIdTextEncoding.GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdWideChars;
var
  Len: Integer;
begin
  if (ABytes = nil) and (AByteCount <> 0) then
    raise Exception.CreateRes(@RSInvalidSourceArray);
  if AByteIndex < 0 then
    raise Exception.CreateResFmt(@RSByteIndexOutOfBounds, [AByteIndex]);
  if AByteCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);
  if (Length(ABytes) - AByteIndex) < AByteCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);

  Len := GetCharCount(ABytes, AByteIndex, AByteCount);
  SetLength(Result, Len);
  if Len > 0 then begin
    GetChars(@ABytes[AByteIndex], AByteCount, PWideChar(Result), Len);
  end;
end;

function TIdTextEncoding.GetChars(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer;
  var VChars: TIdWideChars; ACharIndex: Integer): Integer;
var
  LCharCount: Integer;
begin
  if (ABytes = nil) and (AByteCount <> 0) then
    raise Exception.CreateRes(@RSInvalidSourceArray);
  if AByteIndex < 0 then
    raise Exception.CreateResFmt(@RSByteIndexOutOfBounds, [AByteIndex]);
  if AByteCount < 0 then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);
  if (Length(ABytes) - AByteIndex) < AByteCount then
    raise Exception.CreateResFmt(@RSInvalidCharCount, [AByteCount]);

  LCharCount := GetCharCount(ABytes, AByteIndex, AByteCount);
  if (ACharIndex < 0) or (ACharIndex > Length(VChars)) then
    raise Exception.CreateResFmt(@RSInvalidDestinationIndex, [ACharIndex]);
  if ACharIndex + LCharCount > Length(VChars) then
    raise Exception.CreateRes(@RSInvalidDestinationArray);

  if (AByteCount > 0) and (LCharCount > 0) then begin
    Result := GetChars(@ABytes[AByteIndex], AByteCount, @VChars[ACharIndex], LCharCount);
  end else begin
    Result := 0
  end;
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetDefault: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.Default: TIdTextEncoding;
{$ENDIF}
var
  LEncoding: TIdTextEncoding;
begin
  if GIdDefaultEncoding = nil then
  begin
    {$IFDEF USE_ICONV}
    LEncoding := TIdMBCSEncoding.Create('ASCII');
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    LEncoding := TIdMBCSEncoding.Create(CP_ACP, 0, 0);
      {$ELSE}
    ToDo('Default property of TIdTextEncoding class is not implemented for this platform yet'); {do not localize}
      {$ENDIF}
    {$ENDIF}
    if InterlockedCompareExchangePtr(Pointer(GIdDefaultEncoding), LEncoding, nil) <> nil then
      LEncoding.Free;
  end;
  Result := GIdDefaultEncoding;
end;

{$IFDEF USE_ICONV}
class function TIdTextEncoding.GetEncoding(const ACharSet: String): TIdTextEncoding;
begin
  Result := TIdMBCSEncoding.Create(ACharSet);
end;
{$ELSE}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
class function TIdTextEncoding.GetEncoding(ACodePage: Integer): TIdTextEncoding;
begin
  case ACodePage of
    1200:  Result := TIdUTF16LittleEndianEncoding.Create;
    1201:  Result := TIdUTF16BigEndianEncoding.Create;
    65000: Result := TIdUTF7Encoding.Create;
    20127:
      // RLebeau: 20127 is the official codepage for ASCII,
      // but not all OS versions support that codepage...
      Result := IndyASCIIEncoding(False);
    65001:
      // RLebeau: UTF-8 is handled separate from other standard
      // encodings because we need to avoid the MB_ERR_INVALID_CHARS
      // flag regardless of whether TIdTextEncoding is implemented
      // natively or manually...
      Result := IndyUTF8Encoding(False);
  else
    Result := TIdMBCSEncoding.Create(ACodePage);
  end;
end;
  {$ENDIF}
{$ENDIF}

function TIdTextEncoding.GetString(const ABytes: TIdBytes): TIdUnicodeString;
begin
  Result := GetString(ABytes, 0, Length(ABytes));
end;

function TIdTextEncoding.GetString(const ABytes: TIdBytes; AByteIndex, AByteCount: Integer): TIdUnicodeString;
var
  LChars: TIdWideChars;
begin
  LChars := GetChars(ABytes, AByteIndex, AByteCount);
  SetString(Result, PWideChar(LChars), Length(LChars));
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetUnicode: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.Unicode: TIdTextEncoding;
{$ENDIF}
var
  LEncoding: TIdTextEncoding;
begin
  if GIdLEUTF16Encoding = nil then
  begin
    LEncoding := TIdUTF16LittleEndianEncoding.Create;
    if InterlockedCompareExchangePtr(Pointer(GIdLEUTF16Encoding), LEncoding, nil) <> nil then
      LEncoding.Free;
  end;
  Result := GIdLEUTF16Encoding;
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetUTF7: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.UTF7: TIdTextEncoding;
{$ENDIF}
var
  LEncoding: TIdTextEncoding;
begin
  if GIdUTF7Encoding = nil then
  begin
    LEncoding := TIdUTF7Encoding.Create;
    if InterlockedCompareExchangePtr(Pointer(GIdUTF7Encoding), LEncoding, nil) <> nil then
      LEncoding.Free;
  end;
  Result := GIdUTF7Encoding;
end;

{$IFDEF HAS_CLASSPROPERTIES}
class function TIdTextEncoding.GetUTF8: TIdTextEncoding;
{$ELSE}
class function TIdTextEncoding.UTF8: TIdTextEncoding;
{$ENDIF}
begin
  // RLebeau: UTF-8 is handled separate from other standard encodings
  // because we need to avoid the MB_ERR_INVALID_CHARS flag regardless
  // of whether TIdTextEncoding is implemented natively or manually...
  Result := IndyUTF8Encoding(True);
end;

class function TIdTextEncoding.IsStandardEncoding(AEncoding: TIdTextEncoding): Boolean;
begin
  Result := Assigned(AEncoding) and (
    (AEncoding = GIdASCIIEncoding) or
    (AEncoding = GIdBEUTF16Encoding) or
    (AEncoding = GIdDefaultEncoding) or
    (AEncoding = GIdLEUTF16Encoding) or
    (AEncoding = GIdUTF7Encoding) or
    (AEncoding = GIdUTF8Encoding)
  );
end;

{ TIdMBCSEncoding }

constructor TIdMBCSEncoding.Create;
begin
  {$IFDEF USE_ICONV}
  Create('ASCII'); {do not localize}
  {$ELSE}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Create(CP_ACP, 0, 0);
    {$ELSE}
  ToDo('Constructor of TIdMBCSEncoding class is not implemented for this platform yet'); {do not localize}
    {$ENDIF}
 {$ENDIF}
end;

{$IFDEF USE_ICONV}
constructor TIdMBCSEncoding.Create(const CharSet: AnsiString);
const
  // RLebeau: iconv() does not provide a maximum character byte size like
  // Microsoft does, so have to determine the max bytes by manually encoding
  // an actual Unicode codepoint.  We'll encode the largest codepoint that
  // UTF-16 supports, $10FFFD, for now...
  cValue: array[0..1] of Word = ($DBFF, $DFFD);
begin
  inherited Create;

  FToUTF16 := iconv_open(PAnsiChar(CharSet), 'UTF-16');    {do not localize}
  FFromUTF16 := iconv_open('UTF-16', PAnsiChar(CharSet));  {do not localize}

  if (FToUTF16 = iconv_t(-1)) or (FFromUTF16 = iconv_t(-1)) then begin
    if FToUTF16 <> iconv_t(-1) then begin
      iconv_close(FToUTF16);
      FToUTF16 := iconv_t(-1);
    end;
    if FFromUTF16 <> iconv_t(-1) then begin
      iconv_close(FFromUTF16);
      FFromUTF16 := iconv_t(-1);
    end;
    raise EIdException.CreateResFmt(@RSInvalidCharSet, [CharSet]);
  end;

  FMaxCharSize := GetByteCount(PWideChar(@cValue[0]), 2);
  FIsSingleByte := FMaxCharSize = 1;
end;

destructor TIdMBCSEncoding.Destroy;
begin
  if FToUTF16 <> iconv_t(-1) then begin
    iconv_close(FToUTF16);
  end;
  if FFromUTF16 <> iconv_t(-1) then begin
    iconv_close(FFromUTF16);
  end;
  inherited;
end;
{$ELSE}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
constructor TIdMBCSEncoding.Create(CodePage: Integer);
begin
  Create(CodePage, 0, 0);
end;

constructor TIdMBCSEncoding.Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer);
var
  LCPInfo: TCPInfo;
  LError: Boolean;
begin
  FCodePage := CodePage;
  FMBToWCharFlags := MBToWCharFlags;
  FWCharToMBFlags := WCharToMBFlags;

  LError := not GetCPInfo(FCodePage, LCPInfo);
  if LError and (FCodePage = 20127) then begin
    // RLebeau: 20127 is the official codepage for ASCII, but not
    // all OS versions support that codepage, so fallback to 1252
    // or even 437...
    FCodePage := 1252;
    LError := not GetCPInfo(FCodePage, LCPInfo);
    // just in case...
    if LError then begin
      FCodePage := 437;
      LError := not GetCPInfo(FCodePage, LCPInfo);
    end;
  end;
  if LError then begin
    raise EIdException.CreateResFmt(@RSInvalidCodePage, [FCodePage]);
  end;

  FMaxCharSize := LCPInfo.MaxCharSize;
  FIsSingleByte := FMaxCharSize = 1;
end;
  {$ENDIF}
{$ENDIF}

function TIdMBCSEncoding.GetByteCount(Chars: PWideChar; CharCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  LBytes: array[0..3] of Byte;
  LCharsPtr, LBytesPtr: PAnsiChar;
  LCharCount, LByteCount: size_t;
{$ENDIF}
begin
  {$IFDEF USE_ICONV}
  // RLebeau: iconv() does not allow for querying a pre-calculated byte size
  // for the input like Microsoft does, so have to determine the max bytes
  // by actually encoding the Unicode data to a real buffer.  We'll encode
  // to a small local buffer so we don't have to use a lot of memory...
  Result := 0;
  LCharsPtr := PAnsiChar(Chars);
  LCharCount := CharCount * SizeOf(WideChar);
  while LCharCount > 0 do
  begin
    LBytesPtr := PAnsiChar(@LBytes[0]);
    LByteCount := SizeOf(LBytes);
    //Kylix has an odd definition in iconv.  In Kylix, __outbytesleft is defined as a var
    //while in FreePascal's libc and our IdIconv units define it as a pSize_t
    if iconv(FFromUTF16, @LCharsPtr, @LCharCount, @LBytesPtr, {$IFNDEF KYLIX}@{$ENDIF}LByteCount) = size_t(-1) then
    begin
      Result := 0;
      Exit;
    end;
    // LByteCount was decremented by the number of bytes stored in the output buffer
    Inc(Result, SizeOf(LBytes)-LByteCount);
  end;
  {$ELSE}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags, Chars, CharCount, nil, 0, nil, nil);
    {$ELSE}
  ToDo('GetByteCount() method of TIdMBCSEncoding class is not implemented for this platform yet'); {do not localize}
    {$ENDIF}
  {$ENDIF}
end;

function TIdMBCSEncoding.GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte;
  ByteCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  LCharsPtr, LBytesPtr: PAnsiChar;
  LCharCount, LByteCount: size_t;
{$ENDIF}
begin
  {$IFDEF USE_ICONV}
  Result := 0;
  LCharsPtr := PAnsiChar(Chars);
  LCharCount := CharCount * SizeOf(WideChar);
  LBytesPtr := PAnsiChar(Bytes);
  LByteCount := ByteCount;
  Assert (LBytesPtr <> nil,'TIdMBCSEncoding.GetBytes LBytesPtr can not be nil');
  //Kylix has an odd definition in iconv.  In Kylix, __outbytesleft is defined as a var
  //while in FreePascal's libc and our IdIconv units define it as a pSize_t
  if iconv(FFromUTF16, @LCharsPtr, @LCharCount, @LBytesPtr, {$IFNDEF KYLIX}@{$ENDIF}LByteCount) = size_t(-1) then
  begin
    Exit;
  end;
  // LByteCount was decremented by the number of bytes stored in the output buffer
  Result := ByteCount-LByteCount;
  {$ELSE}
    {$IFDEF  WIN32_OR_WIN64_OR_WINCE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags, Chars, CharCount, PAnsiChar(Bytes), ByteCount, nil, nil);
    {$ELSE}
  ToDo('GetBytes() method of TIdMBCSEncoding class is not implemented for this platform yet'); {do not localize}
    {$ENDIF}
  {$ENDIF}
end;

function TIdMBCSEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  LChars: array[0..3] of WideChar;
  LBytesPtr, LCharsPtr: PAnsiChar;
  LByteCount, LCharsSize: size_t;
{$ENDIF}
begin
  {$IFDEF USE_ICONV}
  // RLebeau: iconv() does not allow for querying a pre-calculated character count
  // for the input like Microsoft does, so have to determine the max characters
  // by actually encoding the Ansi data to a real buffer.  We'll encode to a
  // small local buffer so we don't have to use a lot of memory...
  Result := 0;
  LBytesPtr := PAnsiChar(Bytes);
  LByteCount := ByteCount;
  while LByteCount > 0 do
  begin
    LCharsPtr := PAnsiChar(@LChars[0]);
    LCharsSize := SizeOf(LChars);
    //Kylix has an odd definition in iconv.  In Kylix, __outbytesleft is defined as a var
    //while in FreePascal's libc and our IdIconv units define it as a pSize_t
    if iconv(FToUTF16, @LBytesPtr, @LByteCount, @LCharsPtr, {$IFNDEF KYLIX}@{$ENDIF}LCharsSize) = size_t(-1) then
    begin
      Result := 0;
      Exit;
    end;
    // LBufferCount was decremented by the number of bytes stored in the output buffer
    Inc(Result, (SizeOf(LChars)-LCharsSize) div SizeOf(WideChar));
  end;
  {$ELSE}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags, PAnsiChar(Bytes), ByteCount, nil, 0);
    {$ELSE}
  ToDo('GetCharCount() method of TIdMBCSEncoding class is not implemented for this platform yet'); {do not localize}
    {$ENDIF}
  {$ENDIF}
end;

function TIdMBCSEncoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar;
  CharCount: Integer): Integer;
{$IFDEF USE_ICONV}
var
  LBytesPtr, LCharsPtr: PAnsiChar;
  LByteCount, LCharsSize, LMaxCharsSize: size_t;
{$ENDIF}
begin
  {$IFDEF USE_ICONV}
  Result := 0;
  LBytesPtr := PAnsiChar(Bytes);
  LByteCount := ByteCount;
  LCharsPtr := PAnsiChar(Chars);
  LMaxCharsSize := CharCount * SizeOf(WideChar);
  LCharsSize := LMaxCharsSize;
  Assert (LCharsPtr <> nil,'TIdMBCSEncoding.GetChars LCharsPtr can not be nil');
  //Kylix has an odd definition in iconv.  In Kylix, __outbytesleft is defined as a var
  //while in FreePascal's libc and our IdIconv units define it as a pSize_t
  if iconv(FToUTF16, @LBytesPtr, @LByteCount, @LCharsPtr, {$IFNDEF KYLIX}@{$ENDIF}LCharsSize) = size_t(-1) then
  begin
    Exit;
  end;
  // LCharCount was decremented by the number of bytes stored in the output buffer
  Inc(Result, (LMaxCharsSize-LCharsSize) div SizeOf(WideChar));
  {$ELSE}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags, PAnsiChar(Bytes), ByteCount, Chars, CharCount);
    {$ELSE}
  ToDo('GetChars() method of TIdMBCSEncoding class is not implemented for this platform yet'); {do not localize}
    {$ENDIF}
  {$ENDIF}
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
  SetLength(Result, 0);
end;

{ TIdUTF7Encoding }

constructor TIdUTF7Encoding.Create;
begin
{$IFDEF USE_ICONV}
  inherited Create('UTF-7');
{$ELSE}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  inherited Create(CP_UTF7);
  {$ELSE}
  ToDo('Construtor of TIdUTF7Encoding class is not implemented for this platform yet'); {do not localize}
  {$ENDIF}
{$ENDIF}
end;

function TIdUTF7Encoding.GetByteCount(Chars: PWideChar; CharCount: Integer): Integer;
begin
  Result := inherited GetByteCount(Chars, CharCount);
end;

function TIdUTF7Encoding.GetBytes(Chars: PWideChar; CharCount: Integer; Bytes: PByte;
  ByteCount: Integer): Integer;
begin
  Result := inherited GetBytes(Chars, CharCount, Bytes, ByteCount);
end;

function TIdUTF7Encoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := inherited GetCharCount(Bytes, ByteCount);
end;

function TIdUTF7Encoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PWideChar;
  CharCount: Integer): Integer;
begin
  Result := inherited GetChars(Bytes, ByteCount, Chars, CharCount);
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

constructor TIdUTF8Encoding.Create;
begin
{$IFDEF USE_ICONV}
  inherited Create('UTF-8');
{$ELSE}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  inherited Create(CP_UTF8, 0, 0);
  {$ELSE}
  ToDo('Constructor of TIdUTF8Encoding class is not implemented for this platform yet'); {do not localize}
  {$ENDIF}
{$ENDIF}
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
  FIsSingleByte := False;
  FMaxCharSize := 4;
end;

function TIdUTF16LittleEndianEncoding.GetByteCount(Chars: PWideChar; CharCount: Integer): Integer;
begin
  Result := CharCount * SizeOf(WideChar);
end;

function TIdUTF16LittleEndianEncoding.GetBytes(Chars: PWideChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
{$IFDEF ENDIAN_BIG}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF ENDIAN_BIG}
  for I := CharCount - 1 downto 0 do
  begin
    Bytes^ := Hi(Word(Chars^));
    Inc(Bytes);
    Bytes^ := Lo(Word(Chars^));
    Inc(Bytes);
    Inc(Chars);
  end;
  Result := CharCount * SizeOf(WideChar);
  {$ELSE}
  Result := CharCount * SizeOf(WideChar);
  Move(Chars^, Bytes^, Result);
  {$ENDIF}
end;

function TIdUTF16LittleEndianEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := ByteCount div SizeOf(WideChar);
end;

function TIdUTF16LittleEndianEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PWideChar; CharCount: Integer): Integer;
{$IFDEF ENDIAN_BIG}
var
  P: PByte;
  I: Integer;
{$ENDIF}
begin
  {$IFDEF ENDIAN_BIG}
  P := Bytes;
  Inc(P);
  for I := 0 to CharCount - 1 do
  begin
    Chars^ := WideChar(MakeWord(P^, Bytes^));
    Inc(Bytes, 2);
    Inc(P, 2);
    Inc(Chars);
  end;
  Result := CharCount;
  {$ELSE}
  Result := ByteCount div SizeOf(WideChar);
  Move(Bytes^, Chars^, Result * SizeOf(WideChar));
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

function TIdUTF16BigEndianEncoding.GetBytes(Chars: PWideChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
{$IFDEF ENDIAN_LITTLE}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF ENDIAN_LITTLE}
  for I := CharCount - 1 downto 0 do
  begin
    Bytes^ := Hi(Word(Chars^));
    Inc(Bytes);
    Bytes^ := Lo(Word(Chars^));
    Inc(Bytes);
    Inc(Chars);
  end;
  Result := CharCount * SizeOf(WideChar);
  {$ELSE}
  Result := CharCount * SizeOf(WideChar);
  Move(Chars^, Bytes^, Result);
  {$ENDIF}
end;

function TIdUTF16BigEndianEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PWideChar; CharCount: Integer): Integer;
{$IFDEF ENDIAN_LITTLE}
var
  P: PByte;
  I: Integer;
{$ENDIF}
begin
  {$IFDEF ENDIAN_LITTLE}
  P := Bytes;
  Inc(P);
  for I := 0 to CharCount - 1 do
  begin
    Chars^ := WideChar(MakeWord(P^, Bytes^));
    Inc(Bytes, 2);
    Inc(P, 2);
    Inc(Chars);
  end;
  Result := CharCount;
  {$ELSE}
  Result := ByteCount div SizeOf(WideChar);
  Move(Bytes^, Chars^, Result * SizeOf(WideChar));
  {$ENDIF}
end;

function TIdUTF16BigEndianEncoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 2);
  Result[0] := $FE;
  Result[1] := $FF;
end;

{$ENDIF} // end of {$IFNDEF TIdTextEncoding_IS_NATIVE}

function enDefault: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := nil;
end;

function en7Bit: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IndyASCIIEncoding;
end;

function en8Bit: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := Indy8BitEncoding;
end;

function enUTF8: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IndyUTF8Encoding;
end;

{$IFDEF DOTNET}

function Indy8BitEncoding: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // We need a charset that converts UTF-16 codeunits in the $00-$FF range
  // to/from their numeric values as-is.  Was previously using "Windows-1252"
  // which does so for most codeunits, however codeunits $80-$9F in
  // Windows-1252 map to different codepoints in Unicode, which we don't want.
  // "ISO-8859-1" aka "ISO_8859-1:1987" (not to be confused with the older
  // "ISO 8859-1" charset), on the other hand, treats codeunits $00-$FF as-is,
  // and seems to be just as widely supported as Windows-1252 on most systems,
  // so we'll use that for now...

  Result := TIdTextEncoding.GetEncoding('ISO-8859-1');
end;

function IndyASCIIEncoding: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TIdTextEncoding.ASCII;
end;

function IndyUTF8Encoding: TIdTextEncoding;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TIdTextEncoding.UTF8;
end;

{$ELSE}

{ TIdASCIIEncoding }

constructor TIdASCIIEncoding.Create;
begin
  FIsSingleByte := True;
  FMaxCharSize := 1;
end;

function TIdASCIIEncoding.GetByteCount(AChars: PIdWideChar; ACharCount: Integer): Integer;
begin
  Result := ACharCount;
end;

function TIdASCIIEncoding.GetBytes(AChars: PIdWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  i : Integer;
begin
  Result := IndyMin(ACharCount, AByteCount);
  for i := 1 to Result do begin
    // replace illegal characters > $7F
    if Word(AChars^) > $007F then begin
      ABytes^ := Byte(Ord('?'));
    end else begin
      ABytes^ := Byte(AChars^);
    end;
    //advance to next char
    Inc(AChars);
    Inc(ABytes);
  end;
end;

function TIdASCIIEncoding.GetCharCount(ABytes: PByte; AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

function TIdASCIIEncoding.GetChars(ABytes: PByte; AByteCount: Integer;
  AChars: PIdWideChar; ACharCount: Integer): Integer;
var
  i : Integer;
begin
  Result := IndyMin(ACharCount, AByteCount);
  for i := 1 to Result do begin
    // This is an invalid byte in the ASCII encoding.
    if ABytes^ > $7F then begin
      Word(AChars^) := Ord('?');
    end else begin
      Word(AChars^) := ABytes^;
    end;
    //advance to next byte
    Inc(AChars);
    Inc(ABytes);
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

function TIdASCIIEncoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 0);
end;

function IndyASCIIEncoding(const AOwnedByIndy: Boolean = True): TIdTextEncoding;
var
  LEncoding: TIdTextEncoding;
begin
  if not AOwnedByIndy then begin
    LEncoding := TIdASCIIEncoding.Create;
  end else
  begin
    if GIdASCIIEncoding = nil then begin
      LEncoding := TIdASCIIEncoding.Create;
      if InterlockedCompareExchangePtr(Pointer(GIdASCIIEncoding), LEncoding, nil) <> nil then begin
        LEncoding.Free;
      end;
    end;
    LEncoding := GIdASCIIEncoding;
  end;
  Result := LEncoding;
end;

{ TId8BitEncoding }

type
  TId8BitEncoding = class(TIdTextEncoding)
  protected
    function GetByteCount(AChars: PIdWideChar; ACharCount: Integer): Integer; override;
    function GetBytes(AChars: PIdWideChar; ACharCount: Integer; ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetCharCount(ABytes: PByte; AByteCount: Integer): Integer; override;
    function GetChars(ABytes: PByte; AByteCount: Integer; AChars: PIdWideChar; ACharCount: Integer): Integer; override;
  public
    constructor Create; virtual;
    function GetMaxByteCount(ACharCount: Integer): Integer; override;
    function GetMaxCharCount(AByteCount: Integer): Integer; override;
    function GetPreamble: TIdBytes; override;
  end;

constructor TId8BitEncoding.Create;
begin
  FIsSingleByte := True;
  FMaxCharSize := 1;
end;

function TId8BitEncoding.GetByteCount(AChars: PIdWideChar; ACharCount: Integer): Integer;
begin
  Result := ACharCount;
end;

function TId8BitEncoding.GetBytes(AChars: PIdWideChar; ACharCount: Integer;
  ABytes: PByte; AByteCount: Integer): Integer;
var
  i : Integer;
begin
  Result := IndyMin(ACharCount, AByteCount);
  for i := 1 to Result do begin
    // replace illegal characters > $FF
    if Word(AChars^) > $00FF then begin
      ABytes^ := Byte(Ord('?'));
    end else begin
      ABytes^ := Byte(AChars^);
    end;
    //advance to next char
    Inc(AChars);
    Inc(ABytes);
  end;
end;

function TId8BitEncoding.GetCharCount(ABytes: PByte; AByteCount: Integer): Integer;
begin
  Result := AByteCount;
end;

function TId8BitEncoding.GetChars(ABytes: PByte; AByteCount: Integer;
  AChars: PIdWideChar; ACharCount: Integer): Integer;
var
  i : Integer;
begin
  Result := IndyMin(ACharCount, AByteCount);
  for i := 1 to Result do begin
    Word(AChars^) := ABytes^;
    //advance to next char
    Inc(AChars);
    Inc(ABytes);
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

function TId8BitEncoding.GetPreamble: TIdBytes;
begin
  SetLength(Result, 0);
end;

function Indy8BitEncoding(const AOwnedByIndy: Boolean = True): TIdTextEncoding;
var
  LEncoding: TIdTextEncoding;
begin
  if not AOwnedByIndy then begin
    LEncoding := TId8BitEncoding.Create;
  end else
  begin
    if GId8BitEncoding = nil then begin
      LEncoding := TId8BitEncoding.Create;
      if InterlockedCompareExchangePtr(Pointer(GId8BitEncoding), LEncoding, nil) <> nil then begin
        LEncoding.Free;
      end;
    end;
    LEncoding := GId8BitEncoding;
  end;
  Result := LEncoding;
end;

// TODO: implement a custom TIdUTF8Encoding class so we don't have to
// deal with codepage issues...

function IndyUTF8Encoding(const AOwnedByIndy: Boolean = True): TIdTextEncoding;
var
  LEncoding: TIdTextEncoding;

  function CreateUTF8Encoding: TIdTextEncoding;
  begin
    {$IFDEF USE_ICONV}
    Result := TIdMBCSEncoding.Create('UTF-8');
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    // RLebeau: SysUtils.TUTF8Encoding uses the MB_ERR_INVALID_CHARS
    // flag by default, which we do not want to use, so calling the
    // overloaded constructor that lets us override that behavior...
    Result := TIdUTF8Encoding.Create(CP_UTF8, 0, 0);
      {$ELSE}
    ToDo('IndyUTF8Encoding() is not implemented for this platform yet'); {do not localize}
      {$ENDIF}
    {$ENDIF}
  end;

begin
  if not AOwnedByIndy then begin
    LEncoding := CreateUTF8Encoding;
  end else
  begin
    if GIdUTF8Encoding = nil then begin
      LEncoding := CreateUTF8Encoding;
      if InterlockedCompareExchangePtr(Pointer(GIdUTF8Encoding), LEncoding, nil) <> nil then begin
        LEncoding.Free;
      end;
    end;
    LEncoding := GIdUTF8Encoding;
  end;
  Result := LEncoding;
end;

{$ENDIF}

{$IFDEF UNIX}
function HackLoadFileName(const ALibName, ALibVer : String) : string;  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
 {$IFDEF DARWIN}
  Result := ALibName+ALibVer+LIBEXT;
 {$ELSE}
  Result := ALibName+LIBEXT+ALibVer;
 {$ENDIF}
end;

function HackLoad(const ALibName : String; const ALibVersions : array of String) : HMODULE;
var
  i : Integer;
begin
  Result := NilHandle;
  for i := Low(ALibVersions) to High(ALibVersions) do
  begin
    {$IFDEF USE_SAFELOADLIBRARY}
    Result := SafeLoadLibrary(HackLoadFileName(ALibName,ALibVersions[i]));
    {$ELSE}
      {$IFDEF KYLIXCOMPAT}
    // Workaround that is required under Linux (changed RTLD_GLOBAL with RTLD_LAZY Note: also work with LoadLibrary())
    Result := HMODULE(dlopen(PAnsiChar(HackLoadFileName(ALibName,ALibVersions[i])), RTLD_LAZY));
      {$ELSE}
    Result := LoadLibrary(HackLoadFileName(ALibName,ALibVersions[i]));
      {$ENDIF}
    {$ENDIF}
    {$IFDEF USE_INVALIDATE_MOD_CACHE}
    InvalidateModuleCache;
    {$ENDIF}
    if Result <> NilHandle then begin
      break;
    end;
  end;
end;
{$ENDIF}

procedure IndyRaiseLastError;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFNDEF VCL_6_OR_ABOVE}
  RaiseLastWin32Error;
  {$ELSE}
  RaiseLastOSError;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
function InterlockedExchangeTHandle(var VTarget: THandle; const AValue: PtrUInt): THandle;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TInterlocked}
  Result := TInterlocked.Exchange(LongInt(VTarget), AValue);
  {$ELSE}
    {$IFDEF THANDLE_32}
  Result := InterlockedExchange(LongInt(VTarget), AValue);
    {$ENDIF}
    {$IFDEF THANDLE_64}
  Result := InterlockedExchange64(Int64(VTarget), AValue);
    {$ENDIF}
  {$ENDIF}
end;

function InterlockedCompareExchangePtr(var VTarget: Pointer; const AValue, Compare: Pointer): Pointer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF HAS_TInterlocked}
  Result := TInterlocked.CompareExchange(VTarget, AValue, Compare);
  {$ELSE}
    {$IFDEF FPC}
    //FreePascal 2.2.0 has an overload for InterlockedCompareExchange that takes
    // pointers.
    //TODO: Figure out what to do about FreePascal 2.0.x but that might not be
    //as important as older versions since you download and install FPC for free.
      {$IFDEF CPU64}
  Result := Pointer(InterlockedCompareExchange64(PtrInt(VTarget), PtrInt(AValue), PtrInt(Compare)));
      {$ELSE}
  Result := Pointer(InterlockedCompareExchange(PtrInt(VTarget), PtrInt(AValue), PtrInt(Compare)));
      {$ENDIF}
    {$ELSE}
      {$IFDEF VCL_2009_OR_ABOVE}
  Result := InterlockedCompareExchangePointer(VTarget, AValue, Compare);
      {$ELSE}
        {$IFDEF VCL_2005_OR_ABOVE}
  Result := Pointer(InterlockedCompareExchange(Longint(VTarget), Longint(AValue), Longint(Compare)));
        {$ELSE}
  Result := InterlockedCompareExchange(VTarget, AValue, Compare);
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;
{$ENDIF}

{Little Endian Byte order functions from:

From: http://community.borland.com/article/0,1410,16854,00.html


Big-endian and little-endian formated integers - by Borland Developer Support Staff

Note that I will NOT do big Endian functions because the stacks can handle that
with HostToNetwork and NetworkToHost functions.

You should use these functions for writing data that sent and received in Little
Endian Form.  Do NOT assume endianness of what's written.  It can work in unpredictable
ways on other architectures.
}
function HostToLittleEndian(const AValue : Word) : Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little Endian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := swap(AValue);
    {$ENDIF}
  {$ENDIF}
end;

function HostToLittleEndian(const AValue : LongWord) : LongWord;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little Endian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := swap(AValue shr 16) or (Longint(swap(AValue and $FFFF)) shl 16);
    {$ENDIF}
  {$ENDIF}
end;

function HostToLittleEndian(const AValue : Integer) : Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little Endian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := swap(AValue);
    {$ENDIF}
  {$ENDIF}
end;

function LittleEndianToHost(const AValue : Word) : Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little Endian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := swap(AValue);
    {$ENDIF}
  {$ENDIF}
end;

function LittleEndianToHost(const AValue : Longword): Longword;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little ENdian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := swap(AValue shr 16) or (Longint(swap(AValue and $FFFF)) shl 16);
    {$ENDIF}
  {$ENDIF}
end;

function LittleEndianToHost(const AValue : Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  //I think that is Little ENdian but I'm not completely sure
  Result := AValue;
  {$ELSE}
    {$IFDEF ENDIAN_LITTLE}
  Result := AValue;
    {$ENDIF}
    {$IFDEF ENDIAN_BIG}
  Result := Swap(AValue);
    {$ENDIF}
  {$ENDIF}
end;

// TODO: add an AIndex parameter
procedure FillBytes(var VBytes : TIdBytes; const ACount : Integer; const AValue : Byte);
{$IFDEF STRING_IS_ANSI}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  I: Integer;
{$ENDIF}
begin
  // RLebeau: FillChar() is bad to use on Delphi/C++Builder 2009+ for filling
  // byte buffers as it is actually designed for filling character buffers
  // instead. Now that Char maps to WideChar, this causes problems for FillChar().
  {$IFDEF STRING_IS_UNICODE}
  //System.&Array.Clear(VBytes, 0, ACount);
  // TODO: optimize this
  for I := 0 to ACount-1 do begin
    VBytes[I] := AValue;
  end;
  {$ELSE}
  FillChar(VBytes[0], ACount, AValue);
  {$ENDIF}
end;

constructor TIdFileCreateStream.Create(const AFile : String);
begin
  inherited Create(AFile, fmCreate);
end;

constructor TIdAppendFileStream.Create(const AFile : String);
var
  LFlags: Word;
begin
  if FileExists(AFile) then begin
    LFlags := fmOpenReadWrite or fmShareDenyWrite;
  end else begin
    LFlags := fmCreate;
  end;
  inherited Create(AFile, LFlags);
  if LFlags <> fmCreate then begin
    TIdStreamHelper.Seek(Self, 0, soEnd);
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
  LS: string;
begin
  Result := False;
  if Length(ABytes) > 4 then
  begin
    if (ABytes[2] = cDash) and (ABytes[3] = cDash) then
    begin
      SetLength(LS, 2);
      LS[1] := Char(ABytes[2]);
      LS[2] := Char(ABytes[3]);
      if PosInStrArray(LS, ['bl','bq','dq','lq','mq','ra','wq','zq'], False) > -1 then begin {do not localize}
        Result := True;
      end;
    end;
  end;
end;

function PosInSmallIntArray(const ASearchInt: SmallInt; const AArray: array of SmallInt): Integer;
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
begin
  SetLength(Result, 2);
  Result[1] := IdHexDigits[(AByte and $F0) shr 4];
  Result[2] := IdHexDigits[AByte and $F];
end;

function LongWordToHex(const ALongWord : LongWord) : String;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ByteToHex((ALongWord and $FF000000) shr 24)
            + ByteToHex((ALongWord and $00FF0000) shr 16)
            + ByteToHex((ALongWord and $0000FF00) shr 8)
            + ByteToHex(ALongWord and $000000FF);
end;

function ToHex(const AValue: TIdBytes; const ACount: Integer = -1;
  const AIndex: Integer = 0): string;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I, LCount: Integer;
begin
  LCount := IndyLength(AValue, ACount, AIndex);
  if LCount > 0 then begin
    SetLength(Result, LCount*2);
    for I := 0 to LCount-1 do begin
      Result[I*2+1] := IdHexDigits[(AValue[AIndex+I] and $F0) shr 4];
      Result[I*2+2] := IdHexDigits[AValue[AIndex+I] and $F];
    end;
  end else begin
    Result := '';
  end;
end;

function ToHex(const AValue: array of LongWord): string;
var
{$IFNDEF DOTNET}
  P: PByteArray;
{$ENDIF}
  i: Integer;
begin
  Result := '';
  if Length(AValue) > 0 then
  begin
    {$IFNDEF DOTNET}
    P := PByteArray(@AValue[0]);
    SetString(Result, nil, Length(AValue)*4*2);//40
    for i := 0 to Length(AValue)*4-1 do begin
      Result[i*2+1] := IdHexDigits[(P^[i] and $F0) shr 4];
      Result[i*2+2] := IdHexDigits[P^[i] and $F];
    end;//for
    {$ELSE}
    for i := 0 to Length(AValue)-1 do begin
      Result := Result + ToHex(ToBytes(AValue[i]));
    end;
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

{$IFNDEF DOTNET}
function OctalToInt64(const AValue: string): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AValue) do begin
    Result := (Result shl 3) +  IndyStrToInt(AValue[i], 0);
  end;
end;
{$ENDIF}

function ByteToOctal(const AByte: Byte): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, 3);
  Result[1] := IdOctalDigits[(AByte shr 6) and $7];
  Result[2] := IdOctalDigits[(AByte shr 3) and $7];
  Result[3] := IdOctalDigits[AByte and $7];
  if Result[1] <> '0' then begin
    Result := '0' + Result;
  end;
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
  {$IFDEF DOTNET}
  System.array.Copy(ASource, ASourceIndex, VDest, ADestIndex, ALength);
  {$ELSE}
  //if these asserts fail, then it indicates an attempted buffer overrun.
  Assert(ASourceIndex >= 0);
  Assert((ASourceIndex+ALength) <= Length(ASource));
  Move(ASource[ASourceIndex], VDest[ADestIndex], ALength);
  {$ENDIF}
end;

procedure CopyTIdChar(const ASource: Char; var VDest: TIdBytes; const ADestIndex: Integer;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
var
  LChars: {$IFDEF DOTNET}array[0..0] of Char{$ELSE}TIdWideChars{$ENDIF};
begin
  EnsureEncoding(ADestEncoding);
  {$IFDEF STRING_IS_UNICODE}
    {$IFNDEF DOTNET}
  SetLength(LChars, 1);
    {$ENDIF}
  LChars[0] := ASource;
  ADestEncoding.GetBytes(LChars, 0, 1, VDest, ADestIndex);
  {$ELSE}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LChars := ASrcEncoding.GetChars(RawToBytes(ASource, 1));
  ADestEncoding.GetBytes(LChars, 0, Length(LChars), VDest, ADestIndex);
  {$ENDIF}
end;

procedure CopyTIdShort(const ASource: Short; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  LShort : TIdBytes;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LShort := System.BitConverter.GetBytes(ASource);
  System.array.Copy(LShort, 0, VDest, ADestIndex, SizeOf(Short));
  {$ELSE}
  PSmallInt(@VDest[ADestIndex])^ := ASource;
  {$ENDIF}
end;

procedure CopyTIdWord(const ASource: Word; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  LWord : TIdBytes;
{$ELSE}
 {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LWord := System.BitConverter.GetBytes(ASource);
  System.array.Copy(LWord, 0, VDest, ADestIndex, SizeOf(Word));
  {$ELSE}
  PWord(@VDest[ADestIndex])^ := ASource;
  {$ENDIF}
end;

procedure CopyTIdLongWord(const ASource: LongWord; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  LWord : TIdBytes;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LWord := System.BitConverter.GetBytes(ASource);
  System.array.Copy(LWord, 0, VDest, ADestIndex, SizeOf(LongWord));
  {$ELSE}
  PLongWord(@VDest[ADestIndex])^ := ASource;
  {$ENDIF}
end;

procedure CopyTIdLongInt(const ASource: LongInt; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  LInt : TIdBytes;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LInt := System.BitConverter.GetBytes(ASource);
  System.array.Copy(LInt, 0, VDest, ADestIndex, SizeOf(LongInt));
  {$ELSE}
  PLongInt(@VDest[ADestIndex])^ := ASource;
  {$ENDIF}
end;

procedure CopyTIdInt64(const ASource: Int64; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  LWord : TIdBytes;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LWord := System.BitConverter.GetBytes(ASource);
  System.array.Copy(LWord, 0, VDest, ADestIndex, SizeOf(Int64));
  {$ELSE}
  PInt64(@VDest[ADestIndex])^ := ASource;
  {$ENDIF}
end;

procedure CopyTIdIPV6Address(const ASource: TIdIPv6Address; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF DOTNET}
var
  i : Integer;
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  for i := 0 to 7 do begin
    CopyTIdWord(ASource[i], VDest, ADestIndex + (i * 2));
  end;
  {$ELSE}
  Move(ASource, VDest[ADestIndex], 16);
  {$ENDIF}
end;

procedure CopyTIdByteArray(const ASource: array of Byte; const ASourceIndex: Integer;
  var VDest: array of Byte; const ADestIndex: Integer; const ALength: Integer);
begin
  {$IFDEF DOTNET}
  System.array.Copy(ASource, ASourceIndex, VDest, ADestIndex, ALength);
  {$ELSE}
  Move(ASource[ASourceIndex], VDest[ADestIndex], ALength);
  {$ENDIF}
end;

procedure CopyTIdString(const ASource: String; var VDest: TIdBytes;
  const ADestIndex: Integer; const ALength: Integer = -1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  CopyTIdString(ASource, 1, VDest, ADestIndex, ALength, ADestEncoding
    {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
    );
end;

procedure CopyTIdString(const ASource: String; const ASourceIndex: Integer;
  var VDest: TIdBytes; const ADestIndex: Integer; const ALength: Integer = -1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ); overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LLength: Integer;
  {$IFDEF STRING_IS_ANSI}
  LTmp: TIdWideChars;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_ANSI}
  LTmp := nil; // keep the compiler happy
  {$ENDIF}
  LLength := IndyLength(ASource, ALength, ASourceIndex);
  if LLength > 0 then begin
    EnsureEncoding(ADestEncoding);
    {$IFDEF STRING_IS_UNICODE}
    ADestEncoding.GetBytes(ASource, ASourceIndex{$IFDEF DOTNET}-1{$ENDIF}, LLength, VDest, ADestIndex);
    {$ELSE}
    EnsureEncoding(ASrcEncoding, encOSDefault);
    LTmp := ASrcEncoding.GetChars(RawToBytes(ASource[ASourceIndex], LLength)); // convert to Unicode
    ADestEncoding.GetBytes(LTmp, 0, Length(LTmp), VDest, ADestIndex);
    {$ENDIF}
  end;
end;

procedure DebugOutput(const AText: string);
{$IFDEF WIN32_OR_WIN64_OR_WINCE}
  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
var
  LTemp: WideString;
  {$ELSE}
    {$IFDEF USE_INLINE}inline;{$ENDIF}
  {$ENDIF}
{$ELSE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  {$IFDEF KYLIX}
  __write(stderr, AText, Length(AText));
  __write(stderr, EOL, Length(EOL));
  {$ENDIF}

  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp := WideString(AText); // explicit convert to Unicode
  OutputDebugString(PWideChar(LTemp));
    {$ELSE}
  OutputDebugString(PChar(AText));
    {$ENDIF}
  {$ENDIF}

  {$IFDEF DOTNET}
  System.Diagnostics.Debug.WriteLine(AText);
  {$ENDIF}
end;

function CurrentThreadId: TIdThreadID;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
{$IFDEF DOTNET}
  {$IFDEF DOTNET_2_OR_ABOVE}
  {
  [Warning] IdGlobal.pas(1416): W1000 Symbol 'GetCurrentThreadId'
  is deprecated: 'AppDomain.GetCurrentThreadId has been deprecated because
  it does not provide a stable Id when managed threads are running on fibers
  (aka lightweight threads). To get a stable identifier for a managed thread,
  use the ManagedThreadId property on Thread.
  http://go.microsoft.com/fwlink/?linkid=14202'
  }
  Result := System.Threading.Thread.CurrentThread.ManagedThreadId;
   // Thread.ManagedThreadId;
  {$ENDIF}
  {$IFDEF DOTNET_1_1}
  // SG: I'm not sure if this return the handle of the dotnet thread or the handle of the application domain itself (or even if there is a difference)
  Result := AppDomain.GetCurrentThreadId;
  // RLebeau
  // TODO: find if there is something like the following instead:
  // System.Diagnostics.Thread.GetCurrentThread.ID
  // System.Threading.Thread.CurrentThread.ID
  {$ENDIF}
{$ELSE}
  // TODO: is GetCurrentThreadId() available on Linux?
  Result := GetCurrentThreadID;
{$ENDIF}
end;

function CurrentProcessId: TIdPID;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF KYLIXCOMPAT}
  Result := getpid;
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
   Result := getpid;
  {$ENDIF}
  {$IFDEF USE_BASEUNIX}
  Result := fpgetpid;
  {$ENDIF}

  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Result := GetCurrentProcessID;
  {$ENDIF}
  {$IFDEF DOTNET}
  Result := System.Diagnostics.Process.GetCurrentProcess.ID;
  {$ENDIF}
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
  {$IFDEF UNIX}
  Result := AThread.ThreadID; // RLebeau: is it right to return an ID where a thread object handle is expected instead?
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Result := AThread.Handle;
  {$ENDIF}
  {$IFDEF DOTNET}
  Result := AThread.Handle;
  {$ENDIF}
end;

function Ticks: LongWord;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
{$IFDEF UNIX}
  {$IFDEF MACOSX}
    {$IFDEF USE_INLINE} inline;{$ENDIF}
  {$ELSE}
var
  tv: timeval;
  {$ENDIF}
{$ENDIF}

{$IFDEF WIN32_OR_WIN64_OR_WINCE}
  {$IFDEF USE_HI_PERF_COUNTER_FOR_TICKS}
var
  nTime, freq: {$IFDEF WINCE}LARGE_INTEGER{$ELSE}Int64{$ENDIF};
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF UNIX}
    {$IFDEF MACOSX}
  //This seems to be available on the Delphi cross-compiler for OS/X
  Result := AbsoluteToNanoseconds(UpTime) div 1000000;
    {$ELSE}
      {$IFDEF USE_BASEUNIX}
  fpgettimeofday(@tv,nil);
      {$ENDIF}
      {$IFDEF KYLIXCOMPAT}
  gettimeofday(tv, nil);
      {$ENDIF}
      {$RANGECHECKS OFF}
  Result := Int64(tv.tv_sec) * 1000 + tv.tv_usec div 1000;
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
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
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
      {$IFDEF WINCE}
  if Windows.QueryPerformanceCounter(@nTime) then begin
    if Windows.QueryPerformanceFrequency(@freq) then begin
      Result := Trunc((nTime.QuadPart / Freq.QuadPart) * 1000) and High(LongWord);
      Exit;
    end;
  end;
      {$ELSE}
  if Windows.QueryPerformanceCounter(nTime) then begin
    if Windows.QueryPerformanceFrequency(freq) then begin
      Result := Trunc((nTime / Freq) * 1000) and High(LongWord);
      Exit;
    end;
  end;
      {$ENDIF}
    {$ENDIF}
  Result := Windows.GetTickCount;
  {$ENDIF}
  {$IFDEF DOTNET}
  // Must cast to a cardinal
  //
  // http://lists.ximian.com/archives/public/mono-bugs/2003-November/009293.html
  // Other references in Google.
  // Bug in .NET. It acts like Win32, not as per .NET docs but goes negative after 25 days.
  //
  // There may be a problem in the future if .NET changes this to work as docced with 25 days.
  // Will need to check our routines then and somehow counteract / detect this.
  // One possibility is that we could just wrap it ourselves in this routine.
  Result := LongWord(Environment.TickCount);
  {$ENDIF}
end;

function GetTickDiff(const AOldTickCount, ANewTickCount: LongWord): LongWord;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {This is just in case the TickCount rolled back to zero}
  if ANewTickCount >= AOldTickCount then begin
    Result := ANewTickCount - AOldTickCount;
  end else begin
    Result := High(LongWord) - AOldTickCount + ANewTickCount;
  end;
end;

{$IFNDEF DOTNET}
function ServicesFilePath: string;
var
  {$IFDEF MSWINDOWS}
  sLocation: {$IFDEF UNICODE_BUT_STRING_IS_ANSI}WideString{$ELSE}string{$ENDIF};
  {$ELSE}
  sLocation: string;
  {$ENDIF}
begin
  {$IFDEF UNIX}
  sLocation := '/etc/';  // assume Berkeley standard placement   {do not localize}
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  SetLength(sLocation, MAX_PATH);
  SetLength(sLocation, GetWindowsDirectory(PChar(sLocation), MAX_PATH));
  sLocation := IndyIncludeTrailingPathDelimiter(sLocation);
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    sLocation := sLocation + 'system32\drivers\etc\'; {do not localize}
  end;
  {$ENDIF}

  Result := sLocation + 'services'; {do not localize}
end;
{$ENDIF}


{$IFNDEF DOTNET}
// IdPorts returns a list of defined ports in /etc/services
function IdPorts: TList;
var
  s: string;
  {$IFDEF BYTE_COMPARE_SETS}
  idx, i, iPrev, iPosSlash: Byte;
  {$ELSE}
  idx, i, iPrev, iPosSlash: Integer;
  {$ENDIF}
  sl: TStringList;
begin
  if GIdPorts = nil then
  begin
    GIdPorts := TList.Create;
    sl := TStringList.Create;
    try
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
            GIdPorts.Add(TObject(i));
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
{$ENDIF}

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

function iif(const AEncoding, ADefEncoding: TIdTextEncoding; ADefEncodingType: IdAnsiEncodingType = encASCII): TIdTextEncoding;
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
  {$IFDEF DOTNET}
  Result := System.Threading.Thread.CurrentThread = MainThread;
  {$ELSE}
  Result := GetCurrentThreadID = MainThreadID;
  {$ENDIF}
end;

procedure WriteMemoryStreamToStream(Src: TMemoryStream; Dest: TStream; Count: TIdStreamSize);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Dest.Write(Src.Memory, Count);
  {$ELSE}
  Dest.Write(Src.Memory^, Count);
  {$ENDIF}
end;

{$IFNDEF DOTNET_EXCLUDE}
function IsCurrentThread(AThread: TThread): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AThread.ThreadID = GetCurrentThreadID;
end;
{$ENDIF}

//convert a dword into an IPv4 address in dotted form
function MakeDWordIntoIPv4Address(const ADWord: LongWord): string;
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
  Result := IsNumeric(AChar)
   or ((AChar >= 'A') and (AChar <= 'F')) {Do not Localize}
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

{$HINTS OFF}
function IsNumeric(const AString: string): Boolean;
var
  LCode: Integer;
  LVoid: Int64;
begin
  Val(AString, LVoid, LCode);
  Result := LCode = 0;
end;
{$HINTS ON}

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
  // TODO: under D2009+, use TCharacter.IsDigit() instead

  // Do not use IsCharAlpha or IsCharAlphaNumeric - they are Win32 routines
  Result := (AChar >= '0') and (AChar <= '9'); {Do not Localize}
end;

{
This is an adaptation of the StrToInt64 routine in SysUtils.
We had to adapt it to work with Int64 because the one with Integers
can not deal with anything greater than MaxInt and IP addresses are
always $0-$FFFFFFFF (unsigned)
}
{$IFNDEF VCL_2007_OR_ABOVE}
function StrToInt64Def(const S: string; Default: Integer): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then begin
    Result := Default;
  end;
end;
{$ENDIF}

function IPv4MakeLongWordInRange(const AInt: Int64; const A256Power: Integer): LongWord;
{$IFDEF USE_INLINE}inline;{$ENDIF}
//Note that this function is only for stripping off some extra bits
//from an address that might appear in some spam E-Mails.
begin
  case A256Power of
    4: Result := (AInt and POWER_4);
    3: Result := (AInt and POWER_3);
    2: Result := (AInt and POWER_2);
  else
  {$IFDEF FPC}
    Result := Lo(AInt and POWER_1);
  {$ELSE}
    Result := AInt and POWER_1;
  {$ENDIF}
  end;
end;

function IPv4ToDWord(const AIPAddress: string): LongWord; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
begin
  Result := IPv4ToDWord(AIPAddress, LErr);
end;

function IPv4ToDWord(const AIPAddress: string; var VErr: Boolean): LongWord; overload;
var
{$IFDEF DOTNET}
  AIPaddr: IPAddress;
{$ELSE}
  LBuf, LBuf2: string;
  L256Power: Integer;
  LParts: Integer; //how many parts should we process at a time
{$ENDIF}
begin
  VErr := True;
  Result := 0;
{$IFDEF DOTNET}
  AIPaddr := System.Net.IPAddress.Parse(AIPAddress);
  try
    try
      if AIPaddr.AddressFamily = Addressfamily.InterNetwork then begin
        {$IFDEF DOTNET_2_OR_ABOVE}
        //This looks funny but it's just to circvument a warning about
        //a depreciated property in AIPaddr.  We can safely assume
        //this is an IPv4 address.
        Result := BytesToLongWord( AIPAddr.GetAddressBytes,0);
        {$ENDIF}
        {$IFDEF DOTNET_1_1}
        Result := AIPaddr.Address;
        {$ENDIF}
        VErr := False;
      end;
    except
      VErr := True;
    end;
  finally
    FreeAndNil(AIPaddr);
  end;
{$ELSE}
  // S.G. 11/8/2003: Added overflow checking disabling and change multiplys by SHLs.
  // Locally disable overflow checking so we can safely use SHL and SHR
  {$IFOPT Q+} // detect overflow checking
  {$DEFINE _QPlusWasEnabled}
  {$Q-}
  {$ENDIF}
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
      Result := Result + IPv4MakeLongWordInRange(StrToInt64Def(LBuf, 0), LParts);
    end else begin
      if not IsNumeric(LBuf) then begin
        //There was an error meaning an invalid IP address
        Exit;
      end;
      if TextStartsWith(LBuf, '0') and IsOctal(LBuf) then begin {do not localize}
        //this is octal
        Result := Result + IPv4MakeLongWordInRange(OctalToInt64(LBuf), LParts);
      end else begin
        //this must be a decimal
        Result :=  Result + IPv4MakeLongWordInRange(StrToInt64Def(LBuf, 0), LParts);
      end;
    end;
    Dec(L256Power);
  until False;
  VErr := False;
  // Restore overflow checking
  {$IFDEF _QPlusWasEnabled} // detect previous setting
  {$UNDEF _QPlusWasEnabled}
  {$Q+}
  {$ENDIF}
{$ENDIF}
end;

function IPv6AddressToStr(const AValue: TIdIPv6Address): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 7 do begin
    Result := Result + ':' + IntToHex(AValue[i], 4);
  end;
end;

function MakeCanonicalIPv4Address(const AAddr: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
  LIP: LongWord;
begin
  LIP := IPv4ToDWord(AAddr, LErr);
  if LErr then begin
    Result := '';
  end else begin
    Result := MakeDWordIntoIPv4Address(LIP);
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
  if Length(LAddr) = 0 then begin
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
        Dec(fillzeros, 2);
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

function IndyMax(const AValueOne, AValueTwo: LongInt): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function IndyMax(const AValueOne, AValueTwo: Word): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

{$IFNDEF DOTNET}
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
{$ENDIF}

function IndyMin(const AValueOne, AValueTwo: LongInt): LongInt;
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

function IndyMin(const AValueOne, AValueTwo: Word): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function PosIdx(const ASubStr, AStr: string; AStartPos: LongWord): LongWord;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
  // use best register allocation on Win32
  function FindStr(ALStartPos, EndPos: LongWord; StartChar: Char; const ALStr: string): LongWord;
  begin
    for Result := ALStartPos to EndPos do begin
      if ALStr[Result] = StartChar then begin
        Exit;
      end;
    end;
    Result := 0;
  end;

  // use best register allocation on Win32
  function FindNextStr(ALStartPos, EndPos: LongWord; const ALStr, ALSubStr: string): LongWord;
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
  LenSubStr, LenStr: LongWord;
  EndPos: LongWord;
{$ENDIF}
begin
  if AStartPos = 0 then begin
    AStartPos := 1;
  end;
  {$IFDEF DOTNET}
  Result := AStr.IndexOf(ASubStr, AStartPos-1) + 1;
  {$ELSE}
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
  {$ENDIF}
end;

function SBPos(const Substr, S: string): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // Necessary because of "Compiler magic"
  Result := Pos(Substr, S);
end;

{$IFNDEF DOTNET}
function SBStrScan(Str: PChar; Chr: Char): PChar;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.StrScan(Str, Chr);
end;
{$ENDIF}

{$IFNDEF DOTNET}
//Don't rename this back to AnsiPos because that conceals a symbol in Windows
function InternalAnsiPos(const Substr, S: string): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.AnsiPos(Substr, S);
end;

function InternalAnsiStrScan(Str: PChar; Chr: Char): PChar;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.AnsiStrScan(Str, Chr);
end;
{$ENDIF}

procedure IndySetThreadPriority(AThread: TThread; const APriority: TIdThreadPriority;
  const APolicy: Integer = -MaxInt);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF UNIX}
    {$IFDEF KYLIXCOMPAT}
      {$IFDEF INT_THREAD_PRIORITY}
        // Linux only allows root to adjust thread priorities, so we just ignore this call in Linux?
        // actually, why not allow it if root
        // and also allow setting *down* threadpriority (anyone can do that)
        // note that priority is called "niceness" and positive is lower priority
   if (getpriority(PRIO_PROCESS, 0) < APriority) or (geteuid = 0) then begin
     setpriority(PRIO_PROCESS, 0, APriority);
   end;
      {$ELSE}
   AThread.Priority := APriority;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
      // Linux only allows root to adjust thread priorities, so we just ingnore this call in Linux?
      // actually, why not allow it if root
      // and also allow setting *down* threadpriority (anyone can do that)
      // note that priority is called "niceness" and positive is lower priority
  if (fpgetpriority(PRIO_PROCESS, 0) < cint(APriority)) or (fpgeteuid = 0) then begin
    fpsetpriority(PRIO_PROCESS, 0, cint(APriority));
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  AThread.Priority := APriority;
  {$ENDIF}
  {$IFDEF DOTNET}
  AThread.Priority := APriority;
  {$ENDIF}
end;

procedure IndySleep(ATime: LongWord);
{$IFDEF USE_VCL_POSIX}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LTime: TimeVal;
{$ELSE}
  {$IFNDEF UNIX}
    {$IFDEF USE_INLINE}inline;{$ENDIF}
  {$ELSE}
var
  LTime: TTimeVal;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF UNIX}
    // *nix: Is there are reason for not using nanosleep?

    // what if the user just calls sleep? without doing anything...
    // cannot use GStack.WSSelectRead(nil, ATime)
    // since no readsocketlist exists to get the fdset
  LTime.tv_sec := ATime div 1000;
  LTime.tv_usec := (ATime mod 1000) * 1000;
    {$IFDEF USE_VCL_POSIX}
  select( 0, nil, nil, nil, @LTime);
    {$ENDIF}
    {$IFDEF KYLIXCOMPAT}
  Libc.Select(0, nil, nil, nil, @LTime);
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
  fpSelect(0, nil, nil, nil, @LTime);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  Windows.Sleep(ATime);
  {$ENDIF}
  {$IFDEF DOTNET}
  Thread.Sleep(ATime);
  {$ENDIF}
end;

procedure SplitColumnsNoTrim(const AData: string; AStrings: TStrings; const ADelim: string);
var
  i: Integer;
  LDelim: Integer; //delim len
  LLeft: string;
  {$IFDEF DOTNET}
  LLastPos: Integer;
  {$ELSE}
  LLastPos: PtrInt;
  //note that we use PtrInt instead of Integer because in FPC,
  //you can't assume a pointer will be exactly 4 bytes.  It could be 8 or possibly
  //2 bytes.  Remember that that supports operating systems with versions for different
  //architectures
  {$ENDIF}
begin
  Assert(Assigned(AStrings));
  AStrings.Clear;
  LDelim := Length(ADelim);
  LLastPos := 1;

  i := Pos(ADelim, AData);
  while I > 0 do begin
    LLeft := Copy(AData, LLastPos, I - LLastPos); //'abc d' len:=i(=4)-1    {Do not Localize}
    if LLeft <> '' then begin    {Do not Localize}
      {$IFDEF DOTNET}
      AStrings.AddObject(LLeft, TObject(LLastPos));
      {$ELSE}
      AStrings.AddObject(LLeft, TObject(PtrInt(LLastPos)));
      {$ENDIF}
    end;
    LLastPos := I + LDelim; //first char after Delim
    i := PosIdx(ADelim, AData, LLastPos);
  end;
  if LLastPos <= Length(AData) then begin
    {$IFDEF DOTNET}
    AStrings.AddObject(Copy(AData, LLastPos, MaxInt), TObject(LLastPos));
    {$ELSE}
    AStrings.AddObject(Copy(AData, LLastPos, MaxInt), TObject(PtrInt(LLastPos)));
    {$ENDIF}
  end;
end;

{$IFDEF DOTNET}
procedure SetThreadName(const AName: string; AThread: System.Threading.Thread = nil);
begin
  if AThread = nil then begin
    AThread := System.Threading.Thread.CurrentThread;
  end;
  // cannot rename a previously-named thread
  if AThread.Name = nil then begin
    AThread.Name := AName;
  end;
end;
{$ELSE}
procedure SetThreadName(const AName: string; AThreadID: LongWord = $FFFFFFFF);
  {$IFDEF HAS_NAMED_THREADS}
    {$IFDEF HAS_TThread_NameThreadForDebugging}
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
const
  MS_VC_EXCEPTION = $406D1388;
type
  TThreadNameInfo = record
    RecType: LongWord;  // Must be 0x1000
    Name: PAnsiChar;    // Pointer to name (in user address space)
    ThreadID: LongWord; // Thread ID (-1 indicates caller thread)
    Flags: LongWord;    // Reserved for future use. Must be zero
  end;
var
  LThreadNameInfo: TThreadNameInfo;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
begin
  {$IFDEF HAS_NAMED_THREADS}
    {$IFDEF HAS_TThread_NameThreadForDebugging}
  TThread.NameThreadForDebugging(AnsiString(AName), AThreadID);
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  with LThreadNameInfo do begin
    RecType := $1000;
    Name := {$IFDEF STRING_IS_UNICODE}PAnsiChar(AnsiString(AName)){$ELSE}PChar(AName){$ENDIF};
    ThreadID := AThreadID;
    Flags := 0;
  end;
  try
    // This is a wierdo Windows way to pass the info in
    RaiseException(MS_VC_EXCEPTION, 0, SizeOf(LThreadNameInfo) div SizeOf(LongWord),
      PDWord(@LThreadNameInfo));
  except
  end;
      {$ENDIF}
    {$ENDIF}
  {$ELSE}
  // Do nothing. No support in this compiler for it.
  {$ENDIF}
end;
{$ENDIF}

procedure SplitColumns(const AData: string; AStrings: TStrings; const ADelim: string);
var
  i: Integer;
  LData: string;
  LDelim: Integer; //delim len
  LLeft: string;
  LLastPos: Integer;
  LLeadingSpaceCnt: Integer;
Begin
  Assert(Assigned(AStrings));
  AStrings.Clear;
  LDelim := Length(ADelim);
  LLastPos := 1;
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
      AStrings.AddObject(Trim(LLeft), TObject(LLastPos + LLeadingSpaceCnt));
    end;
    LLastPos := I + LDelim; //first char after Delim
    i := PosIdx(ADelim, LData, LLastPos);
  end;//while found
  if LLastPos <= Length(LData) then begin
    AStrings.AddObject(Trim(Copy(LData, LLastPos, MaxInt)), TObject(LLastPos + LLeadingSpaceCnt));
  end;
end;

{$IFDEF DOTNET}
  {$IFNDEF DOTNET_2_OR_ABOVE}

{ TEvent }

constructor TEvent.Create(EventAttributes: IntPtr; ManualReset, InitialState: Boolean; const Name: string);
begin
  inherited Create;
  // Name not used
  if ManualReset then begin
    FEvent := ManualResetEvent.Create(InitialState);
  end else begin
    FEvent := AutoResetEvent.Create(InitialState);
  end;
end;

constructor TEvent.Create;
begin
  Create(nil, True, False, '');    {Do not Localize}
end;

destructor TEvent.Destroy;
begin
  if Assigned(FEvent) then begin
    FEvent.Close;
  end;
  FreeAndNil(FEvent);
  inherited Destroy;
end;

procedure TEvent.SetEvent;
begin
  if FEvent is ManualResetEvent then begin
    ManualResetEvent(FEvent).&Set;
  end else begin
    AutoResetEvent(FEvent).&Set;
  end;
end;

procedure TEvent.ResetEvent;
begin
  if FEvent is ManualResetEvent then begin
    ManualResetEvent(FEvent).Reset;
  end else begin
    AutoResetEvent(FEvent).Reset;
  end;
end;

function TEvent.WaitFor(Timeout: LongWord): TWaitResult;
var
  Passed: Boolean;
begin
  try
    if Timeout = INFINITE then begin
      Passed := FEvent.WaitOne;
    end else begin
      Passed := FEvent.WaitOne(Timeout, True);
    end;
    if Passed then begin
      Result := wrSignaled;
    end else begin
      Result := wrTimeout;
    end;
  except
    Result := wrError;
  end;
end;

{ TCriticalSection }

procedure TCriticalSection.Acquire;
begin
  Enter;
end;

procedure TCriticalSection.Release;
begin
  Leave;
end;

function TCriticalSection.TryEnter: Boolean;
begin
  Result := System.Threading.Monitor.TryEnter(Self);
end;

procedure TCriticalSection.Enter;
begin
  System.Threading.Monitor.Enter(Self);
end;

procedure TCriticalSection.Leave;
begin
  System.Threading.Monitor.Exit(Self);
end;
   {$ENDIF}
{$ENDIF}

{ TIdLocalEvent }

constructor TIdLocalEvent.Create(const AInitialState: Boolean = False; const AManualReset: Boolean = False);
begin
  inherited Create(nil, AManualReset, AInitialState, '');    {Do not Localize}
end;

function TIdLocalEvent.WaitForEver: TWaitResult;
begin
  Result := WaitFor(Infinite);
end;

{ TIdList }

{$IFNDEF VCL_6_OR_ABOVE}
procedure TIdExtList.Assign(AList: TList);
var
  I: Integer;
begin
  Clear;
  Capacity := AList.Capacity;
  for I := 0 to AList.Count - 1 do
    Add(AList.Items[I]);
end;
{$ENDIF}

procedure ToDo(const AMsg: string);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  EIdException.Toss(AMsg);
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

function IndyLength(const ABuffer: TStream; const ALength: TIdStreamSize = -1): TIdStreamSize; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: TIdStreamSize;
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

{$IFDEF HAS_TFormatSettings}
//Delphi5 does not have TFormatSettings
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
{$ENDIF}

// RLebeau 10/24/2008: In the RTM release of Delphi/C++Builder 2009, the
// overloaded version of SysUtils.Format() that has a TFormatSettings parameter
// has an internal bug that causes an EConvertError exception when UnicodeString
// parameters greater than 4094 characters are passed to it.  Refer to QC #67934
// for details.  The bug is fixed in 2009 Update 1.  For RTM, call FormatBuf()
// directly to work around the problem...
function IndyFormat(const AFormat: string; const Args: array of const): string;
{$IFNDEF DOTNET}
  {$IFDEF HAS_TFormatSettings}
var
  EnglishFmt: TFormatSettings;
    {$IFDEF BROKEN_FmtStr}
  Len, BufLen: Integer;
  Buffer: array[0..4095] of Char;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  // RLebeau 10/29/09: temporary workaround until we figure out how to use
  // SysUtils.FormatBuf() correctly under .NET in D2009 RTM...
  Result := SysUtils.Format(AFormat, Args);
  {$ELSE}
    {$IFDEF HAS_TFormatSettings}
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
    {$ELSE}
  //Is there a way to get delphi5 to use locale in format? something like:
  //  SetThreadLocale(TheNewLocaleId);
  //  GetFormatSettings;
  //  Application.UpdateFormatSettings := False; //needed?
  //  format()
  //  set locale back to prior
  Result := SysUtils.Format(AFormat, Args);
    {$ENDIF}
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

function DateTimeGMTToCookieStr(const GMTValue: TDateTime) : String;
// Wdy, DD-Mon-YY HH:MM:SS GMT
var
  wDay,
  wMonth,
  wYear: Word;
begin
  DecodeDate(GMTValue, wYear, wMonth, wDay);
  Result := IndyFormat('%s, %.2d-%s-%.2d %s %s',    {do not localize}
                   [wdays[DayOfWeek(GMTValue)], wDay, monthnames[wMonth],
                    wYear, FormatDateTime('HH":"nn":"ss',GMTValue), 'GMT']);  {do not localize}
end;

function LocalDateTimeToHttpStr(const Value: TDateTime) : String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeGMTToHttpStr(Value - OffsetFromUTC);
end;

function LocalDateTimeToCookieStr(const Value: TDateTime) : String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeGMTToCookieStr(Value - OffsetFromUTC);
end;

function DateTimeToInternetStr(const Value: TDateTime; const AUseGMTStr : Boolean = False) : String;
begin
  Result := LocalDateTimeToGMT(Value, AUseGMTStr);
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

function DateTimeToGmtOffSetStr(ADateTime: TDateTime; const AUseGMTStr: Boolean = False): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := UTCOffsetToStr(ADateTime, AUseGMTStr);
end;

function OffsetFromUTC: TDateTime;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
var
  iBias: Integer;
  tmez: TTimeZoneInformation;
  {$ENDIF}
  {$IFDEF UNIX}
    {$IFDEF USE_VCL_POSIX}
var
  T : Time_t;
  TV : TimeVal;
  UT : tm;
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
 var
   timeval: TTimeVal;
   timezone: PTimeZone;
    {$ENDIF}
    {$IFDEF KYLIXCOMPAT}
var
  T: Time_T;
  TV: TTimeVal;
  UT: TUnixTime;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF UNIX}

    {$IFDEF USE_VCL_POSIX}
  {from http://edn.embarcadero.com/article/27890 }

  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result := -1*(UT.tm_gmtoff / 60 / 60 / 24);
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
  fpGetTimeOfDay (@TimeVal, TimeZone);
  Result := -1 * (timezone^.tz_minuteswest /60 / 60 / 24)
    {$ENDIF}
    {$IFDEF KYLIXCOMPAT}
  {from http://edn.embarcadero.com/article/27890 }

  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(@T, UT);
  Result := -1*(UT.__tm_gmtoff / 60 / 60 / 24);
    {$ENDIF}
    // __tm_gmtoff is the bias in seconds from the UTC to the current time.
    // so I multiply by -1 to compensate for this.

  {$ENDIF}
  {$IFDEF DOTNET}
  Result := System.Timezone.CurrentTimezone.GetUTCOffset(DateTime.FromOADate(Now)).TotalDays;
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  case GetTimeZoneInformation({$IFDEF WIN32_OR_WIN64}tmez{$ELSE}@tmez{$ENDIF}) of
    TIME_ZONE_ID_INVALID  :
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    TIME_ZONE_ID_UNKNOWN  :
       iBias := tmez.Bias;
    TIME_ZONE_ID_DAYLIGHT :
      iBias := tmez.Bias + tmez.DaylightBias;
    TIME_ZONE_ID_STANDARD :
      iBias := tmez.Bias + tmez.StandardBias;
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
  {$ENDIF}
end;

function UTCOffsetToStr(const AOffset: TDateTime; const AUseGMTStr: Boolean = False): string;
var
  AHour, AMin, ASec, AMSec: Word;
begin
  if (AOffset = 0.0) and AUseGMTStr then
  begin
    Result := 'GMT'; {do not localize}
  end else
  begin
    DecodeTime(AOffset, AHour, AMin, ASec, AMSec);
    Result := IndyFormat(' %0.2d%0.2d', [AHour, AMin]); {do not localize}
    if AOffset < 0.0 then begin
      Result[1] := '-'; {do not localize}
    end else begin
      Result[1] := '+';  {do not localize}
    end;
  end;
end;

function IndyIncludeTrailingPathDelimiter(const S: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF VCL_6_OR_ABOVE}
  Result := SysUtils.IncludeTrailingPathDelimiter(S);
  {$ELSE}
  Result := SysUtils.IncludeTrailingBackslash(S);
  {$ENDIF}
end;

function IndyExcludeTrailingPathDelimiter(const S: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF VCL_6_OR_ABOVE}
  Result := SysUtils.ExcludeTrailingPathDelimiter(S);
  {$ELSE}
  Result := SysUtils.ExcludeTrailingBackslash(S);
  {$ENDIF}
end;

function StringsReplace(const S: String; const OldPattern, NewPattern: array of string): string;
var
  i : Integer;
begin
  Result := s;
  for i := Low(OldPattern) to High(OldPattern) do begin
    Result := StringReplace(Result, OldPattern[i], NewPattern[i], [rfReplaceAll]);
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
var
  LTM1, LTM2 : TTimeStamp;
begin
  LTM1 := DateTimeToTimeStamp(D1);
  LTM2 := DateTimeToTimeStamp(D2);
  if LTM1.Date = LTM2.Date then begin
    if LTM1.Time < LTM2.Time then begin
      Result := -1;
    end
    else if LTM1.Time > LTM2.Time then begin
      Result := 1;
    end
    else begin
      Result := 0;
    end;
  end
  else if LTM1.Date > LTM2.Date then begin
    Result := 1;
  end
  else begin
    Result := -1;
  end;
end;

function AddMSecToTime(const ADateTime: TDateTime; const AMSec: Integer): TDateTime;
{$IFDEF VCL_6_OR_ABOVE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  LTM : TTimeStamp;
{$ENDIF}
begin
  {$IFDEF VCL_6_OR_ABOVE}
  Result := DateUtils.IncMilliSecond(ADateTime, AMSec);
  {$ELSE}
  LTM := DateTimeToTimeStamp(ADateTime);
  LTM.Time := LTM.Time + AMSec;
  Result := TimeStampToDateTime(LTM);
  {$ENDIF}
end;

function IndyFileAge(const AFileName: string): TDateTime;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
    {$IFDEF VCL_2006_OR_ABOVE}
  //single-parameter fileage is deprecated in d2006 and above
  if not FileAge(AFileName, Result) then begin
    Result := 0;
  end;

    {$ELSE}
  Result := FileDateToDateTime(SysUtils.FileAge(AFileName));
    {$ENDIF}
end;

function IndyDirectoryExists(const ADirectory: string): Boolean;
{$IFDEF VCL_6_OR_ABOVE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  Code: Integer;
  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LWStr: WideString;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF VCL_6_OR_ABOVE}
  Result := SysUtils.DirectoryExists(ADirectory);
  {$ELSE}
  // RLebeau 2/16/2006: Removed dependency on the FileCtrl unit
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LWStr := WideString(ADirectory); // explicit convert to Unicode
  Code := GetFileAttributes(PWideChar(LWStr));
    {$ELSE}
  Code := GetFileAttributes(PChar(ADirectory));
    {$ENDIF}
  Result := (Code <> -1) and ((Code and FILE_ATTRIBUTE_DIRECTORY) <> 0);
  {$ENDIF}
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

function IndyStrToStreamSize(const S: string; const ADefault: TIdStreamSize): TIdStreamSize;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF STREAM_SIZE_64}
  Result := IndyStrToInt64(S, ADefault);
  {$ELSE}
  Result := IndyStrToInt(S, ADefault);
  {$ENDIF}
end;

function IndyStrToStreamSize(const S: string): TIdStreamSize;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF STREAM_SIZE_64}
  Result := IndyStrToInt64(S);
  {$ELSE}
  Result := IndyStrToInt(S);
  {$ENDIF}
end;

function ToBytes(const AValue: string; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ToBytes(AValue, -1, 1, ADestEncoding
    {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
    );
end;

function ToBytes(const AValue: string; const ALength: Integer; const AIndex: Integer = 1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
var
  LLength: Integer;
  {$IFDEF STRING_IS_ANSI}
  LBytes: TIdBytes;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_ANSI}
  LBytes := nil; // keep the compiler happy
  {$ENDIF}
  LLength := IndyLength(AValue, ALength, AIndex);
  if LLength > 0 then
  begin
    EnsureEncoding(ADestEncoding);
    {$IFDEF STRING_IS_UNICODE}
    Result := ADestEncoding.GetBytes(Copy(AValue, AIndex, LLength));
    {$ELSE}
    EnsureEncoding(ASrcEncoding, encOSDefault);
    LBytes := RawToBytes(AValue[AIndex], LLength);
    if ASrcEncoding <> ADestEncoding then begin
      LBytes := TIdTextEncoding.Convert(ASrcEncoding, ADestEncoding, LBytes);
    end;
    Result := LBytes;
    {$ENDIF}
  end else begin
    SetLength(Result, 0);
  end;
end;

function ToBytes(const AValue: Char; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  ): TIdBytes; overload;
var
{$IFDEF STRING_IS_UNICODE}
  LChars: {$IFDEF DOTNET}array[0..0] of Char{$ELSE}TIdWideChars{$ENDIF};
{$ELSE}
  LBytes: TIdBytes;
{$ENDIF}
begin
  EnsureEncoding(ADestEncoding);
  {$IFDEF STRING_IS_UNICODE}
    {$IFNDEF DOTNET}
  SetLength(LChars, 1);
    {$ENDIF}
  LChars[0] := AValue;
  Result := ADestEncoding.GetBytes(LChars);
  {$ELSE}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LBytes := RawToBytes(AValue, 1);
  if ASrcEncoding <> ADestEncoding then begin
    LBytes := TIdTextEncoding.Convert(ASrcEncoding, ADestEncoding, LBytes);
  end;
  Result := LBytes;
  {$ENDIF}
end;

function ToBytes(const AValue: Int64): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.BitConverter.GetBytes(AValue);
  {$ELSE}
  SetLength(Result, SizeOf(Int64));
  PInt64(@Result[0])^ := AValue;
  {$ENDIF}
end;

function ToBytes(const AValue: LongInt): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.BitConverter.GetBytes(AValue);
  {$ELSE}
  SetLength(Result, SizeOf(LongInt));
  PLongInt(@Result[0])^ := AValue;
  {$ENDIF}
end;

function ToBytes(const AValue: LongWord): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.BitConverter.GetBytes(AValue);
  {$ELSE}
  SetLength(Result, SizeOf(LongWord));
  PLongWord(@Result[0])^ := AValue;
  {$ENDIF}
end;

function ToBytes(const AValue: Short): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.BitConverter.GetBytes(AValue);
  {$ELSE}
  SetLength(Result, SizeOf(SmallInt));
  PSmallInt(@Result[0])^ := AValue;
  {$ENDIF}
end;

function ToBytes(const AValue: Word): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.BitConverter.GetBytes(AValue);
  {$ELSE}
  SetLength(Result, SizeOf(Word));
  PWord(@Result[0])^ := AValue;
  {$ENDIF}
end;

function ToBytes(const AValue: Byte): TIdBytes; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, SizeOf(Byte));
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

{$IFNDEF DOTNET}
function RawToBytes(const AValue; const ASize: Integer): TIdBytes;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength(Result, ASize);
  if ASize > 0 then begin
    Move(AValue, Result[0], ASize);
  end;
end;
{$ENDIF}

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Char; ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LChars: {$IFDEF DOTNET}array[0..0] of Char{$ELSE}TIdWideChars{$ENDIF};
begin
  EnsureEncoding(ADestEncoding);
  {$IFDEF STRING_IS_UNICODE}
    {$IFNDEF DOTNET}
  SetLength(LChars, 1);
    {$ENDIF}
  LChars[0] := AValue;
  {$ELSE}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LChars := ASrcEncoding.GetChars(RawToBytes(AValue, 1));  // convert to Unicode
  {$ENDIF}
  Assert(Length(Bytes) >= ADestEncoding.GetByteCount(LChars));
  ADestEncoding.GetBytes(LChars, 0, Length(LChars), Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: LongInt);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdLongInt(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Short);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdShort(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Word);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdWord(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Byte);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  Bytes[0] := AValue;
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: LongWord);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdLongWord(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: Int64);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= SizeOf(AValue));
  CopyTIdInt64(AValue, Bytes, 0);
end;

procedure ToBytesF(var Bytes: TIdBytes; const AValue: TIdBytes; const ASize: Integer; const AIndex: Integer = 0);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= ASize);
  CopyTIdBytes(AValue, AIndex, Bytes, 0, ASize);
end;

{$IFNDEF DOTNET}
procedure RawToBytesF(var Bytes: TIdBytes; const AValue; const ASize: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(Bytes) >= ASize);
  if ASize > 0 then begin
    Move(AValue, Bytes[0], ASize);
  end;
end;
{$ENDIF}

function BytesToChar(const AValue: TIdBytes; const AIndex: Integer = 0;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Char; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  BytesToChar(AValue, Result, AIndex, AByteEncoding);
end;

function BytesToChar(const AValue: TIdBytes; var VChar: Char; const AIndex: Integer = 0;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Integer; overload;
var
  I, NumChars, NumBytes: Integer;
  {$IFDEF DOTNET}
  LChars: array[0..1] of Char;
  {$ELSE}
  LChars: TIdWideChars;
    {$IFDEF STRING_IS_ANSI}
  LWTmp: WideString;
  LATmp: TIdBytes;
    {$ENDIF}
  {$ENDIF}
begin
  Result := 0;
  EnsureEncoding(AByteEncoding);
  // 2 Chars to handle UTF-16 surrogates
  NumBytes := IndyMin(IndyLength(AValue, -1, AIndex), AByteEncoding.GetMaxByteCount(2));
  {$IFNDEF DOTNET}
  SetLength(LChars, 2);
  {$ENDIF}
  NumChars := 0;
  if NumBytes > 0 then
  begin
    for I := 1 to NumBytes do
    begin
      NumChars := AByteEncoding.GetChars(AValue, AIndex, I, LChars, 0);
      Inc(Result);
      if NumChars > 0 then begin
        Break;
      end;
    end;
  end;
  {$IFDEF STRING_IS_UNICODE}
  // RLebeau: if the bytes were decoded into surrogates, the second
  // surrogate is lost here, as it can't be returned unless we cache
  // it somewhere for the the next BytesToChar() call to retreive.  Just
  // raise an error for now.  Users will have to update their code to
  // read surrogates differently...
  Assert(NumChars = 1);
  VChar := LChars[0];
  {$ELSE}
  // RLebeau: since we can only return an AnsiChar here, let's convert
  // the decoded characters, surrogates and all, into their Ansi
  // representation. This will have the same problem as above if the
  // conversion results in a multibyte character sequence...
  EnsureEncoding(ADestEncoding, encOSDefault);
  SetString(LWTmp, PWideChar(LChars), NumChars);
  LATmp := ADestEncoding.GetBytes(LWTmp); // convert to Ansi
  Assert(Length(LATmp) = 1);
  VChar := Char(LATmp[0]);
  {$ENDIF}
end;

function BytesToLongInt(const AValue: TIdBytes; const AIndex: Integer = 0): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(LongInt)));
  {$IFDEF DOTNET}
  Result := System.BitConverter.ToInt32(AValue, AIndex);
  {$ELSE}
  Result := PLongInt(@AValue[AIndex])^;
  {$ENDIF}
end;

function BytesToInt64(const AValue: TIdBytes; const AIndex: Integer = 0): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Int64)));
  {$IFDEF DOTNET}
  Result := System.BitConverter.ToInt64(AValue, AIndex);
  {$ELSE}
  Result := PInt64(@AValue[AIndex])^;
  {$ENDIF}
end;

function BytesToWord(const AValue: TIdBytes; const AIndex: Integer = 0): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Word)));
  {$IFDEF DOTNET}
  Result := System.BitConverter.ToUInt16(AValue, AIndex);
  {$ELSE}
  Result := PWord(@AValue[AIndex])^;
  {$ENDIF}
end;

function BytesToShort(const AValue: TIdBytes; const AIndex: Integer = 0): Short;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(Short)));
  {$IFDEF DOTNET}
  Result := System.BitConverter.ToInt16(AValue, AIndex);
  {$ELSE}
  Result := PSmallInt(@AValue[AIndex])^;
  {$ENDIF}
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
{$IFDEF DOTNET}
var
  I: Integer;
{$ELSE}
{$IFDEF USE_INLINE}inline;{$ENDIF}
{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+16));
  {$IFDEF DOTNET}
  for i := 0 to 7 do begin
    VAddress[i] := TwoByteToWord(AValue[(i*2)+AIndex], AValue[(i*2)+1+AIndex]);
  end;
  {$ELSE}
  Move(AValue[AIndex], VAddress[0], 16);
  {$ENDIF}
end;

function BytesToLongWord(const AValue: TIdBytes; const AIndex: Integer = 0): LongWord;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= (AIndex+SizeOf(LongWord)));
  {$IFDEF DOTNET}
  Result := System.BitConverter.ToUInt32(AValue, AIndex);
  {$ELSE}
  Result := PLongWord(@AValue[AIndex])^;
  {$ENDIF}
end;

function BytesToString(const AValue: TIdBytes; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := BytesToString(AValue, 0, -1, AByteEncoding
    {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
    );
end;

function BytesToString(const AValue: TIdBytes; const AStartIndex: Integer;
  const ALength: Integer = -1; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
var
  LLength: Integer;
  {$IFDEF STRING_IS_ANSI}
  LBytes: TIdBytes;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_ANSI}
  LBytes := nil; // keep the compiler happy
  {$ENDIF}
  LLength := IndyLength(AValue, ALength, AStartIndex);
  if LLength > 0 then begin
    EnsureEncoding(AByteEncoding);
    {$IFDEF STRING_IS_UNICODE}
    Result := AByteEncoding.GetString(AValue, AStartIndex, LLength);
    {$ELSE}
    EnsureEncoding(ADestEncoding);
    LBytes := Copy(AValue, AStartIndex, LLength);
    if AByteEncoding <> ADestEncoding then begin
      LBytes := TIdTextEncoding.Convert(AByteEncoding, ADestEncoding, LBytes);
    end;
    SetString(Result, PAnsiChar(LBytes), Length(LBytes));
    {$ENDIF}
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
    {$IFDEF STRING_IS_UNICODE}
    Result := Indy8BitEncoding.GetString(AValue, AStartIndex, LLength);
    {$ELSE}
    SetString(Result, PAnsiChar(@AValue[AStartIndex]), LLength);
    {$ENDIF}
  end else begin
    Result := '';
  end;
end;

{$IFNDEF DOTNET}
procedure BytesToRaw(const AValue: TIdBytes; var VBuffer; const ASize: Integer);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Assert(Length(AValue) >= ASize);
  Move(AValue[0], VBuffer, ASize);
end;
{$ENDIF}

function TwoByteToWord(AByte1, AByte2: Byte): Word;
//Since Replys are returned as Strings, we need a routine to convert two
// characters which are a 2 byte U Int into a two byte unsigned Integer
var
  LWord: TIdBytes;
begin
  SetLength(LWord, 2);
  LWord[0] := AByte1;
  LWord[1] := AByte2;
  Result := BytesToWord(LWord);
//  Result := Word((AByte1 shl 8) and $FF00) or Word(AByte2 and $00FF);
end;

function ReadStringFromStream(AStream: TStream; ASize: Integer = -1;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LBytes: TIdBytes;
begin
  ASize := TIdStreamHelper.ReadBytes(AStream, LBytes, ASize);
  Result := BytesToString(LBytes, 0, ASize, AByteEncoding
  {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
  );
end;

function ReadTIdBytesFromStream(const AStream: TStream; var ABytes: TIdBytes;
  const Count: TIdStreamSize; const AIndex: Integer = 0): TIdStreamSize;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TIdStreamHelper.ReadBytes(AStream, ABytes, Count, AIndex);
end;

function ReadCharFromStream(AStream: TStream; var VChar: Char;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Integer;
var
  StartPos: TIdStreamSize;
  Lb: Byte;
  NumChars, NumBytes: Integer;
  LBytes: TIdBytes;
  {$IFDEF DOTNET}
  LChars: array[0..1] of Char;
  {$ELSE}
  LChars: TIdWideChars;
    {$IFDEF STRING_IS_ANSI}
  LWTmp: WideString;
  LATmp: TIdBytes;
    {$ENDIF}
  {$ENDIF}

  function ReadByte: Byte;
  begin
    if AStream.Read(Result{$IFNDEF DOTNET}, 1{$ENDIF}) <> 1 then begin
      raise EIdException.Create('Unable to read byte'); {do not localize}
    end;
  end;

begin
  Result := 0;
  {$IFDEF STRING_IS_ANSI}
  LATmp := nil; // keep the compiler happy
  {$ENDIF}

  EnsureEncoding(AByteEncoding);
  StartPos := AStream.Position;

  // don't raise an exception here, backwards compatibility for now
  if AStream.Read(Lb{$IFNDEF DOTNET}, 1{$ENDIF}) <> 1 then begin
    Exit;
  end;
  Result := 1;

  // 2 Chars to handle UTF-16 surrogates
  NumBytes := AByteEncoding.GetMaxByteCount(2);
  SetLength(LBytes, NumBytes);
  {$IFNDEF DOTNET}
  SetLength(LChars, 2);
  {$ENDIF}

  try
    repeat
      LBytes[Result-1] := Lb;
      NumChars := AByteEncoding.GetChars(LBytes, 0, Result, LChars, 0);
      if (NumChars > 0) or (Result = NumBytes) then begin
        Break;
      end;
      Lb := ReadByte;
      Inc(Result);
    until False;
  except
    AStream.Position := StartPos;
    raise;
  end;

  {$IFDEF STRING_IS_UNICODE}
  // RLebeau: if the bytes were decoded into surrogates, the second
  // surrogate is lost here, as it can't be returned unless we cache
  // it somewhere for the the next ReadTIdBytesFromStream() call to
  // retreive.  Just raise an error for now.  Users will have to
  // update their code to read surrogates differently...
  Assert(NumChars = 1);
  VChar := LChars[0];
  {$ELSE}
  // RLebeau: since we can only return an AnsiChar here, let's convert
  // the decoded characters, surrogates and all, into their Ansi
  // representation. This will have the same problem as above if the
  // conversion results in a multibyte character sequence...
  EnsureEncoding(ADestEncoding, encOSDefault);
  SetString(LWTmp, PWideChar(LChars), NumChars);
  LATmp := ADestEncoding.GetBytes(LWTmp); // convert to Ansi
  Assert(Length(LATmp) = 1);
  VChar := Char(LATmp[0]);
  {$ENDIF}
end;

procedure WriteTIdBytesToStream(const AStream: TStream; const ABytes: TIdBytes;
  const ASize: Integer = -1; const AIndex: Integer = 0);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  TIdStreamHelper.Write(AStream, ABytes, ASize, AIndex);
end;

procedure WriteStringToStream(AStream: TStream; const AStr: string;
  ADestEncoding: TIdTextEncoding
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  WriteStringToStream(AStream, AStr, -1, 1, ADestEncoding
    {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
    );
end;

procedure WriteStringToStream(AStream: TStream; const AStr: string;
  const ALength: Integer = -1; const AIndex: Integer = 1;
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LLength: Integer;
  LBytes: TIdBytes;
begin
  LBytes := nil;
  LLength := IndyLength(AStr, ALength, AIndex);
  if LLength > 0 then
  begin
    LBytes := ToBytes(AStr, LLength, AIndex, ADestEncoding
    {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
    );
    TIdStreamHelper.Write(AStream, LBytes);
  end;
end;

{$IFDEF DOTNET}
function TIdBaseStream.Read(var VBuffer: array of Byte; AOffset, ACount: Longint): Longint;
var
  LBytes: TIdBytes;
begin
  // this is a silly work around really, but array of Byte and TIdByte aren't
  // interchangable in a var parameter, though really they *should be*
  SetLength(LBytes, ACount - AOffset);
  Result := IdRead(LBytes, 0, ACount - AOffset);
  CopyTIdByteArray(LBytes, 0, VBuffer, AOffset, Result);
end;

function TIdBaseStream.Write(const ABuffer: array of Byte; AOffset, ACount: Longint): Longint;
begin
  Result := IdWrite(ABuffer, AOffset, ACount);
end;

function TIdBaseStream.Seek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  Result := IdSeek(AOffset, AOrigin);
end;

procedure TIdBaseStream.SetSize(ASize: Int64);
begin
  IdSetSize(ASize);
end;

{$ELSE}

  {$IFDEF STREAM_SIZE_64}
procedure TIdBaseStream.SetSize(const NewSize: Int64);
begin
   IdSetSize(NewSize);
end;
  {$ELSE}
procedure TIdBaseStream.SetSize(ASize: Integer);
begin
  IdSetSize(ASize);
end;
 {$ENDIF}

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

  {$IFDEF STREAM_SIZE_64}
function TIdBaseStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := IdSeek(Offset, Origin);
end;
  {$ELSE}
function TIdBaseStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  LSeek : TSeekOrigin;
begin
  case Origin of
    soFromBeginning : LSeek := soBeginning;
    soFromCurrent : LSeek := soCurrent;
    soFromEnd : LSeek := soEnd;
  else
    Result := 0;
    Exit;
  end;
  Result := IdSeek(Offset, LSeek) and $FFFFFFFF;
end;
  {$ENDIF}

{$ENDIF}

function TIdEventStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  Result := 0;
  if Assigned(FOnRead) then begin
    FOnRead(VBuffer, AOffset, ACount, Result);
  end;
end;

function TIdEventStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  if Assigned(FOnWrite) then begin
    Result := 0;
    FOnWrite(ABuffer, AOffset, ACount, Result);
  end else begin
    Result := ACount;
  end;
end;

function TIdEventStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  Result := 0;
  if Assigned(FOnSeek) then begin
    FOnSeek(AOffset, AOrigin, Result);
  end;
end;

procedure TIdEventStream.IdSetSize(ASize: Int64);
begin
  if Assigned(FOnSetSize) then begin
    FOnSetSize(ASize);
  end;
end;

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
  ADestEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF}
  );
var
  LBytes: TIdBytes;
  LLength, LOldLen: Integer;
begin
  LBytes := nil; // keep the compiler happy
  LLength := IndyLength(AStr, ALength);
  if LLength > 0 then begin
    LBytes := ToBytes(AStr, LLength, 1, ADestEncoding
      {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
      );
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
  ExpandBytes(VBytes, AIndex, 1);
  VBytes[AIndex] := AByte;
end;

procedure RemoveBytes(var VBytes: TIdBytes; const ACount: Integer; const AIndex: Integer = 0);
var
  I: Integer;
  LActual: Integer;
begin
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
  {$IFDEF DOTNET}
  Result := System.String.Compare(A1, A2, True) = 0;
  {$ELSE}
  Result := AnsiCompareText(A1, A2) = 0;
  {$ENDIF}
end;

function TextStartsWith(const S, SubS: string): Boolean;
var
  LLen: Integer;
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LS, LSub: WideString;
  P1, P2: PWideChar;
    {$ELSE}
  P1, P2: PChar;
     {$ENDIF}
  {$ENDIF}
begin
  LLen := Length(SubS);
  Result := LLen <= Length(S);
  if Result then
  begin
    {$IFDEF DOTNET}
    Result := System.String.Compare(S, 0, SubS, 0, LLen, True) = 0;
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
        {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
    // convert to Unicode
    LS := S;
    LSub := SubS;
    P1 := PWideChar(LS);
    P2 := PWideChar(LSub);
        {$ELSE}
    P1 := PChar(S);
    P2 := PChar(SubS);
        {$ENDIF}
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P1, LLen, P2, LLen) = 2;
      {$ELSE}
    Result := AnsiCompareText(Copy(S, 1, LLen), SubS) = 0;
      {$ENDIF}
    {$ENDIF}
  end;
end;

function TextEndsWith(const S, SubS: string): Boolean;
var
  LLen: Integer;
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LS, LSubS: WideString;
  P1, P2: PWideChar;
    {$ELSE}
  P1, P2: PChar;
    {$ENDIF}
  {$ENDIF}
begin
  LLen := Length(SubS);
  Result := LLen <= Length(S);
  if Result then
  begin
    {$IFDEF DOTNET}
    Result := System.String.Compare(S, Length(S)-LLen, SubS, 0, LLen, True) = 0;
    {$ELSE}
      {$IFDEF WIN32_OR_WIN64_OR_WINCE}
        {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
    // convert to Unicode
    LS := S;
    LSubS := SubS;
    P1 := PWideChar(LS);
    P2 := PWideChar(LSubS);
        {$ELSE}
    P1 := PChar(S);
    P2 := PChar(SubS);
        {$ENDIF}
    Inc(P1, Length(S)-LLen);
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P1, LLen, P2, LLen) = 2;
      {$ELSE}
    Result := AnsiCompareText(Copy(S, Length(S)-LLen+1, LLen), SubS) = 0;
      {$ENDIF}
    {$ENDIF}
  end;
end;

function IndyLowerCase(const A1: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := A1.ToLower;
  {$ELSE}
  Result := AnsiLowerCase(A1);
  {$ENDIF}
end;

function IndyUpperCase(const A1: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := A1.ToUpper;
  {$ELSE}
  Result := AnsiUpperCase(A1);
  {$ENDIF}
end;

function IndyCompareStr(const A1, A2: string): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := CompareStr(A1, A2);
  {$ELSE}
  Result := AnsiCompareStr(A1, A2);
  {$ENDIF}
end;

function CharPosInSet(const AString: string; const ACharPos: Integer; const ASet: String): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
{$IFNDEF DOTNET}
var
  LChar: Char;
  I: Integer;
{$ENDIF}
begin
  Result := 0;
  if ACharPos < 1 then begin
    EIdException.Toss('Invalid ACharPos');{ do not localize }
  end;
  if ACharPos <= Length(AString) then begin
    {$IFDEF DOTNET}
    Result := ASet.IndexOf(AString[ACharPos]) + 1;
    {$ELSE}
    // RLebeau 5/8/08: Calling Pos() with a Char as input creates a temporary
    // String.  Normally this is fine, but profiling reveils this to be a big
    // bottleneck for code that makes a lot of calls to CharIsInSet(), so need
    // to scan through ASet looking for the character without a conversion...
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
    {$ENDIF}
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
  Result := CharIsInSet(AString, ACharPos, EOL);
end;

function CharEquals(const AString: string; const ACharPos: Integer; const AValue: Char): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ACharPos < 1 then begin
    EIdException.Toss('Invalid ACharPos');{ do not localize }
  end;
  Result := ACharPos <= Length(AString);
  if Result then begin
    Result := AString[ACharPos] = AValue;
  end;
end;

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
    EIdException.Toss('Invalid AIndex'); {do not localize}
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
  AExceptionIfEOF: Boolean = False; AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): string; overload;
begin
  if (not ReadLnFromStream(AStream, Result, AMaxLineLength, AByteEncoding
    {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
    )) and AExceptionIfEOF then
begin
    EIdEndOfStream.Toss(IndyFormat(RSEndOfStream, ['', AStream.Position]));
  end;
end;

//TODO: Continue to optimize this function. Its performance severely impacts the coders
function ReadLnFromStream(AStream: TStream; var VLine: String; AMaxLineLength: Integer = -1;
  AByteEncoding: TIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
  ): Boolean; overload;
const
  LBUFMAXSIZE = 2048;
var
  LStringLen, LResultLen: LongInt;
  LBuf: TIdBytes;
  LLine: TIdBytes;
  // LBuf: packed array [0..LBUFMAXSIZE] of Char;
  LBufSize, LStrmPos, LStrmSize: TIdStreamSize; //LBytesToRead = stream size - Position
  LCrEncountered: Boolean;

  function FindEOL(const ABuf: TIdBytes; var VLineBufSize: TIdStreamSize; var VCrEncountered: Boolean): TIdStreamSize;
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
    LBufSize := IndyMin(LStrmSize - LStrmPos, LBUFMAXSIZE);
    LBufSize := ReadTIdBytesFromStream(AStream, LBuf, LBufSize);
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

  AStream.Position := LStrmPos;
  VLine := BytesToString(LLine, 0, -1, AByteEncoding
    {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
    );
  Result := True;
end;

{$IFNDEF DOTNET}
  {$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
function IndyRegisterExpectedMemoryLeak(AAddress: Pointer): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF USE_FASTMM4}
  // RLebeau 4/9/2009: the user can override the RTL's version of FastMM
  // (2006+ only) with the full version of FastMM in order to enable
  // advanced debugging features, so check for that first...
  Result := FastMM4.RegisterExpectedMemoryLeak(AAddress);
  {$ELSE}
    {$IFDEF VCL_2006_OR_ABOVE}
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

  //Result := System.SysRegisterExpectedMemoryLeak(AAddress);
  Result := System.RegisterExpectedMemoryLeak(AAddress);
    {$ELSE}
  Result := False;
    {$ENDIF}
  {$ENDIF}
end;
  {$ENDIF}
{$ENDIF}

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
  {$IFDEF HAS_TStringList_CaseSensitive}
  if AStrings is TStringList then begin
    Result := IndyIndexOf(TStringList(AStrings), AStr, ACaseSensitive);
    Exit;
  end;
  {$ENDIF}
  Result := InternalIndyIndexOf(AStrings, AStr, ACaseSensitive);
end;

{$IFDEF HAS_TStringList_CaseSensitive}
function IndyIndexOf(AStrings: TStringList; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings.CaseSensitive = ACaseSensitive then begin
    Result := AStrings.IndexOf(AStr);
  end else begin
    Result := InternalIndyIndexOf(AStrings, AStr, ACaseSensitive);
  end;
end;
{$ENDIF}

function InternalIndyIndexOfName(AStrings: TStrings; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AStrings.Count - 1 do begin
    if ACaseSensitive then begin
      if AStrings.Names[I] = AStr then begin
        Result := I;
        Exit;
      end;
    end else begin
      if TextIsSame(AStrings.Names[I], AStr) then begin
        Result := I;
        Exit;
      end;
    end;
  end;
end;

function IndyIndexOfName(AStrings: TStrings; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  {$IFDEF HAS_TStringList_CaseSensitive}
  if AStrings is TStringList then begin
    Result := IndyIndexOfName(TStringList(AStrings), AStr, ACaseSensitive);
    Exit;
  end;
  {$ENDIF}
  Result := InternalIndyIndexOfName(AStrings, AStr, ACaseSensitive);
end;

{$IFDEF HAS_TStringList_CaseSensitive}
function IndyIndexOfName(AStrings: TStringList; const AStr: string;
  const ACaseSensitive: Boolean = False): Integer;
begin
  if AStrings.CaseSensitive = ACaseSensitive then begin
    Result := AStrings.IndexOfName(AStr);
  end else begin
    Result := IndyIndexOfName(TStrings(AStrings), AStr, ACaseSensitive);
  end;
end;
{$ENDIF}

initialization
  // AnsiPos does not handle strings with #0 and is also very slow compared to Pos
  {$IFDEF DOTNET}
  IndyPos := SBPos;
  {$ELSE}
  if LeadBytes = [] then begin
    IndyPos := SBPos;
  end else begin
    IndyPos := InternalAnsiPos;
  end;
  {$ENDIF}

{$IFNDEF DOTNET}
finalization
  FreeAndNil(GIdPorts);
  FreeAndNil(GId8BitEncoding);
  FreeAndNil(GIdASCIIEncoding);
  FreeAndNil(GIdUTF8Encoding);
  {$IFNDEF TIdTextEncoding_IS_NATIVE}
  TIdTextEncoding.FreeEncodings;
  {$ENDIF}
{$ENDIF}

end.

