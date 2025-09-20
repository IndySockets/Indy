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
  Rev 1.7    10/26/2004 11:08:10 PM  JPMugaas
  Updated refs.

  Rev 1.6    28.09.2004 21:35:28  Andreas Hausladen
  Added TIdObjectList.Assign method for missing Delphi 5 TList.Assign

  Rev 1.5    1/4/2004 12:09:00 AM  BGooijen
  Commented out Notify, this doesn't exist in DotNet, and doesn't do anything
  anyways

  Rev 1.4    3/13/2003 11:10:52 AM  JPMugaas
  Fixed warning message.

  Rev 1.3    2/8/2003 04:33:34 AM  JPMugaas
  Commented out a free statement in the TIdObjectList.Notify method because it
  was causing instability in some new IdFTPList code I was working on.
  Added a TStringList descendent object that implements a buble sort.  That
  should require less memory than a QuickSort.  This also replaces the
  TStrings.CustomSort because that is not supported in D4.

  Rev 1.2    2/7/2003 10:33:48 AM  JPMugaas
  Added BoubleSort to TIdObjectList to facilitate some work.

  Rev 1.1    12/2/2002 04:32:30 AM  JPMugaas
  Fixed minor compile errors.

  Rev 1.0    11/14/2002 02:16:14 PM  JPMugaas

  Revision 1.0  2001-02-20 02:02:09-05  dsiders
  Initial revision
}

{********************************************************************}
{*  IdContainers.pas                                                *}
{*                                                                  *}
{*  Provides compatibility with the Contnr.pas unit from            *}
{*  Delphi 5 not found in Delphi 4.                                 *}
{*                                                                  *}
{*  Based on ideas from the Borland VCL Contnr.pas interface.       *}
{*                                                                  *}
{********************************************************************}

unit IdContainers;

interface

{$i IdCompilerDefines.inc}

uses
  Classes
  {$IFDEF HAS_UNIT_Generics_Collections}
  , System.Generics.Collections
  {$ELSE}
    {$IFDEF HAS_TObjectList}
  , Contnrs
    {$ENDIF}
  {$ENDIF}
  ;

type
  {$IFDEF HAS_GENERICS_TObjectList}
  TIdSortCompare<T: class> = function(AItem1, AItem2 : T): Integer;
  {$ELSE}
  TIdSortCompare = function(AItem1, AItem2 : TObject): Integer;
  {$ENDIF}

  {TIdObjectList}

  {$IFDEF HAS_GENERICS_TObjectList}
  TIdObjectList<T: class> = class(TObjectList<T>)
  public
    procedure BubbleSort(ACompare : TIdSortCompare<T>);
    procedure Assign(Source: TIdObjectList<T>);
  end;
  {$ELSE}
    {$IFDEF HAS_TObjectList}
  TIdObjectList = class(TObjectList)
  public
    procedure BubbleSort(ACompare : TIdSortCompare);
    // Delphi 5 does not have TList.Assign.
    // This is a simplyfied Assign method that does only support the copy operation.
    procedure Assign(Source: TIdObjectList); {$IFDEF VCL_6_OR_ABOVE}reintroduce;{$ENDIF}
  end;
    {$ELSE}
  TIdObjectList = class(TList)
  private
    FOwnsObjects: Boolean;
  protected
    function GetItem(AIndex: Integer): TObject;
    procedure SetItem(AIndex: Integer; AObject: TObject);
    {$IFNDEF DOTNET}
    procedure Notify(AItemPtr: Pointer; AAction: TListNotification); override;
    {$ENDIF}
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;
    procedure BubbleSort(ACompare : TIdSortCompare);
    function Add(AObject: TObject): Integer;
    function FindInstanceOf(AClassRef: TClass; AMatchExact: Boolean = True; AStartPos: Integer = 0): Integer;
    function IndexOf(AObject: TObject): Integer;
    function Remove(AObject: TObject): Integer;
    procedure Insert(AIndex: Integer; AObject: TObject);
    procedure Assign(Source: TIdObjectList);
    property Items[AIndex: Integer]: TObject read GetItem write SetItem; default;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;
    {$ENDIF}
  {$ENDIF}

  TIdStringListSortCompare = function(List: TStringList; Index1, Index2: Integer): Integer;

  TIdBubbleSortStringList = class(TStringList)
  public
    procedure BubbleSort(ACompare: TIdStringListSortCompare); virtual;
  end;

