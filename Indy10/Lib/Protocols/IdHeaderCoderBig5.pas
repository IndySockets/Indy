unit IdHeaderCoderBig5;

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

(*$HPPEMIT 'namespace Idheadercoderbig5'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall RegisterHeaderCoderBig5();'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall UnregisterHeaderCoderBig5();'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    class TIdHeaderCoderBig5Registrar'*)
(*$HPPEMIT '    {'*)
(*$HPPEMIT '    public:'*)
(*$HPPEMIT '        TIdHeaderCoderBig5Registrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            RegisterHeaderCoderBig5();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '        ~TIdHeaderCoderBig5Registrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            UnregisterHeaderCoderBig5();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT '    };'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    TIdHeaderCoderBig5Registrar HeaderCoderBig5Registrar;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT ''*)

{$NODEFINE RegisterHeaderCoderBig5}
procedure RegisterHeaderCoderBig5;
{$NODEFINE UnregisterHeaderCoderBig5}
procedure UnregisterHeaderCoderBig5;

implementation

uses
  IdGlobal, IdCoderHeader;

type
  TIdHeaderCoderBig5 = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

class function TIdHeaderCoderBig5.Decode(const ACharSet, AData: String): String;
begin
  Result := '';
  ToDo;
end;

class function TIdHeaderCoderBig5.Encode(const ACharSet, AData: String): String;
begin
  Result := '';
  ToDo;
end;

class function TIdHeaderCoderBig5.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'Big5');
end;

procedure RegisterHeaderCoderBig5;
begin
  RegisterHeaderCoder(TIdHeaderCoderBig5);
end;

procedure UnregisterHeaderCoderBig5;
begin
  UnregisterHeaderCoder(TIdHeaderCoderBig5);
end;

initialization
  RegisterHeaderCoderBig5;
finalization
  UnregisterHeaderCoderBig5;

end.
