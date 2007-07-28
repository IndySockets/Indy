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
  Rev 1.9    10/26/2004 10:10:58 PM  JPMugaas
  Updated refs.

  Rev 1.8    3/6/2004 2:53:30 PM  JPMugaas
  Cleaned up an if as per Bug #79.

  Rev 1.7    2004.02.03 5:43:42 PM  czhower
  Name changes

  Rev 1.6    2004.01.27 1:39:26 AM  czhower
  CharIsInSet bug fix

  Rev 1.5    1/22/2004 3:50:04 PM  SPerry
  fixed set problems (with CharIsInSet)

  Rev 1.4    1/22/2004 7:10:06 AM  JPMugaas
  Tried to fix AnsiSameText depreciation.

  Rev 1.3    10/5/2003 11:43:50 PM  GGrieve
  Use IsLeadChar

  Rev 1.2    10/4/2003 9:15:14 PM  GGrieve
  DotNet changes

  Rev 1.1    2/25/2003 12:56:20 PM  JPMugaas
  Updated with Hadi's fix for a bug .  If complete boolean expression i on, you
  may get an Index out of range error.

  Rev 1.0    11/13/2002 07:53:52 AM  JPMugaas

 2002-Jan-27 Don Siders
  - Modified FoldLine to include Comma in break character set.

 2000-May-31 J. Peter Mugaas
  - started this class to facilitate some work on Indy so we don't have to
    convert '=' to ":" and vice-versa just to use the Values property.
  }

unit IdHeaderList;

