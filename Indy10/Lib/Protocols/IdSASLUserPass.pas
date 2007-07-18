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
  Rev 1.1    2004.02.03 5:44:18 PM  czhower
  Name changes

  Rev 1.0    11/13/2002 08:00:40 AM  JPMugaas

  Base class for any mechanism that needs a username/password.
  This links to a TIdUserPassProvider to allow application programmers
  to only set the username/password once, instead of having to set it for
  all SASL mechanisms they might want to use.
}

unit IdSASLUserPass;

interface

uses
  Classes,
  IdResourceStringsProtocols, IdSASL, IdUserPassProvider, IdBaseComponent,
  IdException;

type
  TIdSASLUserPass = class(TIdSASL)
  protected
    FUserPassProvider: TIdUserPassProvider;
    procedure SetUserPassProvider(const Value: TIdUserPassProvider);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
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

procedure TIdSASLUserPass.Notification(AComponent: TComponent;
  Operation: TOperation);
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
