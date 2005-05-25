{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16212: IdFTPListParseBullGCOS7.pas
{
{   Rev 1.6    10/26/2004 9:36:28 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.5    4/19/2004 5:05:50 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.4    2004.02.03 5:45:30 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/22/2004 4:39:48 PM  SPerry
{ fixed set problems
}
{
    Rev 1.2    10/19/2003 2:27:04 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    4/7/2003 04:03:28 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.0    2/19/2003 10:13:16 PM  JPMugaas
{ Moved parsers to their own classes.
}
unit IdFTPListParseBullGCOS7;

interface
uses classes, IdFTPList, IdFTPListParseBase, IdObjs;

type
  TIdFTPLPGOS7 = class(TIdFTPLineOwnedList)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation

uses
  IdGlobal, IdFTPCommon, IdFTPListTypes, IdGlobalProtocols, IdStrings, IdSys;

{ TIdFTPLPGOS7 }

class function TIdFTPLPGOS7.CheckListing(AListing: TIdStrings;
  const ASysDescript: String = ''; const ADetails: Boolean = true): boolean;

var LData : String;
  {
  - - -----0 SEPT         SYSADMIN         AUG 26, 1997 SEQ1
  - - -----0 SEPT         SYSADMIN         AUG 26, 1997 SEQ2
  123456789012345678901234567890123456789012345678901234567890
           1         2         3         4         5         6
  }
    function NumericOrSpace(const ALine : String): Boolean;
    var i : Integer;
    begin
      Result := True;
      for i := 1 to Length(ALine) do
      begin
        if (IsNumeric(ALine[i])=False) and (ALine[i]<>' ') then
        begin
          Result := False;
          Break;
        end;
      end;
    end;
begin
  Result := False;
  if AListing.Count >0 then
  begin
    LData := AListing[0];
    Result := (Length(LData)>54) and
      (CharIsInSet(LData, 1, '-d')) and
      (LData[2]=' ') and
      (CharIsInSet(LData, 3, '-dsm')) and
      (LData[4]=' ') and
      (LData[24]=' ') and
      (LData[25]<>' ') and
      (NumericOrSpace(Copy(LData,46,2))) and
      (CharIsInSet(LData, 48, ', ')) and
      (LData[49]=' ') and
      (NumericOrSpace(Copy(LData,50,4))) and
      (LData[54]=' ') and
      (LData[55]<>' ');
  end;
end;

class function TIdFTPLPGOS7.GetIdent: String;
begin
  Result := 'Bull GCOS7'; {do not localize}
end;

class function TIdFTPLPGOS7.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;

{
# From: FTP 7 - File Transfer Protocol
# This was a presentation that was made available in PDF form
# http://www.bull.com/servers/gcos7/ce7/ftp7-en.pdf
# reconstructed from screen-shots displayed in the presentation
}
var LBuf : String;
    LI : TIdOwnerFTPListItem;

  function RemoveComma(const AData : String) : String;
  begin
    Result := Sys.StringReplace(AData,',','');
  end;

begin
  LI := AItem as TIdOwnerFTPListItem;
  if LI.Data[1]='d' then
  begin
    LI.ItemType := ditDirectory;
  end
  else
  begin
    LI.ItemType := ditFile;
  end;
  LI.FileName := Copy(AItem.Data, 55, Length(AItem.Data));
  LBuf := RemoveComma(Copy(AItem.Data, 42, 12));
  if IsWhiteString(LBuf) = False then
  begin
    LI.ModifiedDate := DateStrMonthDDYY(LBuf, ' ');
  end;
  LI.OwnerName := Sys.Trim(Copy(AItem.Data, 25, 17));
  //I don't think size is provided
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPGOS7);
finalization
  UnRegisterFTPListParser(TIdFTPLPGOS7);
end.
