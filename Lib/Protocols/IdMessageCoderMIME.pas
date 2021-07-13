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
  Rev 1.37    26/03/2005 19:20:10  CCostelloe
  Fixes for "uneven size" exception

  Rev 1.36    27.08.2004 22:03:58  Andreas Hausladen
  speed optimization ("const" for string parameters)

  Rev 1.35    8/15/04 5:41:00 PM  RLebeau
  Updated GetAttachmentFilename() to handle cases where Outlook puts spaces
  between "name=" and the filename.

  Updated CheckAndSetType() to retreive the filename before checking the type.
  This helps to detect all file attachments better, including "form-data"
  attachments

  Rev 1.34    8/11/04 1:32:52 AM  RLebeau
  Bug fix for TIdMessageDecoderMIME.GetAttachmentFilename()

  Rev 1.33    8/10/04 1:41:48 PM  RLebeau
  Misc. tweaks

    Rev 1.32    6/11/2004 9:38:22 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.31    6/4/04 12:41:04 PM  RLebeau
  ContentTransferEncoding bug fix

  Rev 1.30    29/05/2004 21:23:56  CCostelloe
  Added support for decoding attachments with a Content-Transfer-Encoding of
  binary

  Rev 1.29    2004.05.20 1:39:12 PM  czhower
  Last of the IdStream updates

  Rev 1.28    2004.05.20 11:36:56 AM  czhower
  IdStreamVCL

  Rev 1.27    2004.05.20 11:13:00 AM  czhower
  More IdStream conversions

  Rev 1.26    2004.05.19 3:06:40 PM  czhower
  IdStream / .NET fix

  Rev 1.25    16/05/2004 18:55:26  CCostelloe
  New TIdText/TIdAttachment processing

  Rev 1.24    23/04/2004 20:50:24  CCostelloe
  Paths removed from attachment filenames and invalid Windows filename chars
  weeded out

  Rev 1.23    04/04/2004 17:44:56  CCostelloe
  Bug fix

  Rev 1.22    03/04/2004 20:27:22  CCostelloe
  Fixed bug where code assumed Content-Type always contained a filename for the
  attachment.

  Rev 1.21    2004.02.03 5:44:04 PM  czhower
  Name changes

  Rev 1.20    1/31/2004 3:12:48 AM  JPMugaas
  Removed dependancy on Math unit.  It isn't needed and is problematic in some
  versions of Dlephi which don't include it.

  Rev 1.19    1/22/2004 4:02:52 PM  SPerry
  fixed set problems

  Rev 1.18    16/01/2004 17:42:56  CCostelloe
  Added support for BinHex 4.0 encoding

  Rev 1.17    5/12/2003 9:18:26 AM  GGrieve
  use WriteStringToStream

  Rev 1.16    5/12/2003 12:31:16 AM  GGrieve
  Fis WriteBuffer - can't be used in DotNet

    Rev 1.15    10/17/2003 12:40:20 AM  DSiders
  Added localization comments.

  Rev 1.14    05/10/2003 16:41:54  CCostelloe
  Restructured MIME boundary outputting

  Rev 1.13    29/09/2003 13:07:48  CCostelloe
  Second RandomRange replaced with Random

  Rev 1.12    28/09/2003 22:56:30  CCostelloe
  TIdMessageEncoderInfoMIME.InitializeHeaders now only sets ContentType if it
  is ''

  Rev 1.11    28/09/2003 21:06:52  CCostelloe
  Recoded RandomRange to Random to suit D% and BCB5

  Rev 1.10    26/09/2003 01:05:42  CCostelloe
  Removed FIndyMultiPartAlternativeBoundary, IFndyMultiPartRelatedBoundary - no
  longer needed.  Added support for ContentTransferEncoding '8bit'.  Changed
  nested MIME decoding from finding boundary to finding 'multipart/'.

  Rev 1.9    04/09/2003 20:46:38  CCostelloe
  Added inclusion of =_ in boundary generation in
  TIdMIMEBoundaryStrings.GenerateStrings

  Rev 1.8    30/08/2003 18:39:58  CCostelloe
  MIME boundaries changed to be random strings

  Rev 1.7    07/08/2003 00:56:48  CCostelloe
  ReadBody altered to allow lines over 16K (arises with long html parts)

  Rev 1.6    2003.06.14 11:08:10 PM  czhower
  AV fix

  Rev 1.5    6/14/2003 02:46:42 PM  JPMugaas
  Kudzu wanted the BeginDecode called after LDecoder was created and EndDecode
  to be called just before LDecoder was destroyed.

    Rev 1.4    6/14/2003 1:14:12 PM  BGooijen
  fix for the bug where the attachments are empty

  Rev 1.3    6/13/2003 07:58:46 AM  JPMugaas
  Should now compile with new decoder design.

  Rev 1.2    5/23/03 11:24:06 AM  RLebeau
  Fixed a compiler error for previous changes

  Rev 1.1    5/23/03 9:51:18 AM  RLebeau
  Fixed bug where message body is parsed incorrectly when MIMEBoundary is empty.

  Rev 1.0    11/13/2002 07:57:08 AM  JPMugaas

  2003-Oct-04 Ciaran Costelloe
    Moved boundary out of InitializeHeaders into TIdMessage.GenerateHeader
}

