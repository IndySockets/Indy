unit IdHeaderCoderUTF8;

interface

{$i IdCompilerDefines.inc}

uses
  IdCoderHeader;

type
  TIdHeaderCoderUTF8 = class(TIdHeaderCoder)
  public
    function Decode(const ACharSet, AData: String): String; override;
    function Encode(const ACharSet, AData: String): String; override;
    function CanHandle(const ACharSet: String): Boolean; override;
  end;

implementation

uses
  {$IFDEF DOTNET}System.Text,{$ENDIF}
  IdGlobal;

function TIdHeaderCoderUTF8.Decode(const ACharSet, AData: String): String;
var
  {$IFDEF DOTNET}
  LBytes: TIdBytes;
  {$ELSE}
  I, LCount, LLength: Integer;
  LCh: Byte;
  LWC: Word;
  Temp: WideString;
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

  LCount := Length(AData);
  SetLength(Temp, LCount);

  I := 1;
  LLength := 0;

  while I <= LCount do begin
    LWC := Word(AData[I]);
    Inc(I);
    if (LWC and $0080) <> 0 then begin
      if I > LCount then begin
        Exit;
      end;
      LWC := LWC and $003F;
      if (LWC and $0020) <> 0 then begin
        LCh := Byte(AData[I]);
        Inc(I);
        if ((LCh and $C0) <> $80) or (I > LCount) then begin
          Exit;
        end;
        LWC := ((LWC and $000F) shl 6) or Word(LCh and $3F);
      end;
      LCh := Byte(AData[I]);
      Inc(I);
      if (LCh and $C0) <> $80 then begin
        Exit;
      end;
      LWC := (LWC shl 6) or Word(LCh and $3F);
    end;
    Temp[LLength] := WideChar(LWC);
    Inc(LLength);
  end;

  if LLength > 0 then begin
    if LLength < LCount then begin
      SetLength(Temp, LLength);
    end;
    Result := Temp;
  end;
  {$ENDIF}
end;

function TIdHeaderCoderUTF8.Encode(const ACharSet, AData: String): String;
var
  {$IFDEF DOTNET}
  LBytes: TIdBytes;
  {$ELSE}
  I, LCount, LLength, LMax: Integer;
  LWC: Word;
  Temp: AnsiString;
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

  LCount := Length(AData);
  LMax := LCount * 3;
  SetLength(Temp, LMax);

  I := 1;
  LLength := 0;

  while I <= LCount do
  begin
    LWC := Word(AData[I]);
    Inc(I);

    if LWC <= $007F then
    begin
      Temp[LLength] := AnsiChar(LWC);
      Inc(LLength);
    end
    else if LWC <= $07FF then begin
      Temp[LLength] := AnsiChar($00C0 or (LWC shr 6));
      Temp[LLength+1] := AnsiChar($0080 or (LWC and $003F));
      Inc(LLength, 2);
    end else // (LWC >= $8000)
    begin
      Temp[LLength] := AnsiChar($00E0 or (LWC shr 12));
      Temp[LLength+1] := AnsiChar($0080 or ((LWC shr 6) and $003F));
      Temp[LLength+2] := AnsiChar($0080 or (LWC and $003F));
      Inc(LLength, 3);
    end;
  end;

  if LLength < LMax then begin
    SetLength(Temp, LLength);
  end;

  Result := Temp;
  {$ENDIF}
end;

function TIdHeaderCoderUTF8.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'UTF-8'); {do not localize}
end;

initialization
  TIdHeaderCoderList.RegisterCoder(TIdHeaderCoderUTF8.Create);

end.
