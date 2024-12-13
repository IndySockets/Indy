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
  Rev 1.21    10/26/2004 10:39:54 PM  JPMugaas
  Updated refs.

  Rev 1.20    5/17/04 9:50:52 AM  RLebeau
  Changed TIdRepliesPOP3 constructor to use 'reintroduce' instead

  Rev 1.19    5/16/04 5:26:58 PM  RLebeau
  Added TIdRepliesPOP3 class

  Rev 1.18    2004.04.15 12:49:46 PM  czhower
  Fixed bug in TIdReplyPOP3.IsEndMarker

  Rev 1.17    2004.02.03 5:45:44 PM  czhower
  Name changes

  Rev 1.16    2004.01.29 12:07:52 AM  czhower
  .Net constructor problem fix.

  Rev 1.15    2004.01.22 5:52:54 PM  czhower
  Visibilty fix + TextIsSame

  Rev 1.14    1/3/2004 8:05:50 PM  JPMugaas
  Bug fix:  Sometimes, replies will appear twice due to the way functionality
  was enherited.

  Rev 1.13    22/12/2003 00:45:58  CCostelloe
  .NET fixes

  Rev 1.12    2003.10.18 9:42:12 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.11    2003.09.20 10:38:40 AM  czhower
  Bug fix to allow clearing code field (Return to default value)

  Rev 1.10    6/8/2003 03:26:00 AM  JPMugaas
  AssignTo added for object assignment.

  Rev 1.9    6/8/2003 02:59:24 AM  JPMugaas
  RFC 2449 and RFC 3206 support.

  Rev 1.8    6/5/2003 04:54:22 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.7    6/4/2003 04:06:52 PM  JPMugaas
  Started preliminary worki on RFC 3206 and RFC 2449.

  Removed an old GetInternetResponse override that is no longer needed and
  causes its own problems.

  Now uses string reply codes using Kudzu's new overloaded methods so mapping
  to integers is no longer needed.  The integers used in mapping have been
  removed.

    Rev 1.6    5/30/2003 9:06:44 PM  BGooijen
  uses CheckIfCodeIsValid now

  Rev 1.5    5/26/2003 04:28:28 PM  JPMugaas
  Removed GenerateReply and ParseResponse calls because those functions are
  being removed.

  Rev 1.4    2003.05.26 10:51:42 PM  czhower
  Removed RFC / non POP3 parsing

  Rev 1.3    5/26/2003 12:22:06 PM  JPMugaas

  Rev 1.2    5/25/2003 02:40:56 AM  JPMugaas

  Rev 1.1    5/20/2003 10:58:28 AM  JPMugaas
  SetReplyExceptionCode now validated by TIdReplyPOP3.  This way, it can only
  accept our integer codes for +OK, -ERR, and +.

  Rev 1.0    5/19/2003 04:28:10 PM  JPMugaas
  TIdReply decendant for POP3.
}

unit IdReplyPOP3;

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdException,
  IdReply;

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
  ST_ERR_SYS_TEMP = 'SYS/TEMP';  {Do not translate}  //system failure - temporary
  ST_ERR_SYS_PERM = 'SYS/PERM'; {Do not translate} //system failure - permenent
  ST_ERR_AUTH = 'AUTH'; {Do not translate}  //authentication credential problem

const
  VALID_ENH_CODES : array[0..4] of string = (
    ST_ERR_IN_USE,
    ST_ERR_LOGIN_DELAY,
    ST_ERR_SYS_PERM,
    ST_ERR_SYS_TEMP,
    ST_ERR_AUTH
  );

