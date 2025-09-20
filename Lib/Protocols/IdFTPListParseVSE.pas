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
  Rev 1.6    10/26/2004 10:03:22 PM  JPMugaas
  Updated refs.

  Rev 1.5    4/19/2004 5:05:34 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.4    2004.02.03 5:45:24 PM  czhower
  Name changes

  Rev 1.3    1/23/2004 12:44:52 PM  SPerry
  fixed set problems

  Rev 1.2    10/19/2003 3:48:14 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:04:38 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 04:18:24 AM  JPMugaas
  More things restructured for the new list framework.
}

unit IdFTPListParseVSE;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPCommon, IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdVSERootDirFTPListItem = class(TIdMinimalFTPListItem);

  TIdVSELibraryFTPListItem = class(TIdFTPListItem)
  protected
    FNumberBlocks : Integer;
  public
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
  end;

  TIdVSEPowerQueueFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FVSEPQDisposition : TIdVSEPQDisposition;
    FVSEPQPriority : Integer;
    FNumberRecs : Integer;
  public
    property NumberRecs : Integer read FNumberRecs write FNumberRecs;
    property VSEPQDisposition : TIdVSEPQDisposition read FVSEPQDisposition write FVSEPQDisposition;
    property VSEPQPriority : Integer read FVSEPQPriority write FVSEPQPriority;
  end;

  TIdVSESubLibraryFTPListItem = class(TIdVSELibraryFTPListItem)
  protected
    FNumberRecs : Integer;
    FCreationDate: TDateTime;
  public
    property CreationDate: TDateTime read FCreationDate write FCreationDate;
    property  NumberRecs : Integer read  FNumberRecs write  FNumberRecs;
  end;

  TIdFTPLPVSESubLibrary = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdVSEVSAMCatalogFTPListItem = class(TIdFTPListItem);

  TIdFTPLPVSERootDir = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdFTPLPVSELibrary = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdFTPLPVSEVSAMCatalog = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdVSEVTOCFTPListItem = class(TIdFTPListItem)
  public
    constructor Create(AOwner: TCollection); override;
  end;

  TIdFTPLPVSEVTOC = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdFTPLPVSEPowerQueue = class(TIdFTPListBase)
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
    {$HPPEMIT '#pragma link "IdFTPListParseVSE"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdGlobalProtocols, SysUtils;

{ TIdFTPLPVSERootDir }

class function TIdFTPLPVSERootDir.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuffer : String;
begin
  if AListing.Count > 0 then
  begin
    LBuffer := AListing[0];
    Fetch(LBuffer);
    LBuffer := Trim(LBuffer);
    Result := PosInStrArray(LBuffer, VSERootDirItemTypes) > -1;
  end else begin
    Result := False;
  end;
end;

class function TIdFTPLPVSERootDir.GetIdent: String;
begin
  Result := 'VSE:  Root Directory'; {do not localize}
end;

class function TIdFTPLPVSERootDir.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSERootDirFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSERootDir.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
    LBuffer : String;
begin
  //Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
  //URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LBuffer := AItem.Data;
  AItem.FileName := Fetch(LBuffer);
  LBuffer := Trim(LBuffer);
  if PosInStrArray(LBuffer, VSERootDirItemTypes) = 5 then begin
    AItem.ItemType := ditFile;
  end
  else
  begin
    AItem.ItemType := ditDirectory;
  end;
  Result := True;
end;

{ TIdFTPLPVSEVTOC }

class function TIdFTPLPVSEVTOC.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
const
  //S for Sequential
  //D for BDAM
  //V for VSAM
  //I for ISAM
  //U for Undefined
  ValidFileTypeSet = 'SDVIU'; {Do not translate}
var
  s : TStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    LData := AListing[0];
    s := TStringList.Create;
    try
      SplitDelimitedString(LData, s, True);
      if s.Count = 5 then begin
        Result := (IndyPos(s[4], ValidFileTypeSet) > 0) and IsNumeric(s[3]);
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVSEVTOC.GetIdent: String;
begin
  Result := 'VSE:  VTOC'; {do not localize}
end;

class function TIdFTPLPVSEVTOC.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEVTOCFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSEVTOC.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
begin
  LCols := TStringList.Create;
  try
    //Cols:
    // 0 - File name
    // 1 - Modified Date
    // 2 - Modified Time
    // 3 - logical length of records
    // 4 - file type (S for Sequential, D for BDAM, V for VSAM, I for ISAM, U for Undefined)
    SplitDelimitedString(AItem.Data, LCols, True);
    AItem.FileName := LCols[0];
    AItem.ModifiedDate := DateYYMMDD(LCols[1]);
    AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[2]);
    AItem.ItemType := ditFile;
    AItem.SizeAvail := False;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSEPowerQueue }

