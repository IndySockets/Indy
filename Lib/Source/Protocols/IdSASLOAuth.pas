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

unit IdSASLOAuth;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLOAuth2BearerTokenEvent = procedure(Sender: TObject; var AccessToken: String) of object;

  {
  Implements RFC 7628
  A Set of Simple Authentication and Security Layer (SASL) Mechanisms for OAuth
  }

  TIdSASLOAuth2Base = class(TIdSASLUserPass)
  protected
    FOnGetAccessToken: TIdSASLOAuth2BearerTokenEvent;

    function DoStartAuthenticate(const AHost: string; const APort: TIdPort; const AAccessToken: string): String; virtual; abstract;
    function DoContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort): String; virtual; abstract;

  public
    function TryStartAuthenticate(const AHost: string; const APort: TIdPort; const AProtocolName : string; var VInitialResponse: String): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost: string; const APort: TIdPort; const AProtocolName : string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort; const AProtocolName : String): String; override;

    function IsReadyToStart: Boolean; override;

  published
    property OnGetAccessToken: TIdSASLOAuth2BearerTokenEvent read FOnGetAccessToken write FOnGetAccessToken;
  end;

  TIdSASLOAuth2Bearer = class(TIdSASLOAuth2Base)
  protected
    function DoStartAuthenticate(const AHost: string; const APort: TIdPort; const AAccessToken: string): String; override;
    function DoContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort): String; override;
  public
    class function ServiceName: TIdSASLServiceName; override;
  end;

  TIdSASLOAuth10ATokenEvent = procedure(Sender: TObject; var ARealm, AConsumerKey, AAccessToken, ASignatureMethod, ATimestamp, ANonce, ASignature: String) of object;

  TIdSASLOAuth10A = class(TIdSASLUserPass)
  protected
    FOnGetAccessToken: TIdSASLOAuth10ATokenEvent;

  public
    class function ServiceName: TIdSASLServiceName; override;

    function TryStartAuthenticate(const AHost: string; const APort: TIdPort; const AProtocolName : string; var VInitialResponse: String): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost: string; const APort: TIdPort; const AProtocolName : string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort; const AProtocolName : String): String; override;

    function IsReadyToStart: Boolean; override;

  published
    property OnGetAccessToken: TIdSASLOAuth10ATokenEvent read FOnGetAccessToken write FOnGetAccessToken;
  end;

  {
  Implements Google's XOAUTH2 extension
  }

  TIdSASLXOAuth2 = class(TIdSASLOAuth2Base)
  protected
    function DoStartAuthenticate(const AHost: string; const APort: TIdPort; const AAccessToken: string): String; override;
    function DoContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort): String; override;
  public
    class function ServiceName: TIdSASLServiceName; override;
  end;

implementation

uses
  SysUtils;

{ TIdSASLOAuth2BearerBase }

function TIdSASLOAuth2Base.TryStartAuthenticate(const AHost: string; const APort: TIdPort; const AProtocolName : string; var VInitialResponse: String): Boolean;
var
  LToken: String;
begin
  LToken := GetPassword;
  if (LToken = '') and Assigned(FOnGetAccessToken) then begin
    FOnGetAccessToken(Self, LToken);
  end;
  VInitialResponse := DoStartAuthenticate(AHost, APort, LToken);
  Result := True;
end;

function TIdSASLOAuth2Base.StartAuthenticate(const AChallenge, AHost: string; const APort: TIdPort; const AProtocolName : string) : String;
begin
  TryStartAuthenticate(AHost, APort, AProtocolName, Result);
end;

function TIdSASLOAuth2Base.ContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort; const AProtocolName : String): String;
begin
  // TODO: parse response JSON for 'status', 'scope', and 'openid-configuration' values...
  Result := DoContinueAuthenticate(ALastResponse, AHost, APort);
end;

function TIdSASLOAuth2Base.IsReadyToStart: Boolean;
begin
  Result := (GetUsername <> '') and ((GetPassword <> '') or Assigned(FOnGetAccessToken));
end;

{ TIdSASLOAuthBearer }

class function TIdSASLOAuth2Bearer.ServiceName: TIdSASLServiceName;
begin
  Result := 'OAUTHBEARER'; {do not localize}
end;

function TIdSASLOAuth2Bearer.DoStartAuthenticate(const AHost: string; const APort: TIdPort; const AAccessToken: string): String;
begin
  Result := Format('n,a=%s,'#1'host=%s'#1'port=%d'#1'auth=Bearer %s'#1#1, [GetUserName(), AHost, APort, AAccessToken]);
end;

function TIdSASLOAuth2Bearer.DoContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort): String;
begin
  Result := #1;
end;

{ TIdSASLOAuth10A }

class function TIdSASLOAuth10A.ServiceName: TIdSASLServiceName;
begin
  Result := 'OAUTH10A'; {do not localize}
end;

function TIdSASLOAuth10A.TryStartAuthenticate(const AHost: string; const APort: TIdPort; const AProtocolName : string;
  var VInitialResponse: String): Boolean;
var
  LRealm, LKey, LToken, LMethod, LTimestamp, LNonce, LSignature: string;
begin
  // TODO: add properties for these values...
  if Assigned(FOnGetAccessToken) then begin
    FOnGetAccessToken(Self, LRealm, LKey, LToken, LMethod, LTimestamp, LNonce, LSignature);
  end;
  VInitialResponse := Format(
    'n,a=%s,'#1'host=%s'#1'port=%d'#1'auth=OAuth realm="%s",oauth_consumer_key="%s",oauth_token="%s",oauth_signature_method="%s",oauth_timestamp="%s",oauth_nonce="%s",oauth_signature="%s"'#1#1, {do not localize}
    [GetUsername, AHost, APort, LRealm, LKey, LToken, LMethod, LTimestamp, LNonce, LSignature]
  );
  Result := True;
end;

function TIdSASLOAuth10A.StartAuthenticate(const AChallenge, AHost: string; const APort: TIdPort; const AProtocolName : string) : String;
begin
  TryStartAuthenticate(AHost, APort, AProtocolName, Result);
end;

function TIdSASLOAuth10A.ContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort; const AProtocolName : String): String;
begin
  // TODO: parse response JSON for 'status', 'scope', and 'openid-configuration' values...
  Result := #1;
end;

function TIdSASLOAuth10A.IsReadyToStart: Boolean;
begin
  Result := (GetUsername <> '') and Assigned(FOnGetAccessToken);
end;

{ TIdSASLXOAuth2 }

class function TIdSASLXOAuth2.ServiceName: TIdSASLServiceName;
begin
  Result := 'XOAUTH2'; {do not localize}
end;

function TIdSASLXOAuth2.DoStartAuthenticate(const AHost: string; const APort: TIdPort; const AAccessToken : string): String;
begin
  Result := Format('user=%s'#1'auth=Bearer %s'#1#1, [GetUsername, AAccessToken]); {do not localize}
end;

function TIdSASLXOAuth2.DoContinueAuthenticate(const ALastResponse, AHost: string; const APort: TIdPort): String;
begin
  Result := '';
end;

end.