unit IdHeaderCoderIndy;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoderIndy = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet: string; const AData: TIdBytes): String; override;
    class function Encode(const ACharSet, AData: String): TIdBytes; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterHeaderCoder can be called correctly at program startup...
  (*$HPPEMIT '#pragma link "IdHeaderCoderIndy"'*)

implementation

uses
  IdGlobalProtocols;

class function TIdHeaderCoderIndy.Decode(const ACharSet: string; const AData: TIdBytes): String;
var
  LEncoding: TIdTextEncoding;
begin
  Result := '';
  try
    LEncoding := CharsetToEncoding(ACharSet);
    {$IFNDEF DOTNET}
    try
    {$ENDIF}
      Result := LEncoding.GetString(AData);
    {$IFNDEF DOTNET}
    finally
      LEncoding.Free;
    end;
    {$ENDIF}
  except
  end;
end;

class function TIdHeaderCoderIndy.Encode(const ACharSet, AData: String): TIdBytes;
var
  LEncoding: TIdTextEncoding;
begin
  Result := nil;
  try
    LEncoding := CharsetToEncoding(ACharSet);
    {$IFNDEF DOTNET}
    try
    {$ENDIF}
      Result := LEncoding.GetBytes(AData);
    {$IFNDEF DOTNET}
    finally
      LEncoding.Free;
    end;
    {$ENDIF}
  except
  end;
end;

class function TIdHeaderCoderIndy.CanHandle(const ACharSet: String): Boolean;
var
  LEncoding: TIdTextEncoding;
begin
  try
    LEncoding := CharsetToEncoding(ACharSet);
    Result := Assigned(LEncoding);
    {$IFNDEF DOTNET}
    if Result then begin
      LEncoding.Free;
    end;
    {$ENDIF}
  except
    Result := False;
  end;
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderIndy);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderIndy);

end.
