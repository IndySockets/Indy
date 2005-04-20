{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  56901: IdGlobalProtocols.pas
{
{   Rev 1.31    04/03/2005 21:21:56  HHariri
{ Fix for DirectoryExists and removal of FileCtrl dependency
}
{
{   Rev 1.30    3/3/2005 10:12:38 AM  JPMugaas
{ Fix for compiler warning about DotNET and ByteType.
}
{
{   Rev 1.29    2/12/2005 8:08:02 AM  JPMugaas
{ Attempt to fix MDTM bug where msec was being sent.
}
{
{   Rev 1.28    2/10/2005 2:24:40 PM  JPMugaas
{ Minor Restructures for some new UnixTime Service components.
}
{
{   Rev 1.27    1/15/2005 6:02:46 PM  JPMugaas
{ Byte extract with byte order now use updated code in IdGlobal.
}
{
{   Rev 1.26    1/8/2005 3:59:58 PM  JPMugaas
{ New functions for reading integer values to and from TIdBytes using the
{ network byte order functions.  They should be used for embedding values in
{ some Internet Protocols such as FSP, SNTP, and maybe others.
}
{
    Rev 1.25    12/3/2004 3:16:20 PM  DSiders
  Fixed assignment error in MakeTempFilename.
}
{
{   Rev 1.24    12/1/2004 4:40:42 AM  JPMugaas
{ Fix for GMT Time routine.  This has been tested.
}
{
{   Rev 1.23    11/14/2004 10:28:42 PM  JPMugaas
{ Compiler warning in IdGlobalProtocol about an undefined result.
}
{
{   Rev 1.22    12/11/2004 9:31:22  HHariri
{ Fix for Delphi 5
}
{
{   Rev 1.21    11/11/2004 11:18:04 PM  JPMugaas
{ Function to get the Last Modified file in GMT instead of localtime.  Needed
{ by TIdFSP.
}
{
{   Rev 1.20    2004.10.27 9:17:50 AM  czhower
{ For TIdStrings
}
{
{   Rev 1.19    10/26/2004 10:07:02 PM  JPMugaas
{ Updated refs.
}
{
    Rev 1.18    10/13/2004 7:48:52 PM  DSiders
  Modified GetUniqueFilename to pass correct argument type to tempnam function.
}
{
    Rev 1.17    10/6/2004 11:39:48 PM  DSiders
  Modified MakeTempFilename to use GetUniqueFilename.  File extensions are
  omitted on Linux.
  Modified GetUniqueFilename to use tempnam function on Linux.  Validates path
  on Win32 and .Net.  Uses platform-specific temp path on Win32 and .Net.
}
{
{   Rev 1.16    9/5/2004 2:55:52 AM  JPMugaas
{ Fixed a range check error in
{
{  function TwoCharToWord(AChar1,AChar2: Char):Word;.
}
{
{   Rev 1.15    8/10/04 8:47:16 PM  RLebeau
{ Bug fix for TIdMimeTable.AddMimeType()
}
{
{   Rev 1.14    8/5/04 5:44:40 PM  RLebeau
{ Added GetMIMEDefaultFileExt() function
}
{
{   Rev 1.13    7/23/04 6:51:34 PM  RLebeau
{ Added extra exception handling to IndyCopyFile()
{
{ Updated CopyFileTo() to call IndyCopyFile()
{
{ TFileStream access right tweak for FileSizeByName()
}
{
{   Rev 1.12    7/8/04 5:23:46 PM  RLebeau
{ Updated CardinalToFourChar() to remove use of local TIdBytes variable
}
{
{   Rev 1.11    11/06/2004 00:22:38  CCostelloe
{ Implemented GetClockValue for Linux
}
{
{   Rev 1.10    09/06/2004 10:03:00  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.9    02/05/2004 13:20:50  CCostelloe
{ Added RemoveHeaderEntry for use by IdMessage and IdMessageParts (typically
{ removing old boundary)
}
{
{   Rev 1.8    2/22/2004 12:09:38 AM  JPMugaas
{ Fixes for IMAP4Server compile failure in DotNET.  This also fixes a potential
{ problem where file handles can be leaked in the server needlessly.
}
{
{   Rev 1.7    2/19/2004 11:53:00 PM  JPMugaas
{ Moved some functions out of CoderQuotedPrintable for reuse.
}
{
{   Rev 1.6    2/19/2004 11:40:28 PM  JPMugaas
{ Character to hex translation routine added for QP and some
{ internationalization work.
}
{
{   Rev 1.5    2/19/2004 3:22:40 PM  JPMugaas
{ ABNFToText and related functions added for some RFC 2234.  This is somee
{ groundwork for RFC 2640 - Internationalization of the File Transfer Protocol.
}
{
{   Rev 1.4    2/16/2004 1:53:34 PM  JPMugaas
{ Moved some routines to the system package.
}
{
{   Rev 1.3    2/11/2004 5:17:50 AM  JPMugaas
{ Bit flip functionality was removed because is problematic on some
{ architectures.  They were used in place of the standard network byte order
{ conversion routines.  On an Intel chip, flip works the same as those but in
{ architectures where network order is the same as host order, some functions
{ will fail and you may get strange results.  The network byte order conversion
{ functions provide transparancy amoung architectures.
}
{
{   Rev 1.2    2/9/2004 11:27:48 AM  JPMugaas
{ Some functions weren't working as expected.  Renamed them to describe them
{ better.
}
{
{   Rev 1.1    2/7/2004 7:18:38 PM  JPMugaas
{ Moved some functions out of IdDNSCommon so we can use them elsewhere.
}
{
{   Rev 1.0    2004.02.03 7:46:04 PM  czhower
{ New names
}
{
{   Rev 1.43    1/31/2004 3:31:58 PM  JPMugaas
{ Removed some File System stuff for new package.
}
{
{   Rev 1.42    1/31/2004 1:00:26 AM  JPMugaas
{ FileDateByName was changed to LocalFileDateByName as that uses the Local Time
{ Zone.
{ Added BMTDateByName for some GMT-based stuff.
{ We now use the IdFileSystem*.pas units instead of SysUtils for directory
{ functions.  This should remove a dependancy on platform specific things in
{ DotNET.
}
{
{   Rev 1.41    1/29/2004 6:22:22 AM  JPMugaas
{ IndyComputerName will now use Environment.MachineName in DotNET.  This should
{ fix the ESMTP bug where IndyComputerName would return nothing causing an EHLO
{ and HELO command to fail in TIdSMTP under DotNET.
}
{
{   Rev 1.40    2004.01.22 5:58:56 PM  czhower
{ IdCriticalSection
}
{
{   Rev 1.39    14/01/2004 00:16:10  CCostelloe
{ Updated to remove deprecated warnings by using
{ TextIsSame/IndyLowerCase/IndyUpperCase
}
{
{   Rev 1.38    2003.12.28 6:50:30 PM  czhower
{ Update for Ticks function
}
{
{   Rev 1.37    4/12/2003 10:24:06 PM  GGrieve
{ Fix to Compile
}
{
{   Rev 1.36    11/29/2003 12:19:50 AM  JPMugaas
{ CompareDateTime added for more accurate DateTime comparisons.  Sometimes
{ comparing two floating point values for equality will fail because they are
{ of different percision and some fractions such as 1/3 and pi (7/22) can never
{ be calculated 100% accurately.
}
{
{   Rev 1.35    25/11/2003 12:24:20 PM  SGrobety
{ various IdStream fixes with ReadLn/D6
}
{
    Rev 1.34    10/16/2003 11:18:10 PM  DSiders
  Added localization comments.
  Corrected spelling error in coimments.
}
{
{   Rev 1.33    10/15/2003 9:53:58 PM  GGrieve
{ Add TIdInterfacedObject
}
{
{   Rev 1.32    10/10/2003 10:52:12 PM  BGooijen
{ Removed IdHexDigits
}
{
{   Rev 1.31    10/8/2003 9:52:40 PM  GGrieve
{ reintroduce GetSystemLocale as IdGetDefaultCharSet
}
{
{   Rev 1.30    10/8/2003 2:25:40 PM  GGrieve
{ Update ROL and ROR for DotNet
}
{
{   Rev 1.29    10/5/2003 11:43:32 PM  GGrieve
{ Add IsLeadChar
}
{
{   Rev 1.28    10/5/2003 5:00:10 PM  GGrieve
{ GetComputerName (once was IndyGetHostName)
}
{
{   Rev 1.27    10/4/2003 9:14:26 PM  GGrieve
{ Remove TIdCardinalBytes - replace with other methods
}
{
{   Rev 1.26    10/3/2003 11:55:50 PM  GGrieve
{ First full DotNet version
}
{
{   Rev 1.25    10/3/2003 5:39:30 PM  GGrieve
{ dotnet work
}
{
{   Rev 1.24    2003.10.02 10:52:48 PM  czhower
{ .Net
}
{
{   Rev 1.23    2003.10.02 9:27:50 PM  czhower
{ DotNet Excludes
}
{
{   Rev 1.22    9/18/2003 07:41:46 PM  JPMugaas
{ Moved GetThreadHandle to IdCoreGlobal.
}
{
{   Rev 1.21    9/10/2003 03:26:42 AM  JPMugaas
{ Added EnsureMsgIDBrackets() function.  Checked in on behalf of Remy Lebeau
}
{
{   Rev 1.20    6/27/2003 05:53:28 AM  JPMugaas
{ Removed IsNumeric.  That's now in IdCoreGlobal.
}
{
{   Rev 1.19    2003.06.23 2:57:18 PM  czhower
{ Comments added
}
{
{   Rev 1.18    2003.06.23 9:46:54 AM  czhower
{ Russian, Ukranian support for headers.
}
{
{   Rev 1.17    2003.06.13 2:24:40 PM  czhower
{ Expanded TIdCardinalBytes
}
{
{   Rev 1.16    5/13/2003 12:45:50 PM  JPMugaas
{ GetClockValue added for unique clock values.
}
{
{   Rev 1.15    5/8/2003 08:43:14 PM  JPMugaas
{ Function for finding an integer's position in an array of integers.  This is
{ required by some SASL code.
}
{
    Rev 1.14    4/21/2003 7:52:58 PM  BGooijen
  other nt version detection, removed non-existing windows versions
}
{
{   Rev 1.13    4/18/2003 09:28:24 PM  JPMugaas
{ Changed Win32 Operating System detection so it can distinguish between
{ workstation OS NT versions and server versions.  I also added specific
{ detection for Windows NT 4.0 with a Service Pack below 6 (requested by Bas).
}
{
{   Rev 1.12    2003.04.16 10:06:22 PM  czhower
{ Moved DebugOutput to IdCoreGlobal
}
{
{   Rev 1.11    4/10/2003 02:54:32 PM  JPMugaas
{ Improvement for FTP STOU command.  Unique filename now uses
{ IdGlobal.GetUniqueFileName instead of Rand.  I also fixed GetUniqueFileName
{ so that it can accept an empty path specification.
}
{
    Rev 1.10    4/5/2003 10:39:06 PM  BGooijen
  LAM,LPM were not initialized
}
{
{   Rev 1.9    4/5/2003 04:12:00 AM  JPMugaas
{ Date Time should now be able to process AM/PM.
}
{
{   Rev 1.8    4/4/2003 11:02:56 AM  JPMugaas
{ Added GetUniqueFileName for the Virtual FTP File System component.
}
{
{   Rev 1.7    20/3/2003 19:15:46  GGrieve
{ Fix GMTToLocalDateTime for empty content
}
{
{   Rev 1.6    3/9/2003 04:34:40 PM  JPMugaas
{ FileDateByName now works on directories.
}
{
{   Rev 1.5    2/14/2003 11:50:58 AM  JPMugaas
{ Removed a function for giving an OS identifier in the FTP server because we
{ no longer use that function.
}
{
{   Rev 1.4    1/27/2003 12:30:22 AM  JPMugaas
{ Forgot to add a space after one OS type.  That makes the job a little easier
{ for the FTP Server SYST command handler.
}
{
{   Rev 1.3    1/26/2003 11:56:30 PM  JPMugaas
{ Added function for returning an OS descriptor for combining with a FTP Server
{ SysDescription for the SYST command reply.  This can also optionally return
{ the true system identifier.
}
{
{   Rev 1.2    1/9/2003 05:39:08 PM  JPMugaas
{ Added workaround for if the date is missing a space after a comma.
}
{
{   Rev 1.1    12/29/2002 2:13:14 PM  JPMugaas
{ Moved THandle to IdCoreGlobal for new function used in the core.
}
{
{   Rev 1.0    11/13/2002 08:29:32 AM  JPMugaas
{ Initial import from FTP VC.
}
unit IdGlobalProtocols;

interface
{
2002-04-02 - Darren Kosinski (Borland) - Have SetThreadPriority do nothing on Linux.
2002-01-28 - Hadi Hariri. Fixes for C++ Builder. Thanks to Chuck Smith.
2001-12-21 - Andrew P.Rybin
 - Fetch,FetchCaseInsensitive,IsNumeric(Chr),PosIdx,AnsiPosIdx optimization
2001-Nov-26 - Peter Mee
 - Added IndyStrToBool
2001-Nov-21 - Peter Mee
 - Moved the Fetch function's default values to constants.
 - Added FetchCaseInsensitive.
11-10-2001 - J. Peter Mugaas
  - Merged changes proposed by Andrew P.Rybin}

{$I IdCompilerDefines.inc}

{This is the only unit with references to OS specific units and IFDEFs. NO OTHER units
are permitted to do so except .pas files which are counterparts to dfm/xfm files, and only for
support of that.}

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  Classes,
  IdCharsets,
  IdGlobal,
  IdException,
  IdTStrings,
  IdSysUtils;

const
  LWS = [TAB, CHAR32];
  wdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'    {Do not Localize}
   , 'Sat'); {do not localize}
  monthnames: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May'    {Do not Localize}
   , 'Jun',  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); {do not localize}

type
  TIdReadLnFunction = function: string of object;
  TStringEvent = procedure(ASender: TComponent; const AString: String);

  TIdMimeTable = class(TObject)
  protected
    FOnBuildCache: TNotifyEvent;
    FMIMEList: TIdStringList;
    FFileExt: TIdStringList;
    procedure BuildDefaultCache; virtual;
  public
    procedure BuildCache; virtual;
    procedure AddMimeType(const Ext, MIMEType: string);
    function GetFileMIMEType(const AFileName: string): string;
    function GetDefaultFileExt(Const MIMEType: string): string;
    procedure LoadFromStrings(AStrings: TIdStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    procedure SaveToStrings(AStrings: TIdStrings; const MimeSeparator: Char = '=');    {Do not Localize}
    constructor Create(Autofill: Boolean = True); reintroduce; virtual;
    destructor Destroy; override;
    //
    property  OnBuildCache: TNotifyEvent read FOnBuildCache write FOnBuildCache;
  end;

  TIdInterfacedObject = class (TInterfacedObject)
  public
    function _AddRef: Integer;
    function _Release: Integer;
  end;

  {$IFNDEF VCL6ORABOVE}
  PByte =^Byte;
  PWord =^Word;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
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

  //This is called whenever there is a failure to retreive the time zone information
  EIdFailedToRetreiveTimeZoneInfo = class(EIdException);

  //
  EIdExtensionAlreadyExists = class(EIdException);

// Procs - KEEP THESE ALPHABETICAL!!!!!

//  procedure BuildMIMETypeMap(dest: TIdStringList);
  // TODO: IdStrings have optimized SplitColumns* functions, can we remove it?
  function ABNFToText(const AText : String) : String;
  function BinStrToInt(const ABinary: String): Integer;
  function BreakApart(BaseString, BreakString: string; StringList: TIdStrings): TIdStrings;
  function CardinalToFourChar(ACardinal : Cardinal): string;
  Function CharToHex(const APrefix : String; const c : AnsiChar) : shortstring;
  procedure CommaSeparatedToStringList(AList: TIdStrings; const Value:string);
  function CompareDateTime(const ADateTime1, ADateTime2 : TDateTime) : Integer;
  {
  These are for handling binary values that are in Network Byte order.  They call
  ntohs, ntols, htons, and htons which are required by SNTP and FSP
  (probably some other protocols).  They aren't aren't in IdGlobals because that
  doesn't refer to IdStack so you can't use GStack there.
  }
  procedure CopyBytesToHostCardinal(const ASource : TIdBytes; const ASourceIndex: Integer;
    var VDest : Cardinal);
  procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer;
    var VDest : Word);
  procedure CopyTIdNetworkCardinal(const ASource: Cardinal;
    var VDest: TIdBytes; const ADestIndex: Integer);
  procedure CopyTIdNetworkWord(const ASource: Word;
    var VDest: TIdBytes; const ADestIndex: Integer);


  function CopyFileTo(const Source, Destination: string): Boolean;
  //Used by IMAP4Server
  function CreateEmptyFile(const APathName : String) : Boolean;

  function DateTimeToGmtOffSetStr(ADateTime: TDateTime; SubGMT: Boolean): string;
  function DateTimeGMTToHttpStr(const GMTValue: TDateTime) : String;
  Function DateTimeToInternetStr(const Value: TDateTime; const AIsGMT : Boolean = False) : String;
  function DomainName(const AHost: String): String;
  function EnsureMsgIDBrackets(const AMsgID: String): String;
  function FileSizeByName(const AFilename: string): Int64;

  //MLIST FTP DateTime conversion functions
  function FTPMLSToGMTDateTime(const ATimeStamp : String):TDateTime;
  function FTPMLSToLocalDateTime(const ATimeStamp : String):TDateTime;

  function FTPGMTDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
  function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;

  function GetClockValue : Int64;
  function GetMIMETypeFromFile(const AFile: String): string;
  function GetMIMEDefaultFileExt(const MIMEType: string): string;
  function GetGMTDateByName(const AFileName : String) : TDateTime;
  function GmtOffsetStrToDateTime(S: string): TDateTime;
  function GMTToLocalDateTime(S: string): TDateTime;
  function IdGetDefaultCharSet : TIdCharSet;
  function IntToBin(Value: cardinal): string;
  function IndyComputerName : String; // DotNet: see comments regarding GDotNetComputerName below
  //used by IdIMAP4Server
  function IndyCopyFile(AFromFileName, AToFileName : String; const AFailIfExists : Boolean) : Boolean;

  function IndyStrToBool(const AString: String): Boolean;
  function IsDomain(const S: String): Boolean;
  function IsFQDN(const S: String): Boolean;
  function IsBinary(const AChar : Char) : Boolean;
  function IsHex(const AChar : Char) : Boolean;
  function IsHostname(const S: String): Boolean;
  function IsLeadChar(ACh : Char):Boolean;
  function IsTopDomain(const AStr: string): Boolean;
  function IsValidIP(const S: String): Boolean;


  function Max(AValueOne,AValueTwo: Integer): Integer;
  function MakeTempFilename(const APath: String = ''): string;
  procedure MoveChars(const ASource:ShortString;ASourceStart:integer;var ADest:ShortString;ADestStart, ALen:integer);
  function OffsetFromUTC: TDateTime;
   function OrdFourByteToCardinal(AByte1, AByte2, AByte3, AByte4 : Byte): Cardinal;


  function ProcessPath(const ABasePath: String; const APath: String;
    const APathDelim: string = '/'): string;    {Do not Localize}
  function RightStr(const AStr: String; Len: Integer): String;
  {$IFNDEF DOTNET}
  // still to figure out how to reproduce these under .Net
  function ROL(AVal: LongWord; AShift: Byte): LongWord;
  function ROR(AVal: LongWord; AShift: Byte): LongWord;
  {$ENDIF}
  function RPos(const ASub, AIn: String; AStart: Integer = -1): Integer;
  function SetLocalTime(Value: TDateTime): boolean;

  function StartsWith(const ANSIStr, APattern : String) : Boolean;

  function StrToCard(const AStr: String): Cardinal;
  function StrInternetToDateTime(Value: string): TDateTime;
  function StrToDay(const ADay: string): Byte;
  function StrToMonth(const AMonth: string): Byte;
  function StrToWord(const Value: String): Word;
  function TimeZoneBias: TDateTime;
   //these are for FSP but may also help with MySQL
  function UnixDateTimeToDelphiDateTime(UnixDateTime: Cardinal): TDateTime;
  function DateTimeToUnix(ADateTime: TDateTime): Cardinal;

  function TwoCharToWord(AChar1, AChar2: Char):Word;
  function UpCaseFirst(const AStr: string): string;
  function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
  {$IFDEF MSWINDOWS}
  function Win32Type : TIdWin32Type;
  {$ENDIF}
  procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
  function WordToStr(const Value: Word): String;
  {$IFDEF DELPHI5}
  function DirectoryExists(const Directory: string): Boolean;
  {$ENDIF}
  
 
  //The following is for working on email headers and message part headers...
  function RemoveHeaderEntry(AHeader, AEntry: string): string;

var
  {$IFDEF LINUX}
  // For linux the user needs to set these variables to be accurate where used (mail, etc)
  GOffsetFromUTC: TDateTime = 0;
  GTimeZoneBias: TDateTime = 0;
  GIdDefaultCharSet : TIdCharSet = idcsISO_8859_1;
  {$ENDIF}

  {$IFDEF DOTNET}
  // This is available through System.Windows.Forms.SystemInformation.ComputerName
  // however we do not wish to link to Wystem.Windows.Forms. So the name of
  // the computer must be provided here in DotNet. The only known use for this
  // value is in the NTML and SSPI authentication code
  GDotNetComputerName : String;
  {$ENDIF}

  IndyFalseBoolStrs : array of String;
  IndyTrueBoolStrs : array of String;

//This is from: http://www.swissdelphicenter.ch/en/showcode.php?id=844
const
  // Sets UnixStartDate to TDateTime of 01/01/1970
  UNIXSTARTDATE : TDateTime = 25569.0;
   {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  TIME_BASEDATE = 2;
  
implementation

uses
  {$IFDEF LINUX}
  Libc,
  SysUtils,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  Registry,
  SysUtils,
  {$ENDIF}
  {$IFDEF DOTNET}
  System.IO,
  System.Text,
  {$ENDIF}
  IdAssignedNumbers,
  IdResourceStringsCore,
  IdResourceStringsProtocols,
  IdStack;

{$IFDEF MSWINDOWS}
var
  ATempPath: string;
{$ENDIF}

{$IFDEF DELPHI5}
function DirectoryExists(const Directory: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Directory));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;
{$ENDIF}

function StartsWith(const ANSIStr, APattern : String) : Boolean;
begin
  Result := (ANSIStr<>'') and (IndyPos(APattern, Sys.UpperCase(ANSIStr)) = 1)  {do not localize}
    //tentative fix for a problem with Korean indicated by "SungDong Kim" <infi@acrosoft.pe.kr>
   {$IFNDEF DOTNET}
   //note that in DotNET, everything is MBCS
    and (ByteType(ANSIStr, 1) = mbSingleByte)
   {$ENDIF}
    ;
    //just in case someone is doing a recursive listing and there's a dir with the name total
end;


function UnixDateTimeToDelphiDateTime(UnixDateTime: Cardinal): TDateTime;
begin
   Result := (UnixDateTime / 86400) + UnixStartDate;
{
From: http://homepages.borland.com/efg2lab/Library/UseNet/1999/0309b.txt
 }
   //  Result := EncodeDate(1970, 1, 1) + (UnixDateTime / 86400); {86400=No. of secs. per day}
end;

function DateTimeToUnix(ADateTime: TDateTime): Cardinal;
begin
  //example: DateTimeToUnix(now);
  Result := Round((ADateTime - UnixStartDate) * 86400);
end;

procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : Word);
begin
  VDest := IdGlobal.BytesToWord(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyBytesToHostCardinal(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : Cardinal);
begin
  VDest := IdGlobal.BytesToCardinal(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyTIdNetworkWord(const ASource: Word;
    var VDest: TIdBytes; const ADestIndex: Integer);
var LWord : Word;
begin
  LWord := GStack.HostToNetwork(ASource);
  CopyTIdWord(LWord,VDest,ADestIndex);
end;

procedure CopyTIdNetworkCardinal(const ASource: Cardinal;
    var VDest: TIdBytes; const ADestIndex: Integer);
var LCard : Cardinal;
begin
  LCard := GStack.HostToNetwork(ASource);
  CopyTIdCardinal(LCard,VDest,ADestIndex);
end;

{IndyCopyFile and  CreateEmptyFile are used by TIdIMAP4Server}

function IndyCopyFile(AFromFileName, AToFileName : String; const AFailIfExists : Boolean) : Boolean;
var
  LStream : TStream;
begin
  if Sys.FileExists(AToFileName) and AFailIfExists then begin
    Result := False;
  end else begin
    LStream := TReadFileExclusiveStream.Create(AFromFileName); try
      with TFileCreateStream.Create(AToFileName) do try
        CopyFrom(LStream, 0);
      finally Free; end;
    finally Sys.FreeAndNil(LStream); end;
    Result := True;
  end;
end;

function CreateEmptyFile(const APathName : String) : Boolean;
{$IFDEF DOTNET}
var LSTr : StreamWriter;
{$ELSE}
var LHandle : Integer;
{$ENDIF}
begin
  Result := False;
  {$IFDEF DOTNET}

  LStr := System.IO.&File.CreateText(APathName);

  if Assigned(LStr) then
  begin
    LStr.Close;
    Result := True;
  end;
  {$ELSE}
  LHandle := FileCreate(APathName);
  if LHandle <> -1 then
  begin
    FileClose(LHandle);
    Result := True;
  end;
  {$ENDIF}
end;

// BGO: TODO: Move somewhere else
procedure MoveChars(const ASource:ShortString;ASourceStart:integer;var ADest:ShortString;ADestStart, ALen:integer);
{$ifdef DotNet}
var a:integer;
{$endif}
begin
  {$ifdef DotNet}
  for a:=1 to ALen do begin
    ADest[ADestStart]:= ASource[ASourceStart];
    inc(ADestStart);
    inc(ASourceStart);
  end;
  {$else}
    System.Move(ASource[ASourceStart], ADest[ADestStart], ALen);
  {$endif}
end;

Function CharToHex(const APrefix : String; const c : AnsiChar) : shortstring;
begin
  SetLength(Result,2);
  Result[1] := IdHexDigits[byte(c) shr 4];
  Result[2] := IdHexDigits[byte(c) AND $0F];
  Result := APrefix + Result;
end;

function CardinalToFourChar(ACardinal : Cardinal): string;
begin
  Result := BytesToString(ToBytes(ACardinal));
end;

procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
begin
  //ByteArray[Index] := AWord div 256;
  //ByteArray[Index + 1] := AWord mod 256;
  ByteArray[Index + 1] := AWord div 256;
  ByteArray[Index] := AWord mod 256;
end;

function StrToWord(const Value: String): Word;
begin
  {$IFDEF DOTNET}
  if Length(Value)>1 then
  begin
    Result := TwoCharToWord(Value[1],Value[2]);
  end
  else
  begin
    Result := 0;
  end;
  {$ELSE}
  Result := Word(pointer(@Value[1])^);
  {$ENDIF}
end;

function WordToStr(const Value: Word): String;
begin
  {$IFDEF DOTNET}
  Result := BytesToString(ToBytes(Value));
  {$ELSE}
  SetLength(Result, SizeOf(Value));
  Move(Value, Result[1], SizeOf(Value));
  {$ENDIF}
end;

function OrdFourByteToCardinal(AByte1, AByte2, AByte3, AByte4 : Byte): Cardinal;
var
  LCardinal: TIdBytes;
begin
  SetLength(LCardinal,4);
  LCardinal[0] := AByte1;
  LCardinal[1] := AByte2;
  LCardinal[2] := AByte3;
  LCardinal[3] := AByte4;
  Result := BytesToCardinal( LCardinal);
end;

function TwoCharToWord(AChar1,AChar2: Char):Word;
//Since Replys are returned as Strings, we need a rountime to convert two
// characters which are a 2 byte U Int into a two byte unsigned integer
var
  LWord: TIdBytes;
begin
  SetLength(LWord,2);
  LWord[0] := Ord(AChar1);
  LWord[1] := Ord(AChar2);
  Result := BytesToWord(LWord);

//  Result := Word((Ord(AChar1) shl 8) and $FF00) or Word(Ord(AChar2) and $00FF);
end;


{This routine is based on JPM Open by J. Peter Mugaas.  Permission is granted
to use this with Indy under Indy's Licenses

Note that JPM Open is under a different Open Source license model.

It is available at http://www.wvnet.edu/~oma00215/jpm.html }

{$IFDEF MSWINDOWS}
type
  TNTEditionType = (workstation, server, advancedserver);

{These two are intended as internel functions called by our Win32 function.
These assume you checked for Windows NT, 2000, XP, or 2003}

{Returns the NTEditionType on Windows NT, 2000, XP, or 2003, and return workstation on non-nt platforms (95,98,me) }
function GetNTType : TNTEditionType;
var
  RtlGetNtProductType:function(ProductType:PULONG):BOOL;stdcall;
  Lh:THandle;
  LVersion:ULONG;
begin
  result:=workstation;
  lh:=LoadLibrary('ntdll.dll'); {do not localize}
  if Lh>0 then begin
    @RtlGetNtProductType:=GetProcAddress(lh,'RtlGetNtProductType'); {do not localize}
    if @RtlGetNtProductType<>nil then begin
      RtlGetNtProductType(@LVersion);
      case LVersion of
        1: result := workstation;
        2: result := server;
        3: result := advancedserver;
      end;
    end;
    FreeLibrary(lh);
  end;
end;

function GetOSServicePack : Integer;
var LNumber : String;
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
  for i := 1 to Length(LBuf) do
  begin
    if IsNumeric(LBuf[i]) then
    begin
      LNumber := LNumber+LBuf[i];
    end
    else
    begin
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
        server : Result := Windows2003Server;
        advancedserver : Result := Windows2003Server;
      else
        Result := WindowsXPPro; // Windows 2003 has no desktop version
      end;
    end
    else
    begin
      if Win32MinorVersion >= 1 then begin
        case GetNTType of
          server : Result := Windows2000Server; // hmmm, winXp has no server versions
          advancedserver : Result := Windows2000AdvancedServer; // hmmm, winXp has no server versions
        else
          Result := WindowsXPPro;
        end;
      end
      else begin
        case GetNTType of
          server : Result := Windows2000Server;
          advancedserver : Result := Windows2000AdvancedServer;
        else
          Result := Windows2000Pro;
        end;
      end;
    end;
  end
  else begin
    {is this WIndows 95, 98, Me, or NT 40}
    if Win32MajorVersion > 3 then begin
      if Win32Platform = VER_PLATFORM_WIN32_NT then begin
        //Bas requested that we specifically check for anything below SP6
        if (GetOSServicePack<6) then
        begin
          case GetNTType of
            server : Result := WindowsNT40PreSP6Server;
            advancedserver : Result := WindowsNT40PreSP6AdvancedServer;
          else
            Result := WindowsNT40PreSP6Workstation;
          end;
        end
        else
        begin
          case GetNTType of
        //WindowsNT40Workstation, WindowsNT40Server, WindowsNT40AdvancedServer
            server : Result := WindowsNT40Server;
            advancedserver : Result := WindowsNT40AdvancedServer;
          else
            Result := WindowsNT40Workstation;
          end;
        end;
      end
      else begin
        {mask off junk}
        Win32BuildNumber := Win32BuildNumber and $FFFF;
        if Win32MinorVersion >= 90 then begin
          Result := WindowsMe;
        end
        else begin
          if Win32MinorVersion >= 10 then begin
            {Windows 98}
            if Win32BuildNumber >= 2222 then begin
              Result := Windows98SE
            end
            else begin
              Result := Windows98;
            end;
          end
          else begin {Windows 95}
            if Win32BuildNumber >= 1000 then begin
              Result := Windows95OSR2
            end
            else begin
              Result := Windows95;
            end;
          end;
        end;
      end;//if VER_PLATFORM_WIN32_NT
    end
    else begin
      Result := Win32s;
    end;
  end;//if Win32MajorVersion >= 5
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
  Sys.DecodeDate(ADateTime1,LYear1,LMonth1,LDay1);
  Sys.DecodeDate(ADateTime2,LYear2,LMonth2,LDay2);
  // year
  Result := LYear1 - LYear2;
  if Result <> 0 then
  begin
    Exit;
  end;
  // month
  Result := LMonth1 - LMonth2;
  if Result <> 0 then
  begin
    Exit;
  end;
  // day
  Result := LDay1 - LDay2;
  if Result <> 0 then
  begin
    Exit;
  end;
  Sys.DecodeTime(ADateTime1,LHour1,LMin1,LSec1,LMSec1);
  Sys.DecodeTime(ADateTime2,LHour2,LMin2,LSec2,LMSec2);
  //hour
  Result := LHour1 - LHour2;
  if Result <> 0 then
  begin
    Exit;
  end;
  //minute
  Result := LMin1 - LMin2;
  if Result <> 0 then
  begin
    Exit;
  end;
  //second
  Result := LSec1 - LSec2;
  if Result <> 0 then
  begin
    Exit;
  end;
  //millasecond
  Result := LMSec1 - LMSec2;
end;

{This is an internal procedure so the StrInternetToDateTime and GMTToLocalDateTime can share common code}
function RawStrInternetToDateTime(var Value: string): TDateTime;
var
  i: Integer;
  Dt, Mo, Yr, Ho, Min, Sec: Word;
  sTime: String;
  ADelim: string;
  //flags for if AM/PM marker found
  LAM, LPM : Boolean;

  Procedure ParseDayOfMonth;
  begin
    Dt :=  Sys.StrToInt( Fetch(Value, ADelim), 1);
    Value := Sys.TrimLeft(Value);
  end;

  Procedure ParseMonth;
  begin
    Mo := StrToMonth( Fetch ( Value, ADelim )  );
    Value := Sys.TrimLeft(Value);
  end;
begin
  Result := 0.0;

  LAM:=false;
  LPM:=false;

  Value := Sys.Trim(Value);
  if Length(Value) = 0 then begin
    Exit;
  end;

  try
    {Day of Week}
    if StrToDay(Copy(Value, 1, 3)) > 0 then begin
      //workaround in case a space is missing after the initial column
      if (Copy(Value,4,1)=',') and (Copy(Value,5,1)<>' ') then
      begin
        Insert(' ',Value,5);
      end;
      Fetch(Value);
      Value := Sys.TrimLeft(Value);
    end;

    // Workaround for some buggy web servers which use '-' to separate the date parts.    {Do not Localize}
    if (IndyPos('-', Value) > 1) and (IndyPos('-', Value) < IndyPos(' ', Value)) then begin    {Do not Localize}
      ADelim := '-';    {Do not Localize}
    end
    else begin
      ADelim := ' ';    {Do not Localize}
    end;
    //workaround for improper dates such as 'Fri, Sep 7 2001'    {Do not Localize}
    //RFC 2822 states that they should be like 'Fri, 7 Sep 2001'    {Do not Localize}
    if (StrToMonth(Fetch(Value, ADelim,False)) > 0) then
    begin
      {Month}
      ParseMonth;
      {Day of Month}
      ParseDayOfMonth;
    end
    else
    begin
      {Day of Month}
      ParseDayOfMonth;
      {Month}
      ParseMonth;
    end;
    {Year}
    // There is sometrage date/time formats like
    // DayOfWeek Month DayOfMonth Time Year

    sTime := Fetch(Value);
    Yr := Sys.StrToInt(sTime, 1900);
    // Is sTime valid Integer
    if Yr = 1900 then begin
      Yr := Sys.StrToInt(Value, 1900);
      Value := sTime;
    end;
    if Yr < 80 then begin
      Inc(Yr, 2000);
    end else if Yr < 100 then begin
      Inc(Yr, 1900);
    end;

    Result := Sys.EncodeDate(Yr, Mo, Dt);
    // SG 26/9/00: Changed so that ANY time format is accepted
    if IndyPos('AM', Value)>0 then {do not localize}
    begin
      LAM := True;
      Value := Fetch(Value, 'AM');  {do not localize}
    end;
    if IndyPos('PM', Value)>0 then  {do not localize}
    begin
      LPM := True;
      Value := Fetch(Value, 'PM');  {do not localize}
    end;
    i := IndyPos(':', Value);       {do not localize}
    if i > 0 then begin

      // Copy time string up until next space (before GMT offset)
      sTime := fetch(Value, ' ');  {do not localize}
      {Hour}
      Ho  := Sys.StrToInt( Fetch ( sTime, ':'), 0);  {do not localize}
      {Minute}
      Min := Sys.StrToInt( Fetch ( sTime, ':'), 0);  {do not localize}
      {Second}
      Sec := Sys.StrToInt( Fetch ( sTime ), 0);
      {AM/PM part if preasent}
      Value := Sys.TrimLeft(Value);
      if LAM then
      begin
        if Ho = 12 then
        begin
          Ho := 0;
        end;
      end
      else
      begin
        if LPM then
        begin
          //in the 12 hour format, afternoon is 12:00PM followed by 1:00PM
          //while midnight is written as 12:00 AM
          //Not exactly technically correct but pritty accurate
          if Ho < 12 then
          begin
            Ho := Ho + 12;
          end;
        end;
      end;
      {The date and time stamp returned}
      Result := Result + Sys.EncodeTime(Ho, Min, Sec, 0);
    end;
    Value := Sys.TrimLeft(Value);
  except
    Result := 0.0;
  end;
end;

{$IFDEF MSWINDOWS}
  {$IFNDEF VCL5ORABOVE}
  function CreateTRegistry: TRegistry;
  begin
    Result := TRegistry.Create;
  end;
  {$ELSE}
  function CreateTRegistry: TRegistry;
  begin
    Result := TRegistry.Create(KEY_READ);
  end;
  {$ENDIF}
{$ENDIF}

function Max(AValueOne,AValueTwo: Integer): Integer;
begin
  if AValueOne < AValueTwo then
  begin
    Result := AValueTwo
  end //if AValueOne < AValueTwo then
  else
  begin
    Result := AValueOne;
  end; //else..if AValueOne < AValueTwo then
end;

{This should never be localized}
function DateTimeGMTToHttpStr(const GMTValue: TDateTime) : String;
// should adhere to RFC 2616

var
  wDay,
  wMonth,
  wYear: Word;
begin
  Sys.DecodeDate(GMTValue, wYear, wMonth, wDay);
  Result := Sys.Format('%s, %.2d %s %.4d %s %s',    {do not localize}
                   [wdays[Sys.DayOfWeek(GMTValue)], wDay, monthnames[wMonth],
                    wYear, Sys.FormatDateTime('HH":"NN":"SS', GMTValue), 'GMT']);  {do not localize}
end;

{This should never be localized}
function DateTimeToInternetStr(const Value: TDateTime; const AIsGMT : Boolean = False) : String;
var
  wDay,
  wMonth,
  wYear: Word;
begin
  Sys.DecodeDate(Value, wYear, wMonth, wDay);
  Result := Sys.Format('%s, %d %s %d %s %s',    {do not localize}
                   [ wdays[Sys.DayOfWeek(Value)], wDay, monthnames[wMonth],
                    wYear, Sys.FormatDateTime('HH":"NN":"SS', Value),  {do not localize}
                    DateTimeToGmtOffSetStr(OffsetFromUTC, AIsGMT)]);
end;

function StrInternetToDateTime(Value: string): TDateTime;
begin
  Result := RawStrInternetToDateTime(Value);
end;

function FTPMLSToGMTDateTime(const ATimeStamp : String):TDateTime;
var LYear, LMonth, LDay, LHour, LMin, LSec, LMSec : Integer;
    LBuffer : String;
begin
  Result := 0;
  LBuffer := ATimeStamp;
  if LBuffer <> '' then
  begin
  //  1234 56 78  90 12 34
  //  ---------- ---------
  //  1998 11 07  08 52 15
      LYear := Sys.StrToInt( Copy( LBuffer,1,4),0);
      LMonth := Sys.StrToInt(Copy(LBuffer,5,2),0);
      LDay := Sys.StrToInt(Copy(LBuffer,7,2),0);

      LHour := Sys.StrToInt(Copy(LBuffer,9,2),0);
      LMin := Sys.StrToInt(Copy(LBuffer,11,2),0);
      LSec := Sys.StrToInt(Copy(LBuffer,13,2),0);
      Fetch(LBuffer,'.');
      LMSec := Sys.StrToInt(LBuffer,0);
      Result := Sys.EncodeDate(LYear,LMonth,LDay);
      Result := Result + Sys.EncodeTime(LHour,LMin,LSec,LMSec);
  end;
end;

function FTPMLSToLocalDateTime(const ATimeStamp : String):TDateTime;
begin
  Result := 0;
  if ATimeStamp <> '' then
  begin
    Result := FTPMLSToGMTDateTime(ATimeStamp);
    // Apply local offset
    Result := Result + OffSetFromUTC;
  end;
end;

function FTPGMTDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
var LYear, LMonth, LDay,
    LHour, LMin, LSec, LMSec : Word;

begin
  Sys.DecodeDate(ATimeStamp,LYear,LMonth,LDay);
  Sys.DecodeTime(ATimeStamp,LHour,LMin,LSec,LMSec);
  Result := sys.Format('%4d%2d%2d%2d%2d%2d',[LYear,LMonth,LDay,LHour,LMin,LSec]);
  if AIncludeMSecs then
  begin
    if (LMSec <> 0) then
    begin
      Result := Result + Sys.Format('.%3d',[LMSec]);
    end;
  end;
  Result := Sys.StringReplace(Result,' ','0');
end;
{
Note that MS-DOS displays the time in the Local Time Zone - MLISx commands use
stamps based on GMT)
}
function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
begin
  Result := FTPGMTDateTimeToMLS(ATimeStamp - OffSetFromUTC,AIncludeMSecs);
end;


function BreakApart(BaseString, BreakString: string; StringList: TIdStrings): TIdStrings;
var
  EndOfCurrentString: integer;
begin
  repeat
    EndOfCurrentString := Pos(BreakString, BaseString);
    if (EndOfCurrentString = 0) then
    begin
      StringList.add(BaseString);
    end
    else
      StringList.add(Copy(BaseString, 1, EndOfCurrentString - 1));
    delete(BaseString, 1, EndOfCurrentString + Length(BreakString) - 1); //Copy(BaseString, EndOfCurrentString + length(BreakString), length(BaseString) - EndOfCurrentString);
  until EndOfCurrentString = 0;
  result := StringList;
end;

procedure CommaSeparatedToStringList(AList: TIdStrings; const Value:string);
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
  iLength := Length(Value) ;
  AList.Clear ;
  while (iPos <= iLength) do
  begin
    iStart := iPos ;
    iEnd := iStart ;
    while ( iPos <= iLength ) do
    begin
      if Value[iPos] = '"' then  {do not localize}
      begin
        inc(iQuote);
      end;
      if Value[iPos] = ',' then  {do not localize}
      begin
        if iQuote <> 1 then
        begin
          break;
        end;
      end;
      inc(iEnd);
      inc(iPos);
    end ;
    sTemp := Sys.Trim(Copy(Value, iStart, iEnd - iStart));
    if Length(sTemp) > 0 then
    begin
      AList.Add(sTemp);
    end;
    iPos := iEnd + 1 ;
    iQuote := 0 ;
  end ;
end;

{$IFDEF LINUX}
//LEave in for IdAttachment
function CopyFileTo(const Source, Destination: string): Boolean;
var
  SourceStream: TFileStream;
begin
  // -TODO: Change to use a Linux copy function
  // There is no native Linux copy function (at least "cp" doesn't use one
  // and I can't find one anywhere (Johannes Berg))
  Result := IndyCopyFile(Source, Destination, True);
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function CopyFileTo(const Source, Destination: string): Boolean;
begin
  Result := CopyFile(PChar(Source), PChar(Destination), true);
end;
{$ENDIF}
{$IFDEF DOTNET}
function CopyFileTo(const Source, Destination: string): Boolean;
begin
  System.IO.File.Copy(Source, Destination, true);
  result := true; // or you'll get an exception
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
function TempPath: string;
var
	i: integer;
begin
  SetLength(Result, MAX_PATH);
	i := GetTempPath(Length(Result), PChar(Result));
	SetLength(Result, i);
  IncludeTrailingSlash(Result);
end;
{$ENDIF}

function MakeTempFilename(const APath: String = ''): string;
var
  lPath: string;
  lExt: string;

begin
  lPath := APath;

  {$IFDEF LINUX}
  lExt := '';
  {$ELSE}
  lExt := '.tmp';
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  if lPath = '' then
  begin
    lPath := ATempPath;
  end;
  {$ENDIF}

  {$IFDEF DOTNET}
  if lPath = '' then
  begin
    lPath := System.IO.Path.GetTempPath;
  end;
  {$ENDIF}

  Result := GetUniqueFilename(lPath, 'Indy', lExt);
end;

function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
var
  LNamePart : Cardinal;
  LFQE : String;
  LFName: String;
begin
  {$IFDEF LINUX}

  {
    man tempnam

    BUGS

       The precise meaning of `appropriate' is undefined;  it  is
       unspecified  how  accessibility  of  a directory is deter­
       mined.  Never use this function. Use tmpfile(3) instead.

    Alternative is to use tmpfile, but this creates the temp file.

    Indy is using this to retain it's logic and use of TMPDIR and
    p_dir in the function.

    If the caller passes an invalid path, the results are unpredicatable.
  }

  if APath = '' then
  begin
    Result := tempnam(nil, 'Indy');
  end
  else
  begin
    Result := tempnam(PChar(APath), 'Indy');
  end;

  {$ELSE}

  LFQE := AExt;

  // period is optional in the extension... force it
  if AExt <> '' then
  begin
    if AExt[1] <> '.' then
    begin
      LFQE := '.' + AExt;
    end;
  end;

  // validate path and add path delimiter before file name prefix
  if APath <> '' then
  begin
    if not Sys.DirectoryExists(APath) then
    begin
      LFName := APrefix;
    end
    else
    begin
      // uses the Indy function... not the Borland one
      LFName := IncludeTrailingSlash(APath) + APrefix;
    end;
  end
  else
  begin
    LFName := APrefix;
  end;

  LNamePart := Ticks;
  repeat
    Result := LFName + Sys.IntToHex(LNamePart, 8) + LFQE;

    if not Sys.FileExists(Result) then
    begin
      break;
    end
    else
    begin
      Inc(LNamePart);
    end;
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
  result := 0;
  LTokenLen := Length(ASub);
  // Get starting position
  if AStart = -1 then begin
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
      result := i;
      break;
    end;
  end;
end;

// OS-independant version
function FileSizeByName(const AFilename: string): Int64;
//Leave in for HTTP Server
{$IFDEF DOTNET}
var LF : System.IO.FileInfo;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LF := FileInfo.Create(AFileName);
  Result := LF.Length;
  {$ELSE}
  with TFileStream.Create(AFilename, fmOpenRead or fmShareDenyWrite) do
  try
    Result := Size;
  finally Free; end;
  {$ENDIF}
end;

function GetGMTDateByName(const AFileName : String) : TDateTime;
 {$IFDEF WIN32}
var LRec : TWin32FindData;
  LHandle : THandle;
   LTime : Integer;
 {$ENDIF}
 {$IFDEF LINUX}
var LRec : TStatBuf;
  LTime : Integer;
  LU : TUnixTime;
 {$ENDIF}
begin
  Result := -1;
  {$IFDEF DOTNET}
  if System.IO.File.Exists(AFileName) then
  begin
    Result := System.IO.File.GetLastWriteTimeUtc(AFileName).ToOADate;
  end;
  {$ENDIF}
  {$IFDEF WIN32}
  LHandle := FindFirstFile(PChar(AFileName), LRec);
  if LHandle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(LHandle);
    if (LRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
       FileTimeToDosDateTime(LRec.ftLastWriteTime, LongRec(LTime).Hi, LongRec(LTime).Lo);
       Result := FileDateToDateTime(LTime);
    end;
  end;
  {$ENDIF}
  {$IFDEF LINUX}
  if stat(PChar(AFileName), LRec) = 0 then
  begin
    LTime := LRec.st_mtime;
    gmtime_r(@LTime, LU);
    Result := EncodeDate(LU.tm_year + 1900, LU.tm_mon + 1, LU.tm_mday) +
              EncodeTime(LU.tm_hour, LU.tm_min, LU.tm_sec, 0);
  end;
  {$ENDIF}
end;

function RightStr(const AStr: String; Len: Integer): String;
var
  LStrLen : Integer;
begin
  LStrLen := Length (AStr);
  if (Len > LStrLen) or (Len < 0) then begin
    Result := AStr;
  end  //f ( Len > Length ( st ) ) or ( Len < 0 ) then
  else begin
    //+1 is necessary for the Index because it is one based
    Result := Copy(AStr, LStrLen - Len+1, Len);
  end; //else ... f ( Len > Length ( st ) ) or ( Len < 0 ) then
end;

{$IFDEF LINUX}
function OffsetFromUTC: TDateTime;
begin
  //TODO: Fix OffsetFromUTC for Linux to be automatic from OS
  Result := GOffsetFromUTC;
end;
{$ENDIF}
{$IFDEF DOTNET}
function OffsetFromUTC: TDateTime;
begin
  Result := System.Timezone.CurrentTimezone.GetUTCOffset(Sys.now).TotalDays;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function OffsetFromUTC: TDateTime;
var
  iBias: Integer;
  tmez: TTimeZoneInformation;
begin
  Case GetTimeZoneInformation(tmez) of
    TIME_ZONE_ID_INVALID:
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
    TIME_ZONE_ID_UNKNOWN  :
       iBias := tmez.Bias;
    TIME_ZONE_ID_DAYLIGHT :
      iBias := tmez.Bias + tmez.DaylightBias;
    TIME_ZONE_ID_STANDARD :
      iBias := tmez.Bias + tmez.StandardBias;
    else
      raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
  end;
  {We use ABS because EncodeTime will only accept positve values}
  Result := EncodeTime(Abs(iBias) div 60, Abs(iBias) mod 60, 0, 0);
  {The GetTimeZone function returns values oriented towards convertin
   a GMT time into a local time.  We wish to do the do the opposit by returning
   the difference between the local time and GMT.  So I just make a positive
   value negative and leave a negative value as positive}
  if iBias > 0 then begin
    Result := 0 - Result;
  end;
end;
{$ENDIF}

function StrToCard(const AStr: String): Cardinal;
begin
  Result := Sys.StrToInt64Def(Sys.Trim(AStr),0);
end;

{$IFDEF LINUX}
function TimeZoneBias: TDateTime;
begin
  //TODO: Fix TimeZoneBias for Linux to be automatic
  Result := GTimeZoneBias;
end;
{$ENDIF}
{$IFDEF DOTNET}
function TimeZoneBias: TDateTime;
begin
  Result := -OffsetFromUTC;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function TimeZoneBias: TDateTime;
var
  ATimeZone: TTimeZoneInformation;
begin
  case GetTimeZoneInformation(ATimeZone) of
    TIME_ZONE_ID_DAYLIGHT:
      Result := ATimeZone.Bias + ATimeZone.DaylightBias;
    TIME_ZONE_ID_STANDARD:
      Result := ATimeZone.Bias + ATimeZone.StandardBias;
    TIME_ZONE_ID_UNKNOWN:
      Result := ATimeZone.Bias;
    else
      raise EIdException.Create(SysErrorMessage(GetLastError));
  end;
  Result := Result / 1440;
end;
{$ENDIF}

function IndyStrToBool(const AString : String) : Boolean;
var
  LCount : Integer;
begin
  // First check against each of the elements of the FalseBoolStrs
  for LCount := Low(IndyFalseBoolStrs) to High(IndyFalseBoolStrs) do
  begin
    if TextIsSame(AString, IndyFalseBoolStrs[LCount]) then
    begin
      result := false;
      exit;
    end;
  end;
  // Second check against each of the elements of the TrueBoolStrs
  for LCount := Low(IndyTrueBoolStrs) to High(IndyTrueBoolStrs) do
  begin
    if TextIsSame(AString, IndyTrueBoolStrs[LCount]) then
    begin
      result := true;
      exit;
    end;
  end;
  // None of the strings match, so convert to numeric (allowing an
  // EConvertException to be thrown if not) and test against zero.
  // If zero, return false, otherwise return true.
  LCount := Sys.StrToInt(AString);
  if LCount = 0 then
  begin
    result := false;
  end else
  begin
    result := true;
  end;
end;

{$IFDEF LINUX}
function SetLocalTime(Value: TDateTime): boolean;
begin
  //TODO: Implement SetTime for Linux. This call is not critical.
  result := False;
end;
{$ENDIF}
{$IFDEF DOTNET}
function SetLocalTime(Value: TDateTime): boolean;
begin
  //TODO: Figure out how to do this
  result := False;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function SetLocalTime(Value: TDateTime): boolean;
{I admit that this routine is a little more complicated than the one
in Indy 8.0.  However, this routine does support Windows NT privillages
meaning it will work if you have administrative rights under that OS

Original author Kerry G. Neighbour with modifications and testing
from J. Peter Mugaas}
var
   dSysTime: TSystemTime;
   buffer: DWord;
   tkp, tpko: TTokenPrivileges;
   hToken: THandle;
begin
  Result := False;
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    if not Windows.OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
      hToken) then
    begin
      exit;
    end;
    Windows.LookupPrivilegeValue(nil, 'SE_SYSTEMTIME_NAME', tkp.Privileges[0].Luid);    {Do not Localize}
    tkp.PrivilegeCount := 1;
    tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    if not Windows.AdjustTokenPrivileges(hToken, FALSE, tkp, sizeof(tkp), tpko, buffer) then
    begin
      exit;
    end;
  end;
  DateTimeToSystemTime(Value, dSysTime);
  Result := Windows.SetLocalTime(dSysTime);
  {Undo the Process Privillage change we had done for the set time
  and close the handle that was allocated}
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Windows.AdjustTokenPrivileges(hToken, FALSE,tpko, sizeOf(tpko), tkp, Buffer);
    Windows.CloseHandle(hToken);
  end;
end;
{$ENDIF}



function StrToDay(const ADay: string): Byte;
begin
  Result := Succ(PosInStrArray(Sys.Uppercase(ADay),
    ['SUN','MON','TUE','WED','THU','FRI','SAT']));   {do not localize}
end;

function StrToMonth(const AMonth: string): Byte;
begin
  Result := Succ(PosInStrArray(Sys.Uppercase(AMonth),
    ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC']));   {do not localize}
end;

function UpCaseFirst(const AStr: string): string;
begin
  Result := Sys.LowerCase(Sys.TrimLeft(AStr));
  if Result <> '' then begin   {Do not Localize}
    Result[1] := UpCase(Result[1]);
  end;
end;

function DateTimeToGmtOffSetStr(ADateTime: TDateTime; SubGMT: Boolean): string;
var
  AHour, AMin, ASec, AMSec: Word;
begin
  if (ADateTime = 0.0) and SubGMT then
  begin
    Result := 'GMT'; {do not localize}
    Exit;
  end;
  Sys.DecodeTime(ADateTime, AHour, AMin, ASec, AMSec);
  Result := Sys.Format(' %0.2d%0.2d', [AHour, AMin]); {do not localize}
  if ADateTime < 0.0 then
  begin
    Result[1] := '-'; {do not localize}
  end
  else
  begin
    Result[1] := '+';  {do not localize}
  end;
end;

const
  HexNumbers = '01234567890ABCDEF';  {Do not Localize}
  BinNumbers = '01'; {Do not localize}

function IsHex(const AChar : Char) : Boolean;
begin
  Result := (IndyPos(Sys.UpperCase(AChar),HexNumbers)>0);
end;

function IsBinary(const AChar : Char) : Boolean;
begin
  Result := (IndyPos(Sys.UpperCase(AChar),BinNumbers)>0);
end;

function BinStrToInt(const ABinary: String): Integer;
var
  I: Integer;
//From: http://www.experts-exchange.com/Programming/Programming_Languages/Delphi/Q_20622755.html
begin
  Result := 0;
  for I := 1 to Length(ABinary) do
  begin
    Result := Result shl 1 or (Byte(ABinary[I]) and 1);
  end;
end;

function ABNFToText(const AText : String) : String;
type TIdRuleMode = (data,rule,decimal,hex, binary);
var i : Integer;
    LR : TIdRuleMode;
    LNum : String;
begin
  LR :=data;
  Result := '';
  for i := 1 to Length(AText) do
  begin
    case LR of
      data :
        if (AText[i]='%') and (i < Length(AText)) then
        begin
          LR := rule;
        end
        else
        begin
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
        If IsNumeric(AText[i]) then
        begin
          LNum := LNum + AText[i];
          if Sys.StrToInt(LNum,0)>$FF then
          begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(Sys.StrToInt(LNum,0));
            LR := Data;
            Result := Result + AText[i];
          end;
        end
        else
        begin
          Result := Result + Char(Sys.StrToInt(LNum,0));
          LNum := '';
          if AText[i]<>'.' then
          begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
      hex :
        If IsHex(AText[i]) and (Length(LNum)<2) then
        begin
          LNum := LNum + AText[i];
          if (Sys.StrToInt('$'+LNum,0)>$FF)  then
          begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(Sys.StrToInt(LNum,0));
            LR := Data;
            Result := Result + AText[i];
          end;
        end
        else
        begin
          Result := Result + Char(Sys.StrToInt('$'+LNum,0));
          LNum := '';
          if AText[i]<>'.' then
          begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
    binary :
        If IsBinary(AText[i]) and (Length(LNum)<8) then
        begin
          LNum := LNum + AText[i];
          if (BinStrToInt(LNum)>$FF)  then
          begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(BinStrToInt(LNum));
            LR := Data;
            Result := Result + AText[i];
          end;
        end
        else
        begin
          Result := Result + Char(Sys.StrToInt('$'+LNum,0));
          LNum := '';
          if AText[i]<>'.' then
          begin
            LR := Data;
            Result := Result + AText[i];
          end;
        end;
    end;
  end;
end;

// Currently this function is not used
(*
procedure BuildMIMETypeMap(dest: TIdStringList);
{$IFDEF LINUX}
begin
  // TODO: implement BuildMIMETypeMap in Linux
  raise EIdException.Create('BuildMIMETypeMap not implemented yet.');    {Do not Localize}
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
  Reg: TRegistry;
  slSubKeys: TIdStringList;
  i: integer;
begin
  Reg := CreateTRegistry; try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKeyreadOnly('\MIME\Database\Content Type'); {do not localize}
    slSubKeys := TIdStringList.Create;
    try
      Reg.GetKeyNames(slSubKeys);
      reg.Closekey;
      for i := 0 to slSubKeys.Count - 1 do
      begin
        Reg.OpenKeyreadOnly('\MIME\Database\Content Type\' + slSubKeys[i]);  {do not localize}
        dest.Append(LowerCase(reg.ReadString('Extension')) + '=' + slSubKeys[i]); {do not localize}
        Reg.CloseKey;
      end;
    finally
      slSubKeys.Free;
    end;
  finally
    reg.free;
  end;
end;
{$ENDIF}
*)

function GetMIMETypeFromFile(const AFile: String): string;
var
  MIMEMap: TIdMIMETable;
begin
  MIMEMap := TIdMimeTable.Create(true);
  try
    Result := MIMEMap.GetFileMIMEType(AFile);
  finally
    MIMEMap.Free;
  end;
end;

function GetMIMEDefaultFileExt(const MIMEType: string): string;
var
  MIMEMap: TIdMIMETable;
begin
  MIMEMap := TIdMimeTable.Create(true);
  try
    Result := MIMEMap.GetDefaultFileExt(MIMEType);
  finally
    MIMEMap.Free;
  end;
end;

function GmtOffsetStrToDateTime(S: string): TDateTime;
begin
  Result := 0.0;
  S := Copy(Sys.Trim(s), 1, 5);
  if Length(S) > 0 then
  begin
    if (s[1] = '-') or (s[1] = '+') then   {do not localize}
    begin
      try
        Result := Sys.EncodeTime(Sys.StrToInt(Copy(s, 2, 2)), Sys.StrToInt(Copy(s, 4, 2)), 0, 0);
        if s[1] = '-' then  {do not localize}
        begin
          Result := -Result;
        end;
      except
        Result := 0.0;
      end;
    end;
  end;
end;

function GMTToLocalDateTime(S: string): TDateTime;
var  {-Always returns date/time relative to GMT!!  -Replaces StrInternetToDateTime}
  DateTimeOffset: TDateTime;
begin
  if s = '' then
    begin
    // just hardcode to 0 - don't need all the work below and the spurious timezone adjustment. GDG 20-Mar 2003
    result := 0;
    end
  else
    begin
    Result := RawStrInternetToDateTime(S);
    if Length(S) < 5 then begin
      DateTimeOffset := 0.0
    end else begin
      DateTimeOffset := GmtOffsetStrToDateTime(S);
    end;
    {-Apply GMT offset here}
    if DateTimeOffset < 0.0 then begin
      Result := Result + Abs(DateTimeOffset);
    end else begin
      Result := Result - DateTimeOffset;
    end;
    // Apply local offset
    Result := Result + OffSetFromUTC;
    end;
end;

{ Takes a cardinal (DWORD)  value and returns the string representation of it's binary value}    {Do not Localize}
function IntToBin(Value: cardinal): string;
var
  i: Integer;
begin
  SetLength(result, 32);
  for i := 1 to 32 do
  begin
    if ((Value shl (i-1)) shr 31) = 0 then
      result[i] := '0'  {do not localize}
    else
      result[i] := '1'; {do not localize}
  end;
end;

{ TIdMimeTable }

{$IFDEF LINUX}
procedure LoadMIME(const AFileName : String; AMIMEList : TIdStringList);
var
  KeyList: TIdStringList;
  i, p: Integer;
  s, LMimeType, LExtension: String;
begin
  If FileExists(AFileName) Then  {Do not localize}
  Begin
    // build list from /etc/mime.types style list file
    // I'm lazy so I'm using a stringlist to load the file, ideally
    // this should not be done, reading the file line by line is better
    // I think - at least in terms of storage
    KeyList := TIdStringList.Create;
    try
      KeyList.LoadFromFile(AFileName); {Do not localize}
      for i := 0 to KeyList.Count -1 do begin
        s := KeyList[i];
        p := IndyPos('#', s); {Do not localize}
        if (p>0) then
        begin
          setlength(s, p-1);
        end;
        if s <> '' then
        begin {Do not localize}
          s := Trim(s);
          LMimeType := Fetch(s);
          if LMimeType <> '' then
          begin {Do not localize}
             while (s<>'') do
             begin {Do not localize}
               LExtension := Fetch(s);
               if LExtension <> '' then
               try {Do not localize}
                 AMIMEList.Values['.'+LExtension]:= LMimeType; {Do not localize}
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

procedure FillMimeTable(AMIMEList : TIdStringList);
{$IFDEF MSWINDOWS}
var
  reg: TRegistry;
  KeyList: TIdStringList;
  i: Integer;
  s: String;
{$ENDIF}
begin
  { Protect if someone is allready filled (custom MomeConst) }
  if not Assigned(AMIMEList) then
  begin
    Exit;
  end;
  if AMIMEList.Count > 0 then
  begin
    Exit;
  end;

  with AMIMEList do begin
    {NOTE:  All of these strings should never be translated
    because they are protocol specific and are important for some
    web-browsers}

    { Audio }
    Add('.aiff=audio/x-aiff');    {Do not Localize}
    Add('.au=audio/basic');    {Do not Localize}
    Add('.mid=midi/mid');    {Do not Localize}
    Add('.mp3=audio/x-mpg');    {Do not Localize}
    Add('.m3u=audio/x-mpegurl');    {Do not Localize}
    Add('.qcp=audio/vnd.qcelp');    {Do not Localize}
    Add('.ra=audio/x-realaudio');    {Do not Localize}
    Add('.wav=audio/x-wav');    {Do not Localize}
    Add('.gsm=audio/x-gsm');    {Do not Localize}
    Add('.wax=audio/x-ms-wax');    {Do not Localize}
    Add('.wma=audio/x-ms-wma');    {Do not Localize}
    Add('.ram=audio/x-pn-realaudio');    {Do not Localize}
    Add('.mjf=audio/x-vnd.AudioExplosion.MjuiceMediaFile');    {Do not Localize}


    { Image }
    Add('.bmp=image/bmp');    {Do not Localize}
    Add('.gif=image/gif');    {Do not Localize}
    Add('.jpg=image/jpeg');    {Do not Localize}
    Add('.jpeg=image/jpeg');    {Do not Localize}
    Add('.jpe=image/jpeg');    {Do not Localize}
    Add('.pict=image/x-pict');    {Do not Localize}
    Add('.png=image/x-png');    {Do not Localize}
    Add('.svg=image/svg-xml');    {Do not Localize}
    Add('.tif=image/x-tiff');    {Do not Localize}
    Add('.rf=image/vnd.rn-realflash');    {Do not Localize}
    Add('.rp=image/vnd.rn-realpix');    {Do not Localize}
    Add('.ico=image/x-icon');    {Do not Localize}
    Add('.art=image/x-jg');    {Do not Localize}
    Add('.pntg=image/x-macpaint');    {Do not Localize}
    Add('.qtif=image/x-quicktime');    {Do not Localize}
    Add('.sgi=image/x-sgi');    {Do not Localize}
    Add('.targa=image/x-targa');    {Do not Localize}
    Add('.xbm=image/xbm');    {Do not Localize}
    Add('.psd=image/x-psd');    {Do not Localize}
    Add('.pnm=image/x-portable-anymap');    {Do not Localize}
    Add('.pbm=image/x-portable-bitmap');    {Do not Localize}
    Add('.pgm=image/x-portable-graymap');    {Do not Localize}
    Add('.ppm=image/x-portable-pixmap');    {Do not Localize}
    Add('.rgb=image/x-rgb');    {Do not Localize}
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


    { video/ }
    Add('.avi=video/x-msvideo');    {Do not Localize}
    Add('.flc=video/flc');    {Do not Localize}
    Add('.mpeg=video/x-mpeg2a');    {Do not Localize}
    Add('.mov=video/quicktime');    {Do not Localize}
    Add('.rv=video/vnd.rn-realvideo');    {Do not Localize}
    Add('.ivf=video/x-ivf');    {Do not Localize}
    Add('.wm=video/x-ms-wm');    {Do not Localize}
    Add('.wmp=video/x-ms-wmp');    {Do not Localize}
    Add('.wmv=video/x-ms-wmv');    {Do not Localize}
    Add('.wmx=video/x-ms-wmx');    {Do not Localize}
    Add('.wvx=video/x-ms-wvx');    {Do not Localize}
    Add('.rms=video/vnd.rn-realvideo-secure');    {Do not Localize}
    Add('.asx=video/x-ms-asf-plugin');    {Do not Localize}
    Add('.movie=video/x-sgi-movie');    {Do not Localize}

    { application/ }
    Add('.wmd=application/x-ms-wmd');    {Do not Localize}
    Add('.wms=application/x-ms-wms');    {Do not Localize}
    Add('.wmz=application/x-ms-wmz');    {Do not Localize}
    Add('.p12=application/x-pkcs12');    {Do not Localize}
    Add('.p7b=application/x-pkcs7-certificates');    {Do not Localize}
    Add('.p7r=application/x-pkcs7-certreqresp');    {Do not Localize}
    Add('.qtl=application/x-quicktimeplayer');    {Do not Localize}
    Add('.rtsp=application/x-rtsp');    {Do not Localize}
    Add('.swf=application/x-shockwave-flash');    {Do not Localize}
    Add('.sit=application/x-stuffit');    {Do not Localize}
    Add('.tar=application/x-tar');    {Do not Localize}
    Add('.man=application/x-troff-man');    {Do not Localize}
    Add('.urls=application/x-url-list');    {Do not Localize}
    Add('.zip=application/x-zip-compressed');    {Do not Localize}
    Add('.cdf=application/x-cdf');    {Do not Localize}
    Add('.fml=application/x-file-mirror-list');    {Do not Localize}
    Add('.fif=application/fractals');    {Do not Localize}
    Add('.spl=application/futuresplash');    {Do not Localize}
    Add('.hta=application/hta');    {Do not Localize}
    Add('.hqx=application/mac-binhex40');    {Do not Localize}
    Add('.doc=application/msword');    {Do not Localize}
    Add('.pdf=application/pdf');    {Do not Localize}
    Add('.p10=application/pkcs10');    {Do not Localize}
    Add('.p7m=application/pkcs7-mime');    {Do not Localize}
    Add('.p7s=application/pkcs7-signature');    {Do not Localize}
    Add('.cer=application/x-x509-ca-cert');    {Do not Localize}
    Add('.crl=application/pkix-crl');    {Do not Localize}
    Add('.ps=application/postscript');    {Do not Localize}
    Add('.sdp=application/x-sdp');    {Do not Localize}
    Add('.setpay=application/set-payment-initiation');    {Do not Localize}
    Add('.setreg=application/set-registration-initiation');    {Do not Localize}
    Add('.smil=application/smil');    {Do not Localize}
    Add('.ssm=application/streamingmedia');    {Do not Localize}
    Add('.xfdf=application/vnd.adobe.xfdf');    {Do not Localize}
    Add('.fdf=application/vnd.fdf');    {Do not Localize}
    Add('.xls=application/x-msexcel');    {Do not Localize}
    Add('.sst=application/vnd.ms-pki.certstore');    {Do not Localize}
    Add('.pko=application/vnd.ms-pki.pko');    {Do not Localize}
    Add('.cat=application/vnd.ms-pki.seccat');    {Do not Localize}
    Add('.stl=application/vnd.ms-pki.stl');    {Do not Localize}
    Add('.rmf=application/vnd.rmf');    {Do not Localize}
    Add('.rm=application/vnd.rn-realmedia');    {Do not Localize}
    Add('.rnx=application/vnd.rn-realplayer');    {Do not Localize}
    Add('.rjs=application/vnd.rn-realsystem-rjs');    {Do not Localize}
    Add('.rmx=application/vnd.rn-realsystem-rmx');    {Do not Localize}
    Add('.rmp=application/vnd.rn-rn_music_package');    {Do not Localize}
    Add('.rsml=application/vnd.rn-rsml');    {Do not Localize}
    Add('.vsl=application/x-cnet-vsl');    {Do not Localize}
    Add('.z=application/x-compress');    {Do not Localize}
    Add('.tgz=application/x-compressed');    {Do not Localize}
    Add('.dir=application/x-director');    {Do not Localize}
    Add('.gz=application/x-gzip');    {Do not Localize}
    Add('.uin=application/x-icq');    {Do not Localize}
    Add('.hpf=application/x-icq-hpf');    {Do not Localize}
    Add('.pnq=application/x-icq-pnq');    {Do not Localize}
    Add('.scm=application/x-icq-scm');    {Do not Localize}
    Add('.ins=application/x-internet-signup');    {Do not Localize}
    Add('.iii=application/x-iphone');    {Do not Localize}
    Add('.latex=application/x-latex');    {Do not Localize}
    Add('.nix=application/x-mix-transfer');    {Do not Localize}

    { WAP }
    Add('.wbmp=image/vnd.wap.wbmp');    {Do not Localize}
    Add('.wml=text/vnd.wap.wml');    {Do not Localize}
    Add('.wmlc=application/vnd.wap.wmlc');    {Do not Localize}
    Add('.wmls=text/vnd.wap.wmlscript');    {Do not Localize}
    Add('.wmlsc=application/vnd.wap.wmlscriptc');    {Do not Localize}

    { WEB }
    Add('.css=text/css');    {Do not Localize}
    Add('.htm=text/html');    {Do not Localize}
    Add('.html=text/html');    {Do not Localize}
    Add('.shtml=server-parsed-html');    {Do not Localize}
    Add('.xml=text/xml');    {Do not Localize}
    Add('.sgm=text/sgml');    {Do not Localize}
    Add('.sgml=text/sgml');    {Do not Localize}
  end;
  {$IFDEF MSWINDOWS}
  // Build the file type/MIME type map
  Reg := CreateTRegistry; try
    KeyList := TIdStringList.create;
    try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if Reg.OpenKeyReadOnly('\') then  {do not localize}
      begin
        Reg.GetKeyNames(KeyList);
      //  reg.Closekey;
      end;
      // get a list of registered extentions
      for i := 0 to KeyList.Count - 1 do
      begin
        if Copy(KeyList[i], 1, 1) = '.' then   {do not localize}
        begin
          if reg.OpenKeyReadOnly(KeyList[i]) then
          begin
            s := Reg.ReadString('Content Type');  {do not localize}
{          if Reg.ValueExists('Content Type') then  {do not localize}
{          begin
            FFileExt.Values[KeyList[i]] := Reg.ReadString('Content Type');  {do not localize}
{          end;   }

{ for some odd reason, the code above was triggering a memory leak inside
the TIdHTTPServer demo program even though simply testing the MIME Table
alone did not cause a memory leak.  That is what I found in my leak testing..
Got me <shrug>.

}
            if Length(s) > 0 then
            begin
              AMIMEList.Values[KeyList[i]] := s;
            end;
//            reg.CloseKey;
          end;
        end;
      end;
      if Reg.OpenKeyreadOnly('\MIME\Database\Content Type') then {do not localize}
      begin
        // get a list of registered MIME types
        KeyList.Clear;

        Reg.GetKeyNames(KeyList);
  //      reg.Closekey;
        for i := 0 to KeyList.Count - 1 do
        begin
          if Reg.OpenKeyreadOnly('\MIME\Database\Content Type\' + KeyList[i]) then {do not localize}
          begin
            s := reg.ReadString('Extension');  {do not localize}
            AMIMEList.Values[s] := KeyList[i];
    //        Reg.CloseKey;
          end;
        end;
      end;
    finally
      KeyList.Free;
    end;
  finally
    reg.free;
  end;
{$ENDIF}
{$IFDEF LINUX}
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

procedure TIdMimeTable.AddMimeType(const Ext, MIMEType: string);
var
  LExt,
  LMIMEType: string;
begin
  { Check and fix extension }
  LExt := IndyLowerCase(Ext);
  if Length(LExt) = 0 then
  begin
    raise EIdException.Create(RSMIMEExtensionEmpty);
  end;
  { Check and fix MIMEType }
  LMIMEType := IndyLowerCase(MIMEType);
  if Length(LMIMEType) = 0 then begin
    raise EIdException.Create(RSMIMEMIMETypeEmpty);
  end;
  if LExt[1] <> '.' then     {do not localize}
  begin
    LExt := '.' + LExt;      {do not localize}
  end;
  { Check list }
  if FFileExt.IndexOf(LExt) = -1 then
  begin
    FFileExt.Add(LExt);
    FMIMEList.Add(LMIMEType);
  end else begin
    raise EIdException.Create(RSMIMEMIMEExtAlreadyExists);
  end;
end;

procedure TIdMimeTable.BuildCache;
begin
  if Assigned(FOnBuildCache) then
  begin
    FOnBuildCache(Self);
  end
  else
  begin
    if FFileExt.Count = 0 then
    begin
      BuildDefaultCache;
    end;
  end;
end;

procedure TIdMimeTable.BuildDefaultCache;
{This is just to provide some default values only}
var LKeys : TIdStringList;

begin
  LKeys := TIdStringList.Create;
  try
    FillMIMETable(LKeys);
    LoadFromStrings(LKeys);
  finally
    Sys.FreeAndNil(LKeys);
  end;
end;

constructor TIdMimeTable.Create(Autofill: boolean);
begin
  inherited Create;
  FFileExt := TIdStringList.Create;
  FMIMEList := TIdStringList.Create;
  if Autofill then begin
    BuildCache;
  end;
end;

destructor TIdMimeTable.Destroy;
begin
  Sys.FreeAndNil(FMIMEList);
  Sys.FreeAndNil(FFileExt);
  inherited Destroy;
end;

function TIdMimeTable.GetDefaultFileExt(const MIMEType: string): String;
var
  Index : Integer;
  LMimeType: string;
begin
  Result := '';    {Do not Localize}
  LMimeType := IndyLowerCase(MIMEType);
  Index := FMIMEList.IndexOf(LMimeType);
  if Index <> -1 then
  begin
    Result := FFileExt[Index];
  end
  else
  begin
    BuildCache;
    Index := FMIMEList.IndexOf(LMIMEType);
    if Index <> -1 then
      Result := FFileExt[Index];
  end;
end;

function TIdMimeTable.GetFileMIMEType(const AFileName: string): string;
var
  Index : Integer;
  LExt: string;
begin
  LExt := IndyLowerCase(Sys.ExtractFileExt(AFileName));
  Index := FFileExt.IndexOf(LExt);
  if Index <> -1 then
  begin
    Result := FMIMEList[Index];
  end
  else
  begin
    BuildCache;
    Index := FFileExt.IndexOf(LExt);
    if Index = -1 then
    begin
      Result := 'application/octet-stream' {do not localize}
    end
    else
    begin
      Result := FMIMEList[Index];
    end;
  end;  { if .. else }
end;

procedure TIdMimeTable.LoadFromStrings(AStrings: TIdStrings;const MimeSeparator: Char = '=');    {Do not Localize}
var
  I   : Integer;
  Ext : string;
begin
  FFileExt.Clear;
  FMIMEList.Clear;
  for I := 0 to AStrings.Count - 1 do
  begin
    Ext := IndyLowerCase(Copy(AStrings[I], 1, Pos(MimeSeparator, AStrings[I]) - 1));
    if Length(Ext) > 0 then
      if FFileExt.IndexOf(Ext) = -1 then
        AddMimeType(Ext, Copy(AStrings[I], Pos(MimeSeparator, AStrings[I]) + 1, Length(AStrings[I])));
  end;  { For I := }
end;



procedure TIdMimeTable.SaveToStrings(AStrings: TIdStrings;
  const MimeSeparator: Char);
var
  I : Integer;
begin
  AStrings.Clear;
  for I := 0 to FFileExt.Count - 1 do
    AStrings.Add(FFileExt[I] + MimeSeparator + FMIMEList[I]);
end;

function IsValidIP(const S: String): Boolean;
var
  j, i: Integer;
  LTmp: String;
begin
  Result := True;
  LTmp := Sys.Trim(S);
  for i := 1 to 4 do begin
    j := Sys.StrToInt(Fetch(LTmp, '.'), -1);    {Do not Localize}
    Result := Result and (j > -1) and (j < 256);
    if NOT Result then begin
      Break;
    end;
  end;
end;

// everething that does not start with '.' is treathed as hostname    {Do not Localize}

function IsHostname(const S: String): Boolean;
begin
  Result := ((IndyPos('.', S) = 0) or (S[1] <> '.')) and NOT IsValidIP(S);    {Do not Localize}
end;

function IsTopDomain(const AStr: string): Boolean;
Var
  i: Integer;
  S1,LTmp: String;
begin
  i := 0;

  LTmp := IndyUpperCase(Sys.Trim(AStr));
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
      if S1 = 'CO' then result := i = 2;    {Do not Localize}
      if S1 = 'COM' then result := i = 2;    {Do not Localize}
    end;

    if LTmp = 'TW' then begin    {Do not Localize}
      if S1 = 'CO' then result := i = 2;    {Do not Localize}
      if S1 = 'COM' then result := i = 2;    {Do not Localize}
    end;
  end;
end;

function IsDomain(const S: String): Boolean;
begin
  Result := NOT IsHostname(S) and (IndyPos('.', S) > 0) and NOT IsTopDomain(S);    {Do not Localize}
end;

function DomainName(const AHost: String): String;
begin
  result := Copy(AHost, IndyPos('.', AHost), Length(AHost));    {Do not Localize}
end;

function IsFQDN(const S: String): Boolean;
begin
  Result := IsHostName(S) and IsDomain(DomainName(S));
end;

// The password for extracting password.bin from password.zip is indyrules

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
  if IndyPos(APathDelim, APath) = 1 then begin
    Result := APath;
  end else begin
    Result := '';    {Do not Localize}
    LPreserveTrail := (Copy(APath, Length(APath), 1) = APathDelim) or (Length(APath) = 0);
    LWork := ABasePath;
    // If LWork = '' then we just want it to be APath, no prefixed /    {Do not Localize}
    if (Length(LWork) > 0) and (Copy(LWork, Length(LWork), 1) <> APathDelim) then begin
      LWork := LWork + APathDelim;
    end;
    LWork := LWork + APath;
    if Length(LWork) > 0 then begin
      i := 1;
      while i <= Length(LWork) do begin
        if LWork[i] = APathDelim then begin
          if i = 1 then begin
            Result := APathDelim;
          end else if Copy(Result, Length(Result), 1) <> APathDelim then begin
            Result := Result + LWork[i];
          end;
        end else if LWork[i] = '.' then begin    {Do not Localize}
          // If the last character was a PathDelim then the . is a relative path modifier.
          // If it doesnt follow a PathDelim, its part of a filename
          if (Copy(Result, Length(Result), 1) = APathDelim) and (Copy(LWork, i, 2) = '..') then begin    {Do not Localize}
            // Delete the last PathDelim
            Delete(Result, Length(Result), 1);
            // Delete up to the next PathDelim
            while (Length(Result) > 0) and (Copy(Result, Length(Result), 1) <> APathDelim) do begin
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
        Inc(i);
      end;
    end;
    // Sometimes .. semantics can put a PathDelim on the end
    // But dont modify if it is only a PathDelim and nothing else, or it was there to begin with
    if (Result <> APathDelim) and (Copy(Result, Length(Result), 1) = APathDelim)
     and (LPreserveTrail = False) then begin
      Delete(Result, Length(Result), 1);
    end;
  end;
end;

// make sure that an RFC MsgID has angle brackets on it
function EnsureMsgIDBrackets(const AMsgID: String): String;
begin
  Result := AMsgID;
  if Length(Result) > 0 then begin
    if Result[1] <> #60 then begin
      Result := '<' + Result;
    end;
    if Result[Length(Result)] <> #62 then begin
      Result := Result + '>';
    end;
  end;
end;

{$IFDEF WIN32}
function GetClockValue : Int64;
var LFTime : TFileTime;
type
 TLong64Rec = record
   case LongInt of
   0 : (High : Cardinal;
       Low : Cardinal);
   1 : (Long : Int64);
 end;
begin
  Windows.GetSystemTimeAsFileTime(LFTime);
  TLong64Rec(Result).Low := LFTime.dwLowDateTime;
  TLong64Rec(Result).High := LFTime.dwHighDateTime;
end;
{$ENDIF}

{$IFDEF LINUX}
function GetClockValue : Int64;
var
  TheTms: tms;
begin
  //Is the following correct?
  Result := Libc.Times(TheTms);
end;
{$ENDIF}

{$IFDEF DOTNET}
function GetClockValue : Int64;
begin
  result := System.DateTime.Now.Ticks;
end;
{$ENDIF}

// Arg1=EAX, Arg2=DL
{$IFDEF DOTNET}
function ROL(AVal: LongWord; AShift: Byte): LongWord;
begin
   Result := (AVal shl AShift) or (AVal shr (32 - AShift));
end;
{$ELSE}
function ROL(AVal: LongWord; AShift: Byte): LongWord;
asm
  mov  cl, dl
  rol  eax, cl
end;
{$ENDIF}

{$IFDEF DOTNET}
function ROR(AVal: LongWord; AShift: Byte): LongWord;
begin
   Result := (AVal shr AShift) or (AVal shl (32 - AShift)) ;
end;
{$ELSE}
function ROR(AVal: LongWord; AShift: Byte): LongWord;
asm
  mov  cl, dl
  ror  eax, cl
end;
{$ENDIF}

{$IFDEF LINUX}
function IndyComputerName: string;
var
  LHost: array[1..255] of Char;
  i: LongWord;
begin
  //TODO: No need for LHost at all? Prob can use just Result
  if GetHostname(@LHost[1], 255) <> -1 then begin
    i := IndyPos(#0, LHost);
    SetLength(Result, i - 1);
    Move(LHost, Result[1], i - 1);
  end;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function IndyComputerName: string;
var
  i: LongWord;
begin
  SetLength(Result, MAX_COMPUTERNAME_LENGTH + 1);
  i := Length(Result);
  if GetComputerName(@Result[1], i) then begin
    SetLength(Result, i);
  end;
end;
{$ENDIF}
{$IFDEF DOTNET}
function IndyComputerName: string;
begin
  result := Environment.MachineName;
//  result := GDotNetComputerName;
end;
{$ENDIF}

function IsLeadChar(ACh : Char):Boolean;
begin
  {$IFDEF DOTNET}
  result := false;
  {$ELSE}
  result := ACh in LeadBytes;
  {$ENDIF}
end;

{$IFDEF LINUX}
function IdGetDefaultCharSet: TIdCharSet;
begin
  Result := GIdDefaultCharSet;
end;
{$ENDIF}

{$IFDEF DOTNET}
function IdGetDefaultCharSet: TIdCharSet;
begin
  result := idcsUNICODE_1_1;
  // not a particular Unicode encoding - just unicode in general
  // i.e. DotNet native string is 2 byte Unicode, we do not concern ourselves
  // with Byte order. (though we have to concern ourselves once we start
  // writing to some stream or Bytes
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
// Many defaults are set here when the choice is ambiguous. However for
// IdMessage OnInitializeISO can be used by user to choose other.
function IdGetDefaultCharSet: TIdCharSet;
begin
  case SysLocale.PriLangID of
    LANG_CHINESE: begin
      if SysLocale.SubLangID = SUBLANG_CHINESE_SIMPLIFIED then begin
        Result := idcsGB2312;
      end else begin
        Result := idcsBig5;
      end;
    end;
    LANG_JAPANESE: Result := idcsISO_2022_JP;
    LANG_KOREAN: Result := idcscsEUCKR;
    // Kudzu
    // 1251 is the Windows standard for Russian but its not used in emails.
    // KOI8-R is by far the most widely used and thus the default.
    LANG_RUSSIAN: Result := idcsKOI8_R;
    // Kudzu
    // Ukranian is about 50/50 KOI8u and 1251, but 1251 is the newer one and
    // the Windows one so we default to it.
    LANG_UKRAINIAN: Result := idcswindows_1251;
    else begin
      Result := idcsISO_8859_1;
    end;
  end;
end;
{$ENDIF}

//The following is for working on email headers and message part headers.
//For example, to remove the boundary from the ContentType header, call
//ContentType := RemoveHeaderEntry(ContentType, 'boundary');
function RemoveHeaderEntry(AHeader, AEntry: string): string;
var
  LS: string;
  LPos: integer;
  LInQuotes: Boolean;
begin
  LPos := Pos(Sys.LowerCase(AEntry), Sys.LowerCase(AHeader));
  if LPos = 0 then begin
    Result := AHeader;
  end else begin
    Result := Copy(AHeader, 1, LPos-1);
    LS := Copy(AHeader, LPos, MAXINT);
    //See if there is a following ; that is not within quotes...
    //LPos := Pos(';', LS);
    for LPos := 1 to Length(LS) do begin
      LInQuotes := False;
      if LS[LPos] = '"' then begin
        LInQuotes := not LInQuotes;
      end;
      if ((LS[LPos] = ';') and (LInQuotes = False)) then begin
        Result := Result + Copy(LS, LPos+1, MAXINT);
        Exit;
      end;
    end;
    Result := Sys.Trim(Result);
    if Result[Length(Result)] = ';' then begin
      Result := Copy(Result, 1, Length(Result)-1);
    end;
  end;
end;

{ TIdInterfacedObject }

function TIdInterfacedObject._AddRef: Integer;
begin
  {$IFDEF DOTNET}
  result := 1;
  {$ELSE}
  result := inherited _AddRef;
  {$ENDIF}
end;

function TIdInterfacedObject._Release: Integer;
begin
  {$IFDEF DOTNET}
  result := 1;
  {$ELSE}
  result := inherited _Release;
  {$ENDIF}
end;

initialization
  {$IFDEF MSWINDOWS}
  ATempPath := TempPath;
  {$ENDIF}

  SetLength(IndyFalseBoolStrs, 1);
  IndyFalseBoolStrs[Low(IndyFalseBoolStrs)] := 'FALSE';    {Do not Localize}
  SetLength(IndyTrueBoolStrs, 1);
  IndyTrueBoolStrs[Low(IndyTrueBoolStrs)] := 'TRUE';    {Do not Localize}
end.


