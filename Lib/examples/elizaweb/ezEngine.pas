{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  21828: EZEngine.pas 

   Rev 1.0    2003.07.13 12:12:02 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 2:54:00 PM  czhower
}
unit EZEngine;

interface
{$ifdef fpc}
{$mode objfpc}{$H+}
{$endif}
{
ELIZA -- an interactive parroting

Original Source: CREATIVE COMPUTING - MORRISTOWN, NEW JERSEY, late 1970's

Converted from Basic and some language called Inform to Delphi by
  Chad Z. Hower aka Kudzu in 2002 - email: chad at hower dot org
  Converted to objects, and implementation rewritten from scratch. Logic matched as best possible
  but BASIC code also had bugs in logic. Inform version also differed slightly, but probaly more
  accurate, but I am no Inform expert.

  Since that time I have made several custom modifications an improvements including the addition
  of personalities.

Note:
  Because of the conversion from older languages, this is not my best code.
  Slowly over time I am cleaning it up to make it more proper OO code. I am also
  expanding its capabilities beyond its original design.
}

uses
  Classes,
  ezPersonality;

type
  TEZEngine = class(TComponent)
  protected
    FConjugations: TStrings;
    FDone: Boolean;
    FLastMsg: string;
    FPersonality: TEZPersonality;
    //
    procedure InitConjugations;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetPersonality(const AName: string);
    function TalkTo(AMsg: string): string; overload;
    function TalkTo(AMsg: string; var VSound: string): string; overload;
    //
    property Done: Boolean read FDone;
    property Personality: TEZPersonality read FPersonality;
  end;

implementation

uses
  SysUtils, StrUtils;

{ TEZEngine }

constructor TEZEngine.Create(AOwner: TComponent);
begin
  inherited;
  FConjugations := TStringList.Create;
  InitConjugations;
end;

destructor TEZEngine.Destroy;
begin
  FreeAndNil(FPersonality);
  FreeAndNil(FConjugations);
  inherited;
end;

procedure TEZEngine.InitConjugations;
begin
  with FConjugations do begin
    Add('Are=am');
    Add('Were=was');
    Add('You=I');
    Add('Your=my');
    Add('I''ve=you''ve');
    Add('I''m=you''re');
    Add('Me=you');
  end;
end;

procedure TEZEngine.SetPersonality(const AName: string);
begin
  FreeAndNil(FPersonality);
  FPersonality := TEZPersonality.ConstructPersonality(AName);
end;

function TEZEngine.TalkTo(AMsg: string; var VSound: string): string;
var
  i, j: Integer;
  s: string;
  LConj: string;
  LFoundKeyword: string;
  LFoundKeywordIdx: Integer;
  LFoundKeywordPos: Integer;
  LKeyword: string;
  LWordIn: string;
  LWordOut: string;
begin
  VSound := '';
  if FPersonality = nil then begin
     raise Exception.Create('No personality has been specified.');
  end;
  Result := '';
  LConj := '';
  LFoundKeyword := '';
  LFoundKeywordIdx := FPersonality.Keywords.IndexOf('--NOKEYFOUND--');
  LFoundKeywordPos := 0;
  //
  AMsg := '  ' + Trim(AMsg) + '  ';
  AMsg := StringReplace(AMsg, '''', '', [rfReplaceAll]);
  // TODO: Respond to ones with ?
  // Replace with spaces so ' bug ' will match ' bug. ' etc.
  AMsg := StringReplace(AMsg, '?', ' ', [rfReplaceAll]);
  AMsg := StringReplace(AMsg, '!', ' ', [rfReplaceAll]);
  AMsg := StringReplace(AMsg, '.', ' ', [rfReplaceAll]);
  if AnsiSameText(AMsg, FLastMsg) then begin
    Result := 'Please don''t repeat yourself.';
  end else if AnsiContainsText(AMsg, 'SHUT ') then begin
    Result := 'How would you like it if I told you to shut up? I am sorry but we cannot continue'
     + ' like this. Good bye.';
    FDone := True;
  end else if Trim(AMsg) = '' then begin
    Result := 'I cannot help you if you do not talk to me.';
  end else begin
    FLastMsg := AMsg;
    // Find Keyword
    for i := 0 to FPersonality.Keywords.Count - 1 do begin
      LKeyword := FPersonality.Keywords[i];
      for j := 1 to Length(AMsg) - Length(LKeyword) + 1 do begin
        if AnsiSameText(Copy(AMsg, j, Length(LKeyword)), LKeyword) then begin
          LFoundKeywordIdx := i;
          LFoundKeyword := LKeyword;
          LFoundKeywordPos := j;
          Break;
        end;
        // Break out of second loop
        if LFoundKeyword <> '' then begin
          Break;
        end;
      end;
    end;
    // Take part of string and conjugate it using the list of strings to be swapped
    LConj := ' ' + RightStr(AMsg, Length(AMsg) - Length(LFoundKeyword) - LFoundKeywordPos + 1)
     + ' ';
    for i := 0 to FConjugations.Count - 1 do begin
      LWordIn := FConjugations.Names[i];
      LWordOut := FConjugations.Values[LWordIn] + ' ';
      LWordIn := LWordIn + ' ';
      LConj := StringReplace(LConj, LWordIn, LWordOut, [rfReplaceAll, rfIgnoreCase]);
    end;
    // Only one space
    if Copy(LConj, 1, 1) = ' ' then begin
      Delete(LConj, 1, 1);
    end;
    LConj := StringReplace(LConj, '!', '', [rfReplaceAll]);
    // Get reply
    s := TEZReply(FPersonality.Keywords.Objects[LFoundKeywordIdx]).NextText;
    VSound := TEZReply(FPersonality.Keywords.Objects[LFoundKeywordIdx]).Sound;
    if AnsiPos('*', s) = 0 then begin
      Result := s;
    end else if Trim(LConj) = '' then begin
      Result := 'You will have to elaborate more for me to help you.';
    end else begin
      Result := StringReplace(s, '*', LConj, [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
end;

function TEZEngine.TalkTo(AMsg: string): string;
var
  LSound: string;
begin
  Result := TalkTo(AMsg, LSound);
end;

end.
