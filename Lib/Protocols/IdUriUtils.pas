unit IdUriUtils;

interface

{$i IdCompilerDefines.inc}

{$IFDEF DOTNET}
  {$DEFINE HAS_ConvertToUtf32}
{$ENDIF}
{$IFDEF HAS_TCharacter}
  {$DEFINE HAS_ConvertToUtf32}
{$ENDIF}
{$IFDEF HAS_Character_TCharHelper}
  {$DEFINE HAS_ConvertToUtf32}
{$ENDIF}

{$IFDEF DOTNET}
  {$DEFINE HAS_String_IndexOf}
{$ENDIF}
{$IFDEF HAS_SysUtils_TStringHelper}
  {$DEFINE HAS_String_IndexOf}
{$ENDIF}

uses
  IdGlobal
  {$IFNDEF DOTNET}
    {$IFDEF HAS_ConvertToUtf32}
  , Character
    {$ELSE}
  , IdException
    {$ENDIF}
    {$IFDEF HAS_String_IndexOf}
  , SysUtils
    {$ENDIF}
  {$ENDIF}
  ;

{$IFNDEF HAS_ConvertToUtf32}
type
  //for .NET, we use Char.ConvertToUtf32() as-is
  //for XE3.5+, we use TCharHelper.ConvertToUtf32() as-is
  //for D2009+, we use TCharacter.ConvertToUtf32() as-is
  EIdUTF16Exception = class(EIdException);
  EIdUTF16IndexOutOfRange = class(EIdUTF16Exception);
  EIdUTF16InvalidHighSurrogate = class(EIdUTF16Exception);
  EIdUTF16InvalidLowSurrogate = class(EIdUTF16Exception);
  EIdUTF16MissingLowSurrogate = class(EIdUTF16Exception);
{$ENDIF}

// calculates character length, including surrogates
function CalcUTF16CharLength(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF}; const AIndex: Integer): Integer;
function WideCharIsInSet(const ASet: TIdUnicodeString; const AChar: WideChar): Boolean;
function GetUTF16Codepoint(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF}; const AIndex: Integer): Integer;

implementation

{$IFNDEF HAS_ConvertToUtf32}
uses
  IdResourceStringsProtocols,
  IdResourceStringsUriUtils;
{$ENDIF}

function CalcUTF16CharLength(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF};
  const AIndex: Integer): Integer;
{$IFDEF DOTNET}
var
  C: Integer;
{$ELSE}
  {$IFDEF HAS_ConvertToUtf32}
    {$IFDEF USE_INLINE}inline;{$ENDIF}
  {$ELSE}
var
  C: WideChar;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF DOTNET}
  C := System.Char.ConvertToUtf32(AStr, AIndex-1);
  if (C >= #$10000) and (C <= #$10FFFF) then begin
    Result := 2;
  end else begin
    Result := 1;
  end;
  {$ELSE}
    {$IFDEF HAS_Character_TCharHelper}
  Char.ConvertToUtf32(AStr, AIndex-1, Result);
    {$ELSE}
      {$IFDEF HAS_TCharacter}
  TCharacter.ConvertToUtf32(AStr, AIndex, Result);
      {$ELSE}
  // TODO: use GetUTF16Codepoint() here...
  {
  C := GetUTF16Codepoint(AStr, AIndex);
  if (C >= #$10000) and (C <= #$10FFFF) then begin
    Result := 2;
  end else begin
    Result := 1;
  end;
  }
  if (AIndex < {$IFDEF STRING_IS_UNICODE}1{$ELSE}0{$ENDIF}) or
     (AIndex > (Length(AStr){$IFNDEF STRING_IS_UNICODE}-1{$ENDIF})) then
  begin
    raise EIdUTF16IndexOutOfRange.CreateResFmt(@RSUTF16IndexOutOfRange, [AIndex, Length(AStr)]);
  end;
  C := AStr[AIndex];
  if (C >= #$D800) and (C <= #$DFFF) then
  begin
    if C > #$DBFF then begin
      raise EIdUTF16InvalidHighSurrogate.CreateResFmt(@RSUTF16InvalidHighSurrogate, [AIndex]);
    end;
    if AIndex = (Length(AStr){$IFNDEF STRING_IS_UNICODE}-1{$ENDIF}) then begin
      raise EIdUTF16MissingLowSurrogate.CreateRes(@RSUTF16MissingLowSurrogate);
    end;
    C := AStr[AIndex+1];
    if (C < #$DC00) or (C > #$DFFF) then begin
      raise EIdUTF16InvalidLowSurrogate.CreateResFmt(@RSUTF16InvalidLowSurrogate, [AIndex+1]);
    end;
    Result := 2;
  end else begin
    Result := 1;
  end;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function WideCharIsInSet(const ASet: TIdUnicodeString; const AChar: WideChar): Boolean;
{$IFDEF HAS_String_IndexOf}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF HAS_String_IndexOf}
  Result := ASet.IndexOf(AChar) > -1;
  {$ELSE}
  // RLebeau 5/8/08: Calling Pos() with a Char as input creates a temporary
  // String.  Normally this is fine, but profiling reveils this to be a big
  // bottleneck for code that makes a lot of calls to CharIsInSet(), so we
  // will scan through ASet looking for the character without a conversion...
  //
  // Result := IndyPos(AString[ACharPos], ASet);
  //
  Result := False;
  for I := 1 to Length(ASet) do begin
    if ASet[I] = AChar then begin
      Result := True;
      Exit;
    end;
  end;
  {$ENDIF}
end;

function GetUTF16Codepoint(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF};
  const AIndex: Integer): Integer;
{$IFDEF HAS_ConvertToUtf32}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  C: WideChar;
  LowSurrogate, HighSurrogate: Integer;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := System.Char.ConvertToUtf32(AStr, AIndex-1);
  {$ELSE}
    {$IFDEF HAS_Character_TCharHelper}
  Result := Char.ConvertToUtf32(AStr, AIndex-1);
    {$ELSE}
      {$IFDEF HAS_TCharacter}
  Result := TCharacter.ConvertToUtf32(AStr, AIndex);
      {$ELSE}
  if (AIndex < {$IFDEF STRING_IS_UNICODE}1{$ELSE}0{$ENDIF}) or
     (AIndex > (Length(AStr){$IFNDEF STRING_IS_UNICODE}-1{$ENDIF})) then
  begin
    raise EIdUTF16IndexOutOfRange.CreateResFmt(@RSUTF16IndexOutOfRange, [AIndex, Length(AStr)]);
  end;
  C := AStr[AIndex];
  if (C >= #$D800) and (C <= #$DFFF) then
  begin
    HighSurrogate := Integer(C);
    if HighSurrogate > $DBFF then begin
      raise EIdUTF16InvalidHighSurrogate.CreateResFmt(@RSUTF16InvalidHighSurrogate, [AIndex]);
    end;
    if AIndex = (Length(AStr){$IFNDEF STRING_IS_UNICODE}-1{$ENDIF}) then begin
      raise EIdUTF16MissingLowSurrogate.CreateRes(@RSUTF16MissingLowSurrogate);
    end;
    LowSurrogate := Integer(AStr[AIndex+1]);
    if (LowSurrogate < $DC00) or (LowSurrogate > $DFFF) then begin
      raise EIdUTF16InvalidLowSurrogate.CreateResFmt(@RSUTF16InvalidLowSurrogate, [AIndex+1]);
    end;
    Result := ((HighSurrogate - $D800) shl 10) or (LowSurrogate - $DC00) + $10000;
  end else begin
    Result := Integer(C);
  end;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

end.
