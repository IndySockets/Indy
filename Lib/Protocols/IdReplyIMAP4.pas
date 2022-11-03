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
  Rev 1.26    3/23/2005 3:01:56 PM  DSiders
  Modified TIdReplyIMAP4.Destroy to call inherited destructor.

  Rev 1.25    20/01/2005 11:02:00  CCostelloe
  Now compiles, also updated to suit change in IdReply

  Rev 1.24    1/19/05 5:21:52 PM  RLebeau
  added Destructor to free the FExtra object

  Removed label from SetFormattedReply()

  Rev 1.23    10/26/2004 10:39:54 PM  JPMugaas
  Updated refs.

    Rev 1.22    6/11/2004 9:38:30 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.21    5/17/04 9:53:00 AM  RLebeau
  Changed TIdRepliesIMAP4 constructor to use 'reintroduce' instead

  Rev 1.20    5/16/04 5:31:24 PM  RLebeau
  Added constructor to TIdRepliesIMAP4 class

  Rev 1.19    03/03/2004 01:16:56  CCostelloe
  Yet another check-in as part of continuing development

  Rev 1.18    26/02/2004 02:02:22  CCostelloe
  A few updates to support IdIMAP4Server development

  Rev 1.17    05/02/2004 00:26:06  CCostelloe
  Changes to support TIdIMAP4Server

  Rev 1.16    2/3/2004 4:12:34 PM  JPMugaas
  Fixed up units so they should compile.

  Rev 1.15    2004.01.29 12:07:52 AM  czhower
  .Net constructor problem fix.

  Rev 1.14    1/3/2004 8:05:48 PM  JPMugaas
  Bug fix:  Sometimes, replies will appear twice due to the way functionality
  was enherited.

  Rev 1.13    22/12/2003 00:45:40  CCostelloe
  .NET fixes

  Rev 1.12    03/12/2003 09:48:34  CCostelloe
  IsItANumber and IsItAValidSequenceNumber made public for use by TIdIMAP4.

  Rev 1.11    28/11/2003 21:02:46  CCostelloe
  Fixes for Courier IMAP

  Rev 1.10    22/10/2003 12:18:06  CCostelloe
  Split out DoesLineHaveExpectedResponse for use by other functions in IdIMAP4.

    Rev 1.9    10/19/2003 5:57:12 PM  DSiders
  Added localization comments.

  Rev 1.8    18/10/2003 22:33:00  CCostelloe
  RemoveUnsolicitedResponses added.

  Rev 1.7    20/09/2003 19:36:42  CCostelloe
  Multiple changes to clear up older issues

  Rev 1.6    2003.09.20 10:38:40 AM  czhower
  Bug fix to allow clearing code field (Return to default value)

  Rev 1.5    18/06/2003 21:57:00  CCostelloe
  Rewrote SetFormattedReply.  Compiles and works.  Needs tidying up, as does
  IdIMAP4.

  Rev 1.4    17/06/2003 01:38:12  CCostelloe
  Updated to suit LoginSASL changes.  Compiles OK.

  Rev 1.3    15/06/2003 08:41:48  CCostelloe
  Bug fix: i was undefined in SetFormattedReply in posted version, changed to LN

  Rev 1.2    12/06/2003 10:26:14  CCostelloe
  Unfinished but compiles.  Checked in to show problem with Get/SetNumericCode.

  Rev 1.1    6/5/2003 04:54:26 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.0    5/27/2003 03:03:54 AM  JPMugaas

  2003-Sep-26: CC2: Added Extra property.

  2003-Oct-18: CC3: Added RemoveUnsolicitedResponses function.

  2003-Nov-28: CC4: Fixes for Courier IMAP server.
}

unit IdReplyIMAP4;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdReply,
  IdReplyRFC;

const
  IMAP_OK      = 'OK';      {Do not Localize}
  IMAP_NO      = 'NO';      {Do not Localize}
  IMAP_BAD     = 'BAD';     {Do not Localize}
  IMAP_PREAUTH = 'PREAUTH'; {Do not Localize}
  IMAP_BYE     = 'BYE';     {Do not Localize}
  IMAP_CONT    = '+';       {Do not Localize}

  VALID_TAGGEDREPLIES : array [0..5] of string =
    (IMAP_OK, IMAP_NO, IMAP_BAD, IMAP_PREAUTH, IMAP_BYE, IMAP_CONT);

