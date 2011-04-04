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

  TIdNetscapeCookie - The base code used in all cookies. It implements cookies
  as proposed by Netscape

  TIdCookieRFC2109 - The RFC 2109 implmentation. Not used too much.

  TIdCookieRFC2965 - The RFC 2965 implmentation. Not used yet or at least I don't
    know any HTTP server that supports this specification.

REFERENCES
-------------------
 [Netscape] "Persistent Client State -- HTTP Cookies",
            originally available at <http://www.netscape.com/newsref/std/cookie_spec.html>,
            now at <http://curl.haxx.se/rfc/cookie_spec.html>,
            undated.

 [RFC2109]  Kristol, D. and L. Montulli, "HTTP State Management Mechanism",
            RFC 2109, February 1997.

 [RFC2965]  Kristol, D. and L. Montulli, "HTTP State Management Mechanism",
            RFC 2965, October 2000.

 [ERRATA]   Kristol, D, "Errata to RFC 2965, HTTP State Management",
            May 16, 2003,
            http://kristol.org/cookie/errata.html

 [DRAFT-COOKIE-23] Barth, A, "HTTP State Management Mechanism",
            Internet-Draft, March 1, 2011.
            http://www.ietf.org/id/draft-ietf-httpstate-cookie-23.txt

 [DRAFT-ORIGIN-01] Pettersen, Y, "Identifying origin server of HTTP Cookies",
            Internet-Draft, March 07, 2010.
            http://www.ietf.org/id/draft-pettersen-cookie-origin-01.txt

 [DRAFT-COOKIEv2-05] Pettersen, Y, "HTTP State Management Mechanism v2",
            Internet-Draft, March 07, 2010.
            http://www.ietf.org/id/draft-pettersen-cookie-v2-05.txt
}

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdException, IdGlobalProtocols, IdURI, SysUtils;

type
  TIdCookie = class;

  TIdCookieList = class(TList)
  protected
    function GetCookie(Index: Integer): TIdCookie;
    procedure SetCookie(Index: Integer; AValue: TIdCookie);
  public
    function IndexOfCookie(ACookie: TIdCookie): Integer;
    property Cookies[Index: Integer]: TIdCookie read GetCookie write SetCookie; default;
  end;

  { Base Cookie class as described in [draft-23] }
  TIdCookie = class(TCollectionItem)
  protected
    FDomain: String;
    FExpires: TDateTime;
    FHttpOnly: Boolean;
    FName: String;
    FPath: String;
    FSecure: Boolean;
    FValue: String;
    FCreatedAt: TDateTime;
    FHostOnly: Boolean;
    FLastAccessed: TDateTime;
    FPersistent: Boolean;

    function GetIsExpired: Boolean;

    function GetServerCookie: String; virtual;
    function GetClientCookie: String; virtual;

    function GetMaxAge: Int64;

  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    function IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean; virtual;

    function ParseClientCookie(const ACookieText: String): Boolean; virtual;
    function ParseServerCookie(const ACookieText: String; AURI: TIdURI): Boolean; virtual;

    property ClientCookie: String read GetClientCookie;
    property CookieName: String read FName write FName;
    property CookieText: String read GetServerCookie; // {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPECATED_MSG} 'Use ServerCookie property instead'{$ENDIF};{$ENDIF}
    property Domain: String read FDomain write FDomain;
    property Expires: TDateTime read FExpires write FExpires;
    property HttpOnly: Boolean read FHttpOnly write FHttpOnly;
    property Path: String read FPath write FPath;
    property Secure: Boolean read FSecure write FSecure;
    property ServerCookie: String read GetServerCookie;
    property Value: String read FValue write FValue;

    property MaxAge: Int64 read GetMaxAge;

    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property IsExpired: Boolean read GetIsExpired;
    property HostOnly: Boolean read FHostOnly write FHostOnly;
    property LastAccessed: TDateTime read FLastAccessed write FLastAccessed;
    property Persistent: Boolean read FPersistent write FPersistent;
  end;

  TIdCookieClass = class of TIdCookie;

  { The Cookie collection }

  TIdCookieAccess = (caRead, caReadWrite);

  TIdCookies = class(TOwnedCollection)
  protected
    FCookieList: TIdCookieList;
    FRWLock: TMultiReadExclusiveWriteSynchronizer;

    function GetCookieByNameAndDomain(const AName, ADomain: string): TIdCookie;
    function GetCookie(Index: Integer): TIdCookie;
    procedure SetCookie(Index: Integer; const Value: TIdCookie);

  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;

    function Add: TIdCookie; reintroduce;
    function AddCookie(ACookie: TIdCookie; AURI: TIdURI; AReplaceOld: Boolean = True): Boolean;

    function AddClientCookie(const ACookie: string): TIdCookie;
    procedure AddClientCookies(const ACookie: string); overload;
    procedure AddClientCookies(const ACookies: TStrings); overload;

    function AddServerCookie(const ACookie: string; AURI: TIdURI): TIdCookie;
    procedure AddServerCookies(const ACookies: TStrings; AURI: TIdURI);

    procedure AddCookies(ASource: TIdCookies);

    procedure Assign(ASource: TPersistent); override;
    procedure Clear; reintroduce;

    function GetCookieIndex(const AName: string; FirstIndex: Integer = 0): Integer; overload;
    function GetCookieIndex(const AName, ADomain: string; FirstIndex: integer = 0): Integer; overload;

    function LockCookieList(AAccessType: TIdCookieAccess): TIdCookieList;
    procedure UnlockCookieList(AAccessType: TIdCookieAccess);

    property Cookie[const AName, ADomain: string]: TIdCookie read GetCookieByNameAndDomain;
    property Cookies[Index: Integer]: TIdCookie read GetCookie write SetCookie; Default;
  end;

  EIdCookieError = class(EIdException);

