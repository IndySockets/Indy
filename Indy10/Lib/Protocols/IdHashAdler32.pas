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
  Rev 1.0    11/13/2002 08:30:30 AM  JPMugaas
  Initial import from FTP VC.
}

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen                                                  *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*                                                                           *}
{* Implementation of the Adler 32 hash algoritm                              *}
{* Adler 32 is almost as reliable as CRC32, but faster                       *}
{*                                                                           *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 17/10/2002    1.0   Bas Gooijen  Initial start                            *}
{*****************************************************************************}

unit IdHashAdler32;

interface
{$i IdCompilerDefines.inc}

uses
  IdHash;

type
  TIdHashAdler32 = class(TIdHash32)
  public
    procedure HashStart(var VRunningHash : LongWord); override;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); override;
  end;

implementation
  
const
  BASE = 65521; { largest prime smaller than 65536 }
  NMAX = 5552;  { NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 }

{ TIdHashAdler32 }

procedure TIdHashAdler32.HashStart(var VRunningHash : LongWord);
begin
  VRunningHash := 1;
end;

procedure TIdHashAdler32.HashByte(var VRunningHash : LongWord; const AByte : Byte);
var
  s1, s2: LongWord;
begin
  s1 := VRunningHash and $FFFF;
  s2 := (VRunningHash shr 16) and $FFFF;

  Inc(s1, AByte);
  Inc(s2, s1);

  s1 := s1 mod BASE;
  s2 := s2 mod BASE;

  VRunningHash := (s2 shl 16) or s1;
end;

end.

