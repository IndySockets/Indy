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
  Rev 1.31    12/2/2004 4:23:56 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.30    10/26/2004 10:33:46 PM  JPMugaas
  Updated refs.

  Rev 1.29    5/16/04 5:22:54 PM  RLebeau
  Added try...finally to CommandPost()

  Rev 1.28    3/1/2004 1:02:58 PM  JPMugaas
  Fixed for new code.

  Rev 1.27    2004.02.03 5:44:10 PM  czhower
  Name changes

  Rev 1.26    1/21/2004 3:26:58 PM  JPMugaas
  InitComponent

  Rev 1.25    1/1/04 1:22:04 AM  RLebeau
  Bug fix for parameter parsing in CommandNewNews() that was testing the
  ASender.Params.Count incorrectly.

  Rev 1.24    2003.10.21 9:13:12 PM  czhower
  Now compiles.

    Rev 1.23    10/19/2003 5:39:52 PM  DSiders
  Added localization comments.

  Rev 1.22    2003.10.18 9:42:10 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.21    2003.10.12 4:04:02 PM  czhower
  compile todos

  Rev 1.20    9/19/2003 03:30:10 PM  JPMugaas
  Now should compile again.

  Rev 1.19    9/17/2003 10:41:56 PM  PIonescu
  Fixed small mem leak in CommandPost

  Rev 1.18    8/6/2003 6:13:50 PM  SPerry
  Message-ID Integer - > string

  Rev 1.17    8/2/2003 03:53:00 AM  JPMugaas
  Unit needed to be added to uses clause.

  Rev 1.16    8/1/2003 8:21:38 PM  SPerry

  Rev 1.13    5/26/2003 04:28:02 PM  JPMugaas
  Removed GenerateReply and ParseResponse calls because those functions are
  being removed.

  Rev 1.12    5/26/2003 12:23:48 PM  JPMugaas

  Rev 1.11    5/25/2003 03:50:48 AM  JPMugaas

    Rev 1.10    5/21/2003 2:25:04 PM  BGooijen
  changed due to change in IdCmdTCPServer from ReplyExceptionCode: Integer to
  ReplyException: TIdReply

  Rev 1.9    3/26/2003 04:18:26 PM  JPMugaas
  Now supports implicit and explicit TLS.

  Rev 1.7    3/17/2003 08:55:52 AM  JPMugaas
  Missing reply texts.

  Rev 1.6    3/16/2003 08:30:24 AM  JPMugaas
  Reenabled ExplicitTLS according to
  http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt.

  Support is still preliminary.

    Rev 1.5    1/20/2003 1:15:34 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes

  Rev 1.4    1/17/2003 07:10:40 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.3    1/9/2003 06:09:28 AM  JPMugaas
  Updated for IdContext API change.

  Rev 1.2    1/8/2003 05:53:38 PM  JPMugaas
  Switched stuff to IdContext.

  Rev 1.1    12/7/2002 06:43:14 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 07:58:00 AM  JPMugaas

July 2002
  -Kudzu - Fixes to Authorization and other parts

Oct/Nov 2001
  -Kudzu - Rebuild from scratch for proper use of command handlers and around new
  architecture.

2001-Jul-31 Jim Gunkel
  Reorganized for command handlers

2001-Jun-28 Pete Mee
  Begun transformation to TIdCommandHandler

2000-Apr-22 Mark L. Holmes
  Ported to Indy

2000-Mar-27
  Final Version

2000-Jan-13 MTL
  Moved to new Palette Scheme (Winshoes Servers)
}

unit IdNNTPServer;

interface

{$i IdCompilerDefines.inc}

{
Original Author: Ozz Nixon (Winshoes 7)
}

uses
  Classes,
  IdAssignedNumbers, IdContext, IdCustomTCPServer, IdYarn, IdCommandHandlers, IdException,
  IdGlobal, IdServerIOHandler, IdCmdTCPServer, IdExplicitTLSClientServerBase,
   IdTCPConnection, IdTCPServer, IdReply;

(*
 For more information on NNTP visit http://www.faqs.org/rfcs/

 RFC 977 - A Proposed Standard for the Stream-Based Transmission of News
 RFC 2980 - Common NNTP Extensions
 RFC 1036 - Standard for Interchange of USENET Messages
 RFC 822 - Standard for the Format of ARPA Internet Text
 http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-20.txt
*)

(*
Responses

   100 help text follows
   199 debug output

   200 server ready - posting allowed
   201 server ready - no posting allowed
   202 slave status noted
   205 closing connection - goodbye!
   211 n f l s group selected
   215 list of newsgroups follows
   220 n <a> article retrieved - head and body follow
   221 n <a> article retrieved - head follows
   222 n <a> article retrieved - body follows
   223 n <a> article retrieved - request text separately
   230 list of new articles by message-id follows
   231 list of new newsgroups follows
   235 article transferred ok
   240 article posted ok
   281 Authentication accepted

   335 send article to be transferred.  End with <CR-LF>.<CR-LF>
   340 send article to be posted. End with <CR-LF>.<CR-LF>
   381 More authentication information required

   400 service discontinued
   411 no such news group
   412 no newsgroup has been selected
   420 no current article has been selected
   421 no next article in this group
   422 no previous article in this group
   423 no such article number in this group
   430 no such article found
   435 article not wanted - do not send it
   436 transfer failed - try again later
   437 article rejected - do not try again.
   440 posting not allowed
   441 posting failed
   480 Authentication required
   482 Authentication rejected

   500 command not recognized
   501 command syntax error
   502 access restriction or permission denied
   503 program fault - command not performed
*)

const
  DEF_NNTP_IMPLICIT_TLS = False;

