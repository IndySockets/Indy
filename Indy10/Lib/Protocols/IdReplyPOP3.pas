{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  19169: IdReplyPOP3.pas 
{
{   Rev 1.21    10/26/2004 10:39:54 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.20    5/17/04 9:50:52 AM  RLebeau
{ Changed TIdRepliesPOP3 constructor to use 'reintroduce' instead
}
{
{   Rev 1.19    5/16/04 5:26:58 PM  RLebeau
{ Added TIdRepliesPOP3 class
}
{
{   Rev 1.18    2004.04.15 12:49:46 PM  czhower
{ Fixed bug in TIdReplyPOP3.IsEndMarker
}
{
{   Rev 1.17    2004.02.03 5:45:44 PM  czhower
{ Name changes
}
{
{   Rev 1.16    2004.01.29 12:07:52 AM  czhower
{ .Net constructor problem fix.
}
{
{   Rev 1.15    2004.01.22 5:52:54 PM  czhower
{ Visibilty fix + TextIsSame
}
{
{   Rev 1.14    1/3/2004 8:05:50 PM  JPMugaas
{ Bug fix:  Sometimes, replies will appear twice due to the way functionality
{ was enherited.
}
{
{   Rev 1.13    22/12/2003 00:45:58  CCostelloe
{ .NET fixes
}
{
{   Rev 1.12    2003.10.18 9:42:12 PM  czhower
{ Boatload of bug fixes to command handlers.
}
{
{   Rev 1.11    2003.09.20 10:38:40 AM  czhower
{ Bug fix to allow clearing code field (Return to default value)
}
{
{   Rev 1.10    6/8/2003 03:26:00 AM  JPMugaas
{ AssignTo added for object assignment.
}
{
{   Rev 1.9    6/8/2003 02:59:24 AM  JPMugaas
{ RFC 2449 and RFC 3206 support.
}
{
{   Rev 1.8    6/5/2003 04:54:22 AM  JPMugaas
{ Reworkings and minor changes for new Reply exception framework.
}
{
{   Rev 1.7    6/4/2003 04:06:52 PM  JPMugaas
{ Started preliminary worki on RFC 3206 and RFC 2449.   
{ 
{ Removed an old GetInternetResponse override that is no longer needed and
{ causes its own problems.
{ 
{ Now uses string reply codes using Kudzu's new overloaded methods so mapping
{ to integers is no longer needed.  The integers used in mapping have been
{ removed.
}
{
    Rev 1.6    5/30/2003 9:06:44 PM  BGooijen
  uses CheckIfCodeIsValid now
}
{
{   Rev 1.5    5/26/2003 04:28:28 PM  JPMugaas
{ Removed GenerateReply and ParseResponse calls because those functions are
{ being removed. 
}
{
{   Rev 1.4    2003.05.26 10:51:42 PM  czhower
{ Removed RFC / non POP3 parsing
}
{
{   Rev 1.3    5/26/2003 12:22:06 PM  JPMugaas
}
{
{   Rev 1.2    5/25/2003 02:40:56 AM  JPMugaas
}
{
{   Rev 1.1    5/20/2003 10:58:28 AM  JPMugaas
{ SetReplyExceptionCode now validated by TIdReplyPOP3.  This way, it can only
{ accept our integer codes for +OK, -ERR, and +.
}
{
{   Rev 1.0    5/19/2003 04:28:10 PM  JPMugaas
{ TIdReply decendant for POP3.
}
unit IdReplyPOP3;

interface

uses
  IdReply,
  IdException,
  IdSys,
  IdObjs;

const
  {do not change these strings unless you know what you are doing}
  ST_OK = '+OK';    {Do not translate}
  ST_ERR = '-ERR';   {Do not translate}
  ST_SASLCONTINUE = '+';  {Do not translate}

  //note that for extended codes, we do not put the ] ending as
  //error code may be hierarchical in the future with a / separating levels
  // RFC 2449
  ST_ERR_IN_USE = 'IN-USE';     {Do not translate}  //already in use by another program
  ST_ERR_LOGIN_DELAY = 'LOGIN-DELAY';  {Do not translate}  //login delay time
  // RFC 3206
  ST_ERR_SYS_TEMP = 'SYS/PERM';  {Do not translate}  //system failure - permenent
  ST_ERR_SYS_PERM = 'SYS/TEMP'; {Do not translate} //system failure - temporary
  ST_ERR_AUTH = 'AUTH'; {Do not translate}  //authentication credential problem

const
  VALID_ENH_CODES : array[0..4] of string = (
    ST_ERR_IN_USE,
    ST_ERR_LOGIN_DELAY,
    ST_ERR_SYS_TEMP,
    ST_ERR_SYS_PERM,
    ST_ERR_AUTH
  );

type
  TIdReplyPOP3 = class(TIdReply)
  protected
    FEnhancedCode : String;
    //
    procedure AssignTo(ADest: TIdPersistent); override;
    class function FindCodeTextDelin(const AText : String) : Integer;
    class function IsValidEnhancedCode(const AText : String; const AStrict : Boolean=False) : Boolean;
    class function ExtractTextPosArray(const AStr : String):Integer;
    function GetFormattedReply: TIdStrings; override;
    procedure SetFormattedReply(const AValue: TIdStrings); override;
    function CheckIfCodeIsValid(const ACode: string): Boolean; override;
    procedure SetEnhancedCode(const AValue : String);
  public
    constructor Create(
      ACollection: TIdCollection = nil;
      AReplyTexts: TIdReplies = nil
      ); override;
    destructor Destroy; override;
    procedure RaiseReplyError; override;
    class function IsEndMarker(const ALine: string): Boolean; override;
  published
    property EnhancedCode : String read FEnhancedCode write SetEnhancedCode;
  end;

  TIdRepliesPOP3 = class(TIdReplies)
  public
    constructor Create(AOwner: TIdPersistent); reintroduce;
  end;

  //This error is for POP3 Protocol reply exceptions
  // SendCmd / GetResponse
  EIdReplyPOP3Error = class(EIdReplyError)
  protected
    FErrorCode : String;
    FEnhancedCode : String;
  public
    constructor CreateError(const AErrorCode: String;
     const AReplyMessage: string; const AEnhancedCode : String=''); reintroduce; virtual;
    property ErrorCode : String read FErrorCode;
    property EnhancedCode : String read FEnhancedCode;
  end;

const
  VALID_POP3_STR : Array [0..2] of String = (
     ST_OK,
     ST_ERR,
     ST_SASLCONTINUE);

type
  EIdPOP3ReplyException = class(EIdException);
  EIdPOP3ReplyInvalidEnhancedCode = class(EIdPOP3ReplyException);

implementation

uses
  IdGlobal, IdGlobalProtocols, IdResourceStringsProtocols;

{ TIdReplyPOP3 }

procedure TIdReplyPOP3.AssignTo(ADest: TIdPersistent);
var
  LR: TIdReplyPOP3;
begin

  if ADest is TIdReplyPOP3 then begin
    LR := TIdReplyPOP3(ADest);
    LR.Code := Code;
    LR.FEnhancedCode := EnhancedCode;
    LR.Text.Assign(Text);
  end
  else
  begin
    inherited;
  end;

end;

function TIdReplyPOP3.CheckIfCodeIsValid(const ACode: string): Boolean;
var
  LOrd: Integer;
begin
  LOrd := PosInStrArray(ACode,VALID_POP3_STR, False);
  Result := (LOrd <> -1) or (Sys.Trim(ACode) = '');
end;

constructor TIdReplyPOP3.Create(
      ACollection: TIdCollection = nil;
      AReplyTexts: TIdReplies = nil
      );
begin
  inherited;
  FCode := ST_OK;
end;

destructor TIdReplyPOP3.Destroy;
begin
  inherited;
end;

class function TIdReplyPOP3.ExtractTextPosArray(const AStr: String): Integer;
begin
  Result := PosInStrArray(Copy(AStr,1, Self.FindCodeTextDelin(AStr) - 1)
   ,VALID_POP3_STR,False);
end;

class function TIdReplyPOP3.FindCodeTextDelin(const AText: String): Integer;
var
  LMin, LSpace: Integer;
  LBuf: String;
  LAddBackFlag: Boolean; //if we deleted a begging -, we need to add it back
begin
  LAddBackFlag := False;
  //we do things this way because a line can start with a minus as in
  //-ERR [IN-USE] Mail box in use
  LBuf := AText;
  if Copy(LBuf, 1, 1) = '-' then begin
    Delete(LBuf, 1, 1);
    LAddBackFlag := True;
  end;
  LMin := IndyPos(' ',LBuf);
  LSpace := IndyPos('-', LBuf);
  if LMin > 0 then begin
    if (LSpace <> 0) and (LMin > LSpace) then begin
      Result := LSpace;
    end else begin
      Result := LMin;
    end;
  end else begin
    if LSpace <> 0 then begin
      Result := LSpace;
    end else begin
      Result := Length(AText) + 1;
    end;
  end;
  if LAddBackFlag then begin
    Inc(Result);
  end;
end;

function TIdReplyPOP3.GetFormattedReply: TIdStrings;
var
  i: Integer;
begin
  Result := GetFormattedReplyStrings;
  if Code <> '' then begin
    if FText.Count > 0 then begin
      for i := 0 to FText.Count - 1 do begin
        if i < FText.Count - 1 then begin
          if (Code=ST_ERR) and (FEnhancedCode <> '') then
          begin
            Result.Add( Code + '-' + FEnhancedCode + ' '+FText[i]);
          end
          else
          begin
            Result.Add( Code + '-' + FText[i]);
          end;
        end else begin
          if (Code=ST_ERR) and (FEnhancedCode <> '') then
          begin
            Result.Add( Code + ' ' + Self.EnhancedCode + ' '+FText[i]);
          end
          else
          begin
            Result.Add( Code + ' ' + FText[i]);
          end;
        end;
      end;
    end else begin
      Result.Add( Code);
    end;
  end else if FText.Count > 0 then begin
    Result.AddStrings( FText);
  end;
end;

class function TIdReplyPOP3.IsEndMarker(const ALine: string): Boolean;
var
  LPos: Integer;
begin
  Result := False;
  LPos := FindCodeTextDelin(ALine);
  if LPos > 0 then begin
    if LPos > Length(ALine) then begin
      Result := True
    end else begin
      Result := ALine[LPos] <> '-';
    end;
  end;
end;

class function TIdReplyPOP3.IsValidEnhancedCode(const AText : String; const AStrict : Boolean=False): Boolean;
var LBuf : String;
  i : integer;
begin
  Result := (Sys.Trim(AText) = '');
  if not Result then begin
    LBuf := AText;
    if (LBuf<>'') and (LBuf[1]='[') then begin
      Delete(LBuf,1,1);
      if (LBuf<>'') and (LBuf[Length(LBuf)]=']') then begin
        LBuf := Fetch(LBuf,']');
        if AStrict then begin
          Result := (PosInStrArray(LBuf,VALID_ENH_CODES)>-1);
        end else begin
          {We don't use PosInStrArray because we only want the fist
          charactors in our string to match.  This is necessary because
          the POP3 enhanced codes will be hierarchical as time goes on.
          }
          for i := Low( VALID_ENH_CODES ) to High(VALID_ENH_CODES) do
          begin
            if TextIsSame(Copy(LBuf,1,Length(VALID_ENH_CODES[i])), VALID_ENH_CODES[i]) then begin
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TIdReplyPOP3.RaiseReplyError;
begin
  raise EIdReplyPOP3Error.CreateError(Code, Text.Text);
end;

procedure TIdReplyPOP3.SetEnhancedCode(const AValue: String);
var LBuf : String;
begin
  LBuf := AValue;
  if LBuf = '' then
  begin
    FEnhancedCode := '';
  end
  else
  begin
    LBuf := Sys.UpperCase(LBuf);
    if (LBuf[1]<>'[') then
    begin
      LBuf := '['+LBuf;
    end;
    if (LBuf[Length(LBuf)]<>']') then
    begin
      LBuf := LBuf + ']';
    end;
    if IsValidEnhancedCode(LBuf,True) then
    begin
      FEnhancedCode := LBuf;
    end
    else
    begin
      raise EIdPOP3ReplyInvalidEnhancedCode.Create(RSPOP3ReplyInvalidEnhancedCode+AValue);
    end;
  end;
end;

procedure TIdReplyPOP3.SetFormattedReply(const AValue: TIdStrings);
var
  i: Integer;
  idx : Integer;
  LOrd : Integer;
  LBuf : String;
begin
  Clear;
  if AValue.Count > 0 then begin
    LOrd := ExtractTextPosArray(AValue[0]);

    if LOrd>-1 then
    begin
      Code := VALID_POP3_STR[LOrd];
    end;
    for i := 0 to AValue.Count - 1 do begin
      if LOrd = -1 then
      begin
        LOrd := ExtractTextPosArray(AValue[i]);
      end;
      idx := FindCodeTextDelin(AValue[i]);
      LBuf := Copy(AValue[i], idx+1, MaxInt);
      if (Code = ST_ERR) and(IsValidEnhancedCode(Fetch(LBuf,' ',False))) then
      begin
        //don't use EnhancedCode property set method because that does
        //a tighter validation than we should use for parsing replies
        //from a server.
        FEnhancedCode := Fetch(LBuf);
      end;
      Text.Add(LBuf);
    end;
    if LOrd = -1 then
    begin
      Code := ST_ERR;
    end;
  end;
end;

{ TIdRepliesPOP3 }

constructor TIdRepliesPOP3.Create(AOwner: TIdPersistent);
begin
  inherited Create(AOwner, TIdReplyPOP3);
end;

{ EIdReplyPOP3Error }

constructor EIdReplyPOP3Error.CreateError(const AErrorCode,
  AReplyMessage: string; const AEnhancedCode : String='');
begin
  inherited Create(AReplyMessage);
  FErrorCode := AErrorCode;
  FEnhancedCode := AEnhancedCode;
end;

end.
