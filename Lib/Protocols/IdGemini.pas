unit IdGemini;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdTCPClient, IdGlobal, IdAssignedNumbers, IdException, IdSSL,
  IdURI, IdIDN;

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
    FRedirectCount: Integer;
    FRedirectMax: Integer;
    FHandleRedirects: Boolean;
    FResponse: TGeminiResponse;
    FOnRedirect: TIdGeminiOnRedirectEvent;
    function StatusCodeToEnum(Code: Integer): TGeminiStatus;
    function ResolveURL(const ABaseURL, ARelative: string): string;
    procedure CheckTLSHandler;
  protected
    function InternalRequest(const AURL: string): TGeminiResponse;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    { Request() returns True when a response is available.  The response itself
      is held in Response and belongs to this component, so a caller that needs
      to keep the data past the next Request() makes its own copy of it. }
    function Request(const AURL: string): Boolean; overload;
    function Request(const AURL, AInput: string): Boolean; overload;
    property Response: TGeminiResponse read FResponse;
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

  // Gemini requires TLS, but no handler is created here on purpose.  Indy's own
  // OpenSSL handler is only one of the possible TLS stacks: building it would
  // drag IdSSLOpenSSL into every project that uses this component, and would
  // stop an application that wants TaurusTLS, or anything else, from speaking
  // its own stack.  So the application assigns its own handler to IOHandler and
  // CheckTLSHandler() refuses to go out without one, rather than quietly
  // falling back to plaintext, which Gemini must never use.
  //
  // Certificate verification belongs to that handler too.  Indy's OpenSSL layer
  // does not check the host name against the certificate, and Gemini servers
  // are commonly self-signed, so a client that wants to pin a server sets
  // VerifyMode to [sslvrfPeer] on its own handler and decides in OnVerifyPeer,
  // typically against the SHA256 fingerprint of a certificate the user has
  // confirmed once.
  InitIDNLibrary;
end;

procedure TIdGemini.CheckTLSHandler;
begin
  if not (IOHandler is TIdSSLIOHandlerSocketBase) then
    raise EIdException.Create(
      'Gemini requires TLS: assign a TLS handler to IOHandler before making a ' +
      'request, for example TTaurusTLSIOHandlerSocket or ' +
      'TIdSSLIOHandlerSocketOpenSSL.');
end;

destructor TIdGemini.Destroy;
begin
  FreeAndNil(FResponse);
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
  LPath, LQuery, LSeg, LBasePath, LBaseDoc: string;
  LStack: array of string;
  LCount, LI: Integer;
  LC: Char;
  LStart: Boolean;
