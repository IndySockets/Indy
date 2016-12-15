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
  Rev 1.29    3/1/2005 3:35:48 PM  BGooijen
  Auth

  Rev 1.28    1/11/2005 3:09:06 AM  JPMugaas
  Fix.  A NNTP banner should not be obtained after STARTTLS succeded.

  Rev 1.27    10/26/2004 10:33:46 PM  JPMugaas
  Updated refs.

  Rev 1.26    2004.05.20 11:37:02 AM  czhower
  IdStreamVCL

  Rev 1.25    16/05/2004 14:30:42  CCostelloe
  ReceiveHeader checks added in case message has no body

  Rev 1.24    3/7/2004 11:21:50 PM  JPMugaas
  Compiler warnings.

  Rev 1.23    2004.03.06 1:31:46 PM  czhower
  To match Disconnect changes to core.

  Rev 1.22    2004.02.03 5:44:10 PM  czhower
  Name changes

  Rev 1.21    2004.01.28 9:36:32 PM  czhower
  Fixed search and replace error

  Rev 1.20    2004.01.27 1:13:36 PM  czhower
  T --> TId
  var --> out

  Rev 1.19    1/26/2004 1:16:46 PM  JPMugaas
  SSL Reenabled.

  Rev 1.18    2004.01.22 9:28:44 PM  czhower
  DotNetExclude for TLS.

  Rev 1.17    1/21/2004 3:26:50 PM  JPMugaas
  InitComponent

  Rev 1.16    1/5/2004 8:22:18 PM  JMJacobson
  Updated TIdNNTP.GetCapability to handle empty LIST EXTENSIONS response
  (response 215)

  Rev 1.15    11/11/03 11:06:18 AM  RLebeau
  Updated SendCmd() to test for a 281 response when issuing an AUTHINFO USER
  command, as per RFC 2980

  Rev 1.14    2003.10.24 10:33:22 AM  czhower
  Saved first this time.

  Rev 1.12    10/19/2003 5:31:52 PM  DSiders
  Added localization comments.

  Rev 1.11    2003.10.14 9:57:16 PM  czhower
  Compile todos

  Rev 1.10    2003.10.12 4:04:00 PM  czhower
  compile todos

  Rev 1.9    9/10/2003 03:26:12 AM  JPMugaas
  Updated GetArticle(), GetBody(), and GetHeader() to use new
  EnsureMsgIDBrackets() function in IdGlobal.  Checked in on behalf of Remy
  Lebeau

  Rev 1.8    6/9/2003 05:14:58 AM  JPMugaas
  Fixed crical error.
  Supports HDR and OVER commands defined in
  http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-18.txt if feature
  negotiation indicates that they are supported.
  Added XHDR data parsing routine.
  Added events for when we receive a line of data with XOVER or XHDR as per
  John Jacobson's request.

  Rev 1.7    6/9/2003 01:09:40 AM  JPMugaas
  Host wasn't published when it should have been published.

  Rev 1.6    6/5/2003 04:54:00 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.5    5/8/2003 11:28:06 AM  JPMugaas
  Moved feature negoation properties down to the ExplicitTLSClient level as
  feature negotiation goes hand in hand with explicit TLS support.

  Rev 1.4    4/5/2003 02:06:20 PM  JPMugaas
  TLS handshake itself can now be handled.

  Rev 1.3    3/27/2003 05:46:36 AM  JPMugaas
  Updated framework with an event if the TLS negotiation command fails.
  Cleaned up some duplicate code in the clients.

  Rev 1.2    3/26/2003 04:18:22 PM  JPMugaas
  Now supports implicit and explicit TLS.

  Rev 1.1    2/24/2003 09:25:16 PM  JPMugaas

  Rev 1.0    11/13/2002 07:57:52 AM  JPMugaas

  2001-Dec - Chad Z. Hower a.k.a. Kudzu
    -Continued modifications

  2001-Oct - Chad Z. Hower a.k.a. Kudzu
    -Massive reworking to fit the Indy 9 model and update a lot of outdated code
     that was left over from Delphi 4 days. Updates now use overloaded functions.
    There were also several problems with message number accounting.

  2000-Jun-23 J. Peter Mugaas
    -GetNewGroupsList, GetNewGroupsList, and GetNewNewsList No longer require
     an Event handler if you provide a TStrings to those procedures
    -ParseXOVER was added so that you could parse XOVER data
    -ParseNewsGroup was ripped from GetNewGroupsList so that newsgroups can
     be parsed while not downloading newsgroups
    -Moved some duplicate code into a separate procedure
    -The IdNNTP now uses the Indy exceptions and IdResourceStrings to facilitate
     internationalization

  2000-Apr-28 Mark L. Holmes
    -Ported to Indy

  2000-Apr-28
    -Final Version

  1999-Dec-29 MTL
    -Moved to new Palette Scheme (Winshoes Servers)
}

unit IdNNTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdExplicitTLSClientServerBase, IdException, IdGlobal,
  IdMessage, IdMessageClient, IdReplyRFC, 
  IdTCPServer, IdTCPConnection;

{
  Original Author: Chad Z. Hower a.k.a. Kudzu
  Amended and modified by: AHeid, Mark Holmes
}

