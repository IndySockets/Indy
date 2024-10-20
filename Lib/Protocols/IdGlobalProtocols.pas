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
  10   Indy10    1.9         5/4/2005 7:06:24 PM    J. Peter Mugaas Attempt to
      fix another junked part of the file.

  9    Indy10    1.8         5/4/2005 7:02:50 PM    J. Peter Mugaas Attempt to
      fix a junked file.

  8    Indy10    1.7         5/4/2005 6:31:08 PM    J. Peter Mugaas These
      should now work.  I moved a TextWrapping function out of TIdHeaderList
      and into IdGlobalProtocols so the FTP List output object can use it and
      so we can rework the routine slightly to use StringBuilder in DotNET.

  7    Indy10    1.6         4/28/2005 11:02:30 PM  J. Peter Mugaas Removed
      StrToInt64Def symbol.  We now use Sys.StrToInt64 instead.

  6    Indy10    1.5         4/28/2005 10:23:14 PM  J. Peter Mugaas Should now
      work with new API change in CharInSet.

  5    Indy10    1.4         4/20/2005 10:44:24 PM  Ben Taylor      IdSys
      changes

  4    Indy10    1.3         4/20/2005 12:43:48 AM  J. Peter Mugaas Removed
      SysUtils from most units and added it to IdGlobalProtocols (works best
      that way).

  3    Indy10    1.2         4/19/2005 5:19:11 PM   J. Peter Mugaas Removed
      SysUtils and fixed EIdException reference.

  2    Indy10    1.1         4/19/2005 10:15:26 AM  J. Peter Mugaas Updates

  Rev 1.31    04/03/2005 21:21:56  HHariri
  Fix for DirectoryExists and removal of FileCtrl dependency

  Rev 1.30    3/3/2005 10:12:38 AM  JPMugaas
  Fix for compiler warning about DotNET and ByteType.

  Rev 1.29    2/12/2005 8:08:02 AM  JPMugaas
  Attempt to fix MDTM bug where msec was being sent.

  Rev 1.28    2/10/2005 2:24:40 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.27    1/15/2005 6:02:46 PM  JPMugaas
  Byte extract with byte order now use updated code in IdGlobal.

  Rev 1.26    1/8/2005 3:59:58 PM  JPMugaas
  New functions for reading integer values to and from TIdBytes using the
  network byte order functions.  They should be used for embedding values in
  some Internet Protocols such as FSP, SNTP, and maybe others.

    Rev 1.25    12/3/2004 3:16:20 PM  DSiders
  Fixed assignment error in MakeTempFilename.

  Rev 1.24    12/1/2004 4:40:42 AM  JPMugaas
  Fix for GMT Time routine.  This has been tested.

  Rev 1.23    11/14/2004 10:28:42 PM  JPMugaas
  Compiler warning in IdGlobalProtocol about an undefined result.

  Rev 1.22    12/11/2004 9:31:22  HHariri
  Fix for Delphi 5

  Rev 1.21    11/11/2004 11:18:04 PM  JPMugaas
  Function to get the Last Modified file in GMT instead of localtime.  Needed
  by TIdFSP.

  Rev 1.20    2004.10.27 9:17:50 AM  czhower
  For TIdStrings

  Rev 1.19    10/26/2004 10:07:02 PM  JPMugaas
  Updated refs.

    Rev 1.18    10/13/2004 7:48:52 PM  DSiders
  Modified GetUniqueFilename to pass correct argument type to tempnam function.

    Rev 1.17    10/6/2004 11:39:48 PM  DSiders
  Modified MakeTempFilename to use GetUniqueFilename.  File extensions are
  omitted on Linux.
  Modified GetUniqueFilename to use tempnam function on Linux.  Validates path
  on Win32 and .Net.  Uses platform-specific temp path on Win32 and .Net.

  Rev 1.16    9/5/2004 2:55:52 AM  JPMugaas
  Fixed a range check error in

  function TwoCharToWord(AChar1,AChar2: Char):Word;.

  Rev 1.15    8/10/04 8:47:16 PM  RLebeau
  Bug fix for TIdMimeTable.AddMimeType()

  Rev 1.14    8/5/04 5:44:40 PM  RLebeau
  Added GetMIMEDefaultFileExt() function

  Rev 1.13    7/23/04 6:51:34 PM  RLebeau
  Added extra exception handling to IndyCopyFile()

  Updated CopyFileTo() to call IndyCopyFile()

  TFileStream access right tweak for FileSizeByName()

  Rev 1.12    7/8/04 5:23:46 PM  RLebeau
  Updated CardinalToFourChar() to remove use of local TIdBytes variable

  Rev 1.11    11/06/2004 00:22:38  CCostelloe
  Implemented GetClockValue for Linux

  Rev 1.10    09/06/2004 10:03:00  CCostelloe
  Kylix 3 patch

  Rev 1.9    02/05/2004 13:20:50  CCostelloe
  Added RemoveHeaderEntry for use by IdMessage and IdMessageParts (typically
  removing old boundary)

  Rev 1.8    2/22/2004 12:09:38 AM  JPMugaas
  Fixes for IMAP4Server compile failure in DotNET.  This also fixes a potential
  problem where file handles can be leaked in the server needlessly.

  Rev 1.7    2/19/2004 11:53:00 PM  JPMugaas
  Moved some functions out of CoderQuotedPrintable for reuse.

  Rev 1.6    2/19/2004 11:40:28 PM  JPMugaas
  Character to hex translation routine added for QP and some
  internationalization work.

  Rev 1.5    2/19/2004 3:22:40 PM  JPMugaas
  ABNFToText and related functions added for some RFC 2234.  This is somee
  groundwork for RFC 2640 - Internationalization of the File Transfer Protocol.

  Rev 1.4    2/16/2004 1:53:34 PM  JPMugaas
  Moved some routines to the system package.

  Rev 1.3    2/11/2004 5:17:50 AM  JPMugaas
  Bit flip functionality was removed because is problematic on some
  architectures.  They were used in place of the standard network byte order
  conversion routines.  On an Intel chip, flip works the same as those but in
  architectures where network order is the same as host order, some functions
  will fail and you may get strange results.  The network byte order conversion
  functions provide transparancy amoung architectures.

  Rev 1.2    2/9/2004 11:27:48 AM  JPMugaas
  Some functions weren't working as expected.  Renamed them to describe them
  better.

  Rev 1.1    2/7/2004 7:18:38 PM  JPMugaas
  Moved some functions out of IdDNSCommon so we can use them elsewhere.

  Rev 1.0    2004.02.03 7:46:04 PM  czhower
  New names

  Rev 1.43    1/31/2004 3:31:58 PM  JPMugaas
  Removed some File System stuff for new package.

  Rev 1.42    1/31/2004 1:00:26 AM  JPMugaas
  FileDateByName was changed to LocalFileDateByName as that uses the Local Time
  Zone.
  Added BMTDateByName for some GMT-based stuff.
  We now use the IdFileSystem*.pas units instead of SysUtils for directory
  functions.  This should remove a dependancy on platform specific things in
  DotNET.

  Rev 1.41    1/29/2004 6:22:22 AM  JPMugaas
  IndyComputerName will now use Environment.MachineName in DotNET.  This should
  fix the ESMTP bug where IndyComputerName would return nothing causing an EHLO
  and HELO command to fail in TIdSMTP under DotNET.

  Rev 1.40    2004.01.22 5:58:56 PM  czhower
  IdCriticalSection

  Rev 1.39    14/01/2004 00:16:10  CCostelloe
  Updated to remove deprecated warnings by using
  TextIsSame/IndyLowerCase/IndyUpperCase

  Rev 1.38    2003.12.28 6:50:30 PM  czhower
  Update for Ticks function

  Rev 1.37    4/12/2003 10:24:06 PM  GGrieve
  Fix to Compile

  Rev 1.36    11/29/2003 12:19:50 AM  JPMugaas
  CompareDateTime added for more accurate DateTime comparisons.  Sometimes
  comparing two floating point values for equality will fail because they are
  of different percision and some fractions such as 1/3 and pi (7/22) can never
  be calculated 100% accurately.

  Rev 1.35    25/11/2003 12:24:20 PM  SGrobety
  various IdStream fixes with ReadLn/D6

    Rev 1.34    10/16/2003 11:18:10 PM  DSiders
  Added localization comments.
  Corrected spelling error in coimments.

  Rev 1.33    10/15/2003 9:53:58 PM  GGrieve
  Add TIdInterfacedObject

  Rev 1.32    10/10/2003 10:52:12 PM  BGooijen
  Removed IdHexDigits

  Rev 1.31    10/8/2003 9:52:40 PM  GGrieve
  reintroduce GetSystemLocale as IdGetDefaultCharSet

  Rev 1.30    10/8/2003 2:25:40 PM  GGrieve
  Update ROL and ROR for DotNet

  Rev 1.29    10/5/2003 11:43:32 PM  GGrieve
  Add IsLeadChar

  Rev 1.28    10/5/2003 5:00:10 PM  GGrieve
  GetComputerName (once was IndyGetHostName)

  Rev 1.27    10/4/2003 9:14:26 PM  GGrieve
  Remove TIdCardinalBytes - replace with other methods

  Rev 1.26    10/3/2003 11:55:50 PM  GGrieve
  First full DotNet version

  Rev 1.25    10/3/2003 5:39:30 PM  GGrieve
  dotnet work

  Rev 1.24    2003.10.02 10:52:48 PM  czhower
  .Net

  Rev 1.23    2003.10.02 9:27:50 PM  czhower
  DotNet Excludes

  Rev 1.22    9/18/2003 07:41:46 PM  JPMugaas
  Moved GetThreadHandle to IdCoreGlobal.

  Rev 1.21    9/10/2003 03:26:42 AM  JPMugaas
  Added EnsureMsgIDBrackets() function.  Checked in on behalf of Remy Lebeau

  Rev 1.20    6/27/2003 05:53:28 AM  JPMugaas
  Removed IsNumeric.  That's now in IdCoreGlobal.

  Rev 1.19    2003.06.23 2:57:18 PM  czhower
  Comments added

  Rev 1.18    2003.06.23 9:46:54 AM  czhower
  Russian, Ukranian support for headers.

  Rev 1.17    2003.06.13 2:24:40 PM  czhower
  Expanded TIdCardinalBytes

  Rev 1.16    5/13/2003 12:45:50 PM  JPMugaas
  GetClockValue added for unique clock values.

  Rev 1.15    5/8/2003 08:43:14 PM  JPMugaas
  Function for finding an integer's position in an array of integers.  This is
  required by some SASL code.

    Rev 1.14    4/21/2003 7:52:58 PM  BGooijen
  other nt version detection, removed non-existing windows versions

  Rev 1.13    4/18/2003 09:28:24 PM  JPMugaas
  Changed Win32 Operating System detection so it can distinguish between
  workstation OS NT versions and server versions.  I also added specific
  detection for Windows NT 4.0 with a Service Pack below 6 (requested by Bas).

  Rev 1.12    2003.04.16 10:06:22 PM  czhower
  Moved DebugOutput to IdCoreGlobal

  Rev 1.11    4/10/2003 02:54:32 PM  JPMugaas
  Improvement for FTP STOU command.  Unique filename now uses
  IdGlobal.GetUniqueFileName instead of Rand.  I also fixed GetUniqueFileName
  so that it can accept an empty path specification.

    Rev 1.10    4/5/2003 10:39:06 PM  BGooijen
  LAM,LPM were not initialized

  Rev 1.9    4/5/2003 04:12:00 AM  JPMugaas
  Date Time should now be able to process AM/PM.

  Rev 1.8    4/4/2003 11:02:56 AM  JPMugaas
  Added GetUniqueFileName for the Virtual FTP File System component.

  Rev 1.7    20/3/2003 19:15:46  GGrieve
  Fix GMTToLocalDateTime for empty content

  Rev 1.6    3/9/2003 04:34:40 PM  JPMugaas
  FileDateByName now works on directories.

  Rev 1.5    2/14/2003 11:50:58 AM  JPMugaas
  Removed a function for giving an OS identifier in the FTP server because we
  no longer use that function.

  Rev 1.4    1/27/2003 12:30:22 AM  JPMugaas
  Forgot to add a space after one OS type.  That makes the job a little easier
  for the FTP Server SYST command handler.

  Rev 1.3    1/26/2003 11:56:30 PM  JPMugaas
  Added function for returning an OS descriptor for combining with a FTP Server
  SysDescription for the SYST command reply.  This can also optionally return
  the true system identifier.

  Rev 1.2    1/9/2003 05:39:08 PM  JPMugaas
  Added workaround for if the date is missing a space after a comma.

  Rev 1.1    12/29/2002 2:13:14 PM  JPMugaas
  Moved THandle to IdCoreGlobal for new function used in the core.

  Rev 1.0    11/13/2002 08:29:32 AM  JPMugaas
  Initial import from FTP VC.
}

unit IdGlobalProtocols;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  IdCharsets,
  IdBaseComponent,
  IdGlobal,
  IdException,
  SysUtils;

const
  LWS = TAB + CHAR32;

  // TODO: get rid of these and use the ones in the IdGlobal unit
  wdays: array[1..7] of string =
    ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'); {do not localize}
  monthnames: array[1..12] of string =
    ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); {do not localize}

type
  //WinCE only has Unicode functions for files.
  {$IFDEF WINCE}
  TIdFileName = TIdUnicodeString;
  PIdFileNameChar = PWideChar;
  {$ELSE}
  TIdFileName = String;
  PIdFileNameChar = PChar;
  {$ENDIF}

  TIdReadLnFunction = function: string of object;
  TStringEvent = procedure(ASender: TComponent; const AString: String);

  TIdMimeTable = class(TObject)
  protected
    FLoadTypesFromOS: Boolean;
    FOnBuildCache: TNotifyEvent;
    FMIMEList: TStrings;
    FFileExt: TStrings;
    procedure BuildDefaultCache; virtual;
  public
    property LoadTypesFromOS: Boolean read FLoadTypesFromOS write FLoadTypesFromOS;
    procedure BuildCache; virtual;
    procedure AddMimeType(const Ext, MIMEType: string; const ARaiseOnError: Boolean = True);
    function GetFileMIMEType(const AFileName: string): string;
    function GetDefaultFileExt(const MIMEType: string): string;
    procedure LoadFromStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    procedure SaveToStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    constructor Create(const AutoFill: Boolean = True); reintroduce; virtual;
    destructor Destroy; override;
    //
    property OnBuildCache: TNotifyEvent read FOnBuildCache write FOnBuildCache;
  end;

  {$UNDEF INTF_USES_STDCALL}
  {$IFDEF DCC}
    {$DEFINE INTF_USES_STDCALL}
  {$ELSE}
    {$IFDEF WINDOWS}
      {$DEFINE INTF_USES_STDCALL}
    {$ENDIF}
  {$ENDIF}

  TIdInterfacedObject = class (TInterfacedObject)
  public
    function _AddRef: {$IFDEF FPC}Longint{$ELSE}Integer{$ENDIF}; {$IFDEF INTF_USES_STDCALL}stdcall{$ELSE}cdecl{$ENDIF};
    function _Release: {$IFDEF FPC}Longint{$ELSE}Integer{$ENDIF}; {$IFDEF INTF_USES_STDCALL}stdcall{$ELSE}cdecl{$ENDIF};
  end;

  TIdHeaderQuotingType = (QuotePlain, QuoteRFC822, QuoteMIME, QuoteHTTP);

  //
  EIdExtensionAlreadyExists = class(EIdException);

  // Procs - KEEP THESE ALPHABETICAL!!!!!

//  procedure BuildMIMETypeMap(dest: TIdStringList);
  // TODO: IdStrings have optimized SplitColumns* functions, can we remove it?
  function ABNFToText(const AText : String) : String;
  function BinStrToInt(const ABinary: String): Integer;
  function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
  function UInt32ToFourChar(AValue : UInt32): string;
  function LongWordToFourChar(AValue : UInt32): string; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use UInt32ToFourChar()'{$ENDIF};{$ENDIF}
  function CharRange(const AMin, AMax : Char): String;
  procedure CommaSeparatedToStringList(AList: TStrings; const Value:string);
  function CompareDateTime(const ADateTime1, ADateTime2 : TDateTime) : Integer;

  function ContentTypeToEncoding(const AContentType: string; AQuoteType: TIdHeaderQuotingType): IIdTextEncoding;
  function CharsetToEncoding(const ACharset: string): IIdTextEncoding;

  function ReadStringAsContentType(AStream: TStream; const AContentType: String;
    AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): String;

  procedure ReadStringsAsContentType(AStream: TStream; AStrings: TStrings;
    const AContentType: String; AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF});

  procedure WriteStringAsContentType(AStream: TStream; const AStr, AContentType: String;
    AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});

  procedure WriteStringsAsContentType(AStream: TStream; const AStrings: TStrings;
    const AContentType: String; AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});

  procedure WriteStringAsCharset(AStream: TStream; const AStr, ACharset: string
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});

  procedure WriteStringsAsCharset(AStream: TStream; const AStrings: TStrings;
    const ACharset: string
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});

  function ReadStringAsCharset(AStream: TStream; const ACharset: String
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): String;

  procedure ReadStringsAsCharset(AStream: TStream; AStrings: TStrings; const ACharset: string
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF});

  {
  These are for handling binary values that are in Network Byte order.  They call
  ntohs, ntols, htons, and htons which are required by SNTP and FSP
  (probably some other protocols).  They aren't aren't in IdGlobals because that
  doesn't refer to IdStack so you can't use GStack there.
  }
  procedure CopyBytesToHostUInt32(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt32);
  procedure CopyBytesToHostUInt16(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt16);
  procedure CopyTIdNetworkUInt32(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer);
  procedure CopyTIdNetworkUInt16(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer);

  procedure CopyBytesToHostLongWord(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt32); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use CopyBytesToHostUInt32'{$ENDIF};{$ENDIF}
  procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt16); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use CopyBytesToHostWord'{$ENDIF};{$ENDIF}
  procedure CopyTIdNetworkLongWord(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use CopyTIdNetworkLongWord'{$ENDIF};{$ENDIF}
  procedure CopyTIdNetworkWord(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use CopyTIdNetworkWord'{$ENDIF};{$ENDIF}

  function CopyFileTo(const Source, Destination: TIdFileName): Boolean;
  function DomainName(const AHost: String): String;
  function EnsureMsgIDBrackets(const AMsgID: String): String;
  function ExtractHeaderItem(const AHeaderLine: String): String;
  function ExtractHeaderSubItem(const AHeaderLine, ASubItem: String; AQuoteType: TIdHeaderQuotingType): String;
  function ReplaceHeaderSubItem(const AHeaderLine, ASubItem, AValue: String; AQuoteType: TIdHeaderQuotingType): String; overload;
  function ReplaceHeaderSubItem(const AHeaderLine, ASubItem, AValue: String; var VOld: String; AQuoteType: TIdHeaderQuotingType): String; overload;
  function IsHeaderMediaType(const AHeaderLine, AMediaType: String): Boolean;
  function IsHeaderMediaTypes(const AHeaderLine: String; const AMediaTypes: array of String): Boolean;
  function ExtractHeaderMediaType(const AHeaderLine: String): String;
  function ExtractHeaderMediaSubType(const AHeaderLine: String): String;
  function IsHeaderValue(const AHeaderLine: String; const AValue: String): Boolean; overload;
  function IsHeaderValue(const AHeaderLine: String; const AValues: array of String): Boolean; overload;
  function FileSizeByName(const AFilename: TIdFileName): Int64;
  {$IFDEF WINDOWS}
  function IsVolume(const APathName : TIdFileName) : Boolean;
  {$ENDIF}
  //MLIST FTP DateTime conversion functions
  function FTPMLSToGMTDateTime(const ATimeStamp : String):TDateTime;
  function FTPMLSToLocalDateTime(const ATimeStamp : String):TDateTime;

  function FTPGMTDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
  function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;

  function GetClockValue : Int64;
  function GetMIMETypeFromFile(const AFile: TIdFileName): string;
  function GetMIMEDefaultFileExt(const MIMEType: string): TIdFileName;
  function GetGMTDateByName(const AFileName : TIdFileName) : TDateTime;
  function GetGMTOffsetStr(const S: string): string;
  function GmtOffsetStrToDateTime(const S: string): TDateTime;
  function GMTToLocalDateTime(S: string): TDateTime;
  function CookieStrToLocalDateTime(S: string): TDateTime;
  function IdGetDefaultCharSet : TIdCharSet;
  function IntToBin(Value: UInt32): string;
  function IndyComputerName : String; // DotNet: see comments regarding GDotNetComputerName below
  function IndyCurrentYear : Integer;

  function IndyStrToBool(const AString: String): Boolean;
  function IsDomain(const S: String): Boolean;
  function IsFQDN(const S: String): Boolean;
  function IsBinary(const AChar : Char) : Boolean;
  function IsHex(const AChar : Char) : Boolean;
  function IsHostname(const S: String): Boolean;
  {$IFDEF STRING_IS_ANSI}
  function IsLeadChar(ACh : Char): Boolean;
  {$ENDIF}
  function IsTopDomain(const AStr: string): Boolean;
  function IsValidIP(const S: String): Boolean;
  function MakeTempFilename(const APath: TIdFileName = ''): TIdFileName;
  function OrdFourByteToUInt32(AByte1, AByte2, AByte3, AByte4 : Byte): UInt32;
  function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): UInt32; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use OrdFourByteToUInt32()'{$ENDIF};{$ENDIF}
  procedure UInt32ToOrdFourByte(const AValue: UInt32; var VByte1, VByte2, VByte3, VByte4 : Byte);
  procedure LongWordToOrdFourByte(const AValue: UInt32; var VByte1, VByte2, VByte3, VByte4 : Byte); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use UInt32ToOrdFourByte()'{$ENDIF};{$ENDIF}

  function PadString(const AString : String; const ALen : Integer; const AChar: Char): String;
  function UnquotedStr(const AStr : String): String;

  function ProcessPath(const ABasePath: String; const APath: String; const APathDelim: string = '/'): string;    {Do not Localize}
  function RightStr(const AStr: String; const Len: Integer): String;

  // still to figure out how to reproduce these under .Net
  // TODO: deprecate these, as Indy does not use them at all...
  function ROL(const AVal: UInt32; AShift: Byte): UInt32;
  function ROR(const AVal: UInt32; AShift: Byte): UInt32;

  function RPos(const ASub, AIn: String; AStart: Integer = -1): Integer;
  function IndySetLocalTime(Value: TDateTime): Boolean;

  function StartsWith(const ANSIStr, APattern : String) : Boolean;

  function StrInternetToDateTime(Value: string): TDateTime;
  function StrToDay(const ADay: string): Byte;
  function StrToMonth(const AMonth: string): Byte;
  function StrToWord(const Value: String): Word;
  function TimeZoneBias: TDateTime; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use IdGlobal.LocalTimeToUTCTime() or IdGlobal.UTCTimeToLocalTime()'{$ENDIF};{$ENDIF}
   //these are for FSP but may also help with MySQL
  function UnixDateTimeToDelphiDateTime(UnixDateTime: UInt32): TDateTime;
  function DateTimeToUnix(ADateTime: TDateTime): UInt32;

  function TwoCharToUInt16(AChar1, AChar2: Char): Word;
  function TwoCharToWord(AChar1, AChar2: Char): Word; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TwoCharToUInt16()'{$ENDIF};{$ENDIF}

  function UpCaseFirst(const AStr: string): string;
  function UpCaseFirstWord(const AStr: string): string;
  function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
  procedure UInt16ToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
  procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer); {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use UInt16ToTwoBytes()'{$ENDIF};{$ENDIF}
  function UInt16ToStr(const Value: Word): String;
  function WordToStr(const Value: Word): String; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use UInt16ToStr()'{$ENDIF};{$ENDIF}

  //moved here so I can IFDEF a DotNET ver. that uses StringBuilder
  function IndyWrapText(const ALine, ABreakStr, ABreakChars : string; MaxCol: Integer): string;

  //The following is for working on email headers and message part headers...
  function RemoveHeaderEntry(const AHeader, AEntry: string; AQuoteType: TIdHeaderQuotingType): string; overload;
  function RemoveHeaderEntry(const AHeader, AEntry: string; var VOld: String; AQuoteType: TIdHeaderQuotingType): string; overload;
  function RemoveHeaderEntries(const AHeader: string; const AEntries: array of string; AQuoteType: TIdHeaderQuotingType): string;

  {
    Three functions for easier manipulating of strings.  Don't know of any
    system functions to perform these actions.  If there aren't and someone
    can find an optimised way of performing then please implement...
  }
  function FindFirstOf(const AFind, AText: string; const ALength: Integer = -1; const AStartPos: Integer = 1): Integer;
  function FindFirstNotOf(const AFind, AText: string; const ALength: Integer = -1; const AStartPos: Integer = 1): Integer;
  function TrimAllOf(const ATrim, AText: string): string;
  procedure ParseMetaHTTPEquiv(AStream: TStream; AHeaders : TStrings; var VCharSet: string);

type
  TIdEncodingNeededEvent = function(const ACharset: String): IIdTextEncoding;

var
  {$IFDEF UNIX}
  // For linux the user needs to set these variables to be accurate where used (mail, etc)
  GIdDefaultCharSet : TIdCharSet = idcs_ISO_8859_1; // idcsISO_8859_1;
  {$ENDIF}

  GIdEncodingNeeded: TIdEncodingNeededEvent = nil;

  IndyFalseBoolStrs : array of String;
  IndyTrueBoolStrs : array of String;

//This is from: http://www.swissdelphicenter.ch/en/showcode.php?id=844
const
  // Sets UnixStartDate to TIdDateTime of 01/01/1970
  UNIXSTARTDATE : TDateTime = 25569.0;
   {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  TIME_BASEDATE = 2;
  
//These are moved here to facilitate inlining
const
  HexNumbers = '01234567890ABCDEF';  {Do not Localize}
  BinNumbers = '01'; {Do not localize}

implementation

uses
  {$IFDEF USE_VCL_POSIX}
    {$IFDEF OSX}
  Macapi.CoreServices,
    {$ENDIF}
  {$ENDIF}
  IdIPAddress,
  {$IFDEF UNIX}
    {$IFDEF USE_VCL_POSIX}
  Posix.SysStat, Posix.SysTime, Posix.Time, Posix.Unistd,
    {$ELSE}
      {$IFDEF KYLIXCOMPAT}
  Libc,
      {$ELSE}
        {$IFDEF USE_BASEUNIX}
  BaseUnix, Unix,
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_UNIT_DateUtils}
  DateUtils,
  {$ENDIF}
  {$IFDEF WINDOWS}
  Messages,
  Registry,
  {$ENDIF}
  {$IFDEF DOTNET}
  System.IO,
  System.Text,
  {$ENDIF}
  IdAssignedNumbers,
  IdResourceStringsCore,
  IdResourceStringsProtocols,
  IdStack
  {$IFDEF HAS_IOUtils_TPath}
    {$IFDEF VCL_XE2_OR_ABOVE}
  , System.IOUtils
    {$ELSE}
  , IOUtils
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_OBJECT_ARC}
    {$IFDEF HAS_UNIT_Generics_Collections}
  , System.Generics.Collections
    {$ENDIF}
  {$ENDIF}
  ;

