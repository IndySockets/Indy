unit IdUriUtils;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal
  {$IFNDEF DOTNET}
    {$IFNDEF HAS_TCharacter}
  , IdException
    {$ENDIF}
  {$ENDIF}
  ;

{$IFNDEF DOTNET}
  {$IFNDEF HAS_TCharacter}
type
  //for D2009+, we use TCharacter.ConvertToUtf32() as-is
  EIdUTF16Exception = class(EIdException);
  EIdUTF16IndexOutOfRange = class(EIdUTF16Exception);
  EIdUTF16InvalidHighSurrogate = class(EIdUTF16Exception);
  EIdUTF16InvalidLowSurrogate = class(EIdUTF16Exception);
  EIdUTF16MissingLowSurrogate = class(EIdUTF16Exception);
  {$ENDIF}
{$ENDIF}

// calculates character length, including surrogates
function CalcUTF16CharLength(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF}; const AIndex: Integer): Integer;
function WideCharIsInSet(const ASet: TIdUnicodeString; const AChar: WideChar): Boolean;

implementation

{$IFNDEF DOTNET}
uses
  {$IFDEF HAS_TCharacter}
  Character
  {$ELSE}
  IdResourceStringsProtocols
  {$ENDIF}
  ;
{$ENDIF}

function CalcUTF16CharLength(const AStr: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF};
  const AIndex: Integer): Integer;
{$IFDEF DOTNET}
var
  C: Integer;
{$ELSE}
  {$IFDEF HAS_TCharacter}
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
    {$IFDEF HAS_TCharacter}

  //for D2009+, we use TCharacter.ConvertToUtf32() as-is
  TCharacter.ConvertToUtf32(AStr, AIndex, Result);

    {$ELSE}

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
end;

function WideCharIsInSet(const ASet: TIdUnicodeString; const AChar: WideChar): Boolean;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  I: Integer;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := ASet.IndexOf(AChar) > -1;
  {$ELSE}
  // RLebeau 5/8/08: Calling Pos() with a Char as input creates a temporary
  // String.  Normally this is fine, but profiling reveils this to be a big
  // bottleneck for code that makes a lot of calls to CharIsInSet(), so need
  // to scan through ASet looking for the character without a conversion...
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

end.
