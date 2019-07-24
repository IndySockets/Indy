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
   Rev 1.85    1/6/05 4:38:30 PM  RLebeau
 Bug fix for decoding Text part headers
}
{
   Rev 1.84    11/30/04 10:44:44 AM  RLebeau
 Bug fix for previous checkin
}
{
   Rev 1.83    11/30/2004 12:10:40 PM  JPMugaas
 Fix for compiler error.
}
{
   Rev 1.82    11/28/04 2:22:04 PM  RLebeau
 Updated a few hard-coded strings to use resource strings instead
}
{
   Rev 1.81    28/11/2004 20:08:14  CCostelloe
 MessagePart.Boundary now (correctly) holds decoded MIME boundary
}
{
   Rev 1.80    11/27/2004 8:58:14 PM  JPMugaas
 Compile errors.
}
{
   Rev 1.79    10/26/2004 10:25:46 PM  JPMugaas
 Updated refs.
}
{
   Rev 1.78    24.09.2004 02:16:48  Andreas Hausladen
 Added ReadTIdBytesFromStream and ReadCharFromStream function to supress .NET
 warnings.
}
{
   Rev 1.77    27.08.2004 22:04:32  Andreas Hausladen
 speed optimization ("const" for string parameters)
 Fixed "blank line multiplication"
}
{
   Rev 1.76    27.08.2004 00:21:32  Andreas Hausladen
 Undo last changes (temporary)
}
{
   Rev 1.75    26.08.2004 22:14:16  Andreas Hausladen
 Fixed last line blank line read/write bug
}
{
   Rev 1.74    7/23/04 7:17:20 PM  RLebeau
 TFileStream access right tweak for ProcessMessage()
}
{
   Rev 1.73    28/06/2004 23:58:12  CCostelloe
 Bug fix
}
{
    Rev 1.72    6/11/2004 9:38:08 AM  DSiders
  Added "Do not Localize" comments.
}
{
   Rev 1.71    2004.06.06 4:53:04 PM  czhower
 Undid 1.70. Not needed, just masked an existing bug and did not fix it.
}
{
   Rev 1.70    06/06/2004 01:23:54  CCostelloe
 OnWork fix
}
{
   Rev 1.69    6/4/04 12:41:56 PM  RLebeau
 ContentTransferEncoding bug fix
}
{
   Rev 1.68    2004.05.20 1:39:08 PM  czhower
 Last of the IdStream updates
}
{
   Rev 1.67    2004.05.20 11:36:52 AM  czhower
 IdStreamVCL
}
{
   Rev 1.66    2004.05.20 11:12:56 AM  czhower
 More IdStream conversions
}
{
   Rev 1.65    2004.05.19 3:06:34 PM  czhower
 IdStream / .NET fix
}
{
   Rev 1.64    19/05/2004 00:54:30  CCostelloe
 Bug fix (though I claim in my defence that it is only a hint fix)
}
{
   Rev 1.63    16/05/2004 18:55:06  CCostelloe
 New TIdText/TIdAttachment processing
}
{
   Rev 1.62    2004.05.03 11:15:16 AM  czhower
 Fixed compile error and added use of constants.
}
{
   Rev 1.61    5/2/04 8:02:12 PM  RLebeau
 Updated TIdIOHandlerStreamMsg to keep track of the last character received
 from the stream so that extra CR LF characters are not added to the end of
 the message data unnecessarily.
}
{
   Rev 1.60    4/23/04 1:54:58 PM  RLebeau
 One more tweak for TIdIOHandlerStreamMsg support
}
{
   Rev 1.59    4/23/04 1:21:16 PM  RLebeau
 Minor tweaks for TIdIOHandlerStreamMsg support
}
{
   Rev 1.58    23/04/2004 20:48:10  CCostelloe
 Added TIdIOHandlerStreamMsg to stop looping if no terminating \r\n.\r\n and
 added support for emails that are attachments only
}
{
   Rev 1.57    2004.04.18 1:39:22 PM  czhower
 Bug fix for .NET with attachments, and several other issues found along the
 way.
}
{
   Rev 1.56    2004.04.16 11:31:00 PM  czhower
 Size fix to IdBuffer, optimizations, and memory leaks


   Rev 1.55    2004.03.07 10:36:08 AM  czhower
 SendMsg now calls OnWork with NoEncode = True


   Rev 1.54    2004.03.04 1:02:58 AM  czhower
 Const removed from arguemtns (1 not needed + 1 incorrect)


   Rev 1.53    2004.03.03 7:18:32 PM  czhower
 Fixed AV bug with ProcessMessage


   Rev 1.52    2004.03.03 11:54:34 AM  czhower
 IdStream change


   Rev 1.51    2/3/04 12:25:50 PM  RLebeau
 Updated WriteTextPart() function inside of SendBody() to write the ContentID
 property is it is assigned.


   Rev 1.50    2004.02.03 5:44:02 PM  czhower
 Name changes


   Rev 1.49    2004.02.03 2:12:16 PM  czhower
 $I path change


   Rev 1.48    1/27/2004 4:04:06 PM  SPerry
 StringStream ->IdStringStream


   Rev 1.47    2004.01.27 12:03:28 AM  czhower
 Properly named a local variable to fix a .net conflict.


   Rev 1.46    1/25/2004 3:52:32 PM  JPMugaas
 Fixes for abstract SSL interface to work in NET.


   Rev 1.45    24/01/2004 19:24:30  CCostelloe
 Cleaned up warnings


   Rev 1.44    1/21/2004 1:30:06 PM  JPMugaas
 InitComponent


   Rev 1.43    16/01/2004 17:39:34  CCostelloe
 Added support for BinHex 4.0 encoding


   Rev 1.42    11/01/2004 19:53:40  CCostelloe
 Revisions for TIdMessage SaveToFile & LoadFromFile for D7 & D8


   Rev 1.40    08/01/2004 23:46:16  CCostelloe
 Changes to ProcessMessage to get TIdMessage.LoadFromFile working in D7


   Rev 1.39    08/01/2004 00:31:06  CCostelloe
 Start of reimplementing LoadFrom/SaveToFile


   Rev 1.38    22/12/2003 00:44:52  CCostelloe
 .NET fixes


   Rev 1.37    11/11/2003 12:06:26 AM  BGooijen
 Did all todo's ( TStream to TIdStream mainly )


   Rev 1.36    2003.10.24 10:43:10 AM  czhower
 TIdSTream to dos


    Rev 1.35    10/17/2003 12:37:36 AM  DSiders
  Added localization comments.
  Added resource string for exception message.


   Rev 1.34    2003.10.14 9:57:12 PM  czhower
 Compile todos


   Rev 1.33    10/12/2003 1:49:56 PM  BGooijen
 Changed comment of last checkin


   Rev 1.32    10/12/2003 1:43:40 PM  BGooijen
 Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc


   Rev 1.30    10/11/2003 4:21:14 PM  BGooijen
 Compiles in D7 again


   Rev 1.29    10/10/2003 10:42:28 PM  BGooijen
 DotNet


   Rev 1.28    9/10/2003 1:50:52 PM  SGrobety
 DotNet


   Rev 1.27    10/8/2003 9:53:42 PM  GGrieve
 Remove $IFDEFs


   Rev 1.26    05/10/2003 16:39:52  CCostelloe
 Set default ContentType


   Rev 1.25    03/10/2003 21:03:40  CCostelloe
 Bug fixes


   Rev 1.24    2003.10.02 9:27:52 PM  czhower
 DotNet Excludes


   Rev 1.23    01/10/2003 17:58:56  HHariri
 More fixes for Multipart Messages and also fixes for incorrect transfer
 encoding settings


   Rev 1.20    01/10/2003 10:57:56  CCostelloe
 Fixed GenerateTextPartContentType (was ignoring ContentType)


   Rev 1.19    26/09/2003 01:03:48  CCostelloe
 Modified ProcessAttachment in ReceiveBody to update message's Encoding if
 attachment was XX-encoded.  Added decoding of message bodies encoded as
 base64 or quoted-printable.  Added support for nested MIME parts
 (ParentPart).  Added support for TIdText in UU and XX encoding.  Added
 missing base64 and QP support where needed. Rewrote/rearranged most of code.


   Rev 1.18    04/09/2003 20:44:56  CCostelloe
 In SendBody, removed blank line between boundaries and Text part header;
 recoded wDoublePoint


   Rev 1.17    30/08/2003 18:40:44  CCostelloe
 Updated to use IdMessageCoderMIME's new random boundaries


   Rev 1.16    8/8/2003 12:27:18 PM  JPMugaas
 Should now compile.


   Rev 1.15    07/08/2003 00:39:06  CCostelloe
 Modified SendBody to deal with unencoded attachments (otherwise 7bit
 attachments had the attachment header written out as 7bit but was encoded as
 base64)


   Rev 1.14    11/07/2003 01:14:20  CCostelloe
 SendHeader changed to support new IdMessage.GenerateHeader putting generated
 headers in IdMessage.LastGeneratedHeaders.


   Rev 1.13    6/15/2003 01:13:10 PM  JPMugaas
 Minor fixes and cleanups.


   Rev 1.12    5/18/2003 02:31:44 PM  JPMugaas
 Reworked some things so IdSMTP and IdDirectSMTP can share code including
 stuff for pipelining.


   Rev 1.11    5/8/2003 03:18:06 PM  JPMugaas
 Flattened ou the SASL authentication API, made a custom descendant of SASL
 enabled TIdMessageClient classes.


   Rev 1.10    5/8/2003 11:28:02 AM  JPMugaas
 Moved feature negoation properties down to the ExplicitTLSClient level as
 feature negotiation goes hand in hand with explicit TLS support.


   Rev 1.9    5/8/2003 02:17:58 AM  JPMugaas
 Fixed an AV in IdPOP3 with SASL list on forms.  Made exceptions for SASL
 mechanisms missing more consistant, made IdPOP3 support feature feature
 negotiation, and consolidated some duplicate code.


   Rev 1.8    3/17/2003 02:16:06 PM  JPMugaas
 Now descends from ExplicitTLS base class.


   Rev 1.7    2/24/2003 07:25:18 PM  JPMugaas
 Now compiles with new code.


   Rev 1.6    12-8-2002 21:12:36  BGooijen
 Changed calls to Writeln to  IOHandler.WriteLn, because the parent classes
 don't provide Writeln, System.Writeln was assumed by the compiler


   Rev 1.5    12-8-2002 21:08:58  BGooijen
 The TIdIOHandlerStream was not Opened before used, fixed that.


   Rev 1.4    12/6/2002 05:30:22 PM  JPMugaas
 Now decend from TIdTCPClientCustom instead of TIdTCPClient.


   Rev 1.3    12/5/2002 02:54:06 PM  JPMugaas
 Updated for new API definitions.


   Rev 1.2    11/23/2002 03:33:44 AM  JPMugaas
 Reverted changes because they were problematic.  Kudzu didn't explain why.


   Rev 1.1    11/19/2002 05:35:30 PM  JPMugaas
 Fixed problem with a line starting with a ".".  A double period should only
 be used if the line is really just one "." and no other cases.


   Rev 1.0    11/13/2002 07:56:58 AM  JPMugaas
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

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoderMIME,
  IdExplicitTLSClientServerBase,
  IdGlobal,
  IdHeaderList,
  IdIOHandlerStream,
  IdBaseComponent,
  IdMessage,
  IdTCPClient;

type
  TIdIOHandlerStreamMsg = class(TIdIOHandlerStream)
  protected
    FTerminatorWasRead: Boolean;
    FEscapeLines: Boolean;
    FUnescapeLines: Boolean;
    FLastByteRecv: Byte;
    function ReadDataFromSource(var VBuffer: TIdBytes): Integer; override;
  public
    constructor Create(
      AOwner: TComponent;
      AReceiveStream: TStream;
      ASendStream: TStream = nil
    ); override;  //Should this be reintroduce instead of override?
    function Readable(AMSec: Integer = IdTimeoutDefault): Boolean; override;
    function ReadLn(ATerminator: string; ATimeout: Integer = IdTimeoutDefault;
      AMaxLineLength: Integer = -1; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; override;
    procedure WriteLn(const AOut: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ); override;
    property EscapeLines: Boolean read FEscapeLines write FEscapeLines;
    property UnescapeLines: Boolean read FUnescapeLines write FUnescapeLines;
  published
    property MaxLineLength default MaxInt;
  end;

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
    procedure EncodeAndWriteText(const ABody: TStrings; AEncoding: IIdTextEncoding);
    procedure WriteFoldedLine(const ALine : string);
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
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
  //facilitate inlining only.
  {$IFDEF DOTNET}
  System.IO,
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  //TODO: Remove these references and make it completely pluggable. Check other spots in Indy as well
  IdMessageCoderBinHex4, IdMessageCoderQuotedPrintable, IdMessageCoderMIME,
  IdMessageCoderUUE, IdMessageCoderXXE,
  //
  IdGlobalProtocols,
  IdCoder, IdCoder3to4, IdCoderBinHex4,
  IdCoderHeader, IdHeaderCoderBase, IdMessageCoder, IdComponent, IdException,
  IdResourceStringsProtocols, IdTCPConnection, IdTCPStream, IdIOHandler,
  IdAttachmentFile, IdText, IdAttachment,
  SysUtils;

const
  SContentType = 'Content-Type'; {do not localize}
  SContentTransferEncoding = 'Content-Transfer-Encoding'; {do not localize}
  SThisIsMultiPartMessageInMIMEFormat = 'This is a multi-part message in MIME format'; {do not localize}

function GetLongestLine(var ALine : String; const ADelim : String) : String;
var
  i, fnd, delimLen : Integer;
begin
  Result := '';

  fnd := 0;
  delimLen := Length(ADelim);

  for i := 1 to Length(ALine) do
  begin
    if ALine[i] = ADelim[1] then
    begin
      if Copy(ALine, i, delimLen) = ADelim then
      begin
        fnd := i;
      end;
    end;
  end;

  if fnd > 0 then
  begin
    Result := Copy(ALine, 1, fnd - 1);
    ALine := Copy(ALine, fnd + delimLen, MaxInt);
  end;
end;

procedure RemoveLastBlankLine(Body: TStrings);
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
  AOwner: TComponent;
  AReceiveStream: TStream;
  ASendStream: TStream = nil
  );
begin
  inherited Create(AOwner, AReceiveStream, ASendStream);
  FTerminatorWasRead := False;
  FEscapeLines := False; // do not set this to True! This is for users to set manually...
  FUnescapeLines := False; // do not set this to True! This is for users to set manually...
  FLastByteRecv := 0;
  MaxLineLength := MaxInt;
end;

function TIdIOHandlerStreamMsg.Readable(AMSec: integer = IdTimeoutDefault): Boolean;
begin
  if not FTerminatorWasRead then begin
    Result := inherited Readable(AMSec);
    if Result then begin
      Exit;
    end;
  end;
  Result := ReceiveStream <> nil;
end;

function TIdIOHandlerStreamMsg.ReadDataFromSource(var VBuffer: TIdBytes): Integer;
var
  LTerminator: String;
begin
  if not FTerminatorWasRead then
  begin
    Result := inherited ReadDataFromSource(VBuffer);
    if Result > 0 then begin
      FLastByteRecv := VBuffer[Result-1];
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
    // in theory, CopyTIdString() will write the string
    // into the byte array using 1-byte characters even
    // under DotNet where strings are usually Unicode
    // instead of ASCII...
    CopyTIdString(LTerminator, VBuffer, 0);
    Result := Length(LTerminator);
  end else begin
    Result := 0;
  end;
end;

function TIdIOHandlerStreamMsg.ReadLn(ATerminator: string;
  ATimeout: Integer = IdTimeoutDefault; AMaxLineLength: Integer = -1;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
begin
  Result := inherited ReadLn(ATerminator, ATimeout, AMaxLineLength,
    AByteEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  if FEscapeLines and TextStartsWith(Result, '.') and (not FTerminatorWasRead) then begin {Do not Localize}
    Result := '.' + Result; {Do not Localize}
  end;
end;

procedure TIdIOHandlerStreamMsg.WriteLn(const AOut: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LOut: String;
begin
  LOut := AOut;
  if FUnescapeLines and TextStartsWith(LOut, '..') then begin {Do not Localize}
    IdDelete(LOut, 1, 1);
  end;
  inherited WriteLn(LOut, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
end;

///////////////////
// TIdMessageClient
///////////////////

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdMessageClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdMessageClient.InitComponent;
begin
  inherited InitComponent;
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
    if Trim(s) <> '' then
    begin
      IOHandler.WriteLn(ins + s);
    end;
  end

  else begin
    IOHandler.WriteLn(s);
  end;
end;

procedure TIdMessageClient.ReceiveBody(AMsg: TIdMessage; const ADelim: string = '.');   {do not localize}
var
  LMsgEnd: Boolean;
  LActiveDecoder: TIdMessageDecoder;
  LLine: string;
  LParentPart: integer;
  LPreviousParentPart: integer;
  LEncoding, LCharsetEncoding: IIdTextEncoding;
  LContentTransferEncoding: string;
  LUnknownContentTransferEncoding: Boolean;

  // TODO - move this procedure into TIdIOHandler as a new Capture method?
  procedure CaptureAndDecodeCharset;
  var
    LMStream: TMemoryStream;
  begin
    LMStream := TMemoryStream.Create;
    try
      IOHandler.Capture(LMStream, ADelim, True, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF});
      LMStream.Position := 0;

      // TODO: when String is AnsiString, TIdIMAP4 uses 8bit as the destination
      // encoding, should this be doing the same? Otherwise, we could just use
      // AMsg.Body.LoadFromStream() instead...

      // TODO: if the Content-Type is HTML, parse the HTML data looking for a charset
      // declaration, and if found then use that instead of the MIME charset...

      ReadStringsAsCharSet(LMStream, AMsg.Body, AMsg.CharSet{$IFDEF STRING_IS_ANSI}, CharsetToEncoding(AMsg.CharSet){$ENDIF});
    finally
      FreeAndNil(LMStream);
    end;
  end;

  // RLebeau 11/2/2013: TIdMessage.Headers is a TIdHeaderList, but
  // TIdMessageDecoder.Headers is a plain TStringList.  Although TIdHeaderList
  // is a TStrings descendant, it reintroduces its own Values[] property
  // instead of implementing the TStrings.Values[] property, so we cannot
  // access TIdMessage.Headers using a TStrings pointer or else the wrong
  // property will be invoked and we won't get the right value when accessing
  // TIdMessage.Headers since TStrings and TIdHeaderList use different
  // NameValueSeparator implementations, so we have to access them separately...
  function GetHeaderValue(const AName: string): string;
  begin
    if AMsg.IsMsgSinglePartMime then begin
      Result := AMsg.Headers.Values[AName];
    end else begin
      Result := LActiveDecoder.Headers.Values[AName];
    end;
  end;

  {Only set AUseBodyAsTarget to True if you want the input stream stored in TIdMessage.Body
  instead of TIdText.Body: this happens with some single-part messages.}
  procedure ProcessTextPart(var VDecoder: TIdMessageDecoder; AUseBodyAsTarget: Boolean);
  var
    LMStream: TMemoryStream;
    i: integer;
    LTxt : TIdText;
    LNewDecoder: TIdMessageDecoder;
    {$IFDEF STRING_IS_ANSI}
    LAnsiEncoding: IIdTextEncoding;
    {$ENDIF}
  begin
    LMStream := TMemoryStream.Create;
    try
      LParentPart := AMsg.MIMEBoundary.ParentPart;
      LNewDecoder := VDecoder.ReadBody(LMStream, LMsgEnd);
      try
        LMStream.Position := 0;
        if AUseBodyAsTarget then begin
          // TODO: if the Content-Type is HTML, parse the HTML data looking for a charset
          // declaration, and if found then use that instead of the MIME charset...
          if AMsg.IsMsgSinglePartMime then begin
            {$IFDEF STRING_IS_ANSI}
            LAnsiEncoding := CharsetToEncoding(AMsg.CharSet);
            {$ENDIF}
            ReadStringsAsCharSet(LMStream, AMsg.Body, AMsg.CharSet{$IFDEF STRING_IS_ANSI}, LAnsiEncoding{$ENDIF});
          end else begin
            {$IFDEF STRING_IS_ANSI}
            LAnsiEncoding := ContentTypeToEncoding(VDecoder.Headers.Values[SContentType], QuoteMIME);
            {$ENDIF}
            ReadStringsAsContentType(LMStream, AMsg.Body, VDecoder.Headers.Values[SContentType], QuoteMIME{$IFDEF STRING_IS_ANSI}, LAnsiEncoding{$ENDIF});
          end;
        end else begin
          LTxt := TIdText.Create(AMsg.MessageParts);
          try
            {$IFDEF STRING_IS_ANSI}
            LAnsiEncoding := ContentTypeToEncoding(GetHeaderValue(SContentType), QuoteMIME);
            {$ENDIF}
            ReadStringsAsContentType(LMStream, LTxt.Body, GetHeaderValue(SContentType), QuoteMIME{$IFDEF STRING_IS_ANSI}, LAnsiEncoding{$ENDIF});
            RemoveLastBlankLine(LTxt.Body);
            LTxt.ContentType := LTxt.ResolveContentType(GetHeaderValue(SContentType));
            LTxt.CharSet := LTxt.GetCharSet(GetHeaderValue(SContentType));       {do not localize}
            LTxt.ContentTransfer := GetHeaderValue(SContentTransferEncoding);    {do not localize}
            LTxt.ContentID := GetHeaderValue('Content-ID');  {do not localize}
            LTxt.ContentLocation := GetHeaderValue('Content-Location');  {do not localize}
            LTxt.ContentDescription := GetHeaderValue('Content-Description');  {do not localize}
            LTxt.ContentDisposition := GetHeaderValue('Content-Disposition');  {do not localize}
            if not AMsg.IsMsgSinglePartMime then begin
              for i := 0 to VDecoder.Headers.Count-1 do begin
                if LTxt.Headers.IndexOfName(VDecoder.Headers.Names[i]) < 0 then begin
                  LTxt.ExtraHeaders.AddValue(
                    VDecoder.Headers.Names[i],
                    IndyValueFromIndex(VDecoder.Headers, i)
                  );
                end;
              end;
            end;
            LTxt.Filename := VDecoder.Filename;
            if IsHeaderMediaType(LTxt.ContentType, 'multipart') then begin {do not localize}
              LTxt.ParentPart := LPreviousParentPart;

              // RLebeau 08/17/09 - According to RFC 2045 Section 6.4:
              // "If an entity is of type "multipart" the Content-Transfer-Encoding is not
              // permitted to have any value other than "7bit", "8bit" or "binary"."
              //
              // However, came across one message where the "Content-Type" was set to
              // "multipart/related" and the "Content-Transfer-Encoding" was set to
              // "quoted-printable".  Outlook and Thunderbird were apparently able to parse
              // the message correctly, but Indy was not.  So let's check for that scenario
              // and ignore illegal "Content-Transfer-Encoding" values if present...

              if LTxt.ContentTransfer <> '' then begin
                if not IsHeaderValue(LTxt.ContentTransfer, ['7bit', '8bit', 'binary']) then begin {do not localize}
                  LTxt.ContentTransfer := '';
                end;
              end;
            end else begin
              LTxt.ParentPart := LParentPart;
            end;
          except
            LTxt.Free;
            raise;
          end;
        end;
      except
        LNewDecoder.Free;
        raise;
      end;
      VDecoder.Free;
      VDecoder := LNewDecoder;
    finally
      FreeAndNil(LMStream);
    end;
  end;

  procedure ProcessAttachment(var VDecoder: TIdMessageDecoder);
  var
    LDestStream: TStream;
    i: integer;
    LAttachment: TIdAttachment;
    LNewDecoder: TIdMessageDecoder;
  begin
    LParentPart := AMsg.MIMEBoundary.ParentPart;
    AMsg.DoCreateAttachment(VDecoder.Headers, LAttachment);
    Assert(Assigned(LAttachment), 'Attachment must not be unassigned here!'); {Do not localize}
    try
      LNewDecoder := nil;
      try
        LDestStream := LAttachment.PrepareTempStream;
        try
          LNewDecoder := VDecoder.ReadBody(LDestStream, LMsgEnd);
        finally
          LAttachment.FinishTempStream;
        end;
        LAttachment.ContentType := LAttachment.ResolveContentType(GetHeaderValue(SContentType));
        LAttachment.CharSet := LAttachment.GetCharSet(GetHeaderValue(SContentType));
        if VDecoder is TIdMessageDecoderUUE then begin
          LAttachment.ContentTransfer := TIdMessageDecoderUUE(VDecoder).CodingType;  {do not localize}
        end else begin
          //Watch out for BinHex 4.0 encoding: no ContentTransfer is specified
          //in the header, but we need to set it to something meaningful for us...
          if IsHeaderMediaType(LAttachment.ContentType, 'application/mac-binhex40') then begin {do not localize}
            LAttachment.ContentTransfer := 'binhex40'; {do not localize}
          end else begin
            LAttachment.ContentTransfer := GetHeaderValue(SContentTransferEncoding);
          end;
        end;
        LAttachment.ContentDisposition := GetHeaderValue('Content-Disposition'); {do not localize}
        LAttachment.ContentID := GetHeaderValue('Content-ID');                   {do not localize}
        LAttachment.ContentLocation := GetHeaderValue('Content-Location');       {do not localize}
        LAttachment.ContentDescription := GetHeaderValue('Content-Description'); {do not localize}
        if not AMsg.IsMsgSinglePartMime then begin
          for i := 0 to VDecoder.Headers.Count-1 do begin
            if LAttachment.Headers.IndexOfName(VDecoder.Headers.Names[i]) < 0 then begin
              LAttachment.ExtraHeaders.AddValue(
                VDecoder.Headers.Names[i],
                IndyValueFromIndex(VDecoder.Headers, i)
              );
            end;
          end;
        end;
        LAttachment.Filename := VDecoder.Filename;
        if IsHeaderMediaType(LAttachment.ContentType, 'multipart') then begin  {do not localize}
          LAttachment.ParentPart := LPreviousParentPart;

          // RLebeau 08/17/09 - According to RFC 2045 Section 6.4:
          // "If an entity is of type "multipart" the Content-Transfer-Encoding is not
          // permitted to have any value other than "7bit", "8bit" or "binary"."
          //
          // However, came across one message where the "Content-Type" was set to
          // "multipart/related" and the "Content-Transfer-Encoding" was set to
          // "quoted-printable".  Outlook and Thunderbird were apparently able to parse
          // the message correctly, but Indy was not.  So let's check for that scenario
          // and ignore illegal "Content-Transfer-Encoding" values if present...

          if LAttachment.ContentTransfer <> '' then begin
            if not IsHeaderValue(LAttachment.ContentTransfer, ['7bit', '8bit', 'binary']) then begin {do not localize}
              LAttachment.ContentTransfer := '';
            end;
          end;
        end else begin
          LAttachment.ParentPart := LParentPart;
        end;
      except
        LNewDecoder.Free;
        raise;
      end;
      VDecoder.Free;
      VDecoder := LNewDecoder;
    except
      //This should also remove the Item from the TCollection.
      //Note that Delete does not exist in the TCollection.
      LAttachment.Free;
      raise;
    end;
  end;

begin
  LMsgEnd := False;

  // RLebeau 08/09/09 - TIdNNTP.GetBody() calls TIdMessage.Clear() before then
  // calling ReceiveBody(), thus the TIdMessage.ContentTransferEncoding value
  // is not available for use below.  What is the best way to detect that so
  // the user could be allowed to set up the IOHandler.DefStringEncoding
  // beforehand?

  LUnknownContentTransferEncoding := False;

  if AMsg.NoDecode then begin
    LEncoding := IndyTextEncoding_8Bit;
  end else
  begin
    LContentTransferEncoding := ExtractHeaderItem(AMsg.ContentTransferEncoding);
    if LContentTransferEncoding = '' then begin
      // RLebeau 04/08/2014: According to RFC 2045 Section 6.1:
      // "Content-Transfer-Encoding: 7BIT" is assumed if the
      // Content-Transfer-Encoding header field is not present."
      if IsHeaderMediaType(AMsg.ContentType, 'application/mac-binhex40') then begin  {Do not Localize}
        LContentTransferEncoding := 'binhex40'; {do not localize}
      end
      else if (AMsg.Encoding = meMIME) and (AMsg.MIMEBoundary.Count > 0) and (not AMsg.NoDecode) then begin
        LContentTransferEncoding := '7bit'; {do not localize}
      end;
    end
    else if IsHeaderMediaType(AMsg.ContentType, 'multipart') then {do not localize}
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
        //LUnknownContentTransferEncoding := True;
      end;
    end;

    if LContentTransferEncoding <> '' then begin
      case PosInStrArray(LContentTransferEncoding, ['7bit', 'quoted-printable', 'base64', '8bit', 'binary'], False) of {do not localize}
        0..2: LEncoding := IndyTextEncoding_ASCII;
        3..4: LEncoding := IndyTextEncoding_8Bit;
      else
        // According to RFC 2045 Section 6.4:
        // "Any entity with an unrecognized Content-Transfer-Encoding must be
        // treated as if it has a Content-Type of "application/octet-stream",
        // regardless of what the Content-Type header field actually says."
        LEncoding := IndyTextEncoding_8Bit;
        LContentTransferEncoding := '';
        LUnknownContentTransferEncoding := True;
      end;
    end else begin
      LEncoding := IndyTextEncoding_8Bit;
    end;
  end;

  BeginWork(wmRead);
  try
    if AMsg.NoDecode then begin
      CaptureAndDecodeCharset;
    end else begin
      LActiveDecoder := nil;
      try
        if ((not LUnknownContentTransferEncoding) and
         ((AMsg.Encoding = meMIME) and (AMsg.MIMEBoundary.Count > 0)) or
         ((AMsg.Encoding = mePlainText) and (not IsHeaderValue(AMsg.ContentTransferEncoding, ['base64', 'quoted-printable'])))  {do not localize}
         ) then begin
          {NOTE: You hit this code path with multipart MIME messages and with
          plain-text messages (which may have UUE or XXE attachments embedded).}
          LCharsetEncoding := CharsetToEncoding(AMsg.CharSet);
          repeat
            {CC: This code assumes the preamble text (before the first boundary)
            is plain text.  I cannot imagine it not being, but if it arises, lines
            will have to be decoded.}

            // TODO: need to figure out a way to handle both transfer encoding
            // and charset encoding together!  Need to read the raw bytes into
            // an intermediate buffer of some kind using the transfer encoding,
            // and then decode the characters using the charset afterwards...
            //
            // Need to do this anyway because ReadLnRFC() processes the LF and
            // ADelim values in terms of the charset specified, which is wrong.
            // EBCDIC-based charsets totally break that logic! For example, cp1026
            // converts #10 (LF) to $25 instead of $0A during encoding, and converts
            // $0A (LF) and $2E ('.') to #$83 and #6 during decoding, etc. And what
            // if the charset is UTF-16 instead?  So we need to read raw bytes into
            // a buffer, checking it for handling of line breaks, dot-transparency,
            // and message termination, and THEN decode whatever is left using the
            // charset...

            LLine := IOHandler.ReadLnRFC(LMsgEnd, LF, ADelim, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF});
            if LMsgEnd then begin
              Break;
            end;
            if LActiveDecoder = nil then begin
              LActiveDecoder := TIdMessageDecoderList.CheckForStart(AMsg, LLine);
            end;
            // Check again, the if above can set it.
            if LActiveDecoder = nil then begin
              LLine := LCharsetEncoding.GetString(ToBytes(LLine, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF}));
              AMsg.Body.Add(LLine);
            end else begin
              RemoveLastBlankLine(AMsg.Body);
              while LActiveDecoder <> nil do begin
                LActiveDecoder.SourceStream := TIdTCPStream.Create(Self);
                LPreviousParentPart := AMsg.MIMEBoundary.ParentPart;
                LActiveDecoder.ReadHeader;
                case LActiveDecoder.PartType of
                  mcptText:       ProcessTextPart(LActiveDecoder, False);
                  mcptAttachment: ProcessAttachment(LActiveDecoder);
                  mcptIgnore:     FreeAndNil(LActiveDecoder);
                  mcptEOF:        begin FreeAndNil(LActiveDecoder); LMsgEnd := True; end;
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
          // RLebeau: override what TIdMessageDecoderMime.InitComponent() assigns
          TIdMessageDecoderMime(LActiveDecoder).BodyEncoded := True;
          TIdMessageDecoderMime(LActiveDecoder).ReadHeader;
          case LActiveDecoder.PartType of
            mcptText: begin
              if LUnknownContentTransferEncoding then begin
                ProcessAttachment(LActiveDecoder);
              end else begin
                ProcessTextPart(LActiveDecoder, True); //Put the text into TIdMessage.Body
              end;
            end;
            mcptAttachment: ProcessAttachment(LActiveDecoder);
            mcptIgnore:     FreeAndNil(LActiveDecoder);
            mcptEOF:        FreeAndNil(LActiveDecoder);
          end;
        end;
      finally
        FreeAndNil(LActiveDecoder);
      end;
    end;
  finally
    EndWork(wmRead);
  end;
end;

procedure TIdMessageClient.SendHeader(AMsg: TIdMessage);
begin
  AMsg.GenerateHeader;
  IOHandler.Write(AMsg.LastGeneratedHeaders);
end;

procedure TIdMessageClient.SendBody(AMsg: TIdMessage);
var
  i: Integer;
  LAttachment: TIdAttachment;
  LBoundary: string;
  LDestStream: TStream;
  LStrStream: TStream;
  ISOCharset: string;
  HeaderEncoding: Char;  { B | Q }
  LEncoder: TIdMessageEncoder;
  LLine: string;

  procedure EncodeStrings(AStrings: TStrings; AEncoderClass: TIdMessageEncoderClass; AByteEncoding: IIdTextEncoding
    {$IFDEF STRING_IS_ANSI}; AAnsiEncoding: IIdTextEncoding{$ENDIF});
  var
    LStrings: TStringList;
  begin
    {$IFDEF STRING_IS_ANSI}
    EnsureEncoding(AAnsiEncoding, encOSDefault);
    {$ENDIF}
    LStrings := TStringList.Create; try
      LEncoder := AEncoderClass.Create(Self); try
        LStrStream := TMemoryStream.Create; try
          // RLebeau 10/06/2010: not using TStrings.SaveToStream() in D2009+
          // anymore, as it may save a BOM which we do not want here...
          WriteStringToStream(LStrStream, AStrings.Text, AByteEncoding{$IFDEF STRING_IS_ANSI}, AAnsiEncoding{$ENDIF});
          LStrStream.Position := 0;
          LEncoder.Encode(LStrStream, LStrings);
        finally FreeAndNil(LStrStream); end;
      finally FreeAndNil(LEncoder); end;
      IOHandler.WriteRFCStrings(LStrings, False);
    finally FreeAndNil(LStrings); end;
  end;

  procedure EncodeAttachment(AAttachment: TIdAttachment; AEncoderClass: TIdMessageEncoderClass);
  var
    LAttachStream: TStream;
  begin
    LDestStream := TIdTCPStream.Create(Self, 8192); try
      LEncoder := AEncoderClass.Create(Self); try
        LEncoder.Filename := AAttachment.Filename;
        LAttachStream := AAttachment.OpenLoadStream; try
          LEncoder.Encode(LAttachStream, LDestStream);
        finally AAttachment.CloseLoadStream; end;
      finally FreeAndNil(LEncoder); end;
    finally FreeAndNil(LDestStream); end;
  end;

  procedure WriteTextPart(ATextPart: TIdText);
  var
    LEncoding: IIdTextEncoding;
    LFileName: String;
  begin
    if ATextPart.ContentType = '' then begin
      ATextPart.ContentType := 'text/plain'; {do not localize}
    end;

    // RLebeau 08/17/09 - According to RFC 2045 Section 6.4:
    // "If an entity is of type "multipart" the Content-Transfer-Encoding is not
    // permitted to have any value other than "7bit", "8bit" or "binary"."
    //
    // However, came across one message where the "Content-Type" was set to
    // "multipart/related" and the "Content-Transfer-Encoding" was set to
    // "quoted-printable".  Outlook and Thunderbird were apparently able to parse
    // the message correctly, but Indy was not.  So let's check for that scenario
    // and ignore illegal "Content-Transfer-Encoding" values if present...

    if IsHeaderMediaType(ATextPart.ContentType, 'multipart') then begin {do not localize}
      if ATextPart.ContentTransfer <> '' then begin
        if not IsHeaderValue(ATextPart.ContentTransfer, ['7bit', '8bit', 'binary']) then begin {do not localize}
          ATextPart.ContentTransfer := '';
        end;
      end;
    end
    else if ATextPart.ContentTransfer = '' then begin
      ATextPart.ContentTransfer := 'quoted-printable'; {do not localize}
    end
    else if (not IsHeaderValue(ATextPart.ContentTransfer, ['quoted-printable', 'base64'])) {do not localize}
      and ATextPart.IsBodyEncodingRequired then
    begin
      ATextPart.ContentTransfer := '8bit';                    {do not localize}
    end;

    if ATextPart.ContentDisposition = '' then begin
      ATextPart.ContentDisposition := 'inline'; {do not localize}
    end;

    // TODO: when STRING_IS_ANSI is defined, provide a way for the user to specify the AnsiString encoding for header values...
    LFileName := EncodeHeader(ExtractFileName(ATextPart.FileName), '', HeaderEncoding, ISOCharSet); {do not localize}

    if ATextPart.ContentType <> '' then begin
      IOHandler.Write('Content-Type: ' + ATextPart.ContentType); {do not localize}
      if ATextPart.CharSet <> '' then begin
        IOHandler.Write('; charset="' + ATextPart.CharSet + '"'); {do not localize}
      end;
      if LFileName <> '' then begin
        IOHandler.WriteLn(';');  {do not localize}
        IOHandler.Write(TAB + 'name="' + LFileName + '"'); {do not localize}
      end;
      IOHandler.WriteLn;
    end;

    if ATextPart.ContentTransfer <> '' then begin
      IOHandler.WriteLn(SContentTransferEncoding + ': ' + ATextPart.ContentTransfer); {do not localize}
    end;

    IOHandler.Write('Content-Disposition: ' + ATextPart.ContentDisposition); {do not localize}
    if LFileName <> '' then begin
      IOHandler.WriteLn(';'); {do not localize}
      IOHandler.Write(TAB + 'filename="' + LFileName + '"'); {do not localize}
    end;
    IOHandler.WriteLn;

    if ATextPart.ContentID <> '' then begin
      IOHandler.WriteLn('Content-ID: ' + ATextPart.ContentID);  {do not localize}
    end;

    if ATextPart.ContentDescription <> '' then begin
      IOHandler.WriteLn('Content-Description: ' + ATextPart.ContentDescription); {do not localize}
    end;

    IOHandler.Write(ATextPart.ExtraHeaders);
    IOHandler.WriteLn;

    LEncoding := CharsetToEncoding(ATextPart.CharSet);
    case PosInStrArray(ExtractHeaderItem(ATextPart.ContentTransfer), ['quoted-printable', 'base64'], False) of  {do not localize}
      0: EncodeStrings(ATextPart.Body, TIdMessageEncoderQuotedPrintable, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      1: EncodeStrings(ATextPart.Body, TIdMessageEncoderMIME, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
    else
      IOHandler.WriteRFCStrings(ATextPart.Body, False, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      { No test for last line break necessary because IOHandler.WriteRFCStrings() uses WriteLn(). }
    end;
  end;

var
  LFileName, LContentTransferEncoding: String;
  LTextPart: TIdText;
  LAddedTextPart: Boolean;
  LLastPart: Integer;
  LEncoding: IIdTextEncoding;
  LAttachStream: TStream;
begin
  LBoundary := '';
  AMsg.InitializeISO(HeaderEncoding, ISOCharSet);
  BeginWork(wmWrite);
  try
    LContentTransferEncoding := ExtractHeaderItem(AMsg.ContentTransferEncoding);
    if (not AMsg.IsMsgSinglePartMime) and
      (PosInStrArray(LContentTransferEncoding, ['base64', 'quoted-printable'], False) <> -1) then {do not localize}
    begin
      //CC2: The user wants the body encoded.
      if AMsg.MessageParts.Count > 0 then begin
        //CC2: We cannot deal with parts within a body encoding (user has to do
        //this manually, if the user really wants to). Note this should have been trapped in TIdMessage.GenerateHeader.
        raise EIdException.Create(RSMsgClientInvalidForTransferEncoding);
      end;
      IOHandler.WriteLn;     //This is the blank line after the headers
      DoStatus(hsStatusText, [RSMsgClientEncodingText]);
      LEncoding := CharsetToEncoding(AMsg.CharSet);
      //CC2: Now output AMsg.Body in the chosen encoding...
      if TextIsSame(LContentTransferEncoding, 'base64') then begin  {do not localize}
        EncodeStrings(AMsg.Body, TIdMessageEncoderMIME, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      end else begin  {'quoted-printable'}
        EncodeStrings(AMsg.Body, TIdMessageEncoderQuotedPrintable, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      end;
    end
    else if AMsg.Encoding = mePlainText then begin
      IOHandler.WriteLn;     //This is the blank line after the headers
      //CC2: It is NOT Mime.  It is a body followed by optional attachments
      DoStatus(hsStatusText, [RSMsgClientEncodingText]);
      // Write out Body first
      LEncoding := CharsetToEncoding(AMsg.CharSet);
      EncodeAndWriteText(AMsg.Body, LEncoding);
      IOHandler.WriteLn;
      if AMsg.MessageParts.Count > 0 then begin
        //The message has attachments.
        for i := 0 to AMsg.MessageParts.Count - 1 do begin
          //CC: Added support for TIdText...
          if AMsg.MessageParts.Items[i] is TIdText then begin
            IOHandler.WriteLn;
            IOHandler.WriteLn('------- Start of text attachment -------'); {do not localize}
            DoStatus(hsStatusText,  [RSMsgClientEncodingText]);
            WriteTextPart(TIdText(AMsg.MessageParts.Items[i]));
            IOHandler.WriteLn('------- End of text attachment -------');   {do not localize}
          end
          else if AMsg.MessageParts.Items[i] is TIdAttachment then begin
            LAttachment := TIdAttachment(AMsg.MessageParts[i]);
            DoStatus(hsStatusText, [RSMsgClientEncodingAttachment]);
            if LAttachment.ContentTransfer = '' then begin
              //The user has nothing specified: see has he set a preference in
              //TIdMessage.AttachmentEncoding (AttachmentEncoding is really an
              //old and somewhat deprecated property, but we can still support it)...
              if PosInStrArray(AMsg.AttachmentEncoding, ['UUE', 'XXE']) <> -1 then begin  {do not localize}
                LAttachment.ContentTransfer := AMsg.AttachmentEncoding;
              end else begin
                //We default to UUE (rather than XXE)...
                LAttachment.ContentTransfer := 'UUE';  {do not localize}
              end;
            end;
            case PosInStrArray(ExtractHeaderItem(LAttachment.ContentTransfer), ['UUE', 'XXE'], False) of  {do not localize}
              0: EncodeAttachment(LAttachment, TIdMessageEncoderUUE);
              1: EncodeAttachment(LAttachment, TIdMessageEncoderXXE);
            end;
          end;
          IOHandler.WriteLn;
        end;
      end;
    end
    else begin
      //CC2: It is MIME-encoding...
      LAddedTextPart := False;
      //######### OUTPUT THE PREAMBLE TEXT ########
      {For single-part MIME messages, we want the message part headers to be appended
      to the message headers.  Otherwise, add the blank separator between header and
      body...}
      if not AMsg.IsMsgSinglePartMime then begin
        IOHandler.WriteLn;     //This is the blank line after the headers
        //if AMsg.Body.Count > 0 then begin
        if not AMsg.IsBodyEmpty then begin
          //CC2: The message has a body text.  There are now a few possibilities.
          //First up, if ConvertPreamble is False then the user explicitly does not want us
          //to convert the .Body since he had to change it from the default False.
          //Secondly, if AMsg.MessageParts.TextPartCount > 0, he may have put the
          //message text in the part, so don't convert the body.
          //Thirdly, if AMsg.MessageParts.Count = 0, then it has no other parts
          //anyway: in this case, output it without boundaries.
          //if (AMsg.ConvertPreamble and (AMsg.MessageParts.TextPartCount = 0)) then begin
          if AMsg.ConvertPreamble and (AMsg.MessageParts.TextPartCount = 0) and (AMsg.MessageParts.Count > 0) then begin
            //CC2: There is no text part, the user has not changed ConvertPreamble from
            //its default of True, so the user has probably put his message into
            //the body by mistake instead of putting it in a TIdText part.
            //Create a TIdText part from the .Body text...
            LTextPart := TIdText.Create(AMsg.MessageParts, AMsg.Body);
            LTextPart.CharSet := AMsg.CharSet;
            LTextPart.ContentType := 'text/plain';  {do not localize}
            LTextPart.ContentTransfer := 'quoted-printable';    {do not localize}
            //Have to remember that we added a text part, which is the last part
            //in the collection, because we need it to be outputted first...
            LAddedTextPart := True;
            //CC2: Insert our standard preamble text...
            IOHandler.WriteLn(SThisIsMultiPartMessageInMIMEFormat);
          end else begin
            //CC2: Hopefully the user has put suitable text in the preamble, or this
            //is an already-received message which already has a preamble text...
            LEncoding := CharsetToEncoding(AMsg.CharSet);
            EncodeAndWriteText(AMsg.Body, LEncoding);
          end;
        end
        else begin
          //CC2: The user has specified no body text: he presumably has the message in
          //a TIdText part, but it may have no text at all (a message consisting only
          //of headers, which is allowed under the RFC, which will have a parts count
          //of 0).
          if AMsg.MessageParts.Count <> 0 then begin
            //Add the "standard" MIME preamble text for non-html email clients...
            IOHandler.WriteLn(SThisIsMultiPartMessageInMIMEFormat);
          end;
        end;
        IOHandler.WriteLn;
        //######### SET UP THE BOUNDARY STACK ########
        LBoundary := AMsg.MIMEBoundary.Boundary;
        if LBoundary = '' then begin
          LBoundary := TIdMIMEBoundaryStrings.GenerateBoundary;
          AMsg.MIMEBoundary.Push(LBoundary, -1);  //-1 is "top level"
        end;
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
        DoStatus(hsStatusText, [RSMsgClientEncodingText]);
        WriteTextPart(AMsg.MessageParts.Items[LLastPart] as TIdText);
        IOHandler.WriteLn;
        Dec(LLastPart);  //Don't output it again in the following "for" loop
      end;
      for i := 0 to LLastPart do begin
        LLine := AMsg.MessageParts.Items[i].ContentType;
        if IsHeaderMediaType(LLine, 'multipart') then begin  {do not localize}
          //A multipart header.  Write out the CURRENT boundary first...
          IOHandler.WriteLn('--' + LBoundary);      {do not localize}
          //Make the current boundary and this part number active...
          //Now need to generate a new boundary...
          LBoundary := TIdMIMEBoundaryStrings.GenerateBoundary;
          AMsg.MIMEBoundary.Push(LBoundary, i);
          //Make sure the header does not already have a pre-existing
          //boundary since we just generated a new one...
          IOHandler.WriteLn('Content-Type: ' + RemoveHeaderEntry(LLine, 'boundary', QuoteMIME) + ';');            {do not localize}
          IOHandler.WriteLn(TAB + 'boundary="' + LBoundary + '"');  {do not localize}
          IOHandler.WriteLn;
        end
        else begin
          //Not a multipart header, see if it is a part change...
          if not AMsg.IsMsgSinglePartMime then begin
            while AMsg.MessageParts.Items[i].ParentPart <> AMsg.MIMEBoundary.ParentPart do begin
              IOHandler.WriteLn('--' + LBoundary + '--');  {do not localize}
              IOHandler.WriteLn;
              AMsg.MIMEBoundary.Pop;  //This also pops AMsg.MIMEBoundary.ParentPart
              LBoundary := AMsg.MIMEBoundary.Boundary;
            end;
            IOHandler.WriteLn('--' + LBoundary);  {do not localize}
          end;
          if AMsg.MessageParts.Items[i] is TIdText then begin
            DoStatus(hsStatusText,  [RSMsgClientEncodingText]);
            WriteTextPart(AMsg.MessageParts.Items[i] as TIdText);
            IOHandler.WriteLn;
          end
          else if AMsg.MessageParts.Items[i] is TIdAttachment then begin
            LAttachment := TIdAttachment(AMsg.MessageParts[i]);
            DoStatus(hsStatusText, [RSMsgClientEncodingAttachment]);
            if LAttachment.ContentTransfer = '' then begin
              LContentTransferEncoding := 'base64'; {do not localize}
              LAttachment.ContentTransfer := LContentTransferEncoding;
            end else begin;
              LContentTransferEncoding := ExtractHeaderItem(LAttachment.ContentTransfer);
            end;
            if LAttachment.ContentDisposition = '' then begin
              LAttachment.ContentDisposition := 'attachment'; {do not localize}
            end;
            if LAttachment.ContentType = '' then begin
              if TextIsSame(LContentTransferEncoding, 'base64') then begin {do not localize}
                LAttachment.ContentType := 'application/octet-stream'; {do not localize}
              end else begin
                {CC4: Set default type if not base64 encoded...}
                LAttachment.ContentType := 'text/plain'; {do not localize}
              end;
            end;

            // TODO: when STRING_IS_ANSI is defined, provide a way for the user to specify the AnsiString encoding for header values...
            LFileName := EncodeHeader(ExtractFileName(LAttachment.FileName), '', HeaderEncoding, ISOCharSet); {do not localize}

            if TextIsSame(LContentTransferEncoding, 'binhex40') then begin   {do not localize}
              //This is special - you do NOT write out any Content-Transfer-Encoding
              //header!  We also have to write a Content-Type specified in RFC 1741
              //(overriding any ContentType present, if necessary).
              LAttachment.ContentType := 'application/mac-binhex40';            {do not localize}
              IOHandler.Write('Content-Type: ' + LAttachment.ContentType); {do not localize}
              if LAttachment.CharSet <> '' then begin
                IOHandler.Write('; charset="' + LAttachment.CharSet + '"'); {do not localize}
              end;
              if LFileName <> '' then begin
                IOHandler.WriteLn(';'); {do not localize}
                IOHandler.Write(TAB + 'name="' + LFileName + '"'); {do not localize}
              end;
              IOHandler.WriteLn;
            end
            else begin
              IOHandler.Write('Content-Type: ' + LAttachment.ContentType); {do not localize}
              if LAttachment.CharSet <> '' then begin
                IOHandler.Write('; charset="' + LAttachment.CharSet + '"'); {do not localize}
              end;
              if LFileName <> '' then begin
                IOHandler.WriteLn(';');
                IOHandler.Write(TAB + 'name="' + LFileName + '"'); {do not localize}
              end;
              IOHandler.WriteLn;
              IOHandler.WriteLn('Content-Transfer-Encoding: ' + LAttachment.ContentTransfer); {do not localize}
              IOHandler.Write('Content-Disposition: ' + LAttachment.ContentDisposition); {do not localize}
              if LFileName <> '' then begin
                IOHandler.WriteLn(';');
                IOHandler.Write(TAB + 'filename="' + LFileName + '"'); {do not localize}
              end;
              IOHandler.WriteLn;
            end;
            if LAttachment.ContentID <> '' then begin
              IOHandler.WriteLn('Content-ID: '+ LAttachment.ContentID); {Do not Localize}
            end;
            if LAttachment.ContentDescription <> '' then begin
              IOHandler.WriteLn('Content-Description: ' + LAttachment.ContentDescription); {Do not localize}
            end;

            IOHandler.Write(LAttachment.ExtraHeaders);
            IOHandler.WriteLn;

            case PosInStrArray(LContentTransferEncoding, ['base64', 'quoted-printable', 'binhex40'], False) of {do not localize}
              0: EncodeAttachment(LAttachment, TIdMessageEncoderMIME);
              1: EncodeAttachment(LAttachment, TIdMessageEncoderQuotedPrintable);
              2: EncodeAttachment(LAttachment, TIdMessageEncoderBinHex4);
              else
              begin
                LEncoding := CharsetToEncoding(LAttachment.Charset);
                LAttachStream := LAttachment.OpenLoadStream;
                try
                  while ReadLnFromStream(LAttachStream, LLine, -1, LEncoding) do begin
                    IOHandler.WriteLnRFC(LLine, LEncoding);
                  end;
                finally
                  LAttachment.CloseLoadStream;
                end;
              end;
            end;
            IOHandler.WriteLn;
          end;
        end;
      end;
      if AMsg.MessageParts.Count > 0 then begin
        for i := 0 to AMsg.MIMEBoundary.Count - 1 do begin
          if not AMsg.IsMsgSinglePartMime then begin
            IOHandler.WriteLn('--' + AMsg.MIMEBoundary.Boundary + '--');
            IOHandler.WriteLn;
          end;
          AMsg.MIMEBoundary.Pop;
        end;
      end;
    end;
  finally
    EndWork(wmWrite);
  end;
end;

procedure TIdMessageClient.SendMsg(AMsg: TIdMessage; AHeadersOnly: Boolean = False);
begin
  BeginWork(wmWrite);
  try
    if AMsg.NoEncode then begin
      IOHandler.Write(AMsg.Headers);
      IOHandler.WriteLn;
      if not AHeadersOnly then begin
        IOHandler.WriteRFCStrings(AMsg.Body, False);
      end;
    end else begin
      SendHeader(AMsg);
      if (not AHeadersOnly) then begin
        SendBody(AMsg);
      end;
    end;
  finally
    EndWork(wmWrite);
  end;
end;

function TIdMessageClient.ReceiveHeader(AMsg: TIdMessage; const AAltTerm: string = ''): string;
var
  LMsgEnd: Boolean;
begin
  BeginWork(wmRead);
  try
    repeat
      Result := IOHandler.ReadLnRFC(LMsgEnd);
      // Exchange Bug: Exchange sometimes returns . when getting a message instead of
      // '' then a . - That is there is no seperation between the header and the message for an
      // empty message.
      if ((Length(AAltTerm) = 0) and LMsgEnd) or  {do not localize}
         ({APR: why? (Length(AAltTerm) > 0) and }(Result = AAltTerm)) then begin
        Break;
      end else if Result <> '' then begin
        AMsg.Headers.Append(Result);
      end;
    until False;
    AMsg.ProcessHeaders;
  finally
    EndWork(wmRead);
  end;
end;

procedure TIdMessageClient.ProcessMessage(AMsg: TIdMessage; AHeaderOnly: Boolean = False);
begin
  if IOHandler <> nil then begin
    //Don't call ReceiveBody if the message ended at the end of the headers
    //(ReceiveHeader() would have returned '.' in that case)...
    BeginWork(wmRead);
    try
      if ReceiveHeader(AMsg) = '' then begin
        if not AHeaderOnly then begin
          ReceiveBody(AMsg);
        end;
      end;
    finally
      EndWork(wmRead);
    end;
  end;
end;

procedure TIdMessageClient.ProcessMessage(AMsg: TIdMessage; AStream: TStream; AHeaderOnly: Boolean = False);
var
  LIOHandler: TIdIOHandlerStreamMsg;
begin
  LIOHandler := TIdIOHandlerStreamMsg.Create(nil, AStream);
  try
    LIOHandler.FreeStreams := False;
    LIOHandler.MaxLineLength := MaxInt;
    IOHandler := LIOHandler;
    try
      IOHandler.Open;
      ProcessMessage(AMsg, AHeaderOnly);
    finally
      IOHandler := nil;
    end;
  finally
    LIOHandler.Free;
  end;
end;

procedure TIdMessageClient.ProcessMessage(AMsg: TIdMessage; const AFilename: string; AHeaderOnly: Boolean = False);
var
  LStream: TStream;
begin
  LStream := TIdReadFileExclusiveStream.Create(AFileName); try
    ProcessMessage(AMsg, LStream, AHeaderOnly);
  finally FreeAndNil(LStream); end;
end;

procedure TIdMessageClient.EncodeAndWriteText(const ABody: TStrings; AEncoding: IIdTextEncoding);
begin
  Assert(ABody<>nil);
  Assert(IOHandler<>nil);
  // TODO: encode the text...
  IOHandler.WriteRFCStrings(ABody, False, AEncoding);
end;

destructor TIdMessageClient.Destroy;
begin
  inherited Destroy;
end;

end.