type
  EIdNNTPServerException = class(EIdException);

  TIdNNTPAuthType = (atUserPass, atSimple, atGeneric);
  TIdNNTPAuthTypes = set of TIdNNTPAuthType;

  TIdNNTPLookupType = (ltLookupError, ltLookupByMsgId, ltLookupByMsgNo);

  TIdNNTPContext = class(TIdServerContext)
  protected
    FAuthenticated : Boolean;
    FAuthenticator: string;
    FAuthEmail: String;
    FAuthParams: string;
    FAuthType: TIdNNTPAuthType;
    FCurrentArticle: Int64;
    FCurrentGroup: string;
    FModeReader: Boolean;
    FPassword: string;
    FUserName: string;
    function GetUsingTLS: Boolean;
    function GetCanUseExplicitTLS: Boolean;
    function GetTLSIsRequired: Boolean;
    procedure GenerateAuthEmail;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdContextThreadList = nil
      ); override;
    //
    property Authenticated: Boolean read FAuthenticated;
    property Authenticator: string read FAuthenticator;
    property AuthEmail: String read FAuthEmail;
    property AuthParams: string read FAuthParams;
    property AuthType: TIdNNTPAuthType read FAuthType;
    property CurrentArticle: Int64 read FCurrentArticle;
    property CurrentGroup: string read FCurrentGroup;
    property ModeReader: Boolean read FModeReader;
    property Password: string read FPassword;
    property UserName: string read FUserName;
    property UsingTLS : Boolean read GetUsingTLS;
    property CanUseExplicitTLS: Boolean read GetCanUseExplicitTLS;
    property TLSIsRequired: Boolean read GetTLSIsRequired;
  end;

  TIdNNTPOnAuth = procedure(AContext: TIdNNTPContext; var VAccept: Boolean) of object;
  TIdNNTPOnNewGroupsList = procedure(AContext: TIdNNTPContext; const ADateStamp : TDateTime; const ADistributions : String) of object;
  TIdNNTPOnNewNews = procedure(AContext: TIdNNTPContext; const Newsgroups : String; const ADateStamp : TDateTime; const ADistributions : String) of object;
  TIdNNTPOnIHaveCheck = procedure(AContext: TIdNNTPContext; const AMsgID : String; VAccept : Boolean) of object;
  TIdNNTPOnMsgDataByNo = procedure(AContext: TIdNNTPContext; const AMsgNo: Int64) of object;
  TIdNNTPOnMsgDataByID = procedure(AContext: TIdNNTPContext; const AMsgID: string) of object;
  TIdNNTPOnCheckMsgNo = procedure(AContext: TIdNNTPContext; const AMsgNo: Int64;
   var VMsgID: string) of object;
  TIdNNTPOnCheckMsgID = procedure(AContext: TIdNNTPContext; const AMsgId : string; var VMsgNo : Int64) of object;
  //this has to be a separate event type in case a NNTP client selects a message
  //by Message ID instead of Index number.  If that happens, the user has to
  //to return the index number.  NNTP Clients setting STAT by Message ID is not
  //a good idea but is valid.
  TIdNNTPOnMovePointer = procedure(AContext: TIdNNTPContext; var AMsgNo: Int64; var VMsgID: string) of object;
  TIdNNTPOnPost = procedure(AContext: TIdNNTPContext; var VPostOk: Boolean; var VErrorText: string) of object;
  TIdNNTPOnSelectGroup = procedure(AContext: TIdNNTPContext; const AGroup: string;
   var VMsgCount: Int64; var VMsgFirst: Int64; var VMsgLast: Int64;
   var VGroupExists: Boolean) of object;
  TIdNNTPOnCheckListGroup = procedure(AContext: TIdNNTPContext; const AGroup: string;
   var VCanJoin : Boolean; var VFirstArticle : Int64) of object;
  TIdNNTPOnXHdr = procedure(AContext: TIdNNTPContext; const AHeaderName : String;
   const AMsgFirst: Int64; const AMsgLast: Int64; const AMsgID: String) of object;
  TIdNNTPOnXOver = procedure(AContext: TIdNNTPContext; const AMsgFirst: Int64; const AMsgLast: Int64) of object;
  TIdNNTPOnXPat = procedure(AContext: TIdNNTPContext; const AHeaderName : String; const AMsgFirst: Int64;
   const AMsgLast: Int64; const AMsgID: String; const AHeaderPattern: String) of object;
  TIdNNTPOnAuthRequired = procedure(AContext: TIdNNTPContext; const ACommand, AParams : string; var VRequired: Boolean) of object;
  TIdNNTPOnListPattern = procedure(AContext: TIdNNTPContext; const AGroupPattern: String) of object;

  TIdNNTPServer = class(TIdExplicitTLSServer)
  protected
    FHelp: TStrings;
    FDistributionPatterns: TStrings;
    FOverviewFormat: TStrings;
    FSupportedAuthTypes: TIdNNTPAuthTypes;
    FOnArticleById: TIdNNTPOnMsgDataById;
    FOnArticleByNo: TIdNNTPOnMsgDataByNo;
    FOnBodyById: TIdNNTPOnMsgDataById;
    FOnBodyByNo: TIdNNTPOnMsgDataByNo;
    FOnHeadById: TIdNNTPOnMsgDataById;
    FOnHeadByNo: TIdNNTPOnMsgDataByNo;
    FOnCheckMsgId: TidNNTPOnCheckMsgId;
    FOnCheckMsgNo: TIdNNTPOnCheckMsgNo;
    FOnStatMsgId : TIdNNTPOnMsgDataById;
    FOnStatMsgNo : TIdNNTPOnMsgDataByNo;
    FOnNextArticle : TIdNNTPOnMovePointer;
    FOnPrevArticle : TIdNNTPOnMovePointer;
    //LISTGROUP events - Gravity uses these
    FOnCheckListGroup : TIdNNTPOnCheckListGroup;
    FOnListActiveGroups: TIdNNTPOnListPattern;
    FOnListActiveGroupTimes: TIdNNTPOnListPattern;
    FOnListDescriptions : TIdNNTPOnListPattern;
    FOnListDistributions : TIdServerThreadEvent;
    FOnListExtensions: TIdServerThreadEvent;
    FOnListHeaders: TIdServerThreadEvent;
    FOnListSubscriptions : TIdServerThreadEvent;
    FOnListGroup : TIdServerThreadEvent;
    FOnListGroups: TIdServerThreadEvent;
    FOnListNewGroups : TIdNNTPOnNewGroupsList;
    FOnPost: TIdNNTPOnPost;
    FOnSelectGroup: TIdNNTPOnSelectGroup;
    FOnXHdr: TIdNNTPOnXHdr;
    FOnXOver: TIdNNTPOnXOver;
    FOnXROver: TIdNNTPOnXOver;
    FOnXPat: TIdNNTPOnXPat;
    FOnNewNews : TIdNNTPOnNewNews;
    FOnIHaveCheck : TIdNNTPOnIHaveCheck;
    FOnIHavePost: TIdNNTPOnPost;
    FOnAuth: TIdNNTPOnAuth;
    FOnAuthRequired: TIdNNTPOnAuthRequired;

    function SecLayerRequired(ASender: TIdCommand) : Boolean;
    function AuthRequired(ASender: TIdCommand): Boolean;
    function DoCheckMsgID(AContext: TIdNNTPContext; const AMsgID: String): Int64;
    function DoCheckMsgNo(AContext: TIdNNTPContext; const AMsgNo: Int64): String;
    //return MsgID - AThread.CurrentArticlePointer already set
    function RawNavigate(AContext: TIdNNTPContext; AEvent : TIdNNTPOnMovePointer) : String;
    procedure CommandArticle(ASender: TIdCommand);
    procedure CommandAuthInfoUser(ASender: TIdCommand);
    procedure CommandAuthInfoPassword(ASender: TIdCommand);
    procedure CommandAuthInfoSimple(ASender: TIdCommand);
    procedure CommandAuthInfoGeneric(ASender: TIdCommand);
    procedure CommandBody(ASender: TIdCommand);
    procedure CommandDate(ASender: TIdCommand);
    procedure CommandHead(ASender: TIdCommand);
    procedure CommandHelp(ASender: TIdCommand);
    procedure CommandGroup(ASender: TIdCommand);
    procedure CommandIHave(ASender: TIdCommand);
    procedure CommandLast(ASender: TIdCommand);
    procedure CommandList(ASender: TIdCommand);
    procedure CommandListActiveGroups(ASender: TIdCommand);
    procedure CommandListActiveTimes(ASender: TIdCommand);
    procedure CommandListDescriptions(ASender: TidCommand);
    procedure CommandListDistributions(ASender: TIdCommand);
    procedure CommandListDistribPats(ASender: TIdCommand);
    procedure CommandListExtensions(ASender: TIdCommand);
    procedure CommandListGroup(ASender: TIdCommand);
    procedure CommandListHeaders(ASender: TIdCommand);
    procedure CommandListOverview(ASender: TIdCommand);
    procedure CommandListSubscriptions(ASender: TIdCommand);
    procedure CommandModeReader(ASender: TIdCommand);
    procedure CommandNewGroups(ASender: TIdCommand);
    procedure CommandNewNews(ASender: TIdCommand);
    procedure CommandNext(ASender: TIdCommand);
    procedure CommandPost(ASender: TIdCommand);
    procedure CommandSlave(ASender: TIdCommand);
    procedure CommandStat(ASender: TIdCommand);
    procedure CommandXHdr(ASender: TIdCommand);
    procedure CommandXOver(ASender: TIdCommand);
    procedure CommandXROver(ASender: TIdCommand);
    procedure CommandXPat(ASender: TIdCommand);
    procedure CommandSTARTTLS(ASender: TIdCommand);

    procedure DoListGroups(AContext: TIdNNTPContext);
    procedure DoSelectGroup(AContext: TIdNNTPContext; const AGroup: string; var VMsgCount: Int64;
     var VMsgFirst: Int64; var VMsgLast: Int64; var VGroupExists: Boolean);
    procedure InitializeCommandHandlers; override;
    procedure SetDistributionPatterns(AValue: TStrings);
    procedure SetHelp(AValue: TStrings);
    procedure SetOverviewFormat(AValue: TStrings);
    function GetImplicitTLS: Boolean;
    procedure SetImplicitTLS(const AValue: Boolean);
    procedure InitComponent; override;
    function LookupMessage(ASender : TidCommand; var VNo : Int64; var VId : string) : TIdNNTPLookupType;
    function LookupMessageRange(ASender: TIdCommand; const AData: String;
      var VMsgFirst: Int64; var VMsgLast: Int64) : Boolean;
    function LookupMessageRangeOrID(ASender: TIdCommand; const AData: String;
      var VMsgFirst: Int64; var VMsgLast: Int64; var VMsgID: String) : Boolean;
  public
    destructor Destroy; override;
    class function NNTPTimeToTime(const ATimeStamp : String): TDateTime;
    class function NNTPDateTimeToDateTime(const ATimeStamp: string): TDateTime;
  published
    property DistributionPatterns: TStrings read FDistributionPatterns write SetDistributionPatterns;
    property Help: TStrings read FHelp write SetHelp;
    property ImplicitTLS : Boolean read GetImplicitTLS write SetImplicitTLS default DEF_NNTP_IMPLICIT_TLS; // deprecated 'Use UseTLS property';
    property DefaultPort default IdPORT_NNTP;
    property UseTLS;
    property OverviewFormat: TStrings read FOverviewFormat write SetOverviewFormat;
    property SupportedAuthTypes: TIdNNTPAuthTypes read FSupportedAuthTypes write FSupportedAuthTypes;
    property OnArticleById: TIdNNTPOnMsgDataById read FOnArticleById write FOnArticleById;
    property OnArticleByNo: TIdNNTPOnMsgDataByNo read FOnArticleByNo write FOnArticleByNo;
    property OnAuth: TIdNNTPOnAuth read FOnAuth write FOnAuth;
    property OnAuthRequired : TIdNNTPOnAuthRequired read FOnAuthRequired write FOnAuthRequired;
    property OnBodyById: TIdNNTPOnMsgDataById read FOnBodyById write FOnBodyById;
    property OnBodyByNo: TIdNNTPOnMsgDataByNo read FOnBodyByNo write FOnBodyByNo;
    property OnCheckMsgNo: TIdNNTPOnCheckMsgNo read FOnCheckMsgNo write FOnCheckMsgNo;
    property OnCheckMsgID: TidNNTPOnCheckMsgId read FOnCheckMsgId write FOnCheckMsgId;
    property OnHeadById: TIdNNTPOnMsgDataById read FOnHeadById write FOnHeadById;
    property OnHeadByNo: TIdNNTPOnMsgDataByNo read FOnHeadByNo write FOnHeadByNo;
    property OnIHaveCheck : TIdNNTPOnIHaveCheck read FOnIHaveCheck write FOnIHaveCheck;
    property OnIHavePost: TIdNNTPOnPost read FOnIHavePost write FOnIHavePost;
    property OnStatMsgId : TIdNNTPOnMsgDataById read FOnStatMsgId write FOnStatMsgId;
    property OnStatMsgNo : TIdNNTPOnMsgDataByNo read FOnStatMsgNo write FOnStatMsgNo;
    //You are responsible for writing event handlers for these instead of us incrementing
    //and decrimenting the pointer.  This design permits you to implement article expirity,
    //cancels, and supercedes
    property OnNextArticle : TIdNNTPOnMovePointer read FOnNextArticle write FOnNextArticle;
    property OnPrevArticle : TIdNNTPOnMovePointer read FOnPrevArticle write FOnPrevArticle;
    property OnCheckListGroup : TIdNNTPOnCheckListGroup read FOnCheckListGroup write FOnCheckListGroup;
    property OnListActiveGroups: TIdNNTPOnListPattern read FOnListActiveGroups write FOnListActiveGroups;
    property OnListActiveGroupTimes: TIdNNTPOnListPattern read FOnListActiveGroupTimes write FOnListActiveGroupTimes;
    property OnListDescriptions : TIdNNTPOnListPattern read FOnListDescriptions write FOnListDescriptions;
    property OnListDistributions : TIdServerThreadEvent read FOnListDistributions write FOnListDistributions;
    property OnListExtensions : TIdServerThreadEvent read FOnListExtensions write FOnListExtensions;
    property OnListGroup : TIdServerThreadEvent read FOnListGroup write FOnListGroup;
    property OnListGroups: TIdServerThreadEvent read FOnListGroups write FOnListGroups;
    property OnListHeaders : TIdServerThreadEvent read FOnListHeaders write FOnListHeaders;
    property OnListNewGroups : TIdNNTPOnNewGroupsList read FOnListNewGroups write FOnListNewGroups;
    property OnListSubscriptions : TIdServerThreadEvent read FOnListSubscriptions write FOnListSubscriptions;
    property OnNewNews : TIdNNTPOnNewNews read FOnNewNews write FOnNewNews;
    property OnSelectGroup: TIdNNTPOnSelectGroup read FOnSelectGroup write FOnSelectGroup;
    property OnPost: TIdNNTPOnPost read FOnPost write FOnPost;
    property OnXHdr: TIdNNTPOnXHdr read FOnXHdr write FOnXHdr;
    property OnXOver: TIdNNTPOnXOver read FOnXOver write FOnXOver;
    property OnXPat: TIdNNTPOnXPat read FOnXPat write FOnXPat;
    property OnXROver: TIdNNTPOnXOver read FOnXROver write FOnXROver;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.SysTime,
  Posix.Time,
  {$ENDIF}
  IdGlobalProtocols,
  IdIOHandlerSocket,
  IdResourceStringsProtocols,
  IdReplyRFC,
  IdStack,
  IdSSL,
  SysUtils;

{CH const
  AuthTypes: array [1..2] of string = ('USER', 'PASS'); } {Do not localize}

class function TIdNNTPServer.NNTPTimeToTime(const ATimeStamp : String): TDateTime;
var
  LHr, LMn, LSec : Word;
  LTimeStr : String;
begin
  if ATimeStamp <> '' then  {do not localize}
  begin
    LHr := IndyStrToInt(Copy(ATimeStamp,1,2), 1);
    LMn := IndyStrToInt(Copy(ATimeStamp,3,4), 1);
    LSec := IndyStrToInt(Copy(ATimeStamp,5,6), 1);
    Result := EncodeTime(LHr, LMn, LSec, 0);
    LTimeStr := Trim(Copy(ATimeStamp,7,MaxInt));
    if TextIsSame(LTimeStr, 'GMT') then  {do not localize}
    begin
      // Apply local offset
      Result := UTCTimeToLocalTime(Result);
    end;
  end else begin
    Result := 0.0;
  end;
end;

class function TIdNNTPServer.NNTPDateTimeToDateTime(const ATimeStamp : String): TDateTime;
var
  LYr, LMo, LDay : Word;
  LTimeStr : String;
  LDateStr : String;
begin
  Result := 0;
  if ATimeStamp <> '' then  {do not localize}
  begin
    LTimeStr := ATimeStamp;
    LDateStr := Fetch(LTimeStr);
    if Length(LDateStr) > 6 then begin
      //four digit year, good idea - IMAO
      LYr := IndyStrToInt(Copy(LDateStr,1,4), 1969);
      Delete(LDateStr,1,4);
    end else begin
      LYr := IndyStrToInt(Copy(LDateStr,1,2), 69);
      Delete(LDateStr,1,2);
      Inc(LYr, 2000);
    end;
    LMo := IndyStrToInt(Copy(LDateStr,1,2), 1);
    Delete(LDateStr,1,2);
    LDay := IndyStrToInt(Copy(LDateStr,1,2), 1);
    Delete(LDateStr,1,2);
    Result := EncodeDate(LYr, LMo, LDay) + NNTPTimeToTime(LTimeStr);
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

