{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16180: IdFTPListParseVSE.pas
{
{   Rev 1.6    10/26/2004 10:03:22 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.5    4/19/2004 5:05:34 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.4    2004.02.03 5:45:24 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/23/2004 12:44:52 PM  SPerry
{ fixed set problems
}
{
    Rev 1.2    10/19/2003 3:48:14 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    4/7/2003 04:04:38 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.0    2/19/2003 04:18:24 AM  JPMugaas
{ More things restructured for the new list framework.
}
unit IdFTPListParseVSE;

interface

uses
  IdFTPCommon, 
  IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdObjs, IdSys;

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
    FCreationDate: TIdDateTime;
  public
    property CreationDate: TIdDateTime read FCreationDate write FCreationDate;
    property  NumberRecs : Integer read  FNumberRecs write  FNumberRecs;
  end;
  TIdFTPLPVSESubLibrary = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;
  TIdVSEVSAMCatalogFTPListItem = class(TIdFTPListItem);
  
  TIdFTPLPVSERootDir = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  TIdFTPLPVSELibrary = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  TIdFTPLPVSEVSAMCatalog = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;
  TIdVSEVTOCFTPListItem = class(TIdFTPListItem)
  public
  constructor Create(AOwner: TIdCollection); override;
  end;
  TIdFTPLPVSEVTOC = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  TIdFTPLPVSEPowerQueue = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols;

{ TIdFTPLPVSERootDir }

class function TIdFTPLPVSERootDir.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var LBuffer : String;
begin
  if AListing.Count >0 then
  begin
    LBuffer := AListing[0];
    Fetch(LBuffer);
    LBuffer := Sys.Trim(LBuffer);
    Result := (PosInStrArray(LBuffer,VSERootDirItemTypes) > -1);
  end
  else
  begin
    Result := False;
  end;
end;


class function TIdFTPLPVSERootDir.GetIdent: String;
begin
  Result := 'VSE:  Root Directory'; {do not localize}
end;

class function TIdFTPLPVSERootDir.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSERootDirFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSERootDir.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
    LBuffer : String;
//Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
//URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
begin
  LBuffer := AItem.Data;

  AItem.FileName := Fetch(LBuffer);
  LBuffer := Sys.Trim(LBuffer);
  case PosInStrArray(LBuffer,VSERootDirItemTypes) of
    5 : AItem.ItemType := ditFile;
  else
    AItem.ItemType := ditDirectory;
  end;
  Result := True;
end;

{ TIdFTPLPVSEVTOC }

class function TIdFTPLPVSEVTOC.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
  //S for Sequential
  //D for BDAM
  //V for VSAM
  //I for ISAM
  //U for Undefined
  const ValidFileTypeSet = 'SDVIU'; {Do not translate}
var s : TIdStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count >0 then
  begin
    LData := AListing[0];
    s := TIdStringList.Create;
    try
      SplitColumns(LData,s);
      if (s.Count = 5) then
      begin
        Result := (IndyPos(s[4],ValidFileTypeSet)>0) and (IsNumeric(s[3]));
      end;
    finally
      Sys.FreeAndNil(s);
    end;
  end
  else
  begin
    Result := False;
  end;
end;

class function TIdFTPLPVSEVTOC.GetIdent: String;
begin
  Result := 'VSE:  VTOC'; {do not localize}
end;

class function TIdFTPLPVSEVTOC.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEVTOCFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSEVTOC.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
//Cols:
// 0 - File name
// 1 - Modified Date
// 2 - Modified Time
// 3 - logical length of records
// 4 - file type (S for Sequential, D for BDAM, V for VSAM, I for ISAM, U for Undefined)

var
  LCols : TIdStrings;
begin
  LCols := TIdStringList.Create;
  try
    SplitColumns(Sys.Trim(AItem.Data),LCols);
    AItem.FileName := LCols[0];
    AItem.ModifiedDate := DateYYMMDD(LCols[1]);
    AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[2]);
    AItem.ItemType := ditFile;
  finally
    Sys.FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSEPowerQueue }

class function TIdFTPLPVSEPowerQueue.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var s : TIdStrings;
  LData : String;
begin
  Result := False;
  if AListing.Count >0 then
  begin
    s := TIdStringList.Create;
    try
      LData := AListing[0];
      SplitColumns(LData,s);
      if (s.Count = 6) or (s.Count = 7) then
      begin
        //There must be three subentries in the first col separated by
        //periods.  entries
        Result := CharsInStr('.',s[0])=2;
        if Result then
        begin
          Result := IsNumeric(s[1]) and IsNumeric(s[2]) and
                    IsNumeric(s[3]) and IsNumeric(s[4]);
        end;
        if Result then
        begin
          Result := (s[5]<>'') and (IndyPos(s[5][1],VSE_PowerQueue_Dispositions)<>0);
        end;
      end;
    finally
      Sys.FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVSEPowerQueue.GetIdent: String;
begin
  Result := 'VSE:  PowerQueue'; {do not localize}
end;

class function TIdFTPLPVSEPowerQueue.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEPowerQueueFTPListItem.Create(AOwner);  
end;

class function TIdFTPLPVSEPowerQueue.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
//Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
//URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf

var
  LCols : TIdStrings;
  LI : TIdVSEPowerQueueFTPListItem;
begin
  LI := AItem as TIdVSEPowerQueueFTPListItem;
  LCols := TIdStringList.Create;
  try
    SplitColumns(Sys.Trim(AItem.Data),LCols);
    //0 - Job name, job number, and job suffix. This information is contained in
    //   one string, with the three subfields separated by dots.
    //1 - records in file
    //2 - pages in file
    //3 - lines in file
    //4 - priority in queue entry
    //5 - Disposition of Job
    //6 - user ID that owns the job
    //contents are always files
    if LCols.Count >0 then
    begin
      LI.FileName := LCols[0];
    end;
    if LCols.Count >1 then
    begin
      LI.Size := Sys.StrToInt(LCols[1],0);
      LI.NumberRecs := AItem.Size;
    end;
    if (LCols.Count > 4) then
    begin
      LI.VSEPQPriority := Sys.StrToInt(LCols[4],0);
    end;
    if (LCols.Count > 5) and (LCols[5]<>'') then
    begin
      LI.VSEPQDisposition := DispositionCodeToTIdVSEPQDisposition(LCols[5][1]);
    end;
    if LCols.Count > 6 then
    begin
      LI.OwnerName := LCols[6];
    end;
    LI.ItemType := ditFile;
  finally
    Sys.FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSEVSAMCatalog }

class function TIdFTPLPVSEVSAMCatalog.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;

  //E for ESDS
  //K for KSDS
  //R for RRDS
const ValidFileTypeSet = 'EKR'; {do not localize}
var s : TIdStrings;
    LData : String;
begin
  Result := False;
  if AListing.Count >0 then
  begin
    LData := AListing[0];
    s := TIdStringList.Create;
    try
      SplitColumns(LData,s);
      if (s.Count = 5) then
      begin
        Result := (IndyPos(s[4],ValidFileTypeSet)>0) and (IsNumeric(s[3]));
      end;
    finally
      Sys.FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPVSEVSAMCatalog.GetIdent: String;
begin
  Result := 'VSE:  VSAM Catalog'; {do not localize}
end;

class function TIdFTPLPVSEVSAMCatalog.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSEVSAMCatalogFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSEVSAMCatalog.ParseLine(
  const AItem: TIdFTPListItem; const APath: String): Boolean;
//Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
//URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf

//Cols:
// 0 - File name
// 1 - Modified Date
// 2 - Modified Time
// 3 - Number of records (might be reported in Unix emulation mode as size)
// 4 - file type (E for ESDS,  K for KSDS,   R for RRDS)
var
  LCols : TIdStrings;
  LI : TIdVSEVSAMCatalogFTPListItem;
begin
  LI := AItem as TIdVSEVSAMCatalogFTPListItem;
  LCols := TIdStringList.Create;
  try
    SplitColumns(Sys.Trim(AItem.Data),LCols);
    LI.FileName := LCols[0];
    LI.ModifiedDate := DateYYMMDD(LCols[1]);
    LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LCols[2]);
    LI.Size := Sys.StrToInt64(LCols[3],0);
    LI.ItemType := ditFile;
  finally
    Sys.FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSELibrary }

class function TIdFTPLPVSELibrary.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var LBuffer : String;
begin
  if AListing.Count >0 then
  begin
    LBuffer := AListing[0];
    Fetch(LBuffer);
    LBuffer := Sys.TrimLeft(LBuffer);
    LBuffer := Fetch(LBuffer,'>')+'>';
    Result := LBuffer = '<Sub Library>';  //Note that for Libraries, this  {Do not translate}
    //is always <Sub Library>
  end
  else
  begin
    Result := False;
  end;
end;

class function TIdFTPLPVSELibrary.GetIdent: String;
begin
  Result := 'VSE:  Library';  {do not localize}
end;

class function TIdFTPLPVSELibrary.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSELibraryFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSELibrary.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
//Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
//URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LCols : TIdStrings;
  LI : TIdVSELibraryFTPListItem;
begin
  LI := AItem as TIdVSELibraryFTPListItem;
  LBuffer := LI.Data;

  AItem.FileName := Fetch(LBuffer);
  Fetch(LBuffer,'>');  //This is always <Sub Library>
  LCols := TIdStringList.Create;
  try
    SplitColumns(Sys.Trim(LBuffer),LCols);
    //0 - number of members - used as file size when emulating Unix, I think
    //1 - number of blocks
    //2 - date
    //3 - time
    if LCols.Count > 0 then
    begin
      LI.Size := Sys.StrToInt64(LCols[0],0);
    end;
    if LCols.Count > 1 then
    begin
      LI.NumberBlocks := Sys.StrToInt(LCols[1],0);
    end;
    if LCols.Count > 2 then
    begin
      LI.ModifiedDate := DateYYMMDD(Lcols[2]);
    end;
    if LCols.Count > 3 then
    begin
      LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(Lcols[3]);
    end;
    //sublibraries are always types of directories
    LI.ItemType := ditDirectory;
  finally
    Sys.FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPVSESubLibrary }

class function TIdFTPLPVSESubLibrary.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;

const ValidEntry : array [0..1] of string = (' F',' S');  {Do not translate}
      VSE_SUBLIBTYPES = 'F'+  //fixed
                           'S';  //string
var s : TIdStrings;
    LData : String;
begin
  if AListing.Count > 0 then
  begin
    LData := AListing[0];
    Result := (Length(LData)>2) and
      ( PosInStrArray( Copy(LData,Length(LData)-1,2),ValidEntry) > -1);
    if Result then
    begin
      s := TIdStringList.Create;
      try
        SplitColumns(LData,s);
        Result := (s.Count > 4) and (IndyPos('/',s[3])>0) and (IndyPos(':',s[4])>0)
          and (CharIsInSet(s[s.Count -1], 1, VSE_SUBLIBTYPES));
      finally
        Sys.FreeAndNil(s);
      end;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

class function TIdFTPLPVSESubLibrary.GetIdent: String;
begin
  Result := 'VSE:  Sublibrary'; {do not localize}
end;

class function TIdFTPLPVSESubLibrary.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVSESubLibraryFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVSESubLibrary.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
//Based on: TCP/IP for VSE User's Guide Version 1 Release 4.0A
//URL: http://publibz.boulder.ibm.com/epubs/pdf/iestcu02.pdf
  LCols : TIdStrings;
  LI : TIdVSESubLibraryFTPListItem;
begin
  LI := AItem as TIdVSESubLibraryFTPListItem;
  LBuffer := AItem.Data;
  if Length (LBuffer)<2 then
  begin
    Result := False;
    Exit;
  end;
  LBuffer := Copy(LBuffer,1,Length(LBuffer)-1);
  LCols := TIdStringList.Create;
  try
    SplitColumns(Sys.Trim(LBuffer),LCols);
    //0 - file name
    //1 - records in file - might be reported as size in Unix emulation
    //2 - number of library blocks
    //3 - creation date
    //4 - creation time
    //5 - last modified date (may not be present)
    //6 - last modified time (may not be present)
    //sublibrary contents are always files
    if LCols.Count >0 then
    begin
      LI.FileName := LCols[0];
    end;
    if LCols.Count >1 then
    begin
      LI.Size := Sys.StrToInt64(LCols[1],0);
      LI.NumberRecs := AItem.Size;
    end;
    if LCols.Count > 2 then
    begin
      LI.NumberBlocks := Sys.StrToInt(LCols[2],0);
    end;
    //creation time
      if LCols.Count >3 then
      begin
        LI.CreationDate := DateYYMMDD(LCols[3]);
      end;
      if LCols.Count >4 then
      begin
        LI.CreationDate := LI.CreationDate + TimeHHMMSS(LCols[4]);
      end;

    //modified time
      if LCols.Count >5 then
      begin
        LI.ModifiedDate := DateYYMMDD(LCols[5]);
      end
      else
      begin
        LI.ModifiedDate := DateYYMMDD(LCols[3]);
      end;
      if LCols.Count >6 then
      begin
        LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[6]);
      end
      else
      begin
        LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LCols[4]);
      end;
     AItem.ItemType := ditFile;
  finally
    Sys.FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdVSEVTOCFTPListItem }

constructor TIdVSEVTOCFTPListItem.Create(AOwner: TIdCollection);
begin
  inherited;
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

