unit IdGemini;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdTCPClient, IdGlobal, IdAssignedNumbers, IdException, IdSSL,
  IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdURI, IdIDN;

type
  TGeminiStatus = (gsUnknown, gsInput, gsSensitiveInput, gsSuccess, 
    gsRedirectTemporary, gsRedirectPermanent, gsTempFailure, gsPermFailure, 
    gsCertRequired, gsCertNotAuthorized, gsCertNotValid);

  TGeminiResponse = class
  public
    Status: TGeminiStatus;
    StatusCode: Integer;
    Meta: string;
    Content: TMemoryStream;
    ContentType: string;
    Charset: string;
    constructor Create;
    destructor Destroy; override;
  end;

  TIdGeminiOnRedirectEvent = procedure(Sender: TObject; var NewLocation: String;
    var RedirectCount: Integer; var Handled: Boolean) of object;

  TIdGemini = class(TIdTCPClient)
  private
    FSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    FRedirectCount: Integer;
    FRedirectMax: Integer;
    FHandleRedirects: Boolean;
    FOnRedirect: TIdGeminiOnRedirectEvent;
    function StatusCodeToEnum(Code: Integer): TGeminiStatus;
    function ResolveURL(const ABaseURL, ARelative: string): string;
  protected
    function InternalRequest(const AURL: string): TGeminiResponse;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    function Request(const AURL: string): TGeminiResponse; overload;
    function Request(const AURL, AInput: string): TGeminiResponse; overload;
    // The default TLS handler, created by this component. Assigning IOHandler
    // replaces it; configure your own handler, not this property, in that case.
    property SSLIOHandler: TIdSSLIOHandlerSocketOpenSSL read FSSLIOHandler;
  published
    property HandleRedirects: Boolean read FHandleRedirects write FHandleRedirects default True;
    property RedirectMax: Integer read FRedirectMax write FRedirectMax default 5;
    property OnRedirect: TIdGeminiOnRedirectEvent read FOnRedirect write FOnRedirect;
    property Port default IdPORT_GEMINI;
  end;

implementation

{ TGeminiResponse }

constructor TGeminiResponse.Create;
begin
  inherited Create;
  Status := gsUnknown;
  StatusCode := 0;
  Meta := '';
  Content := nil;
  ContentType := '';
  Charset := '';
end;

destructor TGeminiResponse.Destroy;
begin
  FreeAndNil(Content);
  inherited Destroy;
end;

{ TIdGemini }

procedure TIdGemini.InitComponent;
begin
  inherited InitComponent;
  FHandleRedirects := True;
  FRedirectMax := 5;
  Port := IdPORT_GEMINI;
  
  // Create and configure a default SSL/TLS handler. Indy's own OpenSSL support
  // stops at 1.0.x, so this is only a default: an application that wants a
  // different TLS stack, or different TLS options, replaces IOHandler with its
  // own handler and configures that instead.
  FSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  FSSLIOHandler.SSLOptions.Method := sslvTLSv1_2;
  FSSLIOHandler.SSLOptions.Mode := sslmClient;
  // Do not validate the server certificate by default. Gemini servers are
  // commonly self-signed, and indy's OpenSSL layer does not check the host
  // name against the certificate, so validating the chain would reject
  // self-signed servers without proving the host matches anyway. An
  // application that cares should set VerifyMode to [sslvrfPeer] and decide
  // in OnVerifyPeer, typically by pinning the SHA256 fingerprint of a
  // certificate the user has confirmed once.
  FSSLIOHandler.SSLOptions.VerifyMode := [];
  FSSLIOHandler.SSLOptions.VerifyDepth := 0;
  IOHandler := FSSLIOHandler;
  
  InitIDNLibrary;
end;

destructor TIdGemini.Destroy;
begin
  inherited Destroy;
end;

function TIdGemini.StatusCodeToEnum(Code: Integer): TGeminiStatus;
begin
  case Code of
    10: Result := gsInput;
    11: Result := gsSensitiveInput;
    20..29: Result := gsSuccess;
    30: Result := gsRedirectTemporary;
    31: Result := gsRedirectPermanent;
    40..49: Result := gsTempFailure;
    50..59: Result := gsPermFailure;
    60: Result := gsCertRequired;
    61: Result := gsCertNotAuthorized;
    62: Result := gsCertNotValid;
  else
    Result := gsUnknown;
  end;
end;

