unit IdHeaderCoderBig5;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoderBig5 = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

implementation

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

initialization
  RegisterHeaderCoder(TIdHeaderCoderBig5);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderBig5);

end.
