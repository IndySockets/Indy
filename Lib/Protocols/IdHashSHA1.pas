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
  Rev 1.6    2003-10-12 15:25:50  HHellström
  Comments added

  Rev 1.5    2003-10-12 03:08:24  HHellström
  New implementation; copyright changed. The source code formatting has been
  adjusted to fit the margins. The new implementation is faster on dotNet
  compared to the old one, but is slightly slower on Win32.

  Rev 1.4    2003-10-11 18:44:54  HHellström
  Range checking and overflow checking disabled in the Coder method only. The
  purpose of this setting is to force the arithmetic operations performed on
  LongWord variables to be modulo $100000000. This hack entails reasonable
  performance on both Win32 and dotNet.

  Rev 1.3    10/10/2003 2:20:56 PM  GGrieve
  turn range checking off

  Rev 1.2    2003-09-21 17:31:02  HHellström    Version: 1.2
  DotNET compatibility

  Rev 1.1    2/16/2003 03:19:18 PM  JPMugaas
  Should now compile on D7 better.

  Rev 1.0    11/13/2002 07:53:48 AM  JPMugaas
}

unit IdHashSHA1;

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdHash;

type
  T5x4LongWordRecord = array[0..4] of UInt32;
  T512BitRecord = array [0..63] of Byte;

  TIdHashSHA1 = class(TIdHash)
  protected
    FCheckSum: T5x4LongWordRecord;
    FCBuffer: TIdBytes;
    procedure Coder;
    function GetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes; override;
    function HashToHex(const AHash: TIdBytes): String; override;
  public
    constructor Create; override;
  end;

implementation
  {$IFNDEF DOTNET}
uses
  IdStreamVCL;
  {$ENDIF}
{ TIdHashSHA1 }

function SwapLongWord(const AValue: UInt32): UInt32;
begin
  Result := ((AValue and $FF) shl 24) or ((AValue and $FF00) shl 8) or ((AValue and $FF0000) shr 8) or ((AValue and $FF000000) shr 24);
end;

constructor TIdHashSHA1.Create;
begin
  inherited Create;
  SetLength(FCBuffer, 64);
end;

{$i IdOverflowCheckingOff.inc} // Operations performed modulo $100000000
{$i IdRangeCheckingOff.inc}

procedure TIdHashSHA1.Coder;
var
  T, A, B, C, D, E: UInt32;
  { The size of the W variable has been reduced to make the Coder method
    consume less memory on dotNet. This change has been tested with the v1.1
    framework and entails a general increase of performance by >50%. }
  W: array [0..19] of UInt32;
  i: UInt32;