unit IdMessageCoderMIME;

// for all 3 to 4s:
// TODO: Predict output sizes and presize outputs, then use move on
// presized outputs when possible, or presize only and reposition if stream

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent,
  IdMessageCoder,
  IdMessage,
  IdGlobal;

type
  TIdMessageDecoderMIME = class(TIdMessageDecoder)
  protected
    FFirstLine: string;
    FProcessFirstLine: Boolean;
    FBodyEncoded: Boolean;
    FMIMEBoundary: string;
    function GetProperHeaderItem(const Line: string): string;
    procedure InitComponent; override;
  public
    constructor Create(AOwner: TComponent; const ALine: string); reintroduce; overload;
    function ReadBody(ADestStream: TStream; var VMsgEnd: Boolean): TIdMessageDecoder; override;
    procedure CheckAndSetType(const AContentType, AContentDisposition: string);
    procedure ReadHeader; override;
    function GetAttachmentFilename(const AContentType, AContentDisposition: string): string;
    function RemoveInvalidCharsFromFilename(const AFilename: string): string;
    //
    property MIMEBoundary: string read FMIMEBoundary write FMIMEBoundary;
    property BodyEncoded: Boolean read FBodyEncoded write FBodyEncoded;
  end;

  TIdMessageDecoderInfoMIME = class(TIdMessageDecoderInfo)
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; override;
  end;

  TIdMessageEncoderMIME = class(TIdMessageEncoder)
  public
    procedure Encode(ASrc: TStream; ADest: TStream); override;
  end;

  TIdMessageEncoderInfoMIME = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
    procedure InitializeHeaders(AMsg: TIdMessage); override;
  end;

  TIdMIMEBoundaryStrings = class
  public
    class function GenerateRandomChar: Char;
    class function GenerateBoundary: String;
  end;

  TIdMIMEFilenamePathDelimiterAction = (actTruncatePath, actReplaceWithUnderscore);

var
  DecodeFilenamePathDelimiterAction: TIdMIMEFilenamePathDelimiterAction = actReplaceWithUnderscore;

implementation

uses
  IdCoder, IdCoderMIME, IdException, IdGlobalProtocols, IdResourceStrings,
  IdCoderQuotedPrintable, IdCoderBinHex4, IdCoderHeader, SysUtils;

