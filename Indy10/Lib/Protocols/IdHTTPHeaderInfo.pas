{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further inSys.Formation / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11617: IdHTTPHeaderInfo.pas
{
    Rev 1.9    2/16/2005 7:58:56 AM  DSiders
  Modified TIdRequestHeaderInfo to restore the Range property.
  Modified TIdRequestHeaderInfo methods AssignTo, Clear, ProcessHeaders, and
  SetHeaders to include Range property.
}
{
    Rev 1.8    11/11/2004 12:55:38 AM  DSiders
  Modified TIdEntityHeaderInfo to fix problems with content-range header
  handling.
  Added ContentRangeInstanceLength property.
  Added HasContentRange property (read-ony).
  Added HasContentRangeInstance property (read-only).
  Moved reading and writing methods to ProcessHeaders and SetHeaders in
  TIdEntityHeaderInfo.
}
{
{   Rev 1.7    6/8/2004 10:35:46 AM  BGooijen
{ fixed overflow
}
{
{   Rev 1.6    2004.02.03 5:43:46 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/22/2004 7:10:08 AM  JPMugaas
{ Tried to fix AnsiSameText depreciation.
}
{
{   Rev 1.4    13.1.2004 ã. 17:17:44  DBondzhev
{ moved few methods into protected section to remove some warnings
}
{
    Rev 1.3    10/17/2003 12:09:28 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.2    20/4/2003 3:46:34 PM  SGrobety
{ Fix to previous fix... (Dumb me)
}
{
{   Rev 1.1    20/4/2003 3:33:58 PM  SGrobety
{ Changed Content-type default in TIdEntityHeaderInfo back to empty string and
{ changed the default of the response object. Solved compatibility issue with
{ Netscape servers
}
{
{   Rev 1.0    11/13/2002 07:54:24 AM  JPMugaas
}
{
  HTTP Header definition - RFC 2616

  Copyright: (c) Chad Z. Hower and The Indy Pit Crew.

  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
}

unit IdHTTPHeaderInfo;

interface

uses
  Classes, IdAuthentication, IdGlobal, IdGlobalProtocols, IdHeaderList;

Type
  TIdEntityHeaderInfo = class(TPersistent)
  protected
    FCacheControl: String;
    FRawHeaders: TIdHeaderList;
    FConnection: string;
    FContentEncoding: string;
    FContentLanguage: string;
    FContentLength: Integer;
    FContentRangeEnd: Cardinal;
    FContentRangeStart: Cardinal;
    FContentRangeInstanceLength: Cardinal;
    FContentType: string;
    FContentVersion: string;
    FCustomHeaders: TIdHeaderList;
    FDate: TDateTime;
    FExpires: TDateTime;
    FLastModified: TDateTime;
    FPragma: string;
    FHasContentLength: Boolean;
    //
    procedure AssignTo(Destination: TPersistent); override;
    procedure ProcessHeaders; virtual;
    procedure SetHeaders; virtual;

    procedure SetContentLength(const AValue: Integer);
    procedure SetCustomHeaders(const AValue: TIdHeaderList);
    function GetHasContentRange: Boolean;
    function GetHasContentRangeInstance: Boolean;
  public
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
    property Connection: string read FConnection write FConnection;
    property ContentEncoding: string read FContentEncoding write FContentEncoding;
    property ContentLanguage: string read FContentLanguage write FContentLanguage;
    property ContentLength: Integer read FContentLength write SetContentLength;

    property ContentRangeEnd: Cardinal read FContentRangeEnd write FContentRangeEnd;
    property ContentRangeStart: Cardinal read FContentRangeStart write FContentRangeStart;
    property ContentRangeInstanceLength: Cardinal
      read FContentRangeInstanceLength write FContentRangeInstanceLength;

    property ContentType: string read FContentType write FContentType;
    property ContentVersion: string read FContentVersion write FContentVersion;
    property CustomHeaders: TIdHeaderList read FCustomHeaders write SetCustomHeaders;
    property Date: TDateTime read FDate write FDate;
    property Expires: TDateTime read FExpires write FExpires;
    property LastModified: TDateTime read FLastModified write FLastModified;
    property Pragma: string read FPragma write FPragma;
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
    FRange: String;
    FBasicByDefault: Boolean;
    FAuthentication: TIdAuthentication;
    //
    procedure AssignTo(Destination: TPersistent); override;
    procedure ProcessHeaders; override;
    procedure SetHeaders; override;
  public
    //
    procedure Clear; override;
    property Authentication: TIdAuthentication read FAuthentication write FAuthentication;
    destructor Destroy; override;
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
    property Range: String read FRange write FRange;
  end;

  TIdResponseHeaderInfo = class(TIdEntityHeaderInfo)
  private
  protected
    FLocation: string;
    FServer: string;
    FProxyConnection: string;
    FProxyAuthenticate: TIdHeaderList;
    FWWWAuthenticate: TIdHeaderList;
    //
    procedure SetProxyAuthenticate(const Value: TIdHeaderList);
    procedure SetWWWAuthenticate(const Value: TIdHeaderList);

    procedure ProcessHeaders; override;
  public
    procedure Clear; override;
    constructor Create; override;
    destructor Destroy; override;
  published
    property Location: string read FLocation write FLocation;
    property ProxyConnection: string read FProxyConnection write FProxyConnection;
    property ProxyAuthenticate: TIdHeaderList read FProxyAuthenticate write SetProxyAuthenticate;
    property Server: string read FServer write FServer;
    property WWWAuthenticate: TIdHeaderList read FWWWAuthenticate write SetWWWAuthenticate;
  end;

implementation

const
  DefaultUserAgent = 'Mozilla/3.0 (compatible; Indy Library)'; {do not localize}

{ TIdEntityHeaderInfo }

constructor TIdEntityHeaderInfo.Create;
begin
  inherited Create;

  FRawHeaders := TIdHeaderList.Create;
  FRawHeaders.FoldLength := 1024;

  FCustomHeaders := TIdHeaderList.Create;

  Clear;
end;

destructor TIdEntityHeaderInfo.Destroy;
begin
  Sys.FreeAndNil(FRawHeaders);
  Sys.FreeAndNil(FCustomHeaders);
  inherited Destroy;
end;

procedure TIdEntityHeaderInfo.AssignTo(Destination: TPersistent);
begin
  if Destination is TIdEntityHeaderInfo then
  begin
    with Destination as TIdEntityHeaderInfo do
    begin
      FRawHeaders.Assign(Self.FRawHeaders);
      FContentEncoding := Self.FContentEncoding;
      FContentLanguage := Self.FContentLanguage;
      FContentType := Self.FContentType;
      FContentVersion := Self.FContentVersion;
      FContentLength := Self.FContentLength;
      FContentRangeEnd:= Self.FContentRangeEnd;
      FContentRangeStart:= Self.FContentRangeStart;
      FContentRangeInstanceLength := Self.FContentRangeInstanceLength;
      FDate := Self.FDate;
      FExpires := Self.FExpires;
      FLastModified := Self.FLastModified;
    end;
  end
  else
    inherited AssignTo(Destination);
end;

procedure TIdEntityHeaderInfo.Clear;
begin
  FConnection := '';
  FContentVersion := '';
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
  FContentRangeStart := 0;
  FContentRangeEnd := 0;
  FContentRangeInstanceLength := 0;
  FDate := 0;
  FLastModified := 0;
  FExpires := 0;
  FRawHeaders.Clear;
end;

procedure TIdEntityHeaderInfo.ProcessHeaders;
var
  LSecs: Integer;
  lRangeDecode: string;
  lCRange: string;
  lILength: string;
begin
  with FRawHeaders do
  begin
    FConnection := Values['Connection']; {do not localize}
    FContentVersion := Values['Content-Version']; {do not localize}
    FContentEncoding := Values['Content-Encoding']; {do not localize}
    FContentLanguage := Values['Content-Language']; {do not localize}
    FContentType := Values['Content-Type']; {do not localize}
    FContentLength := Sys.StrToInt(Sys.Trim(Values['Content-Length']), -1); {do not localize}
    FHasContentLength := FContentLength >= 0;

    FContentRangeStart := 0;
    FContentRangeEnd := 0;
    FContentRangeInstanceLength := 0;

    {
     handle content-range headers, like:

     content-range: bytes 1-65536/102400
     content-range: bytes */102400
     content-range: bytes 1-65536/*
    }
    lRangeDecode := Values['Content-Range']; {do not localize}
    if lRangeDecode <> '' then
    begin
      // strip the bytes unit, and keep the range and instance info
      Fetch(lRangeDecode);
      lCRange := Fetch(lRangeDecode, '/');
      lILength := Fetch(lRangeDecode);

      FContentRangeStart := Sys.StrToInt(Fetch(lCRange, '-'), 0);
      FContentRangeEnd := Sys.StrToInt(lCRange, 0);
      FContentRangeInstanceLength := Sys.StrToInt(lILength, 0);
    end;

    FDate := GMTToLocalDateTime(Values['Date']); {do not localize}
    FLastModified := GMTToLocalDateTime(Values['Last-Modified']); {do not localize}

    if Sys.StrToInt(Values['Expires'], -1) <> -1 then {do not localize}
    begin
      // This is happening when expires is an integer number in seconds
      LSecs := Sys.StrToInt(Values['Expires']); {do not localize}
      FExpires := Sys.Now +  (LSecs / SecsPerDay);
    end
    else
    begin
      FExpires := GMTToLocalDateTime(Values['Expires']); {do not localize}
    end;
    FPragma := Values['Pragma'];  {do not localize}
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
    end;
    if FContentLength >= 0 then
    begin
      Values['Content-Length'] := Sys.IntToStr(FContentLength); {do not localize}
    end;

    if HasContentRange or HasContentRangeInstance then
    begin
      Values['Content-Range'] := 'bytes ' + {do not localize}
        iif(HasContentRange,
          Sys.Format('%d%s%d', [FContentRangeStart, '-', FContentRangeEnd]), '*') + '/' + {do not localize}
        iif(HasContentRangeInstance,
          Sys.Format('%d', [FContentRangeInstanceLength]), '*'); {do not localize}
    end;

    if Length(FCacheControl) > 0 then
    begin
      Values['Cache-control'] := FCacheControl; {do not localize}
    end;
    if FDate > 0 then
    begin
      Values['Date'] := DateTimeGMTToHttpStr(FDate); {do not localize}
    end;
    if FExpires > 0 then
    begin
      Values['Expires'] := DateTimeGMTToHttpStr(FExpires); {do not localize}
    end;

    if Length(FPragma) > 0 then
    begin
      Values['Pragma'] := FPragma; {do not localize}
    end;

    if FCustomHeaders.Count > 0 then
    begin
      // Append Custom headers
      Text := Text + FCustomHeaders.Text;
    end;
  end;
end;

procedure TIdEntityHeaderInfo.SetCustomHeaders(const AValue: TIdHeaderList);
begin
  FCustomHeaders.Assign(AValue);
end;

procedure TIdEntityHeaderInfo.SetContentLength(const AValue: Integer);
begin
  FContentLength := AValue;
  FHasContentLength := FContentLength >= 0;
end;

function TIdEntityHeaderInfo.GetHasContentRange: Boolean;
begin
  Result := (FContentRangeEnd > 0);
end;

function TIdEntityHeaderInfo.GetHasContentRangeInstance: Boolean;
begin
  Result := (FContentRangeInstanceLength > 0);
end;


{ TIdProxyConnectionInfo }

constructor TIdProxyConnectionInfo.Create;
begin
  inherited Create;
  Clear;
end;

destructor TIdProxyConnectionInfo.Destroy;
begin
  if Assigned(FAuthentication) then
  begin
    Sys.FreeAndNil(FAuthentication);
  end;
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
  else inherited AssignTo(Destination);
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
        Values['Proxy-Authorization'] := S; {do not localize}
      end
      else
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
    Sys.FreeAndNil(FAuthentication);
  FPort := Value;
end;

procedure TIdProxyConnectionInfo.SetProxyServer(const Value: string);
begin
  if not TextIsSame(Value, FServer) then
    Sys.FreeAndNil(FAuthentication);
  FServer := Value;
end;

{ TIdRequestHeaderInfo }

procedure TIdRequestHeaderInfo.ProcessHeaders;
var
  lRangeHdr: String;
  lRangeVal: String;
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

    // strip off the 'bytes=' portion of the header
    lRangeHdr := Values['Range'];                   {do not localize}
    lRangeVal := '';
    if Length(lRangeHdr) > 0 then
    begin
      lRangeVal := Fetch(lRangeHdr, '=');           {do not localize}
    end;
    FRange := lRangeVal;
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

      FRange := Self.FRange;

      // TODO: omitted intentionally?
      // FHost := Self.FHost;
      // FProxyConnection := Self.FProxyConnection;
    end;
  end
  else
    inherited AssignTo(Destination);
end;

procedure TIdRequestHeaderInfo.Clear;
begin
  FAccept := 'text/html, */*'; {do not localize}
  FAcceptCharSet := '';
  FUserAgent := DefaultUserAgent;
  FBasicByDefault := false;
  FRange := '';

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
    if Length(FRange) > 0 then
    begin
      Values['Range'] := 'bytes=' + FRange; {do not localize}
    end;

    // use 'Last-Modified' entity header in the conditional request
    if FLastModified > 0 then
    begin
      Values['If-Modified-Since'] := DateTimeGMTToHttpStr(FLastModified); {do not localize}
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
  end;
end;

destructor TIdRequestHeaderInfo.Destroy;
begin
  if Assigned(Authentication) then
  begin
    Sys.FreeAndNil(FAuthentication);
  end;
  inherited;
end;

{ TIdResponseHeaderInfo }

constructor TIdResponseHeaderInfo.Create;
begin
  inherited Create;
  FContentType := 'text/html';  {do not localize}
  FWWWAuthenticate := TIdHeaderList.Create;
  FProxyAuthenticate := TIdHeaderList.Create;
end;

destructor TIdResponseHeaderInfo.Destroy;
begin
  Sys.FreeAndNil(FWWWAuthenticate);
  Sys.FreeAndNil(FProxyAuthenticate);
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
    FLocation := Values['Location'];                {do not localize}
    FServer := Values['Server'];                    {do not localize}
    FProxyConnection := Values['Proxy-Connection']; {do not localize}

    FWWWAuthenticate.Clear;
    Extract('WWW-Authenticate', FWWWAuthenticate);   {do not localize}

    FProxyAuthenticate.Clear;
    Extract('Proxy-Authenticate', FProxyAuthenticate); {do not localize}
  end;
end;

procedure TIdResponseHeaderInfo.Clear;
begin
  inherited Clear;
  // S.G. 20/4/2003: Default to text/HTML
  FContentType := 'text/html';  {do not localize}

  FLocation := '';
  FServer := '';
  if Assigned(FProxyAuthenticate) then
  begin
    FProxyAuthenticate.Clear;
  end;

  if Assigned(FWWWAuthenticate) then
  begin
    FWWWAuthenticate.Clear;
  end;
end;

end.

