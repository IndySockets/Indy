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
  {$ifdef win32_or_win64_or_winCE}
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
  //WinceCE only has WideString functions for files.
  {$IFDEF WINCE}
  TIdFileName = WideString;
  {$ELSE}
  TIdFileName = String;
  {$ENDIF}
  TIdReadLnFunction = function: string of object;
  TStringEvent = procedure(ASender: TComponent; const AString: String);

  TIdMimeTable = class(TObject)
  protected
    FLoadTypesFromOS: Boolean;
    FOnBuildCache: TNotifyEvent;
    FMIMEList: TStringList;
    FFileExt: TStringList;
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

  {$IFNDEF VCL6ORABOVE}
  PByte =^Byte;
  PWord =^Word;
  {$ENDIF}

  {$ifdef win32_or_win64_or_winCE}
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
  function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
  function LongWordToFourChar(ACardinal : LongWord): string;
  function CharRange(const AMin, AMax : Char): String;
  Function CharToHex(const APrefix : String; const c : AnsiChar) : shortstring;
  procedure CommaSeparatedToStringList(AList: TStrings; const Value:string);
  function CompareDateTime(const ADateTime1, ADateTime2 : TDateTime) : Integer;
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
  //Wince only has WideString functions so this might as well be a widestring.
  function CopyFileTo(const Source, Destination: TIdFileName): Boolean;
  function DomainName(const AHost: String): String;
  function EnsureMsgIDBrackets(const AMsgID: String): String;
  function FileSizeByName(const AFilename: TIdFileName): Int64;

  //MLIST FTP DateTime conversion functions
  function FTPMLSToGMTDateTime(const ATimeStamp : String):TDateTime;
  function FTPMLSToLocalDateTime(const ATimeStamp : String):TDateTime;

  function FTPGMTDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
  function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;

  function GetClockValue : Int64;
  function GetMIMETypeFromFile(const AFile: String): string;
  function GetMIMEDefaultFileExt(const MIMEType: string): string;
  function GetGMTDateByName(const AFileName : TIdFileName) : TDateTime;
  function GmtOffsetStrToDateTime(S: string): TDateTime;
  function GMTToLocalDateTime(S: string): TDateTime;
  function IdGetDefaultCharSet : TIdCharSet;
  function IntToBin(Value: cardinal): string;
  function IndyComputerName : String; // DotNet: see comments regarding GDotNetComputerName below

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
   function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): LongWord;

  function PadString(const AString : String; const ALen : Integer; const AChar: Char): String;

  function ProcessPath(const ABasePath: String; const APath: String; const APathDelim: string = '/'): string;    {Do not Localize}
  function RightStr(const AStr: String; const Len: Integer): String;
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
  function UpCaseFirstWord(const AStr: string): string;
  function GetUniqueFileName(const APath, APrefix, AExt : String) : String;
  {$ifdef win32_or_win64}
  function Win32Type : TIdWin32Type;
  {$ENDIF}
  procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
  function WordToStr(const Value: Word): String;
  //moved here so I can IFDEF a DotNET ver. that uses StringBuilder
  function WrapText(const ALine, ABreakStr, ABreakChars : string; MaxCol: Integer): string;
 
  //The following is for working on email headers and message part headers...
  function RemoveHeaderEntry(AHeader, AEntry: string): string;

var
  {$IFDEF UNIX}
  // For linux the user needs to set these variables to be accurate where used (mail, etc)
  GOffsetFromUTC: TDateTime = 0;
  GTimeZoneBias: TDateTime = 0;
  GIdDefaultCharSet : TIdCharSet = idcsISO_8859_1;
  {$ENDIF}

  IndyFalseBoolStrs : array of String;
  IndyTrueBoolStrs : array of String;