type
  TIdReplyIMAP4 = class(TIdReply)
  protected
    {CC: A tagged IMAP response is 'C41 OK Completed', where C41 is the
    command sequence number identifying the command you sent to get that
    response.  An untagged one is '* OK Bad parameter'.  The codes are
    the same, some just start with *.
    FSequenceNumber is either a *, C41 or '' (if the response line starts with
    a valid response code like OK)...}
    FSequenceNumber: string;
    {IMAP servers can send extra info after a command like "BAD Bad parameter".
    Keep these for error messages (may be more than one).
    Unsolicited responses from the server will also be put here.}
    FExtra: TStrings;
    function GetExtra: TStrings;  //Added to get over .NET not calling TIdReplyIMAP4's constructor
    {You would think that we need to override IdReply's Get/SetNumericCode
    because they assume the code is like '32' whereas IMAP codes are text like
    'OK' (when IdReply's StrToIntDef always returns 0), but Indy 10 has switched
    from numeric codes to string codes (i.e. we use 'OK' and never a
    numeric equivalent like 4).}
    {function GetNumericCode: Integer;
    procedure SetNumericCode(const AValue: Integer);}
    {Get/SetFormattedReply need to be overriden for IMAP4}
    function GetFormattedReply: TStrings; override;
    procedure SetFormattedReply(const AValue: TStrings); override;
    {CC: Need this also, otherwise the virtual one in IdReply uses
    TIdReplyRFC.CheckIfCodeIsValid which will only convert numeric
    codes like '22' to integer 22.}
    function CheckIfCodeIsValid(const ACode: string): Boolean; override;
    procedure AssignTo(ADest: TPersistent); override;
  public
    constructor CreateWithReplyTexts(
      ACollection: TCollection = nil;
      AReplyTexts: TIdReplies = nil
      ); override;
    destructor Destroy; override;
    procedure Clear; override;
    //
    //CLIENT-SIDE (TIdIMAP4) FUNCTIONS...
    procedure RaiseReplyError; override;
    procedure DoReplyError(ADescription: string; AnOffendingLine: string = ''); reintroduce;
    procedure RemoveUnsolicitedResponses(AExpectedResponses: array of String);
    function DoesLineHaveExpectedResponse(ALine: string; AExpectedResponses: array of string): Boolean;
    {CC: The following decides if AValue is a valid command sequence number
    like C41...}
    function IsItAValidSequenceNumber(const AValue: string): Boolean;
    //
    //SERVER-SIDE (TIdIMAP4Server) FUNCTIONS...
    function ParseRequest(ARequest: string): Boolean;
    //
    property NumericCode: Integer read GetNumericCode write SetNumericCode;
    property Extra: TStrings read GetExtra;
    property SequenceNumber: string read FSequenceNumber;
    //
  end;

  TIdRepliesIMAP4 = class(TIdReplies)
  public
    constructor Create(AOwner: TPersistent); reintroduce;
  end;

  //This error method came from the POP3 Protocol reply exceptions
  // SendCmd / GetResponse
  EIdReplyIMAP4Error = class(EIdReplyError);

implementation

uses
  IdGlobal, IdGlobalProtocols, SysUtils;

{ TIdReplyIMAP4 }

procedure TIdReplyIMAP4.AssignTo(ADest: TPersistent);
var
  LR: TIdReplyIMAP4;
begin
  if ADest is TIdReplyIMAP4 then begin
    LR := TIdReplyIMAP4(ADest);
    //set code first as it possibly clears the reply
    LR.Code := Code;
    LR.FSequenceNumber := SequenceNumber;
    LR.Extra.Assign(Extra);
    LR.Text.Assign(Text);
  end else begin
    inherited AssignTo(ADest);
  end;
end;

function TIdReplyIMAP4.ParseRequest(ARequest: string): Boolean;
begin
  FSequenceNumber := Fetch(ARequest);
  Result := IsItAValidSequenceNumber(FSequenceNumber);
end;

function TIdReplyIMAP4.GetExtra: TStrings;
begin
  if not Assigned(FExtra) then begin
    FExtra := TStringList.Create;
  end;
  Result := FExtra;
end;

constructor TIdReplyIMAP4.CreateWithReplyTexts(
  ACollection: TCollection = nil;
  AReplyTexts: TIdReplies = nil
  );
begin
  inherited CreateWithReplyTexts(ACollection, AReplyTexts);
  FExtra := TStringList.Create;
  Clear;
end;

destructor TIdReplyIMAP4.Destroy;
begin
  FreeAndNil(FExtra);
  inherited Destroy;
end;

procedure TIdReplyIMAP4.Clear;
begin
  inherited Clear;
  FSequenceNumber := '';
  Extra.Clear;
end;

procedure TIdReplyIMAP4.RaiseReplyError;
begin
  raise EIdReplyIMAP4Error.Create(Extra.Text); {do not localize}
end;

{CC: The following decides if AValue is a valid command sequence number like C41...}
function TIdReplyIMAP4.IsItAValidSequenceNumber(const AValue: string): Boolean;
begin
  {CC: Cannot be a C or a digit on its own...}
  {CC: Must start with a C...}
  if (Length(AValue) >= 2) and CharEquals(AValue, 1, 'C') then begin
    {CC: Check if other characters are digits...}
    Result := IsNumeric(AValue, -1, 2);
  end else begin
    Result := False;
  end;
end;

function TIdReplyIMAP4.CheckIfCodeIsValid(const ACode: string): Boolean;
var
  LOrd : Integer;
begin
  LOrd := PosInStrArray(ACode, VALID_TAGGEDREPLIES, False);
  Result := (LOrd <> -1) or (Trim(ACode) = '');
end;

function TIdReplyIMAP4.GetFormattedReply: TStrings;
begin
  {Used by TIdIMAP4Server to assemble a string reply from our fields...}
  FFormattedReply.Clear;
  Result := FFormattedReply;
end;

{CC: AValue may be in one of a few formats:
1) Many commands just give a simple result to the command issued:
    C41 OK Completed
2) Some commands give you data first, then the result:
    * LIST (\UnMarked) "/" INBOX
    * LIST (\UnMarked) "/" Junk
    * LIST (\UnMarked) "/" Junk/Subbox1
    C42 OK Completed
