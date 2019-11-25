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
  Rev 1.53    29/12/2004 11:01:56  CCostelloe
  IsMsgSinglePartMime now cleared in TIdMessage.Clear.

  Rev 1.52    28/11/2004 20:06:28  CCostelloe
  Enhancement to preserve case of MIME boundary

  Rev 1.51    10/26/2004 10:25:44 PM  JPMugaas
  Updated refs.

  Rev 1.50    2004.10.26 9:10:00 PM  czhower
  TIdStrings

  Rev 1.49    24.08.2004 18:01:44  Andreas Hausladen
  Added AttachmentBlocked property to TIdAttachmentFile.

  Rev 1.48    6/29/04 12:29:04 PM  RLebeau
  Updated TIdMIMEBoundary.FindBoundary() to check the string length after
  calling Sys.Trim() before referencing the string data

  Rev 1.47    6/9/04 5:38:48 PM  RLebeau
  Updated ClearHeader() to clear the MsgId and UID properties.

  Updated SetUseNowForDate() to support AValue being set to False

  Rev 1.46    16/05/2004 18:54:42  CCostelloe
  New TIdText/TIdAttachment processing

  Rev 1.45    03/05/2004 20:43:08  CCostelloe
  Fixed bug where QP or base64 encoded text part got header encoding
  incorrectly outputted as 8bit.

  Rev 1.44    4/25/04 1:29:34 PM  RLebeau
  Bug fix for SaveToStream

  Rev 1.42    23/04/2004 20:42:18  CCostelloe
  Bug fixes plus support for From containing multiple addresses

  Rev 1.41    2004.04.18 1:39:20 PM  czhower
  Bug fix for .NET with attachments, and several other issues found along the
  way.

  Rev 1.40    2004.04.16 11:30:56 PM  czhower
  Size fix to IdBuffer, optimizations, and memory leaks

  Rev 1.39    14/03/2004 17:47:54  CCostelloe
  Bug fix: quoted-printable attachment encoding was changed to base64.

  Rev 1.38    2004.02.03 5:44:00 PM  czhower
  Name changes

  Rev 1.37    2004.02.03 2:12:14 PM  czhower
  $I path change

  Rev 1.36    26/01/2004 01:51:14  CCostelloe
  Changed implementation of supressing BCC List generation

  Rev 1.35    25/01/2004 21:15:42  CCostelloe
  Added SuppressBCCListInHeader property for use by TIdSMTP

  Rev 1.34    1/21/2004 1:17:14 PM  JPMugaas
  InitComponent

  Rev 1.33    1/19/04 11:36:02 AM  RLebeau
  Updated GenerateHeader() to remove support for the BBCList property

  Rev 1.32    16/01/2004 17:30:18  CCostelloe
  Added support for BinHex4.0 encoding

  Rev 1.31    11/01/2004 19:53:20  CCostelloe
  Revisions for TIdMessage SaveToFile & LoadFromFile for D7 & D8

  Rev 1.29    08/01/2004 23:43:40  CCostelloe
  LoadFromFile/SaveToFile now work in D7 again

  Rev 1.28    1/7/04 11:07:16 PM  RLebeau
  Bug fix for various TIdMessage properties that were not previously using
  setter methods correctly.

  Rev 1.27    08/01/2004 00:30:26  CCostelloe
  Start of reimplementing LoadFrom/SaveToFile

  Rev 1.26    21/10/2003 23:04:32  CCostelloe
  Bug fix: removed AttachmentEncoding := '' in SetEncoding.

  Rev 1.25    21/10/2003 00:33:04  CCostelloe
  meMIME changed to meDefault in TIdMessage.Create

  Rev 1.24    10/17/2003 7:42:54 PM  BGooijen
  Changed default Encoding to MIME

    Rev 1.23    10/17/2003 12:14:08 AM  DSiders
  Added localization comments.

  Rev 1.22    2003.10.14 9:57:04 PM  czhower
  Compile todos

  Rev 1.21    10/12/2003 1:55:46 PM  BGooijen
  Removed IdStrings from uses

  Rev 1.20    2003.10.11 10:01:26 PM  czhower
  .inc path

  Rev 1.19    10/10/2003 10:42:26 PM  BGooijen
  DotNet

  Rev 1.18    9/10/2003 1:50:54 PM  SGrobety
  DotNet

  Rev 1.17    10/8/2003 9:53:12 PM  GGrieve
  use IdCharsets

  Rev 1.16    05/10/2003 16:38:50  CCostelloe
  Restructured MIME boundary output

  Rev 1.15    2003.10.02 9:27:50 PM  czhower
  DotNet Excludes

  Rev 1.14    01/10/2003 17:58:52  HHariri
  More fixes for Multipart Messages and also fixes for incorrect transfer
  encoding settings

  Rev 1.12    9/28/03 1:36:04 PM  RLebeau
  Updated GenerateHeader() to support the BBCList property

  Rev 1.11    26/09/2003 00:29:34  CCostelloe
  IdMessage.Encoding now set when email decoded; XXencoded emails now decoded;
  logic added to GenerateHeader

  Rev 1.10    04/09/2003 20:42:04  CCostelloe
  GenerateHeader sets From's Name field to Address field if Name blank;
  trailing spaces removed after boundary in FindBoundary; force generation of
  InReplyTo header.

  Rev 1.9    29/07/2003 01:14:30  CCostelloe
  In-Reply-To fixed in GenerateHeader

  Rev 1.8    11/07/2003 01:11:02  CCostelloe
  GenerateHeader changed from function to procedure, results now put in
  LastGeneratedHeaders.  Better for user (can see headers sent) and code still
  efficient.

  Rev 1.7    10/07/2003 22:39:00  CCostelloe
  Added LastGeneratedHeaders field and modified GenerateHeaders so that a copy
  of the last set of headers generated for this message is maintained (see
  comments starting "CC")

  Rev 1.6    2003.06.23 9:46:54 AM  czhower
  Russian, Ukranian support for headers.

  Rev 1.5    6/3/2003 10:46:54 PM  JPMugaas
  In-Reply-To header now supported.

    Rev 1.4    1/27/2003 10:07:46 PM  DSiders
  Corrected error setting file stream permissions in LoadFromFile.  Bug Report
  649502.

  Rev 1.3    27/1/2003 3:07:10 PM  SGrobety
  X-Priority header only added if priority <> mpNormal (because of spam filters)

  Rev 1.2    09/12/2002 18:19:00  ANeillans    Version: 1.2
  Removed X-Library Line that was causing people problems with spam detection
  software , etc.

  Rev 1.1    12/5/2002 02:53:56 PM  JPMugaas
  Updated for new API definitions.

  Rev 1.0    11/13/2002 07:56:52 AM  JPMugaas

