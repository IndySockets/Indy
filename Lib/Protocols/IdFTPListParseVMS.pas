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
  Rev 1.12    2/23/2005 6:34:28 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.11    10/26/2004 10:03:22 PM  JPMugaas
  Updated refs.

  Rev 1.10    7/31/2004 1:08:24 PM  JPMugaas
  Now should handle listings without time.

  Rev 1.9    6/21/2004 10:57:42 AM  JPMugaas
  Now indicates that ModifiedDate and File Size are not available if VMS
  returns an error in the entry.

  Rev 1.8    6/11/2004 9:35:08 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.7    6/7/2004 3:47:48 PM  JPMugaas
  VMS Recursive Dir listings now supported.  This is done with a [...].  Note
  that VMS does have some strange syntaxes with their file system.

  Rev 1.6    4/20/2004 4:01:16 PM  JPMugaas
  Fix for nasty typecasting error.  The wrong create was being called.

  Rev 1.5    4/19/2004 5:05:18 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.4    2004.02.03 5:45:16 PM  czhower
  Name changes

  Rev 1.3    10/19/2003 3:48:12 PM  DSiders
  Added localization comments.

  Rev 1.2    10/1/2003 12:53:08 AM  JPMugaas
  Indicated that VMS returns block sizes.  Note that in VMS, the traditional
  block size is 512 bytes (this is a fixed constant).

  Rev 1.1    4/7/2003 04:04:36 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 02:01:58 AM  JPMugaas
  Individual parsing objects for the new framework.
}
unit IdFTPListParseVMS;

