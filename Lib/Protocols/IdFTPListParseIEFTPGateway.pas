unit IdFTPListParseIEFTPGateway;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase,IdFTPListTypes;

{This is based on:

Information Exchange
via TCP/IP FTP Gateway User’s
Guide
Version 1 Release 4

© Copyright GXS, Inc. 1998, 2005. All rights reserved.

and is available at:
https://www.gxsolc.com/public/EDI/us/support/Library/Publications/IEtcpipFTPGatewayUserGuide_c3423452.pdf

}
type

  TIdIEFTPGatewayLsLongListItem = class(TIdFTPListItem)
  protected
    FSenderAcct : String;
    FSenderUserID : String;
    FMClass : String;
  public
    property SenderAcct : String read FSenderAcct write FSenderAcct;
    property SenderUserID : String read FSenderUserID write FSenderUserID;
    property MClass : String read FMClass write FMClass;
  end;
  TIdIEFTPGatewayLsShortListItem = class(TIdMinimalFTPListItem);
  TIdIEFTPGatewayLsFileNameListItem = class(TIdMinimalFTPListItem)
  protected
    FOrigFileName : String;
  public
    property OrigFileName : String read FOrigFileName write FOrigFileName;
  end;
  TIdIEFTPGatewayLSLibraryListItem = class(TIdUnixPermFTPListItem)
  protected
    FAccount : String;
  public
    property Account : String read FAccount write FAccount;
  end;

  TIdFTPLPIEFTPGatewayLSLong = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;
  TIdFTPLPIEFTPGatewayLSShort = class(TIdFTPLPNList)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdFTPLPIEFTPGatewayLSFileName = class(TIdFTPListBase)
  protected
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;
  TIdFTPLPIEFTPGatewayLSLibrary = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseIEFTPGateway"'}
  {$ENDIF}

implementation
uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;


function IsIEFile(const AStr : String): Boolean;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := TextEndsWith(AStr,'._IE');
end;

{ TIdFTPLPIEFTPGatewayLSLong }

class function TIdFTPLPIEFTPGatewayLSLong.GetIdent: String;
begin
   Result := 'IE-FTPListStyleLong';   {Do not localize}
end;

class function TIdFTPLPIEFTPGatewayLSLong.IsHeader(
  const AData: String): Boolean;
var s : TStrings;
begin
//"  Filename (MSGKEY)        Sender      Class   Size       Date   Time"
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count >=6 then begin
      Result := (s[0] = 'Filename') and (s[1]='(MSGKEY)')
            and (s[2]='Sender') and (s[3]='Class')
            and (s[4]='Size') and (s[5]='Date')
            and (s[6]='Time');
    end else begin
      Result := False;
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPIEFTPGatewayLSLong.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdIEFTPGatewayLsLongListItem.Create(AOwner);
end;

class function TIdFTPLPIEFTPGatewayLSLong.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var li : TIdIEFTPGatewayLsLongListItem;
  s : TStrings;
  d, m, y : Word;
  h, mn, sec : Word;
begin
  Result := True;
//"FFAD59A3FB10054AC5F1._IE  ACCT1 USER1  ORDERS  0000006501 960821 092357"
  li := AItem as TIdIEFTPGatewayLsLongListItem;
  li.ItemType := ditFile;
  s := TStringList.Create;
  try
    SplitDelimitedString(li.Data, s, True);
    li.FileName := s[0];
    li.SenderAcct := s[1];
    li.SenderUserID := s[2];
    li.MClass := s[3];
    li.Size := StrToIntDef(s[4],0);
    li.SizeAvail := True;
    y := Y2Year(StrToInt(Copy(s[5],1,2)));
    m := StrToInt(Copy(s[5],3,2));
    d := StrToInt(Copy(s[5],5,2));
    li.ModifiedDate := EncodeDate(y,m,d);

    h := StrToInt(Copy(s[6],1,2));
    mn := StrToInt(Copy(s[6],3,2));
    sec := StrToInt(Copy(s[6],5,2));
    li.ModifiedDate := li.ModifiedDate + EncodeTime(h,mn,sec,0);

    li.ModifiedAvail := True;
  finally
    FreeAndNil(s);
  end;

end;

{ TIdFTPLPIEFTPGatewayLSFileName }

class function TIdFTPLPIEFTPGatewayLSFileName.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var LData : String;
  i : Integer;
begin
  Result := AListing.Count > 0;
  if Result then begin
    for i := 0 to AListing.Count - 1 do begin
      LData := AListing[i];
      Result := IsIEFile(Fetch(LData));
      if Result then begin
        LData := TrimLeft(LData);
        Result := LData <> '';
      end;
      if not Result then begin
        break;
      end;
    end;
  end;
