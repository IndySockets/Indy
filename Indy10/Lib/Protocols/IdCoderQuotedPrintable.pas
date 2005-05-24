{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13760: IdCoderQuotedPrintable.pas 
{
{   Rev 1.20    10/26/2004 11:08:10 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.19    27.08.2004 22:03:22  Andreas Hausladen
{ Optimized encoders
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.18    24/08/2004 10:33:44  CCostelloe
{ Was too slow (~45 mins for 2MB down to ~1sec)
}
{
{   Rev 1.17    2004.05.20 1:39:22 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.16    2004.05.20 11:37:10 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.15    2004.05.20 11:13:14 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.14    2004.05.19 3:06:54 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.13    2/19/2004 11:52:02 PM  JPMugaas
{ Removed IFDEF's.  Moved some functions into IdGlobalProtocols for reuse
{ elsewhere.
}
{
{   Rev 1.12    2004.02.03 5:45:00 PM  czhower
{ Name changes
}
{
{   Rev 1.11    2004.02.03 2:12:06 PM  czhower
{ $I path change
}
{
{   Rev 1.10    1/22/2004 3:59:14 PM  SPerry
{ fixed set problems
}
{
{   Rev 1.9    11/10/2003 7:41:30 PM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.8    2003.10.17 6:14:44 PM  czhower
{ Fix to match new IdStream
}
{
{   Rev 1.7    2003.10.12 3:38:26 PM  czhower
{ Added path to .inc
}
{
{   Rev 1.6    10/12/2003 1:33:42 PM  BGooijen
{ Compiles on D7 now too
}
{
{   Rev 1.5    10/12/2003 12:02:50 PM  BGooijen
{ DotNet
}
{
{   Rev 1.4    6/13/2003 12:07:44 PM  JPMugaas
{ QP was broken again.
}
{
{   Rev 1.3    6/13/2003 07:58:50 AM  JPMugaas
{ Should now compile with new decoder design.
}
{
{   Rev 1.2    6/13/2003 06:17:06 AM  JPMugaas
{ Should now compil,e.
}
{
{   Rev 1.1    12.6.2003 ã. 12:00:28  DBondzhev
{ Fix for . at the begining of new line
}
{
{   Rev 1.0    11/14/2002 02:15:00 PM  JPMugaas
}
unit IdCoderQuotedPrintable;

{
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
  Rewrote the Encoder according to the new design}

interface

uses
  Classes,
  IdCoder,
  IdStreamVCL,
  IdStreamRandomAccess,
  IdObjs,
  IdSys;

type
  TIdDecoderQuotedPrintable = class(TIdDecoder)
  public
    procedure Decode(const AIn: string;
      const AStartPos: Integer = 1; const ABytes: Integer = -1); override;
  end;

  TIdEncoderQuotedPrintable = class(TIdEncoder)
  public
    function Encode(ASrcStream: TIdStreamRandomAccess; const ABytes: integer = MaxInt): string; override;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols;


{ TIdDecoderQuotedPrintable }

procedure TIdDecoderQuotedPrintable.Decode(const AIn: string;
      const AStartPos: Integer = 1; const ABytes: Integer = -1);

var
  LBuffer, LLine : String;
  i : Integer;
  Ch: Char;
  b : Byte;
  LBufferLen: integer;
  LBufferIndex: integer;
  LPos: integer;

  procedure StripEOLChars;
  var
    j: Integer;
  begin
    for j := 1 to Length(sLineBreak) do begin
      if (LBufferIndex <= LBufferLen) and CharIsInEOF(LBuffer, LBufferIndex) then begin
        Inc(LBufferIndex);
      end else begin
        break;
      end;
    end;
  end;

  function TrimRightWhiteSpace(const Str: string): string;
  var
    i, LenStr: Integer;
    LSaveStr: string;
  begin
    LSaveStr := '';
    LenStr := Length(Str);
    i := LenStr;
    while i > 0 do
    begin
      case Str[i] of
        #9, #32: ;
        #10, #13:
          //BGO: TODO: Change this
           Insert(Str[i], LSaveStr, 1);
      else
        Break;
      end;
      Dec(i);
    end;
    if i + Length(LSaveStr) >= LenStr then
      Result := Str
    else
      Result := Copy(Str, 1, i) + LSaveStr;
  end;

begin
  //LLine := '';     {Do not Localize} // for local strings the compiler generates the ":= ''" code.
  { when decoding a Quoted-Printable body, any trailing
  white space on a line must be deleted, - RFC 1521}
  LBuffer := TrimRightWhiteSpace(AIn);
  LBufferLen := Length(LBuffer);
  LBufferIndex := 1;
  while LBufferIndex <= LBufferLen do begin
    LPos := 0;
    for i := LBufferIndex to LBufferLen do begin
      if LBuffer[i] = '=' then begin
        LPos := i;
        break;
      end;
    end;
    if LPos = 0 then begin
      LLine := Copy(LBuffer, LBufferIndex, MAXINT);
      FStream.Write(LLine);
      LBufferIndex := LBufferLen+1;
    end else begin
      LLine := Copy(LBuffer, LBufferIndex, LPos-LBufferIndex);
      FStream.Write(LLine);
      LBufferIndex := LPos+1;
      // process any following hexidecimal representation
      if LBufferIndex <= LBufferLen then begin
        i := 0;
        b := 0;
        while LBufferIndex <= LBufferLen do begin
          Ch := LBuffer[LBufferIndex];
          case Ch of
            '0'..'9':                                       {Do not Localize}
              b := (b shl 4) or (Ord(Ch) - Ord('0'));       {Do not Localize}
            'A'..'F':                                       {Do not Localize}
              b := (b shl 4) or (Ord(Ch) - Ord('A') + 10);  {Do not Localize}
            'a'..'f':                                       {Do not Localize}
              b := (b shl 4) or (Ord(Ch) - Ord('a') + 10);  {Do not Localize}
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
          if (b = 32) and (LBufferIndex <= LBufferLen) and CharIsInEOF(LBuffer, LBufferIndex) then begin
            FStream.Write(Char(b) + EOL);
            StripEOLChars;
          end else begin
            FStream.Write(Char(b));
          end;
        end else begin
          //ignore soft line breaks -
          StripEOLChars;
        end;
      end;
    end;
  end;
end;

{ TIdEncoderQuotedPrintable }
function TIdEncoderQuotedPrintable.Encode(ASrcStream: TIdStreamRandomAccess; const ABytes: integer): string;
const
  SafeChars = [#33..#60, #62..#126];
  HalfSafeChars = [#32, TAB];
  // Rule #2, #3

var
  st: TIdStringList;
  CurrentLine: shortstring;
  // this is a shortstring for performance reasons.
  // the lines may never get longer than 76, so even if I go a bit
  // further, they won't go longer than 80 or so
  SourceLine: AnsiString;
  CurrentPos: integer;

    procedure WriteToString(const s: shortstring);
    var
      SLen: integer;
    begin
      SLen := Length(s);
      MoveChars(s,1, CurrentLine,CurrentPos, SLen);
      Inc(CurrentPos, SLen);
    end;

    Procedure NewLine(const AtPos: integer);
    begin
      if AtPos = CurrentPos then begin
        WriteToString('=');  {Do not Localize}
        st.Add(Copy(CurrentLine, 1, CurrentPos-1));
        CurrentPos := 1;
      end else begin
        st.Add(Copy(CurrentLine, 1, AtPos-1)+'='); { Do not Localize }
        CurrentPos := CurrentPos-AtPos+1;
        MoveChars(CurrentLine, AtPos, CurrentLine, 1, CurrentPos-1);
      end;
    end;

    Procedure FinishLine;
    begin
      st.Add(Copy(CurrentLine, 1, CurrentPos - 1));
      CurrentPos := 1;
    end;

var
  i: integer;
  PossibleBreakPos: integer;
  SourceLen: integer;
begin
  st := TIdStringList.Create;
  SetLength(CurrentLine, 255);
  try
    while not ASrcStream.EOF do begin
      SourceLine := ASrcStream.ReadLn(-1, False);
      PossibleBreakPos := 1;
      CurrentPos := 1;
      SourceLen := length(SourceLine);
      for i := 1 to SourceLen do begin
        if CurrentPos < 72 then begin
          PossibleBreakPos := CurrentPos;
        end;
        if not (SourceLine[i] in SafeChars) then begin
          if (SourceLine[i] in HalfSafeChars) then begin
            if i = SourceLen then begin
              WriteToString(CharToHex('=',SourceLine[i]));
            end else begin
              WriteToString(SourceLine[i]);
            end;
          end else begin
            WriteToString(CharToHex('=',SourceLine[i]));
          end;
        end else begin
          if (CurrentPos = 1) and (SourceLine[i] = '.') then begin
            WriteToString(CharToHex('=',SourceLine[i]));
          end else begin
            WriteToString(SourceLine[i]);
          end;
        end;
        if CurrentPos > 74 then begin
          NewLine(PossibleBreakPos);
          PossibleBreakPos := 1;
        end;
      end;
      FinishLine;
    end;
    Result := st.Text;
  finally
    Sys.FreeAndNil(st);
  end;
end;

end.