class function TIdFTPLPVSEPowerQueue.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : TStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    s := TStringList.Create;
    try
      LData := AListing[0];
      SplitDelimitedString(LData, s, True);
      if (s.Count = 6) or (s.Count = 7) then
      begin
        //There must be three subentries in the first col separated by
        //periods.  entries
        Result := CharsInStr('.', s[0]) = 2; {do not localize}
        if Result then
        begin
          Result := IsNumeric(s[1]) and IsNumeric(s[2]) and
                    IsNumeric(s[3]) and IsNumeric(s[4]);
        end;
        if Result then begin
          Result := (s[5] <> '') and (IndyPos(s[5][1], VSE_PowerQueue_Dispositions) <> 0);
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVSEPowerQueue.GetIdent: String;
begin
  Result := 'VSE:  PowerQueue'; {do not localize}
end;

class function TIdFTPLPVSEPowerQueue.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEPowerQueueFTPListItem.Create(AOwner);  
end;

class function TIdFTPLPVSEPowerQueue.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
  LI : TIdVSEPowerQueueFTPListItem;
begin
  //Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
  //URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LI := AItem as TIdVSEPowerQueueFTPListItem;
  LCols := TStringList.Create;
  try
    SplitDelimitedString(AItem.Data, LCols, True);
    //0 - Job name, job number, and job suffix. This information is contained in
    //   one string, with the three subfields separated by dots.
    //1 - records in file
    //2 - pages in file
    //3 - lines in file
    //4 - priority in queue entry
    //5 - Disposition of Job
    //6 - user ID that owns the job
    //contents are always files
    if LCols.Count > 0 then begin
      LI.FileName := LCols[0];
    end;
    if LCols.Count > 1 then
    begin
      LI.Size := IndyStrToInt(LCols[1], 0);
      LI.NumberRecs := AItem.Size;
    end;
    if LCols.Count > 4 then begin
      LI.VSEPQPriority := IndyStrToInt(LCols[4], 0);
    end;
    if (LCols.Count > 5) and (LCols[5] <> '') then begin
      LI.VSEPQDisposition := DispositionCodeToTIdVSEPQDisposition(LCols[5][1]);
    end;
    if LCols.Count > 6 then begin
      LI.OwnerName := LCols[6];
    end;
    LI.ItemType := ditFile;
    LI.ModifiedAvail := False;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSEVSAMCatalog }

class function TIdFTPLPVSEVSAMCatalog.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
const
  //E for ESDS
  //K for KSDS
  //R for RRDS
  ValidFileTypeSet = 'EKR'; {do not localize}
var
  s : TStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count >0 then
  begin
    LData := AListing[0];
    s := TStringList.Create;
    try
      SplitDelimitedString(LData, s, True);
      if s.Count = 5 then begin
        Result := (IndyPos(s[4], ValidFileTypeSet) > 0) and IsNumeric(s[3]);
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVSEVSAMCatalog.GetIdent: String;
begin
  Result := 'VSE:  VSAM Catalog'; {do not localize}
end;

class function TIdFTPLPVSEVSAMCatalog.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEVSAMCatalogFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSEVSAMCatalog.ParseLine( const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
  LI : TIdVSEVSAMCatalogFTPListItem;
begin
  //Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
  //URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LI := AItem as TIdVSEVSAMCatalogFTPListItem;
  LCols := TStringList.Create;
  try
    //Cols:
    // 0 - File name
    // 1 - Modified Date
    // 2 - Modified Time
    // 3 - Number of records (might be reported in Unix emulation mode as size)
    // 4 - file type (E for ESDS,  K for KSDS,   R for RRDS)
    SplitDelimitedString(AItem.Data, LCols, True);
    LI.FileName := LCols[0];
    LI.ModifiedDate := DateYYMMDD(LCols[1]);
    LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[2]);
    LI.Size := IndyStrToInt64(LCols[3], 0);
    LI.ItemType := ditFile;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSELibrary }

class function TIdFTPLPVSELibrary.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  LBuffer : String;
begin
  if AListing.Count > 0 then
  begin
    LBuffer := AListing[0];
    Fetch(LBuffer);
    LBuffer := TrimLeft(LBuffer);
    LBuffer := Fetch(LBuffer, '>') + '>'; {do not localize}
    Result := LBuffer = '<Sub Library>';  //Note that for Libraries, this  {Do not translate}
    //is always <Sub Library>
  end else begin
    Result := False;
  end;
end;

class function TIdFTPLPVSELibrary.GetIdent: String;
begin
  Result := 'VSE:  Library';  {do not localize}
end;

class function TIdFTPLPVSELibrary.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSELibraryFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSELibrary.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
  LCols : TStrings;
  LI : TIdVSELibraryFTPListItem;
