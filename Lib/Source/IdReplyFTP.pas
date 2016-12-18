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
  Rev 1.15    2/8/05 6:09:56 PM  RLebeau
  Updated GetFormattedReply() to call Sys.IntToStr() only once.

  Rev 1.14    10/26/2004 10:39:54 PM  JPMugaas
  Updated refs.

  Rev 1.13    8/8/04 12:28:04 AM  RLebeau
  Bug fix for SetFormattedReply() to better conform to RFC 959

  Rev 1.12    6/20/2004 8:30:28 PM  JPMugaas
  TIdReply was ignoring Formatted Output in some strings used in output.

  Rev 1.11    5/18/04 2:42:30 PM  RLebeau
  Changed TIdRepliesFTP to derive from TIdRepliesRFC, and changed constructor
  back to using 'override'

  Rev 1.10    5/17/04 9:52:36 AM  RLebeau
  Changed TIdRepliesFTP constructor to use 'reintroduce' instead

  Rev 1.9    5/16/04 5:27:56 PM  RLebeau
  Added TIdRepliesFTP class

  Rev 1.8    2004.02.03 5:45:46 PM  czhower
  Name changes

  Rev 1.7    2004.01.29 12:07:52 AM  czhower
  .Net constructor problem fix.

  Rev 1.6    1/20/2004 10:03:26 AM  JPMugaas
  Fixed a problem with a server where there was a line with only one " ".  It
  was throwing things off.  Fixed by checking to see if a line <4 chars is
  actually a number.

  Rev 1.5    1/3/2004 8:05:46 PM  JPMugaas
  Bug fix:  Sometimes, replies will appear twice due to the way functionality
  was enherited.

  Rev 1.4    10/26/2003 04:25:46 PM  JPMugaas
  Fixed a bug where a line such as:

  "     Version wu-2.6.2-11.73.1" would be considered the end of a command
  response.

  Rev 1.3    2003.10.18 9:42:12 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.2    2003.09.20 10:38:38 AM  czhower
  Bug fix to allow clearing code field (Return to default value)

    Rev 1.1    5/30/2003 9:23:44 PM  BGooijen
  Changed TextCode to Code

  Rev 1.0    5/26/2003 12:21:10 PM  JPMugaas
}

unit IdReplyFTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdReply,
  IdReplyRFC;

type
  TIdReplyRFCFormat = (rfNormal, rfIndentMidLines);

const
  DEF_ReplyFormat = rfNormal;

type
  TIdReplyFTP = class(TIdReplyRFC)
  protected
    FReplyFormat : TIdReplyRFCFormat;
    function GetFormattedReply: TStrings; override;
    procedure SetFormattedReply(const AValue: TStrings); override;
    procedure AssignTo(ADest: TPersistent); override;
  public
    constructor CreateWithReplyTexts(ACollection: TCollection = nil; AReplyTexts: TIdReplies = nil); override;
    procedure Clear; override;
    procedure RaiseReplyError; override;
    class function IsEndMarker(const ALine: string): Boolean; override;
    class function IsEndReply(const AReplyCode, ALine: string): Boolean;
  published
    property ReplyFormat : TIdReplyRFCFormat read FReplyFormat write FReplyFormat default DEF_ReplyFormat;
  end;

  TIdRepliesFTP = class(TIdRepliesRFC)
  public
    constructor Create(AOwner: TPersistent); override;
  end;

  EIdFTPServiceNotAvailable = class(EIdReplyRFCError);

implementation

uses
  IdException,
  IdGlobal, SysUtils;

{ TIdReplyFTP }

procedure TIdReplyFTP.AssignTo(ADest: TPersistent);
var
  LR: TIdReplyFTP;
begin
  if ADest is TIdReplyFTP then begin
    LR := TIdReplyFTP(ADest);
    //set code first as it possibly clears the reply
    LR.NumericCode := NumericCode;
    LR.ReplyFormat := ReplyFormat;
    LR.Text.Assign(Text);
  end else begin
    inherited AssignTo(ADest);
  end;
end;

constructor TIdReplyFTP.CreateWithReplyTexts(ACollection: TCollection = nil; AReplyTexts: TIdReplies = nil);
begin
  inherited CreateWithReplyTexts(ACollection, AReplyTexts);
  FReplyFormat := DEF_ReplyFormat;
