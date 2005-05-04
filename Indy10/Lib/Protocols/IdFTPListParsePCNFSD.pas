{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  114693: IdFTPListParsePCNFSD.pas 
{
{   Rev 1.0    12/8/2004 10:58:34 AM  JPMugaas
{ PC-NFSD FTP List parser.
}
{
{   Rev 1.0    12/8/2004 10:37:42 AM  JPMugaas
{ Parser for PC-NFS for DOS.
}
unit IdFTPListParsePCNFSD;

interface
uses classes, IdFTPList, IdFTPListParseBase, IdFTPListTypes,IdTStrings;

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
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation
uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, IdSys;

const
  DIR = '<dir>';   {Do not translate}

{ TIdFTPLPPC-NFSD }

class function TIdFTPLPPCNFSD.CheckLine(const AData: String): Boolean;
var s : TIdStrings;
    i : Integer;

var
  LBuf : String;
begin
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(AData,s);
    if s.Count >3 then
    begin
      //last col -time
      i := s.Count - 1;
      LBuf := s[i];
      if CharIsInSet(LBuf,Length(LBuf),['a','p']) then
      begin
        LBuf := Fetch(LBuf,'a');
        LBuf := Fetch(LBuf,'p');
        if IsHHMMSS(LBuf,':') then
        begin
          dec(i);
          //date
          if IsMMDDYY(s[i],'-') then
          begin
            dec(i);
            // size or dir
            if IsNumeric(s[i]) or (s[i]=DIR) then
            begin
              Result := (i=0) or (i=1);
            end;
          end;
        end;
      end;

    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPPCNFSD.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var i : Integer;
begin
  Result := False;
  for i := 0 to AListing.Count -1 do
  begin
    Result := CheckLine(AListing[i]);
    if Result = True then
    begin
      break;
    end;
  end;
end;

class function TIdFTPLPPCNFSD.GetIdent: String;
begin
  Result := 'PC-NFSD';
end;

class function TIdFTPLPPCNFSD.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdPCNFSDFTPListItem.Create(AOwner);
end;

class function TIdFTPLPPCNFSD.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LI : TIdPCNFSDFTPListItem;
  s : TIdStrings;
  i : Integer;

begin
  Result := False;
  LI := AItem as TIdPCNFSDFTPListItem;
  s := TIdStringList.Create;
  try
    IdGlobal.SplitColumns(LI.Data,s);
    if s.Count >3 then
    begin
      LI.FileName := s[0];
      //assume filename 8.3 requirements in MS-DOS
      if Length(s[1])<4 then
      begin
        LI.FFileName := LI.FFileName + '.'+s[1];
        i := 2;
      end
      else
      begin
        i := 1;
      end;
      //<dir> or size
      LI.Size := ExtractNumber(s[i],False);
      if (LI.Size <>-1) or (s[i]=DIR) then
      begin
        if s[i] =DIR then
        begin
          LI.ItemType:=ditDirectory;
          LI.SizeAvail := False;
        end;
        Inc(i);
        //date
        if IsMMDDYY(s[i],'-') then
        begin
          LI.ModifiedDate := DateMMDDYY(s[i]);
          Inc(i);
          //time
          if CharIsInSet(s[i],Length(s[i]),['a','p']) then
          begin
            LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(s[i]);
            Result := True;
          end;
        end;
      end;
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPPCNFSD);
finalization
  UnRegisterFTPListParser(TIdFTPLPPCNFSD);
end.
