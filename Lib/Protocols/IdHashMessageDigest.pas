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
  Rev 1.3    24/01/2004 19:21:36  CCostelloe
  Cleaned up warnings

  Rev 1.2    1/15/2004 2:32:50 AM  JPMugaas
  Attempt to add MD5 coder support for partial streams.  THis is needed for the
  XMD5 command in the FTP Server.

  Rev 1.1    2003-10-12 22:36:40  HHellström
  Reimplemented, optimized and tested for both Win32 and dotNET.

  Rev 1.0    11/13/2002 07:53:40 AM  JPMugaas
}
{
  Implementation of the MD2, MD4 and MD5 Message-Digest Algorithm
  as specified in RFC 1319 (1115), 1320 (1186), 1321

  Author: Henrick Hellström <henrick@streamsec.se>

  Original Intellectual Property Statement:
    Author: Pete Mee
    Port to Indy 8.1 Doychin Bondzhev (doychin@dsoft-bg.com)
    Copyright: (c) Chad Z. Hower and The Winshoes Working Group.
}

unit IdHashMessageDigest;

interface
{$i IdCompilerDefines.inc}

uses
  IdFIPS, IdGlobal, IdHash, Classes;

type
  T4x4LongWordRecord = array[0..3] of UInt32;
  T16x4LongWordRecord = array[0..15] of UInt32;
  T4x4x4LongWordRecord = array[0..3] of T4x4LongWordRecord;

  T512BitRecord = array[0..63] of Byte;
  T384BitRecord = array[0..47] of Byte;
  T128BitRecord = array[0..15] of Byte;

  TIdHashMessageDigest = class(TIdHashNativeAndIntF)
  protected
    FCBuffer: TIdBytes;
    procedure MDCoder; virtual; abstract;
    procedure Reset; virtual;
  end;

  TIdHashMessageDigest2 = class(TIdHashMessageDigest)
  protected
    FX: T384BitRecord;
    FCheckSum: T128BitRecord;

    procedure MDCoder; override;
    procedure Reset; override;

    function InitHash : TIdHashIntCtx; override;
    function NativeGetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes; override;
    function HashToHex(const AHash: TIdBytes): String; override;
  public
    constructor Create; override;
    class function IsIntfAvailable: Boolean; override;
  end;

  TIdHashMessageDigest4 = class(TIdHashMessageDigest)
  protected
    FState: T4x4LongWordRecord;

    function NativeGetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes; override;
    function HashToHex(const AHash: TIdBytes): String; override;

    procedure MDCoder; override;

    function InitHash : TIdHashIntCtx; override;

  public
    constructor Create; override;
    class function IsIntfAvailable: Boolean; override;
  end;

  TIdHashMessageDigest5 = class(TIdHashMessageDigest4)
  protected
    procedure MDCoder; override;

    function InitHash : TIdHashIntCtx; override;
  public
    class function IsIntfAvailable : Boolean; override;
  end;

implementation
uses
  {$IFDEF DOTNET}
  System.Security.Cryptography,
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdGlobalProtocols;

{ TIdHashMessageDigest }

procedure TIdHashMessageDigest.Reset;
begin
  FillBytes(FCBuffer, Length(FCBuffer), 0);
end;

{ TIdHashMessageDigest2 }

