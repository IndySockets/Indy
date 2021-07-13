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
  Rev 1.23    3/23/2005 4:52:28 AM  JPMugaas
  Expansion with MLSD and WIN32.ea fact in MLSD directories as described by:

  http://www.raidenftpd.com/kb/kb000000049.htm

  This returns Win32 file attributes including some that Borland does not
  support.

  Rev 1.22    2/23/2005 6:34:30 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.21    2/4/2005 12:00:50 PM  JPMugaas
  Switched from TObjectList to TList for the parsing registration list.

  Rev 1.20    2/3/2005 11:05:14 PM  JPMugaas
  Fix for compiler warnings.

  Rev 1.19    12/8/2004 5:34:02 PM  JPMugaas
  Added method for getting all of the identifiers for the parsing classes for
  ego purposes only :-).

  Rev 1.18    12/8/2004 8:35:18 AM  JPMugaas
  Minor class restructure to support Unisys ClearPath.

  Rev 1.17    11/29/2004 2:45:28 AM  JPMugaas
  Support for DOS attributes (Read-Only, Archive, System, and Hidden) for use
  by the Distinct32, OS/2, and Chameleon FTP list parsers.

  Rev 1.16    11/5/2004 1:17:26 AM  JPMugaas
  Now also should support sizd fact in some dir listings on PureFTPD.

  Rev 1.15    10/26/2004 9:27:32 PM  JPMugaas
  Updated references.

  Rev 1.14    6/27/2004 1:45:36 AM  JPMugaas
  Can now optionally support LastAccessTime like Smartftp's FTP Server could.
  I also made the MLST listing object and parser support this as well.

    Rev 1.13    6/11/2004 9:35:00 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.12    6/7/2004 7:38:42 PM  JPMugaas
  Fixed bug that appears in some descendant classes.  TIdFTPListBaseHeader
  would only call ADir.Add.  If a descendant is using it's own descendant of
  the TIdFTPListItem class for special properties, that would cause an invalid
  typecast error.  It now calls MakeNewItem so that a descendant can override
  the item creation to make it's own TIdFTPListItem descendant.

  Rev 1.11    6/5/2004 3:04:12 PM  JPMugaas
  In MLST format, we now indicate if Size is available  for item.   One version
  of NcFTP will omit that for directories.  Confirmed at ftp.borland.com.  I
  also did the same for Modified Date if MLST doesn't provide it.

  Rev 1.10    4/19/2004 5:05:12 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.9    2004.02.03 5:45:14 PM  czhower
  Name changes

  Rev 1.8    11/26/2003 6:22:18 PM  JPMugaas
  IdFTPList can now support file creation time for MLSD servers which support
  that feature.  I also added support for a Unique identifier for an item so
  facilitate some mirroring software if the server supports unique ID with EPLF
  and MLSD.

    Rev 1.7    10/19/2003 2:27:02 PM  DSiders
  Added localization comments.

  Rev 1.6    10/6/2003 08:58:00 PM  JPMugaas
  Reworked the FTP list parsing framework so that the user can obtain the list
  of capabilities from a parser class with TIdFTP.  This should permit the user
  to present a directory listing differently for each parser (some FTP list
  parsers do have different capabilities).

  Rev 1.5    4/7/2003 04:03:06 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.4    3/3/2003 04:23:18 PM  JPMugaas
  Fix for a stack overflow.  stupid mistake really.  Procedure kept calling
  itself.

  Rev 1.3    2/23/2003 06:08:16 AM  JPMugaas

  Rev 1.2    2/21/2003 06:54:22 PM  JPMugaas
  The FTP list processing has been restructured so that Directory output is not
  done by IdFTPList.  This now also uses the IdFTPListParserBase for parsing so
  that the code is more scalable.

  Rev 1.1    2/19/2003 05:53:10 PM  JPMugaas
  Minor restructures to remove duplicate code and save some work with some
  formats.  The Unix parser had a bug that caused it to give a False positive
  for Xercom MicroRTOS.

  Rev 1.0    2/18/2003 07:00:30 PM  JPMugaas
  Base class for new parsing framework.
}

unit IdFTPListParseBase;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdException;

