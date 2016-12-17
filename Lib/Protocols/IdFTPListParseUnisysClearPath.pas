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
  Rev 1.0    12/8/2004 8:45:02 AM  JPMugaas
}

unit IdFTPListParseUnisysClearPath;

{
  Unisys ClearPath (MCP and OS/2)
  DIRECTORY_FORMAT=NATIVE

  Much of this is based on:

  ClearPath Enterprise Servers
  FTP Services for ClearPath
  OS 2200 User's Guide
  ClearPath OS 2200 Release 8.0 January 2003
  © 2003 Unisys Corporation.
  All rights reserved.

  and

  ClearPath Enterprise Servers
  TCP/IP Distributed Systems Services Operations Guide
  ClearPath MCP Release 9.0 April 2004
  © 2004 Unisys Corporation.
  All rights reserved.

  With a sample showing a multiline response from:

  http://article.gmane.org/gmane.text.xml.cocoon.devel/24912

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
  DIRECTORY_FORMAT=STANDARD does not need be supported because that is probably listed
  in Unix format. If not, we'll deal with it given some data samples.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

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
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : Boolean; override;
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseUnisysClearPath"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, SysUtils;

{ TIdFTPLPUnisysClearPath }

class function TIdFTPLPUnisysClearPath.GetIdent: String;
begin
  Result := 'Unisys Clearpath'; {Do not localize}
end;

class function TIdFTPLPUnisysClearPath.IsContinuedLine(const AData: String): Boolean;
begin
  Result := TextStartsWith(AData, ' '); {Do not localize}
end;

class function TIdFTPLPUnisysClearPath.IsFooter(const AData: String): Boolean;
var
  s : TStrings;
begin
  Result := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count = 4 then
    begin
      if (s[1] = 'Files') or (s[1] = 'File') then begin {Do not localize}
        Result := (s[3] = 'Octets') or (s[3] = 'Octet');  {Do not localize}
      end;
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.IsHeader(const AData: String): Boolean;
var
  s : TStrings;
begin
  Result := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count > 2 then begin
      Result := (s[0] = 'Report') and (s[1] = 'for:');
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdUnisysClearPathFTPListItem.Create(AOwner);
end;

class function TIdFTPLPUnisysClearPath.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  s : TStrings;
  LI : TIdUnisysClearPathFTPListItem;
begin
  Result := False;
  LI := AItem as TIdUnisysClearPathFTPListItem;
  LI.ItemType := ditFile;
  s := TStringList.Create;
  try
    SplitDelimitedString(LI.Data, s, True);
    if s.Count > 4 then
    begin
      LI.FileName := s[0];
      LI.FileKind := s[1];
      //size
      if IsNumeric(s[2]) then
      begin
        LI.Size := IndyStrToInt(s[2], 0);
        AItem.SizeAvail := True;
        //creation date
        if IsMMDDYY(s[3], '/') then {Do not localize}
        begin
          LI.CreationDate := DateMMDDYY(s[3]);
          if IsHHMMSS(s[4], ':') then {Do not localize}
          begin
            LI.CreationDate := LI.CreationDate + TimeHHMMSS(s[4]);
            Result := True;
          end;
        end;
      end;
      s.Clear;
      //remove path from localFileName
      SplitDelimitedString(LI.FileName, s, True, '/'); {Do not localize}
      if s.Count > 0 then begin
        LI.LocalFileName := s[s.Count-1];
      end else begin
        Result := False;
      end;
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPUnisysClearPath.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  i : Integer;
  LItem : TIdFTPListItem;
begin
  for i := 0  to AListing.Count-1 do
  begin
    if not IsWhiteString(AListing[i]) then
    begin
      if not (IsHeader(AListing[i]) or IsFooter(AListing[i])) then
      begin
        if (not IsContinuedLine(AListing[i])) then //needed because some VMS computers return entries with multiple lines
        begin
          LItem := MakeNewItem(ADir);
          LItem.Data := UnfoldLines(AListing[i], i, AListing);
          Result := ParseLine(LItem);
          if not Result then begin
            FreeAndNil(LItem);
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPUnisysClearPath);
finalization
  UnRegisterFTPListParser(TIdFTPLPUnisysClearPath);

end.