const
  MD2_PI_SUBST : array [0..255] of Byte = (
     41,  46,  67, 201, 162, 216, 124,   1,  61,  54,  84, 161, 236, 240,
      6,  19,  98, 167,   5, 243, 192, 199, 115, 140, 152, 147,  43, 217,
    188,  76, 130, 202,  30, 155,  87,  60, 253, 212, 224,  22, 103,  66,
    111,  24, 138,  23, 229,  18, 190,  78, 196, 214, 218, 158, 222,  73,
    160, 251, 245, 142, 187,  47, 238, 122, 169, 104, 121, 145,  21, 178,
      7,  63, 148, 194,  16, 137,  11,  34,  95,  33, 128, 127,  93, 154,
     90, 144,  50,  39,  53,  62, 204, 231, 191, 247, 151,   3, 255,  25,
     48, 179, 72, 165,  181, 209, 215,  94, 146,  42, 172,  86, 170, 198,
     79, 184,  56, 210, 150, 164, 125, 182, 118, 252, 107, 226, 156, 116,
      4, 241,  69, 157, 112,  89, 100, 113, 135,  32, 134,  91, 207, 101,
    230,  45, 168,   2,  27,  96,  37, 173, 174, 176, 185, 246,  28,  70,
     97, 105,  52,  64, 126, 15,   85,  71, 163,  35, 221,  81, 175,  58,
    195,  92, 249, 206, 186, 197, 234,  38,  44,  83,  13, 110, 133,  40,
    132,   9, 211, 223, 205, 244, 65,  129,  77,  82, 106, 220,  55, 200,
    108, 193, 171, 250,  36, 225, 123,   8,  12, 189, 177,  74, 120, 136,
    149, 139, 227,  99, 232, 109, 233, 203, 213, 254,  59,   0,  29,  57,
    242, 239, 183,  14, 102,  88, 208, 228, 166, 119, 114, 248, 235, 117,
     75,  10,  49,  68,  80, 180, 143, 237,  31,  26, 219, 153, 141,  51,
     159,  17, 131, 20);

constructor TIdHashMessageDigest2.Create;
begin
  inherited Create;
  SetLength(FCBuffer, 16);
end;

procedure TIdHashMessageDigest2.MDCoder;
const
  NumRounds = 18;
var
  x: Byte;
  i, j: Integer;
  T: UInt16;
  LCheckSumScore: Byte;
begin
  // Move the next 16 bytes into the second 16 bytes of X.
  for i := 0 to 15 do begin
    x := FCBuffer[i];
    FX[i + 16] := x;
    FX[i + 32] := x xor FX[i];
  end;

  { Do 18 rounds. }
  T := 0;
  for i := 0 to NumRounds - 1 do begin
    for j := 0 to 47 do
    begin
      T := FX[j] xor MD2_PI_SUBST[T];
      FX[j] := T and $FF;
    end;
    T := (T + i) and $FF;
  end;

  LCheckSumScore := FChecksum[15];
  for i := 0 to 15 do begin
    x := FCBuffer[i] xor LCheckSumScore;
    LCheckSumScore := FChecksum[i] xor MD2_PI_SUBST[x];
    FChecksum[i] := LCheckSumScore;
  end;
end;

// Clear Buffer and Checksum arrays
procedure TIdHashMessageDigest2.Reset;
var
  I: Integer;
begin
  inherited Reset;
  for I := 0 to 15 do begin
    FCheckSum[I] := 0;
    FX[I] := 0;
    FX[I+16] := 0;
    FX[I+32] := 0;
  end;
end;

function TIdHashMessageDigest2.NativeGetHashBytes(AStream: TStream; ASize: TIdStreamSize): TIdBytes;
var
  LStartPos: Integer;
  LSize: Integer;
  Pad: Byte;
  I: Integer;
begin
  Result := nil;
  Reset;

  // Code the entire file in complete 16-byte chunks.
  while ASize >= 16 do begin
    LSize := ReadTIdBytesFromStream(AStream, FCBuffer, 16);
    // TODO: handle stream read error
    MDCoder;
    Dec(ASize, LSize);
  end;

  // Read the last set of bytes.
  LStartPos := ReadTIdBytesFromStream(AStream, FCBuffer, ASize);
  // TODO: handle stream read error
  Pad := 16 - LStartPos;

  // Step 1
  for I := LStartPos to 15 do begin
    FCBuffer[I] := Pad;
  end;
  MDCoder;

  // Step 2
  for I := 0 to 15 do begin
    FCBuffer[I] := FCheckSum[I];
  end;
  MDCoder;

  SetLength(Result, SizeOf(UInt32)*4);
  for I := 0 to 3 do
  begin
    CopyTIdUInt32(
      FX[I*4] + (FX[I*4+1] shl 8) + (FX[I*4+2] shl 16) + (FX[I*4+3] shl 24),
      Result, SizeOf(UInt32)*I);
  end;
end;

function TIdHashMessageDigest2.HashToHex(const AHash: TIdBytes): String;
begin
  Result := LongWordHashToHex(AHash, 4);
end;

function TIdHashMessageDigest2.InitHash: TIdHashIntCtx;
begin
  Result := GetMD2HashInst;
end;

