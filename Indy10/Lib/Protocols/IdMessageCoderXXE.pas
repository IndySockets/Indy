{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11677: IdMessageCoderXXE.pas 
{
{   Rev 1.2    2004.01.22 5:41:50 PM  czhower
{ Fixed visibility
}
{
{   Rev 1.1    1/21/2004 2:20:24 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 07:57:18 AM  JPMugaas
}
unit IdMessageCoderXXE;

interface

uses
  IdMessageCoderUUE, IdMessageCoder, IdMessage;

type
  // No Decoder - UUE handles XXE decoding

  TIdMessageEncoderXXE = class(TIdMessageEncoderUUEBase)
  protected
    procedure InitComponent; override;
  end;

  TIdMessageEncoderInfoXXE = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
  end;

implementation

uses
  IdCoderXXE;

{ TIdMessageEncoderInfoXXE }

constructor TIdMessageEncoderInfoXXE.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderXXE;
end;

{ TIdMessageEncoderXXE }

procedure TIdMessageEncoderXXE.InitComponent;
begin
  inherited;
  FEncoderClass := TIdEncoderXXE;
end;

initialization
  TIdMessageEncoderList.RegisterEncoder('XXE', TIdMessageEncoderInfoXXE.Create);    {Do not Localize}
end.