type
  //We don't want to create instances of these classes and
  //these classes should not contain variables accross procedures
  //because they may run in threads.
  TIdFTPListBase = class(TObject)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; virtual;
    //This is probably going to be a commonly used thing so it may be best to define it here.
    //This is for parsing an individual line of data using AItem.Data
    //AItem is the item that was already created
    //APath should probably be a path passed to the parser for qualitying the filename and should
    //used only for recursive lists
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; virtual;
  public
    //This should return a unique string indicating the type of format the parser supports
    class function GetIdent : String; virtual;
    //This determines if the parser is appropriate and returns True if it is or False if another parser
    //should be used
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; virtual;
    //This parses the AListing and fills in the ADir object
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : boolean; virtual;
  end;

  TIdFTPListParseClass = class of TIdFTPListBase;

  //these are anscestors for some listings with a heading
  TIdFTPListBaseHeader = class(TIdFTPListBase)
  protected
    class function IsHeader(const AData : String): Boolean; virtual;
    class function IsFooter(const AData : String): Boolean; virtual;
  public
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : boolean; override;
  end;
  //these are anscestors for some listings with an optional heading
   TIdFTPListBaseHeaderOpt = class(TIdFTPListBaseHeader)
   protected
    class function CheckListingAlt(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; virtual;
   public
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
   end;
  //base class for line-by-line items where there is a file owner along with mod date and file size
  TIdFTPLineOwnedList = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  end;

  //These two parsers are manditory for the FTP Protocol
  TIdFTPLPNList = class(TIdFTPListBase)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  TIdFTPLPMList = class(TIdFTPListBase)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  //these are for some MS-DOS, OS/2, and Windows servers that report Attributes
  //in their listings
  TIdFTPLPBaseDOS = class(TIdFTPListBase)
  protected
    class function IsValidAttr(const AAttr : String) : Boolean; virtual;
  end;

  EIdFTPListParseError = class(EIdException);

function ParseListing(AListing : TStrings; ADir : TIdFTPListItems; const AFormatID : String ) : boolean;
function CheckListParse(AListing : TStrings; ADir : TIdFTPListItems;var AFormat : String; const ASysDescript : String =''; const ADetails : Boolean = True) : boolean;
function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): String;
function CheckListParseCapa(AListing: TStrings; ADir: TIdFTPListItems; var VFormat: String;
  var VClass: TIdFTPListParseClass; const ASysDescript: String; const ADetails: Boolean=True): Boolean;

procedure RegisterFTPListParser(const AParser : TIdFTPListParseClass);
procedure UnregisterFTPListParser(const AParser : TIdFTPListParseClass);

procedure EnumFTPListParsers(AData : TStrings);

const
  NLST = 'NLST'; {do not localize}
  MLST = 'MLST';  {do not localize}

implementation

uses
  {$IFDEF VCL_XE3_OR_ABOVE}
  System.Types,
  {$ENDIF}
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdFTPCommon, IdFTPListTypes, IdGlobal, IdGlobalProtocols,
  IdResourceStringsProtocols, IdStrings, SysUtils;

type
  TIdFTPRegParseList = class(TList{$IFDEF HAS_GENERICS_TList}<TIdFTPListParseClass>{$ENDIF})
  protected
    function FindParserByDirData(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True) : TIdFTPListParseClass;
    function FindParserByIdent(const AIdent : String) : TIdFTPListParseClass;
  public
    procedure EnumFTPListParsers(AData : TStrings);
    constructor Create; overload;
    function ParseListing(AListing : TStrings; ADir : TIdFTPListItems; const AFormatID : String ) : boolean; virtual;
    function CheckListParse(AListing : TStrings; ADir : TIdFTPListItems;var VFormat : String; const ASysDescript : String =''; const ADetails : Boolean = True) : boolean; virtual;
    function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): String; virtual;
    {
    This is for TIdFTP.  This parses a list, returns the Parser ID, and the capabilities of the parser.
    }
    function CheckListParseCapa(AListing : TStrings; ADir : TIdFTPListItems; var VFormat : String; var VClass :  TIdFTPListParseClass; const ASysDescript : String =''; const ADetails : Boolean = True) : boolean; virtual;
  end;

var
  GParserList : TIdFTPRegParseList = nil;

{ TIdFTPRegParseList }

constructor TIdFTPRegParseList.Create;
begin
  inherited Create;
end;

function TIdFTPRegParseList.CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): String;
var
  LCurParser : TIdFTPListParseClass;
