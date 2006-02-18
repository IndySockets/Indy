{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.4    2004.05.20 1:39:26 PM  czhower
  Last of the IdStream updates

  Rev 1.3    2004.05.20 11:37:20 AM  czhower
  IdStreamVCL

  Rev 1.2    2004.05.20 11:13:16 AM  czhower
  More IdStream conversions

  Rev 1.1    2003.06.13 6:57:10 PM  czhower
  Speed improvement

  Rev 1.0    2003.06.13 4:59:36 PM  czhower
  Initial checkin
}

unit IdCoder00E;

interface

uses
  IdCoder3to4, IdGlobal, IdObjs;

type
  TIdDecoder00E = class(TIdDecoder4to3)
  public
    procedure Decode(const AIn: string; const AStartPos: Integer = 1;
     const ABytes: Integer = -1); override;
  end;

  TIdEncoder00E = class(TIdEncoder3to4)
  public
    function Encode(ASrcStream: TIdStream; const ABytes: Integer = MaxInt)
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

function TIdEncoder00E.Encode(ASrcStream: TIdStream; const ABytes: integer): string;
var
  LStart, LSize: Int64;
begin
  LStart := ASrcStream.Position;
  Result := inherited Encode(ASrcStream, ABytes);
  LSize := ASrcStream.Position-LStart;
  Assert(LSize<High(Integer));
  Result := FCodingTable[Integer(LSize) + 1] + Result;
end;

end.
