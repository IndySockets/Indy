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
  Rev 1.4    10/26/2004 10:59:30 PM  JPMugaas
  Updated ref.

  Rev 1.3    5/29/2004 10:02:20 AM  DSiders
  Corrected case in Create parameter.

  Rev 1.2    2004.02.03 5:44:54 PM  czhower
  Name changes

  Rev 1.1    2004.01.21 1:04:52 PM  czhower
  InitComponenet

  Rev 1.0    11/14/2002 02:13:40 PM  JPMugaas
}

unit IdAuthenticationManager;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAuthentication,
  IdBaseComponent,
  IdURI;

type
  TIdAuthenticationItem = class(TCollectionItem)
  protected
    FURI: TIdURI;
    FParams: TStrings;
    procedure SetParams(const Value: TStrings);
    procedure SetURI(const Value: TIdURI);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property URL: TIdURI read FURI write SetURI;
    property Params: TStrings read FParams write SetParams;
  end;

  TIdAuthenticationCollection = class(TOwnedCollection)
  protected
    function GetAuthItem(AIndex: Integer): TIdAuthenticationItem;
    procedure SetAuthItem(AIndex: Integer; const Value: TIdAuthenticationItem);
  public
    function Add: TIdAuthenticationItem;
    constructor Create(AOwner: TPersistent);
    //
    property Items[AIndex: Integer]: TIdAuthenticationItem read GetAuthItem write SetAuthItem;
  end;

  TIdAuthenticationManager = class(TIdBaseComponent)
  protected
    FAuthentications: TIdAuthenticationCollection;
    //
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    procedure AddAuthentication(AAuthentication: TIdAuthentication; AURL: TIdURI);
    property Authentications: TIdAuthenticationCollection read FAuthentications;
  end;

implementation

uses
  IdGlobal, SysUtils;

{ TIdAuthenticationManager }

function TIdAuthenticationCollection.Add: TIdAuthenticationItem;
begin
  Result := TIdAuthenticationItem(inherited Add);
end;

constructor TIdAuthenticationCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdAuthenticationItem);
end;

function TIdAuthenticationCollection.GetAuthItem(AIndex: Integer): TIdAuthenticationItem;
begin
  Result := TIdAuthenticationItem(inherited GetItem(AIndex));
end;

procedure TIdAuthenticationCollection.SetAuthItem(AIndex: Integer;
  const Value: TIdAuthenticationItem);
begin
  inherited SetItem(AIndex, Value);
end;

{ TIdAuthenticationManager }

procedure TIdAuthenticationManager.AddAuthentication(
  AAuthentication: TIdAuthentication; AURL: TIdURI);
var
  LItem: TIdAuthenticationItem;
begin
  LItem := Authentications.Add;
  LItem.URL.URI := AURL.URI;
  LItem.Params.Assign(AAuthentication.Params);
end;

destructor TIdAuthenticationManager.Destroy;
begin
  FreeAndNil(FAuthentications);
  inherited Destroy;
end;

procedure TIdAuthenticationManager.InitComponent;
begin
  inherited InitComponent;
  FAuthentications := TIdAuthenticationCollection.Create(Self);
end;

{ TIdAuthenticationItem }

constructor TIdAuthenticationItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FURI := TIdURI.Create;
  FParams := TStringList.Create;
end;

destructor TIdAuthenticationItem.Destroy;
begin
  FreeAndNil(FURI);
  FreeAndNil(FParams);
  inherited Destroy;
end;

procedure TIdAuthenticationItem.Assign(Source: TPersistent);
var
  LSource: TIdAuthenticationItem;
begin
  if Source is TIdAuthenticationItem then begin
    LSource := TIdAuthenticationItem(Source);
    URL.URI := LSource.URL.URI;
    Params.Assign(LSource.Params);
  end else begin
    inherited Assign(Source);
  end;
end;

procedure TIdAuthenticationItem.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

procedure TIdAuthenticationItem.SetURI(const Value: TIdURI);
begin
  FURI.URI := Value.URI;
end;

end.
