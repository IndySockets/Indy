unit IdGeminiServer;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdCustomTCPServer, IdContext, IdGlobal, IdAssignedNumbers,
  IdSSL, IdIOHandler, IdException, IdExceptionCore, IdURI, IdIDN;

type
  TGeminiStatus = (gsUnknown, gsInput, gsSensitiveInput, gsSuccess, 
    gsRedirectTemporary, gsRedirectPermanent, gsTempFailure, gsPermFailure, 
    gsCertRequired, gsCertNotAuthorized, gsCertNotValid);

  // Response is owned by the server, not by the handler: write the body into
  // it and leave it alone afterwards. The server sends it when Status is
  // gsSuccess and frees it once the connection is done, so a handler must
  // neither free it nor keep using it after it returns. Meta becomes the
  // remainder of the status line, so it has to stay on one line and free of
  // any CR or LF.
  TGeminiRequestEvent = procedure(AContext: TIdContext; const AURL: string;
    out Status: TGeminiStatus; out Meta: string; var Response: TStream) of object;

  // Reports whatever identifies the client certificate for AContext, typically
  // the SHA256 fingerprint of a self-signed certificate that the user has
  // confirmed once. The server does not look at the certificate itself: the
  // handler on AContext belongs to whichever TLS stack the application
  // assigned, and only that application knows how to read a peer certificate
  // out of it.
  TIdGeminiOnGetClientCertEvent = function(Sender: TObject;
    AContext: TIdContext): string of object;

  TIdGeminiServer = class(TIdCustomTCPServer)
  private
    FOnGeminiRequest: TGeminiRequestEvent;
    FOnGetClientCertificate: TIdGeminiOnGetClientCertEvent;
    procedure WriteStatus(AContext: TIdContext; const AStatus: string);
    function StatusToCode(Status: TGeminiStatus): string;
  protected
    function DoExecute(AContext: TIdContext): Boolean; override;
    procedure CheckOkToBeActive; override;
    procedure InitComponent; override;
  public
    function GetClientCertificate(AContext: TIdContext): string;
  published
    property OnGeminiRequest: TGeminiRequestEvent read FOnGeminiRequest write FOnGeminiRequest;
    property OnGetClientCertificate: TIdGeminiOnGetClientCertEvent read FOnGetClientCertificate write FOnGetClientCertificate;
    property DefaultPort default IdPORT_GEMINI;
  end;

implementation

{ TIdGeminiServer }

procedure TIdGeminiServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_GEMINI;

  // Gemini requires TLS, but no handler is created here on purpose.  Indy's own
  // OpenSSL handler is only one of the possible TLS stacks: building it would
  // drag IdSSLOpenSSL into every project that uses this component, and would
  // stop an application that wants TaurusTLS, or anything else, from speaking
  // its own stack.  So the application assigns its own handler to IOHandler, and
  // CheckOkToBeActive() refuses to listen without one, rather than serving
  // plaintext on a port that is supposed to be Gemini.
  //
  // That handler also owns certificate verification.  Gemini clients commonly
  // present self-signed client certificates, and whether such a certificate is
  // trusted is an application-level decision, e.g. by checking the fingerprint
  // reported by GetClientCertificate().  A server that wants strict chain
  // validation configures that on its own handler.
  InitIDNLibrary;
end;

procedure TIdGeminiServer.CheckOkToBeActive;
begin
  inherited CheckOkToBeActive;
  if not (IOHandler is TIdServerIOHandlerSSLBase) then
    raise EIdException.Create(
      'Gemini requires TLS: assign a TLS handler to IOHandler before listening, ' +
      'for example TTaurusTLSServerIOHandler or TIdServerIOHandlerSSLOpenSSL.');
end;

procedure TIdGeminiServer.WriteStatus(AContext: TIdContext; const AStatus: string);
begin
  // Only worth writing if there is still a peer to write it to.  A failure of
  // the write itself is deliberately not caught: the server is closing this
  // connection either way, and an error from here would only hide whatever
  // the server was already going to report about it.
  if AContext.Connection.Connected then begin
    AContext.Connection.IOHandler.WriteLn(AStatus);
  end;
end;

function TIdGeminiServer.StatusToCode(Status: TGeminiStatus): string;
begin
  case Status of
    gsInput:                Result := '10';
    gsSensitiveInput:       Result := '11';
    gsSuccess:              Result := '20';
    gsRedirectTemporary:    Result := '30';
    gsRedirectPermanent:    Result := '31';
    gsTempFailure:          Result := '40';
    gsPermFailure:          Result := '50';
    gsCertRequired:         Result := '60';
    gsCertNotAuthorized:    Result := '61';
    gsCertNotValid:         Result := '62';
  else
    Result := '50'; // Unknown status defaults to server error
  end;
end;

