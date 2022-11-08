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
  Rev 1.2    1/25/2004 2:17:52 PM  JPMugaas
  Should work better.  Removed one GPF in S/Key.

  Rev 1.1    1/21/2004 4:03:16 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:00:30 AM  JPMugaas

  Basic LOGIN mechanism like SMTP uses it. This is not really specified in
  a RFC - at least I couldn't find one.
  This is of type TIdSASLUserPass because it needs a username/password
}

unit IdSASLLogin;

interface

{$i IdCompilerDefines.inc}

uses
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLLogin = class(TIdSASLUserPass)
  protected
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;

    function TryStartAuthenticate(const AHost, AProtocolName : string; var VInitialResponse: String): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName : string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : String): String; override;
  end;

implementation

uses
  IdGlobal, IdUserPassProvider, IdBaseComponent;

function IsUsernameChallenge(const AChallenge: string): Boolean;
begin
  // in the original spec for LOGIN (draft-murchison-sasl-login-00.txt), the
  // username prompt is defined as 'User Name'. However, the spec also mentions
  // that there is at least one widely deployed client that expects 'Username:'
  // instead, and that is the prompt that most 3rd party documentations of LOGIN
  // describe.  So we will look for that one first, falling back to the original
  // speced one.  Also throwing in 'Username' just for good measure, as I have
  // seen that one mentioned in passing...
  Result := PosInStrArray(AChallenge, ['Username:', 'User Name', 'Username'], False) <> -1; {Do not Localize}
end;

function IsPasswordChallenge(const AChallenge: string): Boolean;
begin
  // in the original spec for LOGIN (draft-murchison-sasl-login-00.txt), the
  // password prompt is defined as 'Password'. However, the spec also mentions
  // that there is at least one widely deployed client that expects 'Password:'
  // instead, and that is the prompt that most 3rd party documentations of LOGIN
  // describe.  So we will look for that one first, falling back to the original
  // speced one...
  Result := PosInStrArray(AChallenge, ['Password:', 'Password'], False) <> -1; {Do not Localize}
end;

{ TIdSASLLogin }

function TIdSASLLogin.TryStartAuthenticate(const AHost, AProtocolName: string;
  var VInitialResponse: String): Boolean;
begin
  VInitialResponse := GetUsername;
  Result := True;
end;

function TIdSASLLogin.StartAuthenticate(const AChallenge, AHost, AProtocolName: string): String;
begin
  if IsUsernameChallenge(AChallenge) then begin // the usual case
    Result := GetUsername;
  end else begin
    Result := ''; // TODO: throw an exception instead?
  end;
end;

function TIdSASLLogin.ContinueAuthenticate(const ALastResponse, AHost, AProtocolName: String): String;
begin
  // RLebeau 8/26/2022: TIdSMTP calls TIdSASLEntries.LoginSASL() with ACanAttemptIR=True,
  // so the Username will be sent in the AUTH command's optional Initial-Response parameter.
  // Most SMTP servers support Initial-Response, but some do not, and unfortunately there
  // is no server advertisement for Initial-Response support defined for SMTP (unlike in
  // other protocols).  If the server does not reject the AUTH command, but does not support
  // Initial-Response, the initial prompt will be for the username, not the password.
  // However, LoginSASL() will have already moved on from the initial step, and will call
  // ContinueAuthenticate() instead of StartAuthenticate(), so we need to handle both prompts
  // here ...
  if IsPasswordChallenge(ALastResponse) then begin // the usual case, so check it first
    Result := GetPassword;
  end else begin // if the Initial-Response is ignored
    Result := StartAuthenticate(ALastResponse, AHost, AProtocolName);
  end;
end;

procedure TIdSASLLogin.InitComponent;
begin
  inherited InitComponent;
  FSecurityLevel := 200;
end;

class function TIdSASLLogin.ServiceName: TIdSASLServiceName;
begin
  Result := 'LOGIN'; {Do not translate}
end;

end.
