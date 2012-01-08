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

  TIdInterfacedObject = class (TInterfacedObject)
  public
    function _AddRef: Integer;
    function _Release: Integer;
  end;

  {$IFDEF WINDOWS}
  TIdWin32Type = (Win32s,
    WindowsNT40PreSP6Workstation, WindowsNT40PreSP6Server, WindowsNT40PreSP6AdvancedServer,
    WindowsNT40Workstation, WindowsNT40Server, WindowsNT40AdvancedServer,
    Windows95, Windows95OSR2,
    Windows98, Windows98SE,
    Windows2000Pro, Windows2000Server, Windows2000AdvancedServer,
    WindowsMe,
    WindowsXPPro,
    Windows2003Server, Windows2003AdvancedServer);
  {$ENDIF}

  TIdHeaderQuotingType = (QuotePlain, QuoteRFC822, QuoteMIME, QuoteHTTP);

  //
  EIdExtensionAlreadyExists = class(EIdException);

  // Procs - KEEP THESE ALPHABETICAL!!!!!

//  procedure BuildMIMETypeMap(dest: TIdStringList);
  // TODO: IdStrings have optimized SplitColumns* functions, can we remove it?
  function ABNFToText(const AText : String) : String;
  function BinStrToInt(const ABinary: String): Integer;
  function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
  function LongWordToFourChar(AValue : LongWord): string;
  function CharRange(const AMin, AMax : Char): String;
  procedure CommaSeparatedToStringList(AList: TStrings; const Value:string);
  function CompareDateTime(const ADateTime1, ADateTime2 : TDateTime) : Integer;

  function ContentTypeToEncoding(const AContentType: string; AQuoteType: TIdHeaderQuotingType): TIdTextEncoding;
  function CharsetToEncoding(const ACharset: string): TIdTextEncoding;

  function ReadStringAsContentType(AStream: TStream; const AContentType: String;
    AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}): String;

  procedure ReadStringsAsContentType(AStream: TStream; AStrings: TStrings;
    const AContentType: String; AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF});

  procedure WriteStringAsContentType(AStream: TStream; const AStr, AContentType: String;
    AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});

  procedure WriteStringsAsContentType(AStream: TStream; const AStrings: TStrings;
    const AContentType: String; AQuoteType: TIdHeaderQuotingType
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});

  procedure WriteStringAsCharset(AStream: TStream; const AStr, ACharset: string
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});

  procedure WriteStringsAsCharset(AStream: TStream; const AStrings: TStrings;
    const ACharset: string
    {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});

  function ReadStringAsCharset(AStream: TStream; const ACharset: String
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}): String;

  procedure ReadStringsAsCharset(AStream: TStream; AStrings: TStrings; const ACharset: string
    {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF});

  {
  These are for handling binary values that are in Network Byte order.  They call
  ntohs, ntols, htons, and htons which are required by SNTP and FSP
  (probably some other protocols).  They aren't aren't in IdGlobals because that
  doesn't refer to IdStack so you can't use GStack there.
  }
  procedure CopyBytesToHostLongWord(const ASource : TIdBytes; const ASourceIndex: Integer;
    var VDest : LongWord);
  procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer;
    var VDest : Word);
  procedure CopyTIdNetworkLongWord(const ASource: LongWord;
    var VDest: TIdBytes; const ADestIndex: Integer);
  procedure CopyTIdNetworkWord(const ASource: Word;
    var VDest: TIdBytes; const ADestIndex: Integer);
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
  function IsHeaderValue(const AHeaderLine: String; const AValue: String): Boolean;
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
  function GmtOffsetStrToDateTime(const S: string): TDateTime;
  function GMTToLocalDateTime(S: string): TDateTime;
  function CookieStrToLocalDateTime(S: string): TDateTime;
  function IdGetDefaultCharSet : TIdCharSet;
  function IntToBin(Value: LongWord): string;
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
  procedure MoveChars(const ASource: ShortString; ASourceStart: integer; var ADest: ShortString; ADestStart, ALen: integer);
  function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): LongWord;
  procedure LongWordToOrdFourByte(const AValue: LongWord; var VByte1, VByte2, VByte3, VByte4 : Byte);

  function PadString(const AString : String; const ALen : Integer; const AChar: Char): String;
  function UnquotedStr(const AStr : String): String;

  function ProcessPath(const ABasePath: String; const APath: String; const APathDelim: string = '/'): string;    {Do not Localize}
  function RightStr(const AStr: String; const Len: Integer): String;
  // still to figure out how to reproduce these under .Net
  function ROL(const AVal: LongWord; AShift: Byte): LongWord;
  function ROR(const AVal: LongWord; AShift: Byte): LongWord;
  function RPos(const ASub, AIn: String; AStart: Integer = -1): Integer;
  function IndySetLocalTime(Value: TDateTime): Boolean;

  function StartsWith(const ANSIStr, APattern : String) : Boolean;

  function StrInternetToDateTime(Value: string): TDateTime;
  function StrToDay(const ADay: string): Byte;
  function StrToMonth(const AMonth: string): Byte;
  function StrToWord(const Value: String): Word;
  function TimeZoneBias: TDateTime;
   //these are for FSP but may also help with MySQL
  function UnixDateTimeToDelphiDateTime(UnixDateTime: LongWord): TDateTime;
  function DateTimeToUnix(ADateTime: TDateTime): LongWord;

  function TwoCharToWord(AChar1, AChar2: Char): Word;
  function UpCaseFirst(const AStr: string): string;
  function UpCaseFirstWord(const AStr: string): string;
  function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
  {$IFDEF WIN32_OR_WIN64}
  function Win32Type : TIdWin32Type;
  {$ENDIF}
  procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
  function WordToStr(const Value: Word): String;
  //moved here so I can IFDEF a DotNET ver. that uses StringBuilder
  function IndyWrapText(const ALine, ABreakStr, ABreakChars : string; MaxCol: Integer): string;
 
  //The following is for working on email headers and message part headers...
  function RemoveHeaderEntry(const AHeader, AEntry: string; AQuoteType: TIdHeaderQuotingType): string; overload;
  function RemoveHeaderEntry(const AHeader, AEntry: string; var VOld: String; AQuoteType: TIdHeaderQuotingType): string; overload;
  function RemoveHeaderEntries(const AHeader: string; AEntries: array of string; AQuoteType: TIdHeaderQuotingType): string;

  {
    Three functions for easier manipulating of strings.  Don't know of any
    system functions to perform these actions.  If there aren't and someone
    can find an optimised way of performing then please implement...
  }
  function FindFirstOf(const AFind, AText: string; const ALength: Integer = -1; const AStartPos: Integer = 1): Integer;
  function FindFirstNotOf(const AFind, AText: string; const ALength: Integer = -1; const AStartPos: Integer = 1): Integer;
  function TrimAllOf(const ATrim, AText: string): string;
  procedure ParseMetaHTTPEquiv(AStream: TStream; AStr : TStrings);

type
  TIdEncodingNeededEvent = function(const ACharset: String): TIdTextEncoding;

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
  {$IFDEF DELPHI_CROSS}
    {$IFDEF MACOSX}
  CoreServices,
    {$ENDIF}
  {$ENDIF}
  IdIPAddress,
  {$IFDEF UNIX}
    {$IFDEF KYLIXCOMPAT}
  Libc,
    {$ENDIF}
    {$IFDEF FPC}
      {$IFDEF USE_BASEUNIX}
      BaseUnix,
      Unix,
      DateUtils,
      {$ENDIF}
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
      {$IFDEF DARWIN}
    Macapi.CoreServices,
      {$ENDIF}
    DateUtils,
    Posix.SysStat, Posix.SysTime, Posix.Time, Posix.Unistd,
    {$ENDIF}
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
  IdStack;

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
{$IFDEF DOTNET}
  LSB : System.Text.StringBuilder;
begin
  LSB := System.Text.StringBuilder.Create;
  for i := AMin to AMax do begin
    LSB.Append(i);
  end;
  Result := LSB.ToString;
{$ELSE}
begin
  SetLength(Result, Ord(AMax) - Ord(AMin) + 1);
  for i := AMin to AMax do begin
    Result[Ord(i) - Ord(AMin) + 1] := i;
  end;
{$ENDIF}
end;

{$IFDEF WINDOWS}
var
  ATempPath: TIdFileName;
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

function UnixDateTimeToDelphiDateTime(UnixDateTime: LongWord): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (UnixDateTime / 86400) + UnixStartDate;
{
From: http://homepages.borland.com/efg2lab/Library/UseNet/1999/0309b.txt
 }
 //   Result := EncodeDate(1970, 1, 1) + (UnixDateTime / 86400); {86400=No. of secs. per day}
end;

function DateTimeToUnix(ADateTime: TDateTime): LongWord;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  //example: DateTimeToUnix(now);
  Result := Round((ADateTime - UnixStartDate) * 86400);
end;

procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : Word);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  VDest := IdGlobal.BytesToWord(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyBytesToHostLongWord(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : LongWord);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  VDest := IdGlobal.BytesToLongWord(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyTIdNetworkWord(const ASource: Word;
    var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdWord(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

procedure CopyTIdNetworkLongWord(const ASource: LongWord;
    var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  CopyTIdLongWord(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

// BGO: TODO: Move somewhere else
procedure MoveChars(const ASource: ShortString; ASourceStart: integer;
  var ADest: ShortString; ADestStart, ALen: integer);
{$IFDEF DOTNET}
var
  a: Integer;
{$ENDIF}
//Inline function must not have open array arguement.
begin
  {$IFDEF DOTNET}
  for a := 1 to ALen do begin
    ADest[ADestStart] := ASource[ASourceStart];
    inc(ADestStart);
    inc(ASourceStart);
  end;
  {$ELSE}
  Move(ASource[ASourceStart], ADest[ADestStart], ALen);
  {$ENDIF}
end;

function LongWordToFourChar(AValue : LongWord): string;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := BytesToStringRaw(ToBytes(AValue));
end;

procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  //ByteArray[Index] := AWord div 256;
  //ByteArray[Index + 1] := AWord mod 256;
  ByteArray[Index + 1] := AWord div 256;
  ByteArray[Index] := AWord mod 256;
end;

function StrToWord(const Value: String): Word;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if Length(Value) > 1 then begin
    {$IFDEF STRING_IS_UNICODE}
    Result := TwoCharToWord(Value[1], Value[2]);
    {$ELSE}
    Result := PWord(Pointer(Value))^;
    {$ENDIF}
  end else begin
    Result := 0;
  end;
end;

function WordToStr(const Value: Word): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  {$IFDEF STRING_IS_UNICODE}
  Result := BytesToStringRaw(ToBytes(Value));
  {$ELSE}
  SetLength(Result, SizeOf(Value));
  Move(Value, Result[1], SizeOf(Value));
  {$ENDIF}
end;

function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): LongWord;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LValue: TIdBytes;
begin
  SetLength(LValue, 4);
  LValue[0] := AByte1;
  LValue[1] := AByte2;
  LValue[2] := AByte3;
  LValue[3] := AByte4;
  Result := BytesToLongWord(LValue);
end;

procedure LongWordToOrdFourByte(const AValue: LongWord; var VByte1, VByte2, VByte3, VByte4 : Byte);
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

function TwoCharToWord(AChar1, AChar2: Char): Word;
//Since Replys are returned as Strings, we need a rountime to convert two
// characters which are a 2 byte U Int into a two byte unsigned integer
var
  LWord: TIdBytes;
begin
  SetLength(LWord, 2);
  LWord[0] := Ord(AChar1);
  LWord[1] := Ord(AChar2);
  Result := BytesToWord(LWord);

//  Result := Word((Ord(AChar1) shl 8) and $FF00) or Word(Ord(AChar2) and $00FF);
end;


{This routine is based on JPM Open by J. Peter Mugaas.  Permission is granted
to use this with Indy under Indy's Licenses

Note that JPM Open is under a different Open Source license model.

It is available at http://www.wvnet.edu/~oma00215/jpm.html }

{$IFDEF WIN32_OR_WIN64}
type
  TNTEditionType = (workstation, server, advancedserver);

{These two are intended as internel functions called by our Win32 function.
These assume you checked for Windows NT, 2000, XP, or 2003}

{Returns the NTEditionType on Windows NT, 2000, XP, or 2003, and return workstation on non-nt platforms (95,98,me) }
function GetNTType : TNTEditionType;
var
  RtlGetNtProductType: function(ProductType:PULONG):BOOL;stdcall;
  Lh: THandle;
  LVersion: ULONG;
begin
  Result := Workstation;
  //In Windows, you should use SafeLoadLibrary instead of the LoadLibrary API
  //call because LoadLibrary messes with the FPU control word.  
  lh := SafeLoadLibrary('ntdll.dll'); {do not localize}
  if Lh > 0 then begin
    @RtlGetNtProductType := GetProcAddress(lh, 'RtlGetNtProductType'); {do not localize}
    if @RtlGetNtProductType <> nil then begin
      RtlGetNtProductType(@LVersion);
      case LVersion of
        1: Result := Workstation;
        2: Result := Server;
        3: Result := AdvancedServer;
      end;
    end;
    FreeLibrary(lh);
  end;
end;

function GetOSServicePack : Integer;
var
  LNumber : String;
  LBuf : String;
  i : Integer;
  OS : TOSVersionInfo;
begin
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  LBuf := OS.szCSDVersion;
  //Strip off "Service Pack" words
  Fetch(LBuf,' ');
  Fetch(LBuf,' ');
  //get the version number without any letters
  LNumber := '';
  for i := 1 to Length(LBuf) do begin
    if IsNumeric(LBuf[i]) then begin
      LNumber := LNumber+LBuf[i];
    end else begin
      Break;
    end;
  end;
  Result := StrToIntDef(LNumber,0);
end;
{============}
function Win32Type: TIdWin32Type;
begin
  {VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);  GetVersionEx(VerInfo);}
  {is this Windows 2000, 2003, or XP?}
  if Win32MajorVersion >= 5 then begin
    if Win32MinorVersion >= 2 then begin
      case GetNTType of
        Server : Result := Windows2003Server;
        AdvancedServer : Result := Windows2003Server;
      else
        Result := WindowsXPPro; // Windows 2003 has no desktop version
      end;
    end else begin
      if Win32MinorVersion >= 1 then begin
        case GetNTType of
          Server : Result := Windows2000Server; // hmmm, winXp has no server versions
          AdvancedServer : Result := Windows2000AdvancedServer; // hmmm, winXp has no server versions
        else
          Result := WindowsXPPro;
        end;
      end else begin
        case GetNTType of
          Server : Result := Windows2000Server;
          AdvancedServer : Result := Windows2000AdvancedServer;
        else
          Result := Windows2000Pro;
        end;
      end;
    end;
  end else begin
    {is this WIndows 95, 98, Me, or NT 40}
    if Win32MajorVersion > 3 then begin
      if Win32Platform = VER_PLATFORM_WIN32_NT then begin
        //Bas requested that we specifically check for anything below SP6
        if GetOSServicePack < 6 then begin
          case GetNTType of
            Server : Result := WindowsNT40PreSP6Server;
            AdvancedServer : Result := WindowsNT40PreSP6AdvancedServer;
          else
            Result := WindowsNT40PreSP6Workstation;
          end;
        end else begin
          case GetNTType of
        //WindowsNT40Workstation, WindowsNT40Server, WindowsNT40AdvancedServer
            Server : Result := WindowsNT40Server;
            AdvancedServer : Result := WindowsNT40AdvancedServer;
          else
            Result := WindowsNT40Workstation;
          end;
        end;
      end else begin
        {mask off junk}
        Win32BuildNumber := Win32BuildNumber and $FFFF;
        if Win32MinorVersion >= 90 then begin
          Result := WindowsMe;
        end else begin
          if Win32MinorVersion >= 10 then begin
            {Windows 98}
            if Win32BuildNumber >= 2222 then begin
              Result := Windows98SE
            end else begin
              Result := Windows98;
            end;
          end else begin {Windows 95}
            if Win32BuildNumber >= 1000 then begin
              Result := Windows95OSR2
            end else begin
              Result := Windows95;
            end;
          end;
        end;
      end;
    end else begin
      Result := Win32s;
    end;
  end;
end;
{$ENDIF}

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
  Dt, Mo, Yr, Ho, Min, Sec: Word;
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

begin
  Result := False;
  VDateTime := 0.0;

  LAM := False;
  LPM := False;

  Value := Trim(Value);
  if Length(Value) = 0 then begin
    Exit;
  end;

  try
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
    if (IndyPos('-', Value) > 1) and (IndyPos('-', Value) < IndyPos(' ', Value)) then begin    {Do not Localize}
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
      Value := Fetch(Value, 'AM');  {do not localize}
    end
    else if IndyPos('PM', Value) > 0 then begin {do not localize}
      LPM := True;
      Value := Fetch(Value, 'PM');  {do not localize}
    end;

    // RLebeau 03/04/2009: some countries use dot instead of colon
    // for the time separator
    i := IndyPos('.', Value);       {do not localize}
    if i > 0 then begin
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
      VDateTime := VDateTime + EncodeTime(Ho, Min, Sec, 0);
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
    Result := Result + OffsetFromUTC;
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
  Result := StringReplace(Result, ' ', '0', [rfReplaceAll]);
end;
{
Note that MS-DOS displays the time in the Local Time Zone - MLISx commands use
stamps based on GMT)
}
function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := FTPGMTDateTimeToMLS(ATimeStamp - OffsetFromUTC, AIncludeMSecs);
end;


function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
var
  EndOfCurrentString: integer;
begin
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
  NumRead, NumWritten: Longint;
  Buffer: array[1..2048] of Byte;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  System.IO.File.Copy(Source, Destination, True);
  Result := True; // or you'll get an exception
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFDEF WIN32_OR_WIN64}
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
  
  Assign(SourceF, Source);
  {$I-} //turn off IO checking - no exception
  Reset(SourceF, 1);
  {$I+} //turn it back on
  Result := IOResult <> 0;
  if not Result then begin
    Exit;
  end;
  Assign(DestF, Destination);
  {$I-} //turn off IO checking - no exception
  Rewrite(DestF, 1);
  {$I+} //turn it back on
  Result := IOResult <> 0;
  if Result then begin
    repeat
      BlockRead(SourceF, Buffer, SizeOf(Buffer), NumRead);
      BlockWrite(DestF, Buffer, NumRead, NumWritten);
    until (NumRead = 0) or (NumWritten <> NumRead);
    Close(DestF);
    Result := True;
  end;
  Close(SourceF);
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
var
  lPath: TIdFileName;
  lExt: TIdFileName;
begin
  lPath := APath;

  {$IFDEF UNIX}
  lExt := '';
  {$ELSE}
  lExt := '.tmp';
  {$ENDIF}

  {$IFDEF WINDOWS}
  if lPath = '' then begin
    lPath := ATempPath;
  end;
  {$ELSE}
    {$IFDEF DOTNET}
  if lPath = '' then begin
    lPath := System.IO.Path.GetTempPath;
  end;
    {$ENDIF}
  {$ENDIF}

  Result := GetUniqueFilename(lPath, 'Indy', lExt);
end;


function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
{$IFNDEF FPC}
var
  LNamePart : LongWord;
  LFQE : String;
  LFName: String;
{$ENDIF}
begin
  {$IFDEF FPC}
  //Do not use Tempnam in Unix-like Operating systems.  That function is dangerous
  //and you will be warned about it when compiling.  FreePascal has GetTempFileName.  Use
  //that instead.
  if APath = '' then begin
    Result := GetTempFileName('', 'Indy');
  end else begin
    Result := GetTempFileName(APath, 'Indy');
  end;
  {$ELSE}

  LFQE := AExt;

  // period is optional in the extension... force it
  if LFQE <> '' then begin
    if LFQE[1] <> '.' then begin
      LFQE := '.' + LFQE;
    end;
  end;

  // validate path and add path delimiter before file name prefix
  if APath <> '' then begin
    if not IndyDirectoryExists(APath) then begin
      LFName := APrefix;
    end else begin
      // uses the Indy function... not the Borland one
      LFName := IndyIncludeTrailingPathDelimiter(APath) + APrefix;
    end;
  end else begin
    LFName := APrefix;
  end;

  LNamePart := Ticks;
  repeat
    Result := LFName + IntToHex(LNamePart, 8) + LFQE;
    if not FileExists(Result) then begin
      Break;
    end;
    Inc(LNamePart);
  until False;

  {$ENDIF}
end;

// Find a token given a direction (>= 0 from start; < 0 from end)
// S.G. 19/4/00:
//  Changed to be more readable
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
    {$ELSE}
      {$IFDEF KYLIXCOMPAT}
  LRec : TStatBuf;
      {$ELSE}
  LRec : TStat;
  LU : time_t;
      {$ENDIF}
    {$ENDIF}
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
    LOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
    {$ENDIF}
      LHandle := Windows.FindFirstFile(PIdFileNameChar(AFileName), LRec);
      if LHandle <> INVALID_HANDLE_VALUE then begin
        Windows.FindClose(LHandle);
        if (LRec.dwFileAttributes and Windows.FILE_ATTRIBUTE_DIRECTORY) = 0 then begin
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
   if stat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then begin
      Result := LRec.st_size;
   end;
      {$ELSE}
    //Note that we can use stat here because we are only looking at the date.
  if {$IFDEF KYLIXCOMPAT}stat{$ELSE}fpstat{$ENDIF}(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then begin
      Result := LRec.st_Size;
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFNDEF NATIVEFILEAPI}
  Result := -1;
  if FileExists(AFilename) then begin
    with TIdReadFileExclusiveStream.Create(AFilename) do try
      Result := Size;
    finally Free; end;
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
{$ENDIF}
{$IFDEF UNIX}
var
  LTime : Integer;
  {$IFDEF USE_VCL_POSIX}
  LRec : _Stat;

  {$ENDIF}
  {$IFDEF KYLIXCOMPAT}
  LRec : TStatBuf;
  LU : TUnixTime;
  {$ENDIF}
  {$IFDEF USE_BASEUNIX}
  LRec : TStat;
  LU : time_t;
  {$ENDIF}
{$ENDIF}
begin
  Result := -1;
  {$IFDEF WINDOWS}
  if not IsVolume(AFileName) then begin
    {$IFDEF WIN32_OR_WIN64}
    LOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
    {$ENDIF}
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
  {$ENDIF}
  {$IFDEF DOTNET}
  if System.IO.File.Exists(AFileName) then begin
    Result := System.IO.File.GetLastWriteTimeUtc(AFileName).ToOADate;
  end;
  {$ENDIF}
  {$IFDEF UNIX}
  //Note that we can use stat here because we are only looking at the date.
    {$IFDEF USE_BASEUNIX}
  if fpstat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then begin
    {$ENDIF}
    {$IFDEF KYLIXCOMPAT}
  if stat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then begin
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
  if stat(PAnsiChar(AnsiString(AFileName)), LRec) = 0 then begin
    {$ENDIF}
    LTime := LRec.st_mtime;
    {$IFDEF KYLIXCOMPAT}
    gmtime_r(@LTime, LU);
    Result := EncodeDate(LU.tm_year + 1900, LU.tm_mon + 1, LU.tm_mday) +
              EncodeTime(LU.tm_hour, LU.tm_min, LU.tm_sec, 0);
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
    Result := UnixToDateTime(LTime);
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
    Result := DateUtils.UnixToDateTime(LTime);
    {$ENDIF}
  end;
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
function TimeZoneBias: TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{$IFNDEF FPC}
  {$IFDEF UNIX}
var
  T: Time_T;
  TV: TimeVal;
    {$IFDEF USE_VCL_POSIX}
  UT: tm;
    {$ELSE}
  UT: TUnixTime;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
begin
{$IFNDEF FPC}
  {$IFDEF UNIX}
  // TODO: use -OffsetFromUTC here. It has this same Unix logic in it
  {from http://edn.embarcadero.com/article/27890 }
  gettimeofday(TV, nil);
  T := TV.tv_sec;
    {$IFDEF USE_VCL_POSIX}
  localtime_r(T, UT);
// __tm_gmtoff is the bias in seconds from the UTC to the current time.
// so I multiply by -1 to compensate for this.
  Result := (UT.tm_gmtoff / 60 / 60 / 24);
    {$ELSE}
  localtime_r(@T, UT);
// __tm_gmtoff is the bias in seconds from the UTC to the current time.
// so I multiply by -1 to compensate for this.
  Result := (UT.__tm_gmtoff / 60 / 60 / 24);
    {$ENDIF}
  {$ELSE}
  Result := -OffsetFromUTC;
  {$ENDIF}
{$ELSE}
  Result := -OffsetFromUTC;
{$ENDIF}
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
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin
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

    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin
      Windows.SetLocalTime({$IFDEF FPC}@{$ENDIF}dSysTime);
      // Windows 2000+ will broadcast WM_TIMECHANGE automatically...
      if Win32MajorVersion < 5 then begin // Windows 2000 = v5.0
        SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);
      end;
    end else begin
      SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);
    end;
  end;

  {Undo the Process Privilege change we had done for the
  set time and close the handle that was allocated}
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin
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
  Months: array[0..7] of array[1..12] of string = (

    // English
    ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'),

    // English - alt. 4 letter abbreviations (Netware Print Services may return a 4 char month such as Sept)
    ('',    '',    '',    '',    '',   'JUNE','JULY', '',   'SEPT', '',    '',    ''),

    // German
    ('',    '',    'MRZ', '',    'MAI', '',    '',    '',    '',    'OKT', '',    'DEZ'),

    // Spanish
    ('ENO', 'FBRO','MZO', 'AB',  '',    '',    '',    'AGTO','SBRE','OBRE','NBRE','DBRE'),

    // Dutch
    ('',    '',    'MRT', '',    'MEI', '',    '',    '',    '',    'OKT', '',    ''),

    // French
    ('JANV','F'+Char($C9)+'V', 'MARS','AVR', 'MAI', 'JUIN','JUIL','AO'+Char($DB), 'SEPT','',    '',    'D'+Char($C9)+'C'),

    // French (alt)
    ('',    'F'+Char($C9)+'VR','',    '',    '',    '',    'JUI',    'AO'+Char($DB)+'T','',    '',    '',    ''),

    // Slovenian
    ('',    '',     '',   '', 'MAJ',    '',    '',       '',     'AVG',    '',    '',  ''));
var
  i: Integer;
begin
  if AMonth <> '' then begin
    for i := Low(Months) to High(Months) do begin
      for Result := Low(Months[i]) to High(Months[i]) do begin
        if TextIsSame(AMonth, Months[i][Result]) then begin
          Exit;
        end;
      end;
	  end;
  end;
  Result := 0;
end;

function UpCaseFirst(const AStr: string): string;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := LowerCase(TrimLeft(AStr));
  if Result <> '' then begin   {Do not Localize}
    Result[1] := UpCase(Result[1]);
  end;
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

function TimeZoneToGmtOffsetStr(const ATimeZone: String): String;
type
  TimeZoneOffset = record
    TimeZone: String;
    Offset: String;
  end;
const
  cTimeZones: array[0..90] of TimeZoneOffset = (
    (TimeZone:'A';    Offset:'+0100'), // Alpha Time Zone - Military                             {do not localize}
    (TimeZone:'ACDT'; Offset:'+1030'), // Australian Central Daylight Time                       {do not localize}
    (TimeZone:'ACST'; Offset:'+0930'), // Australian Central Standard Time                       {do not localize}
    (TimeZone:'ADT';  Offset:'-0300'), // Atlantic Daylight Time - North America                 {do not localize}
    (TimeZone:'AEDT'; Offset:'+1100'), // Australian Eastern Daylight Time                       {do not localize}
    (TimeZone:'AEST'; Offset:'+1000'), // Australian Eastern Standard Time                       {do not localize}
    (TimeZone:'AKDT'; Offset:'-0800'), // Alaska Daylight Time                                   {do not localize}
    (TimeZone:'AKST'; Offset:'-0900'), // Alaska Standard Time                                   {do not localize}
    (TimeZone:'AST';  Offset:'-0400'), // Atlantic Standard Time - North America                 {do not localize}
    (TimeZone:'AWDT'; Offset:'+0900'), // Australian Western Daylight Time                       {do not localize}
    (TimeZone:'AWST'; Offset:'+0800'), // Australian Western Standard Time                       {do not localize}
    (TimeZone:'B';    Offset:'+0200'), // Bravo Time Zone - Military                             {do not localize}
    (TimeZone:'BST';  Offset:'+0100'), // British Summer Time - Europe                           {do not localize}
    (TimeZone:'C';    Offset:'+0300'), // Charlie Time Zone - Military                           {do not localize}
    (TimeZone:'CDT';  Offset:'+1030'), // Central Daylight Time - Australia                      {do not localize}
    (TimeZone:'CDT';  Offset:'-0500'), // Central Daylight Time - North America                  {do not localize}
    (TimeZone:'CEDT'; Offset:'+0200'), // Central European Daylight Time                         {do not localize}
    (TimeZone:'CEST'; Offset:'+0200'), // Central European Summer Time                           {do not localize}
    (TimeZone:'CET';  Offset:'+0100'), // Central European Time                                  {do not localize}
    (TimeZone:'CST';  Offset:'+1030'), // Central Summer Time - Australia                        {do not localize}
    (TimeZone:'CST';  Offset:'+0930'), // Central Standard Time - Australia                      {do not localize}
    (TimeZone:'CST';  Offset:'-0600'), // Central Standard Time - North America                  {do not localize}
    (TimeZone:'CXT';  Offset:'+0700'), // Christmas Island Time - Australia                      {do not localize}
    (TimeZone:'D';    Offset:'+0400'), // Delta Time Zone - Military                             {do not localize}
    (TimeZone:'E';    Offset:'+0500'), // Echo Time Zone - Military                              {do not localize}
    (TimeZone:'EDT';  Offset:'+1100'), // Eastern Daylight Time - Australia                      {do not localize}
    (TimeZone:'EDT';  Offset:'-0400'), // Eastern Daylight Time - North America                  {do not localize}
    (TimeZone:'EEDT'; Offset:'+0300'), // Eastern European Daylight Time                         {do not localize}
    (TimeZone:'EEST'; Offset:'+0300'), // Eastern European Summer Time                           {do not localize}
    (TimeZone:'EET';  Offset:'+0200'), // Eastern European Time                                  {do not localize}
    (TimeZone:'EST';  Offset:'+1100'), // Eastern Summer Time - Australia                        {do not localize}
    (TimeZone:'EST';  Offset:'+1000'), // Eastern Standard Time - Australia                      {do not localize}
    (TimeZone:'EST';  Offset:'-0500'), // Eastern Standard Time - North America                  {do not localize}
    (TimeZone:'F';    Offset:'+0600'), // Foxtrot Time Zone - Military                           {do not localize}
    (TimeZone:'G';    Offset:'+0700'), // Golf Time Zone - Military                              {do not localize}
    (TimeZone:'GMT';  Offset:'+0000'), // Greenwich Mean Time - Europe                           {do not localize}
    (TimeZone:'H';    Offset:'+0800'), // Hotel Time Zone - Military                             {do not localize}
    (TimeZone:'HAA';  Offset:'-0300'), // Heure Avancée de l'Atlantique - North America          {do not localize}
    (TimeZone:'HAC';  Offset:'-0500'), // Heure Avancée du Centre - North America                {do not localize}
    (TimeZone:'HADT'; Offset:'-0900'), // Hawaii-Aleutian Daylight Time - North America          {do not localize}
    (TimeZone:'HAE';  Offset:'-0400'), // Heure Avancée de l'Est - North America                 {do not localize}
    (TimeZone:'HAP';  Offset:'-0700'), // Heure Avancée du Pacifique - North America             {do not localize}
    (TimeZone:'HAR';  Offset:'-0600'), // Heure Avancée des Rocheuses - North America            {do not localize}
    (TimeZone:'HAST'; Offset:'-1000'), // Hawaii-Aleutian Standard Time - North America          {do not localize}
    (TimeZone:'HAT';  Offset:'-0230'), // Heure Avancée de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HAY';  Offset:'-0800'), // Heure Avancée du Yukon - North America                 {do not localize}
    (TimeZone:'HNA';  Offset:'-0400'), // Heure Normale de l'Atlantique - North America          {do not localize}
    (TimeZone:'HNC';  Offset:'-0600'), // Heure Normale du Centre - North America                {do not localize}
    (TimeZone:'HNE';  Offset:'-0500'), // Heure Normale de l'Est - North America                 {do not localize}
    (TimeZone:'HNP';  Offset:'-0800'), // Heure Normale du Pacifique - North America             {do not localize}
    (TimeZone:'HNR';  Offset:'-0700'), // Heure Normale des Rocheuses - North America            {do not localize}
    (TimeZone:'HNT';  Offset:'-0330'), // Heure Normale de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HNY';  Offset:'-0900'), // Heure Normale du Yukon - North America                 {do not localize}
    (TimeZone:'I';    Offset:'+0900'), // India Time Zone - Military                             {do not localize}
    (TimeZone:'IST';  Offset:'+0100'), // Irish Summer Time - Europe                             {do not localize}
    (TimeZone:'K';    Offset:'+1000'), // Kilo Time Zone - Military                              {do not localize}
    (TimeZone:'L';    Offset:'+1100'), // Lima Time Zone - Military                              {do not localize}
    (TimeZone:'M';    Offset:'+1200'), // Mike Time Zone - Military                              {do not localize}
    (TimeZone:'MDT';  Offset:'-0600'), // Mountain Daylight Time - North America                 {do not localize}
    (TimeZone:'MEHSZ';Offset:'+0300'), // Mitteleuropäische Hochsommerzeit - Europe              {do not localize}
    (TimeZone:'MESZ'; Offset:'+0200'), // Mitteleuroäische Sommerzeit - Europe                   {do not localize}
    (TimeZone:'MEZ';  Offset:'+0100'), // Mitteleuropäische Zeit - Europe                        {do not localize}
    (TimeZone:'MSD';  Offset:'+0400'), // Moscow Daylight Time - Europe                          {do not localize}
    (TimeZone:'MSK';  Offset:'+0300'), // Moscow Standard Time - Europe                          {do not localize}
    (TimeZone:'MST';  Offset:'-0700'), // Mountain Standard Time - North America                 {do not localize}
    (TimeZone:'N';    Offset:'-0100'), // November Time Zone - Military                          {do not localize}
    (TimeZone:'NDT';  Offset:'-0230'), // Newfoundland Daylight Time - North America             {do not localize}
    (TimeZone:'NFT';  Offset:'+1130'), // Norfolk (Island), Time - Australia                     {do not localize}
    (TimeZone:'NST';  Offset:'-0330'), // Newfoundland Standard Time - North America             {do not localize}
    (TimeZone:'O';    Offset:'-0200'), // Oscar Time Zone - Military                             {do not localize}
    (TimeZone:'P';    Offset:'-0300'), // Papa Time Zone - Military                              {do not localize}
    (TimeZone:'PDT';  Offset:'-0700'), // Pacific Daylight Time - North America                  {do not localize}
    (TimeZone:'PST';  Offset:'-0800'), // Pacific Standard Time - North America                  {do not localize}
    (TimeZone:'Q';    Offset:'-0400'), // Quebec Time Zone - Military                            {do not localize}
    (TimeZone:'R';    Offset:'-0500'), // Romeo Time Zone - Military                             {do not localize}
    (TimeZone:'S';    Offset:'-0600'), // Sierra Time Zone - Military                            {do not localize}
    (TimeZone:'T';    Offset:'-0700'), // Tango Time Zone - Military                             {do not localize}
    (TimeZone:'U';    Offset:'-0800'), // Uniform Time Zone - Military                           {do not localize}
    (TimeZone:'UT';   Offset:'+0000'), // Universal Time - Europe                                {do not localize}
    (TimeZone:'UTC';  Offset:'+0000'), // Coordinated Universal Time - Europe                    {do not localize}
    (TimeZone:'V';    Offset:'-0900'), // Victor Time Zone - Military                            {do not localize}
    (TimeZone:'W';    Offset:'-1000'), // Whiskey Time Zone - Military                           {do not localize}
    (TimeZone:'WDT';  Offset:'+0900'), // Western Daylight Time - Australia                      {do not localize}
    (TimeZone:'WEDT'; Offset:'+0100'), // Western European Daylight Time - Europe                {do not localize}
    (TimeZone:'WEST'; Offset:'+0100'), // Western European Summer Time - Europe                  {do not localize}
    (TimeZone:'WET';  Offset:'+0000'), // Western European Time - Europe                         {do not localize}
    (TimeZone:'WST';  Offset:'+0900'), // Western Summer Time - Australia                        {do not localize}
    (TimeZone:'WST';  Offset:'+0800'), // Western Standard Time - Australia                      {do not localize}
    (TimeZone:'X';    Offset:'-1100'), // X-ray Time Zone - Military                             {do not localize}
    (TimeZone:'Y';    Offset:'-1200'), // Yankee Time Zone - Military                            {do not localize}
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

function GmtOffsetStrToDateTime(const S: string): TDateTime;
var
  sTmp: String;
begin
  Result := 0.0;
  sTmp := Trim(S);
  sTmp := Fetch(sTmp);
  if Length(sTmp) > 0 then begin
    if (sTmp[1] <> '-') and (sTmp[1] <> '+') then begin {do not localize}
      sTmp := TimeZoneToGmtOffsetStr(sTmp);
    end;
    if (Length(sTmp) = 5) and ((sTmp[1] = '-') or (sTmp[1] = '+')) then begin  {do not localize}
      try
        Result := EncodeTime(IndyStrToInt(Copy(sTmp, 2, 2)), IndyStrToInt(Copy(sTmp, 4, 2)), 0, 0);
        if sTmp[1] = '-' then begin  {do not localize}
          Result := -Result;
        end;
      except
        Result := 0.0;
      end;
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
    {-Apply GMT offset here}
    if DateTimeOffset < 0.0 then begin
      Result := Result + Abs(DateTimeOffset);
    end else begin
      Result := Result - DateTimeOffset;
    end;
    // Apply local offset
    Result := Result + OffsetFromUTC;
  end;
end;

{$IFNDEF HAS_TryStrToInt}
function TryStrToInt(const S: string; out Value: Integer): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;
{$ENDIF}

{ Using the algorithm defined in cookie-draft-23 section 5.1.1 }
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
    time            = hms-time ( non-digit *OCTET )
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
    day-of-month    = 1*2DIGIT ( non-digit *OCTET )
    }
    Result := False;
    S := AStr;

    LTemp := ExtractDigits(S, 1, 2);
    if LTemp = '' then begin
      Exit;
    end;
    if S <> '' then begin
      if IsNumeric(AStr, 1, 3) then begin
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
  begin
    {
    month           = ( "jan" / "feb" / "mar" / "apr" /
                       "may" / "jun" / "jul" / "aug" /
                       "sep" / "oct" / "nov" / "dec" ) *OCTET
    }
    LMonth := PosInStrArray(Copy(AStr, 1, 3), ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'], False) + 1;
    Result := LMonth <> 0;
  end;

  function ParseYear(const AStr: String): Boolean;
  var
    S, LTemp: String;
  begin
    // year            = 2*4DIGIT ( non-digit *OCTET )
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

    Result := EncodeDate(LYear, LMonth, LDayOfMonth) + EncodeTime(LHour, LMinute, LSecond, 0) + OffsetFromUTC;
  except
    Result := 0.0;
  end;
end;

{ Takes a cardinal (DWORD)  value and returns the string representation of it's binary value}    {Do not Localize}
function IntToBin(Value: LongWord): string;
var
  i: Integer;
begin
  SetLength(Result, 32);
  for i := 1 to 32 do begin
    if ((Value shl (i-1)) shr 31) = 0 then begin
      Result[i] := '0'  {do not localize}
    end else begin
      Result[i] := '1'; {do not localize}
    end;
  end;
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
  with AMIMEList do begin
    {NOTE:  All of these strings should never be translated
    because they are protocol specific and are important for some
    web-browsers}

    { Animation }
    Add('.nml=animation/narrative');    {Do not Localize}

    { Audio }
    Add('.aac=audio/mp4');
    Add('.aif=audio/x-aiff');    {Do not Localize}
    Add('.aifc=audio/x-aiff');    {Do not Localize}
    Add('.aiff=audio/x-aiff');    {Do not Localize}

    Add('.au=audio/basic');    {Do not Localize}
    Add('.gsm=audio/x-gsm');    {Do not Localize}
    Add('.kar=audio/midi');    {Do not Localize}
    Add('.m3u=audio/mpegurl');    {Do not Localize}
    Add('.m4a=audio/x-mpg');    {Do not Localize}
    Add('.mid=audio/midi');    {Do not Localize}
    Add('.midi=audio/midi');    {Do not Localize}
    Add('.mpega=audio/x-mpg');    {Do not Localize}
    Add('.mp2=audio/x-mpg');    {Do not Localize}
    Add('.mp3=audio/x-mpg');    {Do not Localize}
    Add('.mpga=audio/x-mpg');    {Do not Localize}
    Add('.m3u=audio/x-mpegurl');    {Do not Localize}
    Add('.pls=audio/x-scpls');   {Do not Localize}
    Add('.qcp=audio/vnd.qcelp');    {Do not Localize}
    Add('.ra=audio/x-realaudio');    {Do not Localize}
    Add('.ram=audio/x-pn-realaudio');    {Do not Localize}
    Add('.rm=audio/x-pn-realaudio');    {Do not Localize}
    Add('.sd2=audio/x-sd2');    {Do not Localize}
    Add('.sid=audio/prs.sid');   {Do not Localize}
    Add('.snd=audio/basic');   {Do not Localize}
    Add('.wav=audio/x-wav');    {Do not Localize}
    Add('.wax=audio/x-ms-wax');    {Do not Localize}
    Add('.wma=audio/x-ms-wma');    {Do not Localize}

    Add('.mjf=audio/x-vnd.AudioExplosion.MjuiceMediaFile');    {Do not Localize}

    { Image }
    Add('.art=image/x-jg');    {Do not Localize}
    Add('.bmp=image/bmp');    {Do not Localize}
    Add('.cdr=image/x-coreldraw');    {Do not Localize}
    Add('.cdt=image/x-coreldrawtemplate');    {Do not Localize}
    Add('.cpt=image/x-corelphotopaint');    {Do not Localize}
    Add('.djv=image/vnd.djvu');    {Do not Localize}
    Add('.djvu=image/vnd.djvu');    {Do not Localize}
    Add('.gif=image/gif');    {Do not Localize}
    Add('.ief=image/ief');    {Do not Localize}
    Add('.ico=image/x-icon');    {Do not Localize}
    Add('.jng=image/x-jng');    {Do not Localize}
    Add('.jpg=image/jpeg');    {Do not Localize}
    Add('.jpeg=image/jpeg');    {Do not Localize}
    Add('.jpe=image/jpeg');    {Do not Localize}
    Add('.pat=image/x-coreldrawpattern');   {Do not Localize}
    Add('.pcx=image/pcx');    {Do not Localize}
    Add('.pbm=image/x-portable-bitmap');    {Do not Localize}
    Add('.pgm=image/x-portable-graymap');    {Do not Localize}
    Add('.pict=image/x-pict');    {Do not Localize}
    Add('.png=image/x-png');    {Do not Localize}
    Add('.pnm=image/x-portable-anymap');    {Do not Localize}
    Add('.pntg=image/x-macpaint');    {Do not Localize}
    Add('.ppm=image/x-portable-pixmap');    {Do not Localize}
    Add('.psd=image/x-psd');    {Do not Localize}
    Add('.qtif=image/x-quicktime');    {Do not Localize}
    Add('.ras=image/x-cmu-raster');    {Do not Localize}
    Add('.rf=image/vnd.rn-realflash');    {Do not Localize}
    Add('.rgb=image/x-rgb');    {Do not Localize}
    Add('.rp=image/vnd.rn-realpix');    {Do not Localize}
    Add('.sgi=image/x-sgi');    {Do not Localize}
    Add('.svg=image/svg-xml');    {Do not Localize}
    Add('.svgz=image/svg-xml');    {Do not Localize}
    Add('.targa=image/x-targa');    {Do not Localize}
    Add('.tif=image/x-tiff');    {Do not Localize}
    Add('.wbmp=image/vnd.wap.wbmp');    {Do not Localize}
    Add('.webp=image/webp'); {Do not localize}
    Add('.xbm=image/xbm');    {Do not Localize}
    Add('.xbm=image/x-xbitmap');    {Do not Localize}
    Add('.xpm=image/x-xpixmap');    {Do not Localize}
    Add('.xwd=image/x-xwindowdump');    {Do not Localize}

    { Text }
    Add('.323=text/h323');    {Do not Localize}

    Add('.xml=text/xml');    {Do not Localize}
    Add('.uls=text/iuls');    {Do not Localize}
    Add('.txt=text/plain');    {Do not Localize}
    Add('.rtx=text/richtext');    {Do not Localize}
    Add('.wsc=text/scriptlet');    {Do not Localize}
    Add('.rt=text/vnd.rn-realtext');    {Do not Localize}
    Add('.htt=text/webviewhtml');    {Do not Localize}
    Add('.htc=text/x-component');    {Do not Localize}
    Add('.vcf=text/x-vcard');    {Do not Localize}

    { Video }
    Add('.asf=video/x-ms-asf');    {Do not Localize}
    Add('.asx=video/x-ms-asf');    {Do not Localize}
    Add('.avi=video/x-msvideo');    {Do not Localize}
    Add('.dl=video/dl');    {Do not Localize}
    Add('.dv=video/dv');  {Do not Localize}
    Add('.flc=video/flc');    {Do not Localize}
    Add('.fli=video/fli');    {Do not Localize}
    Add('.gl=video/gl');    {Do not Localize}
    Add('.lsf=video/x-la-asf');    {Do not Localize}
    Add('.lsx=video/x-la-asf');    {Do not Localize}
    Add('.mng=video/x-mng');    {Do not Localize}

    Add('.mp2=video/mpeg');    {Do not Localize}
    Add('.mp3=video/mpeg');    {Do not Localize}
    Add('.mp4=video/mpeg');    {Do not Localize}
    Add('.mpeg=video/x-mpeg2a');    {Do not Localize}
    Add('.mpa=video/mpeg');    {Do not Localize}
    Add('.mpe=video/mpeg');    {Do not Localize}
    Add('.mpg=video/mpeg');    {Do not Localize}
    Add('.ogv=video/ogg');    {Do not Localize}
    Add('.moov=video/quicktime');     {Do not Localize}
    Add('.mov=video/quicktime');    {Do not Localize}
    Add('.mxu=video/vnd.mpegurl');   {Do not Localize}
    Add('.qt=video/quicktime');    {Do not Localize}
    Add('.qtc=video/x-qtc'); {Do not loccalize}
    Add('.rv=video/vnd.rn-realvideo');    {Do not Localize}
    Add('.ivf=video/x-ivf');    {Do not Localize}
    Add('.webm=video/webm');    {Do not Localize}
    Add('.wm=video/x-ms-wm');    {Do not Localize}
    Add('.wmp=video/x-ms-wmp');    {Do not Localize}
    Add('.wmv=video/x-ms-wmv');    {Do not Localize}
    Add('.wmx=video/x-ms-wmx');    {Do not Localize}
    Add('.wvx=video/x-ms-wvx');    {Do not Localize}
    Add('.rms=video/vnd.rn-realvideo-secure');    {Do not Localize}
    Add('.asx=video/x-ms-asf-plugin');    {Do not Localize}
    Add('.movie=video/x-sgi-movie');    {Do not Localize}

    { Application }
    Add('.7z=application/x-7z-compressed');   {Do not Localize}
    Add('.a=application/x-archive');   {Do not Localize}
    Add('.aab=application/x-authorware-bin');    {Do not Localize}
    Add('.aam=application/x-authorware-map');    {Do not Localize}
    Add('.aas=application/x-authorware-seg');    {Do not Localize}
    Add('.abw=application/x-abiword');    {Do not Localize}
    Add('.ace=application/x-ace-compressed');  {Do not Localize}
    Add('.ai=application/postscript');    {Do not Localize}
    Add('.alz=application/x-alz-compressed');    {Do not Localize}
    Add('.ani=application/x-navi-animation');   {Do not Localize}
    Add('.arj=application/x-arj');    {Do not Localize}
    Add('.asf=application/vnd.ms-asf');    {Do not Localize}
    Add('.bat=application/x-msdos-program');    {Do not Localize}
    Add('.bcpio=application/x-bcpio');    {Do not Localize}
    Add('.boz=application/x-bzip2');     {Do not Localize}
    Add('.bz=application/x-bzip');
    Add('.bz2=application/x-bzip2');    {Do not Localize}
    Add('.cab=application/vnd.ms-cab-compressed');    {Do not Localize}
    Add('.cat=application/vnd.ms-pki.seccat');    {Do not Localize}
    Add('.ccn=application/x-cnc');    {Do not Localize}
    Add('.cco=application/x-cocoa');    {Do not Localize}
    Add('.cdf=application/x-cdf');    {Do not Localize}
    Add('.cer=application/x-x509-ca-cert');    {Do not Localize}
    Add('.chm=application/vnd.ms-htmlhelp');    {Do not Localize}
    Add('.chrt=application/vnd.kde.kchart');    {Do not Localize}
    Add('.cil=application/vnd.ms-artgalry');    {Do not Localize}
    Add('.class=application/java-vm');    {Do not Localize}
    Add('.com=application/x-msdos-program');    {Do not Localize}
    Add('.clp=application/x-msclip');    {Do not Localize}
    Add('.cpio=application/x-cpio');    {Do not Localize}
    Add('.cpt=application/mac-compactpro');    {Do not Localize}
    Add('.cqk=application/x-calquick');    {Do not Localize}
    Add('.crd=application/x-mscardfile');    {Do not Localize}
    Add('.crl=application/pkix-crl');    {Do not Localize}
    Add('.csh=application/x-csh');    {Do not Localize}
    Add('.dar=application/x-dar');    {Do not Localize}
    Add('.dbf=application/x-dbase');    {Do not Localize}
    Add('.dcr=application/x-director');    {Do not Localize}
    Add('.deb=application/x-debian-package');    {Do not Localize}
    Add('.dir=application/x-director');    {Do not Localize}
    Add('.dist=vnd.apple.installer+xml');    {Do not Localize}
    Add('.distz=vnd.apple.installer+xml');    {Do not Localize}
    Add('.dll=application/x-msdos-program');    {Do not Localize}
    Add('.dmg=application/x-apple-diskimage');    {Do not Localize}
    Add('.doc=application/msword');    {Do not Localize}
    Add('.dot=application/msword');    {Do not Localize}
    Add('.dvi=application/x-dvi');    {Do not Localize}
    Add('.dxr=application/x-director');    {Do not Localize}
    Add('.ebk=application/x-expandedbook');    {Do not Localize}
    Add('.eps=application/postscript');    {Do not Localize}
    Add('.evy=application/envoy');    {Do not Localize}
    Add('.exe=application/x-msdos-program');    {Do not Localize}
    Add('.fdf=application/vnd.fdf');    {Do not Localize}
    Add('.fif=application/fractals');    {Do not Localize}
    Add('.flm=application/vnd.kde.kivio');    {Do not Localize}
    Add('.fml=application/x-file-mirror-list');    {Do not Localize}
    Add('.gzip=application/x-gzip');  {Do not Localize}
    Add('.gnumeric=application/x-gnumeric');    {Do not Localize}
    Add('.gtar=application/x-gtar');    {Do not Localize}
    Add('.gz=application/x-gzip');    {Do not Localize}
    Add('.hdf=application/x-hdf');    {Do not Localize}
    Add('.hlp=application/winhlp');    {Do not Localize}
    Add('.hpf=application/x-icq-hpf');    {Do not Localize}
    Add('.hqx=application/mac-binhex40');    {Do not Localize}
    Add('.hta=application/hta');    {Do not Localize}
    Add('.ims=application/vnd.ms-ims');    {Do not Localize}
    Add('.ins=application/x-internet-signup');    {Do not Localize}
    Add('.iii=application/x-iphone');    {Do not Localize}
    Add('.iso=application/x-iso9660-image');    {Do not Localize}
    Add('.jar=application/java-archive');    {Do not Localize}
    Add('.karbon=application/vnd.kde.karbon');    {Do not Localize}
    Add('.kfo=application/vnd.kde.kformula');    {Do not Localize}
    Add('.kon=application/vnd.kde.kontour');    {Do not Localize}
    Add('.kpr=application/vnd.kde.kpresenter');    {Do not Localize}
    Add('.kpt=application/vnd.kde.kpresenter');    {Do not Localize}
    Add('.kwd=application/vnd.kde.kword');    {Do not Localize}
    Add('.kwt=application/vnd.kde.kword');    {Do not Localize}
    Add('.latex=application/x-latex');    {Do not Localize}
    Add('.lha=application/x-lzh');    {Do not Localize}
    Add('.lcc=application/fastman');    {Do not Localize}
    Add('.lrm=application/vnd.ms-lrm');    {Do not Localize}
    Add('.lz=application/x-lzip');    {Do not Localize}
    Add('.lzh=application/x-lzh');    {Do not Localize}
    Add('.lzma=application/x-lzma');  {Do not Localize}
    Add('.lzo=application/x-lzop'); {Do not Localize}
    Add('.lzx=application/x-lzx');
    Add('.m13=application/x-msmediaview');    {Do not Localize}
    Add('.m14=application/x-msmediaview');    {Do not Localize}
    Add('.mpp=application/vnd.ms-project');    {Do not Localize}
    Add('.mvb=application/x-msmediaview');    {Do not Localize}
    Add('.man=application/x-troff-man');    {Do not Localize}
    Add('.mdb=application/x-msaccess');    {Do not Localize}
    Add('.me=application/x-troff-me');    {Do not Localize}
    Add('.ms=application/x-troff-ms');    {Do not Localize}
    Add('.msi=application/x-msi');    {Do not Localize}
    Add('.mpkg=vnd.apple.installer+xml');    {Do not Localize}
    Add('.mny=application/x-msmoney');    {Do not Localize}
    Add('.nix=application/x-mix-transfer');    {Do not Localize}
    Add('.o=application/x-object');    {Do not Localize}
    Add('.oda=application/oda');    {Do not Localize}
    Add('.odb=application/vnd.oasis.opendocument.database');    {Do not Localize}
    Add('.odc=application/vnd.oasis.opendocument.chart');    {Do not Localize}
    Add('.odf=application/vnd.oasis.opendocument.formula');    {Do not Localize}
    Add('.odg=application/vnd.oasis.opendocument.graphics');    {Do not Localize}
    Add('.odi=application/vnd.oasis.opendocument.image');    {Do not Localize}
    Add('.odm=application/vnd.oasis.opendocument.text-master');    {Do not Localize}
    Add('.odp=application/vnd.oasis.opendocument.presentation');    {Do not Localize}
    Add('.ods=application/vnd.oasis.opendocument.spreadsheet');    {Do not Localize}
    Add('.ogg=application/ogg');    {Do not Localize}
    Add('.odt=application/vnd.oasis.opendocument.text');    {Do not Localize}
    Add('.otg=application/vnd.oasis.opendocument.graphics-template');    {Do not Localize}
    Add('.oth=application/vnd.oasis.opendocument.text-web');    {Do not Localize}
    Add('.otp=application/vnd.oasis.opendocument.presentation-template');    {Do not Localize}
    Add('.ots=application/vnd.oasis.opendocument.spreadsheet-template');    {Do not Localize}
    Add('.ott=application/vnd.oasis.opendocument.text-template');    {Do not Localize}
    Add('.p10=application/pkcs10');    {Do not Localize}
    Add('.p12=application/x-pkcs12');    {Do not Localize}
    Add('.p7b=application/x-pkcs7-certificates');    {Do not Localize}
    Add('.p7m=application/pkcs7-mime');    {Do not Localize}
    Add('.p7r=application/x-pkcs7-certreqresp');    {Do not Localize}
    Add('.p7s=application/pkcs7-signature');    {Do not Localize}
    Add('.package=application/vnd.autopackage');    {Do not Localize}
    Add('.pfr=application/font-tdpfr');    {Do not Localize}
    Add('.pkg=vnd.apple.installer+xml');    {Do not Localize}
    Add('.pdf=application/pdf');    {Do not Localize}
    Add('.pko=application/vnd.ms-pki.pko');    {Do not Localize}
    Add('.pl=application/x-perl');    {Do not Localize}
    Add('.pnq=application/x-icq-pnq');    {Do not Localize}
    Add('.pot=application/mspowerpoint');    {Do not Localize}
    Add('.pps=application/mspowerpoint');    {Do not Localize}
    Add('.ppt=application/mspowerpoint');    {Do not Localize}
    Add('.ppz=application/mspowerpoint');    {Do not Localize}
    Add('.ps=application/postscript');    {Do not Localize}
    Add('.pub=application/x-mspublisher');    {Do not Localize}
    Add('.qpw=application/x-quattropro');    {Do not Localize}
    Add('.qtl=application/x-quicktimeplayer');    {Do not Localize}
    Add('.rar=application/rar');    {Do not Localize}
    Add('.rdf=application/rdf+xml');    {Do not Localize}
    Add('.rjs=application/vnd.rn-realsystem-rjs');    {Do not Localize}
    Add('.rm=application/vnd.rn-realmedia');    {Do not Localize}
    Add('.rmf=application/vnd.rmf');    {Do not Localize}
    Add('.rmp=application/vnd.rn-rn_music_package');    {Do not Localize}
    Add('.rmx=application/vnd.rn-realsystem-rmx');    {Do not Localize}
    Add('.rnx=application/vnd.rn-realplayer');    {Do not Localize}
    Add('.rpm=application/x-redhat-package-manager');
    Add('.rsml=application/vnd.rn-rsml');    {Do not Localize}
    Add('.rtsp=application/x-rtsp');    {Do not Localize}
    Add('.rss=application/rss+xml');    {Do not Localize}
    Add('.scm=application/x-icq-scm');    {Do not Localize}
    Add('.ser=application/java-serialized-object');    {Do not Localize}
    Add('.scd=application/x-msschedule');    {Do not Localize}
    Add('.sda=application/vnd.stardivision.draw');    {Do not Localize}
    Add('.sdc=application/vnd.stardivision.calc');    {Do not Localize}
    Add('.sdd=application/vnd.stardivision.impress');    {Do not Localize}
    Add('.sdp=application/x-sdp');    {Do not Localize}
    Add('.setpay=application/set-payment-initiation');    {Do not Localize}
    Add('.setreg=application/set-registration-initiation');    {Do not Localize}
    Add('.sh=application/x-sh');    {Do not Localize}
    Add('.shar=application/x-shar');    {Do not Localize}
    Add('.shw=application/presentations');    {Do not Localize}
    Add('.sit=application/x-stuffit');    {Do not Localize}
    Add('.sitx=application/x-stuffitx');  {Do not localize}
    Add('.skd=application/x-koan');    {Do not Localize}
    Add('.skm=application/x-koan');    {Do not Localize}
    Add('.skp=application/x-koan');    {Do not Localize}
    Add('.skt=application/x-koan');    {Do not Localize}
    Add('.smf=application/vnd.stardivision.math');    {Do not Localize}
    Add('.smi=application/smil');    {Do not Localize}
    Add('.smil=application/smil');    {Do not Localize}
    Add('.spl=application/futuresplash');    {Do not Localize}
    Add('.ssm=application/streamingmedia');    {Do not Localize}
    Add('.sst=application/vnd.ms-pki.certstore');    {Do not Localize}
    Add('.stc=application/vnd.sun.xml.calc.template');    {Do not Localize}
    Add('.std=application/vnd.sun.xml.draw.template');    {Do not Localize}
    Add('.sti=application/vnd.sun.xml.impress.template');    {Do not Localize}
    Add('.stl=application/vnd.ms-pki.stl');    {Do not Localize}
    Add('.stw=application/vnd.sun.xml.writer.template');    {Do not Localize}
    Add('.svi=application/softvision');    {Do not Localize}
    Add('.sv4cpio=application/x-sv4cpio');    {Do not Localize}
    Add('.sv4crc=application/x-sv4crc');    {Do not Localize}
    Add('.swf=application/x-shockwave-flash');    {Do not Localize}
    Add('.swf1=application/x-shockwave-flash');    {Do not Localize}
    Add('.sxc=application/vnd.sun.xml.calc');    {Do not Localize}
    Add('.sxi=application/vnd.sun.xml.impress');    {Do not Localize}
    Add('.sxm=application/vnd.sun.xml.math');    {Do not Localize}
    Add('.sxw=application/vnd.sun.xml.writer');    {Do not Localize}
    Add('.sxg=application/vnd.sun.xml.writer.global');    {Do not Localize}
    Add('.t=application/x-troff');    {Do not Localize}
    Add('.tar=application/x-tar');    {Do not Localize}
    Add('.tcl=application/x-tcl');    {Do not Localize}
    Add('.tex=application/x-tex');    {Do not Localize}
    Add('.texi=application/x-texinfo');    {Do not Localize}
    Add('.texinfo=application/x-texinfo');    {Do not Localize}
    Add('.tbz=application/x-bzip-compressed-tar');   {Do not Localize}
    Add('.tbz2=application/x-bzip-compressed-tar');   {Do not Localize}
    Add('.tgz=application/x-compressed-tar');    {Do not Localize}
    Add('.tlz=application/x-lzma-compressed-tar');    {Do not Localize}
    Add('.tr=application/x-troff');    {Do not Localize}
    Add('.trm=application/x-msterminal');    {Do not Localize}
    Add('.troff=application/x-troff');    {Do not Localize}
    Add('.tsp=application/dsptype');    {Do not Localize}
    Add('.torrent=application/x-bittorrent');    {Do not Localize}
    Add('.ttz=application/t-time');    {Do not Localize}
    Add('.txz=application/x-xz-compressed-tar'); {Do not localize}
    Add('.udeb=application/x-debian-package');    {Do not Localize}

    Add('.uin=application/x-icq');    {Do not Localize}
    Add('.urls=application/x-url-list');    {Do not Localize}
    Add('.ustar=application/x-ustar');    {Do not Localize}
    Add('.vcd=application/x-cdlink');    {Do not Localize}
    Add('.vor=application/vnd.stardivision.writer');    {Do not Localize}
    Add('.vsl=application/x-cnet-vsl');    {Do not Localize}
    Add('.wcm=application/vnd.ms-works');    {Do not Localize}
    Add('.wb1=application/x-quattropro');    {Do not Localize}
    Add('.wb2=application/x-quattropro');    {Do not Localize}
    Add('.wb3=application/x-quattropro');    {Do not Localize}
    Add('.wdb=application/vnd.ms-works');    {Do not Localize}
    Add('.wks=application/vnd.ms-works');    {Do not Localize}
    Add('.wmd=application/x-ms-wmd');    {Do not Localize}
    Add('.wms=application/x-ms-wms');    {Do not Localize}
    Add('.wmz=application/x-ms-wmz');    {Do not Localize}
    Add('.wp5=application/wordperfect5.1');    {Do not Localize}
    Add('.wpd=application/wordperfect');    {Do not Localize}
    Add('.wpl=application/vnd.ms-wpl');    {Do not Localize}
    Add('.wps=application/vnd.ms-works');    {Do not Localize}
    Add('.wri=application/x-mswrite');    {Do not Localize}
    Add('.xfdf=application/vnd.adobe.xfdf');    {Do not Localize}
    Add('.xls=application/x-msexcel');    {Do not Localize}
    Add('.xlb=application/x-msexcel');     {Do not Localize}
    Add('.xpi=application/x-xpinstall');    {Do not Localize}
    Add('.xps=application/vnd.ms-xpsdocument');    {Do not Localize}
    Add('.xsd=application/vnd.sun.xml.draw');    {Do not Localize}
    Add('.xul=application/vnd.mozilla.xul+xml');    {Do not Localize}
    Add('.z=application/x-compress');    {Do not Localize}
    Add('.zoo=application/x-zoo');    {Do not Localize}
    Add('.zip=application/x-zip-compressed');    {Do not Localize}
    
    { WAP }
    Add('.wbmp=image/vnd.wap.wbmp');    {Do not Localize}
    Add('.wml=text/vnd.wap.wml');    {Do not Localize}
    Add('.wmlc=application/vnd.wap.wmlc');    {Do not Localize}
    Add('.wmls=text/vnd.wap.wmlscript');    {Do not Localize}
    Add('.wmlsc=application/vnd.wap.wmlscriptc');    {Do not Localize}

    { Non-web text}
    {
    IMPORTANT!!

    You should not use a text MIME type definition unless you are 
    extremely certain that the file will NOT be a binary.  Some browsers 
    will display the text instead of saving to disk and it looks ugly
    if a web-browser shows all of the 8bit charactors.
    }
    //of course, we have to add this :-).
    Add('.asm=text/x-asm');   {Do not Localize}
    Add('.p=text/x-pascal');    {Do not Localize}
    Add('.pas=text/x-pascal');    {Do not Localize}

    Add('.cs=text/x-csharp'); {Do not Localize}

    Add('.c=text/x-csrc');    {Do not Localize}
    Add('.c++=text/x-c++src');    {Do not Localize}
    Add('.cpp=text/x-c++src');    {Do not Localize}
    Add('.cxx=text/x-c++src');    {Do not Localize}
    Add('.cc=text/x-c++src');    {Do not Localize}
    Add('.h=text/x-chdr'); {Do not localize}
    Add('.h++=text/x-c++hdr');    {Do not Localize}
    Add('.hpp=text/x-c++hdr');    {Do not Localize}
    Add('.hxx=text/x-c++hdr');    {Do not Localize}
    Add('.hh=text/x-c++hdr');    {Do not Localize}
    Add('.java=text/x-java');    {Do not Localize}

    { WEB }
    Add('.css=text/css');    {Do not Localize}
    Add('.js=text/javascript');    {Do not Localize}
    Add('.htm=text/html');    {Do not Localize}
    Add('.html=text/html');    {Do not Localize}
    Add('.xhtml=application/xhtml+xml'); {Do not localize}
    Add('.xht=application/xhtml+xml'); {Do not localize}
    Add('.rdf=application/rdf+xml'); {Do not localize}
    Add('.rss=application/rss+xml'); {Do not localize}

    Add('.ls=text/javascript');    {Do not Localize}
    Add('.mocha=text/javascript');    {Do not Localize}
    Add('.shtml=server-parsed-html');    {Do not Localize}
    Add('.xml=text/xml');    {Do not Localize}
    Add('.sgm=text/sgml');    {Do not Localize}
    Add('.sgml=text/sgml');    {Do not Localize}
  end;

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
      EIdException.Toss(RSMIMEExtensionEmpty);
    end;
    Exit;
  end;
  { Check and fix MIMEType }
  LMIMEType := IndyLowerCase(MIMEType);
  if Length(LMIMEType) = 0 then begin
    if ARaiseOnError then begin
      EIdException.Toss(RSMIMEMIMETypeEmpty);
    end;
    Exit;
  end;
  if LExt[1] <> '.' then begin    {do not localize}
    LExt := '.' + LExt;      {do not localize}
  end;
  { Check list }
  if FFileExt.IndexOf(LExt) = -1 then begin
    FFileExt.Add(LExt);
    FMIMEList.Add(LMIMEType);
  end else begin
    if ARaiseOnError then begin
      EIdException.Toss(RSMIMEMIMEExtAlreadyExists);
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
    P := Pos(MimeSeparator, S);
    if P > 0 then begin
      Ext := IndyLowerCase(Copy(S, 1, P - 1));
      AddMimeType(Ext, Copy(S, P + 1, MaxInt), False);
    end;
  end;
end;



procedure TIdMimeTable.SaveToStrings(const AStrings: TStrings;
  const MimeSeparator: Char);
var
  I : Integer;
begin
  Assert(AStrings <> nil);
  AStrings.Clear;
  for I := 0 to FFileExt.Count - 1 do begin
    AStrings.Add(FFileExt[I] + MimeSeparator + FMIMEList[I]);
  end;
end;

function IsValidIP(const S: String): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LErr: Boolean;
begin
  LErr := False; // keep the compiler happy
  IPv4ToDWord(S, LErr);
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
        end else begin
          DiscardUntil(AStr, LQuoteChar, VPos, ALen);
        end;
        Inc(VPos);
      end else begin
        if TextIsSame(LWord, 'CONTENT') then begin
          Result := Result + ' ' + ParseUntilCharOrEndOfTag(AStr, ' ', VPos, ALen); {do not localize}
        end else begin
          DiscardUntilCharOrEndOfTag(AStr, ' ', VPos, ALen); {do not localize}
        end;
      end;
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
  Result := 'Content-Type: text/html; charset="' + LWord + '"'; {do not localize}
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

procedure ParseMetaHTTPEquiv(AStream: TStream; AStr : TStrings);
type
  TIdHTMLMode = (none, html, title, head, body, comment);
var
  LRawData : String;
  LWord : String;
  LMode : TIdHTMLMode;
  LPos : Integer;
  LLen : Integer;
begin
//  AStr.Clear;
  AStream.Position := 0;
  LRawData := ReadStringFromStream(AStream, -1, Indy8BitEncoding{$IFDEF STRING_IS_ANSI}, Indy8BitEncoding{$ENDIF});
  LMode := none;
  LPos := 0;
  LLen := Length(LRawData);
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
                    AStr.Add( ParseHTTPMetaEquiveData(LRawData, LPos, LLen) );
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
                    AStr.Add( ParseMetaCharsetData(LRawData, LPos, LLen) );
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

procedure SplitHeaderSubItems(AHeaderLine: String; AItems: TStrings;
  AQuoteType: TIdHeaderQuotingType);
var
  LName, LValue, LSep: String;
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
    if TextStartsWith(AHeaderLine, '"') then {do not localize}
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
    if (LName <> '') and (LValue <> '') then begin
      AItems.Add(LName + '=' + LValue);
    end;
  end;
end;

function ExtractHeaderSubItem(const AHeaderLine, ASubItem: String;
  AQuoteType: TIdHeaderQuotingType): String;
var
  LItems: TStringList;
  {$IFNDEF HAS_TStringList_CaseSensitive}
  I: Integer;
  LTmp: string;
  {$ENDIF}
begin
  Result := '';
  LItems := TStringList.Create;
  try
    SplitHeaderSubItems(AHeaderLine, LItems, AQuoteType);
    {$IFDEF HAS_TStringList_CaseSensitive}
    LItems.CaseSensitive := False;
    Result := LItems.Values[ASubItem];
    {$ELSE}
    for I := 0 to LItems.Count-1 do
    begin
      if TextIsSame(LItems.Names[I], ASubItem) then
      begin
        LTmp := LItems.Strings[I];
        Result := Copy(LTmp, Pos('=', LTmp)+1, MaxInt); {do not localize}
        Break;
      end;
    end;
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
  LItems: TStringList;
  I: Integer;
  {$IFNDEF HAS_TStrings_ValueFromIndex}
  LTmp: string;
  {$ENDIF}
  LValue: string;

  {$IFNDEF HAS_TStringList_CaseSensitive}
  function FindIndexOfItem: Integer;
  var
    I: Integer;
  begin
    for I := 0 to LItems.Count-1 do
    begin
      if TextIsSame(LItems.Names[I], ASubItem) then
      begin
        Result := I;
        Exit;
      end;
    end;
    Result := -1;
  end;
  {$ENDIF}

  function QuoteString(const S: String): String;
  var
    I: Integer;
    LAddQuotes: Boolean;
    LNeedQuotes, LNeedEscape: String;
  begin
    Result := '';
    if Length(S) = 0 then begin
      Exit;
    end;
    LAddQuotes := False;
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
  LItems := TStringList.Create;
  try
    SplitHeaderSubItems(AHeaderLine, LItems, AQuoteType);
    {$IFDEF HAS_TStringList_CaseSensitive}
    LItems.CaseSensitive := False;
    I := LItems.IndexOfName(ASubItem);
    {$ELSE}
    I := FindIndexOfItem;
    {$ENDIF}
    if I >= 0 then begin
      VOld := LItems.Strings[I];
      Fetch(VOld, '=');
    end else begin
      VOld := '';
    end;
    LValue := Trim(AValue);
    if LValue <> '' then begin
      if I < 0 then begin
        I := LItems.Add('');
      end;
      LItems.Strings[I] := ASubItem + '=' + LValue; {do not localize}
    end
    else if I >= 0 then begin
      LItems.Delete(I);
    end;
    Result := ExtractHeaderItem(AHeaderLine);
    if Result <> '' then begin
      for I := 0 to LItems.Count-1 do begin
        {$IFDEF HAS_TStrings_ValueFromIndex}
        Result := Result + '; ' + LItems.Names[I] + '=' + QuoteString(LItems.ValueFromIndex[I]); {do not localize}
        {$ELSE}
        LTmp := LItems.Strings[I];
        Result := Result + '; ' + LItems.Names[I] + '=' + QuoteString(Copy(LTmp, Pos('=', LTmp)+1, MaxInt)); {do not localize}
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

function GetClockValue : Int64;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ENDIF}
{$IFDEF WINDOWS}
type
  TLong64Rec = record
    case LongInt of
      0 : (High : LongWord;
           Low : LongWord);
      1 : (Long : Int64);
    end;

var
  LFTime : TFileTime;
{$ENDIF}
{$IFDEF UNIX}
  {$IFNDEF USE_VCL_POSIX}
var
  TheTms: tms;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF WINDOWS}
    {$IFDEF WINCE}
    // TODO
    {$ELSE}
  Windows.GetSystemTimeAsFileTime(LFTime);
  TLong64Rec(Result).Low := LFTime.dwLowDateTime;
  TLong64Rec(Result).High := LFTime.dwHighDateTime;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF UNIX}
  //Is the following correct?
    {$IFDEF USE_BASEUNIX}
  Result := fptimes(TheTms);
    {$ENDIF}
    {$IFDEF KYLIXCOMPAT}
  Result := Times(TheTms);
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
  Result := time(nil);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DOTNET}
  Result := System.DateTime.Now.Ticks;
  {$ENDIF}