2004-05-04 Ciaran Costelloe
  - Replaced meUU with mePlainText.  This also meant that UUE/XXE encoding was pushed
    down from the message-level to the MessagePart level, where it belongs.

2004-04-20 Ciaran Costelloe
  - Added support for multiple From addresses (per RFC 2822, section 3.6.2) by
      adding a FromList field.  The previous From field now maps to FromList[0].

2003-10-04 Ciaran Costelloe (see comments starting CC4)

2003-09-20 Ciaran Costelloe (see comments starting CC2)
  - Added meDefault, meXX to TIdMessageEncoding.
      Code now sets TIdMessage.Encoding when it decodes an email.
      Modified TIdMIMEBoundary to work as a straight stack, now Push/Pops ParentPart also.
    Added meDefault, meXX to TIdMessageEncoding.
    Moved logic from SendBody to GenerateHeader, added extra logic to avoid exceptions:
        Change any encodings we dont know to base64
      We dont support attachments in an encoded body, change it to a supported combination
    Made changes to support ConvertPreamble and MIME message bodies with a
      ContentTransferEncoding of base64, quoted-printable.
      ProcessHeaders now decodes BCC list.

2003-09-02 Ciaran Costelloe
  - Added fix to FindBoundary suggested by Juergen Haible to remove trailing space
    after boundary added by some clients.

2003-07-10 Ciaran Costelloe
  - Added LastGeneratedHeaders property, see comments starting CC.  Changed
      GenerateHeader from function to procedure, it now puts the generated headers
    into LastGeneratedHeaders, which is where dependant units should take the
    results from.  This ensures that the headers that were generated are
    recorded, which some users' programs may need.

2002-12-09 Andrew Neillans
  - Removed X-Library line

2002-08-30 Andrew P.Rybin
    - Now InitializeISO is IdMessage method

2001-12-27 Andrew P.Rybin
  Custom InitializeISO, ExtractCharSet

2001-Oct-29 Don Siders
  Added EIdMessageCannotLoad exception.
  Added RSIdMessageCannotLoad constant.
  Added TIdMessage.LoadFromStream.
  Modified TIdMessage.LoadFromFile to call LoadFromStream.
  Added TIdMessage.SaveToStream.
  Modified TIdMessage.SaveToFile to call SaveToStream.
  Modified TIdMessage.GenerateHeader to include headers received but not used in properties.

2001-Sep-14 Andrew Neillans
  Added LoadFromFile Header only

2001-Sep-12 Johannes Berg
  Fixed upper/Sys.LowerCase in uses clause for Kylix

2001-Aug-09 Allen O'Neill
  Added line to check for valid charset value before adding second ';' after content-type boundry

2001-Aug-07 Allen O'Neill
  Added SaveToFile & LoadFromFile ... Doychin fixed

2001-Jul-11 Hadi Hariri
  Added Encoding for both MIME and UU.

2000-Jul-25 Hadi Hariri
 - Added support for MBCS

2000-Jun-10 Pete Mee
 - Fixed some minor but annoying bugs.

2000-May-06 Pete Mee
 - Added coder support directly into TIdMessage.
}

unit IdMessage;

{
  2001-Jul-11 Hadi Hariri

  TODO: Make checks for encoding and content-type later on.
  TODO: Add TIdHTML, TIdRelated
  TODO: CountParts on the fly
  TODO: Merge Encoding and AttachmentEncoding
  TODO: Make encoding plugable
  TODO: Clean up ISO header coding
}

{ TODO : Moved Decode/Encode out and will add later,. Maybe TIdMessageEncode, Decode?? }

{ TODO : Support any header in TMessagePart }

{ DESIGN NOTE: The TIdMessage has an fBody which should only ever be the
    raw message.  TIdMessage.fBody is only raw if TIdMessage.fIsEncoded = true

    The component parts are thus possibly made up of the following
    order of TMessagePart entries:

    MP[0] : Possible prologue text (fBoundary is '')

    MP[0 or 1 - depending on prologue existence] :
      fBoundary = boundary parameter from Content-Type

    MP[next...] : various parts with or without fBoundary = ''

    MP[MP.Count - 1] : Possible epilogue text (fBoundary is '')
    }

{ DESIGN NOTE: If TMessagePart.fIsEncoded = True, then TMessagePart.fBody
    is the encoded raw message part.  Otherwise, it is the (decoded) text.
    }

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdAttachment,
  IdBaseComponent,
  IdCoderHeader,
  IdEMailAddress,
  IdExceptionCore,
  IdHeaderList,
  IdMessageParts;

type
  TIdMessagePriority = (mpHighest, mpHigh, mpNormal, mpLow, mpLowest);

const
  ID_MSG_NODECODE = False;
  ID_MSG_USESNOWFORDATE = True;
  ID_MSG_PRIORITY = mpNormal;

