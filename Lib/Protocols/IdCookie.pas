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

REFERENCES
-------------------
 [Netscape] "Persistent Client State -- HTTP Cookies",
            formerly available at <http://www.netscape.com/newsref/std/cookie_spec.html>,
            now at <http://curl.haxx.se/rfc/cookie_spec.html>,
            undated.

 [RFC2109]  Kristol, D. and L. Montulli, "HTTP State Management Mechanism",
            RFC 2109, February 1997.

 [RFC2965]  Kristol, D. and L. Montulli, "HTTP State Management Mechanism",
            RFC 2965, October 2000.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdException, IdGlobalProtocols, IdURI, SysUtils;

const
  GFMaxAge = -1;

type
  TIdNetscapeCookie = class;

  TIdCookieList = class(TStringList)
  protected
    function GetCookie(Index: Integer): TIdNetscapeCookie;
  public
    function IndexOfCookie(ACookie: TIdNetscapeCookie): Integer;
    property Cookies[Index: Integer]: TIdNetscapeCookie read GetCookie;
  end;

  {
  TIdCookieDomainList = class(TStringList)
  protected
    function GetCookieList(Index: Integer): TIdCookieList;
  public
    property CookieList[Index: Integer]: TIdCookieList read GetCookieList;
  end;
  }

  {
    Base Cookie class as described in
    "Persistent Client State -- HTTP Cookies"
  }
  TIdNetscapeCookie = class(TCollectionItem)
  protected
    FDomain: String;
    FExpires: TDateTime;
    FHttpOnly: Boolean;
    FName: String;
    FPath: String;
    FSecure: Boolean;
    FValue: String;

    function GetServerCookie: String; virtual;
    procedure SetServerCookie(const AValue: String);

    function GetClientCookie: String; virtual;
    procedure SetClientCookie(const AVAlue: String);

    procedure LoadProperties(APropertyList: TStrings); virtual;

    function GetExpires: TDateTime; virtual;

  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean; virtual;
    function IsRejected(AURI: TIdURI): Boolean; virtual;
    function MatchesHost(const AHost: String): Boolean; virtual;
    procedure ResolveDefaults(AURI: TIdURI); virtual;

    property ClientCookie: String read GetClientCookie write SetClientCookie;
    property CookieName: String read FName write FName;
    property CookieText: String read GetServerCookie write SetServerCookie;// {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPECATED_MSG} 'Use ServerCookie property instead'{$ENDIF};{$ENDIF}
    property Domain: String read FDomain write FDomain;
    property Expires: TDateTime read GetExpires write FExpires;
    property HttpOnly: Boolean read FHttpOnly write FHttpOnly;
    property Path: String read FPath write FPath;
    property Secure: Boolean read FSecure write FSecure;
    property ServerCookie: String read GetServerCookie write SetServerCookie;
    property Value: String read FValue write FValue;
  end;

  { Cookie as described in [RFC2109] }
  // Adds Version, Comment, MaxAge. Version is optional
  TIdCookieRFC2109 = class(TIdNetscapeCookie)
  protected
    FMaxAge: Int64;
    FVersion: Integer;
    FComment: String;

    function GetClientCookie: String; override;
    function GetServerCookie: String; override;

    function GetExpires: TDateTime; override;
    function GetMaxAge: Int64;

    procedure LoadProperties(APropertyList: TStrings); override;

    procedure SetVersion(const AValue: Integer); virtual;

  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    function IsRejected(AURI: TIdURI): Boolean; override;
    function MatchesHost(const AHost: String): Boolean; override;
    procedure ResolveDefaults(AURI: TIdURI); override;

    property Comment: String read FComment write FComment;
    property MaxAge: Int64 read GetMaxAge write FMaxAge;
    property Version: Integer read FVersion write SetVersion;
  end;

  { Cookie as described in [RFC2965] }
  // Adds CommentURL, Discard, Port. Version is required
  TIdCookieRFC2965 = class(TIdCookieRFC2109)
  protected
    FCommentURL: String;
    FDiscard: Boolean;
    FPortList: array of TIdPort;
    FRecvPort: TIdPort;
    FUsePort: Boolean;

    function GetClientCookie: String; override;
    function GetServerCookie: String; override;
    function GetPort(AIndex: Integer): TIdPort;
    function GetPortCount: Integer;

    procedure LoadProperties(APropertyList: TStrings); override;

    procedure SetPort(AIndex: Integer; AValue: TIdPort);
    procedure SetVersion(const AValue: Integer); override;

  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    function IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean; override;
    function IsRejected(AURI: TIdURI): Boolean; override;
    function MatchesHost(const AHost: String): Boolean; override;
    procedure ResolveDefaults(AURI: TIdURI); override;

    property CommentURL: String read FCommentURL write FCommentURL;
    property Discard: Boolean read FDiscard write FDiscard;
    property PortCount: Integer read GetPortCount;
    property PortList[AIndex: Integer]: TIdPort read GetPort write SetPort;
    property UsePort: Boolean read FUsePort;
    property RecvPort: TIdPort read FRecvPort;
  end;

  TIdNetscapeCookieClass = class of TIdNetscapeCookie;
  TIdCookieRFC2109Class = class of TIdCookieRFC2109;
  TIdCookieRFC2965Class = class of TIdCookieRFC2965;

  { The Cookie collection }

  TIdCookieAccess = (caRead, caReadWrite);

  TIdCookies = class(TOwnedCollection)
  protected
    FCookieList: TIdCookieList;
    FRWLock: TMultiReadExclusiveWriteSynchronizer;

    function GetCookie(const AName, AHost: string): TIdNetscapeCookie;
    function GetItem(Index: Integer): TIdNetscapeCookie;
    procedure SetItem(Index: Integer; const Value: TIdNetscapeCookie);

  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;

    function Add: TIdCookieRFC2109; reintroduce;
    function Add2: TIdCookieRFC2965;

    procedure AddCookie(ACookie: TIdNetscapeCookie);

    function AddClientCookie(const ACookie: string): TIdCookieRFC2109;
    function AddClientCookie2(const ACookie: string): TIdCookieRFC2965;

    procedure AddClientCookies(const ACookies: string); overload;
    procedure AddClientCookies(const ACookies: TStrings); overload;

    procedure AddClientCookies2(const ACookies: string); overload;
    procedure AddClientCookies2(const ACookies: TStrings); overload;

    function AddServerCookie(const ACookie: string; AURI: TIdURI): TIdCookieRFC2109;
    function AddServerCookie2(const ACookie: string; AURI: TIdURI): TIdCookieRFC2965;

    procedure AddServerCookies(const ACookies: string; AURI: TIdURI); overload;
    procedure AddServerCookies(const ACookies: TStrings; AURI: TIdURI); overload;

    procedure AddCookies(ASource: TIdCookies);

    procedure Assign(ASource: TPersistent); override;
    procedure Clear; reintroduce;

    function GetCookieIndex(FirstIndex: Integer; const AName: string): Integer; overload;
    function GetCookieIndex(FirstIndex: Integer; const AName, AHost: string): Integer; overload;

    function LockCookieList(AAccessType: TIdCookieAccess): TIdCookieList;
    procedure UnlockCookieList(AAccessType: TIdCookieAccess);

    property Cookie[const AName, ADomain: string]: TIdNetscapeCookie read GetCookie;
    property Items[Index: Integer]: TIdNetscapeCookie read GetItem write SetItem; Default;
  end;