end;

{$UNDEF NO_NATIVE_X86}
{$IFDEF DOTNET}
  {$DEFINE NO_NATIVE_X86}
{$ENDIF}
{$IFDEF FPC}
  {$IFNDEF CPUI386}
    {$DEFINE NO_NATIVE_X86}
  {$ENDIF}
{$ENDIF}

{$IFDEF NO_NATIVE_X86}
function ROL(const AVal: LongWord; AShift: Byte): LongWord;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (AVal shl AShift) or (AVal shr (32 - AShift));
end;

function ROR(const AVal: LongWord; AShift: Byte): LongWord;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
   Result := (AVal shr AShift) or (AVal shl (32 - AShift)) ;
end;

{$ELSE}

// Arg1=EAX, Arg2=DL
function ROL(const AVal: LongWord; AShift: Byte): LongWord; assembler;
asm
  mov  cl, dl
  rol  eax, cl
end;

function ROR(const AVal: LongWord; AShift: Byte): LongWord; assembler;
asm
  mov  cl, dl
  ror  eax, cl
end;
{$ENDIF}

function IndyComputerName: string;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ENDIF}
{$IFDEF UNIX}
var
  LHost: array[1..255] of AnsiChar;
  i: LongWord;
{$ENDIF}
{$IFDEF WINDOWS}
var
  i: LongWord;
{$ENDIF}
begin
  {$IFDEF UNIX}
  //TODO: No need for LHost at all? Prob can use just Result
    {$IFDEF KYLIXCOMPAT}
  if GetHostname(@LHost[1], 255) <> -1 then begin
    i := IndyPos(#0, LHost);
    SetString(Result, PAnsiChar(@LHost[1]), i-1);
  end;
    {$ENDIF}
    {$IFDEF USE_BASE_UNIX}
  Result := GetHostName;
    {$ENDIF}
    {$IFDEF USE_VCL_POSIX}
  if Posix.Unistd.gethostname(@LHost[1], 255) <> -1 then begin
    i := IndyPos(#0, String(LHost));
    SetString(Result, PAnsiChar(@LHost[1]), i-1);
  end;
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$IFDEF WINCE}
      {$WARNING To Do - find some way to get the Computer Name.}
    {$ELSE}
  SetLength(Result, MAX_COMPUTERNAME_LENGTH + 1);
  i := Length(Result);
  if GetComputerName(PChar(Result), i) then begin
    SetLength(Result, i);
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

function RemoveHeaderEntries(const AHeader: string; AEntries: array of string;
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
  AQuoteType: TIdHeaderQuotingType): TIdTextEncoding;
var
  LCharset: String;
begin
  LCharset := ExtractHeaderSubItem(AContentType, 'charset', AQuoteType);  {do not localize}
  Result := CharsetToEncoding(LCharset);
end;

{$IFNDEF DOTNET_OR_ICONV}
  // SysUtils.TEncoding.GetEncoding() in Delphi 2009 and 2010 does not
  // implement UTF-7 and UTF-16 correctly.  This was fixed in Delphi XE...
  {$DEFINE USE_TIdTextEncoding_GetEncoding}
  {$IFDEF TIdTextEncoding_IS_NATIVE}
    {$IFDEF BROKEN_TEncoding_GetEncoding}
      {$UNDEF USE_TIdTextEncoding_GetEncoding}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

function CharsetToEncoding(const ACharset: String): TIdTextEncoding;
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

    // RLebeau 3/13/09: if there is a problem initializing an encoding
    // class for the requested charset, either because the charset is
    // not known to Indy, or because the OS does not support it natively,
    // just return the 8-bit encoding as a fallback for now.  The data
    // being handled by it likely won't be encoded/decoded properly, but
    // at least the error won't cause exceptions in the user's code, and
    // maybe the user will know how to encode/decode the data manually
    // as a workaround...

    // RLebeau: on non-DotNet systems, setting the AOwnedByIndy parameter
    // of Indy...Encoding() to False so that the caller does not have to
    // figure out whether or not to free the output TIdTextEncoding.
    // Standard TIdTextEncoding objects are owned by the RTL, and the
    // encoding objects that Indy...Encoding() normally return are owned
    // by IdGlobal.pas, and thus should not be freed.  Objects returned
    // by TIdTextEncoding.GetEncoding() and Indy...Encoding(False) are
    // not owned by anyone and must always be freed.

    try
      {$IFDEF DOTNET_OR_ICONV}
      Result := TIdTextEncoding.GetEncoding(ACharset);
      {$ELSE}
      CP := CharsetToCodePage(ACharset);
      case CP of
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
        {$IFNDEF USE_TIdTextEncoding_GetEncoding}
        1200:
          Result := TIdUTF16LittleEndianEncoding.Create;
        1201:
          Result := TIdUTF16BigEndianEncoding.Create;
        65000:
          Result := TIdUTF7Encoding.Create;
        {$ENDIF}
      else
        begin
          if CP <> 0 then begin
            {$IFDEF USE_TIdTextEncoding_GetEncoding}
            Result := TIdTextEncoding.GetEncoding(CP);
            {$ELSE}
            Result := TIdMBCSEncoding.Create(CP);
            {$ENDIF}
          end;
        end;
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
    Result := Indy8BitEncoding{$IFNDEF DOTNET}(False){$ENDIF};
  end;
end;

procedure WriteStringAsContentType(AStream: TStream; const AStr, AContentType: String;
  AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := ContentTypeToEncoding(AContentType, AQuoteType);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    WriteStringToStream(AStream, AStr, LEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

procedure WriteStringsAsContentType(AStream: TStream; const AStrings: TStrings;
  const AContentType: String; AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := ContentTypeToEncoding(AContentType, AQuoteType);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    // RLebeau 10/06/2010: not using TStrings.SaveToStream() in D2009+
    // anymore, as it may save a BOM which we do not want here...
    WriteStringToStream(AStream, AStrings.Text, LEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

procedure WriteStringAsCharset(AStream: TStream; const AStr, ACharset: string
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := CharsetToEncoding(ACharset);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    WriteStringToStream(AStream, AStr, LEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

procedure WriteStringsAsCharset(AStream: TStream; const AStrings: TStrings;
  const ACharset: string
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: TIdTextEncoding = nil{$ENDIF});
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := CharsetToEncoding(ACharset);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    // RLebeau 10/06/2010: not using TStrings.SaveToStream() in D2009+
    // anymore, as it may save a BOM which we do not want here...
    WriteStringToStream(AStream, AStrings.Text, LEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

function ReadStringAsContentType(AStream: TStream; const AContentType: String;
  AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
): String;
var
  LEncoding: TIdTextEncoding;
begin
  Result := '';
  LEncoding := ContentTypeToEncoding(AContentType, AQuoteType);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    Result := ReadStringFromStream(AStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

procedure ReadStringsAsContentType(AStream: TStream; AStrings: TStrings;
  const AContentType: String; AQuoteType: TIdHeaderQuotingType
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
);
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := ContentTypeToEncoding(AContentType, AQuoteType);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    {$IFDEF HAS_TEncoding}
    AStrings.LoadFromStream(AStream, LEncoding);
    {$ELSE}
    AStrings.Text := ReadStringFromStream(AStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    {$ENDIF}
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

function ReadStringAsCharset(AStream: TStream; const ACharset: String
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
): String;
//TODO:  Figure out what should happen with Unicode content type.
var
  LEncoding: TIdTextEncoding;
begin
  Result := '';
  LEncoding := CharsetToEncoding(ACharset);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    Result := ReadStringFromStream(AStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

procedure ReadStringsAsCharset(AStream: TStream; AStrings: TStrings; const ACharset: String
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: TIdTextEncoding = nil{$ENDIF}
);
var
  LEncoding: TIdTextEncoding;
begin
  LEncoding := CharsetToEncoding(ACharset);
  {$IFNDEF DOTNET}
  try
  {$ENDIF}
    {$IFDEF HAS_TEncoding}
    AStrings.LoadFromStream(AStream, LEncoding);
    {$ELSE}
    AStrings.Text := ReadStringFromStream(AStream, -1, LEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    {$ENDIF}
  {$IFNDEF DOTNET}
  finally
    LEncoding.Free;
  end;
  {$ENDIF}
end;

{ TIdInterfacedObject }

function TIdInterfacedObject._AddRef: Integer;
begin
  {$IFDEF DOTNET}
  Result := 1;
  {$ELSE}
  Result := inherited _AddRef;
  {$ENDIF}
end;

function TIdInterfacedObject._Release: Integer;
begin
  {$IFDEF DOTNET}
  Result := 1;
  {$ELSE}
  Result := inherited _Release;
  {$ENDIF}
end;

initialization
  {$IFDEF WINDOWS}
  ATempPath := TempPath;
  {$ENDIF}
  SetLength(IndyFalseBoolStrs, 1);
  IndyFalseBoolStrs[Low(IndyFalseBoolStrs)] := 'FALSE';    {Do not Localize}
  SetLength(IndyTrueBoolStrs, 1);
  IndyTrueBoolStrs[Low(IndyTrueBoolStrs)] := 'TRUE';    {Do not Localize}
end.
