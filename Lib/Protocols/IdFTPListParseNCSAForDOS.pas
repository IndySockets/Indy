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
  Rev 1.6    12/5/2004 5:06:30 PM  JPMugaas
  Tightened the detection for NCSA Telnet FTP Server for DOS.  The parser was
  causing problems with SuperTCP because the formats are similar.  By
  preventing SuperTCP from being detected, LongFilenames were not parsed in
  SuperTCP running on Windows 2000.

  Rev 1.5    10/26/2004 9:51:14 PM  JPMugaas
  Updated refs.

  Rev 1.4    6/5/2004 4:45:22 PM  JPMugaas
  Reports SizeAvail=False for directories in a list.  As per the dir format.

  Rev 1.3    4/19/2004 5:05:58 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.2    2004.02.03 5:45:32 PM  czhower
  Name changes

  Rev 1.1    10/19/2003 3:36:04 PM  DSiders
  Added localization comments.

  Rev 1.0    2/19/2003 10:13:38 PM  JPMugaas
  Moved parsers to their own classes.
}

unit IdFTPListParseNCSAForDOS;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdNCSAforDOSFTPListItem = class(TIdFTPListItem);

  TIdFTPLPNCSAforDOS = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseNCSAForDOS"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;


{ TIdFTPLPNCSAforDOS }

class function TIdFTPLPNCSAforDOS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : TStrings;
  LData : String;
  i : Integer;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    //we have to loop through because there is a similar format
    //in SuperTCP but that one has an additional field with spaces
    //for long filenames.
    for i := 0 to AListing.Count-2 do
    begin
      LData := AListing[i];
      s := TStringList.Create;
      try
        SplitDelimitedString(LData, s, True);
        if s.Count = 4 then
        begin
          Result := ((s[1] = '<DIR>') or IsNumeric(s[1])) and  {do not localize}
                    IsMMDDYY(s[2], '-') and IsHHMMSS(s[3], ':') and {do not localize}
                    ExcludeQVNET(LData);
        end;
      finally
        FreeAndNil(s);
      end;
      if not Result then begin
        Break;
      end;
    end;
    Result := IsFooter(AListing[AListing.Count-1]);
  end;
end;

class function TIdFTPLPNCSAforDOS.GetIdent: String;
begin
  Result := 'NCSA for MS-DOS (CU/TCP)'; {do not localize}
end;

class function TIdFTPLPNCSAforDOS.IsFooter(const AData: String): Boolean;
var
  LWords : TStrings;
begin
  Result := False;
  LWords := TStringList.Create;
  try
    SplitDelimitedString(ReplaceAll(AData, '-', ' '), LWords, True);
    while LWords.Count > 2 do begin
      LWords.Delete(0);
    end;
    if LWords.Count = 2 then begin
      Result := (LWords[0] = 'Bytes') and (LWords[1] = 'Available');  {do not localize}
    end;
  finally
    FreeAndNil(LWords);
  end;
end;

class function TIdFTPLPNCSAforDOS.IsHeader(const AData: String): Boolean;
begin
  Result := False;
end;

class function TIdFTPLPNCSAforDOS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdNCSAforDOSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPNCSAforDOS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, LPt : String;
begin
  LBuf := AItem.Data;
  {filename - note that a space is illegal in MS-DOS so this should be safe}
  AItem.FileName := Fetch(LBuf);
  {type or size}
  LBuf := Trim(LBuf);
  LPt := Fetch(LBuf);
  if LPt = '<DIR>' then {do not localize}
  begin
    AItem.ItemType := ditDirectory;
    AItem.SizeAvail := False;
  end else
  begin
    AItem.ItemType := ditFile;
    AItem.Size := IndyStrToInt64(LPt, 0);
  end;
  //time stamp
  if LBuf <> '' then
  begin
    LBuf := Trim(LBuf);
    LPt := Fetch(LBuf);
    if LPt <> '' then
    begin
      //Date
      AItem.ModifiedDate := DateMMDDYY(LPt);
      LBuf := Trim(LBuf);
      LPt := Fetch(LBuf);
      if LPt <> '' then begin
        AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LPt);
      end;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPNCSAforDOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPNCSAforDOS);

end.
