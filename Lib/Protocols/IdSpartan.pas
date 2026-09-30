unit IdSpartan;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdTCPClient, IdGlobal, IdException, IdIOHandler,
  IdExceptionCore, IdURI, IdIDN;

type
  TSpartanStatus = (ssUnknown, ssSuccess, ssRedirect, ssClientError, ssServerError,
    ssInput, ssSensitiveInput);

  TSpartanResponse = class
  public
    Status: TSpartanStatus;
    Meta: string;
    Content: TMemoryStream;
    ContentType: string;    // Added for MIME type handling
    Charset: string;       // Added for character set information
    constructor Create;
    destructor Destroy; override;
  end;

  TIdSpartanOnRedirectEvent = procedure(Sender: TObject; var NewLocation: String;
    var RedirectCount: Integer; var Handled: Boolean) of object;

  TIdSpartan = class(TIdTCPClient)
  private
    FRedirectCount: Integer;
    FRedirectMax: Integer;
    FHandleRedirects: Boolean;
    FOnRedirect: TIdSpartanOnRedirectEvent;
  protected
    function InternalRequest(const AHost, Path: string; const Data: TStream): TSpartanResponse;
    procedure InitComponent; override;
    function EncodePath(const APath: string): string; // Path encoding helper
    function ToPunycode(const ADomain: string): string; // Fallback implementation
    function HasNonASCII(const AStr: string): Boolean;
  public
    function Request(const AHost, Path: string; const Data: TStream = nil): TSpartanResponse; overload;
    function Request(const AHost, Path: string; const AInput: string): TSpartanResponse; overload;
  published
    property HandleRedirects: Boolean read FHandleRedirects write FHandleRedirects default True;
    property RedirectMax: Integer read FRedirectMax write FRedirectMax default 5;
    property OnRedirect: TIdSpartanOnRedirectEvent read FOnRedirect write FOnRedirect;
    property Port default 300;
  end;

implementation

uses
  IdCoderMIME;

{ TSpartanResponse }

constructor TSpartanResponse.Create;
begin
  inherited Create;
  Status := ssUnknown;
  Meta := '';
  Content := nil;
  ContentType := '';
  Charset := '';
end;

destructor TSpartanResponse.Destroy;
begin
  FreeAndNil(Content);
  inherited Destroy;
end;

{ TIdSpartan }

procedure TIdSpartan.InitComponent;
begin
  inherited InitComponent;
  FHandleRedirects := True;
  FRedirectMax := 5;
  Port := 300; // Default Spartan port
  InitIDNLibrary
end;

function TIdSpartan.ToPunycode(const ADomain: string): string;
{$IFDEF WIN32_OR_WIN64}
var
  LUnicodeDomain: TIdUnicodeString;
{$ENDIF}
begin
  {$IFDEF WIN32_OR_WIN64}
  // Check if domain contains non-ASCII characters
  if UseIDNAPI and (ADomain <> '') then
  begin
    // Convert to Unicode string
    {$IFDEF STRING_IS_UNICODE}
    LUnicodeDomain := ADomain;
    {$ELSE}
    LUnicodeDomain := TIdUnicodeString(ADomain);
    {$ENDIF}

    // Check if conversion is needed (contains non-ASCII)
    if HasNonASCII(ADomain) then
    begin
      try
        Result := IDNToPunnyCode(LUnicodeDomain);
        Exit;
      except
        // Fall back to original domain if conversion fails
      end;
    end;
  end;
  {$ENDIF}

  // Fallback: return domain as-is
  Result := ADomain;
end;

