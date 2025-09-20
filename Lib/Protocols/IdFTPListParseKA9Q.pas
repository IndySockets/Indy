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
  Rev 1.6    10/26/2004 9:46:32 PM  JPMugaas
  Updated refs.

  Rev 1.5    6/5/2004 3:09:28 PM  JPMugaas
  Now indicates SIze is not available for directories.  Size is not given for a
  directory in KA9Q.

  Rev 1.4    4/19/2004 5:06:06 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:38 PM  czhower
  Name changes

  Rev 1.2    1/9/2004 4:50:26 PM  BGooijen
  removed text after final end.

  Rev 1.1    10/19/2003 2:27:16 PM  DSiders
  Added localization comments.

  Rev 1.0    3/16/2003 02:39:06 PM  JPMugaas
  I must have forgot to check in this file as part of the FTP list restructure.
  !!!OOPS!!!
}

unit IdFTPListParseKA9Q;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdKA9QFTPListItem = class(TIdFTPListItem);

  TIdFTPLPKA9Q = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): Boolean; override;
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseKA9Q"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPKA9Q }

class function TIdFTPLPKA9Q.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  s : TStrings;

  function IsKAQ9TS(const AData : String) : Boolean;
  begin
    Result := (PatternsInStr(':', AData) = 1) and IsHHMMSS(AData, ':');
  end;

  function IsKAQ9DS(const AData : String) : Boolean;
  begin
    Result := (PatternsInStr('/', AData) = 2) and IsMMDDYY(AData, '/');
  end;

begin
  Result := False;
  if AListing.Count > 0 then
  begin
    Result := False;
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      if s.Count > 2 then
      begin
        if TextEndsWith(s[0], '/') then
        begin
          //could be a dir
          Result := IsKAQ9TS(s[1]) and IsKAQ9DS(s[2]);
        end else
        begin
          //could be a file
          Result := (s.Count > 3) and
            (ExtractNumber(s[1], False) > -1) and
            IsKAQ9TS(s[2]) and
            IsKAQ9DS(s[3]);
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPKA9Q.GetIdent: String;
begin
  Result := 'KA9Q'; {do not localize}
end;

class function TIdFTPLPKA9Q.IsFooter(const AData: String): Boolean;
var
  LWords : TStrings;
begin
  Result := False;
  if AData = '#' then  {do not localize}
  begin
    Result := True;
    Exit;
  end;
  LWords := TStringList.Create;
  try
    SplitDelimitedString(ReplaceAll(AData, '-', ' '), LWords, True);
    if LWords.Count > 1 then
    begin
      Result := (LWords[1] = 'files.') or (LWords[1] = 'file.') or  {do not localize}
        (LWords[1] = 'files') or (LWords[1] = 'file');  {do not localize}
    end;
  finally
    FreeAndNil(LWords);
  end;
end;

class function TIdFTPLPKA9Q.IsHeader(const AData: String): Boolean;
begin
  Result := False;
end;

class function TIdFTPLPKA9Q.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdKA9QFTPListItem.Create(AOwner);
end;

class function TIdFTPLPKA9Q.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, LPt : String;
  LNewItem : TIdFTPListItem;
  LDir : TIdFTPListItems;
begin
  {
  Note that this parser is odd because it will create a new TIdFTPListItem.
  I know that is not according to the current conventional design.  However, KA9Q
  is unusual because a single line can have two items (maybe more)
  }
  LBuf := AItem.Data;
  {filename - note that a space is illegal in MS-DOS so this should be safe}
  LPt := Fetch(LBuf);
  if LPt <> '' then
  begin
    if TextEndsWith(LPt, '/') then
    begin
      AItem.FileName := Fetch(LPt, '/');
      AItem.ItemType := ditDirectory;
      AItem.SizeAvail := False;
    end else
    begin
      AItem.FileName := LPt;
      AItem.ItemType := ditFile;
      LBuf := Trim(LBuf);
      LPt := Fetch(LBuf);
      AItem.Size := ExtractNumber(LPt);
    end;
    LBuf := Trim(LBuf);
    LPt := Fetch(LBuf);
    if LPt <> '' then
    begin
      AItem.ModifiedDate := TimeHHMMSS(LPt);
      LBuf := Trim(LBuf);
      LPt := Fetch(LBuf);
      if LPt <> '' then
      begin
        AItem.ModifiedDate := AItem.ModifiedDate + DateMMDDYY(LPt);
        LBuf := Trim(LBuf);
        if LBuf <> '' then
        begin
          LDir := AItem.Collection as TIdFTPListItems;
          LNewItem := LDir.Add;
          LNewItem.Data := LBuf;
          TIdFTPLPKA9Q.ParseLine(LNewItem, APath);
        end;
      end;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPKA9Q);
finalization
  UnRegisterFTPListParser(TIdFTPLPKA9Q);

end.
