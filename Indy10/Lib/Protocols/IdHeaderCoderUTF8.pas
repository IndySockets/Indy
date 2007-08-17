unit IdHeaderCoderUTF8;

interface

{$i IdCompilerDefines.inc}

{
RLebeau: this unit will not be directly used or referenced anywhere in
Indy or application code.  However, because of that, C++Builder will end
up optimizing out this entire unit when statically linking Indy into a
C++ project, and thus the initialization section below will not be called!
To get around that, a dummy registrar is being used to force C++ to access
this unit at program startup and shutdown.

HPPEMITs are always output at the top of the .hpp file, and procedures at the
bottom.  But to make the registrar work, the reverse is needed, so let the
HPPEMITs declare the functions instead of letting Delphi do it automatically.
}

(*$HPPEMIT 'namespace Idheadercoderutf8'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall RegisterHeaderCoderUTF8();'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall UnregisterHeaderCoderUTF8();'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    class TIdHeaderCoderUTF8Registrar'*)
(*$HPPEMIT '    {'*)
(*$HPPEMIT '    public:'*)
(*$HPPEMIT '        TIdHeaderCoderUTF8Registrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            RegisterHeaderCoderUTF8();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '        ~TIdHeaderCoderUTF8Registrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            UnregisterHeaderCoderUTF8();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT '    };'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    TIdHeaderCoderUTF8Registrar HeaderCoderUTF8Registrar;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT ''*)

{$NODEFINE RegisterHeaderCoderUTF8}
procedure RegisterHeaderCoderUTF8;
{$NODEFINE UnregisterHeaderCoderUTF8}
procedure UnregisterHeaderCoderUTF8;

implementation

uses
  {$IFDEF DOTNET}System.Text,{$ENDIF}
  IdGlobal, IdCoderHeader;

type
  TIdHeaderCoderUTF8 = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

class function TIdHeaderCoderUTF8.Decode(const ACharSet, AData: String): String;
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
    Temp[LLength+1] := WideChar(LWC);
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

class function TIdHeaderCoderUTF8.Encode(const ACharSet, AData: String): String;
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

  LCount := IndyMin(Length(AData), MaxInt div 3);
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
      Temp[LLength+1] := AnsiChar(LWC);
      Inc(LLength);
    end
    else if LWC <= $07FF then begin
      Temp[LLength+1] := AnsiChar($00C0 or (LWC shr 6));
      Temp[LLength+2] := AnsiChar($0080 or (LWC and $003F));
      Inc(LLength, 2);
    end else // (LWC >= $8000)
    begin
      Temp[LLength+1] := AnsiChar($00E0 or (LWC shr 12));
      Temp[LLength+2] := AnsiChar($0080 or ((LWC shr 6) and $003F));
      Temp[LLength+3] := AnsiChar($0080 or (LWC and $003F));
      Inc(LLength, 3);
    end;
  end;

  if LLength < LMax then begin
    SetLength(Temp, LLength);
  end;

  Result := Temp;
  {$ENDIF}
end;

class function TIdHeaderCoderUTF8.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'UTF-8'); {do not localize}
end;

procedure RegisterHeaderCoderUTF8;
begin
  RegisterHeaderCoder(TIdHeaderCoderUTF8);
end;

procedure UnregisterHeaderCoderUTF8;
begin
  UnregisterHeaderCoder(TIdHeaderCoderUTF8);
end;

initialization
  RegisterHeaderCoderUTF8;
finalization
  UnregisterHeaderCoderUTF8;

end.