function TIdGeminiServer.GetClientCertificate(AContext: TIdContext): string;
begin
  // The peer certificate belongs to the TLS handler the application assigned,
  // and only the application knows how to read it back out of the stack it
  // chose. So this reports what that application reports, rather than
  // hard-casting to one stack's handler and returning nothing for all the
  // others. What an absent certificate should report is the application's
  // call too, so an event is free to return an empty string for one.
  Result := '';
  if Assigned(FOnGetClientCertificate) then begin
    Result := FOnGetClientCertificate(Self, AContext);
  end;
end;

function TIdGeminiServer.DoExecute(AContext: TIdContext): Boolean;
var
  RequestURL: string;
  ResponseStream: TMemoryStream;
  Status: TGeminiStatus;
  Meta: string;
  StatusCode: string;
  LURI: TIdURI;
  LIOHandler: TIdIOHandler;
begin
  ResponseStream := nil;
  LURI := nil;
  // Gemini closes the connection after every request, so this never reports
  // the context as still connected. See the Disconnect in the finally block
  // for why that is done explicitly rather than left to this value.
  Result := False;

  try
    LIOHandler := AContext.Connection.IOHandler;

    // TIdServerIOHandlerSSLOpenSSL.Accept() leaves the accepted socket in
    // PassThrough mode. Flip it here so the TLS handshake (and client-cert
    // negotiation) actually runs against the shared server SSL context. The
    // test guards against an application that replaced IOHandler with a
    // handler that has no PassThrough to flip.
    if LIOHandler is TIdSSLIOHandlerSocketBase then begin
      TIdSSLIOHandlerSocketBase(LIOHandler).PassThrough := False;
    end;

    // Read the request line (URL + CRLF).  The spec allows 1024 bytes for the
    // URL itself, and ReadLn() does not count the terminator when it validates
    // the length, so 1024 is the number to pass, not 1026.
    //
    // The terminator is given as EOL because ReadLn()'s default is LF, and a
    // Gemini request ends with CRLF.  The limit is passed per call rather than
    // by setting IOHandler.MaxLineLength, which would reach into the handler's
    // own configuration and fight with whatever else the application is doing
    // with it.
    try
      RequestURL := LIOHandler.ReadLn(EOL, -1, 1024);
    except
      // An over-long request line is the client's mistake and gets a 59; a
      // read timeout or a dead socket is not something a status line can be
      // written to, and letting those through is the server's own business
      // rather than something to answer.  Catching Exception here would turn
      // a timeout into a malformed request, and would also swallow anything
      // the handler raises for a reason that has nothing to do with the
      // request at all.
      on E: EIdReadLnMaxLineLengthExceeded do
      begin
        WriteStatus(AContext, '59 Request line too long');
        Exit;
      end;
      on E: EIdReadTimeout do
      begin
        Exit;
      end;
      on E: EIdConnClosedGracefully do
      begin
        Exit;
      end;
    end;
    
    // Validate request
    if RequestURL = '' then
    begin
      WriteStatus(AContext, '59 Empty request');
      Exit;
    end;

    // Parse and validate URL
    try
      LURI := TIdURI.Create(RequestURL);
      
      // Reject requests with userinfo
      if LURI.Username <> '' then
      begin
        WriteStatus(AContext, '59 Userinfo not allowed');
        Exit;
      end;

      // Reject requests with fragments
      if LURI.Bookmark <> '' then
      begin
        WriteStatus(AContext, '59 Fragments not allowed');
        Exit;
      end;

      // A Gemini request has to be a valid gemini:// URL
      if (LURI.Host = '') or not SameText(LURI.Protocol, 'gemini') then
      begin
        WriteStatus(AContext, '59 Invalid URL');
        Exit;
      end;
    except
      on E: Exception do
      begin
        WriteStatus(AContext, '59 Invalid URL format');
        Exit;
      end;
    end;

    // Prepare response
    Status := gsPermFailure;
    Meta := 'No handler configured';
    ResponseStream := TMemoryStream.Create;

    // Call event handler
    if Assigned(FOnGeminiRequest) then
      FOnGeminiRequest(AContext, RequestURL, Status, Meta, ResponseStream);

    // Convert status to status code
    StatusCode := StatusToCode(Status);

    // Send response header
    LIOHandler.WriteLn(StatusCode + ' ' + Meta);

    // Send response body for successful requests
    if (Status = gsSuccess) and Assigned(ResponseStream) then
    begin
      ResponseStream.Position := 0;
      LIOHandler.Write(ResponseStream, 0, False);
    end;
    
  finally
    // Cleanup. The response stream was handed to the event handler and is
    // freed here rather than by the handler; see TGeminiRequestEvent.
    FreeAndNil(LURI);
    FreeAndNil(ResponseStream);

    // Gemini requires connection close after each request. Returning False
    // above only stops the context thread, so the socket is disconnected
    // explicitly to actually close it, and in the right order relative to the
    // finally block so the response has been written first.
    if AContext.Connection.Connected then
    begin
      AContext.Connection.Disconnect;
    end;
  end;
end;

end.