begin
  Result := '';
  LCurParser := Self.FindParserByDirData(AListing, ASysDescript, ADetails);
  if LCurParser <> nil then begin
    Result := LCurParser.GetIdent;
  end;
end;

function TIdFTPRegParseList.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems; const AFormatID: String): boolean;
var
  LCurParser : TIdFTPListParseClass;
begin
  //we do not want to fault a user or developer for an ambigious list
  //such as something only containing a "total 0".
  Result := True;
  ADir.BeginUpdate;
  try
    ADir.Clear;
    LCurParser := FindParserByIdent(AFormatID);
    if LCurParser <> nil then begin
      Result := LCurParser.ParseListing(AListing, ADir);
    end;
  finally
    ADir.EndUpdate;
  end;
end;

function TIdFTPRegParseList.CheckListParse(AListing : TStrings;
  ADir : TIdFTPListItems;var VFormat : String;
  const ASysDescript : String =''; const ADetails : Boolean = True) : boolean;
var
  LCurParser : TIdFTPListParseClass;
begin
  LCurParser := FindParserByDirData(AListing);
  Result := Assigned(LCurParser);
  if Result then begin
    VFormat := LCurParser.GetIdent;
    Result := ParseListing(AListing, ADir, VFormat);
  end;
end;

function TIdFTPRegParseList.FindParserByIdent(const AIdent: String): TIdFTPListParseClass;
var
  i : Integer;
  LCurParser : TIdFTPListParseClass;
begin
  for i := 0 to Count - 1 do begin
    LCurParser := {$IFDEF HAS_GENERICS_TList}Items[i]{$ELSE}TIdFTPListParseClass(Items[i]){$ENDIF};
    if LCurParser.GetIdent = AIdent then begin
      Result := LCurParser;
      Exit;
    end;
  end;
  Result := nil;
end;

function TIdFTPRegParseList.FindParserByDirData(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True) : TIdFTPListParseClass;
var
  i : Integer;
  LCurParser : TIdFTPListParseClass;
begin
  for i := 0 to Count - 1 do begin
    LCurParser := {$IFDEF HAS_GENERICS_TList}Items[i]{$ELSE}TIdFTPListParseClass(Items[i]){$ENDIF};
    if LCurParser.CheckListing(AListing, ASysDescript, ADetails) then begin
      Result := LCurParser;
      Exit;
    end;
  end;
  Result := nil;
end;

function TIdFTPRegParseList.CheckListParseCapa(AListing: TStrings;
  ADir: TIdFTPListItems; var VFormat: String; var VClass: TIdFTPListParseClass;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  HasExtraParsers: Boolean;
  I: Integer;
  LCurParser : TIdFTPListParseClass;
begin
  VFormat := '';
  ADir.BeginUpdate;
  try
    ADir.Clear;

    // RLebeau 9/17/07: if something other than NLST or MLST was used, check to
    // see that the user has included any of the IdFTPListParse... units in the
    // app's uses clause.  If the user forgot to include any, warn them.
    // Otherwise, just move on and assume they know what they are doing...

    if ADetails then begin
      HasExtraParsers := False;
      for I := 0 to Count-1 do
      begin
        // we need to exclude protocol specified parsers
        LCurParser := {$IFDEF HAS_GENERICS_TList}Items[I]{$ELSE}TIdFTPListParseClass(Items[I]){$ENDIF};
        if PosInStrArray(LCurParser.GetIdent, [NLST, MLST]) = -1 then begin
          HasExtraParsers := True;
          Break;
        end;
      end;
      if not HasExtraParsers then begin
        raise EIdFTPListParseError.Create(RSFTPNoListParseUnitsRegistered); {do not localize}
      end;
    end;

    VClass := FindParserByDirData(AListing, ASysDescript, ADetails);
    Result := Assigned(VClass);
    if Result then begin
      VFormat := VClass.GetIdent;
      Result := VClass.ParseListing(AListing, ADir);
    end;
  finally
    ADir.EndUpdate;
  end;
end;

{ TIdFTPListBase }

{register and unreg procedures}
procedure RegisterFTPListParser(const AParser : TIdFTPListParseClass);
begin
  GParserList.Add(
    {$IFDEF HAS_GENERICS_TList}AParser{$ELSE}TObject(AParser){$ENDIF}
  );
end;

procedure UnregisterFTPListParser(const AParser : TIdFTPListParseClass);
begin
  if Assigned(GParserList) then begin
    GParserList.Remove(
      {$IFDEF HAS_GENERICS_TList}AParser{$ELSE}TObject(AParser){$ENDIF}
    );
  end;
end;

function ParseListing(AListing : TStrings; ADir : TIdFTPListItems; const AFormatID : String) : boolean;
begin
  Result := GParserList.ParseListing(AListing, ADir, AFormatID);
end;

function CheckListParse(AListing : TStrings; ADir : TIdFTPListItems;var AFormat : String; const ASysDescript : String =''; const ADetails : Boolean = True) : boolean;
begin
  Result := GParserList.CheckListParse(AListing, ADir, AFormat, ASysDescript, ADetails);
end;

function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): String;
begin
  Result := GParserList.CheckListing(AListing, ASysDescript, ADetails);