{
  This parser works with VMS (OpenVMS) systems including UCX, MadGoat, Multinet,
  VMS TCPWare, plus some non-multinet systems.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdVMSFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FGroupName : String;
    FVMSOwnerPermissions: String;
    FVMSWorldPermissions: String;
    FVMSSystemPermissions: String;
    FVMSGroupPermissions: String;
    FNumberBlocks : Integer;
    FBlockSize : Integer;
    FVersion : Integer;
  public
    property GroupName : String read FGroupName write FGroupName;
    //VMS File Protections
    //These are different than Unix.  See:
    //See http://www.djesys.com/vms/freevms/mentor/vms_prot.html#prvs

    property VMSSystemPermissions : String read FVMSSystemPermissions write FVMSSystemPermissions;
    property VMSOwnerPermissions : String read FVMSOwnerPermissions write FVMSOwnerPermissions;
    property VMSGroupPermissions : String read FVMSGroupPermissions write FVMSGroupPermissions;
    property VMSWorldPermissions : String read FVMSWorldPermissions write FVMSWorldPermissions;
    property Version : Integer read FVersion write FVersion;
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
    property BlockSize : Integer read FBlockSize write FBlockSize;
  end;

  TIdFTPLPVMS = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsVMSHeader(const AData: String): Boolean;
    class function IsVMSFooter(const AData: String): Boolean;
    class function IsContinuedLine(const AData: String): Boolean;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : Boolean; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseVMS"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings,
  SysUtils;

{ TIdFTPLPVMS }

class function TIdFTPLPVMS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LData : String;
  i : Integer;
begin
  Result := False;
    for i := 0 to AListing.Count - 1 do
    begin
      if AListing[i] <> '' then
      begin
        LData := AListing[i];
        Result := Length(LData) > 1;
        if Result then
        begin
          Result := IsVMSHeader(LData);
          //see if file listing starts a file name
          if not Result then
          begin
            LData := Fetch(LData);
            Fetch(LData, ';');  {do not localize}
            Result := IsNumeric(LData);
          end;
        end;
        Break;
      end;
    end;
end;

class function TIdFTPLPVMS.GetIdent: String;
begin
  Result := 'VMS';  {do not localize}
end;

class function TIdFTPLPVMS.IsContinuedLine(const AData: String): Boolean;
begin
  Result := TextStartsWith(AData, ' ') and (IndyPos(';', AData) = 0); {do not localize}
end;

class function TIdFTPLPVMS.IsVMSFooter(const AData: String): Boolean;
var
  LData : String;
begin
  //The bottum banner may be in the following forms:
  //Total of 1 file, 0 blocks.
  //Total of 6 Files, 1582 Blocks.
  //Total of 90 files.
  //Grand total of 87 directories, 2593 files, 2220036 blocks.
  //*.*;               <%RMS-E-FNF, file not found>

  //VMS returns TOTAL at the end.  We test for " files" at the end of the line
  //so we don't break something with another parser.
  LData := UpperCase(AData);
  Result := TextStartsWith(LData, 'TOTAL OF ') or {do not localize}
            TextStartsWith(LData, 'GRAND TOTAL OF '); {do not localize}
  if Result then
  begin
    Result := (IndyPos(' FILE', LData) > 9);        {do not localize}
    if not Result then begin
      Result := Fetch(LData) = '*.*;';              {do not localize}
    end;
  end;
end;

class function TIdFTPLPVMS.IsVMSHeader(const AData: String): Boolean;
begin
  Result := TextEndsWith(AData, ']') and  {Do not localize}
            (IndyPos(':[', AData) > 0);   {Do not localize}
end;

class function TIdFTPLPVMS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVMSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVMS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer, LBuf2, LLine : String;
  LDay, LMonth, LYear : Integer;
  //LHour, LMinute, LSec : Integer;
  LCols : TStrings;
  LOwnerIdx : Integer;
  LVMSError : Boolean;
  LI : TIdVMSFTPListItem;
begin
  {
           1         2         3         4         5         6
  1234567890123456789012345678901234567890123456789012345678901234567890
  BILF.C;2                13  5-JUL-1991 12:00 [1,1] (RWED,RWED,RE,RE)


   and non-MutliNet VMS:

  CII-MANUAL.TEX;1  213/216  29-JAN-1996 03:33:12  [ANONYMOU,ANONYMOUS]   (RWED,RWED,,)

  or possibly VMS TCPware V5.5-3

  .WELCOME;1                 2  13-FEB-2002 23:32:40.47
  }
  LI := AItem as TIdVMSFTPListItem;
  LVMSError := False;

  LLine := LI.Data;
  // Charon VAX 5.4.2 uses tabs between some of its columns and spaces between others
  LLine := ReplaceAll(LLine, #9, ' ');
  //File Name
  //We do this in a roundabout way because spaces in VMS files may actually
  //be legal and that throws of a typical non-position based column parser.
  //this assumes that the file contains a ";".  In VMS, this separates the name
  //from the version number.
  LBuffer := Fetch(LLine, ';'); {do not localize}
  LI.LocalFileName := LowerCase(LBuffer);
  LBuf2 := Fetch(LLine);
  //Some FTP servers might follow the filename with a tab and than
  //give an error such as this:
  //1KBTEST.PTF;10#9No privilege for attempted operation
  LI.Version := IndyStrToInt(LBuf2, 0);
  LBuffer := LBuffer + ';' + LBuf2; {do not localize}

  //Dirs have to be processed differently then
  //files because a version mark and .DIR exctension
  //are not used to CWD into a subdir although they are
  //listed in a dir listed.
  if (IndyPos('.DIR;', LBuffer) > 0) then {do not localize}
  begin
    AItem.ItemType := ditDirectory;
    //note that you can NOT simply do a Fetch('.') to extract the dir name
    //you use with a CD because the period is also a separator between pathes
    //
    //e.g.
    //
    //[VMSSERV.FILES]ALARM.DIR;1      1/3          5-MAR-1993 18:09
    if IndyPos(PATH_FILENAME_SEP_VMS, LBuffer) = 0 then begin
      LBuf2 := '';
    end else begin
      LBuf2 := Fetch(LBuffer, PATH_FILENAME_SEP_VMS) + PATH_FILENAME_SEP_VMS; {Do not localize}
    end;
    AItem.FileName := LBuf2 + Fetch(LBuffer, '.'); {do not localize}
    AItem.LocalFileName := LowerCase(AItem.FileName);
  end else
  begin
    AItem.ItemType := ditFile;
    AItem.FileName := LBuffer;
  end;
  if APath <> '' then begin
    AItem.FileName := APath + AItem.FileName;
  end;
  LCols := TStringList.Create;
  try
    SplitDelimitedString(LLine, LCols, True);
    LOwnerIdx := 3;
    //if this isn't numeric, there may be an error that is
    //is reported in the File list.  Do not parse the line further.
    if LCols.Count > 0 then
    begin
      LBuffer := LCols[0];
      LBuffer := Fetch(LBuffer, '/');
      if IsNumeric(LBuffer) then
      begin
        //File Size
        LI.NumberBlocks :=  IndyStrToInt(LBuffer, 0);
        LI.BlockSize := VMS_BLOCK_SIZE;
        LI.Size := IndyStrToInt64(LBuffer, 0) * VMS_BLOCK_SIZE; //512 is the size of a VMS block
      end else
      begin
        //on the UCX VMS server, the file size might not be reported.  Probably the file owner
        if not TextStartsWith(LCols[0], '[') then {do not localize}
        begin
          if not IsNumeric(LCols[0], 1, 1) then
          begin
            //the server probably reported an error in the FTP list such as no permission
            //we need to stop right there.
            LVMSError := True;
            AItem.SizeAvail := False;
            AItem.ModifiedAvail := False;
          end;
        end else begin
          LOwnerIdx := 0;
        end;
      end;
      if not LVMSError then
      begin
        if LOwnerIdx > 0 then
        begin
          //Date
          if LCols.Count > 1 then
          begin
            LBuffer := LCols[1];
            LDay := IndyStrToInt(Fetch(LBuffer, '-'), 1); {do not localize}
            LMonth := StrToMonth(Fetch(LBuffer, '-')); {do not localize}
            LYear := IndyStrToInt(Fetch(LBuffer), 1989);
            LI.ModifiedDate := EncodeDate(LYear, LMonth, LDay);
          end;
          //Time
          if LCols.Count > 2 then
          begin
            //Modified Time of Day
            //Some dir listings might be missing the time
            //such as this:
            //
            //vms_dir_2.DIR;1  1 19-NOV-2001 [root,root] (RWE,RWE,RE,RE)

            if IndyPos(':', LCols[2]) = 0 then begin {do not localize}
              Dec(LOwnerIdx);
            end else begin
              LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[2]);
            end;
          end;
        end;
        //Owner/Group
        //This is in the order of Group/Owner
        //See:
        // http://seqaxp.bio.caltech.edu/www/vms_beginners_faq.html#FILE00
        if LCols.Count > LOwnerIdx then
        begin
          LBuffer := LCols[LOwnerIdx];
          Fetch(LBuffer, '['); {do not localize}
          LBuffer := Fetch(LBuffer,']');
          LI.GroupName := Trim(Fetch(LBuffer, ',')); {do not localize}
          LI.OwnerName := Trim(LBuffer); {do not localize}
        end;
        //Protections
        if LCols.Count > (LOwnerIdx+1) then
        begin
          LBuffer := LCols[LOwnerIdx+1];
          Fetch(LBuffer, '('); {do not localize}
          LBuffer := Fetch(LBuffer, ')'); {do not localize}
          LI.PermissionDisplay := '(' + LBuffer + ')'; {do not localize}
          LI.VMSSystemPermissions := Trim(Fetch(LBuffer, ',')); {do not localize}
          LI.VMSOwnerPermissions := Trim(Fetch(LBuffer, ',')); {do not localize}
          LI.VMSGroupPermissions := Trim(Fetch(LBuffer, ',')); {do not localize}
          LI.VMSWorldPermissions := Trim(LBuffer);
        end;
      end;
    end;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

class function TIdFTPLPVMS.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  i : Integer;
  LItem : TIdFTPListItem;
  LStartLine, LEndLine : Integer;
  LRootPath : String; //needed for recursive dir listings "DIR [...]"
  LRelPath : String;
begin
  {
  VMS is really a ball because the listing
  can start and end with blank lines as well as a begging and ending
  banner
  }
  LStartLine := 0;
  LRelPath := '';
  LEndLine := AListing.Count-1;
  for i := 0 to LEndLine do
  begin
    if IsWhiteString(AListing[i]) then begin
      Inc(LStartLine);
    end else
    begin
      if IsVMSHeader(AListing[i]) then
      begin
        LRootPath := AListing[i];

        //to make things easy, we will only use entire banner for deteriming a subdir
        //such as this:
        //
        //Directory ANONYMOUS_ROOT:[000000.VMS-FREEWARE.NARNIA]
        // if
        //Directory ANONYMOUS_ROOT:[000000.VMS-FREEWARE.NARNIA.COM]
        // then result = [.COM]

        LRootPath := Fetch(LRootPath, PATH_FILENAME_SEP_VMS) + '.'; {do not localize}
        Inc(LStartLine);
      end;
      Break;
    end;
  end;
  //find the end of our parsing
  for i := LEndLine downto LStartLine do
  begin
    if IsWhiteString(AListing[i]) or IsVMSFooter(AListing[i]) then begin
      Dec(LEndLine);
    end else begin
      Break;
    end;
  end;
  for i := LStartLine to LEndLine do
  begin  
    if not IsWhiteString(AListing[i]) then
    begin
      if IsVMSHeader(AListing[i]) then
      begin
        //+1 is used because there's a period that we are dropping and then adding back
        LRelPath := Copy(AListing[i], Length(LRootPath)+1, MaxInt);
        LRelPath := VMS_RELPATH_PREFIX + LRelPath;
      end
      else if not IsContinuedLine(AListing[i]) then //needed because some VMS computers return entries with multiple lines
      begin
        LItem := MakeNewItem(ADir);
        LItem.Data := UnfoldLines(AListing[i], i, AListing);
        Result := ParseLine(LItem, LRelPath);
        if not Result then
        begin
          FreeAndNil(LItem);
          Exit;
        end;
      end;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPVMS);
finalization
  UnRegisterFTPListParser(TIdFTPLPVMS);

end.
