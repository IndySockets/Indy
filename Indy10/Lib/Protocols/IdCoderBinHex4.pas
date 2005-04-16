{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  54505: IdCoderBinHex4.pas 
{
{   Rev 1.7    10/6/2004 10:47:00 PM  BGooijen
{ changed array indexer from 64 to 32 bit, it gave errors in dotnet, and making
{ >2GB arrays is not done anyways
}
{
{   Rev 1.6    2004.05.20 1:39:28 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.5    2004.05.20 11:37:24 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.4    2004.05.19 3:06:56 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.3    2004.02.03 5:45:50 PM  czhower
{ Name changes
}
{
{   Rev 1.2    1/21/2004 1:19:58 PM  JPMugaas
{ InitComponent.
}
{
{   Rev 1.1    16/01/2004 18:00:26  CCostelloe
{ This is now working code.
}
{
{   Rev 1.0    14/01/2004 00:46:14  CCostelloe
{ An implementation of Apple's BinHex4 encoding.  It is a "work-in-progress",
{ it does not yet work properly, only checked in as a placeholder.
}
unit IdCoderBinHex4;

{
Written by Ciaran Costelloe, ccostelloe@flogas.ie, December 2003.  Based on
TIdCoderMIME, derived from TIdCoder3to4, derived from TIdCoder.

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
--------------------------------------------------------------------
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

--------------------------------------------------------------------
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

--------------------------------------------------------------------
}

interface

uses
  Classes,
  IdCoder, IdCoder3to4, IdGlobal, IdStream, IdStreamRandomAccess,
  SysUtils;

type
  TIdEncoderBinHex4 = class(TIdEncoder3to4)
  protected
    function GetCRC(ABlock: TIdBytes): word;
    procedure AddByteCRC(var ACRC: word; AByte: Byte);
    procedure InitComponent; override;
  public
    //We cannot override Encode because we need different parameters...
    procedure EncodeFile(AFileName: string; ASrcStream: TIdStreamRandomAccess; ADestStream: TIdStream);
  end;
  TIdDecoderBinHex4 = class(TIdDecoder4to3)
  protected
    procedure InitComponent; override;
  public
    procedure Decode(const AIn: string; const AStartPos: Integer = 1;
     const ABytes: Integer = -1); override;
  end;

const
  //Note the 7th characeter is a ' which is represented in a string as ''
  GBinHex4CodeTable: string = '!"#$%&''()*+,-012345689@ABCDEFGHIJKLMNPQRSTUVXYZ[`abcdefhijklmpqr';    {Do not Localize}
  GBinHex4IdentificationString: string = '(This file must be converted with BinHex 4.0)';             {Do not Localize}

type
  EIdMissingColon = class(Exception);

var
  GBinHex4DecodeTable: TIdDecodeTable;

implementation

uses
  IdException, IdResourceStrings, IdStreamVCL;

{ TIdDecoderBinHex4 }

procedure TIdDecoderBinHex4.InitComponent;
begin
  inherited;
  FDecodeTable := GBinHex4DecodeTable;
  FCodingTable := GBinHex4CodeTable;
  FFillChar := '=';  {Do not Localize}
end;

procedure TIdDecoderBinHex4.Decode(const AIn: string; const AStartPos: Integer = 1;
  const ABytes: Integer = -1);
var
  LCopyToPos: integer;
  LIn : TIdBytes;
  LOut: TIdBytes;
  LN: integer;
  LM: integer;
  LRepetition: integer;
  LForkLength: integer;
begin
  if AIn = '' then Exit;
  LIn := ToBytes(AIn);

  //We don't need to check if the identification string is present, since the
  //attachment is bounded by a : at the start and end, and the identification
  //string may have been stripped off already.
  //While we are at it, remove all the CRs and LFs...
  LCopyToPos := -1;
  for LN := 0 to Length(LIn)-1 do begin
    if LIn[LN] = 58 then begin  //Ascii 58 is a colon :
      if LCopyToPos = -1 then begin
        //This is the start of the file...
        LCopyToPos := 0;
      end else begin
        //This is the second :, i.e. the end of the file...
        SetLength(Lin, LCopyToPos);
        LCopyToPos := -2; //Flag that we got an end marker
        break;
      end;
    end else begin
      if LCopyToPos > -1 then begin
        if ((LIn[LN] <> 13) and (LIn[LN] <> 10)) then begin
          LIn[LCopyToPos] := LIn[LN];
          Inc(LCopyToPos);
        end;
      end;
    end;
  end;
  //Did we get the start and end : ?
  if LCopyToPos = -1 then begin
    //We did not get the initial :
    raise EIdMissingColon.Create('Block passed to TIdDecoderBinHex4.Decode is missing a starting colon :');    {Do not Localize}
  end else if LCopyToPos <> -2 then begin
    //We did not get the terminating :
    raise EIdMissingColon.Create('Block passed to TIdDecoderBinHex4.Decode is missing a terminating colon :'); {Do not Localize}
  end;

  if Length(LIn) = 0 then Exit;
  LOut := InternalDecode(LIn, AStartPos, ABytes);

  //Now expand the run-length encoding.
  //$90 is the marker, encoding is made for 3->255 characters
  // 00 11 22 33 44 55 66 77   -> 00 11 22 33 44 55 66 77
  // 11 22 22 22 22 22 22 33   -> 11 22 90 06 33
  // 11 22 90 33 44            -> 11 22 90 00 33 44
  LN := 0;
  while LN < Length(LOut) do begin
    if LOut[LN] = $90 then begin
      if LOut[LN+1] = 0 then begin
        //The 90 is followed by an 00, so it is just a 90.  Remove the 00.
        for LM := LN+1 to Length(LOut)- 2 do begin
          LOut[LM] := LOut[LM+1];
        end;
        SetLength(LOut, Length(LOut)-1);
        Inc(LN);  //Move past the $90
      end else begin
        LRepetition := LOut[LN+1];
        if LRepetition = 1 then begin
          //Not allowed: 22 90 01 -> 22
          //Throw an exception or deal with it?  Deal with it.
          for LM := LN to Length(LOut)- 3 do begin
            LOut[LM] := LOut[LM+2];
          end;
          SetLength(LOut, Length(LOut)-2);
        end else if LRepetition = 2 then begin
          //Not allowed: 22 90 02 -> 22 22
          //Throw an exception or deal with it?  Deal with it.
          LOut[LN] := LOut[LN-1];
          for LM := LN + 1 to Length(LOut)- 2 do begin
            LOut[LM] := LOut[LM+1];
          end;
          SetLength(LOut, Length(LOut)-1);
          Inc(LN);
        end else if LRepetition = 3 then begin
          //22 90 03 -> 22 22 22
          LOut[LN] := LOut[LN-1];
          LOut[LN+1] := LOut[LN-1];
          Inc(LN, 2);
        end else begin
          //Repetition is 4 to 255: expand the sequence.
          //22 90 04 -> 22 22 22 22
          SetLength(LOut, Length(Lout) + LRepetition - 3);
          //Move up the bytes AFTER our 22 90 04...
          for LM := Length(LOut)-1 downto LN+2 do begin
            LOut[LM] := LOut[LM-(LRepetition-3)];
          end;
          //Now that we have the space, expand our 22 90 04
          for LM := LN to LN+LRepetition-2 do begin
            LOut[LM] := LOut[LN-1];
          end;
          Inc(LN, LRepetition - 1);
        end;
      end;
    end else begin
      Inc(LN);
    end;
  end;
  //We are not finished yet.  Strip off the header, by calculating the offset
  //of the start of the attachment and it's length.
  LN := 1 + LOut[0];        //Length byte + length of filename
  Inc(LN, 1 + 4 + 4 + 2);   //Version, type, creator, flags
  LForkLength := (((((LOut[LN]*256)+LOut[LN+1])*256)+LOut[LN+2])*256)+LOut[LN+3];
  Inc(LN, 4);               //Go past the data fork length
  if LForkLength = 0 then begin
    //No data fork present, save the resource fork instead...
    LForkLength := (((((LOut[LN]*256)+LOut[LN+1])*256)+LOut[LN+2])*256)+LOut[LN+3];
  end;
  Inc(LN, 4);               //Go past the resource fork length
  Inc(LN, 2);               //CRC

  //At this point, LOut[LN] points to the actual data (the data fork, if there
  //is one, or else the resource fork if there is no data fork).
  for LM := 0 to LForkLength-1 do begin
    LOut[LM] := LOut[LM+LN];
  end;
  SetLength(LOut, LForkLength);
  FStream.Write(LOut);
end;

{ TIdEncoderBinHex4 }

procedure TIdEncoderBinHex4.InitComponent;
begin
  inherited;
  FCodingTable := GBinHex4CodeTable;
  FFillChar := '=';   {Do not Localize}
end;

function TIdEncoderBinHex4.GetCRC(ABlock: TIdBytes): word;
var
  LCRC: word;
  LN: integer;
begin
  LCRC := 0;
  for LN := 0 to Length(ABlock) do begin
    AddByteCRC(LCRC, ABlock[LN]);
  end;
  Result := LCRC;
end;

procedure TIdEncoderBinHex4.AddByteCRC(var ACRC: word; AByte: Byte);
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

procedure TIdEncoderBinHex4.EncodeFile(AFileName: string; ASrcStream: TIdStreamRandomAccess; ADestStream: TIdStream);
var
  LN: integer;
  LM: integer;
  LOffset: integer;
  LBlocks: integer;
  LOut: TIdBytes;
  LSSize, LTemp: Int64;
  LFile: TIdBytes;
  LFileName: string;
  LCRC: word;
  LOutgoing: TIdBytes;
  LRemainder: integer;
begin
  //Read in the attachment first...
  LSSize := ASrcStream.Size;
  SetLength(LFile, LSSize);
  ASrcStream.ReadBytes(LFile, LSSize);
  //BinHex4.0 allows filenames to be only 255 bytes long (because the length
  //is stored in a byte), so truncate the filename to 255 bytes...
  if Length(AFileName) > 255 then begin
    LFileName := Copy(AFileName, 1, 255);
  end else begin
    LFileName := AFileName;
  end;
  //Construct the header...
  SetLength(LOut, 1+Length(LFileName)+1+4+4+2+4+4);
  LOut[0] := Length(LFileName);               //Length of filename is 1st byte
  for LN := 1 to Length(LFileName) do begin
    LOut[LN] := Byte(LFileName[LN]);
  end;
  LOffset := Length(LFileName)+1;             //Points to byte after filename
  LOut[LOffset] := 0;                         //Version
  for LN := 1 to 8 do begin
    LOut[LOffset+LN] := 32;                   //Use spaces for Type & Creator
  end;
  LOut[LOffset+9] := 0;                       //Flags
  LOut[LOffset+10] := 0;                      //Flags
  LTemp := LSSize;
  LOut[LOffset+14] := LTemp mod 256;          //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+13] := LTemp mod 256;          //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+12] := LTemp mod 256;          //Length of data fork
  LTemp := LTemp div 256;
  LOut[LOffset+11] := LTemp;                  //Length of data fork
  LOut[LOffset+15] := 0;                      //Length of resource fork
  LOut[LOffset+16] := 0;                      //Length of resource fork
  LOut[LOffset+17] := 0;                      //Length of resource fork
  LOut[LOffset+18] := 0;                      //Length of resource fork
  //Next comes the CRC for the header...
  LCRC := GetCRC(LOut);
  SetLength(LOut, Length(LOut)+2);
  LOut[LOffset+20] := LCRC mod 256;           //CRC of data fork
  LCRC := LCRC div 256;
  LOut[LOffset+19] := LCRC;                   //CRC of data fork
  //Next comes the data fork (we will not be using the resource fork)...
  SetLength(LOut, Length(LOut) + LSSize + 2); //2 for the CRC
  LOffset := LOffset + 21;  //LOut[LOffset] now points to where the attachment goes
  //Copy in the attachment...
  LN := 0;
  while LN < LSSize do begin
    LOut[LN+LOffset] := LFile[LN];
    LN := LN+1;
  end;
  LCRC := GetCRC(LFile);
  SetLength(LFile, 0);
  LOffset := LOffset + LSSize;
  LOut[LOffset+1] := LCRC mod 256;            //CRC of data fork
  LCRC := LCRC div 256;
  LOut[LOffset] := LCRC;                      //CRC of data fork
  //To prepare for the 3to4 encoder, make sure our block is a multiple of 3...
  LOffset := Length(LOut) mod 3;
  if LOffset > 0 then begin
    SetLength(LOut, Length(LOut)+3-LOffset);
  end;
  //We now need to 3to4 encode LOut...
  LOutgoing := EncodeIdBytes(LOut);
  SetLength(LOut, 0);  //Free memory
  //Need to add a colon at the start & end of the block...
  LSSize := Length(LOutgoing);
  SetLength(LOutgoing, Length(LOutgoing)+2);
  LN := LSSize;
  while LN >= 0 do begin
    LOutGoing[LN] := LOutgoing[LN-1];
    LN := LN-1;
  end;
  LOutgoing[0] := 58;                    //58 = :
  LOutgoing[Length(LOutgoing)-1] := 58;  //58 = :
  //Expand any 90 to 90 00
  LN := 0;
  while LN < Length(LOutgoing) do begin
    if LOutgoing[LN] = $90 then begin
      SetLength(LOutgoing, Length(LOutgoing)+1);
      LM := Length(LOutgoing)-1;
      while LM > LN + 1 do begin
       LOutgoing[LM] := LOutgoing[LM-1];
        Dec(LM);
      end;
      LOutgoing[LN+1] := 0;
    end;
    Inc(LN);
  end;

  ADestStream.Write(GBinHex4IdentificationString + EOL);
  //Put back in our CRLFs.  A max of 64 chars are allowed per line.
  LBlocks := Length(LOutgoing); //The number of complete 64-char blocks
  LBlocks := LBlocks div 64; //The number of complete 64-char blocks
  SetLength(LOut, 64+2);
  for LN := 0 to LBlocks-1 do begin
    LOffset := LN*64;
    for LM := 0 to 63 do begin
      LOut[LM] := LOutgoing[LM+LOffset];
    end;
    LOut[64] := 13;
    LOut[65] := 10;
    ADestStream.Write(LOut, 64+2);
  end;
  LRemainder := Length(LOutgoing) mod 64;
  if LRemainder > 0 then begin
    SetLength(LOut, LRemainder+2);
    LOffset := LBlocks*64;
    for LM := 0 to LRemainder-1 do begin
      LOut[LM] := LOutgoing[LM+LOffset];
    end;
    LOut[LRemainder] := 13;
    LOut[LRemainder+1] := 10;
    ADestStream.Write(LOut, LRemainder+2);
  end;
end;

initialization
  TIdDecoder4to3.ConstructDecodeTable(GBinHex4CodeTable, GBinHex4DecodeTable);
end.