end;

function CheckListParseCapa(AListing: TStrings; ADir: TIdFTPListItems;
  var VFormat: String; var VClass :  TIdFTPListParseClass;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
begin
  Result := GParserList.CheckListParseCapa(AListing, ADir, VFormat, VClass, ASysDescript, ADetails);
end;

procedure TIdFTPRegParseList.EnumFTPListParsers(AData: TStrings);
var
  i : Integer;
  LDesc : String;
  LCurParser: TIdFTPListParseClass;
begin
  AData.BeginUpdate;
  try
    AData.Clear;
    for i := 0 to GParserList.Count -1 do begin
      //we need to exclude protocol specified parsers
      LCurParser := {$IFDEF HAS_GENERICS_TList}Items[i]{$ELSE}TIdFTPListParseClass(Items[i]){$ENDIF};
      LDesc := LCurParser.GetIdent;
      if PosInStrArray(LDesc, [NLST, MLST]) = -1 then begin
        AData.Add(LDesc);
      end;
    end;
  finally
    AData.EndUpdate;
  end;
end;

{ TIdFTPListBase }

class function TIdFTPListBase.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  //C++Builder can not use abstract virtual class methods.
  Result := False;
end;

class function TIdFTPListBase.GetIdent: String;
begin
  Result := '';
end;

class function TIdFTPListBase.MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem;
begin
  Result := AOwner.Add;
end;

class function TIdFTPListBase.ParseLine(const AItem: TIdFTPListItem; const APath: String): Boolean;
begin
  //C++Builder can not use abstract virtual class methods.
  Result := False;
end;

class function TIdFTPListBase.ParseListing(AListing: TStrings; ADir: TIdFTPListItems): Boolean;
var
  i : Integer;
  AItem : TIdFTPListItem;
begin
  Result := True;
  for i := 0 to AListing.Count -1 do begin
    if AListing[i] <> '' then begin
      AItem := MakeNewItem(ADir);
      AItem.Data := AListing[i];
      ParseLine(AItem, '');
    end;
  end;
end;

{ TIdFTPLPNList }

class function TIdFTPLPNList.CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): boolean;
begin
  Result := not ADetails;
end;

class function TIdFTPLPNList.GetIdent: String;
begin
  Result := NLST;
end;

class function TIdFTPLPNList.ParseLine(const AItem: TIdFTPListItem;
  const APath: String = ''): Boolean;
begin
  AItem.FileName := AItem.Data;
  Result := True;
end;

{ TIdFTPLPMList }

class function TIdFTPLPMList.CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): boolean;
begin
  //user has to specifically ask for this parser
  Result := False;
end;

class function TIdFTPLPMList.GetIdent: String;
begin
  Result := MLST;
end;

class function TIdFTPLPMList.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMLSTFTPListItem.Create(AOwner);
end;

class function TIdFTPLPMList.ParseLine(const AItem: TIdFTPListItem;
  const APath: String = ''): Boolean;
var
  LFacts : TStrings;
  LBuffer : String;
  LI : TIdMLSTFTPListItem;
//based on:
//
//http://www.ietf.org/internet-drafts/draft-ietf-ftpext-mlst-15.txt
begin
  LI := AItem as TIdMLSTFTPListItem;
  LFacts := TStringList.Create;
  try
    LI.FileName := ParseFactsMLS(AItem.Data, LFacts);

    LI.LocalFileName := AItem.FileName;

    LBuffer := LFacts.Values['type']; {do not localize}
