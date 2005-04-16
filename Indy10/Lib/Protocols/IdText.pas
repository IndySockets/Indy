{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11785: IdText.pas
{
{   Rev 1.5    10/26/2004 10:49:20 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.4    16/05/2004 18:56:16  CCostelloe
{ New TIdText/TIdAttachment processing
}
{
{   Rev 1.3    2004.02.03 5:44:34 PM  czhower
{ Name changes
}
{
{   Rev 1.2    10/17/03 12:06:50 PM  RLebeau
{ Updated Assign() to copy all available header values rather than select ones.
}
{
    Rev 1.1    10/17/2003 1:11:14 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.0    11/13/2002 08:03:00 AM  JPMugaas
}
{
2002-08-30 Andrew P.Rubin
  - extract charset & IsBodyEncodingRequired (true = 8 bit)
}
unit IdText;

interface
uses
  IdMessageParts, Classes, IdTStrings;

type
  TIdText = class(TIdMessagePart)
  protected
    FBody: TIdStrings;
    function  GetContentType: string; override; //Content-Type
    procedure SetBody(const AStrs : TIdStrings); virtual;
    procedure SetContentType(const AValue: string); override;
    procedure SetCharSet(const AValue: String); virtual;
  public
    constructor Create(Collection: TIdMessageParts; ABody: TIdStrings = nil); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  IsBodyEncodingRequired: Boolean;

    class function PartType: TIdMessagePartType; override;
    //
    property  Body: TIdStrings read FBody write SetBody;
  end;

implementation

uses
  IdGlobal, SysUtils;

const
  SContentType = '%s; CHARSET="%s"';  {do not localize}

{ TIdText }

procedure TIdText.Assign(Source: TPersistent);
var mp : TIdText;
begin
  if ClassType <> Source.ClassType then
  begin
    inherited;
  end
  else begin
    mp := TIdText(Source);

    // RLebeau 10/17/2003
    Headers.Assign(mp.Headers);

    ExtraHeaders.Assign(mp.ExtraHeaders);
    Body.Assign(mp.Body);
  end;
end;

constructor TIdText.Create(Collection: TIdMessageParts; ABody: TIdStrings = nil);
begin
  inherited Create(Collection);
  FBody := TIdStringList.Create;
  if ABody <> nil then begin
    FBody.Assign(ABody);
  end;
end;

destructor TIdText.Destroy;
begin
  FBody.Free;
  inherited;
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
  i,j: Integer;
  S: String;
begin
  Result := FALSE;//7bit
  for i:=0 to FBody.Count-1 do begin
    S := FBody[i];
    for j := 1 to Length(S) do begin
      if S[j] > #127 then begin
        Result := TRUE;
        EXIT;
      end;
    end;
  end;
end;

class function TIdText.PartType: TIdMessagePartType;
begin
  Result := mptText;
end;

procedure TIdText.SetBody(const AStrs: TIdStrings);
begin
  FBody.Assign(AStrs);
end;

procedure TIdText.SetCharSet(const AValue: String);
begin
  inherited SetContentType(Format(SContentType,[GetContentType,AValue]));
end;

procedure TIdText.SetContentType(const AValue: string);
begin
  inherited SetContentType(Format(SContentType, [AValue,GetCharSet(Headers.Values['Content-Type'])]));  {do not localize}
end;

initialization
  RegisterClasses([TIdText]);
end.

