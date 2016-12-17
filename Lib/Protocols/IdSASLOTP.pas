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
  IdException,
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLOTP = class(TIdSASLUserPass)
  protected
    function GenerateOTP(const AResponse, APassword: String): String;
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;
    function TryStartAuthenticate(const AHost, AProtocolName : String; var VInitialResponse: String): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName : String): String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : String): String; override;
  end;

implementation

uses
  IdBaseComponent, IdGlobal, IdOTPCalculator, IdUserPassProvider;

{ TIdSASLOTP }

function TIdSASLOTP.ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : String): String;
begin
  Result := GenerateOTP(ALastResponse, GetPassword);
end;

procedure TIdSASLOTP.InitComponent;
begin
  inherited InitComponent;
  FSecurityLevel := 1000;
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
