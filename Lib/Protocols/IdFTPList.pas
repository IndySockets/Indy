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
  Rev 1.73    3/23/2005 5:17:36 AM  JPMugaas
  Removed some unused stuff.

  Rev 1.72    2/23/2005 6:34:30 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.71    10/26/2004 9:19:14 PM  JPMugaas
  Fixed references.

  Rev 1.70    6/14/2004 12:05:50 AM  JPMugaas
  Added support for the following Item types that appear in some Unix listings
  (particularly a /dev or /tmp dir):

  FIFO, Socket, Character Device, Block Device.

  Rev 1.69    4/19/2004 5:04:58 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.68    2004.02.03 5:44:44 PM  czhower
  Name changes

  Rev 1.67    24/01/2004 19:16:42  CCostelloe
  Cleaned up warnings

  Rev 1.66    1/22/2004 4:19:04 PM  SPerry
  fixed set problems

  Rev 1.65    11/26/2003 6:22:12 PM  JPMugaas
  IdFTPList can now support file creation time for MLSD servers which support
  that feature.  I also added support for a Unique identifier for an item so
  facilitate some mirroring software if the server supports unique ID with EPLF
  and MLSD.

  Rev 1.64    3/9/2003 12:01:14 PM  JPMugaas
  Now can report errors in recursive lists.
  Permissions work better.

  Rev 1.63    2/21/2003 06:54:26 PM  JPMugaas
  The FTP list processing has been restructured so that Directory output is not
  done by IdFTPList.  This now also uses the IdFTPListParserBase for parsing so
  that the code is more scalable.

  Rev 1.62    2/17/2003 11:10:12 PM  JPMugaas
  Cisco IOS now supported.

  Rev 1.61    2/17/2003 04:43:44 PM  JPMugaas
  TOPS20 support

  Rev 1.60    2/15/2003 10:29:16 AM  JPMugaas
  Added support for some Unix specific facts with MLSD and MLST.

  Rev 1.59    2/14/2003 05:41:44 PM  JPMugaas
  Moved everything from IdFTPUtils to IdFTPCommon at Kudzu's suggestion.

  Rev 1.58    2/13/2003 10:04:28 PM  JPMugaas
  Moved some routines out of this unit and into a separate place so the code
  could be reused better.

  Rev 1.57    2/13/2003 01:31:56 AM  JPMugaas
  Made sure MLSD output is valid.  I also reordered the facts in the MLSD
  output to match with the FEAT listing.

  Rev 1.56    2/12/2003 12:23:44 PM  JPMugaas
  Bug Fixes:
  1) Blank line starting a recursive list.
  2) The ADetails parameter was working in the opposit as it should have been.

  Rev 1.55    2/12/2003 07:06:06 AM  JPMugaas
  Now honors the following parameters:

  x -  display entrie in columns accross
  C - diplay entries in columns downward
  l - long format - standard for many FTP Servers
  1 - one entry per line.

  Rev 1.54    2/11/2003 06:50:34 PM  JPMugaas
  Now supports the following:

  -X sort by extension
  -S soft by file size.

  More consistant with NcFTP Deamon.

  Rev 1.53    2/11/2003 03:43:00 PM  JPMugaas
  Q - put filename in quotes
  m - list files and dirs in a comma separated list

  are now supported.

  Rev 1.52    2/10/2003 03:05:14 PM  JPMugaas
  Now can read Unix lists with both the owner and group missing.  This can if
  the use sent the -g and -o switches.

  Rev 1.51    2/10/2003 02:09:28 PM  JPMugaas
  Now can properly process dir output using -s and or -i switches.  Note that
  Inote and Block count may not be parsed properly but it shouldn't cause an
  error.

  Rev 1.50    2/8/2003 12:43:24 PM  JPMugaas
  BugFix:  In Unix, a time is only reported if the modified date is within 6
  monthes of the current date.  The code assumed that the time is always given
  if it's in the same year as the date (not always so).

  http://www.opengroup.org/onlinepubs/007908799/xbd/utilconv.html#usg

  Rev 1.49    2/8/2003 11:43:48 AM  JPMugaas
  Made note about LineSet appearing to have two '-'.  There are just two
  charactors that are sometimes rendered the same in some programs.

  Rev 1.48    2/8/2003 10:41:30 AM  JPMugaas
  inode support for /bin/ls output.

  Rev 1.47    2/8/2003 04:37:16 AM  JPMugaas
  Rewrote the dir sorting for recurive stuff so that it is more flexible and
  permits more sorting options.  Added support for the "t" parameter and the
  /bin/ls "f" parameter.

  Rev 1.46    2/5/2003 10:13:38 PM  JPMugaas
  Added -o, -g, -p parameter support and refined the -F parameter so executable
  file names are followed by a '*'.

  Rev 1.44    2/5/2003 02:42:10 PM  JPMugaas
  Now supports the -r parameter for reverse-sorting lists even with recursive
  dirs.

  Rev 1.43    2/5/2003 08:43:48 AM  JPMugaas
  Added a ExportLSSwitches property to control the output of Unix list data
  export.  I also added support for the following switches:

  s - print blocks in List
  F - add a / to the end of dirs and symbolic links pointing to dirs
  A - surpress . and .. entries.

  The switches are the same for the /bin/ls command but we may not support them
  all.

  More will follow.
  Fixed a bug where the file being pointed to was not exported.

  Rev 1.42    2/4/2003 05:32:52 PM  JPMugaas
  Added ability to export recursive lists in both Unix and MS-DOS styles.

  Rev 1.41    2/4/2003 09:35:40 AM  JPMugaas
  Now handles Microsoft IIS DIR style with recursive listing.
  Fix for Recursion with NcFTP and MIcrosoft IIS in Unix DIRSTYLE mode.
  Fixed Novell Unix Print Services detction and Unix detection.

  Rev 1.40    2/3/2003 11:03:36 AM  JPMugaas
  Now exports the directory listing into TStrings.  Also made it possible to
  export a "total x" line for Unix style dirs.

  Rev 1.39    1/27/2003 02:53:18 AM  JPMugaas
  Fixed bug that I mistakenly introduced.

  Rev 1.38    1/27/2003 02:09:08 AM  JPMugaas
  Now, all permission feilds are empty at creation.  If the Unix permission
  feilds are empty when emulating Unix, default permissions will be given.

  Rev 1.37    1/27/2003 01:07:44 AM  JPMugaas
  In Unix, a list item was exported with two spaces between a year and the
  filename instead of one space separating both items.

  Rev 1.35    1/27/2003 12:16:02 AM  JPMugaas
  Minor adjustment to the MS-DOS DIR output.  It turns out that <DIR> part of
  the listing and the file size were off by one because only a and p were
  returned instead of AM/PM.  In addition, the filenames were separated from
  the file size by two spaces instead of one space.

  Rev 1.34    1/26/2003 04:58:36 PM  JPMugaas
  Expanded HP3000 parser slightly.

  Rev 1.33    1/26/2003 02:36:22 AM  JPMugaas
  Removed RecType type.  It was getting too ownerous to manage for MUSIC,
  VM/CMS, and MVS systems.
  Added more MVS specific properties in case a developer wishes to use them in
  a properties dialog-box.

  Rev 1.32    1/25/2003 07:31:34 PM  JPMugaas
  Added support for MUSIC SP FTP Server.

  Rev 1.31    1/20/2003 04:27:24 PM  JPMugaas
  Now handles where JES Interface 1 indicates no jobs are available.

  Rev 1.30    1/20/2003 03:13:06 PM  JPMugaas
  Unix parser now works with a Axis NPS 53X FTP Printer Server.

  Rev 1.29    1/20/2003 12:55:06 PM  JPMugaas
  Fixed sybmolic link detection problem I introduced  when applying a patch for
  other file types in Unix.

  Rev 1.28    1/19/2003 11:10:12 PM  JPMugaas
  Changed LoadList so it does not do anything if the FormatType is flfNextLine.

  Changed the Total function so it can will ignore a "Total:" so a recursive
  Unix listing will not ignore a "total:" subdirectory indicator.

  Rev 1.27    1/14/2003 04:37:52 PM  JPMugaas
  Fixed misapplied patch for Unix parsing problem in /dev directories.

  Rev 1.26    1/13/2003 10:16:06 PM  JPMugaas
  Fixed Unix parser for a peculiarity in ls output with charactor devices in
  the /dev hierarchy.   Data submitted Jeff Eaton in
  Unix-ftp.netscape.com-4.txt illustrates this.  Unix format check function now
  recognizes the following:
  b - block device
  c - character device
  p - pipe
  s - socket

  Rev 1.25    1/13/2003 12:21:28 AM  JPMugaas
  Expanded comment in MVS parser to explain why we do not support file size in
  that format.

  Rev 1.24    1/12/2003 09:00:32 PM  JPMugaas
  Refined EPLF export.  The export now tries to use ModifiedDateGMT and if
  that's not available, it uses the ModifiedDate (assuming it's in the local
  timezone).  EPLF requires dates to be based on GMT time.

  Rev 1.22    1/6/2003 10:37:12 AM  JPMugaas
  Fixed bug with Novell Netware date interpretation.  If the month was 1 and
  the day was 16, the Netware parser would interpret it as 1-16-2003 (note that
  1-16-2003 has not yet arrived).

  Rev 1.21    1/4/2003 03:24:24 PM  JPMugaas
  MVS JES Interface 1 parser now does not use string positions at all.  Spacing
  is now used instead.  More reliable that way.

  Rev 1.19    1/4/2003 01:38:40 PM  JPMugaas
  Reworked HellSoft FTP Server for Novell Support and detection.  Now it is
  detected separately from Novell Netware although it uses the same parser.
  Expanded Novell Netware Print Services for UNIX so DOS namespace is
  supported.  It turned out that I mistakenly thaught that it was simply Novell
  Netware with a NFS namespace.  Renamed format types appropriately.

  Rev 1.18    1/4/2003 10:53:52 AM  JPMugaas
  Fixed parse bug in MVS.  Sometimes, the first char in a filename was
  mistakenly dropped.
  Fixed MS-DOS parser.  For a times such 12:15 AM, the date would be returned
  as 12:15 PM.
  Fixed a MVS Particianed Data bug.  A 0 in the 3rd colum was interprettted as
  current date with the year 2000 if there was only a "0" in that column.

  Rev 1.17    1/3/2003 6:55:36 PM  JPMugaas
  WinQVT/Net 3.98.15 support.

  Rev 1.16    12/30/2002 9:19:34 AM  JPMugaas
  Patch from Andrew P. Rybin for where the count column and the file size
  column Unix are rammed together.

  Rev 1.15    12/30/2002 2:36:04 AM  JPMugaas
  Renamed the DIstinctPermissions to DistinctAttributes because those are just
  the standard MS-DOS attributes (system, read-only, hidden, and archive) as
  verified in my notes.
  Refined the Distinct32 FTP server detection.

  Rev 1.14    12/29/2002 10:29:28 PM  JPMugaas
  Updated Distinct Parser for a sample dir list where no year was given.  Added
  ModifiedTimeGMT for cases where we can obtain a timestamp in GMT (Greenwhich
  Mean Time).  These cases currently are EPLF, Distinct32, and MLST/MLSD output.

  Rev 1.13    12/29/2002 7:23:56 AM  JPMugaas
  Modified VMS parser for UCX 3.3 support (VMS-Unknown-10.txt,
  VMS-Unknown-11.txt).

  Added support for Distinct TCP/IP FTP Server-32 v. 3.0.

  Rev 1.12    12/19/2002 03:58:16 PM  JPMugaas
  Fixed an AV problem with a VM/CMS sample dir (case 10).  It was due to a
  blank line that should not have been passed to the parser.

  Rev 1.11    12/19/2002 01:29:58 PM  JPMugaas
  Microware OS/9 support.

  Rev 1.9    12/11/2002 05:52:18 PM  JPMugaas
  Fixed MS-DOS parser.  A bug would be triggered with
  "MS-DOS-MicrosoftFTP5.0-1.txt".  The parser would locate the first 43 in a
  seconds portion of the dir entry instead of the file size column which also
  contained 43.  Thanks, Jeff Easton for reporting this little gem.  Also
  removed some unneeded variables from the MS-DOS parser.

  Rev 1.8    12/11/2002 03:37:06 PM  JPMugaas
  Added LocalFileName property and the parsers now set this.  This property is
  a suggested filename for saving the file in the local system.  Pathes are
  removed from the FileName property and the version mark is stripped with VMS
  FTP Servers.

  Rev 1.7    12/9/2002 09:34:38 PM  JPMugaas
  Novel Netware with NFS Volume namespace was not working as expected.  A space
  at position in Unknown 1 and 2 was throwing things off.  I simplified the
  logic and refined the detection further.

  Rev 1.6    12/9/2002 06:57:50 PM  JPMugaas
  Added a new symbolic type for cases where a Unix server would return a / at
  the the end of the LinkedTo file name for a dir (clarifying if a link points
  to a file or a dir).  If using the DIR -F, some dir names will have a / at
  the end and executable programs may have a * at the end.  Updated the UNIX
  parser for new -F param. support.  Note that the -F parameter is from the ls
  command.  Most servers get dir lists simply by piping output from the /bin/ls
  command.  NcFTP server will also simulate the ls output.

  Rev 1.5    12/7/2002 03:20:10 PM  JPMugaas
  NCSA FTP server for MS-DOS - I hope.  I think it is included in the Telnet
  package.

  Rev 1.4    12/6/2002 08:46:34 PM  JPMugaas
  KA9Q Support.  KA9Q is a set of Internet programs for MS-DOS including a FTP
  server.  This was popular in the late 1980's and early 1990's.   It's not in
  use much anymore but might be used by Ham radio operators.

  Rev 1.3    12/1/2002 04:20:56 PM  JPMugaas
  added flfNextLine to handle cases where we can't determine the format of a
  dir with a particular line returned by the server.  Expanded Unix Parser to
  also handle Unitree FTP servers.  We now handle Unitree servers and I have
  verified that Unix ls -l * output now works (note that many Unix servers
  simply pipe output from that program).

  Rev 1.0    11/13/2002 08:28:58 AM  JPMugaas
  Initial import from FTP VC.

  Apr.2002
  - Fixed bug with MSDos Listing format - space in front of file names.

  Sep.2001 & Jan.2002
  - Merged changes submitted by Andrew P.Rybin

  2002 - Aug-23 - J. Peter Mugaas
  - fixed a parsing bug in all parsers.  A file name begging with a space will
    throw off the parsers.  Modified VMS parser to permit file names containing spaces

  2002 - Aug-22 - J. Peter Mugaas
  - VM/CMS - now returns OwnerName - I think.
  - Added RecType for VM/CMS.
  - Renamed BlockSize to NumberBlocks. Note:  Block size in VMS is usually 512 anyway
    (we hard-code that for a constant) and in VM/CMS, the block size is either
    800, 512, 1024, 2048, or 4096 at the whim of the user and we can't get the
    block size from the DIR listing.  In other words, any block size property is
    useless.
  - Changed VMS behvioar to be consistant with this.
  - Insider Privillages property added to TIdFTPListItem.  This is the
    OwnerPermissions for Novell Netware.  Note that Novell Privillages are far different
    than Unix permissions so they belong in a different property.
  - added VMS file owner and group.
    See: http://seqaxp.bio.caltech.edu/www/vms_beginners_faq.html#FILE00
  - VMS file protections (permissions).
    See: http://www.djesys.com/vms/freevms/mentor/vms_prot.html#prvs

  2002 - Aug-20 - J. Peter Mugaas
  - Added Novell Netware directory parsing.
  - Rewrote IdFTPList Novell Netware parsing.  File names with spaces are now
    properly handled.  The code also has a side effect of stripping out a zero
    that occurred in a directory that was probably due to a quirk.

  2002 - Aug-19 - J. Peter Mugaas
  - Improved VMS Directory partsing.  It NO LONGER is dependant upon specific
    column widthes.
  - Fixed bugs in VM file parsing and determination.
  - Now handles multiline VMS file list entries.

  2002 - Aug-18 - J. Peter Mugaas
  - VM/CMS or VM/ESA Mainframe directory format parsing added
  - VMS parsing added

  February 2001
  - TFTPListItem now descends from TCollectionItem
  - TFTPList now descends from TCollection

  Jun 2001
  - Fixes in UNIX format parser

  Aug 2001
  - It is now used in the FTP server component
}

