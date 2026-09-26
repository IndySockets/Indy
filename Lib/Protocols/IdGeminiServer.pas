unit IdGeminiServer;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdTCPServer, IdContext, IdGlobal, IdSSL, 
  IdServerIOHandlerSSLOpenSSL, IdSSLOpenSSL, IdURI, IdIDN;

type
  TGeminiStatus = (gsUnknown, gsInput, gsSensitiveInput, gsSuccess, 
    gsRedirectTemporary, gsRedirectPermanent, gsTempFailure, gsPermFailure, 
    gsCertRequired, gsCertNotAuthorized, gsCertNotValid);

  TGeminiRequestEvent = procedure(AContext: TIdContext; const AURL: string;
    out Status: TGeminiStatus; out Meta: string; var Response: TStream) of object;

  TIdGeminiServer = class(TIdTCPServer)
  private
    FOnGeminiRequest: TGeminiRequestEvent;
    FSSLIOHandler: TIdServerIOHandlerSSLOpenSSL;
    procedure InternalExecute(AContext: TIdContext);
    function StatusToCode(Status: TGeminiStatus): string;
    function VerifyPeer(ACertificate: TIdX509; AOk: Boolean;
      ADepth, AError: Integer): Boolean;
  protected
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    class procedure WriteStringToStream(Stream: TStream; const S: string; Encoding: TEncoding = nil);
    function GetClientCertificate(AContext: TIdContext): string;
    // The default TLS handler, created by this component. Assigning IOHandler
    // replaces it, in which case set the certificate and key on your own
    // handler, not on this property.
    property SSLIOHandler: TIdServerIOHandlerSSLOpenSSL read FSSLIOHandler;
  published
    property OnGeminiRequest: TGeminiRequestEvent read FOnGeminiRequest write FOnGeminiRequest;
    property DefaultPort default 1965;
  end;

implementation

{ TIdGeminiServer }

procedure TIdGeminiServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := 1965;
  OnExecute := InternalExecute;
  
  // Create and configure a default SSL/TLS handler. Indy's own OpenSSL support
  // stops at 1.0.x, so this is only a default: an application that wants a
  // different TLS stack replaces IOHandler with its own handler and sets the
  // certificate and key on that handler instead.
  FSSLIOHandler := TIdServerIOHandlerSSLOpenSSL.Create(Self);
  FSSLIOHandler.SSLOptions.Method := sslvTLSv1_2;
  FSSLIOHandler.SSLOptions.Mode := sslmServer;
  // Gemini clients present self-signed client certificates by default.
  // Whether such a certificate is trusted is a purely application-level
  // decision (e.g. by checking the fingerprint reported by
  // GetClientCertificate()), so accept any certificate that is presented.
  // Servers that need strict chain validation can override OnVerifyPeer.
  FSSLIOHandler.SSLOptions.VerifyMode := [sslvrfPeer];
  FSSLIOHandler.SSLOptions.VerifyDepth := 0;
  FSSLIOHandler.OnVerifyPeer := VerifyPeer;
  IOHandler := FSSLIOHandler;

  InitIDNLibrary;
end;

function TIdGeminiServer.VerifyPeer(ACertificate: TIdX509; AOk: Boolean;
  ADepth, AError: Integer): Boolean;
begin
  Result := True;
end;

destructor TIdGeminiServer.Destroy;
begin
  inherited Destroy;
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

class procedure TIdGeminiServer.WriteStringToStream(Stream: TStream; const S: string; Encoding: TEncoding);
var
  Bytes: TBytes;
begin
  if Encoding = nil then
    Encoding := TEncoding.UTF8;

  Bytes := Encoding.GetBytes(S);
  if Length(Bytes) > 0 then
    Stream.WriteBuffer(Bytes[0], Length(Bytes));
end;

function TIdGeminiServer.GetClientCertificate(AContext: TIdContext): string;
var
  LIO: TIdSSLIOHandlerSocketOpenSSL;
  LCert: TIdX509;
begin
  Result := '';
  if AContext = nil then begin
    Exit;
  end;
  LIO := TIdSSLIOHandlerSocketOpenSSL(AContext.Connection.IOHandler);
  if (LIO <> nil) and (LIO.SSLSocket <> nil) then begin
    LCert := LIO.SSLSocket.PeerCert;
    if (LCert <> nil) and (LCert.Fingerprints <> nil) then begin
      Result := LCert.Fingerprints.SHA256AsString;
    end;
  end;
end;

procedure TIdGeminiServer.InternalExecute(AContext: TIdContext);
var
  RequestURL: string;
  ResponseStream: TMemoryStream;
  Status: TGeminiStatus;
  Meta: string;
  StatusCode: string;
  LURI: TIdURI;
begin
  ResponseStream := nil;
  LURI := nil;

  try
    // TIdServerIOHandlerSSLOpenSSL.Accept() leaves the accepted socket in
    // PassThrough mode. Flip it here so the TLS handshake (and client-cert
    // negotiation) actually runs against the shared server SSL context.
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough := False;

    // Guard against overly long request lines (spec allows max 1024 bytes for
    // the URL itself). This prevents a hostile client from flooding our buffers.
    AContext.Connection.IOHandler.MaxLineLength := 1026;

    // Read request line (URL + CRLF)
    try
      RequestURL := AContext.Connection.IOHandler.ReadLn;
    except
      on E: Exception do
      begin
        // Client disconnected mid-request or request line exceeded the size limit
        if AContext.Connection.Connected then
        begin
          try
            AContext.Connection.IOHandler.WriteLn('59 Malformed request');
          except
            on E: Exception do begin
              Exit;
            end;
          end;
        end;
        Exit;
      end;
    end;
    
    // Validate request
    if RequestURL = '' then
    begin
      AContext.Connection.IOHandler.WriteLn('59 Empty request');
      Exit;
    end;

    // Check URL length (max 1024 bytes per spec)
    if Length(RequestURL) > 1024 then
    begin
      AContext.Connection.IOHandler.WriteLn('59 URL too long');
      Exit;
    end;

    // Parse and validate URL
    try
      LURI := TIdURI.Create(RequestURL);
      
      // Reject requests with userinfo
      if LURI.Username <> '' then
      begin
        AContext.Connection.IOHandler.WriteLn('59 Userinfo not allowed');
        Exit;
      end;

      // Reject requests with fragments
      if LURI.Bookmark <> '' then
      begin
        AContext.Connection.IOHandler.WriteLn('59 Fragments not allowed');
        Exit;
      end;

      // A Gemini request has to be a valid gemini:// URL
      if (LURI.Host = '') or not SameText(LURI.Protocol, 'gemini') then
      begin
        AContext.Connection.IOHandler.WriteLn('59 Invalid URL');
        Exit;
      end;
    except
      on E: Exception do
      begin
        AContext.Connection.IOHandler.WriteLn('59 Invalid URL format');
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
    AContext.Connection.IOHandler.WriteLn(StatusCode + ' ' + Meta);

    // Send response body for successful requests
    if (Status = gsSuccess) and Assigned(ResponseStream) then
    begin
      ResponseStream.Position := 0;
      AContext.Connection.IOHandler.Write(ResponseStream, 0, False);
    end;
    
  finally
    // Cleanup
    FreeAndNil(LURI);
    FreeAndNil(ResponseStream);

    // Gemini requires connection close after each request
    if AContext.Connection.Connected then
    begin
      AContext.Connection.Disconnect;
    end;
  end;
end;

end.