implementation

{$IFDEF VCL_XE3_OR_ABOVE}
uses
  System.Types;
{$ENDIF}

{ TIdObjectList }

{$IFNDEF HAS_GENERICS_TObjectList}
  {$IFNDEF HAS_TObjectList}

constructor TIdObjectList.Create;
begin
  inherited Create;
  FOwnsObjects := True;
end;

constructor TIdObjectList.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TIdObjectList.Add(AObject: TObject): Integer;
begin
  Result := inherited Add(AObject);
end;

function TIdObjectList.FindInstanceOf(AClassRef: TClass;
  AMatchExact: Boolean = True; AStartPos: Integer = 0): Integer;
var
  iPos: Integer;
  bIsAMatch: Boolean;
begin
  Result := -1;   // indicates item is not in object list

  for iPos := AStartPos to Count - 1 do
  begin
    bIsAMatch :=
      ((not AMatchExact) and Items[iPos].InheritsFrom(AClassRef)) or
      (AMatchExact and (Items[iPos].ClassType = AClassRef));

    if bIsAMatch then
    begin
      Result := iPos;
      Break;
    end;
  end;
end;

function TIdObjectList.GetItem(AIndex: Integer): TObject;
begin
  Result := inherited Items[AIndex];
end;

function TIdObjectList.IndexOf(AObject: TObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TIdObjectList.Insert(AIndex: Integer; AObject: TObject);
begin
  inherited Insert(AIndex, AObject);
end;

{$IFNDEF DOTNET}
procedure TIdObjectList.Notify(AItemPtr: Pointer; AAction: TListNotification);
begin
  if OwnsObjects and (AAction = lnDeleted) then begin
    TObject(AItemPtr).Free;
  end;
  inherited Notify(AItemPtr, AAction);
end;
{$ENDIF}

function TIdObjectList.Remove(AObject: TObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TIdObjectList.SetItem(AIndex: Integer; AObject: TObject);
begin
  inherited Items[AIndex] := AObject;
end;

  {$ENDIF}
{$ENDIF}

{$IFDEF HAS_GENERICS_TObjectList}
procedure TIdObjectList<T>.BubbleSort(ACompare: TIdSortCompare<T>);
{$ELSE}
procedure TIdObjectList.BubbleSort(ACompare: TIdSortCompare);
{$ENDIF}
var
  i, n, newn : Integer;
begin
  n := Count;
  repeat
    newn := 0;
    for i := 1 to n-1 do begin
      if ACompare(Items[i-1], Items[i]) > 0 then begin
        Exchange(i-1, i);
        newn := i;
      end;
    end;
    n := newn;
  until n = 0;
end;

{$IFDEF HAS_GENERICS_TObjectList}
procedure TIdObjectList<T>.Assign(Source: TIdObjectList<T>);
{$ELSE}
procedure TIdObjectList.Assign(Source: TIdObjectList);
{$ENDIF}
var
  I: Integer;
begin
  // Delphi 5 does not have TList.Assign.
  // This is a simplyfied Assign method that does only support the copy operation.
  Clear;
  Capacity := Source.Capacity;
  for I := 0 to Source.Count - 1 do begin
    Add(Source[I]);
  end;
end;

{ TIdBubbleSortStringList }

procedure TIdBubbleSortStringList.BubbleSort(ACompare: TIdStringListSortCompare);
var
  i, n, newn : Integer;
begin
  n := Count;
  repeat
    newn := 0;
    for i := 1 to n-1 do begin
      if ACompare(Self, i-1, i) > 0 then begin
        Exchange(i-1, i);
        newn := i;
      end;
    end;
    n := newn;
  until n = 0;
end;

end.