function IsDomainMatch(const AUriHost, ACookieDomain: String): Boolean;
function IsPathMatch(const AUriPath, ACookiePath: String): Boolean;

function CanonicalizeHostName(const AHost: String): String;

implementation

uses
  IdAssignedNumbers, IdResourceStringsProtocols;

function GetDefaultPath(const AURL: TIdURI): String;
begin
  if not TextStartsWith(AURL.Path, '/') then begin {do not localize}
    Result := '/'; {do not localize}
  end
  else if AURL.Path = '/' then begin {do not localize}
    Result := '/'; {do not localize}
  end else begin
    Result := Copy(AURL.Path, 1, RPos('/', AURL.Path)-1);
  end;
end;

function CanonicalizeHostName(const AHost: String): String;
begin
  // TODO: implement this
  {
  Per draft-23 Section 5.1.2:

   1.  Convert the host name to a sequence of individual domain name
       labels.

   2.  Convert each label that is not a NR-LDH label, to a A-label (see
       Section 2.3.2.1 of [RFC5890] for the fomer and latter), or to a
       "punycode label" (a label resulting from the "ToASCII" conversion
       in Section 4 of [RFC3490]), as appropriate (see Section 6.3 of
       this specification).

   3.  Concatentate the resulting labels, separated by a %x2E (".")
       character.
  }
  Result := AHost;
end;

function IsDomainMatch(const AUriHost, ACookieDomain: String): Boolean;
var
  LHost, LDomain: String;
begin
  {
  Per draft-23 Section 5.1.3:

   A string domain-matches a given domain string if at least one of the
   following conditions hold:

   o  The domain string and the string are identical.  (Note that both
      the domain string and the string will have been canonicalized to
      lower case at this point.)

   o  All of the following conditions hold:

      *  The domain string is a suffix of the string.

      *  The last character of the string that is not included in the
         domain string is a %x2E (".") character.

      *  The string is a host name (i.e., not an IP address).
  }

  Result := False;
  LHost := CanonicalizeHostName(AUriHost);
  LDomain := CanonicalizeHostName(ACookieDomain);
  if (LHost <> '') and (LDomain <> '') then begin
    if TextIsSame(LHost, LDomain) then begin
      Result := True;
    end
    else if TextEndsWith(LHost, LDomain) then
    begin
      if TextEndsWith(Copy(LHost, 1, Length(LHost)-Length(LDomain)), '.') then begin
        Result := IsHostName(LHost);
      end;
    end;
  end;
end;

function IsPathMatch(const AUriPath, ACookiePath: String): Boolean;
begin
  {
  Per draft-23 Section 5.1.4:

   A request-path path-matches a given cookie-path if at least one of
   the following conditions hold:

   o  The cookie-path and the request-path are identical.

   o  The cookie-path is a prefix of the request-path and the last
      character of the cookie-path is %x2F ("/").

   o  The cookie-path is a prefix of the request-path and the first
      character of the request-path that is not included in the cookie-
      path is a %x2F ("/") character.
  }
  Result := TextIsSame(AUriPath, ACookiePath) or
            (
              TextStartsWith(AUriPath, ACookiePath) and
              (
                TextEndsWith(ACookiePath, '/') or
                CharEquals(AUriPath, Length(ACookiePath)+1, '/')
              )
            );
