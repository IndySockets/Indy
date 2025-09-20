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

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdAEPLFFTPListItem = class(TIdFTPListItem)
  protected
    //Unique ID for an item to prevent yourself from downloading something twice
    FUniqueID : String;
    //UNIX permissions
    FEPLFPermissions: String;
  public
    property ModifiedDateGMT;
    //Valid only with EPLF and MLST
    property UniqueID : string read FUniqueID write FUniqueID;
    property EPLFPermissions: string read FEPLFPermissions write FEPLFPermissions;
  end;

  TIdFTPLPEPLF = class(TIdFTPListBase)
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
    {$HPPEMIT '#pragma link "IdFTPListParseEPLF"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPEPLF }

class function TIdFTPLPEPLF.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s: String;
begin
  Result := (AListing.Count > 0);
  if Result then
  begin
    s := AListing[0];
    Result := (Length(s) > 2) and (s[1] = '+') and (IndyPos(#9, s) > 0);
  end;
end;

class function TIdFTPLPEPLF.GetIdent: String;
begin
  Result := 'EPLF'; {do not localize}
end;

class function TIdFTPLPEPLF.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdAEPLFFTPListItem.Create(AOwner);
end;

class function TIdFTPLPEPLF.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LFacts : TStrings;
  i : Integer;
  LI : TIdAEPLFFTPListItem;
  LBuf: String;
begin
  LI := AItem as TIdAEPLFFTPListItem;
  LFacts := TStringList.Create;
  try
    LI.FileName := ParseFacts(Copy(LI.Data, 2, MaxInt), LFacts, ',', #9);
    for i := 0 to LFacts.Count-1 do
    begin
      LBuf := LFacts[i];
      if LBuf = '/' then begin  {do not localize}
        LI.ItemType := ditDirectory;
      end
      else if LBuf = 'r' then begin  {do not localize}
        LI.ItemType := ditFile;
      end
      else if Length(LBuf) > 0 then
      begin
        case LBuf[1] of
          's':  {do not localize}
            begin
              AItem.Size := IndyStrToInt64(Copy(LBuf, 2, MaxInt), 0);
            end;
          'm': {do not localize}
            begin
              LBuf := Copy(LBuf, 2, MaxInt);
              LI.ModifiedDate := EPLFDateToLocalDateTime(LBuf);
              LI.ModifiedDateGMT := EPLFDateToGMTDateTime(LBuf);
            end;
          'i': {do not localize}
            begin
              LI.UniqueID := Copy(LBuf, 2, MaxInt);
            end;
          'u': {do not localize}
            begin
              if Length(LBuf) > 1 then begin
                if LBuf[2] = 'p' then begin {do not localize}
                  LI.EPLFPermissions := Copy(LBuf, 3, MaxInt);
                  LI.PermissionDisplay := LI.EPLFPermissions;
                end;
              end;
            end;
        end;
      end;
    end;
  finally
    FreeAndNil(LFacts);
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPEPLF);
finalization
  UnRegisterFTPListParser(TIdFTPLPEPLF);

end.
