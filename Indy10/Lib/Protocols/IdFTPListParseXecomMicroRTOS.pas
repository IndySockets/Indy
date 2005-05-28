{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  16195: IdFTPListParseXecomMicroRTOS.pas
{
{   Rev 1.5    10/26/2004 10:03:24 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.4    4/19/2004 5:05:40 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.3    2004.02.03 5:45:26 PM  czhower
{ Name changes
}
{
    Rev 1.2    10/19/2003 3:48:22 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    4/7/2003 04:04:42 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.0    2/19/2003 05:49:46 PM  JPMugaas
{ Parsers ported from old framework.
}
unit IdFTPListParseXecomMicroRTOS;

interface

uses
  IdFTPList, IdFTPListParseBase, IdObjs;

type
   TIdXecomMicroRTOSTPListItem = class(TIdFTPListItem)
   protected
     FMemStart: Cardinal;
     FMemEnd: Cardinal;
   public
     constructor Create(AOwner: TIdCollection); override;
     property MemStart: Cardinal read FMemStart write FMemStart;
     property MemEnd: Cardinal read FMemEnd write FMemEnd;
   end;
  TIdFTPLPXecomMicroRTOS = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings,
  IdSys;

{ TIdFTPLPXecomMicroRTOS }

class function TIdFTPLPXecomMicroRTOS.GetIdent: String;
begin
  Result := 'Xercom Micro RTOS';  {do not localize}
end;

class function TIdFTPLPXecomMicroRTOS.IsFooter(
  const AData: String): Boolean;
var s : TIdStrings;
begin
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(AData,s);
    if s.Count = 7 then
    begin
      Result := (s[0] = '**') and (s[1] = 'Total') and IsNumeric(s[2]) and  {do not localize}
      (s[3] = 'files,') and IsNumeric(s[4]) and (s[5] = 'bytes') and        {do not localize}
      (s[6] = '**');                                                        {do not localize}
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPXecomMicroRTOS.IsHeader(
  const AData: String): Boolean;
var s : TIdStrings;
begin
  Result := False;
  s := TIdStringList.Create;
  try
    SplitColumns(AData,s);
    if s.Count = 5 then
    begin
      Result := (s[0] = 'Start') and (s[1] = 'End') and (s[2] = 'length') and {do not localize}
         (s[3] = 'File') and (s[4] = 'name');                                 {do not localize}
    end;
  finally
    Sys.FreeAndNil(s);
  end;
end;

class function TIdFTPLPXecomMicroRTOS.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdXecomMicroRTOSTPListItem.Create(AOwner);
end;

class function TIdFTPLPXecomMicroRTOS.ParseLine(
  const AItem: TIdFTPListItem; const APath: String): Boolean;
var LBuf : String;
  LI : TIdXecomMicroRTOSTPListItem;
begin
  LI := AItem as TIdXecomMicroRTOSTPListItem;
  LBuf := Sys.TrimLeft(AItem.Data);
  //start memory offset
  LBuf := Sys.TrimLeft(LBuf);
  LI.MemStart := Sys.StrToInt('$'+Fetch(LBuf),0);
  //end memory offset
  LBuf := Sys.TrimLeft(LBuf);
  LI.MemEnd := Sys.StrToInt('$'+Fetch(LBuf),0);
  //file size
  LBuf := Sys.TrimLeft(LBuf);
  LI.Size := Sys.StrToInt64(Fetch(LBuf),0);
  //File name
  LI.FileName := Sys.TrimLeft(LBuf);
  //note that the date is not provided and I do not think there are
  //dirs in this real-time operating system.
  Result := True;
end;

{ TIdXecomMicroRTOSTPListItem }

constructor TIdXecomMicroRTOSTPListItem.Create(AOwner: TIdCollection);
begin
  inherited;
  ModifiedAvail := False;
end;

initialization
  RegisterFTPListParser(TIdFTPLPXecomMicroRTOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPXecomMicroRTOS);
end.