type
  TIdReplyPOP3 = class(TIdReply)
  protected
    FEnhancedCode : String;
    //
    class function FindCodeTextDelim(const AText : String) : Integer;
    class function IsValidEnhancedCode(const AText : String; const AStrict : Boolean = False) : Boolean;
    class function ExtractTextPosArray(const AStr : String):Integer;
    function GetFormattedReply: TStrings; override;
    procedure SetFormattedReply(const AValue: TStrings); override;
    function CheckIfCodeIsValid(const ACode: string): Boolean; override;
    procedure SetEnhancedCode(const AValue : String);
  public
    constructor CreateWithReplyTexts(
      ACollection: TCollection = nil;
      AReplyTexts: TIdReplies = nil
      ); override;
    procedure Assign(ASource: TPersistent); override;
    procedure Clear; override;
    procedure RaiseReplyError; override;
    class function IsEndMarker(const ALine: string): Boolean; override;
  published
    property EnhancedCode : String read FEnhancedCode write SetEnhancedCode;
  end;

  TIdRepliesPOP3 = class(TIdReplies)
  public
    constructor Create(AOwner: TPersistent); reintroduce;
  end;

  //This error is for POP3 Protocol reply exceptions
  // SendCmd / GetResponse
  EIdReplyPOP3Error = class(EIdReplyError)
  protected
    FErrorCode : String;
    FEnhancedCode : String;
  public
    constructor CreateError(const AErrorCode: String;
     const AReplyMessage: string; const AEnhancedCode : String = ''); reintroduce; virtual;
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
  IdGlobal,
  IdGlobalProtocols,
  IdResourceStringsProtocols,
  SysUtils;

{ TIdReplyPOP3 }

procedure TIdReplyPOP3.Assign(ASource: TPersistent);
var
  LR: TIdReplyPOP3;
begin
  if ASource is TIdReplyPOP3 then begin
    LR := TIdReplyPOP3(ASource);
    //set code first as it possibly clears the reply
    Code := LR.Code;
    FEnhancedCode := LR.EnhancedCode;
    FText.Assign(LR.Text);
  end else begin
    inherited Assign(ASource);
  end;
end;

function TIdReplyPOP3.CheckIfCodeIsValid(const ACode: string): Boolean;
var
  LOrd: Integer;
begin
  LOrd := PosInStrArray(ACode, VALID_POP3_STR, False);
  Result := (LOrd > -1) or (Trim(ACode) = '');
end;

procedure TIdReplyPOP3.Clear;
begin
  inherited Clear;
  FEnhancedCode := '';
end;

constructor TIdReplyPOP3.CreateWithReplyTexts(ACollection: TCollection = nil; AReplyTexts: TIdReplies = nil);
begin
  inherited CreateWithReplyTexts(ACollection, AReplyTexts);
  FCode := ST_OK;
end;

class function TIdReplyPOP3.ExtractTextPosArray(const AStr: String): Integer;
begin
  Result := PosInStrArray(Copy(AStr, 1, FindCodeTextDelim(AStr) - 1), VALID_POP3_STR, False);
end;

class function TIdReplyPOP3.FindCodeTextDelim(const AText: String): Integer;
var
  LMin, LSpace: Integer;
  LBuf: String;
  LAddBackFlag: Boolean; //if we deleted a begging -, we need to add it back
begin
  LAddBackFlag := False;
  //we do things this way because a line can start with a minus as in
  //-ERR [IN-USE] Mail box in use
  LBuf := AText;
  // TODO: use PosEx() instead, then we can just skip
  // past the '-' without physically removing it...
  if TextStartsWith(LBuf, '-') then begin
    Delete(LBuf, 1, 1);
    LAddBackFlag := True;
  end;
  LMin := IndyPos(' ', LBuf);
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

function TIdReplyPOP3.GetFormattedReply: TStrings;
var
  i: Integer;
begin
  Result := GetFormattedReplyStrings;
  if Code <> '' then begin
    if FText.Count > 0 then begin
      for i := 0 to FText.Count - 1 do begin
        if i < FText.Count - 1 then begin
          if (Code = ST_ERR) and (FEnhancedCode <> '') then begin
            Result.Add(Code + '-' + FEnhancedCode + ' ' + FText[i]);
          end else begin
            Result.Add(Code + '-' + FText[i]);
          end;
        end else begin
          if (Code = ST_ERR) and (FEnhancedCode <> '') then begin
            Result.Add(Code + ' ' + FEnhancedCode + ' ' + FText[i]);
          end else begin
            Result.Add(Code + ' ' + FText[i]);
          end;
        end;
      end;
    end else begin
      Result.Add(Code);
    end;
  end else if FText.Count > 0 then begin
    Result.AddStrings(FText);
  end;
end;

class function TIdReplyPOP3.IsEndMarker(const ALine: string): Boolean;
var
  LPos: Integer;
begin
  Result := False;
  LPos := FindCodeTextDelim(ALine);
  if LPos > 0 then begin
    if LPos > Length(ALine) then begin
      Result := True;
    end else begin
      Result := ALine[LPos] <> '-';
    end;
  end;
end;

