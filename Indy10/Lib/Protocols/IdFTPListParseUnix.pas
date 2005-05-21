{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16166: IdFTPListParseUnix.pas
{
{   Rev 1.21    2/23/2005 6:34:28 PM  JPMugaas
{ New property for displaying permissions ina GUI column.  Note that this
{ should not be used like a CHMOD because permissions are different on
{ different platforms - you have been warned.
}
{
{   Rev 1.20    10/26/2004 9:56:00 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.19    8/5/2004 11:18:16 AM  JPMugaas
{ Should fix a parsing problem I introeduced that caused errors with Unitree
{ servers.
}
{
{   Rev 1.18    8/4/2004 12:40:12 PM  JPMugaas
{ Fix for problem with total line.
}
{
{   Rev 1.17    7/15/2004 4:02:48 AM  JPMugaas
{ Fix for some FTP servers.  In a Unix listing, a : at the end of a filename
{ was wrongly being interpretted as a subdirectory entry in a recursive
{ listing.  
}
{
{   Rev 1.16    6/14/2004 12:05:54 AM  JPMugaas
{ Added support for the following Item types that appear in some Unix listings
{ (particularly a /dev or /tmp dir):
{ 
{ FIFO, Socket, Character Device, Block Device.
}
{
{   Rev 1.15    6/13/2004 10:44:06 PM  JPMugaas
{ Fixed a problem with some servers returning additional columns in the owner
{ and group feilds.  Note that they will not be parsed correctly in all cases. 
{ That's life.
{ 
{ drwx------  1          BUILTIN     NT AUTHORITY          0 Dec  7  2001
{ System Volume Information
}
{
{   Rev 1.14    4/20/2004 4:01:18 PM  JPMugaas
{ Fix for nasty typecasting error.  The wrong create was being called.
}
{
{   Rev 1.13    4/19/2004 5:05:20 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.12    2004.02.03 5:45:18 PM  czhower
{ Name changes
}
{
{   Rev 1.11    2004.01.23 9:53:32 PM  czhower
{ REmoved unneded check because of CharIsInSet functinoalty. Also was a short
{ circuit which is not permitted.
}
{
{   Rev 1.10    1/23/2004 12:49:52 PM  SPerry
{ fixed set problems
}
{
{   Rev 1.9    1/22/2004 8:29:02 AM  JPMugaas
{ Removed Ansi*.
}
{
{   Rev 1.8    1/22/2004 7:20:48 AM  JPMugaas
{ System.Delete changed to IdDelete so the code can work in NET.
}
{
    Rev 1.7    10/19/2003 3:48:10 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.6    9/28/2003 03:02:30 AM  JPMugaas
{ Now can handle a few non-standard date types.
}
{
{   Rev 1.5    9/3/2003 07:34:40 PM  JPMugaas
{ Parsing for /bin/ls with devices now should work again.
}
{
{   Rev 1.4    4/7/2003 04:04:26 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.3    4/3/2003 03:37:36 AM  JPMugaas
{ Fixed a bug in the Unix parser causing it not to work properly with Unix BSD
{ servers using the -T switch.  Note that when a -T switch s used on a FreeBSD
{ server, the server outputs the millaseconds and an extra column giving the
{ year instead of either the year or time (the regular /bin/ls standard
{ behavior).
}
{
{   Rev 1.2    3/3/2003 07:17:58 PM  JPMugaas
{ Now honors the FreeBSD -T flag and parses list output from a program using
{ it.  Minor changes to the File System component.
}
{
{   Rev 1.1    2/19/2003 05:53:14 PM  JPMugaas
{ Minor restructures to remove duplicate code and save some work with some
{ formats.  The Unix parser had a bug that caused it to give a False positive
{ for Xercom MicroRTOS.
}
{
{   Rev 1.0    2/19/2003 02:02:02 AM  JPMugaas
{ Individual parsing objects for the new framework.
}
unit IdFTPListParseUnix;

interface

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdTStrings;

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
{Note that for this, I am violating a convention.
The violation is that I am putting parsers for two separate servers
in the same unit.  The reason is this, Unitree has two additional columns (a file family
and a file migration status.  The line parsing code is the same because I thought it
was easier to do that way in this case.
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
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function InternelChkUnix(const AData : String) : Boolean; virtual;
    class function IsUnitree(AData:string): Boolean;  virtual;
    class function IsUnitreeBanner(const AData: String): Boolean; virtual;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
    class function ParseListing(AListing : TIdStrings; ADir : TIdFTPListItems) : boolean; override;
  end;
  TIdFTPLPUnitree = class(TIdFTPLPUnix)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
  end;

const
  UNIX = 'Unix';  {do not localize}
  UNITREE = 'Unitree';  {do not localize}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  IdSys;

{ TIdFTPLPUnix }

class function TIdFTPLPUnix.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to AListing.Count - 1 do
  begin
    if (AListing[i]<>'') then
    begin
      //workaround for the XBox MediaCenter FTP Server
      //which returns something like this:
      //
      //dr-xr-xr-x    1 ftp      ftp            1 Feb 23 00:00 D:
      //and the trailing : is falsely assuming that a ":" means
      //a subdirectory entry in a recursive list.
      if InternelChkUnix(AListing[i]) then
      begin
        if GetIdent= UNITREE then
        begin
          Result := IsUnitree(AListing[i]);
        end
        else
        begin
          Result := not IsUnitree(AListing[i]);
        end;
        Break;
      end;
      if IsTotalLine(AListing[i]) or
        IsSubDirContentsBanner(AListing[i]) then
      begin
        Continue;
      end
      else
      begin
        break;
      end;
    end;
  end;
end;

class function TIdFTPLPUnix.GetIdent: String;
begin
  Result := UNIX;
end;

class function TIdFTPLPUnix.InternelChkUnix(const AData: String): Boolean;
  var s : TIdStrings;
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
    LCData := Sys.UpperCase(AData);
    Result := IsValidUnixPerms(AData);
    if Result then
    begin
      //Do NOT attempt to do Novell Netware Print Services for Unix FTPD in NFS
      //namespace if we have a block device.
      if CharIsInSet(LCData, 1, 'CB') then
      begin
        Exit;
      end;
      //This extra complexity is required to distinguish Unix from
      //a Novell Netware server in NFS namespace which is somewhat similar
      //to a Unix listing.  Beware.
      s := TIdStringList.Create;
      try
        SplitColumns(LCData,s);
        if (s.Count > 9) then
        begin
          Result :=  (s[9] <> 'AM') and (s[9] <> 'PM'); {do not localize}
          if Result then
          begin
            //we test the month with a copy because Netware Print Services may return a 4 char month such as Sept
            Result := ((IndyPos(':', s[8]) = 0) and (StrToMonth(Copy(s[6], 1, 3)) > 0)) = False;
          end;
        end;
      finally
        Sys.FreeAndNil(s);
      end;
    end
    else
    begin
      //we make an additional check for two additional rows before the
      //the permissions.  These are the inode and block count for the item.
      //These are specified with the -i and -s parameters.
      s := TIdStringList.Create;
      try
        SplitColumns(LCData,s);
        if s.Count > 3 then
        begin
          if IsNumeric(s[0]) then
          begin
            Result :=  IsValidUnixPerms(S[1]);
            if Result=False then
            begin
              Result := IsNumeric(s[1]) and IsValidUnixPerms(S[2]);
            end;
          end;
        end;
      finally
        Sys.FreeAndNil(s);
      end;
    end;
end;

class function TIdFTPLPUnix.IsUnitree(AData: string): Boolean;
var s : TIdStrings;
  begin
    s := TIdStringList.Create;
    try
      SplitColumns(AData,s);
      Result := (s.Count >4) and (PosInStrArray(s[4],UnitreeStoreTypes)<>-1);
      if Result=False then
      begin
        Result := IsUnitreeBanner(AData);
      end;
    finally
      Sys.FreeAndNil(s);
    end;
end;

class function TIdFTPLPUnix.IsUnitreeBanner(const AData: String): Boolean;
begin
  Result := (IndyPos('/',AData)=1) and (Copy(AData,Length(AData)-1,2)=').')
    and (IndyPos('(',AData)>0);
end;

class function TIdFTPLPUnix.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
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
  TParseUnixSteps = (pusinode, pusBlocks, pusPerm,pusCount,pusOwner,pusGroup,pusSize,pusMonth,pusDay,pusYear,pusTime,pusName,pusDone);
var
  LStep: TParseUnixSteps;
  LData, LTmp: String;
  LInode, LBlocks, LDir, LGPerm, LOPerm, LUPerm, LCount, LOwner, LGroup: String;
  LName, LSize, LLinkTo: String;
  wYear, wMonth, wDay: Word;
 // wYear, LCurrentMonth, wMonth, wDay: Word;
  wHour, wMin, wSec, wMSec: Word;
  ADate: TIdDateTime;
  i: Integer;
  LI : TIdUnixFTPListItem;

  function IsGOSwitches(const AString : String) : Boolean;
  var s : TIdStrings;
  //check to see if both the -g and -o switches were used.  Both
  //owner and group are surpressed in that case.  We have to check that
  //so our interpretation does not cause an error.
  begin
    Result := False;
    s := TIdStringList.Create;
    try
      SplitColumns(AString,s);
      if s.Count >2 then
      begin
        //if either inode or block count were given
        if  IsNumeric(s[0]) then
        begin
          s.Delete(0);
        end;
        //if both inode and block count were given
        if  IsNumeric(s[0]) then
        begin
          s.Delete(0);
        end;
        if s.Count > 5 then
        begin
          if StrToMonth(s[3])>0 then
          begin
            Result := IsNumeric(s[4]) and
              (IsNumeric(s[5]) or (IndyPos(':',s[5])>0));
          end;
        end;
      end;
    finally
      Sys.FreeAndNil(s);
    end;
  end;

  function FixBonkedYear(const AStrPart : String) : String;
  var LB : String;
  begin
    LB := AStrPart;
    Result := Fetch(LB);
    Result := Sys.StringReplace(Result,'-',' ');
    Result := Sys.StringReplace(Result,'/',' ');
    Result := Result + ' '+LB;
  end;

Begin
  LI := AItem as TIdUnixFTPListItem;
  // Get defaults for modified date/time
  ADate := Sys.Now;
  Sys.DecodeDate(ADate, wYear, wMonth, wDay);
  Sys.DecodeTime(ADate, wHour, wMin, wSec, wMSec);
  LData := AItem.Data;
  LStep := pusinode;
  while NOT (LStep = pusDone) do begin
    case LStep of
     pusinode: begin
        //we do it this way because the column for inode is right justified
        //and we don't want to create a problem if the -i parameter was never used

         LTmp := Sys.TrimLeft(LData);
         LTmp := Fetch(LTmp);
         if IsValidUnixPerms(LTmp) then
         begin
           LStep := pusPerm;
         end
         else
         begin
         //the inode column is right justified
           LData := Sys.TrimLeft(LData);
           LTmp := Fetch(LData);
           LData := Sys.TrimLeft(LData);
           LInode := LTmp;
           LStep := pusBlocks;
         end;
      end;
    pusBlocks: begin
    //Note that there is an ambigioutity because this value could
    //be the inode if only the -i switch was used.
         LTmp := Fetch(LData,' ',False);
         if IsValidUnixPerms(LTmp)=False then
         begin
           LTmp := Fetch(LData);
           LData := Sys.TrimLeft(LData);
           LBlocks := LTmp;
         end;
         LStep := pusPerm;
      end;
    pusPerm: begin//1.-rw-rw-rw-
      LTmp := Fetch(LData);
      LData := Sys.TrimLeft(LData);
      // Copy the predictable pieces
      LI.PermissionDisplay := Copy(LTmp,1,10);
      LDir := Sys.UpperCase(Copy(LTmp, 1, 1));
      LOPerm := Copy(LTmp, 2, 3);
      LGPerm := Copy(LTmp, 5, 3);
      LUPerm := Copy(LTmp, 8, 3);
      LStep := pusCount;
    end;
    pusCount: begin
      LData := Sys.TrimLeft(LData);
      LTmp := Fetch(LData);
      LData := Sys.TrimLeft(LData);

      //Patch for NetPresenz
      // "-------r--         326  1391972  1392298 Nov 22  1995 MegaPhone.sit" */
      // "drwxrwxr-x               folder        2 May 10  1996 network" */
      if TextIsSame(LTmp, 'folder') then begin  {do not localize}
        LStep := pusSize;
   //     LStep := pusMonth;
      end
      //APR
      //Patch for overflow -r--r--r--   0526478   128  Dec 30 2002  DE292000
      else begin
        if (Length(LTmp) > 3) and (LTmp[1] = '0') then begin
          LData := Copy(LTmp, 2, MaxInt) + ' ' + LData;
          LCount := '0';
        end
        else begin
          LCount := LTmp;
        end;
        //this check is necessary if both the owner and group were surpressed.
        if IsGOSwitches(AItem.Data) then
        begin
          LStep := pusSize;
        end
        else
        begin
          LStep := pusOwner;
        end;
      end;
      LData := Sys.TrimLeft(LData);
    end;
    pusOwner: begin
      LTmp := Fetch(LData);
      LData := Sys.TrimLeft(LData);
      LOwner := LTmp;
(*    if (SL[4] > '') and    {Do not Localize}
     //Ericsson Switch FTP returns empty owner.
     (SL[4][1] in ['A'..'Z','a'..'z']) then begin    {Do not Localize}
      SL.Insert(2, '');    {Do not Localize}
    end; *)
      LStep := pusGroup;
    end;
    pusGroup: begin
      LTmp := Fetch(LData);
      LData := Sys.TrimLeft(LData);
      LGroup := LTmp;
      LStep := pusSize;
    end;
    pusSize: begin
      //Ericsson - Switch FTP returns empty owner
      //Do not apply Ericson patch to Unitree
      if (CharIsInSet(LData, 1,CharRange('A','Z')+CharRange('a','z')))
       and (GetIdent <> UNITREE) then begin
        LSize := LGroup;
        LGroup := LOwner;
        LOwner := '';
        //we do this just after the erickson patch because
        //a few servers might return additional columns.
        //
        //e.g.
        //
        //drwx------  1          BUILTIN     NT AUTHORITY          0 Dec  7  2001 System Volume Information
        if (IsNumeric(LSize)=False) then
        begin
          //undo the Ericson patch
          LOwner := LGroup;
          LGroup := '';
          repeat
            LGroup := LGroup + ' '+LSize;
            LOwner := LGroup;
            LData := Sys.TrimLeft(LData);
            LSize := Fetch(LData);
          until (IsNumeric(LSize));
          //delete the initial space we had added in the repeat loop
          IdDelete(LGroup,1,1);
        end;
      end
      else begin
        LTmp := Fetch(LData);
        //This is necessary for cases where are char device is listed
        //e.g.
        //crw-rw-rw-   1 0        1         11, 42 Aug  8  2000 tcp
        //
        //Note sure what 11, 42 is so size is not returned.
        if IndyPos(',',LTmp)>0 then
        begin
          LData := Sys.TrimLeft(LData);
          Fetch(LData);
          LData := Sys.TrimLeft(LData);
          LSize := '';
        end
        else
        begin
          LSize := LTmp;
        end;
        LData := Sys.TrimLeft(LData);
        case PosInStrArray(LSize,UnitreeStoreTypes) of
          0 :  //AR - archived to tape - migrated
          begin
            if AItem is TIdUnitreeFTPListItem then
            begin
              (LI as TIdUnitreeFTPListItem).Migrated := True;
              (LI as TIdUnitreeFTPListItem).FileFamily := Fetch(LData);
            end;
            LData := Sys.TrimLeft(LData);
            LSize := Fetch(LData);
            LData := Sys.TrimLeft(LData);
          end;
          1 : //DK - disk
          begin
            if AItem is TIdUnitreeFTPListItem then
            begin
              (LI as TIdUnitreeFTPListItem).FileFamily := Fetch(LData);
            end;
            LData := Sys.TrimLeft(LData);
            LSize := Fetch(LData);
            LData := Sys.TrimLeft(LData);
          end;
        end;
      end;
      LStep := pusMonth;
    end;
    pusMonth: begin // Scan modified MMM
      //fix up a bonked date such as:
      //-rw-r--r--   1 root     other        531 09-26 13:45 README3
      LData := FixBonkedYear(LData);
        //we do this in case there's a space
      LTmp := Fetch(LData);
      if Length(LTmp)>3 then
      begin
        //must be a year
        wYear := Sys.StrToInt(LTmp,wYear);
        LTmp := Fetch(LData);
      end;
      LData := Sys.TrimLeft(LData);
      if IsNumeric(LTmp) then
      begin
        wMonth := Sys.StrToInt(LTmp,wMonth);
        if (wMonth>12) then
        begin
          wDay := wMonth;
          LTmp := Fetch(LData);
          LData := Sys.TrimLeft(LData);
          wMonth := Sys.StrToInt(LTmp,wMonth);
          LStep := pusYear;
        end
        else
        begin
          LStep := pusDay;
        end;
      end
      else
      begin
        wMonth := StrToMonth(LTmp);
        LStep := pusDay;
      end;
    end;
    pusDay: begin // Scan DD
      LTmp := Fetch(LData);
      LData := Sys.TrimLeft(LData);
      wDay := Sys.StrToInt(LTmp, wDay);
      LStep := pusYear;
    end;
    pusYear: begin
      LTmp := Fetch(LData);
      // Not time info, scan year
      if IndyPos(':', LTmp) = 0 then begin    {Do not Localize}
        wYear := Sys.StrToInt(LTmp, wYear);
        // Set time info to 00:00:00.999
        wHour := 0;
        wMin := 0;
        wSec := 0;
        wMSec := 999;
        LStep := pusName;
      end//if IndyPos(':', SL[7])=0    {Do not Localize}
      else begin // Time info, scan hour, min
        LStep := pusTime;
      end;
    end;
    pusTime: begin
      // correct year and Scan hour
      wYear := AddMissingYear(wDay,wMonth);
      wHour:= Sys.StrToInt(Fetch(LTmp,':'), 0);    {Do not Localize}
      // Set sec and ms to 0.999 except for Serv-U or FreeBSD with the -T parameter
      //with the -T parameter, Serve-U returns something like this:
      //
      //drwxrwxrwx   1 user     group           0 Mar  3 04:49:59 2003 upload
      //
      //instead of:
      //
      //drwxrwxrwx   1 user     group           0 Mar  3 04:49 upload
      if (IndyPos(':',LTmp)>0) and (IsNumeric(Fetch(LData,' ',False))) then
      begin
        // Scan minutes
        wMin :=Sys. StrToInt(Fetch(LTmp,':'), 0);
        wSec :=Sys. StrToInt(Fetch(LTmp,':'), 0);
        wMSec :=Sys. StrToInt(Fetch(LTmp,':'),999);
        LTmp := Fetch(LData);
        wYear :=Sys. StrToInt(LTmp, wYear);
      end
      else
      begin
      // Scan minutes
        wMin :=Sys. StrToInt(Fetch(LTmp,':'), 0);
        wSec :=Sys. StrToInt(Fetch(LTmp,':'), 0);
        wMSec :=Sys. StrToInt(Fetch(LTmp),999);
      end;
      LStep := pusName;
    end;
    pusName: begin
      LName := LData;
      LStep := pusDone;
    end;
    end;//case LStep
  end;//while
    AItem.ItemType := ditFile;
    if LDir<>'' then
    begin
      case LDir[1] of
        'D' : AItem.ItemType := ditDirectory;  {Do not Localize}
        'L' : AItem.ItemType := ditSymbolicLink; {Do not Localize}
        'B' : AItem.ItemType := ditBlockDev; {Do not Localize}
        'C' : AItem.ItemType := ditCharDev; {Do not Localize}
        'P' : AItem.ItemType := ditFIFO;  {Do not Localize}
        'S' : AItem.ItemType := ditSocket;   {Do not Localize}
      end;
    end;
    LI.UnixOwnerPermissions := LOPerm;
    LI.UnixGroupPermissions := LGPerm;
    LI.UnixOtherPermissions := LUPerm;
    LI.LinkCount :=Sys. StrToInt(LCount, 0);
    LI.OwnerName := LOwner;
    LI.GroupName := LGroup;
    LI.Size := Sys.StrToInt64(LSize, 0);
    LI.ModifiedDate := Sys.EncodeDate(wYear, wMonth, wDay) + Sys.EncodeTime(wHour, wMin, wSec, wMSec);

    if LI.ItemType = ditSymbolicLink then begin
      i := IndyPos(UNIX_LINKTO_SYM, LName);    {Do not Localize}
      LLinkTo := Copy(LName, i + 4, Length(LName) - i - 3);
      LName := Copy(LName, 1, i - 1);
      //with ls -F (DIR -F in FTP, you will sometimes symbolic links with the linked
      //to item file name ending with a /.  That indicates that the item being pointed to
      //is a directory
      if (LLinkTo <> '') and (LLinkTo[Length(LLinkTo)]=PATH_FILENAME_SEP_UNIX) then
      begin
        LI.ItemType := ditSymbolicLinkDir;
        LLinkTo := Copy(LLinkTo,1,Length(LLinkTo)-1);
      end;
      LI.LinkedItemName := LLinkTo;
    end;
    LI.NumberBlocks :=Sys.StrToInt(LBlocks,0);
    LI.Inode :=Sys.StrToInt(linode,0);
    //with servers using ls -F, / is returned after the name of dir names and a *
    //will be returned at the end of a file name for an executable program.
    //Based on info at http://www.skypoint.com/help/tipgettingaround.html
    //Note that many FTP servers obtain their DIR lists by piping output from the /bin/ls -l command.
    //The -F parameter does work with ftp.netscape.com and I have also tested a NcFTP server
    //which simulates the output of the ls command.
    if (CharIsInSet(LName, Length(LName), PATH_FILENAME_SEP_UNIX+'*')) then
    begin
      LName := Copy(LName,1,Length(LName)-1);
    end;

  if APath<>'' then
  begin
  // a path can sometimes come into the form of:
  //  pub:
  // or
  //  ./pub
  //
  //Deal with both cases
    LI.LocalFileName := LName;
    LName := APath + PATH_FILENAME_SEP_UNIX + LName;
    if Copy(LName,1,Length(UNIX_CURDIR))=UNIX_CURDIR then
    begin
      IdDelete(LName,1,Length(PATH_FILENAME_SEP_UNIX));
      if Copy(LName,1,Length(PATH_FILENAME_SEP_UNIX))=PATH_FILENAME_SEP_UNIX then
      begin
        IdDelete(LName,1,Length(PATH_FILENAME_SEP_UNIX));
      end;
    end;
  end;
  LI.FileName := LName;
  Result := True;
end;

class function TIdFTPLPUnix.ParseListing(AListing: TIdStrings;
  ADir: TIdFTPListItems): boolean;
var i : Integer;
  LPathSpec : String;
  LItem : TIdFTPListItem;
begin
  for i := 0 to AListing.Count -1 do
  begin
    if (AListing[i] ='') or IsTotalLine(AListing[i]) or IsUnixLsErr(AListing[i])
    or (IsUnitreeBanner(AListing[i])) then
    begin
    end
    else
    begin
       //workaround for the XBox MediaCenter FTP Server
      //which returns something like this:
      //
      //dr-xr-xr-x    1 ftp      ftp            1 Feb 23 00:00 D:
      //and the trailing : is falsely assuming that a ":" means
      //a subdirectory entry in a recursive list.
      if (not InternelChkUnix(AListing[i])) and IsSubDirContentsBanner(AListing[i]) then
      begin
        LPathSpec := Copy(AListing[i],1,Length(AListing[i])-1);
      end
      else
      begin
        LItem := MakeNewItem(ADir);
        LItem.Data := AListing[i];
        ParseLine(LItem, LPathSpec);
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

class function TIdFTPLPUnitree.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
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