//   file         -- a file entry
//   cdir         -- the listed directory
//   pdir         -- a parent directory
//   dir          -- a directory or sub-directory
//   OS.name=type -- an OS or file system dependent file type
    case PosInStrArray(LBuffer,  ['cdir', 'pdir', 'dir',
      'OS.unix=slink',
      'OS.unix=socket',
      'OS.unix=blk',
      'OS.unix=chr',
      'OS.unix=fifo']) of
      0, 1, 2 : LI.ItemType := ditDirectory;
      3 : LI.ItemType := ditSymbolicLink;
      4 : LI.ItemType := ditSocket;
      5 : LI.ItemType := ditBlockDev;
      6 : LI.ItemType := ditCharDev;
      7 : LI.ItemType := ditFIFO;
    else
      //PureFTPD may do something like this to report where a symbolic link points to:
      //
      // type=OS.unix=slink:.;size=1;modify=20090304221247;UNIX.mode=0777;unique=13g1f1fb23; pub
      if TextStartsWith(LBuffer,'OS.unix=slink:') then begin
         LI.ItemType := ditSymbolicLink;
         Fetch(LBuffer,':');
         LI.LinkedItemName := LBuffer;
      end else begin
        //tnftpd does something like this for block devices
        //Type=OS.unix=blk-14/0;Modify=20100629203948;Perm=;Unique=dEcpCEoCAAAAAAAA; disk0
        if TextStartsWith(LBuffer, 'OS.unix=blk-' ) then begin
          LI.ItemType := ditBlockDev;
        end else begin
        //tnftpd does something like this for block devices
        //Type=OS.unix=chr-19/0;Modify=20100630134139;Perm=;Unique=dEcpCGECAAAAAAAA; nsmb0
          if TextStartsWith(LBuffer, 'OS.unix=chr-' ) then begin
            LI.ItemType := ditCharDev;
          end else begin
            LI.ItemType := ditFile;
          end;
        end;
      end;
    end;
    LBuffer := LFacts.Values['modify']; {do not localize}
    if LBuffer <> '' then begin
      LI.ModifiedDate := FTPMLSToLocalDateTime(LBuffer);
      LI.ModifiedDateGMT := FTPMLSToGMTDateTime(LBuffer);
      LI.ModifiedAvail := True;
    end else begin
      LI.ModifiedAvail := False;
    end;
    //create
    LBuffer := LFacts.Values['create']; {do not localize}
    if LBuffer <> '' then begin
      LI.CreationDate := FTPMLSToLocalDateTime(LBuffer);
      LI.CreationDateGMT := FTPMLSToGMTDateTime(LBuffer);
    end;
    //last access time
    LBuffer := LFacts.Values['windows.lastaccesstime']; {do not localize}
    if LBuffer <> '' then begin
      LI.LastAccessDate := FTPMLSToLocalDateTime(LBuffer);
      LI.LastAccessDateGMT := FTPMLSToGMTDateTime(LBuffer);
    end;
    LBuffer := LFacts.Values['size']; {do not localize}
    if LBuffer <> '' then begin
      LI.Size := IndyStrToInt64(LBuffer, 0);
      LI.SizeAvail := True;
    end else begin
      LI.SizeAvail := False;
    end;
    if (not LI.SizeAvail) and (LI.ItemType = ditDirectory) then
    begin
      {PureFTPD uses a sizd fact for directories instead of the size fact}
      LBuffer := LFacts.Values['sizd']; {Do not localize}
      if LBuffer <> '' then
      begin
        LI.Size := IndyStrToInt64(LBuffer, 0);
        LI.SizeAvail := True;
      end;
    end;
    LBuffer := LFacts.Values['perm']; {do not localize}
    if LBuffer <> '' then
    begin
      LI.MLISTPermissions := LBuffer;
      LI.PermissionDisplay := LI.MLISTPermissions;
    end else
    begin
      //maybe there is a UNIX.mode value
      LBuffer := LFacts.Values['UNIX.mode']; {do not localize}
      if LBuffer <> '' then
      begin
        //Surge FTP does something like this:
        //type=dir;size=4096;modify=20040901012354;create=20040901012354;unique=833.32641;perm=cdeflmp;unix.mode=drwxr-xr-x;unix.owner=root;unix.group=root pub
        //type=file;size=1376687;modify=20031212015717;create=20031212015717;unique=833.195842;perm=r;unix.mode=-rw-r--r--;unix.owner=root;unix.group=root v.zip
        //
        //while other servers simply give the chmod number
        if IsNumeric(LBuffer) then begin
           ChmodNoToPerms(IndyStrToInt(LBuffer, 0), LBuffer);
           case LI.ItemType of
             ditFile      : LBuffer := '-' + LBuffer; {do not localize}
             ditDirectory : LBuffer := 'd' + LBuffer; {do not localize}
             ditSymbolicLink,
             ditSymbolicLinkDir : LBuffer := 'l' + LBuffer; {do not localize}
             ditBlockDev  : LBuffer := 'b' + LBuffer; {do not localize}
             ditCharDev   : LBuffer := 'c' + LBuffer; {do not localize}
             ditFIFO      : LBuffer := 'p' + LBuffer; {do not localize}
             ditSocket    : LBuffer := 's' + LBuffer; {do not localize}
           end;
        end;
        LI.PermissionDisplay := LBuffer;
      end;
    end;
    LI.UniqueID := LFacts.Values['unique']; {do not localize}
    //Win32.ea
    //
    //format like this:
    //
    //size=0;lang=utf8;modify=20050308020346;create=20041109093936;type=cdir;UNIX.mode=0666;UNIX.owner=a;UNIX.group=default;win32.ea=0x00000810 .
    //
    LBuffer := LFacts.Values['win32.ea']; {do not localize}
    if LBuffer <> '' then begin
      Fetch(LBuffer, 'x'); {do not localize}
      LBuffer := '$'+LBuffer; {do not localize}
      LI.AttributesAvail := True;
      LI.Attributes.FileAttributes := IndyStrToInt(LBuffer, 0);
    end;
    Result := True;
  finally
    FreeAndNil(LFacts);
  end;
