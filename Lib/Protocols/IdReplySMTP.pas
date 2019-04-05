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
  Rev 1.24    10/26/2004 10:39:54 PM  JPMugaas
  Updated refs.

  Rev 1.23    10/4/2004 3:16:44 PM  BGooijen
  Added constructor

  Rev 1.22    8/3/2004 11:49:56 AM  JPMugaas
  Fix for issue where 2.0.0 was always being set even if it should not have
  been set.

  Rev 1.21    7/27/2004 7:18:20 PM  JPMugaas
  Fixed the TIdReplySMTP object as per Bas's suggestion.  He told me that we
  were overriding the wrong object.

  I also fixed the Assign so it will work properly.

  Rev 1.20    7/24/04 1:04:48 PM  RLebeau
  Bug fix for TIdReplySMTP.AssignTo(). The logic was backwards

  Rev 1.19    5/31/04 12:47:02 PM  RLebeau
  Bug fixes for TIdSMTPEnhancedCode.AssignTo() and TIdReplySMTP.AssignTo()

  Rev 1.18    5/18/04 2:39:52 PM  RLebeau
  Changed TIdRepliesSMTP constructor back to using 'override'

  Rev 1.17    5/18/04 11:21:54 AM  RLebeau
  Changed TIdRepliesSMTP constructor to use 'reintroduce' instead

  Rev 1.16    5/16/04 5:27:32 PM  RLebeau
  Added TIdRepliesSMTP class

  Rev 1.15    2004.02.03 5:45:44 PM  czhower
  Name changes

  Rev 1.14    2004.01.29 12:07:54 AM  czhower
  .Net constructor problem fix.

  Rev 1.13    2004.01.23 10:09:54 PM  czhower
  REmoved unneded check because of CharIsInSet functinoalty. Also was a short
  circuit which is not permitted.

  Rev 1.12    1/22/2004 4:23:02 PM  JPMugaas
  Undid a set change that didn't work.

  Rev 1.11    1/22/2004 4:51:40 PM  SPerry
  fixed set problems

  Rev 1.10    1/3/2004 8:05:54 PM  JPMugaas
  Bug fix:  Sometimes, replies will appear twice due to the way functionality
  was enherited.

  Rev 1.9    2003.10.18 9:42:14 PM  czhower
  Boatload of bug fixes to command handlers.

    Rev 1.8    10/17/2003 12:58:54 AM  DSiders
  Added localization comments.

  Rev 1.7    2003.09.20 10:38:42 AM  czhower
  Bug fix to allow clearing code field (Return to default value)

  Rev 1.6    6/5/2003 04:54:24 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

    Rev 1.5    5/30/2003 8:46:28 PM  BGooijen

  Rev 1.4    5/26/2003 12:22:08 PM  JPMugaas

  Rev 1.3    5/25/2003 03:45:16 AM  JPMugaas

  Rev 1.2    5/25/2003 02:46:16 AM  JPMugaas

  Rev 1.1    5/23/2003 04:52:30 AM  JPMugaas
  Work started on TIdDirectSMTP to support enhanced error codes.

  Rev 1.0    5/22/2003 05:24:52 PM  JPMugaas
  RFC 2034 descendant of TIdRFCReply for IdSMTP.  This also includes some
  extended error code constants.
}

unit IdReplySMTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdException,
  IdReply,
  IdReplyRFC;

const
  ValidClassChars = '245';
  ValidClassVals = [2,4,5];
  CLASS_DEF = 2;
  AVAIL_DEF = False;
  NODETAILS = 0;
  PARTSEP = '.';

