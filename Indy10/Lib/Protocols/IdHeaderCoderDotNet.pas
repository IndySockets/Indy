unit IdHeaderCoderDotNet;

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

(*$HPPEMIT 'namespace Idheadercoderdotnet'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall RegisterHeaderCoderDotNet();'*)
(*$HPPEMIT '    extern PACKAGE void __fastcall UnregisterHeaderCoderDotNet();'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    class TIdHeaderCoderDotNetRegistrar'*)
(*$HPPEMIT '    {'*)
(*$HPPEMIT '    public:'*)
(*$HPPEMIT '        TIdHeaderCoderDotNetRegistrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            RegisterHeaderCoderDotNet();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '        ~TIdHeaderCoderDotNetRegistrar()'*)
(*$HPPEMIT '        {'*)
(*$HPPEMIT '            UnregisterHeaderCoderDotNet();'*)
(*$HPPEMIT '        }'*)
(*$HPPEMIT '    };'*)
(*$HPPEMIT ''*)
(*$HPPEMIT '    TIdHeaderCoderDotNetRegistrar HeaderCoderDotNetRegistrar;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT ''*)

{$NODEFINE RegisterHeaderCoderDotNet}
procedure RegisterHeaderCoderDotNet;
{$NODEFINE UnregisterHeaderCoderDotNet}
procedure UnregisterHeaderCoderDotNet;

implementation

uses
  IdGlobal, IdCoderHeader,
  System.Text;

type
  TIdHeaderCoderDotNet = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

class function TIdHeaderCoderDotNet.Decode(const ACharSet, AData: String): String;
var
  LEncoder: System.Text.Encoding;
  LBytes: TIdBytes;
begin
  Result := '';
  try
    LEncoder := System.Text.Encoding.GetEncoding(ACharSet);
    LBytes := System.Text.Encoding.Convert(
      LEncoder,
      System.Text.Encoding.Unicode,
      LEncoder.GetBytes(AData));
    Result := System.Text.Encoding.Unicode.GetString(LBytes, 0, Length(LBytes));
  except
  end;
end;

class function TIdHeaderCoderDotNet.Encode(const ACharSet, AData: String): String;
var
  LEncoder: System.Text.Encoding;
  LBytes: TIdBytes;
begin
  Result := '';
  try
    LEncoder := System.Text.Encoding.GetEncoding(ACharSet);
    LBytes := System.Text.Encoding.Convert(
      System.Text.Encoding.Unicode,
      LEncoder,
      System.Text.Encoding.Unicode.GetBytes(AData));
    Result := LEncoder.GetString(LBytes, 0, Length(LBytes));
  except
  end;
end;

class function TIdHeaderCoderDotNet.CanHandle(const ACharSet: String): Boolean;
var
  LEncoder: System.Text.Encoding;
begin
  try
    LEncoder := System.Text.Encoding.GetEncoding(ACharSet);
  except
    LEncoder := nil;
  end;
  Result := Assigned(LEncoder);
end;

procedure RegisterHeaderCoderDotNet;
begin
  RegisterHeaderCoder(TIdHeaderCoderDotNet);
end;

procedure UnregisterHeaderCoderDotNet;
begin
  UnregisterHeaderCoder(TIdHeaderCoderDotNet);
end;

initialization
  RegisterHeaderCoderDotNet;
finalization
  UnregisterHeaderCoderDotNet;

end.