procedure SplitCookieText(const ACookieText: String; AParts: TStrings);
function ExtractNextCookie(var VCookieText, VCookie: String; IsServerCookie: Boolean): Boolean;

function EffectiveHostName(const AHost: String): String;
function IsDomainMatch(const AHost, ADomain: String): Boolean;

implementation

uses
  IdAssignedNumbers;

procedure SplitCookieText(const ACookieText: String; AParts: TStrings);
var
  LTemp, LName, LValue: String;
  i: Integer;
  IsFlag: Boolean;
begin
  LTemp := Trim(ACookieText);
  while LTemp <> '' do    {Do not Localize}
  begin
    i := FindFirstOf('=;', LTemp); {Do not Localize}
    if i = 0 then begin
      AParts.Add(LTemp);
      Break;
    end;
    IsFlag := (LTemp[i] = ';'); {Do not Localize}
    LName := TrimRight(Copy(LTemp, 1, i-1));
    LTemp := TrimLeft(Copy(LTemp, i+1, MaxInt));
    LValue := '';
    if (not IsFlag) and (LTemp <> '') then
    begin
      if LTemp[1] = '"' then
      begin
        IdDelete(LTemp, 1, 1);
        LValue := Fetch(LTemp, '"'); {Do not Localize}
        Fetch(LTemp, ';'); {Do not Localize}
      end else begin
        LValue := Trim(Fetch(LTemp, ';')); {Do not Localize}
      end;
      LTemp := TrimLeft(LTemp);
    end;
    if LName <> '' then begin
      AParts.Add(LName + '=' + LValue);    {Do not Localize}
    end;
  end;
end;

function ExtractNextCookie(var VCookieText, VCookie: String; IsServerCookie: Boolean): Boolean;
var
  LStartPos, LEndPos, I: Integer;
  LInAttribute: Boolean;
  LName: String;
