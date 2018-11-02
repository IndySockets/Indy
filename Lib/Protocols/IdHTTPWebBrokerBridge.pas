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
  Rev 1.7    6/26/2004 12:11:16 AM  BGooijen
  updates for D8

  Rev 1.6    4/8/2004 4:00:40 PM  BGooijen
  Fix for D8

  Rev 1.5    07/04/2004 20:44:06  HHariri
  Updates

  Rev 1.4    07/04/2004 20:07:50  HHariri
  Updates for .NET

    Rev 1.3    10/19/2003 4:50:10 PM  DSiders
  Added localization comments.

  Rev 1.2    10/12/2003 1:49:48 PM  BGooijen
  Changed comment of last checkin

  Rev 1.1    10/12/2003 1:43:32 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/13/2002 07:54:34 AM  JPMugaas
}

unit IdHTTPWebBrokerBridge;

{
Original Author: Dave Nottage.
Modified by: Grahame Grieve
Modified by: Chad Z. Hower (Kudzu)
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  HTTPApp,
  SysUtils,
  IdContext, IdCustomHTTPServer, IdException, IdTCPServer, IdIOHandlerSocket,
  {$IFDEF CLR}System.Text,{$ENDIF}
  WebBroker, WebReq;

type
  EWBBException = class(EIdException);
  EWBBInvalidIdxGetDateVariable = class(EWBBException);
  EWBBInvalidIdxSetDateVariable = class(EWBBException );
  EWBBInvalidIdxGetIntVariable = class(EWBBException );
  EWBBInvalidIdxSetIntVariable = class(EWBBException );
  EWBBInvalidIdxGetStrVariable = class(EWBBException);
  EWBBInvalidIdxSetStringVar = class(EWBBException);
  EWBBInvalidStringVar = class(EWBBException);

  {$IFNDEF VCL_10_1_OR_ABOVE}
    {$DEFINE WBB_ANSI}
  {$ENDIF}

  TIdHTTPAppRequest = class(TWebRequest)
  protected
    FRequestInfo   : TIdHTTPRequestInfo;
    FResponseInfo  : TIdHTTPResponseInfo;
    FThread        : TIdContext;
    FContentStream : TStream;
    FFreeContentStream : Boolean;
    //
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetStringVariable(Index: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; override;
    {$IFDEF VCL_XE_OR_ABOVE}
    function GetRemoteIP: string; override;
    function GetRawPathInfo: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; override;
    {$ENDIF}
    {$IFDEF VCL_10_1_OR_ABOVE}
    function GetRawContent: TBytes; override;
    {$ENDIF}
  public
    constructor Create(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo);
    destructor Destroy; override;
    {$IFDEF WBB_ANSI}
    function GetFieldByName(const Name: AnsiString): AnsiString; override;
    {$ELSE}
    function GetFieldByName(const Name: string): string; override;
    {$ENDIF}
    function ReadClient(var Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer): Integer; override;
    function ReadString(Count: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; override;
    {function ReadUnicodeString(Count: Integer): string;}
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var ABuffer; ACount: Integer): Integer; override;
    {$IFDEF VCL_6_OR_ABOVE}
      {$DEFINE VCL_6_OR_ABOVE_OR_CLR}
    {$ENDIF}
    {$IFDEF CLR}
      {$DEFINE VCL_6_OR_ABOVE_OR_CLR}
    {$ENDIF}
    {$IFDEF VCL_6_OR_ABOVE_OR_CLR}
    function WriteHeaders(StatusCode: Integer; const ReasonString, Headers: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}): Boolean; override;
    {$ENDIF}
    function WriteString(const AString: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}): Boolean; override;
  end;

  TIdHTTPAppResponse = class(TWebResponse)
  protected
    FContent: string;
    FRequestInfo: TIdHTTPRequestInfo;
    FResponseInfo: TIdHTTPResponseInfo;
    FSent: Boolean;
    FThread: TIdContext;
    FContentType: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; // Workaround to preserve value of ContentType property
    //
    function GetContent: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetStatusCode: Integer; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetLogMessage: string; override;
    function GetStringVariable(Index: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}; override;
    procedure SetContent(const AValue: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}); override;
    procedure SetContentStream(AValue: TStream); override;
    procedure SetStatusCode(AValue: Integer); override;
    procedure SetStringVariable(Index: Integer; const Value: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}); override;
    procedure SetDateVariable(Index: Integer; const Value: TDateTime); override;
    procedure SetIntegerVariable(Index: Integer; Value: Integer); override;
    procedure SetLogMessage(const Value: string); override;
    procedure MoveCookiesAndCustomHeaders;
  public
    constructor Create(AHTTPRequest: TWebRequest; AThread: TIdContext;
     ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure SendRedirect(const URI: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}); override;
    procedure SendResponse; override;
    procedure SendStream(AStream: TStream); override;
    function Sent: Boolean; override;
  end;

  TIdHTTPWebBrokerBridge = class(TIdCustomHTTPServer)
  private
    procedure RunWebModuleClass(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo);
  protected
    FWebModuleClass: TComponentClass;
    //
    procedure DoCommandGet(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo); override;
    procedure DoCommandOther(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo); override;
    procedure InitComponent; override;
  public
    procedure RegisterWebModuleClass(AClass: TComponentClass);
  end;

