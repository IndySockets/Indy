unit IdContainers;

{********************************************************************}
{*  IdContainers.pas                                                 *}
{*                                                                  *}
{*  Provides compatibility with the Contnr.pas unit from            *}
{*  Delphi 5 not found in Delphi 4.                                 *}
{*                                                                  *}
{*  Based on ideas from the Borland VCL Contnr.pas interface.       *}
{*                                                                  *}
{********************************************************************}

{
  $Log:  13772: IdContainers.pas 
{
{   Rev 1.7    10/26/2004 11:08:10 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.6    28.09.2004 21:35:28  Andreas Hausladen
{ Added TIdObjectList.Assign method for missing Delphi 5 TList.Assign
}
{
{   Rev 1.5    1/4/2004 12:09:00 AM  BGooijen
{ Commented out Notify, this doesn't exist in DotNet, and doesn't do anything
{ anyways
}
{
{   Rev 1.4    3/13/2003 11:10:52 AM  JPMugaas
{ Fixed warning message.
}
{
{   Rev 1.3    2/8/2003 04:33:34 AM  JPMugaas
{ Commented out a free statement in the TIdObjectList.Notify method because it
{ was causing instability in some new IdFTPList code I was working on.
{ Added a TStringList descendent object that implements a buble sort.  That
{ should require less memory than a QuickSort.  This also replaces the
{ TStrings.CustomSort because that is not supported in D4.
}
{
{   Rev 1.2    2/7/2003 10:33:48 AM  JPMugaas
{ Added BoubleSort to TIdObjectList to facilitate some work.
}
{
{   Rev 1.1    12/2/2002 04:32:30 AM  JPMugaas
{ Fixed minor compile errors.
}
{
{   Rev 1.0    11/14/2002 02:16:14 PM  JPMugaas
}


{  Revision 1.0  2001-02-20 02:02:09-05  dsiders
  Initial revision
}

interface

uses
  SysUtils, Classes, IdTStrings;

type
  TIdSortCompare = function(AItem1, AItem2 : TObject):Integer;
  {TIdObjectList}

  TIdObjectList = class(TList)
  private
    FOwnsObjects: Boolean;
  protected
    function GetItem(AIndex: Integer): TObject;
    procedure SetItem(AIndex: Integer; AObject: TObject);
//    procedure Notify(AItemPtr: Pointer; AAction: TListNotification); override;
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

  TIdStringListSortCompare = function(List: TIdStringList; Index1, Index2: Integer): Integer;
  TIdBubbleSortStringList = class(TIdStringList)
  public
    procedure BubbleSort(ACompare: TIdStringListSortCompare); virtual;
  end;

implementation

{ TIdObjectList }

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

procedure TIdObjectList.BubbleSort(ACompare: TIdSortCompare);
var i, j : Integer;
begin
  for I := Count -1 downto 0 do begin
    for J := 0 to Count - 1 - 1 do begin
      if ACompare(Items[J] , Items[J + 1])< 0 then begin
        Exchange(J, J + 1);
      end;
    end;
  end;
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

procedure TIdObjectList.Assign(Source: TIdObjectList);
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

//procedure TIdObjectList.Notify(AItemPtr: Pointer; AAction: TListNotification);
//begin
////  if (OwnsObjects and (AAction = lnDeleted)) then
////    TObject(AItemPtr).Free;
//
//  inherited Notify(AItemPtr, AAction);
//end;

function TIdObjectList.Remove(AObject: TObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TIdObjectList.SetItem(AIndex: Integer; AObject: TObject);
begin
  inherited Items[AIndex] := AObject;
end;

{ TIdBubbleSortStringList }

procedure TIdBubbleSortStringList.BubbleSort(ACompare: TIdStringListSortCompare);
var
  i, j: Integer;
  LTemp: String;
  LTmpObj: TObject;
begin
  for i := Count - 1 downto 0 do begin
    for j := 0 to Count - 1 - 1 do begin
      if ACompare(Self, J, J + 1) < 0 then begin
        LTemp := Strings[j];
        LTmpObj := Objects[j];

        Strings[j] := Strings[j + 1];
        Objects[j] := Objects[j + 1];
        Strings[j + 1] := LTemp;
        Objects[j + 1] := LTmpObj;
      end;
    end;
  end;
end;

end.