begin
  VCookie := '';

  VCookieText := TrimLeft(VCookieText);
  if VCookieText = '' then begin
    Result := False;
    Exit;
  end;

  LStartPos := 1;
  LEndPos := 0;
  LInAttribute := False;

  repeat
    if VCookieText[LStartPos] = '$' then begin {Do not Localize}
      LInAttribute := True;
    end else
    begin
      if (not IsServerCookie) and LInAttribute then begin
        Break;
      end;
      LInAttribute := False;
    end;

    I := FindFirstOf('=;,', VCookieText, -1, LStartPos); {Do not Localize}
    if I = 0 then begin
      LEndPos := 0;
      Break;
    end;

    LName := Trim(Copy(VCookieText, LStartPos, I-LStartPos));

    if VCookieText[I] = '=' then begin {Do not Localize}
      I := FindFirstOf('";,', VCookieText, -1, I+1); {Do not Localize}
      if I = 0 then begin
        LEndPos := 0;
        Break;
      end;

      if VCookieText[I] = '"' then begin {Do not Localize}
        I := PosIdx('"', VCookieText, I+1); {Do not Localize}
        if I = 0 then begin
          LEndPos := 0;
          Break;
        end;

        LEndPos := I+1;
        I := FindFirstOf(';,', VCookieText, -1, LEndPos); {Do not Localize}
        if I = 0 then begin
          Break;
        end;

        LEndPos := I;
        if VCookieText[I] = ',' then begin {Do not Localize}
          Break;
        end;
      end
      else if VCookieText[I] = ',' then begin {Do not Localize}
        // RLebeau: check for special case when expiration date is not quoted
        if not TextIsSame(LName, 'Expires') then begin
          LEndPos := I;
          Break;
        end;
        I := FindFirstOf(';,', VCookieText, -1, I+1); {Do not Localize}
        if I = 0 then begin
          LEndPos := 0;
          Break;
        end;
        LEndPos := I;
        if VCookieText[I] = ',' then begin {Do not Localize}
          Break;
        end;
      end else
      begin
        LEndPos := I;
      end;
    end else
    begin
      LEndPos := I;
      if VCookieText[I] = ',' then begin {Do not Localize}
        Break;
      end;
    end;
    LStartPos := FindFirstNotOf(' '#9, VCookieText, -1, LEndPos+1); {Do not Localize}
  until LStartPos = 0;

  if LEndPos > 0 then begin
    VCookie := TrimRight(Copy(VCookieText, 1, LEndPos-1));
    VCookieText := TrimLeft(Copy(VCookieText, LEndPos+1, MaxInt));
  end else
  begin
    VCookie := VCookieText;
    VCookieText := '';
  end;
  Result := (VCookie <> '');
end;

function EffectiveHostName(const AHost: String): String;
begin
  if Pos('.', AHost) = 0 then begin {Do not Localize}
    Result := AHost + '.local'; {Do not Localize}
  end else begin
    Result := AHost;
  end;
end;

function IsDomainMatch(const AHost, ADomain: String): Boolean;
var
  S: String;
begin
  {
  Per RFC 2109:

  Hosts names can be specified either as an IP address or a FQHN
  string.  Sometimes we compare one host name with another.  Host A's
  name domain-matches host B's if

  * both host names are IP addresses and their host name strings match
    exactly; or

  * both host names are FQDN strings and their host name strings match
    exactly; or

  * A is a FQDN string and has the form NB, where N is a non-empty name
    string, B has the form .B', and B' is a FQDN string.  (So, x.y.com
    domain-matches .y.com but not y.com.)

  Note that domain-match is not a commutative operation: a.b.c.com
  domain-matches .c.com, but not the reverse.
  }  

  {
  Per RFC 2965:
  
  Host names can be specified either as an IP address or a HDN string.
  Sometimes we compare one host name with another.  (Such comparisons
  SHALL be case-insensitive.)  Host A's name domain-matches host B's if

    * their host name strings string-compare equal; or

    * A is a HDN string and has the form NB, where N is a non-empty
      name string, B has the form .B', and B' is a HDN string.  (So,
      x.y.com domain-matches .Y.com but not Y.com.)

  Note that domain-match is not a commutative operation: a.b.c.com
  domain-matches .c.com, but not the reverse.
  }

  if IsValidIP(AHost) then
  begin
    Result := TextIsSame(AHost, ADomain);
  end
  else if IsHostName(AHost) then
  begin
    if CharEquals(ADomain, 1, '.') then {do not localize}
    begin
      S := Copy(ADomain, 2, MaxInt);
      if TextEndsWith(AHost, ADomain) then
      begin
        Result := IsHostName(S) and (Length(AHost) > Length(ADomain));
        Exit;
      end;
    end else
    begin
      S := ADomain;
    end;
    Result := TextIsSame(AHost, S);
  end else
  begin
    Result := False;
  end;
end;

function IsPortMatch(ACookie: TIdCookieRFC2965; const APort: String): Boolean;
var
  LPort: TIdPort;
  I: Integer;
begin
  {
  Per RFC 2965:

  Port Selection
      There are three possible behaviors, depending on the Port
      attribute in the Set-Cookie2 response header:

      1. By default (no Port attribute), the cookie MAY be sent to any
         port.

      2. If the attribute is present but has no value (e.g., Port), the
         cookie MUST only be sent to the request-port it was received
         from.

      3. If the attribute has a port-list, the cookie MUST only be
         returned if the new request-port is one of those listed in
         port-list.
  }

  if not ACookie.UsePort then
  begin
    Result := True;
    Exit;
  end;

  LPort := IndyStrToInt(APort, IdPORT_HTTP);

  if ACookie.PortCount = 0 then
  begin
    Result := (ACookie.RecvPort = LPort);
    Exit;
  end;

  for I := 0 to ACookie.PortCount-1 do
  begin
    if ACookie.PortList[I] = LPort then
    begin
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

function IsTailMatch(const AHost, ADomain: String): Boolean;
var
  LDomain: String;
begin
  {
  Per Netscape standard:

  "Tail matching" means that domain attribute is matched against the tail of
  the fully qualified domain name of the host. A domain attribute of "acme.com"
  would match host names "anvil.acme.com" as well as "shipping.crate.acme.com".
  }

  Result := TextIsSame(AHost, ADomain);
  if not Result then
  begin
    LDomain := ADomain;
    if not TextStartsWith(LDomain, '.') then begin {do not localize}
      LDomain := '.' + LDomain; {Do not localize}
    end;
    Result := TextEndsWith(AHost, LDomain);
  end;
end;

function GetTLD(const ADomain: String): String;
var
  I: Integer;
begin
  I := RPos('.', ADomain);
  if I = 0 then begin
    Result := '';
  end else begin
    Result := Copy(ADomain, I+1, MaxInt);
  end;
end;

function HasReservedTLD(const ADomain: String): Boolean;
begin
  Result := PosInStrArray(GetTLD(ADomain), ['COM', 'EDU', 'NET', 'ORG', 'GOV', 'MIL', 'INT'], False) <> -1; {Do not Localize}
end;

function HasAtLeastNumDots(const AStr: String; ANum: LongWord): Boolean;
var
  I: LongWord;
begin
  Result := False;
  I := 1;
  while ANum > 0 do
  begin
    I := PosIdx('.', AStr, I);
    if I = 0 then begin
      Exit;
    end;
    Dec(ANum);
  end;
  Result := True;
end;

{ base functions used for construction of Cookie text }

procedure AddCookieProperty(var VCookie: String; const AProperty, AValue: String; AQuoted: Boolean = True);
begin
  if Length(AValue) > 0 then
  begin
    if Length(VCookie) > 0 then
    begin
      VCookie := VCookie + '; ';    {Do not Localize}
    end;
    // TODO: encode illegal charaters?
    VCookie := VCookie + AProperty + '=' + iif(AQuoted, '"' + AValue + '"', AValue);    {Do not Localize}
  end;
end;

procedure AddCookieFlag(var VCookie: String; const AFlag: String);
begin
  if Length(VCookie) > 0 then
  begin
    VCookie := VCookie + '; ';    {Do not Localize}
  end;
  VCookie := VCookie + AFlag;
end;

{ TIdCookieList }

function TIdCookieList.GetCookie(Index: Integer): TIdNetscapeCookie;
begin
  Result := TIdNetscapeCookie(Objects[Index]);
end;

function TIdCookieList.IndexOfCookie(ACookie: TIdNetscapeCookie): Integer;
begin
  for Result := 0 to Count-1 do
  begin
    if GetCookie(Result) = ACookie then begin
      Exit;
    end;
  end;
  Result := -1;
end;

{ TIdCookieDomainList }

{
function TIdCookieDomainList.GetCookieList(Index: Integer): TIdCookieList;
begin
  Result := TIdCookieList(Objects[Index]);
end;
}

{ TIdNetscapeCookie }

constructor TIdNetscapeCookie.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
end;

destructor TIdNetscapeCookie.Destroy;
Var
  LCookieList: TIdCookieList;
  LIndex: Integer;
begin
  try
    if Assigned(Collection) then
    begin
      LCookieList := TIdCookies(Collection).LockCookieList(caReadWrite);
      try
        LIndex := LCookieList.IndexOfCookie(Self);
        if LIndex <> -1 then begin
          LCookieList.Delete(LIndex);
        end;
      finally
        TIdCookies(Collection).UnlockCookieList(caReadWrite);
      end;
    end;
  finally
    inherited Destroy;
  end;
end;

procedure TIdNetscapeCookie.Assign(Source: TPersistent);
begin
  if Source is TIdNetscapeCookie then
  begin
    with TIdNetscapeCookie(Source) do
    begin
      Self.FDomain := FDomain;
      Self.FExpires := FExpires;
      Self.FHttpOnly := FHttpOnly;
      Self.FName := FName;
      Self.FPath := FPath;
      Self.FSecure := FSecure;
      Self.FValue := FValue;
    end;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdNetscapeCookie.IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean;
begin
  Result := (Value <> '') and
    IsTailMatch(AURI.Host, Domain) and
    TextStartsWith(AURI.Path, Path) and // TODO: do a proper URI comparison here...
    ((Secure and SecureOnly) or (not Secure));
end;

function TIdNetscapeCookie.IsRejected(AURI: TIdURI): Boolean;
begin
  {
  Per Netscape standard:

  Only hosts within the specified domain can set a cookie for a domain and
  domains must have at least two (2) or three (3) periods in them to prevent
  domains of the form: ".com", ".edu", and "va.us". Any domain that fails
  within one of the seven special top level domains listed below only require
  two periods. Any other domain requires at least three. The seven special
  top level domains are: "COM", "EDU", "NET", "ORG", "GOV", "MIL", and "INT".
  }

  if HasReservedTLD(Domain) then begin
    Result := not HasAtLeastNumDots(Domain, 2);
  end else begin
    Result := not HasAtLeastNumDots(Domain, 3);
  end;
end;

function TIdNetscapeCookie.MatchesHost(const AHost: String): Boolean;
begin
  Result := IsTailMatch(AHost, Domain);
end;

procedure TIdNetscapeCookie.ResolveDefaults(AURI: TIdURI);
begin
  if (Length(Domain) = 0) and (AURI <> nil) then begin
    Domain := AURI.Host;
    if (Length(Domain) > 0) and (not TextStartsWith(Domain, '.')) then begin {do not localize}
      if HasReservedTLD(Domain) then begin
        if not HasAtLeastNumDots(Domain, 2) then begin
          Domain := '.' + Domain; {do not localize}
        end;
      end
      else if not HasAtLeastNumDots(Domain, 3) then begin
        Domain := '.' + Domain; {do not localize}
      end;
    end;
  end;

  if (Length(Path) = 0) and (AURI <> nil) then begin
    Path := AURI.Path;
    if CharEquals(Path, Length(Path), '/') then begin {do not localize}
      Path := Copy(Path, 1, Length(Path)-1);
    end;
  end;
end;

function TIdNetscapeCookie.GetExpires: TDateTime;
begin
  Result := FExpires;
end;

{
Set-Cookie: NAME=VALUE; expires=DATE;
path=PATH; domain=DOMAIN_NAME; secure; HttpOnly
}
function TIdNetscapeCookie.GetServerCookie: String;
var
  LExpires: TDateTime;
begin
  Result := FName + '=' + FValue;    {Do not Localize}
  AddCookieProperty(Result, 'path', FPath, False);    {Do not Localize}
  LExpires := Expires;
  if LExpires <> 0.0 then begin
    AddCookieProperty(Result, 'expires', LocalDateTimeToCookieStr(LExpires), False);    {Do not Localize}
  end;
  AddCookieProperty(Result, 'domain', FDomain, False);    {Do not Localize}
  if FSecure then begin
    AddCookieFlag(Result, 'secure');    {Do not Localize}
  end;
  if FHttpOnly then begin
    AddCookieFlag(Result, 'HttpOnly');    {Do not Localize}
  end;
end;

procedure TIdNetscapeCookie.SetServerCookie(const AValue: String);
var
  CookieProp: TStringList;
  i, j: Integer;
begin
  CookieProp := TStringList.Create;
  try
    SplitCookieText(AValue, CookieProp);
    Assert(CookieProp.Count > 0);

    FName := CookieProp.Names[0];
    FValue := CookieProp.Values[FName];
    CookieProp.Delete(0);

    for i := 0 to CookieProp.Count - 1 do
    begin
      j := Pos('=', CookieProp[i]);    {Do not Localize}
      CookieProp[i] := UpperCase(CookieProp.Names[i]) + '=' + Copy(CookieProp[i], j+1, MaxInt);    {Do not Localize}
    end;

    LoadProperties(CookieProp);
  finally
    FreeAndNil(CookieProp);
  end;
end;

{
Cookie: NAME1=OPAQUE_STRING1; NAME2=OPAQUE_STRING2 ...
}
function TIdNetscapeCookie.GetClientCookie: String;
begin
  Result := FName + '=' + FValue;
end;

procedure TIdNetscapeCookie.SetClientCookie(const AValue: String);
var
  CookieProp: TStringList;
  PropName: String;
  i, j: Integer;
begin
  CookieProp := TStringList.Create;
  try
    SplitCookieText(AValue, CookieProp);
    Assert(CookieProp.Count > 0);

    FName := CookieProp.Names[0];
    FValue := CookieProp.Values[FName];
    CookieProp.Delete(0);

    for i := 0 to CookieProp.Count - 1 do
    begin
      j := Pos('=', CookieProp[i]);    {Do not Localize}

      PropName := CookieProp.Names[i];
      if CharEquals(PropName, 1, '$') then begin
        IdDelete(PropName, 1, 1);
      end;

      CookieProp[i] := UpperCase(PropName) + '=' + Copy(CookieProp[i], j+1, MaxInt);    {Do not Localize}
    end;

    LoadProperties(CookieProp);
  finally
    FreeAndNil(CookieProp);
  end;
end;

procedure TIdNetscapeCookie.LoadProperties(APropertyList: TStrings);
var
  s: string;
  LSecs: Int64;
begin
  FPath := APropertyList.Values['PATH'];    {Do not Localize}
  if Length(FPath) = 0 then
  begin
    FPath := '/'; {Do not Localize}
  end;

  s := APropertyList.Values['EXPIRES'];    {Do not Localize}
  if IsNumeric(s) then
  begin
    // This happens when expires is an integer number in seconds
    LSecs := IndyStrToInt64(s);
    if LSecs >= 0 then begin
      FExpires := (Now + LSecs * 1000 / MSecsPerDay);
    end else begin
      FExpires := 0.0;
    end;
  end else
  begin
    // If you see an exception here then that means the HTTP server has
    // returned an invalid expires date/time value. The correct format is:
    //
    // Wdy, DD-Mon-YY HH:MM:SS GMT
    FExpires := GMTToLocalDateTime(s);
  end;

  // RLebeau: have encountered one cookie in the 'Set-Cookie' header that
  // includes a port number in the domain, though the RFCs do not indicate
  // this is allowed. RFC 2965 defines an explicit "port" attribute in the
  // 'Set-Cookie2' header for that purpose instead. We'll just strip it off
  // here if present...
  s := APropertyList.Values['DOMAIN'];    {Do not Localize}
  FDomain := Fetch(s, ':');    {Do not Localize}

  FSecure := APropertyList.IndexOfName('SECURE') <> -1;    {Do not Localize}
  FHttpOnly := APropertyList.IndexOfName('HTTPONLY') <> -1;    {Do not Localize}
end;

{ TIdCookieRFC2109 }

constructor TIdCookieRFC2109.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FMaxAge := GFMaxAge;
  FVersion := 0;
end;

procedure TIdCookieRFC2109.Assign(Source: TPersistent);
begin
  if Source is TIdCookieRFC2109 then
  begin
    with TIdCookieRFC2109(Source) do
    begin
      Self.FMaxAge := FMaxAge;
      Self.FVersion := FVersion;
      Self.FComment := FComment;
    end;
  end;
  inherited Assign(Source);
end;

function TIdCookieRFC2109.GetExpires: TDateTime;
begin
  if (Version >= 1) and (FMaxAge >= 0) then begin
    Result := (Now + FMaxAge * 1000 / MSecsPerDay);
  end else begin
    Result := inherited GetExpires;
  end;
end;

function TIdCookieRFC2109.GetMaxAge: Int64;
begin
  if (Version >= 1) and (FMaxAge >= 0) then begin
    Result := FMaxAge;
  end
  else if FExpires <> 0.0 then begin
    Result := Trunc((FExpires - Now) * MSecsPerDay / 1000);
  end else begin
    Result := GFMaxAge;
  end;
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
  if Version >= 1 then
  begin
    Result := '';
    AddCookieProperty(Result, '$Version', IntToStr(Version)); {Do not Localize}
    Result := Result + '; '+ FName + '="' + FValue + '"'; {Do not Localize}
    AddCookieProperty(Result, '$Path', Path); {Do not Localize}
    AddCookieProperty(Result, '$Domain', Domain); {Do not Localize}
  end else begin
    Result := inherited GetClientCookie;
  end;
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
function TIdCookieRFC2109.GetServerCookie: String;
var
  LMaxAge: Int64;
begin
  if FVersion >= 1 then
  begin
    Result := FName + '="' + FValue + '"';    {Do not Localize}
    AddCookieProperty(Result, 'Path', FPath);    {Do not Localize}
    AddCookieProperty(Result, 'Domain', FDomain);    {Do not Localize}
    if FSecure then begin
      AddCookieFlag(Result, 'Secure');    {Do not Localize}
    end;
    if FHttpOnly then begin
      AddCookieFlag(Result, 'HttpOnly');    {Do not Localize}
    end;
    LMaxAge := MaxAge;
    if LMaxAge > -1 then begin
      AddCookieProperty(Result, 'Max-Age', IntToStr(LMaxAge));    {Do not Localize}
    end;
    AddCookieProperty(Result, 'Comment', FComment);    {Do not Localize}
    AddCookieProperty(Result, 'Version', IntToStr(FVersion));    {Do not Localize}
  end else
  begin
    Result := inherited GetServerCookie;
  end;
end;

function TIdCookieRFC2109.IsRejected(AURI: TIdURI): Boolean;
var
  LDomain: String;
  S: string;
begin
  if Version = 1 then
  begin
    Result := True;

    {
    Per RFC 2109:

    To prevent possible security or privacy violations, a user agent
    rejects a cookie (shall not store its information) if any of the
    following is true:

     * The value for the Path attribute is not a prefix of the request-
       URI.
    }

    if not TextStartsWith(AURI.Path, Path) then begin
      Exit;
    end;

    {
     * The value for the Domain attribute contains no embedded dots or
       does not start with a dot.
    }

    LDomain := Domain;
    if not CharEquals(LDomain, 1, '.') then begin
      Exit;
    end;

    LDomain := Copy(LDomain, 2, MaxInt);
    if Pos('.', LDomain) = 0 then begin
      Exit;
    end;

    {
     * The value for the request-host does not domain-match the Domain
       attribute.
    }

    if not IsDomainMatch(AURI.Host, Domain) then begin
      Exit;
    end;

    {
     * The request-host is a FQDN (not IP address) and has the form HD,
       where D is the value of the Domain attribute, and H is a string
       that contains one or more dots.
    }

    if IsHostName(AURI.Host) and TextEndsWith(AURI.Host, Domain) then
    begin
      S := Copy(AURI.Host, 1, Length(AURI.Host)-Length(Domain));
      if Pos('.', S) <> 0 then begin
        Exit;
      end;
    end;

    Result := False;
  end
  else begin
    Result := inherited IsRejected(AURI);
  end;
end;

function TIdCookieRFC2109.MatchesHost(const AHost: String): Boolean;
begin
  Result := IsDomainMatch(AHost, Domain);
end;

procedure TIdCookieRFC2109.ResolveDefaults(AURI: TIdURI);
begin
  if (Length(Domain) = 0) and (Version = 1) and (AURI <> nil) then
  begin
    // RLebeau 8/19/09: this does not make sense to me - RFC 2109 says that
    // the default value of the Domain attribute is just the request host
    // and is not to include a leading dot.  However, its rules for rejecting
    // a cookie require that the Domain attribute have a leading dot!  So what
    // is the correct thing to do here?
    Domain := '.' + AURI.Host; {Do not Localize}
  end;

  inherited ResolveDefaults(AURI);
end;

procedure TIdCookieRFC2109.LoadProperties(APropertyList: TStrings);
begin
  inherited LoadProperties(APropertyList);

  FVersion := IndyStrToInt(APropertyList.Values['VERSION'], 0);    {Do not Localize}
  FMaxAge := IndyStrToInt64(APropertyList.Values['MAX-AGE'], -1);    {Do not Localize}
  FComment := APropertyList.Values['COMMENT'];    {Do not Localize}

  if (FExpires = 0.0) and (FMaxAge >= 0) then begin
    FExpires := (Now + FMaxAge * 1000 / MSecsPerDay);
  end;
end;

procedure TIdCookieRFC2109.SetVersion(const AValue: Integer);
begin
  if AValue >= 0 then begin
    FVersion := AValue;
  end else begin
    FVersion := 0;
  end;
end;

{ TIdCookieRFC2965 }

constructor TIdCookieRFC2965.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  Version := 1;
  SetLength(FPortList, 0);
end;

procedure TIdCookieRFC2965.Assign(Source: TPersistent);
begin
  if Source is TIdCookieRFC2965 then
  begin
    with TIdCookieRFC2965(Source) do
    begin
      Self.FCommentURL := FCommentURL;
      Self.FDiscard := FDiscard;
      Self.FPortList := FPortList;
      Self.FRecvPort := FRecvPort;
      Self.FUsePort := FUsePort;
    end;
  end;
  inherited Assign(Source);
end;

{
  cookie          =  "Cookie:" cookie-version 1*((";" | ",") cookie-value)
  cookie-value    =  NAME "=" VALUE [";" path] [";" domain] [";" port]
  cookie-version  =  "$Version" "=" value
  NAME            =  attr
  VALUE           =  value
  path            =  "$Path" "=" value
  domain          =  "$Domain" "=" value
  port            =  "$Port" [ "=" <"> value <"> ]
}

function TIdCookieRFC2965.GetClientCookie: String;
var
  s: String;
  i: Integer;
begin
  Result := inherited GetClientCookie;

  if FUsePort then
  begin
    if PortCount > 0 then
    begin
      s := IntToStr(PortList[0]);
      for i := 1 to PortCount-1 do begin
        s := s + ',' + IntToStr(PortList[i]); {Do not Localize}
      end;
      AddCookieProperty(Result, '$Port', s); {Do not Localize}
    end else begin
      AddCookieFlag(Result, '$Port'); {Do not Localize}
    end;
  end;
end;

{
  set-cookie      =       "Set-Cookie2:" cookies
  cookies         =       1#cookie
  cookie          =       NAME "=" VALUE *(";" set-cookie-av)
  NAME            =       attr
  VALUE           =       value
  set-cookie-av   =       "Comment" "=" value
                  |       "CommentURL" "=" <"> http_URL <">
                  |       "Discard"
                  |       "Domain" "=" value
                  |       "Max-Age" "=" value
                  |       "Path" "=" value
                  |       "Port" [ "=" <"> portlist <"> ]
                  |       "Secure"
                  |       "Version" "=" 1*DIGIT
  portlist        =       1#portnum
  portnum         =       1*DIGIT
}

function TIdCookieRFC2965.GetServerCookie: String;
var
  s: String;
  i: Integer;
begin
  Result := inherited GetServerCookie;

  AddCookieProperty(Result, 'CommentURL', CommentURL); {Do not Localize}
  if FDiscard then begin
    AddCookieFlag(Result, 'Discard'); {Do not Localize}
  end;
  if FUsePort then
  begin
    if PortCount > 0 then
    begin
      s := IntToStr(PortList[0]);
      for i := 1 to PortCount-1 do begin
        s := s + ',' + IntToStr(PortList[i]); {Do not Localize}
      end;
      AddCookieProperty(Result, 'Port', s); {Do not Localize}
    end else begin
      AddCookieFlag(Result, 'Port'); {Do not Localize}
    end;
  end;
end;

function TIdCookieRFC2965.IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean;
begin
  Result := IsPortMatch(Self, AURI.Port) and (inherited IsAllowed(AURI, SecureOnly));
end;

function TIdCookieRFC2965.IsRejected(AURI: TIdURI): Boolean;
var
  LDomain: String;
  S: string;
begin
  Result := True;

  {
  Per RFC 2965:

  A user agent rejects (SHALL NOT store its information) if the Version
  attribute is missing...
  }

  if Version <> 1 then begin
    Exit;
  end;

  {
                     ...Moreover, a user agent rejects (SHALL NOT
  store its information) if any of the following is true of the
  attributes explicitly present in the Set-Cookie2 response header:

    *  The value for the Path attribute is not a prefix of the
       request-URI.
  }

  if not TextStartsWith(AURI.Path, Path) then begin
    Exit;
  end;

  {
    *  The value for the Domain attribute contains no embedded dots,
       and the value is not .local.
  }

  LDomain := Domain;
  if CharEquals(LDomain, 1, '.') then begin
    LDomain := Copy(LDomain, 2, MaxInt);
  end;

  if (Pos('.', LDomain) = 0) and (not TextIsSame(Domain, '.local')) then begin
    Exit;
  end;

  {
    *  The effective host name that derives from the request-host does
       not domain-match the Domain attribute.
  }

  if not IsDomainMatch(EffectiveHostName(AURI.Host), Domain) then begin
    Exit;
  end;

  {
    *  The request-host is a HDN (not IP address) and has the form HD,
       where D is the value of the Domain attribute, and H is a string
       that contains one or more dots.
  }

  if IsHostName(AURI.Host) and TextEndsWith(AURI.Host, Domain) then
  begin
    S := Copy(AURI.Host, 1, Length(AURI.Host)-Length(Domain));
    if Pos('.', S) <> 0 then begin
      Exit;
    end;
  end;

  {
    *  The Port attribute has a "port-list", and the request-port was
       not in the list.
  }

  if not IsPortMatch(Self, AURI.Port) then begin
    Exit;
  end;

  Result := False;
end;

function TIdCookieRFC2965.MatchesHost(const AHost: String): Boolean;
begin
  Result := IsDomainMatch(EffectiveHostName(AHost), Domain);
end;

procedure TIdCookieRFC2965.ResolveDefaults(AURI: TIdURI);
begin
  if Length(Domain) = 0 then
  begin
    if AURI <> nil then begin
      Domain := '.' + EffectiveHostName(AURI.Host); {Do not Localize}
    end;
  end
  else if not TextStartsWith(Domain, '.') then begin {do not localize}
    Domain := '.' + Domain; {do not localize}
  end;

  if (Length(Path) = 0) and (AURI <> nil) then begin
    Path := AURI.Path;
  end;

  if (FExpires = 0.0) and (FMaxAge < 0) then begin
    FDiscard := True;
  end;
end;

procedure TIdCookieRFC2965.LoadProperties(APropertyList: TStrings);
var
  LPortList: TStringList;
  i: Integer;
  S: String;
begin
  SetLength(FPortList, 0);
  inherited LoadProperties(APropertyList);

  FCommentURL := APropertyList.Values['COMMENTURL'];      {Do not Localize}
  FDiscard := APropertyList.IndexOfName('DISCARD') <> -1; {Do not Localize}
  FUsePort := APropertyList.IndexOfName('PORT') <> -1;    {Do not Localize}

  if FUsePort then
  begin
    S := APropertyList.Values['PORT'];    {Do not Localize}
    if Length(S) > 0 then
    begin
      LPortList := TStringList.Create;
      try
        LPortList.CommaText := S;
        SetLength(FPortList, LPortList.Count);
        for i := 0 to LPortList.Count - 1 do
        begin
          PortList[i] := IndyStrToInt(LPortList[i]);
        end;
      finally
        LPortList.Free;
      end;
    end;
  end;
end;

procedure TIdCookieRFC2965.SetPort(AIndex: Integer; AValue: TIdPort);
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

function TIdCookieRFC2965.GetPortCount: Integer;
begin
  Result := Length(FPortList);
end;

function TIdCookieRFC2965.GetPort(AIndex: Integer): TIdPort;
begin
  if (AIndex > High(FPortList)) or (AIndex < Low(FPortList)) then
  begin
    raise EIdException.Create('Index out of range.');    {Do not Localize}
  end;
  Result := FPortList[AIndex];
end;

procedure TIdCookieRFC2965.SetVersion(const AValue: Integer);
begin
  if AValue >= 1 then begin
    FVersion := AValue;
  end else begin
    FVersion := 1;
  end;
end;

{ TIdCookies }

constructor TIdCookies.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdCookieRFC2109);
  FRWLock := TMultiReadExclusiveWriteSynchronizer.Create;
  FCookieList := TIdCookieList.Create;