implementation

uses
  IdResourceStringsProtocols,
  IdBuffer, IdHTTPHeaderInfo, IdGlobal, IdGlobalProtocols, IdCookie, IdStream,
  {$IFDEF STRING_IS_UNICODE}IdCharsets,{$ENDIF}
  Math
  {$IFDEF HAS_TNetEncoding}
  , System.NetEncoding
  {$ENDIF}
  ;

type
  // Make HandleRequest accessible
  TWebDispatcherAccess = class(TCustomWebDispatcher);

const
  INDEX_RESP_Version = 0;
  INDEX_RESP_ReasonString = 1;
  INDEX_RESP_Server = 2;
  INDEX_RESP_WWWAuthenticate = 3;
  INDEX_RESP_Realm = 4;
  INDEX_RESP_Allow = 5;
  INDEX_RESP_Location = 6;
  INDEX_RESP_ContentEncoding = 7;
  INDEX_RESP_ContentType = 8;
  INDEX_RESP_ContentVersion = 9;
  INDEX_RESP_DerivedFrom = 10;
  INDEX_RESP_Title = 11;
  //
  INDEX_RESP_ContentLength = 0;
  //
  INDEX_RESP_Date = 0;
  INDEX_RESP_Expires = 1;
  INDEX_RESP_LastModified = 2;
  //
  //Borland coder didn't define constants in HTTPApp
  INDEX_Method           = 0;
  INDEX_ProtocolVersion  = 1;
  INDEX_URL              = 2;
  INDEX_Query            = 3;
  INDEX_PathInfo         = 4;
  INDEX_PathTranslated   = 5;
  INDEX_CacheControl     = 6;
  INDEX_Date             = 7;
  INDEX_Accept           = 8;
  INDEX_From             = 9;
  INDEX_Host             = 10;
  INDEX_IfModifiedSince  = 11;
  INDEX_Referer          = 12;
  INDEX_UserAgent        = 13;
  INDEX_ContentEncoding  = 14;
  INDEX_ContentType      = 15;
  INDEX_ContentLength    = 16;
  INDEX_ContentVersion   = 17;
  INDEX_DerivedFrom      = 18;
  INDEX_Expires          = 19;
  INDEX_Title            = 20;
  INDEX_RemoteAddr       = 21;
  INDEX_RemoteHost       = 22;
  INDEX_ScriptName       = 23;
  INDEX_ServerPort       = 24;
  INDEX_Content          = 25;
  INDEX_Connection       = 26;
  INDEX_Cookie           = 27;
  INDEX_Authorization    = 28;

{ TIdHTTPAppRequest }

constructor TIdHTTPAppRequest.Create(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  i: Integer;
begin
  FThread := AThread;
  FRequestInfo := ARequestInfo;
  FResponseInfo := AResponseInfo;
  inherited Create;
  for i := 0 to ARequestInfo.Cookies.Count - 1 do begin
    CookieFields.Add(ARequestInfo.Cookies[i].ClientCookie);
  end;
  if Assigned(FRequestInfo.PostStream) then
  begin
    FContentStream := FRequestInfo.PostStream;
    FFreeContentStream := False;
  end else
  begin
    if FRequestInfo.FormParams <> '' then begin {do not localize}
      // an input form that was submitted as "application/www-url-encoded"...
      FContentStream := TStringStream.Create(FRequestInfo.FormParams);
    end else
    begin
      // anything else for now...
      FContentStream := TStringStream.Create(FRequestInfo.UnparsedParams);
    end;
    FFreeContentStream := True;
  end;
end;

destructor TIdHTTPAppRequest.Destroy;
begin
  if FFreeContentStream then begin
    FreeAndNil(FContentStream);
  end;
  inherited;
end;

function TIdHTTPAppRequest.GetDateVariable(Index: Integer): TDateTime;
var
  LValue: string;
begin
  LValue := string(GetStringVariable(Index));
  if Length(LValue) > 0 then begin
    Result := ParseDate(LValue);
  end else begin
    Result := -1;
  end;
end;

function TIdHTTPAppRequest.GetIntegerVariable(Index: Integer): Integer;
begin
  Result := StrToIntDef(string(GetStringVariable(Index)), -1)
end;

{$IFDEF VCL_XE_OR_ABOVE}
function TIdHTTPAppRequest.GetRawPathInfo: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF};
begin
  {$IFDEF WBB_ANSI}
  Result := AnsiString(FRequestInfo.URI);
  {$ELSE}
  Result := FRequestInfo.URI;
  {$ENDIF}
end;

function TIdHTTPAppRequest.GetRemoteIP: string;
begin
  Result := FRequestInfo.RemoteIP;
end;
{$ENDIF}

{$IFDEF VCL_10_1_OR_ABOVE}
function TIdHTTPAppRequest.GetRawContent: TBytes;
var
  LPos: TIdStreamSize;
begin
  LPos := FContentStream.Position;
  FContentStream.Position := 0;
  try
    //TIdStreamHelper.ReadBytes(FContentStream, PIdBytes(@Result)^);
    SetLength(Result, FContentStream.Size);
    FContentStream.Read(Result, 0, Length(Result));
  finally
    FContentStream.Position := LPos;
  end;
