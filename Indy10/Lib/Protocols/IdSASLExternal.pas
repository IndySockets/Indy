{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11733: IdSASLExternal.pas 
{
{   Rev 1.1    1/21/2004 4:03:14 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 08:00:16 AM  JPMugaas
}
unit IdSASLExternal;

interface
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
    class function ServiceName: TIdSASLServiceName; override;
    function StartAuthenticate(const AChallenge: String): String; override;

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

class function TIdSASLExternal.ServiceName: TIdSASLServiceName;
begin
  Result := 'EXTERNAL';  {Do not translate}
end;

function TIdSASLExternal.StartAuthenticate(
  const AChallenge: String): String;
begin
  Result := AuthorizationIdentity;
end;

end.
