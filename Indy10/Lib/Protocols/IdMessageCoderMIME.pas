{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11673: IdMessageCoderMIME.pas
{
{   Rev 1.37    26/03/2005 19:20:10  CCostelloe
{ Fixes for "uneven size" exception
}
{
{   Rev 1.36    27.08.2004 22:03:58  Andreas Hausladen
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.35    8/15/04 5:41:00 PM  RLebeau
{ Updated GetAttachmentFilename() to handle cases where Outlook puts spaces
{ between "name=" and the filename.
{ 
{ Updated CheckAndSetType() to retreive the filename before checking the type. 
{ This helps to detect all file attachments better, including "form-data"
{ attachments
}
{
{   Rev 1.34    8/11/04 1:32:52 AM  RLebeau
{ Bug fix for TIdMessageDecoderMIME.GetAttachmentFilename()
}
{
{   Rev 1.33    8/10/04 1:41:48 PM  RLebeau
{ Misc. tweaks
}
{
    Rev 1.32    6/11/2004 9:38:22 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.31    6/4/04 12:41:04 PM  RLebeau
{ ContentTransferEncoding bug fix
}
{
{   Rev 1.30    29/05/2004 21:23:56  CCostelloe
{ Added support for decoding attachments with a Content-Transfer-Encoding of
{ binary
}
{
{   Rev 1.29    2004.05.20 1:39:12 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.28    2004.05.20 11:36:56 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.27    2004.05.20 11:13:00 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.26    2004.05.19 3:06:40 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.25    16/05/2004 18:55:26  CCostelloe
{ New TIdText/TIdAttachment processing
}
{
{   Rev 1.24    23/04/2004 20:50:24  CCostelloe
{ Paths removed from attachment filenames and invalid Windows filename chars
{ weeded out
}
{
{   Rev 1.23    04/04/2004 17:44:56  CCostelloe
{ Bug fix
}
{
{   Rev 1.22    03/04/2004 20:27:22  CCostelloe
{ Fixed bug where code assumed Content-Type always contained a filename for the
{ attachment.
}
{
{   Rev 1.21    2004.02.03 5:44:04 PM  czhower
{ Name changes
}
{
{   Rev 1.20    1/31/2004 3:12:48 AM  JPMugaas
{ Removed dependancy on Math unit.  It isn't needed and is problematic in some
{ versions of Dlephi which don't include it.
}
{
{   Rev 1.19    1/22/2004 4:02:52 PM  SPerry
{ fixed set problems
}
{
{   Rev 1.18    16/01/2004 17:42:56  CCostelloe
{ Added support for BinHex 4.0 encoding
}
{
{   Rev 1.17    5/12/2003 9:18:26 AM  GGrieve
{ use WriteStringToStream
}
{
{   Rev 1.16    5/12/2003 12:31:16 AM  GGrieve
{ Fis WriteBuffer - can't be used in DotNet
}
{
    Rev 1.15    10/17/2003 12:40:20 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.14    05/10/2003 16:41:54  CCostelloe
{ Restructured MIME boundary outputting
}
{
{   Rev 1.13    29/09/2003 13:07:48  CCostelloe
{ Second RandomRange replaced with Random
}
{
{   Rev 1.12    28/09/2003 22:56:30  CCostelloe
{ TIdMessageEncoderInfoMIME.InitializeHeaders now only sets ContentType if it
{ is ''
}
{
{   Rev 1.11    28/09/2003 21:06:52  CCostelloe
{ Recoded RandomRange to Random to suit D% and BCB5
}
{
{   Rev 1.10    26/09/2003 01:05:42  CCostelloe
{ Removed FIndyMultiPartAlternativeBoundary, IFndyMultiPartRelatedBoundary - no
{ longer needed.  Added support for ContentTransferEncoding '8bit'.  Changed
{ nested MIME decoding from finding boundary to finding 'multipart/'.
}
{
{   Rev 1.9    04/09/2003 20:46:38  CCostelloe
{ Added inclusion of =_ in boundary generation in
{ TIdMIMEBoundaryStrings.GenerateStrings
}
{
{   Rev 1.8    30/08/2003 18:39:58  CCostelloe
{ MIME boundaries changed to be random strings
}
{
{   Rev 1.7    07/08/2003 00:56:48  CCostelloe
{ ReadBody altered to allow lines over 16K (arises with long html parts)
}
{
{   Rev 1.6    2003.06.14 11:08:10 PM  czhower
{ AV fix
}
{
{   Rev 1.5    6/14/2003 02:46:42 PM  JPMugaas
{ Kudzu wanted the BeginDecode called after LDecoder was created and EndDecode
{ to be called just before LDecoder was destroyed.
}
{
    Rev 1.4    6/14/2003 1:14:12 PM  BGooijen
  fix for the bug where the attachments are empty
}
{
{   Rev 1.3    6/13/2003 07:58:46 AM  JPMugaas
{ Should now compile with new decoder design.
}
{
{   Rev 1.2    5/23/03 11:24:06 AM  RLebeau
{ Fixed a compiler error for previous changes
}
{
{   Rev 1.1    5/23/03 9:51:18 AM  RLebeau
{ Fixed bug where message body is parsed incorrectly when MIMEBoundary is empty.
}
{
{   Rev 1.0    11/13/2002 07:57:08 AM  JPMugaas
}
unit IdMessageCoderMIME;

{
  2003-Oct-04 Ciaran Costelloe
    Moved boundary out of InitializeHeaders into TIdMessage.GenerateHeader
}

// for all 3 to 4s:
//// TODO: Predict output sizes and presize outputs, then use move on
// presized outputs when possible, or presize only and reposition if stream

interface

uses
  Classes,
  IdMessageCoder,
  IdMessage,
  IdStream,
  IdStreamRandomAccess,
  IdSys;

type
  TIdMessageDecoderMIME = class(TIdMessageDecoder)
  protected
    FFirstLine: string;
    FBodyEncoded: Boolean;
    FMIMEBoundary: string;
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; const ALine: string); reintroduce; overload;
    function ReadBody(ADestStream: TIdStream;
      var VMsgEnd: Boolean): TIdMessageDecoder; override;
    procedure CheckAndSetType(AContentType, AContentDisposition: string);
    procedure ReadHeader; override;
    function GetAttachmentFilename(AContentType, AContentDisposition: string): string;
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
    procedure Encode(ASrc: TIdStreamRandomAccess; ADest: TIdStream); override;
  end;

  TIdMessageEncoderInfoMIME = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
    procedure InitializeHeaders(AMsg: TIdMessage); override;
  end;

  TIdMIMEBoundaryStrings = class
  private
    {CC2: After recoding SendBody et al, dont need FIndyMultiPartAlternativeBoundary
    or FIndyMultiPartRelatedBoundary.}
    FIndyMIMEBoundary: string;
    //FIndyMultiPartAlternativeBoundary: string;
    //FIndyMultiPartRelatedBoundary: string;
    procedure GenerateStrings;
  public
    function GenerateRandomChar: Char;
    function IndyMIMEBoundary: string;
    //function IndyMultiPartAlternativeBoundary: string;
    //function IndyMultiPartRelatedBoundary: string;
  end;

var
  //Note the following is created in the initialization section, so that the
  //overhead of boundary creation is only done at most once per session...
  IdMIMEBoundaryStrings: TIdMIMEBoundaryStrings;

const
  //NOTE: If you used IndyMIMEBoundary, just prefix it with "IdMIMEBoundaryStrings." now.
  //IndyMIMEBoundary                 = '=_NextPart_2rfkindysadvnqw3nerasdf'; {do not localize}
  //IndyMultiPartAlternativeBoundary = '=_NextPart_2altrfkindysadvnqw3nerasdf'; {do not localize}
  //IndyMultiPartRelatedBoundary     = '=_NextPart_2relrfksadvnqindyw3nerasdf'; {do not localize}
  MIMEGenericText = 'text/'; {do not localize}
  MIMEGenericMultiPart = 'multipart/'; {do not localize}
  MIME7Bit = '7bit'; {do not localize}
  {Per Microsoft KnowledgeBase article KB 177506, the following are the only Windows chars permitted:}
  ValidWindowsFilenameChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890^&''@{}[],$=!-#()%.+~_'; {do not localize}

implementation

uses
  IdCoder, IdCoderMIME, IdGlobal, IdException, IdGlobalProtocols, IdResourceStrings,
  IdCoderQuotedPrintable, IdCoderBinHex4,  IdCoderHeader;

{ TIdMIMEBoundaryStrings }
function TIdMIMEBoundaryStrings.GenerateRandomChar: Char;
var
  LOrd: integer;
  LFloat: Double;
begin
  {Allow only digits (ASCII 48-57), Sys.UpperCase letters (65-90) and lowercase
  letters (97-122), which is 62 possible chars...}
  LFloat := (Random* 61) + 1.5;  //Gives us 1.5 to 62.5
  LOrd := Trunc(LFloat)+47;  //(1..62) -> (48..109)
  if LOrd > 83 then begin
    LOrd := LOrd + 13;  {Move into lowercase letter range}
  end else if LOrd > 57 then begin
    LOrd := LOrd + 7;  {Move into Sys.UpperCase letter range}
  end;
  Result := Chr(LOrd);
end;

procedure TIdMIMEBoundaryStrings.GenerateStrings;
{This generates random MIME boundaries.  They are only generated once each time
a program containing this unit is run.}
var
  LN: integer;
  LFloat: Double;
begin
  {Generate a string 34 characters long (34 is a whim, not a requirement)...}
  FIndyMIMEBoundary := '1234567890123456789012345678901234';  {do not localize}
  Randomize;
  for LN := 1 to Length(FIndyMIMEBoundary) do begin
    FIndyMIMEBoundary[LN] := GenerateRandomChar;
  end;
  {CC2: RFC 2045 recommends including "=_" in the boundary, insert in random location...}
  //LN := RandomRange(1,Length(FIndyMIMEBoundary)-1);
  LFloat := (Random * (Length(FIndyMIMEBoundary)-2)) + 1.5;  //Gives us 1.5 to Length-0.5
  LN := Trunc(LFloat);  // 1 to Length-1 (we are inserting a 2-char string)
  FIndyMIMEBoundary[LN] := '=';
  FIndyMIMEBoundary[LN+1] := '_';
  {The Alternative boundary is the same with a random lowercase letter added...}
  //FIndyMultiPartAlternativeBoundary := FIndyMIMEBoundary + Chr(RandomRange(97,122));
  {The Related boundary is the same with a random Sys.UpperCase letter added...}
  //FIndyMultiPartRelatedBoundary     := FIndyMultiPartAlternativeBoundary + Chr(RandomRange(65,90));
end;

function TIdMIMEBoundaryStrings.IndyMIMEBoundary: string;
begin
  if FIndyMIMEBoundary = '' then begin
    GenerateStrings;
  end;
  Result := FIndyMIMEBoundary;
end;
{
function TIdMIMEBoundaryStrings.IndyMultiPartAlternativeBoundary: string;
begin
  if FIndyMIMEBoundary = '' then begin
    GenerateStrings;
  end;
  Result := FIndyMultiPartAlternativeBoundary;
end;
}
{
function TIdMIMEBoundaryStrings.IndyMultiPartRelatedBoundary: string;
begin
  if FIndyMIMEBoundary = '' then begin
    GenerateStrings;
  end;
  Result := FIndyMultiPartRelatedBoundary;
end;
}
{ TIdMessageDecoderInfoMIME }
function TIdMessageDecoderInfoMIME.CheckForStart(ASender: TIdMessage;
 const ALine: string): TIdMessageDecoder;
begin
  if ASender.MIMEBoundary.Boundary <> '' then begin
    if TextIsSame(ALine, '--' + ASender.MIMEBoundary.Boundary) then begin    {Do not Localize}
      Result := TIdMessageDecoderMIME.Create(ASender);
    end else if TextIsSame(ASender.ContentTransferEncoding, 'base64') or    {Do not Localize}
      TextIsSame(ASender.ContentTransferEncoding, 'quoted-printable') then begin    {Do not Localize}
        Result := TIdMessageDecoderMIME.Create(ASender, ALine);
    end else begin
      Result := nil;
    end;
  end else begin
    Result := nil;
  end;
end;

{ TIdCoderMIME }

constructor TIdMessageDecoderMIME.Create(AOwner: TComponent);
begin
  inherited;
  FBodyEncoded := False;
  if AOwner is TIdMessage then begin
    FMIMEBoundary := TIdMessage(AOwner).MIMEBoundary.Boundary;
    {CC2: Check to see if this is an email of the type that is headers followed
    by the body encoded in base64 or quoted-printable.  The problem with this type
    is that the header may state it as MIME, but the MIME parts and their headers
    will be encoded, so we won't find them - in this case, we will later take
    all the info we need from the message header, and not try to take it from
    the part header.}
    if (TIdMessage(AOwner).ContentTransferEncoding <> '') and
      {CC2: added 8bit below, changed to TextIsSame.  Reason is that many emails
      set the Content-Transfer-Encoding to 8bit, have multiple parts, and display
      the part header in plain-text.}
      (not TextIsSame(TIdMessage(AOwner).ContentTransferEncoding, '8bit')) and  {do not localize}
      (not TextIsSame(TIdMessage(AOwner).ContentTransferEncoding, '7bit')) and  {do not localize}
      (not TextIsSame(TIdMessage(AOwner).ContentTransferEncoding, 'binary'))    {do not localize}
      then
    begin
      FBodyEncoded := True;
    end;
  end;
end;

constructor TIdMessageDecoderMIME.Create(AOwner: TComponent; const ALine: string);
begin
  Create(AOwner);
  FFirstLine := ALine;
end;

function TIdMessageDecoderMIME.ReadBody(ADestStream: TIdStream; var VMsgEnd: Boolean): TIdMessageDecoder;
var
  LContentTransferEncoding: string;
  LDecoder: TIdDecoder;
  LLine: string;
  LBuffer: string;  //Needed for binhex4 because cannot decode line-by-line.
  LIsThisTheFirstLine: Boolean; //Needed for binary encoding
  BoundaryStart, BoundaryEnd: string;
  IsBinaryContentTransferEncoding: Boolean;
begin
  LIsThisTheFirstLine := True;
  VMsgEnd := False;
  Result := nil;
  if FBodyEncoded then begin
    LContentTransferEncoding := TIdMessage(Owner).ContentTransferEncoding;
  end else begin
    LContentTransferEncoding := FHeaders.Values['Content-Transfer-Encoding']; {Do not Localize}
    if LContentTransferEncoding = '' then begin
      LContentTransferEncoding := FHeaders.Values['Content-Type']; {Do not Localize}
      if TextIsSame(Copy(LContentTransferEncoding, 1, 24), 'application/mac-binhex40') then begin  {Do not Localize}
        LContentTransferEncoding := 'binhex40'; {do not localize}
      end;
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

    BoundaryStart := '--' + MIMEBoundary; {Do not Localize}
    BoundaryEnd := BoundaryStart + '--'; {Do not Localize}
    IsBinaryContentTransferEncoding := TextIsSame(LContentTransferEncoding, 'binary'); {do not localize}

    repeat
      if FFirstLine = '' then begin // TODO: Improve this. Not very efficient
        if IsBinaryContentTransferEncoding then begin
          //For binary, need EOL because the default LF causes spurious CRs in the output...
          LLine := ReadLn(EOL);
        end else begin
          LLine := ReadLn;
        end;
      end else begin
        LLine := FFirstLine;
        FFirstLine := '';    {Do not Localize}
      end;
      if LLine = '.' then begin // Do not use ADELIM since always ends with . (standard) {Do not Localize}
        VMsgEnd := True;
        Break;
      end;
      // New boundary - end self and create new coder
      if MIMEBoundary <> '' then begin
        if TextIsSame(LLine, BoundaryStart) then begin
          Result := TIdMessageDecoderMIME.Create(Owner);
          Break;
        // End of all coders (not quite ALL coders)
        end
        else if TextIsSame(LLine, BoundaryEnd) then begin
          // POP the boundary
          if Owner is TIdMessage then begin
            TIdMessage(Owner).MIMEBoundary.Pop;
          end;
          Break;
        // Data to save, but not decode
        end else if LDecoder = nil then begin
          if (LLine <> '') and (LLine[1] = '.') then begin // Process . in front for no encoding    {Do not Localize}
            Delete(LLine, 1, 1);
          end;
          if IsBinaryContentTransferEncoding then begin {do not localize}
            //In this case, we have to make sure we dont write out an EOL at the
            //end of the file.
            if LIsThisTheFirstLine then begin
              ADestStream.Write(LLine);
              LIsThisTheFirstLine := False;
            end else begin
              ADestStream.Write(EOL);
              ADestStream.Write(LLine);
            end;
          end else begin
            LLine := LLine + EOL;
            ADestStream.Write(LLine);
          end;
        // Data to decode
        end else begin
          // For TIdDecoderQuotedPrintable, we have to make sure all EOLs are
          // intact
          if LDecoder is TIdDecoderQuotedPrintable then begin
            LDecoder.Decode(LLine + EOL);
          end else if LDecoder is TIdDecoderBinHex4 then begin
            //We cannot decode line-by-line because lines don't have a whole
            //number of 4-byte blocks due to the : inserted at the start of
            //the first line, so buffer the file...
            LBuffer := LBuffer + LLine;
          end else if LLine <> '' then begin
            LDecoder.Decode(LLine);
          end;
        end;
      end else begin  {CC3: Added "else" for QP and base64 encoded message BODIES}
        // For TIdDecoderQuotedPrintable, we have to make sure all EOLs are
        // intact
        if LDecoder is TIdDecoderQuotedPrintable then begin
          LDecoder.Decode(LLine + EOL);
        end else if LDecoder = nil then begin
          if (LLine <> '') and (LLine[1] = '.') then begin // Process . in front for no encoding    {Do not Localize}
            Delete(LLine, 1, 1);
          end;
          LLine := LLine + EOL;
          ADestStream.Write(LLine);
        end else if LLine <> '' then begin
          LDecoder.Decode(LLine);
        end;
      end;
    until False;
    if LDecoder <> nil then begin
      if LDecoder is TIdDecoderBinHex4 then begin
        //Now decode the complete block...
        LDecoder.Decode(LBuffer);
      end else if LDecoder is TIdDecoderMIMELineByLine then begin
        TIdDecoderMIMELineByLine(LDecoder).FinishDecoding;
      end;
      LDecoder.DecodeEnd;
    end;
  finally Sys.FreeAndNil(LDecoder); end;
end;

function TIdMessageDecoderMIME.GetAttachmentFilename(AContentType, AContentDisposition: string): string;
var
  LValue: string;
  LPos: Integer;
begin
  LPos := IndyPos('FILENAME=', Sys.UpperCase(AContentDisposition));  {do not localize}
  if LPos > 0 then begin
    LValue := Sys.Trim(Copy(AContentDisposition, LPos + 9, MaxInt));
  end else begin
    LValue := ''; //FileName not found
  end;
  if Length(LValue) = 0 then begin
    // Get filename from Content-Type
    LPos := IndyPos('NAME=', Sys.UpperCase(AContentType)); {do not localize}
    if LPos > 0 then begin
      LValue := Sys.Trim(Copy(AContentType, LPos + 5, MaxInt));    {do not localize}
    end;
  end;
  if Length(LValue) > 0 then begin
    if LValue[1] = '"' then begin    {do not localize}
      // RLebeau - shouldn't this code use AnsiExtractQuotedStr() instead?
      Fetch(LValue, '"');    {do not localize}
      Result := Fetch(LValue, '"');    {do not localize}
    end else begin
      // RLebeau - just in case the name is not the last field in the line
      Result := Fetch(LValue, ';'); {do not localize}
    end;
    Result := RemoveInvalidCharsFromFilename(DecodeHeader(Result));
  end else begin
    Result := '';
  end;
end;

procedure TIdMessageDecoderMIME.CheckAndSetType(AContentType, AContentDisposition: string);
var
  LDisposition, LFileName: string;
begin
  LDisposition := Fetch(AContentDisposition, ';');    {Do not Localize}

  {The new world order: Indy now defines a TIdAttachment as a part that either has
  a filename, or else does NOT have a ContentType starting with text/ or multipart/.
  Anything left is a TIdText.}

  //WARNING: Attachments may not necessarily have filenames!
  LFileName := GetAttachmentFilename(AContentType, AContentDisposition);

  if TextIsSame(LDisposition, 'attachment') or (Length(LFileName) > 0) then begin {Do not Localize}
    {A filename is specified, so irrespective of type, this is an attachment...}
    FPartType := mcptAttachment;
    FFilename := LFileName;
  end else begin
    {No filename is specified, so see what type the part is...}
    if TextIsSame(Copy(AContentType, 1, 5), MIMEGenericText) or
      TextIsSame(Copy(AContentType, 1, 10), MIMEGenericMultiPart) then
    begin
      FPartType := mcptText;
    end else begin
      FPartType := mcptAttachment;
    end;
  end;
end;

procedure TIdMessageDecoderMIME.ReadHeader;
var
  ABoundary,
  s: string;
  LLine: string;
begin
  if FBodyEncoded then begin // Read header from the actual message since body parts don't exist    {Do not Localize}
    CheckAndSetType(TIdMessage(Owner).ContentType, TIdMessage(OWner).ContentDisposition);
  end else begin
    // Read header
    repeat
      LLine := ReadLn;
      if LLine = '.' then begin // TODO: abnormal situation (Masters!)    {Do not Localize}
        FPartType := mcptUnknown;
        Exit;
      end;//if
      if LLine = '' then begin
        Break;
      end;
      if CharIsInSet(LLine, 1, LWS) then begin
        if FHeaders.Count > 0 then begin
          FHeaders[FHeaders.Count - 1] := FHeaders[FHeaders.Count - 1] + ' ' + Copy(LLine, 2, MaxInt);    {Do not Localize}
        end else begin
          //Make sure you change 'Content-Type :' to 'Content-Type:'
          FHeaders.Add(Sys.ReplaceOnlyFirst( Sys.ReplaceOnlyFirst(Copy(LLine,2,MaxInt),': ','='),' =','=')); {Do not Localize}
        end;
      end else begin
        //Make sure you change 'Content-Type :' to 'Content-Type:'
        FHeaders.Add(Sys.ReplaceOnlyFirst(Sys.ReplaceOnlyFirst(LLine,': ','='),' =','='));    {Do not Localize}
      end;
    until False;
    s := FHeaders.Values['Content-Type'];    {do not localize}
    //CC: Need to detect on "multipart" rather than boundary, because only the
    //"multipart" bit will be visible later...
    if TextIsSame(Copy(s, 1, 10), 'multipart/') then begin  {do not localize}
      ABoundary := TIdMIMEBoundary.FindBoundary(s);
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
var
  LN: integer;
begin
  Result := AFilename;
  //First, strip any Windows or Unix path...
  for LN := Length(Result) downto 1 do begin
    if ((Result[LN] = '/') or (Result[LN] = '\')) then begin  {do not localize}
      Result := Copy(Result, LN+1, MAXINT);
      break;
    end;
  end;
  //Now remove any invalid filename chars.
  //Hmm - this code will be less buggy if I just replace them with _
  for LN := 1 to Length(Result) do begin
    if Pos(Result[LN], ValidWindowsFilenameChars) = 0 then begin
      Result[LN] := '_';    {do not localize}
    end;
  end;
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

procedure TIdMessageEncoderMIME.Encode(ASrc: TIdStreamRandomAccess; ADest: TIdStream);
var
  s: string;
  LEncoder: TIdEncoderMIME;
  LSPos, LSSize : Int64;
begin
  ASrc.Position := 0;
  LSPos := 0;
  LSSize := ASrc.Size;
  LEncoder := TIdEncoderMIME.Create(nil); try
    while LSPos < LSSize do begin
      s := LEncoder.Encode(ASrc, 57) + EOL;
      Inc(LSPos,57);
      ADest.Write(s);
    end;
  finally Sys.FreeAndNil(LEncoder); end;
end;

initialization
  TIdMessageDecoderList.RegisterDecoder('MIME'    {Do not Localize}
   , TIdMessageDecoderInfoMIME.Create);
  TIdMessageEncoderList.RegisterEncoder('MIME'    {Do not Localize}
   , TIdMessageEncoderInfoMIME.Create);
  IdMIMEBoundaryStrings := TIdMIMEBoundaryStrings.Create;
finalization
  IdMIMEBoundaryStrings.Free;
  IdMIMEBoundaryStrings := nil;  {Global vars always initialised to 0, not nil}
end.