end;
{$ENDIF}

function TIdHTTPAppRequest.GetStringVariable(Index: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF};
var
  LValue: string;
  LPos: TIdStreamSize;
  {$IFDEF WBB_ANSI}
  LBytes: TIdBytes;
  {$ENDIF}
begin
  // RLebeau 1/15/2016: Now accessing FRequestInfo.RawHeaders.Values[] directly
  // instead of using GetFieldByName().  On Delphi versions prior to 10.1 Berlin,
  // GetFieldByName() returned an AnsiString, even in Unicode versions. So as not
  // to have to IFDEF all of these fields, now doing one conversion at the end of
  // this method, which means having a local String variable. Don't want the
  // overhead of performing an AnsiString->String->AnsiString conversion...

  {$IFDEF WBB_ANSI}
  LBytes := nil;
  {$ENDIF}

  case Index of
    INDEX_Method          : LValue := FRequestInfo.Command;
    INDEX_ProtocolVersion : LValue := FRequestInfo.Version;
    //INDEX_URL             : LValue := FRequestInfo.Document;
    INDEX_URL             : LValue := ''; // Root - consistent with ISAPI which return path to root
    INDEX_Query           : LValue := FRequestInfo.QueryParams;
    INDEX_PathInfo        : LValue := FRequestInfo.Document;
    INDEX_PathTranslated  : LValue := FRequestInfo.Document;             // it's not clear quite what should be done here - we can't translate to a path
    INDEX_CacheControl    : LValue := FRequestInfo.RawHeaders.Values['Cache-Control'];   {do not localize}
    INDEX_Date            : LValue := FRequestInfo.RawHeaders.Values['Date'];            {do not localize}
    INDEX_Accept          : LValue := FRequestInfo.Accept;
    INDEX_From            : LValue := FRequestInfo.From;
    INDEX_Host: begin
      LValue := FRequestInfo.Host;
      LValue := Fetch(LValue, ':', False);
    end;
    INDEX_IfModifiedSince : LValue := FRequestInfo.RawHeaders.Values['If-Modified-Since']; {do not localize}
    INDEX_Referer         : LValue := FRequestInfo.Referer;
    INDEX_UserAgent       : LValue := FRequestInfo.UserAgent;
    INDEX_ContentEncoding : LValue := FRequestInfo.ContentEncoding;
    INDEX_ContentType     : LValue := FRequestInfo.ContentType;
    INDEX_ContentLength   : LValue := IntToStr(FContentStream.Size);
    INDEX_ContentVersion  : LValue := FRequestInfo.RawHeaders.Values['CONTENT_VERSION']; {do not localize}
    INDEX_DerivedFrom     : LValue := FRequestInfo.RawHeaders.Values['Derived-From'];    {do not localize}
    INDEX_Expires         : LValue := FRequestInfo.RawHeaders.Values['Expires'];         {do not localize}
    INDEX_Title           : LValue := FRequestInfo.RawHeaders.Values['Title'];           {do not localize}
    INDEX_RemoteAddr      : LValue := FRequestInfo.RemoteIP;
    INDEX_RemoteHost      : LValue := FRequestInfo.RawHeaders.Values['REMOTE_HOST'];     {do not localize}
    INDEX_ScriptName      : LValue := '';
    INDEX_ServerPort: begin
      LValue := FRequestInfo.Host;
      Fetch(LValue, ':');
      if Length(LValue) = 0 then begin
        LValue := IntToStr(FThread.Connection.Socket.Binding.Port);
        // LValue := '80';
      end;
    end;
    INDEX_Content: begin
      if FFreeContentStream then
      begin
        LValue := TStringStream(FContentStream).DataString;
      end else
      begin
        LPos := FContentStream.Position;
        FContentStream.Position := 0;
        try
          // TODO: just use TIdHTTPAppRequest.ReadString() instead?
          //s := ReadString(FContentStream.Size);

          {$IFDEF WBB_ANSI}

          // RLebeau 2/21/2009: not using ReadStringAsCharSet() anymore.  Since
          // this method returns an AnsiString, the stream data should not be
          // decoded to Unicode and then converted to Ansi.  That can lose
          // characters...

          // Result := ReadStringAsCharSet(FContentStream, FRequestInfo.CharSet);

          // TODO: instead of using a temp memory buffer, just pre-allocate the
          // Result to the size of the stream and then read directly into it...
          TIdStreamHelper.ReadBytes(FContentStream, LBytes);

            {$IFDEF DOTNET}
          // RLebeau: how to handle this correctly in .NET?
          Result := AnsiString(BytesToStringRaw(LBytes));
            {$ELSE}
          SetString(Result, PAnsiChar(LBytes), Length(LBytes));
              {$IFDEF VCL_2009_OR_ABOVE}
          // RLebeau 2/21/2009: For D2009+, the AnsiString payload should have
          // the proper codepage assigned to it as well so it can be converted
          // correctly if assigned to other string variables later on...
          SetCodePage(PRawByteString(@Result)^, CharsetToCodePage(FRequestInfo.CharSet), False);
              {$ENDIF}
            {$ENDIF}

          {$ELSE}

          // RLebeau 1/15/2016: this method now returns a UnicodeString, so
          // lets use ReadStringAsCharSet() once again...
          Result := ReadStringAsCharset(FContentStream, FRequestInfo.CharSet);

          {$ENDIF}
        finally
          FContentStream.Position := LPos;
        end;
        Exit;
      end;
    end;
    INDEX_Connection      : LValue := FRequestInfo.RawHeaders.Values['Connection'];      {do not localize}
    INDEX_Cookie          : LValue := '';  // not available at present. FRequestInfo.Cookies....;
    INDEX_Authorization   : LValue := FRequestInfo.RawHeaders.Values['Authorization'];   {do not localize}
  else
    LValue := '';
  end;
  Result := {$IFDEF WBB_ANSI}AnsiString(LValue){$ELSE}LValue{$ENDIF};
