{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13762: IdCoderUUE.pas
{
{   Rev 1.6    1/21/2004 1:44:16 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.5    10/16/2003 11:11:18 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.4    2003.06.13 6:57:12 PM  czhower
{ Speed improvement
}
{
{   Rev 1.2    6/13/2003 07:58:48 AM  JPMugaas
{ Should now compile with new decoder design.
}
{
{   Rev 1.1    2003.06.13 3:41:20 PM  czhower
{ Optimizaitions.
}
{
{   Rev 1.0    11/14/2002 02:15:06 PM  JPMugaas
}
unit IdCoderUUE;

interface

uses
  IdCoder00E, IdCoder3to4;

type
  TIdDecoderUUE = class(TIdDecoder00E)
  protected
    procedure InitComponent; override;
  end;

  TIdEncoderUUE = class(TIdEncoder00E)
  protected
    procedure InitComponent; override;
  end;

const
  // Note the embedded '
  GUUECodeTable: string =
    '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_'; {do not localize}

var
  GUUEDecodeTable: TIdDecodeTable;

implementation

uses
  IdGlobal;

{ TIdEncoderUUE }

procedure TIdEncoderUUE.InitComponent;
begin
  inherited;
  FCodingTable := GUUECodeTable;
  FFillChar := FCodingTable[1];
end;

{ TIdDecoderUUE }

procedure TIdDecoderUUE.InitComponent;
begin
  inherited;
  FDecodeTable := GUUEDecodeTable;
  FFillChar := GUUECodeTable[1];
end;

initialization
  TIdDecoder00E.ConstructDecodeTable(GUUECodeTable, GUUEDecodeTable);
  // Older UUEncoders use space instead of `. This way we account for both.
  GUUEDecodeTable[Ord(' ')] := GUUEDecodeTable[Ord('`')];
end.
