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

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdHash;

type
  TIdHashElf = class(TIdHash32)
  public
    procedure HashStart(var VRunningHash : UInt32); override;
    procedure HashByte(var VRunningHash : UInt32; const AByte : Byte); override;
  end;

implementation

{ TIdHashElf }

procedure TIdHashElf.HashStart(var VRunningHash: UInt32);
begin
  VRunningHash := 0;
end;

procedure TIdHashElf.HashByte(var VRunningHash: UInt32; const AByte: Byte);
var
  LTemp: UInt32;
begin
  VRunningHash := (VRunningHash shl 4) + AByte;
  LTemp := VRunningHash and $F0000000;
  if LTemp <> 0 then begin
    VRunningHash := VRunningHash xor (LTemp shr 24);
  end;
  VRunningHash := VRunningHash and (not LTemp);
end;

end.

