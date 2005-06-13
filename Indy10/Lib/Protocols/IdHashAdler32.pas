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
{   Rev 1.0    11/13/2002 08:30:30 AM  JPMugaas
{ Initial import from FTP VC.
}
{*****************************************************************************}
{*                              IdHashAdler32.pas                            *}
{*****************************************************************************}

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

uses
  Classes,
  IdGlobal,
  IdHash;

type
  TIdHashAdler32 = class(TIdHash32)
  protected
    function CalculateAdler32(buf:PByteArray; len:integer;const StartValue:LongWord=1): LongWord;
  public
    function HashValue(AStream: TStream): LongWord; override;
  end;

implementation

{ TIdHashAdler32 }


function TIdHashAdler32.CalculateAdler32(buf:PByteArray; len:integer;const StartValue:LongWord=1): LongWord;
const
  BASE = 65521; { largest prime smaller than 65536 }
const
  NMAX = 5552; { NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 }
var
  s1:LongWord;
  s2:LongWord;
  k:integer;
begin
  s1 := StartValue and $ffff;
  s2 := (StartValue shr 16) and $ffff;

  while (len > 0) do begin
    if len < NMAX then
      k := len
    else
      k := NMAX;
    dec(len, k);
    while (k >= 16) do begin
      inc(s1, buf[0]); inc(s2, s1);     //   loop unrolled 16 times
      inc(s1, buf[1]); inc(s2, s1);     //
      inc(s1, buf[2]); inc(s2, s1);     //
      inc(s1, buf[3]); inc(s2, s1);     //
      inc(s1, buf[4]); inc(s2, s1);     //
      inc(s1, buf[5]); inc(s2, s1);     //
      inc(s1, buf[6]); inc(s2, s1);     //
      inc(s1, buf[7]); inc(s2, s1);     //
      inc(s1, buf[8]); inc(s2, s1);     //
      inc(s1, buf[9]); inc(s2, s1);     //
      inc(s1, buf[10]); inc(s2, s1);    //
      inc(s1, buf[11]); inc(s2, s1);    //
      inc(s1, buf[12]); inc(s2, s1);    //
      inc(s1, buf[13]); inc(s2, s1);    //
      inc(s1, buf[14]); inc(s2, s1);    //
      inc(s1, buf[15]); inc(s2, s1);    //   loop unrolled 16 times
      buf:=@buf[16];
      dec(k, 16);
    end;
    if (k <> 0) then repeat
      inc(s1, buf[0]); inc(s2, s1);
      buf:=@buf[1];
      dec(k);
    until (k = 0);
    s1 := s1 mod BASE;
    s2 := s2 mod BASE;
  end;
  result:=(s2 shl 16) or s1;
end;

function TIdHashAdler32.HashValue(AStream: TStream): LongWord;
var
  LBuffer: array[0..8 * 1024 - 1] of Byte;
  LSize: integer;
begin
  Result := 1;
  LSize := AStream.Read(LBuffer, SizeOf(LBuffer));
  while LSize > 0 do begin
    Result := CalculateAdler32(@LBuffer,LSize,Result);
    LSize := AStream.Read(LBuffer, SizeOf(LBuffer));
  end;
end;

end.

