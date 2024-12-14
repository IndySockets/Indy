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
  Rev 1.21    2/23/2005 6:34:28 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.20    10/26/2004 9:56:00 PM  JPMugaas
  Updated refs.

  Rev 1.19    8/5/2004 11:18:16 AM  JPMugaas
  Should fix a parsing problem I introeduced that caused errors with Unitree
  servers.

  Rev 1.18    8/4/2004 12:40:12 PM  JPMugaas
  Fix for problem with total line.

  Rev 1.17    7/15/2004 4:02:48 AM  JPMugaas
  Fix for some FTP servers.  In a Unix listing, a : at the end of a filename
  was wrongly being interpretted as a subdirectory entry in a recursive
  listing.

  Rev 1.16    6/14/2004 12:05:54 AM  JPMugaas
  Added support for the following Item types that appear in some Unix listings
  (particularly a /dev or /tmp dir):

  FIFO, Socket, Character Device, Block Device.

  Rev 1.15    6/13/2004 10:44:06 PM  JPMugaas
  Fixed a problem with some servers returning additional columns in the owner
  and group feilds.  Note that they will not be parsed correctly in all cases.
  That's life.

  drwx------  1          BUILTIN     NT AUTHORITY          0 Dec  7  2001
  System Volume Information

  Rev 1.14    4/20/2004 4:01:18 PM  JPMugaas
  Fix for nasty typecasting error.  The wrong create was being called.

  Rev 1.13    4/19/2004 5:05:20 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.12    2004.02.03 5:45:18 PM  czhower
  Name changes

  Rev 1.11    2004.01.23 9:53:32 PM  czhower
  REmoved unneded check because of CharIsInSet functinoalty. Also was a short
  circuit which is not permitted.

  Rev 1.10    1/23/2004 12:49:52 PM  SPerry
  fixed set problems

  Rev 1.9    1/22/2004 8:29:02 AM  JPMugaas
  Removed Ansi*.

  Rev 1.8    1/22/2004 7:20:48 AM  JPMugaas
  System.Delete changed to IdDelete so the code can work in NET.

    Rev 1.7    10/19/2003 3:48:10 PM  DSiders
  Added localization comments.

  Rev 1.6    9/28/2003 03:02:30 AM  JPMugaas
  Now can handle a few non-standard date types.

  Rev 1.5    9/3/2003 07:34:40 PM  JPMugaas
  Parsing for /bin/ls with devices now should work again.

  Rev 1.4    4/7/2003 04:04:26 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.3    4/3/2003 03:37:36 AM  JPMugaas
  Fixed a bug in the Unix parser causing it not to work properly with Unix BSD
  servers using the -T switch.  Note that when a -T switch s used on a FreeBSD
  server, the server outputs the millaseconds and an extra column giving the
  year instead of either the year or time (the regular /bin/ls standard
  behavior).

  Rev 1.2    3/3/2003 07:17:58 PM  JPMugaas
  Now honors the FreeBSD -T flag and parses list output from a program using
  it.  Minor changes to the File System component.

  Rev 1.1    2/19/2003 05:53:14 PM  JPMugaas
  Minor restructures to remove duplicate code and save some work with some
  formats.  The Unix parser had a bug that caused it to give a False positive
  for Xercom MicroRTOS.

  Rev 1.0    2/19/2003 02:02:02 AM  JPMugaas
  Individual parsing objects for the new framework.
}

unit IdFTPListParseUnix;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

{
Notes:

- The Unitree and Unix parsers are closely tied together and share just
about all of the same code.  The reason is that Unitee is very similar to
a Unix dir list except it has an extra column which the Unix line parser
can handle in the Unitree type.

- The Unix parser can parse MACOS - Peters server (no relationship to this
author :-) ).

- It is worth noting that the parser does handle /bin/ls -s and -i switches as
well as -g and -o.  This is important sometimes as the Unix format comes
from FTP servers that simply piped output from the Unix /bin/ls command.

- This parser also handles recursive lists which is good for mirroring software.
}

