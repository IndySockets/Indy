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
  Rev 1.7    10/6/2004 10:47:00 PM  BGooijen
  changed array indexer from 64 to 32 bit, it gave errors in dotnet, and making
  >2GB arrays is not done anyways

  Rev 1.6    2004.05.20 1:39:28 PM  czhower
  Last of the IdStream updates

  Rev 1.5    2004.05.20 11:37:24 AM  czhower
  IdStreamVCL

  Rev 1.4    2004.05.19 3:06:56 PM  czhower
  IdStream / .NET fix

  Rev 1.3    2004.02.03 5:45:50 PM  czhower
  Name changes

  Rev 1.2    1/21/2004 1:19:58 PM  JPMugaas
  InitComponent.

  Rev 1.1    16/01/2004 18:00:26  CCostelloe
  This is now working code.

  Rev 1.0    14/01/2004 00:46:14  CCostelloe
  An implementation of Apple's BinHex4 encoding.  It is a "work-in-progress",
  it does not yet work properly, only checked in as a placeholder.
}

unit IdCoderBinHex4;

{
  Written by Ciaran Costelloe, ccostelloe@flogas.ie, December 2003.
  Based on TIdCoderMIME, derived from TIdCoder3to4, derived from TIdCoder.

  DESCRIPTION:

  This is an implementation of the BinHex 4.0 decoder used particularly by Apple.
  It is defined in RFC 1741.  It is a variant of a 3-to-4 decoder, but it uses
  character 90 for sequences of repeating characters, allowing some compression,
  but thereby not allowing it to be mapped in as another 3-to-4 decoder.
  Per the RFC, it must be encapsulated in a MIME part (it cannot be directly coded
  inline in an email "body"), the part is strictly defined to have a header entry
  (with the appropriate "myfile.ext"):
      Content-Type: application/mac-binhex40; name="myfile.ext"
  After the header, the part MUST start with the text (NOT indented):
      (This file must be converted with BinHex 4.0)
  This allows the option AND the ambiguity of identifying it by either the
  Content-Type OR by the initial text line.  However, it is also stated that any
  text before the specified text line must be ignored, implying the line does not
  have to be the first - an apparent contradiction.
  The encoded file then follows, split with CRLFs (to avoid lines that are too long
  for emails) that must be discarded.
  The file starts with a colon (:), a header, followed by the file contents, and
  ending in another colon.
  There is also an interesting article on the web, "BinHex 4.0 Definition by Peter
  N Lewis, Aug 1991", which has very useful information on what is implemeted in
  practice, and seems to come with the good provenance of bitter experience.

 From RFC 1741:

        1) 8 bit encoding of the file:

    Byte:    Length of FileName (1->63)
    Bytes:   FileName ("Length" bytes)
    Byte:    Version
    Long:    Type
    Long:    Creator
    Word:    Flags (And $F800)
    Long:    Length of Data Fork
    Long:    Length of Resource Fork
    Word:    CRC
    Bytes:   Data Fork ("Data Length" bytes)
    Word:    CRC
    Bytes:   Resource Fork ("Rsrc Length" bytes)
    Word:    CRC

        2) Compression of repetitive characters.

    ($90 is the marker, encoding is made for 3->255 characters)

    00 11 22 33 44 55 66 77   -> 00 11 22 33 44 55 66 77
    11 22 22 22 22 22 22 33   -> 11 22 90 06 33
    11 22 90 33 44            -> 11 22 90 00 33 44

    The whole file is considered as a stream of bits.  This stream will
    be divided in blocks of 6 bits and then converted to one of 64
    characters contained in a table.  The characters in this table have
    been chosen for maximum noise protection.  The format will start
    with a ":" (first character on a line) and end with a ":".
    There will be a maximum of 64 characters on a line.  It must be
    preceded, by this comment, starting in column 1 (it does not start
    in column 1 in this document):

      (This file must be converted with BinHex 4.0)

    Any text before this comment is to be ignored.

    The characters used are:

      !"#$%&'()*+,- 012345689@ABCDEFGHIJKLMNPQRSTUVXYZ[`abcdefhijklmpqr

  IMPLEMENTATION NOTES:

  There are older variants referred to in RFC 1741, but I have only come
  across encodings in current use as separate MIME parts, which this
  implementation is targetted at.

  When encoding into BinHex4, you do NOT have to implement the run-length
  encoding (the character 90 for sequences of repeating characters), and
  this encoder does not do it.  The CRC values generated in the header have
  NOT been tested (because this decoder ignores them).

  The decoder has to allow for the run-length encoding.  The decoder works
  irrespective of whether it is preceded by the identification string
  or not (GBinHex4IdentificationString below).  The string to be decoded must
  include the starting and ending colons.  It can deal with embedded CR and LFs.
  Unlike base64 and quoted-printable, we cannot decode line-by-line cleanly,
  because the lines do not contain a clean number of 4-byte blocks due to the
  first line starting with a colon, leaving 63 bytes on that line, plus you have
  the problem of dealing with the run-length encoding and stripping the header.
  If the attachment only has a data fork, it is saved; if only a resource fork,
  it is saved; if both, only the data fork is saved.  The decoder does NOT
  check that the CRC values are correct.

  Indy units use the content-type to decide if the part is BinHex4:
      Content-Type: application/mac-binhex40; name="myfile.ext"

  WARNING: This code only implements BinHex4.0 when used as a part in a
  MIME-encoded email.  To have a part encoded, set the parts
  ContentTransfer := 'binhex40'.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdException,
  IdCoder,
  IdCoder3to4,
  IdGlobal,
  IdStream,
  SysUtils;

