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
  Rev 1.1    1/21/2004 4:03:14 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:00:16 AM  JPMugaas
}

unit IdSASLExternal;

interface

{$i IdCompilerDefines.inc}

uses
  IdSASL, IdTCPConnection;

{
  Implements RFC 2222: External SASL Mechanism
  Added 2002-08
}

type
  TIdSASLExternal = class(TIdSASL)
  protected
    FAuthIdentity: String;
    procedure InitComponent; override;
  public
    function IsReadyToStart: Boolean; override;
    class function ServiceName: TIdSASLServiceName; override;
    function TryStartAuthenticate(const AHost, AProtocolName: String; var VInitialResponse: string): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName: String): String; override;
  published
    property AuthorizationIdentity : String read FAuthIdentity write FAuthIdentity;
  end;

implementation

{ TIdSASLExternal }

procedure TIdSASLExternal.InitComponent;
begin
  inherited;
  FSecurityLevel := 0; // unknown, depends on what the server does
end;

function TIdSASLExternal.IsReadyToStart: Boolean;
begin
  Result := (AuthorizationIdentity <> '');
end;

class function TIdSASLExternal.ServiceName: TIdSASLServiceName;
begin
  Result := 'EXTERNAL';  {Do not translate}
end;

function TIdSASLExternal.TryStartAuthenticate(const AHost, AProtocolName: String;
  var VInitialResponse: string): Boolean;
begin
  VInitialResponse := AuthorizationIdentity;
  Result := True;
end;

function TIdSASLExternal.StartAuthenticate(const AChallenge, AHost, AProtocolName: String): String;
begin
  Result := AuthorizationIdentity;
end;

end.
