{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11669: IdMessageClient.pas
{
{   Rev 1.85    1/6/05 4:38:30 PM  RLebeau
{ Bug fix for decoding Text part headers
}
{
{   Rev 1.84    11/30/04 10:44:44 AM  RLebeau
{ Bug fix for previous checkin
}
{
{   Rev 1.83    11/30/2004 12:10:40 PM  JPMugaas
{ Fix for compiler error.
}
{
{   Rev 1.82    11/28/04 2:22:04 PM  RLebeau
{ Updated a few hard-coded strings to use resource strings instead
}
{
{   Rev 1.81    28/11/2004 20:08:14  CCostelloe
{ MessagePart.Boundary now (correctly) holds decoded MIME boundary
}
{
{   Rev 1.80    11/27/2004 8:58:14 PM  JPMugaas
{ Compile errors.
}
{
{   Rev 1.79    10/26/2004 10:25:46 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.78    24.09.2004 02:16:48  Andreas Hausladen
{ Added ReadTIdBytesFromStream and ReadCharFromStream function to supress .NET
{ warnings.
}
{
{   Rev 1.77    27.08.2004 22:04:32  Andreas Hausladen
{ speed optimization ("const" for string parameters)
{ Fixed "blank line multiplication"
}
{
{   Rev 1.76    27.08.2004 00:21:32  Andreas Hausladen
{ Undo last changes (temporary)
}
{
{   Rev 1.75    26.08.2004 22:14:16  Andreas Hausladen
{ Fixed last line blank line read/write bug
}
{
{   Rev 1.74    7/23/04 7:17:20 PM  RLebeau
{ TFileStream access right tweak for ProcessMessage()
}
{
{   Rev 1.73    28/06/2004 23:58:12  CCostelloe
{ Bug fix
}
{
    Rev 1.72    6/11/2004 9:38:08 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.71    2004.06.06 4:53:04 PM  czhower
{ Undid 1.70. Not needed, just masked an existing bug and did not fix it.
}
{
{   Rev 1.70    06/06/2004 01:23:54  CCostelloe
{ OnWork fix
}
{
{   Rev 1.69    6/4/04 12:41:56 PM  RLebeau
{ ContentTransferEncoding bug fix
}
{
{   Rev 1.68    2004.05.20 1:39:08 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.67    2004.05.20 11:36:52 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.66    2004.05.20 11:12:56 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.65    2004.05.19 3:06:34 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.64    19/05/2004 00:54:30  CCostelloe
{ Bug fix (though I claim in my defence that it is only a hint fix)
}
{
{   Rev 1.63    16/05/2004 18:55:06  CCostelloe
{ New TIdText/TIdAttachment processing
}
{
{   Rev 1.62    2004.05.03 11:15:16 AM  czhower
{ Fixed compile error and added use of constants.
}
{
{   Rev 1.61    5/2/04 8:02:12 PM  RLebeau
{ Updated TIdIOHandlerStreamMsg to keep track of the last character received
{ from the stream so that extra CR LF characters are not added to the end of
{ the message data unnecessarily.
}
{
{   Rev 1.60    4/23/04 1:54:58 PM  RLebeau
{ One more tweak for TIdIOHandlerStreamMsg support
}
{
{   Rev 1.59    4/23/04 1:21:16 PM  RLebeau
{ Minor tweaks for TIdIOHandlerStreamMsg support
}
{
{   Rev 1.58    23/04/2004 20:48:10  CCostelloe
{ Added TIdIOHandlerStreamMsg to stop looping if no terminating \r\n.\r\n and
{ added support for emails that are attachments only
}
{
{   Rev 1.57    2004.04.18 1:39:22 PM  czhower
{ Bug fix for .NET with attachments, and several other issues found along the
{ way.
}
{
{   Rev 1.56    2004.04.16 11:31:00 PM  czhower
{ Size fix to IdBuffer, optimizations, and memory leaks
}
{
{   Rev 1.55    2004.03.07 10:36:08 AM  czhower
{ SendMsg now calls OnWork with NoEncode = True
}
{
{   Rev 1.54    2004.03.04 1:02:58 AM  czhower
{ Const removed from arguemtns (1 not needed + 1 incorrect)
}
{
{   Rev 1.53    2004.03.03 7:18:32 PM  czhower
{ Fixed AV bug with ProcessMessage
}
{
{   Rev 1.52    2004.03.03 11:54:34 AM  czhower
{ IdStream change
}
{
{   Rev 1.51    2/3/04 12:25:50 PM  RLebeau
{ Updated WriteTextPart() function inside of SendBody() to write the ContentID
{ property is it is assigned.
}
{
{   Rev 1.50    2004.02.03 5:44:02 PM  czhower
{ Name changes
}
{
{   Rev 1.49    2004.02.03 2:12:16 PM  czhower
{ $I path change
}
{
{   Rev 1.48    1/27/2004 4:04:06 PM  SPerry
{ StringStream ->IdStringStream
}
{
{   Rev 1.47    2004.01.27 12:03:28 AM  czhower
{ Properly named a local variable to fix a .net conflict.
}
{
{   Rev 1.46    1/25/2004 3:52:32 PM  JPMugaas
{ Fixes for abstract SSL interface to work in NET.
}
{
{   Rev 1.45    24/01/2004 19:24:30  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.44    1/21/2004 1:30:06 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.43    16/01/2004 17:39:34  CCostelloe
{ Added support for BinHex 4.0 encoding
}
{
{   Rev 1.42    11/01/2004 19:53:40  CCostelloe
{ Revisions for TIdMessage SaveToFile & LoadFromFile for D7 & D8
}
{
{   Rev 1.40    08/01/2004 23:46:16  CCostelloe
{ Changes to ProcessMessage to get TIdMessage.LoadFromFile working in D7
}
{
{   Rev 1.39    08/01/2004 00:31:06  CCostelloe
{ Start of reimplementing LoadFrom/SaveToFile
}
{
{   Rev 1.38    22/12/2003 00:44:52  CCostelloe
{ .NET fixes
}
{
{   Rev 1.37    11/11/2003 12:06:26 AM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.36    2003.10.24 10:43:10 AM  czhower
{ TIdSTream to dos
}
{
    Rev 1.35    10/17/2003 12:37:36 AM  DSiders
  Added localization comments.
  Added resource string for exception message.
}
{
{   Rev 1.34    2003.10.14 9:57:12 PM  czhower
{ Compile todos
}
{
{   Rev 1.33    10/12/2003 1:49:56 PM  BGooijen
{ Changed comment of last checkin
}
{
{   Rev 1.32    10/12/2003 1:43:40 PM  BGooijen
{ Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc
}
{
{   Rev 1.30    10/11/2003 4:21:14 PM  BGooijen
{ Compiles in D7 again
}
{
{   Rev 1.29    10/10/2003 10:42:28 PM  BGooijen
{ DotNet
}
{
{   Rev 1.28    9/10/2003 1:50:52 PM  SGrobety
{ DotNet
}
{
{   Rev 1.27    10/8/2003 9:53:42 PM  GGrieve
{ Remove $IFDEFs
}
{
{   Rev 1.26    05/10/2003 16:39:52  CCostelloe
{ Set default ContentType
}
{
{   Rev 1.25    03/10/2003 21:03:40  CCostelloe
{ Bug fixes
}
{
{   Rev 1.24    2003.10.02 9:27:52 PM  czhower
{ DotNet Excludes
}
{
{   Rev 1.23    01/10/2003 17:58:56  HHariri
{ More fixes for Multipart Messages and also fixes for incorrect transfer
{ encoding settings
}
{
{   Rev 1.20    01/10/2003 10:57:56  CCostelloe
{ Fixed GenerateTextPartContentType (was ignoring ContentType)
}
{
{   Rev 1.19    26/09/2003 01:03:48  CCostelloe
{ Modified ProcessAttachment in ReceiveBody to update message's Encoding if
{ attachment was XX-encoded.  Added decoding of message bodies encoded as
{ base64 or quoted-printable.  Added support for nested MIME parts
{ (ParentPart).  Added support for TIdText in UU and XX encoding.  Added
{ missing base64 and QP support where needed. Rewrote/rearranged most of code.
}
{
{   Rev 1.18    04/09/2003 20:44:56  CCostelloe
{ In SendBody, removed blank line between boundaries and Text part header;
{ recoded wDoublePoint
}
{
{   Rev 1.17    30/08/2003 18:40:44  CCostelloe
{ Updated to use IdMessageCoderMIME's new random boundaries
}
{
{   Rev 1.16    8/8/2003 12:27:18 PM  JPMugaas
{ Should now compile.
}
{
{   Rev 1.15    07/08/2003 00:39:06  CCostelloe
{ Modified SendBody to deal with unencoded attachments (otherwise 7bit
{ attachments had the attachment header written out as 7bit but was encoded as
{ base64)
}
{
{   Rev 1.14    11/07/2003 01:14:20  CCostelloe
{ SendHeader changed to support new IdMessage.GenerateHeader putting generated
{ headers in IdMessage.LastGeneratedHeaders.
}
{
{   Rev 1.13    6/15/2003 01:13:10 PM  JPMugaas
{ Minor fixes and cleanups.
}
{
{   Rev 1.12    5/18/2003 02:31:44 PM  JPMugaas
{ Reworked some things so IdSMTP and IdDirectSMTP can share code including
{ stuff for pipelining.
}
{
{   Rev 1.11    5/8/2003 03:18:06 PM  JPMugaas
{ Flattened ou the SASL authentication API, made a custom descendant of SASL
{ enabled TIdMessageClient classes.
}
{
{   Rev 1.10    5/8/2003 11:28:02 AM  JPMugaas
{ Moved feature negoation properties down to the ExplicitTLSClient level as
{ feature negotiation goes hand in hand with explicit TLS support.
}
{
{   Rev 1.9    5/8/2003 02:17:58 AM  JPMugaas
{ Fixed an AV in IdPOP3 with SASL list on forms.  Made exceptions for SASL
{ mechanisms missing more consistant, made IdPOP3 support feature feature
{ negotiation, and consolidated some duplicate code.
}
{
{   Rev 1.8    3/17/2003 02:16:06 PM  JPMugaas
{ Now descends from ExplicitTLS base class.
}
{
{   Rev 1.7    2/24/2003 07:25:18 PM  JPMugaas
{ Now compiles with new code.
}
{
{   Rev 1.6    12-8-2002 21:12:36  BGooijen
{ Changed calls to Writeln to  IOHandler.WriteLn, because the parent classes
{ don't provide Writeln, System.Writeln was assumed by the compiler
}
{
{   Rev 1.5    12-8-2002 21:08:58  BGooijen
{ The TIdIOHandlerStream was not Opened before used, fixed that.
}
{
{   Rev 1.4    12/6/2002 05:30:22 PM  JPMugaas
{ Now decend from TIdTCPClientCustom instead of TIdTCPClient.
}
{
{   Rev 1.3    12/5/2002 02:54:06 PM  JPMugaas
{ Updated for new API definitions.
}
{
{   Rev 1.2    11/23/2002 03:33:44 AM  JPMugaas
{ Reverted changes because they were problematic.  Kudzu didn't explain why.
}
{
{   Rev 1.1    11/19/2002 05:35:30 PM  JPMugaas
{ Fixed problem with a line starting with a ".".  A double period should only
{ be used if the line is really just one "." and no other cases.
}
{
{   Rev 1.0    11/13/2002 07:56:58 AM  JPMugaas
}
unit IdMessageClient;

{
  2003-10-04 Ciaran Costelloe (see comments starting CC4)
    If attachment not base64 encoded and has no ContentType, set to text/plain
  2003-Sep-20 Ciaran Costelloe
    Modified ProcessAttachment in ReceiveBody to update message's Encoding
    if attachment was XX-encoded.  Added decoding of message bodies
    encoded as base64 or quoted-printable.  Added support for nested MIME parts
    (ParentPart).  Added support for TIdText in UU and XX encoding.  Added
    missing base64 and QP support where needed.
    Rewrote/rearranged most of code.

  2001-Oct-29 Don Siders
    Modified TIdMessageClient.SendMsg to use AHeadersOnly argument.

  2001-Dec-1  Don Siders
    Save ContentDisposition in TIdMessageClient.ProcessAttachment

  2003-Sep-04 Ciaran Costelloe (CC comments)
    Commented-out IOHandler.WriteLn(''); in SendBody which used to insert a blank line
    between boundary and text attachment header, causing the attachment header to
    be parsed as part of the attachment text (the blank line is the delimiter for
    the end of the header).

  2003-Sep-11 Ciaran Costelloe (CC2 comments)
    Added support in decoding for message body (as distinct from message parts) being
    encoded.
    Added support for generating encoded message body.
}

{$I IdCompilerDefines.inc}

interface

uses
  IdIOHandlerStream,
  Classes,
  IdExplicitTLSClientServerBase,
  IdGlobal,
  IdMessage, IdTCPClient, IdHeaderList,
  IdCoderMIME,
  IdTStrings;

type
  TIdIOHandlerStreamMsg = class(TIdIOHandlerStream)
  protected
    FTerminatorWasRead: Boolean;
    FLastByteRecv: Byte;
    function ReadFromSource(
      ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
       ARaiseExceptionOnTimeout: Boolean): Integer; override;
  public
    constructor Create(
      AOwner: TComponent;
      AReceiveStream: TStream;
      ASendStream: TStream = nil
    ); override;  //Should this be reintroduce instead of override?
    function Readable(AMSec: integer = IdTimeoutDefault): Boolean; override;
end;

type
  TIdMessageClient = class(TIdExplicitTLSClient)
  protected
    // The length of the folded line
    FMsgLineLength: integer;
    // The string to be pre-pended to the next line
    FMsgLineFold: string;

    procedure ReceiveBody(AMsg: TIdMessage; const ADelim: string = '.'); virtual;    {do not localize}
    function  ReceiveHeader(AMsg: TIdMessage; const AAltTerm: string = ''): string; virtual;
    procedure SendBody(AMsg: TIdMessage); virtual;
    procedure SendHeader(AMsg: TIdMessage); virtual;
    procedure WriteBodyText(AMsg: TIdMessage); virtual;
    procedure WriteFoldedLine(const ALine : string);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    procedure ProcessMessage(AMsg: TIdMessage; AHeaderOnly: Boolean = False); overload;
    procedure ProcessMessage(AMsg: TIdMessage; AStream: TStream; AHeaderOnly: Boolean = False); overload;
    procedure ProcessMessage(AMsg: TIdMessage; const AFilename: string; AHeaderOnly: Boolean = False); overload;
    procedure SendMsg(AMsg: TIdMessage; AHeadersOnly: Boolean = False); overload; virtual;
    //
  //  property Capabilities;
    property MsgLineLength: integer read FMsgLineLength write FMsgLineLength;
    property MsgLineFold: string read FMsgLineFold write FMsgLineFold;
  end;

implementation

uses
  //TODO: Remove these references and make it completely pluggable. Check other spots in Indy as well
  IdCoderQuotedPrintable, IdMessageCoderQuotedPrintable, IdMessageCoderMIME,
  IdMessageCoderUUE, IdMessageCoderXXE,
  //
  IdGlobalProtocols,
  IdCoder, IdCoder3to4, IdCoderBinHex4,
  IdCoderHeader, IdMessageCoder, IdComponent, IdException, IdResourceStringsProtocols,
  IdTCPConnection,
  IdStreamVCL, IdTCPStream, IdStream,
  IdIOHandler, IdAttachmentFile,
  IdSysUtils, IdText, IdAttachment;

const
  SContentType = 'Content-Type'; {do not localize}
  SContentTransferEncoding = 'Content-Transfer-Encoding'; {do not localize}
  SThisIsMultiPartMessageInMIMEFormat = 'This is a multi-part message in MIME format'; {do not localize}

function GenerateTextPartContentType(AContentType, ACharSet: String): String;
Begin
  //ContentType may contain the charset also, but CharSet overrides it if it is present...
  if Length(ACharSet) > 0 then begin
    AContentType := RemoveHeaderEntry(AContentType, 'charset');  {do not localize}
  end;
  Result := SContentType + ': '+AContentType; {do not localize}
  if Length(ACharSet) > 0 then begin
    Result := Result + ' ; charset="'+ACharSet+'"'; {do not localize}
  end
End;//

function GetLongestLine(var ALine : String; ADelim : String) : String;
var
  i, fnd, lineLen, delimLen : Integer;
begin
  i := 0;
  fnd := -1;
  delimLen := length(ADelim);
  lineLen := length(ALine);

  while i < lineLen do
  begin
    if ALine[i] = ADelim[1] then
    begin
      if Copy(ALine, i, delimLen) = ADelim then
      begin
        fnd := i;
      end;
    end;
    Inc(i);
  end;

  if fnd = -1 then
  begin
    result := '';
  end

  else begin
    result := Copy(ALine, 1, fnd - 1);
    ALine := Copy(ALine, fnd + delimLen, lineLen);
  end;
end;

procedure RemoveLastBlankLine(Body: TIdStrings);
var
  Count: Integer;
begin
  if Assigned(Body) then begin
    { Remove the last blank line. The last blank line is added again in
      TIdMessageClient.SendBody(). }
    Count := Body.Count;
    if (Count > 0) and (Body[Count - 1] = '') then begin
      Body.Delete(Count - 1);
    end;
  end;
end;

////////////////////////
// TIdIOHandlerStreamMsg
////////////////////////

constructor TIdIOHandlerStreamMsg.Create(
  //AOwner: TComponent);
  AOwner: TComponent;
  AReceiveStream: TStream;
  ASendStream: TStream = nil
  );
begin
  inherited Create(AOwner, AReceiveStream, ASendStream);
  FTerminatorWasRead := False;
  FLastByteRecv := 0;
end;

function TIdIOHandlerStreamMsg.Readable(AMSec: integer = IdTimeoutDefault): Boolean;
begin
  if not FTerminatorWasRead then begin
    Result := inherited Readable(AMSec);
    if Result then begin
      Exit;
    end;
  end;
  if ReceiveStream <> nil then begin
    Result := not FTerminatorWasRead;
  end else begin
    Result := False;
  end;
end;

function TIdIOHandlerStreamMsg.ReadFromSource(
  ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
  ARaiseExceptionOnTimeout: Boolean): Integer;
var
  LTerminator: String;
begin
  if not FTerminatorWasRead then begin
    Result := inherited ReadFromSource(ARaiseExceptionIfDisconnected, ATimeout, ARaiseExceptionOnTimeout);
    if Result > 0 then begin
      FLastByteRecv := FInputBuffer.PeekByte(FInputBuffer.Size-1);
      Exit;
    end;
    // determine whether the stream ended with a line
    // break, adding an extra CR and/or LF if needed...
    if (FLastByteRecv = Ord(LF)) then begin
      // don't add an extra line break
      LTerminator := '.' + EOL;
    end else if (FLastByteRecv = Ord(CR)) then begin
      // add extra LF
      LTerminator := LF + '.' + EOL;
    end else begin
      // add extra CRLF
      LTerminator := EOL + '.' + EOL;
    end;
    FTerminatorWasRead := True;
    // in theory, TIdBuffer.Write() will write the string
    // into the buffer's byte array using 1-byte characters
    // even under DotNet where strings are usually Unicode
    // instead of ASCII...
    FInputBuffer.Write(LTerminator);
    Result := Length(LTerminator);
  end else begin;
    Result := 0;
  end;
end;

///////////////////
// TIdMessageClient
///////////////////

procedure TIdMessageClient.InitComponent;
begin
  inherited;

  FMsgLineLength := 79;
  FMsgLineFold := TAB;
end;

procedure TIdMessageClient.WriteFoldedLine(const ALine : string);
var
  ins, s, line, spare : String;
  msgLen, insLen : Word;
begin
  s := ALine;

  // To give an amount of thread-safety
  ins := FMsgLineFold;
  insLen := Length(ins);
  msgLen := FMsgLineLength;

  // Do first line
  if length(s) > FMsgLineLength then
  begin
    spare := Copy(s, 1, msgLen);
    line := GetLongestLine(spare, ' ');    {do not localize}
    s := spare + Copy(s, msgLen + 1, length(s));
    IOHandler.WriteLn(line);

    // continue with the folded lines
    while length(s) > (msgLen - insLen) do
    begin
      spare := Copy(s, 1, (msgLen - insLen));
      line := GetLongestLine(spare, ' ');      {do not localize}
      s := ins + spare + Copy(s, (msgLen - insLen) + 1, length(s));
      IOHandler.WriteLn(line);
    end;

    // complete the output with what's left
    if Sys.Trim(s) <> '' then
    begin
      IOHandler.WriteLn(ins + s);
    end;
  end

  else begin
    IOHandler.WriteLn(s);
  end;
end;

procedure TIdMessageClient.ReceiveBody(AMsg: TIdMessage; const ADelim: string = '.');  {do not localize}
var
  LMsgEnd: Boolean;
  LActiveDecoder: TIdMessageDecoder;
  LLine: string;
  LParentPart: integer;
  LPreviousParentPart: integer;

  function ProcessTextPart(ADecoder: TIdMessageDecoder; AUseBodyAsTarget: Boolean = False): TIdMessageDecoder;
  {Only set AUseBodyAsTarget to True if you want the input stream stored in TIdMessage.Body
  instead of TIdText.Body: this happens with some single-part messages.}
  var
    LDestStream: TIdStreamVCL;
    LStringStream: TStringStream;
    i: integer;
    LTxt : TIdText;
  begin
    LStringStream := TIdStringStream.Create('');
    try
      LDestStream := TIdStreamVCL.Create(LStringStream);
      try
        LParentPart := AMsg.MIMEBoundary.ParentPart;
        Result := ADecoder.ReadBody(LDestStream, LMsgEnd);
        if AUseBodyAsTarget then begin
          AMsg.Body.Text := LStringStream.DataString;
        end else begin
          LTxt := TIdText.Create(AMsg.MessageParts);
          LTxt.Body.Text := LStringStream.DataString;
          RemoveLastBlankLine(LTxt.Body);
          if AMsg.IsMsgSinglePartMime then begin
            LTxt.ContentType := LTxt.ResolveContentType(AMsg.Headers.Values[SContentType]);
            LTxt.Headers.Add('Content-Type: '+ AMsg.Headers.Values[SContentType]);     {do not localize}
            LTxt.CharSet := LTxt.GetCharSet(AMsg.Headers.Values[SContentType]);       {do not localize}
            LTxt.ContentTransfer := AMsg.Headers.Values[SContentTransferEncoding];    {do not localize}
            LTxt.Headers.Add('Content-Transfer-Encoding: '+ AMsg.Headers.Values[SContentTransferEncoding]);   {do not localize}
            LTxt.ContentID := AMsg.Headers.Values['Content-ID'];  {do not localize}
            LTxt.ContentLocation := AMsg.Headers.Values['Content-Location'];  {do not localize}
          end else begin
            LTxt.ContentType := LTxt.ResolveContentType(ADecoder.Headers.Values[SContentType]);
            LTxt.Headers.Add('Content-Type: '+ ADecoder.Headers.Values[SContentType]);     {do not localize}
            LTxt.CharSet := LTxt.GetCharSet(ADecoder.Headers.Values[SContentType]);        {do not localize}
            LTxt.ContentTransfer := ADecoder.Headers.Values[SContentTransferEncoding]; {do not localize}
            LTxt.Headers.Add('Content-Transfer-Encoding: '+ ADecoder.Headers.Values[SContentTransferEncoding]);  {do not localize}
            LTxt.ContentID := ADecoder.Headers.Values['Content-ID'];  {do not localize}
            LTxt.ContentLocation := ADecoder.Headers.Values['Content-Location'];  {do not localize}
            LTxt.ExtraHeaders.NameValueSeparator := '=';                          {do not localize}
            for i := 0 to ADecoder.Headers.Count-1 do begin
              if LTxt.Headers.IndexOfName(ADecoder.Headers.Names[i]) < 0 then begin
                LTxt.ExtraHeaders.Add(ADecoder.Headers.Strings[i]);
              end;
            end;
          end;
          if TextIsSame(Copy(LTxt.ContentType, 1, 10), 'multipart/') then begin {do not localize}
            LTxt.ParentPart := LPreviousParentPart;
          end else begin
            LTxt.ParentPart := LParentPart;
          end;
          if LTxt.ParentPart <> -1 then begin
            LTxt.Boundary := AMsg.MIMEBoundary.FindBoundary(AMsg.MessageParts.Items[LTxt.ParentPart].Headers.Values[SContentType]);  {do not localize}
          end else begin
            LTxt.Boundary := AMsg.MIMEBoundary.FindBoundary(AMsg.Headers.Values[SContentType]);                                      {do not localize}
          end;
        end;
        ADecoder.Free;
      finally Sys.FreeAndNil(LDestStream); end;
    finally Sys.FreeAndNil(LStringStream); end;
  end;

  function ProcessAttachment(ADecoder: TIdMessageDecoder): TIdMessageDecoder;
  var
    LStream: TIdStreamVCL;
    LDestStream: TStream;
    i: integer;
    LAttachment: TIdAttachment;
  begin
    Result := nil; // suppress warnings
    LParentPart := AMsg.MIMEBoundary.ParentPart;
    AMsg.DoCreateAttachment(ADecoder.Headers, LAttachment);
    Assert(Assigned(LAttachment), 'Attachment must not be unassigned here!'); {Do not localize}
    with LAttachment do begin
      try
        LDestStream := PrepareTempStream; try
          LStream := TIdStreamVCL.Create(LDestStream); try
            Result := ADecoder.ReadBody(LStream, LMsgEnd);
          finally Sys.FreeAndNil(LStream); end;
          if AMsg.IsMsgSinglePartMime then begin
            ContentType := ResolveContentType(AMsg.Headers.Values[SContentType]);    {do not localize}
            Headers.Add('Content-Type: '+ AMsg.Headers.Values[SContentType]);        {do not localize}
            CharSet := GetCharSet(AMsg.Headers.Values[SContentType]);                {do not localize}
            //Watch out for BinHex 4.0 encoding: no ContentTransfer is specified
            //in the header, but we need to set it to something meaningful for us...
            if TextIsSame(Copy(ContentType, 1, 24), 'application/mac-binhex40') then begin {do not localize}
              ContentTransfer := 'binhex40';                                               {do not localize}
              Headers.Add('Content-Transfer-Encoding: binhex40');                          {do not localize}
            end else begin
              ContentTransfer := AMsg.Headers.Values[SContentTransferEncoding];  {do not localize}
              Headers.Add('Content-Transfer-Encoding: '+ AMsg.Headers.Values[SContentTransferEncoding]); {do not localize}
            end;
            ContentDisposition := AMsg.Headers.Values['Content-Disposition']; {do not localize}
            ContentID := AMsg.Headers.Values['Content-ID'];                   {do not localize}
            ContentLocation := AMsg.Headers.Values['Content-Location'];       {do not localize}
          end else begin
            ContentType := ResolveContentType(ADecoder.Headers.Values[SContentType]);    {do not localize}
            Headers.Add('Content-Type: '+ ADecoder.Headers.Values[SContentType]);        {do not localize}
            CharSet := GetCharSet(ADecoder.Headers.Values[SContentType]);                {do not localize}
            if ADecoder is TIdMessageDecoderUUE then begin
              if TIdMessageDecoderUUE(ADecoder).CodingType = 'XXE' then begin {do not localize}
                ContentTransfer := 'XXE';  {do not localize}
              end else begin
                ContentTransfer := 'UUE';  {do not localize}
              end;
            end else begin
              //Watch out for BinHex 4.0 encoding: no ContentTransfer is specified
              //in the header, but we need to set it to something meaningful for us...
              if TextIsSame(Copy(ContentType, 1, 24), 'application/mac-binhex40') then begin {do not localize}
                ContentTransfer := 'binhex40';                                               {do not localize}
                Headers.Add('Content-Transfer-Encoding: binhex40');                          {do not localize}
              end else begin
                ContentTransfer := ADecoder.Headers.Values[SContentTransferEncoding];  {do not localize}
                Headers.Add('Content-Transfer-Encoding: '+ ADecoder.Headers.Values[SContentTransferEncoding]); {do not localize}
              end;
            end;
            ContentDisposition := ADecoder.Headers.Values['Content-Disposition']; {do not localize}
            ContentID := ADecoder.Headers.Values['Content-ID'];                   {do not localize}
            ContentLocation := ADecoder.Headers.Values['Content-Location'];       {do not localize}
            ExtraHeaders.NameValueSeparator := '=';                               {do not localize}
            for i := 0 to ADecoder.Headers.Count-1 do begin
              if Headers.IndexOfName(ADecoder.Headers.Names[i]) < 0 then begin
                ExtraHeaders.Add(ADecoder.Headers.Strings[i]);
              end;
            end;
          end;
          Filename := ADecoder.Filename;
          if TextIsSame(Copy(ContentType, 1, 10), 'multipart/') then begin  {do not localize}
            ParentPart := LPreviousParentPart;
          end else begin
            ParentPart := LParentPart;
          end;
          if ParentPart <> -1 then begin
            Boundary := AMsg.MIMEBoundary.FindBoundary(AMsg.MessageParts.Items[ParentPart].Headers.Values[SContentType]); {do not localize}
          end else begin
            Boundary := AMsg.MIMEBoundary.FindBoundary(AMsg.Headers.Values[SContentType]);                                {do not localize}
          end;
          ADecoder.Free;
        finally FinishTempStream; end;
      except
        //This should also remove the Item from the TCollection.
        //Note that Delete does not exist in the TCollection.
        AMsg.MessageParts[Index].Free;
        Free;
      end;
    end;
  end;

begin
  LMsgEnd := False;
  if AMsg.NoDecode then begin
    IOHandler.Capture(AMsg.Body, ADelim);
  end else begin
    BeginWork(wmRead); try
      if (
       ((AMsg.Encoding = meMIME) and (AMsg.MIMEBoundary.Count > 0))
       or ((AMsg.Encoding = mePlainText) and (not TextIsSame(AMsg.ContentTransferEncoding, 'base64'))  {do not localize}
          and (not TextIsSame(AMsg.ContentTransferEncoding, 'quoted-printable')))                      {do not localize}
       ) then begin
        {NOTE: You hit this code path with multipart MIME messages and with
        plain-text messages (which may have UUE or XXE attachments embedded).}
        LActiveDecoder := nil;
        repeat
          {CC: This code assumes the preamble text (before the first boundary)
          is plain text.  I cannot imagine it not being, but if it arises, lines
          will have to be decoded.}
          LLine := IOHandler.ReadLn;
          if LLine = ADelim then begin
            Break;
          end;
          if LActiveDecoder = nil then begin
            LActiveDecoder := TIdMessageDecoderList.CheckForStart(AMsg, LLine);
          end;
          // Check again, the if above can set it.
          if LActiveDecoder = nil then begin
            if (LLine <> '') and (LLine[1] = '.') then begin             {do not localize}
              Delete(LLine, 1, 1);
            end;
            AMsg.Body.Add(LLine);
          end else begin
            RemoveLastBlankLine(AMsg.Body);
            while LActiveDecoder <> nil do begin
              LActiveDecoder.SourceStream := TIdTCPStream.Create(Self);
              LPreviousParentPart := AMsg.MIMEBoundary.ParentPart;
              LActiveDecoder.ReadHeader;
              case LActiveDecoder.PartType of
                mcptUnknown:
                  EIdException.Toss(RSMsgClientUnkownMessagePartType);
                mcptText:
                  LActiveDecoder := ProcessTextPart(LActiveDecoder);
                mcptAttachment:
                  LActiveDecoder := ProcessAttachment(LActiveDecoder);
              end;
            end;
          end;
        until LMsgEnd;
        RemoveLastBlankLine(AMsg.Body);
      end else begin
        {These are single-part MIMEs, or else mePlainTexts with the body encoded QP/base64}
        AMsg.IsMsgSinglePartMime := True;
        LActiveDecoder := TIdMessageDecoderMime.Create(AMsg);
        LActiveDecoder.SourceStream := TIdTCPStream.Create(Self);
        TIdMessageDecoderMime(LActiveDecoder).CheckAndSetType(AMsg.ContentType, AMsg.ContentDisposition);
        case LActiveDecoder.PartType of
          mcptUnknown:    EIdException.Toss(RSMsgClientUnkownMessagePartType);
          mcptText:       ProcessTextPart(LActiveDecoder, True); //Put the text into TIdMessage.Body
          mcptAttachment: ProcessAttachment(LActiveDecoder);
        end;
      end;
    finally EndWork(wmRead); end;
  end;
end;

procedure TIdMessageClient.SendHeader(AMsg: TIdMessage);
begin
  AMsg.GenerateHeader;
  IOHandler.Write(AMsg.LastGeneratedHeaders);
end;

procedure TIdMessageClient.SendBody(AMsg: TIdMEssage);
var
  i: Integer;
  LAttachment: TIdAttachment;
  LBoundary: string;
  LDestStream: TIdStream;
  LSrcStream: TIdStreamVCL;
  LStrStream: TIdStreamVCL;
  ISOCharset: string;
  HeaderEncoding: Char;  { B | Q }
  TransferEncoding: TTransfer;
  LEncoder: TIdMessageEncoder;
  LLine: string;
  LX: integer;

  function GetLine(ASrcStream: TStream; var ALine: string): Boolean;
  {Gets the next character, adding an extra '.' if line starts with a '.'}
  var
    LChar: Char;
    LGotAChar: Boolean;
  begin
    LGotAChar := False;
    Result := True;
    ALine := '';
    while ReadCharFromStream(ASrcStream, LChar) > 0 do begin
      if ((LGotAChar = False) and (LChar = '.')) then begin
        {Lines that start with a '.' are required to have an extra '.'
        inserted per RFC 821.}
        ALine := ALine + LChar;
      end;
      LGotAChar := True;
      if LChar = #13 then begin
        {Get the LF after the CR...}
        ReadCharFromStream(ASrcStream, LChar);
        ALine := ALine + EOL;
        Exit;
      end;
      ALine := ALine + LChar;
    end;
    if LGotAChar = False then begin
      Result := False;
    end;
  end;

  procedure WriteTextPart(ATextPart: TIdText);
  var
    LData: string;
    LDestStream: TIdStream;
    LStrStream: TIdStreamVCL;
    LBodyLine: String;
    i: Integer;
  begin
    if ATextPart.ContentType = '' then begin
      ATextPart.ContentType := 'text/plain'; {do not localize}
    end;
    if ATextPart.ContentTransfer = '' then begin
      ATextPart.ContentTransfer := 'quoted-printable'; {do not localize}
    end;
    IOHandler.WriteLn(GenerateTextPartContentType(ATextPart.ContentType, ATextPart.CharSet));

    if ( (not TextIsSame(ATextPart.ContentTransfer, 'quoted-printable')) {do not localize}
     and (not TextIsSame(ATextPart.ContentTransfer, 'base64')) {do not localize}
     and ATextPart.IsBodyEncodingRequired ) then begin
      ATextPart.ContentTransfer := '8bit';                    {do not localize}
    end;
    IOHandler.WriteLn(SContentTransferEncoding + ': ' + ATextPart.ContentTransfer); {do not localize}

    if ATextPart.ContentID <> '' then begin
      IOHandler.WriteLn('Content-ID: ' + ATextPart.ContentID);  {do not localize}
    end;

    LX := ATextPart.ExtraHeaders.Count;  {Debugging}
    IOHandler.Write(ATextPart.ExtraHeaders);
    IOHandler.WriteLn('');

    if TextIsSame(ATextPart.ContentTransfer, 'quoted-printable') then begin {do not localize}
      LData := '';
      for i := 0 to ATextPart.Body.Count - 1 do begin
        LBodyLine := ATextPart.Body[i];
        if (LBodyLine <> '') and (LBodyLine[1] = '.') then begin           {do not localize}
          ATextPart.Body[i] := '.' + LBodyLine;                            {do not localize}
        end;
        LData := TIdEncoderQuotedPrintable.EncodeString(ATextPart.Body[i] + EOL);
        if TransferEncoding = iso2022jp then begin
          IOHandler.Write(Encode2022JP(LData))
        end else begin
          IOHandler.Write(LData);
        end;
      end;
      if (LData <> '') and not CharIsInEOF(LData, Length(LData)) then begin
        { The last line has no line break, add it to get a blank line when
          WriteTextPart returns. This should not happen because quoted-printable
          does not remove the EOL. }
        IOHandler.WriteLn('');
      end;
    end else if TextIsSame(ATextPart.ContentTransfer, 'base64') then begin  {do not localize}
      LDestStream := TIdTCPStream.Create(Self); try
        LEncoder := TIdMessageEncoder(TIdMessageEncoderMIME.Create(Self)); try
          LStrStream := TIdStreamVCL.Create(TIdStringStream.Create(''), True); try
            ATextPart.Body.SaveToStream(LStrStream.VCLStream);
            LStrStream.Position := 0;
            LEncoder.Encode(LStrStream, LDestStream);
          finally Sys.FreeAndNil(LStrStream); end;
        finally Sys.FreeAndNil(LEncoder); end;
      finally Sys.FreeAndNil(LDestStream); end;
    end else begin
      LX := ATextPart.Body.Count;
      IOHandler.Write(ATextPart.Body);
      { No test for last line break necessary because IOHandler.Write(TIdStrings) uses WriteLn. }
    end;
  end;

var
  LBodyLine: String;
  LTextPart: TIdText;
  LAddedTextPart: Boolean;
  LLastPart: integer;
  LBinHex4Encoder: TIdEncoderBinHex4;
begin
  LBoundary := '';
  AMsg.InitializeISO(TransferEncoding, HeaderEncoding, ISOCharSet);
  BeginWork(wmWrite); try
    if ((AMsg.IsMsgSinglePartMime = False) and (TextIsSame(AMsg.ContentTransferEncoding, 'base64') or {do not localize}
      TextIsSame(AMsg.ContentTransferEncoding, 'quoted-printable'))) then begin  {do not localize}
      //CC2: The user wants the body encoded.
      if AMsg.MessageParts.Count > 0 then begin
        //CC2: We cannot deal with parts within a body encoding (user has to do
        //this manually, if the user really wants to). Note this should have been trapped in TIdMessage.GenerateHeader.
        raise EIdException.Create(RSMsgClientInvalidForTransferEncoding);
      end;
      IOHandler.WriteLn('');     //This is the blank line after the headers
      DoStatus(hsStatusText, [RSMsgClientEncodingText]);
      //CC2: Now output AMsg.Body in the chosen encoding...
      LDestStream := TIdTCPStream.Create(Self); try
        if TextIsSame(AMsg.ContentTransferEncoding, 'base64') then begin  {do not localize}
          LEncoder := TIdMessageEncoder(TIdMessageEncoderMIME.Create(Self));
        end else begin  {'quoted-printable'}
          LEncoder := TIdMessageEncoder(TIdMessageEncoderQuotedPrintable.Create(Self));
        end;
        try
          LStrStream := TIdStreamVCL.Create(TIdStringStream.Create(''), True); try
            AMsg.Body.SaveToStream(LStrStream.VCLStream);
            LStrStream.Position := 0;
            LEncoder.Encode(LStrStream, LDestStream);
          finally
            Sys.FreeAndNil(LStrStream);
          end;
        finally
          Sys.FreeAndNil(LEncoder)
        end;
      finally
        Sys.FreeAndNil(LDestStream);
      end;
    end else if AMsg.Encoding = mePlainText then begin
      IOHandler.WriteLn('');     //This is the blank line after the headers
      //CC2: It is NOT Mime.  It is a body followed by optional attachments
      DoStatus(hsStatusText, [RSMsgClientEncodingText]);
      // Write out Body first
      //TODO: Why just iso2022jp? Why not someting generic for all MBCS? Or is iso2022jp special?
      if TransferEncoding = iso2022jp then begin
        for i := 0 to AMsg.Body.Count - 1 do begin
          LBodyLine := AMsg.Body[i];
          if (LBodyLine>'') and (LBodyLine = '.') then begin  {do not localize}
            IOHandler.WriteLn('.' + Encode2022JP(LBodyLine)); {do not localize}
          end else begin
            IOHandler.WriteLn(Encode2022JP(LBodyLine));
          end;
        end;
      end else begin
        WriteBodyText(AMsg);
      end;
      IOHandler.WriteLn('');
      if AMsg.MessageParts.Count > 0 then begin
        //The message has attachments.
        for i := 0 to AMsg.MessageParts.Count - 1 do begin
          //CC: Added support for TIdText...
          if AMsg.MessageParts.Items[i] is TIdText then begin
            IOHandler.WriteLn('');
            IOHandler.WriteLn('------- Start of text attachment -------'); {do not localize}
            DoStatus(hsStatusText,  [RSMsgClientEncodingText]);
            WriteTextPart(AMsg.MessageParts.Items[i] as TIdText);
            IOHandler.WriteLn('------- End of text attachment -------');   {do not localize}
          end else if AMsg.MessageParts.Items[i] is TIdAttachment then begin
            DoStatus(hsStatusText, [RSMsgClientEncodingAttachment]);
            if AMsg.MessageParts[i].ContentTransfer = '' then begin
              //The user has nothing specified: see has he set a preference in
              //TIdMessage.AttachmentEncoding (AttachmentEncoding is really an
              //old and somewhat deprecated property, but we can still support it)...
              if ((AMsg.AttachmentEncoding = 'UUE') or (AMsg.AttachmentEncoding = 'XXE')) then begin  {do not localize}
                AMsg.MessageParts[i].ContentTransfer := AMsg.AttachmentEncoding;
              end else begin
                //We default to UUE (rather than XXE)...
                AMsg.MessageParts[i].ContentTransfer := 'UUE';  {do not localize}
              end;
            end;
            if TextIsSame(AMsg.MessageParts[i].ContentTransfer, 'UUE') then begin          {do not localize}
              LEncoder := TIdMessageEncoderUUE.Create(nil);
            end else if TextIsSame(AMsg.MessageParts[i].ContentTransfer, 'XXE') then begin {do not localize}
              LEncoder := TIdMessageEncoderXXE.Create(nil);
            end;

            LDestStream := TIdTCPStream.Create(Self);
            try
              with LEncoder do
              try
                Filename := TIdAttachment(AMsg.MessageParts[i]).Filename;
                LSrcStream := TIdStreamVCL.Create(TIdAttachment(AMsg.MessageParts[i]).OpenLoadStream);
                try
                  Encode(LSrcStream, LDestStream);
                finally
                  TIdAttachment(AMsg.MessageParts[i]).CloseLoadStream;
                  LSrcStream.Free;
                end;
              finally
                Free;
              end;
            finally
              Sys.FreeAndNil(LDestStream);
            end;
          end;
          IOHandler.WriteLn('');
        end;
      end;
    end else begin
      //CC2: It is MIME-encoding...
      LAddedTextPart := False;
      //######### OUTPUT THE PREAMBLE TEXT ########
      {For single-part MIME messages, we want the message part headers to be appended
      to the message headers.  Otherwise, add the blank separator between header and
      body...}
      if AMsg.IsMsgSinglePartMime = False then begin
        IOHandler.WriteLn('');     //This is the blank line after the headers
        //if AMsg.Body.Count > 0 then begin
        if AMsg.IsBodyEmpty = False then begin
          //CC2: The message has a body text.  There are now a few possibilities.
          //First up, if ConvertPreamble is False then the user explicitly does not want us
          //to convert the .Body since he had to change it from the default False.
          //Secondly, if AMsg.MessageParts.TextPartCount > 0, he may have put the
          //message text in the part, so don't convert the body.
          //Thirdly, if AMsg.MessageParts.Count = 0, then it has no other parts
          //anyway: in this case, output it without boundaries. 
          //if (AMsg.ConvertPreamble and (AMsg.MessageParts.TextPartCount = 0)) then begin
          if (AMsg.ConvertPreamble and (AMsg.MessageParts.TextPartCount = 0) and (AMsg.MessageParts.Count > 0)) then begin
            //CC2: There is no text part, the user has not changed ConvertPreamble from
            //its default of True, so the user has probably put his message into
            //the body by mistake instead of putting it in a TIdText part.
            //Create a TIdText part from the .Body text...
            LTextPart := TIdText.Create(AMsg.MessageParts);
            LTextPart.Body.Text := AMsg.Body.Text;
            LTextPart.ContentType := 'text/plain';  {do not localize}
            LTextPart.ContentTransfer := '7bit';    {do not localize}
            //Have to remember that we added a text part, which is the last part
            //in the collection, because we need it to be outputted first...
            LAddedTextPart := True;
            //CC2: Insert our standard preamble text...
            IOHandler.WriteLn(SThisIsMultiPartMessageInMIMEFormat);
          end else begin
            //CC2: Hopefully the user has put suitable text in the preamble, or this
            //is an already-received message which already has a preamble text...
            WriteBodyText(AMsg);
          end;
        end else begin
          //CC2: The user has specified no body text: he presumably has the message in
          //a TIdText part, but it may have no text at all (a message consisting only
          //of headers, which is allowed under the RFC, which will have a parts count
          //of 0).
          if AMsg.MessageParts.Count <> 0 then begin
            //Add the "standard" MIME preamble text for non-html email clients...
            IOHandler.WriteLn(SThisIsMultiPartMessageInMIMEFormat);
          end;
        end;
        IOHandler.WriteLn('');
        //######### SET UP THE BOUNDARY STACK ########
        AMsg.MIMEBoundary.Clear;
        LBoundary := IdMIMEBoundaryStrings.IndyMIMEBoundary;
        AMsg.MIMEBoundary.Push(LBoundary, -1);  //-1 is "top level"
      end;
      //######### OUTPUT THE PARTS ########
      //CC2: Write the text parts in their order, if you change the order you
      //can mess up mutipart sequences.
      //The exception is due to ConvertPreamble, which may have added a text
      //part at the end (the only place a TIdText part can be added), but it
      //needs to be outputted first...
      LLastPart := AMsg.MessageParts.Count - 1;
      if LAddedTextPart then begin
          IOHandler.WriteLn('--' + LBoundary);       {do not localize}
          DoStatus(hsStatusText,  [RSMsgClientEncodingText]);
          WriteTextPart(AMsg.MessageParts.Items[LLastPart] as TIdText);
          IOHandler.WriteLn('');
          Dec(LLastPart);  //Don't output it again in the following "for" loop
      end;
      for i := 0 to LLastPart do begin
        LLine := AMsg.MessageParts.Items[i].ContentType;
        if TextIsSame(Copy(LLine, 1, 10), 'multipart/') then begin  {do not localize}
          //A multipart header.  Write out the CURRENT boundary first...
          IOHandler.WriteLn('--' + LBoundary);      {do not localize}
          //Make the current boundary and this part number active...
          //Now need to generate a new boundary by adding a random character to
          //the current boundary...
          LBoundary := LBoundary + IdMIMEBoundaryStrings.GenerateRandomChar;
          AMsg.MIMEBoundary.Push(LBoundary, i);
          IOHandler.WriteLn('Content-Type: ' + LLine + ';');            {do not localize}
          IOHandler.WriteLn('        boundary="' + LBoundary + '"');  {do not localize}
          IOHandler.WriteLn('');
        end else begin
          //Not a multipart header, see if it is a part change...
          if AMsg.IsMsgSinglePartMime = False then begin
            while AMsg.MessageParts.Items[i].ParentPart <> AMsg.MIMEBoundary.ParentPart do begin
              IOHandler.WriteLn('--' + LBoundary + '--');  {do not localize}
              IOHandler.WriteLn('');
              AMsg.MIMEBoundary.Pop;  //This also pops AMsg.MIMEBoundary.ParentPart
              LBoundary := AMsg.MIMEBoundary.Boundary;
            end;
            IOHandler.WriteLn('--' + LBoundary);  {do not localize}
          end;
          if AMsg.MessageParts.Items[i] is TIdText then begin
            DoStatus(hsStatusText,  [RSMsgClientEncodingText]);
            WriteTextPart(AMsg.MessageParts.Items[i] as TIdText);
            IOHandler.WriteLn('');
          end
          else
          if AMsg.MessageParts.Items[i] is TIdAttachment then begin
            LAttachment := TIdAttachment(AMsg.MessageParts[i]);
            DoStatus(hsStatusText, [RSMsgClientEncodingAttachment]);
            if LAttachment.ContentTransfer = '' then begin
              LAttachment.ContentTransfer := 'base64'; {do not localize}
            end;
            if LAttachment.ContentDisposition = '' then begin
              LAttachment.ContentDisposition := 'attachment'; {do not localize}
            end;
            if LAttachment.ContentType = '' then begin
              if TextIsSame(LAttachment.ContentTransfer, 'base64') then begin {do not localize}
                LAttachment.ContentType := 'application/octet-stream'; {do not localize}
              end else begin
                {CC4: Set default type if not base64 encoded...}
                LAttachment.ContentType := 'text/plain'; {do not localize}
              end;
            end;
            if TextIsSame(LAttachment.ContentTransfer, 'binhex40') then begin   {do not localize}
              //This is special - you do NOT write out any Content-Transfer-Encoding
              //header!  We also have to write a Content-Type specified in RFC 1741
              //(overriding any ContentType present, if necessary).
              LAttachment.ContentType := 'application/mac-binhex40';            {do not localize}
              if LAttachment.CharSet <> '' then begin
                IOHandler.WriteLn('Content-Type: '+LAttachment.ContentType+'; charset="'+LAttachment.CharSet+'";'); {do not localize}
              end else begin
                IOHandler.WriteLn('Content-Type: '+LAttachment.ContentType+';'); {do not localize}
              end;
              IOHandler.WriteLn('        name="' + Sys.ExtractFileName(LAttachment.FileName) + '"'); {do not localize}
            end else begin
              if LAttachment.CharSet <> '' then begin
                IOHandler.WriteLn('Content-Type: ' + RemoveHeaderEntry(LAttachment.ContentType, 'charset')  {do not localize}
                 + '; charset="'+LAttachment.CharSet+'";'); {do not localize}
              end else begin
                IOHandler.WriteLn('Content-Type: ' + LAttachment.ContentType + ';'); {do not localize}
              end;
              IOHandler.WriteLn('        name="' + Sys.ExtractFileName(LAttachment.FileName) + '"'); {do not localize}
              IOHandler.WriteLn('Content-Transfer-Encoding: ' + LAttachment.ContentTransfer); {do not localize}
              IOHandler.WriteLn('Content-Disposition: ' + LAttachment.ContentDisposition +';'); {do not localize}
              IOHandler.WriteLn('        filename="' + Sys.ExtractFileName(LAttachment.FileName) + '"'); {do not localize}
            end;
            if LAttachment.ContentID <> '' then begin
              IOHandler.WriteLn('Content-ID: '+ LAttachment.ContentID); {Do not Localize}
            end;
            IOHandler.Write(LAttachment.ExtraHeaders);
            IOHandler.WriteLn('');
            LDestStream := TIdTCPStream.Create(Self);
            try
              if ((TextIsSame(LAttachment.ContentTransfer, 'base64') = False) and {do not localize}
               (TextIsSame(LAttachment.ContentTransfer, 'quoted-printable') = False) and {do not localize}
               (TextIsSame(LAttachment.ContentTransfer, 'binhex40') = False)) then begin {do not localize}
                LSrcStream := TIdStreamVCL.Create(TIdAttachment(AMsg.MessageParts[i]).OpenLoadStream);
                try
                  while GetLine(LSrcStream.VCLStream, LLine) do begin
                    LDestStream.Write(LLine);
                  end;
                finally
                  TIdAttachment(AMsg.MessageParts[i]).CloseLoadStream;
                  LSrcStream.Free;
                end;
              end else begin
                if TextIsSame(LAttachment.ContentTransfer, 'binhex40') then begin  {do not localize}
                  //This is different, it has to create a header that includes CRC checks
                  LBinHex4Encoder := TIdEncoderBinHex4.Create(Self);
                  try
                    LSrcStream := TIdStreamVCL.Create(TIdAttachment(AMsg.MessageParts[i]).OpenLoadStream);
                    try
                      LBinHex4Encoder.EncodeFile(TIdAttachment(AMsg.MessageParts[i]).Filename,
                       LSrcStream, LDestStream);
                    finally
                      TIdAttachment(AMsg.MessageParts[i]).CloseLoadStream;
                      LSrcStream.Free;
                    end;
                  finally
                    LBinHex4Encoder.Free;
                  end;
                end else begin
                  if TextIsSame(LAttachment.ContentTransfer, 'base64') then begin {do not localize}
                    LEncoder := TIdMessageEncoder(TIdMessageEncoderMIME.Create(Self));
                  end else begin  {'quoted-printable'}
                    LEncoder := TIdMessageEncoder(TIdMessageEncoderQuotedPrintable.Create(Self));
                  end;
                  try
                    LEncoder.Filename := TIdAttachment(AMsg.MessageParts[i]).Filename;
                    LSrcStream := TIdStreamVCL.Create(TIdAttachment(AMsg.MessageParts[i]).OpenLoadStream);
                    try
                      LEncoder.Encode(LSrcStream, LDestStream);
                    finally
                      TIdAttachment(AMsg.MessageParts[i]).CloseLoadStream;
                      LSrcStream.Free;
                    end;
                  finally
                    LEncoder.Free;
                  end;
                end;
              end;
            finally
              Sys.FreeAndNil(LDestStream);
            end;
            IOHandler.WriteLn('');
          end;
        end;
      end;
      if AMsg.MessageParts.Count > 0 then begin
        for i := 0 to AMsg.MIMEBoundary.Count - 1 do begin
          IOHandler.WriteLn('--' + AMsg.MIMEBoundary.Boundary + '--');
          IOHandler.WriteLn('');
          AMsg.MIMEBoundary.Pop;
        end;
      end;
    end;
  finally EndWork(wmWrite); end;
end;

procedure TIdMessageClient.SendMsg(AMsg: TIdMessage; AHeadersOnly: Boolean = False);
begin
  if AMsg.NoEncode then begin
    BeginWork(wmWrite); try
      IOHandler.Write(AMsg.Headers);
      IOHandler.WriteLn('');
      if not AHeadersOnly then begin
        IOHandler.Write(AMsg.Body);
      end;
    finally EndWork(wmWrite); end;
  end else begin
    SendHeader(AMsg);
    if (not AHeadersOnly) then begin
      SendBody(AMsg);
    end;
  end;
end;

function TIdMessageClient.ReceiveHeader(AMsg: TIdMessage; const AAltTerm: string = ''): string;
begin
  BeginWork(wmRead); try
    repeat
      Result := IOHandler.ReadLn;
      // Exchange Bug: Exchange sometimes returns . when getting a message instead of
      // '' then a . - That is there is no seperation between the header and the message for an
      // empty message.
      if ((Length(AAltTerm) = 0) and (Result = '.')) or  {do not localize}
         ({APR: why? (Length(AAltTerm) > 0) and }(Result = AAltTerm)) then begin
        Break;
      end else if Result <> '' then begin
        AMsg.Headers.Append(Result);
      end;
    until False;
    AMsg.ProcessHeaders;
  finally EndWork(wmRead); end;
end;

procedure TIdMessageclient.ProcessMessage(AMsg: TIdMessage; AHeaderOnly: Boolean = False);
begin
  if IOHandler <> nil then begin
    //Don't call ReceiveBody if the message ended at the end of the headers
    //(ReceiveHeader() would have returned '.' in that case)...
    if ReceiveHeader(AMsg) = '' then begin
      if not AHeaderOnly then begin
        ReceiveBody(AMsg);
      end;
    end;
  end;
end;

procedure TIdMessageClient.ProcessMessage(AMsg: TIdMessage; AStream: TStream; AHeaderOnly: Boolean = False);
begin
  IOHandler := TIdIOHandlerStreamMsg.Create(nil, AStream);
  try
    TIdIOHandlerStreamMsg(IOHandler).FreeStreams := False;
    IOHandler.Open;
    //Don't call ReceiveBody if the message ended at the end of the headers
    //(ReceiveHeader() would have returned '.' in that case)...
    if ReceiveHeader(AMsg) = '' then begin
      if not AHeaderOnly then begin
        ReceiveBody(AMsg);
      end;
    end;
  finally
    IOHandler.Free;
    IOHandler := nil;
  end;
end;

procedure TIdMessageClient.ProcessMessage(AMsg: TIdMessage; const AFilename: string; AHeaderOnly: Boolean = False);
var
  LStream: TFileStream;
begin
  LStream := TReadFileExclusiveStream.Create(AFileName); try
    ProcessMessage(AMsg, LStream, AHeaderOnly);
  finally Sys.FreeAndNil(LStream); end;
end;

procedure TIdMessageClient.WriteBodyText(AMsg: TIdMessage);
var
  i: integer;
  LBodyLine: String;
begin
  for i := 0 to AMsg.Body.Count - 1 do begin
    LBodyLine := AMsg.Body[i];
    if Copy(AMsg.Body[i], 1, 1) = '.' then  {do not localize}
    begin
      IOHandler.WriteLn('.' + LBodyLine);   {do not localize}
    end
    else begin
      IOHandler.WriteLn(LBodyLine);
    end;
  end;
end;

destructor TIdMessageClient.Destroy;
begin
  inherited;
end;

end.
