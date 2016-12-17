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
  Classes, IdGlobalProtocols;

type
  TIdHeaderList = class(TStringList)
  protected
    FNameValueSeparator : String;
    FUnfoldLines : Boolean;
    FFoldLines : Boolean;
    FFoldLinesLength : Integer;
    FQuoteType: TIdHeaderQuotingType;
    //
    procedure AssignTo(Dest: TPersistent); override;
    {This deletes lines which were folded}
    Procedure DeleteFoldedLines(Index : Integer);
    {This folds one line into several lines}
    function FoldLine(AString : string): TStrings; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use FoldLineToList()'{$ENDIF};{$ENDIF}
    procedure FoldLineToList(AString : string; ALines: TStrings);
    {Folds lines and inserts them into a position, Index}
    procedure FoldAndInsert(AString : String; Index : Integer);
    {Name property get method}
    function GetName(Index: Integer): string;
    {Value property get method}
    function GetValue(const AName: string): string;
    {Value property get method}
    function GetParam(const AName, AParam: string): string;
    function GetAllParams(const AName: string): string;
    {Value property set method}
    procedure SetValue(const AName, AValue: string);
    {Value property set method}
    procedure SetParam(const AName, AParam, AValue: string);
    procedure SetAllParams(const AName, AValue: string);
    {Gets a value from a string}
    function GetValueFromLine(var VLine : Integer) : String;
    procedure SkipValueAtLine(var VLine : Integer);
  public
    procedure AddStrings(Strings: TStrings); override;
    { This method extracts "name=value" strings from the ASrc TStrings and adds
      them to this list using our delimiter defined in NameValueSeparator. }
    procedure AddStdValues(ASrc: TStrings);
    { This method adds a single name/value pair to this list using our delimiter
      defined in NameValueSeparator. }
    procedure AddValue(const AName, AValue: string); // allows duplicates
    { This method extracts all of the values from this list and puts them in the
      ADest TStrings as "name=value" strings.}
    procedure ConvertToStdValues(ADest: TStrings);
    constructor Create(AQuoteType: TIdHeaderQuotingType);
    { This method, given a name specified by AName, extracts all of the values
      for that name and puts them in a new string list (just the values) one
      per line in the ADest TIdStrings.}
    procedure Extract(const AName: string; ADest: TStrings);
    { This property works almost exactly as Borland's IndexOfName except it
      uses our delimiter defined in NameValueSeparator }
    function IndexOfName(const AName: string): Integer; reintroduce;
    { This property works almost exactly as Borland's Names except it uses
      our delimiter defined in NameValueSeparator }
    property Names[Index: Integer]: string read GetName;
    { This property works almost exactly as Borland's Values except it uses
      our delimiter defined in NameValueSeparator }
    property Values[const Name: string]: string read GetValue write SetValue;
    property Params[const Name, Param: string]: string read GetParam write SetParam;
    property AllParams[const Name: string]: string read GetAllParams write SetAllParams;
    { This is the separator we need to separate the name from the value }
    property NameValueSeparator : String read FNameValueSeparator
      write FNameValueSeparator;
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
  IdException,
  IdGlobal,
  SysUtils;

{ TIdHeaderList }

procedure TIdHeaderList.AddStdValues(ASrc: TStrings);
var
  i: integer;
begin
  BeginUpdate;
  try
    for i := 0 to ASrc.Count - 1 do begin
      AddValue(ASrc.Names[i], IndyValueFromIndex(ASrc, i));
    end;
  finally
    EndUpdate;
  end;
end;

procedure TIdHeaderList.AddValue(const AName, AValue: string);
var
  I: Integer;
begin
  if (AName <> '') and (AValue <> '') then begin  {Do not Localize}
    I := Add('');    {Do not Localize}
    if FFoldLines then begin
      FoldAndInsert(AName + FNameValueSeparator + AValue, I);
    end else begin
      Put(I, AName + FNameValueSeparator + AValue);
    end;
  end;
end;

procedure TIdHeaderList.AddStrings(Strings: TStrings);
begin
  if Strings is TIdHeaderList then begin
    inherited AddStrings(Strings);
  end else begin
    AddStdValues(Strings);
  end;
end;