type
  TIdMIMEBoundary = class(TObject)
  protected
    FBoundaryList: TStrings;
    {CC: Added ParentPart as a TStrings so I dont have to create a TIntegers}
    FParentPartList: TStrings;
    function GetBoundary: string;
    function GetParentPart: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Push(ABoundary: string; AParentPart: integer);
    procedure Pop;
    procedure Clear;
    function Count: integer;

    property Boundary: string read GetBoundary;
    property ParentPart: integer read GetParentPart;
  end;

  TIdMessageFlags =
  ( mfAnswered, //Message has been answered.
    mfFlagged, //Message is "flagged" for urgent/special attention.
    mfDeleted, //Message is "deleted" for removal by later EXPUNGE.
    mfDraft, //Message has not completed composition (marked as a draft).
    mfSeen, //Message has been read.
    mfRecent ); //Message is "recently" arrived in this mailbox.

  TIdMessageFlagsSet = set of TIdMessageFlags;

  {WARNING: Replaced meUU with mePlainText in Indy 10 due to meUU being misleading.
  This is the MESSAGE-LEVEL "encoding", really the Sys.Format or layout of the message.
  When encoding, the user can let Indy decide on the encoding by leaving it at
  meDefault, or he can pick meMIME or mePlainText }

  //TIdMessageEncoding = (meDefault, meMIME, meUU, meXX);
  TIdMessageEncoding = (meDefault, meMIME, mePlainText);

  TIdInitializeIsoEvent = procedure (var VHeaderEncoding: Char;
    var VCharSet: string) of object;

  TIdMessage = class;

  TIdCreateAttachmentEvent = procedure(const AMsg: TIdMessage;
    const AHeaders: TStrings; var AAttachment: TIdAttachment) of object;

  TIdMessage = class(TIdBaseComponent)
  protected
    FAttachmentTempDirectory: string;
    FBccList: TIdEmailAddressList;
    FBody: TStrings;
    FCharSet: string;
    FCcList: TIdEmailAddressList;
    FContentType: string;
    FContentTransferEncoding: string;
    FContentDisposition: string;
    FDate: TDateTime;
    FIsEncoded : Boolean;
    FExtraHeaders: TIdHeaderList;
    FEncoding: TIdMessageEncoding;
    FFlags: TIdMessageFlagsSet;
    FFromList: TIdEmailAddressList;
    FHeaders: TIdHeaderList;
    FMessageParts: TIdMessageParts;
    FMIMEBoundary: TIdMIMEBoundary;
    FMsgId: string;
    FNewsGroups: TStrings;
    FNoEncode: Boolean;
    FNoDecode: Boolean;
    FOnInitializeISO: TIdInitializeISOEvent;
    FOrganization: string;
    FPriority: TIdMessagePriority;
    FSubject: string;
    FReceiptRecipient: TIdEmailAddressItem;
    FRecipients: TIdEmailAddressList;
    FReferences: string;
    FInReplyTo : String;
    FReplyTo: TIdEmailAddressList;
    FSender: TIdEMailAddressItem;
    FUID: String;
    FXProgram: string;
    FOnCreateAttachment: TIdCreateAttachmentEvent;
    FLastGeneratedHeaders: TIdHeaderList;
    FConvertPreamble: Boolean;
    FSavingToFile: Boolean;
    FIsMsgSinglePartMime: Boolean;
    FExceptionOnBlockedAttachments: Boolean; // used in TIdAttachmentFile
    //
    procedure DoInitializeISO(var VHeaderEncoding: Char; var VCharSet: String); virtual;
    function  GetAttachmentEncoding: string;
    function  GetInReplyTo: String;
    function  GetUseNowForDate: Boolean;
    function  GetFrom: TIdEmailAddressItem;
    procedure SetAttachmentEncoding(const AValue: string);
    procedure SetAttachmentTempDirectory(const Value: string);
    procedure SetBccList(const AValue: TIdEmailAddressList);
    procedure SetBody(const AValue: TStrings);
    procedure SetCCList(const AValue: TIdEmailAddressList);
    procedure SetContentType(const AValue: String);
    procedure SetEncoding(const AValue: TIdMessageEncoding);
    procedure SetExtraHeaders(const AValue: TIdHeaderList);
    procedure SetFrom(const AValue: TIdEmailAddressItem);
    procedure SetFromList(const AValue: TIdEmailAddressList);
    procedure SetHeaders(const AValue: TIdHeaderList);
    procedure SetInReplyTo(const AValue : String);
    procedure SetMsgID(const AValue : String);
    procedure SetNewsGroups(const AValue: TStrings);
    procedure SetReceiptRecipient(const AValue: TIdEmailAddressItem);
    procedure SetRecipients(const AValue: TIdEmailAddressList);
    procedure SetReplyTo(const AValue: TIdEmailAddressList);
    procedure SetSender(const AValue: TIdEmailAddressItem);
    procedure SetUseNowForDate(const AValue: Boolean);
    procedure InitComponent; override;
  public
    destructor Destroy; override;

    procedure AddHeader(const AValue: string);
    procedure Clear; virtual;
    procedure ClearBody;
    procedure ClearHeader;
    procedure GenerateHeader; virtual;
    procedure InitializeISO(var VHeaderEncoding: Char; var VCharSet: String);
    function  IsBodyEncodingRequired: Boolean;
    function  IsBodyEmpty: Boolean;

    procedure LoadFromFile(const AFileName: string; const AHeadersOnly: Boolean = False);
    procedure LoadFromStream(AStream: TStream; const AHeadersOnly: Boolean = False);

    procedure ProcessHeaders; virtual;

    procedure SaveToFile(const AFileName : string; const AHeadersOnly: Boolean = False);
    procedure SaveToStream(AStream: TStream; const AHeadersOnly: Boolean = False);

    procedure DoCreateAttachment(const AHeaders: TStrings; var VAttachment: TIdAttachment); virtual;
    //
    property Flags: TIdMessageFlagsSet read FFlags write FFlags;
    property IsEncoded : Boolean read FIsEncoded write FIsEncoded;
    property MsgId: string read FMsgId write SetMsgID;
    property Headers: TIdHeaderList read FHeaders write SetHeaders;
    property MessageParts: TIdMessageParts read FMessageParts;
    property MIMEBoundary: TIdMIMEBoundary read FMIMEBoundary;
    property UID: String read FUID write FUID;
    property IsMsgSinglePartMime: Boolean read FIsMsgSinglePartMime write FIsMsgSinglePartMime;
  published
    //TODO: Make a property editor which drops down the registered coder types
    property AttachmentEncoding: string read GetAttachmentEncoding write SetAttachmentEncoding;
    property Body: TStrings read FBody write SetBody;
    property BccList: TIdEmailAddressList read FBccList write SetBccList;
    property CharSet: string read FCharSet write FCharSet;
    property CCList: TIdEmailAddressList read FCcList write SetCcList;
    property ContentType: string read FContentType write SetContentType;
    property ContentTransferEncoding: string read FContentTransferEncoding
     write FContentTransferEncoding;
    property ContentDisposition: string read FContentDisposition write FContentDisposition;
    property Date: TDateTime read FDate write FDate;
    //
    property Encoding: TIdMessageEncoding read FEncoding write SetEncoding;
    property ExtraHeaders: TIdHeaderList read FExtraHeaders write SetExtraHeaders;
    property FromList: TIdEmailAddressList read FFromList write SetFromList;
    property From: TIdEmailAddressItem read GetFrom write SetFrom;
    property NewsGroups: TStrings read FNewsGroups write SetNewsGroups;
    property NoEncode: Boolean read FNoEncode write FNoEncode default ID_MSG_NODECODE;
    property NoDecode: Boolean read FNoDecode write FNoDecode default ID_MSG_NODECODE;
    property Organization: string read FOrganization write FOrganization;
    property Priority: TIdMessagePriority read FPriority write FPriority default ID_MSG_PRIORITY;
    property ReceiptRecipient: TIdEmailAddressItem read FReceiptRecipient write SetReceiptRecipient;
    property Recipients: TIdEmailAddressList read FRecipients write SetRecipients;
    property References: string read FReferences write FReferences;
    property InReplyTo : String read GetInReplyTo write SetInReplyTo;
    property ReplyTo: TIdEmailAddressList read FReplyTo write SetReplyTo;
    property Subject: string read FSubject write FSubject;
    property Sender: TIdEmailAddressItem read FSender write SetSender;
    property UseNowForDate: Boolean read GetUseNowForDate write SetUseNowForDate default ID_MSG_USESNOWFORDATE;
    property LastGeneratedHeaders: TIdHeaderList read FLastGeneratedHeaders;
    property ConvertPreamble: Boolean read FConvertPreamble write FConvertPreamble;
    property ExceptionOnBlockedAttachments: Boolean read FExceptionOnBlockedAttachments write FExceptionOnBlockedAttachments default False;
    property AttachmentTempDirectory: string read FAttachmentTempDirectory write SetAttachmentTempDirectory;

    // Events
    property OnInitializeISO: TIdInitializeIsoEvent read FOnInitializeISO write FOnInitializeISO;
    property OnCreateAttachment: TIdCreateAttachmentEvent read FOnCreateAttachment write FOnCreateAttachment;
  End;

  TIdMessageEvent = procedure(ASender : TComponent; var AMsg : TIdMessage) of object;

  EIdTextInvalidCount = class(EIdMessageException);

  // 2001-Oct-29 Don Siders
  EIdMessageCannotLoad = class(EIdMessageException);