end;

{$IFDEF WBB_ANSI}
function TIdHTTPAppRequest.GetFieldByName(const Name: AnsiString): AnsiString;
begin
  Result := AnsiString(FRequestInfo.RawHeaders.Values[string(Name)]);
end;
{$ELSE}
function TIdHTTPAppRequest.GetFieldByName(const Name: string): string;
begin
  Result := FRequestInfo.RawHeaders.Values[Name];
end;
{$ENDIF}

function TIdHTTPAppRequest.ReadClient(var Buffer{$IFDEF CLR}: TBytes{$ENDIF};
  Count: Integer): Integer;
begin
  {$IFDEF CLR}
  Result := TIdStreamHelper.ReadBytes(FContentStream, Buffer, Count);
  {$ELSE}
  Result := FContentStream.Read(Buffer, Count);
  {$ENDIF}
  // well, it shouldn't be less than 0. but let's not take chances
  if Result < 0 then begin
    Result := 0;
  end;
end;

function TIdHTTPAppRequest.ReadString(Count: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF};
{$IFDEF WBB_ANSI}
var
  LBytes: TIdBytes;
{$ENDIF}
begin
  {$IFDEF WBB_ANSI}

  // RLebeau 2/21/2009: not using ReadStringFromStream() anymore.  Since
  // this method returns an AnsiString, the stream data should not be
  // decoded to Unicode and then converted to Ansi.  That can lose
  // characters.

  // Result := AnsiString(ReadStringFromStream(FContentStream, Count));

  LBytes := nil;
  TIdStreamHelper.ReadBytes(FContentStream, LBytes, Count);

  {$IFDEF DOTNET}
  // RLebeau: how to handle this correctly in .NET?
  Result := AnsiString(BytesToStringRaw(LBytes));
  {$ELSE}
  SetString(Result, PAnsiChar(LBytes), Length(LBytes));
    {$IFDEF VCL_2009_OR_ABOVE}
  // RLebeau 2/21/2009: For D2009+, the AnsiString payload should have
  // the proper codepage assigned to it as well so it can be converted
  // correctly if assigned to other string variables later on...
  SetCodePage(PRawByteString(@Result)^, CharsetToCodePage(FRequestInfo.CharSet), False);
    {$ENDIF}
  {$ENDIF}

  {$ELSE}

  // RLebeau 1/15/2016: this method now returns a UnicodeString, so
  // lets use ReadStringFromStream() once again...
  Result := ReadStringFromStream(FContentStream, Count, CharsetToEncoding(FRequestInfo.CharSet));

  {$ENDIF}
end;

function TIdHTTPAppRequest.TranslateURI(const URI: string): string;
begin
  // we don't have the concept of a path translation. It's not quite clear
  // what to do about this. Comments welcome (grahame@kestral.com.au)
  Result := URI;
end;

{$IFDEF VCL_6_OR_ABOVE_OR_CLR}
function TIdHTTPAppRequest.WriteHeaders(StatusCode: Integer; const ReasonString, Headers: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}): Boolean;
begin
  FResponseInfo.ResponseNo := StatusCode;
  FResponseInfo.ResponseText := {$IFDEF WBB_ANSI}string(ReasonString){$ELSE}ReasonString{$ENDIF};
  FResponseInfo.CustomHeaders.Add({$IFDEF WBB_ANSI}string(Headers){$ELSE}Headers{$ENDIF});
  FResponseInfo.WriteHeader;
  Result := True;
end;
{$ENDIF}

function TIdHTTPAppRequest.WriteString(const AString: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}): Boolean;
begin
  FThread.Connection.IOHandler.Write({$IFDEF WBB_ANSI}string(AString){$ELSE}AString{$ENDIF});
  Result := True;
end;

function TIdHTTPAppRequest.WriteClient(var ABuffer; ACount: Integer): Integer;
var
  LBuffer: TIdBytes;
begin
  SetLength(LBuffer, ACount);
{$IFNDEF CLR}
  Move(ABuffer, LBuffer[0], ACount);
{$ELSE}
  // RLebeau: this can't be right?  It is interpretting the source as a
  // null-terminated character string, which is likely not the case...
  CopyTIdBytes(ToBytes(string(ABuffer)), 0, LBuffer, 0, ACount);
{$ENDIF}
  FThread.Connection.IOHandler.Write(LBuffer);
  Result := ACount;