type
  TIdSMTPEnhancedCode = class(TPersistent)
  protected
    FStatusClass : UInt32;
    FSubject : UInt32;
    FDetails : UInt32;
    FAvailable : Boolean;
    procedure AssignTo(ADest: TPersistent); override;
    function IsValidReplyCode(const AText : String) : Boolean;
    function GetReplyAsStr : String;
    procedure SetReplyAsStr(const AText : String);
    procedure SetStatusClass(const AValue: UInt32);
    procedure SetAvailable(const AValue: Boolean);
  public
    constructor Create;
  published
    property StatusClass : UInt32 read FStatusClass write SetStatusClass default CLASS_DEF;
    property Subject : UInt32 read FSubject write FSubject default NODETAILS;
    property Details : UInt32 read FDetails write FDetails default NODETAILS;
    property Available : Boolean read FAvailable write SetAvailable default AVAIL_DEF;
    property ReplyAsStr : String read GetReplyAsStr write SetReplyAsStr;
  end;

  TIdReplySMTP = class(TIdReplyRFC)
  protected
    FEnhancedCode : TIdSMTPEnhancedCode;
    procedure AssignTo(ADest: TPersistent); override;
    procedure SetEnhancedCode(AValue : TIdSMTPEnhancedCode);
    function GetFormattedReply: TStrings; override;
    procedure SetFormattedReply(const AValue: TStrings); override;
  public
    constructor Create(ACollection: TCollection); overload; override;
    constructor CreateWithReplyTexts(ACollection: TCollection; AReplyTexts: TIdReplies); overload; override;
    destructor Destroy; override;
    procedure RaiseReplyError; override;
    procedure SetEnhReply(const ANumericCode : Integer; const AEnhReply, AText : String);
  published
    property EnhancedCode : TIdSMTPEnhancedCode read FEnhancedCode write SetEnhancedCode;
  end;

  TIdRepliesSMTP = class(TIdRepliesRFC)
  public
    constructor Create(AOwner: TPersistent); override;
  end;

  //note that this is here so we don't have to put this unit in an implementaiton clause
  //and both TIdSMTP and TIdDirectSMTP share this.
  EIdSMTPReplyError = class(EIdReplyRFCError)
  protected
    FEnhancedCode : TIdSMTPEnhancedCode;
  public
     constructor CreateError(const AErrCode: Integer;
      AEnhanced : TIdSMTPEnhancedCode;
      const AReplyMessage: string);  reintroduce;
     destructor Destroy; override;
     property EnhancedCode : TIdSMTPEnhancedCode read FEnhancedCode;
   end;

type
  EIdSMTPReply = class(EIdException);
  EIdSMTPReplyInvalidReplyString = class(EIdSMTPReply);
  EIdSMTPReplyInvalidClass = class(EIdSMTPReply);

//suggested extended replies
const
//{ From RFC 3463 Enhanced Mail System Status Codes
  Id_EHR_USE_STARTTLS = '5.7.0'; //required by RFC 2487   {do not localize}
