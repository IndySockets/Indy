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
  Rev 1.6    11/29/2004 2:45:28 AM  JPMugaas
  Support for DOS attributes (Read-Only, Archive, System, and Hidden) for use
  by the Distinct32, OS/2, and Chameleon FTP list parsers.

  Rev 1.5    10/26/2004 9:51:16 PM  JPMugaas
  Updated refs.

  Rev 1.4    4/19/2004 5:05:46 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:28 PM  czhower
  Name changes

  Rev 1.2    10/19/2003 3:36:14 PM  DSiders
  Added localization comments.

  Rev 1.1    10/1/2003 05:27:36 PM  JPMugaas
  Reworked OS/2 FTP List parser for Indy.  The aprser wasn't detecting OS/2 in
  some more samples I was able to get ahold of.

  Rev 1.0    2/19/2003 05:50:28 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseOS2;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

{
  This parser is based on some data that I had managed to obtain second hand
  from what people posted on the newsgroups.
}

type
  TIdOS2FTPListItem = class(TIdDOSBaseFTPListItem);

  TIdFTPLPOS2 = class(TIdFTPLPBaseDOS)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

const
  OS2PARSER = 'OS/2'; {do not localize}

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseOS2"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;


{ TIdFTPLPOS2 }

class function TIdFTPLPOS2.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuf, LBuf2 : String;
  LNum : String;
begin
  {
  "             73098      A          04-06-97   15:15  ds0.internic.net1996052434624.txt"
  "                 0           DIR   12-11-95   13:55  z"
  or maybe this:
  taken from the FileZilla source-code comments
  "     0           DIR   05-12-97   16:44  PSFONTS"
  "36611      A    04-23-103   10:57  OS2 test1.file"
  " 1123      A    07-14-99   12:37  OS2 test2.file"
  "    0 DIR       02-11-103   16:15  OS2 test1.dir"
  " 1123 DIR  A    10-05-100   23:38  OS2 test2.dir"
  }
  Result := False;
  if AListing.Count > 0 then
  begin
    LBuf := TrimLeft(AListing[0]);
    LNum := Fetch(LBuf);
    if not IsNumeric(LNum) then begin
      Exit;
    end;
    repeat
      LBuf := TrimLeft(LBuf);
      LBuf2 := Fetch(LBuf);
      if LBuf2 = 'DIR' then {do not localize}
      begin
        LBuf := TrimLeft(LBuf);
        LBuf2 := Fetch(LBuf);
      end;
      if IsMMDDYY(LBuf2, '-') then begin
        //we found a date
        Break;
      end;
      if not IsValidAttr(LBuf2) then begin
        Exit;
      end;
    until False;
    //there must be two spaces between the date and time
    if not TextStartsWith(LBuf, '  ') then begin {do not localize}
      Exit;
    end;
    if (Length(LBuf) >= 3) and (LBuf[3] = ' ') then begin {do not localize}
      Exit;
    end;
    LBuf := TrimLeft(LBuf);
    LBuf2 := Fetch(LBuf);
    Result := IsHHMMSS(LBuf2, ':');
  end;
end;

class function TIdFTPLPOS2.GetIdent: String;
begin
  Result := OS2PARSER;
end;

class function TIdFTPLPOS2.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdOS2FTPListItem.Create(AOwner);
end;

class function TIdFTPLPOS2.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, lBuf2, LNum : String;
  LOSItem :  TIdOS2FTPListItem;
begin
  {
  Assume layout such as:

                   0           DIR   02-18-94   19:47  BC
               79836      A          11-19-96   19:08  w.txt
  12345678901234567890123456789012345678901234567890123456789012345678
           1         2         3         4         5         6
  }
  Result := False;
  LBuf := AItem.Data;
  LBuf := TrimLeft(LBuf);
  LNum := Fetch(LBuf);
  AItem.Size := IndyStrToInt64(LNum, 0);
  LOSItem := AItem as TIdOS2FTPListItem;
  repeat
    //keep going until we find a date
    LBuf := TrimLeft(LBuf);
    LBuf2 := Fetch(LBuf);
    if LNum = '0' then
    begin
      if LBuf2 = 'DIR' then {do not localize}
      begin
        LOSItem.ItemType := ditDirectory;
        LBuf := TrimLeft(LBuf);
        LBuf2 := Fetch(LBuf);
      end;
    end;
    if IsMMDDYY(LBuf2, '-') then
    begin
      //we found a date
      LOSItem.ModifiedDate := DateMMDDYY(LBuf2);
      Break;
    end;
    LOSItem.Attributes.AddAttribute(LBuf2);
    if LBuf = '' then begin
      Exit;
    end;
  until False;
  //time
  LBuf := TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  if IsHHMMSS(LBuf2, ':') then begin {do not localize}
    LOSItem.ModifiedDate := LOSItem.ModifiedDate + TimeHHMMSS(LBuf2);
  end;
  //fetch removes one space.  We ned to remove an additional one
  //before the filename as a filename might start with a space
  Delete(LBuf, 1, 1);
  LOSItem.FileName := LBuf;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPOS2);
finalization
  UnRegisterFTPListParser(TIdFTPLPOS2);

end.