end;

{ TIdHTTPAppResponse }

constructor TIdHTTPAppResponse.Create(AHTTPRequest: TWebRequest; AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  FThread := AThread;
  FRequestInfo := ARequestInfo;
  FResponseInfo := AResponseInfo;
  inherited Create(AHTTPRequest);
  if Length(FHTTPRequest.ProtocolVersion) = 0 then begin
    Version := '1.0'; {do not localize}
  end;
  StatusCode := 200;
  LastModified := -1;
  Expires := -1;
  Date := -1;

  // RLebeau 8/13/2015: no longer setting a default ContentType here.  Doing so
  // sets a default CharSet, which would get carried over if the user assigns a
  // new *non-text* ContentType without an explicit charset.  TAppResponse does
  // not expose access to the FResponseInfo.CharSet property.  For example, if
  // the user sets TAppResponse.ContentType to 'image/jpeg', the resulting
  // Content-Type header woud be 'image/jpeg; charset=ISO-8859-1', which can
  // cause problems for some clients.  Besides, TIdHTTPResponseInfo.WriteHeader()
  // sets the ContentType to 'text/html; charset=ISO-8859-1' if no ContentType
  // has been provided but there is ContentText/ContentStream data, so this is
  // redundant here anyway...
  //
  // ContentType := 'text/html'; {do not localize}
end;

{$UNDEF CONVERT_UNICODE_TO_ANSI}
{$IFDEF WBB_ANSI}
  {$IFDEF STRING_IS_UNICODE}
    {$DEFINE CONVERT_UNICODE_TO_ANSI}
  {$ENDIF}
{$ENDIF}

function TIdHTTPAppResponse.GetContent: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF};
{$IFDEF CONVERT_UNICODE_TO_ANSI}
var
  LBytes: TIdBytes;
{$ENDIF}
begin
  {$IFDEF CONVERT_UNICODE_TO_ANSI}
  // RLebeau 2/21/2009: encode the content using the specified charset.
  Result := '';
  LBytes := CharsetToEncoding(FResponseInfo.CharSet).GetBytes(FResponseInfo.ContentText);
    {$IFDEF DOTNET}
  // RLebeau: how to handle this correctly in .NET?
  Result := AnsiString(BytesToStringRaw(LBytes));
    {$ELSE}
  SetString(Result, PAnsiChar(LBytes), Length(LBytes));
      {$IFDEF VCL_2009_OR_ABOVE}
  // RLebeau 2/21/2009: for D2009+, the AnsiString payload should have
  // the proper codepage assigned to it as well so it can be converted
  // correctly if assigned to other string variables later on...
  SetCodePage(PRawByteString(@Result)^, CharsetToCodePage(FResponseInfo.CharSet), False);
      {$ENDIF}
    {$ENDIF}
  {$ELSE}
  Result := FResponseInfo.ContentText;
  {$ENDIF}
end;

function TIdHTTPAppResponse.GetLogMessage: string;
begin
  Result := '';
end;

function TIdHTTPAppResponse.GetStatusCode: Integer;
begin
  Result := FResponseInfo.ResponseNo;
end;

function TIdHTTPAppResponse.GetDateVariable(Index: Integer): TDateTime;
  // WebBroker apps are responsible for conversion to GMT, Indy HTTP server expects apps to pas local time
  function ToGMT(ADateTime: TDateTime): TDateTime;
  begin
    Result := ADateTime;
    if Result <> -1 then
      Result := Result - OffsetFromUTC;
  end;
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Date             : Result := ToGMT(FResponseInfo.Date);
    INDEX_RESP_Expires          : Result := ToGMT(FResponseInfo.Expires);
    INDEX_RESP_LastModified     : Result := ToGMT(FResponseInfo.LastModified);
  else
    raise EWBBInvalidIdxGetDateVariable.Create( Format( RSWBBInvalidIdxGetDateVariable,[inttostr(Index)]));
  end;
end;

procedure TIdHTTPAppResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
  // WebBroker apps are responsible for conversion to GMT, Indy HTTP server expects apps to pas local time
  function ToLocal(ADateTime: TDateTime): TDateTime;
  begin
    Result := ADateTime;
    if Result <> -1 then
      Result := Result + OffsetFromUTC;
  end;
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Date             : FResponseInfo.Date := ToLocal(Value);
    INDEX_RESP_Expires          : FResponseInfo.Expires := ToLocal(Value);
    INDEX_RESP_LastModified     : FResponseInfo.LastModified := ToLocal(Value);
  else
    raise EWBBInvalidIdxSetDateVariable.Create(Format(RSWBBInvalidIdxSetDateVariable,[inttostr(Index) ]));
  end;
end;

function TIdHTTPAppResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_ContentLength: Result := FResponseInfo.ContentLength;
  else
    raise EWBBInvalidIdxGetIntVariable.Create( Format( RSWBBInvalidIdxGetIntVariable,[inttostr(Index)]));
  end;
end;