type
  TIdEncoderBinHex4 = class(TIdEncoder3to4)
  protected
    FFileName: String;
    function GetCRC(const ABlock: TIdBytes; const AOffset: Integer = 0; const ASize: Integer = -1): Word;
    procedure AddByteCRC(var ACRC: Word; AByte: Byte);
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    procedure Encode(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1); override;
    //We need to specify this value before calling Encode...
    property FileName: String read FFileName write FFileName;
  end;

  TIdDecoderBinHex4 = class(TIdDecoder4to3)
  protected
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  end;

const
  //Note the 7th characeter is a ' which is represented in a string as ''
  GBinHex4CodeTable: string = '!"#$%&''()*+,-012345689@ABCDEFGHIJKLMNPQRSTUVXYZ[`abcdefhijklmpqr';    {Do not Localize}
  GBinHex4IdentificationString: string = '(This file must be converted with BinHex 4.0)';             {Do not Localize}

type
  EIdMissingColon = class(EIdException);
  EIdMissingFileName = class(EIdException);

var
  GBinHex4DecodeTable: TIdDecodeTable;

implementation

uses
  IdResourceStrings;

{ TIdDecoderBinHex4 }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDecoderBinHex4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDecoderBinHex4.InitComponent;
begin
  inherited InitComponent;
  FDecodeTable := GBinHex4DecodeTable;
  FCodingTable := ToBytes(GBinHex4CodeTable);
  FFillChar := '=';  {Do not Localize}
end;

procedure TIdDecoderBinHex4.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LCopyToPos: integer;
  LIn : TIdBytes;
  LInSize: Integer;
  LOut: TIdBytes;
  LN: Integer;
  LRepetition: Integer;
  LForkLength: Integer;
