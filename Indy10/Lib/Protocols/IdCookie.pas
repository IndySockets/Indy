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
  Rev 1.6    2004.10.27 9:17:46 AM  czhower
  For TIdStrings

  Rev 1.5    10/26/2004 11:08:08 PM  JPMugaas
  Updated refs.

  Rev 1.4    13.04.2004 12:56:44  ARybin
  M$ IE behavior

  Rev 1.3    2004.02.03 5:45:00 PM  czhower
  Name changes

  Rev 1.2    2004.01.22 6:09:02 PM  czhower
  IdCriticalSection

  Rev 1.1    1/22/2004 7:09:58 AM  JPMugaas
  Tried to fix AnsiSameText depreciation.

  Rev 1.0    11/14/2002 02:16:20 PM  JPMugaas

  Mar-31-2001 Doychin Bondzhev
  - Changes in the class heirarchy to implement Netscape specification[Netscape],
      RFC 2109[RFC2109] & 2965[RFC2965]

  Feb-2001 Doychin Bondzhev
  - Initial release
}

unit IdCookie;

{
  Implementation of the HTTP State Management Mechanism as specified in RFC 2109, 2965.
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Indy Team.

  TIdNetscapeCookie - The base code used in all cookies. It implments cookies
  as proposed by Netscape

    TIdCookieRFC2109 - The RFC 2109 implmentation. Not used too much.

  TIdCookieRFC2965 - The RFC 2965 implmentation. Not used yet or at least I don't
    know any HTTP server that supports this specification.

  TIdServerCooke - Used in the HTTP server compoenent.

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

// TODO: Make this unit to implement completely [Netscape], [RFC2109] & [RFC2965]

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdException, IdGlobalProtocols, SysUtils;
  //must keep for now

Const
  GFMaxAge = -1;

Type
  TIdCookieVersion = (cvNetscape, cvRFC2109, cvRFC2965);

  TIdNetscapeCookie = class;

  TIdCookieList = class(TStringList)
  protected
    function GetCookie(Index: Integer): TIdNetscapeCookie;
  public
    property Cookies[Index: Integer]: TIdNetscapeCookie read GetCookie;
  end;

  {
    Base Cookie class as described in
    "Persistent Client State -- HTTP Cookies"
  }
  TIdNetscapeCookie = class(TCollectionItem)
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
    procedure SetExpires(const AValue: String); virtual;
    procedure SetCookie(const AValue: String);

    function GetServerCookie: String; virtual;
    function GetClientCookie: String; virtual;

    procedure LoadProperties(APropertyList: TStrings); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function IsValidCookie(const AServerHost: String): Boolean; virtual;

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
    procedure SetExpires(const AValue: String); override;
    procedure LoadProperties(APropertyList: TStrings); override;
  public
    constructor Create(ACollection: TCollection); override;

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
    procedure LoadProperties(APropertyList: TStrings); override;
    procedure SetPort(AIndex, AValue: Integer);
    function GetPort(AIndex: Integer): Integer;
  public
    constructor Create(ACollection: TCollection); override;

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
    constructor Create(ACollection: TCollection); override;
    procedure AddAttribute(const Attribute, Value: String);
  end;

  { The Cookie collection }

  TIdCookieAccess = (caRead, caReadWrite);

  TIdCookies = class(TOwnedCollection)
  protected
    FCookieListByDomain: TIdCookieList;
    FRWLock: TMultiReadExclusiveWriteSynchronizer;

    function GetCookie(const AName, ADomain: string): TIdCookieRFC2109;
    function GetItem(Index: Integer): TIdCookieRFC2109;
    procedure SetItem(Index: Integer; const Value: TIdCookieRFC2109);
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TIdCookieRFC2109;
    function Add2: TIdCookieRFC2965;
    procedure AddCookie(ACookie: TIdCookieRFC2109);
    procedure AddSrcCookie(const ACookie: string);
    procedure Delete(Index: Integer);
    function GetCookieIndex(FirstIndex: Integer; const AName: string): Integer; overload;
    function GetCookieIndex(FirstIndex: Integer; const AName, ADomain: string): Integer; overload;

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

function AddCookieProperty(const AProperty, AValue, ACookie: String): String;
begin
  Result := ACookie;
  if Length(AValue) > 0 then
  begin
    if Length(Result) > 0 then
    begin
      Result := Result + '; ';    {Do not Localize}
    end;
    Result := Result + AProperty + '=' + AValue;    {Do not Localize}
  end;
end;

function AddCookieFlag(const AFlag, ACookie: String): String;
begin
  Result := ACookie;
  if Length(Result) > 0 then
  begin
    Result := Result + '; ';    {Do not Localize}
  end;
  Result := Result + AFlag;
end;

{ TIdCookieList }

function TIdCookieList.GetCookie(Index: Integer): TIdNetscapeCookie;
begin
  result := TIdNetscapeCookie(Objects[Index]);
end;

{ TIdNetscapeCookie }

constructor TIdNetscapeCookie.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvNetscape;
end;

destructor TIdNetscapeCookie.Destroy;
Var
  LListByDomain: TIdCookieList;
  LCookieStringList: TStringList;
  i: Integer;
begin
  if Assigned(Collection) then try
    LListByDomain := TIdCookies(Collection).LockCookieListByDomain(caReadWrite);
    if Assigned(LListByDomain) then try
      i := LListByDomain.IndexOf(Domain);
      if i > -1 then
      begin
        LCookieStringList := TStringList(LListByDomain.Objects[i]);
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

procedure TIdNetscapeCookie.Assign(Source: TPersistent);
begin
  if Source is TIdCookieRFC2109 then
  begin
    CookieText := TIdCookieRFC2109(Source).CookieText;
    FInternalVersion := TIdCookieRFC2109(Source).FInternalVersion;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdNetscapeCookie.IsValidCookie(const AServerHost: String): Boolean;
begin
  if IsValidIP(AServerHost) then // true if Server host is IP and Domain is eq to ServerHost
  begin
    Result := AServerHost = FDomain;
  end
  else if IsHostName(AServerHost) then
  begin
    if IsHostName(FDomain) then
    begin
      //MSIE: if FDomain looks like "xxxx.yyyy.com", then AServerHost "zzzz.xxxx.yyyy.com" is valid
      //also must allow 4.3.2.1=valid for domain=.2.1
      Result := TextEndsWith(AServerHost, FDomain);
    end
    else begin
      Result := TextIsSame(FDomain, DomainName(AServerHost));
    end;
  end
  else begin
    Result := TextIsSame(FDomain, DomainName(AServerHost));
  end;
end;

procedure TIdNetscapeCookie.SetExpires(const AValue: String);
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
  Result := FName + '=' + FValue;    {Do not Localize}
end;

function TIdNetscapeCookie.GetCookie: String;
begin
  Result := AddCookieProperty(FName, FValue, '');    {Do not Localize}
  Result := AddCookieProperty('path', FPath, Result);    {Do not Localize}
  if FInternalVersion = cvNetscape then
  begin
    Result := AddCookieProperty('expires', FExpires, Result);    {Do not Localize}
  end;
  Result := AddCookieProperty('domain', FDomain, Result);    {Do not Localize}
  if FSecure then
  begin
    Result := AddCookieFlag('secure', Result);    {Do not Localize}
  end;
end;

procedure TIdNetscapeCookie.LoadProperties(APropertyList: TIdStrings);
begin
  FPath := APropertyList.Values['PATH'];    {Do not Localize}
  // Tomcat can return SetCookie2 with path wrapped in "
  if Length(FPath) > 0 then
  begin
    if FPath[1] = '"' then begin   {Do not Localize}
      Delete(FPath, 1, 1);
    end;
    if (FPath <> '') and (FPath[Length(FPath)] = '"') then begin   {Do not Localize}
      SetLength(FPath, Length(FPath) - 1);
    end;
  end
  else begin
    FPath := '/'; {Do not Localize}
  end;
  Expires := APropertyList.values['EXPIRES'];    {Do not Localize}
  FDomain := APropertyList.values['DOMAIN'];    {Do not Localize}
  FSecure := APropertyList.IndexOf('SECURE') <> -1;    {Do not Localize}
end;

procedure TIdNetscapeCookie.SetCookie(const AValue: String);
Var
  i: Integer;
  CookieProp: TStringList;
  LTemp: String;
begin
  if AValue <> FCookieText then
  begin
    FCookieText := AValue;

    CookieProp := TStringList.Create;
    try
      LTemp := Trim(AValue);
      while LTemp <> '' do    {Do not Localize}
      begin
        CookieProp.Add(Trim(Fetch(LTemp, ';')));    {Do not Localize}
        LTemp := Trim(LTemp);
      end;

      FName := CookieProp.Names[0];
      FValue := CookieProp.Values[FName];
      CookieProp.Delete(0);

      for i := 0 to CookieProp.Count - 1 do
      begin
        {RLebeau - isn't this upper-casing everything?  If so, then why look for '=' at all? }
        if Pos('=', CookieProp[i]) = 0 then    {Do not Localize}
        begin
          CookieProp[i] := UpperCase(CookieProp[i]);  // This is for cookie flags (secure)
        end
        else begin
          CookieProp[i] := UpperCase(CookieProp.Names[i]) + '=' + CookieProp.Values[CookieProp.Names[i]];    {Do not Localize}
        end;
      end;

      LoadProperties(CookieProp);
    finally
      FreeAndNil(CookieProp);
    end;
  end;
end;

{ TIdCookieRFC2109 }

constructor TIdCookieRFC2109.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FMax_Age := GFMaxAge;
  FInternalVersion := cvRFC2109;
end;

procedure TIdCookieRFC2109.SetExpires(const AValue: String);
begin
  if Length(AValue) > 0 then
  begin
    try
      // If you see an exception here then that means the HTTP server has returned an invalid expires
      // date/time value. The correct format is Wdy, DD-Mon-YY HH:MM:SS GMT

      // AValue := StringReplace(AValue, '-', ' ', [rfReplaceAll]);    {Do not Localize}
      FMax_Age := Trunc((GMTToLocalDateTime(AValue) - Now) * MSecsPerDay / 1000);
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
  Result := inherited GetClientCookie; 

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
  Result := inherited GetCookie;

  if (FMax_Age > -1) and (Length(FExpires) = 0) then
  begin
    Result := AddCookieProperty('max-age', IntToStr(FMax_Age), Result);    {Do not Localize}
  end;

  Result := AddCookieProperty('comment', FComment, Result);    {Do not Localize}
  Result := AddCookieProperty('version', FVersion, Result);    {Do not Localize}
end;

procedure TIdCookieRFC2109.LoadProperties(APropertyList: TStrings);
begin
  inherited LoadProperties(APropertyList);

  FMax_Age := IndyStrToInt(APropertyList.Values['MAX-AGE'], -1);    {Do not Localize}
  FVersion := APropertyList.Values['VERSION'];    {Do not Localize}
  FComment := APropertyList.Values['COMMENT'];    {Do not Localize}

  if Length(Expires) = 0 then begin
    FInternalVersion := cvNetscape;
    if FMax_Age >= 0 then begin
      Expires := DateTimeGMTToHttpStr(Now - OffsetFromUTC + FMax_Age * 1000 / MSecsPerDay);
    end;
    // else   Free this cookie
  end;
end;

{ TIdCookieRFC2965 }

constructor TIdCookieRFC2965.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvRFC2965;
end;

function TIdCookieRFC2965.GetCookie: String;
begin
  result := inherited GetCookie;
end;

procedure TIdCookieRFC2965.LoadProperties(APropertyList: TStrings);
Var
  PortListAsString: TStringList;
  i: Integer;
  S: String;
begin
  inherited LoadProperties(APropertyList);

  FCommentURL := APropertyList.Values['CommentURL'];    {Do not Localize}
  FDiscard := APropertyList.IndexOf('DISCARD') <> -1;    {Do not Localize}

  PortListAsString := TStringList.Create;
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
            PortList[i] := IndyStrToInt(PortListAsString[i]);
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
  if ((AIndex - High(FPortList)) > 1) or (AIndex < Low(FPortList)) then
  begin
    raise EIdException.Create('Index out of range.');    {Do not Localize}
  end;
  if (AIndex - High(FPortList)) = 1 then
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
  Result := FPortList[AIndex];
end;

{ TIdServerCookie }

constructor TIdServerCookie.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FInternalVersion := cvNetscape;
  // Version := '1';    {Do not Localize}
end;

function TIdServerCookie.GetCookie: String;
begin
  if FMax_Age > -1 then
  begin
    FExpires := DateTimeGMTToCookieStr(
      Now + TimeZoneBias + FMax_Age / MSecsPerDay * 1000);
  end;
  Result := inherited GetCookie;
end;

procedure TIdServerCookie.AddAttribute(const Attribute, Value: String);
begin
  case PosInStrArray(Attribute, ['$PATH', '$DOMAIN'], False) of    {Do not Localize}
    0: Path := Value;
    1: Domain := Value;
  end;
end;

{ TIdCookies }

constructor TIdCookies.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdCookieRFC2109);

  FRWLock := TMultiReadExclusiveWriteSynchronizer.Create;
  FCookieListByDomain := TIdCookieList.Create;
end;

destructor TIdCookies.Destroy;
var
  i : Integer;
begin
  // This will force the Cookie removing process before we free the FCookieListByDomain and
  // FRWLock
  Clear;
  for i := 0 to FCookieListByDomain.Count -1 do
  begin
    FCookieListByDomain.Objects[i].Free;
  end;
  FreeAndNil(FCookieListByDomain);
  FreeAndNil(FRWLock);
  inherited Destroy;
end;

procedure TIdCookies.AddCookie(ACookie: TIdCookieRFC2109);
Var
  LList: TIdCookieList;
  LIndex: Integer;
begin
  with LockCookieListByDomain(caReadWrite) do
  try
    LIndex := IndexOf(ACookie.Domain);
    if LIndex = -1 then
    begin
      LList := TIdCookieList.Create;
      try
        AddObject(ACookie.Domain, LList);
      except
        FreeAndNil(LList);
        raise;
      end;
    end
    else begin
      LList := TIdCookieList(Objects[LIndex]);
    end;

    LIndex := LList.IndexOf(ACookie.CookieName);
    if LIndex = -1 then
    begin
      LList.AddObject(ACookie.CookieName, ACookie);
    end
    else begin
      TIdCookieRFC2109(LList.Objects[LIndex]).Assign(ACookie);
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
  Result := TIdCookieRFC2109.Create(Self);
end;

function TIdCookies.Add2: TIdCookieRFC2965;
begin
  Result := TIdCookieRFC2965.Create(Self);
end;

procedure TIdCookies.AddSrcCookie(const ACookie: string);
begin
  Add.CookieText := ACookie;
end;

function TIdCookies.GetCookie(const AName, ADomain: string): TIdCookieRFC2109;
var
  i: Integer;
begin
  i := GetCookieIndex(0, AName, ADomain);
  if i = -1 then
  begin
    Result := nil;
  end
  else begin
    Result := Items[i];
  end;
end;

function TIdCookies.GetCookieIndex(FirstIndex: Integer; const AName, ADomain: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    if TextIsSame(Items[i].CookieName, AName) and TextIsSame(Items[i].Domain, ADomain) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TIdCookies.GetCookieIndex(FirstIndex: Integer; const AName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    if TextIsSame(Items[i].CookieName, AName) then
    begin
      Result := i;
      Exit;
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
  Result := FCookieListByDomain;
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
  Result := TIdServerCookie.Create(Self);
end;

function TIdServerCookies.GetCookie(const AName: string): TIdCookieRFC2109;
var
  i: Integer;
begin
  i := GetCookieIndex(0, AName);
  if i = -1 then begin
    Result := nil;
  end else begin
    Result := Items[i];
  end;
end;

end.