function TIdSpartan.HasNonASCII(const AStr: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(AStr) do
  begin
    if Ord(AStr[i]) > 127 then
    begin
      Result := True;
      Exit;
    end;
  end;
end;


function TIdSpartan.EncodePath(const APath: string): string;
begin
  // Simple path encoding - handles most common cases
  Result := TIdURI.ParamsEncode(APath);
end;

function TIdSpartan.Request(const AHost, Path: string; const AInput: string): TSpartanResponse;
var
  Data: TMemoryStream;
  Line: string;
begin
  if AInput = '' then
  begin
    Result := Request(AHost, Path, nil);
    Exit;
  end;
  // the body is a line, and it has to be kept in a variable of its own, the
  // temporary of the expression is gone before the write happens
  Line := AInput + #13#10;
  Data := TMemoryStream.Create;
  try
    Data.Write(Line[1], Length(Line));
    Result := Request(AHost, Path, Data);
  finally
    Data.Free;
  end;
end;

function TIdSpartan.InternalRequest(const AHost, Path: string; const Data: TStream): TSpartanResponse;
var
  ReqLine, StatusLine: string;
  StatusCode: Integer;
  Len: Integer;
  LActualHost: string;
  LActualPath: string;
  ParamPos: Integer;
  MetaStart: Integer;
begin
  Result := TSpartanResponse.Create;

  try
    // Handle IDN domains
    LActualHost := ToPunycode(AHost);
    LActualPath := EncodePath(Path);

    Host := LActualHost;
    if not Connected then Connect;

    // Calculate content length
    if Assigned(Data) then
      Len := Data.Size
    else
      Len := 0;

    // Send request line: "host path length"
    ReqLine := LActualHost + ' ' + LActualPath + ' ' + IntToStr(Len);
    IOHandler.WriteLn(ReqLine);

    // Send data if present
    if Assigned(Data) then
    begin
      Data.Position := 0;
      IOHandler.Write(Data, Len);
    end;

    // Read status line
    StatusLine := IOHandler.ReadLn;
    if Length(StatusLine) < 3 then Exit;

    // 2 to 5 are one digit, 10 and 11 are two, then a space and the meta
    if StatusLine[1] = '1' then
    begin
      StatusCode := StrToIntDef(Copy(StatusLine, 1, 2), -1);
      MetaStart := 4;
    end
    else
    begin
      StatusCode := StrToIntDef(Copy(StatusLine, 1, 1), -1);
      MetaStart := 3;
    end;

    // Parse meta (everything after the status code and the space)
    if Length(StatusLine) >= MetaStart then
      Result.Meta := Trim(Copy(StatusLine, MetaStart, MaxInt))
    else
      Result.Meta := '';

    // Set status based on code
    case StatusCode of
      2: Result.Status := ssSuccess;
      3: Result.Status := ssRedirect;
      4: Result.Status := ssClientError;
      5: Result.Status := ssServerError;
      10: Result.Status := ssInput;
      11: Result.Status := ssSensitiveInput;
    else
      Result.Status := ssUnknown;
    end;

    // Parse MIME type for success responses
    if Result.Status = ssSuccess then
    begin
      // Extract content type and charset
      ParamPos := Pos(';', Result.Meta);
      if ParamPos > 0 then
      begin
        Result.ContentType := Copy(Result.Meta, 1, ParamPos - 1);
        Result.Charset := Trim(Copy(Result.Meta, ParamPos + 1, MaxInt));
        // Remove charset= prefix if present
        if Pos('charset=', LowerCase(Result.Charset)) = 1 then
          Result.Charset := Copy(Result.Charset, 9, MaxInt);
      end
      else
      begin
        Result.ContentType := Result.Meta;
        Result.Charset := '';
      end;

      // Read content
      Result.Content := TMemoryStream.Create;
      try
        // Read raw content
        IOHandler.ReadStream(Result.Content, -1, True);
        Result.Content.Position := 0;
      except
        on E: EIdSilentException do
        begin
          // Connection closed gracefully - this is expected for Spartan
        end;
      end;
    end;

  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TIdSpartan.Request(const AHost, Path: string; const Data: TStream = nil): TSpartanResponse;
var
  LCurrentHost, LCurrentPath: string;
  LNewLocation: string;
  LHandled: Boolean;
  LURI: TIdURI;
  LQueryPos: Integer;
  LActualPath: string;
  LQuery: string;
  LQueryStream: TStringStream;
  LTempData: TStream;
begin
  FRedirectCount := 0;
  LCurrentHost := AHost;

  // Handle query parameters if present
  LActualPath := Path;
  LQueryPos := Pos('?', LActualPath);
  if LQueryPos > 0 then
  begin
    // Extract query string, the url carries it encoded, the body does not
    LQuery := TIdURI.URLDecode(Copy(LActualPath, LQueryPos + 1, MaxInt));
    LActualPath := Copy(LActualPath, 1, LQueryPos - 1);

    // If no data stream provided, use query string as payload
    if (LQuery <> '') and not Assigned(Data) then
    begin
      LQueryStream := TStringStream.Create(LQuery);
      LTempData := LQueryStream;
    end
    else
    begin
      LTempData := Data;
      LQueryStream := nil;
    end;
  end
  else
  begin
    LTempData := Data;
    LQueryStream := nil;
  end;

  try
    LCurrentPath := LActualPath;
    Result := nil;

    try
      repeat
        // Free previous response if we're redirecting
        if Result <> nil then
          FreeAndNil(Result);

        // Make request
        Result := InternalRequest(LCurrentHost, LCurrentPath, LTempData);

        // Handle redirect if needed
        if (Result.Status = ssRedirect) and FHandleRedirects and (FRedirectCount < FRedirectMax) then
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
              // Handle relative URLs
              if LURI.Protocol = '' then
              begin
                // Relative path - keep current host and port
LCurrentHost := AHost;
                if LURI.Path <> '' then
                  LCurrentPath := LURI.Path
                else
                  LCurrentPath := LNewLocation;
              end
              else if SameText(LURI.Protocol, 'spartan') then
              begin
                // Enforce same-host redirect (Spartan spec requirement)
                if not TextIsSame(LURI.Host, LCurrentHost) then
                begin
                  // Protocol violation - break redirect loop
                  Break;
                end;

                // Absolute Spartan URL
                LCurrentHost := LURI.Host;
                if LURI.Port <> '' then
                  Port := IndyStrToInt(LURI.Port, 300);
                LCurrentPath := LURI.Path;
              end
              else
              begin
                // Unsupported protocol - treat as normal response
                Break;
              end;
            finally
              LURI.Free;
            end;
          end
          else
          begin
            // Event handler marked redirect as handled - return current response
            Break;
          end;
        end
        else
        begin
          // Not a redirect or redirect handling disabled - return response
          Break;
        end;
      until False;
    except
      FreeAndNil(Result);
      raise;
    end;
  finally
    // Free the query stream if we created it
    if Assigned(LQueryStream) then
      LQueryStream.Free;
  end;
end;

end.
