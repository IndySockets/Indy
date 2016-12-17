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


  $Log$


    Rev 1.30    15.09.2004 22:38:22  Andreas Hausladen
  Added "Delphi 7.1 compiler warning bug" fix code


    Rev 1.29    27.08.2004 22:03:22  Andreas Hausladen
  Optimized encoders
  speed optimization ("const" for string parameters)


    Rev 1.28    7/8/04 5:09:04 PM  RLebeau
  Updated Encode() to remove use of local TIdBytes variable


    Rev 1.27    2004.05.20 1:39:20 PM  czhower
  Last of the IdStream updates


    Rev 1.26    2004.05.20 11:37:08 AM  czhower
  IdStreamVCL


    Rev 1.25    2004.05.20 11:13:12 AM  czhower
  More IdStream conversions


    Rev 1.24    2004.05.19 3:06:54 PM  czhower
  IdStream / .NET fix


    Rev 1.23    2004.03.12 7:54:18 PM  czhower
  Removed old commented out code.


    Rev 1.22    11/03/2004 22:36:14  CCostelloe
  Bug fix (1 to 3 spurious extra characters at the end of UUE encoded messages,
  see comment starting CC3.


    Rev 1.21    2004.02.03 5:44:56 PM  czhower
  Name changes


    Rev 1.20    28/1/2004 6:22:16 PM  SGrobety
  Removed base 64 encoding stream length check is stream size was provided


    Rev 1.19    16/01/2004 17:47:48  CCostelloe
  Restructured slightly to allow IdCoderBinHex4 reuse some of its code


    Rev 1.18    02/01/2004 20:59:28  CCostelloe
  Fixed bugs to get ported code to work in Delphi 7 (changes marked CC2)


    Rev 1.17    11/10/2003 7:54:14 PM  BGooijen
  Did all todo's ( TStream to TIdStream mainly )


    Rev 1.16    2003.10.24 10:43:02 AM  czhower
  TIdSTream to dos


    Rev 1.15    22/10/2003 12:25:36  HHariri
  Stephanes changes


    Rev 1.14    10/16/2003 11:10:18 PM  DSiders
  Added localization comments, whitespace.


    Rev 1.13    2003.10.11 10:00:12 PM  czhower
  Compiles again


    Rev 1.12    10/5/2003 4:31:02 PM  GGrieve
  use ToBytes for Cardinal to Bytes conversion


    Rev 1.11    10/4/2003 9:12:18 PM  GGrieve
  DotNet


    Rev 1.10    2003.06.24 12:02:10 AM  czhower
  Coders now decode properly again.


    Rev 1.9    2003.06.23 10:53:16 PM  czhower
  Removed unused overriden methods.


    Rev 1.8    2003.06.13 6:57:10 PM  czhower
  Speed improvement


   Rev 1.7    2003.06.13 3:41:18 PM  czhower
  Optimizaitions.


    Rev 1.6    2003.06.13 2:24:08 PM  czhower
  Speed improvement


    Rev 1.5    10/6/2003 5:37:02 PM  SGrobety
  Bug fix in decoders.


    Rev 1.4    6/6/2003 4:50:30 PM  SGrobety
  Reworked the 3to4decoder for performance and stability.
  Note that encoders haven't been touched. Will come later. Another problem:
  input is ALWAYS a string. Should be a TStream.

  1/ Fix: added filtering for #13,#10 and #32 to the decoding mechanism.
  2/ Optimization: Speed the decoding by a factor 7-10 AND added filtering ;)
   Could still do better by using a pointer and a stiding window by a factor 2-3.
  3/ Improvement: instead of writing everything to the output stream, there is
  an internal buffer of 4k. It should speed things up when working on large
  data (no large chunk of memory pre-allocated while keeping a decent perf by
  not requiring every byte to be written separately).


    Rev 1.3    28/05/2003 10:06:56  CCostelloe
  StripCRLFs changes stripped out at the request of Chad


   Rev 1.2    20/05/2003 02:01:00  CCostelloe


    Rev 1.1    20/05/2003 01:44:12  CCostelloe
  Bug fix: decoder code altered to ensure that any CRLFs inserted by an MTA are
  removed


    Rev 1.0    11/14/2002 02:14:36 PM  JPMugaas
}
unit IdCoder3to4;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoder,
  IdGlobal,
  SysUtils;

