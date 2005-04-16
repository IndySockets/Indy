{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13754: IdCoder3to4.pas
{
{   Rev 1.30    15.09.2004 22:38:22  Andreas Hausladen
{ Added "Delphi 7.1 compiler warning bug" fix code
}
{
{   Rev 1.29    27.08.2004 22:03:22  Andreas Hausladen
{ Optimized encoders
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.28    7/8/04 5:09:04 PM  RLebeau
{ Updated Encode() to remove use of local TIdBytes variable
}
{
{   Rev 1.27    2004.05.20 1:39:20 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.26    2004.05.20 11:37:08 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.25    2004.05.20 11:13:12 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.24    2004.05.19 3:06:54 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.23    2004.03.12 7:54:18 PM  czhower
{ Removed old commented out code.
}
{
{   Rev 1.22    11/03/2004 22:36:14  CCostelloe
{ Bug fix (1 to 3 spurious extra characters at the end of UUE encoded messages,
{ see comment starting CC3.
}
{
{   Rev 1.21    2004.02.03 5:44:56 PM  czhower
{ Name changes
}
{
{   Rev 1.20    28/1/2004 6:22:16 PM  SGrobety
{ Removed base 64 encoding stream length check is stream size was provided
}
{
{   Rev 1.19    16/01/2004 17:47:48  CCostelloe
{ Restructured slightly to allow IdCoderBinHex4 reuse some of its code
}
{
{   Rev 1.18    02/01/2004 20:59:28  CCostelloe
{ Fixed bugs to get ported code to work in Delphi 7 (changes marked CC2)
}
{
{   Rev 1.17    11/10/2003 7:54:14 PM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.16    2003.10.24 10:43:02 AM  czhower
{ TIdSTream to dos
}
{
{   Rev 1.15    22/10/2003 12:25:36  HHariri
{ Stephanes changes
}
{
    Rev 1.14    10/16/2003 11:10:18 PM  DSiders
  Added localization comments, whitespace.
}
{
{   Rev 1.13    2003.10.11 10:00:12 PM  czhower
{ Compiles again
}
{
{   Rev 1.12    10/5/2003 4:31:02 PM  GGrieve
{ use ToBytes for Cardinal to Bytes conversion
}
{
{   Rev 1.11    10/4/2003 9:12:18 PM  GGrieve
{ DotNet
}
{
{   Rev 1.10    2003.06.24 12:02:10 AM  czhower
{ Coders now decode properly again.
}
{
{   Rev 1.9    2003.06.23 10:53:16 PM  czhower
{ Removed unused overriden methods.
}
{
{   Rev 1.8    2003.06.13 6:57:10 PM  czhower
{ Speed improvement
}
{
{   Rev 1.7    2003.06.13 3:41:18 PM  czhower
{ Optimizaitions.
}
{
{   Rev 1.6    2003.06.13 2:24:08 PM  czhower
{ Speed improvement
}
{
{   Rev 1.5    10/6/2003 5:37:02 PM  SGrobety
{ Bug fix in decoders.
}
{
{   Rev 1.4    6/6/2003 4:50:30 PM  SGrobety
{ Reworked the 3to4decoder for performance and stability.
{ Note that encoders haven't been touched. Will come later. Another problem:
{ input is ALWAYS a string. Should be a TStream.
{
{ 1/ Fix: added filtering for #13,#10 and #32 to the decoding mechanism.
{ 2/ Optimization: Speed the decoding by a factor 7-10 AND added filtering ;)
{ Could still do better by using a pointer and a stiding window by a factor 2-3.
{ 3/ Improvement: instead of writing everything to the output stream, there is
{ an internal buffer of 4k. It should speed things up when working on large
{ data (no large chunk of memory pre-allocated while keeping a decent perf by
{ not requiring every byte to be written separately).
}
{
{   Rev 1.3    28/05/2003 10:06:56  CCostelloe
{ StripCRLFs changes stripped out at the request of Chad
}
{
{   Rev 1.2    20/05/2003 02:01:00  CCostelloe
}
{
{   Rev 1.1    20/05/2003 01:44:12  CCostelloe
{ Bug fix: decoder code altered to ensure that any CRLFs inserted by an MTA are
{ removed
}
{
{   Rev 1.0    11/14/2002 02:14:36 PM  JPMugaas
}
unit IdCoder3to4;

interface

uses
  Classes,
  IdCoder, IdGlobal, IdStreamRandomAccess;

type
  TIdDecodeTable = array[1..127] of Byte;

  TIdEncoder3to4 = class(TIdEncoder)
  protected
    FCodingTable: string;
    FFillChar: Char;
    function EncodeIdBytes(ABuffer: TIdBytes): TIdBytes;
  public
    function Encode(ASrcStream: TIdStreamRandomAccess;
     const ABytes: Integer = MaxInt): string; override;
    //procedure EncodeUnit(const AIn1, AIn2, AIn3: Byte; var VOut: TIdBytes);
  published
    property CodingTable: string read FCodingTable;
    property FillChar: Char read FFillChar write FFillChar;
  end;

  TIdEncoder3to4Class = class of TIdEncoder3to4;

  TIdDecoder4to3 = class(TIdDecoder)
  protected
    FCodingTable: string;
    FDecodeTable: TIdDecodeTable;
    FFillChar: Char;
    function InternalDecode(const LIn: TIdBytes; const AStartPos: Integer = 1; const ABytes: Integer = -1): TIdBytes;
  public
    class procedure ConstructDecodeTable(const ACodingTable: string;
     var ADecodeArray: TIdDecodeTable);
    procedure Decode(const AIn: string; const AStartPos: Integer = 1;
     const ABytes: Integer = -1); override;
  published
    property FillChar: Char read FFillChar write FFillChar;
  end;

implementation

uses
  IdException, IdResourceStrings,
  SysUtils;

{ TIdDecoder4to3 }

class procedure TIdDecoder4to3.ConstructDecodeTable(const ACodingTable: string;
 var ADecodeArray: TIdDecodeTable);
var
  i: integer;
begin
  //TODO: See if we can find an efficient way, or maybe an option to see if the requested
  //decode char is valid, that is it returns a 255 from the DecodeTable, or at maybe
  //check its presence in the encode table.
  for i := Low(ADecodeArray) to High(ADecodeArray) do begin
    ADecodeArray[i] := 255;
  end;
  for i := 1 to Length(ACodingTable) do begin
    ADecodeArray[Ord(ACodingTable[i])] := i - 1;
  end;
end;

procedure TIdDecoder4to3.Decode(const AIn: string; const AStartPos: Integer = 1; const ABytes: Integer = -1);
var
  LIn : TIdBytes;
  LOut: TIdBytes;
begin
  if AIn <> '' then begin
    SetLength(LIn, 0); // Delphi 7.1 first edition warning bug
    SetLength(LOut, 0); // Delphi 7.1 first edition warning bug
    LIn := ToBytes(AIn); // if in dotnet, convert to serialisable format
    LOut := InternalDecode(LIn, AStartPos, ABytes);
    // Write out data to stream
    FStream.Write(LOut);
  end;
end;

function TIdDecoder4to3.InternalDecode(const LIn: TIdBytes; const AStartPos: Integer = 1; const ABytes: Integer = -1): TIdBytes;
const
  LInBytesLen = 4;
var
  LEmptyBytes: Integer;
  LInBytes: array[0..LInBytesLen - 1] of Byte;
  LWorkBytes: TIdBytes;
  LOutPos: Integer;
  LOutSize: Integer;
  LInLimit: Integer;
  LInPos: Integer;
  LWhole : Cardinal;
  LFillChar: Char; // local copy of FFillChar
begin
  LFillChar := FillChar;
  SetLength(LWorkBytes, 4);

  //TODO: Change output to a TMemoryStream
  LEmptyBytes := 0;
  // Presize output buffer
  //CC2, bugfix: was LOutPos := 1;
  LOutPos := 0;
  if ABytes = -1 then begin
    //LOutSize := (Length(AIn) div 4) * 3;
    LOutSize := (Length(LIn) div 4) * 3;
  end else begin
    // Need to make sure we have space as we always write out 3 and then trim
    // because it requires less checking in the loop
    if ABytes mod 3 > 0 then begin
      LOutSize := (ABytes div 3) * 3 + 3;
    end else begin
      LOutSize := ABytes;
    end;
  end;
  SetLength(Result, LOutSize);
  //
  LInPos := AStartPos;
  // +1 because LInPos is 1 based
  LInLimit := Length(LIn) - LInBytesLen + 1;
  while LInPos <= LInLimit do begin
    // Read 4 bytes in for processing
    //CC2 bugfix: was CopyTIdBytes(LIn, LInPos, LInBytes, 0, LInBytesLen);
    //CopyTIdBytes(LIn, LInPos-1, LInBytes, 0, LInBytesLen);
    // Faster than CopyTIdBytes
    LInBytes[0] := LIn[LInPos - 1];
    LInBytes[1] := LIn[LInPos - 1 + 1];
    LInBytes[2] := LIn[LInPos - 1 + 2];
    LInBytes[3] := LIn[LInPos - 1 + 3];
    // Inc pointer
    Inc(LInPos, LInBytesLen);
    // Reduce to 3 bytes
    LWhole :=
     (FDecodeTable[LInBytes[0]] shl 18)
     or (FDecodeTable[LInBytes[1]] shl 12)
     or (FDecodeTable[LInBytes[2]] shl 6)
     or FDecodeTable[LInBytes[3]];
    ToBytesF(LWorkBytes, LWhole);

    //TODO: Temp - Change the above to reconstruct in our order if possible
    // Then we can call a move on all 3 bytes
    Result[LOutPos] := LWorkBytes[2];
    Result[LOutPos + 1] := LWorkBytes[1];
    Result[LOutPos + 2] := LWorkBytes[0];
    Inc(LOutPos, 3);
    // If we dont know how many bytes we need to watch for fill chars. MIME
    // is this way.
    //
    // In best case, the end is not before the end of the input, but the input
    // may be right padded with spaces, or even contain the EOL chars.
    //
    // Because of this we watch for early ends beyond what we originally
    // estimated.
    if ABytes = -1 then begin
      // Must check 3 before 4, if 3 is FillChar, 4 will also be FillChar
      if LInBytes[2] = ord(LFillChar) then begin
        LEmptyBytes := 2;
        Break;
      end else if LInBytes[3] = ord(LFillChar) then begin
        LEmptyBytes := 1;
        Break;
      end;
    // But with 00E's, we have a length signal for each line so we know
    end else if LOutPos > ABytes then begin
      LEmptyBytes := LOutPos - ABytes;
      Break;
    end;
  end;
  if LEmptyBytes > 0 then
    SetLength(Result, LOutSize - LEmptyBytes);
end;

{ TIdEncoder3to4 }

function TIdEncoder3to4.Encode(ASrcStream: TIdStreamRandomAccess; const ABytes: Integer = MaxInt): string;
//TODO: Make this more efficient. Profile it to test, but maybe make single
// calls to ReadBuffer then pull from memory
var
  LBuffer : TIdBytes;
  LBufSize : Integer;
begin
  //CC2: generated "never used" hint: LIn3 := 0;
  // SG 28.01.04: removed that check: it's only there to "optimize" the output strin
  // SG 28.01.04: and creates more trouble than it solves.
//  if (ABytes <> MaxInt) and ((ABytes mod 3) > 0) then begin
//    raise EIdException.Create(RSUnevenSizeInEncodeStream);
//  end;

  // No no - this will read the whole thing into memory and what if its MBs?
  // need to load it in smaller buffered chunks MaxInt is WAY too big....
  LBufSize := Min(ASrcStream.Size - ASrcStream.Position, ABytes);
  if LBufSize > 0 then begin
    SetLength(LBuffer, LBufSize);
    ASrcStream.ReadBytes(LBuffer, LBufSize);
    Result := BytesToString(EncodeIdBytes(LBuffer));
  end else begin
    Result := '';
  end;
end;

function TIdEncoder3to4.EncodeIdBytes(ABuffer: TIdBytes): TIdBytes;
var
  LOutSize: Integer;
  LLen : integer;
  LPos : Integer;
  LBufSize : Integer;
  LBufDataLen: Integer;
  LIn1, LIn2, LIn3: Byte;
  LSize : Integer;
  LUnit: array[0..3] of Byte; // TIdBytes;
begin
  LBufSize := Length(ABuffer);
  LOutSize := ((LBufSize + 2) div 3) * 4;
  SetLength(Result, LOutSize); // we know that the string will grow by 4/3 adjusted to 3 boundary
  //SetLength(LUnit, 4);
  LLen := 0;
  LPos := 0;

  // S.G. 21/10/2003: Copy the relevant bytes into the temporary buffer.
  // S.G. 21/10/2003: Record the data length and force exit loop when necessary
  while (LPos <= LBufSize) do
  begin
    LBufDataLen := LBufSize - LPos;
    if LBufDataLen > 3 then
    begin
      LIn1 := ABuffer[LPos];
      LIn2 := ABuffer[LPos+1];
      LIn3 := ABuffer[LPos+2];
      LSize := 3;
      inc(LPos, 3);
    end
    else
    begin
      if LBufDataLen > 2 then
      begin
        LIn1 := ABuffer[LPos];
        LIn2 := ABuffer[LPos+1];
        LIn3 := ABuffer[LPos+2];
        LSize := 3;
        LPos := LBufSize+1; // Make sure we break at end of loop
      end
      else
      begin
        if LBufDataLen > 1 then
        begin
          LIn1 := ABuffer[LPos];
          LIn2 := ABuffer[LPos+1];
          LIn3 := 0;
          LSize := 2;
          LPos := LBufSize+1; // Make sure we break at end of loop
        end
        else
        begin
          LIn1 := ABuffer[LPos];
          LIn2 := 0;
          LIn3 := 0;
          LSize := 1;
          LPos := LBufSize+1; // Make sure we break at end of loop
        end;
      end;
    end;

    //EncodeUnit(LIn1, LIn2, LIn3, LUnit);
    // inline
    LUnit[0] := Ord(FCodingTable[((LIn1 shr 2) and 63) + 1]);
    LUnit[1] := Ord(FCodingTable[(((LIn1 shl 4) or (LIn2 shr 4)) and 63) + 1]);
    LUnit[2] := Ord(FCodingTable[(((LIn2 shl 2) or (LIn3 shr 6)) and 63) + 1]);
    LUnit[3] := Ord(FCodingTable[(Ord(LIn3) and 63) + 1]);

    assert(LLen + 4 <= length(Result),
      'TIdEncoder3to4.Encode: Calculated length exceeded (expected '+ {do not localize}
      inttostr(4 * trunc((LBufSize + 2)/3)) +
      ', about to go '+                                               {do not localize}
      inttostr(LLen + 4) +
      ' at offset ' +                                                 {do not localize}
      inttostr(LPos) +
      ' of '+                                                         {do not localize}
      inttostr(LBufSize));

    //CopyTIdBytes(LUnit, 0, Result, LLen, 4);
    Result[LLen] := LUnit[0];
    Result[LLen + 1] := LUnit[1];
    Result[LLen + 2] := LUnit[2];
    Result[LLen + 3] := LUnit[3];
    inc(LLen, 4);

    if LSize < 3 then begin
      Result[LLen-1] := ord(FillChar);
      if LSize = 1 then begin
         Result[LLen-2] := ord(FillChar);
      end;
    end;
  end;

  assert(LLen = (4 * trunc((LBufSize + 2)/3)),
    'TIdEncoder3to4.Encode: Calculated length not met (expected ' +  {do not localize}
    inttostr(4 * trunc((LBufSize + 2)/3)) +
    ', finished at ' +                                               {do not localize}
    inttostr(LLen + 4) +
    ', Bufsize = ' +                                                 {do not localize}
    inttostr(LBufSize));
end;

(*procedure TIdEncoder3to4.EncodeUnit(const AIn1, AIn2, AIn3: Byte; var VOut: TIdBytes);
begin
  SetLength(VOut, 4);
  VOut[0] := Ord(FCodingTable[((AIn1 shr 2) and 63) + 1]);
  VOut[1] := Ord(FCodingTable[(((AIn1 shl 4) or (AIn2 shr 4)) and 63) + 1]);
  VOut[2] := Ord(FCodingTable[(((AIn2 shl 2) or (AIn3 shr 6)) and 63) + 1]);
  VOut[3] := Ord(FCodingTable[(Ord(AIn3) and 63) + 1]);
end;*)

end.

