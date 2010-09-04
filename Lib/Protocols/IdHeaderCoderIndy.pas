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

{$IFNDEF DOTNET_OR_ICONV}
uses
  IdCharsets
  {$IFDEF MSWINDOWS}
  , Windows
  {$ENDIF}
  ;
{$ENDIF}

class function TIdHeaderCoderIndy.Decode(const ACharSet: string; const AData: TIdBytes): String;
var
  LEncoding: TIdTextEncoding;
  LBytes: TIdBytes;
  {$IFNDEF DOTNET_OR_ICONV}
  CP: Word;
  {$ENDIF}
begin
  Result := '';
  LBytes := nil;
  try
    {$IFDEF DOTNET_OR_ICONV}
    LEncoding := TIdTextEncoding.GetEncoding(ACharSet);
    {$ELSE}
    CP := CharsetToCodePage(ACharSet);
    Assert(CP <> 0);
    LEncoding := TIdTextEncoding.GetEncoding(CP);
    {$ENDIF}
    {$IFNDEF DOTNET}
    try
    {$ENDIF}
      LBytes := AData;
      if LEncoding <> TIdTextEncoding.Unicode then begin
        LBytes := TIdTextEncoding.Convert(LEncoding, TIdTextEncoding.Unicode, LBytes);
      end;
      Result := TIdTextEncoding.Unicode.GetString(LBytes, 0, Length(LBytes));
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
  LBytes: TIdBytes;
  {$IFNDEF DOTNET_OR_ICONV}
  CP: Word;
  {$ENDIF}
begin
  Result := nil;
  LBytes := nil;
  try
    {$IFDEF DOTNET_OR_ICONV}
    LEncoding := TIdTextEncoding.GetEncoding(ACharSet);
    {$ELSE}
    CP := CharsetToCodePage(ACharSet);
    Assert(CP <> 0);
    LEncoding := TIdTextEncoding.GetEncoding(CP);
    {$ENDIF}
    {$IFNDEF DOTNET}
    try
    {$ENDIF}
      LBytes := TIdTextEncoding.Unicode.GetBytes(AData);
      if LEncoding <> TIdTextEncoding.Unicode then begin
        LBytes := TIdTextEncoding.Convert(TIdTextEncoding.Unicode, LEncoding, LBytes);
      end;
      Result := LBytes;
    {$IFNDEF DOTNET}
    finally
      LEncoding.Free;
    end;
    {$ENDIF}
  except
  end;
end;

class function TIdHeaderCoderIndy.CanHandle(const ACharSet: String): Boolean;
{$IFDEF DOTNET_OR_ICONV}
var
  LEncoding: TIdTextEncoding;
{$ELSE}
  {$IFDEF MSWINDOWS}
var
  CP: Word;
  LCPInfo: TCPInfo;
  {$ENDIF}
{$ENDIF}
begin
  Result := False;
  {$IFDEF DOTNET_OR_ICONV}
  try
    LEncoding := TIdTextEncoding.GetEncoding(ACharSet);
    Result := Assigned(LEncoding);
  except
  end;
  {$ELSE}
    {$IFDEF MSWINDOWS}
  CP := CharsetToCodePage(ACharSet);
  if CP <> 0 then begin
    Result := GetCPInfo(CP, LCPInfo);
  end;
    {$ENDIF}
  {$ENDIF}
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderIndy);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderIndy);

end.