type
  TIdDecodeTable = array[1..127] of Byte;

  TIdEncoder3to4 = class(TIdEncoder)
  protected
    FCodingTable: TIdBytes;
    FFillChar: Char;
    function InternalEncode(const ABuffer: TIdBytes): TIdBytes;
  public
    procedure Encode(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1); override;
    property CodingTable: TIdBytes read FCodingTable;
  published
    property FillChar: Char read FFillChar write FFillChar;
  end;

  TIdEncoder3to4Class = class of TIdEncoder3to4;

  TIdDecoder4to3 = class(TIdDecoder)
  protected
    FCodingTable: TIdBytes;
    FDecodeTable: TIdDecodeTable;
    FFillChar: Char;
    function InternalDecode(const ABuffer: TIdBytes; const AIgnoreFiller: Boolean = False): TIdBytes;
  public
    class procedure ConstructDecodeTable(const ACodingTable: String; var ADecodeArray: TIdDecodeTable);
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  published
    property FillChar: Char read FFillChar write FFillChar;
  end;

implementation

uses
  IdException, IdResourceStrings, IdStream;

{ TIdDecoder4to3 }

class procedure TIdDecoder4to3.ConstructDecodeTable(const ACodingTable: string;
  var ADecodeArray: TIdDecodeTable);
var
  c, i: integer;
begin
  //TODO: See if we can find an efficient way, or maybe an option to see if the requested
  //decode char is valid, that is it returns a 255 from the DecodeTable, or at maybe
  //check its presence in the encode table.
  for i := Low(ADecodeArray) to High(ADecodeArray) do begin
    ADecodeArray[i] := $FF;
  end;
  c := 0;
  for i := 1 to Length(ACodingTable) do begin
    ADecodeArray[Ord(ACodingTable[i])] := c;
    Inc(c);
  end;
end;

procedure TIdDecoder4to3.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LBuffer: TIdBytes;
  LBufSize: Integer;
begin
  // No no - this will read the whole thing into memory and what if its MBs?
  // need to load it in smaller buffered chunks MaxInt is WAY too big....
  LBufSize := IndyLength(ASrcStream, ABytes);
  if LBufSize > 0 then begin
    SetLength(LBuffer, LBufSize);
    TIdStreamHelper.ReadBytes(ASrcStream, LBuffer, LBufSize);
    LBuffer := InternalDecode(LBuffer);
    if Assigned(FStream) then begin
      TIdStreamHelper.Write(FStream, LBuffer);
    end;
  end;
end;

function TIdDecoder4to3.InternalDecode(const ABuffer: TIdBytes; const AIgnoreFiller: Boolean): TIdBytes;
var
  LInBufSize: Integer;
  LEmptyBytes: Integer;
  LInBytes: TIdBytes;
  LOutPos: Integer;
  LOutSize: Integer;
  LInLimit: Integer;
  LInPos: Integer;
begin
  SetLength(LInBytes, 4);

  LInPos := 0;

  LInBufSize := Length(ABuffer);
  if (LInBufSize mod 4) <> 0 then begin
    LInLimit := (LInBufSize div 4) * 4;
  end else begin
    LInLimit := LInBufSize;
  end;

  // Presize output buffer
  //CC2, bugfix: was LOutPos := 1;
  LOutPos := 0;
  LOutSize := (LInLimit div 4) * 3;
  SetLength(Result, LOutSize);

  while LInPos < LInLimit do begin
    // Read 4 bytes in for processing
    //CC2 bugfix: was CopyTIdBytes(LIn, LInPos, LInBytes, 0, LInBytesLen);
    //CopyTIdBytes(LIn, LInPos-1, LInBytes, 0, LInBytesLen);
    // Faster than CopyTIdBytes
    LInBytes[0] := ABuffer[LInPos];
    LInBytes[1] := ABuffer[LInPos + 1];
    LInBytes[2] := ABuffer[LInPos + 2];
    LInBytes[3] := ABuffer[LInPos + 3];
    // Inc pointer
    Inc(LInPos, 4);

    // Reduce to 3 bytes
    Result[LOutPos]     := ((FDecodeTable[LInBytes[0]] and 63) shl 2) or ((FDecodeTable[LInBytes[1]] shr 4) and 3);
    Result[LOutPos + 1] := ((FDecodeTable[LInBytes[1]] and 15) shl 4) or ((FDecodeTable[LInBytes[2]] shr 2) and 15);
    Result[LOutPos + 2] := ((FDecodeTable[LInBytes[2]] and 3) shl 6) or (FDecodeTable[LInBytes[3]] and 63);
    Inc(LOutPos, 3);

    // If we dont know how many bytes we need to watch for fill chars. MIME
    // is this way.
    //
    // In best case, the end is not before the end of the input, but the input
    // may be right padded with spaces, or even contain the EOL chars.
    //
    // Because of this we watch for early ends beyond what we originally
    // estimated.
  end;

  // RLebeau: normally, the FillChar does not appear inside the encoded bytes,
  // however UUE/XXE does allow it, where encoded lines are prefixed with the
  // unencoded data lengths instead...
  if (not AIgnoreFiller) and (LInPos > 0) then begin
    if ABuffer[LInPos-1] = Ord(FillChar) then begin
      if ABuffer[LInPos-2] = Ord(FillChar) then begin
        LEmptyBytes := 2;
      end else begin
        LEmptyBytes := 1;
      end;
      SetLength(Result, LOutSize - LEmptyBytes);
    end;
  end;
