unit IdFTPListParsePCTCP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdPCTCPFTPListItem = class(TIdFTPListItem);

  TIdFTPLPPCTCPNet = class(TIdFTPListBase)
  protected
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
    {$HPPEMIT '#pragma link "IdFTPListParseWinQVTNET"'}
  {$ENDIF}

{
THis is a parser for "PC/TCP v 2.11 ftpsrv.exe".  This was a part of the PC/TCP
suite from FTP Software Inc.

based on

http://www.farmanager.com/viewvc/plugins/ftp/trunk/lib/DirList/pr_pctcp.cpp?revision=275&view=markup&pathrev=788

Note that no source-code was used, just the listing data.

 PC/TCP ftpsrv.exe
 looks like
          1         2         3         4         5         6
0123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------
         1         2         3         4         5         6
123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------
     40774              IO.SYS   Tue May 31 06:22:00 1994
     38138           MSDOS.SYS   Tue May 31 06:22:00 1994
     54645         COMMAND.COM   Tue May 31 06:22:00 1994
<dir>                     UTIL   Thu Feb 20 09:55:02 2003
}
implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{ TIdFTPLPPCTCPNet }

class function TIdFTPLPPCTCPNet.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LData : String;
begin
  Result := False;

  if AListing.Count > 0 then begin
    LData := AListing[0];
    //size or dir
    Result := (LData ='<dir>') or IsNumeric(Trim(Copy(LData,1,10)));
    //file name
    if Result then begin
      Result := Trim(Copy(LData,11,19))<> '';
    end;
    //day of week
    if Result then begin
      Result :=  StrToDay(Trim(Copy(LData,31,7))) > 0;
    end;
    //month
    if Result then begin
      Result := StrToMonth(Copy(LData,38,3)) > 0;
    end;
    //day
     if Result then begin
       Result := StrToIntDef(Copy(LData,42,2),0) > 0;
     end;
    //time
     if Result then begin
       Result := IsHHMMSS(Copy(LData,45,8),':');
     end;
    //year
    if Result then begin
       Result := IsNumeric(Trim(Copy(LData,54,4)));
    end;
  end;
end;

class function TIdFTPLPPCTCPNet.GetIdent: String;
begin
  Result := 'PC/TCP ftpsrv.exe';
end;

class function TIdFTPLPPCTCPNet.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdPCTCPFTPListItem.Create(AOwner);
end;

class function TIdFTPLPPCTCPNet.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LData : String;
  LPt : String;
  LMonth : Word;
  LDay : Word;
  LYear : Word;
begin
  Result := False;
  LData := TrimLeft(AItem.Data);
  LPt := Fetch(LData);
  //dir or file size
  if LPt = '<dir>' then begin
    AItem.ItemType := ditDirectory;
    AItem.SizeAvail := False;
  end else begin
    if IsNumeric(LPt) then begin
      AItem.Size := StrToIntDef(LPt,0);
      AItem.SizeAvail := True;
    end else begin
      exit;
    end;
  end;
  //file name
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  if LPt = '' then begin
    Exit;
  end else begin
    AItem.FileName := LPt;
  end;
  //Day of week
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  if StrToDay(LPt) < 1 then begin
    exit;
  end;
  //month
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  LMOnth := StrToMonth(LPt);
  if LMonth < 1 then begin
    exit;
  end;
  //day
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  LDay := StrToIntDef(LPt,0);
  if LDay = 0 then begin
    exit;
  end;

  //time
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  if not IsHHMMSS(LPt,':') then begin
    exit;
  end;
  AItem.ModifiedDate := TimeHHMMSS(LPt);
  //year
  LData := TrimLeft(LData);
  LPt := Fetch(LData);
  LYear := StrToIntDef(LPt,$FFFF);
  if LYear = $FFFF then begin
    Exit;
  end;
  LYear := Y2Year(LYear);
  AItem.ModifiedDate := AItem.ModifiedDate +  EncodeDate(LYear,LMonth,LDay);
  AItem.ModifiedAvail := True;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPPCTCPNet);
finalization
  UnRegisterFTPListParser(TIdFTPLPPCTCPNet);
end.
