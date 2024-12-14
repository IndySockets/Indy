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
  Rev 1.9    11/29/2004 2:45:28 AM  JPMugaas
  Support for DOS attributes (Read-Only, Archive, System, and Hidden) for use
  by the Distinct32, OS/2, and Chameleon FTP list parsers.

  Rev 1.8    10/26/2004 9:36:28 PM  JPMugaas
  Updated ref.

  Rev 1.7    4/19/2004 5:05:56 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.6    2004.02.03 5:45:32 PM  czhower
  Name changes

  Rev 1.5    24/01/2004 19:19:28  CCostelloe
  Cleaned up warnings

  Rev 1.4    1/23/2004 12:52:58 PM  SPerry
  fixed set problems

  Rev 1.3    1/22/2004 5:54:02 PM  SPerry
  fixed set problems

  Rev 1.2    10/19/2003 2:27:08 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:03:46 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 10:13:32 PM  JPMugaas
  Moved parsers to their own classes.
}

unit IdFTPListParseDistinctTCPIP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdDistinctTCPIPFTPListItem =  class(TIdDOSBaseFTPListItem)
  protected
    FDist32FileAttributes : String;
  public
    property ModifiedDateGMT;
    //This is kept solely for compatability, do NOT remove this as you will probably
    //break someone's code
    property Dist32FileAttributes : string read FDist32FileAttributes write FDist32FileAttributes;
  end;

  TIdFTPLPDistinctTCPIP = class(TIdFTPLPBaseDOS)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
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
    {$HPPEMIT '#pragma link "IdFTPListParseDistinctTCPIP"'}
  {$ENDIF}

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.SysTime,
  Posix.Time,
  {$ENDIF}
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPDistinctTCPIP }

class function TIdFTPLPDistinctTCPIP.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
const
  DistValidTypes = '-d';
  DistValidAttrs  = 'wash-d';
  //w - can write - read attribute not set
  //a - archive bit set
  //s - system attribute bit set
  //h - hidden system bit set
var
  s : TStrings;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      if s.Count > 2 then
      begin
        Result := (Length(s[0]) = 5) and (CharIsInSet(s[0], 1, DistValidTypes))
          and IsNumeric(s[1]) and (StrToMonth(s[2]) > 0);
        if Result then
        begin
          Result := (CharIsInSet(s[0], 1, DistValidAttrs)) and
                    (CharIsInSet(s[0], 2, DistValidAttrs)) and
                    (CharIsInSet(s[0], 3, DistValidAttrs)) and
                    (CharIsInSet(s[0], 4, DistValidAttrs)) and
                    (CharIsInSet(s[0], 5, DistValidAttrs));
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPDistinctTCPIP.GetIdent: String;
begin
  Result := 'Distinct TCP/IP';  {do not localize}
end;

class function TIdFTPLPDistinctTCPIP.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdDistinctTCPIPFTPListItem.Create(AOwner);
end;

class function TIdFTPLPDistinctTCPIP.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, LBuf2, LDate : String;
  LI : TIdDistinctTCPIPFTPListItem;
begin
  Result := False;
  LI := AItem as TIdDistinctTCPIPFTPListItem;
  LI.Attributes.Read_Only := True;
  LBuf := TrimLeft(LI.Data);
  //attributes and attributes
  LBuf2 := Fetch(LBuf);
  LI.Dist32FileAttributes := LBuf2;
  LI.Attributes.AddAttribute(LBuf2);
  LBuf := TrimLeft(LBuf);
  if TextStartsWith(LI.Dist32FileAttributes, 'd') then begin
    LI.ItemType := ditDirectory;
  end;
  //size
  LI.Size := IndyStrToInt64(Fetch(LBuf), 0);
  LBuf := TrimLeft(LBuf);
  //date - month
  LDate := Fetch(LBuf);
  if StrToMonth(LDate) = 0 then begin
    Exit;
  end;
  LBuf := TrimLeft(LBuf);
  //date - day and year
  LBuf2 := Fetch(LBuf);
  //we do it this way because a year might sometimes be missing
  //in which case, we just add the current year.
  LDate := LDate + ',' + LBuf2;
  LDate := ReplaceAll(LDate, ',', ' ');
  LI.ModifiedDate := DateStrMonthDDYY(LDate, ' ', True);
  //time
  LBuf := TrimLeft(LBuf);
  LDate := Fetch(LBuf);
  if not IsHHMMSS(LDate, ':') then begin
    Exit;
  end;
  LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LDate);
  // -wa--          23  Dec 29,2002  18:42  createtest.txt
  // #Timestamp test with createtest.txt.
  // Corresponding local Dir entry:
  // 12/29/2002  01:42p                  23 CreateTest.txt
  // I suspect that this server returns the timestamp as GMT
  LI.ModifiedDateGMT := LI.ModifiedDate;
  LI.ModifiedDate := UTCTimeToLocalTime(LI.ModifiedDateGMT);
  // file name
  LBuf := StripSpaces(LBuf, 1);
  LI.FileName := LBuf;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPDistinctTCPIP);
finalization
  UnRegisterFTPListParser(TIdFTPLPDistinctTCPIP);

end.
