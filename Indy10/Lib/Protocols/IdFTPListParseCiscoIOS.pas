{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16216: IdFTPListParseCiscoIOS.pas
{
{   Rev 1.4    10/26/2004 9:36:28 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.3    4/19/2004 5:05:54 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.2    2004.02.03 5:45:32 PM  czhower
{ Name changes
}
{
    Rev 1.1    10/19/2003 2:27:06 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.0    2/19/2003 10:13:28 PM  JPMugaas
{ Moved parsers to their own classes.
}
unit IdFTPListParseCiscoIOS;

interface

uses IdFTPList, IdFTPListParseBase,IdFTPListTypes, IdObjs;
{
I think this FTP Server is embedded in the Cisco routers.

The Cisco IOS router FTP Server only returns filenames,
not dirs.  You set up a root dir and then you can only access that.
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
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdSys;

{ TIdFTPLPCiscoIOS }

class function TIdFTPLPCiscoIOS.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  // Identifier obtained from
  // http://www.cisco.com/univercd/cc/td/doc/product/access/acs_serv/as5800/sc_3640/features.htm#xtocid210805
  // 1234567890
   Result := (Copy(ASysDescript, 1, 10) = 'Cisco IOS ');  {do not localize}
end;

class function TIdFTPLPCiscoIOS.GetIdent: String;
begin
  Result := 'Cisco IOS';  {do not localize}
end;

class function TIdFTPLPCiscoIOS.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdCiscoIOSFTPListItem.Create(AOwner);
end;

initialization
  RegisterFTPListParser(TIdFTPLPCiscoIOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPCiscoIOS);
end.