begin
  //Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
  //URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LI := AItem as TIdVSELibraryFTPListItem;
  LBuffer := LI.Data;

  AItem.FileName := Fetch(LBuffer);
  Fetch(LBuffer, '>');  //This is always <Sub Library> {do not localize}
  LCols := TStringList.Create;
  try
    SplitDelimitedString(LBuffer, LCols, True);
    //0 - number of members - used as file size when emulating Unix, I think
    //1 - number of blocks
    //2 - date
    //3 - time
    if LCols.Count > 0 then begin
      LI.Size := IndyStrToInt64(LCols[0], 0);
    end;
    if LCols.Count > 1 then begin
      LI.NumberBlocks := IndyStrToInt(LCols[1], 0);
    end;
    if LCols.Count > 2 then begin
      LI.ModifiedDate := DateYYMMDD(Lcols[2]);
    end;
    if LCols.Count > 3 then begin
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(Lcols[3]);
    end;
    //sublibraries are always types of directories
    LI.ItemType := ditDirectory;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSESubLibrary }

class function TIdFTPLPVSESubLibrary.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
const
  ValidEntry : array [0..1] of string = (' F',' S');  {Do not localize}
  VSE_SUBLIBTYPES = 'FS';  {do not localize}
var
  s : TStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    LData := AListing[0];
    Result := (Length(LData) > 2) and
      (PosInStrArray(Copy(LData, Length(LData)-1, 2), ValidEntry) > -1);
    if Result then
    begin
      s := TStringList.Create;
      try
        SplitDelimitedString(LData, s, True);
        Result := (s.Count > 4) and
                  (IndyPos('/', s[3]) > 0) and {do not localize}
                  (IndyPos(':', s[4]) > 0) and {do not localize}
                  CharIsInSet(s[s.Count-1], 1, VSE_SUBLIBTYPES);
      finally
        FreeAndNil(s);
      end;
    end;
  end;
end;

class function TIdFTPLPVSESubLibrary.GetIdent: String;
begin
  Result := 'VSE:  Sublibrary'; {do not localize}
end;

class function TIdFTPLPVSESubLibrary.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSESubLibraryFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSESubLibrary.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
  LCols : TStrings;
  LI : TIdVSESubLibraryFTPListItem;
begin
  //Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
  //URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LI := AItem as TIdVSESubLibraryFTPListItem;
  LBuffer := AItem.Data;
  if Length(LBuffer) < 2 then
  begin
    Result := False;
    Exit;
  end;
  LBuffer := Copy(LBuffer, 1, Length(LBuffer)-1);
  LCols := TStringList.Create;
  try
    SplitDelimitedString(LBuffer, LCols, True);
    //0 - file name
    //1 - records in file - might be reported as size in Unix emulation
    //2 - number of library blocks
    //3 - creation date
    //4 - creation time
    //5 - last modified date (may not be present)
    //6 - last modified time (may not be present)
    //sublibrary contents are always files
    if LCols.Count >0 then begin
      LI.FileName := LCols[0];
    end;
    if LCols.Count >1 then
    begin
      LI.Size := IndyStrToInt64(LCols[1], 0);
      LI.NumberRecs := AItem.Size;
    end;
    if LCols.Count > 2 then begin
      LI.NumberBlocks := IndyStrToInt(LCols[2], 0);
    end;
    //creation time
    if LCols.Count >3 then begin
      LI.CreationDate := DateYYMMDD(LCols[3]);
    end;
    if LCols.Count > 4 then begin
      LI.CreationDate := LI.CreationDate + TimeHHMMSS(LCols[4]);
    end;
    //modified time
    if LCols.Count > 5 then begin
      LI.ModifiedDate := DateYYMMDD(LCols[5]);
    end else begin
      LI.ModifiedDate := DateYYMMDD(LCols[3]);
    end;
    if LCols.Count > 6 then begin
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[6]);
    end else begin
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[4]);
    end;
    AItem.ItemType := ditFile;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdVSEVTOCFTPListItem }

constructor TIdVSEVTOCFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  SizeAvail := False;
end;

initialization
  RegisterFTPListParser(TIdFTPLPVSELibrary);
  RegisterFTPListParser(TIdFTPLPVSEPowerQueue);
  RegisterFTPListParser(TIdFTPLPVSERootDir);
  RegisterFTPListParser(TIdFTPLPVSESubLibrary);
  RegisterFTPListParser(TIdFTPLPVSEVSAMCatalog);
  RegisterFTPListParser(TIdFTPLPVSEVTOC);
finalization
  UnRegisterFTPListParser(TIdFTPLPVSELibrary);
  UnRegisterFTPListParser(TIdFTPLPVSEPowerQueue);
  UnRegisterFTPListParser(TIdFTPLPVSERootDir);
  UnRegisterFTPListParser(TIdFTPLPVSESubLibrary);
  UnRegisterFTPListParser(TIdFTPLPVSEVSAMCatalog);
  UnRegisterFTPListParser(TIdFTPLPVSEVTOC);

end.
