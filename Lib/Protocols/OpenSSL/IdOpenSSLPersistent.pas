unit IdOpenSSLPersistent;

interface

{$i IdCompilerDefines.inc}

uses
  Classes;

type
  TIdOpenSSLPersistent = class(TPersistent)
  public
    constructor Create; virtual;

    procedure AssignTo(Dest: TPersistent); override;
    function Equals(Obj: TObject): Boolean; {$IFDEF VCL_XE4_OR_ABOVE}override;{$ELSE}virtual;{$ENDIF}
    function Clone: TIdOpenSSLPersistent; virtual;
  end;
  TIdOpenSSLPersistentClass = class of TIdOpenSSLPersistent;

implementation

{ TIdOpenSSLPersistent }

procedure TIdOpenSSLPersistent.AssignTo(Dest: TPersistent);
begin
  if not (Dest is TIdOpenSSLPersistent) then
    inherited;
end;

function TIdOpenSSLPersistent.Equals(Obj: TObject): Boolean;
begin
  Result := Assigned(Obj) and (Obj is TIdOpenSSLPersistent);
end;

function TIdOpenSSLPersistent.Clone: TIdOpenSSLPersistent;
begin
  Result := TIdOpenSSLPersistentClass(Self.ClassType).Create();
  AssignTo(Result);
end;

constructor TIdOpenSSLPersistent.Create;
begin
  inherited;
end;

end.