type
  {
  RLebeau: TIdMessageDecoderMIMEIgnore is a private class used when
  TIdMessageDecoderInfoMIME.CheckForStart() detects an ending MIME boundary
  for a finished message part that has nested parts in it.  This is a dirty
  hack to allow TIdMessageClient to skip the boundary line properly, or else
  the line ends up as spare data in the TIdMessage.Body property, which is
  not desired.  A better solution to signal TIdMessageClient to ignore the
  line needs to be found later.
  }

  TIdMessageDecoderMIMEIgnore = class(TIdMessageDecoder)
  public
    function ReadBody(ADestStream: TStream; var VMsgEnd: Boolean): TIdMessageDecoder; override;
    procedure ReadHeader; override;
  end;

function TIdMessageDecoderMIMEIgnore.ReadBody(ADestStream: TStream; var VMsgEnd: Boolean): TIdMessageDecoder;
begin
  VMsgEnd := False;
  Result := nil;
end;

procedure TIdMessageDecoderMIMEIgnore.ReadHeader;
begin
  FPartType := mcptIgnore;
end;

{ TIdMIMEBoundaryStrings }

class function TIdMIMEBoundaryStrings.GenerateRandomChar: Char;
var
  LOrd: integer;
  LFloat: Double;
begin
  if RandSeed = 0 then begin
    Randomize;
  end;
  {Allow only digits (ASCII 48-57), upper-case letters (65-90) and lowercase
  letters (97-122), which is 62 possible chars...}
  LFloat := (Random * 61) + 1.5;  //Gives us 1.5 to 62.5
  LOrd := Trunc(LFloat) + 47;  //(1..62) -> (48..109)
  if LOrd > 83 then begin
    LOrd := LOrd + 13;  {Move into lowercase letter range}
  end else if LOrd > 57 then begin
    Inc(LOrd, 7);  {Move into upper-case letter range}
  end;
  Result := Chr(LOrd);
end;

{This generates a random MIME boundary.}
class function TIdMIMEBoundaryStrings.GenerateBoundary: String;
const
  {Generate a string 34 characters long (34 is a whim, not a requirement)...}
  BoundaryLength = 34;
var
  LN: Integer;
  LFloat: Double;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(BoundaryLength);
  {$ELSE}
  Result := StringOfChar(' ', BoundaryLength);
  {$ENDIF}
  for LN := 1 to BoundaryLength do begin
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB.Append(GenerateRandomChar);
    {$ELSE}
    Result[LN] := GenerateRandomChar;
    {$ENDIF}
  end;
  {CC2: RFC 2045 recommends including "=_" in the boundary, insert in random location...}
  LFloat := (Random * (BoundaryLength-2)) + 1.5;  //Gives us 1.5 to Length-0.5
  LN := Trunc(LFloat);  // 1 to Length-1 (we are inserting a 2-char string)
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB[LN-1] := '=';
  LSB[LN] := '_';
  Result := LSB.ToString;
  {$ELSE}
  Result[LN] := '=';
  Result[LN+1] := '_';
  {$ENDIF}
end;

{ TIdMessageDecoderInfoMIME }

function TIdMessageDecoderInfoMIME.CheckForStart(ASender: TIdMessage;
 const ALine: string): TIdMessageDecoder;
var
  LContentTransferEncoding: string;
begin
  Result := nil;
  if ASender.MIMEBoundary.Boundary <> '' then begin
    if TextIsSame(ALine, '--' + ASender.MIMEBoundary.Boundary) then begin    {Do not Localize}
      Result := TIdMessageDecoderMIME.Create(ASender);
    end
    else if TextIsSame(ALine, '--' + ASender.MIMEBoundary.Boundary + '--') then begin    {Do not Localize}
      ASender.MIMEBoundary.Pop;
      Result := TIdMessageDecoderMIMEIgnore.Create(ASender);
    end;
  end;
  if (Result = nil) and (ASender.ContentTransferEncoding <> '') then begin
    LContentTransferEncoding := ExtractHeaderItem(ASender.ContentTransferEncoding);
    if IsHeaderMediaType(ASender.ContentType, 'multipart') and {do not localize}
       (PosInStrArray(LContentTransferEncoding, ['7bit', '8bit', 'binary'], False) = -1) then {do not localize}
    begin
      Exit;
    end;
    if (PosInStrArray(LContentTransferEncoding, ['base64', 'quoted-printable'], False) <> -1) then begin {Do not localize}
      Result := TIdMessageDecoderMIME.Create(ASender, ALine);
    end;
  end;