type
  {
    Note that for this, I am violating a convention.
    The violation is that I am putting parsers for two separate servers
    in the same unit.
    The reason is this, Unitree has two additional columns (a file family
    and a file migration status.  The line parsing code is the same because
    I thought it was easier to do that way in this case.
}
  TIdUnixFTPListItem = class(TIdUnixBaseFTPListItem)
  protected
    FNumberBlocks : Integer;
    FInode : Integer;
  public
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
    property Inode : Integer read FInode write FInode;
  end;

  TIdUnitreeFTPListItem = class(TIdUnixFTPListItem)
  protected
    FMigrated : Boolean;
    FFileFamily : String;
  public
    property Migrated : Boolean read FMigrated write FMigrated;
    property FileFamily : String read FFileFamily write FFileFamily;
  end;

  TIdFTPLPUnix = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function InternelChkUnix(const AData : String) : Boolean; virtual;
    class function IsUnitree(const AData: string): Boolean;  virtual;
    class function IsUnitreeBanner(const AData: String): Boolean; virtual;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : Boolean; override;
  end;

  TIdFTPLPUnitree = class(TIdFTPLPUnix)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
  end;

const
  UNIX = 'Unix';        {do not localize}
  UNITREE = 'Unitree';  {do not localize}

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseUnix"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  {$IFDEF HAS_UNIT_DateUtils}DateUtils,{$ENDIF}
  SysUtils;

{ TIdFTPLPUnix }

class function TIdFTPLPUnix.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  i : Integer;
begin
  // TODO: return True if ASysDescript starts with 'Unix'?
  Result := False;
  for i := 0 to AListing.Count - 1 do
  begin
    if AListing[i] <> '' then begin
      //workaround for the XBox MediaCenter FTP Server
      //which returns something like this:
      //
      //dr-xr-xr-x    1 ftp      ftp            1 Feb 23 00:00 D:
      //and the trailing : is falsely assuming that a ":" means
      //a subdirectory entry in a recursive list.
      if InternelChkUnix(AListing[i]) then begin
        if GetIdent = UNITREE then begin
          Result := IsUnitree(AListing[i]);
        end else begin
          Result := not IsUnitree(AListing[i]);
        end;
        Break;
      end;
      if not (IsTotalLine(AListing[i]) or IsSubDirContentsBanner(AListing[i])) then begin
        Break;
      end;
    end;
  end;
end;

class function TIdFTPLPUnix.GetIdent: String;
begin
  Result := UNIX;
end;

class function TIdFTPLPUnix.InternelChkUnix(const AData: String): Boolean;
var
  s : TStrings;
  LCData : String;
begin
  //pos 1 values
  // d - dir
  // - - file
  // l - symbolic link
  // b - block device
  // c - charactor device
  // p - pipe (FIFO)
  // s - socket
  LCData := UpperCase(AData);
  Result := IsValidUnixPerms(AData);
  if Result then begin
    //Do NOT attempt to do Novell Netware Print Services for Unix FTPD in NFS
    //namespace if we have a block device.
    if CharIsInSet(LCData, 1, 'CB') then begin
      Exit;
    end;
    //This extra complexity is required to distinguish Unix from
    //a Novell Netware server in NFS namespace which is somewhat similar
    //to a Unix listing.  Beware.
    s := TStringList.Create;
    try
      SplitDelimitedString(LCData, s, True);
      if s.Count > 9 then begin
        Result := PosInStrArray(s[9], ['AM', 'PM']) = -1; {do not localize}
        if Result then begin
          // allow localized months longer than 3 characters
          Result := not ((IndyPos(':', s[8]) = 0) and (StrToMonth(s[6]) > 0)); {do not localize}
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end else begin
    //we make an additional check for two additional rows before the
    //the permissions.  These are the inode and block count for the item.
    //These are specified with the -i and -s parameters.
    s := TStringList.Create;
    try
      SplitDelimitedString(LCData, s, True);
      if s.Count > 3 then begin
        if IsNumeric(s[0]) then begin
          Result :=  IsValidUnixPerms(S[1]);
          if not Result then begin
            Result := IsNumeric(s[1]) and IsValidUnixPerms(S[2]);
          end;
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPUnix.IsUnitree(const AData: string): Boolean;
var
  s : TStrings;
begin
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    Result := (s.Count > 4) and (PosInStrArray(s[4], UnitreeStoreTypes) <> -1);
    if not Result then begin
      Result := IsUnitreeBanner(AData);
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnix.IsUnitreeBanner(const AData: String): Boolean;
begin
  Result := TextStartsWith(AData, '/') and TextEndsWith(AData, ').') and (IndyPos('(', AData) > 0); {do not localize}
end;

class function TIdFTPLPUnix.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdUnixFTPListItem.Create(AOwner);
end;

class function TIdFTPLPUnix.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
{Note that we also use this parser for Unitree FTP Servers because that server
is like Unix except that in Unitree, there's two additional columns before the size.

Those are:

Storage Type - AR - archived or migrated to tape and DK
File family -
}
type
  TParseUnixSteps = (pusINode, pusBlocks, pusPerm, pusCount, pusOwner, pusGroup,
                     pusSize, pusMonth, pusDay, pusYear, pusTime, pusName, pusDone);
var
  LStep: TParseUnixSteps;
  LData, LTmp: String;
  LInode, LBlocks, LDir, LGPerm, LOPerm, LUPerm, LCount, LOwner, LGroup: String;
  LName, LSize, LLinkTo: String;
  wYear, wMonth, wDay: Word;
  wCurrYear, wCurrMonth, wCurrDay: Word;
 // wYear, LCurrentMonth, wMonth, wDay: Word;
  wHour, wMin, wSec, wMSec: Word;
  ADate: TDateTime;
  i: Integer;
  LI : TIdUnixFTPListItem;
  wDayStr: string;

  function IsGOSwitches(const AString : String) : Boolean;
  var
    s : TStrings;
  begin
    //check to see if both the -g and -o switches were used.  Both
    //owner and group are surpressed in that case.  We have to check
    //that so our interpretation does not cause an error.
    Result := False;
    s := TStringList.Create;
    try
      SplitDelimitedString(AString, s, True);
      if s.Count > 2 then begin
        //if either inode or block count were given
        if IsNumeric(s[0]) then begin
          s.Delete(0);
        end;
        //if both inode and block count were given
        if IsNumeric(s[0]) then begin
          s.Delete(0);
        end;
        if s.Count > 5 then begin
          if StrToMonth(s[3]) > 0 then begin
            Result := IsNumeric(s[4]) and (IsNumeric(s[5]) or (IndyPos(':', s[5]) > 0)); {do not localize}
          end;
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;

  function FixBonkedYear(const AStrPart : String) : String;
  var 
    LB : String;
  begin
    LB := AStrPart;
    Result := Fetch(LB);
    //TODO: use StringsReplace() instead
    //Result := StringsReplace(Result, ['-', '/'], [' ', ' ']); {do not localize}
    Result := ReplaceAll(Result, '-', ' '); {do not localize}
    Result := ReplaceAll(Result, '/', ' '); {do not localize}
    Result := Result + ' ' + LB; {do not localize}
  end;

begin
  LI := AItem as TIdUnixFTPListItem;
  // Get defaults for modified date/time
  ADate := Now;
  DecodeDate(ADate, wYear, wMonth, wDay);
  DecodeTime(ADate, wHour, wMin, wSec, wMSec);
  LData := AItem.Data;
  LStep := pusINode;
  repeat
    case LStep of
      pusINode: begin
        //we do it this way because the column for inode is right justified
        //and we don't want to create a problem if the -i parameter was never used
        LTmp := TrimLeft(LData);
        LTmp := Fetch(LTmp);
        if IsValidUnixPerms(LTmp) then begin
          LStep := pusPerm;
        end else begin
          //the inode column is right justified
          LData := TrimLeft(LData);
          LTmp := Fetch(LData);
          LData := TrimLeft(LData);
          LInode := LTmp;
          LStep := pusBlocks;
        end;
      end;
      pusBlocks: begin
        //Note that there is an ambigioutity because this value could
        //be the inode if only the -i switch was used.
        LTmp := Fetch(LData, ' ', False); {do not localize}
        if not IsValidUnixPerms(LTmp) then begin
          LTmp := Fetch(LData);
          LData := TrimLeft(LData);
          LBlocks := LTmp;
        end;
        LStep := pusPerm;
      end;
      pusPerm: begin //1.-rw-rw-rw-
        LTmp := Fetch(LData);
        LData := TrimLeft(LData);
        // Copy the predictable pieces
        LI.PermissionDisplay := Copy(LTmp, 1, 10);
        LDir := UpperCase(Copy(LTmp, 1, 1));
        LOPerm := Copy(LTmp, 2, 3);
        LGPerm := Copy(LTmp, 5, 3);
        LUPerm := Copy(LTmp, 8, 3);
        LStep := pusCount;
      end;
      pusCount: begin
        LData := TrimLeft(LData);
        LTmp := Fetch(LData);
        LData := TrimLeft(LData);
        //Patch for NetPresenz
        // "-------r--         326  1391972  1392298 Nov 22  1995 MegaPhone.sit" */
        // "drwxrwxr-x               folder        2 May 10  1996 network" */
        if TextIsSame(LTmp, 'folder') then begin  {do not localize}
          LStep := pusSize;
        end else begin
          //APR
          //Patch for overflow -r--r--r--   0526478   128  Dec 30 2002  DE292000
          if (Length(LTmp) > 3) and (LTmp[1] = '0') then begin
            LData := Copy(LTmp, 2, MaxInt) + ' ' + LData;
            LCount := '0';
          end else begin
            LCount := LTmp;
          end;
          //this check is necessary if both the owner and group were surpressed.
          if IsGOSwitches(AItem.Data) then begin
            LStep := pusSize;
          end else begin
            LStep := pusOwner;
          end;
        end;
        LData := TrimLeft(LData);
      end;
      pusOwner: begin
        LTmp := Fetch(LData);
        LData := TrimLeft(LData);
        LOwner := LTmp;
        LStep := pusGroup;
      end;
      pusGroup: begin
        LTmp := Fetch(LData);
        LData := TrimLeft(LData);
        LGroup := LTmp;
        LStep := pusSize;
      end;
      pusSize: begin
        //Ericsson - Switch FTP returns empty owner
        //Do not apply Ericson patch to Unitree
        if IsAlpha(LData, 1, 1) and (GetIdent <> UNITREE) then begin
          LSize := LGroup;
          LGroup := LOwner;
          LOwner := '';
          //we do this just after the erickson patch because
          //a few servers might return additional columns.
          //
          //e.g.
          //
          //drwx------  1          BUILTIN     NT AUTHORITY          0 Dec  7  2001 System Volume Information
          if not IsNumeric(LSize) then begin
            //undo the Ericson patch
            LOwner := LGroup;
            LGroup := '';
            repeat
              LGroup := LGroup + ' ' + LSize;
              LOwner := LGroup;
              LData := TrimLeft(LData);
              LSize := Fetch(LData);
            until IsNumeric(LSize);
            //delete the initial space we had added in the repeat loop
            IdDelete(LGroup, 1, 1);
          end;
        end else begin
          LTmp := Fetch(LData);
          //This is necessary for cases where are char device is listed
          //e.g.
          //crw-rw-rw-   1 0        1         11, 42 Aug  8  2000 tcp
          //
          //Note sure what 11, 42 is so size is not returned.
          if IndyPos(',', LTmp) > 0 then begin {do not localize}
            LData := TrimLeft(LData);
            Fetch(LData);
            LData := TrimLeft(LData);
            LSize := '';
          end else begin
            LSize := LTmp;
          end;
          LData := TrimLeft(LData);
          case PosInStrArray(LSize, UnitreeStoreTypes) of
            0 : //AR - archived to tape - migrated
            begin
              if AItem is TIdUnitreeFTPListItem then begin
                (LI as TIdUnitreeFTPListItem).Migrated := True;
                (LI as TIdUnitreeFTPListItem).FileFamily := Fetch(LData);
              end;
              LData := TrimLeft(LData);
              LSize := Fetch(LData);
              LData := TrimLeft(LData);
            end;
            1 : //DK - disk
            begin
              if AItem is TIdUnitreeFTPListItem then begin
                (LI as TIdUnitreeFTPListItem).FileFamily := Fetch(LData);
              end;
              LData := TrimLeft(LData);
              LSize := Fetch(LData);
              LData := TrimLeft(LData);
            end;
          end;
        end;
        LStep := pusMonth;
      end;
      pusMonth: begin // Scan modified MMM
        // Handle Chinese listings;  the month, day, and year may not have spaces between them
        if IndyPos(ChineseYear, LData) > 0 then begin
            wYear := IndyStrToInt(Fetch(LData, ChineseYear));
            LData := TrimLeft(LData);
            // Set time info to 00:00:00.999
            wHour := 0;
            wMin := 0;
            wSec := 0;
            wMSec := 999;
            LStep := pusName
        end;
        if IndyPos(ChineseDay, LData) > 0 then begin
            wMonth := IndyStrToInt(Fetch(LData, ChineseMonth));
            LData := TrimLeft(LData);
            wDay := IndyStrToInt(Fetch(LData, ChineseDay));
            LData := TrimLeft(LData);
            if LStep <> pusName then begin
              LTmp := Fetch(LData);
              LStep := pusTime;
            end;
            Continue;
        end;
        //fix up a bonked date such as:
        //-rw-r--r--   1 root     other        531 09-26 13:45 README3
        LData := FixBonkedYear(LData);
        //we do this in case there's a space
        LTmp := Fetch(LData);
        if (Length(LTmp) > 3) and IsNumeric(LTmp) then begin
          //must be a year
          wYear := IndyStrToInt(LTmp, wYear);
          LTmp := Fetch(LData);
        end;
        LData := TrimLeft(LData);
        // HPUX can output the dates like "28. Jan., 16:48", "5. Mai, 05:34" or 
        // "7. Nov. 2004"
        if TextEndsWith(LTmp, '.') then begin
          Delete(LTmp, Length(LTmp), 1);
        end;
        // Korean listings will have the Korean "month" character
        DeleteSuffix(LTmp,KoreanMonth);
        //  Just in case
        DeleteSuffix(LTmp,KoreanEUCMonth);
        {        if IndyPos(KoreanMonth, LTmp) = Length(LTmp) - Length(KoreanMonth) + 1 then
        begin
          Delete(LTmp, Length(LTmp) - Length(KoreanMonth) + 1, Length(KoreanMonth));
        end;
        // Japanese listings will have the Japanese "month" character
}       DeleteSuffix(LTmp,JapaneseMonth);
        if IsNumeric(LTmp) then begin
          wMonth := IndyStrToInt(LTmp, wMonth);
          // HPUX
          LTmp := Fetch(LData, ' ', False);
          if TextEndsWith(LTmp, ',') then begin
            Delete(LTmp, Length(LTmp), 1);
          end;
          if TextEndsWith(LTmp, '.') then begin
            Delete(LTmp, Length(LTmp), 1);
          end;
          // Handle dates where the day preceeds a string month (French, Dutch)
          i := StrToMonth(LTmp);
          if i > 0 then begin
            wDay := wMonth;
            LTmp := Fetch(LData);
            LData := TrimLeft(LData);
            wMonth := i;
            LStep := pusYear;
          end else begin
            if wMonth > 12 then begin
              wDay := wMonth;
              LTmp := Fetch(LData);
              LData := TrimLeft(LData);
              wMonth := IndyStrToInt(LTmp, wMonth);
              LStep := pusYear;
            end else begin
              LStep := pusDay;
            end;
          end;
        end else begin
          wMonth := StrToMonth(LTmp);
          LStep := pusDay;
          // Korean listings can have dates in the form "2004.10.25"
          if wMonth = 0 then begin
            wYear := IndyStrToInt(Fetch(LTmp, '.'), wYear);
            wMonth := IndyStrToInt(Fetch(LTmp, '.'), 0);
            wDay := IndyStrToInt(LTmp);
            LStep := pusName;
          end;
        end;
      end;
      pusDay: begin // Scan DD
        LTmp := Fetch(LData);
        LData := TrimLeft(LData);
        // Korean dates can have their "Day" character as included
{        if IndyPos(KoreanDay, LTmp) = Length(LTmp) - Length(KoreanDay) + 1 then
        begin
          Delete(LTmp, Length(LTmp) - Length(KoreanDay) + 1, Length(KoreanDay));
        end;   }
        DeleteSuffix(LTmp,KoreanDay);
        //Ditto for Japanese
        DeleteSuffix(LTmp,JapaneseDay);
        wDay := IndyStrToInt(LTmp, wDay);
        LStep := pusYear;
      end;
      pusYear: begin
        LTmp := Fetch(LData);
        //Some localized Japanese listings include a year sybmol
        DeleteSUffix(LTmp,JapaneseYear);
        // Not time info, scan year
        if IndyPos(':', LTmp) = 0 then begin   {Do not Localize}
	        wYear := IndyStrToInt(LTmp, wYear);
          // Set time info to 00:00:00.999
          wHour := 0;
          wMin := 0;
          wSec := 0;
          wMSec := 999;
          LStep := pusName;
        end else begin
          // Time info, scan hour, min
          LStep := pusTime;
        end;
      end;
      pusTime: begin
        // correct year and Scan hour
        wYear := AddMissingYear(wDay, wMonth);
        wHour:= IndyStrToInt(Fetch(LTmp, ':'), 0);    {Do not Localize}
        // Set sec and ms to 0.999 except for Serv-U or FreeBSD with the -T parameter
        //with the -T parameter, Serve-U returns something like this:
        //
        //drwxrwxrwx   1 user     group           0 Mar  3 04:49:59 2003 upload
        //
        //instead of:
        //
        //drwxrwxrwx   1 user     group           0 Mar  3 04:49 upload
        if (IndyPos(':', LTmp) > 0) and (IsNumeric(Fetch(LData, ' ', False))) then begin {Do not localize}
          // Scan minutes
          wMin := IndyStrToInt(Fetch(LTmp, ':'), 0);   {Do not localize}
          wSec := IndyStrToInt(Fetch(LTmp, ':'), 0);   {Do not localize}
          wMSec := IndyStrToInt(Fetch(LTmp,':'), 999); {Do not localize}
          LTmp := Fetch(LData);
          wYear := IndyStrToInt(LTmp, wYear);
        end else begin
          // Scan minutes
          wMin := IndyStrToInt(Fetch(LTmp, ':'), 0); {Do not localize}
          wSec := IndyStrToInt(Fetch(LTmp, ':'), 0); {Do not localize}
          wMSec := IndyStrToInt(Fetch(LTmp), 999);
        end;
        LStep := pusName;
      end;
      pusName: begin
        LName := LData;
        LStep := pusDone;
      end;
    end;//case LStep
  until LStep = pusDone;
  AItem.ItemType := ditFile;
  if LDir <> '' then begin
    case LDir[1] of
      'D' : AItem.ItemType := ditDirectory;    {Do not Localize}
      'L' : AItem.ItemType := ditSymbolicLink; {Do not Localize}
      'B' : AItem.ItemType := ditBlockDev;     {Do not Localize}
      'C' : AItem.ItemType := ditCharDev;      {Do not Localize}
      'P' : AItem.ItemType := ditFIFO;         {Do not Localize}
      'S' : AItem.ItemType := ditSocket;       {Do not Localize}
    end;
  end;
  LI.UnixOwnerPermissions := LOPerm;
  LI.UnixGroupPermissions := LGPerm;
  LI.UnixOtherPermissions := LUPerm;
  LI.LinkCount := IndyStrToInt(LCount, 0);
  LI.OwnerName := LOwner;
  LI.GroupName := LGroup;
  LI.Size := IndyStrToInt64(LSize, 0);
  if (wMonth = 2) and (wDay = 29) and (not IsLeapYear(wYear)) then
  begin
    {temporary workaround for Leap Year, February 29th. Encode with day - 1, but do NOT decrement wDay since this will give us the wrong day when we adjust/re-calculate the date later}
    LI.ModifiedDate := EncodeDate(wYear, wMonth, wDay - 1) + EncodeTime(wHour, wMin, wSec, wMSec);
  end else begin
    LI.ModifiedDate := EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMin, wSec, wMSec);
  end;

  {PATCH: If Indy incorrectly decremented the year then it will be almost a year behind.
  Certainly well past 90 days and so we will have the day and year in the raw data.
  (Files that are from within the last 90 days do not show the year as part of the date.)}
  wdayStr := IntToStr(wDay);
  while Length(wDayStr) < 2 do begin
   wDayStr := '0' + wDayStr; {do not localize}
  end;
  DecodeDate(Now, wCurrYear, wCurrMonth, wCurrDay);
  if (wYear < wCurrYear) and ((Now-LI.ModifiedDate) > 90) and
     (Pos(IntToStr(wMonth) + '  ' + IntToStr(wYear), LI.Data) = 0) and
     (Pos(IntToStr(wMonth) + ' ' + wDayStr + '  ' + IntToStr(wYear), LI.Data) = 0) and
     (Pos(monthNames[wMonth] + '  ' + IntToStr(wYear), LI.Data) = 0) and
     (Pos(monthNames[wMonth] + ' ' + wDayStr + '  ' + IntToStr(wYear), LI.Data) = 0) then
  begin
    {sanity check to be sure we aren't making future dates!!}
    {$IFDEF VCL_6_OR_ABOVE}
    if IncYear(LI.ModifiedDate) <= (Now + 7) then
    {$ELSE}
    if IncMonth(LI.ModifiedDate,12) <= (Now + 7) then
    {$ENDIF}
    begin
      Inc(wYear);
      if (wMonth = 2) and (wDay = 29) and (not IsLeapYear(wYear)) then
      begin
        {temporary workaround for Leap Year, February 29th. Encode with day - 1, but do NOT decrement wDay since this will give us the wrong day when we adjust/re-calculate the date later}
        LI.ModifiedDate := EncodeDate(wYear, wMonth, wDay - 1) + EncodeTime(wHour, wMin, wSec, wMSec);
      end else begin
        LI.ModifiedDate := EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMin, wSec, wMSec);
      end;
    end;
  end;

  if LI.ItemType = ditSymbolicLink then begin
    i := IndyPos(UNIX_LINKTO_SYM, LName);
    LLinkTo := Copy(LName, i + 4, Length(LName) - i - 3);
    LName := Copy(LName, 1, i - 1);
    //with ls -F (DIR -F in FTP, you will sometimes symbolic links with the linked
    //to item file name ending with a /.  That indicates that the item being pointed to
    //is a directory
    if TextEndsWith(LLinkTo, PATH_FILENAME_SEP_UNIX) then begin
      LI.ItemType := ditSymbolicLinkDir;
      LLinkTo := Copy(LLinkTo, 1, Length(LLinkTo)-1);
    end;
    LI.LinkedItemName := LLinkTo;
  end;
  LI.NumberBlocks := IndyStrToInt(LBlocks, 0);
  LI.Inode := IndyStrToInt(LInode, 0);
  //with servers using ls -F, / is returned after the name of dir names and a *
  //will be returned at the end of a file name for an executable program.
  //Based on info at http://www.skypoint.com/help/tipgettingaround.html
  //Note that many FTP servers obtain their DIR lists by piping output from the /bin/ls -l command.
  //The -F parameter does work with ftp.netscape.com and I have also tested a NcFTP server
  //which simulates the output of the ls command.
  if CharIsInSet(LName, Length(LName), PATH_FILENAME_SEP_UNIX + '*') then begin {Do not localize}
    LName := Copy(LName, 1, Length(LName)-1);
  end;

  if APath <> '' then begin
    // a path can sometimes come into the form of:
    //  pub:
    // or
    //  ./pub
    //
    //Deal with both cases
    LI.LocalFileName := LName;
    LName := APath + PATH_FILENAME_SEP_UNIX + LName;
    if TextStartsWith(LName, UNIX_CURDIR) then begin
      IdDelete(LName, 1, Length(UNIX_CURDIR));
      if TextStartsWith(LName, PATH_FILENAME_SEP_UNIX) then begin
        IdDelete(LName, 1, Length(PATH_FILENAME_SEP_UNIX));
      end;
    end;
  end;

  LI.FileName := LName;
  Result := True;
