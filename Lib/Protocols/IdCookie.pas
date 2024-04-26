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
  Implementation of the HTTP State Management Mechanism as specified in RFC 6265.
  Author: Remy Lebeau (remy@lebeausoftware.org)
  Copyright: (c) Chad Z. Hower and The Indy Team.

  TIdCookie - The base code used in all cookies.

REFERENCES
-------------------
 [RFC6265]  Barth, A, "HTTP State Management Mechanism",
            RFC 6265, April 2011.

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
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdGlobal, IdException, IdGlobalProtocols, IdURI,
  SysUtils;

type
  { Base Cookie class as described in [RFC6265] }
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
    FSameSite: String;

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
    property SameSite: String read FSameSite write FSameSite;

    // TODO: add property for user-defined attributes...
  end;

  TIdCookieClass = class of TIdCookie;

  { The Cookie collection }

  {$IFDEF HAS_GENERICS_TList}
  TIdCookieList = TList<TIdCookie>;
  {$ELSE}
  TIdCookieList = class(TList)
  protected
    function GetCookie(Index: Integer): TIdCookie;
    procedure SetCookie(Index: Integer; AValue: TIdCookie);
  public
    function IndexOfCookie(ACookie: TIdCookie): Integer;
    property Cookies[Index: Integer]: TIdCookie read GetCookie write SetCookie; default;
  end;
  {$ENDIF}

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
  {$IFDEF VCL_XE3_OR_ABOVE}
  System.Types,
  {$ENDIF}
  IdAssignedNumbers, IdResourceStringsProtocols;

function GetDefaultPath(const AURL: TIdURI): String;
var
  LUrlPath: string;
  Idx: Integer;
begin
  {
  Per RFC 6265, Section 5.1.4:

     The user agent MUST use an algorithm equivalent to the following
     algorithm to compute the default-path of a cookie:

     1.  Let uri-path be the path portion of the request-uri if such a
         portion exists (and empty otherwise).  For example, if the
         request-uri contains just a path (and optional query string),
         then the uri-path is that path (without the %x3F ("?") character
         or query string), and if the request-uri contains a full
         absoluteURI, the uri-path is the path component of that URI.

     2.  If the uri-path is empty or if the first character of the uri-
         path is not a %x2F ("/") character, output %x2F ("/") and skip
         the remaining steps.

     3.  If the uri-path contains no more than one %x2F ("/") character,
         output %x2F ("/") and skip the remaining steps.

     4.  Output the characters of the uri-path from the first character up
         to, but not including, the right-most %x2F ("/").
  }

  LUrlPath := AURL.Path + AURL.Document;
  if TextStartsWith(LUrlPath, '/') then begin {do not localize}
    Idx := RPos('/', LUrlPath); {do not localize}
    if Idx > 1 then begin
      Result := Copy(LUrlPath, 1, Idx-1);
      Exit;
    end;
  end;
  Result := '/'; {do not localize}
end;

