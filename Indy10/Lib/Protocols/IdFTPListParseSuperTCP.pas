{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  112278: IdFTPListParseSuperTCP.pas 
{
{   Rev 1.1    11/29/2004 11:26:00 PM  JPMugaas
{ This should now support SuperTCP 7.1 running under Windows 2000.  That does
{ support long filenames by the dir entry ending with one space followed by the
{ long-file name.
{ ShortFileName was added to the listitem class for completeness.
}
{
{   Rev 1.0    11/29/2004 2:44:16 AM  JPMugaas
{ New FTP list parsers for some legacy FTP servers.
}
unit IdFTPListParseSuperTCP;

interface
uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdTStrings;

type
  TIdSuperTCPFTPListItem = class(TIdFTPListItem)
  protected
    FShortFileName : String;
  public
    property ShortFileName : String read FShortFileName write FShortFileName;
  end;
  TIdFTPLPSuperTCP = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation
uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{ TIdFTPLPSuperTCP }

class function TIdFTPLPSuperTCP.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
{
Maybe like this:

CMT             <DIR>           11-21-94        10:17
DESIGN1.DOC          11264      05-11-95        14:20

or this:

CMT             <DIR>           11/21/94        10:17
DESIGN1.DOC          11264      05/11/95        14:20

or this with SuperTCP 7.1 running under Windows 2000:

.            <DIR>     11-29-2004  22:04 .
..           <DIR>     11-29-2004  22:04 ..
wrar341.exe  1164112   11-22-2004  15:34 wrar341.exe
test         <DIR>     11-29-2004  22:14 test
TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
TEST~1       <DIR>     11-29-2004  22:52  Test
}
var i : Integer;
  LBuf, LBuf2 : String;
begin
  Result := False;
  for i := 0 to AListing.Count -1 do
  begin
    LBuf := AListing[i];
    //filename and extension - we assume an 8.3 filename type because
    //Windows 3.1 only supports that.
    Fetch(LBuf);
    LBuf := TrimLeft(LBuf);
    //<DIR> or file size
    LBuf2 := Fetch(LBuf);
    Result := (LBuf2='<DIR>') or IsNumeric(LBuf2);   {Do not localize}
    if not result then
    begin
      Exit;
    end;
    //date
    LBuf := TrimLeft(LBuf);
    LBuf2 := Fetch(LBuf);
    Result := IsMMDDYY(LBuf2,'/') or IsMMDDYY(LBuf2,'-');
    if Result then
    begin
      //time
      LBuf := TrimLeft(LBuf);
      LBuf2 := Fetch(LBuf);
      Result := IsHHMMSS(LBuf2,':');
    end;
    if not result then
    begin
      break;
    end;
  end;
end;

class function TIdFTPLPSuperTCP.GetIdent: String;
begin
   Result := 'SuperTCP';
end;

class function TIdFTPLPSuperTCP.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSuperTCPFTPListItem.Create(AOwner);
end;

class function TIdFTPLPSuperTCP.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;

var LI : TIdSuperTCPFTPListItem;

  LBuf, LBuf2 : String;

{
with SuperTCP 7.1 running under Windows 2000:

.            <DIR>     11-29-2004  22:04 .
..           <DIR>     11-29-2004  22:04 ..
wrar341.exe  1164112   11-22-2004  15:34 wrar341.exe
test         <DIR>     11-29-2004  22:14 test
TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
TEST~1       <DIR>     11-29-2004  22:52  Test
}
begin
  LI := AItem as TIdSuperTCPFTPListItem;
  LBuf := AItem.Data;
  //short filename and extension - we assume an 8.3 filename
  //type because Windows 3.1 only supports that and under Win32,
  //a short-filename is returned here.  That's with my testing.
  LBuf2 :=  Fetch(LBuf);
  LI.FileName := LBuf2;
  LI.ShortFileName := LBuf2;
  LBuf := TrimLeft(LBuf);
  //<DIR> or file size
  LBuf2 := Fetch(LBuf);
  if LBuf2 = '<DIR>' then   {Do not localize}
  begin
    LI.ItemType := ditDirectory;
    LI.SizeAvail := False;
  end
  else
  begin
    LI.ItemType := ditFile;
    Result :=  IsNumeric(LBuf2);
    if not result then
    begin
      Exit;
    end;
    LI.Size := StrToIntDef(LBuf2,0);
  end;
  //date
  LBuf := TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  if IsMMDDYY(LBuf2,'/') or IsMMDDYY(LBuf2,'-') then
  begin
    LI.ModifiedDate := DateMMDDYY(LBuf2);
  end
  else
  begin
    Result := False;
    Exit;
  end;
  //time
  LBuf := TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  Result := IsHHMMSS(LBuf2,':');
  if Result then
  begin
    LI.ModifiedDate := LI.ModifiedDate + IdFTPCommon.TimeHHMMSS(LBuf2);
  end;
  // long filename
  //We do not use TrimLeft here because a space can start a filename in Windows
  //2000  and the entry would be like this:
  //
  //TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
  //TEST~1       <DIR>     11-29-2004  22:52  Test
  //
  if LBuf<>'' then
  begin
    LI.FileName := LBuf;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPSuperTCP);
finalization
  UnRegisterFTPListParser(TIdFTPLPSuperTCP);
end.