end;

{ TIdFTPListBaseHeader }

class function TIdFTPListBaseHeader.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to AListing.Count -1 do begin
    if (not IsWhiteString(AListing[i])) and (not IsLineStr(AListing[i])) then begin
      Result := IsHeader(AListing[i]);
      Break;
    end;
  end;
end;

class function TIdFTPListBaseHeader.IsFooter(const AData: String): Boolean;
begin
  Result := False;
end;

class function TIdFTPListBaseHeader.IsHeader(const AData: String): Boolean;
begin
  Result := False;
end;

class function TIdFTPListBaseHeader.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): boolean;
var
  LStart : Integer;
  i : Integer;
  LItem : TIdFTPListItem;
begin
  if AListing.Count > 0 then begin
    //find the entries below the header
    LStart := 0;
    for i := 0 to AListing.Count-1 do begin
      if IsHeader(AListing[i]) or IsWhiteString(AListing[i]) or IsLineStr(AListing[i]) then
      begin
        LStart := i+1;
      end else begin
        //we found where the header ends
        Break;
      end;
    end;
    for i := LStart to AListing.Count -1 do begin
      if (not IsWhiteString(AListing[i])) and (not IsLineStr(AListing[i])) and (not IsFooter(AListing[i])) then begin
        LItem := MakeNewItem(ADir);
        LItem.Data := AListing[i];
        ParseLine(LItem);
      end;
    end;
  end;
  Result := True;
end;

{ TIdFTPListBaseHeaderOpt }

class function TIdFTPListBaseHeaderOpt.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  Result := inherited CheckListing(AListing, ASysDescript,ADetails);
  if not Result then begin
    Result := CheckListingAlt(AListing, ASysDescript,ADetails);
  end;
end;

class function TIdFTPListBaseHeaderOpt.CheckListingAlt(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  Result := False;
end;

{ TIdFTPLineOwnedList }

class function TIdFTPLineOwnedList.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdOwnerFTPListItem.Create(AOwner);
end;

{ TIdFTPLPBaseDOS }

class function TIdFTPLPBaseDOS.IsValidAttr(const AAttr: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 1 to Length(AAttr) do begin
    Result := CharIsInSet(AAttr, i, 'RASH'); {do not localize}
    if not Result then begin
      Break;
    end;
  end;
end;

procedure EnumFTPListParsers(AData : TStrings);
begin
  GParserList.EnumFTPListParsers(AData);
end;

initialization
  GParserList := TIdFTPRegParseList.Create;

  //Register the manditory parsers
  RegisterFTPListParser(TIdFTPLPNList);
  RegisterFTPListParser(TIdFTPLPMList);

finalization
  FreeAndNil(GParserList);

end.

