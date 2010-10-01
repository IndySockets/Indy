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
  Rev 1.9    2/16/2005 7:58:56 AM  DSiders
  Modified TIdRequestHeaderInfo to restore the Range property.
  Modified TIdRequestHeaderInfo methods AssignTo, Clear, ProcessHeaders, and
    SetHeaders to include Range property.

  Rev 1.8    11/11/2004 12:55:38 AM  DSiders
  Modified TIdEntityHeaderInfo to fix problems with content-range header
    handling.
  Added ContentRangeInstanceLength property.
  Added HasContentRange property (read-ony).
  Added HasContentRangeInstance property (read-only).
  Moved reading and writing methods to ProcessHeaders and SetHeaders in
    TIdEntityHeaderInfo.

  Rev 1.7    6/8/2004 10:35:46 AM  BGooijen
  fixed overflow

  Rev 1.6    2004.02.03 5:43:46 PM  czhower
  Name changes

  Rev 1.5    1/22/2004 7:10:08 AM  JPMugaas
  Tried to fix AnsiSameText depreciation.

  Rev 1.4    13.1.2004 ã. 17:17:44  DBondzhev
  moved few methods into protected section to remove some warnings

  Rev 1.3    10/17/2003 12:09:28 AM  DSiders
  Added localization comments.

  Rev 1.2    20/4/2003 3:46:34 PM  SGrobety
  Fix to previous fix... (Dumb me)

  Rev 1.1    20/4/2003 3:33:58 PM  SGrobety
  Changed Content-type default in TIdEntityHeaderInfo back to empty string
    and changed the default of the response object. Solved compatibility
    issue with Netscape servers

  Rev 1.0    11/13/2002 07:54:24 AM  JPMugaas
}

unit IdHTTPHeaderInfo;

