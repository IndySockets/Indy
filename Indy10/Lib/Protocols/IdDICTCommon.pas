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
  Rev 1.4    10/26/2004 8:59:34 PM  JPMugaas
  Updated with new TStrings references for more portability.

  Rev 1.3    2004.10.26 11:47:56 AM  czhower
  Changes to fix a conflict with aliaser.

  Rev 1.2    8/16/2004 1:15:00 PM  JPMugaas
  Create and Destroy need to have the same visibility as inherited methods.

    Rev 1.1    6/11/2004 6:16:48 AM  DSiders
  Corrected spelling in class names, properties, and methods.

  Rev 1.0    3/4/2004 2:43:26 PM  JPMugaas
  RFC 2229 DICT Protocol helper objects for the client and probably when the
  server when we get to it.
}

unit IdDICTCommon;

interface

{$i IdCompilerDefines.inc}

uses
  Classes;

type
  TIdMatchItem = class(TCollectionItem)
  protected
    FDB : String;
    FWord : String;
  published
    property DB : String read FDB write FDB;
    property Word : String read FWord write FWord;
  end;

  TIdMatchList = class(TCollection)
  protected
    function GetItems(AIndex: Integer): TIdMatchItem;
    procedure SetItems(AIndex: Integer; const AValue: TIdMatchItem);
  public
    constructor Create; reintroduce; virtual;
    function IndexOf(AItem: TIdMatchItem): Integer;
    function Add: TIdMatchItem;
    property Items[AIndex: Integer]: TIdMatchItem read GetItems write SetItems; default;
  end;

  TIdGeneric = class(TCollectionItem)
  protected
    FName : String;
    FDesc : String;
  published
    property Name : String read FName write FName;
    property Desc : String read FDesc write FDesc;
  end;

  TIdStrategy = class(TIdGeneric);

  TIdStrategyList = class(TCollection)
  protected
    function GetItems(AIndex: Integer): TIdStrategy;
    procedure SetItems(AIndex: Integer; const AValue: TIdStrategy);
  public
    constructor Create; reintroduce; virtual;
    function IndexOf(AItem: TIdStrategy): Integer;
    function Add: TIdStrategy;
    property Items[AIndex: Integer]: TIdStrategy read GetItems write SetItems; default;
  end;

  TIdDBInfo = class(TIdGeneric);

  TIdDBList = class(TCollection)
  protected
    function GetItems(AIndex: Integer): TIdDBInfo;
    procedure SetItems(AIndex: Integer; const AValue: TIdDBInfo);
  public
    constructor Create; reintroduce; virtual;
    function IndexOf(AItem: TIdDBInfo): Integer;
    function Add: TIdDBInfo;
    property Items[AIndex: Integer]: TIdDBInfo read GetItems write SetItems; default;
  end;

  TIdDefinition = class(TCollectionItem)
  protected
    FWord : String;
    FDefinition : TStrings;
    FDB : TIdDBInfo;
    procedure SetDefinition(AValue : TStrings);
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
 published
    property Word : string read FWord write FWord;
    property DB : TIdDBInfo read FDB write FDB;
    property Definition : TStrings read FDefinition write SetDefinition;
  end;

  TIdDefinitions = class(TCollection)
  protected
    function GetItems(AIndex: Integer): TIdDefinition;
    procedure SetItems(AIndex: Integer; const AValue: TIdDefinition);
  public
    constructor Create; reintroduce; virtual;
    function IndexOf(AItem: TIdDefinition): Integer;
    function Add: TIdDefinition;
    property Items[AIndex: Integer]: TIdDefinition read GetItems write SetItems; default;
  end;

implementation

uses
  IdGlobal, SysUtils;

{ TIdDefinitions }

function TIdDefinitions.Add: TIdDefinition;
begin
  Result := TIdDefinition(inherited Add);
end;

constructor TIdDefinitions.Create;
begin
  inherited Create(TIdDefinition);
end;

function TIdDefinitions.GetItems(AIndex: Integer): TIdDefinition;
begin
  Result := TIdDefinition(inherited Items[AIndex]);
end;

function TIdDefinitions.IndexOf(AItem: TIdDefinition): Integer;
Var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      Result := i;
      Break;
    end;
end;

procedure TIdDefinitions.SetItems(AIndex: Integer;
  const AValue: TIdDefinition);
begin
  inherited Items[AIndex] := AValue;
end;

{ TIdDefinition }

constructor TIdDefinition.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FDefinition := TStringList.Create;
  FDB := TIdDBInfo.Create(nil);
end;

destructor TIdDefinition.Destroy;
begin
  FreeAndNil(FDB);
  FreeAndNil(FDefinition);
  inherited Destroy;
end;

procedure TIdDefinition.SetDefinition(AValue: TStrings);
begin
  FDefinition.Assign(AValue);
end;

{ TIdDBList }

function TIdDBList.Add: TIdDBInfo;
begin
  Result := TIdDBInfo(inherited Add);
end;

constructor TIdDBList.Create;
begin
  inherited Create(TIdDBInfo);
end;

function TIdDBList.GetItems(AIndex: Integer): TIdDBInfo;
begin
  Result := TIdDBInfo(inherited Items[AIndex]);
end;

function TIdDBList.IndexOf(AItem: TIdDBInfo): Integer;
Var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      Result := i;
      Break;
    end;
end;

procedure TIdDBList.SetItems(AIndex: Integer; const AValue: TIdDBInfo);
begin
  inherited Items[AIndex] := AValue;
end;

{ TIdStrategyList }

function TIdStrategyList.Add: TIdStrategy;
begin
  Result := TIdStrategy( inherited Add);
end;

constructor TIdStrategyList.Create;
begin
  inherited Create(TIdStrategy);
end;

function TIdStrategyList.GetItems(AIndex: Integer): TIdStrategy;
begin
  Result := TIdStrategy(inherited Items[AIndex]);
end;

function TIdStrategyList.IndexOf(AItem: TIdStrategy): Integer;
Var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      Result := i;
      Break;
    end;
end;

procedure TIdStrategyList.SetItems(AIndex: Integer;
  const AValue: TIdStrategy);
begin
  inherited Items[AIndex] := AValue;
end;

{ TIdMatchList }

function TIdMatchList.Add: TIdMatchItem;
begin
  Result := TIdMatchItem(inherited Add);
end;

constructor TIdMatchList.Create;
begin
  inherited Create(TIdMatchItem);
end;

function TIdMatchList.GetItems(AIndex: Integer): TIdMatchItem;
begin
  Result := TIdMatchItem(Inherited Items[AIndex]);
end;

function TIdMatchList.IndexOf(AItem: TIdMatchItem): Integer;
Var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      Result := i;
      Break;
    end;
end;

procedure TIdMatchList.SetItems(AIndex: Integer; const AValue: TIdMatchItem);
begin
  inherited SetItem(AIndex,AValue);
end;

end.
