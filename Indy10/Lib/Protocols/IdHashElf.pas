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
  Rev 1.1    2003-10-16 11:22:42  HHellström
  Fixed for dotNET

  Rev 1.0    11/13/2002 07:53:32 AM  JPMugaas
}

unit IdHashElf;

interface

uses
  IdGlobal, IdHash, IdObjs;

type
  TIdHashElf = class(TIdHash32)
  protected
    function GetHashBytes(AStream: TIdStream; ASize: Int64): TIdBytes; override;
  public
    procedure HashStart(var VRunningHash : LongWord); override;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); override;
  end;

implementation

{ TIdHashElf }

function TIdHashElf.GetHashBytes(AStream: TIdStream; ASize: Int64): TIdBytes;
const
  cBufSize = 1024; // Keep it small for dotNET
var
  I: Integer;
  LBuffer: TIdBytes;
  LSize: Integer;
  LHash, LTemp: LongWord;
begin
  Result := nil;
  LHash := 0;

  SetLength(LBuffer, cBufSize);

  while ASize > 0 do
  begin
    LSize := ReadTIdBytesFromStream(AStream, LBuffer, cBufSize);
    if LSize < 1 then begin
      Break; // TODO: throw a stream read exception instead?
    end;
    for i := 0 to LSize-1 do
    begin
      LHash := (LHash shl 4) + LBuffer[i];
      LTemp := LHash and $F0000000;
      if LTemp <> 0 then begin
        LHash := LHash xor (LTemp shr 24);
      end;
      LHash := LHash and (not LTemp);
    end;
    Dec(ASize, LSize);
  end;

  SetLength(Result, SizeOf(LongWord));
  CopyTIdLongWord(LHash, Result, 0);
end;

procedure TIdHashElf.HashByte(var VRunningHash: LongWord; const AByte: Byte);
var
  LTemp: LongWord;
begin
  VRunningHash := (VRunningHash shl 4) + AByte;
  LTemp := VRunningHash and $F0000000;
  if LTemp <> 0 then begin
    VRunningHash := VRunningHash xor (LTemp shr 24);
  end;
  VRunningHash := VRunningHash and (not LTemp);
end;

procedure TIdHashElf.HashStart(var VRunningHash: LongWord);
begin
  VRunningHash := 0;
end;

end.

