unit IdSpartanServer;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdCustomTCPServer, IdContext, IdGlobal, IdAssignedNumbers,
  IdSpartan, IdURI, IdGlobalProtocols, IdIDN;

type
  // Response is owned by the server, not by the handler: write the body into
  // it and leave it alone afterwards. The server sends it when Status is
  // ssSuccess and frees it once the connection is done, so a handler must
  // neither free it nor keep using it after it returns. Meta becomes the
  // remainder of the status line, so it has to stay on one line and free of
  // any CR or LF.
  TSpartanRequestEvent = procedure(AContext: TIdContext; const Host, Path: string;
    Content: TStream; out Status: TSpartanStatus; out Meta: string; var Response: TStream) of object;

  TIdSpartanServer = class(TIdCustomTCPServer)
  private
    FOnSpartanRequest: TSpartanRequestEvent;
    function PunycodeToUnicode(const AHost: string): string;
  protected
    function DoExecute(AContext: TIdContext): Boolean; override;
    procedure InitComponent; override;
  public
  published
    property OnSpartanRequest: TSpartanRequestEvent read FOnSpartanRequest write FOnSpartanRequest;
    property DefaultPort default IdPORT_SPARTAN;
  end;

implementation

{ TIdSpartanServer }

procedure TIdSpartanServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_SPARTAN;
  InitIDNLibrary;
end;

function TIdSpartanServer.PunycodeToUnicode(const AHost: string): string;
{$IFDEF WIN32_OR_WIN64}
var
  LUnicodeHost: TIdUnicodeString;
{$ENDIF}
begin
  {$IFDEF WIN32_OR_WIN64}
  if UseIDNAPI and (Pos('xn--', LowerCase(AHost)) > 0) then
  begin
    try
      LUnicodeHost := PunnyCodeToIDN(AHost);
      {$IFDEF STRING_IS_UNICODE}
      Result := LUnicodeHost;
      {$ELSE}
      Result := string(LUnicodeHost);
      {$ENDIF}
      Exit;
    except
      // Fall back to original if conversion fails
    end;
  end;
  {$ENDIF}

  Result := AHost;
end;

function TIdSpartanServer.DoExecute(AContext: TIdContext): Boolean;
var
  ReqLine, LTemp: string;
  Host, Path: string;
  Len: Integer;
  SpacePos: Integer;
  ContentStream, ResponseStream: TMemoryStream;
  Status: TSpartanStatus;
  Meta: string;
  StatusCode: string;      // 10 and 11 are two digits
  DisplayHost: string;
begin
  ContentStream := nil;
  ResponseStream := nil;
  // Spartan closes the connection after every request, so this never reports
  // the context as still connected. See the Disconnect in the finally block
  // for why that is done explicitly rather than left to this value.
  Result := False;

  try
    // Read request line
    ReqLine := AContext.Connection.IOHandler.ReadLn;
    if ReqLine = '' then
    begin
      AContext.Connection.IOHandler.WriteLn('4 Empty request');
      Exit;
    end;

    // Find first space (between host and path)
    SpacePos := Pos(' ', ReqLine);
    if SpacePos = 0 then
    begin
      AContext.Connection.IOHandler.WriteLn('4 Invalid request format');
      Exit;
    end;

    // Extract host
    Host := Copy(ReqLine, 1, SpacePos - 1);

    DisplayHost := PunycodeToUnicode(Host);
    // Extract remaining request (path + length)
    LTemp := Trim(Copy(ReqLine, SpacePos + 1, MaxInt));

    // Find space between path and content length
    SpacePos := Pos(' ', LTemp);
    if SpacePos = 0 then
    begin
      // No content length specified
      Path := LTemp;
      Len := 0;
    end
    else
    begin
      // Extract path and content length
      Path := Copy(LTemp, 1, SpacePos - 1);
      Len := StrToIntDef(Trim(Copy(LTemp, SpacePos + 1, MaxInt)), -1);
    end;

    // Validate content length
    if Len < 0 then
    begin
      AContext.Connection.IOHandler.WriteLn('4 Invalid content length');
      Exit;
    end;

    // Read request body if present
    ContentStream := TMemoryStream.Create;
    if Len > 0 then
    begin
      AContext.Connection.IOHandler.ReadStream(ContentStream, Len, False);
      ContentStream.Position := 0;
    end;

    // Prepare response
    Status := ssServerError;
    Meta := 'No handler';
    ResponseStream := TMemoryStream.Create;

    // Call event handler
    if Assigned(FOnSpartanRequest) then
      FOnSpartanRequest(AContext, Host, Path, ContentStream, Status, Meta, ResponseStream);

    // Convert status to status code
    case Status of
      ssSuccess:        StatusCode := '2';
      ssRedirect:       StatusCode := '3';
      ssClientError:    StatusCode := '4';
      ssServerError:    StatusCode := '5';
      ssInput:          StatusCode := '10';
      ssSensitiveInput: StatusCode := '11';
    else
      StatusCode := '5';
      Meta := 'Unknown status';
    end;

    // Send response header
    AContext.Connection.IOHandler.WriteLn(StatusCode + ' ' + Meta);

    // Send response body for successful requests
    if (Status = ssSuccess) and Assigned(ResponseStream) then
    begin
      ResponseStream.Position := 0;
      AContext.Connection.IOHandler.Write(ResponseStream, 0, False);
    end;
  finally
    // Cleanup. The response stream was handed to the event handler and is
    // freed here rather than by the handler; see TSpartanRequestEvent.
    FreeAndNil(ContentStream);
    FreeAndNil(ResponseStream);

    // Disconnect after processing request (Spartan requires connection close).
    // Returning False above only stops the context thread, so the socket is
    // disconnected explicitly to actually close it.
    if AContext.Connection.Connected then
    begin
      AContext.Connection.Disconnect;
    end;
  end;
end;

end.