end;

function IsHTTP(const AProtocol: String): Boolean;
begin
  Result := PosInStrArray(AProtocol, ['http', 'https'], False) <> -1; {do not localize}
end;

{ base functions used for construction of Cookie text }

procedure AddCookieProperty(var VCookie: String;
  const AProperty, AValue: String);
begin
  if Length(AValue) > 0 then
  begin
    if Length(VCookie) > 0 then begin
      VCookie := VCookie + '; '; {Do not Localize}
    end;
    // TODO: encode illegal characters?
    VCookie := VCookie + AProperty + '=' + AValue; {Do not Localize}
  end;
end;

procedure AddCookieFlag(var VCookie: String; const AFlag: String);
begin
  if Length(VCookie) > 0 then begin
    VCookie := VCookie + '; '; { Do not Localize }
  end;
  VCookie := VCookie + AFlag;
end;

{ TIdCookieList }

function TIdCookieList.GetCookie(Index: Integer): TIdCookie;
begin
  Result := TIdCookie(Items[Index]);
end;

procedure TIdCookieList.SetCookie(Index: Integer; AValue: TIdCookie);
begin
  Items[Index] := AValue;
end;

function TIdCookieList.IndexOfCookie(ACookie: TIdCookie): Integer;
begin
  for Result := 0 to Count - 1 do
  begin
    if GetCookie(Result) = ACookie then begin
      Exit;
    end;
  end;
  Result := -1;
end;

{ TIdCookie }

constructor TIdCookie.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FCreatedAt := Now;
  FLastAccessed := FCreatedAt;
end;

destructor TIdCookie.Destroy;
var
  LCookieList: TIdCookieList;
begin
  try
    if Assigned(Collection) then
    begin
      LCookieList := TIdCookies(Collection).LockCookieList(caReadWrite);
      try
        LCookieList.Remove(Self);
      finally
        TIdCookies(Collection).UnlockCookieList(caReadWrite);
      end;
    end;
  finally
    inherited Destroy;
  end;
end;

procedure TIdCookie.Assign(Source: TPersistent);
begin
  if Source is TIdCookie then
  begin
    with TIdCookie(Source) do
    begin
      Self.FDomain := FDomain;
      Self.FExpires := FExpires;
      Self.FHttpOnly := FHttpOnly;
      Self.FName := FName;
      Self.FPath := FPath;
      Self.FSecure := FSecure;
      Self.FValue := FValue;
      Self.FCreatedAt := FCreatedAt;
      Self.FHostOnly := FHostOnly;
      Self.FLastAccessed := FLastAccessed;
      Self.FPersistent := FPersistent;
    end;
  end else
  begin
    inherited Assign(Source);
  end;
end;

function TIdCookie.IsAllowed(AURI: TIdURI; SecureOnly: Boolean): Boolean;

  function MatchesHost: Boolean;
  begin
    if HostOnly then begin
      Result := TextIsSame(CanonicalizeHostName(AURI.Host), Domain);
    end else begin
      Result := IsDomainMatch(AURI.Host, Domain);
    end;
  end;

begin
  // using the algorithm defined in draft-23 section 5.4...
  Result := MatchesHost and IsPathMatch(AURI.Path, Path) and
            ((not Secure) or (Secure and SecureOnly)) and
            ((not HttpOnly) or (HttpOnly and IsHTTP(AURI.Protocol)));
end;

{$IFNDEF HAS_TryStrToInt64}
function TryStrToInt64(const S: string; out Value: Int64): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;
{$ENDIF}

function TIdCookie.ParseServerCookie(const ACookieText: String; AURI: TIdURI): Boolean;
const
  cTokenSeparators = '()<>@,;:\"/[]?={} '#9;