function CanonicalizeHostName(const AHost: String): String;
begin
  // TODO: implement this
  {
  Per RFC 6265 Section 5.1.2:

   A canonicalized host name is the string generated by the following
   algorithm:

   1.  Convert the host name to a sequence of individual domain name
       labels.

   2.  Convert each label that is not a Non-Reserved LDH (NR_LDH) label,
       to an A-label (see Section 2.3.2.1 of [RFC5890] for the fomer
       and latter), or to a "punycode label" (a label resulting from the
       "ToASCII" conversion in Section 4 of [RFC3490]), as appropriate
       (see Section 6.3 of this specification).

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
  Per RFC 6265 Section 5.1.3:

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
  Per RFC 6265 Section 5.1.4:

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
  Result := PosInStrArray(AProtocol, ['http', 'https', 'shttp'], False) <> -1; {do not localize}
end;

function IsSecure(const AProtocol: String): Boolean;
begin
  Result := PosInStrArray(AProtocol, ['https', 'shttp'{, ...}], False) <> -1; {do not localize}
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

{$IFNDEF HAS_GENERICS_TList}

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

{$ENDIF}

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
var
  LSource: TIdCookie;
begin
  if Source is TIdCookie then
  begin
    LSource := TIdCookie(Source);
    FDomain := LSource.FDomain;
    FExpires := LSource.FExpires;
    FHttpOnly := LSource.FHttpOnly;
    FName := LSource.FName;
    FPath := LSource.FPath;
    FSecure := LSource.FSecure;
    FValue := LSource.FValue;
    FCreatedAt := LSource.FCreatedAt;
    FHostOnly := LSource.FHostOnly;
    FLastAccessed := LSource.FLastAccessed;
    FPersistent := LSource.FPersistent;
    FSameSite := LSource.FSameSite;
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
  // using the algorithm defined in RFC 6265 section 5.4...
  Result := MatchesHost and IsPathMatch(AURI.Path + AURI.Document, Path) and
            ((not Secure) or (Secure and SecureOnly)) and
            ((not HttpOnly) or (HttpOnly and IsHTTP(AURI.Protocol)))
            // TODO:
            //and ((SameSite = 'None') or (not CrossSite) or ((SameSite = 'Lax') and (Request.Method is safe) and (Request.TargetBrowsingContext = TopLevelBrowsingContext)))
            ;
end;

{$IFNDEF HAS_TryStrToInt64}
// TODO: move this to IdGlobalProtocols...
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

  procedure SplitCookieText(const CookieProp: TStringList; const S: string);
  var
    LNameValue, LAttrs, LAttr, LName, LValue: String;
    LSecs: Int64;
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
    // RLebeau 11/17/2020: no longer stripping off quotes here!
    // Some servers require them to remain intact....
    {
    if TextStartsWith(LValue, '"') then begin
      IdDelete(LValue, 1, 1);
      LNameValue := LValue;
      LValue := Fetch(LNameValue, '"');
    end;
    }
    IndyAddPair(CookieProp, LName, LValue);

    while LAttrs <> '' do
    begin
      IdDelete(LAttrs, 1, 1); // remove the leading ';'
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
        // RLebeau: RFC 6265 does not account for quoted attribute values,
        // despite several complaints asking for it.  We'll do it anyway in
        // the hopes that the RFC will be updated to "do the right thing"...
        // RLebeau 11/17/2020: leaving this intact, for now...
        if TextStartsWith(LValue, '"') then begin
          IdDelete(LValue, 1, 1);
          LNameValue := LValue;
          LValue := Fetch(LNameValue, '"');
        end;
      end else begin
        LName := Trim(LAttr);
        LValue := '';
      end;

      case PosInStrArray(LName, ['Expires', 'Max-Age', 'Domain', 'Path', 'Secure', 'HttpOnly', 'SameSite'], False) of
        0: begin
          if TryStrToInt64(LValue, LSecs) then begin
            // Not in the RFCs, but some servers specify Expires as an
            // integer number in seconds instead of using Max-Age...
            if LSecs >= 0 then begin
              // TODO: use SecsPerDay instead:
              // LExpiryTime := (Now + (LSecs / SecsPerDay));
              LExpiryTime := (Now + LSecs * 1000 / MSecsPerDay);
            end else begin
              LExpiryTime := EncodeDate(1, 1, 1);
            end;
            IndyAddPair(CookieProp, 'EXPIRES', FloatToStr(LExpiryTime)); {do not localize}
          end else
          begin
            LExpiryTime := CookieStrToLocalDateTime(LValue);
            if LExpiryTime <> 0.0 then begin
              IndyAddPair(CookieProp, 'EXPIRES', FloatToStr(LExpiryTime)); {do not localize}
            end;
          end;
        end;
        1: begin
          if TryStrToInt64(LValue, LSecs) then begin
            if LSecs >= 0 then begin
              // TODO: use SecsPerDay instead:
              // LExpiryTime := (Now + (LSecs / SecsPerDay));
              LExpiryTime := (Now + LSecs * 1000 / MSecsPerDay);
            end else begin
              LExpiryTime := EncodeDate(1, 1, 1);
            end;
            IndyAddPair(CookieProp, 'MAX-AGE', FloatToStr(LExpiryTime)); {do not localize}
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
            IndyAddPair(CookieProp, 'DOMAIN', LowerCase(LValue)); {do not localize}
          end;
        end;
        3: begin
          if (LValue = '') or (not TextStartsWith(LValue, '/')) then begin
            LValue := GetDefaultPath(AURI);
          end;
          IndyAddPair(CookieProp, 'PATH', LValue); {do not localize}
        end;
        4: begin
          IndyAddPair(CookieProp, 'SECURE', ''); {do not localize}
        end;
        5: begin
          IndyAddPair(CookieProp, 'HTTPONLY', ''); {do not localize}
        end;
        6: begin
          if TextIsSame(LValue, 'Strict') then begin {do not localize}
            IndyAddPair(CookieProp, 'SAMESITE', 'Strict'); {do not localize}
          end
          else if TextIsSame(LValue, 'Lax') then begin {do not localize}
            IndyAddPair(CookieProp, 'SAMESITE', 'Lax'); {do not localize}
          end else begin
            IndyAddPair(CookieProp, 'SAMESITE', 'None'); {do not localize}
          end;
        end;
      end;
    end;
  end;

  function GetLastValueOf(const CookieProp: TStringList; const AName: String; var VValue: String): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := CookieProp.Count-1 downto 0 do
    begin
      if TextIsSame(CookieProp.Names[I], AName) then
      begin
        VValue := IndyValueFromIndex(CookieProp, I);
        Result := True;
        Exit;
      end;
    end;
  end;

//Darcy: moved down the variables! Android compiler... bad boy!
var
  CookieProp: TStringList;
  S, LPathFromProps: string;
begin
  Result := False;

  // using the algorithm defined in RFC 6265 section 5.2...

  CookieProp := TStringList.Create;
  try
    SplitCookieText(CookieProp, S);
    if CookieProp.Count = 0 then begin
      Exit;
    end;

    FName := CookieProp.Names[0];
    FValue := IndyValueFromIndex(CookieProp, 0);
    CookieProp.Delete(0);

    FCreatedAt := Now;
    FLastAccessed := FCreatedAt;

    // using the algorithms defined in RFC 6265 section 5.3...

    if GetLastValueOf(CookieProp, 'MAX-AGE', S) then begin {Do not Localize}
      FPersistent := True;
      FExpires := StrToFloat(S);
    end
    else if GetLastValueOf(CookieProp, 'EXPIRES', S) then {Do not Localize}
    begin
      FPersistent := True;
      FExpires := StrToFloat(S);
    end else
    begin
      FPersistent := False;
      FExpires := EncodeDate(9999, 12, 31) + EncodeTime(23, 59, 59, 999);
    end;

    S := '';
    if GetLastValueOf(CookieProp, 'DOMAIN', S) then {Do not Localize}
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
      {
      if RejectPublicSuffixes and IsPublicSuffix(S) then begin
        if S <> CanonicalizeHostName(AURI.Host) then begin
          Exit;
        end;
        S := '';
      end;
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

    if GetLastValueOf(CookieProp, 'PATH', LPathFromProps) then begin {Do not Localize}
      FPath := LPathFromProps;
    end else begin
      FPath := GetDefaultPath(AURI);
    end;

    FSecure := CookieProp.IndexOfName('SECURE') <> -1; { Do not Localize }
    if FSecure and (not IsSecure(AURI.Protocol)) then begin
      Exit;
    end;

    FHttpOnly := CookieProp.IndexOfName('HTTPONLY') <> -1; { Do not Localize }
    if FHttpOnly and (not IsHTTP(AURI.Protocol)) then begin
      Exit;
    end;

    if (not FSecure) and (not IsSecure(AURI.Protocol)) then begin
      // TODO
      {
        If the cookie's secure-only-flag is not set, and the scheme
        component of request-uri does not denote a "secure" protocol,
        then abort these steps and ignore the cookie entirely if the
        cookie store contains one or more cookies that meet all of the
        following criteria:

        1.  Their name matches the name of the newly-created cookie.

        2.  Their secure-only-flag is true.

        3.  Their domain domain-matches the domain of the newly-created
            cookie, or vice-versa.

        4.  The path of the newly-created cookie path-matches the path
            of the existing cookie.

        Note: The path comparison is not symmetric, ensuring only that a
        newly-created, non-secure cookie does not overlay an existing
        secure cookie, providing some mitigation against cookie-fixing
        attacks.  That is, given an existing secure cookie named 'a'
        with a path of '/login', a non-secure cookie named 'a' could be
        set for a path of '/' or '/foo', but not for a path of '/login'
        or '/login/en'.	  }
      {
      for I := 0 to CookieList.Count-1 do
      begin
        LCookie := CookieList[I];
        if TextIsSame(LCookie.CookieName, FName) and
           LCookie.Secure and
           (IsDomainMatch(LCookie.Domain, FDomain) or IsDomainMatch(FDomain, LCookie.Domain)) and
           IsPathMatch(FPath, LCookie.Path) then
        begin
          Exit;
        end;
      end;
      }
    end;

    // TODO: implement https://tools.ietf.org/html/draft-west-cookie-incrementalism-01

    if GetLastValueOf(CookieProp, 'SAMESITE', S) then begin {Do not Localize}
      FSameSite := S;
    end else begin
      FSameSite := 'None'; {Do not Localize}
    end;

    if FSameSite <> 'None' then
    begin
      // TODO
      {
        1.  If the cookie was received from a "non-HTTP" API, and the
            API was called from a context whose "site for cookies" is
            not an exact match for request-uri's host's registrable
            domain, then abort these steps and ignore the newly created
            cookie entirely.

        2.  If the cookie was received from a "same-site" request (as
            defined in Section 5.2), skip the remaining substeps and
            continue processing the cookie.

        3.  If the cookie was received from a request which is
            navigating a top-level browsing context [HTML] (e.g. if the
            request's "reserved client" is either "null" or an
            environment whose "target browsing context" is a top-level
            browing context), skip the remaining substeps and continue
            processing the cookie.

            Note: Top-level navigations can create a cookie with any
            "SameSite" value, even if the new cookie wouldn't have been
            sent along with the request had it already existed prior to
            the navigation.

        4.  Abort these steps and ignore the newly created cookie
            entirely.
      }
      {
      if ((not IsHTTP(AURI.Protocol)) and (SiteForCookies <> RegistrableDomain(AURI.Host))) or
         ((IsCrossSite) and (not TopLevelBrowsingContext)) then
      begin
  	    Exit;
      end;
      }
    end;

    if TextStartsWith(FName, '__Secure-') and (not FSecure) then begin {do not localize}
      Exit;
    end;

    if TextStartsWith(FName, '__Host-') and not (FSecure and FHostOnly and (LPathFromProps = '/')) then begin {do not localize}
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
  AddCookieProperty(Result, 'SameSite', FSameSite); {Do not Localize}
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
        if TextStartsWith(LTemp, '"') then {Do not Localize}
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
        IndyAddPair(CookieProp, LName, LValue);
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
    FValue := IndyValueFromIndex(CookieProp, 0);

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
        if LOldCookie.HostOnly <> ACookie.HostOnly then begin
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
          LSrcCookie := LSrcCookies[i];
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