const
  MessageFlags : array [mfAnswered..mfRecent] of String =
  ( '\Answered', {Do not Localize} //Message has been answered.
    '\Flagged',  {Do not Localize} //Message is "flagged" for urgent/special attention.
    '\Deleted',  {Do not Localize} //Message is "deleted" for removal by later EXPUNGE.
    '\Draft',    {Do not Localize} //Message has not completed composition (marked as a draft).
    '\Seen',     {Do not Localize} //Message has been read.
    '\Recent' ); {Do not Localize} //Message is "recently" arrived in this mailbox.

  INREPLYTO = 'In-Reply-To'; {Do not localize}

implementation

uses
  //facilitate inlining only.
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.IO,
    {$ENDIF}
  {$ENDIF}
  IdIOHandlerStream, IdGlobal,
  IdMessageCoderMIME, // Here so the 'MIME' in create will always suceed
  IdCharSets, IdGlobalProtocols, IdMessageCoder, IdResourceStringsProtocols,
  IdMessageClient, IdAttachmentFile,
  IdText, SysUtils;

const
  cPriorityStrs: array[TIdMessagePriority] of string = ('urgent', 'urgent', 'normal', 'non-urgent', 'non-urgent');
  cImportanceStrs: array[TIdMessagePriority] of string = ('high', 'high', 'normal', 'low', 'low');

{ TIdMIMEBoundary }

procedure TIdMIMEBoundary.Clear;
begin
  FBoundaryList.Clear;
  FParentPartList.Clear;
end;

function TIdMIMEBoundary.Count: integer;
begin
  Result := FBoundaryList.Count;
end;

constructor TIdMIMEBoundary.Create;
begin
  inherited;
  FBoundaryList := TStringList.Create;
  FParentPartList := TStringList.Create;
end;

destructor TIdMIMEBoundary.Destroy;
begin
  FreeAndNil(FBoundaryList);
  FreeAndNil(FParentPartList);
  inherited;
end;

function TIdMIMEBoundary.GetBoundary: string;
begin
  if FBoundaryList.Count > 0 then begin
    Result := FBoundaryList.Strings[0];
  end else begin
    Result := '';
  end;
end;

function TIdMIMEBoundary.GetParentPart: integer;
begin
  if FParentPartList.Count > 0 then begin
    Result := IndyStrToInt(FParentPartList.Strings[0]);
  end else begin
    Result := -1;
  end;
end;

procedure TIdMIMEBoundary.Pop;
begin
  if FBoundaryList.Count > 0 then begin
    FBoundaryList.Delete(0);
  end;
  if FParentPartList.Count > 0 then begin
    FParentPartList.Delete(0);
  end;
end;

procedure TIdMIMEBoundary.Push(ABoundary: string; AParentPart: integer);
begin
  {CC: Changed implementation to a simple stack}
  FBoundaryList.Insert(0, ABoundary);
  FParentPartList.Insert(0, IntToStr(AParentPart));
end;

{ TIdMessage }

procedure TIdMessage.AddHeader(const AValue: string);
begin
  FHeaders.Add(AValue);
end;

procedure TIdMessage.Clear;
begin
  ClearHeader;
  ClearBody;
end;

procedure TIdMessage.ClearBody;
begin
  MessageParts.Clear;
  Body.Clear;
end;

procedure TIdMessage.ClearHeader;
begin
  CcList.Clear;
  BccList.Clear;
  Date := 0;
  FromList.Clear;
  NewsGroups.Clear;
  Organization := '';
  References := '';
  ReplyTo.Clear;
  Subject := '';
  Recipients.Clear;
  Priority := ID_MSG_PRIORITY;
  ReceiptRecipient.Text := '';
  FContentType := '';
  FCharSet := '';
  ContentTransferEncoding := '';
  ContentDisposition := '';
  FSender.Text := '';
  Headers.Clear;
  ExtraHeaders.Clear;
  FMIMEBoundary.Clear;
//  UseNowForDate := ID_MSG_USENOWFORDATE;
  Flags := [];
  MsgId := '';
  UID := '';
  FLastGeneratedHeaders.Clear;
  FEncoding := meDefault; {CC3: Changed initial encoding from meMIME to meDefault}
  FConvertPreamble := True;  {By default, in MIME, we convert the preamble text to the 1st TIdText part}
  FSavingToFile := False;  {Only set True by SaveToFile}
  FIsMsgSinglePartMime := False;
end;

procedure TIdMessage.InitComponent;
begin
  inherited;
  FBody := TStringList.Create;
  TStringList(FBody).Duplicates := dupAccept;
  FRecipients := TIdEmailAddressList.Create(Self);
  FBccList := TIdEmailAddressList.Create(Self);
  FCcList := TIdEmailAddressList.Create(Self);
  FMessageParts := TIdMessageParts.Create(Self);
  FNewsGroups := TStringList.Create;
  FHeaders := TIdHeaderList.Create(QuoteRFC822);
  FFromList := TIdEmailAddressList.Create(Self);
  FReplyTo := TIdEmailAddressList.Create(Self);
  FSender := TIdEmailAddressItem.Create;
  FExtraHeaders := TIdHeaderList.Create(QuoteRFC822);
  FReceiptRecipient := TIdEmailAddressItem.Create;
  NoDecode := ID_MSG_NODECODE;
  FMIMEBoundary := TIdMIMEBoundary.Create;
  FLastGeneratedHeaders := TIdHeaderList.Create(QuoteRFC822);
  Clear;
  FEncoding := meDefault;
end;

destructor TIdMessage.Destroy;
begin
  FreeAndNil(FBody);
  FreeAndNil(FRecipients);
  FreeAndNil(FBccList);
  FreeAndNil(FCcList);
  FreeAndNil(FMessageParts);
  FreeAndNil(FNewsGroups);
  FreeAndNil(FHeaders);
  FreeAndNil(FExtraHeaders);
  FreeAndNil(FFromList);
  FreeAndNil(FReplyTo);
  FreeAndNil(FSender);
  FreeAndNil(FReceiptRecipient);
  FreeAndNil(FMIMEBoundary);
  FreeAndNil(FLastGeneratedHeaders);
  inherited Destroy;