// Note - we dont diffentiate between 423 and 430, we always return 430
procedure TIdNNTPServer.CommandArticle(ASender: TIdCommand);
var
  LMsgID: string;
  LMsgNo: Int64;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      case LookupMessage(ASender, LMsgNo, LMsgID) of
        ltLookupByMsgId: begin
          if Assigned(FOnArticleById) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - head and body follow');  {do not localize}
            ASender.SendReply;
            FOnArticleById(TIdNNTPContext(ASender.Context), LMsgId);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        ltLookupByMsgNo: begin
          if Assigned(FOnArticleByNo) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - head and body follow');  {do not localize}
            ASender.SendReply;
            FOnArticleByNo(TIdNNTPContext(ASender.Context), LMsgNo);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        // ltLookupError is already handled inside of LookupMessage()
      end;
    end;
  end;
end;

// Note - we dont diffentiate between 423 and 430, we always return 430
procedure TIdNNTPServer.CommandBody(ASender: TIdCommand);
var
  LMsgID: string;
  LMsgNo: Int64;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      case LookupMessage(ASender, LMsgNo, LMsgID) of
        ltLookupByMsgId: begin
          if Assigned(FOnBodyById) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - body follows');  {do not localize}
            ASender.SendReply;
            FOnBodyById(TIdNNTPContext(ASender.Context), LMsgId);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        ltLookupByMsgNo: begin
          if Assigned(FOnBodyByNo) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - body follows');  {do not localize}
            ASender.SendReply;
            FOnBodyByNo(TIdNNTPContext(ASender.Context), LMsgNo);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        // ltLookupError is already handled inside of LookupMessage()
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandDate(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    ASender.Reply.SetReply(111, FormatDateTime('yyyymmddhhnnss', LocalTimeToUTCTime(Now)));  {do not localize}
  end;
end;

{*
3.3.  The HELP command

3.3.1.  HELP

   HELP

   Provides a short summary of commands that are understood by this
   implementation of the server. The help text will be presented as a
   textual response, terminated by a single period on a line by itself.

   3.3.2.  Responses

   100 help text follows
*}

procedure TIdNNTPServer.CommandHelp(ASender: TIdCommand);
begin
  if Help.Count > 0 then begin
    ASender.Response.Assign(Help);
  end else begin
    ASender.Response.Text := 'No help available.'; {do not localize}
  end;
end;

(*
3.2.  The GROUP command

3.2.1.  GROUP

   GROUP ggg

   The required parameter ggg is the name of the newsgroup to be
   selected (e.g. "net.news").  A list of valid newsgroups may be
   obtained from the LIST command.

   The successful selection response will return the article numbers of
   the first and last articles in the group, and an estimate of the
   number of articles on file in the group.  It is not necessary that
   the estimate be correct, although that is helpful; it must only be
   equal to or larger than the actual number of articles on file.  (Some
   implementations will actually count the number of articles on file.
   Others will just subtract first article number from last to get an
   estimate.)

   When a valid group is selected by means of this command, the
   internally maintained "current article pointer" is set to the first
   article in the group.  If an invalid group is specified, the
   previously selected group and article remain selected.  If an empty
   newsgroup is selected, the "current article pointer" is in an
   indeterminate state and should not be used.

   Note that the name of the newsgroup is not case-dependent.  It must
   otherwise match a newsgroup obtained from the LIST command or an
   error will result.

3.2.2.  Responses

   211 n f l s group selected
           (n = estimated number of articles in group,
           f = first article number in the group,
           l = last article number in the group,
           s = name of the group.)
   411 no such news group
*)
procedure TIdNNTPServer.CommandGroup(ASender: TIdCommand);
var
  LGroup: string;
  LGroupExists: Boolean;
  LMsgCount: Int64;
  LMsgFirst: Int64;
  LMsgLast: Int64;
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      LGroup := Trim(ASender.UnparsedParams);
      LContext := TIdNNTPContext(ASender.Context);
      DoSelectGroup(LContext, LGroup, LMsgCount, LMsgFirst, LMsgLast, LGroupExists);
      if LGroupExists then begin
        LContext.FCurrentGroup := LGroup;
        ASender.Reply.SetReply(211, IndyFormat('%d %d %d %s', [LMsgCount, LMsgFirst, LMsgLast, LGroup]));  {do not localize}
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandHead(ASender: TIdCommand);
// Note - we dont diffentiate between 423 and 430, we always return 430
var
  LMsgID: string;
  LMsgNo: Int64;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      case LookupMessage(ASender, LMsgNo, LMsgID) of
        ltLookupByMsgId: begin
          if Assigned(FOnHeadById) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - head follows');  {do not localize}
            ASender.SendReply;
            FOnHeadById(TIdNNTPContext(ASender.Context), LMsgID);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        ltLookupByMsgNo: begin
          if Assigned(FOnHeadByNo) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - head follows');  {do not localize}
            ASender.SendReply;
            FOnHeadByNo(TIdNNTPContext(ASender.Context), LMsgNo);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        // ltLookupError is already handled inside of LookupMessage()
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandIHave(ASender: TIdCommand);
var
  LContext : TIdNNTPContext;
  LMsgID : String;
  LAccept:Boolean;
  LErrorText : String;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      LContext := TIdNNTPContext(ASender.Context);
      LMsgID := Trim(ASender.UnparsedParams);
      if TextStartsWith(LMsgID, '<') then begin  {do not localize}
        if Assigned(FOnIHaveCheck) and Assigned(FOnPost) then begin
          FOnIHaveCheck(LContext, LMsgID, LAccept);
          if LAccept then begin
            ASender.Reply.SetReply(335, 'send article to be transferred.  End with <CRLF>.<CRLF>'); {do not localize}
            ASender.SendReply;
            LErrorText := '';  {do not localize}
            FOnPost(LContext, LAccept, LErrorText);
            ASender.Reply.SetReply(iif(LAccept, 235, 436), LErrorText);
          end else begin
            ASender.Reply.NumericCode := 435;
          end;
        end else begin
          ASender.Reply.NumericCode := 500;
        end;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandLast(ASender: TIdCommand);
var
  LMsgNo: Int64;
  LContext: TIdNNTPContext;
  LMsgID : String;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnPrevArticle) then begin
        LContext := TIdNNTPContext(ASender.Context);
        //we do this in a round about way in case there is no previous article at all
        LMsgNo := LContext.CurrentArticle;
        LMsgID := RawNavigate(LContext, FOnPrevArticle);
        if LMsgID <> '' then begin  {do not localize}
          ASender.Reply.SetReply(223, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - request text separately');  {do not localize}
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

(*
3.6.  The LIST command

3.6.1.  LIST

   LIST

   Returns a list of valid newsgroups and associated information.  Each
   newsgroup is sent as a line of text in the following format:

      group last first p

   where <group> is the name of the newsgroup, <last> is the number of
   the last known article currently in that newsgroup, <first> is the
   number of the first article currently in the newsgroup, and <p> is
   either 'y' or 'n' indicating whether posting to this newsgroup is
   allowed ('y') or prohibited ('n').

   The <first> and <last> fields will always be numeric.  They may have
   leading zeros.  If the <last> field evaluates to less than the
   <first> field, there are no articles currently on file in the
   newsgroup.

   Note that posting may still be prohibited to a client even though the
   LIST command indicates that posting is permitted to a particular
   newsgroup. See the POST command for an explanation of client
   prohibitions.  The posting flag exists for each newsgroup because
   some newsgroups are moderated or are digests, and therefore cannot be
   posted to; that is, articles posted to them must be mailed to a
   moderator who will post them for the submitter.  This is independent
   of the posting permission granted to a client by the NNTP server.

   Please note that an empty list (i.e., the text body returned by this
   command consists only of the terminating period) is a possible valid
   response, and indicates that there are currently no valid newsgroups.

3.6.2.  Responses

   215 list of newsgroups follows
*)
procedure TIdNNTPServer.CommandList(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      ASender.SendReply;
      DoListGroups(TIdNNTPContext(ASender.Context));
      ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
    end;
  end;
end;

(*
7.6.1 LIST ACTIVE

7.6.1.1 Usage

   Syntax
      LIST ACTIVE [wildmat]

   Responses
      215   Information follows (multiline)

   Parameters
      wildmat = groups of interest


7.6.1.2 Description

   The LIST ACTIVE command with no arguments returns a list of valid
   newsgroups and associated information. The server MUST include every
   group that the client is permitted to select with the GROUP (Section
   6.1.1) command. Each newsgroup is sent as a line of text in the
   following format:

   group high low status

   where:

   "group" is the name of the newsgroup;

   "high" is the reported high water mark for the group;

   "low" is the reported low water mark for the group;

   "status" is the current status of the group on this server.

   Each field in the line is separated from its neighboring fields by
   one or more spaces. Note that an empty list is a possible valid
   response, and indicates that there are currently no valid newsgroups.

   The reported high and low water marks are as described in the GROUP
   command (see Section 6.1.1).

   The status field is typically one of:

   "y" posting is permitted

   "n" posting is not permitted

   "m" postings will be forwarded to the newsgroup moderator

   The server SHOULD use these values when these meanings are required
   and MUST NOT use them with any other meaning. Other values for the
   status may exist; the definition of these other values and the
   circumstances under which they are returned may be specified in an
   extension or may be private to the server. A client SHOULD treat an
   unrecognised status as giving no information.

   The status of a newsgroup only indicates how posts to that newsgroup
   are normally processed and is not necessarily customised to the
   specific client. For example, if the current client is forbidden from
   posting, then this will apply equally to groups with status "y".
   Conversely, a client with special privileges (not defined by this
   specification) might be able to post to a group with status "n".

   If the optional wildmat argument is specified, the response is
   limited to only the groups (if any) whose names match the wildmat. If
   no wildmat is specified, the keyword ACTIVE MAY be omitted without
   altering the effect of the command.
*)
procedure TIdNNTPServer.CommandListActiveGroups(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnListActiveGroups) then begin
        ASender.SendReply;
        FOnListActiveGroups(TIdNNTPContext(ASender.Context), ASender.UnparsedParams);
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

(*
7.6.2 LIST ACTIVE.TIMES

7.6.2.1 Usage

   This command is optional.

   Syntax
      LIST ACTIVE.TIMES [wildmat]

   Responses
      215   Information follows (multiline)

   Parameters
      wildmat = groups of interest


7.6.2.2 Description

   The active.times list is maintained by some news transport systems to
   contain information about who created a particular newsgroup and
   when. Each line of this list consists of three fields separated from
   each other by one or more spaces. The first field is the name of the
   newsgroup. The second is the time when this group was created on this
   news server, measured in seconds since the start of January 1, 1970.
   The third is plain text intended to describe the entity that created
   the newsgroup; it is often a mailbox as defined in RFC 2822
   [RFC2822].

   The list MAY omit newsgroups for which the information is unavailable
   and MAY include groups not available on the server; in particular, it
   MAY omit all groups created before the date and time of the oldest
   entry. The client MUST NOT assume that the list is complete or that
   it matches the list returned by LIST ACTIVE. The NEWGROUPS command
   (Section 7.3) may provide a better way to access this information and
   the results of the two commands SHOULD be consistent (subject to the
   caveats in the description of that command).

   If the information is available, it is returned as a multi-line
   response following the 215 response code.

   If the optional wildmat argument is specified, the response is
   limited to only the groups (if any) whose names match the wildmat and
   for which the information is available. Note that an empty list is a
   possible valid response (whether or not a wildmat is specified) and
   indicates that there are no such groups.

2.1.3.1 Responses

      215 information follows
      503 program error, function not performed
*)
procedure TIdNNTPServer.CommandListActiveTimes(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnListActiveGroupTimes) then begin
        ASender.SendReply;
        FOnListActiveGroupTimes(TIdNNTPContext(ASender.Context), ASender.UnparsedParams);
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 503;
      end;
    end;
  end;
end;

(*
2. Newsreader Extensions

2.1.6 LIST NEWSGROUPS

   LIST NEWSGROUPS [wildmat]

   The newsgroups file is maintained by some news transport systems to
   contain the name of each news group which is active on the server and
   a short description about the purpose of each news group.  Each line
   in the file contains two fields, the news group name and a short
   explanation of the purpose of that news group.  When executed, the
   information is displayed following the 215 response.  When display is
   completed, the server will send a period on a line by itself.  If the
   information is not available, the server will return the 503
   response.  If the optional matching parameter is specified, the list
   is limited to only the groups that match the pattern (no matching is
   done on the group descriptions).  Specifying a single group is
   usually very efficient for the server, and multiple groups may be
   specified by using wildmat patterns (similar to file globbing), not
   regular expressions.  If nothing is matched an empty list is
   returned, not an error.

   When the optional parameter is specified, this command is equivalent
   to the XGTITLE command, though the response code are different.

      215 information follows
      503 program error, function not performed
*)
procedure TIdNNTPServer.CommandListDescriptions(ASender: TidCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnListDescriptions) then begin
        ASender.SendReply;
        FOnListDescriptions(TIdNNTPContext(ASender.Context), ASender.UnparsedParams);
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 503;
      end;
    end;
  end;
end;

(*
2. Newsreader Extensions

2.1.4 LIST DISTRIBUTIONS

   LIST DISTRIBUTIONS

   The distributions file is maintained by some news transport systems
   to contain information about valid values for the Distribution: line
   in a news article header and about what the values mean.  Each line
   contains two fields, the value and a short explanation on the meaning
   of the value.  When executed, the information is displayed following
   the 215 response.  When display is completed, the server will send a
   period on a line by itself.  If the information is not available, the
   server will return the 503 error response.  This command first
   appeared in the UNIX reference version.

2.1.4.1 Responses

      215 information follows
      503 program error, function not performed
*)
procedure TIdNNTPServer.CommandListDistributions(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnListDistributions) then begin
        ASender.SendReply;
        FOnListDistributions(TIdNNTPContext(ASender.Context));
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 503;
      end;
    end;
  end;
end;

(*
7.6.4 LIST DISTRIB.PATS

7.6.4.1 Usage

   This command is optional.

   Syntax
      LIST DISTRIB.PATS

   Responses
      215   Information follows (multiline)


7.6.4.2 Description

   The distrib.pats list is maintained by some news transport systems to
   choose a value for the content of the Distribution header of a news
   article being posted. Each line of this list consists of three fields
   separated from each other by a colon (":"). The first field is a
   weight, the second field is a wildmat (which may be a simple group
   name), and the third field is a value for the Distribution header
   content.

   The client MAY use this information to construct an appropriate
   Distribution header given the name of a newsgroup. To do so, it
   should determine the lines whose second field matches the newsgroup
   name, select from among them the line with the highest weight (with 0
   being the lowest), and use the value of the third field to construct
   the Distribution header.

   If the information is available, it is returned as a multi-line
   response following the 215 response code.
*)
procedure TIdNNTPServer.CommandListDistribPats(ASender: TIdCommand);
begin
  if DistributionPatterns.Count > 0 then begin
    ASender.Reply.SetReply(215, 'information follows'); {do not localize}
    ASender.Response.Assign(DistributionPatterns);
  end else begin
    ASender.Reply.NumericCode := 503;
  end;
end;

(*
6.1 LIST EXTENSIONS

6.1.1 Usage

   This command is optional.

   This command MUST NOT be pipelined.

   Syntax
      LIST EXTENSIONS

   Responses
      202   Extension list follows (multiline)
      402   Server has no extensions
      503   Extension information not available


6.1.2 Description

   The LIST EXTENSIONS command allows a client to determine which
   extensions are supported by the server.  This command MUST be
   implemented by any server that implements any extensions defined in
   this document.

   To discover what extensions are available, an NNTP client SHOULD
   query the server early in the session for extensions information by
   issuing the LIST EXTENSIONS command.  This command MAY be issued at
   anytime during a session.  It is not required that the client issues
   this command before attempting to make use of any extension.  The
   response generated by this command MAY change during a session
   because of other state information.  However, an NNTP client MUST NOT
   cache (for use in another session) any information returned if the
   LIST EXTENSIONS command succeeds.  That is, an NNTP client is only
   able to get the current and correct information concerning available
   extensions during a session by issuing a LIST EXTENSIONS command
   during that session and processing that response.

   The list of extensions is returned as a multi-line response following
   the 202 response code.  Each extension is listed on a separate line;
   the line MUST begin with an extension-label and optionally one or
   more parameters (separated by single spaces).  The extension-label
   and the meaning of the parameters are specified as part of the
   definition of the extension.  The extension-label MUST be in
   uppercase.

   The server MUST NOT list the same extension twice in the response,
   and MUST list all supported extensions.  The order in which the
   extensions are listed is not significant.  The server need not even
   consistently return the same order.  If the server does not support
   any extensions, a 402 response SHOULD be returned, but it MAY instead
   return an empty list.

   Following a 503 response an extension might still be available, and
   the client MAY attempt to use it.
*)
procedure TIdNNTPServer.CommandListExtensions(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(202, 'Extensions supported:'); {do not localize}
  ASender.SendReply;
  if TIdNNTPContext(ASender.Context).CanUseExplicitTLS then begin
    ASender.Context.Connection.IOHandler.WriteLn(' STARTTLS');  {do not localize}
  end;
  if Assigned(FOnXHdr) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' HDR');  {do not localize}
  end;
  if Assigned(FOnXOver) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' OVER');  {do not localize}
  end;
  if Assigned(FOnXROver) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' XROVER');  {do not localize}
  end;
  if Assigned(FOnXPat) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' XPAT');  {do not localize}
  end;
  if Assigned(FOnCheckListGroup) and Assigned(FOnListGroup) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LISTGROUP'); {do not localize}
  end;
  if Assigned(FOnListActiveGroups) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST ACTIVE'); {do not localize}
  end;
  if Assigned(FOnListActiveGroupTimes) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST ACTIVE.TIMES'); {do not localize}
  end;
  if Assigned(FOnListDistributions) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST DISTRIBUTIONS'); {do not localize}
  end;
  if DistributionPatterns.Count > 0 then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST DISTRIB.PATS'); {do not localize}
  end;
  if Assigned(FOnListHeaders) or (OverviewFormat.Count > 0) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST HEADERS'); {do not localize}
  end;
  if Assigned(FOnListDescriptions) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST NEWSGROUPS'); {do not localize}
  end;
  if Assigned(FOnListSubscriptions) then begin
    ASender.Context.Connection.IOHandler.WriteLn(' LIST SUBSCRIPTIONS'); {do not localize}
  end;
  if Assigned(FOnListExtensions) then begin
    FOnListExtensions(TIdNNTPContext(ASender.Context));
  end;
  ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
