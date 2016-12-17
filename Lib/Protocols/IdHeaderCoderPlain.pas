unit IdHeaderCoderPlain;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoderPlain = class(TIdHeaderCoder)
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
    {$HPPEMIT '#pragma link "IdHeaderCoderPlain"'}
  {$ENDIF}

implementation

uses
  SysUtils;

class function TIdHeaderCoderPlain.Decode(const ACharSet: string; const AData: TIdBytes): String;
begin
  Result := BytesToStringRaw(AData);
end;

class function TIdHeaderCoderPlain.Encode(const ACharSet, AData: String): TIdBytes;
begin
  Result := ToBytes(AData, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF});
end;

class function TIdHeaderCoderPlain.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextStartsWith(ACharSet, 'ISO'); {do not localize}
  if Result then begin
    // 'ISO-2022-JP' is handled by TIdHeaderCoder2022JP
    Result := not TextIsSame(ACharSet, 'ISO-2022-JP'); {do not localize}
    Exit;
  end;
  if not Result then begin
    Result := TextStartsWith(ACharSet, 'WINDOWS'); {do not localize}
    if not Result then begin
      Result := TextStartsWith(ACharSet, 'KOI8'); {do not localize}
      if not Result then begin
        Result := TextStartsWith(ACharSet, 'GB2312'); {do not localize}
        if not Result then begin
          Result := TextIsSame(ACharSet, 'US-ASCII');
        end;
      end;
    end;
  end;
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderPlain);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderPlain);

end.