end;

class function TIdFTPLPIEFTPGatewayLSFileName.GetIdent: String;
begin
  Result :=  'IE-FTPListStyleFileName';  {Do not localize}
end;

class function TIdFTPLPIEFTPGatewayLSFileName.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdIEFTPGatewayLsFileNameListItem.Create(AOwner);
end;

class function TIdFTPLPIEFTPGatewayLSFileName.ParseLine(
  const AItem: TIdFTPListItem; const APath: String): Boolean;
var li : TIdIEFTPGatewayLsFileNameListItem;
  LData : String;
begin
  Result := True;
   li := AItem as TIdIEFTPGatewayLsFileNameListItem;
   li.ItemType := ditFile;
   LData := li.Data;
   li.FileName := Fetch(LData);
   LData := TrimLeft(LData);
   li.OrigFileName := UnquotedStr(Fetch(LData));
end;

{ TIdFTPLPIEFTPGatewayLSShort }

class function TIdFTPLPIEFTPGatewayLSShort.CheckListing(AListing : TStrings;
  const ASysDescript : String =''; const ADetails : Boolean = True): boolean;
var
  i : Integer;
begin
  Result := False;
   for I := 0 to AListing.Count - 1 do begin
     Result := IsIEFile(AListing[i]);
     if not Result then begin
       break;
     end;
   end;
end;

class function TIdFTPLPIEFTPGatewayLSShort.GetIdent: String;
begin
  Result :=  'IE-FTPListStyleShort';  {Do not localize}
end;

class function TIdFTPLPIEFTPGatewayLSShort.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
   Result := TIdIEFTPGatewayLsShortListItem.Create(AOwner);
end;

{ TIdFTPLPIEFTPGatewayLSLibrary }

class function TIdFTPLPIEFTPGatewayLSLibrary.GetIdent: String;
begin
  Result := 'IE-FTPListStyleLibrary';  {Do not localize}
end;

class function TIdFTPLPIEFTPGatewayLSLibrary.IsHeader(
  const AData: String): Boolean;
var s : TStrings;
begin
//"Access    Owner    Account Size  Last updated         Name"
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count >=6 then begin
      Result := (s[0] = 'Access') and (s[1]='Owner')
            and (s[2]='Account') and (s[3]='Size')
            and (s[4]='Last') and (s[5]='updated')
            and (s[6]='Name');
    end else begin
      Result := False;
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPIEFTPGatewayLSLibrary.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdIEFTPGatewayLSLibraryListItem.Create(AOwner);
end;

class function TIdFTPLPIEFTPGatewayLSLibrary.ParseLine(
  const AItem: TIdFTPListItem; const APath: String): Boolean;
var LI : TIdIEFTPGatewayLSLibraryListItem;
  LData : String;
begin
  Result := True;
  LI := AItem as TIdIEFTPGatewayLSLibraryListItem;
  LData := LI.Data;
  LI.ItemType := ditFile;
  LI.FUnixOwnerPermissions := Copy(LI.Data,2,3);
  LI.FUnixGroupPermissions := Copy(LI.Data,5,3);
  LI.FUnixOtherPermissions := Copy(LI.Data,8,3);
  IdDelete(LData,1,10);
  LI.OwnerName := Fetch(LData);
  LData := TrimLeft(LData);
  LI.Account := Fetch(LData);
  LData := TrimLeft(LData);
  LI.Size := StrToIntDef(Fetch(LData),0);
  LData := TrimLeft(LData);
  LI.ModifiedDate := DateYYMMDD(Fetch(LData));
  LData := TrimLeft(LData);
  LI.ModifiedDate := TimeHHMMSS(Fetch(LData));
  IdDelete(LData,1,1);
  LI.FileName := LData;
end;

initialization
  RegisterFTPListParser(TIdFTPLPIEFTPGatewayLSLong);
  RegisterFTPListParser(TIdFTPLPIEFTPGatewayLSShort);
  RegisterFTPListParser(TIdFTPLPIEFTPGatewayLSFileName);
  RegisterFTPListParser(TIdFTPLPIEFTPGatewayLSLibrary);
finalization
  UnRegisterFTPListParser(TIdFTPLPIEFTPGatewayLSLong);
  UnRegisterFTPListParser(TIdFTPLPIEFTPGatewayLSShort);
  UnRegisterFTPListParser(TIdFTPLPIEFTPGatewayLSFileName);
  UnRegisterFTPListParser(TIdFTPLPIEFTPGatewayLSLibrary);
end.
