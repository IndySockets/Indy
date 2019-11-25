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
  Rev 1.5    10/26/2004 9:46:34 PM  JPMugaas
  Updated refs.

  Rev 1.4    4/19/2004 5:05:48 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:28 PM  czhower
  Name changes

  Rev 1.2    10/19/2003 2:27:22 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:03:52 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 05:51:24 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseMPEiX;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdMPiXFTPListItem = class(TIdRecFTPListItem)
  protected
    FLimit : UInt32;
  public
    constructor Create(AOwner: TCollection); override;
    property RecLength;
    property RecFormat;
    property NumberRecs;
    property Limit : UInt32 read FLimit write FLimit;
  end;

  //Anscestor for the MPE/iX Parsers
  //This is necessary because they both have a second line a function parses
  //Do not register this one
  TIdFTPLPMPiXBase = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsSecondHeader(ACols: TStrings): Boolean; virtual;
  public
    class function GetIdent : String; override;
  end;

  TIdFTPLPMPiX = class(TIdFTPLPMPiXBase)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
    class function IsHeader(const AData: String): Boolean;  override;
  public
    class function GetIdent : String; override;
  end;

  TIdFTPLPMPiXWithPOSIX = class(TIdFTPLPMPiXBase)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
    class function IsHeader(const AData: String): Boolean;  override;
  public
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseMPEiX"'}
  {$ENDIF}

implementation

uses
  IdFTPCommon, IdGlobalProtocols, IdStrings, SysUtils;

{ TIdFTPLPMPiXBase }

class function TIdFTPLPMPiXBase.GetIdent: String;
begin
  Result := 'MPE/iX:  ';  {do not localize}
end;

class function TIdFTPLPMPiXBase.IsSecondHeader(ACols: TStrings): Boolean;
begin
  Result := (ACols.Count > 3) and
            (ACols[0] = 'SIZE') and     {do not localize}
            (ACols[1] = 'TYP') and      {do not localize}
            (ACols[2] = 'EOF') and      {do not localize}
            (ACols[3] = 'LIMIT');       {do not localize}
  if Result and (ACols.Count = 8) then
  begin
    Result := (ACols[4] = 'R/B') and      {do not localize}
              (ACols[5] = 'SECTORS') and  {do not localize}
              (ACols[6] = '#X') and       {do not localize}
              (ACols[7] = 'MX')           {do not localize}
  end;
  {
This is for a Not Found banner such as:

"@ not found"
"./@ not found"

  }
  if (not Result) and (ACols.Count = 3) then
  begin
    Result := (IndyPos('@', ACols[0]) > 0) and
              (ACols[1] = 'not') and    {do not localize}
              (ACols[2] = 'found');     {do not localize}
  end;
end;

class function TIdFTPLPMPiXBase.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMPiXFTPListItem.Create(AOwner);
end;

{ TIdFTPLPMPiX }

class function TIdFTPLPMPiX.GetIdent: String;
begin
  Result := inherited GetIdent + 'LISTF'; {do not localize}
end;

class function TIdFTPLPMPiX.IsHeader(const AData: String): Boolean;
var
  LCols : TStrings;
  LAccP, LGrpP : Integer;
begin
  LAccP := IndyPos('ACCOUNT=', AData);  {do not localize}
  if LAccP = 0 then begin
    LAccP := IndyPos('ACCOUNT =', AData); {do not localize}
  end;
  LGrpP := IndyPos('GROUP=', AData);  {do not localize}
  if LGrpP = 0 then begin
    LGrpP := IndyPos('GROUP =', AData); {do not localize}
  end;
  Result := (LAccP > 0) and (LGrpP > LAccP);
  if not Result then
  begin
    LCols := TStringList.Create;
    try
      SplitDelimitedString(ReplaceAll(AData, '-', ' '), LCols, True);
      Result := (LCols.Count > 3) and
                (LCols[0] = 'FILENAME') and   {do not localize}
                (LCols[1] = 'CODE') and       {do not localize}
                (LCols[2] = 'LOGICAL') and    {do not localize}
                (LCols[3] = 'RECORD');        {do not localize}
      if Result and (LCols.Count = 5) then begin
        Result := (LCols[4] = 'SPACE');       {do not localize}
      end;
      if not Result then begin
        Result := IsSecondHeader(LCols);
      end;
    finally
      FreeAndNil(LCols);
    end;
  end;
end;

class function TIdFTPLPMPiX.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
  LBuf : String;
  LI : TIdMPiXFTPListItem;