end;

{ TIdEncoder3to4 }

procedure TIdEncoder3to4.Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1);
var
  LBuffer: TIdBytes;
  LBufSize: Integer;
begin
  // No no - this will read the whole thing into memory and what if its MBs?
  // need to load it in smaller buffered chunks MaxInt is WAY too big....
  LBufSize := IndyLength(ASrcStream, ABytes);
  if LBufSize > 0 then begin
    SetLength(LBuffer, LBufSize);
    TIdStreamHelper.ReadBytes(ASrcStream, LBuffer, LBufSize);
    LBuffer := InternalEncode(LBuffer);
    TIdStreamHelper.Write(ADestStream, LBuffer);
  end;
end;

//TODO: Make this more efficient. Profile it to test, but maybe make single
// calls to ReadBuffer then pull from memory
function TIdEncoder3to4.InternalEncode(const ABuffer: TIdBytes): TIdBytes;
var
  LInBufSize : Integer;
  LOutSize: Integer;
  LLen : integer;
  LPos : Integer;
  LBufDataLen: Integer;
  LIn1, LIn2, LIn3: Byte;
  LSize : Integer;
begin
  LInBufSize := Length(ABuffer);
  LOutSize := ((LInBufSize + 2) div 3) * 4;
  SetLength(Result, LOutSize); // we know that the string will grow by 4/3 adjusted to 3 boundary
  LLen := 0;
  LPos := 0;

  // S.G. 21/10/2003: Copy the relevant bytes into the temporary buffer.
  // S.G. 21/10/2003: Record the data length and force exit loop when necessary
  while LPos < LInBufSize do
  begin
    Assert((LLen + 4) <= LOutSize,
      'TIdEncoder3to4.Encode: Calculated length exceeded (expected '+ {do not localize}
      IntToStr(LOutSize) +
      ', about to go '+                                               {do not localize}
      IntToStr(LLen + 4) +
      ' at offset ' +                                                 {do not localize}
      IntToStr(LPos) +
      ' of '+                                                         {do not localize}
      IntToStr(LInBufSize));

    LBufDataLen := LInBufSize - LPos;
    if LBufDataLen > 2 then begin
      LIn1 := ABuffer[LPos];
      LIn2 := ABuffer[LPos+1];
      LIn3 := ABuffer[LPos+2];
      LSize := 3;
    end
    else if LBufDataLen > 1 then begin
      LIn1 := ABuffer[LPos];
      LIn2 := ABuffer[LPos+1];
      LIn3 := 0;
      LSize := 2;
    end
    else begin
      LIn1 := ABuffer[LPos];
      LIn2 := 0;
      LIn3 := 0;
      LSize := 1;
    end;
    Inc(LPos, LSize);

    //possible to do a better assert than this?
    Assert(Length(FCodingTable)>0);
    Result[LLen]     := FCodingTable[(LIn1 shr 2) and 63];
    Result[LLen + 1] := FCodingTable[(((LIn1 and 3) shl 4) or ((LIn2 shr 4) and 15)) and 63];
    Result[LLen + 2] := FCodingTable[(((LIn2 and 15) shl 2) or ((LIn3 shr 6) and 3)) and 63];
    Result[LLen + 3] := FCodingTable[LIn3 and 63];
    Inc(LLen, 4);

    if LSize < 3 then begin
      Result[LLen-1] := Ord(FillChar);
      if LSize = 1 then begin
         Result[LLen-2] := Ord(FillChar);
      end;
    end;
  end;

  SetLength(Result, LLen);

  Assert(LLen = LOutSize,
    'TIdEncoder3to4.Encode: Calculated length not met (expected ' +  {do not localize}
    IntToStr(LOutSize) +
    ', finished at ' +                                               {do not localize}
    IntToStr(LLen) +
    ', BufSize = ' +                                                 {do not localize}
    IntToStr(LInBufSize));
end;

end.

