{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11860: IdFTPCommon.pas
{
{   Rev 1.40    3/3/2005 10:12:38 AM  JPMugaas
{ Fix for compiler warning about DotNET and ByteType.
}
{
{   Rev 1.39    12/8/2004 10:38:40 AM  JPMugaas
{ Adjustment for PC-NFS.  Time is returned with an "a" or "p" instead of AM or
{ PM.
}
{
{   Rev 1.38    11/24/2004 12:26:18 PM  JPMugaas
{ Removed dead code that caused a NET portability warning.
}
{
{   Rev 1.37    11/22/2004 7:44:26 PM  JPMugaas
{ Modified IsYYMMDD to accept 2 digit years.
}
{
{   Rev 1.35    10/27/2004 1:05:08 AM  JPMugaas
{ "SungDong Kim" <infi@acrosoft.pe.kr> indicated a problem with Korean in
{ IsTotalLine.  He suggested specifically testing for multibyte characters.
{ 
{ This is tentative.
}
{
{   Rev 1.34    10/26/2004 9:19:12 PM  JPMugaas
{ Fixed references.
}
{
{   Rev 1.33    9/7/2004 10:01:12 AM  JPMugaas
{ FIxed problem parsing:
{ 
{ drwx------ 1 user group              0 Sep 07 09:20 xxx
{ 
{ It was mistakenly being detected as Windows NT because there was a - in the
{ fifth and eigth position in the string.  The fix is to detect to see if the
{ other chactors in thbat column are numbers.
{ 
{ I did the same thing to the another part of the detection so that something
{ similar doesn't happen there with "-" in Unix listings causing false
{ WindowsNT detection.
}
{
{   Rev 1.32    8/1/2004 1:07:36 AM  JPMugaas
{ Fix for XBox dir listing problem seen in Unix-xbox-MediaCenter.txt
}
{
{   Rev 1.31    7/30/2004 5:50:54 AM  JPMugaas
{ Fix for UnquotedChar.  It was returning nothing instead of what the string
{ without quotes.
}
{
{   Rev 1.30    7/29/2004 1:33:08 AM  JPMugaas
{ Reordered AUTH command values for a new property under development.  This
{ should make things more logical.
}
{
{   Rev 1.29    6/29/2004 4:09:02 PM  JPMugaas
{ OPTS MODE Z now supported as per draft-preston-ftpext-deflate-02.txt.  This
{ should keep FTP Voyager 11 happy.
}
{
{   Rev 1.28    6/17/2004 3:38:42 PM  JPMugaas
{ Removed Transfer Mode's dmBlock and dmCompressed since we did not support
{ those at all.
}
{
{   Rev 1.27    6/15/2004 7:18:58 PM  JPMugaas
{ Compiler defines removed.
}
{
{   Rev 1.26    6/15/2004 6:35:30 PM  JPMugaas
{ Change in ZLib parameter values.  Window Bits is now positive.   We make it
{ negative as part of a workaround and then upload with the ZLib headers.
}
{
{   Rev 1.25    6/7/2004 3:47:50 PM  JPMugaas
{ VMS Recursive Dir listings now supported.  This is done with a [...].  Note
{ that VMS does have some strange syntaxes with their file system.
}
{
{   Rev 1.24    6/5/2004 7:39:58 AM  JPMugaas
{ Exposes Posix constants because I need them for something else in my private
{ work.
}
{
{   Rev 1.23    6/4/2004 4:15:42 PM  JPMugaas
{ A ChModNumber conversion function wasn't returning anything.
{ Added an overloaded function for cases where all of the permissions should be
{ in one string (such as displaying in a ListView column).
}
{
{   Rev 1.22    2/17/2004 12:25:38 PM  JPMugaas
{ The client now supports MODE Z (deflate) uploads and downloads as specified
{ by http://www.ietf.org/internet-drafts/draft-preston-ftpext-deflate-00.txt
}
{
{   Rev 1.21    2/12/2004 11:34:26 PM  JPMugaas
{ FTP Deflate preliminary support.  Work still needs to be done for upload and
{ downloading.
}
{
{   Rev 1.20    2004.02.03 5:44:42 PM  czhower
{ Name changes
}
{
{   Rev 1.19    2004.02.03 2:12:08 PM  czhower
{ $I path change
}
{
{   Rev 1.18    2004.01.23 2:37:24 AM  czhower
{ DCCIL compile fix.
}
{
{   Rev 1.17    2004.01.22 5:27:24 PM  czhower
{ Fixed compile errors.
}
{
{   Rev 1.16    1/22/2004 4:16:46 PM  SPerry
{ fixed set problems
}
{
{   Rev 1.15    1/19/2004 8:57:20 PM  JPMugaas
{ Rearranged functions to be in a more sensible way.  
}
{
{   Rev 1.14    1/19/2004 4:35:30 AM  JPMugaas
{ FTPDateTimeToMDTMD was created for converting a TDateTime into a time value
{ for MDTM.
{ MinutesFromGMT was moved from IdFTPServer because the client now may use it.
}
{
{   Rev 1.13    1/17/2004 7:37:32 PM  JPMugaas
{ Removed some warnings.
}
{
{   Rev 1.12    1/16/2004 12:23:52 AM  JPMugaas
{ New functions for MDTM set date functionality.
}
{
{   Rev 1.11    10/26/2003 9:18:10 PM  BGooijen
{ Compiles in DotNet, and partially works there
}
{
    Rev 1.10    10/19/2003 1:11:06 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.9    10/7/2003 05:46:34 AM  JPMugaas
{ SSCN Support added.
}
{
{   Rev 1.8    10/1/2003 05:29:50 PM  JPMugaas
{ Y2KDate will now adjust date if there's 3 diigits instead of 4.  This is
{ required for the OS/2 FTP LIST parser.
}
{
{   Rev 1.7    10/1/2003 12:57:12 AM  JPMugaas
{ Routines for Sterling Commerce FTP Server support.
}
{
{   Rev 1.6    6/27/2003 06:06:50 AM  JPMugaas
{ Should now compile with the IsNumeric code move.
}
{
{   Rev 1.5    3/12/2003 03:22:32 PM  JPMugaas
{ The FTP Server can now handle masks better including file extensions.
}
{
{   Rev 1.4    2/24/2003 07:19:32 AM  JPMugaas
{ Added routine for determining if a Unix file is "hidden".  This is determined
{ by a "." starting a filename.
}
{
{   Rev 1.3    2/19/2003 02:04:24 AM  JPMugaas
{ Added more routines from IdFTPList for the new framework.
}
{
{   Rev 1.2    2/17/2003 04:43:38 PM  JPMugaas
{ TOPS20 support
}
{
{   Rev 1.1    2/14/2003 05:41:36 PM  JPMugaas
{ Moved everything from IdFTPUtils to IdFTPCommon at Kudzu's suggestion.
}
{
{   Rev 1.0    11/13/2002 08:28:38 AM  JPMugaas
{ Initial import from FTP VC.
}
unit IdFTPCommon;

interface

uses
  IdObjs,
//  Classes,
  IdGlobal,
  IdGlobalProtocols,
  IdSys;

type
  TIdFTPTransferType = (ftASCII, ftBinary);
  TIdFTPDataStructure = (dsFile, dsRecord, dsPage);
  //dmBlock, dmCompressed were removed because we don't use them and they aren't supported on most
  //FTP Servers anyway.
  TIdFTPTransferMode = (dmStream, dmDeflate); // (dmBlock, dmCompressed, dmStream, dmDeflate);
    {Note that some FTP extensions might use some data port protection values that
  are defined but not used.  For memoment, I commented those out.  Leave the comments
  in just in case someone may need those later }
  TIdFTPDataPortSecurity = ( ftpdpsClear,  //'C' - Clear - neither Integrity nor Privacy

    //NOT USED - 'S' - Safe - Integrity without Privacy
    //NOT USED - 'E' - Confidential - Privacy without Integrity
    ftpdpsPrivate //'P' - Private - Integrity and Privacy
  );

{From:
  http://www.ford-hutchinson.com/~fh-1-pfh/ftps-ext.html#bad
}
const
   TLS_AUTH_NAMES : Array [0..3] of string =
     ('TLS',    {implies clear data port in some implementations}  {Do not translate}
      'SSL',    {implies private data port in some implementations}  {Do not translate}
      'TLS-C',  {implies clear data port in some implementations} {Do not translate}
      'TLS-P'); {implies private data port in some implementations} {Do not translate}





{
We hard-code these path specifiers because they are used for specific servers
irregardless of what the client's Operating system is.  It's based on the server.

}

const
  // based on http://www.raidenftpd.com/kb/kb000000037.htm
  // entry in FEAT response indicating SSCN is supported
  SCCN_FEAT = 'SSCN';  {do not localize}

  // client method - SSL Connect
  // turn on SSCN client method in FTP Server - secure server-to-server transfer
  SSCN_ON = 'SSCN ON';  {do not localize}
  //server mthod - SSL Accept method
  // turn off SSCN client method in FTP Server - secure server-to-server transfer
  SSCN_OFF = 'SSCN OFF';  {do not localize}

  SSCN_OK_REPLY = 200;
  SSCN_ERR_NEGOTIATION_REPLY = 421;

{
  VMS Stuff from http://www.djesys.com/vms/freevms/mentor/vms_path.html

  Path/filename separators, which could be different from path/subpath separators on
  some systems
 }
const
  PATH_FILENAME_SEP_UNIX = '/';
  PATH_FILENAME_SEP_DOS  = '\';
  PATH_FILENAME_SEP_VMS  = ']';

{dir/subdir separators}
const
  PATH_SUBDIR_SEP_UNIX = PATH_FILENAME_SEP_UNIX;
  PATH_SUBDIR_SEP_DOS  = PATH_FILENAME_SEP_DOS;
  PATH_SUBDIR_SEP_VMS  = '.';

{device/dir separator}
const
  PATH_DEVICE_SEP_UNIX = '';  //Unix treats devices as part of one big hierarchy as part of the file system - leave emtpy
  PATH_DEVICE_SEP_DOS  = ':';
  PATH_DEVICE_SEP_VMS  = ':[';

{
 sample VMS fully qualified filename:

  DKA0:[MYDIR.SUBDIR1.SUBDIR2]MYFILE.TXT;1

  Note VMS uses 39 chars for name and type

  valid chars are:
  letters A through Z
  numbers 0 through 9
  underscore ( _ )
  hyphen ( -)
  dollar sign ( $ )

  See:  http://www.uh.edu/infotech/services/documentation/vms/v0505.html
}

{ global file specification for all files }

  UNIX_ALL_FILES = '*';
  MS_DOS_ALL_FILES = '*.*';
  VMS_ALL_FILES = '*.*;*';

  CUR_DIR = '.';
  PARENT_DIR = '..';

  VMS_RELPATH_PREFIX = '[.';
  
  MS_DOS_CURDIR = CUR_DIR + PATH_FILENAME_SEP_DOS;
  UNIX_CURDIR = CUR_DIR +  PATH_FILENAME_SEP_UNIX;

  UNIX_DIR_SIZE = 512;

  VMS_BLOCK_SIZE = 512;

  //1/1/1970 - EPL time stamps are based on this value
const EPLF_BASE_DATE = 25569;

const
  //Settings specified by
  // http://www.ietf.org/internet-drafts/draft-preston-ftpext-deflate-00.txt
  {
  DEF_ZLIB_COMP_LEVEL = 7;
  DEF_ZLIB_WINDOW_BITS = -15; //-15 - no extra headers
  DEF_ZLIB_MEM_LEVEL = 8;
  DEF_ZLIB_STRATAGY = 0; // - default
    }
  {
  Settings specified by
  //http://www1.ietf.org/internet-drafts/draft-preston-ftpext-deflate-02.txt
  //and for some compatibility with one version of Noisette Software Corporation's ShareIt
  //FTP Server
  }
  DEF_ZLIB_COMP_LEVEL = 7;
  DEF_ZLIB_WINDOW_BITS = 15; //-15 - no extra headers
  DEF_ZLIB_MEM_LEVEL = 8; // Z_DEFLATED
  DEF_ZLIB_STRATAGY = 0; //Z_DEFAULT_STRATEGY - default
  DEF_ZLIB_METHOD = 8; // Z_DEFLATED
type
  TIdVSEPQDisposition = (
       IdPQAppendable,
       IdPQProcessAndDelete,
       IdPQHoldUntilReleased,
       IdPQProcessAndKeep,
       IdPQLeaveUntilReleased,
       IdPQErrorHoldUntilDK,
       IdPQGetOrErrorHoldUntilDK,
       IdPQJobProcessing,
       IdPQSpoolOutputToInputD,
       IdPQSurpressOutputSpooling,
       IdPQSpoolOutputToTape);


const
  VSERootDirItemTypes : array [0..5] of String =
    ('<Directory>',      {do not localize} // treat as dir
     '<VSE VTOC>',       {do not localize} // treat as dir
     '<Library>',        {do not localize} // treat as dir
     '<Power Queues>',   {do not localize} // treat as dir
     '<VSAM Catalog>',   {do not localize} // treat as dir
     'Entry Seq VSAM');  {do not localize} // treat as file
  {From: http://groups.google.com/groups?q=MVS+JES+FTP+DIR+Output&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=4qf4b8%246i7%40dsk92.itg.ti.com&rnum=1}
  MVS_JES_Status : array [0..3] of string =
    ('INPUT',   {do not localize}  //job received but not run yet
     'HELD',    {do not localize}  //job is in hold status
     'ACTIVE',  {do not localize}  //job is running
     'OUTPUT'); {do not localize}  //job has finished and has output available

     {  Note from stame article:

        To retrieve the entire job issue the GET command with the .x:

        get j26494.x    f:/job26494

        To retrieve only the third output file of your job:

        get j26494.3    f:job26494.3

      }

  { From:

  http://publibz.boulder.ibm.com:80/cgi-bin/bookmgr_OS390/BOOKS/IESPME20/A.0?DT=20010927093004#HDRDISPX

  }
  VSE_PowerQueue_Dispositions : array [1..11] of char = (
    'A',  {do not localize} // (Local only) Appendable. Spool data may be added to the job via spool-access support.
    'D',  {do not localize} // Process the job and delete it after processing. Default disposition.
    'H',  {do not localize} // Hold in queue until released.
    'K',  {do not localize} // Process the job and keep it in the queue after processing. (Default disposition for time event scheduling jobs that have to be processed more than once.)
    'L',  {do not localize} // Leave in queue until released.
    'X',  {do not localize} // (Local only) Hold until disposition is changed to D or K. Temporarily assigned by VSE/POWER when processing fails.
    'Y',  {do not localize} {
      (Local only) Hold until the disposition is changed to D or K. Applies only to
      output being retrieved via the GET service of the spool-access support.
      Assigned by VSE/POWER either on request by the retrieving program or, to
      certain queue entries, when processing fails.

     Output queue entries may have also been set to a disposition of Y when
     ignored records were found and SET IGNREC=DISPY was specified in the
     VSE/POWER autostart procedure.
     }
    '*',  {do not localize} // Indicates that a queue entry is being processed.
    {
      The following local disposition codes may be specified for an output entry,
      but they are effective only while the entry is being created.
    }
    'I',  {do not localize}  //Spool this output to the input (reader) queue with disposition D. Applies to punch output.
    'N',  {do not localize}  //Suppress the spooling of the referenced output when the job entry is being processed.
    'T'   {do not localize}  //Spool the referenced output to tape. Applies to output.
{
If a queue entry has a temporary local disposition of A, or X, or Y, VSE/POWER
present the original disposition in the ORGDP=field of a PDISPLAY...,FULL=YES
request.
}
    );

{TODO:  Add method to TIdFTP to set dispositions for VSE Power Queue jobs if possible.

I think it is done with a PALTER DISP=[disposition code] command but I'm not sure.

}

const UnitreeStoreTypes : array [0..1] of string =
  ('AR', 'DK'); {do not localize}

const
  UNIX_LINKTO_SYM = ' -> '; {do not localize} //indicates where a symbolic link points to
  CDATE_PART_SEP = '/-';  {Do not localize}
{***
Path conversions
***}
function UnixPathToDOSPath(const APath : String):String;
function DOSPathToUnixPath(const APath : String):String;

{***
Indy path utility functions
***}
//works like ExtractFilePath except that it will use both "/" and "\" and the last path spec is dropped
function IndyGetFilePath(const AFileName : String):String;
function IndyGetFileName(const AFileName : String):String;
function IndyIsRelativePath(const APathName : String): Boolean;
function IndyGetFileExt(const AFileName : String) : String;
function StripInitPathDelin(const AStr : String): String;
function IsNavPath(const APath : String): Boolean;
function RemoveDuplicatePathSyms(APath : String): String;

{***
EPLF time stamp processing
***}
function EPLFDateToLocalDateTime(const AData: String): TIdDateTIme;
function EPLFDateToGMTDateTime(const AData: String): TIdDateTime;
function GMTDateTimeToEPLFDate(const ADateTime : TIdDateTime) : String;
function LocalDateTimeToEPLFDate(const ADateTime : TIdDateTime) : String;

{***
Misc parsing
***}
function PatternsInStr(const ASearchPattern, AString : String): Integer;
function StripSpaces(const AString : String; const ASpaces : Cardinal): String;
function StripPath(const AFileName : String; const PathDelin : String = '/'): String;
function CharsInStr(const ASearchChar : Char; const AString : String) : Integer;
function UnfoldLines(const AData : String; ALine : Integer; AStrings : TIdStrings): String;
function StrPart(var AInput: string; const AMaxLength : Integer; const ADelete: Boolean = IdFetchDeleteDefault) : String;
function FetchLength(var AInput: string;
  const AMaxLength : Integer;
 const ADelim: string = IdFetchDelimDefault;
 const ADelete: Boolean = IdFetchDeleteDefault;
 const ACaseSensitive: Boolean = IdFetchCaseSensitiveDefault): String;
function IsLineStr(const AData : String): Boolean;
function PadSpaces(const AString : String; const ALen : Integer):String;

{FTP Pattern recognition}
function IsTotalLine(const AData: String): Boolean;
function IsSubDirContentsBanner(const AData: String): Boolean;

{***
Quoted strings
***}
function UnquotedStr(const AStr : String): String;
procedure ParseQuotedArgs(const AParams : String; AStrings : TIdStrings);

{**
Number extraction
**}
function FindDelimInNumbers(const AData : String) : String;
function ExtractNumber(const AData : String; const ARetZero : Boolean = True): Integer;
function StripNo(const AData : String): String;

{**
Date parsing and processing
**}
function IsMDTMDate(const ADate : String) : Boolean;
function IsDDMonthYY(const AData : String; const ADelin : String) : Boolean;
function IsMMDDYY(const AData : String; const ADelin : String) : Boolean;
function IsYYYYMMDD(const AData : String) : Boolean;
function Y2Year(const AYear : Integer): Integer;
function DateYYMMDD(const AData: String): TIdDateTime;
function DateYYStrMonthDD(const AData: String; const ADelin : String='-'): TIdDateTime;
function DateStrMonthDDYY(const AData:String; const ADelin : String = '-'; const AAddMissingYear : Boolean=False): TIdDateTime;
function DateDDStrMonthYY(const AData: String; const ADelin : String='-'): TIdDateTime;
function DateMMDDYY(const AData: String): TIdDateTime;
function TimeHHMMSS(const AData : String):TIdDateTime;
function IsIn6MonthWindow(const AMDate : TIdDateTime):Boolean;
function AddMissingYear(const ADay, AMonth : Cardinal): Cardinal;
function IsHHMMSS(const AData : String; const ADelin : String) : Boolean;
//This assumes hours in the form 0-23 instead of the 12 AM/PM hour system used in the US.
function MVSDate(const AData: String): TIdDateTime;
function AS400Date(const AData: String): TIdDateTime;

//MDTM Set filedate support and SITE ZONE support
function MinutesFromGMT : Integer;
function MDTMOffset(const AOffs : String) : TIdDateTime;
function FTPDateTimeToMDTMD(const ATimeStamp : TIdDateTime; const AIncludeMSecs : Boolean=True; const AIncludeGMTOffset : Boolean=True ): String;
function FTPMDTMToGMTDateTime(const ATimeStamp : String):TIdDateTime;


{***
platform specific parsing and testing
***}

{Unix}
function IsValidUnixPerms(AData : String; const AStrict : Boolean = False) : Boolean;
function IsUnixLsErr(const AData: String): Boolean;
function IsUnixExec(const LUPer, LGPer, LOPer : String): Boolean;
function IsUnixHiddenFile(const AFileName : String): Boolean;

     //Chmod converstion routines
procedure ChmodNoToPerms(const AChmodNo : Integer; var VUser, VGroup, VOther : String); overload;
procedure ChmodNoToPerms(const AChmodNo : Integer; var VPermissions : String); overload;
function PermsToChmodNo(const AUser, AGroup, AOther : String): Integer;

function ChmodNoToModeBits(const AModVal : Cardinal): Cardinal;
function ModeBitsToChmodNo(const AMode : Cardinal):Integer;

function ModeBitsToPermString(const AMode : Cardinal) : String;
function PermStringToModeBits(const APerms : String): Cardinal;

{Novell Netware}
function IsNovelPSPattern(const AStr : String): Boolean;
function IsValidNovellPermissionStr(const AStr : String): Boolean;
function ExtractNovellPerms(const AData : String) : String;

{QVT/NET}
function ExcludeQVNET(const AData : String) : Boolean;
function ExtractQVNETFileName(const AData : String): String;

{Mainframe support}
function ExtractRecFormat(const ARecFM : String): String;
//Determines if the line is part of a VM/BFS list - also used by WindowsNT parser
//because two columns are shared
function IsVMBFS(AData : String) : Boolean;
{IBM VSE}
function DispositionCodeToTIdVSEPQDisposition(const ADisp : Char) : TIdVSEPQDisposition;
function TIdVSEPQDispositionDispositionCode(const ADisp : TIdVSEPQDisposition) : Char;

{EPLF and MLST/MLSD support}
function ParseFacts(AData : String; AResults : TIdStrings;
  const AFactDelin : String = ';'; const ANameDelin : String=' '): String;

{Sterling Commerce support routines}

function IsValidSterCommFlags(const AString : String) : Boolean;
function IsValidSterCommProt(const AString : String) : Boolean;
function IsValidSterCommData(const AString : String) : Boolean;

//These are from Borland's LIBC.pas header file
//We rename the constants to prevent any conflicts in Kylix and C++

const
  Id__S_ISUID       = $800;   { Set user ID on execution.  }
  Id__S_ISGID       = $400;   { Set group ID on execution.  }
  Id__S_ISVTX       = $200;   { Save swapped text after use (sticky).  }
  Id__S_IREAD       = $100;   { Read by owner.  }
  Id__S_IWRITE      = $80;    { Write by owner.  }
  Id__S_IEXEC       = $40;    { Execute by owner.  }

    { Protection bits.  }

  IdS_ISUID = Id__S_ISUID;      { Set user ID on execution.  }
  IdS_ISGID = Id__S_ISGID;      { Set group ID on execution.  }

  { Save swapped text after use (sticky bit).  This is pretty well obsolete.  }
  IdS_ISVTX         = Id__S_ISVTX;

  IdS_IRUSR = Id__S_IREAD;      { Read by owner.  }
  IdS_IWUSR = Id__S_IWRITE;     { Write by owner.  }
  IdS_IXUSR = Id__S_IEXEC;      { Execute by owner.  }
  { Read, write, and execute by owner.  }
  IdS_IRWXU = Id__S_IREAD or Id__S_IWRITE or Id__S_IEXEC;

  IdS_IREAD         = IdS_IRUSR;
  IdS_IWRITE        = IdS_IWUSR;
  IdS_IEXEC         = IdS_IXUSR;

  IdS_IRGRP = IdS_IRUSR shr 3;  { Read by group.  }
  IdS_IWGRP = IdS_IWUSR shr 3;  { Write by group.  }
  IdS_IXGRP = IdS_IXUSR shr 3;  { Execute by group.  }
  { Read, write, and execute by group.  }
  IdS_IRWXG = IdS_IRWXU shr 3;

  IdS_IROTH = IdS_IRGRP shr 3;  { Read by others.  }
  IdS_IWOTH = IdS_IWGRP shr 3;  { Write by others.  }
  IdS_IXOTH = IdS_IXGRP shr 3;  { Execute by others.  }
  { Read, write, and execute by others.  }
  IdS_IRWXO = IdS_IRWXG shr 3;
  
implementation

{Misc Parsing}

function StripSpaces(const AString : String; const ASpaces : Cardinal): String;
var i : Integer;
begin
  Result := AString;
  for i := 1 to ASpaces do
  begin
    if (Result <> '') and (Result[1]=' ') then
    begin
      Delete(Result,1,1);
    end
    else
    begin
      Break;
    end;
  end;
end;

function StripPath(const AFileName : String; const PathDelin : String = '/'): String;
var LBuf : String;
begin
  LBuf := AFileName;
  repeat
    Result := Fetch(LBuf,PathDelin);
    if (LBuf = '') then
    begin
      break;
    end;
  until False;
end;

function CharsInStr(const ASearchChar : Char; const AString : String) : Integer;
var i : Integer;
begin
  Result := 0;
  for i := 1 to Length(AString) do
  begin
    if AString[i] = ASearchChar then
    begin
      Inc(Result);
    end;
  end;
end;

function PatternsInStr(const ASearchPattern, AString : String): Integer;
var LBuf : String;
begin
  Result := 0;
  LBuf := AString;
  repeat
    Fetch(LBuf,ASearchPattern);
    if LBuf = '' then
    begin
      Break;
    end
    else
    begin
      Inc(Result);
    end;
  until False;
end;

function UnfoldLines(const AData : String; ALine : Integer; AStrings : TIdStrings): String;
var  LFoldedLine : String;
begin

  Result := AData;
  while True do begin
    Inc(ALine);
    if ALine = AStrings.Count then begin
      Break;
    end;
    LFoldedLine := AStrings[ALine];
    if LFoldedLine = '' then
    begin
      Exit;
    end;
    if not (CharIsInSet(LFoldedLine, 1, LWS)) then begin
       Break;
    end;
    Result := Sys.Trim(Result) + ' ' + Sys.Trim(LFoldedLine); {Do not Localize}
  end;
end;

function StrPart(var AInput: string; const AMaxLength : Integer; const ADelete: Boolean = IdFetchDeleteDefault) : String;
begin
  Result := Copy(AInput,1,AMaxLength);
  if ADelete then
  begin
    Delete(AInput,1,AMaxLength);
  end;
end;

function FetchLength(var AInput: string;
  const AMaxLength : Integer;
 const ADelim: string = IdFetchDelimDefault;
 const ADelete: Boolean = IdFetchDeleteDefault;
 const ACaseSensitive: Boolean = IdFetchCaseSensitiveDefault): String;
var i : Integer;
begin

  if ADelim = #0 then begin
      // AnsiPos does not work with #0
      i := Pos(ADelim, AInput);
  end else begin
      i := IndyPos(ADelim, AInput);
  end;
  if (i > AMaxLength) or (i=0) then
  begin
    Result := Copy(AInput, 1, AMaxLength);
    if ADelete then
    begin
      Delete(AInput,1,AMaxLength);
    end;
  end
  else
  begin
    Result := Fetch(AInput, ADelim, ADelete, ACaseSensitive);
  end;
end;

function IsLineStr(const AData : String): Boolean;
//see if this is just a line with spaces, '-', or tabs so we
//can skip it in the parser
const
//Note that there are two separate char codes are rended as '-' in the line below.
//Be careful when editing because the codes are different.
//  LineSet = [' ','-','–','+'];    {Do not Localize}
  LineSet = ' -'+#$96+'+'; //BGO: for DotNet, what to do with this    {Do not Localize}
var
  i: Integer;
  LLen: Integer;
Begin
  LLen := Length(AData);
  if LLen > 0 then begin
    Result:=TRUE; //only white
    for i:=1 to LLen do begin
      if NOT (CharIsInSet(AData, i, LineSet)) then begin
        Result:=FALSE;
        EXIT;
      end;
    end;
  end
  else begin
    Result:=TRUE; //empty
  end;
End;//IsLineString

function PadSpaces(const AString : String; const ALen : Integer):String;
var i : Integer;
begin
  Result := AString;
  for i := 1 to ALen - Length(AString) do
  begin
    Result := Result + ' ';
  end;
end;

{Number extraction}
function FindDelimInNumbers(const AData : String) : String;
var i : Integer;
begin
  Result := '';
  for i := 1 to Length(AData) do
  begin
    if (IsNumeric(AData[i])=False) then
    begin
      Result := AData[i];
      Break;
    end;
  end;
end;

function ExtractNumber(const AData : String; const ARetZero : Boolean = True): Integer;
var i : Integer;
    LBuf : String;
begin
  LBuf := '';
  for i := 1 to Length(AData) do
  begin
    if IsNumeric(AData[i]) then
    begin
      LBuf := LBuf + AData[i];
    end
    else
    begin
      if AData[i]<>',' then
      begin
        Break;
      end;
    end;
  end;
  if ARetZero then
  begin
    Result := Sys.StrToInt(LBuf,0);
  end
  else
  begin
    Result := Sys.StrToInt(LBuf,-1);
  end;
end;

function StripNo(const AData : String): String;
var i : Integer;
    LPos : Integer;
begin
  LPos := 1;
  for i := 1 to Length(AData) do
  begin
    LPos := i;
    if (IsNumeric(AData[i])=False) and (AData[i]<>',') then
    begin
      Break;
    end;
  end;
  Result := Copy(AData,LPos,Length(AData));
end;

{Path processing}
{

Note that for our purposes, Borland's comporable routines
are inadiquate because they always assume the standard system
path separators.  In Win32, the routines use '\' instead of '/' and
likewise, in Linux, the routines use '/' instead of '\'.  We need to
use both separators because we need to handle both for crossplatform
client/server work.

}
function LastPathDelin(const APath : String):Integer;
var i : Integer;
begin
  for i := Length(APath) downto 1 do
  begin
    if (Copy(APath,i,1) = PATH_FILENAME_SEP_DOS) or
      (Copy(APath,i,1) = PATH_FILENAME_SEP_UNIX) then
    begin
      Result := i;
      exit;
    end;
  end;
  Result := 0;
end;

function IndyGetFilePath(const AFileName : String):String;
var i : Integer;
begin
  i := LastPathDelin(AFileName);
  if i > 0 then
  begin
    Result := Copy(AFileName, 1, i-1);
  end
  else
  begin
    Result := '';
  end;
end;

function IndyGetFileName(const AFileName : String):String;
var i : Integer;
begin
  i := LastPathDelin(AFileName);
  if i = 0 then
  begin
    Result := AFileName;
  end
  else
  begin
    Result := Copy(AFileName, i+1, Length(AFileName));
  end;
end;

function IndyIsRelativePath(const APathName : String): Boolean;
begin
  Result := False;
  if APathName<>'' then
  begin
    Result := (APathName[1]=PATH_SUBDIR_SEP_UNIX) or (APathName[1]=PATH_SUBDIR_SEP_DOS);
  end;
end;

function IndyGetFileExt(const AFileName : String) : String;
{
Borland's ExtractFileExtension routine is not adiquate in some cases
because it assumes that there will only be one extension.  Some files
have two extensions such as Linux tarballs, ".tar.gz".

With a file name such as test.tar.gz, Borland's routine returns .gz
instead of .tar.gz

Sometimes, in order to shoot yourself in the foot, you have to reinvent the
gun, the bullet, and your foot :-).

}
var LBuf : String;
begin
  Result := '';
  LBuf := IndyGetFileName(AFileName);
  if IndyPos('.',LBuf)>0 then begin
    Result := Copy(LBuf,IndyPos('.',LBuf),$FFFF);
  end;
end;

function StripInitPathDelin(const AStr : String): String;
begin
  Result := AStr;
  //strip off any beggining / or \
  if Copy(Result,1,Length(PATH_FILENAME_SEP_UNIX))=PATH_FILENAME_SEP_UNIX then
  begin
    IdDelete(Result,1,Length(PATH_FILENAME_SEP_UNIX));
  end;
  if Copy(Result,1,Length(PATH_FILENAME_SEP_DOS))=PATH_FILENAME_SEP_DOS then
  begin
    IdDelete(Result,1,Length(PATH_FILENAME_SEP_DOS));
  end;
end;

function IsNavPath(const APath : String): Boolean;
var LTmp : String;
begin
  LTmp := IndyGetFileName(StripInitPathDelin(APath));
  Result := (LTmp = CUR_DIR) or (LTmp=PARENT_DIR);
end;

const
  TrailingPathCorrectionOrg : array [0..3] of string =
    ('//','\\','/\','\/');
  TrailingPathCorrectionNew : array [0..3] of string =
    ('/','\','/','/');

function RemoveDuplicatePathSyms(APath : String): String;
begin
  Result := APath;
  Result := Sys.StringReplace(APath,TrailingPathCorrectionOrg,TrailingPathCorrectionNew);
end;

{Path conversion}

function UnixPathToDOSPath(const APath : String):String;
begin
  Result := Sys.StringReplace(APath,PATH_SUBDIR_SEP_UNIX,PATH_SUBDIR_SEP_DOS);
end;

function DOSPathToUnixPath(const APath : String):String;
begin
  Result := Sys.StringReplace(APath,PATH_SUBDIR_SEP_DOS,PATH_SUBDIR_SEP_UNIX);
end;

{Pattern recognition}

function IsSubDirContentsBanner(const AData: String): Boolean;
begin
  Result := (AData<>'') and (Copy(AData,Length(AData),1)=':');
  if Result then
  begin
    //A line ending in : might be a standard Unix list item where the filename
    //ends with a ":".  Unix-xbox-MediaCenter.txt is an example.
    Result := not IsValidUnixPerms(AData);
  end;
end;

function IsTotalLine(const AData: String): Boolean;
begin
  Result := StartsWith(AData,'TOTAL')
    and (Copy(AData,Length(AData),1)<>':');
    //just in case someone is doing a recursive listing and there's a dir with the name total
end;

{Quoted strings}

function UnquotedStr(const AStr : String): String;
begin
  Result := AStr;
  if (Copy(Result,1,1)='"') then
  begin
    Delete(Result,1,1);
    Result := Fetch(Result,'"');
  end;
end;

procedure ParseQuotedArgs(const AParams : String; AStrings : TIdStrings);
var lComma, LOpenQuote : Integer;
    LBuf : String;
    LArg : String;
 //filename.ext
//"../SomeDir/A ,File.txt", filename.ext
//filename.ext, ".."
begin
  AStrings.Clear;
  LBuf  := AParams;
  repeat
    if LBuf = '' then
    begin
      Break;
    end;
    lComma := IndyPos(',',LBuf);
    LOpenQuote := IndyPos('"',LBuf);
    if LComma=0 then
    begin
      LComma := Length(LBuf);
    end;
    if (LOpenQuote=0) or (LComma < LOpenQuote) then
    begin
      LArg := Sys.TrimLeft(Fetch(LBuf,','));
    end
    else
    begin
      Fetch(LBuf,'"');
      LArg := '"'+Fetch(LBuf,'"')+'"';
    end;
    if LArg<>'' then
    begin
      AStrings.Add(LArg);
    end;
  until False;
end;

{EPLF Date processing}

function EPLFDateToLocalDateTime(const AData: String): TIdDateTime;
{note - code stolen from TIdTime and mofied for our
needs.}
var LSecs : Int64;
//const BASE_DATE = 2;
const BASE_DATE = 25569; //Jan 1, 1970
begin
  LSecs := Sys.StrToInt(AData);
  Result := Extended( ((LSecs)/ (24 * 60 * 60) ) + Int(BASE_DATE))
    -IdGlobalProtocols.TimeZoneBias;
end;

function EPLFDateToGMTDateTime(const AData: String): TIdDateTime;
{note - code stolen from TIdTime and mofied for our
needs.}
var LSecs : Int64;
//const BASE_DATE = 2;

begin
  LSecs := Sys.StrToInt(AData);
  Result := Extended( ((LSecs)/ (24 * 60 * 60) ) + Int(EPLF_BASE_DATE));
end;

function GMTDateTimeToEPLFDate(const ADateTime : TIdDateTime) : String;
//const BASE_DATE = 2;
const BASE_DATE = 25569;

begin
  Result := Sys.FloatToIntStr( extended(ADateTime - Int(BASE_DATE)) * 24 * 60 * 60);
end;

function LocalDateTimeToEPLFDate(const ADateTime : TIdDateTime) : String;
begin
  Result := Sys.FloatToIntStr(extended(ADateTime + IdGlobalProtocols.TimeZoneBias - Int(EPLF_BASE_DATE)) * 24 * 60 * 60);
end;

{Date routines}
function IsMDTMDate(const ADate : String) : Boolean;
{
Note from FTP Voyager knowlege base:

MDTM

This is from the UNIX world and it lets you query the server for the modification date and time of a file or directory. Unlike UNIX, FTP Serv-U also lets the client set the modification date and time of files on the server, if the user has sufficient access rights to do this. Its use is in synchronizing uploaded files with those on the client. Normally FTP has no way to explicitly set the date of uploaded files, they simply get the date they were created on the server. MDTM lets the client change that so they get the date of the original file on the server. Works for directories too. The syntax to set the date and time is:


MDTM yyyymmddhhmmss[+-xxx]
Where ‘yyyymmddhhmmss’ is a line of text with the year, month, day, hour, minutes, and seconds the file should get set to. The next part, “[+-xxx]”, is optional time zone information of the FTP client in minutes relative to UTC.

If the client provides this info FTP Serv-U takes care to convert the date and time to the proper local time at the server, so dates and times are kept consistent (a file created at 4 in the morning in the Eastern US would be created at 10 in Central Europe). If no time zone info is given FTP Serv-U assumes you are specifying local time at the server.

An example, showing how to set the time if the client is in the Eastern US during summer time: “MDTM 19980719103029-240”. This sets the date and time to 19 July 1998, 10:30am 29 seconds, and indicates the client is 240 behind UT
}
var LMonth, LDay, LHour, LMin, LSec : Integer;
    LBuffer, LMSecPart : String;
begin
  Result := False;
  LBuffer := ADate;
  if IndyPos('-',LBuffer)>0 then
  begin
    LMSecPart := LBuffer;
    LBuffer := Fetch(LMSecPart,'-');
    if not IsNumeric(LMSecPart) then
    begin
      Exit;
    end;
  end;
  if IndyPos('+',LBuffer)>0 then
  begin
    LMSecPart := LBuffer;
    LBuffer := Fetch(LMSecPart,'+');
    if not IsNumeric(LMSecPart) then
    begin
      Exit;
    end;
  end;
  if IndyPos('.',LBuffer)>0 then
  begin
    LMSecPart := Fetch(LBuffer,'.');
  end;
  if Length(LBuffer)<>14 then
  begin
    Exit;
  end;
  if IsNumeric(LBuffer)=False then
  begin
    Exit;
  end;
  if (LMSecPart<>'') and (IsNumeric(LMSecPart)=False) then
  begin
    Exit;
  end;
  //  1234 56 78  90 12 34
  //  ---------- ---------
  //  1998 11 07  08 52 15
 // LYear :=  Sys.StrToInt( Copy( LBuffer,1,4),0);
  LMonth := Sys.StrToInt(Copy(LBuffer,5,2),0);
  if (LMonth < 1) or (LMonth > 12) then
  begin
    Exit;
  end;
  LDay := Sys.StrToInt(Copy(LBuffer,7,2),0);
  if (LDay < 1) or (LDay > 31) then
  begin
    Exit;
  end;
  LHour := Sys.StrToInt(Copy(LBuffer,9,2),0);
  if (LHour < 0) or (LHour > 24) then
  begin
    Exit;
  end;
  LMin := Sys.StrToInt(Copy(LBuffer,11,2),0);
  if (LMin < 0) or (LMin > 59) then
  begin
    Exit;
  end;
  LSec := Sys.StrToInt(Copy(LBuffer,13,2),0);
  if (LSec < 0) or (LSec > 59) then
  begin
    Exit;
  end;
  Result := True;
end;

function MDTMOffset(const AOffs : String) : TIdDateTime;
var
  LOffs : Integer;
begin
  LOffs := Sys.StrToInt(AOffs);
  {We use ABS because EncodeTime will only accept positve values}
  Result := Sys.EncodeTime(Abs(LOffs) div 60, Abs(LOffs) mod 60, 0, 0);
  if LOffs > 0 then begin
    Result := 0 - Result;
  end;
end;

function MinutesFromGMT : Integer;
var LD : TIdDateTime;
    LHour, LMin, LSec, LMSec : Word;
begin
  LD := IdGlobalProtocols.OffsetFromUTC;
  if LD < 0.0 then
  begin
    Sys.DecodeTime(LD,LHour, LMin, LSec,LMSec);
    Result := 0 - (LHour * 60 + LMin);
  end
  else
  begin
    Sys.DecodeTime(LD,LHour, LMin, LSec,LMSec);
    Result := LHour * 60 + LMin;
  end;
end;

function FTPDateTimeToMDTMD(const ATimeStamp : TIdDateTime; const AIncludeMSecs : Boolean=True; const AIncludeGMTOffset : Boolean=True): String;
var LYear, LMonth, LDay,
    LHour, LMin, LSec, LMSec : Word;
    LOfs : Integer;
begin
  Sys.DecodeDate(ATimeStamp,LYear,LMonth,LDay);
  Sys.DecodeTime(ATimeStamp,LHour,LMin,LSec,LMSec);
  Result := Sys.Format('%4d%2d%2d%2d%2d%2d',[LYear,LMonth,LDay,LHour,LMin,LSec]); {Do not translate}
  if AIncludeMSecs then
  begin
    Result := Result + Sys.Format('.%3d',[LMSec]);  {Do not translate}
  end;
  if AIncludeGMTOffset then
  begin
    LOfs := MinutesFromGMT;
    if LOfs < 0 then
    begin
      Result := Result + Sys.IntToStr(LOfs);
    end
    else
    begin
      Result := Result + '+' + Sys.IntToStr(LOfs);
    end;
  end;
  Result := Sys.StringReplace(Result,' ','0');
end;

function FTPMDTMToGMTDateTime(const ATimeStamp : String):TIdDateTime;
var LYear, LMonth, LDay, LHour, LMin, LSec, LMSec : Integer;
    LBuffer : String;
    LOffset : String;

begin
  Result := 0;
  LBuffer := ATimeStamp;
  if LBuffer <> '' then
  begin
    //extract any offset
      if IndyPos('-',LBuffer)>0 then
      begin
        LOffset := LBuffer;
        LBuffer := Fetch(LOffset,'-');
        LOffset := '-'+LOffset;
      end;
      if IndyPos('+',LBuffer)>0 then
      begin
        LOffset := LBuffer;
        LBuffer := Fetch(LOffset,'+');
      end;
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
      if LOffset='' then
      begin
        Result := Result - OffsetFromUTC;
      end
      else
      begin
        Result := Result - MDTMOffset(LOffset);
      end;
  end;
end;

function IsYYYYMMDD(const AData : String) : Boolean;
//Does it look something like this:
//2002-09-02
//
//or
//
//90-05-19
//1234567890
begin
  Result := ((CharIsInSet(AData, 5, '/-')) and
    (CharIsInSet(AData , 8, '/-')));

  if Result then
  begin
    Result := IsNumeric(Copy(AData,1,4)) and IsNumeric(Copy(AData,6,2))
      and IsNumeric(Copy(AData,9,2));
  end;
  if not Result then
  begin
    Result := ((CharIsInSet(AData, 3, CDATE_PART_SEP )) and
      (CharIsInSet(AData , 6, CDATE_PART_SEP)));
    if Result then
    begin
      Result := IsNumeric(Copy(AData,1,2)) and IsNumeric(Copy(AData,4,2))
        and IsNumeric(Copy(AData,7,2));
    end;
  end;
end;

function IsDDMonthYY(const AData : String; const ADelin : String) : Boolean;
var LBuf, LPt : String;
begin
  Result := False;
  if PatternsInStr(ADelin,AData)=2 then
  begin
    LBuf := AData;
    LPt := Fetch(LBuf,ADelin);
    //day
    if (Sys.StrToInt(LPt,0)>0) and (Sys.StrToInt(LPt,0)<32) then
    begin
      //month
      LPt := Fetch(LBuf,ADelin);
      if StrToMonth(LPt)>0 then
      begin
       //year
         LPt := Fetch(LBuf,ADelin);
        if IsNumeric(LPt) then
        begin
          Result := True;
        end;
      end;
    end;
  end;
end;

function IsMMDDYY(const AData : String; const ADelin : String) : Boolean;
var LBuf, LPt : String;
begin
  Result := False;
  if PatternsInStr(ADelin,AData)=2 then
  begin
    LBuf := AData;
    LPt := Fetch(LBuf,ADelin);
    if (Sys.StrToInt(LPt,0)>0) and (Sys.StrToInt(LPt,0)<13) then
    begin
      LPt := Fetch(LBuf,ADelin);
      if (Sys.StrToInt(LPt,0)>0) and (Sys.StrToInt(LPt,0)<33) then
      begin
        Result := IsNumeric(LBuf);
      end;
    end;
  end;
end;

function Y2Year(const AYear : Integer): Integer;
{
This function ensures that 2 digit dates returned
by some FTP servers are interpretted just like Borland's year
handling routines.
}
  function CurrentYear : Integer;
  var LYear, LMonth, LDay : Word;
  begin
    Sys.DecodeDate(Sys.Now,LYear,LMonth,LDay);
    Result := LYear;
  end;

begin
  Result := AYear;
  //Y2K Complience for current code
  //Note that some OS/2 servers return years greater than 100 for
  //years such as 2000 and 2003
  if (Result < 1000) then
  begin
    if Sys.TwoDigitYearCenturyWindow > 0 then
    begin
      if Result > Sys.TwoDigitYearCenturyWindow then
      begin
        Result := Result + (((CurrentYear div 100)-1)*100);
      end
      else
      begin
        Result := Result + ((CurrentYear div 100)*100);
      end;
    end
    else
    begin
      Result := Result + ((CurrentYear div 100)*100);
    end;
  end;
end;

function DateYYMMDD(const AData: String): TIdDateTime;
var LMonth, LDay, LYear : Integer;
  LBuffer : String;
  LDelin : String;

begin
  LBuffer := AData;
  LDelin := FindDelimInNumbers(AData);
  LYear := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);
  LMonth := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);
  LDay := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);

  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function DateYYStrMonthDD(const AData: String; const ADelin : String='-'): TIdDateTime;
var LMonth, LDay, LYear : Integer;
  LBuffer : String;

begin
  LBuffer := AData;
  LYear := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);
  LMonth := StrToMonth(Sys.Trim(Fetch(LBuffer,ADelin)));
  LDay := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);

  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function DateStrMonthDDYY(const AData:String; const ADelin : String = '-'; const AAddMissingYear : Boolean=False): TIdDateTime;
var LMonth, LDay, LYear : Integer;
  LBuffer : String;
  LMnth : String;
begin
  LBuffer := AData;
  LMnth := Sys.Trim(Sys.Trim(Fetch(LBuffer,ADelin)));
  LMonth := Sys.StrToInt(LMnth,0);
  if LMonth = 0 then
  begin
    LMonth := StrToMonth(LMnth);
  end;
  LDay := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);
  LYear := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);
  if AAddMissingYear and (LYear = 0) then
  begin
    LYear := AddMissingYear(LDay,LMonth);
  end;
  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function DateDDStrMonthYY(const AData: String; const ADelin : String='-'): TIdDateTime;
var LMonth, LDay, LYear : Integer;
  LBuffer : String;

begin
  LBuffer := AData;
  LDay := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);
  LMonth := StrToMonth(Sys.Trim(Fetch(LBuffer,ADelin)));
  LYear := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,ADelin)),0);

  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function DateMMDDYY(const AData: String): TIdDateTime;
var LMonth, LDay, LYear : Integer;
  LBuffer : String;
  LDelin : String;

begin
  LBuffer := AData;
  LDelin := FindDelimInNumbers(AData);

  LMonth := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);
  LDay := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);
  LYear := Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelin)),0);
  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function TimeHHMMSS(const AData : String):TIdDateTime;
var LCHour, LCMin, LCSec, LCMSec : Word;
    LHour, LMin, LSec, LMSec : Word;
    LBuffer : String;
    LDelin : String;
    LPM : Boolean;
    LAM : Boolean; //necessary because we have to remove 12 hours
    //if the time was 12:01:00 AM
begin
  LPM := False;
  LAM := False;
  LBuffer := Sys.UpperCase(AData);
  if (IndyPos('PM',LBuffer)>0) then {do not localize}
  begin
    LPM := True;
    LBuffer := Fetch(LBuffer,'PM'); {do not localize}
  end;
  if (IndyPos('AM',LBuffer)>0) then {do not localize}
  begin
    LAM := True;
    LBuffer := Fetch(LBuffer,'AM'); {do not localize}
  end;
  //one server only gives an a or p instead of am or pm
  if (IndyPos('P',LBuffer)>0) then {do not localize}
  begin
    LPM := True;
    LBuffer := Fetch(LBuffer,'P'); {do not localize}
  end;
  if (IndyPos('A',LBuffer)>0) then {do not localize}
  begin
    LAM := True;
    LBuffer := Fetch(LBuffer,'A'); {do not localize}
  end;
  LBuffer := Sys.Trim(LBuffer);
  Sys.DecodeTime(Sys.Now,LCHour,LCMin,LCSec,LCMSec);
  LDelin := FindDelimInNumbers(AData);
  LHour :=   Sys.StrToInt( Fetch(LBuffer,LDelin),0);
  LMin :=  Sys.StrToInt( Fetch(LBuffer,LDelin),0);
  if LPM then
  begin
    //in the 12 hour format, afternoon is 12:00PM followed by 1:00PM
    //while midnight is written as 12:00 AM
    //Not exactly technically correct but pritty accurate
    if LHour < 12 then
    begin
      LHour := LHour + 12;
    end;
  end;
  if LAM then
  begin
    if LHour = 12 then
    begin
      LHour := 0;
    end;
  end;
  LSec :=  Sys.StrToInt( Fetch(LBuffer,LDelin),0);
  LMSec :=  Sys.StrToInt( Fetch(LBuffer,LDelin),0);
  Result := Sys.EncodeTime(LHour,LMin,LSec,LMSec);
end;

function IsIn6MonthWindow(const AMDate : TIdDateTime):Boolean;
//based on http://www.opengroup.org/onlinepubs/007908799/xbd/utilconv.html#usg
//For dates, we display the time only if the date is within 6 monthes of the current
//date.  Otherwise, we send the year.
var LCurMonth, LCurDay, LCurYear : Word;  //Now
      LPMonth,  LPYear : Word;
      LMMonth, LMDay, LMYear : Word;//AMDate
begin
  Sys.DecodeDate(Sys.Now,LCurYear,LCurMonth,LCurDay);
  Sys.DecodeDate(AMDate,LMYear,LMMonth,LMDay);
  if (LCurMonth - 6) < 1 then
  begin
    LPMonth :=  12 + (LCurMonth - 6);
    LPYear := LCurYear - 1;
  end
  else
  begin
    LPMonth := LCurMonth - 6;
    LPYear := LCurYear;
  end;
  if LMYear < LPYear then
  begin
    Result := False;
    Exit;
  end;
  if LMYear = LPYear then
  begin
    Result := (LMMonth >= LPMonth);
    if Result and (LMMonth = LPMonth) then
    begin
      Result := (LMDay >= LCurDay);
      Exit;
    end;
  end
  else
  begin
    Result := True;
  end;
end;

function AddMissingYear(const ADay, AMonth : Cardinal): Cardinal;
var LDay, LMonth, LYear : Word;
begin
  Sys.DecodeDate(Sys.Now,LYear,LMonth,LDay);
  Result := LYear;
  if (LMonth < AMonth) or (LMonth=AMonth) and (ADay > LDay) then begin
    Result := LYear - 1;
  end;
end;

function IsHHMMSS(const AData : String; const ADelin : String) : Boolean;
//This assumes hours in the form 0-23 instead of the 12 AM/PM hour system used in the US.
var LBuf, LPt : String;
begin
  Result := False;
  LBuf := AData;
  if PatternsInStr(ADelin,AData)>0 then
  begin
    LPt := Fetch(LBuf,ADelin);
    if ( Sys.StrToInt(LPt,-1)>-1) and ( Sys.StrToInt(LPt,-1)<24) then
    begin
      LPt := Fetch(LBuf,ADelin);
      if ( Sys.StrToInt(LPt,-1)>-1) and ( Sys.StrToInt(LPt,0)<60) then
      begin
        LPt := Fetch(LBuf,ADelin);
        if LPt = '' then
        begin
          Result := True;
        end
        else
        begin
          //seconds are also given - check those
          Result := ( Sys.StrToInt(LPt,-1)>-1) and ( Sys.StrToInt(LPt,0)<60);
        end;
      end;
    end;
  end;
end;

function MVSDate(const AData: String): TIdDateTime;
var
    LYear, LMonth, LDay : Integer;
    LCYear, LCMonth, LCDay : Word;
    LBuffer : String;
begin
  Sys.DecodeDate(Sys.Now,LCYear,LCMonth,LCDay);
  LBuffer := AData;
  if (IndyPos('/',LBuffer)=3) then
  begin
    //two digit things could be in order of yy/mm/dd or mm/dd/yy in a partitionned dtaset
    LYear :=  Sys.StrToInt( Fetch(LBuffer,'/'),LCYear);
    if (LYear < 13) and (LYear > 0) then
    begin
      LMonth := LYear;
      LDay :=  Sys.StrToInt( Fetch(LBuffer,'/'),LCDay);
      LYear :=   Sys.StrToInt( Fetch(LBuffer,'/'),LCYear);
    end
    else
    begin
      LMonth :=   Sys.StrToInt( Fetch(LBuffer,'/'),LCMonth);
      LDay :=  Sys.StrToInt( Fetch(LBuffer,'/'),LCDay);
    end;
  end
  else
  begin
    LYear :=  Sys.StrToInt( Fetch(LBuffer,'/'),LCYear);
    LMonth :=   Sys.StrToInt( Fetch(LBuffer,'/'),LCMonth);
    LDay :=  Sys.StrToInt( Fetch(LBuffer,'/'),LCDay);
  end;
  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

function AS400Date(const AData: String): TIdDateTime;
var LDelim : String;
    LBuffer : String;

    LDay, LMonth, LYear : Integer;

    procedure SWapNos(var An1, An2 : Integer);
    var LN : Integer;
    begin
      LN := An2;
      An2 := An1;
      An1 := LN;
    end;

begin
  Result := 0;
  LDelim := FindDelimInNumbers(AData);
  if LDelim = '' then
  begin
    Exit;
  end;
  LBuffer := AData;
  LDay :=  Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelim)),0);
  LMonth :=  Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelim)),0);
  LYear :=  Sys.StrToInt(Sys.Trim(Fetch(LBuffer,LDelim)),0);
  if (LMonth>12) then
  begin
    SwapNos(LDay,LMonth);
  end;
  if (LDay>31) then
  begin
    SwapNos(LYear,LDay);
  end;
  LYear := Y2Year(LYear);
  Result := Sys.EncodeDate(LYear,LMonth,LDay);
end;

//=== platform stuff
//===== Unix

function IsValidUnixPerms(AData : String; const AStrict : Boolean = False) : Boolean;
//Stict mode is for things such as Novell Netware Unix Print Services FTP Deamon
//which are not quite like Unix.
//Non-strict mode is for Unix servers or servers that emulate Unix because some are broken.
var SData : String;
begin

  if AStrict=False then
  begin
    SData := Sys.UpperCase(AData);
    result := (Length(SData)>9) and
       (CharIsInSet(SData, 1, 'LD-BCPS')) and    {Do not Localize}
       (CharIsInSet(SData, 2, 'TSRWX-')) and    {Do not Localize}
       {Distinct TCP/IP FTP Server-32 3.0 errs by reporting an 'A" here }
       (CharIsInSet(SData, 3, 'TSRWX-A')) and    {Do not Localize}
       (CharIsInSet(SData, 4, 'TSRWX-')) and    {Do not Localize}
       {Distinct TCP/IP FTP Server-32 3.0 errs by reporting an 'H" here for hidden files}
       (CharIsInSet(SData, 5, 'TSRWX-H')) and    {Do not Localize}
        (CharIsInSet(SData, 6, 'TSRWX-')) and    {Do not Localize}
        {Distinct's FTP Server Active X may report a "Y" by mistake, saw in manual
        FTP Server, ActiveX Control, File Transfer Protocol (RFC 959), ActiveX Control,
        for Microsoftâ Windowsä, Version 4.01
        Copyright Ó 1996 - 1998 by Distinct Corporation
        All rights reserved
    }
        (CharIsInSet(SData, 7, 'TSRWX-Y')) and    {Do not Localize}
        (CharIsInSet(SData, 8, 'TSRWX-A')) and    {Do not Localize}
         {VxWorks 5.3.1 FTP Server has a quirk where a "A" is in the permissions
        See:
  http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=slrn73rfie.
  1g2.chc%40nasa2.ksc.nasa.gov&rnum=1&prev=/groups%3Fq%3DVxWorks%2BFTP%2BLIST%2
  Bformat%2Bdate%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26selm%3D
  slrn73rfie.1g2.chc%2540nasa2.ksc.nasa.gov%26rnum%3D1

}
        (CharIsInSet(SData, 9, 'TSRWX-')) and    {Do not Localize}
        (CharIsInSet(SData, 10, 'TSRWX-'));    {Do not Localize}
  end
  else
  begin
    Result := (CharIsInSet(AData, 1, 'd-')) and    {Do not Localize}
         (CharIsInSet(AData, 2, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 3, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 4, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 5, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 6, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 7, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 8, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 9, 'tsrwx-')) and    {Do not Localize}
         (CharIsInSet(AData, 10, 'tsrwx- '));    {Do not Localize}
  end;
end;

function IsUnixLsErr(const AData: String): Boolean;
begin
  Result := (IndyPos('/bin/ls:', AData)=1);  {do not localize}
end;

function IsUnixHiddenFile(const AFileName : String): Boolean;
var LName : String;
begin
  LName := IndyGetFileName(StripInitPathDelin(AFileName));
  Result := (IsNavPath(AFileName)=False) and (Copy(LName,1,1)='.');
end;

function IsUnixExec(const LUPer, LGPer, LOPer : String): Boolean;
begin
  if (Length(LUPer)>2) and (Length(LGPer)>2) and (Length(LOPer)>2) then
  begin
    Result := False;
    if CharIsInSet(LUPer, 3, 'xSs') then {do not localize}
    begin
      Result := True;
      Exit;
    end;
    if CharIsInSet(LGPer, 3, 'xSs') then {do not localize}
    begin
      Result := True;
      Exit;
    end;
    if CharIsInSet(LOPer, 3, 'xSs') then {do not localize}
    begin
      Result := True;
      Exit;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function PermStringToModeBits(const APerms : String): Cardinal;
begin
  Result := 0;
  //owner bits
  if Copy(APerms,1,1)='r' then
  begin
    Result := Result or IdS_IRUSR;
  end;
  if Copy(APerms,2,1)='w' then
  begin
    Result := Result or IdS_IWUSR;
  end;
  if Length(APerms)>2 then
  begin
    case APerms[3] of
      'x' : //exec
      begin
        Result := Result or IdS_IXUSR;
      end;
      's' : //SUID and exec
      begin
        Result := Result or IdS_IXUSR;
        Result := Result or IdS_ISUID;
      end;
      'S' : //SUID bit without owner exec
      begin
        Result := Result or IdS_ISUID;
      end;
    end;
  end;
  //group bits
  if Copy(APerms,4,1)='r' then
  begin
    Result := Result or IdS_IRGRP;
  end;
  if Copy(APerms,5,1)='w' then
  begin
    Result := Result or IdS_IWGRP;
  end;
  if Length(APerms)>5 then
  begin
    case APerms[6] of
      'x' : //exec
      begin
        Result := Result or IdS_IXGRP;
      end;
      's' : //SUID and exec
      begin
        Result := Result or IdS_IXGRP;
        Result := Result or IdS_ISGID;
      end;
      'S' : //SGID bit without group exec
      begin
        Result := Result or IdS_ISGID;
      end;
    end;
  end;
  //Other permissions
  if Copy(APerms,7,1)='r' then
  begin
    Result := Result or IdS_IROTH;
  end;
  if Copy(APerms,8,1)='w' then
  begin
    Result := Result or IdS_IWOTH;
  end;
  if Length(APerms)>8 then
  begin
    case APerms[9] of
      'x' : Result := Result or IdS_IXOTH;
      't' :
      begin
        Result := Result or IdS_IXOTH;
        Result := Result or IdS_ISVTX;
      end;
      'T' : Result := Result or IdS_ISVTX;
    end;
  end;
end;

function ModeBitsToPermString(const AMode : Cardinal) : String;
begin
      //owner Resultissions
      //read by owner
      if AMode and IdS_IRUSR = IdS_IRUSR then
      begin
        Result := 'r';
      end
      else
      begin
        Result := '-';
      end;
      //write by owner
      if AMode and IdS_IWUSR = IdS_IWUSR then
      begin
        Result := Result + 'w';
      end
      else
      begin
        Result := Result + '-';
      end;
      //execute by owner
      if AMode and IdS_ISUID=IdS_ISUID then
      begin
        //SUID Bit - run with permissions of the file owner
        Result := Result + 's';
      end
      else
      begin
        if AMode and IdS_IXUSR=IdS_IXUSR then
        begin
          Result := Result + 'x';
        end
        else
        begin
          Result := Result + '-';
        end;
      end;
      //group permissions
      //read by group
      if AMode and IdS_IRGRP = IdS_IRGRP then
      begin
        Result := Result + 'r';
      end
      else
      begin
        Result := Result + '-';
      end;
      //write by group
      if AMode and IdS_IWGRP = IdS_IWGRP then
      begin
        Result := Result + 'w';
      end
      else
      begin
        Result := Result + '-';
      end;
      //execute by group
      if AMode and IdS_ISGID=IdS_ISGID then
      begin
        //SGID Bit - run with permissions of the file group
        Result := Result + 's';
      end
      else
      begin
        if AMode and IdS_IXGRP=IdS_IXGRP then
        begin
          Result := Result + 'x';
        end
        else
        begin
          Result := Result + '-';
        end;
      end;
      //other's permissions
      //read by others
      if AMode and IdS_IROTH = IdS_IROTH then
      begin
        Result := Result + 'r';
      end
      else
      begin
        Result := Result + '-';
      end;
      //write by others
      if AMode and IdS_IWOTH = IdS_IWOTH then
      begin
        Result := Result + 'w';
      end
      else
      begin
        Result := Result + '-';
      end;
      //execute by others
      if AMode and IdS_ISVTX=IdS_ISVTX then
      begin
        //Sticky bit - only owner can delete files in dir.
        //on older systems, it means to keep the file in memory as a "cache"
        Result := Result + 't';
      end
      else
      begin
        if AMode and IdS_IXOTH=IdS_IXOTH then
        begin
          Result := Result + 'x';
        end
        else
        begin
          Result := Result + '-';
        end;
      end;
end;

function ModeBitsToChmodNo(const AMode : Cardinal):Integer;
begin
  Result := 0;
  if AMode and IdS_ISUID = IdS_ISUID then
  begin
    Result := Result + 4000;
  end;
  if AMode and IdS_ISGID = IdS_ISGID then
  begin
    Result := Result + 2000;
  end;
  if AMode and IdS_ISVTX = IdS_ISVTX then
  begin
    Result := Result + 1000;
  end;
  if AMode and IdS_IRUSR = IdS_IRUSR then
  begin
    Result := Result + 400;
  end;
  if AMode and IdS_IWUSR = IdS_IWUSR then
  begin
    Result := Result + 200;
  end;
  if AMode and IdS_IXUSR = IdS_IXUSR then
  begin
    Result := Result + 100;
  end;
  if AMode and IdS_IRGRP = IdS_IRGRP then
  begin
    Result := Result + 40;
  end;
  if AMode and IdS_IWGRP = IdS_IWGRP then
  begin
    Result := Result + 20;
  end;
  if AMode and IdS_IXGRP = IdS_IXGRP then
  begin
    Result := Result + 10;
  end;
  if AMode and IdS_IROTH = IdS_IROTH then
  begin
    Result := Result + 4;
  end;
  if AMode and IdS_IWOTH = IdS_IWOTH then
  begin
    Result := Result + 2;
  end;
  if AMode and IdS_IXOTH = IdS_IXOTH then
  begin
    Result := Result + 1;
  end;
end;

function ChmodNoToModeBits(const AModVal : Cardinal): Cardinal;
var LSpecBits, LUBits, LGBits, LOBits : Cardinal;
    LTmp : Cardinal;
begin
  Result := 0;
  LSpecBits := AModVal div 1000;
  LSpecBits := LSpecBits and 7;
  LTmp := AModVal;
  LTmp := LTmp mod 1000;
  LUBits := LTmp div 100;
  LUBits := LUBits and 7;
  LTmp := LTmp mod 100;
  LGBits := LTmp div 10;
  LGBits := LGBits and 7;
  LTmp := LTmp mod 10;
  LOBits := LTmp and 7;
  if LSpecBits and 4=4 then
  begin
    Result := Result + IdS_ISUID;
  end;
  if LSpecBits and 2=2 then
  begin
    Result := Result + IdS_ISGID;
  end;
  if LSpecBits and 1=1 then
  begin
    Result := Result + IdS_ISVTX;
  end;
  //user bits
  if LUBits and 4=4 then
  begin
    Result := Result + IdS_IRUSR;
  end;
  if LUBits and 2=2 then
  begin
    Result := Result + IdS_IWUSR;
  end;
  if LUBits and 1=1 then
  begin
    Result := Result + IdS_IXUSR;
  end;
  //group bits
  if LGBits and 4=4 then
  begin
    Result := Result + IdS_IRGRP;
  end;
  if LGBits and 2=2 then
  begin
    Result := Result + IdS_IWGRP;
  end;
  if LGBits and 1=1 then
  begin
    Result := Result + IdS_IXGRP;
  end;
  //other bits
  if LOBits and 4=4 then
  begin
    Result := Result + IdS_IROTH;
  end;
  if LOBits and 2=2 then
  begin
    Result := Result + IdS_IWOTH;
  end;
  if LOBits and 1=1 then
  begin
    Result := Result + IdS_IXOTH;
  end;
end;

procedure ChmodNoToPerms(const AChmodNo : Integer; var VPermissions : String); overload;
begin
  VPermissions := ModeBitsToPermString(ChmodNoToModeBits(AChmodNo));
end;

procedure ChmodNoToPerms(const AChmodNo : Integer; var VUser, VGroup, VOther : String);
var LPerms : String;
begin
  ChmodNoToPerms(AChmodNo,LPerms);
  VUser := Copy(LPerms,1,3);
  VGroup := Copy(LPerms,4,3);
  VOther := Copy(LPerms,7,3);
end;

function PermsToChmodNo(const AUser, AGroup, AOther : String): Integer;
begin
  Result := ModeBitsToChmodNo( PermStringToModeBits(AUser+AGroup+AOther));
end;
//===== Novell Netware
            //ftp.sips.state.nc.us
function IsNovelPSPattern(const AStr : String): Boolean;
var s : TIdStrings;
  LModStr : String;
begin
  LModStr := AStr;
  if (Copy(LModStr,2,1)='[') then
  begin
    IdInsert(' ',LModStr,2);
  end;
  s := TIdStringList.Create;
  try
    SplitColumns(LModStr,s);
     //0-type
     //1-permissions
     //2-owner
     //3-size
     //4-month
     //5-day of month
     //6-year
     //7-time
     //8-am/pm
     //9- start of filename
     Result := (s.Count > 8) and IsNumeric(s[6]) and IsHHMMSS(s[7], ':') and
       ((Sys.UpperCase(s[8]) = 'AM') or (Sys.UpperCase(s[8]) = 'PM'));  {do not localize}
  finally
    Sys.FreeAndNil(s);
  end;
end;

function IsValidNovellPermissionStr(const AStr : String): Boolean;
var i : Integer;
const PermSet = '-RWCEAFMS';  {do not localize}
begin
  if AStr='' then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  for i := 1 to Length(AStr) do
  begin
    if not (CharIsInSet(AStr, i, PermSet)) then
    begin
      Result := False;
      break;
    end;
  end;
end;

function ExtractNovellPerms(const AData : String) : String;
//extract the Novell Netware permissions from the enclosing brackets
var LOpen, LClose : Integer;
begin
  Result := '';
  LOpen := IndyPos('[',AData);         {Do not translate}
  LClose := IndyPos(']',AData);       {Do not translate}
  if (LOpen <>0) and (LClose <> 0) and (LOpen < LClose) then
  begin
    Result := Copy(AData,LOpen+1,LClose-LOpen-1);
  end;
  Result := Sys.Trim(Result);
end;

//===== QVT/NET

function ExcludeQVNET(const AData : String) : Boolean;
//A few tests will return a false positive with WinQVTNet
//This function prevents this.
begin
  Result := (IsMMDDYY(Copy(AData,36,10),'-')=False) or
              ((Copy(AData,46,1)=' ')=False) or (IsHHMMSS(Copy(AData,47,5),':')=False);

end;

function ExtractQVNETFileName(const AData : String): String;
//This is for WinQVT/Net v3.9 - note filenames are in a 8.3 format
//but unlike the standard MS-DOS form, spaces will appear if running
//on Win32 Operating systems and filenames have spaces.  Note that
//long file names will not appear at all.  I found this out with a rigged test case.
var LBuf : String;
begin
  LBuf := Copy(AData,1,12);
  Result := Fetch(LBuf,'.');
  LBuf := Sys.Trim(LBuf);
  if LBuf <> '' then
  begin
    Result := Result + '.'+Fetch(LBuf);
  end;
  Result := Fetch(Result,'/');
end;

//===== Mainframe support
function ExtractRecFormat(const ARecFM : String): String;
begin
  Result := ARecFM;
  if (Copy(Result,1,1)='<') then
  begin
    IdDelete(Result,1,1);
  end;
  if (Copy(Result,Length(Result),1)='>') then
  begin
    Result := Fetch(Result,'>');
  end;
end;
//===== IBM VSE Power Queue
function DispositionCodeToTIdVSEPQDisposition(const ADisp : Char) : TIdVSEPQDisposition;
begin
  case ADisp of
    'A' : Result := IdPQAppendable;
    'D' : Result := IdPQProcessAndDelete;
    'H' : Result := IdPQHoldUntilReleased;
    'K' : Result := IdPQProcessAndKeep;
    'L' : Result := IdPQLeaveUntilReleased;
    'X' : Result := IdPQErrorHoldUntilDK;//(Local only) Hold until disposition is changed to D or K. Temporarily assigned by VSE/POWER when processing fails.
    'Y' : Result := IdPQGetOrErrorHoldUntilDK;
    '*' : Result := IdPQJobProcessing;
    //only valid for some local jobs being created
    'I' : Result := IdPQSpoolOutputToInputD;
    'N' : Result := IdPQSurpressOutputSpooling;
    'T' : Result := IdPQSpoolOutputToTape;
  else
    Result := IdPQProcessAndDelete;
  end;
end;

function TIdVSEPQDispositionDispositionCode(const ADisp : TIdVSEPQDisposition) : Char;
begin
  case ADisp of
    IdPQAppendable : Result := 'A';
    IdPQProcessAndDelete : Result := 'D';
    IdPQHoldUntilReleased : Result := 'H';
    IdPQProcessAndKeep : Result := 'K';
    IdPQLeaveUntilReleased : Result := 'L';
    IdPQErrorHoldUntilDK : Result := 'X';
    IdPQGetOrErrorHoldUntilDK : Result := 'Y';
    IdPQJobProcessing : Result := '*';
    //only valid for some local jobs being created
    IdPQSpoolOutputToInputD : Result := 'I';
    IdPQSurpressOutputSpooling : Result := 'N';
    IdPQSpoolOutputToTape : Result := 'T' ;
  else
    Result := 'D';
  end;
end;

function IsVMBFS(AData : String) : Boolean;
var s : TIdStrings;
begin
    Result := False;
    s := TIdStringList.Create;
    try
      SplitColumns(Sys.TrimRight(AData),s);
      if s.Count >4 then
      begin
        Result := (s[2]='F') or (s[2]='D');
        if Result then
        begin
          Result := IsNumeric(s[4]) or (s[4]<>'-');
        end;
      end;
    finally
      Sys.FreeAndNil(s);
    end;
end;

//===== MLST/MLSD and EPLF formats
function ParseFacts(AData : String; AResults : TIdStrings;
  const AFactDelin : String = ';'; const ANameDelin : String=' '): String;
var LBuf : String;
begin
  LBuf := Fetch(AData,ANameDelin);
  Result := AData;
  AResults.Clear;
  repeat
    AResults.Add( Fetch(LBuf,AFactDelin));
    if LBuf = '' then
    begin
      Break;
    end;
  until False;
end;

{Sterling Commerce support routines}

{
based on information found in:
"Connect:Enterprise® UNIX Remote User’s Guide Version 2.1 " Copyright
1999, 2002, 2003 Sterling Commerce, Inc.

}
const
  CValidFlags = 'ACDEGIMNPRTUXS';   //not sure about the S {Do not translate}
  CWhiteSpace = ' -';

  CSterThreeCharProt : array [0..7] of string =
    ('TCP','BSC','FTP','FTP','HTTP','ASY','AS2','FTS'); {Do not translate}
  CSterOneCharProt : array [0..6] of string =
    (  'A',  'B',  'F',  'G',   'H', 'Q',  'W');  {Do not translate}
  CSterThreeCharDataFlag : array [0..2] of string =
    ('BIN','ASC','EBC');                     {Do not translate}
  CSterOneCharDataFlag : array [0..2] of string =
    (  'Y',  'Z',  'K');  {Do not translate}

function RawIsValidSterPattern(const AString : String; AOneChar, AThreeChar : array of String) : Boolean;
begin
  Result := False;
  if AString='' then
  begin
    Exit;
  end;
  if Length(AString)=3 then
  begin
    if AString='---' then
    begin
      Result := True;
    end;
    if PosInStrArray(AString,AThreeChar)>-1 then
    begin
      Result := True;
    end;
  end;
  if Length(AString)=1 then
  begin
    if PosInStrArray(AString,AOneChar)>-1 then
    begin
      Result := True;
    end;
  end;
end;

function IsValidSterCommFlags(const AString : String) : Boolean;
var i : Integer;
begin
  if AString='' then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  for i := 1 to Length(AString) do
  begin
    if (IndyPos(AString[i],CValidFlags)=0) and
      (IndyPos(AString[i],CWhiteSpace)=0) then
    begin
      Result := False;
      break;
    end;
  end;
end;

function IsValidSterCommProt(const AString : String) : Boolean;
begin
  Result := RawIsValidSterPattern(AString,CSterOneCharProt,CSterThreeCharProt);
end;

function IsValidSterCommData(const AString : String) : Boolean;
begin
  Result := RawIsValidSterPattern(AString,CSterOneCharDataFlag,CSterThreeCharDataFlag);
end;

end.
