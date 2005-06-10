{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  114686: IdFTPListParseUnisysClearPath.pas 
{
{   Rev 1.0    12/8/2004 8:45:02 AM  JPMugaas
{ Unisys ClearPath (MCP and OS/2) 
{ 
{ DIRECTORY_FORMAT=NATIVE
}
unit IdFTPListParseUnisysClearPath;

{
Much of this is based on:

ClearPath Enterprise
Servers
FTP Services for ClearPath
OS 2200
User's Guide
ClearPath OS 2200
Release 8.0
January 2003
© 2003 Unisys Corporation.
All rights reserved.

and

ClearPath Enterprise
Servers
TCP/IP Distributed Systems Services
Operations Guide
ClearPath MCP Release 9.0
April 2004
© 2004 Unisys Corporation.
All rights reserved.

With a sample from:

http://article.gmane.org/gmane.text.xml.cocoon.devel/24912

showing a multiline response.

This parses data in this form:
===
Report for: (UC)A ON PACK
A                       SEQDATA    84 03/08/1998  15:32
A/B                     SEQDATA    84 06/09/1998  12:03
A/B/C                   SEQDATA    84 06/09/1998  12:03
A/C                     SEQDATA    84 06/09/1998  12:03
A/C/C                   SEQDATA    84 06/09/1998  12:04
A/C/C/D                 SEQDATA    84 06/09/1998  12:04
          6 Files     504 Octets
===

The parserm only support DIRECTORY_FORMAT=NATIVE which is the default on that server.

DIRECTORY_FORMAT=STANDARD does not need be supported because that is probably listed in Unix format.

If not, we'll deal with it given some data samples.
}
interface
uses classes, IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdUnisysClearPathFTPListItem = class(TIdCreationDateFTPListItem)
  protected
    FFileKind : String;
  public
    property FileKind : String read FFileKind write FFileKind;
  end;
  TIdFTPLPUnisysClearPath = class(TIdFTPListBaseHeader)
  protected
    class function IsContinuedLine(const AData: String): Boolean;
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function ParseListing(AListing : TIdStrings; ADir : TIdFTPListItems) : boolean; override;
    class function GetIdent : String; override;
  end;

implementation
uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, IdSys;

{ TIdFTPLPUnisysClearPath }

class function TIdFTPLPUnisysClearPath.GetIdent: String;
begin
  Result := 'Unisys Clearpath';
end;

class function TIdFTPLPUnisysClearPath.IsContinuedLine(
  const AData: String): Boolean;
begin
  Result := (AData <> '') and (AData[1] = ' ');
end;

class function TIdFTPLPUnisysClearPath.IsFooter(
  const AData: String): Boolean;
var s : TIdStrings;
begin
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(AData,s);
    if s.Count=4 then
    begin
      if (s[1]='Files') or (s[1]='File') then  {Do not localize}
      begin
        Result := (s[3]='Octets') or (s[3]='Octet');  {Do not localize}
      end;
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.IsHeader(
  const AData: String): Boolean;
var s : TIdStrings;
begin
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(AData,s);
    if s.Count>2 then
    begin
      Result := (s[0]='Report') and (s[1]='for:');
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdUnisysClearPathFTPListItem.Create(AOwner);
end;

class function TIdFTPLPUnisysClearPath.ParseLine(
  const AItem: TIdFTPListItem; const APath: String): Boolean;
var s : TIdStrings;
  LI : TIdUnisysClearPathFTPListItem;
begin
  LI := AItem as TIdUnisysClearPathFTPListItem;
  LI.ItemType := ditFile;
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(LI.Data,s);
    if s.Count >4 then
    begin
      LI.FileName := s[0];
      LI.FileKind := s[1];
      //size
      if IsNumeric(s[2]) then
      begin
        LI.Size := StrToIntDef(s[2],0);
        AItem.SizeAvail := True;
        //creation date
        if IsMMDDYY(s[3],'/') then
        begin
          LI.CreationDate := DateMMDDYY(s[3]);
          if IsHHMMSS(s[4],':') then
          begin
            LI.CreationDate := LI.CreationDate + TimeHHMMSS(s[4]);
            Result := True;
          end;
        end;
      end;
      s.Clear;
      //remove path from localFileName
      SplitColumns(LI.FileName,s,'/');
      if s.Count >0 then
      begin
        LI.LocalFileName := s[s.Count-1];
        
      end
      else
      begin
        Result := False;
      end;
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.ParseListing(AListing: TIdStrings;
  ADir: TIdFTPListItems): boolean;
var i : Integer;
  LItem : TIdFTPListItem;
begin
  Result := True;
  for i := 0  to AListing.Count-1 do
  begin
    if not IsWhiteString(AListing[i]) then
    begin
      if Self.IsHeader(AListing[i]) or Self.IsFooter(AListing[i]) then
      begin
      end
      else
      begin
        if (IsContinuedLine(AListing[i]) = False ) then //needed because some VMS computers return entries with multiple lines
        begin
          LItem := MakeNewItem(ADir);
          LItem.Data := UnfoldLines(AListing[i],i,AListing);
          Result := ParseLine(LItem);
          if Not Result then
          begin
            Sys.FreeAndNil(LItem);
          end;
        end;
      end;
    end;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPUnisysClearPath);
finalization
  UnRegisterFTPListParser(TIdFTPLPUnisysClearPath);
end.