{
  HTTP Header definition - RFC 2616
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAuthentication,
  IdGlobal,
  IdGlobalProtocols,
  IdHeaderList;

type
  TIdEntityHeaderInfo = class(TPersistent)
  protected
    FCacheControl: String;
    FRawHeaders: TIdHeaderList;
    FCharSet: String;
    FConnection: string;
    FContentDisposition: string;
    FContentEncoding: string;
    FContentLanguage: string;
    FContentLength: Int64;
    FContentRangeEnd: Int64;
    FContentRangeStart: Int64;
    FContentRangeInstanceLength: Int64;
    FContentRangeUnits: String;
    FContentType: string;
    FContentVersion: string;
    FCustomHeaders: TIdHeaderList;
    FDate: TDateTime;
    FExpires: TDateTime;
    FETag: string;
    FLastModified: TDateTime;
    FPragma: string;
    FHasContentLength: Boolean;
    FTransferEncoding: String;
    //
    procedure AssignTo(Destination: TPersistent); override;
    procedure ProcessHeaders; virtual;
    procedure SetHeaders; virtual;
    function GetOwner: TPersistent; override;

    procedure SetContentLength(const AValue: Int64);
    procedure SetContentType(const AValue: String);
    procedure SetCustomHeaders(const AValue: TIdHeaderList);
    function GetHasContentRange: Boolean;
    function GetHasContentRangeInstance: Boolean;
  public
    procedure AfterConstruction; override;
    procedure Clear; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    //
    property HasContentLength: Boolean read FHasContentLength;
    property HasContentRange: Boolean read GetHasContentRange;
    property HasContentRangeInstance: Boolean read GetHasContentRangeInstance;
    property RawHeaders: TIdHeaderList read FRawHeaders;
  published
    property CacheControl: String read FCacheControl write FCacheControl;
    property CharSet: String read FCharSet write FCharSet;
    property Connection: string read FConnection write FConnection;
    property ContentDisposition: string read FContentDisposition write FContentDisposition;
    property ContentEncoding: string read FContentEncoding write FContentEncoding;
    property ContentLanguage: string read FContentLanguage write FContentLanguage;
    property ContentLength: Int64 read FContentLength write SetContentLength;
    property ContentRangeEnd: Int64 read FContentRangeEnd write FContentRangeEnd;
    property ContentRangeStart: Int64 read FContentRangeStart write FContentRangeStart;
    property ContentRangeInstanceLength: Int64 read FContentRangeInstanceLength write FContentRangeInstanceLength;
    property ContentRangeUnits: String read FContentRangeUnits write FContentRangeUnits;
    property ContentType: string read FContentType write SetContentType;
    property ContentVersion: string read FContentVersion write FContentVersion;
    property CustomHeaders: TIdHeaderList read FCustomHeaders write SetCustomHeaders;
    property Date: TDateTime read FDate write FDate;
    property ETag: string read FETag write FETag;
    property Expires: TDateTime read FExpires write FExpires;
    property LastModified: TDateTime read FLastModified write FLastModified;
    property Pragma: string read FPragma write FPragma;
    property TransferEncoding: string read FTransferEncoding write FTransferEncoding;
  end;

  TIdProxyConnectionInfo = class(TPersistent)
  protected
    FAuthentication: TIdAuthentication;
    FPassword: string;
    FPort: Integer;
    FServer: string;
    FUsername: string;
    FBasicByDefault: Boolean;

    procedure AssignTo(Destination: TPersistent); override;
    procedure SetProxyPort(const Value: Integer);
    procedure SetProxyServer(const Value: string);
  public
    procedure AfterConstruction; override;
    constructor Create;
    procedure Clear;
    destructor Destroy; override;
    procedure SetHeaders(Headers: TIdHeaderList);
    //
    property Authentication: TIdAuthentication read FAuthentication write FAuthentication;
  published

    property BasicAuthentication: boolean read FBasicByDefault write FBasicByDefault;
    property ProxyPassword: string read FPassword write FPassword;
    property ProxyPort: Integer read FPort write SetProxyPort;
    property ProxyServer: string read FServer write SetProxyServer;
    property ProxyUsername: string read FUsername write FUserName;
  end;

  TIdEntityRange = class(TCollectionItem)
  protected
    FStartPos: Int64;
    FEndPos: Int64;
    FSuffixLength: Int64;
    function GetText: String;
    procedure SetText(const AValue: String);
  public
    constructor Create(Collection: TCollection); override;
  published
    property StartPos: Int64 read FStartPos write FStartPos;
    property EndPos: Int64 read FEndPos write FEndPos;
    property SuffixLength: Int64 read FSuffixLength write FSuffixLength;
    property Text: String read GetText write SetText;
  end;

  TIdEntityRanges = class(TOwnedCollection)
  protected
    FUnits: String;
    function GetRange(Index: Integer): TIdEntityRange;
    procedure SetRange(Index: Integer; AValue: TIdEntityRange);
    function GetText: String;
    procedure SetText(const AValue: String);
    procedure SetUnits(const AValue: String);
  public
    constructor Create(AOwner: TPersistent); reintroduce;
    function Add: TIdEntityRange; reintroduce;
    property Ranges[Index: Integer]: TIdEntityRange read GetRange write SetRange; default;
  published
    property Text: String read GetText write SetText;
    property Units: String read FUnits write SetUnits;
  end;

  TIdRequestHeaderInfo = class(TIdEntityHeaderInfo)
  protected
    FAccept: String;
    FAcceptCharSet: String;
    FAcceptEncoding: String;
    FAcceptLanguage: String;
    FExpect: String;
    FFrom: String;
    FPassword: String;
    FReferer: String;
    FUserAgent: String;
    FUserName: String;
    FHost: String;
    FProxyConnection: String;
    FRanges: TIdEntityRanges;
    FBasicByDefault: Boolean;
    FAuthentication: TIdAuthentication;
    FMethodOverride: String;
    //
    procedure AssignTo(Destination: TPersistent); override;
    procedure ProcessHeaders; override;
    procedure SetHeaders; override;
    function GetRange: String;
    procedure SetRange(const AValue: String);
    procedure SetRanges(AValue: TIdEntityRanges);
  public
    //
    constructor Create; override;
    destructor Destroy; override;
    procedure Clear; override;
    property Authentication: TIdAuthentication read FAuthentication write FAuthentication;
  published
    property Accept: String read FAccept write FAccept;
    property AcceptCharSet: String read FAcceptCharSet write FAcceptCharSet;
    property AcceptEncoding: String read FAcceptEncoding write FAcceptEncoding;
    property AcceptLanguage: String read FAcceptLanguage write FAcceptLanguage;
    property BasicAuthentication: boolean read FBasicByDefault write FBasicByDefault;
    property Host: String read FHost write FHost;
    property From: String read FFrom write FFrom;
    property Password: String read FPassword write FPassword;
    property Referer: String read FReferer write FReferer;
    property UserAgent: String read FUserAgent write FUserAgent;
    property Username: String read FUsername write FUsername;
    property ProxyConnection: String read FProxyConnection write FProxyConnection;
    property Range: String read GetRange write SetRange; //deprecated 'Use Ranges property';
    property Ranges: TIdEntityRanges read FRanges write SetRanges;
    property MethodOverride: String read FMethodOverride write FMethodOverride;
  end;

  TIdResponseHeaderInfo = class(TIdEntityHeaderInfo)
  protected
    FAcceptRanges: string;
    FLocation: string;
    FServer: string;
    FProxyConnection: string;
    FProxyAuthenticate: TIdHeaderList;
    FWWWAuthenticate: TIdHeaderList;
    FMetaHTTPEquiv : TIdHeaderList;
    //
    procedure SetProxyAuthenticate(const Value: TIdHeaderList);
    procedure SetWWWAuthenticate(const Value: TIdHeaderList);
    procedure SetAcceptRanges(const Value: string);
    procedure ProcessHeaders; override;
    procedure SetHeaders; override;
  public

    procedure Clear; override;
    constructor Create; override;
    destructor Destroy; override;
  published
    property AcceptRanges: string read FAcceptRanges write SetAcceptRanges;
    property Location: string read FLocation write FLocation;
    property ProxyConnection: string read FProxyConnection write FProxyConnection;
    property ProxyAuthenticate: TIdHeaderList read FProxyAuthenticate write SetProxyAuthenticate;
    property Server: string read FServer write FServer;
    property WWWAuthenticate: TIdHeaderList read FWWWAuthenticate write SetWWWAuthenticate;
  end;
  TIdMetaHTTPEquiv = class(TIdEntityHeaderInfo)
  public
    procedure ProcessMetaHTTPEquiv(AStream: TStream);
  end;

implementation

uses
  SysUtils;

const
  DefaultUserAgent = 'Mozilla/3.0 (compatible; Indy Library)'; {do not localize}

{ TIdEntityHeaderInfo }

constructor TIdEntityHeaderInfo.Create;
begin
  inherited Create;
  FRawHeaders := TIdHeaderList.Create(QuoteHTTP);
  FRawHeaders.FoldLength := 1024;
  FCustomHeaders := TIdHeaderList.Create(QuoteHTTP);
end;

procedure TIdEntityHeaderInfo.AfterConstruction;
begin
  inherited AfterConstruction;
  Clear;
end;

destructor TIdEntityHeaderInfo.Destroy;
begin
  FreeAndNil(FRawHeaders);
  FreeAndNil(FCustomHeaders);
  inherited Destroy;
end;

procedure TIdEntityHeaderInfo.AssignTo(Destination: TPersistent);
begin
  if Destination is TIdEntityHeaderInfo then
  begin
    with Destination as TIdEntityHeaderInfo do
    begin
      FRawHeaders.Assign(Self.FRawHeaders);
      FCacheControl := Self.FCacheControl;
      FCharSet := Self.FCharSet;
      FContentDisposition := Self.FContentDisposition;
      FContentEncoding := Self.FContentEncoding;
      FContentLanguage := Self.FContentLanguage;
      FContentType := Self.FContentType;
      FContentVersion := Self.FContentVersion;
      FContentLength := Self.FContentLength;
      FContentRangeEnd:= Self.FContentRangeEnd;
      FContentRangeStart:= Self.FContentRangeStart;
      FContentRangeInstanceLength := Self.FContentRangeInstanceLength;
      FContentRangeUnits := Self.FContentRangeUnits;
      FDate := Self.FDate;
      FETag := Self.FETag;
      FExpires := Self.FExpires;
      FLastModified := Self.FLastModified;
    end;
  end else
  begin
    inherited AssignTo(Destination);
  end;
end;

procedure TIdEntityHeaderInfo.Clear;
begin
  FCacheControl := '';
  FCharSet := '';
  FConnection := '';
  FContentVersion := '';
  FContentDisposition := '';
  FContentEncoding := '';
  FContentLanguage := '';

  { S.G. 20/4/2003

    Was FContentType := 'Text/HTML'

    Shouldn't be set here but in response.
    Requests, by default, have NO content-type.
    This caused problems with some netscape servers
  }
  FContentType := '';

  FContentLength := -1;
  FContentRangeStart := -1;
  FContentRangeEnd := -1;
  FContentRangeInstanceLength := -1;
  FContentRangeUnits := '';
  FDate := 0;
  FLastModified := 0;
  FETag := '';
  FExpires := 0;
  FRawHeaders.Clear;
end;

procedure TIdEntityHeaderInfo.ProcessHeaders;
var
  LSecs: Int64;
  lValue: string;
  lCRange: string;
  lILength: string;
begin
  with FRawHeaders do
  begin
    FCacheControl := Values['Cache-control']; {do not localize}
    FConnection := Values['Connection']; {do not localize}
    FContentVersion := Values['Content-Version']; {do not localize}
    FContentDisposition := Values['Content-Disposition']; {do not localize}
    FContentEncoding := Values['Content-Encoding']; {do not localize}
    FContentLanguage := Values['Content-Language']; {do not localize}
    ContentType := Values['Content-Type']; {do not localize}
    FContentLength := IndyStrToInt64(Values['Content-Length'], -1); {do not localize}
    FHasContentLength := FContentLength >= 0;

    FContentRangeStart := -1;
    FContentRangeEnd := -1;
    FContentRangeInstanceLength := -1;
    FContentRangeUnits := '';

    {
     handle content-range headers, like:

     content-range: bytes 1-65536/102400
     content-range: bytes */102400
     content-range: bytes 1-65536/*
    }
    lValue := Values['Content-Range']; {do not localize}
    if lValue <> '' then
    begin
      // strip the bytes unit, and keep the range and instance info
      FContentRangeUnits := Fetch(lValue);
      lCRange := Fetch(lValue, '/');
      lILength := Fetch(lValue);

      FContentRangeStart := IndyStrToInt64(Fetch(lCRange, '-'), -1);
      FContentRangeEnd := IndyStrToInt64(lCRange, -1);
      FContentRangeInstanceLength := IndyStrToInt64(lILength, -1);
    end;

    // RLebeau 03/04/2009: RFC 2616 Section 14.18 says:
    //    
    // "A received message that does not have a Date header field MUST be
    // assigned one by the recipient if the message will be cached by that
    // recipient or gatewayed via a protocol which requires a Date."
   
    lValue := Values['Date']; {do not localize}
    if lValue <> '' then
    begin
      FDate := GMTToLocalDateTime(lValue);
    end else
    begin
      FDate := Now;
    end;

    FLastModified := GMTToLocalDateTime(Values['Last-Modified']); {do not localize}

    // RLebeau 01/23/2006 - IIS fix
    lValue := Values['Expires']; {do not localize}
    if IsNumeric(lValue) then
    begin
      // This is happening when expires is an integer number in seconds
      LSecs := IndyStrToInt64(lValue);
      // RLebeau 01/23/2005 - IIS sometimes sends an 'Expires: -1' header
      // should we be handling it as actually meaning "Now minus 1 second" instead?
      if LSecs >= 0 then begin
        FExpires := Now + (LSecs / SecsPerDay);
      end else begin
        FExpires := 0.0;
      end;
    end else
    begin
      // RLebeau 03/04/2009: RFC 2616 Section 14.21 says:
      //
      // "The format is an absolute date and time as defined by HTTP-date in
      //  section 3.3.1; it MUST be in RFC 1123 date format:
      //
      //   Expires = "Expires" ":" HTTP-date
      //
      // HTTP/1.1 clients and caches MUST treat other invalid date formats,
      // especially including the value "0", as in the past (i.e., "already
      // expired")."

      try
        FExpires := GMTToLocalDateTime(lValue);
      except
        FExpires := Now - (1 / SecsPerDay);
      end;
    end;

    FETag := Values['ETag'];  {do not localize}
    FPragma := Values['Pragma'];  {do not localize}
    FTransferEncoding := Values['Transfer-Encoding']; {do not localize}
  end;
end;

procedure TIdEntityHeaderInfo.SetHeaders;
begin
  RawHeaders.Clear;
  with RawHeaders do
  begin
    if Length(FConnection) > 0 then
    begin
      Values['Connection'] := FConnection; {do not localize}
    end;
    if Length(FContentVersion) > 0 then
    begin
      Values['Content-Version'] := FContentVersion; {do not localize}
    end;
    if Length(FContentDisposition) > 0 then
    begin
     Values['Content-Disposition'] := FContentDisposition; {do not localize}
    end;
    if Length(FContentEncoding) > 0 then
    begin
      Values['Content-Encoding'] := FContentEncoding; {do not localize}
    end;
    if Length(FContentLanguage) > 0 then
    begin
      Values['Content-Language'] := FContentLanguage; {do not localize}
    end;
    if Length(FContentType) > 0 then
    begin
      Values['Content-Type'] := FContentType; {do not localize}
      Params['Content-Type', 'charset'] := FCharSet; {do not localize}
    end;
    if FContentLength >= 0 then
    begin
      Values['Content-Length'] := IntToStr(FContentLength); {do not localize}
    end;

    { removed setting Content-Range header for entities... deferred to response }

    if Length(FCacheControl) > 0 then
    begin
      Values['Cache-control'] := FCacheControl; {do not localize}
    end;
    if FDate > 0 then
    begin
      Values['Date'] := LocalDateTimeToHttpStr(FDate); {do not localize}
    end;
    if Length(FETag) > 0 then
    begin
      Values['ETag'] := FETag; {do not localize}
    end;
    if FExpires > 0 then
    begin
      Values['Expires'] := LocalDateTimeToHttpStr(FExpires); {do not localize}
    end;
    if Length(FPragma) > 0 then
    begin
      Values['Pragma'] := FPragma; {do not localize}
    end;
    if Length(FTransferEncoding) > 0 then
    begin
      Values['Transfer-Encoding'] := FTransferEncoding; {do not localize}
    end;
    if FCustomHeaders.Count > 0 then
    begin
      // append custom headers
      Text := Text + FCustomHeaders.Text;
    end;
  end;
end;

procedure TIdEntityHeaderInfo.SetCustomHeaders(const AValue: TIdHeaderList);
begin
  FCustomHeaders.Assign(AValue);
end;

procedure TIdEntityHeaderInfo.SetContentLength(const AValue: Int64);
begin
  FContentLength := AValue;
  FHasContentLength := FContentLength >= 0;
end;

procedure TIdEntityHeaderInfo.SetContentType(const AValue: String);
var
  S, LCharSet: string;
begin
  if AValue <> '' then begin
    FContentType := RemoveHeaderEntry(AValue, 'charset', LCharSet, QuoteHTTP); {do not localize}
    // RLebeau: per RFC 2616 Section 3.7.1:
    //
    // The "charset" parameter is used with some media types to define the
    // character set (section 3.4) of the data. When no explicit charset
    // parameter is provided by the sender, media subtypes of the "text"
    // type are defined to have a default charset value of "ISO-8859-1" when
    // received via HTTP. Data in character sets other than "ISO-8859-1" or
    // its subsets MUST be labeled with an appropriate charset value. See
    // section 3.4.1 for compatibility problems.

    // RLebeau: per RFC 3023 Sections 3.1, 3.3, and 3.6:
    //
    // Conformant with [RFC2046], if a text/xml entity is received with
    // the charset parameter omitted, MIME processors and XML processors
    // MUST use the default charset value of "us-ascii"[ASCII].  In cases
    // where the XML MIME entity is transmitted via HTTP, the default
    // charset value is still "us-ascii".  (Note: There is an
    // inconsistency between this specification and HTTP/1.1, which uses
    // ISO-8859-1[ISO8859] as the default for a historical reason.  Since
    // XML is a new format, a new default should be chosen for better
    // I18N.  US-ASCII was chosen, since it is the intersection of UTF-8
    // and ISO-8859-1 and since it is already used by MIME.)
    //
    // ...
    //
    // The charset parameter of text/xml-external-parsed-entity is
    // handled the same as that of text/xml as described in Section 3.1
    //
    // ...
    //
    // The following list applies to text/xml, text/xml-external-parsed-
    // entity, and XML-based media types under the top-level type "text"
    // that define the charset parameter according to this specification:
    //
    // - If the charset parameter is not specified, the default is "us-
    //   ascii".  The default of "iso-8859-1" in HTTP is explicitly
    //   overridden.

    if (LCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin {do not localize}
      S := ExtractHeaderMediaSubType(FContentType);
      if (PosInStrArray(S, ['xml', 'xml-external-parsed-entity'], False) >= 0) or TextEndsWith(S, '+xml') then begin {do not localize}
        LCharSet := 'us-ascii'; {do not localize}
      end else begin
        LCharSet := 'ISO-8859-1'; {do not localize}
      end;
    end;

    {RLebeau: override the current CharSet only if the header specifies a new value}
    if LCharSet <> '' then begin
      FCharSet := LCharSet;
    end;
  end else begin
    FContentType := '';
    FCharSet := '';
  end;
end;

function TIdEntityHeaderInfo.GetHasContentRange: Boolean;
begin
  Result := (FContentRangeEnd >= 0);
end;

function TIdEntityHeaderInfo.GetHasContentRangeInstance: Boolean;
begin
  Result := (FContentRangeInstanceLength >= 0);
end;

function TIdEntityHeaderInfo.GetOwner: TPersistent;
begin
  Result := inherited GetOwner;
end;

{ TIdProxyConnectionInfo }

constructor TIdProxyConnectionInfo.Create;
begin
  inherited Create;
end;

procedure TIdProxyConnectionInfo.AfterConstruction;
begin
  inherited AfterConstruction;
  Clear;
end;

destructor TIdProxyConnectionInfo.Destroy;
begin
  FreeAndNil(FAuthentication);
  inherited Destroy;
end;

procedure TIdProxyConnectionInfo.AssignTo(Destination: TPersistent);
begin
  if Destination is TIdProxyConnectionInfo then
  begin
    with Destination as TIdProxyConnectionInfo do
    begin
      FPassword := Self.FPassword;
      FPort := Self.FPort;
      FServer := Self.FServer;
      FUsername := Self.FUsername;
      FBasicByDefault := Self.FBasicByDefault;
    end;
  end
  else
  begin
    inherited AssignTo(Destination);
  end;
end;

procedure TIdProxyConnectionInfo.Clear;
begin
  FServer := '';
  FUsername := '';
  FPassword := '';
  FPort := 0;
end;

procedure TIdProxyConnectionInfo.SetHeaders(Headers: TIdHeaderList);
Var
  S: String;
begin
  with Headers do
  begin
    if Assigned(Authentication) then
    begin
      S := Authentication.Authentication;
      if Length(S) > 0 then
      begin
        Values['Proxy-Authorization'] := S;             {do not localize}
      end;
    end
    else
    begin
      // Use Basic authentication by default
      if FBasicByDefault then
      begin
        FAuthentication := TIdBasicAuthentication.Create;
        with Authentication do
        begin
          Params.Values['Username'] := Self.FUsername;  {do not localize}
          Params.Values['Password'] := Self.FPassword;  {do not localize}
          S := Authentication;
        end;

        if Length(S) > 0 then
        begin
          Values['Proxy-Authorization'] := S;           {do not localize}
        end;
      end;
    end;
  end;
end;

procedure TIdProxyConnectionInfo.SetProxyPort(const Value: Integer);
begin
  if Value <> FPort then
  begin
    FreeAndNil(FAuthentication);
  end;
  FPort := Value;
end;

procedure TIdProxyConnectionInfo.SetProxyServer(const Value: string);
begin
  if not TextIsSame(Value, FServer) then
  begin
    FreeAndNil(FAuthentication);
  end;
  FServer := Value;
end;

{ TIdEntityRange }

constructor TIdEntityRange.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FStartPos := -1;
  FEndPos := -1;
  FSuffixLength := -1;
end;

function TIdEntityRange.GetText: String;
begin
  if (FStartPos >= 0) or (FEndPos >= 0) then
  begin
    if FEndPos >= 0 then
    begin
      Result := IntToStr(FStartPos) + '-' + IntToStr(FEndPos);  {do not localize}
    end else begin
      Result := IntToStr(FStartPos) + '-'; {do not localize}
    end;
  end
  else if FSuffixLength >= 0 then begin
    Result := '-' + IntToStr(FSuffixLength);
  end
  else begin
    Result := '';
  end;
end;

procedure TIdEntityRange.SetText(const AValue: String);
var
  LValue, S: String;
begin
  LValue := Trim(AValue);
  if LValue <> '' then
  begin
    S := Fetch(LValue, '-'); {do not localize}
    if S <> '' then begin
      FStartPos := StrToIntDef(S, -1);
      FEndPos := StrToIntDef(Fetch(LValue), -1);
      FSuffixLength := -1;
    end else begin
      FStartPos := -1;
      FEndPos := -1;
      FSuffixLength := StrToIntDef(Fetch(LValue), -1);
    end;
  end else begin
    FStartPos := -1;
    FEndPos := -1;
    FSuffixLength := -1;
  end;
end;

{ TIdEntityRanges }

constructor TIdEntityRanges.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdEntityRange);
  FUnits := 'bytes'; {do not localize}
end;

function TIdEntityRanges.Add: TIdEntityRange;
begin
  Result := TIdEntityRange(inherited Add);
end;

function TIdEntityRanges.GetRange(Index: Integer): TIdEntityRange;
begin
  Result := TIdEntityRange(inherited GetItem(Index));
end;

procedure TIdEntityRanges.SetRange(Index: Integer; AValue: TIdEntityRange);
begin
  inherited SetItem(Index, AValue);
end;

function TIdEntityRanges.GetText: String;
var
  I: Integer;
  S: String;
begin
  Result := '';
  for I := 0 to Count-1 do begin
    S := Ranges[I].Text;
    if S <> '' then begin
      if Result <> '' then begin
        Result := Result + ','; {do not localize}
      end;
      Result := Result + S;
    end;
  end;
  if Result <> '' then begin
    Result := FUnits + '=' + Result; {do not localize}
  end;
end;

procedure TIdEntityRanges.SetText(const AValue: String);
var
  LTmp: String;
  LRanges: TStringList;
  I: Integer;
begin
  LTmp := Trim(AValue);
  BeginUpdate;
  try
    Clear;
    Units := Fetch(LTmp, '='); {do not localize}
    LRanges := TStringList.Create;
    try
      SplitColumns(LTmp, LRanges, ','); {do not localize}
      for I := 0 to LRanges.Count-1 do begin
        Add.Text := LRanges[I];
      end;
    finally
      LRanges.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TIdEntityRanges.SetUnits(const AValue: String);
var
  LUnits: String;
begin
  LUnits := Trim(AValue);
  if LUnits <> '' then begin
    FUnits := LUnits;
  end else begin
    FUnits := 'bytes'; {do not localize}
  end;
end;

{ TIdRequestHeaderInfo }

constructor TIdRequestHeaderInfo.Create;
begin
  inherited Create;
  FRanges := TIdEntityRanges.Create(Self);
end;

destructor TIdRequestHeaderInfo.Destroy;
begin
  FreeAndNil(FAuthentication);
  FreeAndNil(FRanges);
  inherited Destroy;
end;

procedure TIdRequestHeaderInfo.ProcessHeaders;
begin
  inherited ProcessHeaders;

  with FRawHeaders do
  begin
    FAccept := Values['Accept'];                    {do not localize}
    FAcceptCharSet := Values['Accept-Charset'];     {do not localize}
    FAcceptEncoding := Values['Accept-Encoding'];   {do not localize}
    FAcceptLanguage := Values['Accept-Language'];   {do not localize}
    FHost := Values['Host'];                        {do not localize}
    FFrom := Values['From'];                        {do not localize}
    FReferer := Values['Referer'];                  {do not localize}
    FUserAgent := Values['User-Agent'];             {do not localize}
    FRanges.Text := Values['Range'];                {do not localize}
    FMethodOverride := Values['X-HTTP-Method-Override']; {do not localize}
  end;
end;

procedure TIdRequestHeaderInfo.AssignTo(Destination: TPersistent);
begin
  if Destination is TIdRequestHeaderInfo then
  begin
    with Destination as TIdRequestHeaderInfo do
    begin
      FAccept := Self.FAccept;
      FAcceptCharSet := Self.FAcceptCharset;
      FAcceptEncoding := Self.FAcceptEncoding;
      FAcceptLanguage := Self.FAcceptLanguage;

      FFrom := Self.FFrom;
      FUsername := Self.FUsername;
      FPassword := Self.FPassword;
      FReferer := Self.FReferer;
      FUserAgent := Self.FUserAgent;
      FBasicByDefault := Self.FBasicByDefault;

      FRanges.Assign(Self.FRanges);
      FMethodOverride := Self.FMethodOverride;

      // TODO: omitted intentionally?
      // FHost := Self.FHost;
      // FProxyConnection := Self.FProxyConnection;
    end;
  end
  else
  begin
    inherited AssignTo(Destination);
  end;
end;

procedure TIdRequestHeaderInfo.Clear;
begin
  FAccept := 'text/html, */*'; {do not localize}
  FAcceptCharSet := '';
  FUserAgent := DefaultUserAgent;
  FBasicByDefault := false;
  FRanges.Text := '';
  FMethodOverride := '';

  // TODO: omitted intentionally?
  // FAcceptEncoding := '';
  // FAcceptLanguage := '';
  // FHost := '';
  // FFrom := '';
  // FPassword := '';
  // FUsername := '';
  // FReferer := '';
  // FProxyConnection := '';

  inherited Clear;
end;

function TIdRequestHeaderInfo.GetRange: String;
begin
  Result := FRanges.Text;
end;

procedure TIdRequestHeaderInfo.SetRange(const AValue: String);
begin
  FRanges.Text := AValue;
end;

procedure TIdRequestHeaderInfo.SetRanges(AValue: TIdEntityRanges);
begin
  FRanges.Assign(AValue);
end;

procedure TIdRequestHeaderInfo.SetHeaders;
var
  S: String;
begin
  inherited SetHeaders;

  with RawHeaders do
  begin
    if Length(FProxyConnection) > 0 then
    begin
      Values['Proxy-Connection'] := FProxyConnection; {do not localize}
    end;
    if Length(FHost) > 0 then
    begin
      Values['Host'] := FHost; {do not localize}
    end;
    if Length(FAccept) > 0 then
    begin
      Values['Accept'] := FAccept; {do not localize}
    end;
    if Length(FAcceptCharset) > 0 then
    begin
      Values['Accept-Charset'] := FAcceptCharSet;   {do not localize}
    end;
    if Length(FAcceptEncoding) > 0 then
    begin
      Values['Accept-Encoding'] := FAcceptEncoding; {do not localize}
    end;
    if Length(FAcceptLanguage) > 0 then
    begin
      Values['Accept-Language'] := FAcceptLanguage; {do not localize}
    end;
    if Length(FFrom) > 0 then
    begin
      Values['From'] := FFrom;                      {do not localize}
    end;
    if Length(FReferer) > 0 then
    begin
      Values['Referer'] := FReferer;                {do not localize}
    end;
    if Length(FUserAgent) > 0 then
    begin
      Values['User-Agent'] := FUserAgent;           {do not localize}
    end;
    S := FRanges.Text;
    if Length(S) > 0 then
    begin
      Values['Range'] := S; {do not localize}
    end;

    // use 'Last-Modified' entity header in the conditional request
    if FLastModified > 0 then
    begin
      Values['If-Modified-Since'] := LocalDateTimeToHttpStr(FLastModified); {do not localize}
    end;

    if Assigned(Authentication) then
    begin
      S := Authentication.Authentication;
      if Length(S) > 0 then
      begin
        Values['Authorization'] := S; {do not localize}
      end;
    end
    else
    begin
      if FBasicByDefault then
      begin
        Authentication := TIdBasicAuthentication.Create;
        with Authentication do
        begin
          Params.Values['Username'] := Self.FUserName;  {do not localize}
          Params.Values['Password'] := Self.FPassword;  {do not localize}
          S := Authentication;
        end;

        if Length(S) > 0 then
        begin
          Values['Authorization'] := S;                 {do not localize}
        end;
      end;
    end;

    if Length(FMethodOverride) > 0 then
    begin
      Values['X-HTTP-Method-Override'] := FMethodOverride; {Do not Localize}
    end;
  end;
end;

{ TIdResponseHeaderInfo }

constructor TIdResponseHeaderInfo.Create;
begin
  inherited Create;
  FContentType := 'text/html';  {do not localize}
  FCharSet := 'ISO-8859-1';  {do not localize}
  FWWWAuthenticate := TIdHeaderList.Create(QuoteHTTP);
  FProxyAuthenticate := TIdHeaderList.Create(QuoteHTTP);
  FMetaHTTPEquiv := TIdHeaderList.Create(QuoteHTTP);
  FAcceptRanges := '';
end;

destructor TIdResponseHeaderInfo.Destroy;
begin
  FreeAndNil(FMetaHTTPEquiv);
  FreeAndNil(FWWWAuthenticate);
  FreeAndNil(FProxyAuthenticate);
  inherited Destroy;
end;

procedure TIdResponseHeaderInfo.SetProxyAuthenticate(const Value: TIdHeaderList);
begin
  FProxyAuthenticate.Assign(Value);
end;

procedure TIdResponseHeaderInfo.SetWWWAuthenticate(const Value: TIdHeaderList);
begin
  FWWWAuthenticate.Assign(Value);
end;

procedure TIdResponseHeaderInfo.ProcessHeaders;
begin
  inherited ProcessHeaders;
  with FRawHeaders do
  begin;
    FLocation := Values['Location'];                  {do not localize}
    FServer := Values['Server'];                      {do not localize}
    FProxyConnection := Values['Proxy-Connection'];   {do not localize}

    FWWWAuthenticate.Clear;
    Extract('WWW-Authenticate', FWWWAuthenticate);    {do not localize}

    FProxyAuthenticate.Clear;
    Extract('Proxy-Authenticate', FProxyAuthenticate);{do not localize}

    FAcceptRanges := Values['Accept-Ranges'];         {do not localize}
  end;
end;

procedure TIdResponseHeaderInfo.SetHeaders;
var
  sUnits: String;
  sCR: String;
  sCI: String;
begin
  inherited SetHeaders;

  {
    setting the content-range header is allowed in server responses...
    moved here TIdEntityHeaderInfo
  }
  if HasContentRange or HasContentRangeInstance then
  begin
    sUnits := iif(FContentRangeUnits <> '',
      FContentRangeUnits, 'bytes'); {do not localize}
    sCR := iif(HasContentRange,
      IndyFormat('%d-%d', [FContentRangeStart, FContentRangeEnd]), '*'); {do not localize}
    sCI := iif(HasContentRangeInstance,
      IndyFormat('%d', [FContentRangeInstanceLength]), '*'); {do not localize}

    RawHeaders.Values['Content-Range'] := sUnits + ' ' + sCR + '/' + sCI;
  end;
  if Length(FAcceptRanges) > 0 then
  begin
    RawHeaders.Values['Accept-Ranges'] := FAcceptRanges;
  end;
end;

procedure TIdResponseHeaderInfo.Clear;
begin
  inherited Clear;

  // S.G. 20/4/2003: Default to text/HTML
  FContentType := 'text/html';  {do not localize}
  FCharSet := 'ISO-8859-1';  {do not localize}

  FLocation := '';
  FServer := '';
  FAcceptRanges := '';

  if Assigned(FProxyAuthenticate) then
  begin
    FProxyAuthenticate.Clear;
  end;

  if Assigned(FWWWAuthenticate) then
  begin
    FWWWAuthenticate.Clear;
  end;
end;

procedure TIdResponseHeaderInfo.SetAcceptRanges(const Value: string);
begin
  FAcceptRanges := Value;
end;

{ TIdMetaHTTPEquiv }

procedure TIdMetaHTTPEquiv.ProcessMetaHTTPEquiv(AStream: TStream);
begin
  ParseMetaHTTPEquiv(AStream, RawHeaders );
  if FRawHeaders.Count > 0 then begin
    ProcessHeaders;
  end;
end;

end.
