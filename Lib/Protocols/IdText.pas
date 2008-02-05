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
  Rev 1.5    10/26/2004 10:49:20 PM  JPMugaas
  Updated ref.

  Rev 1.4    16/05/2004 18:56:16  CCostelloe
  New TIdText/TIdAttachment processing

  Rev 1.3    2004.02.03 5:44:34 PM  czhower
  Name changes

  Rev 1.2    10/17/03 12:06:50 PM  RLebeau
  Updated Assign() to copy all available header values rather than select ones.

    Rev 1.1    10/17/2003 1:11:14 AM  DSiders
  Added localization comments.

  Rev 1.0    11/13/2002 08:03:00 AM  JPMugaas

2002-08-30 Andrew P.Rubin
  - extract charset & IsBodyEncodingRequired (true = 8 bit)
}

unit IdText;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdMessageParts;

type
  TIdText = class(TIdMessagePart)
  protected
    FBody: TStrings;
    function  GetContentType: string; override; //Content-Type
    procedure SetBody(const AStrs : TStrings); virtual;
    procedure SetContentType(const AValue: string); override;
    procedure SetCharSet(const AValue: String); virtual;
  public
    constructor Create(Collection: TIdMessageParts; ABody: TStrings = nil); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IsBodyEncodingRequired: Boolean;

    class function PartType: TIdMessagePartType; override;
    //
    property Body: TStrings read FBody write SetBody;
  end;

implementation

uses
  IdGlobal,
  SysUtils;

const
  SContentType = '%s; CHARSET="%s"';  {do not localize}

{ TIdText }

procedure TIdText.Assign(Source: TPersistent);
begin
  if Source is TIdText then begin
    with Source as TIdText do begin
      // RLebeau 10/17/2003
      Self.Headers.Assign(Headers);
      Self.ExtraHeaders.Assign(ExtraHeaders);
      Self.Body.Assign(Body);
    end;
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdText.Create(Collection: TIdMessageParts; ABody: TStrings = nil);
begin
  inherited Create(Collection);
  FBody := TStringList.Create;
  TStringList(FBody).Duplicates := dupAccept;
  if ABody <> nil then begin
    FBody.Assign(ABody);
  end;
end;

destructor TIdText.Destroy;
begin
  FreeAndNil(FBody);
  inherited Destroy;
end;

function TIdText.GetContentType: string;
var
  S: String;
begin
  S := inherited GetContentType;
  Result := Fetch(S, ';');  {do not localize}
end;

function TIdText.IsBodyEncodingRequired: Boolean;
var
  i, j: Integer;
  S: String;
begin
  Result := False;//7bit
  for i := 0 to FBody.Count-1 do begin
    S := FBody[i];
    for j := 1 to Length(S) do begin
      if S[j] > #127 then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

class function TIdText.PartType: TIdMessagePartType;
begin
  Result := mptText;
end;

procedure TIdText.SetBody(const AStrs: TStrings);
begin
  FBody.Assign(AStrs);
end;

procedure TIdText.SetCharSet(const AValue: String);
begin
  inherited SetContentType(IndyFormat(SContentType, [GetContentType, AValue]));
end;

procedure TIdText.SetContentType(const AValue: string);
begin
  inherited SetContentType(IndyFormat(SContentType, [AValue, GetCharSet(Headers.Values['Content-Type'])]));  {do not localize}
end;

initialization
// RegisterClasses([TIdText]);
end.