end;

class function TIdFTPLPUnix.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  i : Integer;
  LPathSpec : String;
  LItem : TIdFTPListItem;
begin
  for i := 0 to AListing.Count-1 do begin
    if not ((AListing[i] = '') or IsTotalLine(AListing[i]) or IsUnixLsErr(AListing[i]) or IsUnitreeBanner(AListing[i])) then begin
      //workaround for the XBox MediaCenter FTP Server
      //which returns something like this:
      //
      //dr-xr-xr-x    1 ftp      ftp            1 Feb 23 00:00 D:
      //and the trailing : is falsely assuming that a ":" means
      //a subdirectory entry in a recursive list.
      if (not InternelChkUnix(AListing[i])) and IsSubDirContentsBanner(AListing[i]) then begin
        LPathSpec := Copy(AListing[i], 1, Length(AListing[i])-1);
      end else begin
        LItem := MakeNewItem(ADir);
        LItem.Data := AListing[i];
        Result := ParseLine(LItem, LPathSpec);
        if not Result then begin
          FreeAndNil(LItem);
          Exit;
        end;
      end;
    end;
  end;
  Result := True;
end;

{ TIdFTPLPUnitree }

class function TIdFTPLPUnitree.GetIdent: String;
begin
  Result := UNITREE;
end;

class function TIdFTPLPUnitree.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdUnitreeFTPListItem.Create(AOwner);
end;

initialization
  RegisterFTPListParser(TIdFTPLPUnix);
  RegisterFTPListParser(TIdFTPLPUnitree);
finalization
  UnRegisterFTPListParser(TIdFTPLPUnix);
  UnRegisterFTPListParser(TIdFTPLPUnitree);

end.