end;

procedure TIdNNTPServer.CommandListGroup(ASender: TIdCommand);
var
  LContext : TIdNNTPContext;
  LGroup : String;
  LFirstIdx : Int64;
  LCanJoin : Boolean;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnCheckListGroup) and Assigned(FOnListGroup) then begin
        LContext := TIdNNTPContext(ASender.Context);
        LGroup := Trim(ASender.UnparsedParams);
        if Length(LGroup) = 0 then begin
          LGroup := LContext.CurrentGroup;
        end;
        LCanJoin := False;
        if Length(LGroup) > 0 then begin
          FOnCheckListGroup(LContext, LGroup, LCanJoin, LFirstIdx);
        end;
        if LCanJoin then begin
          LContext.FCurrentGroup := LGroup;
          LContext.FCurrentArticle := LFirstIdx;
          ASender.SendReply;
          FOnListGroup(LContext);
          LContext.Connection.IOHandler.WriteLn('.');  {do not localize}
        end else begin
          ASender.Reply.NumericCode := 412;
        end;
      end else begin
        ASender.Reply.NumericCode := 502;
      end;
    end;
  end;
end;

(*
8.6.2 LIST HEADERS

8.6.2.1 Usage

   Syntax
      LIST HEADERS

   Responses
      215   Header and metadata list follows (multiline)


8.6.2.2 Description

   The LIST HEADERS command returns a list of headers and metadata items
   that may be retrieved using the HDR command.

   The information is returned as a multi-line response following the
   215 response code and contains one line for each header or metadata
   item name (excluding the colon in the former case). If the
   implementation allows any header to be retrieved (also indicated by
   the "ALL" argument to the extension label) it MUST NOT include any
   header names in the list but MUST include the special entry ":" (a
   single colon on its own); it MUST still list any metadata items that
   are available. The order of items in the list is not significant; the
   server need not even consistently return the same order. The list MAY
   be empty (though in this circumstance there is little point in
   providing the extension).

   An implementation that also supports the OVER extension SHOULD at
   least permit all the headers and metadata items listed in the output
   from the LIST OVERVIEW.FMT command.

8.6.2.3 Examples

   Example of an implementation providing access to only a few headers:

      [C] LIST EXTENSIONS
      [S] 202 extensions supported:
      [S] HDR
      [S] .
      [C] LIST HEADERS
      [S] 215 headers supported:
      [S] Subject
      [S] Message-ID
      [S] Xref
      [S] .

   Example of an implementation providing access to the same fields as
   the first example in Section 8.5.2.3:

      [C] LIST EXTENSIONS
      [S] 202 extensions supported:
      [S] OVER
      [S] HDR
      [S] .
      [C] LIST HEADERS
      [S] 215 headers and metadata items supported:
      [S] Date
      [S] Distribution
      [S] From
      [S] Message-ID
      [S] References
      [S] Subject
      [S] Xref
      [S] :bytes
      [S] :lines
      [S] .

   Example of an implementation providing access to all headers:

      [C] LIST EXTENSIONS
      [S] 202 extensions supported:
      [S] HDR ALL
      [S] .
      [C] LIST HEADERS
      [S] 215 metadata items supported:
      [S] :
      [S] :lines
      [S] :bytes
      [S] :x-article-number
      [S] .

*)
procedure TIdNNTPServer.CommandListHeaders(ASender: TIdCommand);
begin
  if Assigned(FOnListHeaders) or (OverviewFormat.Count > 0) then begin
    ASender.Reply.SetReply(215, 'Headers and metadata items supported:'); {do not localize}
    if Assigned(FOnListHeaders) then begin
      ASender.SendReply;
      FOnListHeaders(TIdNNTPContext(ASender.Context));
      ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
    end else begin
      ASender.Response.Assign(OverviewFormat);
    end;
  end else begin
    ASender.Reply.NumericCode := 500;
  end;
end;

(*
2. Newsreader Extensions

2.1.7 LIST OVERVIEW.FMT

   LIST OVERVIEW.FMT

   The overview.fmt file is maintained by some news transport systems to
   contain the order in which header information is stored in the
   overview databases for each news group.  When executed, news article
   header fields are displayed one line at a time in the order in which
   they are stored in the overview database [5] following the 215
   response.  When display is completed, the server will send a period
   on a line by itself.  If the information is not available, the server
   will return the 503 response.

   Please note that if the header has the word "full" (without quotes)
   after the colon, the header's name is prepended to its field in the
   output returned by the server.

   Many newsreaders work better if Xref: is one of the optional fields.

   It is STRONGLY recommended that this command be implemented in any
   server that implements the XOVER command.  See section 2.8 for more
   details about the XOVER command.

2.1.7.1 Responses

      215 information follows
      503 program error, function not performed
*)
procedure TIdNNTPServer.CommandListOverview(ASender: TIdCommand);
begin
  if OverviewFormat.Count > 0 then begin
    ASender.Reply.SetReply(215, 'information follows');  {do not localize}
    ASender.Response.Assign(OverviewFormat);
  end else begin
    ASender.Reply.NumericCode := 503;
  end;
end;

