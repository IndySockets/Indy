{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11743: IdSASLUserPass.pas 
{
{   Rev 1.1    2004.02.03 5:44:18 PM  czhower
{ Name changes
}
{
{   Rev 1.0    11/13/2002 08:00:40 AM  JPMugaas
}
{
  Base class for any mechanism that needs a username/password.
  This links to a TIdUserPassProvider to allow application programmers
  to only set the username/password once, instead of having to set it for
  all SASL mechanisms they might want to use.
}
unit IdSASLUserPass;

interface

uses
  IdResourceStringsProtocols, IdSASL, IdUserPassProvider, IdObjs, IdBaseComponent,
  IdException;

type
  TIdSASLUserPass = class(TIdSASL)
  protected
    FUserPassProvider: TIdUserPassProvider;
    procedure SetUserPassProvider(const Value: TIdUserPassProvider);
    procedure Notification(AComponent: TIdNativeComponent; Operation: TIdOperation);
      override;
    function GetUsername: string;
    function GetPassword: string;
  published
    property UserPassProvider: TIdUserPassProvider
      read FUserPassProvider
      write SetUserPassProvider;
  end;

  EIdUserPassProviderUnassigned = class(EIdException);

implementation

{ TIdSASLUserPass }

function TIdSASLUserPass.GetPassword: string;
begin
  if Assigned(FUserPassProvider) then begin
    Result := FUserPassProvider.GetPassword;
  end else begin
    raise EIdUserPassProviderUnassigned.Create(RSUnassignedUserPassProv);
  end;
end;

function TIdSASLUserPass.GetUsername: string;
begin
  if Assigned(FUserPassProvider) then begin
    Result := FUserPassProvider.GetUsername;
  end else begin
    raise EIdUserPassProviderUnassigned.Create(RSUnassignedUserPassProv);
  end;
end;

procedure TIdSASLUserPass.Notification(AComponent: TIdNativeComponent;
  Operation: TIdOperation);
begin
  if Operation = opRemove then begin
    if AComponent = FUserPassProvider then begin
      FUserPassProvider := nil;
    end;
  end;
  inherited;
end;

procedure TIdSASLUserPass.SetUserPassProvider(
  const Value: TIdUserPassProvider);
begin
  FUserPassProvider := Value;
  if Assigned(FUserPassProvider) then begin
    FUserPassProvider.FreeNotification(Self);
  end;
end;

end.