type
  // Most users of this component should use "mtReader"
  TIdModeType = (mtStream, mtIHAVE, mtReader);
  TIdNNTPPermission = (crCanPost, crNoPost, crAuthRequired, crTempUnavailable);
  TIdModeSetResult = (mrCanStream, mrNoStream, mrCanIHAVE, mrNoIHAVE, mrCanPost, mrNoPost);
  TIdEventStreaming = procedure (AMesgID: string; var AAccepted: Boolean)of object;
  TIdNewsTransporTIdEvent = procedure (AMsg: TStrings) of object;
   //AMsg can be an index number or a message ID depending upon the parameters of XHDR
  TIdEvenTIdNewsgroupList = procedure(ANewsgroup: string; ALow, AHigh: Int64;
   AType: string; var ACanContinue: Boolean) of object;
  TIdEventXOVER = procedure(AArticleIndex : Int64; ASubject,
     AFrom : String; ADate : TDateTime; AMsgId, AReferences : String; AByteCount,
     ALineCount : Integer; AExtraData : String; var VCanContinue : Boolean) of object;
  TIdEventNewNewsList = procedure(AMsgID: string; var ACanContinue: Boolean) of object;
  TIdEventXHDREntry = procedure(AHeader : String; AMsg, AHeaderData : String; var ACanContinue: Boolean) of object;

  //TODO: Add a TranslateRFC822 Marker - probably need to do it in TCPConnection and modify Capture
  // Better yet, make capture an object
  TIdNNTP = class(TIdMessageClient)
  protected
    FGreetingCode : Integer;
    FMsgHigh: Int64;
    FMsgLow: Int64;
    FMsgCount: Int64;
    FNewsAgent: string;
    FOnNewsgroupList,
    FOnNewGroupsList: TIdEvenTIdNewsgroupList;
    FOnNewNewsList: TIdEventNewNewsList;
    FOnXHDREntry : TIdEventXHDREntry;
    FOnXOVER : TIdEventXOVER;
    FModeType: TIdModeType;
    FModeResult: TIdModeSetResult;
    FPermission: TIdNNTPPermission;
    FForceAuth: boolean;

    FHDRSupported : Boolean;
    FOVERSupported : Boolean;
    //
    procedure AfterConnect;
    procedure GetCapability;
    function ConvertDateTimeDist(ADate: TDateTime; AGMT: boolean;
     ADistributions: string): string;
    function GetSupportsTLS : boolean; override;
    procedure InitComponent; override;
    procedure ProcessGroupList(ACmd: string; AResponse: integer;
     ALisTIdEvent: TIdEvenTIdNewsgroupList);
    procedure XHDRCommon(AHeader, AParam : String);
    procedure XOVERCommon(AParam : String);
    procedure StartTLS;
  public
    procedure Check(AMsgIDs: TStrings; AResponses: TStrings);
    procedure Connect; override;
    destructor Destroy; override;
    procedure DisconnectNotifyPeer; override;
    function GetArticle(AMsg: TIdMessage): Boolean; overload;
    function GetArticle(AMsgNo: Int64; AMsg: TIdMessage): Boolean; overload;
    function GetArticle(AMsgID: string; AMsg: TIdMessage): Boolean; overload;
    function GetArticle(AMsg: TStrings): Boolean; overload;
    function GetArticle(AMsgNo: Int64; AMsg: TStrings): Boolean; overload;
    function GetArticle(AMsgID: string; AMsg: TStrings): Boolean; overload;
    function GetArticle(AMsg: TStream): Boolean; overload;
    function GetArticle(AMsgNo: Int64; AMsg: TStream): Boolean; overload;
    function GetArticle(AMsgID: string; AMsg: TStream): Boolean; overload;
    function GetBody(AMsg: TIdMessage): Boolean; overload;
    function GetBody(AMsgNo: Int64; AMsg: TIdMessage): Boolean; overload;
    function GetBody(AMsgID: string; AMsg: TIdMessage): Boolean; overload;
    function GetBody(AMsg: TStrings): Boolean; overload;
    function GetBody(AMsgNo: Int64; AMsg: TStrings): Boolean; overload;
    function GetBody(AMsgID: string; AMsg: TStrings): Boolean; overload;
    function GetBody(AMsg: TStream): Boolean; overload;
    function GetBody(AMsgNo: Int64; AMsg: TStream): Boolean; overload;
    function GetBody(AMsgID: string; AMsg: TStream): Boolean; overload;
    function GetHeader(AMsg: TIdMessage): Boolean; overload;
    function GetHeader(AMsgNo: Int64; AMsg: TIdMessage): Boolean; overload;
    function GetHeader(AMsgID: string; AMsg: TIdMessage): Boolean; overload;
    function GetHeader(AMsg: TStrings): Boolean; overload;
    function GetHeader(AMsgNo: Int64; AMsg: TStrings): Boolean; overload;
    function GetHeader(AMsgID: string; AMsg: TStrings): Boolean; overload;
    function GetHeader(AMsg: TStream): Boolean; overload;
    function GetHeader(AMsgNo: Int64; AMsg: TStream): Boolean; overload;
    function GetHeader(AMsgID: string; AMsg: TStream): Boolean; overload;
    procedure GetNewsgroupList; overload;
    procedure GetNewsgroupList(AList: TStrings); overload;
    procedure GetNewsgroupList(AStream: TStream); overload;
    procedure GetNewGroupsList(ADate: TDateTime; AGMT: boolean;
     ADistributions: string); overload;
    procedure GetNewGroupsList(ADate: TDateTime; AGMT: boolean;
     ADistributions: string; AList : TStrings); overload;
    procedure GetNewNewsList(ANewsgroups: string;
      ADate: TDateTime; AGMT: boolean; ADistributions: string); overload;
    procedure GetNewNewsList(ANewsgroups: string; ADate: TDateTime;
      AGMT: boolean; ADistributions: string; AList : TStrings); overload;
    procedure GetOverviewFMT(AResponse: TStrings);
    function IsExtCmdSupported(AExtension : String) : Boolean;
    procedure IHAVE(AMsg: TStrings);
    function Next: Boolean;
    function Previous: Boolean;
    procedure ParseXOVER(Aline: String; var AArticleIndex : Int64; var ASubject,
     AFrom : String; var ADate : TDateTime; var AMsgId, AReferences : String; var AByteCount,
     ALineCount : Integer; var AExtraData : String);
    procedure ParseNewsGroup(ALine : String; out ANewsGroup: string; out AHi, ALo : Int64;
     out AStatus : String);
    procedure ParseXHDRLine(ALine : String; out AMsg : String; out AHeaderData : String);
    procedure Post(AMsg: TIdMessage); overload;
    procedure Post(AStream: TStream); overload;
    function SendCmd(AOut: string; const AResponse: array of Int16;
      AEncoding: IIdTextEncoding = nil): Int16; override;
    function SelectArticle(AMsgNo: Int64): Boolean;
    procedure SelectGroup(AGroup: string);
    function TakeThis(AMsgID: string; AMsg: TStream): string;
    procedure XHDR(AHeader: string; AParam: string; AResponse: TStrings); overload;
    procedure XHDR(AHeader: string; AParam: string); overload;
    procedure XOVER(AParam: string; AResponse: TStrings); overload;
    procedure XOVER(AParam: string; AResponse: TStream); overload;
    procedure XOVER(AParam: string); overload;
    procedure SendAuth;
    //
    property ModeResult: TIdModeSetResult read FModeResult write FModeResult;
    property MsgCount: Int64 read FMsgCount;
    property MsgHigh: Int64 read FMsgHigh;
    property MsgLow: Int64 read FMsgLow;
    property Permission: TIdNNTPPermission read FPermission;
  published
    property NewsAgent: string read FNewsAgent write FNewsAgent;
    property Mode: TIdModeType read FModeType write FModeType default mtReader;
    property Password;
    property Username;
    property OnNewsgroupList: TIdEvenTIdNewsgroupList read FOnNewsgroupList write FOnNewsgroupList;
    property OnNewGroupsList: TIdEvenTIdNewsGroupList read FOnNewGroupsList write FOnNewGroupsList;
    property OnNewNewsList: TIdEventNewNewsList read FOnNewNewsList write FOnNewNewsList;
    property OnXHDREntry : TIdEventXHDREntry read FOnXHDREntry write FOnXHDREntry;
    property OnXOVER : TIdEventXOVER read FOnXOVER write FOnXOVER;
    property OnTLSNotAvailable;
    property Port default IdPORT_NNTP;
    property Host;
    property UseTLS;
    property ForceAuth:boolean read FForceAuth write FForceAuth default false;
  end;

  EIdNNTPException = class(EIdException);
  EIdNNTPNoOnNewGroupsList = class(EIdNNTPException);
  EIdNNTPNoOnNewNewsList = class(EIdNNTPException);
  EIdNNTPNoOnNewsgroupList = class(EIdNNTPException);
  EIdNNTPNoOnXHDREntry = class(EIdNNTPException);
  EIdNNTPNoOnXOVER = class(EIdNNTPException);
  EIdNNTPStringListNotInitialized = class(EIdNNTPException);

  EIdNNTPConnectionRefused = class (EIdReplyRFCError);