end;

function  TIdMessage.IsBodyEmpty: Boolean;
//Determine if there really is anything in the body
var
  LN: integer;
  LOrd: integer;
begin
  Result := False;
  for LN := 1 to Length(Body.Text) do begin
    LOrd := Ord(Body.Text[LN]);
    if ((LOrd <> 13) and (LOrd <> 10) and (LOrd <> 9) and (LOrd <> 32)) then begin
      Exit;
    end;
  end;
  Result := True;
end;

procedure TIdMessage.GenerateHeader;
var
  ISOCharset: string;
  HeaderEncoding: Char;
  LN: Integer;
  LEncoding, LCharSet, LMIMEBoundary: string;
  LDate: TDateTime;
  LReceiptRecipient: string;
begin
  MessageParts.CountParts;
  {CC2: If the encoding is meDefault, the user wants us to pick an encoding mechanism:}
  if Encoding = meDefault then begin
    if MessageParts.Count = 0 then begin
      {If there are no attachments, we want the simplest type, just the headers
      followed by the message body: mePlainText does this for us}
      Encoding := mePlainText;
    end else begin
      {If there are any attachments, default to MIME...}
      Encoding := meMIME;
    end;
  end;
  for LN := 0 to MessageParts.Count-1 do begin
    {Change any encodings we don't know to base64 for MIME and UUE for PlainText...}
    LEncoding := ExtractHeaderItem(MessageParts[LN].ContentTransfer);
    if LEncoding <> '' then begin
      if Encoding = meMIME then begin
        if PosInStrArray(LEncoding, ['7bit', '8bit', 'binary', 'base64', 'quoted-printable', 'binhex40'], False) = -1 then begin {do not localize}
          MessageParts[LN].ContentTransfer := 'base64';                 {do not localize}
        end;
      end
      else if PosInStrArray(LEncoding, ['UUE', 'XXE'], False) = -1 then begin {do not localize}
        //mePlainText
        MessageParts[LN].ContentTransfer := 'UUE';                    {do not localize}
      end;
    end;
  end;
  {RLebeau: should we validate the TIdMessage.ContentTransferEncoding property as well?}
  
  {CC2: We dont support attachments in an encoded body.
  Change it to a supported combination...}
  if MessageParts.Count > 0 then begin
    if (ContentTransferEncoding <> '') and
     (not IsHeaderValue(ContentTransferEncoding, ['7bit', '8bit', 'binary'])) then begin {do not localize}
      ContentTransferEncoding := '';
    end;
  end;
  if Encoding = meMIME then begin
    //HH: Generate Boundary here so we know it in the headers and body
    //######### SET UP THE BOUNDARY STACK ########
    //RLebeau: Moved this logic up from SendBody to here, where it fits better...
    MIMEBoundary.Clear;
    LMIMEBoundary := TIdMIMEBoundaryStrings.GenerateBoundary;
    MIMEBoundary.Push(LMIMEBoundary, -1);  //-1 is "top level"
    //CC: Moved this logic up from SendBody to here, where it fits better...
    if Length(ContentType) = 0 then begin
      //User has omitted ContentType.  We have to guess here, it is impossible
      //to determine without having procesed the parts.
      //See if it is multipart/alternative...
      if MessageParts.TextPartCount > 1 then begin
        if MessageParts.AttachmentCount > 0 then begin
          ContentType := 'multipart/mixed';    {do not localize}
        end else begin
          ContentType := 'multipart/alternative';   {do not localize}
        end;
      end else
      begin
        //Just one (or 0?) text part.
        if MessageParts.AttachmentCount > 0 then begin
          ContentType := 'multipart/mixed';    {do not localize}
        end else begin
          ContentType := 'text/plain';    {do not localize}
        end;
      end;
    end;
    TIdMessageEncoderInfo(MessageParts.MessageEncoderInfo).InitializeHeaders(Self);
  end;

  InitializeISO(HeaderEncoding, ISOCharSet);
  FLastGeneratedHeaders.Assign(FHeaders);
  FIsMsgSinglePartMime := (Encoding = meMIME) and (MessageParts.Count = 1) and IsBodyEmpty;

  // TODO: when STRING_IS_ANSI is defined, provide a way for the user to specify the AnsiString encoding for header values...

  {CC: If From has no Name field, use the Address field as the Name field by setting last param to True (for SA)...}
  FLastGeneratedHeaders.Values['From'] := EncodeAddress(FromList, HeaderEncoding, ISOCharSet, True); {do not localize}
  FLastGeneratedHeaders.Values['Subject'] := EncodeHeader(Subject, '', HeaderEncoding, ISOCharSet); {do not localize}
  FLastGeneratedHeaders.Values['To'] := EncodeAddress(Recipients, HeaderEncoding, ISOCharSet); {do not localize}
  FLastGeneratedHeaders.Values['Cc'] := EncodeAddress(CCList, HeaderEncoding, ISOCharSet); {do not localize}
  {CC: SaveToFile sets FSavingToFile to True so that BCC names are saved
   when saving to file and omitted otherwise (as required by SMTP)...}
  if not FSavingToFile then begin
    FLastGeneratedHeaders.Values['Bcc'] := ''; {do not localize}
  end else begin
    FLastGeneratedHeaders.Values['Bcc'] := EncodeAddress(BCCList, HeaderEncoding, ISOCharSet); {do not localize}
  end;
  FLastGeneratedHeaders.Values['Newsgroups'] := NewsGroups.CommaText; {do not localize}

  if Encoding = meMIME then
  begin
    if IsMsgSinglePartMime then begin
      {This is a single-part MIME: the part may be a text part or an attachment.
      The relevant headers need to be taken from MessageParts[0].  The problem,
      however, is that we have not yet processed MessageParts[0] yet, so we do
      not have its properties or header content properly set up.  So we will
      let the processing of MessageParts[0] append its headers to the message
      headers, i.e. DON'T generate Content-Type or Content-Transfer-Encoding
      headers here.}
      FLastGeneratedHeaders.Values['MIME-Version'] := '1.0'; {do not localize}

      {RLebeau: need to wipe out the following headers if they were present,
      otherwise MessageParts[0] will duplicate them instead of replacing them.
      This is because LastGeneratedHeaders is sent before MessageParts[0] is
      processed.}
      FLastGeneratedHeaders.Values['Content-Type'] := '';
      FLastGeneratedHeaders.Values['Content-Transfer-Encoding'] := '';
      FLastGeneratedHeaders.Values['Content-Disposition'] := '';
    end else begin
      if FContentType <> '' then begin
        LCharSet := FCharSet;
        if (LCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin {do not localize}
          LCharSet := 'us-ascii';  {do not localize}
        end;
        FLastGeneratedHeaders.Values['Content-Type'] := FContentType;  {do not localize}
        FLastGeneratedHeaders.Params['Content-Type', 'charset'] := LCharSet;  {do not localize}
        if (MessageParts.Count > 0) and (LMIMEBoundary <> '') then begin
          FLastGeneratedHeaders.Params['Content-Type', 'boundary'] := LMIMEBoundary;  {do not localize}
        end;
      end;
      {CC2: We may have MIME with no parts if ConvertPreamble is True}
      FLastGeneratedHeaders.Values['MIME-Version'] := '1.0'; {do not localize}
      FLastGeneratedHeaders.Values['Content-Transfer-Encoding'] := ContentTransferEncoding; {do not localize}
    end;
  end else begin
    //CC: non-MIME can have ContentTransferEncoding of base64, quoted-printable...
    LCharSet := FCharSet;
    if (LCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin {do not localize}
      LCharSet := 'us-ascii';  {do not localize}
    end;
    FLastGeneratedHeaders.Values['Content-Type'] := FContentType;  {do not localize}
    FLastGeneratedHeaders.Params['Content-Type', 'charset'] := LCharSet;  {do not localize}
    FLastGeneratedHeaders.Values['Content-Transfer-Encoding'] := ContentTransferEncoding; {do not localize}
  end;
  FLastGeneratedHeaders.Values['Sender'] := EncodeAddressItem(Sender, HeaderEncoding, ISOCharSet); {do not localize}
  FLastGeneratedHeaders.Values['Reply-To'] := EncodeAddress(ReplyTo, HeaderEncoding, ISOCharSet); {do not localize}
  FLastGeneratedHeaders.Values['Organization'] := EncodeHeader(Organization, '', HeaderEncoding, ISOCharSet); {do not localize}

  LReceiptRecipient := EncodeAddressItem(ReceiptRecipient, HeaderEncoding, ISOCharSet);
  FLastGeneratedHeaders.Values['Disposition-Notification-To'] := LReceiptRecipient; {do not localize}
  FLastGeneratedHeaders.Values['Return-Receipt-To'] := LReceiptRecipient; {do not localize}

  FLastGeneratedHeaders.Values['References'] := References; {do not localize}

  if UseNowForDate then begin
    LDate := Now;
  end else begin
    LDate := Self.Date;
  end;
  FLastGeneratedHeaders.Values['Date'] := LocalDateTimeToGMT(LDate); {do not localize}

  // S.G. 27/1/2003: Only issue X-Priority header if priority <> mpNormal (for stoopid spam filters)
  // RLebeau 2/2/2014: add a new Importance property 
  if Priority <> mpNormal then begin
    FLastGeneratedHeaders.Values['Priority'] := cPriorityStrs[Priority]; {do not localize}
    FLastGeneratedHeaders.Values['X-Priority'] := IntToStr(Ord(Priority) + 1); {do not localize}
    FLastGeneratedHeaders.Values['Importance'] := cImportanceStrs[Priority]; {do not localize}
  end else begin
    FLastGeneratedHeaders.Values['Priority'] := '';    {do not localize}
    FLastGeneratedHeaders.Values['X-Priority'] := '';    {do not localize}
    FLastGeneratedHeaders.Values['Importance'] := '';    {do not localize}
  end;

  FLastGeneratedHeaders.Values['Message-ID'] := MsgId;

  // RLebeau 9/12/2016: no longer auto-generating In-Reply-To based on
  // Message-ID. Many email servers will reject an outgoing email that
  // does not have a client-assigned Message-ID, and this method does not
  // know whether this email is a new message or a response to another
  // email when generating headers.  If the calling app wants to send
  // In-Reply-To, it will just have to populate that header like any other.

  FLastGeneratedHeaders.Values['In-Reply-To'] := InReplyTo; {do not localize}

  // Add extra headers created by UA - allows duplicates
  if (FExtraHeaders.Count > 0) then begin
    FLastGeneratedHeaders.AddStrings(FExtraHeaders);
  end;

  {TODO: Generate Message-ID if at all possible to pacify SA.  Do this after FExtraHeaders
   added in case there is a message-ID present as an extra header.}
  {
  if FLastGeneratedHeaders.Values['Message-ID'] = '' then begin //do not localize
    FLastGeneratedHeaders.Values['Message-ID'] := '<' + IntToStr(Abs( CurrentProcessId )) + '.' + IntToStr(Abs( GetClockValue )) + '@' + GStack.HostName + '>'; //do not localize
  end;
  }
end;

procedure TIdMessage.ProcessHeaders;
var
  LBoundary: string;
  LMIMEVersion: string;

  // Some mailers send priority as text, number or combination of both
  function GetMsgPriority(APriority: string): TIdMessagePriority;
  var
    s: string;
    Num: integer;
  begin
    APriority := LowerCase(APriority);
    // TODO: use PostInStrArray() instead of IndyPos()
    // This is for Pegasus / X-MSMail-Priority / Importance headers
    if (IndyPos('non-urgent', APriority) <> 0) or {do not localize}
       (IndyPos('low', APriority) <> 0) then {do not localize}
    begin
      Result := mpLowest;
      // Although a matter of choice, IMO mpLowest is better choice than mpLow,
      // various examples on the net also use 1 as urgent and 5 as non-urgent
    end
    else if (IndyPos('urgent', APriority) <> 0) or {do not localize}
            (IndyPos('high', APriority) <> 0) then {do not localize}
    begin
      Result := mpHighest;
      // Although a matter of choice, IMO mpHighest is better choice than mpHigh,
      // various examples on the net also use 1 as urgent and 5 as non-urgent
    end else
    begin
      s := Trim(APriority);
      Num := IndyStrToInt(Fetch(s, ' '), 3); {do not localize}
      if (Num < 1) or (Num > 5) then begin
        Num := 3;
      end;
      Result := TIdMessagePriority(Num - 1);
    end;
  end;

begin
  // RLebeau: per RFC 2045 Section 5.2:
  //
  // Default RFC 822 messages without a MIME Content-Type header are taken
  // by this protocol to be plain text in the US-ASCII character set,
  // which can be explicitly specified as:
  //
  //   Content-type: text/plain; charset=us-ascii
  //
  // This default is assumed if no Content-Type header field is specified.
  // It is also recommend that this default be assumed when a
  // syntactically invalid Content-Type header field is encountered. In
  // the presence of a MIME-Version header field and the absence of any
  // Content-Type header field, a receiving User Agent can also assume
  // that plain US-ASCII text was the sender's intent.  Plain US-ASCII
  // text may still be assumed in the absence of a MIME-Version or the
  // presence of an syntactically invalid Content-Type header field, but
  // the sender's intent might have been otherwise.

  FContentType := Headers.Values['Content-Type']; {do not localize}
  if FContentType = '' then begin
    FContentType := 'text/plain';  {do not localize}
    FCharSet := 'us-ascii';  {do not localize}
  end else begin
    FContentType := RemoveHeaderEntry(FContentType, 'charset', FCharSet, QuoteMIME);  {do not localize}
    if (FCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin  {do not localize}
      FCharSet := 'us-ascii';  {do not localize}
    end;
  end;

  ContentTransferEncoding := Headers.Values['Content-Transfer-Encoding']; {do not localize}
  ContentDisposition := Headers.Values['Content-Disposition'];  {do not localize}
  Subject := DecodeHeader(Headers.Values['Subject']); {do not localize}
  DecodeAddresses(Headers.Values['From'], FromList); {do not localize}
  MsgId := Headers.Values['Message-Id']; {do not localize}
  CommaSeparatedToStringList(Newsgroups, Headers.Values['Newsgroups']); {do not localize}
  DecodeAddresses(Headers.Values['To'], Recipients); {do not localize}
  DecodeAddresses(Headers.Values['Cc'], CCList); {do not localize}
  {CC2: Added support for BCCList...}
  DecodeAddresses(Headers.Values['Bcc'], BCCList); {do not localize}
  Organization := Headers.Values['Organization']; {do not localize}
  InReplyTo := Headers.Values['In-Reply-To']; {do not localize}

  ReceiptRecipient.Text := Headers.Values['Disposition-Notification-To']; {do not localize}
  if Length(ReceiptRecipient.Text) = 0 then begin
    ReceiptRecipient.Text := Headers.Values['Return-Receipt-To']; {do not localize}
  end;

  References := Headers.Values['References']; {do not localize}

  DecodeAddresses(Headers.Values['Reply-To'], ReplyTo); {do not localize}

  Date := GMTToLocalDateTime(Headers.Values['Date']); {do not localize}
  Sender.Text := Headers.Values['Sender']; {do not localize}

  // RLebeau 2/2/2014: add a new Importance property 
  if Length(Headers.Values['X-Priority']) > 0 then begin {do not localize}
    // Examine X-Priority first - to get better resolution if possible and because it is the most common
    Priority := GetMsgPriority(Headers.Values['X-Priority']); {do not localize}
  end
  else if Length(Headers.Values['Priority']) > 0 then begin {do not localize}
    // Which header should be here is matter of a bit of research, it might be that Importance might be checked first
    Priority := GetMsgPriority(Headers.Values['Priority']) {do not localize}
  end
  else if Length(Headers.Values['Importance']) > 0 then begin {do not localize}
    // Check Importance or Priority
    Priority := GetMsgPriority(Headers.Values['Importance']) {do not localize}
  end
  else if Length(Headers.Values['X-MSMail-Priority']) > 0 then begin {do not localize}
    // This is the least common header (or at least should be) so can be checked last
    Priority := GetMsgPriority(Headers.Values['X-MSMail-Priority']) {do not localize}
  end
  else begin
    Priority := mpNormal;
  end;

  {Note that the following code ensures MIMEBoundary.Count is 0 for single-part MIME messages...}
  FContentType := RemoveHeaderEntry(FContentType, 'boundary', LBoundary, QuoteMIME);  {do not localize}
  if LBoundary <> '' then begin
    MIMEBoundary.Push(LBoundary, -1);
  end;

  {CC2: Set MESSAGE_LEVEL "encoding" (really the format or layout)}
  LMIMEVersion := Headers.Values['MIME-Version']; {do not localize}
  if LMIMEVersion = '' then begin
    Encoding := mePlainText;
  end else begin
    // TODO: this should be true if a MIME boundary is present.
    // The MIME version is optional...
    Encoding := meMIME;
  end;
end;

procedure TIdMessage.SetBccList(const AValue: TIdEmailAddressList);
begin
  FBccList.Assign(AValue);
end;

procedure TIdMessage.SetBody(const AValue: TStrings);
begin
  FBody.Assign(AValue);
end;

procedure TIdMessage.SetCCList(const AValue: TIdEmailAddressList);
begin
  FCcList.Assign(AValue);
end;

procedure TIdMessage.SetContentType(const AValue: String);
var
  LCharSet: String;
begin
  // RLebeau: per RFC 2045 Section 5.2:
  //
  // Default RFC 822 messages without a MIME Content-Type header are taken
  // by this protocol to be plain text in the US-ASCII character set,
  // which can be explicitly specified as:
  //
  //   Content-type: text/plain; charset=us-ascii
  //
  // This default is assumed if no Content-Type header field is specified.
  // It is also recommend that this default be assumed when a
  // syntactically invalid Content-Type header field is encountered. In
  // the presence of a MIME-Version header field and the absence of any
  // Content-Type header field, a receiving User Agent can also assume
  // that plain US-ASCII text was the sender's intent.  Plain US-ASCII
  // text may still be assumed in the absence of a MIME-Version or the
  // presence of an syntactically invalid Content-Type header field, but
  // the sender's intent might have been otherwise.

  if AValue <> '' then
  begin
    FContentType := RemoveHeaderEntry(AValue, 'charset', LCharSet, QuoteMIME); {do not localize}

    {RLebeau: the ContentType property is streamed after the CharSet property,
    so do not overwrite it during streaming}
    if csReading in ComponentState then begin
      Exit;
    end;

    if (LCharSet = '') and (FCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin {do not localize}
      LCharSet := 'us-ascii'; {do not localize}
    end;

    {RLebeau: override the current CharSet only if the header specifies a new value}
    if LCharSet <> '' then begin
      FCharSet := LCharSet;
    end;
  end else
  begin
    FContentType := 'text/plain'; {do not localize}

    {RLebeau: the ContentType property is streamed after the CharSet property,
    so do not overwrite it during streaming}
    if not (csReading in ComponentState) then begin
      FCharSet := 'us-ascii'; {do not localize}
    end;
  end;
end;

procedure TIdMessage.SetExtraHeaders(const AValue: TIdHeaderList);
begin
  FExtraHeaders.Assign(AValue);
end;

procedure TIdMessage.SetFrom(const AValue: TIdEmailAddressItem);
begin
  GetFrom.Assign(AValue);
end;

function  TIdMessage.GetFrom: TIdEmailAddressItem;
begin
  if FFromList.Count = 0 then begin
    FFromList.Add;
  end;
  Result := FFromList[0];
end;

procedure TIdMessage.SetFromList(const AValue: TIdEmailAddressList);
begin
  FFromList.Assign(AValue);
end;

procedure TIdMessage.SetHeaders(const AValue: TIdHeaderList);
begin
  FHeaders.Assign(AValue);
end;

procedure TIdMessage.SetNewsGroups(const AValue: TStrings);
begin
  FNewsgroups.Assign(AValue);
end;

procedure TIdMessage.SetReceiptRecipient(const AValue: TIdEmailAddressItem);
begin
  FReceiptRecipient.Assign(AValue);
end;

procedure TIdMessage.SetRecipients(const AValue: TIdEmailAddressList);
begin
  FRecipients.Assign(AValue);
end;

procedure TIdMessage.SetReplyTo(const AValue: TIdEmailAddressList);
begin
  FReplyTo.Assign(AValue);
end;

procedure TIdMessage.SetSender(const AValue: TIdEmailAddressItem);
begin
  FSender.Assign(AValue);
end;

function TIdMessage.GetUseNowForDate: Boolean;
begin
  Result := (FDate = 0);
end;

procedure TIdMessage.SetUseNowForDate(const AValue: Boolean);
begin
  if GetUseNowForDate <> AValue then begin
    if AValue then begin
      FDate := 0;
    end else begin
      FDate := Now;
    end;
  end;
end;

procedure TIdMessage.SetAttachmentEncoding(const AValue: string);
begin
  MessageParts.AttachmentEncoding := AValue;
end;

function TIdMessage.GetAttachmentEncoding: string;
begin
  Result := MessageParts.AttachmentEncoding;
end;

procedure TIdMessage.SetEncoding(const AValue: TIdMessageEncoding);
begin
  FEncoding := AValue;
  if AValue = meMIME then begin
    AttachmentEncoding := 'MIME';    {do not localize}
  end else begin
    //Default to UUE for mePlainText, user can override to XXE by calling
    //TIdMessage.AttachmentEncoding := 'XXE';
    AttachmentEncoding := 'UUE';    {do not localize}
  end;
end;

procedure TIdMessage.LoadFromFile(const AFileName: string; const AHeadersOnly: Boolean = False);
var
  LStream: TIdReadFileExclusiveStream;
begin
  if not FileExists(AFilename) then begin
    raise EIdMessageCannotLoad.CreateFmt(RSIdMessageCannotLoad, [AFilename]);
  end;
  LStream := TIdReadFileExclusiveStream.Create(AFilename); try
    LoadFromStream(LStream, AHeadersOnly);
  finally FreeAndNil(LStream); end;
end;

procedure TIdMessage.LoadFromStream(AStream: TStream; const AHeadersOnly: Boolean = False);
var
  LMsgClient: TIdMessageClient;
begin
  // clear message properties, headers before loading
  Clear;
  LMsgClient := TIdMessageClient.Create;
  try
    LMsgClient.ProcessMessage(Self, AStream, AHeadersOnly);
  finally
    LMsgClient.Free;
  end;
end;

procedure TIdMessage.SaveToFile(const AFileName: string; const AHeadersOnly: Boolean = False);
var
  LStream : TFileStream;
begin
  LStream := TIdFileCreateStream.Create(AFileName); try
    FSavingToFile := True; try
      SaveToStream(LStream, AHeadersOnly);
    finally FSavingToFile := False; end;
  finally FreeAndNil(LStream); end;
end;

procedure TIdMessage.SaveToStream(AStream: TStream; const AHeadersOnly: Boolean = False);
var
  LMsgClient: TIdMessageClient;
  LIOHandler: TIdIOHandlerStream;
begin
  LMsgClient := TIdMessageClient.Create(nil); try
    LIOHandler := TIdIOHandlerStream.Create(nil, nil, AStream); try
      LIOHandler.FreeStreams := False;
      LMsgClient.IOHandler := LIOHandler;
      LMsgClient.SendMsg(Self, AHeadersOnly);
      // add the end of message marker when body is included
      if not AHeadersOnly then begin
        LMsgClient.IOHandler.WriteLn('.');  {do not localize}
      end;
    finally FreeAndNil(LIOHandler); end;
  finally FreeAndNil(LMsgClient); end;
end;

procedure TIdMessage.DoInitializeISO(var VHeaderEncoding: Char; var VCharSet: string);
begin
  if Assigned(FOnInitializeISO) then begin
    FOnInitializeISO(VHeaderEncoding, VCharSet);//APR
  end;
end;

procedure TIdMessage.InitializeISO(var VHeaderEncoding: Char; var VCharSet: String);
var
  LDefCharset: TIdCharSet;
begin
  // it's not clear when FHeaderEncoding should be Q not B.
  // Comments welcome on atozedsoftware.indy.general

  LDefCharset := IdGetDefaultCharSet;

  case LDefCharset of
    idcs_ISO_8859_1:
      begin
        VHeaderEncoding := 'Q';     { quoted-printable }    {Do not Localize}
        VCharSet := IdCharsetNames[LDefCharset];
      end;
    idcs_UNICODE_1_1:
      begin
        VHeaderEncoding := 'B';     { base64 }    {Do not Localize}
        VCharSet := IdCharsetNames[idcs_UTF_8];
      end;
    else
      begin
        VHeaderEncoding := 'B';     { base64 }    {Do not Localize}
        VCharSet := IdCharsetNames[LDefCharset];
      end;
  end;

  DoInitializeISO(VHeaderEncoding, VCharSet);
end;

procedure TIdMessage.DoCreateAttachment(const AHeaders: TStrings;
  var VAttachment: TIdAttachment);
begin
  VAttachment := nil;
  if Assigned(FOnCreateAttachment) then begin
    FOnCreateAttachment(Self, AHeaders, VAttachment);
  end;
  if VAttachment = nil then begin
    VAttachment := TIdAttachmentFile.Create(MessageParts);
  end;
end;

function TIdMessage.IsBodyEncodingRequired: Boolean;
var
  i,j: Integer;
  S: String;
begin
  Result := False;//7bit
  for i:= 0 to FBody.Count - 1 do begin
    S := FBody[i];
    for j := 1 to Length(S) do begin
      if S[j] > #127 then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;//

function TIdMessage.GetInReplyTo: String;
begin
  Result := EnsureMsgIDBrackets(FInReplyTo);
end;

procedure TIdMessage.SetInReplyTo(const AValue: String);
begin
  FInReplyTo := EnsureMsgIDBrackets(AValue);
end;

// TODO: add this?
{
procedure TIdMessage.GetMsgID: String;
begin
  Result := EnsureMsgIDBrackets(FMsgId);
end;
}

procedure TIdMessage.SetMsgID(const AValue: String);
begin
  FMsgId := EnsureMsgIDBrackets(AValue);
end;

procedure TIdMessage.SetAttachmentTempDirectory(const Value: string);
begin
  if Value <> AttachmentTempDirectory then begin
    FAttachmentTempDirectory := IndyExcludeTrailingPathDelimiter(Value);
  end;
end;

end.