begin
  { The first 16 W values are identical to the input block with endian
    conversion. }
  for i := 0 to 15 do
  begin
    W[i]:= (FCBuffer[i*4] shl 24) or
            (FCBuffer[i*4+1] shl 16) or
            (FCBuffer[i*4+2] shl 8) or
            FCBuffer[i*4+3];
  end;
  { In normal x86 code all of the remaining 64 W values would be calculated
    here. Here only the four next values are calculated, to reduce the code
    size of the first of the four loops below. }
  for i := 16 to 19 do
  begin
    T := W[i-3] xor W[i-8] xor W[i-14] xor W[i-16];
    W[i] := (T shl 1) or (T shr 31);
  end;

  A := FCheckSum[0];
  B := FCheckSum[1];
  C := FCheckSum[2];
  D := FCheckSum[3];
  E := FCheckSum[4];

  { The following loop could be expanded, but has been kept together to reduce
    the code size. A small code size entails better performance due to CPU
    caching.

    Note that the code size could be reduced further by using the SHA-1
    reference code:

      for i := 0 to 19 do begin
        T := E + (A shl 5) + (A shr 27) + (D xor (B and (C xor D))) + W[i];
        Inc(T,$5A827999);
        E := D;
        D := C;
        C := (B shl 30) + (B shr 2);
        B := A;
        A := T;
      end;

    The reference code is usually (at least partly) expanded, mostly because
    the assignments that circle the state variables A, B, C, D and E are costly,
    in particular on dotNET. (In x86 code further optimization can be achieved
    by eliminating the loop variable, which occupies a CPU register that is
    better used by one of the state variables, plus by expanding the W array
    at the beginning.) }

  i := 0;
  repeat
    Inc(E,(A shl 5) + (A shr 27) + (D xor (B and (C xor D))) + W[i+0]);
    Inc(E,$5A827999);
    B := (B shl 30) + (B shr 2);
    Inc(D,(E shl 5) + (E shr 27) + (C xor (A and (B xor C))) + W[i+1]);
    Inc(D,$5A827999);
    A := (A shl 30) + (A shr 2);
    Inc(C,(D shl 5) + (D shr 27) + (B xor (E and (A xor B))) + W[i+2]);
    Inc(C,$5A827999);
    E := (E shl 30) + (E shr 2);
    Inc(B,(C shl 5) + (C shr 27) + (A xor (D and (E xor A))) + W[i+3]);
    Inc(B,$5A827999);
    D := (D shl 30) + (D shr 2);
    Inc(A,(B shl 5) + (B shr 27) + (E xor (C and (D xor E))) + W[i+4]);
    Inc(A,$5A827999);
    C := (C shl 30) + (C shr 2);
    Inc(i,5);
  until i = 20;

  { The following three loops will only use the first 16 elements of the W
    array in a circular, recursive pattern. The following assignments are a
    trade-off to avoid having to split up the first loop. }
  W[0] := W[16];
  W[1] := W[17];
  W[2] := W[18];
  W[3] := W[19];

  { In the following three loops the recursive W array expansion is performed
    "just in time" following a circular pattern. Using circular indicies (e.g.
    (i+2) and $F) is not free, but the cost of declaring a large W array would
    be higher on dotNET. Before attempting to optimize this code, please note
    that the following language features are also costly:

      * Assignments and moves/copies, in particular on dotNET
      * Constant lookup tables, in particular on dotNET
      * Sub functions, in particular on x86
      * if..then and case..of. }

  i := 20;
  repeat
    T := W[(i+13) and $F] xor W[(i+8) and $F];
    T := T xor W[(i+2) and $F] xor W[i and $F];
    T := (T shl 1) or (T shr 31);
    W[i and $F] := T;
    Inc(E,(A shl 5) + (A shr 27) + (B xor C xor D) + T + $6ED9EBA1);
    B := (B shl 30) + (B shr 2);
    T := W[(i+14) and $F] xor W[(i+9) and $F];
    T := T xor W[(i+3) and $F] xor W[(i+1) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+1) and $F] := T;
    Inc(D,(E shl 5) + (E shr 27) + (A xor B xor C) + T + $6ED9EBA1);
    A := (A shl 30) + (A shr 2);
    T := W[(i+15) and $F] xor W[(i+10) and $F];
    T := T xor W[(i+4) and $F] xor W[(i+2) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+2) and $F] := T;
    Inc(C,(D shl 5) + (D shr 27) + (E xor A xor B) + T + $6ED9EBA1);
    E := (E shl 30) + (E shr 2);
    T := W[i and $F] xor W[(i+11) and $F];
    T := T xor W[(i+5) and $F] xor W[(i+3) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+3) and $F] := T;
    Inc(B,(C shl 5) + (C shr 27) + (D xor E xor A) + T + $6ED9EBA1);
    D := (D shl 30) + (D shr 2);
    T := W[(i+1) and $F] xor W[(i+12) and $F];
    T := T xor W[(i+6) and $F] xor W[(i+4) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+4) and $F] := T;
    Inc(A,(B shl 5) + (B shr 27) + (C xor D xor E) + T + $6ED9EBA1);
    C := (C shl 30) + (C shr 2);
    Inc(i,5);
  until i = 40;

  { Note that the constant $70E44324 = $100000000 - $8F1BBCDC has been selected
    to slightly reduce the probability that the CPU flag C (Carry) is set. This
    trick is taken from the StreamSec(R) StrSecII(TM) implementation of SHA-1.
    It entails a marginal but measurable performance gain on some CPUs. }

  i := 40;
  repeat
    T := W[(i+13) and $F] xor W[(i+8) and $F];
    T := T xor W[(i+2) and $F] xor W[i and $F];
    T := (T shl 1) or (T shr 31);
    W[i and $F] := T;
    Inc(E,(A shl 5) + (A shr 27) + ((B and C) or (D and (B or C))) + T);
    Dec(E,$70E44324);
    B := (B shl 30) + (B shr 2);
    T := W[(i+14) and $F] xor W[(i+9) and $F];
    T := T xor W[(i+3) and $F] xor W[(i+1) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+1) and $F] := T;
    Inc(D,(E shl 5) + (E shr 27) + ((A and B) or (C and (A or B))) + T);
    Dec(D,$70E44324);
    A := (A shl 30) + (A shr 2);
    T := W[(i+15) and $F] xor W[(i+10) and $F];
    T := T xor W[(i+4) and $F] xor W[(i+2) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+2) and $F] := T;
    Inc(C,(D shl 5) + (D shr 27) + ((E and A) or (B and (E or A))) + T);
    Dec(C,$70E44324);
    E := (E shl 30) + (E shr 2);
    T := W[i and $F] xor W[(i+11) and $F];
    T := T xor W[(i+5) and $F] xor W[(i+3) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+3) and $F] := T;
    Inc(B,(C shl 5) + (C shr 27) + ((D and E) or (A and (D or E))) + T);
    Dec(B,$70E44324);
    D := (D shl 30) + (D shr 2);
    T := W[(i+1) and $F] xor W[(i+12) and $F];
    T := T xor W[(i+6) and $F] xor W[(i+4) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+4) and $F] := T;
    Inc(A,(B shl 5) + (B shr 27) + ((C and D) or (E and (C or D))) + T);
    Dec(A,$70E44324);
    C := (C shl 30) + (C shr 2);
    Inc(i,5);
  until i = 60;

  { Note that the constant $359D3E2A = $100000000 - $CA62C1D6 has been selected
    to slightly reduce the probability that the CPU flag C (Carry) is set. This
    trick is taken from the StreamSec(R) StrSecII(TM) implementation of SHA-1.
    It entails a marginal but measurable performance gain on some CPUs. }

  repeat
    T := W[(i+13) and $F] xor W[(i+8) and $F];
    T := T xor W[(i+2) and $F] xor W[i and $F];
    T := (T shl 1) or (T shr 31);
    W[i and $F] := T;
    Inc(E,(A shl 5) + (A shr 27) + (B xor C xor D) + T - $359D3E2A);
    B := (B shl 30) + (B shr 2);
    T := W[(i+14) and $F] xor W[(i+9) and $F];
    T := T xor W[(i+3) and $F] xor W[(i+1) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+1) and $F] := T;
    Inc(D,(E shl 5) + (E shr 27) + (A xor B xor C) + T - $359D3E2A);
    A := (A shl 30) + (A shr 2);
    T := W[(i+15) and $F] xor W[(i+10) and $F];
    T := T xor W[(i+4) and $F] xor W[(i+2) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+2) and $F] := T;
    Inc(C,(D shl 5) + (D shr 27) + (E xor A xor B) + T - $359D3E2A);
    E := (E shl 30) + (E shr 2);
    T := W[i and $F] xor W[(i+11) and $F];
    T := T xor W[(i+5) and $F] xor W[(i+3) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+3) and $F] := T;
    Inc(B,(C shl 5) + (C shr 27) + (D xor E xor A) + T - $359D3E2A);
    D := (D shl 30) + (D shr 2);
    T := W[(i+1) and $F] xor W[(i+12) and $F];
    T := T xor W[(i+6) and $F] xor W[(i+4) and $F];
    T := (T shl 1) or (T shr 31);
    W[(i+4) and $F] := T;
    Inc(A,(B shl 5) + (B shr 27) + (C xor D xor E) + T - $359D3E2A);
    C := (C shl 30) + (C shr 2);
    Inc(i,5);
  until i = 80;

  FCheckSum[0]:= FCheckSum[0] + A;
  FCheckSum[1]:= FCheckSum[1] + B;
  FCheckSum[2]:= FCheckSum[2] + C;
  FCheckSum[3]:= FCheckSum[3] + D;
  FCheckSum[4]:= FCheckSum[4] + E;