//X.0.0 Other undefined Status
  Id_EHR_GENERIC_OK = '2.0.0';                            {do not localize}
  Id_EHR_GENERIC_TRANS = '4.0.0';                         {do not localize}
  Id_EHR_GENERIC_PERM  = '5.0.0';                         {do not localize}
  //X.1.0 Other address status
  Id_EHR_MSG_OTH_OK = '2.1.0';                            {do not localize}
  Id_EHR_MSG_OTH_TRANS = '4.1.0';                         {do not localize}
  Id_EHR_MSG_OTH_PERM = '5.1.0';                          {do not localize}
  //X.1.1 Bad destination mailbox address
  Id_EHR_MSG_BAD_DEST = '5.1.1';                          {do not localize}
  //X.1.2 Bad destination system address
  Id_EHR_MSG_BAD_DEST_SYST = '5.1.2';                     {do not localize}
  //X.1.3 Bad destination mailbox address syntax
  Id_EHR_MSG_BAD_DEST_SYNTAX = '5.1.3';                   {do not localize}
  //X.1.4 Destination mailbox address ambiguous
  Id_EHR_MSG_AMBIG_DEST = '5.1.4';                        {do not localize}
  //X.1.5 Destination address valid
  Id_EHR_MSG_VALID_DEST = '2.1.5';                        {do not localize}
  //X.1.6 Destination mailbox has moved, No forwarding address
  Id_EHR_MSG_DEST_MOVED_NOFORWARD = '2.1.6';              {do not localize}
  //X.1.7 Bad sender’s mailbox address syntax
  Id_EHR_MSG_SENDER_BOX_SYNTAX = '5.1.7';                 {do not localize}
  //X.1.8 Bad sender’s system address
  Id_EHR_MSG_BAD_SENDER_ADDR = '5.1.8';                   {do not localize}
  //X.2.0 Other or undefined mailbox status
  Id_EHR_MB_OTHER_STATUS_OK = '2.2.0';                    {do not localize}
  Id_EHR_MB_OTHER_STATUS_TRANS = '4.2.0';                 {do not localize}
  Id_EHR_MB_OTHER_STATUS_PERM = '5.2.0';                  {do not localize}
  //X.2.1 Mailbox disabled, not accepting messages
  Id_EHR_MB_DISABLED_TEMP = '4.2.1';                      {do not localize}
  Id_EHR_MB_DISABLED_PERM = '5.2.1';                      {do not localize}
  //X.2.2 Mailbox full - user can probably delete some messages to make more room
  Id_EHR_MB_FULL = '4.2.2';                               {do not localize}
  //X.2.3 Message length exceeds administrative limit - probably can not be fixed by a user deleting messages
  Id_EHR_MB_MSG_LEN_LIMIT = '5.2.3';                      {do not localize}
  //X.2.4 Mailing list expansion problem
  Id_EHR_MB_ML_EXPAN_TEMP = '4.2.4';                      {do not localize}
  Id_EHR_MB_ML_EXPAN_PERM = '5.2.4';                      {do not localize}
  //X.3.0 Other or undefined mail system status
  Id_EHR_MD_OTHER_OK = '2.3.0';                           {do not localize}
  Id_EHR_MD_OTHER_TRANS = '4.3.0';                        {do not localize}
  Id_EHR_MD_OTHER_PERM = '5.3.0';                         {do not localize}
  //X.3.1 Mail system full
  Id_EHR_MD_MAIL_SYSTEM_FULL = '4.3.1';                   {do not localize}
  //X.3.2 System not accepting network messages
  Id_EHR_MD_NOT_EXCEPTING_TRANS = '4.3.2';                {do not localize}
  Id_EHR_MD_NOT_EXCEPTING_PERM = '5.3.2';                 {do not localize}
  //X.3.3 System not capable of selected features
  Id_EHR_MD_NOT_CAPABLE_FEAT_TRANS = '4.3.3';             {do not localize}
  Id_EHR_MD_NOT_CAPABLE_FEAT_PERM = '5.3.3';              {do not localize}
  //X.3.4 Message too big for system
  Id_EHR_MD_TOO_BIG = '5.3.4';                            {do not localize}
  //X.3.5 System incorrectly configured
  Id_EHR_MD_INCORRECT_CONFIG_TRANS = '4.3.5';             {do not localize}
  Id_EHR_MD_INCORRECT_CONFIG_PERM = '5.3.5';              {do not localize}
  //X.4.0 Other or undefined network or routing status
  Id_EHR_NR_OTHER_OK = '2.4.0';                           {do not localize}
  Id_EHR_NR_OTHER_TRANS = '4.4.0';                        {do not localize}
  Id_EHR_NR_OTHER_PERM = '5.4.0';                         {do not localize}
  //X.4.1 No answer from host
  Id_EHR_NR_NO_ANSWER = '4.4.1';                          {do not localize}
  //X.4.2 Bad connection
  Id_EHR_NR_BAD_CONNECTION = '4.4.2';                     {do not localize}
  //X.4.3 Directory server failure
  Id_EHR_NR_DIR_SVR_FAILURE = '4.4.3';                    {do not localize}
  //X.4.4 Unable to route
  Id_EHR_NR_UNABLE_TO_ROUTE_TRANS = '4.4.4';              {do not localize}
  Id_EHR_NR_UNABLE_TO_ROUTE_PERM = '5.4.4';               {do not localize}
  //X.4.5 Mail system congestion
  Id_EHR_NR_SYSTEM_CONGESTION = '4.4.5';                  {do not localize}
  //X.4.6 Routing loop detected
  Id_EHR_NR_LOOP_DETECTED = '4.4.6';                      {do not localize}
  //X.4.7 Delivery time expired
  Id_EHR_NR_DELIVERY_EXPIRED_TEMP = '4.4.7';              {do not localize}
  Id_EHR_NR_DELIVERY_EXPIRED_PERM = '5.4.7';              {do not localize}
   //X.5.0 Other or undefined protocol status
   Id_EHR_PR_OTHER_OK = '2.5.0';                          {do not localize}
   Id_EHR_PR_OTHER_TEMP = '4.5.0';                        {do not localize}
   Id_EHR_PR_OTHER_PERM = '5.5.0';                        {do not localize}
   //X.5.1 Invalid command
   Id_EHR_PR_INVALID_CMD = '5.5.1';                       {do not localize}
   //X.5.2 Syntax error
   Id_EHR_PR_SYNTAX_ERR = '5.5.2';                        {do not localize}
    //X.5.3 Too many recipients - note that this is given if segmentation isn't possible
   Id_EHR_PR_TOO_MANY_RECIPIENTS_TEMP = '4.5.3';          {do not localize}
   Id_EHR_PR_TOO_MANY_RECIPIENTS_PERM = '5.5.3';          {do not localize}
   //X.5.4 Invalid command arguments
   Id_EHR_PR_INVALID_CMD_ARGS = '5.5.4';                  {do not localize}
   //X.5.5 Wrong protocol version
   Id_EHR_PR_WRONG_VER_TRANS = '4.5.5';                   {do not localize}
   Id_EHR_PR_WRONG_VER_PERM = '5.5.5';                    {do not localize}
   //X.6.0 Other or undefined media error
   Id_EHR_MED_OTHER_OK = '2.6.0';                         {do not localize}
   Id_EHR_MED_OTHER_TRANS = '4.6.0';                      {do not localize}
   Id_EHR_MED_OTHER_PERM = '5.6.0';                       {do not localize}
   //X.6.1 Media not supported
   Id_EHR_MED_NOT_SUPPORTED = '5.6.1';                    {do not localize}
   //6.2 Conversion required and prohibited
   Id_EHR_MED_CONV_REQUIRED_PROHIB_TRANS = '4.6.2';       {do not localize}
   Id_EHR_MED_CONV_REQUIRED_PROHIB_PERM = '5.6.2';        {do not localize}
   //X.6.3 Conversion required but not supported
   Id_EHR_MED_CONV_REQUIRED_NOT_SUP_TRANS = '4.6.3';      {do not localize}
   Id_EHR_MED_CONV_REQUIRED_NOT_SUP_PERM = '5.6.3';       {do not localize}
   //X.6.4 Conversion with loss performed
   Id_EHR_MED_CONV_LOSS_WARNING = '2.6.4';                {do not localize}
   Id_EHR_MED_CONV_LOSS_ERROR = '5.6.4';                  {do not localize}
   //X.6.5 Conversion Failed
   Id_EHR_MED_CONV_FAILED_TRANS = '4.6.5';                {do not localize}
   Id_EHR_MED_CONV_FAILED_PERM = '5.6.5';                 {do not localize}
   //X.7.0 Other or undefined security status
   Id_EHR_SEC_OTHER_OK = '2.7.0';                         {do not localize}
   Id_EHR_SEC_OTHER_TRANS = '4.7.0';                      {do not localize}
   Id_EHR_SEC_OTHER_PERM = '5.7.0';                       {do not localize}
   //X.7.1 Delivery not authorized, message refused
   Id_EHR_SEC_DEL_NOT_AUTH = '5.7.1';                     {do not localize}
   //X.7.2 Mailing list expansion prohibited
   Id_EHR_SEC_EXP_NOT_AUTH = '5.7.2';                     {do not localize}
   //X.7.3 Security conversion required but not possible
   Id_EHR_SEC_CONV_REQ_NOT_POSSIBLE = '5.7.3';            {do not localize}
   //X.7.4 Security features not supported
   Id_EHR_SEC_NOT_SUPPORTED = '5.7.4';                    {do not localize}
   //X.7.5 Cryptographic failure
   Id_EHR_SEC_CRYPT_FAILURE_TRANS = '4.7.5';              {do not localize}
   Id_EHR_SEC_CRYPT_FAILURE_PERM = '5.7.5';               {do not localize}
   //X.7.6 Cryptographic algorithm not supported
   Id_EHR_SEC_CRYPT_ALG_NOT_SUP_TRANS = '4.7.6';          {do not localize}
   Id_EHR_SEC_CRYPT_ALG_NOT_SUP_PERM = '5.7.6';           {do not localize}
   //X.7.7 Message integrity failure
   Id_EHR_SEC_INTEGRETIY_FAILED_WARN = '2.7.7';           {do not localize}
   Id_EHR_SEC_INTEGRETIY_FAILED_TRANS = '4.7.7';          {do not localize}

