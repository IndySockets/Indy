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
  Rev 1.4    10/26/2004 9:36:28 PM  JPMugaas
  Updated ref.

  Rev 1.3    4/19/2004 5:05:54 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.2    2004.02.03 5:45:32 PM  czhower
  Name changes

  Rev 1.1    10/19/2003 2:27:06 PM  DSiders
  Added localization comments.

  Rev 1.0    2/19/2003 10:13:28 PM  JPMugaas
  Moved parsers to their own classes.
}

unit IdFTPListParseCiscoIOS;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase,IdFTPListTypes;

{
  I think this FTP Server is embedded in the Cisco routers.

  The Cisco IOS router FTP Server only returns filenames, not dirs.
  You set up a root dir and then you can only access that.
  You might be able to update something such as flash RAM by specifying
  pathes with uploads.
}

type
  TIdCiscoIOSFTPListItem = class(TIdMinimalFTPListItem);

  TIdFTPLPCiscoIOS = class(TIdFTPLPNList)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseCiscoIOS"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;

{ TIdFTPLPCiscoIOS }

class function TIdFTPLPCiscoIOS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
begin
  // Identifier obtained from
  // http://www.cisco.com/univercd/cc/td/doc/product/access/acs_serv/as5800/sc_3640/features.htm#xtocid210805
  // 1234567890
  Result := TextStartsWith(ASysDescript, 'Cisco IOS ');  {do not localize}
end;

class function TIdFTPLPCiscoIOS.GetIdent: String;
begin
  Result := 'Cisco IOS';  {do not localize}
end;

class function TIdFTPLPCiscoIOS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdCiscoIOSFTPListItem.Create(AOwner);
end;

initialization
  RegisterFTPListParser(TIdFTPLPCiscoIOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPCiscoIOS);
end.
