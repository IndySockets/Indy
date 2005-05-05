{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11603: IdHashElf.pas 
{
{   Rev 1.1    2003-10-16 11:22:42  HHellström
{ Fixed for dotNET
}
{
{   Rev 1.0    11/13/2002 07:53:32 AM  JPMugaas
}
unit IdHashElf;

interface

uses
  Classes,
  IdHash;

type
  TIdHashElf = class( TIdHash32 )
  public
    function HashValue( AStream: TStream ) : LongWord; override;
    procedure HashStart(var VRunningHash : LongWord); override;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); override;

  end;

implementation

{ TIdHashElf }

procedure TIdHashElf.HashByte(var VRunningHash: LongWord; const AByte: Byte);
var
  LTemp: LongWord;
begin
  VRunningHash := ( VRunningHash shl 4 ) + AByte;
  LTemp := VRunningHash and $F0000000;
  if LTemp <> 0 then begin
    VRunningHash := VRunningHash xor ( LTemp shr 24 ) ;
  end;
  VRunningHash := VRunningHash and not LTemp;

end;

procedure TIdHashElf.HashStart(var VRunningHash: LongWord);
begin
  VRunningHash := 0;
end;

function TIdHashElf.HashValue( AStream: TStream ) : LongWord;
const
  BufSize = 1024; // Keep it small for dotNET
var
  i: Integer;
  LTemp: LongWord;
  LBuffer: array[0..BufSize - 1] of Byte;
  LSize: integer;
begin
  Result := 0;
  LSize := AStream.Read( LBuffer, BufSize ) ;
  while LSize > 0 do begin
    for i := 0 to LSize - 1 do begin
      Result := ( Result shl 4 ) + LBuffer[i];
      LTemp := Result and $F0000000;
      if LTemp <> 0 then begin
        Result := Result xor ( LTemp shr 24 ) ;
      end;
      Result := Result and not LTemp;
      LSize := AStream.Read( LBuffer, BufSize ) ;
    end;
  end;
end;

end.

