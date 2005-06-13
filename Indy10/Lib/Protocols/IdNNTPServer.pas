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
{   Rev 1.31    12/2/2004 4:23:56 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.30    10/26/2004 10:33:46 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.29    5/16/04 5:22:54 PM  RLebeau
{ Added try...finally to CommandPost()
}
{
{   Rev 1.28    3/1/2004 1:02:58 PM  JPMugaas
{ Fixed for new code.
}
{
{   Rev 1.27    2004.02.03 5:44:10 PM  czhower
{ Name changes
}
{
{   Rev 1.26    1/21/2004 3:26:58 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.25    1/1/04 1:22:04 AM  RLebeau
{ Bug fix for parameter parsing in CommandNewNews() that was testing the
{ ASender.Params.Count incorrectly.
}
{
{   Rev 1.24    2003.10.21 9:13:12 PM  czhower
{ Now compiles.
}
{
    Rev 1.23    10/19/2003 5:39:52 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.22    2003.10.18 9:42:10 PM  czhower
{ Boatload of bug fixes to command handlers.
}
{
{   Rev 1.21    2003.10.12 4:04:02 PM  czhower
{ compile todos
}
{
{   Rev 1.20    9/19/2003 03:30:10 PM  JPMugaas
{ Now should compile again.
}
{
{   Rev 1.19    9/17/2003 10:41:56 PM  PIonescu
{ Fixed small mem leak in CommandPost
}
{
{   Rev 1.18    8/6/2003 6:13:50 PM  SPerry
{ Message-ID Integer - > string
}
{
{   Rev 1.17    8/2/2003 03:53:00 AM  JPMugaas
{ Unit needed to be added to uses clause.
}
{
{   Rev 1.16    8/1/2003 8:21:38 PM  SPerry
{ -
}
{
{   Rev 1.13    5/26/2003 04:28:02 PM  JPMugaas
{ Removed GenerateReply and ParseResponse calls because those functions are
{ being removed.
}
{
{   Rev 1.12    5/26/2003 12:23:48 PM  JPMugaas
}
{
{   Rev 1.11    5/25/2003 03:50:48 AM  JPMugaas
}
{
    Rev 1.10    5/21/2003 2:25:04 PM  BGooijen
  changed due to change in IdCmdTCPServer from ReplyExceptionCode: Integer to
  ReplyException: TIdReply
}
{
{   Rev 1.9    3/26/2003 04:18:26 PM  JPMugaas
{ Now supports implicit and explicit TLS.
}
{
{   Rev 1.7    3/17/2003 08:55:52 AM  JPMugaas
{ Missing reply texts.
}
{
{   Rev 1.6    3/16/2003 08:30:24 AM  JPMugaas
{ Reenabled ExplicitTLS according to
{ http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt.
{
{ Support is still preliminary.
}
{
    Rev 1.5    1/20/2003 1:15:34 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes
}
{
{   Rev 1.4    1/17/2003 07:10:40 PM  JPMugaas
{ Now compiles under new framework.
}
{
{   Rev 1.3    1/9/2003 06:09:28 AM  JPMugaas
{ Updated for IdContext API change.
}
{
{   Rev 1.2    1/8/2003 05:53:38 PM  JPMugaas
{ Switched stuff to IdContext.
}
{
{   Rev 1.1    12/7/2002 06:43:14 PM  JPMugaas
{ These should now compile except for Socks server.  IPVersion has to be a
{ property someplace for that.
}
{
{   Rev 1.0    11/13/2002 07:58:00 AM  JPMugaas
}
unit IdNNTPServer;

interface

{
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
Original Author: Ozz Nixon (Winshoes 7)
}

uses
  IdAssignedNumbers, IdContext, IdCustomTCPServer, IdYarn, IdCommandHandlers, IdException,
  IdGlobal, IdServerIOHandler, IdCmdTCPServer, IdExplicitTLSClientServerBase, IdSys,
  IdTCPConnection, IdTCPServer, IdObjs;

(*
 For more information on NNTP visit http://www.faqs.org/rfcs/

 RFC 977 - A Proposed Standard for the Stream-Based Transmission of News
 RFC 2980 - Common NNTP Extensions
 RFC 1036 - Standard for Interchange of USENET Messages
 RFC 822 - Standard for the Format of ARPA Internet Text
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
   220 n <a> article retrieved - head and body follow 221 n <a> article
   retrieved - head follows
   222 n <a> article retrieved - body follows
   223 n <a> article retrieved - request text separately 230 list of new
   articles by message-id follows
   231 list of new newsgroups follows
   235 article transferred ok
   240 article posted ok

   335 send article to be transferred.  End with <CR-LF>.<CR-LF>
   340 send article to be posted. End with <CR-LF>.<CR-LF>

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

   500 command not recognized
   501 command syntax error
   502 access restriction or permission denied
   503 program fault - command not performed
*)

const
  DEF_NNTP_IMPLICIT_TLS = False;

type
  EIdNNTPServerException = class(EIdException);
  EIdNNTPImplicitTLSRequiresSSL = class(EIdNNTPServerException);

  TIdNNTPContext = class(TIdContext)
  protected
    FCurrentArticle: Integer;
    FCurrentGroup: string;
    FUserName: string;
    FPassword: string;
    FAuthenticated : Boolean;
    FModeReader: Boolean;
    function GetUsingTLS:boolean;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdThreadList = nil
      ); override;
    //
    property CurrentArticle: Integer read FCurrentArticle;
    property CurrentGroup: string read FCurrentGroup;
    property ModeReader: Boolean read FModeReader;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property Authenticated: Boolean read FAuthenticated;
    property UsingTLS : boolean read GetUsingTLS;
  end;

  TIdNNTPOnAuth = procedure(AThread: TIdNNTPContext; var VAccept: Boolean) of object;
  TIdNNTPOnNewGroupsList = procedure ( AThread: TIdNNTPContext; const ADateStamp : TDateTime; const ADistributions : String) of object;
  TIdNNTPOnNewNews = procedure ( AThread: TIdNNTPContext; const Newsgroups : String; const ADateStamp : TDateTime; const ADistributions : String) of object;
  TIdNNTPOnIHaveCheck = procedure(AThread: TIdNNTPContext; const AMsgID : String; VAccept : Boolean) of object;
  TIdNNTPOnArticleByNo = procedure(AThread: TIdNNTPContext; const AMsgNo: Integer) of object;
  TIdNNTPOnArticleByID = procedure(AThread: TIdNNTPContext; const AMsgID: string) of object;
  TIdNNTPOnCheckMsgNo = procedure(AThread: TIdNNTPContext; const AMsgNo: Integer;
   var VMsgID: string) of object;
  //this has to be a separate event type in case a NNTP client selects a message
  //by Message ID instead of Index number.  If that happens, the user has to
  //to return the index number.  NNTP Clients setting STAT by Message ID is not
  //a good idea but is valid.
  TIdNNTPOnMovePointer = procedure(AThread: TIdNNTPContext; var AMsgNo: Integer;
   var VMsgID: string) of object;
  TIdNNTPOnPost = procedure(AThread: TIdNNTPContext; var VPostOk: Boolean;
   var VErrorText: string) of object;
  TIdNNTPOnSelectGroup = procedure(AThread: TIdNNTPContext; const AGroup: string;
   var VMsgCount: Integer; var VMsgFirst: Integer; var VMsgLast: Integer;
   var VGroupExists: Boolean) of object;
  TIdNNTPOnCheckListGroup = procedure(AThread: TIdNNTPContext; const AGroup: string;
   var VCanJoin : Boolean; var VFirstArticle : Integer) of object;
  TIdNNTPOnXOver = procedure(AThread: TIdNNTPContext; const AMsgFirst: Integer;
   const AMsgLast: Integer) of object;
  TIdNNTPOnXHdr = procedure(AThread: TIdNNTPContext; const AHeaderName : String;
    const AMsgFirst: Integer; const AMsgLast: Integer; const AMsgID: String) of object;

  TIdNNTPServer = class(TIdExplicitTLSServer)
  protected
    FImplicitTLS:boolean;
    FHelp: TIdStrings;
    FOverviewFormat: TIdStrings;
    FOnArticleByNo: TIdNNTPOnArticleByNo;
    FOnBodyByNo: TIdNNTPOnArticleByNo;
    FOnHeadByNo: TIdNNTPOnArticleByNo;
    FOnCheckMsgNo: TIdNNTPOnCheckMsgNo;
    FOnStatMsgNo : TIdNNTPOnMovePointer;
    FOnNextArticle : TIdNNTPOnMovePointer;
    FOnPrevArticle : TIdNNTPOnMovePointer;
    //LISTGROUP events - Gravity uses these
    FOnCheckListGroup : TIdNNTPOnCheckListGroup;
    FOnListGroup : TIdServerThreadEvent;

    FOnListGroups: TIdServerThreadEvent;
    FOnListNewGroups : TIdNNTPOnNewGroupsList;
    FOnPost: TIdNNTPOnPost;
    FOnSelectGroup: TIdNNTPOnSelectGroup;
    FOnXOver: TIdNNTPOnXOver;
    FOnXHdr: TIdNNTPOnXHdr;
    FOnNewNews : TIdNNTPOnNewNews;
    FOnIHaveCheck : TIdNNTPOnIHaveCheck;
    FOnIHavePost: TIdNNTPOnPost;
    FOnAuth: TIdNNTPOnAuth;

    function SecLayerOk(ASender : TIdCommand) : Boolean;
    function AuthOk(ASender: TIdCommand): Boolean;
    //return MsgID - AThread.CurrentArticlePointer already set
    function RawNavigate(AThread: TIdNNTPContext; AEvent : TIdNNTPOnMovePointer) : String;
    procedure CommandArticle(ASender: TIdCommand);
    procedure CommandAuthInfoUser(ASender: TIdCommand);
    procedure CommandAuthInfoPassword(ASender: TIdCommand);
    procedure CommandBody(ASender: TIdCommand);
    procedure CommandDate(ASender: TIdCommand);
    procedure CommandHead(ASender: TIdCommand);
    procedure CommandGroup(ASender: TIdCommand);
    procedure CommandIHave(ASender: TIdCommand);
    procedure CommandLast(ASender: TIdCommand);
    procedure CommandList(ASender: TIdCommand);
    procedure CommandListGroup(ASender: TIdCommand);
    procedure CommandListExtensions(ASender: TIdCommand);
    procedure CommandModeReader(ASender: TIdCommand);
    procedure CommandNewGroups(ASender: TIdCommand);
    procedure CommandNewNews(ASender: TIdCommand);
    procedure CommandNext(ASender: TIdCommand);
    procedure CommandPost(ASender: TIdCommand);
    procedure CommandSlave(ASender: TIdCommand);
    procedure CommandStat(ASender: TIdCommand);
    procedure CommandXHdr(ASender: TIdCommand);
    procedure CommandXOver(ASender: TIdCommand);
    procedure CommandSTARTTLS(ASender: TIdCommand);

    procedure DoListGroups(AThread: TIdNNTPContext);
    procedure DoSelectGroup(AThread: TIdNNTPContext; const AGroup: string; var VMsgCount: Integer;
     var VMsgFirst: Integer; var VMsgLast: Integer; var VGroupExists: Boolean);
    procedure InitializeCommandHandlers; override;
    procedure SetHelp(AValue: TIdStrings);
    procedure SetOverviewFormat(AValue: TIdStrings);
    procedure SetIOHandler(const AValue: TIdServerIOHandler); override;
    procedure SetImplicitTLS(const AValue: Boolean);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    class function NNTPTimeToTime(const ATimeStamp : String): TDateTime;
    class function NNTPDateTimeToDateTime(const ATimeStamp: string): TDateTime;
  published
    property DefaultPort default IdPORT_NNTP;
    property Help: TIdStrings read FHelp write SetHelp;
    property OnArticleByNo: TIdNNTPOnArticleByNo read FOnArticleByNo write FOnArticleByNo;
    property OnAuth: TIdNNTPOnAuth read FOnAuth write FOnAuth;
    property OnBodyByNo: TIdNNTPOnArticleByNo read FOnBodyByNo write FOnBodyByNo;
    property OnHeadByNo: TIdNNTPOnArticleByNo read FOnHeadByNo write FOnHeadByNo;
    property OnCheckMsgNo: TIdNNTPOnCheckMsgNo read FOnCheckMsgNo write FOnCheckMsgNo;
    property OnStatMsgNo : TIdNNTPOnMovePointer read FOnStatMsgNo write FOnStatMsgNo;
    //You are responsible for writing event handlers for these instead of us incrementing
    //and decrimenting the pointer.  This design permits you to implement article expirity,
    //cancels, and supercedes
    property OnNextArticle : TIdNNTPOnMovePointer read FOnNextArticle write FOnNextArticle;
    property OnPrevArticle : TIdNNTPOnMovePointer read FOnPrevArticle write FOnPrevArticle;
    property OnCheckListGroup : TIdNNTPOnCheckListGroup read FOnCheckListGroup write FOnCheckListGroup;
    property OnListGroups: TIdServerThreadEvent read FOnListGroups write FOnListGroups;
    property OnListGroup : TIdServerThreadEvent read FOnListGroup write FOnListGroup;
    property OnListNewGroups : TIdNNTPOnNewGroupsList read FOnListNewGroups write FOnListNewGroups;
    property OnSelectGroup: TIdNNTPOnSelectGroup read FOnSelectGroup write FOnSelectGroup;
    property OnPost: TIdNNTPOnPost read FOnPost write FOnPost;
    property OnXOver: TIdNNTPOnXOver read FOnXOver write FOnXOver;
    property OverviewFormat: TIdStrings read FOverviewFormat write SetOverviewFormat;
    property OnXHdr: TIdNNTPOnXHdr read FOnXHdr write FOnXHdr;
    property OnNewNews : TIdNNTPOnNewNews read FOnNewNews write FOnNewNews;
    property OnIHaveCheck : TIdNNTPOnIHaveCheck read FOnIHaveCheck write FOnIHaveCheck;
    property OnIHavePost: TIdNNTPOnPost read FOnIHavePost write FOnIHavePost;
    property ImplicitTLS : Boolean read FImplicitTLS write SetImplicitTLS default DEF_NNTP_IMPLICIT_TLS;
  end;

implementation

uses
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  IdReply,
  IdReplyRFC,
  IdSSL;

resourcestring
  RSNNTPSvrImplicitTLSRequiresSSL='Implicit NNTP requires that IOHandler be set to a TIdSSLIOHandlerSocketBase.';

Const
  AuthTypes: array [1..2] of string = ('USER', 'PASS'); {Do not localize}

class function TIdNNTPServer.NNTPTimeToTime(const ATimeStamp : String): TDateTime;
var
  LHr, LMn, LSec : Word;
  LTimeStr : String;
begin
  LTimeStr := ATimeStamp;
  if LTimeStr <> '' then
  begin
    LHr := Sys.StrToInt(Copy(LTimeStr,1,2),1);
    Delete(LTimeStr,1,2);
    LMn := Sys.StrToInt(Copy(LTimeStr,1,2),1);
    Delete(LTimeStr,1,2);
    LSec := Sys.StrToInt(Copy(LTimeStr,1,2),1);
    Delete(LTimeStr,1,2);
    Result := Sys.EncodeTime(LHr, LMn, LSec,0);
    LTimeStr := Sys.Trim(LTimeStr);
    if Sys.UpperCase(LTimeStr)='GMT' then {do not localize}
    begin
      // Apply local offset
      Result := Result + OffSetFromUTC;
    end;
  end else begin
    Result := 0;
  end;
end;

class function TIdNNTPServer.NNTPDateTimeToDateTime(const ATimeStamp : String): TDateTime;
var
  LYr, LMo, LDay : Word;
    LTimeStr : String;
    LDateStr : String;
begin
  Result := 0;
  if ATimeStamp <> '' then begin
    LTimeStr := ATimeStamp;
    LDateStr := Fetch(LTimeStr);
    if (Length(LDateStr) > 6) then begin
      //four digit year, good idea - IMAO
      LYr := Sys.StrToInt(Copy(LDateStr,1,4),1969);
      Delete(LDateStr,1,4);
    end else begin
      LYr := Sys.StrToInt(Copy(LDateStr,1,2),69);
      Delete(LDateStr,1,2);
      LYr := LYr + 2000;
    end;
    LMo := Sys.StrToInt(Copy(LDateStr,1,2),1);
    Delete(LDateStr,1,2);
    LDay := Sys.StrToInt(Copy(LDateStr,1,2),1);
    Delete(LDateStr,1,2);
    Result := Sys.EncodeDate(LYr, LMo, LDay) + NNTPTimeToTime(LTimeStr);
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
procedure TIdNNTPServer.CommandArticle(ASender: TIdCommand);
// Note - we dont diffentiate between 423 and 430, we always return 430
var
  s: string;
  LMsgID: string;
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
begin
  if Assigned(OnArticleByNo) and Assigned(OnCheckMsgNo) then begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender) then begin
      Exit;
    end;
    LThread := TIdNNTPContext(ASender.Context );
    if Length(LThread.CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412;
    end else begin
      s := Sys.Trim(ASender.UnparsedParams);
      // Try as a MsgID
      if Copy(s, 1, 1) = '<' then begin
      // Try as a MsgNo
      end else begin
        LMsgNo := Sys.StrToInt(s, 0);
        if LMsgNo = 0 then begin
          if LThread.CurrentArticle = 0 then begin
            ASender.Reply.NumericCode := 420;
            Exit;
          end;
          LMsgNo := LThread.CurrentArticle;
        end;
        LMsgID := '';
        OnCheckMsgNo(LThread, LMsgNo, LMsgID);
        if (Length(LMsgID) > 0) and Assigned(OnArticleByNo) then begin
          ASender.Reply.SetReply(220, Sys.IntToStr(LMsgNo) + ' ' + LMsgID
           + ' article retrieved - head and body follow');  {do not localize}
          ASender.SendReply;
          OnArticleByNo(LThread, LMsgNo);
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandBody(ASender: TIdCommand);
// Note - we dont diffentiate between 423 and 430, we always return 430
var
  s: string;
  LMsgID: string;
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
begin
  if Assigned(OnArticleByNo) and Assigned(OnCheckMsgNo) then begin
    if AuthOk(ASender) then begin
      Exit;
    end;
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    LThread := TIdNNTPContext(ASender.Context);
    if Length(LThread.CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412;
    end else begin
      s := Sys.Trim(ASender.UnparsedParams);
      // Try as a MsgID
      if Copy(s, 1, 1) = '<' then begin
      // Try as a MsgNo
      end else begin
        LMsgNo := Sys.StrToInt(s, 0);
        if LMsgNo = 0 then begin
          if LThread.CurrentArticle = 0 then begin
            ASender.Reply.NumericCode := 420;
            Exit;
          end;
          LMsgNo := LThread.CurrentArticle;
        end;
        LMsgID := '';
        OnCheckMsgNo(LThread, LMsgNo, LMsgID);
        if (Length(LMsgID) > 0) and Assigned(OnArticleByNo) then begin
          ASender.Reply.SetReply(220, Sys.IntToStr(LMsgNo) + ' ' + LMsgID
           + ' article retrieved - body follows');  {do not localize}
          ASender.SendReply;
          OnBodyByNo(LThread, LMsgNo);
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandDate(ASender: TIdCommand);
begin
  if SecLayerOk(ASender) then
  begin
    Exit;
  end;
  ASender.Reply.SetReply(111,Sys.FormatDateTime('yyyymmddhhnnss', Sys.Now + TimeZoneBias));  {do not localize}
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
  LMsgCount: Integer;
  LMsgFirst: Integer;
  LMsgLast: Integer;
begin
  if SecLayerOk(ASender) then
  begin
    Exit;
  end;
  if not AuthOk(ASender) then begin
    LGroup := Sys.Trim(ASender.UnparsedParams);
    DoSelectGroup(TIdNNTPContext(ASender.Context), LGroup, LMsgCount, LMsgFirst, LMsgLast
     , LGroupExists);
    if LGroupExists then begin
      TIdNNTPContext(ASender.Context).FCurrentGroup := LGroup;
      ASender.Reply.SetReply(211, Sys.Format('%d %d %d %s', [LMsgCount, LMsgFirst, LMsgLast, LGroup]));
    end;
  end;
end;

procedure TIdNNTPServer.CommandHead(ASender: TIdCommand);
// Note - we dont diffentiate between 423 and 430, we always return 430
var
  s: string;
  LMsgID: string;
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
begin
  if Assigned(OnArticleByNo) and Assigned(OnCheckMsgNo) then begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender) then begin
      Exit;
    end;
    LThread := TIdNNTPContext(ASender.Context);
    if Length(LThread.CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412;
    end else begin
      s := Sys.Trim(ASender.UnparsedParams);
      // Try as a MsgID
      if Copy(s, 1, 1) = '<' then begin
      // Try as a MsgNo
      end else begin
        LMsgNo := Sys.StrToInt(s, 0);
        if LMsgNo = 0 then begin
          if LThread.CurrentArticle = 0 then begin
            ASender.Reply.NumericCode := 420;
            Exit;
          end;
          LMsgNo := LThread.CurrentArticle;
        end;
        LMsgID := '';
        OnCheckMsgNo(LThread, LMsgNo, LMsgID);
        if (Length(LMsgID) > 0) and Assigned(OnArticleByNo) then begin
          ASender.Reply.SetReply(220, Sys.IntToStr(LMsgNo) + ' ' + LMsgID +
           ' article retrieved - head follows');  {do not localize}
          ASender.SendReply;
          OnHeadByNo(LThread, LMsgNo);
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandIHave(ASender: TIdCommand);
var LThread : TIdNNTPContext;
    LMsgID : String;
    LAccept:Boolean;
    LErrorText : String;
begin
  if Assigned(FOnIHaveCheck) then
  begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender) then begin
      Exit;
    end;
    LThread := TIdNNTPContext(ASender.Context);
    LMsgID := Sys.Trim(ASender.UnparsedParams);
    if (Copy(LMsgID, 1, 1) = '<') then begin
      FOnIHaveCheck(LThread,LMsgID,LAccept);
      if LAccept then
      begin
        ASender.Reply.SetReply(335,'News to me!  <CRLF.CRLF> to end.'); {do not localize}
        ASender.SendReply;
        LErrorText := '';
        OnPost(TIdNNTPContext(ASender.Context), LAccept, LErrorText);
        ASender.Reply.SetReply(iif(LAccept, 235, 436), LErrorText);
      end
      else
      begin
        ASender.Reply.NumericCode := 435;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandLast(ASender: TIdCommand);
var
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
  LMsgID : String;
begin
  if Assigned(OnPrevArticle) then begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if not AuthOk(ASender) then begin
      LThread := TIdNNTPContext(ASender.Context);
      //we do this in a round about way in case there is no previous article at all
      LMsgNo := LThread.CurrentArticle;
      LMsgID := RawNavigate(LThread,OnPrevArticle);
      if LMsgID<>'' then begin
        ASender.Reply.SetReply(223, Sys.IntToStr(LMsgNo) + ' ' + LMsgID +
          ' article retrieved - request text separately');  {do not localize}
      end else begin
        ASender.Reply.NumericCode := 430;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
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
  if SecLayerOk(ASender) then
  begin
    Exit;
  end;
  if not AuthOk(ASender) then begin
    ASender.SendReply;
    DoListGroups(TIdNNTPContext(ASender.Context));
    ASender.Context.Connection.IOHandler.WriteLn('.');
  end;
end;

procedure TIdNNTPServer.CommandListGroup(ASender: TIdCommand);
var LThrd : TIdNNTPContext;
    LGroup : String;
    LFirstIdx : Integer;
    LCanJoin : Boolean;
begin
  if Assigned(FOnCheckListGroup) and Assigned(FOnListGroup) then begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender)=False then begin
      ASender.Reply.NumericCode := 502;
    end;
    LThrd := TIdNNTPContext ( ASender.Context );
    LGroup := Sys.Trim(ASender.UnparsedParams);
    if Length(LGroup)>0 then
    begin
      LGroup := LThrd.CurrentGroup;
    end;
    FOnCheckListGroup(LThrd,LGroup,LCanJoin,LFirstIdx);
    if LCanJoin then
    begin
      LThrd.FCurrentGroup := LGroup;
      LThrd.FCurrentArticle := LFirstIdx;
      ASender.SendReply;
      FOnListGroup(LThrd);
      ASender.Context.Connection.IOHandler.WriteLn('.');
    end
    else
    begin
      ASender.Reply.SetReply(412,'Not currently in newsgroup'); {do not localize}
    end;
  end else ASender.Reply.NumericCode := 500;
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
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
  TIdNNTPContext(ASender.Context).FModeReader := True;
  ASender.Reply.NumericCode := 200;
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
var LDate : TDateTime;
    LDist : String;
begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
  if AuthOk(ASender) then begin
    Exit;
  end;
  if (ASender.Params.Count > 1) and (Assigned(FOnListNewGroups)) then
  begin
    LDist := '';
    LDate := NNTPDateTimeToDateTime( ASender.Params[0] );
    LDate := LDate + NNTPTimeToTime( ASender.Params[1] );
    if ASender.Params.Count > 2 then
    begin
      if (Sys.UpperCase(ASender.Params[2]) = 'GMT') then {Do not translate}
      begin
        LDate := LDate + OffSetFromUTC;
        if (ASender.Params.Count > 3) then
        begin
          LDist := ASender.Params[3];
        end;
      end
      else
      begin
        LDist := ASender.Params[2];
      end;
    end;
    ASender.SendReply;
    FOnListNewGroups(TIdNNTPContext(ASender.Context), LDate, LDist);
    ASender.Context.Connection.IOHandler.WriteLn('.');
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandNewNews(ASender: TIdCommand);
var LDate : TDateTime;
    LDist : String;
begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
  if AuthOk(ASender) then begin
    Exit;
  end;
  if (ASender.Params.Count > 2) and (Assigned(FOnNewNews)) then
  begin
    //0 - newsgroup
    //1 - date
    //2 - time
    //3 - GMT or distributions
    //4 - distributions if 3 was GMT
    LDist := '';
    LDate := NNTPDateTimeToDateTime( ASender.Params[1] );
    LDate := LDate + NNTPTimeToTime( ASender.Params[2] );
    if (ASender.Params.Count > 3) then
    begin
      if (Sys.UpperCase(ASender.Params[3]) = 'GMT') then {Do not translate}
      begin
        LDate := LDate + OffSetFromUTC;
        if (ASender.Params.Count > 4) then
        begin
          LDist := ASender.Params[4];
        end;
      end
      else
      begin
        LDist := ASender.Params[3];
      end;
    end;
    ASender.SendReply;
    FOnNewNews( TIdNNTPContext(ASender.Context), ASender.Params[0], LDate, LDist );
    ASender.Context.Connection.IOHandler.WriteLn('.');
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandNext(ASender: TIdCommand);
var
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
  LMsgID : String;
begin
  if Assigned(OnPrevArticle) then begin
      if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender) then begin
      Exit;
    end;
    LThread := TIdNNTPContext(ASender.Context);
    //we do this in a round about way in case there is no previous article at all
    LMsgNo := LThread.CurrentArticle;
    LMsgID := RawNavigate(LThread,OnPrevArticle);
    if LMsgID<>'' then begin
      ASender.Reply.SetReply(223, Sys.IntToStr(LMsgNo) + ' ' + LMsgID +
        ' article retrieved - request text separately'); {do not localize}
    end else begin
      ASender.Reply.NumericCode := 430;
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
begin
  if SecLayerOk(ASender) then begin
    Exit;
  end;
  if AuthOk(ASender) then begin
    Exit;
  end;
  LCanPost := Assigned(OnPost);
  LReply := TIdReplyRFC.Create(nil);
  try
    LReply.NumericCode := iif(LCanPost, 340, 440);
    ReplyTexts.UpdateText(LReply);
    ASender.Context.Connection.IOHandler.Write(LReply.FormattedReply);
  finally
    Sys.FreeAndNil(LReply);
  end;
  if LCanPost then begin
    LPostOk := False;
    LErrorText := '';
    OnPost(TIdNNTPContext(ASender.Context), LPostOk, LErrorText);
    ASender.Reply.SetReply(iif(LPostOk, 240, 441), LErrorText);
  end;
end;

procedure TIdNNTPServer.CommandSlave(ASender: TIdCommand);
begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
  TIdNNTPContext(ASender.Context).FModeReader := False;
  ASender.Reply.NumericCode := 220;
end;

procedure TIdNNTPServer.CommandStat(ASender: TIdCommand);
var
  s: string;
  LMsgID: string;
  LMsgNo: Integer;
  LThread: TIdNNTPContext;
begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
  if AuthOk(ASender) then begin
    Exit;
  end;
  if Assigned(OnArticleByNo) and Assigned(OnCheckMsgNo) then begin
    LThread := TIdNNTPContext(ASender.Context);
    if Length(LThread.CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412;
    end else begin
      s := Sys.Trim(ASender.UnparsedParams);
      // Try as a MsgID
      if Copy(s, 1, 1) = '<' then begin
      // Try as a MsgNo
      end else begin
        LMsgNo := Sys.StrToInt(s, 0);
        if LMsgNo = 0 then begin
          if LThread.CurrentArticle = 0 then begin
            ASender.Reply.NumericCode := 420;
            Exit;
          end;
          LMsgNo := LThread.CurrentArticle;
        end;
        LMsgID := '';
        OnStatMsgNo(LThread, LMsgNo, LMsgID);
        if (Length(LMsgID) > 0) then begin
          LThread.FCurrentArticle := LMsgNo;
          ASender.Reply.SetReply(220, Sys.IntToStr(LMsgNo) + ' ' + LMsgID +
            ' article retrieved - statistics only');  {do not localize}
          ASender.SendReply;
        end else begin
          ASender.Reply.NumericCode := 430;
        end;
      end;
    end;
  end;
end;

procedure TIdNNTPServer.CommandXHdr(ASender: TIdCommand);
var
  i: Integer;
  s: String;
  LFirstMsg: Integer;
  LLastMsg: Integer;
  LMsgID: String;
begin
  if Assigned(FOnXHdr) then begin
      if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if not AuthOk(ASender) then
    begin
      if Length(TIdNNTPContext(ASender.Context).CurrentGroup) = 0 then
      begin
        ASender.Reply.NumericCode := 412;
      end
      else
      begin
        if (ASender.Params.Count > 0) then
        begin
          s := '';
          for i := 1 to ASender.Params.Count - 1 do
          begin
            s := s + ASender.Params[i] + ' ';
          end;
          s := Sys.Trim(s);
          LFirstMsg := Sys.StrToInt(Sys.Trim(Fetch(s, '-')), 0);
          LMsgID := '';

          if LFirstMsg = 0 then
          begin
            if (ASender.Params.Count = 2) then { HEADER MSG-ID }
            begin
              LMsgID := ASender.Params[1];
              LFirstMsg := Sys.StrToInt(LMsgID, 0);
              LLastMsg := LFirstMsg;
            end
            else
            begin
              LFirstMsg := TIdNNTPContext(ASender.Context).CurrentArticle;
              LLastMsg := LFirstMsg;
            end;
          end
          else
          begin
            if Pos('-', ASender.UnparsedParams) > 0 then
            begin
              LLastMsg := Sys.StrToInt(Sys.Trim(s), 0);
            end
            else
            begin
              LLastMsg := LFirstMsg;
            end;
          end;

          if LFirstMsg = 0 then
          begin
            ASender.Reply.NumericCode := 420;
          end
          else
          begin
            //Note there is an inconstancy here.
            //RFC 2980 says XHDR should return 221
            //http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-17.txt
            //says that HDR should return 225
            //just return the default numeric success reply.
            ASender.SendReply;
            // No need for DoOnXhdr - only this proc can call it and it already checks for nil
            FOnXhdr(TIdNNTPContext(ASender.Context), ASender.Params[0], LFirstMsg, LLastMsg, LMsgID);
            ASender.Context.Connection.IOHandler.WriteLn('.');
          end;
        end;
      end;
    end;
  end else begin
    ASender.Reply.NumericCode := 500;
//      ASender.Reply.NumericCode := 221;
//      ASender.SendReply;
//      ASender.Context.Connection.WriteLn('.');
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
  s: string;
  LFirstMsg: Integer;
  LLastMsg: Integer;
begin
  if Assigned(OnXOver) then begin
    if SecLayerOk(ASender) then
    begin
      Exit;
    end;
    if AuthOk(ASender) then begin
      Exit;
    end;
    if Length(TIdNNTPContext(ASender.Context).CurrentGroup) = 0 then begin
      ASender.Reply.NumericCode := 412;
    end else begin
      s := ASender.UnparsedParams;
      LFirstMsg := Sys.StrToInt(Sys.Trim(Fetch(s, '-')), -1);
      if LFirstMsg = -1 then begin
        LFirstMsg := TIdNNTPContext(ASender.Context).CurrentArticle;
        LLastMsg := LFirstMsg;
      end else begin
        LLastMsg := Sys.StrToInt(Sys.Trim(s), -1);
      end;
      if LFirstMsg = -1 then begin
        ASender.Reply.NumericCode := 420;
      end else begin
        ASender.Reply.NumericCode := 224;
        ASender.SendReply;
        // No need for DoOnXover - only this proc can call it and it already checks for nil
        OnXOver(TIdNNTPContext(ASender.Context), LFirstMsg, LLastMsg);
        ASender.Context.Connection.IOHandler.WriteLn('.');
      end;
    end;
  end;
end;

procedure TIdNNTPServer.InitComponent;
begin
  inherited;
  FHelp := TIdStringList.Create;

  FOverviewFormat := TIdStringList.Create;
  with FOverviewFormat do begin
    Add('Subject:');      {do not localize}
    Add('From:');         {do not localize}
    Add('Date:');         {do not localize}
    Add('Message-ID:');   {do not localize}
    Add('References:');   {do not localize}
    Add('Bytes:');        {do not localize}
    Add('Lines:');        {do not localize}
  end;

  FContextClass := TIdNNTPContext;
  FRegularProtPort := IdPORT_NNTP;
  FImplicitTLSProtPort := IdPORT_SNEWS;
  DefaultPort := IdPORT_NNTP;

  (*
  In general, 1xx codes may be ignored or displayed as desired;  code
  200 or 201 is sent upon initial connection to the NNTP server
  depending upon posting permission;  *)
  // TODO: Account for 201 as well. Right now the user can override this if they wish
  Greeting.NumericCode := 200;
  //

  ExceptionReply.NumericCode := 503;
  ExceptionReply.NumericCode := 500;
  ExceptionReply.Text.Text := RSNNTPServerNotRecognized;
end;

destructor TIdNNTPServer.Destroy;
begin
  Sys.FreeAndNil(FOverviewFormat);
  Sys.FreeAndNil(FHelp);
  inherited;
end;

procedure TIdNNTPServer.DoListGroups(AThread: TIdNNTPContext);
begin
  if Assigned(OnListGroups) then begin
    OnListGroups(AThread);
  end;
end;

procedure TIdNNTPServer.DoSelectGroup(AThread: TIdNNTPContext; const AGroup: string; var VMsgCount,
  VMsgFirst, VMsgLast: Integer; var VGroupExists: Boolean);
begin
  VMsgCount := 0;
  VMsgFirst := 0;
  VMsgLast := 0;
  VGroupExists := False;
  if Assigned(OnSelectGroup) then begin
    OnSelectGroup(TIdNNTPContext(AThread), AGroup, VMsgCount, VMsgFirst, VMsgLast, VGroupExists);
  end;
end;

procedure TIdNNTPServer.SetIOHandler(const AValue: TIdServerIOHandler);
//var LIO :  TIdServerIOHandlerSSLBase;
begin
  inherited;
  if IOHandler is  TIdServerIOHandlerSSLBase then
  begin
//    LIO := AValue as TIdSSLIOHandlerSocketBase;
//    LIO.PeerPassthrough := True;
  end
  else
  begin
    ImplicitTLS := False;
  end;
end;

procedure TIdNNTPServer.SetImplicitTLS(const AValue: Boolean);
begin
  if (AValue = FImplicitTLS) then
  begin
    Exit;
  end;
  if (IOHandler is  TIdServerIOHandlerSSLBase) then
  begin
    FImplicitTLS := AValue;
    if AValue then
    begin
      if DefaultPort = IdPORT_NNTP then
      begin
        DefaultPort := IdPORT_SNEWS;
      end;
    end
    else
    begin
      if DefaultPort = IdPORT_SNEWS then
      begin
        DefaultPort := IdPORT_NNTP;
      end;
    end;
  end
  else
  begin
    if AValue then
    begin
      raise EIdNNTPImplicitTLSRequiresSSL.Create( RSNNTPSvrImplicitTLSRequiresSSL );
    end
    else
    begin
      FImplicitTLS := AValue;
    end;
  end;
end;

procedure TIdNNTPServer.CommandSTARTTLS(ASender: TIdCommand);

var LIO : TIdSSLIOHandlerSocketBase;
  LCxt : TIdNNTPContext;
begin
  if (IOHandler is TIdServerIOHandlerSSLBase) and (ImplicitTLS=False) then begin
    if TIdNNTPContext(ASender.Context).UsingTLS then begin // we are already using TLS
      ASender.Reply.NumericCode:=500;                                        // does someone know the response-code?
      Exit;
    end;
    if (ASender.Context as TIdNNTPContext).UsingTLS then
    begin
      ASender.Reply.NumericCode := 580;
    end
    else
    begin
      ASender.Reply.NumericCode := 382;
      ASender.SendReply;
      LIO := ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase;
      LIO.Passthrough := False;
      LCxt := ASender.Context as TIdNNTPContext;
      //reset the connection state as required by http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt
      LCxt.FUserName := '';
      LCxt.FPassword := '';
      LCxt.FAuthenticated := False;
      LCxt.FModeReader := False;
      ASender.Context.Connection.IOHandler.Write(ReplyUnknownCommand.FormattedReply);
    end;
  end else begin
    ASender.Reply.NumericCode:=500;
  end;
end;

procedure TIdNNTPServer.InitializeCommandHandlers;
begin
  inherited;
  with CommandHandlers.Add do begin
    Command := 'ARTICLE'; {do not localize}
    OnCommand := CommandArticle;
    NormalReply.NumericCode := 500;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'AUTHINFO USER'; {do not localize}
    OnCommand := CommandAuthInfoUser;
    NormalReply.NumericCode := 502;
  end;
  with CommandHandlers.Add do begin
    Command := 'AUTHINFO PASS'; {do not localize}
    OnCommand := CommandAuthInfoPassword;
    NormalReply.NumericCode := 502;
  end;
  // TODO: Add AUTHINFO SIMPLE and AUTHINFO GENERIC
  with CommandHandlers.Add do begin
    Command := 'AUTHINFO SIMPLE'; {do not localize}
    NormalReply.NumericCode := 452;
  end;
  with CommandHandlers.Add do begin
    Command := 'AUTHINFO GENERIC';  {do not localize}
    NormalReply.NumericCode := 501;
  end;
  with CommandHandlers.Add do begin
    Command := 'BODY';  {do not localize}
    OnCommand := CommandBody;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'DATE';  {do not localize}
    OnCommand := CommandDate;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'HEAD';  {do not localize}
    OnCommand := CommandHead;
    ParseParams := False;
  end;
  (*
  3.3.  The HELP command

  3.3.1.  HELP

     HELP

     Provides a short summary of commands that are understood by this
     implementation of the server. The help text will be presented as a
     textual response, terminated by a single period on a line by itself.

     3.3.2.  Responses

     100 help text follows
  *)
  with CommandHandlers.Add do begin
    Command := 'HELP';  {do not localize}
    NormalReply.NumericCode := 100;
    if FHelp.Count = 0 then begin
      Response.Add('No help available.'); {do not localize}
    end else begin
      Response.Assign(FHelp);
    end;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'GROUP'; {do not localize}
    OnCommand := CommandGroup;
    NormalReply.NumericCode := 411;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'IHAVE'; {do not localize}
    OnCommand := CommandIHave;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'LAST';  {do not localize}
    OnCommand := CommandLast;
    ParseParams := False;
  end;
  (*
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
  // Before LIST
  with CommandHandlers.Add do begin
    Command := 'LIST Overview.fmt'; {do not localize}
    if OverviewFormat.Count > 0 then begin
      NormalReply.NumericCode := 215;
      Response.Assign(OverviewFormat);
    end else begin
      NormalReply.NumericCode := 503;
    end;
    ParseParams := False;
  end;
  // Before LIST
  //TODO: This needs implemented as events to allow return data
  // RFC 2980 - NNTP Extension
  with CommandHandlers.Add do begin
    Command := 'LIST NEWSGROUPS'; {do not localize}
    //ReplyNormal.NumericCode := 503;
    NormalReply.NumericCode := 215;
    Response.Add('.');
    ParseParams := False;
  end;
    {
  From: http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-17.txt

  }
  with CommandHandlers.Add do begin
    Command := 'LIST EXTENSIONS'; {do not localize}
    OnCommand := CommandListExtensions;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'LIST';  {do not localize}
    OnCommand := CommandList;
    NormalReply.NumericCode := 215;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'LISTGROUP'; {do not localize}
    OnCommand := CommandListGroup;
    ParseParams := False;
  end;

  with CommandHandlers.Add do begin
    Command := 'MODE READER'; {do not localize}
    OnCommand := CommandModeReader;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'NEWGROUPS'; {do not localize}
    OnCommand := CommandNewGroups;
    NormalReply.NumericCode := 231;
  end;
  with CommandHandlers.Add do begin
    Command := 'NEWNEWS'; {do not localize}
    OnCommand := CommandNewNews;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'NEXT';  {do not localize}
    OnCommand := CommandNext;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'POST';  {do not localize}
    OnCommand := CommandPost;
    ParseParams := False;
  end;
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
  with CommandHandlers.Add do begin
    Command := 'QUIT';  {do not localize}
    Disconnect := True;
    NormalReply.NumericCode := 205;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'SLAVE'; {do not localize}
    OnCommand := CommandSlave;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'STAT';  {do not localize}
    OnCommand := CommandStat;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'XHDR';  {do not localize}
    OnCommand := CommandXHdr;
    ParseParams := True;
    NormalReply.NumericCode := 221;
  end;
  with CommandHandlers.Add do begin
    Command := 'HDR'; {do not localize}
    OnCommand := CommandXHdr;
    ParseParams := True;
    NormalReply.NumericCode := 225;
  end;
  with CommandHandlers.Add do begin
    Command := 'XOVER'; {do not localize}
    OnCommand := CommandXOver;
    NormalReply.NumericCode := 244;
    ParseParams := False;
  end;
  //from http://www.ietf.org/internet-drafts/draft-ietf-nntpext-tls-nntp-00.txt
  with CommandHandlers.Add do begin
    Command := 'OVER';  {do not localize}
    OnCommand := CommandXOver;
    NormalReply.NumericCode := 244;
    ParseParams := False;
  end;
  with CommandHandlers.Add do begin
    Command := 'STARTTLS';  {do not localize}
    OnCommand := CommandSTARTTLS;
  end;


  with ReplyTexts do begin
    // 100s
    Add(100, 'help text follows');                                          {do not localize}
    Add(199, 'debug output');                                               {do not localize}

    // 200s
    Add(200, 'server ready - posting allowed');                             {do not localize}
    Add(201, 'server ready - no posting allowed');                          {do not localize}
    Add(202, 'slave status noted');                                         {do not localize}
    Add(205, 'closing connection - goodbye!');                              {do not localize}
    Add(215, 'list of newsgroups follows');                                 {do not localize}
    Add(221, 'Headers follow');                                             {do not localize}
    Add(224, 'Overview information follows');                               {do not localize}
    Add(225, 'Headers follow');                                             {do not localize}
    Add(231, 'list of new newsgroups follows');                             {do not localize}
    Add(235, 'article transferred ok');                                     {do not localize}
    Add(240, 'article posted ok');                                          {do not localize}
    Add(281,'Authentication accepted');                                     {do not localize}

    // 300s
    Add(335, 'send article to be transferred. End with <CR-LF>.<CR-LF>');   {do not localize}
    Add(340, 'send article to be posted. End with <CR-LF>.<CR-LF>');        {do not localize}
    Add(381, 'More authentication information required');                   {do not localize}
    Add(382,'Continue with TLS negotiation');                               {do not localize}

    // 400s
    Add(400, 'service discontinued');                                       {do not localize}
    Add(403, 'TLS temporarily not available');                              {do not localize}
    Add(411, 'no such news group');                                         {do not localize}
    Add(412, 'no newsgroup has been selected');                             {do not localize}
    Add(420, 'no current article has been selected');                       {do not localize}
    Add(421, 'no next article in this group');                              {do not localize}
    Add(422, 'no previous article in this group');                          {do not localize}
    Add(423, 'no such article number in this group');                       {do not localize}
    Add(430, 'no such article found');                                      {do not localize}
    Add(435, 'article not wanted - do not send it');                        {do not localize}
    Add(436, 'transfer failed - try again later');                          {do not localize}
    Add(437, 'article rejected - do not try again.');                       {do not localize}
    Add(440, 'posting not allowed');                                        {do not localize}
    Add(441, 'posting failed');                                             {do not localize}
    Add(450, 'Authorization required for this command');                    {do not localize}
    Add(452, 'Authorization rejected');                                     {do not localize}
    Add(480, 'Authentication required');                                    {do not localize}
    Add(482, 'Authentication rejected');                                    {do not localize}
    Add(483, 'Strong encryption layer is required');                        {do not localize}

    // 500s
    Add(500, 'command not recognized');                                     {do not localize}
    Add(501, 'command syntax error');                                       {do not localize}
    Add(502, 'access restriction or permission denied');                    {do not localize}
    Add(503, 'program fault - command not performed');                      {do not localize}
    Add(580, 'Security layer already active');                              {do not localize}
  end;
end;

function TIdNNTPServer.AuthOk(ASender: TIdCommand): Boolean;
begin
  Result := (Assigned(FOnAuth)) and (TIdNNTPContext(ASender.Context).Authenticated = False);
  if Result then begin
    ASender.Reply.NumericCode := 450;
  end;
end;

function TIdNNTPServer.RawNavigate(AThread: TIdNNTPContext;
  AEvent: TIdNNTPOnMovePointer): String;
var LMsgNo : Integer;
begin
  Result := '';
  LMsgNo := AThread.CurrentArticle;
  if (AThread.CurrentArticle > 0) then
  begin
    AEvent(AThread,LMsgNo,Result);
    if (LMsgNo > 0) and (LMsgNo <> AThread.CurrentArticle) and (Result <> '') then
    begin
      AThread.FCurrentArticle := LMsgNo;
    end;
  end;
end;

procedure TIdNNTPServer.SetHelp(AValue: TIdStrings);
begin
  FHelp.Assign(AValue);
end;

{ TIdNNTPContext }

constructor TIdNNTPContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdThreadList = nil
  );
begin
  inherited Create(AConnection, AYarn, AList);
  FCurrentArticle := 0;
end;

function TIdNNTPContext.GetUsingTLS:boolean;
begin
  Result:=Connection.IOHandler is TIdSSLIOHandlerSocketBase;
  if result then
  begin
    Result:=not TIdSSLIOHandlerSocketBase(Connection.IOHandler).PassThrough;
  end;
end;

procedure TIdNNTPServer.SetOverviewFormat(AValue: TIdStrings);
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
  LThread: TIdNNTPContext;
begin
  if Assigned(FOnAuth) then begin
    if (ASender.Params.Count = 1) then begin
      if SecLayerOk(ASender) then
      begin
        Exit;
      end;
      LThread := TIdNNTPContext(ASender.Context);
      LThread.FPassword := ASender.Params[0];
      FOnAuth(LThread, LThread.FAuthenticated);
      if LThread.FAuthenticated then begin
        ASender.Reply.NumericCode := 281;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandAuthInfoUser(ASender: TIdCommand);
var
  LThread: TIdNNTPContext;
begin
  if Assigned(FOnAuth) then begin
    if (ASender.Params.Count = 1) then begin
      if SecLayerOk(ASender) then
      begin
        Exit;
      end;
      LThread := TIdNNTPContext(ASender.Context);
      LThread.FUsername := ASender.Params[0];
      FOnAuth(LThread, LThread.FAuthenticated);
      if LThread.FAuthenticated then begin
        ASender.Reply.NumericCode := 281;
      end else begin
        ASender.Reply.NumericCode := 381;
      end;
    end;
  end else ASender.Reply.NumericCode := 500;
end;

procedure TIdNNTPServer.CommandListExtensions(ASender: TIdCommand);

begin
  ASender.Reply.SetReply( 202,'Extensions supported:'); {do not localize}
  ASender.SendReply;
  if (IOHandler is TIdServerIOHandlerSSLBase) and (ImplicitTLS=False) then
  begin
    ASender.Context.Connection.IOHandler.WriteLn(' STARTTLS');  {do not localize}
  end;
  if Assigned(OnXover) then
  begin
    ASender.Context.Connection.IOHandler.WriteLn(' OVER');  {do not localize}
  end;
  if Assigned(FOnCheckListGroup) and Assigned(FOnListGroup) then
  begin
    ASender.Context.Connection.IOHandler.WriteLn(' LISTGROUP'); {do not localize}
  end;
  ASender.Context.Connection.IOHandler.WriteLn('.');
end;

function TIdNNTPServer.SecLayerOk(ASender: TIdCommand): Boolean;
begin
  Result := (FUseTLS = utUseRequireTLS) and
    (ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough = True;
  if Result then begin
    ASender.Reply.NumericCode := 483;
  end;
end;

end.
