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
  Rev 1.4    10/26/2004 10:03:22 PM  JPMugaas
  Updated refs.

  Rev 1.3    4/19/2004 5:06:08 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.2    2004.02.03 5:45:40 PM  czhower
  Name changes

  Rev 1.1    10/19/2003 3:48:16 PM  DSiders
  Added localization comments.

  Rev 1.0    4/7/2003 04:10:34 PM  JPMugaas
  Renamed IdFTPListParseVsWorks.  The s was a typo.

  Rev 1.0    2/19/2003 05:49:54 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseVxWorks;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdVxWorksFTPListItem = class(TIdFTPListItem);

  TIdFTPLPVxWorks = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseVxWorks"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPVxWorks }

class function TIdFTPLPVxWorks.GetIdent: String;
begin
  Result := 'Wind River VxWorks'; {do not localize}
end;

class function TIdFTPLPVxWorks.IsFooter(const AData: String): Boolean;
begin
  {Not sure if the value string is in the FTP list
   because I didn't see it first hand, it could've been a VxWorks command
   prompt, but just in case.}
  Result := TextStartsWith(AData, 'value');  {do not localize}
end;

class function TIdFTPLPVxWorks.IsHeader(const AData: String): Boolean;
var
  LCols : TStrings;
begin
  Result := False;
  LCols := TStringList.Create;
  try
    SplitDelimitedString(AData, LCols, True);
    if LCols.Count > 3 then
    begin
      Result := (LCols[0] = 'size') and   {do not localize}
                (LCols[1] = 'date') and   {do not localize}
                (LCols[2] = 'time') and   {do not localize}
                (LCols[3] = 'name');      {do not localize}
    end;
  finally
    FreeAndNil(LCols);
  end;
end;

class function TIdFTPLPVxWorks.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdVxWorksFTPListItem.Create(AOwner);
end;

class function TIdFTPLPVxWorks.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
begin
  LBuffer := Trim(AItem.Data);
  //Size
  AItem.Size := IndyStrToInt64(Fetch(LBuffer), 0);
  //  date
  LBuffer := TrimLeft(LBuffer);
  AItem.ModifiedDate := DateStrMonthDDYY(Fetch(LBuffer));

  // time
  LBuffer := TrimLeft(LBuffer);
  AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(Fetch(LBuffer));

  // item type
  if TextEndsWith(LBuffer, '<DIR>') then {do not localize}
  begin
    AItem.ItemType := ditDirectory;
    LBuffer := Copy(LBuffer, 1, Length(LBuffer)-5);
  end;
  //I hope filenames and dirs don't start or end with a space
  AItem.FileName := Trim(LBuffer);
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPVxWorks);
finalization
  UnRegisterFTPListParser(TIdFTPLPVxWorks);

end.
