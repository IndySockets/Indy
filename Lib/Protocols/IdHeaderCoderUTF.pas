unit IdHeaderCoderUTF;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoderUTF = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet: string; const AData: TIdBytes): String; override;
    class function Encode(const ACharSet, AData: String): TIdBytes; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterHeaderCoder can be called correctly at program startup...
  (*$HPPEMIT '#pragma link "IdHeaderCoderUTF"'*)

implementation

uses
  SysUtils;

class function TIdHeaderCoderUTF.Decode(const ACharSet: string; const AData: TIdBytes): String;
var
  LEncoding: TIdTextEncoding;
  LBytes: TIdBytes;
begin
  Result := '';
  LBytes := nil;
  if TextIsSame(ACharSet, 'UTF-7') then begin {do not localize}
    LEncoding := TIdTextEncoding.UTF7;
  end
  else if TextIsSame(ACharSet, 'UTF-8') then begin {do not localize}
    LEncoding := TIdTextEncoding.UTF8;
  end else
  begin
    Exit;
  end;
  LBytes := TIdTextEncoding.Convert(
    LEncoding,
    TIdTextEncoding.Unicode,
    AData);
  Result := TIdTextEncoding.Unicode.GetString(LBytes, 0, Length(LBytes));
end;

class function TIdHeaderCoderUTF.Encode(const ACharSet, AData: String): TIdBytes;
var
  LEncoding: TIdTextEncoding;
begin
  Result := nil;
  if TextIsSame(ACharSet, 'UTF-7') then begin {do not localize}
    LEncoding := TIdTextEncoding.UTF7;
  end
  else if TextIsSame(ACharSet, 'UTF-8') then begin {do not localize}
    LEncoding := TIdTextEncoding.UTF8;
  end else
  begin
    Exit;
  end;
  Result := TIdTextEncoding.Convert(
    TIdTextEncoding.Unicode,
    LEncoding,
    TIdTextEncoding.Unicode.GetBytes(AData));
end;

class function TIdHeaderCoderUTF.CanHandle(const ACharSet: String): Boolean;
begin
  Result := PosInStrArray(ACharSet, ['UTF-7', 'UTF-8'], False) > -1; {do not localize}
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderUTF);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderUTF);

end.
