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
{   Rev 1.6    2004.10.27 9:17:46 AM  czhower
{ For TIdStrings
}
{
{   Rev 1.5    10/26/2004 11:08:08 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.4    13.04.2004 12:56:44  ARybin
{ M$ IE behavior 
}
{
{   Rev 1.3    2004.02.03 5:45:00 PM  czhower
{ Name changes
}
{
{   Rev 1.2    2004.01.22 6:09:02 PM  czhower
{ IdCriticalSection
}
{
{   Rev 1.1    1/22/2004 7:09:58 AM  JPMugaas
{ Tried to fix AnsiSameText depreciation.
}
{
{   Rev 1.0    11/14/2002 02:16:20 PM  JPMugaas
}
unit IdCookie;

{
  Implementation of the HTTP State Management Mechanism as specified in RFC 2109, 2965.

  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Indy Team.

Details of implementation
-------------------------
Mar-31-2001 Doychin Bondzhev
 - Chages in the class heirarchy to implement Netscape specification[Netscape], RFC 2109[RFC2109] & 2965[RFC2965]
    TIdNetscapeCookie - The base code used in all cookies. It implments cookies as proposed by Netscape
    TIdCookieRFC2109 - The RFC 2109 implmentation. Not used too much.
    TIdCookieRFC2965 - The RFC 2965 implmentation. Not used yet or at least I don't know any HTTP server that supports   
      this specification.
    TIdServerCooke - Used in the HTTP server compoenent.

Feb-2001 Doychin Bondzhev
 - Initial release

REFERENCES
-------------------
 [Netscape] "Persistent Client State -- HTTP Cookies", available at
            <http://www.netscape.com/newsref/std/cookie_spec.html>,
            undated.

 [RFC2109]  Kristol, D. and L. Montulli, "HTTP State Management
            Mechanism", RFC 2109, February 1997.

 [RFC2965]  Kristol, D. and L. Montulli, "HTTP State Management
            Mechanism", RFC 2965, October 2000.


Implementation status
--------------------------

 [Netscape] - 100%
 [RFC2109]  - 100% (there is still some code to write and debugging)
 [RFC2965]  -  70% (client and server cookie generation is not ready)

}

// TODO: Make this unit to implement compleatly [Netscape], [RFC2109] & [RFC2965]

interface

uses
  IdGlobal, IdException, IdGlobalProtocols, IdObjs, IdSys;
  //must keep for now

Const
  GFMaxAge = -1;

Type
  TIdCookieVersion = (cvNetscape, cvRFC2109, cvRFC2965);

  TIdNetscapeCookie = class;

  TIdCookieList = class(TIdStringList)
  protected
    function GetCookie(Index: Integer): TIdNetscapeCookie;
  public
    property Cookies[Index: Integer]: TIdNetscapeCookie read GetCookie;
  end;

  {
    Base Cookie class as described in
    "Persistent Client State -- HTTP Cookies"
  }
  TIdNetscapeCookie = class(TIdCollectionItem)
  protected
    FCookieText: String;
    FDomain: String;
    FExpires: String;
    FName: String;
    FPath: String;
    FSecure: Boolean;
    FValue: String;

    FInternalVersion: TIdCookieVersion;

    function GetCookie: String; virtual;
    procedure SetExpires(AValue: String); virtual;
    procedure SetCookie(AValue: String);

    function GetServerCookie: String; virtual;
    function GetClientCookie: String; virtual;

    procedure LoadProperties(APropertyList: TIdStringList); virtual;
  public
    constructor Create(ACollection: TIdCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TIdPersistent); override;

    function IsValidCookie(AServerHost: String): Boolean; virtual;

    property CookieText: String read GetCookie write SetCookie;
    property ServerCookie: String read GetServerCookie;
    property ClientCookie: String read GetClientCookie;
    property Domain: String read FDomain write FDomain;
    property Expires: String read FExpires write SetExpires;
    property CookieName: String read FName write FName;
    property Path: String read FPath write FPath;
    property Secure: Boolean read FSecure write FSecure;
    property Value: String read FValue write FValue;
  end;

  { Cookie as described in [RFC2109] }
  // Adds Version, Secure and MaxAge
  TIdCookieRFC2109 = class(TIdNetscapeCookie)
  protected
    FMax_Age: Int64;
    FVersion: String;
    FComment: String;

    function GetClientCookie: String; override;
    function GetCookie: String; override;
    procedure SetExpires(AValue: String); override;
    procedure LoadProperties(APropertyList: TIdStringList); override;
  public
    constructor Create(ACollection: TIdCollection); override;

    property Comment: String read FComment write FComment;
    property MaxAge: Int64 read FMax_Age write FMax_Age;
    property Version: String read FVersion write FVersion;
  end;

  { Cookie as described in [RFC2965] }
  // Adds CommentURL, Discard, Port and Version is now requerd
  TIdCookieRFC2965 = class(TIdCookieRFC2109)
  protected
    FCommentURL: String;
    FDiscard: Boolean;
    FPortList: array of Integer;

    function GetCookie: String; override;
    procedure LoadProperties(APropertyList: TIdStringList); override;
    procedure SetPort(AIndex, AValue: Integer);
    function GetPort(AIndex: Integer): Integer;
  public
    constructor Create(ACollection: TIdCollection); override;

    property CommentURL: String read FCommentURL write FCommentURL;
    property Discard: Boolean read FDiscard write FDiscard;
    property PortList[AIndex: Integer]: Integer read GetPort write SetPort;
  end;

  { Used in the HTTP server }
  // This class descends from TIdCookieRFC2109 but uses Expires and not Max-Age which is not
  // supported from new browsers
  TIdServerCookie = class(TIdCookieRFC2109)
  protected
    function GetCookie: String; override;
  public
    constructor Create(ACollection: TIdCollection); override;
    procedure AddAttribute(const Attribute, Value: String);
  end;

  { The Cookie collection }

  TIdCookieAccess = (caRead, caReadWrite);

  TIdCookies = class(TIdOwnedCollection)
  protected
    FCookieListByDomain: TIdCookieList;
    FRWLock: TIdMultiReadExclusiveWriteSynchronizer;

    function GetCookie(const AName, ADomain: string): TIdCookieRFC2109;
    function GetItem(Index: Integer): TIdCookieRFC2109;
    procedure SetItem(Index: Integer; const Value: TIdCookieRFC2109);
  public
    constructor Create(AOwner: TIdPersistent);
    destructor Destroy; override;
    function Add: TIdCookieRFC2109;
    function Add2: TIdCookieRFC2965;
    procedure AddCookie(ACookie: TIdCookieRFC2109);
    procedure AddSrcCookie(const sCookie: string);
    procedure Delete(Index: Integer);
    function GetCookieIndex(FirstIndex: integer; const AName: string): Integer; overload;
    function GetCookieIndex(FirstIndex: integer; const AName, ADomain: string): Integer; overload;

    function LockCookieListByDomain(AAccessType: TIdCookieAccess): TIdCookieList;
    procedure UnlockCookieListByDomain(AAccessType: TIdCookieAccess);

    // property CookieListByDomain: TIdCookieList read FCookieListByDomain;
    property Cookie[const AName, ADomain: string]: TIdCookieRFC2109 read GetCookie;
    property Items[Index: Integer]: TIdCookieRFC2109 read GetItem write SetItem; Default;
  end;

  TIdServerCookies = class(TIdCookies)
  protected
    function GetCookie(const AName: string): TIdCookieRFC2109;
  public
    function Add: TIdServerCookie;

    property Cookie[const AName: string]: TIdCookieRFC2109 read GetCookie;
  end;

implementation

uses
  IdAssignedNumbers;
  
{ base functions used for construction of Cookie text }

function AddCookieProperty(AProperty, AValue, ACookie: String): String;
begin
  if Length(AValue) > 0 then
  begin
    if Length(ACookie) > 0 then
    begin
      ACookie := ACookie + '; ';    {Do not Localize}
    end;
    ACookie := ACookie + AProperty + '=' + AValue;    {Do not Localize}
  end;

  result := ACookie;
end;

function AddCookieFlag(AFlag, ACookie: String): String;
begin
  if Length(ACookie) > 0 then
  begin
    ACookie := ACookie + '; ';    {Do not Localize}
  end;
  ACookie := ACookie + AFlag;
  result := ACookie;
end;

{ TIdCookieList }

function TIdCookieList.GetCookie(Index: Integer): TIdNetscapeCookie;
begin
  result := TIdNetscapeCookie(Objects[Index]);
end;

{ TIdNetscapeCookie }

constructor TIdNetscapeCookie.Create(ACollection: TIdCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvNetscape;
end;

destructor TIdNetscapeCookie.Destroy;
Var
  LListByDomain: TIdCookieList;
  LCookieStringList: TIdStringList;
  i: Integer;
begin
  if Assigned(Collection) then try
    LListByDomain := TIdCookies(Collection).LockCookieListByDomain(caReadWrite);
    if Assigned(LListByDomain) then try
      i := LListByDomain.IndexOf(Domain);
      if i > -1 then
      begin
        LCookieStringList := TIdStringList(LListByDomain.Objects[i]);
        i := LCookieStringList.IndexOf(CookieName);
        if i > -1 then
        begin
          LCookieStringList.Delete(i);
        end;
      end;
    finally
      TIdCookies(Collection).UnlockCookieListByDomain(caReadWrite);
    end;
  finally
    inherited Destroy;
  end;
end;

procedure TIdNetscapeCookie.Assign(Source: TIdPersistent);
begin
  if (Source <> nil) and (Source is TIdCookieRFC2109) then
  begin
    CookieText := TIdCookieRFC2109(Source).CookieText;
    FInternalVersion := TIdCookieRFC2109(Source).FInternalVersion;
  end;
end;

function TIdNetscapeCookie.IsValidCookie(AServerHost: String): Boolean;
begin
  if IsValidIP(AServerHost) then // true if Server host is IP and Domain is eq to ServerHost
  begin
    result := AServerHost = FDomain;
  end else begin
    if IsHostname(AServerHost) then begin
      //MSIE: if FDomain looks like "xxxx.yyyy.com", then AServerHost "zzzz.xxxx.yyyy.com" is valid
      //also must allow 4.3.2.1=valid for domain=.2.1
      Result := FDomain = RightStr(AServerHost, Length(FDomain));
    end
    else begin
      result := Sys.SameText(FDomain, DomainName(AServerHost));
      // result := IndyPos(FDomain, AServerHost) > 0;
    end;
  end;
end;

procedure TIdNetscapeCookie.SetExpires(AValue: String);
begin
  FExpires := AValue;
end;

{
Set-Cookie: NAME=VALUE; expires=DATE;
path=PATH; domain=DOMAIN_NAME; secure
}
function TIdNetscapeCookie.GetServerCookie: String;
begin
  result := GetCookie;
end;

{
Cookie: NAME1=OPAQUE_STRING1; NAME2=OPAQUE_STRING2 ...
}
function TIdNetscapeCookie.GetClientCookie: String;
begin
  result := FName + '=' + FValue;    {Do not Localize}
end;

function TIdNetscapeCookie.GetCookie: String;
begin
  result := AddCookieProperty(FName, FValue, '');    {Do not Localize}
  result := AddCookieProperty('path', FPath, result);    {Do not Localize}
  if FInternalVersion = cvNetscape then
  begin
    result := AddCookieProperty('expires', FExpires, result);    {Do not Localize}
  end;

  result := AddCookieProperty('domain', FDomain, result);    {Do not Localize}

  if FSecure then
  begin
    result := AddCookieFlag('secure', result);    {Do not Localize}
  end;
end;

procedure TIdNetscapeCookie.LoadProperties(APropertyList: TIdStringList);
begin
  FPath := APropertyList.values['PATH'];    {Do not Localize}
  // Tomcat can return SetCookie2 with path wrapped in "
  if (Length(FPath) > 0) then
  begin
    if FPath[1] = '"' then    {Do not Localize}
      Delete(FPath, 1, 1);
    if FPath[Length(FPath)] = '"' then    {Do not Localize}
      SetLength(FPath, Length(FPath) - 1);
  end
  else begin
    FPath := '/'; {Do not Localize}
  end;
  Expires := APropertyList.values['EXPIRES'];    {Do not Localize}
  FDomain := APropertyList.values['DOMAIN'];    {Do not Localize}
  FSecure := APropertyList.IndexOf('SECURE') <> -1;    {Do not Localize}
end;

procedure TIdNetscapeCookie.SetCookie(AValue: String);
Var
  i: Integer;
  CookieProp: TIdStringList;
begin
  if AValue <> FCookieText then
  begin
    FCookieText := AValue;

    CookieProp := TIdStringList.Create;

    try
      while Pos(';', AValue) > 0 do    {Do not Localize}
      begin
        CookieProp.Add(Sys.Trim(Fetch(AValue, ';')));    {Do not Localize}
        if (Pos(';', AValue) = 0) and (Length(AValue) > 0) then CookieProp.Add(Sys.Trim(AValue));    {Do not Localize}
      end;

      if CookieProp.Count = 0 then CookieProp.Text := AValue;

      FName := CookieProp.Names[0];
      FValue := CookieProp.Values[CookieProp.Names[0]];
      CookieProp.Delete(0);

      for i := 0 to CookieProp.Count - 1 do
        if Pos('=', CookieProp[i]) = 0 then    {Do not Localize}
        begin
          CookieProp[i] := Sys.UpperCase(CookieProp[i]);  // This is for cookie flags (secure)
        end
        else begin
          CookieProp[i] := Sys.UpperCase(CookieProp.Names[i]) + '=' + CookieProp.values[CookieProp.Names[i]];    {Do not Localize}
        end;

      LoadProperties(CookieProp);
    finally
      Sys.FreeAndNil(CookieProp);
    end;
  end;
end;

{ TIdCookieRFC2109 }

constructor TIdCookieRFC2109.Create(ACollection: TIdCollection);
begin
  inherited Create(ACollection);
  FMax_Age := GFMaxAge;
  FInternalVersion := cvRFC2109;
end;

procedure TIdCookieRFC2109.SetExpires(AValue: String);
begin
  if Length(AValue) > 0 then
  begin
    try
      // If you see an exception here then that means the HTTP server has returned an invalid expires
      // date/time value. The correct format is Wdy, DD-Mon-YY HH:MM:SS GMT

      // AValue := StringReplace(AValue, '-', ' ', [rfReplaceAll]);    {Do not Localize}
      FMax_Age := Trunc((GMTToLocalDateTime(AValue) - Sys.Now) * MSecsPerDay / 1000);
    except end;
  end;
  inherited SetExpires(AValue);
end;

{
   cookie          =       "Cookie:" cookie-version
                           1*((";" | ",") cookie-value)
   cookie-value    =       NAME "=" VALUE [";" path] [";" domain]
   cookie-version  =       "$Version" "=" value
   NAME            =       attr
   VALUE           =       value
   path            =       "$Path" "=" value
   domain          =       "$Domain" "=" value
}

function TIdCookieRFC2109.GetClientCookie: String;
begin
  result := inherited GetClientCookie; 

  {if (Length(Version) > 0) and (Length(result) > 0) then
  begin
    result := AddCookieProperty('$Version', '"' + Version + '"', '') + ';' + result;
  end;

  result := AddCookieProperty('$Path', Path, result);
  if IsDomain(Domain) then
  begin
    result := AddCookieProperty('$Domain', Domain, result);    
  end;}
end;

{
   set-cookie      =       "Set-Cookie:" cookies
   cookies         =       1#cookie
   cookie          =       NAME "=" VALUE *(";" cookie-av)
   NAME            =       attr
   VALUE           =       value
   cookie-av       =       "Comment" "=" value
                   |       "Domain" "=" value
                   |       "Max-Age" "=" value
                   |       "Path" "=" value
                   |       "Secure"
                   |       "Version" "=" 1*DIGIT
}
function TIdCookieRFC2109.GetCookie: String;
begin
  result := inherited GetCookie;

   if (FMax_Age > -1) and (Length(FExpires) = 0) then
   begin
    result := AddCookieProperty('max-age', Sys.IntToStr(FMax_Age), result);    {Do not Localize}
  end;

  result := AddCookieProperty('comment', FComment, result);    {Do not Localize}
  result := AddCookieProperty('version', FVersion, result);    {Do not Localize}
end;

procedure TIdCookieRFC2109.LoadProperties(APropertyList: TIdStringList);
begin
  inherited LoadProperties(APropertyList);

  FMax_Age := Sys.StrToInt(APropertyList.values['MAX-AGE'], -1);    {Do not Localize}
  FVersion := APropertyList.values['VERSION'];    {Do not Localize}
  FComment := APropertyList.values['COMMENT'];    {Do not Localize}

  if Length(Expires) = 0 then begin
    FInternalVersion := cvNetscape;
    if FMax_Age >= 0 then begin
      Expires := DateTimeGMTToHttpStr(Sys.Now - OffsetFromUTC + FMax_Age * 1000 / MSecsPerDay);
    end;
    // else   Free this cookie
  end;
end;

{ TIdCookieRFC2965 }

constructor TIdCookieRFC2965.Create(ACollection: TIdCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvRFC2965;
end;

function TIdCookieRFC2965.GetCookie: String;
begin
  result := inherited GetCookie;
end;

procedure TIdCookieRFC2965.LoadProperties(APropertyList: TIdStringList);
Var
  PortListAsString: TIdStringList;
  i: Integer;
  S: String;
begin
  inherited LoadProperties(APropertyList);

  FCommentURL := APropertyList.values['CommentURL'];    {Do not Localize}
  FDiscard := APropertyList.IndexOf('DISCARD') <> -1;    {Do not Localize}
  PortListAsString := TIdStringList.Create;

  try
    S := APropertyList.Values['Port'];    {Do not Localize}
    if Length(S) > 0 then
    begin
      if (S[1] = '"') and (S[Length(S)] = '"') then    {Do not Localize}
      begin
        PortListAsString.CommaText := Copy(S, 2, Length(S) - 2);
        if PortListAsString.Count = 0 then
        begin
          PortList[0] := IdPORT_HTTP;
        end
        else begin
          for i := 0 to PortListAsString.Count - 1 do
          begin
            PortList[i] := Sys.StrToInt(PortListAsString[i]);
          end;
        end;
      end;
    end
    else begin
      PortList[0] := IdPORT_HTTP;
    end;
  finally
    PortListAsString.Free;
  end;
end;

procedure TIdCookieRFC2965.SetPort(AIndex, AValue: Integer);
begin
  if (AIndex - High(FPortList) > 1) or (AIndex < 0) then
  begin
    raise EIdException.Create('Index out of range.');    {Do not Localize}
  end;
  if AIndex - High(FPortList) = 1 then
  begin
    SetLength(FPortList, AIndex + 1);
  end;
  FPortList[AIndex] := AValue;
end;

function TIdCookieRFC2965.GetPort(AIndex: Integer): Integer;
begin
  if (AIndex > High(FPortList)) or (AIndex < Low(FPortList)) then
  begin
    raise EIdException.Create('Index out of range.');    {Do not Localize}
  end;

  result := FPortList[AIndex];
end;

{ TIdServerCookie }

constructor TIdServerCookie.Create(ACollection: TIdCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvNetscape;
  // Version := '1';    {Do not Localize}
end;

function TIdServerCookie.GetCookie: String;
// Wdy, DD-Mon-YY HH:MM:SS GMT
const
  wdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'); {do not localize}
  monthnames: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',  {do not localize}
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); {do not localize}
var
  wDay,
  wMonth,
  wYear: Word;
  ANow: TIdDateTime;
begin
  if FMax_Age > -1 then
  begin
    ANow := Sys.Now + TimeZoneBias + FMax_Age / MSecsPerDay * 1000;
    Sys.DecodeDate(ANow, wYear, wMonth, wDay);
    FExpires := Sys.Format('%s, %d-%s-%d %s GMT',    {do not localize}
                   [wdays[Sys.DayOfWeek(ANow)], wDay, monthnames[wMonth],
                    wYear, Sys.FormatDateTime('HH":"NN":"SS', ANow)]); {do not localize}
  end;

  result := inherited GetCookie;
end;

procedure TIdServerCookie.AddAttribute(const Attribute, Value: String);
begin
  if Sys.UpperCase(Attribute) = '$PATH' then    {Do not Localize}
  begin
    Path := Value;
  end;
  if Sys.UpperCase(Attribute) = '$DOMAIN' then    {Do not Localize}
  begin
    Domain := Value;
  end;
end;

{ TIdCookies }

constructor TIdCookies.Create(AOwner: TIdPersistent);
begin
  inherited Create(AOwner, TIdCookieRFC2109);

  FRWLock := TIdMultiReadExclusiveWriteSynchronizer.Create;
  FCookieListByDomain := TIdCookieList.Create;
end;

destructor TIdCookies.Destroy;
var i : Integer;
begin
  // This will force the Cookie removing process before we free the FCookieListByDomain and
  // FRWLock
  Clear;
  for i := 0 to FCookieListByDomain.Count -1 do
  begin
    FCookieListByDomain.Objects[i].Free;
  end;
  Sys.FreeAndNil(FCookieListByDomain);
  Sys.FreeAndNil(FRWLock);
  inherited Destroy;
end;

procedure TIdCookies.AddCookie(ACookie: TIdCookieRFC2109);
Var
  LList: TIdCookieList;
  j: Integer;
begin
  with LockCookieListByDomain(caReadWrite) do try
    if IndexOf(ACookie.Domain) = -1 then
    begin
      LList := TIdCookieList.Create;
      AddObject(ACookie.Domain, LList);
    end;

    j := TIdStringList(Objects[IndexOf(ACookie.Domain)]).IndexOf(ACookie.CookieName);

    if j = -1 then
    begin
      TIdStringList(Objects[IndexOf(ACookie.Domain)]).AddObject(ACookie.CookieName, ACookie);
    end
    else begin
      TIdCookieRFC2109(TIdStringList(Objects[IndexOf(ACookie.Domain)]).Objects[j]).Assign(ACookie);
      ACookie.Collection := nil;
      ACookie.Free;
    end;
  finally
    UnlockCookieListByDomain(caReadWrite);
  end;
end;

function TIdCookies.GetItem(Index: Integer): TIdCookieRFC2109;
begin
  result := (inherited Items[Index]) as TIdCookieRFC2109;
end;

procedure TIdCookies.SetItem(Index: Integer; const Value: TIdCookieRFC2109);
begin
  inherited Items[Index] := Value;
end;

function TIdCookies.Add: TIdCookieRFC2109;
begin
  Result := TIdCookieRFC2109.Create(self);
end;

function TIdCookies.Add2: TIdCookieRFC2965;
begin
  Result := TIdCookieRFC2965.Create(self);
end;

procedure TIdCookies.AddSrcCookie(const sCookie: string);
begin
  Add.CookieText := sCookie;
end;

function TIdCookies.GetCookie(const AName, ADomain: string): TIdCookieRFC2109;
var
  i: Integer;
begin
  i := GetCookieIndex(0, AName, ADomain);
  if i = -1 then
  begin
    result := nil;
  end
  else begin
    result := Items[i];
  end;
end;

function TIdCookies.GetCookieIndex(FirstIndex: integer; const AName, ADomain: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    if TextIsSame(Items[i].CookieName, AName) and TextIsSame(Items[i].Domain, ADomain) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TIdCookies.GetCookieIndex(FirstIndex: integer; const AName: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    if TextIsSame(Items[i].CookieName, AName) then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TIdCookies.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

function TIdCookies.LockCookieListByDomain(AAccessType: TIdCookieAccess): TIdCookieList;
begin
  case AAccessType of
    caRead:
      begin
        FRWLock.BeginRead;
      end;
    caReadWrite:
      begin
        FRWLock.BeginWrite;
      end;
  end;
  result := FCookieListByDomain;
end;

procedure TIdCookies.UnlockCookieListByDomain(AAccessType: TIdCookieAccess);
begin
  case AAccessType of
    caRead:
      begin
        FRWLock.EndRead;
      end;
    caReadWrite:
      begin
        FRWLock.EndWrite;
      end;
  end;
end;

{ TIdServerCookies }

function TIdServerCookies.Add: TIdServerCookie;
begin
  Result := TIdServerCookie.Create(self);
end;

function TIdServerCookies.GetCookie(const AName: string): TIdCookieRFC2109;
var
  i: Integer;
begin
  i := GetCookieIndex(0, AName);

  if i = -1 then
  begin
    result := nil;
  end
  else begin
    result := Items[i];
  end;
end;

end.
