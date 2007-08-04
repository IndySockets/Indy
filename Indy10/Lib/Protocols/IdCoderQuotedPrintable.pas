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
  Rev 1.20    10/26/2004 11:08:10 PM  JPMugaas
  Updated refs.

  Rev 1.19    27.08.2004 22:03:22  Andreas Hausladen
  Optimized encoders
  speed optimization ("const" for string parameters)

  Rev 1.18    24/08/2004 10:33:44  CCostelloe
  Was too slow (~45 mins for 2MB down to ~1sec)

  Rev 1.17    2004.05.20 1:39:22 PM  czhower
  Last of the IdStream updates

  Rev 1.16    2004.05.20 11:37:10 AM  czhower
  IdStreamVCL

  Rev 1.15    2004.05.20 11:13:14 AM  czhower
  More IdStream conversions

  Rev 1.14    2004.05.19 3:06:54 PM  czhower
  IdStream / .NET fix

  Rev 1.13    2/19/2004 11:52:02 PM  JPMugaas
  Removed IFDEF's.  Moved some functions into IdGlobalProtocols for reuse
  elsewhere.

  Rev 1.12    2004.02.03 5:45:00 PM  czhower
  Name changes

  Rev 1.11    2004.02.03 2:12:06 PM  czhower
  $I path change

  Rev 1.10    1/22/2004 3:59:14 PM  SPerry
  fixed set problems

  Rev 1.9    11/10/2003 7:41:30 PM  BGooijen
  Did all todo's ( TStream to TIdStream mainly )

  Rev 1.8    2003.10.17 6:14:44 PM  czhower
  Fix to match new IdStream

  Rev 1.7    2003.10.12 3:38:26 PM  czhower
  Added path to .inc

  Rev 1.6    10/12/2003 1:33:42 PM  BGooijen
  Compiles on D7 now too

  Rev 1.5    10/12/2003 12:02:50 PM  BGooijen
  DotNet

  Rev 1.4    6/13/2003 12:07:44 PM  JPMugaas
  QP was broken again.

  Rev 1.3    6/13/2003 07:58:50 AM  JPMugaas
  Should now compile with new decoder design.

  Rev 1.2    6/13/2003 06:17:06 AM  JPMugaas
  Should now compil,e.

  Rev 1.1    12.6.2003 ã. 12:00:28  DBondzhev
  Fix for . at the begining of new line

  Rev 1.0    11/14/2002 02:15:00 PM  JPMugaas

 2002-08-13/14 - Johannes Berg
   completely rewrote the Encoder. May do the Decoder later.
   The encoder will add an EOL to the end of the file if it had no EOL
   at start. I can't avoid this due to the design of IdStream.ReadLn,
   but its also no problem, because in transmission this would happen
   anyway.

 9-17-2001 - J. Peter Mugaas
  made the interpretation of =20 + EOL to mean a hard line break
  soft line breaks are now ignored.  It does not make much sense
  in plain text.  Soft breaks do not indicate the end of paragraphs unlike
  hard line breaks that do end paragraphs.

 3-24-2001 - J. Peter Mugaas
  Rewrote the Decoder according to a new design.

 3-25-2001 - J. Peter Mugaas
    Rewrote the Encoder according to the new design
}

unit IdCoderQuotedPrintable;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoder,
  IdStream,
  SysUtils;

type
  TIdDecoderQuotedPrintable = class(TIdDecoder)
  public
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  end;

  TIdEncoderQuotedPrintable = class(TIdEncoder)
  public
    procedure Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1); override;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols;

{ TIdDecoderQuotedPrintable }

procedure TIdDecoderQuotedPrintable.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LBuffer: TIdBytes;
  i : Integer;
  B, DecodedByte : Byte;
  LBufferLen: Integer;
  LBufferIndex: Integer;
  LPos: integer;

  procedure StripEOLChars;
  var
    j: Integer;
  begin
    for j := 1 to 2 do begin
      if (LBufferIndex >= LBufferLen) or (not ByteIsInEOL(LBuffer, LBufferIndex)) then begin
        Break;
      end;
      Inc(LBufferIndex);
    end;
  end;

  function TrimRightWhiteSpace(const ABuf: TIdBytes): TIdBytes;
  var
    LSaveBytes: TIdBytes;
    i, LLen: Integer;
  begin
    SetLength(LSaveBytes, 0);
    LLen := Length(ABuf);
    for i := Length(ABuf)-1 downto 0 do begin
      case ABuf[i] of
        9, 32: ;
        10, 13:
          begin
            //BGO: TODO: Change this
            InsertByte(LSaveBytes, ABuf[i], 0);
          end;
      else
        begin
          Break;
        end;
      end;
      Dec(LLen);
    end;
    SetLength(Result, LLen + Length(LSaveBytes));
    if LLen > 0 then begin
      CopyTIdBytes(ABuf, 0, Result, 0, LLen);
    end;
    if Length(LSaveBytes) > 0 then begin
      CopyTIdBytes(LSaveBytes, 0, Result, LLen, Length(LSaveBytes));
    end;
  end;