//

function UnquotedStr(const AStr : String): String;
begin
  Result := AStr;
  if TextStartsWith(Result, '"') then begin
    IdDelete(Result, 1, 1);
    Result := Fetch(Result, '"');
  end;
end;

{This is taken from Borland's SysUtils and modified for our folding}    {Do not Localize}
function IndyWrapText(const ALine, ABreakStr, ABreakChars : string; MaxCol: Integer): string;
const
  QuoteChars = '"';    {Do not Localize}
var
  LCol, LPos: Integer;
  LLinePos, LLineLen: Integer;
  LBreakLen, LBreakPos: Integer;
  LQuoteChar, LCurChar: Char;
  LExistingBreak: Boolean;
begin
  LCol := 1;
  LPos := 1;
  LLinePos := 1;
  LBreakPos := 0;
  LQuoteChar := ' ';    {Do not Localize}
  LExistingBreak := False;
  LLineLen := Length(ALine);
  LBreakLen := Length(ABreakStr);
  Result := '';    {Do not Localize}
  while LPos <= LLineLen do begin
    LCurChar := ALine[LPos];
    {$IFDEF STRING_IS_ANSI}
    if IsLeadChar(LCurChar) then begin
      Inc(LPos);
      Inc(LCol);
    end else begin //if CurChar in LeadBytes then
    {$ENDIF}
      if LCurChar = ABreakStr[1] then begin
        if LQuoteChar = ' ' then begin   {Do not Localize}
          LExistingBreak := TextIsSame(ABreakStr, Copy(ALine, LPos, LBreakLen));
          if LExistingBreak then begin
            Inc(LPos, LBreakLen-1);
            LBreakPos := LPos;
          end; //if ExistingBreak then
        end // if QuoteChar = ' ' then    {Do not Localize}
      end else begin// if CurChar = BreakStr[1] then
        if CharIsInSet(LCurChar, 1, ABreakChars) then begin
          if LQuoteChar = ' ' then begin   {Do not Localize}
            LBreakPos := LPos;
          end;
        end else begin // if CurChar in BreakChars then
          if CharIsInSet(LCurChar, 1, QuoteChars) then begin
            if LCurChar = LQuoteChar then begin
              LQuoteChar := ' ';    {Do not Localize}
            end else begin
              if LQuoteChar = ' ' then begin   {Do not Localize}
                LQuoteChar := LCurChar;
              end;
            end;
          end;
        end;
      end;
    {$IFDEF STRING_IS_ANSI}
    end;
    {$ENDIF}
    Inc(LPos);
    Inc(LCol);
    if not (CharIsInSet(LQuoteChar, 1, QuoteChars)) and
       (LExistingBreak or
      ((LCol > MaxCol) and (LBreakPos > LLinePos))) then begin
      LCol := LPos - LBreakPos;
      Result := Result + Copy(ALine, LLinePos, LBreakPos - LLinePos + 1);
      if not (CharIsInSet(LCurChar, 1, QuoteChars)) then begin
        while (LPos <= LLineLen) and (CharIsInSet(ALine, LPos, ABreakChars + #13+#10)) do begin
          Inc(LPos);
        end;
        if not LExistingBreak and (LPos < LLineLen) then begin
          Result := Result + ABreakStr;
        end;
      end;
      Inc(LBreakPos);
      LLinePos := LBreakPos;
      LExistingBreak := False;
    end; //if not
  end; //while Pos <= LineLen do
  Result := Result + Copy(ALine, LLinePos, MaxInt);
end;

function IndyCurrentYear : Integer;
{$IFDEF HAS_CurrentYear}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ELSE}
var
  LYear, LMonth, LDay : Word;
{$ENDIF}
begin
  {$IFDEF HAS_CurrentYear}
  Result := CurrentYear;
  {$ELSE}
  DecodeDate(Now, LYear, LMonth, LDay);
  Result := LYear;
  {$ENDIF}
end;

function CharRange(const AMin, AMax : Char): String;
var
  i : Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB : TIdStringBuilder;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(Ord(AMax) - Ord(AMin) + 1);
  for i := AMin to AMax do begin
    LSB.Append(i);
  end;
  Result := LSB.ToString;
  {$ELSE}
  SetLength(Result, Ord(AMax) - Ord(AMin) + 1);
  for i := AMin to AMax do begin
    Result[Ord(i) - Ord(AMin) + 1] := i;
  end;
  {$ENDIF}
end;

{$IFDEF WINDOWS}
var
  GTempPath: TIdFileName;
{$ENDIF}

function StartsWith(const ANSIStr, APattern : String) : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := TextStartsWith(ANSIStr, APattern) {do not localize}
  //tentative fix for a problem with Korean indicated by "SungDong Kim" <infi@acrosoft.pe.kr>
  {$IFNDEF DOTNET}
  //note that in DotNET, everything is MBCS
    and (ByteType(ANSIStr, 1) = mbSingleByte)
  {$ENDIF} ;
  //just in case someone is doing a recursive listing and there's a dir with the name total
end;

function UnixDateTimeToDelphiDateTime(UnixDateTime: UInt32): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (UnixDateTime / 86400) + UnixStartDate;
{
From: http://homepages.borland.com/efg2lab/Library/UseNet/1999/0309b.txt
 }
 //   Result := EncodeDate(1970, 1, 1) + (UnixDateTime / 86400); {86400=No. of secs. per day}
end;

function DateTimeToUnix(ADateTime: TDateTime): UInt32;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  //example: DateTimeToUnix(now);
  Result := Round((ADateTime - UnixStartDate) * 86400);
end;

{$I IdDeprecatedImplBugOff.inc}
procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt16);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyBytesToHostUInt16(ASource, ASourceIndex, VDest);
end;

procedure CopyBytesToHostUInt16(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt16);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  VDest := BytesToUInt16(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

{$I IdDeprecatedImplBugOff.inc}
procedure CopyBytesToHostLongWord(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt32);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyBytesToHostUInt32(ASource, ASourceIndex, VDest);
end;

procedure CopyBytesToHostUInt32(const ASource : TIdBytes; const ASourceIndex: Integer; var VDest : UInt32);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  VDest := BytesToUInt32(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

{$I IdDeprecatedImplBugOff.inc}
procedure CopyTIdNetworkWord(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdNetworkUInt16(ASource, VDest, ADestIndex);
end;

procedure CopyTIdNetworkUInt16(const ASource: UInt16; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdUInt16(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

{$I IdDeprecatedImplBugOff.inc}
procedure CopyTIdNetworkLongWord(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdNetworkUInt32(ASource, VDest, ADestIndex);
end;

procedure CopyTIdNetworkUInt32(const ASource: UInt32; var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdUInt32(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

function UInt32ToFourChar(AValue : UInt32): string;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := BytesToStringRaw(ToBytes(AValue));
end;

{$I IdDeprecatedImplBugOff.inc}
function LongWordToFourChar(AValue : UInt32): string;
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := UInt32ToFourChar(AValue);
end;

procedure UInt16ToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  //ByteArray[Index] := AWord div 256;
  //ByteArray[Index + 1] := AWord mod 256;
  ByteArray[Index + 1] := AWord div 256;
  ByteArray[Index] := AWord mod 256;
end;

{$I IdDeprecatedImplBugOff.inc}
procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  UInt16ToTwoBytes(AWord, ByteArray, Index);
end;

function StrToWord(const Value: String): Word;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if Length(Value) > 1 then begin
    {$IFDEF STRING_IS_UNICODE}
    Result := TwoCharToUInt16(Value[1], Value[2]);
    {$ELSE}
    Result := PWord(Pointer(Value))^;
    {$ENDIF}
  end else begin
    Result := 0;
  end;
end;

function UInt16ToStr(const Value: Word): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  {$IFDEF STRING_IS_UNICODE}
  Result := BytesToStringRaw(ToBytes(Value));
  {$ELSE}
  SetLength(Result, SizeOf(Value));
  Move(Value, Result[1], SizeOf(Value));
  {$ENDIF}
end;

{$I IdDeprecatedImplBugOff.inc}
function WordToStr(const Value: Word): String;
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := UInt16ToStr(Value);
end;

function OrdFourByteToUInt32(AByte1, AByte2, AByte3, AByte4 : Byte): UInt32;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LValue: TIdBytes;
begin
  SetLength(LValue, SizeOf(UInt32));
  LValue[0] := AByte1;
  LValue[1] := AByte2;
  LValue[2] := AByte3;
  LValue[3] := AByte4;
  Result := BytesToUInt32(LValue);
end;

{$I IdDeprecatedImplBugOff.inc}
function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): UInt32;
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := OrdFourByteToUInt32(AByte1, AByte2, AByte3, AByte4);
end;

procedure UInt32ToOrdFourByte(const AValue: UInt32; var VByte1, VByte2, VByte3, VByte4 : Byte);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LValue: TIdBytes;
begin
  LValue := ToBytes(AValue);
  VByte1 := LValue[0];
  VByte2 := LValue[1];
  VByte3 := LValue[2];
  VByte4 := LValue[3];
end;

{$I IdDeprecatedImplBugOff.inc}
procedure LongWordToOrdFourByte(const AValue: UInt32; var VByte1, VByte2, VByte3, VByte4 : Byte);
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  UInt32ToOrdFourByte(AValue, VByte1, VByte2, VByte3, VByte4);
end;

function TwoCharToUInt16(AChar1, AChar2: Char): UInt16;
//Since Replys are returned as Strings, we need a rountime to convert two
// characters which are a 2 byte U Int into a two byte unsigned integer
var
  LWord: TIdBytes;
begin
  SetLength(LWord, SizeOf(UInt16));
  LWord[0] := Ord(AChar1);
  LWord[1] := Ord(AChar2);
  Result := BytesToUInt16(LWord);

//  Result := Word((Ord(AChar1) shl 8) and $FF00) or Word(Ord(AChar2) and $00FF);
end;

{$I IdDeprecatedImplBugOff.inc}
function TwoCharToWord(AChar1, AChar2: Char): Word;
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TwoCharToUInt16(AChar1, AChar2);
end;

function CompareDateTime(const ADateTime1, ADateTime2 : TDateTime) : Integer;
var
  LYear1, LYear2 : Word;
  LMonth1, LMonth2 : Word;
  LDay1, LDay2 : Word;
  LHour1, LHour2 : Word;
  LMin1, LMin2 : Word;
  LSec1, LSec2 : Word;
  LMSec1, LMSec2 : Word;
{
The return value is less than 0 if ADateTime1 is less than ADateTime2,
0 if ADateTime1 equals ADateTime2, or
greater than 0 if ADateTime1 is greater than ADateTime2.
}
begin
  DecodeDate(ADateTime1, LYear1, LMonth1, LDay1);
  DecodeDate(ADateTime2, LYear2, LMonth2, LDay2);
  // year
  Result := LYear1 - LYear2;
  if Result <> 0 then begin
    Exit;
  end;
  // month
  Result := LMonth1 - LMonth2;
  if Result <> 0 then begin
    Exit;
  end;
  // day
  Result := LDay1 - LDay2;
  if Result <> 0 then begin
    Exit;
  end;
  DecodeTime(ADateTime1, LHour1, LMin1, LSec1, LMSec1);
  DecodeTime(ADateTime2, LHour2, LMin2, LSec2, LMSec2);
  //hour
  Result := LHour1 - LHour2;
  if Result <> 0 then begin
    Exit;
  end;
  //minute
  Result := LMin1 - LMin2;
  if Result <> 0 then begin
    Exit;
  end;
  //second
  Result := LSec1 - LSec2;
  if Result <> 0 then begin
    Exit;
  end;
  //millasecond
  Result := LMSec1 - LMSec2;
end;

{This is an internal procedure so the StrInternetToDateTime and GMTToLocalDateTime can share common code}
function RawStrInternetToDateTime(var Value: string; var VDateTime: TDateTime): Boolean;
var
  i: Integer;
  Dt, Mo, Yr, Ho, Min, Sec, MSec: Word;
  sYear, sTime, sDelim: string;
  //flags for if AM/PM marker found
  LAM, LPM : Boolean;

  procedure ParseDayOfMonth;
  begin
    Dt :=  IndyStrToInt( Fetch(Value, sDelim), 1);
    Value := TrimLeft(Value);
  end;

  procedure ParseMonth;
  begin
    Mo := StrToMonth( Fetch (Value, sDelim)  );
    Value := TrimLeft(Value);
  end;

  function ParseISO8601: Boolean;
  var
    S: String;
    Len, Offset, Found: Integer;
  begin
    Result := False;

    // TODO: implement logic from IdVCard.ParseISO8601DateAndOrTime() here and then remove that function
    {
    var
      LDate: TIdISO8601DateComps;
      LTime: TIdISO8601TimeComps;
    begin
      Result := ParseISO8601DateAndOrTime(Value, LDate, LTime);
      if Result then begin
        VDateTime := EncodeDate(LDate.Year, LDate.Month, LDate.Day) + EncodeTime(LTime.Hour, LTime.Min, LTime.Sec, LTime.MSec);
        Value := LTime.UTFOffset;
      end;
    end;
    }

    S := Value;
    Len := Length(S);

    if not IsNumeric(S, 4) then begin
      Exit;
    end;

    // defaults for omitted values
    Dt := 1;
    Mo := 1;
    Ho := 0;
    Min := 0;
    Sec := 0;
    MSec := 0;

    Yr := IndyStrToInt( Copy(S, 1, 4) );
    Offset := 5;

    if Offset <= Len then
    begin
      if (not CharEquals(S, Offset, '-')) or (not IsNumeric(S, 2, Offset+1)) then begin
        Exit;
      end;
      Mo := IndyStrToInt( Copy(S, Offset+1, 2) );
      Inc(Offset, 3);

      if Offset <= Len then
      begin
        if (not CharEquals(S, Offset, '-')) or {Do not Localize}
           (not IsNumeric(S, 2, Offset+1)) then
        begin
          Exit;
        end;
        Dt := IndyStrToInt( Copy(S, Offset+1, 2) );
        Inc(Offset, 3);

        if Offset <= Len then
        begin
          if (not CharEquals(S, Offset, 'T')) or     {Do not Localize}
             (not IsNumeric(S, 2, Offset+1)) or
             (not CharEquals(S, Offset+3, ':')) then   {Do not Localize}
          begin
            Exit;
          end;
          Ho := IndyStrToInt( Copy(S, Offset+1, 2) );
          Inc(Offset, 4);

          if not IsNumeric(S, 2, Offset) then begin
            Exit;
          end;
          Min := IndyStrToInt( Copy(S, Offset, 2) );
          Inc(Offset, 2);

          if Offset > Len then begin
            Exit;
          end;

          if CharEquals(S, Offset, ':') then {Do not Localize}
          begin
            if not IsNumeric(S, 2, Offset+1) then begin
              Exit;
            end;
            Sec := IndyStrToInt( Copy(S, Offset+1, 2) );
            Inc(Offset, 3);

            if Offset > Len then begin
              Exit;
            end;

            if CharEquals(S, Offset, '.') then {Do not Localize}
            begin
              Found := FindFirstNotOf('0123456789', S, -1, Offset+1); {Do not Localize}
              if Found = 0 then begin
                Exit;
              end;
              MSec := IndyStrToInt( Copy(S, Offset+1, Found-Offset-1) );
              Inc(Offset, Found-Offset+1);
            end;
          end;
        end;
      end;
    end;

    VDateTime := EncodeDate(Yr, Mo, Dt) + EncodeTime(Ho, Min, Sec, MSec);
    Value := Copy(S, Offset, MaxInt);
    Result := True;
  end;

begin
  Result := False;
  VDateTime := 0.0;

  Value := Trim(Value);
  if Length(Value) = 0 then begin
    Exit;
  end;

  try
    // RLebeau: have noticed some HTTP servers deliver dates using ISO-8601
    // format even though this is in violation of the HTTP specs!
    if ParseISO8601 then begin
      Result := True;
      Exit;
    end;

    {Day of Week}
    if StrToDay(Copy(Value, 1, 3)) > 0 then begin
      //workaround in case a space is missing after the initial column
      if CharEquals(Value, 4, ',') and (not CharEquals(Value, 5, ' ')) then begin
        Insert(' ', Value, 5);
      end;
      Fetch(Value);
      Value := TrimLeft(Value);
    end;

    // Workaround for some buggy web servers which use '-' to separate the date parts.    {Do not Localize}
    i := IndyPos('-', Value);    {Do not Localize}
    if (i > 1) and (i < IndyPos(' ', Value)) then begin    {Do not Localize}
      sDelim := '-';    {Do not Localize}
    end else begin
      sDelim := ' ';    {Do not Localize}
    end;

    //workaround for improper dates such as 'Fri, Sep 7 2001'    {Do not Localize}
    //RFC 2822 states that they should be like 'Fri, 7 Sep 2001'    {Do not Localize}
    if StrToMonth(Fetch(Value, sDelim, False)) > 0 then begin
      {Month}
      ParseMonth;
      {Day of Month}
      ParseDayOfMonth;
    end else begin
      {Day of Month}
      ParseDayOfMonth;
      {Month}
      ParseMonth;
    end;

    {Year}
    // There is some strange date/time formats like
    // DayOfWeek Month DayOfMonth Time Year
    sYear := Fetch(Value);
    Yr := IndyStrToInt(sYear, High(Word));
    if Yr = High(Word) then begin // Is sTime valid Integer?
      sTime := sYear;
      sYear := Fetch(Value);
      Value := TrimRight(sTime + ' ' + Value);
      Yr := IndyStrToInt(sYear);
    end;

    // RLebeau: According to RFC 2822, Section 4.3:
    //
    // "Where a two or three digit year occurs in a date, the year is to be
    // interpreted as follows: If a two digit year is encountered whose
    // value is between 00 and 49, the year is interpreted by adding 2000,
    // ending up with a value between 2000 and 2049.  If a two digit year is
    // encountered with a value between 50 and 99, or any three digit year
    // is encountered, the year is interpreted by adding 1900."
    if Length(sYear) = 2 then begin
      if {(Yr >= 0) and} (Yr <= 49) then begin
        Inc(Yr, 2000);
      end
      else if (Yr >= 50) and (Yr <= 99) then begin
        Inc(Yr, 1900);
      end;
    end
    else if Length(sYear) = 3 then begin
      Inc(Yr, 1900);
    end;

    VDateTime := EncodeDate(Yr, Mo, Dt);

    // SG 26/9/00: Changed so that ANY time format is accepted
    if IndyPos('AM', Value) > 0 then begin{do not localize}
      LAM := True;
      LPM := False;
      Value := Fetch(Value, 'AM');  {do not localize}
    end
    else if IndyPos('PM', Value) > 0 then begin {do not localize}
      LAM := False;
      LPM := True;
      Value := Fetch(Value, 'PM');  {do not localize}
    end else begin
      LAM := False;
      LPM := False;
    end;

    // RLebeau 03/04/2009: some countries use dot instead of colon
    // for the time separator
    i := IndyPos('.', Value);       {do not localize}
    if (i > 0) and (i < IndyPos(' ', Value)) then begin       {do not localize}
      sDelim := '.';                {do not localize}
    end else begin
      sDelim := ':';                {do not localize}
    end;
    i := IndyPos(sDelim, Value);
    if i > 0 then begin
      // Copy time string up until next space (before GMT offset)
      sTime := Fetch(Value, ' ');  {do not localize}
      {Hour}
      Ho  := IndyStrToInt( Fetch(sTime, sDelim), 0);
      {Minute}
      Min := IndyStrToInt( Fetch(sTime, sDelim), 0);
      {Second}
      Sec := IndyStrToInt( Fetch(sTime), 0);
      MSec := 0; // TODO
      {AM/PM part if present}
      Value := TrimLeft(Value);
      if LAM then begin
        if Ho = 12 then begin
          Ho := 0;
        end;
      end
      else if LPM then begin
        //in the 12 hour format, afternoon is 12:00PM followed by 1:00PM
        //while midnight is written as 12:00 AM
        //Not exactly technically correct but pretty accurate
        if Ho < 12 then begin
          Inc(Ho, 12);
        end;
      end;
      {The date and time stamp returned}
      VDateTime := VDateTime + EncodeTime(Ho, Min, Sec, MSec);
    end;
    Value := TrimLeft(Value);
    Result := True;
  except
    VDateTime := 0.0;
    Result := False;
  end;
end;

{This should never be localized}

function StrInternetToDateTime(Value: string): TDateTime;
begin
  RawStrInternetToDateTime(Value, Result);
end;

function FTPMLSToGMTDateTime(const ATimeStamp : String):TDateTime;
var
  LYear, LMonth, LDay, LHour, LMin, LSec, LMSec : Integer;
  LBuffer : String;
begin
  Result := 0;
  LBuffer := ATimeStamp;
  if LBuffer <> '' then begin
  //  1234 56 78  90 12 34
  //  ---------- ---------
  //  1998 11 07  08 52 15
      LYear := IndyStrToInt( Copy( LBuffer,1,4),0);
      LMonth := IndyStrToInt(Copy(LBuffer,5,2),0);
      LDay := IndyStrToInt(Copy(LBuffer,7,2),0);

      LHour := IndyStrToInt(Copy(LBuffer,9,2),0);
      LMin := IndyStrToInt(Copy(LBuffer,11,2),0);
      LSec := IndyStrToInt(Copy(LBuffer,13,2),0);
      Fetch(LBuffer,'.');
      LMSec := IndyStrToInt(LBuffer,0);
      Result := EncodeDate(LYear,LMonth,LDay);
      Result := Result + EncodeTime(LHour,LMin,LSec,LMSec);
  end;
end;

function FTPMLSToLocalDateTime(const ATimeStamp : String):TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := 0.0;
  if ATimeStamp <> '' then begin
    Result := FTPMLSToGMTDateTime(ATimeStamp);
    // Apply local offset
    Result := UTCTimeToLocalTime(Result);
  end;
end;

function FTPGMTDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
var
  LYear, LMonth, LDay,
  LHour, LMin, LSec, LMSec : Word;
begin
  DecodeDate(ATimeStamp,LYear,LMonth,LDay);
  DecodeTime(ATimeStamp,LHour,LMin,LSec,LMSec);
  Result := IndyFormat('%4d%2d%2d%2d%2d%2d',[LYear,LMonth,LDay,LHour,LMin,LSec]);
  if AIncludeMSecs then begin
    if (LMSec <> 0) then begin
      Result := Result + IndyFormat('.%3d',[LMSec]);
    end;
  end;
  Result := ReplaceAll(Result, ' ', '0');
end;
{
Note that MS-DOS displays the time in the Local Time Zone - MLISx commands use
stamps based on GMT)
}
function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := FTPGMTDateTimeToMLS(LocalTimeToUTCTime(ATimeStamp), AIncludeMSecs);
end;


function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
var
  EndOfCurrentString: integer;
begin
  // TODO: use SplitDelimitedString() instead?
  // SplitDelimitedString(BaseString, StringList, False, BreakString);
  repeat
    EndOfCurrentString := Pos(BreakString, BaseString);
    if EndOfCurrentString = 0 then begin
      StringList.Add(BaseString);
      Break;
    end;
    StringList.Add(Copy(BaseString, 1, EndOfCurrentString - 1));
    Delete(BaseString, 1, EndOfCurrentString + Length(BreakString) - 1); //Copy(BaseString, EndOfCurrentString + length(BreakString), length(BaseString) - EndOfCurrentString);
  until False;
  Result := StringList;
end;

procedure CommaSeparatedToStringList(AList: TStrings; const Value: string);
var
  iStart,
  iEnd,
  iQuote,
  iPos,
  iLength : integer ;
  sTemp : string ;
begin
  iQuote := 0;
  iPos := 1 ;
  iLength := Length(Value);
  AList.Clear ;
  while iPos <= iLength do begin
    iStart := iPos ;
    iEnd := iStart ;
    while iPos <= iLength do begin
      if Value[iPos] = '"' then begin {do not localize}
        Inc(iQuote);
      end;
      if Value[iPos] = ',' then begin {do not localize}
        if iQuote <> 1 then begin
          Break;
        end;
      end;
      Inc(iEnd);
      Inc(iPos);
    end ;
    sTemp := Trim(Copy(Value, iStart, iEnd - iStart));
    if Length(sTemp) > 0 then begin
      AList.Add(sTemp);
    end;
    iPos := iEnd + 1 ;
    iQuote := 0 ;
  end ;
end;

{$UNDEF NATIVEFILEAPI}
{$UNDEF NATIVECOPYAPI}
{$IFDEF DOTNET}
  {$DEFINE NATIVEFILEAPI}
  {$DEFINE NATIVECOPYAPI}
{$ENDIF}
{$IFDEF WINDOWS}
  {$DEFINE NATIVEFILEAPI}
  {$DEFINE NATIVECOPYAPI}
{$ENDIF}
{$IFDEF UNIX}
  {$DEFINE NATIVEFILEAPI}
{$ENDIF}

function CopyFileTo(const Source, Destination: TIdFileName): Boolean;
{$IFDEF NATIVECOPYAPI}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
  {$IFDEF WIN32_OR_WIN64}
var
  LOldErrorMode : Integer;
  {$ENDIF}
{$ELSE}
var
  SourceF, DestF : File;
  NumRead, NumWritten: Integer;
  Buffer: array[1..2048] of Byte;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  try
    System.IO.File.Copy(Source, Destination, True);
    Result := True; // or you'll get an exception
  except
    Result := False;
  end;
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFDEF WIN32_OR_WIN64}
  // TODO: use SetThreadErrorMode() instead, when available...
  LOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    {$ENDIF}
    Result := CopyFile(PIdFileNameChar(Source), PIdFileNameChar(Destination), False);
    {$IFDEF WIN32_OR_WIN64}
  finally
    SetErrorMode(LOldErrorMode);
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFNDEF NATIVECOPYAPI}
  //mostly from  http://delphi.about.com/od/fileio/a/untypedfiles.htm

  //note that I do use the I+ and I- directive.
  // decided not to use streams because some may not handle more than
  // 2GB'sand it would run counter to the intent of this, return false
  //on failure.

  //This is intended to be generic because it may run in many different
  //Operating systems

  // -TODO: Change to use a Linux copy function
  // There is no native Linux copy function (at least "cp" doesn't use one
  // and I can't find one anywhere (Johannes Berg))
  
  {$I IdIOChecksOff.inc}

  Assign(SourceF, Source);
  Reset(SourceF, 1);
  Result := IOResult = 0;
  if not Result then begin
    Exit;
  end;
  Assign(DestF, Destination);
  Rewrite(DestF, 1);
  Result := IOResult = 0;
  if Result then begin
    repeat
      BlockRead(SourceF, Buffer, SizeOf(Buffer), NumRead);
      Result := IOResult = 0;
      if (not Result) or (NumRead = 0) then begin
        Break;
      end;
      BlockWrite(DestF, Buffer, NumRead, NumWritten);
      Result := (IOResult = 0) and (NumWritten = NumRead);
    until not Result;
    Close(DestF);
  end;
  Close(SourceF);

  // Restore IO checking
  {$I IdIOChecksOn.inc}

  {$ENDIF}
end;

{$IFDEF WINDOWS}
function TempPath: TIdFileName;
var
  i: Integer;
begin
  SetLength(Result, MAX_PATH);
  i := GetTempPath(MAX_PATH, PIdFileNameChar(Result));
  if i > 0 then begin
    SetLength(Result, i);
    Result := IndyIncludeTrailingPathDelimiter(Result);
  end else begin
    Result := '';
  end;
end;
{$ENDIF}

function MakeTempFilename(const APath: TIdFileName = ''): TIdFileName;
{$IFNDEF FPC}
var
  lPath: TIdFileName;
  lExt: TIdFileName;
{$ENDIF}
begin
  {$IFDEF FPC}

  //Do not use Tempnam in Unix-like Operating systems.  That function is dangerous
  //and you will be warned about it when compiling.  FreePascal has GetTempFileName.  Use
  //that instead.
  Result := GetTempFileName(APath, 'Indy'); {Do not Localize}

  {$ELSE}

  // NOT using TPath.GetTempFileName() in Delphi 2010+, or System.IO.Path.GetTempFileName()
  // on .NET.  They force use of the system temp path instead of allowing APath, and they
  // do not support custom file prefixes...

  lPath := APath;
  lExt := {$IFDEF UNIX}''{$ELSE}'.tmp'{$ENDIF}; {Do not Localize}

  {$IFDEF WINDOWS}
  if lPath = '' then begin
    // TODO: query this dynamically, in case the user changes the path after this unit
    // is initialized. This is the only spot where GTempPath is used...
    lPath := GTempPath;
  end;
  {$ELSE}
    {$IFDEF DOTNET}
  if lPath = '' then begin
    lPath := System.IO.Path.GetTempPath;
  end;
    {$ELSE}
      {$IFDEF HAS_IOUtils_TPath}
  if lPath = '' then begin
    lPath := {$IFDEF VCL_XE2_OR_ABOVE}System.{$ENDIF}IOUtils.TPath.GetTempPath;
  end;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}

  Result := GetUniqueFilename(lPath, 'Indy', lExt);

  {$ENDIF}
end;


function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
var
{$IFDEF FPC}
  LPrefix: string;
{$ELSE}
  LTicks : TIdTicks;
  LNamePart : Int64;
  LExt : String;
  LFName: String;
{$ENDIF}
begin
  {$IFDEF FPC}

  //Do not use Tempnam in Unix-like Operating systems.  That function is dangerous
  //and you will be warned about it when compiling.  FreePascal has GetTempFileName.  Use
  //that instead.
  LPrefix := APrefix;
  if LPrefix = '' then begin
    LPrefix := 'Indy'; {Do not localize}
  end;
  Result := GetTempFileName(APath, LPrefix);

  {$ELSE}

  // NOT using TPath.GetTempFileName() in Delphi 2010+, or System.IO.Path.GetTempFileName()
  // on .NET.  They force use of the system temp path instead of allowing APath, and they
  // do not support custom file prefixes...

  // TODO: on Windows, use Winapi.GetTempFileName(), at least...

  LExt := AExt;

  // period is optional in the extension... force it
  if LExt <> '' then begin
    if LExt[1] <> '.' then begin
      LExt := '.' + LExt;
    end;
  end;

  // validate path and add path delimiter before file name prefix
  if APath <> '' then begin
    if not IndyDirectoryExists(APath) then begin
      // TODO: fail with an error instead...
      LFName := APrefix;
    end else begin
      // uses the Indy function... not the Borland one
      LFName := IndyIncludeTrailingPathDelimiter(APath) + APrefix;
    end;
  end else begin
    // TODO: without a starting path, we cannot check for file existance, so fail...
    LFName := APrefix;
  end;

  // TODO: use a GUID instead of ticks on platforms that support that...

  LTicks := Ticks64;
  // RLebeau 6/20/2017: casting to TIdTicks to address a compiler bug in Delphi 7
  if LTicks > TIdTicks(High(Int64)) then begin
    LTicks := TIdTicks(High(Int64));
  end;

  LNamePart := Int64(LTicks);
  repeat
    Result := LFName + IntToHex(LNamePart, 8) + LExt;
    if not FileExists(Result) then begin
      Break;
    end;
    if LNamePart = High(Int64) then begin
      LNamePart := 0; // wrap to zero, not negative
    end else begin;
      Inc(LNamePart);
    end;
    // TODO: if we wrap all the way back around to the starting value, fail with an error...
  until False;

  {$ENDIF}
end;

// Find a token given a direction (>= 0 from start; < 0 from end)
// S.G. 19/4/00:
//  Changed to be more readable
// TODO: make this faster
function RPos(const ASub, AIn: String; AStart: Integer = -1): Integer;
var
  i: Integer;
  LStartPos: Integer;
  LTokenLen: Integer;
begin
  Result := 0;
  LTokenLen := Length(ASub);
  // Get starting position
  if AStart < 0 then begin
    AStart := Length(AIn);
  end;
  if AStart < (Length(AIn) - LTokenLen + 1) then begin
    LStartPos := AStart;
  end else begin
    LStartPos := (Length(AIn) - LTokenLen + 1);
  end;
  // Search for the string
  for i := LStartPos downto 1 do begin
    // TODO: remove the need for Copy()
    if TextIsSame(Copy(AIn, i, LTokenLen), ASub) then begin
      Result := i;
      Break;
    end;
  end;
end;

{$IFDEF WINDOWS}
function IsVolume(const APathName : TIdFileName) : Boolean;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := TextEndsWith(APathName, ':') or TextEndsWith(APathName, ':\');
end;
{$ENDIF}

// OS-independant version
function FileSizeByName(const AFilename: TIdFileName): Int64;
//Leave in for HTTP Server
{$IFDEF DOTNET}
var
  LFile : System.IO.FileInfo;
{$ELSE}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
  {$IFDEF WINDOWS}
var
  LHandle : THandle;
  LRec : TWin32FindData;
    {$IFDEF WIN32_OR_WIN64}
  LOldErrorMode : Integer;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF UNIX}
var
    {$IFDEF USE_VCL_POSIX}
  LRec : _Stat;
      {$IFDEF USE_MARSHALLED_PTRS}
  M: TMarshaller;
      {$ENDIF}
    {$ELSE}
      {$IFDEF KYLIXCOMPAT}
  LRec : TStatBuf;
      {$ELSE}
  LRec : TStat;
  LU : time_t;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFNDEF NATIVEFILEAPI}
var
  LStream: TIdReadFileExclusiveStream;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := -1;
  LFile := System.IO.FileInfo.Create(AFileName);
  if LFile.Exists then begin
    Result := LFile.Length;
  end;
  {$ENDIF}
  {$IFDEF WINDOWS}
  Result := -1;
  //check to see if something like "a:\" is specified and fail in that case.
  //FindFirstFile would probably succede even though a drive is not a proper
  //file.
  if not IsVolume(AFileName) then begin
    {
    IMPORTANT!!!

    For servers in Windows, you probably want the API call to fail rather than
    get a "Cancel   Try Again   Continue " dialog-box box if a drive is not
    ready or there's some other critical I/O error.
    }
    {$IFDEF WIN32_OR_WIN64}
    // TODO: use SetThreadErrorMode() instead, when available...
    LOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
    {$ENDIF}
      // TODO: use GetFileAttributesEx(GetFileExInfoStandard) if available...
      LHandle := Windows.FindFirstFile(PIdFileNameChar(AFileName), LRec);
      if LHandle <> INVALID_HANDLE_VALUE then begin
        Windows.FindClose(LHandle);
        if (LRec.dwFileAttributes and Windows.FILE_ATTRIBUTE_DIRECTORY) = 0 then begin
          // TODO: use ULARGE_INTEGER instead...
          Result := (Int64(LRec.nFileSizeHigh) shl 32) + LRec.nFileSizeLow;
        end;
      end;
    {$IFDEF WIN32_OR_WIN64}
    finally
      SetErrorMode(LOldErrorMode);
    end;
    {$ENDIF}
  end;
  {$ENDIF}
  {$IFDEF UNIX}
  Result := -1;
    {$IFDEF USE_VCL_POSIX}
  //This is messy with IFDEF's but I want to be able to handle 63 bit file sizes.
  if stat(
      {$IFDEF USE_MARSHALLED_PTRS}
    M.AsAnsi(AFileName).ToPointer
      {$ELSE}
    PAnsiChar(
        {$IFDEF STRING_IS_ANSI}
      AFileName
        {$ELSE}
      AnsiString(AFileName) // explicit convert to Ansi
        {$ENDIF}
    )
      {$ENDIF}
    , LRec) = 0 then
  begin
    Result := LRec.st_size;
  end;
    {$ELSE}
  //Note that we can use stat here because we are only looking at the date.
  if {$IFDEF KYLIXCOMPAT}stat{$ELSE}fpstat{$ENDIF}(
    PAnsiChar(
      {$IFDEF STRING_IS_ANSI}
      AFileName
      {$ELSE}
      AnsiString(AFileName) // explicit convert to Ansi
      {$ENDIF}
    ), LRec) = 0 then
  begin
    Result := LRec.st_Size;
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFNDEF NATIVEFILEAPI}
  Result := -1;
  if FileExists(AFilename) then begin
    // the other cases simply return -1 on error, so make sure to do the same here
    try
      // TODO: maybe use TIdReadFileNonExclusiveStream instead?
      LStream := TIdReadFileExclusiveStream.Create(AFilename);
      try
        Result := LStream.Size;
      finally
        LStream.Free;
      end;
    except
    end;
  end;
  {$ENDIF}
end;

function GetGMTDateByName(const AFileName : TIdFileName) : TDateTime;
{$IFDEF WINDOWS}
var
  LRec : TWin32FindData;
  LHandle : THandle;
  LTime : {$IFDEF WINCE}TSystemTime{$ELSE}Integer{$ENDIF};
  {$IFDEF WIN32_OR_WIN64}
  LOldErrorMode : Integer;
  {$ENDIF}
{$ELSE}
  {$IFDEF UNIX}
var
  LTime : Integer;
    {$IFDEF USE_VCL_POSIX}
  LRec : _Stat;
      {$IFDEF USE_MARSHALLED_PTRS}
  M: TMarshaller;
      {$ENDIF}
    {$ELSE}
      {$IFDEF KYLIXCOMPAT}
  LRec : TStatBuf;
  LU : TUnixTime;
      {$ELSE}
        {$IFDEF USE_BASEUNIX}
  LRec : TStat;
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  Result := -1;

  {$IFDEF DOTNET}
  if System.IO.File.Exists(AFileName) then begin
    Result := System.IO.File.GetLastWriteTimeUtc(AFileName).ToOADate;
  end;

  {$ELSE}
    {$IFDEF WINDOWS}

  if not IsVolume(AFileName) then begin
      {$IFDEF WIN32_OR_WIN64}
    // TODO: use SetThreadErrorMode() instead, when available...
    LOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
      {$ENDIF}
      // TODO: use GetFileAttributesEx() on systems that support it
      LHandle := Windows.FindFirstFile(PIdFileNameChar(AFileName), LRec);
      {$IFDEF WIN32_OR_WIN64}
    finally
      SetErrorMode(LOldErrorMode);
    end;
      {$ENDIF}
    if LHandle <> INVALID_HANDLE_VALUE then begin
      Windows.FindClose(LHandle);
      {$IFDEF WINCE}
      FileTimeToSystemTime(@LRec, @LTime);
      Result := SystemTimeToDateTime(LTime);
      {$ELSE}
      FileTimeToDosDateTime(LRec.ftLastWriteTime, LongRec(LTime).Hi, LongRec(LTime).Lo);
      Result := FileDateToDateTime(LTime);
      {$ENDIF}
    end;
  end;

    {$ELSE}
      {$IFDEF UNIX}

  //Note that we can use stat here because we are only looking at the date.
  {$IFDEF USE_VCL_POSIX}
  if stat(
    {$IFDEF USE_MARSHALLED_PTRS}
    M.AsAnsi(AFileName).ToPointer
    {$ELSE}
    PAnsiChar(
      {$IFDEF STRING_IS_ANSI}
      AFileName
      {$ELSE}
      AnsiString(AFileName) // explicit convert to Ansi
      {$ENDIF}
    )
    {$ENDIF}
    , LRec) = 0 then
  begin
    LTime := LRec.st_mtime;
    Result := DateUtils.UnixToDateTime(LTime);
  end;
  {$ELSE}
    {$IFDEF KYLIXCOMPAT}
  if stat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then
  begin
    gmtime_r(@LTime, LU);
    Result := EncodeDate(LU.tm_year + 1900, LU.tm_mon + 1, LU.tm_mday) +
              EncodeTime(LU.tm_hour, LU.tm_min, LU.tm_sec, 0);
  end;
    {$ELSE}
      {$IFDEF USE_BASEUNIX}
  if fpstat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then
  begin
    LTime := LRec.st_mtime;
    Result := UnixToDateTime(LTime);
  end;
      {$ELSE}
        {$message error stat is not called on this platform!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}

      {$ELSE}
        {$message error GetGMTDateByName is not implemented on this platform!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function RightStr(const AStr: String; const Len: Integer): String;
var
  LStrLen : Integer;
begin
  LStrLen := Length(AStr);
  if (Len > LStrLen) or (Len < 0) then begin
    Result := AStr;
  end else begin
    //+1 is necessary for the Index because it is one based
    Result := Copy(AStr, LStrLen - Len+1, Len);
  end;
end;

{$I IdDeprecatedImplBugOff.inc}
function TimeZoneBias: TDateTime;
{$I IdDeprecatedImplBugOn.inc}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := -OffsetFromUTC;
end;

function IndyStrToBool(const AString : String) : Boolean;
begin
  // First check against each of the elements of the FalseBoolStrs
  if PosInStrArray(AString, IndyFalseBoolStrs, False) <> -1 then begin
    Result := False;
    Exit;
  end;
  // Second check against each of the elements of the TrueBoolStrs
  if PosInStrArray(AString, IndyTrueBoolStrs, False) <> -1 then begin
    Result := True;
    Exit;
  end;
  // None of the strings match, so convert to numeric (allowing an
  // EConvertException to be thrown if not) and test against zero.
  // If zero, return false, otherwise return true.
  Result := IndyStrToInt(AString) <> 0;
end;

function IndySetLocalTime(Value: TDateTime): Boolean;
{$IFNDEF WINDOWS}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  dSysTime: TSystemTime;
  buffer: DWord;
  tkp, tpko: TTokenPrivileges;
  hToken: THandle;
{$ENDIF}
begin
  Result := False;

  {$IFDEF LINUX}
  //TODO: Implement SetTime for Linux. This call is not critical.
  {$ENDIF}

  {$IFDEF DOTNET}
  //TODO: Figure out how to do this
  {$ENDIF}

  {$IFDEF WINDOWS}
  {I admit that this routine is a little more complicated than the one
  in Indy 8.0.  However, this routine does support Windows NT privileges
  meaning it will work if you have administrative rights under that OS

  Original author Kerry G. Neighbour with modifications and testing
  from J. Peter Mugaas}
    {$IFNDEF WINCE}
  // RLebeau 2/1/2008: MSDN says that SetLocalTime() does the adjustment
  // automatically, so why is it being done manually?
  if IndyWindowsPlatform = VER_PLATFORM_WIN32_NT then begin
    if not Windows.OpenProcessToken(Windows.GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then begin
      Exit;
    end;
    if not Windows.LookupPrivilegeValue(nil, 'SeSystemtimePrivilege', tkp.Privileges[0].Luid) then begin    {Do not Localize}
      Windows.CloseHandle(hToken);
      Exit;
    end;
    tkp.PrivilegeCount := 1;
    tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    if not Windows.AdjustTokenPrivileges(hToken, FALSE, tkp, SizeOf(tkp), tpko, buffer) then begin
      Windows.CloseHandle(hToken);
      Exit;
    end;
  end;
    {$ENDIF}

  DateTimeToSystemTime(Value, dSysTime);
  Result := Windows.SetLocalTime({$IFDEF FPC}@{$ENDIF}dSysTime);

    {$IFNDEF WINCE}
  if Result then begin
    // RLebeau 2/1/2008: According to MSDN:
    //
    // "The system uses UTC internally. Therefore, when you call SetLocalTime(),
    // the system uses the current time zone information to perform the conversion,
    // including the daylight saving time setting. Note that the system uses the
    // daylight saving time setting of the current time, not the new time you are
    // setting. Therefore, to ensure the correct result, call SetLocalTime() a
    // second time, now that the first call has updated the daylight saving time
    // setting."
    //
    // TODO: adjust the Time manually so only 1 call to SetLocalTime() is needed...

    if IndyWindowsPlatform = VER_PLATFORM_WIN32_NT then begin
      Windows.SetLocalTime({$IFDEF FPC}@{$ENDIF}dSysTime);
      // Windows 2000+ will broadcast WM_TIMECHANGE automatically...
      if not IndyCheckWindowsVersion(5) then begin // Windows 2000 = v5.0
        SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);
      end;
    end else begin
      SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);
    end;
  end;

  {Undo the Process Privilege change we had done for the
  set time and close the handle that was allocated}
  if IndyWindowsPlatform = VER_PLATFORM_WIN32_NT then begin
    Windows.AdjustTokenPrivileges(hToken, False, tpko, SizeOf(tpko), tkp, Buffer);
    Windows.CloseHandle(hToken);
  end;
    {$ENDIF}
  {$ENDIF}
end;

function StrToDay(const ADay: string): Byte;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // RLebeau 03/04/2009: TODO - support localized strings as well...
  Result := Succ(
    PosInStrArray(ADay,
      ['SUN','MON','TUE','WED','THU','FRI','SAT'], {do not localize}
      False));
end;

function StrToMonth(const AMonth: string): Byte;
const
  // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...

  // RLebeau 3/12/2018: adding full-length month names.

  // duplicate values shared by multiple languages are not duplicated in the array
  Months: array[0..14] of array[1..12] of string = (

    // English
    ('JAN',     'FEB',      'MAR',   'APR',   'MAY', 'JUN',  'JUL',  'AUG',    'SEP',       'OCT',     'NOV',      'DEC'),
    ('JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', '',    'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'),
    ('',        '',         '',      '',      '',    '',     '',     '',       'SEPT',      '',        '',         ''),

    // German
    ('J'+Char($C4)+'N', '',        'MRZ',              '', 'MAI', 'JUNI', 'JULI', '', '', 'OKT',     '', 'DEZ'),
    ('JANUAR',          'FEBRUAR', 'M'+Char($C4)+'RZ', '', 'MAI', '',     '',     '', '', 'OKTOBER', '', 'DEZEMBER'),

    // Spanish
    ('ENO',   'FBRO',   'MZO',   'ABR',   '',     '',      '',      'AGTO',   'SBRE',       'OBRE',    'NBRE',      'DBRE'),
    ('ENERO', 'FBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'),
    ('',      '',       '',      'AB',    '',     '',      '',      '',       'SET',        '',        '',          'DIC'),

    // Dutch
    ('',        '',         'MRT',   '', '',    '',  '', '',         '', '', '', ''),
    ('JANUARI', 'FEBRUARI', 'MAART', '', 'MEI', '',  '', 'AUGUSTUS', '', '', '', ''),

    // French
    ('JANV',    'F'+Char($C9)+'V',     '',     'AVR',   '', '',     'JUIL',    'AO'+Char($DB),     '',          '',        '',         'D'+Char($C9)+'C'),
    ('JANVIER', 'F'+Char($C9)+'VRIER', 'MARS', 'AVRIL', '', 'JUIN', 'JUILLET', 'AO'+Char($DB)+'T', 'SEPTEMBRE', 'OCTOBRE', 'NOVEMBRE', 'D'+Char($C9)+'CEMBRE'),
    ('',        'F'+Char($C9)+'VR',    '',     '',      '', '',     'JUI',     '',                 '',          '',        '',         ''),

    // Slovenian
    ('', '', '',      '', '',    '',      '',      'AVG',    '', '', '', ''),
    ('', '', 'MAREC', '', 'MAJ', 'JUNJI', 'JULIJ', 'AVGUST', '', '', '', ''));
var
  i, j: Integer;
begin
  Result := 0;
  if AMonth = '' then begin
    Exit;
  end;
  for i := Low(Months) to High(Months) do begin
    for j := Low(Months[i]) to High(Months[i]) do begin
      if Months[i][j] <> '' then begin
        if TextIsSame(AMonth, Months[i][j]) then begin
          Result := j;
          Exit;
        end;
      end;
    end;
  end;
end;

// TODO: use this instead?
{
function StrToMonth(const AMonth: string): Byte;
const
  Months: array[1..12] of array[0..9] of string = (
    ('JAN', 'JANUARY', 'JANUAR', 'ENERO', 'ENO', 'JANUARI', 'JANVIER', 'JANV', '', ''),
    ('FEB', 'FEBRUARY', 'FEBRUAR'. 'FBRERO', 'FBRO', 'FEBRUARI', 'F'+Char($C9)+'VRIER', 'F'+Char($C9)+'V', 'F'+Char($C9)+'VR', ''),
    ('MAR', 'MARCH', 'M'+Char($C4)+'RZ', 'MRZ', 'MARZO', 'MZO', 'MAART', 'MRT', 'MARS', 'MAJ'),
    ('APR', 'APRIL', 'ABRIL', 'ABR', 'AB', 'AVRIL', 'AVR', '', '', ''),
    ('MAY', 'MAI', 'MAYO', 'MEI', 'MAJ', '', '', '', '', ''),
    ('JUN', 'JUNE', 'JUNI', 'JUNIO', 'JUIN', 'JUNJI', '', '', '', ''),
    ('JUL', 'JULY', 'JULI', 'JULIO', 'JUILLET', 'JUIL', 'JUI', 'JULIJ', '', ''),
    ('AUG', 'AUGUST', 'AGOSTO', 'AGTO', 'AUGUSTUS', 'AO'+Char($DB)+'T', 'AO'+Char($DB), 'AVGUST', 'AVG', ''),
    ('SEP', 'SEPTEMBER', 'SEPT', 'SEPTIEMBRE', 'SBRE', 'SET', 'SEPTEMBRE', '', '', ''),
    ('OCT', 'OCTOBER', 'OKTOBER', 'OKT', 'OCTUBRE', 'OBRE', 'OCTOBRE', '', '', ''),
    ('NOV', 'NOVEMBER', 'NOVIEMBRE', 'NBRE', 'NOVEMBRE', '', '', '', '', ''),
    ('DEC', 'DECEMBER', 'DEZEMBER', 'DEZ', 'DICIEMBRE', 'DBRE', 'DIC', 'D'+Char($C9)+'CEMBRE', 'D'+Char($C9)+'C', ''));
var
  i, j: Integer;
begin
  Result := 0;
  if AMonth = '' then begin
    Exit;
  end;
  case AMonth[0] of
    'J', 'j': begin
      if PosInStrArray(AMonth, Months[1], False) <> -1 then begin
        Result := 1;
      end;
      if PosInStrArray(AMonth, Months[6], False) <> -1 then begin
        Result := 6;
      end;
      if PosInStrArray(AMonth, Months[7], False) <> -1 then begin
        Result := 7;
      end;
    end;
    'E', 'e': begin
      if PosInStrArray(AMonth, Months[1], False) <> -1 then begin
        Result := 1;
      end;
    end;
    'F', 'f': begin
      if PosInStrArray(AMonth, Months[2], False) <> -1 then begin
        Result := 2;
      end;
    end;
    'M', 'm': begin
      if PosInStrArray(AMonth, Months[3], False) <> -1 then begin
        Result := 3;
      end;
      if PosInStrArray(AMonth, Months[5], False) <> -1 then begin
        Result := 5;
      end;
    end;
    'A', 'a': begin
      if PosInStrArray(AMonth, Months[4], False) <> -1 then begin
        Result := 4;
      end;
      if PosInStrArray(AMonth, Months[8], False) <> -1 then begin
        Result := 8;
      end;
    end;
    'S', 's': begin
      if PosInStrArray(AMonth, Months[9], False) <> -1 then begin
        Result := 4;
      end;
    end;
    'O', 'o': begin
      if PosInStrArray(AMonth, Months[10], False) <> -1 then begin
        Result := 10;
      end;
    end;
    'N', 'n': begin
      if PosInStrArray(AMonth, Months[11], False) <> -1 then begin
        Result := 11;
      end;
    end;
    'D', 'd': begin
      if PosInStrArray(AMonth, Months[12], False) <> -1 then begin
        Result := 12;
      end;
    end;
  end;
end;
}

function UpCaseFirst(const AStr: string): string;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{$IFDEF STRING_IS_IMMUTABLE}
var
  LSB: TIdStringBuilder;
{$ENDIF}
begin
  // TODO: support Unicode surrogates in the first position?
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(LowerCase(TrimLeft(AStr)));
  if LSB.Length > 0 then begin   {Do not Localize}
    LSB[0] := UpCase(LSB[0]);
  end;
  Result := LSB.ToString;
  {$ELSE}
  Result := LowerCase(TrimLeft(AStr));
  if Result <> '' then begin   {Do not Localize}
    Result[1] := UpCase(Result[1]);
  end;
  {$ENDIF}
end;

function UpCaseFirstWord(const AStr: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(AStr) do begin
    if CharIsInSet(AStr, I, LWS) then begin
      if I > 1 then begin
        Result := UpperCase(Copy(AStr, 1, I-1)) + Copy(AStr, I, MaxInt);
        Exit;
      end;
      Break;
    end;
  end;
  Result := UpperCase(AStr);
end;

function IsHex(const AChar : Char) : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IndyPos(UpperCase(AChar), HexNumbers) > 0;
end;

function IsBinary(const AChar : Char) : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IndyPos(UpperCase(AChar), BinNumbers) > 0;
end;

function BinStrToInt(const ABinary: String): Integer;
var
  I: Integer;
//From: http://www.experts-exchange.com/Programming/Programming_Languages/Delphi/Q_20622755.html
begin
  Result := 0;
  for I := 1 to Length(ABinary) do begin
    Result := Result shl 1 or (Byte(ABinary[I]) and 1);
  end;
end;

function ABNFToText(const AText : String) : String;
type
  TIdRuleMode = (data, rule, decimal, hex, binary);
var
  i : Integer;
  LR : TIdRuleMode;
  LNum : String;
begin
  LR := data;
  Result := '';
  for i := 1 to Length(AText) do begin
    case LR of
      data :
        if (AText[i] = '%') and (i < Length(AText)) then begin
          LR := rule;
        end else begin
          Result := Result + AText[i];
        end;
      rule :
        case AText[i] of
          'd','D' : LR := decimal;
          'x','X' : LR := hex;
          'b','B' : LR := binary;
        else
          begin
            LR := data;
            Result := Result + '%';
          end;
        end;
      decimal :
        If IsNumeric(AText[i]) then begin
          LNum := LNum + AText[i];
          if IndyStrToInt(LNum, 0) > $FF then begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(IndyStrToInt(LNum, 0));
            LR := Data;
            Result := Result + AText[i];
          end;
        end else begin
          Result := Result + Char(IndyStrToInt(LNum, 0));
          LNum := '';
          if AText[i] <> '.' then begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
      hex :
        If IsHex(AText[i]) and (Length(LNum) < 2) then begin
          LNum := LNum + AText[i];
          if IndyStrToInt('$'+LNum, 0) > $FF  then begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(IndyStrToInt(LNum,0));
            LR := Data;
            Result := Result + AText[i];
          end;
        end else begin
          Result := Result + Char(IndyStrToInt('$'+LNum, 0));
          LNum := '';
          if AText[i] <> '.' then begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
    binary :
        If IsBinary(AText[i]) and (Length(LNum)<8) then begin
          LNum := LNum + AText[i];
          if (BinStrToInt(LNum)>$FF) then begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(BinStrToInt(LNum));
            LR := Data;
            Result := Result + AText[i];
          end;
        end else begin
          Result := Result + Char(IndyStrToInt('$'+LNum, 0));
          LNum := '';
          if AText[i] <> '.' then begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
    end;
  end;
end;

function GetMIMETypeFromFile(const AFile: TIdFileName): string;
var
  MIMEMap: TIdMIMETable;
begin
  MIMEMap := TIdMimeTable.Create(True);
  try
    Result := MIMEMap.GetFileMIMEType(AFile);
  finally
    MIMEMap.Free;
  end;
end;

function GetMIMEDefaultFileExt(const MIMEType: string): TIdFileName;
var
  MIMEMap: TIdMIMETable;
begin
  MIMEMap := TIdMimeTable.Create(True);
  try
    Result := MIMEMap.GetDefaultFileExt(MIMEType);
  finally
    MIMEMap.Free;
  end;
end;

// RLebeau: According to RFC 2822 Section 4.3:
//
// In the obsolete time zone, "UT" and "GMT" are indications of
// "Universal Time" and "Greenwich Mean Time" respectively and are both
// semantically identical to "+0000".
//
// The remaining three character zones are the US time zones.  The first
// letter, "E", "C", "M", or "P" stands for "Eastern", "Central",
// "Mountain" and "Pacific".  The second letter is either "S" for
// "Standard" time, or "D" for "Daylight" (or summer) time.  Their
// interpretations are as follows:
//
// EDT is semantically equivalent to -0400
// EST is semantically equivalent to -0500
// CDT is semantically equivalent to -0500
// CST is semantically equivalent to -0600
// MDT is semantically equivalent to -0600
// MST is semantically equivalent to -0700
// PDT is semantically equivalent to -0700
// PST is semantically equivalent to -0800
//
// The 1 character military time zones were defined in a non-standard
// way in [RFC822] and are therefore unpredictable in their meaning.
// The original definitions of the military zones "A" through "I" are
// equivalent to "+0100" through "+0900" respectively; "K", "L", and "M"
// are equivalent to  "+1000", "+1100", and "+1200" respectively; "N"
// through "Y" are equivalent to "-0100" through "-1200" respectively;
// and "Z" is equivalent to "+0000".  However, because of the error in
// [RFC822], they SHOULD all be considered equivalent to "-0000" unless
// there is out-of-band information confirming their meaning.
//
// Other multi-character (usually between 3 and 5) alphabetic time zones
// have been used in Internet messages.  Any such time zone whose
// meaning is not known SHOULD be considered equivalent to "-0000"
// unless there is out-of-band information confirming their meaning.

// RLebeau: according to http://en.wikipedia.org/wiki/Central_European_Time:
//
// Central European Time (CET) is one of the names of the time zone that is
// 1 hour ahead of Coordinated Universal Time. It is used in most European
// and some North African countries.
//
// Its time offset is normally UTC+1. During daylight saving time, Central
// European Summer Time (CEST) is used instead (UTC+2). The current time
// offset is UTC+1.

// RLebeau: other abbreviations taken from:
// http://www.timeanddate.com/library/abbreviations/timezones/
// http://en.wikipedia.org/wiki/List_of_time_zone_abbreviations

function TimeZoneToGmtOffsetStr(const ATimeZone: String): String;
type
  TimeZoneOffset = record
    TimeZone: String;
    Offset: String;
  end;
const
  cTimeZones: array[0..244] of TimeZoneOffset = (
    (TimeZone:'A';    Offset:'+0100'), // Alpha Time Zone - Military                             {do not localize}
    (TimeZone:'ACDT'; Offset:'+1030'), // Australian Central Daylight Time                       {do not localize}
    (TimeZone:'ACST'; Offset:'+0930'), // Australian Central Standard Time                       {do not localize}
    (TimeZone:'ACT';  Offset:'+0800'), // ASEAN Common Time                                      {do not localize}
    (TimeZone:'ADT';  Offset:'-0300'), // Atlantic Daylight Time - North America                 {do not localize}
    (TimeZone:'AEDT'; Offset:'+1100'), // Australian Eastern Daylight Time                       {do not localize}
    (TimeZone:'AEST'; Offset:'+1000'), // Australian Eastern Standard Time                       {do not localize}
    (TimeZone:'AFT';  Offset:'+0430'), // Afghanistan Time                                       {do not localize}
    (TimeZone:'AKDT'; Offset:'-0800'), // Alaska Daylight Time                                   {do not localize}
    (TimeZone:'AKST'; Offset:'-0900'), // Alaska Standard Time                                   {do not localize}
    (TimeZone:'AMST'; Offset:'-0300'), // Amazon Summer Time (Brazil)                            {do not localize}
    (TimeZone:'AMST'; Offset:'+0500'), // Armenia Summer Time                                    {do not localize}
    (TimeZone:'AMT';  Offset:'-0400'), // Amazon Time (Brazil)                                   {do not localize}
    (TimeZone:'AMT';  Offset:'+0400'), // Armenia Time                                           {do not localize}
    (TimeZone:'ART';  Offset:'-0300'), // Argentina Time                                         {do not localize}
    (TimeZone:'AST';  Offset:'-0400'), // Atlantic Standard Time - North America                 {do not localize}
    (TimeZone:'AST';  Offset:'+0300'), // Arabia Standard Time                                   {do not localize}
    (TimeZone:'AWDT'; Offset:'+0900'), // Australian Western Daylight Time                       {do not localize}
    (TimeZone:'AWST'; Offset:'+0800'), // Australian Western Standard Time                       {do not localize}
    (TimeZone:'AZOST';Offset:'-0100'), // Azores Standard Time                                   {do not localize}
    (TimeZone:'AZT';  Offset:'+0400'), // Azerbaijan Time                                        {do not localize}
    (TimeZone:'B';    Offset:'+0200'), // Bravo Time Zone - Military                             {do not localize}
    (TimeZone:'BDT';  Offset:'+0800'), // Brunei Time                                            {do not localize}
    (TimeZone:'BIOT'; Offset:'+0600'), // British Indian Ocean Time                              {do not localize}
    (TimeZone:'BIT';  Offset:'-1200'), // Baker Island Time                                      {do not localize}
    (TimeZone:'BOT';  Offset:'-0400'), // Bolivia Time                                           {do not localize}
    (TimeZone:'BRT';  Offset:'-0300'), // Brasilia Time                                          {do not localize}
    (TimeZone:'BST';  Offset:'+0100'), // British Summer Time - Europe                           {do not localize}
    (TimeZone:'BST';  Offset:'+0600'), // Bangladesh Standard Time                               {do not localize}
    (TimeZone:'BTT';  Offset:'+0600'), // Bhutan Time                                            {do not localize}
    (TimeZone:'C';    Offset:'+0300'), // Charlie Time Zone - Military                           {do not localize}
    (TimeZone:'CAT';  Offset:'+0200'), // Central Africa Time                                    {do not localize}
    (TimeZone:'CCT';  Offset:'+0630'), // Cocos Islands Time                                     {do not localize}
    (TimeZone:'CDT';  Offset:'+1030'), // Central Daylight Time - Australia                      {do not localize}
    (TimeZone:'CDT';  Offset:'-0500'), // Central Daylight Time - North America                  {do not localize}
    (TimeZone:'CEDT'; Offset:'+0200'), // Central European Daylight Time                         {do not localize}
    (TimeZone:'CEST'; Offset:'+0200'), // Central European Summer Time                           {do not localize}
    (TimeZone:'CET';  Offset:'+0100'), // Central European Time                                  {do not localize}
    (TimeZone:'CHADT';Offset:'+1345'), // Chatham Daylight Time                                  {do not localize}
    (TimeZone:'CHAST';Offset:'+1245'), // Chatham Standard Time                                  {do not localize}
    (TimeZone:'CHOT'; Offset:'+0800'), // Choibalsan                                             {do not localize}
    (TimeZone:'ChST'; Offset:'+1000'), // Chamorro Standard Time                                 {do not localize}
    (TimeZone:'CHUT'; Offset:'+1000'), // Chuuk Time                                             {do not localize}
    (TimeZone:'CIST'; Offset:'-0800'), // Clipperton Island Standard Time                        {do not localize}
    (TimeZone:'CIT';  Offset:'+0800'), // Central Indonesia Time                                 {do not localize}
    (TimeZone:'CKT';  Offset:'-1000'), // Cook Island Time                                       {do not localize}
    (TimeZone:'CLST'; Offset:'-0300'), // Chile Summer Time                                      {do not localize}
    (TimeZone:'CLT';  Offset:'-0400'), // Chile Standard Time                                    {do not localize}
    (TimeZone:'COST'; Offset:'-0400'), // Colombia Summer Time                                   {do not localize}
    (TimeZone:'COT';  Offset:'-0500'), // Colombia Time                                          {do not localize}
    (TimeZone:'CST';  Offset:'+1030'), // Central Summer Time - Australia                        {do not localize}
    (TimeZone:'CST';  Offset:'+0930'), // Central Standard Time - Australia                      {do not localize}
    (TimeZone:'CST';  Offset:'-0600'), // Central Standard Time - North America                  {do not localize}
    (TimeZone:'CST';  Offset:'+0800'), // China Standard Time                                    {do not localize}
    (TimeZone:'CST';  Offset:'-0500'), // Cuba Standard Time                                     {do not localize}
    (TimeZone:'CT';   Offset:'+0800'), // China time                                             {do not localize}
    (TimeZone:'CVT';  Offset:'-0100'), // Cape Verde Time                                        {do not localize}
    (TimeZone:'CWST'; Offset:'+0845'), // Central Western Standard Time (Australia) unofficial   {do not localize}
    (TimeZone:'CXT';  Offset:'+0700'), // Christmas Island Time - Australia                      {do not localize}
    (TimeZone:'D';    Offset:'+0400'), // Delta Time Zone - Military                             {do not localize}
    (TimeZone:'DAVT'; Offset:'+0700'), // Davis Time                                             {do not localize}
    (TimeZone:'DDUT'; Offset:'+1000'), // Dumont d'Urville Time                                  {do not localize}
    (TimeZone:'DFT';  Offset:'+0100'), // AIX specific equivalent of Central European Time       {do not localize}
    (TimeZone:'E';    Offset:'+0500'), // Echo Time Zone - Military                              {do not localize}
    (TimeZone:'EASST';Offset:'-0500'), // Easter Island Standard Summer Time                     {do not localize}
    (TimeZone:'EAST'; Offset:'-0600'), // Easter Island Standard Time                            {do not localize}
    (TimeZone:'EAT';  Offset:'+0300'), // East Africa Time                                       {do not localize}
    (TimeZone:'ECT';  Offset:'-0400'), // Eastern Caribbean Time (does not recognise DST)        {do not localize}
    (TimeZone:'ECT';  Offset:'-0500'), // Ecuador Time                                           {do not localize}
    (TimeZone:'EDT';  Offset:'+1100'), // Eastern Daylight Time - Australia                      {do not localize}
    (TimeZone:'EDT';  Offset:'-0400'), // Eastern Daylight Time - North America                  {do not localize}
    (TimeZone:'EEDT'; Offset:'+0300'), // Eastern European Daylight Time                         {do not localize}
    (TimeZone:'EEST'; Offset:'+0300'), // Eastern European Summer Time                           {do not localize}
    (TimeZone:'EET';  Offset:'+0200'), // Eastern European Time                                  {do not localize}
    (TimeZone:'EGST'; Offset:'+0000'), // Eastern Greenland Summer Time                          {do not localize}
    (TimeZone:'EGT';  Offset:'-0100'), // Eastern Greenland Time                                 {do not localize}
    (TimeZone:'EIT';  Offset:'+0900'), // Eastern Indonesian Time                                {do not localize}
    (TimeZone:'EST';  Offset:'+1100'), // Eastern Summer Time - Australia                        {do not localize}
    (TimeZone:'EST';  Offset:'+1000'), // Eastern Standard Time - Australia                      {do not localize}
    (TimeZone:'EST';  Offset:'-0500'), // Eastern Standard Time - North America                  {do not localize}
    (TimeZone:'F';    Offset:'+0600'), // Foxtrot Time Zone - Military                           {do not localize}
    (TimeZone:'FET';  Offset:'+0300'), // Further-eastern European Time                          {do not localize}
    (TimeZone:'FJT';  Offset:'+1200'), // Fiji Time                                              {do not localize}
    (TimeZone:'FKST'; Offset:'-0300'), // Falkland Islands Standard Time                         {do not localize}
    (TimeZone:'FKST'; Offset:'-0300'), // Falkland Islands Summer Time                           {do not localize}
    (TimeZone:'FKT';  Offset:'-0400'), // Falkland Islands Time                                  {do not localize}
    (TimeZone:'FNT';  Offset:'-0200'), // Fernando de Noronha Time                               {do not localize}
    (TimeZone:'G';    Offset:'+0700'), // Golf Time Zone - Military                              {do not localize}
    (TimeZone:'GALT'; Offset:'-0600'), // Galapagos Time                                         {do not localize}
    (TimeZone:'GAMT'; Offset:'-0900'), // Gambier Islands                                        {do not localize}
    (TimeZone:'GET';  Offset:'+0400'), // Georgia Standard Time                                  {do not localize}
    (TimeZone:'GFT';  Offset:'-0300'), // French Guiana Time                                     {do not localize}
    (TimeZone:'GILT'; Offset:'+1200'), // Gilbert Island Time                                    {do not localize}
    (TimeZone:'GIT';  Offset:'-0900'), // Gambier Island Time                                    {do not localize}
    (TimeZone:'GMT';  Offset:'+0000'), // Greenwich Mean Time - Europe                           {do not localize}
    (TimeZone:'GST';  Offset:'-0200'), // South Georgia and the South Sandwich Islands           {do not localize}
    (TimeZone:'GST';  Offset:'+0400'), // Gulf Standard Time                                     {do not localize}
    (TimeZone:'GYT';  Offset:'-0400'), // Guyana Time                                            {do not localize}
    (TimeZone:'H';    Offset:'+0800'), // Hotel Time Zone - Military                             {do not localize}
    (TimeZone:'HAA';  Offset:'-0300'), // Heure Avancée de l'Atlantique - North America          {do not localize}
    (TimeZone:'HAC';  Offset:'-0500'), // Heure Avancée du Centre - North America                {do not localize}
    (TimeZone:'HADT'; Offset:'-0900'), // Hawaii-Aleutian Daylight Time - North America          {do not localize}
    (TimeZone:'HAE';  Offset:'-0400'), // Heure Avancée de l'Est - North America                 {do not localize}
    (TimeZone:'HAEC'; Offset:'+0200'), // Heure Avancée d'Europe Centrale francised name for CEST {do not localize}
    (TimeZone:'HAP';  Offset:'-0700'), // Heure Avancée du Pacifique - North America             {do not localize}
    (TimeZone:'HAR';  Offset:'-0600'), // Heure Avancée des Rocheuses - North America            {do not localize}
    (TimeZone:'HAST'; Offset:'-1000'), // Hawaii-Aleutian Standard Time - North America          {do not localize}
    (TimeZone:'HAT';  Offset:'-0230'), // Heure Avancée de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HAY';  Offset:'-0800'), // Heure Avancée du Yukon - North America                 {do not localize}
    (TimeZone:'HKT';  Offset:'+0800'), // Hong Kong Time                                         {do not localize}
    (TimeZone:'HMT';  Offset:'+0500'), // Heard and McDonald Islands Time                        {do not localize}
    (TimeZone:'HNA';  Offset:'-0400'), // Heure Normale de l'Atlantique - North America          {do not localize}
    (TimeZone:'HNC';  Offset:'-0600'), // Heure Normale du Centre - North America                {do not localize}
    (TimeZone:'HNE';  Offset:'-0500'), // Heure Normale de l'Est - North America                 {do not localize}
    (TimeZone:'HNP';  Offset:'-0800'), // Heure Normale du Pacifique - North America             {do not localize}
    (TimeZone:'HNR';  Offset:'-0700'), // Heure Normale des Rocheuses - North America            {do not localize}
    (TimeZone:'HNT';  Offset:'-0330'), // Heure Normale de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HNY';  Offset:'-0900'), // Heure Normale du Yukon - North America                 {do not localize}
    (TimeZone:'HOVT'; Offset:'+0700'), // Khovd Time                                             {do not localize}
    (TimeZone:'HST';  Offset:'-1000'), // Hawaii Standard Time                                   {do not localize}
    (TimeZone:'I';    Offset:'+0900'), // India Time Zone - Military                             {do not localize}
    (TimeZone:'ICT';  Offset:'+0700'), // Indochina Time                                         {do not localize}
    (TimeZone:'IDT';  Offset:'+0300'), // Israel Daylight Time                                   {do not localize}
    (TimeZone:'IOT';  Offset:'+0300'), // Indian Ocean Time                                      {do not localize}
    (TimeZone:'IRDT'; Offset:'+0430'), // Iran Daylight Time                                     {do not localize}
    (TimeZone:'IRKT'; Offset:'+0900'), // Irkutsk Time                                           {do not localize}
    (TimeZone:'IRST'; Offset:'+0330'), // Iran Standard Time                                     {do not localize}
    (TimeZone:'IST';  Offset:'+0100'), // Irish Summer Time - Europe                             {do not localize}
    (TimeZone:'IST';  Offset:'+0530'), // Indian Standard Time                                   {do not localize}
    (TimeZone:'IST';  Offset:'+0200'), // Israel Standard Time                                   {do not localize}
    (TimeZone:'JST';  Offset:'+0900'), // Japan Standard Time                                    {do not localize}
    (TimeZone:'K';    Offset:'+1000'), // Kilo Time Zone - Military                              {do not localize}
    (TimeZone:'KGT';  Offset:'+0600'), // Kyrgyzstan time                                        {do not localize}
    (TimeZone:'KOST'; Offset:'+1100'), // Kosrae Time                                            {do not localize}
    (TimeZone:'KRAT'; Offset:'+0700'), // Krasnoyarsk Time                                       {do not localize}
    (TimeZone:'KST';  Offset:'+0900'), // Korea Standard Time                                    {do not localize}
    (TimeZone:'L';    Offset:'+1100'), // Lima Time Zone - Military                              {do not localize}
    (TimeZone:'LHST'; Offset:'+1030'), // Lord Howe Standard Time                                {do not localize}
    (TimeZone:'LHST'; Offset:'+1100'), // Lord Howe Summer Time                                  {do not localize}
    (TimeZone:'LINT'; Offset:'+1400'), // Line Islands Time                                      {do not localize}
    (TimeZone:'M';    Offset:'+1200'), // Mike Time Zone - Military                              {do not localize}
    (TimeZone:'MAGT'; Offset:'+1200'), // Magadan Time                                           {do not localize}
    (TimeZone:'MART'; Offset:'-0930'), // Marquesas Islands Time                                 {do not localize}
    (TimeZone:'MAWT'; Offset:'+0500'), // Mawson Station Time                                    {do not localize}
    (TimeZone:'MDT';  Offset:'-0600'), // Mountain Daylight Time - North America                 {do not localize}
    (TimeZone:'MEHSZ';Offset:'+0300'), // Mitteleuropäische Hochsommerzeit - Europe              {do not localize}
    (TimeZone:'MEST'; Offset:'+0200'), // Middle European Saving Time Same zone as CEST          {do not localize}
    (TimeZone:'MESZ'; Offset:'+0200'), // Mitteleuroäische Sommerzeit - Europe                   {do not localize}
    (TimeZone:'MET';  Offset:'+0100'), // Middle European Time Same zone as CET                  {do not localize}
    (TimeZone:'MEZ';  Offset:'+0100'), // Mitteleuropäische Zeit - Europe                        {do not localize}
    (TimeZone:'MHT';  Offset:'+1200'), // Marshall Islands                                       {do not localize}
    (TimeZone:'MIST'; Offset:'+1100'), // Macquarie Island Station Time                          {do not localize}
    (TimeZone:'MIT';  Offset:'-0930'), // Marquesas Islands Time                                 {do not localize}
    (TimeZone:'MMT';  Offset:'+0630'), // Myanmar Time                                           {do not localize}
    (TimeZone:'MSD';  Offset:'+0400'), // Moscow Daylight Time - Europe                          {do not localize}
    (TimeZone:'MSK';  Offset:'+0300'), // Moscow Standard Time - Europe                          {do not localize}
    (TimeZone:'MST';  Offset:'-0700'), // Mountain Standard Time - North America                 {do not localize}
    (TimeZone:'MST';  Offset:'+0800'), // Malaysia Standard Time                                 {do not localize}
    (TimeZone:'MST';  Offset:'+0630'), // Myanmar Standard Time                                  {do not localize}
    (TimeZone:'MUT';  Offset:'+0400'), // Mauritius Time                                         {do not localize}
    (TimeZone:'MVT';  Offset:'+0500'), // Maldives Time                                          {do not localize}
    (TimeZone:'MYT';  Offset:'+0800'), // Malaysia Time                                          {do not localize}
    (TimeZone:'N';    Offset:'-0100'), // November Time Zone - Military                          {do not localize}
    (TimeZone:'NCT';  Offset:'+1100'), // New Caledonia Time                                     [do not localize}
    (TimeZone:'NDT';  Offset:'-0230'), // Newfoundland Daylight Time - North America             {do not localize}
    (TimeZone:'NFT';  Offset:'+1130'), // Norfolk (Island), Time - Australia                     {do not localize}
    (TimeZone:'NPT';  Offset:'+0545'), // Nepal Time                                             {do not localize}
    (TimeZone:'NST';  Offset:'-0330'), // Newfoundland Standard Time - North America             {do not localize}
    (TimeZone:'NT';   Offset:'-0330'), // Newfoundland Time                                      {do not localize}
    (TimeZone:'NUT';  Offset:'-1100'), // Niue Time                                              {do not localize}
    (TimeZone:'NZDT'; Offset:'+1300'), // New Zealand Daylight Time                              {do not localize}
    (TimeZone:'NZST'; Offset:'+1200'), // New Zealand Standard Time                              {do not localize}
    (TimeZone:'O';    Offset:'-0200'), // Oscar Time Zone - Military                             {do not localize}
    (TimeZone:'OMST'; Offset:'+0700'), // Omsk Time                                              {do not localize}
    (TimeZone:'ORAT'; Offset:'+0500'), // Oral Time                                              {do not localize}
    (TimeZone:'P';    Offset:'-0300'), // Papa Time Zone - Military                              {do not localize}
    (TimeZone:'PDT';  Offset:'-0700'), // Pacific Daylight Time - North America                  {do not localize}
    (TimeZone:'PET';  Offset:'-0500'), // Peru Time                                              {do not localize}
    (TimeZone:'PETT'; Offset:'+1200'), // Kamchatka Time                                         {do not localize}
    (TimeZone:'PGT';  Offset:'+1000'), // Papua New Guinea Time                                  {do not localize}
    (TimeZone:'PHOT'; Offset:'+1300'), // Phoenix Island Time                                    {do not localize}
    (TimeZone:'PKT';  Offset:'+0500'), // Pakistan Standard Time                                 {do not localize}
    (TimeZone:'PMDT'; Offset:'-0200'), // Saint Pierre and Miquelon Daylight time                {do not localize}
    (TimeZone:'PMST'; Offset:'-0300'), // Saint Pierre and Miquelon Standard Time                {do not localize}
    (TimeZone:'PONT'; Offset:'+1100'), // Pohnpei Standard Time                                  [do not localize]
    (TimeZone:'PST';  Offset:'-0800'), // Pacific Standard Time - North America                  {do not localize}
    (TimeZone:'PST';  Offset:'+0800'), // Philippine Standard Time                               {do not localize}
    (TimeZone:'PYST'; Offset:'-0300'), // Paraguay Summer Time (South America)                   {do not localize}
    (TimeZone:'PYT';  Offset:'-0400'), // Paraguay Time (South America)                          {do not localize}
    (TimeZone:'Q';    Offset:'-0400'), // Quebec Time Zone - Military                            {do not localize}
    (TimeZone:'R';    Offset:'-0500'), // Romeo Time Zone - Military                             {do not localize}
    (TimeZone:'RET';  Offset:'+0400'), // Réunion Time                                           {do not localize}
    (TimeZone:'ROTT'; Offset:'-0300'), // Rothera Research Station Time                          {do not localize}
    (TimeZone:'S';    Offset:'-0600'), // Sierra Time Zone - Military                            {do not localize}
    (TimeZone:'SAKT'; Offset:'+1100'), // Sakhalin Island time                                   {do not localize}
    (TimeZone:'SAMT'; Offset:'+0400'), // Samara Time                                            {do not localize}
    (TimeZone:'SAST'; Offset:'+0200'), // South African Standard Time                            {do not localize}
    (TimeZone:'SBT';  Offset:'+1100'), // Solomon Islands Time                                   {do not localize}
    (TimeZone:'SCT';  Offset:'+0400'), // Seychelles Time                                        {do not localize}
    (TimeZone:'SGT';  Offset:'+0800'), // Singapore Time                                         {do not localize}
    (TimeZone:'SLST'; Offset:'+0530'), // Sri Lanka Time                                         {do not localize}
    (TimeZone:'SRT';  Offset:'-0300'), // Suriname Time                                          {do not localize}
    (TimeZone:'SST';  Offset:'-1100'), // Samoa Standard Time                                    {do not localize}
    (TimeZone:'SST';  Offset:'+0800'), // Singapore Standard Time                                {do not localize}
    (TimeZone:'SYOT'; Offset:'+0300'), // Showa Station Time                                     {do not localize}
    (TimeZone:'T';    Offset:'-0700'), // Tango Time Zone - Military                             {do not localize}
    (TimeZone:'TAHT'; Offset:'-1000'), // Tahiti Time                                            {do not localize}
    (TimeZone:'THA';  Offset:'+0700'), // Thailand Standard Time                                 {do not localize}
    (TimeZone:'TFT';  Offset:'+0500'), // Indian/Kerguelen                                       {do not localize}
    (TimeZone:'TJT';  Offset:'+0500'), // Tajikistan Time                                        {do not localize}
    (TimeZone:'TKT';  Offset:'+1300'), // Tokelau Time                                           {do not localize}
    (TimeZone:'TLT';  Offset:'+0900'), // Timor Leste Time                                       {do not localize}
    (TimeZone:'TMT';  Offset:'+0500'), // Turkmenistan Time                                      {do not localize}
    (TimeZone:'TOT';  Offset:'+1300'), // Tonga Time                                             {do not localize}
    (TimeZone:'TVT';  Offset:'+1200'), // Tuvalu Time                                            {do not localize}
    (TimeZone:'U';    Offset:'-0800'), // Uniform Time Zone - Military                           {do not localize}
    (TimeZone:'UCT';  Offset:'+0000'), // Coordinated Universal Time                             {do not localize}
    (TimeZone:'ULAT'; Offset:'+0800'), // Ulaanbaatar Time                                       {do not localize}
    (TimeZone:'UT';   Offset:'+0000'), // Universal Time - Europe                                {do not localize}
    (TimeZone:'UTC';  Offset:'+0000'), // Coordinated Universal Time - Europe                    {do not localize}
    (TimeZone:'UYST'; Offset:'-0200'), // Uruguay Summer Time                                    {do not localize}
    (TimeZone:'UYT';  Offset:'-0300'), // Uruguay Standard Time                                  {do not localize}
    (TimeZone:'UZT';  Offset:'+0500'), // Uzbekistan Time                                        {do not localize}
    (TimeZone:'V';    Offset:'-0900'), // Victor Time Zone - Military                            {do not localize}
    (TimeZone:'VET';  Offset:'-0430'), // Venezuelan Standard Time                               {do not localize}
    (TimeZone:'VLAT'; Offset:'+1000'), // Vladivostok Time                                       {do not localize}
    (TimeZone:'VOLT'; Offset:'+0400'), // Volgograd Time                                         {do not localize}
    (TimeZone:'VOST'; Offset:'+0600'), // Vostok Station Time                                    {do not localize}
    (TimeZone:'VUT';  Offset:'+1100'), // Vanuatu Time                                           {do not localize}
    (TimeZone:'W';    Offset:'-1000'), // Whiskey Time Zone - Military                           {do not localize}
    (TimeZone:'WAKT'; Offset:'+1200'), // Wake Island Time                                       {do not localize}
    (TimeZone:'WAST'; Offset:'+0200'), // West Africa Summer Time                                {do not localize}
    (TimeZone:'WAT';  Offset:'+0100'), // West Africa Time                                       {do not localize}
    (TimeZone:'WDT';  Offset:'+0900'), // Western Daylight Time - Australia                      {do not localize}
    (TimeZone:'WEDT'; Offset:'+0100'), // Western European Daylight Time - Europe                {do not localize}
    (TimeZone:'WEST'; Offset:'+0100'), // Western European Summer Time - Europe                  {do not localize}
    (TimeZone:'WET';  Offset:'+0000'), // Western European Time - Europe                         {do not localize}
    (TimeZone:'WIT';  Offset:'+0700'), // Western Indonesian Time                                {do not localize}
    (TimeZone:'WST';  Offset:'+0900'), // Western Summer Time - Australia                        {do not localize}
    (TimeZone:'WST';  Offset:'+0800'), // Western Standard Time - Australia                      {do not localize}
    (TimeZone:'X';    Offset:'-1100'), // X-ray Time Zone - Military                             {do not localize}
    (TimeZone:'Y';    Offset:'-1200'), // Yankee Time Zone - Military                            {do not localize}
    (TimeZone:'YAKT'; Offset:'+1000'), // Yakutsk Time                                           {do not localize}
    (TimeZone:'YEKT'; Offset:'+0600'), // Yekaterinburg Time                                     {do not localize}
    (TimeZone:'Z';    Offset:'+0000')  // Zulu Time Zone - Military                              {do not localize}
  );
var
  I: Integer;
begin
  for I := Low(cTimeZones) to High(cTimeZones) do begin
    if TextIsSame(ATimeZone, cTimeZones[I].TimeZone) then begin
      Result := cTimeZones[I].Offset;
      Exit;
    end;
  end;
  Result := '-0000' {do not localize}
end;

function GetGMTOffsetStr(const S: string): string;
var
  Ignored: TDateTime;
begin
  Result := S;
  if not RawStrInternetToDateTime(Result, Ignored) then begin
    Result := '';
  end;
end;

function GmtOffsetStrToDateTime(const S: string): TDateTime;
var
  sTmp: String;
begin
  Result := 0.0;
  sTmp := Trim(S);
  sTmp := Fetch(sTmp);
  if Length(sTmp) > 0 then begin
    if not CharIsInSet(sTmp, 1, '-+') then begin {do not localize}
      sTmp := TimeZoneToGmtOffsetStr(sTmp);
    end else
    begin
      // ISO 8601 has a colon in the middle, ignore it
      if Length(sTmp) = 6 then begin
        if CharEquals(sTmp, 4, ':') then begin {do not localize}
          IdDelete(sTmp, 4, 1);
        end;
      end
      // ISO 8601 allows the minutes to be omitted, add them
      else if Length(sTmp) = 3 then begin
        sTmp := sTmp + '00';
      end;
      if (Length(sTmp) <> 5) or (not IsNumeric(sTmp, 2, 2)) or (not IsNumeric(sTmp, 2, 4)) then begin
        Exit;
      end;
    end;
    try
      Result := EncodeTime(IndyStrToInt(Copy(sTmp, 2, 2)), IndyStrToInt(Copy(sTmp, 4, 2)), 0, 0);
      if CharEquals(sTmp, 1, '-') then begin  {do not localize}
        Result := -Result;
      end;
    except
      Result := 0.0;
    end;
  end;
end;

{-Always returns date/time relative to GMT!!  -Replaces StrInternetToDateTime}
function GMTToLocalDateTime(S: string): TDateTime;
var
  DateTimeOffset: TDateTime;
begin
  if RawStrInternetToDateTime(S, Result) then begin
    DateTimeOffset := GmtOffsetStrToDateTime(S);
    {-Apply GMT and local offsets}
    Result := UTCTimeToLocalTime(Result - DateTimeOffset);
  end;
end;

{$IFNDEF HAS_TryStrToInt}
// TODO: declare this in the interface section...
function TryStrToInt(const S: string; out Value: Integer): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;
{$ENDIF}

{ Using the algorithm defined in RFC 6265 section 5.1.1 }
function CookieStrToLocalDateTime(S: string): TDateTime;
const
  {
  delimiter       = %x09 / %x20-2F / %x3B-40 / %x5B-60 / %x7B-7E
  non-delimiter   = %x00-08 / %x0A-1F / DIGIT / ":" / ALPHA / %x7F-FF
  }
  cDelimiters = #9' !"#$%&''()*+,-./;<=>?@[\]^_`{|}~';
var
  LStartPos, LEndPos: Integer;
  LFoundTime, LFoundDayOfMonth, LFoundMonth, LFoundYear: Boolean;
  LHour, LMinute, LSecond: Integer;
  LYear, LMonth, LDayOfMonth: Integer;

  function ExtractDigits(var AStr: String; MinDigits, MaxDigits: Integer): String;
  var
    LLength: Integer;
  begin
    Result := '';
    LLength := 0;
    while (LLength < Length(AStr)) and (LLength < MaxDigits) do
    begin
      if not IsNumeric(AStr[LLength+1]) then begin
        Break;
      end;
      Inc(LLength);
    end;
    if (LLength > 0) and (LLength >= MinDigits) then begin
      Result := Copy(AStr, 1, LLength);
      AStr := Copy(AStr, LLength+1, MaxInt);
    end;
  end;

  function ParseTime(const AStr: String): Boolean;
  var
    S, LTemp: String;
  begin
    {
    non-digit       = %x00-2F / %x3A-FF
    time            = hms-time [ non-digit *OCTET ]
    hms-time        = time-field ":" time-field ":" time-field
    time-field      = 1*2DIGIT
    }
    Result := False;
    S := AStr;

    LTemp := ExtractDigits(S, 1, 2);
    if (LTemp = '') or (not CharEquals(S, 1, ':')) then begin
      Exit;
    end;
    if not TryStrToInt(LTemp, LHour) then begin
      Exit;
    end;
    IdDelete(S, 1, 1);

    LTemp := ExtractDigits(S, 1, 2);
    if (LTemp = '') or (not CharEquals(S, 1, ':')) then begin
      Exit;
    end;
    if not TryStrToInt(LTemp, LMinute) then begin
      Exit;
    end;
    IdDelete(S, 1, 1);

    LTemp := ExtractDigits(S, 1, 2);
    if LTemp = '' then begin
      Exit;
    end;
    if S <> '' then begin
      if IsNumeric(S, 1, 1) then begin
        raise Exception.Create('Invalid Cookie Time');
      end;
    end;
    if not TryStrToInt(LTemp, LSecond) then begin
      Exit;
    end;

    if LHour > 23 then begin
      raise Exception.Create('Invalid Cookie Time');
    end;
    if LMinute > 59 then begin
      raise Exception.Create('Invalid Cookie Time');
    end;
    if LSecond > 59 then begin
      raise Exception.Create('Invalid Cookie Time');
    end;

    Result := True;
  end;

  function ParseDayOfMonth(const AStr: String): Boolean;
  var
    S, LTemp: String;
  begin
    {
    non-digit       = %x00-2F / %x3A-FF
    day-of-month    = 1*2DIGIT [ non-digit *OCTET ]
    }
    Result := False;
    S := AStr;

    LTemp := ExtractDigits(S, 1, 2);
    if LTemp = '' then begin
      Exit;
    end;
    if S <> '' then begin
      if IsNumeric(S, 1, 1) then begin
        raise Exception.Create('Invalid Cookie Day of Month');
      end;
    end;
    if not TryStrToInt(LTemp, LDayOfMonth) then begin
      Exit;
    end;
    if (LDayOfMonth < 1) or (LDayOfMonth > 31) then begin
      raise Exception.Create('Invalid Cookie Day of Month');
    end;

    Result := True;
  end;

  function ParseMonth(const AStr: String): Boolean;
  var
    S, LTemp: String;
  begin
    {
    month           = ( "jan" / "feb" / "mar" / "apr" /
                       "may" / "jun" / "jul" / "aug" /
                       "sep" / "oct" / "nov" / "dec" ) *OCTET
    }
    Result := False;

    LMonth := PosInStrArray(Copy(AStr, 1, 3), ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'], False) + 1;
    if LMonth = 0 then begin
      // RLebeau: per JP, some cookies have been encountered that use numbers
      // instead of names, even though this is not allowed by various RFCs...
      S := AStr;
      LTemp := ExtractDigits(S, 1, 2);
      if LTemp = '' then begin
        Exit;
      end;
      if S <> '' then begin
        if IsNumeric(S, 1, 1) then begin
          raise Exception.Create('Invalid Cookie Month');
        end;
      end;
      if not TryStrToInt(LTemp, LMonth) then begin
        Exit;
      end;
      if (LMonth < 1) or (LMonth > 12) then begin
        raise Exception.Create('Invalid Cookie Month');
      end;
    end;

    Result := True;
  end;

  function ParseYear(const AStr: String): Boolean;
  var
    S, LTemp: String;
  begin
    // year            = 2*4DIGIT [ non-digit *OCTET ]

    Result := False;
    S := AStr;

    LTemp := ExtractDigits(S, 2, 4);
    if (LTemp = '') or IsNumeric(S, 1, 1) then begin
      Exit;
    end;
    if not TryStrToInt(AStr, LYear) then begin
      Exit;
    end;
    if (LYear >= 70) and (LYear <= 99) then begin
      Inc(LYear, 1900);
    end
    else if (LYear >= 0) and (LYear <= 69) then begin
      Inc(LYear, 2000);
    end;
    if LYear < 1601 then begin
      raise Exception.Create('Invalid Cookie Year');
    end;

    Result := True;
  end;

  procedure ProcessToken(const AStr: String);
  begin
    if not LFoundTime then begin
      if ParseTime(AStr) then begin
        LFoundTime := True;
        Exit;
      end;
    end;
    if not LFoundDayOfMonth then begin
      if ParseDayOfMonth(AStr) then begin
        LFoundDayOfMonth := True;
        Exit;
      end;
    end;
    if not LFoundMonth then begin
      if ParseMonth(AStr) then begin
        LFoundMonth := True;
        Exit;
      end;
    end;
    if not LFoundYear then begin
      if ParseYear(AStr) then begin
        LFoundYear := True;
        Exit;
      end;
    end;
  end;

begin
  LFoundTime := False;
  LFoundDayOfMonth := False;
  LFoundMonth := False;
  LFoundYear := False;

  try
    LEndPos := 0;
    repeat
      LStartPos := FindFirstNotOf(cDelimiters, S, -1, LEndPos+1);
      if LStartPos = 0 then begin
        Break;
      end;
      LEndPos := FindFirstOf(cDelimiters, S, -1, LStartPos+1);
      if LEndPos = 0 then begin
        ProcessToken(Copy(S, LStartPos, MaxInt));
        Break;
      end;
      ProcessToken(Copy(S, LStartPos, LEndPos-LStartPos));
    until False;

    if (not LFoundDayOfMonth) or (not LFoundMonth) or (not LFoundYear) or (not LFoundTime) then begin
      raise Exception.Create('Invalid Cookie Date format');
    end;

    Result := EncodeDate(LYear, LMonth, LDayOfMonth) + EncodeTime(LHour, LMinute, LSecond, 0);
    Result := UTCTimeToLocalTime(Result);
  except
    Result := 0.0;
  end;
end;

{ Takes a UInt32 value and returns the string representation of it's binary value}    {Do not Localize}
function IntToBin(Value: UInt32): string;
var
  i: Integer;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TStringBuilder;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TStringBuilder.Create(32);
  {$ELSE}
  SetLength(Result, 32);
  {$ENDIF}
  for i := 1 to 32 do begin
    if ((Value shl (i-1)) shr 31) = 0 then begin
      {$IFDEF STRING_IS_IMMUTABLE}
      LSB.Append(Char('0'));  {do not localize}
      {$ELSE}
      Result[i] := '0';  {do not localize}
      {$ENDIF}
    end else begin
      {$IFDEF STRING_IS_IMMUTABLE}
      LSB.Append(Char('1'));  {do not localize}
      {$ELSE}
      Result[i] := '1';  {do not localize}
      {$ENDIF}
    end;
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

{ TIdMimeTable }

{$IFDEF UNIX}
procedure LoadMIME(const AFileName : String; AMIMEList : TStrings);
var
  KeyList: TStringList;
  i, p: Integer;
  s, LMimeType, LExtension: String;
begin
  if FileExists(AFileName) then begin {Do not localize}
    // build list from /etc/mime.types style list file
    // I'm lazy so I'm using a stringlist to load the file, ideally
    // this should not be done, reading the file line by line is better
    // I think - at least in terms of storage
    KeyList := TStringList.Create;
    try
      // TODO: use TStreamReader instead, on versions that support it
      KeyList.LoadFromFile(AFileName); {Do not localize}
      for i := 0 to KeyList.Count -1 do begin
        s := KeyList[i];
        p := IndyPos('#', s); {Do not localize}
        if p > 0 then begin
          SetLength(s, p-1);
        end;
        if s <> '' then begin {Do not localize}
          s := Trim(s);
          LMimeType := IndyLowerCase(Fetch(s));
          if LMimeType <> '' then begin {Do not localize}
             while s <> '' do begin {Do not localize}
               LExtension := IndyLowerCase(Fetch(s));
               if LExtension <> '' then {Do not localize}
               try
                 if LExtension[1] <> '.' then begin
                   LExtension := '.' + LExtension; {Do not localize}
                 end;
                 AMIMEList.Values[LExtension] := LMimeType;
               except
                 on EListError do {ignore} ;
               end;
             end;
          end;
        end;
      end;
    except
      on EFOpenError do {ignore} ;
    end;
  End;
end;
{$ENDIF}

procedure FillMimeTable(const AMIMEList: TStrings; const ALoadFromOS: Boolean = True);
{$IFDEF WINDOWS}
var
  reg: TRegistry;
  KeyList: TStringList;
  i: Integer;
  s, LExt: String;
{$ENDIF}
begin
  { Protect if someone is already filled (custom MomeConst) }
  if not Assigned(AMIMEList) then begin
    Exit;
  end;
  if AMIMEList.Count > 0 then begin
    Exit;
  end;
  {NOTE:  All of these strings should never be translated
  because they are protocol specific and are important for some
  web-browsers}

  { Animation }
  AMIMEList.Add('.nml=animation/narrative');    {Do not Localize}

  { Audio }
  AMIMEList.Add('.aac=audio/mp4');
  AMIMEList.Add('.aif=audio/x-aiff');    {Do not Localize}
  AMIMEList.Add('.aifc=audio/x-aiff');    {Do not Localize}
  AMIMEList.Add('.aiff=audio/x-aiff');    {Do not Localize}

  AMIMEList.Add('.au=audio/basic');    {Do not Localize}
  AMIMEList.Add('.gsm=audio/x-gsm');    {Do not Localize}
  AMIMEList.Add('.kar=audio/midi');    {Do not Localize}
  AMIMEList.Add('.m3u=audio/mpegurl');    {Do not Localize}
  AMIMEList.Add('.m4a=audio/x-mpg');    {Do not Localize}
  AMIMEList.Add('.mid=audio/midi');    {Do not Localize}
  AMIMEList.Add('.midi=audio/midi');    {Do not Localize}
  AMIMEList.Add('.mpega=audio/x-mpg');    {Do not Localize}
  AMIMEList.Add('.mp2=audio/x-mpg');    {Do not Localize}
  AMIMEList.Add('.mp3=audio/x-mpg');    {Do not Localize}
  AMIMEList.Add('.mpga=audio/x-mpg');    {Do not Localize}
  AMIMEList.Add('.m3u=audio/x-mpegurl');    {Do not Localize}
  AMIMEList.Add('.pls=audio/x-scpls');   {Do not Localize}
  AMIMEList.Add('.qcp=audio/vnd.qcelp');    {Do not Localize}
  AMIMEList.Add('.ra=audio/x-realaudio');    {Do not Localize}
  AMIMEList.Add('.ram=audio/x-pn-realaudio');    {Do not Localize}
  AMIMEList.Add('.rm=audio/x-pn-realaudio');    {Do not Localize}
  AMIMEList.Add('.sd2=audio/x-sd2');    {Do not Localize}
  AMIMEList.Add('.sid=audio/prs.sid');   {Do not Localize}
  AMIMEList.Add('.snd=audio/basic');   {Do not Localize}
  AMIMEList.Add('.wav=audio/x-wav');    {Do not Localize}
  AMIMEList.Add('.wax=audio/x-ms-wax');    {Do not Localize}
  AMIMEList.Add('.wma=audio/x-ms-wma');    {Do not Localize}

  AMIMEList.Add('.mjf=audio/x-vnd.AudioExplosion.MjuiceMediaFile');    {Do not Localize}

  { Image }
  AMIMEList.Add('.art=image/x-jg');    {Do not Localize}
  AMIMEList.Add('.bmp=image/bmp');    {Do not Localize}
  AMIMEList.Add('.cdr=image/x-coreldraw');    {Do not Localize}
  AMIMEList.Add('.cdt=image/x-coreldrawtemplate');    {Do not Localize}
  AMIMEList.Add('.cpt=image/x-corelphotopaint');    {Do not Localize}
  AMIMEList.Add('.djv=image/vnd.djvu');    {Do not Localize}
  AMIMEList.Add('.djvu=image/vnd.djvu');    {Do not Localize}
  AMIMEList.Add('.gif=image/gif');    {Do not Localize}
  AMIMEList.Add('.ief=image/ief');    {Do not Localize}
  AMIMEList.Add('.ico=image/x-icon');    {Do not Localize}
  AMIMEList.Add('.jng=image/x-jng');    {Do not Localize}
  AMIMEList.Add('.jpg=image/jpeg');    {Do not Localize}
  AMIMEList.Add('.jpeg=image/jpeg');    {Do not Localize}
  AMIMEList.Add('.jpe=image/jpeg');    {Do not Localize}
  AMIMEList.Add('.pat=image/x-coreldrawpattern');   {Do not Localize}
  AMIMEList.Add('.pcx=image/pcx');    {Do not Localize}
  AMIMEList.Add('.pbm=image/x-portable-bitmap');    {Do not Localize}
  AMIMEList.Add('.pgm=image/x-portable-graymap');    {Do not Localize}
  AMIMEList.Add('.pict=image/x-pict');    {Do not Localize}
  AMIMEList.Add('.png=image/x-png');    {Do not Localize}
  AMIMEList.Add('.pnm=image/x-portable-anymap');    {Do not Localize}
  AMIMEList.Add('.pntg=image/x-macpaint');    {Do not Localize}
  AMIMEList.Add('.ppm=image/x-portable-pixmap');    {Do not Localize}
  AMIMEList.Add('.psd=image/x-psd');    {Do not Localize}
  AMIMEList.Add('.qtif=image/x-quicktime');    {Do not Localize}
  AMIMEList.Add('.ras=image/x-cmu-raster');    {Do not Localize}
  AMIMEList.Add('.rf=image/vnd.rn-realflash');    {Do not Localize}
  AMIMEList.Add('.rgb=image/x-rgb');    {Do not Localize}
  AMIMEList.Add('.rp=image/vnd.rn-realpix');    {Do not Localize}
  AMIMEList.Add('.sgi=image/x-sgi');    {Do not Localize}
  AMIMEList.Add('.svg=image/svg+xml');    {Do not Localize}
  AMIMEList.Add('.svgz=image/svg+xml');    {Do not Localize}
  AMIMEList.Add('.targa=image/x-targa');    {Do not Localize}
  AMIMEList.Add('.tif=image/x-tiff');    {Do not Localize}
  AMIMEList.Add('.wbmp=image/vnd.wap.wbmp');    {Do not Localize}
  AMIMEList.Add('.webp=image/webp'); {Do not localize}
  AMIMEList.Add('.xbm=image/xbm');    {Do not Localize}
  AMIMEList.Add('.xbm=image/x-xbitmap');    {Do not Localize}
  AMIMEList.Add('.xpm=image/x-xpixmap');    {Do not Localize}
  AMIMEList.Add('.xwd=image/x-xwindowdump');    {Do not Localize}

  { Text }
  AMIMEList.Add('.323=text/h323');    {Do not Localize}

  AMIMEList.Add('.xml=text/xml');    {Do not Localize}
  AMIMEList.Add('.uls=text/iuls');    {Do not Localize}
  AMIMEList.Add('.txt=text/plain');    {Do not Localize}
  AMIMEList.Add('.rtx=text/richtext');    {Do not Localize}
  AMIMEList.Add('.wsc=text/scriptlet');    {Do not Localize}
  AMIMEList.Add('.rt=text/vnd.rn-realtext');    {Do not Localize}
  AMIMEList.Add('.htt=text/webviewhtml');    {Do not Localize}
  AMIMEList.Add('.htc=text/x-component');    {Do not Localize}
  AMIMEList.Add('.vcf=text/x-vcard');    {Do not Localize}

  { Video }
  AMIMEList.Add('.asf=video/x-ms-asf');    {Do not Localize}
  AMIMEList.Add('.asx=video/x-ms-asf');    {Do not Localize}
  AMIMEList.Add('.avi=video/x-msvideo');    {Do not Localize}
  AMIMEList.Add('.dl=video/dl');    {Do not Localize}
  AMIMEList.Add('.dv=video/dv');  {Do not Localize}
  AMIMEList.Add('.flc=video/flc');    {Do not Localize}
  AMIMEList.Add('.fli=video/fli');    {Do not Localize}
  AMIMEList.Add('.gl=video/gl');    {Do not Localize}
  AMIMEList.Add('.lsf=video/x-la-asf');    {Do not Localize}
  AMIMEList.Add('.lsx=video/x-la-asf');    {Do not Localize}
  AMIMEList.Add('.mng=video/x-mng');    {Do not Localize}

  AMIMEList.Add('.mp2=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.mp3=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.mp4=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.mpeg=video/x-mpeg2a');    {Do not Localize}
  AMIMEList.Add('.mpa=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.mpe=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.mpg=video/mpeg');    {Do not Localize}
  AMIMEList.Add('.ogv=video/ogg');    {Do not Localize}
  AMIMEList.Add('.moov=video/quicktime');     {Do not Localize}
  AMIMEList.Add('.mov=video/quicktime');    {Do not Localize}
  AMIMEList.Add('.mxu=video/vnd.mpegurl');   {Do not Localize}
  AMIMEList.Add('.qt=video/quicktime');    {Do not Localize}
  AMIMEList.Add('.qtc=video/x-qtc'); {Do not loccalize}
  AMIMEList.Add('.rv=video/vnd.rn-realvideo');    {Do not Localize}
  AMIMEList.Add('.ivf=video/x-ivf');    {Do not Localize}
  AMIMEList.Add('.webm=video/webm');    {Do not Localize}
  AMIMEList.Add('.wm=video/x-ms-wm');    {Do not Localize}
  AMIMEList.Add('.wmp=video/x-ms-wmp');    {Do not Localize}
  AMIMEList.Add('.wmv=video/x-ms-wmv');    {Do not Localize}
  AMIMEList.Add('.wmx=video/x-ms-wmx');    {Do not Localize}
  AMIMEList.Add('.wvx=video/x-ms-wvx');    {Do not Localize}
  AMIMEList.Add('.rms=video/vnd.rn-realvideo-secure');    {Do not Localize}
  AMIMEList.Add('.asx=video/x-ms-asf-plugin');    {Do not Localize}
  AMIMEList.Add('.movie=video/x-sgi-movie');    {Do not Localize}

  { Application }
  AMIMEList.Add('.7z=application/x-7z-compressed');   {Do not Localize}
  AMIMEList.Add('.a=application/x-archive');   {Do not Localize}
  AMIMEList.Add('.aab=application/x-authorware-bin');    {Do not Localize}
  AMIMEList.Add('.aam=application/x-authorware-map');    {Do not Localize}
  AMIMEList.Add('.aas=application/x-authorware-seg');    {Do not Localize}
  AMIMEList.Add('.abw=application/x-abiword');    {Do not Localize}
  AMIMEList.Add('.ace=application/x-ace-compressed');  {Do not Localize}
  AMIMEList.Add('.ai=application/postscript');    {Do not Localize}
  AMIMEList.Add('.alz=application/x-alz-compressed');    {Do not Localize}
  AMIMEList.Add('.ani=application/x-navi-animation');   {Do not Localize}
  AMIMEList.Add('.arj=application/x-arj');    {Do not Localize}
  AMIMEList.Add('.asf=application/vnd.ms-asf');    {Do not Localize}
  AMIMEList.Add('.bat=application/x-msdos-program');    {Do not Localize}
  AMIMEList.Add('.bcpio=application/x-bcpio');    {Do not Localize}
  AMIMEList.Add('.boz=application/x-bzip2');     {Do not Localize}
  AMIMEList.Add('.bz=application/x-bzip');
  AMIMEList.Add('.bz2=application/x-bzip2');    {Do not Localize}
  AMIMEList.Add('.cab=application/vnd.ms-cab-compressed');    {Do not Localize}
  AMIMEList.Add('.cat=application/vnd.ms-pki.seccat');    {Do not Localize}
  AMIMEList.Add('.ccn=application/x-cnc');    {Do not Localize}
  AMIMEList.Add('.cco=application/x-cocoa');    {Do not Localize}
  AMIMEList.Add('.cdf=application/x-cdf');    {Do not Localize}
  AMIMEList.Add('.cer=application/x-x509-ca-cert');    {Do not Localize}
  AMIMEList.Add('.chm=application/vnd.ms-htmlhelp');    {Do not Localize}
  AMIMEList.Add('.chrt=application/vnd.kde.kchart');    {Do not Localize}
  AMIMEList.Add('.cil=application/vnd.ms-artgalry');    {Do not Localize}
  AMIMEList.Add('.class=application/java-vm');    {Do not Localize}
  AMIMEList.Add('.com=application/x-msdos-program');    {Do not Localize}
  AMIMEList.Add('.clp=application/x-msclip');    {Do not Localize}
  AMIMEList.Add('.cpio=application/x-cpio');    {Do not Localize}
  AMIMEList.Add('.cpt=application/mac-compactpro');    {Do not Localize}
  AMIMEList.Add('.cqk=application/x-calquick');    {Do not Localize}
  AMIMEList.Add('.crd=application/x-mscardfile');    {Do not Localize}
  AMIMEList.Add('.crl=application/pkix-crl');    {Do not Localize}
  AMIMEList.Add('.csh=application/x-csh');    {Do not Localize}
  AMIMEList.Add('.dar=application/x-dar');    {Do not Localize}
  AMIMEList.Add('.dbf=application/x-dbase');    {Do not Localize}
  AMIMEList.Add('.dcr=application/x-director');    {Do not Localize}
  AMIMEList.Add('.deb=application/x-debian-package');    {Do not Localize}
  AMIMEList.Add('.dir=application/x-director');    {Do not Localize}
  AMIMEList.Add('.dist=vnd.apple.installer+xml');    {Do not Localize}
  AMIMEList.Add('.distz=vnd.apple.installer+xml');    {Do not Localize}
  AMIMEList.Add('.dll=application/x-msdos-program');    {Do not Localize}
  AMIMEList.Add('.dmg=application/x-apple-diskimage');    {Do not Localize}
  AMIMEList.Add('.doc=application/msword');    {Do not Localize}
  AMIMEList.Add('.dot=application/msword');    {Do not Localize}
  AMIMEList.Add('.dvi=application/x-dvi');    {Do not Localize}
  AMIMEList.Add('.dxr=application/x-director');    {Do not Localize}
  AMIMEList.Add('.ebk=application/x-expandedbook');    {Do not Localize}
  AMIMEList.Add('.eps=application/postscript');    {Do not Localize}
  AMIMEList.Add('.evy=application/envoy');    {Do not Localize}
  AMIMEList.Add('.exe=application/x-msdos-program');    {Do not Localize}
  AMIMEList.Add('.fdf=application/vnd.fdf');    {Do not Localize}
  AMIMEList.Add('.fif=application/fractals');    {Do not Localize}
  AMIMEList.Add('.flm=application/vnd.kde.kivio');    {Do not Localize}
  AMIMEList.Add('.fml=application/x-file-mirror-list');    {Do not Localize}
  AMIMEList.Add('.gzip=application/x-gzip');  {Do not Localize}
  AMIMEList.Add('.gnumeric=application/x-gnumeric');    {Do not Localize}
  AMIMEList.Add('.gtar=application/x-gtar');    {Do not Localize}
  AMIMEList.Add('.gz=application/x-gzip');    {Do not Localize}
  AMIMEList.Add('.hdf=application/x-hdf');    {Do not Localize}
  AMIMEList.Add('.hlp=application/winhlp');    {Do not Localize}
  AMIMEList.Add('.hpf=application/x-icq-hpf');    {Do not Localize}
  AMIMEList.Add('.hqx=application/mac-binhex40');    {Do not Localize}
  AMIMEList.Add('.hta=application/hta');    {Do not Localize}
  AMIMEList.Add('.ims=application/vnd.ms-ims');    {Do not Localize}
  AMIMEList.Add('.ins=application/x-internet-signup');    {Do not Localize}
  AMIMEList.Add('.iii=application/x-iphone');    {Do not Localize}
  AMIMEList.Add('.iso=application/x-iso9660-image');    {Do not Localize}
  AMIMEList.Add('.jar=application/java-archive');    {Do not Localize}
  AMIMEList.Add('.karbon=application/vnd.kde.karbon');    {Do not Localize}
  AMIMEList.Add('.kfo=application/vnd.kde.kformula');    {Do not Localize}
  AMIMEList.Add('.kon=application/vnd.kde.kontour');    {Do not Localize}
  AMIMEList.Add('.kpr=application/vnd.kde.kpresenter');    {Do not Localize}
  AMIMEList.Add('.kpt=application/vnd.kde.kpresenter');    {Do not Localize}
  AMIMEList.Add('.kwd=application/vnd.kde.kword');    {Do not Localize}
  AMIMEList.Add('.kwt=application/vnd.kde.kword');    {Do not Localize}
  AMIMEList.Add('.latex=application/x-latex');    {Do not Localize}
  AMIMEList.Add('.lha=application/x-lzh');    {Do not Localize}
  AMIMEList.Add('.lcc=application/fastman');    {Do not Localize}
  AMIMEList.Add('.lrm=application/vnd.ms-lrm');    {Do not Localize}
  AMIMEList.Add('.lz=application/x-lzip');    {Do not Localize}
  AMIMEList.Add('.lzh=application/x-lzh');    {Do not Localize}
  AMIMEList.Add('.lzma=application/x-lzma');  {Do not Localize}
  AMIMEList.Add('.lzo=application/x-lzop'); {Do not Localize}
  AMIMEList.Add('.lzx=application/x-lzx');
  AMIMEList.Add('.m13=application/x-msmediaview');    {Do not Localize}
  AMIMEList.Add('.m14=application/x-msmediaview');    {Do not Localize}
  AMIMEList.Add('.mpp=application/vnd.ms-project');    {Do not Localize}
  AMIMEList.Add('.mvb=application/x-msmediaview');    {Do not Localize}
  AMIMEList.Add('.man=application/x-troff-man');    {Do not Localize}
  AMIMEList.Add('.mdb=application/x-msaccess');    {Do not Localize}
  AMIMEList.Add('.me=application/x-troff-me');    {Do not Localize}
  AMIMEList.Add('.ms=application/x-troff-ms');    {Do not Localize}
  AMIMEList.Add('.msi=application/x-msi');    {Do not Localize}
  AMIMEList.Add('.mpkg=vnd.apple.installer+xml');    {Do not Localize}
  AMIMEList.Add('.mny=application/x-msmoney');    {Do not Localize}
  AMIMEList.Add('.nix=application/x-mix-transfer');    {Do not Localize}
  AMIMEList.Add('.o=application/x-object');    {Do not Localize}
  AMIMEList.Add('.oda=application/oda');    {Do not Localize}
  AMIMEList.Add('.odb=application/vnd.oasis.opendocument.database');    {Do not Localize}
  AMIMEList.Add('.odc=application/vnd.oasis.opendocument.chart');    {Do not Localize}
  AMIMEList.Add('.odf=application/vnd.oasis.opendocument.formula');    {Do not Localize}
  AMIMEList.Add('.odg=application/vnd.oasis.opendocument.graphics');    {Do not Localize}
  AMIMEList.Add('.odi=application/vnd.oasis.opendocument.image');    {Do not Localize}
  AMIMEList.Add('.odm=application/vnd.oasis.opendocument.text-master');    {Do not Localize}
  AMIMEList.Add('.odp=application/vnd.oasis.opendocument.presentation');    {Do not Localize}
  AMIMEList.Add('.ods=application/vnd.oasis.opendocument.spreadsheet');    {Do not Localize}
  AMIMEList.Add('.ogg=application/ogg');    {Do not Localize}
  AMIMEList.Add('.odt=application/vnd.oasis.opendocument.text');    {Do not Localize}
  AMIMEList.Add('.otg=application/vnd.oasis.opendocument.graphics-template');    {Do not Localize}
  AMIMEList.Add('.oth=application/vnd.oasis.opendocument.text-web');    {Do not Localize}
  AMIMEList.Add('.otp=application/vnd.oasis.opendocument.presentation-template');    {Do not Localize}
  AMIMEList.Add('.ots=application/vnd.oasis.opendocument.spreadsheet-template');    {Do not Localize}
  AMIMEList.Add('.ott=application/vnd.oasis.opendocument.text-template');    {Do not Localize}
  AMIMEList.Add('.p10=application/pkcs10');    {Do not Localize}
  AMIMEList.Add('.p12=application/x-pkcs12');    {Do not Localize}
  AMIMEList.Add('.p7b=application/x-pkcs7-certificates');    {Do not Localize}
  AMIMEList.Add('.p7m=application/pkcs7-mime');    {Do not Localize}
  AMIMEList.Add('.p7r=application/x-pkcs7-certreqresp');    {Do not Localize}
  AMIMEList.Add('.p7s=application/pkcs7-signature');    {Do not Localize}
  AMIMEList.Add('.package=application/vnd.autopackage');    {Do not Localize}
  AMIMEList.Add('.pfr=application/font-tdpfr');    {Do not Localize}
  AMIMEList.Add('.pkg=vnd.apple.installer+xml');    {Do not Localize}
  AMIMEList.Add('.pdf=application/pdf');    {Do not Localize}
  AMIMEList.Add('.pko=application/vnd.ms-pki.pko');    {Do not Localize}
  AMIMEList.Add('.pl=application/x-perl');    {Do not Localize}
  AMIMEList.Add('.pnq=application/x-icq-pnq');    {Do not Localize}
  AMIMEList.Add('.pot=application/mspowerpoint');    {Do not Localize}
  AMIMEList.Add('.pps=application/mspowerpoint');    {Do not Localize}
  AMIMEList.Add('.ppt=application/mspowerpoint');    {Do not Localize}
  AMIMEList.Add('.ppz=application/mspowerpoint');    {Do not Localize}
  AMIMEList.Add('.ps=application/postscript');    {Do not Localize}
  AMIMEList.Add('.pub=application/x-mspublisher');    {Do not Localize}
  AMIMEList.Add('.qpw=application/x-quattropro');    {Do not Localize}
  AMIMEList.Add('.qtl=application/x-quicktimeplayer');    {Do not Localize}
  AMIMEList.Add('.rar=application/rar');    {Do not Localize}
  AMIMEList.Add('.rdf=application/rdf+xml');    {Do not Localize}
  AMIMEList.Add('.rjs=application/vnd.rn-realsystem-rjs');    {Do not Localize}
  AMIMEList.Add('.rm=application/vnd.rn-realmedia');    {Do not Localize}
  AMIMEList.Add('.rmf=application/vnd.rmf');    {Do not Localize}
  AMIMEList.Add('.rmp=application/vnd.rn-rn_music_package');    {Do not Localize}
  AMIMEList.Add('.rmx=application/vnd.rn-realsystem-rmx');    {Do not Localize}
  AMIMEList.Add('.rnx=application/vnd.rn-realplayer');    {Do not Localize}
  AMIMEList.Add('.rpm=application/x-redhat-package-manager');
  AMIMEList.Add('.rsml=application/vnd.rn-rsml');    {Do not Localize}
  AMIMEList.Add('.rtsp=application/x-rtsp');    {Do not Localize}
  AMIMEList.Add('.rss=application/rss+xml');    {Do not Localize}
  AMIMEList.Add('.scm=application/x-icq-scm');    {Do not Localize}
  AMIMEList.Add('.ser=application/java-serialized-object');    {Do not Localize}
  AMIMEList.Add('.scd=application/x-msschedule');    {Do not Localize}
  AMIMEList.Add('.sda=application/vnd.stardivision.draw');    {Do not Localize}
  AMIMEList.Add('.sdc=application/vnd.stardivision.calc');    {Do not Localize}
  AMIMEList.Add('.sdd=application/vnd.stardivision.impress');    {Do not Localize}
  AMIMEList.Add('.sdp=application/x-sdp');    {Do not Localize}
  AMIMEList.Add('.setpay=application/set-payment-initiation');    {Do not Localize}
  AMIMEList.Add('.setreg=application/set-registration-initiation');    {Do not Localize}
  AMIMEList.Add('.sh=application/x-sh');    {Do not Localize}
  AMIMEList.Add('.shar=application/x-shar');    {Do not Localize}
  AMIMEList.Add('.shw=application/presentations');    {Do not Localize}
  AMIMEList.Add('.sit=application/x-stuffit');    {Do not Localize}
  AMIMEList.Add('.sitx=application/x-stuffitx');  {Do not localize}
  AMIMEList.Add('.skd=application/x-koan');    {Do not Localize}
  AMIMEList.Add('.skm=application/x-koan');    {Do not Localize}
  AMIMEList.Add('.skp=application/x-koan');    {Do not Localize}
  AMIMEList.Add('.skt=application/x-koan');    {Do not Localize}
  AMIMEList.Add('.smf=application/vnd.stardivision.math');    {Do not Localize}
  AMIMEList.Add('.smi=application/smil');    {Do not Localize}
  AMIMEList.Add('.smil=application/smil');    {Do not Localize}
  AMIMEList.Add('.spl=application/futuresplash');    {Do not Localize}
  AMIMEList.Add('.ssm=application/streamingmedia');    {Do not Localize}
  AMIMEList.Add('.sst=application/vnd.ms-pki.certstore');    {Do not Localize}
  AMIMEList.Add('.stc=application/vnd.sun.xml.calc.template');    {Do not Localize}
  AMIMEList.Add('.std=application/vnd.sun.xml.draw.template');    {Do not Localize}
  AMIMEList.Add('.sti=application/vnd.sun.xml.impress.template');    {Do not Localize}
  AMIMEList.Add('.stl=application/vnd.ms-pki.stl');    {Do not Localize}
  AMIMEList.Add('.stw=application/vnd.sun.xml.writer.template');    {Do not Localize}
  AMIMEList.Add('.svi=application/softvision');    {Do not Localize}
  AMIMEList.Add('.sv4cpio=application/x-sv4cpio');    {Do not Localize}
  AMIMEList.Add('.sv4crc=application/x-sv4crc');    {Do not Localize}
  AMIMEList.Add('.swf=application/x-shockwave-flash');    {Do not Localize}
  AMIMEList.Add('.swf1=application/x-shockwave-flash');    {Do not Localize}
  AMIMEList.Add('.sxc=application/vnd.sun.xml.calc');    {Do not Localize}
  AMIMEList.Add('.sxi=application/vnd.sun.xml.impress');    {Do not Localize}
  AMIMEList.Add('.sxm=application/vnd.sun.xml.math');    {Do not Localize}
  AMIMEList.Add('.sxw=application/vnd.sun.xml.writer');    {Do not Localize}
  AMIMEList.Add('.sxg=application/vnd.sun.xml.writer.global');    {Do not Localize}
  AMIMEList.Add('.t=application/x-troff');    {Do not Localize}
  AMIMEList.Add('.tar=application/x-tar');    {Do not Localize}
  AMIMEList.Add('.tcl=application/x-tcl');    {Do not Localize}
  AMIMEList.Add('.tex=application/x-tex');    {Do not Localize}
  AMIMEList.Add('.texi=application/x-texinfo');    {Do not Localize}
  AMIMEList.Add('.texinfo=application/x-texinfo');    {Do not Localize}
  AMIMEList.Add('.tbz=application/x-bzip-compressed-tar');   {Do not Localize}
  AMIMEList.Add('.tbz2=application/x-bzip-compressed-tar');   {Do not Localize}
  AMIMEList.Add('.tgz=application/x-compressed-tar');    {Do not Localize}
  AMIMEList.Add('.tlz=application/x-lzma-compressed-tar');    {Do not Localize}
  AMIMEList.Add('.tr=application/x-troff');    {Do not Localize}
  AMIMEList.Add('.trm=application/x-msterminal');    {Do not Localize}
  AMIMEList.Add('.troff=application/x-troff');    {Do not Localize}
  AMIMEList.Add('.tsp=application/dsptype');    {Do not Localize}
  AMIMEList.Add('.torrent=application/x-bittorrent');    {Do not Localize}
  AMIMEList.Add('.ttz=application/t-time');    {Do not Localize}
  AMIMEList.Add('.txz=application/x-xz-compressed-tar'); {Do not localize}
  AMIMEList.Add('.udeb=application/x-debian-package');    {Do not Localize}

  AMIMEList.Add('.uin=application/x-icq');    {Do not Localize}
  AMIMEList.Add('.urls=application/x-url-list');    {Do not Localize}
  AMIMEList.Add('.ustar=application/x-ustar');    {Do not Localize}
  AMIMEList.Add('.vcd=application/x-cdlink');    {Do not Localize}
  AMIMEList.Add('.vor=application/vnd.stardivision.writer');    {Do not Localize}
  AMIMEList.Add('.vsl=application/x-cnet-vsl');    {Do not Localize}
  AMIMEList.Add('.wcm=application/vnd.ms-works');    {Do not Localize}
  AMIMEList.Add('.wb1=application/x-quattropro');    {Do not Localize}
  AMIMEList.Add('.wb2=application/x-quattropro');    {Do not Localize}
  AMIMEList.Add('.wb3=application/x-quattropro');    {Do not Localize}
  AMIMEList.Add('.wdb=application/vnd.ms-works');    {Do not Localize}
  AMIMEList.Add('.wks=application/vnd.ms-works');    {Do not Localize}
  AMIMEList.Add('.wmd=application/x-ms-wmd');    {Do not Localize}
  AMIMEList.Add('.wms=application/x-ms-wms');    {Do not Localize}
  AMIMEList.Add('.wmz=application/x-ms-wmz');    {Do not Localize}
  AMIMEList.Add('.wp5=application/wordperfect5.1');    {Do not Localize}
  AMIMEList.Add('.wpd=application/wordperfect');    {Do not Localize}
  AMIMEList.Add('.wpl=application/vnd.ms-wpl');    {Do not Localize}
  AMIMEList.Add('.wps=application/vnd.ms-works');    {Do not Localize}
  AMIMEList.Add('.wri=application/x-mswrite');    {Do not Localize}
  AMIMEList.Add('.xfdf=application/vnd.adobe.xfdf');    {Do not Localize}
  AMIMEList.Add('.xls=application/x-msexcel');    {Do not Localize}
  AMIMEList.Add('.xlb=application/x-msexcel');     {Do not Localize}
  AMIMEList.Add('.xpi=application/x-xpinstall');    {Do not Localize}
  AMIMEList.Add('.xps=application/vnd.ms-xpsdocument');    {Do not Localize}
  AMIMEList.Add('.xsd=application/vnd.sun.xml.draw');    {Do not Localize}
  AMIMEList.Add('.xul=application/vnd.mozilla.xul+xml');    {Do not Localize}
  AMIMEList.Add('.z=application/x-compress');    {Do not Localize}
  AMIMEList.Add('.zoo=application/x-zoo');    {Do not Localize}
  AMIMEList.Add('.zip=application/x-zip-compressed');    {Do not Localize}
    
  { WAP }
  AMIMEList.Add('.wbmp=image/vnd.wap.wbmp');    {Do not Localize}
  AMIMEList.Add('.wml=text/vnd.wap.wml');    {Do not Localize}
  AMIMEList.Add('.wmlc=application/vnd.wap.wmlc');    {Do not Localize}
  AMIMEList.Add('.wmls=text/vnd.wap.wmlscript');    {Do not Localize}
  AMIMEList.Add('.wmlsc=application/vnd.wap.wmlscriptc');    {Do not Localize}

  { Non-web text}
  {
  IMPORTANT!!

  You should not use a text MIME type definition unless you are
  extremely certain that the file will NOT be a binary.  Some browsers
  will display the text instead of saving to disk and it looks ugly
  if a web-browser shows all of the 8bit charactors.
  }
  //of course, we have to add this :-).
  AMIMEList.Add('.asm=text/x-asm');   {Do not Localize}
  AMIMEList.Add('.p=text/x-pascal');    {Do not Localize}
  AMIMEList.Add('.pas=text/x-pascal');    {Do not Localize}

  AMIMEList.Add('.cs=text/x-csharp'); {Do not Localize}

  AMIMEList.Add('.c=text/x-csrc');    {Do not Localize}
  AMIMEList.Add('.c++=text/x-c++src');    {Do not Localize}
  AMIMEList.Add('.cpp=text/x-c++src');    {Do not Localize}
  AMIMEList.Add('.cxx=text/x-c++src');    {Do not Localize}
  AMIMEList.Add('.cc=text/x-c++src');    {Do not Localize}
  AMIMEList.Add('.h=text/x-chdr'); {Do not localize}
  AMIMEList.Add('.h++=text/x-c++hdr');    {Do not Localize}
  AMIMEList.Add('.hpp=text/x-c++hdr');    {Do not Localize}
  AMIMEList.Add('.hxx=text/x-c++hdr');    {Do not Localize}
  AMIMEList.Add('.hh=text/x-c++hdr');    {Do not Localize}
  AMIMEList.Add('.java=text/x-java');    {Do not Localize}

  { WEB }
  AMIMEList.Add('.css=text/css');    {Do not Localize}
  AMIMEList.Add('.js=text/javascript');    {Do not Localize}
  AMIMEList.Add('.htm=text/html');    {Do not Localize}
  AMIMEList.Add('.html=text/html');    {Do not Localize}
  AMIMEList.Add('.xhtml=application/xhtml+xml'); {Do not localize}
  AMIMEList.Add('.xht=application/xhtml+xml'); {Do not localize}
  AMIMEList.Add('.rdf=application/rdf+xml'); {Do not localize}
  AMIMEList.Add('.rss=application/rss+xml'); {Do not localize}

  AMIMEList.Add('.ls=text/javascript');    {Do not Localize}
  AMIMEList.Add('.mocha=text/javascript');    {Do not Localize}
  AMIMEList.Add('.shtml=server-parsed-html');    {Do not Localize}
  AMIMEList.Add('.xml=text/xml');    {Do not Localize}
  AMIMEList.Add('.sgm=text/sgml');    {Do not Localize}
  AMIMEList.Add('.sgml=text/sgml');    {Do not Localize}

  { Message }
  AMIMEList.Add('.mht=message/rfc822');    {Do not Localize}

  if not ALoadFromOS then begin
    Exit;
  end;

  {$IFDEF WINDOWS}
  // Build the file type/MIME type map
  Reg := TRegistry.Create;
  try
    KeyList := TStringList.create;
    try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      // TODO: use RegEnumKeyEx() directly to avoid wasting memory loading keys we don't care about...
      if Reg.OpenKeyReadOnly('\') then begin  {do not localize}
        Reg.GetKeyNames(KeyList);
        Reg.Closekey;
      end;
      // get a list of registered extentions
      for i := 0 to KeyList.Count - 1 do begin
        LExt := KeyList[i];
        if TextStartsWith(LExt, '.') then begin  {do not localize}
          if Reg.OpenKeyReadOnly(LExt) then begin
            s := Reg.ReadString('Content Type');  {do not localize}
            if Length(s) > 0 then begin
              AMIMEList.Values[IndyLowerCase(LExt)] := IndyLowerCase(s);
            end;
            Reg.CloseKey;
          end;
        end;
      end;
      if Reg.OpenKeyReadOnly('\MIME\Database\Content Type') then begin {do not localize}
        // get a list of registered MIME types
        KeyList.Clear;
        Reg.GetKeyNames(KeyList);
        Reg.CloseKey;

        for i := 0 to KeyList.Count - 1 do begin
          if Reg.OpenKeyReadOnly('\MIME\Database\Content Type\' + KeyList[i]) then begin {do not localize}
            LExt := IndyLowerCase(Reg.ReadString('Extension'));  {do not localize}
            if Length(LExt) > 0 then begin
              if LExt[1] <> '.' then begin
                LExt := '.' + LExt; {do not localize}
              end;
              AMIMEList.Values[LExt] := IndyLowerCase(KeyList[i]);
            end;
            Reg.CloseKey;
          end;
        end;
      end;
    finally
      KeyList.Free;
    end;
  finally
    Reg.Free;
  end;
  {$ENDIF}
  {$IFDEF UNIX}
  {
    /etc/mime.types is not present in all Linux distributions.

    It turns out that "/etc/htdig/mime.types" and
    "/etc/usr/share/webmin/mime..types" are in the same format as what
    Johannes Berg had expected.

   Just read those files for best coverage.  MIME Tables are not centralized
    on Linux.
  }
  LoadMIME('/etc/mime.types', AMIMEList);                   {do not localize}
  LoadMIME('/etc/htdig/mime.types', AMIMEList);             {do not localize}
  LoadMIME('/etc/usr/share/webmin/mime.types', AMIMEList);  {do not localize}
  {$ENDIF}
end;

procedure TIdMimeTable.AddMimeType(const Ext, MIMEType: string; const ARaiseOnError: Boolean = True);
var
  LExt,
  LMIMEType: string;
begin
  { Check and fix extension }
  LExt := IndyLowerCase(Ext);
  if Length(LExt) = 0 then begin
    if ARaiseOnError then begin
      raise EIdException.Create(RSMIMEExtensionEmpty); // TODO: create a new Exception class for this
    end;
    Exit;
  end;
  { Check and fix MIMEType }
  LMIMEType := IndyLowerCase(MIMEType);
  if Length(LMIMEType) = 0 then begin
    if ARaiseOnError then begin
      raise EIdException.Create(RSMIMEMIMETypeEmpty); // TODO: create a new Exception class for this
    end;
    Exit;
  end;
  if LExt[1] <> '.' then begin    {do not localize}
    LExt := '.' + LExt;      {do not localize}
  end;
  { Check list }
  if FFileExt.IndexOf(LExt) = -1 then begin
    // TODO: multiple MIME types can belong to the same file extension.
    // Change this logic to have FFileExt contain "<ext>=<mimetype>"
    // pairs so an extension can map to a prefered MIME type, and have
    // FMIMEList contain "<mimetype>=<ext>" pairs for simple lookup.
    FFileExt.Add(LExt);
    FMIMEList.Add(LMIMEType);
  end else begin
    if ARaiseOnError then begin
      raise EIdException.Create(RSMIMEMIMEExtAlreadyExists); // TODO: create a new Exception class for this
    end;
    Exit;
  end;
end;

procedure TIdMimeTable.BuildCache;
begin
  if Assigned(FOnBuildCache) then begin
    FOnBuildCache(Self);
  end else begin
    if FFileExt.Count = 0 then begin
      BuildDefaultCache;
    end;
  end;
end;

procedure TIdMimeTable.BuildDefaultCache;
{This is just to provide some default values only}
var
  LKeys : TStringList;
begin
  LKeys := TStringList.Create;
  try
    FillMIMETable(LKeys, LoadTypesFromOS);
    LoadFromStrings(LKeys);
  finally
    FreeAndNil(LKeys);
  end;
end;

constructor TIdMimeTable.Create(const AutoFill: Boolean);
begin
  inherited Create;
  FLoadTypesFromOS := True;
  FFileExt := TStringList.Create;
  FMIMEList := TStringList.Create;
  if AutoFill then begin
    BuildCache;
  end;
end;

destructor TIdMimeTable.Destroy;
begin
  FreeAndNil(FMIMEList);
  FreeAndNil(FFileExt);
  inherited Destroy;
end;

function TIdMimeTable.GetDefaultFileExt(const MIMEType: string): String;
var
  Index : Integer;
  LMimeType: string;
begin
  LMimeType := IndyLowerCase(MIMEType);
  Index := FMIMEList.IndexOf(LMimeType);
  if Index = -1 then begin
    BuildCache;
    Index := FMIMEList.IndexOf(LMIMEType);
  end;
  if Index <> -1 then begin
    // TODO: multiple MIME types can belong to the same file extension.
    // Change this logic to have FFileExt contain "<ext>=<mimetype>"
    // pairs so an extension can map to a prefered MIME type, and have
    // FMIMEList contain "<mimetype>=<ext>" pairs for simple lookup.
    Result := FFileExt[Index];
  end else begin
    Result := '';    {Do not Localize}
  end;
end;

function TIdMimeTable.GetFileMIMEType(const AFileName: string): string;
var
  Index : Integer;
  LExt: string;
begin
  LExt := IndyLowerCase(ExtractFileExt(AFileName));

  Index := FFileExt.IndexOf(LExt);
  if Index = -1 then begin
    BuildCache;
    Index := FFileExt.IndexOf(LExt);
  end;
  if Index <> -1 then begin
    // TODO: multiple MIME types can belong to the same file extension.
    // Change this logic to have FFileExt contain "<ext>=<mimetype>"
    // pairs so an extension can map to a prefered MIME type, and have
    // FMIMEList contain "<mimetype>=<ext>" pairs for simple lookup.
    Result := FMIMEList[Index];
  end else begin
    Result := 'application/octet-stream' {do not localize}
  end;
end;

procedure TIdMimeTable.LoadFromStrings(const AStrings: TStrings; const MimeSeparator: Char = '=');    {Do not Localize}
var
  I, P: Integer;
  S, Ext: string;
begin
  Assert(AStrings <> nil);

  FFileExt.Clear;
  FMIMEList.Clear;

  for I := 0 to AStrings.Count - 1 do begin
    S := AStrings[I];
    // RLebeau 12/13/15: Calling Pos() with a Char as input creates a temporary
    // String.  Normally this is fine, but profiling reveils this to be a big
    // bottleneck for code that makes a lot of calls to Pos() in a loop, so we
    // will scan through the string looking for the character without a conversion...
    //
    // P := Pos(MimeSeparator, S);
    // if P > 0 then begin
    //
    for P := 1 to Length(S) do begin
      //if CharEquals(S, P, MimeSeparator) then begin
      if S[P] = MimeSeparator then begin
        Ext := IndyLowerCase(Copy(S, 1, P - 1));
        AddMimeType(Ext, Copy(S, P + 1, MaxInt), False);
        Break;
      end;
    end;
  end;
end;



procedure TIdMimeTable.SaveToStrings(const AStrings: TStrings;
  const MimeSeparator: Char);
var
  I : Integer;
begin
  Assert(AStrings <> nil);
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to FFileExt.Count - 1 do begin
      AStrings.Add(FFileExt[I] + MimeSeparator + FMIMEList[I]);
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

function IsValidIP(const S: String): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
begin
  LErr := False; // keep the compiler happy
  IPv4ToUInt32(S, LErr);
  if LErr then begin
    LErr := (MakeCanonicalIPv6Address(S) = '');
  end;
  Result := not LErr;
end;

//everything that does not start with '.' is treated as hostname
function IsHostname(const S: String): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (not TextStartsWith(S, '.')) and (not IsValidIP(S)) ;    {Do not Localize}
end;

function IsTopDomain(const AStr: string): Boolean;
Var
  i: Integer;
  S1,LTmp: String;
begin
  i := 0;

  LTmp := UpperCase(Trim(AStr));
  while IndyPos('.', LTmp) > 0 do begin    {Do not Localize}
    S1 := LTmp;
    Fetch(LTmp, '.');    {Do not Localize}
    i := i + 1;
  end;

  Result := ((Length(LTmp) > 2) and (i = 1));
  if Length(LTmp) = 2 then begin  // Country domain names
    S1 := Fetch(S1, '.');    {Do not Localize}
    // here will be the exceptions check: com.uk, co.uk, com.tw and etc.
    if LTmp = 'UK' then begin    {Do not Localize}
      if S1 = 'CO' then begin
        result := i = 2;    {Do not Localize}
      end;
      if S1 = 'COM' then begin
        result := i = 2;    {Do not Localize}
      end;
    end;
    if LTmp = 'TW' then begin    {Do not Localize}
      if S1 = 'CO' then begin
        result := i = 2;    {Do not Localize}
      end;
      if S1 = 'COM' then begin
        result := i = 2;    {Do not Localize}
      end;
    end;
  end;
end;

function IsDomain(const S: String): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (not IsHostname(S)) and (IndyPos('.', S) > 0) and (not IsTopDomain(S));    {Do not Localize}
end;

function DomainName(const AHost: String): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := Copy(AHost, IndyPos('.', AHost), Length(AHost));    {Do not Localize}
end;

function IsFQDN(const S: String): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IsHostName(S) and IsDomain(DomainName(S));
end;

// The password for extracting password.bin from password.zip is indyrules

function PadString(const AString : String; const ALen : Integer; const AChar: Char): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if Length(Result) >= ALen then begin
    Result := AString;
  end else begin
    Result := AString + StringOfChar(AChar, ALen-Length(AString));
  end;
end;

function ProcessPath(const ABasePath: string;
  const APath: string;
  const APathDelim: string = '/'): string;    {Do not Localize}
// Dont add / - sometimes a file is passed in as well and the only way to determine is
// to test against the actual targets
var
  i: Integer;
  LPreserveTrail: Boolean;
  LWork: string;
begin
  if TextStartsWith(APath, APathDelim) then begin
    Result := APath;
  end else begin
    Result := '';    {Do not Localize}
    LPreserveTrail := (Length(APath) = 0) or TextEndsWith(APath, APathDelim);
    LWork := ABasePath;
    // If LWork = '' then we just want it to be APath, no prefixed /    {Do not Localize}
    if (Length(LWork) > 0) and (not TextEndsWith(LWork, APathDelim)) then begin
      LWork := LWork + APathDelim;
    end;
    LWork := LWork + APath;
    if Length(LWork) > 0 then begin
      i := 1;
      while i <= Length(LWork) do begin
        if LWork[i] = APathDelim then begin
          if i = 1 then begin
            Result := APathDelim;
          end
          else if not TextEndsWith(Result, APathDelim) then begin
            Result := Result + LWork[i];
          end;
        end else begin
          if LWork[i] = '.' then begin    {Do not Localize}
            // If the last character was a PathDelim then the . is a relative path modifier.
            // If it doesnt follow a PathDelim, its part of a filename
            if TextEndsWith(Result, APathDelim) and (Copy(LWork, i, 2) = '..') then begin    {Do not Localize}
              // Delete the last PathDelim
              Delete(Result, Length(Result), 1);
              // Delete up to the next PathDelim
              while (Length(Result) > 0) and (not TextEndsWith(Result, APathDelim)) do begin
                Delete(Result, Length(Result), 1);
              end;
              // Skip over second .
              Inc(i);
            end else begin
              Result := Result + LWork[i];
            end;
          end else begin
            Result := Result + LWork[i];
          end;
        end;
        Inc(i);
      end;
    end;
    // Sometimes .. semantics can put a PathDelim on the end
    // But dont modify if it is only a PathDelim and nothing else, or it was there to begin with
    if (Result <> APathDelim) and TextEndsWith(Result, APathDelim) and (not LPreserveTrail) then begin
      Delete(Result, Length(Result), 1);
    end;
  end;
end;

{** HTML Parsing code for extracting Metadata.  It can also be the basis of a Full HTML parser ***}

const
 HTML_DOCWHITESPACE = #0+#9+#10+#13+#32;                       {do not localize}
 HTML_ALLOWABLE_ALPHANUMBERIC = 'abcdefghijklmnopqrstuvwxyz'+  {do not localize}
         'ABCDEFGHIJKLMNOPQRSTUVWXYZ'+                         {do not localize}
         '1234567890-_:.';                                     {do not localize}
 HTML_QUOTECHARS = '''"';                                      {do not localize}
 HTML_MainDocParts : array [0..2] of string = ('TITLE','HEAD', 'BODY'); {do not localize}
 HTML_HeadDocAttrs : array [0..3] of string = ('META','TITLE','SCRIPT','LINK'); {do not localize}
 HTML_MetaAttrs : array [0..1] of string = ('HTTP-EQUIV', 'charset'); {do not localize}

function ParseUntilEndOfTag(const AStr : String; var VPos : Integer;
  const ALen : Integer): String; {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LStart: Integer;
begin
  LStart := VPos;
  while VPos <= ALen do begin
    if AStr[VPos] = '>' then begin {do not localize}
      Break;
    end;
    Inc(VPos);
  end;
  Result := Copy(AStr, LStart, VPos - LStart);
end;

procedure DiscardUntilEndOfTag(const AStr : String; var VPos : Integer;
  const ALen : Integer); {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  while VPos <= ALen do begin
    if AStr[VPos] = '>' then begin {do not localize}
      Break;
    end;
    Inc(VPos);
  end;
end;

function ExtractDocWhiteSpace(const AStr : String; var VPos : Integer;
  const ALen : Integer) : String;  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LStart: Integer;
begin
  LStart := VPos;
  while VPos <= ALen do begin
    if not CharIsInSet(AStr, VPos, HTML_DOCWHITESPACE) then begin
      Break;
    end;
    Inc(VPos);
  end;
  Result := Copy(AStr, LStart, VPos-LStart);
end;

procedure DiscardDocWhiteSpace(const AStr : String; var VPos : Integer; const ALen : Integer);  {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  while VPos <= ALen do begin
    if not CharIsInSet(AStr, VPos, HTML_DOCWHITESPACE) then begin
      Break;
    end;
    Inc(VPos);
  end;
end;

function ParseWord(const AStr : String; var VPos : Integer;
  const ALen : Integer) : String;  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LStart: Integer;
begin
  LStart := VPos;
  while VPos <= ALen do begin
    if not CharIsInSet(AStr, VPos, HTML_ALLOWABLE_ALPHANUMBERIC) then begin
      Break;
    end;
    Inc(VPos);
  end;
  Result := Copy(AStr, LStart, VPos-LStart);
end;

procedure DiscardWord(const AStr : String; var VPos : Integer;
  const ALen : Integer);  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  while VPos <= ALen do begin
    if not CharIsInSet(AStr, VPos, HTML_ALLOWABLE_ALPHANUMBERIC) then begin
      Break;
    end;
    Inc(VPos);
  end;
end;

function ParseUntil(const AStr : String; const AChar : Char;
  var VPos : Integer; const ALen : Integer) : String;  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LStart: Integer;
begin
  LStart := VPos;
  while VPos <= ALen do begin
    if AStr[VPos] = AChar then begin
      Break;
    end;
    Inc(VPos);
  end;
  Result := Copy(AStr, LStart, VPos-LStart);
end;

procedure DiscardUntil(const AStr : String; const AChar : Char;
  var VPos : Integer; const ALen : Integer);  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  while VPos <= ALen do begin
    if AStr[VPos] = AChar then begin
      Break;
    end;
    Inc(VPos);
  end;
end;

function ParseUntilCharOrEndOfTag(const AStr : String; const AChar: Char;
  var VPos : Integer; const ALen : Integer): String; {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LStart: Integer;
begin
  LStart := VPos;
  while VPos <= ALen do begin
    if (AStr[VPos] = AChar) or (AStr[VPos] = '>') then begin {do not localize}
      Break;
    end;
    Inc(VPos);
  end;
  Result := Copy(AStr, LStart, VPos - LStart);
end;

procedure DiscardUntilCharOrEndOfTag(const AStr : String; const AChar: Char;
  var VPos : Integer; const ALen : Integer); {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  while VPos <= ALen do begin
    if (AStr[VPos] = AChar) or (AStr[VPos] = '>') then begin {do not localize}
      Break;
    end;
    Inc(VPos);
  end;
end;

function ParseHTTPMetaEquiveData(const AStr : String; var VPos : Integer;
  const ALen : Integer) : String;  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LQuoteChar : Char;
  LWord : String;
begin
  Result := '';
  DiscardDocWhiteSpace(AStr, VPos, ALen);
  if CharIsInSet(AStr, VPos, HTML_QUOTECHARS) then begin
    LQuoteChar := AStr[VPos];
    Inc(VPos);
    if VPos > ALen then begin
      Exit;
    end;
    LWord := ParseUntil(AStr, LQuoteChar, VPos, ALen);
    Inc(VPos);
  end else begin
    if VPos > ALen then begin
      Exit;
    end;
    LWord := ParseWord(AStr, VPos, ALen);
  end;
  Result := LWord + ':'; {do not localize}
  repeat
    DiscardDocWhiteSpace(AStr, VPos, ALen);
    if VPos > ALen then begin
      Break;
    end;
    if AStr[VPos] = '/' then begin {do not localize}
      Inc(VPos);
      if VPos > ALen then begin
        Break;
      end;
    end;
    if AStr[VPos] = '>' then begin {do not localize}
      Break;
    end;
    LWord := ParseWord(AStr, VPos, ALen);
    if VPos > ALen then begin
      Break;
    end;
    if AStr[VPos] = '=' then begin {do not localize}
      Inc(VPos);
      DiscardDocWhiteSpace(AStr, VPos, ALen);
      if CharIsInSet(AStr, VPos, HTML_QUOTECHARS) then begin
        LQuoteChar := AStr[VPos];
        Inc(VPos);
        if TextIsSame(LWord, 'CONTENT') then begin
          Result := Result + ' ' + ParseUntil(AStr, LQuoteChar, VPos, ALen);
          Inc(VPos);
          // RLebeau: this is a special case for handling a malformed tag
          // that was encountered in the wild:
          // <meta http-equiv="Content-Type" content="text/html; charset="window-1255">
          if VPos > ALen then begin
            Break;
          end;
          if CharIsInSet(AStr, VPos, HTML_DOCWHITESPACE + '/>') then begin
            Continue;
          end;
          Result := Result + ParseUntil(AStr, LQuoteChar, VPos, ALen);
          Inc(VPos);
        end else begin
          DiscardUntil(AStr, LQuoteChar, VPos, ALen);
          Inc(VPos);
        end;
      end else begin
        if TextIsSame(LWord, 'CONTENT') then begin
          Result := Result + ' ' + ParseUntilCharOrEndOfTag(AStr, ' ', VPos, ALen); {do not localize}
        end else begin
          DiscardUntilCharOrEndOfTag(AStr, ' ', VPos, ALen); {do not localize}
        end;
      end;
    end else begin
      Inc(VPos);
    end;
  until False;
end;

function ParseMetaCharsetData(const AStr : String; var VPos : Integer;
  const ALen : Integer) : String;  {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LQuoteChar : Char;
  LWord : String;
begin
  Result := '';
  DiscardDocWhiteSpace(AStr, VPos, ALen);
  if CharIsInSet(AStr, VPos, HTML_QUOTECHARS) then begin
    LQuoteChar := AStr[VPos];
    Inc(VPos);
    if VPos > ALen then begin
      Exit;
    end;
    LWord := ParseUntil(AStr, LQuoteChar, VPos, ALen);
    Inc(VPos);
  end else begin
    if VPos > ALen then begin
      Exit;
    end;
    LWord := ParseWord(AStr, VPos, ALen);
  end;
  DiscardUntilEndOfTag(AStr, VPos, ALen);
  Result := LWord;
end;

procedure DiscardToEndOfComment(const AStr : String; var VPos : Integer; const ALen : Integer);  {$IFDEF USE_INLINE}inline; {$ENDIF}
var
  i : Integer;
begin
  DiscardUntil(AStr, '-', VPos, ALen); {do not localize}
  i := 0;
  while VPos <= ALen do begin
    if AStr[VPos] = '-' then begin {do not localize}
      if i < 2 then begin
        Inc(i);
      end;
    end else begin
      if (AStr[VPos] = '>') and (i = 2) then begin {do not localize}
        Break;
      end;
      i := 0;
    end;
    Inc(VPos);
  end;
end;

function ParseForCloseTag(const AStr, ATagWord : String; var VPos : Integer; const ALen : Integer) : String; {$IFDEF USE_INLINE}inline; {$ENDIF}
var
  LWord, LTmp : String;
begin
  Result := '';
  while VPos <= ALen do begin
    Result := Result + ParseUntil(AStr, '<', VPos, ALen); {do not localize}
    if AStr[VPos] = '<' then begin
      Inc(VPos);
    end;
    LTmp := '<' + ExtractDocWhiteSpace(AStr, VPos, ALen); {do not localize}
    if AStr[VPos] = '/' then begin {do not localize}
      Inc(VPos);
      LTmp := LTmp + '/'; {do not localize}
      LWord := ParseWord(AStr, VPos, ALen);
      if TextIsSame(LWord, ATagWord) then begin
        DiscardUntilEndOfTag(AStr, VPos, ALen);
        Break;
      end;
    end;
    Result := Result + LTmp + LWord + ParseUntilEndOfTag(AStr, VPos, ALen); {do not localize}
    Inc(VPos);
  end;
end;

procedure DiscardUntilCloseTag(const AStr, ATagWord : String; var VPos : Integer;
  const ALen : Integer; const AIsScript : Boolean = False);  {$IFDEF USE_INLINE}inline; {$ENDIF}
var
  LWord, LTmp : String;
begin
  while VPos <= ALen do begin
    DiscardUntil(AStr, '<', VPos, ALen); {do not localize}
    if AStr[VPos] = '<' then begin {do not localize}
      Inc(VPos);
    end;
    LTmp := '<' + ExtractDocWhiteSpace(AStr, VPos, ALen);
    if AStr[VPos] = '/' then begin {do not localize}
      Inc(VPos);
      LTmp := LTmp + '/'; {do not localize}
      LWord := ParseWord(AStr, VPos, ALen);
      if TextIsSame(LWord, ATagWord) then begin
        DiscardUntilEndOfTag(AStr, VPos, ALen);
        Break;
      end;
    end;
    if not AIsScript then begin
      DiscardUntilEndOfTag(AStr, VPos, ALen);
    end;
    Inc(VPos);
  end;
end;

procedure ParseMetaHTTPEquiv(AStream: TStream; AHeaders : TStrings; var VCharSet: string);
type
  TIdHTMLMode = (none, html, title, head, body, comment);
var
  LRawData : String;
  LWord : String;
  LMode : TIdHTMLMode;
  LPos : Integer;
  LLen : Integer;
  LEncoding: IIdTextEncoding;
begin
  VCharSet :=  '';
  {if AHeaders <> nil then begin
    AHeaders.Clear;
  end;}
  if AStream = nil then begin
    Exit; // just in case
  end;
  AStream.Position := 0;
  LEncoding := IndyTextEncoding_8Bit;
  // TODO: parse the stream as-is without reading it into a String first...
  LRawData := ReadStringFromStream(AStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  LEncoding := nil;
  LMode := none;
  LPos := 0;
  LLen := Length(LRawData);
  if AHeaders <> nil then begin
    AHeaders.BeginUpdate;
  end;
  try
    repeat
      Inc(LPos);
      if LPos > LLen then begin
        Break;
      end;
      if LRawData[LPos] = '<' then begin {do not localize}
        Inc(LPos);
        if LPos > LLen then begin
          Break;
        end;
        if LRawData[LPos] = '?' then begin {do not localize}
          Inc(LPos);
          if LPos > LLen then begin
            Break;
          end;
        end
        else if LRawData[LPos] = '!' then begin {do not localize}
          Inc(LPos);
          if LPos > LLen then begin
            Break;
          end;
          //we have to handle comments separately since they appear in any mode.
          if Copy(LRawData, LPos, 2) = '--' then begin {do not localize}
            Inc(LPos, 2);
            DiscardToEndOfComment(LRawData, LPos, LLen);
            Continue;
          end;
        end;
        DiscardDocWhiteSpace(LRawData, LPos, LLen);
        LWord := ParseWord(LRawData, LPos, LLen);
        case LMode of
          none :
          begin
            DiscardUntilEndOfTag(LRawData, LPos, LLen);
            if TextIsSame(LWord, 'HTML') then begin
              LMode := html;
            end;
          end;
          html :
          begin
            DiscardUntilEndOfTag(LRawData, LPos, LLen);
            case PosInStrArray(LWord, HTML_MainDocParts, False) of
              0 : LMode := title;//title
              1 : LMode := head; //head
              2 : LMode := body; //body
            end;
          end;
          head :
          begin
            case PosInStrArray(LWord, HTML_HeadDocAttrs, False) of
              0 : //'META'
              begin
                DiscardDocWhiteSpace(LRawData, LPos, LLen);
                LWord := ParseWord(LRawData, LPos, LLen);
                // '<meta http-equiv="..." content="...">'
                // '<meta charset="...">' (used in HTML5)
                // TODO: use ParseUntilEndOfTag() here
                case PosInStrArray(LWord, HTML_MetaAttrs, False) of {do not localize}
                  0: // HTTP-EQUIV
                  begin
                    DiscardDocWhiteSpace(LRawData, LPos, LLen);
                    if LRawData[LPos] = '=' then begin {do not localize}
                      Inc(LPos);
                      if LPos > LLen then begin
                        Break;
                      end;
                      if AHeaders <> nil then begin
                        AHeaders.Add( ParseHTTPMetaEquiveData(LRawData, LPos, LLen) );
                      end else begin
                        ParseHTTPMetaEquiveData(LRawData, LPos, LLen);
                      end;
                    end;
                  end;
                  1: // charset
                  begin
                    DiscardDocWhiteSpace(LRawData, LPos, LLen);
                    if LRawData[LPos] = '=' then begin {do not localize}
                      Inc(LPos);
                      if LPos > LLen then begin
                        Break;
                      end;
                      VCharset := ParseMetaCharsetData(LRawData, LPos, LLen);
                    end;
                  end;
                else
                  DiscardUntilEndOfTag(LRawData, LPos, LLen);
                end;
              end;
              1 :  //'TITLE'
              begin
                DiscardUntilEndOfTag(LRawData, LPos, LLen);
                DiscardUntilCloseTag(LRawData, 'TITLE', LPos, LLen); {do not localize}
              end;
              2 : //'SCRIPT'
              begin
                DiscardUntilEndOfTag(LRawData, LPos, LLen);
                DiscardUntilCloseTag(LRawData, 'SCRIPT', LPos, LLen, True); {do not localize}
              end;
              3 : //'LINK'
              begin
                DiscardUntilEndOfTag(LRawData, LPos, LLen); {do not localize}
              end;
            end;
          end;
          body: begin
            Exit;
          end;
        end;
      end;
    until False;
  finally
    if AHeaders <> nil then begin
      AHeaders.EndUpdate;
    end;
  end;
end;

{*************************************************************************************************}

// make sure that an RFC MsgID has angle brackets on it
function EnsureMsgIDBrackets(const AMsgID: String): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := AMsgID;
  if Length(Result) > 0 then begin
    if Result[1] <> '<' then begin {do not localize}
      Result := '<' + Result; {do not localize}
    end;
    if Result[Length(Result)] <> '>' then begin {do not localize}
      Result := Result + '>'; {do not localize}
    end;
  end;
end;

function ExtractHeaderItem(const AHeaderLine: String): String;
var
  s: string;
begin
  // Store in s and not Result because of Fetch semantics
  s := AHeaderLine;
  Result := Trim(Fetch(s, ';')); {do not localize}
end;

const
  QuoteSpecials: array[TIdHeaderQuotingType] of String = (
    {Plain } '',                    {do not localize}
    {RFC822} '()<>@,;:\"./',        {do not localize}
    {MIME  } '()<>@,;:\"/[]?=',     {do not localize}
    {HTTP  } '()<>@,;:\"/[]?={} '#9 {do not localize}
    );

{$IFDEF USE_OBJECT_ARC}
// Under ARC, SplitHeaderSubItems() cannot put a non-TObject pointer value in
// the TStrings.Objects[] property...
type
  TIdHeaderNameValueItem = record
    Name, Value: String;
    Quoted: Boolean;
    constructor Create(const AName, AValue: String; const AQuoted: Boolean);
  end;

  TIdHeaderNameValueList = class(TList<TIdHeaderNameValueItem>)
  public
    function GetValue(const AName: string): string;
    function IndexOfName(const AName: string): Integer;
    procedure SetValue(const AIndex: Integer; const AValue: String);
  end;

constructor TIdHeaderNameValueItem.Create(const AName, AValue: String; const AQuoted: Boolean);
begin
  Name := AName;
  Value := AValue;
  Quoted := AQuoted;
end;

function TIdHeaderNameValueList.GetValue(const AName: string): string;
var
  I: Integer;
begin
  I := IndexOfName(AName);
  if I <> -1  then begin
    Result := Items[I].Value;
  end else begin
    Result := '';
  end;
end;

function TIdHeaderNameValueList.IndexOfName(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count-1 do
  begin
    if TextIsSame(Items[I].Name, AName) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TIdHeaderNameValueList.SetValue(const AIndex: Integer; const AValue: String);
var
  LItem: TIdHeaderNameValueItem;
begin
  LItem := Items[AIndex];
  LItem.Value := AValue;
  Items[AIndex] := LItem;
end;
{$ENDIF}

procedure SplitHeaderSubItems(AHeaderLine: String;
  AItems: {$IFDEF USE_OBJECT_ARC}TIdHeaderNameValueList{$ELSE}TStrings{$ENDIF};
  AQuoteType: TIdHeaderQuotingType);
var
  LName, LValue, LSep: String;
  LQuoted: Boolean;
  I: Integer;

  function FetchQuotedString(var VHeaderLine: string): string;
  begin
    Result := '';
    Delete(VHeaderLine, 1, 1);
    I := 1;
    while I <= Length(VHeaderLine) do begin
      if VHeaderLine[I] = '\' then begin
        // TODO: disable this logic for HTTP 1.0
        if I < Length(VHeaderLine) then begin
          Delete(VHeaderLine, I, 1);
        end;
      end
      else if VHeaderLine[I] = '"' then begin
        Result := Copy(VHeaderLine, 1, I-1);
        VHeaderLine := Copy(VHeaderLine, I+1, MaxInt);
        Break;
      end;
      Inc(I);
    end;
    Fetch(VHeaderLine, ';');
  end;

begin
  Fetch(AHeaderLine, ';'); {do not localize}
  LSep := CharRange(#0, #32) + QuoteSpecials[AQuoteType] + #127;
  while AHeaderLine <> '' do
  begin
    AHeaderLine := TrimLeft(AHeaderLine);
    if AHeaderLine = '' then begin
      Exit;
    end;
    LName := Trim(Fetch(AHeaderLine, '=')); {do not localize}
    AHeaderLine := TrimLeft(AHeaderLine);
    LQuoted := TextStartsWith(AHeaderLine, '"'); {do not localize}
    if LQuoted then
    begin
      LValue := FetchQuotedString(AHeaderLine);
    end else begin
      I := FindFirstOf(LSep, AHeaderLine);
      if I <> 0 then
      begin
        LValue := Copy(AHeaderLine, 1, I-1);
        if AHeaderLine[I] = ';' then begin {do not localize}
          Inc(I);
        end;
        Delete(AHeaderLine, 1, I-1);
      end else begin
        LValue := AHeaderLine;
        AHeaderLine := '';
      end;
    end;
    if (LName <> '') and ((LValue <> '') or LQuoted) then begin
      {$IFDEF USE_OBJECT_ARC}
      AItems.Add(TIdHeaderNameValueItem.Create(LName, LValue, LQuoted));
      {$ELSE}
      IndyAddPair(AItems, LName, LValue, TObject(LQuoted));
      {$ENDIF}
    end;
  end;
end;

function ExtractHeaderSubItem(const AHeaderLine, ASubItem: String;
  AQuoteType: TIdHeaderQuotingType): String;
var
  LItems: {$IFDEF USE_OBJECT_ARC}TIdHeaderNameValueList{$ELSE}TStringList{$ENDIF};
  {$IFNDEF USE_OBJECT_ARC}
    {$IFNDEF HAS_TStringList_CaseSensitive}
  I: Integer;
    {$ENDIF}
  {$ENDIF}
begin
  Result := '';
  // TODO: instead of splitting the header into a list of name=value pairs,
  // allocating memory for it, just parse the input string in-place and extract
  // the necessary substring from it...
  LItems := {$IFDEF USE_OBJECT_ARC}TIdHeaderNameValueList{$ELSE}TStringList{$ENDIF}.Create;
  try
    SplitHeaderSubItems(AHeaderLine, LItems, AQuoteType);
    {$IFDEF USE_OBJECT_ARC}
    Result := LItems.GetValue(ASubItem);
    {$ELSE}
      {$IFDEF HAS_TStringList_CaseSensitive}
    LItems.CaseSensitive := False;
    Result := LItems.Values[ASubItem];
      {$ELSE}
    I := IndyIndexOfName(LItems, ASubItem);
    if I <> -1 then begin
      Result := IndyValueFromIndex(LItems, I);
    end;
      {$ENDIF}
    {$ENDIF}
  finally
    LItems.Free;
  end;
end;

function ReplaceHeaderSubItem(const AHeaderLine, ASubItem, AValue: String;
  AQuoteType: TIdHeaderQuotingType): String;
var
  LOld: String;
begin
  Result := ReplaceHeaderSubItem(AHeaderLine, ASubItem, AValue, LOld, AQuoteType);
end;

function ReplaceHeaderSubItem(const AHeaderLine, ASubItem, AValue: String;
  var VOld: String; AQuoteType: TIdHeaderQuotingType): String;
var
  LItems: {$IFDEF USE_OBJECT_ARC}TIdHeaderNameValueList{$ELSE}TStringList{$ENDIF};
  I: Integer;
  LValue: string;

  function QuoteString(const S: String; const AForceQuotes: Boolean): String;
  var
    I: Integer;
    LAddQuotes: Boolean;
    LNeedQuotes, LNeedEscape: String;
  begin
    Result := '';
    if Length(S) = 0 then begin
      Exit;
    end;
    LAddQuotes := AForceQuotes;
    LNeedQuotes := CharRange(#0, #32) + QuoteSpecials[AQuoteType] + #127;
    // TODO: disable this logic for HTTP 1.0
    LNeedEscape := '"\'; {Do not Localize}
    if AQuoteType in [QuoteRFC822, QuoteMIME] then begin
      LNeedEscape := LNeedEscape + CR; {Do not Localize}
    end;
    for I := 1 to Length(S) do begin
      if CharIsInSet(S, I, LNeedEscape) then begin
        LAddQuotes := True;
        Result := Result + '\'; {do not localize}
      end
      else if CharIsInSet(S, I, LNeedQuotes) then begin
        LAddQuotes := True;
      end;
      Result := Result + S[I];
    end;
    if LAddQuotes then begin
      Result := '"' + Result + '"';
    end;
  end;

begin
  Result := '';
  // TODO: instead of splitting the header into a list of name=value pairs,
  // allocating memory for it, and then putting the list back together, just
  // parse the input string in-place and extract/replace the necessary
  // substring from it as needed, preserving the rest of the string as-is...
  LItems := {$IFDEF USE_OBJECT_ARC}TIdHeaderNameValueList{$ELSE}TStringList{$ENDIF}.Create;
  try
    SplitHeaderSubItems(AHeaderLine, LItems, AQuoteType);
    {$IFDEF USE_OBJECT_ARC}
    I := LItems.IndexOfName(ASubItem);
    {$ELSE}
      {$IFDEF HAS_TStringList_CaseSensitive}
    LItems.CaseSensitive := False;
      {$ENDIF}
    I := IndyIndexOfName(LItems, ASubItem);
    {$ENDIF}
    if I >= 0 then begin
      {$IFDEF USE_OBJECT_ARC}
      VOld := LItems[I].Value;
      {$ELSE}
      VOld := LItems.Strings[I];
      Fetch(VOld, '=');
      {$ENDIF}
    end else begin
      VOld := '';
    end;
    LValue := Trim(AValue);
    if LValue <> '' then begin
      {$IFDEF USE_OBJECT_ARC}
      if I < 0 then begin
        LItems.Add(TIdHeaderNameValueItem.Create(ASubItem, LValue, False));
      end else begin
        LItems.SetValue(I, LValue);
      end;
      {$ELSE}
      if I < 0 then begin
        IndyAddPair(LItems, ASubItem, LValue);
      end else begin
        {$IFDEF HAS_TStrings_ValueFromIndex}
        LItems.ValueFromIndex[I] := LValue;
        {$ELSE}
        LItems.Strings[I] := ASubItem + '=' + LValue; {do not localize}
        {$ENDIF}
      end;
      {$ENDIF}
    end
    else if I < 0 then begin
      // subitem not found, just return the original header as-is...
      Result := AHeaderLine;
      Exit;
    end else begin
      LItems.Delete(I);
    end;
    Result := ExtractHeaderItem(AHeaderLine);
    if Result <> '' then begin
      for I := 0 to LItems.Count-1 do begin
        {$IFDEF USE_OBJECT_ARC}
        Result := Result + '; ' + LItems[I].Name + '=' + QuoteString(LItems[I].Value, LItems[I].Quoted); {do not localize}
        {$ELSE}
        Result := Result + '; ' + LItems.Names[I] + '=' + QuoteString(IndyValueFromIndex(LItems, I), Boolean(LItems.Objects[I])); {do not localize}
        {$ENDIF}
      end;
    end;
  finally
    LItems.Free;
  end;
end;

function MediaTypeMatches(const AValue, AMediaType: String): Boolean;
begin
  if Pos('/', AMediaType) > 0 then begin {do not localize}
    Result := TextIsSame(AValue, AMediaType);
  end else begin
    Result := TextStartsWith(AValue, AMediaType + '/'); {do not localize}
  end;
end;

function IsHeaderMediaType(const AHeaderLine, AMediaType: String): Boolean;
begin
  Result := MediaTypeMatches(ExtractHeaderItem(AHeaderLine), AMediaType);
end;

function IsHeaderMediaTypes(const AHeaderLine: String; const AMediaTypes: array of String): Boolean;
var
  LHeader: String;
  I: Integer;
begin
  Result := False;
  LHeader := ExtractHeaderItem(AHeaderLine);
  for I := Low(AMediaTypes) to High(AMediaTypes) do begin
    if MediaTypeMatches(LHeader, AMediaTypes[I]) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function ExtractHeaderMediaType(const AHeaderLine: String): String;
var
  S: String;
  I: Integer;
begin
  S := ExtractHeaderItem(AHeaderLine);
  I := Pos('/', S);
  if I > 0 then begin
    Result := Copy(S, 1, I-1);
  end else begin
    Result := '';
  end;
end;

function ExtractHeaderMediaSubType(const AHeaderLine: String): String;
var
  S: String;
  I: Integer;
begin
  S := ExtractHeaderItem(AHeaderLine);
  I := Pos('/', S);
  if I > 0 then begin
    Result := Copy(S, I+1, Length(S));
  end else begin
    Result := '';
  end;
end;

function IsHeaderValue(const AHeaderLine: String; const AValue: String): Boolean;
begin
  Result := TextIsSame(ExtractHeaderItem(AHeaderLine), AValue);
end;

function IsHeaderValue(const AHeaderLine: String; const AValues: array of String): Boolean;
begin
  Result := PosInStrArray(ExtractHeaderItem(AHeaderLine), AValues, False) <> -1;
end;

function GetClockValue : Int64;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ELSE}
  {$IFDEF WINDOWS}
type
  TInt64Rec = record
    case Integer of
      0 : (High : UInt32;
           Low : UInt32);
      1 : (Long : Int64);
    end;

var
  LFTime : TFileTime;
  {$ELSE}
    {$IFDEF UNIX}
      {$IFNDEF USE_VCL_POSIX}
var
  TheTms: tms;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}

  Result := System.DateTime.Now.Ticks;

  {$ELSE}
    {$IFDEF WINDOWS}

      {$IFDEF WINCE}
      // TODO
      {$ELSE}
  Windows.GetSystemTimeAsFileTime(LFTime);
  TInt64Rec(Result).Low := LFTime.dwLowDateTime;
  TInt64Rec(Result).High := LFTime.dwHighDateTime;
      {$ENDIF}

    {$ELSE}
      {$IFDEF UNIX}

        //Is the following correct?
        {$IFDEF USE_VCL_POSIX}
  Result := time(nil);
        {$ELSE}
          {$IFDEF KYLIXCOMPAT}
  Result := Times(TheTms);
          {$ELSE}
            {$IFDEF USE_BASEUNIX}
  Result := fptimes(TheTms);
            {$ELSE}
              {$message error time is not called on this platform!}
            {$ENDIF}
          {$ENDIF}
        {$ENDIF}

      {$ELSE}
        {$message error GetClockValue is not implemented on this platform!}
      {$ENDIF}

    {$ENDIF}
  {$ENDIF}
end;

// TODO: should we just get rid of the inline assembly here and let the compiler generate opcode as needed?
{$UNDEF NO_NATIVE_ASM}
{$IFDEF DOTNET}
  {$DEFINE NO_NATIVE_ASM}
{$ENDIF}
{$IFDEF IOS}
  {$IFDEF CPUARM}
    {$DEFINE NO_NATIVE_ASM}
  {$ENDIF}
{$ENDIF}
{$IFDEF OSX} // !!! ADDED OSX BY EMBT
  {$IFDEF CPUX64}
    {$DEFINE NO_NATIVE_ASM}
  {$ENDIF}
  {$IFDEF CPUARM64}
    {$DEFINE NO_NATIVE_ASM}
  {$ENDIF}
{$ENDIF}
{$IFDEF ANDROID}
  {$DEFINE NO_NATIVE_ASM}
{$ENDIF}
{$IFDEF FPC}
  {$IFNDEF CPUI386}
    {$DEFINE NO_NATIVE_ASM}
  {$ENDIF}
{$ENDIF}
{$IFDEF LINUX64}
  {$DEFINE NO_NATIVE_ASM}
{$ENDIF}

{$IFDEF NO_NATIVE_ASM}

function ROL(const AVal: UInt32; AShift: Byte): UInt32;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (AVal shl AShift) or (AVal shr (32 - AShift));
end;

function ROR(const AVal: UInt32; AShift: Byte): UInt32;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (AVal shr AShift) or (AVal shl (32 - AShift)) ;
end;

{$ELSE}

// 32-bit: Arg1=EAX, Arg2=DL
// 64-bit: Arg1=ECX, Arg2=DL
function ROL(const AVal: UInt32; AShift: Byte): UInt32; assembler;
asm
  {$IFDEF CPU64}
  mov eax, ecx
  {$ENDIF}
  mov  cl, dl
  rol  eax, cl
end;

function ROR(const AVal: UInt32; AShift: Byte): UInt32; assembler;
asm
  {$IFDEF CPU64}
  mov eax, ecx
  {$ENDIF}
  mov  cl, dl
  ror  eax, cl
end;
{$ENDIF}

function IndyComputerName: string;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ENDIF}
{$IFDEF UNIX}
const
  sMaxHostName = 255;
var
  LHost: array[0..sMaxHostName] of TIdAnsiChar;
  {$IFDEF USE_MARSHALLED_PTRS}
  LHostPtr: TPtrWrapper;
  {$ENDIF}
{$ENDIF}
{$IFDEF WINDOWS}
var
  {$IFDEF WINCE}
  Reg: TRegistry;
  {$ELSE}
  LHost: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  i: DWORD;
  {$ENDIF}
{$ENDIF}
begin
  Result := '';

  {$IFDEF UNIX}
  //TODO: No need for LHost at all? Prob can use just Result
    {$IFDEF KYLIXCOMPAT}
  if GetHostname(LHost, sMaxHostName) <> -1 then begin
    Result := String(LHost);
  end;
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
  Result := GetHostName;
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
      {$IFDEF USE_MARSHALLED_PTRS}
  LHostPtr := TPtrWrapper.Create(@LHost[0]);
      {$ENDIF}
  if Posix.Unistd.gethostname(
    {$IFDEF USE_MARSHALLED_PTRS}
    LHostPtr.ToPointer
    {$ELSE}
    LHost
    {$ENDIF},
    sMaxHostName) <> -1 then
  begin
    LHost[sMaxHostName] := TIdAnsiChar(0);
    {$IFDEF USE_MARSHALLED_PTRS}
    Result := TMarshal.ReadStringAsAnsi(LHostPtr);
    {$ELSE}
    Result := String(LHost);
    {$ENDIF}
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFDEF WINCE}
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('\Ident') then begin
      Result := Reg.ReadString('Name');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
    {$ELSE}
  i := MAX_COMPUTERNAME_LENGTH;
  if {$IFDEF STRING_IS_UNICODE}GetComputerNameW{$ELSE}GetComputerNameA{$ENDIF}(LHost, i) then begin
    SetString(Result, LHost, i);
    {$IFDEF STRING_IS_ANSI}
    // on compilers that support AnsiString codepages,
    // set the string's codepage to match the OS...
      {$IFDEF HAS_SetCodePage}
    SetCodePage(PRawByteString(@Result)^, GetACP(), False);
      {$ENDIF}
    {$ENDIF}
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DOTNET}
  Result := Environment.MachineName;
  {$ENDIF}
end;

{$IFDEF STRING_IS_ANSI}
function IsLeadChar(ACh : Char): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := ACh in LeadBytes;
end;
{$ENDIF}

function IdGetDefaultCharSet: TIdCharSet;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  {$IFDEF UNIX}
  Result := GIdDefaultCharSet;
  {$ENDIF}
  {$IFDEF DOTNET}
  Result := idcs_UNICODE_1_1;
  // not a particular Unicode encoding - just unicode in general
  // i.e. DotNet native string is 2 byte Unicode, we do not concern ourselves
  // with Byte order. (though we have to concern ourselves once we start
  // writing to some stream or Bytes
  {$ENDIF}
  {$IFDEF WINDOWS}
  // Many defaults are set here when the choice is ambiguous. However for
  // IdMessage OnInitializeISO can be used by user to choose other.
  case SysLocale.PriLangID of
    LANG_CHINESE: begin
      if SysLocale.SubLangID = SUBLANG_CHINESE_SIMPLIFIED then begin
        Result := idcs_GB2312;
      end else begin
        Result := idcs_Big5;
      end;
    end;
    LANG_JAPANESE: Result := idcs_ISO_2022_JP;
    LANG_KOREAN: Result := idcs_csEUCKR;
    // Kudzu
    // 1251 is the Windows standard for Russian but its not used in emails.
    // KOI8-R is by far the most widely used and thus the default.
    LANG_RUSSIAN: Result := idcs_KOI8_R;
    // Kudzu
    // Ukranian is about 50/50 KOI8u and 1251, but 1251 is the newer one and
    // the Windows one so we default to it.
    LANG_UKRAINIAN: Result := idcs_windows_1251;
    else begin
      {$IFDEF STRING_IS_UNICODE}
      Result := idcs_UNICODE_1_1;
      // not a particular Unicode encoding - just unicode in general
      // i.e. Delphi/C++Builder 2009+ native string is 2 byte Unicode,
      // we do not concern ourselves with Byte order. (though we have
      // to concern ourselves once we start writing to some stream or
      // Bytes
      {$ELSE}
      Result := idcs_ISO_8859_1;
      {$ENDIF}
    end;
  end;
  {$ENDIF}
end;

//The following is for working on email headers and message part headers.
//For example, to remove the boundary from the ContentType header, call
//ContentType := RemoveHeaderEntry(ContentType, 'boundary', QuoteMIME);
function RemoveHeaderEntry(const AHeader, AEntry: string;
  AQuoteType: TIdHeaderQuotingType): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ReplaceHeaderSubItem(AHeader, AEntry, '', AQuoteType);
end;

function RemoveHeaderEntry(const AHeader, AEntry: string; var VOld: String;
  AQuoteType: TIdHeaderQuotingType): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ReplaceHeaderSubItem(AHeader, AEntry, '', VOld, AQuoteType);
end;

function RemoveHeaderEntries(const AHeader: string; const AEntries: array of string;
  AQuoteType: TIdHeaderQuotingType): string;
var
  I: Integer;
begin
  Result := AHeader;
  if Length(AEntries) > 0 then begin
    for I := Low(AEntries) to High(AEntries) do begin
      Result := ReplaceHeaderSubItem(Result, AEntries[I], '', AQuoteType);
    end;
  end;
end;

{
  Three functions for easier manipulating of strings.  Don't know of any
  system functions to perform these actions.  If there aren't and someone
  can find an optimised way of performing then please implement...
}
function FindFirstOf(const AFind, AText: string; const ALength: Integer = -1;
  const AStartPos: Integer = 1): Integer;
var
  I, LLength, LPos: Integer;
begin
  Result := 0;
  if Length(AFind) > 0 then begin
    LLength := IndyLength(AText, ALength, AStartPos);
    if LLength > 0 then begin
      for I := 0 to LLength-1 do begin
        LPos := AStartPos + I;
        if IndyPos(AText[LPos], AFind) <> 0 then begin
          Result := LPos;
          Exit;
        end;
      end;
    end;
  end;
end;

function FindFirstNotOf(const AFind, AText: string; const ALength: Integer = -1;
  const AStartPos: Integer = 1): Integer;
var
  I, LLength, LPos: Integer;
begin
  Result := 0;
  LLength := IndyLength(AText, ALength, AStartPos);
  if LLength > 0 then begin
    if Length(AFind) = 0 then begin
      Result := AStartPos;
      Exit;
    end;
    for I := 0 to LLength-1 do begin
      LPos := AStartPos + I;
      if IndyPos(AText[LPos], AFind) = 0 then begin
        Result := LPos;
        Exit;
      end;
    end;
  end;
end;

function TrimAllOf(const ATrim, AText: string): string;
var
  Len: Integer;
begin
  Result := AText;
  Len := Length(Result);
  while Len > 0 do begin
    if IndyPos(Result[1], ATrim) > 0 then begin
      IdDelete(Result, 1, 1);
      Dec(Len);
    end else begin
      Break;
    end;
  end;
  while Len > 0 do begin
    if IndyPos(Result[Len], ATrim) > 0 then begin
      IdDelete(Result, Len, 1);
      Dec(Len);
    end else begin
      Break;
    end;
  end;
end;

function ContentTypeToEncoding(const AContentType: String;
  AQuoteType: TIdHeaderQuotingType): IIdTextEncoding;
var
  LCharset: String;
begin
  LCharset := ExtractHeaderSubItem(AContentType, 'charset', AQuoteType);  {do not localize}
  Result := CharsetToEncoding(LCharset);
end;

function CharsetToEncoding(const ACharset: String): IIdTextEncoding;
{$IFNDEF DOTNET_OR_ICONV}
var
  CP: Word;
{$ENDIF}
begin
  Result := nil;
  if ACharSet <> '' then
  begin
    // let the user provide a custom encoding first, if desired...
    if Assigned(GIdEncodingNeeded) then begin
      Result := GIdEncodingNeeded(ACharSet);
      if Assigned(Result) then begin
        Exit;
      end;
    end;

    { TODO: finish implementing this
    if PosInStrArray(
      ACharSet,
      ['ISO-2022-JP', 'ISO-2022-JP-1', 'ISO-2022-JP-2', 'ISO-2022-JP-3', 'ISO-2022-JP-2004'], {do not localize
      False) <> -1 then
    begin
      Result := TIdTextEncoding_ISO2022JP.Create;
      Exit;
    end;
    }

    { TODO: implement this
    if TextIsSame(ACharSet, 'ISO-2022-KR') then {do not localize
    begin
      Result := TIdTextEncoding_ISO2022KR.Create;
      Exit;
    end;
    }

    // RLebeau 3/13/09: if there is a problem initializing an encoding
    // class for the requested charset, either because the charset is
    // not known to Indy, or because the OS does not support it natively,
    // just return the 8-bit encoding as a fallback for now.  The data
    // being handled by it likely won't be encoded/decoded properly, but
    // at least the error won't cause exceptions in the user's code, and
    // maybe the user will know how to encode/decode the data manually
    // as a workaround...

    try
      {$IFDEF DOTNET_OR_ICONV}
      Result := IndyTextEncoding(ACharset);
      {$ELSE}
      CP := CharsetToCodePage(ACharset);
      if CP <> 0 then begin
        Result := IndyTextEncoding(CP);
      end;
      {$ENDIF}
    except end;
  end;

  {JPM - I have decided to temporarily make this 8-bit because I'm concerned
  about how binary files will be handled by the ASCII encoder (where there may
  be 8bit byte-values.  In addition, there are numerous charsets for various
  languages and codepages that do some special mapping for them would be a mess.}

  {RLebeau: technically, we should be returning a 7-bit encoding, as the
  default charset for "text/" content types is "us-ascii".}

  if not Assigned(Result) then
  begin
    Result := IndyTextEncoding_8Bit;
  end;
end;

procedure WriteStringAsContentType(AStream: TStream; const AStr, AContentType: String;
  AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  WriteStringToStream(AStream, AStr, ContentTypeToEncoding(AContentType, AQuoteType){$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

procedure WriteStringsAsContentType(AStream: TStream; const AStrings: TStrings;
  const AContentType: String; AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  // RLebeau 10/06/2010: not using TStrings.SaveToStream() in D2009+
  // anymore, as it may save a BOM which we do not want here...

  // TODO: instead of writing AString.Text as a whole, loop through AStrings
  // writing the individual strings to avoid unnecessary memory allocations...

  WriteStringToStream(AStream, AStrings.Text, ContentTypeToEncoding(AContentType, AQuoteType){$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

procedure WriteStringAsCharset(AStream: TStream; const AStr, ACharset: string
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  WriteStringToStream(AStream, AStr, CharsetToEncoding(ACharset){$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

procedure WriteStringsAsCharset(AStream: TStream; const AStrings: TStrings;
  const ACharset: string
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  // RLebeau 10/06/2010: not using TStrings.SaveToStream() in D2009+
  // anymore, as it may save a BOM which we do not want here...

  // TODO: instead of writing AString.Text as a whole, loop through AStrings
  // writing the individual strings to avoid unnecessary memory allocations...

  WriteStringToStream(AStream, AStrings.Text, CharsetToEncoding(ACharset){$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

function ReadStringAsContentType(AStream: TStream; const AContentType: String;
  AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): String;
begin
  Result := ReadStringFromStream(AStream, -1, ContentTypeToEncoding(AContentType, AQuoteType){$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

procedure ReadStringsAsContentType(AStream: TStream; AStrings: TStrings;
  const AContentType: String; AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
);
begin
  // TODO: TStrings.Text truncates on an embedded null character, but the
  // decoded string may contain nulls, depending on the source!  Maybe use
  // SplitDelimitedString() instead, but give it a new parameter to let it
  // know to parse line breaks so it can handle CR, LF, and CRLF equally.
  // Otherwise, create a new function that mimics the TStrings.Text setter
  // but without the null character limitation...
  AStrings.Text := ReadStringFromStream(AStream, -1, ContentTypeToEncoding(AContentType, AQuoteType){$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

function ReadStringAsCharset(AStream: TStream; const ACharset: String
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): String;
begin
  //TODO: Figure out what should happen with Unicode content type.
  Result := ReadStringFromStream(AStream, -1, CharsetToEncoding(ACharset){$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

procedure ReadStringsAsCharset(AStream: TStream; AStrings: TStrings; const ACharset: String
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
);
begin
  // TODO: TStrings.Text truncates on an embedded null character, but the
  // decoded string may contain nulls, depending on the source!  Maybe use
  // SplitDelimitedString() instead, but give it a new parameter to let it
  // know to parse line breaks so it can handle CR, LF, and CRLF equally.
  // Otherwise, create a new function that mimics the TStrings.Text setter
  // but without the null character limitation...
  AStrings.Text := ReadStringFromStream(AStream, -1, CharsetToEncoding(ACharset){$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

{ TIdInterfacedObject }

function TIdInterfacedObject._AddRef: {$IFDEF FPC}Longint{$ELSE}Integer{$ENDIF}; {$IFDEF INTF_USES_STDCALL}stdcall{$ELSE}cdecl{$ENDIF};
begin
  {$IFDEF DOTNET}
  Result := 1;
  {$ELSE}
  Result := inherited _AddRef;
  {$ENDIF}
end;

function TIdInterfacedObject._Release: {$IFDEF FPC}Longint{$ELSE}Integer{$ENDIF}; {$IFDEF INTF_USES_STDCALL}stdcall{$ELSE}cdecl{$ENDIF};
begin
  {$IFDEF DOTNET}
  Result := 1;
  {$ELSE}
  Result := inherited _Release;
  {$ENDIF}
end;

initialization
  {$IFDEF WINDOWS}
  GTempPath := TempPath;
  {$ENDIF}
  SetLength(IndyFalseBoolStrs, 1);
  IndyFalseBoolStrs[Low(IndyFalseBoolStrs)] := 'FALSE';    {Do not Localize}
  SetLength(IndyTrueBoolStrs, 1);
  IndyTrueBoolStrs[Low(IndyTrueBoolStrs)] := 'TRUE';    {Do not Localize}
end.