class function TIdReplyPOP3.IsValidEnhancedCode(const AText : String; const AStrict : Boolean = False): Boolean;
var
  LBuf : String;
  i : integer;
begin
  Result := Trim(AText) = '';
  if not Result then begin
    LBuf := AText;
    if (LBuf <> '') and TextStartsWith(LBuf, '[') then begin
      Delete(LBuf, 1, 1);
      if (LBuf <> '') and TextEndsWith(LBuf, ']') then begin
        LBuf := Fetch(LBuf, ']');
        if AStrict then begin
          Result := PosInStrArray(LBuf, VALID_ENH_CODES) > -1;
        end else begin
          {We don't use PosInStrArray because we only want the first
          charactors in our string to match.  This is necessary because
          the POP3 enhanced codes will be hierarchical as time goes on.
          }
          for i := Low(VALID_ENH_CODES) to High(VALID_ENH_CODES) do begin
            if TextStartsWith(LBuf, VALID_ENH_CODES[i]) then begin
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
var
  LBuf : String;
begin
  LBuf := AValue;
  if LBuf = '' then begin
    FEnhancedCode := '';
  end else begin
    LBuf := UpperCase(LBuf);
    if (LBuf[1] <> '[') then begin
      LBuf := '[' + LBuf;
    end;
    if (LBuf[Length(LBuf)] <> ']') then begin
      LBuf := LBuf + ']';
    end;
    if IsValidEnhancedCode(LBuf, True) then begin
      FEnhancedCode := LBuf;
    end else begin
      raise EIdPOP3ReplyInvalidEnhancedCode.Create(RSPOP3ReplyInvalidEnhancedCode + AValue);
    end;
  end;
end;

procedure TIdReplyPOP3.SetFormattedReply(const AValue: TStrings);
var
  i: Integer;
  idx : Integer;
  LOrd : Integer;
  LBuf, LEnh : String;
  LText : TStringList;
begin
  Clear;
  if AValue.Count > 0 then begin
    // RLebeau: what is the purpose of this ExtractTextPosArray() shenanigans? Why
    // are we allowing the status code to appear outside of the 1st line? That does
    // not conform to the POP3 protocol spec. Are any servers actually doing this
    // in practice? None of the other TIdReply classes handle this possibility...
    //
    // Note: Microsoft's Outlook365 POP3 server DOES send a greeting WITHOUT a
    // status code if a client connects using implicit TLS 1.0 or 1.1!  That was
    // apparently allowed by RFC 1725, but not anymore by RFC 1939!
    LOrd := ExtractTextPosArray(AValue[0]);
    if LOrd > -1 then begin
      Code := VALID_POP3_STR[LOrd];
    end;
    for i := 0 to AValue.Count - 1 do begin
      if LOrd = -1 then begin
        LOrd := ExtractTextPosArray(AValue[i]);
      end;
      idx := FindCodeTextDelim(AValue[i]);
      LBuf := Copy(AValue[i], idx+1, MaxInt);
      if (Code = ST_ERR) and IsValidEnhancedCode(Fetch(LBuf,' ',False)) then begin
        //don't use EnhancedCode property set method because that does
        //a tighter validation than we should use for parsing replies
        //from a server.
        FEnhancedCode := Fetch(LBuf);
      end;
      Text.Add(LBuf);
    end;
    if LOrd = -1 then begin
      // RLebeau 4/30/2023: warning - TIdReply.SetCode() calls Clear(),
      // which will LOSE any EnhancedCode and Text values already assigned
      // above!  We need to preserve them here. This wouldn't be an issue
      // anymore if we get rid of the ExtractTextPosArray() nonsense above...
      LText := TStringList.Create;
      try
        LText.Assign(Text);
        LEnh := FEnhancedCode;
        Code := ST_ERR;
        Text.Assign(LText);
        FEnhancedCode := LEnh;
      finally
        LText.Free;
      end;
    end;
  end;
end;

{ TIdRepliesPOP3 }

constructor TIdRepliesPOP3.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdReplyPOP3);
end;

{ EIdReplyPOP3Error }

constructor EIdReplyPOP3Error.CreateError(const AErrorCode, AReplyMessage: string;
  const AEnhancedCode : String = '');
begin
  inherited Create(AReplyMessage);
  FErrorCode := AErrorCode;
  FEnhancedCode := AEnhancedCode;
end;

end.