class function TIdHashMessageDigest2.IsIntfAvailable: Boolean;
begin
  Result := IsHashingIntfAvail and  IsMD2HashIntfAvail;
end;

{ TIdHashMessageDigest4 }

const
  MD4_INIT_VALUES: T4x4LongWordRecord = (
    $67452301, $EFCDAB89, $98BADCFE, $10325476);

{$i IdOverflowCheckingOff.inc} // Arithmetic operations performed modulo $100000000
{$i IdRangeCheckingOff.inc}

constructor TIdHashMessageDigest4.Create;
begin
  inherited Create;
  SetLength(FCBuffer, 64);
end;

procedure TIdHashMessageDigest4.MDCoder;
var
  A, B, C, D, i : UInt32;
  buff : T16x4LongWordRecord; // 64-byte buffer
begin
  A := FState[0];
  B := FState[1];
  C := FState[2];
  D := FState[3];

  for i := 0 to 15 do
  begin
    buff[i] := FCBuffer[i*4+0] +
               (FCBuffer[i*4+1] shl 8) +
               (FCBuffer[i*4+2] shl 16) +
               (FCBuffer[i*4+3] shl 24);
  end;

  // Round 1
  { Note:
      (x and y) or ( (not x) and z)
    is equivalent to
      (((z xor y) and x) xor z)
    -HHellström }
  for i := 0 to 3 do
  begin
    A := ROL((((D xor C) and B) xor D) + A + buff[i*4+0],  3);
    D := ROL((((C xor B) and A) xor C) + D + buff[i*4+1],  7);
    C := ROL((((B xor A) and D) xor B) + C + buff[i*4+2], 11);
    B := ROL((((A xor D) and C) xor A) + B + buff[i*4+3], 19);
  end;

  // Round 2
  { Note:
      (x and y) or (x and z) or (y and z)
    is equivalent to
      ((x and y) or (z and (x or y)))
    -HHellström }
  for i := 0 to 3 do
  begin
    A := ROL(((B and C) or (D and (B or C))) + A + buff[0*4+i] + $5A827999,  3);
    D := ROL(((A and B) or (C and (A or B))) + D + buff[1*4+i] + $5A827999,  5);
    C := ROL(((D and A) or (B and (D or A))) + C + buff[2*4+i] + $5A827999,  9);
    B := ROL(((C and D) or (A and (C or D))) + B + buff[3*4+i] + $5A827999, 13);
  end;

  // Round 3
  A := ROL((B xor C xor D) + A + buff[ 0] + $6ED9EBA1,  3);
  D := ROL((A xor B xor C) + D + buff[ 8] + $6ED9EBA1,  9);
  C := ROL((D xor A xor B) + C + buff[ 4] + $6ED9EBA1, 11);
  B := ROL((C xor D xor A) + B + buff[12] + $6ED9EBA1, 15);
  A := ROL((B xor C xor D) + A + buff[ 2] + $6ED9EBA1,  3);
  D := ROL((A xor B xor C) + D + buff[10] + $6ED9EBA1,  9);
  C := ROL((D xor A xor B) + C + buff[ 6] + $6ED9EBA1, 11);
  B := ROL((C xor D xor A) + B + buff[14] + $6ED9EBA1, 15);
  A := ROL((B xor C xor D) + A + buff[ 1] + $6ED9EBA1,  3);
  D := ROL((A xor B xor C) + D + buff[ 9] + $6ED9EBA1,  9);
  C := ROL((D xor A xor B) + C + buff[ 5] + $6ED9EBA1, 11);
  B := ROL((C xor D xor A) + B + buff[13] + $6ED9EBA1, 15);
  A := ROL((B xor C xor D) + A + buff[ 3] + $6ED9EBA1,  3);
  D := ROL((A xor B xor C) + D + buff[11] + $6ED9EBA1,  9);
  C := ROL((D xor A xor B) + C + buff[ 7] + $6ED9EBA1, 11);
  B := ROL((C xor D xor A) + B + buff[15] + $6ED9EBA1, 15);

  Inc(FState[0], A);
  Inc(FState[1], B);
  Inc(FState[2], C);
  Inc(FState[3], D);
end;

{$i IdRangeCheckingOn.inc}
{$i IdOverflowCheckingOn.inc}