begin
  LInSize := IndyLength(ASrcStream, ABytes);
  if LInSize <= 0 then begin
    Exit;
  end;

  SetLength(LIn, LInSize);
  TIdStreamHelper.ReadBytes(ASrcStream, LIn, LInSize);

  //We don't need to check if the identification string is present, since the
  //attachment is bounded by a : at the start and end, and the identification
  //string may have been stripped off already.
  //While we are at it, remove all the CRs and LFs...
  LCopyToPos := -1;
  for LN := 0 to LInSize-1 do begin
    if LIn[LN] = 58 then begin  //Ascii 58 is a colon :
      if LCopyToPos = -1 then begin
        //This is the start of the file...
        LCopyToPos := 0;
      end else begin
        //This is the second :, i.e. the end of the file...
        SetLength(LIn, LCopyToPos);
        LCopyToPos := -2; //Flag that we got an end marker
        Break;
      end;
    end else begin
      if (LCopyToPos > -1) and (not ByteIsInEOL(LIn, LN)) then begin
        LIn[LCopyToPos] := LIn[LN];
        Inc(LCopyToPos);
      end;
    end;
  end;

  //did we get the initial colon?
  if LCopyToPos = -1 then begin
    raise EIdMissingColon.Create('Block passed to TIdDecoderBinHex4.Decode is missing a starting colon :');    {Do not Localize}
  end;
  //did we get the terminating colon?
  if LCopyToPos <> -2 then begin
    raise EIdMissingColon.Create('Block passed to TIdDecoderBinHex4.Decode is missing a terminating colon :'); {Do not Localize}
  end;

  if Length(LIn) = 0 then begin
    Exit;
  end;

  LOut := InternalDecode(LIn);

  // Now expand the run-length encoding.
  // $90 is the marker, encoding is made for 3->255 characters
  // 00 11 22 33 44 55 66 77   -> 00 11 22 33 44 55 66 77
  // 11 22 22 22 22 22 22 33   -> 11 22 90 06 33
  // 11 22 90 33 44            -> 11 22 90 00 33 44
  LN := 0;
  while LN < Length(LOut) do begin
    if LOut[LN] = $90 then begin
      LRepetition := LOut[LN+1];
      if LRepetition = 0 then begin
        //90 is by itself, so just remove the 00
        //22 90 00 -> 22 90
        RemoveBytes(LOut, LN+1, 1);
        Inc(LN);  //Move past the $90
      end
      else if LRepetition = 1 then begin
        //Not allowed: 22 90 01 -> 22
        //Throw an exception or deal with it?  Deal with it.
        RemoveBytes(LOut, LN, 2);
      end
      else if LRepetition = 2 then begin
        //Not allowed: 22 90 02 -> 22 22
        //Throw an exception or deal with it?  Deal with it.
        LOut[LN] := LOut[LN-1];
        RemoveBytes(LOut, LN+1, 1);
        Inc(LN);
      end
      else if LRepetition = 3 then begin
        //22 90 03 -> 22 22 22
        LOut[LN] := LOut[LN-1];
        LOut[LN+1] := LOut[LN-1];
        Inc(LN, 2);
      end
      else begin
        //Repetition is 4 to 255: expand the sequence.
        //22 90 04 -> 22 22 22 22
        LOut[LN] := LOut[LN-1];
        LOut[LN+1] := LOut[LN-1];
        ExpandBytes(LOut, LN+2, LRepetition-2, LOut[LN-1]);
        Inc(LN, LRepetition-1);
      end;
    end else begin
      Inc(LN);
    end;
  end;

  //We are not finished yet.  Strip off the header, by calculating the offset
  //of the start of the attachment and it's length.
  LN := 1 + LOut[0];        //Length byte + length of filename
  Inc(LN, 1 + 4 + 4 + 2);   //Version, type, creator, flags
  // TODO: use one of the BytesTo...() functions here instead?
  LForkLength := (((((LOut[LN]*256)+LOut[LN+1])*256)+LOut[LN+2])*256)+LOut[LN+3];
  Inc(LN, 4);               //Go past the data fork length
  if LForkLength = 0 then begin
    //No data fork present, save the resource fork instead...
    // TODO: use one of the BytesTo...() functions here instead?
    LForkLength := (((((LOut[LN]*256)+LOut[LN+1])*256)+LOut[LN+2])*256)+LOut[LN+3];
  end;
  Inc(LN, 4);               //Go past the resource fork length
  Inc(LN, 2);               //CRC

  //At this point, LOut[LN] points to the actual data (the data fork, if there
  //is one, or else the resource fork if there is no data fork).
  if Assigned(FStream) then begin
    TIdStreamHelper.Write(FStream, LOut, LForkLength, LN);
  end;
end;

{ TIdEncoderBinHex4 }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdEncoderBinHex4.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdEncoderBinHex4.InitComponent;
begin
  inherited InitComponent;
  FCodingTable := ToBytes(GBinHex4CodeTable);
  FFillChar := '=';   {Do not Localize}
end;

function TIdEncoderBinHex4.GetCRC(const ABlock: TIdBytes; const AOffset: Integer = 0;
  const ASize: Integer = -1): Word;
var
  LN: Integer;
  LActual: Integer;
begin
  Result := 0;
  LActual := IndyLength(ABlock, ASize, AOffset);
  if LActual > 0 then
  begin
    for LN := 0 to LActual-1 do begin
      AddByteCRC(Result, ABlock[AOffset+LN]);
    end;
  end;
end;

procedure TIdEncoderBinHex4.AddByteCRC(var ACRC: Word; AByte: Byte);
  //BinHex 4.0 uses a 16-bit CRC with an 0x1021 seed.
var
  LWillShiftedOutBitBeA1: boolean;
  LN: integer;
begin
  for LN := 1 to 8 do begin
    LWillShiftedOutBitBeA1 := (ACRC and $8000) <> 0;
    //Shift the CRC left, and add the next bit from our byte...
    ACRC := (ACRC shl 1) or (AByte shr 7);
    if LWillShiftedOutBitBeA1 then begin
      ACRC := ACRC xor $1021;
    end;
    AByte := (AByte shl 1) and $FF;
  end;
end;

procedure TIdEncoderBinHex4.Encode(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1);
var
  LN: Integer;
  LOffset: Integer;
  LBlocks: Integer;
  LOut: TIdBytes;
  LSSize, LTemp: Integer;
  LFileName: {$IFDEF HAS_AnsiString}AnsiString{$ELSE}TIdBytes{$ENDIF};
  LCRC: word;
  LRemainder: integer;