end;

destructor TIdCookies.Destroy;
begin
  // This will force the Cookie removing process before we free FCookieList and FRWLock
  Self.Clear;
  FreeAndNil(FCookieList);
  FreeAndNil(FRWLock);
  inherited Destroy;
end;

procedure TIdCookies.AddCookie(ACookie: TIdNetscapeCookie);
var
  LCookieList: TIdCookieList;
  LOldCookie: TIdNetscapeCookie;
  LIndex: Integer;
begin
  LCookieList := LockCookieList(caReadWrite);
  try
    LIndex := LCookieList.IndexOf(ACookie.CookieName);
    if LIndex = -1 then
    begin
      LCookieList.AddObject(ACookie.CookieName, ACookie);
    end else
    begin
      LOldCookie := LCookieList.Cookies[LIndex];
      LCookieList.Objects[LIndex] := ACookie;
      LOldCookie.Collection := nil;
      LOldCookie.Free;
    end;
  finally
    UnlockCookieList(caReadWrite);
  end;
end;

procedure TIdCookies.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource is TIdCookies) then
  begin
    LockCookieList(caReadWrite);
    try
      Clear;
      AddCookies(TIdCookies(ASource));
    finally
      UnlockCookieList(caReadWrite);
    end;
  end else begin
    inherited Assign(ASource);
  end;