(*
2. Newsreader Extensions

2.1.8 LIST SUBSCRIPTIONS

   LIST SUBSCRIPTIONS

   This command is used to get a default subscription list for new users
   of this server.  The order of groups is significant.

   When this list is available, it is preceded by the 215 response and
   followed by a period on a line by itself.  When this list is not
   available, the server returns a 503 response code.

2.1.8.1 Responses

      215 information follows
      503 program error, function not performed

*)
procedure TIdNNTPServer.CommandListSubscriptions(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnListSubscriptions) then begin
        ASender.Reply.SetReply(215, 'information follows');  {do not localize}
        ASender.SendReply;
        FOnListSubscriptions(TIdNNTPContext(ASender.Context));
        ASender.Context.Connection.IOHandler.WriteLn('.');
      end else begin
        ASender.Reply.NumericCode := 503;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandModeReader(ASender: TIdCommand);
(*
2.3 MODE READER

   MODE READER is used by the client to indicate to the server that it
   is a news reading client.  Some implementations make use of this
   information to reconfigure themselves for better performance in
   responding to news reader commands.  This command can be contrasted
   with the SLAVE command in RFC 977, which was not widely implemented.
   MODE READER was first available in INN.

2.3.1 Responses

      200 Hello, you can post
      201 Hello, you can't post
*)
begin
  if not SecLayerRequired(ASender) then begin
    TIdNNTPContext(ASender.Context).FModeReader := True;
    ASender.Reply.NumericCode := 200;
  end;
end;

(*
3.7.  The NEWGROUPS command

3.7.1.  NEWGROUPS

   NEWGROUPS date time [GMT] [<distributions>]

   A list of newsgroups created since <date and time> will be listed in
   the same format as the LIST command.

   The date is sent as 6 digits in the format YYMMDD, where YY is the
   last two digits of the year, MM is the two digits of the month (with
   leading zero, if appropriate), and DD is the day of the month (with
   leading zero, if appropriate).  The closest century is assumed as
   part of the year (i.e., 86 specifies 1986, 30 specifies 2030, 99 is
   1999, 00 is 2000).

   Time must also be specified.  It must be as 6 digits HHMMSS with HH
   being hours on the 24-hour clock, MM minutes 00-59, and SS seconds
   00-59.  The time is assumed to be in the server's timezone unless the
   token "GMT" appears, in which case both time and date are evaluated
   at the 0 meridian.

   The optional parameter "distributions" is a list of distribution
   groups, enclosed in angle brackets.  If specified, the distribution
   portion of a new newsgroup (e.g, 'net' in 'net.wombat') will be
   examined for a match with the distribution categories listed, and
   only those new newsgroups which match will be listed.  If more than
   one distribution group is to be listed, they must be separated by
   commas within the angle brackets.

   Please note that an empty list (i.e., the text body returned by this
   command consists only of the terminating period) is a possible valid
   response, and indicates that there are currently no new newsgroups.

3.7.2.  Responses

   231 list of new newsgroups follows
*)
procedure TIdNNTPServer.CommandNewGroups(ASender: TIdCommand);
var
  LDate : TDateTime;
  LDist : String;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if (ASender.Params.Count > 1) and (Assigned(FOnListNewGroups)) then begin
        LDist := '';  {do not localize}
        LDate := NNTPDateTimeToDateTime(ASender.Params[0]);
        LDate := LDate + NNTPTimeToTime(ASender.Params[1]);
        if ASender.Params.Count > 2 then begin
          if TextIsSame(ASender.Params[2], 'GMT') then begin {Do not translate}
            LDate := UTCTimeToLocalTime(LDate);
            if ASender.Params.Count > 3 then begin
              LDist := ASender.Params[3];
            end;
          end else begin
            LDist := ASender.Params[2];
          end;
        end;
        ASender.SendReply;
        FOnListNewGroups(TIdNNTPContext(ASender.Context), LDate, LDist);
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandNewNews(ASender: TIdCommand);
var
  LDate : TDateTime;
  LDist : String;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if (ASender.Params.Count > 2) and Assigned(FOnNewNews) then begin
        //0 - newsgroup
        //1 - date
        //2 - time
        //3 - GMT or distributions
        //4 - distributions if 3 was GMT
        LDist := '';  {do not localize}
        LDate := NNTPDateTimeToDateTime(ASender.Params[1]);
        LDate := LDate + NNTPTimeToTime(ASender.Params[2]);
        if ASender.Params.Count > 3 then begin
          if TextIsSame(ASender.Params[3], 'GMT') then begin {Do not translate}
            LDate := UTCTimeToLocalTime(LDate);
            if ASender.Params.Count > 4 then begin
              LDist := ASender.Params[4];
            end;
          end else begin
            LDist := ASender.Params[3];
          end;
        end;
        ASender.SendReply;
        FOnNewNews(TIdNNTPContext(ASender.Context), ASender.Params[0], LDate, LDist);
        ASender.Context.Connection.IOHandler.WriteLn('.');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandNext(ASender: TIdCommand);
var
  LMsgNo: Int64;
  LContext: TIdNNTPContext;
  LMsgID : String;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnNextArticle) then begin
        LContext := TIdNNTPContext(ASender.Context);
        //we do this in a round about way in case there is no previous article at all
        LMsgNo := LContext.CurrentArticle;
        LMsgID := RawNavigate(LContext, FOnNextArticle);
        if LMsgID <> '' then begin  {do not localize}
          ASender.Reply.SetReply(223, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - request text separately'); {do not localize}
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
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
procedure TIdNNTPServer.CommandPost(ASender: TIdCommand);
var
  LCanPost: Boolean;
  LErrorText: string;
  LPostOk: Boolean;
  LReply: TIdReplyRFC;
  LContext : TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      LContext := TIdNNTPContext(ASender.Context);
      LCanPost := Assigned(FOnPost);
      LReply := TIdReplyRFC.Create(nil);
      try
        LReply.NumericCode := iif(LCanPost, 340, 440);
        ReplyTexts.UpdateText(LReply);
        LContext.Connection.IOHandler.Write(LReply.FormattedReply);
      finally
        FreeAndNil(LReply);
      end;
      if LCanPost then begin
        LPostOk := False;
        LErrorText := '';  {do not localize}
        FOnPost(LContext, LPostOk, LErrorText);
        ASender.Reply.SetReply(iif(LPostOk, 240, 441), LErrorText);
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandSlave(ASender: TIdCommand);
begin
  if not SecLayerRequired(ASender) then begin
    TIdNNTPContext(ASender.Context).FModeReader := False;
    ASender.Reply.NumericCode := 220;
  end;
end;

procedure TIdNNTPServer.CommandStat(ASender: TIdCommand);
var
  LMsgID: string;
  LMsgNo: Int64;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      case LookupMessage(ASender, LMsgNo, LMsgID) of
        ltLookupByMsgId: begin
          if Assigned(FOnStatMsgId) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - statistics only');  {do not localize}
            ASender.SendReply;
            FOnStatMsgId(TIdNNTPContext(ASender.Context), LMsgID);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        ltLookupByMsgNo: begin
          if Assigned(FOnStatMsgNo) then begin
            ASender.Reply.SetReply(220, IntToStr(LMsgNo) + ' ' + LMsgID + ' article retrieved - statistics only');  {do not localize}
            ASender.SendReply;
            FOnStatMsgNo(TIdNNTPContext(ASender.Context), LMsgNo);
          end else begin
            ASender.Reply.NumericCode := 500;
          end;
        end;
        // ltLookupError is already handled inside of LookupMessage()
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandXHdr(ASender: TIdCommand);
var
  s: String;
  LFirstMsg: Int64;
  LLastMsg: Int64;
  LMsgID: String;
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnXHdr) then begin
        if ASender.Params.Count > 0 then begin
          if ASender.Params.Count > 1 then begin
            s := ASender.Params[1];
          end;
          if LookupMessageRangeOrID(ASender, s, LFirstMsg, LLastMsg, LMsgID) then begin
            LContext := TIdNNTPContext(ASender.Context);
            //Note there is an inconstancy here.
            //RFC 2980 says XHDR should return 221
            //http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-17.txt
            //says that HDR should return 225
            //just return the default numeric success reply.
            ASender.SendReply;
            // No need for DoOnXhdr - only this proc can call it and it already checks for nil
            FOnXhdr(LContext, ASender.Params[0], LFirstMsg, LLastMsg, LMsgID);
            LContext.Connection.IOHandler.WriteLn('.');  {do not localize}
          end;
        end else begin
          ASender.Reply.NumericCode := 501;
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

(*
2.8 XOVER

   XOVER [range]

   The XOVER command returns information from the overview database for
   the article(s) specified.  This command was originally suggested as
   part of the OVERVIEW work described in "The Design of a Common
   Newsgroup Overview Database for Newsreaders" by Geoff Collyer.  This
   document is distributed in the Cnews distribution.  The optional
   range argument may be any of the following:

               an article number
               an article number followed by a dash to indicate
                  all following
               an article number followed by a dash followed by
                  another article number

   If no argument is specified, then information from the current
   article is displayed.  Successful responses start with a 224 response
   followed by the overview information for all matched messages.  Once
   the output is complete, a period is sent on a line by itself.  If no
   argument is specified, the information for the current article is
   returned.  A news group must have been selected earlier, else a 412
   error response is returned.  If no articles are in the range
   specified, a 420 error response is returned by the server.  A 502
   response will be returned if the client only has permission to
   transfer articles.

   Each line of output will be formatted with the article number,
   followed by each of the headers in the overview database or the
   article itself (when the data is not available in the overview
   database) for that article separated by a tab character.  The
   sequence of fields must be in this order: subject, author, date,
   message-id, references, byte count, and line count.  Other optional
   fields may follow line count.  Other optional fields may follow line
   count.  These fields are specified by examining the response to the
   LIST OVERVIEW.FMT command.  Where no data exists, a null field must
   be provided (i.e. the output will have two tab characters adjacent to
   each other).  Servers should not output fields for articles that have
   been removed since the XOVER database was created.

   The LIST OVERVIEW.FMT command should be implemented if XOVER is
   implemented.  A client can use LIST OVERVIEW.FMT to determine what
   optional fields  and in which order all fields will be supplied by
   the XOVER command.  See Section 2.1.7 for more details about the LIST
   OVERVIEW.FMT command.

   Note that any tab and end-of-line characters in any header data that
   is returned will be converted to a space character.

2.8.1 Responses

      224 Overview information follows
      412 No news group current selected
      420 No article(s) selected
      502 no permission
*)
procedure TIdNNTPServer.CommandXOver(ASender: TIdCommand);
var
  LFirstMsg: Int64;
  LLastMsg: Int64;
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(OnXOver) then begin
        if LookupMessageRange(ASender, ASender.UnparsedParams, LFirstMsg, LLastMsg) then begin
          LContext := TIdNNTPContext(ASender.Context);
          ASender.Reply.NumericCode := 224;
          ASender.SendReply;
          FOnXOver(LContext, LFirstMsg, LLastMsg);
          LContext.Connection.IOHandler.WriteLn('.');  {do not localize}
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