procedure TIdHeaderList.AssignTo(Dest: TPersistent);
begin
  if (Dest is TStrings) and not (Dest is TIdHeaderList) then begin
    ConvertToStdValues(TStrings(Dest));
  end else begin
    inherited AssignTo(Dest);
  end;
end;

procedure TIdHeaderList.ConvertToStdValues(ADest: TStrings);
var
  idx: Integer;
  LName, LValue: string;
begin
  ADest.BeginUpdate;
  try
    idx := 0;
    while idx < Count do
    begin
      LName := GetName(idx);
      LValue := GetValueFromLine(idx);
      IndyAddPair(ADest, LName, LValue);
    end;
  finally
    ADest.EndUpdate;
  end;
end;

constructor TIdHeaderList.Create(AQuoteType: TIdHeaderQuotingType);
begin
  inherited Create;
  FNameValueSeparator := ': ';    {Do not Localize}
  FUnfoldLines := True;
  FFoldLines := True;
  { 78 was specified by a message draft available at
    http://www.imc.org/draft-ietf-drums-msg-fmt }
  // HTTP does not technically have a limitation on line lengths
  FFoldLinesLength := iif(AQuoteType = QuoteHTTP, MaxInt, 78);
  FQuoteType := AQuoteType;
end;

procedure TIdHeaderList.DeleteFoldedLines(Index: Integer);
begin
  Inc(Index);  {skip the current line}
  if Index < Count then begin
    while (Index < Count) and CharIsInSet(Get(Index), 1, LWS) do begin {Do not Localize}
      Delete(Index);
    end;
  end;
end;

procedure TIdHeaderList.Extract(const AName: string; ADest: TStrings);
var
  idx : Integer;
begin
  if Assigned(ADest) then begin
    ADest.BeginUpdate;
    try
      idx := 0;
      while idx < Count do
      begin
        if TextIsSame(AName, GetName(idx)) then begin
          ADest.Add(GetValueFromLine(idx));
        end else begin
          SkipValueAtLine(idx);
        end;
      end;
    finally
      ADest.EndUpdate;
    end;
  end;
end;

procedure TIdHeaderList.FoldAndInsert(AString : String; Index: Integer);
var
  LStrs : TStrings;
  idx : Integer;
begin
  LStrs := TStringList.Create;
  try
    FoldLineToList(AString, LStrs);
    idx := LStrs.Count - 1;
    Put(Index, LStrs[idx]);
    {We decrement by one because we put the last string into the HeaderList}
    Dec(idx);
    while idx > -1 do
    begin
      Insert(Index, LStrs[idx]);
      Dec(idx);
    end;
  finally
    FreeAndNil(LStrs);
  end;  //finally
end;

{$I IdDeprecatedImplBugOff.inc}
function TIdHeaderList.FoldLine(AString : string): TStrings;
{$I IdDeprecatedImplBugOn.inc}
begin
  Result := TStringList.Create;
  try
    FoldLineToList(AString, Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdHeaderList.FoldLineToList(AString : string; ALines: TStrings);
var
  s : String;
begin
  {we specify a space so that starts a folded line}
  s := IndyWrapText(AString, EOL+' ', LWS+',', FFoldLinesLength);    {Do not Localize}
  if s <> '' then begin
    ALines.BeginUpdate;
    try
      repeat
        ALines.Add(TrimRight(Fetch(s, EOL)));
      until s = '';  {Do not Localize};
    finally
      ALines.EndUpdate;
    end;
  end;
end;

function TIdHeaderList.GetName(Index: Integer): string;
var
  I : Integer;
begin
  Result := Get(Index);

  {We trim right to remove space to accomodate header errors such as

  Message-ID:<asdf@fdfs
  }
  I := IndyPos(TrimRight(FNameValueSeparator), Result);

  if I <> 0 then begin
    SetLength(Result, I - 1);
  end else begin
    SetLength(Result, 0);
  end;
end;

function TIdHeaderList.GetValue(const AName: string): string;
var
  idx: Integer;
begin
  idx := IndexOfName(AName);
  Result := GetValueFromLine(idx);
end;

function TIdHeaderList.GetValueFromLine(var VLine: Integer): String;
var
  LLine, LSep: string;
  P: Integer;
begin
  if (VLine >= 0) and (VLine < Count) then begin
    LLine := Get(VLine);
    Inc(VLine);
    
    {We trim right to remove space to accomodate header errors such as

    Message-ID:<asdf@fdfs
    }
    LSep := TrimRight(FNameValueSeparator);
    P := IndyPos(LSep, LLine);

    Result := TrimLeft(Copy(LLine, P + Length(LSep), MaxInt));
    if FUnfoldLines then begin
      while VLine < Count do begin
        LLine := Get(VLine);
        // s[1] is safe since header lines cannot be empty as that causes then end of the header block
        if not CharIsInSet(LLine, 1, LWS) then begin
          Break;
        end;
        Result := Trim(Result) + ' ' + Trim(LLine); {Do not Localize}
        Inc(VLine);
      end;
    end;
    // User may be fetching a folded line directly.
    Result := Trim(Result);
  end else begin
    Result := ''; {Do not Localize}
  end;
end;

procedure TIdHeaderList.SkipValueAtLine(var VLine: Integer);
begin
  if (VLine >= 0) and (VLine < Count) then begin
    Inc(VLine);
    if FUnfoldLines then begin
      while VLine < Count do begin
        // s[1] is safe since header lines cannot be empty as that causes then end of the header block
        if not CharIsInSet(Get(VLine), 1, LWS) then begin
          Break;
        end;
        Inc(VLine);
      end;
    end;
  end;
end;

function TIdHeaderList.GetParam(const AName, AParam: string): string;
var
  s: string;
  LQuoteType: TIdHeaderQuotingType;
begin
  s := Values[AName];
  if s <> '' then begin
    LQuoteType := FQuoteType;
    case LQuoteType of
      QuoteRFC822: begin
        if PosInStrArray(AName, ['Content-Type', 'Content-Disposition'], False) <> -1 then begin {Do not Localize}
          LQuoteType := QuoteMIME;
        end;
      end;
      QuoteMIME: begin
        if PosInStrArray(AName, ['Content-Type', 'Content-Disposition'], False) = -1 then begin {Do not Localize}
          LQuoteType := QuoteRFC822;
        end;
      end;
    end;
    Result := ExtractHeaderSubItem(s, AParam, LQuoteType);
  end else begin
    Result := '';
  end;
end;

function TIdHeaderList.GetAllParams(const AName: string): string;
var
  s: string;
begin
  s := Values[AName];
  if s <> '' then begin
    Fetch(s, ';'); {do not localize}
    Result := Trim(s);
  end else begin
    Result := '';
  end;
end;

function TIdHeaderList.IndexOfName(const AName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do begin
    if TextIsSame(GetName(i), AName) then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TIdHeaderList.SetValue(const AName, AValue: string);
var
  I: Integer;
begin
  I := IndexOfName(AName);
  if AValue <> '' then begin  {Do not Localize}
    if I < 0 then begin
      I := Add('');    {Do not Localize}
    end;
    if FFoldLines then begin
      DeleteFoldedLines(I);
      FoldAndInsert(AName + FNameValueSeparator + AValue, I);
    end else begin
      Put(I, AName + FNameValueSeparator + AValue);
    end;
  end
  else if I >= 0 then begin
    if FFoldLines then begin
      DeleteFoldedLines(I);
    end;
    Delete(I);
  end;
end;

procedure TIdHeaderList.SetParam(const AName, AParam, AValue: string);
var
  LQuoteType: TIdHeaderQuotingType;
begin
  LQuoteType := FQuoteType;
  case LQuoteType of
    QuoteRFC822: begin
      if PosInStrArray(AName, ['Content-Type', 'Content-Disposition'], False) <> -1 then begin {Do not Localize}
        LQuoteType := QuoteMIME;
      end;
    end;
    QuoteMIME: begin
      if PosInStrArray(AName, ['Content-Type', 'Content-Disposition'], False) = -1 then begin {Do not Localize}
        LQuoteType := QuoteRFC822;
      end;
    end;
  end;
  Values[AName] := ReplaceHeaderSubItem(Values[AName], AParam, AValue, LQuoteType);
end;

procedure TIdHeaderList.SetAllParams(const AName, AValue: string);
var
  LValue: string;
begin
  LValue := Values[AName];
  if LValue <> '' then
  begin
    LValue := ExtractHeaderItem(LValue);
    if AValue <> '' then begin
      LValue := LValue + '; ' + AValue; {do not localize}
    end;
    Values[AName] := LValue;
  end;
end;

end.