end;

function TIdCookies.GetItem(Index: Integer): TIdNetscapeCookie;
begin
  Result := inherited GetItem(Index) as TIdNetscapeCookie;
end;

procedure TIdCookies.SetItem(Index: Integer; const Value: TIdNetscapeCookie);
begin
  inherited SetItem(Index, Value);
end;

function TIdCookies.Add: TIdCookieRFC2109;
begin
  Result := TIdCookieRFC2109.Create(Self);
end;

function TIdCookies.Add2: TIdCookieRFC2965;
begin
  Result := TIdCookieRFC2965.Create(Self);
end;

function TIdCookies.AddClientCookie(const ACookie: string): TIdCookieRFC2109;
begin
  Result := Add;
  try
    Result.ClientCookie := ACookie;
    AddCookie(Result);
  except
    Result.Collection := nil;
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdCookies.AddClientCookie2(const ACookie: string): TIdCookieRFC2965;
begin
  Result := Add2;
  try
    Result.ClientCookie := ACookie;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdCookies.AddClientCookies(const ACookies: string);
var
  LCookies, LCookie: String;
  LVersion: Integer;
  LParts: TStringList;
begin
  LVersion := 0;
  LCookies := ACookies;
  while ExtractNextCookie(LCookies, LCookie, False) do
  begin
    if LCookie[1] = '$' then {Do not Localize}
    begin
      LParts := TStringList.Create;
      try
        SplitCookieText(LCookie, LParts);
        if TextIsSame(LParts.Names[0], '$Version') then begin {Do not Localize}
          LVersion := IndyStrToInt(LParts.Values['$Version']); {Do not Localize}
        end;
      finally
        LParts.Free;
      end;
    end else
    begin
      with AddClientCookie(LCookie) do
      begin
        if Version < 1 then begin
          Version := LVersion;
        end;
      end;
    end;
  end;
