{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12014: IdThreadSafe.pas 
{
{   Rev 1.10    2004.10.29 8:49:00 PM  czhower
{ Fixed a constructor.
}
{
{   Rev 1.9    2004.10.27 9:20:04 AM  czhower
{ For TIdStrings
}
{
{   Rev 1.8    10/26/2004 8:43:02 PM  JPMugaas
{ Should be more portable with new references to TIdStrings and TIdStringList.
}
{
{   Rev 1.7    4/12/2004 4:50:36 PM  JPMugaas
{ TIdThreadSafeInt64 created for some internal work but I figured it would help
{ with other stuff.
}
{
{   Rev 1.6    3/26/2004 1:09:28 PM  JPMugaas
{ New ThreadSafe objects that I needed for some other work I'm doing.
}
{
{   Rev 1.5    3/17/2004 8:57:32 PM  JPMugaas
{ Increment and decrement overloads added for quick math in the
{ TIdThreadSafeCardinal and TIdThreadSafeInteger.  I need this for personal
{ work.
}
{
{   Rev 1.4    2004.02.25 8:23:20 AM  czhower
{ Small changes
}
{
{   Rev 1.3    2004.02.03 4:17:00 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.2    2004.01.22 5:59:12 PM  czhower
{ IdCriticalSection
}
{
    Rev 1.1    3/27/2003 12:29:46 AM  BGooijen
  Added TIdThreadSafeList.Assign
}
{
{   Rev 1.0    11/13/2002 09:01:54 AM  JPMugaas
}
unit IdThreadSafe;

interface

uses
  IdGlobal,
  IdSys,
  IdObjs;

type
  TIdThreadSafe = class
  protected
    FCriticalSection: TIdCriticalSection;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

  // Yes we know that integer operations are "atomic". However we do not like to rely on
  // internal compiler implementation. This is a safe and proper way to keep our code independent
  TIdThreadSafeInteger = class(TIdThreadSafe)
  protected
    FValue: Integer;
    //
    function GetValue: Integer;
    procedure SetValue(const AValue: Integer);
  public
    function Decrement: Integer;  overload;
    function Decrement(const AValue : Integer) : Integer; overload;
    function Increment: Integer;   overload;
    function Increment(const AValue : Integer) : Integer; overload;
    //
    property Value: Integer read GetValue write SetValue;
  end;

  TIdThreadSafeBoolean = class(TIdThreadSafe)
  protected
    FValue: Boolean;
    //
    function GetValue: Boolean;
    procedure SetValue(const AValue: Boolean);
  public
    function Toggle: Boolean;
    //
    property Value: Boolean read GetValue write SetValue;
  end;

  TIdThreadSafeCardinal = class(TIdThreadSafe)
  protected
    FValue: Cardinal;
    //
    function GetValue: Cardinal;
    procedure SetValue(const AValue: Cardinal);
  public
    function Decrement: Cardinal; overload;
    function Decrement(const AValue : Cardinal) : Cardinal; overload;
    function Increment: Cardinal; overload;
    function Increment(const AValue : Cardinal) : Cardinal; overload;
    //
    property Value: Cardinal read GetValue write SetValue;
  end;

  TIdThreadSafeInt64 = class(TIdThreadSafe)
  protected
    FValue:  Int64;
    //
    function GetValue: Int64;
    procedure SetValue(const AValue: Int64);
  public
    function Decrement: Int64; overload;
    function Decrement(const AValue : Int64) : Int64; overload;
    function Increment: Int64; overload;
    function Increment(const AValue : Int64) : Int64; overload;
    //
    property Value:  Int64 read GetValue write SetValue;
  end;

  TIdThreadSafeString = class(TIdThreadSafe)
  protected
    FValue: string;
    //
    function GetValue: string;
    procedure SetValue(const AValue: string);
  public
    procedure Append(const AValue: string);
    procedure Prepend(const AValue: string);
    //
    property Value: string read GetValue write SetValue;
  end;

  TIdThreadSafeStringList = class(TIdThreadSafe)
  protected
    FValue: TIdStringList;
    //
    function GetValue(const AName: string): string;
    procedure SetValue(const AName, AValue: string);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Add(const AItem: string);
    procedure AddObject(const AItem: string; AObject: TObject);
    procedure Clear;
    function Empty: Boolean;
    function Lock: TIdStringList; reintroduce;
    function ObjectByItem(const AItem: string): TObject;
    procedure Remove(const AItem: string);
    procedure Unlock; reintroduce;
    property Values[const AName: string]: string read GetValue write SetValue;
  end;

  TIdThreadSafeDateTime = class(TIdThreadSafe)
  protected
    FValue : TIdDateTime;
    function GetValue: TIdDateTime;
    procedure SetValue(const AValue: TIdDateTime);
  public
    procedure Add(const AValue : TIdDateTime);
    procedure Subtract(const AValue : TIdDateTime);
    property Value: TIdDateTime read GetValue write SetValue;
  end;

  //In D7, a double is the same as a TDateTime.  In DotNET, it is not.
  TIdThreadSafeDouble = class(TIdThreadSafe)
  protected
    FValue : Double;
    function GetValue: Double;
    procedure SetValue(const AValue: Double);
  public
    procedure Add(const AValue : Double);
    procedure Subtract(const AValue : Double);
    property Value: Double read GetValue write SetValue;
  end;
  //TODO: Later make this descend from TIdThreadSafe instead
  TIdThreadSafeList = class(TIdThreadList)
  public
    procedure Assign(AThreadList: TIdThreadList);overload;
    procedure Assign(AList: TIdList);overload;
    // Here to make it virtual
    constructor Create; virtual;
    function IsCountLessThan(const AValue: Cardinal): Boolean;
    function IsEmpty: Boolean;
    function Pop: TIdBaseObject;
    function Pull: TIdBaseObject;
  End;

implementation

{ TIdThreadSafe }

constructor TIdThreadSafe.Create;
begin
  inherited Create;
  FCriticalSection := TIdCriticalSection.Create;
end;

destructor TIdThreadSafe.Destroy;
begin
  Sys.FreeAndNil(FCriticalSection);
  inherited Destroy;
end;

procedure TIdThreadSafe.Lock;
begin
  FCriticalSection.Enter;
end;

procedure TIdThreadSafe.Unlock;
begin
  FCriticalSection.Leave;
end;

{ TIdThreadSafeInteger }

function TIdThreadSafeInteger.Decrement: Integer;
begin
  Lock; try
    Result := FValue;
    Dec(FValue);
  finally Unlock; end;
end;

function TIdThreadSafeInteger.Decrement(const AValue: Integer): Integer;
begin
  Lock; try
    Result := FValue;
    Dec(FValue,AValue);
  finally Unlock; end;
end;

function TIdThreadSafeInteger.GetValue: Integer;
begin
  Lock; try
    Result := FValue;
  finally Unlock; end;
end;

function TIdThreadSafeInteger.Increment: Integer;
begin
  Lock; try
    Result := FValue;
    Inc(FValue);
  finally Unlock; end;
end;

function TIdThreadSafeInteger.Increment(const AValue: Integer): Integer;
begin
  Lock; try
    Result := FValue;
    Inc(FValue,AValue);
  finally Unlock; end;
end;

procedure TIdThreadSafeInteger.SetValue(const AValue: Integer);
begin
  Lock; try
    FValue := AValue;
  finally Unlock; end;
end;

{ TIdThreadSafeString }

procedure TIdThreadSafeString.Append(const AValue: string);
begin
  Lock; try
    FValue := FValue + AValue;
  finally Unlock; end;
end;

function TIdThreadSafeString.GetValue: string;
begin
  Lock; try
    Result := FValue;
  finally Unlock; end;
end;

procedure TIdThreadSafeString.Prepend(const AValue: string);
begin
  Lock; try
    FValue := AValue + FValue;
  finally Unlock; end;
end;

procedure TIdThreadSafeString.SetValue(const AValue: string);
begin
  Lock; try
    FValue := AValue;
  finally Unlock; end;
end;

{ TIdThreadSafeStringList }

procedure TIdThreadSafeStringList.Add(const AItem: string);
begin
  with Lock do try
    Add(AItem);
  finally Unlock; end;
end;

procedure TIdThreadSafeStringList.AddObject(const AItem: string; AObject: TObject);
begin
  with Lock do try
    AddObject(AItem, AObject);
  finally Unlock; end;
end;

procedure TIdThreadSafeStringList.Clear;
begin
  with Lock do try
    Clear;
  finally Unlock; end;
end;

constructor TIdThreadSafeStringList.Create;
begin
  inherited Create;
  FValue := TIdStringList.Create;
end;

destructor TIdThreadSafeStringList.Destroy;
begin
  inherited Lock; try
    Sys.FreeAndNil(FValue);
  finally inherited Unlock; end;
  inherited Destroy;
end;

function TIdThreadSafeStringList.Empty: Boolean;
begin
  with Lock do try
    Result := Count = 0;
  finally Unlock; end;
end;

function TIdThreadSafeStringList.GetValue(const AName: string): string;
begin
  with Lock do try
    Result := Values[AName];
  finally Unlock; end;
end;

function TIdThreadSafeStringList.Lock: TIdStringList;
begin
  inherited Lock;
  Result := FValue;
end;

function TIdThreadSafeStringList.ObjectByItem(const AItem: string): TObject;
var
  i: Integer;
begin
  Result := nil;
  with Lock do try
    i := IndexOf(AItem);
    if i > -1 then begin
      Result := Objects[i];
    end;
  finally Unlock; end;
end;

procedure TIdThreadSafeStringList.Remove(const AItem: string);
var
  i: Integer;
begin
  with Lock do try
    i := IndexOf(AItem);
    if i > -1 then begin
      Delete(i);
    end;
  finally Unlock; end;
end;

procedure TIdThreadSafeStringList.SetValue(const AName, AValue: string);
begin
  with Lock do try
    Values[AName] := AValue;
  finally Unlock; end;
end;

procedure TIdThreadSafeStringList.Unlock;
begin
  inherited Unlock;
end;

{ TIdThreadSafeCardinal }

function TIdThreadSafeCardinal.Decrement: Cardinal;
begin
  Lock; try
    Result := FValue;
    Dec(FValue);
  finally Unlock; end;
end;

function TIdThreadSafeCardinal.Decrement(const AValue: Cardinal): Cardinal;
begin
  Lock; try
    Result := FValue;
    Dec(FValue,AValue);
  finally Unlock; end;
end;

function TIdThreadSafeCardinal.GetValue: Cardinal;
begin
  Lock; try
    Result := FValue;
  finally Unlock; end;
end;

function TIdThreadSafeCardinal.Increment: Cardinal;
begin
  Lock; try
    Result := FValue;
    Inc(FValue);
  finally Unlock; end;
end;

function TIdThreadSafeCardinal.Increment(const AValue: Cardinal): Cardinal;
begin
  Lock; try
    Result := FValue;
    Inc(FValue,AValue);
  finally Unlock; end;
end;

procedure TIdThreadSafeCardinal.SetValue(const AValue: Cardinal);
begin
  Lock; try
    FValue := AValue;
  finally Unlock; end;
end;

{ TIdThreadSafeList }

function TIdThreadSafeList.IsCountLessThan(const AValue: Cardinal): Boolean;
begin
  if Assigned(Self) then begin
    try
      Result := Cardinal(LockList.Count) < AValue;
    finally
      UnlockList;
    end;
  end else begin
    Result := True; // none always <
  end;
end;

function TIdThreadSafeList.IsEmpty: Boolean;
begin
  Result := IsCountLessThan(1);
end;

function TIdThreadSafeList.Pop: TObject;
begin
  with LockList do try
    if Count > 0 then begin
      Result := Items[Count - 1];
      Delete(Count - 1);
    end else begin
      Result := nil;
    end;
  finally UnlockList; end;
end;

function TIdThreadSafeList.Pull: TObject;
begin
  with LockList do try
    if Count > 0 then begin
      Result := Items[0];
      Delete(0);
    end else begin
      Result := nil;
    end;
  finally UnlockList; end;
end;

procedure TIdThreadSafeList.Assign(AList: TIdList);
var
  i: integer;
begin
  with LockList do try
    Clear;
    Capacity := AList.Capacity;
    for i := 0 to AList.Count - 1 do begin
      Add(AList.Items[i]);
    end;
  finally UnlockList; end;
end;

procedure TIdThreadSafeList.Assign(AThreadList: TIdThreadList);
var
  LList:TIdList;
begin
  LList := AThreadList.LockList; try
    Assign(LList);
  finally AThreadList.UnlockList; end;
end;

constructor TIdThreadSafeList.Create;
begin
  inherited Create;
end;

{ TIdThreadSafeBoolean }

function TIdThreadSafeBoolean.GetValue: Boolean;
begin
  Lock; try
    Result := FValue;
  finally Unlock; end;
end;

procedure TIdThreadSafeBoolean.SetValue(const AValue: Boolean);
begin
  Lock; try
    FValue := AValue;
  finally Unlock; end;
end;

function TIdThreadSafeBoolean.Toggle: Boolean;
begin
  Lock; try
    FValue := not FValue;
    Result := FValue;
  finally Unlock; end;
end;

{ TIdThreadSafeDateTime }

procedure TIdThreadSafeDateTime.Add(const AValue: TIdDateTime);
begin
  Lock;
  try
    FValue := FValue + AValue;
  finally
    Unlock;
  end;
end;

function TIdThreadSafeDateTime.GetValue: TIdDateTime;
begin
  Lock;
  try
    Result := FValue;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeDateTime.SetValue(const AValue: TIdDateTime);
begin
  Lock;
  try
    FValue := AValue;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeDateTime.Subtract(const AValue: TIdDateTime);
begin
  Lock;
  try
    FValue := FValue - AValue;
  finally
    Unlock;
  end;
end;

{ TIdThreadSafeDouble }

procedure TIdThreadSafeDouble.Add(const AValue: Double);
begin
  Lock;
  try
    FValue := FValue + AValue;
  finally
    Unlock;
  end;
end;

function TIdThreadSafeDouble.GetValue: Double;
begin
  Lock;
  try
    Result := FValue;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeDouble.SetValue(const AValue: Double);
begin
  Lock;
  try
    FValue := AValue;
  finally
    Unlock;
  end;
end;

procedure TIdThreadSafeDouble.Subtract(const AValue: Double);
begin
  Lock;
  try
    FValue := FValue - AValue;
  finally
    Unlock;
  end;
end;

{ TIdThreadSafeInt64 }

function TIdThreadSafeInt64.Decrement(const AValue: Int64): Int64;
begin
  Lock; try
    Result := FValue;
    Dec(FValue,AValue);
  finally Unlock; end;
end;

function TIdThreadSafeInt64.Decrement: Int64;
begin
  Lock; try
    Result := FValue;
    Dec(FValue);
  finally Unlock; end;
end;

function TIdThreadSafeInt64.GetValue: Int64;
begin
  Lock; try
    Result := FValue;
  finally Unlock; end;
end;

function TIdThreadSafeInt64.Increment(const AValue: Int64): Int64;
begin
  Lock; try
    Result := FValue;
    Inc(FValue,AValue);
  finally Unlock; end;
end;

function TIdThreadSafeInt64.Increment: Int64;
begin
  Lock; try
    Result := FValue;
    Inc(FValue);
  finally Unlock; end;
end;

procedure TIdThreadSafeInt64.SetValue(const AValue: Int64);
begin
  Lock;
  try
    FValue := AValue;
  finally
    Unlock;
  end;
end;

end.
