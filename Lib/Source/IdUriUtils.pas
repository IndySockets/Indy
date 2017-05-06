unit IdUriUtils;

interface

{$i IdCompilerDefines.inc}

{$IF DEFINED(HAS_TCharacter) OR DEFINED(HAS_Character_TCharHelper)}
  {$DEFINE HAS_ConvertToUtf32}
{$IFEND}

{$IFDEF HAS_SysUtils_TStringHelper}
  {$DEFINE HAS_String_IndexOf}
{$ENDIF}

uses
  IdGlobal
  {$IFDEF HAS_ConvertToUtf32}
  , Character
  {$ELSE}
  , IdException
  {$ENDIF}
  {$IFDEF HAS_String_IndexOf}
  , SysUtils
  {$ENDIF}
  ;

{$IFNDEF HAS_ConvertToUtf32}
type
  //for XE3.5+, we use TCharHelper.ConvertToUtf32() as-is
  //for D2009+, we use TCharacter.ConvertToUtf32() as-is
  EIdUTF16Exception = class(EIdException);
  EIdUTF16IndexOutOfRange = class(EIdUTF16Exception);
  EIdUTF16InvalidHighSurrogate = class(EIdUTF16Exception);
  EIdUTF16InvalidLowSurrogate = class(EIdUTF16Exception);
  EIdUTF16MissingLowSurrogate = class(EIdUTF16Exception);
{$ENDIF}

// calculates character length, including surrogates
function CalcUTF16CharLength(const AStr: UnicodeString; const AIndex: Integer): Integer;
function WideCharIsInSet(const ASet: UnicodeString; const AChar: WideChar): Boolean;
function GetUTF16Codepoint(const AStr: UnicodeString; const AIndex: Integer): Integer;

implementation

{$IFNDEF HAS_ConvertToUtf32}
uses
  IdResourceStringsProtocols,
  IdResourceStringsUriUtils;
{$ENDIF}

function CalcUTF16CharLength(const AStr: UnicodeString; const AIndex: Integer): Integer;
{$IFDEF HAS_ConvertToUtf32}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  C: WideChar;
{$ENDIF}
begin
  {$IF DEFINED(HAS_Character_TCharHelper)}
  Char.ConvertToUtf32(AStr, AIndex-1, Result);
  {$ELSEIF DEFINED(HAS_TCharacter)}
  TCharacter.ConvertToUtf32(AStr, AIndex, Result);
  {$ELSE}
  if (AIndex < 1) or (AIndex > Length(AStr)) then
  begin
    raise EIdUTF16IndexOutOfRange.CreateResFmt(@RSUTF16IndexOutOfRange, [AIndex, Length(AStr)]);
  end;
  C := AStr[AIndex];
  if (C >= #$D800) and (C <= #$DFFF) then
  begin
    if C > #$DBFF then begin
      raise EIdUTF16InvalidHighSurrogate.CreateResFmt(@RSUTF16InvalidHighSurrogate, [AIndex]);
    end;
    if AIndex = Length(AStr) then begin
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
  {$IFEND}
end;

function WideCharIsInSet(const ASet: UnicodeString; const AChar: WideChar): Boolean;
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

function GetUTF16Codepoint(const AStr: UnicodeString; const AIndex: Integer): Integer;
{$IFDEF HAS_ConvertToUtf32}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  C: WideChar;
  LowSurrogate, HighSurrogate: Integer;
{$ENDIF}
begin
  {$IF DEFINED(HAS_Character_TCharHelper)}
  Result := Char.ConvertToUtf32(AStr, AIndex-1);
  {$ELSEIF DEFINED(HAS_TCharacter)}
  Result := TCharacter.ConvertToUtf32(AStr, AIndex);
  {$ELSE}
  if (AIndex < 1) or (AIndex > Length(AStr)) then
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
    if AIndex = Length(AStr) then begin
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
  {$IFEND}
end;

end.