end;

procedure TIdCookies.AddClientCookies(const ACookies: TStrings);
var
  I: Integer;
begin
  for I := 0 to ACookies.Count-1 do begin
    AddClientCookies(ACookies[I]);
  end;
end;

procedure TIdCookies.AddClientCookies2(const ACookies: string);
var
  LCookies, LCookie: String;
  LVersion: Integer;
  LParts: TStringList;
begin
  LVersion := 0;
  LCookies := ACookies;
  while ExtractNextCookie(LCookies, LCookie, False) do
  begin
    if LCookie[1] = '$' then {Do not Localize}
    begin
      LParts := TStringList.Create;
      try
        SplitCookieText(LCookie, LParts);
        if TextIsSame(LParts.Names[0], '$Version') then begin {Do not Localize}
          LVersion := IndyStrToInt(LParts.Values['$Version']); {Do not Localize}
        end;
      finally
        LParts.Free;
      end;
    end else
    begin
      with AddClientCookie2(LCookie) do
      begin
        if Version < 1 then begin
          Version := LVersion;
        end;
      end;
    end;
  end;
end;

procedure TIdCookies.AddClientCookies2(const ACookies: TStrings);
var
  I: Integer;
begin
  for I := 0 to ACookies.Count-1 do begin
    AddClientCookies2(ACookies[I]);
  end;