{
 NOTE:  This is a modification of Borland's TStrings definition in a
        TStringList descendant.  I had to conceal the original Values to do
        this since most of low level property setting routines aren't virtual   
        and are private.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes;

type
  TIdHeaderList = class(TStringList)
  protected
    FNameValueSeparator : String;
    FCaseSensitive : Boolean;
    FUnfoldLines : Boolean;
    FFoldLines : Boolean;
    FFoldLinesLength : Integer;
    //
    {This deletes lines which were folded}
    Procedure DeleteFoldedLines(Index : Integer);
    {This folds one line into several lines}
    function FoldLine(AString : string) : TStrings;
    {Folds lines and inserts them into a position, Index}
    procedure FoldAndInsert(AString : String; Index : Integer);
    {Name property get method}
    function GetName(Index: Integer): string;
    {Value property get method}
    function GetValue(const AName: string): string;
    {Value property set method}
    procedure SetValue(const Name, Value: string);
    {Gets a value from a string}
    function GetValueFromLine(ALine : Integer) : String;
    Function GetNameFromLine(ALine : Integer) : String;
  public
    procedure AddStdValues(ASrc: TStrings);
    procedure ConvertToStdValues(ADest: TStrings);
    constructor Create;
    { This method  given a name specified by AName extracts all of the values for that name - and puts them in a new string
    list (just the values) one per line in the ADest TIdStrings.}
    procedure Extract(const AName: string; ADest: TStrings);
    { This property works almost exactly as Borland's IndexOfName except it uses
      our deliniator defined in NameValueSeparator }
    function IndexOfName(const AName: string): Integer; reintroduce;
    { This property works almost exactly as Borland's Values except it uses
      our deliniator defined in NameValueSeparator }
    property Names[Index: Integer]: string read GetName;
    { This property works almost exactly as Borland's Values except it uses   
      our deliniator defined in NameValueSeparator }
    property Values[const Name: string]: string read GetValue write SetValue;
    { This is the separator we need to separate the name from the value }
    property NameValueSeparator : String read FNameValueSeparator
      write FNameValueSeparator;
    { Should the names be tested in a case-senstive manner. }
    property CaseSensitive : Boolean read FCaseSensitive write FCaseSensitive;
    { Should we unfold lines so that continuation header data is returned as
    well}
    property UnfoldLines : Boolean read FUnfoldLines write FUnfoldLines;
    { Should we fold lines we the Values(x) property is set with an
    assignment }
    property FoldLines : Boolean read FFoldLines write FFoldLines;
    { The Wrap position for our folded lines }
    property FoldLength : Integer read FFoldLinesLength write FFoldLinesLength;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols, SysUtils;

{ TIdHeaderList }

procedure TIdHeaderList.AddStdValues(ASrc: TStrings);
var
  i: integer;
begin
  for i := 0 to ASrc.Count - 1 do begin
    Add(ReplaceOnlyFirst(ASrc[i], '=', NameValueSeparator));    {Do not Localize}
  end;
end;

procedure TIdHeaderList.ConvertToStdValues(ADest: TStrings);
var
  i: LongInt;
begin
  for i := 0 to Count - 1 do begin
    ADest.Add(ReplaceOnlyFirst(Strings[i], NameValueSeparator, '='));    {Do not Localize}
  end;
end;

constructor TIdHeaderList.Create;
begin
  inherited Create;
  FNameValueSeparator := ': ';    {Do not Localize}
  FCaseSensitive := False;
  FUnfoldLines := True;
  FFoldLines := True;
  { 78 was specified by a message draft available at
    http://www.imc.org/draft-ietf-drums-msg-fmt }
  FFoldLinesLength := 78;
end;

procedure TIdHeaderList.DeleteFoldedLines(Index: Integer);
begin
  Inc(Index);  {skip the current line}
  if Index < Count then begin
    while (Index < Count) and CharIsInSet(Get(Index), 1, ' '+#9) do begin {Do not Localize}
      Delete(Index);
    end;
  end;
end;

procedure TIdHeaderList.Extract(const AName: string; ADest: TStrings);
var
  idx : LongInt;
begin
  if Assigned(ADest) then begin
    for idx := 0 to Count - 1 do
    begin
      if TextIsSame(AName, GetNameFromLine(idx)) then begin
        ADest.Add(GetValueFromLine(idx));
      end;
    end;
  end;
end;

procedure TIdHeaderList.FoldAndInsert(AString : String; Index: Integer);
var
  LStrs : TStrings;
  idx : LongInt;
begin
  LStrs := FoldLine(AString);
  try
    idx := LStrs.Count - 1;
    Put(Index, LStrs[idx]);
    {We decrement by one because we put the last string into the HeaderList}
    Dec(idx);
    while (idx > -1) do
    begin
      Insert(Index, LStrs[idx]);
      Dec(idx);
    end;
  finally
    FreeAndNil(LStrs);
  end;  //finally
end;

function TIdHeaderList.FoldLine(AString : string): TStrings;
var
  s : String;
begin
  Result := TStringList.Create;
  try
    {we specify a space so that starts a folded line}
    s := IdGlobalProtocols.WrapText(AString, EOL+' ', LWS+',', FFoldLinesLength);    {Do not Localize}
    while s <> '' do begin  {Do not Localize}
      Result.Add(TrimRight(Fetch(s, EOL)));
    end; // while s <> '' do    {Do not Localize}
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdHeaderList.GetName(Index: Integer): string;
var
  P: Integer;
begin
  Result := Get(Index);
  P := IndyPos(FNameValueSeparator, Result);
  if P <> 0 then begin
    SetLength(Result, P - 1);
  end else begin
    SetLength(Result, 0);
  end;
end;

function TIdHeaderList.GetNameFromLine(ALine: Integer): String;
var
  p : Integer;
begin
  Result := Get(ALine);
  if not FCaseSensitive then begin
    Result := UpperCase(Result);
  end;
  {We trim right to remove space to accomodate header errors such as

  Message-ID:<asdf@fdfs
  }
  P := IndyPos(TrimRight(FNameValueSeparator), Result);
  Result := Copy(Result, 1, P - 1);
end;

function TIdHeaderList.GetValue(const AName: string): string;
begin
  Result := GetValueFromLine(IndexOfName(AName));
end;

function TIdHeaderList.GetValueFromLine(ALine: Integer): String;
var
  LFoldedLine: string;
  LName: string;
begin
  if (ALine >= 0) and (ALine < Count) then begin
    LName := GetNameFromLine(ALine);
    Result := Copy(Get(ALine), Length(LName) + 2, MaxInt);
    if FUnfoldLines then begin
      while True do begin
        Inc(ALine);
        if ALine = Count then begin
          Break;
        end;
        LFoldedLine := Get(ALine);
        // s[1] is safe since header lines cannot be empty as that causes then end of the header block
        if not (CharIsInSet(LFoldedLine, 1, LWS)) then begin
          Break;
        end;
        Result := Trim(Result) + ' ' + Trim(LFoldedLine); {Do not Localize}
      end;
    end;
  end else begin
    Result := ''; {Do not Localize}
  end;
  // User may be fetching an folded line diretly.
  Result := Trim(Result);
end;

function TIdHeaderList.IndexOfName(const AName: string): Integer;
var
  i: LongInt;
begin
  Result := -1;
  for i := 0 to Count - 1 do begin
    if TextIsSame(GetNameFromLine(i), AName) then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TIdHeaderList.SetValue(const Name, Value: string);
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if Value <> '' then begin  {Do not Localize}
    if I < 0 then begin
      I := Add('');    {Do not Localize}
    end;
    if FFoldLines then begin
      DeleteFoldedLines(I);
      FoldAndInsert(Name + FNameValueSeparator + Value, I);
    end else begin
      Put(I, Name + FNameValueSeparator + Value);
    end;
  end
  else if I >= 0 then begin
    if FFoldLines then begin
      DeleteFoldedLines(I);
    end;
    Delete(I);
  end;
end;

end.
