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
{   Rev 1.5    2/23/2005 6:34:28 PM  JPMugaas
{ New property for displaying permissions ina GUI column.  Note that this
{ should not be used like a CHMOD because permissions are different on
{ different platforms - you have been warned.
}
{
{   Rev 1.4    10/26/2004 9:46:34 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.3    4/19/2004 5:06:10 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.2    2004.02.03 5:45:40 PM  czhower
{ Name changes
}
{
    Rev 1.1    10/19/2003 2:27:20 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.0    4/7/2003 04:11:38 PM  JPMugaas
{ I mistakenly omitted the OS-9 parser when restructuring.  Restored.
}
unit IdFTPListParseMicrowareOS9;

interface

uses IdFTPList, IdFTPListParseBase,IdFTPListTypes, IdObjs;

type
  TIdMicrowareOS9FTPListItem = class(TIdOwnerFTPListItem)
  protected
    FOS9OwnerPermissions : String;
    FOS9PublicPermissions : String;
    FOS9MiscPermissions : String;
    FOS9Sector: Cardinal;
  public
    property OS9OwnerPermissions : String read FOS9OwnerPermissions write FOS9OwnerPermissions;
    property OS9PublicPermissions : String read FOS9PublicPermissions write FOS9PublicPermissions;
    property OS9MiscPermissions : String read FOS9MiscPermissions write FOS9MiscPermissions;
    property OS9Sector : Cardinal read FOS9Sector write FOS9Sector;
  end;
  TIdFTPLPMicrowareOS9 = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, IdSys;

const
  MICROWARE_OS9 = 'MicroWare OS-9'; {do not localize}

{ TIdFTPLPMicrowareOS9 }

class function TIdFTPLPMicrowareOS9.GetIdent: String;
begin
  Result := MICROWARE_OS9;
end;

class function TIdFTPLPMicrowareOS9.IsHeader(const AData: String): Boolean;
var LWrds : TIdStrings;
{The banner is usually something like this:

                            Directory of . 11:44:44
 Owner    Last modified  Attributes Sector Bytecount Name
–––––––   –––––––––––––  –––––––––– –––––– ––––––––– ––––
}
begin
  LWrds := TIdStringList.Create;
  try
    Result := False;
    SplitColumns(AData,LWrds);
    if (LWrds.Count > 2) then
    begin
      Result := (LWrds[0] = 'Directory') and (LWrds[1] = 'of') and  {do not localize}
        (PatternsInStr(':',LWrds[LWrds.Count - 1])=2);
      if Result = False then
      begin
        Result := (LWrds.Count = 7) and
          (LWrds[0] = 'Owner') and (LWrds[1] = 'Last') and (LWrds[2] = 'modified') and  {do not localize}
          (LWrds[3] = 'Attributes') and (LWrds[4] = 'Sector') and (LWrds[5] = 'Bytecount') and  {do not localize}
          (LWrds[6] = 'Name');  {do not localize}
      end;
    end;
  finally
    Sys.FreeAndNil(LWrds);
  end;
end;

class function TIdFTPLPMicrowareOS9.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMicrowareOS9FTPListItem.Create(AOwner);
end;

class function TIdFTPLPMicrowareOS9.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LBuf : String;
    LPerms : String;
    LI : TIdMicrowareOS9FTPListItem;
begin
  LI := AItem as TIdMicrowareOS9FTPListItem;
  LBuf := Sys.TrimLeft(LI.Data);
  //Owner
  LI.OwnerName := Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //Modified date
  LI.ModifiedDate := DateYYMMDD(Fetch(LBuf));
  LBuf := Sys.TrimLeft(LBuf);
  //not sure what this number is
  Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //permissions
  LPerms := Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  if Copy(LPerms,1,1)='d' then
  begin
    LI.ItemType := ditDirectory;
  end
  else
  begin
    LI.ItemType := ditFile;
  end;
  LI.PermissionDisplay := LPerms;
  LI.OS9MiscPermissions := Copy(LPerms,1,2);
  LI.OS9PublicPermissions := Copy(LPerms,3,3);
  LI.OS9OwnerPermissions := Copy(LPerms,5,3);
  //sector
  LI.OS9Sector := Sys.StrToInt64('$'+Fetch(LBuf),0);
  LBuf := Sys.TrimLeft(LBuf);
  //size not sure if in decimal or hexidecimal
  LI.Size := Sys.StrToInt64(Fetch(LBuf),0);
  //name
  LI.FileName := LBuf;
  Result := True;
end;

initialization
  IdFTPListParseBase.RegisterFTPListParser(TIdFTPLPMicrowareOS9);
end.
