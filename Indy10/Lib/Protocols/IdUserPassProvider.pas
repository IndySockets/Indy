{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11815: IdUserPassProvider.pas 
{
{   Rev 1.0    11/13/2002 08:04:28 AM  JPMugaas
}
{
  This component holds a username/password combination.
  It is used by SASL or other components in order to
  simplify application programming - the programmer will only have to
  set the username/password once if a user enters it, instead of for
  all components that instead now link to an instance of this class.
}
unit IdUserPassProvider;

interface
uses
  IdBaseComponent;

type
  TIdUserPassProvider = class(TIdBaseComponent)
  protected
    FUsername: string;
    FPassword: string;
  public
    function GetPassword: String;
    function GetUsername: String;
  published
    property Username: string read GetUsername write FUsername;
    property Password: string read GetPassword write FPassword;
  end;

implementation

{ TIdUserPassProvider }

function TIdUserPassProvider.GetPassword: String;
begin
  Result := FPassword;
end;

function TIdUserPassProvider.GetUsername: String;
begin
  Result := FUsername;
end;

end.
 