(*
2.11 The XROVER command

   XROVER [range]

   The XROVER command returns reference information from the overview
   database for the article(s) specified.  This command first appeared
   in the Unix reference implementation.  The optional range argument
   may be any of the following:

               an article number
               an article number followed by a dash to indicate
                    all following
               an article number followed by a dash followed by
                   another article number

   Successful responses start with a 224 response followed by the
   contents of reference information for all matched messages.  Once the
   output is complete, a period is sent on a line by itself.  If no
   argument is specified, the information for the current article is
   returned.  A news group must have been selected earlier, else a 412
   error response is returned.  If no articles are in the range
   specified, a 420 error response is returned by the server.  A 502
   response will be returned if the client only has permission to
   transfer articles.

   The output will be formatted with the article number, followed by the
   contents of the References: line for that article, but does not
   contain the field name itself.

   This command provides the same basic functionality as using the XHDR
   command and "references" as the header argument.

2.11.1 Responses

      224 Overview information follows
      412 No news group current selected
      420 No article(s) selected
      502 no permission
*)
procedure TIdNNTPServer.CommandXROver(ASender: TIdCommand);
var
  LFirstMsg: Int64;
  LLastMsg: Int64;
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(FOnXROver) then begin
        if LookupMessageRange(ASender, ASender.UnparsedParams, LFirstMsg, LLastMsg) then begin
          LContext := TIdNNTPContext(ASender.Context);
          ASender.Reply.NumericCode := 224;
          ASender.SendReply;
          FOnXROver(LContext, LFirstMsg, LLastMsg);
          LContext.Connection.IOHandler.WriteLn('.');  {do not localize}
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

(*
2.9 XPAT

   XPAT header range|<message-id> pat [pat...]

   The XPAT command is used to retrieve specific headers from specific
   articles, based on pattern matching on the contents of the header.
   This command was first available in INN.

   The required header parameter is the name of a header line (e.g.
   "subject") in a news group article.  See RFC 1036 for a list of valid
   header lines.  The required range argument may be any of the
   following:

               an article number
               an article number followed by a dash to indicate
                  all following
               an article number followed by a dash followed by
                  another article number

   The required message-id argument indicates a specific article.  The
   range and message-id arguments are mutually exclusive.  At least one
   pattern in wildmat must be specified as well.  If there are
   additional arguments the are joined together separated by a single
   space to form one complete pattern.  Successful responses start with
   a 221 response followed by a the headers from all messages in which
   the pattern matched the contents of the specified header line.  This
   includes an empty list.  Once the output is complete, a period is
   sent on a line by itself.  If the optional argument is a message-id
   and no such article exists, the 430 error response is returned.  A
   502 response will be returned if the client only has permission to
   transfer articles.

2.9.1 Responses

      221 Header follows
      430 no such article
      502 no permission
*)
procedure TIdNNTPServer.CommandXPat(ASender: TIdCommand);
var
  i: Integer;
  LFirstMsg: Int64;
  LLastMsg: Int64;
  LMsgID: String;
  LPattern: string;
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if not AuthRequired(ASender) then begin
      if Assigned(OnXPat) then begin
        if ASender.Params.Count > 2 then begin
          if LookupMessageRangeOrID(ASender, ASender.Params[1], LFirstMsg, LLastMsg, LMsgID) then begin
            LContext := TIdNNTPContext(ASender.Context);
            LPattern := ASender.Params[2];
            for i := 3 to (ASender.Params.Count-1) do begin
              LPattern := LPattern + ' ' + ASender.Params[i];  {do not localize}
            end;
            ASender.Reply.SetReply(221, 'Header follows');  {do not localize}
            ASender.SendReply;
            FOnXPat(LContext, ASender.Params[0], LFirstMsg, LLastMsg, LMsgID, LPattern);
            LContext.Connection.IOHandler.WriteLn('.');  {do not localize}
          end;
        end else begin
          ASender.Reply.NumericCode := 501;
        end;
      end else begin
        ASender.Reply.NumericCode := 500;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.InitComponent;
begin
  inherited InitComponent;

  FDistributionPatterns := TStringList.Create;
  FHelp := TStringList.Create;

  FOverviewFormat := TStringList.Create;
  FOverviewFormat.Add('Subject:');      {do not localize}
  FOverviewFormat.Add('From:');         {do not localize}
  FOverviewFormat.Add('Date:');         {do not localize}
  FOverviewFormat.Add('Message-ID:');   {do not localize}
  FOverviewFormat.Add('References:');   {do not localize}
  FOverviewFormat.Add('Bytes:');        {do not localize}
  FOverviewFormat.Add('Lines:');        {do not localize}

  FContextClass := TIdNNTPContext;
  FRegularProtPort := IdPORT_NNTP;
  FImplicitTLSProtPort := IdPORT_SNEWS;
  FExplicitTLSProtPort := IdPORT_NNTP;
  DefaultPort := IdPORT_NNTP;

  FSupportedAuthTypes := [atUserPass];

  (*
  In general, 1xx codes may be ignored or displayed as desired;
  code 200 or 201 is sent upon initial connection to the NNTP server
  depending upon posting permission;  *)
  // TODO: Account for 201 as well. Right now the user can override this if they wish
  Greeting.NumericCode := 200;
  //

  ExceptionReply.SetReply(503, RSNNTPReplyProgramFault);
  ReplyUnknownCommand.SetReply(500, RSNNTPServerNotRecognized);
end;

destructor TIdNNTPServer.Destroy;
begin
  FreeAndNil(FDistributionPatterns);
  FreeAndNil(FHelp);
  FreeAndNil(FOverviewFormat);
  inherited Destroy;
end;

procedure TIdNNTPServer.DoListGroups(AContext: TIdNNTPContext);
begin
  if Assigned(FOnListGroups) then begin
    FOnListGroups(AContext);
  end;
end;

procedure TIdNNTPServer.DoSelectGroup(AContext: TIdNNTPContext; const AGroup: string;
  var VMsgCount, VMsgFirst, VMsgLast: Int64; var VGroupExists: Boolean);
begin
  VMsgCount := 0;
  VMsgFirst := 0;
  VMsgLast := 0;
  VGroupExists := False;
  if Assigned(FOnSelectGroup) then begin
    FOnSelectGroup(AContext, AGroup, VMsgCount, VMsgFirst, VMsgLast, VGroupExists);
  end;
end;

function TIdNNTPServer.GetImplicitTLS: Boolean;
begin
  Result := UseTLS = utUseImplicitTLS;
end;

procedure TIdNNTPServer.SetImplicitTLS(const AValue: Boolean);
begin
  if AValue <> ImplicitTLS then begin
    if AValue then begin
      UseTLS := utUseImplicitTLS;
    end
    else if IOHandler is TIdServerIOHandlerSSLBase then begin
      UseTLS := utUseExplicitTLS;
    end else begin
      UseTLS := utNoTLSSupport;
    end;
  end;
end;

procedure TIdNNTPServer.CommandSTARTTLS(ASender: TIdCommand);
var
  LContext: TIdNNTPContext;