function TIdGemini.ResolveURL(const ABaseURL, ARelative: string): string;
var
  LBase: TIdURI;
  LPath, LQuery, LSeg: string;
  LStack: array of string;
  LCount, LI: Integer;
  LC: Char;
  LStart: Boolean;
begin
  // Resolve a (possibly relative) redirect target against the current request
  // URL, following RFC 3986 section 5.
  LBase := TIdURI.Create(ABaseURL);
  try
    Result := LBase.Protocol + '://' + LBase.Host;
    if LBase.Port <> '' then begin
      Result := Result + ':' + LBase.Port;
    end;
    if ARelative = '' then begin
      // Empty reference inherits the full base-path
      LPath := LBase.Path + LBase.Document;
    end else if (ARelative[1] = '?') or (ARelative[1] = '#') then begin
      // Query/fragment-only reference keeps the base document
      LPath := LBase.Path + LBase.Document + ARelative;
    end else if ARelative[1] = '/' then begin
      // protocol-relative or absolute-path reference
      LPath := ARelative;
    end else begin
      // TIdURI.Path always ends with '/' and holds the directory portion of
      // the base URL, so merging yields the correct parent directory.
      LPath := LBase.Path + ARelative;
    end;
  finally
    FreeAndNil(LBase);
  end;

  // Separate a possible query/fragment portion from the path
  LQuery := '';
  LI := 1;
  while LI <= Length(LPath) do begin
    if (LPath[LI] = '?') or (LPath[LI] = '#') then begin
      LQuery := Copy(LPath, LI, MaxInt);
      SetLength(LPath, LI - 1);
      Break;
    end;
    Inc(LI);
  end;

  // Remove dot segments (RFC 3986 section 5.2.4)
  LCount := 0;
  LSeg := '';
  LStart := (Length(LPath) > 0) and (LPath[1] = '/');
  for LI := 1 to Length(LPath) + 1 do begin
    if LI > Length(LPath) then begin
      if LSeg <> '' then begin
        if LSeg = '.' then begin
          // ignore
        end else if LSeg = '..' then begin
          if LCount > 0 then begin
            Dec(LCount);
          end;
        end else begin
          if LCount = Length(LStack) then begin
            SetLength(LStack, LCount + 1);
          end;
          LStack[LCount] := LSeg;
          Inc(LCount);
        end;
      end;
    end else if LPath[LI] = '/' then begin
      if LSeg <> '' then begin
        if LSeg = '.' then begin
          // ignore
        end else if LSeg = '..' then begin
          if LCount > 0 then begin
            Dec(LCount);
          end;
        end else begin
          if LCount = Length(LStack) then begin
            SetLength(LStack, LCount + 1);
          end;
          LStack[LCount] := LSeg;
          Inc(LCount);
        end;
        LSeg := '';
      end;
    end else begin
      LC := LPath[LI];
      LSeg := LSeg + LC;
    end;
  end;

  LPath := '';
  if LStart then begin
    LPath := '/';
  end;
  for LI := 0 to LCount - 1 do begin
    if LI > 0 then begin
      LPath := LPath + '/';
    end;
    LPath := LPath + LStack[LI];
  end;

  Result := Result + LPath + LQuery;
end;

function TIdGemini.InternalRequest(const AURL: string): TGeminiResponse;
var
  StatusLine: string;
  StatusCode: Integer;
  LURI: TIdURI;
  ParamPos: Integer;
