{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11739: IdSASLLogin.pas 
{
{   Rev 1.2    1/25/2004 2:17:52 PM  JPMugaas
{ Should work better.  Removed one GPF in S/Key.
}
{
{   Rev 1.1    1/21/2004 4:03:16 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 08:00:30 AM  JPMugaas
}
{
  Basic LOGIN mechanism like SMTP uses it. This is not really specified in
  a RFC - at least I couldn't find one.
  This is of type TIdSASLUserPass because it needs a username/password
}
unit IdSASLLogin;

interface
uses
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLLogin = class(TIdSASLUserPass)
  protected
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;

    function StartAuthenticate(const AChallenge:string) : String; override;
    function ContinueAuthenticate(const ALastResponse: String): String;
      override;
  end;

implementation

uses IdUserPassProvider, IdBaseComponent;

{ TIdSASLLogin }

function TIdSASLLogin.ContinueAuthenticate(
  const ALastResponse: String): String;
begin
  Result := GetPassword;
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

function TIdSASLLogin.StartAuthenticate(
  const AChallenge: string): String;
begin
  Result := GetUsername;
end;

end.
