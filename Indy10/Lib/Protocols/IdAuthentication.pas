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
  Rev 1.5    10/26/2004 10:59:30 PM  JPMugaas
  Updated ref.

  Rev 1.4    2004.02.03 5:44:52 PM  czhower
  Name changes

  Rev 1.3    10/5/2003 5:01:34 PM  GGrieve
  fix to compile Under DotNet

  Rev 1.2    10/4/2003 9:09:28 PM  GGrieve
  DotNet fixes

  Rev 1.1    10/3/2003 11:40:38 PM  GGrieve
  move InfyGetHostName here

  Rev 1.0    11/14/2002 02:12:52 PM  JPMugaas

  2001-Sep-11 : DSiders
    Corrected spelling for EIdAlreadyRegisteredAuthenticationMethod
}

unit IdAuthentication;

{
  Implementation of the Basic authentication as specified in RFC 2616
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdHeaderList,
  IdGlobal,
  IdException;

type
  TIdAuthenticationSchemes = (asBasic, asDigest, asNTLM, asUnknown);
  TIdAuthSchemeSet = set of TIdAuthenticationSchemes;

  TIdAuthWhatsNext = (wnAskTheProgram, wnDoRequest, wnFail);

  TIdAuthentication = class(TPersistent)
  protected
    FCurrentStep: Integer;
    FParams: TIdHeaderList;
    FAuthParams: TIdHeaderList;

    function ReadAuthInfo(AuthName: String): String;
    function DoNext: TIdAuthWhatsNext; virtual; abstract;
    procedure SetAuthParams(AValue: TIdHeaderList);
    function GetPassword: String;
    function GetUserName: String;
    function GetSteps: Integer; virtual;
    procedure SetPassword(const Value: String); virtual;
    procedure SetUserName(const Value: String); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Reset; virtual;

    function Authentication: String; virtual; abstract;
    function KeepAlive: Boolean; virtual; abstract;
    function Next: TIdAuthWhatsNext;

    property AuthParams: TIdHeaderList read FAuthParams write SetAuthParams;
    property Params: TIdHeaderList read FParams;
    property Username: String read GetUserName write SetUserName;
    property Password: String read GetPassword write SetPassword;
    property Steps: Integer read GetSteps;
    property CurrentStep: Integer read FCurrentStep;
  end;

  TIdAuthenticationClass = class of TIdAuthentication;

  TIdBasicAuthentication = class(TIdAuthentication)
  protected
    FRealm: String;
    function DoNext: TIdAuthWhatsNext; override;
    function GetSteps: Integer; override;  // this function determines the number of steps that this
                                           // Authtentication needs take to suceed;
  public
    constructor Create; override;
    function Authentication: String; override;
    function KeepAlive: Boolean; override;
    procedure Reset; override;

    property Realm: String read FRealm write FRealm;
  end;

  EIdAlreadyRegisteredAuthenticationMethod = class(EIdException);

  { Support functions }
  procedure RegisterAuthenticationMethod(const MethodName: String; const AuthClass: TIdAuthenticationClass);
  procedure UnregisterAuthenticationMethod(const MethodName: String);
  function FindAuthClass(const AuthName: String): TIdAuthenticationClass;

implementation

uses
  IdCoderMIME, IdResourceStringsProtocols, SysUtils;

type
  TAuthListObject = class(TObject)
    Auth: TIdAuthenticationClass;
  end;

var
  AuthList: TStringList = nil;

procedure RegisterAuthenticationMethod(const MethodName: String; const AuthClass: TIdAuthenticationClass);
var
  LAuthItem: TAuthListObject;
begin
  if not Assigned(AuthList) then begin
    AuthList := TStringList.Create;
  end;

  if AuthList.IndexOf(MethodName) < 0 then begin
    LAuthItem := TAuthListObject.Create;
    LAuthItem.Auth := AuthClass;
    try
      AuthList.AddObject(MethodName, LAuthItem);
    except
      FreeAndNil(LAuthItem);
      raise;
    end;
  end
  else begin
    raise EIdAlreadyRegisteredAuthenticationMethod.CreateFmt(RSHTTPAuthAlreadyRegistered,
      [TAuthListObject(AuthList.Objects[AuthList.IndexOf(MethodName)]).Auth.ClassName]);
  end;
end;

procedure UnregisterAuthenticationMethod(const MethodName: String);
Var
  i: Integer;
begin
  if Assigned(AuthList) then begin
    i := AuthList.IndexOf(MethodName);
    if i >= 0 then begin
      AuthList.Objects[i].Free;
      AuthList.Delete(i);
    end;
  end;
end;

function FindAuthClass(const AuthName: String): TIdAuthenticationClass;
begin
  if AuthList.IndexOf(AuthName) = -1 then begin
    Result := nil;
  end else begin
    Result := TAuthListObject(AuthList.Objects[AuthList.IndexOf(AuthName)]).Auth;
  end;
end;

{ TIdAuthentication }

constructor TIdAuthentication.Create;
begin
  inherited Create;
  FAuthParams := TIdHeaderList.Create;
  FParams := TIdHeaderList.Create;
  FCurrentStep := 0;
end;

destructor TIdAuthentication.Destroy;
begin
  FreeAndNil(FAuthParams);
  FreeAndNil(FParams);
  inherited Destroy;
end;

procedure TIdAuthentication.SetAuthParams(AValue: TIdHeaderList);
begin
  FAuthParams.Assign(AValue);
end;

function TIdAuthentication.ReadAuthInfo(AuthName: String): String;
Var
  i: Integer;
begin
  for i := 0 to FAuthParams.Count - 1 do begin
    if IndyPos(AuthName, FAuthParams[i]) = 1 then begin
      Result := FAuthParams[i];
      Exit;
    end;
  end;
  Result := '';  {Do not Localize}
end;

function TIdAuthentication.Next: TIdAuthWhatsNext;
begin
  Result := DoNext;
end;

procedure TIdAuthentication.Reset;
begin
  // 
end;

function TIdAuthentication.GetPassword: String;
begin
  Result := Params.Values['password'];    {Do not Localize}
end;

function TIdAuthentication.GetUserName: String;
begin
  Result := Params.Values['username'];  {Do not Localize}
end;

procedure TIdAuthentication.SetPassword(const Value: String);
begin
  Params.Values['Password'] := Value;   {Do not Localize}
end;

procedure TIdAuthentication.SetUserName(const Value: String);
begin
  Params.Values['Username'] := Value;     {Do not Localize}
end;

function TIdAuthentication.GetSteps: Integer;
begin
  Result := 0;
end;

{ TIdBasicAuthentication }

constructor TIdBasicAuthentication.Create;
begin
  inherited Create;
  FCurrentStep := 0;
end;

function TIdBasicAuthentication.Authentication: String;
begin
  with TIdEncoderMIME.Create do try
    Result := 'Basic ' + Encode(Username + ':' + Password); {do not localize}
  finally Free; end;
end;

function TIdBasicAuthentication.DoNext: TIdAuthWhatsNext;
var
  S: String;
begin
  S := ReadAuthInfo('Basic');        {Do not Localize}
  Fetch(S);

  while Length(S) > 0 do begin
    with Params do begin
      // realm have 'realm="SomeRealmValue"' format    {Do not Localize}
      // FRealm never assigned without StringReplace
      Add(ReplaceOnlyFirst(Fetch(S, ', '), '=', NameValueSeparator));  {do not localize}
    end;
  end;

  FRealm := Copy(Params.Values['realm'], 2, Length(Params.Values['realm']) - 2);   {Do not Localize}

  if FCurrentStep = 0 then
  begin
    if Length(Username) > 0 then begin
      Result := wnDoRequest;
    end else begin
      Result := wnAskTheProgram;
    end;
  end else begin
    Result := wnFail;
  end;
end;

function TIdBasicAuthentication.KeepAlive: Boolean;
begin
  Result := False;
end;

procedure TIdBasicAuthentication.Reset;
begin
  inherited Reset;
  FCurrentStep := 0;
end;

function TIdBasicAuthentication.GetSteps: Integer;
begin
  Result := 1;
end;

initialization
  RegisterAuthenticationMethod('Basic', TIdBasicAuthentication);  {Do not Localize}
finalization
  // UnregisterAuthenticationMethod('Basic') does not need to be called in this case because
  // AuthList is freed.
  if Assigned(AuthList) then begin
    while AuthList.Count > 0 do begin
      AuthList.Objects[0].Free;
      AuthList.Delete(0);
    end;
    FreeAndNil(AuthList);
  end;
end.

