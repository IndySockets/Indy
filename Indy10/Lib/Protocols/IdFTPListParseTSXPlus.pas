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
  Rev 1.2    10/26/2004 9:55:58 PM  JPMugaas
  Updated refs.

  Rev 1.1    6/11/2004 9:38:48 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.0    6/7/2004 7:46:26 PM  JPMugaas
}

unit IdFTPListParseTSXPlus;

{
  FTP List parser for TSX+.  This is based on:
  http://www.gweep.net/~shifty/music/miragehack/gcc/xasm/cug292.lst
}

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdTSXPlusFTPListItem = class(TIdMinimalFTPListItem)
  protected
    FNumberBlocks : Integer;
  public
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
  end;
  TIdFTPLPTSXPlus = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
    class function GetIdent : String; override;
  end;

implementation
uses IdFTPCommon, IdGlobal, SysUtils;

{ TIdFTPLPTSXPlus }

class function TIdFTPLPTSXPlus.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var i : Integer;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    for i := AListing.Count -1 downto 0 do
    begin
      if AListing[i]<>'' then
      begin
        if IsFooter(AListing[i]) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

class function TIdFTPLPTSXPlus.GetIdent: String;
begin
  Result := 'TSX+'; {do not localize}
end;

class function TIdFTPLPTSXPlus.IsFooter(const AData: String): Boolean;
var LBuf, LPart : String;
//The footer is like this:
//Directory [du3:/cug292/pcdsk4/*.*] / 9 Files / 563 Blocks
begin
  Result := False;
  LBuf := AData;
  LPart := Fetch(LBuf,'[');
  if LBuf='' then
  begin
    Exit;
  end;
  LPart := TrimRight(LPart);
  if LPart = 'Directory' then {do not localize}
  begin
    Fetch(LBuf,']');
    if LBuf='' then
    begin
      Exit;
    end;
    LBuf := TrimLeft(LBuf);
    if (Copy(LBuf,1,1)='/') then
    begin
      IdGlobal.IdDelete(LBuf,1,1);
      if IndyPos('Files',LBuf) > 0 then {do not localize}
      begin
        LPart :=  Fetch(LPart, '/');
        if LBuf='' then
        begin
          Exit;
        end;
        Result := (IndyPos('Block', LBuf) > 0); {do not localize}
      end;
    end;
  end;
end;

class function TIdFTPLPTSXPlus.IsHeader(const AData: String): Boolean;
begin
  Result := False;
end;

class function TIdFTPLPTSXPlus.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdTSXPlusFTPListItem.Create(AOwner);
end;

class function TIdFTPLPTSXPlus.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
{
Note that this parser is odd because it will create a new TIdFTPListItem.
I know that is not according to the current conventional design.  However, KA9Q
is unusual because a single line can have two items (maybe more)
}
var LBuf, LExt : String;
    LNewItem : TIdFTPListItem;
    LDir : TIdFTPListItems;
begin

  LBuf := TrimLeft(AItem.Data);
  AItem.FileName := Fetch(LBuf,'.');
  LExt := Fetch(LBuf);
  if LExt = 'dsk' then {do not localize}
  begin
    AItem.ItemType := ditDirectory;
  end
  else
  begin
    AItem.ItemType := ditFile;
    AItem.FileName := AItem.FileName + '.'+LExt;
  end;
  LBuf := TrimLeft(LBuf);
  //block count
  (AItem as TIdTSXPlusFTPListItem).NumberBlocks := IndyStrToInt(Fetch(LBuf),0);
  LBuf := TrimRight(LBuf);
  if LBuf<>'' then
  begin
    LDir := AItem.Collection as TIdFTPListItems;
    LNewItem := TIdFTPLPTSXPlus.MakeNewItem( LDir);
    LNewItem.Data := LBuf;
    TIdFTPLPTSXPlus.ParseLine(LNewItem,APath);
    LNewItem.Data := AItem.Data;
    Result := True;
  end
  else
  begin
    Result := True;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPTSXPlus);
finalization
  UnRegisterFTPListParser(TIdFTPLPTSXPlus);
end.