implementation

uses
  IdGlobalProtocols, IdResourceStringsProtocols, SysUtils;

{ TIdSMTPEnhancedCode }

procedure TIdSMTPEnhancedCode.AssignTo(ADest: TPersistent);
var
  LE : TIdSMTPEnhancedCode;
begin
  if ADest is TIdSMTPEnhancedCode then
  begin
    LE := TIdSMTPEnhancedCode(ADest);
    LE.StatusClass := FStatusClass;
    LE.Subject := FSubject;
    LE.Details := FDetails;
    LE.Available := FAvailable;
  end else begin
    inherited AssignTo(ADest);
  end;
end;

constructor TIdSMTPEnhancedCode.Create;
begin
  inherited Create;
  FStatusClass := CLASS_DEF;
  FSubject := NODETAILS;
  FDetails := NODETAILS;
  FAvailable := AVAIL_DEF;
end;

function TIdSMTPEnhancedCode.GetReplyAsStr: String;
begin
  Result := '';
  if Available then begin
    Result := Copy(IntToStr(FStatusClass),1,1)+PARTSEP+
      Copy(IntToStr(FSubject),1,3)+PARTSEP+
      Copy(IntToStr(FDetails),1,3);
  end;
end;

function TIdSMTPEnhancedCode.IsValidReplyCode(const AText: String): Boolean;
var
  LTmp, LBuf, LValidPart : String;
