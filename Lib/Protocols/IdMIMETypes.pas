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
  Rev 1.1    2004.02.03 5:44:08 PM  czhower
  Name changes

  Rev 1.0    11/13/2002 07:57:36 AM  JPMugaas

2000-Mar-27 Pete Mee
 - ReturnMIMETypes should return the most relevant MIME type+encoding pair
   to the values passed - i.e., removes x- where it is unnecessary & modifies
   the type if it is known to be incorrect.  (Stupid-)Example:
   application/octet-stream + x-base64 should be application/octet-stream +
   base64... Warning: this file is expected to grow to become mainly constants!!
}

unit IdMIMETypes;

interface
{$i IdCompilerDefines.inc}

const
  MIMESplit = '/';    {Do not Localize}
  MIMEXVal = 'x-';    {Do not Localize}

  MIMETypeApplication = 'application' + MIMESplit;    {Do not Localize}
  MIMETypeAudio = 'audio' + MIMESplit;    {Do not Localize}
  MIMETypeImage = 'image' + MIMESplit;    {Do not Localize}
  MIMETypeMessage = 'message' + MIMESplit;    {Do not Localize}
  MIMETypeMultipart = 'multipart' + MIMESplit;    {Do not Localize}
  MIMETypeText = 'text' + MIMESplit;    {Do not Localize}
  MIMETypeVideo = 'video' + MIMESplit;    {Do not Localize}
  MaxMIMEType = 6;

  // MIME Sub-Types
  MIMESubOctetStream = 'octet-stream';    {Do not Localize}
  MIMESubMacBinHex40 = 'mac-binhex40';    {Do not Localize}
  MaxMIMESubTypes = 1;

  // BinToASCII
  MIMEEncBase64 = 'base64'; // Correct MIME type    {Do not Localize}
  MIMEEncUUEncode = MIMEXVal + 'uu'; // A guess...    {Do not Localize}
  MIMEEncXXEncode = MIMEXVal + 'xx'; // A guess...    {Do not Localize}
  MaxMIMEBinToASCIIType = 2;

  // Message Digests - a MIME type probably doesn't exist for these...    {Do not Localize}
  MIMEEncRSAMD2 = MIMEXVal + 'rsa-md2';    {Do not Localize}
  MIMEEncRSAMD4 = MIMEXVal + 'rsa-md4';    {Do not Localize}
  MIMEEncRSAMD5 = MIMEXVal + 'rsa-md5';    {Do not Localize}
  MIMEEncNISTSHA = MIMEXVal + 'nist-sha';    {Do not Localize}
  MaxMIMEMessageDigestType = 3;

  // Compression Types
  MIMEEncRLECompress = MIMEXVal + 'rle-compress'; // Probably doesn't exist    {Do not Localize}
  MaxMIMECompressType = 0;

  MaxMIMEEncType = MaxMIMEBinToASCIIType + MaxMIMEMessageDigestType + 1 + MaxMIMECompressType + 1;

  // Only put long, frequent full values in. Keep this list short, otherwise
  // it'll be a nightmare & produce HUGE .exe files with LARGE useless    {Do not Localize}
  // sections (the above is bad enough on it's own!).    {Do not Localize}
  MIMEFullApplicationOctetStream = MIMETypeApplication + MIMESubOctetStream;

  // Returns true if matched, false if not.  If true, vars may be altered.
  function ReturnMIMEType(var MediaType, EncType : String) : Boolean;

var
   MIMEMediaType : array [0..MaxMIMEType] of String;

implementation

uses
  IdGlobal,
  IdGlobalProtocols;

function ReturnMIMEType(var MediaType, EncType : String) : Boolean;
var
  MType, SType, EType : String;
  i : LongWord;
begin
  i := IndyPos(MIMESplit, MediaType);
  MType := Copy(MediaType, 1, i);
  SType := Copy(MediaType, i + 1, MaxInt);
  EType := EncType;

  i := PosInStrArray(MType, MIMEMediaType, False);
  case i of
    0 : begin end; // MIMETypeApplication - application/
    1 : begin end; // MIMETypeAudio - audio/
    2 : begin end; // MIMETypeImage - image/
    3 : begin end; // MIMETypeMessage - message/
    4 : begin end; // MIMETypeMultipart - multipart/
    5 : begin end; // MIMETypeText - text/
    6 : begin end; // MIMETypeVideo - video/
    else
      begin
        if TextStartsWith(MType, MIMEXVal) then begin
          i := PosInStrArray(Copy(MType, 3, MaxInt), MIMEMediaType, False);
          case i of
            0 :
              begin
                // MIMETypeApplication - application/
                MType := MIMETypeApplication;
              end;
            1 :
              begin
                // MIMETypeAudio - audio/
                MType := MIMETypeAudio;
              end;
            2 :
              begin
                // MIMETypeImage - image/
                MType := MIMETypeImage;
              end;
            3 :
              begin
                // MIMETypeMessage - message/
                MType := MIMETypeMessage;
              end;
            4 :
              begin
                // MIMETypeMultipart - multipart/
                MType := MIMETypeMultipart;
              end;
            5 :
              begin
                // MIMETypeText - text/
                MType := MIMETypeText;
              end;
            6 :
              begin
                // MIMETypeVideo - video/
                MType := MIMETypeVideo;
              end;
          end;
        end;
      end;
  end;

  Result := False;
end;

initialization
  MIMEMediaType[0] := MIMETypeApplication;
  MIMEMediaType[1] := MIMETypeAudio;
  MIMEMediaType[2] := MIMETypeImage;
  MIMEMediaType[3] := MIMETypeMessage;
  MIMEMediaType[4] := MIMETypeMultipart;
  MIMEMediaType[5] := MIMETypeText;
  MIMEMediaType[6] := MIMETypeVideo;
end.