procedure TIdHTTPAppResponse.SetIntegerVariable(Index, Value: Integer);
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_ContentLength: FResponseInfo.ContentLength := Value;
  else
    raise EWBBInvalidIdxSetIntVariable.Create( Format(RSWBBInvalidIdxSetIntVariable,[inttostr(Index)]));  {do not localize}
  end;
end;

function TIdHTTPAppResponse.GetStringVariable(Index: Integer): {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF};
var
  LValue: string;
begin
  // RLebeau 1/15/2016: On Delphi versions prior to 10.1 Berlin, this method
  // returned an AnsiString, even in Unicode versions. So as not to have to
  // IFDEF all of these fields, now doing one conversion at the end of this
  // method, which means having a local String variable...

  //TODO: resource string these
  case Index of
    INDEX_RESP_Version           : LValue := FRequestInfo.Version;
    INDEX_RESP_ReasonString      : LValue := FResponseInfo.ResponseText;
    INDEX_RESP_Server            : LValue := FResponseInfo.Server;
    INDEX_RESP_WWWAuthenticate   : LValue := FResponseInfo.WWWAuthenticate.Text;
    INDEX_RESP_Realm             : LValue := FResponseInfo.AuthRealm;
    INDEX_RESP_Allow             : LValue := FResponseInfo.CustomHeaders.Values['Allow'];        {do not localize}
    INDEX_RESP_Location          : LValue := FResponseInfo.Location;
    INDEX_RESP_ContentEncoding   : LValue := FResponseInfo.ContentEncoding;
    INDEX_RESP_ContentType       :
    begin
      if FContentType <> '' then begin
        Result := FContentType;
        Exit;
      end;
      LValue := FResponseInfo.ContentType;
    end;
    INDEX_RESP_ContentVersion    : LValue := FResponseInfo.ContentVersion;
    INDEX_RESP_DerivedFrom       : LValue := FResponseInfo.CustomHeaders.Values['Derived-From']; {do not localize}
    INDEX_RESP_Title             : LValue := FResponseInfo.CustomHeaders.Values['Title'];        {do not localize}
  else
    raise EWBBInvalidIdxGetStrVariable.Create(Format(RSWBBInvalidIdxGetStrVariable,[ IntToStr(Index)]));
  end;
  Result := {$IFDEF WBB_ANSI}AnsiString(LValue){$ELSE}LValue{$ENDIF};
end;

procedure TIdHTTPAppResponse.SetStringVariable(Index: Integer; const Value: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF});
var
  LValue: string;
begin
  LValue := {$IFDEF WBB_ANSI}string(Value){$ELSE}Value{$ENDIF};
  //TODO: resource string these
  case Index of
    INDEX_RESP_Version           : EWBBInvalidStringVar.Create(RSWBBInvalidStringVar); // RLebeau: shouldn't this be calling 'raise'?
    INDEX_RESP_ReasonString      : FResponseInfo.ResponseText := LValue;
    INDEX_RESP_Server            : FResponseInfo.Server := LValue;
    INDEX_RESP_WWWAuthenticate   : FResponseInfo.WWWAuthenticate.Text := LValue;
    INDEX_RESP_Realm             : FResponseInfo.AuthRealm := LValue;
    INDEX_RESP_Allow             : FResponseInfo.CustomHeaders.Values['Allow'] := LValue; {do not localize}
    INDEX_RESP_Location          : FResponseInfo.Location := LValue;
    INDEX_RESP_ContentEncoding   : FResponseInfo.ContentEncoding := LValue;
    INDEX_RESP_ContentType       :
    begin
      FResponseInfo.ContentType := LValue;
      FContentType := Value; // using the original input variable, not the converted local variable
    end;
    INDEX_RESP_ContentVersion    : FResponseInfo.ContentVersion := LValue;
    INDEX_RESP_DerivedFrom       : FResponseInfo.CustomHeaders.Values['Derived-From'] := LValue;  {do not localize}
    INDEX_RESP_Title             : FResponseInfo.CustomHeaders.Values['Title'] := LValue; {do not localize}
  else
    raise EWBBInvalidIdxSetStringVar.Create( Format(RSWBBInvalidIdxSetStringVar,[IntToStr(Index)]));                   {do not localize}
  end;
end;

procedure TIdHTTPAppResponse.SendRedirect(const URI: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF});
begin
  FSent := True;
  MoveCookiesAndCustomHeaders;
  FResponseInfo.Redirect({$IFDEF WBB_ANSI}string(URI){$ELSE}URI{$ENDIF});
end;

procedure TIdHTTPAppResponse.SendResponse;
begin
  FSent := True;
  // Reset to -1 so Indy will auto set it
  FResponseInfo.ContentLength := -1;
  MoveCookiesAndCustomHeaders;
  {$IFDEF VCL_10_1_OR_ABOVE}
  // TODO: This code may not be in the correct location.
  if (FResponseInfo.ContentType = '') and
    ((FResponseInfo.ContentText <> '') or (Assigned(FResponseInfo.ContentStream))) and
    (HTTPApp.DefaultCharSet <> '') then
  begin
    // Indicate how to convert UTF16 when write.
    ContentType := Format('text/html; charset=%s', [HTTPApp.DefaultCharSet]); {Do not Localize}
  end;
  {$ENDIF}
  FResponseInfo.WriteContent;