3) Some responses have a result but * instead of a command number (like C42):
    * OK CommuniGate Pro IMAP Server 3.5.7 ready
4) Some have neither a * nor command number, but start with a result:
    + Send the additional command text
or:
    BAD Bad parameter

Because you may get data first, which you need to put into Text, you need to
accept all the above possibilities.

In this function, we can assume that the last line of AValues has previously been
identified (by GetResponse).

For the Text parameter, data lines are added with the starting * stripped off.
The last Text line is the response line (the OK, BAD, etc., line) with any *
and response (OK, BAD) stripped out - this is usually just Completed or the
error message.

Set FSequenceNumber to C41 for cases (1) and (2) above, * for case (3), and
empty '' for case 4.  This tells the caller the context of the reply.
}
procedure TIdReplyIMAP4.SetFormattedReply(const AValue: TStrings);
var
  LWord: string;
  LPos: integer;
  LBuf : String;
  LN: integer;
  LLine: string;
begin
  Clear;
  LWord := '';
  if AValue.Count <= 0 then begin
    {Throw an exception.  Something is badly messed up if we were called with
    an empty string list.}
    DoReplyError('Unexpected: Logic error, SetFormattedReply called with an empty list of parameters');  {do not localize}
  end;
  {CC: Any lines before the last one should be data lines, which begin with a * ...}
  for LN := 0 to AValue.Count - 2 do begin
    LLine := AValue[LN];
    if LLine <> '' then begin
      LWord := Trim(Fetch(LLine));
      LLine := Trim(LLine);
      if (LLine = '') then begin
        {Throw an exception: this line is a single word, not a valid data
        line since it does not have a * plus at least one word of data.}
        DoReplyError('Unexpected: Non-last response line (i.e. a data line) only contained one word, instead of a * followed by one or more words', AValue[LN]); {do not localize}
      end;
      if (LWord <> '*') then begin {Do not Localize}
        //Throw an exception: No * as first word of a data line.
        DoReplyError('Unexpected: Non-last response line (i.e. a data line) did not start with a *', AValue[LN]);  {do not localize}
      end;
      Text.Add(LLine);
    end;
  end;
  {The response (OK, BAD, etc.) is in the LAST line received (or else the
  function that got the response, such as GetResponse, is broken).}
  LLine := AValue[AValue.Count-1];
  if LLine = '' then begin
    {Throw an exception: The previous function (GetResponse, or whatever)
    messed up and passed an empty line as the response (last) line...}
    DoReplyError('Unexpected: Response (last) line was empty instead of containing a line with a response code like OK, NO, BAD, etc');  {do not localize}
  end;
  LBuf := LLine;
  LWord := Trim(Fetch(LBuf));
  LBuf := Trim(LBuf);
  {We can assume, if the previous function (GetResponse) did its
  job, that either the first or the second word (if it exists) is the
  response code...}
  LPos := PosInStrArray(LWord, VALID_TAGGEDREPLIES); {Do not Localize}
  if LPos > -1 then begin
    {The first word is a valid response.  Leave FSequenceNumber as ''
    because there was nothing before it.}
    FCode := LWord;
    Text.Add(LBuf);
  end
  else if LWord = '*' then begin  {Do not Localize}
    if LBuf = '' then begin
      {Throw an exception: it is a line that is just '*'}
      DoReplyError('Unexpected: Response (last) line contained only a *'); {do not localize}
    end;
    FSequenceNumber := LWord;   {Record that it is a * line}
    {The next word had better be a response...}
    LWord := Trim(Fetch(LBuf));
    LBuf := Trim(LBuf);
    if (LBuf = '') then begin
      {Should never get to here: LBuf should have been ''.  Might as
      well throw an exception since we are down here anyway.}
      DoReplyError('Unexpected: Response (last) line contained only a * (type 2)');  {do not localize}
    end;
    LPos := PosInStrArray(LWord, VALID_TAGGEDREPLIES);
    if LPos = -1 then begin
      {A line beginning with * but no valid response code as the 2nd
      word.  It is invalid, but maybe a data line that GetResponse
      missed.  Throw an exception anyway.}
      DoReplyError('Unexpected: Response (last) line started with a * but next word was not a valid response like OK, BAD, etc', LLine); {do not localize}
    end;
    {A valid resonse code...}
    FCode := LWord;
    Text.Add(LBuf);
  end
  else if IsItAValidSequenceNumber(LWord) then begin
    if LBuf = '' then begin
      {Throw an exception: it is a line that is just 'C41' or whatever}
      DoReplyError('Unexpected: Response (last) line started with a command reference (like C41) but nothing else', LLine);  {do not localize}
    end;
    FSequenceNumber := LWord;   {Record that it is a C41 line}
    {The next word had better be a response...}
    LWord := Trim(Fetch(LBuf));
    LBuf := Trim(LBuf);
    if LBuf = '' then begin
      {Should never get to here: LBuf should have been ''.  Might as
      well throw an exception since we are down here anyway.}
      DoReplyError('Unexpected: Logic error, line starts with a command reference (like C41) but nothing else, why was an exception not thrown earlier?', LLine);  {do not localize}
    end;
    LPos := PosInStrArray(LWord, VALID_TAGGEDREPLIES);
    if LPos = -1 then begin
      {A line beginning with C41 but no valid response code as the 2nd
      word.  Throw an exception.}
      DoReplyError('Unexpected: Line starts with a command reference (like C41) but next word was not a valid response like OK, BAD, etc', LLine); {do not localize}
    end;
    {A valid response code...}
    FCode := LWord;
    //CC4: LBuf will contain "SEARCH completed" if LLine was "C64 OK SEARCH completed".
    //Ditch LBuf, otherwise we will confuse the later parser that checks for
    //"expected response" keywords.
    Extra.Add(LBuf);
  end
  else begin
    {Not a response, * or command (e.g. C41).  Throw an exception, as usual.}
    DoReplyError('Unexpected: Line does not start with a command reference (like C41), a *, or a valid response like OK, BAD, etc', LLine);  {do not localize}
  end;
  if FCode = '' then begin
    {Did not get a valid response line, copy ALL of the last line we received
    into Text[] for error display.  This is paranoid programming, we probably
    would have thrown an exception by now.}
    Text.Add(AValue[AValue.Count-1]);
  end;
