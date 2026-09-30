unit IdSpartanServer;
{$mode delphi}

interface

uses
  SysUtils, Classes, IdTCPServer, IdContext, IdGlobal, IdSpartan, IdURI, IdGlobalProtocols, IdIDN;

type
  TSpartanRequestEvent = procedure(AContext: TIdContext; const Host, Path: string;
    Content: TStream; out Status: TSpartanStatus; out Meta: string; var Response: TStream) of object;

  TIdSpartanServer = class(TIdTCPServer)
  private
    FOnSpartanRequest: TSpartanRequestEvent;
    procedure InternalExecute(AContext: TIdContext);
    function PunycodeToUnicode(const AHost: string): string;
  protected
    procedure InitComponent; override;
  public
    class procedure WriteStringToStream(Stream: TStream; const S: string; Encoding: TEncoding = nil);
  published
    property OnSpartanRequest: TSpartanRequestEvent read FOnSpartanRequest write FOnSpartanRequest;
    property DefaultPort default 300;
  end;

implementation

{ TIdSpartanServer }

procedure TIdSpartanServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := 300;
  OnExecute := InternalExecute;
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

class procedure TIdSpartanServer.WriteStringToStream(Stream: TStream; const S: string; Encoding: TEncoding);
var
  Bytes: TBytes;
begin
  if Encoding = nil then
    Encoding := TEncoding.UTF8;

  Bytes := Encoding.GetBytes(S);
  if Length(Bytes) > 0 then
    Stream.WriteBuffer(Bytes[0], Length(Bytes));
end;

procedure TIdSpartanServer.InternalExecute(AContext: TIdContext);
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
    // Cleanup
    FreeAndNil(ContentStream);
    FreeAndNil(ResponseStream);

    // Disconnect after processing request (Spartan requires connection close)
    if AContext.Connection.Connected then
    begin
      AContext.Connection.Disconnect;
    end;
  end;
end;

end.