end;

{ TIdMessageDecoderMIME }

constructor TIdMessageDecoderMIME.Create(AOwner: TComponent; const ALine: string);
begin
  inherited Create(AOwner);
  FFirstLine := ALine;
  FProcessFirstLine := True;
end;

function TIdMessageDecoderMIME.ReadBody(ADestStream: TStream; var VMsgEnd: Boolean): TIdMessageDecoder;
var
  LContentType, LContentTransferEncoding: string;
  LDecoder: TIdDecoder;
  LLine: string;
  LBinaryLineBreak: string;
  LBuffer: string;  //Needed for binhex4 because cannot decode line-by-line.
  LIsThisTheFirstLine: Boolean; //Needed for binary encoding
  LBoundaryStart, LBoundaryEnd: string;
  LIsBinaryContentTransferEncoding: Boolean;
  LEncoding: IIdTextEncoding;
begin
  LIsThisTheFirstLine := True;
  VMsgEnd := False;
  Result := nil;
  if FBodyEncoded then begin
    LContentType := TIdMessage(Owner).ContentType;
    LContentTransferEncoding := ExtractHeaderItem(TIdMessage(Owner).ContentTransferEncoding);
  end else begin
    LContentType := FHeaders.Values['Content-Type']; {Do not Localize}
    LContentTransferEncoding := ExtractHeaderItem(FHeaders.Values['Content-Transfer-Encoding']); {Do not Localize}
  end;
  if LContentTransferEncoding = '' then begin
    // RLebeau 04/08/2014: According to RFC 2045 Section 6.1:
    // "Content-Transfer-Encoding: 7BIT" is assumed if the
    // Content-Transfer-Encoding header field is not present."
    if IsHeaderMediaType(LContentType, 'application/mac-binhex40') then begin  {Do not Localize}
      LContentTransferEncoding := 'binhex40'; {do not localize}
    end
    else if not IsHeaderMediaType(LContentType, 'application/octet-stream') then begin  {Do not Localize}
      LContentTransferEncoding := '7bit'; {do not localize}
    end;
  end
  else if IsHeaderMediaType(LContentType, 'multipart') then {do not localize}
  begin
    // RLebeau 08/17/09 - According to RFC 2045 Section 6.4:
    // "If an entity is of type "multipart" the Content-Transfer-Encoding is not
    // permitted to have any value other than "7bit", "8bit" or "binary"."
    //
    // However, came across one message where the "Content-Type" was set to
    // "multipart/related" and the "Content-Transfer-Encoding" was set to
    // "quoted-printable".  Outlook and Thunderbird were apparently able to parse
    // the message correctly, but Indy was not.  So let's check for that scenario
    // and ignore illegal "Content-Transfer-Encoding" values if present...
    if PosInStrArray(LContentTransferEncoding, ['7bit', '8bit', 'binary'], False) = -1 then begin {do not localize}
      LContentTransferEncoding := '';
    end;
  end;

  if TextIsSame(LContentTransferEncoding, 'base64') then begin {Do not Localize}
    LDecoder := TIdDecoderMIMELineByLine.Create(nil);
  end else if TextIsSame(LContentTransferEncoding, 'quoted-printable') then begin {Do not Localize}
    LDecoder := TIdDecoderQuotedPrintable.Create(nil);
  end else if TextIsSame(LContentTransferEncoding, 'binhex40') then begin {Do not Localize}
    LDecoder := TIdDecoderBinHex4.Create(nil);
  end else begin
    LDecoder := nil;
  end;

  try
    if LDecoder <> nil then begin
      LDecoder.DecodeBegin(ADestStream);
    end;

    if MIMEBoundary <> '' then begin
      LBoundaryStart := '--' + MIMEBoundary; {Do not Localize}
      LBoundaryEnd := LBoundaryStart + '--'; {Do not Localize}
    end;

    if LContentTransferEncoding <> '' then begin
      case PosInStrArray(LContentTransferEncoding, ['7bit', 'quoted-printable', 'base64', '8bit', 'binary'], False) of {do not localize}
        0..2: LIsBinaryContentTransferEncoding := False;
        3..4: LIsBinaryContentTransferEncoding := True;
      else
        // According to RFC 2045 Section 6.4:
        // "Any entity with an unrecognized Content-Transfer-Encoding must be
        // treated as if it has a Content-Type of "application/octet-stream",
        // regardless of what the Content-Type header field actually says."
        LIsBinaryContentTransferEncoding := True;
        LContentTransferEncoding := '';
      end;
    end else begin
      LIsBinaryContentTransferEncoding := True;
    end;

    repeat
      if not FProcessFirstLine then begin
        EnsureEncoding(LEncoding, enc8Bit);
        if LIsBinaryContentTransferEncoding then begin
          // For binary, need EOL because the default LF causes spurious CRs in the output...
          // TODO: don't use ReadLnRFC() for binary data at all.  Read into an intermediate
          // buffer instead, looking for the next MIME boundary and message terminator while
          // flushing the buffer to the destination stream along the way.  Otherwise, at the
          // very least, we need to detect the type of line break used (CRLF vs bare-LF) so
          // we can duplicate it correctly in the output.  Most systems use CRLF, per the RFCs,
          // but have seen systems use bare-LF instead...
          LLine := ReadLnRFC(VMsgEnd, EOL, '.', LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF}); {do not localize}
          LBinaryLineBreak := EOL; // TODO: detect the actual line break used
        end else begin
          LLine := ReadLnRFC(VMsgEnd, LF, '.', LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF}); {do not localize}
        end;
      end else begin
        LLine := FFirstLine;
        FFirstLine := '';    {Do not Localize}
        FProcessFirstLine := False;
        // Do not use ADELIM since always ends with . (standard)
        if LLine = '.' then begin {Do not Localize}
          VMsgEnd := True;
          Break;
        end;
        if TextStartsWith(LLine, '..') then begin
          Delete(LLine, 1, 1);
        end;
      end;
      if VMsgEnd then begin
        Break;
      end;
      // New boundary - end self and create new coder
      if MIMEBoundary <> '' then begin
        if TextIsSame(LLine, LBoundaryStart) then begin
          Result := TIdMessageDecoderMIME.Create(Owner);
          Break;
          // End of all coders (not quite ALL coders)
        end;
        if TextIsSame(LLine, LBoundaryEnd) then begin
          // POP the boundary
          if Owner is TIdMessage then begin
            TIdMessage(Owner).MIMEBoundary.Pop;
          end;
          Break;
        end;
      end;
      if LDecoder = nil then begin
        // Data to save, but not decode
        if Assigned(ADestStream) then begin
          EnsureEncoding(LEncoding, enc8Bit);
        end;
        if LIsBinaryContentTransferEncoding then begin {do not localize}
          //In this case, we have to make sure we dont write out an EOL at the
          //end of the file.
          if LIsThisTheFirstLine then begin
            LIsThisTheFirstLine := False;
          end else begin
            if Assigned(ADestStream) then begin
              WriteStringToStream(ADestStream, LBinaryLineBreak, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
            end;
          end;
          if Assigned(ADestStream) then begin
            WriteStringToStream(ADestStream, LLine, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
          end;
        end else begin
          if Assigned(ADestStream) then begin
            WriteStringToStream(ADestStream, LLine + EOL, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
          end;
        end;
      end
      else begin
        // Data to decode
        if LDecoder is TIdDecoderQuotedPrintable then begin
          // For TIdDecoderQuotedPrintable, we have to make sure all EOLs are intact
          LDecoder.Decode(LLine + EOL);
        end else if LDecoder is TIdDecoderBinHex4 then begin
          // We cannot decode line-by-line because lines don't have a whole
          // number of 4-byte blocks due to the : inserted at the start of
          // the first line, so buffer the file...
          // TODO: flush the buffer periodically when it has enough blocks
          // in it, otherwise we are buffering the entire file in memory
          // before decoding it...
          LBuffer := LBuffer + LLine;
        end else if LLine <> '' then begin
          LDecoder.Decode(LLine);
        end;
      end;
    until False;
    if LDecoder <> nil then begin
      if LDecoder is TIdDecoderBinHex4 then begin
        //Now decode the complete block...
        LDecoder.Decode(LBuffer);
      end;
      LDecoder.DecodeEnd;
    end;
  finally
    FreeAndNil(LDecoder);
  end;
end;

function TIdMessageDecoderMIME.GetAttachmentFilename(const AContentType, AContentDisposition: string): string;
var
  LValue: string;
begin
  LValue := ExtractHeaderSubItem(AContentDisposition, 'filename', QuoteMIME); {do not localize}
  if LValue = '' then begin
    // Get filename from Content-Type
    LValue := ExtractHeaderSubItem(AContentType, 'name', QuoteMIME); {do not localize}
  end;
  if Length(LValue) > 0 then begin
    Result := RemoveInvalidCharsFromFilename(DecodeHeader(LValue));
  end else begin
    Result := '';
  end;
end;

procedure TIdMessageDecoderMIME.CheckAndSetType(const AContentType, AContentDisposition: string);
begin
  {The new world order: Indy now defines a TIdAttachment as a part that either has
  a filename, or else does NOT have a ContentType starting with text/ or multipart/.
  Anything left is a TIdText.}

  {RLebeau 3/28/2006: RFC 2183 states that inlined text can have
  filenames as well, so do NOT treat inlined text as attachments!}

  //WARNING: Attachments may not necessarily have filenames, and Text parts may have filenames!
  FFileName := GetAttachmentFilename(AContentType, AContentDisposition);

  {see what type the part is...}
  if IsHeaderMediaTypes(AContentType, ['text', 'multipart']) and {do not localize}
    (not IsHeaderValue(AContentDisposition, 'attachment')) then {do not localize}
  begin
    // TODO: According to RFC 2045 Section 6.4:
    // "Any entity with an unrecognized Content-Transfer-Encoding must be
    // treated as if it has a Content-Type of "application/octet-stream",
    // regardless of what the Content-Type header field actually says."
    FPartType := mcptText;
  end else begin
    FPartType := mcptAttachment;
  end;
end;

function TIdMessageDecoderMIME.GetProperHeaderItem(const Line: string): string;
var
  LPos, Idx, LLen: Integer;
begin
  LPos := Pos(':', Line);
  if LPos = 0 then begin // the header line is invalid
    Result := Line;
    Exit;
  end;

  Idx := LPos - 1;
  while (Idx > 0) and (Line[Idx] = ' ') do begin
    Dec(Idx);
  end;

  LLen := Length(Line);
  Inc(LPos);
  while (LPos <= LLen) and (Line[LPos] = ' ') do begin
    Inc(LPos);
  end;

  Result := Copy(Line, 1, Idx) + '=' + Copy(Line, LPos, MaxInt);
end;

procedure TIdMessageDecoderMIME.ReadHeader;
var
  ABoundary,
  s: string;
  LLine: string;
  LMsgEnd: Boolean;

begin
  if FBodyEncoded then begin // Read header from the actual message since body parts don't exist    {Do not Localize}
    CheckAndSetType(TIdMessage(Owner).ContentType, TIdMessage(Owner).ContentDisposition);
  end else begin
    // Read header
    repeat
      LLine := ReadLnRFC(LMsgEnd);
      if LMsgEnd then begin // TODO: abnormal situation (Masters!)    {Do not Localize}
        FPartType := mcptEOF;
        Exit;
      end;//if
      if LLine = '' then begin
        Break;
      end;
      if CharIsInSet(LLine, 1, LWS) then begin
        if FHeaders.Count > 0 then begin
          FHeaders[FHeaders.Count - 1] := FHeaders[FHeaders.Count - 1] + ' ' + TrimLeft(LLine);    {Do not Localize}
        end else begin
          //Make sure you change 'Content-Type :' to 'Content-Type:'
          FHeaders.Add(GetProperHeaderItem(TrimLeft(LLine))); {Do not Localize}
        end;
      end else begin
        //Make sure you change 'Content-Type :' to 'Content-Type:'
        FHeaders.Add(GetProperHeaderItem(LLine));    {Do not Localize}
      end;
    until False;
    s := FHeaders.Values['Content-Type'];    {do not localize}
    //CC: Need to detect on "multipart" rather than boundary, because only the
    //"multipart" bit will be visible later...
    if IsHeaderMediaType(s, 'multipart') then begin  {do not localize}
      ABoundary := ExtractHeaderSubItem(s, 'boundary', QuoteMIME);  {do not localize}
      if Owner is TIdMessage then begin
        if Length(ABoundary) > 0 then begin
          TIdMessage(Owner).MIMEBoundary.Push(ABoundary, TIdMessage(Owner).MessageParts.Count);
          // Also update current boundary
          FMIMEBoundary := ABoundary;
        end else begin
          //CC: We are in trouble.  A multipart MIME Content-Type with no boundary?
          //Try pushing the current boundary...
          TIdMessage(Owner).MIMEBoundary.Push(FMIMEBoundary, TIdMessage(Owner).MessageParts.Count);
        end;
      end;
    end;
    CheckAndSetType(FHeaders.Values['Content-Type'],    {do not localize}
      FHeaders.Values['Content-Disposition']);    {do not localize}
  end;
end;

function TIdMessageDecoderMIME.RemoveInvalidCharsFromFilename(const AFilename: string): string;
const
  // MtW: Inversed: see http://support.microsoft.com/default.aspx?scid=kb;en-us;207188
  InvalidWindowsFilenameChars = '\/:*?"<>|'; {do not localize}
var
  LN, LIdx: Integer;
  LChar: Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  Result := AFilename;
  //First, strip any Windows or Unix path...
  if DecodeFilenamePathDelimiterAction = actTruncatePath then begin
    for LN := Length(Result) downto 1 do begin
      if ((Result[LN] = '/') or (Result[LN] = '\')) then begin  {do not localize}
        Result := Copy(Result, LN+1, MaxInt);
        Break;
      end;
    end;
  end;
  //Now remove any invalid filename chars.
  //Hmm - this code will be less buggy if I just replace them with _
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(Result);
  for LN := 0 to LSB.Length-1 do begin
    // MtW: WAS: if Pos(Result[LN], ValidWindowsFilenameChars) = 0 then begin
    // TODO: use CharIsInSet() instead?
    LChar := LSB[LN];
    for LIdx := 1 to Length(InvalidWindowsFilenameChars) do begin
      if InvalidWindowsFilenameChars[LIdx] = LChar then begin
        LSB[LN] := '_';    {do not localize}
        Break;
      end;
    end;
  end;
  {$ELSE}
  for LN := 1 to Length(Result) do begin
    // MtW: WAS: if Pos(Result[LN], ValidWindowsFilenameChars) = 0 then begin
    // TODO: use CharIsInSet() instead?
    LChar := Result[LN];
    for LIdx := 1 to Length(InvalidWindowsFilenameChars) do begin
      if InvalidWindowsFilenameChars[LIdx] = LChar then begin
        Result[LN] := '_';    {do not localize}
        Break;
      end;
    end;
  end;
  {$ENDIF}
end;

{ TIdMessageEncoderInfoMIME }

constructor TIdMessageEncoderInfoMIME.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderMIME;
end;

procedure TIdMessageEncoderInfoMIME.InitializeHeaders(AMsg: TIdMessage);
begin
  {CC2: The following logic does not work - it assumes that just because there
  are related parts, that the message header is multipart/related, whereas it
  could be multipart/related inside multipart/alternative, plus there are other
  issues.
  But...it works on simple emails, and it is better than throwing an exception.
  User must specify the ContentType to get the right results.}
  {CC4: removed addition of boundaries; now added at GenerateHeader stage (could
  end up with boundary added more than once)}
  if AMsg.ContentType = '' then begin
    if AMsg.MessageParts.RelatedPartCount > 0 then begin
      AMsg.ContentType := 'multipart/related; type="multipart/alternative"';  //; boundary="' + {do not localize}
    end else begin
      if AMsg.MessageParts.AttachmentCount > 0 then begin
        AMsg.ContentType := 'multipart/mixed'; //; boundary="' {do not localize}
      end else begin
        if AMsg.MessageParts.TextPartCount > 0 then begin
          AMsg.ContentType := 'multipart/alternative';  //; boundary="' {do not localize}
        end;
      end;
    end;
  end;
end;

{ TIdMessageEncoderMIME }

procedure TIdMessageEncoderMIME.Encode(ASrc: TStream; ADest: TStream);
var
  s: string;
  LEncoder: TIdEncoderMIME;
  LSPos, LSSize : TIdStreamSize;
begin
  ASrc.Position := 0;
  LSPos := 0;
  LSSize := ASrc.Size;
  LEncoder := TIdEncoderMIME.Create(nil);
  try
    while LSPos < LSSize do begin
      s := LEncoder.Encode(ASrc, 57) + EOL;
      Inc(LSPos, 57);
      WriteStringToStream(ADest, s);
    end;
  finally
    FreeAndNil(LEncoder);
  end;
end;

procedure TIdMessageDecoderMIME.InitComponent;
begin
  inherited InitComponent;
  FBodyEncoded := False;
  if Owner is TIdMessage then begin
    FMIMEBoundary := TIdMessage(Owner).MIMEBoundary.Boundary;
    {CC2: Check to see if this is an email of the type that is headers followed
    by the body encoded in base64 or quoted-printable.  The problem with this type
    is that the header may state it as MIME, but the MIME parts and their headers
    will be encoded, so we won't find them - in this case, we will later take
    all the info we need from the message header, and not try to take it from
    the part header.}
    if TIdMessage(Owner).ContentTransferEncoding <> '' then begin
      // RLebeau 12/26/2014 - According to RFC 2045 Section 6.4:
      // "If an entity is of type "multipart" the Content-Transfer-Encoding is not
      // permitted to have any value other than "7bit", "8bit" or "binary"."
      //
      // However, came across one message where the "Content-Type" was set to
      // "multipart/related" and the "Content-Transfer-Encoding" was set to
      // "quoted-printable".  Outlook and Thunderbird were apparently able to parse
      // the message correctly, but Indy was not.  So let's check for that scenario
      // and ignore illegal "Content-Transfer-Encoding" values if present...
      if (not IsHeaderMediaType(TIdMessage(Owner).ContentType, 'multipart')) and
        {CC2: added 8bit below, changed to TextIsSame.  Reason is that many emails
        set the Content-Transfer-Encoding to 8bit, have multiple parts, and display
        the part header in plain-text.}
         (not IsHeaderValue(TIdMessage(Owner).ContentTransferEncoding, ['8bit', '7bit', 'binary']))    {do not localize}
      then begin
        FBodyEncoded := True;
      end;
    end;
  end;
end;

initialization
  TIdMessageDecoderList.RegisterDecoder('MIME'    {Do not Localize}
   , TIdMessageDecoderInfoMIME.Create);
  TIdMessageEncoderList.RegisterEncoder('MIME'    {Do not Localize}
   , TIdMessageEncoderInfoMIME.Create);
finalization

end.