//This is from: http://www.swissdelphicenter.ch/en/showcode.php?id=844
const
  // Sets UnixStartDate to TIdDateTime of 01/01/1970
  UNIXSTARTDATE : TDateTime = 25569.0;
   {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  TIME_BASEDATE = 2;
  
implementation

uses
  {$IFDEF UNIX}
    {$IFDEF KYLIX}
  Libc,
    {$ENDIF}
    {$IFDEF FPC}
     {$IFDEF UseLibC}
       libc,
     {$endif}
     {$ifdef UseBaseUnix}
       BaseUnix,
       Unix,
       DateUtils,
     {$endif}
    {$ENDIF}
  {$ENDIF}
  {$ifdef win32_or_win64_or_winCE}
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

{This is taken from Borland's SysUtils and modified for our folding}    {Do not Localize}
function WrapText(const ALine, ABreakStr, ABreakChars : string; MaxCol: Integer): string;
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
  while LPos <= LLineLen do
  begin
    LCurChar := ALine[LPos];
    if IsLeadChar(LCurChar) then
    begin
      Inc(LPos);
      Inc(LCol);
    end  //if CurChar in LeadBytes then
    else
    begin
      if LCurChar = ABreakStr[1] then
      begin
        if LQuoteChar = ' ' then    {Do not Localize}
        begin
          LExistingBreak := TextIsSame(ABreakStr, Copy(ALine, LPos, LBreakLen));
          if LExistingBreak then
          begin
            Inc(LPos, LBreakLen-1);
            LBreakPos := LPos;
          end; //if ExistingBreak then
        end // if QuoteChar = ' ' then    {Do not Localize}
      end // if CurChar = BreakStr[1] then
      else
        if CharIsInSet(LCurChar, 1, ABreakChars) then
        begin
          if LQuoteChar = ' ' then    {Do not Localize}
          begin
            LBreakPos := LPos;
          end;
        end  // if CurChar in BreakChars then
        else
        begin
        if CharIsInSet(LCurChar, 1, QuoteChars) then
        begin
          if LCurChar = LQuoteChar then
          begin
            LQuoteChar := ' ';    {Do not Localize}
          end
          else
          begin
            if LQuoteChar = ' ' then    {Do not Localize}
            begin
              LQuoteChar := LCurChar;
            end;
          end;
        end;
      end;
    end;
    Inc(LPos);
    Inc(LCol);
    if not (CharIsInSet(LQuoteChar, 1, QuoteChars)) and
       (LExistingBreak or
      ((LCol > MaxCol) and (LBreakPos > LLinePos))) then
    begin
      LCol := LPos - LBreakPos;
      Result := Result + Copy(ALine, LLinePos, LBreakPos - LLinePos + 1);
      if not (CharIsInSet(LCurChar, 1, QuoteChars)) then
      begin
        while (LPos <= LLineLen) and (CharIsInSet(ALine, LPos, ABreakChars + #13+#10)) do
        begin
          Inc(LPos);
        end;
        if not LExistingBreak and (LPos < LLineLen) then
        begin
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

{$IFDEF DOTNET}
function CharRange(const AMin, AMax : Char): String;
var i : Char;
  LSB : System.Text.StringBuilder;
begin
  LSB := System.Text.StringBuilder.Create;
  for i := Amin to AMax do
  begin
    LSB.Append(Char(i));
    Result := Result + i;
  end;
  Result := LSB.ToString;
end;
{$ELSE}
function CharRange(const AMin, AMax : Char): String;
var i : Char;
begin
  Result := '';
  for i := Amin to AMax do
  begin
    Result := Result + i;
  end;
end;
{$ENDIF}

{$ifdef win32_or_win64_or_winCE}
var
  ATempPath: string;
{$ENDIF}

function StartsWith(const ANSIStr, APattern : String) : Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := (ANSIStr <> '') and (IndyPos(APattern, UpperCase(ANSIStr)) = 1)  {do not localize}
  //tentative fix for a problem with Korean indicated by "SungDong Kim" <infi@acrosoft.pe.kr>
  {$IFNDEF DOTNET}
  //note that in DotNET, everything is MBCS
    and (ByteType(ANSIStr, 1) = mbSingleByte)
  {$ENDIF}
  ;
  //just in case someone is doing a recursive listing and there's a dir with the name total
end;


function UnixDateTimeToDelphiDateTime(UnixDateTime: Cardinal): TDateTime;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
   Result := (UnixDateTime / 86400) + UnixStartDate;
{
From: http://homepages.borland.com/efg2lab/Library/UseNet/1999/0309b.txt
 }
   //  Result := EncodeDate(1970, 1, 1) + (UnixDateTime / 86400); {86400=No. of secs. per day}
end;

function DateTimeToUnix(ADateTime: TDateTime): Cardinal;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  //example: DateTimeToUnix(now);
  Result := Round((ADateTime - UnixStartDate) * 86400);
end;

procedure CopyBytesToHostWord(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : Word);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  VDest := IdGlobal.BytesToWord(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyBytesToHostLongWord(const ASource : TIdBytes; const ASourceIndex: Integer;
  var VDest : Cardinal);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  VDest := IdGlobal.BytesToLongWord(ASource, ASourceIndex);
  VDest := GStack.NetworkToHost(VDest);
end;

procedure CopyTIdNetworkWord(const ASource: Word;
    var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  CopyTIdWord(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

procedure CopyTIdNetworkLongWord(const ASource: LongWord;
    var VDest: TIdBytes; const ADestIndex: Integer);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  CopyTIdLongWord(GStack.HostToNetwork(ASource),VDest,ADestIndex);
end;

// BGO: TODO: Move somewhere else
procedure MoveChars(const ASource:ShortString;ASourceStart:integer;var ADest:ShortString;ADestStart, ALen:integer);
{$ifdef DotNet}
var a:integer;
{$endif}
//Inline function must not have open array arguement.
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
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  SetLength(Result,2);
  Result[1] := IdHexDigits[byte(c) shr 4];
  Result[2] := IdHexDigits[byte(c) AND $0F];
  Result := APrefix + Result;
end;

function LongWordToFourChar(ACardinal : LongWord): string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := BytesToString(ToBytes(ACardinal));
end;

procedure WordToTwoBytes(AWord : Word; ByteArray: TIdBytes; Index: integer);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  //ByteArray[Index] := AWord div 256;
  //ByteArray[Index + 1] := AWord mod 256;
  ByteArray[Index + 1] := AWord div 256;
  ByteArray[Index] := AWord mod 256;
end;

function StrToWord(const Value: String): Word;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if Length(Value) > 1 then begin
    {$IFDEF DOTNET}
    Result := TwoCharToWord(Value[1], Value[2]);
    {$ELSE}
    Result := Word(Pointer(@Value[1])^);
    {$ENDIF}
  end else begin
    Result := 0;
  end;
end;

function WordToStr(const Value: Word): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := BytesToString(ToBytes(Value));
  {$ELSE}
  SetLength(Result, SizeOf(Value));
  Move(Value, Result[1], SizeOf(Value));
  {$ENDIF}
end;

function OrdFourByteToLongWord(AByte1, AByte2, AByte3, AByte4 : Byte): LongWord;
var
  LCardinal: TIdBytes;
begin
  SetLength(LCardinal,4);
  LCardinal[0] := AByte1;
  LCardinal[1] := AByte2;
  LCardinal[2] := AByte3;
  LCardinal[3] := AByte4;
  Result := BytesToLongWord( LCardinal);
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

{$ifdef win32_or_win64}
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
  DecodeDate(ADateTime1, LYear1, LMonth1, LDay1);
  DecodeDate(ADateTime2, LYear2, LMonth2, LDay2);
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
  DecodeTime(ADateTime1, LHour1, LMin1, LSec1, LMSec1);
  DecodeTime(ADateTime2, LHour2, LMin2, LSec2, LMSec2);
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
    Dt :=  IndyStrToInt( Fetch(Value, ADelim), 1);
    Value := TrimLeft(Value);
  end;

  Procedure ParseMonth;
  begin
    Mo := StrToMonth( Fetch ( Value, ADelim )  );
    Value := TrimLeft(Value);
  end;
begin
  Result := 0.0;

  LAM:=false;
  LPM:=false;

  Value := Trim(Value);
  if Length(Value) = 0 then begin
    Exit;
  end;

  try
    {Day of Week}
    if StrToDay(Copy(Value, 1, 3)) > 0 then begin
      //workaround in case a space is missing after the initial column
      if (Copy(Value, 4, 1) = ',') and (Copy(Value, 5, 1) <> ' ') then
      begin
        Insert(' ', Value, 5);
      end;
      Fetch(Value);
      Value := TrimLeft(Value);
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
    Yr := IndyStrToInt(sTime, 1900);
    // Is sTime valid Integer
    if Yr = 1900 then begin
      Yr := IndyStrToInt(Value, 1900);
      Value := sTime;
    end;
    if Yr < 80 then begin
      Inc(Yr, 2000);
    end else if Yr < 100 then begin
      Inc(Yr, 1900);
    end;

    Result := EncodeDate(Yr, Mo, Dt);
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
      Ho  := IndyStrToInt( Fetch ( sTime, ':'), 0);  {do not localize}
      {Minute}
      Min := IndyStrToInt( Fetch ( sTime, ':'), 0);  {do not localize}
      {Second}
      Sec := IndyStrToInt( Fetch ( sTime ), 0);
      {AM/PM part if preasent}
      Value := TrimLeft(Value);
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
      Result := Result + EncodeTime(Ho, Min, Sec, 0);
    end;
    Value := TrimLeft(Value);
  except
    Result := 0.0;
  end;
end;

{$ifdef win32_or_win64_or_winCE}
  {$IFNDEF VCL5ORABOVE}
  function CreateTRegistry: TRegistry;
  {$IFDEF USEINLINE} inline; {$ENDIF}
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
{$IFDEF USEINLINE} inline; {$ENDIF}
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
      LYear := IndyStrToInt(Copy( LBuffer,1,4),0);
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
{$IFDEF USEINLINE} inline; {$ENDIF}
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
  DecodeDate(ATimeStamp,LYear,LMonth,LDay);
  DecodeTime(ATimeStamp,LHour,LMin,LSec,LMSec);
  Result := IndyFormat('%4d%2d%2d%2d%2d%2d',[LYear,LMonth,LDay,LHour,LMin,LSec]);
  if AIncludeMSecs then
  begin
    if (LMSec <> 0) then
    begin
      Result := Result + IndyFormat('.%3d',[LMSec]);
    end;
  end;
  Result := StringReplace(Result,' ','0',[rfReplaceAll]);
end;
{
Note that MS-DOS displays the time in the Local Time Zone - MLISx commands use
stamps based on GMT)
}
function FTPLocalDateTimeToMLS(const ATimeStamp : TDateTime; const AIncludeMSecs : Boolean=True): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := FTPGMTDateTimeToMLS(ATimeStamp - OffSetFromUTC, AIncludeMSecs);
end;


function BreakApart(BaseString, BreakString: string; StringList: TStrings): TStrings;
var
  EndOfCurrentString: integer;
begin
  repeat
    EndOfCurrentString := Pos(BreakString, BaseString);
    if EndOfCurrentString = 0 then begin
      StringList.Add(BaseString);
    end else begin
      StringList.Add(Copy(BaseString, 1, EndOfCurrentString - 1));
    end;
    Delete(BaseString, 1, EndOfCurrentString + Length(BreakString) - 1); //Copy(BaseString, EndOfCurrentString + length(BreakString), length(BaseString) - EndOfCurrentString);
  until EndOfCurrentString = 0;
  Result := StringList;
end;

procedure CommaSeparatedToStringList(AList: TStrings; const Value:string);
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
    sTemp := Trim(Copy(Value, iStart, iEnd - iStart));
    if Length(sTemp) > 0 then
    begin
      AList.Add(sTemp);
    end;
    iPos := iEnd + 1 ;
    iQuote := 0 ;
  end ;
end;
{$IFDEF DOTNET}
function CopyFileTo(const Source, Destination: string): Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  System.IO.File.Copy(Source, Destination, true);
  result := true; // or you'll get an exception
end;
{$ELSE}
  {$ifdef win32_or_win64_or_winCE}
    {$ifdef wince}
function CopyFileTo(const Source, Destination: WideString): Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := CopyFile(PWideChar(Source), PWideChar(Destination), true);
end;
    {$else}
function CopyFileTo(const Source, Destination: string): Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := CopyFile(PChar(Source), PChar(Destination), true);
end;
    {$endif}
  {$ELSE}
//LEave in for IdAttachment
function CopyFileTo(const Source, Destination: string): Boolean;
//mostly from  http://delphi.about.com/od/fileio/a/untypedfiles.htm

//note that I do use the I+ and I- directive.
// decided not to use streams because some may not handle more than
// 2GB'sand it would run counter to the intent of this, return false
//on failure.

//This is intended to be generic because it may run in many different
//Operating systems
var
  SourceF, DestF : File;
  NumRead, NumWritten: Word;
  Buffer: array[1..2048] of Byte;
begin
  // -TODO: Change to use a Linux copy function
  // There is no native Linux copy function (at least "cp" doesn't use one
  // and I can't find one anywhere (Johannes Berg))
  
  Assign(SourceF,Source);
  {$I-} //turn off IO checking - no exception
  Reset(SourceF,1);
  {$I+} //turn it back on
  Result := IOResult <>0;
  if not result then
  begin
    Exit;
  end;
  Assign(DestF,Destination);
  {$I-} //turn off IO checking - no exception

  Rewrite(DestF,1);
  {$I+} //turn it back on
  result := IOResult<>0;
  if Result then
  begin
    repeat
      BlockRead(SourceF, Buffer, SizeOf(Buffer), NumRead) ;
      BlockWrite(DestF, Buffer, NumRead, NumWritten) ;
    until (NumRead = 0) or (NumWritten <> NumRead) ;
    Close(DestF);
    Result := True;
  end;
  Close(SourceF);

 // Result := IndyCopyFile(Source, Destination, True);
end;
  {$ENDIF}
{$ENDIF}

{$IFDEF DOTNET} 
function TempPath: WideString; 
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  {$IFDEF DOTNET1}
  Result := IndyIncludeTrailingPathDelimiter(System.IO.GetTempPath);
  {$ENDIF}
  {$IFDEF DOTNET2}
  Result := IndyIncludeTrailingPathDelimiter(System.IO.Path.GetTempPath);
  {$ENDIF}
end; 
{$ELSE} 
   {$ifdef win32_or_win64_or_winCE}
function TempPath: {$IFDEF UNICODE}WideString{$ELSE}String{$ENDIF}; 
var
	i: integer;
begin
  SetLength(Result, MAX_PATH);
  i := GetTempPath(Length(Result), PChar(Result));
  SetLength(Result, i);
  Result := IndyIncludeTrailingPathDelimiter(Result);
end;
  {$endif}
{$ENDIF}

function MakeTempFilename(const APath: String = ''): string;
var
  lPath: string;
  lExt: string;

begin
  lPath := APath;

  {$IFDEF UNIX}
  lExt := '';
  {$ELSE}
  lExt := '.tmp';
  {$ENDIF}

  {$ifdef win32_or_win64_or_winCE}
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
  {$IFDEF UNIX}

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
    {$IFDEF UseLibC}
    Result := libc.tempnam(nil, 'Indy');
    {$ENDIF}
    {$IFDEF UseBaseUnix} // FPC has wrapper function in SysUtils
			 // This might be an addition to a later 2.0 version
       Result:=GetTempFileName('','Indy');
    {$ENDIF}
  end
  
  else
  begin
    {$IFDEF UseLibC}
    Result := libc.tempnam(PChar(APath), 'Indy');
    {$ENDIF}
    {$IFDEF UseBaseUnix}
       Result:=GetTempFileName(APath,'Indy');
    {$ENDIF}
  end;
  {$ELSE}

  LFQE := AExt;

  // period is optional in the extension... force it
  if LFQE <> '' then
  begin
    if LFQE[1] <> '.' then begin
      LFQE := '.' + LFQE;
    end;
  end;

  // validate path and add path delimiter before file name prefix
  if APath <> '' then
  begin
    if not DirectoryExists(APath) then begin
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
  result := 0;
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

// OS-independant version
function FileSizeByName(const AFilename: TIdFileName): Int64;
//Leave in for HTTP Server
{$IFDEF DOTNET}
var
  LF : System.IO.FileInfo;
{$ELSE}
  {$IFDEF USEINLINE} inline; {$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  LF := System.IO.FileInfo.Create(AFileName);
  Result := LF.Length;
  {$ELSE}
  with TIdReadFileExclusiveStream.Create(AFilename) do try
    Result := Size;
  finally Free; end;
  {$ENDIF}
end;

{$IFDEF WINCE}
function GetGMTDateByName(const AFileName : TIdFileName) : TIdDateTime;
var LRec : TWin32FindData;
  LHandle : THandle;
   LTime : TSystemTime;
begin

  LHandle := Windows.FindFirstFile(@AFileName, LRec);
  if LHandle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(LHandle);
    if (LRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToSystemTime(@LRec,@LTime);
      Result := SystemTimeToDateTime(LTime);
    end;
  end;
end;
{$ELSE}
function GetGMTDateByName(const AFileName : TIdFileName) : TDateTime;
 {$ifdef win32_or_win64_or_winCE}
var LRec : TWin32FindData;
  LHandle : THandle;
   LTime : Integer;
 {$ENDIF}
 {$IFDEF UNIX}
var 
  LTime : Integer;
  {$IFDEF UseLibc}
   LRec : TStatBuf;
   LU : TUnixTime;
  {$ELSE}
   LRec : TStat;
   LU : time_t;
  {$endif}
 {$ENDIF}
begin
  Result := -1;
  {$IFDEF DOTNET}
  if System.IO.File.Exists(AFileName) then begin
    Result := System.IO.File.GetLastWriteTimeUtc(AFileName).ToOADate;
  end;
  {$ENDIF}
  {$ifdef win32_or_win64}
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
  {$IFDEF UNIX}
  if {$ifdef UseLibc}stat{$else}fpstat{$endif}(PChar(AFileName), LRec) = 0 then
  begin
    LTime := LRec.st_mtime;
    {$IFDEF UseLibc}
    gmtime_r(LTime, LU);
    Result := EncodeDate(LU.tm_year + 1900, LU.tm_mon + 1, LU.tm_mday) +
              EncodeTime(LU.tm_hour, LU.tm_min, LU.tm_sec, 0);

    {$ELSE}
      Result:=UnixToDateTime(LTime);
    {$ENDIF}
  end;
  {$ENDIF}
end;
{$ENDIF}

function RightStr(const AStr: String; const Len: Integer): String;
var
  LStrLen : Integer;
begin
  LStrLen := Length(AStr);
  if (Len > LStrLen) or (Len < 0) then begin
    Result := AStr;
  end
  else begin
    //+1 is necessary for the Index because it is one based
    Result := Copy(AStr, LStrLen - Len+1, Len);
  end;
end;

function StrToCard(const AStr: String): Cardinal;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := IndyStrToInt64(AStr, 0);
end;

{$IFDEF UNIX}
function TimeZoneBias: TDateTime;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  //TODO: Fix TimeZoneBias for Linux to be automatic
  Result := GTimeZoneBias;
end;
{$ENDIF}
{$IFDEF DOTNET}
function TimeZoneBias: TDateTime;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := -OffsetFromUTC;
end;
{$ENDIF}
{$ifdef win32_or_win64_or_winCE}
function TimeZoneBias: TDateTime;
var
  ATimeZone: TTimeZoneInformation;
begin
  {$IFNDEF WINCE}
  case GetTimeZoneInformation(ATimeZone) of
  {$ELSE}
  case GetTimeZoneInformation(@ATimeZone) of
  {$ENDIF}
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
  LCount := IndyStrToInt(AString);
  if LCount = 0 then
  begin
    result := false;
  end else
  begin
    result := true;
  end;
end;

{$IFDEF UNIX}
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
{$ifdef win32_or_win64_or_winCE}
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
  {$IFNDEF WINCE}
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
  {$ENDIF}
  DateTimeToSystemTime(Value, dSysTime);
  {$IFDEF FPC}
  Result := Windows.SetLocalTime(@dSysTime);
  {$ELSE}
  Result := Windows.SetLocalTime(dSysTime);
  {$ENDIF}
  {$IFNDEF WINCE}
  {Undo the Process Privillage change we had done for the set time
  and close the handle that was allocated}
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Windows.AdjustTokenPrivileges(hToken, False, tpko, SizeOf(tpko), tkp, Buffer);
    Windows.CloseHandle(hToken);
  end;
  {$ENDIF}
end;
{$ENDIF}

function StrToDay(const ADay: string): Byte;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := Succ(
    PosInStrArray(ADay,
      ['SUN','MON','TUE','WED','THU','FRI','SAT'], {do not localize}
      False));
end;

function StrToMonth(const AMonth: string): Byte;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := Succ(
    PosInStrArray(AMonth,
      ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'], {do not localize}
      False));
end;

function UpCaseFirst(const AStr: string): string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := LowerCase(TrimLeft(AStr));
  if Result <> '' then begin   {Do not Localize}
    Result[1] := UpCase(Result[1]);
  end;
end;

function UpCaseFirstWord(const AStr: string): string;
const
  LWhiteSet = TAB+CHAR32;    {Do not Localize}
var
  I: Integer;
begin
  for I := 1 to Length(AStr) do begin
    if CharIsInSet(AStr, I, LWhiteSet) then begin
      if I > 1 then begin
        Result := UpperCase(Copy(Result, 1, I-1)) + Copy(AStr, I, MaxInt);
        Exit;
      end;
      Break;
    end;
  end;
  Result := AStr;
end;

const
  HexNumbers = '01234567890ABCDEF';  {Do not Localize}
  BinNumbers = '01'; {Do not localize}

function IsHex(const AChar : Char) : Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := IndyPos(UpperCase(AChar), '01234567890ABCDEF') > 0; {Do not Localize}
end;

function IsBinary(const AChar : Char) : Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := IndyPos(UpperCase(AChar), '01') > 0;   {Do not localize}
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
  for i := 1 to Length(AText) do
  begin
    case LR of
      data :
        if (AText[i] = '%') and (i < Length(AText)) then
        begin
          LR := rule;
        end else
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
          if IndyStrToInt(LNum, 0) > $FF then begin
            IdDelete(LNum,Length(LNum),1);
            Result := Result + Char(IndyStrToInt(LNum, 0));
            LR := Data;
            Result := Result + AText[i];
          end;
        end
        else
        begin
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
        end
        else
        begin
          Result := Result + Char(IndyStrToInt('$'+LNum, 0));
          LNum := '';
          if AText[i] <> '.' then
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
          Result := Result + Char(IndyStrToInt('$'+LNum, 0));
          LNum := '';
          if AText[i] <> '.' then
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
procedure BuildMIMETypeMap(dest: TStringList);
{$IFDEF UNIX}
begin
  // TODO: implement BuildMIMETypeMap in Linux
  raise EIdException.Create('BuildMIMETypeMap not implemented yet.');    {Do not Localize}
end;
{$ENDIF}
{$ifdef win32_or_win64_or_winCE}
var
  Reg: TRegistry;
  slSubKeys: TStringList;
  i: integer;
begin
  Reg := CreateTRegistry; try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKeyreadOnly('\MIME\Database\Content Type'); {do not localize}
    slSubKeys := TStringList.Create;
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

function GmtOffsetStrToDateTime(S: string): TDateTime;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := 0.0;
  S := Copy(Trim(s), 1, 5);
  if Length(S) > 0 then
  begin
    if (s[1] = '-') or (s[1] = '+') then   {do not localize}
    begin
      try
        Result := EncodeTime(IndyStrToInt(Copy(s, 2, 2)), IndyStrToInt(Copy(s, 4, 2)), 0, 0);
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
    Result := Result + OffsetFromUTC;
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

{$IFDEF UNIX}
procedure LoadMIME(const AFileName : String; AMIMEList : TStringList);
var
  KeyList: TStringList;
  i, p: Integer;
  s, LMimeType, LExtension: String;
begin
  If FileExists(AFileName) Then  {Do not localize}
  Begin
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
        if p > 0 then
        begin
          SetLength(s, p-1);
        end;
        if s <> '' then {Do not localize}
        begin
          s := Trim(s);
          LMimeType := IndyLowerCase(Fetch(s));
          if LMimeType <> '' then {Do not localize}
          begin
             while s <> '' do {Do not localize}
             begin
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

procedure FillMimeTable(const AMIMEList: TStringList; const ALoadFromOS: Boolean = True);
{$ifdef win32_or_win64_or_winCE}
var
  reg: TRegistry;
  KeyList: TStringList;
  i: Integer;
  s, LExt: String;
{$ENDIF}
begin
  { Protect if someone is allready filled (custom MomeConst) }
  if not Assigned(AMIMEList) then begin
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

    { Animation }
    Add('.nml=animation/narrative');    {Do not Localize}

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

    { Video }
    Add('.avi=video/x-msvideo');    {Do not Localize}
    Add('.flc=video/flc');    {Do not Localize}
    Add('.mp2=video/mpeg');    {Do not Localize}
    Add('.mp3=video/mpeg');    {Do not Localize}
    Add('.mp4=video/mpeg');    {Do not Localize}
    Add('.mpeg=video/x-mpeg2a');    {Do not Localize}
    Add('.mpa=video/mpeg');    {Do not Localize}
    Add('.mpe=video/mpeg');    {Do not Localize}
    Add('.mpg=video/mpeg');    {Do not Localize}
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

    { Application }
    Add('.aab=application/x-authorware-bin');    {Do not Localize}
    Add('.aam=application/x-authorware-map');    {Do not Localize}
    Add('.aas=application/x-authorware-seg');    {Do not Localize}
    Add('.abw=application/x-abiword');    {Do not Localize}
    Add('.ai=application/postscript');    {Do not Localize}
    Add('.arj=application/x-arj');    {Do not Localize}
    Add('.asf=application/vnd.ms-asf');    {Do not Localize}
    Add('.bat=application/x-msdos-program');    {Do not Localize}
    Add('.bcpio=application/x-bcpio');    {Do not Localize}
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
    Add('.lzh=application/x-lzh');    {Do not Localize}
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
    Add('.sh=application/x-sh');    {Do not Localize}
    Add('.shar=application/x-shar');    {Do not Localize}
    Add('.scd=application/x-msschedule');    {Do not Localize}
    Add('.sda=application/vnd.stardivision.draw');    {Do not Localize}
    Add('.sdc=application/vnd.stardivision.calc');    {Do not Localize}
    Add('.sdd=application/vnd.stardivision.impress');    {Do not Localize}
    Add('.sdp=application/x-sdp');    {Do not Localize}
    Add('.setpay=application/set-payment-initiation');    {Do not Localize}
    Add('.setreg=application/set-registration-initiation');    {Do not Localize}
    Add('.shw=application/presentations');    {Do not Localize}
    Add('.sit=application/x-stuffit');    {Do not Localize}
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
    Add('.tr=application/x-troff');    {Do not Localize}
    Add('.trm=application/x-msterminal');    {Do not Localize}
    Add('.troff=application/x-troff');    {Do not Localize}
    Add('.tsp=application/dsptype');    {Do not Localize}
    Add('.tgz=application/x-compressed');    {Do not Localize}
    Add('.torrent=application/x-bittorrent');    {Do not Localize}
    Add('.ttz=application/t-time');    {Do not Localize}
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
    Add('.p=text/x-pascal');    {Do not Localize}
    Add('.pas=text/x-pascal');    {Do not Localize}
    Add('.h++=text/x-c++hdr');    {Do not Localize}
    Add('.hpp=text/x-c++hdr');    {Do not Localize}
    Add('.hxx=text/x-c++hdr');    {Do not Localize}
    Add('.hh=text/x-c++hdr');    {Do not Localize}
    Add('.c++=text/x-c++src');    {Do not Localize}
    Add('.cpp=text/x-c++src');    {Do not Localize}
    Add('.cxx=text/x-c++src');    {Do not Localize}
    Add('.cc=text/x-c++src');    {Do not Localize}
    Add('.h=text/x-chdr');    {Do not Localize}
    Add('.c=text/x-csrc');    {Do not Localize}
    Add('.java=text/x-java');    {Do not Localize}

    { WEB }
    Add('.css=text/css');    {Do not Localize}
    Add('.js=text/javascript');    {Do not Localize}
    Add('.htm=text/html');    {Do not Localize}
    Add('.html=text/html');    {Do not Localize}
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

  {$ifdef win32_or_win64_or_winCE}
  // Build the file type/MIME type map
  Reg := CreateTRegistry; try
    KeyList := TStringList.create;
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
        LExt := KeyList[i];
        if TextStartsWith(LExt, '.') then   {do not localize}
        begin
          if reg.OpenKeyReadOnly(LExt) then
          begin
            s := Reg.ReadString('Content Type');  {do not localize}
            if Length(s) > 0 then
            begin
              AMIMEList.Values[IndyLowerCase(LExt)] := IndyLowerCase(s);
            end;
            reg.CloseKey;
          end;
        end;
      end;
      if Reg.OpenKeyReadOnly('\MIME\Database\Content Type') then {do not localize}
      begin
        // get a list of registered MIME types
        KeyList.Clear;
        Reg.GetKeyNames(KeyList);
        reg.CloseKey;

        for i := 0 to KeyList.Count - 1 do
        begin
          if Reg.OpenKeyReadOnly('\MIME\Database\Content Type\' + KeyList[i]) then {do not localize}
          begin
            LExt := IndyLowerCase(reg.ReadString('Extension'));  {do not localize}
            if Length(LExt) > 0 then
            begin
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
    reg.free;
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
  if Length(LExt) = 0 then
  begin
    EIdException.IfTrue(ARaiseOnError, RSMIMEExtensionEmpty);
    Exit;
  end;
  { Check and fix MIMEType }
  LMIMEType := IndyLowerCase(MIMEType);
  if Length(LMIMEType) = 0 then begin
    EIdException.IfTrue(ARaiseOnError, RSMIMEMIMETypeEmpty);
    Exit;
  end;
  if LExt[1] <> '.' then begin    {do not localize}
    LExt := '.' + LExt;      {do not localize}
  end;
  { Check list }
  if FFileExt.IndexOf(LExt) = -1 then
  begin
    FFileExt.Add(LExt);
    FMIMEList.Add(LMIMEType);
  end else begin
    EIdException.IfTrue(ARaiseOnError, RSMIMEMIMEExtAlreadyExists);
    Exit;
  end;
end;

procedure TIdMimeTable.BuildCache;
begin
  if Assigned(FOnBuildCache) then begin
    FOnBuildCache(Self);
  end
  else if FFileExt.Count = 0 then
  begin
    BuildDefaultCache;
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
  if Index = -1 then
  begin
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
  if Index = -1 then
  begin
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
  for I := 0 to AStrings.Count - 1 do
  begin
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
  for I := 0 to FFileExt.Count - 1 do
    AStrings.Add(FFileExt[I] + MimeSeparator + FMIMEList[I]);
end;

function IsValidIP(const S: String): Boolean;
var
  j, i: Integer;
  LTmp: String;
begin
  Result := False;
  LTmp := Trim(S);
  for i := 1 to 4 do begin
    j := IndyStrToInt(Fetch(LTmp, '.'), -1);    {Do not Localize}
    if (j < 0) or (j >= 256) then begin
      Exit;
    end;
  end;
  Result := True;
end;

//everything that does not start with '.' is treated as hostname
function IsHostname(const S: String): Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := (not TextStartsWith(S, '.')) and (not IsValidIP(S));    {Do not Localize}
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
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := (not IsHostname(S)) and (IndyPos('.', S) > 0) and (not IsTopDomain(S));    {Do not Localize}
end;

function DomainName(const AHost: String): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := Copy(AHost, IndyPos('.', AHost), Length(AHost));    {Do not Localize}
end;

function IsFQDN(const S: String): Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := IsHostName(S) and IsDomain(DomainName(S));
end;

// The password for extracting password.bin from password.zip is indyrules

function PadString(const AString : String; const ALen : Integer; const AChar: Char): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
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
  if IndyPos(APathDelim, APath) = 1 then begin
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
          end else if not TextEndsWith(Result, APathDelim) then begin
            Result := Result + LWork[i];
          end;
        end else if LWork[i] = '.' then begin    {Do not Localize}
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

// make sure that an RFC MsgID has angle brackets on it
function EnsureMsgIDBrackets(const AMsgID: String): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
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

{$ifdef win32_or_win64_or_winCE}
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
  {$IFDEF WINCE}
  {$ELSE}
  Windows.GetSystemTimeAsFileTime(LFTime);
  TLong64Rec(Result).Low := LFTime.dwLowDateTime;
  TLong64Rec(Result).High := LFTime.dwHighDateTime;
  {$ENDIF}
end;
{$ENDIF}

{$IFDEF UNIX}
function GetClockValue : Int64;
var
  TheTms: tms;
begin
  //Is the following correct?
  Result := {$ifdef UseBaseUnix}fptimes{$else}Libc.Times{$endif}(TheTms);
end;
{$ENDIF}

{$IFDEF DOTNET}
function GetClockValue : Int64;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  result := System.DateTime.Now.Ticks;
end;
{$ENDIF}

{$UNDEF DONTHAVENATIVEX86}
{$IFDEF DOTNET}
  {$DEFINE DONTHAVENATIVEX86}
{$ENDIF}
{$IFDEF FPC}
  {$IFNDEF i386}
     {$DEFINE  DONTHAVENATIVEX86}
  {$ENDIF}
{$ENDIF}

{$IFDEF  DONTHAVENATIVEX86}
function ROL(AVal: LongWord; AShift: Byte): LongWord;
begin
   Result := (AVal shl AShift) or (AVal shr (32 - AShift));
end;

function ROR(AVal: LongWord; AShift: Byte): LongWord;
begin
   Result := (AVal shr AShift) or (AVal shl (32 - AShift)) ;
end;

{$ELSE}

// Arg1=EAX, Arg2=DL
function ROL(AVal: LongWord; AShift: Byte): LongWord;
asm
  mov  cl, dl
  rol  eax, cl
end;

function ROR(AVal: LongWord; AShift: Byte): LongWord;
asm
  mov  cl, dl
  ror  eax, cl
end;
{$ENDIF}

{$IFDEF UNIX}
function IndyComputerName: string;
var
  LHost: array[1..255] of Char;
  i: LongWord;
begin
  //TODO: No need for LHost at all? Prob can use just Result
  {$IFDEF UseLibc}
  if GetHostname(@LHost[1], 255) <> -1 then begin
    i := IndyPos(#0, LHost);
    SetLength(Result, i - 1);
    Move(LHost, Result[1], i - 1);
  end;
  {$else}
     Result:=Unix.GetHostName;
  {$endif}
end;
{$ENDIF}
{$ifdef win32_or_win64_or_winCE}
function IndyComputerName: string;
var
  i: LongWord;
begin
  {$IFDEF WINCE}
  {$WARNING To Do - find some way to get the Computer Name.}
  {$ELSE}
  SetLength(Result, MAX_COMPUTERNAME_LENGTH + 1);
  i := Length(Result);
  if GetComputerName(@Result[1], i) then begin
    SetLength(Result, i);
  end;
  {$ENDIF}
end;
{$ENDIF}
{$IFDEF DOTNET}
function IndyComputerName: string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  result := Environment.MachineName;
end;
{$ENDIF}

function IsLeadChar(ACh : Char):Boolean;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  {$IFDEF DOTNET}
  result := false;
  {$ELSE}
  result := ACh in LeadBytes;
  {$ENDIF}
end;

{$IFDEF UNIX}
function IdGetDefaultCharSet: TIdCharSet;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := GIdDefaultCharSet;
end;
{$ENDIF}

{$IFDEF DOTNET}
function IdGetDefaultCharSet: TIdCharSet;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  result := idcsUNICODE_1_1;
  // not a particular Unicode encoding - just unicode in general
  // i.e. DotNet native string is 2 byte Unicode, we do not concern ourselves
  // with Byte order. (though we have to concern ourselves once we start
  // writing to some stream or Bytes
end;
{$ENDIF}

{$ifdef win32_or_win64_or_winCE}
// Many defaults are set here when the choice is ambiguous. However for
// IdMessage OnInitializeISO can be used by user to choose other.
function IdGetDefaultCharSet: TIdCharSet;
{$IFDEF USEINLINE} inline; {$ENDIF}
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
  LPos := Pos(LowerCase(AEntry), LowerCase(AHeader));
  if LPos = 0 then begin
    Result := AHeader;
  end else begin
    Result := Copy(AHeader, 1, LPos-1);
    LS := Copy(AHeader, LPos, MaxInt);
    //See if there is a following ; that is not within quotes...
    //LPos := Pos(';', LS);
    for LPos := 1 to Length(LS) do begin
      LInQuotes := False;
      if LS[LPos] = '"' then begin
        LInQuotes := not LInQuotes;
      end;
      if ((LS[LPos] = ';') and (LInQuotes = False)) then begin
        Result := Result + Copy(LS, LPos+1, MaxInt);
        Exit;
      end;
    end;
    Result := Trim(Result);
    if TextEndsWith(Result, ';') then begin
      Delete(Result, Length(Result), 1);
    end;
  end;
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
  {$ifdef win32_or_win64_or_winCE}
  ATempPath := TempPath;
  {$ENDIF}

  SetLength(IndyFalseBoolStrs, 1);
  IndyFalseBoolStrs[Low(IndyFalseBoolStrs)] := 'FALSE';    {Do not Localize}
  SetLength(IndyTrueBoolStrs, 1);
  IndyTrueBoolStrs[Low(IndyTrueBoolStrs)] := 'TRUE';    {Do not Localize}
end.