end;

function TIdHashSHA1.GetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes;
var
  LSize: Integer;
  LLenHi: UInt32;
  LLenLo: UInt32;
  I: Integer;
begin
  Result := nil;

  FCheckSum[0] := $67452301;
  FCheckSum[1] := $EFCDAB89;
  FCheckSum[2] := $98BADCFE;
  FCheckSum[3] := $10325476;
  FCheckSum[4] := $C3D2E1F0;

  LLenHi := 0;
  LLenLo := 0;

  // Code the entire file in complete 64-byte chunks.
  while ASize >= 64 do begin
    LSize := ReadTIdBytesFromStream(AStream, FCBuffer, 64);
    // TODO: handle stream read error
    Inc(LLenLo, LSize * 8);
    if LLenLo < UInt32(LSize * 8) then begin
      Inc(LLenHi);
    end;
    Coder;
    Dec(ASize, LSize);
  end;

  // Read the last set of bytes.
  LSize := ReadTIdBytesFromStream(AStream, FCBuffer, ASize);
  // TODO: handle stream read error
  Inc(LLenLo, LSize * 8);
  if LLenLo < UInt32(LSize * 8) then begin
    Inc(LLenHi);
  end;

  FCBuffer[LSize] := $80;
  if LSize >= 56 then begin
    for I := (LSize + 1) to 63 do begin
      FCBuffer[i] := 0;
    end;
    Coder;
    LSize := -1;
  end;

  for I := (LSize + 1) to 55 do begin
    FCBuffer[i] := 0;
  end;
  FCBuffer[56] := (LLenHi shr 24);
  FCBuffer[57] := (LLenHi shr 16) and $FF;
  FCBuffer[58] := (LLenHi shr 8) and $FF;
  FCBuffer[59] := (LLenHi and $FF);
  FCBuffer[60] := (LLenLo shr 24);
  FCBuffer[61] := (LLenLo shr 16) and $FF;
  FCBuffer[62] := (LLenLo shr 8) and $FF;
  FCBuffer[63] := (LLenLo and $FF);
  Coder;

  FCheckSum[0] := SwapLongWord(FCheckSum[0]);
  FCheckSum[1] := SwapLongWord(FCheckSum[1]);
  FCheckSum[2] := SwapLongWord(FCheckSum[2]);
  FCheckSum[3] := SwapLongWord(FCheckSum[3]);
  FCheckSum[4] := SwapLongWord(FCheckSum[4]);

  SetLength(Result, SizeOf(UInt32)*5);
  for I := 0 to 4 do begin
    CopyTIdUInt32(FCheckSum[I], Result, SizeOf(UInt32)*I);
  end;
end;

function TIdHashSHA1.HashToHex(const AHash: TIdBytes): String;
begin
  Result := LongWordHashToHex(AHash, 5);
end;

end.