end;

procedure TIdHTTPAppResponse.SendStream(AStream: TStream);
begin
  FThread.Connection.IOHandler.Write(AStream);
end;

function TIdHTTPAppResponse.Sent: Boolean;
begin
  Result := FSent;
end;

{$UNDEF CONVERT_ANSI_TO_UNICODE}
{$IFDEF WBB_ANSI}
  {$IFDEF STRING_IS_UNICODE}
    {$DEFINE CONVERT_ANSI_TO_UNICODE}
  {$ENDIF}
{$ENDIF}

procedure TIdHTTPAppResponse.SetContent(const AValue: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF});
{$IFDEF CONVERT_ANSI_TO_UNICODE}
var
  LValue : string;
{$ENDIF}
begin
  {$IFDEF CONVERT_ANSI_TO_UNICODE}

  // AValue contains Encoded bytes
  if AValue <> '' then begin
    // RLebeau 3/28/2013: decode the content using the specified charset.
    if FResponseInfo.CharSet <> '' then begin
      LValue := CharsetToEncoding(FResponseInfo.CharSet).GetString(
        {$IFDEF DOTNET}
        RawToBytes(PAnsiChar(AValue)^, Length(AValue))
        {$ELSE}
        PByte(PAnsiChar(AValue)), Length(AValue)
        {$ENDIF}
      );
    end else begin
      LValue := string(AValue);
    end;
  end;

  FResponseInfo.ContentText := LValue;
  // TODO: use Length(AValue) instead, as the ContentText *should* get re-encoded
  // back to the same value as AValue when transmitted.  Or, just set ContentLength
  // to -1 and let Indy calculate it later...
  FResponseInfo.ContentLength := Length(LValue);

  {$ELSE}

  FResponseInfo.ContentText := AValue;
  FResponseInfo.ContentLength := Length(AValue);

  {$ENDIF}
end;

procedure TIdHTTPAppResponse.SetLogMessage(const Value: string);
begin
  // logging not supported
end;

procedure TIdHTTPAppResponse.SetStatusCode(AValue: Integer);
begin
  FResponseInfo.ResponseNo := AValue;
end;

procedure TIdHTTPAppResponse.SetContentStream(AValue: TStream);
begin
  inherited;
  FResponseInfo.ContentStream := AValue;
end;

function DoHTTPEncode(const AStr: {$IFDEF WBB_ANSI}AnsiString{$ELSE}string{$ENDIF}): String;
begin
  {$IFDEF HAS_TNetEncoding}
  Result := TNetEncoding.URL.Encode(string(AStr));
  {$ELSE}
  Result := String(HTTPEncode(AStr));
  {$ENDIF}
end;

procedure TIdHTTPAppResponse.MoveCookiesAndCustomHeaders;
var
  i: Integer;
  LSrcCookie: TCookie;
  LDestCookie: TIdCookie;
begin
  for i := 0 to Cookies.Count - 1 do begin
    LSrcCookie := Cookies[i];
    LDestCookie := FResponseInfo.Cookies.Add;
    LDestCookie.CookieName := DoHTTPEncode(LSrcCookie.Name);
    LDestCookie.Value := DoHTTPEncode(LSrcCookie.Value);
    LDestCookie.Domain := String(LSrcCookie.Domain);
    LDestCookie.Path := String(LSrcCookie.Path);
    LDestCookie.Expires := LSrcCookie.Expires;
    LDestCookie.Secure := LSrcCookie.Secure;
    // TODO: LDestCookie.HttpOnly := LSrcCookie.HttpOnly;
  end;
  FResponseInfo.CustomHeaders.Clear;
  FResponseInfo.CustomHeaders.AddStdValues(CustomHeaders);
end;

{ TIdHTTPWebBrokerBridge }