begin
  LContext := TIdNNTPContext(ASender.Context);
  if LContext.CanUseExplicitTLS then begin
    if not LContext.UsingTLS then begin
      ASender.Reply.NumericCode := 382;
      ASender.SendReply;
      (LContext.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
      //reset the connection state as required by http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt
      LContext.FUserName := '';  {do not localize}
      LContext.FPassword := '';  {do not localize}
      LContext.FAuthenticated := False;
      LContext.FAuthenticator := '';  {do not localize}
      LContext.FAuthParams := '';  {do not localize}
      LContext.FAuthType := atUserPass;
      LContext.FModeReader := False;
      LContext.Connection.IOHandler.Write(ReplyUnknownCommand.FormattedReply);
    end else begin
      ASender.Reply.NumericCode := 580;
    end;
  end else begin
    ASender.Reply.NumericCode := 500;
  end;
end;

procedure TIdNNTPServer.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  inherited InitializeCommandHandlers;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'ARTICLE'; {do not localize}
  LCommandHandler.OnCommand := CommandArticle;
  LCommandHandler.NormalReply.NumericCode := 500;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTHINFO USER'; {do not localize}
  LCommandHandler.OnCommand := CommandAuthInfoUser;
  LCommandHandler.NormalReply.NumericCode := 502;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTHINFO PASS'; {do not localize}
  LCommandHandler.OnCommand := CommandAuthInfoPassword;
  LCommandHandler.NormalReply.NumericCode := 502;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTHINFO SIMPLE'; {do not localize}
  LCommandHandler.OnCommand := CommandAuthInfoSimple;
  LCommandHandler.NormalReply.NumericCode := 350;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTHINFO GENERIC';  {do not localize}
  LCommandHandler.OnCommand := CommandAuthInfoGeneric;
  LCommandHandler.NormalReply.NumericCode := 501;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'BODY';  {do not localize}
  LCommandHandler.OnCommand := CommandBody;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'DATE';  {do not localize}
  LCommandHandler.OnCommand := CommandDate;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'HEAD';  {do not localize}
  LCommandHandler.OnCommand := CommandHead;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'HELP';  {do not localize}
  LCommandHandler.OnCommand := CommandHelp;
  LCommandHandler.NormalReply.NumericCode := 100;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'GROUP'; {do not localize}
  LCommandHandler.OnCommand := CommandGroup;
  LCommandHandler.NormalReply.NumericCode := 411;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'IHAVE'; {do not localize}
  LCommandHandler.OnCommand := CommandIHave;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LAST';  {do not localize}
  LCommandHandler.OnCommand := CommandLast;
  LCommandHandler.ParseParams := False;

  // Before LIST
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST Overview.fmt'; {do not localize}
  LCommandHandler.OnCommand := CommandListOverview;
  LCommandHandler.ParseParams := False;

  // Before LIST
  //TODO: This needs implemented as events to allow return data
  // RFC 2980 - NNTP Extension
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST NEWSGROUPS'; {do not localize}
  //LCommandHandler.ReplyNormal.NumericCode := 503;
  LCommandHandler.NormalReply.NumericCode := 215;
  LCommandHandler.Response.Add('.');
  LCommandHandler.ParseParams := False;

  {
  From: http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-17.txt
  }
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST EXTENSIONS'; {do not localize}
  LCommandHandler.OnCommand := CommandListExtensions;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LIST';  {do not localize}
  LCommandHandler.OnCommand := CommandList;
  LCommandHandler.NormalReply.NumericCode := 215;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'LISTGROUP'; {do not localize}
  LCommandHandler.OnCommand := CommandListGroup;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'MODE READER'; {do not localize}
  LCommandHandler.OnCommand := CommandModeReader;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NEWGROUPS'; {do not localize}
  LCommandHandler.OnCommand := CommandNewGroups;
  LCommandHandler.NormalReply.NumericCode := 231;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NEWNEWS'; {do not localize}
  LCommandHandler.OnCommand := CommandNewNews;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'NEXT';  {do not localize}
  LCommandHandler.OnCommand := CommandNext;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'POST';  {do not localize}
  LCommandHandler.OnCommand := CommandPost;
  LCommandHandler.ParseParams := False;

  (*
  3.11.  The QUIT command

  3.11.1.  QUIT

     QUIT

     The server process acknowledges the QUIT command and then closes the
     connection to the client.  This is the preferred method for a client
     to indicate that it has finished all its transactions with the NNTP
     server.

     If a client simply disconnects (or the connection times out, or some
     other fault occurs), the server should gracefully cease its attempts
     to service the client.

  3.11.2.  Responses

     205 closing connection - goodbye!
  *)
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'QUIT';  {do not localize}
  LCommandHandler.Disconnect := True;
  LCommandHandler.NormalReply.NumericCode := 205;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SLAVE'; {do not localize}
  LCommandHandler.OnCommand := CommandSlave;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STAT';  {do not localize}
  LCommandHandler.OnCommand := CommandStat;
  LCommandHandler.ParseParams := False;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'XHDR';  {do not localize}
  LCommandHandler.OnCommand := CommandXHdr;
  LCommandHandler.ParseParams := True;
  LCommandHandler.NormalReply.NumericCode := 221;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'HDR'; {do not localize}
  LCommandHandler.OnCommand := CommandXHdr;
  LCommandHandler.ParseParams := True;
  LCommandHandler.NormalReply.NumericCode := 225;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'XOVER'; {do not localize}
  LCommandHandler.OnCommand := CommandXOver;
  LCommandHandler.NormalReply.NumericCode := 224;
  LCommandHandler.ParseParams := False;

  //from http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'OVER';  {do not localize}
  LCommandHandler.OnCommand := CommandXOver;
  LCommandHandler.NormalReply.NumericCode := 224;
  LCommandHandler.ParseParams := False;

  // RFC 2980 - NNTP Extensions
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'XROVER';
  LCommandHandler.OnCommand := CommandXROver;
  LCommandHandler.NormalReply.NumericCode := 500;
  LCommandHandler.ParseParams := False;

  // RFC 2980 - NNTP Extensions
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'XPAT';  {do not localize}
  LCommandHandler.OnCommand := CommandXPat;
  LCommandHandler.NormalReply.NumericCode := 500;
  LCommandHandler.ParseParams := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STARTTLS';  {do not localize}
  LCommandHandler.OnCommand := CommandSTARTTLS;

  // 100s
  FReplyTexts.Add(100, 'help text follows');                                          {do not localize}
  FReplyTexts.Add(199, 'debug output');                                               {do not localize}

  // 200s
  FReplyTexts.Add(200, 'server ready - posting allowed');                             {do not localize}
  FReplyTexts.Add(201, 'server ready - no posting allowed');                          {do not localize}
  FReplyTexts.Add(202, 'slave status noted');                                         {do not localize}
  FReplyTexts.Add(205, 'closing connection - goodbye!');                              {do not localize}
  FReplyTexts.Add(215, 'list of newsgroups follows');                                 {do not localize}
  FReplyTexts.Add(221, 'Headers follow');                                             {do not localize}
  FReplyTexts.Add(224, 'Overview information follows');                               {do not localize}
  FReplyTexts.Add(225, 'Headers follow');                                             {do not localize}
  FReplyTexts.Add(231, 'list of new newsgroups follows');                             {do not localize}
  FReplyTexts.Add(235, 'article transferred ok');                                     {do not localize}
  FReplyTexts.Add(240, 'article posted ok');                                          {do not localize}
  FReplyTexts.Add(281,'Authentication accepted');                                     {do not localize}

  // 300s
  FReplyTexts.Add(335, 'send article to be transferred. End with <CR-LF>.<CR-LF>');   {do not localize}
  FReplyTexts.Add(340, 'send article to be posted. End with <CR-LF>.<CR-LF>');        {do not localize}
  FReplyTexts.Add(381, 'More authentication information required');                   {do not localize}
  FReplyTexts.Add(382,'Continue with TLS negotiation');                               {do not localize}

  // 400s
  FReplyTexts.Add(400, 'service discontinued');                                       {do not localize}
  FReplyTexts.Add(403, 'TLS temporarily not available');                              {do not localize}
  FReplyTexts.Add(411, 'no such news group');                                         {do not localize}
  FReplyTexts.Add(412, 'no newsgroup has been selected');                             {do not localize}
  FReplyTexts.Add(420, 'no current article has been selected');                       {do not localize}
  FReplyTexts.Add(421, 'no next article in this group');                              {do not localize}
  FReplyTexts.Add(422, 'no previous article in this group');                          {do not localize}
  FReplyTexts.Add(423, 'no such article number in this group');                       {do not localize}
  FReplyTexts.Add(430, 'no such article found');                                      {do not localize}
  FReplyTexts.Add(435, 'article not wanted - do not send it');                        {do not localize}
  FReplyTexts.Add(436, 'transfer failed - try again later');                          {do not localize}
  FReplyTexts.Add(437, 'article rejected - do not try again.');                       {do not localize}
  FReplyTexts.Add(440, 'posting not allowed');                                        {do not localize}
  FReplyTexts.Add(441, 'posting failed');                                             {do not localize}
  FReplyTexts.Add(450, 'Authorization required for this command');                    {do not localize}
  FReplyTexts.Add(452, 'Authorization rejected');                                     {do not localize}
  FReplyTexts.Add(480, 'Authentication required');                                    {do not localize}
  FReplyTexts.Add(482, 'Authentication rejected');                                    {do not localize}
  FReplyTexts.Add(483, 'Strong encryption layer is required');                        {do not localize}

  // 500s
  FReplyTexts.Add(500, 'command not recognized');                                     {do not localize}
  FReplyTexts.Add(501, 'command syntax error');                                       {do not localize}
  FReplyTexts.Add(502, 'access restriction or permission denied');                    {do not localize}
  FReplyTexts.Add(503, 'program fault - command not performed');                      {do not localize}
  FReplyTexts.Add(580, 'Security layer already active');                              {do not localize}
end;

function TIdNNTPServer.AuthRequired(ASender: TIdCommand): Boolean;
var
  LContext: TIdNNTPContext;
begin
  LContext := TIdNNTPContext(ASender.Context);
  Result := (FSupportedAuthTypes <> []) and Assigned(FOnAuth) and (not LContext.Authenticated);
  if Result then begin
    if Assigned(FOnAuthRequired) then begin
      FOnAuthRequired(LContext, ASender.CommandHandler.Command, ASender.UnparsedParams, Result);
    end;
    if Result then begin
      { RLebeau - AUTHINFO SIMPLE is discouraged by RFC 2980, but it
      is not completely obsolete, so if the user really wants to use
      just it and no other, then do so here.  If any other auth type
      is begin supported though, always use another one instead }
      if (FSupportedAuthTypes = [atSimple]) then begin
        ASender.Reply.NumericCode := 450;
      end else begin
        ASender.Reply.NumericCode := 480;
      end;
    end;
  end;
end;

function TIdNNTPServer.DoCheckMsgID(AContext: TIdNNTPContext; const AMsgID: String): Int64;
begin
  Result := 0;
  if Assigned(FOnCheckMsgId) then begin
    FOnCheckMsgId(AContext, AMsgID, Result);
  end;
end;

function TIdNNTPServer.DoCheckMsgNo(AContext: TIdNNTPContext; const AMsgNo: Int64): String;
begin
  Result := '';
  if Assigned(FOnCheckMsgNo) then begin
    FOnCheckMsgNo(AContext, AMsgNo, Result);
  end;
end;

function TIdNNTPServer.RawNavigate(AContext: TIdNNTPContext; AEvent: TIdNNTPOnMovePointer): String;
var
  LMsgNo : Int64;
begin
  Result := '';
  LMsgNo := AContext.CurrentArticle;
  if LMsgNo > 0 then begin
    if Assigned(AEvent) then begin
      AEvent(AContext, LMsgNo, Result);
    end;
    if (LMsgNo <> AContext.CurrentArticle) and (LMsgNo > 0) and (Result <> '') then begin  {do not localize}
      AContext.FCurrentArticle := LMsgNo;
    end;
  end;
end;

procedure TIdNNTPServer.SetHelp(AValue: TStrings);
begin
  FHelp.Assign(AValue);
end;

procedure TIdNNTPServer.SetDistributionPatterns(AValue: TStrings);
begin
  FDistributionPatterns.Assign(AValue);
end;

{ TIdNNTPContext }

constructor TIdNNTPContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdContextThreadList = nil
  );
begin
  inherited Create(AConnection, AYarn, AList);
  FCurrentArticle := 0;
end;

procedure TIdNNTPContext.GenerateAuthEmail;
var
  LIP, LHost: String;
  LSocket: TIdIOHandlerSocket;
begin
  FAuthEmail := '';  {do not localize}
  if FUsername <> '' then begin  {do not localize}
    LSocket := Connection.Socket;
    if Assigned(LSocket) then begin
      if Assigned(LSocket.Binding) then begin
        LIP := LSocket.Binding.PeerIP;
        if LIP <> '' then begin  {do not localize}
          try
            LHost := GStack.HostByAddress(LIP, LSocket.Binding.IPVersion);
          except
            LHost := '';  {do not localize}
          end;
          if LHost = '' then begin  {do not localize}
            LHost := LIP;
          end;
          FAuthEmail := FUsername + '@' + LHost; {do not localize}
        end;
      end;
    end;
  end;
end;

function TIdNNTPContext.GetUsingTLS: Boolean;
begin
  Result := (Connection.IOHandler is TIdSSLIOHandlerSocketBase);
  if Result then begin
    Result := not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end;
end;

function TIdNNTPContext.GetCanUseExplicitTLS: Boolean;
begin
  Result := (Connection.IOHandler is TIdSSLIOHandlerSocketBase);
  if Result then begin
    Result := (TIdNNTPServer(Server).UseTLS in ExplicitTLSVals);
  end;
end;

function TIdNNTPContext.GetTLSIsRequired: Boolean;
begin
  Result := (TIdNNTPServer(Server).UseTLS = utUseRequireTLS);
  if Result then begin
    Result := not UsingTLS;
  end;
end;

procedure TIdNNTPServer.SetOverviewFormat(AValue: TStrings);
begin
  FOverviewFormat.Assign(AValue);
end;


(*
3.1 AUTHINFO

   AUTHINFO is used to inform a server about the identity of a user of
   the server.  In all cases, clients must provide this information when
   requested by the server.  Servers are not required to accept
   authentication information that is volunteered by the client.
   Clients must accommodate servers that reject any authentication
   information volunteered by the client.

   There are three forms of AUTHINFO in use.  The original version, an
   NNTP v2 revision called AUTHINFO SIMPLE and a more recent version
   which is called AUTHINFO GENERIC.

3.1.1 Original AUTHINFO

   AUTHINFO USER username
   AUTHINFO PASS password

   The original AUTHINFO is used to identify a specific entity to the
   server using a simple username/password combination.  It first
   appeared in the UNIX reference implementation.

   When authorization is required, the server will send a 480 response
   requesting authorization from the client.  The client must enter
   AUTHINFO USER followed by the username.  Once sent, the server will
   cache the username and may send a 381 response requesting the
   password associated with that username.  Should the server request a
   password using the 381 response, the client must enter AUTHINFO PASS
   followed by a password and the server will then check the
   authentication database to see if the username/password combination
   is valid.  If the combination is valid or if no password is required,
   the server will return a 281 response.  The client should then retry
   the original command to which the server responded with the 480
   response.  The command should then be processed by the server
   normally.  If the combination is not valid, the server will return a
   502 response.

   Clients must provide authentication when requested by the server.  It
   is possible that some implementations will accept authentication
   information at the beginning of a session, but this was not the
   original intent of the specification.  If a client attempts to
   reauthenticate, the server may return 482 response indicating that
   the new authentication data is rejected by the server.  The 482 code
   will also be returned when the AUTHINFO commands are not entered in
   the correct sequence (like two AUTHINFO USERs in a row, or AUTHINFO
   PASS preceding AUTHINFO USER).

   All information is passed in cleartext.

   When authentication succeeds, the server will create an email address
   for the client from the user name supplied in the AUTHINFO USER
   command and the hostname generated by a reverse lookup on the IP
   address of the client.  If the reverse lookup fails, the IP address,
   represented in dotted-quad format, will be used.  Once authenticated,
   the server shall generate a Sender:  line using the email address
   provided by authentication if it does not match the client-supplied
   From: line.  Additionally, the server should log the event, including
   the email address.  This will provide a means by which subsequent
   statistics generation can associate newsgroup references with unique
   entities - not necessarily by name.

3.1.1.1 Responses

      281 Authentication accepted
      381 More authentication information required
      480 Authentication required
      482 Authentication rejected
      502 No permission
*)
procedure TIdNNTPServer.CommandAuthInfoPassword(ASender: TIdCommand);
var
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if (atUserPass in SupportedAuthTypes) and Assigned(FOnAuth) then begin
      if ASender.Params.Count = 1 then begin
        LContext := TIdNNTPContext(ASender.Context);
        LContext.FAuthenticator := '';  {do not localize}
        LContext.FAuthParams := '';  {do not localize}
        LContext.FAuthEmail := '';  {do not localize}
        LContext.FAuthType := atUserPass;
        LContext.FPassword := ASender.Params[0];
        FOnAuth(LContext, LContext.FAuthenticated);
        if LContext.FAuthenticated then begin
          LContext.GenerateAuthEmail;
          ASender.Reply.NumericCode := 281;
        end else begin
          ASender.Reply.NumericCode := 482;
        end;
      end else begin
        ASender.Reply.NumericCode := 482;
      end;
    end else begin
      ASender.Reply.NumericCode := 500;
    end;
  end;