var
  CookieProp: TStringList;
  S: string;
  LSecs: Int64;

  procedure SplitCookieText;
  var
    LNameValue, LAttrs, LAttr, LName, LValue: String;
    LExpiryTime: TDateTime;
    i: Integer;
  begin
    I := Pos(';', ACookieText);
    if I > 0 then
    begin
      LNameValue := Copy(ACookieText, 1, I-1);
      LAttrs := Copy(ACookieText, I, MaxInt);
    end else
    begin
      LNameValue := ACookieText;
      LAttrs := '';
    end;

    I := Pos('=', LNameValue);
    if I = 0 then begin
      Exit;
    end;

    LName := Trim(Copy(LNameValue, 1, I-1));
    if LName = '' then begin
      Exit;
    end;

    LValue := Trim(Copy(LNameValue, I+1, MaxInt));
    if TextStartsWith(LValue, '"') then begin
      IdDelete(LValue, 1, 1);
      LNameValue := LValue;
      LValue := Fetch(LNameValue, '"');
    end;
    CookieProp.Add(LName + '=' + LValue);

    while LAttrs <> '' do
    begin
      IdDelete(LAttrs, 1, 1);
      I := Pos(';', LAttrs);
      if I > 0 then begin
        LAttr := Copy(LAttrs, 1, I-1);
        LAttrs := Copy(LAttrs, I, MaxInt);
      end else begin
        LAttr := LAttrs;
        LAttrs := '';
      end;
      I := Pos('=', LAttr);
      if I > 0 then begin
        LName := Trim(Copy(LAttr, 1, I-1));
        LValue := Trim(Copy(LAttr, I+1, MaxInt));
        // RLebeau: draft-23 does not (yet?) account for quoted attribute
        // values, despite several complaints asking for it.  We'll do it
        // anyway in the hopes that the draft will "do the right thing" by
        // the time it is finalized...
        if TextStartsWith(LValue, '"') then begin
          IdDelete(LValue, 1, 1);
          LNameValue := LValue;
          LValue := Fetch(LNameValue, '"');
        end;
      end else begin
        LName := Trim(LAttr);
        LValue := '';
      end;

      case PosInStrArray(LName, ['Expires', 'Max-Age', 'Domain', 'Path', 'Secure', 'HttpOnly'], False) of
        0: begin
          if TryStrToInt64(LValue, LSecs) then begin
            // Not in the RFCs, but some servers specify Expires as an
            // integer number in seconds instead of using Max-Age...
            if LSecs >= 0 then begin
              LExpiryTime := (Now + LSecs * 1000 / MSecsPerDay);
            end else begin
              LExpiryTime := EncodeDate(1, 1, 1);
            end;
            CookieProp.Add('EXPIRES=' + FloatToStr(LExpiryTime));
          end else
          begin
            LExpiryTime := CookieStrToLocalDateTime(LValue);
            if LExpiryTime <> 0.0 then begin
              CookieProp.Add('EXPIRES=' + FloatToStr(LExpiryTime));
            end;
          end;
        end;
        1: begin
          if TryStrToInt64(LValue, LSecs) then begin
            if LSecs >= 0 then begin
              LExpiryTime := (Now + LSecs * 1000 / MSecsPerDay);
            end else begin
              LExpiryTime := EncodeDate(1, 1, 1);
            end;
            CookieProp.Add('MAX-AGE=' + FloatToStr(LExpiryTime));
          end;
        end;
        2: begin
          if LValue <> '' then begin
            if TextStartsWith(LValue, '.') then begin {do not localize}
              LValue := Copy(LValue, 2, MaxInt);
            end;
            // RLebeau: have encountered one cookie in the 'Set-Cookie' header that
            // includes a port number in the domain, though the RFCs do not indicate
            // this is allowed. RFC 2965 defines an explicit "port" attribute in the
            // 'Set-Cookie2' header for that purpose instead. We'll just strip it off
            // here if present...
            I := Pos(':', LValue);
            if I > 0 then begin
              LValue := Copy(S, 1, I-1);
            end;
            CookieProp.Add('DOMAIN=' + LowerCase(LValue));
          end;
        end;
        3: begin
          if (LValue = '') or (not TextStartsWith(LValue, '/')) then begin
            LValue := GetDefaultPath(AURI);
          end;
          CookieProp.Add('PATH=' + LValue);
        end;
        4: begin
          CookieProp.Add('SECURE=');
        end;
        5: begin
          CookieProp.Add('HTTPONLY=');
        end;
      end;
    end;
  end;

  function GetLastValueOf(const AName: String; var VValue: String): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := CookieProp.Count-1 downto 0 do
    begin
      if TextIsSame(CookieProp.Names[I], AName) then
      begin
        {$IFDEF HAS_TStrings_ValueFromIndex}
        VValue := CookieProp.ValueFromIndex[I];
        {$ELSE}
        VValue := Copy(CookieProp[I], Pos('=', CookieProp[I])+1, MaxInt); {Do not Localize}
        {$ENDIF}
        Result := True;
        Exit;
      end;
    end;
  end;

