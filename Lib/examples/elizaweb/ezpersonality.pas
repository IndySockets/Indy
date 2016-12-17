{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{
 $Log:  21834: EZPersonality.pas 

   Rev 1.0    2003.07.13 12:12:04 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 2:54:06 PM  czhower
}
unit ezpersonality;

interface
{$ifdef fpc}
  {$mode objfpc}{$H+}
{$endif}

uses
  Classes;

type
  TEZPersonalityAttributes = record
    Name: string;
    Description: string;
  end;

  TEZPersonality = class;
  TEZPersonalityClass = class of TEZPersonality;

  TEZPersonality = class(TCollection)
  protected
    FKeywords: TStrings;
    //
    procedure AddReply(const AKeywords: array of string;
     const AReplies: array of string); overload;
    procedure AddReply(const AKeywords: array of string;
     const AReplies: array of string; const ASounds: array of string); overload;
    procedure InitReplies; virtual; abstract;
  public
    class function Attributes: TEZPersonalityAttributes; virtual; abstract;
    class function ConstructPersonality(const AName: string): TEZPersonality;
    constructor Create; virtual;
    destructor Destroy; override;
    class procedure PersonalityList(AStrings: TStrings);
    class procedure RegisterPersonality;
    //
    property Keywords: TStrings read FKeywords;
  end;

  TEZReply = class(TCollectionItem)
  protected
    FIndex: Integer;
    FSound: string;
    FSounds: TStrings;
    FTexts: TStrings;
  public
    procedure AddText(const AText: string; const ASound: string = '');
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
    function NextText: string;
    //
    property Sound: string read FSound;
  end;

implementation

uses
  SysUtils;

var
  GPersonalities: TStringList;

{ TEZReply }

procedure TEZReply.AddText(const AText: string; const ASound: string = '');
begin
  FTexts.Add(AText);
  FSounds.Add(ASound);
end;

constructor TEZReply.Create(AOwner: TCollection);
begin
  inherited;
  FSounds := TStringList.Create;
  FTexts := TStringList.Create;
end;

destructor TEZReply.Destroy;
begin
  FreeAndNil(FTexts);
  FreeAndNil(FSounds);
  inherited;
end;

function TEZReply.NextText: string;
begin
  Result := FTexts[FIndex];
  FSound := FSounds[FIndex];
  Inc(FIndex);
  if FIndex = FTexts.Count then begin
    FIndex := 0;
  end;
end;

{ TEZPersonality }

procedure TEZPersonality.AddReply(const AKeywords, AReplies: array of string;
 const ASounds: array of string);
var
  i: integer;
  LReply: TEZReply;
begin
  LReply := TEZReply.Create(Self);
  for i := Low(AReplies) to High(AReplies) do begin
    if i <= High(ASounds) then begin
      LReply.AddText(AReplies[i], ASounds[i]);
    end else begin
      LReply.AddText(AReplies[i]);
    end;
  end;
  for i := Low(AKeywords) to High(AKeywords) do begin
    FKeywords.AddObject(Uppercase(AKeywords[i]), LReply);
  end;
end;

procedure TEZPersonality.AddReply(const AKeywords, AReplies: array of string);
begin
  AddReply(AKeywords, AReplies, []);
end;

class function TEZPersonality.ConstructPersonality(
 const AName: string): TEZPersonality;
var
  i: Integer;
begin
  i := GPersonalities.IndexOf(AName);
  if i = -1 then begin
    raise Exception.Create('Personality not found.');
  end;
  Result := TEZPersonalityClass(GPersonalities.Objects[i]).Create;
end;

constructor TEZPersonality.Create;
begin
  inherited Create(TEZReply);
  FKeywords := TStringList.Create;
  InitReplies;
end;

destructor TEZPersonality.Destroy;
begin
  FreeAndNil(FKeywords);
  inherited;
end;

class procedure TEZPersonality.PersonalityList(AStrings: TStrings);
begin
  AStrings.AddStrings(GPersonalities);
end;

class procedure TEZPersonality.RegisterPersonality;
begin
  GPersonalities.AddObject(Self.Attributes.Name, TObject(Self));
end;

initialization
  GPersonalities := TStringList.Create;
  GPersonalities.Sorted := True;
finalization
  FreeAndNil(GPersonalities)
end.
