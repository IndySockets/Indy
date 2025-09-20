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
  Rev 1.5    2/23/2005 6:34:28 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.4    10/26/2004 9:46:34 PM  JPMugaas
  Updated refs.

  Rev 1.3    4/19/2004 5:06:10 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.2    2004.02.03 5:45:40 PM  czhower
  Name changes

  Rev 1.1    10/19/2003 2:27:20 PM  DSiders
  Added localization comments.

  Rev 1.0    4/7/2003 04:11:38 PM  JPMugaas
  I mistakenly omitted the OS-9 parser when restructuring.  Restored.
}

unit IdFTPListParseMicrowareOS9;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdFTPList, IdFTPListParseBase,IdFTPListTypes;

type
  TIdMicrowareOS9FTPListItem = class(TIdOwnerFTPListItem)
  protected
    FOS9OwnerPermissions : String;
    FOS9PublicPermissions : String;
    FOS9MiscPermissions : String;
    FOS9Sector: UInt32;
  public
    property OS9OwnerPermissions : String read FOS9OwnerPermissions write FOS9OwnerPermissions;
    property OS9PublicPermissions : String read FOS9PublicPermissions write FOS9PublicPermissions;
    property OS9MiscPermissions : String read FOS9MiscPermissions write FOS9MiscPermissions;
    property OS9Sector : UInt32 read FOS9Sector write FOS9Sector;
  end;

  TIdFTPLPMicrowareOS9 = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseMicrowareOS9"'}
  {$ENDIF}

implementation

uses
  IdFTPCommon, IdGlobalProtocols, IdStrings, SysUtils;

const
  MICROWARE_OS9 = 'MicroWare OS-9'; {do not localize}

{ TIdFTPLPMicrowareOS9 }

class function TIdFTPLPMicrowareOS9.GetIdent: String;
begin
  Result := MICROWARE_OS9;
end;

class function TIdFTPLPMicrowareOS9.IsHeader(const AData: String): Boolean;
var
  LWrds : TStrings;
begin
  {The banner is usually something like this:

                              Directory of . 11:44:44
    Owner   Last modified  Attributes Sector Bytecount Name
  –––––––   –––––––––––––  –––––––––– –––––– ––––––––– ––––
  }
  LWrds := TStringList.Create;
  try
    Result := False;
    SplitDelimitedString(AData, LWrds, True);
    if LWrds.Count > 2 then
    begin
      Result := (LWrds[0] = 'Directory') and (LWrds[1] = 'of') and  {do not localize}
        (PatternsInStr(':', LWrds[LWrds.Count - 1]) = 2);
      if not Result then
      begin
        Result := (LWrds.Count = 7) and
          (LWrds[0] = 'Owner') and      {do not localize}
          (LWrds[1] = 'Last') and       {do not localize}
          (LWrds[2] = 'modified') and   {do not localize}
          (LWrds[3] = 'Attributes') and {do not localize}
          (LWrds[4] = 'Sector') and     {do not localize}
          (LWrds[5] = 'Bytecount') and  {do not localize}
          (LWrds[6] = 'Name');          {do not localize}
      end;
    end;
  finally
    FreeAndNil(LWrds);
  end;
end;

class function TIdFTPLPMicrowareOS9.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMicrowareOS9FTPListItem.Create(AOwner);
end;

class function TIdFTPLPMicrowareOS9.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
  LPerms : String;
  LI : TIdMicrowareOS9FTPListItem;
begin
  LI := AItem as TIdMicrowareOS9FTPListItem;
  LBuf := TrimLeft(LI.Data);
  //Owner
  LI.OwnerName := Fetch(LBuf);
  LBuf := TrimLeft(LBuf);
  //Modified date
  LI.ModifiedDate := DateYYMMDD(Fetch(LBuf));
  LBuf := TrimLeft(LBuf);
  //not sure what this number is
  Fetch(LBuf);
  LBuf := TrimLeft(LBuf);
  //permissions
  LPerms := Fetch(LBuf);
  LBuf := TrimLeft(LBuf);
  if TextStartsWith(LPerms, 'd') then begin
    LI.ItemType := ditDirectory;
  end else begin
    LI.ItemType := ditFile;
  end;
  LI.PermissionDisplay := LPerms;
  LI.OS9MiscPermissions := Copy(LPerms, 1, 2);
  LI.OS9PublicPermissions := Copy(LPerms, 3, 3);
  LI.OS9OwnerPermissions := Copy(LPerms, 5, 3);
  //sector
  LI.OS9Sector := IndyStrToInt64('$'+Fetch(LBuf), 0);
  LBuf := TrimLeft(LBuf);
  //size not sure if in decimal or hexidecimal
  LI.Size := IndyStrToInt64(Fetch(LBuf), 0);
  //name
  LI.FileName := LBuf;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPMicrowareOS9);
finalization
  UnRegisterFTPListParser(TIdFTPLPMicrowareOS9);

end.
