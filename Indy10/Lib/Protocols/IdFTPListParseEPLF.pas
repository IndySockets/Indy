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
  Rev 1.6    10/26/2004 9:36:30 PM  JPMugaas
  Updated ref.

  Rev 1.5    4/19/2004 5:05:30 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.4    2004.02.03 5:45:22 PM  czhower
  Name changes

  Rev 1.3    11/26/2003 6:22:24 PM  JPMugaas
  IdFTPList can now support file creation time for MLSD servers which support
  that feature.  I also added support for a Unique identifier for an item so
  facilitate some mirroring software if the server supports unique ID with EPLF
  and MLSD.

  Rev 1.2    10/19/2003 2:27:14 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:03:48 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 04:18:16 AM  JPMugaas
  More things restructured for the new list framework.
}

unit IdFTPListParseEPLF;

interface

uses
  IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdObjs;

type
  TIdAEPLFFTPListItem = class(TIdFTPListItem)
  protected
    //Unique ID for an item to prevent yourself from downloading something twice
    FUniqueID : String;
  public
    property ModifiedDateGMT;
    //Valid only with EPLF and MLST
    property UniqueID : string read FUniqueID write FUniqueID;
  end;
  TIdFTPLPEPLF = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdSys;

{ TIdFTPLPEPLF }

class function TIdFTPLPEPLF.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  Result := (AListing.Count > 0) and (Length(AListing[0])>2) and (AListing[0][1]='+')
      and (IndyPos(#9,AListing[0])>0);
end;

class function TIdFTPLPEPLF.GetIdent: String;
begin
  Result := 'EPLF'; {do not localize}
end;

class function TIdFTPLPEPLF.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdAEPLFFTPListItem.Create(AOwner);
end;

class function TIdFTPLPEPLF.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LFacts : TIdStrings;
    i : Integer;
  LI : TIdAEPLFFTPListItem;
begin
  LI := AItem as TIdAEPLFFTPListItem;
  LFacts := TIdStringList.Create;
  try
    LI.FileName := ParseFacts(Copy(LI.Data, 2, Length(LI.Data)), LFacts, ',', #9);
    for i := 0 to LFacts.Count -1 do
    begin
      if LFacts[i] = '/' then   {do not localize}
      begin
        LI.ItemType := ditDirectory;
      end;
      if (Length(LFacts[i]) > 0) and (LFacts[i][1] = 's') then
      begin
        AItem.Size := Sys.StrToInt64(Copy(LFacts[i], 2, Length(LFacts[i])), 0);
      end;
      if LFacts[i][1] = 'm' then  {do not localize}
      begin
        LI.ModifiedDate := EPLFDateToLocalDateTime(Copy(LFacts[i], 2, Length(LFacts[i])));
        LI.ModifiedDateGMT := EPLFDateToGMTDateTime(Copy(LFacts[i], 2, Length(LFacts[i])));
      end;
      if LFacts[i][1] = 'i' then   {do not localize}
      begin
        LI.UniqueID := Copy(LFacts[i],2,Length(LFacts[i]));
      end;
    end;
  finally
    Sys.FreeAndNil(LFacts);
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPEPLF);
finalization
  UnRegisterFTPListParser(TIdFTPLPEPLF);
end.
