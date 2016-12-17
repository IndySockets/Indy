unit IdMessageCoderBinHex4;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdMessageCoder,
  IdMessage,
  IdGlobal;

type
  TIdMessageEncoderBinHex4 = class(TIdMessageEncoder)
  public
    procedure Encode(ASrc: TStream; ADest: TStream); override;
  end;

  TIdMessageEncoderInfoBinHex4 = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
  end;

implementation

uses
  IdCoder, IdCoderBinHex4, SysUtils;

{ TIdMessageEncoderInfoBinHex4 }

constructor TIdMessageEncoderInfoBinHex4.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderBinHex4;
end;

{ TIdMessageEncoderBinHex4 }

procedure TIdMessageEncoderBinHex4.Encode(ASrc: TStream; ADest: TStream);
var
  LEncoder: TIdEncoderBinHex4;
begin
  LEncoder := TIdEncoderBinHex4.Create(nil); try
    LEncoder.FileName := FileName;
    LEncoder.Encode(ASrc, ADest);
  finally FreeAndNil(LEncoder); end;
end;

initialization
  TIdMessageEncoderList.RegisterEncoder('binhex4', TIdMessageEncoderInfoBinHex4.Create);    {Do not Localize}

end.
