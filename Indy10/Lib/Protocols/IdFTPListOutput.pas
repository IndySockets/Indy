{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16230: IdFTPListOutput.pas
{
{   Rev 1.18    12/10/04 1:13:34 PM  RLebeau
{ FormatDateTime() fixes.  Was using 'mm' instead of 'nn' for minutes.
}
{
{   Rev 1.17    10/26/2004 9:36:26 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.16    10/26/2004 9:19:14 PM  JPMugaas
{ Fixed references.
}
{
{   Rev 1.15    10/1/2004 6:17:12 AM  JPMugaas
{ Removed some dead code.
}
{
{   Rev 1.14    6/27/2004 1:45:36 AM  JPMugaas
{ Can now optionally support LastAccessTime like Smartftp's FTP Server could. 
{ I also made the MLST listing object and parser support this as well.
}
{
    Rev 1.13    6/11/2004 9:34:44 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.12    4/19/2004 5:06:02 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.11    2004.02.03 5:45:34 PM  czhower
{ Name changes
}
{
{   Rev 1.10    24/01/2004 19:18:48  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.9    1/4/2004 12:09:54 AM  BGooijen
{ changed System.Delete to IdDelete
}
{
{   Rev 1.8    11/26/2003 6:23:44 PM  JPMugaas
{ Quite a number of fixes for recursive dirs and a few other things that
{ slipped my mind.
}
{
    Rev 1.7    10/19/2003 2:04:02 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.6    3/11/2003 07:36:00 PM  JPMugaas
{ Now reports permission denied in subdirs when doing recursive listts in Unix
{ export.
}
{
{   Rev 1.5    3/9/2003 12:01:26 PM  JPMugaas
{ Now can report errors in recursive lists.
{ Permissions work better.
}
{
{   Rev 1.4    3/3/2003 07:18:34 PM  JPMugaas
{ Now honors the FreeBSD -T flag and parses list output from a program using
{ it.  Minor changes to the File System component.
}
{
{   Rev 1.3    2/26/2003 08:57:10 PM  JPMugaas
{ Bug fix.  The owner and group should be left-justified.
}
{
{   Rev 1.2    2/24/2003 07:24:00 AM  JPMugaas
{ Now honors more Unix switches just like the old code and now work with the
{ NLIST command when emulating Unix.  -A switch support added.  Switches are
{ now in constants.
}
{
{   Rev 1.1    2/23/2003 06:19:42 AM  JPMugaas
{ Now uses Classes instead of classes.
}
{
{   Rev 1.0    2/21/2003 06:51:46 PM  JPMugaas
{ FTP Directory list output object for the FTP server.
}
unit IdFTPListOutput;

interface

uses IdFTPList, Classes, IdTStrings, SysUtils;

type
  //we can't use the standard FTP MLSD option types in the FTP Server
  //because we support some minimal things that the user can't set.
  //We have the manditory items to make it harder for the user to mess up.

  TIdFTPFactOutput = (ItemType,Modify,Size,Perm,Unique,UnixMODE,UnixOwner,UnixGroup,CreateTime,LastAccessTime);
  TIdFTPFactOutputs = set of TIdFTPFactOutput;
  TIdDirOutputFormat = (doUnix, doWin32, doEPLF);
  TIdFTPListOutputItem = class(TIdFTPListItem)
  protected
    FLinkCount: Integer;
    FGroupName: string;
    FOwnerName : String;
    FLinkedItemName : string;
    FNumberBlocks : Integer;
    FInode : Integer;
    FLastAccessDate: TDateTime;
    FLastAccessDateGMT: TDateTime;
    FCreationDate: TDateTime;
    FCreationDateGMT : TDateTime;
    //Unique ID for an item to prevent yourself from downloading something twice
    FUniqueID : String;
    //MLIST things
    FMLISTPermissions : String;

    FUnixGroupPermissions: string;
    FUnixOwnerPermissions: string;
    FUnixOtherPermissions: string;
    FUnixinode : Integer;
    //an error has been reported in the DIR listing itself for an item
    FDirError : Boolean;
  public
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
    property Inode : Integer read FInode write FInode;
      //Last Access time values are for MLSD data output and can be returned by the
      //MLST command
    property LastAccessDate: TDateTime read FLastAccessDate write FLastAccessDate;
    property LastAccessDateGMT : TDateTime read FLastAccessDateGMT write FLastAccessDateGMT;

      //Creation time values are for MLSD data output and can be returned by the
      //MLST command
    property CreationDate: TDateTime read FCreationDate write FCreationDate;
    property CreationDateGMT : TDateTime read FCreationDateGMT write FCreationDateGMT;
    // If this is not blank, you can use this as a unique identifier for an item to prevent
    // yourself from downloading the same item twice (which is not easy to see with some
    // some FTP sites where symbolic links or similar things are used.
    //Valid only with EPLF and MLST
    property UniqueID : string read FUniqueID write FUniqueID;
    //Creation time values are for MLSD data output and can be returned by the
    //the MLSD parser in some cases
    property ModifiedDateGMT;
    //MLIST Permissions
    property MLISTPermissions : string read FMLISTPermissions write FMLISTPermissions;
    property UnixOwnerPermissions: string read FUnixOwnerPermissions write FUnixOwnerPermissions;
    property UnixGroupPermissions: string read FUnixGroupPermissions write FUnixGroupPermissions;
    property UnixOtherPermissions: string read FUnixOtherPermissions write FUnixOtherPermissions;
    property LinkCount: Integer read FLinkCount write FLinkCount;
    property OwnerName: string read FOwnerName write FOwnerName;
    property GroupName: string read FGroupName write FGroupName;
    property LinkedItemName : string read FLinkedItemName write FLinkedItemName;

    property DirError : Boolean read FDirError write FDirError;
  end;
  TIdFTPListOutput = class(TCollection)
  protected
    FSwitches : String;
    FOutput : String;
    FDirFormat : TIdDirOutputFormat;
    FExportTotalLine : Boolean;
    function GetLocalModTime(AItem : TIdFTPListOutputItem) : TDateTime; virtual;
    function UnixItem(AItem : TIdFTPListOutputItem) : String; virtual;
    function Win32Item(AItem : TIdFTPListOutputItem) : String; virtual;
    function EPLFItem(AItem : TIdFTPListOutputItem) : String; virtual;
    function NListItem(AItem : TIdFTPListOutputItem) : String; virtual;
    function MListItem(AItem : TIdFTPListOutputItem; AMLstOpts : TIdFTPFactOutputs) : String; virtual;
    procedure InternelOutputDir(AOutput : TIdStrings; ADetails : Boolean = true); virtual;
    function UnixINodeOutput(AItem : TIdFTPListOutputItem) : String;
    function UnixBlocksOutput(AItem : TIdFTPListOutputItem) : String;
    function UnixGetOutputOwner(AItem : TIdFTPListOutputItem) : String;
    function UnixGetOutputGroup(AItem : TIdFTPListOutputItem) : String;
    function UnixGetOutputOwnerPerms(AItem : TIdFTPListOutputItem) : String;
    function UnixGetOutputGroupPerms(AItem : TIdFTPListOutputItem) : String;
    function UnixGetOutputOtherPerms(AItem : TIdFTPListOutputItem) : String;

    function GetItems(AIndex: Integer): TIdFTPListOutputItem;
    procedure SetItems(AIndex: Integer; const AValue: TIdFTPListOutputItem);

  public
    function Add: TIdFTPListOutputItem;
    constructor Create; reintroduce;
    function IndexOf(AItem: TIdFTPListOutputItem): Integer;
    property Items[AIndex: Integer]: TIdFTPListOutputItem read GetItems write SetItems; default;

    procedure LISTOutputDir(AOutput : TIdStrings); virtual;
    procedure MLISTOutputDir(AOutput : TIdStrings; AMLstOpts : TIdFTPFactOutputs); virtual;
    procedure NLISTOutputDir(AOutput : TIdStrings); virtual;


    property DirFormat : TIdDirOutputFormat read FDirFormat write FDirFormat;
    property Switches : String read FSwitches write FSwitches;
    property Output : String read FOutput write FOutput;
    property ExportTotalLine : Boolean read FExportTotalLine write FExportTotalLine;
  end;

const
  DEF_FILE_OWN_PERM = 'rw-';                {do not localize}
  DEF_FILE_GRP_PERM = DEF_FILE_OWN_PERM;
  DEF_FILE_OTHER_PERM = 'r--';              {do not localize}
  DEF_DIR_OWN_PERM = 'rwx';                 {do not localize}
  DEF_DIR_GRP_PERM = DEF_DIR_OWN_PERM;
  DEF_DIR_OTHER_PERM = 'r-x';               {do not localize}
  DEF_OWNER = 'root';                       {do not localize}

{NLIST and LIST switches - based on /bin/ls }
{
  Note that the standard Unix form started simply by Unix
  FTP deamons piping output from the /bin/ls program for both
  the NLIST and LIST FTP commands.  The standard /bin/ls
  program has several standard switches that allow the output
  to be customized.  For our output, we wish to emulate this behavior.

  Microsoft IIS even honors a subset of these switches dealing sort order
  and recursive listings.   It does not honor some sort-by-switches although
  we honor those in Win32 (hey, we did MS one better, not that it says much though.

}
const
  {format switches - used by Unix mode only}
  SWITCH_COLS_ACCROSS = 'x';
  SWITCH_COLS_DOWN = 'C';
  SWITCH_ONE_COL = '1';
  SWITCH_ONE_DIR = 'f';
  SWITCH_COMMA_STREAM = 'm';
  SWITCH_LONG_FORM = 'l';
  {recursive for both Win32 and Unix forms}
  SWITCH_RECURSIVE = 'R';
  {sort switches - used both by Win32 and Unix forms}
  SWITCH_SORT_REVERSE = 'r';
  SWITCH_SORTBY_MTIME = 't';
  SWITCH_SORTBY_CTIME = 'u';
  SWITCH_SORTBY_EXT = 'X';
  SWITCH_SORTBY_SIZE = 'S';
  {Output switches for Unix mode only}
  SWITCH_CLASSIFY = 'F';
  //
{     -F  Put aslash (/) aftereach filename if the file is a directory, an
  asterisk (*) if the file is executable, an equal sign(=) if the
  file is an AF_UNIX address family socket, andan ampersand (@) if
  the file is asymbolic link.Unless the -H option isalso used,
  symbolic links are followed to see ifthey might be adirectory; see
  above.

  From:
  http://www.mcsr.olemiss.edu/cgi-bin/man-cgi?ls+1   }
  SWITCH_SLASHDIR = 'p';
  SWITCH_QUOTEDNAME = 'Q';
  SWITCH_PRINT_BLOCKS = 's';
  SWITCH_PRINT_INODE = 'i';
  SWITCH_SHOW_ALLPERIOD = 'a'; //show all entries even ones with a pariod starting the filename/hidden
  //note that anything starting with a period is shown except for the .. and . entries for security reasons
  SWITCH_HIDE_DIRPOINT = 'A'; //hide the "." and ".." entries
  SWITCH_BOTH_TIME_YEAR = 'T'; //This is used by FTP Voyager with a Serv-U FTP Server to both
  //a time and year in the FTP list.  Note that this does conflict with a ls -T flag used to specify a column size
  //on Linux but in FreeBSD, the -T flag is also honored.
implementation

uses
  IdContainers, IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, IdSys;

type
  TDirEntry = class(TObject)
  protected
    FPathName : String;
    FDirListItem : TIdFTPListOutputItem;
    FSubDirs : TIdObjectList;
    FFileList : TIdBubbleSortStringList;

  public
    constructor Create(const APathName : String; ADirListItem : TIdFTPListOutputItem);
    destructor Destroy; override;
//    procedure Sort(ACompare: TIdSortCompare;const Recurse : Boolean = True);
    procedure SortAscendFName;
    procedure SortDescendFName;
    procedure SortAscendMTime;
    procedure SortDescendMTime;
    procedure SortAscendSize;
    procedure SortDescendSize;
    procedure SortAscendFNameExt;
    procedure SortDescendFNameExt;
    function AddSubDir(const APathName : String; ADirEnt : TIdFTPListOutputItem) : Boolean;
    function AddFileName(const APathName : String; ADirEnt : TIdFTPListOutputItem) : Boolean;
    property SubDirs : TIdObjectList read FSubDirs;
    property FileList : TIdBubbleSortStringList read FFileList;
    property PathName : String read FPathName;
    property DirListItem : TIdFTPListOutputItem read FDirListItem;
  end;

function RawSortAscFName(AItem1, AItem2: TObject; const ASubDirs : Boolean = True): Integer;
var LItem1, LItem2 : TIdFTPListItem;
{
> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
< 0 (negative)	Item1 is greater than Item2
}
  LTmpPath1, LTmpPath2 : String;
begin
    LItem1 := TIdFTPListItem(AItem1);
    LItem2 := TIdFTPListItem(AItem2);
    LTmpPath1 := IndyGetFileName( LItem1.FileName );
    LTmpPath2 := IndyGetFileName( LItem2.FileName );
    //periods are always greater then letters in dir lists
    if (Copy(LTmpPath1,1,1)='.') and (Copy(LTmpPath2,1,1)='.') then
    begin
      if (LTmpPath1=CUR_DIR) and (LTmpPath2=PARENT_DIR) then
      begin
        Result := 1;
        Exit;
      end;
      if (LTmpPath2=CUR_DIR) and (LTmpPath1=PARENT_DIR) then
      begin
        Result := -1;
        Exit;
      end;
      if (LTmpPath2=CUR_DIR) and (LTmpPath1=CUR_DIR) then
      begin
        Result := 0;
        Exit;
      end;
      if (LTmpPath2=PARENT_DIR) and (LTmpPath1=PARENT_DIR) then
      begin
        Result := 0;
        Exit;
      end;
    end;
    if (Copy(LTmpPath2,1,1)='.') and (Copy(LTmpPath1,1,1)<>'.') then
    begin
      Result := -1;
      Exit;
    end;
    if (Copy(LTmpPath1,1,1)='.') and (Copy(LTmpPath2,1,1)<>'.') then
    begin
      Result := 1;
      Exit;
    end;
    Result := -IndyCompareStr(LTmpPath1, LTmpPath2);
end;

function RawSortDescFName(AItem1, AItem2: TObject): Integer;
begin
  Result := -RawSortAscFName(AItem1,AItem2);
end;

function RawSortAscFNameExt(AItem1, AItem2: TObject; const ASubDirs : Boolean = True): Integer;
var LItem1, LItem2 : TIdFTPListItem;
{
> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
< 0 (negative)	Item1 is greater than Item2
}
  LTmpPath1, LTmpPath2 : String;
begin
  LItem1 := TIdFTPListItem(AItem1);
  LItem2 := TIdFTPListItem(AItem2);

  LTmpPath1 := Sys.ExtractFileExt(LItem1.FileName);
  LTmpPath2 := Sys.ExtractFileExt(LItem2.FileName);
  Result := -IndyCompareStr(LTmpPath1, LTmpPath2);
  if Result = 0 then
  begin
    Result := RawSortAscFName(AItem1,AItem2);
  end;

end;

function RawSortDescFNameExt(AItem1, AItem2: TObject): Integer;
begin
    Result := -RawSortAscFNameExt(AItem1,AItem2,False);
end;

function RawSortAscMTime(AItem1, AItem2: TObject): Integer;
var LItem1, LItem2 : TIdFTPListItem;
{
> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
< 0 (negative)	Item1 is greater than Item2
}

begin

  LItem1 := TIdFTPListItem(AItem1);
  LItem2 := TIdFTPListItem(AItem2);
  if LItem1.ModifiedDate < LItem2.ModifiedDate then
  begin
    Result := -1;
  end
  else
  begin
    if LItem1.ModifiedDate > LItem2.ModifiedDate then
    begin
      Result := 1;
    end
    else
    begin
      Result := 0;
    end;
  end;
  if Result=0 then
  begin
    Result := RawSortAscFName (AItem1, AItem2);
  end;
end;

function RawSortDescMTime(AItem1, AItem2: TObject): Integer;
begin
  Result := -RawSortAscMTime(AItem1,AItem2);
end;

function RawSortAscSize(AItem1, AItem2: TObject; const ASubDirs : Boolean = True): Integer;
var LItem1, LItem2 : TIdFTPListItem;
    LSize1, LSize2 : Int64;
{
> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
< 0 (negative)	Item1 is greater than Item2
}

begin
  LItem1 := TIdFTPListItem(AItem1);
  LItem2 := TIdFTPListItem(AItem2);
  LSize1 := LItem1.Size;
  LSize2 := LItem2.Size;
  if TIdFTPListOutput(LItem1.Collection).DirFormat = doUnix then
  begin
    if LItem1.ItemType = ditDirectory then
    begin
      LSize1 := UNIX_DIR_SIZE;
    end;
    if LItem2.ItemType = ditDirectory then
    begin
      LSize2 := UNIX_DIR_SIZE;
    end;
  end;
  if LSize1 < LSize2 then
  begin
    Result := -1;
  end
  else
  begin
    if LSize1 > LSize2 then
    begin
      Result := 1;
    end
    else
    begin
      Result := 0;
    end;
  end;
  if Result=0 then
  begin
    Result := RawSortAscFName (AItem1, AItem2);
  end;
end;

function RawSortDescSize(AItem1, AItem2: TObject): Integer;
begin
  Result := -RawSortAscSize(AItem1,AItem2,False);
end;

{DirEntry objects}
function DESortAscFName(AItem1, AItem2: TObject): Integer;
var L1, L2 : TDirEntry;
begin
  L1 := TDirEntry(AItem1);
  L2 := TDirEntry(AItem2);
  Result := -IndyCompareStr(L1.PathName,L2.PathName);
end;

function DESortAscMTime(AItem1, AItem2: TObject): Integer;
var L1, L2 : TIdFTPListItem;   
{
> 0 (positive)	Item1 is less than Item2
   0	Item1 is equal to Item2
< 0 (negative)	Item1 is greater than Item2
}
begin
  L1 := TDirEntry(AItem1).DirListItem;
  L2 := TDirEntry(AItem2).DirListItem;
  if L1.ModifiedDate > L2.ModifiedDate then
  begin
    Result := -1;
  end
  else
  begin
    if L1.ModifiedDate = L2.ModifiedDate then
    begin
      Result := 0;
    end
    else
    begin
      Result := 1;
    end;
  end;
  if Result = 0 then
  begin
    Result := DESortAscFName(AItem1,AItem2);
  end;
end;

function DESortDescMTime(AItem1, AItem2: TObject): Integer;
begin
  Result := -DESortAscMTime(AItem1,AItem2);
end; 


function DESortDescFName(AItem1, AItem2: TObject): Integer;
begin
  Result := -DESortAscFName(AItem1, AItem2);
end;

{stringlist objects}
function StrSortAscMTime(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortAscMTime(L1,L2);
end;

function StrSortDescMTime(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortDescMTime(L1,L2);
end;

function StrSortAscSize(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortAscSize(L1,L2);
end;

function StrSortDescSize(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortDescSize(L1,L2);
end;

function StrSortAscFName(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortAscFName(L1,L2);
end;

function StrSortDescFName(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortDescFName(L1,L2);
end;

function StrSortAscFNameExt(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortAscFNameExt(L1,L2);
end;

function StrSortDescFNameExt(List: TIdStringList; Index1, Index2: Integer): Integer;
var L1, L2 : TIdFTPListItem;
begin
  L1 := TIdFTPListItem(List.Objects[Index1]);
  L2 := TIdFTPListItem(List.Objects[Index2]);
  Result := RawSortDescFNameExt(L1,L2);
end;

{ TIdFTPListOutput }

function TIdFTPListOutput.Add: TIdFTPListOutputItem;
begin
  Result := TIdFTPListOutputItem( inherited Add);
end;

constructor TIdFTPListOutput.Create;
begin
  inherited Create(TIdFTPListOutputItem);
  FDirFormat := doUnix;
end;

function TIdFTPListOutput.EPLFItem(AItem: TIdFTPListOutputItem): String;
var LFileName : String;
begin
  LFileName := IndyGetFileName(AItem.FileName);
  if AItem.ModifiedDateGMT > EPLF_BASE_DATE then
  begin
        Result := '+m'+GMTDateTimeToEPLFDate(AItem.ModifiedDateGMT);
  end
  else
  begin
    if AItem.ModifiedDate > EPLF_BASE_DATE then
    begin
      Result := '+m'+LocalDateTimeToEPLFDate(AItem.ModifiedDate);
    end;
  end;
  if AItem.ItemType = ditFile then
  begin
        Result := Result + ',r';
  end
  else
  begin
        Result := Result + ',/';
  end;
  Result := Result + ',s'+Sys.IntToStr(AItem.Size);
  Result := Result + #9 + LFileName;
end;

function TIdFTPListOutput.GetItems(AIndex: Integer): TIdFTPListOutputItem;
begin
  Result := TIdFTPListOutputItem( inherited GetItem(AIndex));
end;

function TIdFTPListOutput.GetLocalModTime(
  AItem: TIdFTPListOutputItem): TDateTime;
begin
  if AItem.ModifiedDateGMT<>0 then
  begin
    Result := AItem.ModifiedDateGMT - TimeZoneBias;
  end
  else
  begin
    Result := AItem.ModifiedDate;
  end;
end;

function TIdFTPListOutput.IndexOf(AItem: TIdFTPListOutputItem): Integer;
Var
  i: Integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      result := i;
      break;
    end;
end;

procedure TIdFTPListOutput.InternelOutputDir(AOutput: TIdStrings;
  ADetails: Boolean);
type TIdDirOutputType = (doColsAccross, doColsDown, doOneCol, doOnlyDirs, doComma, doLong);

var i : Integer;
//    LIdx : Integer;
//    LBlockCount : Integer;
    //note we use this for sorting pathes with recursive dirs
    LRootPath : TDirEntry;
    LShowNavSym : BOolean;

    function DetermineOp : TIdDirOutputType;
    //we do things this way because the last switch in a mutually exclusive set
    //always takes precidence over the others.
    var
        LStopScan : Boolean;
        i : Integer;
    begin
      if ADetails then
      begin
        Result := doLong;
      end
      else
      begin
        Result := doOneCol;
      end;
      if DirFormat <> doUnix then
      begin
        Exit;
      end;

      LStopScan := False;
      for i := Length(Switches) downto 1 do
      begin
        case Switches[i] of
          SWITCH_COLS_ACCROSS : begin
                  Result := doColsAccross;
                  LStopScan := True;
                end;
          SWITCH_COLS_DOWN : begin
                  Result := doColsDown;
                  LStopScan := True;
                end;
          SWITCH_ONE_COL : begin
                  Result := doOneCol;
                  LStopScan := True;
                end;
          SWITCH_ONE_DIR : begin
                  Result := doOnlyDirs;
                  LStopScan := True;
                end;
          SWITCH_COMMA_STREAM : begin
                  Result := doComma;
                  LStopScan := True;
                end;
          SWITCH_LONG_FORM : begin
                  Result := doLong;
                  LStopScan := True;
                end;
        end;
        if LStopScan then
        begin
          break;
        end;
      end;
    end;

    procedure PrintSubDirHeader(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var LUnixPrependPath : Boolean;
    begin
       LUnixPrependPath := (IndyPos(SWITCH_SORT_REVERSE,Switches)>0) or (IndyPos(SWITCH_SORTBY_MTIME,Switches)>0)
         or (DetermineOp<>doLong);
        if (ACurDir <> ARoot) or LUnixPrependPath then
        begin
          //we don't want an empty line to start the list
          if (ACurDir <> ARoot) then
          begin
            AOutput.Add('');
          end;
          if Self.DirFormat = doWin32 then
          begin
            AOutput.Add(MS_DOS_CURDIR + UnixPathToDOSPath(ACurDir.PathName)+':');
          end
          else
          begin
            if LUnixPrependPath then
            begin
              if ACurDir = ARoot then
              begin
                AOutput.Add(CUR_DIR+':')
              end
              else
              begin
                AOutput.Add(UNIX_CURDIR + DOSPathToUnixPath (ACurDir.PathName)+':');
              end;
            end
            else
            begin
              AOutput.Add(DOSPathToUnixPath (ACurDir.PathName)+':');
            end;
          end;
        end;
    end;

    procedure ProcessOnePathCol(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var i : Integer;
      LCurItem : TIdFTPListOutputItem;
    begin
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        if Recurse then
        begin
          PrintSubDirHeader(ARoot,ACurDir,AOutput,Recurse);
        end;
      end;
      for i := 0 to ACurDir.FileList.Count -1 do
      begin
        AOutput.Add(NListItem(TIdFTPListOutputItem(ACurDir.FileList.Objects[i])));
      end;
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LCurItem := TDirEntry(ACurDir.SubDirs[i]).DirListItem;
          if LCurItem.DirError then
          begin
            if i = 0 then
            begin
              AOutput.Add('');
            end;
            AOutput.Add(Sys.Format('/bin/ls: %s: Permission denied', [LCurItem.FileName])); {do not localize}
          end
          else
          begin
            ProcessOnePathCol(ARoot,TDirEntry(ACurDir.SubDirs[i]),AOutput,Recurse);
          end;
        end;
      end;
    end;

    function CalcMaxLen(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False) : Integer;
    var LEntryMaxLen : Integer;
        i : Integer;
    begin
      Result := 0;
      for i := 0 to ACurDir.FileList.Count -1 do
      begin
        LEntryMaxLen := Length(NListItem(TIdFTPListOutputItem(ACurDir.FileList.Objects[i])) );
        if LEntryMaxLen > Result then
        begin
          Result := LEntryMaxLen;
        end;
      end;
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LEntryMaxLen := CalcMaxLen(ARoot,TDirEntry(ACurDir.SubDirs[i]),AOutput,Recurse);
          if LEntryMaxLen > Result then
          begin
            Result := LEntryMaxLen;
          end;
        end;
      end;
    end;

    procedure ProcessPathAccross(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var i, j : Integer;
        LTmp : String;
        LMaxLen : Integer;
        LCols : Integer;
        LCurItem : TIdFTPListOutputItem;
    begin
      if ACurDir.FileList.Count = 0 then
      begin
        Exit;
      end;
    //Note that we will assume a console width of 80 and we don't want something to wrap
    //causing a blank line
      LMaxLen := CalcMaxLen(ARoot, ACurDir, AOutput, Recurse);
      //if more than 39, we probably are going to exceed the width of the screen,
      //just treat as one column
      if (LMaxLen > 39) then
      begin
        ProcessOnePathCol(ARoot, ACurDir, AOutput, Recurse);
        Exit;
      end;
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        if Recurse then
        begin
          PrintSubDirHeader(ARoot,ACurDir,AOutput,Recurse);
        end;
      end;
      LCols := 79 div (LMaxLen + 2);//2 spaces between columns
      j := 0;
      repeat
        LTmp := '';
        for i := 0 to LCols -1 do
        begin
          LTmp := LTmp + PadSpaces(NListItem(TIdFTPListOutputItem(ACurDir.FileList.Objects[j])),LMaxLen)+'  ';
          Inc(j);
          if j = ACurDir.FileList.Count then
          begin
            Break;
          end;
        end;
        AOutput.Add(Sys.TrimRight(LTmp));
      until (j = ACurDir.FileList.Count);

      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LCurItem := TDirEntry(ACurDir.SubDirs[i]).DirListItem;
          if LCurItem.DirError then
          begin
            if i = 0 then
            begin
              AOutput.Add('');
            end;
            AOutput.Add(Sys.Format('/bin/ls: %s: Permission denied', [LCurItem.FileName])); {do not localize}
          end
          else
          begin
            ProcessPathAccross(ARoot, TDirEntry(ACurDir.SubDirs[i]), AOutput, Recurse);
          end;
        end;
      end;
    end;

    procedure ProcessPathDown(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var i, j : Integer;
        LTmp : String;
        LMaxLen : Integer;
        LCols : Integer;
        LLines : Integer;
        LFrm : String;
        LCurItem : TIdFTPListOutputItem;
    begin
      LFrm := '';
      if ACurDir.FileList.Count = 0 then
      begin
        Exit;
      end;
    //Note that we will assume a console width of 80 and we don't want something to wrap
    //causing a blank line
      LMaxLen := CalcMaxLen(ARoot, ACurDir, AOutput, Recurse);
      //if more than 39, we probably are going to exceed the width of the screen,
      //just treat as one column
      if (LMaxLen > 39) then
      begin
        ProcessOnePathCol(ARoot, ACurDir, AOutput, Recurse);
        Exit;
      end;
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        if Recurse then
        begin
          PrintSubDirHeader(ARoot,ACurDir,AOutput,Recurse);
        end;
      end;
      LCols := 79 div (LMaxLen + 2);//2 spaces between columns
      LLines := ACurDir.FileList.COunt div LCols;
      LFrm := '%'+Sys.IntToStr(LMaxLen+2)+'s';
      if (ACurDir.FileList.COunt mod LCols >0) then
      begin
        Inc(LLines);
      end;
      for i := 1 to LLines do
      begin
        j := 0;
        LTmp := '';
        repeat
          if (i-1)+(LLInes*j) < ACurDir.FileList.Count then
          begin
            LTmp := LTmp + PadSpaces(NListItem(TIdFTPListOutputItem(ACurDir.FileList.Objects[(i-1)+(LLInes*j)])),LMaxLen)+ '  ';
          end;
          Inc(j);
        until (j > LCols);
        AOutput.Add(Sys.TrimRight(LTmp));
      end;
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LCurItem := TDirEntry(ACurDir.SubDirs[i]).DirListItem;
          if LCurItem.DirError then
          begin
            if i = 0 then
            begin
              AOutput.Add('');
            end;
            AOutput.Add(Sys.Format('/bin/ls: %s: Permission denied', [LCurItem.FileName])); {do not localize}
          end
          else
          begin
            ProcessPathAccross(ARoot, TDirEntry(ACurDir.SubDirs[i]), AOutput, Recurse);
          end;
        end;
      end;
    end;

    procedure ProcessPathComma(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var i : Integer;
      LTmp : String;
      LCurItem : TIdFTPListOutputItem;
    begin
      if Recurse then
      begin
        PrintSubDirHeader(ARoot,ACurDir,AOutput,Recurse);
      end;
      LTmp := '';
      for i := 0 to ACurDir.FileList.Count -1 do
      begin
          LTmp := LTmp + NListItem(TIdFTPListOutputItem(ACurDir.FileList.Objects[i])) +
            ', ';
      end;
      IdDelete(LTmp,Length(LTmp)-1,2);
      AOutput.Text := AOutput.Text + WrapText(LTmp);
      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LCurItem := TDirEntry(ACurDir.SubDirs[i]).DirListItem;
          if LCurItem.DirError then
          begin
            if i = 0 then
            begin
              AOutput.Add('');
            end;
            AOutput.Add(Sys.Format('/bin/ls: %s: Permission denied', [LCurItem.FileName])); {do not localize}
          end
          else
          begin
            ProcessPathComma(ARoot, TDirEntry(ACurDir.SubDirs[i]), AOutput, Recurse);
          end;
        end;
      end;
    end;

    procedure ProcessPathLong(ARoot, ACurDir : TDirEntry; AOutput : TIdStrings; const Recurse : Boolean = False);
    var i : Integer;
      LBlockCount : Integer;
      LCurItem : TIdFTPListOutputItem;
    begin
      if Recurse then
      begin
        PrintSubDirHeader(ARoot,ACurDir,AOutput,Recurse);
      end;
        if (DirFormat = doUnix) and ExportTotalLine then
        begin
          LBlockCount := 0;
          for i := 0 to ACurDir.FileList.Count -1 do
          begin
            LBlockCount := LBlockCount +
              TIdFTPListOutputItem(ACurDir.FileList.Objects[i]).NumberBlocks;
          end;
          AOutput.Add(Sys.Format('total %d',[LBlockCount]));  {Do not translate}
        end;

        for i := 0 to ACurDir.FileList.Count -1 do
        begin
          LCurItem := TIdFTPListOutputItem(ACurDir.FileList.Objects[i]);
          case DirFormat of
            doEPLF : AOutput.Add(Self.EPLFItem(LCurItem));
            doWin32 : AOutput.Add(Self.Win32Item (LCurItem));
          else
            AOutput.Add(Self.UnixItem (LCurItem));
          end;
        end;

      if Recurse and Assigned(ACurDir.SubDirs) then
      begin
        for i := 0 to ACurDir.SubDirs.Count -1 do
        begin
          LCurItem := TDirEntry(ACurDir.SubDirs[i]).DirListItem;
          if LCurItem.DirError then
          begin
            if DirFormat = doUnix then
            begin
              if i = 0 then
              begin
                AOutput.Add('');
              end;
              AOutput.Add(Sys.Format('/bin/ls: %s: Permission denied', [LCurItem.FileName])); {do not localize}
            end;
          end
          else
          begin
            ProcessPathLong(ARoot, TDirEntry(ACurDir.SubDirs[i]), AOutput, Recurse);
          end;
        end;
      end;
    end;

    procedure DoUnixfParam(ARoot : TDirEntry; AOutput : TIdStrings);
    var i : Integer;
        LI : TIdFTPListItem;
    begin
      for i := 0 to ARoot.FileList.Count -1 do
      begin
        LI := TIdFTPListItem(ARoot.FileList.Objects[i]);
        if LI.ItemType = ditDirectory then
        begin
          AOutput.Add( IndyGetFileName(LI.FileName));
        end;
      end;
    end;

begin
  LShowNavSym := (DirFormat=doUnix) and
    (IndyPos(SWITCH_SHOW_ALLPERIOD,Switches)>0);
  if LShowNavSym then
  begin
    LShowNavSym := (IndyPos(SWITCH_HIDE_DIRPOINT,Switches)=0);
  end;
  LRootPath := TDirEntry.Create('',nil);
  try
    for i := 0 to Count -1 do
    begin
      if (Items[i].ItemType in [ditDirectory,ditSymbolicLinkDir])  then
      begin
        if IsNavPath(StripInitPathDelin(IndyGetFileName( Items[i].FileName)))=False then
        begin
          LRootPath.AddSubDir(StripInitPathDelin(Items[i].FileName),Items[i]);
        end
        else
        begin
          //if it's a "." or "..", we show it only in Unix mode and only with eht -a switch
          if LShowNavSym then
          begin
            LRootPath.AddFileName(StripInitPathDelin(Items[i].FileName),Items[i]);
          end;
        end;
      end;
    end;
    //add the file names
    for i := 0 to Count -1 do
    begin
      if (Items[i].ItemType in [ditFile, ditSymbolicLink]) then
      begin
        if IsNavPath(StripInitPathDelin(IndyGetFileName( Items[i].FileName))) then
        begin
          if LShowNavSym then
          begin
            LRootPath.AddFileName(StripInitPathDelin(Items[i].FileName),Items[i]);
          end;
        end
        else
        begin
          LRootPath.AddFileName(StripInitPathDelin(Items[i].FileName),Items[i]);
        end;
      end;
    end;
    //Note that Indy does not support a Last Access time in some file systems
    //so we use the u parameter to mean the same as the t parameter
    if IndyPos(SWITCH_SORT_REVERSE,Switches)>0 then
    begin
      if (IndyPos(SWITCH_SORTBY_MTIME,Switches)>0) or (IndyPos(SWITCH_SORTBY_CTIME,Switches)>0) then
      begin
        LRootPath.SortDescendMTime;
      end
      else
      begin
        if (IndyPos(SWITCH_SORTBY_EXT, Switches)>0) then
        begin
          LRootPath.SortDescendFNameExt;
        end
        else
        begin
          if (IndyPos(SWITCH_SORTBY_SIZE, Switches)>0) then
          begin
            LRootPath.SortDescendSize;
          end
          else
          begin
            LRootPath.SortDescendFName;
          end;
        end;
      end;
    end
    else
    begin
      if (IndyPos(SWITCH_SORTBY_MTIME,Switches)>0) or (IndyPos(SWITCH_SORTBY_CTIME,Switches)>0) then
      begin
        LRootPath.SortAscendMTime;
      end
      else
      begin
        if (IndyPos(SWITCH_SORTBY_EXT, Switches)>0) then
        begin
          LRootPath.SortAscendFNameExt;
        end
        else
        begin
          if (IndyPos(SWITCH_SORTBY_SIZE, Switches)>0) then
          begin
            LRootPath.SortAscendSize;
          end
          else
          begin
            LRootPath.SortAscendFName;
          end;
        end;
      end;
    end;
    //select the operation
    // do the selected output operation
    case DetermineOp of
      doColsAccross : ProcessPathAccross(LRootPath,LRootPath,AOutput, IndyPos(SWITCH_RECURSIVE,Switches)>0 );
      doColsDown : ProcessPathDown(LRootPath,LRootPath,AOutput, IndyPos(SWITCH_RECURSIVE,Switches)>0 );
      doOneCol   : ProcessOnePathCol(LRootPath,LRootPath,AOutput, IndyPos(SWITCH_RECURSIVE,Switches)>0 );
      doOnlyDirs : DoUnixfParam(LRootPath,AOutput);
      doComma :  ProcessPathComma(LRootPath,LRootPath,AOutput, IndyPos(SWITCH_RECURSIVE,Switches)>0 );
    else
      ProcessPathLong(LRootPath,LRootPath,AOutput, IndyPos(SWITCH_RECURSIVE,Switches)>0 );
    end;
  finally
    Sys.FreeAndNil(LRootPath);
  end;
end;

procedure TIdFTPListOutput.LISTOutputDir(AOutput: TIdStrings);
begin
  InternelOutputDir(AOutput,True);
end;

function TIdFTPListOutput.MListItem(AItem: TIdFTPListOutputItem;
  AMLstOpts: TIdFTPFactOutputs): String;
begin
  if AMLstOpts <> [] then
  begin
    if Size in AMLstOpts then  {do not localize}
    begin
      Result := 'size=' + Sys.IntToStr(AItem.Size) + ';'; {do not localize}
    end;

    if ItemType in AMLstOpts then  {do not localize}
    begin
      Result := Result + 'type='; {do not localize}
      case AItem.ItemType of
        ditFile : Result := Result + 'file;'; {do not localize}
        ditDirectory :
        begin
          if (AItem.FileName = '..') then {do not localize}
          begin
            Result := Result + 'pdir;'; {do not localize}
          end
          else
          begin
            if (AItem.FileName = '.') then
            begin
              Result := Result + 'cdir;'; {do not localize}
            end
            else
            begin
            Result := Result + 'dir;';  {do not localize}
            end;
          end;
        end;
        ditSymbolicLink :
          Result := Result + 'OS.unix=slink:' + AItem.FileName + ';';  {do not localize}
      end;
    end;

    if Perm in AMLstOpts then  {do not localize}
    begin
      Result := Result + 'perm=' + AItem.MLISTPermissions + ';';  {do not localize}
    end;

    if CreateTime in AMLstOpts then  {do not localize}
    begin
      if AItem.CreationDateGMT<>0 then
      begin
        Result := Result + 'create='+ FTPGMTDateTimeToMLS(AItem.CreationDateGMT ) + ';';  {do not localize}
      end
      else
      begin
        if AItem.CreationDate<>0 then
        begin
          Result := Result + 'create='+ FTPLocalDateTimeToMLS(AItem.CreationDate ) + ';';  {do not localize}
        end;
      end;
    end;

    if Modify in AMLstOpts then  {do not localize}
    begin
      if AItem.ModifiedDateGMT<>0 then
      begin
        Result := Result + 'modify='+  FTPGMTDateTimeToMLS(AItem.ModifiedDateGMT ) + ';';  {do not localize}
      end
      else
      begin
        if AItem.ModifiedDate<>0 then
        begin
          Result := Result + 'modify='+ FTPLocalDateTimeToMLS(AItem.ModifiedDate) + ';';  {do not localize}
        end;
      end;
    end;
    if UnixMODE in AMLstOpts then {do not localize}
    begin
      Result := Result + 'UNIX.mode='+ Sys.Format('%.4d', [PermsToChmodNo(UnixGetOutputOwnerPerms(AItem), UnixGetOutputGroupPerms(AItem), UnixGetOutputOtherPerms(AItem) )] ) + ';';  {do not localize}
    end;
    if UnixOwner in AMLstOpts then  {do not localize}
    begin
      Result := Result + 'UNIX.owner=' + UnixGetOutputOwner(AItem) + ';'; {do not localize}
    end;
    if UnixGroup in AMLstOpts then  {do not localize}
    begin
      Result := Result + 'UNIX.group=' + UnixGetOutputGroup(AItem) + ';'; {do not localize}
    end;
    if Unique in AMLstOpts then
    begin
      if AItem.UniqueID <> '' then
      begin
        Result := Result + 'unique=' + AItem.UniqueID+';'; {do not localize}
      end;
    end;

    if LastAccessTime in AMLstOpts then  {do not localize}
    begin
      if AItem.ModifiedDateGMT<>0 then
      begin
        Result := Result + 'windows.lastaccesstime='+  FTPGMTDateTimeToMLS(AItem.ModifiedDateGMT ) + ';';  {do not localize}
      end
      else
      begin
        if AItem.ModifiedDate<>0 then
        begin
          Result := Result + 'windows.lastaccesstime='+ FTPLocalDateTimeToMLS(AItem.ModifiedDate) + ';';  {do not localize}
        end;
      end;
    end;
    Result := Result + ' ' + AItem.FileName;
  end
  else
  begin
    Result := AItem.FileName;
  end;
end;

procedure TIdFTPListOutput.MLISTOutputDir(AOutput : TIdStrings; AMLstOpts: TIdFTPFactOutputs);
var i : Integer;
begin
  AOutput.Clear;
  for i := 0 to Count -1 do
  begin
    AOutput.Add(MListItem(Items[i],AMLstOpts));
  end;
end;

function TIdFTPListOutput.NListItem(AItem: TIdFTPListOutputItem): String;
begin
  Result := IndyGetFileName(AItem.FileName);
  case Self.DirFormat of

    doUnix : begin
      if (IndyPos(SWITCH_QUOTEDNAME,Switches) >0) then
      begin
        Result := '"'+Result+'"';
      end;
      if (IndyPos(SWITCH_CLASSIFY,Switches)>0) or (IndyPos(SWITCH_SLASHDIR,Switches)>0) then
      begin
        case AItem.ItemType of
        ditDirectory : Result := Result + PATH_SUBDIR_SEP_UNIX;
        ditSymbolicLink, ditSymbolicLinkDir : Result := Result + '@';
        else
          if IsUnixExec(AItem.UnixOwnerPermissions, AItem.UnixGroupPermissions , AItem.UnixOtherPermissions) then
          begin
            Result := Result + '*';
          end;
        end;
      end;
      Result := UnixinodeOutput(AItem)+ UnixBlocksOutput(AItem)+ Result;
    end;
  end;
end;

procedure TIdFTPListOutput.NLISTOutputDir(AOutput: TIdStrings);
begin
  InternelOutputDir(AOutput,False);
end;

procedure TIdFTPListOutput.SetItems(AIndex: Integer;
  const AValue: TIdFTPListOutputItem);
begin
  inherited Items[AIndex] := AValue;
end;

function TIdFTPListOutput.UnixBlocksOutput(AItem: TIdFTPListOutputItem): String;
begin
  Result := '';
  if IndyPos(SWITCH_PRINT_BLOCKS,Switches)>0 then
  begin
    Result := Result + Sys.Format('%4d ',[ AItem.NumberBlocks ]);
  end;
end;

function TIdFTPListOutput.UnixGetOutputGroup(
  AItem: TIdFTPListOutputItem): String;
begin
  if AItem.GroupName = '' then
  begin
    Result := UnixGetOutputOwner(AItem);
  end
  else
  begin
    Result := AItem.GroupName;
  end;
end;

function TIdFTPListOutput.UnixGetOutputGroupPerms(
  AItem: TIdFTPListOutputItem): String;
begin
  if AItem.UnixOtherPermissions = '' then
  begin
    if AItem.ItemType in [ditSymbolicLink, ditSymbolicLinkDir] then
    begin
      Result := DEF_DIR_GRP_PERM;
    end
    else
    begin
      Result := DEF_FILE_GRP_PERM;
    end;
  end
  else
  begin
    Result := AItem.UnixOtherPermissions;
  end;
end;

function TIdFTPListOutput.UnixGetOutputOtherPerms(
  AItem: TIdFTPListOutputItem): String;
begin
  if AItem.UnixOtherPermissions = '' then
  begin
    if AItem.ItemType in [ditSymbolicLink, ditSymbolicLinkDir] then
    begin
      Result := DEF_DIR_OTHER_PERM;
    end
    else
    begin
      Result := DEF_FILE_OTHER_PERM
    end;
  end
  else
  begin
    Result := AItem.UnixOtherPermissions;
  end;
end;

function TIdFTPListOutput.UnixGetOutputOwner(
  AItem: TIdFTPListOutputItem): String;
begin
  if AItem.OwnerName = '' then
  begin
    Result := DEF_OWNER;
  end
  else
  begin
    Result := AItem.OwnerName;
  end;
end;

function TIdFTPListOutput.UnixGetOutputOwnerPerms(
  AItem: TIdFTPListOutputItem): String;
begin
  if AItem.UnixOwnerPermissions = '' then
  begin
    if AItem.ItemType in [ditSymbolicLink, ditSymbolicLinkDir] then
    begin
      Result := DEF_DIR_OWN_PERM
    end
    else
    begin
      Result := DEF_FILE_OWN_PERM;
    end;
  end
  else
  begin
    Result := AItem.UnixOwnerPermissions;
  end;
end;

function TIdFTPListOutput.UnixINodeOutput(AItem: TIdFTPListOutputItem): String;
var LInode : String;
begin
  Result := '';
  if IndyPos(SWITCH_PRINT_INODE,Switches)>0 then
  begin
    LInode := Sys.IntToStr(Abs(AItem.Inode));
    //should be no more than 10 digits
    LInode := Copy(LInode,1,10);
    Result := Result + Sys.Format('%10s ',[ LInode ]);
  end;
end;

function TIdFTPListOutput.UnixItem(AItem: TIdFTPListOutputItem): String;
var
  LSize, LTime: string;
  l, month: Word;
  LLinkNum : Integer;
  LFileName : String;
  LFormat : String;
  LMTime : TDateTime;
begin

  LFileName := IndyGetFileName(AItem.FileName);
  Result := '';

  Result := Result + UnixINodeOutput(AItem);
  Result := Result + UnixBlocksOutput(AItem);
  LSize := '-';    {Do not Localize}
  case AItem.ItemType of
    ditDirectory: begin
      AItem.Size := UNIX_DIR_SIZE;
      LSize := 'd';    {Do not Localize}
    end;
    ditSymbolicLink: LSize := 'l';    {Do not Localize}
  end;
  if AItem.LinkCount = 0 then
  begin
    LLinkNum := 1;
  end
  else
  begin
    LLinkNum := AItem.LinkCount;
  end;
  LFormat := '%3:3s%4:3s%5:3s %6:3d '; {Do not localize}
  //g - surpress owner
  //lrwxrwxrwx   1 other          7 Nov 16  2001 bin -> usr/bin
  //where it would normally print
  //lrwxrwxrwx   1 root     other          7 Nov 16  2001 bin -> usr/bin
  if (IndyPos('g',Switches)=0) then
  begin
    LFormat := LFormat + '%1:-8s '; {Do not localize}
  end;
  //o - surpress group
  //lrwxrwxrwx   1 root           7 Nov 16  2001 bin -> usr/bin
  //where it would normally print
  //lrwxrwxrwx   1 root     other          7 Nov 16  2001 bin -> usr/bin
  if (IndyPos('o',Switches)=0) then
  begin
    LFormat := LFormat + '%2:-8s ';  {Do not localize}
  end;
  LFormat := LFormat + '%0:8d'; {Do not localize}
  LSize := LSize + Sys.Format(LFormat
       , [AItem.Size, UnixGetOutputOwner(AItem), UnixGetOutputGroup(AItem), UnixGetOutputOwnerPerms(AItem), UnixGetOutputGroupPerms(AItem), UnixGetOutputOtherPerms(AItem),LLinkNum]);
  LMTime := GetLocalModTime(AItem);
  Sys.DecodeDate(LMTime, l, month, l);
  LTime := MonthNames[month] + Sys.FormatDateTime(' dd', LMTime);    {Do not Localize}
  if (IndyPos(SWITCH_BOTH_TIME_YEAR,Switches)>0) then
  begin
    LTime := LTime + Sys.FormatDateTime(' hh:nn:ss yyyy', AItem.ModifiedDate);    {Do not Localize}
  end
  else
  begin
    if IsIn6MonthWindow(LMTime) then begin    {Do not Localize}
      LTime := LTime + Sys.FormatDateTime(' hh:nn', LMTime);    {Do not Localize}
    end else begin
      LTime := LTime + Sys.FormatDateTime('  yyyy', LMTime);    {Do not Localize}
    end;
  end;
  // A.Neillans, 20 Apr 2002, Fixed glitch, extra space in front of names.
  //      Result := LSize + ' ' + LTime + '  ' + FileName;    {Do not Localize}
  Result := Result + LSize + ' ' + LTime + ' ';
  if (IndyPos(SWITCH_QUOTEDNAME,Switches)>0) then
  begin
    Result := Result + '"'+LFileName+'"';
  end
  else
  begin
    Result := Result + LFileName;    {Do not Localize}
  end;
  if AItem.ItemType in [ditSymbolicLink, ditSymbolicLinkDir] then
  begin
    if (IndyPos(SWITCH_QUOTEDNAME,Switches)>0) then
    begin
      Result := Result + UNIX_LINKTO_SYM + '"'+AItem.LinkedItemName+'"';
    end
    else
    begin
      Result := Result + UNIX_LINKTO_SYM + AItem.LinkedItemName;
    end;
  end;
  if ((IndyPos(SWITCH_CLASSIFY,Switches)>0) or (IndyPos(SWITCH_SLASHDIR,Switches)>0)) and  {Do not translate}
        (AItem.ItemType in [ditDirectory, ditSymbolicLinkDir]) then
  begin
    Result := Result + PATH_SUBDIR_SEP_UNIX;
  end;
  if (IndyPos(SWITCH_CLASSIFY,Switches)>0) and  {Do not translate}
        (AItem.ItemType = ditFile) and
         IsUnixExec( UnixGetOutputOwnerPerms(AItem), UnixGetOutputGroupPerms(AItem), UnixGetOutputOtherPerms(AItem)) then
  begin
    //star is placed at the end of a file name
    //like this:
    //-r-xr-xr-x   1 0        1          17440 Aug  8  2000 ls*
    Result := Result + '*';
  end;
end;

function TIdFTPListOutput.Win32Item(AItem: TIdFTPListOutputItem): String;
var LSize, LFileName : String;
begin
  LFileName := IndyGetFileName(AItem.FileName);
  if AItem.ItemType = ditDirectory then begin
    LSize := '      ' + '<DIR>' + StringOfChar(' ', 9);    {Do not Localize}
  end else begin
    LSize := StringOfChar(' ', 20 - Length(Sys.IntToStr(AItem.Size))) + Sys.IntToStr(AItem.Size);    {Do not Localize}
  end;
  Result := Sys.FormatDateTime('mm-dd-yy  hh:nnAM/PM', GetLocalModTime( AItem) ) + ' ' + LSize    {Do not Localize}
       + ' ' + LFileName;    {Do not Localize}
end;


{ TDirEntry }

function TDirEntry.AddFileName(const APathName: String;
  ADirEnt: TIdFTPListOutputItem) : Boolean;
var i : Integer;
  LParentPart : String;
  LDirEnt : TDirEntry;
begin
  Result := False;
  LParentPart := StripInitPathDelin(IndyGetFilePath(APathName));
//  LParentPart := IndyGetFileName(LParentPart);
  if LParentPart = PathName then
  begin

    if FFileList.IndexOf(APathName)=-1 then
    begin
      FFileList.AddObject(APathName,ADirEnt);
    end;
    Result := True;
  end
  else
  begin
    if Assigned( SubDirs) then
    begin
      for i := 0 to SubDirs.Count -1 do
      begin
        LDirEnt := TDirEntry(SubDirs[i]);
        LParentPart := StripInitPathDelin( IndyGetFilePath(LDirEnt.FDirListItem.FileName));
        if Copy(APathName,1, Length(LParentPart))=
          LParentPart then
        begin

          if TDirEntry(SubDirs[i]).AddFileName(APathName,ADirEnt) then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TDirEntry.AddSubDir(const APathName: String;
  ADirEnt: TIdFTPListOutputItem) : Boolean;
var LDirEnt : TDirEntry;
   i : Integer;
   LParentPart : String;
begin
  Result := False;
  LParentPart := StripInitPathDelin(IndyGetFilePath(APathName));
  if LParentPart = PathName then
  begin
    if Assigned(FSubDirs)=False then
    begin
      FSubDirs := TIdObjectList.Create;
    end;
    LParentPart := StripInitPathDelin( IndyGetFilePath(APathName));
    LParentPart := IndyGetFileName(LParentPart);
    LDirEnt := TDirEntry.Create(APathName,ADirEnt);
    FSubDirs.Add(LDirEnt);
    AddFileName(APathName, ADirEnt);
    Result := True;
  end
  else
  begin
    if Assigned(SubDirs) then
    begin
      for i := 0 to SubDirs.Count -1 do
      begin
        LDirEnt := TDirEntry(SubDirs[i]);
        LParentPart := StripInitPathDelin( IndyGetFilePath(LDirEnt.FDirListItem.FileName));
      //  if Copy(APathName,1, Length(LParentPart))=
      //    LParentPart then
        if Copy(APathName,1, Length(LParentPart))=
          LParentPart then
        begin
          if LDirEnt.AddSubDir(APathName,ADirEnt) then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;



constructor TDirEntry.Create(const APathName : String; ADirListItem : TIdFTPListOutputItem);
begin
  inherited Create;
  FPathName := APathName;
  FFileList := TIdBubbleSortStringList.Create;
  FDirListItem := ADirListItem;
  //create that only when necessary;
  FSubDirs := TIdObjectList.Create;
end;

destructor TDirEntry.Destroy;
begin
  Sys.FreeAndNil( FFileList );
  Sys.FreeAndNil( FSubDirs );
  inherited;
end;

procedure TDirEntry.SortAscendFName;
var i : Integer;
begin
  if Assigned(FFileList) then
  begin
    FFileList.BubbleSort(StrSortAscFName);
  end;
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortAscFName);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortAscendFName;
    end;
  end;
end;

procedure TDirEntry.SortAscendMTime;
var i : Integer;
begin
  FFileList.BubbleSort(StrSortAscMTime);
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortAscMTime);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortAscendMTime;
    end;
  end;
end;

procedure TDirEntry.SortDescendMTime;
var i : Integer;
begin
  FFileList.BubbleSort(StrSortDescMTime);
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortDescMTime);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortDescendMTime;
    end;
  end;
end;

procedure TDirEntry.SortDescendFName;
var i : Integer;
begin
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortDescFName);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortDescendFName;
    end;
  end;
  FFileList.BubbleSort(StrSortDescFName);

end;

procedure TDirEntry.SortAscendFNameExt;
var i : Integer;
begin
  if Assigned(FFileList) then
  begin
    FFileList.BubbleSort(StrSortAscFNameExt);
  end;
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortAscFName);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortAscendFNameExt;
    end;
  end;
end;

procedure TDirEntry.SortDescendFNameExt;
var i : Integer;
begin
  if Assigned(FFileList) then
  begin
    FFileList.BubbleSort(StrSortDescFNameExt);
  end;
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortAscFName);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortDescendFNameExt;
    end;
  end;
end;

procedure TDirEntry.SortAscendSize;
var i : Integer;
begin
  FFileList.BubbleSort(StrSortAscSize);
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortAscMTime);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortAscendSize;
    end;
  end;
end;

procedure TDirEntry.SortDescendSize;
var i : Integer;
begin
  FFileList.BubbleSort(StrSortDescSize);
  if Assigned(FSubDirs) then
  begin
    FSubDirs.BubbleSort(DESortDescFName);
    for i := 0 to FSubDirs.Count -1 do
    begin
      TDirEntry(FSubDirs[i]).SortDescendSize ;
    end;
  end;
end;

end.