begin
  // Resolve a (possibly relative) redirect target against the current request
  // URL, following RFC 3986 section 5.
  LBase := TIdURI.Create(ABaseURL);
  try
    // The base's own query and fragment are not part of the path, and this
    // function only ever wants the path, so ask TIdURI to leave them out
    // instead of taking them apart again further down.
    LBase.Params := '';
    LBase.Bookmark := '';
    // With the path, the query and the fragment blanked, GetFullURI([]) is
    // just the origin: the scheme, the host, and the port unless the scheme
    // has a default one.  Asking TIdURI for that rather than concatenating the
    // pieces by hand also brackets an IPv6 host, which the concatenation did
    // not.
    LBasePath := LBase.Path;
    LBaseDoc := LBase.Document;
    LBase.Path := '';
    LBase.Document := '';
    Result := LBase.GetFullURI([]);
    if ARelative = '' then begin
      // Empty reference inherits the full base-path
      LPath := LBasePath + LBaseDoc;
    end else if (ARelative[1] = '?') or (ARelative[1] = '#') then begin
      // Query/fragment-only reference keeps the base document
      LPath := LBasePath + LBaseDoc + ARelative;
    end else if ARelative[1] = '/' then begin
      // protocol-relative or absolute-path reference
      LPath := ARelative;
    end else begin
      // TIdURI.Path always ends with '/' and holds the directory portion of
      // the base URL, so merging yields the correct parent directory.
      LPath := LBasePath + ARelative;
    end;
  finally
    FreeAndNil(LBase);
  end;

  // Separate a possible query/fragment portion from the path.  The base's own
  // query and fragment are already gone, so this is only ever about the query
  // of ARelative, but a relative reference can carry one just as well.
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
  // LStack is grown one segment at a time below, so its first read is the
  // Length() test that decides whether to SetLength. SetLength does not count
  // as initialisation to the compiler, hence the explicit nil.
  LStack := nil;
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
  // Fail before anything is allocated rather than after a plaintext request has
  // already been answered as though it were valid Gemini.
  CheckTLSHandler;
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

    // Connect unconditionally.  Gemini allows one request per connection and
    // the server closes after answering, so being connected here is the
    // exception rather than the rule, and testing for it only risks talking on
    // somebody else's connection.
    //
    // One request per connection, so the connection belongs to this request.
    // Leaving it to the caller to manage means a second request can land on a
    // connection the server is about to close, so it is dropped and made here.
    if Connected then
    begin
      Disconnect;
    end;

    // TIdTCPClient does not start TLS by itself; flip PassThrough so the
    // handler's ConnectClient() runs the handshake.  Done through the base
    // class so it works with whichever handler is in use.
    if IOHandler is TIdSSLIOHandlerSocketBase then
      TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
    Connect;

    // Send request (URL + CRLF)
    IOHandler.WriteLn(AURL);

    // Read the status line, which is a status code, a space, and the meta
    // string, and is limited to 1024 bytes by the spec.  ReadLn() does not
    // count the terminator when it validates, so 1024 is the number to pass.
    // The limit goes in as an argument rather than into IOHandler.MaxLineLength
    // so the application's own handler configuration is left alone.  EOL is
    // given explicitly because ReadLn()'s default terminator is LF and a
    // Gemini response ends with CRLF.
    StatusLine := IOHandler.ReadLn(EOL, -1, 1024);
    
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

      // Read content until the server closes the connection, which is how a
      // Gemini response ends.  A graceful close part way through is the normal
      // way this loop ends rather than a failure, so it is caught; anything
      // else is a real error and is left to propagate.
      Result.Content := TMemoryStream.Create;
      try
        IOHandler.ReadStream(Result.Content, -1, True);
        Result.Content.Position := 0;
      except
        on EIdConnClosedGracefully do
        begin
          // expected: the server closed after the body
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

function TIdGemini.Request(const AURL: string): Boolean;
var
  LCurrentURL: string;
  LNewLocation: string;
  LHandled: Boolean;
  LURI: TIdURI;
begin
  FRedirectCount := 0;
  LCurrentURL := AURL;

  repeat
    // The response belongs to this component rather than to the caller, so the
    // previous one goes before each new one is adopted.  Doing it here rather
    // than once up front also covers the redirects further round the loop.
    FreeAndNil(FResponse);

    // Make request.  InternalRequest() owns the connection, see there.
    FResponse := InternalRequest(LCurrentURL);

    // Handle redirect if needed
    if ((FResponse.Status = gsRedirectTemporary) or (FResponse.Status = gsRedirectPermanent)) 
       and FHandleRedirects and (FRedirectCount < FRedirectMax) then
    begin
      Inc(FRedirectCount);
      LNewLocation := FResponse.Meta;
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

  Result := FResponse <> nil;
end;

function TIdGemini.Request(const AURL, AInput: string): Boolean;
var
  LURL: string;
begin
  Request(AURL);

  // If the server asks for input (status 10 or 11), re-issue the request
  // with the input submitted as a query parameter, as the spec requires.  The
  // status is tested before the second call, because that call frees the
  // response the status came from.
  if (FResponse <> nil) and ((FResponse.Status = gsInput) or (FResponse.Status = gsSensitiveInput)) then
  begin
    LURL := AURL;
    if Pos('?', LURL) > 0 then
      LURL := LURL + '&'   {Do not Localize}
    else
      LURL := LURL + '?';  {Do not Localize}
    LURL := LURL + TIdURI.ParamsEncode(AInput, IndyTextEncoding(encUTF8));
    Request(LURL);
  end;

  Result := FResponse <> nil;
end;

end.