begin
  Result := (Trim(AText) = '');
  if not Result then begin
    LTmp := AText;
    LBuf := Fetch(LTmp);
    //class
    LValidPart := Fetch(LBuf,PARTSEP);
    if CharIsInSet(LValidPart, 1, ValidClassChars) then begin
      //subject
      LValidPart := Fetch(LBuf,PARTSEP);
      if (LValidPart<>'') and IsNumeric(LValidPart) then begin
        //details
        Result := (LBuf<>'') and IsNumeric(LBuf);
      end;
    end;
  end;
end;

procedure TIdSMTPEnhancedCode.SetAvailable(const AValue: Boolean);
begin
  if FAvailable <> AValue then
  begin
    FAvailable := AValue;
    if not AValue then
    begin
      FStatusClass := CLASS_DEF;
      FSubject := NODETAILS;
      FDetails := NODETAILS;
    end;
  end;
end;

procedure TIdSMTPEnhancedCode.SetReplyAsStr(const AText: String);
var
  LTmp, LBuf: string;
  LValidPart: string;
begin
  if not IsValidReplyCode(AText) then begin
    raise EIdSMTPReplyInvalidReplyString.Create(RSSMTPReplyInvalidReplyStr);
  end;
  LTmp := AText;
  LBuf := Fetch(LTmp);
  if LBuf <> '' then begin
    //class
    LValidPart := Fetch(LBuf, PARTSEP);
    FStatusClass := IndyStrToInt(LValidPart, 0);
    //subject
    LValidPart := Fetch(LBuf, PARTSEP);
    FSubject := IndyStrToInt(LValidPart,0);
    //details
    FDetails := IndyStrToInt(LBuf,0);
    FAvailable := True;
  end else begin
    FAvailable := False;
  end;
end;

procedure TIdSMTPEnhancedCode.SetStatusClass(const AValue: UInt32);
begin
  if not (AValue in ValidClassVals) then begin
    raise EIdSMTPReplyInvalidClass.Create(RSSMTPReplyInvalidClass);
  end;
  FStatusClass := AValue;
end;

{ TIdReplySMTP }

procedure TIdReplySMTP.AssignTo(ADest: TPersistent);
var
  LS : TIdReplySMTP;
