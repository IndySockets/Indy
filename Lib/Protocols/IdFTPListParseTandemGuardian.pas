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
  Rev 1.2    2/23/2005 6:34:30 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.1    10/26/2004 11:21:16 PM  JPMugaas
  Updated refs.

  Rev 1.0    7/30/2004 8:03:42 AM  JPMugaas
  FTP List parser for the Tandem NonStop Guardian file-system.
}

unit IdFTPListParseTandemGuardian;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

{
  This parser is based on the Tandem NonStop Server with a Guardian file system.
  This is primarily based on some correspondances and samples I got from Steeve Howe.
  His correspondance is here and I'm noting it in case I need to refer back later:

  What are the rules for acceptable filenames on the Tandem?  
  >>Must start with a character and must be at least on character long.

  What charactors can be used?
  >>Alpha characters and numerals.

  What's the length?
  >>  8 characters max.

  Can you have file extensions, if so how many and what's the length for
  those?
  >> No file extensions.

  Is the system case insensitive or case-sensitive?
  >>All filenames are converted to uppercase (from what I can tell)

  What's Code? Is it always a number?
  >> Code is the type of file.  101 is an editable file, 100 is an
    exacutable, 1000 is an user defined executable, there is a type 1600
    and I have seen type 0 (which I think is an unknown binary type of
    file)

  What's EOF?  Is that the file size?  I don't know.
  >> Yes,  That is the file size.

  In the Owner column, you have something like this "155, 76".  Are
  their only numbers and what do the numbers in the column mean (I
  assume that there is two).  Will the Owner column ever have letters?
  >> Never letters.
    first byte is group, second is user
    it describes user and security level

  What is valid for "RWEP" and what do the letters in that mean and what
  letters are there?
  >> Read, Write, Execute, Purge

  some valid letters (there are about 7 and I don't know them all):
  N - anyone across system has access
  U - only the user has this priviledge
  A - anyone on local system has priviledge
  G - anyone belonging to same group
  - (dash)  - only local super.super has access

  some further references from Tandem that might help:

  http://www.hp.com/go/NTL - General technical reference
  http://h30163.www3.hp.com/NTL/library/G06_RVUs/G06_20/Publications/ -HP
  G06.20 Publications

  hope this helps!
}
{
  This parses something like this:
  ====
  File         Code             EOF  Last Modification    Owner  RWEP
  ALV           101             2522 27-Aug-02 13:57:10 155,106 "nnnn"
  ALVO         1000             2048 27-Aug-02 13:57:22 155,106 "nunu"
  ====
}

type
  TIdTandemGuardianFTPListItem = class(TIdOwnerFTPListItem)
  protected
    //this is given as a numbeer like the owner.  We keep it as a string
    //for consistancy with other FTP list parsers.
    FGroupName : String;
    //this may be an integer value but I'm not sure
    //because one
    FCode : UInt32;
    //This is the RWEP value
    { It's done like this:

    Read, Write, Execute, Purge

    some valid letters (there are about 7 and I don't know them all):
    N - anyone across system has access
    U - only the user has this priviledge
    A - anyone on local system has priviledge
    G - anyone belonging to same group
    - (dash)  - only local super.super has access

    }
    FPermissions : String;
  public
    property GroupName : String read FGroupName write FGroupName;
    property Code : UInt32 read FCode write FCode;
    property Permissions : String read  FPermissions write FPermissions;
  end;

  TIdFTPLPTandemGuardian = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

const
  TANDEM_GUARDIAN_ID = 'Tandem NonStop Guardian'; {do not localize}

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseTandemGuardian"'}
  {$ENDIF}

implementation

uses
  IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPTandemGuardian }

class function TIdFTPLPTandemGuardian.GetIdent: String;
begin
  Result := TANDEM_GUARDIAN_ID;
end;

class function TIdFTPLPTandemGuardian.IsHeader(const AData: String): Boolean;
var
  LCols : TStrings;
begin
  Result := False;
  LCols := TStringList.Create;
  try
     SplitDelimitedString(AData, LCols, True);
     if LCols.Count = 7 then
     begin
       Result := (LCols[0] = 'File') and            {do not localize}
                 (LCols[1] = 'Code') and            {do not localize}
                 (LCols[2] = 'EOF') and             {do not localize}
                 (LCols[3] = 'Last') and            {do not localize}
                 (LCols[4] = 'Modification') and    {do not localize}
                 (LCols[5] = 'Owner') and           {do not localize}
                 (LCols[6] = 'RWEP')                {do not localize}
     end;
  finally
    FreeAndNil(LCols);
  end;
end;

class function TIdFTPLPTandemGuardian.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdTandemGuardianFTPListItem.Create(AOwner);
end;

class function TIdFTPLPTandemGuardian.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LItem : TIdTandemGuardianFTPListItem;
  LLine, LBuffer : String;
  LDay, LMonth, LYear : Integer;
begin
  {
  Parse lines like these:

  ALV           101             2522 27-Aug-02 13:57:10 155,106 "nnnn"
  ALVO         1000             2048 27-Aug-02 13:57:22 155,106 "nunu"
  }
  //
  { Note from Steeve Howe:
  ===
The directories are flat.  The Guardian system appears like this:

\<server>.$<volume>.<subvolume>

you can change from server to server, volume to volume, subvolume to
subvolume, but
nothing deeper.  what you get from a directory listing then is just the
files within that
subvolume of the volume on the server.
===
  }
  Result := True;
  LItem := AItem as TIdTandemGuardianFTPListItem;
  LLine := Trim(LItem.Data);
  LItem.ItemType := ditFile;
  //name
  // Steve Howe advised me that a filename can not have a space and is 8 chars
  // with no filename extensions.  It is case insensitive.
  LItem.FileName := Fetch(LLine);
  LLine := TrimLeft(LLine);
  //code
  LItem.Code := IndyStrToInt(Fetch(LLine), 0);
  LLine := TrimLeft(LLine);
  //EOF
  LItem.Size := IndyStrToInt64(Fetch(LLine), 0);
  LLine := TrimLeft(LLine);
  //Last Modification
  //date
  LBuffer := Fetch(LLine);
  LLine := TrimLeft(LLine);
  LDay := IndyStrToInt(Fetch(LBuffer, '-'), 1); {do not localize}
  LMonth := StrToMonth(Fetch(LBuffer, '-'));   {do not localize}

  LYear := IndyStrToInt(Fetch(LBuffer), 1989);
  LYear := Y2Year(LYear);
  //time
  LItem.ModifiedDate := EncodeDate(LYear, LMonth, LDay);
  LBuffer := Fetch(LLine);
  LLine := TrimLeft(LLine);
  LItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LBuffer);
  LLine := TrimLeft(LLine);
  //group,Owner
  //Steve how advised me that the first number in this column is a group
  //and the number after the comma is an owner
  LItem.GroupName := Fetch(LLine, ','); {do not localize}
  LLine := TrimLeft(LLine);
  LItem.OwnerName := Fetch(LLine);
  //RWEP
  LItem.Permissions := UnquotedStr(LLine);
  LItem.PermissionDisplay := '"' + LItem.Permissions + '"';
end;

initialization
  RegisterFTPListParser(TIdFTPLPTandemGuardian);
finalization
  UnRegisterFTPListParser(TIdFTPLPTandemGuardian);

end.
