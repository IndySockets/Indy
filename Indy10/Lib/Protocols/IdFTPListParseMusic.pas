{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16205: IdFTPListParseMusic.pas
{
{   Rev 1.5    10/26/2004 9:46:36 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.4    4/19/2004 5:05:48 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.3    2004.02.03 5:45:28 PM  czhower
{ Name changes
}
{
    Rev 1.2    10/19/2003 3:36:02 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    4/7/2003 04:03:56 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.0    2/19/2003 05:51:12 PM  JPMugaas
{ Parsers ported from old framework.
}
unit IdFTPListParseMusic;

interface

uses IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdObjs;

type
  TIdMusicFTPListItem = class(TIdRecFTPListItem)
  protected
    FOwnerName : String;
  public
    property OwnerName : String read FOwnerName write FOwnerName;
    property RecLength;
    property RecFormat;
    property NumberRecs;
  end;
  TIdFTPLPMusic = class(TIdFTPListBaseHeader)
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

{ TIdFTPLPMusic }

class function TIdFTPLPMusic.GetIdent: String;
begin
  Result := 'MUSIC/SP'; {do not localize}
end;

class function TIdFTPLPMusic.IsHeader(const AData: String): Boolean;
var LWords : TIdStrings;
begin
  LWords := TIdStringList.Create;
  try
    SplitColumns(AData,LWords);
    Result := (LWords.Count > 7) and
      ((LWords[0] = 'File') and         {do not localize}
      (LWords[1] = 'name') and          {do not localize}
      (LWords[2] = 'RlenRf') and        {do not localize}
      (LWords[3] = 'Size') and          {do not localize}
      (LWords[4] = 'Read') and          {do not localize}
      (LWords[5] = 'Write') and         {do not localize}
      (LWords[6] = 'By') and            {do not localize}
      ((LWords[7] = 'Attrbs') and       {do not localize}
      (LWords.Count > 8) and
      (LWords[8] = '#Recs')) or         {do not localize}
      (LWords[7] = 'Attrbs#Recs'));     {do not localize}
  finally
    Sys.FreeAndNil(LWords);
  end;
end;

class function TIdFTPLPMusic.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMusicFTPListItem.Create(AOwner);
end;

class function TIdFTPLPMusic.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LBuf : String;
    LTmp : String;
    LDay, LMonth, LYear : Integer;
  LI : TIdMusicFTPListItem;
begin
  LI := AItem as TIdMusicFTPListItem;
  LBuf := AItem.Data;
  //file name
  LI.FileName := Fetch(LBuf);
  if (Copy(AItem.FileName,Length(AItem.FileName),1)='\') then
  begin
    LI.ItemType := ditDirectory;
    LI.FileName := (Copy(AItem.FileName,1,Length(AItem.FileName)-1));
  end;
  //record length and type
  LBuf := Sys.TrimLeft(LBuf);
  LTmp := Fetch(LBuf);
  LI.RecFormat := ExtractRecFormat(StripNo(LTmp));
  LI.RecLength := ExtractNumber(LTmp);
  if LI.RecFormat = 'DIR' then {do not localize}
  begin
    LI.ItemType := ditDirectory;
  end;
  //Size - estimate
  LBuf := Sys.TrimLeft(LBuf);
  LTmp := Fetch(LBuf);
  LI.Size := ExtractNumber(LTmp) * 1024;  //usually, K ends the number
  //Read - not sure so lets skip it
  LBuf := Sys.TrimLeft(LBuf);

  Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //Write date - I think this is last modified
  LTmp := Fetch(LBuf);
  LDay := Sys.StrToInt(Copy(LTmp,1,2),1);
  LMonth := StrToMonth(Copy(LTmp,3,3));
  LYear := Y2Year(Sys.StrToInt(Copy(LTmp,6,Length(LTmp)),0));
  LI.ModifiedDate := Sys.EncodeDate(LYear,LMonth,LDay);
  LBuf := Sys.TrimLeft(LBuf);
  //Write time
  LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS( Fetch(LBuf));
  LBuf := Sys.TrimLeft(LBuf);
  //Owner
  LI.OwnerName := Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //attribs and rec count
  if IndyPos(' ',LBuf)>0 then
  begin
    Fetch(LBuf);
    LBuf := Sys.TrimLeft(LBuf);
  end
  else
  begin
    LI.NumberRecs := Sys.StrToInt(LBuf,0);
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPMusic);
finalization
  RegisterFTPListParser(TIdFTPLPMusic)
end.
