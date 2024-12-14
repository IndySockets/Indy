unit IdHTTPHelper;

{$I IdCompilerDefines.inc}

interface

uses
  Classes, IdGlobal, IdHTTP;

{$IFDEF HAS_CLASS_HELPER}
type
  TIdHTTPHelper = class helper for TIdHTTP
  public
    procedure CustomRequest(const AMethod: TIdHTTPMethod; const AURL: string;
      ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);

    function Delete(const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    function Delete(const AURL: string; ASource: TStream
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;

    procedure Delete(const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload;
    procedure Delete(const AURL: string; ASource, AResponseContent: TStream); overload;

    function Put(const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    procedure Put(const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload;

  end;
{$ENDIF}

procedure TIdHTTPHelper_CustomRequest(AHTTP: TIdHTTP; const AMethod: TIdHTTPMethod;
  const AURL: string; ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.CustomRequest()'{$ENDIF};{$ENDIF}{$ENDIF}

function TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string; overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Delete()'{$ENDIF};{$ENDIF}{$ENDIF}

function TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string; overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Delete()'{$ENDIF};{$ENDIF}{$ENDIF}

procedure TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Delete()'{$ENDIF};{$ENDIF}{$ENDIF}

procedure TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource, AResponseContent: TStream); overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Delete()'{$ENDIF};{$ENDIF}{$ENDIF}

function TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string; overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Put()'{$ENDIF};{$ENDIF}{$ENDIF}

procedure TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Put()'{$ENDIF};{$ENDIF}{$ENDIF}

implementation

uses
  IdGlobalProtocols, IdHTTPHeaderInfo;

{ TIdHTTPHelper }

type
  TIdHTTPAccess = class(TIdHTTP)
  end;

//---

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdHTTPHelper_CustomRequest(AHTTP: TIdHTTP; const AMethod: TIdHTTPMethod;
  const AURL: string; ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  {$I IdObjectChecksOff.inc}
  TIdHTTPAccess(AHTTP).DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
  {$I IdObjectChecksOn.inc}
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdHTTPHelper.CustomRequest(const AMethod: TIdHTTPMethod; const AURL: string;
  ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);
begin
  DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
end;
{$ENDIF}

//---

function IsContentTypeHtml(AInfo: TIdEntityHeaderInfo) : Boolean;
begin
  Result := IsHeaderMediaTypes(AInfo.ContentType, ['text/html', 'text/html-sandboxed','application/xhtml+xml']); {do not localize}
end;

procedure Internal_TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings;
  AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload; forward;

function Internal_TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string; overload;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Internal_TIdHTTPHelper_Delete(AHTTP, AURL, ASource, LResponse, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, AHTTP.Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    LResponse.Free;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
function TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string;
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Result := Internal_TIdHTTPHelper_Delete(AHTTP, AURL, ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding, ADestEncoding{$ENDIF});
end;

{$IFDEF HAS_CLASS_HELPER}
function TIdHTTPHelper.Delete(const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string;
begin
  Result := Internal_TIdHTTPHelper_Delete(Self, AURL, ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding, ADestEncoding{$ENDIF});
end;
{$ENDIF}

//---

function Internal_TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string; overload;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    {$I IdObjectChecksOff.inc}
    TIdHTTPAccess(AHTTP).DoRequest(Id_HTTPMethodDelete, AURL, ASource, LResponse, []);
    {$I IdObjectChecksOn.inc}
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, AHTTP.Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    LResponse.Free;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
function TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string;
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Result := Internal_TIdHTTPHelper_Delete(AHTTP, AURL, ASource{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

{$IFDEF HAS_CLASS_HELPER}
function TIdHTTPHelper.Delete(const AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string;
begin
  Result := Internal_TIdHTTPHelper_Delete(Self, AURL, ASource{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;
{$ENDIF}

//---

procedure Internal_TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings;
  AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload;
var
  LParams: TMemoryStream;
  LHTTPAccess: TIdHTTPAccess;
begin
  // Usual posting request have default ContentType is application/x-www-form-urlencoded
  if (AHTTP.Request.ContentType = '') or IsContentTypeHtml(AHTTP.Request) then begin
    AHTTP.Request.ContentType := 'application/x-www-form-urlencoded'; {do not localize}
  end;

  {$I IdObjectChecksOff.inc}
  LHTTPAccess := TIdHTTPAccess(AHTTP);
  {$I IdObjectChecksOn.inc}

  if ASource <> nil then
  begin
    LParams := TMemoryStream.Create;
    try
      WriteStringToStream(LParams, LHTTPAccess.SetRequestParams(ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}));
      LParams.Position := 0;
      LHTTPAccess.DoRequest(Id_HTTPMethodDelete, AURL, LParams, AResponseContent, []);
    finally
      LParams.Free;
    end;
  end else begin
    LHTTPAccess.DoRequest(Id_HTTPMethodDelete, AURL, TStream(nil), AResponseContent, []);
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdHTTPHelper_Delete(AHTTP, AURL, ASource, AResponseContent, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdHTTPHelper.Delete(const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  Internal_TIdHTTPHelper_Delete(Self, AURL, ASource, AResponseContent, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;
{$ENDIF}

//---

procedure Internal_TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource, AResponseContent: TStream); overload;
begin
  {$I IdObjectChecksOff.inc}
  TIdHTTPAccess(AHTTP).DoRequest(Id_HTTPMethodDelete, AURL, ASource, AResponseContent, []);
  {$I IdObjectChecksOn.inc}
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdHTTPHelper_Delete(AHTTP: TIdHTTP; const AURL: string; ASource, AResponseContent: TStream);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  {$I IdObjectChecksOff.inc}
  TIdHTTPAccess(AHTTP).DoRequest(Id_HTTPMethodDelete, AURL, ASource, AResponseContent, []);
  {$I IdObjectChecksOn.inc}
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdHTTPHelper.Delete(const AURL: string; ASource, AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodDelete, AURL, ASource, AResponseContent, []);
end;
{$ENDIF}

//---

procedure Internal_TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings;
  AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload; forward;

function Internal_TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string; overload;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Internal_TIdHTTPHelper_Put(AHTTP, AURL, ASource, LResponse, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, AHTTP.Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    LResponse.Free;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
function TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string; overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Put()'{$ENDIF};{$ENDIF}{$ENDIF}
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
begin
  Result := Internal_TIdHTTPHelper_Put(AHTTP, AURL, ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding, ADestEncoding{$ENDIF});
end;

{$IFDEF HAS_CLASS_HELPER}
function TIdHTTPHelper.Put(const AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string;
begin
  Result := Internal_TIdHTTPHelper_Put(Self, AURL, ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding, ADestEncoding{$ENDIF});
end;
{$ENDIF}

//---

procedure Internal_TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings;
  AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload;
var
  LParams: TMemoryStream;
  LHTTPAccess: TIdHTTPAccess;
begin
  // Usual posting request have default ContentType is application/x-www-form-urlencoded
  if (AHTTP.Request.ContentType = '') or IsContentTypeHtml(AHTTP.Request) then begin
    AHTTP.Request.ContentType := 'application/x-www-form-urlencoded'; {do not localize}
  end;

  {$I IdObjectChecksOff.inc}
  LHTTPAccess := TIdHTTPAccess(AHTTP);
  {$I IdObjectChecksOn.inc}

  if ASource <> nil then
  begin
    LParams := TMemoryStream.Create;
    try
      WriteStringToStream(LParams, LHTTPAccess.SetRequestParams(ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}));
      LParams.Position := 0;
      LHTTPAccess.DoRequest(Id_HTTPMethodPut, AURL, LParams, AResponseContent, []);
    finally
      LParams.Free;
    end;
  end else begin
    LHTTPAccess.DoRequest(Id_HTTPMethodPut, AURL, TStream(nil), AResponseContent, []);
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdHTTPHelper_Put(AHTTP: TIdHTTP; const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload; {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.Put()'{$ENDIF};{$ENDIF}{$ENDIF}
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdHTTPHelper_Put(AHTTP, AURL, ASource, AResponseContent, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdHTTPHelper.Put(const AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF});
begin
  Internal_TIdHTTPHelper_Put(Self, AURL, ASource, AResponseContent, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;
{$ENDIF}

end.