begin
  if FFileName = '' then begin
    raise EIdMissingFileName.Create('Data passed to TIdEncoderBinHex4.Encode is missing a filename');    {Do not Localize}
  end;
  //Read in the attachment first...
  LSSize := IndyLength(ASrcStream, ABytes);
  //BinHex4.0 allows filenames to be only 255 bytes long (because the length
  //is stored in a byte), so truncate the filename to 255 bytes...
  {$IFNDEF HAS_AnsiString}
  LFileName := IndyTextEncoding_OSDefault.GetBytes(FFileName);
  {$ELSE}
    {$IFDEF STRING_IS_UNICODE}
  LFileName := AnsiString(FFileName); // explicit convert to Ansi
    {$ELSE}
  LFileName := FFileName;
    {$ENDIF}
  {$ENDIF}
  if Length(FFileName) > 255 then begin
    SetLength(LFileName, 255);
  end;
  //Construct the header...
  SetLength(LOut, 1+Length(LFileName)+1+4+4+2+4+4+2+LSSize+2);
  LOut[0] := Length(LFileName);               //Length of filename in 1st byte
  for LN := 1 to Length(LFileName) do begin
    LOut[LN] := {$IFNDEF HAS_AnsiString}LFileName[LN-1]{$ELSE}Byte(LFileName[LN]){$ENDIF};
  end;
  LOffset := 1+Length(LFileName);             //Points to byte after filename
  LOut[LOffset] := 0;                         //Version
  Inc(LOffset);
  for LN := 0 to 7 do begin
    LOut[LOffset+LN] := 32;                   //Use spaces for Type & Creator
  end;
  Inc(LOffset, 8);
  LOut[LOffset]   := 0;                       //Flags
  LOut[LOffset+1] := 0;                       //Flags
  Inc(LOffset, 2);
  LTemp := LSSize;
  LOut[LOffset] := LTemp mod 256;             //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+1] := LTemp mod 256;           //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+2] := LTemp mod 256;           //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+3] := LTemp;                   //Length of data fork
  Inc(LOffset, 4);
  LOut[LOffset]   := 0;                       //Length of resource fork
  LOut[LOffset+1] := 0;                       //Length of resource fork
  LOut[LOffset+2] := 0;                       //Length of resource fork
  LOut[LOffset+3] := 0;                       //Length of resource fork
  Inc(LOffset, 4);
  //Next comes the CRC for the header...
  LCRC := GetCRC(LOut, 0, LOffset);
  LOut[LOffset] := LCRC mod 256;              //CRC of data fork
  LCRC := LCRC div 256;
  LOut[LOffset+1] := LCRC;                    //CRC of data fork
  Inc(LOffset, 2);
  //Next comes the data fork (we will not be using the resource fork)...
  //Copy in the attachment...
  TIdStreamHelper.ReadBytes(ASrcStream, LOut, LSSize, LOffset);
  LCRC := GetCRC(LOut, LOffset, LSSize);
  Inc(LOffset, LSSize);
  LOut[LOffset] := LCRC mod 256;              //CRC of data fork
  LCRC := LCRC div 256;
  LOut[LOffset+1] := LCRC;                    //CRC of data fork
  Inc(LOffset, 2);
  //To prepare for the 3to4 encoder, make sure our block is a multiple of 3...
  LSSize := LOffset mod 3;
  if LSSize > 0 then begin
    ExpandBytes(LOut, LOffset, 3-LSSize);
  end;
  //We now need to 3to4 encode LOut...
  //TODO: compress repetitive bytes to "<byte> $90 <run length>"
  LOut := InternalEncode(LOut);
  //Need to add a colon at the start & end of the block...
  InsertByte(LOut, 58, 0);
  AppendByte(LOut, 58);
  //Expand any bare $90 to $90 $00
  LN := 0;
  while LN < Length(LOut) do begin
    if LOut[LN] = $90 then begin
      InsertByte(LOut, 0, LN+1);
      Inc(LN);
    end;
    Inc(LN);
  end;

  WriteStringToStream(ADestStream, GBinHex4IdentificationString + EOL);

  //Put back in our CRLFs.  A max of 64 chars are allowed per line.
  LBlocks := Length(LOut) div 64;
  for LN := 0 to LBlocks-1 do begin
    TIdStreamHelper.Write(ADestStream, LOut, 64, LN*64);
    WriteStringToStream(ADestStream, EOL);
  end;
  LRemainder := Length(LOut) mod 64;
  if LRemainder > 0 then begin
    TIdStreamHelper.Write(ADestStream, LOut, LRemainder, LBlocks*64);
    WriteStringToStream(ADestStream, EOL);
  end;
end;

initialization
  TIdDecoder4to3.ConstructDecodeTable(GBinHex4CodeTable, GBinHex4DecodeTable);
end.