end;

procedure TIdNNTPServer.CommandAuthInfoUser(ASender: TIdCommand);
var
  LContext: TIdNNTPContext;
begin
  if not SecLayerRequired(ASender) then begin
    if (atUserPass in SupportedAuthTypes) and Assigned(FOnAuth) then begin
      if ASender.Params.Count = 1 then begin
        LContext := TIdNNTPContext(ASender.Context);
        LContext.FAuthenticator := '';  {do not localize}
        LContext.FAuthParams := '';  {do not localize}
        LContext.FAuthEmail := '';  {do not localize}
        LContext.FAuthType := atUserPass;
        LContext.FUsername := ASender.Params[0];
        FOnAuth(LContext, LContext.FAuthenticated);
        if LContext.FAuthenticated then begin
          LContext.GenerateAuthEmail;
          ASender.Reply.NumericCode := 281;
        end else begin
          ASender.Reply.NumericCode := 381;
        end;
      end else begin
        ASender.Reply.NumericCode := 482;
      end;
    end else begin
      ASender.Reply.NumericCode := 500;
    end;
  end;
end;

(*
3.1 AUTHINFO

3.1.2 AUTHINFO SIMPLE

   AUTHINFO SIMPLE
   user password

   This version of AUTHINFO was part of a proposed NNTP V2
   specification, which was started in 1991 but never completed, and is
   implemented in some servers and clients.  It is a refinement of the
   original AUTHINFO and provides the same basic functionality, but the
   sequence of commands is much simpler.

   When authorization is required, the server sends a 450 response
   requesting authorization from the client.  The client must enter
   AUTHINFO SIMPLE.  If the server will accept this form of
   authentication, the server responds with a 350 response.  The client
   must then send the username followed by one or more space characters
   followed by the password.  If accepted, the server returns a 250
   response and the client should then retry the original command to
   which the server responded with the 450 response.  The command should
   then be processed by the server normally.  If the combination is not
   valid, the server will return a 452 response.

   Note that the response codes used here were part of the proposed NNTP
   V2 specification and are violations of RFC 977.  It is recommended
   that this command not be implemented, but use either or both of the
   other forms of AUTHINFO if such functionality if required.

3.1.2.1 Responses

      250 Authorization accepted
      350 Continue with authorization sequence
      450 Authorization required for this command
      452 Authorization rejected

*)
procedure TIdNNTPServer.CommandAuthInfoSimple(ASender: TIdCommand);
var
  s: String;
  LReply: TIdReplyRFC;
  LContext: TIdNNTPContext;
begin
  if (atSimple in SupportedAuthTypes) and Assigned(FOnAuth) then begin
    LContext := TIdNNTPContext(ASender.Context);
    LReply := TIdReplyRFC.Create(nil);
    try
      LReply.NumericCode := 350;
      ReplyTexts.UpdateText(LReply);
      LContext.Connection.IOHandler.Write(LReply.FormattedReply);
    finally
      FreeAndNil(LReply);
    end;
    s := LContext.Connection.IOHandler.ReadLn;
    LContext.FAuthenticator := '';  {do not localize}
    LContext.FAuthParams := '';  {do not localize}
    LContext.FAuthEmail := '';  {do not localize}
    LContext.FAuthType := atSimple;
    LContext.FUsername := Fetch(s);
    LContext.FPassword := Trim(s);
    FOnAuth(LContext, LContext.FAuthenticated);
    if LContext.FAuthenticated then begin
      LContext.GenerateAuthEmail;
      ASender.Reply.NumericCode := 250;
    end else begin
      ASender.Reply.NumericCode := 452;
    end;
  end else begin
    ASender.Reply.NumericCode := 500;
  end;
end;

(*
3.1 AUTHINFO

3.1.3 AUTHINFO GENERIC

   AUTHINFO GENERIC authenticator arguments...

   AUTHINFO GENERIC is used to identify a specific entity to the server
   using arbitrary authentication  or identification protocols.  The
   desired protocol is indicated by the authenticator parameter, and any
   number of parameters can be passed to the authenticator.

   When authorization is required, the server will send a 480 response
   requesting authorization from the client.  The client should enter
   AUTHINFO GENERIC followed by the authenticator name, and the
   arguments if any.  The authenticator and arguments must not contain
   the sequence "..".

   The server will attempt to engage the server end authenticator,
   similarly, the client should engage the client end authenticator.
   The server end authenticator will then initiate authentication using
   the NNTP sockets (if appropriate for that authentication protocol),
   using the protocol specified by the authenticator name.  These
   authentication protocols are not included in this document, but are
   similar in structure to those referenced in RFC 1731 [8] for the
   IMAP-4 protocol.

   If the server returns 501, this means that the authenticator
   invocation was syntactically incorrect, or that AUTHINFO GENERIC is
   not supported.  The client should retry using the AUTHINFO USER
   command.

   If the requested authenticator capability is not found, the server
   returns the 503 response code.

   If there is some other unspecified server program error, the server
   returns the 500 response code.

   The authenticators converse using their protocol until complete.  If
   the authentication succeeds, the server authenticator will terminate
   with a 281, and the client can continue by reissuing the command that
   prompted the 380.  If the authentication fails, the server will
   respond with a 502.

   The client must provide authentication when requested by the server.
   The server may request authentication at any time.  Servers may
   request authentication more than once during a single session.

   When the server authenticator completes, it provides to the server
   (by a mechanism herein undefined) the email address of the user, and
   potentially what the user is allowed to access.  Once authenticated,
   the server shall generate a Sender:  line using the email address
   provided by the authenticator if it does not match the user-supplied
   From: line.  Additionally, the server should log the event, including
   the user's authenticated email address (if available).  This will
   provide a means by which subsequent statistics generation can
   associate newsgroup references with unique entities - not necessarily
   by name.

   Some implementations make it possible to obtain a list of
   authentication procedures available by sending the server AUTHINFO
   GENERIC with no arguments.  The server then returns a list of
   supported mechanisms followed by a period on a line by itself.

3.1.3.1 Responses

      281 Authentication succeeded
      480 Authentication required
      500 Command not understood
      501 Command not supported
      502 No permission
      503 Program error, function not performed
      nnn  authenticator-specific protocol.
*)
procedure TIdNNTPServer.CommandAuthInfoGeneric(ASender: TIdCommand);
var
  LContext: TIdNNTPContext;
  s: String;
begin
  if (atGeneric in SupportedAuthTypes) and Assigned(FOnAuth) then begin
    s := Trim(ASender.UnparsedParams);
    if (Length(s) > 0) and (IndyPos('..', s) = 0) then begin
      LContext := TIdNNTPContext(ASender.Context);
      LContext.FAuthenticator := Fetch(s);
      LContext.FAuthParams := Trim(s);
      LContext.FAuthEmail := '';  {do not localize}
      LContext.FAuthType := atGeneric;
      LContext.FUsername := '';  {do not localize}
      LContext.FPassword := '';  {do not localize}
      FOnAuth(LContext, LContext.FAuthenticated);
      if LContext.FAuthenticated then begin
        LContext.GenerateAuthEmail;
        ASender.Reply.NumericCode := 281;
      end else begin
        ASender.Reply.NumericCode := 502;
      end;
    end else begin
      ASender.Reply.NumericCode := 501;
    end;
  end else begin
    ASender.Reply.NumericCode := 500;
  end;
end;

function TIdNNTPServer.SecLayerRequired(ASender: TIdCommand): Boolean;
begin
  Result := TIdNNTPContext(ASender.Context).TLSIsRequired;
  if Result then begin
    ASender.Reply.NumericCode := 483;
  end;
end;

function TIdNNTPServer.LookupMessage(ASender: TIdCommand; var VNo: Int64; var VId: string): TIdNNTPLookupType;
var
  s : string;
  LContext : TidNNTPContext;
  LIsMsgID: Boolean;
begin
  Result := ltLookupError;
  LContext := TIdNNTPContext(ASender.Context);

  s := Trim(ASender.UnparsedParams);
  VId := '';  {do not localize}

  LIsMsgID := TextStartsWith(s, '<');
  if not LIsMsgID then begin
    if Length(LContext.CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412; // No newsgroup has been selected
      Exit;
    end;
  end;

  if LIsMsgID then begin
    VNo := DoCheckMsgID(LContext, s);
    if VNo <= 0 then begin
      ASender.Reply.NumericCode := 430; // Article not found
      Exit;
    end;
    VId := s;
    Result := ltLookupByMsgId;
    {
    RLebeau - per RFC 977, the CurrentArticle should
    not be updated when selecting an article by MsgID
    }
  end
  else begin
    if Length(s) = 0 then begin
      VNo := LContext.CurrentArticle;
      if VNo <= 0 then begin
        ASender.Reply.NumericCode := 420;  // Current article not set.
        Exit;
      end;
    end
    else begin
      VNo := IndyStrToInt64(s, 0);
      if VNo > 0 then begin
        VId := DoCheckMsgNo(LContext, VNo);
      end;
      if Length(VId) = 0 then begin
        ASender.Reply.NumericCode := 423;  // Article does not exist
        Exit;
      end;
      LContext.FCurrentArticle := VNo;
    end;
    Result := ltLookupByMsgNo;
  end;
end;

function TIdNNTPServer.LookupMessageRange(ASender: TIdCommand; const AData: String;
  var VMsgFirst: Int64; var VMsgLast: Int64): Boolean;
var
  s: String;
  LContext: TIdNNTPContext;
  IsRange: Boolean;
begin
  Result := False;
  LContext := TIdNNTPContext(ASender.Context);

  if Length(LContext.CurrentGroup) = 0 then begin
    ASender.Reply.NumericCode := 412;
    Exit;
  end;

  s := Trim(AData);

  if Length(s) = 0 then begin
    IsRange := False;
    VMsgFirst := LContext.CurrentArticle;
  end else begin
    IsRange := IndyPos('-', s) > 1;
    if IsRange then begin
      VMsgFirst := IndyStrToInt64(Fetch(s, '-'), 0);
    end else begin
      VMsgFirst := IndyStrToInt64(s, 0);
    end;
  end;

  if VMsgFirst <= 0 then begin
    ASender.Reply.NumericCode := 420;
    Exit;
  end;

  if IsRange then begin
    s := Trim(s);
    if Length(s) = 0 then begin
      VMsgLast := 0;  // return all from VMsgFirst onwards
    end else begin
      VMsgLast := IndyStrToInt64(s, 0);
      if VMsgLast < VMsgFirst then begin
        ASender.Reply.NumericCode := 501;
        Exit;
      end;
    end;
  end else begin
    VMsgLast := VMsgFirst;
  end;

  Result := True;
end;

function TIdNNTPServer.LookupMessageRangeOrID(ASender: TIdCommand; const AData: String;
  var VMsgFirst: Int64; var VMsgLast: Int64; var VMsgID: String): Boolean;
var
  s: String;
  LFirstMsg: Int64;
  LContext: TIdNNTPContext;
begin
  Result := False;
  LContext := TIdNNTPContext(ASender.Context);

  s := Trim(AData);

  if TextStartsWith(s, '<') then begin
    LFirstMsg := DoCheckMsgID(LContext, s);
    if LFirstMsg <= 0 then begin
      ASender.Reply.NumericCode := 430;
      Exit;
    end;
    VMsgFirst := LFirstMsg;
    VMsgLast := LFirstMsg;
    VMsgID := s;
    Result := True;
  end else begin
    Result := LookupMessageRange(ASender, s, VMsgFirst, VMsgLast);
  end;
end;

end.