end;

{CC3: This goes through the lines in Text and moves any that are not "expected" into
Extra.  Lines that are "expected" are those that have a command in one of the
strings in AExpectedResponses, which has entries like "FETCH", "UID", "LIST".
Unsolicited responses are typically lines like "* RECENT 3", which are sent by
the server to tell you that new messages arrived.  The problem is that they can
be anywhere in a reply from the server, the RFC does not stipulate where, or
what their format may be, but they wont be expected by the caller and will cause
the caller's parsing to fail.
The Text variable also has the bits stripped off from the final response, i.e.
it will have "Completed" as the last entry, stripped from "C62 OK Completed".}
procedure TIdReplyIMAP4.RemoveUnsolicitedResponses(AExpectedResponses: array of String);
var
  LLine: string;
  LN, LIndex: integer;
  LLast: integer;  {Need to calculate this outside the loop}
begin
  {The (valid) lines are of one of two formats:
  * LIST BlahBlah
  * 53 FETCH BlahBlah
  The "53" arises with commands that reference a specific email, the server returns
  the relative message number in that case.
  Note the * has been stripped off before this procedure is called.}
  LLast := Text.Count-1;
  LIndex := 0;
  for LN := 0 to LLast do begin
    LLine := Text[LIndex];
    if LLine = '' then begin
      {Unlikely to happen, but paranoia is always a better approach...}
      Text.Delete(LIndex);
    end
    else begin
      if DoesLineHaveExpectedResponse(LLine, AExpectedResponses) then begin
        {We were expecting this word, so don't remove this line.}
        Inc(LIndex);
        Continue;
      end;
      {We were not expecting this response, it is an unsolicited response or
      something else we are not interested in.  Transfer the UNSTRIPPED
      line to Extra (i.e. not LLine).}
      Extra.Add(Text[LIndex]);
      Text.Delete(LIndex);
    end;
  end;
end;

function TIdReplyIMAP4.DoesLineHaveExpectedResponse(ALine: string; AExpectedResponses: array of string): Boolean;
var
  LWord: string;
  LPos: integer;
begin
  Result := False;
  {Get the first word, it may be a relative message number like "53".
  CC4: Note the line may only consist of a single word, e.g. "SEARCH" with some
  servers (e.g. Courier) where there were no matches to the search.}
  LPos := Pos(' ', ALine); {Do not Localize}
  if LPos > 0 then begin
    if IsNumeric(ALine, LPos-1) then begin
      ALine := Copy(ALine, LPos+1, MaxInt);
    end;
    {If there was a relative message number, it is now stripped from LLine.}
    {The first word in LLine is the one that may hold our expected response.}
    LPos := Pos(' ', ALine);    {Do not Localize}
    if LPos > 0 then begin
      LWord := Copy(ALine, 1, LPos-1);
    end else begin
      LWord := ALine;
    end;
  end else begin
    LWord := ALine;
  end;
  if PosInStrArray(LWord, AExpectedResponses) > -1 then begin
    {We were expecting this word...}
    Result := True;
  end;
end;

procedure TIdReplyIMAP4.DoReplyError(ADescription: string; AnOffendingLine: string);
var
  LMsg: string;
begin
  LMsg := ADescription;
  if AnOffendingLine <> '' then begin
    LMsg := LMsg + ', offending line: ' + AnOffendingLine;  {do not localize}
  end;
  raise EIdReplyIMAP4Error.Create(LMsg);
end;

{ TIdRepliesIMAP4 }

constructor TIdRepliesIMAP4.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdReplyIMAP4);
end;

end.

