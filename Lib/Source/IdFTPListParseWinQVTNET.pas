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
  Rev 1.5    10/26/2004 10:03:22 PM  JPMugaas
  Updated refs.

  Rev 1.4    4/19/2004 5:05:42 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:26 PM  czhower
  Name changes

  Rev 1.2    1/22/2004 7:20:56 AM  JPMugaas
  System.Delete changed to IdDelete so the code can work in NET.

  Rev 1.1    10/19/2003 3:48:20 PM  DSiders
  Added localization comments.

  Rev 1.0    2/19/2003 05:49:50 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseWinQVTNET;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

{
  This was tested with data obtained from WinQVT/Net Version 3.98.15 running
  on Windows 2000.

  No parser is required for later versions because those use the Unix listing
  format.
}

type
  TIdWinQVNetFTPListItem = class(TIdFTPListItem);

  TIdFTPLPWinQVNet = class(TIdFTPListBase)
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
    {$HPPEMIT '#pragma link "IdFTPListParseWinQVTNET"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{ TIdFTPLPWinQVNet }

class function TIdFTPLPWinQVNet.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LData : String;
begin
  Result := False;

  if AListing.Count > 0 then
  {
  test.txt                        0  10-23-2003 01:01
  123456789012345678901234567890123456789012345678901234567890
           1         2         3         4         5         6
  }
  begin
    LData := AListing[0];
    Result := (Copy(LData, 38, 1) = '-') and         {do not localize}
              (Copy(LData, 41, 1) = '-') and         {do not localize}
              (Copy(LData, 49, 1) = ':') and         {do not localize}
              IsMMDDYY(Copy(LData, 36, 10), '-') and {do not localize}
              (Copy(LData, 46, 1) = ' ') and         {do not localize}
              IsHHMMSS(Copy(LData, 47, 5), ':');     {do not localize}
  end;
end;

class function TIdFTPLPWinQVNet.GetIdent: String;
begin
  Result := 'WinQVT/NET'; {do not localize}
end;

class function TIdFTPLPWinQVNet.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdWinQVNetFTPListItem.Create(AOwner);
end;

class function TIdFTPLPWinQVNet.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
begin
  //filename (note that it can contain spaces on WinNT with my test case
  AItem.FileName := ExtractQVNETFileName(AItem.Data);
  LBuf := AItem.Data;
  //item type
  if IndyPos('/', Copy(LBuf, 1, 13)) > 0 then begin {do not localize}
    AItem.ItemType := ditDirectory;
  end;
  IdDelete(LBuf, 1, 13);
  LBuf := TrimLeft(LBuf);
  //Size
  AItem.Size := IndyStrToInt64(Fetch(LBuf), 0);
  //Date
  LBuf := TrimLeft(LBuf);
  AItem.ModifiedDate := DateMMDDYY(Fetch(LBuf));
  //Time
  LBuf := Trim(LBuf);
  AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LBuf);
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPWinQVNet);
finalization
  UnRegisterFTPListParser(TIdFTPLPWinQVNet);

end.