begin
  Result := False;

  // using the algorithm defined in draft-23 section 5.1.3...

  CookieProp := TStringList.Create;
  try
    SplitCookieText;
    if CookieProp.Count = 0 then begin
      Exit;
    end;

    FName := CookieProp.Names[0];
    {$IFDEF HAS_TStrings_ValueFromIndex}
    FValue := CookieProp.ValueFromIndex[0];
    {$ELSE}
    S := CookieProp[0];
    FValue := Copy(S, Pos('=', S)+1, MaxInt);
    {$ENDIF}
    CookieProp.Delete(0);

    FCreatedAt := Now;
    FLastAccessed := FCreatedAt;

    // using the algorithms defined in draft-23 section 5.3...

    if GetLastValueOf('MAX-AGE', S) then begin {Do not Localize}
      FPersistent := True;
      FExpires := StrToFloat(S);
    end
    else if GetLastValueOf('EXPIRES', S) then {Do not Localize}
    begin
      FPersistent := True;
      FExpires := StrToFloat(S);
    end else
    begin
      FPersistent := False;
      FExpires := EncodeDate(9999, 12, 31) + EncodeTime(23, 59, 59, 999);
    end;

    if GetLastValueOf('DOMAIN', S) then {Do not Localize}
    begin
      // TODO
      {
        If the user agent is configured to reject "public suffixes" and
        the domain-attribute is a public suffix:

           If the domain-attribute is identical to the canonicalized
           request-host:

              Let the domain-attribute be the empty string.

           Otherwise:

              Ignore the cookie entirely and abort these steps.

           NOTE: A "public suffix" is a domain that is controlled by a
           public registry, such as "com", "co.uk", and "pvt.k12.wy.us".
           This step is essential for preventing attacker.com from
           disrupting the integrity of example.com by setting a cookie
           with a Domain attribute of "com".  Unfortunately, the set of
           public suffixes (also known as "registry controlled domains")
           changes over time.  If feasible, user agents SHOULD use an
           up-to-date public suffix list, such as the one maintained by
           the Mozilla project at <http://publicsuffix.org/>.
      }
    end;

    if Length(S) > 0 then
    begin
      if not IsDomainMatch(AURI.Host, S) then begin
        Exit;
      end;
      FHostOnly := False;
      FDomain := S;
    end else
    begin
      FHostOnly := True;
      FDomain := CanonicalizeHostName(AURI.Host);
    end;

    if GetLastValueOf('PATH', S) then begin {Do not Localize}
      FPath := S;
    end else begin
      FPath := GetDefaultPath(AURI);
    end;

    FSecure := CookieProp.IndexOfName('SECURE') <> -1; { Do not Localize }
    FHttpOnly := CookieProp.IndexOfName('HTTPONLY') <> -1; { Do not Localize }

    if FHttpOnly and (not IsHTTP(AURI.Protocol)) then begin
      Exit;
    end;

    Result := True;
  finally
    FreeAndNil(CookieProp);
  end;
end;

function TIdCookie.GetIsExpired: Boolean;
begin
  Result := (FExpires <> 0.0) and (FExpires < Now);
end;

function TIdCookie.GetMaxAge: Int64;
begin
  if FExpires <> 0.0 then begin
    Result := Trunc((FExpires - Now) * MSecsPerDay / 1000);
  end else begin
    Result := -1;
  end;
end;

