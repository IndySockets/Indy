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
  Rev 1.0    12/8/2004 10:58:34 AM  JPMugaas
  PC-NFSD FTP List parser.

  Rev 1.0    12/8/2004 10:37:42 AM  JPMugaas
  Parser for PC-NFS for DOS.
}

unit IdFTPListParsePCNFSD;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

{
  This parser is a little more tolarant of stuff than others because of scanty samples.
  I only found one second hand and it might not have included a header or footer.
  Here's all I had:

  prog1    exe     2,563,136 06-10-99  10:00a
  temp         <dir>         01-27-97   3:41p

  That was from the TotalCommander helpfile.
  It was part of a PC-NFSD package for MS-DOS which included a FTP Deamon.
}

type
  TIdPCNFSDFTPListItem = class(TIdFTPListItem);

  TIdFTPLPPCNFSD = class(TIdFTPListBase)
  protected
    class function CheckLine(const AData : String): Boolean;
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
    {$HPPEMIT '#pragma link "IdFTPListParsePCNFSD"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, SysUtils;

const
  DIR = '<dir>';   {Do not translate}

{ TIdFTPLPPC-NFSD }

class function TIdFTPLPPCNFSD.CheckLine(const AData: String): Boolean;
var
  s : TStrings;
  i : Integer;
  LBuf : String;
begin
  Result := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count > 3 then
    begin
      //last col -time
      i := s.Count - 1;
      LBuf := s[i];
      if CharIsInSet(LBuf, Length(LBuf), 'ap') then   {do not localize}
      begin
        LBuf := Fetch(LBuf, 'a');          {Do not localize}
        LBuf := Fetch(LBuf, 'p');          {Do not localize}
        if IsHHMMSS(LBuf, ':') then
        begin
          Dec(i);
          //date
          if IsMMDDYY(s[i], '-') then
          begin
            Dec(i);
            // size or dir
            if IsNumeric(s[i]) or (s[i] = DIR) then begin
              Result := (i = 0) or (i = 1);
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPPCNFSD.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to AListing.Count -1 do
  begin
    Result := CheckLine(AListing[i]);
    if Result then begin
      Break;
    end;
  end;
end;

class function TIdFTPLPPCNFSD.GetIdent: String;
begin
  Result := 'PC-NFSD';   {Do not localize}
end;

class function TIdFTPLPPCNFSD.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdPCNFSDFTPListItem.Create(AOwner);
end;

class function TIdFTPLPPCNFSD.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LI : TIdPCNFSDFTPListItem;
  s : TStrings;
  i : Integer;
begin
  Result := False;
  LI := AItem as TIdPCNFSDFTPListItem;
  s := TStringList.Create;
  try
    SplitDelimitedString(LI.Data, s, True);
    if s.Count > 3 then
    begin
      LI.FileName := s[0];
      //assume filename 8.3 requirements in MS-DOS
      if Length(s[1]) < 4 then
      begin
        LI.FFileName := LI.FFileName + '.' + s[1];
        i := 2;
      end else begin
        i := 1;
      end;
      //<dir> or size
      LI.Size := ExtractNumber(s[i], False);
      if (LI.Size <> -1) or (s[i] = DIR) then
      begin
        if s[i] = DIR then
        begin
          LI.ItemType := ditDirectory;
          LI.SizeAvail := False;
        end;
        Inc(i);
        //date
        if IsMMDDYY(s[i], '-') then
        begin
          LI.ModifiedDate := DateMMDDYY(s[i]);
          Inc(i);
          //time
          if CharIsInSet(s[i], Length(s[i]), 'ap') then  {Do not localize}
          begin
            LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(s[i]);
            Result := True;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(s);
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPPCNFSD);
finalization
  UnRegisterFTPListParser(TIdFTPLPPCNFSD);

end.