implementation

uses
  IdComponent,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdSSL, SysUtils;

procedure TIdNNTP.ParseXOVER(Aline : String;
  var AArticleIndex : Int64;
  var ASubject,
      AFrom : String;
  var ADate : TDateTime;
  var AMsgId,
      AReferences : String;
  var AByteCount,
      ALineCount : Integer;
  var AExtraData : String);

begin
  {Strip backspace and tab junk sequences which occur after a tab separator so they don't throw off any code}
  ALine := ReplaceAll(ALine, #9#8#9, #9);
  {Article Index}
  AArticleIndex := IndyStrToInt64(Fetch(ALine, #9), 0);
  {Subject}
  ASubject := Fetch(ALine, #9);
  {From}
  AFrom := Fetch(ALine, #9);
  {Date}
  ADate := GMTToLocalDateTime(Fetch(Aline, #9));
  {Message ID}
  AMsgId := Fetch(Aline, #9);
  {References}
  AReferences := Fetch(ALine, #9);
  {Byte Count}
  AByteCount := IndyStrToInt(Fetch(ALine, #9), 0);
  {Line Count}
  ALineCount := IndyStrToInt(Fetch(ALine, #9), 0);
  {Extra data}
  AExtraData := ALine;
end;

procedure TIdNNTP.ParseNewsGroup(ALine : String; out ANewsGroup : String;
  out AHi, ALo : Int64; out AStatus : String);
begin
  ANewsgroup := Fetch(ALine, ' ');
  AHi := IndyStrToInt64(Fetch(Aline, ' '), 0);
  ALo := IndyStrToInt64(Fetch(ALine, ' '), 0);
  AStatus := ALine;
end;

procedure TIdNNTP.InitComponent;
begin
  inherited InitComponent;
  Mode := mtReader;
  Port := IdPORT_NNTP;
  ForceAuth := false;

  FRegularProtPort := IdPORT_NNTP;
  FImplicitTLSProtPort := IdPORT_SNEWS;
  FExplicitTLSProtPort := IdPORT_NNTP;
end;

function TIdNNTP.SendCmd(AOut: string; const AResponse: Array of Int16;
  AEncoding: IIdTextEncoding = nil): Int16;
begin
  // NOTE: Responses must be passed as arrays so that the proper inherited SendCmd is called
  // and a stack overflow is not caused.
  Result := inherited SendCmd(AOut, [], AEncoding);
  if (Result = 480) or (Result = 450) then
  begin
    SendAuth;
    Result := inherited SendCmd(AOut, AResponse, AEncoding);
  end else begin
    CheckResponse(Result, AResponse);
  end;
end;

procedure TIdNNTP.Connect;
begin
  inherited Connect;
  try
    FGreetingCode := GetResponse;
    AfterConnect;
    StartTLS;
    if ForceAuth then begin
      SendAuth;
    end;
  except
    Disconnect(False);
    raise;
  end;
end;

{ This procedure gets the overview format as suported by the server }
procedure TIdNNTP.GetOverviewFMT(AResponse: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  SendCmd('LIST OVERVIEW.FMT', 215);  {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AResponse, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

{ Send the XOVER Command.  XOVER [Range]
  Range can be of the form: Article Number i.e. 1
                            Article Number followed by a dash
                            Article Number followed by a dash and aother number
  Remember to select a group first and to issue a GetOverviewFMT so that you
  can interpret the information sent by the server corectly. }
procedure TIdNNTP.XOVER(AParam: string; AResponse: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  XOVERCommon(AParam);
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AResponse, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

procedure TIdNNTP.XOVER(AParam: string; AResponse: TStream);
var
  LEncoding: IIdTextEncoding;
begin
  XOVERCommon(AParam);
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AResponse, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

{ Send the XHDR Command.  XHDR Header (Range | Message-ID)
  Range can be of the form: Article Number i.e. 1
                            Article Number followed by a dash
                            Article Number followed by a dash and aother number
  Parm is either the Range or the MessageID of the articles you want. They
  are Mutually Exclusive}
procedure TIdNNTP.XHDR(AHeader: string; AParam: String; AResponse: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  { This method will send the XHDR command.
  The programmer is responsible for choosing the correct header. Headers
  that should always work as per RFC 1036 are:

      From
      Date
      Newsgroups
      Subject
      Message-ID
      Path

    These Headers may work... They are optional per RFC1036 and new headers can
    be added at any time as server implementation changes

      Reply-To
      Sender
      Followup-To
      Expires
      References
      Control
      Distribution
      Organization
      Keywords
      Summary
      Approved
      Lines
      Xref
    }
  XHDRCommon(AHeader,AParam);
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AResponse, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

procedure TIdNNTP.SelectGroup(AGroup: string);
var
  s: string;
begin
  SendCmd('GROUP ' + AGroup, 211);  {do not localize}
  s := LastCmdResult.Text[0];
  FMsgCount := IndyStrToInt64(Fetch(s), 0);
  FMsgLow := IndyStrToInt64(Fetch(s), 0);
  FMsgHigh := IndyStrToInt64(Fetch(s), 0);
end;

{ This method will send messages via the IHAVE command.
The IHAVE command first sends the message ID and waits for a response from the
server prior to sending the header and body. This command is of no practical
use for NNTP client readers as readers are generally denied the privelege
to execute the IHAVE command. this is a news transport command. So use this
when you are implementing a NNTP server send unit }

procedure TIdNNTP.IHAVE(AMsg: TStrings);
var
  i     : Integer;
  MsgID : string;
begin
//TODO: Im not sure this fucntion works properly - needs checked
// Why is it not using a TIdMessage?
  // Since we are merely forwarding messages we have already received
  // it is assumed that the required header fields and body are already in place

  // We need to get the message ID from the stringlist because it's required
  // that we send it s part of the IHAVE command
  for i := 0 to AMsg.Count - 1 do
  begin
    if IndyPos('Message-ID', AMsg.Strings[i]) > 0 then begin  {do not localize}
      MsgID := AMsg.Strings[i];
      Fetch(MsgID,':');
      Break;
    end;
  end;
  SendCmd('IHAVE ' + MsgID, 335); {do not localize}
  WriteRFCStrings(AMsg);
  // Why is the response ignored? What is it?
  Readln;
end;

(*
1.1.1  The CHECK command

   CHECK <message-id>

   CHECK is used by a peer to discover if the article with the specified
   message-id should be sent to the server using the TAKETHIS command.
   The peer does not have to wait for a response from the server before
   sending the next command.

   From using the responses to the sequence of CHECK commands, a list of
   articles to be sent can be constructed for subsequent use by the
   TAKETHIS command.

   The use of the CHECK command for streaming is optional.  Some
   implementations will directly use the TAKETHIS command and send all
   articles in the send queue on that peer for the server.

   On some implementations, the use of the CHECK command is not
   permitted when the server is in slave mode (via the SLAVE command).

   Responses that are of the form X3X must specify the message-id in the
   response.

1.1.2.  Responses

      238 no such article found, please send it to me
      400 not accepting articles
      431 try sending it again later
      438 already have it, please don't send it to me
      480 Transfer permission denied
      500 Command not understood
*)
procedure TIdNNTP.Check(AMsgIDs: TStrings; AResponses: TStrings);
var
  i: Integer;
begin
  if not Assigned(AResponses) then begin
    raise EIdNNTPStringListNotInitialized.Create(RSNNTPStringListNotInitialized);
  end;
  for i := 0 to AMsgIDs.Count - 1 do begin
    IOHandler.WriteLn('CHECK '+ AMsgIDs.Strings[i]);  {do not localize}
  end;
  for i := 0 to AMsgIDs.Count - 1 do begin
    AResponses.Add(IOHandler.ReadLn)
  end;
end;

(*
1.3.1  The TAKETHIS command

   TAKETHIS <message-id>

   TAKETHIS is used to send articles to a server when in streaming mode.
   The entire article (header and body, in that sequence) is sent
   immediately after the peer sends the TAKETHIS command.  The peer does
   not have to wait for a response from the server before sending the
   next command and the associated article.

   During transmission of the article, the peer should send the entire
   article, including header and body, in the manner specified for text
   transmission from the server.  See RFC 977, Section 2.4.1 for
   details.

   Responses that are of the form X3X must specify the message-id in the
   response.

1.3.2.  Responses

      239 article transferred ok
      400 not accepting articles
      439 article transfer failed
      480 Transfer permission denied
      500 Command not understood
*)
function TIdNNTP.TakeThis(AMsgID: string; AMsg: TStream): string;
// This message assumes AMsg is "raw" and has already taken care of . to ..
begin
  SendCmd('TAKETHIS ' + AMsgID, 239); {do not localize}
  IOHandler.Write(AMsg);
  IOHandler.WriteLn('.');
end;

(*
3.10.  The POST command

3.10.1.  POST

   POST

   If posting is allowed, response code 340 is returned to indicate that
   the article to be posted should be sent. Response code 440 indicates
   that posting is prohibited for some installation-dependent reason.

   If posting is permitted, the article should be presented in the
   format specified by RFC850, and should include all required header
   lines. After the article's header and body have been completely sent
   by the client to the server, a further response code will be returned
   to indicate success or failure of the posting attempt.

   The text forming the header and body of the message to be posted
   should be sent by the client using the conventions for text received
   from the news server:  A single period (".") on a line indicates the
   end of the text, with lines starting with a period in the original
   text having that period doubled during transmission.

   No attempt shall be made by the server to filter characters, fold or
   limit lines, or otherwise process incoming text.  It is our intent
   that the server just pass the incoming message to be posted to the
   server installation's news posting software, which is separate from
   this specification.  See RFC850 for more details.

   Since most installations will want the client news program to allow
   the user to prepare his message using some sort of text editor, and
   transmit it to the server for posting only after it is composed, the
   client program should take note of the herald message that greeted it
   when the connection was first established. This message indicates
   whether postings from that client are permitted or not, and can be
   used to caution the user that his access is read-only if that is the
   case. This will prevent the user from wasting a good deal of time
   composing a message only to find posting of the message was denied.
   The method and determination of which clients and hosts may post is
   installation dependent and is not covered by this specification.

3.10.2.  Responses

   240 article posted ok
   340 send article to be posted. End with <CR-LF>.<CR-LF>
   440 posting not allowed
   441 posting failed

   (for reference, one of the following codes will be sent upon initial
   connection; the client program should determine whether posting is
   generally permitted from these:) 200 server ready - posting allowed
   201 server ready - no posting allowed
*)
procedure TIdNNTP.Post(AMsg: TIdMessage);
begin
  SendCmd('POST', 340); {do not localize}
  //Header
  if Length(NewsAgent) > 0 then begin
    AMsg.ExtraHeaders.Values['X-Newsreader'] := NewsAgent;  {do not localize}
  end;
  SendMsg(AMsg);
  SendCmd('.', 240);
end;

procedure TIdNNTP.Post(AStream: TStream);
begin
  SendCmd('POST', 340); {do not localize}
  IOHandler.Write(AStream);
  SendCmd('.', 240);
end;

procedure TIdNNTP.ProcessGroupList(ACmd: string; AResponse: integer;
 ALisTIdEvent: TIdEvenTIdNewsgroupList);
var
  s1, sNewsgroup: string;
  lLo, lHi: Int64;
  sStatus: string;
  LCanContinue: Boolean;
begin
  BeginWork(wmRead, 0); try
    SendCmd(ACmd, AResponse);
    s1 := IOHandler.ReadLn;
    LCanContinue := True;
    while (s1 <> '.') and LCanContinue do
    begin
      ParseNewsGroup(s1, sNewsgroup, lHi, lLo, sStatus);
      ALisTIdEvent(sNewsgroup, lLo, lHi, sStatus, LCanContinue);
      s1 := IOHandler.ReadLn;
    end;
  finally
    EndWork(wmRead);
  end;
end;

procedure TIdNNTP.GetNewsgroupList;
begin
  if not Assigned(FOnNewsgroupList) then begin
    raise EIdNNTPNoOnNewsgroupList.Create(RSNNTPNoOnNewsgroupList);
  end;
  ProcessGroupList('LIST', 215, FOnNewsgroupList);  {do not localize}
end;

procedure TIdNNTP.GetNewGroupsList(ADate: TDateTime; AGMT: boolean;
 ADistributions: string);
begin
  if not Assigned(FOnNewGroupsList) then begin
    raise EIdNNTPNoOnNewGroupsList.Create(RSNNTPNoOnNewGroupsList);
  end;
  ProcessGroupList('NEWGROUPS ' + ConvertDateTimeDist(ADate, AGMT, ADistributions), {do not localize}
    231, FOnNewGroupsList);
end;

procedure TIdNNTP.GetNewNewsList(ANewsgroups: string;
 ADate: TDateTime; AGMT: boolean; ADistributions: string);
var
  s1: string;
  CanContinue: Boolean;
begin
  if not Assigned(FOnNewNewsList) then begin
    raise EIdNNTPNoOnNewNewsList.Create(RSNNTPNoOnNewNewsList);
  end;

  BeginWork(wmRead,0); try
    SendCmd('NEWNEWS ' + ANewsgroups + ' ' + ConvertDateTimeDist(ADate, AGMT, ADistributions), 230);  {do not localize}
    s1 := IOHandler.ReadLn;
    CanContinue := True;
    while (s1 <> '.') and CanContinue do begin
      FOnNewNewsList(s1, CanContinue);
      s1 := IOHandler.ReadLn;
    end;
  finally
    EndWork(wmRead);
  end;
end;

(*
3.9.  The NEXT command

3.9.1.  NEXT

   NEXT

   The internally maintained "current article pointer" is advanced to
   the next article in the current newsgroup.  If no more articles
   remain in the current group, an error message is returned and the
   current article remains selected.

   The internally-maintained "current article pointer" is set by this
   command.

   A response indicating the current article number, and the message-id
   string will be returned.  No text is sent in response to this
   command.

3.9.2.  Responses

   223 n a article retrieved - request text separately
           (n = article number, a = unique article id)
   412 no newsgroup selected
   420 no current article has been selected
   421 no next article in this group
*)
function TIdNNTP.Next: Boolean;
begin
  Result := SendCmd('NEXT', [223, 421]) = 223;  {do not localize}
end;

(*
3.5.  The LAST command

3.5.1.  LAST

   LAST

   The internally maintained "current article pointer" is set to the
   previous article in the current newsgroup.  If already positioned at
   the first article of the newsgroup, an error message is returned and
   the current article remains selected.

   The internally-maintained "current article pointer" is set by this
   command.

   A response indicating the current article number, and a message-id
   string will be returned.  No text is sent in response to this
   command.

3.5.2.  Responses

   223 n a article retrieved - request text separately
           (n = article number, a = unique article id)
   412 no newsgroup selected
   420 no current article has been selected
   422 no previous article in this group
*)
function TIdNNTP.Previous: Boolean;
begin
  Result := SendCmd('LAST', [223, 422]) = 223;  {do not localize}
end;

function TIdNNTP.SelectArticle(AMsgNo: Int64): Boolean;
begin
  Result := SendCmd('STAT ' + IntToStr(AMsgNo), [223, 423]) = 223;  {do not localize}
end;

procedure TIdNNTP.GetNewsgroupList(AList: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  SendCmd('LIST', 215); {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AList, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

procedure TIdNNTP.GetNewGroupsList(ADate: TDateTime; AGMT: boolean;
 ADistributions: string; AList: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  SendCmd('NEWGROUPS ' + ConvertDateTimeDist(ADate, AGMT, ADistributions), 231);  {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AList, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

procedure TIdNNTP.GetNewNewsList(ANewsgroups: string; ADate: TDateTime;
 AGMT: boolean; ADistributions: string; AList: TStrings);
var
  LEncoding: IIdTextEncoding;
begin
  SendCmd('NEWNEWS ' + ANewsgroups + ' ' + ConvertDateTimeDist(ADate, AGMT, ADistributions), 230);  {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AList, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.ConvertDateTimeDist(ADate: TDateTime; AGMT: boolean;
 ADistributions: string): string;
begin
  Result := FormatDateTime('yymmdd hhnnss', ADate); {do not localize}
  if AGMT then begin
    Result:= Result + ' GMT'; {do not localize}
  end;
  if Length(ADistributions) > 0 then begin
    Result := ' <' + ADistributions + '>';
  end;
end;

(*
3.1.  The ARTICLE, BODY, HEAD, and STAT commands

   There are two forms to the ARTICLE command (and the related BODY,
   HEAD, and STAT commands), each using a different method of specifying
   which article is to be retrieved.  When the ARTICLE command is
   followed by a message-id in angle brackets ("<" and ">"), the first
   form of the command is used; when a numeric parameter or no parameter
   is supplied, the second form is invoked.

   The text of the article is returned as a textual response, as
   described earlier in this document.

   The HEAD and BODY commands are identical to the ARTICLE command
   except that they respectively return only the header lines or text
   body of the article.

   The STAT command is similar to the ARTICLE command except that no
   text is returned.  When selecting by message number within a group,
   the STAT command serves to set the current article pointer without
   sending text. The returned acknowledgement response will contain the
   message-id, which may be of some value.  Using the STAT command to
   select by message-id is valid but of questionable value, since a
   selection by message-id does NOT alter the "current article pointer".

3.1.1.  ARTICLE (selection by message-id)

   ARTICLE <message-id>

   Display the header, a blank line, then the body (text) of the
   specified article.  Message-id is the message id of an article as
   shown in that article's header.  It is anticipated that the client
   will obtain the message-id from a list provided by the NEWNEWS
   command, from references contained within another article, or from
   the message-id provided in the response to some other commands.

   Please note that the internally-maintained "current article pointer"
   is NOT ALTERED by this command. This is both to facilitate the
   presentation of articles that may be referenced within an article
   being read, and because of the semantic difficulties of determining
   the proper sequence and membership of an article which may have been
   posted to more than one newsgroup.

3.1.2.  ARTICLE (selection by number)

   ARTICLE [nnn]

   Displays the header, a blank line, then the body (text) of the
   current or specified article.  The optional parameter nnn is the

   numeric id of an article in the current newsgroup and must be chosen
   from the range of articles provided when the newsgroup was selected.
   If it is omitted, the current article is assumed.

   The internally-maintained "current article pointer" is set by this
   command if a valid article number is specified.

   [the following applies to both forms of the article command.] A
   response indicating the current article number, a message-id string,
   and that text is to follow will be returned.

   The message-id string returned is an identification string contained
   within angle brackets ("<" and ">"), which is derived from the header
   of the article itself.  The Message-ID header line (required by
   RFC850) from the article must be used to supply this information. If
   the message-id header line is missing from the article, a single
   digit "0" (zero) should be supplied within the angle brackets.

   Since the message-id field is unique with each article, it may be
   used by a news reading program to skip duplicate displays of articles
   that have been posted more than once, or to more than one newsgroup.

3.1.3.  Responses

   220 n <a> article retrieved - head and body follow
           (n = article number, <a> = message-id)
   221 n <a> article retrieved - head follows
   222 n <a> article retrieved - body follows
   223 n <a> article retrieved - request text separately
   412 no newsgroup has been selected
   420 no current article has been selected
   423 no such article number in this group
   430 no such article found
*)
function TIdNNTP.GetArticle(AMsg: TIdMessage): Boolean;
begin
  Result := True;
  SendCmd('ARTICLE', 220);  {do not localize}
  AMsg.Clear;
  //Don't call ReceiveBody if the message ended at the end of the headers
  //(ReceiveHeader() would have returned '.' in that case)...
  if ReceiveHeader(AMsg) = '' then begin
    ReceiveBody(AMsg);
  end;
end;

function TIdNNTP.GetArticle(AMsgNo: Int64; AMsg: TIdMessage): Boolean;
begin
  // RLebeau: 430 is not supposed to be used with this version of ARTICLE,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('ARTICLE ' + IntToStr(AMsgNo), [220, 423, 430]) = 220; {do not localize}
  if Result then begin
    AMsg.Clear;
    //Don't call ReceiveBody if the message ended at the end of the headers
    //(ReceiveHeader() would have returned '.' in that case)...
    if ReceiveHeader(AMsg) = '' then begin
      ReceiveBody(AMsg);
    end;
  end;
end;

function TIdNNTP.GetArticle(AMsgID: string; AMsg: TIdMessage): Boolean;
begin
  Result := SendCmd('ARTICLE ' + EnsureMsgIDBrackets(AMsgID), [220, 430]) = 220; {do not localize}
  if Result then begin
    AMsg.Clear;
    //Don't call ReceiveBody if the message ended at the end of the headers
    //(ReceiveHeader() would have returned '.' in that case)...
    if ReceiveHeader(AMsg) = '' then begin
      ReceiveBody(AMsg);
    end;
  end;
end;

function TIdNNTP.GetArticle(AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('ARTICLE', 220);  {do not localize}
  AMsg.Clear;
  // per RFC 3977, headers should be in UTF-8, but are not required to,
  // so lets read them as 8-bit...
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetArticle(AMsgNo: Int64; AMsg: TStrings): Boolean;
begin
  // RLebeau: 430 is not supposed to be used with this version of ARTICLE,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('ARTICLE ' + IntToStr(AMsgNo), [220, 423, 430]) = 220; {do not localize}
  if Result then begin
    AMsg.Clear;
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    IOHandler.Capture(AMsg, IndyTextEncoding_8Bit);
  end;
end;

function TIdNNTP.GetArticle(AMsgID: string; AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('ARTICLE ' + EnsureMsgIDBrackets(AMsgID), [220, 430]) = 220; {do not localize}
  if Result then begin
    AMsg.Clear;
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetArticle(AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('ARTICLE', 220);  {do not localize}
  // per RFC 3977, headers should be in UTF-8, but are not required to,
  // so lets read them as 8-bit...
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetArticle(AMsgNo: Int64; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  // RLebeau: 430 is not supposed to be used with this version of ARTICLE,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('ARTICLE ' + IntToStr(AMsgNo), [220, 423, 430]) = 220; {do not localize}
  if Result then begin
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetArticle(AMsgID: string; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('ARTICLE ' + EnsureMsgIDBrackets(AMsgID), [220, 430]) = 220; {do not localize}
  if Result then begin
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetBody(AMsg: TIdMessage): Boolean;
begin
  // RLebeau: The single-parameter GetArticle(TIdMessage) and GetHeader(TIdMessage)
  // methods raise an exception if the currently selected message is not available.
  // All of the single-parameter TStrings and TStream versions of GetArticle(),
  // GetHeader(), and GetBody() do as well. So why is this one method acting
  // differently?  Why is it not raising an exception on 420 like the others do?
  Result := SendCmd('BODY', [222, 420]) = 222; {do not localize}
  if Result then begin
    AMsg.Clear;
    ReceiveBody(AMsg);
  end;
end;

function TIdNNTP.GetBody(AMsgNo: Int64; AMsg: TIdMessage): Boolean;
begin
  // RLebeau: 430 is not supposed to be used with this version of BODY,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('BODY ' + IntToStr(AMsgNo), [222, 423, 430]) = 222;  {do not localize}
  if Result then begin
    AMsg.Clear;
    ReceiveBody(AMsg);
  end;
end;

function TIdNNTP.GetBody(AMsgID: string; AMsg: TIdMessage): Boolean;
begin
  Result := SendCmd('BODY ' + EnsureMsgIDBrackets(AMsgID), [222, 430]) = 222;  {do not localize}
  if Result then begin
    AMsg.Clear;
    ReceiveBody(AMsg);
  end;
end;

function TIdNNTP.GetBody(AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('BODY', 222); {do not localize}
  AMsg.Clear;
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetBody(AMsgNo: Int64; AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  // RLebeau: 430 is not supposed to be used with this version of BODY,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('BODY ' + IntToStr(AMsgNo), [222, 423, 430]) = 222;  {do not localize}
  if Result then begin
    AMsg.Clear;
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetBody(AMsgID: string; AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('BODY ' + EnsureMsgIDBrackets(AMsgID), [222, 430]) = 222;  {do not localize}
  if Result then begin
    AMsg.Clear;
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetBody(AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('BODY', 222); {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetBody(AMsgNo: Int64; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  // RLebeau: 430 is not supposed to be used with this version of BODY,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('BODY ' + IntToStr(AMsgNo), [222, 423, 430]) = 222;  {do not localize}
  if Result then begin
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetBody(AMsgID: string; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('BODY ' + EnsureMsgIDBrackets(AMsgID), [222, 430]) = 222;  {do not localize}
  if Result then begin
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetHeader(AMsg: TIdMessage): Boolean;
begin
  Result := True;
  SendCmd('HEAD', 221); {do not localize}
  AMsg.Clear;
  ReceiveHeader(AMsg);
end;

function TIdNNTP.GetHeader(AMsgNo: Int64; AMsg: TIdMessage): Boolean;
begin
  // RLebeau: 430 is not supposed to be used with this version of HEAD,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('HEAD ' + IntToStr(AMsgNo), [221, 423, 430]) = 221;  {do not localize}
  if Result then begin
    AMsg.Clear;
    ReceiveHeader(AMsg);
  end;
end;

function TIdNNTP.GetHeader(AMsgID: string; AMsg: TIdMessage): Boolean;
begin
  Result := SendCmd('HEAD ' + EnsureMsgIDBrackets(AMsgID), [221, 430]) = 221;  {do not localize}
  if Result then begin
    AMsg.Clear;
    ReceiveHeader(AMsg);
  end;
end;

function TIdNNTP.GetHeader(AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('HEAD', 221); {do not localize}
  AMsg.Clear;
  // per RFC 3977, headers should be in UTF-8, but are not required to,
  // so lets read them as 8-bit...
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetHeader(AMsgNo: Int64; AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  // RLebeau: 430 is not supposed to be used with this version of HEAD,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('HEAD ' + IntToStr(AMsgNo), [221, 423, 430]) = 221;  {do not localize}
  if Result then begin
    AMsg.Clear;
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetHeader(AMsgID: string; AMsg: TStrings): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('HEAD ' + EnsureMsgIDBrackets(AMsgID), [221, 430]) = 221;  {do not localize}
  if Result then begin
    AMsg.Clear;
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetHeader(AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := True;
  SendCmd('HEAD', 221); {do not localize}
  // per RFC 3977, headers should be in UTF-8, but are not required to,
  // so lets read them as 8-bit...
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

function TIdNNTP.GetHeader(AMsgNo: Int64; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  // RLebeau: 430 is not supposed to be used with this version of HEAD,
  // but have seen servers that do, so let's check for it as well...
  Result := SendCmd('HEAD ' + IntToStr(AMsgNo), [221, 423, 430]) = 221;  {do not localize}
  if Result then begin
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdNNTP.GetHeader(AMsgID: string; AMsg: TStream): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := SendCmd('HEAD ' + EnsureMsgIDBrackets(AMsgID), [221, 430]) = 221;  {do not localize}
  if Result then begin
    // per RFC 3977, headers should be in UTF-8, but are not required to,
    // so lets read them as 8-bit...
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(AMsg, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

procedure TIdNNTP.GetNewsgroupList(AStream: TStream);
var
  LEncoding: IIdTextEncoding;
begin
  SendCmd('LIST', 215); {do not localize}
  LEncoding := IndyTextEncoding_8Bit;
  IOHandler.Capture(AStream, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

procedure TIdNNTP.AfterConnect;
begin
  try
   
    // Here lets check to see what condition we are in after being greeted by
    // the server. The application utilizing NNTPWinshoe should check the value
    // of GreetingResult to determine if further action is warranted.

    case FGreetingCode of
      200: FPermission := crCanPost;
      201: FPermission := crNoPost;
      400: FPermission := crTempUnavailable;
      // This should never happen because the server should immediately close
      // the connection but just in case ....
      // Kudzu: Changed this to an exception, otherwise it produces non-standard usage by the
      // users code
      502: raise EIdNNTPConnectionRefused.CreateError(502, RSNNTPConnectionRefused);
    end;
    // here we call SeTIdMode on the value stored in mode to make sure we can
    // use the mode we have selected
    case Mode of
      mtStream: begin
        SendCmd('MODE STREAM'); {do not localize}
        if LastCmdResult.NumericCode <> 203 then begin
          ModeResult := mrNoStream
        end else begin
          ModeResult := mrCanStream;
        end;
      end;
      mtReader: begin
        // We should get the same info we got in the greeting
        // result but we set mode to reader anyway since the
        // server may want to do some internal reconfiguration
        // if it knows that a reader has connected
        SendCmd('MODE READER'); {do not localize}
        if LastCmdResult.NumericCode <> 200 then begin
          ModeResult := mrNoPost;
        end else begin
          ModeResult := mrCanPost;
        end;
      end;
    end;
    GetCapability;
  except
    Disconnect;
    Raise;
  end;
end;

destructor TIdNNTP.Destroy;
begin
  inherited Destroy;
end;

procedure TIdNNTP.GetCapability;
var
  i: Integer;
begin
  FCapabilities.Clear;
  // try CAPABILITIES first, as it is a standard command introduced in RFC 3977
  if SendCmd('CAPABILITIES') = 101 then {do not localize}
  begin
    IOHandler.Capture(FCapabilities, '.'); {do not localize}
  end
  // fall back to the previous non-standard approach
  else if SendCmd('LIST EXTENSIONS') in [202, 215] then  {do not localize}
  begin
    IOHandler.Capture(FCapabilities, '.'); {do not localize}
  end;
  //flatten everything out for easy processing
  for i := 0 to FCapabilities.Count-1 do
  begin
    FCapabilities[i] := Trim(UpperCase(FCapabilities[i]));
  end;
  FOVERSupported := IsExtCmdSupported('OVER');  {do not localize}
  FHDRSupported := IsExtCmdSupported('HDR');  {do not localize}
//  Self.FStartTLSSupported := IsExtCmdSupported('STARTTLS');
end;

function TIdNNTP.IsExtCmdSupported(AExtension: String): Boolean;
begin
  Result := FCapabilities.IndexOf(Trim(UpperCase(AExtension))) > -1;
end;

procedure TIdNNTP.StartTLS;
var
  LIO : TIdSSLIOHandlerSocketBase;
begin
  if (IOHandler is TIdSSLIOHandlerSocketBase) and (FUseTLS <> utNoTLSSupport) then
  begin
    LIO := TIdSSLIOHandlerSocketBase(IOHandler);
    //we check passthrough because we can either be using TLS currently with
    //implicit TLS support or because STARTLS was issued previously.
    if LIO.PassThrough then
    begin
      if IsExtCmdSupported('STARTTLS') then  {do not localize}
      begin
        if SendCmd('STARTTLS') = 382 then {do not localize}
        begin
          TLSHandshake;
          AfterConnect;
        end else begin
          ProcessTLSNegCmdFailed;
        end;
      end else begin
        ProcessTLSNotAvail;
      end;
    end;
  end;
end;

function TIdNNTP.GetSupportsTLS: boolean;
begin
  Result := IsExtCmdSupported('STARTTLS') {do not localize}
end;

procedure TIdNNTP.XHDR(AHeader, AParam: string);
var
  LLine : String;
  LMsg, LHeaderData : String;
  LCanContinue : Boolean;
begin
  if Assigned(FOnXHDREntry) then
  begin
    XHDRCommon(AHeader,AParam);
    BeginWork(wmRead, 0);
    try
      LLine := IOHandler.ReadLn;
      LCanContinue := True;
      while (LLine <> '.') and LCanContinue do
      begin
        ParseXHDRLine(LLine,LMsg,LHeaderData);
        FOnXHDREntry(AHeader,LMsg,LHeaderData,LCanContinue);
        LLine := IOHandler.ReadLn;
      end;
    finally
      EndWork(wmRead);
    end;
  end else
  begin
    raise EIdNNTPNoOnXHDREntry.Create(RSNNTPNoOnXHDREntry);
  end;
end;

procedure TIdNNTP.XOVER(AParam: string);
var
  LLine : String;
  //for our XOVER data
  LArticleIndex : Int64;
  LSubject,
  LFrom : String;
  LDate : TDateTime;
  LMsgId, LReferences : String;
  LByteCount,
  LLineCount : Integer;
  LExtraData : String;
  LCanContinue : Boolean;
begin
  if Assigned( FOnXOVER) then
  begin
    XOVERCommon(AParam);
    BeginWork(wmRead, 0);
    try
      LLine := IOHandler.ReadLn;
      LCanContinue := True;
      while (LLine <> '.') and LCanContinue do
      begin
        ParseXOVER(LLine,LArticleIndex,LSubject,LFrom,LDate,
          LMsgId,LReferences,LByteCount,LLineCount,LExtraData);
        FOnXOVER(LArticleIndex,LSubject,LFrom,LDate,LMsgId,LReferences,LByteCount,LLineCount,LExtraData,LCanContinue);
        LLine := IOHandler.ReadLn;
      end;
    finally
      EndWork(wmRead);
    end;
  end else
  begin
    raise EIdNNTPNoOnXOVER.Create(RSNNTPNoOnXOVER);
  end;
end;

procedure TIdNNTP.ParseXHDRLine(ALine: String; out AMsg,
  AHeaderData: String);
begin
//from:  RFC 2890
//Each line
//containing matched headers returned by the server has an article
//number (or message ID, if a message ID was specified in the command),
//then one or more spaces, then the value of the requested header in
//that article.

//from: http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-18.txt
// describing HDR
// The line consists
//   of the article number, a space, and then the contents of the header
//   (without the header name or the colon and space that follow it) or
//   metadata item. If the article is specified by message-id rather than
//   by article range, the article number is given as "0".
  AMsg := Fetch(ALine);
  AHeaderData := ALine;
end;

procedure TIdNNTP.XHDRCommon(AHeader, AParam : String);
begin
  if FHDRSupported then
  begin
  //http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-18.txt
  //says the correct reply code is 225 but RFC 2980 specifies 221 for the
  //XHDR command so we should accept both to CYA.
    SendCmd('HDR '+ AHeader + ' ' + AParam, [225, 221]);  {do not localize}
  end else
  begin
    SendCmd('XHDR ' + AHeader + ' ' + AParam, 221); {do not localize}
  end;
end;

procedure TIdNNTP.XOVERCommon(AParam: String);
begin
  if FOVERSupported then begin
    SendCmd('OVER '+ AParam, 224);  {do not localize}
  end else begin
    SendCmd('XOVER ' + AParam, 224);  {do not localize}
  end;
end;

procedure TIdNNTP.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', 205);  {do not localize}
end;

procedure TIdNNTP.SendAuth;
begin
  // calling the inherited SendCmd() so as not to handle 480 and 450
  // again, causing a recursive loop...

  // RLebeau - RFC 2980 says that if the password is not required,
  // then 281 will be returned for the username request, not 381.
  if (inherited SendCmd('AUTHINFO USER ' + Username, [281, 381]) = 381) then begin {do not localize}
    inherited SendCmd('AUTHINFO PASS ' + Password, 281);  {do not localize}
  end;
end;

end.

