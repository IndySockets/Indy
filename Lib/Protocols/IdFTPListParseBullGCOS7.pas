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
  Rev 1.6    10/26/2004 9:36:28 PM  JPMugaas
  Updated ref.

  Rev 1.5    4/19/2004 5:05:50 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.4    2004.02.03 5:45:30 PM  czhower
  Name changes

  Rev 1.3    1/22/2004 4:39:48 PM  SPerry
  fixed set problems

  Rev 1.2    10/19/2003 2:27:04 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:03:28 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 10:13:16 PM  JPMugaas
  Moved parsers to their own classes.
}

unit IdFTPListParseBullGCOS7;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdFTPLPGOS7 = class(TIdFTPLineOwnedList)
  protected
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
    {$HPPEMIT '#pragma link "IdFTPListParseBullGCOS7"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdFTPListTypes, IdGlobalProtocols, IdStrings, SysUtils;

{ TIdFTPLPGOS7 }

class function TIdFTPLPGOS7.CheckListing(AListing: TStrings;
  const ASysDescript: String = ''; const ADetails: Boolean = True): Boolean;
var
  LData : String;

  {
  - - -----0 SEPT         SYSADMIN         AUG 26, 1997 SEQ1
  - - -----0 SEPT         SYSADMIN         AUG 26, 1997 SEQ2
  123456789012345678901234567890123456789012345678901234567890
           1         2         3         4         5         6
  }
  function NumericOrSpace(const ALine : String): Boolean;
  var
    i : Integer;
  begin
    Result := True;
    for i := 1 to Length(ALine) do
    begin
      if (not IsNumeric(ALine[i])) and (not CharEquals(ALine, i, ' ')) then
      begin
        Result := False;
        Break;
      end;
    end;
  end;

begin
  Result := False;
  if AListing.Count > 0 then
  begin
    LData := AListing[0];
    Result := (Length(LData) > 54) and
      (CharIsInSet(LData, 1, '-d')) and
      (LData[2] = ' ') and
      (CharIsInSet(LData, 3, '-dsm')) and
      (LData[4] = ' ') and
      (LData[24] = ' ') and
      (LData[25] <> ' ') and
      (NumericOrSpace(Copy(LData, 46, 2))) and
      (CharIsInSet(LData, 48, ', ')) and
      (LData[49] = ' ') and
      (NumericOrSpace(Copy(LData, 50, 4))) and
      (LData[54] = ' ') and
      (LData[55] <> ' ');
  end;
end;

class function TIdFTPLPGOS7.GetIdent: String;
begin
  Result := 'Bull GCOS7'; {do not localize}
end;

class function TIdFTPLPGOS7.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
{
# From: FTP 7 - File Transfer Protocol
# This was a presentation that was made available in PDF form
# http://www.bull.com/servers/gcos7/ce7/ftp7-en.pdf
# reconstructed from screen-shots displayed in the presentation
}
var
  LBuf : String;
  LI : TIdOwnerFTPListItem;
begin
  LI := AItem as TIdOwnerFTPListItem;
  if LI.Data[1] = 'd' then begin
    LI.ItemType := ditDirectory;
  end else begin
    LI.ItemType := ditFile;
  end;
  LI.FileName := Copy(AItem.Data, 55, MaxInt);
  LBuf := ReplaceAll(Copy(AItem.Data, 42, 12), ',', '');
  if not IsWhiteString(LBuf) then begin
    LI.ModifiedDate := DateStrMonthDDYY(LBuf, ' ');
  end;
  LI.OwnerName := Trim(Copy(AItem.Data, 25, 17));
  //I don't think size is provided
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPGOS7);
finalization
  UnRegisterFTPListParser(TIdFTPLPGOS7);
end.
