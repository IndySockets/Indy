unit IdHeaderCoderUTF8;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoderUTF8 = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

implementation

{$IFDEF DOTNET}
uses
  System.Text;
{$ENDIF}

class function TIdHeaderCoderUTF8.Decode(const ACharSet, AData: String): String;
  {$IFDEF DOTNET}
var
  LBytes: TIdBytes;
  {$ELSE}
  {$IFNDEF VCL6ORABOVE}
var
  I, LCount, LLength: Integer;
  LCh: Byte;
  LWC: LongWord;
  LResult: WideString;
  {$ENDIF}
  {$ENDIF}
begin
  Result := '';
  if AData = '' then begin
    Exit;
  end;

  {$IFDEF DOTNET}

  try
    LBytes := System.Text.Encoding.Convert(
      System.Text.Encoding.UTF8,
      System.Text.Encoding.Unicode,
      System.Text.Encoding.UTF8.GetBytes(AData));
    Result := System.Text.Encoding.Unicode.GetString(LBytes, 0, Length(LBytes));
  except
  end;

  {$ELSE}
  {$IFDEF VCL6ORABOVE}

  Result := System.UTF8Decode(AData);

  {$ELSE}

  LCount := Length(AData);
  SetLength(LResult, LCount);

  I := 1;
  LLength := 0;

  while I <= LCount do begin
    LWC := LongWord(AData[I]);
    Inc(I);
    if (LWC and $80) <> 0 then begin
      if I > LCount then begin
        Exit;
      end;
      LWC := LWC and $3F;
      if (LWC and $20) <> 0 then begin
        LCh := Byte(AData[I]);
        Inc(I);
        if ((LCh and $C0) <> $80) or (I > LCount) then begin
          Exit;
        end;
        LWC := ((LWC and $0F) shl 6) or LongWord(LCh and $3F);
      end;
      LCh := Byte(AData[I]);
      Inc(I);
      if (LCh and $C0) <> $80 then begin
        Exit;
      end;
      LWC := (LWC shl 6) or LongWord(LCh and $3F);
    end;
    LResult[LLength+1] := WideChar(LWC);
    Inc(LLength);
  end;

  if LLength > 0 then begin
    if LLength < LCount then begin
      SetLength(LResult, LLength);
    end;
    Result := LResult;
  end;

  {$ENDIF}
  {$ENDIF}
end;

class function TIdHeaderCoderUTF8.Encode(const ACharSet, AData: String): String;
  {$IFDEF DOTNET}
var
  LBytes: TIdBytes;
  {$ELSE}
  {$IFNDEF VCL6ORABOVE}
var
  I, LCount, LLength, LMax: Integer;
  LWC: LongWord;
  LResult: AnsiString;
  LTemp: WideString;
  {$ENDIF}
  {$ENDIF}
begin
  Result := '';
  if AData = '' then begin
    Exit;
  end;

  {$IFDEF DOTNET}

  try
    LBytes := System.Text.Encoding.Convert(
      System.Text.Encoding.Unicode,
      System.Text.Encoding.UTF8,
      System.Text.Encoding.Unicode.GetBytes(AData));
    Result := System.Text.Encoding.UTF8.GetString(LBytes, 0, Length(LBytes));
  except
  end;

  {$ELSE}
  {$IFDEF VCL6ORABOVE}

  Result := System.UTF8Encode(AData);

  {$ELSE}

  // RLebeau: need to convert to actual Unicode first.
  // This way, MBCS characters are encoded properly.
  LTemp := AData;

  LCount := IndyMin(Length(LTemp), MaxInt div 3);
  LMax := LCount * 3;
  SetLength(LResult, LMax);

  I := 1;
  LLength := 0;

  while I <= LCount do
  begin
    LWC := LongWord(LTemp[I]);
    Inc(I);

    if LWC <= $7F then
    begin
      LResult[LLength+1] := AnsiChar(LWC);
      Inc(LLength);
    end
    else if LWC <= $7FF then begin
      LResult[LLength+1] := AnsiChar($C0 or (LWC shr 6));
      LResult[LLength+2] := AnsiChar($80 or (LWC and $3F));
      Inc(LLength, 2);
    end else // (LWC >= $8000)
    begin
      LResult[LLength+1] := AnsiChar($E0 or (LWC shr 12));
      LResult[LLength+2] := AnsiChar($80 or ((LWC shr 6) and $3F));
      LResult[LLength+3] := AnsiChar($80 or (LWC and $3F));
      Inc(LLength, 3);
    end;
  end;

  if LLength < LMax then begin
    SetLength(LResult, LLength);
  end;

  Result := LResult;

  {$ENDIF}
  {$ENDIF}
end;

class function TIdHeaderCoderUTF8.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'UTF-8'); {do not localize}
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderUTF8);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderUTF8);

end.