end;

function TIdCookies.AddServerCookie(const ACookie: string; AURI: TIdURI): TIdCookieRFC2109;
begin
  Result := Add;
  try
    Result.ServerCookie := ACookie;
    Result.ResolveDefaults(AURI);
    AddCookie(Result);
  except
    Result.Collection := nil;
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdCookies.AddServerCookie2(const ACookie: string; AURI: TIdURI): TIdCookieRFC2965;
begin
  Result := Add2;
  try
    Result.ServerCookie := ACookie;
    Result.ResolveDefaults(AURI);
    AddCookie(Result);
  except
    Result.Collection := nil;
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdCookies.AddServerCookies(const ACookies: string; AURI: TIdURI);
var
  LCookies, LCookie: String;
begin
  LCookies := ACookies;
  while ExtractNextCookie(LCookies, LCookie, True) do begin
    AddServerCookie(LCookie, AURI);
  end;
end;

procedure TIdCookies.AddServerCookies(const ACookies: TStrings; AURI: TIdURI);
var
  I: Integer;
begin
  for I := 0 to ACookies.Count-1 do begin
    AddServerCookies(ACookies[I], AURI);
  end;
end;

procedure TIdCookies.AddCookies(ASource: TIdCookies);
var
  LSrcCookies: TIdCookieList;
  LSrcCookie: TIdNetscapeCookie;
  LDestCookie: TIdNetscapeCookie;
  I: Integer;
