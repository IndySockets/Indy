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

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdHeaderCoderIndy"'}
  {$ENDIF}

implementation

uses
  IdGlobalProtocols;

class function TIdHeaderCoderIndy.Decode(const ACharSet: string; const AData: TIdBytes): String;
begin
  try
    Result := CharsetToEncoding(ACharSet).GetString(AData);
  except
    Result := '';
  end;
end;

class function TIdHeaderCoderIndy.Encode(const ACharSet, AData: String): TIdBytes;
begin
  try
    Result := CharsetToEncoding(ACharSet).GetBytes(AData);
  except
    Result := nil;
  end;
end;

class function TIdHeaderCoderIndy.CanHandle(const ACharSet: String): Boolean;
begin
  try
    Result := CharsetToEncoding(ACharSet) <> nil;
  except
    Result := False;
  end;
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderIndy);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderIndy);

end.