function TIdHashMessageDigest4.NativeGetHashBytes(AStream: TStream; ASize: TIdStreamSize): TidBytes;
var
  LStartPos: Integer;
  LSize: TIdStreamSize;
  LBitSize: Int64;
  I, LReadSize: Integer;
begin
  Result := nil;

  LSize := ASize;

  // A straight assignment would be by ref on dotNET.
  for I := 0 to 3 do begin
    FState[I] := MD4_INIT_VALUES[I];
  end;

  while LSize >= 64 do
  begin
    LReadSize := ReadTIdBytesFromStream(AStream, FCBuffer, 64);
    // TODO: handle stream read error
    MDCoder;
    Dec(LSize, LReadSize);
  end;

  // Read the last set of bytes.
  LStartPos := ReadTIdBytesFromStream(AStream, FCBuffer, LSize);
  // TODO: handle stream read error

  // Append one bit with value 1
  FCBuffer[LStartPos] := $80;
  Inc(LStartPos);

  // Must have sufficient space to insert the 64-bit size value
  if LStartPos > 56 then
  begin
    for I := LStartPos to 63 do begin
      FCBuffer[I] := 0;
    end;
    MDCoder;
    LStartPos := 0;
  end;

  // Pad with zeroes. Leave room for the 64 bit size value.
  for I := LStartPos to 55 do begin
    FCBuffer[I] := 0;
  end;

  // Append the Number of bits processed.
  LBitSize := ASize * 8;
  for I := 56 to 63 do
  begin
    FCBuffer[I] := LBitSize and $FF;
    LBitSize := LBitSize shr 8;
  end;
  MDCoder;

  SetLength(Result, SizeOf(UInt32)*4);
  for I := 0 to 3 do begin
    CopyTIdUInt32(FState[I], Result, SizeOf(UInt32)*I);
  end;
end;

function TIdHashMessageDigest4.InitHash : TIdHashIntCtx;
begin
  Result := GetMD4HashInst;
end;

function TIdHashMessageDigest4.HashToHex(const AHash: TIdBytes): String;
begin
  Result := LongWordHashToHex(AHash, 4);
end;

class function TIdHashMessageDigest4.IsIntfAvailable: Boolean;
begin
  Result := IsHashingIntfAvail and IsMD4HashIntfAvail ;
end;

{ TIdHashMessageDigest5 }

const
  MD5_SINE : array[1..64] of UInt32 = (
   { Round 1. }
   $d76aa478, $e8c7b756, $242070db, $c1bdceee, $f57c0faf, $4787c62a,
   $a8304613, $fd469501, $698098d8, $8b44f7af, $ffff5bb1, $895cd7be,
   $6b901122, $fd987193, $a679438e, $49b40821,
   { Round 2. }
   $f61e2562, $c040b340, $265e5a51, $e9b6c7aa, $d62f105d, $02441453,
   $d8a1e681, $e7d3fbc8, $21e1cde6, $c33707d6, $f4d50d87, $455a14ed,
   $a9e3e905, $fcefa3f8, $676f02d9, $8d2a4c8a,
   { Round 3. }
   $fffa3942, $8771f681, $6d9d6122, $fde5380c, $a4beea44, $4bdecfa9,
   $f6bb4b60, $bebfbc70, $289b7ec6, $eaa127fa, $d4ef3085, $04881d05,
   $d9d4d039, $e6db99e5, $1fa27cf8, $c4ac5665,
   { Round 4. }
   $f4292244, $432aff97, $ab9423a7, $fc93a039, $655b59c3, $8f0ccc92,
   $ffeff47d, $85845dd1, $6fa87e4f, $fe2ce6e0, $a3014314, $4e0811a1,
   $f7537e82, $bd3af235, $2ad7d2bb, $eb86d391
  );

{$i IdOverflowCheckingOff.inc} // Arithmetic operations performed modulo $100000000
{$i IdRangeCheckingOff.inc}

function TIdHashMessageDigest5.InitHash: TIdHashIntCtx;
begin
  Result := GetMD5HashInst;
end;

class function TIdHashMessageDigest5.IsIntfAvailable: Boolean;
begin
  Result := IsHashingIntfAvail and IsMD5HashIntfAvail ;
end;