{
 set-cookie-header = "Set-Cookie:" SP set-cookie-string
 set-cookie-string = cookie-pair *( ";" SP cookie-av )
 cookie-pair       = cookie-name "=" cookie-value
 cookie-name       = token
 cookie-value      = *cookie-octet / ( DQUOTE *cookie-octet DQUOTE )
 cookie-octet      = %x21 / %x23-2B / %x2D-3A / %x3C-5B / %x5D-7E
                       ; US-ASCII characters excluding CTLs,
                       ; whitespace DQUOTE, comma, semicolon,
                       ; and backslash
 token             = <token, defined in [RFC2616], Section 2.2>

 cookie-av         = expires-av / max-age-av / domain-av /
                     path-av / secure-av / httponly-av /
                     extension-av
 expires-av        = "Expires=" sane-cookie-date
 sane-cookie-date  = <rfc1123-date, defined in [RFC2616], Section 3.3.1>
 max-age-av        = "Max-Age=" non-zero-digit *DIGIT
                       ; In practice, both expires-av and max-age-av
                       ; are limited to dates representable by the
                       ; user agent.
 non-zero-digit    = %x31-39
                       ; digits 1 through 9
 domain-av         = "Domain=" domain-value
 domain-value      = <subdomain>
                       ; defined in [RFC1034], Section 3.5, as
                       ; enhanced by [RFC1123], Section 2.1
 path-av           = "Path=" path-value
 path-value        = <any CHAR except CTLs or ";">
 secure-av         = "Secure"
 httponly-av       = "HttpOnly"
 extension-av      = <any CHAR except CTLs or ";">
}
function TIdCookie.GetServerCookie: String;
var
  LExpires: TDateTime;
  LMaxAge: Int64;
begin
  Result := FName + '=' + FValue; {Do not Localize}
  AddCookieProperty(Result, 'Path', FPath); {Do not Localize}
  AddCookieProperty(Result, 'Domain', FDomain); {Do not Localize}
  if FSecure then begin
    AddCookieFlag(Result, 'Secure'); {Do not Localize}
  end;
  if FHttpOnly then begin
    AddCookieFlag(Result, 'HttpOnly'); {Do not Localize}
  end;
  LMaxAge := MaxAge;
  if LMaxAge >= 0 then begin
    AddCookieProperty(Result, 'Max-Age', IntToStr(LMaxAge)); {Do not Localize}
  end;
  LExpires := Expires;
  if LExpires <> 0.0 then begin
    AddCookieProperty(Result, 'Expires', LocalDateTimeToCookieStr(LExpires)); {Do not Localize}
  end;
end;

{
  Cookie: NAME1=OPAQUE_STRING1; NAME2=OPAQUE_STRING2 ...
}
function TIdCookie.GetClientCookie: String;
begin
  Result := FName + '=' + FValue;
end;

{
   cookie-header = "Cookie:" OWS cookie-string OWS
   cookie-string = cookie-pair *( ";" SP cookie-pair )
}
function TIdCookie.ParseClientCookie(const ACookieText: String): Boolean;
var
  CookieProp: TStringList;

  procedure SplitCookieText;
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
        CookieProp.Add(LTemp);
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
        CookieProp.Add(LName + '=' + LValue);    {Do not Localize}
      end;
    end;
end;

begin
  Result := False;

  CookieProp := TStringList.Create;
  try
    SplitCookieText;
    if CookieProp.Count = 0 then begin
      Exit;
    end;

    FName := CookieProp.Names[0];
    {$IFDEF HAS_TStrings_ValueFromIndex}
    FValue := CookieProp.ValueFromIndex[0];
    {$ELSE}
    FValue := Copy(CookieProp[0], Pos('=', CookieProp[0])+1, MaxInt);
    {$ENDIF}

    Result := True;
  finally
    FreeAndNil(CookieProp);
  end;
end;

{ TIdCookies }

constructor TIdCookies.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdCookie);
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

function TIdCookies.Add: TIdCookie;
begin
  Result := TIdCookie(inherited Add);
end;

function TIdCookies.AddCookie(ACookie: TIdCookie; AURI: TIdURI; AReplaceOld: Boolean = True): Boolean;
var
  LOldCookie: TIdCookie;
  I: Integer;
begin
  Result := False;
  LockCookieList(caReadWrite);
  try
    if AReplaceOld then
    begin
      for I := 0 to FCookieList.Count-1 do
      begin
        LOldCookie := FCookieList[I];
        if not TextIsSame(LOldCookie.CookieName, ACookie.CookieName) then begin
          Continue;
        end;
        if not TextIsSame(LOldCookie.Domain, ACookie.Domain) then begin
          Continue;
        end;
        if not TextIsSame(LOldCookie.Path, ACookie.Path) then begin
          Continue;
        end;
        if ((AURI <> nil) and (not IsHTTP(AURI.Protocol))) and LOldCookie.HttpOnly then begin
          Exit;
        end;
        ACookie.FCreatedAt := LOldCookie.CreatedAt;
        FCookieList.Delete(I);
        LOldCookie.Collection := nil;
        LOldCookie.Free;
        Break;
      end;
    end;
    if not ACookie.IsExpired then begin
      FCookieList.Add(ACookie);
      Result := True;
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
  end else
  begin
    inherited Assign(ASource);
  end;