unit IdFTPList;

{
  NOTE:  For this class, I recommend that you read some sections in the

  Operating Systems Handbook

  The book is out of print but is freely available at:
  http://www.snee.com/bob/opsys.html

  - Fixes as per user request for parsing non-detailed lists (SP).
    [Added flfNoDetails list format].

  Initial version by
    D. Siders
    Integral Systems
    October 2000

  Additions and extensions
    A Neillans
    Doychin Bondzhev (doychin@dsoft-bg.com)
    dSoft-Bulgaria
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,  IdException, IdFTPCommon;

{ Indy TIdFtp extensions to support automatic parsing of FTP directory listings }

type
  EIdInvalidFTPListingFormat = class(EIdException);

  TIdDirItemType = (ditDirectory, ditFile, ditSymbolicLink, ditSymbolicLinkDir,
    ditBlockDev, ditCharDev, ditFIFO, ditSocket);

  TIdFTPFileName = TIdUnicodeString;

  TIdFTPListItems = class;

  // TIdFTPListItem stores an item in the FTP directory listing
  TIdFTPListItem = class(TCollectionItem)
  protected
    FSize: Int64;
    FData: string;
    FFileName: TIdFTPFileName;
    FLocalFileName : TIdFTPFileName; //suggested file name for local file
    FSizeAvail : Boolean;
    FModifiedAvail : Boolean;
    FModifiedDate: TDateTime;

    //the item below is for cases such as MLST output, EPLF, and Distinct format
    //which usually reports dates in GMT
    FModifiedDateGMT : TDateTime;
    //Creation time values are for MLSD data output and can be returned by the
    //the MLSD parser in some cases

    FItemType: TIdDirItemType;
    //an error has been reported in the DIR listing itself for an item
    FDirError : Boolean;
    //Permission Display
    FPermissionDisplay : String;
    //this will very amoung platforms, do not use for CHMOD
    //The format veries amoung systems.  This is only provided for people
    //wanting to display a "permission column in their FTP listing
    //property set methods
    procedure SetFileName(const AValue : TIdFTPFileName);
    //may be used by some descendent classes
    property ModifiedDateGMT : TDateTime read FModifiedDateGMT write FModifiedDateGMT;
  public
    constructor Create(AOwner: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property Data: string read FData write FData;

    property Size: Int64 read FSize write FSize;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;

    property FileName: TIdFTPFileName read FFileName write SetFileName;
    property LocalFileName : TIdFTPFileName read FLocalFileName write FLocalFileName;
    property ItemType: TIdDirItemType read FItemType write FItemType;
    property SizeAvail : Boolean read FSizeAvail write FSizeAvail;
    property ModifiedAvail : Boolean read FModifiedAvail write FModifiedAvail;

    //Permission Display
    property PermissionDisplay : String read FPermissionDisplay write FPermissionDisplay;
  end;

  TIdFTPListOnGetCustomListFormat = procedure(AItem: TIdFTPListItem; var VText: string) of object;
  TIdOnParseCustomListFormat = procedure(AItem: TIdFTPListItem) of object;

  // TFTPList is the container and parser for items in the directory listing
  TIdFTPListItems = class(TCollection)
  protected
    FDirectoryName: string;
    //
    procedure SetDirectoryName(const AValue: string);
    function GetItems(AIndex: Integer): TIdFTPListItem;
    procedure SetItems(AIndex: Integer; const Value: TIdFTPListItem);
  public
    function Add: TIdFTPListItem;
    constructor Create; reintroduce;
    function IndexOf(AItem: TIdFTPListItem): Integer;
    property DirectoryName: string read FDirectoryName write SetDirectoryName;
    property Items[AIndex: Integer]: TIdFTPListItem read GetItems write SetItems; default;
  end;

implementation

uses
  IdContainers, IdResourceStrings, IdStrings, SysUtils;

{ TFTPListItem }

constructor TIdFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  Data := '';    {Do not Localize}
  FItemType := ditFile;
  Size := 0;
  ModifiedDate := 0.0;
  FFileName := '';    {Do not Localize}
  FLocalFileName := '';
  FSizeAvail := True;
  FModifiedAvail := True;
end;

procedure TIdFTPListItem.Assign(Source: TPersistent);
var
  LSource: TIdFTPListItem;
begin
  if Source is TIdFTPListItem then begin
    LSource := TIdFTPListItem(Source);
    Data := LSource.Data;
    ItemType := LSource.ItemType;
    Size := LSource.Size;
    ModifiedDate := LSource.ModifiedDate;
    ModifiedDateGMT := LSource.ModifiedDateGMT;
    FFileName := LSource.FileName;
    FLocalFileName := LSource.LocalFileName;
    SizeAvail := LSource.SizeAvail;
    ModifiedAvail := LSource.ModifiedAvail;
    PermissionDisplay := LSource.PermissionDisplay;
    FDirError := LSource.FDirError;
  end else begin
    inherited Assign(Source);
  end;
end;

{ TFTPList }

constructor TIdFTPListItems.Create;
begin
  inherited Create(TIdFTPListItem);
end;

function TIdFTPListItems.Add: TIdFTPListItem;
begin
  Result := TIdFTPListItem(inherited Add);
end;

function TIdFTPListItems.GetItems(AIndex: Integer): TIdFTPListItem;
begin
  Result := TIdFTPListItem(inherited Items[AIndex]);
end;

function TIdFTPListItems.IndexOf(AItem: TIdFTPListItem): Integer;
Var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if AItem = Items[i] then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TIdFTPListItems.SetItems(AIndex: Integer; const Value: TIdFTPListItem);
begin
  inherited Items[AIndex] := Value;
end;

procedure TIdFTPListItems.SetDirectoryName(const AValue: string);
begin
  if not TextIsSame(FDirectoryName, AValue) then begin       
    FDirectoryName := AValue;
    Clear;
  end;
end;

procedure TIdFTPListItem.SetFileName(const AValue: TIdFTPFileName);
var
  i : Integer;
  LDoLowerCase : Boolean;
const
  LLowCase = 'abcdefghijklmnpqrstuvwxyz';   {do not localize}
begin
  if (FLocalFileName = '') or TextIsSame(FFileName, FLocalFileName) then begin
    //we do things this way because some file systems use all capital letters or are
    //case insensivite.  The Unix file is case sensitive and Unix users tend to
    //prefer lower case filenames.  We do not want to force lowercase if a file
    //has both uppercase and lowercase because the uppercase letters are probably intentional
    LDoLowerCase := True;
    // TODO: add IsLower() functions in IdGlobal/Protocol?
    for i := 1 to Length(AValue) do begin
      if CharIsInSet(AValue, i, LLowCase) then begin
        LDoLowerCase := False;
        Break;
      end;
    end;
    if LDoLowerCase then begin
      FLocalFileName := LowerCase(AValue);
    end else begin
      FLocalFileName := AValue;
    end;
  end;
  FFileName := AValue;
end;

end.