procedure TIdHashMessageDigest5.MDCoder;
var
  A, B, C, D : UInt32;
  i: Integer;
  x : T16x4LongWordRecord; // 64-byte buffer
begin
  A := FState[0];
  B := FState[1];
  C := FState[2];
  D := FState[3];

  for i := 0 to 15 do
  begin
    x[i] := FCBuffer[i*4+0] +
            (FCBuffer[i*4+1] shl 8) +
            (FCBuffer[i*4+2] shl 16) +
            (FCBuffer[i*4+3] shl 24);
  end;
  { Round 1 }
  { Note:
      (x and y) or ( (not x) and z)
    is equivalent to
      (((z xor y) and x) xor z)
    -HHellström }
  A := ROL(A + (((D xor C) and B) xor D) + x[ 0] + MD5_SINE[ 1],  7) + B;
  D := ROL(D + (((C xor B) and A) xor C) + x[ 1] + MD5_SINE[ 2], 12) + A;
  C := ROL(C + (((B xor A) and D) xor B) + x[ 2] + MD5_SINE[ 3], 17) + D;
  B := ROL(B + (((A xor D) and C) xor A) + x[ 3] + MD5_SINE[ 4], 22) + C;
  A := ROL(A + (((D xor C) and B) xor D) + x[ 4] + MD5_SINE[ 5],  7) + B;
  D := ROL(D + (((C xor B) and A) xor C) + x[ 5] + MD5_SINE[ 6], 12) + A;
  C := ROL(C + (((B xor A) and D) xor B) + x[ 6] + MD5_SINE[ 7], 17) + D;
  B := ROL(B + (((A xor D) and C) xor A) + x[ 7] + MD5_SINE[ 8], 22) + C;
  A := ROL(A + (((D xor C) and B) xor D) + x[ 8] + MD5_SINE[ 9],  7) + B;
  D := ROL(D + (((C xor B) and A) xor C) + x[ 9] + MD5_SINE[10], 12) + A;
  C := ROL(C + (((B xor A) and D) xor B) + x[10] + MD5_SINE[11], 17) + D;
  B := ROL(B + (((A xor D) and C) xor A) + x[11] + MD5_SINE[12], 22) + C;
  A := ROL(A + (((D xor C) and B) xor D) + x[12] + MD5_SINE[13],  7) + B;
  D := ROL(D + (((C xor B) and A) xor C) + x[13] + MD5_SINE[14], 12) + A;
  C := ROL(C + (((B xor A) and D) xor B) + x[14] + MD5_SINE[15], 17) + D;
  B := ROL(B + (((A xor D) and C) xor A) + x[15] + MD5_SINE[16], 22) + C;

  { Round 2 }
  { Note:
      (x and z) or (y and (not z) )
    is equivalent to
      (((y xor x) and z) xor y)
    -HHellström }
  A := ROL(A + (C xor (D and (B xor C))) + x[ 1] + MD5_SINE[17],  5) + B;
  D := ROL(D + (B xor (C and (A xor B))) + x[ 6] + MD5_SINE[18],  9) + A;
  C := ROL(C + (A xor (B and (D xor A))) + x[11] + MD5_SINE[19], 14) + D;
  B := ROL(B + (D xor (A and (C xor D))) + x[ 0] + MD5_SINE[20], 20) + C;
  A := ROL(A + (C xor (D and (B xor C))) + x[ 5] + MD5_SINE[21],  5) + B;
  D := ROL(D + (B xor (C and (A xor B))) + x[10] + MD5_SINE[22],  9) + A;
  C := ROL(C + (A xor (B and (D xor A))) + x[15] + MD5_SINE[23], 14) + D;
  B := ROL(B + (D xor (A and (C xor D))) + x[ 4] + MD5_SINE[24], 20) + C;
  A := ROL(A + (C xor (D and (B xor C))) + x[ 9] + MD5_SINE[25],  5) + B;
  D := ROL(D + (B xor (C and (A xor B))) + x[14] + MD5_SINE[26],  9) + A;
  C := ROL(C + (A xor (B and (D xor A))) + x[ 3] + MD5_SINE[27], 14) + D;
  B := ROL(B + (D xor (A and (C xor D))) + x[ 8] + MD5_SINE[28], 20) + C;
  A := ROL(A + (C xor (D and (B xor C))) + x[13] + MD5_SINE[29],  5) + B;
  D := ROL(D + (B xor (C and (A xor B))) + x[ 2] + MD5_SINE[30],  9) + A;
  C := ROL(C + (A xor (B and (D xor A))) + x[ 7] + MD5_SINE[31], 14) + D;
  B := ROL(B + (D xor (A and (C xor D))) + x[12] + MD5_SINE[32], 20) + C;

  { Round 3. }
  A := ROL(A + (B xor C xor D) + x[ 5] + MD5_SINE[33],  4) + B;
  D := ROL(D + (A xor B xor C) + x[ 8] + MD5_SINE[34], 11) + A;
  C := ROL(C + (D xor A xor B) + x[11] + MD5_SINE[35], 16) + D;
  B := ROL(B + (C xor D xor A) + x[14] + MD5_SINE[36], 23) + C;
  A := ROL(A + (B xor C xor D) + x[ 1] + MD5_SINE[37],  4) + B;
  D := ROL(D + (A xor B xor C) + x[ 4] + MD5_SINE[38], 11) + A;
  C := ROL(C + (D xor A xor B) + x[ 7] + MD5_SINE[39], 16) + D;
  B := ROL(B + (C xor D xor A) + x[10] + MD5_SINE[40], 23) + C;
  A := ROL(A + (B xor C xor D) + x[13] + MD5_SINE[41],  4) + B;
  D := ROL(D + (A xor B xor C) + x[ 0] + MD5_SINE[42], 11) + A;
  C := ROL(C + (D xor A xor B) + x[ 3] + MD5_SINE[43], 16) + D;
  B := ROL(B + (C xor D xor A) + x[ 6] + MD5_SINE[44], 23) + C;
  A := ROL(A + (B xor C xor D) + x[ 9] + MD5_SINE[45],  4) + B;
  D := ROL(D + (A xor B xor C) + x[12] + MD5_SINE[46], 11) + A;
  C := ROL(C + (D xor A xor B) + x[15] + MD5_SINE[47], 16) + D;
  B := ROL(B + (C xor D xor A) + x[ 2] + MD5_SINE[48], 23) + C;

  { Round 4. }
  A := ROL(A + ((B or not D) xor C) + x[ 0] + MD5_SINE[49],  6) + B;
  D := ROL(D + ((A or not C) xor B) + x[ 7] + MD5_SINE[50], 10) + A;
  C := ROL(C + ((D or not B) xor A) + x[14] + MD5_SINE[51], 15) + D;
  B := ROL(B + ((C or not A) xor D) + x[ 5] + MD5_SINE[52], 21) + C;
  A := ROL(A + ((B or not D) xor C) + x[12] + MD5_SINE[53],  6) + B;
  D := ROL(D + ((A or not C) xor B) + x[ 3] + MD5_SINE[54], 10) + A;
  C := ROL(C + ((D or not B) xor A) + x[10] + MD5_SINE[55], 15) + D;
  B := ROL(B + ((C or not A) xor D) + x[ 1] + MD5_SINE[56], 21) + C;
  A := ROL(A + ((B or not D) xor C) + x[ 8] + MD5_SINE[57],  6) + B;
  D := ROL(D + ((A or not C) xor B) + x[15] + MD5_SINE[58], 10) + A;
  C := ROL(C + ((D or not B) xor A) + x[ 6] + MD5_SINE[59], 15) + D;
  B := ROL(B + ((C or not A) xor D) + x[13] + MD5_SINE[60], 21) + C;
  A := ROL(A + ((B or not D) xor C) + x[ 4] + MD5_SINE[61],  6) + B;
  D := ROL(D + ((A or not C) xor B) + x[11] + MD5_SINE[62], 10) + A;
  C := ROL(C + ((D or not B) xor A) + x[ 2] + MD5_SINE[63], 15) + D;
  B := ROL(B + ((C or not A) xor D) + x[ 9] + MD5_SINE[64], 21) + C;

  Inc(FState[0], A);
  Inc(FState[1], B);
  Inc(FState[2], C);
  Inc(FState[3], D);
end;

{$i IdRangeCheckingOn.inc}
{$i IdOverflowCheckingOn.inc}

end.