procedure TIdHTTPWebBrokerBridge.DoCommandOther(AThread: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  DoCommandGet(AThread, ARequestInfo, AResponseInfo);

end;

procedure TIdHTTPWebBrokerBridge.InitComponent;
begin
  inherited InitComponent;
 // FOkToProcessCommand := True;
end;

type
  TIdHTTPWebBrokerBridgeRequestHandler = class(TWebRequestHandler)
  {$IFDEF HAS_CLASSVARS}
  private
   class var FWebRequestHandler: TIdHTTPWebBrokerBridgeRequestHandler;
  {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF HAS_CLASSVARS}
      {$IFDEF HAS_CLASSDESTRUCTOR}
    class destructor Destroy;
      {$ENDIF}
    {$ENDIF}
    destructor Destroy; override;
    procedure Run(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  end;

{$IFNDEF HAS_CLASSVARS}
var
  IndyWebRequestHandler: TIdHTTPWebBrokerBridgeRequestHandler = nil;
{$ENDIF}

{ TIdHTTPWebBrokerBridgeRequestHandler }

procedure TIdHTTPWebBrokerBridgeRequestHandler.Run(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LRequest: TIdHTTPAppRequest;
  LResponse: TIdHTTPAppResponse;
begin
  try
    LRequest := TIdHTTPAppRequest.Create(AThread, ARequestInfo, AResponseInfo);
    try
      LResponse := TIdHTTPAppResponse.Create(LRequest, AThread, ARequestInfo, AResponseInfo);
      try
        // WebBroker will free it and we cannot change this behaviour
        AResponseInfo.FreeContentStream := False;
        HandleRequest(LRequest, LResponse);
      finally
        FreeAndNil(LResponse);
      end;
    finally
      FreeAndNil(LRequest);
    end;
  except
    // Let Indy handle this exception
    raise;
  end;
end;

constructor TIdHTTPWebBrokerBridgeRequestHandler.Create(AOwner: TComponent);
begin
  inherited;
  Classes.ApplicationHandleException := HandleException;
end;

destructor TIdHTTPWebBrokerBridgeRequestHandler.Destroy;
begin
  Classes.ApplicationHandleException := nil;
  inherited;
end;

{$IFDEF HAS_CLASSVARS}
  {$IFDEF HAS_CLASSDESTRUCTOR}
class destructor TIdHTTPWebBrokerBridgeRequestHandler.Destroy;
begin
  FreeAndNil(FWebRequestHandler);
end;
  {$ENDIF}
{$ENDIF}

function IdHTTPWebBrokerBridgeRequestHandler: TWebRequestHandler;
begin
  {$IFDEF HAS_CLASSVARS}
  if not Assigned(TIdHTTPWebBrokerBridgeRequestHandler.FWebRequestHandler) then
    TIdHTTPWebBrokerBridgeRequestHandler.FWebRequestHandler := TIdHTTPWebBrokerBridgeRequestHandler.Create(nil);
  Result := TIdHTTPWebBrokerBridgeRequestHandler.FWebRequestHandler;
  {$ELSE}
  if not Assigned(IndyWebRequestHandler) then
    IndyWebRequestHandler := TIdHTTPWebBrokerBridgeRequestHandler.Create(nil);
  Result := IndyWebRequestHandler;
  {$ENDIF}
end;

procedure TIdHTTPWebBrokerBridge.DoCommandGet(AThread: TIdContext;
 ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if FWebModuleClass <> nil then begin
    // FWebModuleClass, RegisterWebModuleClass supported for backward compatability
    RunWebModuleClass(AThread, ARequestInfo, AResponseInfo)
  end else
  begin
    {$IFDEF HAS_CLASSVARS}
    TIdHTTPWebBrokerBridgeRequestHandler.FWebRequestHandler.Run(AThread, ARequestInfo, AResponseInfo);
    {$ELSE}
    IndyWebRequestHandler.Run(AThread, ARequestInfo, AResponseInfo);
    {$ENDIF}
  end;
end;

procedure TIdHTTPWebBrokerBridge.RunWebModuleClass(AThread: TIdContext;
 ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LRequest: TIdHTTPAppRequest;
  LResponse: TIdHTTPAppResponse;
  LWebModule: TCustomWebDispatcher;
  {$IFDEF VCL_6_OR_ABOVE}
  WebRequestHandler: IWebRequestHandler;
  {$ENDIF}
  Handled: Boolean;
begin
  LRequest := TIdHTTPAppRequest.Create(AThread, ARequestInfo, AResponseInfo);
  try
    LResponse := TIdHTTPAppResponse.Create(LRequest, AThread, ARequestInfo, AResponseInfo);
    try
      // WebBroker will free it and we cannot change this behaviour
      AResponseInfo.FreeContentStream := False;
      // There are better ways in D6, but this works in D5
      LWebModule := FWebModuleClass.Create(nil) as TCustomWebDispatcher;
      try
        {$IFDEF VCL_6_OR_ABOVE}
        if Supports(LWebModule, IWebRequestHandler, WebRequestHandler) then begin
          try
            Handled := WebRequestHandler.HandleRequest(LRequest, LResponse);
          finally
            WebRequestHandler := nil;
          end;
        end else begin
          Handled := TWebDispatcherAccess(LWebModule).DispatchAction(LRequest, LResponse);
        end;
        {$ELSE}
        Handled := TWebDispatcherAccess(LWebModule).DispatchAction(LRequest, LResponse);
        {$ENDIF}
        if Handled and (not LResponse.Sent) then begin
          LResponse.SendResponse;
        end;
      finally
        FreeAndNil(LWebModule);
      end;
    finally
      FreeAndNil(LResponse);
    end;
  finally
    FreeAndNil(LRequest);
  end;
end;

// FWebModuleClass, RegisterWebModuleClass supported for backward compatability
// Instead set WebModuleClass using: WebReq.WebRequestHandler.WebModuleClass := TWebModule1;
procedure TIdHTTPWebBrokerBridge.RegisterWebModuleClass(AClass: TComponentClass);
begin
  FWebModuleClass := AClass;
end;

initialization
  WebReq.WebRequestHandlerProc := IdHTTPWebBrokerBridgeRequestHandler;
{$IFDEF HAS_CLASSVARS}
  {$IFNDEF HAS_CLASSDESTRUCTOR}
finalization
  FreeAndNil(TIdHTTPWebBrokerBridgeRequestHandler.FWebRequestHandler);
  {$ENDIF}
{$ELSE}
finalization
  FreeAndNil(IndyWebRequestHandler);
{$ENDIF}

end.