begin
  LBufferLen := IndyLength(ASrcStream, ABytes);
  if LBufferLen <= 0 then begin
    Exit;
  end;
  SetLength(LBuffer, LBufferLen);
  TIdStreamHelper.ReadBytes(ASrcStream, LBuffer, LBufferLen);
  { when decoding a Quoted-Printable body, any trailing
  white space on a line must be deleted, - RFC 1521}
  LBuffer := TrimRightWhiteSpace(LBuffer);
  LBufferLen := Length(LBuffer);
  LBufferIndex := 0;
  while LBufferIndex < LBufferLen do begin
    LPos := ByteIndex(Ord('='), LBuffer, LBufferIndex);
    if LPos = -1 then begin
      if Assigned(FStream) then begin
        TIdStreamHelper.Write(FStream, LBuffer, -1, LBufferIndex);
      end;
      Break;
    end;
    if Assigned(FStream) then begin
      TIdStreamHelper.Write(FStream, LBuffer, LPos-LBufferIndex, LBufferIndex);
    end;
    LBufferIndex := LPos+1;
    // process any following hexidecimal representation
    if LBufferIndex < LBufferLen then begin
      i := 0;
      DecodedByte := 0;
      while LBufferIndex < LBufferLen do begin
        B := LBuffer[LBufferIndex];
        case B of
          48..57: //0-9                                           {Do not Localize}
            DecodedByte := (DecodedByte shl 4) or (B - 48);       {Do not Localize}
          65..70: //A-F                                           {Do not Localize}
            DecodedByte := (DecodedByte shl 4) or (B - 65 + 10);  {Do not Localize}
          97..102://a-f                                           {Do not Localize}
            DecodedByte := (DecodedByte shl 4) or (B - 97 + 10);  {Do not Localize}
        else
          Break;
        end;
        Inc(i);
        Inc(LBufferIndex);
        if i > 1 then begin
          Break;
        end;
      end;
      if i > 0 then begin
        //if =20 + EOL, this is a hard line break after a space
        if (DecodedByte = 32) and (LBufferIndex < LBufferLen) and ByteIsInEOL(LBuffer, LBufferIndex) then begin
          if Assigned(FStream) then begin
            WriteStringToStream(FStream, Char(DecodedByte) + EOL);
          end;
          StripEOLChars;
        end else begin
          WriteStringToStream(FStream, Char(DecodedByte));
        end;
      end else begin
        //ignore soft line breaks -
        StripEOLChars;
      end;
    end;
  end;
end;

{ TIdEncoderQuotedPrintable }
procedure TIdEncoderQuotedPrintable.Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1);
const
  SafeChars = [#33..#60, #62..#126];
  HalfSafeChars = [#32, TAB];
  // Rule #2, #3
var
  CurrentLine: ShortString;
  // this is a shortstring for performance reasons.
  // the lines may never get longer than 76, so even if I go a bit
  // further, they won't go longer than 80 or so
  SourceLine: AnsiString;
  CurrentPos: Integer;

  procedure WriteToString(const s: ShortString);
  var
    SLen: Integer;
  begin
    SLen := Length(s);
    MoveChars(s, 1, CurrentLine, CurrentPos, SLen);
    Inc(CurrentPos, SLen);
  end;

  procedure FinishLine;
  begin
    WriteStringToStream(ADestStream, Copy(CurrentLine, 1, CurrentPos-1) + EOL);
    CurrentPos := 1;
  end;

var
  I: Integer;
  LSourceSize: Integer;
begin
  SetLength(CurrentLine, 255);
  //ie while not eof
  LSourceSize := ASrcStream.Size;
  while ASrcStream.Position < LSourceSize do begin
    SourceLine := ReadLnFromStream(ASrcStream, -1, False);
    CurrentPos := 1;
    for i := 1 to Length(SourceLine) do begin
      if not (SourceLine[i] in SafeChars) then
      begin
        if (SourceLine[i] in HalfSafeChars) then begin
          if i = Length(SourceLine) then begin
            WriteToString(CharToHex('=', SourceLine[i]));
          end else begin
            WriteToString(SourceLine[i]);
          end;
        end else begin
          WriteToString(CharToHex('=', SourceLine[i]));
        end;
      end
      else if ((CurrentPos = 1) or (CurrentPos = 71)) and (SourceLine[i] = '.') then begin
        WriteToString(CharToHex('=', SourceLine[i]));
      end else begin
        WriteToString(SourceLine[i]);
      end;
      if CurrentPos > 70 then begin
        WriteToString('=');  {Do not Localize}
        FinishLine;
      end;
    end;
    FinishLine;
  end;
end;

end.