begin
  if (ASource <> nil) and (ASource <> Self) then
  begin
    LSrcCookies := ASource.LockCookieList(caRead);
    try
      LockCookieList(caReadWrite);
      try
        for I := 0 to LSrcCookies.Count-1 do
        begin
          LSrcCookie := LSrcCookies.Cookies[I];
          LDestCookie := TIdNetscapeCookieClass(LSrcCookie.ClassType).Create(Self);
          try
            LDestCookie.Assign(LSrcCookie);
            AddCookie(LDestCookie);
          except
            LDestCookie.Collection := nil;
            LDestCookie.Free;
            raise;
          end;
        end;
      finally
        UnlockCookieList(caReadWrite);
      end;
    finally
      ASource.UnlockCookieList(caRead);
    end;
  end;
end;

function TIdCookies.GetCookie(const AName, AHost: string): TIdNetscapeCookie;
var
  i: Integer;
begin
  i := GetCookieIndex(0, AName, AHost);
  if i = -1 then begin
    Result := nil;
  end else begin
    Result := Items[i];
  end;
end;

function TIdCookies.GetCookieIndex(FirstIndex: Integer; const AName, AHost: string): Integer;
var
  i: Integer;
  LCookie: TIdNetscapeCookie;
begin
  Result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    LCookie := Items[i];
    if LCookie.MatchesHost(AHost) and
      TextIsSame(LCookie.CookieName, AName) then
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

procedure TIdCookies.Clear;
begin
  LockCookieList(caReadWrite);
  try
    FCookieList.Clear;
    inherited Clear;
  finally
    UnlockCookieList(caReadWrite);
  end;
end;

function TIdCookies.LockCookieList(AAccessType: TIdCookieAccess): TIdCookieList;
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
  Result := FCookieList;
end;

procedure TIdCookies.UnlockCookieList(AAccessType: TIdCookieAccess);
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

end.
