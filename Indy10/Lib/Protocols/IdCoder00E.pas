{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  20265: IdCoder00E.pas 
{
{   Rev 1.4    2004.05.20 1:39:26 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.3    2004.05.20 11:37:20 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.2    2004.05.20 11:13:16 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.1    2003.06.13 6:57:10 PM  czhower
{ Speed improvement
}
{
{   Rev 1.0    2003.06.13 4:59:36 PM  czhower
{ Initial checkin
}
unit IdCoder00E;

interface

uses
  Classes,
  IdCoder3to4, IdStreamVCL, IdStreamRandomAccess;

type
  TIdDecoder00E = class(TIdDecoder4to3)
  public
    procedure Decode(const AIn: string; const AStartPos: Integer = 1;
     const ABytes: Integer = -1); override;
  end;

  TIdEncoder00E = class(TIdEncoder3to4)
  public
    function Encode(ASrcStream: TIdStreamRandomAccess; const ABytes: Integer = MaxInt)
     : string; override;
  end;

implementation

{ TIdDecoder00E }

procedure TIdDecoder00E.Decode(const AIn: string; const AStartPos: Integer = 1;
 const ABytes: Integer = -1);
begin
  if ABytes <> -1 then begin
    inherited Decode(AIn, AStartPos, ABytes);
  end else if AIn <> '' then begin
    //Param 2 - Start at second char since 00E's have byte 1 as length
    //Param 3 - Get expected length of input. This is length in bytes, not chars
    inherited Decode(AIn, 2, FDecodeTable[Ord(AIn[1])]);
  end;
end;

{ TIdEncoder00E }

function TIdEncoder00E.Encode(ASrcStream: TIdStreamRandomAccess; const ABytes: integer): string;
var
  LStart: Integer;
begin
  LStart := ASrcStream.Position;
  Result := inherited Encode(ASrcStream, ABytes);
  Result := FCodingTable[ASrcStream.Position - LStart + 1] + Result;
end;

end.
