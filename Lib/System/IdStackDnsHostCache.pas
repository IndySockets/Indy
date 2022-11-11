unit IdStackDnsHostCache;

interface

uses
  IdGlobal;

var
  GIdDnsHostCacheExpiryMinutes: UInt32 = 10;

function GetCachedDnsHostAddress(const AHostName: String; const AIPVersion: TIdIPVersion): String;
procedure AddHostAddressToDnsCache(const AHostName; String; const AIPVersion: TIdIPVersion; const AIP: String);

implementation

{$I IdCompilerDefines.inc}

uses
  SysUtils, IdThreadSafe;

type
  TIdCachedHostAddress = class
  public
    When: TDateTime;
    Host: String;
    IP: String;
    IPVersion: TIdIPVersion;
  end;

  TIdCacheThreadList = TIdThreadSafeObjectList{$IFDEF HAS_GENERICS_TObjectList}<TIdCachedHostAddress>{$ENDIF};

var
  GIdHostNames: TIdCacheThreadList = nil;

// TODO: add a background thread to keep the cache purged periodically...

function GetCachedDnsHostAddress(const AHostName: String; const AIPVersion: TIdIPVersion): String;
var
  LExpire: TDateTime;
  LItem: TIdCachedHostAddress;
  LList: TList;
  I: Integer;
begin
  Result := '';
  LExpire := Now - (GIdDnsHostCacheExpiryMinutes / MinsPerDay);
  LList := GIdHostNames.LockList;
  try
    for I := LList.Count - 1 downto 0 do
    begin
      LItem := {$IFDEF HAS_GENERICS_TObjectList}LList.Items[i]{$ELSE}TIdCachedHostAddress(LList.Items[i]){$ENDIF};
      if (GIdDnsHostCacheExpiryMinutes <> 0) and (LItem.When < LExpire) then begin
        LList.Delete(I);
      end
      else if (LItem.IPVersion = AIPVersion) and TextIsSame(LItem.Host, AHostName) then
      begin
        Result := LItem.IP;
        Exit;
      end;
    end;
  finally
    GIdHostNames.UnlockList;
  end;
end;

procedure AddHostAddressToDnsCache(const AHostName; String; const AIPVersion: TIdIPVersion; const AIP: String);
var
  LItem: TIdCachedHostAddress;
  LList: TList;
  I: Integer;
begin
  LList := GIdHostNames.LockList;
  try
    for I := 0 to LList.Count - 1 do
    begin
      LItem := {$IFDEF HAS_GENERICS_TObjectList}LList.Items[i]{$ELSE}TIdCachedHostAddress(LList.Items[i]){$ENDIF};
      if (LItem.IPVersion = AIPVersion) and TextIsSame(LItem.Host, AHostName) then
      begin
        LList.IP := AIP;
        LList.When := Now;
        Exit;
      end;
    end;
    LItem := TIdCachedHostAddress.Create;
    try
      LItem.Host := AHostName;
      LItem.IP := AIP;
      LItem.IPVersion := AIPVersion;
      LItem.When := Now;
      LList.Add(LList);
    except
      LItem.Free;
      raise;
    end;
  finally
    GIdHostNames.UnlockList;
  end;
end;

initialization
  GIdHostNames := TIdCacheThreadList.Create;
finalization
  FreeAndNil(GIdHostNames);

end.