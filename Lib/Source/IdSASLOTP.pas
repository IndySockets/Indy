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
  Rev 1.4    2004.02.03 5:45:12 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 4:03:16 PM  JPMugaas
  InitComponent

    Rev 1.2    10/19/2003 5:57:18 PM  DSiders
  Added localization comments.

  Rev 1.1    5/10/2003 10:10:44 PM  JPMugaas
  Bug fixes.

  Rev 1.0    12/16/2002 03:27:22 AM  JPMugaas
  Initial version of IdSASLOTP.  This is the OTP (One-Time-only password) SASL
  mechanism.
}

{This is based on RFC2444}

unit IdSASLOTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLOTP = class(TIdSASLUserPass)
  protected
    function GenerateOTP(const AResponse, APassword: String): String;
  public
    constructor Create(AOwner: TComponent); override;
    class function ServiceName: TIdSASLServiceName; override;
    function TryStartAuthenticate(const AHost, AProtocolName : String; var VInitialResponse: String): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName : String): String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : String): String; override;
  end;

implementation

uses
  IdGlobal, IdOTPCalculator;

{ TIdSASLOTP }

constructor TIdSASLOTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSecurityLevel := 1000;
end;

function TIdSASLOTP.ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : String): String;
begin
  // RLebeau 4/17/2018: TIdSMTP calls TIdSASLEntries.LoginSASL() with ACanAttemptIR=True,
  // so the Username will be sent in the AUTH command's optional Initial-Response parameter.
  // Most SMTP servers support Initial-Response, but some do not, and unfortunately there
  // is no server advertisement for Initial-Response support defined for SMTP (unlike in
  // other protocols).  If the server does not reject the AUTH command, but does not support
  // Initial-Response, the initial prompt will be for the username, not the password.
  // However, LoginSASL() will have already moved on from the initial step, and will call
  // ContinueAuthenticate() instead of StartAuthenticate(), so we need to handle both prompts
  // here ...
  if TextStartsWith(ALastResponse, 'otp-') then begin // the usual case, so check it first...
    Result := GenerateOTP(ALastResponse, GetPassword);
  end else begin // if the Initial-Response is ignored
    Result := StartAuthenticate(ALastResponse, AHost, AProtocolName);
  end;
end;

class function TIdSASLOTP.ServiceName: TIdSASLServiceName;
begin
  Result := 'OTP'; {Do not translate}
end;

function TIdSASLOTP.TryStartAuthenticate(const AHost, AProtocolName : string;
  var VInitialResponse: String): Boolean;
begin
  VInitialResponse := GetUsername;
  Result := True;
end;

function TIdSASLOTP.StartAuthenticate(const AChallenge, AHost, AProtocolName : string): String;
begin
  Result := GetUsername;
end;

function TIdSASLOTP.GenerateOTP(const AResponse, APassword: String): String;
var
  LKey: String;
begin
  if TIdOTPCalculator.GenerateSixWordKey(AResponse, APassword, LKey) then begin
    Result := 'word:' + LKey; {do not localize}
  end else begin
    Result := '';
  end;
end;

end.