end;

procedure TIdReplyFTP.Clear;
begin
  inherited Clear;
 // FReplyFormat := DEF_ReplyFormat;
end;

function TIdReplyFTP.GetFormattedReply: TStrings;
var
  i : Integer;
  LCode: String;
begin
  Result := GetFormattedReplyStrings;
  if NumericCode > 0 then begin
    LCode := IntToStr(NumericCode);
    if Text.Count > 0 then begin
      for i := 0 to Text.Count - 1 do begin
        if i < Text.Count - 1 then begin
          if FReplyFormat = rfIndentMidLines then begin
            if i = 0 then begin
              Result.Add(LCode + '-' + Text[i]);
            end else begin
              Result.Add(' ' + Text[i]);
            end;
          end else begin
            Result.Add(LCode + '-' + Text[i]);
          end;
        end else begin
          Result.Add(LCode + ' ' + Text[i]);
        end;
      end;
    end else begin
      Result.Add(LCode + ' ');
    end;
  end else if Text.Count > 0 then begin
    Result.AddStrings(Text);
  end;
end;

class function TIdReplyFTP.IsEndMarker(const ALine: string): Boolean;
begin
  // Use copy not ALine[4] as it might not be long enough for that reference
  // to be valid

  // RLebeau 03/09/2009: noticed a Microsoft FTP server send multi-line
  // text that had a "+44" at the beginning of a line.  That threw off
  // IdGlobal.IsNumeric(String) because the compiler's Val() did not
  // report an error for it.  We will use the overloaded version of
  // IdGlobal.IsNumeric() now so that each character is validated
  // individually to prevent that from happening again.

  {
  Result := (Length(ALine) < 4) and IsNumeric(ALine);
  if Result then begin
    //"     Version wu-2.6.2-11.73.1"  is not a end of reply
    //"211 End of status" is the end of a reply
    Result := IsNumeric(ALine, 3) and CharEquals(ALine, 4, ' ');
  end;
  }

  Result := (Length(ALine) >= 3) and IsNumeric(ALine, 3);
  if Result then begin
    Result := (Length(ALine) = 3) or CharEquals(ALine, 4, ' ');
  end;
end;

class function TIdReplyFTP.IsEndReply(const AReplyCode, ALine: string): Boolean;
begin
  Result := IsEndMarker(ALine) and TextIsSame(Copy(ALine, 1, 3), AReplyCode);
end;

procedure TIdReplyFTP.SetFormattedReply(const AValue: TStrings);
var
  i: Integer;
  LCode, LTemp: string;
begin
  Clear;
  if AValue.Count > 0 then begin
    // Get 4 chars - for POP3
    LCode := Trim(Copy(AValue[0], 1, 4));
    if CharEquals(LCode, 4, '-') then begin {do not localize}
      SetLength(LCode, 3);
    end;
    Code := LCode;
    Text.Add(Copy(AValue[0], Length(LCode)+2, MaxInt));
    FReplyFormat := rfNormal;
    if AValue.Count > 1 then begin
      for i := 1 to AValue.Count - 1 do begin
        // RLebeau - RFC 959 does not require the response code
        // to be prepended to every line like with other protocols.
        // Most FTP servers do this, but not all of them do, so
        // check here for that possibility ...
        if TextStartsWith(AValue[i], LCode) then begin
          LTemp := Copy(AValue[i], Length(LCode)+2, MaxInt);
        end else begin
          if TextStartsWith(AValue[i], ' ') then begin
            FReplyFormat := rfIndentMidLines;
          end;
          LTemp := TrimLeft(AValue[i]);
        end;
        Text.Add(LTemp);
      end;
    end;
  end;
end;

procedure TIdReplyFTP.RaiseReplyError;
begin
  // any FTP command can return a 421 reply if the server is going to
  // shut down the command connection...
  if NumericCode = 421 then begin
    raise EIdFTPServiceNotAvailable.CreateError(NumericCode, Text.Text);
  end else begin
    inherited;
  end;
end;

{ TIdRepliesFTP }

constructor TIdRepliesFTP.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdReplyFTP);
end;

end.