end;

function TIdCookies.GetCookie(Index: Integer): TIdCookie;
begin
  Result := inherited GetItem(Index) as TIdCookie;
end;

procedure TIdCookies.SetCookie(Index: Integer; const Value: TIdCookie);
begin
  inherited SetItem(Index, Value);
end;

function TIdCookies.AddClientCookie(const ACookie: string): TIdCookie;
var
  LCookie: TIdCookie;
begin
  Result := nil;
  LCookie := Add;
  try
    if LCookie.ParseClientCookie(ACookie) then
    begin
      LockCookieList(caReadWrite);
      try
        FCookieList.Add(LCookie);
        Result := LCookie;
        LCookie := nil;
      finally
        UnlockCookieList(caReadWrite);
      end;
    end;
  finally
    if LCookie <> nil then
    begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

procedure TIdCookies.AddClientCookies(const ACookie: string);
var
  Temp: TStringList;
  LCookie, S: String;
  I: Integer;
begin
  S := Trim(ACookie);
  if S <> '' then begin
    Temp := TStringList.Create;
    try
      repeat
        LCookie := Fetch(S, ';');
        if LCookie <> '' then begin
          Temp.Add(LCookie);
        end;
      until S = '';
      for I := 0 to Temp.Count-1 do begin
        AddClientCookie(Temp[I]);
      end;
    finally
      Temp.Free;
    end;
  end;
end;

procedure TIdCookies.AddClientCookies(const ACookies: TStrings);
var
  i: Integer;
begin
  for i := 0 to ACookies.Count - 1 do begin
    AddClientCookies(ACookies[i]);
  end;
end;

function TIdCookies.AddServerCookie(const ACookie: string; AURI: TIdURI): TIdCookie;
var
  LCookie: TIdCookie;
begin
  Result := nil;
  LCookie := Add;
  try
    if LCookie.ParseServerCookie(ACookie, AURI) then begin
      if AddCookie(LCookie, AURI) then
      begin
        Result := LCookie;
        LCookie := nil;
      end;
    end;
  finally
    if LCookie <> nil then begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

procedure TIdCookies.AddServerCookies(const ACookies: TStrings; AURI: TIdURI);
var
  i: Integer;
begin
  for i := 0 to ACookies.Count - 1 do begin
    AddServerCookie(ACookies[i], AURI);
  end;
end;

procedure TIdCookies.AddCookies(ASource: TIdCookies);
var
  LSrcCookies: TIdCookieList;
  LSrcCookie, LDestCookie: TIdCookie;
  i: Integer;
begin
  if (ASource <> nil) and (ASource <> Self) then
  begin
    LSrcCookies := ASource.LockCookieList(caRead);
    try
      LockCookieList(caReadWrite);
      try
        for i := 0 to LSrcCookies.Count - 1 do
        begin
          LSrcCookie := LSrcCookies.Cookies[i];
          LDestCookie := TIdCookieClass(LSrcCookie.ClassType).Create(Self);
          try
            LDestCookie.Assign(LSrcCookie);
            FCookieList.Add(LDestCookie);
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

function TIdCookies.GetCookieByNameAndDomain(const AName, ADomain: string): TIdCookie;
var
  i: Integer;
begin
  i := GetCookieIndex(AName, ADomain);
  if i = -1 then begin
    Result := nil;
  end else begin
    Result := Cookies[i];
  end;
end;

function TIdCookies.GetCookieIndex(const AName: string; FirstIndex: Integer = 0): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    if TextIsSame(Cookies[i].CookieName, AName) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TIdCookies.GetCookieIndex(const AName, ADomain: string; FirstIndex: Integer = 0): Integer;
var
  LCookie: TIdCookie;
  i: Integer;
begin
  Result := -1;
  for i := FirstIndex to Count - 1 do
  begin
    LCookie := Cookies[i];
    if TextIsSame(LCookie.CookieName, AName) and
       TextIsSame(CanonicalizeHostName(LCookie.Domain), CanonicalizeHostName(ADomain)) then
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
