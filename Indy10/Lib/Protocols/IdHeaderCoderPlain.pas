unit IdHeaderCoderPlain;

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

(*$HPPEMIT 'namespace Idheadercoderplain'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall RegisterHeaderCoderPlain();'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall UnregisterHeaderCoderPlain();'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    class TIdHeaderCoderPlainRegistrar'*)
(*$HPPEMIT '    {'*)
(*$HPPEMIT '    public:'*)
(*$HPPEMIT '        TIdHeaderCoderPlainRegistrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            RegisterHeaderCoderPlain();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '        ~TIdHeaderCoderPlainRegistrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            UnregisterHeaderCoderPlain();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT '    };'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    TIdHeaderCoderPlainRegistrar HeaderCoderPlainRegistrar;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT ''*)

{$NODEFINE RegisterHeaderCoderPlain}
procedure RegisterHeaderCoderPlain;
{$NODEFINE UnregisterHeaderCoderPlain}
procedure UnregisterHeaderCoderPlain;

implementation

uses
  IdGlobal, IdCoderHeader;

type
  TIdHeaderCoderPlain = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

class function TIdHeaderCoderPlain.Decode(const ACharSet, AData: String): String;
begin
  Result := AData;
end;

class function TIdHeaderCoderPlain.Encode(const ACharSet, AData: String): String;
begin
  Result := AData;
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

procedure RegisterHeaderCoderPlain;
begin
  RegisterHeaderCoder(TIdHeaderCoderPlain);
end;

procedure UnregisterHeaderCoderPlain;
begin
  UnregisterHeaderCoder(TIdHeaderCoderPlain);
end;

initialization
  RegisterHeaderCoderPlain;
finalization
  UnregisterHeaderCoderPlain;

end.
