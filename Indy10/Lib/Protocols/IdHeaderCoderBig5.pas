unit IdHeaderCoderBig5;

interface

{$i IdCompilerDefines.inc}

uses
  IdCoderHeader;

type
  TIdHeaderCoderBig5 = class(TIdHeaderCoder)
  public
    function Decode(const ACharSet, AData: String): String; override;
    function Encode(const ACharSet, AData: String): String; override;
    function CanHandle(const ACharSet: String): Boolean; override;
  end;

implementation

uses
  IdGlobal;

function TIdHeaderCoderBig5.Decode(const ACharSet, AData: String): String;
begin
  Result := '';
  ToDo;
end;

function TIdHeaderCoderBig5.Encode(const ACharSet, AData: String): String;
begin
  Result := '';
  ToDo;
end;

function TIdHeaderCoderBig5.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'Big5');
end;

initialization
  TIdHeaderCoderList.RegisterCoder(TIdHeaderCoderBig5.Create);

end.