begin
  Result := TGeminiResponse.Create;
  LURI := nil;

  try
    // Parse URL to set host and port
    LURI := TIdURI.Create(AURL);
    
    // Set connection parameters
    Host := LURI.Host;
    if LURI.Port <> '' then
      Port := IndyStrToInt(LURI.Port, IdPORT_GEMINI)
    else
      Port := IdPORT_GEMINI;

    // Connect if not already connected
    if not Connected then
    begin
      // TIdTCPClient does not start TLS automatically; flip PassThrough
      // so the handler's ConnectClient() runs the handshake. Done through the
      // base class so it works with whatever handler is in use.
      if IOHandler is TIdSSLIOHandlerSocketBase then
        TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
      Connect;
    end;

    // Send request (URL + CRLF)
    IOHandler.WriteLn(AURL);

    // Re-assert the 1024 byte header limit, in case the application replaced
    // the IOHandler after construction, which restores the 16 KB default.
    IOHandler.MaxLineLength := 1024;

    // Read status line
    StatusLine := IOHandler.ReadLn;
    
    if Length(StatusLine) < 3 then
    begin
      Result.Status := gsUnknown;
      Result.Meta := 'Invalid response';
      Exit;
    end;

    // Parse status code (first two characters)
    StatusCode := StrToIntDef(Copy(StatusLine, 1, 2), -1);
    Result.StatusCode := StatusCode;
    Result.Status := StatusCodeToEnum(StatusCode);

    // Parse meta (everything after "XX " where XX is status code)
    if Length(StatusLine) > 3 then
      Result.Meta := Trim(Copy(StatusLine, 4, MaxInt))
    else
      Result.Meta := '';

    // Read content for success responses
    if Result.Status = gsSuccess then
    begin
      // Parse MIME type and charset from meta
      ParamPos := Pos(';', Result.Meta);
      if ParamPos > 0 then
      begin
        Result.ContentType := Trim(Copy(Result.Meta, 1, ParamPos - 1));
        Result.Charset := Trim(Copy(Result.Meta, ParamPos + 1, MaxInt));
        // Remove charset= prefix if present
        if Pos('charset=', LowerCase(Result.Charset)) = 1 then
          Result.Charset := Trim(Copy(Result.Charset, 9, MaxInt));
      end
      else
      begin
        Result.ContentType := Trim(Result.Meta);
        Result.Charset := '';
      end;

      // Read content until connection closes
      Result.Content := TMemoryStream.Create;
      try
        IOHandler.ReadStream(Result.Content, -1, True);
        Result.Content.Position := 0;
      except
        on E: EIdSilentException do
        begin
          // Connection closed gracefully - expected for Gemini
        end;
      end;
    end;

  except
    on E: Exception do
    begin
      FreeAndNil(LURI);
      FreeAndNil(Result);
      raise;
    end;
  end;
  
  FreeAndNil(LURI);
end;

function TIdGemini.Request(const AURL: string): TGeminiResponse;
var
  LCurrentURL: string;
  LNewLocation: string;
  LHandled: Boolean;
  LURI: TIdURI;
begin
  FRedirectCount := 0;
  LCurrentURL := AURL;
  Result := nil;

  try
    repeat
      // Free previous response if redirecting
      if Result <> nil then
        FreeAndNil(Result);

      // Disconnect before making new request (Gemini closes after each response)
      if Connected then
        Disconnect;

      // Make request
      Result := InternalRequest(LCurrentURL);

      // Handle redirect if needed
      if ((Result.Status = gsRedirectTemporary) or (Result.Status = gsRedirectPermanent)) 
         and FHandleRedirects and (FRedirectCount < FRedirectMax) then
      begin
        Inc(FRedirectCount);
        LNewLocation := Result.Meta;
        LHandled := False;

        // Fire redirect event
        if Assigned(FOnRedirect) then
          FOnRedirect(Self, LNewLocation, FRedirectCount, LHandled);

        if not LHandled then
        begin
          // Parse the new location
          LURI := TIdURI.Create(LNewLocation);
          try
            if LURI.Protocol = '' then
            begin
              // Relative URL - resolve it against the current URL
              LCurrentURL := ResolveURL(LCurrentURL, LNewLocation);
            end
            else if SameText(LURI.Protocol, 'gemini') then
            begin
              // Absolute Gemini URL
              LCurrentURL := LNewLocation;
            end
            else
            begin
              // Different protocol - stop redirecting
              Break;
            end;
          finally
            LURI.Free;
          end;
        end
        else
        begin
          // Event handler marked redirect as handled
          Break;
        end;
      end
      else
      begin
        // Not a redirect or redirect handling disabled
        Break;
      end;
    until False;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdGemini.Request(const AURL, AInput: string): TGeminiResponse;
var
  LURL: string;
begin
  Result := Request(AURL);

  // If the server asks for input (status 10 or 11), re-issue the request
  // with the input submitted as a query parameter, as the spec requires.
  if (Result <> nil) and ((Result.Status = gsInput) or (Result.Status = gsSensitiveInput)) then
  begin
    LURL := AURL;
    if Pos('?', LURL) > 0 then
      LURL := LURL + '&'   {Do not Localize}
    else
      LURL := LURL + '?';  {Do not Localize}
    LURL := LURL + TIdURI.ParamsEncode(AInput, IndyTextEncoding(encUTF8));
    FreeAndNil(Result);
    Result := Request(LURL);
  end;
end;

end.
