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
  Rev 1.8    2/24/2005 10:01:34 AM  JPMugaas
  Fixed estimation of filesize for variable record length files (V) in z/VM to
  conform to what was specified in:

  z/VMTCP/IP User’s Guide Version 5 Release 1.0

  This will not always give the same estimate as the server would when listing
  in Unix format "SITE LISTFORMAT UNIX" because we can't know the block size
  (we have to assume a size of 4096).

  Rev 1.7    10/26/2004 10:03:20 PM  JPMugaas
  Updated refs.

  Rev 1.6    9/7/2004 10:02:30 AM  JPMugaas
  Tightened the VM/BFS parser detector so that valid dates have to start the
  listing item.  This should reduce the likelyhood of error.

  Rev 1.5    6/28/2004 4:34:18 AM  JPMugaas
  VM_CMS-ftp.marist.edu-7.txt was being detected as VM/BFS instead of VM/CMS
  causing a date encode error.

  Rev 1.4    4/19/2004 5:05:32 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:22 PM  czhower
  Name changes

    Rev 1.2    10/19/2003 3:48:12 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:04:30 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 04:18:20 AM  JPMugaas
  More things restructured for the new list framework.
}

unit IdFTPListParseVM;

{
  IBM VM and z/VM parser
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdVMCMSFTPListItem = class(TIdRecFTPListItem)
  protected
    FOwnerName : String;
    FNumberBlocks : Integer;
  public
    property RecLength : Integer read FRecLength write FRecLength;
    property RecFormat : String read FRecFormat write FRecFormat;
    property NumberRecs : Integer read FNumberRecs write FNumberRecs;
    property OwnerName : String read FOwnerName write FOwnerName;
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
  end;

  TIdVMVirtualReaderFTPListItem = class(TIdFTPListItem)
  protected
    FNumberRecs : Integer;
  public
     constructor Create(AOwner: TCollection); override;
    property NumberRecs : Integer read FNumberRecs write FNumberRecs;
  end;

  TIdVMBFSFTPListItem = class(TIdFTPListItem);

  TIdFTPLPVMCMS = class(TIdFTPListBaseHeaderOpt)
  protected
    class function IsHeader(const AData : String): Boolean; override;
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
    class function CheckListingAlt(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  TIdFTPLPVMBFS = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdFTPLVirtualReader = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;

  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseVM"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

function IsFileMode(const AStr : String) : Boolean;
begin
  Result := CharIsInSet(AStr,1,'ABCDEFGHIJKLMNOPQRSTUV') and
    CharIsInSet(AStr,2,'0123456');
end;

{ TIdFTPLPVMCMS }

class function TIdFTPLPVMCMS.CheckListingAlt(AListing: TStrings; const ASysDescript: String;
  const ADetails: Boolean): Boolean;
const
  VMTypes : array [1..3] of string = ('F','V','DIR'); {do not localize}
var
  LData : String;

begin
  Result := False;
  if AListing.Count > 0 then begin
    LData := AListing[0];
    if IsFileMode(Trim(Copy(LData, 19, 3))) then begin
       Result := PosInStrArray(Trim(Copy(LData, 22, 3)), VMTypes) <> -1;
       if Result then begin
         Result := IsMMDDYY(Trim(Copy(LData,52,10)),'/');
       end;
    end else begin
      Result := PosInStrArray(Trim(Copy(LData, 19, 3)), VMTypes) <> -1;
      if Result then begin
        Result := (Copy(LData, 56, 1) = '/') and (Copy(LData, 59, 1) = '/'); {do not localize}
        if not Result then begin
          Result := (Copy(LData, 58, 1) = '-') and (Copy(LData, 61, 1) = '-'); {do not localize}
          if not Result then begin
            Result := (Copy(LData, 48, 1) = '-') and (Copy(LData, 51, 1) = '-'); {do not localize}
          end;
        end;
      end;
    end;
  end;
end;

class function TIdFTPLPVMCMS.GetIdent: String;
begin
  Result := 'VM/CMS'; {do not localize}
end;

class function TIdFTPLPVMCMS.IsHeader(const AData: String): Boolean;
begin
  Result := Trim(AData) = 'Filename FileType  Fm Format Lrecl  Records Blocks Date      Time'
end;

class function TIdFTPLPVMCMS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVMCMSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVMCMS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
  LCols : TStrings;
  LI : TIdVMCMSFTPListItem;
  LSize : Int64;
  LPRecLn,LLRecLn : Integer;
  LPRecNo, LLRecNo : Integer;
  LPBkNo,LLBkNo : Integer;
  LPCol : Integer;
begin
{Some of this is based on the following:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=4e7k0p%24t1v%40blackice.winternet.com&rnum=4&prev=/groups%3Fq%3DVM%2BFile%2BRecords%2Bdirectory%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26selm%3D4e7k0p%2524t1v%2540blackice.winternet.com%26rnum%3D4

and

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&selm=DLspv2.G2w%40epsilon.com&rnum=2
}
{
123456789012345678901234567890123456789012345678901234567890123456789012
         1         2         3         4         5         6         7
OMA00215 PLAN     V         64         28          1  6/26/02  9:33:21 -
WEBSHARE          DIR        -          -          -  5/30/97 18:44:17 -

or

README   ANONYMOU V         71         26          1 1997-04-02 12:33:20 TCP291

or maybe this:

ENDTRACE TCPIP    F      80       1      1 1999-07-28 12:24:01 TCM191
123456789012345678901234567890123456789012345678901234567890123456789012
         1         2         3         4         5         6         7

or possibly this FILELIST format:

Filename FileType  Fm Format Lrecl  Records Blocks Date      Time
LASTING  GLOBALV   A1 V      41     21     1       9/16/91   15:10:32
J43401   NETLOG    A0 V      77     1      1       9/12/91   12:36:04
PROFILE  EXEC      A1 V      17     3      1       9/12/91   12:39:07
DIRUNIX  SCRIPT    A1 V      77     1216   17      1/04/93   20:30:47
MAIL     PROFILE   A2 F      80     1      1       10/14/92  16:12:27
BADY2K   TEXT      A0 V      1      1      1       1/03/102  10:11:12
AUTHORS            A1 DIR    -      -      -       9/20/99   10:31:11
---------------

123456789012345678901234567890123456789012345678901234567890123456789012
         1         2         3         4         5         6         7

}
  LI := AItem as TIdVMCMSFTPListItem;
  //File Name
  LI.FileName := Trim(Copy(AItem.Data, 1, 8));
  //File Type - extension
  if LI.Data[9] = ' ' then begin
    LBuffer := Copy(AItem.Data, 10, 9);
  end else begin
    LBuffer := Copy(AItem.Data, 9, 9);
  end;
  LBuffer := Trim(LBuffer);
  if LBuffer <> '' then begin
    LI.FileName := LI.FileName + '.' + LBuffer; {do not localize}
  end;
  //Record format
  LBuffer := Trim(Copy(AItem.Data, 19, 3));
  if IsFileMode(LBuffer) then begin
    LBuffer := Trim(Copy(AItem.Data, 23, 3));
    LPRecLn := 30;
    LLRecLn :=  7;
    LPRecNo := 37;
    LLRecNo := 7;
    LPBkNo := 44;
    LLBkNo := 8;
    LPCol := 52;
  end else begin
    LPRecLn := 22;
    LLRecLn := 9;
    LPRecNo := 31;
    LLRecNo := 11;
    LPBkNo := 42;
    LLBkNo := 11;
    if (Copy(AItem.Data, 48, 1) = '-') and (Copy(AItem.Data, 51, 1) = '-') then begin {do not localize}
      LPCol := 44;
    end else begin
      LPCol := 54;
    end;
  end;
  LI.RecFormat := LBuffer;
  if LI.RecFormat = 'DIR' then begin {do not localize}
    LI.ItemType := ditDirectory;
    LI.RecLength := 0;
  end else begin
    LI.ItemType := ditFile;
    //Record Length - for files
    LBuffer := Copy(AItem.Data, LPRecLn, LLRecLn);
    LI.RecLength := IndyStrToInt(LBuffer, 0);
    //Record numbers
    LBuffer := Trim(Copy(AItem.Data, LPRecNo, LLRecNo));
    LBuffer := Fetch(LBuffer);
    LI.NumberRecs := IndyStrToInt(LBuffer, 0);
    //Number of Blocks
    {
    From:

    http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&selm=DLspv2.G2w%40epsilon.com&rnum=2

    Block sizes can be 800, 512, 1024,
    2048, or 4096, per the whim of the user.  IBM loves 4096, but it wastes
    space (just like on FAT partitions on DOS.)

    For F files (any type which begins with F), record count times logical
    record length.

    For V files, you need to read the file for an exact count, or the block
    size (times block count) for a good guess.  In other words, you're up
    the creek because you don't KNOW the block size.  Use record size times
    record length for a _maximum_ file size.

    Anyway, you can not know from the directory list.
    }
    LBuffer := Trim(Copy(AItem.Data, LPBkNo, LLBkNo));
    LI.NumberBlocks := IndyStrToInt(LBuffer, 0);
    LI.Size := LI.RecLength * LI.NumberRecs;
    //File Size - note that this is just an estimiate

    {From:
    z/VMTCP/IP User’s Guide Version 5 Release 1.0
    © Copyright International Business Machines Corporation 1987, 2004.
    All rights reserved.

    For fixed-record (F) format minidisk and SFS files,
    the size field indicates the actual size of a file.
    For variable-record (V) format minidisk and SFS files,
    the size field contains an estimated file size, this
    being the lesser value determined by:

    – the number of records in the file and its maximum record length
    – the size and number of blocks required to maintain the file.

    For virtual reader files, a size of 0 is always indicated.}

    if LI.RecFormat = 'V' then begin
      LSize := LI.NumberBlocks * 4096;
      if LI.Size > LSize then begin
        LI.Size := LSize;
      end;
    end;
    if LI.RecFormat = 'DIR' then begin
      LI.SizeAvail := False;
    end;
  end;
  LCols := TStringList.Create;
  try
    // we do things this way for the rest because vm.sc.edu has
    // a variation on VM/CMS that does directory dates differently
    //and some columns could be off.
    //Note that the start position in one server it's column 44 while in others, it's column 54
    // handle both cases.
    LBuffer := Trim(Copy(AItem.Data, LPCol, MaxInt));
    SplitDelimitedString(LBuffer, LCols, True);
    //LCols - 0 - Date
    //LCols - 1 - Time
    //LCols - 2 - Owner if present
    if LCols.Count > 0 then begin
      //date
      if IsNumeric(LCols[0], 3) then begin
        // vm.sc.edu date stamps yyyy-mm-dd
        LI.ModifiedDate := DateYYMMDD(LCols[0]);
      end else begin
        //Note that the date is displayed as 2 digits not 4 digits
        //mm/dd/yy
        LI.ModifiedDate := DateMMDDYY(LCols[0]);
      end;
      //time
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[1]);
      //owner
      if (LCols.Count > 2) and (LCols[2] <> '-') then begin {do not localize}
        LI.OwnerName := LCols[2];
      end;
    end;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVMBFS }

{List format like:

===
05/20/2000 13:38:19 F 1 65758 ’bfsline.cpy’
05/19/2000 11:02:15 F 1 65758 ’bfsline.txt’
06/03/2000 12:27:48 F 1 15414 ’bfstest.cpy’
05/20/2000 13:38:05 F 1 15414 ’bfstest.output’
05/20/2000 13:38:42 F 1 772902 ’bfswork.output’
03/31/2000 15:49:27 F 1 782444 ’bfswork.txt’
05/20/2000 13:39:20 F 1 13930 ’lotsonl.putdata’
05/19/2000 09:41:21 F 1 13930 ’lotsonl.txt’
06/15/2000 09:29:25 F 1 278 ’mail.maw’
05/20/2000 13:39:34 F 1 278 ’mail.putdata’
05/20/2000 15:30:45 F 1 13930 ’nls.new’
05/20/2000 14:02:24 F 1 13931 ’nls.txt’
08/21/2000 10:03:17 F 1 328 ’rock.rules’
05/20/2000 13:40:05 F 1 58 ’testfil2.putdata’
04/26/2000 14:34:42 F 1 63 ’testfil2.txt’
08/21/2000 05:28:40 D - - ’ALTERNATE’
12/28/2000 17:36:19 D - - ’FIRST
===
}
class function TIdFTPLPVMBFS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : TStrings;
begin
  Result := False;

  if AListing.Count > 0 then begin
    //should have a "'" as the terminator
    if AListing[0] <> '' then begin
      if not TextEndsWith(AListing[0], '''') then begin
        Exit;
      end;
    end;
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      if s.Count > 4 then begin
        if not IsMMDDYY(s[0], '/') then begin {do not localize}
          Exit;
        end;
        Result := CharIsInSet(s[2], 1, 'FD'); {do not localize}
        if Result then begin
          Result := IsNumeric(s[4]) or (s[4] <> '-'); {do not localize}
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVMBFS.GetIdent: String;
begin
  Result := 'VM/BFS'; {do not localize}
end;

class function TIdFTPLPVMBFS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVMBFSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVMBFS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
  LCols : TStrings;
begin
  // z/VM Byte File System

  //This is based on:
  //
  //   z/VM: TCP/IP Level 430 User's Guide Version 4 Release 3.0
  //
  // http://www.vm.ibm.com/pubs/pdf/hcsk7a10.pdf
  //
  LBuffer := AItem.Data;
  LCols := TStringList.Create;
  try
    SplitDelimitedString(Fetch(LBuffer, #39), LCols, True); {do not localize}
    //0 - date
    //1 - time
    //2 - (D) dir or file (F)
    //3 - not sure what this is
    //4 - file size
    AItem.FileName :=  LBuffer;
    if TextEndsWith(AItem.FileName, '''') then begin
      AItem.FileName := Copy(AItem.FileName, 1, Length(AItem.FileName)-1);
    end;
    //date
    if LCols.Count > 0 then begin
      AItem.ModifiedDate := DateMMDDYY(LCols[0]);
    end;
    if LCols.Count > 1 then begin
      AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[1]);
    end;
    if LCols.Count > 2 then
    begin
      if LCols[2] = 'D' then begin
        AItem.ItemType := ditDirectory;
      end else begin
        AItem.ItemType := ditFile;
      end;
    end;
    //file size
    if LCols.Count > 4 then begin
      if IsNumeric(LCols[3]) then begin
        AItem.Size := IndyStrToInt64(LCols[4], 0);
        AItem.SizeAvail := True;
      end else begin
        AItem.SizeAvail := False;
      end;
    end;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLVirtualReader }

class function TIdFTPLVirtualReader.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : TStrings;
begin
  Result := False;
  if AListing.Count > 0 then begin
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      if s.Count > 2 then begin
        if (Length(s[0]) = 4) and IsNumeric(s[0]) then begin
          Result := (Length(s[2]) = 8) and (IsNumeric(s[2]));
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLVirtualReader.GetIdent: String;
begin
  Result := 'VM Virtual Reader';  {do not localize}
end;

class function TIdFTPLVirtualReader.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVMVirtualReaderFTPListItem.Create(AOwner);
end;

class function TIdFTPLVirtualReader.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
  LI : TIdVMVirtualReaderFTPListItem;
begin
  // z/VM Byte File System

  //This is based on:
  //
  //   z/VM: TCP/IP Level 430 User's Guide Version 4 Release 3.0
  //
  // http://www.vm.ibm.com/pubs/pdf/hcsk7a10.pdf
  //
  LI := AItem as TIdVMVirtualReaderFTPListItem;
  LCols := TStringList.Create;
  try
    // z/VM Virtual Reader (RDR)
    //Col 0 - spool ID
    //Col 1 - origin
    //Col 2 - records
    //Col 3 - date
    //Col 4 - time
    //Col 5 - filename
    //Col 6 - file type
    SplitDelimitedString(AItem.Data, LCols, True);
    if LCols.Count > 5 then begin
      LI.FileName := LCols[5];
    end;
    if LCols.Count > 6 then begin
      LI.FileName := LI.FileName + '.' + LCols[6]; {do not localize}
    end;
    //record count
    if LCols.Count > 2 then begin
      LI.NumberRecs := IndyStrToInt(LCols[2], 0);
    end;
    //date
    if LCols.Count > 3 then begin
      LI.ModifiedDate := DateYYMMDD(LCols[3]);
    end;
    //Time
    if LCols.Count > 4 then begin
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[1]);
    end;
    //Note that IBM does not even try to give an estimate
    //with reader file sizes when emulating Unix. We can't support file sizes
    //with this.
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdVMVirtualReaderFTPListItem }

constructor TIdVMVirtualReaderFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  //There's no size for things in a virtual reader
  SizeAvail := False;
end;

initialization
  RegisterFTPListParser(TIdFTPLVirtualReader);
  RegisterFTPListParser(TIdFTPLPVMBFS);
  RegisterFTPListParser(TIdFTPLPVMCMS);
finalization
  UnRegisterFTPListParser(TIdFTPLVirtualReader);
  UnRegisterFTPListParser(TIdFTPLPVMBFS);
  UnRegisterFTPListParser(TIdFTPLPVMCMS);

end.