begin
  if ADest is TIdReplySMTP then begin
    LS := TIdReplySMTP(ADest);
    //set code first as it possibly clears the reply
    LS.Code := Code;
    LS.EnhancedCode := EnhancedCode;
    LS.Text.Assign(Text);
  end else begin
    inherited AssignTo(ADest);
  end;
end;

constructor TIdReplySMTP.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FEnhancedCode := TIdSMTPEnhancedCode.Create;
end;

constructor TIdReplySMTP.CreateWithReplyTexts(ACollection: TCollection; AReplyTexts: TIdReplies);
begin
  inherited CreateWithReplyTexts(ACollection, AReplyTexts);
  FEnhancedCode := TIdSMTPEnhancedCode.Create;
end;

destructor TIdReplySMTP.Destroy;
begin
  FreeAndNil(FEnhancedCode);
  inherited;
end;

function TIdReplySMTP.GetFormattedReply: TStrings;
var
  i: Integer;
  LCode: String;
begin
  Result := GetFormattedReplyStrings;
{  JP here read from Items and format according to the reply, in this case RFC
  and put it into FFormattedReply   }

  if NumericCode > 0 then begin
    LCode := IntToStr(NumericCode);
    if FText.Count > 0 then begin
      for i := 0 to FText.Count - 1 do begin
        if i < FText.Count - 1 then begin
          if EnhancedCode.Available then begin
            Result.Add(LCode + '-' + EnhancedCode.ReplyAsStr + ' ' + FText[i]);
          end else begin
            Result.Add(LCode + '-' + FText[i]);
          end;
        end else begin
          if EnhancedCode.Available then begin
            Result.Add(LCode + ' ' + EnhancedCode.ReplyAsStr + ' ' + FText[i]);
          end else begin
            Result.Add(LCode + ' ' + FText[i]);
          end;
        end;
      end;
    end else begin
      if EnhancedCode.Available then begin
        Result.Add(LCode + ' ' + EnhancedCode.ReplyAsStr);
      end else begin
        Result.Add(LCode);
      end;
    end;
  end else if FText.Count > 0 then begin
    Result.AddStrings(FText);
  end;
end;

procedure TIdReplySMTP.RaiseReplyError;
begin
  raise EIdSMTPReplyError.CreateError(NumericCode, FEnhancedCode, Text.Text);
end;

procedure TIdReplySMTP.SetEnhancedCode(AValue: TIdSMTPEnhancedCode);
begin
  FEnhancedCode.Assign(AValue);
end;

procedure TIdReplySMTP.SetEnhReply(const ANumericCode: Integer;
  const AEnhReply, AText: String);
begin
  inherited SetReply(ANumericCode, AText);
  FEnhancedCode.ReplyAsStr := AEnhReply;
end;

procedure TIdReplySMTP.SetFormattedReply(const AValue: TStrings);
{  in here just parse and put in items, no need to store after parse }
 var
  i: Integer;
  s: string;
begin
  Clear;
  if AValue.Count > 0 then begin
    // Get 4 chars - for POP3
    s := Trim(Copy(AValue[0], 1, 4));
    if Length(s) = 4 then begin
      if s[4] = '-' then begin
        SetLength(s, 3);
      end;
    end;
    Code := s;
    for i := 0 to AValue.Count - 1 do begin
      s := Copy(AValue[i], 5, MaxInt);
      if FEnhancedCode.IsValidReplyCode(s) then begin
        FEnhancedCode.ReplyAsStr := Fetch(s);
      end;
      Text.Add(s);
    end;
  end;
end;

{ TIdRepliesSMTP }

constructor TIdRepliesSMTP.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdReplySMTP);
end;

{ EIdSMTPReplyError }

constructor EIdSMTPReplyError.CreateError(const AErrCode: Integer;
  AEnhanced: TIdSMTPEnhancedCode; const AReplyMessage: string);
begin
  inherited CreateError(AErrCode,AReplyMessage);
  FEnhancedCode := TIdSMTPEnhancedCode.Create;
  FEnhancedCode.Assign(AEnhanced);
end;

destructor EIdSMTPReplyError.Destroy;
begin
  FreeAndNil(FEnhancedCode);
  inherited Destroy;
end;

end.