begin
  LI := AItem as TIdMPiXFTPListItem;
  LCols := TStringList.Create;
  try
    //According to "HP ARPA File Transfer Protocol, User’s Guide, HP 3000 MPE/iX Computer Systems,Edition 6"
    //the filename here can be 8 chars long
    LI.FileName := Trim(Copy(AItem.Data, 1, 8));
    LBuf := Copy(AItem.Data, 8, MaxInt);
    if (Length(LBuf) > 0) and (LBuf[1] <> ' ') then begin
      Fetch(LBuf);
    end;
    SplitDelimitedString(LBuf, LCols, True);
    if LCols.Count > 1 then begin
      LI.Size := ExtractNumber(LCols[1]);
    end;
    //Type
    if LCols.Count > 2 then begin
      LI.RecFormat := LCols[2];
    end;
    //record COunt - EOF
    if LCols.Count > 3 then begin
      LI.NumberRecs := IndyStrToInt64(LCols[3], 0);
    end;
    //Limit
    if LCols.Count > 4 then begin
      LI.Limit := IndyStrToInt64(LCols[4], 0);
    end;
    {
    HP3000 is a flat file system where there are no
    subdirs.  There is a file group created by the user
    but that is mroe logical than anything.  There might
    be a command for obtaining file groups but I have not
    seen one.  Note that file groups can not obtain other groups.
    }
    LI.ItemType := ditFile;
    {
    Note that HP3000 does not give you the date at all.
    }
    LI.ModifiedAvail := False;
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdFTPLPMPiXWithPOSIX }

class function TIdFTPLPMPiXWithPOSIX.GetIdent: String;
begin
  Result := inherited GetIdent + 'With POSIX';  {do not localize}
end;

class function TIdFTPLPMPiXWithPOSIX.IsHeader(const AData: String): Boolean;
var
  LCols : TStrings;
begin
  {
  Often is something like this (spacing may very):
  ==

   PATH= /PH/SAPHP/

   CODE  ------------LOGICAL RECORD-----------  ----SPACE----  FILENAME
           SIZE  TYP        EOF      LIMIT R/B  SECTORS #X MX

  ==
  or maybe this:
  ===
  ACCOUNT=  SYS         GROUP=  WORK
  FILENAME  CODE  ------------LOGICAL RECORD-----------  ----SPACE----
  ===
  }
  Result := IndyPos('PATH=', AData) > 0;  {do not localize}
  if not Result then
  begin
    LCols := TStringList.Create;
    try
      SplitDelimitedString(ReplaceAll(AData, '-', ' '), LCols, True);
      Result := (LCols.Count = 5) and
                (LCols[0] = 'CODE') and       {do not localize}
                (LCols[1] = 'LOGICAL') and    {do not localize}
                (LCols[2] = 'RECORD') and     {do not localize}
                (LCols[3] = 'SPACE') and      {do not localize}
                (LCols[4] = 'FILENAME');      {do not localize}
      if not Result then begin
        Result := IsSecondHeader(LCols);
      end;
    finally
      FreeAndNil(LCols);
    end;
  end;
end;

class function TIdFTPLPMPiXWithPOSIX.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LCols : TStrings;
  LI : TIdMPiXFTPListItem;
begin
  LI := AItem as TIdMPiXFTPListItem;
  LCols := TStringList.Create;
  try
    SplitDelimitedString(AItem.Data, LCols, True);
    if LCols.Count > 0 then begin
      LI.Size := ExtractNumber(LCols[0]);
    end;
    if LCols.Count > 1 then begin
      LI.RecFormat := LCols[1];
    end;
    if LCols.Count > 2 then begin
      LI.NumberRecs := IndyStrToInt64(LCols[2], 0);
    end;
    if LCols.Count > 3 then begin
      LI.Limit := IndyStrToInt64(LCols[3], 0);
    end;
    if LCols.Count > 8 then begin
      LI.FileName := LCols[8];
    end;
    {
    The original HP3000 is a flat file system where there are no
    subdirs.  There is a file group created by the user
    but that is more logical than anything.  There might
    be a command for obtaining file groups but I have not
    seen one.  Note that file groups can not obtain other groups.

    More recent versions of HP3000 have Posix support including a
    hierarchical file system.  Verified with test at:

    jazz.external.hp.com
    }
    if TextEndsWith(LI.FileName, '/') then
    begin
      LI.ItemType := ditDirectory;
      LI.FileName := Copy(LI.FileName, 1, Length(LI.FileName) - 1);
    end else begin
      LI.ItemType := ditFile;
    end;
    {
    Note that HP3000 does not give you the date at all.
    }
  finally
    FreeAndNil(LCols);
  end;
  Result := True;
end;

{ TIdMPiXFTPListItem }

constructor TIdMPiXFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  //MP/iX or HP3000 will not give you a modified date at all
  ModifiedAvail := False;
end;

initialization
  RegisterFTPListParser(TIdFTPLPMPiX);
  RegisterFTPListParser(TIdFTPLPMPiXWithPOSIX);
finalization
  UnRegisterFTPListParser(TIdFTPLPMPiX);
  UnRegisterFTPListParser(TIdFTPLPMPiXWithPOSIX);

end.
