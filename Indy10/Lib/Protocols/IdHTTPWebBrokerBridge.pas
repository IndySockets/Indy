{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11621: IdHTTPWebBrokerBridge.pas
{
{   Rev 1.7    6/26/2004 12:11:16 AM  BGooijen
{ updates for D8
}
{
{   Rev 1.6    4/8/2004 4:00:40 PM  BGooijen
{ Fix for D8
}
{
{   Rev 1.5    07/04/2004 20:44:06  HHariri
{ Updates
}
{
{   Rev 1.4    07/04/2004 20:07:50  HHariri
{ Updates for .NET
}
{
    Rev 1.3    10/19/2003 4:50:10 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.2    10/12/2003 1:49:48 PM  BGooijen
{ Changed comment of last checkin
}
{
{   Rev 1.1    10/12/2003 1:43:32 PM  BGooijen
{ Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc
}
{
{   Rev 1.0    11/13/2002 07:54:34 AM  JPMugaas
}
unit IdHTTPWebBrokerBridge;

{$I IdCompilerDefines.inc}

(*

Original Author: Dave Nottage.
Modified by: Grahame Grieve
Modified by: Chad Z. Hower (Kudzu)

*)

interface

uses
  Classes,
  HTTPApp,
  IdContext, IdCustomHTTPServer, IdTCPServer, IdIOHandlerSocket,
  {$IFDEF CLR}System.Text,{$ENDIF}
  WebBroker;

type
  TIdHTTPAppRequest = class(TWebRequest)
  protected
    FRequestInfo   : TIdHTTPRequestInfo;
    FResponseInfo  : TIdHTTPResponseInfo;
    FThread        : TIdContext;
    FClientCursor  : Integer;
    //
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetStringVariable(Index: Integer): string; override;
  public
    constructor Create(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo);
    function GetFieldByName(const Name: string): string; override;
    {$IFDEF CLR}
    function ReadClient(var Buffer: TBytes; Count: Integer): Integer; override;
    {$ELSE}
    function ReadClient(var Buffer; Count: Integer): Integer; override;
    {$ENDIF}
    function ReadString(Count: Integer): string; override;
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var ABuffer; ACount: Integer): Integer; override;

    {$IFDEF VCL6ORABOVE}
    {$DEFINE VCL6ORABOVEORCLR}
    {$ENDIF}
    {$IFDEF CLR}
    {$DEFINE VCL6ORABOVEORCLR}
    {$ENDIF}
    {$IFDEF VCL6ORABOVEORCLR}
    function WriteHeaders(StatusCode: Integer; const ReasonString, Headers: string): Boolean; override;
    {$ENDIF}
    function WriteString(const AString: string): Boolean; override;
  end;

  TIdHTTPAppResponse = class(TWebResponse)
  protected
    FContent: string;
    FRequestInfo: TIdHTTPRequestInfo;
    FResponseInfo: TIdHTTPResponseInfo;
    FSent: Boolean;
    FThread: TIdContext;
    //
    function GetContent: string; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetStatusCode: Integer; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetLogMessage: string; override;
    function GetStringVariable(Index: Integer): string; override;
    procedure SetContent(const AValue: string); override;
    procedure SetContentStream(AValue: TStream); override;
    procedure SetStatusCode(AValue: Integer); override;
    procedure SetStringVariable(Index: Integer; const Value: string); override;
    procedure SetDateVariable(Index: Integer; const Value: TDateTime); override;
    procedure SetIntegerVariable(Index: Integer; Value: Integer); override;
    procedure SetLogMessage(const Value: string); override;
    procedure MoveCookiesAndCustomHeaders;
  public
    constructor Create(AHTTPRequest: TWebRequest; AThread: TIdContext;
     ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure SendRedirect(const URI: string); override;
    procedure SendResponse; override;
    procedure SendStream(AStream: TStream); override;
    function Sent: Boolean; override;
  end;

  TIdHTTPWebBrokerBridge = class(TIdCustomHTTPServer)
  protected
    FWebModuleClass: TComponentClass;
    //
    procedure DoCommandGet(AThread: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
     AResponseInfo: TIdHTTPResponseInfo); override;
    procedure InitComponent; override;
  public

    procedure RegisterWebModuleClass(AClass: TComponentClass);
  end;

implementation

uses
  IdBuffer, IdException, IdHTTPHeaderInfo, IdGlobal, IdCookie, IdStream,
  SysUtils, Math, IdStreamVCL;

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
Var
  i: Integer;
begin
  FThread := AThread;
  FRequestInfo := ARequestInfo;
  FResponseInfo := AResponseInfo;
  inherited Create;
  FClientCursor := 0;
  for i := 0 to ARequestInfo.Cookies.Count - 1 do begin
    CookieFields.Add(ARequestInfo.Cookies[i].ClientCookie);
  end;
end;

function TIdHTTPAppRequest.GetDateVariable(Index: Integer): TDateTime;
var
  LValue: string;
begin
  LValue := GetStringVariable(Index);
  if Length(LValue) > 0 then begin
    Result := ParseDate(LValue)
  end else begin
    Result := -1;
  end;
end;

function TIdHTTPAppRequest.GetIntegerVariable(Index: Integer): Integer;
begin
  Result := StrToIntDef(GetStringVariable(Index), -1)
end;

function TIdHTTPAppRequest.GetStringVariable(Index: Integer): string;
var
  s: string;
begin
  case Index of
    INDEX_Method          : Result := FRequestInfo.Command;
    INDEX_ProtocolVersion : Result := FRequestInfo.Version;
    INDEX_URL             : Result := FRequestInfo.Document;
    INDEX_Query           : Result := FRequestInfo.UnparsedParams;
    INDEX_PathInfo        : Result := FRequestInfo.Document;
    INDEX_PathTranslated  : Result := FRequestInfo.Document;             // it's not clear quite what should be done here - we can't translate to a path
    INDEX_CacheControl    : Result := GetFieldByName('CACHE_CONTROL');   {do not localize}
    INDEX_Date            : Result := GetFieldByName('DATE');            {do not localize}
    INDEX_Accept          : Result := FRequestInfo.Accept;
    INDEX_From            : Result := FRequestInfo.From;
    INDEX_Host: begin
      s := FRequestInfo.Host;
      Result := Fetch(s, ':');
    end;
    INDEX_IfModifiedSince : Result := GetFieldByName('IF_MODIFIED_SINCE'); {do not localize}
    INDEX_Referer         : Result := FRequestInfo.Referer;
    INDEX_UserAgent       : Result := FRequestInfo.UserAgent;
    INDEX_ContentEncoding : Result := FRequestInfo.ContentEncoding;
    INDEX_ContentType     : Result := FRequestInfo.ContentType;
    INDEX_ContentLength   : Result := IntToStr(Length(FRequestInfo.UnparsedParams));
    INDEX_ContentVersion  : Result := GetFieldByName('CONTENT_VERSION'); {do not localize}
    INDEX_DerivedFrom     : Result := GetFieldByName('DERIVED_FROM');    {do not localize}
    INDEX_Expires         : Result := GetFieldByName('EXPIRES');         {do not localize}
    INDEX_Title           : Result := GetFieldByName('TITLE');           {do not localize}
    INDEX_RemoteAddr      : Result := FRequestInfo.RemoteIP;
    INDEX_RemoteHost      : Result := GetFieldByName('REMOTE_HOST');     {do not localize}
    INDEX_ScriptName      : Result := '';
    INDEX_ServerPort: begin
      Result := FRequestInfo.Host;
      Fetch(Result, ':');
      if Length(Result) = 0 then begin
        Result := IntToStr(TIdIOHandlerSocket(FThread.Connection.IOHandler).Binding.Port);
        // Result := '80';
      end;
    end;
    INDEX_Content         : Result := FRequestInfo.UnparsedParams;
    INDEX_Connection      : Result := GetFieldByName('CONNECTION');      {do not localize}
    INDEX_Cookie          : Result := '';  // not available at present. FRequestInfo.Cookies....;
    INDEX_Authorization   : Result := GetFieldByName('AUTHORIZATION');   {do not localize}
  else
    Result := '';
  end;
end;

function TIdHTTPAppRequest.GetFieldByName(const Name: string): string;
begin
  Result := FRequestInfo.RawHeaders.Values[Name];
end;

function TIdHTTPAppRequest.ReadClient;
{$IFDEF CLR}
var
  LASCII : System.Text.ASCIIEncoding;
{$ENDIF}
begin
  Result := Min(Count, length(FRequestInfo.UnparsedParams)) - FClientCursor;
  if Result > 0 then begin
    {$IFDEF CLR}
    LASCII := System.Text.ASCIIEncoding.Create;
    LASCII.GetBytes(FRequestInfo.UnparsedParams.ToCharArray(FClientCursor + 1, Result), 0, Result, Buffer, 0);
    {$ELSE}
    Move(FRequestInfo.UnparsedParams[FClientCursor + 1], Buffer, Result);
    {$ENDIF}
    Inc(FClientCursor, Result);
  end else begin
    // well, it shouldn't be less than 0. but let's not take chances
    Result := 0;
  end;
end;

function TIdHTTPAppRequest.ReadString(Count: Integer): string;
var
  LLength: Integer;
begin
  LLength := Min(Count, length(FRequestInfo.UnparsedParams)) - FClientCursor;
  if LLength > 0 then
    begin
    Result := copy(FRequestInfo.UnparsedParams, FClientCursor, LLength);
    inc(FClientCursor, LLength);
    end
  else
    Result := '';
end;

function TIdHTTPAppRequest.TranslateURI(const URI: string): string;
begin
  // we don't have the concept of a path translation. It's not quite clear
  // what to do about this. Comments welcome (grahame@kestral.com.au)
  Result := URI;
end;

{$IFDEF VCL6ORABOVEORCLR}
function TIdHTTPAppRequest.WriteHeaders(StatusCode: Integer; const ReasonString, Headers: string): Boolean;
begin
  FResponseInfo.ResponseNo := StatusCode;
  FResponseInfo.ResponseText := ReasonString;
  FResponseInfo.CustomHeaders.Add(Headers);
  FResponseInfo.WriteHeader;
  Result := True;
end;
{$ENDIF}

function TIdHTTPAppRequest.WriteString(const AString: string): Boolean;
begin
  FThread.Connection.IOHandler.Write(AString);
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
  ContentType := 'text/html'; {do not localize}
end;

function TIdHTTPAppResponse.GetContent: string;
begin
  Result := FResponseInfo.ContentText;
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
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Date             : Result := FResponseInfo.Date;
    INDEX_RESP_Expires          : Result := FResponseInfo.Expires;
    INDEX_RESP_LastModified     : Result := FResponseInfo.LastModified;
  else
    raise EIdException.Create('Invalid Index ' + inttostr(Index) + ' in TIdHTTPAppResponse.GetDateVariable'); {do not localize}
  end;
end;

procedure TIdHTTPAppResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Date             : FResponseInfo.Date := Value;
    INDEX_RESP_Expires          : FResponseInfo.Expires := Value;
    INDEX_RESP_LastModified     : FResponseInfo.LastModified := Value;
  else
    raise EIdException.Create('Invalid Index ' + inttostr(Index) + ' in TIdHTTPAppResponse.SetDateVariable'); {do not localize}
  end;
end;

function TIdHTTPAppResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_ContentLength: Result := FResponseInfo.ContentLength;
  else
    raise EIdException.Create('Invalid Index ' + inttostr(Index) + ' in TIdHTTPAppResponse.GetIntegerVariable');  {do not localize}
  end;
end;

procedure TIdHTTPAppResponse.SetIntegerVariable(Index, Value: Integer);
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_ContentLength: FResponseInfo.ContentLength := Value;
  else
    raise EIdException.Create('Invalid Index ' + inttostr(Index) + ' in TIdHTTPAppResponse.SetIntegerVariable');  {do not localize}
  end;
end;

function TIdHTTPAppResponse.GetStringVariable(Index: Integer): string;
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Version           :Result := FRequestInfo.Version;
    INDEX_RESP_ReasonString      :Result := FResponseInfo.ResponseText;
    INDEX_RESP_Server            :Result := FResponseInfo.Server;
    INDEX_RESP_WWWAuthenticate   :Result := FResponseInfo.WWWAuthenticate.Text;
    INDEX_RESP_Realm             :Result := FResponseInfo.AuthRealm;
    INDEX_RESP_Allow             :Result := FResponseInfo.CustomHeaders.Values['Allow'];        {do not localize}
    INDEX_RESP_Location          :Result := FResponseInfo.Location;
    INDEX_RESP_ContentEncoding   :Result := FResponseInfo.ContentEncoding;
    INDEX_RESP_ContentType       :Result := FResponseInfo.ContentType;
    INDEX_RESP_ContentVersion    :Result := FResponseInfo.ContentVersion;
    INDEX_RESP_DerivedFrom       :Result := FResponseInfo.CustomHeaders.Values['Derived-From']; {do not localize}
    INDEX_RESP_Title             :Result := FResponseInfo.CustomHeaders.Values['Title'];        {do not localize}
  else
    raise EIdException.Create('Invalid Index ' + IntToStr(Index) +  {do not localize}
     ' in TIdHTTPAppResponse.GetStringVariable');                   {do not localize}
  end;
end;

procedure TIdHTTPAppResponse.SetStringVariable(Index: Integer; const Value: string);
begin
  //TODO: resource string these
  case Index of
    INDEX_RESP_Version           :EIdException.Create('TIdHTTPAppResponse.SetStringVariable: Cannot set the version');  {do not localize}
    INDEX_RESP_ReasonString      :FResponseInfo.ResponseText := Value;
    INDEX_RESP_Server            :FResponseInfo.Server := Value;
    INDEX_RESP_WWWAuthenticate   :FResponseInfo.WWWAuthenticate.Text := Value;
    INDEX_RESP_Realm             :FResponseInfo.AuthRealm := Value;
    INDEX_RESP_Allow             :FResponseInfo.CustomHeaders.Values['Allow'] := Value; {do not localize}
    INDEX_RESP_Location          :FResponseInfo.Location := Value;
    INDEX_RESP_ContentEncoding   :FResponseInfo.ContentEncoding := Value;
    INDEX_RESP_ContentType       :FResponseInfo.ContentType := Value;
    INDEX_RESP_ContentVersion    :FResponseInfo.ContentVersion := Value;
    INDEX_RESP_DerivedFrom       :FResponseInfo.CustomHeaders.Values['Derived-From'] := Value;  {do not localize}
    INDEX_RESP_Title             :FResponseInfo.CustomHeaders.Values['Title'] := Value; {do not localize}
  else
    raise EIdException.Create('Invalid Index ' + IntToStr(Index) +  {do not localize}
     ' in TIdHTTPAppResponse.SetStringVariable');                   {do not localize}
  end;
end;

procedure TIdHTTPAppResponse.SendRedirect(const URI: string);
begin
  FSent := True;
  MoveCookiesAndCustomHeaders;
  FResponseInfo.Redirect(URI);
end;

procedure TIdHTTPAppResponse.SendResponse;
begin
  FSent := True;
  // Reset to -1 so Indy will auto set it
  FResponseInfo.ContentLength := -1;
  MoveCookiesAndCustomHeaders;
  FResponseInfo.WriteContent;
end;

procedure TIdHTTPAppResponse.SendStream(AStream: TStream);
var
  LStream : TIdStreamVCL;
begin
  LStream := TIdStreamVCL.Create(AStream);
  try
    FThread.Connection.IOHandler.Write(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

function TIdHTTPAppResponse.Sent: Boolean;
begin
  Result := FSent;
end;

procedure TIdHTTPAppResponse.SetContent(const AValue: string);
begin
  FResponseInfo.ContentText := AValue;
  FResponseInfo.ContentLength := Length(AValue);
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

procedure TIdHTTPAppResponse.MoveCookiesAndCustomHeaders;
Var
  i: Integer;
begin
  for i := 0 to Cookies.Count - 1 do begin
    with FResponseInfo.Cookies.Add do begin
      CookieText := Cookies[i].HeaderValue
    end;
  end;
  FResponseInfo.CustomHeaders.Clear;
  for i := 0 to CustomHeaders.Count - 1 do begin
    FResponseInfo.CustomHeaders.Values[CustomHeaders.Names[i]] :=
      CustomHeaders.Values[CustomHeaders.Names[i]];
  end;
end;

{ TIdHTTPWebBrokerBridge }

procedure TIdHTTPWebBrokerBridge.InitComponent;
begin
  inherited;
  FOkToProcessCommand := True;
end;

procedure TIdHTTPWebBrokerBridge.DoCommandGet(AThread: TIdContext;
 ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LRequest: TIdHTTPAppRequest;
  LResponse: TIdHTTPAppResponse;
  LWebModule: TCustomWebDispatcher;
begin
  LRequest := TIdHTTPAppRequest.Create(AThread, ARequestInfo, AResponseInfo); try
    LResponse := TIdHTTPAppResponse.Create(LRequest, AThread, ARequestInfo, AResponseInfo); try
      // WebBroker will free it and we cannot change this behaviour
      AResponseInfo.FreeContentStream := False;
      // There are better ways in D6, but this works in D5
      LWebModule := FWebModuleClass.Create(nil) as TCustomWebDispatcher; try
        if TWebDispatcherAccess(LWebModule).DispatchAction(LRequest, LResponse) then begin
          if not LResponse.Sent then begin
            LResponse.SendResponse;
          end;
        end;
      finally FreeAndNil(LWebModule); end;
    finally FreeAndNil(LResponse); end;
  finally FreeAndNil(LRequest); end;
end;

procedure TIdHTTPWebBrokerBridge.RegisterWebModuleClass(AClass: TComponentClass);
begin
  FWebModuleClass := AClass;
end;

end.


